
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
    "./pc/Val_ConvenioPAC.pc"
};


static unsigned int sqlctx = 443611651;


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
"select NUM_GENERAL ,COD_COMISIONISTA ,TO_CHAR(FEC_CONVENIO,'DD-MM-YYYY')  fr\
om CM_CONVENIOS_TO where (((COD_TIPORED=:b0 and ID_PERIODO=:b1) and COD_TIPCOM\
IS=:b2) and FEC_CONVENIO between TO_DATE(:b3,'DD-MM-YYYY') and TO_DATE(:b4,'DD\
-MM-YYYY'))           ";

 static char *sq0002 = 
"select NUM_GENERAL ,COD_COMISIONISTA ,TO_CHAR(FEC_VENTA,'DD-MM-YYYY')  from \
CMT_HABIL_CELULAR where ((((COD_TIPORED=:b0 and ID_PERIODO=:b1) and COD_TIPCOM\
IS=:b2) and FEC_VENTA between TO_DATE(:b3,'DD-MM-YYYY') and TO_DATE(:b4,'DD-MM\
-YYYY')) and IND_CONVENIO=1)           ";

 static char *sq0003 = 
"select IND_ORGENCONVENIO ,IMP_COMISION  from CM_VALOR_CONVENIO_TD where ((CO\
D_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,254,0,9,104,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
40,0,0,1,0,0,13,110,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,
67,0,0,1,0,0,15,134,0,0,0,0,0,1,0,
82,0,0,2,271,0,9,202,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
117,0,0,2,0,0,13,208,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,
144,0,0,2,0,0,15,233,0,0,0,0,0,1,0,
159,0,0,3,145,0,9,297,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
186,0,0,3,0,0,13,301,0,0,2,0,0,1,0,2,97,0,0,2,4,0,0,
209,0,0,3,0,0,15,330,0,0,0,0,0,1,0,
224,0,0,4,190,0,3,401,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
275,0,0,5,0,0,29,426,0,0,0,0,0,1,0,
290,0,0,6,48,0,1,601,0,0,0,0,0,1,0,
305,0,0,7,0,0,30,687,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las habilitaciones segun la          */
/* existencia de convenio PAC                                           */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Miercoles 11 de Diciembre del 2002.                          */
/* Fin:                                                                 */
/* Autor : Patricio Gonzalez Gomez.                                     */
/************************************************************************/
/* Modificacion : Jaime Vargas Morales                                  */
/* Inicio       : Viernes 24 de Enero de 2003                           */
/* Descripcion  : Generacion del nombre y creacion del archivo de log.  */
/************************************************************************/
/* Modificacion : Marcelo González Lizama                               */
/* Inicio       : Martes 07 de Octubre de 2003                          */
/* Fin			:                                                       */
/* Descripcion  : Carga de datos a travez de estructura StConceptosProc */
/*                Eliminacion y actualizacion de Querys para rescatar   */
/*                datos  												*/
/*                Cambio de Funcion vWriteLog por fprintf               */
/* **********************************************************************/ 

/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Val_ConvenioPAC.h"
#include "GEN_biblioteca.h"


