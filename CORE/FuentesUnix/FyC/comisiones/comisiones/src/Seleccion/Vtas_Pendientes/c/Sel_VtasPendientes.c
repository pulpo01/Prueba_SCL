
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
           char  filnam[27];
};
static struct sqlcxp sqlfpn =
{
    26,
    "./pc/Sel_VtasPendientes.pc"
};


static unsigned int sqlctx = 745924093;


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
   unsigned char  *sqhstv[23];
   unsigned long  sqhstl[23];
            int   sqhsts[23];
            short *sqindv[23];
            int   sqinds[23];
   unsigned long  sqharm[23];
   unsigned long  *sqharc[23];
   unsigned short  sqadto[23];
   unsigned short  sqtdso[23];
} sqlstm = {12,23};

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
"OANT)))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,1042,0,9,210,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
56,0,0,1,0,0,13,213,0,0,14,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
127,0,0,1,0,0,15,263,0,0,0,0,0,1,0,
142,0,0,2,65,0,4,287,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
165,0,0,3,79,0,4,330,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
188,0,0,4,95,0,4,344,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
211,0,0,5,318,0,4,376,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
238,0,0,6,508,0,3,480,0,0,22,22,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
341,0,0,7,508,0,3,503,0,0,22,22,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
444,0,0,8,476,0,3,526,0,0,21,21,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
543,0,0,9,540,0,3,549,0,0,23,23,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
650,0,0,10,48,0,1,699,0,0,0,0,0,1,0,
665,0,0,11,0,0,30,746,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las habilitaciones del producto    */
/* para luego pasar a la etapa de valoracion.                           */ 
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
/* 20030917 Marcelo Quiroz G. Versionado Cuzco.                         */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorpora manejo de lista general de tipos de comisionistas.      */
/* Se reestructura proceso en funcion de estructura de tipos de         */
/* comisionistas.                                                       */
/*                                                                      */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Sel_VtasPendientes.h"
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
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los datos del Cliente de la venta pendiente.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los datos del Cliente de la venta pendiente.\n");
		vGetClientes();
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los abonados de la venta.\n");
		vGetVendDealer();
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
    long    	iCantidad = 0;

	int                     i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIndEstVenta[MAXFETCH][3];
		char	szhIndEstVentaAC[3];
		char	szhIndEstVentaRE[3];
		char  	szhFecHastaAceptacion[11];
		char  	szhFecHastaRecepcion [11];
		char    szhCodTipComis[3];
		long    lhNumVenta[MAXFETCH];
	    char    szhFecVenta[MAXFETCH][20];
	    char    szhFecRecepcion[MAXFETCH][20];
	    char    szhFecAceptacion[MAXFETCH][20];
        char	szhNumContrato[MAXFETCH][20];
		long    lhCodVendedor[MAXFETCH];
		long    lhCodVendComis[MAXFETCH];
		long	lhCodVendDealer[MAXFETCH];
        long    lhCodCliente[MAXFETCH];
        long    lhNumAbonado[MAXFETCH];
        long    lhNumCelular[MAXFETCH];
        char    szhCodPlanTarif[MAXFETCH][4];
        char    szhNumSerie[MAXFETCH][26];
        char    szhIndProcequi[MAXFETCH][2];
		int		ihCodTipoRed;
		char	szhCodTipVendedor[3];
	    long    lhCodPeriodo;
        short   ihIndCodVendDealer[MAXFETCH];

	    long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhIndEstVentaAC			, "AC");
    strcpy(szhIndEstVentaRE			, "RE");
    strcpy(szhFecHastaAceptacion    , stCiclo.szFecHastaAceptacion);  
    strcpy(szhFecHastaRecepcion     , stCiclo.szFecHastaRecepcion);  
    lhCodPeriodo                    = stCiclo.lCodCiclComis;        
    strcpy(szhCodTipComis			, pszCodTipComis);
    strcpy(szhCodTipVendedor		, pszCodTipVendedor);
    ihCodTipoRed					= piCodTipoRed;

    paux      = NULL;
	lMaxFetch = MAXFETCH;
	
    /* EXEC SQL DECLARE cur_universo CURSOR FOR
             SELECT  DISTINCT
			 		 VTAS.IND_ESTVENTA,
                     VTAS.NUM_VENTA,
                     NVL(TO_CHAR(VTAS.FEC_VENTA,'DD-MM-YYYY HH24:MI:SS')   ,0),
                     NVL(TO_CHAR(VTAS.FEC_RECDOCUM,'DD-MM-YYYY HH24:MI:SS'),0),
                     NVL(TO_CHAR(VTAS.FEC_ACEPREC,'DD-MM-YYYY HH24:MI:SS') ,0),
                     NVL(VTAS.NUM_CONTRATO,'S/N'),
                     VEN1.COD_VENDEDOR,
                     NVL(VTAS.COD_VENDEALER, -1),
                     ABON.COD_CLIENTE,
                     ABON.NUM_ABONADO,
                     ABON.NUM_CELULAR,
                     ABON.COD_PLANTARIF,
                     ABON.NUM_SERIE,
                     ABON.IND_PROCEQUI
             FROM    VE_VENDEDORES   VEN1,
                     GA_ABOCEL       ABON,
                     GA_VENTAS       VTAS, 
					 VE_REDVENTAS_TD RVEN
             WHERE   RVEN.COD_TIPORED 		= :ihCodTipoRed
			 	 AND RVEN.COD_VENDEDOR 		= VEN1.COD_VENDEDOR
				 AND VEN1.COD_TIPCOMIS 		= :szhCodTipVendedor
				 AND VEN1.COD_VENDEDOR  	= VTAS.COD_VENDEDOR 
				 AND (VTAS.FEC_RECDOCUM             >  TO_DATE(:szhFecHastaRecepcion,'DD-MM-YYYY')
                       OR (VTAS.FEC_RECDOCUM        <= TO_DATE(:szhFecHastaRecepcion,'DD-MM-YYYY')
                       AND VTAS.IND_ESTVENTA NOT IN (:szhIndEstVentaRE,:szhIndEstVentaAC))
                       OR (VTAS.FEC_ACEPREC         > TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY')
                       AND VTAS.IND_ESTVENTA     IN (:szhIndEstVentaRE,:szhIndEstVentaAC)))
                AND   VTAS.NUM_VENTA		= ABON.NUM_VENTA
                AND   NOT EXISTS (SELECT ROWID
                                  FROM   GA_TRASPABO TRAS
                                  WHERE  TRAS.NUM_ABONADO     = ABON.NUM_ABONADO
                                  AND    TRAS.NUM_ABONADO    != TRAS.NUM_ABONADOANT); */ 

	                                               
    /* EXEC SQL open cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlbuft((void **)0, 
      "select distinct VTAS.IND_ESTVENTA ,VTAS.NUM_VENTA ,NVL(TO_CHAR(VTAS.F\
EC_VENTA,'DD-MM-YYYY HH24:MI:SS'),0) ,NVL(TO_CHAR(VTAS.FEC_RECDOCUM,'DD-MM-Y\
YYY HH24:MI:SS'),0) ,NVL(TO_CHAR(VTAS.FEC_ACEPREC,'DD-MM-YYYY HH24:MI:SS'),0\
) ,NVL(VTAS.NUM_CONTRATO,'S/N') ,VEN1.COD_VENDEDOR ,NVL(VTAS.COD_VENDEALER,(\
-1)) ,ABON.COD_CLIENTE ,ABON.NUM_ABONADO ,ABON.NUM_CELULAR ,ABON.COD_PLANTAR\
IF ,ABON.NUM_SERIE ,ABON.IND_PROCEQUI  from VE_VENDEDORES VEN1 ,GA_ABOCEL AB\
ON ,GA_VENTAS VTAS ,VE_REDVENTAS_TD RVEN where ((((((RVEN.COD_TIPORED=:b0 an\
d RVEN.COD_VENDEDOR=VEN1.COD_VENDEDOR) and VEN1.COD_TIPCOMIS=:b1) and VEN1.C\
OD_VENDEDOR=VTAS.COD_VENDEDOR) and ((VTAS.FEC_RECDOCUM>TO_DATE(:b2,'DD-MM-YY\
YY') or (VTAS.FEC_RECDOCUM<=TO_DATE(:b2,'DD-MM-YYYY') and VTAS.IND_ESTVENTA \
not  in (:b4,:b5))) or (VTAS.FEC_ACEPREC>TO_DATE(:b6,'DD-MM-YYYY') and VTAS.\
IND_ESTVENTA in (:b4,:b5)))) and VTAS.NUM_VENTA=ABON.NUM_VENTA) and  not exi\
sts (select ROWID  from GA_TRASPABO TRAS where (TRAS.NUM_ABONADO=ABON.NUM_AB\
ONADO and TRAS.NUM_ABONADO<>TRAS.NUM_ABONAD");
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecHastaRecepcion;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaRecepcion;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhIndEstVentaRE;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhIndEstVentaAC;
    sqlstm.sqhstl[5] = (unsigned long )3;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecHastaAceptacion;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhIndEstVentaRE;
    sqlstm.sqhstl[7] = (unsigned long )3;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhIndEstVentaAC;
    sqlstm.sqhstl[8] = (unsigned long )3;
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


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch
                   FETCH cur_universo INTO
                            :szhIndEstVenta,
                            :lhNumVenta,
                            :szhFecVenta,
                            :szhFecRecepcion,
                            :szhFecAceptacion,
                            :szhNumContrato,
                            :lhCodVendedor,                       
                            :lhCodVendDealer,  
                            :lhCodCliente,
                            :lhNumAbonado,
                            :lhNumCelular,
                            :szhCodPlanTarif,
                            :szhNumSerie,
                            :szhIndProcequi; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )56;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstVenta;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )3;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lhNumVenta;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
        sqlstm.sqhstl[2] = (unsigned long )20;
        sqlstm.sqhsts[2] = (         int  )20;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecRecepcion;
        sqlstm.sqhstl[3] = (unsigned long )20;
        sqlstm.sqhsts[3] = (         int  )20;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecAceptacion;
        sqlstm.sqhstl[4] = (unsigned long )20;
        sqlstm.sqhsts[4] = (         int  )20;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhNumContrato;
        sqlstm.sqhstl[5] = (unsigned long )20;
        sqlstm.sqhsts[5] = (         int  )20;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)lhCodVendedor;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )sizeof(long);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)lhCodVendDealer;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )sizeof(long);
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)lhCodCliente;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )sizeof(long);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)lhNumAbonado;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )sizeof(long);
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)lhNumCelular;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )sizeof(long);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szhCodPlanTarif;
        sqlstm.sqhstl[11] = (unsigned long )4;
        sqlstm.sqhsts[11] = (         int  )4;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhNumSerie;
        sqlstm.sqhstl[12] = (unsigned long )26;
        sqlstm.sqhsts[12] = (         int  )26;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)szhIndProcequi;
        sqlstm.sqhstl[13] = (unsigned long )2;
        sqlstm.sqhsts[13] = (         int  )2;
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


                                                                                                            
		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {                
            paux = (stUniverso *) malloc(sizeof(stUniverso));
		    
		    strcpy(paux->szCodTipComis      , szhCodTipComis);  
            strcpy(paux->szIndEstVenta      , szfnTrim(szhIndEstVenta[i]));                    
            paux->lNumVenta                 = lhNumVenta[i];          
            strcpy(paux->szFecVenta         , szfnTrim(szhFecVenta[i]));                 
            strcpy(paux->szFecRecepcion     , szfnTrim(szhFecRecepcion[i])); 
            strcpy(paux->szFecAceptacion    , szfnTrim(szhFecAceptacion[i]));                        
            strcpy(paux->szNumContrato      , szfnTrim(szhNumContrato[i]));  
            paux->lCodVendedor              = lhCodVendedor[i];                           
            paux->lCodVendComis             = lObtieneVendedorPadre(paux->lCodVendedor , ihCodTipoRed, szhCodTipComis);
            paux->lCodVendDealer            = lhCodVendDealer[i];      
            paux->lCodCliente               = lhCodCliente[i];        
            paux->lNumAbonado               = lhNumAbonado[i];        
            paux->lNumCelular               = lhNumCelular[i];        
            strcpy(paux->szCodPlanTarif     , szfnTrim(szhCodPlanTarif[i]));                          
            strcpy(paux->szNumSerie         , szfnTrim(szhNumSerie[i]));     
            strcpy(paux->szIndProcequi      , szfnTrim(szhIndProcequi[i]));      
            paux->iCodTipoRed     			= ihCodTipoRed;
		    strcpy(paux->szCodTipVendedor   , szfnTrim(szhCodTipVendedor));
		    paux->lCodPeriodo               = lhCodPeriodo;		   
            paux->cIndConsidera				= 'S';

            paux->sgte 						= lstUniverso;
            lstUniverso 					= paux;
            iCantidad++;
	    }	
	}
    /* EXEC SQL close cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )127;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog, "\n[vSeleccionarUniverso]Tipo Comisionista:[%s] Cantidad de Ventas Pendientes:[%ld].\n", szhCodTipComis, iCantidad);
    fprintf(pfLog, "\n[vSeleccionarUniverso]Tipo Comisionista:[%s] Cantidad de Ventas Pendientes:[%ld].\n", szhCodTipComis, iCantidad);
}

/* **************************************************************************** */
/* Del universo seleccionado, ahora se revisan los clientes.                    */
/* **************************************************************************** */
void vGetClientes()
{
    stUniverso  * paux;
	long	    lCantVentas = 0;
	
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
                    INTO   :szhNumIdent
           FROM     GE_CLIENTES
           WHERE    COD_CLIENTE = :lhCodCliente; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 14;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "select NUM_IDENT into :b0  from GE_CLIENTES where \
COD_CLIENTE=:b1";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )142;
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
            	fprintf(stderr,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta Pendiente [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);
            	fprintf(pfLog ,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta Pendiente [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);
           }
           else
           {
				lCantVentas++;
				strcpy(paux->szNumIdent 	, szfnTrim(szhNumIdent));
			}
		} 
	}
	fprintf(stderr,"\n(vGetClientes) Cantidad de ventas pendientes examinadas (solo validas):[%d].\n", lCantVentas);
}

