
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
           char  filnam[15];
};
static const struct sqlcxp sqlfpn =
{
    14,
    "./pc/notdeb.pc"
};


static unsigned int sqlctx = 865531;


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

 static const char *sq0003 = 
"select COD_TIPDOCUMREL ,NVL(NUM_ABONADO,0) ,COD_PRODUCTO ,sum(IMP_CONCEPTO) \
 from CO_AJUSTECONC where ((((COD_TIPDOCUM=:b0 and COD_CENTREMI=:b1) and NUM_S\
ECUENCI=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b4) group by COD_TIPDOCUM\
REL,NUM_ABONADO,COD_PRODUCTO           ";

 static const char *sq0004 = 
"select COD_TIPDOCUMREL ,COD_CENTREMIREL ,NUM_SECUENCIREL ,COD_AGENTEREL ,LET\
RAREL ,NUM_ABONADO ,COD_PRODUCTO ,IMP_CONCEPTO ,ORD_SEC  from CO_AJUSTECONC wh\
ere ((((COD_TIPDOCUM=:b0 and COD_CENTREMI=:b1) and NUM_SECUENCI=:b2) and COD_V\
ENDEDOR_AGENTE=:b3) and LETRA=:b4) order by ORD_SEC            ";

 static const char *sq0015 = 
"select  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/ COD_CONCEPTO ,COLUMNA \
,IMPORTE_DEBE ,IMPORTE_HABER ,TO_CHAR(FEC_EFECTIVIDAD,:b0) ,TO_CHAR(FEC_VENCIM\
IE,:b0) ,TO_CHAR(FEC_CADUCIDA,:b0) ,TO_CHAR(FEC_ANTIGUEDAD,:b0) ,TO_CHAR(FEC_P\
AGO,:b0) ,NUM_FOLIO ,NUM_CUOTA ,SEC_CUOTA ,NUM_TRANSACCION ,NUM_VENTA ,NUM_FOL\
IOCTC ,NVL(PREF_PLAZA,' ') ,NVL(COD_OPERADORA_SCL,' ') ,NVL(COD_PLAZA,' ')  fr\
om CO_CARTERA where ((((((((COD_CLIENTE=:b5 and COD_TIPDOCUM=:b6) and COD_CENT\
REMI=:b7) and NUM_SECUENCI=:b8) and COD_VENDEDOR_AGENTE=:b9) and LETRA=:b10) a\
nd COD_PRODUCTO=:b11) and NUM_ABONADO=:b12) and  not exists (select 1  from CO\
_CODIGOS where ((NOM_TABLA=:b13 and NOM_COLUMNA=:b14) and COD_TIPDOCUM=TO_NUMB\
ER(COD_VALOR)))) order by FEC_EFECTIVIDAD            ";

 static const char *sq0016 = 
"select  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/ A.COD_CONCEPTO ,A.COLU\
MNA ,A.IMPORTE_DEBE ,A.IMPORTE_HABER ,TO_CHAR(A.FEC_EFECTIVIDAD,:b0) ,TO_CHAR(\
A.FEC_VENCIMIE,:b0) ,TO_CHAR(A.FEC_CADUCIDA,:b0) ,TO_CHAR(A.FEC_ANTIGUEDAD,:b0\
) ,A.NUM_FOLIO ,A.NUM_CUOTA ,A.SEC_CUOTA ,A.NUM_TRANSACCION ,A.NUM_VENTA ,A.NU\
M_FOLIOCTC ,NVL(A.PREF_PLAZA,' ') ,NVL(A.COD_OPERADORA_SCL,' ') ,NVL(A.COD_PLA\
ZA,' ')  from CO_CARTERA A ,CO_CONCEPTOS B where ((((((((((A.COD_CLIENTE=:b4 a\
nd A.COD_TIPDOCUM=:b5) and A.COD_CENTREMI=:b6) and A.NUM_SECUENCI=:b7) and A.C\
OD_VENDEDOR_AGENTE=:b8) and A.LETRA=:b9) and A.NUM_ABONADO=:b10) and A.COD_PRO\
DUCTO=:b11) and A.COD_CONCEPTO=B.COD_CONCEPTO) and A.COD_CONCEPTO not  in (:b1\
2,:b13)) and  not exists (select 1  from CO_CODIGOS where ((NOM_TABLA=:b14 and\
 NOM_COLUMNA=:b15) and COD_TIPDOCUM=TO_NUMBER(COD_VALOR)))) order by A.FEC_ANT\
IGUEDAD,B.ORDEN_CAN,A.COD_PRODUCTO,A.NUM_ABONADO            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,103,0,4,144,0,0,4,2,0,1,0,1,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
36,0,0,2,96,0,4,159,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
63,0,0,3,271,0,9,198,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
98,0,0,3,0,0,13,207,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
129,0,0,3,0,0,15,303,0,0,0,0,0,1,0,
144,0,0,4,295,0,9,414,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
179,0,0,4,0,0,13,424,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,
0,0,2,3,0,0,2,4,0,0,2,3,0,0,
230,0,0,4,0,0,15,601,0,0,0,0,0,1,0,
245,0,0,5,1181,0,3,668,0,0,8,8,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,3,0,0,
292,0,0,6,231,0,2,706,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,
335,0,0,7,1002,0,3,796,0,0,7,7,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,
378,0,0,8,820,0,3,834,0,0,11,11,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
437,0,0,9,208,0,2,868,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
3,0,0,
476,0,0,10,300,0,6,961,0,0,14,14,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,97,0,0,
547,0,0,11,54,0,4,1004,0,0,1,0,0,1,0,2,3,0,0,
566,0,0,12,193,0,6,1023,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,3,3,0,0,2,3,0,0,
2,97,0,0,
605,0,0,13,387,0,4,1092,0,0,9,8,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,97,0,0,1,97,0,0,
656,0,0,14,410,0,4,1180,0,0,10,9,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
711,0,0,15,753,0,9,1354,0,0,15,15,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,
786,0,0,15,0,0,13,1364,0,0,18,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,
0,2,97,0,0,2,97,0,0,2,97,0,0,
873,0,0,15,0,0,15,1530,0,0,0,0,0,1,0,
888,0,0,16,916,0,9,1680,0,0,16,16,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,97,0,0,
967,0,0,16,0,0,13,1691,0,0,17,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,5,0,0,
2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,97,0,
0,2,97,0,0,2,97,0,0,
1050,0,0,16,0,0,15,1963,0,0,0,0,0,1,0,
1065,0,0,17,474,0,3,2182,0,0,23,23,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1172,0,0,18,130,0,4,2258,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1195,0,0,19,40,0,4,2290,0,0,1,0,0,1,0,2,5,0,0,
};


/***********************************************************************************
    Programa    : Ejecucion de notas de debito .                           
    Modulo      : COBROS.                                                   
    Fichero     : notdeb.pc                                                 
    Descripcion : Programa ejecutar notas de debito a traves de VB          
    Programador : Julia Serrano                                             
    Fecha       : 18-03-1997                                                
************************************************************************************
    Modificaciones:                                                         
    2002-05-16	:  Se agrega a query de filtro para creditos a recuperar   
                  la restriccion ind_facturado = 1						  
************************************************************************************
	Modificado por Proyecto MAS_03043 Mejoras de Cancelacion de Credito
************************************************************************************/

#include <notdeb.h>     

/*char szhVersion[] = "v.4.0.0";*/
/*char szhVersion[] = "v.4.0.1";  XO-200508270497 Soporte RyC 29-08-2005 capc */
/*char szhVersion[] = "v.4.0.2";  * XO-200509070609 Soporte RyC 09.09.2005 mfqg */
/*char szhVersion[] = "v.4.0.3";  * CO-200607260257 Soporte RyC 26.07.2006 capc */
/*char szhVersion[] = "v.4.0.4";  * Requerimiento de Soporte Ticket 39419 - Colombia - RyC - 16.04.2007 */
/*char szhVersion[] = "v.4.0.5";  * Requerimiento de Soporte 40812 - Colombia - RyC - CAPC - 24.05.2007 */
char szhVersion[] = "v.4.0.6";  /* Requerimiento de Soporte 40812 - Colombia - RyC - CAPC - 08.06.2007 Se actualizan variables de ambiente GE_LIB_PATH y GE_INC_PATH */
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

/*  */ 
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


/*===========================================================================
Funcion : ifnCanNotas()
Cancela el importe del pago contra la cuenta de consumo del cliente.
Supone  que ya se han generado  los recargos.
Prerequisitos :
      El importe se supone que se recibe en moneda de cartera.
      Supone validacion de pago ya efectuado.
      Supone fecha en formato yyyymmdd.
Devuelve  : 0   - Todo ha ido bien. o Error ERR_XXX.
===========================================================================*/
int ifnCanNotas(long lCodCli    , double dImporte,	char *szFecValor,
			       int iCodTipDocum, long lCodAgente,	char *szLetra,
			       int iCodCenEmi  , long lNumSecu  ,	int iCodCredito,
			       int iCodConcepto, int iNC        , char *szFecVenci )
{
typedef  char  asc41[4];
typedef  char  asc21[2];
typedef  char  asc91[9];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/* EXEC SQL TYPE asc41 IS STRING(4); */ 

	/* EXEC SQL TYPE asc21 IS STRING(2); */ 

	/* EXEC SQL TYPE asc91 IS STRING(9); */ 

	int	   	ihCodTipDocum;
	int    	ihCodCentremi;
	long   	lhNumSecuenci;
	long   	lhCodAgente;
	char	szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int    	ihCodTipDocumRel[512];
	int    	ihCodCredito;
	int    	ihColumna[512];
	int	 	ihCodProducto[512];
	double 	dhImporteCon[512];
	long	lhNumAbonado[512];
	short	shIndNumAbonado[512];
	short	shIndCodTipDocumRel[512];
	short	shIndCodProducto[512];
	char   	szhPrefPlaza[26];
	char  	szhCodOperadoraScl[6];	
	char   	szhCodPlaza[6];			
	long 	lhCodCliente;
	long   	lhNSecuenciaCartera;

	long   	lhNumeroSecuencia;
	int     ihCodigoCentremi;
	char	szhCodigoLetra[2]; /* EXEC SQL VAR szhCodigoLetra IS STRING(2); */ 

	long   	lhCodigoAgente;
	short   shCodigoCentremi[512];
	short	shCodigoLetra[512];
	short  	shCodigoAgente[512];
	short   shNumeroSecuencia[512];
/* EXEC SQL END DECLARE SECTION; */ 


int      iResul = OK;
int      i, iNumCon;
BOOL     bResul;
BOOL     bFin = FALSE;
DATCON 	stConGen  ;

	fprintf(TiG.lFile,"\n\n==================================================\n", szhVersion);
	fprintf(TiG.lFile,"\nNOTDEBOL VERSION [%s]\n", szhVersion);
	fprintf(TiG.lFile,"\nParametros Ingresados\n");
	fprintf(TiG.lFile,"\nlCodCli      [%ld]", lCodCli); 
	fprintf(TiG.lFile,"\ndImporte     [%f] ", dImporte); 
	fprintf(TiG.lFile,"\nszFecValor   [%s] ", szFecValor); 
	fprintf(TiG.lFile,"\niCodTipDocum [%d] ", iCodTipDocum); 
	fprintf(TiG.lFile,"\nlCodAgente   [%ld]", lCodAgente); 
	fprintf(TiG.lFile,"\nszLetra      [%s] ", szLetra); 
	fprintf(TiG.lFile,"\niCodCenEmi   [%d] ", iCodCenEmi); 
	fprintf(TiG.lFile,"\nlNumSecu     [%ld]", lNumSecu); 
	fprintf(TiG.lFile,"\niCodCredito  [%d] ", iCodCredito); 
	fprintf(TiG.lFile,"\niCodConcepto [%d] ", iCodConcepto); 
	fprintf(TiG.lFile,"\niNC          [%d] ", iNC); 
	/* Requerimiento de Soporte Ticket 39419 - Colombia - RyC - 16.04.2007 */
	/*printf(TiG.lFile,"\nszFecVenci   [%d]\n\n", szFecVenci); */
	fprintf(TiG.lFile,"\nszFecVenci   [%s]\n\n", szFecVenci); 
		
	if (!bfnDBValFecValor(szFecValor))
		return ERR_FECVALOR;

	fprintf(TiG.lFile,"bfnDBValFecValor(szFecValor)  [%s]\n", szFecValor);
	lhCodCliente = lCodCli;

	/* Datos para la select */
	ihCodTipDocum = iCodTipDocum;
	ihCodCentremi = iCodCenEmi;
	lhNumSecuenci = lNumSecu;
	lhCodAgente = lCodAgente;
	strcpy(szhLetra , szLetra);

	/* manejo de decimales segun la operadora local */
	dImporte = fnCnvDouble( dImporte, 0 );

	/* Datos para insertar en cartera */
	stConGen.iCodTipDocum = iCodTipDocum;
	stConGen.lCodAgente   = lCodAgente;
	strcpy(stConGen.szLetra, szLetra);
	stConGen.iCodCentremi = iCodCenEmi;
	stConGen.lNumSecuenci = lNumSecu;
	stConGen.iIndContado  = 0;
	stConGen.iIndFacturado= 1;
	strcpy(stConGen.szFecEfectividad,szFecValor);
	strcpy(stConGen.szFecVencimie,szFecVenci);
	strcpy(stConGen.szFecCaducida,szFecVenci);
	strcpy(stConGen.szFecAntiguedad,szFecVenci);
	strcpy(stConGen.szFecPago,"");
	/*stConGen.lNumCuota   = -1;
	stConGen.iSecCuota   = -1;*/
	/* XO-200508270497 Soporte RyC 29-08-2005 capc */
	stConGen.lNumCuota   = 0;
	stConGen.iSecCuota   = 0;	
	stConGen.lNumTransa  = -1;
	stConGen.lNumVenta   = -1;
	stConGen.lNumFolio   = lhNumSecuenci;
	strcpy(stConGen.szFolioCTC,"");

	/* buscamos la operadora y plaza del cliente */
	/* EXEC SQL
	SELECT COD_OPERADORA      ,  Fn_Obtiene_PlazaCliente( :lhCodCliente )
	INTO   :szhCodOperadoraScl,  :szhCodPlaza
	FROM   GE_CLIENTES
	WHERE  COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_OPERADORA ,Fn_Obtiene_PlazaCliente(:b0) into :b1,\
:b2  from GE_CLIENTES where COD_CLIENTE=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
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


	
	if( sqlca.sqlcode != SQLOK )
	{
		fprintf( TiG.lFile, "Cliente => [%d] Error al recuperar OPERADORA => [%s].\n", lhCodCliente, szfnORAerror() );
		return ERR_SELECT;
	}
	
	rtrim( szhCodOperadoraScl );
	rtrim( szhCodPlaza );
	
	/* EXEC SQL
	SELECT PREF_PLAZA
	INTO   :szhPrefPlaza
	FROM   GE_OPERPLAZA_TD
	WHERE  COD_OPERADORA_SCL = :szhCodOperadoraScl
	AND    COD_PLAZA = :szhCodPlaza; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select PREF_PLAZA into :b0  from GE_OPERPLAZA_TD where (COD_\
OPERADORA_SCL=:b1 and COD_PLAZA=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )36;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[0] = (unsigned long )26;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[2] = (unsigned long )6;
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


	   
	if( sqlca.sqlcode != SQLOK )
	{
		fprintf( TiG.lFile, "Cliente => [%d] Error al recuperar PREFIJO PLAZA => [%s].\n", lhCodCliente, szfnORAerror() );
		return ERR_SELECT;
	}

	rtrim( szhPrefPlaza );
	rtrim( szhLetra );
	strcpy( stConGen.szPrefPlaza, szhPrefPlaza );				
	strcpy( stConGen.szCodOperadoraScl, szhCodOperadoraScl );
	strcpy( stConGen.szCodPlaza, szhCodPlaza );					
	fprintf(TiG.lFile,"\nszPrefPlaza          [%s]\n", stConGen.szPrefPlaza);
	fprintf(TiG.lFile,"szCodOperadoraScl    [%s]\n", stConGen.szCodOperadoraScl);
	fprintf(TiG.lFile,"stConGen.szCodPlaza  [%s]\n", stConGen.szCodPlaza);

	/* Cursor para insertar tantos ajustes como registros haya */
	fprintf(TiG.lFile,"\n\n lhNumSecuenci from CO_AJUSTECONC = %ld \n", lhNumSecuenci ); /*CAPC 24-02-2004 MA-200402200339*/
	/* Se modifica linea NUM_ABONADO,0, por NVL(NUM_ABONADO,0),  Requerimiento de Soporte Ticket 39419 - Colombia - RyC - 16.04.2007 */
	/* EXEC SQL DECLARE C_INSCONAJUSTE CURSOR FOR
	SELECT  COD_TIPDOCUMREL,
		    NVL(NUM_ABONADO,0),
		    COD_PRODUCTO,
		    SUM(IMP_CONCEPTO)
	FROM   CO_AJUSTECONC
	WHERE  COD_TIPDOCUM = :ihCodTipDocum
	AND    COD_CENTREMI = :ihCodCentremi
	AND    NUM_SECUENCI = :lhNumSecuenci
	AND    COD_VENDEDOR_AGENTE = :lhCodAgente
	AND    LETRA = :szhLetra
	GROUP BY  COD_TIPDOCUMREL,NUM_ABONADO,COD_PRODUCTO; */ 

	/*ORDER BY ORD_SEC;*/
	
	/* EXEC SQL OPEN C_INSCONAJUSTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0003;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )63;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentremi;
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
		fprintf(TiG.lFile,"Error en el cursor contra documento %s\n",szfnORAerror());
		return ERR_OPENCURSOR;
	}

	while (!bFin)
	{
		/* EXEC SQL FETCH C_INSCONAJUSTE 
		INTO	:ihCodTipDocumRel:shIndCodTipDocumRel,
				:lhNumAbonado:shIndNumAbonado,
				:ihCodProducto:shIndCodProducto,
				:dhImporteCon; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )512;
  sqlstm.offset = (unsigned int  )98;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipDocumRel;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)shIndCodTipDocumRel;
  sqlstm.sqinds[0] = (         int  )sizeof(short);
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)shIndNumAbonado;
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ihCodProducto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)shIndCodProducto;
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)dhImporteCon;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )sizeof(double);
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
}



		if (sqlca.sqlcode < 0)
		{
			fprintf(TiG.lFile,"Error en Fetch C_INSCONAJUSTE %s\n",
			szfnORAerror());
			return ERR_FETCH;
		}
		
		iNumCon = 512;
		
		if (sqlca.sqlcode == NOT_FOUND)
		{
			iNumCon = sqlca.sqlerrd[2] % 512;
			bFin = TRUE;
		}

		for( i = 0; i < iNumCon; i++ )
		{

			fprintf(TiG.lFile,"\tihCodTipDocumRel [%d]\n", ihCodTipDocumRel[i]);
			fprintf(TiG.lFile,"\tlhNumAbonado     [%ld]\n",lhNumAbonado[i]);
			fprintf(TiG.lFile,"\tihCodProducto    [%d]\n", ihCodProducto[i]);
			fprintf(TiG.lFile,"\tdhImporteCon     [%f]\n", dhImporteCon[i]);

			/* manejo de decimales segun la operadora local */
			dhImporteCon[i] = fnCnvDouble( dhImporteCon[i], 0 );
			
			/* Comprobar Importe */
			if (IMPORTEMINIMO > dhImporteCon[i])
			{
				/* fprintf(TiG.lFile,"control minimo dhImporteCon %10.5f\n",dhImporteCon[i]); */
				return ERR_IMPORTE;
			}
			
			if (IMPORTEMAXIMO < dhImporteCon[i])
			{
				/* fprintf(TiG.lFile,"control maximo dhImporteCon %10.5f\n",dhImporteCon[i]); */
				return ERR_IMPORTE;
			}
		
			if (shIndCodTipDocumRel[i] == ORA_NULL)
			{
			    fprintf(TiG.lFile,"Tratar con un unico importe a nivel de cliente ...\n");
				stConGen.iCodProducto = PRODGEN;
				stConGen.lNumAbonado = ABOCLI;
				stConGen.iColumna     = 0;
				if (iNC)
				{
					stConGen.iCodConcepto = iCodCredito;
					stConGen.dImporteDebe = 0.0;
					stConGen.dImporteHaber= dImporte;
				}
				else
				{
					stConGen.iCodConcepto = iCodConcepto;
					stConGen.dImporteDebe = dImporte;
					stConGen.dImporteHaber= 0.0;
				}
				fprintf(TiG.lFile,"\n\n **** modulo [bfnDBIntCartera] stConGen 1\n" ); /*CAPC 24-02-2004 MA-200402200339*/
				bResul = bfnDBIntCartera( &stConGen, lCodCli );
				if( !bResul )
					return ERR_INTCARTE;
			}
			else
			{
			    fprintf(TiG.lFile,"Tratar con un unico importe a nivel de documento ...\n");
				/* Insertar un registro por cada ajuste */
				stConGen.iCodProducto = ihCodProducto[i];
				stConGen.lNumAbonado  = lhNumAbonado[i];
				stConGen.iColumna     = 0;

				if( iNC )
				{
					stConGen.iCodConcepto = iCodCredito;
					stConGen.dImporteDebe = 0.0;
					stConGen.dImporteHaber= dhImporteCon[i];
				}
				else
				{
					stConGen.iCodConcepto = iCodConcepto;
					stConGen.dImporteDebe = dhImporteCon[i];
					stConGen.dImporteHaber= 0.0;
				}
				fprintf(TiG.lFile,"\n\n **** modulo [bfnDBIntCartera] stConGen 2 \n" ); /*CAPC 24-02-2004 MA-200402200339*/
				bResul = bfnDBIntCartera(&stConGen,lCodCli);
				if( !bResul )
					return ERR_INTCARTE;
			}/* shIndCodTipDocum != ORA_NULL */
		}/* For */
	}/*Fin del cursor  C_INSCONAJUSTE*/

	/* EXEC SQL CLOSE C_INSCONAJUSTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )129;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode != 0)
	{
		fprintf(TiG.lFile,"Error al cerrar el cursor %s\n",szfnORAerror());
		return ERR_CLOSECURSOR;
	}
	
	iResul = ifnDBContraDocum( lCodCli, &stConGen, iCodCredito, szFecValor );
	fprintf(TiG.lFile,"iResul    [%d] \n", iResul);
	if (iResul == 0) 
	{
		fprintf(TiG.lFile,"\n\n **** Proceso Finalizó OK **** \n" );	
	}
	else
	{
		fprintf(TiG.lFile,"\n\n **** Proceso Finalizó Con Error **** \n" );	
	}
	
	return iResul;
} /* Fin ifnCanNotas() */


