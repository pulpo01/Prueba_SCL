
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
    "./pc/Val_HabilPrepago.pc"
};


static unsigned int sqlctx = 887124259;


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
"select NUM_DESDE ,NUM_HASTA ,IMP_COMISION  from CM_MATRIZ_PREPAGO_TD where (\
(COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2)           ";

 static char *sq0002 = 
"select V.COD_VENDEDOR ,C.IMP_COMISION ,C.IND_PROCEQUI  from CM_VALPREPAGO_TD\
 C ,VE_VENDEDORES V ,VE_REDVENTAS_TD R where (((((C.COD_TIPORED=:b0 and C.COD_\
PLANCOMIS=:b1) and C.COD_CONCEPTO=:b2) and C.COD_TIPORED=R.COD_TIPORED) and R.\
COD_VENDEDOR=V.COD_VENDEDOR) and V.COD_TIPCOMIS=:b3)           ";

 static char *sq0003 = 
"select NUM_GENERAL ,COD_COMISIONISTA ,TO_CHAR(FEC_HABILITACION,'DD-MM-YYYY')\
 ,IND_PROCEQUI ,COD_TIPORED ,COD_TIPCOMIS  from CMT_HABIL_PREPAGO where ID_PER\
IODO=:b0 order by COD_COMISIONISTA            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,148,0,9,159,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
32,0,0,1,0,0,13,163,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
59,0,0,1,0,0,15,185,0,0,0,0,0,1,0,
74,0,0,2,295,0,9,271,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
105,0,0,2,0,0,13,280,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,97,0,0,
132,0,0,2,0,0,15,325,0,0,0,0,0,1,0,
147,0,0,3,200,0,9,372,0,0,1,1,0,1,0,1,97,0,0,
166,0,0,3,0,0,13,376,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,
97,0,0,
205,0,0,3,0,0,15,405,0,0,0,0,0,1,0,
220,0,0,4,204,0,4,433,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
259,0,0,5,203,0,4,449,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
298,0,0,6,190,0,3,670,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
349,0,0,7,189,0,3,702,0,0,9,9,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,
400,0,0,8,48,0,1,852,0,0,0,0,0,1,0,
415,0,0,9,0,0,30,959,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa encargado de ejecutar la valoración de habilitaciones de         */
/* celulares de prepago                                                      */
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                  */
/* Inicio: Miercoles 4 de Diciembre de 2002.                                 */
/* Fin:    Lunes 9 de Diciembre de 2002.                                     */
/* Autor : Patricio Gonzalez Gomez                                           */
/*---------------------------------------------------------------------------*/
/* Modificacion : Jaime Vargas Morales                                       */
/* Inicio       : Viernes 24 de Enero de 2003                                */
/* Descripcion  : GENERACION DEL NOMBRE Y CREACION DEL ARCHIVO DE LOG.       */
/* ------------------------------------------------------------------------- */
/* Modificado Marcelo Quiroz Garcia                                          */
/* Se incorporan tratamientos de:                                            */
/* - Ciclos Esporádicos                                                      */
/* - Planes de Comisiones                                                    */
/* - Red de Ventas                                                           */
/* Versionado CUZCO - Oct-2003.                                              */
/* ***************************************************************************/

