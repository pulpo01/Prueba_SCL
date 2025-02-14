
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
           char  filnam[21];
};
static struct sqlcxp sqlfpn =
{
    20,
    "./pc/Val_Recargas.pc"
};


static unsigned int sqlctx = 55456547;


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

 static char *sq0003 = 
"select COD_ORIGEN ,MTO_MIN_RECARGA ,COD_CONCEPTO_ASOC ,NUM_PERIODOS ,IMP_COM\
ISION  from CM_VALRECARGAS_TD where ((COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) a\
nd COD_CONCEPTO=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,165,0,4,126,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
40,0,0,2,173,0,4,137,0,0,5,4,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
75,0,0,3,185,0,9,214,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
102,0,0,3,0,0,13,218,0,0,5,0,0,1,0,2,97,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
137,0,0,3,0,0,15,249,0,0,0,0,0,1,0,
152,0,0,4,0,0,17,334,0,0,1,1,0,1,0,1,97,0,0,
171,0,0,4,0,0,45,338,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
198,0,0,4,0,0,13,343,0,0,8,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,4,0,0,2,
3,0,0,2,3,0,0,2,97,0,0,
245,0,0,4,0,0,15,373,0,0,0,0,0,1,0,
260,0,0,5,190,0,3,462,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
311,0,0,6,48,0,1,588,0,0,0,0,0,1,0,
326,0,0,7,0,0,30,699,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa Recargas.                                                        */                                                                           
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                  */
/* Inicio: Jueves  26 de Diciembre del 2002.                                 */
/* Autor : Jaime Vargas Morales.                                             */
/*---------------------------------------------------------------------------*/
/*****************************************************************************/
/* Modificacion : Marcelo González Lizama                                    */
/* Inicio       : Miercoles 08 de Octubre de 2003                            */
/* Fin			:                                                            */
/* Descripcion  : Carga de datos a travez de estructura StConceptosProc      */
/*                Eliminacion y actualizacion de Querys para rescatar datos  */
/*                Cambio de Funcion vWriteLog por fprintf                    */
/* ************************************************************************* */ 
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Val_Recargas.h"
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
/* LIBERA MEMORIA USADA EN LA LISTA EVENTOS 		                         */
/*---------------------------------------------------------------------------*/
void vLiberaEvento(stEvento * paux)
{
    stEvento *  raux;	
	   
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

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA PRINCIPAL   	                         */
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{
        if (paux == NULL)
                return;
        vLiberaPrincipal(paux->sgte);
        free(paux);
}

/*---------------------------------------------------------------------------*/
/* funcion que retorna si tiene carga superior a cero                        */
/*---------------------------------------------------------------------------*/
BOOL bfnEstadoRecarga (long plNum_Abonado , long plNum_Celular, double pdMto_Recarga, char * pszCod_Origen )
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                
                long    lhNum_Abonado;
                long    lhNum_Celular;
                char    szhFecHastaNormal[11];
                double  dhCarga;
                double	dhMto_Recarga;
                char	szhCod_Origen[6];
				int     ihCantidad;
                
        /* EXEC SQL END DECLARE SECTION; */ 


    	dhCarga        	= 	0;
        lhNum_Abonado  	= 	plNum_Abonado;
        lhNum_Celular  	= 	plNum_Celular;
        dhMto_Recarga	=	pdMto_Recarga;
        strcpy(szhCod_Origen , pszCod_Origen);
        
        strcpy(szhFecHastaNormal , stCiclo.szFecDesdeNormal); 
        
       	/* EXEC SQL 
		SELECT COUNT(1)
		INTO   :ihCantidad    
    	FROM   PV_RECARGAPREPAGO_TO                      
    	WHERE  NUM_ABONADO     = :lhNum_Abonado             
        AND    NUM_CELULAR     = :lhNum_Celular 
        AND    FEC_RECARGA    <= TO_DATE(:szhFecHastaNormal, 'DD-MM-YYYY')
		AND    COD_APLIORIGEN  = :szhCod_Origen; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(1) into :b0  from PV_RECARGAPREPAGO_TO w\
here (((NUM_ABONADO=:b1 and NUM_CELULAR=:b2) and FEC_RECARGA<=TO_DATE(:b3,'DD-\
MM-YYYY')) and COD_APLIORIGEN=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCantidad;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_Abonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_Celular;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaNormal;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Origen;
        sqlstm.sqhstl[4] = (unsigned long )6;
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



        if (ihCantidad > 0)
		{
        /* EXEC SQL 
        		SELECT 
        				SUM(VAL_RECARGA) INTO :dhCarga    
                FROM 
                		PV_RECARGAPREPAGO_TO
                WHERE 	
                		NUM_ABONADO 	= 	:lhNum_Abonado             
              	AND 	NUM_CELULAR 	= 	:lhNum_Celular 
              	AND 	FEC_RECARGA 	<= 	TO_DATE(:szhFecHastaNormal, 'DD-MM-YYYY')
              	AND		COD_APLIORIGEN	=	:szhCod_Origen; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select sum(VAL_RECARGA) into :b0  from PV_RECARGAPREP\
AGO_TO where (((NUM_ABONADO=:b1 and NUM_CELULAR=:b2) and FEC_RECARGA<=TO_DATE(\
:b3,'DD-MM-YYYY')) and COD_APLIORIGEN=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )40;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhCarga;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_Abonado;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_Celular;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaNormal;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Origen;
        sqlstm.sqhstl[4] = (unsigned long )6;
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


        }
        else
		{
	     return FALSE;
		}
              	
        if (dhCarga >= dhMto_Recarga)
                return TRUE ;
        else
                return FALSE ;
}                                                                                                               

/* ------------------------------------------------------------------------ */
/* CREA LISTA PRINCIPAL (TAZADOR)                                           */       
/* ------------------------------------------------------------------------ */
void vLlenaTasador()
{
    stPrincipal     * paux;
    stConceptosProc	* raux;

    int             i;
    short           iLastRows    = 0;
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int			ihCodTipoRed;
        char		szhCodPlanComis		[6];
        int         ihCod_Concepto 		;
        char    	szhCod_TipComis		[3];
        char    	szhCod_Origen  		[MAXFETCH][6];
        double  	dhMto_Recarga  		[MAXFETCH];
        int     	ihCod_Concepto_Asoc	[MAXFETCH];
        int     	ihNum_Periodos 		[MAXFETCH];
        double  	dhImp_Comision 		[MAXFETCH];
        long    	lhCodCicloComis;
        long    	lhCodCiclo;
        long    	lMaxFetch; 
    /* EXEC SQL END DECLARE SECTION; */ 


    for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
   	{
    	ihCodTipoRed 			= 	raux->iCodTipoRed;
    	strcpy(szhCodPlanComis	,	raux->szCodPlanComis);
    	ihCod_Concepto			= 	raux->iCodConcepto;
    	strcpy(szhCod_TipComis	,	raux->szCodTipComis);
    
        lMaxFetch = MAXFETCH;
        	        
        lhCodCicloComis = stCiclo.lCodCiclComis;
        lhCodCiclo  = stCiclo.lCodCiclo;

        /* EXEC SQL DECLARE CUR_RECARGAS CURSOR FOR
                SELECT                    
                        COD_ORIGEN,
                        MTO_MIN_RECARGA,
                        COD_CONCEPTO_ASOC,
                        NUM_PERIODOS ,
                        IMP_COMISION
                FROM
                    	CM_VALRECARGAS_TD
                WHERE	
                		COD_TIPORED		=	:ihCodTipoRed
            	AND		COD_PLANCOMIS		=	:szhCodPlanComis	            									
            	AND		COD_CONCEPTO		=	:ihCod_Concepto; */ 



        /* EXEC SQL OPEN CUR_RECARGAS; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0003;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )75;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Concepto;
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
                 FETCH CUR_RECARGAS INTO
                	:szhCod_Origen,
                	:dhMto_Recarga,
                	:ihCod_Concepto_Asoc,
                	:ihNum_Periodos,
                	:dhImp_Comision; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 5;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )102;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Origen;
            sqlstm.sqhstl[0] = (unsigned long )6;
            sqlstm.sqhsts[0] = (         int  )6;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)dhMto_Recarga;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )sizeof(double);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)ihCod_Concepto_Asoc;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )sizeof(int);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)ihNum_Periodos;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[3] = (         int  )sizeof(int);
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)dhImp_Comision;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[4] = (         int  )sizeof(double);
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
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

	                        	

            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];

            for (i=0; i < iRetrievRows; i++)
            {
                paux = (stPrincipal *) malloc(sizeof(stPrincipal));

                paux->iCodTipoRed				= ihCodTipoRed;
                strcpy(paux->szCodPlanComis		, szhCodPlanComis);
                paux->iCod_Concepto             = ihCod_Concepto;
                strcpy(paux->szCod_TipComis     , szfnTrim(szhCod_TipComis));
                strcpy(paux->szCod_Origen       , szfnTrim(szhCod_Origen[i]));
                paux->dMto_Recarga              = dhMto_Recarga[i];
                paux->iCod_Concepto_Asoc        = ihCod_Concepto_Asoc[i];
                paux->iNum_Periodos             = ihNum_Periodos[i];
                paux->lImp_Comision             = dhImp_Comision[i];
                strcpy(paux->szFecDesde			, raux->szFecDesde);
                strcpy(paux->szFecHasta			, raux->szFecHasta);
				paux->sgte_evento				= NULL;
                paux->sgte        				= lstPrincipal;
                lstPrincipal              		= paux;
            }
        }
    	/* EXEC SQL CLOSE CUR_RECARGAS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 5;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )137;
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
/* PROCEDIMIENTO QUE CARGA LOS EVENTOS  EN UNA LISTA                         */      
/*---------------------------------------------------------------------------*/
stEvento * stCargaEventos( long pNewCodCiclComis, char * pszIdCiclComis, int iCodTipoRed, int iCod_Concepto)
{							
    stEvento        * paux;  
    stEvento        * qaux;  

    short   iLastRows    = 0;
    int     iFetchedRows = MAXFETCH;
    int     iRetrievRows = MAXFETCH;
    int     i;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int		ihCodTipoRed;		
		char	szhCodPlanComis[6];  
		int     ihCod_Concepto;
        long    lhNum_General       [MAXFETCH];
        char    szhCod_Tipcomis     [MAXFETCH][3];
        long    lhCod_Comisionista 	[MAXFETCH];
        char    szhCod_Universo     [MAXFETCH][7];
        char	szhIdCiclComis		[11];
		double  dhImp_Concepto      [MAXFETCH];
		long    lhNum_Abonado       [MAXFETCH];
		long    lhNum_Celular       [MAXFETCH];
		long    lhCod_Concepto_Asoc;
		double  dhImp_Comision 		[MAXFETCH];
		int    	lhCodCiclComis; 
        long    lMaxFetch;
                
		char	szTabLogValor		[31];
		char	szTabFisValor		[31];
		char	szTabLogHabil		[31];
		char	szTabFisHabil		[31];	
		char    szSentenciaSql      [1024];
		char    szhFechaEvento [MAXFETCH][11];
	/* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclComis			=	pNewCodCiclComis;
    strcpy(szhIdCiclComis	,	pszIdCiclComis);
    ihCodTipoRed			=	iCodTipoRed;		
	ihCod_Concepto			=	iCod_Concepto;       
	
	paux	=	NULL;
    qaux	=	NULL;

    strcpy(szTabLogValor, "CMT_VALORIZADOS");
    strcpy(szTabLogHabil, "CMT_HABIL_PREPAGO");
    
	if (!iBuscaTablaFisica(szTabLogValor, szhIdCiclComis , szTabFisValor))
		return (NULL);
	
	if (strcmp(szfnTrim(szTabFisValor),"0")==0)
		return (NULL);

	if (!iBuscaTablaFisica(szTabLogHabil, szhIdCiclComis , szTabFisHabil))
		return (NULL);
	
	if (strcmp(szfnTrim(szTabFisHabil),"0")==0)
		return (NULL);

    sprintf(szSentenciaSql, 
	           "SELECT "
	            "A.NUM_GENERAL, "
	            "A.COD_UNIVERSO, "
	            "A.COD_TIPCOMIS, "
	            "A.COD_COMISIONISTA, "
	            "A.IMP_CONCEPTO, "
	            "B.NUM_ABONADO, "
	            "B.NUM_CELULAR, "
	            "B.TO_CHAR(FEC_HABILITACION, 'DD-MM-YYYY') "           
	            "FROM %s A, "
	            "     %s B  "
	            "WHERE A.ID_PERIODO  	= :v1 "
	            "AND A.COD_TIPORED    	= :v2 " 
	            "AND A.COD_CONCEPTO   	= :v3 " 
	            "AND A.NUM_GENERAL     	= B.NUM_GENERAL " 
	            "AND A.IMP_CONCEPTO   	>= 0 ",                    
  			   szTabFisValor,
               szTabFisHabil );
                
     
    /* EXEC SQL PREPARE PRE_CURSOR FROM :szSentenciaSql; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )152;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szSentenciaSql;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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


    
    /* EXEC SQL DECLARE CUR_Eventos CURSOR for PRE_CURSOR; */ 


    /* EXEC SQL OPEN Cur_Eventos using :szhIdCiclComis, :ihCodTipoRed, :ihCod_Concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )171;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Concepto;
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


    
    lMaxFetch = MAXFETCH;
    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch FETCH Cur_Eventos INTO
	          :lhNum_General     ,
	          :szhCod_Universo   ,
	          :szhCod_Tipcomis   , 
	          :lhCod_Comisionista,
	          :dhImp_Concepto    ,
	          :lhNum_Abonado     ,
	          :lhNum_Celular	 ,
	          :szhFechaEvento; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )198;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Universo;
        sqlstm.sqhstl[1] = (unsigned long )7;
        sqlstm.sqhsts[1] = (         int  )7;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Tipcomis;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )3;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)lhCod_Comisionista;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )sizeof(long);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)dhImp_Concepto;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[4] = (         int  )sizeof(double);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)lhNum_Abonado;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )sizeof(long);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)lhNum_Celular;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )sizeof(long);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFechaEvento;
        sqlstm.sqhstl[7] = (unsigned long )11;
        sqlstm.sqhsts[7] = (         int  )11;
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
            paux = (stEvento *) malloc(sizeof(stEvento));

            paux->lNum_General              = lhNum_General[i];
            strcpy(paux->szCod_Tipcomis  	, szfnTrim(szhCod_Tipcomis[i]));
            paux->lCod_Comisionista         = lhCod_Comisionista[i];
            strcpy(paux->szCod_Universo  	, szfnTrim(szhCod_Universo[i])); 
            paux->dImp_Concepto             = dhImp_Concepto[i];
            paux->lNum_Abonado              = lhNum_Abonado[i];
            paux->lNum_Celular           	= lhNum_Celular[i]; 
            strcpy(paux->szFechaHabilitacion, szfnTrim(szhFechaEvento [i]));             
       
            paux->sgte 	= qaux;
            qaux        = paux;
        }
    }
    /* EXEC SQL CLOSE Cur_Eventos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )245;
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
/* PROCEDIMIENTO QUE EJECUTA LA CONSULTA DE RECARGAS                         */
/*---------------------------------------------------------------------------*/
void vCalculaRecargas(stPrincipal * paux)
{
	stEvento * qaux;
	
	for (qaux = paux->sgte_evento; qaux != NULL; qaux = qaux->sgte)
	{
		if (!bfnEstadoRecarga(qaux->lNum_Abonado ,qaux->lNum_Celular, paux->dMto_Recarga, paux->szCod_Origen))
            	qaux->lImp_Comision = paux->lImp_Comision;
        else
		    qaux->lImp_Comision = 0.00;
	}
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE INICIA LA COMPLETACION DE LOS EVENTOS                   */
/*---------------------------------------------------------------------------*/
void  vEvaluaRecargas()
{
    stPrincipal * paux;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            long    lhNewCodCiclComis;
            char	szIdCiclComis[11];
    /* EXEC SQL END DECLARE SECTION; */ 
   

    for(paux=lstPrincipal;paux!=NULL;paux=paux->sgte)
    {
        lhNewCodCiclComis		= lNewCiclComis(stCiclo.lCodCiclComis, (paux->iNum_Periodos * -1));
        strcpy(szIdCiclComis	, szNewCiclComis(lhNewCodCiclComis));
        paux->sgte_evento 		= stCargaEventos(lhNewCodCiclComis,szIdCiclComis, paux->iCodTipoRed, paux->iCod_Concepto );
        vCalculaRecargas(paux);
    }
        
}
                                                                                                                                                        
/*-----------------------------------------------------------------------------*/
/* INSERTA  REGISTROS EN LA TABLA CMT_VALORIZADOS                              */
/*-----------------------------------------------------------------------------*/
void vGrabaPrincipal()
{
    stPrincipal    * pPrincipal;
    stEvento       * pEvento;
    int            i;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int		ihCodTipoRed;		
		char	szhCodPlanComis[6];  
		long    lhNumGeneral;
        char    szhCodUniverso[7];
        int     ihCodConcepto;
        char    szhCodTipComis[3];
        long    lhCodComisionista;
        long    lhCodCiclComis;
        char    szhIdCiclComis[10];
        double  dhImpComision;
        char	szhFecDesde[11];
		char	szhFecHasta[11];
		char	szhFecEvento[11];
    /* EXEC SQL END DECLARE SECTION; */ 
   
    i = 0;
    strcpy(szhIdCiclComis  , stCiclo.szIdCiclComis);
    lhCodCiclComis         = stCiclo.lCodCiclComis;
        
    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
    {       
        ihCodConcepto			= 	pPrincipal->iCod_Concepto_Asoc;
        dhImpComision       	= 	fnCnvDouble(pPrincipal->lImp_Comision, 0);
		strcpy(szhCodTipComis   , 	pPrincipal->szCod_TipComis);
		ihCodTipoRed			=	pPrincipal->iCodTipoRed;
		
		for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
		{
			strcpy(szhFecDesde	,	pPrincipal->szFecDesde);
			strcpy(szhFecHasta	,	pPrincipal->szFecHasta);
			strcpy(szhFecEvento,	pEvento->szFechaHabilitacion);
	 
			if (bValidaFechaEvento(szhFecDesde, szhFecHasta, szhFecEvento))
			{		
				lhNumGeneral          = pEvento->lNum_General;
				strcpy(szhCodUniverso , pEvento->szCod_Universo);
				lhCodComisionista     = pEvento->lCod_Comisionista;
				
				i++;
				
				/* EXEC SQL INSERT INTO CMT_VALORIZADOS
				        ( 	COD_TIPORED,
				        	NUM_GENERAL,
				          	COD_CONCEPTO,
				          	ID_PERIODO, 
				          	COD_UNIVERSO,
				          	COD_TIPCOMIS,
				          	COD_COMISIONISTA,
				          	COD_PERIODO, 
				          	IMP_CONCEPTO)
				        VALUES
				         	(
				         	:ihCodTipoRed,
				         	:lhNumGeneral,
				          	:ihCodConcepto,
				          	:szhIdCiclComis,
				          	:szhCodUniverso,
				          	:szhCodTipComis,
				          	:lhCodComisionista,
				          	:lhCodCiclComis,
				          	:dhImpComision); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_VALORIZADOS (COD_TIPORED,NUM_GENERAL,COD_\
CONCEPTO,ID_PERIODO,COD_UNIVERSO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,IMP\
_CONCEPTO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )260;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoRed;
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
    sqlstm.sqhstv[3] = (unsigned char  *)szhIdCiclComis;
    sqlstm.sqhstl[3] = (unsigned long )10;
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
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodComisionista;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclComis;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhImpComision;
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


			 }  
		}                                                                                
	}
	stStatusProc.lCantRegistros = i;        
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
            fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);                                   
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
        sqlstm.offset = (unsigned int  )311;
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
        
		lSegIni=lGetTimer();                                                                
                                                                                            
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());      
        fprintf(pfLog,  "Inicio procesamiento principal ...\n\n");
        fprintf(stderr, "Inicio procesamiento principal ...\n\n");

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

/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA PRINCIPAL DE VALORACION DE UNIVERSOS                     */
/*---------------------------------------------------------------------------*/
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "Carga estructura principal de valoración...\n\n");
        fprintf(stderr, "Carga estructura principal de valoración...\n\n");
        vLlenaTasador();                

/*---------------------------------------------------------------------------*/
/* EJECUTA VALORACION DE EVENTOS POR CONCEPTOS DE RECARGAS                   */
/*---------------------------------------------------------------------------*/
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "Carga lista de eventos...\n\n");
        fprintf(stderr, "Carga lista de eventos...\n\n");
        vEvaluaRecargas();      
                
/*---------------------------------------------------------------------------*/
/* GRABA RESULTADOS EN CMT_VALORIZADOS                                       */
/*---------------------------------------------------------------------------*/   
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "Graba resultados en cmt_valorizados...\n\n");
        fprintf(stderr, "Graba resultados en cmt_valorizados...\n\n");
        vGrabaPrincipal();  
        
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA...                                               */
/*---------------------------------------------------------------------------*/        
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA PRINCIPAL                              */
/*---------------------------------------------------------------------------*/
        vFechaHora();                                                                   
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());      
        fprintf(pfLog, "Libera memoria utilizada por lista Principal...(vLiberaPrincipal)\n\n");
        fprintf(stderr, "Libera memoria utilizada por lista Principal...(vLiberaPrincipal)\n\n");
        vLiberaPrincipal(lstPrincipal);

/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA DE EVENTOS                             */
/*---------------------------------------------------------------------------*/
        vFechaHora();                                                                   
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());      
        fprintf(pfLog, "Libera memoria utilizada por lista de Eventos.....(vLiberaEvento)\n\n");
        fprintf(stderr, "Libera memoria utilizada por lista de Eventos.....(vLiberaEvento)\n\n");        
        vFechaHora();
	   	vLiberaEvento(lstEvento);
        
/*---------------------------------------------------------------------------*/
/*    - Libera memoria utilizada por listas de Conceptos.*/
/*---------------------------------------------------------------------------*/
        
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
        fprintf(stderr, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
        
        vLiberaConceptosVal(lstConceptos);

/*------------------------------------------------------------------*/
/* RECUPERACION DE LOS SEGUNDOS REALES OCUPADOS POR EL PROCESO.    */
/*-----------------------------------------------------------------*/
    lSegFin=lGetTimer();
        stStatusProc.lSegProceso = lSegFin - lSegIni;
        
        if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"",stStatusProc.lSegProceso,stStatusProc.lCantRegistros))                                         
                exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));                                              
        
        /* EXEC SQL COMMIT WORK RELEASE; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )326;
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
        fprintf(pfLog, "\nEstadistica del proceso\n");
        fprintf(pfLog, "------------------------\n");
        fprintf(pfLog, "Segundos Reales Utilizados    : [%d]\n", stStatusProc.lSegProceso);
        fprintf(pfLog, "Cantidad Registros Porcesados : [%d]\n",stStatusProc.lCantRegistros);
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

