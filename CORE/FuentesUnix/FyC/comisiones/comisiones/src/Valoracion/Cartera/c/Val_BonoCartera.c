
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
    "./pc/Val_BonoCartera.pc"
};


static unsigned int sqlctx = 443593315;


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

 static char *sq0002 = 
"select NUM_GENERAL ,COD_COMISIONISTA ,IMP_CARGOBASICO ,IMP_TRAFICO  from CMT\
_BONOSCARTERA where ((COD_TIPORED=:b0 and COD_TIPCOMIS=:b1) and ID_PERIODO=:b2\
) order by COD_COMISIONISTA            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,134,0,4,86,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
36,0,0,2,193,0,9,165,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
63,0,0,2,0,0,13,169,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,
94,0,0,2,0,0,15,194,0,0,0,0,0,1,0,
109,0,0,3,190,0,3,235,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,1,97,0,0,1,4,0,0,
160,0,0,4,48,0,1,456,0,0,0,0,0,1,0,
175,0,0,5,0,0,30,547,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa encargado de ejecutar la valoración del Bono Cartera             */
/*                                                                           */
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                  */
/* Inicio: Lunes 26 de Noviembre del 2001.                                   */
/* Fin:                                                                      */
/* Autor : Fabian Aedo Ramirez                                               */
/*---------------------------------------------------------------------------*/
/* Recibira entre sus parametros un COD_PERIODO, con el que cruzara las      */
/*  tablas de Valoracion (CMT_VALORIZADOS) y la de periodos, (CMD_PERIODOS), */
/*  para todos aquellos periodos cuyo indicador de periodo sea mensual.      */
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
/* Modificacion por PGonzaleg                                                */
/* Inicio: Lunes 2 de diciembre de 2002.                                     */
/* Fin:    Lunes 2 de diciembre de 2002.                                     */
/* Autor : Patricio Gonzalez Gomez                                           */
/* Modificacion de condiciones en los WHERE referentes a la tabla            */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y          */
/* COD_PARAMETRO.                                                            */
/*****************************************************************************/
/* Modificacion : Jaime Vargas MOrales                                       */
/* Inicio       : Viernes 24 de Enero de 2003                                */
/* Descripcion  : Generacion del nombre y creacion del archivo de log.       */
/* ************************************************************************* */ 
/*****************************************************************************/
/* Modificacion : Marcelo González Lizama                                    */
/* Inicio       : Miercoles 01 de Octubre de 2003                            */
/* Fin			:                                                            */
/* Descripcion  : Carga de datos a travez de estructura StConceptosProc      */
/*                Eliminacion y actualizacion de Querys para rescatar datos  */
/*                Cambio de Funcion vWriteLog por fprintf                    */
/* ************************************************************************* */ 

#include "Val_BonoCartera.h"
#include "GEN_biblioteca.h"
#include <geora.h>

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

