
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
    "./pc/Ext_RedVentas.pc"
};


static unsigned int sqlctx = 110803651;


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
   unsigned char  *sqhstv[11];
   unsigned long  sqhstl[11];
            int   sqhsts[11];
            short *sqindv[11];
            int   sqinds[11];
   unsigned long  sqharm[11];
   unsigned long  *sqharc[11];
   unsigned short  sqadto[11];
   unsigned short  sqtdso[11];
} sqlstm = {12,11};

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
"select COMIS.DES_TIPCOMIS ,VEN.COD_VENDEDOR ,VEN.NOM_VENDEDOR ,VEN.COD_TIPID\
ENT ,TIPIDENT.DES_TIPIDENT ,VEN.NUM_IDENT ,NVL(TO_CHAR(VEN.FEC_CONTRATO,'YYYYM\
MDD'),' ') ,NVL(TO_CHAR(VEN.FEC_FINCONTRATO,'YYYYMMDD'),' ') ,OFI.DES_OFICINA \
,NVL(VEN.NUM_TELEF1,' ') ,DECODE(COMIS.IND_VTA_EXTERNA,'0','CANAL INTERNO','1'\
,'CANAL EXTERNO')  from VE_VENDEDORES VEN ,VE_TIPCOMIS COMIS ,GE_OFICINAS OFI \
,GE_TIPIDENT TIPIDENT where ((VEN.COD_TIPCOMIS=COMIS.COD_TIPCOMIS and OFI.COD_\
OFICINA=VEN.COD_OFICINA) and VEN.COD_TIPIDENT=TIPIDENT.COD_TIPIDENT)          \
 ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,545,0,9,85,0,0,0,0,0,1,0,
