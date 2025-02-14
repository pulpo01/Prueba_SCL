
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
           char  filnam[19];
};
static struct sqlcxp sqlfpn =
{
    18,
    "./pc/SEL_bajpre.pc"
};


static unsigned int sqlctx = 13856227;


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
   unsigned char  *sqhstv[26];
   unsigned long  sqhstl[26];
            int   sqhsts[26];
            short *sqindv[26];
            int   sqinds[26];
   unsigned long  sqharm[26];
   unsigned long  *sqharc[26];
   unsigned short  sqadto[26];
   unsigned short  sqtdso[26];
} sqlstm = {12,26};

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
"select distinct CEL.NUM_CONTRATO ,CEL.COD_CLIENTE ,CEL.COD_CAUSABAJA ,TO_CHA\
R(CEL.FEC_BAJA,'DD/MM/YYYY HH24:MI:SS') ,NVL(CEL.NUM_VENTA,0) ,VEN1.FEC_CONTRA\
TO ,NVL(VTAS.COD_VENDEALER,0) ,VTAS.COD_VENDEDOR ,VTAS.COD_VENDEDOR ,TO_CHAR(V\
TAS.FEC_VENTA,'DD/MM/YYYY HH24:MI:SS') ,TO_CHAR(NVL(VTAS.FEC_RECDOCUM,VTAS.FEC\
_VENTA),'DD/MM/YYYY HH24:MI:SS') ,TO_CHAR(NVL(VTAS.FEC_ACEPREC,NVL(VTAS.FEC_RE\
CDOCUM,VTAS.FEC_VENTA)),'DD/MM/YYYY HH24:MI:SS') ,VTAS.IND_ESTVENTA  from GA_A\
BOCEL CEL ,GA_VENTAS VTAS ,VE_VENDEDORES VEN1 ,VE_REDVENTAS_TD RVEN where ((((\
(((((CEL.COD_PRODUCTO=:b0 and CEL.COD_PLANTARIF not  in ('AMI','Y','Z','ZZ','9\
0','91')) and CEL.COD_CAUSABAJA not  in ('39','40')) and CEL.FEC_BAJA>TO_DATE(\
:b1,'DD-MM-YYYY')) and CEL.FEC_BAJA<=TO_DATE(:b2,'DD-MM-YYYY')) and CEL.NUM_VE\
NTA=VTAS.NUM_VENTA) and VTAS.COD_VENDEDOR=VEN1.COD_VENDEDOR) and VEN1.COD_TIPC\
OMIS=:b3) and VEN1.COD_VENDEDOR=RVEN.COD_VENDEDOR) and RVEN.COD_TIPORED=:b4)  \
         ";

 static char *sq0002 = 
"select CEL.NUM_CELULAR ,CEL.COD_PLANTARIF ,CEL.NUM_SERIE ,CEL.NUM_ABONADO ,N\
VL(CEL.COD_AFINIDAD,'0') ,NVL(CEL.COD_TECNOLOGIA,'TDMA')  from GA_ABOCEL CEL w\
here (((((CEL.COD_PRODUCTO=:b0 and CEL.COD_PLANTARIF not  in ('AMI','Y','Z','Z\
Z','90','91')) and CEL.COD_CAUSABAJA not  in ('39','40')) and CEL.FEC_BAJA>TO_\
DATE(:b1,'DD-MM-YYYY')) and CEL.FEC_BAJA<=TO_DATE(:b2,'DD-MM-YYYY')) and CEL.N\
UM_VENTA=:b3)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,943,0,9,203,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
40,0,0,1,0,0,13,207,0,0,13,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
107,0,0,1,0,0,15,259,0,0,0,0,0,1,0,
122,0,0,2,412,0,9,319,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
153,0,0,2,0,0,13,323,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,
192,0,0,2,0,0,15,350,0,0,0,0,0,1,0,
207,0,0,3,335,0,4,376,0,0,5,1,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,1,0,0,1,3,0,0,
242,0,0,4,425,0,4,443,0,0,5,2,0,1,0,2,3,0,0,2,1,0,0,2,3,0,0,1,3,0,0,1,97,0,0,
277,0,0,5,54,0,4,572,0,0,1,0,0,1,0,2,3,0,0,
296,0,0,6,641,0,3,575,0,0,26,26,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,1,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,1,97,0,0,
415,0,0,7,48,0,1,757,0,0,0,0,0,1,0,
430,0,0,8,0,0,30,803,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las Bajas Prematuras x Canal Espec.*/ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 03.                                             */
/* Inicio: Jueves 23 de Agosto del 2001.                                */
/* Fin   : Jueves 06 de Septiembre del 2001.                            */
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
/************************************************************************/
/* 20030905 Marcelo Quiroz G. Versionado Cuzco.                         */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorpora manejo de lista general de tipos de comisionistas.      */
/* Se reestructura proceso en funcion de estructura de tipos de         */
/* comisionistas.                                                       */
/*                                                                      */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "bajpre.h"
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
   char    szhSysDate[17]="";
   char    szFechaYYYYMMDD[9]="";  
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Lista de Tipos de Comisionistas para ejecucion de ciclo                   */
/*---------------------------------------------------------------------------*/
	stTiposComis * lstTiposComis = NULL;    
