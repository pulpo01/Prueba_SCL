
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
    "./pc/ResPac.pc"
};


static unsigned int sqlctx = 865539;


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
   unsigned char  *sqhstv[30];
   unsigned long  sqhstl[30];
            int   sqhsts[30];
            short *sqindv[30];
            int   sqinds[30];
   unsigned long  sqharm[30];
   unsigned long  *sqharc[30];
   unsigned short  sqadto[30];
   unsigned short  sqtdso[30];
} sqlstm = {12,30};

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

 static const char *sq0017 = 
"select des_parametro  from ged_parametros where ((nom_parametro like :b0 and\
 cod_modulo=:b1) and cod_producto=:b2) order by nom_parametro            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,31,163,0,0,0,0,0,1,0,
20,0,0,2,0,0,29,174,0,0,0,0,0,1,0,
35,0,0,3,289,0,6,306,0,0,9,9,0,1,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,
97,0,0,2,5,0,0,1,97,0,0,2,3,0,0,
86,0,0,4,75,0,4,595,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
109,0,0,5,154,0,5,640,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,
148,0,0,6,61,0,4,741,0,0,2,1,0,1,0,2,5,0,0,1,97,0,0,
171,0,0,7,197,0,4,754,0,0,4,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,
202,0,0,8,95,0,4,768,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
229,0,0,9,95,0,4,783,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
256,0,0,10,95,0,4,799,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
283,0,0,11,102,0,4,815,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
310,0,0,12,95,0,4,836,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
337,0,0,13,95,0,4,851,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
364,0,0,14,95,0,4,866,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
391,0,0,15,73,0,4,888,0,0,2,1,0,1,0,1,5,0,0,2,5,0,0,
414,0,0,16,118,0,4,908,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
445,0,0,17,149,0,9,936,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
472,0,0,17,0,0,13,949,0,0,1,0,0,1,0,2,97,0,0,
491,0,0,17,0,0,15,974,0,0,0,0,0,1,0,
506,0,0,18,118,0,4,999,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
537,0,0,19,90,0,4,1022,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
564,0,0,20,129,0,4,1042,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
595,0,0,21,129,0,4,1062,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
626,0,0,22,429,0,4,1263,0,0,15,10,0,1,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,
701,0,0,23,703,0,4,1486,0,0,24,8,0,1,0,1,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
812,0,0,24,51,0,4,1566,0,0,1,0,0,1,0,2,3,0,0,
831,0,0,25,545,0,3,1587,0,0,29,29,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
962,0,0,26,51,0,4,1617,0,0,1,0,0,1,0,2,3,0,0,
981,0,0,27,561,0,3,1630,0,0,30,30,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1116,0,0,28,561,0,3,1660,0,0,30,30,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1251,0,0,29,156,0,4,1710,0,0,6,5,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,3,0,0,
1290,0,0,30,117,0,4,1755,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
1321,0,0,31,132,0,4,1807,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
};


 	/*=============================================================================
   Nombre     : ResPac.pc
   Programa   : Actualiza Respuesta Banco para los pagos Pac
   Autor      : G.A.C  
   Creado     : 02 - Febrero - 2003 
  ============================================================================= */
#include <stdlib.h> 
#include <stdio.h>
#include <string.h>
#include <pasoc.h>
#include <unistd.h>
#include <ctype.h>
#include "ResPac.h"    
/*---------------------------------------------------------------------------*/
/* Inclusion de	biblioteca para	manejo de interaccion con Oracle.	         */
/*---------------------------------------------------------------------------*/
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

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con	Oracle.		         */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char   szSysdate          [11]; /* EXEC SQL VAR szSysdate 			IS STRING(11); */ 

    char   szHora             [11]; /* EXEC SQL VAR szHora    			IS STRING(11); */ 

    char   szFechayyyymmdd    [9] ; /* EXEC SQL VAR szFechayyyymmdd    IS STRING(9) ; */ 

    char   szyyyymmddhhmm     [13]; /* EXEC SQL VAR szyyyymmddhhmm     IS STRING(13); */ 

    char   szhAceptado        [5] ; /* EXEC SQL VAR szhAceptado        IS STRING(5) ; */ 

    char   szhRechazado       [5] ; /* EXEC SQL VAR szhRechazado       IS STRING(5) ; */ 

    char   szhCod_Formato     [7] ; /* EXEC SQL VAR szhCod_Formato     IS STRING(7) ; */ 

    char   szhCod_Banco       [16]; /* EXEC SQL VAR szhCod_Banco       IS STRING(16); */ 

    char   szhPosClienteTmm1  [5] ; /* EXEC SQL VAR szhPosClienteTmm1  IS STRING(5) ; */ 

    char   szhPosClienteTmm2  [5] ; /* EXEC SQL VAR szhPosClienteTmm2  IS STRING(5) ; */ 

    char   szhPosClienteTmm3  [5] ; /* EXEC SQL VAR szhPosClienteTmm3  IS STRING(5) ; */ 

    char   szhPosClienteTmm4  [5] ; /* EXEC SQL VAR szhPosClienteTmm4  IS STRING(5) ; */ 

    char   szhPosAprobadoTmm1 [5] ; /* EXEC SQL VAR szhPosAprobadoTmm1 IS STRING(5) ; */ 

    char   szhPosAprobadoTmm2 [5] ; /* EXEC SQL VAR szhPosAprobadoTmm2 IS STRING(5) ; */ 

    char   szhPosAprobadoTmm3 [5] ; /* EXEC SQL VAR szhPosAprobadoTmm3 IS STRING(5) ; */ 

    char   szhPosAprobadoTmm4 [5] ; /* EXEC SQL VAR szhPosAprobadoTmm4 IS STRING(5) ; */ 


    char   szhPosClienteGUA   [5] ; /* EXEC SQL VAR szhPosClienteGUA   IS STRING(5) ; */ 

    char   szhPosClienteSAL   [5] ; /* EXEC SQL VAR szhPosClienteSAL   IS STRING(5) ; */ 

    char   szhIndRechazoGUA   [15]; /* EXEC SQL VAR szhIndRechazoGUA   IS STRING(15); */ 

    char   szhIndRechazoSAL   [15]; /* EXEC SQL VAR szhIndRechazoSAL   IS STRING(15); */ 

    char   szhPosClieFinSAL   [5] ; /* EXEC SQL VAR szhPosClieFinSAL   IS STRING(5) ; */ 


    char   szhPosAprobadoFUnico   [5] ; /* EXEC SQL VAR szhPosAprobadoFUnico    IS STRING(5); */ 

    char   szhPosClienteFUnico    [5] ; /* EXEC SQL VAR szhPosClienteFUnico     IS STRING(5); */ 

    char   szhPosRespuFUnico      [5] ; /* EXEC SQL VAR szhPosRespuFUnico       IS STRING(5); */ 

    char   szhPosAprobadoArchTmm3 [5] ; /* EXEC SQL VAR szhPosAprobadoArchTmm3  IS STRING(5); */ 

    char   szhClaveEstablecimiento[8] ; /* EXEC SQL VAR szhClaveEstablecimiento IS STRING(8); */ 

    char   szhPosEstadoArchTmm3   [3] ; /* EXEC SQL VAR szhPosEstadoArchTmm3    IS STRING(3); */ 

    char   szhCodOperadora        [6] ; /* EXEC SQL VAR szhCodOperadora         IS STRING(6); */ 

    
    /* variablres bind */
    int  ihValorCero    ;
    int  ihValorUno     ;
    int  ihValorTres    ;
    int  iDecimal       ;
    char szhddmmyyyy    [11]; 
    char szhhhmiss      [11];
    char szhyyyymmdd    [9] ;
    char szhyyyymmddhhmi[15];

    /* Inicio Incidencia 120541 - 06.01.2010 */
    char szhLetra_X            [2]; /* EXEC SQL VAR szhLetra_X         IS STRING   (2); */ 

    char szhNomOperadora      [51]; /* EXEC SQL VAR szhNomOperadora    IS STRING  (51); */ 
 
    char szhAsunto           [101]; /* EXEC SQL VAR szhAsunto          IS STRING (101); */ 
 
    char szhTextoCorreo     [1001]; /* EXEC SQL VAR szhTextoCorreo     IS STRING(1001); */ 
 
    char zshFormatoMonto      [21]; /* EXEC SQL VAR zshFormatoMonto    IS STRING  (21); */ 
 
    char szhICG_MENSA         [12]; /* EXEC SQL VAR szhICG_MENSA       IS STRING  (12); */ 
 
	char szhCOD_MENSA         [12]; /* EXEC SQL VAR szhCOD_MENSA       IS STRING  (12); */ 
 
	char szhCodMensaje         [4]; /* EXEC SQL VAR szhCodMensaje      IS STRING   (4); */ 

	char szhLetraA             [2]; /* EXEC SQL VAR szhLetraA          IS STRING   (2); */ 

    char szhLetraD             [2]; /* EXEC SQL VAR szhLetraD          IS STRING   (2); */ 

    char szhLetraG             [2]; /* EXEC SQL VAR szhLetraG          IS STRING   (2); */ 

    char szhBAA                [4]; /* EXEC SQL VAR szhBAA             IS STRING   (4); */ 

    char szhRutinaMensaje      [6]; /* EXEC SQL VAR szhRutinaMensaje   IS STRING   (6); */ 

    char szhModulo             [3]; /* EXEC SQL VAR szhModulo          IS STRING   (3); */ 

    char szhPendiente         [10]; /* EXEC SQL VAR szhPendiente       IS STRING  (10); */ 

    char szhS                  [2]; /* EXEC SQL VAR szhS               IS STRING   (2); */ 

    
    int  ihEnvioEmail             ;
    int  ihEnvioSms               ;
	int  ihCodCentralMens	      ;
	char szhTextoCorreoPaso [1001]; 
    /* Fin Incidencia 120541 - 06.01.2010 */
    
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* Definicion de estructuras globales 					                     */
/*---------------------------------------------------------------------------*/
static  RESPAC stResPac;

/*===========================================================================*/
/* Rutina Principal							                                 */
/*===========================================================================*/
int main (int argc, char* argv[])
{
char modulo[]="Main";
/*---------------------------------------------------------------------------*/
/* Variables Globales.							                             */
/*---------------------------------------------------------------------------*/
int  iResultado , iFinProc=TRUE ;
/*---------------------------------------------------------------------------*/
/* Inicializacion de variables.			     			                     */
/*---------------------------------------------------------------------------*/
	iResultado  = 0;   
	strcpy(szhddmmyyyy    ,"dd-mm-yyyy");
	strcpy(szhhhmiss      ,"hh24:mi:ss");
	strcpy(szhyyyymmdd    ,"yyyymmdd");
	strcpy(szhyyyymmddhhmi,"yyyymmddhh24mi");
	ihValorCero=0;
	ihValorUno =1;
	ihValorTres=3;

/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura	utilizadas 				                     */
/*---------------------------------------------------------------------------*/
    memset (&stStatus,0,sizeof (STATUS));
	memset (&stResPac,0,sizeof (RESPAC));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos	ingresados como	parametros externos.		         */
/*---------------------------------------------------------------------------*/
	iResultado = ifnManejaArgumentos(argc, argv);
	if (iResultado < 0) return -1;
/*---------------------------------------------------------------------------*/
/* Conexion a Oracle							                             */
/*---------------------------------------------------------------------------*/
   if (!bfnConnectORA (stResPac.szUsuario,stResPac.szPassWord))  {
        fprintf (stderr,"\n\t=>Error en la Conexion Oracle\n");
        return   -1 ;
   }
/*---------------------------------------------------------------------------*/
/* Inicializacion del Proceso RESPAC					                     */
/*---------------------------------------------------------------------------*/		
   if (ifnInicio(&stResPac,&stStatus)!=0)  return -1;
      
/*---------------------------------------------------------------------------*/
/* Header.								                                     */
/*---------------------------------------------------------------------------*/	
   fprintf(stdout, "\nProcesando ...\n");                                        
   vDTrazasLog( modulo, "%s\n"      ,LOG03 , szRaya);                    
   vDTrazasLog( modulo, "FECHA            [%s %s]",LOG03 , szSysdate,szHora);
   vDTrazasLog( modulo, "PROGRAMA         [%s]",LOG03 , LOGNAME    );                
   vDTrazasLog( modulo, "%s"                   ,LOG03 , GLOSA_PROG );                
   vDTrazasLog( modulo, "VERSION          [%s]",LOG03 , szhVersion );      
   vDTrazasLog( modulo, "Ultima Revision  [%s]",LOG03 , LAST_REVIEW);                
   vDTrazasLog( modulo, "%s\n\n"    ,LOG03, szRaya);               

   fprintf( stdout, "%s\n"      , szRaya);
   fprintf( stdout, "FECHA            [%s %s]\n", szSysdate,szHora);
   fprintf( stdout, "PROGRAMA         [%s]\n", LOGNAME    );
   fprintf( stdout, "%s\n"                   , GLOSA_PROG );
   fprintf( stdout, "VERSION          [%s]\n", szhVersion );
   fprintf( stdout, "Ultima Revision  [%s]\n", LAST_REVIEW);
   fprintf( stdout, "%s\n\n"    , szRaya);
   
/*---------------------------------------------------------------------------*/
/* Proceso RESPAC  -  Principal						                         */
/*---------------------------------------------------------------------------*/		       
	if (ifnProcesoGen()!=0) {
   	   iFinProc=FALSE;
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
}


       if (SQLCODE != SQLOK) {
            iDError(modulo,ERR000,vInsertarIncidencia,"ROLLBACK WORK.\n ",SQLERRM);
            return -1;
       }

       fclose(stStatus.LogFile);
	   fclose(stStatus.ErrFile);
       return -1;
	}
 
    /* EXEC SQL COMMIT WORK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )20;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"COMMIT WORK.\n ",SQLERRM);
        return -1;
    }

/*---------------------------------------------------------------------------*/
/* Desconexion de Oracle 						                             */
/*---------------------------------------------------------------------------*/
 	iResultado = ifnDesconexionOracle();
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion	estadistica del	proceso.		             */
/*---------------------------------------------------------------------------*/

    vDTrazasLog( modulo, "\n%s"      ,LOG03 , szRaya);                    
	vDTrazasLog( modulo,  "Estadistica del proceso", LOG03);								 
    vDTrazasLog( modulo, "%s"      ,LOG03 , szRaya);                    
    vDTrazasLog( modulo,  "Cantidad de Registros Procesados   [%d]", LOG03,iCan_Reg);			       
    vDTrazasLog( modulo,  "Cantidad de Registros Actualizados [%d]", LOG03,iCan_Reg-iReg_Act);
    vDTrazasLog( modulo,  "Cantidad de Registros Fallidos     [%d]\n", LOG03,iReg_Act);
	if (iFinProc)  vDTrazasLog( modulo,  "Proceso [%s] finalizado Ok.\n\n\n"      , LOG03,LOGNAME );
  
    if (iFinProc)  {
	   fprintf(stdout, "\nEstadistica del proceso\n");
	   fprintf(stdout,	"------------------------\n");
	   fprintf(stdout, "Cantidad de Registros Procesados   [%d]\n",iCan_Reg);			       																      
	   fprintf(stdout, "Cantidad de Registros Actualizados [%d]\n",iCan_Reg-iReg_Act);			       																      
	   fprintf(stdout, "Cantidad de Registros Fallidos     [%d]\n\n",iReg_Act);
	   fprintf(stdout, "Proceso [%s] finalizado ok.\n\n\n"      ,LOGNAME );
    } else 
	   fprintf(stdout,"\n\t* Proceso genero Anomalias. Favor Revisar. *\n\n");
	
