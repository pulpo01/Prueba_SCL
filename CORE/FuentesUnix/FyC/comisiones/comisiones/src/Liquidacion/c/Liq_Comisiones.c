
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/Liq_Comisiones.pc"
};


static unsigned int sqlctx = 221490051;


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

 static char *sq0002 = 
"select A.COD_TIPORED ,A.COD_PLANCOMIS ,A.COD_CONCEPTO ,B.NIV_CRITICO ,B.COD_\
OPERADOR  from CM_CONCEPTOSTIPORED_TD A ,CM_PLANESCONCEPTOS_TD B ,CM_PLANESCOM\
IS_TD C where (((((A.COD_PLANCOMIS=C.COD_PLANCOMIS and C.TIP_CICLCOMIS=:b0) an\
d ((C.TIP_CICLCOMIS=:b1 and ID_CICLCOMIS=:b2) or C.TIP_CICLCOMIS=:b3)) and A.C\
OD_PLANCOMIS=B.COD_PLANCOMIS) and A.COD_CONCEPTO=B.COD_CONCEPTO) and B.IND_CRI\
TICO='S')           ";

 static char *sq0003 = 
"select distinct D.COD_TIPORED ,E.COD_TIPCOMIS ,G.COD_VENDEDOR ,NVL(G.COD_CLI\
ENTE,0) ,G.COD_OFICINA ,D.IND_APLIC_SUBORDINADA  from VE_TIPORED_TD D ,CM_PLAN\
ESTIPORED_TD F ,CM_PLANESCOMIS_TD H ,CM_CONCEPTOSTIPORED_TD B ,VE_DETALLE_TIPO\
RED_TD E ,VE_VENDEDORES G where ((((((((D.COD_CICLOCOMIS=:b0 and D.COD_TIPORED\
=F.COD_TIPORED) and F.COD_PLANCOMIS=H.COD_PLANCOMIS) and H.TIP_CICLCOMIS=:b1) \
and D.COD_TIPORED=B.COD_TIPORED) and F.COD_PLANCOMIS=B.COD_PLANCOMIS) and B.CO\
D_TIPORED=E.COD_TIPORED) and B.NIV_APLICACION=E.NUM_NIVEL) and E.COD_TIPCOMIS=\
G.COD_TIPCOMIS) order by G.COD_VENDEDOR            ";

 static char *sq0004 = 
"select distinct D.COD_TIPORED ,E.COD_TIPCOMIS ,G.COD_VENDEDOR ,NVL(G.COD_CLI\
ENTE,:b0) ,G.COD_OFICINA ,D.IND_APLIC_SUBORDINADA  from VE_TIPORED_TD D ,CM_PL\
ANESTIPORED_TD F ,CM_PLANESCOMIS_TD H ,CM_CONCEPTOSTIPORED_TD B ,VE_DETALLE_TI\
PORED_TD E ,VE_VENDEDORES G where ((((((((H.TIP_CICLCOMIS=:b1 and H.ID_CICLCOM\
IS=:b2) and H.COD_PLANCOMIS=F.COD_PLANCOMIS) and F.COD_TIPORED=D.COD_TIPORED) \
and D.COD_TIPORED=B.COD_TIPORED) and F.COD_PLANCOMIS=B.COD_PLANCOMIS) and B.CO\
D_TIPORED=E.COD_TIPORED) and B.NIV_APLICACION=E.NUM_NIVEL) and E.COD_TIPCOMIS=\
G.COD_TIPCOMIS) order by G.COD_VENDEDOR            ";

 static char *sq0005 = 
"select NUM_AJUSTE ,IMP_CONCEPTO  from CMT_AJUSTES_COMISIONES where (((COD_TI\
PORED=:b0 and ID_PERIODO=:b1) and COD_COMISIONISTA=:b2) and COD_ESTADO='ING') \
          ";

 static char *sq0006 = 
"select A.NUM_ANTICIPO ,A.IMP_ANTICIPO  from CMT_ANTICIPOS A where (((A.COD_T\
IPORED=:b0 and A.COD_COMISIONISTA=:b1) and A.ID_PERIODO_LIQ=:b2) and A.COD_EST\
ADO_LIQ='ING')           ";

 static char *sq0007 = 
"select A.COD_CONCEPTO ,NUM_LOGRO ,NUM_REGISTROS ,A.IMP_CONCEPTO ,B.TIP_CONCE\
PTO ,B.COD_UNIVERSO ,B.TIP_CALCULO ,C.NIV_SELECCION ,C.NIV_APLICACION  from CM\
T_ACUMULADOS A ,CMD_CONCEPTOS B ,CM_CONCEPTOSTIPORED_TD C where (((((A.COD_TIP\
ORED=:b0 and A.COD_COMISIONISTA=:b1) and A.ID_PERIODO=:b2) and A.COD_CONCEPTO=\
B.COD_CONCEPTO) and A.COD_TIPORED=C.COD_TIPORED) and A.COD_CONCEPTO=C.COD_CONC\
EPTO)           ";

 static char *sq0023 = 
"select C.COD_TIPCOMIS ,A.COD_VENDEDOR ,C.COD_CLIENTE ,C.COD_OFICINA  from VE\
_REDVENTAS_TD A ,VE_VENDEDORES C where (((A.COD_TIPORED=:b0 and A.COD_VENDE_PA\
DRE=:b1) and A.COD_VENDEDOR=C.COD_VENDEDOR) and A.COD_VENDEDOR<>A.COD_VENDE_PA\
DRE)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,0,0,31,56,0,0,0,0,0,1,0,
20,0,0,2,408,0,9,119,0,0,4,4,0,1,0,1,1,0,0,1,1,0,0,1,97,0,0,1,1,0,0,
51,0,0,2,0,0,13,122,0,0,5,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,4,0,0,2,97,0,0,
86,0,0,2,0,0,15,146,0,0,0,0,0,1,0,
101,0,0,3,595,0,9,342,0,0,2,2,0,1,0,1,3,0,0,1,1,0,0,
124,0,0,3,0,0,13,345,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,
97,0,0,
163,0,0,3,0,0,15,384,0,0,0,0,0,1,0,
178,0,0,4,595,0,9,457,0,0,3,3,0,1,0,1,3,0,0,1,1,0,0,1,97,0,0,
205,0,0,4,0,0,13,460,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,
97,0,0,
244,0,0,4,0,0,15,495,0,0,0,0,0,1,0,
259,0,0,5,164,0,9,545,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
286,0,0,5,0,0,13,548,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
309,0,0,5,0,0,15,574,0,0,0,0,0,1,0,
324,0,0,6,179,0,9,623,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
351,0,0,6,0,0,13,626,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
374,0,0,6,0,0,15,653,0,0,0,0,0,1,0,
389,0,0,7,404,0,9,720,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
416,0,0,7,0,0,13,723,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,
467,0,0,7,0,0,15,752,0,0,0,0,0,1,0,
482,0,0,8,297,0,3,922,0,0,14,14,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,4,0,0,1,4,0,0,
1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,1,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
553,0,0,9,72,0,5,961,0,0,1,1,0,1,0,1,3,0,0,
572,0,0,10,69,0,5,969,0,0,1,1,0,1,0,1,3,0,0,
591,0,0,11,71,0,4,999,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
614,0,0,12,74,0,4,1006,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
637,0,0,13,51,0,4,1053,0,0,1,0,0,1,0,2,3,0,0,
656,0,0,14,91,0,4,1057,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
679,0,0,15,233,0,3,1063,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,
1,3,0,0,
718,0,0,16,0,0,29,1072,0,0,0,0,0,1,0,
733,0,0,17,169,0,6,1083,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,3,97,0,0,3,97,0,
0,3,97,0,0,3,97,0,0,3,97,0,0,3,97,0,0,
784,0,0,18,0,0,29,1098,0,0,0,0,0,1,0,
799,0,0,19,145,0,4,1102,0,0,2,1,0,1,0,2,4,0,0,1,3,0,0,
822,0,0,20,125,0,4,1125,0,0,1,0,0,1,0,2,3,0,0,
841,0,0,21,125,0,4,1134,0,0,1,0,0,1,0,2,3,0,0,
860,0,0,22,206,0,4,1249,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
887,0,0,23,247,0,9,1276,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
910,0,0,23,0,0,13,1279,0,0,4,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
941,0,0,23,0,0,15,1314,0,0,0,0,0,1,0,
956,0,0,24,0,0,17,1431,0,0,1,1,0,1,0,1,97,0,0,
975,0,0,24,0,0,45,1435,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1006,0,0,24,0,0,13,1437,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
1029,0,0,24,0,0,15,1439,0,0,0,0,0,1,0,
1044,0,0,25,48,0,1,1773,0,0,0,0,0,1,0,
1059,0,0,26,0,0,30,1903,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de generar liquidaciones de comisionistas         */
/*----------------------------------------------------------------------*/
/* Version 2 - Revision 00.                                             */
/* Inicio: Viernes 5 de Julio de 2002 .                                 */
/* Fin:                                                                 */
/* Autor : Nelson Contreras Helena                                      */
/************************************************************************/
/*---------------------------------------------------------------------------*/
/* Modificacion por PGonzaleg                                                */
/* Inicio: Lunes 2 de diciembre de 2002.                                     */
/* Fin:    Lunes 2 de diciembre de 2002.                                     */
/* Autor : Patricio Gonzalez Gomez                                           */
/* Modificacion de condiciones en los WHERE referentes a la tabla            */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y          */
/* COD_PARAMETRO.                                                            */
/*---------------------------------------------------------------------------*/
/* Modificacion por Fabian Aedo R.                                           */
/* Se optimiza el uso de punteros y consultas SQL....                        */
/* Enero - 2003. Version Aranjuez.                                           */
/*---------------------------------------------------------------------------*/
/* Modificacion por Fabian Aedo R.                                           */
/* Se incorporan mejoras de versión Cuzco-2003                               */
/* Se incorpora menejo de conceptos críticos                                 */
/* Se incorpora manejo de nueva estructura de red de ventas                  */
/* Se reconstruyen funcionalidades de repartición de comisiones, en funcion  */
/*    de lo generado por cada uno de los hijos receptores (o sus hijos...)   */
/*---------------------------------------------------------------------------*/
/* Inclusion de librería para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Liq_Comisiones.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError_2(); */ 


/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 
     
char    szhUser[30]="";         
char    szhPass[30]="";         
char    szhSysDate[17]="";        
char    szFechaYYYYMMDD[9]="";  
/* EXEC SQL END DECLARE SECTION; */ 
      
