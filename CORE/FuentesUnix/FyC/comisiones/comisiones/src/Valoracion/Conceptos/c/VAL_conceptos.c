
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
           char  filnam[22];
};
static struct sqlcxp sqlfpn =
{
    21,
    "./pc/VAL_conceptos.pc"
};


static unsigned int sqlctx = 110898467;


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
   unsigned char  *sqhstv[14];
   unsigned long  sqhstl[14];
            int   sqhsts[14];
            short *sqindv[14];
            int   sqinds[14];
   unsigned long  sqharm[14];
   unsigned long  *sqharc[14];
   unsigned short  sqadto[14];
   unsigned short  sqtdso[14];
} sqlstm = {12,14};

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
"select NUM_DESDE ,NUM_HASTA ,IMP_COMISION  from CMD_DETMATRIZCOM where (NUM_\
FILA>0 and NUM_MATRIZ=:b0) order by NUM_DESDE desc             ";

 static char *sq0004 = 
"select NUM_MATRIZ ,NUM_ACTUACION ,COD_PERIODO_INI ,COD_PERIODO_FIN  from CMD\
_MATRIZCOM where (NUM_MATRIZ>0 and :b0 between COD_PERIODO_INI and COD_PERIODO\
_FIN) order by NUM_ACTUACION desc             ";

 static char *sq0005 = 
"select VAL_METAPARCIAL ,COD_PERIODO  from CMD_DETMETAS where (NUM_METAPARCIA\
L>0 and NUM_META=:b0) order by COD_PERIODO desc             ";

 static char *sq0006 = 
"select distinct A.NUM_META ,A.NUM_ACTUACION ,A.COD_COMISIONISTA ,B.NOM_VENDE\
DOR ,A.VAL_META ,A.IND_TIPMETA ,A.COD_PERIODO_INI ,A.COD_PERIODO_FIN  from CMD\
_METAS A ,VE_VENDEDORES B ,VE_REDVENTAS_TD C where (((((A.NUM_META>0 and :b0 b\
etween A.COD_PERIODO_INI and A.COD_PERIODO_FIN) and A.COD_COMISIONISTA=B.COD_V\
ENDEDOR) and B.COD_VENDEDOR=C.COD_VENDEDOR) and C.COD_TIPORED=:b1) and B.COD_T\
IPCOMIS=:b2) order by NUM_ACTUACION desc             ";

 static char *sq0007 = 
"select distinct A.COD_VENDEDOR ,A.NOM_VENDEDOR  from VE_VENDEDORES A ,VE_EST\
ADOS_TD B ,VE_REDVENTAS_TD C where (((A.COD_TIPCOMIS=:b0 and A.COD_ESTADO=B.CO\
D_ESTADO) and C.COD_TIPORED=:b1) and C.COD_VENDEDOR=A.COD_VENDEDOR)           ";

 static char *sq0008 = 
"select NUM_ACTUACION ,COD_VENDEDOR ,IMP_COMISION  from CM_VALDIFERENCIADA_TD\
  order by NUM_ACTUACION,COD_VENDEDOR            ";

 static char *sq0009 = 
"select NUM_ACTUACION ,TIP_PLAN ,COD_CATEGCLIENTE ,COD_OFICINA ,NVL(IND_ESCAL\
ONADO,'N') ,IMP_COMISION ,TO_CHAR(FEC_DESDE,'DD-MM-YYYY') ,TO_CHAR(FEC_HASTA,'\
DD-MM-YYYY') ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,'YYYYMM\
DDHH24MISS')  from CM_VALCONTRATOS_TD where ((((NUM_ACTUACION>0 and COD_TIPORE\
D=:b0) and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2) and ((FEC_DESDE between TO\
_DATE(:b3,'DD-MM-YYYY') and TO_DATE(:b4,'DD-MM-YYYY') or FEC_HASTA between TO_\
DATE(:b3,'DD-MM-YYYY') and TO_DATE(:b4,'DD-MM-YYYY')) or (to_date(:b3,'DD-MM-Y\
YYY') between FEC_DESDE and FEC_HASTA or TO_DATE(:b4,'DD-MM-YYYY') between FEC\
_DESDE and FEC_HASTA))) order by 2,3,4,6 desc             ";

 static char *sq0010 = 
"select TO_CHAR(R.FEC_ACEPTACION,'DD-MM-YYYY') ,R.NUM_GENERAL ,TO_CHAR(R.FEC_\
ACEPTACION,'YYYYMMDDHH24MISS') ,TO_CHAR(R.FEC_VENTA,'YYYYMMDDHH24MISS') ,F.TIP\
_PLAN ,R.COD_TIPCOMIS ,R.COD_CATEGCLIENTE ,R.COD_COMISIONISTA ,R.COD_OFICINA ,\
TO_CHAR(R.FEC_VENTA,'DD-MM-YYYY') ,R.COD_TECNOLOGIA ,R.COD_TIPORED ,R.COD_TIPV\
ENDEDOR ,R.COD_AGENCIA  from CMT_HABIL_CELULAR R ,CMD_PLANESTARIF F where ((R.\
NUM_GENERAL>0 and R.ID_PERIODO=:b0) and R.COD_PLANTARIF=F.COD_PLANTARIF)      \
     ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,189,0,3,420,0,0,9,9,0,1,0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,4,0,0,1,3,0,0,1,3,0,0,
56,0,0,2,190,0,3,466,0,0,9,9,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,
0,0,1,4,0,0,1,3,0,0,1,3,0,0,
107,0,0,3,139,0,9,727,0,0,1,1,0,1,0,1,3,0,0,
126,0,0,3,0,0,13,731,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
153,0,0,3,0,0,15,750,0,0,0,0,0,1,0,
168,0,0,4,200,0,9,790,0,0,1,1,0,1,0,1,3,0,0,
187,0,0,4,0,0,13,795,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
218,0,0,4,0,0,15,816,0,0,0,0,0,1,0,
233,0,0,5,136,0,9,851,0,0,1,1,0,1,0,1,3,0,0,
252,0,0,5,0,0,13,855,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
275,0,0,5,0,0,15,871,0,0,0,0,0,1,0,
290,0,0,6,441,0,9,938,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
317,0,0,6,0,0,13,944,0,0,8,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,
97,0,0,2,3,0,0,2,3,0,0,
364,0,0,6,0,0,15,977,0,0,0,0,0,1,0,
379,0,0,7,232,0,9,1204,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
402,0,0,7,0,0,13,1210,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
425,0,0,7,0,0,15,1232,0,0,0,0,0,1,0,
440,0,0,8,125,0,9,1303,0,0,0,0,0,1,0,
455,0,0,8,0,0,13,1306,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,
482,0,0,8,0,0,15,1325,0,0,0,0,0,1,0,
497,0,0,9,680,0,9,1404,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
548,0,0,9,0,0,13,1407,0,0,10,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
603,0,0,9,0,0,15,1442,0,0,0,0,0,1,0,
618,0,0,10,471,0,9,1507,0,0,1,1,0,1,0,1,97,0,0,
637,0,0,10,0,0,13,1513,0,0,14,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,
0,0,
708,0,0,10,0,0,15,1557,0,0,0,0,0,1,0,
723,0,0,11,12,0,1,1824,0,0,0,0,0,1,0,
738,0,0,12,48,0,1,1886,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las comisiones (cmt_valorizados)     */
/*----------------------------------------------------------------------*/
/* Version 2 - Revision 01.                                             */
/* Inicio: Viernes 19 de Julio 2002     .                               */
/* Modificado por  Nelson Contreras Helena.                             */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla       */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y     */
/* COD_PARAMETRO.                                                       */
/************************************************************************/
#include "conceptos.h"
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

	char    szhSysDate [17]="";
    char  	szFechaYYYYMMDD[9]="";
    char    szUser[30];
    char    szPass[30];    
/* EXEC SQL END DECLARE SECTION; */ 