/*---------------------------------------------------------------------------*/
/* Cerrando Archivos Log y Err.						                         */
/*---------------------------------------------------------------------------*/
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);

    return 0; 
}/***************************** Final main ***********************************/


/*===========================================================================*/
/* Manejo de argumentos	ingresados como	parametros externos.		         */
/*===========================================================================*/
int  ifnManejaArgumentos(int argc, char * const argv[])
{
extern char *optarg;
char modulo[]="ifnManejaArgumentos";
char opt[]   = "u:l:n:c:f:";
int  iOpt    = 0    ;

char szUsuario[61] = "" ;
char *pszTmp       = "" ;
    
    stResPac.bOptFile=FALSE;
    while ( (iOpt = getopt (argc,argv,opt)) != EOF) {
        switch (iOpt) {
            case 'u':  
                if ( strlen (optarg) ) {
                    strcpy (szUsuario,optarg)  ;
                    stResPac.bOptUsuario = TRUE;
                }
                break;
            case 'l': 
                if ( strlen (optarg) ) {
                    stResPac.bOptNivelLog = TRUE         ;
                    stResPac.iNivelLog    = atoi (optarg);
                }
                break;   
            case 'c': 
                if ( strlen (optarg) ) {
                    stResPac.bOptBanco = TRUE         ;
                    strcpy (stResPac.szCod_Banco,optarg);
                }
                break;   
            case 'f': 
                if ( strlen (optarg) ) {
                    strcpy (stResPac.szFile,optarg)  ;
                    stResPac.bOptFile = TRUE;
                }
                break;   
        }/* fin switch */
    }/* fin While de Opciones */

    if (!stResPac.bOptUsuario) {
		fprintf (stderr,"\n\t=> Version => [%s]\n\n", szhVersion);
		fprintf (stderr,"\n\t=> Error Faltan Parametros de Entrada: \n%s\n\n",szUsage);
		return  -1 ;

    } else {
       
       if ( (pszTmp = (char *)strstr (szUsuario,"/"))==(char *)NULL) {
             fprintf (stderr,"\n\t=>Formato Usuario Oracle Incorrecto:\n%s\n\n",szUsage);
             return -1;

       } else {
             strncpy (stResPac.szUsuario ,szUsuario,pszTmp-szUsuario);
             strcpy  (stResPac.szPassWord, pszTmp+1);
       }
    }
    
    if (!stResPac.bOptNivelLog)
         stResPac.iNivelLog = LOG03;

    if (stResPac.bOptFile)
        sprintf(szFileName,"%s\0",stResPac.szFile);
    else {
        fprintf (stderr,"\n\t=>Error Faltan Parametro de Archivo: \n%s\n\n",szUsage);
        return -1;
	}    

    if (!stResPac.bOptBanco) {
        fprintf (stderr,"\n\t=>Error Faltan Parametros de Banco: \n%s\n\n",szUsage);
        return -1;
    }

	return 0;
}/* ifnManejaArgumentos */

/*===========================================================================*/
/* Funcion : bfnInicio                                                       */
/*===========================================================================*/
int ifnInicio ( RESPAC *stResPac, STATUS *pstStatus )
{
int  iRes=0;
char modulo[]="ifnInicio";

   pstStatus->OraConnected = 1;
	/*-----------------------------------------------------------------------*/
	/* Obtenemos la Fecha y hora del Sistema 				                 */
	/*-----------------------------------------------------------------------*/    
	/* EXEC SQL EXECUTE
		BEGIN
			:szSysdate		:=TO_CHAR(SYSDATE,:szhddmmyyyy);
			:szHora			:=TO_CHAR(SYSDATE,:szhhhmiss);
            :szFechayyyymmdd:=TO_CHAR(SYSDATE,:szhyyyymmdd);
            :szyyyymmddhhmm :=TO_CHAR(SYSDATE,:szhyyyymmddhhmi);
            :iDecimal       :=GE_PAC_GENERAL.PARAM_GENERAL('num_decimal');
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szSysdate := TO_CHAR ( SYSDATE , :szhddmmyyyy ) ; :sz\
Hora := TO_CHAR ( SYSDATE , :szhhhmiss ) ; :szFechayyyymmdd := TO_CHAR ( SYSDA\
TE , :szhyyyymmdd ) ; :szyyyymmddhhmm := TO_CHAR ( SYSDATE , :szhyyyymmddhhmi \
) ; :iDecimal := GE_PAC_GENERAL . PARAM_GENERAL ( 'num_decimal' ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )35;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szSysdate;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhddmmyyyy;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szHora;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhhhmiss;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szFechayyyymmdd;
 sqlstm.sqhstl[4] = (unsigned long )9;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhyyyymmdd;
 sqlstm.sqhstl[5] = (unsigned long )9;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szyyyymmddhhmm;
 sqlstm.sqhstl[6] = (unsigned long )13;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhyyyymmddhhmi;
 sqlstm.sqhstl[7] = (unsigned long )15;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&iDecimal;
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



	/*-----------------------------------------------------------------------*/
    /* Inicializacion de Archivos LOG y ERR					                 */
	/*-----------------------------------------------------------------------*/
    if (ifnAbreArchivosLog()!=0)  return -1;
    
    strcpy (modulo,"Resp Banco Pac");
    pstStatus->LogNivel = stResPac->iNivelLog;
        
    vDTrazasError(modulo,
    "\n     *******************************************************************"
    "\n     *%s     ERRORES EN RES.PAC            HORA : %s        *"
    "\n     *******************************************************************\n", LOG03,szhVersion,szHora);
    
    return 0;
}/* ifnInicio */ 

/*===========================================================================*/
/* Funcion : ifnProcesoGen                                                   */
/*===========================================================================*/
int ifnProcesoGen ()
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de Variables  					                         */
/*---------------------------------------------------------------------------*/
char  modulo[]="ifnProcesoGen";
char  szReg_Leido  [LARGOREG];
char  szAux        [LARGOREG];
char  aux2         [9];
char  aux3         [9];
char  szCod_Cliente[21];
int   iFlag = 0;
int   iRes  = 0;
int   z;
int   x;
long  lCodCliente;
/*Inicio CSR-11002*/
char codRechazo[2+1];
char descRechazo[50+1];
int iCodRechazo;
/*Fin CSR-11002*/
   vDTrazasLog (modulo,"\n\t Funcion ifnProcesoGen()",LOG03);

   /*-----------------------------------------------------------------------*/
   /* Obtener los valores parametricos de PAC				                */
   /*-----------------------------------------------------------------------*/
   if (ifnValParametrosPAC()!=0) return -1;
   
   /*-----------------------------------------------------------------------*/
   /* Abre el Archivo Plano						                            */
   /*-----------------------------------------------------------------------*/
   if (ifnOpenFileDat()!=0) return -1;
   iCan_Reg=0;

   vDTrazasLog (modulo,"\n\t Iniciando Lectura de Archivo\n",LOG03);
   iFlag=0;
   while (!feof(fpDat)) {
        
	  memset(&szReg_Leido,'\0',sizeof(szReg_Leido));		
      fgets(szReg_Leido,LARGOREG,fpDat);
      
      /* Inicio Incidencia 120541 - 13.01.2010 */		
	  /*-------------------------------------------------------------------*/
      /* Leyendo Formato de Archivo GUA1 - GUA2                			   */
	  /*-------------------------------------------------------------------*/        
      if ( (strcmp(szhCod_Formato,GUA1)==0) || (strcmp(szhCod_Formato,GUA2)==0)) {

	       sprintf(szAux,"%s\0",szReg_Leido);
	       z=0;
		   if (iFlag==0) {
		          
		          /* Transformando a MAYUSCULA */
		          for (x=0;szAux[x];x++) {
			            szAux[x]=toupper(szAux[x]);      
			      } /* Fin del for */
		          
					if (toupper(szAux[0])== 'T') 
					{
						for (x=0;x<strlen(szAux);x++) 
						{
							if (szAux[x]==szhIndRechazoGUA[z]) 
							{
								strncpy(aux2,&szAux[x],8);
								if (strcmp(aux2,szhIndRechazoGUA)==0)	 
								{
									z++;
									iFlag = 1;			                      			                      			                      
								}
							}
						} /* end for */
						fgets(szReg_Leido,LARGOREG,fpDat);
						fgets(szReg_Leido,LARGOREG,fpDat);
					} 
					else 
					{          		  	    
						if (isdigit(szAux[0])) 
						{
							memset(szCod_Cliente,'\0',sizeof(szCod_Cliente));
							iRes = ifnBuscaCliente(atoi(szhPosClienteGUA), strlen(szAux), szAux, szCod_Cliente, 0);	       		       	      	       		       	      
							lCodCliente = atol(szCod_Cliente);
							vDTrazasLog (modulo,"\t Registro Aceptado - szCod_Cliente [%s]\n",LOG07,szCod_Cliente);
							
							if (ifnUpdatePAC(atol(szCod_Cliente),0)!=0) 
								return -1 ;
	
							iCan_Reg++;          		  		                       		  	 		
						} 
						else 
						{
							vDTrazasLog (modulo,"\t Salto de linea \n",LOG09);
						}	
					}
		          		          
			} 
			else 
			{
				memset(szCod_Cliente,'\0',sizeof(szCod_Cliente));
				iRes = ifnBuscaCliente(atoi(szhPosClienteGUA), strlen(szAux), szAux, szCod_Cliente, 0);	       		       	      	       		       	      
				lCodCliente = atol(szCod_Cliente);
				
				if ((ihEnvioEmail == 0) && (ihEnvioSms == 0)) 
				{
					iRes = ifnEnviaMensajes(lCodCliente);
					if (iRes < 0) 
						return -1;
					
					if (iRes == 0) 
					{
						vDTrazasLog (modulo,"\t Registro Rechazado - szCod_Cliente [%s]\n",LOG07,szCod_Cliente);
						if (ifnUpdatePAC(lCodCliente,atoi(szhRechazado))!=0) 
							return -1 ;                      	  	
					}
				}
				iCan_Reg++;	       	      
			} /* if (iFlag==0) */       	        	        	
       	        	        	 
      } /*if ( (strcmp(szhCod_Formato,GUA1)==0) || (strcmp(szhCod_Formato,GUA2)==0))*/
      /* Fin Incidencia 120541 - 06.01.2010 */				       	  

	  /*-------------------------------------------------------------------*/
      /* Leyendo Formato de Archivo SAL1 - SAL2 - SAL3                     */
	  /*-------------------------------------------------------------------*/        
      if ((strcmp(szhCod_Formato,SAL1)==0) || (strcmp(szhCod_Formato,SAL2)==0) || (strcmp(szhCod_Formato,SAL3)==0) ) {

           if (iFlag==0) {
	           /* se leen los 7 primeros registros */
               fgets(szReg_Leido,LARGOREG,fpDat);
               fgets(szReg_Leido,LARGOREG,fpDat);
               fgets(szReg_Leido,LARGOREG,fpDat);
               fgets(szReg_Leido,LARGOREG,fpDat);
               fgets(szReg_Leido,LARGOREG,fpDat);
               fgets(szReg_Leido,LARGOREG,fpDat);
               vDTrazasLog (modulo,"Leyendo ultimo registro de cabecera[%s]",LOG09,szReg_Leido);
	           iFlag=1;

		   } else {
		       memset(szAux,'\0',sizeof(szAux));
		       sprintf(szAux,"%s\0",szReg_Leido);
		       vDTrazasLog (modulo,"Leyendo Registro [%s]\n",LOG09,szAux);
		       int x=0;
		    
	           for(x=0;x<strlen(szAux);x++) {
				   if (x==atoi(szhIndRechazoSAL)) {
					   memset(aux2,'\0',sizeof(aux2));
					   strncpy(aux2,&szAux[atoi(szhIndRechazoSAL)],1); /* el largo da igual..solo queremos saber si esta nulo o no...capicci maledetto?*/
					   RighTrim(aux2);
					   if (strlen(aux2)<1) { 
				          strncpy(aux3,&szAux[atoi(szhPosClienteSAL)],atol(szhPosClieFinSAL));
				       	  strcpy(szCod_Cliente,aux3);
				       	  vDTrazasLog (modulo,"\t Registro Aceptado - szCod_Cliente [%s]\n",LOG07,szCod_Cliente);
				       	
						  if (ifnUpdatePAC(atol(szCod_Cliente),0)!=0) return -1 ;
						
						  iCan_Reg++;
					   } else {						     

                          /* Inicio Incidencia 120541 - 06.01.2010 */		
                          memset(szCod_Cliente,'\0',sizeof(szCod_Cliente));
                          iRes = ifnBuscaCliente(atoi(szhPosClienteSAL), atoi(szhPosClieFinSAL), szAux, szCod_Cliente,1); 
                          lCodCliente = atol(szCod_Cliente);

                          if ((ihEnvioEmail == 0) && (ihEnvioSms == 0)) {
                          	  iRes = ifnEnviaMensajes(lCodCliente);
                          	  if (iRes < 0) return -1;
                          	  if (iRes == 0) {
						          vDTrazasLog (modulo,"\t Registro Rechazado - szCod_Cliente [%s]\n",LOG07,szCod_Cliente);						 
				       	          if (ifnUpdatePAC(lCodCliente,atoi(szhRechazado))!=0) return -1 ;
				       	      }
                          }
                          /* Fin Incidencia 120541 - 06.01.2010 */				       	  
				       	  				       	  
						  iCan_Reg++;
					   } /* end if (strlen(aux2)<1) */
				  } /* end if (x==atoi(szhIndRechazoSAL)) */
	          }/*end for*/
	      }/* end if (iFlag==0)*/
      } /* end if ((strcmp(szhCod_Formato,SAL1)==0) || (strcmp(szhCod_Formato,SAL2)==0) || (strcmp(szhCod_Formato,SAL3)==0) )*/
      /*Inicio CSR-11002*/   
	  if (strcmp(szhCod_Formato, CSR1) == 0)
	  {
		  if(strlen(szReg_Leido) == 152 || strlen(szReg_Leido) == 151) //El registro tiene 152 caracteres de largo en todos las filas menos la ultima.
		  {
			  vfnSubString(szCod_Cliente, szReg_Leido, 0, 10);
			  vfnSubString(codRechazo, szReg_Leido, 98, 2);
			  vfnSubString(descRechazo, szReg_Leido, 101, 50);
			  
			  lCodCliente = atol(szCod_Cliente);
			  iCodRechazo = atoi(codRechazo);
			  
			  if(iCodRechazo == 0) // Aceptado
			  {
				  vDTrazasLog (modulo,"\t Registro Aceptado - szCod_Cliente [%s]\n", LOG07, szCod_Cliente);
			  }
			  else //no fue aceptado por algun motivo
			  {
				  if ((ihEnvioEmail == 0) && (ihEnvioSms == 0)) 
				  {
					  
					  iRes = ifnEnviaMensajes(lCodCliente);
					  if (iRes < 0) 
					  {
						  vDTrazasLog (modulo,"\t Registro Rechazado - szCod_Cliente [%s] pero no se actualizo en la base de datos debido a un error al enviar mensaje.\n", LOG07, szCod_Cliente);
						  return -1;
					  }
				      else if (iRes == 0) 
					  {
						 vDTrazasLog (modulo, "\t Registro Rechazado - szCod_Cliente [%s] Razon: Cod[%s] %s \n", LOG07, szCod_Cliente, codRechazo, descRechazo);
					  }
				  }
			  }
			  if (ifnUpdatePAC(lCodCliente, iCodRechazo) != 0) 
				  return -1;
		  }
		  else
		  {
			//Error Aca
			vDTrazasLog (modulo, "\t Registro Rechazado -  No cumple con la longitud de caracteres esperada para CSR1. \nEl registro tiene %u , se esperaban 151... \n", LOG07, strlen(szReg_Leido));
		  }
		  iCan_Reg++;
	  } /*end if (strcmp(szhCod_Formato, CSR1) == 0)*/
	  /*Fin CSR-11002*/	 
	} /* end while (!feof(fpDat)) */
	
    return 0;
}