/*---------------------------------------------------------------------------*/
/* RUTINA PARA MANEJO DE MENSAJES DE ERRORES ORACLE. TEMPORAL                */
/*---------------------------------------------------------------------------*/
void vSqlError_2( void )                                                                              
{                                                                                                     
    if (!iPl)                                                                                         
    {                                                                                                             
       /* EXEC SQL ROLLBACK WORK; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 0;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )5;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
       if (sqlca.sqlcode < 0) vSqlError_2();
}

                                                                       
       fprintf(stderr,"\n\nERROR ORACLE: Se Cierra Traza de Procesos.");  
       fprintf(stderr,"[%d] [%s]\n\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);                       
       exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,-1,sqlca.sqlerrm.sqlerrmc,0,0));          
    }                                                                                                 
}                                                                                                                                                                                                            
/*---------------------------------------------------------------------------*/
/* Crea el universo de comisiones / bonos en la lista de universo.           */
/*---------------------------------------------------------------------------*/
void vCreaConceptosCriticos()      
{     
    stCriticos  * paux;
    
    long		lCantRegistros=0;
    int         i;
    short       iLastRows     = 0;
    int         iFetchedRows  = MAXFETCH;
    int         iRetrievRows  = MAXFETCH;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed		[MAXFETCH];
	    char	szhCodPlanComis		[MAXFETCH][7];
	    int     lhCodConcepto    	[MAXFETCH];
	    double  dhNivCritico    	[MAXFETCH];
	    char	chCodOperador		[MAXFETCH][2];
	    
	    char	cPeriodico;
	    char	cEsporadico;
	    char	chTipCiclComis;
	    char	szhIdCiclComis[11];
	    long    lMaxFetch;      
    /* EXEC SQL END DECLARE SECTION; */ 

        
    lMaxFetch = MAXFETCH;
    paux      = NULL;

	chTipCiclComis       = stCiclo.cTipCiclComis;
	strcpy(szhIdCiclComis, stCiclo.szIdCiclComis);
	
	cPeriodico  = PERIODICO;
	cEsporadico = ESPORADICO;
    
    fprintf(pfLog ,"\n[vCreaConceptosCriticos]Carga Conceptos de Comisiones Criticos para el Periodo.\n");
    fprintf(stderr,"\n[vCreaConceptosCriticos]Carga Conceptos de Comisiones Criticos para el Periodo.\n");
    
    /* EXEC SQL DECLARE CUR_UNIVERSO_CRITICOS CURSOR FOR SELECT          
			   A.COD_TIPORED,
			   A.COD_PLANCOMIS,
			   A.COD_CONCEPTO,
			   B.NIV_CRITICO,
			   B.COD_OPERADOR
		FROM CM_CONCEPTOSTIPORED_TD A,
			 CM_PLANESCONCEPTOS_TD B,
			 CM_PLANESCOMIS_TD C
		WHERE A.COD_PLANCOMIS 	= C.COD_PLANCOMIS
		AND C.TIP_CICLCOMIS 	= :chTipCiclComis
		AND ((C.TIP_CICLCOMIS 	= :cEsporadico 
			  AND ID_CICLCOMIS 	= :szhIdCiclComis) OR
			 (C.TIP_CICLCOMIS 	= :cPeriodico))
		AND A.COD_PLANCOMIS 	= B.COD_PLANCOMIS
		AND A.COD_CONCEPTO 		= B.COD_CONCEPTO
		AND B.IND_CRITICO 		= 'S'; */ 

                   
    /* EXEC SQL OPEN CUR_UNIVERSO_CRITICOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )20;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&chTipCiclComis;
    sqlstm.sqhstl[0] = (unsigned long )1;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&cEsporadico;
    sqlstm.sqhstl[1] = (unsigned long )1;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdCiclComis;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&cPeriodico;
    sqlstm.sqhstl[3] = (unsigned long )1;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch FETCH  CUR_UNIVERSO_CRITICOS INTO   
			:ihCodTipoRed, :szhCodPlanComis, :lhCodConcepto, 
			:dhNivCritico   , :chCodOperador; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )51;
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
        sqlstm.sqhstl[1] = (unsigned long )7;
        sqlstm.sqhsts[1] = (         int  )7;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)lhCodConcepto;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)dhNivCritico;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[3] = (         int  )sizeof(double);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)chCodOperador;
        sqlstm.sqhstl[4] = (unsigned long )2;
        sqlstm.sqhsts[4] = (         int  )2;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
            
            paux = (stCriticos *) malloc(sizeof(stCriticos));

			strcpy(paux->szCodPlanComis	, szfnTrim(szhCodPlanComis[i]));
			strcpy(paux->cCodOperador	, szfnTrim(chCodOperador[i]));
			paux->iCodTipoRed			= ihCodTipoRed[i];
			paux->lCodConcepto   		= lhCodConcepto[i];
			paux->dNivCritico    		= dhNivCritico[i];
			fprintf(pfLog ,"[vCreaConceptosCriticos] TR:[%d] PlCom:[%s] Conc:[%d] OP:[%s] Nivel:[%5.2f]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->lCodConcepto, paux->cCodOperador, paux->dNivCritico);
			fprintf(stderr,"[vCreaConceptosCriticos] TR:[%d] PlCom:[%s] Conc:[%d] OP:[%s] Nivel:[%5.2f]\n",paux->iCodTipoRed, paux->szCodPlanComis, paux->lCodConcepto, paux->cCodOperador, paux->dNivCritico);
            paux->sgte 					= lstCriticos;
            lstCriticos 				= paux;
            lCantRegistros++;
        }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO_CRITICOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )86;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    
    fprintf(stderr,"\n[vCreaConceptosCriticos]Cantidad de conceptos Criticos Recuperados:[%d]\n",lCantRegistros);
    fprintf(pfLog ,"\n[vCreaConceptosCriticos]Cantidad de conceptos Criticos Recuperados:[%d]\n",lCantRegistros);
}
/*---------------------------------------------------------------------------*/
/* Busca en la lista de conceptos criticos, la ocurrencia del par            */
/* Tipo de Red - Concepto, que se recibe.                                    */
/* La evaluación no incluye diferenciación por tipo de comisionista.         */
/*---------------------------------------------------------------------------*/
stCriticos * stFndCriticos(int piTipoRed, long piConcepto, stCriticos * paux)
{
	if (paux == NULL)
		return NULL;
	if ((paux->iCodTipoRed == piTipoRed)&&(paux->lCodConcepto==piConcepto))
		return paux;
	return stFndCriticos(piTipoRed, piConcepto, paux->sgte);
}
/*---------------------------------------------------------------------------*/
/* Eecuta la comparacion lógica del nivel de cumplimiento con la exigencia   */
/* del nivel critico establecido.                                            */
/*---------------------------------------------------------------------------*/
int bEvaluaCumplimiento(long lNumRegistros, char * cCodOperador, double dNivCritico)
{
	if (strcmp(cCodOperador,"1" )==0) 
		return (lNumRegistros == (long)dNivCritico );
	if (strcmp(cCodOperador,"2" )==0) 
		return (lNumRegistros >  (long)dNivCritico );
	if (strcmp(cCodOperador,"3" )==0) 
		return (lNumRegistros >= (long)dNivCritico );
	if (strcmp(cCodOperador,"4" )==0) 
		return (lNumRegistros <  (long)dNivCritico );
	if (strcmp(cCodOperador,"5" )==0) 
		return (lNumRegistros <= (long)dNivCritico );
	if (strcmp(cCodOperador,"6" )==0) 
		return (lNumRegistros != (long)dNivCritico );
	return (FALSE);
}
/*---------------------------------------------------------------------------*/
/* Marca la estructura de ventas para el tipo de red y vendedor, con         */
/* indicador de cumplimiento en 'N'...                                       */
/*---------------------------------------------------------------------------*/
void vMarcaTipoRed(int iCodTipoRed, long lCodVendedor)
{
	stRedVentas 	* lstRedVentas 	= NULL;
	stUniverso 		* paux 			= NULL;
	stRedVentas 	* qaux 			= NULL;
	long			lCodComisPadre;
	
	/*primero, crear la lista de comisionistas pertenecientes a la estructura a modificar...*/
	
	if ((lCodComisPadre = lGetVendedorPadre(iCodTipoRed, lCodVendedor ))!=0)
	{
		lstRedVentas = stCreaRedVentas(iCodTipoRed, lCodVendedor);
		for (qaux = lstRedVentas; qaux != NULL; qaux = qaux->sgte)
		{
			/* Para cada registro de la red de ventas, verifica si tiene liquidación */
			/* y lo marca con el indicador en 'S' según corresponde.                 */
			
			for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
			{
				if ((qaux->iCodTipoRed == paux->iCodTipoRed)&&(qaux->lCodVendedor == paux->lCodComisionista))
				{
					paux->cIndCumplimiento = 'N';
					fprintf(pfLog, "\n\t[vMarcaTipoRed] Marcado Vendedor:[%d]. No Cumple Nivel Critico.\n  ",paux->lCodComisionista);
				}
			}
		}
	}
	/* Al salir, libera la lista de Red de Ventas, para ser recreada con otro caso... */
	vLiberaRedVentas(lstRedVentas);
}
/*---------------------------------------------------------------------------*/
/* Evalua la aplicación de conceptos crítico sobre las liquidaciones.        */
/*---------------------------------------------------------------------------*/
void vEvaluaCriticos()
{
    stUniverso	* paux;
    stConceptos	* qaux;
    stCriticos	* raux;
   
    for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
    {
    	for (qaux = paux->sgte_concepto; qaux != NULL; qaux = qaux->sgte)
    	{
    		raux = stFndCriticos(paux->iCodTipoRed, qaux->lCodConcepto, lstCriticos);
    		if (raux!=NULL)
    		{
    			if (strcmp(qaux->cTipCalculo ,TIPCALMETA)!=0)
    			{
				    if (!(bEvaluaCumplimiento(qaux->lNumRegistros, raux->cCodOperador,raux->dNivCritico)))
				    {
						vMarcaTipoRed(paux->iCodTipoRed, paux->lCodComisionista);
					}
    			}
    			if (strcmp(qaux->cTipCalculo ,TIPCALMETA)==0)
    			{
					if (!(bEvaluaCumplimiento(qaux->lNumLogro, raux->cCodOperador,raux->dNivCritico)))
					{
						vMarcaTipoRed(paux->iCodTipoRed, paux->lCodComisionista);
					}
    			}
    		}
    	}	
	}
}
/*---------------------------------------------------------------------------*/
/* FUNCIÓN QUE BUSCA UN COMISIONISTA EN LA LISTA PRINCIPAL                   */
/*---------------------------------------------------------------------------*/
stUniverso * stfnFindComisionista(int iCodTipoRed, long plCodComisionista, stUniverso * paux)
{
    if (paux==NULL)
		return (NULL);
            
    if ((paux->lCodComisionista == plCodComisionista)&&(paux->iCodTipoRed == iCodTipoRed)&&(paux->cIndConsidera == 'S'))
		return (paux);
    return (stfnFindComisionista(iCodTipoRed, plCodComisionista, paux->sgte));
}
/*---------------------------------------------------------------------------*/
/* FUNCION QUE BUSCA UN CONCEPTO EN UNA LISTA DE CONCEPTOS...                */
/*---------------------------------------------------------------------------*/
stConceptos * stfnFindConcepto(long lCodConcepto, stConceptos * paux)
{
    if (paux==NULL)
		return (NULL);
	if ((paux->lCodConcepto == lCodConcepto)&&(paux->cIndConsidera == 'S'))
		return paux;
	return (stfnFindConcepto(lCodConcepto, paux->sgte));   	
}
/*---------------------------------------------------------------------------*/
/* Crea el universo de comisionistas a liquidar para Ciclo Periodico         */
/*---------------------------------------------------------------------------*/
stUniverso * stCreaUniversoPeriodico()      
{     
    stUniverso  * paux;
    stUniverso  * qaux;

    long		lCantRegistros  =0;
    int         i;
    short       iLastRows       = 0;
    int         iFetchedRows    = MAXFETCH;
    int         iRetrievRows    = MAXFETCH;
    int 		NroComisionistas= 0;
    
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed			[MAXFETCH];
	    char    szhCodTipComis       	[MAXFETCH][3];
	    long    lhCodComisionista		[MAXFETCH];
	    long    lhCodCliente     		[MAXFETCH];
	    char    szhCodOficina    		[MAXFETCH][3];
	    char	szhIndAplicSubordinada 	[MAXFETCH][2];
	    long	lhClienteGenerico;
	    long    lhCodPeriodo;
	    char    szhIdPeriodo[11];
	    long	lhCodCiclo;
	    char	chTipCiclComis;
	    long    lMaxFetch;      
    /* EXEC SQL END DECLARE SECTION; */ 

        
    strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
    lhCodPeriodo 		= stCiclo.lCodCiclComis;
    lhCodCiclo   		= stCiclo.lCodCiclo;
    chTipCiclComis 		= stCiclo.cTipCiclComis;
	lhClienteGenerico	= lClienteGenerico;

    lMaxFetch           = MAXFETCH;
    paux 				= NULL;
    qaux 				= NULL;

    fprintf(pfLog ,"[stCreaUniversoPeriodico]Carga Detalle de Comisionistas a Liquidar.\n");
    fprintf(stderr,"[stCreaUniversoPeriodico]Carga Detalle de Comisionistas a Liquidar.\n");
    
    /* EXEC SQL DECLARE CUR_UNIVERSO_PERIODICO CURSOR FOR SELECT DISTINCT
            D.COD_TIPORED,
            E.COD_TIPCOMIS,
            G.COD_VENDEDOR,
            NVL(G.COD_CLIENTE, 0),
            G.COD_OFICINA,
            D.IND_APLIC_SUBORDINADA
        FROM 	VE_TIPORED_TD 			D,
        		CM_PLANESTIPORED_TD 	F,
        		CM_PLANESCOMIS_TD 		H,
        		CM_CONCEPTOSTIPORED_TD  B,
        		VE_DETALLE_TIPORED_TD 	E,
        		VE_VENDEDORES 			G
        WHERE	D.COD_CICLOCOMIS 	= :lhCodCiclo
          AND 	D.COD_TIPORED 		= F.COD_TIPORED
          AND 	F.COD_PLANCOMIS 	= H.COD_PLANCOMIS
          AND	H.TIP_CICLCOMIS 	= :chTipCiclComis
          AND	D.COD_TIPORED 		= B.COD_TIPORED
          AND 	F.COD_PLANCOMIS 	= B.COD_PLANCOMIS
          AND 	B.COD_TIPORED		= E.COD_TIPORED
          AND 	B.NIV_APLICACION	= E.NUM_NIVEL
          AND 	E.COD_TIPCOMIS 		= G.COD_TIPCOMIS
        ORDER BY G.COD_VENDEDOR; */ 
                
    
    /* EXEC SQL OPEN CUR_UNIVERSO_PERIODICO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )101;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&chTipCiclComis;
    sqlstm.sqhstl[1] = (unsigned long )1;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for    :lMaxFetch FETCH  CUR_UNIVERSO_PERIODICO INTO   
        	:ihCodTipoRed,  :szhCodTipComis, :lhCodComisionista,
			:lhCodCliente,  :szhCodOficina,  :szhIndAplicSubordinada; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )124;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )3;
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
        sqlstm.sqhstv[3] = (unsigned char  *)lhCodCliente;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )sizeof(long);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )3;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhIndAplicSubordinada;
        sqlstm.sqhstl[5] = (unsigned long )2;
        sqlstm.sqhsts[5] = (         int  )2;
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
        
        for (i=0; i < iRetrievRows; i++)
        {
		    paux = (stUniverso *) malloc(sizeof(stUniverso));
			paux->iCodTipoRed			       	= ihCodTipoRed[i];
		    paux->lCodComisionista             	= lhCodComisionista[i];   
		    strcpy(paux->szTipComis		       	, szfnTrim(szhCodTipComis[i]));   
		    strcpy(paux->szCodOficina          	, szfnTrim(szhCodOficina[i]));    
		    strcpy(paux->szIndAplicSubordinada	, szfnTrim(szhIndAplicSubordinada[i]));

		    if (lhCodCliente[i] == 0)
		    	paux->lCodCliente           = lhClienteGenerico;                        
			else
				paux->lCodCliente           = lhCodCliente[i];                        

		    paux->dAcumComisiones 		= 0.00;
		    paux->dAcumAjustes 			= 0.00;
		    paux->dAcumAnticipos 		= 0.00;
		    paux->dAcumPenaliza 		= 0.00;
		    paux->dValorNeto 			= 0.00;
		    paux->dValorImpuesto 		= 0.00;
		    paux->dValorTotal 			= 0.00;
		    paux->cIndCumplimiento		= 'S';
		    paux->cIndConsidera         = 'S';
		    paux->sgte_concepto 		= NULL;
		    paux->sgte_anticipo 		= NULL;
		    paux->sgte_ajuste 			= NULL;
		    
		    paux->sgte 					= qaux;
		    qaux						= paux;
		    lCantRegistros++;
        }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO_PERIODICO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )163;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    
    fprintf(stderr,"[stCreaUniversoPeriodico]Cantidad Comisionistas a Liquidar en Periodo:[%s] ==>[%d]\n",szhIdPeriodo, lCantRegistros);
    fprintf(pfLog ,"[stCreaUniversoPeriodico]Cantidad Comisionistas a Liquidar en Periodo:[%s] ==>[%d]\n",szhIdPeriodo, lCantRegistros);
	stStatusProc.lComisiones = lCantRegistros;
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* Crea el universo de comisionistas a liquidar para Ciclo Periodico         */
/*---------------------------------------------------------------------------*/
stUniverso * stCreaUniversoEsporadico()      
{     
    stUniverso  * paux;
    stUniverso  * qaux;

    long		lCantRegistros= 0;
    int         i;
    short       iLastRows     = 0;
    int         iFetchedRows  = MAXFETCH;
    int         iRetrievRows  = MAXFETCH;
    
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCodTipoRed			[MAXFETCH];
	    char    szhCodTipComis       	[MAXFETCH][3];
	    long    lhCodComisionista		[MAXFETCH];
	    long    lhCodCliente     		[MAXFETCH];
	    char    szhCodOficina    		[MAXFETCH][3];
	    char	szhIndAplicSubordinada	[MAXFETCH][2];
	    long	lhClienteGenerico;
	    long    lhCodPeriodo;
	    char    szhIdPeriodo[11];
	    long	lhCodCiclo;
	    char	chTipCiclComis;
	    long    lMaxFetch;      
    /* EXEC SQL END DECLARE SECTION; */ 

        
    strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
    lhCodPeriodo 		= stCiclo.lCodCiclComis;
    lhCodCiclo   		= stCiclo.lCodCiclo;
    chTipCiclComis 		= stCiclo.cTipCiclComis;
    lhClienteGenerico	= lClienteGenerico;

    lMaxFetch           = MAXFETCH;
    paux 				= NULL;
    qaux 				= NULL;

    fprintf(pfLog ,"[stCreaUniversoEsporadico]Carga Detalle de Comisionistas a Liquidar.\n");
    fprintf(stderr,"[stCreaUniversoEsporadico]Carga Detalle de Comisionistas a Liquidar.\n");
    
    /* EXEC SQL DECLARE CUR_UNIVERSO_ESPORADICO CURSOR FOR SELECT DISTINCT
            D.COD_TIPORED,
            E.COD_TIPCOMIS,
            G.COD_VENDEDOR,
            NVL(G.COD_CLIENTE,:lhClienteGenerico), 
            G.COD_OFICINA,
            D.IND_APLIC_SUBORDINADA
        FROM 	VE_TIPORED_TD 			D,
        		CM_PLANESTIPORED_TD 	F,
        		CM_PLANESCOMIS_TD 		H,
        		CM_CONCEPTOSTIPORED_TD  B,
        		VE_DETALLE_TIPORED_TD 	E,
        		VE_VENDEDORES 			G
        WHERE	H.TIP_CICLCOMIS 	= :chTipCiclComis
          AND	H.ID_CICLCOMIS 		= :szhIdPeriodo
          AND 	H.COD_PLANCOMIS 	= F.COD_PLANCOMIS
          AND	F.COD_TIPORED 		= D.COD_TIPORED
          AND	D.COD_TIPORED 		= B.COD_TIPORED
          AND 	F.COD_PLANCOMIS 	= B.COD_PLANCOMIS
          AND 	B.COD_TIPORED		= E.COD_TIPORED
          AND 	B.NIV_APLICACION	= E.NUM_NIVEL
          AND 	E.COD_TIPCOMIS 		= G.COD_TIPCOMIS
        ORDER BY G.COD_VENDEDOR; */ 
                
                   
    /* EXEC SQL OPEN CUR_UNIVERSO_ESPORADICO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )178;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhClienteGenerico;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&chTipCiclComis;
    sqlstm.sqhstl[1] = (unsigned long )1;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for    :lMaxFetch FETCH  CUR_UNIVERSO_ESPORADICO INTO   
        	:ihCodTipoRed,  :szhCodTipComis, :lhCodComisionista,
			:lhCodCliente,  :szhCodOficina,  :szhIndAplicSubordinada; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )205;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipComis;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )3;
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
        sqlstm.sqhstv[3] = (unsigned char  *)lhCodCliente;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )sizeof(long);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )3;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhIndAplicSubordinada;
        sqlstm.sqhstl[5] = (unsigned long )2;
        sqlstm.sqhsts[5] = (         int  )2;
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
        
        for (i=0; i < iRetrievRows; i++)
        {
		    paux = (stUniverso *) malloc(sizeof(stUniverso));
		    strcpy(paux->szTipComis		        , szfnTrim(szhCodTipComis[i]));   
		    strcpy(paux->szCodOficina           , szfnTrim(szhCodOficina[i]));    
		    strcpy(paux->szIndAplicSubordinada  , szfnTrim(szhIndAplicSubordinada[i]));		    
		    
		    paux->iCodTipoRed			= ihCodTipoRed[i];
		    paux->lCodComisionista      = lhCodComisionista[i];   
		    paux->lCodCliente           = lhCodCliente[i];                        
		    paux->dAcumComisiones 		= 0.00;
		    paux->dAcumAjustes 			= 0.00;
		    paux->dAcumAnticipos 		= 0.00;
		    paux->dAcumPenaliza 		= 0.00;
		    paux->dValorNeto 			= 0.00;
		    paux->dValorImpuesto 		= 0.00;
		    paux->dValorTotal 			= 0.00;
		    paux->cIndCumplimiento		= 'S';
		    paux->cIndConsidera         = 'S';
		    paux->sgte_concepto 		= NULL;
		    paux->sgte_anticipo 		= NULL;
		    paux->sgte_ajuste 			= NULL;
		    
		    paux->sgte 					= qaux;
		    qaux						= paux;
		    lCantRegistros++;
        }
    }
    /* EXEC SQL CLOSE CUR_UNIVERSO_ESPORADICO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )244;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    
    fprintf(stderr,"[stCreaUniversoEsporadico]Cantidad Comisionistas a Liquidar en Periodo:[%s] ==>[%d]\n",szhIdPeriodo, lCantRegistros);
    fprintf(pfLog ,"[stCreaUniversoEsporadico]Cantidad Comisionistas a Liquidar en Periodo:[%s] ==>[%d]\n",szhIdPeriodo, lCantRegistros);
	stStatusProc.lComisiones = lCantRegistros;
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* Recupra los Ajustes de Cada Comisionista, para el periodo en proceso.     */
/*---------------------------------------------------------------------------*/
stConceptos * stCargaAjustes(int iTipoRed, long lComisionista)      
{     
    stConceptos	* paux;
    stConceptos	* qaux;
        
    int		i;
    long    lCantRegistros 		= 0;
    short   iLastRows     		= 0;
    int     iFetchedRows  		= MAXFETCH;
    int     iRetrievRows  		= MAXFETCH;
    int 	NroComisionistas	= 0;
        
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        double  dhImpConcepto   		[MAXFETCH];
		long	lhNumAjuste				[MAXFETCH];
        int		ihCodTipoRed;
        long	lhCodComisionista;
        char	szhIdPeriodo[11];
        long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
	lhCodComisionista 	= lComisionista;
	ihCodTipoRed 		= iTipoRed;

    lMaxFetch = MAXFETCH;
    paux 	  = NULL;
    qaux 	  = NULL;

	fprintf(pfLog ,"\n\n[stCargaAjustes]Carga de Ajustes del Periodo. TipoRed:[%d] Comisionista:[%ld]\n",ihCodTipoRed, lhCodComisionista);

    /* EXEC SQL DECLARE CUR_UNIVERSO_AJUSTES CURSOR FOR SELECT  
	    	NUM_AJUSTE,
	        IMP_CONCEPTO
        FROM    CMT_AJUSTES_COMISIONES 
        WHERE   COD_TIPORED 		= :ihCodTipoRed
        AND 	ID_PERIODO   		= :szhIdPeriodo
        AND     COD_COMISIONISTA 	= :lhCodComisionista
        AND     COD_ESTADO    		= 'ING'; */ 


    /* EXEC SQL OPEN CUR_UNIVERSO_AJUSTES; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )259;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodComisionista;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch FETCH CUR_UNIVERSO_AJUSTES  INTO 
        	:lhNumAjuste, :dhImpConcepto; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )286;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lhNumAjuste;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)dhImpConcepto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )sizeof(double);
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
		    paux = (stConceptos *) malloc(sizeof(stConceptos));                                                             

		    paux->lCodConcepto      = lhNumAjuste[i];
		    strcpy(paux->cTipComision, "A");
		    paux->dImpConcepto      = dhImpConcepto[i];
		    strcpy(paux->szUniverso , "AJUSTES");
		    strcpy(paux->cTipCalculo, "D");
		    paux->lNumLogro			= 0;
		    paux->lNumRegistros		= 0; 
			paux->iNivSeleccion		= 1;
			paux->iNivAplicacion	= 1; 
			paux->cIndConsidera     = 'S';
			
			paux->sgte				= qaux;
			qaux 					= paux;            
            lCantRegistros++;
        }
	}
    /* EXEC SQL CLOSE CUR_UNIVERSO_AJUSTES; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )309;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}



    fprintf(pfLog ,"\t[stCargaAjustes]Cantidad de Ajustes Recuperados:[%d]\n", lCantRegistros);
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* Crea el universo de Anticipos en la lista de universo.                      */
/*---------------------------------------------------------------------------*/
stConceptos * stCargaAnticipos(int iTipoRed, long lComisionista)      
{     
    stConceptos     * paux;
    stConceptos     * qaux;
    
    int  	i;
    long    lCantRegistros 		= 0;
    short   iLastRows     		= 0;
    int     iFetchedRows  		= MAXFETCH;
    int     iRetrievRows  		= MAXFETCH;
    int 	NroComisionistas	= 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        double  dhImpConcepto   [MAXFETCH];
        long	lhNumAnticipo	[MAXFETCH];

        int		ihCodTipoRed;
        long    lhCodComisionista;
        char	szhIdPeriodo	[11];
        long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    ihCodTipoRed	  	= iTipoRed;
	lhCodComisionista 	= lComisionista;
    lMaxFetch 			= MAXFETCH;
	strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
    paux 				= NULL;
    qaux 				= NULL;
	
    fprintf(pfLog ,"\n\n[stCargaAnticipos] Carga de Anticipos TipoRed:[%d] Comisionista:[%ld]\n",ihCodTipoRed, lhCodComisionista);
    
    /* EXEC SQL DECLARE CUR_UNIVERSO_ANTICIPOS CURSOR FOR SELECT  
            A.NUM_ANTICIPO,
            A.IMP_ANTICIPO
        FROM    CMT_ANTICIPOS A
        WHERE   A.COD_TIPORED		= :ihCodTipoRed
        AND     A.COD_COMISIONISTA 	= :lhCodComisionista
        AND 	A.ID_PERIODO_LIQ	= :szhIdPeriodo
        AND     A.COD_ESTADO_LIQ  	= 'ING'; */ 


                   
    /* EXEC SQL OPEN CUR_UNIVERSO_ANTICIPOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )324;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodComisionista;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch FETCH CUR_UNIVERSO_ANTICIPOS INTO   
			:lhNumAnticipo, :dhImpConcepto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )351;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhNumAnticipo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)dhImpConcepto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )sizeof(double);
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
    		paux = (stConceptos *) malloc(sizeof(stConceptos));                                                             

		    paux->lCodConcepto      = lhNumAnticipo[i];
		    strcpy(paux->cTipComision, "A");
		    paux->dImpConcepto      = dhImpConcepto[i];
		    strcpy(paux->szUniverso , "ANTICIPOS");
		    strcpy(paux->cTipCalculo, "D");
		    paux->lNumLogro			= 0;
		    paux->lNumRegistros		= 0; 
			paux->iNivSeleccion		= 1;
			paux->iNivAplicacion	= 1; 
			paux->cIndConsidera     = 'S';

			
			paux->sgte				= qaux;
			qaux 					= paux;            
            lCantRegistros++;
		}
	}
	/* EXEC SQL CLOSE CUR_UNIVERSO_ANTICIPOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )374;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}



    fprintf(pfLog ,"\t[stCargaAnticipos]Cantidad de Anticipos Recuperados:[%d]\n", lCantRegistros);
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* Carga universo de conceptos acumulados para cada comisionista.            */
/*---------------------------------------------------------------------------*/
stConceptos * stCargaConceptos(int iTipoRed, long lComisionista)      
{     
    stConceptos     * paux;
    stConceptos     * qaux;
    
    int  	i;
    long    lCantRegistros 		= 0;
    short   iLastRows     		= 0;
    int     iFetchedRows  		= MAXFETCH;
    int     iRetrievRows  		= MAXFETCH;
    int 	NroComisionistas	= 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szRowId         [MAXFETCH][19];
        long	lhCodConcepto	[MAXFETCH];
        double  dhImpConcepto   [MAXFETCH];
        long	lhNumLogro		[MAXFETCH];
        long	lhNumRegistros	[MAXFETCH];
        char	chTipConcepto	[MAXFETCH][2];
        char	szhCodUniverso	[MAXFETCH][7];
		char	chTipCalculo	[MAXFETCH][2];
		int		ihNivSeleccion  [MAXFETCH];
		int		ihNivAplicacion [MAXFETCH];
        int		ihCodTipoRed;
        long    lhCodComisionista;
        char	szhIdPeriodo	[11];
        long    lMaxFetch;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    ihCodTipoRed	  	= iTipoRed;
	lhCodComisionista 	= lComisionista;
    lMaxFetch 			= MAXFETCH;
	strcpy(szhIdPeriodo	, stCiclo.szIdCiclComis);
    paux 				= NULL;
    qaux 				= NULL;
	
    fprintf(pfLog ,"\n\n[stCargaConceptos] Carga de Cocneptos TipoRed:[%d] Comisionista:[%ld]\n",ihCodTipoRed, lhCodComisionista);

    /* EXEC SQL DECLARE CUR_UNIVERSO_CONCEPTOS CURSOR FOR SELECT  
            A.COD_CONCEPTO,
            NUM_LOGRO,
            NUM_REGISTROS,
            A.IMP_CONCEPTO,
            B.TIP_CONCEPTO,
            B.COD_UNIVERSO,
            B.TIP_CALCULO,
            C.NIV_SELECCION,
            C.NIV_APLICACION
        FROM    CMT_ACUMULADOS A,
        		CMD_CONCEPTOS B,
        		CM_CONCEPTOSTIPORED_TD C
        WHERE   A.COD_TIPORED		= :ihCodTipoRed
        AND     A.COD_COMISIONISTA 	= :lhCodComisionista
        AND 	A.ID_PERIODO		= :szhIdPeriodo
        AND     A.COD_CONCEPTO 		= B.COD_CONCEPTO
        AND 	A.COD_TIPORED 		= C.COD_TIPORED
        AND 	A.COD_CONCEPTO 		= C.COD_CONCEPTO; */ 


                   
    /* EXEC SQL OPEN CUR_UNIVERSO_CONCEPTOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )389;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodComisionista;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch FETCH CUR_UNIVERSO_CONCEPTOS INTO   
			:lhCodConcepto , :lhNumLogro   , 
			:lhNumRegistros, :dhImpConcepto, :chTipConcepto,
			:szhCodUniverso, :chTipCalculo , :ihNivSeleccion,
			:ihNivAplicacion; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )416;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhCodConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhNumLogro;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumRegistros;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)dhImpConcepto;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )sizeof(double);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)chTipConcepto;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )2;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodUniverso;
  sqlstm.sqhstl[5] = (unsigned long )7;
  sqlstm.sqhsts[5] = (         int  )7;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)chTipCalculo;
  sqlstm.sqhstl[6] = (unsigned long )2;
  sqlstm.sqhsts[6] = (         int  )2;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)ihNivSeleccion;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )sizeof(int);
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)ihNivAplicacion;
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];

        for (i=0; i < iRetrievRows; i++)
        {
    		paux = (stConceptos *) malloc(sizeof(stConceptos));                                                             

		    paux->lCodConcepto      = lhCodConcepto[i];
		    strcpy(paux->cTipComision, chTipConcepto[i]);
		    paux->dImpConcepto      = dhImpConcepto[i];
		    strcpy(paux->szUniverso , szfnTrim(szhCodUniverso[i]));
		    strcpy(paux->cTipCalculo, chTipCalculo[i]);
		    paux->lNumLogro			= lhNumLogro[i];
		    paux->lNumRegistros		= lhNumRegistros[i]; 
			paux->iNivSeleccion		= ihNivSeleccion[i];
			paux->iNivAplicacion	= ihNivAplicacion[i]; 
			paux->cIndConsidera     = 'S';

			paux->sgte				= qaux;
			qaux 					= paux;            
            lCantRegistros++;
		}
	}
	/* EXEC SQL CLOSE CUR_UNIVERSO_CONCEPTOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )467;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}



    fprintf(pfLog ,"\t[stCargaConceptos]Cantidad de Conceptos Recuperados:[%d]\n", lCantRegistros);
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* Ejecuta la carga de las estructuras de comisionistas, conceptos y ajustes */
/* para proceder al cálculo de la liquidación de comisiones.                 */
/*---------------------------------------------------------------------------*/
void vCargaDatosLiquidacion()
{
	stUniverso * paux;
	
	switch(stCiclo.cTipCiclComis)
	{
		case PERIODICO:
			lstComisionistas = stCreaUniversoPeriodico();
			break;
		case ESPORADICO:
			lstComisionistas = stCreaUniversoEsporadico();
			break;
		default:
			fprintf(pfLog ,"\n\n[vCargaDatosLiquidacion] Tipo de Ciclo de Comisiones [%c] Desconocido. Se aborta la ejecucion.", stCiclo.cTipCiclComis);
			fprintf(stderr,"\n\n[vCargaDatosLiquidacion] Tipo de Ciclo de Comisiones [%c] Desconocido. Se aborta la ejecucion.", stCiclo.cTipCiclComis);
			exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,-1,"Tipo de Ciclo de Comisiones Desconocido.",0,0));
	}
	for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
		paux->sgte_concepto = stCargaConceptos(paux->iCodTipoRed, paux->lCodComisionista);
		paux->sgte_ajuste   = stCargaAjustes(paux->iCodTipoRed, paux->lCodComisionista);
		paux->sgte_anticipo	= stCargaAnticipos(paux->iCodTipoRed, paux->lCodComisionista);
	}
}
/*---------------------------------------------------------------------------*/
/* Calcula losvalores totales de liquidación, para lalista principal.        */
/*---------------------------------------------------------------------------*/
void vTotalizaLiquidaciones()
{
	stUniverso 	* paux;
	stConceptos * qaux;

	double  	dhAcumComisiones;
    double  	dhAcumAjustes;
    double  	dhAcumAnticipos;
    double  	dhAcumPenaliza;
	
	for(paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
	    if (paux->cIndConsidera == 'S')
	    {
		    dhAcumComisiones = 0.00;
		    dhAcumAjustes	 = 0.00;
		    dhAcumAnticipos	 = 0.00;
		    dhAcumPenaliza	 = 0.00;
		    /* Conceptos de Comoisiones / Bonos y Penalizaciones */
		    for (qaux = paux->sgte_concepto; qaux != NULL; qaux = qaux->sgte)
		    {
		    	if (qaux->cIndConsidera == 'S')
		    	{
		    		if (strcmp(qaux->cTipComision,"P")!=0)	dhAcumComisiones += qaux->dImpConcepto;
		    		if (strcmp(qaux->cTipComision,"P")==0)	dhAcumPenaliza += qaux->dImpConcepto;		    		
		    	}
		    }
		    paux->dAcumComisiones 	= dhAcumComisiones;
		    paux->dAcumPenaliza		= dhAcumPenaliza;
			/* Anticipos */
		    for (qaux = paux->sgte_anticipo; qaux != NULL; qaux = qaux->sgte)
		    {
		    	if (qaux->cIndConsidera == 'S')
		    	{
		    		dhAcumAnticipos += qaux->dImpConcepto;
		    	}
		    }
		    paux->dAcumAnticipos	= dhAcumAnticipos;
			/* Ajustes */
		    for (qaux = paux->sgte_ajuste; qaux != NULL; qaux = qaux->sgte)
		    {
		    	if (qaux->cIndConsidera == 'S')
		    	{
		    		dhAcumAjustes += qaux->dImpConcepto;
		    	}
		    }
		    paux->dAcumAjustes	= dhAcumAjustes;
		}
	}
}
/*---------------------------------------------------------------------------*/
/* Aplica Criterios de Impuestos a las liquidaciones de Comisiones.          */
/*---------------------------------------------------------------------------*/
void vCalculaImpuestos()
{
	stUniverso 	* paux;
    double  	dhAcumComisiones;
    double  	dhAcumAjustes;
    double  	dhAcumAnticipos;
    double  	dhAcumPenaliza;
    
    double  	dhValorNeto;
    double  	dhValorImpuesto;
    double  	dhValorTotal;
	
	for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
		dhAcumComisiones= paux->dAcumComisiones ;
        dhAcumAjustes   = paux->dAcumAjustes    ;
        dhAcumAnticipos = paux->dAcumAnticipos  ;
        dhAcumPenaliza  = paux->dAcumPenaliza   ;
       	dhValorTotal    = dhAcumComisiones + dhAcumAjustes - dhAcumAnticipos - dhAcumPenaliza;
        
        fFactorImpuesto = dObtenerFactor(paux->lCodCliente, paux->szCodOficina);
        dhValorNeto     = dhValorTotal * (100.00/(100.00 + fFactorImpuesto));
        dhValorImpuesto	= dhValorTotal - dhValorNeto;

		paux->dAcumComisiones   = fnCnvDouble(dhAcumComisiones, 0); 
		paux->dAcumAjustes      = fnCnvDouble(dhAcumAjustes   , 0); 
		paux->dAcumAnticipos    = fnCnvDouble(dhAcumAnticipos , 0); 
		paux->dAcumPenaliza     = fnCnvDouble(dhAcumPenaliza  , 0); 
        paux->dValorNeto		= fnCnvDouble(dhValorNeto	  , 0);
        paux->dValorImpuesto  	= fnCnvDouble(dhValorImpuesto , 0);
        paux->dValorTotal    	= fnCnvDouble(dhValorTotal    , 0);
	}
}
/*---------------------------------------------------------------------------*/
/* Inserta en tabla el registro de liquidacion                               */
/*---------------------------------------------------------------------------*/
void vInsertaLiquidacion()
{
	stUniverso 	* paux;
	stConceptos * qaux;

	long		lCantRegs = 0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    ihCodComisionista;
        char    szhTipComis[3];
        int     ihCodPeriodo;
        double  dhAcumComisiones;
        double  dhAcumPenaliza;
        double  dhAcumAnticipos;
        double  dhAcumAjustes;
        double  dhValorNeto;
        double  dhValorImpuesto;
        double  dhValorTotal;
        char	chIndCumplimiento;
        char	szhIndAplicSubordinada[2];
        char	szhIdPeriodo[11];
        int		ihCodTipoRed;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCodPeriodo        = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo , stCiclo.szIdCiclComis);   
	fprintf(pfLog , "[vInsertaLiquidacion] Inicia Grabado de Registros en Tabla de Liquidaciones.\n");
	fprintf(stderr, "[vInsertaLiquidacion] Inicia Grabado de Registros en Tabla de Liquidaciones.\n");

	for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
        ihCodComisionista  				= paux->lCodComisionista;
        strcpy(szhTipComis				, paux->szTipComis);
        dhAcumComisiones   				= paux->dAcumComisiones;
        dhAcumPenaliza     				= paux->dAcumPenaliza;
        dhAcumAnticipos    				= paux->dAcumAnticipos;
        dhAcumAjustes      				= paux->dAcumAjustes;
        dhValorNeto        				= paux->dValorNeto;
        dhValorImpuesto    				= paux->dValorImpuesto;
        dhValorTotal       				= paux->dValorTotal;
        ihCodTipoRed       				= paux->iCodTipoRed;
        chIndCumplimiento				= paux->cIndCumplimiento;
        strcpy(szhIndAplicSubordinada	, paux->szIndAplicSubordinada);
        lCantRegs++;

        /* EXEC SQL INSERT INTO CM_LIQUIDACION_TO  (
        	COD_COMISIONISTA, COD_TIPCOMIS , COD_PERIODO      , ACUM_COMISION   ,
        	ACUM_ANTICIPO   , ACUM_AJUSTES , ACUM_PENALIZACION,
        	ACUM_NETO       , ACUM_IMPUESTO, TOT_PAGAR        , IND_CUMPLIMIENTO,
			IND_APLIC_SUBORDINADA, ID_PERIODO, COD_TIPORED) 
        VALUES (
        	:ihCodComisionista, :szhTipComis    ,  :ihCodPeriodo   , :dhAcumComisiones , 
            :dhAcumAnticipos  , :dhAcumAjustes  ,  :dhAcumPenaliza ,
            :dhValorNeto      , :dhValorImpuesto,  :dhValorTotal   , :chIndCumplimiento,
            :szhIndAplicSubordinada, :szhIdPeriodo, :ihCodTipoRed); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 14;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into CM_LIQUIDACION_TO (COD_COMISIONISTA,COD_T\
IPCOMIS,COD_PERIODO,ACUM_COMISION,ACUM_ANTICIPO,ACUM_AJUSTES,ACUM_PENALIZACION\
,ACUM_NETO,ACUM_IMPUESTO,TOT_PAGAR,IND_CUMPLIMIENTO,IND_APLIC_SUBORDINADA,ID_P\
ERIODO,COD_TIPORED) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,\
:b12,:b13)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )482;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodComisionista;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhTipComis;
        sqlstm.sqhstl[1] = (unsigned long )3;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodPeriodo;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&dhAcumComisiones;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&dhAcumAnticipos;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&dhAcumAjustes;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&dhAcumPenaliza;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&dhValorNeto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&dhValorImpuesto;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&dhValorTotal;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&chIndCumplimiento;
        sqlstm.sqhstl[10] = (unsigned long )1;
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)szhIndAplicSubordinada;
        sqlstm.sqhstl[11] = (unsigned long )2;
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)szhIdPeriodo;
        sqlstm.sqhstl[12] = (unsigned long )11;
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&ihCodTipoRed;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
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
        if (sqlca.sqlcode < 0) vSqlError_2();
}

 
	}
	fprintf(pfLog , "[vInsertaLiquidacion] Fin Grabado. Registros en Tabla de Liquidaciones:[%ld].", lCantRegs);
	fprintf(stderr, "[vInsertaLiquidacion] Fin Grabado. Registros en Tabla de Liquidaciones:[%ld].", lCantRegs);
	stStatusProc.lLiquidaciones = lCantRegs;
}
/*---------------------------------------------------------------------------*/
/* Marca los registros de Anticipo y Ajuste como liquidados...               */
/*---------------------------------------------------------------------------*/
void vMarcaAjustesAnticipos()
{
	stUniverso 		* paux;
	stConceptos 	* qaux;
	long		  	lCantAjustes = 0;
	long		  	lCantAnticipos = 0;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNumId;
	/* EXEC SQL END DECLARE SECTION; */ 


	long		lNumId;

	fprintf(pfLog , "[vMarcaAjustesAnticipos] Marca los registros de Anticipo y Ajuste como liquidados.\n");
	fprintf(stderr, "[vMarcaAjustesAnticipos] Marca los registros de Anticipo y Ajuste como liquidados.\n");

	for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
        for( qaux = paux->sgte_ajuste;qaux !=NULL ; qaux = qaux->sgte)
        {
			lhNumId = qaux->lCodConcepto;
			/* EXEC SQL UPDATE CMT_AJUSTES_COMISIONES
                SET COD_ESTADO = 'LIQ'
                WHERE NUM_AJUSTE = :lhNumId; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CMT_AJUSTES_COMISIONES  set COD_ESTADO='LIQ' where \
NUM_AJUSTE=:b0";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )553;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumId;
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
   if (sqlca.sqlcode < 0) vSqlError_2();
}


           	lCantAjustes++;
		}
        for( qaux = paux->sgte_anticipo;qaux !=NULL ; qaux = qaux->sgte)
        {
            lhNumId = qaux->lCodConcepto;
            /* EXEC SQL UPDATE CMT_ANTICIPOS
                SET COD_ESTADO_LIQ = 'LIQ'
                WHERE NUM_ANTICIPO = :lhNumId; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 14;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CMT_ANTICIPOS  set COD_ESTADO_LIQ='LIQ' wh\
ere NUM_ANTICIPO=:b0";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )572;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumId;
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
            if (sqlca.sqlcode < 0) vSqlError_2();
}


            lCantAnticipos++;
        }
	
	}
	stStatusProc.lAjustes 	= lCantAjustes;
	stStatusProc.lAnticipos	= lCantAnticipos;
	
	fprintf(pfLog ,"[vMarcaAjustesAnticipos] Cantidad de Ajustes   Liquidados:[%ld].", lCantAjustes);
	fprintf(pfLog ,"[vMarcaAjustesAnticipos] Cantidad de Anticipos Liquidados:[%ld].", lCantAnticipos);
	fprintf(stderr,"[vMarcaAjustesAnticipos] Cantidad de Ajustes   Liquidados:[%ld].", lCantAjustes);
	fprintf(stderr,"[vMarcaAjustesAnticipos] Cantidad de Anticipos Liquidados:[%ld].", lCantAnticipos);
}

/*---------------------------------------------------------------------------*/
/* OBTIENE CATEGORIA DE IMPUESTO                                             */
/*---------------------------------------------------------------------------*/
long lObtenerCategoria(long lCodCliente)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long     lhCliente;
		int      iExiste;
        long     lhCodCatImpos;
    /* EXEC SQL END DECLARE SECTION; */ 


	iExiste   = 0;
    lhCliente = lCodCliente;

    /* EXEC SQL SELECT COUNT(*)  
   	INTO :iExiste
    FROM GE_CATIMPCLIENTES
    WHERE COD_CLIENTE = :lhCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from GE_CATIMPCLIENTES where C\
OD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )591;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iExiste;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCliente;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}



	if (iExiste > 0) 
	{
	    /* EXEC SQL SELECT COD_CATIMPOS  
    	INTO :lhCodCatImpos
        FROM GE_CATIMPCLIENTES
        WHERE COD_CLIENTE = :lhCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_CATIMPOS into :b0  from GE_CATIMPCLIENTES whe\
re COD_CLIENTE=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )614;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCatImpos;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhCliente;
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
     if (sqlca.sqlcode < 0) vSqlError_2();
}



		return lhCodCatImpos;
	}

	return -1;
}
/*---------------------------------------------------------------------------*/
/* OBTIENE FACTOR DE IMPUESTO APLICADO                                       */
/*---------------------------------------------------------------------------*/
double dObtenerFactor(long lCodCliente, char * szCodOficina)
{
	char szMsgErr[MAXARRAY];
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long     lhSecuencia;
        int      ihConceptoComisiones;
        long     lhClienteGenerico;
        float    fhValorNeto;
        float    fhValorConImpto;
        int      ihCodTipConce;
        long     lhCodCatImpos;
        char     szhRetorno[250];
        double   fhFactor;
        char     szhCodOficina[3];
		char     szhRetorno1[250]; 
		char     szhRetorno2[250]; 
		char     szhRetorno3[250]; 
		char     szhRetorno4[250]; 
		char     szhRetorno5[250]; 
		char     szhRetorno6[250]; 
    /* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhRetorno1	, "");
	strcpy(szhRetorno2	, "");
	strcpy(szhRetorno3	, "");
	strcpy(szhRetorno4	, "");
	strcpy(szhRetorno5	, "");
	strcpy(szhRetorno6	, "");
	
    strcpy(szhCodOficina	, szCodOficina);
    lhClienteGenerico 		= ((lCodCliente==0)?lClienteGenerico:lCodCliente);
    ihConceptoComisiones	= iConceptoComisiones;  
    fhValorNeto         	= 0.00;
    
    /* EXEC SQL SELECT FAS_PRESUPTEMP.NEXTVAL 
    	INTO :lhSecuencia
        FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FAS_PRESUPTEMP.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )637;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


        
    /* EXEC SQL SELECT COD_TIPCONCE 
    	INTO :ihCodTipConce  
        FROM FA_CONCEPTOS
        WHERE COD_CONCEPTO = :ihConceptoComisiones
        AND COD_PRODUCTO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_TIPCONCE into :b0  from FA_CONCEPTOS where (CO\
D_CONCEPTO=:b1 and COD_PRODUCTO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )656;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipConce;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihConceptoComisiones;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}

     

    /* EXEC SQL INSERT INTO FAT_PRESUPTEMP (
		NUM_PROCESO, COD_CONCEPTO, COLUMNA,  COD_CLIENTE, 
        FEC_EFECTIVIDAD, IMP_CONCEPTO, IMP_FACTURABLE, 
        COD_TIPCONCE, COD_CONCEREL,  COLUMNA_REL, 
        FLAG_IMPUES, PRC_IMPUESTO)
        VALUES(:lhSecuencia, :ihConceptoComisiones, 1,
               :lhClienteGenerico, SYSDATE, :fhValorNeto,
               :fhValorNeto, :ihCodTipConce, 0, 0, 0, 0.0); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_PRESUPTEMP (NUM_PROCESO,COD_CONCEPTO,COLU\
MNA,COD_CLIENTE,FEC_EFECTIVIDAD,IMP_CONCEPTO,IMP_FACTURABLE,COD_TIPCONCE,COD_C\
ONCEREL,COLUMNA_REL,FLAG_IMPUES,PRC_IMPUESTO) values (:b0,:b1,1,:b2,SYSDATE,:b\
3,:b3,:b5,0,0,0,0.0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )679;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihConceptoComisiones;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhClienteGenerico;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&fhValorNeto;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&fhValorNeto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipConce;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}



    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )718;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}

   
                    
    lhCodCatImpos = lObtenerCategoria(lhClienteGenerico);
    
    sprintf(szMsgErr , "Cliente [%ld] no cuenta con Categoria de Impuesto \n" ,lhClienteGenerico);
        
	if (lhCodCatImpos < 0) 
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,-1,szMsgErr,lhClienteGenerico,0));        
   
	iPl=1;
     
	/* EXEC SQL EXECUTE                                 
		BEGIN                                            
            FA_PROC_IMPTOS (:lhSecuencia, :lhCodCatImpos, :szhCodOficina,            
            	:szhRetorno1, :szhRetorno2, :szhRetorno3, :szhRetorno4,                 
    			:szhRetorno5, :szhRetorno6);
     	END;                                             
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin FA_PROC_IMPTOS ( :lhSecuencia , :lhCodCatImpos , :szhC\
odOficina , :szhRetorno1 , :szhRetorno2 , :szhRetorno3 , :szhRetorno4 , :szhRe\
torno5 , :szhRetorno6 ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )733;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhSecuencia;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCatImpos;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhRetorno1;
 sqlstm.sqhstl[3] = (unsigned long )250;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhRetorno2;
 sqlstm.sqhstl[4] = (unsigned long )250;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhRetorno3;
 sqlstm.sqhstl[5] = (unsigned long )250;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhRetorno4;
 sqlstm.sqhstl[6] = (unsigned long )250;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhRetorno5;
 sqlstm.sqhstl[7] = (unsigned long )250;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhRetorno6;
 sqlstm.sqhstl[8] = (unsigned long )250;
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
 if (sqlca.sqlcode < 0) vSqlError_2();
}


     
	/*if (sqlca.sqlcode != 0)
	{
    	fprintf(stderr, "Error [%ld] en ejecucion del Calculo de Impuesto...Secuencia [%ld]\n", sqlca.sqlcode, lhSecuencia);
    	vSqlError_2();
    }
    */
                                                      
	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )784;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}

                                   
	
	iPl=0;
	
     /* EXEC SQL SELECT NVL(MAX(PRC_IMPUESTO),0)  
     	INTO :fhFactor
        FROM FAT_PRESUPTEMP
        WHERE NUM_PROCESO = :lhSecuencia
        AND PRC_IMPUESTO IS NOT NULL
        ORDER BY PRC_IMPUESTO DESC; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select NVL(max(PRC_IMPUESTO),0) into :b0  from FAT_PRESU\
PTEMP where (NUM_PROCESO=:b1 and PRC_IMPUESTO is  not null ) order by PRC_IMPU\
ESTO desc  ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )799;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&fhFactor;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&lhSecuencia;
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
     if (sqlca.sqlcode < 0) vSqlError_2();
}


    
	return fhFactor;   
}
/*---------------------------------------------------------------------------*/
/* PROCEDIMIENTO QUE CARGA LOS PARAMETROS GENERALES DEL PROCESO              */
/*---------------------------------------------------------------------------*/
void vCargaParametros()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

       int      ihCodConcepComisiones;
       long     lhCodClienteGenerico;
       char     szhMonto[15]; /* EXEC SQL VAR  szhMonto IS STRING(15); */ 

    /* EXEC SQL END DECLARE SECTION; */ 
     

	fprintf(pfLog, "\n[vCargaParametros]Carga Parametros para CALCULO de IMPUESTOS.\n");
	fprintf(stderr,"\n[vCargaParametros]Carga Parametros para CALCULO de IMPUESTOS.\n");
    
    /* EXEC SQL SELECT TO_NUMBER(VAL_PARAMETRO1) INTO
         :ihCodConcepComisiones
         FROM CMD_PARAMETROS
         WHERE COD_TIPCODIGO = 4 
         AND COD_CODIGO = 1
         AND COD_PARAMETRO  =1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_NUMBER(VAL_PARAMETRO1) into :b0  from CMD_PARAM\
ETROS where ((COD_TIPCODIGO=4 and COD_CODIGO=1) and COD_PARAMETRO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )822;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepComisiones;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}

    
         
    iConceptoComisiones = ihCodConcepComisiones;        

    /* EXEC SQL SELECT TO_NUMBER(VAL_PARAMETRO1) INTO
         :lhCodClienteGenerico
         FROM CMD_PARAMETROS
         WHERE COD_TIPCODIGO = 4
         AND COD_CODIGO = 2
         AND COD_PARAMETRO  =1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_NUMBER(VAL_PARAMETRO1) into :b0  from CMD_PARAM\
ETROS where ((COD_TIPCODIGO=4 and COD_CODIGO=2) and COD_PARAMETRO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )841;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteGenerico;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}

    
    
    lClienteGenerico = lhCodClienteGenerico;
    fprintf(pfLog ,"[vCargaParametros]Concepto de Facturacion Para Calculo de Impuestos:[%d].\n",iConceptoComisiones);
    fprintf(stderr,"[vCargaParametros]Concepto de Facturacion Para Calculo de Impuestos:[%d].\n",iConceptoComisiones);
    fprintf(pfLog ,"[vCargaParametros]Cliente Generico Para Calculo de Impuestos:[%d].\n",lClienteGenerico);
    fprintf(stderr,"[vCargaParametros]Cliente Generico Para Calculo de Impuestos:[%d].\n",lClienteGenerico);
}
/*---------------------------------------------------------------------------*/
/* Lista el contenido de la estructura en el archivo LOG.                    */
/*---------------------------------------------------------------------------*/
void vMuestraListas(stUniverso * lstUniverso)
{
    stUniverso      * pUniver;
    stConceptos     * pConcep;
        
	fprintf(pfLog, "\nMuestra estructura de listas de comisionistas...\n");   
    for(pUniver=lstUniverso; pUniver!=NULL; pUniver=pUniver->sgte)
    {
    	if (pUniver->cIndConsidera == 'S')
    	{
	        fprintf(pfLog, "-------------COMISIONISTA-------------------------------------\n");   
	        fprintf(pfLog, "Tipo de Red         [%d]\n"  , pUniver->lCodComisionista  	);        
	        fprintf(pfLog, "Tipo Comisionista   [%s]\n"   , pUniver->szTipComis 	    );      
	        fprintf(pfLog, "Comisionista        [%d]\n"  , pUniver->lCodComisionista  	);        
	        fprintf(pfLog, "Cliente             [%d]\n"  , pUniver->lCodCliente      	);      
	        fprintf(pfLog, "Oficina             [%s]\n"   , pUniver->szCodOficina      	); 
	        fprintf(pfLog, "Bonos y Comisiones  [%6.2f]\n", pUniver->dAcumComisiones	); 
	        fprintf(pfLog, "Ajustes             [%6.2f]\n", pUniver->dAcumAjustes		); 
	        fprintf(pfLog, "Anticipos           [%6.2f]\n", pUniver->dAcumAnticipos		); 
	        fprintf(pfLog, "Penalizaciones      [%6.2f]\n", pUniver->dAcumPenaliza		); 
	        fprintf(pfLog, "Neto                [%6.2f]\n", pUniver->dValorNeto			); 
	        fprintf(pfLog, "Impuesto            [%6.2f]\n", pUniver->dValorImpuesto		); 
	        fprintf(pfLog, "Total a PAgar       [%6.2f]\n", pUniver->dValorTotal		); 
		    /* Conceptos... */
		    for(pConcep=pUniver->sgte_concepto; pConcep!=NULL; pConcep=pConcep->sgte)
		    {
		    	if (pConcep->cIndConsidera == 'S')
		    	{
		            fprintf(pfLog, "\t----CONCEPTOS DE COMISION/BONO/PENALIZACION---------------\n");
		            fprintf(pfLog, "\tConcepto        [%d]\n", pConcep->lCodConcepto       );
		            		            
		            if (strcmp(pConcep->cTipComision, "B")==0) fprintf(pfLog, "\tTipo Concepto   [%s][BONOS]\n", pConcep->cTipComision);
					if (strcmp(pConcep->cTipComision, "C")==0) fprintf(pfLog, "\tTipo Concepto   [%s][COMISION]\n", pConcep->cTipComision);
					if (strcmp(pConcep->cTipComision, "P")==0) fprintf(pfLog, "\tTipo Concepto   [%s][PENALIZACION]\n", pConcep->cTipComision);
							            		
		            fprintf(pfLog, "\tImporte         [%f]\n", pConcep->dImpConcepto     );                     
		            fprintf(pfLog, "\tUniverso        [%s]\n", pConcep->szUniverso       );
		            fprintf(pfLog, "\tRegistros       [%d]\n", pConcep->lNumRegistros    );
		            if (strcmp(pConcep->cTipCalculo,"M")==0) 
		            	fprintf(pfLog, "\tLogro Metas     [%d]\n", pConcep->lNumLogro);		            	
	            }
	        }
	        /* Ajustes */
		    for(pConcep=pUniver->sgte_ajuste; pConcep!=NULL; pConcep=pConcep->sgte)
		    {
		    	if (pConcep->cIndConsidera == 'S')
		    	{
		            fprintf(pfLog, "\t-------------AJUSTES COMISIONALES-------------------------\n");
		            fprintf(pfLog, "\tNum. Ajuste    [%d]\n", pConcep->lCodConcepto    );
		            fprintf(pfLog, "\tImporte        [%6.2f]\n" , pConcep->dImpConcepto    );
				}
	        }
	        /* Anticipos */
		    for(pConcep=pUniver->sgte_anticipo; pConcep!=NULL; pConcep=pConcep->sgte)
		    {
		    	if (pConcep->cIndConsidera == 'S')
		    	{
		            fprintf(pfLog, "\t-----------ANTICIPOS COMISIONALES-------------------------\n");
		            fprintf(pfLog, "\tNum. Anticipo  [%d]\n", pConcep->lCodConcepto    );
		            fprintf(pfLog, "\tImporte        [%6.2f]\n" , pConcep->dImpConcepto    );
				}
	        }
		}
    }       
}
/*---------------------------------------------------------------------------*/
/* Crea lista de Comisionistas Hijos, para comenzar la repartición...        */
/*---------------------------------------------------------------------------*/
stUniverso * stCreaComisHijos(int iCodTipoRed, long lCodVendedor)
{
	stUniverso 	* paux = NULL;
	stUniverso 	* qaux = NULL;
    int  		i;
    long    	lCantRegistros 		= 0;
    short   	iLastRows     		= 0;
    int     	iFetchedRows  		= MAXFETCH;
    int     	iRetrievRows  		= MAXFETCH;
    int 		NroComisionistas	= 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhTipComis      		[MAXFETCH][3];
        long    lhCodVendedor			[MAXFETCH];
        long    lhCodCliente     		[MAXFETCH];
        char    szhCodOficina    		[MAXFETCH][3];
        long    lMaxFetch;
        long	lhCodPadre;
        int		ihCodTipoRed;
        int		iCantHijos = 0;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodPadre 		= lCodVendedor;
    ihCodTipoRed 	= iCodTipoRed;
    lMaxFetch 		= MAXFETCH;
    paux 			= NULL;
    qaux 			= NULL;
    
    fprintf(pfLog ,"\n\n[stCreaComisHijos] Inicia Carga de Hijos de TipoRed:[%d] Comisionista:[%ld]\n", ihCodTipoRed, lhCodPadre );
    fprintf(stderr,"\n\n[stCreaComisHijos] Inicia Carga de Hijos de TipoRed:[%d] Comisionista:[%ld]\n", ihCodTipoRed, lhCodPadre );

	/* EXEC SQL SELECT COUNT(A.COD_VENDEDOR)
		INTO :iCantHijos
		FROM VE_REDVENTAS_TD A,
			 VE_VENDEDORES C
		WHERE A.COD_TIPORED = :ihCodTipoRed
		AND   A.COD_VENDE_PADRE = :lhCodPadre
		AND   A.COD_VENDEDOR = C.COD_VENDEDOR
		AND   A.COD_VENDEDOR != A.COD_VENDE_PADRE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(A.COD_VENDEDOR) into :b0  from VE_REDVENTAS_TD \
A ,VE_VENDEDORES C where (((A.COD_TIPORED=:b1 and A.COD_VENDE_PADRE=:b2) and A\
.COD_VENDEDOR=C.COD_VENDEDOR) and A.COD_VENDEDOR<>A.COD_VENDE_PADRE)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )860;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iCantHijos;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodPadre;
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
 if (sqlca.sqlcode < 0) vSqlError_2();
}


	
	if (iCantHijos == 0)
	{
    	fprintf(pfLog ,"\t[stCreaComisHijos] TipoRed:[%d] Comisionista:[%ld] NO POSEE HIJOS \n", ihCodTipoRed, lhCodPadre );
    	fprintf(stderr,"\t[stCreaComisHijos] TipoRed:[%d] Comisionista:[%ld] NO POSEE HIJOS \n", ihCodTipoRed, lhCodPadre );
		return NULL;
	}
    /* EXEC SQL DECLARE CUR_COMISHIJOS CURSOR FOR SELECT  
			C.COD_TIPCOMIS,
			A.COD_VENDEDOR,
			C.COD_CLIENTE,
			C.COD_OFICINA
		FROM VE_REDVENTAS_TD A,
			 VE_VENDEDORES C
		WHERE A.COD_TIPORED = :ihCodTipoRed
		AND   A.COD_VENDE_PADRE = :lhCodPadre
		AND   A.COD_VENDEDOR = C.COD_VENDEDOR
		AND   A.COD_VENDEDOR != A.COD_VENDE_PADRE; */ 

	
    /* EXEC SQL OPEN CUR_COMISHIJOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0023;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )887;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodPadre;
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
    if (sqlca.sqlcode < 0) vSqlError_2();
}


    while(iFetchedRows == iRetrievRows)
    {
		/* EXEC SQL for :lMaxFetch FETCH CUR_COMISHIJOS INTO   
			:szhTipComis,  :lhCodVendedor, :lhCodCliente, :szhCodOficina; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )910;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhTipComis;
  sqlstm.sqhstl[0] = (unsigned long )3;
  sqlstm.sqhsts[0] = (         int  )3;
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
  sqlstm.sqhstv[2] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
        {
		    paux = (stUniverso *) malloc(sizeof(stUniverso));

			paux->iCodTipoRed					= ihCodTipoRed;
		    paux->lCodComisionista      		= lhCodVendedor[i];   
		    strcpy(paux->szTipComis				, szfnTrim(szhTipComis[i]));   
		    strcpy(paux->szCodOficina   		, szfnTrim(szhCodOficina[i]));    
		    paux->lCodCliente           		= lhCodCliente[i];                        
		    paux->dAcumComisiones 				= 0.00;
		    paux->dAcumAjustes 					= 0.00;
		    paux->dAcumAnticipos 				= 0.00;
		    paux->dAcumPenaliza 				= 0.00;
		    paux->dValorNeto 					= 0.00;
		    paux->dValorImpuesto 				= 0.00;
		    paux->dValorTotal 					= 0.00;
		    paux->cIndCumplimiento				= 'S';
		    paux->cIndConsidera					= 'S';
		    
		    strcpy(paux->szIndAplicSubordinada 	, "N");
		    paux->sgte_concepto 				= NULL;
		    paux->sgte_anticipo 				= NULL;
		    paux->sgte_ajuste 					= NULL;
		                              
		    lCantRegistros++;

			paux->sgte 							= qaux;
			qaux 								= paux;
	    }
	}
	/* EXEC SQL CLOSE CUR_COMISHIJOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )941;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}


    fprintf(stderr,"\n\t[stCreaComisHijos] Registros Seleccionados (TipoRed:[%d] Comisionista:[%ld])[%d]\n",ihCodTipoRed, lhCodPadre, lCantRegistros);
    fprintf(pfLog ,"\n\t[stCreaComisHijos] Registros Seleccionados (TipoRed:[%d] Comisionista:[%ld])[%d]\n",ihCodTipoRed, lhCodPadre, lCantRegistros);
	return qaux;
}
/*---------------------------------------------------------------------------*/
/* RUTINA PARA CODIFICAR LOS UNIVERSOS  			                         */
/*---------------------------------------------------------------------------*/
int ifnGetNomTablaSeleccion(char * szUniverso, reg_campos * stMiCampos )
{
	if(strcmp(szUniverso,"HABCEL")==0)
	{
		strcpy(stMiCampos->szNomTabla	 	, "CMT_HABIL_CELULAR");
		strcpy(stMiCampos->szNomComisAplic 	, "COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec	, "COD_AGENCIA");
		return TRUE;
	}
	if(strcmp(szUniverso,"HABPRE")==0)
	{
		strcpy(stMiCampos->szNomTabla		, "CMT_HABIL_PREPAGO");
		strcpy(stMiCampos->szNomComisAplic	, "COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec	, "COD_AGENCIA");
		return TRUE;
	}
	if(strcmp(szUniverso,"BAJAS")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CMT_BAJAS_CELULAR");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_AGENCIA");
		return TRUE;
	}
	if(strcmp(szUniverso,"RECHAZ")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CMT_RECHAZOS_CELULAR");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_AGENCIA");
		return TRUE;
	}
	if(strcmp(szUniverso,"CONPAC")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CM_CONVENIOS_TO");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_VENDEDOR");
		return TRUE;
	}
	if(strcmp(szUniverso,"EVALUA")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CMT_EVALUACIONES");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_VENDEDOR");
		return TRUE;
	}
	if(strcmp(szUniverso,"CARTER")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CMT_EVALUACIONES");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_AGENCIA");
		return TRUE;
	}
	if(strcmp(szUniverso,"RETENC")==0)
	{
		strcpy(stMiCampos->szNomTabla,"CM_RETENCIONES_TO");
		strcpy(stMiCampos->szNomComisAplic,"COD_COMISIONISTA");
		strcpy(stMiCampos->szNomComisSelec,"COD_VENDEDOR");
		return TRUE;
	}
	return FALSE;
}
/*---------------------------------------------------------------------------*/
/* Determina la porción del monto total, que le corresponde al hijo, en raux */
/*(stPadre->iCodTipoRed, stPadre->lCodComisionista, stHijos->lCodComisionista, raux, paux->szTipComis);*/
/*---------------------------------------------------------------------------*/
void vDeterminaMontos(int iCodTipoRed, long lCodComisionista, long lCodComisHijo, stConceptos * raux)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szStmSql[MAXARRAY];
		int		ihCodTipoRed;
		long	lhCodComisionista;
		long	lhCodComisHijo;
		long	lhCodConcepto;
		long	lCantRegistros;
		double	dImpComision;
	/* EXEC SQL END DECLARE SECTION; */ 


	memset(&stCampos, 0, sizeof(reg_campos));
	if(ifnGetNomTablaSeleccion(raux->szUniverso, &stCampos))
	{
		ihCodTipoRed 		= iCodTipoRed;
		lhCodComisionista 	= lCodComisionista;
		lhCodConcepto 		= raux->lCodConcepto;
		lhCodComisHijo 		= lCodComisHijo;
		if (raux->iNivAplicacion == raux->iNivSeleccion)
		{
			/* caso 1: son niveles contiguos... */
			sprintf(szStmSql, "SELECT NVL(COUNT(A.NUM_GENERAL), 0), "
			" NVL(SUM(A.IMP_CONCEPTO), 0) "
			"FROM CMT_VALORIZADOS A, %s B "
			"WHERE A.COD_TIPORED      = :tipored "
			"  AND A.COD_CONCEPTO     = :concepto "
			"  AND A.COD_COMISIONISTA = :comisionista "
			"  AND A.NUM_GENERAL      = B.NUM_GENERAL "
			"  AND B.%s               = :hijo ",stCampos.szNomTabla, stCampos.szNomComisSelec );
		}
		else
		{
			/* caso 2: No son niveles contiguos...*/
				sprintf(szStmSql, "SELECT NVL(COUNT(A.NUM_GENERAL), 0), "
				" NVL(SUM(A.IMP_CONCEPTO), 0) "
				"FROM CMT_VALORIZADOS A, %s B "
				"WHERE A.COD_TIPORED = :tipored "
				"  AND A.COD_CONCEPTO = :concepto "
				"  AND A.COD_COMISIONISTA = :comisionista "
			"  AND A.NUM_GENERAL = B.NUM_GENERAL "
			"  AND CM_VALIDA_CICLCOMIS_PG.IESVENDEPADRE(A.COD_TIPORED,:hijo, B.%s)= 1 ",stCampos.szNomTabla, stCampos.szNomComisSelec );

		}
	
		/* EXEC SQL PREPARE MICUR FROM :szStmSql; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )956;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szStmSql;
  sqlstm.sqhstl[0] = (unsigned long )500;
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}


		
		/* EXEC SQL DECLARE CUR_REPARTE CURSOR FOR MICUR; */ 

		
		/* EXEC SQL OPEN CUR_REPARTE USING :ihCodTipoRed, :lhCodConcepto, :lhCodComisionista, :lhCodComisHijo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )975;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodConcepto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodComisionista;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodComisHijo;
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}


		
		/* EXEC SQL FETCH CUR_REPARTE INTO :lCantRegistros, :dImpComision; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1006;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lCantRegistros;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dImpComision;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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
  if (sqlca.sqlcode < 0) vSqlError_2();
}


		
		/* EXEC SQL CLOSE CUR_REPARTE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1029;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
  if (sqlca.sqlcode < 0) vSqlError_2();
}



		raux->lNumRegistros = lCantRegistros;
		raux->dImpConcepto  = dImpComision;
	}
	else
	{
		raux->lNumRegistros = 0;
		raux->dImpConcepto  = 0.00;
	}
}
/*---------------------------------------------------------------------------*/
/* Reparte la comisión del padre entre los hijos, de acuerdo a la valoración */
/* de eventos, es decir, el prorrateo se hará de manera directa desde la     */
/* tabla de valorizados.                                                     */
/*---------------------------------------------------------------------------*/
void vReparteComision(stUniverso * stPadre, stUniverso * stHijos)
{
	stConceptos * paux;
	stUniverso 	* qaux;
	stConceptos * raux;
	fprintf(stderr, "\n[vReparteComision] Reparte las comisiones de TR[%d] CatVta:[%s] Comis:[%d]\n",stPadre->iCodTipoRed, stPadre->szTipComis, stPadre->lCodComisionista);
	fprintf(pfLog , "\n[vReparteComision] Reparte las comisiones de TR[%d] CatVta:[%s] Comis:[%d]\n",stPadre->iCodTipoRed, stPadre->szTipComis, stPadre->lCodComisionista);
	for (paux = stPadre->sgte_concepto; paux != NULL; paux = paux->sgte)
	{
		if((paux->iNivAplicacion < paux->iNivSeleccion)&&(paux->cIndConsidera== 'S'))
		{
			fprintf(stderr, "\n\t[vReparteComision] Concepto:[%d] Comision:[%7.2f]\n",paux->lCodConcepto, paux->dImpConcepto);
			fprintf(pfLog , "\n\t[vReparteComision] Concepto:[%d] Comision:[%7.2f]\n",paux->lCodConcepto, paux->dImpConcepto);
			for (qaux = stHijos; qaux != NULL; qaux = qaux->sgte)
			{

				/* se crea el nuevo nodo de concepto, para el hijo qaux)...*/
				raux = (stConceptos *) malloc(sizeof(stConceptos));

			    raux->lCodConcepto      	= paux->lCodConcepto;   
			    strcpy(raux->cTipComision	, paux->cTipComision);
			    strcpy(raux->szUniverso 	, paux->szUniverso);
			    strcpy(raux->cTipCalculo	, paux->cTipCalculo); 
			    raux->lNumLogro				= paux->lNumLogro;	 
				raux->iNivSeleccion			= paux->iNivSeleccion;	 
				raux->iNivAplicacion		= paux->iNivAplicacion + 1; 
				raux->cIndConsidera     	= 'S';

				vDeterminaMontos(stPadre->iCodTipoRed, stPadre->lCodComisionista, qaux->lCodComisionista, raux);
				fprintf(stderr, "\n\t[vReparteComision] Comis. Hijo:[%d] Se lleva:[%7.2f]\n",qaux->lCodComisionista, raux->dImpConcepto);
				fprintf(pfLog , "\n\t[vReparteComision] Comis. Hijo:[%d] Se lleva:[%7.2f]\n",qaux->lCodComisionista, raux->dImpConcepto);

				/* asocia el nuevo nodo de concepto a la lista de conceptos del hijo. */
				raux->sgte 				= qaux->sgte_concepto;
				qaux->sgte_concepto 	= raux;
				/* Se marca el concepto en el padre para que no sea considerado al final. */
				paux->cIndConsidera     = 'N';
			}
		}
		else
		{
			fprintf(stderr,"\n\n[vReparteComision] No Es Posible Ejecutar la Reparticion de Comisiones\n");
			fprintf(stderr,"\tNivel de Aplicación es IGUAL al Nivel de Seleccion.\n");
			fprintf(stderr,"\tTipoRed:[%d] Concepto:[%d] Comisionista:%ld]\n",stPadre->iCodTipoRed, paux->lCodConcepto,stPadre->lCodComisionista  );

			fprintf(pfLog ,"\n\n[vReparteComision] No Es Posible Ejecutar la Reparticion de Comisiones\n");
			fprintf(pfLog ,"\tNivel de Aplicación es IGUAL al Nivel de Seleccion.\n");
			fprintf(pfLog ,"\tTipoRed:[%d] Concepto:[%d] Comisionista:%ld]\n",stPadre->iCodTipoRed, paux->lCodConcepto,stPadre->lCodComisionista  );
		}
	}
}

/*---------------------------------------------------------------------------*/
/* Añade el contenido de la lista stSource a la lista stTarget...            */
/*---------------------------------------------------------------------------*/
void vConcatenaListas(stUniverso * stSource)
{
	stUniverso * paux;
	stUniverso * qaux;

	if (stSource != NULL)
	{
		paux = stSource;
		qaux = paux->sgte;
		while (qaux != NULL)
		{
			paux = qaux;
			qaux = paux->sgte;
		}
		paux->sgte 	= lstAuxiliar;
		lstAuxiliar = stSource;
	}
}
/*---------------------------------------------------------------------------*/
/* Mezcla las listas de Padres e Hijos, para dejar una única lista...        */
/*---------------------------------------------------------------------------*/
void vMergeListas(stUniverso * lstPadres, stUniverso * lstHijos)
{
	stUniverso * paux;
	stUniverso * raux;
	
	stConceptos * qaux;
	stConceptos * saux;
	
	
	while (lstHijos != NULL)
	{
		fprintf(stderr, "\n[vMergeListas] Inserta al Comis.Hijo[%d] TR:[%d] en la lista General de Comisionistas.\n", lstHijos->iCodTipoRed, lstHijos->lCodComisionista);
		fprintf(pfLog , "\n[vMergeListas] Inserta al Comis.Hijo[%d] TR:[%d] en la lista General de Comisionistas.\n", lstHijos->iCodTipoRed, lstHijos->lCodComisionista);
		paux=stfnFindComisionista(lstHijos->iCodTipoRed, lstHijos->lCodComisionista, lstPadres);
		if (paux!=NULL)
		{
			/* se deben comparar las listas de conceptos. No debieran haber intersecciones... */
			qaux = lstHijos->sgte_concepto;
			while (qaux != NULL)
			{
				fprintf(stderr, "\n[vMergeListas] }Comisionista Existe. Intercala el concepto[%d].\n",qaux->lCodConcepto);
				fprintf(pfLog , "\n[vMergeListas] }Comisionista Existe. Intercala el concepto[%d].\n",qaux->lCodConcepto);
				saux=stfnFindConcepto(qaux->lCodConcepto, paux->sgte_concepto);
				if (saux!=NULL)
				{
					/* ERROR: El tipo de red posee dos veces el mismo concepto a niveles diferentes de aplicacion.*/
					fprintf(stderr,"\n\n[vMergeListas]El tipo de red posee dos veces el mismo concepto a niveles diferentes de aplicacion\n");
					fprintf(stderr,"\tTipoRed:[%d] Comisionista:[%ld] Concepto:[%ld]\n",paux->iCodTipoRed, paux->lCodComisionista, qaux->lCodConcepto);
					fprintf(pfLog ,"\n\n[vMergeListas]El tipo de red posee dos veces el mismo concepto a niveles diferentes de aplicacion\n");
					fprintf(pfLog ,"\tTipoRed:[%d] Comisionista:[%ld] Concepto:[%ld]\n",paux->iCodTipoRed, paux->lCodComisionista, qaux->lCodConcepto);
					exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,-1,"TIPO RED POSEE DOS VECES EL MISMO CONCEPTO A NIVELES DIFERENTES DE APLICACION.",0,0));
				}
				else
				{
					saux 				= qaux->sgte;
					qaux->sgte 			= paux->sgte_concepto;
					paux->sgte_concepto = qaux;
					qaux 				= saux;
				}
			}
			paux = lstHijos->sgte;
			free (lstHijos);
			lstHijos = paux;
		}
		else
		{
			/* Pasa la lista completa de conceptos... */
			fprintf(stderr, "\n[vMergeListas] Comisionista NO Existe. Pasa la Lista Completa de Conceptos.\n");
			fprintf(pfLog , "\n[vMergeListas] Comisionista NO Existe. Pasa la Lista Completa de Conceptos.\n");
			raux 			= lstHijos->sgte;
			lstHijos->sgte 	= lstPadres;
			lstPadres 		= lstHijos;
			lstHijos 		= raux;
		}
	}
}
/*---------------------------------------------------------------------------*/
/* Realiza la "repartición de comisiones" para el caso de Tipo de Red con    */
/* Ind_Aplic_Subordinada = 'S'.                                              */
/* SOLO LOS REGISTROS ASOCIADOS A CONCEPTOS DE COMISIONES.                   */
/* SE EXCLUYEN LOS RELACIONADOS CON AJUSTES Y ANTICIPOS.                     */
/*---------------------------------------------------------------------------*/
void vComisionesSubordinadas()
{
	stUniverso 	* paux;
	stUniverso 	* raux;

	for (paux = lstComisionistas; paux != NULL; paux = paux->sgte)
	{
		if (strcmp(paux->szIndAplicSubordinada ,"S")==0)
		{
			/* Se crea la lista "comisionista" con los hijos...  */
			raux = NULL;
			raux = stCreaComisHijos(paux->iCodTipoRed, paux->lCodComisionista);
			if (raux!=NULL)
			{
				/* Reparte las comisiones de cada concepto entre los distintos comisionistas */
				fprintf(pfLog ,"\n[vComisionesSubordinadas] Reparte los conceptos del padre en la lista de hijos creada.\n" );
				fprintf(stderr,"\n[vComisionesSubordinadas] Reparte los conceptos del padre en la lista de hijos creada.\n" );
				vReparteComision(paux, raux);
				
				/* pasamos la lista raux, a la lista qaux, para inicial otro ciclo con raux vacio */
				fprintf(pfLog ,"\n[vComisionesSubordinadas] Respalda en Lista Auxiliar la lista de comisionistas hijos.\n" );
				fprintf(stderr,"\n[vComisionesSubordinadas] Respalda en Lista Auxiliar la lista de comisionistas hijos.\n" );
				vConcatenaListas(raux);
			}
		}
	}
	/* Debe realizar el mix entre los comisionistas padres y los comisionistas hijos */
	/* para dejar una única lista de liquidación.                                    */
	fprintf(pfLog ,"\n[vComisionesSubordinadas] Realiza El Merge de las listas, de padres e hijos...\n" );
	fprintf(stderr,"\n[vComisionesSubordinadas] Realiza El Merge de las listas, de padres e hijos...\n" );
	vMergeListas(lstComisionistas, lstAuxiliar);
}
/*---------------------------------------------------------------------------*/
/* Libera la memoria utilizada por las estructuras de proceso...             */
/*---------------------------------------------------------------------------*/
void vLiberaConceptos(stConceptos * paux)
{
	if (paux == NULL)
		return;
	vLiberaConceptos(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
void vLiberaUniverso(stUniverso * paux)
{
	stUniverso 	* raux;
	
	if (paux != NULL)
	{
		while ((raux=paux->sgte)!=NULL)
		{
			vLiberaConceptos(paux->sgte_concepto);
			vLiberaConceptos(paux->sgte_ajuste);
			vLiberaConceptos(paux->sgte_anticipo);
			free (paux);
			paux = raux;
		}
		if (paux != NULL)
		{
			vLiberaConceptos(paux->sgte_concepto);
			vLiberaConceptos(paux->sgte_ajuste);
			vLiberaConceptos(paux->sgte_anticipo);
			free (paux);
		}
	}
}
/*---------------------------------------------------------------------------*/
void vLiberaCriticos(stCriticos * paux)
{
	if (paux == NULL)
		return;
	vLiberaCriticos(paux->sgte);
	free(paux);
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));
    memset(&stCiclo, 0, sizeof(reg_ciclo));
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
    memset(&proceso, 0, sizeof(proceso));
    stArgs.bFlagUser     		= FALSE;
	stStatusProc.lLiquidaciones = 0;
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
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
        fprintf(stderr, "Error [%d] al escribir en TRAZA de Proceso.\n", ibiblio);                     
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
/*------------------------------------------------------------*/        
/* Ingresa parametros para estructura que crea archivo de Log */
/*------------------------------------------------------------*/  
    strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
    strncpy(szhSysDate, pszGetDateLog(),16);
    strcpy(stArgsLog.szProceso,LOG_NAME);
    strncpy(stArgsLog.szSysDate,szhSysDate,16);
    sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)
    {
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);
        fprintf(stderr, "Revise su existencia.\n");
        fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
        fprintf(stderr, "Proceso finalizado con error.\n");
                exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE LOG NO PUDO SER ABIERTO.",0,0));
    }
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
	lSegIni=lGetTimer(); 
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
    fprintf(pfLog, "\nUsuario ORACLE      :[ %s ]\n",(char * )sysGetUserName()); 
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
 sqlstm.offset = (unsigned int  )1044;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError_2();
}