/* **************************************************************************** */
/* Determina la meta asociada a una actuacion.                                  */
/* **************************************************************************** */
long lObtieneMeta(long lCodComisionista,long stActuacion, long lCodPeriodo, Lmetas * pmetas)
{
        if (pmetas == NULL)
                return 0;
        if ((pmetas->lNum_Actuacion == stActuacion)&&(pmetas->lCod_Comisionista==lCodComisionista)&&(lCodPeriodo >= pmetas->lCod_Periodo_Ini)&&(lCodPeriodo <= pmetas->lCod_Periodo_Fin))        
        {
                /*fprintf(stderr,"\n(lObtieneMeta)Comis[%ld] Act[%ld] Per[%ld] ValMeta[%ld]\n",lCodComisionista,stActuacion,lCodPeriodo, pmetas->dVal_Meta);*/
                return pmetas->dVal_Meta;
        }
        else
                return  lObtieneMeta(lCodComisionista,stActuacion, lCodPeriodo, pmetas->sgte);
}
/* **************************************************************************** */
/* Busca la matriz de comisiones de una determinada actuacion                   */
/* **************************************************************************** */
Lmatriz * stBuscaMatriz(long lNumActuacion,Lmatriz * pmat,long lCodCiclComis)
{
        if (pmat == NULL)
                return NULL;
        if ((pmat->lNum_Actuacion == lNumActuacion)&&(lCodCiclComis >= pmat->lCod_Periodo_Ini)&&(lCodCiclComis <= pmat->lCod_Periodo_Fin))
        {
                /*fprintf(stderr,"(stBuscaMatriz)pmat->lNum_Actuacion[%ld] pmat->lCod_Periodo_Ini[%ld] pmat->lCod_Periodo_Fin[%ld]\n",pmat->lNum_Actuacion ,pmat->lCod_Periodo_Ini, pmat->lCod_Periodo_Fin);*/
                return pmat;
        }
        else
                return stBuscaMatriz(lNumActuacion,pmat->sgte,lCodCiclComis);
}
/* **************************************************************************** */
/* evalua un monto en la matriz de comisiones que se le pasa por parámetro      */
/* **************************************************************************** */
double dObtieneImporteMatriz(double dPorcentaje,Ldetmatriz * paux)
{
    if (paux == NULL)
            return -1;
    if ((dPorcentaje >= (double)paux->lNum_Desde && dPorcentaje < (double)paux->lNum_Hasta)||(paux->lNum_Hasta == -1))
    {
    	fprintf(pfLog, "\n[dObtieneImporteMatriz] Encontrado....\n");
		return paux->dImp_Comision;
    }
    else
    {
    	return dObtieneImporteMatriz(dPorcentaje,paux->sgte);
    }
}
/* **************************************************************************** */
/* Calcula el escalonamiento de las metas.                                      */
/* **************************************************************************** */
int vCalculaEscalMeta(stActuacion * pActua,long lCodComisionista, double *dImporte)
{
    stVenta          * pVenta;
    Lmatriz     * pmat;
    long            lCuenta_Vtas= 0;
    long            lNumActuacion;
    double          dPorcentaje;    
    long            lValMeta = 0 ;
    long            dImporteSum = 0.00;
    lNumActuacion = pActua->lNumActuacion;
    /* Primero, determinar la meta a cumplir... */
    lValMeta = lObtieneMeta(lCodComisionista,lNumActuacion, stCiclo.lCodCiclComis, lstMetas);
    
    if (lValMeta == 0) 
    {
            fprintf (stderr, "[vCalculaEscalMeta]**lValMeta == 0** Comisionista[%ld] Actuacion[%ld] Periodo[%ld]\n", lCodComisionista,lNumActuacion, stCiclo.lCodCiclComis);
            return -1;
    }
    pmat = stBuscaMatriz(lNumActuacion, lstMatrizCom,stCiclo.lCodCiclComis);
    if (pmat == NULL) 
    {
            fprintf (stderr, "[vCalculaEscalMeta](pmat == NULL)lNumActuacion :[%ld]- Periodo:[%ld]\n", lNumActuacion,stCiclo.lCodCiclComis);
            return -1;
    }
    lCuenta_Vtas = 0;
    for (pVenta = pActua->sgte_venta; pVenta != NULL; pVenta = pVenta->sgte)
    {
        lCuenta_Vtas++;
        dPorcentaje = ((double)lCuenta_Vtas * 100.00) / (double)lValMeta;
    	pVenta->dImpComision = dObtieneImporteMatriz(dPorcentaje,pmat->sgte_detmatriz);
    	dImporteSum += pVenta->dImpComision;
    }
    *dImporte = dImporteSum;
    return ((int) dPorcentaje);
}
/* **************************************************************************** */
/* Calcula la meta obtenida por un comisionista, de forma directa, y aplica     */
/* la comisión asociada.                                                        */
/* **************************************************************************** */
int vCalculaMeta(stActuacion * pActua,long lCodComisionista, long lCantVentas, double *dImporte)
{
        stVenta          * pVenta;
        Lmatriz     * pmat;
        long            lNumActuacion;
        double          dImpComision;
        double          dPorcentaje;    
        long            lValMeta = 0 ;
        
        lNumActuacion = pActua->lNumActuacion;
        /* Primero, determinar la meta a cumplir... */
        lValMeta = lObtieneMeta(lCodComisionista,lNumActuacion, stCiclo.lCodCiclComis, lstMetas);
        
        if (lValMeta == 0) 
        {
                fprintf (stderr, "[vCalculaMeta]**lValMeta == 0** Comisionista[%ld] Actuacion[%ld] Periodo[%ld]\n", lCodComisionista,lNumActuacion, stCiclo.lCodCiclComis);
                return -1;
        }
    pmat = stBuscaMatriz(lNumActuacion, lstMatrizCom,stCiclo.lCodCiclComis);
        if (pmat == NULL) 
        {
                fprintf (stderr, "[vCalculaMeta](pmat == NULL)lNumActuacion :[%ld]- Periodo:[%ld]\n", lNumActuacion,stCiclo.lCodCiclComis);
                return -1;
        }
        dPorcentaje = ((double)lCantVentas * 100.00) / (double)lValMeta;
        dImpComision = dObtieneImporteMatriz(dPorcentaje,pmat->sgte_detmatriz);
    *dImporte = dAsigna_Comision(pActua->sgte_venta, dImpComision);
    fprintf(stderr,"[vCalculaMeta]lCantVentas[%ld] dPorcentaje[%f][%d]  Comision[%f]\n",lCantVentas,dPorcentaje,(int)dPorcentaje,dImpComision);
        return ((int)dPorcentaje);
}
/*****************************************************************************/
/* Evalua la cantidad de ventas en la matriz de comisiones asociada a la     */
/* actuación, retornando el importe de la comisión.                          */
/*****************************************************************************/
double dObtiene_Importe(long lNumActuacion, double dCanVentas)
{
    Lmatriz         * pmat;
    double          dImpComision;

    pmat = stBuscaMatriz(lNumActuacion, lstMatrizCom, stCiclo.lCodCiclComis);
	if (pmat==NULL)
	{
		fprintf(pfLog, "\n[dObtiene_Importe] No Encontro Matriz de Comisiones Actuacion:[%d].\n",lNumActuacion);
		return -1.00;
	}
	dImpComision = dObtieneImporteMatriz(dCanVentas,pmat->sgte_detmatriz);
	if (dImpComision >= 0.00)
    {
    	return dImpComision; 
    }
    else
   	{
		fprintf(pfLog, "\n[dObtiene_Importe] Matriz de Comisiones Mal Construida. Actuacion:[%d].\n",lNumActuacion);
        return -1.00;
	}
}
/* **************************************************************************** */
/* Asigna importe en forma escalonada. (VOLUMEN).                               */
/* **************************************************************************** */
int iAsigna_Escalonado(long lNumActuacion, stVenta * pven, long lCanVentas)
{
    stVenta          * paux;
    long            lCantVentas = 0 ;
    double          dImporte;
 	Lmatriz         * pmat;

    pmat = stBuscaMatriz(lNumActuacion, lstMatrizCom, stCiclo.lCodCiclComis);
	if (pmat==NULL)
	{
		fprintf(pfLog, "\n[iAsigna_Escalonado] No Encontro Matriz de Comisiones Actuacion:[%d].\n",lNumActuacion);
		return -1;
	}
	fprintf(pfLog, "\n[iAsigna_Escalonado] Actuacion:[%d] posee matriz vigente Ini[%d] Fin:[%d]. VentasTotales:[%d].\n",lNumActuacion, pmat->lCod_Periodo_Ini, pmat->lCod_Periodo_Ini, lCanVentas);
    for (paux = pven; paux != NULL; paux = paux->sgte)
    {
        lCantVentas++;
        dImporte = dObtieneImporteMatriz(lCantVentas,pmat->sgte_detmatriz);
		fprintf(pfLog, "\n[iAsigna_Escalonado] Determina Importe:[%5.2f] para NumGral.:[%ld] Comisionista:[%d].\n", dImporte ,paux->lNumGeneral, paux->lCodVendedor);
        if (dImporte >= 0)
        {
        	paux->dImpComision = dImporte;
        }
        else
        {
			fprintf(pfLog, "\n[iAsigna_Escalonado] Matriz de Comisiones Mal Construida. Actuacion:[%d].\n",lNumActuacion);
            return -1;
        }
    }
    return 1;
}
/* **************************************************************************** */
/* Obtencion de importe de para caso 4. Meta Mensual.                           */
/* **************************************************************************** */
double dObtiene_Importe_Mensual(Lmetas * pmet, long lNumActuacion,long lCanVentas)
{
    double  dCumplimiento;

    dCumplimiento = (double)lCanVentas * 100.00 / (double)pmet->dVal_Meta;
    return dObtiene_Importe(lNumActuacion, dCumplimiento);
}


/* **************************************************************************** */
/* Obtencion de importe de para caso 5. Meta Anual.                             */
/* **************************************************************************** */
double dObtiene_Importe_Anual(Lmetas * pmet, long lNumActuacion,long lCanVentas)
{
    double      dCumplimiento;
	Ldetmetas       * paux;

    for (paux = pmet->sgte_detmeta; 
             paux != NULL && paux->lCod_Periodo < stCiclo.lCodCiclComis;
             paux = paux->sgte)
                ; /* solo se avanza */

    if (paux == NULL || paux->lCod_Periodo != stCiclo.lCodCiclComis)
        return -1; 
    dCumplimiento = lCanVentas * 100 / paux->dVal_MetaParcial;
	return dObtiene_Importe(lNumActuacion, dCumplimiento);
}
/* **************************************************************************** */
/* Asignacion de comision entre las ventas.                                     */
/* **************************************************************************** */
double dAsigna_Comision(stVenta * pven, double dImpComision)
{
        stVenta  * paux;
        double  dImpConcepto = 0.00;
        for (paux = pven; paux != NULL; paux = paux->sgte)
        {
                paux->dImpComision = dImpComision;
                dImpConcepto+=dImpComision;
        }
        return dImpConcepto;
}
/* **************************************************************************** */
/* **************************************************************************** */
int iDetTipoCalculo(char * szIndCalculo, char * szIndEscalonado)
{
	if (strcmp(szIndCalculo, "D")==0)
    	return TIPDIRECTO;
    
    if ((strcmp(szIndCalculo, "V")==0)&&(strcmp(szIndEscalonado, "N")==0))
    	return TIPVOLNOES;
    
    if ((strcmp(szIndCalculo, "V")==0)&&(strcmp(szIndEscalonado, "S")==0))
    	return TIPVOLUMES;
    
    if ((strcmp(szIndCalculo, "M")==0)&&(strcmp(szIndEscalonado, "N")==0))
    	return TIPMETNOES;
    
    if ((strcmp(szIndCalculo, "M")==0)&&(strcmp(szIndEscalonado, "S")==0))
    	return TIPMETAESC;

	return 0;
}
/* **************************************************************************** */
/* Rutina que realiza valorizacion de ventas .                                  */
/* **************************************************************************** */
void vValorizando()
{
    stUniverso   * puni;
    stConcepto   * pcon;
    stActuacion  * pact;
    stVenta      * pven;
    
    char         cIndMeta;
    char         cIndTipCalculo[2];
    char         cIndEscalonado[2];
    short        iIndIndEscalonado;
    double       dImporte;
    int          iValLogro = 0;
	int			iCasoValora;

    /* Recorre el universo de TipoRed/TipComis. */
    for (puni = lstUniverso; puni != NULL; puni = puni->sgte) 
    {
        /* Recorre el conjunto de conceptos asociados a cada tipo de Red/TipComis*/
        for (pcon = puni->sgte_concepto; pcon != NULL; pcon = pcon->sgte) 
        {
        	/* Evalua cada actuacion, de la lista de conceptos. */
            for (pact = pcon->sgte_actuacion; pact != NULL; pact = pact->sgte)
			{
				if (pact->lNumActuacion != -1 && pact->lCanVentas > 0) 
				{
					iCasoValora = iDetTipoCalculo(pcon->cTipCalculo,pact->szIndEscalonado);
	
			        fprintf(pfLog, "\n[vValorizando] TR:[%d] Comisionista:[%d] Act.[%ld] TipoCalculo:[%s] IndEscalonado:[%s] >> CasoValoracion:[%d]\n", puni->iCodTipoRed, puni->lCod_Comisionista, pact->lNumActuacion, pcon->cTipCalculo, pact->szIndEscalonado, iCasoValora);
                	dImporte		  		= 0.00;
			        switch (iCasoValora)
					{    
			        	case TIPDIRECTO: 	/* CASO 1 : Tipo de Calculo Directo*/
		                	for(pven = pact->sgte_venta; pven != NULL; pven = pven->sgte)
		                	{
		                		if(dImporte = dImporteDiferenciada(lstActDiferenciada,pact->lNumActuacion,pven->lCodVendedor)==-1)
		                		{
		                			dImporte = pact->dImpComision;
		                		}
		                		pven->dImpComision = dImporte;
		                		pcon->dImpConcepto+=dImporte;
		                	}
							break;
						case TIPVOLNOES:	/* CASO 2 : No Escalonado, Por Volumen */
		                    dImporte = dObtiene_Importe(pact->lNumActuacion, pact->lCanVentas);
		                    if (dImporte < 0.00)
		                    {
		                        fprintf(pfLog,"[vValorizando] Error de dObtiene_Importe [%f]\n", dImporte);
		                        fprintf(pfLog,"[vValorizando] Actuacion [%d] no posee importe en matriz de Comision\n",pact->lNumActuacion);
		                        fprintf(pfLog,"[vValorizando] TipComis: [%s] Comisionista: [%d] Concepto:[%d]\n",puni->szCod_TipComis, puni->lCod_Comisionista, pcon->iCodConcepto);
		                        /* exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"Actuacion no posee Importe en Matriz de Comisiones.",0,0));*/
		                        dImporte = 0.00;
		                    }
				            pcon->dImpConcepto = dAsigna_Comision(pact->sgte_venta, dImporte);
				            break;
	                	case TIPVOLUMES:	/* CASO 3 :  Escalonado, Por Volumen */
		                    if (iAsigna_Escalonado(pact->lNumActuacion, pact->sgte_venta,pact->lCanVentas)< 0)
		                    {
		                        fprintf(pfLog,"[vValorizando] Error de asignacion de Volumen Escalonado.\n");
		                        fprintf(pfLog,"[vValorizando] Para actuacion [%d]\n", pact->lNumActuacion);
		                        fprintf(pfLog,"[vValorizando] TipComis: [%s] Comisionista: [%d] Concepto:[%d]\n",puni->szCod_TipComis, puni->lCod_Comisionista, pcon->iCodConcepto);
		                        /*exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"No se pudo asignar Escalonado a Actuacion.",0,0));*/
		                     }   
		                     break;
	            		case TIPMETNOES:	/* CASO 4 : No Escalonado, En base a metas */
		                    if ((iValLogro = vCalculaMeta(pact, puni->lCod_Comisionista,pact->lCanVentas, &pcon->dImpConcepto))<0)
		                    {
		                        fprintf(pfLog,"[vValorizando] Error calculando logro de meta.  \n");
		                        fprintf(pfLog,"[vValorizando] Actuacion [%d].\n", pact->lNumActuacion);
		                        fprintf(pfLog,"[vValorizando] TipComis: [%s] Comisionista: [%d] Concepto:[%d] **No se comisiona**\n",puni->szCod_TipComis, puni->lCod_Comisionista, pcon->iCodConcepto);
		                    }
		                    else
		                    {
		                        pcon->iValLogro = iValLogro;
		                        fprintf(stderr,"[vCalculaMeta]pcon->iValLogro [%d]\n",pcon->iValLogro);
		                    }
		                    break;
	            		case TIPMETAESC:	/* CASO 5 : Escalonado, En base a metas */
		                    if ((iValLogro = vCalculaEscalMeta(pact, puni->lCod_Comisionista, &pcon->dImpConcepto)) < 0 )
		                    {
		                        fprintf(pfLog,"[vValorizando] Error Escalonando Meta...  \n");
		                        fprintf(pfLog,"[vValorizando] Actuacion [%d].\n", pact->lNumActuacion);
		                        fprintf(pfLog,"[vValorizando] TipComis: [%s] Comisionista: [%d] Concepto:[%d] **No se comisiona**\n",puni->szCod_TipComis, puni->lCod_Comisionista, pcon->iCodConcepto);
		                    }
		                    else
		                    {
		                        pcon->iValLogro = iValLogro;
		                        fprintf(stderr,"[vCalculaEscalMeta]pcon->iValLogro [%d]\n",pcon->iValLogro);
		                    }
		                    break;
	            		default:	/* Si no paso por ninguno de los anteriores ERROR */
                			fprintf(pfLog,"**********************************\n");
                            fprintf(pfLog,"**********************************\n");
                            fprintf(pfLog,"[vValorizando] Combinacion no permitida. Concepto:[%d] TipComis:[%s] Comisionista:[%d]\n", pcon->iCodConcepto, puni->szCod_TipComis, puni->lCod_Comisionista);
                            fprintf(pfLog,"[vValorizando]  - Ind_tipcalculo: [%s]\n", cIndTipCalculo);
                            fprintf(pfLog,"[vValorizando]  - Ind_escalonado: [%s]\n", cIndEscalonado);
                            fprintf(pfLog,"**********************************\n");
                            fprintf(pfLog,"**********************************\n");
                            /*exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"Combinacion de tipcalculo, escalonado y meta no Validas.",0,0));*/
							break;
					}
				}                
			}
		}
	}
}

