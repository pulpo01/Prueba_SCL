
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
    "./pc/SEL_selven.pc"
};


static unsigned int sqlctx = 13861275;


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
   unsigned char  *sqhstv[32];
   unsigned long  sqhstl[32];
            int   sqhsts[32];
            short *sqindv[32];
            int   sqinds[32];
   unsigned long  sqharm[32];
   unsigned long  *sqharc[32];
   unsigned short  sqadto[32];
   unsigned short  sqtdso[32];
} sqlstm = {12,32};

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
"FEC_RECDOCUM>TO_DATE(:b6,'DD-MM-YYYY')) and VTAS.FEC_RECDOCUM<=TO_DATE(:b3,'\
DD-MM-YYYY')))) and VTAS.COD_OFICINA=OFIC.COD_OFICINA) and VEN1.COD_VENDEDOR=R\
VEN.COD_VENDEDOR) and RVEN.COD_TIPORED=:b10)           ";

 static char *sq0004 = 
"select CEL.NUM_CELULAR ,CEL.COD_PLANTARIF ,CEL.NUM_SERIE ,CEL.NUM_ABONADO ,N\
VL(CEL.COD_AFINIDAD,'0') ,NVL(CEL.COD_TECNOLOGIA,'TDMA')  from GA_ABOCEL CEL w\
here (CEL.NUM_VENTA=:b0 and  not exists (select 1  from GA_TRASPABO ABO where \
(ABO.NUM_ABONADO=CEL.NUM_ABONADO and ABO.NUM_ABONADO<>ABO.NUM_ABONADOANT)))   \
        ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,276,0,4,166,0,0,6,2,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
1,3,0,0,
44,0,0,2,1233,0,9,304,0,0,11,11,0,1,0,1,97,0,0,1,97,0,0,1,1,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
103,0,0,2,0,0,13,308,0,0,14,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
174,0,0,2,0,0,15,360,0,0,0,0,0,1,0,
189,0,0,3,148,0,4,385,0,0,3,1,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,
216,0,0,4,318,0,9,471,0,0,1,1,0,1,0,1,3,0,0,
235,0,0,4,0,0,13,475,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,
274,0,0,4,0,0,15,503,0,0,0,0,0,1,0,
289,0,0,5,368,0,4,541,0,0,5,3,0,1,0,2,97,0,0,2,1,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
324,0,0,6,400,0,4,607,0,0,4,2,0,1,0,2,3,0,0,2,1,0,0,1,3,0,0,1,97,0,0,
355,0,0,7,54,0,4,774,0,0,1,0,0,1,0,2,3,0,0,
374,0,0,8,704,0,3,777,0,0,32,32,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,1,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
517,0,0,9,81,0,4,827,0,0,3,2,0,1,0,1,97,0,0,1,97,0,0,2,3,0,0,
544,0,0,10,79,0,4,848,0,0,2,1,0,1,0,1,97,0,0,2,97,0,0,
567,0,0,11,88,0,4,870,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
590,0,0,12,66,0,4,896,0,0,2,1,0,1,0,1,97,0,0,2,3,0,0,
613,0,0,13,48,0,1,1128,0,0,0,0,0,1,0,
628,0,0,14,0,0,30,1175,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las ventas para comisiones         */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Martes 21 de Agosto del 2001.                                */
/* Fin   : Miercoles 22 de Agosto del 2001.                             */
/* Por Richard Troncoso C.                                              */
/* Inicio: Miercoles 13 de Noviembre del 2002                           */
/* Fin:                                                                 */
/* Autor:  Christian Descouvieres Vargas                                */
/* Modificacion: Se modifico el Num_serie de largo 12 a 26              */
/* -------------------------------------------------------------------- */
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla       */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y     */
/* COD_PARAMETRO.                                                       */
/* -------------------------------------------------------------------- */
/* Modificacion Jaime Vargas Morales.                                   */
/* Inicio : miercoles 2 de Enero 2003                                   */
/* Fin    : miercoles 2 de Enero 2003                                   */
/* Descripcion :     se incorpora a los registros de abono el atributo  */ 
/*                   COD_TECNOLOGIA,                                    */
/*                   se incorpora a la tabla CMT_HABIL_CELULAR          */ 
/*                   el atributo COD_TECNOLOGIA                         */
/* Jaime Varas Morales.                                                 */
/* Inicio : Viernes 3 de Enero 2003                                     */
/* Fin    : Viernes 3 de Enero 2003                                     */
/* Descripcion : marcar aquellos registros con Cod_vend_nvo es null     */ 
/*               tabla GA_ANULRECH_TH  funcion vNoConsidera()           */
/* -------------------------------------------------------------------- */
/* Modificacion Jaime Vargas Morales.                                   */
/* Inicio : Lunes 13 de Enero 2003                                      */
/* Descripcion  : Poblar el  atributo IND_CONVENIO de la TABLA          */
/*                CMT_HABIL_CELULAR                                     */
/************************************************************************/
/* 20030729 Fabián Aedo R. Versionado Cuzco.                            */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorporan: Planes de Comisiones y Tipos de Ciclos                */
/* Se incorpra manejo de lista general de tipos de comisionistas.       */
/* Se restructura proceso en función de estructura de tipos de          */
/* comisionistas.                                                       */
/*                                                                      */
/************************************************************************/

#include "selven.h"
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
		char  szFechaYYYYMMDD[9]="";
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
			fprintf(pfLog ,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s] TR[%d] TipVend:[%s].\n",paux->szCodTipComis,paux->szDesTipComis, paux->iCodTipoRed, paux->szCodTipVendedor);
			fprintf(stderr,"\n(vCargaTiposComis) Carga las Ventas para TipComis:[%s] [%s] TR[%d] TipVend:[%s].\n",paux->szCodTipComis,paux->szDesTipComis, paux->iCodTipoRed, paux->szCodTipVendedor);
            vSeleccionarUniverso(paux->iCodTipoRed, paux->szCodTipComis, paux->szCodTipVendedor);
		}
