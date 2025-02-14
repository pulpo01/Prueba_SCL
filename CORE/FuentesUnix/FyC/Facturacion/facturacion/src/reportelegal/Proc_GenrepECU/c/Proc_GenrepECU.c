
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/Proc_GenrepECU.pc"
};


static unsigned int sqlctx = 221876627;


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
   unsigned char  *sqhstv[26];
   unsigned long  sqhstl[26];
            int   sqhsts[26];
            short *sqindv[26];
            int   sqinds[26];
   unsigned long  sqharm[26];
   unsigned long  *sqharc[26];
   unsigned short  sqadto[26];
   unsigned short  sqtdso[26];
} sqlstm = {12,26};

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
"select B.NUM_IDENT ,(TO_CHAR(TO_DATE(:b0,'DDMMYYYY'),'MM')||TO_CHAR(TO_DATE(\
:b0,'DDMMYYYY'),'YY')) ,A.COD_TIPIDENT ,A.NUM_IDENTIFICACION ,A.TIPO_DOCUMENTO\
 ,:b2 ,:b2 ,' ' ,' ' ,' ' ,'00' ,A.TOT_MONTOGRAV ,'2' ,A.TOT_MONTOEXE ,A.TOT_M\
ONTOIVA ,A.TOT_MONTOICE ,'0.0' ,'0' ,'0.0' ,'0.0' ,'0' ,'0.0' ,'N' ,A.CANT_DOC\
VTAEMI ,A.CANT_NCEMI ,A.CANT_NDEMI  from FA_RESUMEN_MONTOSIMP_TO A ,(select B.\
NUM_IDENT  from GE_CLIENTES B ,GE_DATOSGENER A where B.COD_CLIENTE=A.COD_CLIEN\
TESTARTEL) B where A.CERRADO='N' order by A.NUM_IDENTIFICACION            ";

 static char *sq0004 = 
"select TO_CHAR(TO_DATE(:b0,'DDMMYYYY'),'YYYY') ,TO_CHAR(TO_DATE(:b0,'DDMMYYY\
Y'),'MM') ,B.NUM_IDENT ,'C' ,A.COD_TIPIDENT ,A.NUM_IDENTIFICACION ,((((A.NOM_C\
LIENTE||' ')||A.NOM_APECLIEN1)||' ')||A.NOM_APECLIEN2) ,A.COD_PROVINCIA ,A.TOT\
_MONTOGRAV ,A.TOT_MONTOEXE ,A.TOT_MONTOIVA ,A.TOT_MONTOICE  from FA_RESUMEN_MO\
NTOSIMP_TO A ,(select B.NUM_IDENT ,B.COD_TIPIDENT ,B.NOM_CLIENTE  from GE_CLIE\
NTES B ,GE_DATOSGENER A where B.COD_CLIENTE=A.COD_CLIENTESTARTEL) B where A.CE\
RRADO='N' order by A.NUM_IDENTIFICACION            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,81,0,4,85,0,0,2,1,0,1,0,1,97,0,0,2,97,0,0,
28,0,0,2,540,0,9,139,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
59,0,0,2,0,0,13,152,0,0,26,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,3,0,0,2,4,0,
0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,4,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,
178,0,0,2,0,0,15,193,0,0,0,0,0,1,0,
193,0,0,3,81,0,4,379,0,0,2,1,0,1,0,1,97,0,0,2,97,0,0,
216,0,0,4,517,0,9,419,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
239,0,0,4,0,0,13,432,0,0,12,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
302,0,0,4,0,0,15,460,0,0,0,0,0,1,0,
317,0,0,5,218,0,3,747,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
348,0,0,6,218,0,3,820,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
379,0,0,7,65,0,5,835,0,0,0,0,0,1,0,
};


/* ********************************************************************** */
/* *  Fichero : Proc_GenrepECU.pc                                       * */
/* *  Proceso generador de reportes legales de Ecuador			* */
/* *  Autor : Patricio Gonzalez Gomez	                                * */
/* *  Modif : 								* */
/* *  Parametros : 							* */
/* *         -u Usuario/Password                                        * */
/* *         -m Mes al cual se le desea generar reporte 		* */
/* *         -a Año al cual se le desea generar reporte 		* */
/* *         -l Nivel de Log						* */
/* ********************************************************************** */

#define _PROC_GENREPECU_PC_

#include <deftypes.h>
#include <stdlib.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "Proc_GenrepECU.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

char  modulo[30];

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhFecInicio  	[9]	;
	char	szhFecFin  	[9]	;
	long	lhCantClientesIva	;
	long	lhCantDoctosIva         ;
	long	lhCantClientesIce       ;
	long	lhCantDoctosIce         ;
/* EXEC SQL END DECLARE SECTION ; */ 


double	dfnObtieneParteDecimal(double dValor)
{
	double	dMultiplicador;
  	double	dValorEntero;
  	double	dValorDecimal;
  	double 	dValorFinal;
  	long	lValor;
  	long	lResultado;



	dMultiplicador = 100.00;
	lValor = dValor;
  	dValorEntero = lValor;

  	dValorDecimal = dValor - dValorEntero;

  	dValorFinal = dValorDecimal * dMultiplicador;

  	if (dValorFinal < 0)
  		dValorFinal = dValorFinal * -1;

	return dValorFinal;
}


/* DESDE AQUI PGG FUNCIONES NUEVAS */
void trim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}


/* --------Estructura IVA Desde Aqui */
static int ifnOpenIVA (void)
{

    	strcpy(modulo,"ifnOpenIVA");

	sprintf(szhFecInicio  	, "01%2.2ld%4.4ld", stLineaComando.lMes, stLineaComando.lAno);

	/* EXEC SQL
		SELECT TO_CHAR(LAST_DAY(TO_DATE(:szhFecInicio,'DDMMYYYY')), 'DDMMYYYY')
		INTO :szhFecFin
	        FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(LAST_DAY(TO_DATE(:b0,'DDMMYYYY')),'DDMMYYYY')\
 into :b1  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
 sqlstm.sqhstl[1] = (unsigned long )9;
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



 	if(SQLCODE!=SQLOK)
	{
		vDTrazasLog(modulo, "Error En SELECT de obtencion del ultimo dia del mes. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
		return (FALSE);
	}

        /* EXEC SQL DECLARE Cursor_Iva CURSOR FOR
		SELECT
			B.NUM_IDENT,
			TO_CHAR(TO_DATE(:szhFecInicio,'DDMMYYYY'), 'MM') || TO_CHAR(TO_DATE(:szhFecInicio,'DDMMYYYY'), 'YY'),
			A.COD_TIPIDENT,
			A.NUM_IDENTIFICACION,
			A.TIPO_DOCUMENTO,
			:szhFecFin,
			:szhFecFin,
			' ',
			' ',
			' ',
			'00',
			A.TOT_MONTOGRAV,
			'2',
			A.TOT_MONTOEXE,
			A.TOT_MONTOIVA,
			A.TOT_MONTOICE,
			'0.0',
			'0',
			'0.0',
			'0.0',
			'0',
			'0.0',
			'N',
			A.CANT_DOCVTAEMI,
			A.CANT_NCEMI,
			A.CANT_NDEMI
		FROM   	FA_RESUMEN_MONTOSIMP_TO A,
				(SELECT B.NUM_IDENT
						FROM GE_CLIENTES B, GE_DATOSGENER A
						WHERE B.COD_CLIENTE = A.COD_CLIENTESTARTEL) B
		WHERE A.CERRADO = 'N'
		ORDER BY A.NUM_IDENTIFICACION; */ 



    	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* DECLARE=> Cursor_Iva",   LOG05);
                return(SQLCODE);
    	}

        /* EXEC SQL OPEN Cursor_Iva; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )28;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
        sqlstm.sqhstl[0] = (unsigned long )9;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecInicio;
        sqlstm.sqhstl[1] = (unsigned long )9;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecFin;
        sqlstm.sqhstl[2] = (unsigned long )9;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecFin;
        sqlstm.sqhstl[3] = (unsigned long )9;
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



    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* OPEN=> Cursor_Iva",   LOG05);
                return(SQLCODE);
    	}

    	return (SQLCODE);
}/***************************** Final ifnOpenIVA  **********************/