/*===========================================================================*/
/* Funcion que valida que codigo de rechazo no sea letra                     */
/*===========================================================================*/
int ifnValidaString (char *szCod_Aproba)
{
char modulo[]="ifnValidaString";
char *szCod_Valido;
int i;
  /*strcpy(szCod_Valido,szCod_Aproba);*/
  /*vDTrazasLog (modulo,"\t\t  String. %s\n",LOG07,szCod_Aproba);*/
  for (i = 0; i!=strlen(szCod_Aproba);i++){	
     /*vDTrazasLog (modulo,"\t\t  Valor. %c\n",LOG07,szCod_Aproba[i]);	*/
     if (!isdigit(szCod_Aproba[i]))
        return 0;
     }
   return 1;     
}


/*===========================================================================*/
/* Funcion que valida codigo de rechazo                                      */
/*===========================================================================*/
int ifnValidaCodRechazo(char *szCod_Aproba) 
{
char modulo[]="ifnValidaCodRechazo";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

  int  ihCod_Respuesta  ;
  int  ihCount		;
/* EXEC SQL END DECLARE SECTION ; */ 


    if (ifnValidaString(szCod_Aproba)){
          
        vDTrazasLog (modulo,"\t\t  Validacion OK Respuesta %ld\n",LOG07,atoi(szCod_Aproba));	 	  
	    ihCod_Respuesta= atoi(szCod_Aproba);
	    /* EXEC SQL
	    SELECT COD_RESPUBANCO INTO :ihCount
	    FROM   CO_RESPUBANCO
	    WHERE  COD_RESPUBANCO = :ihCod_Respuesta; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_RESPUBANCO into :b0  from CO_RESPUBANCO where\
 COD_RESPUBANCO=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )86;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCount;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCod_Respuesta;
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


	            
        if ((SQLCODE != SQLOK) && (SQLCODE != NOTFOUND)){
            iDError(modulo,ERR000,vInsertarIncidencia,"SELECT FROM CO_RESPUBANCO. ",SQLERRM);        
            return -1;
        }
          
        if (SQLCODE == NOTFOUND) {
   	        vDTrazasLog (modulo,"\t\t  Codigo no existe. Se asumira valor 1\n",LOG03);
	     	return 100;   
	    }
          
	    return 0;
    }else{
        vDTrazasLog (modulo,"\t\t  Codigo no es Numerico. Se asumira valor 4\n",LOG03);
	  	return 4;
    }
       
}

/*===========================================================================*/
/* Funcion que actualiza la co_pagospac                                      */
/*===========================================================================*/
int ifnUpdatePAC (long lCod_Cliente, int iRespuesta)
{
char modulo[]="ifnUpdatePAC";
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		             */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long   lhCod_Cliente    ;
    int    ihRespuBanco     ;
/* EXEC SQL END DECLARE SECTION; */ 
 

    vDTrazasLog (modulo,"\n\t Funcion ifnUpdatePAC ()",LOG03);
    
    lhCod_Cliente=lCod_Cliente;
    ihRespuBanco =iRespuesta;
    vDTrazasLog (modulo,"\t\t lhCod_Cliente   [%ld] ",LOG03,lhCod_Cliente);
    vDTrazasLog (modulo,"\t\t ihRespuBanco    [%d]  ",LOG03,ihRespuBanco );
    vDTrazasLog (modulo,"\t\t szhCodOperadora [%s]\n",LOG03,szhCodOperadora);
	
	/* EXEC SQL
	UPDATE CO_PAGOSPAC SET
	       COD_RESPUBANCO = :ihRespuBanco,
	       IND_PROCESADO  = :ihValorUno
	WHERE  COD_CLIENTE    = :lhCod_Cliente
	AND    IND_CANCELADO  = :ihValorCero
	AND    IND_PROCESADO  = :ihValorCero
	AND    COD_OPERADORA  = :szhCodOperadora; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_PAGOSPAC  set COD_RESPUBANCO=:b0,IND_PROCESADO=:b1\
 where (((COD_CLIENTE=:b2 and IND_CANCELADO=:b3) and IND_PROCESADO=:b3) and CO\
D_OPERADORA=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )109;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihRespuBanco;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValorUno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Cliente;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValorCero;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCero;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[5] = (unsigned long )6;
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


    
	if (SQLCODE == NOTFOUND) {
       vDTrazasLog (modulo,"Cliente no Existe en Co_PagosPac - %s",LOG02,SQLERRM );
   	   iReg_Act++;
       return 0;
    }
    
    if (SQLCODE != SQLOK) {
       iDError(modulo,ERR000,vInsertarIncidencia,"UPDATE CO_PAGOSPAC SET. ",SQLERRM);        
   	   iReg_Act++;
       return -1;
    }
    
    vDTrazasLog (modulo,"\t\t  Tabla CO_PAGOSPAC actualizada con respuesta del banco en [%d]\n",LOG03,ihRespuBanco);
   
    return 0;
}/*ifnUpdatePAC*/

/*===========================================================================*/
/* Funcion que rescata los parametros de cargos                              */
/*===========================================================================*/
int ifnValParametrosPAC()
{
char modulo[]="ifnValParametrosPAC";

/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		                 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhBanco             [16];
    char szhPAC_ACEP          [9];
    char szhPAC_RECH          [9];

    char szhPOS_CLIE_GUA      [13];
    char szhPOS_CLIE_SAL      [13];
    char szhIND_RECHAZO_GUA   [16];
    char szhIND_RECHAZO_SAL   [19];
    char szhPOS_CLIE_FIN_SAL  [17];
    
    /* Inicio Incidencia 120541 - 06.01.2010 */
	int  iFetchedRows = MAXFETCH;
	int  iRetrievRows = MAXFETCH;	
	int  i;
	int  iRes;
	int  ihCantRegs;
	long lMaxFetch ; 
	long iLastRows ;	
    char szhCodigoMensaje     [12]; /* EXEC SQL VAR szhCodigoMensaje   IS STRING  (12); */ 

	char szhCodigoAsunto      [18]; /* EXEC SQL VAR szhCodigoAsunto    IS STRING  (18); */ 

	char szhTexto             [51]; /* EXEC SQL VAR szhTexto           IS STRING  (51); */ 

	char szhTextoArr[MAXFETCH][51];
	char szhResPacMensaje     [15]; /* EXEC SQL VAR szhResPacMensaje   IS STRING  (15); */ 
 	
	char szhENVIO_MAIL        [12]; /* EXEC SQL VAR szhENVIO_MAIL      IS STRING  (12); */ 
 	
	char szhENVIO_SMS         [11]; /* EXEC SQL VAR szhENVIO_SMS       IS STRING  (11); */ 
 	
    /* Fin Incidencia 120541 - 06.01.2010 */

/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t Funcion ifnValParametrosPAC ()",LOG03);
    sprintf(szhBanco,"%s\0",stResPac.szCod_Banco);
    vDTrazasLog (modulo,"\t\t <<< szBanco  [%s] >>>\n",LOG04,szhBanco);
	strcpy(szhModulo   ,"CO");
	strcpy(szhPAC_ACEP ,"PAC_ACEP");
	strcpy(szhPAC_RECH ,"PAC_RECH");

	strcpy(szhPOS_CLIE_GUA    ,"POS_CLIE_GUA");
	strcpy(szhPOS_CLIE_SAL    ,"POS_CLIE_SAL");
	strcpy(szhIND_RECHAZO_GUA ,"IND_RECHAZO_GUA");
	strcpy(szhIND_RECHAZO_SAL ,"IND_RECHAZO_SAL");
	strcpy(szhPOS_CLIE_FIN_SAL,"POS_CLIE_FIN_SAL");
	
	/* Inicio Incidencia 120541 - 06.01.2010 */
	strcpy(szhLetra_X      ,"X");
	strcpy(zshFormatoMonto ,"99,999,999,999     ");
	strcpy(szhCodigoMensaje,"RES_CORREO%");
	strcpy(szhCodigoAsunto ,"RES_ASUNTO_CORREO");
	strcpy(szhICG_MENSA    ,"ICG_MENSAJE");
	strcpy(szhCOD_MENSA    ,"COD_MENSAJE");
	strcpy(szhResPacMensaje,"RESPAC_MENSAJE");
	strcpy(szhLetraA       ,"A");
	strcpy(szhLetraD       ,"D");
	strcpy(szhLetraG       ,"G");
    strcpy(szhBAA          ,"BAA");
    strcpy(szhRutinaMensaje,"MENSJ");
    strcpy(szhENVIO_MAIL   ,"ENVIO_MAIL");
    strcpy(szhENVIO_SMS    ,"ENVIO_SMS");    
   	strcpy(szhPendiente    ,"PENDIENTE");
   	strcpy(szhS,"S");
	/* Fin Incidencia 120541 - 06.01.2010 */

	/*---------------------------------------------------------------------------*/
	/* Obtencion del codigo del banco			 		                         */
	/*---------------------------------------------------------------------------*/	    
    /* EXEC SQL
    SELECT COD_BANCO
    INTO   :szhCod_Banco
    FROM   GE_BANCOS
    WHERE  COD_BANCO  = :szhBanco; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_BANCO into :b0  from GE_BANCOS where COD_BANCO\
=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )148;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Banco;
    sqlstm.sqhstl[0] = (unsigned long )16;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhBanco;
    sqlstm.sqhstl[1] = (unsigned long )16;
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


    if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT COD_BANCO. ",SQLERRM);        
        return -1;
    }
    
	/*---------------------------------------------------------------------------*/
	/* Obtencion del formato y convenio, segun banco 			                 */
	/*---------------------------------------------------------------------------*/	        
    /* EXEC SQL
    SELECT A.COD_FORMATO   , NVL(COD_CONVENIO,' ')    , COD_OPERADORA_SCL
    INTO   :szhCod_Formato , :szhClaveEstablecimiento , :szhCodOperadora
    FROM   CO_SERVICIOPAC A
    WHERE  A.COD_BANCO 		 = (SELECT UNIQUE B.COD_BANCO_GRP FROM CO_SERVICIOPAC B WHERE B.COD_BANCO = :szhCod_Banco); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_FORMATO ,NVL(COD_CONVENIO,' ') ,COD_OPERADOR\
A_SCL into :b0,:b1,:b2  from CO_SERVICIOPAC A where A.COD_BANCO=(select unique\
 B.COD_BANCO_GRP  from CO_SERVICIOPAC B where B.COD_BANCO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )171;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Formato;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhClaveEstablecimiento;
    sqlstm.sqhstl[1] = (unsigned long )8;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCod_Banco;
    sqlstm.sqhstl[3] = (unsigned long )16;
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


   
    if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT COD_FORMATO Y CONVENIO",SQLERRM);        
        return -1;
    }

	/*--------------------------------------------------------------------------*/
	/* Obtencion del codigo aceptado, valor que se carga en la tabla CO_PAGOSPAC*/
	/*--------------------------------------------------------------------------*/	    
    /* EXEC SQL
    SELECT VAL_PARAMETRO
    INTO   :szhAceptado
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO = :szhPAC_ACEP
    AND    COD_MODULO    = :szhModulo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )202;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhAceptado;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPAC_ACEP;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


    
    if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO PAC_ACEP. ",SQLERRM);        
        return -1;
    }

	/*---------------------------------------------------------------------------*/
	/* Obtencion del codigo rechazado, valor que se carga en la tabla CO_PAGOSPAC*/
	/*---------------------------------------------------------------------------*/	    
    /* EXEC SQL
    SELECT VAL_PARAMETRO
    INTO   :szhRechazado
    FROM   GED_PARAMETROS
    WHERE  NOM_PARAMETRO = :szhPAC_RECH
    AND    COD_MODULO    = :szhModulo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )229;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRechazado;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPAC_RECH;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


    
    if (SQLCODE != SQLOK) {
        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO PAC_RECH. ",SQLERRM);        
        return -1;
    }

	/*---------------------------------------------------------------------------*/
	/* Obtencion del codigo posicion y aprobacion del cliente.Formato GUA1 y GUA2*/
	/*---------------------------------------------------------------------------*/	        
    if ( (strcmp(szhCod_Formato,GUA1)==0) || (strcmp(szhCod_Formato,GUA2)==0)) {
	    /* EXEC SQL
	    SELECT VAL_PARAMETRO
	    INTO   :szhPosClienteGUA
	    FROM   GED_PARAMETROS
	    WHERE  NOM_PARAMETRO = :szhPOS_CLIE_GUA
	    AND    COD_MODULO    = :szhModulo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where\
 (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )256;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhPosClienteGUA;
     sqlstm.sqhstl[0] = (unsigned long )5;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhPOS_CLIE_GUA;
     sqlstm.sqhstl[1] = (unsigned long )13;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


	    if (SQLCODE == NOTFOUND) {
			strcpy(szhPosClienteTmm1, szNulo);
	    	vDTrazasLog (modulo,"\t\t * Warning...Parametro POS_CLIE_GUA no existe en tabla GED_PARAMETROS",LOG03);
	    }
	    else if (SQLCODE != SQLOK) {
	        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO POS_CLIE_GUA. ",SQLERRM);        
	        return -1;
	    }
	
	    /*Obtiene valor del parametro a encontrar como rechazo*/
	    /* EXEC SQL
	    SELECT UPPER(VAL_PARAMETRO)
	    INTO   :szhIndRechazoGUA
	    FROM   GED_PARAMETROS
	    WHERE  NOM_PARAMETRO = :szhIND_RECHAZO_GUA
	    AND    COD_MODULO    = :szhModulo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select UPPER(VAL_PARAMETRO) into :b0  from GED_PARAMETRO\
S where (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )283;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhIndRechazoGUA;
     sqlstm.sqhstl[0] = (unsigned long )15;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhIND_RECHAZO_GUA;
     sqlstm.sqhstl[1] = (unsigned long )16;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


	    if (SQLCODE == NOTFOUND) {
			strcpy(szhPosAprobadoTmm1, szNulo);
	    	vDTrazasLog (modulo,"\t\t * Warning...Parametro IND_RECHAZO_GUA no existe en tabla GED_PARAMETROS",LOG03);
	    }
	    else if (SQLCODE != SQLOK) {
	        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO IND_RECHAZO_GUA. ",SQLERRM);        
	        return -1;
	    }

	 }

	/*---------------------------------------------------------------------------------*/
	/* Obtencion del codigo posicion y aprobacion del cliente.Formato SAL1,SAL2 y SAL3 */
	/*---------------------------------------------------------------------------------*/	        
    if ( (strcmp(szhCod_Formato,SAL1)==0) || (strcmp(szhCod_Formato,SAL2)==0) || (strcmp(szhCod_Formato,SAL3)==0) ) {
	    /* EXEC SQL
	    SELECT VAL_PARAMETRO
	    INTO   :szhPosClienteSAL
	    FROM   GED_PARAMETROS
	    WHERE  NOM_PARAMETRO = :szhPOS_CLIE_SAL
	    AND    COD_MODULO    = :szhModulo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where\
 (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )310;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhPosClienteSAL;
     sqlstm.sqhstl[0] = (unsigned long )5;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhPOS_CLIE_SAL;
     sqlstm.sqhstl[1] = (unsigned long )13;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


	    if (SQLCODE == NOTFOUND) {
			strcpy(szhPosClienteTmm1, szNulo);
	    	vDTrazasLog (modulo,"\t\t * Warning...Parametro POS_CLIE_SAL no existe en tabla GED_PARAMETROS",LOG03);
	    }
	    else if (SQLCODE != SQLOK) {
	        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO POS_CLIE_SAL. ",SQLERRM);        
	        return -1;
	    }
	
	    /* EXEC SQL
	    SELECT VAL_PARAMETRO
	    INTO   :szhIndRechazoSAL
	    FROM   GED_PARAMETROS
	    WHERE  NOM_PARAMETRO = :szhIND_RECHAZO_SAL
	    AND    COD_MODULO    = :szhModulo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where\
 (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )337;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhIndRechazoSAL;
     sqlstm.sqhstl[0] = (unsigned long )15;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhIND_RECHAZO_SAL;
     sqlstm.sqhstl[1] = (unsigned long )19;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


	    if (SQLCODE == NOTFOUND) {
			strcpy(szhPosAprobadoTmm1, szNulo);
	    	vDTrazasLog (modulo,"\t\t * Warning...Parametro IND_RECHAZO_SAL no existe en tabla GED_PARAMETROS",LOG03);
	    }
	    else if (SQLCODE != SQLOK) {
	        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO IND_RECHAZO_SAL. ",SQLERRM);        
	        return -1;
	    }

	    /* EXEC SQL
	    SELECT VAL_PARAMETRO
	    INTO   :szhPosClieFinSAL
	    FROM   GED_PARAMETROS
	    WHERE  NOM_PARAMETRO = :szhPOS_CLIE_FIN_SAL
	    AND    COD_MODULO    = :szhModulo; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where\
 (NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )364;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhPosClieFinSAL;
     sqlstm.sqhstl[0] = (unsigned long )5;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhPOS_CLIE_FIN_SAL;
     sqlstm.sqhstl[1] = (unsigned long )17;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
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
}


	    if (SQLCODE == NOTFOUND) {
			strcpy(szhPosAprobadoTmm1, szNulo);
	    	vDTrazasLog (modulo,"\t\t * Warning...Parametro IND_RECHAZO_SAL no existe en tabla GED_PARAMETROS",LOG03);
	    }
	    else if (SQLCODE != SQLOK) {
	        iDError(modulo,ERR000,vInsertarIncidencia,"SELECT VAL_PARAMETRO IND_RECHAZO_SAL. ",SQLERRM);        
	        return -1;
	    }
	
	}
 
    /* Inicio Incidencia 120541 - 06.01.2010 */
  	lMaxFetch = MAXFETCH;  	
  	/*-----------------------------------------------------------------------*/
  	/* Obtencion de Nombre de la Operadora Local            			     */
  	/*-----------------------------------------------------------------------*/	
  	/* EXEC SQL
  	SELECT CO_ENCCUPON_PAGO_PG.CO_DESC_OPERADORA_FN(:szhCodOperadora)
  	INTO   :szhNomOperadora
  	FROM   DUAL; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select CO_ENCCUPON_PAGO_PG.CO_DESC_OPERADORA_FN(:b0) into \
:b1  from DUAL ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )391;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodOperadora;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNomOperadora;
   sqlstm.sqhstl[1] = (unsigned long )51;
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

 

  	if (SQLCODE == NOTFOUND )  {
		vDTrazasLog  ( modulo,"\n Error, Descripción de Operadora No Existe [%s]-[%s].\n", LOG03,SQLERRM, szhCodOperadora);		
		vDTrazasError( modulo,"\n Error, Descripción de Operadora No Existe [%s]-[%s].\n", LOG03,SQLERRM, szhCodOperadora);		
		return -1;
	}  else if (SQLCODE != SQLOK) {
		vDTrazasLog  ( modulo, "\n Error en SELECT CO_ENCCUPON_PAGO_PG.CO_DESC_OPERADORA_FN [%s]-[%s].\n", LOG03,SQLERRM, szhCodOperadora);		
		vDTrazasError( modulo, "\n Error en SELECT CO_ENCCUPON_PAGO_PG.CO_DESC_OPERADORA_FN [%s]-[%s].\n", LOG03,SQLERRM, szhCodOperadora);		 
   		return -1;
  	}

	RighTrim(szhNomOperadora);

  	/*-----------------------------------------------------------------------*/
  	/* Asunto del Correo			    				                     */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
  	SELECT des_parametro
  	INTO   :szhAsunto 
 	FROM   ged_parametros 
  	WHERE  nom_parametro = :szhCodigoAsunto
  	AND    cod_modulo    = :szhModulo
	AND    cod_producto  = :ihValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select des_parametro into :b0  from ged_parametros where (\
(nom_parametro=:b1 and cod_modulo=:b2) and cod_producto=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )414;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhAsunto;
   sqlstm.sqhstl[0] = (unsigned long )101;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodigoAsunto;
   sqlstm.sqhstl[1] = (unsigned long )18;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
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



  	if (SQLCODE == NOTFOUND) {
   		vDTrazasLog  (modulo,"\n     Error, Asunto del Correo No existe. [%s]\n",LOG03,SQLERRM);
		vDTrazasError(modulo,"\n     Asunto del Correo No existe. [%s]\n",LOG03,SQLERRM);
   		return -1;
  	} else if (SQLCODE != SQLOK) {
   		vDTrazasLog  (modulo, "\n     Error en SELECT des_parametro FROM ged_parametros (PAC_ASUNTO_CORREO). [%s]\n",LOG03,SQLERRM);
		vDTrazasError(modulo, "\n     SELECT des_parametro FROM ged_parametros (PAC_ASUNTO_CORREO). [%s]\n",LOG03,SQLERRM);
   		return -1;
  	}

  	RighTrim(szhAsunto);
   
  	/* EXEC SQL DECLARE CUR_TEXTO CURSOR FOR     
  	SELECT des_parametro
  	FROM   ged_parametros 
  	WHERE  nom_parametro LIKE :szhCodigoMensaje
  	AND    cod_modulo   = :szhModulo
	AND    cod_producto = :ihValorUno
	ORDER BY nom_parametro; */ 

	
	/* EXEC SQL OPEN CUR_TEXTO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0017;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )445;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodigoMensaje;
 sqlstm.sqhstl[0] = (unsigned long )12;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhModulo;
 sqlstm.sqhstl[1] = (unsigned long )3;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValorUno;
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

      
	if (SQLCODE!=SQLOK)	{
		vDTrazasLog  ( modulo, "\n     Error en OPEN Cursor CUR_TEXTO. [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     en OPEN Cursor CUR_TEXTO. [%s]\n",LOG03,SQLERRM);
		return -1;
	} /* end if (SQLCODE!=SQLOK)	*/

	memset(szhTextoCorreo,'\0',sizeof(szhTextoCorreo));
 	iLastRows  = 0;
  	ihCantRegs = 0;

   	while (iFetchedRows == iRetrievRows)
   	{	   			   	   		
		/* EXEC SQL 
		   for   :lMaxFetch  FETCH CUR_TEXTO 
       	   INTO  :szhTextoArr; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )lMaxFetch;
  sqlstm.offset = (unsigned int  )472;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhTextoArr;
  sqlstm.sqhstl[0] = (unsigned long )51;
  sqlstm.sqhsts[0] = (         int  )51;
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
		vDTrazasLog(modulo,"\t\t iLastRows  [%d].",LOG03,iLastRows);		

       	for (i=0; i < iRetrievRows; i++){ 
         	strcpy (szhTexto, szhTextoArr[i]);	
         	RighTrim(szhTexto);
         	sprintf(szhTextoCorreo,"%s%s",szhTextoCorreo, szhTexto);
         	ihCantRegs++;
        } /* end for */        
    } /* end while */
    
    if (ihCantRegs == 0){
		vDTrazasLog  ( modulo,"\n  Error, Texto del Correo no existe. [%s]\n",LOG00,SQLERRM);
		vDTrazasError( modulo,"\n  Texto del Correo no existe. [%s]\n",LOG00,SQLERRM);
		return -1;         	
    } 

	/*---------------------------------------------------------------------------*/
	/*	Cierra cursor CUR_TEXTO												     */
	/*---------------------------------------------------------------------------*/	
	/* EXEC SQL CLOSE CUR_TEXTO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )491;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE )  {
		vDTrazasLog  ( modulo, "\n     Error en CLOSE CUR_TEXTO. [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     En CLOSE CUR_TEXTO. [%s]\n",LOG03,SQLERRM);
		return -1;
	}   
		
	/*Reemplaza Nombre Operadora en Texto del Correo  */	
	memset(szhTextoCorreoPaso,'\0',sizeof(szhTextoCorreoPaso));		
    iRes = 0;
    iRes = ifnReemplazaItem (szhTextoCorreo, "<Operadora>", szhNomOperadora, szhTextoCorreoPaso);
    if (iRes < 0) return -1;
	   
    /* Generando Formato para el Monto*/     
	if (iDecimal > 0) {		
		zshFormatoMonto[14] = '.';
		for(i=1;i<=iDecimal;i++){
		    zshFormatoMonto[14+i] = '9';
		} /*for(i==1;i<=iDecimal;i++)*/
	} /*if (iDecimal > 0)*/
	RighTrim(zshFormatoMonto);

  	/*-----------------------------------------------------------------------*/
  	/* Obtencion de Codigo de Mensaje	            			             */
  	/*-----------------------------------------------------------------------*/	
  	/* EXEC SQL
  	SELECT val_parametro 
  	INTO   :szhCodMensaje
  	FROM   ged_parametros
	WHERE  NOM_PARAMETRO = :szhResPacMensaje
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :ihValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select val_parametro into :b0  from ged_parametros where (\
(NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )506;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodMensaje;
   sqlstm.sqhstl[0] = (unsigned long )4;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhResPacMensaje;
   sqlstm.sqhstl[1] = (unsigned long )15;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
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

 

  	if (SQLCODE==NOTFOUND )  {
		vDTrazasLog  ( modulo, "\n   Error, Código de Mensaje No existe en GED_PARAMETROS (RESPAC_MENSAJE). [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n   Código de Mensaje No existe en GED_PARAMETROS (RESPAC_MENSAJE). [%s]\n",LOG03,SQLERRM);
		return -1;
	} else if (SQLCODE != SQLOK) {
		vDTrazasLog  ( modulo, "\n     Error en SELECT VAL_PARAMETRO RESPAC_MENSAJE. [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     SELECT VAL_PARAMETRO RESPAC_MENSAJE. [%s]\n",LOG03,SQLERRM);
   		return -1;
  	}

	RighTrim(szhCodMensaje);

  	/*-----------------------------------------------------------------------*/
  	/* Codigo de Central			    				                     */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
  	SELECT cod_central
  	INTO   :ihCodCentralMens
  	FROM   icg_mensaje 
  	WHERE  COD_PRODUCTO  = :ihValorUno
  	AND    COD_MENSAJE   = :szhCodMensaje; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select cod_central into :b0  from icg_mensaje where (COD_P\
RODUCTO=:b1 and COD_MENSAJE=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )537;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCentralMens;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihValorUno;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodMensaje;
   sqlstm.sqhstl[2] = (unsigned long )4;
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

 
  	
  	if (SQLCODE == NOTFOUND) {
		vDTrazasLog  ( modulo, "\n     Error, Código de Central de Mensajes No existe [%s]\n",LOG03,szhCodMensaje);	         		
		vDTrazasError( modulo, "\n     Error, Código de Central de Mensajes No existe [%s]\n",LOG03,szhCodMensaje);	         		
   		return -1;
  	} else if (SQLCODE != SQLOK) {
		vDTrazasLog  ( modulo, "\n     Error en SELECT cod_central FROM icg_mensaje. [%s]\n",LOG03,SQLERRM);	         		
		vDTrazasError( modulo, "\n     Error en SELECT cod_central FROM icg_mensaje. [%s]\n",LOG03,SQLERRM);	         		 
   		return -1;
  	}

  	/*-----------------------------------------------------------------------*/
  	/* Envio de E-Mail  		    				                         */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
  	SELECT TO_NUMBER(val_parametro)
  	INTO   :ihEnvioEmail
  	FROM   ged_parametros
	WHERE  NOM_PARAMETRO = :szhENVIO_MAIL
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :ihValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_NUMBER(val_parametro) into :b0  from ged_paramet\
ros where ((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )564;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihEnvioEmail;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhENVIO_MAIL;
   sqlstm.sqhstl[1] = (unsigned long )12;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
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

 
  	
  	if (SQLCODE == NOTFOUND) {
  		/* Valor por Defecto */
		ihEnvioEmail = 1;
  	} else if (SQLCODE != SQLOK) {
		vDTrazasLog  ( modulo, "\n     Error al obtener szhENVIO_EMAIL. [%s]\n",LOG03,SQLERRM);	         		
		vDTrazasError( modulo, "\n     Error al obtener szhENVIO_EMAIL. [%s]\n",LOG03,SQLERRM);	         		 
   		return -1;
  	}

  	/*-----------------------------------------------------------------------*/
  	/* Envio de SMS  		    				                             */
  	/*-----------------------------------------------------------------------*/	    
  	/* EXEC SQL
  	SELECT TO_NUMBER(val_parametro)
  	INTO   :ihEnvioSms
  	FROM   ged_parametros
	WHERE  NOM_PARAMETRO = :szhENVIO_SMS
	AND    COD_MODULO    = :szhModulo
	AND    COD_PRODUCTO  = :ihValorUno; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_NUMBER(val_parametro) into :b0  from ged_paramet\
ros where ((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )595;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihEnvioSms;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhENVIO_SMS;
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValorUno;
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

 
  	
  	if (SQLCODE == NOTFOUND) {
  		/* Valor por Defecto */
		ihEnvioSms = 1;
  	} else if (SQLCODE != SQLOK) {
		vDTrazasLog  ( modulo, "\n     Error al obtener szhENVIO_SMS. [%s]\n",LOG03,SQLERRM);	         		
		vDTrazasError( modulo, "\n     Error al obtener szhENVIO_SMS. [%s]\n",LOG03,SQLERRM);	         		 
   		return -1;
  	}  	
    /* Fin Incidencia 120541 - 06.01.2010 */
	   
	/*---------------------------------------------------------------------------*/
	/* Resumen de los datos obtenidos					                         */
	/*---------------------------------------------------------------------------*/	        
    vDTrazasLog (modulo,"\t\t szhCodOperadora[%s]",LOG06,szhCodOperadora);
    vDTrazasLog (modulo,"\t\t szhCod_Banco   [%s]",LOG03,szhCod_Banco  );
    vDTrazasLog (modulo,"\t\t szhCod_Formato [%s]",LOG03,szhCod_Formato);
    vDTrazasLog (modulo,"\t\t szhAceptado    [%s]",LOG04,szhAceptado   );
    vDTrazasLog (modulo,"\t\t szhRechazado   [%s]",LOG04,szhRechazado  );
    vDTrazasLog (modulo,"\t\t szhClaveEstablecimiento....[%s]",LOG06,szhClaveEstablecimiento);
    vDTrazasLog (modulo,"\t\t ****************************"  ,LOG03);
    vDTrazasLog (modulo,"\t\t szhPosClienteGUA.....[%s]",LOG03,szhPosClienteGUA);
    vDTrazasLog (modulo,"\t\t szhIndRechazoGUA.....[%s]",LOG03,szhIndRechazoGUA);
    vDTrazasLog (modulo,"\t\t szhPosClienteSAL.....[%s]",LOG03,szhPosClienteSAL);
    vDTrazasLog (modulo,"\t\t szhIndRechazoSAL.....[%s]",LOG03,szhIndRechazoSAL);
    vDTrazasLog (modulo,"\t\t szhPosClieFinSAL.....[%s]",LOG03,szhPosClieFinSAL);

    /* Inicio Incidencia 120541 - 06.01.2010 */
    vDTrazasLog (modulo,"\t\t szhNomOperadora......[%s]",LOG03,szhNomOperadora);
    vDTrazasLog (modulo,"\t\t szhAsunto............[%s]",LOG03,szhAsunto);
    vDTrazasLog (modulo,"\t\t szhTextoCorreoPaso...[%s]",LOG07,szhTextoCorreoPaso); 	
	vDTrazasLog (modulo,"\t\t zshFormatoMonto......[%s]",LOG03,zshFormatoMonto);
  	vDTrazasLog (modulo,"\t\t szhCodMensaje....... [%s]",LOG03,szhCodMensaje);
  	vDTrazasLog (modulo,"\t\t ihCodCentralMens.... [%d]",LOG03,ihCodCentralMens);
    vDTrazasLog (modulo,"\t\t ihEnvioEmail.........[%d]",LOG03,ihEnvioEmail);
    vDTrazasLog (modulo,"\t\t ihEnvioSms...........[%d]",LOG03,ihEnvioSms);
    vDTrazasLog (modulo,"\t\t iDecimal.............[%d]",LOG09,iDecimal);    
    /* Fin Incidencia 120541 - 06.01.2010 */
    
    return 0;
} /*ifnValParametrosPAC*/

/*===========================================================================*/
/* Funcion que abre el archivo de Pac                                        */
/*===========================================================================*/
int ifnOpenFileDat ()
{
char modulo[]="ifnOpenFileDat";
	
	vDTrazasLog (modulo,"\n\t *** Abriendo Archivo PAC  [%s]***",LOG03,szFileName);

	if ((fpDat=fopen(szFileName,"r")) == (FILE *)NULL) {
        vDTrazasLog (modulo,"\t Fallo al abrir Fichero de datos [%s].",LOG01,szFileName);
		return -1;
	}
   vDTrazasLog (modulo,"\t\t Archivo [%s] fue abierto con Exito.",LOG03,szFileName);
    
   return 0;
} /* ifnOpenFileDat */


/*===========================================================================*/
/* Funcion : ifnDesconexionOracle                                            */
/*===========================================================================*/
int ifnDesconexionOracle (void)
{
char modulo[]="ifnDesconexionOracle";
	
   if (!bfnDisconnectORA(0)) {
        iDError(modulo,ERR000,vInsertarIncidencia,"Desconexion de Oracle.\n ",SQLERRM);
        return -1;
   }
   stStatus.OraConnected = FALSE;
   vDTrazasLog (modulo,"\t *** Desconexion a Oracle ***",LOG03);

   return 0;                                
                           
}/* ifnExitAplicapago */

/*===========================================================================*/
/* Funcion que abre los archivos de log y de error                           */
/*===========================================================================*/
int ifnAbreArchivosLog()
{
char *pathDir               ;
char szArchivo  [32]    ="" ;
char szComando  [128]   ="" ;

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"ResPac");

	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");
	sprintf(szPath  ,"%s/LOG/Recaudacion/ResPac/%s",pathDir,szFechayyyymmdd);

	free(pathDir);

	sprintf(szComando,"/usr/bin/mkdir -p %s", szPath);
	system (szComando);

	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL ){
	    fprintf( stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
	    return -1;
	}

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) {
	    fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
    	return -1;
    }
    
    return 0;
}/*ifnAbreArchivosLog */

/*===========================================================================*/
/* Funcion RighTrim : Limpia blancos a la derecha                            */
/*===========================================================================*/
int RighTrim (char *szVar)
{
int  iLenVar = 0, i=0;

    iLenVar = strlen(szVar);
    for (i=iLenVar-1;i>-1;i--) {
        if (szVar[i]==' ') {
            szVar[i]='\0';
        } else break;
    }
    return (0);        
} /* RighTrim */

/* Inicio Incidencia 120541 - 06.01.2010 */
/*===========================================================================*/
/* Funcion ifnBuscaCliente    : Busca codigo del cliente en el registro leido*/
/* IndOperadora = 0 GUATEMALA                                                */
/* IndOperadora = 1 EL SALVADOR                                              */
/*===========================================================================*/
int ifnBuscaCliente(int Inicio1, int Fin1, char *pszRegistro, char *szhCodCliente, int IndOperadora)
{
char  szhLinea [LARGOREG];
char  szhAux   [LARGOREG];
int   y = 0;

    memset (szhLinea,'\0',sizeof(szhLinea));
    strncpy(szhLinea, &pszRegistro[Inicio1], Fin1);    
    strcpy (szhAux,szhLinea);

    if (IndOperadora==0) {        	
        for (y=0;y<strlen(szhAux);y++) {
            if (szhAux[y]==',') {
                strncpy(szhCodCliente, szhAux, y);    
 	    	    break; /*encontro la proxima coma, por lo tanto corta el string obteniendo el codigo de cliente*/
            }
        } /* end for */
    } else { 
    	strcpy (szhCodCliente, szhAux);
    } /* end if (IndOperadora==0) {*/
    
    vDTrazasLog (modulo,"\t szhCodCliente    [%s]",LOG05, szhCodCliente);

    return 0;
                
}

/*===========================================================================*/
/* Funcion ifnEnviaMensajes : Envio de correo y sms a clientes rechazados    */
/*===========================================================================*/
int ifnEnviaMensajes (long plCodCliente)
{
/*---------------------------------------------------------------------------*/
/* Inicializacion de Variables  										 	 */
/*---------------------------------------------------------------------------*/
char  modulo[]="ifnEnviaMensajes";
int   iRes;
char  szhTextoCorreoPaso1[1001];
char  szhTextoMensaje    [1001];
char  szhTextoCorreoAct  [1001];

/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   	long lhCodCliente       ;		   	
   	char szhEmail      [256]; /* EXEC SQL VAR szhEmail      IS STRING(256); */ 
	   		   		
   	char szhNomCliente  [91]; /* EXEC SQL VAR szhNomCliente IS STRING (91); */ 
	   		   		
   	char szhFecProceso  [11]; /* EXEC SQL VAR szhFecProceso IS STRING (11); */ 
	   		   		
   	char szhImporte     [21]; /* EXEC SQL VAR szhImporte    IS STRING (21); */ 
	
    char zshCodIdioma    [6]; /* EXEC SQL VAR zshCodIdioma  IS STRING  (6); */ 
   	   		   				   
/* EXEC SQL END DECLARE SECTION; */ 

	
	vDTrazasLog (modulo,"\n\t Funcion %s",LOG03, modulo);
    lhCodCliente = plCodCliente;
	vDTrazasLog  ( modulo, "\t lhCodCliente  [%ld]",LOG09,lhCodCliente);
    			
    /* EXEC SQL
		SELECT NVL(b.NOM_EMAIL, :szhLetra_X),
		       b.NOM_CLIENTE || ' ' || b.NOM_APECLIEN1 || ' ' || b.NOM_APECLIEN2 as NOM_CLIENTE,
		       TO_CHAR(SYSDATE,:szhddmmyyyy ), 
		       TRIM(TO_CHAR(GE_PAC_GENERAL.REDONDEA(a.importe_debe, :iDecimal, :ihValorCero),:zshFormatoMonto)) , 
		       NVL(b.COD_IDIOMA,:ihValorUno) AS COD_IDIOMA
		 INTO  :szhEmail     , 
		  	   :szhNomCliente,
		  	   :szhFecProceso,
		  	   :szhImporte   , 
		  	   :zshCodIdioma
		 FROM CO_PAGOSPAC a, GE_CLIENTES b
		WHERE a.COD_CLIENTE   = b.COD_CLIENTE 
		AND   a.COD_CLIENTE   = :lhCodCliente
	    AND   a.IND_CANCELADO = :ihValorCero
	    AND   a.IND_PROCESADO = :ihValorCero
	    /oAND   a.COD_BANCO     = :szhCod_Banco Incidencia 132780 - 04.05.2010 o/
	    AND   a.COD_OPERADORA = :szhCodOperadora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 15;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(b.NOM_EMAIL,:b0) ,((((b.NOM_CLIENTE||' ')||b.N\
OM_APECLIEN1)||' ')||b.NOM_APECLIEN2) NOM_CLIENTE ,TO_CHAR(SYSDATE,:b1) ,trim(\
TO_CHAR(GE_PAC_GENERAL.REDONDEA(a.importe_debe,:b2,:b3),:b4)) ,NVL(b.COD_IDIOM\
A,:b5) COD_IDIOMA into :b6,:b7,:b8,:b9,:b10  from CO_PAGOSPAC a ,GE_CLIENTES b\
 where ((((a.COD_CLIENTE=b.COD_CLIENTE and a.COD_CLIENTE=:b11) and a.IND_CANCE\
LADO=:b3) and a.IND_PROCESADO=:b3) and a.COD_OPERADORA=:b14)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )626;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_X;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhddmmyyyy;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iDecimal;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)zshFormatoMonto;
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihValorUno;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhEmail;
    sqlstm.sqhstl[6] = (unsigned long )256;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNomCliente;
    sqlstm.sqhstl[7] = (unsigned long )91;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhFecProceso;
    sqlstm.sqhstl[8] = (unsigned long )11;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhImporte;
    sqlstm.sqhstl[9] = (unsigned long )21;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)zshCodIdioma;
    sqlstm.sqhstl[10] = (unsigned long )6;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[14] = (unsigned long )6;
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



  	if (SQLCODE == NOTFOUND) {
		vDTrazasLog  ( modulo, "\n     Codigo de cliente no se encuentra [%ld]\n",LOG03,lhCodCliente);
		return 1;
	}
		   		  
	if (SQLCODE!=SQLOK)	{
		vDTrazasLog  ( modulo, "\n     Error en consultar e-mail del cliente. [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     Error en consultar e-mail del cliente. [%s]\n",LOG03,SQLERRM);
		return -1;
	} /* end if (SQLCODE!=SQLOK)	*/
	   	   		   	   	
    if ( (strcmp(szhEmail,szhLetra_X) ==0))  {
		vDTrazasLog  ( modulo, "\t  Cliente no tiene registrado E-Mail. [%ld]\n",LOG03,lhCodCliente);
		return 0;    	
    }

	vDTrazasLog  ( modulo, "\t szhEmail.      [%s]",LOG09,szhEmail);
	vDTrazasLog  ( modulo, "\t szhNomCliente  [%s]",LOG09,szhNomCliente);
	vDTrazasLog  ( modulo, "\t szhFecProceso  [%s]",LOG09,szhFecProceso);
	vDTrazasLog  ( modulo, "\t szhImporte     [%s]",LOG09,szhImporte);

    if (ihEnvioEmail == 0) {
       vDTrazasLog(modulo,"szhTextoCorreoPaso [%s]",LOG07,szhTextoCorreoPaso);							
	            			         			
	   memset(szhTextoCorreoAct  ,'\0',sizeof(szhTextoCorreoAct)); 
       memset(szhTextoCorreoPaso1,'\0',sizeof(szhTextoCorreoPaso1));
	   strcpy(szhTextoCorreoPaso1,szhTextoCorreoPaso);         			         			
       
       iRes = 0;
       iRes = ifnReemplazaItem (szhTextoCorreoPaso1, "<nom_cliente>", szhNomCliente, szhTextoCorreoAct);    
       if (iRes < 0) return -1;
       
       memset(szhTextoCorreoPaso1,'\0',sizeof(szhTextoCorreoPaso1));
	   strcpy(szhTextoCorreoPaso1, szhTextoCorreoAct);	         				         			
       
       iRes = 0;
       iRes = ifnReemplazaItem (szhTextoCorreoPaso1, "<fec_pago>", szhFecProceso, szhTextoCorreoAct);
       if (iRes < 0) return -1;
       
       memset(szhTextoCorreoPaso1,'\0',sizeof(szhTextoCorreoPaso1));
	   strcpy(szhTextoCorreoPaso1, szhTextoCorreoAct);	         				         			
       
       iRes = 0;
       iRes = ifnReemplazaItem (szhTextoCorreoPaso1, "<mto_pago>", szhImporte, szhTextoCorreoAct);
       if (iRes < 0) return -1;
       
       memset(szhTextoCorreoPaso1,'\0',sizeof(szhTextoCorreoPaso1));
	   strcpy(szhTextoCorreoPaso1, szhTextoCorreoAct);	         				         			
       
       while (((char *)strstr (szhTextoCorreoPaso1,"<sp>"))!=(char *)NULL){	         				        				
           memset(szhTextoCorreoAct,'\0',sizeof(szhTextoCorreoAct));
           iRes = 0;
           iRes = ifnReemplazaItem (szhTextoCorreoPaso1, "<sp>", "\n", szhTextoCorreoAct);
           if (iRes < 0) return -1;
	       strcpy(szhTextoCorreoPaso1, szhTextoCorreoAct);	         				         			
       }
                			
       vDTrazasLog(modulo,"Mensaje final [%s]",LOG07,szhTextoCorreoAct);							
	   															
       iRes = 0;
       iRes = ifnEnviaEmail (szhTextoCorreoAct, szhEmail);
       if (iRes < 0) return -1;
    }    								

    if (ihEnvioSms == 0) {
    	iRes = ifnEnviaSMS(lhCodCliente, zshCodIdioma, atof(szhImporte));
       if (iRes < 0) return -1;
    }    								
    
	return 0;
	
} /* end ifnEnviaMensajes*/

/*===========================================================================*/
/* Funcion ifnReemplazaItem :                                                */
/*===========================================================================*/
int ifnReemplazaItem (char *szTexto, char *szItem, char *szDetalle, char *szTextoAct)
{	
char  modulo[]="ifnReemplazaItem";
char  szhTextoMensaje   [1001];

    if (((char *) strstr(szTexto,szItem))!=(char *)NULL) {
		memset(szhTextoMensaje,'\0',sizeof(szhTextoMensaje)); 
		if (ifnReplace(szTexto,szItem,szDetalle,szhTextoMensaje)!=0){
	        vDTrazasLog  ( modulo, "\n     Error al reemplazar %s en correo electronico.\n", LOG03, szItem);
		    vDTrazasError( modulo, "\n     Error al reemplazar %s en correo electronico.\n", LOG03, szItem);
		    return -1;
     	}

		strcpy(szTextoAct, szhTextoMensaje);	         				         			
	}         			

    return 0;        
} /* ifnReemplazaItem */

/*===========================================================================*/
/* Funcion ifnReplace :                                                      */
/*===========================================================================*/
int ifnReplace(char *szpPalabra, char* szpFind, char* szpReplace, char *szpMensajeCompleto)
{
char sz_Aux  [101];
char sz_Aux2 [101];
char szpMensajeCompleto2[1001];
int ihInicio = 0;

  ihInicio = strlen(szpFind);
  if (strlen(szpMensajeCompleto)==0) {
     strncpy(szpMensajeCompleto,&szpPalabra[0],strlen(szpPalabra)-strlen(strstr( szpPalabra,szpFind )));
     strcat(szpMensajeCompleto,szpReplace);
     strcpy(sz_Aux,strstr( szpPalabra,szpFind ));     
     strncpy(sz_Aux,&sz_Aux[ihInicio],strlen(sz_Aux));
     sprintf(szpMensajeCompleto,"%s%s",szpMensajeCompleto,sz_Aux);
  } else {
     strncpy(sz_Aux2,&szpMensajeCompleto[strlen(szpMensajeCompleto) - strlen(strstr(szpMensajeCompleto,szpFind )) +ihInicio],strlen(strstr( szpMensajeCompleto,szpFind )));
     strncpy(szpMensajeCompleto2,&szpMensajeCompleto[0],strlen(szpMensajeCompleto)-strlen(strstr(szpMensajeCompleto,szpFind )));
     strcat(szpMensajeCompleto2,szpReplace);
     sprintf(szpMensajeCompleto2,"%s%s",szpMensajeCompleto2,sz_Aux2);
     strcpy(szpMensajeCompleto,szpMensajeCompleto2);	
  }
    return 0;
    
} /*ifnReplace*/

/*===========================================================================*/
/* Funcion ifnEnviaEmail:                                                    */
/*===========================================================================*/
int ifnEnviaEmail (char *szTexto, char *szEmail)
{	
char  modulo[]="ifnEnviaEmail";
FILE  *arch;
char  comando[1001];			

    vDTrazasLog (modulo,"\n\t Funcion %s",LOG09, modulo);

	sprintf(comando,"echo '%s' > Correo_Enviado.txt",szTexto);
	system(comando);
				
    arch = fopen("Correo_Enviado.txt","r");			
	strcpy(comando, "mailx ");
	sprintf(comando,"%s -s '%s' %s",comando,szhAsunto,szEmail);
	strcat(comando, " < Correo_Enviado.txt");
	fprintf(arch,szTexto);
	fclose(arch);
    system(comando);				
	strcpy(comando,"rm Correo_Enviado.txt");
	system(comando);																

    return 0;        
} /* ifnEnviaEmail */

/*===========================================================================*/
/* Funcion ifnEnviaSMS:                                                      */
/*===========================================================================*/
int ifnEnviaSMS (long plCodCliente, char *szCodIdioma, double pdImporte)
{	
char  modulo[]="ifnEnviaSMS";
char  zshCodIdioma[6]; 
char  szhCodActAbo[3];
long  lhCodActCen;
long  lhNumMovimiento;
long  lhNumMovimiento2;
int   iRes;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

  long lhCodCliente;
  int  ihCodProducto;
  int  ihCodCentral;
  int  lhIndPlexsys ;
  long lhNumAbonado;
  long lhNumCelular;
  long lhCodCentralPlexsys;
  long lhNumCelularPrexsys;

  char   szhNumSerieHex  [9]; /* EXEC SQL VAR szhNumSerieHex   IS STRING (9); */ 

  char   szhTipTerminal  [2]; /* EXEC SQL VAR szhTipTerminal   IS STRING (2); */ 

  char   szhNumMin       [4]; /* EXEC SQL VAR szhNumMin        IS STRING (4); */ 

  char   szhCodTecnologia[8]; /* EXEC SQL VAR szhCodTecnologia IS STRING (8); */ 

  char   szhNumSerie    [26]; /* EXEC SQL VAR szhNumSerie      IS STRING(26); */ 

  char   szhNumImei     [26]; /* EXEC SQL VAR szhNumImei       IS STRING(26); */ 

  char   szhImsi        [51]; /* EXEC SQL VAR szhImsi          IS STRING(51); */ 

  char   szhTipPlan      [9]; /* EXEC SQL VAR szhTipPlan       IS STRING (9); */ 

  char   zshFecProceso  [11]; /* EXEC SQL VAR zshFecProceso    IS STRING(11); */ 

  double dhImporte          ;	
  char	 zshMensaje    [257]; /* EXEC SQL VAR zshMensaje       IS STRING(257); */ 

  char	 zshTextoMsj   [257]; /* EXEC SQL VAR zshTextoMsj      IS STRING(257); */ 

  char	 zshTexto      [257]; /* EXEC SQL VAR zshTexto         IS STRING(257); */ 

/* EXEC SQL END DECLARE SECTION; */ 

	
	vDTrazasLog (modulo,"\n\t Funcion %s",LOG03, modulo);
	lhCodCliente = plCodCliente;
	dhImporte    = pdImporte;
	strcpy(zshCodIdioma  , szCodIdioma );
	
	vDTrazasLog (modulo,"\t lhCodCliente [%ld]",LOG09, lhCodCliente);
	vDTrazasLog (modulo,"\t zshCodIdioma  [%s]",LOG09, zshCodIdioma);
	      							
	/* seleccionamos el mensaje que corresponde al cliente de acuerdo a mensaje/idioma */
	if( !bfnSelectDescripcionMensaje(szhCodMensaje, zshCodIdioma, zshMensaje ) ) {
		return -1;
    }														
    
	/*--------------------------------------------------------------*/
	/* Obtencion datos del celular al que se enviará el mensaje     */
	/*--------------------------------------------------------------*/								
   	/* EXEC SQL 
		SELECT cod_producto              , num_abonado           , num_celular              , 
		       cod_central               , NVL(ind_plexsys, 0 )  , NVL(cod_central_plex, 0 ),
			   NVL(num_celular_plex, -1 ), NVL(num_seriehex, '0'), tip_terminal             ,
			   NVL(num_min, 730 )        , cod_tecnologia        , 
			   DECODE(cod_tecnologia, 'GSM',  num_serie, ' ' ) as num_serie,
			   NVL(num_imei, ' ' )       , 
			   DECODE(cod_tecnologia, 'GSM', fRecuperSIMCARD_FN( num_serie, 'IMSI'), ' ' ) imsi,
 			   CO_fGetTipPlanCelular( cod_plantarif) AS TIP_PLAN, 
 			   TO_CHAR(sysdate, :szhddmmyyyy) 
	 	 INTO :ihCodProducto      , :lhNumAbonado    , :lhNumCelular       ,
			  :ihCodCentral       , :lhIndPlexsys    , :lhCodCentralPlexsys,
			  :lhNumCelularPrexsys, :szhNumSerieHex  , :szhTipTerminal     ,
			  :szhNumMin          , :szhCodTecnologia, 
			  :szhNumSerie        ,
			  :szhNumImei         ,
			  :szhImsi            ,
			  :szhTipPlan         , 
			  :zshFecProceso
  	   FROM   ga_abocel
	   WHERE  cod_cliente = :lhCodCliente
 		 AND  num_celular =	(SELECT min(num_celular)
					           FROM ga_abocel
					          WHERE cod_cliente   = :lhCodCliente
					           AND  tip_terminal IN ( :szhLetraA, :szhLetraD, :szhLetraG ) 
					           AND  cod_uso       != :ihValorTres          
					           AND  cod_situacion != :szhBAA); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select cod_producto ,num_abonado ,num_celular ,cod_centra\
l ,NVL(ind_plexsys,0) ,NVL(cod_central_plex,0) ,NVL(num_celular_plex,(-1)) ,NV\
L(num_seriehex,'0') ,tip_terminal ,NVL(num_min,730) ,cod_tecnologia ,DECODE(co\
d_tecnologia,'GSM',num_serie,' ') num_serie ,NVL(num_imei,' ') ,DECODE(cod_tec\
nologia,'GSM',fRecuperSIMCARD_FN(num_serie,'IMSI'),' ') imsi ,CO_fGetTipPlanCe\
lular(cod_plantarif) TIP_PLAN ,TO_CHAR(sysdate,:b0) into :b1,:b2,:b3,:b4,:b5,:\
b6,:b7,:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16  from ga_abocel where (cod_c\
liente=:b17 and num_celular=(select min(num_celular)  from ga_abocel where (((\
cod_cliente=:b17 and tip_terminal in (:b19,:b20,:b21)) and cod_uso<>:b22) and \
cod_situacion<>:b23)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )701;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhddmmyyyy;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProducto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumCelular;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhIndPlexsys;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCentralPlexsys;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhNumCelularPrexsys;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumSerieHex;
    sqlstm.sqhstl[8] = (unsigned long )9;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhTipTerminal;
    sqlstm.sqhstl[9] = (unsigned long )2;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhNumMin;
    sqlstm.sqhstl[10] = (unsigned long )4;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhCodTecnologia;
    sqlstm.sqhstl[11] = (unsigned long )8;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhNumSerie;
    sqlstm.sqhstl[12] = (unsigned long )26;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhNumImei;
    sqlstm.sqhstl[13] = (unsigned long )26;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhImsi;
    sqlstm.sqhstl[14] = (unsigned long )51;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhTipPlan;
    sqlstm.sqhstl[15] = (unsigned long )9;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)zshFecProceso;
    sqlstm.sqhstl[16] = (unsigned long )11;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhLetraA;
    sqlstm.sqhstl[19] = (unsigned long )2;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhLetraD;
    sqlstm.sqhstl[20] = (unsigned long )2;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhLetraG;
    sqlstm.sqhstl[21] = (unsigned long )2;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&ihValorTres;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhBAA;
    sqlstm.sqhstl[23] = (unsigned long )4;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
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


		
    if (SQLCODE!=SQLOK ) {
		vDTrazasLog  ( modulo, "\n     Error al Obtener Datos celular al que se enviará el Mensaje [%s].\n",LOG03,SQLERRM);						
		vDTrazasError( modulo, "\n     Error al Obtener Datos celular al que se enviará el Mensaje [%s].\n",LOG03,SQLERRM);						
	}

    memset(zshTextoMsj,'\0',sizeof(zshTextoMsj));
    strcpy(zshTextoMsj, zshMensaje);	         				         			
    
    iRes = 0;
    iRes = ifnReemplazaItem (zshTextoMsj, "<p1>", zshFecProceso, zshTexto);
    if (iRes < 0) return -1;

    memset(zshMensaje,'\0',sizeof(zshMensaje));
    strcpy(zshMensaje, zshTexto);	         				         			
	
	vDTrazasLog(modulo,"\t\t zshMensaje          ====>  [%s].",LOG07,zshMensaje);				
	vDTrazasLog(modulo,"\t\t lhCodCliente        ====>  [%d].",LOG07,lhCodCliente);
	vDTrazasLog(modulo,"\t\t ihCodProducto       ====>  [%d].",LOG07,ihCodProducto);
	vDTrazasLog(modulo,"\t\t num_abonado         ====>  [%d].",LOG07,lhNumAbonado);
	vDTrazasLog(modulo,"\t\t lhNumCelular        ====> [%ld].",LOG07,lhNumCelular);										
	vDTrazasLog(modulo,"\t\t ihCodCentral        ====>  [%d].",LOG07,ihCodCentral);
    vDTrazasLog(modulo,"\t\t lhIndPlexsys        ====>  [%d].",LOG07,lhIndPlexsys);
    vDTrazasLog(modulo,"\t\t lhCodCentralPlexsys ====>  [%d].",LOG07,lhCodCentralPlexsys);				
	vDTrazasLog(modulo,"\t\t lhNumCelularPrexsys ====> [%ld].",LOG07,lhNumCelularPrexsys);
	vDTrazasLog(modulo,"\t\t szhNumSerieHex      ====>  [%s].",LOG07,szhNumSerieHex);
	vDTrazasLog(modulo,"\t\t szhTipTerminal      ====>  [%s].",LOG07,szhTipTerminal);
	vDTrazasLog(modulo,"\t\t szhNumMin           ====>  [%s].",LOG07,szhNumMin);
	vDTrazasLog(modulo,"\t\t szhCodTecnologia    ====>  [%s].",LOG07,szhCodTecnologia);
	vDTrazasLog(modulo,"\t\t szhNumSerie         ====>  [%s].",LOG07,szhNumSerie);
    vDTrazasLog(modulo,"\t\t szhNumImei          ====>  [%s].",LOG07,szhNumImei);
	vDTrazasLog(modulo,"\t\t szhImsi             ====>  [%s].",LOG07,szhImsi);
    vDTrazasLog(modulo,"\t\t szhTipPlan          ====>  [%s].",LOG07,szhTipPlan);

	/*--------------------------------------------------------------*/
	/* Obtencion de la Actuacion del Abonado                        */
	/*--------------------------------------------------------------*/				
	RighTrim(szhTipPlan);
	if( !bfnGetActAbodeAccion( szhRutinaMensaje, szhTipPlan, ihValorUno, szhCodActAbo ) ) {
		return 0;
	}											    								

	/*--------------------------------------------------------------*/
    /* Obtencion de la central asociada a la actuación              */
    /*--------------------------------------------------------------*/				
	RighTrim(szhCodTecnologia);												
	if( ( lhCodActCen = ifnGetActuacionCentralCelularAcc(szhCodActAbo, ihValorUno, szhModulo, szhCodTecnologia ) ) < 0 ) {
		return 0;
	}
					
	/*--------------------------------------------------------------*/
	/* Obtencion del número de movimiento en centrales              */
	/*--------------------------------------------------------------*/									
   	/* EXEC SQL 
		SELECT ICC_SEQ_NUMMOV.NEXTVAL
		INTO   :lhNumMovimiento
		FROM   DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )812;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
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


		
	if (SQLCODE!=SQLOK ) {
		vDTrazasLog  ( modulo, "\n     Error al Obtener Numero de Movimiento. [%s]\n\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     Al Obtener Numero de Movimiento. [%s]\n\n",LOG03,SQLERRM);
		return -1;
	}
	
	vDTrazasLog(modulo,"\t\t lhNumMovimiento        ====>  [%d].",LOG03,lhNumMovimiento);	
					
	RighTrim(szhNumSerie);
	RighTrim(szhNumImei);
	RighTrim(szhImsi);
	RighTrim(szhTipPlan);
	if (lhIndPlexsys == 0){
		/*--------------------------------------------------------------*/
		/* Genera movimiento en Centrales                               */
		/*--------------------------------------------------------------*/
		/* EXEC SQL  
			INSERT INTO ICC_MOVIMIENTO 
				   (NUM_MOVIMIENTO, NUM_ABONADO  , COD_ESTADO    , COD_MODULO , 
				    NUM_INTENTOS  , DES_RESPUESTA, COD_ACTUACION , COD_ACTABO ,
 				    NOM_USUARORA  , FEC_INGRESO  , COD_CENTRAL   , NUM_CELULAR, 
				    NUM_SERIE     , TIP_TERMINAL , IND_BLOQUEO   , NUM_MIN    , 
				    STA           , DES_MENSAJE  , TIP_TECNOLOGIA, 
				    IMEI          , IMSI         , ICC           ,
				    COD_MENSAJE   , PARAM1_MENS  , 
				    PARAM2_MENS) 
		   VALUES (:lhNumMovimiento, :lhNumAbonado  , :ihValorUno      , :szhModulo   ,
				   :ihValorCero    , :szhPendiente  , :lhCodActCen     , :szhCodActAbo,
				   USER            , SYSDATE        , :ihCodCentralMens, :lhNumCelular,
				   :szhNumSerieHex , :szhTipTerminal, :ihValorCero     , :szhNumMin   ,
				   :szhS           , :zshMensaje    , :szhCodTecnologia, 
				   DECODE(:szhNumImei , ' ', NULL, :szhNumImei),
				   DECODE(:szhImsi    , ' ', NULL, :szhImsi),
				   DECODE(:szhNumSerie, ' ', NULL, :szhNumSerie),
				   :szhCodMensaje  , :zshFecProceso, 
				   TO_CHAR(GE_PAC_GENERAL.REDONDEA(:dhImporte, :iDecimal, :ihValorCero),:zshFormatoMonto)); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD_\
ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_ACTABO,NOM_USUA\
RORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,IND_BLOQUEO,NU\
M_MIN,STA,DES_MENSAJE,TIP_TECNOLOGIA,IMEI,IMSI,ICC,COD_MENSAJE,PARAM1_MENS,PAR\
AM2_MENS) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,USER,SYSDATE,:b8,:b9,:b10,:b\
11,:b4,:b13,:b14,:b15,:b16,DECODE(:b17,' ',null ,:b17),DECODE(:b19,' ',null ,:\
b19),DECODE(:b21,' ',null ,:b21),:b23,:b24,TO_CHAR(GE_PAC_GENERAL.REDONDEA(:b2\
5,:b26,:b4),:b28))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )831;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValorUno;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhPendiente;
  sqlstm.sqhstl[5] = (unsigned long )10;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhCodActCen;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
  sqlstm.sqhstl[7] = (unsigned long )3;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentralMens;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumCelular;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[10] = (unsigned long )9;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhNumMin;
  sqlstm.sqhstl[13] = (unsigned long )4;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhS;
  sqlstm.sqhstl[14] = (unsigned long )2;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)zshMensaje;
  sqlstm.sqhstl[15] = (unsigned long )257;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[16] = (unsigned long )8;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[17] = (unsigned long )26;
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[18] = (unsigned long )26;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[19] = (unsigned long )51;
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[20] = (unsigned long )51;
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[21] = (unsigned long )26;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[22] = (unsigned long )26;
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)szhCodMensaje;
  sqlstm.sqhstl[23] = (unsigned long )4;
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)zshFecProceso;
  sqlstm.sqhstl[24] = (unsigned long )11;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)&dhImporte;
  sqlstm.sqhstl[25] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)&iDecimal;
  sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)zshFormatoMonto;
  sqlstm.sqhstl[28] = (unsigned long )21;
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

					
						
		if (SQLCODE)  {
			vDTrazasLog  ( modulo, "\n     Error al Insertar en la icc_movimientos. [%s]\n",LOG03,SQLERRM);							
			vDTrazasError( modulo, "\n     Error al Insertar en la icc_movimientos. [%s]\n",LOG03,SQLERRM);							 
			return -1;
		}
	}else{
		/*--------------------------------------------------------------*/
		/* Obtencion del nuevo número de movimiento en centrales        */
		/*--------------------------------------------------------------*/									
    	/* EXEC SQL 
			SELECT ICC_SEQ_NUMMOV.NEXTVAL
			INTO   :lhNumMovimiento2
			FROM   DUAL; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 29;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select ICC_SEQ_NUMMOV.nextval  into :b0  from DUAL ";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )962;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento2;
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


				
		if (SQLCODE!=SQLOK ) {
		   vDTrazasLog  ( modulo, "\n     Error al Obtener Numero de Movimiento (2). [%s]\n\n",LOG03,SQLERRM);
		   vDTrazasError( modulo, "\n     Al Obtener Numero de Movimiento (2). [%s]\n\n",LOG03,SQLERRM);
		   return -1;
		}						
		/*--------------------------------------------------------------*/
		/* Genera movimiento en Centrales                               */
		/*--------------------------------------------------------------*/
		/* EXEC SQL  
			INSERT INTO ICC_MOVIMIENTO 
				   (NUM_MOVIMIENTO, NUM_ABONADO  , COD_ESTADO   , COD_MODULO    , 
				    NUM_INTENTOS  , DES_RESPUESTA, COD_ACTUACION, COD_ACTABO    ,
				    NOM_USUARORA  , FEC_INGRESO  , COD_CENTRAL  , NUM_CELULAR   , 
				    NUM_SERIE     , TIP_TERMINAL , IND_BLOQUEO  , NUM_MOVPOS    ,
				    NUM_MIN       , STA          , DES_MENSAJE  , TIP_TECNOLOGIA, 
				    IMEI          , IMSI         , ICC          ,
				    COD_MENSAJE   , PARAM1_MENS  , 
				    PARAM2_MENS) 
		    VALUES (:lhNumMovimiento, :lhNumAbonado  , :ihValorUno      , :szhModulo       ,
				    :ihValorCero    , :szhPendiente  , :lhCodActCen     , :szhCodActAbo    ,
					USER            , SYSDATE        , :ihCodCentralMens, :lhNumCelular    ,
				    :szhNumSerieHex , :szhTipTerminal, :ihValorCero     , :lhNumMovimiento2,
				    :szhNumMin      , :szhS          , :zshMensaje      , :szhCodTecnologia, 
 				    DECODE(:szhNumImei , ' ', NULL, :szhNumImei) ,
				    DECODE(:szhImsi    , ' ', NULL, :szhImsi)    ,
 				    DECODE(:szhNumSerie, ' ', NULL, :szhNumSerie),
				    :szhCodMensaje  , :zshFecProceso, 
				    TO_CHAR(GE_PAC_GENERAL.REDONDEA(:dhImporte, :iDecimal, :ihValorCero),:zshFormatoMonto)); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 30;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD_\
ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_ACTABO,NOM_USUA\
RORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,IND_BLOQUEO,NU\
M_MOVPOS,NUM_MIN,STA,DES_MENSAJE,TIP_TECNOLOGIA,IMEI,IMSI,ICC,COD_MENSAJE,PARA\
M1_MENS,PARAM2_MENS) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,USER,SYSDATE,:b8,\
:b9,:b10,:b11,:b4,:b13,:b14,:b15,:b16,:b17,DECODE(:b18,' ',null ,:b18),DECODE(\
:b20,' ',null ,:b20),DECODE(:b22,' ',null ,:b22),:b24,:b25,TO_CHAR(GE_PAC_GENE\
RAL.REDONDEA(:b26,:b27,:b4),:b29))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )981;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValorUno;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhPendiente;
  sqlstm.sqhstl[5] = (unsigned long )10;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhCodActCen;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
  sqlstm.sqhstl[7] = (unsigned long )3;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentralMens;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumCelular;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[10] = (unsigned long )9;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&lhNumMovimiento2;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhNumMin;
  sqlstm.sqhstl[14] = (unsigned long )4;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhS;
  sqlstm.sqhstl[15] = (unsigned long )2;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)zshMensaje;
  sqlstm.sqhstl[16] = (unsigned long )257;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[17] = (unsigned long )8;
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[18] = (unsigned long )26;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[19] = (unsigned long )26;
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[20] = (unsigned long )51;
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[21] = (unsigned long )51;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[22] = (unsigned long )26;
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[23] = (unsigned long )26;
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhCodMensaje;
  sqlstm.sqhstl[24] = (unsigned long )4;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)zshFecProceso;
  sqlstm.sqhstl[25] = (unsigned long )11;
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)&dhImporte;
  sqlstm.sqhstl[26] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)&iDecimal;
  sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[28] = (         int  )0;
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)zshFormatoMonto;
  sqlstm.sqhstl[29] = (unsigned long )21;
  sqlstm.sqhsts[29] = (         int  )0;
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
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

					
						
		if (SQLCODE)  {
			vDTrazasLog  ( modulo, "\n     Error al Insertar en la icc_movimientos(2). [%s]\n",LOG03,SQLERRM);							
			vDTrazasError( modulo, "\n     Error al Insertar en la icc_movimientos(2). [%s]\n",LOG03,SQLERRM);							 
			return -1;
		}
					
		/*--------------------------------------------------------------*/
		/* Genera Segundo movimiento en Centrales                       */
		/*--------------------------------------------------------------*/
		/* EXEC SQL  
			INSERT INTO ICC_MOVIMIENTO 
				   (NUM_MOVIMIENTO, NUM_ABONADO  , COD_ESTADO   , COD_MODULO   , 
				    NUM_INTENTOS  , DES_RESPUESTA, COD_ACTUACION, COD_ACTABO   ,
				    NOM_USUARORA  , FEC_INGRESO  , COD_CENTRAL  , NUM_CELULAR  , 
				    NUM_SERIE     , TIP_TERMINAL , IND_BLOQUEO  , NUM_MOVANT   , 
				    NUM_MIN       , STA          , DES_MENSAJE  , TIP_TECNOLOGIA, 
				    IMEI          , IMSI         , ICC          ,
				    COD_MENSAJE   , PARAM1_MENS  , 
				    PARAM2_MENS) 
 		    VALUES (:lhNumMovimiento2, :lhNumAbonado  , :ihValorUno         , :szhModulo          ,
				    :ihValorCero     , :szhPendiente  , :lhCodActCen        , :szhCodActAbo       ,
				    USER             , SYSDATE        , :lhCodCentralPlexsys, :lhNumCelularPrexsys,
				    :szhNumSerieHex  , :szhTipTerminal, :ihValorCero        , :lhNumMovimiento    ,
				    :szhNumMin       , :szhS          , :zshMensaje         , :szhCodTecnologia   , 
				    DECODE(:szhNumImei , ' ', NULL, :szhNumImei),
				    DECODE(:szhImsi    , ' ', NULL, :szhImsi),
				    DECODE(:szhNumSerie, ' ', NULL, :szhNumSerie),
				    :szhCodMensaje  , :zshFecProceso, 
				    TO_CHAR(GE_PAC_GENERAL.REDONDEA(:dhImporte, :iDecimal, :ihValorCero),:zshFormatoMonto)); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 30;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD_\
ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_ACTABO,NOM_USUA\
RORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,IND_BLOQUEO,NU\
M_MOVANT,NUM_MIN,STA,DES_MENSAJE,TIP_TECNOLOGIA,IMEI,IMSI,ICC,COD_MENSAJE,PARA\
M1_MENS,PARAM2_MENS) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,USER,SYSDATE,:b8,\
:b9,:b10,:b11,:b4,:b13,:b14,:b15,:b16,:b17,DECODE(:b18,' ',null ,:b18),DECODE(\
:b20,' ',null ,:b20),DECODE(:b22,' ',null ,:b22),:b24,:b25,TO_CHAR(GE_PAC_GENE\
RAL.REDONDEA(:b26,:b27,:b4),:b29))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1116;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumMovimiento2;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihValorUno;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhModulo;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhPendiente;
  sqlstm.sqhstl[5] = (unsigned long )10;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhCodActCen;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodActAbo;
  sqlstm.sqhstl[7] = (unsigned long )3;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCentralPlexsys;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lhNumCelularPrexsys;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[10] = (unsigned long )9;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&lhNumMovimiento;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhNumMin;
  sqlstm.sqhstl[14] = (unsigned long )4;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhS;
  sqlstm.sqhstl[15] = (unsigned long )2;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)zshMensaje;
  sqlstm.sqhstl[16] = (unsigned long )257;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[17] = (unsigned long )8;
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[18] = (unsigned long )26;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[19] = (unsigned long )26;
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[20] = (unsigned long )51;
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhImsi;
  sqlstm.sqhstl[21] = (unsigned long )51;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[22] = (unsigned long )26;
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[23] = (unsigned long )26;
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhCodMensaje;
  sqlstm.sqhstl[24] = (unsigned long )4;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)zshFecProceso;
  sqlstm.sqhstl[25] = (unsigned long )11;
  sqlstm.sqhsts[25] = (         int  )0;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)&dhImporte;
  sqlstm.sqhstl[26] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[26] = (         int  )0;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)&iDecimal;
  sqlstm.sqhstl[27] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[27] = (         int  )0;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)&ihValorCero;
  sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[28] = (         int  )0;
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)zshFormatoMonto;
  sqlstm.sqhstl[29] = (unsigned long )21;
  sqlstm.sqhsts[29] = (         int  )0;
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
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

					

		if (SQLCODE)  {
			vDTrazasLog  ( modulo, "\n     Error al Insertar en la icc_movimientos(3). [%s]\n",LOG03,SQLERRM);							
			vDTrazasError( modulo, "\n     Error al Insertar en la icc_movimientos(3). [%s]\n",LOG03,SQLERRM);							 
			return -1;
		}
	} /* end if (lhIndPlexsys == 0) */						
	
    return 0;        
} /* ifnEnviaSMS */

/*==================================================================================================*/
/* Funcion que Selecciona el texto del mensaje a enviar al cliente y central de envio               */
/*==================================================================================================*/
BOOL bfnSelectDescripcionMensaje(char *szCodMensaje, char *szCodIdioma, char *szpDescMensaje )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhCodConcepto [13]; /* EXEC SQL VAR szhCodConcepto  IS STRING (13); */ 

	char	szhDescMensaje[257]; /* EXEC SQL VAR szhDescMensaje  IS STRING(257); */ 

	char	szhCodIdioma    [6]; /* EXEC SQL VAR szhCodIdioma    IS STRING  (6); */ 

/* EXEC SQL END DECLARE SECTION; */ 

char 	modulo[] = "bfnSelectDescripcionMensaje";

	memset(szhCodConcepto, '\0', sizeof( szhCodConcepto ) );
	memset(szhCodIdioma  , '\0', sizeof( szhCodIdioma ) );
	memset(szhDescMensaje, '\0', sizeof( szhDescMensaje ) );
	
	strcpy(szhCodConcepto, szCodMensaje);
	strcpy(szhCodIdioma  , szCodIdioma );

	/* EXEC SQL 
	SELECT DES_CONCEPTO
	 INTO  :szhDescMensaje	
	 FROM  GE_MULTIIDIOMA
	WHERE  NOM_TABLA	= :szhICG_MENSA
	  AND  NOM_CAMPO	= :szhCOD_MENSA
	  AND  COD_CONCEPTO = :szhCodConcepto
	  AND  COD_IDIOMA	= :szhCodIdioma
	  AND  COD_PRODUCTO = :ihValorUno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 30;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select DES_CONCEPTO into :b0  from GE_MULTIIDIOMA where ((((\
NOM_TABLA=:b1 and NOM_CAMPO=:b2) and COD_CONCEPTO=:b3) and COD_IDIOMA=:b4) and\
 COD_PRODUCTO=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1251;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDescMensaje;
 sqlstm.sqhstl[0] = (unsigned long )257;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhICG_MENSA;
 sqlstm.sqhstl[1] = (unsigned long )12;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCOD_MENSA;
 sqlstm.sqhstl[2] = (unsigned long )12;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodConcepto;
 sqlstm.sqhstl[3] = (unsigned long )13;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodIdioma;
 sqlstm.sqhstl[4] = (unsigned long )6;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValorUno;
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



	if ((SQLCODE!=SQLOK) && (SQLCODE!=SQLNOTFOUND))	{
		vDTrazasLog  ( modulo, "\n     Error en consultar descripcion del mensaje. [%s]\n",LOG03,SQLERRM);
		vDTrazasError( modulo, "\n     Error en consultar descripcion del mensaje. [%s]\n",LOG03,SQLERRM);
		return FALSE;
	} /* end if (SQLCODE!=SQLOK)	*/
	
	strcpy( szpDescMensaje, szhDescMensaje );
	return TRUE;

}/* end bfnSelectDescripcionMensaje */

/*==================================================================================================*/
/* bfnGetActAbodeAccion                                                                             */
/*==================================================================================================*/
BOOL bfnGetActAbodeAccion(char *szCodRutina, char *szCodTiPlan, int iCodProducto, char *szActuacionOut)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhCodRutina[6];
	char szhCodTiPlan[9];
	 int ihCodProducto;
	char szhCodActAbo[3]; 
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnGetActAbodeAccion";

	memset( szhCodRutina, '\0', sizeof( szhCodRutina ) );
	memset( szhCodTiPlan, '\0', sizeof( szhCodTiPlan ) );
	memset( szhCodActAbo, '\0', sizeof( szhCodActAbo ) );

	strcpy( szhCodRutina, szCodRutina );
	strcpy( szhCodTiPlan, szCodTiPlan );
	ihCodProducto = iCodProducto;

	RighTrim( szhCodRutina );
	RighTrim( szhCodTiPlan );

	/* EXEC SQL
	SELECT COD_ACTABO
	INTO   :szhCodActAbo
	FROM   CO_RUTINA_ACTABO_TD
	WHERE  COD_RUTINA = :szhCodRutina
	AND    COD_TIPLAN = :szhCodTiPlan
	AND    COD_PRODUCTO = :ihCodProducto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 30;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ACTABO into :b0  from CO_RUTINA_ACTABO_TD where (\
(COD_RUTINA=:b1 and COD_TIPLAN=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1290;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodActAbo;
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodRutina;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodTiPlan;
 sqlstm.sqhstl[2] = (unsigned long )9;
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



	if( (sqlca.sqlcode != SQLOK) && (sqlca.sqlcode != SQLNOTFOUND) ) 	{  
		vDTrazasLog  ( modulo, "\n     Error al recuperar COD_ACTABO. [%s]\n",LOG03,SQLERRM);		
		return FALSE;
	}  

	if( sqlca.sqlcode == SQLNOTFOUND ) 	{  
		vDTrazasLog  ( modulo, "\n     No se encuentra definida relacion RUTINA/ACTABO.\n",LOG03);				
		return FALSE;
	}  

	RighTrim( szhCodActAbo );
	strcpy( szActuacionOut, szhCodActAbo );
    vDTrazasLog  ( modulo, "\n     Actuacion Abonado recuperada => [%s]\n",LOG03,szActuacionOut);		
	return TRUE;
	
} /* BOOL bfnGetActAbodeAccion() */

/*==================================================================================================*/
/* Funcion que Busca el codigo de Activacion en Central para la actuacion de abonado                */
/*==================================================================================================*/
int ifnGetActuacionCentralCelularAcc(char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int ihCodActCen   = 0;
	int ihCodProducto = 0;
	char szhActAbo       [3]; /* EXEC SQL VAR szhActAbo        IS STRING(3); */ 

	char szhCodModulo    [3]; /* EXEC SQL VAR szhCodModulo     IS STRING(3); */ 

	char szhCodTecnologia[8]; /* EXEC SQL VAR szhCodTecnologia IS STRING(8); */ 

/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnGetActuacionCentralCelularAcc";

	memset( szhActAbo       , '\0', sizeof( szhActAbo ) );
	memset( szhCodModulo    , '\0', sizeof( szhCodModulo ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	
	strcpy( szhActAbo       , szActAbo );
	strcpy( szhCodModulo    , szCodModulo );
	strcpy( szhCodTecnologia, szCodTecnologia );
	ihCodProducto = iCodProducto;
	
	RighTrim(szhActAbo );
	RighTrim(szhCodModulo );
	RighTrim(szhCodTecnologia);
	
	/* EXEC SQL
	SELECT COD_ACTCEN
	INTO  :ihCodActCen
	FROM  GA_ACTABO
	WHERE COD_ACTABO   = :szhActAbo
	AND   COD_PRODUCTO = :ihCodProducto
	AND   COD_MODULO   = :szhCodModulo
	AND   COD_TECNOLOGIA = :szhCodTecnologia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 30;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ACTCEN into :b0  from GA_ACTABO where (((COD_ACTA\
BO=:b1 and COD_PRODUCTO=:b2) and COD_MODULO=:b3) and COD_TECNOLOGIA=:b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1321;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodActCen;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhActAbo;
 sqlstm.sqhstl[1] = (unsigned long )3;
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
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodModulo;
 sqlstm.sqhstl[3] = (unsigned long )3;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodTecnologia;
 sqlstm.sqhstl[4] = (unsigned long )8;
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



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {  
        vDTrazasLog  ( modulo, "\n     ACTABO => [%s], TECNOLOGIA => [%s], Recuperando Actuacion Central => [%s].\n",LOG03,szhActAbo, szhCodTecnologia);				
		return -1;
	} 

	if( sqlca.sqlcode == SQLNOTFOUND )	 {  
        vDTrazasLog  ( modulo, "\n     ACTABO => [%s], TECNOLOGIA => [%s], No se encuentra definida en Actuaciones Abonado.\n",LOG03,szhActAbo, szhCodTecnologia);						
		return -1;
	} 

     vDTrazasLog  ( modulo, "\n     ACTABO => [%s], TECNOLOGIA => [%s], Actuacion Central => [%d]..\n",LOG03,szhActAbo, szhCodTecnologia, ihCodActCen);						
	return ihCodActCen;
} /* int ifnGetActuacionCentralCelularAcc( char *szActAbo ) */

/* Fin Incidencia 120541 - 06.01.2010 */

/*Inicio CSR-11002*/
void vfnSubString(char* target, char* strn, int index, int size)
{
	int i;
	int z = 0;
	int y = index;
	char* finalString = (char*)malloc((size+1) * sizeof(char));
	
	for(i = 0; i < size; i++)
	{
		finalString[z] = strn[y];
		y++;
		z++;
	}
	finalString[z] = '\0';
	strcpy(target, finalString);
}
/*Fin CSR-11002*/
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

