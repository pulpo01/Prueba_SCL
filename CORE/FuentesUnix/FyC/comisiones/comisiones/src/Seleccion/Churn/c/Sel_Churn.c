
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
    "./pc/Sel_Churn.pc"
};


static unsigned int sqlctx = 6928971;


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
   unsigned char  *sqhstv[11];
   unsigned long  sqhstl[11];
            int   sqhsts[11];
            short *sqindv[11];
            int   sqinds[11];
   unsigned long  sqharm[11];
   unsigned long  *sqharc[11];
   unsigned short  sqadto[11];
   unsigned short  sqtdso[11];
} sqlstm = {12,11};

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
"select distinct C.COD_VENDEDOR  from VE_REDVENTAS_TD C ,VE_VENDEDORES B wher\
e ((C.COD_TIPORED=:b0 and C.COD_VENDEDOR=B.COD_VENDEDOR) and B.COD_TIPCOMIS=:b\
1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,167,0,9,137,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
28,0,0,1,0,0,13,141,0,0,1,0,0,1,0,2,3,0,0,
47,0,0,1,0,0,15,162,0,0,0,0,0,1,0,
62,0,0,2,155,0,4,188,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
97,0,0,3,155,0,4,196,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
132,0,0,4,54,0,4,267,0,0,1,0,0,1,0,2,3,0,0,
151,0,0,5,225,0,3,270,0,0,11,11,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
210,0,0,6,48,0,1,405,0,0,0,0,0,1,0,
225,0,0,7,0,0,30,454,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar y calcular el Churn para cada      */
/* comisionista.                                                        */ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Viernes 13 de Diciembre de 2002.                             */
/* Fin:                                                                 */
/* Autor : Patricio Gonzalez Gomez.                                     */
/************************************************************************/
/* 20030923 Marcelo Quiroz G. Versionado Cuzco.                         */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorpora manejo de lista general de tipos de comisionistas.      */
/* Se reestructura proceso en funcion de estructura de tipos de         */
/* comisionistas.                                                       */
/*                                                                      */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Sel_Churn.h"
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
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
	long    lhCodCiclComis;       
    char    szhIdCiclComis[11]; 
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Lista de Tipos de Comisionistas para ejecucion de ciclo                   */
/*---------------------------------------------------------------------------*/
	stTiposComis * lstTiposComis = NULL;
/*---------------------------------------------------------------------------*/
/* Carga la estructura de tipos de comisionistas que serán procesados.       */
/* en funcion del tipo de ciclo en proceso, se ejecuta librería de carga de  */
/* tipos de comisionista a procesar.                                         */
/*---------------------------------------------------------------------------*/
void vCargaTiposComis()
{
    stTiposComis * paux;
    
    lstUniverso = NULL;
    switch(szTipoPeriodo)
    {
    	case PERIODICO:
    			fprintf(stderr,"\n(vCargaTiposComis) EJECUCION EN MODO PERIODICO.\n");
    			fprintf(pfLog ,"\n(vCargaTiposComis) EJECUCION EN MODO PERIODICO.\n");
    			lstTiposComis = stGetTipComisSelecPer(UNIVERSO, stCiclo);
				break;
    	case ESPORADICO:
    			fprintf(stderr,"\n(vCargaTiposComis) EJECUCION EN MODO ESPORADICO.\n");
    			fprintf(pfLog ,"\n(vCargaTiposComis) EJECUCION EN MODO ESPORADICO.\n");
    			lstTiposComis = stGetTipComisSelecProm(UNIVERSO, stCiclo);
    			break;
    }
	if (lstTiposComis==NULL)
		fprintf(pfLog, "\n[vCargaTiposComis] No existen Tipos de Comisionistas para procesar.");
	else
	{
		for (paux=lstTiposComis;paux != NULL; paux=paux->sgte)
        {
			fprintf(pfLog ,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s].\n",paux->szCodTipComis,paux->szDesTipComis);
			fprintf(stderr,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s].\n",paux->szCodTipComis,paux->szDesTipComis);
            vSeleccionarUniverso(paux->iCodTipoRed, paux->szCodTipComis, paux->szCodTipVendedor);
		}
/*---------------------------------------------------------------------------*/        
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCalculaChurn) Calculo de Churn\n");
		fprintf(stderr,"\n(vCalculaChurn) Calculo de Churn\n");
	    vCalculaChurn();
/*---------------------------------------------------------------------------*/        
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vMuestraEstructura) Muestra Estructura\n");
		fprintf(stderr,"\n(vMuestraEstructura) Muestra Estructura\n");
	    vMuestraEstructura();
