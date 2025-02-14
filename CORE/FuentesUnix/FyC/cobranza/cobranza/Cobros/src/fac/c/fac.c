
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
           char  filnam[12];
};
static const struct sqlcxp sqlfpn =
{
    11,
    "./pc/fac.pc"
};


static unsigned int sqlctx = 107459;


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
   unsigned char  *sqhstv[35];
   unsigned long  sqhstl[35];
            int   sqhsts[35];
            short *sqindv[35];
            int   sqinds[35];
   unsigned long  sqharm[35];
   unsigned long  *sqharc[35];
   unsigned short  sqadto[35];
   unsigned short  sqtdso[35];
} sqlstm = {12,35};

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

 static const char *sq0009 = 
"select nvl(COD_CONCEPTO,0) ,nvl(COLUMNA,0) ,nvl(IMPORTE_DEBE,0) ,nvl(IMPORTE\
_HABER,0) ,nvl(NUM_ABONADO,0) ,nvl(NUM_FOLIO,0) ,nvl(NUM_CUOTA,0) ,nvl(SEC_CUO\
TA,0) ,NUM_TRANSACCION ,nvl(NUM_VENTA,0) ,nvl(COD_PRODUCTO,0) ,nvl(PREF_PLAZA,\
'000') ,nvl(COD_OPERADORA_SCL,'TMG') ,nvl(COD_PLAZA,'00001')  from CO_CARTERA \
where ((((((COD_CLIENTE=:b0 and NUM_SECUENCI=:b1) and COD_TIPDOCUM=:b2) and CO\
D_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD_CENTREMI=:b5) and NUM_TRANSACCIO\
N=:b6) order by SEC_CUOTA  for update ";

 static const char *sq0010 = 
"select nvl(COD_CONCEPTO,0) ,nvl(COLUMNA,0) ,nvl(IMPORTE_DEBE,0) ,nvl(IMPORTE\
_HABER,0) ,nvl(NUM_ABONADO,0) ,nvl(NUM_FOLIO,0) ,nvl(NUM_CUOTA,0) ,nvl(SEC_CUO\
TA,0) ,NUM_TRANSACCION ,nvl(NUM_VENTA,0) ,nvl(COD_PRODUCTO,0) ,NVL(PREF_PLAZA,\
'000') ,NVL(COD_OPERADORA_SCL,'TMG') ,NVL(COD_PLAZA,'00001')  from CO_CARTERA \
where ((((((COD_CLIENTE=:b0 and NUM_SECUENCI=:b1) and COD_TIPDOCUM=:b2) and CO\
D_VENDEDOR_AGENTE=:b3) and LETRA=:b4) and COD_CENTREMI=:b5) and NUM_TRANSACCIO\
N=:b6) for update ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,96,0,4,100,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
28,0,0,2,132,0,4,174,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
59,0,0,3,206,0,4,185,0,0,11,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,2,3,0,0,2,
3,0,0,2,4,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
118,0,0,4,186,0,4,211,0,0,11,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,2,4,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
177,0,0,5,106,0,5,357,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
200,0,0,6,54,0,4,403,0,0,1,0,0,1,0,2,3,0,0,
219,0,0,7,193,0,6,420,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,3,3,0,0,2,3,0,0,2,
97,0,0,
258,0,0,8,102,0,4,497,0,0,4,1,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,1,3,0,0,
289,0,0,9,504,0,9,636,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,
332,0,0,9,0,0,13,650,0,0,14,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
403,0,0,9,0,0,15,813,0,0,0,0,0,1,0,
418,0,0,10,484,0,9,931,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,
461,0,0,10,0,0,13,942,0,0,14,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
532,0,0,10,0,0,15,1050,0,0,0,0,0,1,0,
547,0,0,11,0,0,17,1209,0,0,1,1,0,1,0,1,97,0,0,
566,0,0,11,0,0,45,1223,0,0,0,0,0,1,0,
581,0,0,11,0,0,13,1233,0,0,14,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
652,0,0,11,0,0,15,1339,0,0,0,0,0,1,0,
667,0,0,12,308,0,4,1390,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
702,0,0,13,396,0,4,1414,0,0,8,3,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,
749,0,0,14,176,0,2,1450,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,
792,0,0,15,183,0,4,1470,0,0,8,3,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,
839,0,0,16,181,0,4,1503,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,3,0,0,
882,0,0,17,163,0,2,1516,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,
921,0,0,18,257,0,4,1599,0,0,11,10,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,2,4,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
980,0,0,19,261,0,4,1613,0,0,10,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,2,4,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1035,0,0,20,161,0,4,1675,0,0,6,3,0,1,0,1,97,0,0,2,4,0,0,2,3,0,0,2,5,0,0,1,3,0,
0,1,3,0,0,
1074,0,0,21,55,0,4,1737,0,0,1,0,0,1,0,2,5,0,0,
1093,0,0,22,716,0,3,1936,0,0,29,29,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1224,0,0,23,1274,0,3,2079,0,0,35,35,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,
1379,0,0,24,247,0,2,2160,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1434,0,0,25,114,0,5,2223,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1465,0,0,26,105,0,5,2238,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1496,0,0,27,138,0,5,2278,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1527,0,0,28,69,0,4,2355,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
1550,0,0,29,635,0,3,2587,0,0,27,27,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,
1673,0,0,30,109,0,4,2681,0,0,2,1,0,1,0,2,4,0,0,1,5,0,0,
1696,0,0,31,109,0,4,2693,0,0,2,1,0,1,0,2,4,0,0,1,5,0,0,
1719,0,0,32,474,0,3,2878,0,0,23,23,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1826,0,0,33,55,0,4,2997,0,0,1,0,0,1,0,2,5,0,0,
1845,0,0,34,192,0,4,3059,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
1888,0,0,35,149,0,3,3083,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
1931,0,0,36,174,0,5,3149,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
1974,0,0,37,635,0,3,3381,0,0,27,27,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,
2097,0,0,38,299,0,5,3519,0,0,12,12,0,1,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
2160,0,0,39,125,0,4,3559,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
};


/*************************************************************************************************************
	Fichero  	: fac.pc
	Modulo		: Cobros.
	Descripcion	: Funcion de interfaz de paso a cobros con facturacion
	Fecha       : 23-04-97.
	Autor		   : Julia Serrano.
Modificaciones:
03-04-2002	Se agregan rutinas para manejo de decimales de acuerdo a la definicion de la operadora local
16-05-2002	Se agrega a query de filtro para creditos a recuperar la restriccion ind_facturado = 1
            Se cambia en las querys la condicion                    
21-11-2002	Se agregan salidas a archivo LOG, en vez de a la salida estandar (PANTALLA).
16-04-2003	Se agregan valores operadora, cod_plaza, prefijo plaza al crear la cuota 0.
*****************************************************************************************************************
*****************************************************************************************************************
Modificado por Proyecto MAS_03043 Mejoras Cancelacion de Credito.
*****************************************************************************************************************/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <geora.h>   	
#include <GenTypes.h>   /* Declaracion de tipos generales.     	*/
#include <GenORA.h>     /* Libreria general ORACLE.            	*/
#include <coerr.h>      /* Declaracion de constantes de error. 	*/
#include "fac.h"      	/* Tipos y funciones para canc. pagos. 	*/

int iConceptoCredito, iConceptoConsumo;
long glNumSecuenciaCIC = 0;
static FILE *fArchLog = stdout;

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


/****************************************************************************/
BOOL bfnInicializaLogFac( FILE *fpLOG )
{
	fArchLog = ( fpLOG == (FILE *)NULL ) ? fArchLog : fpLOG;
	return TRUE;
}

/****************************************************************************/
int ifnDBPasoCob( 	long lCodCliente	,	 int iCodTipDocum		,	long lCodAgente  ,  
					char *szLetra 		,	 int iCodCentremi		,	long lNumSecuenci,  
					 int iCodProducto	,	long lNumTransa			, 	long lNumVenta   ,  
					char *szFecValor	,	char *szFecPriCuota		, 	long lNumProceso ,
					long lNumAbonado	,	 int iCodTipMovimiento	, 	char *pszPrefPlaza,
					char *pszCodOperadora,	char *pszCodPlaza )
/**
Descripcion: Funcion de interfaz con Facturacion en primera venta NO regalo
Salida	  :	OK si todo va bien
		ERR_xxx si hay algun error
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int    ihIndPaso;
	long   lhNumVenta;
	long   lhNumTransa;
	int    ihCodProducto;
	long   lhCodCliente;
	double dImpAbono = 0;
	int    iIndAbono = 0;
	char   szFechaVenta[9];       
	char   szFecPrimeraCuota[9];       
	int    iEncon = 0;
	long   lhNumSecuenciaCIC = 0;
	char   szPrefPlaza[26];
	char   szCodOperadoraScl[6];
	char   szCodPlaza[6];
	long   lhNumProceso;
	char   szhyyyymmdd  [9];
	int    ihValor_cero = 0;
	int    ihValor_uno  = 1;
	char szhDIAS_VCTO_FACTURA[18];   /* EXEC SQL VAR szhDIAS_VCTO_FACTURA IS STRING(18); */ 
 /* Soporte RyC CO-200607310285 05-08-2006 capc */
	char    szD_Vcto_Fact[10];   /* EXEC SQL VAR szD_Vcto_Fact IS STRING(10); */ 
 /* Soporte RyC CO-200607310285 05-08-2006 capc */	
/* EXEC SQL END DECLARE SECTION; */ 


DATCON stCon;
BOOL   bResul;
int    iResul;
double dImporteCo = 0.0;
double dImporteFa = 0.0;
double dImp = 0.0;
int    iCodCredito;

	fprintf( fArchLog, "En funcion ifnDBPasoCob().\n" );
	memset( szFecPrimeraCuota, '\0', sizeof( szFecPrimeraCuota ) );
	memset( szPrefPlaza, '\0', sizeof( szPrefPlaza ) );
	memset( szCodOperadoraScl, '\0', sizeof( szCodOperadoraScl ) );
	memset( szCodPlaza, '\0', sizeof( szCodPlaza ) );
	strcpy(szhyyyymmdd,"yyyymmdd");
	strcpy(szhDIAS_VCTO_FACTURA,"DIAS_VCTO_FACTURA");   /* Soporte RyC CO-200607310285 05-08-2006 capc */
	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )
	{
		fprintf( fArchLog, "Error en funcion bGetParamDecimales.\n" );
		return -1;
	}

   	/* Inicio Soporte RyC CO-200607310285 05-08-2006 capc */
   	/* Obtiene DIAS DE VENCIMIENTO QUE SE AGREGAN A LAS CUOTAS desde la tabla GED_PARAMETROS */
   	/* EXEC SQL
   	SELECT VAL_PARAMETRO
   	  INTO :szD_Vcto_Fact
   	  FROM GED_PARAMETROS
   	 WHERE COD_MODULO    = 'GA'
   	  AND  NOM_PARAMETRO = :szhDIAS_VCTO_FACTURA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(COD_MODULO='GA' and NOM_PARAMETRO=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szD_Vcto_Fact;
    sqlstm.sqhstl[0] = (unsigned long )10;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDIAS_VCTO_FACTURA;
    sqlstm.sqhstl[1] = (unsigned long )18;
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
		fprintf( fArchLog, "Error al obtener szhDIAS_VCTO_FACTURA para Cuota 0 %s.\n", szfnORAerror() );
		return ERR_SELECT;
	}	  
	/* Fin Soporte RyC CO-200607310285 05-08-2006 capc */

	szFecValor[8] = 0;
	
	lhNumVenta = lNumVenta;
	lhNumTransa = lNumTransa;
	ihCodProducto = iCodProducto;
	lhCodCliente = lCodCliente;
	lhNumProceso = lNumProceso;
	
	/* Rellenar datos de Concepto */
	stCon.iCodTipDocum = iCodTipDocum;
	stCon.lCodAgente = lCodAgente;
	strcpy(stCon.szLetra, szLetra);
	stCon.iCodCentremi = iCodCentremi;
	stCon.lNumSecuenci = lNumSecuenci;
	stCon.lNumTransa = lNumTransa;
	stCon.lNumVenta = lNumVenta;
	stCon.iCodProducto = iCodProducto;
	strcpy( szFecPrimeraCuota, szFecPriCuota );        
	strcpy( szPrefPlaza, pszPrefPlaza );        
	strcpy( szCodOperadoraScl, pszCodOperadora );        
	strcpy( szCodPlaza, pszCodPlaza );        

	fprintf( fArchLog,	"Datos de Entrada para ifnDBPasoCob\n"
						"\tlCodCliente     => [%d],\n"
						"\tiCodTipDocum    => [%d],\n"
						"\tlCodAgente      => [%d],\n"
						"\tszLetra         => [%s],\n"
						"\tiCodCentremi    => [%d],\n"
						"\tlNumSecuenci    => [%d],\n"
						"\tlNumTransa      => [%d],\n"
						"\tlNumVenta       => [%d],\n"
						"\tiCodProducto    => [%d],\n"
						"\tszFecVencimie   => [%s],\n"
						"\tlhNumProceso    => [%d].\n\n",
						lCodCliente,
						stCon.iCodTipDocum,
						stCon.lCodAgente,
						stCon.szLetra,
						stCon.iCodCentremi,
						stCon.lNumSecuenci,
						stCon.lNumTransa,
						stCon.lNumVenta,
						stCon.iCodProducto,
						szFecPrimeraCuota,
						lhNumProceso );

	bResul = bfnDBObtConCreFA( &iCodCredito );
	if (!bResul)
		return ERR_DATGEN;

	if( iCodTipMovimiento == 1 ) /* Si es Venta */
	{
		/* Obtener el importe en carteventa */
		iResul = ifnDBObtImpCo( lCodCliente, &stCon, &dImporteCo, &iEncon );
		
		if( iResul != OK )
			return iResul; 

		if( lNumVenta == -1 )
		{
			/* EXEC SQL
			SELECT IND_PASOCOB
			INTO  :ihIndPaso
			FROM  GA_TRANSCONTADO
			WHERE NUM_TRANSACCION = :lhNumTransa
			AND   COD_PRODUCTO = :ihCodProducto
			AND   COD_CLIENTE  = :lhCodCliente
			FOR UPDATE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select IND_PASOCOB into :b0  from GA_TRANSCONTADO where ((\
NUM_TRANSACCION=:b1 and COD_PRODUCTO=:b2) and COD_CLIENTE=:b3) for update ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )28;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihIndPaso;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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


		}
		else
		{
			/* EXEC SQL
			SELECT IND_PASOCOB,
				   NVL( IND_ABONO, :ihValor_cero ),
				   NVL( IMP_ABONO, :ihValor_cero ),
				   TO_CHAR( FEC_VENTA + :szD_Vcto_Fact, :szhyyyymmdd )
			INTO  :ihIndPaso,
				   :iIndAbono,
				   :dImpAbono,                       
				   :szFechaVenta
			FROM  GA_VENTAS
			WHERE NUM_VENTA = :lhNumVenta
			AND   NUM_TRANSACCION = :lhNumTransa
			AND COD_CLIENTE  = :lhCodCliente
			FOR UPDATE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select IND_PASOCOB ,NVL(IND_ABONO,:b0) ,NVL(IMP_ABONO,:b0)\
 ,TO_CHAR((FEC_VENTA+:b2),:b3) into :b4,:b5,:b6,:b7  from GA_VENTAS where ((NU\
M_VENTA=:b8 and NUM_TRANSACCION=:b9) and COD_CLIENTE=:b10) for update ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )59;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szD_Vcto_Fact;
   sqlstm.sqhstl[2] = (unsigned long )10;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihIndPaso;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&iIndAbono;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&dImpAbono;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szFechaVenta;
   sqlstm.sqhstl[7] = (unsigned long )9;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhNumVenta;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
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


		}	
		
		if( sqlca.sqlcode )
		{
			fprintf( fArchLog, "Error al obtener el indicador paso a cobros %s.\n", szfnORAerror() );
			return ERR_SELECT;
		}
	}	
	else	/* es una factura Miscelanea */
	{
		fprintf( fArchLog, "Es Factura  MISCELANEA.\n" );

		/* EXEC SQL
		SELECT :ihValor_uno,				/o ind_pasocob o/
			   IMPORTE_INTER,
			   :ihValor_uno,				/o encon o/
			   :ihValor_cero,
			   NUM_SECUENCI_PAGO
		INTO  :ihIndPaso,
			   :dImporteCo,
			   :iEncon,
			   :iIndAbono,
			   :lhNumSecuenciaCIC
		FROM  CO_INTERFAZ_CAJA
		WHERE NUM_PROCESO = :lhNumProceso
		AND   IND_PASOCOB = :ihValor_cero
		AND   NUM_SECUENCI_PAGO > :ihValor_cero
		FOR UPDATE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select :b0 ,IMPORTE_INTER ,:b0 ,:b2 ,NUM_SECUENCI_PAGO into\
 :b3,:b4,:b5,:b6,:b7  from CO_INTERFAZ_CAJA where ((NUM_PROCESO=:b8 and IND_PA\
SOCOB=:b2) and NUM_SECUENCI_PAGO>:b2) for update ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )118;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihIndPaso;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&dImporteCo;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&iEncon;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&iIndAbono;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhNumSecuenciaCIC;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumProceso;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_cero;
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



		if( sqlca.sqlcode && sqlca.sqlcode != NOT_FOUND )
		{
			fprintf( fArchLog, "ERROR al Consultar la CO_INTERFAZ_CAJA => %s.\n", szfnORAerror() );
			return ERR_SELECT;
		}
		
		if( sqlca.sqlcode == NOT_FOUND )
		{
			fprintf( fArchLog, "No es factura de Convenio.\n" );
			return OK;
		}
	}
	
	fprintf( fArchLog,	"Valores recuperados.\n"
						"\tihIndPaso         => [%d]\n"
						"\tdImporteCo        => [%.2f]\n"
						"\tiEncon            => [%d]\n"
						"\tiIndAbono         => [%d]\n"
						"\tlhNumSecuenciaCIC => [%d]\n\n",
						ihIndPaso,
						dImporteCo,
						iEncon,
						iIndAbono,
						lhNumSecuenciaCIC );

	/* Obtener el importe en cartera */
	iResul = ifnDBObtImpFa( lCodCliente, &stCon, &dImporteFa );
	if( iResul != OK )
		return iResul; 

   if( ihIndPaso == 0 || ihIndPaso == 2) /*- MQ_07.05.03 ihIndPaso == 2 -*/
	{
		if( !iEncon )
		{
			/* El cliente no ha pagado y no ha habido paso a cobros */
			/* Modifica el ind_pasocob de ga_transcontado o ga_ventas */
			bResul = bfnDBUpdateVenta(lCodCliente,iCodProducto,lNumTransa, lNumVenta);
			if (!bResul)
				return ERR_UPDATEVENTA;

    		if( iIndAbono == 1 || iIndAbono == 2 )  /*- MGG_03.04.01 -*/
         {
				/* Inserta cuota 0 */
			    iResul = ifnDBInsCuota0( lCodCliente, stCon, iIndAbono, dImpAbono, szFechaVenta, 
			    		   			  	 szFecPrimeraCuota, lNumProceso, szFecValor, lNumAbonado,
			    		   			  	 szPrefPlaza, szCodOperadoraScl, szCodPlaza );
				if( iResul != 0 )
					return iResul;
	      } /* if ( iIndAbono ) */
		}
		else
		{
			fprintf( fArchLog, "Error el cliente no ha pagado y hay datos en carteventa \n" );
			return ERR_FAC2;
		}
	}
	else
	{
		if( !iEncon )
		{
			fprintf( fArchLog, "Error el cliente ha pagado y no hay datos en carteventa.\n" );
			return ERR_FAC2;
		}
		else
		{
			fprintf( fArchLog, "Antes calculos dImporteCo = [%.2f], dImporteFa  = [%.2f]\n", dImporteCo, dImporteFa );
    		
    		if( iCodTipMovimiento != 1 )	/* es una factura Miscelanea */
    			if( dImporteCo != dImporteFa )	/* si son distintos los importes es un error */
    				return ERR_IMPMISCEL;

    		if( iIndAbono == 1 || iIndAbono == 2 )  /*- MGG_03.04.01 -*/
         {
				/* Inserta cuota 0 */
			    iResul = ifnDBInsCuota0( lCodCliente, stCon, iIndAbono, dImpAbono, szFechaVenta, 
			    		   			  	 szFecPrimeraCuota, lNumProceso, szFecValor, lNumAbonado,
			    		   			  	 szPrefPlaza, szCodOperadoraScl,  szCodPlaza );
				if( iResul != 0 )
					   return iResul;
            
            dImporteFa += dImpAbono;
	      } /* if ( iIndAbono ) */
	
			fprintf( fArchLog, "Despues calculos dImporteCo = [%.2f], dImporteFa  = [%.2f]\n", dImporteCo, dImporteFa );

			if( dImporteCo == dImporteFa )
			{
				fprintf( fArchLog, "Importes son iguales.\n" );
				/* Importe en carteventa o co_interfaz_caja, es igual que importe en cartera */
				iResul = ifnDBCanVentaIgual( lCodCliente, &stCon, szFecValor, lhNumSecuenciaCIC );
				if (iResul != OK)
					return iResul;
			}
			else
			{
				if( dImporteCo > dImporteFa )
				{
					fprintf( fArchLog, "CarteVenta mayor a Cartera, si es mayor.\n" );
					dImp = dImporteCo - dImporteFa;
					dImp = fnCnvDouble( dImp, 0 );
					
					/*dImp = ( dImp * INVMIN ) / INVMIN; mgg */
					/* Importe en carteventa mayor que importe en cartera */
					iResul = ifnDBCanVentaMayor( lCodCliente, &stCon, szFecValor, dImp, iCodCredito );
					if (iResul != OK)
						return iResul;
				}
				else
				{
					fprintf( fArchLog, "Carteventa menor a Cartera.\n" );
					dImp = dImporteCo;
					/* dImp = (dImp * INVMIN) / INVMIN; mgg */
					/* Importe en carteventa menor que importe en cartera */
					iResul = ifnDBCanVentaMenor(lCodCliente,&stCon,szFecValor,dImp);
					if (iResul != OK)
						return iResul;
				}
			}
		}

		if( iCodTipMovimiento == 1 ) /* Si es Venta */
		{
			/* Modifica el ind_cancelado de co_carteventa */
			bResul = bfnDBUpdateCarVenta( lCodCliente, iCodProducto, lNumTransa );
			if( !bResul )
				return ERR_UPDATEVENTA;
		}	
		else	/* es una factura Miscelanea */
		{
			/* EXEC SQL
			UPDATE CO_INTERFAZ_CAJA SET 	
			       IND_PASOCOB	= :ihValor_uno,
					 FEC_APLICAJA  = SYSDATE,
					 NOM_USUA_APLI	= USER
			WHERE  NUM_PROCESO	= :lhNumProceso; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_INTERFAZ_CAJA  set IND_PASOCOB=:b0,FEC_APLICAJA=\
SYSDATE,NOM_USUA_APLI=USER where NUM_PROCESO=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )177;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
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


	
			if( sqlca.sqlcode )
			{
				fprintf( fArchLog, "ERROR al Actualizar la CO_INTERFAZ_CAJA => %s.\n", szfnORAerror() );
				return ERR_UPDATEVENTA;
			}
		}
	} /* if (ihIndPaso == 0) */

	/* Llamar a la cancelacion sin carrier */
	/*iResul = ifnCancelacionCreditos( lCodCliente, &stCon, iCodCredito, szFecValor, 0 ); modif 29-12-2004*/
	iResul = ifnLlamaCancelacionCredito( lCodCliente, szFecValor );
	if( iResul != OK )
		return iResul;

	return OK;
} /* Fin ifnPasoCob() */


/*****************************************************************************/
/*Funcion : ifnLlamaCancelacion 	                 	                          */
/*****************************************************************************/
int ifnLlamaCancelacionCredito( long lCodCliente, char *szFec_pago)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNum_Transaccion     ;
	long lhCodCliente          ;
	char szhFec_Pago       [20];
	int  ihRetorno             ;
	char szhGlosa         [500];
	int  ihCarrier  = 0        ;
/* EXEC SQL END DECLARE SECTION; */ 

	
	fprintf( fArchLog, "En funcion ifnLlamaCancelacionCredito().\n" );

	fprintf( fArchLog,"CO_CANCELACION_PG.CO_CANCELACREDITOS_PR\n");
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
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )200;
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
	    fprintf( fArchLog,"En SELECT GA_SEQ_TRANSACABO.NEXTVAL.", szfnORAerror() );
	    return -1;
	}
	
	lhCodCliente=lCodCliente;
	strncpy(szhFec_Pago,szFec_pago,8);
	szhFec_Pago[8] = '\0';
	fprintf( fArchLog,"\n\t******************************"
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
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_CANCELACION_PG . CO_CANCELACREDITOS_PR ( :lhCodClie\
nte , TO_DATE ( :szhFec_Pago , 'YYYYMMDD' ) , :lhNum_Transaccion , :ihCarrier \
, NULL , NULL , NULL , :ihRetorno , :szhGlosa ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )219;
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
  	 	if (sqlca.sqlcode != -1405 ) { /* Soporte RyC 34635 - Colombia 16.11.2006 */
        	fprintf( fArchLog,"En CO_CANCELACREDITOS_PR.\n", szfnORAerror() );
        	return -1;
     	}
	}   
   
   if (ihRetorno == 99) {
   	fprintf( fArchLog,"Valor de Retorno es 99. Posible error en la PL\n", szfnORAerror() );
   
   }
   else if (ihRetorno != 0)   {
   	fprintf( fArchLog,"Valor ihRetorno [%d]\n",ihRetorno);
   	fprintf( fArchLog,"En CO_CANCELACREDITOS_PR. [%s]\n ",szhGlosa);
   
   }

  	fprintf( fArchLog,"Fin a Cancelacion de Creditos. <== %d ==>\n\n",ihRetorno);
	return ihRetorno;

}/* Fin ifnLlamaCancelacion() */

/*****************************************************************************/
/*****************************************************************************/
int ifnDBInsCuota0( long lCodCliente, DATCON stConF, int iIndAbono, double dImporteAbono, char *szFecVenta, 
                    char *szFecPrimeraCuota, long lNroProceso, char *szFecValor, long lNumAbonado,
                    char *pszPrefPlaza, char *pszCodOperadoraScl, char *pszCodPlaza )
/**
Descripcion: Funcion que recupera los datos para crear un registro en co_cartera perteneciente a
			 la cuota 0.
Salida     : 0       si todo va bien
			 <> 0    si no termina bien
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente;
	int  lhNumCuota;
	long lhNumFolio;
	char szhNumFolioCtc[12];
	long lhNroProceso;
	char szFechaCuotaCero[9];    
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion ifnDBInsCuota0().\n" );
	memset( szhNumFolioCtc, '\0', sizeof( szhNumFolioCtc ) );
	lhNroProceso = lNroProceso;
	
	if( iIndAbono == 1 )
	{
		stConF.iIndFacturado = 1;
		strcpy ( stConF.szFecVencimie, szFecVenta ); 
	}
	else if( iIndAbono == 2 )
	{
		stConF.iIndFacturado = 0;
		strcpy ( stConF.szFecVencimie, szFecPrimeraCuota ); 
	}
	
	stConF.dImporteDebe = dImporteAbono;
	stConF.dImporteHaber = 0;       
   stConF.iCodConcepto = 3;
   stConF.iColumna = 0;
   stConF.iIndContado = 1;
	strcpy( stConF.szFecEfectividad, szFecValor );
	strcpy( stConF.szFecCaducida, szFecValor );
	strcpy( stConF.szFecAntiguedad, szFecValor );
	strcpy( stConF.szFecPago, "" );
	stConF.iDiasVencimiento = 0;
	stConF.iSecCuota = 0;
   stConF.lNumAbonado = lNumAbonado;              

	/* EXEC SQL 
	SELECT NUM_CUOTAS,
		    NUM_FOLIO,
		    NUM_CTC
	INTO   :lhNumCuota,   
	   	 :lhNumFolio,   
		    :szhNumFolioCtc
   FROM   FA_FACTDOCU_NOCICLO          
   WHERE  NUM_PROCESO = :lhNroProceso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NUM_CUOTAS ,NUM_FOLIO ,NUM_CTC into :b0,:b1,:b2  from\
 FA_FACTDOCU_NOCICLO where NUM_PROCESO=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )258;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCuota;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhNumFolioCtc;
 sqlstm.sqhstl[2] = (unsigned long )12;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhNroProceso;
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

  
	
	if( sqlca.sqlcode ) 
	{
		fprintf( fArchLog, "Error al obtener datos desde FA_FACTDOCU_NOCICLO para Cuota 0 %s.\n", szfnORAerror() );
		return ERR_SELECT;
	}

	stConF.lNumCuota = lhNumCuota;
	stConF.lNumFolio = lhNumFolio;
	strcpy( stConF.szFolioCTC, szhNumFolioCtc );   
	strcpy( stConF.szPrefPlaza, pszPrefPlaza );        
	strcpy( stConF.szCodOperadoraScl, pszCodOperadoraScl );        
	strcpy( stConF.szCodPlaza, pszCodPlaza );        

	/*-- Inserta la cuota N° 0 en la co_cartera --*/
	if( !bfnDBIntCartera( &stConF, lCodCliente ) )
	{
		fprintf( fArchLog, "Error al INSERTAR Cuota 0 %s.\n", szfnORAerror() );
		return ERR_INSCART;
	}
	return 0;
}

