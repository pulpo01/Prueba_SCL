
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
           char  filnam[24];
};
static struct sqlcxp sqlfpn =
{
    23,
    "./pc/Val_BonoCampana.pc"
};


static unsigned int sqlctx = 443592227;


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
"select A.COD_CATEGVENTA ,A.COD_CATEGCLIENTE ,A.TIP_PLAN  from CM_DETCATEGVEN\
TAS_TD A ,CMD_CATEGPLANES B where (A.TIP_PLAN=B.TIP_PLAN and B.TIP_CICLCOMIS=:\
b0) order by COD_CATEGVENTA            ";

 static char *sq0002 = 
"select VAL_UMBRAL ,IMP_COMISION  from CM_DETCAMPANA_TD where ((((COD_TIPORED\
=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2) and COD_CICLCOMIS=:b3) and C\
OD_COMISIONISTA=:b4) order by VAL_UMBRAL desc             ";

 static char *sq0003 = 
"select distinct A.COD_CATEGVENTA ,A.IND_FECCORTE ,NVL(TO_CHAR(B.FEC_CORTE,'Y\
YYYMMDDHH24MISS'),'0') ,B.COD_COMISIONISTA  from CM_VALCAMPANA_TD A ,CM_DETCAM\
PANA_TD B where (((((((A.COD_TIPORED=:b0 and A.COD_PLANCOMIS=:b1) and A.COD_CO\
NCEPTO=:b2) and A.COD_TIPORED=B.COD_TIPORED) and A.COD_PLANCOMIS=B.COD_PLANCOM\
IS) and A.COD_TIPORED=B.COD_TIPORED) and B.COD_CICLCOMIS=:b3) and B.VAL_UMBRAL\
=(select min(X.VAL_UMBRAL)  from CM_DETCAMPANA_TD X where ((((X.COD_TIPORED=B.\
COD_TIPORED and X.COD_PLANCOMIS=B.COD_PLANCOMIS) and X.COD_CONCEPTO=B.COD_CONC\
EPTO) and X.COD_CICLCOMIS=B.COD_CICLCOMIS) and X.COD_COMISIONISTA=B.COD_COMISI\
ONISTA)))           ";

 static char *sq0004 = 
"select COD_TIPORED ,COD_PLANCOMIS ,COD_CONCEPTO ,COD_VENDEDOR  from CM_DIFCA\
MPANA_TD where IND_CONSIDERA='N' order by COD_VENDEDOR desc             ";

 static char *sq0005 = 