/* **************************************************************************** */
/* Inserta registro en tabla CMT_LOGROS_METAS                                   */
/* **************************************************************************** */
void vInsertaCmtLogrosMetas()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhIdPeriodo  [11];/* EXEC SQL VAR szhIdPeriodo  IS STRING(11); */ 

        int     ihCodPeriodo      ;
        char    szhCodTipComis [3];/* EXEC SQL VAR szhCodTipComis IS STRING(3); */ 

        long    lhCodComisionista ;
        int     ihCodConcepto     ;
        int     ihValLogro        ;
        double  dhImpConcepto     ;
        int     ihNumRegistros    ;
        long	lhCodCiclComis    ;
        int		ihCodTipoRed;
        /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy(szhIdPeriodo,sthCmtLogroMetas.szIdPeriodo);
    strcpy(szhCodTipComis,sthCmtLogroMetas.szCodTipComis);    
     
    lhCodCiclComis 		=   stCiclo.lCodCiclComis;
    lhCodComisionista   =   sthCmtLogroMetas.lCodComisionista;
    ihCodConcepto       =   sthCmtLogroMetas.iCodConcepto;     
    ihValLogro          =   sthCmtLogroMetas.iValLogro;       
    dhImpConcepto       =   fnCnvDouble(sthCmtLogroMetas.dImpConcepto, 0);    
    ihNumRegistros      =   sthCmtLogroMetas.iNumRegistros;   
    ihCodTipoRed		=   sthCmtLogroMetas.iCodTipoRed;

    /* EXEC SQL INSERT INTO CMT_LOGRO_METAS(
        ID_PERIODO, 
        COD_PERIODO , 
        COD_TIPCOMIS,
        COD_COMISIONISTA, 
        COD_CONCEPTO, 
        VAL_LOGRO, 
        IMP_CONCEPTO, 
        NUM_REGISTROS,
        COD_TIPORED)
     VALUES(:szhIdPeriodo,
	    :lhCodCiclComis,  
	    :szhCodTipComis,       
        :lhCodComisionista,
        :ihCodConcepto,    
        :ihValLogro,       
        :dhImpConcepto,    
        :ihNumRegistros,
        :ihCodTipoRed); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_LOGRO_METAS (ID_PERIODO,COD_PERIODO,COD_T\
IPCOMIS,COD_COMISIONISTA,COD_CONCEPTO,VAL_LOGRO,IMP_CONCEPTO,NUM_REGISTROS,COD\
_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclComis;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodComisionista;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihValLogro;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhImpConcepto;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihNumRegistros;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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

  
}
/* **************************************************************************** */
/* Inserta registro en tabla CMT_VALORIZADOS                                    */
/* **************************************************************************** */ 
void vInsertarCmtValorizados()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		char    szhCodTipComis [3];/* EXEC SQL VAR szhCodTipComis IS STRING(3); */ 

		long    lhCodComisionista ;
		int     ihCodConcepto     ;
		char    szhCodUniverso[10];/* EXEC SQL VAR szhCodUniverso IS STRING(10); */ 

		char    szhIdPeriodo  [11];/* EXEC SQL VAR szhIdPeriodo IS STRING(11); */ 

		long    lhNumGeneral;
		double  dhImpComision;
        long	lhCodCiclComis;
        int		ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhCodTipComis,sthCmtLogroMetas.szCodTipComis);
    strcpy(szhCodUniverso,sthCmtLogroMetas.szCodUniverso);
    strcpy(szhIdPeriodo,sthCmtLogroMetas.szIdPeriodo);
    lhCodCiclComis 			= stCiclo.lCodCiclComis;
    lhCodComisionista       = sthCmtLogroMetas.lCodComisionista;
    ihCodConcepto           = sthCmtLogroMetas.iCodConcepto;    
    lhNumGeneral            = sthCmtLogroMetas.lNumGeneral;     
    dhImpComision           = fnCnvDouble(sthCmtLogroMetas.dImpComision, 0);     
    ihCodTipoRed			= sthCmtLogroMetas.iCodTipoRed;
    /* EXEC SQL INSERT INTO CMT_VALORIZADOS(
                COD_TIPCOMIS, 
                COD_COMISIONISTA, 
                COD_CONCEPTO, 
                COD_UNIVERSO, 
                ID_PERIODO, 
                NUM_GENERAL, 
                IMP_CONCEPTO, 
                COD_PERIODO,
                COD_TIPORED)
        VALUES(:szhCodTipComis,
               :lhCodComisionista,
               :ihCodConcepto,
               :szhCodUniverso,
               :szhIdPeriodo,
               :lhNumGeneral,
               :dhImpComision,
               :lhCodCiclComis,
               :ihCodTipoRed ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CMT_VALORIZADOS (COD_TIPCOMIS,COD_COMISIONIST\
A,COD_CONCEPTO,COD_UNIVERSO,ID_PERIODO,NUM_GENERAL,IMP_CONCEPTO,COD_PERIODO,CO\
D_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )56;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipComis;
    sqlstm.sqhstl[0] = (unsigned long )3;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodUniverso;
    sqlstm.sqhstl[3] = (unsigned long )10;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumGeneral;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhImpComision;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
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


}
/* **************************************************************************** */
/* Insercion de registros de valoirizacion en base y archivo de salida          */
/* **************************************************************************** */
void vInserta_Salida()
{
        stUniverso       * puni;
        stVenta          * pven;
        stConcepto       * pcon;
        stActuacion      * pact;
    
    for (puni = lstUniverso; puni != NULL; puni = puni->sgte)
	{
		if (puni->lCan_Ventas == 0)
		    continue;
        for (pcon = puni->sgte_concepto; pcon != NULL; pcon = pcon->sgte)
        {
			if (pcon->lCanVentas == 0)
				continue;
                                
			strcpy(sthCmtLogroMetas.szCodUniverso	, CODUNIVERSO);              
			strcpy(sthCmtLogroMetas.szCodTipComis  	, puni->szCod_TipComis);             
			strcpy(sthCmtLogroMetas.szIdPeriodo     , stCiclo.szIdCiclComis);        
			sthCmtLogroMetas.iCodConcepto           = pcon->iCodConcepto;                
			sthCmtLogroMetas.lCodComisionista       = puni->lCod_Comisionista;           
			sthCmtLogroMetas.iValLogro              = pcon->iValLogro;                   
			sthCmtLogroMetas.dImpConcepto           = fnCnvDouble(pcon->dImpConcepto, 0);
			sthCmtLogroMetas.iNumRegistros          = pcon->lCanVentas;                  
			sthCmtLogroMetas.iCodTipoRed			= puni->iCodTipoRed;
            if ((strcmp(pcon->cTipCalculo, "M")==0)&& (pcon->iValLogro > 0))
            {
                vInsertaCmtLogrosMetas();
                stStatusProc.ilogros += 1;
			}
            for (pact = pcon->sgte_actuacion; pact != NULL; pact = pact->sgte)
            {
                if ((pact->lCanVentas == 0)||(pact->lNumActuacion <= 0))
            		continue;
                for (pven = pact->sgte_venta; pven != NULL; pven = pven->sgte)
                {
                    sthCmtLogroMetas.dImpComision = fnCnvDouble(pven->dImpComision,0);
                    sthCmtLogroMetas.lNumGeneral = pven->lNumGeneral;
                    vInsertarCmtValorizados();
				}
			}
		}
    }
}
/* **************************************************************************** */
/* Devuelve el puntero donde se encuentra el tipcomis y comisionista buscado.   */
/* **************************************************************************** */
stUniverso * stBuscaTipComis(stUniverso * stLista, Ventas * paux)
{
        if (stLista == NULL)
                return NULL;
        if ((stLista->iCodTipoRed == paux->iCodTipoRed)&&(strcmp(stLista->szCod_TipComis,paux->szCodTipComis)==0)&&(stLista->lCod_Comisionista==paux->lCodComisionista))
                return stLista;
        else
                return (stBuscaTipComis(stLista->sgte,paux));
}
/* **************************************************************************** */
/* Devuelve el puntero donde se encuentra la actuacion buscada.                 */
/* **************************************************************************** */
stActuacion * stBuscaActuacion(stActuacion *stLista,Ventas * paux)
{
	if (stLista == NULL) 
		return NULL;

    /* Si se trata del nodo basura, entonces no hay mas.*/
    if (stLista->lNumActuacion == -1) 
    	return stLista;

    /* Si la actuación es categoría TODAS/TODAS */
    if (strcmp(stLista->szTipPlan, TODAS)==0 &&
        strcmp(stLista->szCodCategCliente, TODAS)==0 &&
        strcmp(stLista->szCodOficina, "TO")==0 &&
        stLista->dFecInicio 	<= paux->dFechaVenta &&
        stLista->dFecTermino	>= paux->dFechaVenta)
        return stLista;
        
    /* Si exite match entre las categorias de plan y cliente */
    if (strcmp(stLista->szTipPlan, paux->szTipPlan)==0 &&
        strcmp(stLista->szCodCategCliente, paux->szCodCategCliente)==0 &&
        (strcmp(stLista->szCodOficina, paux->szCodOficina)==0  || strcmp(stLista->szCodOficina, "TO")==0) &&
        stLista->dFecInicio  <= paux->dFechaVenta &&
        stLista->dFecTermino >= paux->dFechaVenta)
        return stLista;
    else
		return stBuscaActuacion(stLista->sgte,paux);
        
}
/* **************************************************************************** */
/* Crea un nodo de actuación y retorna un puntero sobre el.                     */
/* **************************************************************************** */
stActuacion * stCreaActuacionBasura()
{
        stActuacion * pact;
        
        pact = (stActuacion *) malloc (sizeof(stActuacion));
        pact->lNumActuacion 			= -1;

        strcpy(pact->szIndEscalonado	, "N");
        pact->dImpComision 				= 0.00;
        pact->lCanVentas 				= 0;
        pact->sgte_venta 				= NULL;
        pact->sgte 						= NULL;
        return pact;
}
/* **************************************************************************** */
/* Procedimiento que crea un nodo de venta, para asignarlo al universo.         */
/* **************************************************************************** */
stVenta * stCreaNodoVenta(Ventas * paux)
{
	stVenta * pven;

    pven = (stVenta *) malloc (sizeof(stVenta));
    
	strcpy(pven->szCodOficina		, paux->szCodOficina);
	strcpy(pven->szCodCategCliente	, paux->szCodCategCliente);
	strcpy(pven->szTipPlan			, paux->szTipPlan);
	pven->lNumGeneral 				= paux->lNumGeneral;
	pven->dImpComision 				= 0;
	pven->lCodVendedor				= paux->lCodVendedor;
	strcpy(pven->szCodTipVendedor	, paux->szCodTipVendedor);
	pven->sgte 						= NULL;
	return pven;
}
/* **************************************************************************** */
/* Rutina que ingresa las ventas dentro de la estructura general.               */
/* **************************************************************************** */
void vAsigna_Ventas()
{
	stUniverso		* puni;
	stActuacion		* pact;
	stVenta			* pven;
	stVenta			* paux;
	stConcepto		* pcon;
    Ventas			* pventa;
	
	/* Para cada venta en lista de ventas */
	fprintf(pfLog , "\n\n(vAsigna_Ventas)Inicio de Asociacion de Ventas a Estructura de Valoracion.\n");
	fprintf(stderr, "\n\n(vAsigna_Ventas)Inicio de Asociacion de Ventas a Estructura de Valoracion.\n");
	for ( pventa = lstVentas; pventa != NULL ; pventa = pventa->sgte )
	{
	
		fprintf(pfLog, "[vAsigna_Ventas] Gral:[%ld] TR:[%d] TC[%s] Comis:[%d] TPlan:[%s] CCte:[%s] Ofic:[%s]\n",
		pventa->lNumGeneral, pventa->iCodTipoRed, pventa->szCodTipComis, pventa->lCodComisionista, pventa->szTipPlan, pventa->szCodCategCliente, pventa->szCodOficina );
		/* Determinar a que tip_comis y comisionista corresponde la venta... */
	    puni = NULL;
	    puni = stBuscaTipComis(lstUniverso, pventa);
	    if (puni == NULL)
	            continue;
	    		
        /* Recorre estructura de conceptos, para la venta en asignación */
        for (pcon = puni->sgte_concepto; pcon != NULL; pcon = pcon->sgte)
        {
            if (strcmp(pcon->szCodTecnologia, NOTECNOLOGIA) == 0 || 
			    strcmp(pcon->szCodTecnologia, pventa->szCodTecnologia) == 0)
			{
            	/* Evalua la vigencia del concepto... */
            	if (bValidaFechaEvento (pcon->szFecDesde, pcon->szFecHasta, pventa->szFecVenta))
            	{
	            	/* nuevo nodo de la venta, que será asociado a cada concepto */
	            	paux = stCreaNodoVenta(pventa);
	
		            /* Determina la actuacion de comisiones que le corresponde a la venta... */
	            	pact = NULL;
	            	pact = stBuscaActuacion(pcon->sgte_actuacion, pventa);
	            
	            	/* ************************ */
	            	/* Evalua Comision Diferida */
	            	/* ************************ */
	            	if (strcmp(pcon->cTipCalculo ,"D")!=0)
	            	{
	            		if (!(bExisteDiferenciada(lstActDiferenciada, pact->lNumActuacion,pventa->lCodVendedor)))
	            		{
	            			paux->sgte = pact->sgte_venta;
	            			pact->sgte_venta = paux;
	            			pact->lCanVentas++;
	            			pcon->lCanVentas++;
		            		puni->lCan_Ventas++;
		            		stStatusProc.ivalorizados++;
						}
						else
						{
	           				fprintf(pfLog , "\t(vAsigna_Ventas) Evento:[%ld] Excluido de Concepto:[%d]. Actuacion con Diferenciación de Comisiones.\n", pventa->lNumGeneral, pcon->iCodConcepto);
    	       				fprintf(stderr, "\t(vAsigna_Ventas) Evento:[%ld] Excluido de Concepto:[%d]. Actuacion con Diferenciación de Comisiones.\n", pventa->lNumGeneral, pcon->iCodConcepto);
						}
					}
					else
					{
	            		paux->sgte = pact->sgte_venta;
    	        		pact->sgte_venta = paux;
        	    		pact->lCanVentas++;
            			pcon->lCanVentas++;
	            		puni->lCan_Ventas++;
	            		stStatusProc.ivalorizados++;
	            	}
           		}
           		else
           		{
           			fprintf(pfLog , "\t(vAsigna_Ventas) Evento:[%ld] Excluido de Concepto:[%d]. Fuera de Vigencia Plan/Tipo de Red.\n", pventa->lNumGeneral, pcon->iCodConcepto);
           			fprintf(stderr, "\t(vAsigna_Ventas) Evento:[%ld] Excluido de Concepto:[%d]. Fuera de Vigencia Plan/Tipo de Red.\n", pventa->lNumGeneral, pcon->iCodConcepto);
           		}
			}
    	}
	} 
}
/*****************************************************************************/
/* Bajada a Lista de tabla de matrizcomisiones y su detalle.                 */
/*****************************************************************************/
Ldetmatriz * stBajaDetMatrizCom(long plNumMatriz)
{
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    Ldetmatriz      * paux;
    Ldetmatriz      * qaux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		long	lhNumMatriz;
		long    lhNumDesde       [MAXFETCH];
        long    lhNumHasta       [MAXFETCH];
        double  dhImpComision    [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 

    
	lhNumMatriz = plNumMatriz;
    lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	
	/* EXEC SQL DECLARE CUR_DetMatrizCom CURSOR for SELECT  
			NUM_DESDE,
            NUM_HASTA,
            IMP_COMISION
		FROM    CMD_DETMATRIZCOM
        WHERE   NUM_FILA > 0
        AND     NUM_MATRIZ = :lhNumMatriz
        ORDER BY NUM_DESDE DESC; */ 

		
	/* EXEC SQL OPEN CUR_DetMatrizCom; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0003;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )107;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMatriz;
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
		/* EXEC SQL fetch CUR_DetMatrizCom
        	INTO    :lhNumDesde,
                    :lhNumHasta,
                    :dhImpComision; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )500;
  sqlstm.offset = (unsigned int  )126;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhNumDesde;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhNumHasta;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)dhImpComision;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )sizeof(double);
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
            paux = (Ldetmatriz *) malloc (sizeof(Ldetmatriz));
            paux->lNum_Desde    = lhNumDesde[i]; 
            paux->lNum_Hasta    = lhNumHasta[i]; 
            paux->dImp_Comision = dhImpComision[i]; 
            
            paux->sgte 			= qaux;
            qaux 				= paux;
        }
	}
	/* EXEC SQL CLOSE CUR_DetMatrizCom; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )153;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	return qaux;
}
/*****************************************************************************/
/* Bajada a Lista de tabla de matrizcomisiones y su detalle.                 */
/*****************************************************************************/
Lmatriz *  stCargaMatrizCom()
{
	Lmatriz         * paux;
	Lmatriz			* qaux;

    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lMaxFetch;
	    long    lhCodPeriodo;
	    
	    long    lhNum_Matriz     [MAXFETCH];
	    long    lhNum_Actuacion  [MAXFETCH];
	    long    lhCodPeriodoIni  [MAXFETCH];
	    long    lhCodPeriodoFin  [MAXFETCH];
	/* EXEC SQL END DECLARE SECTION; */ 

	paux = NULL;
	qaux = NULL;
        
	lhCodPeriodo = stCiclo.lCodCiclComis;
        
    /* EXEC SQL DECLARE CUR_MatrizCom CURSOR FOR SELECT  
			NUM_MATRIZ,
            NUM_ACTUACION,
            COD_PERIODO_INI,
            COD_PERIODO_FIN
		FROM    CMD_MATRIZCOM
        WHERE   NUM_MATRIZ 		> 0
        AND     :lhCodPeriodo BETWEEN COD_PERIODO_INI 
        						  AND COD_PERIODO_FIN
        ORDER BY NUM_ACTUACION DESC; */ 


    /* EXEC SQL OPEN CUR_MatrizCom; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )168;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
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


    lMaxFetch = MAXFETCH;

    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL FOR :lMaxFetch FETCH CUR_MatrizCom
        	INTO    :lhNum_Matriz,
            		:lhNum_Actuacion,
                    :lhCodPeriodoIni,
                    :lhCodPeriodoFin; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )187;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhNum_Matriz;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhNum_Actuacion;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhCodPeriodoIni;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhCodPeriodoFin;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
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
            paux = (Lmatriz *) malloc (sizeof(Lmatriz));
            paux->lNum_Actuacion   	= lhNum_Actuacion[i];
            paux->lCod_Periodo_Ini 	= lhCodPeriodoIni[i];
            paux->lCod_Periodo_Fin 	= lhCodPeriodoFin[i];
            paux->sgte_detmatriz  	= stBajaDetMatrizCom(lhNum_Matriz[i]);

            paux->sgte 				= qaux;
            qaux 					= paux;

		}
	}
	/* EXEC SQL CLOSE CUR_MatrizCom; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )218;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	return qaux;
}
/*****************************************************************************/
/* Bajada a Lista de tabla de detalle de metas.                              */
/*****************************************************************************/
Ldetmetas * stBajaDetMetas(long plNumMeta)
{
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    Ldetmetas       * paux;
    Ldetmetas       * qaux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		long	lhNumMeta;
		long    dhValMetaParcial [MAXFETCH];
        long    lhCodPeriodo     [MAXFETCH];    
	/* EXEC SQL END DECLARE SECTION; */ 

    
	lhNumMeta = plNumMeta;
    lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	
	/* EXEC SQL DECLARE CUR_DetMetas CURSOR for SELECT  
			VAL_METAPARCIAL,
	        COD_PERIODO
        FROM    CMD_DETMETAS
		WHERE   NUM_METAPARCIAL > 0
        AND     NUM_META = :lhNumMeta
        ORDER BY COD_PERIODO DESC; */ 
	
        	
	/* EXEC SQL OPEN CUR_DetMetas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0005;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )233;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMeta;
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
		/* EXEC SQL fetch CUR_DetMetas
        	INTO    :dhValMetaParcial,
                    :lhCodPeriodo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )500;
  sqlstm.offset = (unsigned int  )252;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)dhValMetaParcial;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhCodPeriodo;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
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
            paux = (Ldetmetas *) malloc (sizeof(Ldetmetas));
            paux->dVal_MetaParcial  = dhValMetaParcial[i]; 
            paux->lCod_Periodo      = lhCodPeriodo[i]; 
            paux->sgte              = qaux;
            qaux      				= paux;            
        }
	}
	/* EXEC SQL CLOSE CUR_DetMetas; */ 

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


	return qaux;
}
/*****************************************************************************/
/* Carga estructura de metas para el proceso de comisiones.                  */
/*****************************************************************************/
Lmetas * stCargaMetas()
{
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    Lmetas       	* paux;
    Lmetas       	* qaux;
    stConceptosProc	* raux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		long	lhCodPeriodo;
        long    lhNumMeta        [MAXFETCH];
        long    lhNumActuacion   [MAXFETCH];
        long    lhCodComisionista[MAXFETCH];
        char	szhNomVendedor	 [MAXFETCH][41];
        double  dhValMeta        [MAXFETCH];
        char    szhIndMeta       [MAXFETCH][2];
        long    lhCodPeriodoIni  [MAXFETCH];
        long    lhCodPeriodoFin  [MAXFETCH];
		char	szhCodTipComis[3];
		int		ihCodTipoRed;
	/* EXEC SQL END DECLARE SECTION; */ 

    
   	lMaxFetch = MAXFETCH;
	paux = NULL;
	qaux = NULL;
	
	lhCodPeriodo = stCiclo.lCodCiclComis;

	for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
	{
   		lMaxFetch 		= MAXFETCH;
		iLastRows    	= 0;       
		iFetchedRows 	= MAXFETCH;
		iRetrievRows 	= MAXFETCH;
		strcpy(szhCodTipComis, raux->szCodTipComis);
		ihCodTipoRed         = raux->iCodTipoRed;
	
		/* EXEC SQL DECLARE CUR_Metas CURSOR FOR
    		SELECT  DISTINCT
					A.NUM_META,
                	A.NUM_ACTUACION,
                	A.COD_COMISIONISTA,
                	B.NOM_VENDEDOR,
                	A.VAL_META,
                	A.IND_TIPMETA,
                	A.COD_PERIODO_INI,
                	A.COD_PERIODO_FIN 
			FROM    CMD_METAS     A,
					VE_VENDEDORES B, 
			    	VE_REDVENTAS_TD  C
        	WHERE   A.NUM_META > 0
        	AND     :lhCodPeriodo BETWEEN A.COD_PERIODO_INI AND A.COD_PERIODO_FIN
        	AND     A.COD_COMISIONISTA = B.COD_VENDEDOR
			AND     B.COD_VENDEDOR     = C.COD_VENDEDOR
			AND     C.COD_TIPORED      = :ihCodTipoRed
			AND     B.COD_TIPCOMIS     = :szhCodTipComis
        	ORDER BY NUM_ACTUACION DESC; */ 


    	/* EXEC SQL OPEN CUR_Metas; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0006;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )290;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[2] = (unsigned long )3;
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
			/* EXEC SQL FOR :lMaxFetch FETCH CUR_Metas
        		INTO	:lhNumMeta,
            	        :lhNumActuacion,
                	    :lhCodComisionista,  
                    	:szhNomVendedor,
	                    :dhValMeta,
    	                :szhIndMeta,
        	            :lhCodPeriodoIni,
            	        :lhCodPeriodoFin; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )lMaxFetch;
   sqlstm.offset = (unsigned int  )317;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)lhNumMeta;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )sizeof(long);
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqharc[0] = (unsigned long  *)0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)lhNumActuacion;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )sizeof(long);
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqharc[1] = (unsigned long  *)0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)lhCodComisionista;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )sizeof(long);
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqharc[2] = (unsigned long  *)0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNomVendedor;
   sqlstm.sqhstl[3] = (unsigned long )41;
   sqlstm.sqhsts[3] = (         int  )41;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqharc[3] = (unsigned long  *)0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)dhValMeta;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[4] = (         int  )sizeof(double);
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqharc[4] = (unsigned long  *)0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhIndMeta;
   sqlstm.sqhstl[5] = (unsigned long )2;
   sqlstm.sqhsts[5] = (         int  )2;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqharc[5] = (unsigned long  *)0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)lhCodPeriodoIni;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )sizeof(long);
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqharc[6] = (unsigned long  *)0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)lhCodPeriodoFin;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )sizeof(long);
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
        	iLastRows    = sqlca.sqlerrd[2];
                        
	        for (i=0; i < iRetrievRows; i++)
			{
	        	paux = (Lmetas *) malloc (sizeof(Lmetas));
    	        paux->lNum_Actuacion    	= lhNumActuacion[i];
        	    paux->lCod_Comisionista 	= lhCodComisionista[i];
            	paux->dVal_Meta         	= dhValMeta[i];
            	strcpy(paux->szInd_TipMeta	, szfnTrim(szhIndMeta[i]));
	            paux->lCod_Periodo_Ini  	= lhCodPeriodoIni[i];
    	        paux->lCod_Periodo_Fin  	= lhCodPeriodoFin[i];
        	    strcpy(paux->szNomVendedor	, szfnTrim(szhNomVendedor[i]));
	
    	        if ( !strcmp(szhIndMeta[i],"A") )
	            	paux->sgte_detmeta      = stBajaDetMetas(lhNumMeta[i]);
    	        else
        	    	paux->sgte_detmeta      = NULL;
            	
            	paux->sgte              	= qaux;
            	qaux                  		= paux;
			}
    	}
		/* EXEC SQL CLOSE CUR_Metas; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )364;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError();
}


	}
	return qaux;
}
/*****************************************************************************/
/* Muestra detalle de metas, para una determinada actuacion.                 */
/*****************************************************************************/
void vMuestraMetas(long plNumActuacion, Lmetas * paux)
{
	Ldetmetas * qaux;
	if (paux!=NULL)
	{
		if (paux->lNum_Actuacion == plNumActuacion)
		{
			if  (strcmp(paux->szInd_TipMeta,"M")!=0)
			{
				fprintf(stderr,"\nDesglose de Metas Parciales:\n");
				fprintf(pfLog ,"\nDesglose de Metas Parciales:\n");
				for (qaux = paux->sgte_detmeta; qaux != NULL; qaux = qaux->sgte)
                {
                	fprintf(pfLog ,"\t\tPeriodo:[%d] -- Metaparcial:[%d]\n", qaux->lCod_Periodo, qaux->dVal_MetaParcial);
                	fprintf(stderr,"\t\tPeriodo:[%d] -- Metaparcial:[%d]\n", qaux->lCod_Periodo, qaux->dVal_MetaParcial);
				}
			}
			fflush(pfLog);
		}	
		vMuestraMetas(plNumActuacion, paux->sgte);
	}
}
/*****************************************************************************/
/* Muestra Matriz de Comisiones para una actuación en Particular.            */
/*****************************************************************************/
void vMuestraMatriz(int piNumActuacion, Lmatriz * paux)
{
    Ldetmatriz   * qaux;
	if (paux!=NULL)
		if (paux->lNum_Actuacion == piNumActuacion)
		{	
			fprintf(pfLog, "\n[vMuestra_Matriz]Detalle de Matriz de Comsiones Para Actuacion:[%ld]\n", piNumActuacion);
			fprintf(pfLog,"[vMuestra_Matriz]Vigencia desde Periodo:[%d] hasta Periodo:[%d]\n",paux->lCod_Periodo_Ini, paux->lCod_Periodo_Fin);
			fprintf(stderr, "\n[vMuestra_Matriz]Detalle de Matriz de Comsiones Para Actuacion:[%ld]\n", piNumActuacion);
			fprintf(stderr,"[vMuestra_Matriz]Vigencia desde Periodo:[%d] hasta Periodo:[%d]\n",paux->lCod_Periodo_Ini, paux->lCod_Periodo_Fin);
			for (qaux = paux->sgte_detmatriz; qaux != NULL; qaux = qaux->sgte)
				fprintf(pfLog,"\tDesde:[%d] -- Hasta:[%d] -- Comision:[%-6.2f]\n",qaux->lNum_Desde, qaux->lNum_Hasta, qaux->dImp_Comision);
			fflush(pfLog);
    	}
    	else
    		vMuestraMatriz(piNumActuacion, paux->sgte);
}
/*****************************************************************************/
/* Muestra las actuaciones que poseen valoración diferenciada, en función de */
/* la propiedad de la oficina física en la que operan.                       */
/*****************************************************************************/
void vMuestraDiferenciada(long plActuacion, char * cTipCalculo)
{
	stActDiferenciada * paux;	
	for (paux = lstActDiferenciada; paux!= NULL; paux = paux->sgte)
	{
		if (paux->lNumActuacion == plActuacion)
		{
			if (strcmp(cTipCalculo , "D")==0)
				fprintf(pfLog ,"Actuacion:[%d] Vendedor:[%ld] Se diferencia la Comision en $[%6.2f]\n",paux->lNumActuacion, paux->lCodVendedor, paux->dImpComision);
			else
				fprintf(pfLog ,"Actuacion:[%d] Vendedor:[%ld] Se considera la Venta [%1f][0:NO/1:SI]\n",paux->lNumActuacion, paux->lCodVendedor, paux->dImpComision);
		}
	}
}
/*****************************************************************************/
/* Despliegue de la estructura de Valoración en pantalla.                    */
/*****************************************************************************/
void vMuestraEstructura()
{
	stUniverso	* paux;
	stConcepto  * qaux;
	stActuacion * raux;
	fprintf(pfLog , "%s\n", szRaya); 
	fprintf(stderr, "%s\n", szRaya); 
	for (paux = lstUniverso;paux != NULL; paux = paux->sgte)
	{
		fprintf(pfLog ,"\nTipo de Red:[%d] Tip.Comis:[%s] Comisionista:[%ld][%s]\n",paux->iCodTipoRed, paux->szCod_TipComis, paux->lCod_Comisionista, paux->szNomVendedor);
		fprintf(stderr,"\nTipo de Red:[%d] Tip.Comis:[%s] Comisionista:[%ld][%s]\n",paux->iCodTipoRed, paux->szCod_TipComis, paux->lCod_Comisionista, paux->szNomVendedor);
		for (qaux = paux->sgte_concepto;qaux != NULL; qaux = qaux->sgte)
		{
			fprintf(pfLog ,"\tPlanComis:[%s] Concepto:[%d] Tip.Calculo:[%s] Tecnologia:[%s] Desde:[%s] Hasta:[%s]\n",qaux->szCodPlanComis, qaux->iCodConcepto, qaux->cTipCalculo, qaux->szCodTecnologia, qaux->szFecDesde, qaux->szFecHasta);
			fprintf(stderr,"\tPlanComis:[%s] Concepto:[%d] Tip.Calculo:[%s] Tecnologia:[%s] Desde:[%s] Hasta:[%s]\n",qaux->szCodPlanComis, qaux->iCodConcepto, qaux->cTipCalculo, qaux->szCodTecnologia, qaux->szFecDesde, qaux->szFecHasta);
			for (raux = qaux->sgte_actuacion;raux != NULL; raux = raux->sgte)
			{
				fprintf(pfLog ,"\t\tActuacion:[%d] Cat.Plan:[%s] Cat.Cliente:[%s] Oficina:[%s]\n", raux->lNumActuacion, raux->szTipPlan, raux->szCodCategCliente,raux->szCodOficina); 
				fprintf(pfLog ,"\t\t ---->Escalonado:[%s] Desde:[%s] Hasta:[%s] Comision[%6.2f] ==>Ventas:[%d]\n", raux->szIndEscalonado, raux->szFecInicio, raux->szFecTermino, raux->dImpComision, raux->lCanVentas);
				fprintf(stderr,"\t\tActuacion:[%d] Cat.Plan:[%s] Cat.Cliente:[%s] Oficina:[%s]\n", raux->lNumActuacion, raux->szTipPlan, raux->szCodCategCliente,raux->szCodOficina); 
				fprintf(stderr,"\t\t ---->Escalonado:[%s] Desde:[%s] Hasta:[%s] Comision[%6.2f] ==>Ventas:[%d]\n", raux->szIndEscalonado, raux->szFecInicio, raux->szFecTermino, raux->dImpComision, raux->lCanVentas);

/*				if (strcmp(qaux->cTipCalculo, TIPCALMETA)==0)               */
/*				{                                                           */
/*					vMuestraMetas(raux->lNumActuacion, lstMetas);           */
/*					vMuestraMatriz(raux->lNumActuacion, lstMatrizCom);      */
/*				}                                                           */
/*				if (strcmp(qaux->cTipCalculo, TIPCALVOLUMEN)==0)            */
/*				{                                                           */
/*					vMuestraMatriz(raux->lNumActuacion, lstMatrizCom);      */
/*				}                                                           */
/*				vMuestraDiferenciada(raux->lNumActuacion,qaux->cTipCalculo);*/

			}
		}
	}
	fprintf(pfLog , "%s\n", szRaya); 
	fprintf(stderr, "%s\n", szRaya); 
}
void vMuestraVtasAsignadas()
{
	stUniverso	* paux;
	stConcepto  * qaux;
	stActuacion * raux;
	fprintf(pfLog , "%s\n", szRaya); 
	fprintf(stderr, "%s\n", szRaya); 
	for (paux = lstUniverso;paux != NULL; paux = paux->sgte)
	{
		for (qaux = paux->sgte_concepto;qaux != NULL; qaux = qaux->sgte)
		{
			for (raux = qaux->sgte_actuacion;raux != NULL; raux = raux->sgte)
			{
				if (raux->lCanVentas > 0)
				{
					fprintf(pfLog ,"\nTRed:[%d] TComis:[%s] Comis:[%ld] Concepto:[%d] Actuacion:[%d] Ventas:[%d]\n",
					paux->iCodTipoRed, paux->szCod_TipComis, paux->lCod_Comisionista, qaux->iCodConcepto, raux->lNumActuacion,raux->lCanVentas );
					fprintf(stderr ,"\nTRed:[%d] TComis:[%s] Comis:[%ld] Concepto:[%d] Actuacion:[%d] Ventas:[%d]\n",
					paux->iCodTipoRed, paux->szCod_TipComis, paux->lCod_Comisionista, qaux->iCodConcepto, raux->lNumActuacion,raux->lCanVentas );
				}
			}
		}
	}
	fprintf(pfLog , "%s\n", szRaya); 
	fprintf(stderr, "%s\n", szRaya); 
}
/*****************************************************************************/
/* Busca en la lista de Actuaciones con Valoración Diferenciada, la Actuacion*/
/* y el Vendedor pasados por parámetro. Retorma True si lo encuentra y False */
/* si no.                                                                    */
/*****************************************************************************/
double dImporteDiferenciada(stActDiferenciada * paux, long lNumActuacion,long lCodVendedor)
{
	if (paux == NULL)
		return -1.00;
	
	if ((paux->lNumActuacion == lNumActuacion)&&(paux->lCodVendedor == lCodVendedor))
		return paux->dImpComision;
	else
		return (dImporteDiferenciada(paux->sgte, lNumActuacion, lCodVendedor));
}
/*****************************************************************************/
/* Busca en la lista de Actuaciones con Valoración Diferenciada, la Actuacion*/
/* y el Vendedor pasados por parámetro. Retorma True si lo encuentra y False */
/* si no.                                                                    */
/*****************************************************************************/
int bExisteDiferenciada(stActDiferenciada * paux, long lNumActuacion,long lCodVendedor)
{
	if (paux == NULL)
		return FALSE;
	
	if ((paux->lNumActuacion == lNumActuacion)&&(paux->lCodVendedor == lCodVendedor)&&(paux->dImpComision == 0))
		return TRUE;
	else
		return (bExisteDiferenciada(paux->sgte, lNumActuacion, lCodVendedor));
}
/*****************************************************************************/
/* Busca un tipo de comisionista en la lista principal de valoracion.        */
/* Si lo encuantra, retorna true.                                            */
/*****************************************************************************/
int bExisteTipComis(char * pszCodTipComis, stUniverso * paux)
{
	if (paux == NULL)
		return FALSE;
	if (strcmp(paux->szCod_TipComis , pszCodTipComis)==0)
		return TRUE;
	else
		return (bExisteTipComis(pszCodTipComis, paux->sgte));
}
/*****************************************************************************/
/* Carga estructura principal de valoración. (lstUniverso).                  */
/*****************************************************************************/
stUniverso * stCargaUniverso()
{
    int             i;
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
    stUniverso		* paux;
    stUniverso		* qaux;
    stConceptosProc	* raux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		long	lhCodComisionsta[MAXFETCH];
		char	szhNomVendedor[MAXFETCH][41];
		char	szhCodTipComis[3];
		int		ihCodTipoRed;
	/* EXEC SQL END DECLARE SECTION; */ 

        
	paux = NULL;
	qaux = NULL;
	
	
	for(raux=lstConceptos; raux != NULL; raux = raux->sgte)
	{
		strcpy(szhCodTipComis, raux->szCodTipComis);
		ihCodTipoRed         = raux->iCodTipoRed;
		
		lMaxFetch = MAXFETCH;
	    iLastRows    = 0;       
	    iFetchedRows = MAXFETCH;
	    iRetrievRows = MAXFETCH;

		if (!bExisteTipComis(szhCodTipComis,qaux))
		{
			/* EXEC SQL DECLARE CUR_VENDEDORES CURSOR FOR
	    		SELECT 	DISTINCT 
						A.COD_VENDEDOR,
	    				A.NOM_VENDEDOR
	    		FROM 	VE_VENDEDORES   A,
	    				VE_ESTADOS_TD   B, 
						VE_REDVENTAS_TD C
	    		WHERE 	A.COD_TIPCOMIS = :szhCodTipComis
				AND     A.COD_ESTADO   = B.COD_ESTADO
				AND     C.COD_TIPORED  = :ihCodTipoRed
				AND 	C.COD_VENDEDOR = A.COD_VENDEDOR; */ 


		    /* EXEC SQL OPEN CUR_VENDEDORES; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 9;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0007;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )379;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipComis;
      sqlstm.sqhstl[0] = (unsigned long )3;
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
				/* EXEC SQL FOR :lMaxFetch FETCH CUR_VENDEDORES
		        	INTO	:lhCodComisionsta, :szhNomVendedor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )lMaxFetch;
    sqlstm.offset = (unsigned int  )402;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)lhCodComisionsta;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNomVendedor;
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )41;
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
		        	paux = (stUniverso *) malloc (sizeof(stUniverso));
		        	
		        	paux->iCodTipoRed       	= ihCodTipoRed;
					strcpy(paux->szCod_TipComis	, raux->szCodTipComis);
					paux->lCod_Comisionista 	= lhCodComisionsta[i];
					strcpy(paux->szNomVendedor	, szfnTrim(szhNomVendedor[i]));
					paux->lCan_Ventas       	= 0;
					paux->sgte_concepto			= NULL;
					
					/* fprintf(pfLog, "\n[stCargaUniverso] TipoRed:[%d] Comisionista:[%d] [%s]\n", paux->iCodTipoRed , paux->lCod_Comisionista,paux->szNomVendedor); */
					paux->sgte					= qaux;
					qaux						= paux;
				}
			}
		/* EXEC SQL CLOSE CUR_VENDEDORES; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )425;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError();
}


		}		
	}
	return qaux;
}
/*****************************************************************************/
/* Asocia a cada nodo de estructura principal, la lista de conceptos de      */
/* comisiones que trae desde estructura stConceptosProc                      */
/*****************************************************************************/
void vAsignaConceptos()
{
	stUniverso		* paux;
	stConceptosProc	* qaux;
	stConcepto		* raux;
	
	for (qaux = lstConceptos; qaux!= NULL; qaux = qaux->sgte)
	{
		for (paux=lstUniverso; paux != NULL; paux = paux->sgte)
		{
			if (strcmp(qaux->szCodTipComis, paux->szCod_TipComis)==0)
			{
				raux = (stConcepto *) malloc (sizeof(stConcepto));
				
				strcpy(raux->szCodPlanComis     , qaux->szCodPlanComis);
				strcpy(raux->szFecDesde         , qaux->szFecDesde);
				strcpy(raux->szFecHasta         , qaux->szFecHasta);
				strcpy(raux->szCodTecnologia    , qaux->szCodTecnologia);
				raux->iCodConcepto       		= qaux->iCodConcepto;
				strcpy(raux->cTipCalculo        , qaux->cCodTipCalculo);
				raux->lCanVentas         		= 0;
				raux->iValLogro          		= 0;
				raux->dImpConcepto       		= 0.0;
				raux->dFecDesde					= qaux->dFecDesde;
				raux->dFecHasta					= qaux->dFecHasta;
				raux->sgte_actuacion            = stCreaActuacionBasura();
				raux->sgte						= paux->sgte_concepto;
				paux->sgte_concepto				= raux;
			}
		}
	}
}
/*****************************************************************************/
/* Rutina que ingresa las actuaciones dentro de la estructura general.       */
/*****************************************************************************/
stActDiferenciada * stCargaActDiferenciada()
{
    stActDiferenciada 	* paux;
    stActDiferenciada 	* qaux;
    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhNumActuacion       [MAXFETCH];
	    double  dhImpComision        [MAXFETCH];
	    long	lhCodVendedor		 [MAXFETCH];
	    long	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 


	paux = NULL;
	qaux = NULL;

	lMaxFetch = MAXFETCH;
    /* EXEC SQL DECLARE CUR_ActDiferenciada CURSOR FOR SELECT  
    		NUM_ACTUACION,
            COD_VENDEDOR,
            IMP_COMISION
        FROM    CM_VALDIFERENCIADA_TD
        ORDER BY NUM_ACTUACION,COD_VENDEDOR; */ 


	/* EXEC SQL OPEN CUR_ActDiferenciada; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )440;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL FOR :lMaxFetch FETCH   CUR_ActDiferenciada INTO
					:lhNumActuacion,
					:lhCodVendedor,
                    :dhImpComision; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )455;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhNumActuacion;
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
  sqlstm.sqhstv[2] = (unsigned char  *)dhImpComision;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )sizeof(double);
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
        	paux = (stActDiferenciada *) malloc (sizeof(stActDiferenciada));
                	
            paux->lNumActuacion 	= lhNumActuacion[i];
            paux->lCodVendedor		= lhCodVendedor[i];
            paux->dImpComision 		= dhImpComision[i];
            paux->sgte 				= qaux;
            qaux					= paux;
		}
	}
	/* EXEC SQL CLOSE CUR_ActDiferenciada; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )482;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	return qaux;
}

/*****************************************************************************/
/* Rutina que ingresa las actuaciones dentro de la estructura general.       */
/*****************************************************************************/
void vCargaActuaciones()
{
    stUniverso 		* puni;
    stConcepto 		* pcon;
    stActuacion 	* pact;

    int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhNumActuacion       [MAXFETCH];
	    char    szhTipPlan           [MAXFETCH][6];
	    char    szhCodCategCliente   [MAXFETCH][11];
	    char	szhCodOficina		 [MAXFETCH][3];
	    char    szhIndEscalonado     [MAXFETCH][2];
	    double  dhImpComision        [MAXFETCH];
	    char    szhFecInicio         [MAXFETCH][11];
	    char    szhFecTermino        [MAXFETCH][11];

	    char    dhFecInicio         [MAXFETCH][20];
	    char    dhFecTermino        [MAXFETCH][20];

	    long	lMaxFetch;
	    char    szhCodTipComis[3];
		int		ihCodTipoRed;
	    char	szhCodPlanComis[7];
	    short   ihCodConcepto;
	    char	szhFecDesdeAceptacion[11];
	    char	szhFecHastaAceptacion[11];
	/* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szhFecDesdeAceptacion, stCiclo.szFecDesdeAceptacion);
    strcpy (szhFecHastaAceptacion, stCiclo.szFecHastaAceptacion);

	for (puni = lstUniverso; puni != NULL; puni = puni->sgte)
    {
    	strcpy(szhCodTipComis	, puni->szCod_TipComis);
    	ihCodTipoRed 			= puni->iCodTipoRed;
    	
        for (pcon = puni->sgte_concepto; pcon != NULL; pcon = pcon->sgte)
        {
        	strcpy(szhCodPlanComis	, pcon->szCodPlanComis);
        	ihCodConcepto 			= pcon->iCodConcepto;
			iLastRows    = 0;        
			iFetchedRows = MAXFETCH; 
			iRetrievRows = MAXFETCH; 
			lMaxFetch = MAXFETCH;
			
            /* EXEC SQL DECLARE CUR_Actuaciones CURSOR FOR SELECT  
	        		NUM_ACTUACION,
	                TIP_PLAN,
	                COD_CATEGCLIENTE,
	                COD_OFICINA,
	                NVL(IND_ESCALONADO,'N'),
	                IMP_COMISION,
	                TO_CHAR(FEC_DESDE,'DD-MM-YYYY'),
	                TO_CHAR(FEC_HASTA,'DD-MM-YYYY'),
	                TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS'),
	                TO_CHAR(FEC_HASTA,'YYYYMMDDHH24MISS')
	            FROM    CM_VALCONTRATOS_TD
	            WHERE   NUM_ACTUACION 	> 0
	            AND		COD_TIPORED 	= :ihCodTipoRed
	            AND 	COD_PLANCOMIS 	= :szhCodPlanComis
	            AND 	COD_CONCEPTO  	= :ihCodConcepto
	            AND     ((FEC_DESDE BETWEEN TO_DATE(:szhFecDesdeAceptacion,'DD-MM-YYYY') AND TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY'))
	            OR      (FEC_HASTA BETWEEN TO_DATE(:szhFecDesdeAceptacion,'DD-MM-YYYY') AND TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY'))
	            OR      ((to_date(:szhFecDesdeAceptacion,'DD-MM-YYYY') BETWEEN FEC_DESDE AND FEC_HASTA)
	            OR      (TO_DATE(:szhFecHastaAceptacion,'DD-MM-YYYY')  BETWEEN FEC_DESDE AND FEC_HASTA)))
	            ORDER BY 2, 3, 4, 6 DESC; */ 


			/* EXEC SQL OPEN CUR_Actuaciones; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0009;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )497;
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
   sqlstm.sqhstl[1] = (unsigned long )7;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
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
   sqlstm.sqhstv[5] = (unsigned char  *)szhFecDesdeAceptacion;
   sqlstm.sqhstl[5] = (unsigned long )11;
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
   sqlstm.sqhstv[7] = (unsigned char  *)szhFecDesdeAceptacion;
   sqlstm.sqhstl[7] = (unsigned long )11;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhFecHastaAceptacion;
   sqlstm.sqhstl[8] = (unsigned long )11;
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
				/* EXEC SQL FOR :lMaxFetch FETCH   CUR_Actuaciones INTO
					:lhNumActuacion,
                    :szhTipPlan,
                    :szhCodCategCliente,
                    :szhCodOficina,
                    :szhIndEscalonado,
                    :dhImpComision,
                    :szhFecInicio,
                    :szhFecTermino,
                    :dhFecInicio,
                    :dhFecTermino; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )lMaxFetch;
    sqlstm.offset = (unsigned int  )548;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)lhNumActuacion;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhTipPlan;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCategCliente;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )11;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[3] = (unsigned long )3;
    sqlstm.sqhsts[3] = (         int  )3;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhIndEscalonado;
    sqlstm.sqhstl[4] = (unsigned long )2;
    sqlstm.sqhsts[4] = (         int  )2;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)dhImpComision;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )sizeof(double);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )11;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecTermino;
    sqlstm.sqhstl[7] = (unsigned long )11;
    sqlstm.sqhsts[7] = (         int  )11;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)dhFecInicio;
    sqlstm.sqhstl[8] = (unsigned long )20;
    sqlstm.sqhsts[8] = (         int  )20;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)dhFecTermino;
    sqlstm.sqhstl[9] = (unsigned long )20;
    sqlstm.sqhsts[9] = (         int  )20;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
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
                	pact = (stActuacion *) malloc (sizeof(stActuacion));
                	
                    pact->lNumActuacion 			= lhNumActuacion[i];
                    pact->sgte_venta    			= NULL;
                    strcpy(pact->szTipPlan			, szfnTrim(szhTipPlan[i]));
                    strcpy(pact->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
                    strcpy(pact->szCodOficina		, szfnTrim(szhCodOficina[i]));
                    strcpy(pact->szIndEscalonado	, szfnTrim(szhIndEscalonado[i]));
                    pact->dImpComision 				= dhImpComision[i];
                    strcpy(pact->szFecInicio   		, szfnTrim(szhFecInicio[i] ));
                    strcpy(pact->szFecTermino  		, szfnTrim(szhFecTermino[i]));
                    pact->dFecInicio				= atof(szfnTrim(dhFecInicio[i]));
					pact->dFecTermino				= atof(szfnTrim(dhFecTermino[i]));
                    pact->lCanVentas   				= 0;
                    pact->sgte 						= pcon->sgte_actuacion;
                    pcon->sgte_actuacion 			= pact;
				}
			}
			/* EXEC SQL CLOSE CUR_Actuaciones; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 10;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )603;
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
/*****************************************************************************/
/* Rutina que carga ventas en estructura para posterior insercion en         */
/* estructura principal                                                      */
/*****************************************************************************/
Ventas *  vCargaVentas()
{
	int         i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
	Ventas      * paux;
	Ventas      * qaux;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 


        long    lMaxFetch;
        char    szhIdCiclComis[11];
        char    szhFecAceptacion        [MAXFETCH][20];
        char    szhFecVenta             [MAXFETCH][11];
        char  	dhFechaAceptacion       [MAXFETCH][15];
        char  	dhFechaVenta            [MAXFETCH][15];
        long    lhNumGeneral            [MAXFETCH];
        long    lhCodComisionista       [MAXFETCH];
        char    szhCodOficina           [MAXFETCH][3]; 
        char    szhTipPlan              [MAXFETCH][6]; 
        char    szhCodTipComis          [MAXFETCH][3]; 
        char    szhCodCategCliente      [MAXFETCH][11];
		char	szhCodTecnologia		[MAXFETCH][8];
		int		ihCodTipoRed			[MAXFETCH];
		char	szAuxFecha				[15];
        char    szhCodTipVendedor       [MAXFETCH][3]; 
        long    lhCodVendedor       	[MAXFETCH];

    /* EXEC SQL END DECLARE SECTION; */ 

	strcpy(szhIdCiclComis, szfnTrim(stArgs.szIdPeriodo));

	paux = NULL;
	qaux = NULL;
	
	stStatusProc.iventas = 0;
    /* EXEC SQL DECLARE CUR_VentasPeriodo CURSOR FOR SELECT  
			TO_CHAR(R.FEC_ACEPTACION,'DD-MM-YYYY'),
            R.NUM_GENERAL,
            TO_CHAR(R.FEC_ACEPTACION, 'YYYYMMDDHH24MISS'),
            TO_CHAR(R.FEC_VENTA, 'YYYYMMDDHH24MISS'),
            F.TIP_PLAN,
            R.COD_TIPCOMIS,
            R.COD_CATEGCLIENTE,
            R.COD_COMISIONISTA,
            R.COD_OFICINA,
            TO_CHAR(R.FEC_VENTA, 'DD-MM-YYYY'),
            R.COD_TECNOLOGIA,
            R.COD_TIPORED,
            R.COD_TIPVENDEDOR,
            R.COD_AGENCIA
        FROM    CMT_HABIL_CELULAR R, 
        		CMD_PLANESTARIF F
        WHERE   R.NUM_GENERAL > 0
        AND     R.ID_PERIODO    = :szhIdCiclComis
        AND     R.COD_PLANTARIF = F.COD_PLANTARIF; */ 


	/* EXEC SQL OPEN CUR_VentasPeriodo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 10;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0010;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )618;
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
        /* EXEC SQL FOR :lMaxFetch FETCH   CUR_VentasPeriodo
        	INTO	:szhFecAceptacion,
                    :lhNumGeneral,
                    :dhFechaAceptacion,
                    :dhFechaVenta,
                    :szhTipPlan,
                    :szhCodTipComis,
                    :szhCodCategCliente,
                    :lhCodComisionista,
                    :szhCodOficina,
                    :szhFecVenta,
                    :szhCodTecnologia,
                    :ihCodTipoRed, 
                    :szhCodTipVendedor, 
                    :lhCodVendedor; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )637;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecAceptacion;
        sqlstm.sqhstl[0] = (unsigned long )20;
        sqlstm.sqhsts[0] = (         int  )20;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lhNumGeneral;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)dhFechaAceptacion;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )15;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)dhFechaVenta;
        sqlstm.sqhstl[3] = (unsigned long )15;
        sqlstm.sqhsts[3] = (         int  )15;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhTipPlan;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )6;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[5] = (unsigned long )3;
        sqlstm.sqhsts[5] = (         int  )3;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodCategCliente;
        sqlstm.sqhstl[6] = (unsigned long )11;
        sqlstm.sqhsts[6] = (         int  )11;
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
        sqlstm.sqhstv[8] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[8] = (unsigned long )3;
        sqlstm.sqhsts[8] = (         int  )3;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhFecVenta;
        sqlstm.sqhstl[9] = (unsigned long )11;
        sqlstm.sqhsts[9] = (         int  )11;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szhCodTecnologia;
        sqlstm.sqhstl[10] = (unsigned long )8;
        sqlstm.sqhsts[10] = (         int  )8;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)ihCodTipoRed;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[11] = (         int  )sizeof(int);
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhCodTipVendedor;
        sqlstm.sqhstl[12] = (unsigned long )3;
        sqlstm.sqhsts[12] = (         int  )3;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)lhCodVendedor;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[13] = (         int  )sizeof(long);
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
			paux = (Ventas *) malloc (sizeof(Ventas));
                    
            strcpy(paux->szFecAceptacion	, szfnTrim(szhFecAceptacion[i]));
            paux->lNumGeneral 				= lhNumGeneral[i];
            paux->dFechaAceptacion   		= atof(szfnTrim(dhFechaAceptacion[i]));
            paux->dFechaVenta   			= atof(szfnTrim(dhFechaVenta[i]));
            strcpy(paux->szTipPlan			, szfnTrim(szhTipPlan[i]));
            strcpy(paux->szCodTipComis		, szfnTrim(szhCodTipComis[i]));
            strcpy(paux->szCodCategCliente	, szfnTrim(szhCodCategCliente[i]));
            paux->lCodComisionista 			= lhCodComisionista[i];
            strcpy(paux->szCodOficina		, szfnTrim(szhCodOficina[i]));
            strcpy(paux->szFecVenta			, szfnTrim(szhFecVenta[i]));
            strcpy(paux->szCodTecnologia	, szfnTrim(szhCodTecnologia[i]));
            paux->iCodTipoRed				= ihCodTipoRed[i];
            strcpy(paux->szCodTipVendedor	, szfnTrim(szhCodTipVendedor[i]));
            paux->lCodVendedor 				= lhCodVendedor[i];
            
            paux->sgte 						= qaux;
            qaux  							= paux;
            stStatusProc.iventas++;
        }   
   }        
   fprintf(stderr,"\n\n[vCargaVentas]Total Abonados Cargados para valoración ciclo:[%s] -->[%ld]\n", szhIdCiclComis, stStatusProc.iventas);
   fprintf(pfLog ,"\n\n[vCargaVentas]Total Abonados Cargados para valoración ciclo:[%s] -->[%ld]\n", szhIdCiclComis, stStatusProc.iventas);
   /* EXEC SQL CLOSE CUR_VentasPeriodo; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )708;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
   if (sqlca.sqlcode < 0) vSqlError();
}

 
   return qaux;
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

/*****************************************************************************/
/* LIBERA ACTUACIONES CON VALORACION DIFERENCIADA.                           */
/*****************************************************************************/
void vLiberaDiferenciada(stActDiferenciada * paux)
{
	if (paux!= NULL)
	{
		vLiberaDiferenciada(paux->sgte);
		free(paux);
	}
}
/*****************************************************************************/
/* LIBERA DETALLE DE METAS.                                                  */
/*****************************************************************************/
void vLiberaDetMetas(Ldetmetas * paux)
{
	if (paux!= NULL)
	{
		vLiberaDetMetas(paux->sgte);
		free(paux);
	}
}
/*****************************************************************************/
/* LIBERA LISTA DE METAS DE VALORACION.                                      */
/*****************************************************************************/
void vLiberaMetas(Lmetas * paux)
{
	Lmetas *  raux;
	Lmetas *  qaux;
	
	if (paux!=NULL)
	{
		raux = paux;
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			vLiberaDetMetas(paux->sgte_detmeta);
			free(raux);
			raux = qaux;
			qaux = raux->sgte;
		}
		if (raux !=  NULL)
		{
			vLiberaDetMetas(paux->sgte_detmeta);
			free(raux);
		}
	}
}
/*****************************************************************************/
/* LIBERA ESTRUCTURA DE DETALLE DE MATRIZCOM.                                */
/*****************************************************************************/
void vLiberaDetMatrizCom(Ldetmatriz * paux)
{
	Ldetmatriz * qaux;

	if (paux!= NULL)
	{
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			free(paux);
			paux = qaux;
			qaux = paux->sgte;
		}
		if (paux!=NULL)
		{
			free(paux);
		}
	}	
}
/*****************************************************************************/
/* LIBERA LISTA DE MATRIZCOM.                                                */
/*****************************************************************************/
void vLiberaMatrizcom(Lmatriz * paux)
{
	Lmatriz *  qaux;
	
	if (paux!=NULL)
	{
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			fprintf(stderr, "[vLiberaMatrizcom] Num_Actuacion [%d] Siguente:[%d]\n", paux->lNum_Actuacion, qaux->lNum_Actuacion);
			vLiberaDetMatrizCom(paux->sgte_detmatriz);
			free(paux);
			paux = qaux;
			qaux = paux->sgte;
		}
		if (paux !=  NULL)
		{
			fprintf(stderr, "[vLiberaMatrizcom] Num_Actuacion [%d] \n", paux->lNum_Actuacion );
			vLiberaDetMatrizCom(paux->sgte_detmatriz);
			free(paux);
		}
	}
}
/*****************************************************************************/
/* LIBERA LISTA DE VENTAS POR VALORAR.                                       */
/*****************************************************************************/
void vLiberaVentas(Ventas * paux)
{
	Ventas *  raux;
	Ventas *  qaux;
	
	if (paux!=NULL)
	{
		raux = paux;
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			free(raux);
			raux = qaux;
			qaux = raux->sgte;
		}
		if (raux !=  NULL)
			free(raux);
	}
}
/*****************************************************************************/
/* LIBERA LISTA DE VENTAS VALORADAS DESDE ESTRUCTURA PRINCIPAL.              */
/*****************************************************************************/
void vLiberastVenta(stVenta * paux)
{
	stVenta *  raux;
	stVenta *  qaux;
	
	if (paux!=NULL)
	{
		raux = paux;
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			free(raux);
			raux = qaux;
			qaux = raux->sgte;
		}
		if (raux !=  NULL)
			free(raux);
	}
}
/*****************************************************************************/
/* LIBERA LISTA DE ACTUACIONES DE COMISION.                                  */
/*****************************************************************************/
void vLiberaActuacion(stActuacion * qaux)
{
	if (qaux!= NULL)
	{
		vLiberastVenta(qaux->sgte_venta);
		free(qaux);
	}
}
/*****************************************************************************/
/* LIVERA ESTRUCTURA DE CONCEPTOS DE COMISIONES.                             */
/*****************************************************************************/
void vLiberaConceptos(stConcepto * qaux)
{
	if (qaux!= NULL)
	{
		vLiberaActuacion(qaux->sgte_actuacion);
		free(qaux);
	}
}
/*****************************************************************************/
/* LIBERA MEMORIA DE ESTRUCTURA PRINCIPAL.                                   */
/*****************************************************************************/
void vLiberaUniverso(stUniverso * paux)
{
	stUniverso *  raux;
	stUniverso *  qaux;
	
	if (paux!=NULL)
	{
		raux = paux;
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			vLiberaConceptos(raux->sgte_concepto);
			free(raux);
			raux = qaux;
			qaux = raux->sgte;
		}
		if (raux !=  NULL)
		{
			vLiberaConceptos(raux->sgte_concepto);
			free(raux);
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
    long lSegundos,lSegIni, lSegFin;
    short ibiblio;

        /* EXEC SQL BEGIN DECLARE SECTION; */ 


        /* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
        lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
        memset(&stArgs      , 0, sizeof(rg_argumentos));
        memset(&stStatusProc, 0, sizeof(rg_estadistica));
        memset(&stCiclo, 0, sizeof(reg_ciclo));         /* Incorporado Por PGonzaleg 2-1-2003. Modificacion de Periodos. */     
        memset(&proceso     , 0, sizeof(proceso));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
        vManejaArgs(argc    , argv);
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
    strcpy(szUser, stArgs.szUser);
    strcpy(szPass, stArgs.szPass);
    if(fnOraConnect(szUser, szPass) == FALSE)
    {
        fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
        fprintf(stderr, "Usuario/Password Oracle no son validos. Se cancela.\n");
        exit(EXIT_205);
    }
    else
    {
        fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");
        fprintf(stderr, "Username: %s\n\n", szUser);
        /* EXEC SQL SET ROLE ALL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "set role ALL";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )723;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


    }
/*---------------------------------------------------------------------------*/
/* Inicia estructura de proceso y bloques.                                   */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,stArgs.szUser, stArgs.izSecuencia);
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
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )738;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/*    INICIA PROCESAMIENTO PRINCIPAL.                                        */
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
/* Carga Estructura de Cocneptos y Tipos de Red a Procesar...               */
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
/* Bajando estructura de Valoracion                                         */
/*--------------------------------------------------------------------------*/    
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Bajando universo de vendedores a comisionar...\n\n");  
    fprintf(stderr, "Bajando universo de vendedores a comisionar...\n\n");  
    lstUniverso = stCargaUniverso();
/*--------------------------------------------------------------------------*/
/* Bajando estructura de Valoracion                                         */
/*--------------------------------------------------------------------------*/    
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Asociando lista de conceptos de comision...\n\n");  
    fprintf(stderr, "Asociando lista de conceptos de comision...\n\n");  
    vAsignaConceptos();
/*--------------------------------------------------------------------------*/
/* Bajando Actuaciones de Comisiones                                        */
/*--------------------------------------------------------------------------*/    
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Bajando Actuaciones de Comisiones...\n\n");
    fprintf(stderr, "Bajando Actuaciones de Comisiones...\n\n");
    vCargaActuaciones();
/*--------------------------------------------------------------------------*/
/* Carga Matrices de comisiones                                             */
/*--------------------------------------------------------------------------*/
	vFechaHora();                                                                                   
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
	fprintf(pfLog, "Carga Matrices de comisiones ...\n\n");  
	fprintf(stderr, "Carga Matrices de comisiones...\n\n");  
	lstMatrizCom = stCargaMatrizCom();
/*--------------------------------------------------------------------------*/
/* Carga Metas                                                              */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Carga metas de comisiones...\n\n");
    fprintf(stderr, "Carga metas de comisiones...\n\n");
    lstMetas = stCargaMetas();
/*--------------------------------------------------------------------------*/
/* Carga Actuaciones con Valoración Diferenciada                            */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Carga Actuaciones con valoracion Diferenciada...\n\n");
    fprintf(stderr, "Carga Actuaciones con valoracion Diferenciada...\n\n");
    lstActDiferenciada = stCargaActDiferenciada();
/*--------------------------------------------------------------------------*/
/* Bajando universo de Ventas                                               */
/*--------------------------------------------------------------------------*/    
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Bajando universo de Ventas...\n\n");  
    fprintf(stderr, "Bajando universo de Ventas...\n\n");  
    lstVentas = vCargaVentas();
/*--------------------------------------------------------------------------*/
/* Asignando Ventas a estructura de valoración                              */
/*--------------------------------------------------------------------------*/    
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Asignando Ventas a estructura de valoración...\n\n");  
    fprintf(stderr, "Asignando Ventas a estructura de valoración...\n\n");  
    vAsigna_Ventas();
/*--------------------------------------------------------------------------*/
/* MUESTRA ESTRUCTURA GENERAL DE VALORACION. (COMPLETA).                    */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Visualiza Estructura General de Valoracion de Contratos...\n\n");
    fprintf(stderr, "Visualiza Estructura General de Valoracion de Contratos...\n\n");
/*	vMuestraVtasAsignadas();*/
	vMuestraEstructura(); 
/*--------------------------------------------------------------------------*/
/* Ejecuta Proceso de Valoración de Ventas                                  */
/*--------------------------------------------------------------------------*/    
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "Ejecuta Proceso de Valoración de Ventas...\n\n");  
    fprintf(stderr, "Ejecuta Proceso de Valoración de Ventas...\n\n");  
    vValorizando();
/*--------------------------------------------------------------------------*/
/* Insertando resultados en tabla de Valoizados y Logro de Metas            */
/*--------------------------------------------------------------------------*/    
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Insertando resultados en tabla de Valoizados y Logro de Metas...\n\n");
    fprintf(stderr, "Insertando resultados en tabla de Valoizados y Logro de Metas...\n\n");
    vInserta_Salida();
/*--------------------------------------------------------------------------*/
/* Libera Memoria utilizada.                                                */
/*--------------------------------------------------------------------------*/    
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera la memoria utilizada en el proceso.\n\n");
    fprintf(stderr, "Libera la memoria utilizada en el proceso.\n\n");
 
    fprintf(pfLog, "Libera lista de matrices de comisiones. [vLiberaMatrizcom]\n\n");
    fprintf(stderr, "Libera lista de matrices de comisiones. [vLiberaMatrizcom]\n\n");
    vLiberaMatrizcom(lstMatrizCom);    
    
    fprintf(pfLog, "Libera lista de conceptos estándar.\n\n");
    fprintf(stderr, "Libera lista de conceptos estándar.\n\n");
    vLiberaConceptosVal(lstConceptos);

    fprintf(pfLog, "Libera estructura principal de valoracion.\n\n");
    fprintf(stderr, "Libera estructura principal de valoracion.\n\n");
    vLiberaUniverso(lstUniverso);

    fprintf(pfLog, "Libera lista de ventas recuperadas del periodo.\n\n");
    fprintf(stderr, "Libera lista de ventas recuperadas del periodo.\n\n");
    vLiberaVentas(lstVentas);

    fprintf(pfLog, "Libera lista de metas de comisiones.\n\n");
    fprintf(stderr, "Libera lista de metas de comisiones.\n\n");
    vLiberaMetas(lstMetas);
    
    fprintf(pfLog, "Libera lista de Actuaciones con Valoración Diferenciada por Propiedad de la Oficina.\n\n");
    fprintf(stderr, "Libera lista de Actuaciones con Valoración Diferenciada por Propiedad de la Oficina.\n\n");
    vLiberaDiferenciada(lstActDiferenciada);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
	lSegFin=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
    stStatusProc.lSegProceso = lSegFin - lSegIni;
    fprintf(pfLog, "Estadistica del proceso\n");
    fprintf(pfLog, "------------------------\n");
    fprintf(pfLog, "Total Ventas Consideradas      : [%d]\n"  ,stStatusProc.iventas);
    fprintf(pfLog, "Total Registros Valorizados    : [%d]\n"  ,stStatusProc.ivalorizados);
    fprintf(pfLog, "Total Registros Basura         : [%d]\n"  ,stStatusProc.ibasura);
    fprintf(pfLog, "Total Registros Cmt_Valorizados: [%d]\n"  ,stStatusProc.ivalorizados + stStatusProc.ibasura);
    fprintf(pfLog, "Total Registros Logro_Metas    : [%d]\n"  ,stStatusProc.ilogros);
    fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", lSegundos);
    fprintf(pfLog, "%s\n", szRaya);
    fprintf(pfLog, "%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", szRaya);  
    
    
/*---------------------------------------------------------------------------*/
/* Cierre de traz<as y salida del proceso                                    */
/*---------------------------------------------------------------------------*/
	if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0," ", lSegundos,stStatusProc.ivalorizados + stStatusProc.ibasura))
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));
    fprintf(pfLog,"\n\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
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

