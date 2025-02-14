
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
    "./pc/Ext_ListoPack.pc"
};


static unsigned int sqlctx = 110803395;


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
" ,ABO.COD_VENDEDOR Vendedor ,NVL(ABO.COD_CICLO,0) Ciclo ,SIT.DES_SITUACION S\
ituacion  from GA_VENTAS VTAS ,GA_ABOAMIST ABO ,GE_CLIENTES CLI ,TA_PLANTARIF \
PLA ,GA_SITUABO SIT ,GED_CODIGOS COD where (((((((((((PLA.COD_PRODUCTO=ABO.COD\
_PRODUCTO and PLA.COD_PLANTARIF=ABO.COD_PLANTARIF) and SIT.COD_SITUACION=ABO.C\
OD_SITUACION) and ABO.FEC_ACTIVACION>=TO_DATE(:b0,'YYYYMMDD')) and ABO.FEC_ACT\
IVACION<=(TO_DATE(:b1,'YYYYMMDD')+1)) and ABO.NUM_VENTA=VTAS.NUM_VENTA) and AB\
O.COD_CLIENTE=CLI.COD_CLIENTE) and ABO.COD_PRODUCTO=:b2) and ABO.COD_SITUACION\
=COD.COD_VALOR) and COD.COD_MODULO='CM') and COD.NOM_TABLA='GA_ABOCEL') and CO\
D.NOM_COLUMNA='COD_SITUACION')           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,1687,0,9,142,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,
32,0,0,1,0,0,13,146,0,0,26,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,3,0,0,2,97,0,0,
151,0,0,1,0,0,15,245,0,0,0,0,0,1,0,
166,0,0,2,620,0,4,269,0,0,11,4,0,1,0,2,3,0,0,2,97,0,0,2,1,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
225,0,0,3,48,0,1,628,0,0,0,0,0,1,0,
240,0,0,4,0,0,30,690,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de extraer las ventas para comisiones, en archivos*/
/*     planos, orentado a procesos externos de comisiones (SADECOM)     */
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
#include "Ext_ListoPack.h"
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
		long    lNumVenta[MAXFETCH];
		long    lCodCliente[MAXFETCH];
		long    lNumAbonado[MAXFETCH];
		char    cContrato[MAXFETCH][22];     
		char    cNombre[MAXFETCH][51];
		char    cApellidos[MAXFETCH][50];
		char    cDesEmpresa[MAXFETCH][50];
		char    cCedula[MAXFETCH][21];
		char    cRuc[MAXFETCH][21];
		char    cFec_act_cuenta[MAXFETCH][30];
		char    cCelular[MAXFETCH][16];     
		char    cFec_act_tel[MAXFETCH][30];
		char    cFec_termino_tel[MAXFETCH][30];
		char    cFec_act_comp[MAXFETCH][30];
		char    cFec_termino_comp[MAXFETCH][30];
		char    cFec_ult_cambio[MAXFETCH][30];
		char    cUsuario[MAXFETCH][31];
		char    cCod_servicio[MAXFETCH][8];
		char    cCod_tecnologia[MAXFETCH][8];
		char    cCod_plan[MAXFETCH][4];
		char    cPlan_activo[MAXFETCH][31];
		long    lVendedor[MAXFETCH];
		long    iCiclo[MAXFETCH];
		char    cSituacion[MAXFETCH][31]; 
		char	szhIndProcequi[2];
  		char    szhNumSerie[MAXFETCH][26];	/* Serie de la Simcard (GSM) */
  		char	szhNumImei[MAXFETCH][26];	/* serie mecanica (terminal) */		
    /* EXEC SQL END DECLARE SECTION; */ 
 
    	
    strcpy(szhFechaInicio   , stArgsExt.szFecDesde);  
    strcpy(szhFechaTermino  , stArgsExt.szFecHasta); 
	fprintf(stderr, "\n[vSeleccionarUniverso]Parametros: Fec_Desde:[%s] Fec_Hasta:[%s]\n", szhFechaInicio, szhFechaTermino);
	
	strcpy(szhIndProcequi, "I");
	ihProdCelular  = 1;
    lMaxFetch      = MAXFETCH;     
    
	/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR 
		SELECT  DISTINCT 
			ABO.NUM_VENTA  num_venta,
			ABO.COD_CLIENTE cliente,
			ABO.NUM_ABONADO NumAbonado,
			NVL(VTAS.NUM_CONTRATO, 'S/N') Contrato,
			CLI.NOM_CLIENTE Nombre,
			NVL(CLI.NOM_APECLIEN1, ' ')||' '||nvl(CLI.NOM_APECLIEN2, ' ') Apellidos,
			NVL(CLI.NOM_APECLIEN1, ' ') compania,
			CLI.NUM_IDENT cedula,
			CLI.NUM_IDENT Ruc,
			NVL(TO_CHAR(CLI.FEC_ACEPVENT, 'YYYYMMDD'), ' ') Fecha_activacion_cuenta,
			ABO.NUM_CELULAR Celular,
			NVL(TO_CHAR(ABO.FEC_ACTIVACION, 'YYYYMMDD'), ' ') Fecha_activa_telefono,
			NVL(TO_CHAR(ABO.FEC_BAJA,'YYYYMMDD'), ' ') Fecha_termino_telefono,
			NVL(TO_CHAR(ABO.FEC_ACTIVACION, 'YYYYMMDD'), ' ') Fecha_activa_comp,
			NVL(TO_CHAR(ABO.FEC_FINCONTRA, 'YYYYMMDD'), ' ') Fecha_termino_comp,			
			NVL(TO_CHAR(VTAS.FEC_VENTA, 'YYYYMMDD'), ' ') Fecha_ultimo_cambio,
			VTAS.NOM_USUAR_VTA Usuario,
			DECODE(PLA.COD_TIPLAN, '1','PREPAGO',2,'POSPAGO',3,'HIBRIDO') CodServicio,
			NVL(ABO.COD_TECNOLOGIA, ' ') Codigo_tecnologia,
			NVL(ABO.NUM_IMEI, NUM_SERIE) ,						/o SERIE DEL TERMINAL  o/
			DECODE(ABO.NUM_IMEI, NULL, 'S/N', NUM_SERIE), 		/o SERIE DE LA SIMCARD o/
			ABO.COD_PLANTARIF Codigo_plan,
			PLA.DES_PLANTARIF Plan_activo,
			ABO.COD_VENDEDOR Vendedor,
			NVL(ABO.COD_CICLO,0) Ciclo,                                                                                  
			SIT.DES_SITUACION Situacion 
        FROM	
		    GA_VENTAS       VTAS,
		    GA_ABOAMIST	    ABO,
		    GE_CLIENTES     CLI,
		    TA_PLANTARIF    PLA,
          	GA_SITUABO 		SIT,
          	GED_CODIGOS		COD 
        WHERE   PLA.COD_PRODUCTO 	=  ABO.COD_PRODUCTO
        	AND PLA.COD_PLANTARIF 	=  ABO.COD_PLANTARIF
        	AND SIT.COD_SITUACION 	=  ABO.COD_SITUACION
        	AND ABO.FEC_ACTIVACION 	>= TO_DATE(:szhFechaInicio,'YYYYMMDD')
        	AND ABO.FEC_ACTIVACION 	<= TO_DATE(:szhFechaTermino,'YYYYMMDD') + 1
        	AND ABO.NUM_VENTA 		=  VTAS.NUM_VENTA
        	AND ABO.COD_CLIENTE 	=  CLI.COD_CLIENTE
			AND ABO.COD_PRODUCTO   	=  :ihProdCelular
			AND ABO.COD_SITUACION  	=  COD.COD_VALOR
          	AND COD.COD_MODULO    	=  'CM'
          	AND COD.NOM_TABLA     	=  'GA_ABOCEL'
          	AND COD.NOM_COLUMNA   	=  'COD_SITUACION'; */ 


    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlbuft((void **)0, 
      "select distinct ABO.NUM_VENTA num_venta ,ABO.COD_CLIENTE cliente ,ABO\
.NUM_ABONADO NumAbonado ,NVL(VTAS.NUM_CONTRATO,'S/N') Contrato ,CLI.NOM_CLIE\
NTE Nombre ,((NVL(CLI.NOM_APECLIEN1,' ')||' ')||nvl(CLI.NOM_APECLIEN2,' ')) \
Apellidos ,NVL(CLI.NOM_APECLIEN1,' ') compania ,CLI.NUM_IDENT cedula ,CLI.NU\
M_IDENT Ruc ,NVL(TO_CHAR(CLI.FEC_ACEPVENT,'YYYYMMDD'),' ') Fecha_activacion_\
cuenta ,ABO.NUM_CELULAR Celular ,NVL(TO_CHAR(ABO.FEC_ACTIVACION,'YYYYMMDD'),\
' ') Fecha_activa_telefono ,NVL(TO_CHAR(ABO.FEC_BAJA,'YYYYMMDD'),' ') Fecha_\
termino_telefono ,NVL(TO_CHAR(ABO.FEC_ACTIVACION,'YYYYMMDD'),' ') Fecha_acti\
va_comp ,NVL(TO_CHAR(ABO.FEC_FINCONTRA,'YYYYMMDD'),' ') Fecha_termino_comp ,\
NVL(TO_CHAR(VTAS.FEC_VENTA,'YYYYMMDD'),' ') Fecha_ultimo_cambio ,VTAS.NOM_US\
UAR_VTA Usuario ,DECODE(PLA.COD_TIPLAN,'1','PREPAGO',2,'POSPAGO',3,'HIBRIDO'\
) CodServicio ,NVL(ABO.COD_TECNOLOGIA,' ') Codigo_tecnologia ,NVL(ABO.NUM_IM\
EI,NUM_SERIE) ,DECODE(ABO.NUM_IMEI,null ,'S/N',NUM_SERIE) ,ABO.COD_PLANTARIF\
 Codigo_plan ,PLA.DES_PLANTARIF Plan_activo");
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFechaInicio;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFechaTermino;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihProdCelular;
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
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}

 

    while (iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch 
        	FETCH cur_universo INTO
                	:lNumVenta		,
                        :lCodCliente            ,
                        :lNumAbonado		,
                        :cContrato              ,
                        :cNombre                ,
                        :cApellidos             ,
                        :cDesEmpresa		,
                        :cCedula                ,
                        :cRuc                   ,
                        :cFec_act_cuenta        ,
                        :cCelular               ,
                        :cFec_act_tel           ,
                        :cFec_termino_tel       ,
                        :cFec_act_comp       	,
                        :cFec_termino_comp      ,
                        :cFec_ult_cambio        ,
                        :cUsuario               ,
                        :cCod_servicio	 	,
                        :cCod_tecnologia        ,
						:szhNumImei				,	/o SERIE DEL TERMINAL  o/
						:szhNumSerie			,	/o SERIE DE LA SIMCARD o/
                        :cCod_plan              ,
                        :cPlan_activo           ,
                        :lVendedor              ,
                        :iCiclo                 ,
                        :cSituacion             ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 26;
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
  sqlstm.sqhstv[0] = (unsigned char  *)lNumVenta;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lNumAbonado;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)cContrato;
  sqlstm.sqhstl[3] = (unsigned long )22;
  sqlstm.sqhsts[3] = (         int  )22;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)cNombre;
  sqlstm.sqhstl[4] = (unsigned long )51;
  sqlstm.sqhsts[4] = (         int  )51;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)cApellidos;
  sqlstm.sqhstl[5] = (unsigned long )50;
  sqlstm.sqhsts[5] = (         int  )50;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)cDesEmpresa;
  sqlstm.sqhstl[6] = (unsigned long )50;
  sqlstm.sqhsts[6] = (         int  )50;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)cCedula;
  sqlstm.sqhstl[7] = (unsigned long )21;
  sqlstm.sqhsts[7] = (         int  )21;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)cRuc;
  sqlstm.sqhstl[8] = (unsigned long )21;
  sqlstm.sqhsts[8] = (         int  )21;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)cFec_act_cuenta;
  sqlstm.sqhstl[9] = (unsigned long )30;
  sqlstm.sqhsts[9] = (         int  )30;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)cCelular;
  sqlstm.sqhstl[10] = (unsigned long )16;
  sqlstm.sqhsts[10] = (         int  )16;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)cFec_act_tel;
  sqlstm.sqhstl[11] = (unsigned long )30;
  sqlstm.sqhsts[11] = (         int  )30;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)cFec_termino_tel;
  sqlstm.sqhstl[12] = (unsigned long )30;
  sqlstm.sqhsts[12] = (         int  )30;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)cFec_act_comp;
  sqlstm.sqhstl[13] = (unsigned long )30;
  sqlstm.sqhsts[13] = (         int  )30;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)cFec_termino_comp;
  sqlstm.sqhstl[14] = (unsigned long )30;
  sqlstm.sqhsts[14] = (         int  )30;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)cFec_ult_cambio;
  sqlstm.sqhstl[15] = (unsigned long )30;
  sqlstm.sqhsts[15] = (         int  )30;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)cUsuario;
  sqlstm.sqhstl[16] = (unsigned long )31;
  sqlstm.sqhsts[16] = (         int  )31;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)cCod_servicio;
  sqlstm.sqhstl[17] = (unsigned long )8;
  sqlstm.sqhsts[17] = (         int  )8;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)cCod_tecnologia;
  sqlstm.sqhstl[18] = (unsigned long )8;
  sqlstm.sqhsts[18] = (         int  )8;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[19] = (unsigned long )26;
  sqlstm.sqhsts[19] = (         int  )26;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[20] = (unsigned long )26;
  sqlstm.sqhsts[20] = (         int  )26;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)cCod_plan;
  sqlstm.sqhstl[21] = (unsigned long )4;
  sqlstm.sqhsts[21] = (         int  )4;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)cPlan_activo;
  sqlstm.sqhstl[22] = (unsigned long )31;
  sqlstm.sqhsts[22] = (         int  )31;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)lVendedor;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[23] = (         int  )sizeof(long);
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)iCiclo;
  sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[24] = (         int  )sizeof(long);
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




			iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows    = sqlca.sqlerrd[2];
                
            for (i=0; i < iRetrievRows; i++)
            {                
		       
		       paux = (stUniverso *) malloc(sizeof(stUniverso));
		       
		       paux->lNumVenta		  			  = lNumVenta	       			  [i]   ;    				
                       paux->lCodCliente          = lCodCliente          		  [i]   ;  
                       paux->lNumAbonado	  	  = lNumAbonado	       			  [i]   ;    	
                strcpy(paux->cContrato            , szfnTrim(cContrato            [i] ));  
                strcpy(paux->cNombre              , szfnTrim(cNombre              [i] ));  
                strcpy(paux->cApellidos           , szfnTrim(cApellidos           [i] ));  
                strcpy(paux->cDesEmpresa          , szfnTrim(cDesEmpresa          [i] ));  
                strcpy(paux->cCedula              , szfnTrim(cCedula              [i] ));  
                strcpy(paux->cRuc                 , szfnTrim(cRuc                 [i] ));  
                strcpy(paux->cFec_act_cuenta      , szfnTrim(cFec_act_cuenta      [i] ));  
                strcpy(paux->cCelular             , szfnTrim(cCelular             [i] ));  
                strcpy(paux->cFec_act_tel         , szfnTrim(cFec_act_tel         [i] ));  
                strcpy(paux->cFec_termino_tel     , szfnTrim(cFec_termino_tel     [i] ));  
                strcpy(paux->cFec_act_comp        , szfnTrim(cFec_act_comp        [i] ));  
                strcpy(paux->cFec_termino_comp    , szfnTrim(cFec_termino_comp    [i] ));  
                strcpy(paux->cFec_ult_cambio      , szfnTrim(cFec_ult_cambio      [i] ));  
                strcpy(paux->cUsuario             , szfnTrim(cUsuario             [i] ));  
                strcpy(paux->cCod_servicio        , szfnTrim(cCod_servicio        [i] ));  
                strcpy(paux->cCod_tecnologia      , szfnTrim(cCod_tecnologia      [i] ));  
                strcpy(paux->cCod_plan            , szfnTrim(cCod_plan            [i] ));  
                strcpy(paux->cPlan_activo         , szfnTrim(cPlan_activo         [i] ));  

                strcpy(paux->szNumImei         	  , szfnTrim(szhNumImei           [i] ));  
                strcpy(paux->szNumSerie           , szfnTrim(szhNumSerie          [i] ));  

                       paux->lVendedor            =          lVendedor            [i]   ;  
                       paux->iCiclo               =          iCiclo               [i]   ;  
			    strcpy(paux->cSituacion           , szfnTrim(cSituacion           [i] ));    
                paux->cIndConsidera			      = 'S';

				fprintf(stderr, "\n[vSeleccionarUniverso] Procesando Venta:[%ld] Cliente:[%ld] Abonado:[%ld].", paux->lNumVenta, paux->lCodCliente, paux->lNumAbonado);
				fprintf(pfLog , "\n[vSeleccionarUniverso] Procesando Venta:[%ld] Cliente:[%ld] Abonado:[%ld].", paux->lNumVenta, paux->lCodCliente, paux->lNumAbonado);
				
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
				{
					paux->cIndConsidera			 = 'N';
					fprintf(stderr, "\n[vSeleccionarUniverso] A Cliente:[%ld] No se le Pudo Obtener Dirección.", paux->lCodCliente);
					fprintf(pfLog , "\n[vSeleccionarUniverso] A Cliente:[%ld] No se le Pudo Obtener Dirección.", paux->lCodCliente);
				}
				if (!ifnCargaDatosEquipo(paux))
				{
					paux->cIndConsidera			 = 'N';
					fprintf(stderr, "\n[vSeleccionarUniverso] A Abonado:[%ld] No se le Pudo Obtener Datos del Equipo.", paux->lNumAbonado);
					fprintf(pfLog , "\n[vSeleccionarUniverso] A Abonado:[%ld] No se le Pudo Obtener Datos del Equipo.", paux->lNumAbonado);
				}
				
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
    sqlstm.offset = (unsigned int  )151;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    fprintf(pfLog, "\n(vSeleccionarUniverso)Cantidad de Abonados Kit Extraídos:[%ld].\n", iCantidad);        
}
/* -------------------------------------------------------------------------------------- */
/* Carga los datos del equipo...                                                          */
/* -------------------------------------------------------------------------------------- */
int ifnCargaDatosEquipo(stUniverso * paux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    long    lhNumAbonado		    ;
   		long	lhCodArticulo		    ;
		char	szhDesArticulo      [41];
		char	ihTipArticulo           ;
		char	szhDesTipArticulo   [16];
		char	szhCodModelo        [16];
		int		ihCodFabricante         ;
		char	szhDesFabricante    [21];
		char	szhTipTerminal[2];
		char	szhIndProcequi[2];
	/* EXEC SQL END DECLARE SECTION; */ 

	strcpy(szhTipTerminal , "G");
	strcpy(szhIndProcequi, "I");

    lhNumAbonado      	= paux->lNumAbonado;
    /* EXEC SQL SELECT 
	         EQUI1.COD_ARTICULO,
	         ARTI.DES_ARTICULO,
	         ARTI.TIP_ARTICULO, 
	         TIPO.DES_TIPARTICULO, 
	         ARTI.COD_MODELO, 
	         ARTI.COD_FABRICANTE,
	         FABR.DES_FABRICANTE
         INTO 	:lhCodArticulo		 ,
				:szhDesArticulo      ,
				:ihTipArticulo       ,
				:szhDesTipArticulo   ,
				:szhCodModelo        ,
				:ihCodFabricante     ,
				:szhDesFabricante    
         FROM	AL_FABRICANTES     FABR,
                AL_ARTICULOS       ARTI,
                GA_EQUIPABOSER     EQUI1,
				AL_TIPOS_ARTICULOS TIPO
         WHERE	EQUI1.NUM_ABONADO    = :lhNumAbonado
           AND  EQUI1.TIP_TERMINAL  != :szhTipTerminal
		   AND  EQUI1.IND_PROCEQUI   = :szhIndProcequi
           AND  EQUI1.FEC_ALTA =(SELECT  MAX(R.FEC_ALTA) 
            					 FROM   	GA_EQUIPABOSER R
                                   WHERE   	R.NUM_ABONADO = EQUI1.NUM_ABONADO
                                   AND 	   	R.TIP_TERMINAL != :szhTipTerminal)
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
ABRICANTE into :b0,:b1,:b2,:b3,:b4,:b5,:b6  from AL_FABRICANTES FABR ,AL_ARTIC\
ULOS ARTI ,GA_EQUIPABOSER EQUI1 ,AL_TIPOS_ARTICULOS TIPO where ((((((EQUI1.NUM\
_ABONADO=:b7 and EQUI1.TIP_TERMINAL<>:b8) and EQUI1.IND_PROCEQUI=:b9) and EQUI\
1.FEC_ALTA=(select max(R.FEC_ALTA)  from GA_EQUIPABOSER R where (R.NUM_ABONADO\
=EQUI1.NUM_ABONADO and R.TIP_TERMINAL<>:b8))) and EQUI1.COD_ARTICULO=ARTI.COD_\
ARTICULO) and ARTI.COD_FABRICANTE=FABR.COD_FABRICANTE) and ARTI.TIP_ARTICULO=T\
IPO.TIP_ARTICULO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )166;
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
    sqlstm.sqhstv[7] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhIndProcequi;
    sqlstm.sqhstl[9] = (unsigned long )2;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[10] = (unsigned long )2;
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
    char		  szCampoArchivo[1024];
    char          szLineaArchivo[2048];
	char          szNomArchivo_dat[250] ;
	char          szNomArchivo_lst[250] ;
	int			  bRes;
	char		  *aux;
    int			  iNumLineas = 0;
	int			  iNumArchivos = 0;
	
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
/*            fprintf(stderr,"[%d][%s]\n", iNumLineas, szLineaArchivo); */
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
		fprintf(pfLst, "\n[COL][CAMPO                    ][LEN][JUS][FIL][TYP]");
		
		for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
		{
			fprintf(pfLst, "\n[%-3d][%-25.25s][%-3d][%-3.3s][%-3.3s][%-3.3s]",
			paux_det_archivo->iNumOrden, paux_det_archivo->szNomCampo, paux_det_archivo->iLargoCampo,
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
char *szBuscaDetalleCampoi(stUniverso    *paux, stDetArchivo  *paux_det_archivo)
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
    
    strcpy(szCodCampo      , paux_det_archivo->szNomCampo);
    strcpy(pszTipoDato     , paux_det_archivo->szTipoDato);
    strcpy(szFormato       , paux_det_archivo->szFormato);

   /*fprintf(stderr, "[szBuscaDetalleCampoi] Campo:[%s] 	szFormato:[%s]\n",szCodCampo, szFormato);*/

           if (strncmp( "COD_REGION"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szMTX                 );
      else if (strncmp( "NUM_CONTRATO"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->cContrato             ); 
      else if (strncmp( "NOM_CLIENTE"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->cNombre               );
      else if (strncmp( "NOM_APECLIEN1"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cApellidos            );
      else if (strncmp( "DES_EMPRESA"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->cDesEmpresa	      	  );
      else if (strncmp( "DIRECCION"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->cDireccion	      	  );
      else if (strncmp( "NUM_IDENT"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->cCedula               );
      else if (strncmp( "NUM_RUC"             ,szfnTrim(szCodCampo),7  ) == 0)  sprintf(szResp,szFormato, paux->cRuc                  );
      else if (strncmp( "FEC_ACEPVENT"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->cFec_act_cuenta       );
      else if (strncmp( "NUM_CELULAR"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->cCelular              );
      else if (strncmp( "FEC_ALTA"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->cFec_act_tel          );   
      else if (strncmp( "FEC_BAJA"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->cFec_termino_tel      );
      else if (strncmp( "FEC_ACTIVACION"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->cFec_act_comp	      );
      else if (strncmp( "FEC_FINCONTRA"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cFec_termino_comp     );
      else if (strncmp( "FEC_ULTMOD"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->cFec_ult_cambio       );
      else if (strncmp( "NOM_USUAR_VTA"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cUsuario              );
      else if (strncmp( "COD_TIPLAN"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->cCod_servicio	      );
      else if (strncmp( "COD_TECNOLOGIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->cCod_tecnologia       );
      else if (strncmp( "TIP_TERMINAL"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->lCodArticulo          );
      else if (strncmp( "DES_TERMINAL"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szDesArticulo         );
      else if (strncmp( "COD_FABRICANTE"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->iCodFabricante        );   
      else if (strncmp( "DES_FABRICANTE"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szDesFabricante       );   
      else if (strncmp( "COD_PLANTARIF"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cCod_plan	      	  );
      else if (strncmp( "DES_PLANTARIF"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cPlan_activo	      );
      else if (strncmp( "COD_VENDEDOR"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->lVendedor   	      );   
      else if (strncmp( "DES_CIUDAD"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szDesCiudad           );
      else if (strncmp( "DES_PROVINCIA"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szDesProvincia	      );        
      else if (strncmp( "COD_FRANQUICIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szCodCiudad	      	  );        
      else if (strncmp( "DES_FRANQUICIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szFranquicia   	      );   
      else if (strncmp( "COD_CICLO"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->iCiclo                ); 
      else if (strncmp( "DES_SITUACION"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cSituacion	      	  );  
      else if (strncmp( "BLANCO"  			  ,szfnTrim(szCodCampo),6  ) == 0)  sprintf(szResp,szFormato, CARACBLANCO      		  	  );  
      else if (strncmp( "NUM_IMEI"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux->szNumImei             );
      else if (strncmp( "NUM_SERIE"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szNumSerie            );

/*    fprintf(stderr, "[szBuscaDetalleCampoi] Parceo realizado.. respuesta[%s]\n",szResp);*/
    if (szResp[0] == NULL){
        if (pszTipoDato[0] == 'N')
             sprintf(szResp,szFormato,0);
        else
             sprintf(szResp,szFormato," ");
    }
     
/*    fprintf(stderr, "[szBuscaDetalleCampoi] respuesta FINAL[%s]\n",szResp); */
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
    sqlstm.offset = (unsigned int  )225;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


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
/* CARGA REGISTROS DE VENTAS KIT DEL PERIODO                                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga las Ventas Kit entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde, stArgsExt.szFecHasta);
    fprintf(stderr,"\n(Principal) Carga las Ventas Kit entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde, stArgsExt.szFecHasta);
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
    sqlstm.offset = (unsigned int  )240;
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