"select A.COD_TIPORED ,A.COD_TIPCOMIS ,A.COD_COMISIONISTA ,A.COD_AGENCIA ,A.N\
UM_GENERAL ,A.NUM_VENTA ,A.NUM_ABONADO ,TO_CHAR(A.FEC_VENTA,'DD-MM-YYYY') ,TO_\
CHAR(A.FEC_VENTA,'YYYYMMDDHH24MISS') ,B.TIP_PLAN ,A.COD_CATEGCLIENTE ,A.COD_TE\
CNOLOGIA  from CMT_HABIL_CELULAR A ,CMD_PLANESTARIF B ,CMD_CATEGPLANES C where\
 ((A.ID_PERIODO=:b0 and A.COD_PLANTARIF=B.COD_PLANTARIF) and B.TIP_PLAN=C.TIP_\
PLAN)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,193,0,9,95,0,0,1,1,0,1,0,1,1,0,0,
24,0,0,1,0,0,13,98,0,0,3,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,
51,0,0,1,0,0,15,124,0,0,0,0,0,1,0,
66,0,0,2,212,0,9,202,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
101,0,0,2,0,0,13,206,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
124,0,0,2,0,0,15,222,0,0,0,0,0,1,0,
139,0,0,3,642,0,9,290,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
170,0,0,3,0,0,13,294,0,0,4,0,0,1,0,2,97,0,0,2,97,0,0,2,4,0,0,2,3,0,0,
201,0,0,3,0,0,15,329,0,0,0,0,0,1,0,
216,0,0,4,148,0,9,370,0,0,0,0,0,1,0,
231,0,0,4,0,0,13,374,0,0,4,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,
262,0,0,4,0,0,15,395,0,0,0,0,0,1,0,
277,0,0,5,404,0,9,472,0,0,1,1,0,1,0,1,97,0,0,
296,0,0,5,0,0,13,476,0,0,12,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
359,0,0,5,0,0,15,510,0,0,0,0,0,1,0,
374,0,0,6,190,0,3,753,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
425,0,0,7,48,0,1,976,0,0,0,0,0,1,0,
440,0,0,8,0,0,30,1123,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las habilitaciones del producto      */
/* prepago para luego pasar a la etapa de acumulacion.                  */ 
/*----------------------------------------------------------------------*/
/* Version 2 - Revision 00.                                             */
/* Inicio: Lunes 01 de Abril del 2001.                                  */
/* Fin:                                                                 */
/* Autor : Fabian Aedo Ramirez                                          */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla       */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y     */
/* COD_PARAMETRO.                                                       */
/************************************************************************/
/* Modificado por Jaime Vargas                                          */
/* Inicio      : Viernes  24 de Enero 2003                              */
/* Descripcion : incorporacion del archivo de log y la creacion   del   */ 
/*               nombre del directorio de Log                           */
/* **********************************************************************/
/* Modificado Fabián Aedo R.                                            */
/* Se incorporan tratamientos de:                                       */
/* - Ciclos Esporádicos                                                 */
/* - Planes de Comisiones                                               */
/* - Red de Ventas                                                      */
/* - Comisión Diferenciada                                              */
/* Versionado CUZCO - Sep-2003.                                         */
/* **********************************************************************/
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Val_BonoCampana.h"
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
/* Declaración e inicialización de lista de conceptos a procesar.            */
/*---------------------------------------------------------------------------*/
stConceptosProc * lstConceptosProc = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA DE CATEGORIAS DE VENTA.                                  */
/*---------------------------------------------------------------------------*/
stCategVentas *  stCargaCategVentas()
{
	stCategVentas  * qaux;
	stCategVentas  * paux;

	int             i;
	short           iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;
	int				iCantReg     = 0;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    char    szhCodCategVenta[MAXFETCH][11];
	    char    szhTipPlan[MAXFETCH][6];
	    char    szhCodCategCliente[MAXFETCH][11];
		char	chTipCiclComis;
		long    lMaxFetch;    		  
	/* EXEC SQL END DECLARE SECTION; */ 

	
	chTipCiclComis = stCiclo.cTipCiclComis;

    lMaxFetch = MAXFETCH;
    qaux 	  = NULL;
    paux      = NULL;

	fprintf(pfLog , "\n\n[stCargaCategVentas] Inicio funcion Carga Categoria de Ventas. Tipo de Ciclo:[%c]\n",chTipCiclComis);
	fprintf(stderr, "\n\n[stCargaCategVentas] Inicio funcion Carga Categoria de Ventas. Tipo de Ciclo:[%c]\n",chTipCiclComis);
	
    /* EXEC SQL DECLARE CUR_CATEGVENTAS CURSOR FOR 
	SELECT A.COD_CATEGVENTA,
           A.COD_CATEGCLIENTE,
           A.TIP_PLAN
    FROM   CM_DETCATEGVENTAS_TD A,
           CMD_CATEGPLANES B
    WHERE  A.TIP_PLAN = B.TIP_PLAN
    AND    B.TIP_CICLCOMIS = :chTipCiclComis
    ORDER  BY COD_CATEGVENTA; */ 

                
    /* EXEC SQL OPEN CUR_CATEGVENTAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
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
    sqlstm.sqhstv[0] = (unsigned char  *)&chTipCiclComis;
    sqlstm.sqhstl[0] = (unsigned long )1;
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


    while(iFetchedRows == iRetrievRows)
    {
	    /* EXEC SQL for :lMaxFetch 
			FETCH CUR_CATEGVENTAS 
				INTO :szhCodCategVenta  , 
					 :szhCodCategCliente,
					 :szhTipPlan; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 3;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )24;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategVenta;
     sqlstm.sqhstl[0] = (unsigned long )11;
     sqlstm.sqhsts[0] = (         int  )11;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodCategCliente;
     sqlstm.sqhstl[1] = (unsigned long )11;
     sqlstm.sqhsts[1] = (         int  )11;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhTipPlan;
     sqlstm.sqhstl[2] = (unsigned long )6;
     sqlstm.sqhsts[2] = (         int  )6;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
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
     if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stCategVentas *) malloc(sizeof(stCategVentas));

			strcpy(paux->szCodCategVenta 	, szfnTrim(szhCodCategVenta[i]));
			strcpy(paux->szCodCategCliente 	, szfnTrim(szhCodCategCliente[i]));
			strcpy(paux->szTipPlan 			, szfnTrim(szhTipPlan[i]));

			fprintf(pfLog , "\tCat. Venta:[%s] = Cat.Cliente[%s] + Cat.PlanTarif.:[%s]\n",paux->szCodCategVenta, paux->szCodCategCliente, paux->szTipPlan);
			fprintf(stderr, "\tCat. Venta:[%s] = Cat.Cliente[%s] + Cat.PlanTarif.:[%s]\n",paux->szCodCategVenta, paux->szCodCategCliente, paux->szTipPlan);
			iCantReg++;

            paux->sgte    = qaux;
            qaux          = paux;
        }
    }
	fprintf(pfLog , "\n\n[stCargaCategVentas] Cantidad de Registros Leidos:[%d].\n",iCantReg);
	fprintf(stderr, "\n\n[stCargaCategVentas] Cantidad de Registros Leidos:[%d].\n",iCantReg);
    /* EXEC SQL CLOSE CUR_CATEGVENTAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )51;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    return qaux;
}
/*---------------------------------------------------------------------------*/
/* Gestiona la carga de Conceptos y Parámetros de Valoración                 */
/*---------------------------------------------------------------------------*/
int bCargaConceptos()
{
	switch (stCiclo.cTipCiclComis)
	{
		case PERIODICO:
		    vFechaHora();                                                                                   
		    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
		    fprintf(pfLog, "Carga lista de conceptos para ejecución Periodica o Normal..\n\n");  
		    fprintf(stderr, "Carga lista de conceptos para ejecución Periodica o Normal...\n\n");  
			lstConceptosProc = stGetConceptosPer(FORMACOMIS,stCiclo);
			return TRUE;
		case ESPORADICO:
		    vFechaHora();                                                                                   
		    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
		    fprintf(pfLog, "Carga lista de conceptos para ejecución Esporádica o Promocional..\n\n");  
		    fprintf(stderr, "Carga lista de conceptos para ejecución Esporádica o Promocional...\n\n");  
			lstConceptosProc = stGetConceptosProm(FORMACOMIS,stCiclo);
			return TRUE;
		default:
		    vFechaHora();                                                                                   
		    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
		    fprintf(pfLog, "Error, Forma de Ejecución:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    fprintf(stderr, "Error, Forma de Ejecución:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
			return FALSE;
	}
	
}
/*---------------------------------------------------------------------------*/
/* CARGA DETALLE DE CONCEPTOS DE CAMPANA (UMBRALES POR COMISIONISTA).        */
/*---------------------------------------------------------------------------*/
stDetConceptos * stCargaDetConceptos(int piTipoRed, char * pszPlanComis ,int piConcepto, long plCiclComis, long plComisionista)
{
	stDetConceptos	* paux;
	stDetConceptos	* qaux;
	int             i;
	short           iLastRows    = 0;
	int				iCantReg     = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
		int		ihCodTipoRed;
		char	szhCodPlanComis[6];
		int		ihCodConcepto;
		long	lhCodCiclComis;
		long	lhCodComisionista;
		double	dhImpComision[MAXFETCH];
		long	lhValUmbral  [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

	
	ihCodTipoRed 			= piTipoRed;
	strcpy(szhCodPlanComis	, pszPlanComis);
	ihCodConcepto			= piConcepto;
	lhCodCiclComis			= plCiclComis;
	lhCodComisionista		= plComisionista;
    
    lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	
	/* EXEC SQL DECLARE CUR_DETCONCEPTOS CURSOR FOR
			SELECT	VAL_UMBRAL	,
					IMP_COMISION
			FROM    CM_DETCAMPANA_TD
			WHERE   COD_TIPORED 		= :ihCodTipoRed
			AND     COD_PLANCOMIS 		= :szhCodPlanComis
			AND     COD_CONCEPTO		= :ihCodConcepto
			AND     COD_CICLCOMIS 		= :lhCodCiclComis
			AND     COD_COMISIONISTA	= :lhCodComisionista
			ORDER BY VAL_UMBRAL DESC; */ 

			
	/* EXEC SQL OPEN CUR_DETCONCEPTOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )66;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
 sqlstm.sqhstl[1] = (unsigned long )6;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclComis;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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



    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch 
			FETCH CUR_DETCONCEPTOS 
			INTO :lhValUmbral, :dhImpComision; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )101;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhValUmbral;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)dhImpComision;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )sizeof(double);
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
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
                paux = (stDetConceptos *) malloc(sizeof(stDetConceptos));
                paux->lValUmbral  	= lhValUmbral[i];
                paux->dImpComision	= dhImpComision[i];
                paux->sgte          = qaux;
                qaux                = paux;
        }
    }
    /* EXEC SQL CLOSE CUR_DETCONCEPTOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )124;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    return qaux;
}
/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA LOCAL DE CONCEPTOS DE VALORACION DE CAMPAÑA.             */
/*---------------------------------------------------------------------------*/
stConceptos * stCargaConceptosLocal()
{
	stConceptosProc	* paux;
	stConceptos		* qaux;
	stConceptos		* raux;

	int             i;
	int				iCantReg     = 0;
	short           iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
		int		ihCodTipoRed;
		char	szhCodPlanComis  [6];
		int		ihCodConcepto;
		long	lhCodCiclComis;
		char    szhCodCategVenta [MAXFETCH][11];
		char	chIndFechaCorte  [MAXFETCH][2];
		double	dhFechaCorte     [MAXFETCH];
		long	lhCodComisionista[MAXFETCH];
		char	szhCodTipComis	 [3];		
    /* EXEC SQL END DECLARE SECTION; */ 
	

	paux = NULL;
	qaux = NULL;
	raux = NULL;

	for (paux = lstConceptosProc; paux != NULL; paux = paux->sgte)
	{
		ihCodTipoRed			= paux->iCodTipoRed;
		strcpy(szhCodPlanComis 	, paux->szCodPlanComis);
		ihCodConcepto			= paux->iCodConcepto;
		lhCodCiclComis			= stCiclo.lCodCiclComis;

		lMaxFetch = MAXFETCH;
		iLastRows    = 0;              
		iFetchedRows = MAXFETCH;       
		iRetrievRows = MAXFETCH;       
		/* EXEC SQL DECLARE CUR_CONCEPTOS CURSOR FOR
			SELECT	DISTINCT
					A.COD_CATEGVENTA,
					A.IND_FECCORTE,
					NVL(TO_CHAR(B.FEC_CORTE,'YYYYMMDDHH24MISS'),'0'),
					B.COD_COMISIONISTA
			FROM 	CM_VALCAMPANA_TD A,
					CM_DETCAMPANA_TD B
			WHERE 	A.COD_TIPORED   = :ihCodTipoRed
			AND 	A.COD_PLANCOMIS = :szhCodPlanComis
			AND 	A.COD_CONCEPTO  = :ihCodConcepto
			AND 	A.COD_TIPORED 	= B.COD_TIPORED
			AND 	A.COD_PLANCOMIS = B.COD_PLANCOMIS
			AND 	A.COD_TIPORED 	= B.COD_TIPORED
			AND 	B.COD_CICLCOMIS = :lhCodCiclComis
			AND     B.VAL_UMBRAL 	= (SELECT MIN(X.VAL_UMBRAL)
					FROM CM_DETCAMPANA_TD X
					WHERE X.COD_TIPORED      = B.COD_TIPORED
					AND   X.COD_PLANCOMIS    = B.COD_PLANCOMIS
					AND   X.COD_CONCEPTO     = B.COD_CONCEPTO
					AND   X.COD_CICLCOMIS 	 = B.COD_CICLCOMIS
					AND   X.COD_COMISIONISTA = B.COD_COMISIONISTA); */ 

		/* EXEC SQL OPEN CUR_CONCEPTOS; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0003;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )139;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
  sqlstm.sqhstl[1] = (unsigned long )6;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclComis;
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
  if (sqlca.sqlcode < 0) vSqlError();
}



        while(iFetchedRows == iRetrievRows)
        {
			/* EXEC SQL for :lMaxFetch 
					FETCH CUR_CONCEPTOS 
					INTO  :szhCodCategVenta, :chIndFechaCorte, 
						  :dhFechaCorte    , :lhCodComisionista; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )lMaxFetch;
   sqlstm.offset = (unsigned int  )170;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategVenta;
   sqlstm.sqhstl[0] = (unsigned long )11;
   sqlstm.sqhsts[0] = (         int  )11;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)chIndFechaCorte;
   sqlstm.sqhstl[1] = (unsigned long )2;
   sqlstm.sqhsts[1] = (         int  )2;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)dhFechaCorte;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[2] = (         int  )sizeof(double);
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)lhCodComisionista;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )sizeof(long);
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
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
   if (sqlca.sqlcode < 0) vSqlError();
}



            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];
            for (i=0; i < iRetrievRows; i++)
            {
                    qaux = (stConceptos *) malloc(sizeof(stConceptos));
                    
                    strcpy(qaux->szCodCategVenta 	, szfnTrim(szhCodCategVenta[i]));
                    strcpy(qaux->cIndFechaCorte  	, szfnTrim(chIndFechaCorte[i]));
                    qaux->dFechaCorte     			= dhFechaCorte[i];
                    qaux->lCodComisionista			= lhCodComisionista[i];
                    qaux->iCodTipoRed				= paux->iCodTipoRed;
                    strcpy(qaux->szCodTipComis		, paux->szCodTipComis);
                    strcpy(qaux->szCodPlanComis		, paux->szCodPlanComis);
                    qaux->iCodConcepto				= paux->iCodConcepto;
                    strcpy(qaux->szCodTecnologia	, paux->szCodTecnologia);
                    qaux->dFecDesde 				= paux->dFecDesde;	
                    qaux->dFecHasta 				= paux->dFecHasta;
                    strcpy(qaux->szFecDesde			, paux->szFecDesde);
                    strcpy(qaux->szFecHasta			, paux->szFecHasta);
                    strcpy(qaux->szCodUniverso		, paux->szCodUniverso);
                    qaux->lCantVentasCorte 			= 0;
                    qaux->lCantVentasTotal			= 0;
                    qaux->dImpConcepto				= 0.00;
                    qaux->sgte_venta				= NULL;
                    qaux->sgte_detalle				= stCargaDetConceptos(ihCodTipoRed, szhCodPlanComis , ihCodConcepto, lhCodCiclComis, qaux->lCodComisionista);
                    
                    qaux->sgte                  	= raux;
                    raux                        	= qaux;
            }
        }
        /* EXEC SQL CLOSE CUR_CONCEPTOS; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )201;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


	}
	return raux;
}
/*---------------------------------------------------------------------------*/
/* CARGA LISTA DE VENDEDORES CON COMISION DIFERENCIADA.                      */
/*---------------------------------------------------------------------------*/
stDiferenciada * stCargaDiferenciada()
{
	stDiferenciada	* paux;
	stDiferenciada	* qaux;

	int             i;
	int				iCantReg     = 0;
	short           iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
		int		ihCodTipoRed   [MAXFETCH];
		char	szhCodPlanComis[MAXFETCH][6];
		int		ihCodConcepto  [MAXFETCH];
		long	lhCodVendedor  [MAXFETCH];		
		double	dhImpComision  [MAXFETCH];
		long	lhValUmbral    [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

	    
    lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	
	/* EXEC SQL DECLARE CUR_DIFERENCIADA CURSOR FOR
		SELECT	COD_TIPORED,
				COD_PLANCOMIS,
				COD_CONCEPTO,
				COD_VENDEDOR
		FROM	CM_DIFCAMPANA_TD
		WHERE 	IND_CONSIDERA = 'N'
		ORDER BY COD_VENDEDOR DESC; */ 

			
	/* EXEC SQL OPEN CUR_DIFERENCIADA; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}



    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch 
			FETCH CUR_DIFERENCIADA 
			INTO :ihCodTipoRed , :szhCodPlanComis, 
				 :ihCodConcepto, :lhCodVendedor  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )231;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )6;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ihCodConcepto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhCodVendedor;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
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
  if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
             paux = (stDiferenciada *) malloc(sizeof(stDiferenciada));

             paux->iCodTipoRed  	= ihCodTipoRed[i];
             paux->iCodConcepto	= ihCodConcepto[i];
             paux->lCodVendedor	= lhCodVendedor[i];
             strcpy(paux->szCodPlanComis	, szfnTrim(szhCodPlanComis[i]));
                
             paux->sgte          = qaux;
             qaux                = paux;
        }
    }
    /* EXEC SQL CLOSE CUR_DIFERENCIADA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )262;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    return qaux;
}
/*---------------------------------------------------------------------------*/
/* Obtiene la categoria de venta de un plan TipoPlan/CategCliente            */
/*---------------------------------------------------------------------------*/
char * szObtieneCatVenta(stCategVentas * paux, char * pszTipPlan, char * pszCodCategCliente)
{
	if (paux == NULL)
		return NOCATEG;
	if(strcmp(paux->szTipPlan,pszTipPlan)==0 && strcmp(paux->szCodCategCliente,pszCodCategCliente)==0)
		return paux->szCodCategVenta;
	else
		return szObtieneCatVenta(paux->sgte, pszTipPlan, pszCodCategCliente);
}
/*---------------------------------------------------------------------------*/
/* CARGA VENTAS DEL PERIODO.                                                 */
/* SOLO LAS QUE POSEEN TIPO DE PLAN CONFIGURADO EN EL TIPO DE CICLO QUE SE   */
/* ESTA EJECUTANDO.                                                          */
/*---------------------------------------------------------------------------*/
stVentas * stCargaVentas()
{
	stVentas	* paux;
	stVentas	* qaux;
	int         i;
	long		lCantReg 	 = 0;
	short       iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
		char	chTipCiclComis;
		char	szhIdCiclComis    [11];
		int		ihCodTipoRed      [MAXFETCH];
		char	szhCodTipComis    [MAXFETCH][3];
		long	lhCodComisionista [MAXFETCH];
		long	lhCodVendedor     [MAXFETCH];	
		long    lhNumGeneral      [MAXFETCH];
		long    lhNumVenta        [MAXFETCH];
		long    lhNumAbonado      [MAXFETCH];
		char    szhTipPlan        [MAXFETCH][6];
		char    szhCodCategCliente[MAXFETCH][11];
		char	szhFecVenta		  [MAXFETCH][11];
		double	dhFecVenta        [MAXFETCH];
		char	szhCodTecnologia  [MAXFETCH][8];
    /* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhIdCiclComis	, stCiclo.szIdCiclComis);
    chTipCiclComis			= stCiclo.cTipCiclComis;

    lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	fprintf(pfLog ,"\n\n[stCargaVentas]Inicio de Carga de Ventas Contrato. Ciclo:[%s] Tipo:[%c]\n", szhIdCiclComis, chTipCiclComis );
	fprintf(stderr,"\n\n[stCargaVentas]Inicio de Carga de Ventas Contrato. Ciclo:[%s] Tipo:[%c]\n", szhIdCiclComis, chTipCiclComis );

	/* EXEC SQL DECLARE CUR_VENTAS CURSOR FOR
		SELECT	A.COD_TIPORED,
				A.COD_TIPCOMIS,
				A.COD_COMISIONISTA,
				A.COD_AGENCIA,
				A.NUM_GENERAL,
				A.NUM_VENTA,
				A.NUM_ABONADO,
				TO_CHAR(A.FEC_VENTA,'DD-MM-YYYY'),
				TO_CHAR(A.FEC_VENTA,'YYYYMMDDHH24MISS'),
				B.TIP_PLAN,
				A.COD_CATEGCLIENTE,
				A.COD_TECNOLOGIA
		   FROM CMT_HABIL_CELULAR A,
			    CMD_PLANESTARIF B,
				CMD_CATEGPLANES C
		  WHERE A.ID_PERIODO 		= :szhIdCiclComis
		  AND   A.COD_PLANTARIF 	= B.COD_PLANTARIF
		  AND   B.TIP_PLAN 		= C.TIP_PLAN; */ 

			
	/* EXEC SQL OPEN CUR_VENTAS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0005;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )277;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhIdCiclComis;
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



    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch 
			FETCH CUR_VENTAS 
			INTO :ihCodTipoRed     , :szhCodTipComis, 
				 :lhCodComisionista, :lhCodVendedor ,
 				 :lhNumGeneral     , :lhNumVenta    ,
				 :lhNumAbonado	   , :szhFecVenta   , :dhFecVenta    ,
				 :szhTipPlan       , :szhCodCategCliente, 
				 :szhCodTecnologia; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )296;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
  sqlstm.sqhstl[1] = (unsigned long )3;
  sqlstm.sqhsts[1] = (         int  )3;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhCodComisionista;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhCodVendedor;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)lhNumGeneral;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )sizeof(long);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )sizeof(long);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )sizeof(long);
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhFecVenta;
  sqlstm.sqhstl[7] = (unsigned long )11;
  sqlstm.sqhsts[7] = (         int  )11;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)dhFecVenta;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[8] = (         int  )sizeof(double);
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhTipPlan;
  sqlstm.sqhstl[9] = (unsigned long )6;
  sqlstm.sqhsts[9] = (         int  )6;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhCodCategCliente;
  sqlstm.sqhstl[10] = (unsigned long )11;
  sqlstm.sqhsts[10] = (         int  )11;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[11] = (unsigned long )8;
  sqlstm.sqhsts[11] = (         int  )8;
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
  if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stVentas *) malloc(sizeof(stVentas));

            paux->iCodTipoRed  				= ihCodTipoRed[i];
            strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
            paux->lCodComisionista			= lhCodComisionista[i];
            paux->lCodVendedor				= lhCodVendedor[i];
            paux->lNumGeneral				= lhNumGeneral[i];
            paux->lNumVenta					= lhNumVenta[i];
            paux->lNumAbonado				= lhNumAbonado[i];
            strcpy(paux->szTipPlan			, szfnTrim(szhTipPlan[i]));
            strcpy(paux->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
			strcpy(paux->szCodCategVenta	, szObtieneCatVenta(lstCategVentas, paux->szTipPlan, paux->szCodCategCliente));
            strcpy(paux->szFecVenta			, szfnTrim(szhFecVenta[i]));
            paux->dFecVenta					= dhFecVenta[i];
            strcpy(paux->szCodTecnologia	, szfnTrim(szhCodTecnologia[i]));
            lCantReg++;
            paux->sgte          = qaux;
            qaux                = paux;
        }
    }
    /* EXEC SQL CLOSE CUR_VENTAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )359;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog ,"\t[stCargaVentas]Cantidad de Ventas recuperadas:[%ld]\n",lCantReg);
    fprintf(stderr,"\t[stCargaVentas]Cantidad de Ventas recuperadas:[%ld]\n",lCantReg);
    stStatusProc.lCantRegistros = lCantReg;
    return qaux;
}
/*----------------------------------------------------------------------------*/
/* Para asociar una venta a un nodo de valoración, se debe cumplir:			  */
/* - Tipo de Red y Tipo de Comisionista y Comisionista, coincidentes          */
/* - Tecnologia del equipo debe ser idéntica o Tecnología del conc. = NOTECNO */
/* - Fecha de Venta estar contenida en las fechas de vigencia del concepto    */
/* - Categoria de la Venta coincidente                                        */
/*----------------------------------------------------------------------------*/
int bValidaVenta(stConceptos * paux, stVentas * qaux)
{
	
	if((paux->iCodTipoRed != qaux->iCodTipoRed)||(strcmp(paux->szCodTipComis,qaux->szCodTipComis)!=0)
	  ||(paux->lCodComisionista != qaux->lCodComisionista))
	  	return FALSE;

/*	fprintf(pfLog ,"\n[bValidaVenta] Analiza Tr:[%d] PlComis:[%s] Concepto:[%d] CatVenta:[%s] Tecno:[%s]",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->szCodCategVenta, paux->szCodTecnologia); */
/*	fprintf(stderr,"\n[bValidaVenta] Analiza Tr:[%d] PlComis:[%s] Concepto:[%d] CatVenta:[%s] Tecno:[%s]",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->szCodCategVenta, paux->szCodTecnologia); */

	if (!((strcmp(paux->szCodTecnologia, qaux->szCodTecnologia)==0) || (strcmp(paux->szCodTecnologia, NOTECNOLOGIA)==0)))
		return FALSE;

	if (strcmp(paux->szCodCategVenta, qaux->szCodCategVenta)!=0)
		return FALSE;

	if (!bValidaFechaEvento (paux->szFecDesde, paux->szFecHasta, qaux->szFecVenta))
	{
		fprintf(pfLog , "\n[bValidaVenta] Abonado:[%d] Venta fuera de Vigencia Desde:[%s] Hasta:[%s] Venta:[%s]\n", qaux->lNumAbonado, paux->szFecDesde, paux->szFecHasta, qaux->szFecVenta);
		fprintf(stderr, "\n[bValidaVenta] Abonado:[%d] Venta fuera de Vigencia Desde:[%s] Hasta:[%s] Venta:[%s]\n", qaux->lNumAbonado, paux->szFecDesde, paux->szFecHasta, qaux->szFecVenta);
		return FALSE;
	}		
	return TRUE;
}
/*---------------------------------------------------------------------------*/
/* Reproduce un nodo de venta, para asignarlo a la estructura de tasación.   */
/*---------------------------------------------------------------------------*/
stVentas * stCreaNodoVenta(stVentas * paux)
{
	stVentas		* raux;
	
	raux = (stVentas *) malloc(sizeof(stVentas));
	raux->sgte = NULL;

	strcpy(raux->szCodTipComis    	, paux->szCodTipComis);
	strcpy(raux->szTipPlan        	, paux->szTipPlan);
	strcpy(raux->szCodCategCliente	, paux->szCodCategCliente);
	strcpy(raux->szCodCategVenta 	, paux->szCodCategVenta);
	raux->lNumGeneral      			= paux->lNumGeneral;
	raux->iCodTipoRed      			= paux->iCodTipoRed;
	raux->lCodComisionista 			= paux->lCodComisionista;
	raux->lCodVendedor     			= paux->lCodVendedor;
	raux->lNumVenta        			= paux->lNumVenta;
	raux->lNumAbonado      			= paux->lNumAbonado;
	raux->dFecVenta        			= paux->dFecVenta;
	raux->dImpComision     			= paux->dImpComision;
	
	return raux;
}
/*---------------------------------------------------------------------------*/
/* Evalua si vendedor de la venta qaux posee comisión diferenciada por propie*/
/* dad de la oficina donde opera.                                           -*/
/*---------------------------------------------------------------------------*/
int bComisDiferenciada(long lVendedor, int iTipoRed, char * szPlanComis, int iConcepto, stDiferenciada * paux)
{
	if (paux==NULL)
		return FALSE;
	
	if ((paux->iCodTipoRed==iTipoRed)&&(strcmp(paux->szCodPlanComis,szPlanComis)==0)&&(paux->iCodConcepto==iConcepto)&&(paux->lCodVendedor==lVendedor))
		return TRUE;
	else
		return (bComisDiferenciada(lVendedor,iTipoRed,szPlanComis,iConcepto,paux->sgte));
}
/*---------------------------------------------------------------------------*/
/* Asigna las ventas a la estructura de valoración.                          */
/*---------------------------------------------------------------------------*/
void vAsignaVentas()
{
	stConceptos		* paux;
	stVentas		* qaux;
	stVentas		* raux;
	int				iNoCateg = 0;
	int				iDiferenciada = 0;
	
	fprintf(pfLog ,"\n[vAsignaVentas]Inicio de Asignacion de Ventas a Estructura de Valoracion.\n");
	fprintf(stderr,"\n[vAsignaVentas]Inicio de Asignacion de Ventas a Estructura de Valoracion.\n");
	for(qaux = lstVentas; qaux != NULL; qaux = qaux->sgte)
	{
		if (strcmp(qaux->szCodCategVenta, NOCATEG)!=0)
		{
/*			fprintf(pfLog ,"\n[vAsignaVentas] Analiza Tr:[%d] Comis:[%d] Abonado:[%d] CatVenta:[%s] FecVenta:[%s] Tecno:[%s]\n",qaux->iCodTipoRed, qaux->lCodComisionista, qaux->lNumAbonado, qaux->szCodCategVenta, qaux->szFecVenta, qaux->szCodTecnologia);  */
/*			fprintf(stderr,"\n[vAsignaVentas] Analiza Tr:[%d] Comis:[%d] Abonado:[%d] CatVenta:[%s] FecVenta:[%s] Tecno:[%s]\n",qaux->iCodTipoRed, qaux->lCodComisionista, qaux->lNumAbonado, qaux->szCodCategVenta, qaux->szFecVenta, qaux->szCodTecnologia);	*/
			for (paux = lstConceptos; paux != NULL; paux = paux->sgte)
			{
				if (bValidaVenta(paux,qaux))
				{
					/* Evalua comision diferenciada */
					if (!bComisDiferenciada(qaux->lCodVendedor,paux->iCodTipoRed,paux->szCodPlanComis,paux->iCodConcepto,lstDiferenciada))
					{
						raux = stCreaNodoVenta(qaux);
						raux->sgte = paux->sgte_venta;
						paux->sgte_venta = raux;
						
						paux->lCantVentasTotal++;
						if (strcmp(paux->cIndFechaCorte , "S")==0)
						{
							if (raux->dFecVenta <= paux->dFechaCorte)
								paux->lCantVentasCorte++;
						}
					}
					else
					{
						iDiferenciada++;
						fprintf(pfLog ,"\t[vAsignaVentas]Abonado:[%ld] Vendedor:[%ld] NO SERA CONSIDERADA Concepto:[%d].\n", qaux->lNumAbonado, qaux->lCodVendedor, paux->iCodConcepto);
						fprintf(stderr,"\t[vAsignaVentas]Abonado:[%ld] Vendedor:[%ld] NO SERA CONSIDERADA Concepto:[%d].\n", qaux->lNumAbonado, qaux->lCodVendedor, paux->iCodConcepto);
					}
				}
			}
		}
		else
		{
			fprintf(pfLog ,"\t[vAsignaVentas]Abonado:[%ld] Vendedor:[%ld] TipPlan:[%s] CatCliente:[%s] CatVenta:[%s] NO SERA CONSIDERADA .\n", qaux->lNumAbonado, qaux->lCodVendedor,qaux->szTipPlan, qaux->szCodCategCliente, qaux->szCodCategVenta);
			fprintf(stderr,"\t[vAsignaVentas]Abonado:[%ld] Vendedor:[%ld] TipPlan:[%s] CatCliente:[%s] CatVenta:[%s] NO SERA CONSIDERADA .\n", qaux->lNumAbonado, qaux->lCodVendedor,qaux->szTipPlan, qaux->szCodCategCliente, qaux->szCodCategVenta);
			iNoCateg++;
		}
	}
	
	stStatusProc.lCantNOCATEG = iNoCateg;
	stStatusProc.lCantDIFEREN = iDiferenciada;
	fprintf(pfLog ,"\n[vAsignaVentas]Termino la Asignacion de Ventas a Estructura de Valoracion.\n");
	fprintf(stderr,"\n[vAsignaVentas]Termino la Asignacion de Ventas a Estructura de Valoracion.\n");
}
/*---------------------------------------------------------------------------*/
/* En función de la cantidad de ventas, determina la comisión que le         */
/* corresponde, desde el detalle de umbrales de comision.                    */
/*---------------------------------------------------------------------------*/
double dObtieneImporte(stDetConceptos * paux, long lCantVentas)
{
	stDetConceptos * qaux;

	double 	dImporte  = 0.00;
	long 	lCantidad = 0;
	
	qaux = paux;
	while(qaux != NULL)
	{
		if (lCantVentas >= qaux->lValUmbral)
		{
			if (qaux->lValUmbral > lCantidad)
			{
				lCantidad = qaux->lValUmbral;
				dImporte  = qaux->dImpComision;
			}
		}
		qaux = qaux->sgte;
	}
	return dImporte;
}
/*---------------------------------------------------------------------------*/
/* Asigna el importe de comision a la lista de ventas del concepto, y retorna*/
/* el importe acumulado.                                                     */
/*---------------------------------------------------------------------------*/
double dAsignaImporte(stVentas * paux, double dImporte)
{
	stVentas * qaux;
	double	dImpConcepto = 0.00;

	for (qaux = paux; qaux != NULL; qaux = qaux->sgte)
	{
		qaux->dImpComision = dImporte;
		dImpConcepto+=dImporte;
	}
	return dImpConcepto;
}
/*---------------------------------------------------------------------------*/
/* Ejecuta valoración de ventas, de acuerdo a patrones cargados en TASADOR.  */
/*---------------------------------------------------------------------------*/
void vEjecutaValoracion()
{
	stConceptos		* paux;
	stVentas		* qaux;
	double			dImpComision = 0.00;
	
	for(paux = lstConceptos; paux != NULL; paux = paux->sgte)
	{
		if (strcmp(paux->cIndFechaCorte , "S")==0)
			dImpComision = dObtieneImporte(paux->sgte_detalle, paux->lCantVentasCorte);
		else
			dImpComision = dObtieneImporte(paux->sgte_detalle, paux->lCantVentasTotal);
		paux->dImpConcepto = dAsignaImporte(paux->sgte_venta, dImpComision);
	}
}
/*---------------------------------------------------------------------------*/
/* Insercion de valores en tabla CMT_VALORIZADOS                             */
/*---------------------------------------------------------------------------*/
void vInsertaValorizados()
{
    stConceptos 	* paux;
    stVentas        * qaux;
	int	 iCantidad = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodPeriodo;
         char    szhIdPeriodo[11];
         char    szhCodUniverso[7];
         char    szhCodTipComis[3];
         long    lhCodComisionista;
         int     ihCodConcepto;
         int	 ihCodTipoRed;
         long    lhNumGeneral;
         double  dhImpComision;     
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodPeriodo           = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo    , stCiclo.szIdCiclComis);
    
    for (paux = lstConceptos; paux != NULL; paux = paux->sgte)
    {
        strcpy(szhCodTipComis  	, paux->szCodTipComis);
        lhCodComisionista      	= paux->lCodComisionista;
		ihCodConcepto			= paux->iCodConcepto;
		ihCodTipoRed			= paux->iCodTipoRed;
    	strcpy(szhCodUniverso  	, paux->szCodUniverso);

		for (qaux = paux->sgte_venta; qaux != NULL; qaux = qaux->sgte)
		{
			lhNumGeneral    = qaux->lNumGeneral;
			dhImpComision   = fnCnvDouble(qaux->dImpComision,0);
			iCantidad ++;
			
/* fprintf(pfLog, "+++++++++++++++++++++++++++++++[%d]++++++++++++++++++++++++++++++++++++\n",iCantidad );*/
/* fprintf(pfLog, "[vInsertaValorizados] lhNumGeneral      :[%ld]\n",lhNumGeneral         );              */
/* fprintf(pfLog, "[vInsertaValorizados] szhCodUniverso    :[%s]\n",szhCodUniverso       );               */
/* fprintf(pfLog, "[vInsertaValorizados] ihCodConcepto     :[%d]\n",ihCodConcepto        );               */
/* fprintf(pfLog, "[vInsertaValorizados] szhCodTipComis    :[%s]\n",szhCodTipComis       );               */
/* fprintf(pfLog, "[vInsertaValorizados] lhCodComisionista :[%d]\n",lhCodComisionista    );               */
/* fprintf(pfLog, "[vInsertaValorizados] lhCodPeriodo      :[%d]\n",lhCodPeriodo         );               */
/* fprintf(pfLog, "[vInsertaValorizados] szhIdPeriodo      :[%s]\n",szhIdPeriodo         );               */
/* fprintf(pfLog, "[vInsertaValorizados] dhImpComision     :[%6.2f]\n",dhImpComision        );            */
/* fprintf(pfLog, "[vInsertaValorizados] ihCodTipoRed		:[%d]\n",ihCodTipoRed		  );		      */
		
			/* EXEC SQL INSERT INTO CMT_VALORIZADOS (
		        NUM_GENERAL , COD_UNIVERSO    , COD_CONCEPTO,
				COD_TIPCOMIS, COD_COMISIONISTA, COD_PERIODO ,
				ID_PERIODO  , IMP_CONCEPTO    , COD_TIPORED) 
			VALUES 
		        (:lhNumGeneral  , :szhCodUniverso   , :ihCodConcepto,
				 :szhCodTipComis, :lhCodComisionista, :lhCodPeriodo ,
 				 :szhIdPeriodo  , :dhImpComision    , :ihCodTipoRed); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_UNIVERSO,COD_\
CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP_CONCEPTO,COD\
_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )374;
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
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodTipoRed;
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
   if (sqlca.sqlcode < 0) vSqlError();
}


		}
	}
	stStatusProc.lCantVentas = iCantidad;
}
/*---------------------------------------------------------------------------*/
/* Muestra estructura de valoración.                                         */
/*---------------------------------------------------------------------------*/
void vMuestraConceptos(stConceptos * lstConceptos)
{
	stConceptos * paux;
	stDetConceptos * qaux;
	int	i = 0;

	fprintf(pfLog , "\n\n[vMuestraConceptos]Resumen de comisiones Bono Campana\n");
	fprintf(stderr, "\n\n[vMuestraConceptos]Resumen de comisiones Bono Campana\n");
	for(paux = lstConceptos; paux!= NULL; paux = paux->sgte)
	{
		i++;
		fprintf(pfLog , "[-----------------------------------------[%d]------------------------------------------------]\n", i);
		fprintf(stderr, "[-----------------------------------------[%d]------------------------------------------------]\n", i);
		fprintf(pfLog , "[vMuestraConceptos] TR[%d] Conc[%d] Comis[%d] IndFecCorte[%s] VtasCorte[%ld] VtasTotal[%ld] Comision[%6.2f]\n", paux->iCodTipoRed, paux->iCodConcepto, paux->lCodComisionista, paux->cIndFechaCorte, paux->lCantVentasCorte, paux->lCantVentasTotal, paux->dImpConcepto);
		fprintf(stderr, "[vMuestraConceptos] TR[%d] Conc[%d] Comis[%d] IndFecCorte[%s] VtasCorte[%ld] VtasTotal[%ld] Comision[%6.2f]\n", paux->iCodTipoRed, paux->iCodConcepto, paux->lCodComisionista, paux->cIndFechaCorte, paux->lCantVentasCorte, paux->lCantVentasTotal, paux->dImpConcepto);
		fprintf(pfLog , "\tUmbrales:\n");
		fprintf(stderr, "\tUmbrales:\n");
		for (qaux = paux->sgte_detalle; qaux != NULL; qaux = qaux->sgte)
		{
			fprintf(pfLog , "\tUmbral:[%d] Comision:$[%6.2f]\n", qaux->lValUmbral, qaux->dImpComision);
			fprintf(stderr, "\tUmbral:[%d] Comision:$[%6.2f]\n", qaux->lValUmbral, qaux->dImpComision);
		}
	}
}
/*---------------------------------------------------------------------------*/
/* Libera memoria utilizada por lista con valoración diferenciada.           */
/*---------------------------------------------------------------------------*/
void vLiberaDiferenciada(stDiferenciada * paux)
{
	if (paux==NULL)
		return;
	vLiberaDiferenciada(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Libera memoria utilizada por lista de categorías de venta.                */
/*---------------------------------------------------------------------------*/
void vLiberaCategVenta(stCategVentas * paux)
{
	if (paux==NULL)
		return;
	vLiberaCategVenta(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Libera memoria utilizada por lista de categorías de venta.                */
/*---------------------------------------------------------------------------*/
void vLiberaVentas(stVentas * paux)
{
	stVentas * qaux;
	
	if (paux==NULL)
		return;
	
	qaux = paux->sgte;
	while (qaux != NULL)
	{
		free(paux);
		paux = qaux;
		qaux = paux->sgte;
	}
	if (paux != NULL)
		free (qaux);
}
/*---------------------------------------------------------------------------*/
/* Libera sublista de detalle de conceptos.                                  */
/*---------------------------------------------------------------------------*/
void vLiebraDetalle(stDetConceptos * paux)
{
	if (paux == NULL)
		return;
	
	vLiebraDetalle(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Libera estructura de conceptos locales, utilizada como TASADOR.           */
/*---------------------------------------------------------------------------*/
void vLiberaConceptosLocal(stConceptos * paux)
{
	stConceptos * qaux;
	
	if (paux == NULL)
		return;
	while ((qaux = paux->sgte)!=NULL)
	{
		vLiberaVentas(paux->sgte_venta);
		vLiebraDetalle(paux->sgte_detalle);
		free(paux);
		paux = qaux;
		qaux = paux->sgte;
	}
	if (paux!=NULL)
	{
		vLiberaVentas(paux->sgte_venta);
		vLiebraDetalle(paux->sgte_detalle);
		free(paux);
	}
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));
    memset(&stCiclo, 0, sizeof(reg_ciclo));
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
    memset(&proceso, 0, sizeof(proceso));
    stArgs.bFlagUser     = FALSE;
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
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
		fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);                                   
		fprintf(stderr, "Revise su existencia.\n");                                                            
		fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                  
		fprintf(stderr, "Proceso finalizado con error.\n");                                                    
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE DATOS NO PUDO SER ABIERTO.",0,0));   
	}                                                                                               
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
        lSegIni=lGetTimer();
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
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )425;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

        
/*---------------------------------------------------------------------------*/
/* Procesamiento principal.                                                  */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inicio procesamiento principal ...\n\n");
/*--------------------------------------------------------------------------*/
/* Carga Fechas de periodo a procesar                                       */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Carga fechas que definen el periodo actual...\n\n");  
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
/* Carga Estructura de Conceptos y Tipos de Red a Procesar...(Estándar)     */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Gestiona Carga de Datos y Parámetros..\n\n");  
    fprintf(stderr, "Gestiona Carga de Datos y Parámetros...\n\n");  
	if (!bCargaConceptos())
	{
        fprintf(stderr, "\nError Recuperando Lista de Conceptos de comisiones.\n");
        fprintf(stderr, "Revise la parametrización.\n");
        fprintf(stderr, "Proceso finalizado con error.\n");
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"NO PUEDE CARGAR LISTA DE CONCEPTOS DE COMISION.",0,0));
	}
/*--------------------------------------------------------------------------*/
/* Carga Estructura de Conceptos y Tipos de Red a Procesar...(LOCAL)        */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog ,"Carga Estructura de Conceptos y Tipos de Red a Procesar...(LOCAL)\n\n");  
    fprintf(stderr,"Carga Estructura de Conceptos y Tipos de Red a Procesar...(LOCAL)\n\n");  
	lstConceptos = stCargaConceptosLocal();
/*--------------------------------------------------------------------------*/
/* Carga Detalle de vendedores con comision diferenciada para el periodo.   */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog ,"Carga Detalle de vendedores con comision diferenciada para el periodo.\n\n");  
    fprintf(stderr,"Carga Detalle de vendedores con comision diferenciada para el periodo.\n\n");  
	lstDiferenciada = stCargaDiferenciada();
/*--------------------------------------------------------------------------*/
/* Carga Estructura de Categorias de Ventas                                 */
/*--------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Carga Estructura de Categorias de Ventas..\n\n");  
    fprintf(stderr, "Carga Estructura de Categorias de Ventas...\n\n");  
	lstCategVentas = stCargaCategVentas();
/*--------------------------------------------------------------------------*/
/* Carga Ventas a ser procesadas en el periodo                              */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Carga Ventas a ser procesadas en el periodo..\n\n");  
    fprintf(stderr,"Carga Ventas a ser procesadas en el periodo...\n\n");  
	lstVentas = stCargaVentas();
/*--------------------------------------------------------------------------*/
/* Asigna ventas a cada nodo de la estructura de valoración.                */
/*--------------------------------------------------------------------------*/	
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Asigna ventas a la estructura de Valoracion..\n\n");  
    fprintf(stderr,"Asigna ventas a la estructura de Valoracion...\n\n");  
	vAsignaVentas();
/*---------------------------------------------------------------------------*/
/* Ejecuta la valoracion de eventos contenidos en estructura principal.      */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Ejecuta la valoracion Eventos...\n\n");
    fprintf(stderr, "Ejecuta la valoracion Eventos...\n\n");
    vEjecutaValoracion();
/*---------------------------------------------------------------------------*/
/* Muestra resumen de valoración de eventos.                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Muestra resumen de valoración de eventos.\n\n");
    fprintf(stderr, "Muestra resumen de valoración de eventos.\n\n");        
    vMuestraConceptos(lstConceptos);
/*---------------------------------------------------------------------------*/
/* Inserta los registros en la tabla de resultados.                          */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inserta los registros en la tabla de resultados. (CMT_VALORIZADOS)...\n\n");
    fprintf(stderr, "Inserta los registros en la tabla de resultados. (CMT_VALORIZADOS)...\n\n");        
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/* Libera memoria utilizada por listas de abonados y universsos.             */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada por listas de abonados y universos...\n\n");
    fprintf(stderr, "Libera memoria utilizada por listas de abonados y universos...\n\n");
	
	fprintf(stderr, "\nLibera Estructura General de Valoración (TASADOR).\n");
	fprintf(pfLog , "\nLibera Estructura General de Valoración (TASADOR).\n");
	vLiberaConceptosLocal(lstConceptos);

	fprintf(stderr, "\nLibera detalle de Categorias de Ventas.\n");
	fprintf(pfLog , "\nLibera detalle de Categorias de Ventas.\n");
	vLiberaCategVenta(lstCategVentas);

	fprintf(stderr, "\nLibera Estructura de Valoracion Diferenciada.\n");
	fprintf(pfLog , "\nLibera Estructura de Valoracion Diferenciada.\n");
	vLiberaDiferenciada(lstDiferenciada);

	fprintf(stderr, "\nLibera Estructura Ventas a Valorar Durante el Periodo.\n");
	fprintf(pfLog, "\nLibera Estructura Ventas a Valorar Durante el Periodo.\n");
	vLiberaVentas(lstVentas);
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
    fprintf(pfLog, "Segundos Reales Utilizados                          : [%d]\n", stStatusProc.lSegProceso);
    fprintf(pfLog, "Cantidad de Registros Leidos                        : [%d]\n", stStatusProc.lCantRegistros);
    fprintf(pfLog, "Cantidad de Registros Sin Categoría de Ventas       : [%d]\n", stStatusProc.lCantNOCATEG);
    fprintf(pfLog, "Cantidad de Registros con Valoracion Diferenciada   : [%d]\n", stStatusProc.lCantDIFEREN);
    fprintf(pfLog, "Cantidad de Registros Insertados (CMT_VALORIZADOS)  : [%d]\n", stStatusProc.lCantVentas);
    
    fprintf(stderr, "\nEstadistica del proceso\n");
    fprintf(stderr, "------------------------\n");
    fprintf(stderr, "Segundos Reales Utilizados                          : [%d]\n", stStatusProc.lSegProceso);
    fprintf(stderr, "Cantidad de Registros Leidos                        : [%d]\n", stStatusProc.lCantRegistros);
    fprintf(stderr, "Cantidad de Registros Insertados (CMT_VALORIZADOS)  : [%d]\n", stStatusProc.lCantVentas);

    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantVentas);
    if (ibiblio)
            exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )440;
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