/*---------------------------------------------------------------------------*/
/* Procesamiento principal.                                                  */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inicio procesamiento principal ...\n\n");
/*---------------------------------------------------------------------------*/
/*    - Recupera fechas que conforman periodo del parametro.                 */
/*---------------------------------------------------------------------------*/
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
/*---------------------------------------------------------------------------*/
/*    - Cargando Parametros                                                  */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Cargando Parametros Para Calculo de Impuestos...\n\n");
    fprintf(stderr, "Cargando Parametros Para Calculo de Impuestos...\n\n");
    vCargaParametros();
/*---------------------------------------------------------------------------------------------*/
/*    - Carga universo de Registros  de bonos/comisiones   a considerar para el calculo.       */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog , "Carga universo de registros de bonos/comisiones/ajustes/anticipos a considerar para el calculo....\n\n");
    fprintf(stderr, "Carga universo de registros de bonos/comisiones/ajustes/anticipos a considerar para el calculo....\n\n");
    vCargaDatosLiquidacion();
/*---------------------------------------------------------------------------------------------*/
/* Evalua la existencia de Tipos de Red con Ind_Aplica_Subordinada en 'S', para repartir las   */
/* comisiones entre sus hijos directos.                                                        */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Reparte Comisiones para Tipos de Red con Comisión Subordinada.\n\n");
    fprintf(stderr,"Reparte Comisiones para Tipos de Red con Comisión Subordinada.\n\n");
	vComisionesSubordinadas();
