
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
    "./pc/Sel_Prepago.pc"
};


static unsigned int sqlctx = 27723043;


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
   unsigned char  *sqhstv[19];
   unsigned long  sqhstl[19];
            int   sqhsts[19];
            short *sqindv[19];
            int   sqinds[19];
   unsigned long  sqharm[19];
   unsigned long  *sqharc[19];
   unsigned short  sqadto[19];
   unsigned short  sqtdso[19];
} sqlstm = {12,19};

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
"select distinct VEN1.COD_VENDEDOR ,NVL(VTAS.COD_VENDEALER,(-1)) ,VTAS.NUM_VE\
NTA ,TO_CHAR(VTAS.FEC_VENTA,'DD-MM-YYYY HH24:MI:SS') ,VTAS.COD_CLIENTE ,VTAS.C\
OD_OFICINA ,CLIE.NUM_IDENT  from VE_VENDEDORES VEN1 ,GE_CLIENTES CLIE ,GA_VENT\
AS VTAS ,VE_REDVENTAS_TD RVEN where (((((((RVEN.COD_TIPORED=:b0 and RVEN.COD_V\
ENDEDOR=VEN1.COD_VENDEDOR) and VEN1.COD_TIPCOMIS=:b1) and VEN1.COD_VENDEDOR=VT\
AS.COD_VENDEDOR) and VTAS.FEC_VENTA>TO_DATE(:b2,'DD-MM-YYYY')) and VTAS.FEC_VE\
NTA<=TO_DATE(:b3,'DD-MM-YYYY')) and VTAS.COD_CLIENTE=CLIE.COD_CLIENTE) and exi\
sts (select NUM_VENTA  from GA_ABOAMIST where NUM_VENTA=VTAS.NUM_VENTA))      \
     ";

 static char *sq0003 = 