/*****************************************************************************/
/*****************************************************************************/
int ifnDBCanVentaMenor( long lCodCliente, DATCON *stCon, char *szFecValor, double dImp )
/**
Descripcion: Funcion que cancela la venta cuando el importe es igual
			 Importe en carteventa menor que importe en cartera 
Salida     : OK si todo va bien
			 ERR_xxx si falla algo
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long    lhCodCliente   ;
	int     ihCodTipDocum  ;
	long    lhCodAgente    ;
	char    *szhLetra      ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int     ihCodCentremi  ;
	long    lhNumSecuenci  ;
	long    lhNumTransa    ;
	long    lhNumVenta     ;
	double  dhImporteDebe  ;
	double  dhImporteHaber ;
	int	  ihCodConcepto  ;
	int	  ihCodProducto  ;
	int	  ihColumna      ;
	long	  lhNumAbonado   ;
	long	  lhNumFolio     ;
	long	  lhNumCuota     ;
	int	  ihSecCuota     ;
	short	  shIndNumAbonado   ;
	short   shIndNumFolio     ;
	short	  shIndNumCuota     ;
	short	  shIndSecCuota     ;
	short	  shIndNumTransa    ;
	short	  shIndNumVenta     ;
	char    szhPrefPlaza[26]    ;	/* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

	char    szhCodOperadoraScl[6];	/* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
	/* jlr_11.01.03 */
	char    szhCodPlaza[6]      ;	/* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
			/* jlr_11.01.03 */
