
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
    "./pc/Val_Churn.pc"
};


static unsigned int sqlctx = 6931019;


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
"select NUM_DESDE ,NUM_HASTA ,IMP_COMISION  from CM_MATRIZ_CHURN_TD where ((C\
OD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2)           ";

 static char *sq0002 = 
"select NUM_GENERAL ,COD_TIPCOMIS ,COD_COMISIONISTA ,NUM_ALTAS ,NUM_BAJAS ,NU\
M_CHURN  from CM_EVALUA_CHURN_TO where (ID_CICLCOMIS=:b0 and COD_TIPORED=:b1) \
          ";

 static char *sq0003 = 
"select distinct B.COD_VENDEDOR  from VE_REDVENTAS_TD B ,VE_VENDEDORES C wher\
e ((B.COD_TIPORED=:b0 and B.COD_VENDEDOR=C.COD_VENDEDOR) and C.COD_TIPCOMIS=:b\
1)           ";

 static char *sq0005 = 
"select NUM_GENERAL  from CMT_HABIL_CELULAR where ((COD_COMISIONISTA=:b0 and \
ID_PERIODO=:b1) and COD_TIPORED=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,146,0,9,84,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
32,0,0,1,0,0,13,88,0,0,3,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,
59,0,0,1,0,0,15,109,0,0,0,0,0,1,0,
74,0,0,2,164,0,9,174,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
97,0,0,2,0,0,13,178,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,
0,0,
136,0,0,2,0,0,15,209,0,0,0,0,0,1,0,
151,0,0,3,167,0,9,263,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
174,0,0,3,0,0,13,267,0,0,1,0,0,1,0,2,3,0,0,
193,0,0,3,0,0,15,293,0,0,0,0,0,1,0,
208,0,0,4,190,0,3,336,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
259,0,0,5,123,0,9,391,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
286,0,0,5,0,0,13,395,0,0,1,0,0,1,0,2,3,0,0,
305,0,0,5,0,0,15,415,0,0,0,0,0,1,0,
320,0,0,6,48,0,1,636,0,0,0,0,0,1,0,
335,0,0,7,0,0,30,742,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las habilitaciones segun la          */
/* existencia de convenio PAC                                           */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Jueves 26 de Diciembre del 2002.                             */
/* Fin:                                                                 */
/* Autor : Patricio Gonzalez Gomez.                                     */
/************************************************************************/
/* Modificacion :  Jaime Vargas Morales                                 */
/* Inicio       :  Viernes 24 de Enero de 2003                          */
/* descripcion  :  Generacion del nombre y creacion del archivo de log. */
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
#include "Val_Churn.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

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
/* CARGA MATRIZ                                                              */
/*---------------------------------------------------------------------------*/                
stMatriz * Carga_Matriz(int piCodTipoRed, char * pszCodPlanComis, int piCodConcepto)
{               
    stMatriz    * paux;
    stMatriz    * qaux;

    int           i;      
    short         iLastRows    = 0;       
    int           iFetchedRows = MAXFETCH;
    int           iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lMaxFetch;
      	 int	 ihCodTipoRed;
		 char	 szhCodPlanComis[6];
         long    lhCodConcepto;
         double  dhDesde         [MAXFETCH];
         double  dhHasta         [MAXFETCH];
         double  dhChurn         [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

        
    lMaxFetch = MAXFETCH;        
    qaux      = NULL;    
        
    strcpy(szhCodPlanComis, pszCodPlanComis);
    ihCodTipoRed          = piCodTipoRed;
    lhCodConcepto         = piCodConcepto;
        
    /* EXEC SQL DECLARE Cur_Matriz CURSOR FOR
         SELECT  NUM_DESDE, 
                 NUM_HASTA, 
                 IMP_COMISION  
         FROM    CM_MATRIZ_CHURN_TD
         WHERE   COD_TIPORED   = :ihCodTipoRed
         AND     COD_PLANCOMIS = :szhCodPlanComis
         AND     COD_CONCEPTO  = :lhCodConcepto; */ 

                
    /* EXEC SQL OPEN Cur_Matriz; */ 

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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
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


        
    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch 
                 FETCH Cur_Matriz INTO
                       :dhDesde,       
                       :dhHasta,
                       :dhChurn; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
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
        sqlstm.sqhstv[0] = (unsigned char  *)dhDesde;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )sizeof(double);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)dhHasta;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )sizeof(double);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)dhChurn;
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
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stMatriz *) malloc(sizeof(stMatriz));
                        
            paux->dNumDesde        = dhDesde[i];
            paux->dNumHasta        = dhHasta[i];
            paux->dImpComision     = dhChurn[i];
                        
            paux->sgte              = qaux;
            qaux                    = paux; 
        }
    }        
    /* EXEC SQL CLOSE Cur_Matriz; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )59;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

 
        
    return (qaux);
}
/*---------------------------------------------------------------------------*/
/* LLENA MATRIZ                                                              */
/*---------------------------------------------------------------------------*/
void vLlenaMatriz()
{       
    stPrincipal     * pPrincipal;           
        
    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)
         pPrincipal->sgte_matriz = Carga_Matriz(pPrincipal->iCodTipoRed,pPrincipal->szCodPlanComis, pPrincipal->lCodConcepto );
        
    return;
}