/*===========================================================================
Funcion : ifnDBContraDocum()
Descripcion:  Funcion que obtiene todos los creditos de un cliente y los cancela.
Entrada:       stCli, estructura de datos de cliente. iCodCredito, codigo de credito.
Salida:        TRUE, si todo va bien. ERR_xxx, si falla algo.
===========================================================================*/
int ifnDBContraDocum( long lCodCliente, DATCON *stCre, int iCodCredito, char *szFecValor )
{
typedef  char  asc41[4];
typedef  char  asc21[2];
typedef  char  asc91[9];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/* EXEC SQL TYPE asc41 IS STRING(4); */ 

	/* EXEC SQL TYPE asc21 IS STRING(2); */ 

	/* EXEC SQL TYPE asc91 IS STRING(9); */ 

	
	int     ihCodTipDocum;
	int     ihCodCentremi;
	long    lhNumSecuenci;
	long	lhCodAgente;
	char    szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodTipDocumRel[512];
	int     ihCodCentremiRel[512];
	long    lhNumSecuenciRel[512];
	long    lhCodAgenteRel[512];
	asc21   szhLetraRel[512];
	int     ihCodCredito;
	int     ihColumna[512];
	int     ihCodProducto[512];
	double  dhImporteCon[512];
	long    lhNumAbonado[512];
	short   shIndNumAbonado[512];
	short   shIndCodTipDocumRel[512];
	short   shIndCodCentremiRel[512];
	short   shIndNumSecuenciaRel[512];
	short   shIndCodAgenteRel[512];
	short   shIndLetraRel[512];
	short   shIndCodProducto[512];
	int     ihSecCuotaa[512];

/* EXEC SQL END DECLARE SECTION; */ 


DATCON   stConCre;
int      iResul = OK;
int      i,iNumCon;
BOOL     bResul;
BOOL     bFin = FALSE;
double   dImporte = 0.0;
double   dImporteAbo = 0.0;
int      iCancelacionDocumento = 0;
int      iIndicadorPago;
double   dImpPagado = 0;

	fprintf(TiG.lFile,"*****************************************************  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"modulo [ifnDBContraDocum] \n");					/*CAPC 24-02-2004 MA-200402200339*/

	ihCodTipDocum = stCre->iCodTipDocum;
	ihCodCentremi = stCre->iCodCentremi;
	lhNumSecuenci = stCre->lNumSecuenci;
	lhCodAgente   = stCre->lCodAgente;
	strcpy(szhLetra , stCre->szLetra);

	fprintf(TiG.lFile,"ihCodTipDocum    [%d] \n", ihCodTipDocum);	
	fprintf(TiG.lFile,"ihCodCentremi    [%d] \n", ihCodCentremi);	
	fprintf(TiG.lFile,"lhNumSecuenci    [%ld] \n", lhNumSecuenci);	
	fprintf(TiG.lFile,"lhCodAgente      [%ld] \n", lhCodAgente);	
	fprintf(TiG.lFile,"szhLetra         [%s] \n", szhLetra);	

	/* Cursor para tratar los conceptos del cliente */
	/* EXEC SQL DECLARE C_CONAJUSTE CURSOR FOR
	SELECT COD_TIPDOCUMREL,
			 COD_CENTREMIREL,
			 NUM_SECUENCIREL,
			 COD_AGENTEREL,
			 LETRAREL,
			 NUM_ABONADO,
			 COD_PRODUCTO,
			 IMP_CONCEPTO,
			 ORD_SEC
	FROM	 CO_AJUSTECONC
	WHERE	 COD_TIPDOCUM	= :ihCodTipDocum
	AND	 COD_CENTREMI  = :ihCodCentremi
	AND	 NUM_SECUENCI  = :lhNumSecuenci
	AND	 COD_VENDEDOR_AGENTE = :lhCodAgente
	AND	 LETRA         = :szhLetra
	ORDER BY ORD_SEC; */ 

	
	/* EXEC SQL OPEN C_CONAJUSTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )144;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentremi;
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
		fprintf(TiG.lFile,"Error en el cursor contra documento %s\n",szfnORAerror());
		return ERR_OPENCURSOR;
	}

	while (!bFin)
	{
		/* EXEC SQL FETCH C_CONAJUSTE 
		INTO	:ihCodTipDocumRel:shIndCodTipDocumRel,
				:ihCodCentremiRel:shIndCodCentremiRel,
				:lhNumSecuenciRel:shIndNumSecuenciaRel,
				:lhCodAgenteRel:shIndCodAgenteRel,
				:szhLetraRel:shIndLetraRel,
				:lhNumAbonado:shIndNumAbonado,
				:ihCodProducto:shIndCodProducto,
				:dhImporteCon,
				:ihSecCuotaa; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )512;
  sqlstm.offset = (unsigned int  )179;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodTipDocumRel;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)shIndCodTipDocumRel;
  sqlstm.sqinds[0] = (         int  )sizeof(short);
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihCodCentremiRel;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)shIndCodCentremiRel;
  sqlstm.sqinds[1] = (         int  )sizeof(short);
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumSecuenciRel;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)shIndNumSecuenciaRel;
  sqlstm.sqinds[2] = (         int  )sizeof(short);
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhCodAgenteRel;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)shIndCodAgenteRel;
  sqlstm.sqinds[3] = (         int  )sizeof(short);
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetraRel;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )2;
  sqlstm.sqindv[4] = (         short *)shIndLetraRel;
  sqlstm.sqinds[4] = (         int  )sizeof(short);
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)lhNumAbonado;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )sizeof(long);
  sqlstm.sqindv[5] = (         short *)shIndNumAbonado;
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)ihCodProducto;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )sizeof(int);
  sqlstm.sqindv[6] = (         short *)shIndCodProducto;
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)dhImporteCon;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[7] = (         int  )sizeof(double);
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)ihSecCuotaa;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )sizeof(int);
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
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


		
		if( sqlca.sqlcode < 0 )
		{
			fprintf(TiG.lFile,"Error en Fetch C_CAN de Cancelados %s\n",
			szfnORAerror());
			return ERR_FETCH;
		}
		
		iNumCon = 512;
		
		if( sqlca.sqlcode == NOT_FOUND )
		{
			iNumCon = sqlca.sqlerrd[2] % 512;
			bFin = TRUE;
		}
		
		for( i = 0; i < iNumCon; i++ )
		{
			/*fprintf(TiG.lFile,"importe obtenido antes [%f]\n",dhImporteCon[i]);*/

			/* manejo de decimales segun la operadora local */
			/*fprintf(TiG.lFile,"\n\n 11 dhImporteCon[i] = %f antes de fnCnvDouble\n", dhImporteCon[i] );*/ /*CAPC 24-02-2004 MA-200402200339*/
			dhImporteCon[i] = fnCnvDouble( dhImporteCon[i], 0 );
		
			/* Comprobar Importe */
			if (IMPORTEMINIMO > dhImporteCon[i])
				return ERR_IMPORTE;
			
			if (IMPORTEMAXIMO < dhImporteCon[i])
				return ERR_IMPORTE;
			
			if( shIndCodTipDocumRel[i] == ORA_NULL )
			{
				/* TRATAR CON UN UNICO IMPORTE A NIVEL DE CLIENTE */
				/* Se ha de realizar la cancelacion de un credito */
				/* Llamar a la cancelacion de creditos sin carrier */
				iResul = ifnCancelacionCreditos( lCodCliente, szFecValor, i+1 );
				if( iResul != OK )		return iResul;
				
			}
			else
			{
				/* Llenamos estructura de datos de Credito. */
				stConCre.iCodTipDocum = ihCodTipDocumRel[i];
				stConCre.lCodAgente   = lhCodAgenteRel[i];
				strcpy(stConCre.szLetra,szhLetraRel[i]);
				stConCre.iCodCentremi = ihCodCentremiRel[i];
				stConCre.lNumSecuenci = lhNumSecuenciRel[i];
				stConCre.iCodProducto = ihCodProducto[i];
				stConCre.dImporteDebe = dhImporteCon[i];				
				stConCre.lNumAbonado  = lhNumAbonado[i];
				stConCre.iSecCuota    = ihSecCuotaa[i];				
				stCre->iCodProducto   = ihCodProducto[i];
				stCre->lNumAbonado    = lhNumAbonado[i];

				/* Obtener el importe del ajuste */
				bResul = bfnDBSumImporte( stCre, lCodCliente, &dImporte );
				if(!bResul)
					return ERR_IMPORTE;

				/* Obtener el importe de la relacion ajuste documento abonado */
				bResul = bfnDBSumImporteAbo( &stConCre, lCodCliente, &dImporteAbo );
				if(!bResul)
					return ERR_IMPORTE;

			    fprintf(TiG.lFile,"\n\ndImporte    [%f]\n", dImporte);
			    fprintf(TiG.lFile,"dImporteAbo [%f]\n", dImporteAbo);

				if (dImporte > 0.0)
				{
			        fprintf(TiG.lFile,"\n\n NOTA DE DEBITO ... "); 
					/* Estamos tratando con una ND */
					if (dImporteAbo > 0.0)
					{
						/* Estamos tratando con una ND con una ND  */
						fprintf(TiG.lFile,"Estamos tratando con  ND con  ND \n");

						/* Se ha de realizar la cancelacion de un credito */
						fprintf(TiG.lFile,"cancelacion creditos\n");
						/* Llamar a la cancelacion de creditos sin carrier */
						iResul = ifnCancelacionCreditos( lCodCliente, szFecValor, i+1 );

						if (iResul != OK)
							return iResul;
					}
					else
					{
						/* Estamos tratando con una ND con una NC */
						fprintf(TiG.lFile,"Estamos tratando con una ND con una NC\n");

						iResul = ifnDBAjusteNC( &stConCre, stCre, iCodCredito, lCodCliente, szFecValor );
			
						if (iResul != OK)
							return iResul;
					}
				}
				else
				{
			        fprintf(TiG.lFile,"\n\n NOTA DE CREDITO ... "); 
					/* Estamos tratando con una NC */
					if (dImporteAbo > 0.0)
					{ 
						/* Estamos tratando con una NC con una ND */
						fprintf(TiG.lFile,"Estamos tratando con NC con ND \n");

						if ((dImporteAbo+dImporte)== 0) {
							iResul = ifnCancelacionTotalCreditos(lCodCliente, &stConCre, lhNumSecuenci, ihCodTipDocum, 
                                                                 lhCodAgente, szhLetra , ihCodCentremi, stConCre.iSecCuota, 
                                                                 szFecValor , stCre->lNumAbonado);
							if (iResul != OK)
								return iResul;

							iIndicadorPago = 0;
							iResul = ifnCancelaConceptos(lCodCliente  , ihCodTipDocum, ihCodCentremi, 
                                                         lhNumSecuenci, lhCodAgente  , szhLetra     , 
                                                         stCre        , szFecValor);
 							/*if (iResul != OK)*/
							return iResul;

					} else {
							fprintf(TiG.lFile,"ihSecCuotaa               [%d]\n",stCre->iSecCuota );
							iResul = ifnCancelacionParcialCreditos(lCodCliente, &stConCre, lhNumSecuenci, ihCodTipDocum, lhCodAgente, szhLetra , ihCodCentremi, stConCre.iSecCuota, szFecValor, stCre->lNumAbonado);

							if (iResul != OK)
								return iResul;

							iIndicadorPago = 1;
														
							dImpPagado = dImpPagado + stConCre.dImporteDebe;
							
							fprintf(TiG.lFile,"dImporte [%f]\n", dImporte);
							fprintf(TiG.lFile,"dImpPagado [%f]\n", dImpPagado);
														
							if (dImpPagado == (dImporte *(-1)))
							{
							iResul = ifnCancelaConceptos(lCodCliente  , ihCodTipDocum, ihCodCentremi, 
                                                         lhNumSecuenci, lhCodAgente  , szhLetra     , 
                                                         stCre        , szFecValor);
                            }                             
 							
/*		  				    iResul = ifnDBAjusteNC( &stConCre, stCre, iCodCredito, lCodCliente, szFecValor );*/
			
							if (iResul != OK)
								return iResul;
						} /* end if (dImporteAbo == dImporte)*/

						iCancelacionDocumento = 1;
					}
					else
					{
						/* Estamos tratando con una NC con una NC */
						fprintf(TiG.lFile,"Estamos tratando con una NC con una NC \n");
						
						/* Se ha de realizar la cancelacion de un credito */
						fprintf(TiG.lFile,"cancelacion creditos\n");      
						/* Llamar a la cancelacion de creditos sin carrier */

						iResul = ifnCancelacionCreditos(lCodCliente, szFecValor, i+1 );
						
						if( iResul != OK )
							return iResul;
					} 
				}/* dImporte > 0.0) */
			}/* shIndCodTipDocum != ORA_NULL */
		}/* For */
	}/*Fin del cursor  C_CAN*/

	/* EXEC SQL CLOSE C_CONAJUSTE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )230;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode != 0)
	{
		fprintf(TiG.lFile,"Error al cerrar el cursor %s\n",szfnORAerror());
		return ERR_CLOSECURSOR;
	}
    
    if( iCancelacionDocumento != 1) {
		/* LLAMAR A LA CANCELACION YA QUE PUEDEN QUEDAR ABONOS NO CANCELADOS */
		fprintf(TiG.lFile,"\nCANCELACION FINAL POR SI QUEDA ALGO PENDIENTE \n");

		iResul = ifnCancelacionCreditos( lCodCliente, szFecValor, i+1 );

		if( iResul != OK )
			return iResul;
	} /* end if( iCancelacionDocumento != 1)*/

	return OK;
}/* Fin ifnDBContraDocum() */

