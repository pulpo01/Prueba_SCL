
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
           char  filnam[18];
};
static struct sqlcxp sqlfpn =
{
    17,
    "./pc/Ext_Bajas.pc"
};


static unsigned int sqlctx = 6922691;


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
",NVL(CLI.TEF_CLIENTE1,'0') ,SIT.DES_SITUACION Situacion  from GA_ABOAMIST AB\
O ,GA_VENTAS VTAS ,GE_CLIENTES CLI ,GA_CAUSABAJA CAU ,TA_PLANTARIF TAP ,GA_SIT\
UABO SIT where ((((((((ABO.COD_PRODUCTO=:b0 and ABO.FEC_BAJA>TO_DATE(:b1,'YYYY\
MMDD')) and ABO.FEC_BAJA<=(TO_DATE(:b2,'YYYYMMDD')+1)) and ABO.COD_SITUACION=S\
IT.COD_SITUACION) and ABO.NUM_VENTA=VTAS.NUM_VENTA) and ABO.COD_PRODUCTO=CAU.C\
OD_PRODUCTO(+)) and ABO.COD_CAUSABAJA=CAU.COD_CAUSABAJA(+)) and ABO.COD_CLIENT\
E=CLI.COD_CLIENTE) and ABO.COD_PLANTARIF=TAP.COD_PLANTARIF)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,2584,0,9,176,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,
44,0,0,1,0,0,13,180,0,0,26,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,97,0,0,
163,0,0,1,0,0,15,267,0,0,0,0,0,1,0,
178,0,0,2,626,0,4,290,0,0,10,2,0,1,0,2,3,0,0,2,97,0,0,2,1,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,97,0,0,
233,0,0,3,48,0,1,659,0,0,0,0,0,1,0,
248,0,0,4,0,0,30,727,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las Bajas Prematuras x Canal Espec.*/ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Jueves 23 de Agosto del 2001.                                */
/* Fin   : Jueves 06 de Septiembre del 2001.                            */
/* Por Fabian Aedo R.                                                   */
/* Inicio: Miercoles 13 de Noviembre del 2002                           */
/* Fin:                                                                 */
/* Autor:                                                               */
/* Modificacion:                                                        */
/* Fecha:                                                               */
/* Autor:                                                               */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Ext_Bajas.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError_EXT(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char    szhUser[30]="";
   char    szhPass[30]="";
   char    szhSysDate[17]="";
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Lista de Archivos                                                         */
/*---------------------------------------------------------------------------*/
	stArchivo *lstArchivo = NULL;


/* -------------------------------------------------------------------------------------- */
/* Se extrae el universo DIRECTO inicial de registros a considerar para Comisiones.       */
/* -------------------------------------------------------------------------------------- */
void vSeleccionarUniverso()
{
    stUniverso 	* paux = NULL;
    long    	iCantidad    = 0;
	int         i;
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
		int	ihProdCelular;
	   	long    lMaxFetch ; 
		char    szhCodTipComis [3] ;
	    	char    szhFechaInicio [11];
	    	char    szhFechaTermino[11];
        	long    lhCodCliente      [MAXFETCH];
		char	szhNumContrato    [MAXFETCH][22];
		char	szhNomCliente	  [MAXFETCH][51];
		char	szhApeCliente	  [MAXFETCH][41];
		char	szhNumIdent	  [MAXFETCH][21];
		char	szhFecAltaCli	  [MAXFETCH][21];
		char	szhNumCelular	  [MAXFETCH][16];
		long	lhNumAbonado	  [MAXFETCH];
		char	szhNumSerie	  [MAXFETCH][26];
		char	szhFecVenta	  [MAXFETCH][21];
		char	szhFecBaja	  [MAXFETCH][21];
		char	szhFecUltMod	  [MAXFETCH][21];
		char	szhNomUsuario	  [MAXFETCH][31];
		char	szhCodCausaBaja	  [MAXFETCH][3];
		char	szhDesCausaBaja   [MAXFETCH][31];
		char	szhCodTecnologia  [MAXFETCH][8];
		long	lhNumVenta	  [MAXFETCH];
		long	lhCodVenDealer    [MAXFETCH];
		long	lhCodVendedor	  [MAXFETCH];
		char	szhIndEstVenta	  [MAXFETCH][3];
		char	szhServicio	  [MAXFETCH][20];
		char	szhCodPlanTarif   [MAXFETCH][4];
		char	szhDesPlanTarif   [MAXFETCH][31];
		char    szhNumTelefono1	  [MAXFETCH][16];
		int     ihCodCiclo	  [MAXFETCH];
		char    cSituacion	  [MAXFETCH][31]; 
    /* EXEC SQL END DECLARE SECTION; */ 
 
    strcpy(szhFechaInicio   , stArgsExt.szFecDesde);  
    strcpy(szhFechaTermino  , stArgsExt.szFecHasta); 
	fprintf(stderr, "\n[vSeleccionarUniverso]Parametros: Fec_Desde:[%s] Fec_Hasta:[%s]\n", szhFechaInicio, szhFechaTermino);
	ihProdCelular  = 1;
    lMaxFetch      = MAXFETCH;     
    
	/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR 
		SELECT
			ABO.COD_CLIENTE 							,
			NVL(VTAS.NUM_CONTRATO ,'S/N')						,
			CLI.NOM_CLIENTE 							,
			NVL(CLI.NOM_APECLIEN1,' ')||' '||NVL(CLI.NOM_APECLIEN2,' ') 		,
			CLI.NUM_IDENT 								,
			NVL(TO_CHAR(CLI.FEC_ACEPVENT, 'YYYYMMDD'), ' ')				,
			TO_CHAR(ABO.NUM_CELULAR)								,
			ABO.NUM_ABONADO								,
			NVL(ABO.NUM_IMEI, ABO.NUM_SERIE)								,
			TO_CHAR(NVL(VTAS.FEC_VENTA, ABO.FEC_ACEPVENTA), 'YYYYMMDD') 		,
			TO_CHAR(NVL(ABO.FEC_BAJA, VTAS.FEC_VENTA), 'YYYYMMDD') 			,
			TO_CHAR(NVL(ABO.FEC_ULTMOD, VTAS.FEC_VENTA), 'YYYYMMDD')		,
			VTAS.NOM_USUAR_VTA 							,
			NVL(ABO.COD_CAUSABAJA,'0')						,
			NVL(CAU.DES_CAUSABAJA,'SIN CAUSA')					,
			ABO.COD_TECNOLOGIA 							, 
			NVL(ABO.NUM_VENTA, 0)							,
			NVL(VTAS.COD_VENDEALER,0)						,
			VTAS.COD_VENDEDOR							,
			VTAS.IND_ESTVENTA	  						,
			DECODE(TAP.COD_TIPLAN, '1', 'PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO')  ,
			ABO.COD_PLANTARIF                                                       ,
			TAP.DES_PLANTARIF                                                       ,
			NVL(ABO.COD_CICLO,0)							,
			NVL(CLI.TEF_CLIENTE1,'0')  						,
			SIT.DES_SITUACION Situacion 
		FROM    GA_ABOCEL       ABO,
               	GA_VENTAS       VTAS,
	      	   	GE_CLIENTES	CLI,
	      	   	GA_CAUSABAJA    CAU, 
				TA_PLANTARIF    TAP,
				GA_SITUABO   	SIT 
       WHERE  ABO.COD_PRODUCTO  = :ihProdCelular
         AND  ABO.FEC_BAJA      > TO_DATE(:szhFechaInicio,'YYYYMMDD')
         AND  ABO.FEC_BAJA     <= TO_DATE(:szhFechaTermino,'YYYYMMDD') + 1
         AND  ABO.COD_SITUACION = SIT.COD_SITUACION
         AND  ABO.NUM_VENTA     = VTAS.NUM_VENTA
         AND  ABO.COD_PRODUCTO  = CAU.COD_PRODUCTO (+)
	 	 AND  ABO.COD_CAUSABAJA = CAU.COD_CAUSABAJA (+)
         AND  ABO.COD_CLIENTE   = CLI.COD_CLIENTE
	 	 AND  ABO.COD_PLANTARIF = TAP.COD_PLANTARIF
	   UNION SELECT
			ABO.COD_CLIENTE 							,
			NVL(VTAS.NUM_CONTRATO ,'S/N')						,
			CLI.NOM_CLIENTE 							,
			NVL(CLI.NOM_APECLIEN1,' ')||' '||NVL(CLI.NOM_APECLIEN2,' ') 		,
			CLI.NUM_IDENT 								,
			NVL(TO_CHAR(CLI.FEC_ACEPVENT, 'YYYYMMDD'), ' ')				,
			TO_CHAR(ABO.NUM_CELULAR)								,
			ABO.NUM_ABONADO								,
			NVL(ABO.NUM_IMEI, ABO.NUM_SERIE)								,
			TO_CHAR(NVL(VTAS.FEC_VENTA, ABO.FEC_ACEPVENTA), 'YYYYMMDD') 		,
			TO_CHAR(NVL(ABO.FEC_BAJA, VTAS.FEC_VENTA), 'YYYYMMDD') 			,
			TO_CHAR(NVL(ABO.FEC_ULTMOD, VTAS.FEC_VENTA), 'YYYYMMDD')		,
			VTAS.NOM_USUAR_VTA 							,
			NVL(ABO.COD_CAUSABAJA,'0')						,
			NVL(CAU.DES_CAUSABAJA,'SIN CAUSA')					,
			ABO.COD_TECNOLOGIA 							, 
			NVL(ABO.NUM_VENTA, 0)							,
			NVL(VTAS.COD_VENDEALER,0)						,
			VTAS.COD_VENDEDOR							,
			VTAS.IND_ESTVENTA	  						,
			DECODE(TAP.COD_TIPLAN, '1', 'PREPAGO', '2', 'POSPAGO', '3', 'HIBRIDO')  ,
			ABO.COD_PLANTARIF                                                       ,
			TAP.DES_PLANTARIF                                                       ,
			NVL(ABO.COD_CICLO,0)							,
			NVL(CLI.TEF_CLIENTE1,'0')  						,
			SIT.DES_SITUACION Situacion 
		FROM    GA_ABOAMIST     ABO,
               	GA_VENTAS       VTAS,
	      	   	GE_CLIENTES	    CLI,
	      	   	GA_CAUSABAJA    CAU, 
				TA_PLANTARIF    TAP,
				GA_SITUABO   	SIT 
       WHERE  ABO.COD_PRODUCTO  = :ihProdCelular
         AND  ABO.FEC_BAJA      > TO_DATE(:szhFechaInicio,'YYYYMMDD')
         AND  ABO.FEC_BAJA     <= TO_DATE(:szhFechaTermino,'YYYYMMDD') + 1
         AND  ABO.COD_SITUACION = SIT.COD_SITUACION
         AND  ABO.NUM_VENTA     = VTAS.NUM_VENTA
         AND  ABO.COD_PRODUCTO  = CAU.COD_PRODUCTO (+)
	 AND  ABO.COD_CAUSABAJA = CAU.COD_CAUSABAJA (+)
         AND  ABO.COD_CLIENTE   = CLI.COD_CLIENTE
	 AND  ABO.COD_PLANTARIF = TAP.COD_PLANTARIF; */ 


    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlbuft((void **)0, 
      "select ABO.COD_CLIENTE ,NVL(VTAS.NUM_CONTRATO,'S/N') ,CLI.NOM_CLIENTE\
 ,((NVL(CLI.NOM_APECLIEN1,' ')||' ')||NVL(CLI.NOM_APECLIEN2,' ')) ,CLI.NUM_I\
DENT ,NVL(TO_CHAR(CLI.FEC_ACEPVENT,'YYYYMMDD'),' ') ,TO_CHAR(ABO.NUM_CELULAR\
) ,ABO.NUM_ABONADO ,NVL(ABO.NUM_IMEI,ABO.NUM_SERIE) ,TO_CHAR(NVL(VTAS.FEC_VE\
NTA,ABO.FEC_ACEPVENTA),'YYYYMMDD') ,TO_CHAR(NVL(ABO.FEC_BAJA,VTAS.FEC_VENTA)\
,'YYYYMMDD') ,TO_CHAR(NVL(ABO.FEC_ULTMOD,VTAS.FEC_VENTA),'YYYYMMDD') ,VTAS.N\
OM_USUAR_VTA ,NVL(ABO.COD_CAUSABAJA,'0') ,NVL(CAU.DES_CAUSABAJA,'SIN CAUSA')\
 ,ABO.COD_TECNOLOGIA ,NVL(ABO.NUM_VENTA,0) ,NVL(VTAS.COD_VENDEALER,0) ,VTAS.\
COD_VENDEDOR ,VTAS.IND_ESTVENTA ,DECODE(TAP.COD_TIPLAN,'1','PREPAGO','2','PO\
SPAGO','3','HIBRIDO') ,ABO.COD_PLANTARIF ,TAP.DES_PLANTARIF ,NVL(ABO.COD_CIC\
LO,0) ,NVL(CLI.TEF_CLIENTE1,'0') ,SIT.DES_SITUACION Situacion  from GA_ABOCE\
L ABO ,GA_VENTAS VTAS ,GE_CLIENTES CLI ,GA_CAUSABAJA CAU ,TA_PLANTARIF TAP ,\
GA_SITUABO SIT where ((((((((ABO.COD_PRODUCTO=:b0 and ABO.FEC_BAJA>TO_DATE(:\
b1,'YYYYMMDD')) and ABO.FEC_BAJA<=(TO_DATE(");
    sqlbuft((void **)0, 
      ":b2,'YYYYMMDD')+1)) and ABO.COD_SITUACION=SIT.COD_SITUACION) and ABO.\
NUM_VENTA=VTAS.NUM_VENTA) and ABO.COD_PRODUCTO=CAU.COD_PRODUCTO(+)) and ABO.\
COD_CAUSABAJA=CAU.COD_CAUSABAJA(+)) and ABO.COD_CLIENTE=CLI.COD_CLIENTE) and\
 ABO.COD_PLANTARIF=TAP.COD_PLANTARIF) union select ABO.COD_CLIENTE ,NVL(VTAS\
.NUM_CONTRATO,'S/N') ,CLI.NOM_CLIENTE ,((NVL(CLI.NOM_APECLIEN1,' ')||' ')||N\
VL(CLI.NOM_APECLIEN2,' ')) ,CLI.NUM_IDENT ,NVL(TO_CHAR(CLI.FEC_ACEPVENT,'YYY\
YMMDD'),' ') ,TO_CHAR(ABO.NUM_CELULAR) ,ABO.NUM_ABONADO ,NVL(ABO.NUM_IMEI,AB\
O.NUM_SERIE) ,TO_CHAR(NVL(VTAS.FEC_VENTA,ABO.FEC_ACEPVENTA),'YYYYMMDD') ,TO_\
CHAR(NVL(ABO.FEC_BAJA,VTAS.FEC_VENTA),'YYYYMMDD') ,TO_CHAR(NVL(ABO.FEC_ULTMO\
D,VTAS.FEC_VENTA),'YYYYMMDD') ,VTAS.NOM_USUAR_VTA ,NVL(ABO.COD_CAUSABAJA,'0'\
) ,NVL(CAU.DES_CAUSABAJA,'SIN CAUSA') ,ABO.COD_TECNOLOGIA ,NVL(ABO.NUM_VENTA\
,0) ,NVL(VTAS.COD_VENDEALER,0) ,VTAS.COD_VENDEDOR ,VTAS.IND_ESTVENTA ,DECODE\
(TAP.COD_TIPLAN,'1','PREPAGO','2','POSPAGO','3','HIBRIDO') ,ABO.COD_PLANTARI\
F ,TAP.DES_PLANTARIF ,NVL(ABO.COD_CICLO,0) ");
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihProdCelular;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&ihProdCelular;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFechaInicio;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFechaTermino;
    sqlstm.sqhstl[5] = (unsigned long )11;
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
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}

 

    while (iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch 
        	FETCH cur_universo INTO
                :lhCodCliente       ,
                :szhNumContrato     ,
				:szhNomCliente		,
				:szhApeCliente		,
				:szhNumIdent		,
				:szhFecAltaCli		,
				:szhNumCelular		,
				:lhNumAbonado		,
				:szhNumSerie        ,
				:szhFecVenta		,
				:szhFecBaja			,
				:szhFecUltMod		,
				:szhNomUsuario		,
                :szhCodCausaBaja    ,
                :szhDesCausaBaja	,
                :szhCodTecnologia	,
                :lhNumVenta			,
                :lhCodVenDealer		,
                :lhCodVendedor		,
                :szhIndEstVenta		,
                :szhServicio        ,
                :szhCodPlanTarif    ,
                :szhDesPlanTarif    ,
                :ihCodCiclo         ,
                :szhNumTelefono1    ,
                :cSituacion             ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 26;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )44;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhNumContrato;
  sqlstm.sqhstl[1] = (unsigned long )22;
  sqlstm.sqhsts[1] = (         int  )22;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhNomCliente;
  sqlstm.sqhstl[2] = (unsigned long )51;
  sqlstm.sqhsts[2] = (         int  )51;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhApeCliente;
  sqlstm.sqhstl[3] = (unsigned long )41;
  sqlstm.sqhsts[3] = (         int  )41;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhNumIdent;
  sqlstm.sqhstl[4] = (unsigned long )21;
  sqlstm.sqhsts[4] = (         int  )21;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecAltaCli;
  sqlstm.sqhstl[5] = (unsigned long )21;
  sqlstm.sqhsts[5] = (         int  )21;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhNumCelular;
  sqlstm.sqhstl[6] = (unsigned long )16;
  sqlstm.sqhsts[6] = (         int  )16;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )sizeof(long);
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[8] = (unsigned long )26;
  sqlstm.sqhsts[8] = (         int  )26;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhFecVenta;
  sqlstm.sqhstl[9] = (unsigned long )21;
  sqlstm.sqhsts[9] = (         int  )21;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhFecBaja;
  sqlstm.sqhstl[10] = (unsigned long )21;
  sqlstm.sqhsts[10] = (         int  )21;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhFecUltMod;
  sqlstm.sqhstl[11] = (unsigned long )21;
  sqlstm.sqhsts[11] = (         int  )21;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhNomUsuario;
  sqlstm.sqhstl[12] = (unsigned long )31;
  sqlstm.sqhsts[12] = (         int  )31;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhCodCausaBaja;
  sqlstm.sqhstl[13] = (unsigned long )3;
  sqlstm.sqhsts[13] = (         int  )3;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhDesCausaBaja;
  sqlstm.sqhstl[14] = (unsigned long )31;
  sqlstm.sqhsts[14] = (         int  )31;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[15] = (unsigned long )8;
  sqlstm.sqhsts[15] = (         int  )8;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[16] = (         int  )sizeof(long);
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)lhCodVenDealer;
  sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[17] = (         int  )sizeof(long);
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)lhCodVendedor;
  sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[18] = (         int  )sizeof(long);
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhIndEstVenta;
  sqlstm.sqhstl[19] = (unsigned long )3;
  sqlstm.sqhsts[19] = (         int  )3;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhServicio;
  sqlstm.sqhstl[20] = (unsigned long )20;
  sqlstm.sqhsts[20] = (         int  )20;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhCodPlanTarif;
  sqlstm.sqhstl[21] = (unsigned long )4;
  sqlstm.sqhsts[21] = (         int  )4;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhDesPlanTarif;
  sqlstm.sqhstl[22] = (unsigned long )31;
  sqlstm.sqhsts[22] = (         int  )31;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)ihCodCiclo;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[23] = (         int  )sizeof(int);
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhNumTelefono1;
  sqlstm.sqhstl[24] = (unsigned long )16;
  sqlstm.sqhsts[24] = (         int  )16;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)cSituacion;
  sqlstm.sqhstl[25] = (unsigned long )31;
  sqlstm.sqhsts[25] = (         int  )31;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
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
  if (sqlca.sqlcode < 0) vSqlError_EXT();
}



	fprintf(stderr, "\n\tPaso el Fetch...");                  

			iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows    = sqlca.sqlerrd[2];
                
            for (i=0; i < iRetrievRows; i++)
            {                
                       paux = (stUniverso *) malloc(sizeof(stUniverso));
                       paux->lCodCliente            = lhCodCliente[i];
                strcpy(paux->szNumContrato   , szfnTrim(szhNumContrato[i]));
                strcpy(paux->szNomCliente    , szfnTrim(szhNomCliente[i]));
                strcpy(paux->szCompania      , szfnTrim(szhNomCliente[i]));
                strcpy(paux->szApeCliente    , szfnTrim(szhApeCliente[i]));
                strcpy(paux->szNumIdent      , szfnTrim(szhNumIdent[i]));
                strcpy(paux->szNumRuc        , szfnTrim(szhNumIdent[i]));
                strcpy(paux->szFecAltaCli    , szfnTrim(szhFecAltaCli[i]));
                strcpy(paux->szNumCelular    , szfnTrim(szhNumCelular[i]));
                       paux->lNumAbonado     = lhNumAbonado[i];
                strcpy(paux->szNumSerie      , szfnTrim(szhNumSerie[i]));
                strcpy(paux->szFecVenta      , szfnTrim(szhFecVenta[i]));
                strcpy(paux->szFecBaja       , szfnTrim(szhFecBaja[i]));
                strcpy(paux->szFecUltMod     , szfnTrim(szhFecUltMod[i]));
                strcpy(paux->szNomUsuario    , szfnTrim(szhNomUsuario[i]));
                strcpy(paux->szCodCausaBaja  , szfnTrim(szhCodCausaBaja[i]));
                strcpy(paux->szDesCausaBaja  , szfnTrim(szhDesCausaBaja[i]));
                strcpy(paux->szCodTecnologia , szfnTrim(szhCodTecnologia[i]));
                       paux->lNumVenta       = lhNumVenta[i];
                       paux->lCodVenDealer   = lhCodVenDealer[i];
                       paux->lCodVendedor    = lhCodVendedor[i];
                strcpy(paux->szIndEstVenta   , szfnTrim(szhIndEstVenta[i]));
                strcpy(paux->szServicio      , szfnTrim(szhServicio[i]));
                strcpy(paux->szCodPlanTarif  , szfnTrim(szhCodPlanTarif[i]));
                strcpy(paux->szDesPlanTarif  , szfnTrim(szhDesPlanTarif[i]));
                strcpy(paux->szNumTelefono1  , szfnTrim(szhNumTelefono1[i]));
                       paux->iCodCiclo 	     = ihCodCiclo[i];
                strcpy(paux->cSituacion      , szfnTrim(cSituacion           [i] ));
                paux->cIndConsidera			 = 'S';
                
				if (ifnCargaDireccion(paux->lCodCliente, 1, &stDireccion))
				{
					strcpy(paux->cDireccion      , stDireccion.szDireccion);
					strcpy(paux->szMTX           , stDireccion.szCodRegion);
					strcpy(paux->szDesCiudad     , stDireccion.szDesCiudad);
					strcpy(paux->szDesProvincia  , stDireccion.szDesProvincia);
					strcpy(paux->szCodCiudad     , stDireccion.szCodCiudad);
					strcpy(paux->szFranquicia    , stDireccion.szDesCiudad);
				}
				else
					paux->cIndConsidera			 = 'N';

				if (!ifnCargaDatosEquipo(paux))
					paux->cIndConsidera			 = 'N';
				
                paux->sgte 					 = lstUniverso;
                lstUniverso 				 = paux;
                iCantidad++;                
            }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )163;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    fprintf(pfLog, "\n(vSeleccionarUniverso)Tipo Comisionista:[%s] Cantidad de BAJAS Extraidas:[%ld].\n", szhCodTipComis, iCantidad);        
}
/* -------------------------------------------------------------------------------------- */
/* Carga los datos del equipo...                                                          */
/* -------------------------------------------------------------------------------------- */
int ifnCargaDatosEquipo(stUniverso * paux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhNumSerie			[26];
	    long    lhNumAbonado		    ;
   		long	lhCodArticulo		    ;
		char	szhDesArticulo      [41];
		char	ihTipArticulo           ;
		char	szhDesTipArticulo   [16];
		char	szhCodModelo        [16];
		int		ihCodFabricante         ;
		char	szhDesFabricante    [21];
		char    szhNumImei          [26];
	/* EXEC SQL END DECLARE SECTION; */ 

	
    lhNumAbonado      	= paux->lNumAbonado;
    strcpy(szhNumSerie 	, paux->szNumSerie);	
    /* EXEC SQL SELECT 
	         EQUI1.COD_ARTICULO,
	         ARTI.DES_ARTICULO,
	         ARTI.TIP_ARTICULO, 
	         TIPO.DES_TIPARTICULO, 
	         ARTI.COD_MODELO, 
	         ARTI.COD_FABRICANTE,
	         FABR.DES_FABRICANTE,
	         NVL(EQUI1.NUM_IMEI,'S/N')
         INTO 	:lhCodArticulo		 ,
		:szhDesArticulo      ,
		:ihTipArticulo       ,
		:szhDesTipArticulo   ,
		:szhCodModelo        ,
		:ihCodFabricante     ,
		:szhDesFabricante    ,
		:szhNumImei
         FROM	AL_FABRICANTES     FABR,
                AL_ARTICULOS       ARTI,
                GA_EQUIPABOSER     EQUI1,
		AL_TIPOS_ARTICULOS TIPO
         WHERE	EQUI1.NUM_ABONADO   = :lhNumAbonado
           AND  EQUI1.NUM_SERIE     = :szhNumSerie
           AND  EQUI1.FEC_ALTA =(SELECT  MAX(R.FEC_ALTA) FROM   GA_EQUIPABOSER R
                                   WHERE   R.NUM_ABONADO = EQUI1.NUM_ABONADO
                                   AND     R.NUM_SERIE   = EQUI1.NUM_SERIE)
           AND  EQUI1.COD_ARTICULO  = ARTI.COD_ARTICULO 
           AND  ARTI.COD_FABRICANTE = FABR.COD_FABRICANTE
		   AND  ARTI.TIP_ARTICULO   = TIPO.TIP_ARTICULO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select EQUI1.COD_ARTICULO ,ARTI.DES_ARTICULO ,ARTI.TIP_AR\
TICULO ,TIPO.DES_TIPARTICULO ,ARTI.COD_MODELO ,ARTI.COD_FABRICANTE ,FABR.DES_F\
ABRICANTE ,NVL(EQUI1.NUM_IMEI,'S/N') into :b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7  fro\
m AL_FABRICANTES FABR ,AL_ARTICULOS ARTI ,GA_EQUIPABOSER EQUI1 ,AL_TIPOS_ARTIC\
ULOS TIPO where (((((EQUI1.NUM_ABONADO=:b8 and EQUI1.NUM_SERIE=:b9) and EQUI1.\
FEC_ALTA=(select max(R.FEC_ALTA)  from GA_EQUIPABOSER R where (R.NUM_ABONADO=E\
QUI1.NUM_ABONADO and R.NUM_SERIE=EQUI1.NUM_SERIE))) and EQUI1.COD_ARTICULO=ART\
I.COD_ARTICULO) and ARTI.COD_FABRICANTE=FABR.COD_FABRICANTE) and ARTI.TIP_ARTI\
CULO=TIPO.TIP_ARTICULO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )178;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesArticulo;
    sqlstm.sqhstl[1] = (unsigned long )41;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihTipArticulo;
    sqlstm.sqhstl[2] = (unsigned long )1;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhDesTipArticulo;
    sqlstm.sqhstl[3] = (unsigned long )16;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodModelo;
    sqlstm.sqhstl[4] = (unsigned long )16;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodFabricante;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhDesFabricante;
    sqlstm.sqhstl[6] = (unsigned long )21;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[7] = (unsigned long )26;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[9] = (unsigned long )26;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
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
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}




	if (sqlca.sqlcode != SQLOK)
		return FALSE;
	
	paux->lCodArticulo				= lhCodArticulo                   ;
	paux->iTipArticulo              = ihTipArticulo                   ;
	paux->iCodFabricante          	= ihCodFabricante                 ;
	strcpy(paux->szDesArticulo      , szfnTrim(szhDesArticulo       ));
	strcpy(paux->szDesTipArticulo   , szfnTrim(szhDesTipArticulo    ));
	strcpy(paux->szCodModelo        , szfnTrim(szhCodModelo         ));
	strcpy(paux->szDesFabricante    , szfnTrim(szhDesFabricante     ));
	strcpy(paux->szNumImei          , szfnTrim(szhNumImei           ));
	
	return TRUE;

}

/* -------------------------------------------------------------------------------------- */
/* Rutina que devuelve la memoria utilizada por la lista de ventas.                       */
/* como pueden ser "n" ventas, se hará con while y no recursiva...                        */
/* -------------------------------------------------------------------------------------- */
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
			free(qaux);
			qaux = paux;
			paux = qaux->sgte;
		}
		if (qaux!=NULL)
			free(qaux);
	}
}