/*---------------------------------------------------------------------------*/
/* CARGA DE LOS REGISTROS DE CHURN DEL PERIODO                               */
/*---------------------------------------------------------------------------*/
void vLlenaHabilitados()
{    
    stConceptosProc * raux;   
    stHabilitado    * pHabilitados;
        
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;      
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int	   	ihCodTipoRed;
        char    szhIdCiclComis[11];
        long    lhCodCiclComis;          

        long    lMaxFetch;
                
        long    lhNumGeneral      [MAXFETCH];
        char    szhCodTipComis     [MAXFETCH][3];  
        long    lhCodComisionista [MAXFETCH];          
        long    lhNumAltas        [MAXFETCH];
        long    lhNumBajas        [MAXFETCH];          
        double  dhNumChurn        [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

        
    strcpy(szhIdCiclComis, stCiclo.szIdCiclComis);
    lhCodCiclComis       = stCiclo.lCodCiclComis;
        
    lMaxFetch = MAXFETCH;

    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
	{
		ihCodTipoRed = raux->iCodTipoRed;
                
        /* EXEC SQL DECLARE Cur_Habil CURSOR FOR
                SELECT  NUM_GENERAL, 
                        COD_TIPCOMIS, 
                        COD_COMISIONISTA,                       
                        NUM_ALTAS, 
                        NUM_BAJAS, 
                        NUM_CHURN
                FROM    CM_EVALUA_CHURN_TO
                WHERE   ID_CICLCOMIS  = :szhIdCiclComis
                AND     COD_TIPORED   = :ihCodTipoRed; */ 

        
        /* EXEC SQL OPEN Cur_Habil; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )74;
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
           /* EXEC SQL for :lMaxFetch 
                    FETCH Cur_Habil INTO
                          :lhNumGeneral      ,
                          :szhCodTipComis    ,           
                          :lhCodComisionista ,
                          :lhNumAltas        ,
                          :lhNumBajas        ,
                          :dhNumChurn; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 6;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )lMaxFetch;
           sqlstm.offset = (unsigned int  )97;
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
           sqlstm.sqhstv[3] = (unsigned char  *)lhNumAltas;
           sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[3] = (         int  )sizeof(long);
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqinds[3] = (         int  )0;
           sqlstm.sqharm[3] = (unsigned long )0;
           sqlstm.sqharc[3] = (unsigned long  *)0;
           sqlstm.sqadto[3] = (unsigned short )0;
           sqlstm.sqtdso[3] = (unsigned short )0;
           sqlstm.sqhstv[4] = (unsigned char  *)lhNumBajas;
           sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[4] = (         int  )sizeof(long);
           sqlstm.sqindv[4] = (         short *)0;
           sqlstm.sqinds[4] = (         int  )0;
           sqlstm.sqharm[4] = (unsigned long )0;
           sqlstm.sqharc[4] = (unsigned long  *)0;
           sqlstm.sqadto[4] = (unsigned short )0;
           sqlstm.sqtdso[4] = (unsigned short )0;
           sqlstm.sqhstv[5] = (unsigned char  *)dhNumChurn;
           sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[5] = (         int  )sizeof(double);
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
           iLastRows    = sqlca.sqlerrd[2];
                
           for (i=0; i < iRetrievRows; i++)                                   
           { 
               pHabilitados = (stHabilitado *) malloc(sizeof(stHabilitado));   
               
               pHabilitados->iCodTipoRed          = ihCodTipoRed;                         
               pHabilitados->lCodCiclComis        = lhCodCiclComis;              
               pHabilitados->lNumGeneral          = lhNumGeneral[i];
               pHabilitados->lCodComisionista     = lhCodComisionista[i];
               pHabilitados->lNumAltas            = lhNumAltas[i];
               pHabilitados->lNumBajas            = lhNumBajas[i];
               pHabilitados->dNumChurn            = dhNumChurn[i];               
                
               strcpy(pHabilitados->szIdCiclComis , szhIdCiclComis);
               strcpy(pHabilitados->szCodTipComis , szhCodTipComis[i]);
                               
               pHabilitados->sgte              = lstHabilitado;
               lstHabilitado                   = pHabilitados;                         
           }                                                              
        }
    	/* EXEC SQL CLOSE Cur_Habil; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 6;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )136;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
     if (sqlca.sqlcode < 0) vSqlError();
}


        
	}  
      
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA PRINCIPAL (TASADOR) PARA LUEGO            */
/* PODER VALORAR LAS HABILITACIONES DE CMD_HABIL_CELULAR                     */
/*---------------------------------------------------------------------------*/
void vLlenaTasador ()
{       
    stConceptosProc * raux;
    stPrincipal     * pPrincipal;   
        
    int             i;      
    short           iLastRows    = 0;      
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;        
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int	   	ihCodTipoRed;
		char	szhCodPlanComis[6];
		int		ihCodConcepto;
        long    dFecDesde;  
        long    dFecHasta;  
        long    lhCodComisionista  [MAXFETCH];
 	    char	szhCodTipComis[3];	
        char    szhCodUniverso[7];

        long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 


    lMaxFetch = MAXFETCH;

    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
	{
		ihCodTipoRed	       = raux->iCodTipoRed;
        ihCodConcepto 		   = raux->iCodConcepto;                        
        dFecDesde              = raux->dFecDesde;  
        dFecHasta              = raux->dFecHasta;  
        strcpy (szhCodUniverso , raux->szCodUniverso);

        strcpy (szhCodTipComis , raux->szCodTipComis);
        strcpy (szhCodPlanComis, raux->szCodPlanComis);                        
                
        /* EXEC SQL DECLARE Cur_Tasador CURSOR FOR
			SELECT  DISTINCT
					B.COD_VENDEDOR 
			FROM    VE_REDVENTAS_TD B,
       				VE_VENDEDORES   C
			WHERE   B.COD_TIPORED  = :ihCodTipoRed
			AND 	B.COD_VENDEDOR = C.COD_VENDEDOR
			AND 	C.COD_TIPCOMIS = :szhCodTipComis; */ 

        
        /* EXEC SQL OPEN Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0003;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )151;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[1] = (unsigned long )3;
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
             /* EXEC SQL for :lMaxFetch FETCH Cur_Tasador INTO :lhCodComisionista; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 6;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.iters = (unsigned int  )lMaxFetch;
             sqlstm.offset = (unsigned int  )174;
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
                 pPrincipal = (stPrincipal *) malloc(sizeof(stPrincipal));                       
                        
				 pPrincipal->iCodTipoRed           = ihCodTipoRed;
                 pPrincipal->lCodConcepto          = ihCodConcepto;                                                            
                 pPrincipal->lPeriodoDesde         = dFecDesde;                                     
                 pPrincipal->lPeriodoHasta         = dFecHasta;     
                 pPrincipal->lCodComisionista      = lhCodComisionista[i];

                 strcpy (pPrincipal->szCodPlanComis, szhCodPlanComis);                        
                 strcpy (pPrincipal->szCodTipComis , szhCodTipComis);
                 strcpy (pPrincipal->szCodUniverso , szhCodUniverso);
                                 
                 pPrincipal->sgte                  = lstPrincipal;
                 lstPrincipal                      = pPrincipal;   
                        
                 pPrincipal->sgte_matriz           = NULL;         
                 pPrincipal->sgte_evento           = NULL;
             }                                                             
        }        
        /* EXEC SQL CLOSE Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
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


	}
}
/*-----------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE INSERTA LOS EVENTOS OBTENIDOS EN LA TABLA CMT_VALORIZADOS */
/*-----------------------------------------------------------------------------*/
void vInsertaValorizados()                                                                                     
{                                                                                                                                                                                                                                
    stPrincipal     * pPrincipal; 
    stEvento        * pEvento;                                                                           
        
    long         lCantReg = 0;
                                                                                                        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
                                                                          
         long    lhNumGeneral;
         long    lhCodComisionista;
         int     ihCodConcepto;
         double  dhImpConcepto;
         char    szhCodTipComis[3];
         char    szhCodUniverso[7];
         long    lhCodPeriodo;
         char    szhIdPeriodo[11];
		 int     ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 
                                                                            

    lhCodPeriodo        = stCiclo.lCodCiclComis;          
    strcpy(szhIdPeriodo , stCiclo.szIdCiclComis); 
                                                                                                                 
    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)                       
    {                                                                                                       
         if (pPrincipal->sgte_evento != NULL)                                                              
         {                                                                                                                       
            ihCodTipoRed          = pPrincipal->iCodTipoRed;
            strcpy(szhCodTipComis , pPrincipal->szCodTipComis);                                                                                           
            strcpy(szhCodUniverso , pPrincipal->szCodUniverso);                                                                                                           
            
			for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)             
            {                                                                                        
                 lhNumGeneral      = pEvento->lNumGeneral;
                 lhCodComisionista = pEvento->lCodComisionista;
                 ihCodConcepto     = pEvento->lCodConcepto;
                 dhImpConcepto     = fnCnvDouble(pEvento->dImpComision, 0);
                                                
                 /* EXEC SQL INSERT INTO CMT_VALORIZADOS                                          
                            (NUM_GENERAL     ,  COD_UNIVERSO,
                             COD_CONCEPTO    ,  COD_TIPCOMIS,
                             COD_COMISIONISTA,  COD_PERIODO ,
                             ID_PERIODO      ,  IMP_CONCEPTO, 
							 COD_TIPORED)                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                      VALUES 
                            (:lhNumGeneral     ,  :szhCodUniverso,
                             :ihCodConcepto    ,  :szhCodTipComis,                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                
                             :lhCodComisionista,  :lhCodPeriodo  ,
                             :szhIdPeriodo     ,  :dhImpConcepto , 
                             :ihCodTipoRed); */ 

{
                 struct sqlexd sqlstm;
                 sqlstm.sqlvsn = 12;
                 sqlstm.arrsiz = 9;
                 sqlstm.sqladtp = &sqladt;
                 sqlstm.sqltdsp = &sqltds;
                 sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD\
_UNIVERSO,COD_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IM\
P_CONCEPTO,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
                 sqlstm.iters = (unsigned int  )1;
                 sqlstm.offset = (unsigned int  )208;
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
                 sqlstm.sqhstv[7] = (unsigned char  *)&dhImpConcepto;
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

  
				lCantReg++;                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
            }                                                                                             
        }                                                                                                     
    }            
    stStatusProc.lCantEvaluaciones = lCantReg;                                                                                                          
    fprintf(pfLog,"[vInsertaValorizados] Cantidad de Registros Grabados [%ld].\n", lCantReg);
}                                                                                                                       
/*---------------------------------------------------------------------------*/
/* CARGANDO EVENTOS                                                          */
/*---------------------------------------------------------------------------*/                
void vCarga_Eventos (stPrincipal * pPrincip, stHabilitado * pHabil, double dImporte)
{                                                                                                                             
    stEvento *paux;                                                                                                      
    stEvento *qaux;
        
    int          i;                                                                                                                                 
    short        iLastRows    = 0;                           
    int          iFetchedRows = MAXFETCH;                     
    int          iRetrievRows = MAXFETCH;                     
                                                                                                                              
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
       
         long    lhCodComisionista ;                                                                                    
         char    szIdCiclComis [11];           
         int     ihCodTipoRed      ;           
         long    lhNumGeneral   [MAXFETCH];

         long    lMaxFetch;                                                                                              
    /* EXEC SQL END DECLARE SECTION; */ 
                                                                                         
                
    qaux = pPrincip->sgte_evento;
                                                                                                                              
    lhCodComisionista     = pHabil->lCodComisionista;
    ihCodTipoRed          = pHabil->iCodTipoRed;

    strcpy(szIdCiclComis  , pHabil->szIdCiclComis);
                        
    /* EXEC SQL DECLARE Cur_Altas CURSOR FOR
             SELECT  NUM_GENERAL
             FROM    CMT_HABIL_CELULAR
             WHERE   COD_COMISIONISTA = :lhCodComisionista
             AND     ID_PERIODO       = :szIdCiclComis
             AND     COD_TIPORED      = :ihCodTipoRed; */ 

                                                                                                                              
    /* EXEC SQL OPEN Cur_Altas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )259;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodComisionista;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szIdCiclComis;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipoRed;
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
              FETCH Cur_Altas INTO                                                                                  
                      :lhNumGeneral; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 9;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )lMaxFetch;
         sqlstm.offset = (unsigned int  )286;
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
              paux = (stEvento *) malloc(sizeof(stEvento));                   
 
              paux->lNumGeneral        = lhNumGeneral[i];     
              paux->lCodConcepto       = pPrincip->lCodConcepto;
              paux->lCodComisionista   = lhCodComisionista;
              paux->dImpComision       = dImporte;
                        
              paux->sgte               = qaux;
              qaux                     = paux; 
         }                                                                                                             
    }                  
    /* EXEC SQL CLOSE Cur_Altas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )305;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    pPrincip->sgte_evento = qaux;                                                                                                                   
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE OBTIENE EL MONTO DE COMISION CORRESPONDIENTE            */
/*---------------------------------------------------------------------------*/
double lGetImporte(stMatriz * qaux, float fChurn)
{
    if (qaux == NULL) return(0);
                
    if ((fChurn > qaux->dNumDesde) && ((fChurn <= qaux->dNumHasta)||(qaux->dNumHasta == -1)))            
       return(qaux->dImpComision);    
    else
       return(lGetImporte(qaux->sgte,fChurn));
}
/*---------------------------------------------------------------------------*/
/* APLICA COMISION AL UNIVSERO SELECCIONADO                                  */
/*---------------------------------------------------------------------------*/                
void vAplicaComision()
{                                                                                                                                                                     
    stHabilitado    * pHabilitados;
    stPrincipal     * pPrincipal;
    double  dComision;

    for (pHabilitados = lstHabilitado; pHabilitados != NULL; pHabilitados = pHabilitados->sgte)             
    {
         for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)              
         {
             if (pHabilitados->lCodComisionista   == pPrincipal->lCodComisionista    &&
                 pHabilitados->iCodTipoRed        == pPrincipal->iCodTipoRed)
                 {               
                      dComision = lGetImporte(pPrincipal->sgte_matriz, pHabilitados->dNumChurn);                                                             
                      vCarga_Eventos(pPrincipal, pHabilitados, dComision);
                 }
         }
    }        
}                                                                                                                                                                     
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE HABILITADOS                           */
/*---------------------------------------------------------------------------*/
void vLiberaDatosHabilitado(stHabilitado * taux)
{
    if (taux == NULL)
    {
        return;
    }       
    vLiberaDatosHabilitado(taux->sgte);     
    free(taux);
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE EVENTOS                               */
/*---------------------------------------------------------------------------*/
void vLiberaDatosEvento(stEvento * raux)
{
    if (raux == NULL)
    {
        return;
    }       
    vLiberaDatosEvento(raux->sgte);
    free(raux);
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE MATRICES                              */
/*---------------------------------------------------------------------------*/
void vLiberaDatosMatriz(stMatriz * qaux)
{        
    if (qaux == NULL)
        return;
    vLiberaDatosMatriz(qaux->sgte);
    free(qaux);
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA PRINCIPAL (TASADOR)                      */
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{        
    if (paux == NULL)
        return;
    vLiberaPrincipal(paux->sgte);
    vLiberaDatosMatriz(paux->sgte_matriz);
    vLiberaDatosEvento(paux->sgte_evento);
    free(paux);
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
		    fprintf(pfLog , "[bCargaConceptos] Carga lista de conceptos para ejecucion Periodica o Normal..\n\n");  
		    fprintf(stderr, "[bCargaConceptos] Carga lista de conceptos para ejecucion Periodica o Normal...\n\n");  
		    lstConceptosProc = stGetConceptosPer(FORMACOMIS,stCiclo);
		    return TRUE;
		case ESPORADICO:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "[bCargaConceptos] Carga lista de conceptos para ejecucion Esporadica	o Promocional..\n\n");	
		    fprintf(stderr, "[bCargaConceptos] Carga lista de conceptos para ejecucion Esporadica	o Promocional...\n\n");	 
		    lstConceptosProc = stGetConceptosProm(FORMACOMIS,stCiclo);
		    return TRUE;
		default:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "[bCargaConceptos] Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    fprintf(stderr, "[bCargaConceptos] Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    return FALSE;
	}	
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
    long    lSegIni, lSegFin, lSegProceso;
    int     ibiblio = 0;
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
    sqlstm.offset = (unsigned int  )320;
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
    vLlenaTasador();
/*---------------------------------------------------------------------------*/
/* CARGA MATRIZ                                           		     		 */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Carga matriz de Evaluación del Indicador de Churn...\n\n");       
    fprintf(stderr,  "Carga matriz de Evaluación del Indicador de Churn...\n\n");       
    vLlenaMatriz();
/*---------------------------------------------------------------------------*/
/* PODER VALORAR LAS HABILITACIONES DE CMD_HABIL_CELULAR                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Carga de los registros de Churn del periodo...\n\n");       
    fprintf(stderr,  "Carga de los registros de Churn del periodo...\n\n");       
    vLlenaHabilitados();                
/*---------------------------------------------------------------------------*/
/* APLICA COMISION AL UNIVERSO SELECCIONADO                                  */
/*---------------------------------------------------------------------------*/                
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Aplicando comision al universo seleccionado...\n\n");       
    fprintf(stderr,  "Aplicando comision al universo seleccionado...\n\n");       
    vAplicaComision();
/*---------------------------------------------------------------------------*/
/* GRABA REGISTROS VALORIZADOS EN TABLA CMT_VALORIZADOS                      */
/*---------------------------------------------------------------------------*/                
    vFechaHora();										    
    fprintf(pfLog ,  "\n\n%s\n", (char *)pszFechaHora());		       
    fprintf(pfLog ,  "Graba registros en tabla CMT_VALORIZADOS...\n\n");       
    fprintf(stderr,  "Graba registros en tabla CMT_VALORIZADOS...\n\n");       
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA...						     					 */
/*---------------------------------------------------------------------------*/        
    vFechaHora();									  
    fprintf(pfLog,	"\n\n%s\n", (char *)pszFechaHora());	  
    fprintf(pfLog,	"Libera	memoria	utilizada...\n\n");	
    fprintf(stderr,	"Libera	memoria	utilizada...\n\n");	        
    vLiberaPrincipal(lstPrincipal);                  
    vLiberaDatosHabilitado(lstHabilitado);   
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
    fprintf(pfLog,	"Segundos Reales Utilizados	    : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(pfLog,	"Cantidad de Registros Grabados : [%d]\n",stStatusProc.lCantEvaluaciones);			       

    fprintf(stderr, "\nEstadistica del proceso\n");								 
    fprintf(stderr,	"------------------------\n");									 
    fprintf(stderr,	"Segundos Reales Utilizados	    : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(stderr,	"Cantidad de Registros Grabados : [%d]\n",stStatusProc.lCantEvaluaciones);		       
																	       
    if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"",stStatusProc.lSegProceso, stStatusProc.lCantEvaluaciones))  
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));					
    
    /* EXEC SQL COMMIT	WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )335;
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

