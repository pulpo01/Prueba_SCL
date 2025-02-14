
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
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/intCobFac.pc"
};


static unsigned int sqlctx = 6914947;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
      const short *cud;
   unsigned char  *sqlest;
      const char  *stmt;
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
extern void sqlcxt (void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlcx2t(void **, unsigned int *,
                    struct sqlexd *, const struct sqlcxp *);
extern void sqlbuft(void **, char *);
extern void sqlgs2t(void **, char *);
extern void sqlorat(void **, unsigned int *, void *);

/* Forms Interface */
static const int IAPSUCC = 0;
static const int IAPFAIL = 1403;
static const int IAPFTL  = 535;
extern void sqliem(char *, int *);

 static const char *sq0002 = 
"select IMPORTE_DEBE ,IMPORTE_HABER ,COD_CONCEPTO ,COLUMNA ,SEC_CUOTA  from C\
O_CARTERA where ((((NUM_SECUENCI=:b0 and COD_TIPDOCUM=:b1) and COD_VENDEDOR_AG\
ENTE=:b2) and LETRA=:b3) and COD_CENTREMI=:b4) order by SEC_CUOTA            ";

 static const char *sq0003 = 
"select sum(A.IMPORTE_DEBE) ,sum(A.IMPORTE_HABER) ,A.SEC_CUOTA  from CO_CARTE\
RA A where ((((A.NUM_SECUENCI=:b0 and A.COD_TIPDOCUM=:b1) and A.COD_VENDEDOR_A\
GENTE=:b2) and A.LETRA=:b3) and A.COD_CENTREMI=:b4) group by A.SEC_CUOTA order\
 by A.SEC_CUOTA            ";

 static const char *sq0016 = 
"select NUM_SECUENCI ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COLUMNA ,(IMP\
ORTE_HABER-IMPORTE_DEBE) ,TO_CHAR(SYSDATE,'YYYYMMDD') ,NUM_ABONADO ,COD_PRODUC\
TO  from CO_CARTERA where ((COD_CLIENTE=:b0 and NUM_FOLIO=:b1) and COD_TIPDOCU\
M=39)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,55,0,4,212,0,0,1,0,0,1,0,2,5,0,0,
24,0,0,2,231,0,9,242,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
59,0,0,2,0,0,13,251,0,0,5,0,0,1,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
94,0,0,3,259,0,9,295,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
129,0,0,3,0,0,13,306,0,0,3,0,0,1,0,2,4,0,0,2,4,0,0,2,3,0,0,
156,0,0,3,0,0,15,433,0,0,0,0,0,1,0,
171,0,0,2,0,0,15,444,0,0,0,0,0,1,0,
186,0,0,4,264,0,6,547,0,0,14,14,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,97,0,0,
257,0,0,5,1035,0,3,633,0,0,9,9,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
308,0,0,6,1037,0,3,706,0,0,9,9,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
359,0,0,7,796,0,3,866,0,0,13,13,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
426,0,0,8,200,0,2,977,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,
473,0,0,9,230,0,5,1054,0,0,9,9,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
524,0,0,10,232,0,5,1071,0,0,9,9,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
575,0,0,11,240,0,4,1092,0,0,10,8,0,1,0,2,4,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
630,0,0,12,54,0,4,1171,0,0,1,0,0,1,0,2,3,0,0,
649,0,0,13,193,0,6,1189,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,3,3,0,0,2,3,0,0,
2,97,0,0,
688,0,0,14,84,0,4,1231,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
711,0,0,15,424,0,3,1356,0,0,19,19,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,1,4,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,97,0,0,
802,0,0,16,248,0,9,1458,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
825,0,0,16,0,0,13,1468,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,
4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
876,0,0,17,262,0,5,1505,0,0,8,8,0,1,0,1,4,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,1,3,0,0,
923,0,0,16,0,0,15,1549,0,0,0,0,0,1,0,
938,0,0,18,1182,0,3,1613,0,0,10,10,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
993,0,0,19,224,0,2,1651,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/***************************************************************************************************************
Fichero     :  intCobFac.pc
Modulo      :  COBROS
Proceso     :  Interface entre modulo COBROS y FACTURACION
Fecha       :  20-11-1997
Autor       :  Miguel Acero
Descripcion :  Este programa es llamado desde el modulo de facturacion cuando
               se genera una NC o una ND.
               Recibe los cinco campos que identifican a la NC o ND, los cinco
               campos que identifica a la factura asociada y el codigo del
               cliente.
Modificaciones:
03-04-2002	Se agregan rutinas para manejo de decimales de acuerdo a la definicion de la operadora local
16-05-2002	Se agrega a query de filtro para creditos a recuperar la restriccion ind_facturado = 1
21-11-2002	Se agregan salidas a archivo LOG, en vez de a la salida estandar (PANTALLA).
*****************************************************************************************************************
*****************************************************************************************************************
Modificado por Proyecto MAS_03043 Mejoras Cancelacion de Creditos
*****************************************************************************************************************/

/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h 24-apr-2003.12:50:58 mkandarp Exp $ sqlca.h 
 */

/* Copyright (c) 1985, 2003, Oracle Corporation.  All rights reserved.  */
 
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


#include <geora.h>
#include <GenTypes.h>
#include <GenORA.h>
#include <coerr.h>
#include <genco.h>
#include "intCobFac.h"

/* EXEC SQL BEGIN DECLARE SECTION; */ 
 
	char szPrefPlazaDefault[26];
/* EXEC SQL END DECLARE SECTION; */ 


static FILE *fArchLogIn = stdout;
char  szNomUsuarioOraMain[31];

/****************************************************************************/
/****************************************************************************/
BOOL bfnInicializaLogNc( FILE *fpLOG )
{
	fArchLogIn = ( fpLOG == (FILE *)NULL ) ? fArchLogIn : fpLOG;
	return TRUE;
}

/****************************************************************************/
/****************************************************************************/

int ifnPasoCobNcNd(	long lNumSecuenciC, int	 iCodTipDocC, 		 long  AgenteC		 , 
					char *szLetraC	  , int	 iCentremiC , 		 long  lNumSecuenciF , 
					int	 iCodTipDocF  , long AgenteF	, 		 char  *szLetraF	 , 
					int	 iCentremiF	  , long lCodCliente, 		 int   iCodTipMovimie, /* se agrego iCodTipMovimie jlr_03.05.01 */
					char *szPrefPlaza , char *szCodOperadoraScl, char  *szCodPlaza, /* jlr_11.01.03 */
					char *szNomUsuarioOra)                     /* GAC 08-08-2003 (Homolog.) */
{
	int    iRet;
	int    iDis;
	char   szDia[5];
	char   lLog[384];
	int    bResul;

	fprintf( fArchLogIn, "Modulo ifnPasoCobNcNd \n" );
	
	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
	    fprintf( fArchLogIn, "Error al realizar carga de bGetParamDecimales().\n" );
		return ERR_DECIMAL;
	}

	/* obtenemos fecha juliana */
	bResul = bfnDBObtFechaFA( szDia );
	if( !bResul )
		return ERR_DATGEN;

	/* obtenemos concepto credito */
	bResul = bfnDBObtConCre( &TiG.iCodCredito );
	if( !bResul )
		return ERR_CONCREDITO;

        /* GAC 08-08-2003 (Homolog.) */
        strcpy(szNomUsuarioOraMain,szNomUsuarioOra);
		

	/*datos nota credito/debito*/
	stDatNota.lNumSecuenci = lNumSecuenciC;
	stDatNota.iCodTipDocum = iCodTipDocC;
	stDatNota.lCodAgente   = AgenteC;
	strcpy( stDatNota.szLetra, szLetraC );
	stDatNota.iCodCentremi = iCentremiC;

	fprintf( fArchLogIn, "\n\n Cliente         ....: %d", lCodCliente );
   	fprintf( fArchLogIn, "\nTipo Movimiento  ....: %d", iCodTipMovimie );

	fprintf( fArchLogIn, "\n\n ***** DATOS NOTA CREDITO *****" );
   	fprintf( fArchLogIn, "\n\tNumero Secuencia....: %d", lNumSecuenciC );
   	fprintf( fArchLogIn, "\n\tTipo Documento  ....: %d", iCodTipDocC );
   	fprintf( fArchLogIn, "\n\tAgente          ....: %d", AgenteC );
   	fprintf( fArchLogIn, "\n\tLetra           ....: %s", szLetraC );
   	fprintf( fArchLogIn, "\n\tCentro Emisor   ....: %ld", iCentremiC ); 
   	fprintf( fArchLogIn, "\n\tNom Usuario ORA ....: %s",szNomUsuarioOraMain);  /* GAC 08-08-2003 (Homolog.) */
                          
	/*datos factura asociada*/
	stDatFact.lNumSecuenci = lNumSecuenciF;
	stDatFact.iCodTipDocum = iCodTipDocF;
	stDatFact.lCodAgente   = AgenteF;
	strcpy( stDatFact.szLetra, szLetraF );
	stDatFact.iCodCentremi = iCentremiF;
	strcpy( stDatFact.szPrefPlaza, szPrefPlaza );			  /* jlr_11.01.03 */
	strcpy( stDatFact.szCodOperadoraScl, szCodOperadoraScl ); /* jlr_11.01.03 */
	strcpy( stDatFact.szCodPlaza, szCodPlaza );  			  /* jlr_11.01.03 */

	fprintf( fArchLogIn, "\n\n *****   DATOS FACTURA    *****");
   	fprintf( fArchLogIn, "\n\tNumero Secuencia....: %d", lNumSecuenciF);
   	fprintf( fArchLogIn, "\n\tTipo Documento  ....: %d", iCodTipDocF);
   	fprintf( fArchLogIn, "\n\tAgente          ....: %d", AgenteF);
   	fprintf( fArchLogIn, "\n\tLetra           ....: %s", szLetraF);
   	fprintf( fArchLogIn, "\n\tCentro Emisor   ....: %d", iCentremiF); 
   	fprintf( fArchLogIn, "\n\tPrefijo Plaza   ....: %s", szPrefPlaza); 		/* jlr_11.01.03 */ 
   	fprintf( fArchLogIn, "\n\tCod. Operadora  ....: %s", szCodOperadoraScl);/* jlr_11.01.03 */ 
   	fprintf( fArchLogIn, "\n\tCodigo Plaza    ....: %s", szCodPlaza); 		/* jlr_11.01.03 */ 
                          
	fprintf(fArchLogIn, "\nOK : [%d]\n", OK );

	/*codigo de cliente*/
	TiG.lCodCliente = lCodCliente;
	iRet = ifnProcNota( iCodTipMovimie );
	return iRet;
} /* Fin main() */