/* EXEC SQL END DECLARE SECTION; */ 


	BOOL	bResul;
	int		iResul;
	int		iError = 0;	
	double	dResta = 0.0;
	double	dAux = 0.0;
	int		iCont = 0;
	DATPAG	stDatPag;
	int		iVeces = 0;

	fprintf( fArchLog, "En funcion ifnDBCanVentaMenor().\n" );
	lhCodCliente  = lCodCliente;
	ihCodTipDocum = stCon->iCodTipDocum;
	lhCodAgente   = stCon->lCodAgente;
	szhLetra      = stCon->szLetra;
	ihCodCentremi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	lhNumTransa   = stCon->lNumTransa;
	lhNumVenta    = stCon->lNumVenta;
	/* ihCodProducto = stCon->iCodProducto; */

	fprintf( fArchLog,	"Datos de entrada ifnDBCanVentaMenor.\n"
						"\tlhCodCliente   = [%d],\n"
						"\tihCodTipDocum  = [%d],\n"
						"\tlhCodAgente    = [%d],\n"
						"\tszhLetra       = [%s],\n"
						"\tihCodCentremi  = [%d],\n"
						"\tlhNumSecuenci  = [%d],\n"
						"\tlhNumTransa    = [%d],\n"
						"\tlhNumVenta     = [%d],\n"
						"\tdImp           = [%.2f]\n\n.",
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						lhNumTransa,
						lhNumVenta,
						dImp );

	/* Recuperar el importe */
	/* EXEC SQL DECLARE C_VENTAMENOR CURSOR FOR
   	SELECT nvl(COD_CONCEPTO,0),
           nvl(COLUMNA,0),
           nvl(IMPORTE_DEBE,0),
           nvl(IMPORTE_HABER,0),
           nvl(NUM_ABONADO,0),
           nvl(NUM_FOLIO,0),
           nvl(NUM_CUOTA,0),
           nvl(SEC_CUOTA,0),
/o           nvl(NUM_TRANSACCION,0),o/
           NUM_TRANSACCION,                        /oXC-200411020352 03-11-2004 RyC PRM. Mejorao/
           nvl(NUM_VENTA,0),
           nvl(COD_PRODUCTO,0),
           nvl(PREF_PLAZA,'000'),                  /o jlr_11.01.03 *** CH-1912 01-06-2004o/
           nvl(COD_OPERADORA_SCL,'TMG'),           /o jlr_11.01.03 *** CH-1912 01-06-2004o/
           nvl(COD_PLAZA,'00001')                  /o jlr_11.01.03 *** CH-1912 01-06-2004o/
	  FROM CO_CARTERA
	 WHERE COD_CLIENTE = :lhCodCliente
	   AND NUM_SECUENCI = :lhNumSecuenci
	   AND COD_TIPDOCUM = :ihCodTipDocum
	   AND COD_VENDEDOR_AGENTE = :lhCodAgente
	   AND LETRA = :szhLetra
	   AND COD_CENTREMI = :ihCodCentremi
	   AND NUM_TRANSACCION = :lhNumTransa
	ORDER BY SEC_CUOTA						/o-- MGG-04.04.01 --o/
	FOR UPDATE; */ 


	/* EXEC SQL OPEN C_VENTAMENOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0009;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )289;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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



	if( sqlca.sqlcode )
	{
		fprintf( fArchLog, "Error OPEN C_VENTAMENOR => [%s].\n", szfnORAerror() );
		return ERR_OPENCURSOR;
	}

	/* Bucle de cancelacion del importe. */
	while (TRUE)
	{
		if( dImp <= 0.0 )
			break;

		/* EXEC SQL FETCH C_VENTAMENOR
		INTO
			:ihCodConcepto  ,
			:ihColumna      ,
			:dhImporteDebe  ,
			:dhImporteHaber ,
			:lhNumAbonado:shIndNumAbonado,
			:lhNumFolio:shIndNumFolio,
			:lhNumCuota:shIndNumCuota,
			:ihSecCuota:shIndSecCuota,
			:lhNumTransa:shIndNumTransa,
			:lhNumVenta:shIndNumVenta,
       	:ihCodProducto,
			:szhPrefPlaza,		/o jlr_11.01.03 o/
			:szhCodOperadoraScl,/o jlr_11.01.03 o/
			:szhCodPlaza; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )332;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dhImporteDebe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImporteHaber;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)&shIndNumAbonado;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&shIndNumFolio;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&shIndNumCuota;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&shIndSecCuota;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)&shIndNumTransa;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumVenta;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&shIndNumVenta;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[11] = (unsigned long )26;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[12] = (unsigned long )6;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[13] = (unsigned long )6;
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

		/* jlr_11.01.03 */

		if (sqlca.sqlcode < 0)
		{
			fprintf( fArchLog, "Error FETCH C_VENTAMENOR => [%s].\n", szfnORAerror() );
			iError = ERR_FETCH;
			break;
		}

		if (sqlca.sqlcode == NOT_FOUND)
			break;
		
		fprintf( fArchLog,	"Datos Fetch C_VENTAMENOR.\n"
							"\tihCodConcepto  = [%d],\n"
							"\tihColumna      = [%d]\n"      
							"\tdhImporteDebe  = [%0.f],\n"
							"\tdhImporteHaber = [%0.f]\n\n",
							ihCodConcepto  ,
							ihColumna      ,
							dhImporteDebe  ,
							dhImporteHaber );
                             
		iCont ++;            

		stCon->iCodConcepto = ihCodConcepto; 
		stCon->iColumna     = ihColumna    ;
   		stCon->iCodProducto = ihCodProducto;

		if (shIndNumAbonado == ORA_NULL)
			stCon->lNumAbonado  = ORA_NULL;
		else
			stCon->lNumAbonado  = lhNumAbonado;

		if (shIndNumFolio == ORA_NULL)
			stCon->lNumFolio = ORA_NULL;
		else
			stCon->lNumFolio   = lhNumFolio;

		if (shIndNumCuota == ORA_NULL)
			stCon->lNumCuota = ORA_NULL;
		else
			stCon->lNumCuota   = lhNumCuota;

		if (shIndSecCuota == ORA_NULL)
			stCon->iSecCuota = ORA_NULL;
		else
			stCon->iSecCuota   = ihSecCuota;

		if (shIndNumTransa == ORA_NULL)
			stCon->lNumTransa = ORA_NULL;
		else
			stCon->lNumTransa  = lhNumTransa;

		if (shIndNumVenta == ORA_NULL)
			stCon->lNumVenta = ORA_NULL;
		else
			stCon->lNumVenta  = lhNumVenta;

		strcpy(stCon->szPrefPlaza,szhPrefPlaza);			/* jlr_11.01.03 */
		strcpy(stCon->szCodOperadoraScl,szhCodOperadoraScl);/* jlr_11.01.03 */
		strcpy(stCon->szCodPlaza,szhCodPlaza);				/* jlr_11.01.03 */

		/* manejo de decimales segun la operadora local */
		dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
		dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

		dResta = dhImporteDebe - dhImporteHaber;
		dResta = fnCnvDouble( dResta, 0 );
		/* dResta = (dResta * INVMIN)/INVMIN; MGG */

		if (dResta > dImp) /* El importe nunca va a ser igual */
		{
			/* El concepto es mayor que el importe del pago */
			stCon->dImporteDebe = dhImporteDebe ;
			stCon->dImporteHaber = dhImporteHaber + dImp;
			/* stCon->dImporteHaber = (stCon->dImporteHaber * INVMIN)/INVMIN; MGG */

			/* Modifico en cartera el importe haber */
			bResul = bfnDBUpdCartera(stCon,lCodCliente);
			if( !bResul )
			{
				iError = ERR_UPDATECARTE;
				break;
			}

			/* Inserto la relacion del pago con pagosconc */

			dAux = stCon->dImporteHaber;
			stCon->dImporteHaber = dImp;

			iResul = ifnDBDelPagCon( &stDatPag.stDatDocPago, stCon, iCont, lhCodCliente, lhNumTransa, iVeces, 0 );
			
			if( iResul != OK )
			{
				iError = iResul;
				break;
			}

			iVeces ++;
			stCon->dImporteHaber = dAux;
			dImp = dImp - dResta;
			dImp = fnCnvDouble( dImp, 0 );
			/* dImp = (dImp * INVMIN)/INVMIN; MGG */
		}
		else
		{
			/* El concepto es menor que el importe del pago */
			stCon->dImporteDebe = dhImporteDebe ;
			stCon->dImporteHaber = dhImporteDebe;

			/* Modifico en cartera el importe haber */
			bResul = bfnDBUpdCartera(stCon,lCodCliente);
			if (!bResul)
			{
				iError = ERR_UPDATECARTE;
				break;
			}

			/* Inserto la relacion del pago con pagosconc */
			dAux = stCon->dImporteHaber;
			stCon->dImporteHaber = dResta; 
			/* stCon->dImporteHaber = (stCon->dImporteHaber * INVMIN) / INVMIN; MGG */
			iResul = ifnDBDelPagCon( &stDatPag.stDatDocPago, stCon, iCont, lhCodCliente, lhNumTransa, iVeces, 0 );

			if (iResul != OK)
			{
				iError = iResul;
				break;
			}

			iVeces ++;

			stCon->dImporteHaber = dAux;

			/* Borro los datos de cartera y los llevo a cancelados */
			bResul = bfnDBLlevarACanCtosFA(stCon,lCodCliente,szFecValor);
			if (!bResul)
			{
				iError = ERR_MOVCON;
				break;
			}

			dImp = dImp - dResta;
			dImp = fnCnvDouble( dImp, 0 );
			/* dImp = (dImp * INVMIN)/INVMIN; mgg */
		}
	}

	/* EXEC SQL CLOSE C_VENTAMENOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )403;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode != 0)
	{
		fprintf( fArchLog, "Error CLOSE C_VENTAMENOR => [%s].\n", szfnORAerror() );
		iError = ERR_CLOSECURSOR;
	}

	if( iError != OK )	/* ocurrio un error, no se procesa mas */
		return iError;
		
	return OK;

}/* Fin ifnDBCanVentaMenor() */
/*****************************************************************************/
int ifnDBCanVentaMayor( long lCodCliente, DATCON *stCon, char *szFecValor, double dImp, int iCodCredito )
/**
Descripcion: Funcion que cancela la venta cuando el importe en Carteventa mayor que importe en cartera 
Salida     :	OK si todo va bien
		ERR_xxx si falla algo
**/
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long    lhCodCliente   ;
		int     ihCodTipDocum  ;
		long    lhCodAgente    ;
		char    *szhLetra      ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int     ihCodCentremi  ;
		long    lhNumSecuenci  ;
		long    lhNumTransa    ;
		long    lhNumVenta     ;
		double  dhImporteDebe  ;
		double  dhImporteHaber ;
		int  	ihCodConcepto  ;
		int  	ihCodProducto  ;
		int  	ihColumna      ;
		long	lhNumAbonado   ;
		long	lhNumFolio     ;
		long	lhNumCuota     ;
		int  	ihSecCuota     ;
		short	shIndNumAbonado   ;
		short   shIndNumFolio     ;
		short	shIndNumCuota     ;
		short	shIndSecCuota     ;
		short	shIndNumTransa    ;
		short	shIndNumVenta     ;
		char    szhPrefPlaza[26]  ;	/* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

		char    szhCodOperadoraScl[6];	/* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
	/* jlr_11.01.03 */
		char    szhCodPlaza[6]      ;	/* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
			/* jlr_11.01.03 */
	/* EXEC SQL END DECLARE SECTION; */ 


	BOOL	bResul;
	int		iResul;
	int		iError = 0;
	int		iCont = 0;
	DATPAG	stDatPag;
	double	dAux;
	int		iVeces = 0;

	fprintf( fArchLog, "En funcion ifnDBCanVentaMayor().\n" );
	lhCodCliente  = lCodCliente;
	ihCodTipDocum = stCon->iCodTipDocum;
	lhCodAgente   = stCon->lCodAgente;
	szhLetra      = stCon->szLetra;
	ihCodCentremi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	lhNumTransa   = stCon->lNumTransa;
	lhNumVenta    = stCon->lNumVenta;

	fprintf( fArchLog,	"Datos de Entrada ifnDBCanVentaMayor.\n"
						"\tlhCodCliente    = [%d]\n"
						"\tihCodTipDocum   = [%d]\n"
						"\tlhCodAgente     = [%d]\n"
						"\tszhLetra        = [%s],\n"
						"\tihCodCentremi   = [%d]\n"
						"\tlhNumSecuenci   = [%d]\n"
						"\tlhNumTransa     = [%d]\n"
						"\tlhNumVenta      = [%d]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						lhNumTransa,
						lhNumVenta );

	
	/* QUITADO POR EXISTIR CONTADO CON DOS PRODUCTOS 03-05-99 */
	/* ihCodProducto = stCon->iCodProducto; */

	/* Recuperar el importe */
	/* EXEC SQL DECLARE C_VENTAMAYOR CURSOR FOR
    SELECT  nvl(COD_CONCEPTO,0),
            nvl(COLUMNA,0),
            nvl(IMPORTE_DEBE,0),
            nvl(IMPORTE_HABER,0),
            nvl(NUM_ABONADO,0),
            nvl(NUM_FOLIO,0),
            nvl(NUM_CUOTA,0),
            nvl(SEC_CUOTA,0),
/o            nvl(NUM_TRANSACCION,0),o/
            NUM_TRANSACCION,                       /oXC-200411020352 03-11-2004 RyC PRM. Mejorao/
            nvl(NUM_VENTA,0),
            nvl(COD_PRODUCTO,0),
            NVL(PREF_PLAZA,'000'),                  /o jlr_11.01.03 *** CH-1912 01-06-2004o/
            NVL(COD_OPERADORA_SCL,'TMG'),           /o jlr_11.01.03 *** CH-1912 01-06-2004o/
            NVL(COD_PLAZA,'00001')                  /o jlr_11.01.03 *** CH-1912 01-06-2004o/
	FROM	   CO_CARTERA
	WHERE	   COD_CLIENTE  	= :lhCodCliente
	AND		NUM_SECUENCI    = :lhNumSecuenci
	AND		COD_TIPDOCUM    = :ihCodTipDocum
	AND		COD_VENDEDOR_AGENTE = :lhCodAgente
	AND		LETRA          	= :szhLetra
	AND		COD_CENTREMI   	= :ihCodCentremi
	AND		NUM_TRANSACCION	= :lhNumTransa
	FOR UPDATE; */ 


	/* EXEC SQL OPEN C_VENTAMAYOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0010;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )418;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentremi;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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



	if (sqlca.sqlcode)
	{
		fprintf( fArchLog, "Error OPEN C_VENTAMAYOR => [%s].\n", szfnORAerror() );
		return ERR_OPENCURSOR;
	}

	/* Bucle de cancelacion del importe. */
	while (TRUE)
	{
		/* EXEC SQL FETCH C_VENTAMAYOR
		INTO
			:ihCodConcepto  ,
			:ihColumna      ,
			:dhImporteDebe  ,
			:dhImporteHaber ,
			:lhNumAbonado:shIndNumAbonado,
			:lhNumFolio:shIndNumFolio,
			:lhNumCuota:shIndNumCuota,
			:ihSecCuota:shIndSecCuota,
			:lhNumTransa:shIndNumTransa,
			:lhNumVenta:shIndNumVenta,
       	:ihCodProducto,
			:szhPrefPlaza,		/o jlr_11.01.03 o/
			:szhCodOperadoraScl,/o jlr_11.01.03 o/
			:szhCodPlaza; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )461;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dhImporteDebe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImporteHaber;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)&shIndNumAbonado;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&shIndNumFolio;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&shIndNumCuota;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&shIndSecCuota;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)&shIndNumTransa;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumVenta;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&shIndNumVenta;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[11] = (unsigned long )26;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[12] = (unsigned long )6;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[13] = (unsigned long )6;
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

		/* jlr_11.01.03 */

		if (sqlca.sqlcode < 0)
		{
			fprintf( fArchLog, "Error FETCH C_VENTAMAYOR => [%s].\n", szfnORAerror() );
			iError = ERR_FETCH;
			break;
		}

		if (sqlca.sqlcode == NOT_FOUND)
			break;
		
		iCont ++;

		stCon->iCodConcepto = ihCodConcepto; 
		stCon->iColumna     = ihColumna    ;
   		stCon->iCodProducto = ihCodProducto;

		if (shIndNumAbonado == ORA_NULL)
			stCon->lNumAbonado  = ORA_NULL;
		else
			stCon->lNumAbonado  = lhNumAbonado;

		if (shIndNumFolio == ORA_NULL)
			stCon->lNumFolio = ORA_NULL;
		else
			stCon->lNumFolio   = lhNumFolio;

		if (shIndNumCuota == ORA_NULL)
			stCon->lNumCuota = ORA_NULL;
		else
			stCon->lNumCuota   = lhNumCuota;

		if (shIndSecCuota == ORA_NULL)
			stCon->iSecCuota = ORA_NULL;
		else
			stCon->iSecCuota   = ihSecCuota;

		if (shIndNumTransa == ORA_NULL)
			stCon->lNumTransa = ORA_NULL;
		else
			stCon->lNumTransa  = lhNumTransa;

		if (shIndNumVenta == ORA_NULL)
			stCon->lNumVenta = ORA_NULL;
		else
			stCon->lNumVenta  = lhNumVenta;

		strcpy(stCon->szPrefPlaza,szhPrefPlaza);			/* jlr_11.01.03 */
		strcpy(stCon->szCodOperadoraScl,szhCodOperadoraScl);/* jlr_11.01.03 */
		strcpy(stCon->szCodPlaza,szhCodPlaza);				/* jlr_11.01.03 */


		stCon->dImporteDebe = dhImporteDebe ;
		stCon->dImporteHaber = dhImporteDebe;

		/* Modifico en cartera el importe haber */
		bResul = bfnDBUpdCartera( stCon,lCodCliente );
		if (!bResul)
		{
			iError = ERR_UPDATECARTE;
			break;
		}

		dAux = stCon->dImporteHaber;
		/* manejo de decimales segun la operadora local */
		dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
		dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

		stCon->dImporteHaber = dhImporteDebe - dhImporteHaber;
		/* stCon->dImporteHaber = (stCon->dImporteHaber * INVMIN)/INVMIN; */

		/* Inserto la relacion del pago con pagosconc */
		iResul = ifnDBDelPagCon( &stDatPag.stDatDocPago, stCon, iCont, lhCodCliente, lhNumTransa, iVeces, 0 );

		if (iResul != OK)
		{
			iError = iResul;
			break;
		}
		
		stCon->dImporteHaber = dAux;
   		iVeces ++;

		/* Borro los datos de cartera y los llevo a cancelados */
		bResul = bfnDBLlevarACanCtosFA(stCon,lCodCliente,szFecValor);
		if (!bResul)
		{
			iError = ERR_MOVCON;
			break;
		}
	}

	/* EXEC SQL CLOSE C_VENTAMAYOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )532;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode != 0)
	{
		fprintf( fArchLog, "Error CLOSE C_VENTAMAYOR => [%s].\n", szfnORAerror() );
		iError = ERR_CLOSECURSOR;
	}

	if( iError != OK )	/* ocurrio un error, no se procesa mas */
		return iError;
		
	/* Se ha de insertar un pago por la diferencia */
	/* Llevamos datos de concepto de credito */
	stCon->iCodTipDocum          = stDatPag.stDatDocPago.iCodTipDocum;
	stCon->lCodAgente            = stDatPag.stDatDocPago.lCodAgente;
	strcpy(stCon->szLetra        , stDatPag.stDatDocPago.szLetra);
	stCon->iCodCentremi          = stDatPag.stDatDocPago.iCodCentrEmi;
	stCon->lNumSecuenci          = stDatPag.stDatDocPago.lNumSecuenci;
	stCon->iCodConcepto          = iCodCredito;
	stCon->dImporteDebe          = 0.0;
	stCon->dImporteHaber         = dImp;
	stCon->iColumna              = 1; /* insert co_secartera */
	stCon->iIndFacturado         = 1;
	stCon->iIndContado           = 0;
	strcpy(stCon->szFecEfectividad, szFecValor);
	strcpy(stCon->szFecVencimie   , szFecValor);
	strcpy(stCon->szFecCaducida   , szFecValor);
	strcpy(stCon->szFecAntiguedad , szFecValor);
	strcpy(stCon->szFecPago       , szFecValor);
	stCon->iDiasVencimiento      = 0 ;
	stCon->lNumAbonado           = ABOCLI;/* credito a nivel de cliente */
	stCon->iCodProducto          = PRODGEN; /* producto general */
	stCon->lNumFolio             = stCon->lNumSecuenci;
	stCon->lNumCuota             = -1;
	stCon->iSecCuota             = -1;
	stCon->lNumTransa            = -1;
	stCon->lNumVenta             = -1;

	/* Introducimos un credito en cartera */
	if( !bfnDBIntCarteraFA( stCon, lCodCliente ) )
   		return ERR_GENCRE;

	/* Introducimos la relacion del pago con el credito */
	if (!bfnDBInsPagCon(&stDatPag.stDatDocPago,stCon))
	   return ERR_INSPAGCON;

	return OK;

}/* Fin ifnDBCanVentaMayor() */
/*****************************************************************************/
int ifnDBCanVentaIgual( long lCodCliente, DATCON *stCon, char *szFecValor, long lNumSecuenciaCIC )
/**
Descripcion: Funcion que cancela la venta cuando el importe es igual
Salida     : OK si todo va bien
				 ERR_xxx si falla algo
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente   ;
	int	ihCodTipDocum  ;
	long	lhCodAgente    ;
	char	*szhLetra      ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int	ihCodCentremi  ;
	long	lhNumSecuenci  ;
	long	lhNumTransa    ;
	long	lhNumVenta     ;
	double	dhImporteDebe  ;
	double	dhImporteHaber ;
	int	ihCodConcepto  ;
	int	ihCodProducto  ;
	int	ihColumna      ;
	long	lhNumAbonado   ;
	long	lhNumFolio     ;
	long	lhNumCuota     ;
	int	ihSecCuota     ;
	short	shIndNumAbonado   ;
	short	shIndNumFolio     ;
	short	shIndNumCuota     ;
	short	shIndSecCuota     ;
	short	shIndNumTransa    ;
	short	shIndNumVenta     ;
	char    szhPrefPlaza[26]      ; /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

	char    szhCodOperadoraScl[6]; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
 /* jlr_11.01.03 */
	char    szhCodPlaza[6]       ; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
        /* jlr_11.01.03 */
	char	szhSql[1001];	
/* EXEC SQL END DECLARE SECTION; */ 

BOOL	bResul;
int		iResul = 0; 
int		iError = 0;	
int		iCont = 0;
DATPAG	stDatPag;
double	dAux = 0.0;
int		iVeces = 0;

	fprintf( fArchLog, "En funcion ifnDBCanVentaIgual().\n" );
	memset( szhSql, '\0', sizeof( szhSql ) ) ;

	lhCodCliente  = lCodCliente;
	ihCodTipDocum = stCon->iCodTipDocum;
	lhCodAgente   = stCon->lCodAgente;
	szhLetra      = stCon->szLetra;
	ihCodCentremi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	lhNumTransa   = stCon->lNumTransa;
	lhNumVenta    = stCon->lNumVenta;
	/* ihCodProducto = stCon->iCodProducto; */

	fprintf( fArchLog,	"Datos de Entrada ifnDBCanVentaIgual.\n"
						"\tlhCodCliente    = [%d]\n"
						"\tihCodTipDocum   = [%d]\n"
						"\tlhCodAgente     = [%d]\n"
						"\tszhLetra        = [%s],\n"
						"\tihCodCentremi   = [%d]\n"
						"\tlhNumSecuenci   = [%d]\n"
						"\tlhNumTransa     = [%ld]\n"
						"\tlhNumVenta      = [%d]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						lhNumTransa,
						lhNumVenta );

	/* Recuperar el importe */
	sprintf( szhSql, " SELECT   nvl(COD_CONCEPTO,0), "
					 "		    nvl(COLUMNA,0), "
					 "		    nvl(IMPORTE_DEBE,0), "
					 "		    nvl(IMPORTE_HABER,0), "
					 "		    nvl(NUM_ABONADO,0), "
					 "		    nvl(NUM_FOLIO,0), "
					 "		    nvl(NUM_CUOTA,0), "
					 "		    nvl(SEC_CUOTA,0), "
					 "		    NUM_TRANSACCION, "
					 "		    nvl(NUM_VENTA,0), "
					 "		    nvl(COD_PRODUCTO,0), "
                "        nvl(PREF_PLAZA,'000'), "
                "        nvl(COD_OPERADORA_SCL,'TMG'), "
                "        nvl(COD_PLAZA, '00001') "
					 " FROM	CO_CARTERA "
					 " WHERE	COD_CLIENTE		= %d "
					 " AND	COD_TIPDOCUM    = %d "
					 " AND	COD_CENTREMI    = %d "
					 " AND	NUM_SECUENCI    = %d "
					 " AND	COD_VENDEDOR_AGENTE = %d "
					 " AND	LETRA           = '%s' "
					 " AND	NUM_TRANSACCION ",
					 lhCodCliente, ihCodTipDocum, ihCodCentremi, lhNumSecuenci, lhCodAgente, szhLetra );
					 
	if( lhNumTransa > 0 )
		sprintf( szhSql, "%s= %d", szhSql, lhNumTransa );
	else
		sprintf( szhSql, "%sIS NULL", szhSql );
		
	sprintf( szhSql, "%s FOR UPDATE", szhSql );
	
	fprintf( fArchLog,"szhSql [%s]\n", szhSql );
		
	/* EXEC SQL PREPARE sqlDinamico FROM :szhSql; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )547;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
 sqlstm.sqhstl[0] = (unsigned long )1001;
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


	if( sqlca.sqlcode )
	{
		fprintf( fArchLog, "Error PREPARE C_VENTAIGUAL => [%s].\n", szfnORAerror() );
		return ERR_OPENCURSOR;
	}
			
	/* EXEC SQL DECLARE C_VENTAIGUAL CURSOR FOR sqlDinamico; */ 

	if( sqlca.sqlcode )
	{
		fprintf( fArchLog, "Error DECLARE C_VENTAIGUAL => [%s].\n", szfnORAerror() );
		return ERR_OPENCURSOR;
	}
	
	/* EXEC SQL OPEN C_VENTAIGUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )566;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode )
	{
		fprintf( fArchLog, "Error OPEN C_VENTAIGUAL => [%s].\n", szfnORAerror() );
		return ERR_OPENCURSOR;
	}

	/* Bucle de cancelacion del importe. */
	while( TRUE )
	{
		/* EXEC SQL FETCH C_VENTAIGUAL
		INTO	:ihCodConcepto  ,
				:ihColumna      ,
				:dhImporteDebe  ,
				:dhImporteHaber ,
				:lhNumAbonado:shIndNumAbonado,
				:lhNumFolio:shIndNumFolio,
				:lhNumCuota:shIndNumCuota,
				:ihSecCuota:shIndSecCuota,
				:lhNumTransa:shIndNumTransa,
				:lhNumVenta:shIndNumVenta,
				:ihCodProducto,
		      :szhPrefPlaza,       /o jlr_11.01.03 o/
				:szhCodOperadoraScl, /o jlr_11.01.03 o/
				:szhCodPlaza ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )581;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihColumna;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dhImporteDebe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImporteHaber;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)&shIndNumAbonado;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)&shIndNumFolio;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumCuota;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)&shIndNumCuota;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihSecCuota;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)&shIndSecCuota;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)&shIndNumTransa;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumVenta;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)&shIndNumVenta;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&ihCodProducto;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[11] = (unsigned long )26;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[12] = (unsigned long )6;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[13] = (unsigned long )6;
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

       /* jlr_11.01.03 */

		if( sqlca.sqlcode < 0 )
		{
			fprintf( fArchLog, "Error FETCH C_VENTAIGUAL => [%s].\n", szfnORAerror() );
			iError = ERR_FETCH;
			break;
		}

		if( sqlca.sqlcode == NOT_FOUND )
			break;

		iCont ++;

		stCon->iCodConcepto = ihCodConcepto; 
		stCon->iColumna     = ihColumna    ;
      	stCon->iCodProducto = ihCodProducto;

		if (shIndNumAbonado == ORA_NULL)
			stCon->lNumAbonado  = ORA_NULL;
		else
			stCon->lNumAbonado  = lhNumAbonado;

		if (shIndNumFolio == ORA_NULL)
			stCon->lNumFolio = ORA_NULL;
		else
			stCon->lNumFolio   = lhNumFolio;

		if (shIndNumCuota == ORA_NULL)
			stCon->lNumCuota = ORA_NULL;
		else
			stCon->lNumCuota   = lhNumCuota;

		if (shIndSecCuota == ORA_NULL)
			stCon->iSecCuota = ORA_NULL;
		else
			stCon->iSecCuota   = ihSecCuota;

		if (shIndNumTransa == ORA_NULL)
			stCon->lNumTransa = ORA_NULL;
		else
			stCon->lNumTransa  = lhNumTransa;

		if (shIndNumVenta == ORA_NULL)
			stCon->lNumVenta = ORA_NULL;
		else
			stCon->lNumVenta  = lhNumVenta;

		stCon->dImporteDebe = dhImporteDebe ;
		stCon->dImporteHaber = dhImporteDebe;

		strcpy(stCon->szPrefPlaza,szhPrefPlaza);			/* jlr_11.01.03 */
		strcpy(stCon->szCodOperadoraScl,szhCodOperadoraScl);/* jlr_11.01.03 */
		strcpy(stCon->szCodPlaza,szhCodPlaza);				/* jlr_11.01.03 */

		/* Modifico en cartera el importe haber */
		bResul = bfnDBUpdCartera( stCon, lCodCliente );
		if( !bResul )
		{
			iError = ERR_UPDATECARTE;
			break;
		}

		dAux = stCon->dImporteHaber;
		/* manejo de decimales segun la operadora local */
		dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
		dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );
		
		stCon->dImporteHaber = dhImporteDebe - dhImporteHaber;
		/* stCon->dImporteHaber = (stCon->dImporteHaber * INVMIN)/INVMIN; MGG */
		
		/* Inserto la relacion del pago con pagosconc */
		iResul = ifnDBDelPagCon( &stDatPag.stDatDocPago, stCon, iCont, lhCodCliente, lhNumTransa, iVeces, lNumSecuenciaCIC );

		if( iResul != OK )
		{
			iError = iResul;
			break;
		}
		
		iVeces ++;
		stCon->dImporteHaber = dAux;

		/* Borro los datos de cartera y los llevo a cancelados */
		bResul = bfnDBLlevarACanCtosFA( stCon, lCodCliente, szFecValor );
		if( !bResul )
		{
			iError = ERR_MOVCON;
			break;
		}
	}

	/* EXEC SQL CLOSE C_VENTAIGUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )652;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode != 0 )
	{
		fprintf( fArchLog, "Error CLOSE C_VENTAIGUAL => [%s].\n", szfnORAerror() );
		iError = ERR_CLOSECURSOR;
	}

	if( iError != OK )
		return iError;
		
	return OK;

}/* Fin ifnDBCanVentaIgual() */

/*****************************************************************************/
int ifnDBDelPagCon( DATDOC *stDoc, DATCON *stCon, int iCont, long lCodCliente,
					long lNumTransa, int iVeces, long lNumSecuenciaCIC )
/**
Descripcion	: 	Funcion que se encarga de borrar el pagconc de la primera venta
				e insertar el relacionado correcto
Salida		:	TRUE si se efectua correctamente
				FALSE si se produce algun error
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int	ihCount;
	long	lhCodCliente;
	long	lhNumTransa;
	int	ihCodTipDocum;
	int	ihCodCentremi;
	long	lhNumSecuenci;
	long	lhCodAgente;
	char	szhLetra[2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	long	lhNumSecuenciaCIC;
	int   ihExisteReg;         /*** XC-200411020352 03-11-2004 RyC PRM. Homologación de CH-200410182302 ***/
	int   ihValor_cero = 0;
	int   ihValor_unoNeg=-1;
	int   ihValor_ocho = 8;	