/*---------------------------------------------------------------------------*/        
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vInsertaEvaluaChurn) Evalua e Inserta Churn\n");
		fprintf(stderr,"\n(vInsertaEvaluaChurn) Evalua e Inserta Churn\n");
	    vInsertaEvaluaChurn();
/*---------------------------------------------------------------------------*/
		vFechaHora();
	    fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Libera la memoria utilizada.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Libera la memoria utilizada.\n");
		vLiberaUniverso(lstUniverso);
		vLiberaTiposComis(lstTiposComis);
	}    
}	
/* -------------------------------------------------------------------------------------- */
/* Se extrae el universo DIRECTO inicial de registros a considerar para Comisiones.       */
/* -------------------------------------------------------------------------------------- */
void vSeleccionarUniverso(int piCodTipoRed, char * pszCodTipComis, char * pszCodTipVendedor)
{
	stUniverso 	* paux;
    long       	iCantidad = 0;
    int         i;      
    short       iLastRows    = 0;       
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
                
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
         
         long    lMaxFetch;              
         char    szhCodTipComis[3];
         long    lhCodComisionista[MAXFETCH];
	 	 char	 szhCodTipVendedor[3];
	 	 int	 ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhCodTipComis   , pszCodTipComis);
    strcpy(szhCodTipVendedor, pszCodTipVendedor);
    ihCodTipoRed			= piCodTipoRed;    
    lMaxFetch               = MAXFETCH;

    /* EXEC SQL DECLARE cur_universo CURSOR FOR
         SELECT  DISTINCT 
		 		C.COD_VENDEDOR
         FROM   VE_REDVENTAS_TD    C, 
				VE_VENDEDORES      B
         WHERE	C.COD_TIPORED  = :ihCodTipoRed 
		 AND    C.COD_VENDEDOR = B.COD_VENDEDOR
         AND	B.COD_TIPCOMIS = :szhCodTipComis; */ 

        
    /* EXEC SQL OPEN cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
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
          /* EXEC SQL for :lMaxFetch FETCH cur_universo INTO :lhCodComisionista; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 2;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )lMaxFetch;
          sqlstm.offset = (unsigned int  )28;
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
              paux = (stUniverso *) malloc(sizeof(stUniverso));
              
              paux->iCodTipoRed     	    = ihCodTipoRed;
			  strcpy(paux->szCodTipComis    , szhCodTipComis);  
			  strcpy(paux->szCodTipVendedor , szhCodTipVendedor);            
              paux->lNumGeneral             = 0;
              paux->lCodComisionista        = lhCodComisionista[i];
              paux->dChurn                  = 0.00;
                        
              paux->sgte                    = lstUniverso;
              lstUniverso                   = paux;
              iCantidad++;
          }
    }
    /* EXEC SQL CLOSE cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )47;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog, "\n [vSeleccionarUniverso] Cantidad de Registros :[%ld].\n", iCantidad);
        
}
/* -------------------------------------------------------------------------------------- */
/* Calculo de CHURN                                                                       */
/* -------------------------------------------------------------------------------------- */
void vCalculaChurn ()
{      
    stUniverso  * paux; 	 
    double      dPaso;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhCodTipComis[3];
         long    lhCantAltas;
         long    lhCodComisionista;
         long    lhCantBajas;
         char	 szhCodTipVendedor[3];     
    /* EXEC SQL END DECLARE SECTION; */ 


    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)  
    {         
       strcpy(szhCodTipComis   , paux->szCodTipComis);                
       lhCodComisionista       = paux->lCodComisionista;
       strcpy(szhCodTipVendedor, paux->szCodTipVendedor);
       
       /* EXEC SQL SELECT COUNT(NUM_GENERAL) 
       INTO  :lhCantAltas
       FROM  CMT_HABIL_CELULAR 
       WHERE COD_COMISIONISTA 	= :lhCodComisionista
       AND   COD_TIPCOMIS     	= :szhCodTipComis
       AND   COD_TIPVENDEDOR	= :szhCodTipVendedor
       AND   ID_PERIODO       	= :szhIdCiclComis; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 5;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select count(NUM_GENERAL) into :b0  from CMT_HABIL_CEL\
ULAR where (((COD_COMISIONISTA=:b1 and COD_TIPCOMIS=:b2) and COD_TIPVENDEDOR=:\
b3) and ID_PERIODO=:b4)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )62;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhCantAltas;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&lhCodComisionista;
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
       sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipVendedor;
       sqlstm.sqhstl[3] = (unsigned long )3;
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szhIdCiclComis;
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


                        
       /* EXEC SQL SELECT COUNT(NUM_GENERAL)
       INTO  :lhCantBajas
       FROM  CMT_BAJAS_CELULAR
       WHERE COD_COMISIONISTA 	= :lhCodComisionista
       AND   COD_TIPCOMIS     	= :szhCodTipComis
       AND   COD_TIPVENDEDOR	= :szhCodTipVendedor
       AND   ID_PERIODO       	= :szhIdCiclComis; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 5;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select count(NUM_GENERAL) into :b0  from CMT_BAJAS_CEL\
ULAR where (((COD_COMISIONISTA=:b1 and COD_TIPCOMIS=:b2) and COD_TIPVENDEDOR=:\
b3) and ID_PERIODO=:b4)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )97;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhCantBajas;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&lhCodComisionista;
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
       sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipVendedor;
       sqlstm.sqhstl[3] = (unsigned long )3;
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szhIdCiclComis;
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


                        
       dPaso = ((double)lhCantAltas - (double)lhCantBajas) / 2;
                
       if (lhCantBajas == 0 || dPaso == 0)
       {
           paux->lCantAltas = lhCantAltas;
           paux->lCantBajas = lhCantBajas;
           paux->dChurn     = 0 ;               
       }
       else                               
       {
           paux->lCantAltas = lhCantAltas;
           paux->lCantBajas = lhCantBajas;
           paux->dChurn     = (double)(lhCantBajas) / dPaso;
       }                       
    }                
}

/* -------------------------------------------------------------------------------------- */
/* Muestra Estructura                                                                     */
/* -------------------------------------------------------------------------------------- */
void vMuestraEstructura()
{
    stUniverso  * paux; 	 
        
    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)  
    {
        fprintf (pfLog, "-----Principal-----------------------------------\n");
        fprintf (pfLog, "paux->szCodTipComis      [%s] \n",  paux->szCodTipComis );
        fprintf (pfLog, "paux->lCodComisionista   [%ld]\n",  paux->lCodComisionista ); 
        fprintf (pfLog, "paux->szCodTipVendedor   [%s]\n",   paux->szCodTipVendedor); 
        fprintf (pfLog, "paux->dChurn             [%5.3f]\n",paux->dChurn);
    }
}