"select CEL.NUM_CELULAR ,CEL.NUM_SERIE ,CEL.NUM_ABONADO ,CEL.IND_PROCEQUI  fr\
om GA_ABOAMIST CEL where ((CEL.NUM_VENTA=:b0 and CEL.IND_PROCEQUI='E') and  no\
t exists (select 1  from GA_TRASPABO ABO where (ABO.NUM_ABONADO=CEL.NUM_ABONAD\
O and ABO.NUM_ABONADO<>ABO.NUM_ABONADOANT)))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,627,0,9,190,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
36,0,0,1,0,0,13,194,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,
79,0,0,1,0,0,15,231,0,0,0,0,0,1,0,
94,0,0,2,238,0,4,272,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
117,0,0,3,287,0,9,306,0,0,1,1,0,1,0,1,3,0,0,
136,0,0,3,0,0,13,310,0,0,4,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
167,0,0,3,0,0,15,336,0,0,0,0,0,1,0,
182,0,0,4,65,0,4,364,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
205,0,0,5,410,0,4,416,0,0,4,2,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,1,97,0,0,
236,0,0,6,54,0,4,519,0,0,1,0,0,1,0,2,3,0,0,
255,0,0,7,404,0,3,541,0,0,19,19,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
346,0,0,8,48,0,1,716,0,0,0,0,0,1,0,
361,0,0,9,0,0,30,763,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las habilitaciones del producto    */
/* para luego pasar a la etapa de valoración.                           */ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 24 de Octubre del 2001.                                */
/* Fin:                                                                 */
/* Autor : Fabian Aedo Ramirez                                          */
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
/************************************************************************/
/* Modificacion:  por Jaime Vargas Morales                              */
/* fecha       : martes 7 de diciembre 2003                             */
/* descripcion : se incorpora al select un nuevo campo de la tabla      */
/* CMT_HABIL_PREPAGO  ind_procequi varchar2(2)                          */
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
#include "Sel_Prepago.h"
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
/* Carga la estructura de tipos de comisionistas que seran procesados.       */
/* en funcion del tipo de ciclo en proceso, se ejecuta libreria de carga de  */
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
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		vGetAbonados();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los datos del Cliente de la venta.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los datos del Cliente de la venta.\n");
		vGetClientes();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los datos de los equipos de la Venta.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los datos de los equipos de la Venta.\n");
		vGetEquipos();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Inserta Datos en Tabla de Seleccion.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Inserta Datos en Tabla de Seleccion.\n");
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

	int                     i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    char    szhFechaInicio[11];
	    char    szhFechaTermino[11];
		char    szhCodTipComis[3];
        long    lhCodComisionista[MAXFETCH];
        int     ihCodAgencia[MAXFETCH];
        int     ihCodVenDealer[MAXFETCH];
        long    lhNumVenta[MAXFETCH];
        long    lhNumAbonado[MAXFETCH];
        char    szhNumSerie[MAXFETCH][26];	    
        char    szhFecVenta[MAXFETCH][20];
        long    lhCodCliente[MAXFETCH];
        char    szhCodOficina[MAXFETCH][3];
        char    szhNumIdent[MAXFETCH][21];
		int		ihCodTipoRed;
		char	szhCodTipVendedor[3];
	    long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 

   
    strcpy(szhFechaInicio           , stCiclo.szFecDesdePrepago);    
    strcpy(szhFechaTermino          , stCiclo.szFecHastaPrepago );   
    strcpy(szhCodTipComis			, pszCodTipComis);    
    ihCodTipoRed					= piCodTipoRed;
    strcpy(szhCodTipVendedor		, pszCodTipVendedor);
    
    paux      = NULL;
	lMaxFetch = MAXFETCH;

	/* EXEC SQL DECLARE cur_universo CURSOR FOR 
     SELECT  DISTINCT
             VEN1.COD_VENDEDOR,
             NVL(VTAS.COD_VENDEALER,-1),
             VTAS.NUM_VENTA,
             TO_CHAR(VTAS.FEC_VENTA, 'DD-MM-YYYY HH24:MI:SS'),
             VTAS.COD_CLIENTE,
             VTAS.COD_OFICINA,
             CLIE.NUM_IDENT
     FROM    VE_VENDEDORES   VEN1,
             GE_CLIENTES     CLIE,
             GA_VENTAS       VTAS, 
			 VE_REDVENTAS_TD RVEN
       WHERE RVEN.COD_TIPORED    =  :ihCodTipoRed
	     AND RVEN.COD_VENDEDOR   =  VEN1.COD_VENDEDOR
		 AND VEN1.COD_TIPCOMIS   =  :szhCodTipVendedor
         AND VEN1.COD_VENDEDOR   =  VTAS.COD_VENDEDOR		 
	     AND VTAS.FEC_VENTA      >  TO_DATE(:szhFechaInicio,'DD-MM-YYYY')
         AND VTAS.FEC_VENTA     <=  TO_DATE(:szhFechaTermino,'DD-MM-YYYY')
         AND VTAS.COD_CLIENTE    =  CLIE.COD_CLIENTE
         AND EXISTS (SELECT NUM_VENTA 	 
         			 FROM GA_ABOAMIST 
         			 WHERE NUM_VENTA = VTAS.NUM_VENTA); */ 

                                               
    /* EXEC SQL OPEN cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipVendedor;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFechaInicio;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFechaTermino;
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



    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch
             FETCH cur_universo INTO
                   :ihCodAgencia     ,
                   :ihCodVenDealer   ,
                   :lhNumVenta       ,
                   :szhFecVenta      ,
                   :lhCodCliente     ,
                   :szhCodOficina    ,
                   :szhNumIdent; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )36;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodAgencia;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihCodVenDealer;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecVenta;
  sqlstm.sqhstl[3] = (unsigned long )20;
  sqlstm.sqhsts[3] = (         int  )20;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )sizeof(long);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodOficina;
  sqlstm.sqhstl[5] = (unsigned long )3;
  sqlstm.sqhsts[5] = (         int  )3;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhNumIdent;
  sqlstm.sqhstl[6] = (unsigned long )21;
  sqlstm.sqhsts[6] = (         int  )21;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
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
                 
                paux->iCodTipoRed     			= ihCodTipoRed;
				strcpy(paux->szCodTipComis      , szhCodTipComis);				
                paux->iCodAgencia               = ihCodAgencia[i];
                paux->lCodComisionista			= lObtieneVendedorPadre(paux->iCodAgencia, ihCodTipoRed, szhCodTipComis);      
				paux->iCodVenDealer 			= ihCodVenDealer[i];    
				paux->lNumVenta        			= lhNumVenta[i];        
				paux->lCodCliente      			= lhCodCliente[i];
				strcpy(paux->szFecVenta     	, szfnTrim(szhFecVenta[i]));				
				strcpy(paux->szCodOficina     	, szfnTrim(szhCodOficina[i]));				
                strcpy(paux->szNumIdent         , szfnTrim(szhNumIdent[i]));
				strcpy(paux->szCodTipVendedor   , szhCodTipVendedor);
				fprintf(pfLog , "\n[vSeleccionarUniverso] TR:[%d] Venta:[%d] Vendedor:[%d] Comisionista:[%d]",paux->iCodTipoRed, paux->lNumVenta, paux->iCodAgencia, paux->lCodComisionista);
                paux->cIndConsidera				= 'S';
                paux->abonado_sgte 				= NULL;
                paux->sgte 						= lstUniverso;
                lstUniverso 					= paux;
                iCantidad++; 
		}
   }
   /* EXEC SQL CLOSE cur_universo; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )79;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
   if (sqlca.sqlcode < 0) vSqlError();
}


   fprintf(pfLog ,"\n[vSeleccionarUniverso] Tipo Comisionista:[%s] Cantidad de Ventas Prepago Extraidas:[%ld].\n", szhCodTipComis, iCantidad);
   fprintf(stderr,"\n[vSeleccionarUniverso] Tipo Comisionista:[%s] Cantidad de Ventas Prepago Extraidas:[%ld].\n", szhCodTipComis, iCantidad);

}

/* ***************************************************************************** */
/* Del universo seleccionado, ahora se rescatan los abonados.                    */
/* ***************************************************************************** */
void vGetAbonados()
{
    stUniverso * paux;
    stAbonado  * aaux;
    int             i;     
    short           iLastRows     = 0;       
    int             iFetchedRows  = MAXFETCH;
    int             iRetrievRows  = MAXFETCH;
    long			lCantAbonados = 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhNumVenta;
		long    lMaxFetch;   	
	    long    lhNumCelular[MAXFETCH];
	    char    szhNumSerie[MAXFETCH][26];
	    long    lhNumAbonado[MAXFETCH];
        char    szhIndProcequi[MAXFETCH][2];
        long    lhNumSecuencia;
        int		iCantAbonados;
    /* EXEC SQL END DECLARE SECTION; */ 


    paux      = NULL; 
    aaux      = NULL; 

	for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		paux->abonado_sgte = NULL;
		if (paux->cIndConsidera == 'S')
		{
			lhNumVenta    = paux->lNumVenta;
			iCantAbonados = 0;
			
            /* EXEC SQL SELECT COUNT(NUM_ABONADO)
		        INTO  :iCantAbonados
				FROM    GA_ABOAMIST CEL
				WHERE   CEL.NUM_VENTA = :lhNumVenta
				AND   CEL.IND_PROCEQUI  = 'E' 
				AND   NOT EXISTS (SELECT  1 
				                 FROM  GA_TRASPABO ABO
				                 WHERE ABO.NUM_ABONADO   = CEL.NUM_ABONADO
				                 AND   ABO.NUM_ABONADO  != ABO.NUM_ABONADOANT); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select count(NUM_ABONADO) into :b0  from GA_ABOAM\
IST CEL where ((CEL.NUM_VENTA=:b1 and CEL.IND_PROCEQUI='E') and  not exists (s\
elect 1  from GA_TRASPABO ABO where (ABO.NUM_ABONADO=CEL.NUM_ABONADO and ABO.N\
UM_ABONADO<>ABO.NUM_ABONADOANT)))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )94;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&iCantAbonados;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumVenta;
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


			
            if (iCantAbonados == 0)
            {
                fprintf(pfLog, "\n[vGetAbonados] Venta [%d] No posee abonados Prepago (PROCEQUI=[E]). No se Considera.\n", lhNumVenta);
                paux->cIndConsidera = 'N';
            }
            else
            {
                iFetchedRows     = MAXFETCH;
                iRetrievRows     = MAXFETCH;
                iLastRows        = 0;
    			lMaxFetch = MAXFETCH;
                /* EXEC SQL DECLARE CUR_ABONADOS CURSOR FOR
                     SELECT  CEL.NUM_CELULAR,
                             CEL.NUM_SERIE,
                             CEL.NUM_ABONADO,
                             CEL.IND_PROCEQUI
                     FROM    GA_ABOAMIST CEL
                     WHERE   CEL.NUM_VENTA = :lhNumVenta
                       AND   CEL.IND_PROCEQUI  = 'E' 
                       AND   NOT EXISTS (SELECT  1 
                                         FROM  GA_TRASPABO ABO
                                         WHERE ABO.NUM_ABONADO   = CEL.NUM_ABONADO
                                         AND   ABO.NUM_ABONADO  != ABO.NUM_ABONADOANT); */ 

        
                /* EXEC SQL OPEN CUR_ABONADOS; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = sq0003;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )117;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqcmod = (unsigned int )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
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


        
                while(iFetchedRows == iRetrievRows)
                {
                     /* EXEC SQL for :lMaxFetch
                          FETCH CUR_ABONADOS INTO 
                                :lhNumCelular   ,     
                                :szhNumSerie    ,     
                                :lhNumAbonado   ,   
                                :szhIndProcequi; */ 

{
                     struct sqlexd sqlstm;
                     sqlstm.sqlvsn = 12;
                     sqlstm.arrsiz = 7;
                     sqlstm.sqladtp = &sqladt;
                     sqlstm.sqltdsp = &sqltds;
                     sqlstm.iters = (unsigned int  )lMaxFetch;
                     sqlstm.offset = (unsigned int  )136;
                     sqlstm.selerr = (unsigned short)1;
                     sqlstm.cud = sqlcud0;
                     sqlstm.sqlest = (unsigned char  *)&sqlca;
                     sqlstm.sqlety = (unsigned short)256;
                     sqlstm.occurs = (unsigned int  )0;
                     sqlstm.sqfoff = (         int )0;
                     sqlstm.sqfmod = (unsigned int )2;
                     sqlstm.sqhstv[0] = (unsigned char  *)lhNumCelular;
                     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                     sqlstm.sqhsts[0] = (         int  )sizeof(long);
                     sqlstm.sqindv[0] = (         short *)0;
                     sqlstm.sqinds[0] = (         int  )0;
                     sqlstm.sqharm[0] = (unsigned long )0;
                     sqlstm.sqharc[0] = (unsigned long  *)0;
                     sqlstm.sqadto[0] = (unsigned short )0;
                     sqlstm.sqtdso[0] = (unsigned short )0;
                     sqlstm.sqhstv[1] = (unsigned char  *)szhNumSerie;
                     sqlstm.sqhstl[1] = (unsigned long )26;
                     sqlstm.sqhsts[1] = (         int  )26;
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
                     sqlstm.sqhstv[3] = (unsigned char  *)szhIndProcequi;
                     sqlstm.sqhstl[3] = (unsigned long )2;
                     sqlstm.sqhsts[3] = (         int  )2;
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
                     iLastRows    = sqlca.sqlerrd[2];
                
                     for (i=0; i < iRetrievRows; i++)
                     {
                         aaux = (stAbonado *) malloc (sizeof(stAbonado));
                                                        
                         lCantAbonados++;
                                
                         aaux->cIndConsidera      = 'S';
                         aaux->lNumCelular        = lhNumCelular[i];
                         aaux->lNumAbonado        = lhNumAbonado[i];
                         strcpy(aaux->szNumSerie  , szfnTrim(szhNumSerie[i]));
                         strcpy(aaux->cIndProcequi, szfnTrim(szhIndProcequi[i]));
                                                
                         aaux->sgte               = paux->abonado_sgte;
                         paux->abonado_sgte       = aaux;
                     }
                }                                
                /* EXEC SQL CLOSE CUR_ABONADOS; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )167;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
                if (sqlca.sqlcode < 0) vSqlError();
}

            	
            }			
		} 
	} 
    fprintf(stderr,"\n[vGetAbonados]Cantidad Total de abonados Prepago Habilitados... [%d]\n",lCantAbonados);
    fprintf(pfLog ,"\n[vGetAbonados]Cantidad Total de abonados Prepago Habilitados... [%d]\n",lCantAbonados);
    stStatusProc.iCantAbonados = lCantAbonados;        
}

/* **************************************************************************** */
/* Del universo seleccionado, ahora se revisan los clientes.                    */
/* **************************************************************************** */
void vGetClientes()
{
    stUniverso * paux;
	long	   lCantVentas = 0;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhCodCliente;
        char    szhNumIdent[20]; 
    /* EXEC SQL END DECLARE SECTION; */ 


    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
		if (paux->cIndConsidera == 'S')
		{
            lhCodCliente = paux->lCodCliente;

            /* EXEC SQL SELECT NUM_IDENT
            INTO    :szhNumIdent
            FROM    GE_CLIENTES
            WHERE   COD_CLIENTE = :lhCodCliente; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select NUM_IDENT into :b0  from GE_CLIENTES where\
 COD_CLIENTE=:b1";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )182;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
            sqlstm.sqhstl[0] = (unsigned long )20;
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
            	fprintf(stderr,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta Prepago [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);
            	fprintf(pfLog ,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta Prepago [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);
            }
            else
            {
				lCantVentas++;
				strcpy(paux->szNumIdent 	, szfnTrim(szhNumIdent));
			}
		} 
	}
	fprintf(stderr,"\n(vGetClientes) Cantidad de Ventas Prepago examinadas (solo validas):[%ld].\n", lCantVentas);
}

/* **************************************************************************** */
/* Del universo seleccionado, ahora se revisan los equipos.                     */
/* **************************************************************************** */
void vGetEquipos()
{
    stUniverso	* paux;
    stAbonado   * aaux;
	long		lCantVentas 	= 0;
	long		lCantAbonados 	= 0;
	long		lCantAbonadosX	= 0;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhNumAbonado;
	    char    szhNumSerie[26];
	    long    lhCodArticulo;
        short   shCodFabricante;
    /* EXEC SQL END DECLARE SECTION; */ 


    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
        if (paux->cIndConsidera == 'S')
        {
            lCantVentas++;
            for (aaux=paux->abonado_sgte; aaux != NULL; aaux = aaux->sgte)
            {
                if (aaux->cIndConsidera == 'S')
                {
                    lhNumAbonado      	= aaux->lNumAbonado;
                    strcpy(szhNumSerie 	, aaux->szNumSerie);
					lCantAbonados++;

                    /* EXEC SQL SELECT FABR.COD_FABRICANTE, 
                                    EQUI1.COD_ARTICULO
                             INTO   :shCodFabricante,
                                    :lhCodArticulo
                           FROM     AL_FABRICANTES FABR,
                                    AL_ARTICULOS   ARTI,
                                    GA_EQUIPABOSER EQUI1
                           WHERE    EQUI1.NUM_ABONADO   = :lhNumAbonado
                             AND    EQUI1.NUM_SERIE     = :szhNumSerie
                             AND    EQUI1.FEC_ALTA      = (SELECT  MAX(R.FEC_ALTA) FROM   GA_EQUIPABOSER R
                                                            WHERE  R.NUM_ABONADO = EQUI1.NUM_ABONADO
                                                              AND  R.NUM_SERIE   = EQUI1.NUM_SERIE)
                             AND    EQUI1.COD_ARTICULO  = ARTI.COD_ARTICULO 
                             AND    ARTI.COD_FABRICANTE = FABR.COD_FABRICANTE; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 7;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select FABR.COD_FABRICANTE ,EQUI1.COD_ART\
ICULO into :b0,:b1  from AL_FABRICANTES FABR ,AL_ARTICULOS ARTI ,GA_EQUIPABOSE\
R EQUI1 where ((((EQUI1.NUM_ABONADO=:b2 and EQUI1.NUM_SERIE=:b3) and EQUI1.FEC\
_ALTA=(select max(R.FEC_ALTA)  from GA_EQUIPABOSER R where (R.NUM_ABONADO=EQUI\
1.NUM_ABONADO and R.NUM_SERIE=EQUI1.NUM_SERIE))) and EQUI1.COD_ARTICULO=ARTI.C\
OD_ARTICULO) and ARTI.COD_FABRICANTE=FABR.COD_FABRICANTE)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )205;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&shCodFabricante;
                    sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodArticulo;
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
                    sqlstm.sqhstv[3] = (unsigned char  *)szhNumSerie;
                    sqlstm.sqhstl[3] = (unsigned long )26;
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



                    if (sqlca.sqlcode)
                    {
                    	fprintf(stderr,"\n(vGetEquipos) Abonado:[%ld] Serie:[%s] No fue posible recueprar datos del equipo.", lhNumAbonado, szhNumSerie);
                    	fprintf(pfLog ,"\n(vGetEquipos) Abonado:[%ld] Serie:[%s] No fue posible recueprar datos del equipo.", lhNumAbonado, szhNumSerie);
                    	aaux->cIndConsidera = 'N';
                    	lCantAbonadosX++;
					}
					else
                    {
                       	aaux->lCodArticulo   	= lhCodArticulo;
                        aaux->sCodFabricante 	= shCodFabricante;
                        aaux->cIndConsidera     = 'S';
                    }
                }
	        } 
        } 
    }
    fprintf(stderr,"\n(vGetEquipos) Fin de Función que recupera datos de Equipos.");
    fprintf(stderr,"\n(vGetEquipos) Ventas Examinadas (solo validas):       [%ld].", lCantVentas);
    fprintf(stderr,"\n(vGetEquipos) Abonados con datos de Equipo Correcto:  [%ld].", lCantAbonados);
    fprintf(stderr,"\n(vGetEquipos) Abonados Sin datos de Equipo:           [%ld].", lCantAbonadosX);

    fprintf(pfLog,"\n(vGetEquipos) Fin de Función que recupera datos de Equipos.");
    fprintf(pfLog,"\n(vGetEquipos) Ventas Examinadas (solo validas):       [%ld].", lCantVentas);
    fprintf(pfLog,"\n(vGetEquipos) Abonados con datos de Equipo Correcto:  [%ld].", lCantAbonados);
    fprintf(pfLog,"\n(vGetEquipos) Abonados Sin datos de Equipo:           [%ld].", lCantAbonadosX);

}

/*---------------------------------------------------------------------------*/
/* Insercion de valores en tabla de salida                                   */
/*---------------------------------------------------------------------------*/
void vInsertaSeleccion()
{
    stUniverso	* paux;
    stAbonado    * aaux;
	long		lCantAbonados = 0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumSecuencia;
		char	szhCodTipComis[3];
		long	lhCodComisionista;
		int  	ihCodAgencia;
		int 	ihCodVendDealer;
		char  	szhCodOficina[3];
		char  	szhFecVenta[20];
		long  	lhCodCliente;
		char  	szhNumIdent[20];
		long  	lhNumAbonado;
		long  	lhNumCelular;
		char  	szhNumSerie[26];
		long  	lhCodArticulo;	
        short   shCodFabricante;
		char  	chIndProcequi[2];
		long	lhCodCiclComis;	
		char	szhIdCiclComis[11];
		int		ihCodTipoRed;
		char	szhCodTipVendedor[3];	
	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhCodCiclComis 			= stCiclo.lCodCiclComis;
    strcpy(szhIdCiclComis	, stCiclo.szIdCiclComis);

    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
    	if (paux->cIndConsidera == 'S')
        {
            for (aaux = paux->abonado_sgte; aaux != NULL; aaux = aaux->sgte)
                if (aaux->cIndConsidera == 'S')
                {
					strcpy(szhCodTipComis      	, paux->szCodTipComis);
					lhCodComisionista    		= paux->lCodComisionista;   
					ihCodAgencia         		= paux->iCodAgencia;   
                    ihCodVendDealer             = paux->iCodVenDealer;
					strcpy(szhCodOficina       	, paux->szCodOficina);
					strcpy(szhFecVenta         	, paux->szFecVenta);
					lhCodCliente        		= paux->lCodCliente;  	
					strcpy(szhNumIdent       	, paux->szNumIdent); 
                 	ihCodTipoRed        		= paux->iCodTipoRed;  
					strcpy(szhCodTipVendedor   	, paux->szCodTipVendedor);

					lhNumAbonado    			= aaux->lNumAbonado;
					lhNumCelular    			= aaux->lNumCelular;
					strcpy(szhNumSerie     		, aaux->szNumSerie);
					lhCodArticulo   			= aaux->lCodArticulo;
					shCodFabricante 		    = aaux->sCodFabricante;
					strcpy(chIndProcequi   		, aaux->cIndProcequi);
                
                    /* EXEC SQL SELECT CMS_REG_SELECCION.NEXTVAL INTO :lhNumSecuencia FROM DUAL; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 7;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b\
0  from DUAL ";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )236;
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


                    lCantAbonados++;

					fprintf(pfLog, "\n+++++++++++++++++++++++++++[%d]++++++++++++++++++++++++++", lCantAbonados);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhNumSecuencia        [%ld]", lhNumSecuencia    	);
					fprintf(pfLog, "\n[vInsertaSeleccion] szhCodTipComis      	[%s]" , szhCodTipComis     	);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhCodComisionista    	[%ld]", lhCodComisionista  	);	
					fprintf(pfLog, "\n[vInsertaSeleccion] ihCodAgencia         	[%d]" , ihCodAgencia       	);	
					fprintf(pfLog, "\n[vInsertaSeleccion] ihCodVendDealer       [%d]" , ihCodVendDealer    	);    
					fprintf(pfLog, "\n[vInsertaSeleccion] szhCodOficina       	[%s]" , szhCodOficina      	);
					fprintf(pfLog, "\n[vInsertaSeleccion] szhFecVenta         	[%s]" , szhFecVenta        	);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhCodCliente        	[%ld]", lhCodCliente       	);	
					fprintf(pfLog, "\n[vInsertaSeleccion] szhNumIdent       	[%s]" , szhNumIdent        	);
					fprintf(pfLog, "\n[vInsertaSeleccion] ihCodTipoRed        	[%d]" , ihCodTipoRed       	);	
					fprintf(pfLog, "\n[vInsertaSeleccion] szhCodTipVendedor   	[%s]" , szhCodTipVendedor  	);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhNumAbonado    		[%ld]", lhNumAbonado    	);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhNumCelular    		[%ld]", lhNumCelular    	);
					fprintf(pfLog, "\n[vInsertaSeleccion] szhNumSerie     		[%s]" , szhNumSerie     	);
					fprintf(pfLog, "\n[vInsertaSeleccion] lhCodArticulo   		[%ld]", lhCodArticulo   	);
					fprintf(pfLog, "\n[vInsertaSeleccion] shCodFabricante 		[%d]" , shCodFabricante 	); 
					fprintf(pfLog, "\n[vInsertaSeleccion] chIndProcequi   		[%s]" , chIndProcequi      	);

                    /* EXEC SQL INSERT INTO CMT_HABIL_PREPAGO (
                        NUM_GENERAL     , COD_TIPCOMIS    , COD_COMISIONISTA,
                        COD_AGENCIA     , COD_VEND_FINAL  , COD_OFICINA     ,
                        FEC_HABILITACION, 
                        COD_CLIENTE     , NUM_IDENT       , NUM_ABONADO     , 
                        NUM_CELULAR     , NUM_SERIE       , COD_ARTICULO    , 
                        COD_FABRICANTE  , COD_PERIODO     , ID_PERIODO      , 
                        IND_PROCEQUI    , COD_TIPORED	  , COD_TIPVENDEDOR) 
                    VALUES (
                        :lhNumSecuencia , :szhCodTipComis , :lhCodComisionista ,
                        :ihCodAgencia   , :ihCodVendDealer, :szhCodOficina     ,
                        to_date(:szhFecVenta, 'DD-MM-YYYY HH24:MI:SS'), 
                        :lhCodCliente   , :szhNumIdent    , :lhNumAbonado      ,
                        :lhNumCelular   , :szhNumSerie    , :lhCodArticulo     ,
                        :shCodFabricante, :lhCodCiclComis , :szhIdCiclComis    ,
                        :chIndProcequi  , :ihCodTipoRed	  , :szhCodTipVendedor); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 19;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CMT_HABIL_PREPAGO (NUM_GENERA\
L,COD_TIPCOMIS,COD_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,COD_OFICINA,FEC_HAB\
ILITACION,COD_CLIENTE,NUM_IDENT,NUM_ABONADO,NUM_CELULAR,NUM_SERIE,COD_ARTICULO\
,COD_FABRICANTE,COD_PERIODO,ID_PERIODO,IND_PROCEQUI,COD_TIPORED,COD_TIPVENDEDO\
R) values (:b0,:b1,:b2,:b3,:b4,:b5,to_date(:b6,'DD-MM-YYYY HH24:MI:SS'),:b7,:b\
8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )255;
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
                    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodAgencia;
                    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodVendDealer;
                    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[4] = (         int  )0;
                    sqlstm.sqindv[4] = (         short *)0;
                    sqlstm.sqinds[4] = (         int  )0;
                    sqlstm.sqharm[4] = (unsigned long )0;
                    sqlstm.sqadto[4] = (unsigned short )0;
                    sqlstm.sqtdso[4] = (unsigned short )0;
                    sqlstm.sqhstv[5] = (unsigned char  *)szhCodOficina;
                    sqlstm.sqhstl[5] = (unsigned long )3;
                    sqlstm.sqhsts[5] = (         int  )0;
                    sqlstm.sqindv[5] = (         short *)0;
                    sqlstm.sqinds[5] = (         int  )0;
                    sqlstm.sqharm[5] = (unsigned long )0;
                    sqlstm.sqadto[5] = (unsigned short )0;
                    sqlstm.sqtdso[5] = (unsigned short )0;
                    sqlstm.sqhstv[6] = (unsigned char  *)szhFecVenta;
                    sqlstm.sqhstl[6] = (unsigned long )20;
                    sqlstm.sqhsts[6] = (         int  )0;
                    sqlstm.sqindv[6] = (         short *)0;
                    sqlstm.sqinds[6] = (         int  )0;
                    sqlstm.sqharm[6] = (unsigned long )0;
                    sqlstm.sqadto[6] = (unsigned short )0;
                    sqlstm.sqtdso[6] = (unsigned short )0;
                    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCliente;
                    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[7] = (         int  )0;
                    sqlstm.sqindv[7] = (         short *)0;
                    sqlstm.sqinds[7] = (         int  )0;
                    sqlstm.sqharm[7] = (unsigned long )0;
                    sqlstm.sqadto[7] = (unsigned short )0;
                    sqlstm.sqtdso[7] = (unsigned short )0;
                    sqlstm.sqhstv[8] = (unsigned char  *)szhNumIdent;
                    sqlstm.sqhstl[8] = (unsigned long )20;
                    sqlstm.sqhsts[8] = (         int  )0;
                    sqlstm.sqindv[8] = (         short *)0;
                    sqlstm.sqinds[8] = (         int  )0;
                    sqlstm.sqharm[8] = (unsigned long )0;
                    sqlstm.sqadto[8] = (unsigned short )0;
                    sqlstm.sqtdso[8] = (unsigned short )0;
                    sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
                    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[9] = (         int  )0;
                    sqlstm.sqindv[9] = (         short *)0;
                    sqlstm.sqinds[9] = (         int  )0;
                    sqlstm.sqharm[9] = (unsigned long )0;
                    sqlstm.sqadto[9] = (unsigned short )0;
                    sqlstm.sqtdso[9] = (unsigned short )0;
                    sqlstm.sqhstv[10] = (unsigned char  *)&lhNumCelular;
                    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[10] = (         int  )0;
                    sqlstm.sqindv[10] = (         short *)0;
                    sqlstm.sqinds[10] = (         int  )0;
                    sqlstm.sqharm[10] = (unsigned long )0;
                    sqlstm.sqadto[10] = (unsigned short )0;
                    sqlstm.sqtdso[10] = (unsigned short )0;
                    sqlstm.sqhstv[11] = (unsigned char  *)szhNumSerie;
                    sqlstm.sqhstl[11] = (unsigned long )26;
                    sqlstm.sqhsts[11] = (         int  )0;
                    sqlstm.sqindv[11] = (         short *)0;
                    sqlstm.sqinds[11] = (         int  )0;
                    sqlstm.sqharm[11] = (unsigned long )0;
                    sqlstm.sqadto[11] = (unsigned short )0;
                    sqlstm.sqtdso[11] = (unsigned short )0;
                    sqlstm.sqhstv[12] = (unsigned char  *)&lhCodArticulo;
                    sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[12] = (         int  )0;
                    sqlstm.sqindv[12] = (         short *)0;
                    sqlstm.sqinds[12] = (         int  )0;
                    sqlstm.sqharm[12] = (unsigned long )0;
                    sqlstm.sqadto[12] = (unsigned short )0;
                    sqlstm.sqtdso[12] = (unsigned short )0;
                    sqlstm.sqhstv[13] = (unsigned char  *)&shCodFabricante;
                    sqlstm.sqhstl[13] = (unsigned long )sizeof(short);
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
                    sqlstm.sqhstv[16] = (unsigned char  *)chIndProcequi;
                    sqlstm.sqhstl[16] = (unsigned long )2;
                    sqlstm.sqhsts[16] = (         int  )0;
                    sqlstm.sqindv[16] = (         short *)0;
                    sqlstm.sqinds[16] = (         int  )0;
                    sqlstm.sqharm[16] = (unsigned long )0;
                    sqlstm.sqadto[16] = (unsigned short )0;
                    sqlstm.sqtdso[16] = (unsigned short )0;
                    sqlstm.sqhstv[17] = (unsigned char  *)&ihCodTipoRed;
                    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[17] = (         int  )0;
                    sqlstm.sqindv[17] = (         short *)0;
                    sqlstm.sqinds[17] = (         int  )0;
                    sqlstm.sqharm[17] = (unsigned long )0;
                    sqlstm.sqadto[17] = (unsigned short )0;
                    sqlstm.sqtdso[17] = (unsigned short )0;
                    sqlstm.sqhstv[18] = (unsigned char  *)szhCodTipVendedor;
                    sqlstm.sqhstl[18] = (unsigned long )3;
                    sqlstm.sqhsts[18] = (         int  )0;
                    sqlstm.sqindv[18] = (         short *)0;
                    sqlstm.sqinds[18] = (         int  )0;
                    sqlstm.sqharm[18] = (unsigned long )0;
                    sqlstm.sqadto[18] = (unsigned short )0;
                    sqlstm.sqtdso[18] = (unsigned short )0;
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
    stStatusProc.lCantRegistros = lCantAbonados;
    fprintf(stderr,"\n(vInsertaSeleccion)Cantidad de Abonados Insertados:[%ld].\n",lCantAbonados);
    fprintf(pfLog ,"\n(vInsertaSeleccion)Cantidad de Abonados Insertados:[%ld].\n",lCantAbonados);	
}	

/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por las listas de abonados.      */
/*****************************************************************************/
void vLiberaAbonados(stAbonado * qaux)
{
	if (qaux!=NULL)
	{
		vLiberaAbonados(qaux->sgte);
		free(qaux);
	}
}
/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por la lista de ventas.          */
/* como pueden ser "n" ventas, se hará con while y no recursiva...           */
/*****************************************************************************/
void vLiberaUniverso()
{
	stUniverso * paux;
	stUniverso * qaux;
	if (lstUniverso != NULL)
	{
		qaux = lstUniverso;
		paux = lstUniverso->sgte;
		while (paux!=NULL)
		{
			vLiberaAbonados(qaux->abonado_sgte);
			qaux->abonado_sgte = NULL;
			free(qaux);
			qaux = paux;
			paux = qaux->sgte;
		}
		if (qaux!=NULL)
		{
			vLiberaAbonados(qaux->abonado_sgte);
			qaux->abonado_sgte = NULL;
			free(qaux);
		}
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
	fprintf(stderr, "\nstArgs.szUser        [%s]\n", stArgs.szUser);
	fprintf(stderr, "\nstArgs.szPass        [%s]\n", stArgs.szPass);
	
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
    sprintf(stArgsLog.szPath,"%s%s/%s", pszEnvLog, stArgsLog.szProceso, szFechaYYYYMMDD);
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
	fprintf(pfLog, "Base de datos : %s\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
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
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )346;
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
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )361;
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

