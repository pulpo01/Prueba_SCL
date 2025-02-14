
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
    "./pc/Sel_Cartera.pc"
};


static unsigned int sqlctx = 27714147;


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
   unsigned char  *sqhstv[7];
   unsigned long  sqhstl[7];
            int   sqhsts[7];
            short *sqindv[7];
            int   sqinds[7];
   unsigned long  sqharm[7];
   unsigned long  *sqharc[7];
   unsigned short  sqadto[7];
   unsigned short  sqtdso[7];
} sqlstm = {12,7};

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
"select A.NUM_VENTA ,A.COD_VENDEDOR  from GA_VENTAS A ,VE_VENDEDORES B ,VE_RE\
DVENTAS_TD D where ((((((D.COD_TIPORED=:b0 and D.COD_VENDEDOR=B.COD_VENDEDOR) \
and B.COD_TIPCOMIS=:b1) and B.COD_TIPCOMIS=A.COD_TIPCOMIS) and B.COD_VENDEDOR=\
A.COD_VENDEDOR) and A.IND_ESTVENTA='AC') and A.FEC_ACEPREC between TO_DATE(:b2\
,'DD-MM-YYYY') and TO_DATE(:b3,'DD-MM-YYYY'))           ";

 static char *sq0004 = 
"select A.NUM_VENTA ,A.COD_VENDEDOR  from GA_VENTAS A ,VE_VENDEDORES B ,VE_RE\
DVENTAS_TD D where ((((((D.COD_TIPORED=:b0 and D.COD_VENDEDOR=B.COD_VENDEDOR) \
and B.COD_TIPCOMIS=:b1) and B.COD_TIPCOMIS=A.COD_TIPCOMIS) and B.COD_VENDEDOR=\
A.COD_VENDEDOR) and A.IND_ESTVENTA='AC') and A.FEC_ACEPREC<TO_DATE(:b2,'DD-MM-\
YYYY'))           ";

 static char *sq0006 = 
"select A.NUM_ABONADO ,A.COD_ESTADO ,B.COD_ESTADO ,A.COD_SITUACION ,B.COD_SIT\
UACION ,A.COD_PLANTARIF ,B.COD_PLANTARIF  from CMT_CARTERA A ,GA_ABOCEL B wher\
e (((A.COD_TIPCOMIS=:b0 and A.COD_TIPORED=:b1) and A.NUM_ABONADO=B.NUM_ABONADO\
) and ((A.COD_ESTADO<>B.COD_ESTADO or A.COD_SITUACION<>B.COD_SITUACION) or A.C\
OD_PLANTARIF<>B.COD_PLANTARIF))           ";

 static char *sq0008 = 
"select NUM_ABONADO  from CMT_CARTERA C ,CMD_PARAMETROS P where (((((C.COD_TI\
PCOMIS=:b0 and C.COD_TIPORED=:b1) and C.COD_SITUACION=P.VAL_PARAMETRO1) and P.\
COD_TIPCODIGO=10) and P.COD_CODIGO=5) and P.COD_PARAMETRO>0) minus select NUM_\
ABONADO  from CMT_CARTERA C ,CMD_PARAMETROS P where ((((((C.COD_TIPCOMIS=:b0 a\
nd C.COD_TIPORED=:b1) and C.IND_PROCESABLE='N') and C.COD_ESTADO=P.VAL_PARAMET\
RO1) and P.COD_TIPCODIGO=10) and P.COD_CODIGO=6) and P.COD_PARAMETRO>0)       \
    ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,81,0,4,73,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