/*===========================================================================
Funcion    : ifnCancelaConceptos()
Descripcion: Funcion encargada de cancelar los conceptos de un documento.
Entrada    : 

Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
===========================================================================*/
int ifnCancelaConceptos(long lCodCliente , int  iCodTipDocum, int  iCodCentremi, 
						long lNumSecuenci, long lCodAgente  , char * szLetra   , 
 						DATCON *stCon    , char *szFecPago )
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
/* EXEC SQL END DECLARE SECTION; */ 

int ihRetorno;

    fprintf(TiG.lFile,"modulo [ifnCancelaConceptos]\n");      
    fprintf(TiG.lFile,"lCodCliente          [%ld]\n",lCodCliente );  
    fprintf(TiG.lFile,"iCodTipDocum         [%d]\n",iCodTipDocum );      
    fprintf(TiG.lFile,"iCodCentremi         [%d]\n",iCodCentremi ); 
    fprintf(TiG.lFile,"lNumSecuenci         [%ld]\n",lNumSecuenci );      
    fprintf(TiG.lFile,"lCodAgente           [%ld]\n",lCodAgente );      
    fprintf(TiG.lFile,"szLetra              [%s]\n",szLetra );      
    fprintf(TiG.lFile,"stCon.iCodProducto   [%d]\n",stCon->iCodProducto );
    fprintf(TiG.lFile,"stCon.lNumAbonado    [%ld]\n",stCon->lNumAbonado );      
    fprintf(TiG.lFile,"szFecPago            [%s]\n",szFecPago );      

	lhCodCliente       = lCodCliente;
	ihCodTipDocumPago  = iCodTipDocum;
    ihCodCentremiPago  = iCodCentremi;
	lhNumSecuenciaPago = lNumSecuenci;
	lhCodAgentePago    = lCodAgente;
	strcpy(szhLetraPago, szLetra);
	lhNumAbonado       = stCon->lNumAbonado;
	ihCodProducto      = stCon->iCodProducto;
	strcpy(szhFecPago, szFecPago);

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
         SELECT /o+ INDEX ( co_cartera , pk_co_cartera) o/
         		car.cod_cliente      , car.cod_tipdocum        , car.cod_centremi  ,
                car.num_secuenci     , car.cod_vendedor_agente , car.letra         ,
                car.cod_concepto     , car.columna             , car.cod_producto  ,
                car.importe_haber    , car.importe_haber       , car.ind_contado   ,
                car.ind_facturado    , car.fec_efectividad     , to_date(:szhFecPago, 'yyyymmdd'),
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
            AND car.cod_producto = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft((void **)0, 
   "insert into co_cancelados (cod_cliente,cod_tipdocum,cod_centremi,num_sec\
uenci,cod_vendedor_agente,letra,cod_concepto,columna,cod_producto,importe_de\
be,importe_haber,ind_contado,ind_facturado,fec_efectividad,fec_cancelacion,i\
nd_portador,fec_vencimie,fec_caducida,fec_antiguedad,fec_pago,num_abonado,nu\
m_folio,num_folioctc,num_cuota,sec_cuota,num_transaccion,num_venta,pref_plaz\
a,cod_operadora_scl,cod_plaza)select  /*+  INDEX ( co_cartera , pk_co_carter\
a)  +*/ car.cod_cliente ,car.cod_tipdocum ,car.cod_centremi ,car.num_secuenc\
i ,car.cod_vendedor_agente ,car.letra ,car.cod_concepto ,car.columna ,car.co\
d_producto ,car.importe_haber ,car.importe_haber ,car.ind_contado ,car.ind_f\
acturado ,car.fec_efectividad ,to_date(:b0,'yyyymmdd') ,0 ,car.fec_vencimie \
,car.fec_caducida ,car.fec_antiguedad ,SYSDATE ,car.num_abonado ,car.num_fol\
io ,car.num_folioctc ,car.num_cuota ,car.sec_cuota ,car.num_transaccion ,car\
.num_venta ,car.pref_plaza ,car.cod_operadora_scl ,car.cod_plaza  from co_ca\
rtera car where ((((((car.cod_cliente=:b");
 sqlstm.stmt = "1 and car.cod_tipdocum=:b2) and car.cod_centremi=:b3) and ca\
r.num_secuenci=:b4) and car.cod_vendedor_agente=:b5) and car.letra=:b6) and ca\
r.cod_producto=:b7)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )245;
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


            /*AND car.num_abonado  = :lhNumAbonado;*/
	
	if (sqlca.sqlcode != SQLOK) {
		fprintf(TiG.lFile,"Error en el insertar en co_cancelados %s\n",szfnORAerror());
		return FALSE;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

	/* EXEC SQL
    DELETE /o+ INDEX ( co_cartera , pk_co_cartera) o/
    co_cartera
    WHERE cod_cliente = :lhCodCliente
    AND cod_tipdocum  = :ihCodTipDocumPago
    AND cod_centremi  = :ihCodCentremiPago
    AND num_secuenci  = :lhNumSecuenciaPago
    AND cod_vendedor_agente = :lhCodAgentePago
    AND letra         = :szhLetraPago
    AND cod_producto  = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/  from \
co_cartera  where ((((((cod_cliente=:b0 and cod_tipdocum=:b1) and cod_centremi\
=:b2) and num_secuenci=:b3) and cod_vendedor_agente=:b4) and letra=:b5) and co\
d_producto=:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )292;
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


    /*AND num_abonado   = :lhNumAbonado;*/

	if (sqlca.sqlcode != SQLOK) {
		fprintf(TiG.lFile,"Error en el borrar en co_cartera %s\n",szfnORAerror());
		return FALSE;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

    ihRetorno  = 0;

} /* end ifnCancelaConceptos */

/*===========================================================================
Funcion    : ifnCancelacionTotalCreditos()
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
			 lNumAbonado
Salida     : TRUE, si todo ha ido bien.
			 ERR_xxx, si falla algo.
===========================================================================*/
int ifnCancelacionTotalCreditos(long lCodCliente , DATCON *stConCre, long lNumSecuenci, 
                                int  iCodTipDocum, long lCodAgente , char * szLetra   , 
                                int  iCodCentremi, int  iCuota     , char * szFecPago , 
                                long lNumAbonado)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente         ;
	long   lhNumSecuencia       ;
	long   lhCodAgente          ;
	long   lhNumSecuenciaPago   ;
	long   lhCodAgentePago      ;
	long   lhNumAbonado         ;
	int    ihCodTipDocum        ;
	int    ihCodCentremi        ;
	int    ihCodTipDocumPago    ;
	int    ihCodCentremiPago    ;
	int    ihCuota              ;
	char   szhLetra          [2];
	char   szhLetraPago      [2];
	char   szhFecPago       [20];
/* EXEC SQL END DECLARE SECTION; */ 


    fprintf(TiG.lFile,"modulo [ifnCancelacionTotalCreditos]\n");      
    fprintf(TiG.lFile,"lCodCliente          [%ld]\n",lCodCliente );  
    fprintf(TiG.lFile,"stConCre.lNumSecuenci[%ld]\n",stConCre->lNumSecuenci );      
    fprintf(TiG.lFile,"stConCre.iCodTipDocum[%d]\n",stConCre->iCodTipDocum );      
    fprintf(TiG.lFile,"stConCre.lCodAgente  [%ld]\n",stConCre->lCodAgente );      
    fprintf(TiG.lFile,"stConCre.szLetra     [%s]\n",stConCre->szLetra );      
    fprintf(TiG.lFile,"stConCre.iCodCentremi[%d]\n",stConCre->iCodCentremi );      
    fprintf(TiG.lFile,"lNumSecuenci         [%ld]\n",lNumSecuenci );      
    fprintf(TiG.lFile,"iCodTipDocum         [%d]\n",iCodTipDocum );      
    fprintf(TiG.lFile,"lCodAgente           [%ld]\n",lCodAgente );      
    fprintf(TiG.lFile,"szLetra              [%s]\n",szLetra );      
    fprintf(TiG.lFile,"iCodCentremi         [%d]\n",iCodCentremi );      
    fprintf(TiG.lFile,"iCuota               [%d]\n",iCuota );      
    fprintf(TiG.lFile,"szFecPago            [%s]\n",szFecPago );      
    fprintf(TiG.lFile,"lhNumAbonado         [%ld]\n",lhNumAbonado );      

	lhCodCliente       = lCodCliente;
	lhNumSecuencia     = stConCre->lNumSecuenci;
	ihCodTipDocum      = stConCre->iCodTipDocum;
	lhCodAgente        = stConCre->lCodAgente;
	strcpy(szhLetra, stConCre->szLetra);
	ihCodCentremi      = stConCre->iCodCentremi;
	lhNumSecuenciaPago = lNumSecuenci;
	ihCodTipDocumPago  = iCodTipDocum;
	lhCodAgentePago    = lCodAgente;
	strcpy(szhLetraPago, szhLetra);
    ihCodCentremiPago  = iCodCentremi;
	ihCuota            = iCuota;
	strcpy(szhFecPago, szFecPago);
	lhNumAbonado	   = lNumAbonado;

	/* EXEC SQL
        INSERT INTO CO_CANCELADOS (
               COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
               NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
               COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
               IMPORTE_HABER            ,                NUM_TRANSACCION          ,                IMPORTE_DEBE             ,
               IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
               FEC_CANCELACION          ,                IND_PORTADOR             ,                FEC_PAGO                 ,
               FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
               NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
               NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA               ,
               NUM_FOLIOCTC             ,                COD_OPERADORA_SCL        ,                COD_PLAZA)
       SELECT  /o+ INDEX ( co_cartera , pk_co_cartera) o/
       		   COD_CLIENTE              ,                COD_TIPDOCUM             ,                COD_CENTREMI             ,
               NUM_SECUENCI             ,                COD_VENDEDOR_AGENTE      ,                LETRA                    ,
               COD_CONCEPTO             ,                COLUMNA                  ,                COD_PRODUCTO             ,
               IMPORTE_DEBE             ,                0                        ,                IMPORTE_DEBE             ,
               IND_CONTADO              ,                IND_FACTURADO            ,                FEC_EFECTIVIDAD          ,
               TO_DATE(:szhFecPago,'YYYYMMDD'), 		 0                   	  ,                SYSDATE                  ,
               FEC_CADUCIDA             ,                FEC_ANTIGUEDAD           ,                FEC_VENCIMIE             ,
               NUM_CUOTA                ,                SEC_CUOTA                ,                NUM_VENTA                ,
               NUM_ABONADO              ,                NUM_FOLIO                ,                PREF_PLAZA               ,
               NUM_FOLIOCTC             ,                COD_OPERADORA_SCL        ,                COD_PLAZA
       FROM    CO_CARTERA
       WHERE   COD_CLIENTE            = :lhCodCliente
       AND     NUM_SECUENCI           = :lhNumSecuencia
	   /oAND     NUM_ABONADO            = :lhNumAbonado o/
       AND     COD_TIPDOCUM           = :ihCodTipDocum
       AND     COD_VENDEDOR_AGENTE    = :lhCodAgente
       AND     LETRA                  = :szhLetra
       AND     COD_CENTREMI           = :ihCodCentremi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_CANCELADOS (COD_CLIENTE,COD_TIPDOCUM,COD_CENT\
REMI,NUM_SECUENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,\
IMPORTE_HABER,NUM_TRANSACCION,IMPORTE_DEBE,IND_CONTADO,IND_FACTURADO,FEC_EFECT\
IVIDAD,FEC_CANCELACION,IND_PORTADOR,FEC_PAGO,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_V\
ENCIMIE,NUM_CUOTA,SEC_CUOTA,NUM_VENTA,NUM_ABONADO,NUM_FOLIO,PREF_PLAZA,NUM_FOL\
IOCTC,COD_OPERADORA_SCL,COD_PLAZA)select  /*+  INDEX ( co_cartera , pk_co_cart\
era)  +*/ COD_CLIENTE ,COD_TIPDOCUM ,COD_CENTREMI ,NUM_SECUENCI ,COD_VENDEDOR_\
AGENTE ,LETRA ,COD_CONCEPTO ,COLUMNA ,COD_PRODUCTO ,IMPORTE_DEBE ,0 ,IMPORTE_D\
EBE ,IND_CONTADO ,IND_FACTURADO ,FEC_EFECTIVIDAD ,TO_DATE(:b0,'YYYYMMDD') ,0 ,\
SYSDATE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,FEC_VENCIMIE ,NUM_CUOTA ,SEC_CUOTA ,NUM\
_VENTA ,NUM_ABONADO ,NUM_FOLIO ,PREF_PLAZA ,NUM_FOLIOCTC ,COD_OPERADORA_SCL ,C\
OD_PLAZA  from CO_CARTERA where (((((COD_CLIENTE=:b1 and NUM_SECUENCI=:b2) and\
 COD_TIPDOCUM=:b3) and COD_VENDEDOR_AGENTE=:b4) and LETRA=:b5) and COD_CENTREM\
I=:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )335;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuencia;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
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


       /*AND     NVL(SEC_CUOTA, 0)      = NVL(:ihCuota, 0);  */

	if (sqlca.sqlcode != SQLOK) {
		fprintf(TiG.lFile,"Error en el insertar en co_cancelados %s\n",szfnORAerror());
		return -1;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

	/* EXEC SQL
       INSERT INTO CO_PAGOSCONC  (
              COD_TIPDOCUM                 ,              COD_CENTREMI                 ,              NUM_SECUENCI            ,
              COD_VENDEDOR_AGENTE          ,              NUM_SECUREL                  ,              LETRA                   ,
              IMP_CONCEPTO                 ,              COD_PRODUCTO                 ,              COD_TIPDOCREL           ,
              COD_AGENTEREL                ,              NUM_TRANSACCION              ,              LETRA_REL               ,
              COD_CENTRREL                 ,              COD_CONCEPTO                 ,              COLUMNA                 ,
              NUM_ABONADO                  ,              NUM_FOLIO                    ,              PREF_PLAZA              ,
              NUM_CUOTA                    ,              SEC_CUOTA                    ,              NUM_VENTA               ,
              NUM_FOLIOCTC                 ,              COD_OPERADORA_SCL            ,              COD_PLAZA                               )
       SELECT /o+ INDEX ( co_cartera , pk_co_cartera) o/
       		  :ihCodTipDocumPago           ,              :ihCodCentremiPago          ,               :lhNumSecuenciaPago     ,
              :lhCodAgentePago             ,              NUM_SECUENCI                 ,              :szhLetraPago           ,
              IMPORTE_DEBE-IMPORTE_HABER   ,              COD_PRODUCTO                 ,              COD_TIPDOCUM            ,
              COD_VENDEDOR_AGENTE          ,              NUM_TRANSACCION              ,              LETRA                   ,
              COD_CENTREMI                 ,              COD_CONCEPTO                 ,              COLUMNA                 ,
              NUM_ABONADO                  ,              NUM_FOLIO                    ,              PREF_PLAZA              ,
              NUM_CUOTA                    ,              SEC_CUOTA                    ,              NUM_VENTA               ,
              NUM_FOLIOCTC                 ,              COD_OPERADORA_SCL            ,              COD_PLAZA
       FROM   CO_CARTERA
       WHERE  COD_CLIENTE            = :lCodCliente
          AND NUM_SECUENCI           = :lhNumSecuencia
          AND COD_TIPDOCUM           = :ihCodTipDocum
	     /o AND NUM_ABONADO            = :lhNumAbonado o/
          AND COD_VENDEDOR_AGENTE    = :lhCodAgente
          AND LETRA                  = :szhLetra
          AND COD_CENTREMI           = :ihCodCentremi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,NUM_SECUREL,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDO\
CREL,COD_AGENTEREL,NUM_TRANSACCION,LETRA_REL,COD_CENTRREL,COD_CONCEPTO,COLUMNA\
,NUM_ABONADO,NUM_FOLIO,PREF_PLAZA,NUM_CUOTA,SEC_CUOTA,NUM_VENTA,NUM_FOLIOCTC,C\
OD_OPERADORA_SCL,COD_PLAZA)select  /*+  INDEX ( co_cartera , pk_co_cartera)  +\
*/ :b0 ,:b1 ,:b2 ,:b3 ,NUM_SECUENCI ,:b4 ,(IMPORTE_DEBE-IMPORTE_HABER) ,COD_PR\
ODUCTO ,COD_TIPDOCUM ,COD_VENDEDOR_AGENTE ,NUM_TRANSACCION ,LETRA ,COD_CENTREM\
I ,COD_CONCEPTO ,COLUMNA ,NUM_ABONADO ,NUM_FOLIO ,PREF_PLAZA ,NUM_CUOTA ,SEC_C\
UOTA ,NUM_VENTA ,NUM_FOLIOCTC ,COD_OPERADORA_SCL ,COD_PLAZA  from CO_CARTERA w\
here (((((COD_CLIENTE=:b5 and NUM_SECUENCI=:b6) and COD_TIPDOCUM=:b7) and COD_\
VENDEDOR_AGENTE=:b8) and LETRA=:b9) and COD_CENTREMI=:b10)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )378;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocumPago;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentremiPago;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenciaPago;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgentePago;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetraPago;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lCodCliente;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumSecuencia;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[9] = (unsigned long )2;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihCodCentremi;
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
}


          /* AND NVL(SEC_CUOTA, 0)      = NVL(:ihCuota, 0); */

	if (sqlca.sqlcode != SQLOK) {
		fprintf(TiG.lFile,"Error en el insertar en co_pagosconc %s\n",szfnORAerror());
		return -1;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

	/* EXEC SQL
         DELETE /o+ INDEX ( co_cartera , pk_co_cartera) o/
         FROM CO_CARTERA
         WHERE COD_CLIENTE          = :lCodCliente
           AND NUM_SECUENCI         = :lhNumSecuencia
           AND COD_TIPDOCUM         = :ihCodTipDocum
	      /o AND NUM_ABONADO          = :lhNumAbonado o/
           AND COD_VENDEDOR_AGENTE  = :lhCodAgente
           AND LETRA                = :szhLetra
           AND COD_CENTREMI         = :ihCodCentremi; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/  from \
CO_CARTERA  where (((((COD_CLIENTE=:b0 and NUM_SECUENCI=:b1) and COD_TIPDOCUM=\
:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD_CENTREMI=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )437;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
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
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremi;
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


          /* AND NVL(SEC_CUOTA, 0)    = NVL(:ihCuota, 0); */

	if (sqlca.sqlcode != SQLOK) {
		fprintf(TiG.lFile,"Error en el insertar en co_cartera %s\n",szfnORAerror());
		return -1;
	} /* end if (sqlca.sqlcode != SQLOK) {*/

  	fprintf(TiG.lFile,"Fin a Cancelacion Total de Creditos por documento .\n\n");

	return 0;

} /* end if ifnCancelacionTotalCreditos()*/
/*===========================================================================
Funcion    : ifnCancelacionParcialCreditos()
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
int ifnCancelacionParcialCreditos(long lCodCliente , DATCON *stConCre, long lNumSecuenci, 
                                  int  iCodTipDocum, long lCodAgente , char * szLetra   , 
                                  int  iCodCentremi, int  iCuota     , char * szFecPago , 
								  long lNumAbonado)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente         ;
	long   lhNumSecuencia       ;
	long   lhNumAbonado         ;
	long   lhCodAgente          ;
	long   lhCodAgentePago      ;
	long   lhNumSecuenciaPago   ;
	int    ihCodCentremi        ;
	int    ihCodCentremiPago    ;
	int    ihCodTipDocum        ;
	int    ihCodTipDocumPago    ;
	int    ihCuota              ;
	char   szhLetra          [2];
	char   szhLetraPago      [2];
	char   szhFecPago       [20];
	double dhImporte            ;
/* EXEC SQL END DECLARE SECTION; */ 


    fprintf(TiG.lFile,"modulo [ifnCancelacionParcialCreditos]\n");      
    fprintf(TiG.lFile,"lCodCliente          [%ld]\n",lCodCliente );      
    fprintf(TiG.lFile,"stConCre.lNumSecuenci[%ld]\n",stConCre->lNumSecuenci );      
    fprintf(TiG.lFile,"stConCre.iCodTipDocum[%d]\n",stConCre->iCodTipDocum );      
    fprintf(TiG.lFile,"stConCre.lCodAgente  [%ld]\n",stConCre->lCodAgente );      
    fprintf(TiG.lFile,"stConCre.szLetra     [%s]\n",stConCre->szLetra );      
    fprintf(TiG.lFile,"stConCre.iCodCentremi[%d]\n",stConCre->iCodCentremi );      
    fprintf(TiG.lFile,"lNumSecuenci         [%ld]\n",lNumSecuenci );      
    fprintf(TiG.lFile,"iCodTipDocum         [%d]\n",iCodTipDocum );      
    fprintf(TiG.lFile,"lCodAgente           [%ld]\n",lCodAgente );      
    fprintf(TiG.lFile,"szLetra              [%s]\n",szLetra );      
    fprintf(TiG.lFile,"iCodCentremi         [%d]\n",iCodCentremi );      
    fprintf(TiG.lFile,"stConCre.dImporteDebe[%f]\n",stConCre->dImporteDebe );      
    fprintf(TiG.lFile,"iCuota               [%d]\n",iCuota );
    fprintf(TiG.lFile,"szFecPago            [%s]\n",szFecPago );      
    fprintf(TiG.lFile,"lNumAbonado          [%ld]\n",lNumAbonado );      

	lhCodCliente       = lCodCliente;
	lhNumSecuencia     = stConCre->lNumSecuenci;
	ihCodTipDocum      = stConCre->iCodTipDocum;
	lhCodAgente        = stConCre->lCodAgente;
	strcpy(szhLetra, stConCre->szLetra);
	ihCodCentremi      = stConCre->iCodCentremi;
	lhNumSecuenciaPago = lNumSecuenci;
	ihCodTipDocumPago  = iCodTipDocum;
	dhImporte          = stConCre->dImporteDebe;
	ihCuota            = iCuota;
	strcpy(szhFecPago, szFecPago);
	strcpy(szhLetraPago, szhLetra);
	lhCodAgentePago    = lCodAgente;
    ihCodCentremiPago  = iCodCentremi;
	lhNumAbonado       = lNumAbonado;

	/* EXEC SQL EXECUTE
		BEGIN
		  CO_P_PAGO_PARCIALES_FACTURA(:lhCodCliente     , :lhNumSecuencia  				  , :ihCodTipDocum  , 
                                      :lhCodAgente       , :szhLetra         			  , :ihCodCentremi  , 
                                      :lhNumSecuenciaPago, :ihCodTipDocumPago			  , :lhCodAgentePago, 
                                      :szhLetraPago      , :ihCodCentremiPago			  , :dhImporte      , 
                                      :ihCuota           , TO_DATE(:szhFecPago,'YYYYMMDD')); /o, :lhNumAbonado    ) ; o/
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_P_PAGO_PARCIALES_FACTURA ( :lhCodCliente , :lhNumSe\
cuencia , :ihCodTipDocum , :lhCodAgente , :szhLetra , :ihCodCentremi , :lhNumS\
ecuenciaPago , :ihCodTipDocumPago , :lhCodAgentePago , :szhLetraPago , :ihCodC\
entremiPago , :dhImporte , :ihCuota , TO_DATE ( :szhFecPago , 'YYYYMMDD' ) ) ;\
 END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )476;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
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
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumSecuenciaPago;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocumPago;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCodAgentePago;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhLetraPago;
 sqlstm.sqhstl[9] = (unsigned long )2;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihCodCentremiPago;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&dhImporte;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&ihCuota;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhFecPago;
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


	
  	fprintf(TiG.lFile,"Fin a Cancelacion Parcial de Creditos (por documento).\n\n");

	return 0;

} /* end if ifnCancelacionParcialCreditos()*/

