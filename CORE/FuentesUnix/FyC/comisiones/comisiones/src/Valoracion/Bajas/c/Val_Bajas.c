
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
           char  filnam[18];
};
static struct sqlcxp sqlfpn =
{
    17,
    "./pc/Val_Bajas.pc"
};


static unsigned int sqlctx = 6929859;


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
   unsigned char  *sqhstv[15];
   unsigned long  sqhstl[15];
            int   sqhsts[15];
            short *sqindv[15];
            int   sqinds[15];
   unsigned long  sqharm[15];
   unsigned long  *sqharc[15];
   unsigned short  sqadto[15];
   unsigned short  sqtdso[15];
} sqlstm = {12,15};

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
"select IND_TRAFICO ,IND_PROCEQUI ,COD_TIPCALCULO ,NOM_FECHADESDE ,NUM_LISTAC\
AUSA ,NUM_LISTAUSUAEXCEP  from CM_PENALIZA_TD where ((COD_TIPORED=:b0 and COD_\
PLANCOMIS=:b1) and COD_CONCEPTO=:b2)           ";

 static char *sq0006 = 
"select VAL_PARAMETRO1  from CMD_PARAMETROS where ((COD_TIPCODIGO=:b0 and COD\
_CODIGO=:b1) and COD_PARAMETRO>0)           ";

 static char *sq0007 = 
"select TIP_PLAN ,COD_CATEGCLIENTE ,NVL(IMP_BASE,0) ,NVL(IMP_EQUIPO,0)  from \
CM_DETPENALIZA_TD where ((COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCE\
PTO=:b2)           ";

 static char *sq0008 = 
"select DIAS_DESDE ,DIAS_HASTA ,IMP_PENALIZA  from CM_PLAZOS_PENALIZA_TD wher\
e ((((COD_TIPORED=:b0 and COD_CONCEPTO=:b1) and COD_PLANCOMIS=:b2) and TIP_PLA\
N=:b3) and COD_CATEGCLIENTE=:b4) order by DIAS_DESDE desc             ";

 static char *sq0010 = 
"select A.NUM_GENERAL ,A.COD_COMISIONISTA ,A.NUM_CELULAR ,A.COD_CATEGCLIENTE \
,A.COD_PLANTARIF ,TO_CHAR(A.FEC_BAJA,'DD-MM-YYYY') ,TO_CHAR(A.FEC_VENTA,'YYYYM\
MDD') ,A.COD_CAUSABAJA ,C.NOM_USUARIO ,A.IND_PROCEQUI ,C.TIP_PLAN ,TRUNC((A.FE\
C_BAJA-A.FEC_VENTA)) ,TRUNC((A.FEC_BAJA-A.FEC_RECEPCION)) ,TRUNC((A.FEC_BAJA-A\
.FEC_ACEPTACION)) ,A.COD_TIPORED  from CMT_BAJAS_CELULAR A ,CMD_PLANESTARIF C \
where (((A.COD_TIPCOMIS=:b0 and A.COD_PERIODO=:b1) and A.ID_PERIODO=:b2) and A\
.COD_PLANTARIF=C.COD_PLANTARIF)           ";

 static char *sq0011 = 
"select A.NUM_GENERAL ,A.COD_COMISIONISTA ,A.NUM_CELULAR ,A.COD_CATEGCLIENTE \
,A.COD_PLANTARIF ,TO_CHAR(A.FEC_RECHAZO,'DD-MM-YYYY') ,TO_CHAR(A.FEC_VENTA,'YY\
YYMMDD') ,A.COD_CAUSAREC ,A.NOM_USUARIO ,A.IND_PROCEQUI ,C.TIP_PLAN ,TRUNC((A.\
FEC_RECHAZO-A.FEC_VENTA)) ,TRUNC((A.FEC_RECHAZO-A.FEC_RECEPCION)) ,A.COD_TIPOR\
ED  from CMT_RECHAZOS_CELULAR A ,CMD_PLANESTARIF C where ((((A.NUM_GENERAL>0 a\
nd A.COD_TIPCOMIS=:b0) and A.COD_PERIODO=:b1) and A.ID_PERIODO=:b2) and C.COD_\
PLANTARIF=A.COD_PLANTARIF)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,201,0,9,159,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
32,0,0,1,0,0,13,163,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,
71,0,0,1,0,0,15,205,0,0,0,0,0,1,0,
86,0,0,2,190,0,3,469,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
137,0,0,3,238,0,3,495,0,0,12,12,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
200,0,0,4,148,0,4,541,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
227,0,0,5,518,0,4,551,0,0,4,3,0,1,0,2,4,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
258,0,0,6,120,0,9,719,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
281,0,0,6,0,0,13,723,0,0,1,0,0,1,0,2,97,0,0,
300,0,0,6,0,0,15,740,0,0,0,0,0,1,0,
315,0,0,7,173,0,9,785,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
342,0,0,7,0,0,13,789,0,0,4,0,0,1,0,2,97,0,0,2,97,0,0,2,4,0,0,2,4,0,0,
373,0,0,7,0,0,15,824,0,0,0,0,0,1,0,
388,0,0,8,224,0,9,875,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
423,0,0,8,0,0,13,879,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
450,0,0,8,0,0,15,904,0,0,0,0,0,1,0,
465,0,0,9,241,0,4,921,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
496,0,0,10,508,0,9,1016,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
523,0,0,10,0,0,13,1020,0,0,15,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,
598,0,0,10,0,0,15,1079,0,0,0,0,0,1,0,
613,0,0,11,503,0,9,1167,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
640,0,0,11,0,0,13,1171,0,0,14,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,
711,0,0,11,0,0,15,1227,0,0,0,0,0,1,0,
726,0,0,12,48,0,1,1336,0,0,0,0,0,1,0,
741,0,0,13,0,0,30,1460,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa encargado de ejecutar la valoración	del Bono Cartera	         */
/*									                                         */
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision	00.						                             */
/* Inicio: Lunes 26 de Noviembre del 2001.				                     */
/* Fin:									                                     */
/* Autor : Fabian Aedo Ramirez						                         */
/*---------------------------------------------------------------------------*/
/* Recibira entre sus parametros un COD_PERIODO, con el	que cruzara las	     */
/*  tablas de Valoracion (CMT_VALORIZADOS) y la	de periodos, (CMD_PERIODOS), */
/*  para todos aquellos	periodos cuyo indicador	de periodo sea mensual.	     */
/*---------------------------------------------------------------------------*/
/* Inclusion de	librería para definiciones generales del programa.	         */
/*---------------------------------------------------------------------------*/
/* Modificado Marcelo Quiroz Garcia                                          */
/* Se incorporan tratamientos de:                                            */
/* - Ciclos Esporádicos                                                      */
/* - Planes de Comisiones                                                    */
/* - Red de Ventas                                                           */
/* Versionado CUZCO - Oct-2003.                                              */
/* ***************************************************************************/
#include "Val_Bajas.h"
#include "GEN_biblioteca.h"
#include <geora.h>
/*---------------------------------------------------------------------------*/
/* Declaracion e inicializacion	de lista de conceptos a	procesar.	         */
/*---------------------------------------------------------------------------*/
stConceptosProc	* lstConceptosProc = NULL;
/*---------------------------------------------------------------------------*/
/* Inclusion de	biblioteca para	manejo de interaccion con Oracle.	         */
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
void vLiberaDatosTiempo(stTiempos * taux)
{
	if (taux == NULL)
		return;
	vLiberaDatosTiempo(taux->sgte);	
	free(taux);
}
/*---------------------------------------------------------------------------*/
void vLiberaDatosPlan(stPlan * raux)
{
	if (raux == NULL)
		return;
	vLiberaDatosPlan(raux->sgte);
	vLiberaDatosTiempo(raux->sgte_tiempo);
	free(raux);
}
/*---------------------------------------------------------------------------*/
void vLiberaDatosParam(stParam * qaux)
{
	if (qaux == NULL)
		return;
	vLiberaDatosParam(qaux->sgte);
	free(qaux);
}
/*---------------------------------------------------------------------------*/
void vLiberaDatosEvento(stEvento * qaux)
{
	if (qaux == NULL)
		return;
	vLiberaDatosEvento(qaux->sgte);
	free(qaux);
}
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{
	if (paux == NULL)
		return;
	vLiberaPrincipal(paux->sgte);	
	vLiberaDatosPlan(paux->sgte_plan);
	vLiberaDatosParam(paux->sgte_causa);
	vLiberaDatosParam(paux->sgte_usuar);
	vLiberaDatosEvento(paux->sgte_evento);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* CREA	LISTA PRINCIPAL	DE EVALUALCION A PARTIR	DE LA TABLA CM_PENALIZA_TD   */
/*---------------------------------------------------------------------------*/
stPrincipal * stfnCreaPrincipal()
{
    stConceptosProc * raux;
    stPrincipal	    *paux;
    stPrincipal	    *qaux;
    
    long	lCantRegistros = 0;
    int				         i;
    short	iLastRows      = 0;
    int		iFetchedRows   = MAXFETCH;
    int		iRetrievRows   = MAXFETCH;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodPlanComis[6] ;
	int	    ihCodTipoRed	   ;
	int	    ihCodConcepto	   ;
	char	szhCodTipComis [3] ;
	char	szhCodUniverso [7] ;		    

	long	lMaxFetch;

	char	szhIndTrafico	    [MAXFETCH][2];
	char	szhIndProcequi	    [MAXFETCH][2];
	char	szhCodTipCalculo    [MAXFETCH][2];
	int	    ihNomFechaDesde	    [MAXFETCH];
	int	    ihNumListaCausa	    [MAXFETCH];
	int	    ihNumListaUsuaExcep [MAXFETCH];
	
	char	szhFecInicio[11];
	char	szhFecTermino[11];
	
    /* EXEC SQL END DECLARE SECTION; */ 


    paux = NULL;
    qaux = NULL;	 
	
    lMaxFetch =	MAXFETCH;
    
    strcpy(szhFecInicio  , stCiclo.szFecDesdeNormal);
	strcpy(szhFecTermino , stCiclo.szFecHastaNormal);
    
    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
    {
		iLastRows      		   = 0;       
		iFetchedRows   		   = MAXFETCH;
		iRetrievRows   		   = MAXFETCH;
		ihCodTipoRed	       = raux->iCodTipoRed;
		ihCodConcepto	       = raux->iCodConcepto;
		strcpy(szhCodPlanComis , raux->szCodPlanComis);
		lMaxFetch =	MAXFETCH;

		strcpy(szhCodTipComis  , raux->szCodTipComis);
		strcpy(szhCodUniverso  , raux->szCodUniverso);
	
		/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR
			SELECT	IND_TRAFICO	  	  ,
				    IND_PROCEQUI	  ,
					COD_TIPCALCULO	  ,
					NOM_FECHADESDE	  ,
					NUM_LISTACAUSA	  ,
					NUM_LISTAUSUAEXCEP			
			FROM	CM_PENALIZA_TD
			WHERE	COD_TIPORED   =	:ihCodTipoRed
			AND	    COD_PLANCOMIS =	:szhCodPlanComis
			AND	    COD_CONCEPTO  =	:ihCodConcepto; */ 

	
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
				 FETCH CUR_UNIVERSO INTO 
					:szhIndTrafico,
					:szhIndProcequi,
					:szhCodTipCalculo,
					:ihNomFechaDesde,
					:ihNumListaCausa,
					:ihNumListaUsuaExcep; */ 

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
       sqlstm.sqhstv[0] = (unsigned char  *)szhIndTrafico;
       sqlstm.sqhstl[0] = (unsigned long )2;
       sqlstm.sqhsts[0] = (         int  )2;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqharc[0] = (unsigned long  *)0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhIndProcequi;
       sqlstm.sqhstl[1] = (unsigned long )2;
       sqlstm.sqhsts[1] = (         int  )2;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqharc[1] = (unsigned long  *)0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipCalculo;
       sqlstm.sqhstl[2] = (unsigned long )2;
       sqlstm.sqhsts[2] = (         int  )2;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqharc[2] = (unsigned long  *)0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)ihNomFechaDesde;
       sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[3] = (         int  )sizeof(int);
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqharc[3] = (unsigned long  *)0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)ihNumListaCausa;
       sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[4] = (         int  )sizeof(int);
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqharc[4] = (unsigned long  *)0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)ihNumListaUsuaExcep;
       sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[5] = (         int  )sizeof(int);
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
		     iLastRows	  = sqlca.sqlerrd[2];
					
		     for (i=0; i < iRetrievRows; i++)
		     {
			  paux = (stPrincipal *) malloc(sizeof(stPrincipal));
	 
			  paux->iCodTipoRed	       	   = ihCodTipoRed;
			  paux->iCodConcepto	       = ihCodConcepto;
			  paux->iNomFechaDesde	       = ihNomFechaDesde[i];
			  paux->iNumListaCausa	       = ihNumListaCausa[i];
			  paux->iNumListaUsuaExcep     = ihNumListaUsuaExcep[i];
	
			  strcpy(paux->szCodPlanComis  , szhCodPlanComis);
			  strcpy(paux->szCodTipComis   , szfnTrim(szhCodTipComis)); 
			  strcpy(paux->szCodUniverso   , szfnTrim(szhCodUniverso));			   
			  strcpy(paux->szIndTrafico    , szfnTrim(szhIndTrafico[i]));
			  strcpy(paux->szIndProcequi   , szfnTrim(szhIndProcequi[i]));			      
			  strcpy(paux->szCodTipCalculo , szfnTrim(szhCodTipCalculo[i]));			
			  
			  strcpy(paux->szFecDesde		, raux->szFecDesde);
			  strcpy(paux->szFecHasta		, raux->szFecHasta);

			  paux->sgte_plan  = NULL;  
			  paux->sgte_causa = NULL; 
			  paux->sgte_usuar = NULL; 
			  paux->sgte_evento= NULL;
			  lCantRegistros++;
				
			  paux->sgte	   = qaux;
			  qaux		   = paux;
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
  if (sqlca.sqlcode < 0) vSqlError();
}


    }
    fprintf(pfLog,  "(stfnCreaPrincipal)Registros Leidos:[%ld].\n\n", lCantRegistros);
    return (qaux);
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
/*   Funcion que devuelve el puntero de	una lista			                 */
/*---------------------------------------------------------------------------*/
void vCargaPrincipal()
{			     
    stPrincipal	 * paux;											     
    lstPrincipal = NULL;														

    lstPrincipal = stfnCreaPrincipal();	 
    
    /* recorre la lista	principal para añadir listas de	planes,	usuarios y causas.. */
    for(paux=lstPrincipal; paux!=NULL; paux=paux->sgte)
    {
		fprintf(pfLog,	"(vCargaPrincipal) Carga Lista de TipPlan/CategCliente\n");
		paux->sgte_plan	= stCargaPlan(paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto);
			
		if (paux->iNumListaCausa!=0)
		{
			fprintf(pfLog,"\n(vCargaPrincipal) Carga Lista de Causas [%s]\n", paux->szCodUniverso);		   
			paux->sgte_causa = stCargaParam(paux->iNumListaCausa);
		}
		if (paux->iNumListaUsuaExcep!=0)
		{
			fprintf(pfLog,"\n(vCargaPrincipal) Carga Lista de Usuarios de Excepcion\n");
			paux->sgte_usuar = stCargaParam(paux->iNumListaUsuaExcep);
		}
    }														
}
/*---------------------------------------------------------------------------*/
/* Busca la existencia de pszElemento en la lista stLista (parametros).	     */
/*---------------------------------------------------------------------------*/
BOOL bBuscaParametro(stParam * stLista,char *	pszElemento)
{								   
	if (stLista==NULL)
		return FALSE;		
	if (strcmp(stLista->szValParametro1,pszElemento)==0)	   
		return TRUE;
	else							   
		return(bBuscaParametro(stLista->sgte,pszElemento));
} 								     
 /*---------------------------------------------------------------------------*/
