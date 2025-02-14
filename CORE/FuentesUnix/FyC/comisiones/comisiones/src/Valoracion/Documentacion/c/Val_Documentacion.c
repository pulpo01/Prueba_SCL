
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
           char  filnam[26];
};
static struct sqlcxp sqlfpn =
{
    25,
    "./pc/Val_Documentacion.pc"
};


static unsigned int sqlctx = 1774395227;


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

 static char *sq0001 = 
"select A.NUM_GENERAL ,A.COD_TIPCOMIS ,A.COD_CATEGCLIENTE ,B.TIP_PLAN ,A.COD_\
COMISIONISTA ,TO_CHAR(A.FEC_VENTA,'YYYYMMDDHH24MISS') ,TO_CHAR(A.FEC_VENTA,'DD\
-MM-YYYY') ,TO_CHAR(A.FEC_RECEPCION,'YYYYMMDDHH24MISS') ,A.IND_DOCUM ,A.NUM_DI\
AS_HABILES ,A.COD_OFICINA ,NVL(A.OBS_INCUMP,'SIN OBSERVACIONES') ,A.COD_TIPORE\
D ,A.COD_TECNOLOGIA  from CMT_HABIL_CELULAR A ,CMD_PLANESTARIF B where ((A.NUM\
_GENERAL>0 and A.ID_PERIODO=:b0) and A.COD_PLANTARIF=B.COD_PLANTARIF)         \
  ";

 static char *sq0002 = 
"select NUM_DIASDESDE ,NUM_DIASHASTA ,IMP_PENALIZACION ,TIP_OFICINA  from CM_\
PLAZOSDOCUM_TD where ((((COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEP\
TO=:b2) and TIP_PLAN=:b3) and COD_CATEGCLIENTE=:b4) order by NUM_DIASDESDE des\
c             ";

 static char *sq0003 = 
"select TIP_PLAN ,COD_CATEGCLIENTE ,IMP_PENALIZACION  from CM_DETALLE_DOCUM_T\
D where ((COD_TIPORED=:b0 and COD_PLANCOMIS=:b1) and COD_CONCEPTO=:b2)        \
   ";

 static char *sq0004 = 
"select VAL_PARAMETRO1  from CMD_PARAMETROS where ((COD_TIPCODIGO=5 and COD_C\
ODIGO=5) and COD_PARAMETRO>0)           ";

 static char *sq0005 = 
"select distinct B.TIP_EVALUACION ,K.TIP_CONCEPTO  from CM_CALIDAD_DOCUM_TD B\
 ,VE_VENDEDORES C ,VE_REDVENTAS_TD A ,CMD_CONCEPTOS K where ((((((B.COD_TIPORE\
D=:b0 and B.COD_PLANCOMIS=:b1) and B.COD_CONCEPTO=:b2) and B.COD_CONCEPTO=K.CO\
D_CONCEPTO) and B.COD_TIPORED=A.COD_TIPORED) and A.COD_VENDEDOR=C.COD_VENDEDOR\
) and C.COD_TIPCOMIS=:b3)           ";

 static char *sq0007 = 
"select COD_TIPORED ,COD_PLANCOMIS ,COD_CONCEPTO ,TIP_PLAN ,COD_CATEGCLIENTE \
,COD_VENDEDOR ,IMP_DIFERENCIADO  from CM_DIFDOCUMENTACION_TD  order by COD_VEN\
DEDOR            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,468,0,9,119,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,13,123,0,0,14,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
2,4,0,0,2,97,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
95,0,0,1,0,0,15,170,0,0,0,0,0,1,0,
110,0,0,2,246,0,9,225,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
145,0,0,2,0,0,13,229,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,97,0,0,
176,0,0,2,0,0,15,252,0,0,0,0,0,1,0,
191,0,0,3,157,0,9,295,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
218,0,0,3,0,0,13,299,0,0,3,0,0,1,0,2,97,0,0,2,97,0,0,2,4,0,0,
245,0,0,3,0,0,15,321,0,0,0,0,0,1,0,
260,0,0,4,116,0,9,390,0,0,0,0,0,1,0,
275,0,0,4,0,0,13,394,0,0,1,0,0,1,0,2,97,0,0,
294,0,0,4,0,0,15,411,0,0,0,0,0,1,0,
309,0,0,5,346,0,9,474,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
340,0,0,5,0,0,13,478,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
363,0,0,5,0,0,15,518,0,0,0,0,0,1,0,
378,0,0,6,190,0,3,794,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,4,0,0,1,3,0,0,
429,0,0,7,171,0,9,880,0,0,0,0,0,1,0,
444,0,0,7,0,0,13,884,0,0,7,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,
2,3,0,0,2,4,0,0,
487,0,0,7,0,0,15,913,0,0,0,0,0,1,0,
502,0,0,8,48,0,1,1117,0,0,0,0,0,1,0,
517,0,0,9,0,0,30,1240,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de valorizar las habilitaciones segun plazos de   */
/* entrega y calidad de la documentacion del cliente                    */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Miercoles 11-12-2002                                         */
/* Fin:                                                                 */
/* Autor : Patricio Gonzalez Gomez.                                     */
/************************************************************************/
/* Modificado Marcelo Quiroz Garcia                                     */
/* Se incorporan tratamientos de:                                       */
/* - Ciclos Esporádicos                                                 */
/* - Planes de Comisiones                                               */
/* - Red de Ventas                                                      */
/* Versionado CUZCO - Oct-2003.                                         */
/* **********************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Val_Documentacion.h"
#include "GEN_biblioteca.h"
/*---------------------------------------------------------------------------*/
/* Declaracion e inicializacion	de lista de conceptos a	procesar.	         */
/*---------------------------------------------------------------------------*/
stConceptosProc	* lstConceptosProc = NULL;
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
	char  	szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* FUNCION QUE RETORNA EL TIPO DE OFICINA ASOCIADA A UNA VENTA               */