static BOOL ifnFetchIVA (REG_ARCH_IVA_HOST *pstHost,long *plNumFilas)
{
         /* EXEC SQL FETCH Cursor_Iva
             INTO	 :pstHost->szRuc
			,:pstHost->szCod_Periodo
			,:pstHost->szCod_Secuencial
			,:pstHost->szNro_Docto
			,:pstHost->szCod_Tip_Comprobante
			,:pstHost->szFec_Emision
			,:pstHost->szFec_Registro_Contable
			,:pstHost->szNro_Serie_Comprobante
			,:pstHost->szNro_Secuen_Comprobante
			,:pstHost->szNro_Autoriz_Comprob
			,:pstHost->szIdentif_Credito_Tributario
			,:pstHost->dBase_Imponible_Gravada
			,:pstHost->lCod_Porcent_Iva
			,:pstHost->dBase_Imponible_Tarif_0
			,:pstHost->dMonto_Iva
			,:pstHost->dMonto_Ice
			,:pstHost->dMonto_Iva1
			,:pstHost->lCod_Porcent_Retencion_Iva1
			,:pstHost->dMonto_Retencion_Iva1
			,:pstHost->dMonto_Iva2
			,:pstHost->lCod_Porcent_Retencion_Iva2
			,:pstHost->dMonto_Retencion_Iva2
			,:pstHost->szTransac_Con_Derecho_Devolucion
			,:pstHost->szCant_Coprobantes_Vta_Emitidos_Mes
			,:pstHost->szCant_Notascredito_Emitidas_Mes
			,:pstHost->szCant_Notasdebito_Emitidas_Mes	; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 26;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )2000;
         sqlstm.offset = (unsigned int  )59;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szRuc);
         sqlstm.sqhstl[0] = (unsigned long )14;
         sqlstm.sqhsts[0] = (         int  )14;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szCod_Periodo);
         sqlstm.sqhstl[1] = (unsigned long )5;
         sqlstm.sqhsts[1] = (         int  )5;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szCod_Secuencial);
         sqlstm.sqhstl[2] = (unsigned long )3;
         sqlstm.sqhsts[2] = (         int  )3;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szNro_Docto);
         sqlstm.sqhstl[3] = (unsigned long )14;
         sqlstm.sqhsts[3] = (         int  )14;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqharc[3] = (unsigned long  *)0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szCod_Tip_Comprobante);
         sqlstm.sqhstl[4] = (unsigned long )3;
         sqlstm.sqhsts[4] = (         int  )3;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqharc[4] = (unsigned long  *)0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szFec_Emision);
         sqlstm.sqhstl[5] = (unsigned long )9;
         sqlstm.sqhsts[5] = (         int  )9;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqharc[5] = (unsigned long  *)0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szFec_Registro_Contable);
         sqlstm.sqhstl[6] = (unsigned long )9;
         sqlstm.sqhsts[6] = (         int  )9;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqharc[6] = (unsigned long  *)0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szNro_Serie_Comprobante);
         sqlstm.sqhstl[7] = (unsigned long )7;
         sqlstm.sqhsts[7] = (         int  )7;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqharc[7] = (unsigned long  *)0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->szNro_Secuen_Comprobante);
         sqlstm.sqhstl[8] = (unsigned long )8;
         sqlstm.sqhsts[8] = (         int  )8;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqharc[8] = (unsigned long  *)0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->szNro_Autoriz_Comprob);
         sqlstm.sqhstl[9] = (unsigned long )11;
         sqlstm.sqhsts[9] = (         int  )11;
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqharc[9] = (unsigned long  *)0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->szIdentif_Credito_Tributario);
         sqlstm.sqhstl[10] = (unsigned long )3;
         sqlstm.sqhsts[10] = (         int  )3;
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqharc[10] = (unsigned long  *)0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->dBase_Imponible_Gravada);
         sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[11] = (         int  )sizeof(double);
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqharc[11] = (unsigned long  *)0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->lCod_Porcent_Iva);
         sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[12] = (         int  )sizeof(long);
         sqlstm.sqindv[12] = (         short *)0;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqharc[12] = (unsigned long  *)0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->dBase_Imponible_Tarif_0);
         sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[13] = (         int  )sizeof(double);
         sqlstm.sqindv[13] = (         short *)0;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqharc[13] = (unsigned long  *)0;
         sqlstm.sqadto[13] = (unsigned short )0;
         sqlstm.sqtdso[13] = (unsigned short )0;
         sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->dMonto_Iva);
         sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[14] = (         int  )sizeof(double);
         sqlstm.sqindv[14] = (         short *)0;
         sqlstm.sqinds[14] = (         int  )0;
         sqlstm.sqharm[14] = (unsigned long )0;
         sqlstm.sqharc[14] = (unsigned long  *)0;
         sqlstm.sqadto[14] = (unsigned short )0;
         sqlstm.sqtdso[14] = (unsigned short )0;
         sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->dMonto_Ice);
         sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[15] = (         int  )sizeof(double);
         sqlstm.sqindv[15] = (         short *)0;
         sqlstm.sqinds[15] = (         int  )0;
         sqlstm.sqharm[15] = (unsigned long )0;
         sqlstm.sqharc[15] = (unsigned long  *)0;
         sqlstm.sqadto[15] = (unsigned short )0;
         sqlstm.sqtdso[15] = (unsigned short )0;
         sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->dMonto_Iva1);
         sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[16] = (         int  )sizeof(double);
         sqlstm.sqindv[16] = (         short *)0;
         sqlstm.sqinds[16] = (         int  )0;
         sqlstm.sqharm[16] = (unsigned long )0;
         sqlstm.sqharc[16] = (unsigned long  *)0;
         sqlstm.sqadto[16] = (unsigned short )0;
         sqlstm.sqtdso[16] = (unsigned short )0;
         sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->lCod_Porcent_Retencion_Iva1);
         sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[17] = (         int  )sizeof(long);
         sqlstm.sqindv[17] = (         short *)0;
         sqlstm.sqinds[17] = (         int  )0;
         sqlstm.sqharm[17] = (unsigned long )0;
         sqlstm.sqharc[17] = (unsigned long  *)0;
         sqlstm.sqadto[17] = (unsigned short )0;
         sqlstm.sqtdso[17] = (unsigned short )0;
         sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->dMonto_Retencion_Iva1);
         sqlstm.sqhstl[18] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[18] = (         int  )sizeof(double);
         sqlstm.sqindv[18] = (         short *)0;
         sqlstm.sqinds[18] = (         int  )0;
         sqlstm.sqharm[18] = (unsigned long )0;
         sqlstm.sqharc[18] = (unsigned long  *)0;
         sqlstm.sqadto[18] = (unsigned short )0;
         sqlstm.sqtdso[18] = (unsigned short )0;
         sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->dMonto_Iva2);
         sqlstm.sqhstl[19] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[19] = (         int  )sizeof(double);
         sqlstm.sqindv[19] = (         short *)0;
         sqlstm.sqinds[19] = (         int  )0;
         sqlstm.sqharm[19] = (unsigned long )0;
         sqlstm.sqharc[19] = (unsigned long  *)0;
         sqlstm.sqadto[19] = (unsigned short )0;
         sqlstm.sqtdso[19] = (unsigned short )0;
         sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->lCod_Porcent_Retencion_Iva2);
         sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[20] = (         int  )sizeof(long);
         sqlstm.sqindv[20] = (         short *)0;
         sqlstm.sqinds[20] = (         int  )0;
         sqlstm.sqharm[20] = (unsigned long )0;
         sqlstm.sqharc[20] = (unsigned long  *)0;
         sqlstm.sqadto[20] = (unsigned short )0;
         sqlstm.sqtdso[20] = (unsigned short )0;
         sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->dMonto_Retencion_Iva2);
         sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[21] = (         int  )sizeof(double);
         sqlstm.sqindv[21] = (         short *)0;
         sqlstm.sqinds[21] = (         int  )0;
         sqlstm.sqharm[21] = (unsigned long )0;
         sqlstm.sqharc[21] = (unsigned long  *)0;
         sqlstm.sqadto[21] = (unsigned short )0;
         sqlstm.sqtdso[21] = (unsigned short )0;
         sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->szTransac_Con_Derecho_Devolucion);
         sqlstm.sqhstl[22] = (unsigned long )2;
         sqlstm.sqhsts[22] = (         int  )2;
         sqlstm.sqindv[22] = (         short *)0;
         sqlstm.sqinds[22] = (         int  )0;
         sqlstm.sqharm[22] = (unsigned long )0;
         sqlstm.sqharc[22] = (unsigned long  *)0;
         sqlstm.sqadto[22] = (unsigned short )0;
         sqlstm.sqtdso[22] = (unsigned short )0;
         sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->szCant_Coprobantes_Vta_Emitidos_Mes);
         sqlstm.sqhstl[23] = (unsigned long )13;
         sqlstm.sqhsts[23] = (         int  )13;
         sqlstm.sqindv[23] = (         short *)0;
         sqlstm.sqinds[23] = (         int  )0;
         sqlstm.sqharm[23] = (unsigned long )0;
         sqlstm.sqharc[23] = (unsigned long  *)0;
         sqlstm.sqadto[23] = (unsigned short )0;
         sqlstm.sqtdso[23] = (unsigned short )0;
         sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->szCant_Notascredito_Emitidas_Mes);
         sqlstm.sqhstl[24] = (unsigned long )13;
         sqlstm.sqhsts[24] = (         int  )13;
         sqlstm.sqindv[24] = (         short *)0;
         sqlstm.sqinds[24] = (         int  )0;
         sqlstm.sqharm[24] = (unsigned long )0;
         sqlstm.sqharc[24] = (unsigned long  *)0;
         sqlstm.sqadto[24] = (unsigned short )0;
         sqlstm.sqtdso[24] = (unsigned short )0;
         sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->szCant_Notasdebito_Emitidas_Mes);
         sqlstm.sqhstl[25] = (unsigned long )13;
         sqlstm.sqhsts[25] = (         int  )13;
         sqlstm.sqindv[25] = (         short *)0;
         sqlstm.sqinds[25] = (         int  )0;
         sqlstm.sqharm[25] = (unsigned long )0;
         sqlstm.sqharc[25] = (unsigned long  *)0;
         sqlstm.sqadto[25] = (unsigned short )0;
         sqlstm.sqtdso[25] = (unsigned short )0;
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




	vDTrazasLog(modulo, "\n\t\t* SQLCODE EN FETCH	[%ld]\n",   LOG05, sqlca.sqlcode);
        if (SQLCODE==SQLOK)
                *plNumFilas = TAM_HOSTS_PEQ;
        else
                if (SQLCODE==SQLNOTFOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

  return (SQLCODE);
}/***************************** Final ifnFetchIVA ****************/

int ifnCloseIVA (void)
{
	/* EXEC SQL CLOSE Cursor_Iva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )178;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	strcpy(modulo,"ifnCloseIVA");
	vDTrazasLog(modulo, "\n\t\t* Close=> Cursor_Iva",   LOG05);

	return (SQLCODE);
}/**************************** Final ifnCloseIVA ******************/


void vfnPrintIVA (REG_ARCH_IVA *pstRegIva, int iNumRegIva)
{
        int i = 0;

        strcpy(modulo,"vfnPrintIVA");

	vDTrazasLog(modulo,"\n\t\t* Despliegue de la Carga de IVA... [%d]", LOG05 ,iNumRegIva);

        for (i=0;i<iNumRegIva;i++)
        {
               vDTrazasLog(modulo,	"---------------------------------------\n"
               				"pstRegIva[%d].szRuc					[%s]	\n"
                                        "pstRegIva[%d].szCod_Periodo				[%s]	\n"
                                        "pstRegIva[%d].szCod_Secuencial			        [%s]	\n"
                                        "pstRegIva[%d].szNro_Docto				[%s]	\n"
                                        "pstRegIva[%d].szCod_Tip_Comprobante			[%s]	\n"
                                        "pstRegIva[%d].szFec_Emision				[%s]	\n"
                                        "pstRegIva[%d].szFec_Registro_Contable			[%s]	\n"
                                        "pstRegIva[%d].szNro_Serie_Comprobante			[%s]	\n"
                                        "pstRegIva[%d].szNro_Secuen_Comprobante		        [%s]	\n"
                                        "pstRegIva[%d].szNro_Autoriz_Comprob			[%s]	\n"
                                        "pstRegIva[%d].szIdentif_Credito_Tributario		[%s]	\n"
                                        "pstRegIva[%d].dBase_Imponible_Gravada			[%f]	\n"
                                        "pstRegIva[%d].lCod_Porcent_Iva			        [%ld]	\n"
                                        "pstRegIva[%d].dBase_Imponible_Tarif_0			[%f]	\n"
                                        "pstRegIva[%d].dMonto_Iva				[%f]	\n"
                                        "pstRegIva[%d].dMonto_Ice				[%f]	\n"
                                        "pstRegIva[%d].dMonto_Iva1				[%f]	\n"
                                        "pstRegIva[%d].lCod_Porcent_Retencion_Iva1		[%ld]	\n"
                                        "pstRegIva[%d].dMonto_Retencion_Iva1			[%f]	\n"
                                        "pstRegIva[%d].dMonto_Iva2				[%f]	\n"
                                        "pstRegIva[%d].lCod_Porcent_Retencion_Iva2		[%ld]	\n"
                                        "pstRegIva[%d].dMonto_Retencion_Iva2			[%f]	\n"
                                        "pstRegIva[%d].szTransac_Con_Derecho_Devolucion	        [%s]	\n"
                                        "pstRegIva[%d].szCant_Coprobantes_Vta_Emitidos_Mes	[%s]	\n"
                                        "pstRegIva[%d].szCant_Notascredito_Emitidas_Mes	        [%s]	\n"
                                        "pstRegIva[%d].szCant_Notasdebito_Emitidas_Mes		[%s]	\n"
               				, LOG05
               				, i, pstRegIva[i].szRuc
               				, i, pstRegIva[i].szCod_Periodo
               				, i, pstRegIva[i].szCod_Secuencial
               				, i, pstRegIva[i].szNro_Docto
               				, i, pstRegIva[i].szCod_Tip_Comprobante
               				, i, pstRegIva[i].szFec_Emision
               				, i, pstRegIva[i].szFec_Registro_Contable
               				, i, pstRegIva[i].szNro_Serie_Comprobante
               				, i, pstRegIva[i].szNro_Secuen_Comprobante
               				, i, pstRegIva[i].szNro_Autoriz_Comprob
               				, i, pstRegIva[i].szIdentif_Credito_Tributario
               				, i, pstRegIva[i].dBase_Imponible_Gravada
               				, i, pstRegIva[i].lCod_Porcent_Iva
               				, i, pstRegIva[i].dBase_Imponible_Tarif_0
               				, i, pstRegIva[i].dMonto_Iva
               				, i, pstRegIva[i].dMonto_Ice
               				, i, pstRegIva[i].dMonto_Iva1
               				, i, pstRegIva[i].lCod_Porcent_Retencion_Iva1
               				, i, pstRegIva[i].dMonto_Retencion_Iva1
               				, i, pstRegIva[i].dMonto_Iva2
               				, i, pstRegIva[i].lCod_Porcent_Retencion_Iva2
               				, i, pstRegIva[i].dMonto_Retencion_Iva2
               				, i, pstRegIva[i].szTransac_Con_Derecho_Devolucion
               				, i, pstRegIva[i].szCant_Coprobantes_Vta_Emitidos_Mes
               				, i, pstRegIva[i].szCant_Notascredito_Emitidas_Mes
               				, i, pstRegIva[i].szCant_Notasdebito_Emitidas_Mes		);
        }
}/*************************** vfnPrintIVA *****************************/



int iCargaIVA(REG_ARCH_IVA **pstRegIva, int *iNumRegIva)
{
        int     rc = 0;
        long    lNumFilas;
        static  REG_ARCH_IVA_HOST pstRegIvaHost;
        REG_ARCH_IVA *pstRegIvaTemp;
        long lCont;

        strcpy(modulo,"iCargaIVA");

        vDTrazasLog(modulo, "\n\t\t* Carga Estructura de IVA",   LOG05);


        *iNumRegIva = 0;
        *pstRegIva = NULL;

        if (ifnOpenIVA ())
        	return (FALSE);

	vDTrazasLog(modulo, "\n\t\t* Paso el OPEN Cur_IVA",   LOG05);

        while (rc != SQLNOTFOUND)
        {
        rc = ifnFetchIVA (&pstRegIvaHost,&lNumFilas);
        vDTrazasLog(modulo, "\n\t\t* Paso el FECTH IVA",   LOG05);

        if (rc != SQLOK  && rc != SQLNOTFOUND)
        {
        		vDTrazasLog(modulo, "\n\t\t* Primer return false",   LOG05);
                        return (FALSE);
	}
                if (!lNumFilas)
                {
                	vDTrazasLog(modulo, "\n\t\t* Segundo return false",   LOG05);
                	break;
		}

                *pstRegIva =(REG_ARCH_IVA*) realloc(*pstRegIva,(((*iNumRegIva)+lNumFilas)*sizeof(REG_ARCH_IVA)));

                if (!*pstRegIva)
                {
                	vDTrazasLog(modulo, "\n\t\t* Tercer return false",   LOG05);
                        return (FALSE);
		}

                pstRegIvaTemp = &(*pstRegIva)[(*iNumRegIva)];
                memset(pstRegIvaTemp, 0, sizeof(REG_ARCH_IVA)*lNumFilas);
                for (lCont = 0 ; lCont < lNumFilas ; lCont++)
                {

			trim(pstRegIvaHost.szRuc				[lCont]	, 	pstRegIvaTemp[lCont].szRuc					);
                        trim(pstRegIvaHost.szCod_Periodo			[lCont]	, 	pstRegIvaTemp[lCont].szCod_Periodo				);
                        trim(pstRegIvaHost.szCod_Secuencial			[lCont]	,       pstRegIvaTemp[lCont].szCod_Secuencial				);
                        trim(pstRegIvaHost.szNro_Docto				[lCont]	,       pstRegIvaTemp[lCont].szNro_Docto				);
                        trim(pstRegIvaHost.szCod_Tip_Comprobante		[lCont]	,       pstRegIvaTemp[lCont].szCod_Tip_Comprobante			);
                        trim(pstRegIvaHost.szFec_Emision			[lCont]	, 	pstRegIvaTemp[lCont].szFec_Emision				);
                        trim(pstRegIvaHost.szFec_Registro_Contable		[lCont]	, 	pstRegIvaTemp[lCont].szFec_Registro_Contable			);

                        strcpy(pstRegIvaTemp[lCont].szNro_Serie_Comprobante		, 	pstRegIvaHost.szNro_Serie_Comprobante			[lCont]	);
                        strcpy(pstRegIvaTemp[lCont].szNro_Secuen_Comprobante		, 	pstRegIvaHost.szNro_Secuen_Comprobante			[lCont]	);
                        strcpy(pstRegIvaTemp[lCont].szNro_Autoriz_Comprob		, 	pstRegIvaHost.szNro_Autoriz_Comprob			[lCont]	);

                        trim(pstRegIvaHost.szIdentif_Credito_Tributario		[lCont]	,       pstRegIvaTemp[lCont].szIdentif_Credito_Tributario		);

                        pstRegIvaTemp[lCont].dBase_Imponible_Gravada		 	= 	pstRegIvaHost.dBase_Imponible_Gravada			[lCont];
                        pstRegIvaTemp[lCont].lCod_Porcent_Iva			 	= 	pstRegIvaHost.lCod_Porcent_Iva				[lCont];
                        pstRegIvaTemp[lCont].dBase_Imponible_Tarif_0		 	= 	pstRegIvaHost.dBase_Imponible_Tarif_0			[lCont];
                        pstRegIvaTemp[lCont].dMonto_Iva				 	= 	pstRegIvaHost.dMonto_Iva				[lCont];
                        pstRegIvaTemp[lCont].dMonto_Ice				 	= 	pstRegIvaHost.dMonto_Ice				[lCont];
                        pstRegIvaTemp[lCont].dMonto_Iva1			 	= 	pstRegIvaHost.dMonto_Iva1				[lCont];
                        pstRegIvaTemp[lCont].lCod_Porcent_Retencion_Iva1	 	= 	pstRegIvaHost.lCod_Porcent_Retencion_Iva1		[lCont];
                        pstRegIvaTemp[lCont].dMonto_Retencion_Iva1		 	= 	pstRegIvaHost.dMonto_Retencion_Iva1			[lCont];
                        pstRegIvaTemp[lCont].dMonto_Iva2			 	= 	pstRegIvaHost.dMonto_Iva2				[lCont];
                        pstRegIvaTemp[lCont].lCod_Porcent_Retencion_Iva2	 	= 	pstRegIvaHost.lCod_Porcent_Retencion_Iva2		[lCont];
                        pstRegIvaTemp[lCont].dMonto_Retencion_Iva2		 	= 	pstRegIvaHost.dMonto_Retencion_Iva2			[lCont];

                        trim(pstRegIvaHost.szTransac_Con_Derecho_Devolucion	[lCont]	,       pstRegIvaTemp[lCont].szTransac_Con_Derecho_Devolucion		);
                        trim(pstRegIvaHost.szCant_Coprobantes_Vta_Emitidos_Mes	[lCont]	,       pstRegIvaTemp[lCont].szCant_Coprobantes_Vta_Emitidos_Mes	);
                        trim(pstRegIvaHost.szCant_Notascredito_Emitidas_Mes	[lCont]	,       pstRegIvaTemp[lCont].szCant_Notascredito_Emitidas_Mes		);
                        trim(pstRegIvaHost.szCant_Notasdebito_Emitidas_Mes	[lCont]	, 	pstRegIvaTemp[lCont].szCant_Notasdebito_Emitidas_Mes		);

                }
                (*iNumRegIva) += lNumFilas;

        }/* fin while */


        vDTrazasLog(modulo, "\n\t\t* Cantidad de Regs. de IVA cargados [%d]",   LOG05, *iNumRegIva);

        rc = ifnCloseIVA();
        if (rc != SQLOK)
                return (FALSE);

        vfnPrintIVA (*pstRegIva, *iNumRegIva);

        return (TRUE);
}

/* --------Estructura IVA Hasta Aqui */

/* --------Estructura ICE Desde Aqui */
static int ifnOpenICE (void)
{

    	strcpy(modulo,"ifnOpenICE");

	sprintf(szhFecInicio  	, "01%2.2ld%4.4ld", stLineaComando.lMes, stLineaComando.lAno);

	/* EXEC SQL
		SELECT TO_CHAR(LAST_DAY(TO_DATE(:szhFecInicio,'DDMMYYYY')), 'DDMMYYYY')
		INTO :szhFecFin
	        FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(LAST_DAY(TO_DATE(:b0,'DDMMYYYY')),'DDMMYYYY')\
 into :b1  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )193;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
 sqlstm.sqhstl[1] = (unsigned long )9;
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



 	if(SQLCODE!=SQLOK)
	{
		vDTrazasLog(modulo, "Error En SELECT de obtencion del ultimo dia del mes. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
		return (FALSE);
	}

        /* EXEC SQL DECLARE Cursor_Ice CURSOR FOR
		SELECT
			TO_CHAR(TO_DATE(:szhFecInicio,'DDMMYYYY'), 'YYYY'),
			TO_CHAR(TO_DATE(:szhFecInicio,'DDMMYYYY'), 'MM'),
			 B.NUM_IDENT,
			'C',
			A.COD_TIPIDENT,
			A.NUM_IDENTIFICACION,
			A.NOM_CLIENTE ||' '|| A.NOM_APECLIEN1 || ' ' || A.NOM_APECLIEN2,
			A.COD_PROVINCIA,
			A.TOT_MONTOGRAV,
			A.TOT_MONTOEXE,
			A.TOT_MONTOIVA,
			A.TOT_MONTOICE
		FROM   	FA_RESUMEN_MONTOSIMP_TO A,
				(SELECT B.NUM_IDENT, B.COD_TIPIDENT, B.NOM_CLIENTE
						FROM GE_CLIENTES B, GE_DATOSGENER A
						WHERE B.COD_CLIENTE = A.COD_CLIENTESTARTEL) B
		WHERE A.CERRADO = 'N'
		ORDER BY A.NUM_IDENTIFICACION; */ 



    	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* DECLARE=> Cursor_Ice",   LOG05);
                return(SQLCODE);
    	}

        /* EXEC SQL OPEN Cursor_Ice; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0004;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )216;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
        sqlstm.sqhstl[0] = (unsigned long )9;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecInicio;
        sqlstm.sqhstl[1] = (unsigned long )9;
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



    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* OPEN=> Cursor_Ice",   LOG05);
                return(SQLCODE);
    	}

    	return (SQLCODE);
}/***************************** Final ifnOpenICE  **********************/

static BOOL ifnFetchICE (REG_ARCH_ICE_HOST *pstHost,long *plNumFilas)
{
         /* EXEC SQL FETCH Cursor_Ice
             INTO	 :pstHost->szAno_Proceso
			,:pstHost->szMes_Proceso
			,:pstHost->szRuc_Empresa
			,:pstHost->szTip_Servicio
			,:pstHost->szTip_Ident_Usuario
			,:pstHost->szIdentif_Usuario
			,:pstHost->szNom_Usuario
			,:pstHost->szCod_Provincia
			,:pstHost->dBase_Imponible_Iva
			,:pstHost->dBase_Imponible_Ice
			,:pstHost->dValor_Iva
			,:pstHost->dValor_Ice	; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 26;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )2000;
         sqlstm.offset = (unsigned int  )239;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->szAno_Proceso);
         sqlstm.sqhstl[0] = (unsigned long )5;
         sqlstm.sqhsts[0] = (         int  )5;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->szMes_Proceso);
         sqlstm.sqhstl[1] = (unsigned long )3;
         sqlstm.sqhsts[1] = (         int  )3;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->szRuc_Empresa);
         sqlstm.sqhstl[2] = (unsigned long )14;
         sqlstm.sqhsts[2] = (         int  )14;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szTip_Servicio);
         sqlstm.sqhstl[3] = (unsigned long )2;
         sqlstm.sqhsts[3] = (         int  )2;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqharc[3] = (unsigned long  *)0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->szTip_Ident_Usuario);
         sqlstm.sqhstl[4] = (unsigned long )3;
         sqlstm.sqhsts[4] = (         int  )3;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqharc[4] = (unsigned long  *)0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->szIdentif_Usuario);
         sqlstm.sqhstl[5] = (unsigned long )14;
         sqlstm.sqhsts[5] = (         int  )14;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqharc[5] = (unsigned long  *)0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szNom_Usuario);
         sqlstm.sqhstl[6] = (unsigned long )61;
         sqlstm.sqhsts[6] = (         int  )61;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqharc[6] = (unsigned long  *)0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->szCod_Provincia);
         sqlstm.sqhstl[7] = (unsigned long )6;
         sqlstm.sqhsts[7] = (         int  )6;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqharc[7] = (unsigned long  *)0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->dBase_Imponible_Iva);
         sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[8] = (         int  )sizeof(double);
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqharc[8] = (unsigned long  *)0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->dBase_Imponible_Ice);
         sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[9] = (         int  )sizeof(double);
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqharc[9] = (unsigned long  *)0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->dValor_Iva);
         sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[10] = (         int  )sizeof(double);
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqharc[10] = (unsigned long  *)0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->dValor_Ice);
         sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[11] = (         int  )sizeof(double);
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqharc[11] = (unsigned long  *)0;
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





	vDTrazasLog(modulo, "\n\t\t* SQLCODE EN FETCH	[%ld]\n",   LOG05, sqlca.sqlcode);
        if (SQLCODE==SQLOK)
                *plNumFilas = TAM_HOSTS_PEQ;
        else
                if (SQLCODE==SQLNOTFOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

  return (SQLCODE);
}/***************************** Final ifnFetchICE ****************/

int ifnCloseICE (void)
{
	/* EXEC SQL CLOSE Cursor_Ice; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )302;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	strcpy(modulo,"ifnCloseICE");
	vDTrazasLog(modulo, "\n\t\t* Close=> Cursor_Ice",   LOG05);

	return (SQLCODE);
}/**************************** Final ifnCloseICE ******************/


void vfnPrintICE (REG_ARCH_ICE *pstRegIce, int iNumRegIce)
{
        int i = 0;

        strcpy(modulo,"vfnPrintICE");

	vDTrazasLog(modulo,"\n\t\t* Despliegue de la Carga de ICE... [%d]", LOG05 ,iNumRegIce);

        for (i=0;i<iNumRegIce;i++)
        {
               vDTrazasLog(modulo,	"---------------------------------------\n"
               				"pstRegIce[%d].szAno_Proceso		   [%s]	\n"
                                        "pstRegIce[%d].szMes_Proceso		   [%s]	\n"
                                        "pstRegIce[%d].szRuc_Empresa		   [%s]	\n"
                                        "pstRegIce[%d].szTip_Servicio		   [%s]	\n"
                                        "pstRegIce[%d].szTip_Ident_Usuario	   [%s]	\n"
                                        "pstRegIce[%d].szIdentif_Usuario	   [%s]	\n"
                                        "pstRegIce[%d].szNom_Usuario		   [%s]	\n"
                                        "pstRegIce[%d].szCod_Provincia		   [%s]	\n"
                                        "pstRegIce[%d].dBase_Imponible_Iva	   [%f]	\n"
                                        "pstRegIce[%d].dBase_Imponible_Ice	   [%f]	\n"
                                        "pstRegIce[%d].dValor_Iva		   [%f]	\n"
                                        "pstRegIce[%d].dValor_Ice	           [%f]	\n"
               				, LOG05
               				, i, pstRegIce[i].szAno_Proceso
               				, i, pstRegIce[i].szMes_Proceso
               				, i, pstRegIce[i].szRuc_Empresa
               				, i, pstRegIce[i].szTip_Servicio
               				, i, pstRegIce[i].szTip_Ident_Usuario
               				, i, pstRegIce[i].szIdentif_Usuario
               				, i, pstRegIce[i].szNom_Usuario
               				, i, pstRegIce[i].szCod_Provincia
               				, i, pstRegIce[i].dBase_Imponible_Iva
               				, i, pstRegIce[i].dBase_Imponible_Ice
               				, i, pstRegIce[i].dValor_Iva
               				, i, pstRegIce[i].dValor_Ice			);
        }
}/*************************** vfnPrintICE *****************************/



int iCargaICE(REG_ARCH_ICE **pstRegIce, int *iNumRegIce)
{
        int     rc = 0;
        long    lNumFilas;
        static  REG_ARCH_ICE_HOST pstRegIceHost;
        REG_ARCH_ICE *pstRegIceTemp;
        long lCont;

        strcpy(modulo,"iCargaICE");

        vDTrazasLog(modulo, "\n\t\t* Carga Estructura de ICE",   LOG05);


        *iNumRegIce = 0;
        *pstRegIce = NULL;

        if (ifnOpenICE ())
        	return (FALSE);

	vDTrazasLog(modulo, "\n\t\t* Paso el OPEN Cur_ICE",   LOG05);

        while (rc != SQLNOTFOUND)
        {
        rc = ifnFetchICE (&pstRegIceHost,&lNumFilas);
        vDTrazasLog(modulo, "\n\t\t* Paso el FECTH ICE",   LOG05);

        if (rc != SQLOK  && rc != SQLNOTFOUND)
        {
        		vDTrazasLog(modulo, "\n\t\t* Primer return false",   LOG05);
                        return (FALSE);
	}
                if (!lNumFilas)
                {
                	vDTrazasLog(modulo, "\n\t\t* Segundo return false",   LOG05);
                	break;
		}

                *pstRegIce =(REG_ARCH_ICE*) realloc(*pstRegIce,(((*iNumRegIce)+lNumFilas)*sizeof(REG_ARCH_ICE)));

                if (!*pstRegIce)
                {
                	vDTrazasLog(modulo, "\n\t\t* Tercer return false",   LOG05);
                        return (FALSE);
		}

                pstRegIceTemp = &(*pstRegIce)[(*iNumRegIce)];
                memset(pstRegIceTemp, 0, sizeof(REG_ARCH_ICE)*lNumFilas);
                for (lCont = 0 ; lCont < lNumFilas ; lCont++)
                {
			trim(pstRegIceHost.szAno_Proceso		[lCont], pstRegIceTemp[lCont].szAno_Proceso		        );
                        trim(pstRegIceHost.szMes_Proceso		[lCont], pstRegIceTemp[lCont].szMes_Proceso		        );
                        trim(pstRegIceHost.szRuc_Empresa		[lCont], pstRegIceTemp[lCont].szRuc_Empresa		        );
                        trim(pstRegIceHost.szTip_Servicio		[lCont], pstRegIceTemp[lCont].szTip_Servicio		        );
                        trim(pstRegIceHost.szTip_Ident_Usuario		[lCont], pstRegIceTemp[lCont].szTip_Ident_Usuario		);
                        trim(pstRegIceHost.szIdentif_Usuario		[lCont], pstRegIceTemp[lCont].szIdentif_Usuario			);
                        trim(pstRegIceHost.szNom_Usuario		[lCont], pstRegIceTemp[lCont].szNom_Usuario		        );
                        trim(pstRegIceHost.szCod_Provincia		[lCont], pstRegIceTemp[lCont].szCod_Provincia		        );
                        pstRegIceTemp[lCont].dBase_Imponible_Iva		= pstRegIceHost.dBase_Imponible_Iva		[lCont]	;
                        pstRegIceTemp[lCont].dBase_Imponible_Ice		= pstRegIceHost.dBase_Imponible_Ice	  	[lCont]	;
			pstRegIceTemp[lCont].dValor_Iva	 	 		= pstRegIceHost.dValor_Iva		   	[lCont]	;
			pstRegIceTemp[lCont].dValor_Ice	  			= pstRegIceHost.dValor_Ice		        [lCont]	;
                }
                (*iNumRegIce) += lNumFilas;

        }/* fin while */


        vDTrazasLog(modulo, "\n\t\t* Cantidad de Regs. de ICE cargados [%d]",   LOG05, *iNumRegIce);

        rc = ifnCloseICE();
        if (rc != SQLOK)
                return (FALSE);

        vfnPrintICE (*pstRegIce, *iNumRegIce);

        return (TRUE);
}

/* --------Estructura ICE Hasta Aqui */



BOOL bfnCargaEstructuras()
{

char modulo[]="bfnCargaEstructuras";
BOOL bExiste = TRUE;
int   i;
int   iContLeidos = 0;
int   iContTotal  = 0;


	if(!iCargaIVA(&pstRegIva.stRegIva, &pstRegIva.iCantRegIVA)!= SQLOK)
	{
		strcpy(modulo, "bfnCargaEstructuras");
		vDTrazasLog(modulo, "Error al Cargar el Detalle de IVA para los reportes. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}

	if(!iCargaICE  (&pstRegIce.stRegIce	, &pstRegIce.iCantRegICE)	 != SQLOK)
	{
		strcpy(modulo, "bfnCargaEstructuras");
		vDTrazasLog(modulo, "Error al Cargar el Detalle de ICE para los reportes. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}


	return (TRUE);
}


BOOL bfnGeneraReportes()
{

	char modulo[]="bfnGeneraReportes";
	BOOL bExiste = TRUE;
	int   i;                
	long	lCompVtaEmit = 0;
	long	lCompNCEmit  = 0;

	FILE 	*Arch_IVA;
	FILE 	*Arch_ICE;

	char 	*pathDir;
	char 	szPath[128]="";
	char	szMesArch[3];
	char	szAnoArch[5];

	char	szRuc_Aux[14];

	char 	szNombreFileIVA[200];
	char 	szNombreFileICE[200];

	char	szRegistro_IVA[4000];
	char	szRegistro_ICE[4000];

	char szComando[128]="";

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_DAT");
	sprintf(szPath,"%s/Proc_GenrepECU/%s",pathDir,cfnGetTime(2));
	free(pathDir);

	vDTrazasLog(modulo,"szPath DAT	[%s]\n", LOG03, szPath);

	sprintf(szMesArch, "%2.2ld", stLineaComando.lMes);
	sprintf(szAnoArch, "%4.4ld", stLineaComando.lAno);


	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	memset (szNombreFileIVA, '\0', sizeof(szNombreFileIVA));
	memset (szNombreFileICE, '\0', sizeof(szNombreFileICE));

	sprintf (szNombreFileIVA	, "%s/TL%s%s.ANE"	, szPath, szMesArch	, szAnoArch	);		/*"Arch_IVA.txt" */
	sprintf (szNombreFileICE	, "%s/ICEIVA%s.%s.ANE"		, szPath, szMesArch     , szAnoArch );		/*"Arch_ICE.txt" */


	if (pstRegIva.iCantRegIVA > 0)
	{

		printf("Archivo de IVA [%s]\n", szNombreFileIVA);


		if( (Arch_IVA=fopen(szNombreFileIVA, "w" ) )==NULL )
		{
			vDTrazasLog(modulo,"Error creando archivo IVA [%s]\n", LOG03, szNombreFileIVA);
		}

		memset (szRuc_Aux, '\0', sizeof(szRuc_Aux));

		trim(pstRegIva.stRegIva[0].szNro_Docto, szRuc_Aux);

		lhCantClientesIva = 1;
		lhCantDoctosIva  = pstRegIva.iCantRegIVA;


		for (i=0; i < pstRegIva.iCantRegIVA; i++)
		{
			memset(szRegistro_IVA, '\0', sizeof(szRegistro_IVA));

			if (strcmp(szRuc_Aux, pstRegIva.stRegIva[i].szNro_Docto) != 0)
				lhCantClientesIva++;
			
			lCompVtaEmit = atol(pstRegIva.stRegIva[i].szCant_Coprobantes_Vta_Emitidos_Mes);
			lCompNCEmit  = atol(pstRegIva.stRegIva[i].szCant_Notascredito_Emitidas_Mes);
			

			sprintf (szRegistro_IVA, REG_IVA
				,pstRegIva.stRegIva[i].szRuc
				,pstRegIva.stRegIva[i].szCod_Periodo
				,pstRegIva.stRegIva[i].szCod_Secuencial
				,pstRegIva.stRegIva[i].szNro_Docto
				,pstRegIva.stRegIva[i].szCod_Tip_Comprobante
				,pstRegIva.stRegIva[i].szFec_Emision
				,pstRegIva.stRegIva[i].szFec_Registro_Contable
				,pstRegIva.stRegIva[i].szNro_Serie_Comprobante
				,pstRegIva.stRegIva[i].szNro_Secuen_Comprobante
				,pstRegIva.stRegIva[i].szNro_Autoriz_Comprob
				,pstRegIva.stRegIva[i].szIdentif_Credito_Tributario
				,(long)pstRegIva.stRegIva[i].dBase_Imponible_Gravada
				,dfnObtieneParteDecimal(pstRegIva.stRegIva[i].dBase_Imponible_Gravada)
				,pstRegIva.stRegIva[i].lCod_Porcent_Iva
				,(long)pstRegIva.stRegIva[i].dBase_Imponible_Tarif_0
				,dfnObtieneParteDecimal(pstRegIva.stRegIva[i].dBase_Imponible_Tarif_0)
				,(long)pstRegIva.stRegIva[i].dMonto_Iva
				,dfnObtieneParteDecimal(pstRegIva.stRegIva[i].dMonto_Iva)
				,(long)pstRegIva.stRegIva[i].dMonto_Ice
				,dfnObtieneParteDecimal(pstRegIva.stRegIva[i].dMonto_Ice)
				," "
				," "
				," "
				," "
				," "
				," "
				," "
				," "
				," "
				," "
				,pstRegIva.stRegIva[i].szTransac_Con_Derecho_Devolucion
				,lCompVtaEmit
				,lCompNCEmit 
				," " );

			fprintf(Arch_IVA ,"%s", szRegistro_IVA);

			memset (szRuc_Aux, '\0', sizeof(szRuc_Aux));

			trim(pstRegIva.stRegIva[i].szNro_Docto, szRuc_Aux);

		}

		fclose (Arch_IVA);

		/* Archivo de IVA... GENERADO */

		/* EXEC SQL
			INSERT INTO FA_REPORTES_EST_TO (COD_REPORTE		, FECHA_INICO				, FECHA_TERMINO				,
							CANT_CLIENTES		, CANT_DOCUMENTOS			, ULT_FECHA_EJECUCION			,
							TERMINO_NORMAL)
						VALUES ('IVA'			,TO_DATE(:szhFecInicio, 'DDMMYYYY')	, TO_DATE(:szhFecFin, 'DDMMYYYY')	,
							:lhCantClientesIva	,:lhCantDoctosIva			, SYSDATE				,
							'S'); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 26;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into FA_REPORTES_EST_TO (COD_REPORTE,FECHA_INICO,FEC\
HA_TERMINO,CANT_CLIENTES,CANT_DOCUMENTOS,ULT_FECHA_EJECUCION,TERMINO_NORMAL) v\
alues ('IVA',TO_DATE(:b0,'DDMMYYYY'),TO_DATE(:b1,'DDMMYYYY'),:b2,:b3,SYSDATE,'\
S')";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )317;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCantClientesIva;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCantDoctosIva;
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


		if(SQLCODE != SQLOK)
	        {
	        	vDTrazasLog(modulo, "\n\t\t* INSERT INTO FA_REPORTES_EST_TO (IVA)	[%ld]",   LOG05, sqlca.sqlcode );
	                return(FALSE);
	    	}
	}







	if (pstRegIce.iCantRegICE > 0)
	{
		printf("Archivo de ICE [%s]\n", szNombreFileICE);

		if( (Arch_ICE=fopen(szNombreFileICE, "w" ) )==NULL )
		{
			vDTrazasLog(modulo,"Error creando archivo ICE	[%s]\n", LOG03, szNombreFileICE);
		}


		memset (szRuc_Aux, '\0', sizeof(szRuc_Aux));
		trim(pstRegIce.stRegIce[0].szIdentif_Usuario, szRuc_Aux);

		lhCantClientesIce = 1;
		lhCantDoctosIce  = pstRegIce.iCantRegICE;


		for (i=0; i < pstRegIce.iCantRegICE; i++)
		{
			memset(szRegistro_ICE, '\0', sizeof(szRegistro_ICE));

			if (strcmp(szRuc_Aux, pstRegIce.stRegIce[i].szIdentif_Usuario) != 0)
				lhCantClientesIce++;

			sprintf (szRegistro_ICE, REG_ICE
				,pstRegIce.stRegIce[i].szAno_Proceso
				,pstRegIce.stRegIce[i].szMes_Proceso
				,pstRegIce.stRegIce[i].szRuc_Empresa
				,pstRegIce.stRegIce[i].szTip_Servicio
				,pstRegIce.stRegIce[i].szTip_Ident_Usuario
				,pstRegIce.stRegIce[i].szIdentif_Usuario
				,pstRegIce.stRegIce[i].szNom_Usuario
				,pstRegIce.stRegIce[i].szCod_Provincia
				,(long)pstRegIce.stRegIce[i].dBase_Imponible_Iva
				,dfnObtieneParteDecimal(pstRegIce.stRegIce[i].dBase_Imponible_Iva)
				,(long)pstRegIce.stRegIce[i].dBase_Imponible_Ice
				,dfnObtieneParteDecimal(pstRegIce.stRegIce[i].dBase_Imponible_Ice)
				,(long)pstRegIce.stRegIce[i].dValor_Iva
				,dfnObtieneParteDecimal(pstRegIce.stRegIce[i].dValor_Iva)
				,(long)pstRegIce.stRegIce[i].dValor_Ice
				,dfnObtieneParteDecimal(pstRegIce.stRegIce[i].dValor_Ice));

			fprintf(Arch_ICE ,"%s", szRegistro_ICE);

			memset (szRuc_Aux, '\0', sizeof(szRuc_Aux));
			trim(pstRegIce.stRegIce[i].szIdentif_Usuario, szRuc_Aux);
		}

		fclose (Arch_ICE);

		/* Archivo de ICE... GENERADO */


		/* EXEC SQL
			INSERT INTO FA_REPORTES_EST_TO (COD_REPORTE		, FECHA_INICO				, FECHA_TERMINO				,
							CANT_CLIENTES		, CANT_DOCUMENTOS			, ULT_FECHA_EJECUCION			,
							TERMINO_NORMAL)
						VALUES ('ICE'			,TO_DATE(:szhFecInicio, 'DDMMYYYY')	, TO_DATE(:szhFecFin, 'DDMMYYYY')	,
							:lhCantClientesIce	,:lhCantDoctosIce			, SYSDATE				,
							'S'); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 26;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into FA_REPORTES_EST_TO (COD_REPORTE,FECHA_INICO,FEC\
HA_TERMINO,CANT_CLIENTES,CANT_DOCUMENTOS,ULT_FECHA_EJECUCION,TERMINO_NORMAL) v\
alues ('ICE',TO_DATE(:b0,'DDMMYYYY'),TO_DATE(:b1,'DDMMYYYY'),:b2,:b3,SYSDATE,'\
S')";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )348;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCantClientesIce;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCantDoctosIce;
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


		if(SQLCODE != SQLOK)
	        {
	        	vDTrazasLog(modulo, "\n\t\t* INSERT INTO FA_REPORTES_EST_TO (ICE)	[%ld]",   LOG05, sqlca.sqlcode );
	                return(FALSE);
	    	}

    	}

    	/* EXEC SQL UPDATE FA_RESUMEN_MONTOSIMP_TO SET CERRADO = 'S'
    		WHERE CERRADO = 'N'; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 26;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update FA_RESUMEN_MONTOSIMP_TO  set CERRADO='S' where CE\
RRADO='N'";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )379;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* UPDATE FA_RESUMEN_MONTOSIMP_TO [%ld]",   LOG05, sqlca.sqlcode );
                return(FALSE);
    	}



	return (TRUE);
}



/* HASTA AQUI PGG FUNCIONES NUEVAS */


/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char modulo[]="main"		;
    char *szUserid_Aux			;
    extern	char *optarg        	;
    char  	opt[]=":u:m:a:l:" 	;
    int   	iOpt =0             	;
    int   	sts			;
    char  	szHelpString[1024] = " ";
    char  	szLineaComando2[25]= ""	;

    memset(&stLineaComando,0    ,sizeof(LINEACOMANDOPRELIMINAR));


    sprintf(szHelpString,"\n Argumentos de entrada de proceso : "
    				"\n\t -u Usuario/Password                               "
    				"\n\t -m Mes al cual se le desea generar reporte        "
    				"\n\t -a Año al cual se le desea generar reporte        "
    				"\n\t -l Nivel de Log				   	\n");

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
		case 'u':
			strcpy(stLineaComando.szUsuario, optarg);
			if((szUserid_Aux=(char *)strstr(stLineaComando.szUsuario,"/")) == (char *)NULL)
			{
				fprintf(stderr, "\nUsuario Oracle no es valido.\n");
				return(1);
			}
			else
			{
				strncpy(stLineaComando.szUser,stLineaComando.szUsuario, szUserid_Aux-stLineaComando.szUsuario);
				strcpy(stLineaComando.szPass, szUserid_Aux+1);
				fprintf (stdout," -u?/? ");
			}
			break;
		case 'm':
			if (strlen (optarg))
			{
				stLineaComando.lMes =atol (optarg);
				fprintf (stdout," -m%ld ", stLineaComando.lMes);
			}
			else
			{
				fprintf (stderr,"\n\t<< Error : Falta parametro Mes.\n");
				return (1);
			}
			break;

		case 'a':
	                if ( strlen (optarg) )
	                {
				stLineaComando.lAno =atol (optarg);
				fprintf (stdout," -a%ld ", stLineaComando.lAno);
			}
	                else
			{
				fprintf (stderr,"\n\t<< Error : Falta parametro Año.\n");
				return (1);
			}
	                break;
		case 'l':
			if (strlen (optarg) )
			{
				stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
				fprintf (stdout,"-l%d ", stStatus.LogNivel)     ;
			}
			break;

        }/*End Switch */

    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */


	if (stLineaComando.lMes < 1 || stLineaComando.lMes > 12)
	{
		fprintf(stderr, "\n\tMes fuera de rango.\n");
		fprintf(stderr,"%s",szHelpString);
		return (1);
    	}

	if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF;

	stLineaComando.iNivLog = stStatus.LogNivel;

    	if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    	{
        	fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                		"'sptel  <usuario> <passwd> '\n");
        	return (2);
    	}
    	else
    	{
        	printf( "\n\t-------------------------------------------------------"
                	"\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                	"\n\t-------------------------------------------------------\n",
	                stLineaComando.szUser);
    	}



    	/**************************************************************************************/
    	/* Crear archivos y directorios de log y errores */

    	sts = ifnAbreArchivosLog();


    	if ( sts != 0 ) return sts;

    	/*********************************************************************************************/

    	vDTrazasLog  ( modulo ,"\n\n\t**********************************************"
                           "\n\n\t****           Log Proc_GenrepECU          **"
                           "\n\n\t**********************************************"
                           ,LOG03);

    	vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada Proc_GenrepECU  ***"
                           "\n\t\t=> Usuario               	[%s]"
                           "\n\t\t=> Mes			[%ld]"
                           "\n\t\t=> Año			[%ld]"
                           "\n\t\t=> Niv.Log              	[%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.lMes
                           ,stLineaComando.lAno
                           ,stLineaComando.iNivLog);

    	/************************************************************************************/
    	/*			Proceso Principal						*/
    	/************************************************************************************/

    	strcpy(modulo,"Proc_GenrepECU");

    	vDTrazasLog(modulo,"\n\t\t***  Inicio Proceso principal  ***", LOG03);



    	vDTrazasLog(modulo,"\n\t\t*** Inicio del Cargado de Estructuras***\n", LOG03);


	if (!bfnCargaEstructuras())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
	        return (FALSE);
	}
	vDTrazasLog(modulo,"\n\t\t*** Inicio Ejecucion Generacion de Reportes***\n", LOG03);


	if (!bfnGeneraReportes())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de la Generacion de Reportes***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de la Generacion de Reportes***\n", LOG01);
	        return (FALSE);
	}


    	if (!bfnOraCommit ())
    	{
        	vDTrazasError(modulo," en Commit", LOG01);
        	vDTrazasLog  (modulo," en Commit", LOG01);
        	return FALSE;
    	}

	if(!bfnDisconnectORA(0))
	{
		vDTrazasLog  ( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
	}
    	else
    	{
		vDTrazasLog  ( modulo,	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo, 	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);

	}


    return (0);
}/* ********************* Fin Main * *************************************** */

/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog(void)
{
	char modulo[]="ifnAbreArchivosLog";

	char *pathDir;
	char szArchivo[32]="";
	char szPath[128]="";
	char szComando[128]="";
	char szRechazadosName[32];

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"Proc_GenrepECU");

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/Proc_GenrepECU/%s",pathDir,cfnGetTime(2));
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	sprintf(stStatus.ErrName,"%s/%s_%s.err",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;
	}

	vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

	sprintf(stStatus.LogName,"%s/%s_%s.log",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.LogFile = fopen(stStatus.LogName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;
	}

	vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));


	vDTrazasLog(modulo, "%s << Inicio de Proc_GenrepECU >>" , LOG03, cfnGetTime(1));

	return 0;


} /* Fin ifnAbreArchivosLog  */


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