/* EXEC SQL END DECLARE SECTION; */ 

	BOOL bResul;

	fprintf( fArchLog, "En funcion ifnDBDelPagCon().\n" );
	lhCodCliente	= lCodCliente;
	lhNumTransa		= lNumTransa;
	lhNumSecuenciaCIC = lNumSecuenciaCIC;

	fprintf( fArchLog, 	"Entrada ifnDBDelPagCon.\nlhCodCliente => [%d], lhNumTransa => [%ld], iVeces => [%d], iCont => [%d].\n", 
						lhCodCliente, lhNumTransa, iVeces, iCont );

	if( iCont == 1 && lhNumTransa > 0 ) 
	{
		/* EXEC SQL
		SELECT NVL(COUNT(*),:ihValor_cero)
		INTO  :ihCount
		FROM  CO_PAGOSCONC A, CO_PAGOS B
		WHERE B.COD_CLIENTE = :lhCodCliente
		AND   A.COD_TIPDOCUM = B.COD_TIPDOCUM
		AND   A.COD_CENTREMI = B.COD_CENTREMI
		AND   A.NUM_SECUENCI = B.NUM_SECUENCI
		AND   A.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE
		AND   A.LETRA = B.LETRA
		AND   NVL( A.NUM_TRANSACCION, :ihValor_unoNeg ) = :lhNumTransa; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(count(*) ,:b0) into :b1  from CO_PAGOSCONC A ,CO\
_PAGOS B where ((((((B.COD_CLIENTE=:b2 and A.COD_TIPDOCUM=B.COD_TIPDOCUM) and \
A.COD_CENTREMI=B.COD_CENTREMI) and A.NUM_SECUENCI=B.NUM_SECUENCI) and A.COD_VE\
NDEDOR_AGENTE=B.COD_VENDEDOR_AGENTE) and A.LETRA=B.LETRA) and NVL(A.NUM_TRANSA\
CCION,:b3)=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )667;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCount;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_unoNeg;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumTransa;
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
}



		if( sqlca.sqlcode )
		{
			fprintf( fArchLog, "Error SELECT CO_PAGOSCONC A, CO_PAGOS B => [%s].\n", szfnORAerror() );
			return ERR_COUNT;
		}

    	fprintf( fArchLog, "Valor ihCount => [%d].\n", ihCount );

		/* En la primera venta se inserta solo un registro en pagosconc */
		if (ihCount != 1)
			return ERR_COUNT;
        	
		/* EXEC SQL 
		SELECT A.COD_TIPDOCUM,
				 A.COD_CENTREMI,
				 A.NUM_SECUENCI,
				 A.COD_VENDEDOR_AGENTE,
				 A.LETRA
		INTO   :ihCodTipDocum,
				 :ihCodCentremi,
				 :lhNumSecuenci,
				 :lhCodAgente,
				 :szhLetra
		FROM 	 CO_PAGOSCONC A, CO_PAGOS B
		WHERE  B.COD_CLIENTE = :lhCodCliente
		AND 	 A.COD_TIPDOCUM = B.COD_TIPDOCUM
		AND 	 A.COD_CENTREMI = B.COD_CENTREMI
		AND 	 A.NUM_SECUENCI = B.NUM_SECUENCI
		AND 	 A.COD_VENDEDOR_AGENTE = B.COD_VENDEDOR_AGENTE
		AND 	 A.LETRA = B.LETRA
		AND 	 NVL( A.NUM_TRANSACCION, :ihValor_unoNeg ) = :lhNumTransa
		FOR UPDATE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select A.COD_TIPDOCUM ,A.COD_CENTREMI ,A.NUM_SECUENCI ,A.CO\
D_VENDEDOR_AGENTE ,A.LETRA into :b0,:b1,:b2,:b3,:b4  from CO_PAGOSCONC A ,CO_P\
AGOS B where ((((((B.COD_CLIENTE=:b5 and A.COD_TIPDOCUM=B.COD_TIPDOCUM) and A.\
COD_CENTREMI=B.COD_CENTREMI) and A.NUM_SECUENCI=B.NUM_SECUENCI) and A.COD_VEND\
EDOR_AGENTE=B.COD_VENDEDOR_AGENTE) and A.LETRA=B.LETRA) and NVL(A.NUM_TRANSACC\
ION,:b6)=:b7) for update ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )702;
  sqlstm.selerr = (unsigned short)1;
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
  sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_unoNeg;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
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
			fprintf( fArchLog, "Error SELECT CO_PAGOSCONC, CO_PAGOS => %s.\n", szfnORAerror() );
			return ERR_SELECT;
		}
    	
		/* Datos del pago */
		stDoc->iCodTipDocum = ihCodTipDocum;
		stDoc->iCodCentrEmi = ihCodCentremi;
		stDoc->lNumSecuenci = lhNumSecuenci;
		stDoc->lCodAgente   = lhCodAgente;
		strcpy(stDoc->szLetra, szhLetra);
		
	    if( iVeces == 0 )
	    {
			/* EXEC SQL
			DELETE CO_PAGOSCONC
			WHERE  COD_TIPDOCUM = :ihCodTipDocum
			AND 	 COD_CENTREMI = :ihCodCentremi
			AND	 NUM_SECUENCI = :lhNumSecuenci
			AND	 COD_VENDEDOR_AGENTE = :lhCodAgente
			AND	 LETRA = :szhLetra 
			AND	 NVL( NUM_TRANSACCION, :ihValor_unoNeg ) = :lhNumTransa; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "delete  from CO_PAGOSCONC  where (((((COD_TIPDOCUM=:b0 and\
 COD_CENTREMI=:b1) and NUM_SECUENCI=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETR\
A=:b4) and NVL(NUM_TRANSACCION,:b5)=:b6)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )749;
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
   sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_unoNeg;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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


	
			if (sqlca.sqlcode)
			{
				fprintf( fArchLog, "Error DELETE CO_PAGOSCONC => %s.\n", szfnORAerror() );
				return ERR_DELPAGCONC;
			}
	    }
	}
	else	
	{
		if( lhNumTransa < 0 )	/* ya que es factura miscelanea, buscamos los datos del pago */
		{
			/* EXEC SQL 
			SELECT COD_TIPDOCUM,
					COD_CENTREMI,
					NUM_SECUENCI,
					COD_VENDEDOR_AGENTE,
					LETRA
			INTO   	:ihCodTipDocum,
					:ihCodCentremi,
					:lhNumSecuenci,
					:lhCodAgente,
					:szhLetra
			FROM 	CO_PAGOS
			WHERE COD_CLIENTE		= :lhCodCliente
			AND 	COD_TIPDOCUM	= :ihValor_ocho
			AND 	NUM_SECUENCI	= :lhNumSecuenciaCIC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_TIPDOCUM ,COD_CENTREMI ,NUM_SECUENCI ,COD_VENDE\
DOR_AGENTE ,LETRA into :b0,:b1,:b2,:b3,:b4  from CO_PAGOS where ((COD_CLIENTE=\
:b5 and COD_TIPDOCUM=:b6) and NUM_SECUENCI=:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )792;
   sqlstm.selerr = (unsigned short)1;
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
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_ocho;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&lhNumSecuenciaCIC;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
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


	
			if( sqlca.sqlcode )
			{
				fprintf( fArchLog, "Error al leer Datos del Pago de F. Miscelanea %s\n", szfnORAerror() );
				return ERR_SELECT;
			}
			/* Datos del pago */
			stDoc->iCodTipDocum = ihCodTipDocum;
			stDoc->iCodCentrEmi = ihCodCentremi;
			stDoc->lNumSecuenci = lhNumSecuenci;
			stDoc->lCodAgente   = lhCodAgente;
			strcpy( stDoc->szLetra, szhLetra );
			

			/*******CAPC MA-200403160356 17-03-2004 ****************/
			if( iVeces == 0 )
			{
				/*** XC-200411020352 03-11-2004 RyC PRM. Homologación de CH-200410182302 ***/
				/* EXEC SQL
				SELECT COUNT(*)
				INTO  :ihExisteReg
				FROM  CO_PAGOSCONC
				WHERE COD_TIPDOCUM = :ihCodTipDocum
				AND   COD_CENTREMI = :ihCodCentremi
				AND   NUM_SECUENCI = :lhNumSecuenci
				AND   COD_VENDEDOR_AGENTE = :lhCodAgente
				AND   LETRA        = :szhLetra 
				AND   NUM_SECUREL  = :lhNumSecuenci; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from CO_PAGOSCONC where (((((C\
OD_TIPDOCUM=:b1 and COD_CENTREMI=:b2) and NUM_SECUENCI=:b3) and COD_VENDEDOR_A\
GENTE=:b4) and LETRA=:b5) and NUM_SECUREL=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )839;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihExisteReg;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumSecuenci;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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

			
			
				if (ihExisteReg > 0)
				{   				
					/* EXEC SQL
					DELETE CO_PAGOSCONC
					WHERE  COD_TIPDOCUM = :ihCodTipDocum
					AND    COD_CENTREMI = :ihCodCentremi
					AND    NUM_SECUENCI = :lhNumSecuenci
					AND    COD_VENDEDOR_AGENTE = :lhCodAgente
					AND    LETRA        = :szhLetra 
					AND    NUM_SECUREL  = :lhNumSecuenci; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "delete  from CO_PAGOSCONC  where (((((COD_TIPDOCUM=:b0 a\
nd COD_CENTREMI=:b1) and NUM_SECUENCI=:b2) and COD_VENDEDOR_AGENTE=:b3) and LE\
TRA=:b4) and NUM_SECUREL=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )882;
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
     sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
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
}

			
	
					if (sqlca.sqlcode)
					{
						fprintf( fArchLog, "Error DELETE CO_PAGOSCONC => %s.\n", szfnORAerror() );
						return ERR_DELPAGCONC;
					}
				        fprintf( fArchLog, "SI existe registro en CO_PAGOSCONC.  \n" );
				}
				else
				{
						fprintf( fArchLog, "NO existe registro en CO_PAGOSCONC.  \n" );
				}
				/******************************************/	
			}
			/*******************************************************/
		}
	}
	
	/* Como la venta es igual el importe en pagconc es igual */
	bResul = bfnDBInsPagCon( stDoc, stCon );
	
	if( bResul == FALSE )
		return ERR_INSPAGCON;

	return OK;
}/* Fin ifnDBDelPagCon() */

/*****************************************************************************/
int ifnDBObtImpFa( long lCodCliente, DATCON *stCon, double *dImporte )
/**
Descripcion: Funcion que obtiene el importe de co_cartera
Salida     : TRUE si todo va bien
             FALSE si hay algun error
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente;
	int    ihCodTipDocum;
	long   lhCodAgente;
	char   *szhLetra; 			/* EXEC SQL VAR szhLetra IS STRING(2); */ 

	int    ihCodCentremi;
	long   lhNumSecuenci;
	long   lhNumTransa;
	double dhImp = 0.0;
	int    ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion ifnDBObtImpFa().\n" );
	lhCodCliente  	= lCodCliente;
	ihCodTipDocum 	= stCon->iCodTipDocum;
	lhCodAgente   	= stCon->lCodAgente;
	szhLetra      	= stCon->szLetra;
	ihCodCentremi 	= stCon->iCodCentremi;
	lhNumSecuenci 	= stCon->lNumSecuenci;
	lhNumTransa 	= stCon->lNumTransa;

	fprintf( fArchLog,	"Datos de Entrada para ifnDBObtImpFa\n"
						"\tCliente     => [%d],\n"
						"\tTipDocum    => [%d],\n"
						"\tAgente      => [%d],\n"
						"\tLetra       => [%s],\n"
						"\tCentremi    => [%d],\n"
						"\tSecuencia   => [%d],\n"
						"\tTransaccion => [%d].\n\n", 	 
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						lhNumTransa );

	/* Recuperar el importe */
	if( lhNumTransa > 0 )
	{
		/* EXEC SQL
 	   SELECT NVL(SUM(NVL(IMPORTE_DEBE, :ihValor_cero) - NVL(IMPORTE_HABER, :ihValor_cero) ), :ihValor_cero)
		INTO   :dhImp
		FROM   CO_CARTERA
		WHERE  COD_CLIENTE	 = :lhCodCliente
		AND    NUM_SECUENCI	 = :lhNumSecuenci
		AND    COD_TIPDOCUM	 = :ihCodTipDocum
		AND    COD_VENDEDOR_AGENTE	= :lhCodAgente
		AND    LETRA		    = :szhLetra
		AND    COD_CENTREMI	 = :ihCodCentremi
		AND    NUM_TRANSACCION= :lhNumTransa; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(sum((NVL(IMPORTE_DEBE,:b0)-NVL(IMPORTE_HABER,:b0\
))),:b0) into :b3  from CO_CARTERA where ((((((COD_CLIENTE=:b4 and NUM_SECUENC\
I=:b5) and COD_TIPDOCUM=:b6) and COD_VENDEDOR_AGENTE=:b7) and LETRA=:b8) and C\
OD_CENTREMI=:b9) and NUM_TRANSACCION=:b10)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )921;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImp;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
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
  sqlstm.sqhstv[7] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihCodCentremi;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
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


	}
	else
	{
		/* EXEC SQL
      SELECT NVL(SUM( NVL(IMPORTE_DEBE, :ihValor_cero) - NVL(IMPORTE_HABER, :ihValor_cero) ), :ihValor_cero)
		INTO  :dhImp
		FROM  CO_CARTERA
		WHERE COD_CLIENTE	   = :lhCodCliente
		AND   NUM_SECUENCI	= :lhNumSecuenci
		AND   COD_TIPDOCUM	= :ihCodTipDocum
		AND   COD_VENDEDOR_AGENTE	= :lhCodAgente
		AND   LETRA		      = :szhLetra
		AND   COD_CENTREMI	= :ihCodCentremi
		AND   NUM_TRANSACCION	IS NULL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(sum((NVL(IMPORTE_DEBE,:b0)-NVL(IMPORTE_HABER,:b0\
))),:b0) into :b3  from CO_CARTERA where ((((((COD_CLIENTE=:b4 and NUM_SECUENC\
I=:b5) and COD_TIPDOCUM=:b6) and COD_VENDEDOR_AGENTE=:b7) and LETRA=:b8) and C\
OD_CENTREMI=:b9) and NUM_TRANSACCION is null )";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )980;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhImp;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
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
  sqlstm.sqhstv[7] = (unsigned char  *)&lhCodAgente;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihCodCentremi;
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


	}
	
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != NOT_FOUND )
	{
		fprintf( fArchLog, "Error al obtener importe de CO_CARTERA => %s.\n", szfnORAerror() );
		return ERR_IMPCARTE;
	}

	if( dhImp == 0 )
	{
		fprintf( fArchLog, "Importe de la Cartera es 0.\n" );
		return ERR_IMPCERO;
	}
	
	/* dhImp = ( dhImp * INVMIN ) / INVMIN; mgg */
	*dImporte = dhImp;

	fprintf( fArchLog, "Retorno ifnDBObtImpFa Importe de Cartera = [%.0f].\n", dhImp );
	return OK;
}/* Fin ifnDBObtImpFa() */

/*****************************************************************************/
int ifnDBObtImpCo(long lCodCliente, DATCON *stCon,double *dImporte,int *iEncon)
/**
Descripcion: Funcion que obtiene el importe de co_carteventa
Salida     : TRUE si todo va bien
             FALSE si hay algun error
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente   ;
	long lhNumTransa    ;
	double  dhImporteDebe;
	int ihIndCancelado;
	int ihIndPasoCob;
	char szhFecEfec[9]; /* EXEC SQL VAR szhFecEfec IS STRING(9); */ 

	char   szhyyyymmdd  [9];
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion ifnDBObtImpCo().\n" );
	strcpy(szhyyyymmdd,"yyyymmdd");
  	lhCodCliente   = lCodCliente;
  	lhNumTransa = stCon->lNumTransa;
	*iEncon = 0;
	*dImporte = 0.0;
  
	fprintf( fArchLog,	"Datos de Entrada para ifnDBObtImpCo\n"
						"lhCodCliente => [%d], lhNumTransa => [%d].\n",
						lhCodCliente, lhNumTransa );
   	
   	/* Recuperar el importe */
	/* EXEC SQL
	SELECT IMP_CONCEPTO,
		   IND_CANCELADO,
		   TO_CHAR( FEC_EFECTIVIDAD, :szhyyyymmdd )
	INTO  :dhImporteDebe,
		   :ihIndCancelado,
		   :szhFecEfec
	FROM  CO_CARTEVENTA
	WHERE NUM_TRANSACCION = :lhNumTransa
	AND   COD_CLIENTE   = :lhCodCliente
	FOR UPDATE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select IMP_CONCEPTO ,IND_CANCELADO ,TO_CHAR(FEC_EFECTIVIDAD,\
:b0) into :b1,:b2,:b3  from CO_CARTEVENTA where (NUM_TRANSACCION=:b4 and COD_C\
LIENTE=:b5) for update ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1035;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihIndCancelado;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecEfec;
 sqlstm.sqhstl[3] = (unsigned long )9;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
		fprintf(fArchLog,"* Error al obtener el importe de CO_CARTEVENTA => [%s].\n", szfnORAerror());
		return ERR_SELECT;
	}

	/* Si no encuentro datos en co_carteventa es porque no ha pagado */
	if (sqlca.sqlcode == NOT_FOUND)
	{
		fprintf( fArchLog,	"No existe registro en la CO_CARTEVENTA.\n" );
		*iEncon = 0;
		return OK;
	} 

	if (ihIndCancelado == 1)
	{
		/* Factura duplicada para la misma venta */
		fprintf( fArchLog, "Factura duplicada para la misma venta.\n" );
		return ERR_FAC2;
	}

	if( dhImporteDebe == 0.0 )
	{
		fprintf( fArchLog, "Factura tiene importe 0.\n" );
		return ERR_IMPORTE;
	}
	
	/* dhImporteDebe = (dhImporteDebe * INVMIN)/INVMIN; mgg */

	*dImporte = dhImporteDebe;
	*iEncon = 1;

	fprintf( fArchLog,	"Datos recuperados en ifnDBObtImpCo.\n"
						"ImpDebe = [%.0f], IndCancelado = [%d], FecEfec = [%s].\n", 
						dhImporteDebe, ihIndCancelado, szhFecEfec );
	return OK;

}/* Fin ifnDBObtImpCo() */
/*****************************************************************************/
BOOL bfnDBObtFecha(char *szFecha)
/**
Descripcion: Obtiene la fecha del sistema.
Entrada    : szFecha, fecha del sistema.
Salida     : szFecha, fecha del sistema.
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhFecha[9]   ; /* EXEC SQL VAR szhFecha IS STRING(9); */ 