/* -------------------------------------------------------------------------------------- */
/* Evalua e Inserta Churn                                                                 */
/* -------------------------------------------------------------------------------------- */
void vInsertaEvaluaChurn ()
{
    stUniverso  * paux   ; 	 
    long        lCantidad;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhCodTipComis[3];
         long    lhCodComisionista;
         long    lhNumAltas;
         long    lhNumBajas;
         double  dhNumChurn;
         long    lhNumSecuencia;
	 	 char	 szhCodTipVendedor[3];
	 	 int	 ihCodTipoRed;         
    /* EXEC SQL END DECLARE SECTION; */ 
        
        
    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)  
    {
       strcpy(szhCodTipComis   , paux->szCodTipComis);             
       lhCodComisionista       = paux->lCodComisionista;
       lhNumAltas              = paux->lCantAltas;      
       lhNumBajas              = paux->lCantBajas;      
       dhNumChurn              = paux->dChurn;
       ihCodTipoRed            = paux->iCodTipoRed;
	   strcpy(szhCodTipVendedor, paux->szCodTipVendedor);            
                 
       /* EXEC SQL SELECT CMS_REG_SELECCION.NEXTVAL INTO :lhNumSecuencia FROM DUAL; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 5;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b0  from DUAL ";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )132;
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


       lCantidad++;
                                                
       /* EXEC SQL INSERT INTO CM_EVALUA_CHURN_TO (
              NUM_GENERAL    , COD_TIPCOMIS , COD_COMISIONISTA, 
              COD_CICLCOMIS  , ID_CICLCOMIS , NUM_ALTAS       , 
              NUM_BAJAS      , NUM_CHURN    , COD_TIPORED     , 
              COD_TIPVENDEDOR, COD_VENDEDOR) 
       VALUES (
              :lhNumSecuencia   , :szhCodTipComis, :lhCodComisionista, 
              :lhCodCiclComis   , :szhIdCiclComis, :lhNumAltas       , 
              :lhNumBajas       , :dhNumChurn    , :ihCodTipoRed     ,
              :szhCodTipVendedor, :lhCodComisionista); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "insert into CM_EVALUA_CHURN_TO (NUM_GENERAL,COD_TIPCOM\
IS,COD_COMISIONISTA,COD_CICLCOMIS,ID_CICLCOMIS,NUM_ALTAS,NUM_BAJAS,NUM_CHURN,C\
OD_TIPORED,COD_TIPVENDEDOR,COD_VENDEDOR) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:\
b7,:b8,:b9,:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )151;
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
       sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclComis;
       sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szhIdCiclComis;
       sqlstm.sqhstl[4] = (unsigned long )11;
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAltas;
       sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[5] = (         int  )0;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)&lhNumBajas;
       sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[6] = (         int  )0;
       sqlstm.sqindv[6] = (         short *)0;
       sqlstm.sqinds[6] = (         int  )0;
       sqlstm.sqharm[6] = (unsigned long )0;
       sqlstm.sqadto[6] = (unsigned short )0;
       sqlstm.sqtdso[6] = (unsigned short )0;
       sqlstm.sqhstv[7] = (unsigned char  *)&dhNumChurn;
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
       sqlstm.sqhstv[9] = (unsigned char  *)szhCodTipVendedor;
       sqlstm.sqhstl[9] = (unsigned long )3;
       sqlstm.sqhsts[9] = (         int  )0;
       sqlstm.sqindv[9] = (         short *)0;
       sqlstm.sqinds[9] = (         int  )0;
       sqlstm.sqharm[9] = (unsigned long )0;
       sqlstm.sqadto[9] = (unsigned short )0;
       sqlstm.sqtdso[9] = (unsigned short )0;
       sqlstm.sqhstv[10] = (unsigned char  *)&lhCodComisionista;
       sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
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

   
    }
    stStatusProc.lCantRegistros = lCantidad;
    fprintf(stderr,"\n[vInsertaSeleccion] Cantidad de Registros Insertados:[%d].\n",lCantidad);
    fprintf(pfLog ,"\n[vInsertaSeleccion] Cantidad de Registros Insertados:[%d].\n",lCantidad);
}

/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por las listas de abonados.      */
/*****************************************************************************/
void vLiberaUniverso(stUniverso * paux)
{
        if (paux == NULL)
                return;
        vLiberaUniverso(paux->sgte);
        free(paux);
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{        
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
	long  lSegIni, lSegFin;         
	short ibiblio;                  
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
/* Inicializacion estructura de Bloque(proceso).                             */
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

/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )210;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

      
/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA CICLOS DE PROCESO                                        */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de ciclo de proceso...\n\n");       
    fprintf(stderr, "Carga estructura de ciclo de proceso...\n\n");       
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	exit(EXIT_101);
    }
    szTipoPeriodo         = stCiclo.cTipCiclComis;
    lhCodCiclComis 	      = stCiclo.lCodCiclComis;
	strcpy(szhIdCiclComis , stCiclo.szIdCiclComis);
/*---------------------------------------------------------------------------*/
/* CARGA TIPOS DE COMISIONISTAS                                              */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga tipos de comisionistas a procesar...\n\n");       
    fprintf(stderr, "Carga tipos de comisionistas a procesar...\n\n");       
	vCargaTiposComis();
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();                         
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
	fprintf(pfLog, "Estadistica del proceso\n");
	fprintf(pfLog, "------------------------\n");
	fprintf(pfLog, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);
	fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

/*---------------------------------------------------------------------------*/
	ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantRegistros);
	if (ibiblio)
	        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )225;
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

