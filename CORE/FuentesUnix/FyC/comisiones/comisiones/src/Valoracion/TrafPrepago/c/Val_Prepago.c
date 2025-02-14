
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
    "./pc/Val_Prepago.pc"
};


static unsigned int sqlctx = 27731235;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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
"select A.NUM_PERFIL ,A.NUM_PERIODO ,NVL(B.TIP_UNITAS,'X') ,NVL(B.UNI_ENTRADA\
,0) ,NVL(B.UNI_SALIDA,0) ,NVL(B.UNI_TOTAL,0) ,NVL(B.MTO_RECARGA,0) ,NVL(B.IMP_\
COMISION,0) ,NVL(B.IMP_CASTIGO,0) ,NVL(B.OPE_ENTRADA,'O') ,NVL(B.OPE_SALIDA,'O\
') ,NVL(B.OPE_RECARGA,'O') ,NVL(B.COD_ORIGEN,'O')  from CM_CRITERIOS_PERFIL_TD\
 A ,CM_PERFILES_TD B where (A.NUM_CRITERIO=:b0 and B.NUM_PERFIL=A.NUM_PERFIL) \
          ";

 static char *sq0003 = 
"select NUM_CRITERIO_REQ ,NUM_PERFIL_REQ ,NUM_PERIODO_REQ ,IND_CUMPLIMIENTO  \
from CM_REQUISITOS_TD where ((NUM_CRITERIO_REL=:b0 and NUM_PERFIL_REL=:b1) and\
 NUM_PERIODO_REL=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,125,0,4,80,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
36,0,0,2,398,0,9,157,0,0,1,1,0,1,0,1,3,0,0,
55,0,0,2,0,0,13,161,0,0,13,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
122,0,0,2,0,0,15,201,0,0,0,0,0,1,0,
137,0,0,3,186,0,9,244,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
164,0,0,3,0,0,13,248,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
195,0,0,3,0,0,15,270,0,0,0,0,0,1,0,
210,0,0,4,0,0,17,401,0,0,1,1,0,1,0,1,97,0,0,
229,0,0,4,0,0,45,405,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
260,0,0,4,0,0,13,410,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,
97,0,0,
299,0,0,4,0,0,15,431,0,0,0,0,0,1,0,
314,0,0,5,0,0,17,512,0,0,1,1,0,1,0,1,97,0,0,
333,0,0,5,0,0,45,516,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
368,0,0,5,0,0,13,518,0,0,1,0,0,1,0,2,3,0,0,
387,0,0,6,224,0,4,564,0,0,6,5,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
426,0,0,4,0,0,17,628,0,0,1,1,0,1,0,1,97,0,0,
445,0,0,4,0,0,45,632,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
476,0,0,4,0,0,13,635,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
499,0,0,4,0,0,15,642,0,0,0,0,0,1,0,
514,0,0,7,190,0,3,897,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
565,0,0,8,226,0,3,904,0,0,11,11,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,1,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
624,0,0,9,12,0,1,1039,0,0,0,0,0,1,0,
639,0,0,10,48,0,1,1104,0,0,0,0,0,1,0,
654,0,0,11,0,0,30,1202,0,0,0,0,0,1,0,
};


/* ********************************************************************** */
/*  Programa encargado de valorizar Prepago                               */
/* ---------------------------------------------------------------------- */
/*  Version 2 - Revision 01.                                              */
/*  Inicio: 9 de Septiembre 2002.                                         */
/*  Autor : Nelson Contreras Helena.                                      */
/* ********************************************************************** */
/*  Modificacion por PGonzaleg                                            */
/*  Inicio: Lunes 2 de diciembre de 2002.                                 */
/*  Fin:    Lunes 2 de diciembre de 2002.                                 */
/*  Autor : Patricio Gonzalez Gomez                                       */
/*  Modificacion de condiciones en los WHERE referentes a la tabla        */
/*  CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y      */
/*  COD_PARAMETRO.                                                        */
/* ********************************************************************** */
/*  Modificado  por Jaime Vargas Morales                                  */
/*  Inicio       : Miercoles 8 de Enero 2003                              */
/*  Descripcion  : dicriminar por en concepto IND_PROCEQUI = 'E'          */
/*                 cuando recupere las habilitaciones                     */
/*  ********************************************************************  */
/*  Modificado Por Fabián Aedo R.                                         */
/*  Inicio       : Miécoles 15 de Octubre 2003 (VERSION CUZCO).           */
/*  Descripción  :                                                        */
/* 	- Se normalizan nombres de estructuras y variables                    */
/* 	- Se quita el código basura acumulado (comentariado, y no usado).     */
/*  - Se corrige función main, adecuandola a estándares de comisiones     */
/* 	- Se aplican cambios relacionados con Red de Ventas                   */
/*  - Se aplican cambios relacionados con Planes de Comisiones            */
/*  - Se aplican cambios relacionados con Ciclos Promocionales            */
/*  - Se aplica evaluación de Recargas de Minutos, dentro de la definic.  */
/* 	  de perfiles de tráfico.                                             */
/* ********************************************************************** */
#include "Val_Prepago.h"
#include "GEN_biblioteca.h"
#include <geora.h>
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con	Oracle.		         */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhUser[30]			= "";
	char	szhPass[30]			= "";
	char	szhSysDate [17]		= "";
	char	szFechaYYYYMMDD[9]	= "";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* CONSTRUYE ESTRUCTURA PRINCIPAL DE CRITERIOS PERFILES Y REQUISITOS.        */