/* EXEC SQL END DECLARE SECTION; */ 


   /* EXEC SQL
   SELECT TO_CHAR(SYSDATE,'yyyymmdd')
   INTO :szhFecha
   FROM DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_CHAR(SYSDATE,'yyyymmdd') into :b0  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1074;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
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



   if (sqlca.sqlcode != SQLOK)
   {
      fprintf(fArchLog,"* Error al recuperar fecha del sistema => [%s].\n",szfnORAerror());
      return FALSE;
   }

	strcpy(szFecha,szhFecha);
	return TRUE;

}/* Fin bfnDBObtFecha() */
/***************************************************************************/
BOOL bfnDBIntCancelados (DATCON *stConGen, long lCodCliente,char *szFecHis)
/**
Descripcion: Introduce en cancelados el concepto de la estructura poniendo 
				 fecha historico igual a la fecha valor.
				 En caso de Error devuelve FALSE.
**/
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 


	 long    lhCodCliente        ;
	 int     ihCodTipDocum       ;
    long    lhCodAgente         ; 
	 char    *szhLetra           ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	 int     ihCodCentrEmi       ;
     long    lhNumSecuenci      ;
	 int     ihCodConcepto       ;
     int     ihColumna          ;
	 double  dhImporteDebe       ;
	 double  dhImporteHaber      ;
	 int		ihCodProducto		  ;	
	 int     ihIndContado        ;
	 int     ihIndFacturado      ;
     char    szhFecEfectividad[9]; /* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

     char    szhFecHistorico[9]  ; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

     char    szhFecVencimie[9]   ; /* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

	 char    szhFecCaducida[9]   ; /* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 

	 char    szhFecAntiguedad[9] ; /* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 

	 char    szhFecPago[9] 			; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

	 long		lhNumAbonado			;
	 long		lhNumFolio				;
	 char    szhNumFolioCTC[12] 			; /* EXEC SQL VAR szhNumFolioCTC IS STRING(12); */ 

	 long		lhNumCuota				;
	 int		ihSecCuota				;
	 long		lhNumTransa 			;
	 long		lhNumVenta				;
	 short   shIndFecVencimie     ;
	 short   shIndFecCaducida     ;
	 short   shIndFecAntiguedad   ;
	 short   shIndFecPago		   ;
	 short	shIndNumAbonado		;
	 short   shIndNumFolio			;
	 short   shIndNumFolioCTC			;
	 short	shIndNumCuota			;
	 short   shIndSecCuota			;
	 short	shIndNumTransa			;
	 short	shIndNumVenta			;
	char    szhPrefPlaza[26]      ; /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

	char    szhCodOperadoraScl[6]; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
 /* jlr_11.01.03 */
	char    szhCodPlaza[6]       ; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
        /* jlr_11.01.03 */

   /* EXEC SQL END DECLARE SECTION; */ 


   BOOL bResul;

   lhCodCliente  = lCodCliente; 
   ihCodTipDocum = stConGen->iCodTipDocum;
   lhCodAgente   = stConGen->lCodAgente;
   szhLetra      = stConGen->szLetra;
   ihCodCentrEmi = stConGen->iCodCentremi;
   lhNumSecuenci = stConGen->lNumSecuenci;
   ihCodConcepto = stConGen->iCodConcepto;

   ihColumna      = stConGen->iColumna;
	ihCodProducto  = stConGen->iCodProducto;
   dhImporteDebe  = stConGen->dImporteDebe;
   dhImporteHaber = stConGen->dImporteHaber;

   ihIndContado   = stConGen->iIndContado;
   ihIndFacturado = stConGen->iIndFacturado;

   strcpy(szhFecEfectividad,stConGen->szFecEfectividad);
   strcpy(szhFecHistorico  ,szFecHis);

   if (strlen(stConGen->szFecVencimie) == 0)
   {
	   strcpy(szhFecVencimie,"");
       shIndFecVencimie = ORA_NULL;
   }
   else
	 {
	   strcpy(szhFecVencimie,stConGen->szFecVencimie);
       shIndFecVencimie = 0;
     }
	   
   if (strlen(stConGen->szFecCaducida) == 0)
   {
	   strcpy(szhFecCaducida,"");
       shIndFecCaducida = ORA_NULL;
   }
   else 
	 {
	   strcpy(szhFecCaducida,stConGen->szFecCaducida);
       shIndFecCaducida = 0;
     }

   if (strlen(stConGen->szFecAntiguedad) == 0)
   {
	   strcpy(szhFecAntiguedad,"");
       shIndFecAntiguedad = ORA_NULL;
   }
   else
	{
	   strcpy(szhFecAntiguedad,stConGen->szFecAntiguedad);
       shIndFecAntiguedad = 0;
    }

   if (strlen(stConGen->szFecPago) == 0)
   {
	   strcpy(szhFecPago,"");
       shIndFecPago = ORA_NULL;
   }
   else
	{
	   strcpy(szhFecPago,stConGen->szFecPago);
       shIndFecPago = 0;
    }

   if (stConGen->lNumAbonado == ORA_NULL)
       shIndNumAbonado = ORA_NULL;
   else
   {
       lhNumAbonado = stConGen->lNumAbonado;
	   shIndNumAbonado = 0;
   }

   if (stConGen->lNumFolio == ORA_NULL)
       shIndNumFolio = ORA_NULL;
   else
   {
       lhNumFolio = stConGen->lNumFolio;
	   shIndNumFolio = 0;
   }

   if (strlen(stConGen->szFolioCTC) == 0)
   {
       strcpy(szhNumFolioCTC,"");
       shIndNumFolioCTC = ORA_NULL;
   }
   else
   {
	   strcpy(szhNumFolioCTC,stConGen->szFolioCTC);
	   shIndNumFolioCTC = 0;
   }

   if (stConGen->lNumCuota == ORA_NULL)
       shIndNumCuota = ORA_NULL;
   else
   {
       lhNumCuota = stConGen->lNumCuota;
	   shIndNumCuota = 0;
   }

   if (stConGen->iSecCuota == ORA_NULL)
       shIndSecCuota = ORA_NULL;
   else
   {
       ihSecCuota = stConGen->iSecCuota;
	   shIndSecCuota = 0;
   }
   if (stConGen->lNumTransa == ORA_NULL)
       shIndNumTransa = ORA_NULL;
   else
   {
       lhNumTransa = stConGen->lNumTransa;
	   shIndNumTransa = 0;
   }
   if (stConGen->lNumVenta == ORA_NULL)
       shIndNumVenta = ORA_NULL;
   else
   {
       lhNumVenta = stConGen->lNumVenta;
	   shIndNumVenta = 0;
   }

   strcpy(szhPrefPlaza,stConGen->szPrefPlaza);				/* jlr_11.01.03 */
   strcpy(szhCodOperadoraScl,stConGen->szCodOperadoraScl);	/* jlr_11.01.03 */
   strcpy(szhCodPlaza,stConGen->szCodPlaza);				/* jlr_11.01.03 */

	/* manejo de decimales segun la operadora local */
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

   /* EXEC SQL INSERT
	 INTO CO_CANCELADOS
		(COD_CLIENTE       ,
		 COD_TIPDOCUM      ,
		 COD_CENTREMI      ,
		 NUM_SECUENCI      ,
		 COD_VENDEDOR_AGENTE        ,
		 LETRA             ,
		 COD_CONCEPTO      ,
		 COLUMNA           ,
		 COD_PRODUCTO	   ,
		 IMPORTE_DEBE      ,
		 IMPORTE_HABER     ,
		 IND_CONTADO       ,
		 IND_FACTURADO     ,
		 FEC_EFECTIVIDAD   ,
		 FEC_CANCELACION   ,
		 IND_PORTADOR		 ,	
		 FEC_VENCIMIE      ,
		 FEC_CADUCIDA      ,
		 FEC_ANTIGUEDAD    ,
		 FEC_PAGO		    ,
		 NUM_ABONADO       ,
		 NUM_FOLIO         ,
		 NUM_FOLIOCTC      ,
		 NUM_CUOTA         ,
		 SEC_CUOTA			,
		 NUM_TRANSACCION	,
		 NUM_VENTA          ,
         PREF_PLAZA         , /o jlr_11.01.03 o/
         COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
         COD_PLAZA          ) /o jlr_11.01.03 o/
      VALUES
		(:lhCodCliente          ,
		 :ihCodTipDocum         ,
		 :ihCodCentrEmi         ,
		 :lhNumSecuenci         ,
		 :lhCodAgente          ,
		 :szhLetra              ,
		 :ihCodConcepto         ,
		 :ihColumna             ,
		 :ihCodProducto			,
		 :dhImporteDebe,
		 :dhImporteHaber,
		 :ihIndContado          ,
		 :ihIndFacturado        ,
		 TO_DATE(:szhFecEfectividad,'YYYYMMDD'),
		 TO_DATE(:szhFecHistorico,'YYYYMMDD')  ,
		 0,	
		 TO_DATE(:szhFecVencimie:shIndFecVencimie,'YYYYMMDD'),
		 TO_DATE(:szhFecCaducida:shIndFecCaducida,'YYYYMMDD'),
		 TO_DATE(:szhFecAntiguedad:shIndFecAntiguedad,'YYYYMMDD'),
		 TO_DATE(:szhFecPago:shIndFecPago,'YYYYMMDD'),
		 :lhNumAbonado:shIndNumAbonado,
		 :lhNumFolio:shIndNumFolio,
		 :szhNumFolioCTC:shIndNumFolioCTC,
		 :lhNumCuota:shIndNumCuota,
		 :ihSecCuota:shIndSecCuota,
		 :lhNumTransa:shIndNumTransa,
		 :lhNumVenta:shIndNumVenta,
       	 :szhPrefPlaza,       /o jlr_11.01.03 o/
		 :szhCodOperadoraScl, /o jlr_11.01.03 o/
		 :szhCodPlaza ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_CANCELADOS (COD_CLIENTE,COD_TIPDOCUM,COD_CE\
NTREMI,NUM_SECUENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CONCEPTO,COLUMNA,COD_PRODUCT\
O,IMPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CAN\
CELACION,IND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_AB\
ONADO,NUM_FOLIO,NUM_FOLIOCTC,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,PRE\
F_PLAZA,COD_OPERADORA_SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:\
b8,:b9,:b10,:b11,:b12,TO_DATE(:b13,'YYYYMMDD'),TO_DATE(:b14,'YYYYMMDD'),0,TO_D\
ATE(:b15:b16,'YYYYMMDD'),TO_DATE(:b17:b18,'YYYYMMDD'),TO_DATE(:b19:b20,'YYYYMM\
DD'),TO_DATE(:b21:b22,'YYYYMMDD'),:b23:b24,:b25:b26,:b27:b28,:b29:b30,:b31:b32\
,:b33:b34,:b35:b36,:b37,:b38,:b39)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1093;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&dhImporteDebe;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteHaber;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&ihIndContado;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihIndFacturado;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhFecEfectividad;
   sqlstm.sqhstl[13] = (unsigned long )9;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhFecHistorico;
   sqlstm.sqhstl[14] = (unsigned long )9;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhFecVencimie;
   sqlstm.sqhstl[15] = (unsigned long )9;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&shIndFecVencimie;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhFecCaducida;
   sqlstm.sqhstl[16] = (unsigned long )9;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&shIndFecCaducida;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhFecAntiguedad;
   sqlstm.sqhstl[17] = (unsigned long )9;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)&shIndFecAntiguedad;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)szhFecPago;
   sqlstm.sqhstl[18] = (unsigned long )9;
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)&shIndFecPago;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)&shIndNumAbonado;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)&lhNumFolio;
   sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)&shIndNumFolio;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)szhNumFolioCTC;
   sqlstm.sqhstl[21] = (unsigned long )12;
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)&shIndNumFolioCTC;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqhstv[22] = (unsigned char  *)&lhNumCuota;
   sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[22] = (         int  )0;
   sqlstm.sqindv[22] = (         short *)&shIndNumCuota;
   sqlstm.sqinds[22] = (         int  )0;
   sqlstm.sqharm[22] = (unsigned long )0;
   sqlstm.sqadto[22] = (unsigned short )0;
   sqlstm.sqtdso[22] = (unsigned short )0;
   sqlstm.sqhstv[23] = (unsigned char  *)&ihSecCuota;
   sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[23] = (         int  )0;
   sqlstm.sqindv[23] = (         short *)&shIndSecCuota;
   sqlstm.sqinds[23] = (         int  )0;
   sqlstm.sqharm[23] = (unsigned long )0;
   sqlstm.sqadto[23] = (unsigned short )0;
   sqlstm.sqtdso[23] = (unsigned short )0;
   sqlstm.sqhstv[24] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[24] = (         int  )0;
   sqlstm.sqindv[24] = (         short *)&shIndNumTransa;
   sqlstm.sqinds[24] = (         int  )0;
   sqlstm.sqharm[24] = (unsigned long )0;
   sqlstm.sqadto[24] = (unsigned short )0;
   sqlstm.sqtdso[24] = (unsigned short )0;
   sqlstm.sqhstv[25] = (unsigned char  *)&lhNumVenta;
   sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[25] = (         int  )0;
   sqlstm.sqindv[25] = (         short *)&shIndNumVenta;
   sqlstm.sqinds[25] = (         int  )0;
   sqlstm.sqharm[25] = (unsigned long )0;
   sqlstm.sqadto[25] = (unsigned short )0;
   sqlstm.sqtdso[25] = (unsigned short )0;
   sqlstm.sqhstv[26] = (unsigned char  *)szhPrefPlaza;
   sqlstm.sqhstl[26] = (unsigned long )26;
   sqlstm.sqhsts[26] = (         int  )0;
   sqlstm.sqindv[26] = (         short *)0;
   sqlstm.sqinds[26] = (         int  )0;
   sqlstm.sqharm[26] = (unsigned long )0;
   sqlstm.sqadto[26] = (unsigned short )0;
   sqlstm.sqtdso[26] = (unsigned short )0;
   sqlstm.sqhstv[27] = (unsigned char  *)szhCodOperadoraScl;
   sqlstm.sqhstl[27] = (unsigned long )6;
   sqlstm.sqhsts[27] = (         int  )0;
   sqlstm.sqindv[27] = (         short *)0;
   sqlstm.sqinds[27] = (         int  )0;
   sqlstm.sqharm[27] = (unsigned long )0;
   sqlstm.sqadto[27] = (unsigned short )0;
   sqlstm.sqtdso[27] = (unsigned short )0;
   sqlstm.sqhstv[28] = (unsigned char  *)szhCodPlaza;
   sqlstm.sqhstl[28] = (unsigned long )6;
   sqlstm.sqhsts[28] = (         int  )0;
   sqlstm.sqindv[28] = (         short *)0;
   sqlstm.sqinds[28] = (         int  )0;
   sqlstm.sqharm[28] = (unsigned long )0;
   sqlstm.sqadto[28] = (unsigned short )0;
   sqlstm.sqtdso[28] = (unsigned short )0;
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

      /* jlr_11.01.03 */

	 if (sqlca.sqlcode != SQLOK)
	 {
		 fprintf( fArchLog, "Error al insertar en CO_CANCELADOS => [%s].\n", szfnORAerror() );
		 return FALSE;
	 }

     return TRUE;
}/* Fin bfnDBIntCancelados() */

/*****************************************************************************/
BOOL bfnDBLlevarACanCtosFA(DATCON *stCon,long lCodCliente,char *szFecHis)
/**
Descripcion: Mueve el concepto de argumento y todos sus relacionados de
             cartera a cancelados.
Salida     : En caso de error devuelve FALSE.
**/
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente    ;
	int    ihCodTipDocum   ;
	long   lhCodAgente     ;
	char   *szhLetra       ; /* EXEC SQL VAR szhLetra     IS STRING(2); */ 

	int    ihCodCentrEmi   ;
	long   lhNumSecuenci   ;
	int    ihCodConcepto   ;
	int    ihColumna       ;
	char   *szhFecHistorico; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

	int    ihCodProducto   ;
	long   lhNumAbonado    ;
	char   szhTMC       [4];
	char   szhyyyymmdd  [9];
	char   szh000       [4];
	char   szh00001     [6];
	int    ihValor_cero = 0;
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion bfnDBLlevarACanCtosFA().\n" );
   /* Prepara datos para "move" */
   lhCodCliente  = lCodCliente ;
   ihCodTipDocum = stCon->iCodTipDocum;
   ihCodCentrEmi = stCon->iCodCentremi;
   lhNumSecuenci = stCon->lNumSecuenci;
   lhCodAgente   = stCon->lCodAgente ;
   szhLetra      = stCon->szLetra     ;
   ihCodConcepto = stCon->iCodConcepto;
   ihColumna     = stCon->iColumna;
   ihCodProducto = stCon->iCodProducto;
   lhNumAbonado  = stCon->lNumAbonado;
   strcpy(szhTMC,"TMC");
   strcpy(szhyyyymmdd,"yyyymmdd");
   strcpy(szh000,"000");
   strcpy(szh00001,"00001");
   szhFecHistorico = szFecHis;

	fprintf( fArchLog,	"Datos entrada bfnDBLlevarACanCtosFA.\n"
						"\tlhCodCliente    => [%d]\n"
						"\tihCodTipDocum   => [%d]\n"
						"\tihCodCentrEmi   => [%d]\n"
						"\tlhNumSecuenci   => [%d]\n"
						"\tlhCodAgente     => [%d]\n"
						"\tszhLetra        => [%s]\n"
						"\tihCodConcepto   => [%d]\n"
						"\tihColumna       => [%d]\n"
						"\tihCodProducto   => [%d]\n"
						"\tlhNumAbonado    => [%d]\n"
						"\tszhFecHistorico => [%s]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						ihCodCentrEmi,
						lhNumSecuenci,
						lhCodAgente,
						szhLetra,
						ihCodConcepto,
						ihColumna,
						ihCodProducto,
						lhNumAbonado,
						szhFecHistorico );

	/* EXEC SQL INSERT
	INTO CO_CANCELADOS
			(	COD_CLIENTE    ,
				COD_TIPDOCUM   ,
				COD_CENTREMI   ,
				NUM_SECUENCI   ,
				COD_VENDEDOR_AGENTE     ,
				LETRA          ,
				COD_CONCEPTO   ,
				COLUMNA        ,
				COD_PRODUCTO   ,
				IMPORTE_DEBE   ,
				IMPORTE_HABER  ,
				IND_CONTADO    ,
				IND_FACTURADO  ,
				FEC_EFECTIVIDAD,
				FEC_CANCELACION,
				IND_PORTADOR   ,
				FEC_VENCIMIE   ,
				FEC_CADUCIDA   ,
				FEC_ANTIGUEDAD ,
				FEC_PAGO       ,
				NUM_ABONADO    ,
				NUM_FOLIO      ,
				NUM_FOLIOCTC   ,
				NUM_CUOTA      ,
				SEC_CUOTA      ,
				NUM_TRANSACCION,
				NUM_VENTA      ,
				PREF_PLAZA         , /o jlr_11.01.03 o/
				COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
				COD_PLAZA          ) /o jlr_11.01.03 o/
	SELECT	nvl(COD_CLIENTE,:ihValor_cero)      ,
			   nvl(COD_TIPDOCUM,:ihValor_cero)     ,
			   nvl(COD_CENTREMI,:ihValor_cero)     ,
			   nvl(NUM_SECUENCI,:ihValor_cero)     ,
			   nvl(COD_VENDEDOR_AGENTE,:ihValor_cero)       ,
			   nvl(LETRA,:ihValor_cero)            ,
			   nvl(COD_CONCEPTO,:ihValor_cero)     ,
			   nvl(COLUMNA,:ihValor_cero)          ,
			   nvl(COD_PRODUCTO ,:ihValor_cero)    ,
			   nvl(IMPORTE_DEBE,:ihValor_cero)     ,
			   nvl(IMPORTE_HABER,:ihValor_cero)    ,
			   nvl(IND_CONTADO,:ihValor_cero)      ,
			   nvl(IND_FACTURADO,:ihValor_cero)    ,
			   FEC_EFECTIVIDAD,
			   TO_DATE(:szhFecHistorico,:szhyyyymmdd),
			   :ihValor_cero,
			   FEC_VENCIMIE   ,
			   FEC_CADUCIDA   ,
			   FEC_ANTIGUEDAD ,
			   SYSDATE        ,
			   nvl(NUM_ABONADO,:ihValor_cero)        ,
			   nvl(NUM_FOLIO,:ihValor_cero)          ,
			   nvl(NUM_FOLIOCTC,:ihValor_cero)       ,
			   nvl(NUM_CUOTA,:ihValor_cero)          ,
			   nvl(SEC_CUOTA,:ihValor_cero)          ,
			   nvl(NUM_TRANSACCION,:ihValor_cero)    ,
			   nvl(NUM_VENTA,:ihValor_cero)    	   ,
            NVL(PREF_PLAZA,:szh000)           ,       /o jlr_11.01.03 *** CH-1912 01-06-2004o/
            NVL(COD_OPERADORA_SCL,'TMG')    ,       /o jlr_11.01.03 *** CH-1912 01-06-2004o/
            NVL(COD_PLAZA,:szh00001)                  /o jlr_11.01.03 *** CH-1912 01-06-2004o/
	FROM 	CO_CARTERA
	WHERE COD_CLIENTE        = :lhCodCliente
	AND 	COD_TIPDOCUM   = :ihCodTipDocum
	AND 	COD_CENTREMI   = :ihCodCentrEmi
	AND 	NUM_SECUENCI   = :lhNumSecuenci
	AND 	COD_VENDEDOR_AGENTE	= :lhCodAgente
	AND 	LETRA          = :szhLetra
	AND 	COD_PRODUCTO   = :ihCodProducto
	AND 	NUM_ABONADO    = :lhNumAbonado
	AND 	COD_CONCEPTO   = :ihCodConcepto
	AND 	COLUMNA        = :ihColumna; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft((void **)0, 
   "insert into CO_CANCELADOS (COD_CLIENTE,COD_TIPDOCUM,COD_CENTREMI,NUM_SEC\
UENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMPORTE_DE\
BE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CANCELACION,I\
ND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NU\
M_FOLIO,NUM_FOLIOCTC,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,PREF_PLAZ\
A,COD_OPERADORA_SCL,COD_PLAZA)select nvl(COD_CLIENTE,:b0) ,nvl(COD_TIPDOCUM,\
:b0) ,nvl(COD_CENTREMI,:b0) ,nvl(NUM_SECUENCI,:b0) ,nvl(COD_VENDEDOR_AGENTE,\
:b0) ,nvl(LETRA,:b0) ,nvl(COD_CONCEPTO,:b0) ,nvl(COLUMNA,:b0) ,nvl(COD_PRODU\
CTO,:b0) ,nvl(IMPORTE_DEBE,:b0) ,nvl(IMPORTE_HABER,:b0) ,nvl(IND_CONTADO,:b0\
) ,nvl(IND_FACTURADO,:b0) ,FEC_EFECTIVIDAD ,TO_DATE(:b13,:b14) ,:b0 ,FEC_VEN\
CIMIE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,SYSDATE ,nvl(NUM_ABONADO,:b0) ,nvl(NUM_\
FOLIO,:b0) ,nvl(NUM_FOLIOCTC,:b0) ,nvl(NUM_CUOTA,:b0) ,nvl(SEC_CUOTA,:b0) ,n\
vl(NUM_TRANSACCION,:b0) ,nvl(NUM_VENTA,:b0) ,NVL(PREF_PLAZA,:b23) ,NVL(COD_O\
PERADORA_SCL,'TMG') ,NVL(COD_PLAZA,:b24)");
 sqlstm.stmt = "  from CO_CARTERA where (((((((((COD_CLIENTE=:b25 and COD_TI\
PDOCUM=:b26) and COD_CENTREMI=:b27) and NUM_SECUENCI=:b28) and COD_VENDEDOR_AG\
ENTE=:b29) and LETRA=:b30) and COD_PRODUCTO=:b31) and NUM_ABONADO=:b32) and CO\
D_CONCEPTO=:b33) and COLUMNA=:b34)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1224;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhFecHistorico;
 sqlstm.sqhstl[13] = (unsigned long )9;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[14] = (unsigned long )9;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)0;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)0;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)0;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szh000;
 sqlstm.sqhstl[23] = (unsigned long )4;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)0;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szh00001;
 sqlstm.sqhstl[24] = (unsigned long )6;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)0;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)0;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)0;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[27] = (         int  )0;
 sqlstm.sqindv[27] = (         short *)0;
 sqlstm.sqinds[27] = (         int  )0;
 sqlstm.sqharm[27] = (unsigned long )0;
 sqlstm.sqadto[27] = (unsigned short )0;
 sqlstm.sqtdso[27] = (unsigned short )0;
 sqlstm.sqhstv[28] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[28] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[28] = (         int  )0;
 sqlstm.sqindv[28] = (         short *)0;
 sqlstm.sqinds[28] = (         int  )0;
 sqlstm.sqharm[28] = (unsigned long )0;
 sqlstm.sqadto[28] = (unsigned short )0;
 sqlstm.sqtdso[28] = (unsigned short )0;
 sqlstm.sqhstv[29] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[29] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[29] = (         int  )0;
 sqlstm.sqindv[29] = (         short *)0;
 sqlstm.sqinds[29] = (         int  )0;
 sqlstm.sqharm[29] = (unsigned long )0;
 sqlstm.sqadto[29] = (unsigned short )0;
 sqlstm.sqtdso[29] = (unsigned short )0;
 sqlstm.sqhstv[30] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[30] = (unsigned long )2;
 sqlstm.sqhsts[30] = (         int  )0;
 sqlstm.sqindv[30] = (         short *)0;
 sqlstm.sqinds[30] = (         int  )0;
 sqlstm.sqharm[30] = (unsigned long )0;
 sqlstm.sqadto[30] = (unsigned short )0;
 sqlstm.sqtdso[30] = (unsigned short )0;
 sqlstm.sqhstv[31] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[31] = (         int  )0;
 sqlstm.sqindv[31] = (         short *)0;
 sqlstm.sqinds[31] = (         int  )0;
 sqlstm.sqharm[31] = (unsigned long )0;
 sqlstm.sqadto[31] = (unsigned short )0;
 sqlstm.sqtdso[31] = (unsigned short )0;
 sqlstm.sqhstv[32] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[32] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[32] = (         int  )0;
 sqlstm.sqindv[32] = (         short *)0;
 sqlstm.sqinds[32] = (         int  )0;
 sqlstm.sqharm[32] = (unsigned long )0;
 sqlstm.sqadto[32] = (unsigned short )0;
 sqlstm.sqtdso[32] = (unsigned short )0;
 sqlstm.sqhstv[33] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[33] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[33] = (         int  )0;
 sqlstm.sqindv[33] = (         short *)0;
 sqlstm.sqinds[33] = (         int  )0;
 sqlstm.sqharm[33] = (unsigned long )0;
 sqlstm.sqadto[33] = (unsigned short )0;
 sqlstm.sqtdso[33] = (unsigned short )0;
 sqlstm.sqhstv[34] = (unsigned char  *)&ihColumna;
 sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[34] = (         int  )0;
 sqlstm.sqindv[34] = (         short *)0;
 sqlstm.sqinds[34] = (         int  )0;
 sqlstm.sqharm[34] = (unsigned long )0;
 sqlstm.sqadto[34] = (unsigned short )0;
 sqlstm.sqtdso[34] = (unsigned short )0;
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



	if( sqlca.sqlcode != 0 )
	{
		fprintf( fArchLog, "Error en INSERT CO_CANCELADOS => [%s].\n", szfnORAerror() );
		return FALSE;
	}

	/* Borramos de cartera */
	/* EXEC SQL
	DELETE 	CO_CARTERA
	WHERE  	COD_CLIENTE		= :lhCodCliente
	AND 	COD_TIPDOCUM   	= :ihCodTipDocum
	AND 	COD_CENTREMI   	= :ihCodCentrEmi
	AND 	NUM_SECUENCI   	= :lhNumSecuenci
	AND 	COD_VENDEDOR_AGENTE	= :lhCodAgente
	AND		LETRA          	= :szhLetra
	AND		COD_CONCEPTO   	= :ihCodConcepto
	AND		COLUMNA        	= :ihColumna
	AND		COD_PRODUCTO   	= :ihCodProducto
	AND		NUM_ABONADO    	= :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_CARTERA  where (((((((((COD_CLIENTE=:b0 and \
COD_TIPDOCUM=:b1) and COD_CENTREMI=:b2) and NUM_SECUENCI=:b3) and COD_VENDEDOR\
_AGENTE=:b4) and LETRA=:b5) and COD_CONCEPTO=:b6) and COLUMNA=:b7) and COD_PRO\
DUCTO=:b8) and NUM_ABONADO=:b9)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1379;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmi;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
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


	
	if( sqlca.sqlcode != 0 )
	{
		fprintf( fArchLog, "Error en DELETE CO_CARTERA => [%s].\n", szfnORAerror() );
		return FALSE;
	}
	
	return TRUE;
} /* Fin DBLlevarACanCtosFA(.)  */