/*---------------------------------------------------------------------------------------------*/
/* Totaliza los conceptos en nodo Padre...                                                     */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Totaliza los conceptos en nodo Padre.\n\n");
    fprintf(stderr, "Totaliza los conceptos en nodo Padre.\n\n");
    vTotalizaLiquidaciones();
/*---------------------------------------------------------------------------------------------*/
/*    - Aplica impuestos a la lista de liquidaciones cargadas.                                 */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Aplica Criterios de Impuestos a las liquidaciones de Comisiones.\n\n");
    fprintf(stderr, "Aplica Criterios de Impuestos a las liquidaciones de Comisiones.\n\n");
	vCalculaImpuestos();
/*---------------------------------------------------------------------------------------------*/
/*    - Crea lista de conceptos criticos.                                                      */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Crea lista de conceptos criticos.\n\n");
    fprintf(stderr,"Crea lista de conceptos criticos.\n\n");
	vCreaConceptosCriticos();
/*---------------------------------------------------------------------------------------------*/
/*    - Evalua existencia de Conceptos Criticos, y Marca Liquidaciones.                        */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Evalua existencia de Conceptos Criticos, y Marca Liquidaciones.\n\n");
    fprintf(stderr,"Evalua existencia de Conceptos Criticos, y Marca Liquidaciones.\n\n");
	vEvaluaCriticos();