/*---------------------------------------------------------------------------*/
stCriterios * vLlenaTasador()
{
	stCriterios 		* pCrit;

	stCriterios 		* qaux;
	stConceptosProc 	* paux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int		ihCodTipoRed;
    	int		ihCodConcepto;
    	char	szhCodPlanComis[7];
    	int		ihNumCriterio;
    /* EXEC SQL END DECLARE SECTION; */ 

	
	pCrit        = NULL;
	qaux         = NULL;	

	for (paux = lstConceptosProc; paux!=NULL; paux = paux->sgte)
	{
		ihCodTipoRed   			= paux->iCodTipoRed;  
		ihCodConcepto  			= paux->iCodConcepto; 
		strcpy(szhCodPlanComis	, paux->szCodPlanComis);

		/* EXEC SQL SELECT NUM_CRITERIO
		INTO :ihNumCriterio
		FROM CM_CRITERIOS_CANAL_TD
		WHERE COD_TIPORED 	= :ihCodTipoRed
		  AND COD_PLANCOMIS = :szhCodPlanComis
		  AND COD_CONCEPTO 	= :ihCodConcepto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NUM_CRITERIO into :b0  from CM_CRITERIOS_CANAL_TD wh\
ere ((COD_TIPORED=:b1 and COD_PLANCOMIS=:b2) and COD_CONCEPTO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihNumCriterio;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanComis;
  sqlstm.sqhstl[2] = (unsigned long )7;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodConcepto;
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
  if (sqlca.sqlcode < 0) vSqlError();
}


		
		pCrit  = (stCriterios *) malloc (sizeof(stCriterios));
		
		pCrit->iCodTipoRed     			= ihCodTipoRed;
		strcpy(pCrit->szCodPlanComis  	, szhCodPlanComis);
		pCrit->iCodConcepto    			= ihCodConcepto;
		strcpy(pCrit->szCodTipComis		, paux->szCodTipComis);
		strcpy(pCrit->szFecDesde      	, paux->szFecDesde);
		strcpy(pCrit->szFecHasta      	, paux->szFecHasta);
		strcpy(pCrit->szCodTecnologia 	, paux->szCodTecnologia);
		strcpy(pCrit->szCodUniverso   	, paux->szCodUniverso);
		pCrit->iNumCriterio    			= ihNumCriterio;
		pCrit->sgte_perfil				= stObtienePerfiles(pCrit->iNumCriterio);
		pCrit->sgte						= qaux;
		qaux       					    = pCrit;
	}
    return qaux;
}
/*---------------------------------------------------------------------------*/
/* CREA SUB ESTRUCTURA DE PERFILES DE EVALUACION, PARA CADA CRITERIO.        */
/*---------------------------------------------------------------------------*/
stPerfil * stObtienePerfiles(int iNumCriterio)
{
	stPerfil *paux;
	stPerfil *qaux;
	int                        i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	   	int 	ihNumCriterio;
	   	int     ihNumPerfil[MAXFETCH];
	    int     ihNumPeriodo[MAXFETCH];
	    char    chTipUnitas[MAXFETCH];
	    long    lhUniEntrada[MAXFETCH];
	    long    lhUniSalida[MAXFETCH];
	    long    lhUniTotal[MAXFETCH];
		double	dhImpRecarga[MAXFETCH];
	    double  dhImpComision[MAXFETCH];
	    double  dhImpCastigo[MAXFETCH];
	    char	chOpeEntrada[MAXFETCH];
	    char	chOpeSalida[MAXFETCH];
	    char	chOpeRecarga[MAXFETCH];
	    char	szhCodOrigen[MAXFETCH][6];
	    long	lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;
	
    lMaxFetch      = MAXFETCH;     
	ihNumCriterio = iNumCriterio;

    /* EXEC SQL DECLARE Cursor_Perfiles CURSOR FOR SELECT   
    			A.NUM_PERFIL,
                A.NUM_PERIODO,
                NVL(B.TIP_UNITAS,'X'),
                NVL(B.UNI_ENTRADA,0),
                NVL(B.UNI_SALIDA,0),
                NVL(B.UNI_TOTAL,0),
                NVL(B.MTO_RECARGA,0),
                NVL(B.IMP_COMISION,0),
                NVL(B.IMP_CASTIGO,0),
                NVL(B.OPE_ENTRADA,'O'),
                NVL(B.OPE_SALIDA,'O'),
                NVL(B.OPE_RECARGA,'O'),
                NVL(B.COD_ORIGEN,'O')
       FROM  	CM_CRITERIOS_PERFIL_TD A,
                CM_PERFILES_TD B
       WHERE    A.NUM_CRITERIO = :ihNumCriterio
       AND      B.NUM_PERFIL   = A.NUM_PERFIL; */ 


	/* EXEC SQL OPEN  Cursor_Perfiles; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )36;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumCriterio;
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
 if (sqlca.sqlcode < 0) vSqlError();
}



    while (iFetchedRows == iRetrievRows)
    {
          /* EXEC SQL for :lMaxFetch FETCH Cursor_Perfiles INTO
				:ihNumPerfil,
				:ihNumPeriodo,
				:chTipUnitas,
				:lhUniEntrada,
				:lhUniSalida,
				:lhUniTotal,
				:dhImpRecarga,
				:dhImpComision,
				:dhImpCastigo,
				:chOpeEntrada,
				:chOpeSalida,
				:chOpeRecarga,
				:szhCodOrigen; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 13;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )lMaxFetch;
          sqlstm.offset = (unsigned int  )55;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqfoff = (         int )0;
          sqlstm.sqfmod = (unsigned int )2;
          sqlstm.sqhstv[0] = (unsigned char  *)ihNumPerfil;
          sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[0] = (         int  )sizeof(int);
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqharc[0] = (unsigned long  *)0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)ihNumPeriodo;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[1] = (         int  )sizeof(int);
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqharc[1] = (unsigned long  *)0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)chTipUnitas;
          sqlstm.sqhstl[2] = (unsigned long )500;
          sqlstm.sqhsts[2] = (         int  )500;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)lhUniEntrada;
          sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[3] = (         int  )sizeof(long);
          sqlstm.sqindv[3] = (         short *)0;
          sqlstm.sqinds[3] = (         int  )0;
          sqlstm.sqharm[3] = (unsigned long )0;
          sqlstm.sqharc[3] = (unsigned long  *)0;
          sqlstm.sqadto[3] = (unsigned short )0;
          sqlstm.sqtdso[3] = (unsigned short )0;
          sqlstm.sqhstv[4] = (unsigned char  *)lhUniSalida;
          sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[4] = (         int  )sizeof(long);
          sqlstm.sqindv[4] = (         short *)0;
          sqlstm.sqinds[4] = (         int  )0;
          sqlstm.sqharm[4] = (unsigned long )0;
          sqlstm.sqharc[4] = (unsigned long  *)0;
          sqlstm.sqadto[4] = (unsigned short )0;
          sqlstm.sqtdso[4] = (unsigned short )0;
          sqlstm.sqhstv[5] = (unsigned char  *)lhUniTotal;
          sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[5] = (         int  )sizeof(long);
          sqlstm.sqindv[5] = (         short *)0;
          sqlstm.sqinds[5] = (         int  )0;
          sqlstm.sqharm[5] = (unsigned long )0;
          sqlstm.sqharc[5] = (unsigned long  *)0;
          sqlstm.sqadto[5] = (unsigned short )0;
          sqlstm.sqtdso[5] = (unsigned short )0;
          sqlstm.sqhstv[6] = (unsigned char  *)dhImpRecarga;
          sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[6] = (         int  )sizeof(double);
          sqlstm.sqindv[6] = (         short *)0;
          sqlstm.sqinds[6] = (         int  )0;
          sqlstm.sqharm[6] = (unsigned long )0;
          sqlstm.sqharc[6] = (unsigned long  *)0;
          sqlstm.sqadto[6] = (unsigned short )0;
          sqlstm.sqtdso[6] = (unsigned short )0;
          sqlstm.sqhstv[7] = (unsigned char  *)dhImpComision;
          sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[7] = (         int  )sizeof(double);
          sqlstm.sqindv[7] = (         short *)0;
          sqlstm.sqinds[7] = (         int  )0;
          sqlstm.sqharm[7] = (unsigned long )0;
          sqlstm.sqharc[7] = (unsigned long  *)0;
          sqlstm.sqadto[7] = (unsigned short )0;
          sqlstm.sqtdso[7] = (unsigned short )0;
          sqlstm.sqhstv[8] = (unsigned char  *)dhImpCastigo;
          sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[8] = (         int  )sizeof(double);
          sqlstm.sqindv[8] = (         short *)0;
          sqlstm.sqinds[8] = (         int  )0;
          sqlstm.sqharm[8] = (unsigned long )0;
          sqlstm.sqharc[8] = (unsigned long  *)0;
          sqlstm.sqadto[8] = (unsigned short )0;
          sqlstm.sqtdso[8] = (unsigned short )0;
          sqlstm.sqhstv[9] = (unsigned char  *)chOpeEntrada;
          sqlstm.sqhstl[9] = (unsigned long )500;
          sqlstm.sqhsts[9] = (         int  )500;
          sqlstm.sqindv[9] = (         short *)0;
          sqlstm.sqinds[9] = (         int  )0;
          sqlstm.sqharm[9] = (unsigned long )0;
          sqlstm.sqadto[9] = (unsigned short )0;
          sqlstm.sqtdso[9] = (unsigned short )0;
          sqlstm.sqhstv[10] = (unsigned char  *)chOpeSalida;
          sqlstm.sqhstl[10] = (unsigned long )500;
          sqlstm.sqhsts[10] = (         int  )500;
          sqlstm.sqindv[10] = (         short *)0;
          sqlstm.sqinds[10] = (         int  )0;
          sqlstm.sqharm[10] = (unsigned long )0;
          sqlstm.sqadto[10] = (unsigned short )0;
          sqlstm.sqtdso[10] = (unsigned short )0;
          sqlstm.sqhstv[11] = (unsigned char  *)chOpeRecarga;
          sqlstm.sqhstl[11] = (unsigned long )500;
          sqlstm.sqhsts[11] = (         int  )500;
          sqlstm.sqindv[11] = (         short *)0;
          sqlstm.sqinds[11] = (         int  )0;
          sqlstm.sqharm[11] = (unsigned long )0;
          sqlstm.sqadto[11] = (unsigned short )0;
          sqlstm.sqtdso[11] = (unsigned short )0;
          sqlstm.sqhstv[12] = (unsigned char  *)szhCodOrigen;
          sqlstm.sqhstl[12] = (unsigned long )6;
          sqlstm.sqhsts[12] = (         int  )6;
          sqlstm.sqindv[12] = (         short *)0;
          sqlstm.sqinds[12] = (         int  )0;
          sqlstm.sqharm[12] = (unsigned long )0;
          sqlstm.sqharc[12] = (unsigned long  *)0;
          sqlstm.sqadto[12] = (unsigned short )0;
          sqlstm.sqtdso[12] = (unsigned short )0;
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
			paux = (stPerfil *) malloc(sizeof(stPerfil));
			paux->iNumPerfil     		= ihNumPerfil[i];
			paux->iNumPeriodo    		= ihNumPeriodo[i];
			paux->cTipUnitas     		= chTipUnitas[i];
			paux->lUniEntrada    		= lhUniEntrada[i];
			paux->lUniSalida     		= lhUniSalida[i];
			paux->lUniTotal      		= lhUniTotal[i];
			paux->dImpRecarga    		= dhImpRecarga[i];
			paux->dImpComision   		= dhImpComision[i];
			paux->dImpCastigo    		= dhImpCastigo[i];
			paux->cOpeEntrada    		= chOpeEntrada[i];
			paux->cOpeSalida     		= chOpeSalida[i];
			paux->cOpeRecarga    		= chOpeRecarga[i];
			strcpy(paux->szCodOrigen	, szfnTrim(szhCodOrigen[i]));
			paux->sgte_requisito 		= stObtieneRequisitos(iNumCriterio, paux->iNumPerfil, paux->iNumPeriodo);
			
			paux->sgte					= qaux;
			qaux 						= paux;
		}
	}
    /* EXEC SQL CLOSE  Cursor_Perfiles; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )122;
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
/* FUNCION QUE CARGA LA SUBESTRUCTURA DE REQUISITOS POR PERFIL               */
/*---------------------------------------------------------------------------*/
stRequisito * stObtieneRequisitos(int iNumCriterio, int iNumPerfil, int iNumPeriodo)
{
	stRequisito * paux;
	stRequisito * qaux;
	int                        i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int    ihNumCriterio;
         int    ihNumPerfil;
         int    ihNumPeriodo;
         int    ihNumCriterio_req[MAXFETCH];
         int    ihNumPerfil_req[MAXFETCH];
         int    ihNumPeriodo_req[MAXFETCH];
         char   chIndCumplimiento[MAXFETCH];
         long	lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 

	
	paux = NULL;
	qaux = NULL;
	ihNumCriterio  = iNumCriterio;
	ihNumPerfil    = iNumPerfil;
	ihNumPeriodo   = iNumPeriodo;
	lMaxFetch      = MAXFETCH;     

    /* EXEC SQL DECLARE Cursor_requisitos CURSOR FOR
        SELECT NUM_CRITERIO_REQ,
               NUM_PERFIL_REQ,
               NUM_PERIODO_REQ,
               IND_CUMPLIMIENTO
        FROM   CM_REQUISITOS_TD
        WHERE  NUM_CRITERIO_REL = :ihNumCriterio
           AND NUM_PERFIL_REL   = :ihNumPerfil
           AND NUM_PERIODO_REL  = :ihNumPeriodo; */ 


    /* EXEC SQL OPEN Cursor_requisitos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )137;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNumCriterio;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumPerfil;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihNumPeriodo;
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



    while (iFetchedRows == iRetrievRows)
    {
          /* EXEC SQL for :lMaxFetch FETCH Cursor_requisitos INTO
                    :ihNumCriterio_req,
                    :ihNumPerfil_req,
                    :ihNumPeriodo_req,
                    :chIndCumplimiento; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 13;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )lMaxFetch;
          sqlstm.offset = (unsigned int  )164;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqfoff = (         int )0;
          sqlstm.sqfmod = (unsigned int )2;
          sqlstm.sqhstv[0] = (unsigned char  *)ihNumCriterio_req;
          sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[0] = (         int  )sizeof(int);
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqharc[0] = (unsigned long  *)0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)ihNumPerfil_req;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[1] = (         int  )sizeof(int);
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqharc[1] = (unsigned long  *)0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)ihNumPeriodo_req;
          sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[2] = (         int  )sizeof(int);
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqharc[2] = (unsigned long  *)0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)chIndCumplimiento;
          sqlstm.sqhstl[3] = (unsigned long )500;
          sqlstm.sqhsts[3] = (         int  )500;
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



		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
		iLastRows    = sqlca.sqlerrd[2];
		    
		for (i=0; i < iRetrievRows; i++)
		{
            paux = (stRequisito *) malloc (sizeof(stRequisito));

            paux->iNumCriterio_req 	= ihNumCriterio_req[i];
            paux->iNumPerfil_req   	= ihNumPerfil_req[i];
            paux->iNumPeriodo_req  	= ihNumPeriodo_req[i];
            paux->cIndCumplimiento 	= chIndCumplimiento[i];

            paux->sgte 				= qaux;
            qaux 					= paux;
        }
	}
    /* EXEC SQL CLOSE Cursor_requisitos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )195;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    return paux;
}

/*---------------------------------------------------------------------------*/
/* MUESTRA LA ESTRUCTURA DE VALORACION                                       */
/*---------------------------------------------------------------------------*/
void vMuestraEstructura()
{ 
	stCriterios  	* paux;
	stPerfil		* qaux;
	stRequisito		* raux;

	if (lstCriterios  != NULL) 
	{
		fprintf(pfLog ,"\n[vMuestraEstructura] Estructura de Criterios de Evaluacion.\n");
		fprintf(stderr,"\n[vMuestraEstructura] Estructura de Criterios de Evaluacion.\n");
		for (paux = lstCriterios; paux != NULL; paux = paux->sgte)
		{
			fprintf(pfLog ,"==============================================================================\n");
			fprintf(pfLog ,"\tTipoRed:[%d] PlanComis:[%s] Concepto:[%d] Criterio[%d]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->iNumCriterio );
			fprintf(stderr,"==============================================================================\n");
			fprintf(stderr,"\tTipoRed:[%d] PlanComis:[%s] Concepto:[%d] Criterio[%d]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->iNumCriterio );
	
			fprintf(pfLog ,"===PERFILES===================================================================\n");
			fprintf(stderr,"===PERFILES===================================================================\n");
	
			for ( qaux = paux->sgte_perfil; qaux != NULL; qaux = qaux->sgte)
	        {
				fprintf(stderr,"\t\tNum Perfil:[%d] Num Periodo:[%d] cTipUnitas:[%c]\n"
	                          "\t\tTrafico: Entrada:[%d] [%c] Salida:[%d] [%c] Total:[%d]\n"
	                          "\t\tRecargas: [%c] Origen:[%s] Monto Mínimo:[%6.2f]\n"
	                          "\t\tdImpComision:[%f] dImpCastigo:[%f]\n"
	                          ,qaux->iNumPerfil	 ,qaux->iNumPeriodo	,qaux->cTipUnitas
	                          ,qaux->lUniEntrada ,qaux->cOpeEntrada	,qaux->lUniSalida,	qaux->cOpeSalida
	                          ,qaux->lUniTotal	 ,qaux->cOpeRecarga	,qaux->szCodOrigen, qaux->dImpRecarga
	                          ,qaux->dImpComision,qaux->dImpCastigo);
	
				fprintf(pfLog,"\t\tNum Perfil:[%d] Num Periodo:[%d] cTipUnitas:[%c]\n"
	                          "\t\tTrafico: Entrada:[%d] [%c] Salida:[%d] [%c] Total:[%d]\n"
	                          "\t\tRecargas: [%c] Origen:[%s] Monto Mínimo:[%6.2f]\n"
	                          "\t\tdImpComision:[%f] dImpCastigo:[%f]\n"
	                          ,qaux->iNumPerfil	 ,qaux->iNumPeriodo	,qaux->cTipUnitas
	                          ,qaux->lUniEntrada ,qaux->cOpeEntrada	,qaux->lUniSalida,	qaux->cOpeSalida
	                          ,qaux->lUniTotal	 ,qaux->cOpeRecarga	,qaux->szCodOrigen, qaux->dImpRecarga
	                          ,qaux->dImpComision,qaux->dImpCastigo);
	
				fprintf(stderr,"===REQUISITOS=================================================================\n");
				fprintf(pfLog ,"===REQUISITOS=================================================================\n");
	            for ( raux = qaux->sgte_requisito; raux !=NULL ; raux= raux->sgte)
				{	
					fprintf(stderr,"\t\t\t Criterio:[%d] Perfil:[%d] Periodo:[%d] IndCumplimiento:[%c]\n", raux->iNumCriterio_req, raux->iNumPerfil_req, raux->iNumPeriodo_req, raux->cIndCumplimiento);
					fprintf(pfLog ,"\t\t\t Criterio:[%d] Perfil:[%d] Periodo:[%d] IndCumplimiento:[%c]\n", raux->iNumCriterio_req, raux->iNumPerfil_req, raux->iNumPeriodo_req, raux->cIndCumplimiento);
				}
			}
		}
	}
}
/*---------------------------------------------------------------------------*/
/* RECUPERA LAS VENTAS PARA LA EVALUACON DE UN PERFIL DE TRAFICO/RECARGA     */
/*---------------------------------------------------------------------------*/
stVentas * stObtieneVentas(stCriterios *pCrit, stPerfil *pPerf)
{
	stVentas 		* paux;
	stVentas 		* qaux;

	char 			* szDesError;
	char			* szTablaLogica;
    char 			* szTablaFisica;

	int				i;
	short          	iLastRows    = 0;
	int            	iFetchedRows = MAXFETCH;
	int            	iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long	lhPeriodoHab;
        char	szhIdPeriodoHab[11];
        int  	ihNumPeriodo;
        long 	lhCodPeriodo;
        int		ihCodTipoRed;
        char 	szhFecDesde[9];
        char 	szhFecHasta[9];
        char 	szhSentencia[500];

        long 	lhNumGeneral[MAXFETCH] ;
        long 	lhCodComisionista[MAXFETCH];
        long 	lhNumCelular[MAXFETCH];
        char 	szhNumSerie[MAXFETCH][26];
		long	lhNumAbonado[MAXFETCH];
		long 	lMaxFetch;
		char    szhFechaEvento [MAXFETCH][11];

    /* EXEC SQL END DECLARE SECTION; */ 


    paux = NULL;
	qaux = NULL;

    fprintf(pfLog ,"\n\t[stObtieneVentas]Seleccionando Ventas Perfil:[%d] Periodo[%d]\n", pPerf->iNumPerfil, pPerf->iNumPeriodo);
    fprintf(stderr,"\n\t[stObtieneVentas]Seleccionando Ventas Perfil:[%d] Periodo[%d]\n", pPerf->iNumPerfil, pPerf->iNumPeriodo);
	
	lhCodPeriodo 			= stCiclo.lCodCiclComis;
    ihNumPeriodo 			= pPerf->iNumPeriodo;
    lhPeriodoHab 			= lNewCiclComis(lhCodPeriodo,-1*ihNumPeriodo);  
    strcpy(szhIdPeriodoHab	, szNewCiclComis(lhPeriodoHab));
	strcpy(szTablaLogica	, "CMT_HABIL_PREPAGO");

        
	if ( lhPeriodoHab == stCiclo.lCodCiclComis )
		strcpy(szTablaFisica,szTablaLogica);
	else
	    if (!iBuscaTablaFisica(szTablaLogica, szhIdPeriodoHab, szTablaFisica))
		{	
            fprintf(pfLog ,"\n[stObtieneVentas] No hay Datos para Periodo:[%ld].\n\n", lhPeriodoHab);
            fprintf(stderr,"\n[stObtieneVentas] No hay Datos para Periodo:[%ld].\n\n", lhPeriodoHab);
            return NULL;
    	}

	ihCodTipoRed			= pCrit->iCodTipoRed;
	strcpy(szhFecDesde		, pCrit->szFecDesde);
	strcpy(szhFecHasta		, pCrit->szFecHasta);

    sprintf(szhSentencia, "SELECT NUM_GENERAL, COD_COMISIONISTA, NUM_CELULAR, NUM_SERIE, NUM_ABONADO , TO_CHAR(FEC_HABILITACION, 'DD-MM-YYYY')"
						  " FROM %s "
                          " WHERE COD_TIPRED   = :v1 "
                          "   AND ID_PERIODO   = :v2 "
                          "   AND FEC_HABILITACION BETWEEN TO_DATE( :v3 ,'DDD-MM-YYYY') "
                          "                            AND TO_DATE( :v4 ,'DDD-MM-YYYY') "
                          "   AND IND_PROCEQUI = 'E' "
                          , szTablaFisica);
	
	/* EXEC SQL PREPARE PRE_CURSOR FROM :szhSentencia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )210;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSentencia;
 sqlstm.sqhstl[0] = (unsigned long )500;
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


	
	/* EXEC SQL DECLARE CUR_HABILITACIONES CURSOR for PRE_CURSOR; */ 

	
	/* EXEC SQL OPEN CUR_HABILITACIONES USING :ihCodTipoRed, :szhIdPeriodoHab, :szhFecDesde, :szhFecHasta; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )229;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodoHab;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
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
 if (sqlca.sqlcode < 0) vSqlError();
}



    lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch FETCH CUR_HABILITACIONES INTO
            :lhNumGeneral, :lhCodComisionista, :lhNumCelular, :szhNumSerie, lhNumAbonado,szhFechaEvento; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )260;
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
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumCelular;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[3] = (unsigned long )26;
  sqlstm.sqhsts[3] = (         int  )26;
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
  sqlstm.sqhstv[5] = (unsigned char  *)szhFechaEvento;
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
  if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
            qaux  = (stVentas *) malloc (sizeof(stVentas));
            qaux->lNumGeneral      	= lhNumGeneral[i];
            qaux->lCodComisionista 	= lhCodComisionista[i];
            qaux->lNumCelular      	= lhNumCelular[i];
            strcpy(qaux->szNumSerie	, szfnTrim(szhNumSerie[i]));
			qaux->lCodPeriodoHab	= lhPeriodoHab;
			qaux->lNumAbonado		= lhNumAbonado[i];
			strcpy(qaux->szFechaHabilitacion	, szfnTrim(szhFechaEvento[i]));
            qaux->sgte 				= paux;
            paux 					= qaux;

    	}
    }
	/* EXEC SQL CLOSE CUR_HABILITACIONES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )299;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


    return paux;
}
/*---------------------------------------------------------------------------*/
/* PROCESO DE VERIFICACION DE REQUISITOS DE TRAFICO                          */
/*---------------------------------------------------------------------------*/
int iVerificaRequisitos(stPerfil *pPerf ,stVentas *pVta,int lNumCriterio)
{
    stRequisito		* pAuxReq;
    stRequisito		* pReq;
    char			* szNomTablaLogica;
	char			* szNomTablaFisica;
    BOOL       		bInd;
    int        		iEntrada;
    int        		iSalida;
    int        		iTotal;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long	lhPeriodoHab;
        char 	szhIdPeriodo[11];
		char 	szhSentencia[500];
        long 	lhNumGeneral;
        int  	lhNumCriterio;
        int  	lhNumPerfil;
        int  	lhNumPeriodo;
        int  	ihCont;
    /* EXEC SQL END DECLARE SECTION; */ 


	pReq = pPerf->sgte_requisito;
    if ((pReq = pPerf->sgte_requisito)==NULL)
        return TRUE;
    
    lhNumGeneral = pVta->lNumGeneral;

	for (pAuxReq=pReq; pAuxReq !=NULL ; pAuxReq = pAuxReq->sgte)
    {
	    lhNumCriterio= pAuxReq->iNumCriterio_req;
	    lhNumPerfil  = pAuxReq->iNumPerfil_req;
	    lhNumPeriodo = pAuxReq->iNumPeriodo_req;
	
	    strcpy(szNomTablaLogica	, "CM_TRAF_CRITERIOS_TO");
		lhPeriodoHab 			= lNewCiclComis(stCiclo.lCodCiclComis , lhNumPeriodo * -1);
		strcpy(szhIdPeriodo		, szNewCiclComis(lhPeriodoHab));
		
		if ( lhPeriodoHab == stCiclo.lCodCiclComis )
		{
			strcpy(szNomTablaFisica,szNomTablaLogica);
		}
		else
		{
		    if (!iBuscaTablaFisica(szNomTablaLogica, szhIdPeriodo, szNomTablaFisica))
			{	
	            fprintf(pfLog ,"\n[iVerificaRequisitos] No hay Datos para Periodo:[%ld] Tabla:[%s].\n\n", lhPeriodoHab, szNomTablaLogica);
	            fprintf(stderr,"\n[iVerificaRequisitos] No hay Datos para Periodo:[%ld] Tabla:[%s].\n\n", lhPeriodoHab, szNomTablaLogica);
	            if (iEvaluaPerfil(pVta, pPerf))
	            {
	            	if (  pReq->cIndCumplimiento == '1' ) /* Debia cumplir requisito */
		            	continue;
		            else  
		            	/* No debia cumplirse */
		            	return FALSE;
				}
	        	else
	        	{
	            	if (  pReq->cIndCumplimiento == '1' ) /* Debia cumplir requisito */
		            	return FALSE;
		            else  
		            	/* No debia cumplirse */
		            	continue;
	           	}
	    	}
	    	else
			{
				sprintf(szhSentencia, "SELECT COUNT(1) FROM  %s "
		        					  "WHERE NUM_GENERAL = :v1 AND "
		        					  "NUM_CRITERIO      = :v2 AND "
		        					  "NUM_PERFIL        = :v3 AND "
		         					  "NUM_PERIODO       = :v4 AND "
		        					  "COD_PERIODO_EVAL  = :v5 AND "
		        					  "IMP_COMISION      > 0 ", szNomTablaFisica);
		        					  
				/* EXEC SQL PREPARE PRE_requisitos FROM :szhSentencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )314;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhSentencia;
    sqlstm.sqhstl[0] = (unsigned long )500;
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


				
				/* EXEC SQL DECLARE CUR_requisitos CURSOR for PRE_requisitos; */ 

				
				/* EXEC SQL OPEN CUR_requisitos USING :lhNumGeneral, :lhNumCriterio, :lhNumPerfil, :lhNumPeriodo, :lhPeriodoHab; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )333;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumGeneral;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCriterio;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumPerfil;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhPeriodoHab;
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


				
				/* EXEC SQL FETCH CUR_requisitos INTO :ihCont; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )368;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCont;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


				
		        if (ihCont > 0) 
		        {
					/* Se cumplio requisito */
					if (  pReq->cIndCumplimiento == '1' ) /* Debia cumplir requisito */
		            	continue;
		            else  
		            	/* No debia cumplirse */
		            	return FALSE;
		        }
		        else
		        {
					/* NO Se cumplio requisito */
					if (  pReq->cIndCumplimiento == '1' ) /* Debia cumplir requisito */
		            	return FALSE;
		            else  
		            	/* No debia cumplirse */
		            	continue;
		        }
			}
		}
    }
    return TRUE;
}

/*---------------------------------------------------------------------------*/
/* RECUPERA LAS RECARGAS DE TARJETA DEL PERIODO, PARA CADA ABONADO EVALUADO. */
/*---------------------------------------------------------------------------*/
double dRecuperaRecargas(long lAbonado, long lCelular, char * szOrigen)
{        
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumAbonado;
		long	lhNumCelular;
		char	szhCodOrigen[6];
		char	szhFecDesde[11];
		char	szhFecHasta[11];
		double	dhMtoRecarga;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhFecDesde	, stCiclo.szFecDesdeNormal);
	strcpy(szhFecHasta	, stCiclo.szFecHastaNormal);
	strcpy(szhCodOrigen	, szOrigen);
	lhNumAbonado 		= lAbonado;
	lhNumCelular 		= lCelular;
	
	/* EXEC SQL SELECT NVL(SUM(VAL_RECARGA),0) INTO :dhMtoRecarga    
	FROM PV_RECARGAPREPAGO_TO
	WHERE	NUM_ABONADO 	= 	:lhNumAbonado             
  	AND 	NUM_CELULAR 	= 	:lhNumCelular 
  	AND		COD_APLIORIGEN	=	:szhCodOrigen
  	AND 	FEC_RECARGA 	>=  TO_DATE(:szhFecDesde, 'DD-MM-YYYY') 
  	AND 	FEC_RECARGA		<   TO_DATE(:szhFecHasta, 'DD-MM-YYYY'); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum(VAL_RECARGA),0) into :b0  from PV_RECARGAPREP\
AGO_TO where ((((NUM_ABONADO=:b1 and NUM_CELULAR=:b2) and COD_APLIORIGEN=:b3) \
and FEC_RECARGA>=TO_DATE(:b4,'DD-MM-YYYY')) and FEC_RECARGA<TO_DATE(:b5,'DD-MM\
-YYYY'))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )387;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoRecarga;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumCelular;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodOrigen;
 sqlstm.sqhstl[3] = (unsigned long )6;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
 sqlstm.sqhstl[5] = (unsigned long )11;
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
 if (sqlca.sqlcode < 0) vSqlError();
}


  	
  	return dhMtoRecarga;
}
/*---------------------------------------------------------------------------*/
/* Rutina encargada de recuperar el trafico de un celular, en un periodo     */
/* determinado. Se incluye el canal de ventas, para saber qcomo se recupera  */
/* el trafico, ya sean minutos o segundos.                                   */
/* Parametros:  piNumCelular            :Numero de celular a buscar          */
/*              plPeriodo               :Periodo de evaluacion (yyyymm)      */
/*              pszTipUnitas            :Tipo de Umbral (S:Seg;M:Min)        */
/*              piPer                   :Periodo de Comisiones(yyyymm)       */
/*              piEnt, piSal, piTot     :Donde se alamcenaran los resultados */
/*---------------------------------------------------------------------------*/
int bRecuperaTrafico(int piNumCelular, char pszTipUnitas, long *piEnt,long *piSal)
{
        long    iEnt = 0;
        long    iSal = 0;
        char    szNomCampo[100];
        int     bFin = FALSE;
        char    szTipUnitas;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        char	szSentencia[MAXARRAY];
        int     iUmbral;
        long    iMinutos;
        long    lhPeriodo;
    	long    lhNumCelular;
    	char	szhFecDesde[11];
    	char	szhFecHasta[11];
	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhFecDesde	, stCiclo.szFecDesdeNormal);
	strcpy(szhFecHasta	, stCiclo.szFecHastaNormal);
	szTipUnitas 		= pszTipUnitas;
    lhNumCelular		= piNumCelular;

    switch (szTipUnitas)
    {
	    case 'S':       /* Evaluacion al segundo        */
	            strcpy(szNomCampo,"SEGS_TRAF");
	            break;
	    case 'M':       /* Evaluacion al minuto         */
	            strcpy(szNomCampo,"MINS_TRAF");
	            break;
	    default:        /* Valor no reconocido          */
				fprintf(pfLog, "\nTipo de Uidad de Tasacion [%c] No Reconocido.Perfil Mal Construido.\n", szTipUnitas);
				fprintf(stderr, "\nTipo de Uidad de Tasacion [%c] No Reconocido.Perfil Mal Construido.\n", szTipUnitas);
	            return(FALSE);
    }

	sprintf(szSentencia,"SELECT IND_ENTSAL,SUM(%s) FROM TA_TRAFICO_CELULAR_MES "
						" WHERE NUM_CELULAR  = :v1 AND "
						" FECHA_TRAF >= TO_DATE(:v2,'YYYYMMDD') AND "
						" FECHA_TRAF <  TO_DATE(:v3,'YYYYMMDD') "
						" GROUP BY IND_ENTSAL ", szNomCampo);


    /* EXEC SQL PREPARE PRE_CURSOR FROM :szSentencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )426;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSentencia;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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



    /* EXEC SQL DECLARE CUR_MINUTOS CURSOR for PRE_CURSOR; */ 


    /* EXEC SQL OPEN CUR_MINUTOS USING :lhNumCelular,:lhPeriodo, :szhFecDesde, :szhFecHasta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )445;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelular;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhPeriodo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
    sqlstm.sqhstl[3] = (unsigned long )11;
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


    do
    {
        /* EXEC SQL FETCH CUR_MINUTOS INTO :iUmbral,:iMinutos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )476;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&iUmbral;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&iMinutos;
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
        if (sqlca.sqlcode < 0) vSqlError();
}



        if (sqlca.sqlcode==SQLNOTFOUND)
        {
          *piEnt=iEnt;
          *piSal=iSal;
          bFin=TRUE;
          /* EXEC SQL CLOSE CUR_MINUTOS; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 13;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )499;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
          if (sqlca.sqlcode < 0) vSqlError();
}


          return(TRUE);
        }
        switch (iUmbral)
        {
            case 1: /* Llamadas de entrada  */
                    iEnt=iMinutos;
                    break;
            case 2: /* Llamadas de Salida   */
                    iSal=iMinutos;
                    break;
        }
    } while(bFin==FALSE);

}
/*---------------------------------------------------------------------------*/
/* EVALUA EL CUMPLIMIENTO DE UN PERFIL DE TRAFICO / RECARGA.                 */
/*---------------------------------------------------------------------------*/
int iEvaluaPerfil(stVentas * pVta, stPerfil *pPerf)
{
	long    lEntrada 	= 0;
	long    lSalida  	= 0;
	long    lTotal   	= 0;
	double	dMtoRecarga = 0.00;
	int		bCompEntrada;
	int		bCompSalida;
	int		bCompTotal;
	int		bCompRecarga;
	int		bResultado;
	long	lNumAbonado;
	long	lNumCelular;
	
	lNumAbonado = pVta->lNumAbonado;
	lNumCelular = pVta->lNumCelular;
	
	if ((pPerf->lUniEntrada > 0)||(pPerf->lUniSalida > 0)||(pPerf->lUniTotal > 0))
		if (bRecuperaTrafico(lNumCelular, pPerf->cTipUnitas ,&lEntrada ,&lSalida))
			lTotal = lEntrada + lSalida;

	if (pPerf->dImpRecarga > (double) 0)
		dMtoRecarga = dRecuperaRecargas(lNumAbonado, lNumCelular, pPerf->szCodOrigen);
	
	pVta->lUniEntrada	= lEntrada; 	
	pVta->lUniSalida	= lSalida;  	
	pVta->lUniTotal		= lTotal;   	
	pVta->dImpRecarga	= dMtoRecarga; 	
	
	bCompEntrada 	= (lEntrada 	>= pPerf->lUniEntrada);
	bCompSalida  	= (lSalida 		>= pPerf->lUniSalida);
	bCompTotal		= (lTotal 		>= pPerf->lUniTotal);
	bCompRecarga 	= (dMtoRecarga 	>= pPerf->dImpRecarga);
	
	switch(pPerf->cOpeEntrada)
	{
		case 'Y':
			switch (pPerf->cOpeSalida)
			{
				case 'Y':
					switch (pPerf->cOpeRecarga)
					{
						case 'Y':
							bResultado = (bCompEntrada) && (bCompSalida) && (bCompTotal) && (bCompRecarga);
						case 'O':
							bResultado = (bCompEntrada) && (bCompSalida) && (bCompTotal) || (bCompRecarga);
					}
				case 'O':
					switch (pPerf->cOpeRecarga)
					{
						case 'Y':
							bResultado = (bCompEntrada) && (bCompSalida) || (bCompTotal) && (bCompRecarga);
						case 'O':
							bResultado = (bCompEntrada) && (bCompSalida) || (bCompTotal) || (bCompRecarga);
					}
				
			}
		case 'O':		
			switch (pPerf->cOpeSalida)
			{
				case 'Y':
					switch (pPerf->cOpeRecarga)
					{
						case 'Y':
							bResultado = (bCompEntrada) || (bCompSalida) && (bCompTotal) && (bCompRecarga);
						case 'O':
							bResultado = (bCompEntrada) || (bCompSalida) && (bCompTotal) || (bCompRecarga);
					}
				case 'O':
					switch (pPerf->cOpeRecarga)
					{
						case 'Y':
							bResultado = (bCompEntrada) || (bCompSalida) || (bCompTotal) && (bCompRecarga);
						case 'O':
							bResultado = (bCompEntrada) || (bCompSalida) || (bCompTotal) || (bCompRecarga);
					}
				
			}
		
	}
	return bResultado;
}
/*---------------------------------------------------------------------------*/
/* PROCESO DE VALORACION DE VENTAS EN FUNCION DE LOS PERFILES DE EVALUACION  */
/*---------------------------------------------------------------------------*/
void vValorarVentas(stVentas *pVentas, stCriterios *pCrit, stPerfil *pPerf)
{
	stVentas 	* pVta;
	stVentas 	* raux;
	BOOL    	bInd;
	
	char	szhFecDesde[11];
	char	szhFecHasta[11];
	char	szhFecEvento[11];	
	
	if (pPerf == NULL) return;
	if (pVta == NULL) return;
	
	raux = pVta->sgte;
	while (raux != NULL)
	{
		strcpy(szhFecDesde	,	pCrit->szFecDesde);
		strcpy(szhFecHasta	,	pCrit->szFecHasta);
		strcpy(szhFecEvento,	pVentas->szFechaHabilitacion);
	 
		if (bValidaFechaEvento(szhFecDesde, szhFecHasta, szhFecEvento))
		{
			if  (iVerificaRequisitos(pPerf,pVta,pCrit->iNumCriterio))
			{
				if (iEvaluaPerfil(pVta, pPerf))
				{
			        pVta->dImpComision  = pPerf->dImpComision;
				}
				else
				{
			        pVta->dImpComision  = ( -1 * pPerf->dImpCastigo );
				}
			    pVta->sgte 			= pPerf->sgte_venta;
			    pPerf->sgte_venta 	= pVta;
			}
			else
			{
				free(pVta);
        	}
        	pVta = raux;
        	if (pVta!=NULL)
        		raux 			= pVta->sgte;
		}
	}
    
	if (pVta != NULL)
	{
		strcpy(szhFecDesde	,	pCrit->szFecDesde);
		strcpy(szhFecHasta	,	pCrit->szFecHasta);
		strcpy(szhFecEvento,	pVentas->szFechaHabilitacion);
	 
		if (bValidaFechaEvento(szhFecDesde, szhFecHasta, szhFecEvento))
		{
			if  (iVerificaRequisitos(pPerf,pVta,pCrit->iNumCriterio))
			{
				if (iEvaluaPerfil(pVta, pPerf))
				    pVta->dImpComision  = pPerf->dImpComision;
				else
				    pVta->dImpComision  = ( -1 * pPerf->dImpCastigo );
				
				pVta->sgte 			= pPerf->sgte_venta;
				pPerf->sgte_venta 	= pVta;
			}    	
			else
				free(pVta);
		}
	}
}
/*---------------------------------------------------------------------------*/
/* Proceso Principal : Selecciona y valora Universo                          */
/*---------------------------------------------------------------------------*/
void vValoraUniverso()
{
	stCriterios		*paux;
	stPerfil		*qaux;
	stVentas		*pVentas;


	for ( paux = lstCriterios ; paux != NULL ; paux = paux->sgte)
	{
        fprintf(pfLog ,"[vValoraUniverso]Evaluando TipoRed:[%d] PlanComis:[%s] Concepto:[%d] Criterio:[%d] Desde:[%s] Hasta:[%s]\n", paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->iNumCriterio, paux->szFecDesde, paux->szFecHasta);

        fprintf(stderr,"[vValoraUniverso]Evaluando TipoRed:[%d] PlanComis:[%s] Concepto:[%d] Criterio:[%d] Desde:[%s] Hasta:[%s]\n", paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->iNumCriterio, paux->szFecDesde, paux->szFecHasta);

        for ( qaux = paux->sgte_perfil ; qaux != NULL ; qaux = qaux->sgte)
        {
	        /* Seleccionando ventas para el perfil */
	        pVentas = stObtieneVentas(paux,qaux);
	        if (pVentas !=NULL)
            	vValorarVentas(pVentas,paux,qaux);
            
        }
    }
}
/*---------------------------------------------------------------------------*/
/* INSERTA VALORIZADOS                                                       */
/*---------------------------------------------------------------------------*/
void vInsertaValorizados()
{
	stCriterios * paux;
	stPerfil 	* qaux;
	stVentas	* raux;
	long		lCantRegs = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int		ihCodTipoRed;
        long 	lhNumGeneral;
        int		ihCodConcepto;
        char 	szhIdPeriodo[11];
        long 	lhCodPeriodo;
        char 	szhCodTipComis[3];
        long 	lhCodComisionista;
        char 	szhCodUniverso[7];
        double  dhImporte;
        
        int		ihNumCriterio;
        int  	ihNumPefil;
        int  	ihNumPeriodo;
		int  	ihCodHabilitacion;
		char	chTipUnitas;
		long 	lhUniEntrada;
		long 	lhUniSalida;
		long 	lhUniTotal;
		double	dhImpRecarga;
		char	szhCodOrigen[6];
    /* EXEC SQL END DECLARE SECTION; */ 

	lhCodPeriodo            = stCiclo.lCodCiclComis;
	strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);

	for (paux = lstCriterios; paux != NULL; paux = paux->sgte)
	{
        strcpy(szhCodUniverso	, paux->szCodUniverso);
        ihCodConcepto           = paux->iCodConcepto;
        strcpy(szhCodTipComis   , paux->szCodTipComis);
        ihCodTipoRed			= paux->iCodTipoRed;
        ihNumCriterio			= paux->iNumCriterio;
		for (qaux = paux->sgte_perfil; qaux != NULL; qaux = qaux->sgte)
		{
			ihNumPefil 			= qaux->iNumPerfil;
			ihNumPeriodo		= qaux->iNumPeriodo;
			chTipUnitas			= qaux->cTipUnitas;
			strcpy(szhCodOrigen	, qaux->szCodOrigen);
			for (raux = qaux->sgte_venta; raux != NULL; raux = raux->sgte)
			{
        		lhNumGeneral            = raux->lNumGeneral;
        		lhCodComisionista       = raux->lCodComisionista;
		        dhImporte               = fnCnvDouble(raux->dImpComision, 0);
		        ihCodHabilitacion 		= raux->lCodPeriodoHab;
		        lhUniEntrada			= raux->lUniEntrada;
                lhUniSalida				= raux->lUniSalida;
                lhUniTotal				= raux->lUniTotal;
                dhImpRecarga			= raux->dImpRecarga;

			    /* EXEC SQL INSERT INTO CMT_VALORIZADOS
				    (NUM_GENERAL, COD_UNIVERSO, COD_CONCEPTO, COD_TIPCOMIS,
				     COD_COMISIONISTA, COD_PERIODO, ID_PERIODO, IMP_CONCEPTO,
				     COD_TIPORED) VALUES( :lhNumGeneral, :szhCodUniverso,
				     :ihCodConcepto, :szhCodTipComis, :lhCodComisionista,
				     :lhCodPeriodo, :szhIdPeriodo, :dhImporte, :ihCodTipoRed); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 13;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_UNIVERSO,\
COD_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP_CONCEPTO\
,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )514;
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
       sqlstm.sqhstv[7] = (unsigned char  *)&dhImporte;
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


				
				 /* EXEC SQL INSERT INTO CM_TRAF_CRITERIOS_TO(
				 	NUM_GENERAL, NUM_CRITERIO, NUM_PERFIL, NUM_PERIODO,
                    COD_PERIODO_HAB, COD_PERIODO_EVAL, TIP_UNITAS,
                    UNI_ENTRADA, UNI_SALIDA, UNI_TOTAL, IMP_COMISION)
                    VALUES( :lhNumGeneral, :ihNumCriterio, :ihNumPefil,
                    :ihNumPeriodo, :ihCodHabilitacion, :lhCodPeriodo,
                    :chTipUnitas, :lhUniEntrada, :lhUniSalida, :lhUniTotal, :dhImporte  ); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 13;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CM_TRAF_CRITERIOS_TO (NUM_GENERAL,NUM_CRITER\
IO,NUM_PERFIL,NUM_PERIODO,COD_PERIODO_HAB,COD_PERIODO_EVAL,TIP_UNITAS,UNI_ENTR\
ADA,UNI_SALIDA,UNI_TOTAL,IMP_COMISION) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7\
,:b8,:b9,:b10)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )565;
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
     sqlstm.sqhstv[1] = (unsigned char  *)&ihNumCriterio;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihNumPefil;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&ihNumPeriodo;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&ihCodHabilitacion;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
     sqlstm.sqhstv[6] = (unsigned char  *)&chTipUnitas;
     sqlstm.sqhstl[6] = (unsigned long )1;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&lhUniEntrada;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&lhUniSalida;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&lhUniTotal;
     sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)&dhImporte;
     sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[10] = (         int  )0;
     sqlstm.sqindv[10] = (         short *)0;
     sqlstm.sqinds[10] = (         int  )0;
     sqlstm.sqharm[10] = (unsigned long )0;
     sqlstm.sqadto[10] = (unsigned short )0;
     sqlstm.sqtdso[10] = (unsigned short )0;
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


				
				lCantRegs++;
			}
		}
	}
	stStatusProc.lCantValorizados = lCantRegs;
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
/* Libera la memoria utilizada por los datos de valoración.                  */
/*---------------------------------------------------------------------------*/
void vLiberaVentas(stVentas * paux)
{
	stVentas 	*qaux;
	if (paux == NULL)
		return;

	qaux = paux->sgte;
	while (qaux != NULL)
	{
		free (paux);
		paux = qaux;
		qaux = paux->sgte;
	}
	if (paux != NULL)
		free(paux);
}
/*---------------------------------------------------------------------------*/
/* Libera la memoria utilizada por los datos de valoración.                  */
/*---------------------------------------------------------------------------*/
void vLiberaRequisitos(stRequisito * paux)
{
	if (paux == NULL)
		return;
	vLiberaRequisitos(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Libera la memoria utilizada por los datos de valoración.                  */
/*---------------------------------------------------------------------------*/
void vLiberaPerfiles(stPerfil * paux)
{
	if (paux == NULL)
		return;
	vLiberaPerfiles(paux->sgte);
	vLiberaRequisitos(paux->sgte_requisito);
	vLiberaVentas(paux->sgte_venta);
}
/*---------------------------------------------------------------------------*/
/* Libera la memoria utilizada por los datos de valoración.                  */
/*---------------------------------------------------------------------------*/
void vLiberaMemomoria(stCriterios * paux)
{
	if (paux == NULL)
		return;
	vLiberaMemomoria(paux->sgte);
	vLiberaPerfiles(paux->sgte_perfil);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.													     */
/*---------------------------------------------------------------------------*/
    long  lSegIni, lSegFin;	    
    short ibiblio;		    
/*---------------------------------------------------------------------------*/
/* Recuperacion	del tiempo de inicio del proceso, en segundos.			     */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura	de argumentos externos,	de estadistica del   */
/* proceso y de	alguna otra estructura.					    				 */
/*---------------------------------------------------------------------------*/
    memset(&stCiclo, 0,	sizeof(reg_ciclo));	    
    memset(&stStatusProc, 0, sizeof(stStatusProc));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos	ingresados como	parametros externos.			     */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));	   
    vManejaArgs(argc, argv);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.					    				 */
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
        /* EXEC SQL SET ROLE ALL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "set role ALL";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )624;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


    }
/*---------------------------------------------------------------------------*/
/* Inicia estructura de	proceso	y bloques.				    				 */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUser, stArgs.izSecuencia);	    
    ibiblio = iAccesa_Traza_Procesos(ABRIR_TRAZA,0,"",0,0);					    
    if (ibiblio)										    
    {												    
		fprintf(stderr,	"Error al Abrir	Traza");						    
		fprintf(stderr,	"Error [%d] al escribir	Traza de Proceso.\n", ibiblio);			    
		exit(ibiblio);										    
    }												    
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para	archivos de log	y datos.		     		 */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando	ambiente para archivos de log, de datos	y de configuracion ...\n");		       
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", ""))	== (char *)NULL)					       
    {														       
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE	DE AMBIENTE XPCM_LOG NO	RECONOCIDA.",0,0));
    }														       
    fprintf(stderr, "Directorio	de Logs		: [%s]\n", (char *)pszEnvLog);		
/*---------------------------------------------------------------------------*/
/* GENERACION DEL NOMBRE Y CREACION DEL	ARCHIVO	DE LOG.			     		 */
/*---------------------------------------------------------------------------*/
    strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
    strncpy(szhSysDate, pszGetDateLog(),16);								    
    strcpy(stArgsLog.szProceso,LOGNAME);									    
    strncpy(stArgsLog.szSysDate,szhSysDate,16);									    
    sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);				    
														   
    if((pfLog =	fAbreArchivoLog()) == (FILE *)NULL)								    
    {														    
       fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n",	LOGNAME);					 
       fprintf(stderr, "Revise su existencia.\n");								   
       fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));					   
       fprintf(stderr, "Proceso	finalizado con error.\n");							   
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
    fprintf(pfLog, "Tipo de Ciclo 					<%c>\n", stArgs.szTipCiclComis);
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);

    fprintf(pfLog, "Identificador de Proceso		<%s>\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque			<%s>\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion			<%d>\n", stArgs.izSecuencia);

	fprintf(pfLog, "Base de datos : %s\n\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog,"\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
/*---------------------------------------------------------------------------*/
/* Modificacion	de configuracion ambiental, para manejo	de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )639;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

	    
/*---------------------------------------------------------------------------*/
/*    INICIA PROCESAMIENTO PRINCIPAL.					     				 */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "Inicio procesamiento principal ...\n\n");
    fprintf(stderr, "Inicio procesamiento principal ...\n\n");
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
/*--------------------------------------------------------------------------*/
/* Carga estructura principal de valoracion (criterios / perfiles / requisi.*/
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Carga estructura principal de valoracion (criterios / perfiles / requisitos).\n\n");  
    fprintf(stderr, "Carga estructura principal de valoracion (criterios / perfiles / requisitos).\n\n");  
	lstCriterios = vLlenaTasador();
/*--------------------------------------------------------------------------*/
/* Muestra estructura principal de Valoracion.                              */
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Muestra estructura principal de Valoracion.\n\n");  
    fprintf(stderr, "Muestra estructura principal de Valoracion.\n\n");  
    vMuestraEstructura();
/*--------------------------------------------------------------------------*/
/* Ejecuta el Calculo de las comisiones por tráfico de Prepago.             */
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Ejecuta el Calculo de las comisiones por tráfico de Prepago.\n\n");  
    fprintf(stderr, "Ejecuta el Calculo de las comisiones por tráfico de Prepago.\n\n");  
    vValoraUniverso();
/*--------------------------------------------------------------------------*/
/* Inserta los registros procesados en la tabla de Valoizados               */
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Inserta los registros procesados en la tabla de Valoizados.\n\n");  
    fprintf(stderr, "Inserta los registros procesados en la tabla de Valoizados.\n\n");  
	vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/* Libera la memoria de las listas de datos.                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Libera la memoria de las listas de datos.\n\n");  
    fprintf(stderr, "Libera la memoria de las listas de datos.\n\n");  
	vLiberaMemomoria(lstCriterios);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/
    lSegFin=lGetTimer();
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion	estadistica del	proceso.		     		 */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "\nEstadistica del proceso\n");
    fprintf(pfLog,	"------------------------\n");
    fprintf(pfLog,	"Segundos Reales Utilizados			: [%d]\n",stStatusProc.lSegProceso);
    fprintf(pfLog,	"Cantidad de Registros Valorados	: [%d]\n",stStatusProc.lCantValorizados);
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "\nEstadistica del proceso\n");
    fprintf(stderr,	"------------------------\n");
    fprintf(stderr,	"Segundos Reales Utilizados			: [%d]\n",stStatusProc.lSegProceso);
    fprintf(stderr,	"Cantidad de Registros Valorados	: [%d]\n",stStatusProc.lCantValorizados);
/*---------------------------------------------------------------------------*/
    if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"", stStatusProc.lSegProceso,stStatusProc.lCantValorizados))
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));
	fprintf(pfLog,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
	fprintf(stderr,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));

    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )654;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


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