/*****************************************************************************/
BOOL bfnDBUpdateVenta( long lCodCliente, int iCodProducto, long lNumTransa, long lNumVenta )
/**
Descripcion : Funcion que inserta un importe de primera venta en co_carteventa.
Entrada		: stDatPag, estructura de pago
				  stDatFac, estructura de factura
Salida 		: TRUE, si todo ha ido bien.
              FALSE, si falla algo.
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNumTransa;
	long lhNumVenta;
	long lhCodCliente ;
	int  ihCodProducto;
	int  ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion bfnDBUpdateVenta().\n" );
	lhNumTransa = lNumTransa;
	lhNumVenta = lNumVenta;
	lhCodCliente = lCodCliente;
	ihCodProducto = iCodProducto;
	
	fprintf( fArchLog, "Datos de entrada bfnDBUpdateVenta.\n"
						"\tlhNumTransa   => [%d]\n"
						"\tlhNumVenta    => [%d]\n"
						"\tlhCodCliente  => [%d]\n"
						"\tihCodProducto => [%d]\n\n",
						lhNumTransa,
						lhNumVenta,
						lhCodCliente,
						ihCodProducto );
                         
	lhNumTransa = lNumTransa;
	lhNumVenta = lNumVenta;
	lhCodCliente = lCodCliente;
	ihCodProducto = iCodProducto;

	if (lhNumVenta == ORA_NULL)
	{
		/* EXEC SQL 
		UPDATE GA_TRANSCONTADO SET 
		      IND_PASOCOB = :ihValor_uno
		WHERE NUM_TRANSACCION = :lhNumTransa
		AND   COD_CLIENTE = :lhCodCliente
		AND   COD_PRODUCTO = :ihCodProducto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 35;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_TRANSCONTADO  set IND_PASOCOB=:b0 where ((NUM_TRA\
NSACCION=:b1 and COD_CLIENTE=:b2) and COD_PRODUCTO=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1434;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProducto;
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



  		if(sqlca.sqlcode != 0) 
		{
    		fprintf( fArchLog, "Error en UPDATE GA_TRANSCONTADO => %s.\n", szfnORAerror() );
    		return FALSE;
   	}
	}
	else
	{
		/* EXEC SQL 
		UPDATE GA_VENTAS SET 
		      IND_PASOCOB = :ihValor_uno
		WHERE NUM_VENTA = :lhNumVenta
		AND   NUM_TRANSACCION = :lhNumTransa
		AND   COD_CLIENTE = :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 35;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update GA_VENTAS  set IND_PASOCOB=:b0 where ((NUM_VENTA=:b1\
 and NUM_TRANSACCION=:b2) and COD_CLIENTE=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1465;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumTransa;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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



  		if( sqlca.sqlcode != 0 ) 
		{
    		fprintf( fArchLog, "Error en UPDATE GA_VENTAS => %s.\n", szfnORAerror() );
    		return FALSE;
   	}
	}
	return TRUE;
	
}/* bfnDBUpdateVenta() */
/***************************************************************************/
BOOL bfnDBUpdateCarVenta(long lCodCliente, int iCodProducto,long lNumTransa)
/**
Descripcion : Funcion que al updatear el indicador de cancelado indica que si
				  facturacion vuelve a incorporar la factura de primeraventa no se
				  le va a permitir.
Entrada     : stDatPag, estructura de pago
              stDatFac, estructura de factura
Salida      : TRUE, si todo ha ido bien.
              FALSE, si falla algo.
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long  lhNumTransa;
	long  lhCodCliente ;
	int   ihCodProducto;
	int   ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion bfnDBUpdateCarVenta().\n" );
	lhNumTransa = lNumTransa;
	lhCodCliente = lCodCliente;
	ihCodProducto = iCodProducto;
	
	/* EXEC SQL
	UPDATE CO_CARTEVENTA  SET 
	       IND_CANCELADO = :ihValor_uno,
		    FEC_CANCELACION= SYSDATE
	WHERE  NUM_TRANSACCION= :lhNumTransa
	AND    COD_CLIENTE    = :lhCodCliente
	AND    COD_PRODUCTO   = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_CARTEVENTA  set IND_CANCELADO=:b0,FEC_CANCELACION=\
SYSDATE where ((NUM_TRANSACCION=:b1 and COD_CLIENTE=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1496;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumTransa;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProducto;
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


	
	if( sqlca.sqlcode != 0 )
	{
		fprintf (fArchLog, "Error en update CO_CARTEVENTA => [%s].\n", szfnORAerror() );
		return FALSE;
	}
	
	return TRUE;

}/* bfnDBUpdateCarteVenta() */
/***************************************************************************/
BOOL bfnDBIntCarteraFac(DATCON *stConGen,long lCodCliente,char *szCodMoneda)
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 


      long    lhCodCliente ;
      int     ihCodTipDocum;
      long    lhCodAgente  ;
      char    *szhLetra    ; 		/* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int     ihCodCentremi;
      long    lhNumSecuenci;
      int     ihCodConcepto;
      int     ihColumna    ;
      double  dhImporteDebe;
      double  dhImporteHaber;
      int     ihCodProducto;
      int     ihIndContado ;
      int     ihIndFacturado      ;
      char    szhMonedaCobros[4]  ; /* EXEC SQL VAR szhMonedaCobros IS STRING(4); */ 

      char    szhFecEfectividad[9]; /* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

      char    szhFecVencimie[9]   ; /* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

      char    szhFecCaducida[9]   ; /* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 

      char    szhFecAntiguedad[9] ; /* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 

      char    szhFecPago[9]       ; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

      long    lhNumAbonado        ;
      long    lhNumFolio          ;
      long    lhNumCuota          ;
      int     ihSecCuota          ;
      long    lhNumTransa         ;
      long    lhNumVenta          ;
      short   shIndFecVencimie    ;
      short   shIndFecCaducida    ;
      short   shIndFecAntiguedad  ;
      short   shIndFecPago   	  ;
      short   shIndNumAbonado     ;
      short   shIndNumFolio       ;
      short   shIndNumCuota       ;
      short   shIndSecCuota       ;
      short   shIndNumTransa      ;
      short   shIndNumVenta       ;
      int     ihConcepCarrier	  ;
      char    szhPrefPlaza[26]      ; /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

      char    szhCodOperadoraScl[6]; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
 /* jlr_11.01.03 */
      char    szhCodPlaza[6]       ; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
        /* jlr_11.01.03 */

   /* EXEC SQL END DECLARE SECTION; */ 


   BOOL bResul;
	double dImporteDebe = 0.0;
	double dImporteHaber = 0.0;

	fprintf( fArchLog, "En funcion bfnDBIntCarteraFac().\n" );
	/* EXEC SQL
	SELECT MONEDA_COBROS,TIP_CONCEPCARRIER
	  INTO :szhMonedaCobros,
		   :ihConcepCarrier
	  FROM CO_DATGEN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select MONEDA_COBROS ,TIP_CONCEPCARRIER into :b0,:b1  from C\
O_DATGEN ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1527;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhMonedaCobros;
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihConcepCarrier;
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



   if (sqlca.sqlcode != 0)
   {
      fprintf( fArchLog, "Error al leer de datos generales => [%s].\n", szfnORAerror() );
      return FALSE;
   }

	bResul = bfnDBConversionMon( szCodMoneda, szhMonedaCobros, stConGen->dImporteDebe, &dImporteDebe );
	if (!bResul)
		return FALSE;

	bResul = bfnDBConversionMon( szCodMoneda, szhMonedaCobros, stConGen->dImporteHaber, &dImporteHaber );
	if (!bResul)
		return FALSE;

   lhCodCliente  = lCodCliente           ;
   ihCodTipDocum = stConGen->iCodTipDocum;
   lhCodAgente   = stConGen->lCodAgente  ;
   szhLetra      = stConGen->szLetra     ;
   ihCodCentremi = stConGen->iCodCentremi;
   lhNumSecuenci = stConGen->lNumSecuenci;
   ihCodConcepto = stConGen->iCodConcepto;
/*
	EXEC SQL 
		SELECT COD_CONCEPTO
		INTO :ihCodConcepto
		FROM CO_CONCEPTOS
		WHERE COD_CONCEPTO = :ihCodConcepto
		AND COD_TIPCONCE = :ihConcepCarrier;

   if (sqlca.sqlcode < 0)
   {
      fprintf(fArchLog,"Error al leer el concepto de cobros %s\n",szfnORAerror());
      return FALSE;
   }
*/
	/* Si encuentra es que el concepto es de carrier si no encuentra no lo es */
	dhImporteDebe = stConGen->dImporteDebe;
	dhImporteHaber = stConGen->dImporteHaber;

	if (dhImporteDebe < dhImporteHaber)
	{
  		ihCodConcepto = iConceptoCredito;
	}

   ihCodProducto = stConGen->iCodProducto;

   bResul = bfnDBSecColFA(stConGen);

   if (!bResul)
   {
      fprintf( fArchLog, "ERROR en la Funcio bfnDBSecColFA, llamada por bfnDBIntCarteraFac.\n" );
      return FALSE;
   }
   ihColumna = stConGen->iColumna;

   dhImporteDebe = stConGen->dImporteDebe;
   dhImporteHaber = stConGen->dImporteHaber;

   ihIndContado = stConGen->iIndContado;
   ihIndFacturado = stConGen->iIndFacturado;

   strcpy(szhFecEfectividad,stConGen->szFecEfectividad);

   if (strlen(stConGen->szFecVencimie) == 0)
   {
      strcpy(szhFecVencimie,"");
      shIndFecVencimie = ORA_NULL;
   }
   else
   {
      strcpy(szhFecVencimie,stConGen->szFecVencimie);
      shIndFecVencimie = 0;
   }

   if (strlen(stConGen->szFecCaducida) == 0)
   {
      strcpy(szhFecCaducida,"");
      shIndFecCaducida = ORA_NULL;
   }
   else
   {
      strcpy(szhFecCaducida,stConGen->szFecCaducida);
      shIndFecCaducida = 0;
   }

   if (strlen(stConGen->szFecAntiguedad) == 0)
   {
      strcpy(szhFecAntiguedad,"");
      shIndFecAntiguedad = ORA_NULL;
   }
   else
   {
      strcpy(szhFecAntiguedad,stConGen->szFecAntiguedad);
      shIndFecAntiguedad = 0;
   }

   if (strlen(stConGen->szFecPago) == 0)
   {
      strcpy(szhFecPago,"");
      shIndFecPago = ORA_NULL;
   }
   else
   {
      strcpy(szhFecPago,stConGen->szFecPago);
      shIndFecPago = 0;
   }

   if (stConGen->lNumAbonado == ORA_NULL)
   {
      lhNumAbonado = ORA_NULL;
      shIndNumAbonado = ORA_NULL;
   }
   else
   {
      shIndNumAbonado = 0;
      lhNumAbonado = stConGen->lNumAbonado;
   }
   if (stConGen->lNumFolio == ORA_NULL)
   {
      lhNumFolio = ORA_NULL;
      shIndNumFolio = ORA_NULL;
   }
   else
   {
      shIndNumFolio = 0;
      lhNumFolio = stConGen->lNumFolio;
   }
   if (stConGen->lNumCuota == ORA_NULL)
   {
      lhNumCuota = ORA_NULL;
      shIndNumCuota = ORA_NULL;
   }
   else
   {
      shIndNumCuota = 0;
      lhNumCuota = stConGen->lNumCuota;
   }
   if (stConGen->iSecCuota == ORA_NULL)
   {
      ihSecCuota = ORA_NULL;
      shIndSecCuota = ORA_NULL;
   }
   else
   {
      shIndSecCuota = 0;
      ihSecCuota = stConGen->iSecCuota;
   }
   if (stConGen->lNumTransa == ORA_NULL)
   {
      lhNumTransa = ORA_NULL;
      shIndNumTransa = ORA_NULL;
   }
   else
   {
      shIndNumTransa = 0;
      lhNumTransa = stConGen->lNumTransa;
   }
   if (stConGen->lNumVenta == ORA_NULL)
   {
      lhNumVenta = ORA_NULL;
      shIndNumVenta = ORA_NULL;
   }
   else
   {
      shIndNumVenta = 0;
      lhNumVenta = stConGen->lNumVenta;
   }

	strcpy(szhPrefPlaza,stConGen->szPrefPlaza);				/* jlr_11.01.03 */
	strcpy(szhCodOperadoraScl,stConGen->szCodOperadoraScl);	/* jlr_11.01.03 */
	strcpy(szhCodPlaza,stConGen->szCodPlaza);				/* jlr_11.01.03 */

	fprintf( fArchLog,	"Datos a insertar en Cartera\n"
						"\tlhCodCliente       => [%d]\n"
						"\tihCodTipDocum      => [%d]\n"
						"\tlhCodAgente        => [%d]\n"
						"\tszhLetra           => [%s]\n"
						"\tihCodCentremi      => [%d]\n"
						"\tlhNumSecuenci      => [%d]\n"
						"\tihCodConcepto      => [%d]\n"
						"\tihColumna          => [%d]\n"
						"\tihCodProducto      => [%d]\n"
						"\tdhImporteDebe      => [%.2f]\n"
						"\tdhImporteHaber     => [%.2f]\n"
						"\tihIndContado       => [%d]\n"
						"\tihIndFacturado     => [%d]\n"
						"\tszhFecEfectividad  => [%s]\n"
						"\tszhFecVencimie     => [%s]\n"
						"\tszhFecCaducida     => [%s]\n"
						"\tszhFecAntiguedad   => [%s]\n"
						"\tszhFecPago         => [%s]\n"
						"\tlhNumAbonado       => [%d]\n"
						"\tlhNumFolio         => [%d]\n"
						"\tlhNumCuota         => [%d]\n"
						"\tihSecCuota         => [%d]\n"
						"\tlhNumTransa        => [%d]\n"
						"\tlhNumVenta         => [%d]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						ihCodConcepto,
						ihColumna,
						ihCodProducto,
						dhImporteDebe,
						dhImporteHaber,
						ihIndContado,
						ihIndFacturado,
						szhFecEfectividad,
						szhFecVencimie,
						szhFecCaducida,
						szhFecAntiguedad,
						szhFecPago,
						lhNumAbonado,
						lhNumFolio,
						lhNumCuota,
						ihSecCuota,
						lhNumTransa,
						lhNumVenta );

	/* manejo de decimales segun la operadora local */
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

   /* EXEC SQL INSERT
   INTO CO_CARTERA
         (COD_CLIENTE   ,
         COD_TIPDOCUM  ,
         COD_VENDEDOR_AGENTE    ,
         LETRA         ,
         COD_CENTREMI  ,
         NUM_SECUENCI  ,
         COD_CONCEPTO  ,
         COLUMNA       ,
         COD_PRODUCTO  ,
         IMPORTE_DEBE  ,
         IMPORTE_HABER ,
         IND_CONTADO   ,
         IND_FACTURADO ,
         FEC_EFECTIVIDAD,
         FEC_VENCIMIE  ,
         FEC_CADUCIDA  ,
         FEC_ANTIGUEDAD,
         FEC_PAGO      ,
         NUM_ABONADO   ,
         NUM_FOLIO     ,
         NUM_CUOTA     ,
         SEC_CUOTA     ,
         NUM_TRANSACCION,
         NUM_VENTA     ,
         PREF_PLAZA         , /o jlr_11.01.03 o/
         COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
         COD_PLAZA          ) /o jlr_11.01.03 o/
   VALUES
         (:lhCodCliente ,
         :ihCodTipDocum,
         :lhCodAgente  ,
         :szhLetra     ,
         :ihCodCentremi,
         :lhNumSecuenci,
         :ihCodConcepto,
         :ihColumna    ,
         :ihCodProducto,
         :dhImporteDebe,
         :dhImporteHaber,
         :ihIndContado ,
         :ihIndFacturado,
         TO_DATE(:szhFecEfectividad,'YYYYMMDD'),
         TO_DATE(:szhFecVencimie:shIndFecVencimie,'YYYYMMDD'),
         TO_DATE(:szhFecCaducida:shIndFecCaducida,'YYYYMMDD'),
         TO_DATE(:szhFecAntiguedad:shIndFecAntiguedad,'YYYYMMDD'),
         TO_DATE(:szhFecPago:shIndFecPago,'YYYYMMDD'),
         :lhNumAbonado:shIndNumAbonado,
         :lhNumFolio:shIndNumFolio,
         :lhNumCuota:shIndNumCuota,
         :ihSecCuota:shIndSecCuota,
         :lhNumTransa:shIndNumTransa,
         :lhNumVenta:shIndNumVenta,
       	 :szhPrefPlaza,       /o jlr_11.01.03 o/
		 :szhCodOperadoraScl, /o jlr_11.01.03 o/
		 :szhCodPlaza ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 35;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_CARTERA (COD_CLIENTE,COD_TIPDOCUM,COD_VENDE\
DOR_AGENTE,LETRA,COD_CENTREMI,NUM_SECUENCI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,I\
MPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_VENCIM\
IE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NUM_FOLIO,NUM_CUOTA,SEC_CU\
OTA,NUM_TRANSACCION,NUM_VENTA,PREF_PLAZA,COD_OPERADORA_SCL,COD_PLAZA) values (\
:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,TO_DATE(:b13,'YYYYMMDD'\
),TO_DATE(:b14:b15,'YYYYMMDD'),TO_DATE(:b16:b17,'YYYYMMDD'),TO_DATE(:b18:b19,'\
YYYYMMDD'),TO_DATE(:b20:b21,'YYYYMMDD'),:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b\
30:b31,:b32:b33,:b34,:b35,:b36)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1550;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentremi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&dhImporteDebe;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteHaber;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&ihIndContado;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihIndFacturado;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhFecEfectividad;
   sqlstm.sqhstl[13] = (unsigned long )9;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhFecVencimie;
   sqlstm.sqhstl[14] = (unsigned long )9;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)&shIndFecVencimie;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhFecCaducida;
   sqlstm.sqhstl[15] = (unsigned long )9;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&shIndFecCaducida;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhFecAntiguedad;
   sqlstm.sqhstl[16] = (unsigned long )9;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&shIndFecAntiguedad;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhFecPago;
   sqlstm.sqhstl[17] = (unsigned long )9;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)&shIndFecPago;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)&shIndNumAbonado;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)&lhNumFolio;
   sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)&shIndNumFolio;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)&lhNumCuota;
   sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)&shIndNumCuota;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)&ihSecCuota;
   sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)&shIndSecCuota;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqhstv[22] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[22] = (         int  )0;
   sqlstm.sqindv[22] = (         short *)&shIndNumTransa;
   sqlstm.sqinds[22] = (         int  )0;
   sqlstm.sqharm[22] = (unsigned long )0;
   sqlstm.sqadto[22] = (unsigned short )0;
   sqlstm.sqtdso[22] = (unsigned short )0;
   sqlstm.sqhstv[23] = (unsigned char  *)&lhNumVenta;
   sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[23] = (         int  )0;
   sqlstm.sqindv[23] = (         short *)&shIndNumVenta;
   sqlstm.sqinds[23] = (         int  )0;
   sqlstm.sqharm[23] = (unsigned long )0;
   sqlstm.sqadto[23] = (unsigned short )0;
   sqlstm.sqtdso[23] = (unsigned short )0;
   sqlstm.sqhstv[24] = (unsigned char  *)szhPrefPlaza;
   sqlstm.sqhstl[24] = (unsigned long )26;
   sqlstm.sqhsts[24] = (         int  )0;
   sqlstm.sqindv[24] = (         short *)0;
   sqlstm.sqinds[24] = (         int  )0;
   sqlstm.sqharm[24] = (unsigned long )0;
   sqlstm.sqadto[24] = (unsigned short )0;
   sqlstm.sqtdso[24] = (unsigned short )0;
   sqlstm.sqhstv[25] = (unsigned char  *)szhCodOperadoraScl;
   sqlstm.sqhstl[25] = (unsigned long )6;
   sqlstm.sqhsts[25] = (         int  )0;
   sqlstm.sqindv[25] = (         short *)0;
   sqlstm.sqinds[25] = (         int  )0;
   sqlstm.sqharm[25] = (unsigned long )0;
   sqlstm.sqadto[25] = (unsigned short )0;
   sqlstm.sqtdso[25] = (unsigned short )0;
   sqlstm.sqhstv[26] = (unsigned char  *)szhCodPlaza;
   sqlstm.sqhstl[26] = (unsigned long )6;
   sqlstm.sqhsts[26] = (         int  )0;
   sqlstm.sqindv[26] = (         short *)0;
   sqlstm.sqinds[26] = (         int  )0;
   sqlstm.sqharm[26] = (unsigned long )0;
   sqlstm.sqadto[26] = (unsigned short )0;
   sqlstm.sqtdso[26] = (unsigned short )0;
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

      /* jlr_11.01.03 */

   if (sqlca.sqlcode != 0)
   {
      fprintf( fArchLog, "Error INSERT CO_CARTERA => [%s].\n", szfnORAerror() );
      return FALSE;
   }
   return TRUE;

}/* Fin bfnDBIntCarteraFA() */
/*****************************************************************************/
BOOL bfnDBConversionMon(char *szMonedaOrigen, char *szMonedaDestino,
                     double dImpOrigen, double *dImpDest)