/*---------------------------------------------------------------------------*/
		vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(vCargaTiposComis) Evalua Rescate de Rechazos de Venta\n");
		fprintf(stderr,"\n(vCargaTiposComis) Evalua Rescate de Rechazos de Venta\n");
		vNoConsidera();
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
		fprintf(pfLog ,"\n(vCargaTiposComis) Valida ventas con convenio PAC (Duplicados).\n");
		fprintf(stderr,"\n(vCargaTiposComis) Valida ventas con convenio PAC (Duplicados).\n");
		vValidaDupConvenio();
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
/* --------------------------------------------------------------- */
/* Determina si cliente posee convenio PAC en la venta.            */
/* --------------------------------------------------------------- */
int iFntIndConvenio(long pCodCliente , long plVenta)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhCodCliente ;
	    char    szhFecAlta[30];
	    char    szhFecVenta[30];
	    char    szhCodBanco[30];
	    char    szhNumTajeta[30];
	    long    lhNumVenta;
    /* EXEC SQL END DECLARE SECTION; */ 
 
    
    lhCodCliente = pCodCliente;
    lhNumVenta = plVenta;

    fprintf(pfLog,"\n[iFntIndConvenio] lhCodCliente:[%ld] lhNumVenta:[%ld].",lhCodCliente,lhNumVenta);

    /* EXEC SQL SELECT 
            TO_CHAR(CLI.FEC_ALTA,'DD-MM-YYYY'),
            TO_CHAR(VTA.FEC_VENTA, 'DD-MM-YYYY'),
            NVL(CLI.COD_BANCO,'NN'),
            NVL(CLI.NUM_TARJETA,'NN')
            INTO  :szhFecAlta,:szhFecVenta,:szhCodBanco,:szhNumTajeta
            FROM GE_CLIENTES  CLI , 
                 GA_VENTAS    VTA 
        WHERE   CLI.COD_CLIENTE 	= :lhCodCliente
         AND  	CLI.COD_CLIENTE   	= VTA.COD_CLIENTE
         AND  	VTA.NUM_VENTA 		= :lhNumVenta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(CLI.FEC_ALTA,'DD-MM-YYYY') ,TO_CHAR(VTA.FE\
C_VENTA,'DD-MM-YYYY') ,NVL(CLI.COD_BANCO,'NN') ,NVL(CLI.NUM_TARJETA,'NN') into\
 :b0,:b1,:b2,:b3  from GE_CLIENTES CLI ,GA_VENTAS VTA where ((CLI.COD_CLIENTE=\
:b4 and CLI.COD_CLIENTE=VTA.COD_CLIENTE) and VTA.NUM_VENTA=:b5)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecAlta;
    sqlstm.sqhstl[0] = (unsigned long )30;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecVenta;
    sqlstm.sqhstl[1] = (unsigned long )30;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodBanco;
    sqlstm.sqhstl[2] = (unsigned long )30;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhNumTajeta;
    sqlstm.sqhstl[3] = (unsigned long )30;
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
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumVenta;
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



    if ((strcmp(szfnTrim(szhCodBanco),"NN")==0)||(strcmp(szfnTrim(szhNumTajeta),"NN")==0))
    {
        fprintf(pfLog," No Tiene convenio...\n");
        return(0);
    }
    else
    {
        if (strcmp(szfnTrim(szhFecVenta),szfnTrim(szhFecAlta))==0)
        {
            fprintf(pfLog," Si Tiene convenio...Banco:[%s] tarjeta/cuenta:[%s]\n", szhCodBanco,szhNumTajeta );
            return (1);
        }
		else
        {
            fprintf(pfLog,"El Cliente es anterior a la Venta. No se Cossidera...\n");
            return(0);
        }
            
    }
}

/* -------------------------------------------------------------------------------------- */
/* Se extrae el universo DIRECTO inicial de registros a considerar para Comisiones.       */
/* -------------------------------------------------------------------------------------- */
void vSeleccionarUniverso(int piCodTipoRed, char * pszCodTipComis, char * pszCodTipVendedor)
{
    stUniverso 	* paux;
    char        szObsIncumpFil[151];
    long    	iCantidad = 0;

	int                     i;
	long            iLastRows    = 0;
	int             iFetchedRows = MAXFETCH;
	int             iRetrievRows = MAXFETCH;

    /* EXEC SQL begin declare section; */ 

		char  	szhFecDesdeAceptacion[11];
		char  	szhFecHastaAceptacion[11];
		char  	szhFecDesdeRecepcion [11];
		char  	szhFecHastaRecepcion [11];
		long	lhCodCiclComis;
		
		int		ihCodTipoRed;
		char    szhCodTipComis[3];
		char	szhCodTipVendedor[3];

		char	szhIndEstVenta[3];
	    char    chIndVenta;
	    long    lMaxFetch;

		long    lhNumVenta[MAXFETCH];
		long    lhCodVendedor[MAXFETCH];
		long	lhCodVendDealer[MAXFETCH];
	    char    szhFecVenta[MAXFETCH][20];
	    char    szhFecRecepcion[MAXFETCH][20];
	    char    szhFecAceptacion[MAXFETCH][20];
	    char    szhFechaInicio[MAXFETCH][11];
	    char    szhFechaTermino[MAXFETCH][11];
		int		ihCodModVenta[MAXFETCH];
		int		ihIndDocComp[MAXFETCH];
        char    szhObsIncump[MAXFETCH][151];
	    char    szhCodOficina[MAXFETCH][3];
        long    lhCodCliente[MAXFETCH];
        char	szhNumContrato[MAXFETCH][20];
                
    /* EXEC SQL end declare section; */ 

    
    ihCodTipoRed					= piCodTipoRed;
    strcpy(szhCodTipComis			, pszCodTipComis);
    strcpy(szhCodTipVendedor		, pszCodTipVendedor);
    
    strcpy(szhFecDesdeAceptacion 	, stCiclo.szFecDesdeAceptacion);
    strcpy(szhFecHastaAceptacion	, stCiclo.szFecHastaAceptacion);
    strcpy(szhFecDesdeRecepcion 	, stCiclo.szFecDesdeRecepcion );
    strcpy(szhFecHastaRecepcion 	, stCiclo.szFecHastaRecepcion );
    lhCodCiclComis 					= stCiclo.lCodCiclComis;
    chIndVenta 						= 'V';	/* Solo son consideradas las ventas contrato.*/
    strcpy(szhIndEstVenta			, "AC");
    paux = NULL;
   
    lMaxFetch = MAXFETCH;
	
	/* EXEC SQL declare cur_universo cursor for 
		SELECT  DISTINCT 
            VTAS.NUM_VENTA,
            VTAS.COD_VENDEDOR,
	    	NVL(VTAS.COD_VENDEALER,0),
            TO_CHAR(VTAS.FEC_VENTA, 'DD/MM/YYYY HH24:MI:SS'),
            TO_CHAR(NVL(VTAS.FEC_RECDOCUM, VTAS.FEC_VENTA),'DD/MM/YYYY HH24:MI:SS'),
            TO_CHAR(NVL(VTAS.FEC_ACEPREC, NVL(VTAS.FEC_RECDOCUM, VTAS.FEC_VENTA)), 'DD/MM/YYYY HH24:MI:SS'),
            TO_CHAR(VTAS.FEC_VENTA, 'DD/MM/YYYY'),
            TO_CHAR(NVL(VTAS.FEC_RECDOCUM, VTAS.FEC_VENTA), 'DD/MM/YYYY'),
            NVL(VTAS.COD_MODVENTA, -1),
            NVL(VTAS.IND_DOCCOMP, 1),
            NVL(VTAS.OBS_INCUMP,'SIN OBSERVACIONES'),
            VTAS.COD_OFICINA,
            VTAS.COD_CLIENTE,
            NVL(VTAS.NUM_CONTRATO,'S/N')
        FROM	GE_OFICINAS       OFIC,
            	GA_VENTAS         VTAS,
            	VE_VENDEDORES     VEN1, 
				VE_REDVENTAS_TD   RVEN
        WHERE	VTAS.COD_TIPCOMIS 	= :szhCodTipVendedor
        AND VTAS.IND_ESTVENTA 		= :szhIndEstVenta
        AND upper(VTAS.IND_VENTA)	= :chIndVenta
        AND VTAS.COD_VENDEDOR 		= VEN1.COD_VENDEDOR
        AND
             ((
                    VTAS.FEC_ACEPREC > TO_DATE(:szhFecDesdeAceptacion,'DD-MM-YYYY')
        AND
                    VTAS.FEC_ACEPREC<=TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY')
        AND
                    VTAS.FEC_RECDOCUM<=TO_DATE(:szhFecHastaRecepcion,'DD-MM-YYYY')
             ) OR (
                    VTAS.FEC_ACEPREC > TO_DATE(:szhFecDesdeRecepcion,'DD-MM-YYYY')
        AND
                    VTAS.FEC_ACEPREC<=TO_DATE(:szhFecDesdeAceptacion,'DD-MM-YYYY')
        AND
                    VTAS.FEC_RECDOCUM> TO_DATE(:szhFecDesdeRecepcion,'DD-MM-YYYY')
        AND
                    VTAS.FEC_RECDOCUM<=TO_DATE(:szhFecDesdeAceptacion,'DD-MM-YYYY')
             ))
         AND VTAS.COD_OFICINA       =  OFIC.COD_OFICINA		     
         AND VEN1.COD_VENDEDOR 		=  RVEN.COD_VENDEDOR
		 AND RVEN.COD_TIPORED       =  :ihCodTipoRed; */ 

   
        /* EXEC SQL open cur_universo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlbuft((void **)0, 
          "select distinct VTAS.NUM_VENTA ,VTAS.COD_VENDEDOR ,NVL(VTAS.COD_V\
ENDEALER,0) ,TO_CHAR(VTAS.FEC_VENTA,'DD/MM/YYYY HH24:MI:SS') ,TO_CHAR(NVL(VT\
AS.FEC_RECDOCUM,VTAS.FEC_VENTA),'DD/MM/YYYY HH24:MI:SS') ,TO_CHAR(NVL(VTAS.F\
EC_ACEPREC,NVL(VTAS.FEC_RECDOCUM,VTAS.FEC_VENTA)),'DD/MM/YYYY HH24:MI:SS') ,\
TO_CHAR(VTAS.FEC_VENTA,'DD/MM/YYYY') ,TO_CHAR(NVL(VTAS.FEC_RECDOCUM,VTAS.FEC\
_VENTA),'DD/MM/YYYY') ,NVL(VTAS.COD_MODVENTA,(-1)) ,NVL(VTAS.IND_DOCCOMP,1) \
,NVL(VTAS.OBS_INCUMP,'SIN OBSERVACIONES') ,VTAS.COD_OFICINA ,VTAS.COD_CLIENT\
E ,NVL(VTAS.NUM_CONTRATO,'S/N')  from GE_OFICINAS OFIC ,GA_VENTAS VTAS ,VE_V\
ENDEDORES VEN1 ,VE_REDVENTAS_TD RVEN where (((((((VTAS.COD_TIPCOMIS=:b0 and \
VTAS.IND_ESTVENTA=:b1) and upper(VTAS.IND_VENTA)=:b2) and VTAS.COD_VENDEDOR=\
VEN1.COD_VENDEDOR) and (((VTAS.FEC_ACEPREC>TO_DATE(:b3,'DD-MM-YYYY') and VTA\
S.FEC_ACEPREC<=TO_DATE(:b4,'DD-MM-YYYY')) and VTAS.FEC_RECDOCUM<=TO_DATE(:b5\
,'DD-MM-YYYY')) or (((VTAS.FEC_ACEPREC>TO_DATE(:b6,'DD-MM-YYYY') and VTAS.FE\
C_ACEPREC<=TO_DATE(:b3,'DD-MM-YYYY')) and VTAS.");
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )44;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhIndEstVenta;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&chIndVenta;
        sqlstm.sqhstl[2] = (unsigned long )1;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecDesdeAceptacion;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhFecHastaAceptacion;
        sqlstm.sqhstl[4] = (unsigned long )11;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhFecHastaRecepcion;
        sqlstm.sqhstl[5] = (unsigned long )11;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhFecDesdeRecepcion;
        sqlstm.sqhstl[6] = (unsigned long )11;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFecDesdeAceptacion;
        sqlstm.sqhstl[7] = (unsigned long )11;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhFecDesdeRecepcion;
        sqlstm.sqhstl[8] = (unsigned long )11;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhFecDesdeAceptacion;
        sqlstm.sqhstl[9] = (unsigned long )11;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&ihCodTipoRed;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
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


        
        while(iFetchedRows == iRetrievRows)
        {
			/* EXEC SQL for :lMaxFetch
                         FETCH cur_universo INTO
                            :lhNumVenta,
                            :lhCodVendedor,
                            :lhCodVendDealer,
                            :szhFecVenta,
                            :szhFecRecepcion,
                            :szhFecAceptacion,
                            :szhFechaInicio,
                            :szhFechaTermino,
                            :ihCodModVenta,
                            :ihIndDocComp,
                            :szhObsIncump,
                            :szhCodOficina,
                            :lhCodCliente,
                            :szhNumContrato; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )lMaxFetch;
   sqlstm.offset = (unsigned int  )103;
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
   sqlstm.sqhstv[1] = (unsigned char  *)lhCodVendedor;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )sizeof(long);
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)lhCodVendDealer;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhFecRecepcion;
   sqlstm.sqhstl[4] = (unsigned long )20;
   sqlstm.sqhsts[4] = (         int  )20;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFecAceptacion;
   sqlstm.sqhstl[5] = (unsigned long )20;
   sqlstm.sqhsts[5] = (         int  )20;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhFechaInicio;
   sqlstm.sqhstl[6] = (unsigned long )11;
   sqlstm.sqhsts[6] = (         int  )11;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqharc[6] = (unsigned long  *)0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFechaTermino;
   sqlstm.sqhstl[7] = (unsigned long )11;
   sqlstm.sqhsts[7] = (         int  )11;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqharc[7] = (unsigned long  *)0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)ihCodModVenta;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )sizeof(int);
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqharc[8] = (unsigned long  *)0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)ihIndDocComp;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )sizeof(int);
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqharc[9] = (unsigned long  *)0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhObsIncump;
   sqlstm.sqhstl[10] = (unsigned long )151;
   sqlstm.sqhsts[10] = (         int  )151;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqharc[10] = (unsigned long  *)0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhCodOficina;
   sqlstm.sqhstl[11] = (unsigned long )3;
   sqlstm.sqhsts[11] = (         int  )3;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqharc[11] = (unsigned long  *)0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)lhCodCliente;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[12] = (         int  )sizeof(long);
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqharc[12] = (unsigned long  *)0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhNumContrato;
   sqlstm.sqhstl[13] = (unsigned long )20;
   sqlstm.sqhsts[13] = (         int  )20;
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
            iLastRows = sqlca.sqlerrd[2];
                
            for (i=0; i < iRetrievRows; i++)
            {                
                paux = (stUniverso *) malloc(sizeof(stUniverso));
                 
                paux->iCodTipoRed     			= ihCodTipoRed;
				strcpy(paux->szCodTipComis      , szhCodTipComis);
				paux->lCodVendedor     			= lhCodVendedor[i];
				paux->lCodComisonista			= lObtieneVendedorPadre(paux->lCodVendedor, ihCodTipoRed, szhCodTipComis);
				strcpy(paux->szCodTipVendedor   , szhCodTipVendedor);

				paux->lNumVenta        			= lhNumVenta[i];
				paux->lCodVendDealer   			= lhCodVendDealer[i];
				strcpy(paux->szFecVenta       	, szfnTrim(szhFecVenta[i]));
				strcpy(paux->szFecRecepcion   	, szfnTrim(szhFecRecepcion[i]));
				strcpy(paux->szFecAceptacion  	, szfnTrim(szhFecAceptacion[i]));
				paux->iCodModVenta     			= ihCodModVenta[i];
				paux->iIndDocComp      			= ihIndDocComp [i];
				strcpy(paux->szCodOficina     	, szfnTrim(szhCodOficina[i]));
				paux->lCodCliente      			= lhCodCliente[i];
				strcpy(paux->szNumContrato      , szfnTrim(szhNumContrato[i]));

                paux->iDiasReales = iGetNumDias(szfnTrim(szhFechaInicio[i]), szfnTrim(szhFechaTermino[i]));
            	paux->iDiasHabiles = iCalculaDiasHabiles(szfnTrim(szhFechaInicio[i]), szfnTrim(szhFechaTermino[i]));
                vFiltraGlosa(szfnTrim(szhObsIncump[i]) , paux->szObsIncump);

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
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )174;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


        fprintf(pfLog, "\n(vSeleccionarUniverso)Tipo Comisionista:[%s] Cantidad de Ventas Extraídas:[%ld].\n", szhCodTipComis, iCantidad);
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE MARCA AQUELLOS REGISTROS ,  COD_VEND_NVO ES NULO        */
/*---------------------------------------------------------------------------*/
void vNoConsidera()
{
    stUniverso  * paux;  
    
    long	lCantVentasRech = 0;
    long	lCantVentasOk 	= 0;
	long	lCantVentas 	= 0;

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

       long  lhNumVenta;
       long  lhVenta;
       long  lhCodVendNvo;
    /* EXEC SQL END  DECLARE SECTION; */ 
          
    
    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)  
    {  
	    lCantVentas++;
	    lhNumVenta	= paux->lNumVenta;
	    lhVenta     = -1;
		/* EXEC SQL SELECT 
            B.NUM_VENTA ,
            NVL(A.COD_VEND_NVO,-1)
            INTO :lhVenta,:lhCodVendNvo
            FROM GA_ANULRECH_TH A, GA_VENTAS B
            WHERE 
            B.NUM_VENTA = :lhNumVenta  
            AND B.NUM_VENTA = A.NUM_VENTA (+); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select B.NUM_VENTA ,NVL(A.COD_VEND_NVO,(-1)) into :b0,:b1  \
from GA_ANULRECH_TH A ,GA_VENTAS B where (B.NUM_VENTA=:b2 and B.NUM_VENTA=A.NU\
M_VENTA(+))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )189;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhVenta;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendNvo;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumVenta;
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


            
		if ( lhCodVendNvo > 0 )  
		{
			fprintf(pfLog, "(vNoConsidera) Venta [%ld] no sera considerada (RESCATE RECHAZO).\n",lhNumVenta); 
		    paux->cIndConsidera = 'N';
		    lCantVentasRech++;
		}
		else
		{
            paux->cIndConsidera = 'S';
            lCantVentasOk++;
		}
	}
    fprintf(pfLog, "(vNoConsidera) Fin de Evaluacion de Ventas con Rescate de Rechazo.\n");
    fprintf(pfLog, "(vNoConsidera) Total Ventas Examinadas          [%ld].\n",lCantVentas);
    fprintf(pfLog, "(vNoConsidera) Total Ventas Rescate Rechazo     [%ld].\n",lCantVentasRech);
    fprintf(pfLog, "(vNoConsidera) Total Ventas Comisionables       [%ld].\n",lCantVentasOk);

    fprintf(stderr, "(vNoConsidera) Fin de Evaluacion de Ventas con Rescate de Rechazo.\n");
    fprintf(stderr, "(vNoConsidera) Total Ventas Examinadas          [%ld].\n",lCantVentas);
    fprintf(stderr, "(vNoConsidera) Total Ventas Rescate Rechazo     [%ld].\n",lCantVentasRech);
    fprintf(stderr, "(vNoConsidera) Total Ventas Comisionables       [%ld].\n",lCantVentasOk);
}    

/* ***************************************************************************** */
/* Del universo seleccionado, ahora se rescatan los abonados.                    */
/* ***************************************************************************** */
void vGetAbonados()
{
    stUniverso * paux;
    stAbonado  * aaux;
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    int				iCantAbonados = 0;
    int				iCantVentas   = 0;
    int				iCantVentasInv= 0;
    /* EXEC SQL begin declare section; */ 

		long    lMaxFetch;   	

	    long    lhNumVenta;
	    long    lhNumCelular[MAXFETCH];
	    char    szhCodPlanTarif[MAXFETCH][4];
	    char    szhNumSerie[MAXFETCH][26];
	    long    lhNumAbonado[MAXFETCH];
	    int   	ihCodAfinidad[MAXFETCH];
	    char    szhCodTecnologia[MAXFETCH][8]; 
	    
    /* EXEC SQL end declare section; */ 

	
	for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
	{
		paux->abonado_sgte = NULL;
		if (paux->cIndConsidera == 'S')
		{
			iLastRows    = 0;       
			iFetchedRows = MAXFETCH;
			iRetrievRows = MAXFETCH;
			lMaxFetch 	 = MAXFETCH;
			
			lhNumVenta = paux->lNumVenta;
			iCantVentas++;

            /* EXEC SQL DECLARE CUR_ABONADOS CURSOR FOR SELECT 
                CEL.NUM_CELULAR,
                CEL.COD_PLANTARIF,
                CEL.NUM_SERIE,
                CEL.NUM_ABONADO,
                NVL(CEL.COD_AFINIDAD,'0'),
                NVL(CEL.COD_TECNOLOGIA,'TDMA') 
            FROM    GA_ABOCEL CEL
            WHERE   CEL.NUM_VENTA = :lhNumVenta
            AND   NOT EXISTS (SELECT 1
				FROM   GA_TRASPABO ABO
                WHERE  ABO.NUM_ABONADO = CEL.NUM_ABONADO
                AND  ABO.NUM_ABONADO != ABO.NUM_ABONADOANT); */ 


			/* EXEC SQL open cur_abonados; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0004;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )216;
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
				/* EXEC SQL for :lMaxFetch FETCH cur_abonados
                	INTO    :lhNumCelular,
                            :szhCodPlanTarif,
                            :szhNumSerie,
                            :lhNumAbonado,
                            :ihCodAfinidad,
                            :szhCodTecnologia ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )lMaxFetch;
    sqlstm.offset = (unsigned int  )235;
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
                iLastRows = sqlca.sqlerrd[2];
               
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
            /* EXEC SQL close cur_abonados; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 14;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )274;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
            if (sqlca.sqlcode < 0) vSqlError();
}


            if (iCantAbonados==0)
            {
            	paux->cIndConsidera = 'N';
            	iCantVentasInv++;
            }
		}
	} 
	fprintf(stderr, "\n[vGetAbonados] Ventas Validas:[%d] Abonados Recuperados:[%d] Ventas Invalidas:[%d]\n",iCantVentas, iCantAbonados, iCantVentasInv);
	fprintf(pfLog , "\n[vGetAbonados] Ventas Validas:[%d] Abonados Recuperados:[%d] Ventas Invalidas:[%d]\n",iCantVentas, iCantAbonados, iCantVentasInv);
        
}

/* **************************************************************************** */
/* Del universo seleccionado, ahora se revisan los clientes.                    */
/* **************************************************************************** */
void vGetClientes()
{
    stUniverso       * paux;
    short			seguir;
	long			lCantVentas = 0;
    /* EXEC SQL begin declare section; */ 

        long    lhCodCliente;
		char	szhFecHastaAceptacion[11];
		char	szhFecHastaRecepcion[11];
		
        char    szhNumIdent[20]; 
        char    chCodCaTribut;
    /* EXEC SQL end declare section; */ 


    strcpy(szhFecHastaAceptacion, stCiclo.szFecHastaAceptacion);
    strcpy(szhFecHastaRecepcion , stCiclo.szFecHastaRecepcion );        

    for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
		if (paux->cIndConsidera == 'S')
		{
            lhCodCliente = paux->lCodCliente;
            /* EXEC SQL SELECT 
	            	CLIE.NUM_IDENT,
	                CATRI.COD_CATRIBUT
	                INTO
	                :szhNumIdent,
	                :chCodCaTribut
            FROM	GE_CLIENTES CLIE,
                	GA_CATRIBUTCLIE CATRI
			WHERE CLIE.COD_CLIENTE 	= :lhCodCliente
            AND CLIE.COD_CLIENTE 	= CATRI.COD_CLIENTE
            AND CATRI.FEC_DESDE  	=(	SELECT MAX(E.FEC_DESDE)
				                        FROM    GA_CATRIBUTCLIE E
				                        WHERE  	CATRI.COD_CLIENTE = E.COD_CLIENTE
							            AND  	E.FEC_DESDE <= TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY')
							            AND 	E.FEC_DESDE <= TO_DATE(:szhFecHastaRecepcion,'DD-MM-YYYY')
							         ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 14;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select CLIE.NUM_IDENT ,CATRI.COD_CATRIBUT into :b\
0,:b1  from GE_CLIENTES CLIE ,GA_CATRIBUTCLIE CATRI where ((CLIE.COD_CLIENTE=:\
b2 and CLIE.COD_CLIENTE=CATRI.COD_CLIENTE) and CATRI.FEC_DESDE=(select max(E.F\
EC_DESDE)  from GA_CATRIBUTCLIE E where ((CATRI.COD_CLIENTE=E.COD_CLIENTE and \
E.FEC_DESDE<=TO_DATE(:b3,'DD-MM-YYYY')) and E.FEC_DESDE<=TO_DATE(:b4,'DD-MM-YY\
YY'))))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )289;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&chCodCaTribut;
            sqlstm.sqhstl[1] = (unsigned long )1;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhFecHastaAceptacion;
            sqlstm.sqhstl[3] = (unsigned long )11;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhFecHastaRecepcion;
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


			if (sqlca.sqlcode)
			{
            	paux->cIndConsidera = 'N';
            	fprintf(stderr,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta [%ld] no será considerada.\n", lhCodCliente, paux->lNumVenta);
            	fprintf(pfLog ,"\n(vGetClientes) Cliente:[%ld] Sin datos. Venta [%ld] no será considerada.\n", lhCodCliente, paux->lNumVenta);
            }
            else
            {
				lCantVentas++;
				strcpy(paux->szNumIdent 	, szfnTrim(szhNumIdent));
				strcpy(paux->szCodCategoria  ,(char *) szfnGetCategCliente(chCodCaTribut,paux->szNumIdent));

				paux->iIndConvenio 			= 0;
				paux->iIndConvenio 			= iFntIndConvenio(lhCodCliente , paux->lNumVenta);
			}
		} 
	}
	fprintf(stderr,"\n(vGetClientes) Cantidad de ventas examinadas (solo validas):[%ld].\n", lCantVentas);
}

/* **************************************************************************** */
/* Del universo seleccionado, ahora se revisan los equipos.                     */
/* **************************************************************************** */
void vGetEquipos()
{
    stUniverso	* paux;
    stAbonado    * aaux;
	long		lCantVentas 	= 0;
	long		lCantAbonados 	= 0;
	long		lCantAbonadosX	= 0;
	
    /* EXEC SQL begin declare section; */ 

	    long    lhNumAbonado;
	    long    lhCodArticulo;
	    char    szhNumSerie[26];
	    char    chIndProcequi;
    /* EXEC SQL end declare section; */ 


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
                    /* EXEC SQL SELECT 
                         EQUI.COD_ARTICULO,
                         EQUI.IND_PROCEQUI
                    	INTO     :lhCodArticulo,
                                 :chIndProcequi
                        FROM     AL_FABRICANTES FABR,
                                 AL_ARTICULOS   ARTI,
                                 GA_EQUIPABOSER EQUI
			            WHERE   EQUI.NUM_ABONADO 	= :lhNumAbonado
			              AND   EQUI.NUM_SERIE   	= :szhNumSerie
			              AND   EQUI.COD_ARTICULO	= ARTI.COD_ARTICULO
			              AND   ARTI.COD_FABRICANTE	= FABR.COD_FABRICANTE
			              AND  	EQUI.FEC_ALTA 		= (	SELECT MAX(R.FEC_ALTA)
                                                    FROM    GA_EQUIPABOSER R
                                                    WHERE   R.NUM_ABONADO = EQUI.NUM_ABONADO
                                                    AND     R.NUM_SERIE   = EQUI.NUM_SERIE); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 14;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select EQUI.COD_ARTICULO ,EQUI.IND_PROCEQ\
UI into :b0,:b1  from AL_FABRICANTES FABR ,AL_ARTICULOS ARTI ,GA_EQUIPABOSER E\
QUI where ((((EQUI.NUM_ABONADO=:b2 and EQUI.NUM_SERIE=:b3) and EQUI.COD_ARTICU\
LO=ARTI.COD_ARTICULO) and ARTI.COD_FABRICANTE=FABR.COD_FABRICANTE) and EQUI.FE\
C_ALTA=(select max(R.FEC_ALTA)  from GA_EQUIPABOSER R where (R.NUM_ABONADO=EQU\
I.NUM_ABONADO and R.NUM_SERIE=EQUI.NUM_SERIE)))";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )324;
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



                    if (sqlca.sqlcode) /* quiere decir que no encontro registro */
                    {
                    	fprintf(stderr,"\n(vGetEquipos) Abonado:[%ld] Serie:[%s] No fue posible recueprar datos del equipo.", lhNumAbonado, szhNumSerie);
                    	fprintf(pfLog ,"\n(vGetEquipos) Abonado:[%ld] Serie:[%s] No fue posible recueprar datos del equipo.", lhNumAbonado, szhNumSerie);
                    	aaux->cIndConsidera = 'N';
                    	lCantAbonadosX++;
					}
					else
                    {
                       	aaux->lCodArticulo 	= lhCodArticulo;
                        aaux->cIndProcequi 	= chIndProcequi;
                        aaux->cIndConsidera = 'S';
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
/*****************************************************************************/
/* Deszmarca las ventas con indicador de conveniom con num_venta mayor al    */
/* Parámetro, para el mismo cliente del parámetro, sobre la lista de ventas  */
/* qaux...                                                                   */
/*****************************************************************************/
void vDesmarcarVentas(long plNumVenta, long plCodCliente, stUniverso * qaux)
{
        stUniverso * paux;
        for (paux = qaux; paux != NULL; paux = paux->sgte)
        {
                if ((paux->lCodCliente == plCodCliente)&&(paux->lNumVenta > plNumVenta)&&(paux->iIndConvenio == 1))
                        paux->iIndConvenio = 0;
        }
}       
/*****************************************************************************/
/* Elimina la ocurrencia de dos ventas, para un mismo cliente, con indicador */
/* de convenio PAC. Solo debe quedar una con indicador de convenio x cliente.*/
/*****************************************************************************/
void vValidaDupConvenio()
{
        stUniverso * paux;
        stUniverso * qaux;
        
        for (paux = lstUniverso; paux != NULL; paux = paux->sgte)
        {
                if ((paux->cIndConsidera == 'S')&&(paux->iIndConvenio==1))
                {
                        qaux = lstUniverso;
                        vDesmarcarVentas(paux->lNumVenta, paux->lCodCliente, qaux);
                }
        }
        
}       
/*****************************************************************************/
/* Insercion de valores en tabla de salida                                   */
/*****************************************************************************/
void vInsertaSeleccion()
{
    stUniverso	* paux;
    stAbonado    * aaux;
    char        rut_clientetmp[20];
	long		lCantAbonados = 0;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;
		char	szhCodTipComis[3];
		long	lhCodComisonista;
		char	szhCodTipVendedor[3];
		long	lhCodVendedor;
		
		long	lhCodVendDealer;
		long	lhNumSecuencia;
		char  	szhNumContrato[20];      
		int		ihCodModVenta;
		long  	lhNumVenta;
		int   	ihIndDocComp;
		int   	ihIndConvenio; 
		char 	szhObsIncump[151];
		char  	szhCodOficina[3];
		char  	szhFecVenta[20];
		char  	szhFecRecepcion[20];
		char  	szhFecAceptacion[20];
		long  	lhCodCliente;
		char  	szhNumIdent[20];
		char	szhCodCategoria[11];
		int		ihDiasHabiles;
		int  	ihDiasReales;

		long  	lhNumCelular;
		char  	szhCodPlanTarif[4];
		char  	szhNumSerie[26];
		long  	lhNumAbonado;
		int	 	ihCodAfinidad;
		char  	szhCodTecnologia[8]; 
		char  	chIndProcequi;
		long  	lhCodArticulo;	

		long	lhCodCiclComis;	
		char	szhIdCiclComis[11];
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
                	ihCodTipoRed        		= paux->iCodTipoRed;  
					strcpy(szhCodTipComis      	, paux->szCodTipComis);
					lhCodComisonista    		= paux->lCodComisonista;   
					strcpy(szhCodTipVendedor   	, paux->szCodTipVendedor);
					lhCodVendedor       		= paux->lCodVendedor;   
					lhCodVendDealer     		= paux->lCodVendDealer;   
					strcpy(szhNumContrato      	, paux->szNumContrato);
					ihCodModVenta       		= paux->iCodModVenta;   
					lhNumVenta          		= paux->lNumVenta;
					ihIndDocComp        		= paux->iIndDocComp;
					ihIndConvenio       		= paux->iIndConvenio;   
					strcpy(szhObsIncump       	, paux->szObsIncump);  
					strcpy(szhCodOficina       	, paux->szCodOficina);
					strcpy(szhFecVenta         	, paux->szFecVenta);
					strcpy(szhFecRecepcion    	, paux->szFecRecepcion); 
					strcpy(szhFecAceptacion  	, paux->szFecAceptacion); 
					lhCodCliente        		= paux->lCodCliente;  	
					strcpy(szhNumIdent       	, paux->szNumIdent); 
					strcpy(szhCodCategoria 		, paux->szCodCategoria); 	
					ihDiasHabiles       		= paux->iDiasHabiles;  	
					ihDiasReales        		= paux->iDiasReales; 

					lhNumCelular    			= aaux->lNumCelular;
					strcpy(szhCodPlanTarif 		, aaux->szCodPlanTarif);
					strcpy(szhNumSerie     		, aaux->szNumSerie);
					lhNumAbonado    			= aaux->lNumAbonado;
					ihCodAfinidad   			= aaux->iCodAfinidad;
					strcpy(szhCodTecnologia		, aaux->szCodTecnologia);
					chIndProcequi   			= aaux->cIndProcequi;
					lhCodArticulo   			= aaux->lCodArticulo;
                
                    /* EXEC SQL SELECT CMS_REG_SELECCION.NEXTVAL INTO :lhNumSecuencia FROM DUAL; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 14;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select CMS_REG_SELECCION.nextval  into :b\
0  from DUAL ";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )355;
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
					
                    /* EXEC SQL INSERT INTO CMT_HABIL_CELULAR (
                    	NUM_GENERAL     , NUM_VENTA       , FEC_VENTA       ,
                        FEC_RECEPCION   , FEC_ACEPTACION  , NUM_CONTRATO    ,
                        COD_MODVENTA    , IND_DOCUM       , COD_OFICINA     ,
                        COD_TIPCOMIS    , COD_COMISIONISTA, COD_AGENCIA     ,
                        COD_VEND_FINAL  , COD_CLIENTE     , NUM_ABONADO     ,
                        COD_AFINIDAD    , NUM_CELULAR     , NUM_IDENT       , 
                        COD_CATEGCLIENTE, COD_PLANTARIF   , NUM_SERIE       , 
                        COD_ARTICULO    , IND_PROCEQUI    , NUM_DIAS_REALES , 
                        NUM_DIAS_HABILES, COD_PERIODO     , ID_PERIODO      ,
                        OBS_INCUMP      , COD_TECNOLOGIA  , IND_CONVENIO	,
                        COD_TIPORED		, COD_TIPVENDEDOR) 
					VALUES (
						:lhNumSecuencia	,:lhNumVenta	,
						TO_DATE(:szhFecVenta,'DD/MM/YYYY HH24:MI:SS'),
						TO_DATE(:szhFecRecepcion,'DD/MM/YYYY HH24:MI:SS'),
						TO_DATE(:szhFecAceptacion,'DD/MM/YYYY HH24:MI:SS'), 
						:szhNumContrato,
						:ihCodModVenta	, :ihIndDocComp		, :szhCodOficina	,
						:szhCodTipComis	, :lhCodComisonista	, :lhCodVendedor	,
						:lhCodVendDealer, :lhCodCliente		, :lhNumAbonado		, 
						:ihCodAfinidad	, :lhNumCelular		, :szhNumIdent		,
						:szhCodCategoria, :szhCodPlanTarif	, :szhNumSerie		,
						:lhCodArticulo	, :chIndProcequi	, :ihDiasReales		,
						:ihDiasHabiles	, :lhCodCiclComis	, :szhIdCiclComis	,
						:szhObsIncump	, :szhCodTecnologia	, :ihIndConvenio	,
						:ihCodTipoRed	, :szhCodTipVendedor ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 32;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CMT_HABIL_CELULAR (NUM_GENERA\
L,NUM_VENTA,FEC_VENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_MODVENTA,I\
ND_DOCUM,COD_OFICINA,COD_TIPCOMIS,COD_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,\
COD_CLIENTE,NUM_ABONADO,COD_AFINIDAD,NUM_CELULAR,NUM_IDENT,COD_CATEGCLIENTE,CO\
D_PLANTARIF,NUM_SERIE,COD_ARTICULO,IND_PROCEQUI,NUM_DIAS_REALES,NUM_DIAS_HABIL\
ES,COD_PERIODO,ID_PERIODO,OBS_INCUMP,COD_TECNOLOGIA,IND_CONVENIO,COD_TIPORED,C\
OD_TIPVENDEDOR) values (:b0,:b1,TO_DATE(:b2,'DD/MM/YYYY HH24:MI:SS'),TO_DATE(:\
b3,'DD/MM/YYYY HH24:MI:SS'),TO_DATE(:b4,'DD/MM/YYYY HH24:MI:SS'),:b5,:b6,:b7,:\
b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:\
b24,:b25,:b26,:b27,:b28,:b29,:b30,:b31)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )374;
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
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumVenta;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhFecVenta;
                    sqlstm.sqhstl[2] = (unsigned long )20;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhFecRecepcion;
                    sqlstm.sqhstl[3] = (unsigned long )20;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhFecAceptacion;
                    sqlstm.sqhstl[4] = (unsigned long )20;
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
                    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodModVenta;
                    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[6] = (         int  )0;
                    sqlstm.sqindv[6] = (         short *)0;
                    sqlstm.sqinds[6] = (         int  )0;
                    sqlstm.sqharm[6] = (unsigned long )0;
                    sqlstm.sqadto[6] = (unsigned short )0;
                    sqlstm.sqtdso[6] = (unsigned short )0;
                    sqlstm.sqhstv[7] = (unsigned char  *)&ihIndDocComp;
                    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[7] = (         int  )0;
                    sqlstm.sqindv[7] = (         short *)0;
                    sqlstm.sqinds[7] = (         int  )0;
                    sqlstm.sqharm[7] = (unsigned long )0;
                    sqlstm.sqadto[7] = (unsigned short )0;
                    sqlstm.sqtdso[7] = (unsigned short )0;
                    sqlstm.sqhstv[8] = (unsigned char  *)szhCodOficina;
                    sqlstm.sqhstl[8] = (unsigned long )3;
                    sqlstm.sqhsts[8] = (         int  )0;
                    sqlstm.sqindv[8] = (         short *)0;
                    sqlstm.sqinds[8] = (         int  )0;
                    sqlstm.sqharm[8] = (unsigned long )0;
                    sqlstm.sqadto[8] = (unsigned short )0;
                    sqlstm.sqtdso[8] = (unsigned short )0;
                    sqlstm.sqhstv[9] = (unsigned char  *)szhCodTipComis;
                    sqlstm.sqhstl[9] = (unsigned long )3;
                    sqlstm.sqhsts[9] = (         int  )0;
                    sqlstm.sqindv[9] = (         short *)0;
                    sqlstm.sqinds[9] = (         int  )0;
                    sqlstm.sqharm[9] = (unsigned long )0;
                    sqlstm.sqadto[9] = (unsigned short )0;
                    sqlstm.sqtdso[9] = (unsigned short )0;
                    sqlstm.sqhstv[10] = (unsigned char  *)&lhCodComisonista;
                    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[10] = (         int  )0;
                    sqlstm.sqindv[10] = (         short *)0;
                    sqlstm.sqinds[10] = (         int  )0;
                    sqlstm.sqharm[10] = (unsigned long )0;
                    sqlstm.sqadto[10] = (unsigned short )0;
                    sqlstm.sqtdso[10] = (unsigned short )0;
                    sqlstm.sqhstv[11] = (unsigned char  *)&lhCodVendedor;
                    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[11] = (         int  )0;
                    sqlstm.sqindv[11] = (         short *)0;
                    sqlstm.sqinds[11] = (         int  )0;
                    sqlstm.sqharm[11] = (unsigned long )0;
                    sqlstm.sqadto[11] = (unsigned short )0;
                    sqlstm.sqtdso[11] = (unsigned short )0;
                    sqlstm.sqhstv[12] = (unsigned char  *)&lhCodVendDealer;
                    sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[12] = (         int  )0;
                    sqlstm.sqindv[12] = (         short *)0;
                    sqlstm.sqinds[12] = (         int  )0;
                    sqlstm.sqharm[12] = (unsigned long )0;
                    sqlstm.sqadto[12] = (unsigned short )0;
                    sqlstm.sqtdso[12] = (unsigned short )0;
                    sqlstm.sqhstv[13] = (unsigned char  *)&lhCodCliente;
                    sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[13] = (         int  )0;
                    sqlstm.sqindv[13] = (         short *)0;
                    sqlstm.sqinds[13] = (         int  )0;
                    sqlstm.sqharm[13] = (unsigned long )0;
                    sqlstm.sqadto[13] = (unsigned short )0;
                    sqlstm.sqtdso[13] = (unsigned short )0;
                    sqlstm.sqhstv[14] = (unsigned char  *)&lhNumAbonado;
                    sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[14] = (         int  )0;
                    sqlstm.sqindv[14] = (         short *)0;
                    sqlstm.sqinds[14] = (         int  )0;
                    sqlstm.sqharm[14] = (unsigned long )0;
                    sqlstm.sqadto[14] = (unsigned short )0;
                    sqlstm.sqtdso[14] = (unsigned short )0;
                    sqlstm.sqhstv[15] = (unsigned char  *)&ihCodAfinidad;
                    sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[15] = (         int  )0;
                    sqlstm.sqindv[15] = (         short *)0;
                    sqlstm.sqinds[15] = (         int  )0;
                    sqlstm.sqharm[15] = (unsigned long )0;
                    sqlstm.sqadto[15] = (unsigned short )0;
                    sqlstm.sqtdso[15] = (unsigned short )0;
                    sqlstm.sqhstv[16] = (unsigned char  *)&lhNumCelular;
                    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[16] = (         int  )0;
                    sqlstm.sqindv[16] = (         short *)0;
                    sqlstm.sqinds[16] = (         int  )0;
                    sqlstm.sqharm[16] = (unsigned long )0;
                    sqlstm.sqadto[16] = (unsigned short )0;
                    sqlstm.sqtdso[16] = (unsigned short )0;
                    sqlstm.sqhstv[17] = (unsigned char  *)szhNumIdent;
                    sqlstm.sqhstl[17] = (unsigned long )20;
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
                    sqlstm.sqhstv[20] = (unsigned char  *)szhNumSerie;
                    sqlstm.sqhstl[20] = (unsigned long )26;
                    sqlstm.sqhsts[20] = (         int  )0;
                    sqlstm.sqindv[20] = (         short *)0;
                    sqlstm.sqinds[20] = (         int  )0;
                    sqlstm.sqharm[20] = (unsigned long )0;
                    sqlstm.sqadto[20] = (unsigned short )0;
                    sqlstm.sqtdso[20] = (unsigned short )0;
                    sqlstm.sqhstv[21] = (unsigned char  *)&lhCodArticulo;
                    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[21] = (         int  )0;
                    sqlstm.sqindv[21] = (         short *)0;
                    sqlstm.sqinds[21] = (         int  )0;
                    sqlstm.sqharm[21] = (unsigned long )0;
                    sqlstm.sqadto[21] = (unsigned short )0;
                    sqlstm.sqtdso[21] = (unsigned short )0;
                    sqlstm.sqhstv[22] = (unsigned char  *)&chIndProcequi;
                    sqlstm.sqhstl[22] = (unsigned long )1;
                    sqlstm.sqhsts[22] = (         int  )0;
                    sqlstm.sqindv[22] = (         short *)0;
                    sqlstm.sqinds[22] = (         int  )0;
                    sqlstm.sqharm[22] = (unsigned long )0;
                    sqlstm.sqadto[22] = (unsigned short )0;
                    sqlstm.sqtdso[22] = (unsigned short )0;
                    sqlstm.sqhstv[23] = (unsigned char  *)&ihDiasReales;
                    sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[23] = (         int  )0;
                    sqlstm.sqindv[23] = (         short *)0;
                    sqlstm.sqinds[23] = (         int  )0;
                    sqlstm.sqharm[23] = (unsigned long )0;
                    sqlstm.sqadto[23] = (unsigned short )0;
                    sqlstm.sqtdso[23] = (unsigned short )0;
                    sqlstm.sqhstv[24] = (unsigned char  *)&ihDiasHabiles;
                    sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[24] = (         int  )0;
                    sqlstm.sqindv[24] = (         short *)0;
                    sqlstm.sqinds[24] = (         int  )0;
                    sqlstm.sqharm[24] = (unsigned long )0;
                    sqlstm.sqadto[24] = (unsigned short )0;
                    sqlstm.sqtdso[24] = (unsigned short )0;
                    sqlstm.sqhstv[25] = (unsigned char  *)&lhCodCiclComis;
                    sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[25] = (         int  )0;
                    sqlstm.sqindv[25] = (         short *)0;
                    sqlstm.sqinds[25] = (         int  )0;
                    sqlstm.sqharm[25] = (unsigned long )0;
                    sqlstm.sqadto[25] = (unsigned short )0;
                    sqlstm.sqtdso[25] = (unsigned short )0;
                    sqlstm.sqhstv[26] = (unsigned char  *)szhIdCiclComis;
                    sqlstm.sqhstl[26] = (unsigned long )11;
                    sqlstm.sqhsts[26] = (         int  )0;
                    sqlstm.sqindv[26] = (         short *)0;
                    sqlstm.sqinds[26] = (         int  )0;
                    sqlstm.sqharm[26] = (unsigned long )0;
                    sqlstm.sqadto[26] = (unsigned short )0;
                    sqlstm.sqtdso[26] = (unsigned short )0;
                    sqlstm.sqhstv[27] = (unsigned char  *)szhObsIncump;
                    sqlstm.sqhstl[27] = (unsigned long )151;
                    sqlstm.sqhsts[27] = (         int  )0;
                    sqlstm.sqindv[27] = (         short *)0;
                    sqlstm.sqinds[27] = (         int  )0;
                    sqlstm.sqharm[27] = (unsigned long )0;
                    sqlstm.sqadto[27] = (unsigned short )0;
                    sqlstm.sqtdso[27] = (unsigned short )0;
                    sqlstm.sqhstv[28] = (unsigned char  *)szhCodTecnologia;
                    sqlstm.sqhstl[28] = (unsigned long )8;
                    sqlstm.sqhsts[28] = (         int  )0;
                    sqlstm.sqindv[28] = (         short *)0;
                    sqlstm.sqinds[28] = (         int  )0;
                    sqlstm.sqharm[28] = (unsigned long )0;
                    sqlstm.sqadto[28] = (unsigned short )0;
                    sqlstm.sqtdso[28] = (unsigned short )0;
                    sqlstm.sqhstv[29] = (unsigned char  *)&ihIndConvenio;
                    sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[29] = (         int  )0;
                    sqlstm.sqindv[29] = (         short *)0;
                    sqlstm.sqinds[29] = (         int  )0;
                    sqlstm.sqharm[29] = (unsigned long )0;
                    sqlstm.sqadto[29] = (unsigned short )0;
                    sqlstm.sqtdso[29] = (unsigned short )0;
                    sqlstm.sqhstv[30] = (unsigned char  *)&ihCodTipoRed;
                    sqlstm.sqhstl[30] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[30] = (         int  )0;
                    sqlstm.sqindv[30] = (         short *)0;
                    sqlstm.sqinds[30] = (         int  )0;
                    sqlstm.sqharm[30] = (unsigned long )0;
                    sqlstm.sqadto[30] = (unsigned short )0;
                    sqlstm.sqtdso[30] = (unsigned short )0;
                    sqlstm.sqhstv[31] = (unsigned char  *)szhCodTipVendedor;
                    sqlstm.sqhstl[31] = (unsigned long )3;
                    sqlstm.sqhsts[31] = (         int  )0;
                    sqlstm.sqindv[31] = (         short *)0;
                    sqlstm.sqinds[31] = (         int  )0;
                    sqlstm.sqharm[31] = (unsigned long )0;
                    sqlstm.sqadto[31] = (unsigned short )0;
                    sqlstm.sqtdso[31] = (unsigned short )0;
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
/* Rutina encargada de obtener el numero de dias corridos transcurridos      */
/* entre dos fechas.                                                         */
/*****************************************************************************/
int     iGetNumDias(char *pszFecIni, char *pszFecTerm)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szhFecIni[11] ;
                char    szhFecTerm[11];
                int     ihNumDias     ;
        /* EXEC SQL END DECLARE SECTION; */ 

        
    strcpy(szhFecIni, pszFecIni);
    strcpy(szhFecTerm, pszFecTerm);

    /* EXEC SQL SELECT TO_DATE(:szhFecTerm, 'dd/mm/yyyy') - TO_DATE(:szhFecIni,'dd/mm/yyyy')
        INTO   :ihNumDias
        FROM   DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 32;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select (TO_DATE(:b0,'dd/mm/yyyy')-TO_DATE(:b1,'dd/mm/yyyy\
')) into :b2  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )517;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecTerm;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecIni;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihNumDias;
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


	return(ihNumDias);
}

/*****************************************************************************/
/* Rutina encargada de agregar 1 dia a la fecha que se le entrega por        */
/* parametro. El valor es retornado como puntero a char.                     */
/*****************************************************************************/
char    GTMPFecha_pszSumaDia[15];

char    *pszSumaDia (char *pszFecha)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhFecha[11]   ;
        char    szhFechaNext[11];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhFecha, pszFecha);

    /* EXEC SQL SELECT to_char(TO_DATE(:szhFecha, 'dd-mm-yyyy') + 1, 'dd-mm-yyyy')
                 INTO   :szhFechaNext
                 FROM   DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 32;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select to_char((TO_DATE(:b0,'dd-mm-yyyy')+1),'dd-mm-yyyy'\
) into :b1  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )544;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFechaNext;
    sqlstm.sqhstl[1] = (unsigned long )11;
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



    szfnTrim(szhFechaNext);
    strcpy(GTMPFecha_pszSumaDia, szhFechaNext);
    return((char *)GTMPFecha_pszSumaDia);    
}

/*****************************************************************************/
/* Funcion encargada de acceder a la tabla CMD_DIASFEST, para verificar que   */
/* el dia es o no feriado.                                                   */
/*****************************************************************************/
int     iGetDiaFeriado (char *pszFecha)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhFecha[11] ;
        int     ihNumReg = 0 ;
        /* EXEC SQL END DECLARE SECTION; */ 

        strcpy(szhFecha, pszFecha);
                ihNumReg = 0;

        /* EXEC SQL SELECT COUNT(*)
                INTO :ihNumReg
                FROM CMD_DIASFEST
                WHERE FEC_DIAFEST = TO_DATE(:szhFecha, 'dd-mm-yyyy'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 32;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from CMD_DIASFEST where FE\
C_DIAFEST=TO_DATE(:b1,'dd-mm-yyyy')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )567;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihNumReg;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecha;
        sqlstm.sqhstl[1] = (unsigned long )11;
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


        return(ihNumReg);
}

/*****************************************************************************/
/* Rutina encargada de obtener el tipo de dia (habil o inhabil) asociado a   */
/* una fecha.                                                                */
/*****************************************************************************/
int iGetTipoDia (char *pszFecha)
{
    int iTipoDia;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhFecha[11]   ;
    int ihNumDia       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhFecha, pszFecha);
    if(iGetDiaFeriado(pszFecha) > 0)
    {
        iTipoDia = 0;
        return(iTipoDia);
    }
     /* EXEC SQL SELECT    TO_CHAR(TO_DATE(:szhFecha, 'dd-mm-yyyy'), 'D')
                  INTO          :ihNumDia
              FROM              DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 32;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select TO_CHAR(TO_DATE(:b0,'dd-mm-yyyy'),'D') into :b1  \
from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )590;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
     sqlstm.sqhstl[0] = (unsigned long )11;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihNumDia;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    switch(ihNumDia)
   {
    case    2:
        iTipoDia = HABIL;
        break;    
    case    3:
        iTipoDia = HABIL;
        break;    
    case    4:
        iTipoDia = HABIL;
        break;    
    case    5:
        iTipoDia = HABIL;
        break;
    case    6:
        iTipoDia = HABIL;
        break;
    default:
        iTipoDia = 0;
        break;
   }
    return(iTipoDia);
}

/*****************************************************************************/
/* Rutina encargada de determinar el                                         */
/* numero de dias habiles transcurridos entre dos fechas                     */
/*****************************************************************************/

int iCalculaDiasHabiles (char *pszFecIni, char *pszFecTerm)
{
    int iNumDiasHabil = 0 ;
    char    szFecTerm[11]     ;
    char    szFecMov[11]      ;

    strcpy(szFecMov, (char *)pszSumaDia(pszFecIni));
    strcpy(szFecTerm, pszFecTerm);
    while(iGetNumDias(szFecMov, szFecTerm) >= 0)
    {                  
         switch(iGetTipoDia(szFecMov))
         {
           case HABIL:
                      iNumDiasHabil++;
                      break;
         }
         strcpy(szFecMov, (char *)pszSumaDia(szFecMov));
    }
    return(iNumDiasHabil);
}

/*****************************************************************************/
/* Rutina encargada de filtar caracteres extraños de glosa                   */
/*****************************************************************************/

void vFiltraGlosa(char *szhObsIncump,char *szObsIncumpFil)
{

int i=0;
int j=0;
int  iCaracter;
char cCaracter;


    for( i=0; szhObsIncump[i] != '\0' ; i++)
    {
        iCaracter = szhObsIncump[i];
        
        if ( (iCaracter >= 65 && iCaracter <= 90) || /* Letra Mayuscula */
             (iCaracter >= 97 && iCaracter <=122) || /* Letra Minuscula */
             (iCaracter >= 48 && iCaracter <=57 ) || /* Numero */  
             (iCaracter == 32 || iCaracter == 35 ||  /* SPACE # */
              iCaracter == 40 || iCaracter == 41 ||  /* ( ) */
              iCaracter == 44 || iCaracter == 45 ||  /* , - */
              iCaracter == 46 || iCaracter == 63) )  /* . ? */
              
            cCaracter = szhObsIncump[i];
        else
            cCaracter = 32; /* SPACE */
    
        szObsIncumpFil[j] = cCaracter;
        j++;
    }
    
    szObsIncumpFil[j] = '\0';
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

/*****************************************************************************/
/* Rutina principal.                                                         */
/*****************************************************************************/
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
/* Inicialización estructura de Bloque(proceso).                             */
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

    /* fprintf(pfLog,"\nUsername unix : %s   (id = %d)\n", getlogin(), getuid()); */
    /* fprintf(pfLog,"Base de datos : %s\n\n", (strcmp(getenv("ORACLE_SID"), "")!=0?getenv("ORACLE_SID"):getenv("TWO_TASK"))); */
/*---------------------------------------------------------------------------*/
/* MODIFICACION DE CONFIGURACION AMBIENTAL, PARA MANEJO DE FECHAS EN ORACLE. */
/*---------------------------------------------------------------------------*/
	/* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 32;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )613;
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
 sqlstm.arrsiz = 32;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )628;
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