/*===========================================================================
Funcion : ifnCancelacionCreditos()
Descripcion: Funcion encargada de cancelar los creditos para un cliente.
Entrada:    lCodCliente, codigo de cliente.
			iCodCredito, es el codigo del credito.
Salida:     TRUE, si todo ha ido bien.
			 	ERR_xxx, si falla algo.
===========================================================================*/
int ifnCancelacionCreditos( long lCodCliente, char *szFecValor, int k)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNum_Transaccion     ;
	long lhCodCliente          ;
	char szhFec_Pago       [20];
	int  ihRetorno             ;
	char szhGlosa         [500];
	int  ihCarrier  = 0        ;
/* EXEC SQL END DECLARE SECTION; */ 

	
	/*---------------------------------------------------------------------*/
	fprintf(TiG.lFile,"modulo [ifnCancelacionCreditos] \n"); 
	fprintf(TiG.lFile,"Ejecuta CO_CANCELACION_PG.CO_CANCELACREDITOS_PR\n");
	
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
 sqlstm.offset = (unsigned int  )547;
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
	    fprintf(TiG.lFile,"En SELECT GA_SEQ_TRANSACABO.NEXTVAL.\n ");
	    return -1;
	}
	
	lhCodCliente=lCodCliente;
	strncpy(szhFec_Pago,szFecValor,8);
	fprintf(TiG.lFile, "\n\t****** Registro #[%03d] ******"
							 "\n\t\t=> lhCodCliente      [%ld]"
							 "\n\t\t=> szFecPago         [%s] "
							 "\n\t\t=> lhNum_Transaccion [%ld]\n\n",k ,lhCodCliente ,szhFec_Pago, lhNum_Transaccion );

	/* Cancelar Creditos */
	/*iResul = ifnDBCancelacion( lCodCliente, stConCar, iCodCredito, szFec, iCarrier );*/
	
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
 sqlstm.offset = (unsigned int  )566;
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


	
	rtrim(szhGlosa);
	if (sqlca.sqlcode != SQLOK ) {
   		fprintf(TiG.lFile,"\nError en CO_CANCELACREDITOS_PR\n%s\n ",sqlca.sqlerrm.sqlerrmc);
   }
   if (ihRetorno == 99) {
   		fprintf(TiG.lFile,"Valor de Retorno es 99. Posible error en la PL\n ");
   
   }
   else if (ihRetorno != 0)   {
   		fprintf(TiG.lFile,"Valor ihRetorno [%d]\n",ihRetorno);
   		fprintf(TiG.lFile,"Error en CO_CANCELACREDITOS_PR. [%s]\n ",szhGlosa);
	}

	fprintf(TiG.lFile,"Valor ihRetorno [%d]\n",ihRetorno);
  	fprintf(TiG.lFile,"Fin a Cancelacion de Creditos.\n\n");
	return ihRetorno;

}/* Fin ifnCancelacionCreditos() */


