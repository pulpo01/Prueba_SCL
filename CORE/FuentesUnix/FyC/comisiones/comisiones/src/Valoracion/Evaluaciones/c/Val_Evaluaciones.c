
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
           char  filnam[25];
};
static struct sqlcxp sqlfpn =
{
    24,
    "./pc/Val_Evaluaciones.pc"
};


static unsigned int sqlctx = 887247747;


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
   unsigned char  *sqhstv[9];
   unsigned long  sqhstl[9];
            int   sqhsts[9];
            short *sqindv[9];
            int   sqinds[9];
   unsigned long  sqharm[9];
   unsigned long  *sqharc[9];
   unsigned short  sqadto[9];
   unsigned short  sqtdso[9];
} sqlstm = {12,9};

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

 static char *sq0001 = 
"select A.NUM_GENERAL ,A.COD_COMISIONISTA ,A.NUM_VENTA ,NVL(B.COD_CLIENTE,0) \
,B.COD_OFICINA ,TO_CHAR(A.FEC_SOLICITUD,'DD-MM-YYYY')  from CMT_EVALUACIONES A\
 ,VE_VENDEDORES B ,VE_REDVENTAS_TD D where ((((((A.ID_PERIODO=:b0 and A.COD_TI\
PORED=:b1) and A.COD_TIPCOMIS=:b2) and A.COD_COMISIONISTA=B.COD_VENDEDOR) and \
B.COD_TIPCOMIS=A.COD_TIPCOMIS) and D.COD_TIPORED=A.COD_TIPORED) and D.COD_VEND\
EDOR=B.COD_VENDEDOR)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,419,0,9,108,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
32,0,0,1,0,0,13,112,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,
97,0,0,
71,0,0,1,0,0,15,176,0,0,0,0,0,1,0,
86,0,0,2,158,0,4,205,0,0,6,3,0,1,0,2,4,0,0,2,4,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,
125,0,0,3,174,0,3,273,0,0,8,8,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,
172,0,0,4,118,0,4,317,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,
199,0,0,5,111,0,4,392,0,0,1,0,0,1,0,2,4,0,0,
218,0,0,6,51,0,4,438,0,0,1,0,0,1,0,2,3,0,0,
237,0,0,7,91,0,4,442,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
260,0,0,8,233,0,3,455,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,
3,0,0,
299,0,0,9,0,0,29,482,0,0,0,0,0,1,0,
314,0,0,10,74,0,4,484,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
337,0,0,11,169,0,6,497,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,3,97,0,0,3,97,0,
0,3,97,0,0,3,97,0,0,3,97,0,0,3,97,0,0,
388,0,0,12,0,0,29,507,0,0,0,0,0,1,0,
403,0,0,13,78,0,4,518,0,0,2,1,0,1,0,2,4,0,0,1,3,0,0,
426,0,0,14,0,0,31,533,0,0,0,0,0,1,0,
441,0,0,15,48,0,1,651,0,0,0,0,0,1,0,
456,0,0,16,0,0,30,748,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las habilitaciones del producto      */
/* prepago para luego pasar a la etapa de acumulacion.                  */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 28 de Octubre del 2001.                                */
/* Fin:                                                                 */
/* Autor : Fabian Aedo Ramirez                                          */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla 	    */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y	    */
/* COD_PARAMETRO.						                               	*/
/************************************************************************/
/* Modificado Marcelo Quiroz Garcia                                     */
/* Se incorporan tratamientos de:                                       */
/* - Ciclos Esporádicos                                                 */
/* - Planes de Comisiones                                               */
/* - Red de Ventas                                                      */
/* Versionado CUZCO - Oct-2003.                                         */
/* **********************************************************************/
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Val_Evaluaciones.h"
#include "GEN_biblioteca.h"
/*---------------------------------------------------------------------------*/
/* Declaracion e inicializacion	de lista de conceptos a	procesar.	         */
/*---------------------------------------------------------------------------*/
stConceptosProc	* lstConceptosProc = NULL;
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError_2(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhUser[30]="";
	char	szhPass[30]="";
	char	szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
	char	szhIdPeriodo[11];
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* Extrae el universo de evaluaciones de riesgo para luego proceder a su     */
/* valorización.                                                             */
/*---------------------------------------------------------------------------*/
void vCreaUniverso()
{
    stConceptosProc * raux;    
	stEvaluaciones  * qaux;
	stUniverso      * paux;

	int		    i;
	short 		iLastRows    = 0;
	int   		iFetchedRows = MAXFETCH;
	int   		iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lMaxFetch;
    	int	   	ihCodTipoRed;
        int     ihCodConcepto;
		long	lhNumGeneral     [MAXFETCH];
		long	lhCodComisionista[MAXFETCH];
		long	lhNumVenta       [MAXFETCH];
		long	lhCodCliente     [MAXFETCH];
		char	szhCodOficina    [MAXFETCH][3];
		char	szhFechaSolicitud [MAXFETCH][11];

		char	szhCodPlanComis[7];	
		char	szhCodTipComis [3];		
	/* EXEC SQL END DECLARE SECTION; */ 


	lMaxFetch    = MAXFETCH;
	stStatusProc.lCantEvaluaciones = 0;

    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
	{	
		ihCodTipoRed           = raux->iCodTipoRed;
		ihCodConcepto          = raux->iCodConcepto;
        strcpy(szhCodTipComis  , raux->szCodTipComis);
        strcpy(szhCodPlanComis , raux->szCodPlanComis);

	    /* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR
		 	SELECT 	A.NUM_GENERAL,
					A.COD_COMISIONISTA,
					A.NUM_VENTA,
					NVL(B.COD_CLIENTE,0),
					B.COD_OFICINA,
					TO_CHAR(A.FEC_SOLICITUD,'DD-MM-YYYY')					
			FROM    CMT_EVALUACIONES A, 
					VE_VENDEDORES    B,
			   		VE_REDVENTAS_TD  D
			WHERE   A.ID_PERIODO 		= :szhIdPeriodo
			AND 	A.COD_TIPORED 		= :ihCodTipoRed
			AND 	A.COD_TIPCOMIS 		= :szhCodTipComis
			AND 	A.COD_COMISIONISTA 	= B.COD_VENDEDOR
           	AND 	B.COD_TIPCOMIS   	= A.COD_TIPCOMIS 
		   	AND 	D.COD_TIPORED    	= A.COD_TIPORED
		   	AND 	D.COD_VENDEDOR   	= B.COD_VENDEDOR; */ 

		      
		/* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 3;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0001;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoRed;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}


	
		while(iFetchedRows == iRetrievRows)
		{
			/* EXEC SQL for :lMaxFetch
				FETCH CUR_UNIVERSO 
			 	INTO 	:lhNumGeneral     ,
			 			:lhCodComisionista,
			 			:lhNumVenta       ,
			 			:lhCodCliente     ,
			 			:szhCodOficina	  ,
			 			:szhFechaSolicitud; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 6;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )lMaxFetch;
   sqlstm.offset = (unsigned int  )32;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)lhNumGeneral;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)lhCodComisionista;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )sizeof(long);
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)lhNumVenta;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )sizeof(long);
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)lhCodCliente;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )sizeof(long);
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
   sqlstm.sqhstl[4] = (unsigned long )3;
   sqlstm.sqhsts[4] = (         int  )3;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFechaSolicitud;
   sqlstm.sqhstl[5] = (unsigned long )11;
   sqlstm.sqhsts[5] = (         int  )11;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
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
   if (sqlca.sqlcode < 0) vSqlError_2();
}


       
			iRetrievRows= sqlca.sqlerrd[2] - iLastRows;
			iLastRows 	= sqlca.sqlerrd[2];
				
			for (i=0; i < iRetrievRows; i++)
			{		   
				qaux = (stEvaluaciones *) malloc(sizeof(stEvaluaciones));

				qaux->lNumGeneral = lhNumGeneral[i];
				qaux->lNumVenta   = lhNumVenta[i];
				strcpy(qaux->szFechaSolicitud, szfnTrim(szhFechaSolicitud[i]));
				
				qaux->sgte        = NULL;

				paux              = lstUniverso;			
			
				while((paux!=NULL)&&(paux->lCodComisionista!=lhCodComisionista[i]))
					paux=paux->sgte;

				if (paux == NULL)
				{			    
	            	fprintf(pfLog ,"No existia comisionista, se crea\n");
	            	fprintf(stderr,"No existia comisionista, se crea\n");
			    
					paux = (stUniverso *) malloc(sizeof(stUniverso));

        			paux->iCodTipoRed          = ihCodTipoRed;                                                     
        			paux->iCodConcepto         = ihCodConcepto;                                                     
					paux->lCodComisionista     = lhCodComisionista[i];
					paux->lCodCliente		   = lhCodCliente[i];
					paux->iNumTotal            = 0;
					paux->iNumVentas           = 0;
					paux->dPonderacion         = 0.0;
					paux->dImpComision         = 0.0;
					
					strcpy(paux->szFecDesde		, raux->szFecDesde);
					strcpy(paux->szFecHasta		, raux->szFecHasta);

					strcpy(paux->szCodTipComis , szfnTrim(szhCodTipComis));
					strcpy(paux->szCodPlanComis, szfnTrim(szhCodPlanComis));
					strcpy(paux->szCodOficina  , szhCodOficina[i]);

					paux->sgte_eval            = NULL;
					paux->sgte                 = lstUniverso;
					lstUniverso                = paux;
				}
				qaux->sgte      = paux->sgte_eval;
				paux->sgte_eval = qaux;

				paux->iNumTotal++;

				if(qaux->lNumVenta>0) paux->iNumVentas++;
	
				stStatusProc.lCantEvaluaciones++;
			}
		}
		/* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )71;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError_2();
}


	}
	fprintf(stderr,"\nCantidad de Evaluaciones valorizadas....[%d]\n",stStatusProc.lCantEvaluaciones);
}
/*---------------------------------------------------------------------------*/
/* Ejecuta la valoracion de los excedentes de evaluacion.                    */
/*---------------------------------------------------------------------------*/
void	vValoraExcedentes()
{
	stUniverso * paux;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed     ;
        int     ihCodConcepto ;
        double  dhValUmbral   ;
        double  dhValExcedente;
        char    szhCodMoneda   [3];  
        char    szhCodPlanComis[6];  
	/* EXEC SQL END DECLARE SECTION; */ 


	double	dRazon=0.000;
    double	dMtoPrecio;

	for(paux=lstUniverso;paux!=NULL;paux=paux->sgte)
	{
        ihCodTipoRed  = paux->iCodTipoRed;
        ihCodConcepto = paux->iCodConcepto;
        strcpy(szhCodPlanComis,paux->szCodPlanComis);

        /* EXEC SQL 
        	SELECT 	VAL_UMBRAL   , 
					VAL_EXCEDENTE, 
					COD_MONEDA 
        	INTO   	:dhValUmbral   , 
					:dhValExcedente, 
					:szhCodMoneda
        	FROM 	CM_VALEVALUACIONES_TD
        	WHERE 	COD_TIPORED   = :ihCodTipoRed
        	AND 	COD_CONCEPTO  = :ihCodConcepto
        	AND 	COD_PLANCOMIS = :szhCodPlanComis; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select VAL_UMBRAL ,VAL_EXCEDENTE ,COD_MONEDA into :b0\
,:b1,:b2  from CM_VALEVALUACIONES_TD where ((COD_TIPORED=:b3 and COD_CONCEPTO=\
:b4) and COD_PLANCOMIS=:b5)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )86;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhValUmbral;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhValExcedente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodMoneda;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipoRed;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodPlanComis;
        sqlstm.sqhstl[5] = (unsigned long )6;
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}



        paux->dValUmbral         = dhValUmbral;
        paux->dValExcedente      = dhValExcedente;
        strcpy(paux->szCodMoneda , szhCodMoneda);

        dRazon = (float)(paux->iNumVentas)/(float)(paux->iNumTotal);
                
        paux->dPonderacion = paux->dValUmbral - dRazon;
                
        dMtoPrecio = fObtienePrecio(paux->dValExcedente, paux->lCodCliente, paux->szCodOficina);

        if (paux->dPonderacion >=0) paux->dImpComision = dMtoPrecio * paux->dPonderacion;
	}	
}
/*---------------------------------------------------------------------------*/
/* Insercion de valores en tabla CMT_VALORIZADOS                             */
/*---------------------------------------------------------------------------*/
void 	vInsertaValorizados()
{
	stEvaluaciones	* qaux;
	stUniverso	    * paux;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumGeneral;
		long    lhCodComisionista;
		long    lhCodPeriodo;
		int     ihCodConcepto;		
		char	szhCodUniverso[7];	
		char	szhCodTipComis[3];	
		char	szhIdPeriodo [11];	
		double	dhImpComision;
		char	szhFecDesde[11];
		char	szhFecHasta[11];
		char	szhFecEvento[11];
	/* EXEC SQL END DECLARE SECTION; */ 

		
	lhCodPeriodo           = stCiclo.lCodCiclComis ;	
	strcpy(szhIdPeriodo    , stCiclo.szIdCiclComis);		
	strcpy(szhCodUniverso  , CODUNIVERSO);

	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		dhImpComision          = fnCnvDouble(paux->dImpComision, 0);
		strcpy(szhCodTipComis  , paux->szCodTipComis);
		ihCodConcepto          = paux->iCodConcepto;
		lhCodComisionista      = paux->lCodComisionista;

		for (qaux = paux->sgte_eval; qaux != NULL; qaux = qaux->sgte)
		{
		 strcpy(szhFecDesde	,	paux->szFecDesde);
	 	 strcpy(szhFecHasta	,	paux->szFecHasta);
	 	 strcpy(szhFecEvento,	qaux->szFechaSolicitud);
	 	
		 if (bValidaFechaEvento(szhFecDesde, szhFecHasta, szhFecEvento))
	  	  {						
			lhNumGeneral           = qaux->lNumGeneral;
	     	
			/* EXEC SQL INSERT INTO CMT_VALORIZADOS (
			     	NUM_GENERAL , COD_UNIVERSO    , COD_CONCEPTO,
					COD_TIPCOMIS, COD_COMISIONISTA, COD_PERIODO,
			     	ID_PERIODO  , IMP_CONCEPTO) 
			VALUES (:lhNumGeneral  , :szhCodUniverso  , :ihCodConcepto,
			     	:szhCodTipComis, :lhCodComisionista,:lhCodPeriodo ,
					:szhIdPeriodo  , :dhImpComision); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_UNIVERSO,COD_\
CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP_CONCEPTO) va\
lues (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )125;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumGeneral;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodUniverso;
   sqlstm.sqhstl[1] = (unsigned long )7;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipComis;
   sqlstm.sqhstl[3] = (unsigned long )3;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodComisionista;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodPeriodo;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhIdPeriodo;
   sqlstm.sqhstl[6] = (unsigned long )11;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&dhImpComision;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
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
   if (sqlca.sqlcode < 0) vSqlError_2();
}


		  }
		}
	}
} 
/*---------------------------------------------------------------------------*/
/* Liberar Memoria para Lista de evaluaciones deriesgo.                      */
/*---------------------------------------------------------------------------*/
void vLiberaEventos(stEvaluaciones * EvalAux)
{
	if (EvalAux == NULL)
		return;
	vLiberaEventos(EvalAux->sgte);
	free(EvalAux);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria para Lista de evaluaciones deriesgo.                      */
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stUniverso * UniAux)
{
	if (UniAux == NULL)
		return;
	vLiberaUniverso(UniAux->sgte);
	vLiberaEventos(UniAux->sgte_eval);
	free(UniAux);
}
/*---------------------------------------------------------------------------*/
char *szGetCmdParametros(int iTipCod, int iCodCod)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	       int 		ihTipCod;
	       int		ihCodCod;
	       char		szhResul[11];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihTipCod = iTipCod;
	ihCodCod = iCodCod;
	   	
	/* EXEC SQL SELECT VAL_PARAMETRO1 
		INTO   :szhResul
         FROM  CMD_PARAMETROS
         WHERE COD_TIPCODIGO = :ihTipCod
         AND   COD_CODIGO    = :ihCodCod
         AND   COD_PARAMETRO > 0; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO1 into :b0  from CMD_PARAMETROS where ((\
COD_TIPCODIGO=:b1 and COD_CODIGO=:b2) and COD_PARAMETRO>0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )172;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhResul;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihTipCod;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCod;
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
 if (sqlca.sqlcode < 0) vSqlError_2();
}


	return szhResul;
}
/*---------------------------------------------------------------------------*/
/* Carga Parametros Generales de proceso                                     */
/*---------------------------------------------------------------------------*/
void vCargaParametros()
{
	iCodConcepFactImp = atol(szGetCmdParametros(4,1)); 
	lClienteGenerico  = atol(szGetCmdParametros(4,2));
}
/*---------------------------------------------------------------------------*/
/* Gestiona la carga de	Conceptos y Parámetros de Valoración		         */
/*---------------------------------------------------------------------------*/
int bCargaConceptos()
{
	switch (stCiclo.cTipCiclComis)
	{
		case PERIODICO:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "Carga lista de conceptos para ejecucion Periodica o Normal..\n\n");  
		    fprintf(stderr, "Carga lista de conceptos para ejecucion Periodica o Normal...\n\n");  
		    lstConceptosProc = stGetConceptosPer(FORMACOMIS,stCiclo);
		    return TRUE;
		case ESPORADICO:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "Carga lista de conceptos para ejecucion Esporadica	o Promocional..\n\n");	
		    fprintf(stderr, "Carga lista de conceptos para ejecucion Esporadica	o Promocional...\n\n");	 
		    lstConceptosProc = stGetConceptosProm(FORMACOMIS,stCiclo);
		    return TRUE;
		default:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    fprintf(stderr, "Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    return FALSE;
	}	
}
/*---------------------------------------------------------------------------*/
/* Obtiene Precio                                                            */
/*---------------------------------------------------------------------------*/
float fObtienePrecio ( float fConstante , long lCodCliente, char * szCodOficina)
{
float fValorConversion;
float fValorNeto      ;
float fValorPrecio    ;

    fprintf(pfLog , "Inicio de funcion fObtienePrecio...\n\n");	
    fprintf(stderr, "Inicio de funcion fObtienePrecio...\n\n");	         
    fValorConversion = fObtieneValorConversion();

   	fValorNeto       = fConstante * fValorConversion;

    fprintf(pfLog , "Inicio de funcion fOBtieneImpuestos...\n\n");	
    fprintf(stderr, "Inicio de funcion fOBtieneImpuestos...\n\n");	         
    fValorPrecio     = fOBtieneImpuestos(fValorNeto, lCodCliente, szCodOficina);

    return (fValorPrecio);
}
/*---------------------------------------------------------------------------*/
/* Obtiene Valor de Conversion                                               */
/*---------------------------------------------------------------------------*/
float fObtieneValorConversion()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        float   fhValorConversion;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL
        SELECT CAMBIO 
		INTO   :fhValorConversion 
        FROM   GE_CONVERSION
        WHERE  COD_MONEDA = '003'
        AND    SYSDATE BETWEEN  FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD_MON\
EDA='003' and SYSDATE between FEC_DESDE and FEC_HASTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )199;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&fhValorConversion;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(float);
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    
    return(fhValorConversion);    
}    
/*---------------------------------------------------------------------------*/
/* Obtiene Impuestos                                                         */
/*---------------------------------------------------------------------------*/
float fOBtieneImpuestos(float fValorNeto, long lCodCte, char * szCodOfi)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

       int      ihConceptoFacturacion;
       int      ihCodTipConce;
       long     lhSecuencia;
       long     lhClienteGenerico;
       long     lhCodCatImpos;
       float	fhValorNeto;
       float    fhValorConImpto;
       char		szhCodOficina[3];        
       char     szhRetorno1[250]; 
       char     szhRetorno2[250]; 
       char     szhRetorno3[250]; 
       char     szhRetorno4[250]; 
       char     szhRetorno5[250]; 
       char     szhRetorno6[250];                            
    /* EXEC SQL END DECLARE SECTION; */ 

        
    szhRetorno1[0]= '\0';
    szhRetorno2[0]= '\0';
    szhRetorno3[0]= '\0';
    szhRetorno4[0]= '\0';
    szhRetorno5[0]= '\0';
    szhRetorno6[0]= '\0';

    ihConceptoFacturacion = iCodConcepFactImp;   
    strcpy(szhCodOficina  , szCodOfi);
        
    if    (lCodCte == 0)  	lhClienteGenerico = lClienteGenerico;
    else                    lhClienteGenerico = lCodCte;
    	
    fhValorNeto = fValorNeto;
        
    /* EXEC SQL SELECT FAS_PRESUPTEMP.NEXTVAL INTO :lhSecuencia FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FAS_PRESUPTEMP.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )218;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}

    
        
    fprintf(pfLog , "\n\nihConceptoComisiones [%ld]\n", ihConceptoFacturacion);
        
    /* EXEC SQL
        SELECT COD_TIPCONCE INTO
               :ihCodTipConce  
        FROM FA_CONCEPTOS
        WHERE COD_CONCEPTO = :ihConceptoFacturacion
        AND COD_PRODUCTO   = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_TIPCONCE into :b0  from FA_CONCEPTOS where (CO\
D_CONCEPTO=:b1 and COD_PRODUCTO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )237;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipConce;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihConceptoFacturacion;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}

     
                
    fprintf(pfLog ,"\n\n lhSecuencia		    [%ld]\n", lhSecuencia);
    fprintf(pfLog ,"\n\n ihConceptoFacturacion  [%d]\n" , ihConceptoFacturacion);
    fprintf(pfLog ,"\n\n lhClienteGenerico 	    [%ld]\n", lhClienteGenerico);
    fprintf(pfLog ,"\n\n fhValorNeto  		    [%ld]\n", fhValorNeto);
    fprintf(pfLog ,"\n\n ihCodTipConce 		    [%ld]\n", ihCodTipConce);
    
    /* EXEC SQL
        INSERT INTO FAT_PRESUPTEMP
                (NUM_PROCESO	, 
                COD_CONCEPTO	, 
                COLUMNA			, 
                COD_CLIENTE		, 
                FEC_EFECTIVIDAD	, 
                IMP_CONCEPTO	, 
                IMP_FACTURABLE	, 
                COD_TIPCONCE	,
                COD_CONCEREL	, 
                COLUMNA_REL		, 
                FLAG_IMPUES		, 
                PRC_IMPUESTO)
         VALUES(:lhSecuencia,
                :ihConceptoFacturacion,
                1,
                :lhClienteGenerico,
                SYSDATE,
                :fhValorNeto,
                :fhValorNeto,
                :ihCodTipConce,
                0,
                0,
                0,
                0.0); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_PRESUPTEMP (NUM_PROCESO,COD_CONCEPTO,COLU\
MNA,COD_CLIENTE,FEC_EFECTIVIDAD,IMP_CONCEPTO,IMP_FACTURABLE,COD_TIPCONCE,COD_C\
ONCEREL,COLUMNA_REL,FLAG_IMPUES,PRC_IMPUESTO) values (:b0,:b1,1,:b2,SYSDATE,:b\
3,:b3,:b5,0,0,0,0.0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )260;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihConceptoFacturacion;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhClienteGenerico;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&fhValorNeto;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&fhValorNeto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


           	       
    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )299;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}

   
                            
    /* EXEC SQL 
        SELECT COD_CATIMPOS  INTO
                :lhCodCatImpos
        FROM GE_CATIMPCLIENTES
        WHERE COD_CLIENTE = :lhClienteGenerico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CATIMPOS into :b0  from GE_CATIMPCLIENTES wher\
e COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )314;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCatImpos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhClienteGenerico;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


                           
    fprintf(pfLog ,"Empezando PL ---lhSecuencia=%d lhCodCatImpos=%d sqlcode[%d]\n",
    lhSecuencia,lhCodCatImpos,sqlca.sqlcode);
    fprintf(stderr,"Empezando PL ---lhSecuencia=%d lhCodCatImpos=%d sqlcode[%d]\n",
    lhSecuencia,lhCodCatImpos,sqlca.sqlcode);
     
    iPl=1;
     
    /* EXEC SQL EXECUTE                                         
     	BEGIN                                                    
            FA_PROC_IMPTOS (:lhSecuencia,           
                            :lhCodCatImpos, :szhCodOficina,                     
                            :szhRetorno1  , :szhRetorno2,                         
                            :szhRetorno3  , :szhRetorno4,                         
                            :szhRetorno5  , :szhRetorno6);                        
     	END;                                                     
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin FA_PROC_IMPTOS ( :lhSecuencia , :lhCodCatImpos , :s\
zhCodOficina , :szhRetorno1 , :szhRetorno2 , :szhRetorno3 , :szhRetorno4 , :sz\
hRetorno5 , :szhRetorno6 ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )337;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCatImpos;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhRetorno1;
    sqlstm.sqhstl[3] = (unsigned long )250;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhRetorno2;
    sqlstm.sqhstl[4] = (unsigned long )250;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhRetorno3;
    sqlstm.sqhstl[5] = (unsigned long )250;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhRetorno4;
    sqlstm.sqhstl[6] = (unsigned long )250;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhRetorno5;
    sqlstm.sqhstl[7] = (unsigned long )250;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhRetorno6;
    sqlstm.sqhstl[8] = (unsigned long )250;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}

                                                
                                                                   
    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )388;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}

      					
    
    iPl=0;
    
    fprintf(stderr,"Terminando PL %s %s %s %s %s %s\n",szfnTrim(szhRetorno1)
                                                      ,szfnTrim(szhRetorno2)
                                                      ,szfnTrim(szhRetorno3)
                                                      ,szfnTrim(szhRetorno4)
                                                      ,szfnTrim(szhRetorno5)
                                                      ,szfnTrim(szhRetorno6));    
  
    /* EXEC SQL
        SELECT SUM(IMP_FACTURABLE) 
		INTO   :fhValorConImpto
        FROM   FAT_PRESUPTEMP
        WHERE  NUM_PROCESO = :lhSecuencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select sum(IMP_FACTURABLE) into :b0  from FAT_PRESUPTEMP \
where NUM_PROCESO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )403;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&fhValorConImpto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhSecuencia;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    
    return fhValorConImpto;   
}    
/*---------------------------------------------------------------------------*/
/* Rutina para manejo de mensajes de errores Oracle.                         */
/*---------------------------------------------------------------------------*/
void vSqlError_2()
{
   if (!iPl) 
   {
	    /* EXEC SQL ROLLBACK WORK; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )426;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
     if (sqlca.sqlcode < 0) vSqlError_2();
}


	
		fprintf(stderr,"[%d] [%s]\n\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
		fprintf(pfLog ,"[%d] [%s]\n\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
	    exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,iCodError,sqlca.sqlerrm.sqlerrmc,0,0));
	}
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int 	main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
    long  lSegIni, lSegFin;	    
    short ibiblio;	
/*---------------------------------------------------------------------------*/
/* Recuperacion	del tiempo de inicio del proceso, en segundos.			     */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
	memset(&stCiclo, 0, sizeof(reg_ciclo));		
	memset(&stStatusProc, 0, sizeof(rg_estadistica));
	stArgs.bFlagUser     = FALSE;
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
	memset(&stArgs, 0, sizeof(rg_argumentos));
	vManejaArgs(argc, argv);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
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
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);
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

    fprintf(pfLog, "Identificador de Proceso		<%s>\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque			<%s>\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion			<%d>\n", stArgs.izSecuencia);

	fprintf(pfLog, "Base de datos : %s\n\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog,"\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
	/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )441;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}


/*---------------------------------------------------------------------------*/
/*    INICIA PROCESAMIENTO PRINCIPAL.					     				 */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "Inicio procesamiento principal ...\n\n");
    fprintf(stderr, "Inicio procesamiento principal ...\n\n");
/*---------------------------------------------------------------------------*/
/* Carga Parametros generales de proceso                                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Inicio CargaParametros ...\n\n");       
    fprintf(stderr,  "Inicio CargaParametros ...\n\n");       
    vCargaParametros();										   
/*---------------------------------------------------------------------------*/
/* CARGA DATOS DEL PERIODO DE COMISIONES				     				 */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Carga fechas que definen el periodo actual...\n\n");  
    fprintf(stderr, "Carga fechas que definen el periodo actual...\n\n");  
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
		fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
		fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
		fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
		fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
		exit(EXIT_101);
    }
/*--------------------------------------------------------------------------*/
/* Carga Estructura de Conceptos y Tipos de Red	a Procesar...(Estándar)	    */
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Gestiona Carga de Datos y Parametros..\n\n");  
    fprintf(stderr, "Gestiona Carga de Datos y Parametros...\n\n");  
	if (!bCargaConceptos())
	{
		fprintf(stderr,	"\nError Recuperando Lista de Conceptos	de comisiones.\n");
		fprintf(stderr,	"Revise	la parametrizacion.\n");
		fprintf(stderr,	"Proceso finalizado con	error.\n");
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"NO PUEDE	CARGAR LISTA DE	CONCEPTOS DE COMISION.",0,0));
	}    
/*---------------------------------------------------------------------------*/
/*    - Carga universo de evaluaciones a considerar para el calculo.         */
/*---------------------------------------------------------------------------*/
    strcpy(szhIdPeriodo  , stCiclo.szIdCiclComis);
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga universo de evaluaciones a considerar para el calculo....\n\n");     
    fprintf(stderr, "Carga universo de evaluaciones a considerar para el calculo....\n\n");     
	vCreaUniverso();
/*---------------------------------------------------------------------------*/
/*    - Ejecuta la valoracion de los excedentes de evaluacion.               */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Ejecuta la valoracion de los excedentes de evaluacion....\n\n");     
    fprintf(stderr, "Ejecuta la valoracion de los excedentes de evaluacion....\n\n");     
	vValoraExcedentes();
/*---------------------------------------------------------------------------*/
/*    - Inserta los registros en las tablas de resultados.                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Inserta los valores finales en la tabla de valorizados. (CMT_VALORIZADOS)...\n\n");     
    fprintf(stderr, "Inserta los valores finales en la tabla de valorizados. (CMT_VALORIZADOS)...\n\n");     
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de abonados y universsos.        */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Libera memoria utilizada por listas de abonados y universsos...\n\n");     
    fprintf(stderr, "Libera memoria utilizada por listas de abonados y universsos...\n\n");     
	vLiberaUniverso(lstUniverso);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/
	lSegFin=lGetTimer();
	stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
	fprintf(pfLog ,  "\nEstadistica del proceso\n");
	fprintf(pfLog ,  "------------------------\n");
	fprintf(pfLog ,  "Total Habilitaciones Procesadas        : [%d]\n", stStatusProc.lCantEvaluaciones);
	fprintf(pfLog ,  "Segundos Reales Utilizados             : [%d]\n", stStatusProc.lSegProceso);

	fprintf(stderr,  "\nEstadistica del proceso\n");
	fprintf(stderr,  "------------------------\n");
	fprintf(stderr,  "Total Habilitaciones Procesadas        : [%d]\n", stStatusProc.lCantEvaluaciones);
	fprintf(stderr,  "Segundos Reales Utilizados             : [%d]\n", stStatusProc.lSegProceso);

	ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantEvaluaciones);
	if (ibiblio)
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )456;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}



    vFechaHora();
    fprintf(stderr, "Programa [%s] finalizado ok.\n", basename(argv[0]));
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Proceso [%s] finalizado ok.\n", basename(argv[0]));
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

