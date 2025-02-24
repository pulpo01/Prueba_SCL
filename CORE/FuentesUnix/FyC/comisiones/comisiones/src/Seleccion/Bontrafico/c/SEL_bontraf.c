
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
    "./pc/SEL_bontraf.pc"
};


static unsigned int sqlctx = 27716891;


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
   unsigned char  *sqhstv[17];
   unsigned long  sqhstl[17];
            int   sqhsts[17];
            short *sqindv[17];
            int   sqinds[17];
   unsigned long  sqharm[17];
   unsigned long  *sqharc[17];
   unsigned short  sqadto[17];
   unsigned short  sqtdso[17];
} sqlstm = {12,17};

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
"select COD_CONCEPTOFACT ,TIP_CONCEPTO  from CM_CONCEPFACT_BONOCARTERA_TD whe\
re ((COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2)           ";

 static char *sq0002 = 
"select A.COD_COMISIONISTA ,A.COD_TIPVENDEDOR ,A.COD_AGENCIA ,A.COD_CLIENTE ,\
A.NUM_ABONADO ,A.COD_PLANTARIF ,NVL(C.NUM_ABONADOS,1) ,TO_CHAR(A.FEC_VENTA,'YY\
YYMMDDHH24MISS')  from CMT_CARTERA A ,(select COD_PLANTARIF ,NUM_ABONADOS  fro\
m TA_PLANTARIF where (COD_PLANTARIF in (select unique COD_PLANTARIF  from CMT_\
CARTERA where IND_PROCESABLE='S') and COD_PRODUCTO=1)) C where ((((A.IND_PROCE\
SABLE='S' and A.NUM_ABONADO>0) and A.COD_TIPCOMIS=:b0) and A.COD_TIPORED=:b1) \
and C.COD_PLANTARIF=A.COD_PLANTARIF) order by A.COD_CLIENTE desc             ";

 static char *sq0003 = 
"select TO_NUMBER(VAL_PARAMETRO1) ,DES_PARAMETRO1  from CMD_PARAMETROS where \
((COD_TIPCODIGO=10 and COD_CODIGO=8) and COD_PARAMETRO>0)           ";

 static char *sq0004 = 
"select COD_CLIENTE ,COD_TIPDOCUM ,COD_CENTREMI ,NUM_SECUENCI ,COD_VENDEDOR_A\
GENTE ,LETRA  from CO_CANCELADOS S where (S.FEC_CANCELACION between TO_DATE(:b\
0,'DD-MM-YYYY') and TO_DATE(:b1,'DD-MM-YYYY') and S.rowid =(select T.rowid   f\
rom CO_CANCELADOS T where (((((S.NUM_SECUENCI=T.NUM_SECUENCI and S.COD_TIPDOCU\
M=T.COD_TIPDOCUM) and S.COD_VENDEDOR_AGENTE=T.COD_VENDEDOR_AGENTE) and S.LETRA\
=T.LETRA) and S.COD_CENTREMI=T.COD_CENTREMI) and ROWNUM=1))) order by COD_CLIE\
NTE desc             ";

 static char *sq0007 = 
"select COD_CICLFACT ,FA_HISTCONC  from FA_ENLACEHIST where FA_HISTCONC is  n\
ot null            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,152,0,9,150,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
32,0,0,1,0,0,13,154,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
55,0,0,1,0,0,15,170,0,0,0,0,0,1,0,
70,0,0,2,543,0,9,258,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
93,0,0,2,0,0,13,262,0,0,8,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,3,0,0,2,97,0,0,
140,0,0,2,0,0,15,311,0,0,0,0,0,1,0,
155,0,0,3,144,0,9,339,0,0,0,0,0,1,0,
170,0,0,3,0,0,13,346,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
193,0,0,3,0,0,15,364,0,0,0,0,0,1,0,
208,0,0,4,487,0,9,429,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
231,0,0,4,0,0,13,433,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,
270,0,0,4,0,0,15,461,0,0,0,0,0,1,0,
285,0,0,5,178,0,4,569,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,
328,0,0,6,233,0,4,618,0,0,8,5,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,97,0,0,1,3,0,0,
375,0,0,7,95,0,9,665,0,0,0,0,0,1,0,
390,0,0,7,0,0,13,669,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
413,0,0,7,0,0,15,685,0,0,0,0,0,1,0,
428,0,0,8,0,0,17,880,0,0,1,1,0,1,0,1,97,0,0,
447,0,0,8,0,0,45,883,0,0,1,1,0,1,0,1,3,0,0,
466,0,0,8,0,0,13,890,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
493,0,0,8,0,0,15,901,0,0,0,0,0,1,0,
508,0,0,9,54,0,4,1066,0,0,1,0,0,1,0,2,3,0,0,
527,0,0,10,340,0,3,1070,0,0,17,17,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,97,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,
97,0,0,1,97,0,0,1,3,0,0,
610,0,0,11,48,0,1,1190,0,0,0,0,0,1,0,
625,0,0,12,0,0,29,1352,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar los prepagos para comisiones ver. 2*/ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 04.                                             */
/* Inicio: Viernes 31 de Agosto del 2001.                               */
/* Fin   : Martes 25 de Septiembre del 2001.                            */
/* Por Richard Troncoso C.                                              */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla 		*/
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y		*/
/* COD_PARAMETRO.														*/
/************************************************************************/
/************************************************************************/
/* Modificacion : Marcelo Gonz�lez Lizama                               */
/* Inicio       : Martes 14 de Octubre de 2003                          */
/* Fin			:                                               		*/
/* Descripcion  : 					       								*/
/* **********************************************************************/
/************************************************************************/
/* Modificacion : Fabian Aedo Ramirez                                   */
/* Inicio       : Jueves 06 de Novienmbre del 2003.                     */
/* Fin			:                                               		*/
/* Descripcion  : Cambios asociados al versionado de cuzco....          */
/*                - Normalizacion de Uso de Variables                   */
/*                - Planes de Comisiones                                */
/*                - Nuevo modelo de Bono Cartera                        */
/*                - Mejoras Varias.                                     */
/*                                                                      */
/* Modificacion : Manuel Garcia G.                                      */
/* Inicio       : Jueves 13 de Mayo del 2004.                           */
/* Fin			:                                               		*/
/* Descripcion  : Se aplica Homologacion HD-200405060712                */
/*                - Se optimiza acceso a tabla cmt_cartera              */
/*                  Se crea version CUZCO 4.0.1                         */
/* **********************************************************************/ 

#include "bontraf.h"
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
/* Definicion de variables globales para ser usadas con	Oracle.		         */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhUser[30]="";
	char	szhPass[30]="";
	char	szhSysDate [17]="";
	char	szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Lista de Tipos de Comisionistas para ejecuci�n de ciclo  			     */
/*---------------------------------------------------------------------------*/
	stConceptosProc * lstConceptosProc = NULL;