/*===========================================================================
Funcion : bfnDBSumImporte()
Descripcion: Obtiene la deuda de un abonado en una factura determinada
===========================================================================*/
BOOL bfnDBSumImporte(DATCON *stCon,long lCodCliente,double *dImporte)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long    lhCodCliente   ;
	long    lhNumAbonado   ;
	int     ihCodTipDocum  ;
	long    lhCodAgente    ;
	char    szhLetra[2]    ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodCentrEmi  ;
	long    lhNumSecuenci  ;
	double  dhImporteDebe  ;
	int     ihCodProducto  ;
	char    szhCARTERA [11];
	char    szhTIPDOCUM[23];
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf(TiG.lFile,"*****************************************************  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"modulo [bfnDBSumImporte]  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	strcpy(szhCARTERA ,"CO_CARTERA");
    strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
	lhCodCliente   = lCodCliente;
	ihCodTipDocum  = stCon->iCodTipDocum;
	ihCodCentrEmi  = stCon->iCodCentremi;
	lhNumSecuenci  = stCon->lNumSecuenci;
	lhCodAgente    = stCon->lCodAgente;
	strcpy(szhLetra, stCon->szLetra);
	ihCodProducto  = stCon->iCodProducto;
	lhNumAbonado   = stCon->lNumAbonado;
	
	fprintf(TiG.lFile,"cliente %ld\n",lhCodCliente);
	fprintf(TiG.lFile,"tipdocum %d\n",ihCodTipDocum);
	fprintf(TiG.lFile,"centremi %d\n",ihCodCentrEmi);
	fprintf(TiG.lFile,"numsecuenci %ld\n",lhNumSecuenci);
	fprintf(TiG.lFile,"codagente %ld\n",lhCodAgente);
	fprintf(TiG.lFile,"letra %s\n",szhLetra);
	fprintf(TiG.lFile,"producto %d\n",ihCodProducto);
	/*fprintf(TiG.lFile,"abonado %ld\n",lhNumAbonado);*/
	
	/* Cursor para recuperar el importe abonado producto. */
	/* EXEC SQL
	SELECT /o+ INDEX ( co_cartera , pk_co_cartera) o/
	NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0.0)
	INTO	 :dhImporteDebe
	FROM	 CO_CARTERA
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_TIPDOCUM    = :ihCodTipDocum
	AND	 COD_CENTREMI    = :ihCodCentrEmi
	AND	 NUM_SECUENCI    = :lhNumSecuenci
	AND	 COD_VENDEDOR_AGENTE = :lhCodAgente
	AND	 LETRA           = :szhLetra
	/oAND  NUM_ABONADO     = :lhNumAbonadoo/
	AND  NOT EXISTS (SELECT 1
					 FROM   CO_CODIGOS           
					 WHERE  NOM_TABLA    = :szhCARTERA 
					 AND    NOM_COLUMNA  = :szhTIPDOCUM 
                     AND    COD_TIPDOCUM =  TO_NUMBER(COD_VALOR) ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/ NVL(su\
m((IMPORTE_DEBE-IMPORTE_HABER)),0.0) into :b0  from CO_CARTERA where ((((((COD\
_CLIENTE=:b1 and COD_TIPDOCUM=:b2) and COD_CENTREMI=:b3) and NUM_SECUENCI=:b4)\
 and COD_VENDEDOR_AGENTE=:b5) and LETRA=:b6) and  not exists (select 1  from C\
O_CODIGOS where ((NOM_TABLA=:b7 and NOM_COLUMNA=:b8) and COD_TIPDOCUM=TO_NUMBE\
R(COD_VALOR))))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )605;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[7] = (unsigned long )11;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[8] = (unsigned long )23;
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


/* Soporte R&C XO-609  09.09.2005*/
/*	AND 	 COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR) 
									    FROM   CO_CODIGOS           
									    WHERE  NOM_TABLA = :szhCARTERA 
									    AND    NOM_COLUMNA = :szhTIPDOCUM );*/
	
	if (sqlca.sqlcode)
	{
		fprintf(stderr,"* Error al obtener el importe %s\n",szfnORAerror());
		return FALSE;
	}
	
	if (dhImporteDebe == 0.0)
	{
		*dImporte = 0.0;
		return FALSE;
	}
	
	/* manejo de decimales segun la operadora local */
	fprintf(TiG.lFile,"\n14 dhImporteDebe = %f antes de fnCnvDouble\n", dhImporteDebe ); /*CAPC 24-02-2004 MA-200402200339*/
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	*dImporte = dhImporteDebe;
	
	return TRUE;
}/* Fin bfnDBSumImporte() */


/*===========================================================================
Funcion : bfnDBSumImporteAbo()
Descripcion: Obtiene la deuda de un abonado en una factura determinada
===========================================================================*/
BOOL bfnDBSumImporteAbo(DATCON *stCon,long lCodCliente,double *dImporte)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long    lhCodCliente   ;
	long    lhNumAbonado   ;
	int     ihCodTipDocum  ;
	long    lhCodAgente    ;
	char    szhLetra[2]    ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodCentrEmi  ;
	long    lhNumSecuenci  ;
	double  dhImporteDebe  ;
	int     ihCodProducto  ;
	int     ihSecCuota     ;
	char    szhCARTERA [11];
	char    szhTIPDOCUM[23];
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf(TiG.lFile,"*****************************************************  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"modulo [bfnDBSumImporteAbo]  \n");					/*CAPC 24-02-2004 MA-200402200339*/
	strcpy(szhCARTERA ,"CO_CARTERA");
   strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
	lhCodCliente   = lCodCliente;
	ihCodTipDocum  = stCon->iCodTipDocum;
	ihCodCentrEmi  = stCon->iCodCentremi;
	lhNumSecuenci  = stCon->lNumSecuenci;
	lhCodAgente    = stCon->lCodAgente;
	strcpy(szhLetra, stCon->szLetra);
	ihCodProducto  = stCon->iCodProducto;
	lhNumAbonado   = stCon->lNumAbonado;
	
	fprintf(TiG.lFile,"cliente %ld\n",lhCodCliente);
	fprintf(TiG.lFile,"tipdocum %d\n",ihCodTipDocum);
	fprintf(TiG.lFile,"centremi %d\n",ihCodCentrEmi);
	fprintf(TiG.lFile,"numsecuenci %ld\n",lhNumSecuenci);
	fprintf(TiG.lFile,"codagente %ld\n",lhCodAgente);
	fprintf(TiG.lFile,"letra %s\n",szhLetra);
	fprintf(TiG.lFile,"producto %d\n",ihCodProducto);
	/*fprintf(TiG.lFile,"abonado %ld\n",lhNumAbonado);*/
	
	/* Cursor para recuperar el importe abonado producto. */
	/* EXEC SQL
	SELECT /o+ INDEX ( co_cartera , pk_co_cartera) o/
	NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0.0)
	INTO	 :dhImporteDebe
	FROM	 CO_CARTERA
	WHERE	 COD_CLIENTE = :lhCodCliente
	AND	 COD_TIPDOCUM    = :ihCodTipDocum
	AND	 COD_CENTREMI    = :ihCodCentrEmi
	AND	 NUM_SECUENCI    = :lhNumSecuenci
	AND	 COD_VENDEDOR_AGENTE = :lhCodAgente
	AND	 LETRA           = :szhLetra
	/o AND	 NUM_ABONADO     = :lhNumAbonadoo/
	AND	 COD_PRODUCTO    = :ihCodProducto
	AND  NOT EXISTS (SELECT 1
					 FROM   CO_CODIGOS           
					 WHERE  NOM_TABLA    = :szhCARTERA 
					 AND    NOM_COLUMNA  = :szhTIPDOCUM 
                     AND    COD_TIPDOCUM =  TO_NUMBER(COD_VALOR) ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  INDEX ( co_cartera , pk_co_cartera)  +*/ NVL(su\
m((IMPORTE_DEBE-IMPORTE_HABER)),0.0) into :b0  from CO_CARTERA where (((((((CO\
D_CLIENTE=:b1 and COD_TIPDOCUM=:b2) and COD_CENTREMI=:b3) and NUM_SECUENCI=:b4\
) and COD_VENDEDOR_AGENTE=:b5) and LETRA=:b6) and COD_PRODUCTO=:b7) and  not e\
xists (select 1  from CO_CODIGOS where ((NOM_TABLA=:b8 and NOM_COLUMNA=:b9) an\
d COD_TIPDOCUM=TO_NUMBER(COD_VALOR))))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )656;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
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
 sqlstm.sqhstv[8] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[8] = (unsigned long )11;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[9] = (unsigned long )23;
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


/* Soporte R&C XO-609  09.09.2005*/
/*	AND 	 COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR) 
									    FROM   CO_CODIGOS           
									    WHERE  NOM_TABLA = :szhCARTERA 
									    AND    NOM_COLUMNA = :szhTIPDOCUM );*/
	
	if (sqlca.sqlcode)
	{
		fprintf(stderr,"* Error al obtener el importe %s\n",szfnORAerror());
		return FALSE;
	}
	
	if (dhImporteDebe == 0.0)
	{
		*dImporte = 0.0;
		return FALSE;
	}
	
	/* manejo de decimales segun la operadora local */
	fprintf(TiG.lFile,"\n\n 15 dhImporteDebe (Abonado) = %f antes de fnCnvDouble", dhImporteDebe ); /*CAPC 24-02-2004 MA-200402200339*/
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	*dImporte = dhImporteDebe;
	
	return TRUE;
}/* Fin bfnDBSumImporteAbo() */