/**
Descripcion: Funcion que realiza la convesion
Salida     : TRUE si todo va bien
             FALSE si falla algo
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char szhMonedaOri[4]; /* EXEC SQL VAR szhMonedaOri IS STRING(4); */ 

   char szhMonedaDes[4]; /* EXEC SQL VAR szhMonedaDes IS STRING(4); */ 

   double   dhCambio1;
   double   dhCambio2;
/* EXEC SQL END DECLARE SECTION; */ 

double   dImpOri = 0.0;
  
	fprintf( fArchLog, "En funcion bfnDBConversionMon().\n" );
   dImpOri = dImpOrigen;
   strcpy(szhMonedaOri,szMonedaOrigen);
   strcpy(szhMonedaDes,szMonedaDestino);

   if (!(strcmp(szhMonedaOri,szhMonedaDes)))
   {
      *dImpDest = dImpOrigen;
   }
   else
   {
      /* EXEC SQL
      SELECT CAMBIO
      INTO :dhCambio1
      FROM GE_CONVERSION
      WHERE COD_MONEDA = :szhMonedaOri
		AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 35;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD_M\
ONEDA=:b1 and SYSDATE between FEC_DESDE and FEC_HASTA)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1673;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&dhCambio1;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhMonedaOri;
      sqlstm.sqhstl[1] = (unsigned long )4;
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



      if (sqlca.sqlcode)
      {
         fprintf(fArchLog,"Error al obtener la conversion %s\n",szfnORAerror());
         return FALSE;
      }
      /* EXEC SQL
      SELECT CAMBIO
      INTO :dhCambio2
      FROM GE_CONVERSION
      WHERE COD_MONEDA = :szhMonedaDes
		AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 35;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select CAMBIO into :b0  from GE_CONVERSION where (COD_M\
ONEDA=:b1 and SYSDATE between FEC_DESDE and FEC_HASTA)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1696;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&dhCambio2;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhMonedaDes;
      sqlstm.sqhstl[1] = (unsigned long )4;
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



      if (sqlca.sqlcode)
      {
         fprintf(fArchLog,"Error al obtener la conversion %s\n",szfnORAerror());
         return FALSE;
      }

      dImpOri = dImpOri * dhCambio1 / dhCambio2;
      /* dImpOri = (dImpOri * INVMIN) / INVMIN; mgg */
      *dImpDest = dImpOri;
   }

   return TRUE;

}/* bfnDBConversionMon() */


BOOL bfnDBInsPagCon( DATDOC *stDoc, DATCON *stHab )
/**
Descripcion: Lleva la relacion del pago con el concepto a pagosconc.
Salida     : En caso de error devuelve FALSE.
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   int     ihCodTipDocum  ;
   int     ihCodCentrEmi  ;
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
		/* jlr_11.01.03 */
   char    szhCodOperadoraScl[6]	; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
	/* jlr_11.01.03 */
   char    szhCodPlaza[6]		; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
		/* jlr_11.01.03 */
/* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion bfnDBInsPagCon().\n" );
   /* Preparamos datos para insert en pagosconc */
   ihCodTipDocum = stDoc->iCodTipDocum;
   ihCodCentrEmi = stDoc->iCodCentrEmi;
   lhNumSecuenci = stDoc->lNumSecuenci;
   lhCodAgente  = stDoc->lCodAgente;
   szhLetra      = stDoc->szLetra;
   dhImporteDebe  = stHab->dImporteHaber;
   ihCodProducto  = stHab->iCodProducto;

   if (stHab->iCodTipDocum == ORA_NULL)
       shIndCodTipDocRel = ORA_NULL;
   else
   {
      ihCodTipDocRel = stHab->iCodTipDocum;
      shIndCodTipDocRel = 0;
   }
   if (stHab->iCodCentremi == ORA_NULL)
       shIndCodCenRel = ORA_NULL;
   else
   {
      ihCodCenRel    = stHab->iCodCentremi;
      shIndCodCenRel = 0;
   }
   if (stHab->lNumSecuenci == ORA_NULL)
       shIndNumSecRel = ORA_NULL;
   else
   {
      lhNumSecRel    = stHab->lNumSecuenci;
      shIndNumSecRel = 0;
   }
   if (stHab->lCodAgente == ORA_NULL)
       shIndCodAgeRel = ORA_NULL;
   else
   {
      lhCodAgeRel    = stHab->lCodAgente;
      shIndCodAgeRel = 0;
   }

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
   if (stHab->iColumna == ORA_NULL)
       shIndColumna = ORA_NULL;
   else
   {
      ihColumna      = stHab->iColumna;
      shIndColumna = 0;
   }

   if (stHab->lNumAbonado == ORA_NULL)
       shIndNumAbonado = ORA_NULL;
   else
   {
      lhNumAbonado   = stHab->lNumAbonado;
      shIndNumAbonado = 0;
   }
   if (stHab->lNumFolio == ORA_NULL)
       shIndNumFolio = ORA_NULL;
   else
   {
      lhNumFolio     = stHab->lNumFolio;
      shIndNumFolio = 0;
   }
   if (stHab->lNumCuota == ORA_NULL)
       shIndNumCuota = ORA_NULL;
   else
   {
      lhNumCuota     = stHab->lNumCuota;
      shIndNumCuota = 0;
   }
   if (stHab->iSecCuota == ORA_NULL)
       shIndSecCuota = ORA_NULL;
   else
   {
      ihSecCuota     = stHab->iSecCuota;
      shIndSecCuota = 0;
   }
   if (stHab->lNumTransa == ORA_NULL)
       shIndNumTransa = ORA_NULL;
   else
   {
      lhNumTransa    = stHab->lNumTransa;
      shIndNumTransa = 0;
   }

   if (stHab->lNumVenta == ORA_NULL)
       shIndNumVenta = ORA_NULL;
   else
   {
      lhNumVenta    = stHab->lNumVenta;
      shIndNumVenta = 0;
   }

	strcpy(szhPrefPlaza,stHab->szPrefPlaza);			/* jlr_11.01.03 */
	strcpy(szhCodOperadoraScl,stHab->szCodOperadoraScl);/* jlr_11.01.03 */
	strcpy(szhCodPlaza,stHab->szCodPlaza);				/* jlr_11.01.03 */

	/* manejo de decimales segun la operadora local */
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
          PREF_PLAZA         , /o jlr_11.01.03 o/
          COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
          COD_PLAZA          ) /o jlr_11.01.03 o/
   VALUES (
          :ihCodTipDocum  ,
          :ihCodCentrEmi  ,
          :lhNumSecuenci  ,
          :lhCodAgente   ,
          :szhLetra       ,
          :dhImporteDebe,
          :ihCodProducto  ,
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
          :szhPrefPlaza,       /o jlr_11.01.03 o/
          :szhCodOperadoraScl, /o jlr_11.01.03 o/
          :szhCodPlaza ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 35;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SE\
CUENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCREL,COD_C\
ENTRREL,NUM_SECUREL,COD_AGENTEREL,LETRA_REL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,N\
UM_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,PREF_PLAZA,COD_OPERADOR\
A_SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7:b8,:b9:b10,:b11:b12,:\
b13:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29:b3\
0,:b31:b32,:b33,:b34,:b35)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1719;
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

      /* jlr_11.01.03 */

     /*PRM*/

	fprintf( fArchLog,	"**********************Datos a insertar en CO_PAGOSCONC\n"
						"\tihCodTipDocum      => [%d]\n"
						"\tihCodCentrEmi      => [%d]\n"
						"\tlhNumSecuenci      => [%ld]\n"
						"\tlhCodAgente        => [%d]\n"
						"\tszhLetra           => [%s]\n"
						"\tdhImporteDebe      => [%.2f]\n"
						"\tihCodProducto      => [%d]\n"
						"\tihCodTipDocRel:shIndCodTipDocRel  => [%d]\n"
						"\tlhNumSecRel:shIndNumSecRel        => [%d]\n"
						"\tszhLetraRel:shIndLetraRel         => [%s]\n"
						"\tihCodConcepto:shIndCodConcepto    => [%d]\n"
						"\tihColumna:shIndColumna            => [%d]\n"
						"\tlhNumAbonado:shIndNumAbonado      => [%d]\n"
						"\tlhNumFolio:shIndNumFolio          => [%d]\n"
						"\tlhNumCuota:shIndNumCuota          => [%d]\n"
						"\tihSecCuota:shIndSecCuota          => [%d]\n"
						"\tlhNumTransa:shIndNumTransa        => [%d]\n"
						"\tlhNumVenta:shIndNumVenta          => [%d]\n"
						"\tszhPrefPlaza                      => [%s]\n"
						"\tszhCodOperadoraScl                => [%s]\n"
						"\tszhCodPlaza                       => [%s]\n\n",
						ihCodTipDocum     	,		
						ihCodCentrEmi      ,
						lhNumSecuenci      ,
						lhCodAgente        ,
						szhLetra           ,
						dhImporteDebe      ,
						ihCodProducto      ,
						ihCodTipDocRel,
						lhNumSecRel,
						szhLetraRel,
						ihCodConcepto,
						ihColumna,
						lhNumAbonado,
						lhNumFolio, 
						lhNumCuota,  
						ihSecCuota,   
						lhNumTransa,    
						lhNumVenta,     
						szhPrefPlaza       ,           
						szhCodOperadoraScl,            
						szhCodPlaza );		
		

	if (sqlca.sqlcode)
	{
		fprintf( fArchLog, "Error bfnDBInsPagCon en INSERT CO_PAGOSCONC => [%s].\n", szfnORAerror() );
		return FALSE;
	}
                    
	fprintf( fArchLog, "Se inserto con exito Registro en CO_PAGOSCONC.\n", szfnORAerror() );
	return TRUE;

} /* Fin DBInsPagCon(...) */

/*****************************************************************************/
BOOL bfnDBValFecValorFA(char *szFecValor)
/**
Valida si la fecha pasada por argumento es menor o igual que SYSDATE.
Si en mayor devuelve FALSE.
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char szhFecha[9]   ; /* EXEC SQL VAR szhFecha IS STRING(9); */ 

/* EXEC SQL END DECLARE SECTION; */ 


   /* EXEC SQL
   SELECT TO_CHAR(SYSDATE,'yyyymmdd')
   INTO :szhFecha
   FROM DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 35;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_CHAR(SYSDATE,'yyyymmdd') into :b0  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1826;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
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



   if (sqlca.sqlcode != SQLOK)
   {
      fprintf(fArchLog,"* Error recuperando fecha de sistema- %s\n", szfnORAerror());
      return FALSE;
   }

   if (strcmp(szFecValor,szhFecha) > 0)
      return FALSE;
   else
      return TRUE ;

} /* Fin bfnDBValFecValorFA() */

/*****************************************************************************/
BOOL bfnDBSecColFA(DATCON *stCon)
/**
Descripcion: Funcion que obtiene la secuencia de la proxima columna.
Entrada:     stCon, estructura de datos de concepto generado.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 


      int     ihCodTipDocum;
      long    lhCodAgente  ;
      char    szhLetra[2]  ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int     ihCodCentremi;
      long    lhNumSecuenci;
      int     ihCodConcepto;
      int     ihColumna    ;
      short   shIndColumna ;

   /* EXEC SQL END DECLARE SECTION; */ 


	fprintf( fArchLog, "En funcion bfnDBSecColFA().\n" );
   ihCodTipDocum = stCon->iCodTipDocum;
   lhCodAgente   = stCon->lCodAgente  ;
   strcpy(szhLetra,stCon->szLetra)    ;
   ihCodCentremi = stCon->iCodCentremi;
   lhNumSecuenci = stCon->lNumSecuenci;
   ihCodConcepto = stCon->iCodConcepto;

	fprintf( fArchLog,	"Entrada de Datos en bfnDBIntCarteraFA\n"
						"\tihCodTipDocum = [%d]\n"
						"\tihCodConcepto = [%d]\n"
						"\tlhCodAgente   = [%d]\n"
						"\tszhLetra      = [%s]\n"
						"\tihCodCentremi = [%d]\n"
						"\tlhNumSecuenci = [%d]\n\n",
						ihCodTipDocum,
						ihCodConcepto,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci);
   	
   	/* EXEC SQL
   	SELECT COLUMNA
   	INTO  :ihColumna
   	FROM  CO_SECARTERA
   	WHERE COD_TIPDOCUM   = :ihCodTipDocum
   	AND COD_VENDEDOR_AGENTE     = :lhCodAgente
   	AND LETRA          = :szhLetra
   	AND COD_CENTREMI   = :ihCodCentremi
   	AND NUM_SECUENCI   = :lhNumSecuenci
   	AND COD_CONCEPTO   = :ihCodConcepto
   	FOR UPDATE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 35;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COLUMNA into :b0  from CO_SECARTERA where (((((COD\
_TIPDOCUM=:b1 and COD_VENDEDOR_AGENTE=:b2) and LETRA=:b3) and COD_CENTREMI=:b4\
) and NUM_SECUENCI=:b5) and COD_CONCEPTO=:b6) for update ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1845;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihColumna;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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



   	if (sqlca.sqlcode < 0 && sqlca.sqlcode != NOT_FOUND)
   	{
      	fprintf(fArchLog,"* Error al obtener la secuencia de la COLUMNA %s\n", szfnORAerror());
      	return FALSE ;
   	}

	if (sqlca.sqlcode == NOT_FOUND)
   	{
		ihColumna = 0;

		printf( "\n\nEntrada de Datos en bfnDBIntCarteraFA, ihColumna = [%d]\n", ihColumna );

		/* EXEC SQL
		INSERT INTO CO_SECARTERA
		( 
			COD_TIPDOCUM,
			COD_VENDEDOR_AGENTE,
			LETRA,
			COD_CENTREMI,
			NUM_SECUENCI,
			COD_CONCEPTO,
			COLUMNA       
		)
		VALUES
		( 
			:ihCodTipDocum,
			:lhCodAgente,
			:szhLetra,
			:ihCodCentremi,
			:lhNumSecuenci,
			:ihCodConcepto,
			:ihColumna    
		); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 35;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into CO_SECARTERA (COD_TIPDOCUM,COD_VENDEDOR_AGENTE,\
LETRA,COD_CENTREMI,NUM_SECUENCI,COD_CONCEPTO,COLUMNA) values (:b0,:b1,:b2,:b3,\
:b4,:b5,:b6)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1888;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodAgente;
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
  sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodConcepto;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihColumna;
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


		
		if( sqlca.sqlcode != SQLOK )
		{
			fprintf(fArchLog,"Error al insertar en CO_SECARTERA (COLUMNA NOT_FOUND) %s\n", szfnORAerror());
			return FALSE;
		}
	}
   /*
   if (shIndColumna == ORA_NULL)
   {
      ihColumna = 0;

      EXEC SQL
      INSERT INTO CO_SECARTERA
      ( COD_TIPDOCUM  ,
         COD_VENDEDOR_AGENTE    ,
         LETRA         ,
         COD_CENTREMI  ,
         NUM_SECUENCI  ,
         COD_CONCEPTO  ,
         COLUMNA       )
      VALUES
         ( :ihCodTipDocum,
         :lhCodAgente  ,
         :szhLetra     ,
         :ihCodCentremi,
         :lhNumSecuenci,
         :ihCodConcepto,
         :ihColumna    );

      if (sqlca.sqlcode != SQLOK)
      {
         fprintf(fArchLog,"Error al insertar en CO_SECARTERA (COLUMNA ORA_NULL) %s\n", szfnORAerror());
         return FALSE;
      }

   } */
   else
   {
      if (ihColumna == 9999)
         ihColumna = 1;
      else
         ihColumna++;
   }

   /* EXEC SQL
   UPDATE CO_SECARTERA
   SET COLUMNA = :ihColumna
   WHERE COD_TIPDOCUM   = :ihCodTipDocum
   AND COD_VENDEDOR_AGENTE     = :lhCodAgente
   AND LETRA          = :szhLetra
   AND COD_CENTREMI   = :ihCodCentremi
   AND NUM_SECUENCI   = :lhNumSecuenci
   AND COD_CONCEPTO   = :ihCodConcepto; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 35;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_SECARTERA  set COLUMNA=:b0 where (((((COD_TIPDOC\
UM=:b1 and COD_VENDEDOR_AGENTE=:b2) and LETRA=:b3) and COD_CENTREMI=:b4) and N\
UM_SECUENCI=:b5) and COD_CONCEPTO=:b6)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1931;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentremi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
      fprintf(fArchLog,"* Error al actualizar la secuencia de la columna %s\n", szfnORAerror());
      return FALSE ;
   }
   stCon->iColumna = ihColumna;

   return TRUE;

} /* Fin bfnDBSecColFA() */