28,0,0,2,366,0,9,133,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
59,0,0,2,0,0,13,138,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
82,0,0,3,622,0,3,149,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
113,0,0,2,0,0,15,178,0,0,0,0,0,1,0,
128,0,0,4,328,0,9,224,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
155,0,0,4,0,0,13,229,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
178,0,0,5,622,0,3,240,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
209,0,0,4,0,0,15,269,0,0,0,0,0,1,0,
224,0,0,6,352,0,9,322,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
247,0,0,6,0,0,13,326,0,0,7,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,
290,0,0,7,179,0,5,346,0,0,6,6,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,
329,0,0,6,0,0,15,358,0,0,0,0,0,1,0,
344,0,0,8,470,0,9,414,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
375,0,0,8,0,0,13,420,0,0,1,0,0,1,0,2,3,0,0,
394,0,0,9,109,0,5,432,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
425,0,0,8,0,0,15,443,0,0,0,0,0,1,0,
440,0,0,10,113,0,4,511,0,0,1,0,0,1,0,2,97,0,0,
459,0,0,11,115,0,4,529,0,0,1,0,0,1,0,2,3,0,0,
478,0,0,12,245,0,4,561,0,0,5,2,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,1,3,0,0,1,97,0,0,
513,0,0,13,59,0,1,716,0,0,0,0,0,1,0,
528,0,0,14,0,0,29,790,0,0,0,0,0,1,0,
543,0,0,15,0,0,30,815,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Actualiza estados de cartera: Estados y situaciones de abonados para */
/*                               ser considerados en proceso.           */
/* Ingresa nuevas ventas periodo: Para lo que recurre a Siscel para     */
/*                                recuperar las nuevas ventas.          */
/* Discrimina clientes/abonados a ser procesados.                       */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 13 de Agosto del 2001.                                 */
/* Por Fabian Aedo Ramírez.                                             */
/* modificado : Viernes 13 de Diciembre 2002                            */
/* por Jaime Vargas                                                     */ 
/*----------------------------------------------------------------------*/
#include "Sel_Cartera.h"
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

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUserName[30]="";
	char    szhPassWord[30]="";
	char    szhSysDate [17]="";
   	char    szFechaYYYYMMDD[9]="";  
	char    szhIndInstancia[2]="";
    char    szhIndEstado[2]="";
    short 	lhErrValCartera;
	long    lhCodError;
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
    
    switch(szTipoPeriodo)
    {
    	case PERIODICO:
    			fprintf(stderr,"\n[vCargaTiposComis] EJECUCION EN MODO PERIODICO.\n");
    			fprintf(pfLog ,"\n[vCargaTiposComis] EJECUCION EN MODO PERIODICO.\n");
    			lstTiposComis = stGetTipComisSelecPer(UNIVERSO, stCiclo);
				break;
    	case ESPORADICO:
    			fprintf(stderr,"\n[vCargaTiposComis] EJECUCION EN MODO ESPORADICO.\n");
    			fprintf(pfLog ,"\n[vCargaTiposComis] EJECUCION EN MODO ESPORADICO.\n");
    			lstTiposComis = stGetTipComisSelecProm(UNIVERSO, stCiclo);
    			break;
    }
}	
/*-----------------------------------------------------------------------------*/
/* funcion que retorna si existen registros asosiados a un tipo comisionista   */
/*-----------------------------------------------------------------------------*/
BOOL  bfnExisteTipComis(char * pszCodTipComis)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      char  szhCodTipComis[3];
      long  lhContReg;
   /* EXEC SQL END DECLARE SECTION; */ 


   strcpy(szhCodTipComis , pszCodTipComis);
   lhContReg = 0;

   /* EXEC SQL SELECT count(*) INTO :lhContReg
      FROM  CMT_CARTERA
      WHERE COD_TIPCOMIS  = :szhCodTipComis 
      AND   ROWNUM = 1 ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 2;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(*)  into :b0  from CMT_CARTERA where (COD_TIP\
COMIS=:b1 and ROWNUM=1)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )5;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhContReg;
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
}



   if(lhContReg != 0)
      return TRUE ;
   else
      return FALSE ;
}
/*****************************************************************************/
/* Rutina para la incorporación de las nuevas ventas de MasterDealer         */
/*****************************************************************************/
void vGetNvasVentas(int piCodTipoRed, char * szCodigoTipComis, char * pszCodTipVendedor)
{
	int         i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
	long		lCantVentas  = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;
		char    szhFecDesde[11];
		char    szhFecHasta[11];
		long    lhNumVenta[MAXFETCH];
		long	lhCodVendedor[MAXFETCH];
		long	lNumVenta;
		long	lhCodComisionista;
		char	szhCodTipComis[3];
		int     ihCodTipoRed;
		char	szhCodTipVendedor[3];
    /* EXEC SQL END DECLARE SECTION; */ 

               
    strcpy(szhFecDesde    		, stCiclo.szFecDesdeNormal);   
    strcpy(szhFecHasta    		, stCiclo.szFecHastaNormal);         
    strcpy(szhCodTipComis 		, szCodigoTipComis);    
    strcpy(szhCodTipVendedor	, pszCodTipVendedor);
    ihCodTipoRed          		= piCodTipoRed;
                       
    fprintf(stderr,"[vGetNvasVentas] En Proceso de inserción de nuevas ventas... fec_desde = [%s],\n",szhFecDesde);
    fprintf(stderr,"[vGetNvasVentas] En Proceso de inserción de nuevas ventas... fec_hasta = [%s],\n",szhFecHasta);

    fprintf(pfLog ,"[vGetNvasVentas] En Proceso de inserción de nuevas ventas... fec_desde = [%s],\n",szhFecDesde);
    fprintf(pfLog ,"[vGetNvasVentas] En Proceso de inserción de nuevas ventas... fec_hasta = [%s],\n",szhFecHasta);
    
    /* EXEC SQL DECLARE NUEVASVTAS CURSOR for 
        SELECT 	A.NUM_VENTA,
        		A.COD_VENDEDOR 
         FROM 	GA_VENTAS       A, 
              	VE_VENDEDORES   B,
		      	VE_REDVENTAS_TD D
        WHERE	D.COD_TIPORED    = :ihCodTipoRed
          AND	D.COD_VENDEDOR   = B.COD_VENDEDOR
          AND 	B.COD_TIPCOMIS   = :szhCodTipVendedor
          AND 	B.COD_TIPCOMIS   = A.COD_TIPCOMIS
          AND 	B.COD_VENDEDOR   = A.COD_VENDEDOR 
          AND 	A.IND_ESTVENTA   = 'AC' 
          AND 	A.FEC_ACEPREC     BETWEEN TO_DATE(:szhFecDesde,'DD-MM-YYYY') 
		  AND   TO_DATE(:szhFecHasta,'DD-MM-YYYY'); */ 


    /* EXEC SQL OPEN NUEVASVTAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )28;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
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
}


    lMaxFetch = MAXFETCH;
        
	while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL FOR :lMaxFetch FETCH   NUEVASVTAS
        	INTO	:lhNumVenta, lhCodVendedor; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
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
}



		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
			lCantVentas++;
			lNumVenta = lhNumVenta[i];
			lhCodComisionista	= lObtieneVendedorPadre(lhCodVendedor[i], ihCodTipoRed, szhCodTipComis);
        
	        /* EXEC SQL INSERT INTO CMT_CARTERA
	              ( COD_TIPCOMIS       ,COD_COMISIONISTA
	               ,COD_AGENCIA        ,COD_CLIENTE
	               ,NUM_VENTA          ,FEC_VENTA
	               ,FEC_ACEPREC        
	               ,NUM_ABONADO        ,COD_ESTADO         
	               ,FEC_CAMBIO         ,COD_SITUACION     
	               ,IND_PROCESABLE     ,COD_PLANTARIF      
	               ,COD_TIPORED		   ,COD_TIPVENDEDOR) 
	           SELECT 
	                :szhCodTipComis    	,:lhCodComisionista
	               ,A.COD_VENDEDOR     	,A.COD_CLIENTE
	               ,A.NUM_VENTA        	,A.FEC_VENTA
	               ,NVL(A.FEC_ACEPREC  	,A.FEC_VENTA)
	               ,C.NUM_ABONADO      	,C.COD_ESTADO
	               ,SYSDATE        		,C.COD_SITUACION
	               ,'N'                	,C.COD_PLANTARIF 
	               ,:ihCodTipoRed		,A.COD_TIPCOMIS
	          FROM GA_VENTAS       A , 
	               GA_ABOCEL       C 
	         WHERE A.NUM_VENTA         = :lNumVenta
	           AND A.IND_ESTVENTA      = 'AC'
	           AND A.NUM_VENTA         = C.NUM_VENTA
	           AND NOT EXISTS (SELECT X.NUM_ABONADO FROM CMT_CARTERA X
	                           WHERE C.NUM_ABONADO=X.NUM_ABONADO); */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "insert into CMT_CARTERA (COD_TIPCOMIS,COD_COMISIONIS\
TA,COD_AGENCIA,COD_CLIENTE,NUM_VENTA,FEC_VENTA,FEC_ACEPREC,NUM_ABONADO,COD_EST\
ADO,FEC_CAMBIO,COD_SITUACION,IND_PROCESABLE,COD_PLANTARIF,COD_TIPORED,COD_TIPV\
ENDEDOR)select :b0 ,:b1 ,A.COD_VENDEDOR ,A.COD_CLIENTE ,A.NUM_VENTA ,A.FEC_VEN\
TA ,NVL(A.FEC_ACEPREC,A.FEC_VENTA) ,C.NUM_ABONADO ,C.COD_ESTADO ,SYSDATE ,C.CO\
D_SITUACION ,'N' ,C.COD_PLANTARIF ,:b2 ,A.COD_TIPCOMIS  from GA_VENTAS A ,GA_A\
BOCEL C where (((A.NUM_VENTA=:b3 and A.IND_ESTVENTA='AC') and A.NUM_VENTA=C.NU\
M_VENTA) and  not exists (select X.NUM_ABONADO  from CMT_CARTERA X where C.NUM\
_ABONADO=X.NUM_ABONADO))";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )82;
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
         sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipoRed;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lNumVenta;
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
}


		}
    }
    fprintf(pfLog , "\n[vGetNvasVentas] Ventas Recuperadas TR:[%d] TipComis:[%s] TipVendedor:[%s]--->[%d]\n", ihCodTipoRed, szhCodTipComis,szhCodTipVendedor, lCantVentas);
    fprintf(stderr, "\n[vGetNvasVentas] Ventas Recuperadas TR:[%d] TipComis:[%s] TipVendedor:[%s]--->[%d]\n", ihCodTipoRed, szhCodTipComis,szhCodTipVendedor, lCantVentas);
    /* EXEC SQL CLOSE NUEVASVTAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )113;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


}
/*****************************************************************************/
/* Rutina para la creación de cartera inicial para nuevos tip_comis          */
/*****************************************************************************/
void vCargaCarteraNueva(int piCodTipoRed, char * pszCodTipComis, char *pszCodTipVendedor)
{
	int         i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
	long		lCantVentas = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;
        char    szhFecHasta[11];
        long    lNumVenta[MAXFETCH];
        long	lhCodVendedor[MAXFETCH];
        long	lhCodComisionista;
        long    lhNumVenta;
        char    szhCodTipComis[3];
		int     ihCodTipoRed;
		char	szhCodTipVendedor[3];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhFecHasta    		, stCiclo.szFecHastaNormal);
    strcpy(szhCodTipComis 		, pszCodTipComis);    
	strcpy(szhCodTipVendedor	, pszCodTipVendedor);
	ihCodTipoRed          		= piCodTipoRed;

    fprintf(stderr,"[vCargaCarteraNueva] En Proceso de creacion cartera inicial... fec_hasta = [%s],\n",szhFecHasta);
    fprintf(pfLog ,"[vCargaCarteraNueva] En Proceso de creacion cartera inicial... fec_hasta = [%s],\n",szhFecHasta);
    
    /* EXEC SQL DECLARE CARTERANUEVA CURSOR for 
        SELECT 	A.NUM_VENTA,
        		A.COD_VENDEDOR 
         FROM 	GA_VENTAS       A, 
              	VE_VENDEDORES   B,
		      	VE_REDVENTAS_TD D
        WHERE	D.COD_TIPORED    = :ihCodTipoRed
          AND	D.COD_VENDEDOR   = B.COD_VENDEDOR
          AND 	B.COD_TIPCOMIS   = :szhCodTipVendedor
          AND 	B.COD_TIPCOMIS   = A.COD_TIPCOMIS
          AND 	B.COD_VENDEDOR   = A.COD_VENDEDOR 
          AND 	A.IND_ESTVENTA     = 'AC' 
          AND 	A.FEC_ACEPREC      < TO_DATE(:szhFecHasta,'DD-MM-YYYY'); */ 


    /* EXEC SQL OPEN CARTERANUEVA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )128;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
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
}


    lMaxFetch = MAXFETCH;
        
	while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL FOR :lMaxFetch FETCH   CARTERANUEVA
        	INTO	:lNumVenta, :lhCodVendedor; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )155;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lNumVenta;
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
}



		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
			lCantVentas++;
			lhNumVenta = lNumVenta[i];
			lhCodComisionista	= lObtieneVendedorPadre(lhCodVendedor[i], ihCodTipoRed, szhCodTipComis);
					
	        /* EXEC SQL INSERT INTO CMT_CARTERA
	              ( COD_TIPCOMIS       ,COD_COMISIONISTA
	               ,COD_AGENCIA        ,COD_CLIENTE
	               ,NUM_VENTA          ,FEC_VENTA
	               ,FEC_ACEPREC        
	               ,NUM_ABONADO        ,COD_ESTADO         
	               ,FEC_CAMBIO         ,COD_SITUACION     
	               ,IND_PROCESABLE     ,COD_PLANTARIF      
	               ,COD_TIPORED		   ,COD_TIPVENDEDOR) 
	           SELECT 
	                :szhCodTipComis    	,:lhCodComisionista
	               ,A.COD_VENDEDOR     	,A.COD_CLIENTE
	               ,A.NUM_VENTA        	,A.FEC_VENTA
	               ,NVL(A.FEC_ACEPREC  	,A.FEC_VENTA)
	               ,C.NUM_ABONADO      	,C.COD_ESTADO
	               ,SYSDATE        		,C.COD_SITUACION
	               ,'N'                	,C.COD_PLANTARIF 
	               ,:ihCodTipoRed		,A.COD_TIPCOMIS
	          FROM GA_VENTAS       A , 
	               GA_ABOCEL       C 
	         WHERE A.NUM_VENTA         = :lhNumVenta
	           AND A.IND_ESTVENTA      = 'AC'
	           AND A.NUM_VENTA         = C.NUM_VENTA
	           AND NOT EXISTS (SELECT X.NUM_ABONADO FROM CMT_CARTERA X
	                           WHERE C.NUM_ABONADO=X.NUM_ABONADO); */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "insert into CMT_CARTERA (COD_TIPCOMIS,COD_COMISIONIS\
TA,COD_AGENCIA,COD_CLIENTE,NUM_VENTA,FEC_VENTA,FEC_ACEPREC,NUM_ABONADO,COD_EST\
ADO,FEC_CAMBIO,COD_SITUACION,IND_PROCESABLE,COD_PLANTARIF,COD_TIPORED,COD_TIPV\
ENDEDOR)select :b0 ,:b1 ,A.COD_VENDEDOR ,A.COD_CLIENTE ,A.NUM_VENTA ,A.FEC_VEN\
TA ,NVL(A.FEC_ACEPREC,A.FEC_VENTA) ,C.NUM_ABONADO ,C.COD_ESTADO ,SYSDATE ,C.CO\
D_SITUACION ,'N' ,C.COD_PLANTARIF ,:b2 ,A.COD_TIPCOMIS  from GA_VENTAS A ,GA_A\
BOCEL C where (((A.NUM_VENTA=:b3 and A.IND_ESTVENTA='AC') and A.NUM_VENTA=C.NU\
M_VENTA) and  not exists (select X.NUM_ABONADO  from CMT_CARTERA X where C.NUM\
_ABONADO=X.NUM_ABONADO))";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )178;
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
         sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipoRed;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
}


		}
    }
	fprintf(pfLog , "\n[vCargaCarteraNueva]Ventas Nuevas Tr:[%d] TipComis:[%s] TipVendedor:[%s]-->[%d].\n",ihCodTipoRed, szhCodTipComis, szhCodTipVendedor, lCantVentas);
	fprintf(stderr, "\n[vCargaCarteraNueva]Ventas Nuevas Tr:[%d] TipComis:[%s] TipVendedor:[%s]-->[%d].\n",ihCodTipoRed, szhCodTipComis, szhCodTipVendedor, lCantVentas);
    /* EXEC SQL CLOSE CARTERANUEVA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )209;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


}
/*****************************************************************************/
/* Rutina para la actualizacion de los estados, situaciones y plan tarifario */
/* que cambiaron durante el último periodo.                                  */
/*****************************************************************************/
void vActCambiosAbonados(int piCodTipoRed, char * pszCodTipComis)
{

    long    	lhCantAbonados=0;
	int         i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lMaxFetch;
		int		ihCodTipoRed;
		char	szhCodTipComis[3];
        
        long    lhNumAbonado[MAXFETCH];
        char    szhOldEstado[MAXFETCH][3]; 
        char    szhNewEstado[MAXFETCH][3];
        char    szhOldSituacion[MAXFETCH][4]; 
        char    szhNewSituacion[MAXFETCH][4];
        char    szhOldPlanTarif[MAXFETCH][4]; 
        char    szhNewPlanTarif[MAXFETCH][4]; 
        
        char    szhEstado[3];
        char    szhSituacion[4];
        char    szhPlanTarif[4]; 
        long	lhAbonado;
    /* EXEC SQL END DECLARE SECTION; */ 

        
	ihCodTipoRed             = piCodTipoRed;
    strcpy(szhCodTipComis    , pszCodTipComis);
        
    /* EXEC SQL DECLARE CAMBIOS_ABONADOS CURSOR for 
        SELECT A.NUM_ABONADO
              ,A.COD_ESTADO
              ,B.COD_ESTADO
              ,A.COD_SITUACION
              ,B.COD_SITUACION
              ,A.COD_PLANTARIF
              ,B.COD_PLANTARIF 
        FROM  CMT_CARTERA A ,
              GA_ABOCEL   B
        WHERE A.COD_TIPCOMIS	 =  :szhCodTipComis
		  AND A.COD_TIPORED      =  :ihCodTipoRed
          AND A.NUM_ABONADO      =  B.NUM_ABONADO
          AND ((A.COD_ESTADO    !=  B.COD_ESTADO) 
            OR (A.COD_SITUACION !=  B.COD_SITUACION)
            OR (A.COD_PLANTARIF !=  B.COD_PLANTARIF)); */ 


    /* EXEC SQL OPEN CAMBIOS_ABONADOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )224;
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
}


        
	while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL FOR :lMaxFetch FETCH   CAMBIOS_ABONADOS
			INTO :lhNumAbonado    , 
                 :szhOldEstado    ,
                 :szhNewEstado    ,
                 :szhOldSituacion ,
                 :szhNewSituacion ,
                 :szhOldPlanTarif ,
                 :szhNewPlanTarif ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )247;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lhNumAbonado;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhOldEstado;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )3;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhNewEstado;
        sqlstm.sqhstl[2] = (unsigned long )3;
        sqlstm.sqhsts[2] = (         int  )3;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhOldSituacion;
        sqlstm.sqhstl[3] = (unsigned long )4;
        sqlstm.sqhsts[3] = (         int  )4;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhNewSituacion;
        sqlstm.sqhstl[4] = (unsigned long )4;
        sqlstm.sqhsts[4] = (         int  )4;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhOldPlanTarif;
        sqlstm.sqhstl[5] = (unsigned long )4;
        sqlstm.sqhsts[5] = (         int  )4;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhNewPlanTarif;
        sqlstm.sqhstl[6] = (unsigned long )4;
        sqlstm.sqhsts[6] = (         int  )4;
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
}



		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
        	lhCantAbonados++;
        	
			strcpy(szhEstado	, szfnTrim(szhNewEstado[i]));
			strcpy(szhSituacion	, szfnTrim(szhNewSituacion[i]));
			strcpy(szhPlanTarif	, szfnTrim(szhNewPlanTarif[i])); 
			lhAbonado			= lhNumAbonado[i];
			
	        /* EXEC SQL UPDATE CMT_CARTERA
	             SET COD_ESTADO      = :szhEstado,
	                 COD_SITUACION   = :szhSituacion,
	                 COD_PLANTARIF   = :szhPlanTarif,
	                 FEC_CAMBIO      = SYSDATE,
	                 IND_PROCESABLE  = 'N'
	           WHERE NUM_ABONADO      = :lhAbonado 
	          	 AND COD_TIPCOMIS     = :szhCodTipComis
			  	 AND COD_TIPORED      = :ihCodTipoRed; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 7;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CMT_CARTERA  set COD_ESTADO=:b0,COD_SITUACION\
=:b1,COD_PLANTARIF=:b2,FEC_CAMBIO=SYSDATE,IND_PROCESABLE='N' where ((NUM_ABONA\
DO=:b3 and COD_TIPCOMIS=:b4) and COD_TIPORED=:b5)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )290;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
         sqlstm.sqhstl[0] = (unsigned long )3;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)szhSituacion;
         sqlstm.sqhstl[1] = (unsigned long )4;
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)szhPlanTarif;
         sqlstm.sqhstl[2] = (unsigned long )4;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&lhAbonado;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
         sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipoRed;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
}


    	}
    }
    
	/* EXEC SQL CLOSE CAMBIOS_ABONADOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )329;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
    fprintf(pfLog ,"\n [vActCambiosAbonados] Cantidad Total de abonados actualizados... %d\n",lhCantAbonados);
    fprintf(stderr,"\n [vActCambiosAbonados] Cantidad Total de abonados actualizados... %d\n",lhCantAbonados);
}       
/*****************************************************************************/
/* Rutina para determinacion de ind_procesable, es decir, si el abonado      */
/* entrara al proceso de comision.                                           */
/* Situacion de abonado Aceptable (AAA, ABP, ACP, CNP, CSP, RTP)             */
/* Estados de Cobranza que invalidan: (BF, CF, CC)                           */
/* Solo se chequean aquellos abonados que ingresaron y/o cambiaron de estado */
/* es decir, con IND_PROCESABLE='P'.                                         */
/*****************************************************************************/
void vDiscriminaAbonados(int piCodTipoRed , char * pszCodTipComis)
{
	long       	iCantidad = 0;
	int         i;      
	short       iLastRows    = 0;  
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lMaxFetch;     
		int		ihCodTipoRed;
		char	szhCodTipComis[3];
        long    lhNumAbonado[MAXFETCH];
        long	lhAbonado;
        char    szhIndProcesable[2];
    /* EXEC SQL END DECLARE SECTION; */ 


	lMaxFetch                = MAXFETCH;
	ihCodTipoRed             = piCodTipoRed;
    strcpy(szhCodTipComis    , pszCodTipComis);
        
    /* EXEC SQL DECLARE DISCRIMINA_ABONADOS CURSOR for 
        SELECT NUM_ABONADO                           
        FROM  CMT_CARTERA    C ,                          
              CMD_PARAMETROS P                         
       WHERE  C.COD_TIPCOMIS   = :szhCodTipComis
		  AND C.COD_TIPORED    = :ihCodTipoRed
       	  AND C.COD_SITUACION  = P.VAL_PARAMETRO1  
          AND P.COD_TIPCODIGO  = 10 
          AND P.COD_CODIGO     = 5 
          AND P.COD_PARAMETRO  > 0
       MINUS
       SELECT NUM_ABONADO                           
       FROM  CMT_CARTERA     C ,                          
             CMD_PARAMETROS  P                         
      WHERE  C.COD_TIPCOMIS		= :szhCodTipComis
		  AND C.COD_TIPORED    	= :ihCodTipoRed
          AND C.IND_PROCESABLE 	= 'N' 
       	  AND C.COD_ESTADO     	= P.VAL_PARAMETRO1 
          AND P.COD_TIPCODIGO  	= 10 
          AND P.COD_CODIGO     	= 6 
          AND P.COD_PARAMETRO  	> 0 ; */ 

    
	/* EXEC SQL OPEN DISCRIMINA_ABONADOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )344;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipComis;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipoRed;
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
}


	     
	strcpy(szhIndProcesable,"S");
	
	while(iFetchedRows == iRetrievRows)
	{
		/* EXEC SQL for :lMaxFetch 
        	FETCH DISCRIMINA_ABONADOS 
            INTO  :lhNumAbonado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )375;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
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
}



		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
		iLastRows    = sqlca.sqlerrd[2];                
                
		for (i=0; i < iRetrievRows; i++)
		{
	
			lhAbonado = lhNumAbonado[i];
			
			/* EXEC SQL UPDATE CMT_CARTERA 
			SET IND_PROCESABLE = :szhIndProcesable
			WHERE NUM_ABONADO    = :lhAbonado
			AND  COD_TIPORED    = :ihCodTipoRed
			AND  COD_TIPCOMIS   = :szhCodTipComis; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CMT_CARTERA  set IND_PROCESABLE=:b0 where ((NUM_ABO\
NADO=:b1 and COD_TIPORED=:b2) and COD_TIPCOMIS=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )394;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhIndProcesable;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhAbonado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipComis;
   sqlstm.sqhstl[3] = (unsigned long )3;
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
}


			
			iCantidad++;
		}
	}
	fprintf(pfLog , "\n[vDiscriminaAbonados] Abonados con Cambio a Procesable TR:[%d] TipComis:[%s]---->[%d]\n",ihCodTipoRed, szhCodTipComis, iCantidad);
	fprintf(stderr, "\n[vDiscriminaAbonados] Abonados con Cambio a Procesable TR:[%d] TipComis:[%s]---->[%d]\n",ihCodTipoRed, szhCodTipComis, iCantidad);
	/* EXEC SQL CLOSE DISCRIMINA_ABONADOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )425;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


}
/*****************************************************************************/
/* RUTINA QUE PERMITE MANEJAR LAS  ENTIDADES DE CARTERA PARA LOS PROCESOS    */
/* DE COMISION POR CONCEPTO DE FACTURACION                                   */
/*****************************************************************************/
void vProcesaCarteras()
{
    stTiposComis * paux;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhCodTipComis[3];
		int		ihCodTipoRed;
		char	szhCodTipVendedor[3];
    /* EXEC SQL END DECLARE SECTION; */ 

        
	for (paux=lstTiposComis;paux != NULL; paux=paux->sgte)
    {
		ihCodTipoRed            = paux->iCodTipoRed   ;
		strcpy(szhCodTipComis   , paux->szCodTipComis);
		strcpy(szhCodTipVendedor, paux->szCodTipVendedor);

        fprintf(pfLog, "\n[vProcesaCarteras] TR:[%d] TipComis:[%s] TipVendedor:[%s]\n", ihCodTipoRed, szhCodTipComis, szhCodTipVendedor);                

        if (bfnExisteTipComis(szhCodTipComis))
        { 
            /*------------------------------------------------------------*/
            /* Rutina para la actualizacion de los estados, situaciones   */
            /* y plan tarifario que cambiaron durante el último periodo.  */
            /*------------------------------------------------------------*/
     		fprintf(pfLog , "[vProcesaCarteras] Actualizando estado de abonados para CodTipComis ...\n\n");       
    		fprintf(stderr, "[vProcesaCarteras] Actualizando estado de abonados para CodTipComis ...\n\n");       
            vActCambiosAbonados(ihCodTipoRed, szhCodTipComis);
              
            /*------------------------------------------------------------------ */
            /* Rutina para la incorporación de las nuevas ventas del periodo.    */
            /*------------------------------------------------------------------ */    
     		fprintf(pfLog , "[vProcesaCarteras] Recuperando nuevas ventas desde Siscel para CodTipComis ...\n\n");       
    		fprintf(stderr, "[vProcesaCarteras] Recuperando nuevas ventas desde Siscel para CodTipComis ...\n\n");       
            vGetNvasVentas(ihCodTipoRed, szhCodTipComis, szhCodTipVendedor);
        } 
        else
        { 
            /*------------------------------------------------------------------*/
            /* Genera Cartera Inicial para distribuidores nuevos.               */
            /*------------------------------------------------------------------*/
     		fprintf(pfLog , "[vProcesaCarteras] Genera Cartera Inicial para distribuidores nuevos...Tipo Comisionista:[%s].\n\n",szhCodTipComis);
    		fprintf(stderr, "[vProcesaCarteras] Genera Cartera Inicial para distribuidores nuevos...Tipo Comisionista:[%s].\n\n",szhCodTipComis);
            vCargaCarteraNueva(ihCodTipoRed, szhCodTipComis, szhCodTipVendedor);
         }
         
        /*------------------------------------------------------------------*/
        /* Determina abonados a ser procesables.                            */ 
        /*------------------------------------------------------------------*/
  		fprintf(pfLog , "[vProcesaCarteras] Determina abonados a ser procesados (marca S)...\n\n");
   		fprintf(stderr, "[vProcesaCarteras] Determina abonados a ser procesados (marca S)...\n\n");
        vDiscriminaAbonados(ihCodTipoRed, szhCodTipComis);                                                  
    }
}
/*****************************************************************************/
/* CARGA PARAMETROS DEL PROCESO Y VERIFICA ESTADO                            */
/*****************************************************************************/
void  vGetParametros()
{
	lhErrValCartera         = 0;
    strcpy(szhIndInstancia, "N");
	strcpy(szhIndEstado   , "T");

    /* EXEC SQL
		SELECT 	VAL_PARAMETRO
        INTO    :szhIndInstancia
 		FROM 	GED_PARAMETROS
		WHERE 	NOM_PARAMETRO = 'IND_CARTERA_MANUAL'
  		AND 	COD_MODULO    = 'CM'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(NOM_PARAMETRO='IND_CARTERA_MANUAL' and COD_MODULO='CM')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )440;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIndInstancia;
    sqlstm.sqhstl[0] = (unsigned long )2;
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
}



    if (sqlca.sqlcode!=0)
    {
       exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_201,"ERROR AL CONSULTAR PARAMETRO IND_CARTERA_MANUAL.",0,0));                                                                                                                           
    }

    if (strcmp(szhIndInstancia, AUTOMATICO) == 0)
    {
    	lhCodError = 0;
    }
    else
	{
		/* EXEC SQL
			SELECT 	VAL_PARAMETRO
        	INTO    :lhErrValCartera
 			FROM 	GED_PARAMETROS
			WHERE 	NOM_PARAMETRO = 'COD_ERROR_VALCARTERA'
  			AND 	COD_MODULO    = 'CM'; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (N\
OM_PARAMETRO='COD_ERROR_VALCARTERA' and COD_MODULO='CM')";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )459;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhErrValCartera;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
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
}



        if (sqlca.sqlcode != 0)
     	{
       		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_201,"ERROR AL CONSULTAR PARAMETRO COD_ERROR_VALCARTERA.",0,0));                                                                                                                           
     	}
	}
	fprintf(pfLog, "\n[vGetParametros] Modo Cartera Manual:[%s] Error Generico:[%d].\n",szhIndInstancia, lhErrValCartera);
	fprintf(stderr, "\n[vGetParametros] Modo Cartera Manual:[%s] Error Generico:[%d].\n",szhIndInstancia, lhErrValCartera);
}
/*****************************************************************************/
/* VERIFICA ESTADO DEL PROCESO                                               */
/*****************************************************************************/
void vEstadoProceso()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhSecProceso;
		long lhMiSecProceso;
		char szhIdCiclComis[11];
    /* EXEC SQL END DECLARE SECTION; */ 

    
	lhMiSecProceso 			= proceso.sec_proceso;
	strcpy(szhIdCiclComis	, stArgs.szIdPeriodo);
	
	fprintf(pfLog, "\n[vEstadoProceso]Valida ejecucion anterior proceso Cartera.\n");
	fprintf(stderr, "\n[vEstadoProceso]Valida ejecucion anterior proceso Cartera.\n");
	
	/* EXEC SQL
		SELECT 	SEC_PROCESO         , 
				NVL(IND_ESTADO, 'T'), 
     			NVL(COD_ERROR , 0)
		INTO    :lhSecProceso,
				:szhIndEstado, 
				:lhCodError
		FROM 	CMT_TRAZAS_PROCESOS
		WHERE 	SEC_PROCESO = (SELECT MAX(SEC_PROCESO) 
							   FROM CMT_TRAZAS_PROCESOS 
							   WHERE SEC_PROCESO < :lhMiSecProceso
							   AND ID_PERIODO = :szhIdCiclComis)
		AND 	COD_PROCESO = 'SEL_CARTERA'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select SEC_PROCESO ,NVL(IND_ESTADO,'T') ,NVL(COD_ERROR,0) in\
to :b0,:b1,:b2  from CMT_TRAZAS_PROCESOS where (SEC_PROCESO=(select max(SEC_PR\
OCESO)  from CMT_TRAZAS_PROCESOS where (SEC_PROCESO<:b3 and ID_PERIODO=:b4)) a\
nd COD_PROCESO='SEL_CARTERA')";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )478;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhSecProceso;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhIndEstado;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodError;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhMiSecProceso;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhIdCiclComis;
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
}



    if (sqlca.sqlcode != SQLNOTFOUND)
    {
	    if (sqlca.sqlcode!=SQLOK)
	    {
	    	exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_201,"ERROR AL CONSULTAR ESTADO DEL PROCESO",0,0));                                                                                                                           
	    }	
	
	    fprintf(pfLog, "[vEstadoProceso] Secuencia del Proceso <%ld> - Estado <%s> - Error <%ld>\n", lhSecProceso, szhIndEstado, lhCodError);    
		if (strcmp(szhIndInstancia, MANUAL) == 0)
		{
		    if (strcmp(szhIndEstado, FALLA) == 0)
			{
				if(lhCodError == lhErrValCartera)	
				{
					fprintf(pfLog, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
					fprintf(pfLog, "\nDEBE APROBAR EN FORMA MANUAL LA CARTERAA TRAVES DE LA APLICACION VB.\n");
					fprintf(pfLog, "\nMENU FORMAS COMISION -> CARTERA -> ACTUALIZACION MANUAL CARTERA.\n");
					fprintf(pfLog, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");

					fprintf(stderr, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
					fprintf(stderr, "\nDEBE APROBAR EN FORMA MANUAL LA CARTERAA TRAVES DE LA APLICACION VB.\n");
					fprintf(stderr, "\nMENU FORMAS COMISION -> CARTERA -> ACTUALIZACION MANUAL CARTERA.\n");
					fprintf(stderr, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
					
					exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,lhErrValCartera,"CARTERA EN ESPERA DE APROBACION POR EL USUARIO.",0,0)); 
				}
			}
		}

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
    long    lSegIni, lSegFin ;
    short   ibiblio;   
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
	memset(&stStatusProc, 0, sizeof(rg_estadistica));
	memset(&stCiclo, 0, sizeof(reg_ciclo));  
	memset(&proceso     , 0, sizeof(proceso));
  
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
     memset(&stArgs, 0, sizeof(rg_argumentos));
     vManejaArgs(argc, argv);        
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
    strcpy(szhUserName, stArgs.szUser);                                                 
    strcpy(szhPassWord, stArgs.szPass); 
                                                         
    if(fnOraConnect(szhUserName, szhPassWord) == FALSE)                                       
    {                                                                                 
       fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
       exit(EXIT_205);                                                           
    }                                                                                 
    else                                                                              
    {                                                                                 
       fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");    
       fprintf(stderr, "Username: %s\n\n", szhUserName);                             
    }                                                                                 
/*---------------------------------------------------------------------------*/
/* Inicializa la traza del proceso.                                          */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUserName, stArgs.izSecuencia);
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
    sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
        
    if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)                                                          
    {                                                                                                        
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", LOGNAME);                                 
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
	fprintf(pfLog, "Base de datos : %s\n\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog,"\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName() ); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);

    fprintf(pfLog, "Identificador de Proceso		<%s>\n", stArgs.szProceso);
    fprintf(pfLog, "Identificador de Bloque			<%s>\n", stArgs.szBloque);
    fprintf(pfLog, "Secuencia de Ejecucion			<%d>\n", stArgs.izSecuencia);    
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy hh24:mi:ss'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy hh24:mi:s\
s'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )513;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

      
/*---------------------------------------------------------------------------*/
/* Procesamiento principal:                                                  */
/*---------------------------------------------------------------------------*/
   fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
   fprintf(pfLog, "Inicio Procesamiento Principal ...\n\n");