stConceptosProc * lstConceptos = NULL;

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
/* Recupera %Residual para calculo de Bono por Cartera.                      */
/*---------------------------------------------------------------------------*/
void vCreaUniverso()
{
	stResumen	    * paux;
    stConceptosProc	* raux;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int 	ihCodTipoRed;
    	char	shCodTipComis[3];
    	char	shCodPlanComis[6];
    	int		ihCodConcepto;
    	int		ihValPorcen;
    	
    /* EXEC SQL END DECLARE SECTION; */ 


	for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
   	{
	   	ihCodTipoRed			= raux->iCodTipoRed;
        strcpy(shCodTipComis	, raux->szCodTipComis);
        strcpy(shCodPlanComis	, raux->szCodPlanComis);
        ihCodConcepto			= raux->iCodConcepto;
			        
        /* EXEC SQL 	SELECT VAL_PORCENTAJE into :ihValPorcen
			FROM  	CM_PORCENTAJE_BONOCARTERA_TD
			WHERE 	COD_TIPORED		= :ihCodTipoRed
			AND	  	COD_PLANCOMIS 	= :shCodPlanComis
			AND	  	COD_CONCEPTO  	= :ihCodConcepto; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select VAL_PORCENTAJE into :b0  from CM_PORCENTAJE_BO\
NOCARTERA_TD where ((COD_TIPORED=:b1 and COD_PLANCOMIS=:b2) and COD_CONCEPTO=:\
b3)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihValPorcen;
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
        sqlstm.sqhstv[2] = (unsigned char  *)shCodPlanComis;
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


                
        paux = (stResumen *) malloc(sizeof(stResumen));

        paux->iCodTipoRed           = ihCodTipoRed;
        strcpy(paux->szCodTipComis	, shCodTipComis);
        strcpy(paux->szCodPlanComis	, shCodPlanComis);
        paux->iCod_Concepto         = ihCodConcepto;
		paux->iVal_Porcentaje       = ihValPorcen;
		paux->lCantAbonados			= 0;
		paux->dTotFactura			= 0;
		paux->dImpComision			= 0;
		strcpy(paux->szCodUniverso	, raux->szCodUniverso);
		paux->sgte_dato				= NULL;
        paux->sgte                  = lstResumen;
        lstResumen					= paux;
    }
}

/*---------------------------------------------------------------------------*/
/* Se extrae el universo inicial de registros a considerar para Comisiones.  */
/*---------------------------------------------------------------------------*/
void vCargaBonosCartera()
{	
	long            lCantVentas=0;
    int             i;
    long            iLastRows    = 0;
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    int             iLastComis=0;
    stUniverso      * paux;
    stResumen       * raux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;

        char    szhIdPeriodo[11];
        long    lhCodPeriodo;
        int 	ihCod_Concepto;
        double  dhImpFacturas;
		int 	ihCodTipoRed;
		int 	ihVal_Porcentaje;
        long    lhNumGeneral[MAXFETCH];
        char    szhCodTipComis[3];
        int     ihCodComisionista[MAXFETCH];
        double  dhImpBasico[MAXFETCH];
        double  dhImpTrafico[MAXFETCH];
        long    lhCodCiclo;
        char	shCodPlanComis[6];
    
    /* EXEC SQL END DECLARE SECTION; */ 


    lMaxFetch	= MAXFETCH;
    paux 		= NULL;
	    
	for(raux=lstResumen; raux != NULL; raux = raux->sgte)
	{
	   	strcpy(szhCodTipComis	, raux->szCodTipComis);
		strcpy(szhIdPeriodo 	, stCiclo.szIdCiclComis);           
		ihCodTipoRed 			= raux->iCodTipoRed;
		lhCodPeriodo    		= stCiclo.lCodCiclComis;            
		lhCodCiclo  			= stCiclo.lCodCiclo;
		dhImpFacturas 			= 0;
		iLastComis    			= 0;
		        
		/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR
			SELECT  NUM_GENERAL,
					COD_COMISIONISTA,
			 		IMP_CARGOBASICO,
			        IMP_TRAFICO
		    FROM    CMT_BONOSCARTERA		            	
		    WHERE 	COD_TIPORED		= :ihCodTipoRed	
		    AND 	COD_TIPCOMIS	= :szhCodTipComis
		    AND 	ID_PERIODO  	= :szhIdPeriodo
		    ORDER BY COD_COMISIONISTA; */ 
		
	    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

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
	    	/* EXEC SQL for 	:lMaxFetch FETCH CUR_UNIVERSO INTO 
				:lhNumGeneral,:ihCodComisionista,:dhImpBasico,:dhImpTrafico; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )lMaxFetch;
      sqlstm.offset = (unsigned int  )63;
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
      sqlstm.sqhstv[1] = (unsigned char  *)ihCodComisionista;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[1] = (         int  )sizeof(int);
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqharc[1] = (unsigned long  *)0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)dhImpBasico;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[2] = (         int  )sizeof(double);
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqharc[2] = (unsigned long  *)0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)dhImpTrafico;
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



            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];

            for (i=0; i < iRetrievRows; i++)
            {
           	                    
        		paux = (stUniverso *) malloc(sizeof(stUniverso));
                        
                paux->lNumGeneral			 = lhNumGeneral[i];
                paux->ihCodComisionista		 = ihCodComisionista[i];
				dhImpFacturas 				 = dhImpBasico[i] + dhImpTrafico[i];
                paux->dImpFactura            = dhImpFacturas;
                paux->dImpComision           = (double)dhImpFacturas * (double)raux->iVal_Porcentaje / 100.00;
                
                raux->lCantAbonados++;
				raux->dTotFactura			+= dhImpFacturas;  
				raux->dImpComision			+= paux->dImpComision; 
				
                paux->sgte                   = raux->sgte_dato;
                raux->sgte_dato              = paux;
            }
        }  
		/* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )94;
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
/* RUTINA QUE INSERTA EL REGISTRO FINAL EN LA TABLA DE VALORIZADOS.          */
/*---------------------------------------------------------------------------*/
void vInsertaVaorizados()
{
       
    stResumen       * paux;
    stUniverso      * qaux;
    long			lCantRegistros = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumGeneral;
        char    szhCodUniverso[7];
        int     ihCodConcepto;
        char    szhCodTipComis[3];
        int     ihCodComisionista;
        long    lhCodPeriodo;
        char    szhIdPeriodo[11];
        double  dhImpConcepto;
        int 	iCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 
   
                
    lhCodPeriodo            = stCiclo.lCodCiclComis;        
    strcpy(szhIdPeriodo     , stCiclo.szIdCiclComis);       
    
	for (paux = lstResumen; paux != NULL; paux = paux->sgte)
    {
    	iCodTipoRed				= paux->iCodTipoRed;
		strcpy(szhCodTipComis   , paux->szCodTipComis);                        
		ihCodConcepto			= paux->iCod_Concepto;
    	strcpy(szhCodUniverso   , paux->szCodUniverso);

        for(qaux = paux->sgte_dato; qaux != NULL; qaux = qaux->sgte)
        {
            lhNumGeneral        	= qaux->lNumGeneral;
            ihCodComisionista   	= qaux->ihCodComisionista;
            dhImpConcepto       	= fnCnvDouble(qaux->dImpComision, 0);

            /* EXEC SQL INSERT INTO CMT_VALORIZADOS (
				COD_TIPORED, NUM_GENERAL, COD_CONCEPTO, COD_PERIODO,
				COD_UNIVERSO, COD_TIPCOMIS, COD_COMISIONISTA, ID_PERIODO, 
				IMP_CONCEPTO ) VALUES  (
				:iCodTipoRed, :lhNumGeneral, :ihCodConcepto, :lhCodPeriodo,
				:szhCodUniverso, :szhCodTipComis, :ihCodComisionista, :szhIdPeriodo,
				:dhImpConcepto); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 9;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into CMT_VALORIZADOS (COD_TIPORED,NUM_GENE\
RAL,COD_CONCEPTO,COD_PERIODO,COD_UNIVERSO,COD_TIPCOMIS,COD_COMISIONISTA,ID_PER\
IODO,IMP_CONCEPTO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )109;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&iCodTipoRed;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumGeneral;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhCodUniverso;
            sqlstm.sqhstl[4] = (unsigned long )7;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipComis;
            sqlstm.sqhstl[5] = (unsigned long )3;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)&ihCodComisionista;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhIdPeriodo;
            sqlstm.sqhstl[7] = (unsigned long )11;
            sqlstm.sqhsts[7] = (         int  )0;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)&dhImpConcepto;
            sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
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


			lCantRegistros++;
        }       
    }
    stStatusProc.lCantRegistros = lCantRegistros;
}
/*---------------------------------------------------------------------------*/
/* RUTINA QUE LISTA EL CONTENIDO DE LA ESTRUCTURA EN PANTALLA.               */
/*---------------------------------------------------------------------------*/
void vMuestraResumen()
{
    stResumen       * paux;

    char            szhCodTipComis[3];
    int             ihCodComisionista;
    long            lhCodPeriodo;
    double          dhImpConcepto;
    double          dhImpFacturas;
    long            lhCantRegistros;
    
    lhCodPeriodo            = stCiclo.lCodCiclComis;        

    fprintf(stderr,"\n\n PERIODO; CAT.VENTA; CANT. REGISTROS; SUM(FACTURAS); IMP. COMISION;\n");
    fprintf(stderr,"===============================================================================\n");
    
    fprintf(pfLog ,"\n\n PERIODO; CAT.VENTA; CANT. REGISTROS; SUM(FACTURAS); IMP. COMISION;\n");
    fprintf(pfLog ,"===============================================================================\n");
    for (paux = lstResumen; paux != NULL; paux = paux->sgte)
    {
        strcpy(szhCodTipComis   , paux->szCodTipComis);
        lhCantRegistros         = paux->lCantAbonados;
        dhImpFacturas           = paux->dTotFactura;
        dhImpConcepto           = paux->dImpComision;
        
        fprintf(stderr,"%d;%s;%d;%d;%.7f;%.7f\n",lhCodPeriodo,szhCodTipComis,lhCantRegistros,dhImpFacturas,dhImpConcepto);
        fprintf(pfLog ,"%d;%s;%d;%d;%.7f;%.7f\n",lhCodPeriodo,szhCodTipComis,lhCantRegistros,dhImpFacturas,dhImpConcepto);
    }
    fprintf(stderr,"===============================================================================\n");
    fprintf(pfLog ,"===============================================================================\n");
}

/*****************************************************************************/
/* Gestiona la carga de Conceptos y Parámetros de Valoración                 */
/*****************************************************************************/
int bCargaConceptos()
{
	switch (stCiclo.cTipCiclComis)
	{
		case PERIODICO:
		    vFechaHora();                                                                                   
		    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
		    fprintf(pfLog, "Carga lista de conceptos para ejecución Periodica o Normal..\n\n");  
		    fprintf(stderr, "Carga lista de conceptos para ejecución Periodica o Normal...\n\n");  
			lstConceptos = stGetConceptosPer(FORMACOMIS,stCiclo);
			return TRUE;
		case ESPORADICO:
		    vFechaHora();                                                                                   
		    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
		    fprintf(pfLog, "Carga lista de conceptos para ejecución Esporádica o Promocional..\n\n");  
		    fprintf(stderr, "Carga lista de conceptos para ejecución Esporádica o Promocional...\n\n");  
			lstConceptos = stGetConceptosProm(FORMACOMIS,stCiclo);
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
/* Liberar Memoria Usada para datos de valoracion.                           */
/*---------------------------------------------------------------------------*/
void vLiberaDatos(stUniverso * qaux)
{
	stUniverso * paux;
    if (qaux == NULL)
        return;

	paux = qaux->sgte;
	while(paux != NULL)
	{
        free(qaux);
		qaux = paux;
		paux = qaux->sgte;		
	}
	if (qaux != NULL)
        free(qaux);

}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Resumen.                                       */
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stResumen * paux)
{
    if (paux == NULL)
        return;
    vLiberaUniverso(paux->sgte);
    vLiberaDatos(paux->sgte_dato);
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
            exit(EXIT_200);
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
    fprintf(stderr, "Preparando ambiente para archivos de log y de configuracion ...\n");
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
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )160;
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
/* Carga Estructura de Conceptos y Tipos de Red a Procesar...               */
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
	
/*----------------------------------------------------------------*/
/*    - Crea una lista de Porcentajes asociados a los conceptos.  */
/*----------------------------------------------------------------*/	
	vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Ejecuta la valoración de los eventos...\n\n");
    fprintf(stderr, "Ejecuta la valoración de los eventos...\n\n");
    vCreaUniverso();
        
/*---------------------------------------------------------------------------*/
/*    - Crea una lista de universos con la acumulación previa de conceptos.  */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Ejecuta la valoración de los eventos...\n\n");
    fprintf(stderr, "Ejecuta la valoración de los eventos...\n\n");
    vCargaBonosCartera();
/*---------------------------------------------------------------------------*/
/*    - Inserta los registros valorizados en la tabla CMT_VALORIZADOS.       */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inserta los registros valorizados en la tabla CMT_VALORIZADOS....\n\n");
    vInsertaVaorizados();
/*---------------------------------------------------------------------------*/
/*    - Muestra resumen de valorización en pantalla.                         */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Muestra resumen de valorización en pantalla...\n\n");
    vMuestraResumen();
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de abonados y universsos.        */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada por listas de abonados y universsos...\n\n");
    fprintf(stderr, "Libera memoria utilizada por listas de abonados y universsos...\n\n");
    vLiberaUniverso(lstResumen);
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
    fprintf(pfLog, "Segundos reales utilizados             : [%d]\n", stStatusProc.lSegProceso);
    fprintf(pfLog, "Registros liedos desde Cartera         : [%d]\n", stStatusProc.lCantRegistros);

    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantRegistros);
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
    sqlstm.offset = (unsigned int  )175;
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