/*---------------------------------------------------------------------------*/
/* CARGA LISTA DE TIPOS DE COMISIONISTAS, PARA TRATAMINETO DE MULTI-NIVEL.   */
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
		for(paux=lstTiposComis;paux != NULL; paux=paux->sgte)
        {
			fprintf(pfLog ,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s].\n",paux->szCodTipComis,paux->szDesTipComis);
			fprintf(stderr,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s].\n",paux->szCodTipComis,paux->szDesTipComis);
            vSeleccionarUniverso(paux->iCodTipoRed, paux->szCodTipComis, paux->szCodTipVendedor);
		}
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los abonados \n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los abonados \n");
		vGetAbonados(); 
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Recupera los datos del Cliente \n");
		fprintf(stderr,"\n(vCargaTiposComis) Recupera los datos del Cliente \n");
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
		fprintf(pfLog ,"\n(vCargaTiposComis) Libera la memoria utilizada.\n");
		fprintf(stderr,"\n(vCargaTiposComis) Libera la memoria utilizada.\n");
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
    long    	iCantidad    = 0;
	int                        i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
	    long    lMaxFetch ; 

	    int		ihCodTipoRed       ;
        int		ihCodProducto      ;                    
		char    szhCodTipComis [3] ;
	    char    szhFechaInicio [11];
	    char    szhFechaTermino[11];

		char	szhIndEstVenta    [MAXFETCH][3];	   
		long    lhNumVenta        [MAXFETCH];
		long    lhCodVendedor     [MAXFETCH];
		long    lhCodVendComis    [MAXFETCH];
		long	lhCodVendDealer   [MAXFETCH];
	    char    szhFecVenta       [MAXFETCH][20];
	    char    szhFecRecepcion   [MAXFETCH][20];
	    char    szhFecAceptacion  [MAXFETCH][20];
        long    lhCodCliente      [MAXFETCH];
        char	szhNumContrato    [MAXFETCH][20];
        long    lhNumCelular      [MAXFETCH];
        char    szhCodPlantarif   [MAXFETCH][4];
        char    szhNumSerie       [MAXFETCH][26];
        long    lhNumAbonado      [MAXFETCH];
        char    szhCodCausaBaja   [MAXFETCH][3];
        char    szhFecAlta        [MAXFETCH][20];
        char    szhFecContrato    [MAXFETCH][20];
        long    lhCodVendFinal    [MAXFETCH];     
        short   shIndNumVenta     [MAXFETCH];    
        short   shIndCodVendFinal [MAXFETCH];  
        short   shIndFecRecepcion [MAXFETCH];
        short   shIndFecAceptacion[MAXFETCH];
        char	szhCodTipVendedor [3];
                   
    /* EXEC SQL END DECLARE SECTION; */ 
 

    strcpy(szhCodTipComis   , pszCodTipComis)          ;
    strcpy(szhFechaInicio   , stCiclo.szFecDesdeNormal);  
    strcpy(szhFechaTermino  , stCiclo.szFecHastaNormal); 
    strcpy(szhCodTipVendedor, pszCodTipVendedor);
	
    ihCodTipoRed   = piCodTipoRed;
	ihCodProducto  = 1;
    lMaxFetch      = MAXFETCH;     
    paux           = NULL;
    
    /* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR
         SELECT  DISTINCT 
		 		 CEL.NUM_CONTRATO,
                 CEL.COD_CLIENTE,
                 CEL.COD_CAUSABAJA,
                 TO_CHAR(CEL.FEC_BAJA, 'DD/MM/YYYY HH24:MI:SS'),
                 NVL(CEL.NUM_VENTA, 0),
                 VEN1.FEC_CONTRATO,
                 NVL(VTAS.COD_VENDEALER,0),
                 VTAS.COD_VENDEDOR,
                 VTAS.COD_VENDEDOR,
                 TO_CHAR(VTAS.FEC_VENTA, 'DD/MM/YYYY HH24:MI:SS'),
                 TO_CHAR(NVL(VTAS.FEC_RECDOCUM,VTAS.FEC_VENTA), 'DD/MM/YYYY HH24:MI:SS'),
                 TO_CHAR(NVL(VTAS.FEC_ACEPREC,NVL(VTAS.FEC_RECDOCUM,VTAS.FEC_VENTA) ), 'DD/MM/YYYY HH24:MI:SS'),
                 VTAS.IND_ESTVENTA
         FROM    GA_ABOCEL       CEL ,
                 GA_VENTAS       VTAS,
                 VE_VENDEDORES   VEN1, 
				 VE_REDVENTAS_TD RVEN
         WHERE   CEL.COD_PRODUCTO  = :ihCodProducto
           AND   CEL.COD_PLANTARIF NOT IN ('AMI','Y','Z','ZZ','90','91')
           AND   CEL.COD_CAUSABAJA NOT IN ('39','40')
           AND   CEL.FEC_BAJA      > TO_DATE(:szhFechaInicio,'DD-MM-YYYY')
           AND   CEL.FEC_BAJA     <= TO_DATE(:szhFechaTermino,'DD-MM-YYYY')
           AND   CEL.NUM_VENTA     = VTAS.NUM_VENTA
           AND   VTAS.COD_VENDEDOR = VEN1.COD_VENDEDOR
           AND 	 VEN1.COD_TIPCOMIS = :szhCodTipVendedor
		   AND   VEN1.COD_VENDEDOR = RVEN.COD_VENDEDOR
		   AND   RVEN.COD_TIPORED  = :ihCodTipoRed; */ 

                  
    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

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
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipVendedor;
    sqlstm.sqhstl[3] = (unsigned long )3;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipoRed;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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

 

    while (iFetchedRows == iRetrievRows)
    {
          /* EXEC SQL for :lMaxFetch 
                        FETCH cur_universo INTO
                            :szhNumContrato     ,                    
                            :lhCodCliente       ,                     
                            :szhCodCausaBaja    ,                    
                            :szhFecAlta         ,                     
                            :lhNumVenta:shIndNumVenta          ,                   
                            :szhFecContrato     ,
                            :lhCodVendFinal:shIndCodVendFinal  ,                    
                            :lhCodVendedor      ,                                                 
                            :lhCodVendDealer    ,                     
                            :szhFecVenta        ,                   
                            :szhFecRecepcion:shIndFecRecepcion  ,                     
                            :szhFecAceptacion:shIndFecAceptacion,                    
                            :szhIndEstVenta     ; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 13;
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
          sqlstm.sqhstv[0] = (unsigned char  *)szhNumContrato;
          sqlstm.sqhstl[0] = (unsigned long )20;
          sqlstm.sqhsts[0] = (         int  )20;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqharc[0] = (unsigned long  *)0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)lhCodCliente;
          sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[1] = (         int  )sizeof(long);
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqharc[1] = (unsigned long  *)0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)szhCodCausaBaja;
          sqlstm.sqhstl[2] = (unsigned long )3;
          sqlstm.sqhsts[2] = (         int  )3;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqharc[2] = (unsigned long  *)0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)szhFecAlta;
          sqlstm.sqhstl[3] = (unsigned long )20;
          sqlstm.sqhsts[3] = (         int  )20;
          sqlstm.sqindv[3] = (         short *)0;
          sqlstm.sqinds[3] = (         int  )0;
          sqlstm.sqharm[3] = (unsigned long )0;
          sqlstm.sqharc[3] = (unsigned long  *)0;
          sqlstm.sqadto[3] = (unsigned short )0;
          sqlstm.sqtdso[3] = (unsigned short )0;
          sqlstm.sqhstv[4] = (unsigned char  *)lhNumVenta;
          sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[4] = (         int  )sizeof(long);
          sqlstm.sqindv[4] = (         short *)shIndNumVenta;
          sqlstm.sqinds[4] = (         int  )sizeof(short);
          sqlstm.sqharm[4] = (unsigned long )0;
          sqlstm.sqharc[4] = (unsigned long  *)0;
          sqlstm.sqadto[4] = (unsigned short )0;
          sqlstm.sqtdso[4] = (unsigned short )0;
          sqlstm.sqhstv[5] = (unsigned char  *)szhFecContrato;
          sqlstm.sqhstl[5] = (unsigned long )20;
          sqlstm.sqhsts[5] = (         int  )20;
          sqlstm.sqindv[5] = (         short *)0;
          sqlstm.sqinds[5] = (         int  )0;
          sqlstm.sqharm[5] = (unsigned long )0;
          sqlstm.sqharc[5] = (unsigned long  *)0;
          sqlstm.sqadto[5] = (unsigned short )0;
          sqlstm.sqtdso[5] = (unsigned short )0;
          sqlstm.sqhstv[6] = (unsigned char  *)lhCodVendFinal;
          sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[6] = (         int  )sizeof(long);
          sqlstm.sqindv[6] = (         short *)shIndCodVendFinal;
          sqlstm.sqinds[6] = (         int  )sizeof(short);
          sqlstm.sqharm[6] = (unsigned long )0;
          sqlstm.sqharc[6] = (unsigned long  *)0;
          sqlstm.sqadto[6] = (unsigned short )0;
          sqlstm.sqtdso[6] = (unsigned short )0;
          sqlstm.sqhstv[7] = (unsigned char  *)lhCodVendedor;
          sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[7] = (         int  )sizeof(long);
          sqlstm.sqindv[7] = (         short *)0;
          sqlstm.sqinds[7] = (         int  )0;
          sqlstm.sqharm[7] = (unsigned long )0;
          sqlstm.sqharc[7] = (unsigned long  *)0;
          sqlstm.sqadto[7] = (unsigned short )0;
          sqlstm.sqtdso[7] = (unsigned short )0;
          sqlstm.sqhstv[8] = (unsigned char  *)lhCodVendDealer;
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
          sqlstm.sqhstv[11] = (unsigned char  *)szhFecAceptacion;
          sqlstm.sqhstl[11] = (unsigned long )20;
          sqlstm.sqhsts[11] = (         int  )20;
          sqlstm.sqindv[11] = (         short *)shIndFecAceptacion;
          sqlstm.sqinds[11] = (         int  )sizeof(short);
          sqlstm.sqharm[11] = (unsigned long )0;
          sqlstm.sqharc[11] = (unsigned long  *)0;
          sqlstm.sqadto[11] = (unsigned short )0;
          sqlstm.sqtdso[11] = (unsigned short )0;
          sqlstm.sqhstv[12] = (unsigned char  *)szhIndEstVenta;
          sqlstm.sqhstl[12] = (unsigned long )3;
          sqlstm.sqhsts[12] = (         int  )3;
          sqlstm.sqindv[12] = (         short *)0;
          sqlstm.sqinds[12] = (         int  )0;
          sqlstm.sqharm[12] = (unsigned long )0;
          sqlstm.sqharc[12] = (unsigned long  *)0;
          sqlstm.sqadto[12] = (unsigned short )0;
          sqlstm.sqtdso[12] = (unsigned short )0;
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

                strcpy(paux->szNumContrato   , szfnTrim(szhNumContrato[i]));
                paux->lCodCliente            = lhCodCliente[i];
                strcpy(paux->szCodCausaBaja  , szfnTrim(szhCodCausaBaja[i]));
                strcpy(paux->szFecAlta       , szfnTrim(szhFecAlta[i]));
                paux->lNumVenta              = lhNumVenta[i];
                strcpy(paux->szFecContrato   , szfnTrim(szhFecContrato[i]));
                paux->lCodVendFinal          = lhCodVendFinal[i];
                paux->lCodVendedor           = lhCodVendedor[i];
                paux->lCodVendComis          = lObtieneVendedorPadre(paux->lCodVendedor, ihCodTipoRed, szhCodTipComis);
                paux->lCodVendDealer         = lhCodVendDealer[i];
                strcpy(paux->szFecVenta      , szfnTrim(szhFecVenta[i]));
                strcpy(paux->szFecRecepcion  , szfnTrim(szhFecRecepcion[i]));
                strcpy(paux->szFecAceptacion , szfnTrim(szhFecAceptacion[i]));
                strcpy(paux->szIndEstVenta   , szfnTrim(szhIndEstVenta[i]));
                paux->sIndNumVenta           = shIndNumVenta[i]; 
                paux->sIndCodVendFinal       = shIndCodVendFinal[i]; 
                paux->sIndFecRecepcion       = shIndFecRecepcion[i];
                paux->sIndFecAceptacion      = shIndFecAceptacion[i];
				strcpy(paux->szCodTipComis   , szhCodTipComis);				
				strcpy(paux->szCodTipVendedor, szhCodTipVendedor);
				paux->iCodTipoRed            = ihCodTipoRed;
                paux->cIndConsidera			 = 'S';

                paux->abonado_sgte 			 = NULL;
                paux->sgte 					 = lstUniverso;
                lstUniverso 				 = paux;
                iCantidad++;                
            }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )107;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog, "\n(vSeleccionarUniverso)Tipo Comisionista:[%s] Cantidad de BAJAS Extraidas:[%ld].\n", szhCodTipComis, iCantidad);        
}
/*******************************************************************************/
/*Del universo seleccionado, ahora se rescatan los abonados.                   */
/*******************************************************************************/
void vGetAbonados()
{	
    stUniverso * paux;
    stAbonado  * aaux;

    int         i;      
    short       iLastRows    = 0;       
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
    int			iCantAbonados = 0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
		char    szhCodTipComis[3];
        char    szhFechaInicio[11];
	    char    szhFechaTermino[11];
	    long    lhNumVenta;
	    int		ihCodProducto;     
		long    lMaxFetch;   	
	    long    lhNumCelular[MAXFETCH];
	    char    szhCodPlanTarif[MAXFETCH][4];
	    char    szhNumSerie[MAXFETCH][26];
	    long    lhNumAbonado[MAXFETCH];
	    int   	ihCodAfinidad[MAXFETCH];
	    char    szhCodTecnologia[MAXFETCH][8]; 	    
    /* EXEC SQL END DECLARE SECTION; */ 

    ihCodProducto = 1;
	for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		paux->abonado_sgte     = NULL;
	    strcpy(szhCodTipComis  , paux->szCodTipComis);
        strcpy(szhFechaInicio  , stCiclo.szFecDesdeNormal);  
        strcpy(szhFechaTermino , stCiclo.szFecHastaNormal); 

  		lhNumVenta    = paux->lNumVenta;
		iCantAbonados = 0;
		iLastRows    = 0;       
		iFetchedRows = MAXFETCH;
		iRetrievRows = MAXFETCH;
    	lMaxFetch     = MAXFETCH;
        /* EXEC SQL DECLARE CUR_ABONADOS CURSOR FOR SELECT
                      CEL.NUM_CELULAR,
                      CEL.COD_PLANTARIF,
                      CEL.NUM_SERIE,
                      CEL.NUM_ABONADO,
                      NVL(CEL.COD_AFINIDAD,'0'),
                      NVL(CEL.COD_TECNOLOGIA,'TDMA')                       
              FROM    GA_ABOCEL       CEL
              WHERE   CEL.COD_PRODUCTO  = :ihCodProducto 
                AND   CEL.COD_PLANTARIF NOT IN ('AMI','Y','Z','ZZ','90','91')
                AND   CEL.COD_CAUSABAJA NOT IN ('39','40')
                AND   CEL.FEC_BAJA      > TO_DATE(:szhFechaInicio,'DD-MM-YYYY')
                AND   CEL.FEC_BAJA     <= TO_DATE(:szhFechaTermino,'DD-MM-YYYY')
                AND   CEL.NUM_VENTA     = :lhNumVenta; */ 

                         
		/* EXEC SQL OPEN CUR_ABONADOS; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0002;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )122;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[3] = (unsigned char  *)&lhNumVenta;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
			/* EXEC SQL for :lMaxFetch FETCH cur_abonados
               	INTO    :lhNumCelular     ,
                        :szhCodPlanTarif  ,
                        :szhNumSerie      ,
                        :lhNumAbonado     ,
                        :ihCodAfinidad    ,
                        :szhCodTecnologia ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )lMaxFetch;
   sqlstm.offset = (unsigned int  )153;
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
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
   sqlstm.sqhstl[1] = (unsigned long )4;
   sqlstm.sqhsts[1] = (         int  )4;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhNumSerie;
   sqlstm.sqhstl[2] = (unsigned long )26;
   sqlstm.sqhsts[2] = (         int  )26;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)lhNumAbonado;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )sizeof(long);
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)ihCodAfinidad;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )sizeof(int);
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodTecnologia;
   sqlstm.sqhstl[5] = (unsigned long )8;
   sqlstm.sqhsts[5] = (         int  )8;
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
                    aaux = (stAbonado *) malloc (sizeof(stAbonado));

                    aaux->lNumCelular         	= lhNumCelular[i];
                    aaux->lNumAbonado         	= lhNumAbonado[i];
                    aaux->iCodAfinidad        	= ihCodAfinidad[i];
                    aaux->cIndConsidera    		= 'S';
                    strcpy(aaux->szCodPlanTarif	, szfnTrim(szhCodPlanTarif[i]));
                    strcpy(aaux->szNumSerie    	, szfnTrim(szhNumSerie[i]));
                    strcpy(aaux->szCodTecnologia, szfnTrim(szhCodTecnologia[i])); 
                    aaux->sgte 					= paux->abonado_sgte;
                    paux->abonado_sgte 			= aaux;
                    iCantAbonados++;
			}
		} 
        /* EXEC SQL CLOSE CUR_ABONADOS; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )192;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


        if (iCantAbonados==0)
           paux->cIndConsidera = 'N';
	} 	         
}
/******************************************************************************/
/* Del universo seleccionado, ahora se obtienen las categorias de clientes    */
/******************************************************************************/
void vGetClientes()
{
    stUniverso       * paux;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int     ihCodCategoria;
         long    lhCodCliente;
         char    szhCodCaTribut;
         char    szhTipIdent[3];
         char    szhNumIdent[21];       
    /* EXEC SQL END DECLARE SECTION; */ 
 

    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
         lhCodCliente = paux->lCodCliente;

         if (paux->cIndConsidera == 'S')
         {
             /* EXEC SQL SELECT clie.NUM_IDENT,
                             clie.cod_tipident,
                             nvl(clie.cod_categoria, -1),
                             catri.cod_catribut
                     INTO    :szhNumIdent,
                             :szhTipIdent,
                             :ihCodCategoria,
                             :szhCodCaTribut
                     FROM    ge_clientes clie,
                             ga_catributclie catri
                     WHERE   clie.cod_cliente = :lhCodCliente
                     AND     clie.cod_cliente = catri.cod_cliente
                     AND     catri.fec_desde =
                                (SELECT max(e.fec_desde)
                                FROM   ga_catributclie e
                                WHERE  catri.cod_cliente = e.cod_cliente); */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 13;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "select clie.NUM_IDENT ,clie.cod_tipident ,nvl(cl\
ie.cod_categoria,(-1)) ,catri.cod_catribut into :b0,:b1,:b2,:b3  from ge_clien\
tes clie ,ga_catributclie catri where ((clie.cod_cliente=:b4 and clie.cod_clie\
nte=catri.cod_cliente) and catri.fec_desde=(select max(e.fec_desde)  from ga_c\
atributclie e where catri.cod_cliente=e.cod_cliente))";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )207;
             sqlstm.selerr = (unsigned short)1;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
             sqlstm.sqhstl[0] = (unsigned long )21;
             sqlstm.sqhsts[0] = (         int  )0;
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)szhTipIdent;
             sqlstm.sqhstl[1] = (unsigned long )3;
             sqlstm.sqhsts[1] = (         int  )0;
             sqlstm.sqindv[1] = (         short *)0;
             sqlstm.sqinds[1] = (         int  )0;
             sqlstm.sqharm[1] = (unsigned long )0;
             sqlstm.sqadto[1] = (unsigned short )0;
             sqlstm.sqtdso[1] = (unsigned short )0;
             sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCategoria;
             sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[2] = (         int  )0;
             sqlstm.sqindv[2] = (         short *)0;
             sqlstm.sqinds[2] = (         int  )0;
             sqlstm.sqharm[2] = (unsigned long )0;
             sqlstm.sqadto[2] = (unsigned short )0;
             sqlstm.sqtdso[2] = (unsigned short )0;
             sqlstm.sqhstv[3] = (unsigned char  *)&szhCodCaTribut;
             sqlstm.sqhstl[3] = (unsigned long )1;
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
            	fprintf(stderr,"\n(vGetClientes) Cliente:[%ld] Sin datos. Baja [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);
            	fprintf(pfLog ,"\n(vGetClientes) Cliente:[%ld] Sin datos. Baja [%ld] no sera considerada.\n", lhCodCliente, paux->lNumVenta);                        
             }
             else
             {
                strcpy(paux->szNumIdent 	, szfnTrim(szhNumIdent));
                strcpy(paux->szTipIdent 	, szfnTrim(szhTipIdent));
                paux->iCodCategoria     	= ihCodCategoria;
                paux->szCodCaTribut			= szhCodCaTribut;
             }
         }
    }
        
}
/******************************************************************************/
/* Del abonado seleccionado, ahora se revisan los equipos.                    */
/******************************************************************************/
void vGetEquipos()
{
     stUniverso	  * paux;
     stAbonado    * aaux;
  	 
 	 long		lCantVentas 	= 0;
 	 long		lCantAbonados 	= 0;
 	 long		lCantAbonadosX	= 0;

     /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
         	long  	lhNumAbonado;
            long    lhCodArticulo;
            short   shCodFabricante;
            char    szhNumSerie[26];
            char    chIndProcequi;
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
                        lhNumAbonado       = aaux->lNumAbonado;
                        strcpy(szhNumSerie , aaux->szNumSerie);
						lCantAbonados++;
						
                        /* EXEC SQL SELECT equi.cod_articulo, 
                                        equi.ind_procequi,
                                        fabr.cod_fabricante
                                INTO    :lhCodArticulo,
                                        :chIndProcequi,
                                        :shCodFabricante
                                FROM    al_fabricantes fabr,
                                        al_articulos   arti,
                                        ga_equipaboser equi
                                WHERE   equi.num_abonado    = :lhNumAbonado
                                AND     equi.num_serie      = :szhNumSerie
                                AND     equi.cod_articulo   = arti.cod_articulo 
                                AND     arti.cod_fabricante = fabr.cod_fabricante
                                AND     equi.fec_alta       = (SELECT max(r.fec_alta)
                                                               FROM   ga_equipaboser r
                                                               WHERE  r.num_abonado = equi.num_abonado
                                                               AND    r.num_serie   = equi.num_serie); */ 

{
                        struct sqlexd sqlstm;
                        sqlstm.sqlvsn = 12;
                        sqlstm.arrsiz = 13;
                        sqlstm.sqladtp = &sqladt;
                        sqlstm.sqltdsp = &sqltds;
                        sqlstm.stmt = "select equi.cod_articulo ,equi.ind_pr\
ocequi ,fabr.cod_fabricante into :b0,:b1,:b2  from al_fabricantes fabr ,al_art\
iculos arti ,ga_equipaboser equi where ((((equi.num_abonado=:b3 and equi.num_s\
erie=:b4) and equi.cod_articulo=arti.cod_articulo) and arti.cod_fabricante=fab\
r.cod_fabricante) and equi.fec_alta=(select max(r.fec_alta)  from ga_equipabos\
er r where (r.num_abonado=equi.num_abonado and r.num_serie=equi.num_serie)))";
                        sqlstm.iters = (unsigned int  )1;
                        sqlstm.offset = (unsigned int  )242;
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
                        sqlstm.sqhstv[1] = (unsigned char  *)&chIndProcequi;
                        sqlstm.sqhstl[1] = (unsigned long )1;
                        sqlstm.sqhsts[1] = (         int  )0;
                        sqlstm.sqindv[1] = (         short *)0;
                        sqlstm.sqinds[1] = (         int  )0;
                        sqlstm.sqharm[1] = (unsigned long )0;
                        sqlstm.sqadto[1] = (unsigned short )0;
                        sqlstm.sqtdso[1] = (unsigned short )0;
                        sqlstm.sqhstv[2] = (unsigned char  *)&shCodFabricante;
                        sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
                        sqlstm.sqhsts[2] = (         int  )0;
                        sqlstm.sqindv[2] = (         short *)0;
                        sqlstm.sqinds[2] = (         int  )0;
                        sqlstm.sqharm[2] = (unsigned long )0;
                        sqlstm.sqadto[2] = (unsigned short )0;
                        sqlstm.sqtdso[2] = (unsigned short )0;
                        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
                        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
                        sqlstm.sqhsts[3] = (         int  )0;
                        sqlstm.sqindv[3] = (         short *)0;
                        sqlstm.sqinds[3] = (         int  )0;
                        sqlstm.sqharm[3] = (unsigned long )0;
                        sqlstm.sqadto[3] = (unsigned short )0;
                        sqlstm.sqtdso[3] = (unsigned short )0;
                        sqlstm.sqhstv[4] = (unsigned char  *)szhNumSerie;
                        sqlstm.sqhstl[4] = (unsigned long )26;
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



                        if (sqlca.sqlcode) 
                        {
                    		fprintf(stderr,"\n(vGetEquipos) Abonado:[%d] Serie:[%s] No fue posible recuperar datos del equipo.", lhNumAbonado, szhNumSerie);
                    		fprintf(pfLog ,"\n(vGetEquipos) Abonado:[%d] Serie:[%s] No fue posible recuperar datos del equipo.", lhNumAbonado, szhNumSerie);
                    		aaux->cIndConsidera = 'N';
                    		lCantAbonadosX++;
                    	}
                        else
                        {
                            aaux->lCodArticulo   = lhCodArticulo;
                            aaux->cIndProcequi   = chIndProcequi;
                            aaux->sCodFabricante = shCodFabricante;
                            aaux->cIndConsidera  = 'S';
                        }
                   }
               }
            }   
     }
    fprintf(stderr,"\n(vGetEquipos) Fin de Funcion que recupera datos de Equipos.");
    fprintf(stderr,"\n(vGetEquipos) Ventas Examinadas (solo validas):       [%ld].", lCantVentas);
    fprintf(stderr,"\n(vGetEquipos) Abonados con datos de Equipo Correcto:  [%ld].", lCantAbonados);
    fprintf(stderr,"\n(vGetEquipos) Abonados Sin datos de Equipo:           [%ld].", lCantAbonadosX);

    fprintf(pfLog,"\n(vGetEquipos) Fin de Funcion que recupera datos de Equipos.");
    fprintf(pfLog,"\n(vGetEquipos) Ventas Examinadas (solo validas):       [%ld].", lCantVentas);
    fprintf(pfLog,"\n(vGetEquipos) Abonados con datos de Equipo Correcto:  [%ld].", lCantAbonados);
    fprintf(pfLog,"\n(vGetEquipos) Abonados Sin datos de Equipo:           [%ld].", lCantAbonadosX);         
}
/*****************************************************************************/
/* Insercion de valores en tabla de salida                                   */
/*****************************************************************************/
void vInsertaSeleccion()
{
    stUniverso	* paux;
    stAbonado   * aaux;
    long        lCantRegistros;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhFecVenta[20]      ;
         char    szhFecRecepcion[20]  ;
         char    szhFecAceptacion[20] ;
         char    szhFecAlta[20]       ;
         char    szhNumContrato[20]   ;
         char    szhCodTipComis[3]    ;
         int     lhCodVendComis       ;
         int     lhCodVendDealer      ;
         long    lhNumVenta           ;
         long    lhCodVendedor        ;
         long    lhCodCliente         ;
         long    lhNumAbonado         ;
         long    lhCodVendFinal       ;
         long    lhNumCelular         ;
         char    szhCodPlantarif[4]   ;
         char    szhNumSerie[26]      ;
         long    lhCodArticulo        ;
         char    chIndProcequi        ;
         char    szhCodCategoria[15]  ;
         char    szhNumIdent[21]      ;    
         long    lhSecuencia          ;
         short   shCodFabricante      ;
         char    szhCodCausaBaja[3]   ;
         char    szhIdCiclComis[11]   ;
         long    lhCodCiclComis       ;
   	     int	 ihCodTipoRed         ;
   	     short   shIndNumVenta        ; 
         short   shIndCodVendFinal    ;       
         short   shIndFecRecepcion    ;                                        	             
         short   shIndFecAceptacion   ;     
         char	szhCodTipVendedor[3]  ;
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
                   strcpy(szhNumIdent          , paux->szNumIdent)      ; 
                   lhCodVendFinal              = paux->lCodVendFinal    ;
                   strcpy(szhFecVenta          , paux->szFecVenta)      ;
                   strcpy(szhFecRecepcion      , paux->szFecRecepcion)  ;
                   strcpy(szhFecAceptacion     , paux->szFecAceptacion) ;
                   strcpy(szhFecAlta           , paux->szFecAlta)       ;
                   strcpy(szhNumContrato       , paux->szNumContrato)   ;
                   lhCodVendComis              = paux->lCodVendComis    ;
                   lhCodVendDealer             = paux->lCodVendDealer   ;
                   lhCodVendedor               = paux->lCodVendedor     ;
                   lhCodCliente                = paux->lCodCliente      ;                        
                   lhNumVenta                  = paux->lNumVenta        ;
                   strcpy(szhCodTipComis       , paux->szCodTipComis)   ;   
                   strcpy(szhCodCausaBaja      , paux->szCodCausaBaja)  ;
                   strcpy(szhCodPlantarif      , aaux->szCodPlanTarif)  ;
             	   ihCodTipoRed        		   = paux->iCodTipoRed      ;  
				   shIndNumVenta               = paux->sIndNumVenta     ;   
				   shIndCodVendFinal           = paux->sIndCodVendFinal ;   
                   shIndFecRecepcion           = paux->sIndFecRecepcion ;
                   shIndFecAceptacion          = paux->sIndFecAceptacion;
                   
                   lhNumAbonado                = aaux->lNumAbonado      ;                                 
                   lhNumCelular                = aaux->lNumCelular      ;
                   strcpy(szhNumSerie          , aaux->szNumSerie)      ;
                   chIndProcequi               = aaux->cIndProcequi     ;
                   lhCodArticulo               = aaux->lCodArticulo     ;
                   shCodFabricante             = aaux->sCodFabricante   ;
                   strcpy(szhCodTipVendedor	   , paux->szCodTipVendedor);
                   strcpy(szhCodCategoria      , szfnGetCategCliente(paux->szCodCaTribut,szhNumIdent));                   

                   /* EXEC SQL SELECT CMS_REG_SELECCION.nextval INTO :lhSecuencia FROM dual; */ 

{
                   struct sqlexd sqlstm;
                   sqlstm.sqlvsn = 12;
                   sqlstm.arrsiz = 13;
                   sqlstm.sqladtp = &sqladt;
                   sqlstm.sqltdsp = &sqltds;
                   sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b0\
  from dual ";
                   sqlstm.iters = (unsigned int  )1;
                   sqlstm.offset = (unsigned int  )277;
                   sqlstm.selerr = (unsigned short)1;
                   sqlstm.cud = sqlcud0;
                   sqlstm.sqlest = (unsigned char  *)&sqlca;
                   sqlstm.sqlety = (unsigned short)256;
                   sqlstm.occurs = (unsigned int  )0;
                   sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
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


                   lCantRegistros++;
        
                   /* EXEC SQL INSERT INTO CMT_BAJAS_CELULAR (
                            NUM_GENERAL     , COD_TIPCOMIS     , COD_COMISIONISTA, 
                            COD_AGENCIA     , COD_CLIENTE      , NUM_CONTRATO    , 
                            NUM_ABONADO     , NUM_CELULAR      , 
                            FEC_VENTA       , 
                            FEC_RECEPCION   , 
                            FEC_ACEPTACION  , 
                            FEC_BAJA        , 
                            COD_CAUSABAJA   , NUM_SERIE        , COD_ARTICULO    , 
                            COD_FABRICANTE  , IND_PROCEQUI     , COD_PERIODO     , 
                            ID_PERIODO      , COD_CATEGCLIENTE , COD_PLANTARIF   ,
                            NUM_VENTA       , 
                            COD_VEND_FINAL  , 
                            NUM_IDENT       , COD_TIPORED, COD_TIPVENDEDOR)
                   VALUES (
                            :lhSecuencia    , :szhCodTipComis  , :lhCodVendComis , 
                            :lhCodVendDealer, :lhCodCliente    , :szhNumContrato ,
                            :lhNumAbonado   , :lhNumCelular    , 
                            to_date(:szhFecVenta,'dd/mm/yyyy hh24:mi:ss')        ,
                            to_date(:szhFecRecepcion:shIndFecRecepcion,'dd/mm/yyyy hh24:mi:ss'),
                            to_date(:szhFecAceptacion:shIndFecAceptacion,'dd/mm/yyyy hh24:mi:ss'),
                            to_date(:szhFecAlta,'dd/mm/yyyy hh24:mi:ss')         ,
                            :szhCodCausaBaja, :szhNumSerie     , :lhCodArticulo  ,
                            :shCodFabricante, :chIndProcequi   , :lhCodCiclComis ,
                            :szhIdCiclComis , :szhCodCategoria , :szhCodPlantarif,
                            :lhNumVenta:shIndNumVenta          ,
                            :lhCodVendFinal:shIndCodVendFinal  , 
                            :szhNumIdent    , :ihCodTipoRed, :szhCodTipVendedor); */ 

{
                   struct sqlexd sqlstm;
                   sqlstm.sqlvsn = 12;
                   sqlstm.arrsiz = 26;
                   sqlstm.sqladtp = &sqladt;
                   sqlstm.sqltdsp = &sqltds;
                   sqlstm.stmt = "insert into CMT_BAJAS_CELULAR (NUM_GENERAL\
,COD_TIPCOMIS,COD_COMISIONISTA,COD_AGENCIA,COD_CLIENTE,NUM_CONTRATO,NUM_ABONAD\
O,NUM_CELULAR,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,FEC_BAJA,COD_CAUSABAJA,NU\
M_SERIE,COD_ARTICULO,COD_FABRICANTE,IND_PROCEQUI,COD_PERIODO,ID_PERIODO,COD_CA\
TEGCLIENTE,COD_PLANTARIF,NUM_VENTA,COD_VEND_FINAL,NUM_IDENT,COD_TIPORED,COD_TI\
PVENDEDOR) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,to_date(:b8,'dd/mm/yyyy hh2\
4:mi:ss'),to_date(:b9:b10,'dd/mm/yyyy hh24:mi:ss'),to_date(:b11:b12,'dd/mm/yyy\
y hh24:mi:ss'),to_date(:b13,'dd/mm/yyyy hh24:mi:ss'),:b14,:b15,:b16,:b17,:b18,\
:b19,:b20,:b21,:b22,:b23:b24,:b25:b26,:b27,:b28,:b29)";
                   sqlstm.iters = (unsigned int  )1;
                   sqlstm.offset = (unsigned int  )296;
                   sqlstm.cud = sqlcud0;
                   sqlstm.sqlest = (unsigned char  *)&sqlca;
                   sqlstm.sqlety = (unsigned short)256;
                   sqlstm.occurs = (unsigned int  )0;
                   sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
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
                   sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendComis;
                   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                   sqlstm.sqhsts[2] = (         int  )0;
                   sqlstm.sqindv[2] = (         short *)0;
                   sqlstm.sqinds[2] = (         int  )0;
                   sqlstm.sqharm[2] = (unsigned long )0;
                   sqlstm.sqadto[2] = (unsigned short )0;
                   sqlstm.sqtdso[2] = (unsigned short )0;
                   sqlstm.sqhstv[3] = (unsigned char  *)&lhCodVendDealer;
                   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
                   sqlstm.sqhstv[8] = (unsigned char  *)szhFecVenta;
                   sqlstm.sqhstl[8] = (unsigned long )20;
                   sqlstm.sqhsts[8] = (         int  )0;
                   sqlstm.sqindv[8] = (         short *)0;
                   sqlstm.sqinds[8] = (         int  )0;
                   sqlstm.sqharm[8] = (unsigned long )0;
                   sqlstm.sqadto[8] = (unsigned short )0;
                   sqlstm.sqtdso[8] = (unsigned short )0;
                   sqlstm.sqhstv[9] = (unsigned char  *)szhFecRecepcion;
                   sqlstm.sqhstl[9] = (unsigned long )20;
                   sqlstm.sqhsts[9] = (         int  )0;
                   sqlstm.sqindv[9] = (         short *)&shIndFecRecepcion;
                   sqlstm.sqinds[9] = (         int  )0;
                   sqlstm.sqharm[9] = (unsigned long )0;
                   sqlstm.sqadto[9] = (unsigned short )0;
                   sqlstm.sqtdso[9] = (unsigned short )0;
                   sqlstm.sqhstv[10] = (unsigned char  *)szhFecAceptacion;
                   sqlstm.sqhstl[10] = (unsigned long )20;
                   sqlstm.sqhsts[10] = (         int  )0;
                   sqlstm.sqindv[10] = (         short *)&shIndFecAceptacion;
                   sqlstm.sqinds[10] = (         int  )0;
                   sqlstm.sqharm[10] = (unsigned long )0;
                   sqlstm.sqadto[10] = (unsigned short )0;
                   sqlstm.sqtdso[10] = (unsigned short )0;
                   sqlstm.sqhstv[11] = (unsigned char  *)szhFecAlta;
                   sqlstm.sqhstl[11] = (unsigned long )20;
                   sqlstm.sqhsts[11] = (         int  )0;
                   sqlstm.sqindv[11] = (         short *)0;
                   sqlstm.sqinds[11] = (         int  )0;
                   sqlstm.sqharm[11] = (unsigned long )0;
                   sqlstm.sqadto[11] = (unsigned short )0;
                   sqlstm.sqtdso[11] = (unsigned short )0;
                   sqlstm.sqhstv[12] = (unsigned char  *)szhCodCausaBaja;
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
                   sqlstm.sqhstv[14] = (unsigned char  *)&lhCodArticulo;
                   sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
                   sqlstm.sqhsts[14] = (         int  )0;
                   sqlstm.sqindv[14] = (         short *)0;
                   sqlstm.sqinds[14] = (         int  )0;
                   sqlstm.sqharm[14] = (unsigned long )0;
                   sqlstm.sqadto[14] = (unsigned short )0;
                   sqlstm.sqtdso[14] = (unsigned short )0;
                   sqlstm.sqhstv[15] = (unsigned char  *)&shCodFabricante;
                   sqlstm.sqhstl[15] = (unsigned long )sizeof(short);
                   sqlstm.sqhsts[15] = (         int  )0;
                   sqlstm.sqindv[15] = (         short *)0;
                   sqlstm.sqinds[15] = (         int  )0;
                   sqlstm.sqharm[15] = (unsigned long )0;
                   sqlstm.sqadto[15] = (unsigned short )0;
                   sqlstm.sqtdso[15] = (unsigned short )0;
                   sqlstm.sqhstv[16] = (unsigned char  *)&chIndProcequi;
                   sqlstm.sqhstl[16] = (unsigned long )1;
                   sqlstm.sqhsts[16] = (         int  )0;
                   sqlstm.sqindv[16] = (         short *)0;
                   sqlstm.sqinds[16] = (         int  )0;
                   sqlstm.sqharm[16] = (unsigned long )0;
                   sqlstm.sqadto[16] = (unsigned short )0;
                   sqlstm.sqtdso[16] = (unsigned short )0;
                   sqlstm.sqhstv[17] = (unsigned char  *)&lhCodCiclComis;
                   sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
                   sqlstm.sqhsts[17] = (         int  )0;
                   sqlstm.sqindv[17] = (         short *)0;
                   sqlstm.sqinds[17] = (         int  )0;
                   sqlstm.sqharm[17] = (unsigned long )0;
                   sqlstm.sqadto[17] = (unsigned short )0;
                   sqlstm.sqtdso[17] = (unsigned short )0;
                   sqlstm.sqhstv[18] = (unsigned char  *)szhIdCiclComis;
                   sqlstm.sqhstl[18] = (unsigned long )11;
                   sqlstm.sqhsts[18] = (         int  )0;
                   sqlstm.sqindv[18] = (         short *)0;
                   sqlstm.sqinds[18] = (         int  )0;
                   sqlstm.sqharm[18] = (unsigned long )0;
                   sqlstm.sqadto[18] = (unsigned short )0;
                   sqlstm.sqtdso[18] = (unsigned short )0;
                   sqlstm.sqhstv[19] = (unsigned char  *)szhCodCategoria;
                   sqlstm.sqhstl[19] = (unsigned long )15;
                   sqlstm.sqhsts[19] = (         int  )0;
                   sqlstm.sqindv[19] = (         short *)0;
                   sqlstm.sqinds[19] = (         int  )0;
                   sqlstm.sqharm[19] = (unsigned long )0;
                   sqlstm.sqadto[19] = (unsigned short )0;
                   sqlstm.sqtdso[19] = (unsigned short )0;
                   sqlstm.sqhstv[20] = (unsigned char  *)szhCodPlantarif;
                   sqlstm.sqhstl[20] = (unsigned long )4;
                   sqlstm.sqhsts[20] = (         int  )0;
                   sqlstm.sqindv[20] = (         short *)0;
                   sqlstm.sqinds[20] = (         int  )0;
                   sqlstm.sqharm[20] = (unsigned long )0;
                   sqlstm.sqadto[20] = (unsigned short )0;
                   sqlstm.sqtdso[20] = (unsigned short )0;
                   sqlstm.sqhstv[21] = (unsigned char  *)&lhNumVenta;
                   sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
                   sqlstm.sqhsts[21] = (         int  )0;
                   sqlstm.sqindv[21] = (         short *)&shIndNumVenta;
                   sqlstm.sqinds[21] = (         int  )0;
                   sqlstm.sqharm[21] = (unsigned long )0;
                   sqlstm.sqadto[21] = (unsigned short )0;
                   sqlstm.sqtdso[21] = (unsigned short )0;
                   sqlstm.sqhstv[22] = (unsigned char  *)&lhCodVendFinal;
                   sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
                   sqlstm.sqhsts[22] = (         int  )0;
                   sqlstm.sqindv[22] = (         short *)&shIndCodVendFinal;
                   sqlstm.sqinds[22] = (         int  )0;
                   sqlstm.sqharm[22] = (unsigned long )0;
                   sqlstm.sqadto[22] = (unsigned short )0;
                   sqlstm.sqtdso[22] = (unsigned short )0;
                   sqlstm.sqhstv[23] = (unsigned char  *)szhNumIdent;
                   sqlstm.sqhstl[23] = (unsigned long )21;
                   sqlstm.sqhsts[23] = (         int  )0;
                   sqlstm.sqindv[23] = (         short *)0;
                   sqlstm.sqinds[23] = (         int  )0;
                   sqlstm.sqharm[23] = (unsigned long )0;
                   sqlstm.sqadto[23] = (unsigned short )0;
                   sqlstm.sqtdso[23] = (unsigned short )0;
                   sqlstm.sqhstv[24] = (unsigned char  *)&ihCodTipoRed;
                   sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
                   sqlstm.sqhsts[24] = (         int  )0;
                   sqlstm.sqindv[24] = (         short *)0;
                   sqlstm.sqinds[24] = (         int  )0;
                   sqlstm.sqharm[24] = (unsigned long )0;
                   sqlstm.sqadto[24] = (unsigned short )0;
                   sqlstm.sqtdso[24] = (unsigned short )0;
                   sqlstm.sqhstv[25] = (unsigned char  *)szhCodTipVendedor;
                   sqlstm.sqhstl[25] = (unsigned long )3;
                   sqlstm.sqhsts[25] = (         int  )0;
                   sqlstm.sqindv[25] = (         short *)0;
                   sqlstm.sqinds[25] = (         int  )0;
                   sqlstm.sqharm[25] = (unsigned long )0;
                   sqlstm.sqadto[25] = (unsigned short )0;
                   sqlstm.sqtdso[25] = (unsigned short )0;
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
    stStatusProc.lCantRegistros = lCantRegistros;
    fprintf(stderr,"\n(vInsertaSeleccion)Cantidad de Bajas Insertadas:[%d].\n",lCantRegistros);
    fprintf(pfLog ,"\n(vInsertaSeleccion)Cantidad de Bajas Insertados:[%d].\n",lCantRegistros);	    
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
    int    lSegIni, lSegFin ;
    short   ibiblio;   
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stCiclo     , 0, sizeof(reg_ciclo));             
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
    memset(&stArgs, 0, sizeof(rg_argumentos));
	memset(&proceso     , 0, sizeof(proceso));    
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
/* GENERACION DEL NOMBRE Y CREACION DEL ARCHIVO DE LOG.                      */
/*---------------------------------------------------------------------------*/
    strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
    strncpy(szhSysDate, pszGetDateLog(),16);                                                            
    strcpy(stArgsLog.szProceso,LOGNAME);                                                                     
    strncpy(stArgsLog.szSysDate,szhSysDate,16);                                                                         
    sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
	strcpy(szLogName, stArgsLog.szPath);                                                                  
        
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
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )415;
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
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
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
/* CARGA ESTRUCTURA DE TIPOS DE COMISIONISTAS A SELECCIONAR                  */
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
    fprintf(pfLog, "-------------------------\n");
    fprintf(pfLog, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);  
    fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);  
	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Registros Finales Procesados   : [%d]\n", stStatusProc.lCantRegistros);
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

/*---------------------------------------------------------------------------*/
	if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0," ", stStatusProc.lSegProceso ,stStatusProc.lCantRegistros))
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));

    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )430;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


                                                                                                  
    vFechaHora();                                                                             
    fprintf(stderr, "Programa [%s] finalizado ok.\n", basename(argv[0]));                     
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());                
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