/*---------------------------------------------------------------------------*/
/* Carga Parametros del proceso                                              */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga parametros del proceso...\n\n");       
    fprintf(stderr, "Carga parametros del proceso...\n\n");       
    vGetParametros();
/*---------------------------------------------------------------------------*/
/* Verifica Estado del Proceso                                               */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Verifica Estado del Proceso...\n\n");       
    fprintf(stderr, "Verifica Estado del Proceso...\n\n");       
    vEstadoProceso();
/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA CICLOS DE PROCESO                                        */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga estructura de ciclo de proceso...\n\n");       
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
/* Controla ciclo para los de diferentes tipos de comisiones                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Procesando carteras por tipos de comision...\n\n");       
    fprintf(stderr, "Procesando carteras por tipos de comision...\n\n");       
    vProcesaCarteras();
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();                         
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog , "Estadistica del proceso\n");                                                   
    fprintf(pfLog , "-------------------------\n");
    fprintf(pfLog , "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);  
	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);
/*---------------------------------------------------------------------------*/                                                                                                                             
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Evalua Forma de Salida Final. Cartera Manual:[%s] Error:[%d]\n\n", szhIndInstancia, lhErrValCartera);
	
	if (strcmp(szhIndInstancia, MANUAL) == 0)
	{
		/* EXEC SQL COMMIT; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 7;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )528;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK, lhErrValCartera,"CARTERA EN ESPERA DE APROBACION DEL USUARIO.",stStatusProc.lSegProceso,0);
	    if (ibiblio)
	    {
	    	exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));                          
		}
		fprintf(pfLog, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
		fprintf(pfLog, "\nDEBE APROBAR EN FORMA MANUAL LA CARTERAA TRAVES DE LA APLICACION VB.\n");
		fprintf(pfLog, "\nMENU FORMAS COMISION -> CARTERA -> ACTUALIZACION MANUAL CARTERA.\n");
		fprintf(pfLog, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");

		fprintf(stderr, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
		fprintf(stderr, "\nDEBE APROBAR EN FORMA MANUAL LA CARTERAA TRAVES DE LA APLICACION VB.\n");
		fprintf(stderr, "\nMENU FORMAS COMISION -> CARTERA -> ACTUALIZACION MANUAL CARTERA.\n");
		fprintf(stderr, "\n++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++\n");
		
    }
    else
    {
		ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0," ",stStatusProc.lSegProceso,0);
	    if (ibiblio)
	    {
	    	exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));                          
		}
    }
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )543;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
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

