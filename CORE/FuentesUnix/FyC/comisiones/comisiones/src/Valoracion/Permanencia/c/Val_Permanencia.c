
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
    "./pc/Val_Permanencia.pc"
};


static unsigned int sqlctx = 443673235;


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
"select TIP_PLAN ,NUM_PERIODOS ,IND_SALDO ,TIP_BONIFICACION ,COD_CONCEPTO_ASO\
C ,IMP_BONIFICACION  from CM_PERMANENCIA_TD where ((COD_TIPORED=:b0 and COD_PL\
ANCOMIS=:b1) and COD_CONCEPTO=:b2) order by TIP_PLAN            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,145,0,4,125,0,0,3,2,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,
32,0,0,2,218,0,9,203,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
59,0,0,2,0,0,13,207,0,0,6,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,
4,0,0,
98,0,0,2,0,0,15,244,0,0,0,0,0,1,0,
113,0,0,3,0,0,17,333,0,0,1,1,0,1,0,1,97,0,0,
132,0,0,3,0,0,45,335,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
163,0,0,3,0,0,13,340,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
214,0,0,3,0,0,15,374,0,0,0,0,0,1,0,
229,0,0,4,0,0,17,414,0,0,1,1,0,1,0,1,97,0,0,
248,0,0,4,0,0,45,418,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
279,0,0,4,0,0,13,420,0,0,1,0,0,1,0,2,3,0,0,
298,0,0,4,0,0,15,422,0,0,0,0,0,1,0,
313,0,0,5,0,0,17,437,0,0,1,1,0,1,0,1,97,0,0,
332,0,0,5,0,0,45,441,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
363,0,0,5,0,0,13,443,0,0,1,0,0,1,0,2,4,0,0,
382,0,0,5,0,0,15,445,0,0,0,0,0,1,0,
397,0,0,6,190,0,3,634,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,97,0,0,1,4,0,0,
448,0,0,7,48,0,1,767,0,0,0,0,0,1,0,
463,0,0,8,0,0,30,859,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa encargado de ejecutar la valoración por Permanencia              */
/*---------------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                                  */
/* Inicio: Martes 9 de Diciembre de 2002.                                    */
/* Autor : Jaime Vargas Morales                                              */
/*---------------------------------------------------------------------------*/
/*****************************************************************************/
/* Modificacion : Marcelo González Lizama                                    */
/* Inicio       : Martes 07 de Octubre de 2003                               */
/* Fin			:                                                            */
/* Descripcion  : Carga de datos a travez de estructura StConceptosProc      */
/*                Eliminacion y actualizacion de Querys para rescatar datos  */
/*                Cambio de Funcion vWriteLog por fprintf                    */
/* ************************************************************************* */ 
/* INCLUSION DE LIBRERÍA PARA DEFINICIONES GENERALES DEL PROGRAMA.           */
/*---------------------------------------------------------------------------*/
#include "Val_Permanencia.h"
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
/* Declaración e inicialización de lista de conceptos a procesar.            */
/*---------------------------------------------------------------------------*/
stConceptosProc * lstConceptos = NULL;
/*---------------------------------------------------------------------------*/
/* DEFINICION DE VARIABLES GLOBALES PARA SER USADAS CON ORACLE.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

char    szhUser[30]="";
char    szhPass[30]="";
char    szhSysDate[17]="";
char    szFechaYYYYMMDD[9];
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* LIBERA LISTA DE EVENTOS                                                                   */
/*---------------------------------------------------------------------------*/
void vLiberaEvento(stEvento * raux)
{
    if (raux == NULL)
        return;
    vLiberaEvento(raux->sgte);
    free(raux);
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA PRINCIPAL (TASADOR)                              */
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{
        if (paux == NULL)
                return;
        vLiberaPrincipal(paux->sgte);
        vLiberaEvento(paux->sgte_evento);
        free(paux);
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
/* MUESTRA UN RESUMEN DEL CONTENIDO DE LAS LISTAS LLENADAS POR EL PROCESO    */
/*---------------------------------------------------------------------------*/
BOOL vMuestraEstructura()                                                                                                                     
{                                                                                                              
        stPrincipal     * pPrincipal;
        stEvento        * pEvento;

        char    szDesde[11];
        char    szHasta[11];
        int     contador = 1;
        
        for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
        {      
            printf ("pPrincipal->iCod_Concepto        [%ld]\n", pPrincipal->iCod_Concepto     );                                                                                             
                printf ("pPrincipal->szCod_Tipcomis       [%s]\n" , pPrincipal->szCod_Tipcomis    );   
                printf ("pPrincipal->szTip_Plan           [%s]\n" , pPrincipal->szTip_Plan        );            
                                
                printf ("------------------------------------------------------------------------\n");          
        }
        return (TRUE);
}       
/*---------------------------------------------------------------------------*/
/* FUNCION QUE RETORNA EL SALDO VENCIDO DEL CLIENTE...                       */
/*---------------------------------------------------------------------------*/
BOOL bfnEstadoSaldo(long plCodCliente, long plNumAbonado)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                long    lhCodCliente;
                double  dhImpDebe;
                long	lhNumAbonado;
        /* EXEC SQL END DECLARE SECTION; */ 


        lhCodCliente = plCodCliente;
        lhNumAbonado = plNumAbonado;
        /* EXEC SQL SELECT NVL(SUM(IMPORTE_DEBE-IMPORTE_HABER),0)
                INTO :dhImpDebe
                FROM CO_CARTERA
                WHERE COD_CLIENTE = :lhCodCliente
                  AND NUM_ABONADO = :lhNumAbonado
                  AND FEC_VENCIMIE <= SYSDATE; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) into \
:b0  from CO_CARTERA where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and FEC_VENC\
IMIE<=SYSDATE)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhImpDebe;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
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



        if(dhImpDebe <= 0)
                return TRUE;
        else
                return FALSE;
}                                                                                                                                       
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA PRINCIPAL (TASADOR) PARA LUEGO                */
/* PODER VALORAR LAS    PERMANENCIAS                                         */
/*---------------------------------------------------------------------------*/
void bfnLlenaTasador ()
{       
        stPrincipal     * pPrincipal;
        stConceptosProc	* raux;
        
        int                     i;
        short                   iLastRows    = 0;       
        int                     iFetchedRows = MAXFETCH;
        int                     iRetrievRows = MAXFETCH;
        long                    lCantidad = 0;
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                long    lMaxFetch;
                int		ihCodTipoRed		;
                int     ihCod_Concepto      ;
                char    szhCod_TipComis     [3];
                char	szCodPlanComis		[6];
                char    szhTip_Plan         [MAXFETCH][6];
                char    szhFec_Desde        [11];
                char    szhFec_Hasta        [11];
                int     ihNum_Periodo       [MAXFETCH]; 
                char    szhInd_Saldo        [MAXFETCH][2]; 
                char    szhTip_Bonifica     [MAXFETCH][2];
                int     ihCod_Concepto_Asoc [MAXFETCH];
                double  dhImp_Bonifica      [MAXFETCH];
                long    lhCodCiclo			;
                char	szhCodUniverso[7]	;
        /* EXEC SQL END DECLARE SECTION; */ 


        for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
	   	{
        	ihCodTipoRed 			= 	raux->iCodTipoRed;
        	strcpy(szCodPlanComis	,	raux->szCodPlanComis);
        	ihCod_Concepto			= 	raux->iCodConcepto;
        	strcpy(szhCod_TipComis	,	raux->szCodTipComis);
        	strcpy(szhFec_Desde		,	raux->szFecDesde);
        	strcpy(szhFec_Hasta		,	raux->szFecHasta);
        	strcpy(szhCodUniverso	,	raux->szCodUniverso);
        	
	        fprintf(pfLog ,"\n(bfnLlenaTasador) Carga conceptos. TR:[%d] PlComis:[%s] TipComis:[%s] Conc:[%d] Desde[%s] Hasta:[%s]\n",ihCodTipoRed, szCodPlanComis, szhCod_TipComis, ihCod_Concepto, szhFec_Desde, szhFec_Hasta);
	        fprintf(stderr,"\n(bfnLlenaTasador) Carga conceptos. TR:[%d] PlComis:[%s] TipComis:[%s] Conc:[%d] Desde[%s] Hasta:[%s]\n",ihCodTipoRed, szCodPlanComis, szhCod_TipComis, ihCod_Concepto, szhFec_Desde, szhFec_Hasta);
        	        	
			iFetchedRows 	= MAXFETCH;
			iRetrievRows 	= MAXFETCH;
	        lMaxFetch 		= MAXFETCH;
	        iLastRows    	= 0;
	        lhCodCiclo  	= stCiclo.lCodCiclo;
	        
	        /* EXEC SQL DECLARE Cur_Tasador CURSOR for
	        		SELECT 
	                          TIP_PLAN, 
	                          NUM_PERIODOS, 
	                          IND_SALDO, 
	                          TIP_BONIFICACION,
	                          COD_CONCEPTO_ASOC,
	                          IMP_BONIFICACION	                          
	                FROM  CM_PERMANENCIA_TD 
	                WHERE 	
	                		COD_TIPORED		= :ihCodTipoRed	
		        	AND 	COD_PLANCOMIS	= :szCodPlanComis
		        	AND		COD_CONCEPTO	= :ihCod_Concepto	                
	                ORDER BY TIP_PLAN; */ 

	                  
	        /* EXEC SQL OPEN Cur_Tasador; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 3;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = sq0002;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )32;
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
         sqlstm.sqhstv[1] = (unsigned char  *)szCodPlanComis;
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
	                        FETCH Cur_Tasador INTO
	                        :szhTip_Plan      ,    
	                        :ihNum_Periodo    ,       
	                        :szhInd_Saldo     ,       
	                        :szhTip_Bonifica  ,    
	                        :ihCod_Concepto_Asoc,
	                        :dhImp_Bonifica   ; */ 

{
                 struct sqlexd sqlstm;
                 sqlstm.sqlvsn = 12;
                 sqlstm.arrsiz = 6;
                 sqlstm.sqladtp = &sqladt;
                 sqlstm.sqltdsp = &sqltds;
                 sqlstm.iters = (unsigned int  )lMaxFetch;
                 sqlstm.offset = (unsigned int  )59;
                 sqlstm.selerr = (unsigned short)1;
                 sqlstm.cud = sqlcud0;
                 sqlstm.sqlest = (unsigned char  *)&sqlca;
                 sqlstm.sqlety = (unsigned short)256;
                 sqlstm.occurs = (unsigned int  )0;
                 sqlstm.sqfoff = (         int )0;
                 sqlstm.sqfmod = (unsigned int )2;
                 sqlstm.sqhstv[0] = (unsigned char  *)szhTip_Plan;
                 sqlstm.sqhstl[0] = (unsigned long )6;
                 sqlstm.sqhsts[0] = (         int  )6;
                 sqlstm.sqindv[0] = (         short *)0;
                 sqlstm.sqinds[0] = (         int  )0;
                 sqlstm.sqharm[0] = (unsigned long )0;
                 sqlstm.sqharc[0] = (unsigned long  *)0;
                 sqlstm.sqadto[0] = (unsigned short )0;
                 sqlstm.sqtdso[0] = (unsigned short )0;
                 sqlstm.sqhstv[1] = (unsigned char  *)ihNum_Periodo;
                 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
                 sqlstm.sqhsts[1] = (         int  )sizeof(int);
                 sqlstm.sqindv[1] = (         short *)0;
                 sqlstm.sqinds[1] = (         int  )0;
                 sqlstm.sqharm[1] = (unsigned long )0;
                 sqlstm.sqharc[1] = (unsigned long  *)0;
                 sqlstm.sqadto[1] = (unsigned short )0;
                 sqlstm.sqtdso[1] = (unsigned short )0;
                 sqlstm.sqhstv[2] = (unsigned char  *)szhInd_Saldo;
                 sqlstm.sqhstl[2] = (unsigned long )2;
                 sqlstm.sqhsts[2] = (         int  )2;
                 sqlstm.sqindv[2] = (         short *)0;
                 sqlstm.sqinds[2] = (         int  )0;
                 sqlstm.sqharm[2] = (unsigned long )0;
                 sqlstm.sqharc[2] = (unsigned long  *)0;
                 sqlstm.sqadto[2] = (unsigned short )0;
                 sqlstm.sqtdso[2] = (unsigned short )0;
                 sqlstm.sqhstv[3] = (unsigned char  *)szhTip_Bonifica;
                 sqlstm.sqhstl[3] = (unsigned long )2;
                 sqlstm.sqhsts[3] = (         int  )2;
                 sqlstm.sqindv[3] = (         short *)0;
                 sqlstm.sqinds[3] = (         int  )0;
                 sqlstm.sqharm[3] = (unsigned long )0;
                 sqlstm.sqharc[3] = (unsigned long  *)0;
                 sqlstm.sqadto[3] = (unsigned short )0;
                 sqlstm.sqtdso[3] = (unsigned short )0;
                 sqlstm.sqhstv[4] = (unsigned char  *)ihCod_Concepto_Asoc;
                 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
                 sqlstm.sqhsts[4] = (         int  )sizeof(int);
                 sqlstm.sqindv[4] = (         short *)0;
                 sqlstm.sqinds[4] = (         int  )0;
                 sqlstm.sqharm[4] = (unsigned long )0;
                 sqlstm.sqharc[4] = (unsigned long  *)0;
                 sqlstm.sqadto[4] = (unsigned short )0;
                 sqlstm.sqtdso[4] = (unsigned short )0;
                 sqlstm.sqhstv[5] = (unsigned char  *)dhImp_Bonifica;
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
	                iLastRows = sqlca.sqlerrd[2];
	                
	                for (i=0; i < iRetrievRows; i++)
	                {
		                pPrincipal = (stPrincipal *) malloc(sizeof(stPrincipal));
		                
		                
		                pPrincipal->iCodTipoRed					=	ihCodTipoRed;
		                strcpy(pPrincipal->szCodPlanComis		,	szCodPlanComis);
		                pPrincipal->iCod_Concepto           	= 	ihCod_Concepto;
		                strcpy(pPrincipal->szCod_Tipcomis   	, 	szfnTrim(szhCod_TipComis));
		                strcpy(pPrincipal->szTip_Plan       	, 	szfnTrim(szhTip_Plan[i]));
		                strcpy(pPrincipal->szFec_Desde      	, 	szfnTrim(szhFec_Desde));
		                strcpy(pPrincipal->szFec_Hasta      	, 	szfnTrim(szhFec_Hasta));
		                pPrincipal->iNum_Periodos           	= 	ihNum_Periodo[i];                        
		                strcpy(pPrincipal->szInd_Saldo      	, 	szfnTrim(szhInd_Saldo[i]));                      
		    			strcpy(pPrincipal->szTip_Bonificacion	, 	szfnTrim(szhTip_Bonifica[i]));
		    			pPrincipal->iCod_Concepto_Asoc       	= 	ihCod_Concepto_Asoc[i];
		                pPrincipal->dImp_Bonificacion        	= 	dhImp_Bonifica[i];
		                strcpy(pPrincipal->szCodUniverso		,   raux->szCodUniverso);
		                lCantidad++;
		                
		                pPrincipal->sgte                = lstPrincipal;                 
		                lstPrincipal                    = pPrincipal;
		                pPrincipal->sgte_evento         = NULL;
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
         sqlstm.offset = (unsigned int  )98;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
         if (sqlca.sqlcode < 0) vSqlError();
}


	    }	       
        fprintf(pfLog,"\n\t(bfnLlenaTasador)Cantidad de Registros leidos:[%ld]\n",lCantidad);
        fprintf(stderr,"\n\t(bfnLlenaTasador)Cantidad de Registros leidos:[%ld]\n",lCantidad);
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LOS EVENTOS  EN UNA LISTA                         */
/* 1.- DETERMINA LA TABLA FISICA DONDE SE ENCUENTRAN LOS EVENTOS.            */
/* 2.- CREA LA LISTA DE EVENTOS                                              */
/*---------------------------------------------------------------------------*/
stEvento * stCargaEventos(char * pszCodTipcomis, char * pszTipPlan, int piCodTipoRed, char * szCodPlanComis, int iCod_Concepto, char * pszIdCiclComis)
{							
        stEvento        * paux;  
        stEvento        * qaux;  
        
        short           iLastRows    = 0;       
        int             iFetchedRows = MAXFETCH;
        int             iRetrievRows = MAXFETCH;
        int             i;
        int				iCantidad = 0;
                
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                long    lhNum_General       [MAXFETCH];
                long    lhCod_Comisionista  [MAXFETCH];
                char    szhCod_Estado       [MAXFETCH][3];
                char    szhCod_Situacion    [MAXFETCH][4];
                char    szhTip_Plan         [MAXFETCH][6];
                char    szhCod_Categcliente [MAXFETCH][11];
                long    ihCod_Cliente       [MAXFETCH];
                long	lhNumAbonado		[MAXFETCH];
                char	szhCodTipPlan		[6];
                char    szhCodTipcomis      [3];
                char    szIdCiclComis		[11];
                long    lMaxFetch;
                char    szTablaLogica       [31];
                char    szTablaFisica       [31];
                char    szTabla             [31];
                char    szSentenciaSql      [1024];
                int		ihCodTipoRed		;
                char	szhCodPlanComis		[6];
                int		ihCod_Concepto;
                char	szhCod_Oficina		[MAXFETCH][3];
             
        /* EXEC SQL END DECLARE SECTION; */ 

        
        paux = NULL;
        qaux = NULL;
		
        strcpy(szTablaLogica,"CMT_HABIL_CELULAR");        
        strcpy(szIdCiclComis	,	pszIdCiclComis);
        strcpy(szhCodTipcomis	,	pszCodTipcomis);
        ihCodTipoRed			=	piCodTipoRed;
		strcpy(szhCodPlanComis	,	szCodPlanComis);
		ihCod_Concepto			=	iCod_Concepto;
		strcpy(szhCodTipPlan	, 	pszTipPlan);
		
        if (!(iBuscaTablaFisica(szTablaLogica, szIdCiclComis, szTablaFisica)))
        {
                return (NULL);
        }
        strcpy(szTablaFisica, szfnTrim(szTablaFisica)); 
        if (strcmp(szTablaFisica,"0")==0)
        {
                return (NULL);
        }
        
        fprintf(pfLog, "\n[stCargaEventos] TR:[%d] TipComis:[%s] Periodo:[%s] --->Tabla:[%s]\n",ihCodTipoRed, szhCodTipcomis, szIdCiclComis, szTablaFisica);
        fprintf(stderr,"\n[stCargaEventos] TR:[%d] TipComis:[%s] Periodo:[%s] --->Tabla:[%s]\n",ihCodTipoRed, szhCodTipcomis, szIdCiclComis, szTablaFisica);
        sprintf(szSentenciaSql, "SELECT "
                                "A.NUM_GENERAL, "
                                "A.COD_COMISIONISTA, "
                                "A.NUM_ABONADO, "
                                "NVL(B.COD_ESTADO,'BF'), "
                                "NVL(B.COD_SITUACION,'BAA'), "
                                "C.TIP_PLAN, "
                                "A.COD_CATEGCLIENTE, "
                                "A.COD_CLIENTE,"
                                "A.COD_OFICINA "
                                "FROM %s A, "
                                "GA_ABOCEL         B, "
                                "CMD_PLANESTARIF   C "
                                "WHERE A.ID_PERIODO    	= :v1 "
                                "AND A.COD_TIPCOMIS     = :v2 "
                                "AND A.COD_TIPORED      = :v3 " 
                                "AND A.NUM_ABONADO     	= B.NUM_ABONADO (+) "
                                "AND A.COD_PLANTARIF    = C.COD_PLANTARIF "
                                "AND ((C.TIP_PLAN = :v4) OR (:v4 = 'TODAS')) ",
                                szTablaFisica);

        /* EXEC SQL PREPARE Pre_cursor FROM :szSentenciaSql; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )113;
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


        /* EXEC SQL DECLARE Cur_Eventos CURSOR for Pre_cursor ; */ 

        /* EXEC SQL OPEN Cur_Eventos using :szIdCiclComis, :szhCodTipcomis, :ihCodTipoRed, :szhCodTipPlan; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )132;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szIdCiclComis;
        sqlstm.sqhstl[0] = (unsigned long )11;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipcomis;
        sqlstm.sqhstl[1] = (unsigned long )3;
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
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipPlan;
        sqlstm.sqhstl[3] = (unsigned long )6;
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
                /* EXEC SQL for :lMaxFetch 
                        FETCH Cur_Eventos  
                        INTO    
                      		:lhNum_General     	,   
                          	:lhCod_Comisionista	,
                          	:lhNumAbonado		,  
                          	:szhCod_Estado     	, 
                          	:szhCod_Situacion  	, 
                          	:szhTip_Plan		,
                          	:szhCod_Categcliente, 
                          	:ihCod_Cliente,
                          	:szhCod_Oficina; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 9;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )lMaxFetch;
                sqlstm.offset = (unsigned int  )163;
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
                sqlstm.sqhstv[2] = (unsigned char  *)lhNumAbonado;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[2] = (         int  )sizeof(long);
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqharc[2] = (unsigned long  *)0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhCod_Estado;
                sqlstm.sqhstl[3] = (unsigned long )3;
                sqlstm.sqhsts[3] = (         int  )3;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqharc[3] = (unsigned long  *)0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Situacion;
                sqlstm.sqhstl[4] = (unsigned long )4;
                sqlstm.sqhsts[4] = (         int  )4;
                sqlstm.sqindv[4] = (         short *)0;
                sqlstm.sqinds[4] = (         int  )0;
                sqlstm.sqharm[4] = (unsigned long )0;
                sqlstm.sqharc[4] = (unsigned long  *)0;
                sqlstm.sqadto[4] = (unsigned short )0;
                sqlstm.sqtdso[4] = (unsigned short )0;
                sqlstm.sqhstv[5] = (unsigned char  *)szhTip_Plan;
                sqlstm.sqhstl[5] = (unsigned long )6;
                sqlstm.sqhsts[5] = (         int  )6;
                sqlstm.sqindv[5] = (         short *)0;
                sqlstm.sqinds[5] = (         int  )0;
                sqlstm.sqharm[5] = (unsigned long )0;
                sqlstm.sqharc[5] = (unsigned long  *)0;
                sqlstm.sqadto[5] = (unsigned short )0;
                sqlstm.sqtdso[5] = (unsigned short )0;
                sqlstm.sqhstv[6] = (unsigned char  *)szhCod_Categcliente;
                sqlstm.sqhstl[6] = (unsigned long )11;
                sqlstm.sqhsts[6] = (         int  )11;
                sqlstm.sqindv[6] = (         short *)0;
                sqlstm.sqinds[6] = (         int  )0;
                sqlstm.sqharm[6] = (unsigned long )0;
                sqlstm.sqharc[6] = (unsigned long  *)0;
                sqlstm.sqadto[6] = (unsigned short )0;
                sqlstm.sqtdso[6] = (unsigned short )0;
                sqlstm.sqhstv[7] = (unsigned char  *)ihCod_Cliente;
                sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[7] = (         int  )sizeof(long);
                sqlstm.sqindv[7] = (         short *)0;
                sqlstm.sqinds[7] = (         int  )0;
                sqlstm.sqharm[7] = (unsigned long )0;
                sqlstm.sqharc[7] = (unsigned long  *)0;
                sqlstm.sqadto[7] = (unsigned short )0;
                sqlstm.sqtdso[7] = (unsigned short )0;
                sqlstm.sqhstv[8] = (unsigned char  *)szhCod_Oficina;
                sqlstm.sqhstl[8] = (unsigned long )3;
                sqlstm.sqhsts[8] = (         int  )3;
                sqlstm.sqindv[8] = (         short *)0;
                sqlstm.sqinds[8] = (         int  )0;
                sqlstm.sqharm[8] = (unsigned long )0;
                sqlstm.sqharc[8] = (unsigned long  *)0;
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


                
                iRetrievRows 	= sqlca.sqlerrd[2] - iLastRows;
                iLastRows 		= sqlca.sqlerrd[2];
                
                for (i=0; i < iRetrievRows; i++)
                {  
	                paux = (stEvento *) malloc(sizeof(stEvento));
	                paux->lNum_General              = 	lhNum_General[i];
	                strcpy(paux->szCod_Tipcomis     , 	szhCodTipcomis);
	                paux->iCod_Comisionista         = 	lhCod_Comisionista[i];
	                paux->lNumAbonado				=	lhNumAbonado[i];
	            	paux->iCod_Cliente              = 	ihCod_Cliente[i];
	            	strcpy(paux->szTip_Plan         , 	szfnTrim(szhTip_Plan[i])); 
	            	strcpy(paux->szCod_Categcliente , 	szfnTrim(szhCod_Categcliente[i]));
	            	strcpy(paux->szCod_Estado       , 	szfnTrim(szhCod_Estado[i]));
	    			strcpy(paux->szCod_Situacion    , 	szfnTrim(szhCod_Situacion[i]));
	    			strcpy(paux->szCod_Oficina		,	szhCod_Oficina[i]);
	               	iCantidad++;
	                paux->sgte  	= qaux;                     
	                qaux            = paux;                 
                }
        }
        /* EXEC SQL CLOSE Cur_Eventos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 9;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )214;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


        fprintf(pfLog, "\n[stCargaEventos] Ventas Recuperadas:[%d]\n", iCantidad);
        fprintf(stderr,"\n[stCargaEventos] Ventas Recuperadas:[%d]\n", iCantidad);
        return (qaux);
}
/*---------------------------------------------------------------------------*/
/* FUNCION QUE RETORNA EL IMPORTE DE LA COMISION ASOCIADA (PARA PORCENTAJE)  */
/*---------------------------------------------------------------------------*/
double dGetImpComisionAsoc(stPrincipal * paux, stEvento * qaux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 
 
		int		ihCodTipoRed;
		int   	ihCodConcepto;  
		char	szhIdCiclComis[11];
		long	lhNumGeneral;
		double	dhImpComision;
		char	szTablaLogica[31];
		char	szTablaFisica[31];
		char	szSentenciaSql[1024];
		int		lhNumRegistro;
	/* EXEC SQL END DECLARE SECTION; */ 


	ihCodTipoRed 			= paux->iCodTipoRed;
	ihCodConcepto			= paux->iCod_Concepto_Asoc;
	strcpy(szhIdCiclComis 	, paux->szIdCiclComis);
	lhNumGeneral   			= qaux->lNum_General;
    strcpy(szTablaLogica	, "CMT_VALORIZADOS");        

    if (!(iBuscaTablaFisica(szTablaLogica, szhIdCiclComis, szTablaFisica)))
    {
        return 0.00;
    }
    sprintf(szSentenciaSql, "SELECT COUNT(1) FROM %s "
                            "WHERE COD_TIPORED 	= :v1 "
                            " AND  NUM_GENERAL  = :v2 "
                            " AND  COD_CONCEPTO = :v3 " 
                            " AND  ID_PERIODO	= :v4 "
                            ,szTablaFisica);
                            
                                    
    /* EXEC SQL PREPARE Pre_cursor_1 FROM :szSentenciaSql; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )229;
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



    /* EXEC SQL DECLARE Cur_Eventos_1 CURSOR for Pre_cursor_1; */ 


    /* EXEC SQL OPEN Cur_Eventos_1 using :ihCodTipoRed, :lhNumGeneral, :ihCodConcepto, :szhIdCiclComis; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )248;
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



	/* EXEC SQL FETCH Cur_Eventos_1 INTO :lhNumRegistro; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )279;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumRegistro;
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


	
	/* EXEC SQL CLOSE Cur_Eventos_1; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )298;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	
	if (lhNumRegistro == 0 )
	{
		return (0.00);
	}
	else
	{
    	sprintf(szSentenciaSql, "SELECT IMP_CONCEPTO FROM %s "
                            "WHERE COD_TIPORED 	= :v1 "
                            " AND  NUM_GENERAL  = :v2 "
                            " AND  COD_CONCEPTO = :v3 " 
                            " AND  ID_PERIODO	= :v4 "
                            ,szTablaFisica);

	    /* EXEC SQL PREPARE Pre_cursor_2 FROM :szSentenciaSql; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )313;
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


	
	    /* EXEC SQL DECLARE Cur_Eventos_2 CURSOR for Pre_cursor_2; */ 

	
	    /* EXEC SQL OPEN Cur_Eventos_2 using :ihCodTipoRed, :lhNumGeneral, :ihCodConcepto, :szhIdCiclComis; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )332;
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


	
		/* EXEC SQL FETCH Cur_Eventos_2 INTO :dhImpComision; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )363;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhImpComision;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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


		
		/* EXEC SQL CLOSE Cur_Eventos_2; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )382;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError();
}


        return(dhImpComision);
	}
}
/*---------------------------------------------------------------------------*/
/* DUPLICA EL NODO DE EVENTO PARA INSERTARLO EN LA ESTRUCTURA GENERAL.       */
/*---------------------------------------------------------------------------*/
stEvento * stDuplicaEvento(stEvento * qaux)
{
	stEvento * paux;

	paux = (stEvento *) malloc(sizeof(stEvento));
	
    paux->lNum_General              = qaux->lNum_General; 	
    strcpy(paux->szCod_Tipcomis     , qaux->szCod_Tipcomis); 	
    paux->iCod_Comisionista         = qaux->iCod_Comisionista; 	
    paux->lNumAbonado         		= qaux->lNumAbonado; 	
	paux->iCod_Cliente              = qaux->iCod_Cliente; 	
	strcpy(paux->szTip_Plan         , qaux->szTip_Plan); 	
	strcpy(paux->szCod_Categcliente , qaux->szCod_Categcliente); 	
	strcpy(paux->szCod_Estado       , qaux->szCod_Estado); 	
	strcpy(paux->szCod_Situacion    , qaux->szCod_Situacion); 	
	strcpy(paux->szCod_Oficina		, qaux->szCod_Oficina);
	paux->sgte = NULL;
	
	return paux;
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE EJECUTA EL CALCULO DE LA COMISION DE LOS EVENTOS (qaux) */
/* EN BASE A LO CONFIGURADO EN EL TASADOR (paux).                            */
/*---------------------------------------------------------------------------*/
void vCalculaComision(stPrincipal * paux, stEvento * saux)
{
	stEvento * raux;
	stEvento * qaux;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    double  dhComision ;
	    double  dhPorcentaje;
	    double  dhComisionAsoc;
	    int     ihConsidera;
	    char	szhIdCiclComis[11];
	/* EXEC SQL END DECLARE SECTION; */ 

	

	for (qaux = saux; qaux != NULL; qaux = qaux->sgte)
	{

		fprintf(pfLog, "\n[vCalculaComision] Analiza Evento:[%ld] TPlan:[%s] CatCte.:[%s] Estado:[%s] Situac:[%s]\n", qaux->lNum_General, qaux->szTip_Plan, qaux->szCod_Categcliente, qaux->szCod_Estado, qaux->szCod_Situacion);  
/*		fprintf(stderr,"\n[vCalculaComision] Analiza Evento:[%ld] TPlan:[%s] CatCte.:[%s] Estado:[%s] Situac:[%s]\n", qaux->lNum_General, qaux->szTip_Plan, qaux->szCod_Categcliente, qaux->szCod_Estado, qaux->szCod_Situacion);  */

		ihConsidera = TRUE;
		/* verificamos que sea un cliente activo */
		if ((strcmp(qaux->szCod_Situacion ,"BAA") != 0) && 
			(strcmp(qaux->szCod_Situacion ,"BAP") != 0) &&
			(strcmp(qaux->szCod_Estado    ,"CO")  == 0))
		{   
			if (strcmp(paux->szInd_Saldo,"S") == 0 )  /* verificamos su estado de saldo 0  */
			{                        
				if (!bfnEstadoSaldo(qaux->iCod_Cliente, qaux->lNumAbonado))
				{
	            	fprintf(pfLog, "\nn[vCalculaComision] Cliente:[%d] Abonado [%ld] Posee Saldo en Mora. No se Comisiona.\n",qaux->iCod_Cliente,  qaux->lNumAbonado);  
/*	            	fprintf(stderr,"\nn[vCalculaComision] Cliente:[%d] Abonado [%ld] Posee Saldo en Mora. No se Comisiona.\n",qaux->iCod_Cliente,  qaux->lNumAbonado);  */
	            	ihConsidera = FALSE;
	            }
			}
		}
		else
		{
        	fprintf(pfLog, "\nn[vCalculaComision] Abonado [%ld] no se encuentra ACTIVO. No se Comisiona.\n", qaux->lNumAbonado);  
/*        	fprintf(stderr,"\nn[vCalculaComision] Abonado [%ld] no se encuentra ACTIVO. No se Comisiona.\n", qaux->lNumAbonado);  */
        	ihConsidera = FALSE;
        }

	    if (ihConsidera==TRUE)
	    {
			if (strcmp(paux->szTip_Bonificacion, "M") == 0)
			{ 
				dhComision = paux->dImp_Bonificacion ;
			}          
			else
			{                    
				dhComisionAsoc = dGetImpComisionAsoc(paux, qaux);
				dhComision = (paux->dImp_Bonificacion * dhComisionAsoc) / 100.00 ;
			}
		}
		else
		{
			dhComision = 0.00;
		}
		raux = stDuplicaEvento(qaux);
		raux->dImp_Comision = dhComision;
		
		raux->sgte = paux->sgte_evento;
		paux->sgte_evento = raux;
 	    fprintf(pfLog, "\n[vCalculaComision] Comision Asociada:[%7.2f] Evento:[%ld]\n", raux->dImp_Comision, raux->lNum_General);  
		raux = NULL;

    }
}

/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE INICIA LA VALORACION DE LISTAS                          */
/* 1.- RECORRE LA LISTA PRINCIPAL                                            */
/* 2.- CALCULA EL PERIODO SOBRE EL QUE RECOLECTARA LAS EVENTOS               */
/* 3.- MANDA A CREAR LA LISTA DE EVENTOS...                                  */
/* 4.- CALCULA LA COMISION SOBRE LA LISTA DE EVENTOS.                                           */
/*---------------------------------------------------------------------------*/
void bfnEvaluaPermanencia()
{
        stPrincipal 	* paux;
        stEvento        * qaux;
        
        long            lCodPeriodo;
        char            szTablaLogica[30];
        char            szTablaFisica[30];
        char			szIdCiclComis[11];
        int             iNumPeriodos;
        long			lhCodPeriodo;
        
        for(paux=lstPrincipal; paux!=NULL; paux=paux->sgte)
        {
	    		lCodPeriodo = lNewCiclComis(stCiclo.lCodCiclComis, paux->iNum_Periodos * -1);
	    		strcpy(paux->szIdCiclComis 	, 	szNewCiclComis(lCodPeriodo));
				
                fprintf(pfLog, "\n(bfnEvaluaPermanencia)Procesa Permanencia Periodo:[%s] Tr:[%d] PlComis:[%s] Conc:[%d] TipComis:[%s]...\n",paux->szIdCiclComis, paux->iCodTipoRed, paux->szCodPlanComis, paux->iCod_Concepto, paux->szCod_Tipcomis);
                fprintf(stderr, "\n(bfnEvaluaPermanencia)Procesa Permanencia Periodo:[%s] Tr:[%d] PlComis:[%s] Conc:[%d] TipComis:[%s]...\n",paux->szIdCiclComis, paux->iCodTipoRed, paux->szCodPlanComis, paux->iCod_Concepto, paux->szCod_Tipcomis);
                qaux = stCargaEventos(paux->szCod_Tipcomis,paux->szTip_Plan, paux->iCodTipoRed, paux->szCodPlanComis, paux->iCod_Concepto,paux->szIdCiclComis);
                
                if (qaux!= NULL)
                {
                        fprintf(pfLog, "\n(bfnEvaluaPermanencia)Asigna la comisión a la lista de eventos.\n");
                        fprintf(stderr, "\n(bfnEvaluaPermanencia)Asigna la comisión a la lista de eventos.\n");
                        vCalculaComision(paux,qaux);
                }
                fprintf(pfLog, "\n(bfnEvaluaPermanencia)Libera Eventos Seleccionados...\n");
                fprintf(stderr,"\n(bfnEvaluaPermanencia)Libera Eventos Seleccionados...\n");
                vLiberaEvento(qaux);
        }
}

/*-----------------------------------------------------------------------------*/
/* INSERTA  REGISTROS EN LA TABLA CMT_VALORIZADOS                              */
/*-----------------------------------------------------------------------------*/
void bfnInsertaValorizados()
{
    stPrincipal    * pPrincipal;
    stEvento       * pEvento;
    int                    i;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

            int		ihCodTipoRed;
            long    lhNumGeneral;
            char    szhCodUniverso[7];
            int     ihCodConcepto;
            char    szhCodTipComis[3];
            long    lhCodComisionista;
            long    lhCodPeriodo;
            char    szhIdPeriodo[11];
            double  dhImpConcepto;                
    /* EXEC SQL END DECLARE SECTION; */ 
   
    i = 0;
            
    strcpy(szhIdPeriodo    , stCiclo.szIdCiclComis);        
    lhCodPeriodo           = stCiclo.lCodCiclComis;     
                
    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
    {       
        strcpy(szhCodTipComis   , 	pPrincipal->szCod_Tipcomis);                        
        ihCodConcepto          	= 	pPrincipal->iCod_Concepto;
        strcpy(szhCodUniverso	,	pPrincipal->szCodUniverso);
		ihCodTipoRed			=	pPrincipal->iCodTipoRed;
        for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
        {
            lhNumGeneral      	= 	pEvento->lNum_General;
            lhCodComisionista 	= 	pEvento->iCod_Comisionista;
            dhImpConcepto     	= 	fnCnvDouble(pEvento->dImp_Comision, 0);
            i++;

			fprintf(pfLog, "\n+++++++++++++++++++++++++++[%d]+++++++++++++\n", i);
			fprintf(pfLog, "[bfnInsertaValorizados] ihCodTipoRed     [%d]\n",pPrincipal->iCodTipoRed);                    
			fprintf(pfLog, "[bfnInsertaValorizados] lhNumGeneral     [%d]\n",pEvento->lNum_General);
			fprintf(pfLog, "[bfnInsertaValorizados] szhCodUniverso   [%s]\n",pPrincipal->szCodUniverso);
			fprintf(pfLog, "[bfnInsertaValorizados] ihCodConcepto    [%d]\n",pPrincipal->iCod_Concepto);
			fprintf(pfLog, "[bfnInsertaValorizados] szhCodTipComis   [%s]\n",pPrincipal->szCod_Tipcomis);
			fprintf(pfLog, "[bfnInsertaValorizados] lhCodComisionista[%d]\n",pEvento->iCod_Comisionista);
			fprintf(pfLog, "[bfnInsertaValorizados] lhCodPeriodo     [%d]\n",stCiclo.lCodCiclComis);
			fprintf(pfLog, "[bfnInsertaValorizados] szhIdPeriodo     [%s]\n",stCiclo.szIdCiclComis);
			fprintf(pfLog, "[bfnInsertaValorizados] dhImpConcepto    [%7.2f]\n",pEvento->dImp_Comision);
           
            /* EXEC SQL INSERT INTO CMT_VALORIZADOS
                ( 	COD_TIPORED,
                	NUM_GENERAL,  
                  	COD_UNIVERSO,
                  	COD_CONCEPTO,
                  	COD_TIPCOMIS,
                  	COD_COMISIONISTA,
                  	COD_PERIODO, 
                  	ID_PERIODO, 
                  	IMP_CONCEPTO)
                VALUES
                 	(:ihCodTipoRed,
                 	:lhNumGeneral,
                  	:szhCodUniverso,
                  	:ihCodConcepto,
                  	:szhCodTipComis,
                  	:lhCodComisionista,
                  	:lhCodPeriodo,
                  	:szhIdPeriodo,
                  	:dhImpConcepto); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 9;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into CMT_VALORIZADOS (COD_TIPORED,NUM_GENE\
RAL,COD_UNIVERSO,COD_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PER\
IODO,IMP_CONCEPTO) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )397;
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
            sqlstm.sqhstv[2] = (unsigned char  *)szhCodUniverso;
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
            sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipComis;
            sqlstm.sqhstl[4] = (unsigned long )3;
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
            sqlstm.sqhstv[6] = (unsigned char  *)&lhCodPeriodo;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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


        }                                                                                
    }
    stStatusProc.lCantRegistros = i;        
}
      
/*---------------------------------------------------------------------------*/
/* RUTINA PRINCIPAL.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
        long  lSegIni, lSegFin;
        short ibiblio;
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));
    memset(&stCiclo, 0, sizeof(reg_ciclo));
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
    memset(&proceso, 0, sizeof(proceso));
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
        sqlstm.offset = (unsigned int  )448;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/* PROCESAMIENTO PRINCIPAL.                                                  */
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
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());                      
        fprintf(pfLog,  "Carga estructura principal de valoración...\n\n");       
        fprintf(stderr,  "Carga estructura principal de valoración...\n\n");  
        bfnLlenaTasador(); 
/*---------------------------------------------------------------------------*/
/* EJECUTA VALORACION DE EVENTOS POR CONCEPTOS DE PERMANENCIA                */
/*---------------------------------------------------------------------------*/
        vFechaHora();                                                                                   
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());                      
        fprintf(pfLog,  "Ejecuta valoracion de eventos por conceptos de permanencia...\n\n");       
        fprintf(stderr,  "Ejecuta valoracion de eventos por conceptos de permanencia...\n\n");  
        bfnEvaluaPermanencia(); 
/*---------------------------------------------------------------------------*/
/* GRABA RESULTADOS EN CMT_VALORIZADOS                                       */
/*---------------------------------------------------------------------------*/
        vFechaHora();                                                                                   
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());                      
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());          
        fprintf(pfLog,  "Graba resultados en cmt_valorizados...\n\n");
        fprintf(stderr, "Graba resultados en cmt_valorizados...\n\n");
        bfnInsertaValorizados(); 
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LISTA PRINCIPAL                              */
/*---------------------------------------------------------------------------*/
        vFechaHora();                                                                   
        fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());      
        fprintf(pfLog, "Libera memoria utilizada por lista Principal...(vLiberaPrincipal)\n\n");
        fprintf(stderr, "Libera memoria utilizada por lista Principal...(vLiberaPrincipal)\n\n");
        vLiberaPrincipal(lstPrincipal);
/*---------------------------------------------------------------------------*/
/*    - LIBERA MEMORIA UTILIZADA POR LISTAS DE CONCEPTOS.                    */
/*---------------------------------------------------------------------------*/
        
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
        fprintf(stderr, "Libera memoria utilizada por listas de Conceptos...(vLiberaConceptosVal)\n\n");
        vLiberaConceptosVal(lstConceptos);
/*---------------------------------------------------------------------------*/
/* RECUPERACION DE LOS SEGUNDOS REALES OCUPADOS POR EL PROCESO.              */
/*---------------------------------------------------------------------------*/
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
        sqlstm.offset = (unsigned int  )463;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
        fprintf(pfLog,  "\nEstadistica del proceso\n");
        fprintf(pfLog,  "------------------------\n");
        fprintf(pfLog,  "Segundos Reales Utilizados             : [%d]\n", stStatusProc.lSegProceso);
        fprintf(pfLog,  "Cantidad Registros Porcesados          : [%d]\n",stStatusProc.lCantRegistros);
    fprintf(pfLog , "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
    fprintf(stderr, "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));

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