/*****************************************************************************/
BOOL bfnDBIntCarteraFA(DATCON *stConGen,long lCodCliente)
/**
Descripcion: Funcion que introduce en cartera el concepto generado.
Entrada:     stConGen, estructura de concepto generado.
             lCodCliente, codigo de cliente.
Salida:      TRUE, si todo va bien.
             FALSE, si falla algo.
**/
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      long    lhCodCliente ;
      int     ihCodTipDocum;
      long    lhCodAgente  ;
      char    *szhLetra    ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int     ihCodCentremi;
      long    lhNumSecuenci;
      int     ihCodConcepto;
      int     ihColumna    ;
      double  dhImporteDebe;
      double  dhImporteHaber;
      int     ihCodProducto;
      int     ihIndContado ;
      int     ihIndFacturado      ;
      char    szhFecEfectividad[9]; /* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

      char    szhFecVencimie[9]   ; /* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

      char    szhFecCaducida[9]   ; /* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 

      char    szhFecAntiguedad[9] ; /* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 

      char    szhFecPago[9]       ; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

      long    lhNumAbonado        ;
      long    lhNumFolio          ;
      long    lhNumCuota          ;
      int     ihSecCuota          ;
      long    lhNumTransa         ;
      long    lhNumVenta          ;
      short   shIndFecVencimie    ;
      short   shIndFecCaducida    ;
      short   shIndFecAntiguedad  ;
      short   shIndFecPago        ;
      short   shIndNumAbonado     ;
      short   shIndNumFolio       ;
      short   shIndNumCuota       ;
      short   shIndSecCuota       ;
      short   shIndNumTransa      ;
      short   shIndNumVenta       ;
      char    szhPrefPlaza[26]		; /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 
		/* jlr_11.01.03 */
      char    szhCodOperadoraScl[6]	; /* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
	/* jlr_11.01.03 */
      char    szhCodPlaza[6]		; /* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
		/* jlr_11.01.03 */
   /* EXEC SQL END DECLARE SECTION; */ 


   BOOL bResul;

	fprintf( fArchLog, "En funcion bfnDBIntCarteraFA().\n" );
   lhCodCliente  = lCodCliente           ;
   ihCodTipDocum = stConGen->iCodTipDocum;
   lhCodAgente   = stConGen->lCodAgente  ;
   szhLetra      = stConGen->szLetra     ;
   ihCodCentremi = stConGen->iCodCentremi;
   lhNumSecuenci = stConGen->lNumSecuenci;
   ihCodConcepto = stConGen->iCodConcepto;
   ihCodProducto = stConGen->iCodProducto;

	fprintf( fArchLog,	"Entrada de Datos en bfnDBIntCarteraFA\n"
						"\tlhCodCliente  = [%d]\n"
						"\tihCodTipDocum = [%d]\n"
						"\tlhCodAgente   = [%d]\n"
						"\tszhLetra      = [%s]\n"
						"\tihCodCentremi = [%d]\n"
						"\tlhNumSecuenci = [%d]\n"
						"\tihCodConcepto = [%d]\n"
						"\tihCodProducto = [%d]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						lhCodAgente,
						szhLetra,
						ihCodCentremi,
						lhNumSecuenci,
						ihCodConcepto,
						ihCodProducto );

   bResul = bfnDBSecColFA( stConGen );

   if (!bResul)
   {
      fprintf( fArchLog, "ERROR en la Funcio bfnDBSecColFA, llamada por bfnDBIntCarteraFA\n" );
      return FALSE;
   }
   ihColumna = stConGen->iColumna;

   dhImporteDebe = stConGen->dImporteDebe;
   dhImporteHaber = stConGen->dImporteHaber;

   ihIndContado = stConGen->iIndContado;
   ihIndFacturado = stConGen->iIndFacturado;

   strcpy(szhFecEfectividad,stConGen->szFecEfectividad);

   if (strlen(stConGen->szFecVencimie) == 0)
   {
      strcpy(szhFecVencimie,"");
      shIndFecVencimie = ORA_NULL;
   }
   else
   {
      strcpy(szhFecVencimie,stConGen->szFecVencimie);
      shIndFecVencimie = 0;
   }

   if (strlen(stConGen->szFecCaducida) == 0)
   {
      strcpy(szhFecCaducida,"");
      shIndFecCaducida = ORA_NULL;
   }
   else
   {
      strcpy(szhFecCaducida,stConGen->szFecCaducida);
      shIndFecCaducida = 0;
   }

   if (strlen(stConGen->szFecAntiguedad) == 0)
   {
      strcpy(szhFecAntiguedad,"");
      shIndFecAntiguedad = ORA_NULL;
   }
   else
   {
      strcpy(szhFecAntiguedad,stConGen->szFecAntiguedad);
      shIndFecAntiguedad = 0;
   }

   if (strlen(stConGen->szFecPago) == 0)
   {
      strcpy(szhFecPago,"");
      shIndFecPago = ORA_NULL;
   }
   else
   {
      strcpy(szhFecPago,stConGen->szFecPago);
      shIndFecPago = 0;
   }

   if (stConGen->lNumAbonado == ORA_NULL)
   {
      lhNumAbonado = ORA_NULL;
      shIndNumAbonado = ORA_NULL;
   }
   else
   {
      shIndNumAbonado = 0;
      lhNumAbonado = stConGen->lNumAbonado;
   }
   if (stConGen->lNumFolio == ORA_NULL)
   {
      lhNumFolio = ORA_NULL;
      shIndNumFolio = ORA_NULL;
   }
   else
   {
      shIndNumFolio = 0;
      lhNumFolio = stConGen->lNumFolio;
   }
   if (stConGen->lNumCuota == ORA_NULL)
   {
      lhNumCuota = ORA_NULL;
      shIndNumCuota = ORA_NULL;
   }
   else
   {
      shIndNumCuota = 0;
      lhNumCuota = stConGen->lNumCuota;
   }
   if (stConGen->iSecCuota == ORA_NULL)
   {
      ihSecCuota = ORA_NULL;
      shIndSecCuota = ORA_NULL;
   }
   else
   {
      shIndSecCuota = 0;
      ihSecCuota = stConGen->iSecCuota;
   }
   if (stConGen->lNumTransa == ORA_NULL)
   {
      lhNumTransa = ORA_NULL;
      shIndNumTransa = ORA_NULL;
   }
   else
   {
      shIndNumTransa = 0;
      lhNumTransa = stConGen->lNumTransa;
   }
   if (stConGen->lNumVenta == ORA_NULL)
   {
      lhNumVenta = ORA_NULL;
      shIndNumVenta = ORA_NULL;
   }
   else
   {
      shIndNumVenta = 0;
      lhNumVenta = stConGen->lNumVenta;
   }

	strcpy(szhPrefPlaza,stConGen->szPrefPlaza);				/* jlr_11.01.03 */
	strcpy(szhCodOperadoraScl,stConGen->szCodOperadoraScl);	/* jlr_11.01.03 */
	strcpy(szhCodPlaza,stConGen->szCodPlaza);				/* jlr_11.01.03 */

	/* manejo de decimales segun la operadora local */
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

   /* EXEC SQL INSERT
   INTO CO_CARTERA
         (COD_CLIENTE   ,
         COD_TIPDOCUM  ,
         COD_VENDEDOR_AGENTE    ,
         LETRA         ,
         COD_CENTREMI  ,
         NUM_SECUENCI  ,
         COD_CONCEPTO  ,
         COLUMNA       ,
         COD_PRODUCTO  ,
         IMPORTE_DEBE  ,
         IMPORTE_HABER ,
         IND_CONTADO   ,
         IND_FACTURADO ,
         FEC_EFECTIVIDAD,
         FEC_VENCIMIE  ,
         FEC_CADUCIDA  ,
         FEC_ANTIGUEDAD,
         FEC_PAGO      ,
         NUM_ABONADO   ,
         NUM_FOLIO     ,
         NUM_CUOTA     ,
         SEC_CUOTA     ,
         NUM_TRANSACCION,
         NUM_VENTA     ,
		PREF_PLAZA         , /o jlr_11.01.03 o/
		COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
		COD_PLAZA          ) /o jlr_11.01.03 o/
   VALUES
         (:lhCodCliente,
         :ihCodTipDocum,
         :lhCodAgente  ,
         :szhLetra     ,
         :ihCodCentremi,
         :lhNumSecuenci,
         :ihCodConcepto,
         :ihColumna    ,
         :ihCodProducto,
         :dhImporteDebe,
         :dhImporteHaber,
         :ihIndContado ,
         :ihIndFacturado,
         TO_DATE(:szhFecEfectividad,'YYYYMMDD'),
         TO_DATE(:szhFecVencimie:shIndFecVencimie,'YYYYMMDD'),
         TO_DATE(:szhFecCaducida:shIndFecCaducida,'YYYYMMDD'),
         TO_DATE(:szhFecAntiguedad:shIndFecAntiguedad,'YYYYMMDD'),
         TO_DATE(:szhFecPago:shIndFecPago,'YYYYMMDD'),
         :lhNumAbonado:shIndNumAbonado,
         :lhNumFolio:shIndNumFolio,
         :lhNumCuota:shIndNumCuota,
         :ihSecCuota:shIndSecCuota,
         :lhNumTransa:shIndNumTransa,
         :lhNumVenta:shIndNumVenta,
         :szhPrefPlaza,		/o jlr_11.01.03 o/
         :szhCodOperadoraScl,/o jlr_11.01.03 o/
         :szhCodPlaza		/o jlr_11.01.03 o/
         ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 35;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_CARTERA (COD_CLIENTE,COD_TIPDOCUM,COD_VENDE\
DOR_AGENTE,LETRA,COD_CENTREMI,NUM_SECUENCI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,I\
MPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_VENCIM\
IE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NUM_FOLIO,NUM_CUOTA,SEC_CU\
OTA,NUM_TRANSACCION,NUM_VENTA,PREF_PLAZA,COD_OPERADORA_SCL,COD_PLAZA) values (\
:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12,TO_DATE(:b13,'YYYYMMDD'\
),TO_DATE(:b14:b15,'YYYYMMDD'),TO_DATE(:b16:b17,'YYYYMMDD'),TO_DATE(:b18:b19,'\
YYYYMMDD'),TO_DATE(:b20:b21,'YYYYMMDD'),:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b\
30:b31,:b32:b33,:b34,:b35,:b36)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1974;
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
   sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentremi;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&dhImporteDebe;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteHaber;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&ihIndContado;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihIndFacturado;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhFecEfectividad;
   sqlstm.sqhstl[13] = (unsigned long )9;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhFecVencimie;
   sqlstm.sqhstl[14] = (unsigned long )9;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)&shIndFecVencimie;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhFecCaducida;
   sqlstm.sqhstl[15] = (unsigned long )9;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&shIndFecCaducida;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhFecAntiguedad;
   sqlstm.sqhstl[16] = (unsigned long )9;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&shIndFecAntiguedad;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)szhFecPago;
   sqlstm.sqhstl[17] = (unsigned long )9;
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)&shIndFecPago;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)&shIndNumAbonado;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)&lhNumFolio;
   sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)&shIndNumFolio;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)&lhNumCuota;
   sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)&shIndNumCuota;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
   sqlstm.sqhstv[21] = (unsigned char  *)&ihSecCuota;
   sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[21] = (         int  )0;
   sqlstm.sqindv[21] = (         short *)&shIndSecCuota;
   sqlstm.sqinds[21] = (         int  )0;
   sqlstm.sqharm[21] = (unsigned long )0;
   sqlstm.sqadto[21] = (unsigned short )0;
   sqlstm.sqtdso[21] = (unsigned short )0;
   sqlstm.sqhstv[22] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[22] = (         int  )0;
   sqlstm.sqindv[22] = (         short *)&shIndNumTransa;
   sqlstm.sqinds[22] = (         int  )0;
   sqlstm.sqharm[22] = (unsigned long )0;
   sqlstm.sqadto[22] = (unsigned short )0;
   sqlstm.sqtdso[22] = (unsigned short )0;
   sqlstm.sqhstv[23] = (unsigned char  *)&lhNumVenta;
   sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[23] = (         int  )0;
   sqlstm.sqindv[23] = (         short *)&shIndNumVenta;
   sqlstm.sqinds[23] = (         int  )0;
   sqlstm.sqharm[23] = (unsigned long )0;
   sqlstm.sqadto[23] = (unsigned short )0;
   sqlstm.sqtdso[23] = (unsigned short )0;
   sqlstm.sqhstv[24] = (unsigned char  *)szhPrefPlaza;
   sqlstm.sqhstl[24] = (unsigned long )26;
   sqlstm.sqhsts[24] = (         int  )0;
   sqlstm.sqindv[24] = (         short *)0;
   sqlstm.sqinds[24] = (         int  )0;
   sqlstm.sqharm[24] = (unsigned long )0;
   sqlstm.sqadto[24] = (unsigned short )0;
   sqlstm.sqtdso[24] = (unsigned short )0;
   sqlstm.sqhstv[25] = (unsigned char  *)szhCodOperadoraScl;
   sqlstm.sqhstl[25] = (unsigned long )6;
   sqlstm.sqhsts[25] = (         int  )0;
   sqlstm.sqindv[25] = (         short *)0;
   sqlstm.sqinds[25] = (         int  )0;
   sqlstm.sqharm[25] = (unsigned long )0;
   sqlstm.sqadto[25] = (unsigned short )0;
   sqlstm.sqtdso[25] = (unsigned short )0;
   sqlstm.sqhstv[26] = (unsigned char  *)szhCodPlaza;
   sqlstm.sqhstl[26] = (unsigned long )6;
   sqlstm.sqhsts[26] = (         int  )0;
   sqlstm.sqindv[26] = (         short *)0;
   sqlstm.sqinds[26] = (         int  )0;
   sqlstm.sqharm[26] = (unsigned long )0;
   sqlstm.sqadto[26] = (unsigned short )0;
   sqlstm.sqtdso[26] = (unsigned short )0;
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
      fprintf(fArchLog,"Error al insertar en CO_CARTERA %s.\n",szfnORAerror());
      return FALSE;
   }
   return TRUE;

}/* Fin bfnDBIntCarteraFA() */

/*****************************************************************************/
BOOL bfnDBUpdCarteraFA(DATCON *stCon,long lCodCliente)
/**
Descripcion: Modifica el importe del concepto
Salida     : True, si todo va ok
             False, si se genera algun error
**/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int    ihCodTipDocum   ;
	long   lhCodAgente     ;
	char   *szhLetra       ; /* EXEC SQL VAR szhLetra     IS STRING(2); */ 

	int    ihCodCentrEmi   ;
	long   lhNumSecuenci   ;
	int    ihCodConcepto   ;
	int    ihColumna       ;
	char   *szhFecHistorico; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

	int    ihCodProducto   ;
	long   lhNumAbonado    ;
	double dhImporteHaber  ;
	double dhImporteDebe   ;
	long   lhCodCliente    ;
/* EXEC SQL END DECLARE SECTION; */ 

	
	fprintf( fArchLog, "En funcion bfnDBUpdCarteraFA().\n" );
	/* Prepara datos para "move" */
	lhCodCliente  = lCodCliente;
	ihCodTipDocum = stCon->iCodTipDocum;
	ihCodCentrEmi = stCon->iCodCentremi;
	lhNumSecuenci = stCon->lNumSecuenci;
	lhCodAgente   = stCon->lCodAgente ;
	szhLetra      = stCon->szLetra     ;
	ihCodConcepto = stCon->iCodConcepto;
	ihColumna     = stCon->iColumna;
	ihCodProducto = stCon->iCodProducto;
	lhNumAbonado  = stCon->lNumAbonado;
	dhImporteHaber= stCon->dImporteHaber;
	dhImporteDebe = stCon->dImporteDebe;
	
	/* manejo de decimales segun la operadora local */
	dhImporteDebe = fnCnvDouble( dhImporteDebe, 0 );
	dhImporteHaber = fnCnvDouble( dhImporteHaber, 0 );

	fprintf( fArchLog,	"Datos entrada bfnDBUpdCarteraFA.\n"
						"\tlhCodCliente   => [%d]\n"
						"\tihCodTipDocum  => [%d]\n"
						"\tihCodCentrEmi  => [%d]\n"
						"\tlhNumSecuenci  => [%d]\n"
						"\tlhCodAgente    => [%d]\n"
						"\tszhLetra       => [%s]\n"
						"\tihCodConcepto  => [%d]\n"
						"\tihColumna      => [%d]\n"
						"\tihCodProducto  => [%d]\n"
						"\tlhNumAbonado   => [%d]\n"
						"\tdhImporteHaber => [%.2f]\n"
						"\tdhImporteDebe  => [%.2f]\n\n",
						lhCodCliente,
						ihCodTipDocum,
						ihCodCentrEmi,
						lhNumSecuenci,
						lhCodAgente,
						szhLetra,
						ihCodConcepto,
						ihColumna,
						ihCodProducto,
						lhNumAbonado,
						dhImporteHaber,
						dhImporteDebe );

	/* Modificar de cartera el importe */
	/* EXEC SQL
	UPDATE	CO_CARTERA
	SET 	IMPORTE_HABER  = :dhImporteHaber,
			IMPORTE_DEBE   = :dhImporteDebe,
			FEC_PAGO       = SYSDATE
	WHERE 	COD_CLIENTE    = :lhCodCliente
	AND		COD_TIPDOCUM   = :ihCodTipDocum
	AND		COD_CENTREMI   = :ihCodCentrEmi
	AND		NUM_SECUENCI   = :lhNumSecuenci
	AND		COD_VENDEDOR_AGENTE     = :lhCodAgente
	AND		LETRA          = :szhLetra
	AND		COD_CONCEPTO   = :ihCodConcepto
	AND		COLUMNA        = :ihColumna
	AND		COD_PRODUCTO   = :ihCodProducto
	AND		NUM_ABONADO    = :lhNumAbonado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_CARTERA  set IMPORTE_HABER=:b0,IMPORTE_DEBE=:b1,FE\
C_PAGO=SYSDATE where (((((((((COD_CLIENTE=:b2 and COD_TIPDOCUM=:b3) and COD_CE\
NTREMI=:b4) and NUM_SECUENCI=:b5) and COD_VENDEDOR_AGENTE=:b6) and LETRA=:b7) \
and COD_CONCEPTO=:b8) and COLUMNA=:b9) and COD_PRODUCTO=:b10) and NUM_ABONADO=\
:b11)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2097;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhImporteHaber;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhImporteDebe;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[5] = (unsigned char  *)&lhNumSecuenci;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhCodAgente;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhLetra;
 sqlstm.sqhstl[7] = (unsigned long )2;
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
 sqlstm.sqhstv[10] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&lhNumAbonado;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
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


	
	if( sqlca.sqlcode != 0 )
	{
		fprintf(fArchLog,"* Error en update co_cartera %s\n",szfnORAerror());
		return FALSE;
	}
	return TRUE;
} /* Fin bfnDBUpdCarteraFA() */


/*****************************************************************************/
BOOL bfnDBObtConCreFA( int *iCodConcepto )
/*	
	Descripcion	:	Obtener el codigo de concepto credito
	Salida     	: 	True, si todo va ok
					False, si se genera algun error
*/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int    ihCodConcepto   ;
	int    ihValor_uno  = 1;
/* EXEC SQL END DECLARE SECTION; */ 

	
	fprintf( fArchLog, "En funcion bfnDBObtConCreFA().\n" );
	/* Obtener el concepto abono */
	/* EXEC SQL
	SELECT A.COD_CONCEPTO
	INTO  :ihCodConcepto
	FROM  CO_CONCEPTOS A, CO_TIPCONCEP B
	WHERE A.COD_TIPCONCE = B.COD_TIPCONCE
	AND   B.IND_ABONO = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 35;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.COD_CONCEPTO into :b0  from CO_CONCEPTOS A ,CO_TIPC\
ONCEP B where (A.COD_TIPCONCE=B.COD_TIPCONCE and B.IND_ABONO=:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2160;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
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


	
	if( sqlca.sqlcode != 0 )
	{
		fprintf( fArchLog, "Error al obtener el concepto abono %s.\n", szfnORAerror() );
		return FALSE;
	}
	
	*iCodConcepto = ihCodConcepto;
	iConceptoCredito = ihCodConcepto;
	return TRUE;
} /* Fin bfnDBObtConCreFA() */
/*****************************************************************************/



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