/*---------------------------------------------------------------------------*/
char * szfnGetTipoOficina(char * pszOficina)
{
    char    szCodOficina[4];
    char    szTipoOficina[2];
        
    strcpy(szCodOficina,pszOficina);
        
    if(bfnVerificaOficina(lstOfCentrales, szCodOficina))
       strcpy(szTipoOficina,OFIC_CENTRAL);
    
    strcpy(szTipoOficina,OFIC_REGIONAL);
        
    return(szTipoOficina);
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LAS HABILITACIONES EN UNA LISTA                   */
/*---------------------------------------------------------------------------*/
void vLlenaHabilitaciones()
{
    stHabilitado    * pHabilitado;
    short           iLastRows    = 0;       
    int             i;
    long            lCantRegistros=0;

    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szIdPeriodo    [11];

        long    lMaxFetch;

	    char	szhCodTecnologia       [MAXFETCH][8];
		int		ihCodTipoRed           [MAXFETCH];		
        char    szhCodTipComis         [MAXFETCH][3];
        long    lhNumGeneral           [MAXFETCH]; 
        long    lhCodComisionista      [MAXFETCH];
        double  dFechaVenta            [MAXFETCH];
        char	szhFechaVenta		   [MAXFETCH][11];
        double  dFechaRecepcion        [MAXFETCH];
        char    szhCatCliente          [MAXFETCH][11];
        char    szhPlanTarif           [MAXFETCH][7];
        int     ihIndDocum             [MAXFETCH];
        int     ihNumDiasHabiles       [MAXFETCH];
        char    szhCodOficina          [MAXFETCH][4];
        char    szhObsImcump           [MAXFETCH][150];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szIdPeriodo	, stCiclo.szIdCiclComis);
	iLastRows    		= 0; 
	iFetchedRows 		= MAXFETCH;     
	iRetrievRows 		= MAXFETCH;     
	lMaxFetch 			= MAXFETCH; 		

	/* EXEC SQL DECLARE Cur_Habilitados CURSOR FOR
        SELECT  A.NUM_GENERAL, 
        		A.COD_TIPCOMIS,
	            A.COD_CATEGCLIENTE, 
    	        B.TIP_PLAN, 
            	A.COD_COMISIONISTA,
                TO_CHAR(A.FEC_VENTA, 'YYYYMMDDHH24MISS'),
                TO_CHAR(A.FEC_VENTA, 'DD-MM-YYYY'),
	            TO_CHAR(A.FEC_RECEPCION, 'YYYYMMDDHH24MISS'),
    	        A.IND_DOCUM,
        	    A.NUM_DIAS_HABILES,
                A.COD_OFICINA,
            	NVL(A.OBS_INCUMP, 'SIN OBSERVACIONES'),
            	A.COD_TIPORED,
            	A.COD_TECNOLOGIA
      	  FROM  CMT_HABIL_CELULAR A, CMD_PLANESTARIF B
      	  WHERE A.NUM_GENERAL > 0
      	  AND   A.ID_PERIODO    = :szIdPeriodo
          AND   A.COD_PLANTARIF = B.COD_PLANTARIF; */ 

    
	/* EXEC SQL OPEN Cur_Habilitados; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
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
 sqlstm.sqhstv[0] = (unsigned char  *)szIdPeriodo;
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


        
	while(iFetchedRows == iRetrievRows)
	{
    	/* EXEC SQL for :lMaxFetch 
        	FETCH Cur_Habilitados 
         	INTO    :lhNumGeneral      ,
         			:szhCodTipComis    ,
                 	:szhCatCliente     ,
                 	:szhPlanTarif      ,
                 	:lhCodComisionista ,
                 	:dFechaVenta       ,
                 	:szhFechaVenta	   ,
                 	:dFechaRecepcion   ,
                 	:ihIndDocum        ,
                 	:ihNumDiasHabiles  ,
                 	:szhCodOficina     ,
                 	:szhObsImcump	   ,
                 	:ihCodTipoRed      ,
                 	:szhCodTecnologia  ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )24;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)lhNumGeneral;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )sizeof(long);
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
     sqlstm.sqhstl[1] = (unsigned long )3;
     sqlstm.sqhsts[1] = (         int  )3;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCatCliente;
     sqlstm.sqhstl[2] = (unsigned long )11;
     sqlstm.sqhsts[2] = (         int  )11;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqharc[2] = (unsigned long  *)0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhPlanTarif;
     sqlstm.sqhstl[3] = (unsigned long )7;
     sqlstm.sqhsts[3] = (         int  )7;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqharc[3] = (unsigned long  *)0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)lhCodComisionista;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[4] = (         int  )sizeof(long);
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqharc[4] = (unsigned long  *)0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)dFechaVenta;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[5] = (         int  )sizeof(double);
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqharc[5] = (unsigned long  *)0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szhFechaVenta;
     sqlstm.sqhstl[6] = (unsigned long )11;
     sqlstm.sqhsts[6] = (         int  )11;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqharc[6] = (unsigned long  *)0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)dFechaRecepcion;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[7] = (         int  )sizeof(double);
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqharc[7] = (unsigned long  *)0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)ihIndDocum;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )sizeof(int);
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqharc[8] = (unsigned long  *)0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)ihNumDiasHabiles;
     sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[9] = (         int  )sizeof(int);
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqharc[9] = (unsigned long  *)0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)szhCodOficina;
     sqlstm.sqhstl[10] = (unsigned long )4;
     sqlstm.sqhsts[10] = (         int  )4;
     sqlstm.sqindv[10] = (         short *)0;
     sqlstm.sqinds[10] = (         int  )0;
     sqlstm.sqharm[10] = (unsigned long )0;
     sqlstm.sqharc[10] = (unsigned long  *)0;
     sqlstm.sqadto[10] = (unsigned short )0;
     sqlstm.sqtdso[10] = (unsigned short )0;
     sqlstm.sqhstv[11] = (unsigned char  *)szhObsImcump;
     sqlstm.sqhstl[11] = (unsigned long )150;
     sqlstm.sqhsts[11] = (         int  )150;
     sqlstm.sqindv[11] = (         short *)0;
     sqlstm.sqinds[11] = (         int  )0;
     sqlstm.sqharm[11] = (unsigned long )0;
     sqlstm.sqharc[11] = (unsigned long  *)0;
     sqlstm.sqadto[11] = (unsigned short )0;
     sqlstm.sqtdso[11] = (unsigned short )0;
     sqlstm.sqhstv[12] = (unsigned char  *)ihCodTipoRed;
     sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[12] = (         int  )sizeof(int);
     sqlstm.sqindv[12] = (         short *)0;
     sqlstm.sqinds[12] = (         int  )0;
     sqlstm.sqharm[12] = (unsigned long )0;
     sqlstm.sqharc[12] = (unsigned long  *)0;
     sqlstm.sqadto[12] = (unsigned short )0;
     sqlstm.sqtdso[12] = (unsigned short )0;
     sqlstm.sqhstv[13] = (unsigned char  *)szhCodTecnologia;
     sqlstm.sqhstl[13] = (unsigned long )8;
     sqlstm.sqhsts[13] = (         int  )8;
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
    	   	pHabilitado = (stHabilitado *) malloc(sizeof(stHabilitado));
                    
       		pHabilitado->lNumGeneral            = lhNumGeneral[i];
       		pHabilitado->lCodComisionista       = lhCodComisionista[i];
       		pHabilitado->iIndDocum              = ihIndDocum[i];
       		pHabilitado->iNumDiasHabiles        = ihNumDiasHabiles[i];
       		pHabilitado->iCodTipoRed        	= ihCodTipoRed[i];
       		pHabilitado->dFechaVenta            = dFechaVenta[i];
       		strcpy(pHabilitado->szFechaVenta	, szfnTrim(szhFechaVenta[i]));
       		pHabilitado->dFechaRecepcion        = dFechaRecepcion[i];                       
	                        
    		strcpy(pHabilitado->szCodOficina     , szfnTrim(szhCodOficina[i])); 
       		strcpy(pHabilitado->szTipoOficina    , szfnGetTipoOficina(pHabilitado->szCodOficina));
       		strcpy(pHabilitado->szCodCategCliente, szfnTrim(szhCatCliente[i]));
       		strcpy(pHabilitado->szTipPlan        , szfnTrim(szhPlanTarif[i]));
       		strcpy(pHabilitado->szCodTipComis    , szfnTrim(szhCodTipComis[i]));
       		strcpy(pHabilitado->szObsIncump      , szfnTrim(szhObsImcump[i]));
       		strcpy(pHabilitado->szCodTecnologia  , szfnTrim(szhCodTecnologia[i]));
       
	   		lCantRegistros++;
                    
	        pHabilitado->sgte  = lstHabilitado;                        
    		lstHabilitado      = pHabilitado;                  
    	}
    }
	/* EXEC SQL CLOSE Cur_Habilitados; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )95;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


    fprintf(pfLog,"[vLlenaHabilitaciones] Registros leidos:[%ld].\n",lCantRegistros);   
    fprintf(stderr,"[vLlenaHabilitaciones] Registros leidos:[%ld].\n",lCantRegistros);   
}
/*-----------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA EN UNA LISTA LOS PLAZOS CORRESPONDIENTE A CADA PLAN */
/*-----------------------------------------------------------------------------*/
stPlazos * fnCargaPlazos (int piCodTipoRed, char * pszCodPlanComis, int piConcepto, 
                          char * pszTipPlan, char * pszCatCliente)
{
    stPlazos    * paux;
    stPlazos    * qaux;
        
    int         i;
    short       iLastRows    = 0;       
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;		
		char	szhCodPlanComis[6];	
    	int     ihCodConcepto;
        char    szhTipPlan[7];
        char    szhCatCliente[11];
        int     ihDiasDesde            [MAXFETCH];
        int     ihDiasHasta            [MAXFETCH];
        double  dhImpPenalizacion      [MAXFETCH];
        char    szhTipOficina          [MAXFETCH][2];
              
        long    lMaxFetch;              
    /* EXEC SQL END DECLARE SECTION; */ 

        
    lMaxFetch = MAXFETCH;        
    qaux      = NULL;    
  
    ihCodTipoRed           = piCodTipoRed;
    ihCodConcepto          = piConcepto;

    strcpy(szhCodPlanComis , pszCodPlanComis);
    strcpy(szhTipPlan      , pszTipPlan     );      
    strcpy(szhCatCliente   , pszCatCliente  );
              
    /* EXEC SQL DECLARE Cur_plazos CURSOR FOR
          SELECT  NUM_DIASDESDE, 
                  NUM_DIASHASTA, 
                  IMP_PENALIZACION, 
                  TIP_OFICINA
          FROM    CM_PLAZOSDOCUM_TD
          WHERE   COD_TIPORED     = :ihCodTipoRed
		  AND     COD_PLANCOMIS   = :szhCodPlanComis
          AND     COD_CONCEPTO    = :ihCodConcepto
          AND     TIP_PLAN        = :szhTipPlan
          AND     COD_CATEGCLIENTE= :szhCatCliente
          ORDER BY NUM_DIASDESDE DESC; */ 

                        
    /* EXEC SQL OPEN Cur_plazos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )110;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhTipPlan;
    sqlstm.sqhstl[3] = (unsigned long )7;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCatCliente;
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


        
    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch 
                 FETCH Cur_plazos INTO
                       :ihDiasDesde,
                       :ihDiasHasta,
                       :dhImpPenalizacion,
                       :szhTipOficina; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )145;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)ihDiasDesde;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )sizeof(int);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)ihDiasHasta;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)dhImpPenalizacion;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )sizeof(double);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhTipOficina;
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
            paux = (stPlazos *) malloc(sizeof(stPlazos));
                        
            paux->iDiasDesde        = ihDiasDesde[i];
            paux->iDiasHasta        = ihDiasHasta[i];
            paux->dImpComision      = dhImpPenalizacion[i];
            strcpy(paux->szTipoOficina, szhTipOficina[i]);

            paux->sgte              = qaux;
            qaux                    = paux;        
         }
    }        
    /* EXEC SQL CLOSE Cur_plazos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )176;
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
/* PROCEDIMIENTO QUE CARGA EN UNA LISTA LOS PLANES DE CADA COMISIONISTA      */
/*---------------------------------------------------------------------------*/
stPlanes * fnCargaPlanes (int piCodTipoRed, char * pszCodPlanComis, int piConcepto )
{
    stPlanes        * paux;
    stPlanes        * qaux;

    int                        i;
    short       iLastRows    = 0;       
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed;		
		char	szhCodPlanComis[6];	
    	int     ihCodConcepto;
        long    lMaxFetch;             

        char    szhTipPlan              [MAXFETCH][7];
        char    szhCodCategCliente      [MAXFETCH][11];
        double  dhImpComision           [MAXFETCH];
    /* EXEC SQL END DECLARE SECTION; */ 


	ihCodTipoRed          = piCodTipoRed;
    ihCodConcepto         = piConcepto;
    strcpy(szhCodPlanComis, pszCodPlanComis);
        
    lMaxFetch = MAXFETCH;
    qaux      = NULL;    
                
    /* EXEC SQL DECLARE Cur_planes CURSOR FOR
        SELECT  TIP_PLAN, 
                COD_CATEGCLIENTE, 
                IMP_PENALIZACION
        FROM    CM_DETALLE_DOCUM_TD
        WHERE   COD_TIPORED   = :ihCodTipoRed
        AND     COD_PLANCOMIS = :szhCodPlanComis
		AND     COD_CONCEPTO  = :ihCodConcepto; */ 

                        
    /* EXEC SQL OPEN Cur_planes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )191;
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
             FETCH Cur_planes INTO
                    :szhTipPlan,
                    :szhCodCategCliente,
  	                :dhImpComision; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )218;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhTipPlan;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )7;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodCategCliente;
        sqlstm.sqhstl[1] = (unsigned long )11;
        sqlstm.sqhsts[1] = (         int  )11;
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
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {
            paux = (stPlanes *) malloc(sizeof(stPlanes));
                
            paux->dImpComision              = dhImpComision [i];
            strcpy(paux->szTipPlan          , szfnTrim(szhTipPlan[i]));
            strcpy(paux->szCodCategCliente  , szfnTrim(szhCodCategCliente[i]));

            paux->sgte_plazo  = NULL;
            paux->sgte        = qaux;
            qaux              = paux;                
       }
    }        
    /* EXEC SQL CLOSE Cur_planes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
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
/*---------------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LA OFICINAS REGIONALES EN UNA LISTA                     */
/*---------------------------------------------------------------------------------*/
int bfnVerificaOficina(stOficinas * pOficinas, char * CodOficina)
{       
    if (pOficinas == NULL)
    	return FALSE;

    if (strcmp(pOficinas->szCodOficina, CodOficina) == 0)
		return TRUE;
	
	return bfnVerificaOficina(pOficinas->sgte, CodOficina);
}

/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA SECUNDARIA DENOMINADA PLANES, DONDE SE    */
/* ALMACENARAN LOS PLANES CORRESPONDIENTES PARA CADA CASO                    */
/*---------------------------------------------------------------------------*/
void vLlenaPlanes()
{               
    stPrincipal     * pPrincipal;   
    stPlanes        * pPlanes;
    
    for(pPrincipal=lstPrincipal; pPrincipal!=NULL; pPrincipal=pPrincipal->sgte)
    {       
        pPrincipal->sgte_plan = fnCargaPlanes(pPrincipal->iCodTipoRed, pPrincipal->szCodPlanComis, 
                                              pPrincipal->iCodConcepto);
        if (pPrincipal->sgte_plan != NULL)
        {
            for(pPlanes=pPrincipal->sgte_plan; pPlanes!=NULL; pPlanes = pPlanes->sgte)
            {
                pPlanes->sgte_plazo = fnCargaPlazos(pPrincipal->iCodTipoRed , pPrincipal->szCodPlanComis, 
                                                    pPrincipal->iCodConcepto, pPlanes->szTipPlan, 
                                                    pPlanes->szCodCategCliente);
            }
        }

    }
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LAS ESTRUCTURAS DE OFICINAS TANTO CENTRALES COMO        */
/* REGIONALES                                                                */
/*---------------------------------------------------------------------------*/
void vLlenaOficinasCentrales ()
{               
    stOficinas      * pCentrales;
        
    int      i;       
    short    iLastRows    = 0;       
    int      iFetchedRows = MAXFETCH;
    int      iRetrievRows = MAXFETCH;
                
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lMaxFetch;
         char    szhCodOficina          [MAXFETCH][3];
    /* EXEC SQL END DECLARE SECTION; */ 

        
    lMaxFetch = MAXFETCH;
       
    /* EXEC SQL DECLARE Cur_OfCentrales CURSOR FOR
        SELECT  VAL_PARAMETRO1
        FROM    CMD_PARAMETROS
        WHERE   COD_TIPCODIGO   = 5
        AND     COD_CODIGO      = 5
        AND     COD_PARAMETRO   > 0; */ 


    /* EXEC SQL OPEN Cur_OfCentrales; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )260;
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
        /* EXEC SQL for :lMaxFetch 
             FETCH Cur_OfCentrales INTO
                   :szhCodOficina; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )275;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[0] = (unsigned long )3;
        sqlstm.sqhsts[0] = (         int  )3;
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
        if (sqlca.sqlcode < 0) vSqlError();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {
            pCentrales = (stOficinas *) malloc(sizeof(stOficinas));
                        
            strcpy(pCentrales->szCodOficina , szfnTrim(szhCodOficina [i]));

            pCentrales->sgte                = lstOfCentrales;
            lstOfCentrales                  = pCentrales;
        }
    }        
    /* EXEC SQL CLOSE Cur_OfCentrales; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )294;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE LLENA LA ESTRUCTURA PRINCIPAL (TASADOR) PARA LUEGO            */
/* PODER VALORAR LAS HABILITACIONES DE CMD_HABIL_PREPAGO                     */
/*---------------------------------------------------------------------------*/
stPrincipal * vLlenaTasador ()
{       
    stConceptosProc * raux;   
    stPrincipal     * pPrincipal;
	stPrincipal     * qaux;
    int         i;      
    short       iLastRows    = 0;       
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;
    long        lCantRegistros = 0;
                
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int	   	ihCodTipoRed ;
		char	szhCodPlanComis  [6];
        long    lhCodConcepto;
        double  dFechaInicio;
        double  dFechaTermino;
        char    szhCodTipComis   [3];
        long    lMaxFetch;
        char    szhTipEvaluacion [MAXFETCH][2];
        char    szhTipConcepto   [MAXFETCH][2];
        char	szhCodUniverso   [7];
    /* EXEC SQL END DECLARE SECTION; */ 


	pPrincipal 	= NULL;
	qaux 		= NULL;

    for (raux = lstConceptosProc; raux != NULL; raux = raux->sgte)
	{
		ihCodTipoRed           = raux->iCodTipoRed;
		lhCodConcepto          = raux->iCodConcepto;
        strcpy(szhCodPlanComis , raux->szCodPlanComis);
        strcpy(szhCodTipComis  , raux->szCodTipComis);
        strcpy(szhCodUniverso  , raux->szCodUniverso);
		
		iLastRows    = 0;            
		iFetchedRows = MAXFETCH;     
		iRetrievRows = MAXFETCH;     
		lMaxFetch = MAXFETCH; 
		
		fprintf(pfLog, "\n[vLlenaTasador] Carga Registros para TipoRed:[%d] PlanComis:[%s] Concepto:[%d] TipComis:[%s]\n", ihCodTipoRed, szhCodPlanComis, lhCodConcepto, szhCodTipComis);
        /* EXEC SQL DECLARE Cur_Tasador CURSOR FOR
        	SELECT  DISTINCT
					B.TIP_EVALUACION, 
                	K.TIP_CONCEPTO  
        	FROM    CM_CALIDAD_DOCUM_TD B, 
					VE_VENDEDORES       C,
                    VE_REDVENTAS_TD     A,
                	CMD_CONCEPTOS       K
        	WHERE   B.COD_TIPORED   = :ihCodTipoRed
			AND     B.COD_PLANCOMIS = :szhCodPlanComis
			AND     B.COD_CONCEPTO  = :lhCodConcepto
        	AND     B.COD_CONCEPTO  = K.COD_CONCEPTO
            AND     B.COD_TIPORED   = A.COD_TIPORED
            AND     A.COD_VENDEDOR  = C.COD_VENDEDOR
            AND     C.COD_TIPCOMIS  = :szhCodTipComis; */ 


        /* EXEC SQL OPEN Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0005;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )309;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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
        if (sqlca.sqlcode < 0) vSqlError();
}


        
        while(iFetchedRows == iRetrievRows)
        {
            /* EXEC SQL for :lMaxFetch 
                   FETCH Cur_Tasador INTO
                       :szhTipEvaluacion,
                       :szhTipConcepto; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 14;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )340;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhTipEvaluacion;
            sqlstm.sqhstl[0] = (unsigned long )2;
            sqlstm.sqhsts[0] = (         int  )2;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhTipConcepto;
            sqlstm.sqhstl[1] = (unsigned long )2;
            sqlstm.sqhsts[1] = (         int  )2;
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
            iLastRows    = sqlca.sqlerrd[2];
            
		    for (i=0; i < iRetrievRows; i++)
            {
                pPrincipal = (stPrincipal *) malloc(sizeof(stPrincipal));

        		pPrincipal->iCodTipoRed            	= ihCodTipoRed;                                                     
        		pPrincipal->iCodConcepto           	= lhCodConcepto;
				strcpy(pPrincipal->szCodTecnologia 	, raux->szCodTecnologia);

				strcpy(pPrincipal->szFecDesde		, raux->szFecDesde);
				strcpy(pPrincipal->szFecHasta		, raux->szFecHasta);

        		strcpy(pPrincipal->szCodPlanComis  	, szfnTrim(szhCodPlanComis));
        		strcpy(pPrincipal->szCodTipComis   	, szfnTrim(szhCodTipComis));
        		strcpy(pPrincipal->szTipoEvaluacion	, szfnTrim(szhTipEvaluacion[i]));
        		strcpy(pPrincipal->szTipConcepto   	, szfnTrim(szhTipConcepto[i]));
        		strcpy(pPrincipal->szCodUniverso   	, szfnTrim(szhCodUniverso));

                fprintf(pfLog, "\t[vLlenaTasador] TR:[%d] PlCom:[%s] Conc:[%d] TC:[%s] Tecno:[%s] Evalua:[%s] TipConcepto:[%s]\n",
                pPrincipal->iCodTipoRed, pPrincipal->szCodPlanComis, pPrincipal->iCodConcepto ,pPrincipal->szCodTipComis, pPrincipal->szCodTecnologia, pPrincipal->szTipoEvaluacion, pPrincipal->szTipConcepto );  

                fprintf(stderr, "\t[vLlenaTasador] TR:[%d] PlCom:[%s] Conc:[%d] TC:[%s] Tecno:[%s] Evalua:[%s] TipConcepto:[%s]\n",
                pPrincipal->iCodTipoRed, pPrincipal->szCodPlanComis, pPrincipal->iCodConcepto ,pPrincipal->szCodTipComis, pPrincipal->szCodTecnologia, pPrincipal->szTipoEvaluacion, pPrincipal->szTipConcepto );  
		       	pPrincipal->iContador     = 0;
		
        		pPrincipal->sgte_evento	= NULL;
	        	pPrincipal->sgte_plan	= NULL;
        		pPrincipal->sgte		= qaux;                 
        		qaux					= pPrincipal;

		        lCantRegistros++;
			}
        }
        /* EXEC SQL CLOSE Cur_Tasador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )363;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
        if (sqlca.sqlcode < 0) vSqlError();
}


    }
    fprintf(pfLog,"[vLlenaTasador] Cantidad de Registros:[%ld]\n",lCantRegistros);
    fprintf(stderr,"[vLlenaTasador] Cantidad de Registros:[%ld]\n",lCantRegistros);
    return qaux;
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE OBTIENE EL MONTO DE COMISION CORRESPONDIENTE            */
/*---------------------------------------------------------------------------*/
double lGetImporte(stPlazos * paux, int iCantDias, char * szTipoOficina )
{
    stPlazos        * qaux;

    int             iContinue       = 0;
    double          dImporte        = 0.0;
        
    qaux = paux;

    if (qaux == NULL)
       return(0);

    if ((iCantDias <= qaux->iDiasDesde)&&(strcmp(qaux->szTipoOficina, szTipoOficina) == 0))
    {
        return(qaux->dImpComision);
    }       
       
    while (iContinue == 0)
    {       
        if (((iCantDias > qaux->iDiasDesde) && (iCantDias <= qaux->iDiasHasta))||(qaux->iDiasHasta == -1))      
           if (strcmp(qaux->szTipoOficina, szTipoOficina) == 0)
           {
              dImporte = qaux->dImpComision;
              iContinue = -1;
           }
           else
           {
              qaux = qaux->sgte;
              if (qaux==NULL)
              {
                  iContinue = -1;
                  dImporte  = 0.0;
              }
           }       
        else
        {
           qaux = qaux->sgte;
           if (qaux==NULL)
           {
              iContinue = -1;
              dImporte  = 0.0;
           }      
        }
    }
    fprintf(pfLog," \n\t [lGetImporte]  Retorna Comision :[%f]\n", dImporte);
    return(dImporte);
}
/*---------------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE VERIFICA LA FECHA DE VENTA VERSUS LA FECHA DE VIGENCIA, Y EL  */
/* TIPO DE COMISIONISTA HABILITADO VERSUS EL DEL TASADOR.                          */
/*---------------------------------------------------------------------------------*/
int bfnCondicion(stHabilitado * pHabilitado, stPrincipal * pPrincipal)
{
	if (!bValidaFechaEvento(pPrincipal->szFecDesde, pPrincipal->szFecHasta, pHabilitado->szFechaVenta))
	{
		fprintf(stderr, "\n[bfnCondicion] Evento fuera de Vigencia. NumGral:[%ld] Desde:[s] Hasta:[%s] Evento:[%s]\n",pHabilitado->lNumGeneral, pPrincipal->szFecDesde, pPrincipal->szFecHasta, pHabilitado->szFechaVenta );
		return (FALSE);
	}

    if ( (strcmp(pPrincipal->szCodTipComis 	, pHabilitado->szCodTipComis)== 0)&&(pPrincipal->iCodTipoRed 			== pHabilitado->iCodTipoRed))      
		return (TRUE);
    else
		return (FALSE);
}

/*---------------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE VERIFICA LA CONDICION PARA EL OPTAR A GENERAR UN NUEVO EVENTO */
/*---------------------------------------------------------------------------------*/
stPlanes * stBuscaPlanCte(stHabilitado * paux, stPlanes * qaux, char * szCodTecnologia)
{
	if (qaux == NULL)
		return NULL;
	
	if ((strcmp(qaux->szTipPlan        , "TODAS"   ) == 0) && 
        (strcmp(qaux->szCodCategCliente, "TODAS"   ) == 0) &&
        (strcmp(szCodTecnologia        , "NOTECNO" ) == 0))
       return qaux;

    if ((strcmp(qaux->szTipPlan         , paux->szTipPlan        ) == 0) && 
        (strcmp(qaux->szCodCategCliente , paux->szCodCategCliente) == 0) &&   
        ((strcmp(szCodTecnologia , "NOTECNO") == 0)||((strcmp(szCodTecnologia , paux->szCodTecnologia) == 0))))
       return qaux;

	return stBuscaPlanCte(paux, qaux->sgte, szCodTecnologia);
}
/*---------------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE GENERA UN NUEVO EVENTO                                        */
/*---------------------------------------------------------------------------------*/
stEvento * GeneraEvento(stPrincipal * pPrincip, stHabilitado * pHabil, double dImporte )
{
    stEvento        * paux;
    stEvento        * qaux;
                   
    qaux = pPrincip->sgte_evento;
        
    paux = (stEvento *) malloc(sizeof(stEvento));                                                           
        
    paux->lNumGeneral       = pHabil->lNumGeneral;
    paux->iIndDocum         = pHabil->iIndDocum;
    paux->iCodConcepto      = pPrincip->iCodConcepto;
    paux->lCodComisionista  = pHabil->lCodComisionista;    
    strcpy(paux->szTipPlan         , pHabil->szTipPlan);
    strcpy(paux->szCodCategCliente , pHabil->szCodCategCliente);
    strcpy(paux->szCodOficina      , pHabil->szCodOficina);                                               
    strcpy(paux->szObsIncump       , pHabil->szObsIncump);
        
    paux->dImporte = dImporte;
        
    paux->sgte              = qaux;
    qaux                    = paux;
      
    return (qaux);        
}
/*---------------------------------------------------------------------------------*/
/* Busca en la lista de comisiones Diferenciada, el importe correspondiente        */
/*---------------------------------------------------------------------------------*/
double dImporteDiferenciada(stComDiferenciada * paux,stPrincipal * pPrincipal, stHabilitado * pHabilitado)
{
	if (paux == NULL)
		return -1.00;
	
	if ((paux->iCodTipoRed == pPrincipal->iCodTipoRed)&&
        (strcmp(paux->szCodPlanComis, pPrincipal->szCodPlanComis) == 0) &&
		(paux->iCodConcepto == pPrincipal->iCodConcepto) &&
        (strcmp(paux->szTipPlan, pHabilitado->szTipPlan) == 0) &&
        (strcmp(paux->szCodCategCliente, pHabilitado->szCodCategCliente) == 0) &&
		(paux->lCodComisionista == pHabilitado->lCodComisionista))
		return paux->dImpDiferenciado;
	else
		return (dImporteDiferenciada(paux->sgte    , pPrincipal, pHabilitado));
}
/*---------------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE EJECUTA EL CALCULO DE LA COMISION                             */
/*---------------------------------------------------------------------------------*/
void vValoraHabilitaciones()
{
    stHabilitado      * pHabilitado;
    stPrincipal       * pPrincipal;   
    stPlanes          * pPlanes;
	stComDiferenciada * pDiferenciada;
	

    int             iSwCalidad;
	double          dImporte;
    double          dImpPorCalidad;       
    double          dImpPorPlazo;
    long            iCantEventos=0;
    int             iSwPlazo;
    char			szhFecDesde[11];
	char			szhFecHasta[11];
	char			szhFecEvento[11];

    for (pHabilitado = lstHabilitado; pHabilitado != NULL; pHabilitado = pHabilitado->sgte)         
    {
    	fprintf(pfLog ,"\n[vValoraHabilitaciones] Evento:[%ld] Cliente:[%s] Plan:[%s] DiasHabiles[%d] IndDocum:[%d]\n",pHabilitado->lNumGeneral, pHabilitado->szCodCategCliente,pHabilitado->szTipPlan, pHabilitado->iNumDiasHabiles, pHabilitado->iIndDocum);
        fprintf(stderr,"\n[vValoraHabilitaciones] Evento:[%ld] Cliente:[%s] Plan:[%s] DiasHabiles[%d] IndDocum:[%d]\n",pHabilitado->lNumGeneral, pHabilitado->szCodCategCliente,pHabilitado->szTipPlan, pHabilitado->iNumDiasHabiles, pHabilitado->iIndDocum);
        for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)        
        { 
		    if (bfnCondicion(pHabilitado, pPrincipal))
		    {
				/*************************** C = x Calidad   *******************************/
				/* (pHabilitado->iInd_Docum  == 1)  Si es buena calidad de Documentacion.  */
				/*************************** C = x Calidad   *******************************/
		       
				if (strcmp(pPrincipal->szTipoEvaluacion, "C") == 0)     
				{
					fprintf(pfLog ,"\t (bfnValoraHabilitaciones) Por Calidad Concepto:[%d]\n", pPrincipal->iCodConcepto);
					fprintf(stderr,"\t (bfnValoraHabilitaciones) Por Calidad Concepto:[%d]\n", pPrincipal->iCodConcepto);
					
					pPlanes = stBuscaPlanCte(pHabilitado, pPrincipal->sgte_plan, pPrincipal->szCodTecnologia);
					if (pPlanes == NULL)
					{
					  fprintf(pfLog ,"\t [vValoraHabilitaciones] No existe combinacion en Lista de Planes/Cat.Cliente Asociada. Se Ignora.\n", pPrincipal->iCodConcepto, pPrincipal->szCodTipComis);
					  fprintf(stderr,"\t [vValoraHabilitaciones] No existe combinacion en Lista de Planes/Cat.Cliente Asociada. Se Ignora.\n", pPrincipal->iCodConcepto, pPrincipal->szCodTipComis);
					}
					else
					{
						if (((strcmp(pPrincipal->szTipConcepto ,"P")!=0)&&(pHabilitado->iIndDocum  == 1))||
						   ((strcmp(pPrincipal->szTipConcepto ,"P")==0)&&(pHabilitado->iIndDocum != 1)))
						{
							dImpPorCalidad = pPlanes->dImpComision;
							dImporte = dImporteDiferenciada(lstComDiferenciada , pPrincipal, pHabilitado);
							if (dImporte != -1.00)
							{
								dImpPorCalidad = dImporte ;
							}
						}
						else
						{
							dImpPorCalidad = 0.00;
						}
         			   	pPrincipal->sgte_evento = GeneraEvento(pPrincipal, pHabilitado, dImpPorCalidad);
                       	iCantEventos++;
                       	fprintf(pfLog ,"[vValoraHabilitaciones] Se Valoriza en :[%f]\n", dImpPorCalidad);
                       	fprintf(stderr,"[vValoraHabilitaciones] Se Valoriza en :[%f]\n", dImpPorCalidad);
					}                                
				}
				/*************************** P = x Plazos    *******************************/             
				if (strcmp(pPrincipal->szTipoEvaluacion, "P") == 0)   
				{
					fprintf(pfLog ,"\t [vValoraHabilitaciones] Por Plazo Concepto:[%d]\n", pPrincipal->iCodConcepto);
					fprintf(stderr,"\t [vValoraHabilitaciones] Por Plazo Concepto:[%d]\n", pPrincipal->iCodConcepto);
					
					pPlanes = stBuscaPlanCte(pHabilitado, pPrincipal->sgte_plan, pPrincipal->szCodTecnologia);
					if (pPlanes == NULL)
					{
						fprintf(pfLog ,"\t [vValoraHabilitaciones] No existe combinacion en Lista de Planes/Cat.Cliente Asociada. Se Ignora.\n", pPrincipal->iCodConcepto, pPrincipal->szCodTipComis);
						fprintf(stderr,"\t [vValoraHabilitaciones] No existe combinacion en Lista de Planes/Cat.Cliente Asociada. Se Ignora.\n", pPrincipal->iCodConcepto, pPrincipal->szCodTipComis);
					}                                       
		           	else
					{
						dImpPorPlazo = lGetImporte(pPlanes->sgte_plazo, pHabilitado->iNumDiasHabiles, pHabilitado->szTipoOficina);
						dImporte = dImporteDiferenciada(lstComDiferenciada , pPrincipal, pHabilitado);
						if (dImporte == 0.00)		
						{						
								dImpPorPlazo = 0.00;
	                  	}
	                  	pPrincipal->sgte_evento = GeneraEvento(pPrincipal, pHabilitado, dImpPorPlazo);
	                  	iCantEventos++;
	                  	fprintf(pfLog ," [vValoraHabilitaciones] Se Valoriza en :[%f]\n", dImpPorPlazo); 
	                  	fprintf(stderr," [vValoraHabilitaciones] Se Valoriza en :[%f]\n", dImpPorPlazo); 
					}
				}
			}
		}
	}
	fprintf(pfLog ,"\n\n[vValoraHabilitaciones] CANTIDAD DE EVENTOS VALORADOS:[%ld]\n", iCantEventos);
	fprintf(stderr,"\n\n[vValoraHabilitaciones] CANTIDAD DE EVENTOS VALORADOS:[%ld]\n", iCantEventos);
	stStatusProc.lCantEHabilitaciones = iCantEventos;
}
/*-----------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE INSERTA LOS EVENTOS OBTENIDOS EN LA TABLA CMT_VALORIZADOS */
/*-----------------------------------------------------------------------------*/
void vInsertaValorizados()
{
    stPrincipal     * pPrincipal;
    stEvento        * pEvento;

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
   

    lhCodPeriodo         = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo  , stCiclo.szIdCiclComis);

    for (pPrincipal = lstPrincipal; pPrincipal != NULL; pPrincipal = pPrincipal->sgte)             
    {       
        strcpy(szhCodUniverso , pPrincipal->szCodUniverso);
        strcpy(szhCodTipComis , pPrincipal->szCodTipComis);
        ihCodTipoRed          = pPrincipal->iCodTipoRed;

        if (pPrincipal->sgte_evento != NULL)
        {
            for (pEvento = pPrincipal->sgte_evento; pEvento != NULL; pEvento = pEvento->sgte)
            {                                
                lhNumGeneral  		= pEvento->lNumGeneral;
                ihCodConcepto 		= pEvento->iCodConcepto;
                dhImpConcepto 		= fnCnvDouble(pEvento->dImporte, 0);
        		lhCodComisionista	= pEvento->lCodComisionista;
                /* EXEC SQL INSERT INTO CMT_VALORIZADOS                                          
                         (NUM_GENERAL     , COD_UNIVERSO, 
                          COD_CONCEPTO    , COD_TIPCOMIS,
                          COD_COMISIONISTA, COD_PERIODO ,
                          ID_PERIODO      , IMP_CONCEPTO, 
						  COD_TIPORED)                                
                  VALUES (:lhNumGeneral     , :szhCodUniverso,
                          :ihCodConcepto    , :szhCodTipComis, 
                          :lhCodComisionista, :lhCodPeriodo  ,
                          :szhIdPeriodo     , :dhImpConcepto , 
                          :ihCodTipoRed); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 14;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into CMT_VALORIZADOS (NUM_GENERAL,COD_\
UNIVERSO,COD_CONCEPTO,COD_TIPCOMIS,COD_COMISIONISTA,COD_PERIODO,ID_PERIODO,IMP\
_CONCEPTO,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )378;
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



            }                                                                                
        }                                                                                
    }
}
/*---------------------------------------------------------------------------*/
/* Gestiona la carga de	Conceptos y Parámetros de Valoración		         */
/*---------------------------------------------------------------------------*/
int bCargaConceptos()
{
	switch (stCiclo.cTipCiclComis)
	{
		case PERIODICO:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "[bCargaConceptos] Carga lista de conceptos para ejecucion Periodica o Normal..\n\n");  
		    fprintf(stderr, "[bCargaConceptos] Carga lista de conceptos para ejecucion Periodica o Normal...\n\n");  
		    lstConceptosProc = stGetConceptosPer(FORMACOMIS,stCiclo);
		    return TRUE;
		case ESPORADICO:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "[bCargaConceptos] Carga lista de conceptos para ejecucion Esporadica	o Promocional..\n\n");	
		    fprintf(stderr, "[bCargaConceptos] Carga lista de conceptos para ejecucion Esporadica	o Promocional...\n\n");	 
		    lstConceptosProc = stGetConceptosProm(FORMACOMIS,stCiclo);
		    return TRUE;
		default:
		    vFechaHora();										    
		    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
		    fprintf(pfLog , "[bCargaConceptos] Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    fprintf(stderr, "[bCargaConceptos] Error, Forma de Ejecucion:[%c] No reconocida..\n\n", stCiclo.cTipCiclComis);  
		    return FALSE;
	}	
}
/*---------------------------------------------------------------------------*/
/* Rutina que ingresa las comisiones diferenciadas.                          */
/*---------------------------------------------------------------------------*/
stComDiferenciada * stCargaComDiferenciada()
{
    stComDiferenciada 	* paux;
    stComDiferenciada 	* qaux;
    
	int             i;      
    short           iLastRows    = 0;       
    int             iFetchedRows = MAXFETCH;
    int             iRetrievRows = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed   [MAXFETCH]   ;		
		char	szhCodPlanComis[MAXFETCH][6];	
    	int     ihCodConcepto  [MAXFETCH]   ;
    	char    szhTipPlan     [MAXFETCH][7];   
    	char    szhCodCategCliente[MAXFETCH][11];
    	long    lhCodComisionista [MAXFETCH];
    	double  dhImpDiferenciado [MAXFETCH];

	    long	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	paux      = NULL;
	qaux      = NULL;

	lMaxFetch = MAXFETCH;

    /* EXEC SQL DECLARE CUR_ComDiferenciada CURSOR FOR SELECT  
			COD_TIPORED      , 
			COD_PLANCOMIS    ,
			COD_CONCEPTO     , 
			TIP_PLAN         , 
			COD_CATEGCLIENTE ,
			COD_VENDEDOR     , 
			IMP_DIFERENCIADO  
   	   FROM CM_DIFDOCUMENTACION_TD
      ORDER BY COD_VENDEDOR; */ 


	/* EXEC SQL OPEN CUR_ComDiferenciada; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )429;
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
		/* EXEC SQL FOR :lMaxFetch FETCH   CUR_ComDiferenciada INTO
				ihCodTipoRed       ,
				szhCodPlanComis    , 
    			ihCodConcepto      , 
    			szhTipPlan         , 
    			szhCodCategCliente , 
    			lhCodComisionista  , 
    			dhImpDiferenciado  ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )444;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipoRed;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanComis;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )6;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ihCodConcepto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhTipPlan;
  sqlstm.sqhstl[3] = (unsigned long )7;
  sqlstm.sqhsts[3] = (         int  )7;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodCategCliente;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )11;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)lhCodComisionista;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )sizeof(long);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)dhImpDiferenciado;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[6] = (         int  )sizeof(double);
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
        	paux = (stComDiferenciada *) malloc (sizeof(stComDiferenciada));
                	
            paux->iCodTipoRed 	           = ihCodTipoRed[i];
            paux->iCodConcepto             = ihCodConcepto[i];
            paux->lCodComisionista         = lhCodComisionista[i];
            paux->dImpDiferenciado         = dhImpDiferenciado[i];

    		strcpy(paux->szCodPlanComis    , szhCodPlanComis[i]);
    		strcpy(paux->szTipPlan         , szhTipPlan[i]);
    		strcpy(paux->szCodCategCliente , szhCodCategCliente[i]);

            paux->sgte 	= qaux;
            qaux		= paux;
		}
	}
	/* EXEC SQL CLOSE CUR_ComDiferenciada; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )487;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	return qaux;
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE EVENTOS                               */
/*---------------------------------------------------------------------------*/
void vLiberaDatosEvento(stEvento * raux)
{
    stEvento * saux;
    if (raux!=NULL)
    {
        saux = raux->sgte;
        while (saux!=NULL)
        {
            free(raux);
            raux = saux;
            saux = raux->sgte;
        }
        if(raux!=NULL) free(raux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE PLANES                                */
/*---------------------------------------------------------------------------*/
void vLiberaDatosPlanes(stPlanes * qaux)
{
    stPlanes * saux;
    if (qaux!=NULL)
    {
        saux = qaux->sgte;
        while (saux!=NULL)
        {
            free(qaux);
            qaux = saux;
            saux = qaux->sgte;
        }
        if(qaux!=NULL) free(qaux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA PRINCIPAL (TASADOR)                      */
/*---------------------------------------------------------------------------*/
void vLiberaPrincipal(stPrincipal * paux)
{
    stPrincipal * raux;
    if (paux != NULL)
    {
        raux = paux->sgte;
        while (raux!=NULL)
        {
            vLiberaDatosPlanes(paux->sgte_plan);
            vLiberaDatosEvento(paux->sgte_evento);
            free(paux);
            paux = raux;
            raux = paux->sgte;
        }
        if(paux!=NULL) free(paux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE HABILITADOS                           */
/*---------------------------------------------------------------------------*/
void vLiberaDatosHabilitado(stHabilitado * taux)
{
    stHabilitado * saux;
    if (taux!=NULL)
    {
        saux = taux->sgte;
        while (saux!=NULL)
        {
            free(taux);
            taux = saux;
            saux = taux->sgte;
        }
        if(taux!=NULL) free(taux);
    }
}
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA USADA EN LA LISTA DE HABILITADOS                           */
/*---------------------------------------------------------------------------*/
void vLiberaComisionDiferenciada(stComDiferenciada * taux)
{
    stComDiferenciada * saux;
    if (taux!=NULL)
    {
        saux = taux->sgte;
        while (saux!=NULL)
        {
            free(taux);
            taux = saux;
            saux = taux->sgte;
        }
        if(taux!=NULL) free(taux);
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
    long    lSegIni, lSegFin, lSegProceso;
    int     ibiblio = 0;
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
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )502;
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
    fprintf(pfLog,  "Inicio procesamiento principal ...\n\n");
    fprintf(stderr, "Inicio procesamiento principal ...\n\n");
/*---------------------------------------------------------------------------*/
/* Carga Fechas que definen el Periodo                                       */
/*---------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Carga fechas que definen el periodo actual...\n\n");  
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
/* Carga Estructura de Conceptos y Tipos de Red	a Procesar...(Estándar)	    */
/*--------------------------------------------------------------------------*/
    vFechaHora();										    
    fprintf(pfLog , "\n\n%s\n",	(char *)pszFechaHora());		      
    fprintf(pfLog , "Gestiona Carga de Datos y Parametros..\n\n");  
    fprintf(stderr, "Gestiona Carga de Datos y Parametros...\n\n");  
	if (!bCargaConceptos())
	{
		fprintf(stderr,	"\nError Recuperando Lista de Conceptos	de comisiones.\n");
		fprintf(stderr,	"Revise	la parametrizacion.\n");
		fprintf(stderr,	"Proceso finalizado con	error.\n");
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"NO PUEDE	CARGAR LISTA DE	CONCEPTOS DE COMISION.",0,0));
	}    
/*---------------------------------------------------------------------------*/
/* Llena estructura de valoración de la documentación y plazos de entrega    */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Llena estructura de valoración de la documentación y plazos de entrega...\n\n");       
    fprintf(stderr, "Llena estructura de valoración de la documentación y plazos de entrega...\n\n");       
    lstPrincipal = vLlenaTasador();
/*---------------------------------------------------------------------------*/
/* Carga estructura de Planes, asociada a la valoracion                      */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de Planes, asociada a la valoracion...\n\n");       
    fprintf(stderr, "Carga estructura de Planes, asociada a la valoracion...\n\n");       
    vLlenaPlanes();
/*---------------------------------------------------------------------------*/
/* Carga estructura de Oficinas, consideradas como centrales (Plazos)        */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de Oficinas, consideradas como centrales (Plazos)...\n\n");       
    fprintf(stderr, "Carga estructura de Oficinas, consideradas como centrales (Plazos)...\n\n");   
    vLlenaOficinasCentrales();
/*---------------------------------------------------------------------------*/
/* Carga habilitaciones a evaluar                                            */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga habilitaciones a evaluar...\n\n");       
    fprintf(stderr, "Carga habilitaciones a evaluar...\n\n");       
    vLlenaHabilitaciones();
/*--------------------------------------------------------------------------*/
/* Carga Comisiones con Valoración Diferenciada                             */
/*--------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga Comisiones con valoracion Diferenciada...\n\n");
    fprintf(stderr, "Carga Comisiones con valoracion Diferenciada...\n\n");
    lstComDiferenciada = stCargaComDiferenciada();
/*---------------------------------------------------------------------------*/
/* Valora habilitaciones para calidad documentacion y plazos de entrega      */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Valora habilitaciones para calidad documentacion y plazos de entrega...\n\n");       
    fprintf(stderr, "Valora habilitaciones para calidad documentacion y plazos de entrega...\n\n"); 
    vValoraHabilitaciones();                                                                                     
/*---------------------------------------------------------------------------*/
/* Inserta registros en tabla de valorizados                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Inserta registros en tabla de valorizados...\n\n");       
    fprintf(stderr, "Inserta registros en tabla de valorizados...\n\n");    
    vInsertaValorizados();
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA.                                                 */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog , "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Libera memoria utilizada...\n\n");     
    fprintf(stderr, "Libera memoria utilizada...\n\n");             
    vLiberaPrincipal(lstPrincipal);
    vLiberaDatosHabilitado(lstHabilitado);
    vLiberaComisionDiferenciada(lstComDiferenciada);
    vLiberaConceptosVal(lstConceptosProc);
/*---------------------------------------------------------------------------*/
/* Recuperacion	de los segundos	reales ocupados	por el proceso.		     	 */
/*---------------------------------------------------------------------------*/
    lSegFin=lGetTimer();					  
    stStatusProc.lSegProceso = lSegFin - lSegIni;	
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion	estadistica del	proceso.		     		 */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog,  "\nEstadistica del proceso\n");								 
    fprintf(pfLog,	"------------------------\n");									 
    fprintf(pfLog,	"Segundos Reales Utilizados	     : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(pfLog,	"Cantidad de Eventos Valorizados : [%d]\n",stStatusProc.lCantEHabilitaciones);			       

    fprintf(stderr, "\nEstadistica del proceso\n");								 
    fprintf(stderr,	"------------------------\n");									 
    fprintf(stderr,	"Segundos Reales Utilizados	     : [%d]\n",stStatusProc.lSegProceso);				 
    fprintf(stderr,	"Cantidad de Eventos Valorizados : [%d]\n",stStatusProc.lCantEHabilitaciones);		       
																	       
    if (iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,0,"",stStatusProc.lSegProceso, stStatusProc.lCantEHabilitaciones))  
		exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_400,"NO SE PUDO CERRAR TRAZA OK.",0,0));					
    
    /* EXEC SQL COMMIT	WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )517;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}

													                                                       
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