/* -------------------------------------------------------------------------------------- */
/* Rutina que busca un campo de detalle de archivo en una lista                           */
/* -------------------------------------------------------------------------------------- */
char szBuscaArchivo()
{
    stArchivo     *paux_archivos;
    stDetArchivo  *paux_det_archivo;
    stUniverso    *paux_venta;
    char          separador;       
    char	  	  szCampoArchivo[1024];
    char          szLineaArchivo[2048];
    char          szNomArchivo_dat[250] ;
    char          szNomArchivo_lst[250] ;
    int		  	  bRes;
    char	      *aux;
    char 	      szFmt[81];
    int		      iNumLineas = 0;
    int		      iNumArchivos = 0;
	
	for (paux_archivos = lstArchivo; paux_archivos != NULL; paux_archivos=paux_archivos->sgte)
    {
		/* Se tiene un archivo... se debe mandar a crearlo EL DAT*/
		sprintf(szDatName, "%s_%s", UNIVERSO, paux_archivos->szNomFisico);
		
		bGeneraArchivoExtractores(&pfDat, szDatName, pszEnvDat, szhSysDate, DAT, szNomArchivo_dat );
		if (pfDat==NULL)
		{
			fprintf(stderr, "\nError en Generacion de Archivo de Datos:[%s]", szNomArchivo_dat );
			fprintf(stderr, "Revise su existencia.\n");
			fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
			fprintf(stderr, "Proceso finalizado con error.\n");
			return (FALSE);
		}

		iNumLineas = 0;
    	iNumArchivos++;
    	/* primero se lista el encabezado del archivo */
		memset(szLineaArchivo, 0, sizeof(szLineaArchivo)); 
		for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
		{
	        aux = szFormatEtiqueta(paux_det_archivo);
        	sprintf(szCampoArchivo, "%s", aux);
            separador = paux_archivos->szCarSeparador[0];
			if (paux_det_archivo->sgte != NULL)
			{ 
				if (separador != 'X')
					sprintf(szLineaArchivo,"%s%s%c", szLineaArchivo,szCampoArchivo,separador);
				else
					sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
			}
			else
				sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
			free(aux);
		}
		fprintf(pfDat ,"%s\n", szLineaArchivo);
    	
        /* Se recorre el universo de datos... */
        for (paux_venta =lstUniverso ;paux_venta != NULL; paux_venta = paux_venta->sgte)
        {
	        if (paux_venta->cIndConsidera == 'S')
			{
				memset(szLineaArchivo, 0, sizeof(szLineaArchivo)); 
				for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
				{
		        	
		            aux = szBuscaDetalleCampoi(paux_venta, paux_det_archivo);
		            sprintf(szCampoArchivo, "%s", aux);
		            separador = paux_archivos->szCarSeparador[0];
					if (paux_det_archivo->sgte != NULL)
					{ 
						if (separador != 'X')
							sprintf(szLineaArchivo,"%s%s%c", szLineaArchivo,szCampoArchivo,separador);
						else
							sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
					}
					else
						sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
					free(aux);
				}
				iNumLineas++;
	            fprintf(pfDat ,"%s\n", szLineaArchivo);
			}
		}

		/* EL LST*/
		bGeneraArchivoExtractores(&pfLst, szDatName, pszEnvDat, szhSysDate, LST, szNomArchivo_lst);
		if(pfLst == NULL)
		{
			fprintf(stderr, "\nError en Generacion de Archivo de Datos:[%s]", szNomArchivo_lst );
			fprintf(stderr, "Revise su existencia.\n");
			fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
			fprintf(stderr, "Proceso finalizado con error.\n");
		}
		
		fprintf(stderr,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(stderr,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(stderr,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(stderr,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		fprintf(pfLog,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(pfLog,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(pfLog,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(pfLog,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		fprintf(pfLst,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(pfLst,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(pfLst,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(pfLst,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		fprintf(pfLst,"\nDetalle de Campos Listados:");
		fprintf(pfLst, "\n[COL][CAMPO                    ][ETIQUETA                 ][LEN][JUS][FIL][TYP]");
		
		for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
		{
			fprintf(pfLst, "\n[%-3d][%-25.25s][%-25.25s][%-3d][%-3.3s][%-3.3s][%-3.3s]",
			paux_det_archivo->iNumOrden, paux_det_archivo->szNomCampo, paux_det_archivo->szNomEtiqueta, paux_det_archivo->iLargoCampo,
			paux_det_archivo->szIndJustificado, paux_det_archivo->szCarRelleno, paux_det_archivo->szTipoDato);
		}

		fclose(pfLst);
		fclose(pfDat);
		/* Actualiza Traza de Archivos... */
		fprintf(pfLog ,"\nActualiza Trazas de Archivos: [%s]\n", szNomArchivo_dat);
		fprintf(stderr,"\nActualiza Trazas de Archivos: [%s]\n", szNomArchivo_dat);
		if (!ifnActualizaTrazasArchivos(paux_archivos->szNomFisico, UNIVERSO, stArgsExt.lNumSecuencia, szNomArchivo_dat, iNumLineas, getlogin()))
		{
			fprintf(pfLog ,"\nError Actualizando Trazas de Archivos.\n");
			fprintf(stderr,"\nError Actualizando Trazas de Archivos.\n");
		}
    }
    stStatusProc.lCantArchivos = iNumArchivos;
    return(TRUE);
}
/*****************************************************************************/
/* Rutina que busca un campo de detalle de archivo en una lista             */
/*****************************************************************************/
char *szBuscaDetalleCampoi(stUniverso    *paux,
                           stDetArchivo  *paux_det_archivo)
{    
    char   szCodCampo[31];
    char   *szResp;
    int    iLargoCampo = paux_det_archivo->iLargoCampo;
    char   szFormato[81];
    char   pszTipoDato[15];

    if (iLargoCampo == 0) iLargoCampo=8; /* para fechas, por si no vienen con largo */
    szResp = (char *) malloc(sizeof(iLargoCampo +1));
    if (!szResp) 
       fprintf(stderr, "[szBuscaDetalleCampoi] No se pudo asignar memoria a szResp        [%s]\n",paux_det_archivo->szNomCampo);
    memset(szResp,0,(iLargoCampo ));
    
	sprintf(szResp,szFormato, paux->szMTX              );
    
    strcpy(szCodCampo      , paux_det_archivo->szNomCampo);
    strcpy(pszTipoDato     , paux_det_archivo->szTipoDato);
	strcpy(szFormato	   , paux_det_archivo->szFormato);

   /*fprintf(stderr, "[szBuscaDetalleCampoi] Campo:[%s] 	szFormato:[%s]\n",szCodCampo, szFormato);*/


           if (strncmp( "COD_REGION"     ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szMTX              );
      else if (strncmp( "NUM_CONTRATO"   ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szNumContrato      );
      else if (strncmp( "NOM_CLIENTE"    ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->szNomCliente       );
      else if (strncmp( "NOM_APECLIEN1"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szApeCliente       );
      else if (strncmp( "DES_EMPRESA"    ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->szCompania         );
      else if (strncmp( "DIRECCION"      ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->cDireccion	      );
      else if (strncmp( "NUM_IDENT"      ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szNumIdent         );
      else if (strncmp( "NUM_RUC"        ,szfnTrim(szCodCampo),7  ) == 0)  sprintf(szResp,szFormato, paux->szNumIdent         );
      else if (strncmp( "FEC_ACEPVENT"   ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szFecAltaCli       );
      else if (strncmp( "NUM_CELULAR"    ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->szNumCelular        );
      else if (strncmp( "FEC_ALTA"       ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->szFecVenta         );
      else if (strncmp( "FEC_BAJA"       ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->szFecBaja          );
      else if (strncmp( "FEC_VENTA"      ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szFecUltMod        );
      else if (strncmp( "NOM_USUAR_VTA"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szNomUsuario       );
      else if (strncmp( "COD_CAUSABAJA"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szCodCausaBaja     );
      else if (strncmp( "DES_CAUSABAJA"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szDesCausaBaja     );
      else if (strncmp( "COD_TIPLAN"     ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szServicio	      );
      else if (strncmp( "COD_TECNOLOGIA" ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szCodTecnologia    );
      else if (strncmp( "TIP_TERMINAL"   ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->lCodArticulo       );
      else if (strncmp( "DES_TERMINAL"   ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szDesArticulo      );
      else if (strncmp( "COD_FABRICANTE" ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->iCodFabricante     );
      else if (strncmp( "DES_FABRICANTE" ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szDesFabricante    );
      else if (strncmp( "NUM_IMEI"       ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->szNumImei          );
      else if (strncmp( "COD_PLANTARIF"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szCodPlanTarif     );
      else if (strncmp( "DES_PLANTARIF"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szDesPlanTarif     );
      else if (strncmp( "COD_VENDEDOR"   ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->lCodVendedor       );
      else if (strncmp( "DES_CIUDAD"     ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szDesCiudad        );
      else if (strncmp( "DES_PROVINCIA"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szDesProvincia     );      
      else if (strncmp( "COD_FRANQUICIA" ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szCodCiudad        );
      else if (strncmp( "DES_FRANQUICIA" ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szFranquicia       );
      else if (strncmp( "COD_CICLO"      ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->iCodCiclo          );
      else if (strncmp( "NUM_SERIE"      ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szNumSerie         );
      else if (strncmp( "DES_SITUACION"  ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cSituacion	      );  
      /*else if (strncmp( "COD_CLIENTE"    ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->lCodCliente        );*/
      /*else if (strncmp( "MODELO"         ,szfnTrim(szCodCampo),6  ) == 0)  sprintf(szResp,szFormato, paux->szCodModelo        );*/
      /*else if (strncmp( "NUM_IMEI"       ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->szNumSerie         );*/
      else if (strncmp( "BLANCO"  		,szfnTrim(szCodCampo),6 ) == 0)  sprintf(szResp,szFormato, CARACBLANCO      		  );  
      
    if (szResp[0] == NULL){
        if (pszTipoDato[0] == 'N')
             sprintf(szResp,szFormato,0);
        else
             sprintf(szResp,szFormato," ");
    }
    
/*	fprintf(stderr, "[szBuscaDetalleCampoi] respuesta FINAL: [%s]\n",szResp);*/
    return (szResp);
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
    int     lSegIni, lSegFin ;
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
	memset(&stStatusProc, 0, sizeof(rg_estadistica));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
    memset(&stArgsExt, 0, sizeof(rg_argextractores));
    vManejaArgsExt(argc, argv);
    
    memset(&stDireccion, 0, sizeof(rg_direccion));
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "\nstArgsExt.szUser        [%s]\n", stArgsExt.szUser);
    fprintf(stderr, "\nstArgsExt.szPass        [%s]\n", stArgsExt.szPass);
    
    strcpy(szhUser, stArgsExt.szUser);                                                      
    strcpy(szhPass, stArgsExt.szPass);                                                    
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
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando ambiente para archivos de log ...\n");                    
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)                                               
    {                                                                                                                  
            exit(1);
    }                                                                                                                  

    fprintf(stderr, "Preparando ambiente para archivos de datos...\n");                    
    if((pszEnvDat = (char *)pszEnviron("XPCM_DAT", "")) == (char *)NULL)                                               
    {
            exit(1);
    }
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);                                         
    fprintf(stderr, "Directorio de Datos        : [%s]\n", (char *)pszEnvDat);                                         

/*---------------------------------------------------------------------------*/
/* GENERACION DEL NOMBRE Y CREACION DEL ARCHIVO DE LOG.                      */
/*---------------------------------------------------------------------------*/
    strncpy(szhSysDate, pszGetDateLog(),16); 
	fprintf(stderr, "\n[Principal] szhSysDate:[%s]", szhSysDate);
    bGeneraArchivoExtractores(&pfLog, LOGNAME, pszEnvLog, szhSysDate, LOG, szLogName);
    if(pfLog  == NULL)
    {
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);
        fprintf(stderr, "Revise su existencia.\n");
        fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
        fprintf(stderr, "Proceso finalizado con error.\n");
        exit(EXIT_03);                                                  
    }
/*---------------------------------------------------------------------------*/
/* HEADER.                                                                   */
/*---------------------------------------------------------------------------*/ 
    vFechaHora();                                                               
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog,  "%s\n", szRaya);                    
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "%s\n", GLOSA_PROG);                
    fprintf(pfLog,  "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog,  "Ultima Revision: [%s]\n", LAST_REVIEW);                
    fprintf(pfLog,  "%s\n\n", szRaya);                  

    fprintf(pfLog,  "\n Argumentos de Ejecucion\n");
    
    fprintf(pfLog,  "Fecha Desde        [%s]\n", stArgsExt.szFecDesde);
    fprintf(pfLog,  "Fecha Hasta        [%s]\n", stArgsExt.szFecHasta);
    fprintf(pfLog,  "Username unix   [%s](id = %d)\n", getlogin(), getuid());
    fprintf(pfLog,  "Base de datos   [%s]\n\n", (strcmp(getenv("ORACLE_SID"), "")!=0?getenv("ORACLE_SID"):getenv("TWO_TASK"))); 
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
    sqlstm.offset = (unsigned int  )233;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


/*---------------------------------------------------------------------------*/
/* ACTUALIZA TRAZA DE EXTRACTORES                                            */
/*---------------------------------------------------------------------------*/
/*    fprintf(pfLog ,"\n(Principal) Actualiza Traza de Extractores(iCREATRAZA): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);*/
/*    fprintf(stderr,"\n(Principal) Actualiza Traza de Extractores(iCREATRAZA): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);*/
/*	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 0, "X", iCREATRAZA);                                                          */
/*---------------------------------------------------------------------------*/
/* CARGA LISTA DE ARCHIVOS A GENERAR                                         */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga la definción de Archivos para universo:[%s].\n",UNIVERSO);
    fprintf(stderr,"\n(Principal) Carga la definción de Archivos para universo:[%s].\n",UNIVERSO);
    lstArchivo = stCargaDefArchivo(UNIVERSO);
    if (lstArchivo == NULL)
    {
	    fprintf(pfLog ,"\n(Principal) No Existen Archivos Configurados para este Universo:[%s].\n",UNIVERSO);
	    fprintf(stderr,"\n(Principal) No Existen Archivos Configurados para este Universo:[%s].\n",UNIVERSO);
    	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 10, "No hay Archivos Configurados.", iCIERRATRAZAOK);
		exit(EXIT_0);
    }
    vMuestraArchivo(lstArchivo);
/*---------------------------------------------------------------------------*/
/* CARGA REGISTROS DE BAJAS DEL PERIODO                                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga las Bajas entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde, stArgsExt.szFecHasta);
    fprintf(stderr,"\n(Principal) Carga las Bajas entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde, stArgsExt.szFecHasta);
    vSeleccionarUniverso();
    if (lstUniverso == NULL)
    {
	    fprintf(pfLog ,"\n(Principal) No Existen Eventos para Informar en el Periodo Desde:[%s] y Hasta:[%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
	    fprintf(stderr,"\n(Principal) No Existen Eventos para Informar en el Periodo Desde:[%s] y Hasta:[%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
    	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 10, "No Existen Eventos para Informar.", iCIERRATRAZAOK);
		exit(EXIT_0);
    }
/*---------------------------------------------------------------------------*/
/* PROCEDE A LA GENERACION DE LOS ARCHIVOS DE DATOS...                       */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Genera los Archivos de Datos.\n");
    fprintf(stderr,"\n(Principal) Genera los Archivos de Datos.\n");
    szBuscaArchivo(); 
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
    fprintf(pfLog, "Archivos Generados             : [%d]\n\n", stStatusProc.lCantArchivos);   
    fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);  
	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
    fprintf(stderr, "Archivos Generados             : [%d]\n\n", stStatusProc.lCantArchivos);  
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

/*---------------------------------------------------------------------------*/
    fprintf(pfLog ,"\n(Principal) Actualiza Traza de Extractores(iCIERRATRAZAOK): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);
    fprintf(stderr,"\n(Principal) Actualiza Traza de Extractores(iCIERRATRAZAOK): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);
	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 0, "", iCIERRATRAZAOK);

    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )248;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
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