/******************************************************************************/
int ifnProcNota( int  iCodTipMovimie )
{
	int iResul;
	if( iCodTipMovimie == NCRE )
	{
		iResul = ifnDBProcCredito();
		if( iResul )
		{
			fprintf( fArchLogIn, "Retorno ifnDBProcCredito iResul = %d.\n", iResul );
			return( iResul == 69 ) ? 69 : ERR_PROCREDITO;
		}
	}
	else
	{
		iResul = ifnProcDebito();
		if( iResul )
		{
			fprintf( fArchLogIn, "Retorno ifnProcDebito iResul = %d.\n", iResul );
			return ERR_PRODEBITO;
		}
	}
	return OK;
}/*fin ifnProcNota*/
/******************************************************************************/
int ifnDBProcCredito()
/* 
Se modifica funcion completa por Incidencia XO-200509130656, 27-09-2005 rvc Soporte RyC
*/
/*
Se reemplaza funcion completa por una que funciona RA-200603160921 13-07-2006 capc Soporte RyC
*/
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

  long   lhNumSecuenciC;
  int    ihCodTipDocumC;
  long   lhCodAgenteC;
  char   *szhLetraC;     /* EXEC SQL VAR szhLetraC IS STRING(2); */ 

  int    ihCodCentrEmiC;
  double dhImpDebeC;
  double dhImpHaberC;
  int    ihCodConceptoC;
  int    ihColumnaC;
  long   lhNumSecuenciF;
  int    ihCodTipDocumF;
  long   lhCodAgenteF;
  long   lhCodClienteF;
  long   lhNumFolioF;
  char   *szhLetraF;     /* EXEC SQL VAR szhLetraF IS STRING(2); */ 

  int    ihCodCentrEmiF;
  double dhImpDebeF;
  double dhImpHaberF;
  int    ihCodConceptoF;
  int    ihColumnaF;
  int	 ihSecCuotaF;
  int	 ihSecCuotaC;
  char   szhFechaP_ddmmyyyy[9]   ; /* EXEC SQL VAR szhFechaP_ddmmyyyy IS STRING(9); */ 

 /* EXEC SQL END DECLARE SECTION; */ 

 
 int  iResul;
 BOOL bResul;
 int  iError = 0;
 double dImporteC;
 double dImporteF;
 double dImporteCTot = 0.0;
 double dImpCastigo = 0.0;
 double	dhValoraPagar;
 
 lhNumSecuenciC = stDatNota.lNumSecuenci;
 ihCodTipDocumC = stDatNota.iCodTipDocum;
 lhCodAgenteC   = stDatNota.lCodAgente;
 szhLetraC      = stDatNota.szLetra;
 ihCodCentrEmiC = stDatNota.iCodCentremi;
 
 lhNumSecuenciF = stDatFact.lNumSecuenci;
 ihCodTipDocumF = stDatFact.iCodTipDocum;
 lhCodAgenteF   = stDatFact.lCodAgente;
 szhLetraF      = stDatFact.szLetra;
 ihCodCentrEmiF = stDatFact.iCodCentremi;
 
 /* Inicio RA-200602070720 Soporte RyC 09-02-2006 capc*/

	/* EXEC SQL
	SELECT	TO_CHAR(SYSDATE,'ddmmyyyy')
	INTO	:szhFechaP_ddmmyyyy
	FROM	DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'ddmmyyyy') into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFechaP_ddmmyyyy;
 sqlstm.sqhstl[0] = (unsigned long )9;
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


	
	if (sqlca.sqlcode)
	{
		fprintf(stderr,"* Error recuperando fecha de sistema szhFechaP_ddmmyyyy - %d\n",sqlca.sqlcode);
		return FALSE;
	}

	fprintf( fArchLogIn, "szhFechaP_ddmmyyyy => [%s].\n", szhFechaP_ddmmyyyy );	
	
/* Fin RA-200602070720 Soporte RyC 09-02-2006 capc*/	
 
 /* EXEC SQL DECLARE C_CREDITO CURSOR FOR
 SELECT IMPORTE_DEBE,
   		IMPORTE_HABER,
   		COD_CONCEPTO,
   		COLUMNA,
   		SEC_CUOTA
 FROM  CO_CARTERA
 WHERE  NUM_SECUENCI = :lhNumSecuenciC
 AND  COD_TIPDOCUM = :ihCodTipDocumC
 AND  COD_VENDEDOR_AGENTE = :lhCodAgenteC
 AND  LETRA        = :szhLetraC
 AND  COD_CENTREMI = :ihCodCentrEmiC
 --GROUP BY SEC_CUOTA,COD_CONCEPTO,COLUMNA
 ORDER BY SEC_CUOTA; */ 

 
 /* EXEC SQL OPEN C_CREDITO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )24;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenciC;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumC;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodAgenteC;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhLetraC;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentrEmiC;
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
}


 if( sqlca.sqlcode )
 {
  fprintf( fArchLogIn, "ERROR OPEN C_CREDITO => [%s].\n", szfnORAerror() );
  return ERR_OPENCURSOR;
 }
 
 while( TRUE )
 {
  /* EXEC SQL 
  FETCH C_CREDITO
   INTO :dhImpDebeC,
     :dhImpHaberC,
     :ihCodConceptoC,
     :ihColumnaC,
     :ihSecCuotaC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )59;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhImpDebeC;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhImpHaberC;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConceptoC;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihColumnaC;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihSecCuotaC;
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
}


   
  if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != NOT_FOUND )
  {
   fprintf( fArchLogIn, "ERROR FETCH C_CREDITO => [%s].\n", szfnORAerror() );
   iError = ERR_FETCH;
   break;
  }
  
  if( sqlca.sqlcode == NOT_FOUND ) /*no quedan mas clientes*/
   break;
  
  stDatNota.iCodConcepto = ihCodConceptoC;
  stDatNota.iColumna     = ihColumnaC;
  stDatNota.iSecCuota     = ihSecCuotaC;
  dImporteC = dhImpHaberC - dhImpDebeC;
  
  /* manejo de decimales segun la operadora local */
  dImporteC = fnCnvDouble( dImporteC, 0 );
  dImporteCTot += dImporteC;
  
  /* EXEC SQL DECLARE C_FACTURA CURSOR FOR
  SELECT SUM(A.IMPORTE_DEBE),
      	SUM(A.IMPORTE_HABER),
      	/oA.COD_CONCEPTO,
      	A.COLUMNA,
      	A.COD_CLIENTE,
      	A.NUM_FOLIO,o/
      	A.SEC_CUOTA
    FROM CO_CARTERA A
   WHERE A.NUM_SECUENCI = :lhNumSecuenciF
     AND A.COD_TIPDOCUM = :ihCodTipDocumF
     AND A.COD_VENDEDOR_AGENTE = :lhCodAgenteF
     AND A.LETRA        = :szhLetraF
     AND A.COD_CENTREMI = :ihCodCentrEmiF
  GROUP BY A.SEC_CUOTA
  ORDER BY A.SEC_CUOTA; */ 

  
  /* EXEC SQL OPEN C_FACTURA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0003;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )94;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenciF;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumF;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodAgenteF;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhLetraF;
  sqlstm.sqhstl[3] = (unsigned long )2;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentrEmiF;
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
}


  
  if( sqlca.sqlcode )
  {
   fprintf( fArchLogIn, "ERROR OPEN C_FACTURA => [%s].\n", szfnORAerror() );
   iError = ERR_OPENCURSOR;
   break;
  }
  
  while( TRUE )
  {
   /* EXEC SQL 
   FETCH C_FACTURA
    INTO :dhImpDebeF,
      :dhImpHaberF,
      /o:ihCodConceptoF,
      :ihColumnaF,
      :lhCodClienteF,
      :lhNumFolioF,o/
      :ihSecCuotaF; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )129;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhImpDebeF;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&dhImpHaberF;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihSecCuotaF;
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
}


   
   if( sqlca.sqlcode < 0 )
   {
    fprintf( fArchLogIn, "ERROR FETCH C_FACTURA => [%s].\n", szfnORAerror() );
    iError = ERR_FETCH;
    break;
   }
 
   if( sqlca.sqlcode == NOT_FOUND ) /*no quedan mas clientes*/
    break;
 
   /*stDatFact.iCodConcepto = ihCodConceptoF;
   stDatFact.iColumna     = ihColumnaF;*/
   
   /* manejo de decimales segun la operadora local */
   dhImpDebeF = fnCnvDouble( dhImpDebeF, 0 );
   dhImpHaberF = fnCnvDouble( dhImpHaberF, 0 );
   
   dImporteF = dhImpDebeF - dhImpHaberF;
   dImporteF = fnCnvDouble( dImporteF, 0 );
   
   if( dImporteC > 0.00 )
   {
/*    if( dImporteC >= dImporteF )   {*/

		dhValoraPagar = 0.00;
  		
  		if (dImporteC > dImporteF)
			dhValoraPagar = dImporteF;
		else 
			dhValoraPagar = dImporteC;

   		/*****************************************************************************/	
	    fprintf( fArchLogIn, " \n Procesando Registros NC de la CO_CARTERA  \n\n");
		
		iResul = ifnCancelacionParcialCreditos( TiG.lCodCliente  , lhNumSecuenciF, ihCodTipDocumF, 
										 		lhCodAgenteF  , szhLetraF     , ihCodCentrEmiF,
										   		ihSecCuotaF   , dhValoraPagar, lhNumSecuenciC ,
										   		ihCodTipDocumC, lhCodAgenteC  , szhLetraC,
										   		ihCodCentrEmiC, szhFechaP_ddmmyyyy);
		if (iResul != OK)
			return iResul;
		/*********************************************************************************/

     	if( dImporteC >= dImporteF ) {     
     		bResul = bfnDBUpdCartNC( stDatNota, dhValoraPagar, 0 ); /* aumenta el debe de la NCredito */
     		if (!bResul) {
      			iError = ERR_UPDCARTERA;
      			break;
     		}
     	}
     	else if( dImporteC < dImporteF ) {
     	   	bResul = bfnDBInsCancNC( stDatNota, 0 ); /* pasa la N. Credito a cancelados */
     		if (!bResul) {
      			iError = ERR_INSCANCE;
      			break;
    		}
    		bResul = bfnDBDelCartNC( stDatNota );
     		if (!bResul) {
      			iError = ERR_DELCARTERA;
      			break;
     		}
     	}
      	dImporteC -= dhValoraPagar;/*dImporteF;*/
     	dImporteC = fnCnvDouble( dImporteC, 0 );    
     	/*dImpCastigo = dImporteF;*/

/*    else
    {
     	bResul = bfnDBInsCancNC( stDatNota, 0 ); * pasa la N. Credito a cancelados *
     	if (!bResul) {
      		iError = ERR_INSCANCE;
      		break;
     		}
     
     	bResul = bfnDBInsPagConNC( stDatNota, stDatFact, dImporteC );
     	if (!bResul)
     	{
      	iError = ERR_INSPAGOSCON;
      	break;
     	}
     
     	bResul = bfnDBDelCartNC( stDatNota );
     	if (!bResul)
     	{
      	iError = ERR_DELCARTERA;
      	break;
     	}
     
     	dImporteF -= dImporteC;
     	dImporteF = fnCnvDouble( dImporteF, 0 );
	 
     	bResul = bfnDBUpdCartNC( stDatFact, dImporteC, 1 ); * aumenta el haber de la Factura *
     	if (!bResul)
     	{
      		iError = ERR_UPDCARTERA;
      		break;
     	}
     
     	dImpCastigo = dImporteC;
     	dImporteC = 0.00;
    }
*/    
    
    /* llama a rutina que rebaja Castigo asociado a la Factura si corresponde *
    bResul = bfnDBUpdCastigoNC( lhCodClienteF, lhNumFolioF, dImpCastigo );
    
    if (!bResul)
    {
     iError = ERR_UPDCARTERA;
     break;
    }*/
   } /* if (dImporteC > 0.00) */
   
   if( dImporteC == 0.00 )
    break;
  }/*fin while*/
  
  /* EXEC SQL CLOSE C_FACTURA; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )156;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if( sqlca.sqlcode != 0 )
  {
   fprintf( fArchLogIn, "Error CLOSE C_FACTURA => [%s].\n", szfnORAerror() );
   iError = ERR_CLOSECURSOR;
  }
  
  if( iError != OK )
   break;
 }/*fin while*/
 
 /* EXEC SQL CLOSE C_CREDITO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )171;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


 if( sqlca.sqlcode != 0 )
 {
  fprintf( fArchLogIn, "Error CLOSE C_CREDITO => [%s].\n", szfnORAerror() );
  iError = ERR_CLOSECURSOR;
 }
 
 if( iError != OK )
  return iError;
   
 if( dImporteC > 0.00 )
 {
  /*iResul = ifnCancelacionCreditosNC( TiG.lCodCliente, &stDatNota, TiG.iCodCredito, TiG.szFecActual, 0 );*/
  iResul = ifnLlamaCancelacionCred( TiG.lCodCliente, TiG.szFecActual );
  if( iResul )
   return ERR_CANCCRED;
 }
 
 iResul = ifnDBInsDatosPago( TiG.lCodCliente, &stDatNota, dImporteCTot );
 if( iResul != OK )
 {
  return iResul;
 }
 
 return OK;

}/*fin ifnDBProcCredito*/