/*---------------------------------------------------------------------------*/
/* Gestiona la carga de	Conceptos y Par�metros de Valoraci�n		         */
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
/* */
/*---------------------------------------------------------------------------*/
stUniverso * stBuscaCliente(stUniverso * paux, long lCodCliente, char * szTipComis, int iCodTipoRed)
{
	stUniverso * 	raux;
	int				bEncontrado;
	if (paux==NULL)
		return paux;
	raux = paux;
	bEncontrado = FALSE;
	while((raux != NULL)&&(!bEncontrado))
	{
		if ((lCodCliente == raux->lCodCliente)&&(strcmp(raux->szCodTipComis, szTipComis)==0)&&(raux->iCodTipoRed == iCodTipoRed))
			bEncontrado = TRUE;
		else
			raux = raux->sgte;
	}
	if (bEncontrado)
		return raux;
	else
		return NULL;
}
/*---------------------------------------------------------------------------*/
/* OBTIENE LOS CONCEPTOS DE FACTURACION ASOCIADOS AL TIPO DE RED.            */
/*---------------------------------------------------------------------------*/
stConcFact * stCargaConcFact(int iCodTipoRed, char * szCodPlanComis, int iCodConcComis)
{
	stConcFact * paux;
	stConcFact * qaux;
	int			i;
	short 		iLastRows 	 = 0;
	short 		iFetchedRows = MAXFETCH;
	short 		iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;
		char	szhCodPlanComis[7];
		int		ihCodConcComis;
		int 	ihCodConcepto[MAXFETCH];
		char 	szhTipoConcepto[MAXFETCH][10];
		int		iMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihCodTipoRed			= iCodTipoRed;
	strcpy(szhCodPlanComis	, szCodPlanComis);
	ihCodConcComis 			= iCodConcComis;
	iMaxFetch 				= MAXFETCH;
	paux 					= NULL;
	qaux 					= NULL;
	
	/* EXEC SQL DECLARE CUR_CONCFACT CURSOR FOR SELECT  
		COD_CONCEPTOFACT,
		TIP_CONCEPTO
		FROM CM_CONCEPFACT_BONOCARTERA_TD
		WHERE 	COD_TIPORED 	= :ihCodTipoRed
		AND 	COD_PLANCOMIS 	= :szhCodPlanComis
		AND 	COD_CONCEPTO	= :ihCodConcComis; */ 

	
	/* EXEC SQL OPEN CUR_CONCFACT; */ 

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
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
 sqlstm.sqhstl[1] = (unsigned long )7;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcComis;
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
 if (sqlca.sqlcode < 0) vSqlError();
}

	

	while(iFetchedRows == iRetrievRows)
	{
		/* EXEC SQL FOR :iMaxFetch FETCH CUR_CONCFACT INTO 
			:ihCodConcepto, :szhTipoConcepto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 3;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )iMaxFetch;
  sqlstm.offset = (unsigned int  )32;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhTipoConcepto;
  sqlstm.sqhstl[1] = (unsigned long )10;
  sqlstm.sqhsts[1] = (         int  )10;
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
		iLastRows = sqlca.sqlerrd[2];
				
		for (i=0; i < iRetrievRows; i++)
		{
			paux = (stConcFact *) malloc (sizeof(stConcFact));
			
			paux->iCodConcepto 			= ihCodConcepto[i];
			strcpy(paux->szTipoConcepto	, szfnTrim(szhTipoConcepto[i]));
			paux->sgte 					= qaux;
			qaux 						= paux;
		}
	}
	/* EXEC SQL CLOSE CUR_CONCFACT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )55;
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
/*   Carga universo de datos												 */
/*---------------------------------------------------------------------------*/
void vSeleccionarUniverso()
{
	stUniverso 		* paux;
	stUniverso 		* qaux;
	stAbonado  		* aaux;
	stConceptosProc 	* raux;
	
	int			i;
	short 		iLastRows 	= 0;
	short 		iFetchedRows 	= MAXFETCH;
	short 		iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		iMaxFetch;
		int		ihCodTipoRed;
		long    lhCodComisionista[MAXFETCH];
		char	szhCodTipVendedor[MAXFETCH][3];
	    long    lhCodAgencia[MAXFETCH];
	    long    lhCodCliente[MAXFETCH];
	    long    lhNumAbonado[MAXFETCH];
		int		ihCanAbonados[MAXFETCH];
		char    szhCodPlanTarif[MAXFETCH][04];
    	char	szhFecVenta[MAXFETCH][15];
		char    szhCodTipComis[3];
	/* EXEC SQL END DECLARE SECTION; */ 
		
	qaux = NULL;
	for (raux=lstConceptosProc;raux != NULL; raux=raux->sgte)
	{
    	ihCodTipoRed			= raux->iCodTipoRed;
	   	strcpy(szhCodTipComis	, raux->szCodTipComis);
	   	iMaxFetch 				= MAXFETCH;
	
		fprintf(pfLog, "\n[vSeleccionarUniverso] Carga Cartera Para TipoRed:[%d] TipComis:[%s].\n",ihCodTipoRed, szhCodTipComis);
		fprintf(stderr,"\n[vSeleccionarUniverso] Carga Cartera Para TipoRed:[%d] TipComis:[%s].\n",ihCodTipoRed, szhCodTipComis);

/* MGG HOMOLOGACION HD-200405060712 
		EXEC SQL DECLARE CUR_CARTERA CURSOR FOR SELECT  
 			A.COD_COMISIONISTA,
 			A.COD_TIPVENDEDOR,
			A.COD_AGENCIA,
			A.COD_CLIENTE,
			A.NUM_ABONADO,
			A.COD_PLANTARIF,
			NVL(C.NUM_ABONADOS,1),
			TO_CHAR(A.FEC_VENTA, 'YYYYMMDDHH24MISS')
	 	FROM	CMT_CARTERA A, 
	 			TA_PLANTARIF C
	 	WHERE	A.IND_PROCESABLE 	= 'S' 
	 	AND		A.COD_TIPCOMIS		= :szhCodTipComis
	 	AND		A.COD_TIPORED		= :ihCodTipoRed
	 	AND   	A.NUM_ABONADO 		> 0
	 	AND   	C.COD_PRODUCTO 		= 1
	 	AND	 	C.COD_PLANTARIF 	= A.COD_PLANTARIF
	 	ORDER BY A.COD_CLIENTE DESC; 
*/
		/* EXEC SQL 
		DECLARE CUR_CARTERA CURSOR FOR 
		SELECT A.COD_COMISIONISTA,
			   A.COD_TIPVENDEDOR,
			   A.COD_AGENCIA,
			   A.COD_CLIENTE,
			   A.NUM_ABONADO,
			   A.COD_PLANTARIF,
			   NVL(C.NUM_ABONADOS,1),
			   TO_CHAR(A.FEC_VENTA, 'YYYYMMDDHH24MISS')
		  FROM CMT_CARTERA A, 
			   ( SELECT COD_PLANTARIF, 
					    NUM_ABONADOS
				   FROM TA_PLANTARIF
				  WHERE COD_PLANTARIF IN ( SELECT UNIQUE COD_PLANTARIF 
											 FROM CMT_CARTERA
											WHERE IND_PROCESABLE = 'S' 
										 )
					AND COD_PRODUCTO = 1 
			   ) C
		 WHERE A.IND_PROCESABLE = 'S' 
		   AND A.NUM_ABONADO > 0
		   AND A.COD_TIPCOMIS = :szhCodTipComis
		   AND A.COD_TIPORED = :ihCodTipoRed
		   AND C.COD_PLANTARIF = A.COD_PLANTARIF	
		ORDER BY A.COD_CLIENTE DESC; */ 
 
	
		/* EXEC SQL OPEN CUR_CARTERA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 3;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0002;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )70;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipComis;
  sqlstm.sqhstl[0] = (unsigned long )3;
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
			/* EXEC SQL FOR :iMaxFetch FETCH CUR_CARTERA INTO  
				:lhCodComisionista,
				:szhCodTipVendedor,
				:lhCodAgencia,
				:lhCodCliente,
				:lhNumAbonado,
				:szhCodPlanTarif,
				:ihCanAbonados,
				:szhFecVenta; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )iMaxFetch;
   sqlstm.offset = (unsigned int  )93;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)lhCodComisionista;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipVendedor;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )3;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)lhCodAgencia;
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
   sqlstm.sqhstv[4] = (unsigned char  *)lhNumAbonado;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )sizeof(long);
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodPlanTarif;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )4;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)ihCanAbonados;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )sizeof(int);
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqharc[6] = (unsigned long  *)0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFecVenta;
   sqlstm.sqhstl[7] = (unsigned long )15;
   sqlstm.sqhsts[7] = (         int  )15;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqharc[7] = (unsigned long  *)0;
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
   if (sqlca.sqlcode < 0) vSqlError();
}


	
			iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
			iLastRows = sqlca.sqlerrd[2];
					
			for (i=0; i < iRetrievRows; i++)
			{
				paux = stBuscaCliente(qaux, lhCodCliente[i], szhCodTipComis, ihCodTipoRed);
				if (paux == NULL)
				{
					paux = (stUniverso *) malloc (sizeof(stUniverso));
					
					paux->iCodTipoRed			= ihCodTipoRed;
				    strcpy(paux->szCodTipComis	, szhCodTipComis);
					paux->lCodComisonista 		= lhCodComisionista[i];
					paux->lCodCliente 			= lhCodCliente[i];
					paux->sgte_concfact			= stCargaConcFact(paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto);
					paux->cIndConsidera 		= 'N'; 										   							
					strcpy(paux->szCodPlanComis	, raux->szCodPlanComis);
					paux->iCodConcepto			= raux->iCodConcepto; 
					paux->sgte_factura 			= NULL;
					paux->sgte_abonado 			= NULL;
					paux->sgte 					= qaux;
					qaux 						= paux;
				}

				aaux = (stAbonado *) malloc (sizeof(stAbonado));
				
				aaux->lCodAgencia 				= lhCodAgencia[i];
			    strcpy(aaux->szCodTipVendedor	, szfnTrim(szhCodTipVendedor[i]));
				aaux->lNumAbonado 				= lhNumAbonado[i];
				strcpy(aaux->szCodPlanTarif		, szfnTrim(szhCodPlanTarif[i]));
				aaux->iCantAbonadosPlan			= ihCanAbonados[i];	
				aaux->dFecVenta					= atof(szhFecVenta[i]); 
				aaux->cIndConsidera 			= 'N'; 

				aaux->sgte_idfactura			= NULL;
				aaux->sgte 						= paux->sgte_abonado;
				paux->sgte_abonado 				= aaux;
		  	}
		}	
		/* EXEC SQL CLOSE CUR_CARTERA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )140;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError();
}

	
	}
	lstUniverso = qaux;
}
/*****************************************************************************/
/* CARGA TIPOS DE DOCUMENTOS VALIDOS PARA EL PROCESO.                        */
/*****************************************************************************/
void vCargaTipoDocumentos ()
{
    stDocumentos * paux;
    int     iFetchedRows 	= MAXFETCH;
    int     iRetrievRows 	= MAXFETCH;
    short   iLastRows    	= 0;   
	int		i;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        int    	iMaxFetch;
        int		ihCodTipDocum[MAXFETCH];
	    char    szhDesTipDocum[MAXFETCH][51];
    /* EXEC SQL END DECLARE SECTION; */ 

    
	/* EXEC SQL DECLARE CUR_PARAMETROS CURSOR FOR SELECT 
			TO_NUMBER(VAL_PARAMETRO1), 
			DES_PARAMETRO1
	FROM 	CMD_PARAMETROS
	WHERE 	COD_TIPCODIGO 		= 10
			AND COD_CODIGO 		= 8
			AND COD_PARAMETRO 	> 0; */ 


	/* EXEC SQL OPEN CUR_PARAMETROS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0003;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )155;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	fprintf(pfLog ,"\n[vCargaTipoDocumentos] Inicia Carga de Tipos de Documentos a Considerar\n");
	fprintf(stderr,"\n[vCargaTipoDocumentos] Inicia Carga de Tipos de Documentos a Considerar\n");
	iMaxFetch = MAXFETCH;
	
	while(iFetchedRows == iRetrievRows)
    {
	/* EXEC SQL FOR :iMaxFetch FETCH CUR_PARAMETROS INTO
            :ihCodTipDocum,    
            :szhDesTipDocum; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )iMaxFetch;
 sqlstm.offset = (unsigned int  )170;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipDocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )sizeof(int);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhDesTipDocum;
 sqlstm.sqhstl[1] = (unsigned long )51;
 sqlstm.sqhsts[1] = (         int  )51;
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
       	iLastRows = sqlca.sqlerrd[2];
		for (i=0; i < iRetrievRows; i++)
		{
			paux = (stDocumentos *) malloc (sizeof(stDocumentos));
	       	paux->iCodTipDocum 			= ihCodTipDocum[i];
	       	strcpy(paux->szDesTipDocum	, szfnTrim(szhDesTipDocum[i]));
			paux->sgte 					= lstDocumentos;
			lstDocumentos				= paux;
			
			fprintf(pfLog ,"[vCargaTipoDocumentos] TipDocum:[%d] [%s]\n", paux->iCodTipDocum, paux->szDesTipDocum);	       	
			fprintf(stderr,"[vCargaTipoDocumentos] TipDocum:[%d] [%s]\n", paux->iCodTipDocum, paux->szDesTipDocum);	       	
		}
   }   
	/* EXEC SQL CLOSE CUR_PARAMETROS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )193;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	fprintf(pfLog ,"\n[vCargaTipoDocumentos] Fin Carga de Tipos de Documentos a Considerar\n");
	fprintf(stderr,"\n[vCargaTipoDocumentos] Fin Carga de Tipos de Documentos a Considerar\n");
}
/*****************************************************************************/
/* BUSCA UN TIPO DE DOCUMENTO EN LA LISTA DE TIPOS DE DOCUMENTOS VALIDOS.    */
/*****************************************************************************/
int bFindTipDocum(stDocumentos * paux, int iTipDocum)
{
	if (paux == NULL)
		return FALSE;
	if (paux->iCodTipDocum == iTipDocum)
		return TRUE;
	return bFindTipDocum(paux->sgte, iTipDocum);
}
/*****************************************************************************/
/* Almacenamiento de CO_CANCELADOS en memoria                                */
/*****************************************************************************/
void vCargaFacturas() 
{

	stCancelados * 	faux;
	int				i;
	int 			iLastRows 		= 0;
	int 			iFetchedRows 	= MAXFETCH;
	int 			iRetrievRows 	= MAXFETCH;
	long			lCantRegistros 	= 0;	

    /* EXEC SQL begin declare section; */ 

		int		iMaxFetch;
        int   	ihCodTipDocum[MAXFETCH];
        int   	ihCodCentremi[MAXFETCH];
		long    lhNumSecuenci[MAXFETCH];
        long    lhCodCliente[MAXFETCH];
        long    lhCodVendedorAgente[MAXFETCH];
        char    szhLetra[MAXFETCH][2];
		char	szhFecDesde[11];
		char	szhFecHasta[11];
    /* EXEC SQL end declare section; */ 


	strcpy(szhFecDesde, stCiclo.szFecDesdeNormal);
	strcpy(szhFecHasta, stCiclo.szFecHastaNormal);
	fprintf(pfLog ,"\n[vCargaFacturas] Inicia Carga de Documentos cancelados del periodo.\n");
	fprintf(stderr,"\n[vCargaFacturas] Inicia Carga de Documentos cancelados del periodo.\n");

	iMaxFetch = MAXFETCH;
	/* EXEC SQL DECLARE CUR_CANCELADOS CURSOR FOR SELECT  
		COD_CLIENTE, 
		COD_TIPDOCUM, 
		COD_CENTREMI,
		NUM_SECUENCI, 
		COD_VENDEDOR_AGENTE, 
		LETRA 
		FROM   CO_CANCELADOS S 
		WHERE  S.FEC_CANCELACION BETWEEN  TO_DATE(:szhFecDesde ,'DD-MM-YYYY') AND 
										  TO_DATE(:szhFecHasta,'DD-MM-YYYY') 
		 AND   S.ROWID = ( SELECT T.ROWID FROM CO_CANCELADOS T 
		                    WHERE  S.NUM_SECUENCI        = T.NUM_SECUENCI 
		                    AND    S.COD_TIPDOCUM        = T.COD_TIPDOCUM 
		                    AND    S.COD_VENDEDOR_AGENTE = T.COD_VENDEDOR_AGENTE 
		                    AND    S.LETRA               = T.LETRA 
		                    AND    S.COD_CENTREMI        = T.COD_CENTREMI 
		                    AND   ROWNUM                 = 1) 
		ORDER BY COD_CLIENTE DESC; */ 


	/* EXEC SQL OPEN CUR_CANCELADOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )208;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesde;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
 sqlstm.sqhstl[1] = (unsigned long )11;
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
 if (sqlca.sqlcode < 0) vSqlError();
}



    while (iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL FOR :iMaxFetch FETCH CUR_CANCELADOS INTO
			:lhCodCliente,
			:ihCodTipDocum,
			:ihCodCentremi,
			:lhNumSecuenci,
			:lhCodVendedorAgente,
			:szhLetra; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )iMaxFetch;
  sqlstm.offset = (unsigned int  )231;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihCodTipDocum;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ihCodCentremi;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhNumSecuenci;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)lhCodVendedorAgente;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )sizeof(long);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[5] = (unsigned long )2;
  sqlstm.sqhsts[5] = (         int  )2;
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
  if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows 	= sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
 		{
			if (bFindTipDocum(lstDocumentos, ihCodTipDocum[i]))
			{
				faux = (stCancelados *) malloc(sizeof(stCancelados));
				faux->lCodCliente  			= lhCodCliente[i];
				faux->iCodTipDocum 			= ihCodTipDocum[i];
				faux->iCodCentremi 			= ihCodCentremi[i];
				faux->lNumSecuenci 			= lhNumSecuenci[i];
				faux->lCodVendedorAgente 	= lhCodVendedorAgente[i];
				strcpy(faux->cLetra 		, szhLetra[i]);
				faux->sgte 					= lstCancelados;
				lstCancelados 				= faux;
				lCantRegistros++;
			}
		}
	}
	/* EXEC SQL CLOSE CUR_CANCELADOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )270;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	fprintf(pfLog ,"\n[vCargaFacturas] Documentos Cancelados del Periodo[%ld].\n", lCantRegistros);
	fprintf(stderr,"\n[vCargaFacturas] Documentos Cancelados del Periodo[%ld].\n", lCantRegistros);
}

/*****************************************************************************/
/* Liberar memoria ocupada por las Facturas                                  */
/*****************************************************************************/
void vLiberaCancelados(stCancelados * paux)
{
	stCancelados * raux;
	
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }
}
/*****************************************************************************/
/*****************************************************************************/
stUniverso * stBuscaClienteFactura(stUniverso * puni, long lCodCliente)
{
	int	bEncontrado = FALSE;
	if (puni == NULL)
		return NULL;

	bEncontrado = FALSE;
	while ((puni!=NULL)&&(!bEncontrado))
	{
		if (puni->lCodCliente < lCodCliente)
			puni = puni->sgte;
		else
			bEncontrado = TRUE;
	}
	if (bEncontrado)
		if (puni->lCodCliente == lCodCliente)
			return puni;

	return NULL;
}
/*****************************************************************************/
/* Asignacion de Facturas a la Estructura de Clientes                        */
/*****************************************************************************/
void vAsignaFacturas()
{
	stUniverso 		* puni;
	stCancelados	* pcan;
	stFactura		* faux;

	for (pcan = lstCancelados; pcan != NULL; pcan = pcan->sgte)
	{
		puni = stBuscaClienteFactura(lstUniverso, pcan->lCodCliente);
		while (puni!=NULL)
		{
            faux = (stFactura *) malloc(sizeof(stFactura));
            
            faux->iCodTipDocum 			= pcan->iCodTipDocum;
            faux->iCodCentremi 			= pcan->iCodCentremi;
            faux->lNumSecuenci 			= pcan->lNumSecuenci;
            faux->lCodVendedorAgente 	= pcan->lCodVendedorAgente;
            strcpy(faux->cLetra 		, pcan->cLetra);
            faux->cIndConsidera 		= 'S';
            puni->cIndConsidera 		= 'S';
            faux->sgte 					= puni->sgte_factura;
            puni->sgte_factura 			= faux;
            
			puni = stBuscaClienteFactura(puni->sgte, pcan->lCodCliente);
		}
	}
}
/*****************************************************************************/
/* Comparacion contra tabla CO_CARTERA                                       */ 
/*****************************************************************************/
void vValidaCancelados()
{
	stUniverso	* paux;
	stFactura	* faux;

    /* EXEC SQL begin declare section; */ 

		short	ihCantCartera;
        short   ihCodTipDocum;
        short   ihCodCentremi;
        long    lhCodCliente;
        long    lhNumSecuenci;
        long    lhCodVendedorAgente;
        char    szhLetra[2];
    /* EXEC SQL end declare section; */ 


	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		if (paux->cIndConsidera == 'S')
		{
			for (faux = paux->sgte_factura; faux != NULL; faux = faux->sgte)
			{
				lhCodCliente  = paux->lCodCliente;
				ihCodTipDocum = faux->iCodTipDocum;
				ihCodCentremi = faux->iCodCentremi;
				lhNumSecuenci = faux->lNumSecuenci;
				lhCodVendedorAgente = faux->lCodVendedorAgente;
				strcpy(szhLetra , faux->cLetra);
				ihCantCartera = 0;

				/* EXEC SQL SELECT COUNT(1)
					 INTO	:ihCantCartera
					 FROM	CO_CARTERA
					 WHERE	COD_CLIENTE  		= :lhCodCliente
					   AND	NUM_SECUENCI 		= :lhNumSecuenci
					   AND	COD_TIPDOCUM 		= :ihCodTipDocum
					   AND	COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
					   AND	LETRA 				= :szhLetra
					   AND	COD_CENTREMI 		= :ihCodCentremi; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from CO_CARTERA where (((((COD_\
CLIENTE=:b1 and NUM_SECUENCI=:b2) and COD_TIPDOCUM=:b3) and COD_VENDEDOR_AGENT\
E=:b4) and LETRA=:b5) and COD_CENTREMI=:b6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )285;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCantCartera;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorAgente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
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
    if (sqlca.sqlcode < 0) vSqlError();
}



				if (ihCantCartera)
					faux->cIndConsidera = 'N';
			}
		}
	}
}
/*****************************************************************************/
/* Recupera los datos de la Factura desde FA_HISTDOCU.                       */ 
/*****************************************************************************/
void vRecuperaFactura()
{
	stUniverso	* paux;
	stFactura	* faux;

    /* EXEC SQL begin declare section; */ 

        short   ihCodTipDocum;
        short   ihCodCentremi;
        long    lhNumSecuenci;
        long    lhCodVendedorAgente;
        char    szhLetra[2];
		long	lhCodCiclFact;
		long	lhlIndOrdenTotal;
		char	szhFecEmision[15];
    /* EXEC SQL end declare section; */ 


	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		if (paux->cIndConsidera == 'S')
		{
			for (faux=paux->sgte_factura; faux != NULL; faux=faux->sgte)
			{
				if (faux->cIndConsidera == 'S')
				{
					ihCodTipDocum 			= faux->iCodTipDocum;
					ihCodCentremi 			= faux->iCodCentremi;
					lhNumSecuenci 			= faux->lNumSecuenci;
					lhCodVendedorAgente 	= faux->lCodVendedorAgente;
					strcpy(szhLetra 			, faux->cLetra);

					/* EXEC SQL SELECT	NVL(COD_CICLFACT,0),									
									IND_ORDENTOTAL,
									TO_CHAR(FEC_EMISION, 'YYYYMMDDHH24MISS')
					 		 INTO	:lhCodCiclFact,
									:lhlIndOrdenTotal,
									:szhFecEmision
					 		 FROM	FA_HISTDOCU
					 		 WHERE	NUM_SECUENCI 		= :lhNumSecuenci	
					 		   AND	COD_TIPDOCUM 		= :ihCodTipDocum
					   		   AND	COD_VENDEDOR_AGENTE	= :lhCodVendedorAgente
					   		   AND	LETRA 				= :szhLetra
					   		   AND	COD_CENTREMI 		= :ihCodCentremi; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select NVL(COD_CICLFACT,0) ,IND_ORDENTOTAL ,TO_CHAR(FEC_\
EMISION,'YYYYMMDDHH24MISS') into :b0,:b1,:b2  from FA_HISTDOCU where ((((NUM_S\
ECUENCI=:b3 and COD_TIPDOCUM=:b4) and COD_VENDEDOR_AGENTE=:b5) and LETRA=:b6) \
and COD_CENTREMI=:b7)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )328;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhlIndOrdenTotal;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
     sqlstm.sqhstl[2] = (unsigned long )15;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocum;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedorAgente;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentremi;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
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
     if (sqlca.sqlcode < 0) vSqlError();
}



					faux->lCodCiclFact 		= lhCodCiclFact;
					faux->lIndOrdenTotal 	= lhlIndOrdenTotal;
					faux->dFecEmision    	= atof(szhFecEmision);						
				}
			}
		}
	}
}

/*****************************************************************************/
/* Bajando a memoria FA_ENLACEHIST                                           */
/*****************************************************************************/
void vCargaEnlaceHist()
{
	stEnlaceHist * paux;
	int				i;
	int 			iLastRows = 0;
	int 			iFetchedRows = MAXFETCH;
	int 			iRetrievRows = MAXFETCH;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodCiclFact[MAXFETCH];
		char    szhFaHistConc[MAXFETCH][41];
		int		iMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 


	iMaxFetch = MAXFETCH; 

	/* EXEC SQL DECLARE CUR_ENLACE CURSOR FOR SELECT	
		COD_CICLFACT,
		FA_HISTCONC
	 FROM FA_ENLACEHIST
	 WHERE FA_HISTCONC IS NOT NULL; */ 


	/* EXEC SQL OPEN CUR_ENLACE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )375;
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
        /* EXEC SQL FOR :iMaxFetch FETCH CUR_ENLACE INTO  
        	:lhCodCiclFact, :szhFaHistConc; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )iMaxFetch;
        sqlstm.offset = (unsigned int  )390;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lhCodCiclFact;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFaHistConc;
        sqlstm.sqhstl[1] = (unsigned long )41;
        sqlstm.sqhsts[1] = (         int  )41;
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
        iLastRows = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
			paux 					= (stEnlaceHist *) malloc (sizeof(stEnlaceHist));
			
			paux->lCodCiclFact 			= lhCodCiclFact[i];
			strcpy(paux->szFaHistConc	, szfnTrim(szhFaHistConc[i]));
			paux->sgte 					= lstEnlaceHist;
			lstEnlaceHist 				= paux;
		}
	}
	/* EXEC SQL CLOSE CUR_ENLACE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )413;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


}
/*****************************************************************************/
/*****************************************************************************/
stEnlaceHist * stBuscaEnlace(stEnlaceHist * paux, long lCodCiclFact)
{
	if (paux == NULL)
		return paux;
	
	if (paux->lCodCiclFact == lCodCiclFact)
		return paux;
	return 	stBuscaEnlace(paux->sgte, lCodCiclFact);
}
/*****************************************************************************/
/* Asigna Tabla Historica para cada Ciclo                                    */
/*****************************************************************************/
void vDeterminaCicloFactura()
{
	stUniverso 		* paux;
	stEnlaceHist	* penl;
	stFactura		* pfac;

	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		if (paux->cIndConsidera == 'S')
		{
			for (pfac = paux->sgte_factura; pfac != NULL; pfac = pfac->sgte)
			{
				if ( pfac->cIndConsidera == 'S' )
				{
					penl = stBuscaEnlace(lstEnlaceHist, pfac->lCodCiclFact);
					if (penl == NULL)
					{
						fprintf(pfLog ,"\t[vDeterminaCicloFactura] No se Encontro Detalle para CICLO:[%d]. Se Descarta.\n", pfac->lCodCiclFact);
						fprintf(stderr,"\t[vDeterminaCicloFactura] No se Encontro Detalle para CICLO:[%d]. Se Descarta.\n", pfac->lCodCiclFact);
						pfac->cIndConsidera = 'N';						
					}
					else
						strcpy(pfac->szFaHistConc, penl->szFaHistConc);
				}
			}
		}
	}
}
/*****************************************************************************/
/* Busca una factura en la lista de facturas por abonado.                    */
/*****************************************************************************/
stIdFactura * stBuscaIdFactura(stIdFactura * pide, long lIndOrden)
{
	if (pide == NULL)
		return NULL;
	
	if (pide->lIndOrdenTotal = lIndOrden)
		return pide;
		
	return stBuscaIdFactura(pide->sgte, lIndOrden);
}
/*****************************************************************************/
/* Busca un abonado en la lista de abonados del cliente.                     */
/*****************************************************************************/
stAbonado * stBuscaAbonado(stAbonado * pabo, long lNumAbonado)
{
	if (pabo == NULL)
	{
		return NULL;
	}
	if (pabo->lNumAbonado == lNumAbonado)
	{
		return pabo;
	}
	return stBuscaAbonado(pabo->sgte,lNumAbonado);
}

/*****************************************************************************/
/* BUSQUEDA DE CONCEPTOS													 */
/*****************************************************************************/
stConcFact * stBuscaConcepto(stConcFact * paux, int iCodConcepto)
{
	if (paux==NULL)
		return paux;
	if (paux->iCodConcepto == iCodConcepto)
		return paux;
	return stBuscaConcepto(paux->sgte, iCodConcepto);
}
/*****************************************************************************/
/* Distribuye y asigna el monto del concepto recuperado de la factura sobre  */
/* la lista de abonamdos del nodo principal.                                 */
/*****************************************************************************/
void vAsignaConceptos(stUniverso * paux, stFactura * pfac, int iCodConcepto, double dImpConcepto, long lNumAbonado)
{
	stAbonado   * pabo;
	stIdFactura * pide;
	stConcFact	* pConc;
	
	double	    dProrrateo;
	int			bExiste;
	
	if (lNumAbonado = 0)
	{
		for(pabo = paux->sgte_abonado; pabo != NULL; pabo = pabo->sgte)
		{
			if(pabo->dFecVenta <= pfac->dFecEmision)
			{
				dProrrateo = (dImpConcepto / pabo->iCantAbonadosPlan);
				pide = stBuscaIdFactura(pabo->sgte_idfactura, pfac->lIndOrdenTotal);
				if (pide == NULL)
				{
					pide = (stIdFactura *) malloc (sizeof(stIdFactura));
		       		pide->lIndOrdenTotal 	= pfac->lIndOrdenTotal;
		       		pide->lCodCiclFact   	= pfac->lCodCiclFact;
	           		pide->dImpTrafico 		= 0.00;
					pide->dImpCBasico  		= 0.00;
		       		pide->sgte 				= pabo->sgte_idfactura;
		       		pabo->sgte_idfactura 	= pide;
					pabo->cIndConsidera 	= 'S';
				}
	       		pConc = stBuscaConcepto(paux->sgte_concfact, iCodConcepto);
	       		if (pConc != NULL)
	       		{
	       		 	if (strcmp(pConc->szTipoConcepto , CONCEPTO_TRAFICO)==0)
	           			pide->dImpTrafico += dProrrateo;
	       			else 
	       		 		pide->dImpCBasico += dProrrateo;
				}
			}
		}
	}
	else
	{
		pabo = stBuscaAbonado(paux->sgte_abonado, lNumAbonado);
		if (pabo != NULL)
		{
			if(pabo->dFecVenta <= pfac->dFecEmision)
			{
				pide = stBuscaIdFactura(pabo->sgte_idfactura, pfac->lIndOrdenTotal);
				if (pide == NULL)
				{
					pide = (stIdFactura *) malloc (sizeof(stIdFactura));
		       		pide->lIndOrdenTotal 	= pfac->lIndOrdenTotal;
		       		pide->lCodCiclFact   	= pfac->lCodCiclFact;
	           		pide->dImpTrafico 		= 0.00;
					pide->dImpCBasico  		= 0.00;
		       		pide->sgte 				= pabo->sgte_idfactura;
		       		pabo->sgte_idfactura 	= pide;
					pabo->cIndConsidera 	= 'S';
				}
	       		pConc = stBuscaConcepto(paux->sgte_concfact, iCodConcepto);
	       		if (pConc != NULL)
	       		{
	       		 	if (strcmp(pConc->szTipoConcepto , CONCEPTO_TRAFICO)==0)
	           			pide->dImpTrafico += dProrrateo;
	       			else 
	       		 		pide->dImpCBasico += dProrrateo;
				}
			}
		}
	}
}
/*****************************************************************************/
/* Se asignan los bonos x cartera                                            */ 
/*****************************************************************************/
void vRecuperaMontosFactura()
{
	stUniverso	* paux;
	stAbonado 	* aaux;
	stFactura	* pfac;

	short		i;
	short 		iLastRows;
	short 		iFetchedRows;
	short 		iRetrievRows;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		iMaxFetch;
		char	szhSentencia[MAXARRAY];
		long	lhlIndOrdenTotal;
		long	lhNumAbonado[MAXFETCH];
		short	ihCodConcepto[MAXFETCH];
		double	dhImpConcepto[MAXFETCH];
	/* EXEC SQL END DECLARE SECTION; */ 


	iMaxFetch = MAXFETCH;

	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
		if (paux->cIndConsidera == 'S')
		{
			for (pfac = paux->sgte_factura; pfac != NULL; pfac = pfac->sgte)
				if (pfac->cIndConsidera == 'S')
				{
					lhlIndOrdenTotal = pfac->lIndOrdenTotal;
					sprintf(szhSentencia, " SELECT "
					 	" NUM_ABONADO, COD_CONCEPTO, IMP_CONCEPTO "
						" FROM %s "
						" WHERE IND_ORDENTOTAL = :v1 ",pfac->szFaHistConc);
						
					/* EXEC SQL PREPARE S FROM :szhSentencia; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )428;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhSentencia;
     sqlstm.sqhstl[0] = (unsigned long )2000;
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


					/* EXEC SQL DECLARE CUR_CONCEPTOS CURSOR FOR S; */ 

					
					/* EXEC SQL OPEN CUR_CONCEPTOS USING :lhlIndOrdenTotal; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )447;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhlIndOrdenTotal;
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



					iLastRows = 0;
					iFetchedRows = MAXFETCH;
					iRetrievRows = MAXFETCH;
    				while(iFetchedRows == iRetrievRows)
    				{
	        			 /* EXEC SQL FOR :iMaxFetch FETCH 	CUR_CONCEPTOS INTO 	
	        			 	:lhNumAbonado, :ihCodConcepto, :dhImpConcepto; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 8;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.iters = (unsigned int  )iMaxFetch;
             sqlstm.offset = (unsigned int  )466;
             sqlstm.selerr = (unsigned short)1;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqfoff = (         int )0;
             sqlstm.sqfmod = (unsigned int )2;
             sqlstm.sqhstv[0] = (unsigned char  *)lhNumAbonado;
             sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[0] = (         int  )sizeof(long);
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqharc[0] = (unsigned long  *)0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)ihCodConcepto;
             sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
             sqlstm.sqhsts[1] = (         int  )sizeof(short);
             sqlstm.sqindv[1] = (         short *)0;
             sqlstm.sqinds[1] = (         int  )0;
             sqlstm.sqharm[1] = (unsigned long )0;
             sqlstm.sqharc[1] = (unsigned long  *)0;
             sqlstm.sqadto[1] = (unsigned short )0;
             sqlstm.sqtdso[1] = (unsigned short )0;
             sqlstm.sqhstv[2] = (unsigned char  *)dhImpConcepto;
             sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
             sqlstm.sqhsts[2] = (         int  )sizeof(double);
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
							vAsignaConceptos(paux, pfac, ihCodConcepto[i],dhImpConcepto[i],lhNumAbonado[i]);
						}
					}
					/* EXEC SQL CLOSE CUR_CONCEPTOS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )493;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
     if (sqlca.sqlcode < 0) vSqlError();
}


				}
		} 
}
/*****************************************************************************/
/* Liberar Memoria para Enlaces Historicos                                   */
/*****************************************************************************/

void liberar_enlaceshist(stEnlaceHist * paux)
{
    stEnlaceHist *  raux;	
	   
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }  
    return;
}
/*****************************************************************************/
/* Liberar Memoria para Abonados (Montos)                                    */
/*****************************************************************************/
void liberar_idfactura(stIdFactura * paux)
{
    stIdFactura	*  raux;	
	   
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }      
}
/*****************************************************************************/
/* Liberar Memoria para Abonados                                             */
/*****************************************************************************/
void liberar_abonado(stAbonado * paux)
{
    stAbonado	*  raux;	
	   
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }     
}
/*****************************************************************************/
/* Liberar Memoria para Facturas                                             */
/*****************************************************************************/

void liberar_factura(stFactura * paux)
{
    stFactura	*  raux;	
	   
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }
}

/*****************************************************************************/
/* Libera Memoria Usada Por Universo                                         */
/*****************************************************************************/

void liberar_memoria(stUniverso * paux)
{
	stUniverso * raux;
	long	 	lCantMemoria = 0;
    if(paux!=NULL)
	{
		raux = paux->sgte;
		while (raux!=NULL)
		{
			free(paux);
			lCantMemoria++;
			paux = raux;
			raux = paux->sgte;
		}
		if(paux!=NULL) free(paux);
    }
    fprintf(stderr,"\nLibera_Memoria: Registros eliminados:[%ld]\n",lCantMemoria);
}

/*****************************************************************************/
/* Insercion de valores en salida                                            */
/*****************************************************************************/

void inserta_valores()
{
	stUniverso	* paux;
	stAbonado	* aaux;
	stIdFactura * pfac;
	long		lCantRegistros = 0;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIdCiclComis[11];
		long	lhCodCiclComis;
		int		ihCodTipoRed;
		char	szhCodPlanComis[7];
		int		ihCodConcepto;
		char    szhCodTipComis[3];
		long	lhCodComisionista;
		long	lhCodCliente;
		long	lhNumAbonado;
		long	lhCodAgencia;
		char    szhCodPlanTarif[4];
		char	szhCodTipVendedor[3];
		long	lhIndOrdenTotal;
		long	lhCodCiclFact;
		double	dhImpTrafico;
		double	dhImpCBasico;
		long	lhNumSecuencia;
	/* EXEC SQL END DECLARE SECTION; */ 


	lhCodCiclComis 			= stCiclo.lCodCiclComis;	
	strcpy(szhIdCiclComis	, stCiclo.szIdCiclComis);

	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
		if (paux->cIndConsidera == 'S')
		{
			ihCodTipoRed			= paux->iCodTipoRed;
			strcpy(szhCodPlanComis 	, paux->szCodPlanComis);
			ihCodConcepto			= paux->iCodConcepto;
			strcpy(szhCodTipComis	, paux->szCodTipComis);
			lhCodComisionista 		= paux->lCodComisonista;
			lhCodCliente 			= paux->lCodCliente;
	    	for (aaux = paux->sgte_abonado; aaux != NULL; aaux = aaux->sgte)
	       	{
				if (aaux->cIndConsidera == 'S')
			 	{
					lhNumAbonado	 		= 	aaux->lNumAbonado;
					lhCodAgencia	 		= 	aaux->lCodAgencia;
					strcpy(szhCodPlanTarif	, 	aaux->szCodPlanTarif);
					strcpy(szhCodTipVendedor,	aaux->szCodTipVendedor);
	
					for (pfac=aaux->sgte_idfactura; pfac != NULL; pfac = pfac->sgte)
					{
						lhIndOrdenTotal 	= 	pfac->lIndOrdenTotal;
						lhCodCiclFact	 	= 	pfac->lCodCiclFact;
						dhImpTrafico 		= 	pfac->dImpTrafico;
						dhImpCBasico  		= 	pfac->dImpCBasico; 
		
						/* EXEC SQL SELECT CMS_REG_SELECCION.nextval INTO :lhNumSecuencia FROM   DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 8;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b0  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )508;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
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


		
						lCantRegistros++;

						/* EXEC SQL INSERT INTO CMT_BONOSCARTERA(
							NUM_GENERAL, COD_TIPCOMIS, COD_COMISIONISTA, COD_AGENCIA, 
							COD_CLIENTE, NUM_ABONADO, COD_PLANTARIF, IND_ORDENTOTAL, 
							IMP_TRAFICO, IMP_CARGOBASICO, COD_CICLFACT, COD_PERIODO, 
							ID_PERIODO, COD_TIPORED, COD_TIPVENDEDOR, COD_PLANCOMIS, 
							COD_CONCEPTO) VALUES(
							:lhNumSecuencia, :szhCodTipComis, :lhCodComisionista, :lhCodAgencia, 
							:lhCodCliente, :lhNumAbonado, :szhCodPlanTarif, :lhIndOrdenTotal,
							:dhImpTrafico, :dhImpCBasico, :lhCodCiclFact, :lhCodCiclComis,
							:szhIdCiclComis, :ihCodTipoRed, :szhCodTipVendedor, :szhCodPlanComis,
							:ihCodConcepto); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 17;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "insert into CMT_BONOSCARTERA (NUM_GENERAL,COD_TIPCOMIS,\
COD_COMISIONISTA,COD_AGENCIA,COD_CLIENTE,NUM_ABONADO,COD_PLANTARIF,IND_ORDENTO\
TAL,IMP_TRAFICO,IMP_CARGOBASICO,COD_CICLFACT,COD_PERIODO,ID_PERIODO,COD_TIPORE\
D,COD_TIPVENDEDOR,COD_PLANCOMIS,COD_CONCEPTO) values (:b0,:b1,:b2,:b3,:b4,:b5,\
:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )527;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
      sqlstm.sqhstl[1] = (unsigned long )3;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lhCodComisionista;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgencia;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
      sqlstm.sqhstv[6] = (unsigned char  *)szhCodPlanTarif;
      sqlstm.sqhstl[6] = (unsigned long )4;
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&lhIndOrdenTotal;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&dhImpTrafico;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&dhImpCBasico;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCiclFact;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCiclComis;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)0;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)szhIdCiclComis;
      sqlstm.sqhstl[12] = (unsigned long )11;
      sqlstm.sqhsts[12] = (         int  )0;
      sqlstm.sqindv[12] = (         short *)0;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
      sqlstm.sqhstv[13] = (unsigned char  *)&ihCodTipoRed;
      sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[13] = (         int  )0;
      sqlstm.sqindv[13] = (         short *)0;
      sqlstm.sqinds[13] = (         int  )0;
      sqlstm.sqharm[13] = (unsigned long )0;
      sqlstm.sqadto[13] = (unsigned short )0;
      sqlstm.sqtdso[13] = (unsigned short )0;
      sqlstm.sqhstv[14] = (unsigned char  *)szhCodTipVendedor;
      sqlstm.sqhstl[14] = (unsigned long )3;
      sqlstm.sqhsts[14] = (         int  )0;
      sqlstm.sqindv[14] = (         short *)0;
      sqlstm.sqinds[14] = (         int  )0;
      sqlstm.sqharm[14] = (unsigned long )0;
      sqlstm.sqadto[14] = (unsigned short )0;
      sqlstm.sqtdso[14] = (unsigned short )0;
      sqlstm.sqhstv[15] = (unsigned char  *)szhCodPlanComis;
      sqlstm.sqhstl[15] = (unsigned long )7;
      sqlstm.sqhsts[15] = (         int  )0;
      sqlstm.sqindv[15] = (         short *)0;
      sqlstm.sqinds[15] = (         int  )0;
      sqlstm.sqharm[15] = (unsigned long )0;
      sqlstm.sqadto[15] = (unsigned short )0;
      sqlstm.sqtdso[15] = (unsigned short )0;
      sqlstm.sqhstv[16] = (unsigned char  *)&ihCodConcepto;
      sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[16] = (         int  )0;
      sqlstm.sqindv[16] = (         short *)0;
      sqlstm.sqinds[16] = (         int  )0;
      sqlstm.sqharm[16] = (unsigned long )0;
      sqlstm.sqadto[16] = (unsigned short )0;
      sqlstm.sqtdso[16] = (unsigned short )0;
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
	       	}
		}
	stStatusProc.lCantRegistros = lCantRegistros;
}
/*****************************************************************************/
/* Rutina principal.                                                         */
/*****************************************************************************/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
	long lSegIni, lSegFin;
	short ibiblio;
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
	lSegIni =lGetTimer();

	memset(&stArgs, 0, sizeof(rg_argumentos));
	memset(&proceso, 0, sizeof(proceso));
	memset(&stStatusProc, 0, sizeof(rg_estadistica));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/	
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
/* Inicializaci�n estructura de Bloque(proceso).                             */
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
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
	fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");                    
	if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)                                               
	{                                                                                                                  
	        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));
	}                                                                                                                  
	fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);                                         
/*---------------------------------------------------------------------------*/
/* GENERACION DEL NOMBRE Y CREACION DEL ARCHIVO DE LOG.                      */
/*---------------------------------------------------------------------------*/
	strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
        strncpy(szhSysDate, pszGetDateLog(),16);                                                           
	strcpy(stArgsLog.szProceso,LOGNAME);                                                                     
	strncpy(stArgsLog.szSysDate,szhSysDate,16);                                                                  
	sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
	                                                                                                         
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)                                                          
	{
	    fprintf(stderr, "\nArchivo [%s/%s_%s.log] No pudo ser abierto." ,stArgsLog.szPath,stArgsLog.szProceso,stArgsLog.szSysDate);                                  
	    fprintf(stderr, "Revise su existencia.\n");                                                          
	    fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
	    fprintf(stderr, "Proceso finalizado con error.\n");                                                  
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
	fprintf(pfLog, "Base de datos : %s\n\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog,"\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
             
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
	fprintf(pfLog,"Periodo                : %s\n", stArgs.szIdPeriodo);
    fprintf(pfLog,"Codigo de Bloque       : %s\n", stArgs.szBloque);
    fprintf(pfLog,"Codigo de Proceso      : %s\n", stArgs.szProceso);
    fprintf(pfLog,"Secuencia de Bloque    : %d\n", stArgs.izSecuencia);


/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
        /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )610;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/*  PROGRAMA PRINCIPAL                                                       */
/*---------------------------------------------------------------------------*/        

/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA CICLOS DE PROCESO                                        */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de ciclo de proceso...(vCargaCiclo)\n\n");       
    fprintf(stderr, "Carga estructura de ciclo de proceso...(vCargaCiclo)\n\n");       
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no bExiste.(vCargaCiclo)\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.(vCargaCiclo)\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no bExiste.(vCargaCiclo)\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.(vCargaCiclo)\n");
    	exit(EXIT_101);
    }
/*--------------------------------------------------------------------------*/
/* Carga Estructura de Conceptos y Tipos de Red	a Procesar...(Est�ndar)	    */
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
/* CARGA UNIVERSO DE DATOS                                                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog,  "Carga Universo de datos a procesar...\n\n");       
    fprintf(stderr, "Carga Universo de datos a procesar...\n\n");       
	vSeleccionarUniverso();
   
/*--------------------------------------------------------------------------*/
/* Almacenando tabla CO_CANCELADOS                                          */
/*--------------------------------------------------------------------------*/    
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog,  "Carga Tipos de Documentos a procesar...\n\n");       
    fprintf(stderr, "Carga Tipos de Documentos a procesar...\n\n");       
  	vCargaTipoDocumentos();

    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Almacena tabla CO_CANCELADOS...\n\n");  
    fprintf(stderr, "Almacena tabla CO_CANCELADOS...\n\n");  
	vCargaFacturas();
/*--------------------------------------------------------------------------*/
/* Asigna Facturas a Clientes                                               */
/*--------------------------------------------------------------------------*/    
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Asignando Facturas a Clientes...(asignar_facturas)\n\n");  
    fprintf(stderr, "Asignando Facturas a Clientes...(asignar_facturas)\n\n");
    vAsignaFacturas();

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA CCANCELADO                             */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Libera memoria utilizada por lista de Clientes Cancelados.....(liberar_co_cancelados)\n\n");  
    fprintf(stderr, "Libera memoria utilizada por lista de Clientes Cancelados.....(liberar_co_cancelados)\n\n");    
    vLiberaCancelados(lstCancelados);
/*---------------------------------------------------------------------------*/
/* Verifican No existencia en CO_CARTERA                                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Verificando No existencia en CO_CARTERA........\n\n");  
    fprintf(stderr, "Verificando No existencia en CO_CARTERA........\n\n");    
    vValidaCancelados();
/*---------------------------------------------------------------------------*/
/* Compara con tabla FA_HISTDOCU                                             */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Comparando con tabla FA_HISTDOCU...()\n\n");  
    fprintf(stderr, "Comparando con tabla FA_HISTDOCU...()\n\n");    
	vRecuperaFactura();
	
/*---------------------------------------------------------------------------*/
/* Almacena en Memoria FA_ENLACEHIST                                         */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Almacenando en Memoria FA_ENLACEHIST...()\n\n");  
    fprintf(stderr, "Almacenando en Memoria FA_ENLACEHIST...()\n\n");    
    vCargaEnlaceHist();

/*---------------------------------------------------------------------------*/
/* Asigna tabla de enlace para Ciclos                                        */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Asignando tabla de enlace para Ciclos...()\n\n");  
    fprintf(stderr, "Asignando tabla de enlace para Ciclos...()\n\n"); 
    vDeterminaCicloFactura();
    
/*---------------------------------------------------------------------------*/
/* Asignando Bonos por Cartera                                               */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Asignando Bonos por Cartera...()\n\n");  
    fprintf(stderr, "Asignando Bonos por Cartera...()\n\n");     
	vRecuperaMontosFactura();

/*---------------------------------------------------------------------------*/
/* Inserta Valores en Salida                                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
  	fprintf(pfLog, "Insertando Valores en Salida(s)...(inserta_valores)\n\n");  
    fprintf(stderr, "Insertando Valores en Salida(s)...(inserta_valores)\n\n");        
	inserta_valores();

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA DE UNIVERSO                            */
/*---------------------------------------------------------------------------*/   
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
	fprintf(pfLog, "Liberando Memoria usada por lista Universo...(liberar_memoria)\n\n");  
    fprintf(stderr, "Liberando Memoria usada por lista Universo...(liberar_memoria)\n\n");    
    liberar_memoria(lstUniverso); 
    
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA DE UNIVERSO                            */
/*---------------------------------------------------------------------------*/   
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
	fprintf(pfLog, "Liberando Memoria usada por lista de enlaces historicos...(liberar_enlaceshist)\n\n");  
    fprintf(stderr, "Liberando Memoria usada por lista de enlaces historicos...(liberar_enlaceshist)\n\n");    
	liberar_enlaceshist(lstEnlaceHist); 

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA DE ABONADOS                            */
/*---------------------------------------------------------------------------*/   
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
	fprintf(pfLog, "Liberando Memoria usada por lista de Abonados...(liberar_abonado)\n\n");  
    fprintf(stderr, "Liberando Memoria usada por lista de Abonados...(liberar_abonado)\n\n");    
	liberar_abonado(lstAbonado);

/*------------------------------------------------------------------*/
/* RECUPERACION DE LOS SEGUNDOS REALES OCUPADOS POR EL PROCESO.    */
/*-----------------------------------------------------------------*/
   	lSegFin=lGetTimer();
   	stStatusProc.lSegProceso = lSegFin - lSegIni;

   	if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"", stStatusProc.lSegProceso, stStatusProc.lCantRegistros))
      exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));

	/* EXEC SQL COMMIT WORK; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )625;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


/*-----------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                 */
/*-----------------------------------------------------------------------*/   
  
   	fprintf(pfLog, "Estadistica del proceso\n");
   	fprintf(pfLog, "------------------------\n");
   	fprintf(pfLog, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);
   	fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

   	fprintf(stderr, "Estadistica del proceso\n");
   	fprintf(stderr, "------------------------\n");
   	fprintf(stderr, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);
   	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

	fprintf(pfLog ,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
	fprintf(stderr,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
	fclose(pfLog);
	return(EXIT_0);
}


/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