/*===========================================================================
Funcion : ifnDBAjusteNC()
Descripcion:  Funcion que obtiene todos los creditos de un cliente y los
               cancela.
Entrada:       stCli, estructura de datos de cliente.
               iCodCredito, codigo de credito.
Salida:        TRUE, si todo va bien.
               ERR_xxx, si falla algo.
===========================================================================*/
int ifnDBAjusteNC(DATCON *stCreN,DATCON *stConCre,int iCodCredito, long lCodCliente, char *szFecValor)
{
typedef  char  asc41[4];
typedef  char  asc21[2];
typedef  char  asc91[9];
typedef  char  asc121[12];
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/* EXEC SQL TYPE asc41 IS STRING(4); */ 

	/* EXEC SQL TYPE asc21 IS STRING(2); */ 

	/* EXEC SQL TYPE asc91 IS STRING(9); */ 

	/* EXEC SQL TYPE asc121 IS STRING(12); */ 

	
	long	  lhCodCliente;
	int     ihCodTipDocum;
	int     ihCodCentremi;
	long    lhNumSecuenci;
	long    lhCodAgente;
	char    szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodCredito[512];
	int     ihColumna[512];
	int     ihCodProducto;
	double  dhImporteDebe[512];
	double  dhImporteHaber[512];
	asc91   szhFecEfectividad[512];
	asc91   szhFecVencimie[512];
	asc91   szhFecCaducida[512];
	asc91   szhFecAntiguedad[512];
	asc91   szhFecPago[512];
	long    lhNumAbonado;
	long    lhNumFolio[512];
	long    lhNumCuota[512];
	int     ihSecCuota[512];
	long    lhNumTransa[512];
	long    lhNumVenta[512];
	asc121  szhFolioCTC[512];
	short   shIndFecVenci[512];
	short   shIndFecCadu[512];
	short   shIndFecAnti[512];
	short   shIndFecPago[512];
	short   shIndNumFolio[512];
	short   shIndNumCuota[512];
	short   shIndSecCuota[512];
	short   shIndNumTransa[512];
	short   shIndNumVenta[512];
	short   shIndFolioCTC[512];
	char    szhPrefPlaza[512][26]; 
	char    szhCodOperadoraScl[512][6];	
	char    szhCodPlaza[512][6]		; 	
	char    szhCARTERA [11];
	char    szhTIPDOCUM[23];
	char    szhyyyymmdd[9];
/* EXEC SQL END DECLARE SECTION; */ 

	
DATCON   stCre;
int      iResul = OK;
int      iDebe;
BOOL     bResul;
BOOL     bFin = FALSE;
int      i,iNumCon = 0;
double   dResta;
int      iEncCarr = 0;

	fprintf(TiG.lFile,"*****************************************************  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"AJUSTE NC \n");
	
	strcpy(szhCARTERA ,"CO_CARTERA");
    strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
    strcpy(szhyyyymmdd,"yyyymmdd");
	lhCodCliente  = lCodCliente;
	ihCodTipDocum = stCreN->iCodTipDocum;
	ihCodCentremi = stCreN->iCodCentremi;
	lhNumSecuenci = stCreN->lNumSecuenci;
	lhCodAgente   = stCreN->lCodAgente;
	strcpy(szhLetra , stCreN->szLetra);
	ihCodProducto = stCreN->iCodProducto;
	lhNumAbonado  = stCreN->lNumAbonado;
	
	/* Cursor para tratar Creditos al haber */
	/* EXEC SQL DECLARE C_CANCREN CURSOR FOR
	SELECT	/o+ INDEX ( co_cartera , pk_co_cartera) o/
			COD_CONCEPTO,
			COLUMNA,
			IMPORTE_DEBE,
			IMPORTE_HABER,
			TO_CHAR(FEC_EFECTIVIDAD,:szhyyyymmdd),
			TO_CHAR(FEC_VENCIMIE,:szhyyyymmdd),
			TO_CHAR(FEC_CADUCIDA,:szhyyyymmdd),
			TO_CHAR(FEC_ANTIGUEDAD,:szhyyyymmdd),
			TO_CHAR(FEC_PAGO,:szhyyyymmdd),
			NUM_FOLIO,
			NUM_CUOTA,
			SEC_CUOTA,
			NUM_TRANSACCION,
			NUM_VENTA,
			NUM_FOLIOCTC,
			NVL(PREF_PLAZA,' '),
			NVL(COD_OPERADORA_SCL,' '),
			NVL(COD_PLAZA,' ')
	FROM	CO_CARTERA
	WHERE	COD_CLIENTE  = :lhCodCliente
	AND	 COD_TIPDOCUM    = :ihCodTipDocum
	AND	 COD_CENTREMI    = :ihCodCentremi
	AND	 NUM_SECUENCI    = :lhNumSecuenci
	AND	 COD_VENDEDOR_AGENTE = :lhCodAgente
	AND	 LETRA           = :szhLetra
	AND	 COD_PRODUCTO    = :ihCodProducto
	AND	 NUM_ABONADO     = :lhNumAbonado
	AND  NOT EXISTS (SELECT 1
					 FROM   CO_CODIGOS           
					 WHERE  NOM_TABLA    = :szhCARTERA 
					 AND    NOM_COLUMNA  = :szhTIPDOCUM 
                     AND    COD_TIPDOCUM = TO_NUMBER(COD_VALOR) )
/o Soporte R&C XO-609  09.09.2005o/
/o	AND 	 COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR) 
									    FROM   CO_CODIGOS           
									    WHERE  NOM_TABLA = :szhCARTERA 
									    AND    NOM_COLUMNA = :szhTIPDOCUM );o/
	ORDER BY FEC_EFECTIVIDAD; */ 

	
	/* EXEC SQL OPEN C_CANCREN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 15;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0015;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )711;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[3] = (unsigned long )9;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[4] = (unsigned long )9;
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
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[10] = (unsigned long )2;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[13] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[13] = (unsigned long )11;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[14] = (unsigned long )23;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
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
		fprintf(TiG.lFile,"Error en el cursor ajuste %s\n",szfnORAerror());
		return ERR_OPENCURSOR;
	}
	
	while (!bFin)
	{
		/* EXEC SQL FETCH C_CANCREN 
		INTO	:ihCodCredito,
				:ihColumna,
				:dhImporteDebe,
				:dhImporteHaber,
				:szhFecEfectividad,
				:szhFecVencimie:shIndFecVenci,
				:szhFecCaducida:shIndFecCadu,
				:szhFecAntiguedad:shIndFecAnti,
				:szhFecPago:shIndFecPago,
				:lhNumFolio:shIndNumFolio,
				:lhNumCuota:shIndNumCuota,
				:ihSecCuota:shIndSecCuota,
				:lhNumTransa:shIndNumTransa,
				:lhNumVenta:shIndNumVenta,
				:szhFolioCTC:shIndFolioCTC,
				:szhPrefPlaza,		
				:szhCodOperadoraScl,
				:szhCodPlaza; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 18;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )512;
  sqlstm.offset = (unsigned int  )786;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodCredito;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihColumna;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)dhImporteDebe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )sizeof(double);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)dhImporteHaber;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )sizeof(double);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecEfectividad;
  sqlstm.sqhstl[4] = (unsigned long )9;
  sqlstm.sqhsts[4] = (         int  )9;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecVencimie;
  sqlstm.sqhstl[5] = (unsigned long )9;
  sqlstm.sqhsts[5] = (         int  )9;
  sqlstm.sqindv[5] = (         short *)shIndFecVenci;
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecCaducida;
  sqlstm.sqhstl[6] = (unsigned long )9;
  sqlstm.sqhsts[6] = (         int  )9;
  sqlstm.sqindv[6] = (         short *)shIndFecCadu;
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhFecAntiguedad;
  sqlstm.sqhstl[7] = (unsigned long )9;
  sqlstm.sqhsts[7] = (         int  )9;
  sqlstm.sqindv[7] = (         short *)shIndFecAnti;
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhFecPago;
  sqlstm.sqhstl[8] = (unsigned long )9;
  sqlstm.sqhsts[8] = (         int  )9;
  sqlstm.sqindv[8] = (         short *)shIndFecPago;
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)lhNumFolio;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )sizeof(long);
  sqlstm.sqindv[9] = (         short *)shIndNumFolio;
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)lhNumCuota;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[10] = (         int  )sizeof(long);
  sqlstm.sqindv[10] = (         short *)shIndNumCuota;
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)ihSecCuota;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )sizeof(int);
  sqlstm.sqindv[11] = (         short *)shIndSecCuota;
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)lhNumTransa;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[12] = (         int  )sizeof(long);
  sqlstm.sqindv[12] = (         short *)shIndNumTransa;
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[13] = (         int  )sizeof(long);
  sqlstm.sqindv[13] = (         short *)shIndNumVenta;
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhFolioCTC;
  sqlstm.sqhstl[14] = (unsigned long )12;
  sqlstm.sqhsts[14] = (         int  )12;
  sqlstm.sqindv[14] = (         short *)shIndFolioCTC;
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[15] = (unsigned long )26;
  sqlstm.sqhsts[15] = (         int  )26;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[16] = (unsigned long )6;
  sqlstm.sqhsts[16] = (         int  )6;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[17] = (unsigned long )6;
  sqlstm.sqhsts[17] = (         int  )6;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
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

		
		
		if (sqlca.sqlcode < 0)
		{
			fprintf(TiG.lFile,"Error en Fetch C_CAN de Cancelados %s\n", szfnORAerror());
			return ERR_FETCH;
		}
		
		iNumCon = 512;
		
		if (sqlca.sqlcode == NOT_FOUND)
		{
			iNumCon = sqlca.sqlerrd[2] % 512;
			bFin = TRUE;
		}
		
		for (i=0;i<iNumCon;i++)
		{
			/* manejo de decimales segun la operadora local */
			fprintf(TiG.lFile,"\n\n 12 dhImporteDebe[i] = %f antes de fnCnvDouble", dhImporteDebe[i] );  /*CAPC 24-02-2004 MA-200402200339*/
			fprintf(TiG.lFile,"\n\n 12 dhImporteHaber[i] = %f antes de fnCnvDouble",dhImporteHaber[i] ); /*CAPC 24-02-2004 MA-200402200339*/
			dhImporteDebe[i] = fnCnvDouble( dhImporteDebe[i], 0 );
			/* manejo de decimales segun la operadora local */
			dhImporteHaber[i] = fnCnvDouble( dhImporteHaber[i], 0 );

			/* Llenamos estructura de datos de Credito. */
			stCre.iCodTipDocum = ihCodTipDocum;
			stCre.lCodAgente   = lhCodAgente;
			strcpy(stCre.szLetra,szhLetra);
			stCre.iCodCentremi = ihCodCentremi;
			stCre.lNumSecuenci = lhNumSecuenci;
			stCre.iCodProducto = ihCodProducto;
			stCre.lNumAbonado  = lhNumAbonado;
			stCre.iCodConcepto = ihCodCredito[i];
			stCre.iColumna     = ihColumna[i];
			stCre.dImporteDebe = dhImporteDebe[i];
			stCre.dImporteHaber= dhImporteHaber[i];
			strcpy(stCre.szFecEfectividad,szhFecEfectividad[i]);

			if (shIndFecVenci[i] == ORA_NULL)
				strcpy(stCre.szFecVencimie,"");
			else
				strcpy(stCre.szFecVencimie,szhFecVencimie[i]);
	
			if (shIndFecCadu[i] == ORA_NULL)
				strcpy(stCre.szFecCaducida,"");
			else
				strcpy(stCre.szFecCaducida,szhFecCaducida[i]);
	
			if (shIndFecAnti[i] == ORA_NULL)
				strcpy(stCre.szFecAntiguedad,"");
			else
				strcpy(stCre.szFecAntiguedad,szhFecAntiguedad[i]);
	
			if (shIndFecPago[i] == ORA_NULL)
				strcpy(stCre.szFecPago,"");
			else
				strcpy(stCre.szFecPago,szhFecPago[i]);
			
			if (shIndNumFolio[i] == ORA_NULL)
				stCre.lNumFolio = ORA_NULL;
			else
				stCre.lNumFolio = lhNumFolio[i];
			
			if (shIndNumCuota[i] == ORA_NULL)
				stCre.lNumCuota = ORA_NULL;
			else
				stCre.lNumCuota = lhNumCuota[i];
			
			if (shIndSecCuota[i] == ORA_NULL)
				stCre.iSecCuota = ORA_NULL;
			else
				stCre.iSecCuota = ihSecCuota[i];
			
			if (shIndNumTransa[i] == ORA_NULL)
				stCre.lNumTransa = ORA_NULL;
			else
				stCre.lNumTransa = lhNumTransa[i];
			
			if (shIndNumVenta[i] == ORA_NULL)
				stCre.lNumVenta = ORA_NULL;
			else
				stCre.lNumVenta = lhNumVenta[i];
	
			if (shIndFolioCTC[i] == ORA_NULL)
				strcpy(stCre.szFolioCTC,"");
			else
				strcpy(stCre.szFolioCTC,szhFolioCTC[i]);
			
			strcpy( stCre.szPrefPlaza, szhPrefPlaza[i] );				
			strcpy( stCre.szCodOperadoraScl, szhCodOperadoraScl[i] );
			strcpy( stCre.szCodPlaza, szhCodPlaza[i] );					

			dResta = stCre.dImporteHaber - stCre.dImporteDebe;
			fprintf(TiG.lFile,"\n\n2 dResta = %f", dResta );

			if (dResta < 0.0)
			{
				fprintf(TiG.lFile,"error debehaber\n");
				return ERR_DEBEHABER;
			}
			
			if (dResta == 0.0)
			{
				fprintf(TiG.lFile,"error importe cero\n");
				return ERR_IMPCERO;
			}
			
			fprintf(TiG.lFile,"\n\nCREDITO OBTENIDO ...\n");
			fprintf(TiG.lFile,"tipdocum %d\n",stCre.iCodTipDocum);
			fprintf(TiG.lFile,"agente %ld\n",stCre.lCodAgente);
			fprintf(TiG.lFile,"letra %s\n",stCre.szLetra);
			fprintf(TiG.lFile,"centremi %d\n",stCre.iCodCentremi);
			fprintf(TiG.lFile,"numsecuenci %ld\n",stCre.lNumSecuenci);
			fprintf(TiG.lFile,"concepto %d\n",stCre.iCodConcepto);
			fprintf(TiG.lFile,"columna %d\n",stCre.iColumna);
			fprintf(TiG.lFile,"importe debe %f\n",stCre.dImporteDebe);
			fprintf(TiG.lFile,"importe haber%f\n",stCre.dImporteHaber);
			fprintf(TiG.lFile,"producto %d\n",stCre.iCodProducto);
			fprintf(TiG.lFile,"fecha efectividad %s\n",stCre.szFecEfectividad);
			fprintf(TiG.lFile,"fecha vencimiento %s\n",stCre.szFecVencimie);
			fprintf(TiG.lFile,"fecha caducidad %s\n",stCre.szFecCaducida);
			fprintf(TiG.lFile,"fecha antiguedad %s\n",stCre.szFecAntiguedad);
			fprintf(TiG.lFile,"fecha Pago %s\n",stCre.szFecPago);
			fprintf(TiG.lFile,"num abonado %ld\n",stCre.lNumAbonado);
			fprintf(TiG.lFile,"num folio %ld\n",stCre.lNumFolio);
			fprintf(TiG.lFile,"num cuota %ld\n",stCre.lNumCuota);
			fprintf(TiG.lFile,"sec cuota %d\n",stCre.iSecCuota);
			fprintf(TiG.lFile,"num Transa %ld\n",stCre.lNumTransa);
			fprintf(TiG.lFile,"num venta %ld\n",stCre.lNumVenta);
			fprintf(TiG.lFile,"pref plaza %s\n",stCre.szPrefPlaza);
			fprintf(TiG.lFile,"operadora %s\n",stCre.szCodOperadoraScl);
			fprintf(TiG.lFile,"cod plaza %s\n",stCre.szCodPlaza);
			fprintf(TiG.lFile,"\n\nCREDITO OBTENIDO ...\n");
			
			/* el importe del credito debe ser mayor o igual que 0.01 */
			if (dResta > 0.0)
			{
				iResul = ifnTratConcepNotas( &stCre, stConCre, lCodCliente, szFecValor, &iEncCarr );
				if (iResul != OK)
					return iResul;
			}/* impconcepto >= 0.0 */
			
			dResta = stCre.dImporteHaber - stCre.dImporteDebe;
			
		}/* For */
	}/*Fin del cursor  C_CANCREN*/
	
	/* EXEC SQL CLOSE C_CANCREN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 18;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )873;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode != 0)
	{
		fprintf(TiG.lFile,"Error al cerrar el cursor %s\n",szfnORAerror());
		return ERR_CLOSECURSOR;
	}
	
	return OK;

}/* Fin ifnDBAjusteNC() */