/*---------------------------------------------------------------------------*/
/* Declaración e inicialización de lista de conceptos a procesar.            */
/*---------------------------------------------------------------------------*/
stConceptosProc * lstConceptos = NULL;

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
/* PROCEDIMIENTO QUE CARGA LAS HABILITACIONES DE CONVENIO EN UNA LISTA       */
/*---------------------------------------------------------------------------*/
stEventos * bfnLlenaConvenios(stPrincipal * qaux) 
{
        stEventos * pEvento;
        stEventos * paux;
        
        short           iLastRows    = 0;       
        int             iFetchedRows = MAXFETCH;
        int             iRetrievRows = MAXFETCH;
        int             i;
        
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                
                long    lhNum_General           [MAXFETCH];
                long    lhCod_Comisionista      [MAXFETCH];                                               
                char    szhFec_Venta            [MAXFETCH][11];
                char    szhFecDesde             [11];    
                char    szhFecHasta             [11];    
                char    szhCod_TipComis         [3];                                               
                int		ihCodTipoRed;
                char	szhCodPlanComis			[6];
                int		ihCodConcepto;
                char    szhIdCiclComis			[11];
                long    lhCod_Periodo;
                long    lMaxFetch;
                
        /* EXEC SQL END DECLARE SECTION; */ 

        
        strcpy(szhFecDesde    	, qaux->szFec_Desde);
        strcpy(szhFecHasta    	, qaux->szFec_Hasta);
        strcpy(szhCod_TipComis	, qaux->szCodTipComis);
        ihCodTipoRed			= qaux->iCodTipoRed;
        strcpy(szhCodPlanComis	, qaux->szCodPlanComis);
        ihCodConcepto			= qaux->iCodConcepto;
        
        lhCod_Periodo = stCiclo.lCodCiclComis;
        strcpy(szhIdCiclComis, stCiclo.szIdCiclComis);
        
        paux = NULL;
                
        /* EXEC SQL DECLARE Cur_HabilConv CURSOR FOR
                SELECT 	NUM_GENERAL, 
                        COD_COMISIONISTA, 
                        TO_CHAR(FEC_CONVENIO,'DD-MM-YYYY')
                FROM 	CM_CONVENIOS_TO
                WHERE 	COD_TIPORED 	= :ihCodTipoRed
                AND 	ID_PERIODO 		= :szhIdCiclComis
                AND 	COD_TIPCOMIS  	= :szhCod_TipComis
                AND 	FEC_CONVENIO BETWEEN TO_DATE(:szhFecDesde, 'DD-MM-YYYY') 
                						AND  TO_DATE(:szhFecHasta, 'DD-MM-YYYY'); */ 

        
        /* EXEC SQL OPEN Cur_HabilConv; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhIdCiclComis;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCod_TipComis;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecHasta;
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


        
        lMaxFetch = MAXFETCH;
        
        while(iFetchedRows == iRetrievRows)
        {
                /* EXEC SQL for :lMaxFetch 
                        FETCH   Cur_HabilConv 
                        INTO    :lhNum_General          ,
                                :lhCod_Comisionista     ,
                                :szhFec_Venta           ; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )lMaxFetch;
                sqlstm.offset = (unsigned int  )40;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqfoff = (         int )0;
                sqlstm.sqfmod = (unsigned int )2;
                sqlstm.sqhstv[0] = (unsigned char  *)lhNum_General;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )sizeof(long);
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqharc[0] = (unsigned long  *)0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)lhCod_Comisionista;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )sizeof(long);
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqharc[1] = (unsigned long  *)0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhFec_Venta;
                sqlstm.sqhstl[2] = (unsigned long )11;
                sqlstm.sqhsts[2] = (         int  )11;
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
                        pEvento = (stEventos *) malloc(sizeof(stEventos));
                        
                        pEvento->lNum_General      		= 	lhNum_General[i];
                        pEvento->lCod_Comisionista  	= 	lhCod_Comisionista[i];
                        strcpy(pEvento->szFec_Venta 	, 	szfnTrim(szhFec_Venta[i]));           
                        
                        pEvento->sgte               = paux;                 
                        paux                        = pEvento;                      
                } 
        
        } 
        
        /* EXEC SQL CLOSE Cur_HabilConv; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )67;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


        
        return (paux);
} 


/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LAS HABILITACIONES DE CONVENIO EN UNA LISTA       */
/*---------------------------------------------------------------------------*/
stEventos * bfnLlenaHabilVentas(stPrincipal * qaux)
{
        
        
        stEventos * pEvento;
        stEventos * paux;
        
        short           iLastRows    = 0;       
        int             iFetchedRows = MAXFETCH;
        int             iRetrievRows = MAXFETCH;
        int             i;
        char            Query[1024];
        char            Query2[1024];
        
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                
                long    lhNum_General           [MAXFETCH];
                long    lhCod_Comisionista      [MAXFETCH];                                               
                char    szhFec_Venta            [MAXFETCH][11];
                
                char    szhFecDesde             [11];    
                char    szhFecHasta             [11];    
                char    szhCod_TipComis         [3];          
                int		ihCodTipoRed;
                char	szhCodPlanComis			[6];
                char    szhIdCiclComis			[11];                        
                int		ihCodConcepto;                                     
                                                               
                long    lhCod_Periodo;
                long    lMaxFetch;
                
        /* EXEC SQL END DECLARE SECTION; */ 

        
		strcpy(szhFecDesde    	, qaux->szFec_Desde);
        strcpy(szhFecHasta    	, qaux->szFec_Hasta);
        strcpy(szhCod_TipComis	, qaux->szCodTipComis);
        ihCodTipoRed			= qaux->iCodTipoRed;
        strcpy(szhCodPlanComis	, qaux->szCodPlanComis);
        ihCodConcepto			= qaux->iCodConcepto;
        
        lhCod_Periodo 			= stCiclo.lCodCiclComis;
        strcpy(szhIdCiclComis	, stCiclo.szIdCiclComis);

        paux = NULL;
                
        /* EXEC SQL DECLARE Cur_HabilVtas CURSOR FOR
                SELECT 
                	NUM_GENERAL, 
                	COD_COMISIONISTA, 
                	TO_CHAR(FEC_VENTA,'DD-MM-YYYY')
                FROM 
                	CMT_HABIL_CELULAR
                WHERE COD_TIPORED 	= :ihCodTipoRed
                AND	ID_PERIODO 		= :szhIdCiclComis
                AND COD_TIPCOMIS 	= :szhCod_TipComis
                AND FEC_VENTA BETWEEN TO_DATE(:szhFecDesde , 'DD-MM-YYYY') 
								AND   TO_DATE(:szhFecHasta, 'DD-MM-YYYY')
                AND IND_CONVENIO = 1; */ 

        
        /* EXEC SQL OPEN Cur_HabilVtas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )82;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhIdCiclComis;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCod_TipComis;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecHasta;
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


        
        lMaxFetch = MAXFETCH;
        
        while(iFetchedRows == iRetrievRows)
        {
                /* EXEC SQL for :lMaxFetch 
                        FETCH Cur_HabilVtas 
                        INTO    :lhNum_General          ,
                                :lhCod_Comisionista     ,
                                :szhFec_Venta           ; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )lMaxFetch;
                sqlstm.offset = (unsigned int  )117;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqfoff = (         int )0;
                sqlstm.sqfmod = (unsigned int )2;
                sqlstm.sqhstv[0] = (unsigned char  *)lhNum_General;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )sizeof(long);
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqharc[0] = (unsigned long  *)0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)lhCod_Comisionista;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )sizeof(long);
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqharc[1] = (unsigned long  *)0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhFec_Venta;
                sqlstm.sqhstl[2] = (unsigned long )11;
                sqlstm.sqhsts[2] = (         int  )11;
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
                        
                        pEvento = (stEventos *) malloc(sizeof(stEventos));
                        
                        pEvento->lNum_General      		= lhNum_General[i];
                        pEvento->lCod_Comisionista  	= lhCod_Comisionista[i];
                        strcpy(pEvento->szFec_Venta 	, szfnTrim(szhFec_Venta[i]));           
                        
                        pEvento->sgte               = paux;                 
                        paux                        = pEvento;  
                        
                } 
        
        }  
        
        /* EXEC SQL CLOSE Cur_HabilVtas; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )144;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}



        return (paux);
} 


/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA PRINCIPAL (TASADOR) PARA LUEGO            */
/* PODER VALORAR LAS HABILITACIONES DE CMD_HABIL_CELULAR                     */
/*---------------------------------------------------------------------------*/
void vLlenaTasador ()
{       
        stPrincipal     * pPrincipal;
        stConceptosProc	* raux;
        int             i;      
        short           iLastRows    = 0;       
        int             iFetchedRows = MAXFETCH;
        int             iRetrievRows = MAXFETCH;
        
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szhFec_Inicio [11];
                char    szhFec_Termino[11];
                long    lMaxFetch;              
                int		ihCodTipoRed;
                int     ihCodConcepto;
                char    szhCodTipComis          [3];
                char 	shCodPlanComis			[6];
                char    szhOrigenConv           [MAXFETCH][2];
                double  dhImp_Comision          [MAXFETCH];
                char    szhFec_Desde            [11];
                char    szhFec_Hasta            [11];
                long    lhCodCiclo;
        /* EXEC SQL END DECLARE SECTION; */ 

        
        lstPrincipal = NULL;
                        
        strcpy(szhFec_Inicio , stCiclo.szFecDesdeAceptacion);
        strcpy(szhFec_Termino, stCiclo.szFecHastaAceptacion);
                
        lhCodCiclo  = stCiclo.lCodCiclo;
        
        lMaxFetch = MAXFETCH;
        
        for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
	   {
	   	
	   		ihCodTipoRed		=	raux->iCodTipoRed;
	   		strcpy(szhCodTipComis, raux->szCodTipComis);	      
	   		strcpy(shCodPlanComis, raux->szCodPlanComis);	 
	   		ihCodConcepto		=	raux->iCodConcepto;
	   		strcpy(szhFec_Desde,	raux->szFecDesde);
	   		strcpy(szhFec_Hasta,	raux->szFecHasta);
	         
	        /* EXEC SQL DECLARE Cur_Tasador CURSOR FOR
	                SELECT 	
	                		IND_ORGENCONVENIO, 
                			IMP_COMISION				                		
	                FROM 
	                		CM_VALOR_CONVENIO_TD
	                WHERE 
	                		COD_TIPORED		= :ihCodTipoRed
	                AND		COD_PLANCOMIS 	= :shCodPlanComis
	                AND		COD_CONCEPTO	= :ihCodConcepto; */ 

	
	        /* EXEC SQL OPEN Cur_Tasador; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 5;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = sq0003;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )159;
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
         sqlstm.sqhstv[1] = (unsigned char  *)shCodPlanComis;
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
	                        FETCH Cur_Tasador INTO
	                                :szhOrigenConv  ,
	                                :dhImp_Comision ; */ 

{
                 struct sqlexd sqlstm;
                 sqlstm.sqlvsn = 12;
                 sqlstm.arrsiz = 5;
                 sqlstm.sqladtp = &sqladt;
                 sqlstm.sqltdsp = &sqltds;
                 sqlstm.iters = (unsigned int  )lMaxFetch;
                 sqlstm.offset = (unsigned int  )186;
                 sqlstm.selerr = (unsigned short)1;
                 sqlstm.cud = sqlcud0;
                 sqlstm.sqlest = (unsigned char  *)&sqlca;
                 sqlstm.sqlety = (unsigned short)256;
                 sqlstm.occurs = (unsigned int  )0;
                 sqlstm.sqfoff = (         int )0;
                 sqlstm.sqfmod = (unsigned int )2;
                 sqlstm.sqhstv[0] = (unsigned char  *)szhOrigenConv;
                 sqlstm.sqhstl[0] = (unsigned long )2;
                 sqlstm.sqhsts[0] = (         int  )2;
                 sqlstm.sqindv[0] = (         short *)0;
                 sqlstm.sqinds[0] = (         int  )0;
                 sqlstm.sqharm[0] = (unsigned long )0;
                 sqlstm.sqharc[0] = (unsigned long  *)0;
                 sqlstm.sqadto[0] = (unsigned short )0;
                 sqlstm.sqtdso[0] = (unsigned short )0;
                 sqlstm.sqhstv[1] = (unsigned char  *)dhImp_Comision;
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
	                iLastRows = sqlca.sqlerrd[2];
	                
	                
	                for (i=0; i < iRetrievRows; i++)
	                {
	                        pPrincipal = (stPrincipal *) malloc(sizeof(stPrincipal)); 
	                        
	                        pPrincipal->iCodConcepto        = ihCodConcepto;
	                        pPrincipal->dImpComision        = dhImp_Comision[i];
	                        
	                        strcpy(pPrincipal->szCodTipComis        , szfnTrim(szhCodTipComis));	                        												   
	                        strcpy(pPrincipal->szOrigenConvenio     , szfnTrim(szhOrigenConv[i]));
	                        strcpy(pPrincipal->szFec_Desde          , szfnTrim(szhFec_Desde));
	                        strcpy(pPrincipal->szFec_Hasta          , szfnTrim(szhFec_Hasta));
	                        
	                        pPrincipal->sgte                = lstPrincipal;                 
	                        lstPrincipal                    = pPrincipal;
	                        pPrincipal->sgte_evento         = NULL;
	
	                } 
	        } 
        
        /* EXEC SQL CLOSE Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )209;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


     } 
} 


/*************************************************************************************/
/***********Se realiza recorrido del tasador para cargar eventos**********************/
/*************************************************************************************/
void vCargaEventos()
{
        stPrincipal     * pPrincipal;
        
        for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)      
        {
	        fprintf(stderr,"\npPrincipal->szOrigenConvenio:[%s]\n",pPrincipal->szOrigenConvenio);
	        if (strcmp(pPrincipal->szOrigenConvenio, "C") == 0)
	                pPrincipal->sgte_evento = bfnLlenaConvenios(lstPrincipal);
	        
	        if (strcmp(pPrincipal->szOrigenConvenio, "V") == 0)
	                pPrincipal->sgte_evento = bfnLlenaHabilVentas(lstPrincipal);
                        
        } 
        
} 

/*-----------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE INSERTA LOS EVENTOS OBTENIDOS EN LA TABLA CMT_VALORIZADOS */
/*-----------------------------------------------------------------------------*/
void vInsertaValorizados()
{
    stPrincipal     * pPrincipal;
    stEventos       * pEvento;    
    
    int             i;
   	char	szhFecDesde[11];
	char	szhFecHasta[11];
	char	szhFecEvento[11];

    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            long    lhNumGeneral;
            char    szhCodUniverso[7];
            int     ihCodConcepto;
            char    szhCodTipComis[3];
            long    lhCodComisionista;
            long    lhCodPeriodo;
            char    szhIdPeriodo[11];
            double  dhImpConcepto;
            int		ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 
   
    i = 0;
    stStatusProc.lCantEvaluaciones	=	0;
    lhCodPeriodo 			= stCiclo.lCodCiclComis;           
    strcpy(szhIdPeriodo		, stCiclo.szIdCiclComis);    
                        
    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
    {       
        strcpy(szhFecDesde	,	pPrincipal->szFec_Desde);
		strcpy(szhFecHasta	,	pPrincipal->szFec_Hasta);
        ihCodConcepto 			= pPrincipal->iCodConcepto;
        strcpy(szhCodTipComis	, pPrincipal->szCodTipComis);
        ihCodTipoRed 			= pPrincipal->iCodTipoRed;
        for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
        {
        strcpy(szhFecEvento	,	pEvento->szFec_Venta);
        if (bValidaFechaEvento (szhFecDesde, szhFecHasta, szhFecEvento))
	  	{	
            lhNumGeneral 			= pEvento->lNum_General;
            lhCodComisionista 		= pEvento->lCod_Comisionista;
            dhImpConcepto 			= fnCnvDouble(pPrincipal->dImpComision, 0);
                                                          
            /* EXEC SQL 	INSERT INTO	CMT_VALORIZADOS                                          
    			(NUM_GENERAL,
    			COD_UNIVERSO,
    			COD_CONCEPTO, 
    			COD_TIPCOMIS,
    			COD_COMISIONISTA,
    			COD_PERIODO, 
    			ID_PERIODO, 
    			IMP_CONCEPTO,
    			COD_TIPORED)
        	VALUES 
    			(:lhNumGeneral,
    			:szhCodUniverso,
    			:ihCodConcepto,
    			:szhCodTipComis, 
    			:lhCodComisionista,
    			:lhCodPeriodo,
    			:szhIdPeriodo,
    			:dhImpConcepto,
    			:ihCodTipoRed); */ 

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
            sqlstm.offset = (unsigned int  )224;
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



            stStatusProc.lCantEvaluaciones++;
        }
        } 
    }  
    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )275;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


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
void vLiberaDatos(stEventos * qaux)
{
        if (qaux == NULL)
                return;
        vLiberaDatos(qaux->sgte);
        free(qaux);
}
/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Resumen.                                       */
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stPrincipal * paux)
{
        if (paux == NULL)
                return;
        vLiberaUniverso(paux->sgte);
        vLiberaDatos(paux->sgte_evento);
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
    long lSegundos,lSegIni, lSegFin;
   
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();       
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
        strcpy(szFuncName, "fnOraConnect");
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
/* Preparacion de ambiente para archivos de log                              */
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
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )290;
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
/*--------------------------------------------------------------------------*/
/* Carga Estructura del Tasador                                             */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Gestiona Carga de Datos del Tasador..(vLlenaTasador)\n\n");
    fprintf(stderr, "Gestiona Carga de Datos del Tasador..(vLlenaTasador)\n\n");
    vLlenaTasador();
/*--------------------------------------------------------------------------*/
/* Recorre Estructura del Tasador                                           */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Ejecuta la carga de los eventos...(vCargaEventos)\n\n");
    fprintf(stderr, "Ejecuta la carga de los eventos...(vCargaEventos)\n\n");
    vCargaEventos();
/*--------------------------------------------------------------------------*/
/* Inserta datos en tabla VALORIZADOS                                       */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inserta los registros valorizados en la tabla CMT_VALORIZADOS....(vInsertaValorizados)\n\n");
    fprintf(stderr, "Inserta los registros valorizados en la tabla CMT_VALORIZADOS....(vInsertaValorizados)\n\n");
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de abonados, universos.			 */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada por listas de abonados y universos...(vLiberaUniverso)\n\n");
    fprintf(stderr, "Libera memoria utilizada por listas de abonados y universos...(vLiberaUniverso)\n\n");
    vLiberaUniverso(lstPrincipal);
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de Conceptos.*/
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
    fprintf(stderr, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
    vLiberaConceptosVal(lstConceptos);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
	lSegFin=lGetTimer();        
/*****************************************************************************/        
	stStatusProc.lSegProceso = lSegFin - lSegIni;
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
    sqlstm.offset = (unsigned int  )305;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}



    vFechaHora();                                                                                   
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