/*===========================================================================
Funcion    : ifnCancelacionParcialCreditos()
Se crea funcion por Incidencia XO-200509130656, 27-09-2005 rvc Soporte RyC
Descripcion: Funcion encargada de cancelar parcialmente los creditos para un cliente.
Entrada    : lCodCliente 
             stConCre 
             lNumSecuenci 
             iCodTipDocum
             lCodAgente 
             szLetra    
             iCodCentremi
             iCuota 
             szFecPago			 
Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
===========================================================================*/
int ifnCancelacionParcialCreditos(long lCodCliente , long lNumSecuenciF, int iCodTipDocumF, 
								  long lCodAgenteF , char * szLetraF   , int  iCodCentremiF, 
								  int  iCuotaF     , double dImporteF,   long lNumSecuenciP, 
								  int iCodTipDocumP, long lCodAgenteP,   char * szLetraP,
								  int  iCodCentremiP,char * szFecP )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente          ;
	long   lhNumSecuenciaF       ;
	int    ihCodTipDocumF        ;
	long   lhCodAgenteF          ;
	char   szhLetraF          [2];
	int    ihCodCentremiF        ;
	int    ihCuotaF              ;
	double dhImporteF            ;

	long   lhNumSecuenciaP   ;
	int    ihCodTipDocumP    ;
	long   lhCodAgenteP      ;
	char   szhLetraP      [2];
	int    ihCodCentremiP    ;
	char   szhFecP       [20];


/* EXEC SQL END DECLARE SECTION; */ 


    fprintf(fArchLogIn,"modulo [ifnCancelacionParcialCreditos]\n\n");      

	lhCodCliente        = lCodCliente;
	lhNumSecuenciaF     = lNumSecuenciF;
	ihCodTipDocumF      = iCodTipDocumF;
	lhCodAgenteF        = lCodAgenteF;
	strcpy(szhLetraF, szLetraF);
	ihCodCentremiF      = iCodCentremiF;
	ihCuotaF            = iCuotaF;
	dhImporteF          = dImporteF;

	lhNumSecuenciaP = lNumSecuenciP;
	ihCodTipDocumP  = iCodTipDocumP;
	lhCodAgenteP    = lCodAgenteP;
	strcpy(szhLetraP, szLetraP);
	ihCodCentremiP  = iCodCentremiP;
	strcpy(szhFecP, szFecP);

    fprintf(fArchLogIn,"lhCodCliente          [%ld]\n",lhCodCliente );      
    fprintf(fArchLogIn,"lhNumSecuenciaF       [%ld]\n",lhNumSecuenciaF );      
    fprintf(fArchLogIn,"ihCodTipDocumF        [%d]\n",ihCodTipDocumF );      
    fprintf(fArchLogIn,"lhCodAgenteF          [%ld]\n",lhCodAgenteF );      
    fprintf(fArchLogIn,"szhLetraF             [%s]\n",szhLetraF );      
    fprintf(fArchLogIn,"ihCodCentremiF        [%d]\n",ihCodCentremiF );      
    fprintf(fArchLogIn,"lhNumSecuenciaP       [%ld]\n",lhNumSecuenciaP );      
    fprintf(fArchLogIn,"ihCodTipDocumP        [%d]\n",ihCodTipDocumP );      
    fprintf(fArchLogIn,"lhCodAgenteP          [%ld]\n",lhCodAgenteP );      
    fprintf(fArchLogIn,"szhLetraP             [%s]\n",szhLetraP );      
    fprintf(fArchLogIn,"ihCodCentremiP        [%d]\n",ihCodCentremiP );      
    fprintf(fArchLogIn,"dhImporteF            [%f]\n",dhImporteF );      
    fprintf(fArchLogIn,"ihCuotaF              [%d]\n",ihCuotaF );      
    fprintf(fArchLogIn,"szhFecP               [%s]\n",szhFecP );      
    
	/* EXEC SQL EXECUTE
		BEGIN
		  CO_P_PAGO_PARCIALES_FACTURA(:lhCodCliente    , :lhNumSecuenciaF , :ihCodTipDocumF , 
                                      :lhCodAgenteF    , :szhLetraF       , :ihCodCentremiF , 
                                      :lhNumSecuenciaP , :ihCodTipDocumP  , :lhCodAgenteP   , 
                                      :szhLetraP       , :ihCodCentremiP  , :dhImporteF     , 
                                      :ihCuotaF        , :szhFecP) ;
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_P_PAGO_PARCIALES_FACTURA ( :lhCodCliente , :lhNumSe\
cuenciaF , :ihCodTipDocumF , :lhCodAgenteF , :szhLetraF , :ihCodCentremiF , :l\
hNumSecuenciaP , :ihCodTipDocumP , :lhCodAgenteP , :szhLetraP , :ihCodCentremi\
P , :dhImporteF , :ihCuotaF , :szhFecP ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )186;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenciaF;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumF;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgenteF;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetraF;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremiF;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumSecuenciaP;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocumP;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCodAgenteP;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhLetraP;
 sqlstm.sqhstl[9] = (unsigned long )2;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihCodCentremiP;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&dhImporteF;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&ihCuotaF;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhFecP;
 sqlstm.sqhstl[13] = (unsigned long )20;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
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
}


	
  	fprintf(fArchLogIn,"\n Fin a Cancelacion Parcial de Creditos.\n\n");

	return 0;

} /* end if ifnCancelacionParcialCreditos()*/

