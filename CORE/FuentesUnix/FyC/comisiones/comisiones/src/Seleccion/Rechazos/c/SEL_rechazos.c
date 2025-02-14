
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
    "./pc/SEL_rechazos.pc"
};


static unsigned int sqlctx = 55440803;


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
   unsigned char  *sqhstv[24];
   unsigned long  sqhstl[24];
            int   sqhsts[24];
            short *sqindv[24];
            int   sqinds[24];
   unsigned long  sqharm[24];
   unsigned long  *sqharc[24];
   unsigned short  sqadto[24];
   unsigned short  sqtdso[24];
} sqlstm = {12,24};

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
"select S.NUM_VENTA ,S.NUM_ABONADO ,S.COD_VEND_FINAL ,S.COD_CLIENTE ,S.NUM_CE\
LULAR ,S.NUM_CONTRATO ,S.NUM_SERIE ,S.COD_COMISIONISTA ,S.COD_AGENCIA ,TO_CHAR\
(S.FEC_VENTA,'DD-MM-YYYY HH24:MI:SS') ,TO_CHAR(S.FEC_RECEPCION,'DD-MM-YYYY HH2\
4:MI:SS') ,TO_CHAR(S.FEC_RECHAZO,'DD-MM-YYYY HH24:MI:SS') ,S.COD_CAUSAREC ,CLI\
.NUM_IDENT ,CLI.COD_CATEGORIA ,CATRI.COD_CATRIBUT ,S.IND_PROCEQUI ,S.NOM_USUAR\
IO  from GAT_RECHAZOS S ,GE_CLIENTES CLI ,GA_CATRIBUTCLIE CATRI where ((((((S.\
NUM_VENTA>0 and S.COD_TIPCOMIS=:b0) and S.FEC_RECHAZO>TO_DATE(:b1,'DD-MM-YYYY'\
)) and S.FEC_RECHAZO<=TO_DATE(:b2,'DD-MM-YYYY')) and CLI.COD_CLIENTE=S.COD_CLI\
ENTE) and CLI.COD_CLIENTE=CATRI.COD_CLIENTE) and CATRI.FEC_DESDE=(select max(E\
.FEC_DESDE)  from GA_CATRIBUTCLIE E where CATRI.COD_CLIENTE=E.COD_CLIENTE))   \
        ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,786,0,9,192,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,
32,0,0,1,0,0,13,195,0,0,18,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,
3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
119,0,0,1,0,0,15,256,0,0,0,0,0,1,0,
134,0,0,2,68,0,4,278,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
157,0,0,3,67,0,4,285,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
180,0,0,4,54,0,4,390,0,0,1,0,0,1,0,2,3,0,0,
199,0,0,5,560,0,3,393,0,0,24,24,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1,97,0,0,
310,0,0,6,48,0,1,534,0,0,0,0,0,1,0,
325,0,0,7,0,0,30,581,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de poblar tabla cmt_rechazos_celular              */ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 01.                                             */
/* Inicio: Martes 09 de Octubre del 2001.                               */
/* Fin   : Miercoles 10 de Octubre del 2001.                            */
/* Por Richard Troncoso C.                                              */
/* Inicio: Miercoles 13 de Noviembre del 2002                           */
/* Fin:                                                                 */
/* Autor:  Christian Descouvieres Vargas                                */
/* Modificacion: Se modifico el Num_serie de largo 12 a 26              */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla       */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y     */
/* COD_PARAMETRO.                                                       */
/* Modificacion por Jaime Vargas  (enero-7-2003)                        */
/* Descripcion : se modifico estructura  para multinivel                */                 
/************************************************************************/
/* 20030924 Marcelo Quiroz Garcia Versionado Cuzco.                     */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorporan: Planes de Comisiones y Tipos de Ciclos                */
/* Se incorpra manejo de lista general de tipos de comisionistas.       */
/* Se restructura proceso en función de estructura de tipos de          */
/* comisionistas.                                                       */
/*                                                                      */
/************************************************************************/

#include "SEL_rechazos.h"
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
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Lista de Tipos de Comisionistas para ejecucion de ciclo                   */
/*---------------------------------------------------------------------------*/
	stTiposComis * lstTiposComis = NULL;