/* INCLUSION DE LIBRERÍA PARA DEFINICIONES GENERALES DEL PROGRAMA.           */
/*---------------------------------------------------------------------------*/
#include "Val_HabilPrepago.h"
#include "GEN_biblioteca.h"
/*---------------------------------------------------------------------------*/
/* INCLUSION DE BIBLIOTECA PARA MANEJO DE INTERACCION CON ORACLE.            */
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
/* Declaracion e inicializacion	de lista de conceptos a	procesar.	         */
/*---------------------------------------------------------------------------*/
stConceptosProc	* lstConceptosProc = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE VARIABLES GLOBALES PARA SER USADAS CON ORACLE.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE HABILITADOS                           */
/*---------------------------------------------------------------------------*/
void vLiberaDatosHabilitado(stHabilitado * taux)
{
    stHabilitado * saux;
    if (taux!=NULL)
    {
        saux = taux->sgte;
        while (saux!=NULL)
        {
            free(taux);
            taux = saux;
            saux = taux->sgte;
        }
        if(taux!=NULL) free(taux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE EVENTOS                               */
/*---------------------------------------------------------------------------*/
void vLiberaDatosEvento(stEvento * raux)
{
    stEvento * saux;
    if (raux!=NULL)
    {
        saux = raux->sgte;
        while (saux!=NULL)
        {
            free(raux);
            raux = saux;
            saux = raux->sgte;
        }
        if(raux!=NULL) free(raux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE MATRICES                              */
/*---------------------------------------------------------------------------*/
void vLiberaDatosMatriz(stMatriz * qaux)
{
    stMatriz * saux;
    if (qaux!=NULL)
    {
        saux = qaux->sgte;
        while (saux!=NULL)
        {
            free(qaux);
            qaux = saux;
            saux = qaux->sgte;
        }
        if(qaux!=NULL) free(qaux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA PRINCIPAL (TASADOR)                      */
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{
    stPrincipal * raux;
    if (paux != NULL)
    {
        raux = paux->sgte;
        while (raux!=NULL)
        {
            vLiberaDatosMatriz(paux->sgte_matriz);
            vLiberaDatosEvento(paux->sgte_evento);
            free(paux);
            paux = raux;
            raux = paux->sgte;
        }
        if(paux!=NULL) free(paux);
    }
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA EN UNA LISTA LA MATRIZ CON LAS COMISIONES         */
/* CORRESPONDIENTES AL PAR DESDE-HASTA.                                      */
/*---------------------------------------------------------------------------*/
stMatriz * CargaMatriz(int piCodTipoRed, char * pszTipComis, int piCodConcepto)
{
    stMatriz        *paux;
    stMatriz        *qaux;
    int             i;
    short           iLastRows      = 0;
    long            lCantRegistros = 0;
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		int     ihCodTipoRed;
        int     ihCodConcepto; 
        long    lMaxFetch;
    	char	szhCodPlanComis[7];
        long    lhDesde         [MAXFETCH];
        long    lhHasta         [MAXFETCH];
        double  lhImpComision   [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 


    qaux      = NULL;
    paux      = NULL;        
    lMaxFetch = MAXFETCH;   
      
	ihCodTipoRed           = piCodTipoRed;        
    ihCodConcepto          = piCodConcepto;
    strcpy(szhCodPlanComis , pszTipComis);
	
    /* EXEC SQL DECLARE Cur_Matrices CURSOR FOR
         SELECT NUM_DESDE, 
                NUM_HASTA, 
                IMP_COMISION
           FROM CM_MATRIZ_PREPAGO_TD
          WHERE COD_TIPORED   = :ihCodTipoRed
           AND  COD_PLANCOMIS = :szhCodPlanComis
		   AND  COD_CONCEPTO  = :ihCodConcepto; */ 

                      
    /* EXEC SQL OPEN Cur_Matrices; */ 

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
               FETCH Cur_Matrices INTO 
                     :lhDesde,               
                     :lhHasta,               
                     :lhImpComision; */ 

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
        sqlstm.sqhstv[0] = (unsigned char  *)lhDesde;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lhHasta;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)lhImpComision;
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


                                                 
        iRetrievRows    = sqlca.sqlerrd[2] - iLastRows;
        iLastRows       = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stMatriz *) malloc(sizeof(stMatriz));
               
            paux->lNumDesde      = lhDesde[i];
            paux->lNumHasta      = lhHasta[i];
            paux->lImpComision   = lhImpComision[i];                                                                     

            paux->sgte           = qaux; 
            qaux                 = paux;
            lCantRegistros++;
       }
    }
    /* EXEC SQL CLOSE Cur_Matrices; */ 

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


    return(qaux);
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA SECUNDARIA DENOMINADA MATRIZ, DONDE SE    */
/* ALMACENARAN LOS MONTOS DE COMISION CORRESPONDIENTES PARA CADA CASO        */
/*---------------------------------------------------------------------------*/
void vLlenaMatriz()
{       
    stPrincipal     * pPrincipal;
    stMatriz        * pMatriz;
            
    for(pPrincipal=lstPrincipal; pPrincipal!=NULL; pPrincipal=pPrincipal->sgte)
    {
		if (strcmp(pPrincipal->szTipCalculo , TIPCALDIRECTO) !=0)
		{
			pPrincipal->sgte_matriz = CargaMatriz(pPrincipal->iCodTipoRed , pPrincipal->szCodPlanComis, pPrincipal->iCodConcepto);
		}
		else
		{
			pPrincipal->sgte_matriz = NULL;
		}
	}
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA PRINCIPAL (TASADOR) PARA LUEGO            */
/* PODER VALORAR LAS HABILITACIONES DE CMD_HABIL_PREPAGO                     */
/*---------------------------------------------------------------------------*/
void vLlenaTasador ()
{ 
    stConceptosProc * raux;   
    stPrincipal     * pPrincipal;
      
    long            lCantRegistros = 0;
    int             iFetchedRows   = MAXFETCH;
    int             iRetrievRows   = MAXFETCH;
    int             i;
    short           iLastRows      = 0;       
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhFechaInicio   [11];
        char    szhFechaTermino  [11];
        char    szhCodTipComis    [3];
        char	szhCodPlanComis   [6];
	    char	szhCodUniverso    [7];
        char    szhTipCalculo	  [2];

        long    lMaxFetch;
        int     ihCodConcepto;
		int		ihCodTipoRed;
		int     ihValMeta;
		
        long    lhCodVendedor  [MAXFETCH];
        double  lhImpComision  [MAXFETCH];
        char    szhIndProcequi [MAXFETCH][2];
    /* EXEC SQL END DECLARE SECTION; */ 

                

        
    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
	{
        strcpy(szhFechaInicio  , raux->szFecDesde);
        strcpy(szhFechaTermino , raux->szFecHasta);
        strcpy(szhCodTipComis  , raux->szCodTipComis);
        strcpy(szhCodPlanComis , raux->szCodPlanComis);
        strcpy(szhCodUniverso  , raux->szCodUniverso);

		strcpy(szhTipCalculo   , raux->cCodTipCalculo);
		ihCodConcepto          = raux->iCodConcepto;
		ihCodTipoRed   		   = raux->iCodTipoRed;


        /* EXEC SQL DECLARE Cur_Tasador CURSOR FOR      
              SELECT V.COD_VENDEDOR ,     
                     C.IMP_COMISION ,  
                     C.IND_PROCEQUI 					 
                FROM CM_VALPREPAGO_TD   C, 
                 	 VE_VENDEDORES      V, 
				 	 VE_REDVENTAS_TD    R
               WHERE C.COD_TIPORED   = :ihCodTipoRed
                AND  C.COD_PLANCOMIS = :szhCodPlanComis
                AND  C.COD_CONCEPTO  = :ihCodConcepto
		   		AND  C.COD_TIPORED   = R.COD_TIPORED  
		   		AND  R.COD_VENDEDOR  = V.COD_VENDEDOR
		   		AND  V.COD_TIPCOMIS  = :szhCodTipComis; */ 
  
                                              
        /* EXEC SQL OPEN Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
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
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[3] = (unsigned long )3;
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
		iFetchedRows   = MAXFETCH;       
		iRetrievRows   = MAXFETCH;       
		i;                               
		iLastRows      = 0;              
        while(iFetchedRows == iRetrievRows)
        {       
            /* EXEC SQL for :lMaxFetch 
                   FETCH Cur_Tasador INTO 
                       :lhCodVendedor ,      
                       :lhImpComision ,
                       :szhIndProcequi; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 4;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )105;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)lhCodVendedor;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )sizeof(long);
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)lhImpComision;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )sizeof(double);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhIndProcequi;
            sqlstm.sqhstl[2] = (unsigned long )2;
            sqlstm.sqhsts[2] = (         int  )2;
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
               pPrincipal = (stPrincipal *) malloc(sizeof(stPrincipal));

               pPrincipal->iCodTipoRed            = ihCodTipoRed;                        
               pPrincipal->iCodConcepto           = ihCodConcepto;   
               pPrincipal->lCodComisionista       = lhCodVendedor[i];
               pPrincipal->dImpComision           = lhImpComision[i];
               
			   if  (strcmp(szhTipCalculo ,TIPCALMETA)==0)
			   {
               		ihValMeta  = iCargaMeta(ihCodTipoRed, ihCodConcepto, szhCodPlanComis, pPrincipal->lCodComisionista);
			   }
			   else ihValMeta = 0;

               pPrincipal->iValorMeta          	  = ihValMeta;   
               
               pPrincipal->dImpConcepto           = 0.00;
               pPrincipal->iContadorVentas        = 0;
               pPrincipal->fPorcentaje            = 0.00;
               strcpy(pPrincipal->szTipCalculo    ,szfnTrim(szhTipCalculo));

               strcpy(pPrincipal->szCodPlanComis  , szhCodPlanComis);
               strcpy(pPrincipal->szFechaDesde    , szhFechaInicio);
               strcpy(pPrincipal->szFechaHasta    , szhFechaTermino);
               strcpy(pPrincipal->szCodTipComis   , szhCodTipComis);
               strcpy(pPrincipal->szCodUniverso   , szhCodUniverso);
               strcpy(pPrincipal->szIndProcequi   , szfnTrim(szhIndProcequi[i]));
               
               pPrincipal->sgte_evento         = NULL;
               pPrincipal->sgte_matriz         = NULL;
               pPrincipal->sgte                = lstPrincipal;                 
               lstPrincipal                    = pPrincipal;
               lCantRegistros++;
            }       
        }
        /* EXEC SQL CLOSE Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )132;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


	}
	fprintf(pfLog ,"\n[vLlenaTasador] Cantidad de Registros = [%ld]\n",lCantRegistros);       
    fprintf(stderr,"\n[vLlenaTasador] Cantidad de Registros = [%ld]\n",lCantRegistros); 
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LAS HABILITACIONES EN UNA LISTA                   */
/*---------------------------------------------------------------------------*/
void vLlenaHabilitaciones()
{
    stHabilitado * pHabilitado;
        
    int      i;
    long     lCantRegistros = 0;
    int      iLastRows      = 0;       
    int      iFetchedRows = MAXFETCH;
    int      iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhIdPeriodo [11];         

        long    lhNumGeneral           [MAXFETCH];
        long    lhCodComisionista      [MAXFETCH];
        char    szhFechaHabilitacion   [MAXFETCH][11];
        char    szhFechaEvento   	   [MAXFETCH][11];
        char    szIndProcequi          [MAXFETCH][2];
		int     ihCodTipoRed           [MAXFETCH];
        char    szhCodTipComis         [MAXFETCH][3];
        long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 


    pHabilitado   = NULL;
    lstHabilitado = NULL;
    lMaxFetch     = MAXFETCH;   
    strcpy(szhIdPeriodo , stCiclo.szIdCiclComis);   

	/* EXEC SQL DECLARE Cur_Habilitados CURSOR FOR
    	  SELECT  NUM_GENERAL, 
              	  COD_COMISIONISTA, 
                  TO_CHAR(FEC_HABILITACION, 'DD-MM-YYYY'), 
                  IND_PROCEQUI,
                  COD_TIPORED, 
                  COD_TIPCOMIS
          FROM    CMT_HABIL_PREPAGO
          WHERE   ID_PERIODO   = :szhIdPeriodo
          ORDER   BY COD_COMISIONISTA; */ 

    
    /* EXEC SQL OPEN Cur_Habilitados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )147;
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
           FETCH Cur_Habilitados 
           INTO :lhNumGeneral,       
           		:lhCodComisionista,
                :szhFechaEvento,
                :szIndProcequi,
                :ihCodTipoRed,
                :szhCodTipComis; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )166;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhFechaEvento;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )11;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szIndProcequi;
        sqlstm.sqhstl[3] = (unsigned long )2;
        sqlstm.sqhsts[3] = (         int  )2;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)ihCodTipoRed;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[5] = (unsigned long )3;
        sqlstm.sqhsts[5] = (         int  )3;
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
           pHabilitado = (stHabilitado *) malloc(sizeof(stHabilitado));
           
           pHabilitado->iCodTipoRed          = ihCodTipoRed[i];
           pHabilitado->lNumGeneral          = lhNumGeneral[i];
           pHabilitado->lCodComisionista     = lhCodComisionista[i];

           strcpy(pHabilitado->szCodTipComis        , szfnTrim(szhCodTipComis[i]));
           strcpy(pHabilitado->szFechaEvento  		, szfnTrim(szhFechaEvento[i]));
           strcpy(pHabilitado->szIndProcequi        , szfnTrim(szIndProcequi[i]));                 

           lCantRegistros++;
           pHabilitado->sgte  = lstHabilitado;                        
           lstHabilitado      = pHabilitado;     
        }        
    }        
    /* EXEC SQL CLOSE Cur_Habilitados; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )205;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog ,"\n [vlenaHabilitaciones] Cantdad de Registros:[%ld] Ciclo de Comisiones[%s].\n", lCantRegistros, szhIdPeriodo);
    fprintf(stderr,"\n [vlenaHabilitaciones] Cantdad de Registros:[%ld] Ciclo de Comisiones[%s].\n", lCantRegistros, szhIdPeriodo);
}

/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE OBTIENE EL VALOR DE LA META ASOCIADA AL CONCEPTO        */
/*---------------------------------------------------------------------------*/
int iCargaMeta(int pihCodTipoRed, int pihCodConcepto, char *pszhCodPlanComis, long plhCodComisionista)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
		
		int		ihVal_Meta;
		int		ihCodTipoRed;
		int		ihCodConcepto;
		char	szhCodPlanComis[6];
		int		ihCantRegistros;
		long    lhCodComisionista;		
		long    lhCodPeriodo;
	/* EXEC SQL END DECLARE SECTION; */ 

		
	ihCodTipoRed			=	pihCodTipoRed;
	ihCodConcepto			=	pihCodConcepto;
	strcpy(szhCodPlanComis	,	pszhCodPlanComis);
	lhCodComisionista       =   plhCodComisionista;
    lhCodPeriodo            =   stCiclo.lCodCiclComis;        

	ihCantRegistros = 0;

	/* EXEC SQL 
	    SELECT	COUNT(*)
		INTO    :ihCantRegistros
	 	FROM    CM_METASPREPAGO_TD 
	 	WHERE  	COD_TIPORED 	= :ihCodTipoRed
	 	AND 	COD_PLANCOMIS	= :szhCodPlanComis
	 	AND		COD_CONCEPTO	= :ihCodConcepto
	 	AND 	:lhCodPeriodo BETWEEN COD_CICLCOMIS_INI AND COD_CICLCOMIS_FIN 
	 	AND 	COD_COMISIONISTA = :lhCodComisionista; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CM_METASPREPAGO_TD where (((\
(COD_TIPORED=:b1 and COD_PLANCOMIS=:b2) and COD_CONCEPTO=:b3) and :b4 between \
COD_CICLCOMIS_INI and COD_CICLCOMIS_FIN) and COD_COMISIONISTA=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )220;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCantRegistros;
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
 sqlstm.sqhstl[2] = (unsigned long )6;
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
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodPeriodo;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodComisionista;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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


	
	switch(ihCantRegistros)
	{
		case 0: 
			ihVal_Meta = 0;
			break;
		case 1:
			/* EXEC SQL 
			 	SELECT	VAL_META
			 	INTO    :ihVal_Meta
			 	FROM    CM_METASPREPAGO_TD 
			 	WHERE  	COD_TIPORED 	= :ihCodTipoRed
			 	AND 	COD_PLANCOMIS	= :szhCodPlanComis
			 	AND		COD_CONCEPTO	= :ihCodConcepto
			 	AND 	:lhCodPeriodo BETWEEN COD_CICLCOMIS_INI AND COD_CICLCOMIS_FIN 
			 	AND 	COD_COMISIONISTA = :lhCodComisionista; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 6;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select VAL_META into :b0  from CM_METASPREPAGO_TD where ((\
((COD_TIPORED=:b1 and COD_PLANCOMIS=:b2) and COD_CONCEPTO=:b3) and :b4 between\
 COD_CICLCOMIS_INI and COD_CICLCOMIS_FIN) and COD_COMISIONISTA=:b5)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )259;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihVal_Meta;
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
   sqlstm.sqhstl[2] = (unsigned long )6;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodPeriodo;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodComisionista;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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


			break;
		default:
			fprintf(pfLog , "\n[iCargaMeta] Este Comisionista posee mas de una META. TR:[%d] PlComis:[%s] Conc:[%d] Comis:[%d]\n", ihCodTipoRed, szhCodPlanComis, ihCodConcepto, lhCodComisionista);
			fprintf(stderr, "\n[iCargaMeta] Este Comisionista posee mas de una META. TR:[%d] PlComis:[%s] Conc:[%d] Comis:[%d]\n", ihCodTipoRed, szhCodPlanComis, ihCodConcepto, lhCodComisionista);
			ihVal_Meta = 0;
	}
	return (ihVal_Meta); 
}

/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE OBTIENE EL MONTO DE COMISION CORRESPONDIENTE            */
/*---------------------------------------------------------------------------*/
double lGetImporte(stMatriz * qaux, float fCantVentas)
{        
    if (qaux == NULL)
       return(0);
        
    if ((fCantVentas >= qaux->lNumDesde) && ((fCantVentas < qaux->lNumHasta)||(qaux->lNumHasta == -1)))  
    {
    	return(qaux->lImpComision);
    }
    else
    {
		return(lGetImporte(qaux->sgte,fCantVentas));
	}
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE EJECUTA EL CALCULO DE LA COMISION                       */
/*---------------------------------------------------------------------------*/
void vValoraHabilitaciones()
{
    stHabilitado    * pHabilitado;
    stPrincipal     * pPrincipal;
    stEvento        * paux;
    stEvento        * qaux;
    stEvento        * pEvento;

    long            lImpPorVolumen;
    long            lImpPorMonto;
    float           fPorcentaje;
        
    fprintf(stderr,"\n [vValoraHabilitaciones] Asignando las ventas a su correspondiente distribuidor/concepto\n");  
    fprintf(pfLog ,"\n [vValoraHabilitaciones] Asignando las ventas a su correspondiente distribuidor/concepto\n");  

	for (pHabilitado = lstHabilitado; pHabilitado != NULL; pHabilitado = pHabilitado->sgte)
	{       
		for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte) 
		{
			if ( strcmp(pPrincipal->szCodTipComis , pHabilitado->szCodTipComis)  == 0 &&
			     pHabilitado->lCodComisionista == pPrincipal->lCodComisionista &&
			     pHabilitado->iCodTipoRed      == pPrincipal->iCodTipoRed      &&
			    (strcmp(pPrincipal->szIndProcequi,pHabilitado->szIndProcequi)== 0 || 
			     strcmp(pPrincipal->szIndProcequi,PROCEQ_TODAS)== 0))
			{
				if (bValidaFechaEvento(pPrincipal->szFechaDesde, pPrincipal->szFechaHasta, pHabilitado->szFechaEvento))
				{						

					paux = NULL;                            
/*					fprintf(pfLog ,"\n [vValoraHabilitaciones] Asigna venta [%ld] a Concepto:[%d] TipCalculo:[%s]\n",pHabilitado->lNumGeneral, pPrincipal->iCodConcepto,pPrincipal->szTipCalculo);  */
/*					fprintf(stderr,"\n [vValoraHabilitaciones] Asigna venta [%ld] a Concepto:[%d] TipCalculo:[%s]\n",pHabilitado->lNumGeneral, pPrincipal->iCodConcepto,pPrincipal->szTipCalculo);	*/
					
					paux = (stEvento *) malloc(sizeof(stEvento));
					        
					paux->lNumGeneral         = pHabilitado->lNumGeneral;
					strcpy(paux->szCodUniverso, pPrincipal->szCodUniverso);         
					                
					pPrincipal->iContadorVentas ++;
	                            
					if (strcmp(pPrincipal->szTipCalculo, TIPCALDIRECTO)==0)
					{
						paux->lImpConcepto        = pPrincipal->dImpComision;
					   	pPrincipal->dImpConcepto += paux->lImpConcepto;
					}
					else
					{
						paux->lImpConcepto   = 0;  
	                }           
					paux->sgte              = pPrincipal->sgte_evento;
					pPrincipal->sgte_evento = paux;
				}
			}
		}
	}

    fprintf(stderr,"\n [vValoraHabilitaciones] Calculo de comisiones por volumen y metas...\n");      
    fprintf(pfLog ,"\n [vValoraHabilitaciones] Calculo de comisiones por volumen y metas...\n");      

	for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte) 
	{		
		if (pPrincipal->iContadorVentas > 0)                                             
		{
			if (strcmp(pPrincipal->szTipCalculo, TIPCALVOLUMEN)==0)
			{
/*				fprintf(stderr,"\n [vValoraHabilitaciones]Volumen Concepto[%d] Comisionista:[%d] Cantidad:[%ld]\n",pPrincipal->iCodConcepto, pPrincipal->lCodComisionista,pPrincipal->iContadorVentas); */
/*				fprintf(pfLog ,"\n [vValoraHabilitaciones]Volumen Concepto[%d] Comisionista:[%d] Cantidad:[%ld]\n",pPrincipal->iCodConcepto, pPrincipal->lCodComisionista,pPrincipal->iContadorVentas);	*/
				
				lImpPorVolumen  = 0;
				lImpPorVolumen  = lGetImporte(pPrincipal->sgte_matriz,(float )pPrincipal->iContadorVentas);
				        
				for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)                       
				{
					pEvento->lImpConcepto     = lImpPorVolumen;
					pPrincipal->dImpConcepto += pEvento->lImpConcepto;
				}

			}
			if (strcmp(pPrincipal->szTipCalculo, TIPCALMETA)==0)
			{
/*				fprintf(stderr,"\n [vValoraHabilitaciones] Evaluacion Meta Concepto[%d] Comisionista:[%d] Cantidad:[%ld]\n",pPrincipal->iCodConcepto, pPrincipal->lCodComisionista,pPrincipal->iContadorVentas);    */
/*				fprintf(pfLog ,"\n [vValoraHabilitaciones] Evaluacion Meta Concepto[%d] Comisionista:[%d] Cantidad:[%ld]\n",pPrincipal->iCodConcepto, pPrincipal->lCodComisionista,pPrincipal->iContadorVentas);	*/
				
				lImpPorMonto = 0;
				if (pPrincipal->iValorMeta >0 )
				{
					pPrincipal->fPorcentaje = ((float)pPrincipal->iContadorVentas /(float)pPrincipal->iValorMeta) * 100;
				
					lImpPorMonto = lGetImporte(pPrincipal->sgte_matriz, pPrincipal->fPorcentaje);
				}
				else
				{
					lImpPorMonto = 0;
					pPrincipal->fPorcentaje = 0;
				}				
				for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
				{
					pEvento->lImpConcepto     = lImpPorMonto;
					pPrincipal->dImpConcepto += pEvento->lImpConcepto;
				}
			}
		}
    }
}
/*-----------------------------------------------------------------------------*/
/*-----------------------------------------------------------------------------*/
void vMuestraEstructura()
{
	stPrincipal     * paux;
	stMatriz		* qaux;
	for (paux = lstPrincipal; paux!=NULL; paux = paux->sgte)
	{
		fprintf(pfLog, "\n[vMuestra] Tr:[%d] PlCom:[%s] Conc:[%d] Comis:[%d] TipCalc:[%s] ",paux->iCodTipoRed, paux->szCodPlanComis, paux->iCodConcepto, paux->lCodComisionista, paux->szTipCalculo);
		fprintf(pfLog, "\n\t[vMuestra] Meta:[%d] Comision:$[%6.2f] Ventas:[%d] Total:$[%6.2f]", paux->iValorMeta, paux->dImpComision, paux->iContadorVentas, paux->dImpConcepto);

		if (strcmp(paux->szTipCalculo, TIPCALDIRECTO)!=0)
		{
			for (qaux = paux->sgte_matriz; qaux != NULL; qaux = qaux->sgte)
			{
				fprintf(pfLog, "\n\t ----> Desde[%d] Hasta[%d] Comision:[%6.2f]",qaux->lNumDesde, qaux->lNumHasta, qaux->lImpComision);
			}
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

    long            lCantRegistros = 0;
    long			lCantLogroMetas = 0;
    
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumGeneral;
         char    szhCodUniverso[7];
         int     ihCodConcepto;
         char    szhCodTipComis[3];
         long    lhCodComisionista;
         long    lhCodPeriodo;
         char    szhIdPeriodo[11];
         double  dhImpConcepto;
   	     int     ihCodTipoRed;
         float   fhPorcentaje;
         double  dhImpComision;
         int     ihCantRegistros;
    /* EXEC SQL END DECLARE SECTION; */ 
   

    fprintf(stderr, "\n [vInsertaValorizados] Graba Valorizados DIRECTO y por VOLUMEN.\n");
    fprintf(pfLog , "\n [vInsertaValorizados] Graba Valorizados DIRECTO y por VOLUMEN.\n");

    lhCodPeriodo        = stCiclo.lCodCiclComis ;        
    strcpy(szhIdPeriodo , stCiclo.szIdCiclComis);      
    
	for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
    {       
        ihCodConcepto          = pPrincipal->iCodConcepto;
        lhCodComisionista      = pPrincipal->lCodComisionista;
        ihCodTipoRed           = pPrincipal->iCodTipoRed;

        strcpy (szhCodUniverso , pPrincipal->szCodUniverso);
        strcpy (szhCodTipComis , pPrincipal->szCodTipComis);

        for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
        {
            lhNumGeneral    = pEvento->lNumGeneral;
            dhImpConcepto   = fnCnvDouble((double)pEvento->lImpConcepto, 0);

			lCantRegistros++;
			fprintf( pfLog, "\n+++++vInsertaValorizados+[%d]+++++++++++++++++++++++++++++++", lCantRegistros       );
			fprintf( pfLog, "\n[vInsertaValorizados] lhNumGeneral      :[%d]", lhNumGeneral         );
			fprintf( pfLog, "\n[vInsertaValorizados] szhCodUniverso    :[%s]", szhCodUniverso       );
			fprintf( pfLog, "\n[vInsertaValorizados] ihCodConcepto     :[%d]", ihCodConcepto        );
			fprintf( pfLog, "\n[vInsertaValorizados] szhCodTipComis    :[%s]", szhCodTipComis       );
			fprintf( pfLog, "\n[vInsertaValorizados] lhCodComisionista :[%d]", lhCodComisionista    );
			fprintf( pfLog, "\n[vInsertaValorizados] lhCodPeriodo      :[%d]", lhCodPeriodo         );
			fprintf( pfLog, "\n[vInsertaValorizados] szhIdPeriodo      :[%s]", szhIdPeriodo         );
			fprintf( pfLog, "\n[vInsertaValorizados] dhImpConcepto     :[%6.2f]", dhImpConcepto     );
			fprintf( pfLog, "\n[vInsertaValorizados] ihCodTipoRed		:[%d]", ihCodTipoRed		 );

                                                                
            /* EXEC SQL INSERT INTO CMT_VALORIZADOS (
                     NUM_GENERAL     , COD_UNIVERSO, 
                     COD_CONCEPTO    , COD_TIPCOMIS,
                     COD_COMISIONISTA, COD_PERIODO ,
                     ID_PERIODO      , IMP_CONCEPTO, 
                     COD_TIPORED)
             VALUES (
                     :lhNumGeneral     , :szhCodUniverso,
                     :ihCodConcepto    , :szhCodTipComis,
                     :lhCodComisionista, :lhCodPeriodo  ,
                     :szhIdPeriodo     , :dhImpConcepto , 
                     :ihCodTipoRed ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 9;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_UNIV\
ERSO,COD_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP_CON\
CEPTO,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )298;
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


        }
        
		if (strcmp(pPrincipal->szTipCalculo, TIPCALMETA)==0)
		{
			fhPorcentaje    = pPrincipal->fPorcentaje;
    		dhImpComision   = pPrincipal->dImpConcepto;
    		ihCantRegistros = pPrincipal->iContadorVentas;
    		lCantLogroMetas++;

			fprintf( pfLog, "\n+++++++++++vInsrtaLogroMetas++++[%d]+++++++++++++++++++++++++++++++", lCantLogroMetas       );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] szhIdPeriodo        :[%s]", szhIdPeriodo       );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] lhCodPeriodo        :[%d]", lhCodPeriodo       );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] szhCodTipComis      :[%s]", szhCodTipComis     );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] lhCodComisionista   :[%d]", lhCodComisionista  );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] ihCodConcepto       :[%d]", ihCodConcepto      );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] fhPorcentaje        :[%6.2f]", fhPorcentaje    );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] dhImpComision       :[%6.2f]", dhImpComision   );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] ihCantRegistros     :[%d]", ihCantRegistros    );
			fprintf( pfLog, "\n[vInsrtaLogroMetas] ihCodTipoRed		:[%d]", ihCodTipoRed       );
		
    		/* EXEC SQL INSERT INTO CMT_LOGRO_METAS (
             	ID_PERIODO   , COD_PERIODO     , 
             	COD_TIPCOMIS , COD_COMISIONISTA, 
             	COD_CONCEPTO , VAL_LOGRO       , 
             	IMP_CONCEPTO , NUM_REGISTROS   , 
			 	COD_TIPORED) 
         	VALUES (
             	:szhIdPeriodo  , :lhCodPeriodo     ,
             	:szhCodTipComis, :lhCodComisionista,
             	:ihCodConcepto , :fhPorcentaje     ,
             	:dhImpComision , :ihCantRegistros  ,
             	:ihCodTipoRed); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 9;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "insert into CMT_LOGRO_METAS (ID_PERIODO,COD_PERIODO,COD\
_TIPCOMIS,COD_COMISIONISTA,COD_CONCEPTO,VAL_LOGRO,IMP_CONCEPTO,NUM_REGISTROS,C\
OD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )349;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
      sqlstm.sqhstl[0] = (unsigned long )11;
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
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
      sqlstm.sqhstl[2] = (unsigned long )3;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&lhCodComisionista;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
      sqlstm.sqhstv[5] = (unsigned char  *)&fhPorcentaje;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(float);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&dhImpComision;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&ihCantRegistros;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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
    fprintf(stderr, "\n [vInsertaValorizados] Cantidad de Registros Insertados en CMT_VALORIZADOS:[%ld].\n", lCantRegistros);
    fprintf(pfLog , "\n [vInsertaValorizados] Cantidad de Registros Insertados en CMT_VALORIZADOS:[%ld].\n", lCantRegistros);
    stStatusProc.lCantRegistros = lCantRegistros;
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
/* RUTINA PRINCIPAL.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* VARIABLES gLOBALES.                                                       */
/*---------------------------------------------------------------------------*/
    long    lSegIni, lSegFin, lSegProceso;
    int     ibiblio = 0;
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* INICIALIZACION DE ESTRUCTURA DE ARGUMENTOS EXTERNOS, DE ESTADISTICA DEL   */
/* PROCESO Y DE ALGUNA OTRA ESTRUCTURA.                                      */
/*---------------------------------------------------------------------------*/
    memset(&proceso, 0, sizeof(proceso));
    memset(&stCiclo, 0, sizeof(reg_ciclo));
    memset(&stStatusProc, 0, sizeof(stStatusProc));
/*---------------------------------------------------------------------------*/
/* MANEJO DE ARGUMENTOS INGRESADOS COMO PARAMETROS EXTERNOS.                 */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));
    vManejaArgs(argc, argv);
/*---------------------------------------------------------------------------*/
/* CONEXION A LA BASE DE DATOS ORACLE.                                       */
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
/* PREPARACION DE AMBIENTE PARA ARCHIVOS DE LOG Y DATOS.                     */
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
    fprintf(pfLog, "VERSION                        : [%s]\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision                : [%s]\n", LAST_REVIEW);                
	fprintf(pfLog, "Base de datos                  : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE                 : [%s]\n",(char * )sysGetUserName() ); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    
    fprintf(pfLog, "Identificador de Ciclo 		   : [%s]\n", stArgs.szIdPeriodo);

    fprintf(pfLog, "Identificador de Proceso	   : [%s]\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque		   : [%s]\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion		   : [%d]\n", stArgs.izSecuencia);

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
    sqlstm.offset = (unsigned int  )400;
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
    fprintf(pfLog,  "Inicio procesamiento principal ...\n\n");
    fprintf(stderr, "Inicio procesamiento principal ...\n\n");
/*---------------------------------------------------------------------------*/
/* Carga Fechas que definen el Periodo                                       */
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
    fprintf(pfLog , "Gestiona Carga de Datos y Parametros...\n\n");  
    fprintf(stderr, "Gestiona Carga de Datos y Parametros...\n\n");  
	if (!bCargaConceptos())
	{
		fprintf(stderr,	"\nError Recuperando Lista de Conceptos	de comisiones.\n");
		fprintf(stderr,	"Revise	la parametrizacion.\n");
		fprintf(stderr,	"Proceso finalizado con	error.\n");
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"NO PUEDE	CARGAR LISTA DE	CONCEPTOS DE COMISION.",0,0));
	}    
/*---------------------------------------------------------------------------*/
/* LLENA ESTRUCTURA DE VALORACION                                            */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga estructura de valoracion de Prepagos ...\n\n");     
    fprintf(stderr, "Carga estructura de valoracion de Prepagos ...\n\n");     
    vLlenaTasador();
/*---------------------------------------------------------------------------*/
/* LLENA ESTRUCTURA DE VALORACION                                            */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga matrices de evaluacion de metas y volumenes...\n\n");     
    fprintf(stderr, "Carga matrices de evaluacion de metas y volumenes...\n\n");     
    vLlenaMatriz();
/*---------------------------------------------------------------------------*/
/* CARGA HABILITACIONES PREPAGO DEL PERIODO                                  */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga habilitaciones prepago del periodo...\n\n");     
    fprintf(stderr, "Carga habilitaciones prepago del periodo...\n\n");     
    vLlenaHabilitaciones();
/*---------------------------------------------------------------------------*/
/* EJECUTA VALORACION DE HABILITACIONES PREPAGO.                             */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Ejecuta valoracion de habilitaciones prepago...\n\n");     
    fprintf(stderr, "Ejecuta valoracion de habilitaciones prepago...\n\n");     
    vValoraHabilitaciones();
    vMuestraEstructura();
/*---------------------------------------------------------------------------*/
/* GUARDA RESULTADOS EN TABLA DE VALORIZADOS.                                */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Guarda resultados en tabla de valorizados...\n\n");     
    fprintf(stderr, "Guarda resultados en tabla de valorizados...\n\n");            
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA.                                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada....\n\n");     
    fprintf(stderr, "Libera memoria utilizada...\n\n");             
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
    fprintf(pfLog,	"Segundos Reales Utilizados	     : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(pfLog,	"Cantidad de Registros Valorizados : [%d]\n",stStatusProc.lCantRegistros);			       

    fprintf(stderr, "\nEstadistica del proceso\n");								 
    fprintf(stderr,	"------------------------\n");									 
    fprintf(stderr,	"Segundos Reales Utilizados	     : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(stderr,	"Cantidad de Registros Valorizados : [%d]\n",stStatusProc.lCantRegistros);		       
																	       
    if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"",stStatusProc.lSegProceso, stStatusProc.lCantRegistros))  
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));					
    
    /* EXEC SQL COMMIT	WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )415;
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