/*---------------------------------------------------------------------------------------------*/
/*    - Inserta los registros procesados en tablas de Liquidacion.                             */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Inserta los registros procesados en tablas de Liquidacion.\n\n");
    fprintf(stderr, "Inserta los registros procesados en tablas de Liquidacion.\n\n");
	vInsertaLiquidacion();
/*---------------------------------------------------------------------------------------------*/
/*    - Marca los registros de ajustes y anticipos como liquidados.                            */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Marca los registros de ajustes y anticipos como liquidados.\n\n");
    fprintf(stderr, "Marca los registros de ajustes y anticipos como liquidados.\n\n");
	vMarcaAjustesAnticipos();
/*---------------------------------------------------------------------------------------------*/
/*    - MUESTRA EL CONTENIDO DE LA ESTRUCTURA....                                              */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();                                                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Muestra el contenido de la estructura....\n\n");  
    fprintf(stderr, "Muestra el contenido de la estructura......\n\n");                     
    vMuestraListas(lstComisionistas);
/*---------------------------------------------------------------------------------------------*/
/*    - Libera las estructuras cargadas en memoria.                                            */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();                                                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Libera las estructuras cargadas en memoria.\n\n");  
    fprintf(stderr, "Libera las estructuras cargadas en memoria.\n\n");                     
	vLiberaUniverso(lstComisionistas); 
	vLiberaCriticos(lstCriticos);
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();                            
    stStatusProc.lSegProceso = lSegFin - lSegIni;   
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\nEstadistica del proceso\n");
    fprintf(pfLog, "-----------------------------------------\n");
    fprintf(pfLog, "Segundos Reales Utilizados         : [%ld]\n", stStatusProc.lSegProceso);
    fprintf(pfLog, "Cantidad Comisiones Cargadas       : [%ld]\n", stStatusProc.lComisiones);
    fprintf(pfLog, "Cantidad Ajustes Cargados          : [%ld]\n", stStatusProc.lAjustes);
    fprintf(pfLog, "Cantidad Anticipos                 : [%ld]\n", stStatusProc.lAnticipos);
	fprintf(pfLog, "Cantidad Liquidaciones Generadas   : [%ld]\n", stStatusProc.lLiquidaciones);

    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lLiquidaciones);
    if (ibiblio)
            exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1059;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_2();
}



    fprintf(pfLog , "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
    fprintf(stderr, "\n\nProceso [%s] finalizado ok.\n", basename(argv[0]));
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