20,0,0,1,0,0,13,91,0,0,11,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
79,0,0,1,0,0,15,129,0,0,0,0,0,1,0,
94,0,0,2,48,0,1,424,0,0,0,0,0,1,0,
109,0,0,3,0,0,30,492,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de seleccionar las Bajas Prematuras x Canal Espec.*/ 
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Lunes 02 de Mayo del 2005.                                	*/
/* Fin   : Viernes 06 de Mayo del 2005.                            	*/
/* Modificacion:                                                        */
/* Fecha:                                                               */
/* Autor:                                                               */
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Ext_RedVentas.h"
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
    	long	iCantidad    = 0;
	int     i;
	long    iLastRows    = 0;
	int     iFetchedRows = MAXFETCH;
	int     iRetrievRows = MAXFETCH;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
	long    lMaxFetch ; 
	char	szhDesTipcomis     [MAXFETCH][31];
	long	szhCodVendedor     [MAXFETCH];
	char	szhNomVendedor 	   [MAXFETCH][41];
	char	szhCodTipident 	   [MAXFETCH][3];
	char	szhDesTipident 	   [MAXFETCH][21];
	char	szhNumIdent    	   [MAXFETCH][21];
	char	szhFecContrato	   [MAXFETCH][21];
	char	szhFecFinContrato  [MAXFETCH][21];
	char	szhDesOficina	   [MAXFETCH][41];
	char	szhNumTelefono	   [MAXFETCH][16];
	char	szhIndVentaExterna [MAXFETCH][14];
	
    /* EXEC SQL END DECLARE SECTION; */ 
 
    
    fprintf(stderr, "\n[vSeleccionarUniverso]Parametros: Trae todos los Vendedores\n");
    lMaxFetch      = MAXFETCH;     
    
	/* EXEC SQL DECLARE CUR_UNIVERSO CURSOR FOR 
	SELECT 
           COMIS.DES_TIPCOMIS, 
	       VEN.COD_VENDEDOR, 
	       VEN.NOM_VENDEDOR, 
	       VEN.COD_TIPIDENT, 
	       TIPIDENT.DES_TIPIDENT, 
	       VEN.NUM_IDENT, 
	       NVL(TO_CHAR(VEN.FEC_CONTRATO,'YYYYMMDD'), ' '),
	       NVL(TO_CHAR(VEN.FEC_FINCONTRATO,'YYYYMMDD' ), ' '),
	       OFI.DES_OFICINA,
	       NVL(VEN.NUM_TELEF1, ' '),
	       DECODE(COMIS.IND_VTA_EXTERNA,'0','CANAL INTERNO', '1','CANAL EXTERNO')
	FROM   VE_VENDEDORES VEN,
	       VE_TIPCOMIS COMIS,
	       GE_OFICINAS OFI,
	       GE_TIPIDENT TIPIDENT
	WHERE  VEN.COD_TIPCOMIS = COMIS.COD_TIPCOMIS
	       AND OFI.COD_OFICINA = VEN.COD_OFICINA
	       AND VEN.COD_TIPIDENT = TIPIDENT.COD_TIPIDENT; */ 


    /* EXEC SQL OPEN CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}

 

    fprintf(stderr, "\nDespues de Cursor; iFetchedRows: [%d], iRetrievRows: [%d] \n", iFetchedRows, iFetchedRows);
    
    while (iFetchedRows == iRetrievRows)
    {
	/* EXEC SQL for :lMaxFetch 
	    	
        FETCH CUR_UNIVERSO INTO
		:szhDesTipcomis    	,
		:szhCodVendedor    	,
		:szhNomVendedor 	,
		:szhCodTipident 	,
		:szhDesTipident 	,
		:szhNumIdent    	,
		:szhFecContrato	  	,
		:szhFecFinContrato 	,
		:szhDesOficina	  	,
		:szhNumTelefono	  	,
        	:szhIndVentaExterna	; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )lMaxFetch;
 sqlstm.offset = (unsigned int  )20;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDesTipcomis;
 sqlstm.sqhstl[0] = (unsigned long )31;
 sqlstm.sqhsts[0] = (         int  )31;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodVendedor;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqharc[1] = (unsigned long  *)0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhNomVendedor;
 sqlstm.sqhstl[2] = (unsigned long )41;
 sqlstm.sqhsts[2] = (         int  )41;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqharc[2] = (unsigned long  *)0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipident;
 sqlstm.sqhstl[3] = (unsigned long )3;
 sqlstm.sqhsts[3] = (         int  )3;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqharc[3] = (unsigned long  *)0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhDesTipident;
 sqlstm.sqhstl[4] = (unsigned long )21;
 sqlstm.sqhsts[4] = (         int  )21;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqharc[4] = (unsigned long  *)0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhNumIdent;
 sqlstm.sqhstl[5] = (unsigned long )21;
 sqlstm.sqhsts[5] = (         int  )21;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqharc[5] = (unsigned long  *)0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFecContrato;
 sqlstm.sqhstl[6] = (unsigned long )21;
 sqlstm.sqhsts[6] = (         int  )21;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqharc[6] = (unsigned long  *)0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhFecFinContrato;
 sqlstm.sqhstl[7] = (unsigned long )21;
 sqlstm.sqhsts[7] = (         int  )21;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqharc[7] = (unsigned long  *)0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhDesOficina;
 sqlstm.sqhstl[8] = (unsigned long )41;
 sqlstm.sqhsts[8] = (         int  )41;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqharc[8] = (unsigned long  *)0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhNumTelefono;
 sqlstm.sqhstl[9] = (unsigned long )16;
 sqlstm.sqhsts[9] = (         int  )16;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqharc[9] = (unsigned long  *)0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhIndVentaExterna;
 sqlstm.sqhstl[10] = (unsigned long )14;
 sqlstm.sqhsts[10] = (         int  )14;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqharc[10] = (unsigned long  *)0;
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



	    iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows    = sqlca.sqlerrd[2];
                
            for (i=0; i < iRetrievRows; i++)
            {                
                paux = (stUniverso *) malloc(sizeof(stUniverso));
                
                strcpy(paux->szDesTipcomis         , szfnTrim(szhDesTipcomis	[i]));
                       paux->szCodVendedor         = szhCodVendedor		[i];
                strcpy(paux->szNomVendedor 	   , szfnTrim(szhNomVendedor 	[i]));
                strcpy(paux->szCodTipident 	   , szfnTrim(szhCodTipident	[i]));
                strcpy(paux->szDesTipident 	   , szfnTrim(szhDesTipident	[i]));
                strcpy(paux->szNumIdent    	   , szfnTrim(szhNumIdent	[i]));
                strcpy(paux->szFecContrato	   , szfnTrim(szhFecContrato	[i]));
                strcpy(paux->szFecFinContrato  	   , szfnTrim(szhFecFinContrato	[i]));
                strcpy(paux->szDesOficina          , szfnTrim(szhDesOficina 	[i]));
                strcpy(paux->szNumTelefono         , szfnTrim(szhNumTelefono	[i]));
                strcpy(paux->szIndVentaExterna     , szfnTrim(szhIndVentaExterna[i]));
                paux->sgte 			   = lstUniverso;
                lstUniverso 			 = paux;
                iCantidad++;                
            }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )79;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    fprintf(pfLog, "\n(vSeleccionarUniverso)Cantidad de Vendedores Extraidos:[%ld].\n", iCantidad);        
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
    
    char	separador;       
    char	szCampoArchivo[1024];
    char        szLineaArchivo[2048];
    char        szNomArchivo_dat[250] ;
    char        szNomArchivo_lst[250] ;
    /*char	szUbicacion_dat[250];*/
    int	 	bRes;
    char	*aux;
    int		iNumLineas = 0;
    int		iNumArchivos = 0;
	
	for (paux_archivos = lstArchivo; paux_archivos != NULL; paux_archivos=paux_archivos->sgte)
    {
		/* Se tiene un archivo... se debe mandar a crear EL DAT*/
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
		/*sprintf(szUbicacion_dat, "%s%s%s",pszEnvDat , szhSysDate, szNomArchivo_lst);*/
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
    
    strcpy(szCodCampo      , paux_det_archivo->szNomCampo);
    strcpy(pszTipoDato     , paux_det_archivo->szTipoDato);
	strcpy(szFormato	   , paux_det_archivo->szFormato);

/*    fprintf(stderr, "[szBuscaDetalleCampoi] szFormato       [%s]\n",szFormato); */

           if (strncmp( "DES_TIPCOMIS"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szDesTipcomis     );
      else if (strncmp( "COD_VENDEDOR"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szCodVendedor     );
      else if (strncmp( "NOM_VENDEDOR"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szNomVendedor     );
      else if (strncmp( "COD_TIPIDENT"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szCodTipident     );
      else if (strncmp( "DES_TIPIDENT"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szDesTipident     );
      else if (strncmp( "NUM_IDENT"        ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szNumIdent        );
      else if (strncmp( "FEC_CONTRATO"     ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szFecContrato     );
      else if (strncmp( "FEC_FINCONTRATO"  ,szfnTrim(szCodCampo),15 ) == 0)  sprintf(szResp,szFormato, paux->szFecFinContrato  );
      else if (strncmp( "DES_OFICINA" 	   ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->szDesOficina      );
      else if (strncmp( "NUM_TELEF1"   	   ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szNumTelefono     );
      else if (strncmp( "CANAL"   	   	   ,szfnTrim(szCodCampo),5  ) == 0)  sprintf(szResp,szFormato, paux->szIndVentaExterna );
      else if (strncmp( "BLANCO"  		   ,szfnTrim(szCodCampo),6  ) == 0)  sprintf(szResp,szFormato, CARACBLANCO      		  );  
                                             
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
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )94;
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
/*    ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 0, "X", iCREATRAZA);*/
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
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )109;
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