int bValidaEvento(stPrincipal * paux, stEvento * qaux)				
{
	stConceptosProc * raux;
	
	if (paux == NULL) 
		return(FALSE);

	if (qaux == NULL) 
		return(FALSE);

	if  ((paux->iCodTipoRed == qaux->iCodTipoRed) && 
	     (strcmp(paux->szCodTipComis , qaux->szCodTipComis)== 0) && 
	     ((strcmp(paux->szIndProcequi, qaux->szIndProcequi)== 0) ||	(strcmp(paux->szIndProcequi, "T")==	0))) 
	{
		if (paux->sgte_causa ==	NULL)
		{	    
			fprintf(pfLog, "\n[bValidaEvento] Concepto sin lista de Causas. Se asumen todas las causas validas.\n");
			fprintf(stderr,"\n[bValidaEvento] Concepto sin lista de Causas. Se asumen todas las causas validas.\n");
		}
		else
		{
			if (!bBuscaParametro(paux->sgte_causa,qaux->szCodCausaBaja))		
			{
				return(FALSE);									
			}
		}
	}			
	else
	{
		return(FALSE);									
	}						      

	if (!bValidaFechaEvento(paux->szFecDesde, paux->szFecHasta, qaux->szFechaEvento))
	{						
		fprintf(pfLog, "\n[bValidaEvento] Evento esta fuera de la vigencia del Plan de Comisiones.");
		fprintf(stderr,"\n[bValidaEvento] Evento esta fuera de la vigencia del Plan de Comisiones.");
		return (FALSE);
	}
	return(TRUE);
} 											  
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE EJECUTA EL	CALCULO	DE LA COMISION			             */
/*---------------------------------------------------------------------------*/
void vCalculaComision(stEvento * lstEventos)
{														   
    stPrincipal	* paux;											   
    stEvento	* pNuevo;	
    stEvento	* qaux;	
    
	for(qaux = lstEventos; qaux != NULL; qaux = qaux->sgte)
	{
		fprintf(pfLog, "\n[vCalculaComision] Analiza Evento. TR:[%d] NumGral.:[%ld] Universo:[%s] TipPlan:[%s] CatCte.:[%s]\n",qaux->iCodTipoRed, qaux->lNumGeneral, qaux->szCodUniverso, qaux->szTipPlan, qaux->szCodCategCliente);
		fprintf(pfLog, "\tCausa:[%s] DiasVta:[%d] Acep:[%d] Recep:[%d] ProcEqui:[%s]\n", qaux->szCodCausaBaja, qaux->iDiasVenta, qaux->iDiasAceptacion, qaux->iDiasRecepcion, qaux->szIndProcequi);
		fprintf(stderr,"\n[vCalculaComision] Analiza Evento. TR:[%d] NumGral.:[%ld] Universo:[%s] TipPlan:[%s] CatCte.:[%s]\n",qaux->iCodTipoRed, qaux->lNumGeneral, qaux->szCodUniverso, qaux->szTipPlan, qaux->szCodCategCliente);
		fprintf(stderr,"\tCausa:[%s] DiasVta:[%d] Acep:[%d] Recep:[%d] ProcEqui:[%s]\n", qaux->szCodCausaBaja, qaux->iDiasVenta, qaux->iDiasAceptacion, qaux->iDiasRecepcion, qaux->szIndProcequi);
	    
	    for(paux = lstPrincipal; paux != NULL; paux = paux->sgte)							   
	    {
			fprintf(pfLog , "\n[vCalculaComision]TR:[%d] PlComis:[%s] Conc:[%d] Universo:[%s] IndProcequi:[%s]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->szCodUniverso, paux->szIndProcequi);
			fprintf(stderr, "\n[vCalculaComision]TR:[%d] PlComis:[%s] Conc:[%d] Universo:[%s] IndProcequi:[%s]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->szCodUniverso, paux->szIndProcequi);
			
			if (bValidaEvento(paux,qaux))
			{
				pNuevo = (stEvento *) malloc(sizeof(stEvento));						   

				/* copiamos los valores del evento...	*/
				pNuevo->lNumGeneral		        = qaux->lNumGeneral;
				strcpy(pNuevo->szCodUniverso	, qaux->szCodUniverso);
				strcpy(pNuevo->szCodTipComis	, qaux->szCodTipComis);
				pNuevo->lCodComisionista	    = qaux->lCodComisionista;
				pNuevo->lNumCelular		        = qaux->lNumCelular;
				strcpy(pNuevo->szCodCategCliente, szfnTrim(qaux->szCodCategCliente));
				strcpy(pNuevo->szCodPlanTarif	, qaux->szCodPlanTarif);
				strcpy(pNuevo->szFechaEvento	, qaux->szFechaEvento);
				strcpy(pNuevo->szCodCausaBaja	, szfnTrim(qaux->szCodCausaBaja));
				strcpy(pNuevo->szNomUsuario	    , qaux->szNomUsuario);

				strcpy(pNuevo->szIndProcequi	, qaux->szIndProcequi);

				strcpy(pNuevo->szCodCategoria	, qaux->szCodCategoria);
				strcpy(pNuevo->szTipPlan	    , qaux->szTipPlan);
				pNuevo->iDiasVenta		        = qaux->iDiasVenta;
				pNuevo->iDiasRecepcion		    = qaux->iDiasRecepcion;
				pNuevo->iDiasAceptacion		    = qaux->iDiasAceptacion;
				pNuevo->dImporteTotal		    = 0;
				pNuevo->dImporteBase		    = 0;
				pNuevo->dImporteEquipo		    = 0;
				pNuevo->dImporteTrafico		    = 0;
				pNuevo->lCantMinutos		    = 0;
				pNuevo->dImporteTarifa		    = 0;
																   
				/* anexamos el nodo a	la lista principal */								  
				pNuevo->sgte	    = paux->sgte_evento;						     
				paux->sgte_evento   = pNuevo;								   
																   
				/* Comenzamos	la recuperación	de los montos... */							  
				/* Importe Base	y Equipo */										
				vAsignaImporteBase(paux->sgte_plan, pNuevo, paux->szCodTipCalculo, paux->iNomFechaDesde);	  
				
				if (strcmp(pNuevo->szCodUniverso, UNIRECHAZO) == 0)
				{
					if (strcmp(paux->szIndTrafico,"S") == 0)
					{
						vAsignaImporteTrafico(pNuevo);								
					}
					vEvaluaUsuarioExepcion(paux->sgte_usuar,pNuevo);     
				}												   
			}
		}													   
	}														   
} 														     
/*---------------------------------------------------------------------------*/
/* EVALUA EXCEPCION DE USUARIO:	SI EXISTE USUARIO EN LISTA, IMPORTE_BASE = 0 */
/* USUARIO = paux->szNom_Usuario					                         */
/* LISTA   = qaux							                                 */
/* SI EXISTE ->	  paux->dImp_Base = 0					                     */
/*---------------------------------------------------------------------------*/
void vEvaluaUsuarioExepcion(stParam *	qaux,stEvento *	paux)		    
{									  
    if (qaux != NULL)	
    {					  
		if (strcmp(qaux->szValParametro1 , paux->szNomUsuario)==0)
		{
	 	    paux->dImporteBase = 0;
		    fprintf(pfLog,"\t(vEvaluaUsuarioExepcion)Evento:[%ld] Universo:[%s]-->Importe Base$[%f]	UsuarioExcepcion[%s] \n",paux->lNumGeneral,paux->szCodUniverso, paux->dImporteBase, paux->szNomUsuario);
		}		
		else							  
		{
		    vEvaluaUsuarioExepcion(qaux->sgte, paux);	  
		}
	}
}										 
/*---------------------------------------------------------------------------*/
/* Funcion que inserta en la tabla Valorizados y Detalle Rechazos	         */
/*---------------------------------------------------------------------------*/
void vGrabaPrincipal()
{												     
    stPrincipal  *paux;										    
    stEvento     *qaux;										    

    long	lCantBajas;							       
    long	lCantRecha;							       
													    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
								       
		char	szhCodUniverso[7];							       
		int		ihCodConcepto;								       
		char	szhCodTipComis[3];							       
		long	lhCodPeriodo;								       
		char	szhIdPeriodo[11];							       
		long	lhNumGeneral;									     
		long	lhCodComisionista;								       
		double	dhImporteEquipo;								       
		double	dhImporteBase;									       
		double	dhImporteTrafico;								       
		long	lhCantMinutos;									       
		double	dhImporteTarifa;								       
		double	dhImporteConcepto;
	    int		ihCodTipoRed;							      
    /* EXEC SQL END DECLARE SECTION; */ 
								       
													    
    lCantBajas = 0;										       
    lCantRecha = 0;				     
	
    for(paux=lstPrincipal;paux!=NULL;paux=paux->sgte)					       
    {											       
		strcpy(szhCodUniverso	, paux->szCodUniverso);
		strcpy(szhCodTipComis	, paux->szCodTipComis);
		ihCodConcepto			= paux->iCodConcepto;
	    ihCodTipoRed            = paux->iCodTipoRed;

		lhCodPeriodo			= stCiclo.lCodCiclComis;  
	    strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);	
															    
	    for(qaux=paux->sgte_evento;qaux!=NULL;qaux=qaux->sgte)
		{
			lhNumGeneral		= qaux->lNumGeneral;
	   		lhCodComisionista	= qaux->lCodComisionista;
	   		dhImporteEquipo		= fnCnvDouble(qaux->dImporteEquipo , 0);
	   		dhImporteBase		= fnCnvDouble(qaux->dImporteBase   , 0);
	   		dhImporteTrafico	= fnCnvDouble(qaux->dImporteTrafico, 0);
	   		lhCantMinutos		= qaux->lCantMinutos;
	   		dhImporteTarifa		= qaux->dImporteTarifa;
	   		dhImporteConcepto	= 0;
											       
	   		/*Calcula el importe total */							  
	   		dhImporteConcepto = dhImporteEquipo	+ dhImporteBase + dhImporteTrafico;			
	   		dhImporteConcepto = fnCnvDouble(dhImporteConcepto, 0);
													      														      
		   /* EXEC SQL INSERT
			INTO CMT_VALORIZADOS (
				NUM_GENERAL,
				COD_UNIVERSO,
				COD_CONCEPTO,
				COD_TIPCOMIS,
				COD_COMISIONISTA,
				COD_PERIODO,
				ID_PERIODO,
				IMP_CONCEPTO, 
				COD_TIPORED)
			VALUES (
				:lhNumGeneral,									      
				:szhCodUniverso,								      
				:ihCodConcepto,								      
				:szhCodTipComis,								      
				:lhCodComisionista,								      
				:lhCodPeriodo,									      
				:szhIdPeriodo,									      
				:dhImporteConcepto, 
            	:ihCodTipoRed); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_UNIVERSO,CO\
D_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP_CONCEPTO,C\
OD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )86;
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
     sqlstm.sqhstv[7] = (unsigned char  *)&dhImporteConcepto;
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

								      
												
           	lCantBajas++ ;	
											      
	   		if (strcmp(paux->szCodUniverso, UNIRECHAZO)== 0)					      
	   		{											      
				/* EXEC SQL INSERT	INTO CMT_DETALLE_RECHAZOS					      
					(NUM_GENERAL      , COD_TIPCOMIS, 
             		COD_COMISIONISTA , COD_PERIODO ,		      
			 		ID_PERIODO       , COD_CONCEPTO,
		            IMP_EQUIPO       , IMP_RECHAZO ,			      
		    		IMP_TRAFICO      , MIN_SALIDA  ,
 	         		VAL_PLAN         , COD_TIPORED  )					      
				VALUES							       
					(:lhNumGeneral     , :szhCodTipComis,
             		:lhCodComisionista, :lhCodPeriodo  ,		
		 	 		:szhIdPeriodo     , :ihCodConcepto ,
             		:dhImporteEquipo  , :dhImporteBase ,		
			 		:dhImporteTrafico , :lhCantMinutos ,
             		:dhImporteTarifa  , :ihCodTipoRed); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_DETALLE_RECHAZOS (NUM_GENERAL,COD_TIPCOMI\
S,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,COD_CONCEPTO,IMP_EQUIPO,IMP_RECHAZO,\
IMP_TRAFICO,MIN_SALIDA,VAL_PLAN,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:\
b6,:b7,:b8,:b9,:b10,:b11)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )137;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhImporteEquipo;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhImporteBase;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhImporteTrafico;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhCantMinutos;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteTarifa;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
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

				
		
 			lCantRecha++;										
	    	}											
		}													
    }		      
												  
    lCantBajas -=lCantRecha;										     
    stStatusProc.lCantBajasWrit = lCantBajas;									 
    stStatusProc.lCantRechaWrit = lCantRecha; 
										       
}												
/*---------------------------------------------------------------------------*/
/* Funcion que retorna los minutos y el	monto							     */
/*---------------------------------------------------------------------------*/
void vAsignaImporteTrafico(stEvento *	qaux)			  
{								
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
				
		long	lhMinutos;					
		double	dhTarifa;					
		long	lhNumCelular;					
		long	lhCodPeriodo;					
		char	szhCodPlanTarif[4];				
    /* EXEC SQL END DECLARE SECTION; */ 
				
								  
    lhCodPeriodo = stCiclo.lCodCiclComis;	 
    
    lhNumCelular           = qaux->lNumCelular;			  
    strcpy(szhCodPlanTarif , qaux->szCodPlanTarif);		
								
    lhMinutos =	0;						
    dhTarifa  =	0;						
																
    /* EXEC SQL							
    SELECT NVL (SUM (MINS_TRAF), 0)				
      INTO :lhMinutos						
    FROM TA_TRAFICO_CELULAR_MES					
    WHERE NUM_CELULAR =	:lhNumCelular				
       AND IND_ENTSAL =	2					
       AND TO_CHAR (FECHA_TRAF,	'YYYYMMDD') = :lhCodPeriodo ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(sum(MINS_TRAF),0) into :b0  from TA_TRAFICO_CE\
LULAR_MES where ((NUM_CELULAR=:b1 and IND_ENTSAL=2) and TO_CHAR(FECHA_TRAF,'YY\
YYMMDD')=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )200;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhMinutos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCelular;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError();
}

	  
								
    qaux->lCantMinutos	= lhMinutos;				
								
    /* EXEC SQL							
    SELECT NVL(MAX (tarifa),0)
      INTO :dhTarifa
      FROM (SELECT NVL((60 * IMP_AIRE /	SEG_FRACCION),0) AS TARIFA
	      FROM TA_TFAIRE
	     WHERE CLS_TARIFA =	'LOC'
	       AND TIP_DIA = '1'
	       AND COD_FRANCONS	= 'FCG'
	       AND COD_PLANTARIF = :szhCodPlanTarif
	    UNION
	    SELECT NVL((60 * IMP_AIRE_RF / SEG_FRACCION),0)
	      FROM TA_TFAIRE
	     WHERE CLS_TARIFA =	'LOC'
	       AND TIP_DIA = '1'
	       AND COD_FRANCONS	= 'FCG'
	       AND COD_PLANTARIF = :szhCodPlanTarif
	    UNION
	    SELECT NVL((60 * IMP_AIRE_RM / SEG_FRACCION),0)
	      FROM TA_TFAIRE
	     WHERE CLS_TARIFA =	'LOC'
	       AND TIP_DIA = '1'
	       AND COD_FRANCONS	= 'FCG'
	       AND COD_PLANTARIF = :szhCodPlanTarif); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(max(tarifa),0) into :b0  from (select NVL(((60\
* IMP_AIRE)/SEG_FRACCION),0) TARIFA  from TA_TFAIRE where (((CLS_TARIFA='LOC' \
and TIP_DIA='1') and COD_FRANCONS='FCG') and COD_PLANTARIF=:b1) union select N\
VL(((60* IMP_AIRE_RF)/SEG_FRACCION),0)  from TA_TFAIRE where (((CLS_TARIFA='LO\
C' and TIP_DIA='1') and COD_FRANCONS='FCG') and COD_PLANTARIF=:b1) union selec\
t NVL(((60* IMP_AIRE_RM)/SEG_FRACCION),0)  from TA_TFAIRE where (((CLS_TARIFA=\
'LOC' and TIP_DIA='1') and COD_FRANCONS='FCG') and COD_PLANTARIF=:b1)) ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )227;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTarifa;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[3] = (unsigned long )4;
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


								
    qaux->dImporteTarifa=dhTarifa;				
								
    qaux->dImporteTrafico = dhTarifa *	lhMinutos;
    fprintf(pfLog,"\t-->Importe	Tarifa$[%f] Trafico$[%f] \n", qaux->dImporteTarifa, qaux->dImporteTrafico);
} 								  
/*---------------------------------------------------------------------------*/
/* FUNCION QUE ASIGNA IMPORTE BASE					     				     */
/*---------------------------------------------------------------------------*/
void vAsignaImporteBase(stPlan *lstPlan, stEvento * pNuevo, char * pszCodTipCalculo, int piNomDias)
{												
    char	cCodTipCalculo[2];
    int		iDiasDesde;								  
    
    strcpy(cCodTipCalculo , pszCodTipCalculo);
    
    if (lstPlan	== NULL)
    {												
	pNuevo->dImporteBase	      =	0.00;
	pNuevo->dImporteEquipo	      =	0.00;                                              

    }												
    else											
    {
	    if (((strcmp(lstPlan->szTipPlan   ,  pNuevo->szTipPlan	      )==0)&&		   
		(strcmp(lstPlan->szCodCategCliente,  pNuevo->szCodCategCliente)==0)) ||		
		((strcmp(lstPlan->szTipPlan,"TODAS") == 0) &&	
		(strcmp(lstPlan->szCodCategCliente,"TODAS") ==	0 )))
		{										  
			pNuevo->dImporteEquipo	      =	lstPlan->dImporteEquipo;    
			
			fprintf	(pfLog,"\n(vAsignaImporteBase) cCodTipCalculo [%s]",cCodTipCalculo);
			if(strcmp(cCodTipCalculo,"D") == 0)
			{
				pNuevo->dImporteBase	      =	lstPlan->dImporteBase;
			}
			if(strcmp(cCodTipCalculo,"I") == 0)
			{
  			    /* determina la cantidad de días a considerar	en la evaluacion de plazos */
			    iDiasDesde = iGetDiasDesde(pNuevo,piNomDias);
				/* evalúa la cantidad de días con la lista de plazos. */
				pNuevo->dImporteBase	 = dGetImportePlazos(lstPlan->sgte_tiempo,iDiasDesde);
			}															
		}
		else
			vAsignaImporteBase(lstPlan->sgte, pNuevo, cCodTipCalculo, piNomDias);
	}
    fprintf(pfLog,"\n\t-->Evento [%ld] Importe Base$[%f] Equipo$[%f]", pNuevo->lNumGeneral,pNuevo->dImporteBase, pNuevo->dImporteEquipo);
}
/*---------------------------------------------------------------------------*/
/* FUNCION QUE DETERMINA LA CANTIDAD DE	DIAS (PARAMETRO) A EVALUAR PARA	     */
/* LOS PLAZOS.								     							 */
/*---------------------------------------------------------------------------*/
int iGetDiasDesde(stEvento * qaux, int iDias)
{
	int	iRetorno = 0;
	fprintf(pfLog, "\n\t(iGetDiasDesde) Nombre de Fecha:[%d]",iDias);
	switch (iDias)
	{
		case iDIASVENTA:
			iRetorno = qaux->iDiasVenta;
			break;
		case iDIASRECEP:
			iRetorno = qaux->iDiasRecepcion;
			break;
		case iDIASACEPT:
			iRetorno = qaux->iDiasAceptacion;
			break;
	}
	fprintf(pfLog, " Dias Retorno:[%d]\n",iRetorno);
	return (iRetorno);
}
/*---------------------------------------------------------------------------*/
/* Funcion de busca el importe de plazos				     				 */
/*---------------------------------------------------------------------------*/
double dGetImportePlazos(stTiempos * qaux,int	iDias)
{												    
    int	iContinue = 0;
    double	dImporte = 0.0;
	
    if (qaux == NULL) return(0);
       
    fprintf(pfLog,"\n(dGetImportePlazos)Dias :[%d]\n",iDias);

    if (iDias <= qaux->iDiasDesde)
    {
		fprintf(pfLog,"\n\t Es Primer Tramo... Dias:[%d] <= Desde:[%d] Comision:[%f]\n",iDias,qaux->iDiasDesde, qaux->dImpPenaliza);
		return(qaux->dImpPenaliza);
    }
	
    while(iContinue == 0)
    {
		fprintf(pfLog,"\n\t -> Evalua tramo Desde:[%d] Hasta:[%d] Comision:[%f]",qaux->iDiasDesde, qaux->iDiasHasta,qaux->dImpPenaliza );
		if (((iDias > qaux->iDiasDesde)&&(iDias <= qaux->iDiasHasta))||(qaux->iDiasHasta == -1))
		{
			dImporte = qaux->dImpPenaliza;
			iContinue = 1;
			fprintf(pfLog,"	Encontrado!!!\n");
		}
		else
		{
			fprintf(pfLog,"	Siguiente!!!\n");
			qaux = qaux->sgte;
			if (qaux == NULL)
			{
				dImporte = 0.0;
				iContinue = 1;
			}
		}
    }
    return (dImporte);
} 												      
/*---------------------------------------------------------------------------*/
/* Funcion de Carga de Parametro					     					 */
/*---------------------------------------------------------------------------*/
stParam * stCargaParam( int piCodTipCodigo)						
{										      
    stParam	   *paux;							      
    stParam	   *qaux;							      
										      
    int		  	           i;							
    short	iLastRows    = 0;						
    int		iFetchedRows = MAXFETCH;					
    int		iRetrievRows = MAXFETCH;					
											
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
							
		char	szhValParametro1[MAXFETCH][11];				
		int		ihCodCodigo;  
		int		ihTipCodigo;
		long	lMaxFetch;							
    /* EXEC SQL END DECLARE SECTION; */ 
							

    paux = NULL;
    qaux = NULL;

    ihTipCodigo = ITIPOCODIGO;
    ihCodCodigo	= piCodTipCodigo;
    lMaxFetch   = MAXFETCH;

    /* EXEC SQL DECLARE Cur_Parametro CURSOR FOR
	SELECT VAL_PARAMETRO1
	FROM   CMD_PARAMETROS
	WHERE  COD_TIPCODIGO	= :ihTipCodigo
	AND    COD_CODIGO	= :ihCodCodigo
	AND    COD_PARAMETRO	> 0; */ 

    /* EXEC SQL OPEN Cur_Parametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )258;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTipCodigo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCodigo;
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
		/* EXEC SQL for :lMaxFetch
			 FETCH Cur_Parametro INTO :szhValParametro1; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )281;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhValParametro1;
  sqlstm.sqhstl[0] = (unsigned long )11;
  sqlstm.sqhsts[0] = (         int  )11;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
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



		iRetrievRows = sqlca.sqlerrd[2]	- iLastRows;
		iLastRows    = sqlca.sqlerrd[2];
	
		for (i=0; i < iRetrievRows; i++)
		{
			paux = (stParam	*) malloc(sizeof(stParam));

			strcpy(paux->szValParametro1  , szfnTrim(szhValParametro1[i]));

			fprintf(pfLog,	"\t(stCargaParam)Parametro...[%s]\n", paux->szValParametro1);
			paux->sgte	  = qaux;
			qaux		  = paux;
		}
    }
    /* EXEC SQL CLOSE Cur_Parametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )300;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

							
    return(qaux);								
} 											  
/*---------------------------------------------------------------------------*/
/*  Funcion para Planes													     */
/*---------------------------------------------------------------------------*/
stPlan * stCargaPlan( int piCodTipoRed , char * pszCodPlanComis , int piCodConcepto )
{										     
	stPlan	      *pPlanaux;							     
	stPlan	      *qaux;							       
	int			               i;							       
	short		iLastRows    = 0;					       
	int		iFetchedRows = MAXFETCH;				       
	int		iRetrievRows = MAXFETCH;				       
										       
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
	
		int     ihCodTipoRed      ;		
		int		ihCodConcepto     ;
    	char    szhCodPlanComis[6];			       

		long	lMaxFetch;

		char	szhTipoPlan		[MAXFETCH][6];					    
		char	szhCodCategCliente	[MAXFETCH][11];				    
		double	dhImpBase		[MAXFETCH];					     
		double	dhImpEquipo		[MAXFETCH];						  
	/* EXEC SQL END DECLARE SECTION; */ 
						       
										     
	ihCodTipoRed            = piCodTipoRed;
	ihCodConcepto			= piCodConcepto;
	strcpy(szhCodPlanComis	, pszCodPlanComis);
										     
	lMaxFetch = MAXFETCH;							       
	qaux      = NULL;	  

	/* EXEC SQL DECLARE CUR_PLANES CURSOR FOR
		SELECT TIP_PLAN,
		       COD_CATEGCLIENTE,
		       NVL(IMP_BASE,0),
		       NVL(IMP_EQUIPO,0)
		FROM   CM_DETPENALIZA_TD
		WHERE COD_TIPORED   = :ihCodTipoRed
		AND   COD_PLANCOMIS = :szhCodPlanComis
        AND   COD_CONCEPTO  = :ihCodConcepto; */ 

		  										       
	/* EXEC SQL OPEN CUR_PLANES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )315;
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
			 FETCH CUR_PLANES INTO					       
				:szhTipoPlan,						
				:szhCodCategCliente,				       
				:dhImpBase,					       
				:dhImpEquipo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )342;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhTipoPlan;
  sqlstm.sqhstl[0] = (unsigned long )6;
  sqlstm.sqhsts[0] = (         int  )6;
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
  sqlstm.sqhstv[2] = (unsigned char  *)dhImpBase;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )sizeof(double);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)dhImpEquipo;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )sizeof(double);
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

					       
										     
		iRetrievRows = sqlca.sqlerrd[2]	- iLastRows;			       
		iLastRows    = sqlca.sqlerrd[2];  
		
						
		for (i=0; i < iRetrievRows; i++)				       
		{
			pPlanaux = (stPlan *) malloc(sizeof(stPlan));			 
			
			strcpy(pPlanaux->szTipPlan			, szfnTrim(szhTipoPlan[i]));
			strcpy(pPlanaux->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
			pPlanaux->dImporteBase				= dhImpBase[i];										  
			pPlanaux->dImporteEquipo			= dhImpEquipo[i];

			fprintf(pfLog,"\tszTipPlan	      	  [%s]\n",pPlanaux->szTipPlan	    );
			fprintf(pfLog,"\tszCodCategCliente    [%s]\n",pPlanaux->szCodCategCliente );
			fprintf(pfLog,"\tdImporteBase	      [%f]\n",pPlanaux->dImporteBase	    );
			fprintf(pfLog,"\tdImporteEquipo       [%f]\n",pPlanaux->dImporteEquipo    );
			
			fprintf(pfLog,"\tCarga Plazos de evaluacion para Universo de Datos.\n");
			pPlanaux->sgte_tiempo = stCargaTiempo(ihCodTipoRed   ,
                                                  szhCodPlanComis,
                                                  ihCodConcepto  ,
                                                  pPlanaux->szTipPlan,
                                                  pPlanaux->szCodCategCliente);
			pPlanaux->sgte	= qaux;															      
			qaux		= pPlanaux;															  
		}			
	}			      
	/* EXEC SQL CLOSE CUR_PLANES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )373;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}

    
	return(qaux);		      
}
/*----------------------------------------------------------------------------*/
/*  Funcion para los Plazos						      */
/*----------------------------------------------------------------------------*/
stTiempos *stCargaTiempo(int piCodTipoRed, char * pszCodPlanComis, int piCodConcepto, char * pszTipPlan, char * pszCodCategCliente)
{													  
	stTiempos	*paux;										    
	stTiempos	*qaux;										    
	int			i;										    
	short		iLastRows    = 0;								    
	int			iFetchedRows = MAXFETCH;							    
	int			iRetrievRows = MAXFETCH;							    

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int		ihCodTipoRed;
     	char    szhCodPlanComis[6];
  	    int		ihCodConcepto;
		char	szhTipPlan[6];
		char	szhCodCategCliente[11];

		long	lMaxFetch;

		int		ihDiasDesde[MAXFETCH];
		int		ihDiasHasta[MAXFETCH];
		double	dhImpPenaliza[MAXFETCH];
	/* EXEC SQL END DECLARE SECTION; */ 

		
	ihCodTipoRed              =  piCodTipoRed;
    ihCodConcepto		  	  =  piCodConcepto;
    strcpy(szhCodPlanComis	  ,  pszCodPlanComis);
	strcpy(szhTipPlan	  	  ,  pszTipPlan);
    strcpy(szhCodCategCliente ,  pszCodCategCliente);

	paux = NULL;
	qaux = NULL;
	lMaxFetch = MAXFETCH;

	/* EXEC SQL DECLARE CUR_PLAZOS CURSOR FOR
		SELECT DIAS_DESDE,
		       DIAS_HASTA,
		       IMP_PENALIZA
		FROM   CM_PLAZOS_PENALIZA_TD
	WHERE  COD_TIPORED      = :ihCodTipoRed
     AND   COD_CONCEPTO		= :ihCodConcepto
	 AND   COD_PLANCOMIS	= :szhCodPlanComis
	 AND   TIP_PLAN			= :szhTipPlan
	 AND   COD_CATEGCLIENTE	= :szhCodCategCliente
	ORDER BY DIAS_DESDE DESC; */ 

	
	/* EXEC SQL OPEN CUR_PLAZOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )388;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanComis;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhTipPlan;
 sqlstm.sqhstl[3] = (unsigned long )6;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodCategCliente;
 sqlstm.sqhstl[4] = (unsigned long )11;
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
		FETCH CUR_PLAZOS INTO
		 		:ihDiasDesde,
		     	:ihDiasHasta,
		     	:dhImpPenaliza; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )423;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihDiasDesde;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihDiasHasta;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)dhImpPenaliza;
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


		
		iRetrievRows = sqlca.sqlerrd[2]	- iLastRows;
		iLastRows    = sqlca.sqlerrd[2];

		for (i=0; i < iRetrievRows; i++)
		{
			paux = (stTiempos *) malloc(sizeof(stTiempos));

			paux->iDiasDesde     =	ihDiasDesde[i];
			paux->iDiasHasta     =	ihDiasHasta[i];
			paux->dImpPenaliza   =	dhImpPenaliza[i];
	
			fprintf(pfLog, "\t\t(stCargaTiempo)iDiasDesde	  :[%d]\n",paux->iDiasDesde	);
			fprintf(pfLog, "\t\t(stCargaTiempo)iDiasHasta	  :[%d]\n",paux->iDiasHasta	);
			fprintf(pfLog, "\t\t(stCargaTiempo)dImpPenaliza   :[%f]\n",paux->dImpPenaliza);

			paux->sgte	  = qaux;
			qaux		  = paux;
		}
	}													    
	/* EXEC SQL CLOSE CUR_PLAZOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )450;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}

									    
	return(qaux);										    
} 													    
/*----------------------------------------------------------------------------*/
/* Obtiene categoria de	Plan tarifario para evaluar Excepcion de Plan Total   */
/*----------------------------------------------------------------------------*/
char * szfnCategoriaPlan(char * pszCodPlanTarif,char * pszhFecVenta)								
{															      
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
												
		char	szhFecVenta[9];												
		char	szhCodPlanTarif[4];											
		char	szhCodCategoria[4];											
    /* EXEC SQL END DECLARE SECTION; */ 
		 
    
    strcpy (szhCodPlanTarif, pszCodPlanTarif);
    strcpy (szhFecVenta, pszhFecVenta);
	
    /* EXEC SQL SELECT COD_CATEGORIA												
	       INTO :szhCodCategoria												
	       FROM VE_CATPLANTARIF												
  	      WHERE COD_PLANTARIF   =	:szhCodPlanTarif									
	      AND   COD_PRODUCTO    =	1											
	      AND   FEC_EFECTIVIDAD =	(SELECT	MAX(FEC_EFECTIVIDAD)								
					 FROM   VE_CATPLANTARIF						
					 WHERE  COD_PLANTARIF    = :szhCodPlanTarif			
					 AND    FEC_EFECTIVIDAD <= TO_DATE(:szhFecVenta,'YYYYMMDD')); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CATEGORIA into :b0  from VE_CATPLANTARIF where\
 ((COD_PLANTARIF=:b1 and COD_PRODUCTO=1) and FEC_EFECTIVIDAD=(select max(FEC_E\
FECTIVIDAD)  from VE_CATPLANTARIF where (COD_PLANTARIF=:b1 and FEC_EFECTIVIDAD\
<=TO_DATE(:b3,'YYYYMMDD'))))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )465;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodCategoria;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecVenta;
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

	
	
    return (szfnTrim(szhCodCategoria));											
} 																  
/*---------------------------------------------------------------------------*/
/* Carga Eventos de Baja						     */
/*---------------------------------------------------------------------------*/
stEvento * stCargaEventosBaja()
{
    stConceptosProc * raux;    
    stEvento	    * paux;
    stEvento	    * qaux;

    int		i;
    short	iLastRows    = 0;
    int		iFetchedRows = MAXFETCH;
    int		iRetrievRows = MAXFETCH;
    int		lCantReg = 0;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char    szhCodTipComis[3];        
		char	szhCodUniverso[7];
		long	lhCodPeriodo;
		char	szhIdPeriodo[11];

		long	lMaxFetch;
	
		long	lhNumGeneral		[MAXFETCH];
		long	lhCodComisionista	[MAXFETCH];
		long	lhNumCelular		[MAXFETCH];
		char	szhCodCategCliente	[MAXFETCH][11];
		char	szhCodPlanTarif		[MAXFETCH][4];
		char	szhFecBaja			[MAXFETCH][11];
		char	szhFecVenta			[MAXFETCH][9];
		char	szhFecAux			[9];		 		
		char	szhCodCausaBaja		[MAXFETCH][6];
		char	szhNomUsuario		[MAXFETCH][31];
		char	szhIndProcequi		[MAXFETCH][2];
		char	szhTipPlan			[MAXFETCH][6];
		int		ihDiasVenta			[MAXFETCH];
		int		ihDiasRecepcion		[MAXFETCH];
		int		ihDiasAceptacion	[MAXFETCH];
    	int	    ihCodTipoRed        [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

	
    paux = NULL;  
    qaux = NULL;
    lCantReg  = 0;	

    lhCodPeriodo	  	  = stCiclo.lCodCiclComis;
    strcpy(szhCodUniverso , UNIBAJAS);
    strcpy(szhIdPeriodo	  , stCiclo.szIdCiclComis);
    
    
    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
    {        
		strcpy(szhCodTipComis	, raux->szCodTipComis);
		iLastRows    	= 0;          
		iFetchedRows 	= MAXFETCH;   
		iRetrievRows 	= MAXFETCH;   
		lMaxFetch 		= MAXFETCH;   
	
	    fprintf(stderr, "\n[stCargaEventosBaja] Cargando Eventos de Baja...TipComis[%s] Ciclo:[%s]\n",szhCodTipComis, szhIdPeriodo );
		
        /* EXEC SQL DECLARE CUR_BAJAS CURSOR FOR
			SELECT	A.NUM_GENERAL, 
					A.COD_COMISIONISTA,
					A.NUM_CELULAR, 
					A.COD_CATEGCLIENTE, 
					A.COD_PLANTARIF, 
					TO_CHAR(A.FEC_BAJA,'DD-MM-YYYY'),
					TO_CHAR(A.FEC_VENTA,'YYYYMMDD'),
					A.COD_CAUSABAJA, 
					C.NOM_USUARIO,
					A.IND_PROCEQUI,	
					C.TIP_PLAN,
					TRUNC(A.FEC_BAJA - A.FEC_VENTA),	 
					TRUNC(A.FEC_BAJA - A.FEC_RECEPCION),
					TRUNC(A.FEC_BAJA - A.FEC_ACEPTACION), 
					A.COD_TIPORED
	   		FROM 	CMT_BAJAS_CELULAR A, 
	        	 	CMD_PLANESTARIF C
			WHERE 	A.COD_TIPCOMIS  = :szhCodTipComis
	  		AND 	A.COD_PERIODO   = :lhCodPeriodo
	  		AND 	A.ID_PERIODO    = :szhIdPeriodo
	  		AND	 	A.COD_PLANTARIF = C.COD_PLANTARIF; */ 


		/* EXEC SQL OPEN CUR_BAJAS; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0010;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )496;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodPeriodo;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
  sqlstm.sqhstl[2] = (unsigned long )11;
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
	   		/* EXEC SQL for :lMaxFetch
		 		FETCH CUR_BAJAS INTO 
			       	:lhNumGeneral		,
			        :lhCodComisionista	,
		       		:lhNumCelular		,
		       		:szhCodCategCliente	,
		       		:szhCodPlanTarif	,
		       		:szhFecBaja			,
		       		:szhFecVenta		,
		       		:szhCodCausaBaja	,  
		       		:szhNomUsuario		,  
		       		:szhIndProcequi		,    
		       		:szhTipPlan			, 
		       		:ihDiasVenta		,
		       		:ihDiasRecepcion	,
		       		:ihDiasAceptacion   , 
				    :ihCodTipoRed		; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 15;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )lMaxFetch;
      sqlstm.offset = (unsigned int  )523;
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
      sqlstm.sqhstv[3] = (unsigned char  *)szhCodCategCliente;
      sqlstm.sqhstl[3] = (unsigned long )11;
      sqlstm.sqhsts[3] = (         int  )11;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqharc[3] = (unsigned long  *)0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodPlanTarif;
      sqlstm.sqhstl[4] = (unsigned long )4;
      sqlstm.sqhsts[4] = (         int  )4;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqharc[4] = (unsigned long  *)0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhFecBaja;
      sqlstm.sqhstl[5] = (unsigned long )11;
      sqlstm.sqhsts[5] = (         int  )11;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqharc[5] = (unsigned long  *)0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhFecVenta;
      sqlstm.sqhstl[6] = (unsigned long )9;
      sqlstm.sqhsts[6] = (         int  )9;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqharc[6] = (unsigned long  *)0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)szhCodCausaBaja;
      sqlstm.sqhstl[7] = (unsigned long )6;
      sqlstm.sqhsts[7] = (         int  )6;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqharc[7] = (unsigned long  *)0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)szhNomUsuario;
      sqlstm.sqhstl[8] = (unsigned long )31;
      sqlstm.sqhsts[8] = (         int  )31;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqharc[8] = (unsigned long  *)0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)szhIndProcequi;
      sqlstm.sqhstl[9] = (unsigned long )2;
      sqlstm.sqhsts[9] = (         int  )2;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqharc[9] = (unsigned long  *)0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)szhTipPlan;
      sqlstm.sqhstl[10] = (unsigned long )6;
      sqlstm.sqhsts[10] = (         int  )6;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqharc[10] = (unsigned long  *)0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)ihDiasVenta;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[11] = (         int  )sizeof(int);
      sqlstm.sqindv[11] = (         short *)0;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqharc[11] = (unsigned long  *)0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)ihDiasRecepcion;
      sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[12] = (         int  )sizeof(int);
      sqlstm.sqindv[12] = (         short *)0;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqharc[12] = (unsigned long  *)0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
      sqlstm.sqhstv[13] = (unsigned char  *)ihDiasAceptacion;
      sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[13] = (         int  )sizeof(int);
      sqlstm.sqindv[13] = (         short *)0;
      sqlstm.sqinds[13] = (         int  )0;
      sqlstm.sqharm[13] = (unsigned long )0;
      sqlstm.sqharc[13] = (unsigned long  *)0;
      sqlstm.sqadto[13] = (unsigned short )0;
      sqlstm.sqtdso[13] = (unsigned short )0;
      sqlstm.sqhstv[14] = (unsigned char  *)ihCodTipoRed;
      sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[14] = (         int  )sizeof(int);
      sqlstm.sqindv[14] = (         short *)0;
      sqlstm.sqinds[14] = (         int  )0;
      sqlstm.sqharm[14] = (unsigned long )0;
      sqlstm.sqharc[14] = (unsigned long  *)0;
      sqlstm.sqadto[14] = (unsigned short )0;
      sqlstm.sqtdso[14] = (unsigned short )0;
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


	     				 
	   		iRetrievRows = sqlca.sqlerrd[2]- iLastRows;
	   		iLastRows    = sqlca.sqlerrd[2];
					
	   		for (i=0; i < iRetrievRows; i++)
	   		{		    
	 			paux = (stEvento *) malloc(sizeof(stEvento));
			
				strcpy(paux->szCodTipComis		, szhCodTipComis);
				strcpy(paux->szCodUniverso		, UNIBAJAS);
				paux->lNumGeneral				= lhNumGeneral[i];
				paux->lCodComisionista			= lhCodComisionista[i];
				paux->lNumCelular				= lhNumCelular[i];
				paux->iCodTipoRed				= ihCodTipoRed[i];

				strcpy(paux->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
				strcpy(paux->szCodPlanTarif		, szfnTrim(szhCodPlanTarif[i]));
				strcpy(paux->szFechaEvento		, szfnTrim(szhFecBaja[i]));
				
				strcpy(szhFecAux				, szfnTrim(szhFecVenta[i]));
				strcpy(paux->szCodCategoria		, szfnCategoriaPlan(paux->szCodPlanTarif,szhFecAux));

				strcpy(paux->szCodCausaBaja		, szfnTrim(szhCodCausaBaja[i]));
				strcpy(paux->szNomUsuario		, szfnTrim(szhNomUsuario[i]));
				strcpy(paux->szIndProcequi		, szfnTrim(szhIndProcequi[i]));
				strcpy(paux->szTipPlan			, szfnTrim(szhTipPlan[i]));
			
				paux->iDiasVenta		= ihDiasVenta[i];	   
				paux->iDiasRecepcion	= ihDiasRecepcion[i]; 
				paux->iDiasAceptacion	= ihDiasAceptacion[i];
				paux->dImporteTotal		= 0;
				paux->dImporteBase		= 0;
				paux->dImporteEquipo	= 0;
				paux->dImporteTrafico	= 0;
				paux->lCantMinutos		= 0;
				paux->dImporteTarifa	= 0;
		
				paux->sgte	  = qaux;
				qaux		  = paux;
				lCantReg++;
	   		}
		}
    	/* EXEC SQL CLOSE CUR_BAJAS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )598;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
     if (sqlca.sqlcode < 0) vSqlError();
}


    }	
    stStatusProc.lCantBajasRead = lCantReg;
    fprintf(pfLog,"(stCargaEventosBaja) Registros Leidos [%d].\n", lCantReg);
    fprintf(stderr,"(stCargaEventosBaja) Registros Leidos [%d].\n", lCantReg);
    return(qaux);
}
/*---------------------------------------------------------------------------*/
/* Carga Eventos de Rechazo						     */
/*---------------------------------------------------------------------------*/
stEvento * stCargaEventosRechazo()
{
    stConceptosProc * raux;    
    stEvento	    * paux;
    stEvento	    * qaux;
	
    int					   i;
    short	iLastRows    = 0;
    int		iFetchedRows = MAXFETCH;
    int		iRetrievRows = MAXFETCH;
    long	lCantReg;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char    szhCodTipComis[3];        
		char	szhCodUniverso[6];
		long	lhCodPeriodo;
		char	szhIdPeriodo[11];

		long	lMaxFetch;

		long	lhNumGeneral		[MAXFETCH]; 
		long	lhCodComisionista	[MAXFETCH];
		long	lhNumCelular		[MAXFETCH];	  
		char	szhCodCategCliente	[MAXFETCH][11];	  
		char	szhCodPlanTarif		[MAXFETCH][4];	     
		char	szhFecRechazo		[MAXFETCH][11];		 
		char	szhFecVenta			[MAXFETCH][9];		 
		char	szhFecAux			[9];		 
		char	szhCodCausaRec		[MAXFETCH][3];
		char	szhNomUsuario		[MAXFETCH][31];		  
		char	szhIndProcequi		[MAXFETCH][2];
		char	szhTipPlan			[MAXFETCH][6];
		int		ihDiasVenta			[MAXFETCH];	     
		int		ihDiasRecepcion		[MAXFETCH];	   
    	int	    ihCodTipoRed        [MAXFETCH];  	
    /* EXEC SQL END DECLARE SECTION; */ 

		
    lCantReg = 0;
    strcpy(szhCodUniverso,  UNIRECHAZO);

    lhCodPeriodo	  	=  stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo ,  stCiclo.szIdCiclComis);
	
    paux = NULL;  
    qaux = NULL;		
    lMaxFetch = MAXFETCH;

    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
    {			
		strcpy(szhCodTipComis	, raux->szCodTipComis);
		iLastRows    	= 0;          
		iFetchedRows 	= MAXFETCH;   
		iRetrievRows 	= MAXFETCH;   
		lMaxFetch 		= MAXFETCH;   
				
		/* EXEC SQL DECLARE CUR_RECHAZ CURSOR FOR
			SELECT	A.NUM_GENERAL, 
					A.COD_COMISIONISTA,
					A.NUM_CELULAR,	    
					A.COD_CATEGCLIENTE, 
					A.COD_PLANTARIF, 
					TO_CHAR(A.FEC_RECHAZO,'DD-MM-YYYY'),
					TO_CHAR(A.FEC_VENTA,'YYYYMMDD'),
					A.COD_CAUSAREC,	
					A.NOM_USUARIO,
					A.IND_PROCEQUI,	
					C.TIP_PLAN,
					TRUNC(A.FEC_RECHAZO - A.FEC_VENTA),	       
					TRUNC(A.FEC_RECHAZO - A.FEC_RECEPCION), 
	 				A.COD_TIPORED
			FROM	CMT_RECHAZOS_CELULAR A,	
					CMD_PLANESTARIF	C
			WHERE	A.NUM_GENERAL >	0
			AND		A.COD_TIPCOMIS  = :szhCodTipComis
			AND		A.COD_PERIODO	= :lhCodPeriodo
			AND		A.ID_PERIODO	= :szhIdPeriodo 
			AND		C.COD_PLANTARIF	= A.COD_PLANTARIF; */ 


		/* EXEC SQL OPEN CUR_RECHAZ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 15;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0011;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )613;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodPeriodo;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
  sqlstm.sqhstl[2] = (unsigned long )11;
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
	    	 /* EXEC SQL for :lMaxFetch
			 	FETCH CUR_RECHAZ INTO	
					:lhNumGeneral		,
					:lhCodComisionista	,
					:lhNumCelular		,
					:szhCodCategCliente	,
					:szhCodPlanTarif	,
					:szhFecRechazo		,
					:szhFecVenta		,
					:szhCodCausaRec		,	
					:szhNomUsuario		,	
					:szhIndProcequi		,
					:szhTipPlan			,
					:ihDiasVenta		,   
					:ihDiasRecepcion	, 
					:ihCodTipoRed		; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 15;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )lMaxFetch;
       sqlstm.offset = (unsigned int  )640;
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
       sqlstm.sqhstv[3] = (unsigned char  *)szhCodCategCliente;
       sqlstm.sqhstl[3] = (unsigned long )11;
       sqlstm.sqhsts[3] = (         int  )11;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqharc[3] = (unsigned long  *)0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szhCodPlanTarif;
       sqlstm.sqhstl[4] = (unsigned long )4;
       sqlstm.sqhsts[4] = (         int  )4;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqharc[4] = (unsigned long  *)0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)szhFecRechazo;
       sqlstm.sqhstl[5] = (unsigned long )11;
       sqlstm.sqhsts[5] = (         int  )11;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqharc[5] = (unsigned long  *)0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)szhFecVenta;
       sqlstm.sqhstl[6] = (unsigned long )9;
       sqlstm.sqhsts[6] = (         int  )9;
       sqlstm.sqindv[6] = (         short *)0;
       sqlstm.sqinds[6] = (         int  )0;
       sqlstm.sqharm[6] = (unsigned long )0;
       sqlstm.sqharc[6] = (unsigned long  *)0;
       sqlstm.sqadto[6] = (unsigned short )0;
       sqlstm.sqtdso[6] = (unsigned short )0;
       sqlstm.sqhstv[7] = (unsigned char  *)szhCodCausaRec;
       sqlstm.sqhstl[7] = (unsigned long )3;
       sqlstm.sqhsts[7] = (         int  )3;
       sqlstm.sqindv[7] = (         short *)0;
       sqlstm.sqinds[7] = (         int  )0;
       sqlstm.sqharm[7] = (unsigned long )0;
       sqlstm.sqharc[7] = (unsigned long  *)0;
       sqlstm.sqadto[7] = (unsigned short )0;
       sqlstm.sqtdso[7] = (unsigned short )0;
       sqlstm.sqhstv[8] = (unsigned char  *)szhNomUsuario;
       sqlstm.sqhstl[8] = (unsigned long )31;
       sqlstm.sqhsts[8] = (         int  )31;
       sqlstm.sqindv[8] = (         short *)0;
       sqlstm.sqinds[8] = (         int  )0;
       sqlstm.sqharm[8] = (unsigned long )0;
       sqlstm.sqharc[8] = (unsigned long  *)0;
       sqlstm.sqadto[8] = (unsigned short )0;
       sqlstm.sqtdso[8] = (unsigned short )0;
       sqlstm.sqhstv[9] = (unsigned char  *)szhIndProcequi;
       sqlstm.sqhstl[9] = (unsigned long )2;
       sqlstm.sqhsts[9] = (         int  )2;
       sqlstm.sqindv[9] = (         short *)0;
       sqlstm.sqinds[9] = (         int  )0;
       sqlstm.sqharm[9] = (unsigned long )0;
       sqlstm.sqharc[9] = (unsigned long  *)0;
       sqlstm.sqadto[9] = (unsigned short )0;
       sqlstm.sqtdso[9] = (unsigned short )0;
       sqlstm.sqhstv[10] = (unsigned char  *)szhTipPlan;
       sqlstm.sqhstl[10] = (unsigned long )6;
       sqlstm.sqhsts[10] = (         int  )6;
       sqlstm.sqindv[10] = (         short *)0;
       sqlstm.sqinds[10] = (         int  )0;
       sqlstm.sqharm[10] = (unsigned long )0;
       sqlstm.sqharc[10] = (unsigned long  *)0;
       sqlstm.sqadto[10] = (unsigned short )0;
       sqlstm.sqtdso[10] = (unsigned short )0;
       sqlstm.sqhstv[11] = (unsigned char  *)ihDiasVenta;
       sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[11] = (         int  )sizeof(int);
       sqlstm.sqindv[11] = (         short *)0;
       sqlstm.sqinds[11] = (         int  )0;
       sqlstm.sqharm[11] = (unsigned long )0;
       sqlstm.sqharc[11] = (unsigned long  *)0;
       sqlstm.sqadto[11] = (unsigned short )0;
       sqlstm.sqtdso[11] = (unsigned short )0;
       sqlstm.sqhstv[12] = (unsigned char  *)ihDiasRecepcion;
       sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[12] = (         int  )sizeof(int);
       sqlstm.sqindv[12] = (         short *)0;
       sqlstm.sqinds[12] = (         int  )0;
       sqlstm.sqharm[12] = (unsigned long )0;
       sqlstm.sqharc[12] = (unsigned long  *)0;
       sqlstm.sqadto[12] = (unsigned short )0;
       sqlstm.sqtdso[12] = (unsigned short )0;
       sqlstm.sqhstv[13] = (unsigned char  *)ihCodTipoRed;
       sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[13] = (         int  )sizeof(int);
       sqlstm.sqindv[13] = (         short *)0;
       sqlstm.sqinds[13] = (         int  )0;
       sqlstm.sqharm[13] = (unsigned long )0;
       sqlstm.sqharc[13] = (unsigned long  *)0;
       sqlstm.sqadto[13] = (unsigned short )0;
       sqlstm.sqtdso[13] = (unsigned short )0;
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


													 
	     	iRetrievRows = sqlca.sqlerrd[2]	- iLastRows;
	     	iLastRows    = sqlca.sqlerrd[2];

	     	for (i=0; i < iRetrievRows; i++)
	     	{
				paux = (stEvento *) malloc(sizeof(stEvento));
			
				strcpy(paux->szCodUniverso		, UNIRECHAZO);	
				paux->lNumGeneral				= lhNumGeneral[i];
				strcpy(paux->szCodTipComis		, szhCodTipComis);
				paux->lCodComisionista			= lhCodComisionista[i];
				paux->lNumCelular				= lhNumCelular[i];
				strcpy(paux->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
				strcpy(paux->szCodPlanTarif		, szfnTrim(szhCodPlanTarif[i]));
				strcpy(paux->szFechaEvento		, szfnTrim(szhFecRechazo[i]));
				strcpy(paux->szCodCausaBaja		, szfnTrim(szhCodCausaRec[i]));
				strcpy(paux->szNomUsuario		, szfnTrim(szhNomUsuario[i]));
				strcpy(paux->szIndProcequi		, szfnTrim(szhIndProcequi[i]));
				strcpy(paux->szTipPlan			, szfnTrim(szhTipPlan[i]));	 

				paux->iCodTipoRed				= ihCodTipoRed[i];     
				paux->iDiasVenta				= ihDiasVenta[i];
				paux->iDiasRecepcion			= ihDiasRecepcion[i];	
				
				strcpy(szhFecAux				, szfnTrim(szhFecVenta[i]));
				strcpy(paux->szCodCategoria		, szfnCategoriaPlan(paux->szCodPlanTarif,szhFecAux));
				paux->iDiasAceptacion			= 0;						     
				paux->dImporteTotal				= 0;
				paux->dImporteBase				= 0;
				paux->dImporteEquipo			= 0;
				paux->dImporteTrafico			= 0;
				paux->lCantMinutos				= 0;
				paux->dImporteTarifa			= 0;
			
				paux->sgte	  = qaux;
				qaux		  = paux;
				lCantReg++;
	  	   }
		}
    	/* EXEC SQL CLOSE CUR_RECHAZ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 15;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )711;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
     if (sqlca.sqlcode < 0) vSqlError();
}


    }
    stStatusProc.lCantRechaRead = lCantReg;
    fprintf(pfLog,"(stCargaEventosRechazo) Cantidad de Registros:[%ld].\n", lCantReg);
    fprintf(stderr,"(stCargaEventosRechazo) Cantidad de Registros:[%ld].\n", lCantReg);
    return(qaux);
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.							     						 */
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
/* Header.								     								 */
/*---------------------------------------------------------------------------*/	
    vFechaHora();                                                               
    fprintf(stderr, "\nProcesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision: [%s]\n", LAST_REVIEW);                
	fprintf(pfLog, "Base de datos : %s\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog,"Usuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);
    fprintf(pfLog, "Identificador de Proceso		<%s>\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque			<%s>\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion			<%d>\n", stArgs.izSecuencia);

/*---------------------------------------------------------------------------*/
/* Modificacion	de configuracion ambiental, para manejo	de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )726;
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
/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA PRINCIPAL DE VALORACION DE UNIVERSOS		     		 */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Carga estructura principal de valoracion...\n\n");       
    fprintf(stderr,  "Carga estructura principal de valoracion...\n\n");       
    vCargaPrincipal();										   
/*---------------------------------------------------------------------------*/
/* CARGA UNIVERSO DE BAJAS DE CONTRATO DEL PERIODO			     			 */
/*---------------------------------------------------------------------------*/
    vFechaHora();									 
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());	 
    fprintf(pfLog ,  "Carga universo de bajas...\n\n");	 
    fprintf(stderr,  "Carga universo de bajas...\n\n");	 
    lstBajas = stCargaEventosBaja();
/*---------------------------------------------------------------------------*/
/* CARGA UNIVERSO DE RECHAZOS DE CONTRATO DEL PERIODO			     		 */
/*---------------------------------------------------------------------------*/
    vFechaHora();								    
    fprintf(pfLog,	"\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,	"Carga universo	de rechazos ...\n\n");	
    fprintf(stderr,	"Carga universo	de rechazos ...\n\n");	
    lstRechazos = stCargaEventosRechazo();						
/*---------------------------------------------------------------------------*/
/* CALCULA COMISION SOBRE EL UNIVERSO DE BAJAS							     */
/*---------------------------------------------------------------------------*/
    vFechaHora();								     
    fprintf(pfLog   , "\n\n%s\n", (char *)pszFechaHora()); 
    fprintf(pfLog   , "Calcula comisión por bajas...\n\n");
    fprintf(stderr  , "Calcula comisión por bajas...\n\n");
    vCalculaComision(lstBajas);							
/*---------------------------------------------------------------------------*/
/* CALCULA COMISION SOBRE EL UNIVERSO DE RECHAZOS						     */
/*---------------------------------------------------------------------------*/
    vFechaHora();									
    fprintf(pfLog   ,	"\n\n%s\n", (char *)pszFechaHora());	
    fprintf(pfLog   ,	"Calcula comisión por rechazos...\n\n");
    fprintf(stderr  ,	"Calcula comisión por rechazos...\n\n");
    vCalculaComision(lstRechazos);							
/*---------------------------------------------------------------------------*/
/* GRABA REGISTROS EN CMT_VALORIZADOS....				    				 */
/*---------------------------------------------------------------------------*/
    vFechaHora();									      
    fprintf(pfLog   ,	"\n\n%s\n", (char *)pszFechaHora());	      
    fprintf(pfLog   ,	"Graba resultados en cmt_valorizados...\n\n");
    fprintf(stderr  ,	"Graba resultados en cmt_valorizados...\n\n");
    vGrabaPrincipal();									
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA...						     					 */
/*---------------------------------------------------------------------------*/
    vFechaHora();									  
    fprintf(pfLog ,	"\n\n%s\n", (char *)pszFechaHora());	  
    fprintf(pfLog ,	"Libera	memoria	utilizada...\n\n");	
    fprintf(stderr,	"Libera	memoria	utilizada...\n\n");	
    vLiberaPrincipal(lstPrincipal);						 
    vLiberaDatosEvento(lstBajas);						 
    vLiberaDatosEvento(lstRechazos);	
    vLiberaConceptosVal(lstConceptosProc);					
/*---------------------------------------------------------------------------*/
/* Recuperacion	de los segundos	reales ocupados	por el proceso.		     	 */
/*---------------------------------------------------------------------------*/
    lSegFin=lGetTimer();					  
    stStatusProc.lSegProceso = lSegFin - lSegIni;	
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion	estadistica del	proceso.		     		 */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "\nEstadistica del proceso\n");								 
    fprintf(pfLog,	"------------------------\n");									 
    fprintf(pfLog,	"Segundos Reales Utilizados	: [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(pfLog,	"Cantidad de Bajas Leidas	: [%d]\n",stStatusProc.lCantBajasRead);			       
    fprintf(pfLog,	"Cantidad de Bajas Valoradas	: [%d]\n",stStatusProc.lCantBajasWrit);			       
    fprintf(pfLog,	"Cantidad de Rechazos Leidos	: [%d]\n",stStatusProc.lCantRechaRead);			       
    fprintf(pfLog,	"Cantidad de Rechazos Valorados	: [%d]\n",stStatusProc.lCantRechaWrit);			       

    fprintf(stderr, "\nEstadistica del proceso\n");								 
    fprintf(stderr,	"------------------------\n");									 
    fprintf(stderr,	"Segundos Reales Utilizados	: [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(stderr,	"Cantidad de Bajas Leidas	: [%d]\n",stStatusProc.lCantBajasRead);			       
    fprintf(stderr,	"Cantidad de Bajas Valoradas	: [%d]\n",stStatusProc.lCantBajasWrit);			       
    fprintf(stderr,	"Cantidad de Rechazos Leidos	: [%d]\n",stStatusProc.lCantRechaRead);			       
    fprintf(stderr,	"Cantidad de Rechazos Valorados	: [%d]\n",stStatusProc.lCantRechaWrit);			       
																	       
    if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"",stStatusProc.lSegProceso, stStatusProc.lCantBajasWrit +	stStatusProc.lCantRechaWrit))  
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));					

	fprintf(pfLog,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
	fprintf(stderr,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
    
    /* EXEC SQL COMMIT	WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )741;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

													  
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