/******************************************************************************/
int ifnProcDebito()
/**
**/
{
int   iResul;

	/*iResul = ifnCancelacionCreditosNC( TiG.lCodCliente, &stDatFact, TiG.iCodCredito, TiG.szFecActual, 0 );*/
	iResul = ifnLlamaCancelacionCred( TiG.lCodCliente, TiG.szFecActual );
	if( iResul )
	{
		return ERR_CANCCRED;
	}
	
	return OK;
}/*fin ifnProcDebito*/
/******************************************************************************/
BOOL bfnDBInsCancNC( DATCON stGen, int iDebeHaber )
/**
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      long lhNumSecuenci;
      int  ihCodTipDocum;
      long lhCodAgente;
      char szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int  ihCodCentrEmi;
      int  ihCodConcepto;
      int  ihDebeHaber;
      int  ihColumna;
      int  ihSecCuota;
      char szhFecPago[9]; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


	lhNumSecuenci = stGen.lNumSecuenci;
	ihCodTipDocum = stGen.iCodTipDocum;
	lhCodAgente   = stGen.lCodAgente;
	strcpy(szhLetra, stGen.szLetra);
	ihCodCentrEmi = stGen.iCodCentremi;
	ihCodConcepto = stGen.iCodConcepto;
	ihColumna     = stGen.iColumna;
	ihSecCuota    = stGen.iSecCuota;
	strcpy(szhFecPago, TiG.szFecActual);
	ihDebeHaber   = iDebeHaber;

	fprintf( fArchLogIn, 	"Parametros entrada bfnDBInsCancNC\n"
						"\tlhNumSecuenci => [%d]\n"
						"\tihCodTipDocum => [%d]\n"
						"\tlhCodAgente   => [%d]\n"
						"\tszhLetra      => [%s]\n"
						"\tihCodCentrEmi => [%d]\n"
						"\tihCodConcepto => [%d]\n"
						"\tihColumna     => [%d]\n"
						"\tihSecCuota    => [%d]\n"
						"\tszhFecPago    => [%s]\n"
						"\tihDebeHaber   => [%d]\n\n",
						lhNumSecuenci,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentrEmi,
						ihCodConcepto,
						ihColumna,
						ihSecCuota,						
						szhFecPago,
						ihDebeHaber );


	if (ihDebeHaber) /* Cancela la Factura */
	{
   		/* EXEC SQL 
   		INSERT INTO CO_CANCELADOS (	COD_CLIENTE, 
   									NUM_SECUENCI, 
   									COD_TIPDOCUM, 
   									COD_VENDEDOR_AGENTE,
                    				LETRA, 
                    				COD_CENTREMI, 
                    				COD_CONCEPTO, 
                    				COLUMNA, 
                    				COD_PRODUCTO, 
                    				IMPORTE_DEBE, 
                    				IMPORTE_HABER,
                    				IND_CONTADO, 
                    				IND_FACTURADO, 
                    				FEC_EFECTIVIDAD, 
                    				FEC_CANCELACION, 
                    				IND_PORTADOR, 
                    				FEC_VENCIMIE,
                    				FEC_CADUCIDA, 
                    				FEC_ANTIGUEDAD, 
                    				NUM_ABONADO, 
                    				NUM_FOLIO, 
                    				FEC_PAGO, 
                    				NUM_CUOTA, 
                    				SEC_CUOTA,
                    				NUM_TRANSACCION, 
                    				NUM_VENTA, 
                    				NUM_FOLIOCTC,
					                PREF_PLAZA         , /o jlr_11.01.03 o/
       								COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
       								COD_PLAZA          ) /o jlr_11.01.03 o/
		SELECT	COD_CLIENTE, 
				NUM_SECUENCI, 
				COD_TIPDOCUM, 
				COD_VENDEDOR_AGENTE, 
				LETRA, 
				COD_CENTREMI,
				COD_CONCEPTO,
				COLUMNA, 
				COD_PRODUCTO, 
				IMPORTE_DEBE, 
				IMPORTE_DEBE, /o el haber debe ser igual al debe o/
				IND_CONTADO, 
				IND_FACTURADO, 
				FEC_EFECTIVIDAD, 
				SYSDATE, 
				0, 
				FEC_VENCIMIE, 
				FEC_CADUCIDA,
				FEC_ANTIGUEDAD, 
				NUM_ABONADO, 
				NUM_FOLIO, 
				TO_DATE( :szhFecPago, 'yyyymmdd' ), 
				NUM_CUOTA,
				SEC_CUOTA, 
				NUM_TRANSACCION, 
				NUM_VENTA, 
				NUM_FOLIOCTC,
	        	NVL(PREF_PLAZA,' ')         , /o jlr_11.01.03 o/
				NVL(COD_OPERADORA_SCL,' ')  , /o jlr_11.01.03 o/
				NVL(COD_PLAZA,' ')            /o jlr_11.01.03 o/
		FROM 	CO_CARTERA
		WHERE	NUM_SECUENCI = :lhNumSecuenci 
		AND		COD_TIPDOCUM = :ihCodTipDocum 
		AND		COD_VENDEDOR_AGENTE = :lhCodAgente 
		AND		LETRA = :szhLetra 
		AND		COD_CENTREMI = :ihCodCentrEmi 
		AND     SEC_CUOTA    = :ihSecCuota
		AND		COD_CONCEPTO = :ihCodConcepto 
		AND		COLUMNA      = :ihColumna; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlbuft((void **)0, 
       "insert into CO_CANCELADOS (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD\
_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMPORT\
E_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CANCELACI\
ON,IND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,NUM_ABONADO,NUM_FOL\
IO,FEC_PAGO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_\
PLAZA,COD_OPERADORA_SCL,COD_PLAZA)select COD_CLIENTE ,NUM_SECUENCI ,COD_TIPD\
OCUM ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COD_CONCEPTO ,COLUMNA ,COD_P\
RODUCTO ,IMPORTE_DEBE ,IMPORTE_DEBE ,IND_CONTADO ,IND_FACTURADO ,FEC_EFECTIV\
IDAD ,SYSDATE ,0 ,FEC_VENCIMIE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,NUM_ABONADO ,N\
UM_FOLIO ,TO_DATE(:b0,'yyyymmdd') ,NUM_CUOTA ,SEC_CUOTA ,NUM_TRANSACCION ,NU\
M_VENTA ,NUM_FOLIOCTC ,NVL(PREF_PLAZA,' ') ,NVL(COD_OPERADORA_SCL,' ') ,NVL(\
COD_PLAZA,' ')  from CO_CARTERA where (((((((NUM_SECUENCI=:b1 and COD_TIPDOC\
UM=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD_CENTREMI=:b5) an\
d SEC_CUOTA=:b6) and COD_CONCEPT");
     sqlstm.stmt = "O=:b7) and COLUMNA=:b8)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )257;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhFecPago;
     sqlstm.sqhstl[0] = (unsigned long )9;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenci;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
     sqlstm.sqhstl[4] = (unsigned long )2;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmi;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&ihSecCuota;
     sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
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
}


	}
	else /* cancela la Nota de Credito */
	{
		/* EXEC SQL 
		INSERT INTO CO_CANCELADOS (	COD_CLIENTE, 
									NUM_SECUENCI, 
									COD_TIPDOCUM, 
									COD_VENDEDOR_AGENTE,
									LETRA, 
									COD_CENTREMI, 
									COD_CONCEPTO, 
									COLUMNA, 
									COD_PRODUCTO, 
									IMPORTE_DEBE, 
									IMPORTE_HABER,
									IND_CONTADO, 
									IND_FACTURADO, 
									FEC_EFECTIVIDAD, 
									FEC_CANCELACION, 
									IND_PORTADOR, 
									FEC_VENCIMIE,
									FEC_CADUCIDA, 
									FEC_ANTIGUEDAD, 
									NUM_ABONADO, 
									NUM_FOLIO, 
									FEC_PAGO,
									NUM_CUOTA,
									SEC_CUOTA,
									NUM_TRANSACCION,
									NUM_VENTA,
									NUM_FOLIOCTC,
					                PREF_PLAZA         , /o jlr_11.01.03 o/
       								COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
       								COD_PLAZA          ) /o jlr_11.01.03 o/
		SELECT	COD_CLIENTE, 
				NUM_SECUENCI, 
				COD_TIPDOCUM, 
				COD_VENDEDOR_AGENTE, 
				LETRA, 
				COD_CENTREMI,
				COD_CONCEPTO, 
				COLUMNA, 
				COD_PRODUCTO, 
				IMPORTE_HABER, /o el Debe debe ser igual al Haber o/ 
				IMPORTE_HABER,
				IND_CONTADO, 
				IND_FACTURADO, 
				FEC_EFECTIVIDAD, 
				SYSDATE, 
				0, 
				FEC_VENCIMIE, 
				FEC_CADUCIDA,
				FEC_ANTIGUEDAD, 
				NUM_ABONADO, 
				NUM_FOLIO, 
				TO_DATE( :szhFecPago, 'yyyymmdd' ), 
				NUM_CUOTA,
				SEC_CUOTA, 
				NUM_TRANSACCION, 
				NUM_VENTA, 
				NUM_FOLIOCTC,
	        	NVL(PREF_PLAZA,' ')         , /o jlr_11.01.03 o/
				NVL(COD_OPERADORA_SCL,' ')  , /o jlr_11.01.03 o/
				NVL(COD_PLAZA,' ')            /o jlr_11.01.03 o/
		FROM 	CO_CARTERA
		WHERE	NUM_SECUENCI = :lhNumSecuenci 
		AND		COD_TIPDOCUM = :ihCodTipDocum 
		AND		COD_VENDEDOR_AGENTE = :lhCodAgente 
		AND		LETRA = :szhLetra 
		AND		COD_CENTREMI = :ihCodCentrEmi 
		AND     SEC_CUOTA    = :ihSecCuota
		AND		COD_CONCEPTO = :ihCodConcepto 
		AND		COLUMNA      = :ihColumna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlbuft((void **)0, 
    "insert into CO_CANCELADOS (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCUM,COD_VE\
NDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMPORTE_D\
EBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CANCELACION,\
IND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,NUM_ABONADO,NUM_FOLIO,\
FEC_PAGO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLA\
ZA,COD_OPERADORA_SCL,COD_PLAZA)select COD_CLIENTE ,NUM_SECUENCI ,COD_TIPDOCU\
M ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COD_CONCEPTO ,COLUMNA ,COD_PROD\
UCTO ,IMPORTE_HABER ,IMPORTE_HABER ,IND_CONTADO ,IND_FACTURADO ,FEC_EFECTIVI\
DAD ,SYSDATE ,0 ,FEC_VENCIMIE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,NUM_ABONADO ,NU\
M_FOLIO ,TO_DATE(:b0,'yyyymmdd') ,NUM_CUOTA ,SEC_CUOTA ,NUM_TRANSACCION ,NUM\
_VENTA ,NUM_FOLIOCTC ,NVL(PREF_PLAZA,' ') ,NVL(COD_OPERADORA_SCL,' ') ,NVL(C\
OD_PLAZA,' ')  from CO_CARTERA where (((((((NUM_SECUENCI=:b1 and COD_TIPDOCU\
M=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD_CENTREMI=:b5) and\
 SEC_CUOTA=:b6) and COD_CONCEPTO=:b7) and");
  sqlstm.stmt = " COLUMNA=:b8)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )308;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecPago;
  sqlstm.sqhstl[0] = (unsigned long )9;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
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
}


	}

	if( sqlca.sqlcode )
	{
		fprintf( fArchLogIn, "Error INSERT CO_CANCELADOS => [%s].\n", szfnORAerror() );
		return FALSE;
	}

   return TRUE;
}/*fin bfnDBInsCancNC(.)*/
/******************************************************************************/
BOOL bfnDBInsPagConNC(DATCON stGenNota, DATCON stGenFact, double dImporte)
/**
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhNumSecuenci;
		int    ihCodTipDocum;
		long   lhCodAgente;
		char   szhLetra[2];     /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int    ihCodCentrEmi;
		double dhImporte;
		long   lhNumSecuenciF;
		int    ihCodTipDocumF;
		long   lhCodAgenteF;
		char   szhLetraF[2];    /* EXEC SQL VAR szhLetraF IS STRING(2); */ 

		int    ihCodCentrEmiF;
		int    ihCodConceptoF;
		int    ihColumnaF;
		char   szhPrefPlazaF[26];       /* EXEC SQL VAR szhPrefPlazaF IS STRING(26); */ 

		char   szhCodOperadoraSclF[6]; /* EXEC SQL VAR szhCodOperadoraSclF IS STRING(6); */ 
 /* jlr_11.01.03 */
		char   szhCodPlazaF[6];        /* EXEC SQL VAR szhCodPlazaF IS STRING(6); */ 
        /* jlr_11.01.03 */
	/* EXEC SQL END DECLARE SECTION; */ 


	lhNumSecuenci  = stGenNota.lNumSecuenci;
	ihCodTipDocum  = stGenNota.iCodTipDocum;
	lhCodAgente    = stGenNota.lCodAgente;
	strcpy(szhLetra, stGenNota.szLetra);
	ihCodCentrEmi  = stGenNota.iCodCentremi;
	dhImporte      = dImporte;
	lhNumSecuenciF = stGenFact.lNumSecuenci;
	ihCodTipDocumF = stGenFact.iCodTipDocum;
	lhCodAgenteF   = stGenFact.lCodAgente;
	strcpy(szhLetraF, stGenFact.szLetra);
	ihCodCentrEmiF = stGenFact.iCodCentremi;
	ihCodConceptoF = stGenFact.iCodConcepto;
	ihColumnaF     = stGenFact.iColumna;
	strcpy(szhPrefPlazaF, stGenFact.szPrefPlaza);			/* jlr_11.01.03 */
	strcpy(szhCodOperadoraSclF,stGenFact.szCodOperadoraScl);/* jlr_11.01.03 */
	strcpy(szhCodPlazaF, stGenFact.szCodPlaza);				/* jlr_11.01.03 */

	/* manejo de decimales segun la operadora local */
	dhImporte = fnCnvDouble( dhImporte, 0 );

	fprintf( fArchLogIn, 	"Parametros entrada bfnDBInsPagConNC\n\n"
						"\tlhNumSecuenci  => [%d]\n"
						"\tihCodTipDocum  => [%d]\n"
						"\tlhCodAgente    => [%d]\n"
						"\tszhLetra       => [%s]\n"
						"\tihCodCentrEmi  => [%d]\n"
						"\tdhImporte      => [%.2f]\n"
						"\tlhNumSecuenciF => [%d]\n"
						"\tihCodTipDocumF => [%d]\n"
						"\tlhCodAgenteF   => [%d]\n"
						"\tszhLetraF      => [%s]\n"
						"\tihCodCentrEmiF => [%d]\n"
						"\tihCodConceptoF => [%d]\n"
						"\tihColumnaF     => [%d]\n"
						"\tszPrefPlazaF   => [%s]\n"   /* jlr_11.01.03 */
						"\tszCodOperadoraF=> [%s]\n"   /* jlr_11.01.03 */
						"\tszCodPlazaF    => [%s]\n\n" /* jlr_11.01.03 */
						,
						lhNumSecuenci,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentrEmi,
						dhImporte,
						lhNumSecuenciF,
						ihCodTipDocumF,
						lhCodAgenteF,
						szhLetraF,
						ihCodCentrEmiF,
						ihCodConceptoF,
						ihColumnaF,
						szhPrefPlazaF,       /* jlr_11.01.03 */
						szhCodOperadoraSclF, /* jlr_11.01.03 */
						szhCodPlazaF         /* jlr_11.01.03 */
						 );

   /* EXEC SQL INSERT INTO CO_PAGOSCONC
                        (NUM_SECUENCI,
                         COD_TIPDOCUM,
                         COD_VENDEDOR_AGENTE,
                         LETRA,
                         COD_CENTREMI,
                         IMP_CONCEPTO,
                         COD_PRODUCTO,
                         NUM_SECUREL,
                         COD_TIPDOCREL,
                         COD_AGENTEREL,
                         LETRA_REL,
                         COD_CENTRREL,
                         COD_CONCEPTO,
                         COLUMNA,
                         NUM_ABONADO,
                         NUM_FOLIO,
                         NUM_CUOTA,
                         SEC_CUOTA,
                         NUM_TRANSACCION,
                         NUM_VENTA,
			 			 NUM_FOLIOCTC,
			 			 PREF_PLAZA         , /o jlr_11.01.03 o/
						 COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
						 COD_PLAZA            /o jlr_11.01.03 o/
			 )
              SELECT :lhNumSecuenci,
                     :ihCodTipDocum,
                     :lhCodAgente,
                     :szhLetra,
                     :ihCodCentrEmi,
                     :dhImporte,
                     COD_PRODUCTO,
                     NUM_SECUENCI,
                     COD_TIPDOCUM,
                     COD_VENDEDOR_AGENTE,
                     LETRA,
                     COD_CENTREMI,
                     COD_CONCEPTO, 
                     COLUMNA,
                     NUM_ABONADO,
                     NUM_FOLIO,
                     NUM_CUOTA,
                     SEC_CUOTA,
                     NUM_TRANSACCION,
                     NUM_VENTA,
					 NUM_FOLIOCTC,
		     		 NVL(PREF_PLAZA,' '), 			/o jlr_11.01.03 o/
		     		 NVL(COD_OPERADORA_SCL,' '), 	/o jlr_11.01.03 o/
		     		 NVL(COD_PLAZA,' ')         	/o jlr_11.01.03 o/
             FROM CO_CARTERA
             WHERE NUM_SECUENCI = :lhNumSecuenciF AND
                   COD_TIPDOCUM = :ihCodTipDocumF AND
                   COD_VENDEDOR_AGENTE = :lhCodAgenteF AND
                   LETRA = :szhLetraF AND
                   COD_CENTREMI = :ihCodCentrEmiF AND
                   COD_CONCEPTO = :ihCodConceptoF AND
                   COLUMNA = :ihColumnaF; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_PAGOSCONC (NUM_SECUENCI,COD_TIPDOCUM,COD_VE\
NDEDOR_AGENTE,LETRA,COD_CENTREMI,IMP_CONCEPTO,COD_PRODUCTO,NUM_SECUREL,COD_TIP\
DOCREL,COD_AGENTEREL,LETRA_REL,COD_CENTRREL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,N\
UM_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLAZA\
,COD_OPERADORA_SCL,COD_PLAZA)select :b0 ,:b1 ,:b2 ,:b3 ,:b4 ,:b5 ,COD_PRODUCTO\
 ,NUM_SECUENCI ,COD_TIPDOCUM ,COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COD_CO\
NCEPTO ,COLUMNA ,NUM_ABONADO ,NUM_FOLIO ,NUM_CUOTA ,SEC_CUOTA ,NUM_TRANSACCION\
 ,NUM_VENTA ,NUM_FOLIOCTC ,NVL(PREF_PLAZA,' ') ,NVL(COD_OPERADORA_SCL,' ') ,NV\
L(COD_PLAZA,' ')  from CO_CARTERA where ((((((NUM_SECUENCI=:b6 and COD_TIPDOCU\
M=:b7) and COD_VENDEDOR_AGENTE=:b8) and LETRA=:b9) and COD_CENTREMI=:b10) and \
COD_CONCEPTO=:b11) and COLUMNA=:b12)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )359;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&dhImporte;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhNumSecuenciF;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocumF;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhCodAgenteF;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhLetraF;
   sqlstm.sqhstl[9] = (unsigned long )2;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&ihCodCentrEmiF;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&ihCodConceptoF;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihColumnaF;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
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
}



	if (sqlca.sqlcode)
	{
		fprintf( fArchLogIn, "Error INSERT CO_PAGOSCONC => [%s].\n", szfnORAerror() );
		return FALSE;
	}

   return TRUE;
}/*fin bfnDBInsPagConNC*/
/******************************************************************************/
BOOL bfnDBDelCartNC(DATCON stGen)
/**
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhNumSecuenci;
		int  ihCodTipDocum;
		long lhCodAgente;
		char szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int  ihCodCentrEmi;
		int  ihCodConcepto;
		int  ihColumna;
		int  ihSecCuota;
		char szhFecPago[9]; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhNumSecuenci = stGen.lNumSecuenci;
	ihCodTipDocum = stGen.iCodTipDocum;
	lhCodAgente   = stGen.lCodAgente;
	strcpy(szhLetra, stGen.szLetra);
	ihCodCentrEmi = stGen.iCodCentremi;
	ihCodConcepto = stGen.iCodConcepto;
	ihColumna     = stGen.iColumna;
	ihSecCuota    = stGen.iSecCuota;	

	fprintf( fArchLogIn,	"Datos de Entrada bfnDBDelCartNC \n\n"
						"\tlhNumSecuenci => [%d],\n"
						"\tihCodTipDocum => [%d],\n"
						"\tlhCodAgente   => [%d],\n"
						"\tszhLetra      => [%s],\n"
						"\tihCodCentrEmi => [%d],\n"
						"\tihCodConcepto => [%d],\n"
						"\tihColumna     => [%d],\n"
						"\tihSecCuota    => [%d],\n\n",
						lhNumSecuenci,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentrEmi,
						ihCodConcepto,
						ihColumna,
						ihSecCuota );

   /* EXEC SQL DELETE CO_CARTERA 
            WHERE NUM_SECUENCI = :lhNumSecuenci AND
                  COD_TIPDOCUM = :ihCodTipDocum AND
                  COD_VENDEDOR_AGENTE = :lhCodAgente AND
                  LETRA        = :szhLetra AND
                  COD_CENTREMI = :ihCodCentrEmi AND
                  SEC_CUOTA    = :ihSecCuota AND
                  COD_CONCEPTO = :ihCodConcepto AND
                  COLUMNA      = :ihColumna; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "delete  from CO_CARTERA  where (((((((NUM_SECUENCI=:b0 and\
 COD_TIPDOCUM=:b1) and COD_VENDEDOR_AGENTE=:b2) and LETRA=:b3) and COD_CENTREM\
I=:b4) and SEC_CUOTA=:b5) and COD_CONCEPTO=:b6) and COLUMNA=:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )426;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihSecCuota;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
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
}



   if (sqlca.sqlcode)
   {
		fprintf( fArchLogIn, "Error DELETE CO_CARTERA => [%s].\n", szfnORAerror() );
		return FALSE;
   }

   return TRUE;
}/*fin bfnDBDelCartNC(.)*/
/******************************************************************************/
BOOL bfnDBUpdCartNC(DATCON stGen, double dImporte, int iDebHab)
/**
**/
{
	BOOL bResul;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhNumSecuenci;
		int    ihCodTipDocum;
		long   lhCodAgente;
		char   szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int    ihCodCentrEmi;
		int    ihCodConcepto;
		int    ihColumna;
		int    ihSecCuota;
		char   szhFecPago[9]; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

		double dhImporte;
		double dhImpD;
		double dhImpH;
	/* EXEC SQL END DECLARE SECTION; */ 


	lhNumSecuenci = stGen.lNumSecuenci;
	ihCodTipDocum = stGen.iCodTipDocum;
	lhCodAgente   = stGen.lCodAgente;
	strcpy(szhLetra, stGen.szLetra);
	ihCodCentrEmi = stGen.iCodCentremi;
	ihCodConcepto = stGen.iCodConcepto;
	ihColumna     = stGen.iColumna;
	ihSecCuota    = stGen.iSecCuota;
	dhImporte     = dImporte;

	fprintf( fArchLogIn,	" Datos de Entrada bfnDBUpdCartNC \n\n"
						"\tlhNumSecuenci => [%d],\n"
						"\tihCodTipDocum => [%d],\n"
						"\tlhCodAgente   => [%d],\n"
						"\tszhLetra      => [%s],\n"
						"\tihCodCentrEmi => [%d],\n"
						"\tihCodConcepto => [%d],\n"
						"\tihColumna     => [%d],\n"
						"\tihSecCuota    => [%d],\n"
						"\tdhImporte     => [%.2f],\n"
						"\tiDebHab       => [%d],\n\n",
						lhNumSecuenci,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentrEmi,
						ihCodConcepto,
						ihColumna,
						ihSecCuota,
						dhImporte,
						iDebHab );

	if( !iDebHab ) /*aumentamos el debe de la NCredito*/
	{
		/* manejo de decimales segun la operadora local */
		dImporte = fnCnvDouble( dImporte, 0 );

		/* EXEC SQL
		UPDATE	CO_CARTERA
		SET		IMPORTE_DEBE = IMPORTE_DEBE + :dImporte
		WHERE	NUM_SECUENCI = :lhNumSecuenci
		AND		COD_TIPDOCUM = :ihCodTipDocum 
		AND		COD_VENDEDOR_AGENTE = :lhCodAgente
		AND		LETRA		 = :szhLetra
		AND		COD_CENTREMI = :ihCodCentrEmi
		AND     SEC_CUOTA    = :ihSecCuota
		AND		COD_CONCEPTO = :ihCodConcepto
		AND		COLUMNA 	 = :ihColumna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_CARTERA  set IMPORTE_DEBE=(IMPORTE_DEBE+:b0) wher\
e (((((((NUM_SECUENCI=:b1 and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3) a\
nd LETRA=:b4) and COD_CENTREMI=:b5) and SEC_CUOTA=:b6) and COD_CONCEPTO=:b7) a\
nd COLUMNA=:b8)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )473;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dImporte;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
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
}


	}
	else /*aumentamos el haber de la factura asociada*/
	{
		/* manejo de decimales segun la operadora local */
		dImporte = fnCnvDouble( dImporte, 0 );

		/* EXEC SQL
		UPDATE	CO_CARTERA
		SET		IMPORTE_HABER = IMPORTE_HABER + :dImporte
		WHERE	NUM_SECUENCI = :lhNumSecuenci 
		AND		COD_TIPDOCUM = :ihCodTipDocum 
		AND		COD_VENDEDOR_AGENTE = :lhCodAgente 
		AND		LETRA = :szhLetra 
		AND		COD_CENTREMI = :ihCodCentrEmi 
		AND     SEC_CUOTA    = :ihSecCuota	
		AND		COD_CONCEPTO = :ihCodConcepto 
		AND		COLUMNA 	 = :ihColumna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_CARTERA  set IMPORTE_HABER=(IMPORTE_HABER+:b0) wh\
ere (((((((NUM_SECUENCI=:b1 and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3)\
 and LETRA=:b4) and COD_CENTREMI=:b5) and SEC_CUOTA=:b6) and COD_CONCEPTO=:b7)\
 and COLUMNA=:b8)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )524;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dImporte;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
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
}


	}

	if (sqlca.sqlcode)
	{
		fprintf( fArchLogIn, "Error UPDATE CO_CARTERA NC => [%s].\n", szfnORAerror() );
		return FALSE;
	}

	if (!iDebHab) /*aumentamos el debe de la NCredito*/
	{
		/* EXEC SQL
		SELECT	IMPORTE_DEBE, IMPORTE_HABER
		INTO	:dhImpD, :dhImpH
		FROM	CO_CARTERA
		WHERE	NUM_SECUENCI 	= :lhNumSecuenci AND
				COD_TIPDOCUM 		= :ihCodTipDocum AND
				COD_VENDEDOR_AGENTE = :lhCodAgente AND
				LETRA        		= :szhLetra AND
				COD_CENTREMI 		= :ihCodCentrEmi AND
			    SEC_CUOTA    		= :ihSecCuota AND
				COD_CONCEPTO 		= :ihCodConcepto AND
				COLUMNA      		= :ihColumna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select IMPORTE_DEBE ,IMPORTE_HABER into :b0,:b1  from CO_CA\
RTERA where (((((((NUM_SECUENCI=:b2 and COD_TIPDOCUM=:b3) and COD_VENDEDOR_AGE\
NTE=:b4) and LETRA=:b5) and COD_CENTREMI=:b6) and SEC_CUOTA=:b7) and COD_CONCE\
PTO=:b8) and COLUMNA=:b9)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )575;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhImpD;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhImpH;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[5] = (unsigned long )2;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentrEmi;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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
}



		if (sqlca.sqlcode)
		{
			fprintf( fArchLogIn, "Error SELECT CO_CARTERA NC => [%s].\n", szfnORAerror() );
			return FALSE;
		}

		if (dhImpD == dhImpH)
		{
			bResul = bfnDBInsCancNC(stGen, 1);
			if (!bResul)
			{
				return ERR_INSCANCE;
			}

			bResul = bfnDBDelCartNC(stGen);
			if (!bResul)
			{
				return ERR_DELCARTERA;
			}
		}
	}

	return TRUE;
}/*fin bfnDBUpdCartNC*/
/******************************************************************************/
/*int ifnCancelacionCreditosNC( long lCodCliente, DATCON *stConCar, int iCodCredito, char *szFec, int iCarrier )*/
int ifnLlamaCancelacionCred( long lCodCliente, char *szFec_pago)
/**
Descripcion: Funcion encargada de cancelar los creditos para un cliente.
Entrada    : lCodCliente, codigo de cliente.
             iCodCredito, es el codigo del credito.
Salida     : TRUE, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/
{
int      iResul = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNum_Transaccion     ;
	long lhCodCliente          ;
	char szhFec_Pago       [20];
	int  ihRetorno             ;
	char szhGlosa         [500];
	int  ihCarrier  = 0        ;
/* EXEC SQL END DECLARE SECTION; */ 

	
	/* Si el cliente tiene los pagos restringidos no permitimos alterar
	la cartera */
	/* -------------------------------------------------------------------
	if (stCli.iIndPagos == 0)
	return ERR_PAGRES;
	---  Lo comento por si facturacion  ----
	---------------------------------------------------------------------*/
	
	/* Cancelar Creditos 
	iResul = ifnDBCancelacionNC(lCodCliente,stConCar,iCodCredito,szFec,iCarrier);
	if (iResul)
		return iResul;*/
		
	fprintf( fArchLogIn, "En funcion ifnLlamaCancelacionCred().\n" );
	/*---------------------------------------------------------------------*/
	fprintf( fArchLogIn,"CO_CANCELACION_PG.CO_CANCELACREDITOS_PR\n");
	
	memset(szhGlosa,'\0',sizeof(szhGlosa));
	memset(szhFec_Pago,'\0',sizeof(szhFec_Pago));
	ihRetorno=99;

	/* EXEC SQL
	SELECT GA_SEQ_TRANSACABO.NEXTVAL
	INTO   :lhNum_Transaccion
	FROM   DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )630;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_Transaccion;
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
}


	if (sqlca.sqlcode != SQLOK) {
	    fprintf( fArchLogIn,"En SELECT GA_SEQ_TRANSACABO.NEXTVAL.", szfnORAerror() );
	    return -1;
	}
	
	lhCodCliente=lCodCliente;
	strncpy(szhFec_Pago,szFec_pago,8);
	szhFec_Pago[8] = '\0';

	fprintf( fArchLogIn,"\n\t\t******************************"
							"\n\t\t=> lhCodCliente      [%ld]"
							"\n\t\t=> szFecPago         [%s] "
							"\n\t\t=> lhNum_Transaccion [%ld]\n\n",lhCodCliente ,szhFec_Pago, lhNum_Transaccion );

	/* EXEC SQL EXECUTE
		BEGIN
				CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(:lhCodCliente, TO_DATE(:szhFec_Pago,'YYYYMMDD'), :lhNum_Transaccion , :ihCarrier , NULL , NULL , NULL, :ihRetorno , :szhGlosa );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_CANCELACION_PG . CO_CANCELACREDITOS_PR ( :lhCodClie\
nte , TO_DATE ( :szhFec_Pago , 'YYYYMMDD' ) , :lhNum_Transaccion , :ihCarrier \
, NULL , NULL , NULL , :ihRetorno , :szhGlosa ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )649;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFec_Pago;
 sqlstm.sqhstl[1] = (unsigned long )20;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_Transaccion;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCarrier;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihRetorno;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhGlosa;
 sqlstm.sqhstl[5] = (unsigned long )500;
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


	
	if (sqlca.sqlcode != SQLOK ) {
  	 	if (sqlca.sqlcode != -1405 ) {  /* Soporte RyC 34635 - Colombia 16.11.2006 */
        	fprintf( fArchLogIn,"En CO_CANCELACREDITOS_PR.\n", szfnORAerror() );
        	return -1;
     	}
	}



   if (ihRetorno == 99) {
   	fprintf( fArchLogIn,"Valor de Retorno es 99. Posible error en la PL\n", szfnORAerror() );
   
   }
   else if (ihRetorno != 0)   {
   	fprintf( fArchLogIn,"Valor ihRetorno [%d]\n",ihRetorno);
   	fprintf( fArchLogIn,"En CO_CANCELACREDITOS_PR. [%s]\n ",szhGlosa);
   
   }

  	fprintf( fArchLogIn,"Fin a Cancelacion de Creditos. <== %d ==>\n\n",ihRetorno);
	return ihRetorno;
		
}/* Fin ifnLlamaCancelacionCred() */



/******************************************************************************/
BOOL bfnDBObtFechaFA(char *szDia)
/**
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhDia[5];       /* EXEC SQL VAR szhDia IS STRING(5); */ 

		char szhFecActual[9]; /* EXEC SQL VAR szhFecActual IS STRING(9); */ 

	/* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL 
	SELECT 	TO_CHAR(SYSDATE,'YDDD'),
			TO_CHAR(SYSDATE,'YYYYMMDD')
	INTO 	:szhDia,
			:szhFecActual
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(SYSDATE,'YDDD') ,TO_CHAR(SYSDATE,'YYYYMMDD') \
into :b0,:b1  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )688;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDia;
 sqlstm.sqhstl[0] = (unsigned long )5;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecActual;
 sqlstm.sqhstl[1] = (unsigned long )9;
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



	if( sqlca.sqlcode )
	{
		fprintf( fArchLogIn, "Error bfnDBObtFechaFA SELECT => [%s].\n", szfnORAerror() );
		return FALSE;
	}
	
	strcpy( szDia, szhDia );
	strcpy( TiG.szFecActual, szhFecActual );

	return TRUE;
}/*fin bfnObtFechaFA*/
/******************************************************************************/

int ifnDBInsDatosPago(long lCodCliente, DATCON *stDatNota, double dImpPago)
/**
Inserta registro en co_pagos  con los datos de la estructura.
En caso de error devuelve FALSE.
**/
{
	int iResul;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int    ihCodTipDocum     ;
		int    ihCodCentrEmi     ;
		long   lhNumSecuenci     ;
		long   lhCodAgente       ;
		char   szhLetra[2]       ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		long   lhCodCliente      ;
		double dhImpPago         ;
		char   szhCodCaja[5]     ; /* EXEC SQL VAR szhCodCaja IS STRING(5); */ 

		short shIndCaja          ;
		char  szhFecValor[9]     ; /* EXEC SQL VAR szhFecValor IS STRING(9); */ 

		short  shIndContado      ;
		int    ihCodSisPago      ;
		int    ihCodOriPago      ;
		int    ihCodCauPago      ;
		char   szhCodBanco[4]    ; /* EXEC SQL VAR szhCodBanco IS STRING(4); */ 

		short  shIndCodBan       ;
		char  szhCodSucursal[5]  ; /* EXEC SQL VAR szhCodSucursal IS STRING(5); */ 

		short  shIndCodSuc       ;
		char  szhCtaCorriente[16]; /* EXEC SQL VAR szhCtaCorriente IS STRING(16); */ 

		short  shIndCtaCor       ;
		char  szhCodTipTarjeta[4]; /* EXEC SQL VAR szhCodTipTarjeta IS STRING(4); */ 

		short  shIndCodTipTar    ;
		char  szhNumTarjeta[21]  ; /* EXEC SQL VAR szhNumTarjeta IS STRING(21); */ 

		short  shIndNumTar       ;
		char  szhDesPago[41]     ; /* EXEC SQL VAR szhDesPago IS STRING(41); */ 

		char  szhNomUsuarioOraMain[31]; /* EXEC SQL VAR szhNomUsuarioOraMain IS STRING(31); */ 
 /* GAC 08-08-2003 (Homolog.) */
	/* EXEC SQL END DECLARE SECTION; */ 


	/* Preparar valores para insercion en co_pagos */
	lhNumSecuenci = stDatNota->lNumSecuenci;
	ihCodTipDocum = stDatNota->iCodTipDocum;
	lhCodAgente   = stDatNota->lCodAgente;
	ihCodCentrEmi = stDatNota->iCodCentremi;
	strcpy( szhLetra, stDatNota->szLetra );

	/*ihCodTipDocum  = 8;
	lhCodAgente    = 100001;
	strcpy(szhLetra, "X");
	ihCodCentrEmi  = 1;
	iResul = iDBTomarSecuencia( ihCodTipDocum, ihCodCentrEmi, szhLetra, &lhNumSecuenci );
	if (iResul != OK)
		return iResul;*/

   lhCodCliente   = lCodCliente;
   dhImpPago      = dImpPago;

   shIndContado   = 0; /* Siempre Consumo */
   ihCodSisPago   = 1;
   ihCodOriPago   = 1;
   ihCodCauPago   = 14;
   
   strcpy( szhDesPago, "PAGO POR NC FACTURACION" );

	strcpy(szhCodCaja, "\0");
	if (strlen(szhCodCaja) == 0)
		shIndCaja = ORA_NULL;
	else
		shIndCaja = ORA_NOTNULL;
	
	strcpy(szhCodBanco, "\0" );
	if (strlen(szhCodBanco) == 0)
		shIndCodBan = ORA_NULL;
	else
		shIndCodBan = ORA_NOTNULL;
	
	strcpy(szhCodSucursal, "\0" );
	if (strlen(szhCodSucursal) == 0)
		shIndCodSuc = ORA_NULL   ;
	else
		shIndCodSuc = ORA_NOTNULL;
	
	strcpy(szhCtaCorriente, "\0");
	if (strlen(szhCtaCorriente) == 0)
		shIndCtaCor = ORA_NULL;
	else
		shIndCtaCor = ORA_NOTNULL;
	
	strcpy(szhCodTipTarjeta, "\0");
	if (strlen(szhCodTipTarjeta) == 0)
		shIndCodTipTar = ORA_NULL;
	else
		shIndCodTipTar = ORA_NOTNULL;
	
	strcpy(szhNumTarjeta, "\0");
	if (strlen(szhNumTarjeta) == 0)
		shIndNumTar = ORA_NULL;
	else
		shIndNumTar = ORA_NOTNULL;

	/* manejo de decimales segun la operadora local */
	dhImpPago = fnCnvDouble( dhImpPago, 0 );
	
	strcpy(szhNomUsuarioOraMain,szNomUsuarioOraMain);  /* GAC 08-08-2003 (Homolog.) */
       /* asigna valores por Default definidas en .h  GAC 08-08-2003 (Homolog.) */
       strcpy( szPrefPlazaDefault, szPREF_PLAZA_DEFAULT );
	
	/* EXEC SQL
	INSERT INTO CO_PAGOS
		(
			COD_TIPDOCUM       ,
			COD_CENTREMI       ,
			NUM_SECUENCI       ,
			COD_VENDEDOR_AGENTE,
			LETRA              ,
			COD_CLIENTE        ,
			IMP_PAGO           ,
			FEC_EFECTIVIDAD    ,
			COD_CAJA           ,
			FEC_VALOR          ,
			NOM_USUARORA       ,
			COD_FORPAGO        ,
			COD_SISPAGO        ,
			COD_ORIPAGO        ,
			COD_CAUPAGO        ,
			COD_BANCO          ,
			COD_TIPTARJETA     ,
			COD_SUCURSAL       ,
			CTA_CORRIENTE      ,
			NUM_TARJETA        ,
			DES_PAGO           , 
                        PREF_PLAZA              /o GAC 08-08-2003 (Homolog.) o/
		)
		VALUES
		(
			:ihCodTipDocum      ,
			:ihCodCentrEmi      ,
			:lhNumSecuenci      ,
			:lhCodAgente        ,
			:szhLetra           ,
			:lhCodCliente       ,
			:dhImpPago,
			SYSDATE            ,
			:szhCodCaja:shIndCaja,
			SYSDATE             , 
			/o USER                ,   GAC 08-08-2003 (Homolog.) o/
			:szhNomUsuarioOraMain,
			0                   ,
			:ihCodSisPago       ,
			:ihCodOriPago       ,
			:ihCodCauPago       ,
			:szhCodBanco:shIndCodBan        ,
			:szhCodTipTarjeta:shIndCodTipTar,
			:szhCodSucursal:shIndCodSuc     ,
			:szhCtaCorriente:shIndCtaCor    ,
			:szhNumTarjeta:shIndNumTar      ,
			:szhDesPago                     ,
            :szPrefPlazaDefault              /o GAC 08-08-2003 (Homolog.) o/
		); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOS (COD_TIPDOCUM,COD_CENTREMI,NUM_SECUENCI\
,COD_VENDEDOR_AGENTE,LETRA,COD_CLIENTE,IMP_PAGO,FEC_EFECTIVIDAD,COD_CAJA,FEC_V\
ALOR,NOM_USUARORA,COD_FORPAGO,COD_SISPAGO,COD_ORIPAGO,COD_CAUPAGO,COD_BANCO,CO\
D_TIPTARJETA,COD_SUCURSAL,CTA_CORRIENTE,NUM_TARJETA,DES_PAGO,PREF_PLAZA) value\
s (:b0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,:b7:b8,SYSDATE,:b9,0,:b10,:b11,:b12,:b1\
3:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23,:b24)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )711;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&dhImpPago;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCodCaja;
 sqlstm.sqhstl[7] = (unsigned long )5;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)&shIndCaja;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNomUsuarioOraMain;
 sqlstm.sqhstl[8] = (unsigned long )31;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&ihCodSisPago;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihCodOriPago;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&ihCodCauPago;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[12] = (unsigned long )4;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)&shIndCodBan;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhCodTipTarjeta;
 sqlstm.sqhstl[13] = (unsigned long )4;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)&shIndCodTipTar;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhCodSucursal;
 sqlstm.sqhstl[14] = (unsigned long )5;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)&shIndCodSuc;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhCtaCorriente;
 sqlstm.sqhstl[15] = (unsigned long )16;
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)&shIndCtaCor;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhNumTarjeta;
 sqlstm.sqhstl[16] = (unsigned long )21;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&shIndNumTar;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)szhDesPago;
 sqlstm.sqhstl[17] = (unsigned long )41;
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szPrefPlazaDefault;
 sqlstm.sqhstl[18] = (unsigned long )26;
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
}



	if( sqlca.sqlcode )
	{
		fprintf( fArchLogIn, "Error INSERT CO_PAGOS => [%s].\n", szfnORAerror() );
		return ERR_INSPAG;
	}
	return OK;
} /* Fin bfnDBInsDatosPago(...) */
/*******************************************************************/

BOOL bfnDBUpdCastigoNC(long lCodCliente,long lNumFolio,double dMtoPago)
/**
Descripcion: Modifica el importe Debe del Castigo
Salida     : True, si todo va ok
             False, si se genera algun error
**/
{
	DATCON	stCon;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char   szhLetra[2]     ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int    ihCodCentrEmi   ;
		long   lhNumSecuenci   ;
		long   lhNumAbonado    ;
		long   lhCodVendedorAgente   ;
		int    ihColumna       ;
		int    ihCodProducto   ;
		int    ihCodCentremi   ;
		int    ihFlgCancelados ;
		double dhMtoSaldo      ;
		double dhMtoDebe       ;
		char   szhFecHist[9]   ; /* EXEC SQL VAR szhFecHist IS STRING(9); */ 

	/* EXEC SQL END DECLARE SECTION; */ 


	int		iError = 0;

	/* EXEC SQL DECLARE CASTIGOS_ASOC CURSOR FOR
	SELECT	NUM_SECUENCI,
			COD_VENDEDOR_AGENTE,
			LETRA,
			COD_CENTREMI,
			COLUMNA,
			IMPORTE_HABER - IMPORTE_DEBE,
			TO_CHAR(SYSDATE,'YYYYMMDD'),
			NUM_ABONADO,
			COD_PRODUCTO
	FROM	CO_CARTERA
	WHERE	COD_CLIENTE = :lCodCliente
	AND		NUM_FOLIO   = :lNumFolio
	AND		COD_TIPDOCUM = 39; */ 


	/* EXEC SQL OPEN CASTIGOS_ASOC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0016;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )802;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lNumFolio;
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
}



	if (sqlca.sqlcode != SQLOK)
	{
		fprintf( fArchLogIn, "Error OPEN CASTIGOS_ASOC => [%s].\n", szfnORAerror() );
		return FALSE;
	}

	while(1)
	{
		/* EXEC SQL FETCH CASTIGOS_ASOC
		INTO	:lhNumSecuenci,
				:lhCodVendedorAgente,
				:szhLetra,
				:ihCodCentremi,
				:ihColumna,
				:dhMtoSaldo,
				:szhFecHist,
				:lhNumAbonado,
				:ihCodProducto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 19;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )825;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedorAgente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&dhMtoSaldo;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecHist;
  sqlstm.sqhstl[6] = (unsigned long )9;
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
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
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
}



		if( sqlca.sqlcode != OK && sqlca.sqlcode != NOT_FOUND )
		{
			fprintf( fArchLogIn, "Error FETCH CASTIGOS_ASOC => [%s].\n", szfnORAerror() );
			iError = ERR_FETCH;
			break;
		}

		if( sqlca.sqlcode == NOT_FOUND )
			break;

		if (dMtoPago >= dhMtoSaldo)
		{
			dhMtoDebe = dhMtoSaldo;
			dMtoPago = dMtoPago - dhMtoSaldo;
			ihFlgCancelados = 1;
		}
		else
		{
			dhMtoDebe = dMtoPago;
			dMtoPago = 0;
			ihFlgCancelados = 0;
		}

		/* manejo de decimales segun la operadora local */
		dhMtoDebe = fnCnvDouble( dhMtoDebe, 0 );

		/* EXEC SQL
		UPDATE	CO_CARTERA
		SET		IMPORTE_DEBE = IMPORTE_DEBE + :dhMtoDebe,
				FEC_PAGO = TO_DATE(:szhFecHist,'YYYYMMDD')
		WHERE	COD_CLIENTE = :lCodCliente
		AND		NUM_SECUENCI = :lhNumSecuenci
		AND		COD_TIPDOCUM = 39
		AND		COD_VENDEDOR_AGENTE = :lhCodVendedorAgente
		AND		LETRA = :szhLetra
		AND		COD_CENTREMI = :ihCodCentremi
		AND		COD_CONCEPTO = 6
		AND		COLUMNA = :ihColumna; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 19;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_CARTERA  set IMPORTE_DEBE=(IMPORTE_DEBE+:b0),FEC_\
PAGO=TO_DATE(:b1,'YYYYMMDD') where (((((((COD_CLIENTE=:b2 and NUM_SECUENCI=:b3\
) and COD_TIPDOCUM=39) and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5) and COD_CEN\
TREMI=:b6) and COD_CONCEPTO=6) and COLUMNA=:b7)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )876;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhMtoDebe;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecHist;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lCodCliente;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorAgente;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[5] = (unsigned long )2;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
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
}



		if (sqlca.sqlcode != SQLOK)
		{
			fprintf( fArchLogIn, "Error UPDATE CO_CARTERA CC => [%s].\n", szfnORAerror() );
			iError = 1;
			break;
		}

		if (ihFlgCancelados) /* si cancelo el registro, lo pasa a Cancelados */
		{
			stCon.lNumSecuenci = lhNumSecuenci;
			stCon.iCodTipDocum = 39;
			stCon.lCodAgente   = lhCodVendedorAgente;
			strcpy(stCon.szLetra,szhLetra);
			stCon.iCodCentremi = ihCodCentremi;
			stCon.iCodConcepto = 6;
			stCon.iColumna     = ihColumna;
			stCon.iCodProducto = ihCodProducto;
			stCon.lNumAbonado  = lhNumAbonado ;
			
			if (!bfnDBLlevarACanCtos(&stCon,lCodCliente,szhFecHist))
			{
				fprintf(fArchLogIn,"ERROR en llamada a procedimiento bfnDBLlevarACanCtos\n");
				iError = 1;
				break;
			}
		}
		
		if (dMtoPago < 1) /* si no queda mas dinero */
			break;
	} /* end while */

	/* EXEC SQL CLOSE CASTIGOS_ASOC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )923;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (sqlca.sqlcode != 0)
	{
		fprintf( fArchLogIn, "Error CLOSE CASTIGOS_ASOC => [%s].\n", szfnORAerror() );
		return FALSE;
	}

	if( iError != OK )
		return FALSE;

	return TRUE;
}


/*===========================================================================
Funcion    : ifnCancelaConceptosNC()
Se crea funcion por Incidencia XO-200509130656, 27-09-2005 rvc Soporte RyC
Descripcion: Funcion encargada de cancelar los conceptos de un documento.
Entrada    : 

Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
===========================================================================*/
int ifnCancelaConceptosNC(long lCodCliente , int  iCodTipDocum, int  iCodCentremi, 
						long lNumSecuenci, long lCodAgente  , char * szLetra   , 
 						DATCON stCon    , char *szFecPago )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente         ;
	long   lhNumSecuenciaPago   ;
	long   lhCodAgentePago      ;
	long   lhNumAbonado         ;
	char   szhLetraPago      [2];
	char   szhFecPago       [20];
	int    ihCodTipDocumPago    ;
	int    ihCodCentremiPago    ;
	int    ihCodProducto        ;
	int    ihColumnaC;
/* EXEC SQL END DECLARE SECTION; */ 

int ihRetorno;

    fprintf(fArchLogIn,"modulo [ifnCancelaConceptosNC]\n");      
    fprintf(fArchLogIn,"lCodCliente          [%ld]\n",lCodCliente );  
    fprintf(fArchLogIn,"iCodTipDocum         [%d]\n",iCodTipDocum );      
    fprintf(fArchLogIn,"iCodCentremi         [%d]\n",iCodCentremi ); 
    fprintf(fArchLogIn,"lNumSecuenci         [%ld]\n",lNumSecuenci );      
    fprintf(fArchLogIn,"lCodAgente           [%ld]\n",lCodAgente );      
    fprintf(fArchLogIn,"szLetra              [%s]\n",szLetra );      
    fprintf(fArchLogIn,"stCon.iCodProducto   [%d]\n",stCon.iCodProducto );
    fprintf(fArchLogIn,"stCon.lNumAbonado    [%ld]\n",stCon.lNumAbonado );      
    fprintf(fArchLogIn,"szFecPago            [%s]\n",szFecPago );      
    fprintf(fArchLogIn,"stCon.iColumna       [%d]\n",stCon.iColumna );

	lhCodCliente       = lCodCliente;
	ihCodTipDocumPago  = iCodTipDocum;
    ihCodCentremiPago  = iCodCentremi;
	lhNumSecuenciaPago = lNumSecuenci;
	lhCodAgentePago    = lCodAgente;
	strcpy(szhLetraPago, szLetra);
	lhNumAbonado       = stCon.lNumAbonado;
	ihCodProducto      = stCon.iCodProducto;
	strcpy(szhFecPago, szFecPago);
	ihColumnaC         = stCon.iColumna;

	/* EXEC SQL
    INSERT INTO co_cancelados
            (cod_cliente   , cod_tipdocum       , cod_centremi   , 
             num_secuenci  , cod_vendedor_agente, letra          ,
             cod_concepto  , columna            , cod_producto   ,
             importe_debe  , importe_haber      , ind_contado    , 
             ind_facturado , fec_efectividad    , fec_cancelacion,
             ind_portador  , fec_vencimie       , fec_caducida   , 
             fec_antiguedad, fec_pago           , num_abonado    , 
             num_folio     , num_folioctc       , num_cuota      , 
             sec_cuota     , num_transaccion    , num_venta      ,
             pref_plaza    , cod_operadora_scl  , cod_plaza )
         SELECT car.cod_cliente      , car.cod_tipdocum        , car.cod_centremi  ,
                car.num_secuenci     , car.cod_vendedor_agente , car.letra         ,
                car.cod_concepto     , car.columna             , car.cod_producto  ,
                car.importe_haber    , car.importe_haber       , car.ind_contado   ,
                car.ind_facturado    , car.fec_efectividad     , to_date(:szhFecPago, 'ddmmyyyy'),
                0                    , car.fec_vencimie        , car.fec_caducida  , 
                car.fec_antiguedad   , SYSDATE                 , car.num_abonado   , 
                car.num_folio        , car.num_folioctc        , car.num_cuota     , 
                car.sec_cuota        , car.num_transaccion     , car.num_venta     , 
                car.pref_plaza       , car.cod_operadora_scl, car.cod_plaza
           FROM co_cartera car
          WHERE car.cod_cliente  = :lhCodCliente
            AND car.cod_tipdocum = :ihCodTipDocumPago
            AND car.cod_centremi = :ihCodCentremiPago
            AND car.num_secuenci = :lhNumSecuenciaPago
            AND car.cod_vendedor_agente = :lhCodAgentePago
            AND car.letra        = :szhLetraPago
            AND car.cod_producto = :ihCodProducto
            AND car.num_abonado  = :lhNumAbonado
            AND car.columna      = :ihColumnaC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft((void **)0, 
   "insert into co_cancelados (cod_cliente,cod_tipdocum,cod_centremi,num_sec\
uenci,cod_vendedor_agente,letra,cod_concepto,columna,cod_producto,importe_de\
be,importe_haber,ind_contado,ind_facturado,fec_efectividad,fec_cancelacion,i\
nd_portador,fec_vencimie,fec_caducida,fec_antiguedad,fec_pago,num_abonado,nu\
m_folio,num_folioctc,num_cuota,sec_cuota,num_transaccion,num_venta,pref_plaz\
a,cod_operadora_scl,cod_plaza)select car.cod_cliente ,car.cod_tipdocum ,car.\
cod_centremi ,car.num_secuenci ,car.cod_vendedor_agente ,car.letra ,car.cod_\
concepto ,car.columna ,car.cod_producto ,car.importe_haber ,car.importe_habe\
r ,car.ind_contado ,car.ind_facturado ,car.fec_efectividad ,to_date(:b0,'ddm\
myyyy') ,0 ,car.fec_vencimie ,car.fec_caducida ,car.fec_antiguedad ,SYSDATE \
,car.num_abonado ,car.num_folio ,car.num_folioctc ,car.num_cuota ,car.sec_cu\
ota ,car.num_transaccion ,car.num_venta ,car.pref_plaza ,car.cod_operadora_s\
cl ,car.cod_plaza  from co_cartera car where ((((((((car.cod_cliente=:b1 and\
 car.cod_tipdocum=:b2) and car.cod_centr");
 sqlstm.stmt = "emi=:b3) and car.num_secuenci=:b4) and car.cod_vendedor_agen\
te=:b5) and car.letra=:b6) and car.cod_producto=:b7) and car.num_abonado=:b8) \
and car.columna=:b9)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )938;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecPago;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumPago;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentremiPago;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenciaPago;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodAgentePago;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetraPago;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[9] = (unsigned char  *)&ihColumnaC;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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
}


	
	if (sqlca.sqlcode != SQLOK) {
		fprintf(fArchLogIn,"Error en el insertar en co_cancelados %s\n",szfnORAerror());
		return FALSE;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

	/* EXEC SQL
    DELETE  co_cartera
    WHERE cod_cliente = :lhCodCliente
    AND cod_tipdocum  = :ihCodTipDocumPago
    AND cod_centremi  = :ihCodCentremiPago
    AND num_secuenci  = :lhNumSecuenciaPago
    AND cod_vendedor_agente = :lhCodAgentePago
    AND letra         = :szhLetraPago
    AND cod_producto  = :ihCodProducto
    AND num_abonado   = :lhNumAbonado
    AND columna       = :ihColumnaC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 19;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from co_cartera  where ((((((((cod_cliente=:b0 and c\
od_tipdocum=:b1) and cod_centremi=:b2) and num_secuenci=:b3) and cod_vendedor_\
agente=:b4) and letra=:b5) and cod_producto=:b6) and num_abonado=:b7) and colu\
mna=:b8)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )993;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumPago;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentremiPago;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenciaPago;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodAgentePago;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhLetraPago;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[8] = (unsigned char  *)&ihColumnaC;
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
}



	if (sqlca.sqlcode != SQLOK) {
		fprintf(fArchLogIn,"Error al borrar en co_cartera %s\n",szfnORAerror());
		return FALSE;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

    ihRetorno  = 0;

} /* end ifnCancelaConceptosNC */

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