/*===========================================================================
Funcion : ifnTratConcepNotas()
Descripcion: Funcion que obtiene los conceptos del cliente y los cancela con
             el credito que se pasa como parametro.
Entrada:     stCre, puntero a la estructura del credito.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             ERR_xxx, si falla algo.
===========================================================================*/
int ifnTratConcepNotas(DATCON *stCre,DATCON *stConCre,long lCodCliente, char *szFec,int *iEncCarr)
{
typedef  char  asc42[4];
typedef  char  asc22[2];
typedef  char  asc92[9];
typedef  char  asc122[12];

/* EXEC SQL BEGIN DECLARE SECTION; */ 


	/* EXEC SQL TYPE asc42 IS STRING(4); */ 

	/* EXEC SQL TYPE asc22 IS STRING(2); */ 

	/* EXEC SQL TYPE asc92 IS STRING(9); */ 

	/* EXEC SQL TYPE asc122 IS STRING(12); */ 

	
	long    lhCodCliente;
	int     ihCodTipDocum;
	long    lhCodAgente;
	char    szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodCentremi;
	long    lhNumSecuenci;
	long    lhNumAbonado;
	int     ihCodProducto;
	int     ihCodCredito;
	int     ihCodConcepto[512];
	int     ihColumna[512];
	double  dhImporteDebe[512];
	double  dhImporteHaber[512];
	asc92   szhFecEfectividad[512];
	asc92   szhFecVencimie[512];
	asc92   szhFecCaducida[512];
	asc92   szhFecAntiguedad[512];
	long    lhNumFolio[512];
	long    lhNumCuota[512];
	int     ihSecCuota[512];
	long    lhNumTransa[512];
	long    lhNumVenta[512];
	asc122  szhFolioCTC[512];
	short   shIndFecVenci[512];
	short   shIndFecCadu[512];
	short   shIndFecAnti[512];
	short   shIndNumFolio[512];
	short   shIndNumCuota[512];
	short   shIndSecCuota[512];
	short   shIndNumTransa[512];
	short   shIndNumVenta[512];
	short   shIndFolioCTC[512];
	char    szhPrefPlaza[512][26];
	char    szhCodOperadoraScl[512][6];
	char    szhCodPlaza[512][6]		; 
	char    szhCARTERA [11];
	char    szhTIPDOCUM[23];
	char    szhyyyymmdd[9];
	int     ihValor_dos = 2;
	int     ihValor_seis = 6;
/* EXEC SQL END DECLARE SECTION; */ 


DATCON   stCon;
int      iResul = OK;
int      iDebe,iCol;
double   dCantCre,dCantCon;
BOOL     bResul;
double   dImporte;
BOOL     bFin = FALSE;
int      i,iNumCon = 0;
int      iCanCon, iCanCre;
double   dImpAux, dImpPagConc;
int      iEncon;
	
	fprintf(TiG.lFile,"*****************************************************  \n");
	fprintf(TiG.lFile,"TratConceptos \n");
	
	strcpy(szhCARTERA ,"CO_CARTERA");
    strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
    strcpy(szhyyyymmdd,"yyyymmdd");
	dImpAux = 0.0;
	dImpPagConc = 0.0;
	lhCodCliente = lCodCliente;
	ihCodTipDocum = stConCre->iCodTipDocum;
	ihCodCentremi = stConCre->iCodCentremi;
	lhNumSecuenci = stConCre->lNumSecuenci;
	lhCodAgente = stConCre->lCodAgente;
	strcpy(szhLetra , stConCre->szLetra);
	lhNumAbonado = stConCre->lNumAbonado;
	ihCodProducto = stConCre->iCodProducto;

	/* Cursor para tratar los conceptos del cliente */
	/* EXEC SQL DECLARE C_CONCEPNOT CURSOR FOR
	SELECT	/o+ INDEX ( co_cartera , pk_co_cartera) o/
			A.COD_CONCEPTO,
			A.COLUMNA,
			A.IMPORTE_DEBE,
			A.IMPORTE_HABER,
			TO_CHAR(A.FEC_EFECTIVIDAD,:szhyyyymmdd),
			TO_CHAR(A.FEC_VENCIMIE,:szhyyyymmdd),
			TO_CHAR(A.FEC_CADUCIDA,:szhyyyymmdd),
			TO_CHAR(A.FEC_ANTIGUEDAD,:szhyyyymmdd),
			A.NUM_FOLIO,
			A.NUM_CUOTA,
			A.SEC_CUOTA,
			A.NUM_TRANSACCION,
			A.NUM_VENTA,
			A.NUM_FOLIOCTC,
			NVL(A.PREF_PLAZA,' '),	
			NVL(A.COD_OPERADORA_SCL,' '),
			NVL(A.COD_PLAZA,' ')
	FROM	CO_CARTERA A, CO_CONCEPTOS B
	WHERE	A.COD_CLIENTE   = :lhCodCliente
	AND	A.COD_TIPDOCUM  = :ihCodTipDocum
	AND	A.COD_CENTREMI  = :ihCodCentremi
	AND	A.NUM_SECUENCI  = :lhNumSecuenci
	AND	A.COD_VENDEDOR_AGENTE = :lhCodAgente
	AND	A.LETRA         = :szhLetra
	AND	A.NUM_ABONADO   = :lhNumAbonado
	AND	A.COD_PRODUCTO  = :ihCodProducto
	AND	A.COD_CONCEPTO  = B.COD_CONCEPTO
	AND A.COD_CONCEPTO NOT IN (:ihValor_dos,:ihValor_seis)  /o 2:Abono - 6:Castigo Contable o/
	AND NOT EXISTS (SELECT 1
					 FROM   CO_CODIGOS           
					 WHERE  NOM_TABLA    = :szhCARTERA 
					 AND    NOM_COLUMNA  = :szhTIPDOCUM 
                     AND    COD_TIPDOCUM =  TO_NUMBER(COD_VALOR) )
/o Soporte R&C XO-609  09.09.2005o/
/o	AND 	 COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR) 
									    FROM   CO_CODIGOS           
									    WHERE  NOM_TABLA = :szhCARTERA 
									    AND    NOM_COLUMNA = :szhTIPDOCUM );o/
    ORDER BY A.FEC_ANTIGUEDAD, B.ORDEN_CAN,A.COD_PRODUCTO, A.NUM_ABONADO; */ 


   /* EXEC SQL OPEN C_CONCEPNOT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 18;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0016;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )888;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhyyyymmdd;
   sqlstm.sqhstl[0] = (unsigned long )9;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhyyyymmdd;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhyyyymmdd;
   sqlstm.sqhstl[2] = (unsigned long )9;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhyyyymmdd;
   sqlstm.sqhstl[3] = (unsigned long )9;
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
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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
   sqlstm.sqhstv[7] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[9] = (unsigned long )2;
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
   sqlstm.sqhstv[11] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihValor_dos;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)&ihValor_seis;
   sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhCARTERA;
   sqlstm.sqhstl[14] = (unsigned long )11;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhTIPDOCUM;
   sqlstm.sqhstl[15] = (unsigned long )23;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)0;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
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
      fprintf(TiG.lFile,"Error en el cursor tratar conceptos notas %s\n",
																					szfnORAerror());
      return ERR_OPENCURSOR;
   }

   while (!bFin)
   {
		/* EXEC SQL FETCH C_CONCEPNOT 
		INTO	:ihCodConcepto,
				:ihColumna,
				:dhImporteDebe,
				:dhImporteHaber,
				:szhFecEfectividad,
				:szhFecVencimie:shIndFecVenci,
				:szhFecCaducida:shIndFecCadu,
				:szhFecAntiguedad:shIndFecAnti,
				:lhNumFolio:shIndNumFolio,
				:lhNumCuota:shIndNumCuota,
				:ihSecCuota:shIndSecCuota,
				:lhNumTransa:shIndNumTransa,
				:lhNumVenta:shIndNumVenta,
				:szhFolioCTC:shIndFolioCTC,
				:szhPrefPlaza,		
				:szhCodOperadoraScl,
				:szhCodPlaza; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 18;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )512;
  sqlstm.offset = (unsigned int  )967;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )sizeof(int);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ihColumna;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)dhImporteDebe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )sizeof(double);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)dhImporteHaber;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )sizeof(double);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecEfectividad;
  sqlstm.sqhstl[4] = (unsigned long )9;
  sqlstm.sqhsts[4] = (         int  )9;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecVencimie;
  sqlstm.sqhstl[5] = (unsigned long )9;
  sqlstm.sqhsts[5] = (         int  )9;
  sqlstm.sqindv[5] = (         short *)shIndFecVenci;
  sqlstm.sqinds[5] = (         int  )sizeof(short);
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecCaducida;
  sqlstm.sqhstl[6] = (unsigned long )9;
  sqlstm.sqhsts[6] = (         int  )9;
  sqlstm.sqindv[6] = (         short *)shIndFecCadu;
  sqlstm.sqinds[6] = (         int  )sizeof(short);
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhFecAntiguedad;
  sqlstm.sqhstl[7] = (unsigned long )9;
  sqlstm.sqhsts[7] = (         int  )9;
  sqlstm.sqindv[7] = (         short *)shIndFecAnti;
  sqlstm.sqinds[7] = (         int  )sizeof(short);
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)lhNumFolio;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )sizeof(long);
  sqlstm.sqindv[8] = (         short *)shIndNumFolio;
  sqlstm.sqinds[8] = (         int  )sizeof(short);
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)lhNumCuota;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )sizeof(long);
  sqlstm.sqindv[9] = (         short *)shIndNumCuota;
  sqlstm.sqinds[9] = (         int  )sizeof(short);
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)ihSecCuota;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[10] = (         int  )sizeof(int);
  sqlstm.sqindv[10] = (         short *)shIndSecCuota;
  sqlstm.sqinds[10] = (         int  )sizeof(short);
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)lhNumTransa;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[11] = (         int  )sizeof(long);
  sqlstm.sqindv[11] = (         short *)shIndNumTransa;
  sqlstm.sqinds[11] = (         int  )sizeof(short);
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[12] = (         int  )sizeof(long);
  sqlstm.sqindv[12] = (         short *)shIndNumVenta;
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhFolioCTC;
  sqlstm.sqhstl[13] = (unsigned long )12;
  sqlstm.sqhsts[13] = (         int  )12;
  sqlstm.sqindv[13] = (         short *)shIndFolioCTC;
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[14] = (unsigned long )26;
  sqlstm.sqhsts[14] = (         int  )26;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[15] = (unsigned long )6;
  sqlstm.sqhsts[15] = (         int  )6;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[16] = (unsigned long )6;
  sqlstm.sqhsts[16] = (         int  )6;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
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


		
		if (sqlca.sqlcode < 0)
		{
			fprintf(TiG.lFile,"Error en Fetch C_CONCEP de Cancelados %s\n", szfnORAerror());
			return ERR_FETCH;
		}
		
		iNumCon = 512;
		
		if (sqlca.sqlcode == NOT_FOUND)
		{
			iNumCon = sqlca.sqlerrd[2] % 512;
			bFin = TRUE;
		}
		
		for( i = 0; i < iNumCon; i++ )
		{
			/* manejo de decimales segun la operadora local */
			fprintf(TiG.lFile,"\n\n 13 dhImporteDebe[i] = %f antes de fnCnvDouble", dhImporteDebe[i] );  /*CAPC 24-02-2004 MA-200402200339*/
			fprintf(TiG.lFile,"\n\n 13 dhImporteHaber[i] = %f antes de fnCnvDouble",dhImporteHaber[i] ); /*CAPC 24-02-2004 MA-200402200339*/
			dhImporteDebe[i] = fnCnvDouble( dhImporteDebe[i], 0 );
			/* manejo de decimales segun la operadora local */
			dhImporteHaber[i] = fnCnvDouble( dhImporteHaber[i], 0 );
						
			/* Codigo de credito != codigo de concepto sino no hago nada */
			if (stCre->iCodConcepto != ihCodConcepto[i])
			{
				iEncon = 0;
				bResul = bfnDBCompConcepto(ihCodConcepto[i],&iEncon);
				if (!bResul)
					return ERR_COMPCARRIER;
				
				dCantCre = stCre->dImporteHaber - stCre->dImporteDebe;
				/* MGG dCantCre = (dCantCre * INVMIN) / INVMIN; */
				
				/* Llenamos estructura de datos de Concepto. */
				stCon.iCodTipDocum = ihCodTipDocum;
				stCon.lCodAgente   = lhCodAgente;
				strcpy(stCon.szLetra,szhLetra);
				stCon.iCodCentremi = ihCodCentremi;
				stCon.lNumSecuenci = lhNumSecuenci;
				stCon.iCodProducto = ihCodProducto;
				stCon.lNumAbonado  = lhNumAbonado;
				stCon.iCodConcepto = ihCodConcepto[i];
				stCon.iColumna     = ihColumna[i];
				stCon.dImporteDebe = dhImporteDebe[i] ;
				stCon.dImporteHaber= dhImporteHaber[i] ;
				strcpy(stCon.szFecEfectividad,szhFecEfectividad[i]);
	
				if (shIndFecVenci[i] == ORA_NULL)
					strcpy(stCon.szFecVencimie,"");
				else
					strcpy(stCon.szFecVencimie,szhFecVencimie[i]);
	
				if (shIndFecCadu[i] == ORA_NULL)
					strcpy(stCon.szFecCaducida,"");
				else
					strcpy(stCon.szFecCaducida,szhFecCaducida[i]);
	
				if (shIndFecAnti[i] == ORA_NULL)
					strcpy(stCon.szFecAntiguedad,"");
				else
					strcpy(stCon.szFecAntiguedad,szhFecAntiguedad[i]);
				
				if (shIndNumFolio[i] == ORA_NULL)
					stCon.lNumFolio = ORA_NULL;
				else
					stCon.lNumFolio = lhNumFolio[i];
				
				if (shIndNumCuota[i] == ORA_NULL)
					stCon.lNumCuota = ORA_NULL;
				else
					stCon.lNumCuota = lhNumCuota[i];
				
				if (shIndSecCuota[i] == ORA_NULL)
					stCon.iSecCuota = ORA_NULL;
				else
					stCon.iSecCuota = ihSecCuota[i];
				
				if (shIndNumTransa[i] == ORA_NULL)
					stCon.lNumTransa = ORA_NULL;
				else
					stCon.lNumTransa = lhNumTransa[i];
				
				if (shIndNumVenta[i] == ORA_NULL)
					stCon.lNumVenta = ORA_NULL;
				else
					stCon.lNumVenta = lhNumVenta[i];
	
				if (shIndFolioCTC[i] == ORA_NULL)
					strcpy(stCon.szFolioCTC,"");
				else
					strcpy(stCon.szFolioCTC,szhFolioCTC[i]);
				
				strcpy( stCon.szPrefPlaza, szhPrefPlaza[i] );
				strcpy( stCon.szCodOperadoraScl, szhCodOperadoraScl[i] );
				strcpy( stCon.szCodPlaza, szhCodPlaza[i] );

				fprintf(TiG.lFile,"\n\n stCon.dImporteDebe = %f", stCon.dImporteDebe );   /*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n stCon.dImporteHaber = %f", stCon.dImporteHaber ); /*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n stCon.iCodTipDocum = %d", stCon.iCodTipDocum );   /*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n stCon.lNumSecuenci = %ld", stCon.lNumSecuenci);   /*CAPC 24-02-2004 MA-200402200339*/
				dCantCon = stCon.dImporteDebe - stCon.dImporteHaber;
				/* MGG dCantCon = (dCantCon * INVMIN) / INVMIN; */
				fprintf(TiG.lFile,"\n\ndCantCon = %f", dCantCon );
				
				if (dCantCon < 0.0)
					return ERR_HABERDEBE;
				if (dCantCon == 0.0)
					return ERR_IMPCERO;
	
				fprintf(TiG.lFile,"\n\nCONCEPTO OBTENIDO");
				fprintf(TiG.lFile,"tipdocum %d\n",stCon.iCodTipDocum);
				fprintf(TiG.lFile,"agente %ld\n",stCon.lCodAgente);
				fprintf(TiG.lFile,"letra %s\n",stCon.szLetra);
				fprintf(TiG.lFile,"centremi %d\n",stCon.iCodCentremi);
				fprintf(TiG.lFile,"numsecuenci %ld\n",stCon.lNumSecuenci);
				fprintf(TiG.lFile,"concepto %d\n",stCon.iCodConcepto);
				fprintf(TiG.lFile,"columna %d\n",stCon.iColumna);
				fprintf(TiG.lFile,"importe debe %f\n",stCon.dImporteDebe);
				fprintf(TiG.lFile,"importe haber %f\n",stCon.dImporteHaber);
				fprintf(TiG.lFile,"producto %d\n",stCon.iCodProducto);
				fprintf(TiG.lFile,"fecha efectividad %s\n",stCon.szFecEfectividad);
				fprintf(TiG.lFile,"fecha vencimiento %s\n",stCon.szFecVencimie);
				fprintf(TiG.lFile,"fecha caducidad %s\n",stCon.szFecCaducida);
				fprintf(TiG.lFile,"fecha antiguedad %s\n",stCon.szFecAntiguedad);
				fprintf(TiG.lFile,"num abonado %ld\n",stCon.lNumAbonado);
				fprintf(TiG.lFile,"num folio %ld\n",stCon.lNumFolio);
				fprintf(TiG.lFile,"num cuota %ld\n",stCon.lNumCuota);
				fprintf(TiG.lFile,"sec cuota %d\n",stCon.iSecCuota);
				fprintf(TiG.lFile,"num Transa %ld\n",stCon.lNumTransa);
				fprintf(TiG.lFile,"num venta %ld\n",stCon.lNumVenta);
				fprintf(TiG.lFile,"pref plaza %s\n",stCon.szPrefPlaza);
				fprintf(TiG.lFile,"operadora %s\n",stCon.szCodOperadoraScl);
				fprintf(TiG.lFile,"cod plaza %s\n",stCon.szCodPlaza);
				fprintf(TiG.lFile,"\n\nCONCEPTO OBTENIDO");
				
				/* Calcular el credito debito y meterlo en cartera. */
				/* MGG dImporte = ((dCantCon - dCantCre) * INVMIN) / INVMIN; */
				fprintf(TiG.lFile,"\n\n dCantCon = %f", dCantCon );	/*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n dCantCre = %f", dCantCre );	/*CAPC 24-02-2004 MA-200402200339*/
				dImporte = dCantCon - dCantCre;
				dImporte = fnCnvDouble(dImporte, 0);
				fprintf(TiG.lFile,"\n\n dImporte = %f", dImporte );	/*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n stCon.iCodTipDocum = %d", stCon.iCodTipDocum );	/*CAPC 24-02-2004 MA-200402200339*/
				fprintf(TiG.lFile,"\n\n stCon.lNumSecuenci = %ld", stCon.lNumSecuenci); /*CAPC 24-02-2004 MA-200402200339*/
				
				if (iEncon)
				{
					fprintf(TiG.lFile,"ha encontrado un carrier\n");
					if (dImporte > 0.0)
					{
						fprintf(TiG.lFile, "No Cancela el concepto ir a por otro\n");
						*iEncCarr = 1;
					}
				}
	
				if( ( ( dImporte <= 0.0 ) && ( iEncon ) ) || ( !iEncon ) )
				{
					fprintf(TiG.lFile,"\n\n entro en ---> ** dImporte <= 0.0  &&  iEncon ** ||  !iEncon  "); /*CAPC 24-02-2004 MA-200402200339*/
					if( dImporte > 0.0 )
					{
						dImpPagConc = dCantCre;
						/* concepto es mayor que el credito */
						stCon.dImporteHaber = stCon.dImporteHaber + dCantCre;
						/* MGG stCon.dImporteHaber = (stCon.dImporteHaber*INVMIN)/INVMIN; */
						stCre->dImporteDebe = stCre->dImporteHaber;
						fprintf(TiG.lFile,"\n\n dImpPagConc = %f", dImpPagConc );	/*CAPC 24-02-2004 MA-200402200339*/
						fprintf(TiG.lFile,"\n\n stCon.dImporteHaber = %f", stCon.dImporteHaber ); /*CAPC 24-02-2004 MA-200402200339*/
						fprintf(TiG.lFile,"\n\n stCre->dImporteDebe = %f", stCre->dImporteDebe ); /*CAPC 24-02-2004 MA-200402200339*/
						iCanCon = 0;
						iCanCre = 1;
					}
					else
					{
						if (dImporte <= 0.0)
						{
							if (dImporte == 0.0)
							{
								dImpPagConc = (stCon.dImporteDebe - stCon.dImporteHaber);
								/* concepto es igual que el credito */
								stCon.dImporteHaber = stCon.dImporteDebe;
								stCre->dImporteDebe = stCre->dImporteHaber;
								fprintf(TiG.lFile,"\n\n dImpPagConc = %f", dImpPagConc ); /*CAPC 24-02-2004 MA-200402200339*/
								fprintf(TiG.lFile,"\n\n stCon.dImporteHaber = %f", stCon.dImporteHaber ); /*CAPC 24-02-2004 MA-200402200339*/
								fprintf(TiG.lFile,"\n\n stCre->dImporteDebe = %f", stCre->dImporteDebe ); /*CAPC 24-02-2004 MA-200402200339*/
								iCanCon = 1;
								iCanCre = 1;
							}
							else
							{
								/* concepto es menor que el credito */
								dImpPagConc = (stCon.dImporteDebe - stCon.dImporteHaber);
								stCon.dImporteHaber = stCon.dImporteDebe;
								stCre->dImporteDebe = stCre->dImporteDebe + dCantCon;
								/* MGG stCre->dImporteDebe = (stCre->dImporteDebe*INVMIN)/INVMIN; */
								iCanCon = 1;
								iCanCre = 0;
							}/* else if (dImporte == 0.0)*/
						}/* if (dImporte <= 0.0)*/
					}/* if (dImporte > 0.0)*/
					
					/* Modificar en la cartera los importes de los conceptos */
					bResul = bfnDBUpdCartera(&stCon,lCodCliente);
					if (!bResul)
						return ERR_UPDATECARTE;
					
					bResul = bfnDBUpdCartera(stCre,lCodCliente);
					if (!bResul)
						return ERR_UPDATECARTE;
				
					/* Introducir la relacion entre el credito y el concepto */
					dImpAux = stCon.dImporteHaber;
					stCon.dImporteHaber = dImpPagConc;
					bResul = bfnDBInsCreCon(stCre,&stCon);
					if (!bResul)
						return ERR_INSPAGCON;
			
					stCon.dImporteHaber = dImpAux;
					
					fprintf(TiG.lFile,"\n\n iCanCon = %d", iCanCon );  /*CAPC 24-02-2004 MA-200402200339*/
					fprintf(TiG.lFile,"\n\n iCanCre = %d", iCanCre );  /*CAPC 24-02-2004 MA-200402200339*/
					if (iCanCon == 1)
					{
						/* Se ha cancelado el concepto */
						fprintf(TiG.lFile,"LLEVAR A CAN CONCENTO \n");
						bResul = bfnDBLlevarACanCtos(&stCon,lCodCliente,szFec);
						if (!bResul)
							return ERR_MOVCON;
				
						fprintf(TiG.lFile,"FIN DE LLEVAR A CAN CONCENTO \n");
					} /*if (iCanCon == 1)*/
					
					if (iCanCre == 1)
					{
						/* Se ha cancelado el credito */
						bResul = bfnDBLlevarACanCtos(stCre,lCodCliente,szFec);
						if (!bResul)
							return ERR_MOVCON;
				
						/* ya no tengo credito y he de terminar */
						dCantCre = 0.0;
						bFin = TRUE;
						break;
						/* si el importe no es mayor o igual que
						el IMPORTEMINIMO salir */
						/* ya no queda importe de credito <= importe concepto */
						/* no puedo seguir cogiendo conceptos sin dinero */
					}/* if (iCanCre == 1)*/
				}/* if (((dImporte <= 0.0) && (iEncon)) || (!iEncon))*/
			}/* Fin concepto != credito */
		}/* For */
	}/*Fin del cursor  C_CONCEPNOT */

	/* EXEC SQL CLOSE C_CONCEPNOT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 18;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1050;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (sqlca.sqlcode != 0)
	{
		fprintf(TiG.lFile,"Error al cerrar el cursor %s\n",szfnORAerror());
		return ERR_CLOSECURSOR;
	} 
	
	return OK;
}/* Fin ifnTratConcepNotas()*/