/*---------------------------------------------------------------------------*/
/* Del universo seleccionado, agregan los datos del vendedor final(vendealer)*/
/*---------------------------------------------------------------------------*/
void vGetVendDealer()
{
    stUniverso   * paux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long	lhCodVendDealer;
         int	ihExisteVendDealer;
         char	szhNomVendDealer[41];
    /* EXEC SQL END DECLARE SECTION; */ 

        
	for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{      
	    if (paux->cIndConsidera == 'S' )  
		{
/*			fprintf(stderr,"\n[vGetVendDealer] Busca Nombre VendedorDealer:[%d]", paux->lCodVendDealer);    */
/*			fprintf(pfLog ,"\n[vGetVendDealer] Busca Nombre VendedorDealer:[%d]", paux->lCodVendDealer);	*/

			lhCodVendDealer = paux->lCodVendDealer;
			
			/* EXEC SQL SELECT COUNT(COD_VENDEALER)
			        INTO  :ihExisteVendDealer
			FROM     VE_VENDEALER
			WHERE    COD_VENDEALER = :lhCodVendDealer; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(COD_VENDEALER) into :b0  from VE_VENDEALER wh\
ere COD_VENDEALER=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )165;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihExisteVendDealer;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendDealer;
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



/*			fprintf(stderr,"\n-->Existe VendedorDealer?[%d]\n", ihExisteVendDealer);    */
/*			fprintf(pfLog ,"\n-->Existe VendedorDealer?[%d]\n", ihExisteVendDealer);	*/
			
			if (ihExisteVendDealer == 0) 
			{
				strcpy(paux->szNomVendDealer, "NO SE ENCONTRO.");
			}
			else
			{
				/* EXEC SQL SELECT NVL(NOM_VENDEALER,'NO SE ENCONTRO.') 
				        INTO  :szhNomVendDealer
				FROM     VE_VENDEALER
				WHERE    COD_VENDEALER = :lhCodVendDealer; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(NOM_VENDEALER,'NO SE ENCONTRO.') into :b0  fro\
m VE_VENDEALER where COD_VENDEALER=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )188;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomVendDealer;
    sqlstm.sqhstl[0] = (unsigned long )41;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendDealer;
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


				strcpy(paux->szNomVendDealer, szfnTrim(szhNomVendDealer));
			}
/*			fprintf(stderr,"\nVendedor:[%s]\n", paux->szNomVendDealer); */
/*			fprintf(pfLog ,"\nVendedor:[%s]\n", paux->szNomVendDealer);	*/
        }
    }
}

/*---------------------------------------------------------------------------*/
/* Para el universo seleccionado, se recuperan los datos del equipo.         */
/*---------------------------------------------------------------------------*/
void vGetEquipos()
{
    stUniverso      * paux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumAbonado;
         long    lhCodArticulo;
         char    szhNumSerie[26];
    /* EXEC SQL END DECLARE SECTION; */ 

        
    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {      
   	    if (paux->cIndConsidera == 'S')
		{                                                         
			lhNumAbonado            = paux->lNumAbonado;
			strcpy(szhNumSerie      , paux->szNumSerie);
			
			/* EXEC SQL SELECT  EQUI1.COD_ARTICULO
			INTO     :lhCodArticulo
			FROM     AL_ARTICULOS   ARTI, GA_EQUIPABOSER EQUI1
			WHERE    EQUI1.NUM_ABONADO   = :lhNumAbonado
			 AND    EQUI1.NUM_SERIE     = :szhNumSerie
			 AND    EQUI1.FEC_ALTA =(SELECT  MAX(R.FEC_ALTA) FROM   GA_EQUIPABOSER R
			                         WHERE   R.NUM_ABONADO = EQUI1.NUM_ABONADO
			                           AND   R.NUM_SERIE   = EQUI1.NUM_SERIE)
			 AND    EQUI1.COD_ARTICULO  = ARTI.COD_ARTICULO; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select EQUI1.COD_ARTICULO into :b0  from AL_ARTICULOS ARTI\
 ,GA_EQUIPABOSER EQUI1 where (((EQUI1.NUM_ABONADO=:b1 and EQUI1.NUM_SERIE=:b2)\
 and EQUI1.FEC_ALTA=(select max(R.FEC_ALTA)  from GA_EQUIPABOSER R where (R.NU\
M_ABONADO=EQUI1.NUM_ABONADO and R.NUM_SERIE=EQUI1.NUM_SERIE))) and EQUI1.COD_A\
RTICULO=ARTI.COD_ARTICULO)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )211;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodArticulo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[2] = (unsigned char  *)szhNumSerie;
   sqlstm.sqhstl[2] = (unsigned long )26;
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


			
			paux->lCodArticulo        = lhCodArticulo;
        }
    }
}

/*---------------------------------------------------------------------------*/
/* Insercion de valores en tabla de salida                                   */
/*---------------------------------------------------------------------------*/
void vInsertaSeleccion()
{
    stUniverso	* paux;
    long        lCantAbonados = 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhIndEstVenta[3];      /* EXEC SQL VAR szhIndEstVenta     IS STRING(3); */ 

         long    lhNumVenta;
         char    szhFecVenta[22];        /* EXEC SQL VAR szhFecVenta        IS STRING(22); */ 

         char    szhFecRecepcion[22];    /* EXEC SQL VAR szhFecRecepcion    IS STRING(22); */ 

         char    szhFecAceptacion[22];   /* EXEC SQL VAR szhFecAceptacion   IS STRING(22); */ 

         char    szhNumContrato[21];     /* EXEC SQL VAR szhNumContrato     IS STRING(21); */ 

         char    szhCodTipComis[3];      /* EXEC SQL VAR szhCodTipComis     IS STRING(3); */ 

         long    lhCodVendedor;
         long    lhCodVendComis;
         long    lhCodVendDealer;
         short   ihIndCodVendFinal;
         char    szhNomVendDealer[41];    /* EXEC SQL VAR szhNomVendDealer  IS STRING(41); */ 

         long    lhCodCliente;
         long    lhNumAbonado;
         long    lhNumCelular;
         char    szhNumIdent[21];        /* EXEC SQL VAR szhNumIdent        IS STRING(21); */ 
          
         char    szhCodPlanTarif[4];     /* EXEC SQL VAR szhCodPlanTarif    IS STRING(4); */ 

         char    szhNumSerie[26];        /* EXEC SQL VAR szhNumSerie        IS STRING(26); */ 

         long    lhCodArticulo;
         char    szhIndProcequi[2];      /* EXEC SQL VAR szhIndProcequi     IS STRING(2); */ 

         long    lhCodPeriodo;  
		 int	 ihCodTipoRed;
		 char	 szhCodTipVendedor[3];  
		 char	 szhIdPeriodo[11];       
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);
    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
    	if (paux->cIndConsidera == 'S')
        {
            strcpy(szhIndEstVenta   , paux->szIndEstVenta);
            lhNumVenta              = paux->lNumVenta;
            strcpy(szhFecVenta      , paux->szFecVenta);
            strcpy(szhFecRecepcion  , paux->szFecRecepcion);
            strcpy(szhFecAceptacion , paux->szFecAceptacion);
            strcpy(szhNumContrato   , paux->szNumContrato);
            strcpy(szhCodTipComis   , paux->szCodTipComis);
            lhCodVendedor           = paux->lCodVendedor;
            lhCodVendComis          = paux->lCodVendComis;
            lhCodVendDealer         = paux->lCodVendDealer;            
            strcpy(szhNomVendDealer , paux->szNomVendDealer);
            lhCodCliente            = paux->lCodCliente;
            lhNumAbonado            = paux->lNumAbonado;
            lhNumCelular            = paux->lNumCelular;
            strcpy(szhNumIdent      , paux->szNumIdent);
            strcpy(szhCodPlanTarif  , paux->szCodPlanTarif);
            strcpy(szhNumSerie      , paux->szNumSerie);
            lhCodArticulo           = paux->lCodArticulo;
            strcpy(szhIndProcequi   , paux->szIndProcequi);
            lhCodPeriodo            = paux->lCodPeriodo;
      		ihCodTipoRed            = paux->iCodTipoRed;
		    strcpy(szhCodTipVendedor, paux->szCodTipVendedor);
            lCantAbonados++;

			fprintf(pfLog, "\n+++++++++++++++++++++++++++++++++[%d]+++++++++++++++++++++++++++\n",lCantAbonados);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szIndEstVenta  	:[%s]\n",paux->szIndEstVenta);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lNumVenta      	:[%d]\n",paux->lNumVenta);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szFecVenta     	:[%s]\n",paux->szFecVenta);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szFecRecepcion 	:[%s]\n",paux->szFecRecepcion);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szFecAceptacion	:[%s]\n",paux->szFecAceptacion);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szNumContrato  	:[%s]\n",paux->szNumContrato);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szCodTipComis  	:[%s]\n",paux->szCodTipComis);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodVendedor   	:[%d]\n",paux->lCodVendedor);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodVendComis  	:[%d]\n",paux->lCodVendComis);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodVendDealer 	:[%d]\n",paux->lCodVendDealer);            
			fprintf(pfLog, "[vInsertaSeeccion] paux->szNomVendDealer	:[%s]\n",paux->szNomVendDealer);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodCliente    	:[%d]\n",paux->lCodCliente);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lNumAbonado    	:[%d]\n",paux->lNumAbonado);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lNumCelular    	:[%ld]\n",paux->lNumCelular);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szNumIdent     	:[%s]\n",paux->szNumIdent);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szCodPlanTarif 	:[%s]\n",paux->szCodPlanTarif);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szNumSerie     	:[%s]\n",paux->szNumSerie);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodArticulo   	:[%d]\n",paux->lCodArticulo);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szIndProcequi  	:[%s]\n",paux->szIndProcequi);
			fprintf(pfLog, "[vInsertaSeeccion] paux->lCodPeriodo    	:[%d]\n",paux->lCodPeriodo);
			fprintf(pfLog, "[vInsertaSeeccion] paux->iCodTipoRed    	:[%d]\n",paux->iCodTipoRed);
			fprintf(pfLog, "[vInsertaSeeccion] paux->szCodTipVendedor	:[%s]\n",paux->szCodTipVendedor);

            if(strcmp(szhFecAceptacion, "0") == 0 && strcmp(szhFecRecepcion, "0") != 0)
               /* EXEC SQL INSERT INTO CMT_VENTAS_PENDIENTES 
                        (COD_ESTADO    , NUM_VENTA     , 
                         FEC_VENTA     , 
                         FEC_RECEPCION , 
                         FEC_ACEPTACION, 
                         NUM_CONTRATO  , COD_TIPCOMIS  , COD_COMISIONISTA, 
                         COD_AGENCIA   , COD_VEND_FINAL, NOM_VEND_FINAL  ,
                         COD_CLIENTE   , NUM_ABONADO   , NUM_CELULAR     ,
                         NUM_IDENT     , COD_PLANTARIF , NUM_SERIE       ,
                         COD_ARTICULO  , IND_PROCEQUI  , COD_PERIODO     , 
                         COD_TIPORED   , COD_TIPVENDEDOR, ID_PERIODO)
               VALUES (:szhIndEstVenta , :lhNumVenta       ,
                       TO_DATE(:szhFecVenta,'DD-MM-YYYY HH24:MI:SS'),
                       TO_DATE(:szhFecRecepcion,'DD-MM-YYYY HH24:MI:SS'),
                       NULL,
                       :szhNumContrato , :szhCodTipComis   , :lhCodVendedor   ,
                       :lhCodVendComis , :lhCodVendDealer  , :szhNomVendDealer,
                       :lhCodCliente   , :lhNumAbonado     , :lhNumCelular    ,
                       :szhNumIdent    , :szhCodPlanTarif  , :szhNumSerie     ,
                       :lhCodArticulo  , :szhIndProcequi   , :lhCodPeriodo    , 
                       :ihCodTipoRed   , :szhCodTipVendedor, :szhIdPeriodo); */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 22;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "insert into CMT_VENTAS_PENDIENTES (COD_ESTADO,\
NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_TIPCOMIS,COD\
_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,NOM_VEND_FINAL,COD_CLIENTE,NUM_ABONAD\
O,NUM_CELULAR,NUM_IDENT,COD_PLANTARIF,NUM_SERIE,COD_ARTICULO,IND_PROCEQUI,COD_\
PERIODO,COD_TIPORED,COD_TIPVENDEDOR,ID_PERIODO) values (:b0,:b1,TO_DATE(:b2,'D\
D-MM-YYYY HH24:MI:SS'),TO_DATE(:b3,'DD-MM-YYYY HH24:MI:SS'),null ,:b4,:b5,:b6,\
:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )238;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstVenta;
               sqlstm.sqhstl[0] = (unsigned long )3;
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
               sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
               sqlstm.sqhstl[2] = (unsigned long )22;
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)szhFecRecepcion;
               sqlstm.sqhstl[3] = (unsigned long )22;
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)szhNumContrato;
               sqlstm.sqhstl[4] = (unsigned long )21;
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
               sqlstm.sqhstv[6] = (unsigned char  *)&lhCodVendedor;
               sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[6] = (         int  )0;
               sqlstm.sqindv[6] = (         short *)0;
               sqlstm.sqinds[6] = (         int  )0;
               sqlstm.sqharm[6] = (unsigned long )0;
               sqlstm.sqadto[6] = (unsigned short )0;
               sqlstm.sqtdso[6] = (unsigned short )0;
               sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendComis;
               sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[7] = (         int  )0;
               sqlstm.sqindv[7] = (         short *)0;
               sqlstm.sqinds[7] = (         int  )0;
               sqlstm.sqharm[7] = (unsigned long )0;
               sqlstm.sqadto[7] = (unsigned short )0;
               sqlstm.sqtdso[7] = (unsigned short )0;
               sqlstm.sqhstv[8] = (unsigned char  *)&lhCodVendDealer;
               sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[8] = (         int  )0;
               sqlstm.sqindv[8] = (         short *)0;
               sqlstm.sqinds[8] = (         int  )0;
               sqlstm.sqharm[8] = (unsigned long )0;
               sqlstm.sqadto[8] = (unsigned short )0;
               sqlstm.sqtdso[8] = (unsigned short )0;
               sqlstm.sqhstv[9] = (unsigned char  *)szhNomVendDealer;
               sqlstm.sqhstl[9] = (unsigned long )41;
               sqlstm.sqhsts[9] = (         int  )0;
               sqlstm.sqindv[9] = (         short *)0;
               sqlstm.sqinds[9] = (         int  )0;
               sqlstm.sqharm[9] = (unsigned long )0;
               sqlstm.sqadto[9] = (unsigned short )0;
               sqlstm.sqtdso[9] = (unsigned short )0;
               sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCliente;
               sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[10] = (         int  )0;
               sqlstm.sqindv[10] = (         short *)0;
               sqlstm.sqinds[10] = (         int  )0;
               sqlstm.sqharm[10] = (unsigned long )0;
               sqlstm.sqadto[10] = (unsigned short )0;
               sqlstm.sqtdso[10] = (unsigned short )0;
               sqlstm.sqhstv[11] = (unsigned char  *)&lhNumAbonado;
               sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[11] = (         int  )0;
               sqlstm.sqindv[11] = (         short *)0;
               sqlstm.sqinds[11] = (         int  )0;
               sqlstm.sqharm[11] = (unsigned long )0;
               sqlstm.sqadto[11] = (unsigned short )0;
               sqlstm.sqtdso[11] = (unsigned short )0;
               sqlstm.sqhstv[12] = (unsigned char  *)&lhNumCelular;
               sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[12] = (         int  )0;
               sqlstm.sqindv[12] = (         short *)0;
               sqlstm.sqinds[12] = (         int  )0;
               sqlstm.sqharm[12] = (unsigned long )0;
               sqlstm.sqadto[12] = (unsigned short )0;
               sqlstm.sqtdso[12] = (unsigned short )0;
               sqlstm.sqhstv[13] = (unsigned char  *)szhNumIdent;
               sqlstm.sqhstl[13] = (unsigned long )21;
               sqlstm.sqhsts[13] = (         int  )0;
               sqlstm.sqindv[13] = (         short *)0;
               sqlstm.sqinds[13] = (         int  )0;
               sqlstm.sqharm[13] = (unsigned long )0;
               sqlstm.sqadto[13] = (unsigned short )0;
               sqlstm.sqtdso[13] = (unsigned short )0;
               sqlstm.sqhstv[14] = (unsigned char  *)szhCodPlanTarif;
               sqlstm.sqhstl[14] = (unsigned long )4;
               sqlstm.sqhsts[14] = (         int  )0;
               sqlstm.sqindv[14] = (         short *)0;
               sqlstm.sqinds[14] = (         int  )0;
               sqlstm.sqharm[14] = (unsigned long )0;
               sqlstm.sqadto[14] = (unsigned short )0;
               sqlstm.sqtdso[14] = (unsigned short )0;
               sqlstm.sqhstv[15] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[15] = (unsigned long )26;
               sqlstm.sqhsts[15] = (         int  )0;
               sqlstm.sqindv[15] = (         short *)0;
               sqlstm.sqinds[15] = (         int  )0;
               sqlstm.sqharm[15] = (unsigned long )0;
               sqlstm.sqadto[15] = (unsigned short )0;
               sqlstm.sqtdso[15] = (unsigned short )0;
               sqlstm.sqhstv[16] = (unsigned char  *)&lhCodArticulo;
               sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[16] = (         int  )0;
               sqlstm.sqindv[16] = (         short *)0;
               sqlstm.sqinds[16] = (         int  )0;
               sqlstm.sqharm[16] = (unsigned long )0;
               sqlstm.sqadto[16] = (unsigned short )0;
               sqlstm.sqtdso[16] = (unsigned short )0;
               sqlstm.sqhstv[17] = (unsigned char  *)szhIndProcequi;
               sqlstm.sqhstl[17] = (unsigned long )2;
               sqlstm.sqhsts[17] = (         int  )0;
               sqlstm.sqindv[17] = (         short *)0;
               sqlstm.sqinds[17] = (         int  )0;
               sqlstm.sqharm[17] = (unsigned long )0;
               sqlstm.sqadto[17] = (unsigned short )0;
               sqlstm.sqtdso[17] = (unsigned short )0;
               sqlstm.sqhstv[18] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[18] = (         int  )0;
               sqlstm.sqindv[18] = (         short *)0;
               sqlstm.sqinds[18] = (         int  )0;
               sqlstm.sqharm[18] = (unsigned long )0;
               sqlstm.sqadto[18] = (unsigned short )0;
               sqlstm.sqtdso[18] = (unsigned short )0;
               sqlstm.sqhstv[19] = (unsigned char  *)&ihCodTipoRed;
               sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[19] = (         int  )0;
               sqlstm.sqindv[19] = (         short *)0;
               sqlstm.sqinds[19] = (         int  )0;
               sqlstm.sqharm[19] = (unsigned long )0;
               sqlstm.sqadto[19] = (unsigned short )0;
               sqlstm.sqtdso[19] = (unsigned short )0;
               sqlstm.sqhstv[20] = (unsigned char  *)szhCodTipVendedor;
               sqlstm.sqhstl[20] = (unsigned long )3;
               sqlstm.sqhsts[20] = (         int  )0;
               sqlstm.sqindv[20] = (         short *)0;
               sqlstm.sqinds[20] = (         int  )0;
               sqlstm.sqharm[20] = (unsigned long )0;
               sqlstm.sqadto[20] = (unsigned short )0;
               sqlstm.sqtdso[20] = (unsigned short )0;
               sqlstm.sqhstv[21] = (unsigned char  *)szhIdPeriodo;
               sqlstm.sqhstl[21] = (unsigned long )11;
               sqlstm.sqhsts[21] = (         int  )0;
               sqlstm.sqindv[21] = (         short *)0;
               sqlstm.sqinds[21] = (         int  )0;
               sqlstm.sqharm[21] = (unsigned long )0;
               sqlstm.sqadto[21] = (unsigned short )0;
               sqlstm.sqtdso[21] = (unsigned short )0;
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


                
            if(strcmp(szhFecRecepcion, "0") == 0 && strcmp(szhFecAceptacion, "0") != 0)
               /* EXEC SQL INSERT INTO CMT_VENTAS_PENDIENTES 
                        (COD_ESTADO    , NUM_VENTA     , 
                         FEC_VENTA     , 
                         FEC_RECEPCION , 
                         FEC_ACEPTACION, 
                         NUM_CONTRATO  , COD_TIPCOMIS  , COD_COMISIONISTA, 
                         COD_AGENCIA   , COD_VEND_FINAL, NOM_VEND_FINAL  ,
                         COD_CLIENTE   , NUM_ABONADO   , NUM_CELULAR     ,
                         NUM_IDENT     , COD_PLANTARIF , NUM_SERIE       ,
                         COD_ARTICULO  , IND_PROCEQUI  , COD_PERIODO     , 
                         COD_TIPORED   , COD_TIPVENDEDOR, ID_PERIODO)
               VALUES (:szhIndEstVenta , :lhNumVenta       ,
                       TO_DATE(:szhFecVenta,'DD-MM-YYYY HH24:MI:SS')     ,                          
                       NULL            ,
                       TO_DATE(:szhFecAceptacion,'DD-MM-YYYY HH24:MI:SS'),
                       :szhNumContrato , :szhCodTipComis   , :lhCodVendedor    ,
                       :lhCodVendComis , :lhCodVendDealer  , :szhNomVendDealer ,
                       :lhCodCliente   , :lhNumAbonado     , :lhNumCelular     ,
                       :szhNumIdent    , :szhCodPlanTarif  , :szhNumSerie      ,
                       :lhCodArticulo  , :szhIndProcequi   , :lhCodPeriodo     , 
                       :ihCodTipoRed   , :szhCodTipVendedor, :szhIdPeriodo); */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 22;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "insert into CMT_VENTAS_PENDIENTES (COD_ESTADO,\
NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_TIPCOMIS,COD\
_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,NOM_VEND_FINAL,COD_CLIENTE,NUM_ABONAD\
O,NUM_CELULAR,NUM_IDENT,COD_PLANTARIF,NUM_SERIE,COD_ARTICULO,IND_PROCEQUI,COD_\
PERIODO,COD_TIPORED,COD_TIPVENDEDOR,ID_PERIODO) values (:b0,:b1,TO_DATE(:b2,'D\
D-MM-YYYY HH24:MI:SS'),null ,TO_DATE(:b3,'DD-MM-YYYY HH24:MI:SS'),:b4,:b5,:b6,\
:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )341;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstVenta;
               sqlstm.sqhstl[0] = (unsigned long )3;
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
               sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
               sqlstm.sqhstl[2] = (unsigned long )22;
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)szhFecAceptacion;
               sqlstm.sqhstl[3] = (unsigned long )22;
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)szhNumContrato;
               sqlstm.sqhstl[4] = (unsigned long )21;
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
               sqlstm.sqhstv[6] = (unsigned char  *)&lhCodVendedor;
               sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[6] = (         int  )0;
               sqlstm.sqindv[6] = (         short *)0;
               sqlstm.sqinds[6] = (         int  )0;
               sqlstm.sqharm[6] = (unsigned long )0;
               sqlstm.sqadto[6] = (unsigned short )0;
               sqlstm.sqtdso[6] = (unsigned short )0;
               sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendComis;
               sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[7] = (         int  )0;
               sqlstm.sqindv[7] = (         short *)0;
               sqlstm.sqinds[7] = (         int  )0;
               sqlstm.sqharm[7] = (unsigned long )0;
               sqlstm.sqadto[7] = (unsigned short )0;
               sqlstm.sqtdso[7] = (unsigned short )0;
               sqlstm.sqhstv[8] = (unsigned char  *)&lhCodVendDealer;
               sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[8] = (         int  )0;
               sqlstm.sqindv[8] = (         short *)0;
               sqlstm.sqinds[8] = (         int  )0;
               sqlstm.sqharm[8] = (unsigned long )0;
               sqlstm.sqadto[8] = (unsigned short )0;
               sqlstm.sqtdso[8] = (unsigned short )0;
               sqlstm.sqhstv[9] = (unsigned char  *)szhNomVendDealer;
               sqlstm.sqhstl[9] = (unsigned long )41;
               sqlstm.sqhsts[9] = (         int  )0;
               sqlstm.sqindv[9] = (         short *)0;
               sqlstm.sqinds[9] = (         int  )0;
               sqlstm.sqharm[9] = (unsigned long )0;
               sqlstm.sqadto[9] = (unsigned short )0;
               sqlstm.sqtdso[9] = (unsigned short )0;
               sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCliente;
               sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[10] = (         int  )0;
               sqlstm.sqindv[10] = (         short *)0;
               sqlstm.sqinds[10] = (         int  )0;
               sqlstm.sqharm[10] = (unsigned long )0;
               sqlstm.sqadto[10] = (unsigned short )0;
               sqlstm.sqtdso[10] = (unsigned short )0;
               sqlstm.sqhstv[11] = (unsigned char  *)&lhNumAbonado;
               sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[11] = (         int  )0;
               sqlstm.sqindv[11] = (         short *)0;
               sqlstm.sqinds[11] = (         int  )0;
               sqlstm.sqharm[11] = (unsigned long )0;
               sqlstm.sqadto[11] = (unsigned short )0;
               sqlstm.sqtdso[11] = (unsigned short )0;
               sqlstm.sqhstv[12] = (unsigned char  *)&lhNumCelular;
               sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[12] = (         int  )0;
               sqlstm.sqindv[12] = (         short *)0;
               sqlstm.sqinds[12] = (         int  )0;
               sqlstm.sqharm[12] = (unsigned long )0;
               sqlstm.sqadto[12] = (unsigned short )0;
               sqlstm.sqtdso[12] = (unsigned short )0;
               sqlstm.sqhstv[13] = (unsigned char  *)szhNumIdent;
               sqlstm.sqhstl[13] = (unsigned long )21;
               sqlstm.sqhsts[13] = (         int  )0;
               sqlstm.sqindv[13] = (         short *)0;
               sqlstm.sqinds[13] = (         int  )0;
               sqlstm.sqharm[13] = (unsigned long )0;
               sqlstm.sqadto[13] = (unsigned short )0;
               sqlstm.sqtdso[13] = (unsigned short )0;
               sqlstm.sqhstv[14] = (unsigned char  *)szhCodPlanTarif;
               sqlstm.sqhstl[14] = (unsigned long )4;
               sqlstm.sqhsts[14] = (         int  )0;
               sqlstm.sqindv[14] = (         short *)0;
               sqlstm.sqinds[14] = (         int  )0;
               sqlstm.sqharm[14] = (unsigned long )0;
               sqlstm.sqadto[14] = (unsigned short )0;
               sqlstm.sqtdso[14] = (unsigned short )0;
               sqlstm.sqhstv[15] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[15] = (unsigned long )26;
               sqlstm.sqhsts[15] = (         int  )0;
               sqlstm.sqindv[15] = (         short *)0;
               sqlstm.sqinds[15] = (         int  )0;
               sqlstm.sqharm[15] = (unsigned long )0;
               sqlstm.sqadto[15] = (unsigned short )0;
               sqlstm.sqtdso[15] = (unsigned short )0;
               sqlstm.sqhstv[16] = (unsigned char  *)&lhCodArticulo;
               sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[16] = (         int  )0;
               sqlstm.sqindv[16] = (         short *)0;
               sqlstm.sqinds[16] = (         int  )0;
               sqlstm.sqharm[16] = (unsigned long )0;
               sqlstm.sqadto[16] = (unsigned short )0;
               sqlstm.sqtdso[16] = (unsigned short )0;
               sqlstm.sqhstv[17] = (unsigned char  *)szhIndProcequi;
               sqlstm.sqhstl[17] = (unsigned long )2;
               sqlstm.sqhsts[17] = (         int  )0;
               sqlstm.sqindv[17] = (         short *)0;
               sqlstm.sqinds[17] = (         int  )0;
               sqlstm.sqharm[17] = (unsigned long )0;
               sqlstm.sqadto[17] = (unsigned short )0;
               sqlstm.sqtdso[17] = (unsigned short )0;
               sqlstm.sqhstv[18] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[18] = (         int  )0;
               sqlstm.sqindv[18] = (         short *)0;
               sqlstm.sqinds[18] = (         int  )0;
               sqlstm.sqharm[18] = (unsigned long )0;
               sqlstm.sqadto[18] = (unsigned short )0;
               sqlstm.sqtdso[18] = (unsigned short )0;
               sqlstm.sqhstv[19] = (unsigned char  *)&ihCodTipoRed;
               sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[19] = (         int  )0;
               sqlstm.sqindv[19] = (         short *)0;
               sqlstm.sqinds[19] = (         int  )0;
               sqlstm.sqharm[19] = (unsigned long )0;
               sqlstm.sqadto[19] = (unsigned short )0;
               sqlstm.sqtdso[19] = (unsigned short )0;
               sqlstm.sqhstv[20] = (unsigned char  *)szhCodTipVendedor;
               sqlstm.sqhstl[20] = (unsigned long )3;
               sqlstm.sqhsts[20] = (         int  )0;
               sqlstm.sqindv[20] = (         short *)0;
               sqlstm.sqinds[20] = (         int  )0;
               sqlstm.sqharm[20] = (unsigned long )0;
               sqlstm.sqadto[20] = (unsigned short )0;
               sqlstm.sqtdso[20] = (unsigned short )0;
               sqlstm.sqhstv[21] = (unsigned char  *)szhIdPeriodo;
               sqlstm.sqhstl[21] = (unsigned long )11;
               sqlstm.sqhsts[21] = (         int  )0;
               sqlstm.sqindv[21] = (         short *)0;
               sqlstm.sqinds[21] = (         int  )0;
               sqlstm.sqharm[21] = (unsigned long )0;
               sqlstm.sqadto[21] = (unsigned short )0;
               sqlstm.sqtdso[21] = (unsigned short )0;
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



            if(strcmp(szhFecRecepcion, "0") == 0 && strcmp(szhFecAceptacion, "0") == 0)
               /* EXEC SQL INSERT INTO CMT_VENTAS_PENDIENTES 
                        (COD_ESTADO    , NUM_VENTA     , 
                         FEC_VENTA     , 
                         FEC_RECEPCION , 
                         FEC_ACEPTACION, 
                         NUM_CONTRATO  , COD_TIPCOMIS  , COD_COMISIONISTA, 
                         COD_AGENCIA   , COD_VEND_FINAL, NOM_VEND_FINAL  ,
                         COD_CLIENTE   , NUM_ABONADO   , NUM_CELULAR     ,
                         NUM_IDENT     , COD_PLANTARIF , NUM_SERIE       ,
                         COD_ARTICULO  , IND_PROCEQUI  , COD_PERIODO     , 
                         COD_TIPORED   , COD_TIPVENDEDOR, ID_PERIODO)
               VALUES (:szhIndEstVenta , :lhNumVenta       ,
                       TO_DATE(:szhFecVenta,'DD-MM-YYYY HH24:MI:SS'),                          
                       NULL            ,
                       NULL            ,
                       :szhNumContrato , :szhCodTipComis   , :lhCodVendedor    ,
                       :lhCodVendComis , :lhCodVendDealer  , :szhNomVendDealer ,
                       :lhCodCliente   , :lhNumAbonado     , :lhNumCelular     ,
                       :szhNumIdent    , :szhCodPlanTarif  , :szhNumSerie      ,
                       :lhCodArticulo  , :szhIndProcequi   , :lhCodPeriodo     , 
                       :ihCodTipoRed   , :szhCodTipVendedor, :szhIdPeriodo); */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 22;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "insert into CMT_VENTAS_PENDIENTES (COD_ESTADO,\
NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_TIPCOMIS,COD\
_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,NOM_VEND_FINAL,COD_CLIENTE,NUM_ABONAD\
O,NUM_CELULAR,NUM_IDENT,COD_PLANTARIF,NUM_SERIE,COD_ARTICULO,IND_PROCEQUI,COD_\
PERIODO,COD_TIPORED,COD_TIPVENDEDOR,ID_PERIODO) values (:b0,:b1,TO_DATE(:b2,'D\
D-MM-YYYY HH24:MI:SS'),null ,null ,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,\
:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )444;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstVenta;
               sqlstm.sqhstl[0] = (unsigned long )3;
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
               sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
               sqlstm.sqhstl[2] = (unsigned long )22;
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)szhNumContrato;
               sqlstm.sqhstl[3] = (unsigned long )21;
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
               sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedor;
               sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[5] = (         int  )0;
               sqlstm.sqindv[5] = (         short *)0;
               sqlstm.sqinds[5] = (         int  )0;
               sqlstm.sqharm[5] = (unsigned long )0;
               sqlstm.sqadto[5] = (unsigned short )0;
               sqlstm.sqtdso[5] = (unsigned short )0;
               sqlstm.sqhstv[6] = (unsigned char  *)&lhCodVendComis;
               sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[6] = (         int  )0;
               sqlstm.sqindv[6] = (         short *)0;
               sqlstm.sqinds[6] = (         int  )0;
               sqlstm.sqharm[6] = (unsigned long )0;
               sqlstm.sqadto[6] = (unsigned short )0;
               sqlstm.sqtdso[6] = (unsigned short )0;
               sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendDealer;
               sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[7] = (         int  )0;
               sqlstm.sqindv[7] = (         short *)0;
               sqlstm.sqinds[7] = (         int  )0;
               sqlstm.sqharm[7] = (unsigned long )0;
               sqlstm.sqadto[7] = (unsigned short )0;
               sqlstm.sqtdso[7] = (unsigned short )0;
               sqlstm.sqhstv[8] = (unsigned char  *)szhNomVendDealer;
               sqlstm.sqhstl[8] = (unsigned long )41;
               sqlstm.sqhsts[8] = (         int  )0;
               sqlstm.sqindv[8] = (         short *)0;
               sqlstm.sqinds[8] = (         int  )0;
               sqlstm.sqharm[8] = (unsigned long )0;
               sqlstm.sqadto[8] = (unsigned short )0;
               sqlstm.sqtdso[8] = (unsigned short )0;
               sqlstm.sqhstv[9] = (unsigned char  *)&lhCodCliente;
               sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[9] = (         int  )0;
               sqlstm.sqindv[9] = (         short *)0;
               sqlstm.sqinds[9] = (         int  )0;
               sqlstm.sqharm[9] = (unsigned long )0;
               sqlstm.sqadto[9] = (unsigned short )0;
               sqlstm.sqtdso[9] = (unsigned short )0;
               sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
               sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[10] = (         int  )0;
               sqlstm.sqindv[10] = (         short *)0;
               sqlstm.sqinds[10] = (         int  )0;
               sqlstm.sqharm[10] = (unsigned long )0;
               sqlstm.sqadto[10] = (unsigned short )0;
               sqlstm.sqtdso[10] = (unsigned short )0;
               sqlstm.sqhstv[11] = (unsigned char  *)&lhNumCelular;
               sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[11] = (         int  )0;
               sqlstm.sqindv[11] = (         short *)0;
               sqlstm.sqinds[11] = (         int  )0;
               sqlstm.sqharm[11] = (unsigned long )0;
               sqlstm.sqadto[11] = (unsigned short )0;
               sqlstm.sqtdso[11] = (unsigned short )0;
               sqlstm.sqhstv[12] = (unsigned char  *)szhNumIdent;
               sqlstm.sqhstl[12] = (unsigned long )21;
               sqlstm.sqhsts[12] = (         int  )0;
               sqlstm.sqindv[12] = (         short *)0;
               sqlstm.sqinds[12] = (         int  )0;
               sqlstm.sqharm[12] = (unsigned long )0;
               sqlstm.sqadto[12] = (unsigned short )0;
               sqlstm.sqtdso[12] = (unsigned short )0;
               sqlstm.sqhstv[13] = (unsigned char  *)szhCodPlanTarif;
               sqlstm.sqhstl[13] = (unsigned long )4;
               sqlstm.sqhsts[13] = (         int  )0;
               sqlstm.sqindv[13] = (         short *)0;
               sqlstm.sqinds[13] = (         int  )0;
               sqlstm.sqharm[13] = (unsigned long )0;
               sqlstm.sqadto[13] = (unsigned short )0;
               sqlstm.sqtdso[13] = (unsigned short )0;
               sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[14] = (unsigned long )26;
               sqlstm.sqhsts[14] = (         int  )0;
               sqlstm.sqindv[14] = (         short *)0;
               sqlstm.sqinds[14] = (         int  )0;
               sqlstm.sqharm[14] = (unsigned long )0;
               sqlstm.sqadto[14] = (unsigned short )0;
               sqlstm.sqtdso[14] = (unsigned short )0;
               sqlstm.sqhstv[15] = (unsigned char  *)&lhCodArticulo;
               sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[15] = (         int  )0;
               sqlstm.sqindv[15] = (         short *)0;
               sqlstm.sqinds[15] = (         int  )0;
               sqlstm.sqharm[15] = (unsigned long )0;
               sqlstm.sqadto[15] = (unsigned short )0;
               sqlstm.sqtdso[15] = (unsigned short )0;
               sqlstm.sqhstv[16] = (unsigned char  *)szhIndProcequi;
               sqlstm.sqhstl[16] = (unsigned long )2;
               sqlstm.sqhsts[16] = (         int  )0;
               sqlstm.sqindv[16] = (         short *)0;
               sqlstm.sqinds[16] = (         int  )0;
               sqlstm.sqharm[16] = (unsigned long )0;
               sqlstm.sqadto[16] = (unsigned short )0;
               sqlstm.sqtdso[16] = (unsigned short )0;
               sqlstm.sqhstv[17] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[17] = (         int  )0;
               sqlstm.sqindv[17] = (         short *)0;
               sqlstm.sqinds[17] = (         int  )0;
               sqlstm.sqharm[17] = (unsigned long )0;
               sqlstm.sqadto[17] = (unsigned short )0;
               sqlstm.sqtdso[17] = (unsigned short )0;
               sqlstm.sqhstv[18] = (unsigned char  *)&ihCodTipoRed;
               sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[18] = (         int  )0;
               sqlstm.sqindv[18] = (         short *)0;
               sqlstm.sqinds[18] = (         int  )0;
               sqlstm.sqharm[18] = (unsigned long )0;
               sqlstm.sqadto[18] = (unsigned short )0;
               sqlstm.sqtdso[18] = (unsigned short )0;
               sqlstm.sqhstv[19] = (unsigned char  *)szhCodTipVendedor;
               sqlstm.sqhstl[19] = (unsigned long )3;
               sqlstm.sqhsts[19] = (         int  )0;
               sqlstm.sqindv[19] = (         short *)0;
               sqlstm.sqinds[19] = (         int  )0;
               sqlstm.sqharm[19] = (unsigned long )0;
               sqlstm.sqadto[19] = (unsigned short )0;
               sqlstm.sqtdso[19] = (unsigned short )0;
               sqlstm.sqhstv[20] = (unsigned char  *)szhIdPeriodo;
               sqlstm.sqhstl[20] = (unsigned long )11;
               sqlstm.sqhsts[20] = (         int  )0;
               sqlstm.sqindv[20] = (         short *)0;
               sqlstm.sqinds[20] = (         int  )0;
               sqlstm.sqharm[20] = (unsigned long )0;
               sqlstm.sqadto[20] = (unsigned short )0;
               sqlstm.sqtdso[20] = (unsigned short )0;
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


            
            if(strcmp(szhFecRecepcion, "0") != 0 && strcmp(szhFecAceptacion, "0") != 0)
               /* EXEC SQL INSERT INTO CMT_VENTAS_PENDIENTES 
                        (COD_ESTADO    , NUM_VENTA     , 
                         FEC_VENTA     , 
                         FEC_RECEPCION , 
                         FEC_ACEPTACION, 
                         NUM_CONTRATO  , COD_TIPCOMIS  , COD_COMISIONISTA, 
                         COD_AGENCIA   , COD_VEND_FINAL, NOM_VEND_FINAL  ,
                         COD_CLIENTE   , NUM_ABONADO   , NUM_CELULAR     ,
                         NUM_IDENT     , COD_PLANTARIF , NUM_SERIE       ,
                         COD_ARTICULO  , IND_PROCEQUI  , COD_PERIODO     , 
                         COD_TIPORED   , COD_TIPVENDEDOR, ID_PERIODO)
               VALUES (:szhIndEstVenta , :lhNumVenta   ,
                       TO_DATE(:szhFecVenta,'DD-MM-YYYY HH24:MI:SS')    ,                          
                       TO_DATE(:szhFecRecepcion,'DD-MM-YYYY HH24:MI:SS'),
                       TO_DATE(:szhFecAceptacion,'DD-MM-YYYY HH24:MI:SS'),
                       :szhNumContrato , :szhCodTipComis   , :lhCodVendedor    ,
                       :lhCodVendComis , :lhCodVendDealer  , :szhNomVendDealer ,
                       :lhCodCliente   , :lhNumAbonado     , :lhNumCelular     ,
                       :szhNumIdent    , :szhCodPlanTarif  , :szhNumSerie      ,
                       :lhCodArticulo  , :szhIndProcequi   , :lhCodPeriodo     , 
                       :ihCodTipoRed   , :szhCodTipVendedor, :szhIdPeriodo); */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 23;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "insert into CMT_VENTAS_PENDIENTES (COD_ESTADO,\
NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_TIPCOMIS,COD\
_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,NOM_VEND_FINAL,COD_CLIENTE,NUM_ABONAD\
O,NUM_CELULAR,NUM_IDENT,COD_PLANTARIF,NUM_SERIE,COD_ARTICULO,IND_PROCEQUI,COD_\
PERIODO,COD_TIPORED,COD_TIPVENDEDOR,ID_PERIODO) values (:b0,:b1,TO_DATE(:b2,'D\
D-MM-YYYY HH24:MI:SS'),TO_DATE(:b3,'DD-MM-YYYY HH24:MI:SS'),TO_DATE(:b4,'DD-MM\
-YYYY HH24:MI:SS'),:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17\
,:b18,:b19,:b20,:b21,:b22)";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )543;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstVenta;
               sqlstm.sqhstl[0] = (unsigned long )3;
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
               sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
               sqlstm.sqhstl[2] = (unsigned long )22;
               sqlstm.sqhsts[2] = (         int  )0;
               sqlstm.sqindv[2] = (         short *)0;
               sqlstm.sqinds[2] = (         int  )0;
               sqlstm.sqharm[2] = (unsigned long )0;
               sqlstm.sqadto[2] = (unsigned short )0;
               sqlstm.sqtdso[2] = (unsigned short )0;
               sqlstm.sqhstv[3] = (unsigned char  *)szhFecRecepcion;
               sqlstm.sqhstl[3] = (unsigned long )22;
               sqlstm.sqhsts[3] = (         int  )0;
               sqlstm.sqindv[3] = (         short *)0;
               sqlstm.sqinds[3] = (         int  )0;
               sqlstm.sqharm[3] = (unsigned long )0;
               sqlstm.sqadto[3] = (unsigned short )0;
               sqlstm.sqtdso[3] = (unsigned short )0;
               sqlstm.sqhstv[4] = (unsigned char  *)szhFecAceptacion;
               sqlstm.sqhstl[4] = (unsigned long )22;
               sqlstm.sqhsts[4] = (         int  )0;
               sqlstm.sqindv[4] = (         short *)0;
               sqlstm.sqinds[4] = (         int  )0;
               sqlstm.sqharm[4] = (unsigned long )0;
               sqlstm.sqadto[4] = (unsigned short )0;
               sqlstm.sqtdso[4] = (unsigned short )0;
               sqlstm.sqhstv[5] = (unsigned char  *)szhNumContrato;
               sqlstm.sqhstl[5] = (unsigned long )21;
               sqlstm.sqhsts[5] = (         int  )0;
               sqlstm.sqindv[5] = (         short *)0;
               sqlstm.sqinds[5] = (         int  )0;
               sqlstm.sqharm[5] = (unsigned long )0;
               sqlstm.sqadto[5] = (unsigned short )0;
               sqlstm.sqtdso[5] = (unsigned short )0;
               sqlstm.sqhstv[6] = (unsigned char  *)szhCodTipComis;
               sqlstm.sqhstl[6] = (unsigned long )3;
               sqlstm.sqhsts[6] = (         int  )0;
               sqlstm.sqindv[6] = (         short *)0;
               sqlstm.sqinds[6] = (         int  )0;
               sqlstm.sqharm[6] = (unsigned long )0;
               sqlstm.sqadto[6] = (unsigned short )0;
               sqlstm.sqtdso[6] = (unsigned short )0;
               sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendedor;
               sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[7] = (         int  )0;
               sqlstm.sqindv[7] = (         short *)0;
               sqlstm.sqinds[7] = (         int  )0;
               sqlstm.sqharm[7] = (unsigned long )0;
               sqlstm.sqadto[7] = (unsigned short )0;
               sqlstm.sqtdso[7] = (unsigned short )0;
               sqlstm.sqhstv[8] = (unsigned char  *)&lhCodVendComis;
               sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[8] = (         int  )0;
               sqlstm.sqindv[8] = (         short *)0;
               sqlstm.sqinds[8] = (         int  )0;
               sqlstm.sqharm[8] = (unsigned long )0;
               sqlstm.sqadto[8] = (unsigned short )0;
               sqlstm.sqtdso[8] = (unsigned short )0;
               sqlstm.sqhstv[9] = (unsigned char  *)&lhCodVendDealer;
               sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[9] = (         int  )0;
               sqlstm.sqindv[9] = (         short *)0;
               sqlstm.sqinds[9] = (         int  )0;
               sqlstm.sqharm[9] = (unsigned long )0;
               sqlstm.sqadto[9] = (unsigned short )0;
               sqlstm.sqtdso[9] = (unsigned short )0;
               sqlstm.sqhstv[10] = (unsigned char  *)szhNomVendDealer;
               sqlstm.sqhstl[10] = (unsigned long )41;
               sqlstm.sqhsts[10] = (         int  )0;
               sqlstm.sqindv[10] = (         short *)0;
               sqlstm.sqinds[10] = (         int  )0;
               sqlstm.sqharm[10] = (unsigned long )0;
               sqlstm.sqadto[10] = (unsigned short )0;
               sqlstm.sqtdso[10] = (unsigned short )0;
               sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCliente;
               sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[11] = (         int  )0;
               sqlstm.sqindv[11] = (         short *)0;
               sqlstm.sqinds[11] = (         int  )0;
               sqlstm.sqharm[11] = (unsigned long )0;
               sqlstm.sqadto[11] = (unsigned short )0;
               sqlstm.sqtdso[11] = (unsigned short )0;
               sqlstm.sqhstv[12] = (unsigned char  *)&lhNumAbonado;
               sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[12] = (         int  )0;
               sqlstm.sqindv[12] = (         short *)0;
               sqlstm.sqinds[12] = (         int  )0;
               sqlstm.sqharm[12] = (unsigned long )0;
               sqlstm.sqadto[12] = (unsigned short )0;
               sqlstm.sqtdso[12] = (unsigned short )0;
               sqlstm.sqhstv[13] = (unsigned char  *)&lhNumCelular;
               sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[13] = (         int  )0;
               sqlstm.sqindv[13] = (         short *)0;
               sqlstm.sqinds[13] = (         int  )0;
               sqlstm.sqharm[13] = (unsigned long )0;
               sqlstm.sqadto[13] = (unsigned short )0;
               sqlstm.sqtdso[13] = (unsigned short )0;
               sqlstm.sqhstv[14] = (unsigned char  *)szhNumIdent;
               sqlstm.sqhstl[14] = (unsigned long )21;
               sqlstm.sqhsts[14] = (         int  )0;
               sqlstm.sqindv[14] = (         short *)0;
               sqlstm.sqinds[14] = (         int  )0;
               sqlstm.sqharm[14] = (unsigned long )0;
               sqlstm.sqadto[14] = (unsigned short )0;
               sqlstm.sqtdso[14] = (unsigned short )0;
               sqlstm.sqhstv[15] = (unsigned char  *)szhCodPlanTarif;
               sqlstm.sqhstl[15] = (unsigned long )4;
               sqlstm.sqhsts[15] = (         int  )0;
               sqlstm.sqindv[15] = (         short *)0;
               sqlstm.sqinds[15] = (         int  )0;
               sqlstm.sqharm[15] = (unsigned long )0;
               sqlstm.sqadto[15] = (unsigned short )0;
               sqlstm.sqtdso[15] = (unsigned short )0;
               sqlstm.sqhstv[16] = (unsigned char  *)szhNumSerie;
               sqlstm.sqhstl[16] = (unsigned long )26;
               sqlstm.sqhsts[16] = (         int  )0;
               sqlstm.sqindv[16] = (         short *)0;
               sqlstm.sqinds[16] = (         int  )0;
               sqlstm.sqharm[16] = (unsigned long )0;
               sqlstm.sqadto[16] = (unsigned short )0;
               sqlstm.sqtdso[16] = (unsigned short )0;
               sqlstm.sqhstv[17] = (unsigned char  *)&lhCodArticulo;
               sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[17] = (         int  )0;
               sqlstm.sqindv[17] = (         short *)0;
               sqlstm.sqinds[17] = (         int  )0;
               sqlstm.sqharm[17] = (unsigned long )0;
               sqlstm.sqadto[17] = (unsigned short )0;
               sqlstm.sqtdso[17] = (unsigned short )0;
               sqlstm.sqhstv[18] = (unsigned char  *)szhIndProcequi;
               sqlstm.sqhstl[18] = (unsigned long )2;
               sqlstm.sqhsts[18] = (         int  )0;
               sqlstm.sqindv[18] = (         short *)0;
               sqlstm.sqinds[18] = (         int  )0;
               sqlstm.sqharm[18] = (unsigned long )0;
               sqlstm.sqadto[18] = (unsigned short )0;
               sqlstm.sqtdso[18] = (unsigned short )0;
               sqlstm.sqhstv[19] = (unsigned char  *)&lhCodPeriodo;
               sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[19] = (         int  )0;
               sqlstm.sqindv[19] = (         short *)0;
               sqlstm.sqinds[19] = (         int  )0;
               sqlstm.sqharm[19] = (unsigned long )0;
               sqlstm.sqadto[19] = (unsigned short )0;
               sqlstm.sqtdso[19] = (unsigned short )0;
               sqlstm.sqhstv[20] = (unsigned char  *)&ihCodTipoRed;
               sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[20] = (         int  )0;
               sqlstm.sqindv[20] = (         short *)0;
               sqlstm.sqinds[20] = (         int  )0;
               sqlstm.sqharm[20] = (unsigned long )0;
               sqlstm.sqadto[20] = (unsigned short )0;
               sqlstm.sqtdso[20] = (unsigned short )0;
               sqlstm.sqhstv[21] = (unsigned char  *)szhCodTipVendedor;
               sqlstm.sqhstl[21] = (unsigned long )3;
               sqlstm.sqhsts[21] = (         int  )0;
               sqlstm.sqindv[21] = (         short *)0;
               sqlstm.sqinds[21] = (         int  )0;
               sqlstm.sqharm[21] = (unsigned long )0;
               sqlstm.sqadto[21] = (unsigned short )0;
               sqlstm.sqtdso[21] = (unsigned short )0;
               sqlstm.sqhstv[22] = (unsigned char  *)szhIdPeriodo;
               sqlstm.sqhstl[22] = (unsigned long )11;
               sqlstm.sqhsts[22] = (         int  )0;
               sqlstm.sqindv[22] = (         short *)0;
               sqlstm.sqinds[22] = (         int  )0;
               sqlstm.sqharm[22] = (unsigned long )0;
               sqlstm.sqadto[22] = (unsigned short )0;
               sqlstm.sqtdso[22] = (unsigned short )0;
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
    stStatusProc.lCantRegistros = lCantAbonados;
    fprintf(stderr,"\n(vInsertaSeleccion)Cantidad de Abonados Insertados:[%ld].\n",lCantAbonados);
    fprintf(pfLog ,"\n(vInsertaSeleccion)Cantidad de Abonados Insertados:[%ld].\n",lCantAbonados);        
}

/*---------------------------------------------------------------------------*/
/* Liberar Memoria Usada para Universo                                       */
/*---------------------------------------------------------------------------*/
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
         fprintf(stderr,"\nConexion con la base de datos ha sido exitosa.\n");
         fprintf(stderr,"Username: %s\n\n", szhUser);
    }
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
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
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )650;
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
 sqlstm.arrsiz = 23;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )665;
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