/*---------------------------------------------------------------------------*/
/* Tipos de Comisionistas para el proceso.                                   */
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
		fprintf(pfLog ,"\n(vCargaTiposComis) Evalua Rescate de Rechazos de Venta\n");
		fprintf(stderr,"\n(vCargaTiposComis) Evalua Rescate de Rechazos de Venta\n");
		vGetPlan();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		vInsertaSeleccion();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Libera la memori utilizada.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Libera la memori utilizada.\n");
		vLiberaUniverso();
		vLiberaTiposComis(lstTiposComis);
	}
}

/* -------------------------------------------------------------------------------------- */
/* Se extrae el universo DIRECTO inicial de registros a considerar para Comisiones.       */
/* -------------------------------------------------------------------------------------- */
void vSeleccionarUniverso(int piCodTipoRed, char * pszCodTipComis, char * pszCodTipVendedor)
{
    stUniverso 	* paux;
    long    	iCantidad = 0;

	int                            i;
	long            iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    char    szhFechaInicio[11];
	    char    szhFechaTermino[11];
	    long    lMaxFetch;

		int		ihCodTipoRed;
		char	szhCodTipVendedor[3];
		long    lhNumVenta[MAXFETCH];
        long    lhNumAbonado[MAXFETCH];
		char    szhCodTipComis[3];
        long    lhCodVendFinal[MAXFETCH];
        short   shIndCodVendFinal[MAXFETCH];
        long    lhCodCliente[MAXFETCH];
        long    lhNumCelular[MAXFETCH];
        char    szhNumContrato[MAXFETCH][20];
        short   shIdNumContrato[MAXFETCH];
        char    chNumSerie[MAXFETCH][26];
        long    lhCodComisionista[MAXFETCH];
        long    lhCodAgencia[MAXFETCH];
   	    char    szhFecVenta[MAXFETCH][20];
	    char    szhFecRecepcion[MAXFETCH][20];
        short   shIndFecRecepcion[MAXFETCH];
	    char    szhFecRechazo[MAXFETCH][20];
        char    szhCodCausaRec[MAXFETCH][3];
        char    szhNumIdent[MAXFETCH][21];
        long    lhCodCategoria[MAXFETCH];
        short   shIndCodCategoria[MAXFETCH];
        char    szhCodCatribut[MAXFETCH][2];
        char    szhIndProcequi[MAXFETCH][2];
        char    szhNomUsuario[MAXFETCH][31];                
    /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy(szhFechaInicio           , stCiclo.szFecDesdeNormal);  
    strcpy(szhFechaTermino          , stCiclo.szFecHastaNormal);  
    strcpy(szhCodTipComis			, pszCodTipComis);    
    ihCodTipoRed					= piCodTipoRed;
    strcpy(szhCodTipVendedor		, pszCodTipVendedor);
    
    paux      = NULL;
	lMaxFetch = MAXFETCH;	

    /* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR
          SELECT  S.NUM_VENTA,
                  S.NUM_ABONADO,
                  S.COD_VEND_FINAL,
                  S.COD_CLIENTE,
                  S.NUM_CELULAR,
                  S.NUM_CONTRATO,
                  S.NUM_SERIE,
                  S.COD_COMISIONISTA,
                  S.COD_AGENCIA,
                  TO_CHAR(S.FEC_VENTA,'DD-MM-YYYY HH24:MI:SS'),
                  TO_CHAR(S.FEC_RECEPCION,'DD-MM-YYYY HH24:MI:SS'),
                  TO_CHAR(S.FEC_RECHAZO,'DD-MM-YYYY HH24:MI:SS'),
                  S.COD_CAUSAREC,
                  CLI.NUM_IDENT,
                  CLI.COD_CATEGORIA,
                  CATRI.COD_CATRIBUT,
                  S.IND_PROCEQUI,
                  S.NOM_USUARIO
          FROM    GAT_RECHAZOS S, 
                  GE_CLIENTES CLI, 
                  GA_CATRIBUTCLIE CATRI
          WHERE   S.NUM_VENTA             >  0 
            AND   S.COD_TIPCOMIS          =  :szhCodTipVendedor  
            AND   S.FEC_RECHAZO           >  TO_DATE(:szhFechaInicio,'DD-MM-YYYY')
            AND   S.FEC_RECHAZO           <= TO_DATE(:szhFechaTermino,'DD-MM-YYYY')
            AND   CLI.COD_CLIENTE         =  S.COD_CLIENTE
            AND   CLI.COD_CLIENTE         =  CATRI.COD_CLIENTE
            AND   CATRI.FEC_DESDE         =  (SELECT MAX(E.FEC_DESDE)
                                              FROM   GA_CATRIBUTCLIE E
                                              WHERE  CATRI.COD_CLIENTE = E.COD_CLIENTE); */ 

	                                               
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
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipVendedor;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFechaInicio;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFechaTermino;
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
                  FETCH CUR_UNIVERSO INTO
                        :lhNumVenta,                        
                        :lhNumAbonado,                      
                        :lhCodVendFinal:shIndCodVendFinal,  
                        :lhCodCliente,                      
                        :lhNumCelular,                      
                        :szhNumContrato:shIdNumContrato,    
                        :chNumSerie,                        
                        :lhCodComisionista,                 
                        :lhCodAgencia,                      
                        :szhFecVenta,                       
                        :szhFecRecepcion:shIndFecRecepcion, 
                        :szhFecRechazo,                     
                        :szhCodCausaRec,                    
                        :szhNumIdent,                       
                        :lhCodCategoria,                    
						:szhCodCatribut,                    
                        :szhIndProcequi,                    
                        :szhNomUsuario; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 18;
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
   sqlstm.sqhstv[0] = (unsigned char  *)lhNumVenta;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)lhNumAbonado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )sizeof(long);
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)lhCodVendFinal;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )sizeof(long);
   sqlstm.sqindv[2] = (         short *)shIndCodVendFinal;
   sqlstm.sqinds[2] = (         int  )sizeof(short);
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
   sqlstm.sqhstv[4] = (unsigned char  *)lhNumCelular;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )sizeof(long);
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhNumContrato;
   sqlstm.sqhstl[5] = (unsigned long )20;
   sqlstm.sqhsts[5] = (         int  )20;
   sqlstm.sqindv[5] = (         short *)shIdNumContrato;
   sqlstm.sqinds[5] = (         int  )sizeof(short);
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)chNumSerie;
   sqlstm.sqhstl[6] = (unsigned long )26;
   sqlstm.sqhsts[6] = (         int  )26;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqharc[6] = (unsigned long  *)0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)lhCodComisionista;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )sizeof(long);
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqharc[7] = (unsigned long  *)0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)lhCodAgencia;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )sizeof(long);
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqharc[8] = (unsigned long  *)0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhFecVenta;
   sqlstm.sqhstl[9] = (unsigned long )20;
   sqlstm.sqhsts[9] = (         int  )20;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqharc[9] = (unsigned long  *)0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhFecRecepcion;
   sqlstm.sqhstl[10] = (unsigned long )20;
   sqlstm.sqhsts[10] = (         int  )20;
   sqlstm.sqindv[10] = (         short *)shIndFecRecepcion;
   sqlstm.sqinds[10] = (         int  )sizeof(short);
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqharc[10] = (unsigned long  *)0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhFecRechazo;
   sqlstm.sqhstl[11] = (unsigned long )20;
   sqlstm.sqhsts[11] = (         int  )20;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqharc[11] = (unsigned long  *)0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhCodCausaRec;
   sqlstm.sqhstl[12] = (unsigned long )3;
   sqlstm.sqhsts[12] = (         int  )3;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqharc[12] = (unsigned long  *)0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhNumIdent;
   sqlstm.sqhstl[13] = (unsigned long )21;
   sqlstm.sqhsts[13] = (         int  )21;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqharc[13] = (unsigned long  *)0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)lhCodCategoria;
   sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[14] = (         int  )sizeof(long);
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqharc[14] = (unsigned long  *)0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhCodCatribut;
   sqlstm.sqhstl[15] = (unsigned long )2;
   sqlstm.sqhsts[15] = (         int  )2;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqharc[15] = (unsigned long  *)0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhIndProcequi;
   sqlstm.sqhstl[16] = (unsigned long )2;
   sqlstm.sqhsts[16] = (         int  )2;
   sqlstm.sqindv[16] = (         short *)0;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqharc[16] = (unsigned long  *)0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhNomUsuario;
   sqlstm.sqhstl[17] = (unsigned long )31;
   sqlstm.sqhsts[17] = (         int  )31;
   sqlstm.sqindv[17] = (         short *)0;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqharc[17] = (unsigned long  *)0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
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
                 
                paux->iCodTipoRed     			= ihCodTipoRed;
				strcpy(paux->szCodTipComis      , szhCodTipComis);
				strcpy(paux->szCodTipVendedor   , szhCodTipVendedor);
				paux->lNumVenta        			= lhNumVenta[i];
				paux->lNumAbonado     			= lhNumAbonado[i];
                paux->lCodVendFinal             = lhCodVendFinal[i];
                paux->sIndCodVendFinal          = shIndCodVendFinal[i];
				paux->lCodCliente      			= lhCodCliente[i];
                paux->lNumCelular               = lhNumCelular[i];
				strcpy(paux->szNumContrato      , szfnTrim(szhNumContrato[i]));
                paux->sIdNumContrato            = shIdNumContrato[i];
                strcpy(paux->cNumSerie          , szfnTrim(chNumSerie[i]));
				paux->lCodComisionista			= lhCodComisionista[i];
                paux->lCodAgencia               = lhCodAgencia[i];
				strcpy(paux->szFecVenta       	, szfnTrim(szhFecVenta[i]));
				strcpy(paux->szFecRecepcion   	, szfnTrim(szhFecRecepcion[i]));
                paux->sIndFecRecepcion          = shIndFecRecepcion[i];
                strcpy(paux->szFecRechazo       , szfnTrim(szhFecRechazo[i]));
                strcpy(paux->szCodCausaRec      , szfnTrim(szhCodCausaRec[i]));
                strcpy(paux->szNumIdent         , szhNumIdent[i]);
                paux->lCodCategoria             = lhCodCategoria[i];
                strcpy(paux->szCodCatribut      , szhCodCatribut[i]);
                strcpy(paux->szIndProcequi      , szhIndProcequi[i]);
                strcpy(paux->szNomUsuario       , szhNomUsuario[i]);

                paux->cIndConsidera				= 'S';

                paux->abonado_sgte 				= NULL;
                paux->sgte 						= lstUniverso;
                lstUniverso 					= paux;
                iCantidad++;
			}
        }
        /* EXEC SQL close cur_universo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 18;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )119;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


        fprintf(pfLog, "\n(vSeleccionarUniverso)Tipo Comisionista:[%s] Cantidad de Rechazos Extraidos:[%ld].\n", szhCodTipComis, iCantidad);
}

/* **************************************************************************** */
/* Se asigna el plantarif desde tabla de abonados.                              */
/* **************************************************************************** */
void vGetPlan()
{
    stUniverso	* paux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhCodPlanTarif[4]; 
	    long    lhNumAbonado;
    /* EXEC SQL END DECLARE SECTION; */ 


    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
        if (paux->cIndConsidera == 'S')
        {
          lhNumAbonado      	= paux->lNumAbonado;
 
          /* EXEC SQL SELECT COD_PLANTARIF
                   INTO   :szhCodPlanTarif
                   FROM   GA_HABOCEL
                   WHERE  NUM_ABONADO = :lhNumAbonado; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 18;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "select COD_PLANTARIF into :b0  from GA_HABOCEL wher\
e NUM_ABONADO=:b1";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )134;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
          sqlstm.sqhstl[0] = (unsigned long )4;
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



          if (sqlca.sqlcode)
          {
             /* EXEC SQL SELECT COD_PLANTARIF
                      INTO   :szhCodPlanTarif
                      FROM   GA_ABOCEL
                      WHERE  NUM_ABONADO = :lhNumAbonado; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 18;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "select COD_PLANTARIF into :b0  from GA_ABOCEL wh\
ere NUM_ABONADO=:b1";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )157;
             sqlstm.selerr = (unsigned short)1;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
             sqlstm.sqhstl[0] = (unsigned long )4;
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


        
             if (sqlca.sqlcode)
             {
                 paux->cIndConsidera = 'N';
             }
             else
             {
                 strcpy(paux->szCodPlanTarif, szhCodPlanTarif);
             }
          }
          else
          {
             strcpy(paux->szCodPlanTarif, szhCodPlanTarif);
          }
		}          
    }
}
/*****************************************************************************/
/* Obtencion de la Categoria Asociada al Cliente                             */
/*****************************************************************************/
char * vGet_Categoria(char * catribut)
{
    if (strcmp(catribut, "B")==0)
        return INDIVIDUAL;
    else
        return PYME;
}
/*****************************************************************************/
/* Insercion de valores en tabla de salida                                   */
/*****************************************************************************/
void vInsertaSeleccion()
{
    stUniverso	* paux;
	long		lCantRechazos = 0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumSecuencia;
		char	szhCodTipComis[3];
		long	lhCodComisionista;
        long    lhCodAgencia;
		long  	lhCodCliente;
		char  	szhNumContrato[20];      
		long  	lhNumAbonado;
		long  	lhNumCelular;
		long  	lhNumVenta;
		char  	szhFecVenta[20];
		char  	szhFecRecepcion[20];
	    char    szhFecRechazo[20];
        char    szhCodCausaRec[3];
		char  	szhNumSerie[26];
		long	lhCodCiclComis;	
		char	szhIdCiclComis[11];
        long    lhCodVendFinal;		
        short   shIndCodVendFinal;
        char    szhNumIdent[21];
        char    szhCodCategoria[11];
        char    szhIndProcequi[2];
        char    szhNomUsuario[31];                
	    int		ihCodTipoRed;
		char	szhCodTipVendedor[3];
        char    szhCodPlanTarif[4]; 		
	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhCodCiclComis 			= stCiclo.lCodCiclComis;
    strcpy(szhIdCiclComis	, stCiclo.szIdCiclComis);
  
    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
    	if (paux->cIndConsidera == 'S')
        {
		   strcpy(szhCodTipComis      	, paux->szCodTipComis);
		   lhCodComisionista    		= paux->lCodComisionista;   
           lhCodAgencia                 = paux->lCodAgencia;
		   lhCodCliente        		    = paux->lCodCliente;  	
		   lhNumAbonado    			    = paux->lNumAbonado;
		   lhNumCelular    			    = paux->lNumCelular;
		   lhNumVenta          		    = paux->lNumVenta;
		   strcpy(szhFecVenta         	, paux->szFecVenta);		  		   
		   strcpy(szhFecRecepcion    	, paux->szFecRecepcion); 
		   strcpy(szhFecRechazo      	, paux->szFecRechazo); 
           strcpy(szhCodCausaRec        , paux->szCodCausaRec);
		   strcpy(szhNumSerie     		, paux->cNumSerie);
           shIndCodVendFinal            = paux->sIndCodVendFinal;
		   strcpy(szhNumIdent       	, paux->szNumIdent); 
           strcpy(szhCodCategoria       , vGet_Categoria(paux->szCodCatribut));
		   strcpy(szhCodPlanTarif 		, paux->szCodPlanTarif);
		   strcpy(szhIndProcequi   		, paux->szIndProcequi);
           strcpy(szhNomUsuario         , paux->szNomUsuario);
           ihCodTipoRed        		    = paux->iCodTipoRed;  
		   strcpy(szhCodTipVendedor   	, paux->szCodTipVendedor);

		   if (paux->sIndCodVendFinal != -1)
               strcpy(szhNumContrato, paux->szNumContrato);
           else
               strcpy(szhNumContrato,"0");
           
           if (paux->sIndFecRecepcion != -1)
               strcpy(szhFecRecepcion, paux->szFecRecepcion);
           else
               strcpy(szhFecRecepcion, paux->szFecRechazo);

           /* EXEC SQL SELECT CMS_REG_SELECCION.NEXTVAL INTO :lhNumSecuencia FROM DUAL; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 18;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b0  from D\
UAL ";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )180;
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


           lCantRechazos++;

           /* EXEC SQL INSERT INTO CMT_RECHAZOS_CELULAR(
                           NUM_GENERAL     , COD_TIPCOMIS  , COD_COMISIONISTA, 
                           COD_AGENCIA     , COD_CLIENTE   , NUM_CONTRATO    , 
                           NUM_ABONADO     , NUM_CELULAR   , NUM_VENTA       , 
                           FEC_VENTA       , 
                           FEC_RECEPCION   , 
                           FEC_RECHAZO     , 
                           COD_CAUSAREC    , NUM_SERIE     , COD_PERIODO     , 
                           ID_PERIODO      ,
                           COD_VEND_FINAL  , 
                           NUM_IDENT       , COD_CATEGCLIENTE, COD_PLANTARIF ,
                           IND_PROCEQUI    , NOM_USUARIO     , COD_TIPORED   , 
                           COD_TIPVENDEDOR )
                   VALUES ( 
                           :lhNumSecuencia, :szhCodTipComis , :lhCodComisionista,
                           :lhCodAgencia  , :lhCodCliente   , :szhNumContrato   ,
                           :lhNumAbonado  , :lhNumCelular   , :lhNumVenta       ,
                           to_date(:szhFecVenta, 'dd-mm-yyyy hh24:mi:ss')       , 
                           to_date(:szhFecRecepcion, 'dd-mm-yyyy hh24:mi:ss')   ,
                           to_date(:szhFecRechazo, 'dd-mm-yyyy hh24:mi:ss')     ,
                           :szhCodCausaRec, :szhNumSerie    , :lhCodCiclComis   ,
                           :szhIdCiclComis,
                           :lhCodVendFinal:shIndCodVendFinal, 
                           :szhNumIdent   , :szhCodCategoria, :szhCodPlanTarif  ,
                           :szhIndProcequi, :szhNomUsuario  , :ihCodTipoRed	    ,
                           :szhCodTipVendedor ); */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 24;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "insert into CMT_RECHAZOS_CELULAR (NUM_GENERAL,COD_\
TIPCOMIS,COD_COMISIONISTA,COD_AGENCIA,COD_CLIENTE,NUM_CONTRATO,NUM_ABONADO,NUM\
_CELULAR,NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_RECHAZO,COD_CAUSAREC,NUM_SERIE,\
COD_PERIODO,ID_PERIODO,COD_VEND_FINAL,NUM_IDENT,COD_CATEGCLIENTE,COD_PLANTARIF\
,IND_PROCEQUI,NOM_USUARIO,COD_TIPORED,COD_TIPVENDEDOR) values (:b0,:b1,:b2,:b3\
,:b4,:b5,:b6,:b7,:b8,to_date(:b9,'dd-mm-yyyy hh24:mi:ss'),to_date(:b10,'dd-mm-\
yyyy hh24:mi:ss'),to_date(:b11,'dd-mm-yyyy hh24:mi:ss'),:b12,:b13,:b14,:b15,:b\
16:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b24)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )199;
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
           sqlstm.sqhstv[5] = (unsigned char  *)szhNumContrato;
           sqlstm.sqhstl[5] = (unsigned long )20;
           sqlstm.sqhsts[5] = (         int  )0;
           sqlstm.sqindv[5] = (         short *)0;
           sqlstm.sqinds[5] = (         int  )0;
           sqlstm.sqharm[5] = (unsigned long )0;
           sqlstm.sqadto[5] = (unsigned short )0;
           sqlstm.sqtdso[5] = (unsigned short )0;
           sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
           sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[6] = (         int  )0;
           sqlstm.sqindv[6] = (         short *)0;
           sqlstm.sqinds[6] = (         int  )0;
           sqlstm.sqharm[6] = (unsigned long )0;
           sqlstm.sqadto[6] = (unsigned short )0;
           sqlstm.sqtdso[6] = (unsigned short )0;
           sqlstm.sqhstv[7] = (unsigned char  *)&lhNumCelular;
           sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[7] = (         int  )0;
           sqlstm.sqindv[7] = (         short *)0;
           sqlstm.sqinds[7] = (         int  )0;
           sqlstm.sqharm[7] = (unsigned long )0;
           sqlstm.sqadto[7] = (unsigned short )0;
           sqlstm.sqtdso[7] = (unsigned short )0;
           sqlstm.sqhstv[8] = (unsigned char  *)&lhNumVenta;
           sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[8] = (         int  )0;
           sqlstm.sqindv[8] = (         short *)0;
           sqlstm.sqinds[8] = (         int  )0;
           sqlstm.sqharm[8] = (unsigned long )0;
           sqlstm.sqadto[8] = (unsigned short )0;
           sqlstm.sqtdso[8] = (unsigned short )0;
           sqlstm.sqhstv[9] = (unsigned char  *)szhFecVenta;
           sqlstm.sqhstl[9] = (unsigned long )20;
           sqlstm.sqhsts[9] = (         int  )0;
           sqlstm.sqindv[9] = (         short *)0;
           sqlstm.sqinds[9] = (         int  )0;
           sqlstm.sqharm[9] = (unsigned long )0;
           sqlstm.sqadto[9] = (unsigned short )0;
           sqlstm.sqtdso[9] = (unsigned short )0;
           sqlstm.sqhstv[10] = (unsigned char  *)szhFecRecepcion;
           sqlstm.sqhstl[10] = (unsigned long )20;
           sqlstm.sqhsts[10] = (         int  )0;
           sqlstm.sqindv[10] = (         short *)0;
           sqlstm.sqinds[10] = (         int  )0;
           sqlstm.sqharm[10] = (unsigned long )0;
           sqlstm.sqadto[10] = (unsigned short )0;
           sqlstm.sqtdso[10] = (unsigned short )0;
           sqlstm.sqhstv[11] = (unsigned char  *)szhFecRechazo;
           sqlstm.sqhstl[11] = (unsigned long )20;
           sqlstm.sqhsts[11] = (         int  )0;
           sqlstm.sqindv[11] = (         short *)0;
           sqlstm.sqinds[11] = (         int  )0;
           sqlstm.sqharm[11] = (unsigned long )0;
           sqlstm.sqadto[11] = (unsigned short )0;
           sqlstm.sqtdso[11] = (unsigned short )0;
           sqlstm.sqhstv[12] = (unsigned char  *)szhCodCausaRec;
           sqlstm.sqhstl[12] = (unsigned long )3;
           sqlstm.sqhsts[12] = (         int  )0;
           sqlstm.sqindv[12] = (         short *)0;
           sqlstm.sqinds[12] = (         int  )0;
           sqlstm.sqharm[12] = (unsigned long )0;
           sqlstm.sqadto[12] = (unsigned short )0;
           sqlstm.sqtdso[12] = (unsigned short )0;
           sqlstm.sqhstv[13] = (unsigned char  *)szhNumSerie;
           sqlstm.sqhstl[13] = (unsigned long )26;
           sqlstm.sqhsts[13] = (         int  )0;
           sqlstm.sqindv[13] = (         short *)0;
           sqlstm.sqinds[13] = (         int  )0;
           sqlstm.sqharm[13] = (unsigned long )0;
           sqlstm.sqadto[13] = (unsigned short )0;
           sqlstm.sqtdso[13] = (unsigned short )0;
           sqlstm.sqhstv[14] = (unsigned char  *)&lhCodCiclComis;
           sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[14] = (         int  )0;
           sqlstm.sqindv[14] = (         short *)0;
           sqlstm.sqinds[14] = (         int  )0;
           sqlstm.sqharm[14] = (unsigned long )0;
           sqlstm.sqadto[14] = (unsigned short )0;
           sqlstm.sqtdso[14] = (unsigned short )0;
           sqlstm.sqhstv[15] = (unsigned char  *)szhIdCiclComis;
           sqlstm.sqhstl[15] = (unsigned long )11;
           sqlstm.sqhsts[15] = (         int  )0;
           sqlstm.sqindv[15] = (         short *)0;
           sqlstm.sqinds[15] = (         int  )0;
           sqlstm.sqharm[15] = (unsigned long )0;
           sqlstm.sqadto[15] = (unsigned short )0;
           sqlstm.sqtdso[15] = (unsigned short )0;
           sqlstm.sqhstv[16] = (unsigned char  *)&lhCodVendFinal;
           sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[16] = (         int  )0;
           sqlstm.sqindv[16] = (         short *)&shIndCodVendFinal;
           sqlstm.sqinds[16] = (         int  )0;
           sqlstm.sqharm[16] = (unsigned long )0;
           sqlstm.sqadto[16] = (unsigned short )0;
           sqlstm.sqtdso[16] = (unsigned short )0;
           sqlstm.sqhstv[17] = (unsigned char  *)szhNumIdent;
           sqlstm.sqhstl[17] = (unsigned long )21;
           sqlstm.sqhsts[17] = (         int  )0;
           sqlstm.sqindv[17] = (         short *)0;
           sqlstm.sqinds[17] = (         int  )0;
           sqlstm.sqharm[17] = (unsigned long )0;
           sqlstm.sqadto[17] = (unsigned short )0;
           sqlstm.sqtdso[17] = (unsigned short )0;
           sqlstm.sqhstv[18] = (unsigned char  *)szhCodCategoria;
           sqlstm.sqhstl[18] = (unsigned long )11;
           sqlstm.sqhsts[18] = (         int  )0;
           sqlstm.sqindv[18] = (         short *)0;
           sqlstm.sqinds[18] = (         int  )0;
           sqlstm.sqharm[18] = (unsigned long )0;
           sqlstm.sqadto[18] = (unsigned short )0;
           sqlstm.sqtdso[18] = (unsigned short )0;
           sqlstm.sqhstv[19] = (unsigned char  *)szhCodPlanTarif;
           sqlstm.sqhstl[19] = (unsigned long )4;
           sqlstm.sqhsts[19] = (         int  )0;
           sqlstm.sqindv[19] = (         short *)0;
           sqlstm.sqinds[19] = (         int  )0;
           sqlstm.sqharm[19] = (unsigned long )0;
           sqlstm.sqadto[19] = (unsigned short )0;
           sqlstm.sqtdso[19] = (unsigned short )0;
           sqlstm.sqhstv[20] = (unsigned char  *)szhIndProcequi;
           sqlstm.sqhstl[20] = (unsigned long )2;
           sqlstm.sqhsts[20] = (         int  )0;
           sqlstm.sqindv[20] = (         short *)0;
           sqlstm.sqinds[20] = (         int  )0;
           sqlstm.sqharm[20] = (unsigned long )0;
           sqlstm.sqadto[20] = (unsigned short )0;
           sqlstm.sqtdso[20] = (unsigned short )0;
           sqlstm.sqhstv[21] = (unsigned char  *)szhNomUsuario;
           sqlstm.sqhstl[21] = (unsigned long )31;
           sqlstm.sqhsts[21] = (         int  )0;
           sqlstm.sqindv[21] = (         short *)0;
           sqlstm.sqinds[21] = (         int  )0;
           sqlstm.sqharm[21] = (unsigned long )0;
           sqlstm.sqadto[21] = (unsigned short )0;
           sqlstm.sqtdso[21] = (unsigned short )0;
           sqlstm.sqhstv[22] = (unsigned char  *)&ihCodTipoRed;
           sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[22] = (         int  )0;
           sqlstm.sqindv[22] = (         short *)0;
           sqlstm.sqinds[22] = (         int  )0;
           sqlstm.sqharm[22] = (unsigned long )0;
           sqlstm.sqadto[22] = (unsigned short )0;
           sqlstm.sqtdso[22] = (unsigned short )0;
           sqlstm.sqhstv[23] = (unsigned char  *)szhCodTipVendedor;
           sqlstm.sqhstl[23] = (unsigned long )3;
           sqlstm.sqhsts[23] = (         int  )0;
           sqlstm.sqindv[23] = (         short *)0;
           sqlstm.sqinds[23] = (         int  )0;
           sqlstm.sqharm[23] = (unsigned long )0;
           sqlstm.sqadto[23] = (unsigned short )0;
           sqlstm.sqtdso[23] = (unsigned short )0;
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
    stStatusProc.lCantRechazos = lCantRechazos;
    fprintf(stderr,"\n(vInsertaSeleccion)Cantidad de Rechazos Insertados:[%ld].\n",lCantRechazos);
    fprintf(pfLog ,"\n(vInsertaSeleccion)Cantidad de Rechazos Insertados:[%ld].\n",lCantRechazos);
}
/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por las listas de abonados.      */
/*****************************************************************************/
void vLiberaUniverso(stUniverso * qaux)
{
	if (qaux!=NULL)
	{
		vLiberaUniverso(qaux->sgte);
		free(qaux);
	}
}
/*****************************************************************************/
/* Rutina principal.                                                         */
/*****************************************************************************/
int     main (int argc, char *argv[])
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
	}                                                                                                               
/*---------------------------------------------------------------------------*/
/* HEADER.                                                                   */
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
/* MODIFICACION DE CONFIGURACION AMBIENTAL, PARA MANEJO DE FECHAS EN ORACLE. */
/*---------------------------------------------------------------------------*/
	/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )310;
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
    szTipoPeriodo = stCiclo.cTipCiclComis;
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
	fprintf(pfLog, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRechazos);
	fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRechazos);
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

/*---------------------------------------------------------------------------*/
	ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lCantRechazos);
	if (ibiblio)
	        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )325;
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