/*===========================================================================
Funcion : bfnDBInsCreCon()
Descripcion: Lleva la relacion del pago con el concepto a pagosconc.
Salida     : En caso de error devuelve FALSE.
===========================================================================*/
BOOL bfnDBInsCreCon(DATCON *stDoc,DATCON *stHab)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 


   int     ihCodTipDocum  ;
   int     ihCodCentremi  ;
   long    lhNumSecuenci  ;
   long    lhCodAgente    ; 
   char    *szhLetra      ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

   double  dhImporteDebe  ;
   int     ihCodProducto  ;
   int     ihCodTipDocRel ;
   int     ihCodCenRel    ;
   long    lhNumSecRel    ;
   long    lhCodAgeRel    ;
   char    *szhLetraRel   ; /* EXEC SQL VAR szhLetraRel IS STRING(2); */ 

   int     ihCodConcepto  ;
   int     ihColumna      ;
   long    lhNumAbonado   ;
   long    lhNumFolio     ;
   long    lhNumCuota     ;
   int     ihSecCuota     ;
   long    lhNumTransa    ;
   long    lhNumVenta     ;
   short   shIndCodTipDocRel;
   short   shIndCodCenRel ;
   short   shIndNumSecRel ;
   short   shIndCodAgeRel ;
   short   shIndLetraRel  ;
   short   shIndCodConcepto;
   short   shIndColumna   ;
   short   shIndNumAbonado;
   short   shIndNumFolio  ;
   short   shIndNumCuota  ;
   short   shIndSecCuota  ;
   short   shIndNumTransa ;
   short   shIndNumVenta  ;
   char    szhPrefPlaza[26]		; /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

   char    szhCodOperadoraScl[6]	; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 

   char    szhCodPlaza[6]		; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
		

/* EXEC SQL END DECLARE SECTION; */ 


	fprintf(TiG.lFile,"*****************************************************  \n");  /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"bfnDBInsCreCon ... datos para insert into pagosconc  \n");	 /*CAPC 24-02-2004 MA-200402200339*/

   /* Preparamos datos para insert en pagosconc */
	ihCodTipDocum = stDoc->iCodTipDocum;
	fprintf(TiG.lFile,"tipdocum %d\n",ihCodTipDocum);
	ihCodCentremi = stDoc->iCodCentremi;
	fprintf(TiG.lFile,"centremi %d\n",ihCodCentremi);
	lhNumSecuenci = stDoc->lNumSecuenci;
	fprintf(TiG.lFile,"numsecuenci %ld\n",lhNumSecuenci);
	lhCodAgente  = stDoc->lCodAgente;
	fprintf(TiG.lFile,"agente %ld\n",lhCodAgente);
	szhLetra      = stDoc->szLetra;
	fprintf(TiG.lFile,"letra %s\n",szhLetra);
	dhImporteDebe  = stHab->dImporteHaber;
	fprintf(TiG.lFile,"importe %f\n",dhImporteDebe);
	ihCodProducto  = stHab->iCodProducto;
	fprintf(TiG.lFile,"producto %d\n",ihCodProducto);

	if (stHab->iCodTipDocum == ORA_NULL)
		shIndCodTipDocRel = ORA_NULL;
	else
	{
		ihCodTipDocRel = stHab->iCodTipDocum;
		shIndCodTipDocRel = 0;
	}
	
	fprintf(TiG.lFile,"tipdocum %d\n",ihCodTipDocRel);
	
	if (stHab->iCodCentremi == ORA_NULL)
		shIndCodCenRel = ORA_NULL;
	else
	{
		ihCodCenRel    = stHab->iCodCentremi;
		shIndCodCenRel = 0;
	}
	
	fprintf(TiG.lFile,"centro %d\n",ihCodCenRel);
	
	if (stHab->lNumSecuenci == ORA_NULL)
		shIndNumSecRel = ORA_NULL;
	else
	{
		lhNumSecRel    = stHab->lNumSecuenci;
		shIndNumSecRel = 0;
	}
	
	fprintf(TiG.lFile,"secuenci %ld\n",lhNumSecRel);
	
	if (stHab->lCodAgente == ORA_NULL)
		shIndCodAgeRel = ORA_NULL;
	else
	{
		lhCodAgeRel    = stHab->lCodAgente;
		shIndCodAgeRel = 0;
	}

	fprintf(TiG.lFile,"agente %ld\n",lhCodAgeRel);
	
	if ((strlen(stHab->szLetra)) == 0)
	{
		szhLetraRel = "";
		shIndLetraRel = ORA_NULL;
	}
	else
	{
		szhLetraRel = stHab->szLetra;
		shIndLetraRel = 0;
	}
	
	if (stHab->iCodConcepto == ORA_NULL)
		shIndCodConcepto = ORA_NULL;
	else
	{
		ihCodConcepto  = stHab->iCodConcepto;
		shIndCodConcepto = 0;
	}
	
	fprintf(TiG.lFile,"concepto %d\n",ihCodConcepto);
	
	if (stHab->iColumna == ORA_NULL)
		shIndColumna = ORA_NULL;
	else
	{
		ihColumna      = stHab->iColumna;
		shIndColumna = 0;
	}
	
	fprintf(TiG.lFile,"columna %d\n",ihColumna);
	
	if (stHab->lNumAbonado == ORA_NULL)
		shIndNumAbonado = ORA_NULL;
	else
	{
		lhNumAbonado   = stHab->lNumAbonado;
		shIndNumAbonado = 0;
	}
	
	fprintf(TiG.lFile,"numAbonado %ld\n",lhNumAbonado);
	
	if (stHab->lNumFolio == ORA_NULL)
		shIndNumFolio = ORA_NULL;
	else
	{
		lhNumFolio     = stHab->lNumFolio;
		shIndNumFolio = 0;
	}
	
	fprintf(TiG.lFile,"numFolio %ld\n",lhNumFolio);
	
	if (stHab->lNumCuota == ORA_NULL)
		shIndNumCuota = ORA_NULL;
	else
	{
		lhNumCuota     = stHab->lNumCuota;
		shIndNumCuota = 0;
	}
	
	fprintf(TiG.lFile,"Numcuota %ld\n",lhNumCuota);
	
	if (stHab->iSecCuota == ORA_NULL)
		shIndSecCuota = ORA_NULL;
	else
	{
		ihSecCuota     = stHab->iSecCuota;
		shIndSecCuota = 0;
	}
	
	fprintf(TiG.lFile,"Seccuota %d\n",ihSecCuota);
	
	if (stHab->lNumTransa == ORA_NULL)
		shIndNumTransa = ORA_NULL;
	else
	{
		lhNumTransa    = stHab->lNumTransa;
		shIndNumTransa = 0;
	}
	
	fprintf(TiG.lFile,"Transa %ld\n",lhNumTransa);
	
	if (stHab->lNumVenta == ORA_NULL)
		shIndNumVenta = ORA_NULL;
	else
	{
		lhNumVenta    = stHab->lNumVenta;
		shIndNumVenta = 0;
	}
	
	strcpy(szhPrefPlaza,stHab->szPrefPlaza);
	strcpy(szhCodOperadoraScl,stHab->szCodOperadoraScl);
	strcpy(szhCodPlaza,stHab->szCodPlaza);

	fprintf(TiG.lFile,"venta %ld\n",lhNumVenta);
	fprintf(TiG.lFile,"antes del insert\n");
	
	/* manejo de decimales segun la operadora local */
	fprintf(TiG.lFile,"\n\n 10 dhImporteDebe = %f antes de fnCnvDouble", dhImporteDebe ); /*CAPC 24-02-2004 MA-200402200339*/
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	
	/* Insert en pagosconc */
	/* EXEC SQL
	INSERT INTO CO_PAGOSCONC (	
           COD_TIPDOCUM  ,
           COD_CENTREMI  ,
           NUM_SECUENCI  ,
           COD_VENDEDOR_AGENTE    ,
           LETRA         ,
           IMP_CONCEPTO  ,
           COD_PRODUCTO  ,
           COD_TIPDOCREL ,
           COD_CENTRREL  ,
           NUM_SECUREL   ,
           COD_AGENTEREL ,
           LETRA_REL     ,
           COD_CONCEPTO  ,
           COLUMNA       ,
           NUM_ABONADO   ,
           NUM_FOLIO     ,
           NUM_CUOTA     ,
           SEC_CUOTA     ,
           NUM_TRANSACCION,
           NUM_VENTA     ,
           PREF_PLAZA    ,
           COD_OPERADORA_SCL,
           COD_PLAZA )
	VALUES (  :ihCodTipDocum ,
			  :ihCodCentremi ,
			  :lhNumSecuenci ,
			  :lhCodAgente   ,
			  :szhLetra      ,
			  :dhImporteDebe ,
			  :ihCodProducto ,
			  :ihCodTipDocRel:shIndCodTipDocRel,
			  :ihCodCenRel:shIndCodCenRel,
			  :lhNumSecRel:shIndNumSecRel,
			  :lhCodAgeRel:shIndCodAgeRel,
			  :szhLetraRel:shIndLetraRel,
			  :ihCodConcepto:shIndCodConcepto,
			  :ihColumna:shIndColumna,
			  :lhNumAbonado:shIndNumAbonado,
			  :lhNumFolio:shIndNumFolio,
			  :lhNumCuota:shIndNumCuota,
			  :ihSecCuota:shIndSecCuota,
			  :lhNumTransa:shIndNumTransa,
			  :lhNumVenta:shIndNumVenta,
			  :szhPrefPlaza,
			  :szhCodOperadoraScl,
			  :szhCodPlaza ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 23;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCREL,COD_CEN\
TRREL,NUM_SECUREL,COD_AGENTEREL,LETRA_REL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,NUM\
_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,PREF_PLAZA,COD_OPERADORA_\
SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7:b8,:b9:b10,:b11:b12,:b1\
3:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29:b30,\
:b31:b32,:b33,:b34,:b35)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1065;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentremi;
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
 sqlstm.sqhstv[5] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocRel;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)&shIndCodTipDocRel;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCenRel;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)&shIndCodCenRel;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lhNumSecRel;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)&shIndNumSecRel;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&lhCodAgeRel;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)&shIndCodAgeRel;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhLetraRel;
 sqlstm.sqhstl[11] = (unsigned long )2;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)&shIndLetraRel;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)&shIndCodConcepto;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)&shIndColumna;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)&shIndNumAbonado;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)&shIndNumFolio;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&lhNumCuota;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&shIndNumCuota;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&ihSecCuota;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&shIndSecCuota;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)&shIndNumTransa;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&lhNumVenta;
 sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)&shIndNumVenta;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[20] = (unsigned long )26;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)0;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[21] = (unsigned long )6;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[22] = (unsigned long )6;
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
}



	if (sqlca.sqlcode)
	{
		fprintf(stderr,"* Error en Insert PAGCONC %s\n",szfnORAerror());
		return FALSE;
	}
	
	return TRUE;
} /* Fin DBInsCreCon(...) */


/*===========================================================================
Funcion : bfnDBCompConcepto()
Descripcion: Funcion que comprueba si el concepto es el un concepto carrier
Salida     : TRUE si todo es correcto
				 FALSE si falla algo
===========================================================================*/
BOOL bfnDBCompConcepto( int iCodConcepto, int *iEncon )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihCodConcepto;
	int	ihCodConceptoRec;
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf(TiG.lFile,"*****************************************************  \n"); /*CAPC 24-02-2004 MA-200402200339*/
	fprintf(TiG.lFile,"bfnDBCompConcepto  \n");					/*CAPC 24-02-2004 MA-200402200339*/
	ihCodConcepto = iCodConcepto;
	
	/* EXEC SQL
	SELECT a.COD_CONCEPTO
	INTO	 :ihCodConceptoRec
	FROM	 CO_CONCEPTOS a, CO_DATGEN b
	WHERE	 a.COD_CONCEPTO = :ihCodConcepto
	AND	 a.COD_TIPCONCE = b.TIP_CONCEPCARRIER; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 23;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select a.COD_CONCEPTO into :b0  from CO_CONCEPTOS a ,CO_DATG\
EN b where (a.COD_CONCEPTO=:b1 and a.COD_TIPCONCE=b.TIP_CONCEPCARRIER)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1172;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConceptoRec;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
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


	
	if( sqlca.sqlcode < 0 )
	{
		fprintf( stderr, "* Error al comprobar si el concepto es carrier\n", szfnORAerror() );
		return FALSE;
	}
	
	if( sqlca.sqlcode == NOT_FOUND )
		*iEncon = 0;
	else
		*iEncon = 1;
	
	return TRUE;
}/* Fin bfnDBCompConcepto() */


/*===========================================================================
Funcion : bfnDBObtDatGen()
Definicion		:	Selecciona el path del archivo log
===========================================================================*/
BOOL bfnDBObtDatGen()
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhPathLog[384]; /* EXEC SQL VAR szhPathLog IS STRING(384); */ 

/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL 
	SELECT PATHLOG
	INTO	 :szhPathLog
	FROM	 CO_DATGEN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 23;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select PATHLOG into :b0  from CO_DATGEN ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1195;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhPathLog;
 sqlstm.sqhstl[0] = (unsigned long )384;
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
		fprintf(stderr,"ERROR select de CO_DATGEN %s\n", szfnORAerror());
		return FALSE;
	}
	
	strcpy(TiG.szPathLog,szhPathLog);
	return TRUE;
}/*fin bfnDBObtDatGen*/


/*===========================================================================
Funcion : rtrim()
Definicion		:	Quita los espacios en blanco a la derecha de una cadena.
Parametros		:	szCadena	cadena de trabajo.
===========================================================================*/
void rtrim( char *szCadena )
{
char modulo[] = "rtrim";
int i, iLen, iCnt;

    iLen = strlen( szCadena ) - 1;
    for( iCnt = iLen; iCnt >= 0; iCnt-- ) if( szCadena[iCnt] != ' ' && szCadena[iCnt] != '\0' ) break;
    szCadena[ iCnt + 1 ] = '\0'; 	/* reemplaza primer ' ' por '\0' produciendo un rtrim */
    return;
} /* void rtrim( char *szCadena ) */



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

