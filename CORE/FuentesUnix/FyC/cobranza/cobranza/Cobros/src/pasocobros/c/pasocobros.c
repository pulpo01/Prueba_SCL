
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
           char  filnam[19];
};
static const struct sqlcxp sqlfpn =
{
    18,
    "./pc/pasocobros.pc"
};


static unsigned int sqlctx = 13836387;


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
   unsigned char  *sqhstv[37];
   unsigned long  sqhstl[37];
            int   sqhsts[37];
            short *sqindv[37];
            int   sqinds[37];
   unsigned long  sqharm[37];
   unsigned long  *sqharc[37];
   unsigned short  sqadto[37];
   unsigned short  sqtdso[37];
} sqlstm = {12,37};

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

 static const char *sq0031 = 
"select  /*+  full (FA_FACTCOBR)  +*/ COD_CONCFACT ,COD_CONCCOBR  from FA_FAC\
TCOBR            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,0,0,273,271,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,301,283,0,0,0,0,0,1,0,
39,0,0,1,0,0,269,289,0,0,1,0,0,1,0,2,3,0,0,
58,0,0,1,0,0,271,295,0,0,0,0,0,1,0,
73,0,0,2,209,0,260,365,0,0,6,1,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,1,
97,0,0,
112,0,0,3,55,0,260,536,0,0,1,0,0,1,0,2,3,0,0,
131,0,0,4,180,0,260,660,0,0,7,6,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,
174,0,0,5,212,0,260,682,0,0,8,7,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,
221,0,0,6,95,0,260,799,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
248,0,0,7,95,0,260,815,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,5,0,0,
275,0,0,8,96,0,260,834,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
298,0,0,9,73,0,260,850,0,0,1,0,0,1,0,2,3,0,0,
317,0,0,10,167,0,260,918,0,0,5,2,0,1,0,1,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,1,3,0,0,
352,0,0,11,116,0,260,1125,0,0,5,3,0,1,0,2,4,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,
387,0,0,12,141,0,260,1149,0,0,7,6,0,1,0,1,4,0,0,1,4,0,0,1,4,0,0,2,4,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,
430,0,0,13,171,0,260,1219,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,3,0,0,
457,0,0,14,114,0,262,1284,0,0,2,2,0,1,0,2,97,0,0,1,97,0,0,
480,0,0,15,100,0,261,1536,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
507,0,0,16,64,0,260,1601,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
530,0,0,17,333,0,260,1615,0,0,3,1,0,1,0,2,5,0,0,2,4,0,0,1,3,0,0,
557,0,0,18,152,0,260,1634,0,0,2,1,0,1,0,2,4,0,0,1,3,0,0,
580,0,0,19,112,0,261,1650,0,0,4,4,0,1,0,1,5,0,0,1,4,0,0,1,4,0,0,1,3,0,0,
611,0,0,20,83,0,260,1664,0,0,3,1,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,
638,0,0,21,294,0,260,1680,0,0,7,5,0,1,0,2,5,0,0,2,5,0,0,1,5,0,0,1,5,0,0,1,3,0,
0,1,97,0,0,1,3,0,0,
681,0,0,22,286,0,261,1701,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,
716,0,0,23,54,0,260,1832,0,0,1,0,0,1,0,2,3,0,0,
735,0,0,24,104,0,262,1845,0,0,3,3,0,1,0,3,5,0,0,1,97,0,0,1,97,0,0,
762,0,0,25,195,0,262,1860,0,0,7,7,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,0,3,3,0,
0,2,3,0,0,2,97,0,0,
805,0,0,26,100,0,261,1921,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
832,0,0,27,93,0,260,1974,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
855,0,0,28,129,0,260,1992,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
878,0,0,29,96,0,260,2045,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
901,0,0,30,0,0,273,2179,0,0,1,1,0,1,0,1,5,0,0,
920,0,0,30,0,0,301,2193,0,0,0,0,0,1,0,
935,0,0,30,0,0,269,2265,0,0,31,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,
0,2,3,0,0,2,4,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
1074,0,0,30,0,0,271,2414,0,0,0,0,0,1,0,
1089,0,0,31,93,0,265,2488,0,0,0,0,0,1,0,
1104,0,0,31,0,0,269,2498,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
1127,0,0,31,0,0,271,2529,0,0,0,0,0,1,0,
1142,0,0,32,0,0,273,2718,0,0,1,1,0,1,0,1,5,0,0,
1161,0,0,32,0,0,301,2733,0,0,0,0,0,1,0,
1176,0,0,32,0,0,269,2822,0,0,37,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,
0,2,3,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,3,0,0,2,4,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,
5,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,
1339,0,0,32,0,0,271,2929,0,0,0,0,0,1,0,
1354,0,0,33,0,0,273,3309,0,0,1,1,0,1,0,1,5,0,0,
1373,0,0,33,0,0,277,3316,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,
1400,0,0,33,0,0,273,3361,0,0,1,1,0,1,0,1,5,0,0,
1419,0,0,33,0,0,277,3371,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
1442,0,0,34,391,0,259,3506,0,0,12,12,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1505,0,0,35,496,0,259,3724,0,0,24,24,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1616,0,0,36,699,0,259,3955,0,0,28,28,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1743,0,0,37,186,0,260,4103,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,
1778,0,0,38,184,0,261,4125,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,
97,0,0,
1813,0,0,32,0,0,273,4255,0,0,1,1,0,1,0,1,5,0,0,
1832,0,0,32,0,0,301,4270,0,0,0,0,0,1,0,
1847,0,0,32,0,0,269,4276,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,
1890,0,0,39,0,0,273,4469,0,0,1,1,0,1,0,1,5,0,0,
1909,0,0,39,0,0,301,4483,0,0,0,0,0,1,0,
1924,0,0,39,0,0,269,4488,0,0,1,0,0,1,0,2,3,0,0,
1943,0,0,40,65,0,260,4502,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
};


/**********************************************************************************/
/* Funcion    : PASOCOBROS  (... The George Lizama's Master Piece ...)            */
/* 16/05/2000 : RBR : by George Lizama's Intructions                              */
/**********************************************************************************/
/* Modificaciones																  */
/* 16-04-2003	Se restringe los documentos a considerar al momento de            */
/*				   actualizar la traza de facturacion                             */
/* 17-07-2003  Se agrega condicion stHistDocu.iIndFactur == 1 antes de			  */
/*			      pasar a cobros.                                                 */
/* 15-10-2003  Modificacion para proyecto Calculo de IVA.				          */
/*				   Se reemplaza tabla FA_REPPASOCOBROS por tabla FA_REPDETALLE_TO */
/**********************************************************************************/
/* 24-12-2004  Modificado por Proyecto MAS_03043 Mejoras Cancelacion de Credito   */
/**********************************************************************************/

#define _PASOC_PC_     
#include <geora.h>
#include <ORAcarga.h>
#include <deftypes.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include <genco.h>
#include <intCobFac.h>
#include "pasocobros.h"
#include <New_Interfact.h>

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


/*****************************************************************************/
/*                    -- Declaracion de Variables Globales --                */
/*****************************************************************************/
/* EXEC SQL BEGIN DECLARE SECTION; */ 
 
	char szPrefPlazaDefault[26];
	char szEntGestion[2];        /* 18-05-2004 XM-200405180055 */
	int  ihValor_cero = 0;
	int  ihValor_uno  = 1;
	int  ihValor_dos  = 2;
	int  ihValor_tres = 3;
    char szInd_TotalFactura[2];/* EXEC SQL VAR szInd_TotalFactura IS STRING(2); */ 
   /*RA-200601130570 19.01.2006 Soporte RyC */
	long lTotalConcCartera;
	int  ihNotaAbono ;
/* EXEC SQL END DECLARE SECTION; */ 


static char szExePasoC [1024];
static char szUsage [] =
						"\nUso : pasocobros -u [Usuario]/[Password] [Opciones]"
						"\n\tOpciones :"
						"\n\t-Batch    -d CodTipDocum [-c Ciclo] -g CodModGener -l [NivelLog]"
						"\n\t-Online   -g CodModGener -l [NivelLog]"
						"\n\t-Unico    -p NumProceso -l [NivelLog]\n";

static char szNomTablaCab [25];/* EXEC SQL VAR szNomTablaCab IS STRING(25); */ 

static char szNomTablaDet [25];/* EXEC SQL VAR szNomTablaDet IS STRING(25); */ 

long        lNumProcPasoCob;
int	    	iProcTermOk  = iESTAPROC_TERMINADO_OK;
int	    	iProcTermErr = iESTAPROC_TERMINADO_ERROR;
int	    	iCodEstaDocEnt;
int	    	iCodEstaDocSal;

/* Variables de uso general para proceso de documentos con error */
/*int      	giCntRegistrosProc;  Requerimiento de Soporte - 41321 - 07.06.2007 */
long     	giCntRegistrosProc; /* Requerimiento de Soporte - 41321 - 07.06.2007 */
int			giEstadoDocumento  = 0;
long		glTotalDoctosInter = 0;

/* Inicio Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
long        lTotAbonados       = 0; 
long        lTotalConceptos    = 0; 
static char   szNomTablaDetalle  [25];/* EXEC SQL VAR szNomTablaDetalle  IS STRING(25); */ 

/* Fin Requerimiento de Soporte - 84622 - 13.04.2009 MQG */

TAcumDoctoPaso	stAcumDoctoPaso[iCNTDOCTOS];	/* estructura de documentos con error */
DATOS_FACT	    stDoctosInter[iMAXARRAYWORK];	/* estructura de trabajo de documentos a intercalar */
	
/*****************************************************************************/
/*                       funcion : main                                      */
/* -Lanza el proceso de Paso a Cobros basicamente toma los conceptos factura-*/
/*  dos y los incorpora a la cartera de Cobros, actualizando asi la cartera  */
/* -Valores de Retorno : 0 => Todo OK                                        */
/*                      !0 => Error en algunas de las funciones que ejecuta  */
/*                           el main.                                        */
/*****************************************************************************/
int main (int argc, char* argv[])
{
extern int   opterr;
extern int   optopt;
extern char *optarg;

char opt[]  = "u:B:d:c:O:g:U:p:l:";
int  iOpt          = 0;

char szUsuario[61] = "";
char *pszTmp       = "";
char szFecha  [20] = "";

    CONFIG stConfig;
    memset (&stConfig,0,sizeof (CONFIG));
    memset (&stStatus,0,sizeof (STATUS));

    /* asigna valores por Default definidas en .h  GAC 08-08-2003*/
    strcpy( szPrefPlazaDefault, szPREF_PLAZA_DEFAULT );

    while ( (iOpt = getopt (argc,argv,opt)) != EOF)
    {
          switch (iOpt)
             {
                 case 'u':
                   if ( strlen (optarg) )
                   {
                            strcpy (szUsuario,optarg)  ;
                            stConfig.bOptUsuario = TRUE; 
                   }
                   break;
                 case 'U':
                   if ( strlen (optarg) )
                   {
                        if (!strcmp (optarg,"nico"))
                        {
                            stConfig.bOptUnico = TRUE;
                        }
                   }
                   break;
                 case 'B':
                   if ( strlen (optarg) )
                   {
                        if (!strcmp (optarg,"atch"))
                            stConfig.bOptBatch = TRUE;
                   }
                   break;
                 case 'O':
                   if ( strlen (optarg) )
                   {
                        if (!strcmp (optarg,"nline"))
                            stConfig.bOptOnline = TRUE;
                   }
                   break;
                 case 'd':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptCodTipDocum = TRUE         ;
                        stConfig.iCodTipDocum    = atoi(optarg); 
                   }
                   break;   
                 case 'c':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptCodCicloFact= TRUE         ;
                        stConfig.lCodCicloFact  = atol(optarg); 
/*                        printf("!!ERROR ESTE BINARIO NO ESTA HABILITADO PARA PROCESAR CICLOS , SOLO NO CICLOS\n");
                        exit(0);                        */
                   }
                   break;   
                 case 'g':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptCodModGener = TRUE;
                        strcpy(stConfig.szCodModGener, optarg);
                   }
                   break;   
                 case 'p':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptNumProceso = TRUE;
                        strcpy(stConfig.szNumProceso, optarg);
                   }
                   break;   
                 case 'l':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptNivelLog = TRUE;
                        stConfig.iNivelLog    = atoi(optarg);
                   }
                   break;   

             }/* fin switch */
    }/* fin While de Opciones */
    if (!stConfig.bOptUsuario)
    {
         fprintf(stderr,"\n\tError Falta Usuario en Parametros de Entrada: \n%s\n", szUsage);
         return (1);
    }
    else
    {
       if ( (pszTmp = (char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tFormato Usuario Oracle Incorrecto:\n%s\n", szUsage);
             return (1);
       }
       else
       {
          strncpy (stConfig.szUsuario ,szUsuario,pszTmp-szUsuario);
          strcpy  (stConfig.szPassWord, pszTmp+1);
       }
    }

    if (    (stConfig.bOptCodModGener && stConfig.bOptCodCicloFact)
         || (stConfig.bOptBatch && stConfig.bOptUnico             )  )
    {
           fprintf (stderr, "\n\tError Sobran parametros de Entrada : %s\n",szUsage);
           return (1);
    }

    if (    ( !stConfig.bOptCodModGener && !stConfig.bOptCodCicloFact && !stConfig.bOptUnico )
         || ( !stConfig.bOptBatch && !stConfig.bOptUnico                                     )
         || ( stConfig.bOptBatch && !stConfig.bOptCodTipDocum                                )
         || ( stConfig.bOptUnico && !stConfig.bOptNumProceso                                 )  )
    {
           fprintf (stderr, "\n\tError Faltan parametros de Entrada : %s\n",szUsage);
           return (1);
    }

    if( !stConfig.bOptNivelLog )
         stConfig.iNivelLog = iNIVEL_DEF;

    if( !bfnInitPasoCobros( &stConfig, &stStatus ) )
         return (2);

    if( !bfnPasoCobros( stConfig, &stStatus ) )
         iDError( szExePasoC, ERR042, vInsertarIncidencia );
    else
        vDTrazasLog (szExePasoC,"\n\t*** Proceso Paso a Cobros OK ***\n",LOG03);

    if (stConfig.bOptCodCicloFact)
    {
        if(bfbFinPasocobros(stConfig.lCodCicloFact))
        {
                if (!bfnSelectSysDate(szFecha))
                     return FALSE;

                stTrazaProc.iCodEstaProc = iPROC_EST_OK;
                strcpy(stTrazaProc.szFecTermino,szFecha);
                strcpy(stTrazaProc.szGlsProceso,"Proceso de Paso a Cobros OK");
                bPrintTrazaProc(stTrazaProc);
                if(!bfnUpdateTrazaProc(stTrazaProc))
                     return FALSE;

                if (!bfnOraCommit ())
                {
                     iDError (szExePasoC,ERR000,vInsertarIncidencia, "CommitWork",szfnORAerror());
                     return FALSE;
                }
        }
    }
    bfnExitPasoCobros ();
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);

    return (0); 
}/***************************** Final main ***********************************/


static BOOL bfbFinPasocobros(long lhCodCiclFact)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szCadenaSQL[1024];
	long lhNumReg = 0;
/* EXEC SQL END DECLARE SECTION; */ 

    
    memset( szCadenaSQL, '\0', sizeof( szCadenaSQL ) );
	sprintf( szCadenaSQL, 
	"SELECT NVL( COUNT(*), 0 ) "
	"  FROM FA_FACTDOCU_%ld "
	" WHERE IND_PASOCOBRO <= 0 "
	"   AND IND_ANULADA = 0 "
	"   AND COD_TIPDOCUM NOT IN ( SELECT COD_VALOR "
	"                               FROM GED_CODIGOS "
	"                              WHERE NOM_TABLA = 'FA_FACTDOCU' "
	"                                AND NOM_COLUMNA = 'COD_TIPDOCUM' "
	"                                AND COD_MODULO = 'CO' )", lhCodCiclFact );
    
    /* EXEC SQL PREPARE sql_fin_pasocobros FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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


    if (SQLCODE)  {
        vDTrazasError( szExeName, "Error en SQL-PREPARE sql_fin_pasocobros Error => [%d][%s].", LOG01, SQLCODE, SQLERRM );
        return  (FALSE);
    }

    /* EXEC SQL DECLARE cur_count_pasocobros CURSOR FOR sql_fin_pasocobros; */ 

    if (SQLCODE)  {
        vDTrazasError( szExeName, "Error en DECLARE cur_count_pasocobros Error => [%d][%s].", LOG01, SQLCODE, SQLERRM );
        return  (FALSE);
    }

    /* EXEC SQL OPEN cur_count_pasocobros; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)  {
        vDTrazasError( szExeName, "Error en OPEN cur_count_pasocobros Error => [%d][%s].", LOG01, SQLCODE, SQLERRM );
        return  (FALSE);
    }

    /* EXEC SQL FETCH cur_count_pasocobros INTO :lhNumReg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )39;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumReg;
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


    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)    {
        vDTrazasError( szExeName, "Error en FETCH cur_count_pasocobros Error => [%d][%s].", LOG01, SQLCODE, SQLERRM );
        return  (FALSE);
    }

    /* EXEC SQL CLOSE cur_count_pasocobros; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )58;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog ( szExeName ,   "\n\t ********* Documentos Sin Pasar A Cobros ************"
                                "\t\t\t\t  ==> Cod_CiclFact          [%ld]\n"
                                "\t\t\t\t  ==> Numero de Facturas    [%ld]"
                            ,   (lhNumReg==0?LOG03:LOG02),lhCodCiclFact,lhNumReg);

    if (lhNumReg > 0)    {
        vDTrazasError( szExeName ,  "\n\t ** Documentos Sin Pasar A Cobros **"
                                    "\n\t\t\t\t  ==> Cod_CiclFact          [%ld]"
                                    "\n\t\t\t\t  ==> Numero de Facturas    [%ld]"
                                 ,  LOG02,lhCodCiclFact,lhNumReg);
        return FALSE;
    }
    return TRUE;
}

/*****************************************************************************/
/*                            funcion : bfnInitPasoCobros                    */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnInitPasoCobros (CONFIG *pstConfig, STATUS *pstStatus)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   short    row = 0;
   int      ihCodTipDocum;
   long     lNumFolio;
   short    sIndPasoCobro; 
   short    sIndAnulada; 
   double   dSaldo_Debe;
   double   dSaldo_Haber;
   char     szhCodModGener[4];/* EXEC SQL VAR szhCodModGener IS STRING(4); */ 

   char     szhddmmyy  [7];
   char     szhPUNTUAL [8];
/* EXEC SQL END DECLARE SECTION; */ 

char szFechDesde [15]= "";
char szFechHasta [15]= "";
char szComando [255]= "";
char *szDirLogs;

    strcpy(szhddmmyy,"ddmmyy");
    strcpy(szhPUNTUAL,"PUNTUAL");
  
    szDirLogs   =(char *)malloc(1024);
    if( !bfnConnectORA( pstConfig->szUsuario, pstConfig->szPassWord ) )   {
        fprintf (stderr,"\n\t=>Error en la Conexion Oracle\n");
        return FALSE;
    }
    /* Datos Iniciales de Tiempo */
    cpu_ini = clock();
    time (&real_ini) ;
    pstStatus->OraConnected = 1;
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (5);

    if (!bGetDatosGener (&stDatosGener,szSysDate))
        return  FALSE;

	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )	{
		fprintf( stderr, "Error al realizar carga de bGetParamDecimales()." );
		return -1;
	}

	if( pstConfig->bOptUnico )  {

		sprintf(szDirLogs,"%s/pasocobros/NoCiclo/%8.8s/",szDirLogs,szSysDate);
		sprintf (pstStatus->LogName,"%s/PasoCobros_%s.log",szDirLogs,pstConfig->szNumProceso);
		sprintf (pstStatus->ErrName,"%s/PasoCobros_%s.err",szDirLogs,pstConfig->szNumProceso); 
		/* Rao: Se incorpora la consulta a la interfaz para recuperar el modo de generacion */
		/* EXEC SQL
		SELECT A.NUM_FOLIO,
			   A.IND_PASOCOBRO,
			   A.IND_ANULADA,
			   A.COD_TIPDOCUM,
			   B.COD_MODGENER
		INTO  :lNumFolio,
			   :sIndPasoCobro,
			   :sIndAnulada,
			   :ihCodTipDocum,
			   :szhCodModGener
		FROM  FA_FACTDOCU_NOCICLO A, FA_INTERFACT B
		WHERE A.NUM_PROCESO = :pstConfig->szNumProceso
		AND   A.NUM_PROCESO=B.NUM_PROCESO; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select A.NUM_FOLIO ,A.IND_PASOCOBRO ,A.IND_ANULADA ,A.COD_T\
IPDOCUM ,B.COD_MODGENER into :b0,:b1,:b2,:b3,:b4  from FA_FACTDOCU_NOCICLO A ,\
FA_INTERFACT B where (A.NUM_PROCESO=:b5 and A.NUM_PROCESO=B.NUM_PROCESO)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )73;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lNumFolio;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&sIndPasoCobro;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&sIndAnulada;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
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
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodModGener;
  sqlstm.sqhstl[4] = (unsigned long )4;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(pstConfig->szNumProceso);
  sqlstm.sqhstl[5] = (unsigned long )13;
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


		
		if (SQLCODE == SQLNOTFOUND)
		{
			printf("\nEl NUM_PROCESO pasado como parametro no existe en la FA_FACTDOCU_NOCICLO.\n\n");
			return FALSE;
		}
		else
		{
			pstConfig->iCodTipDocum = ihCodTipDocum;
			strcpy(pstConfig->szCodModGener,"\0");
			if (lNumFolio == 0)
			{
				printf("\nEl NUM_PROCESO pasado como parametro no se encuentra Foliado.\n\n");
				return FALSE;
			}
			if (sIndPasoCobro != 0)
			{
				printf("\nEl NUM_PROCESO pasado como parametro YA fue Intercalado.\n\n");
				return FALSE;
			}
			if (sIndAnulada != 0)
			{
				printf("\nEl NUM_PROCESO pasado como parametro se encuentra Anulado.\n\n");
				return FALSE;
			}
		}
	}
	else /* Batch , Online */
	{
		if (pstConfig->bOptCodCicloFact)
			sprintf(szDirLogs,"%s/pasocobros/%ld/",szDirLogs,pstConfig->lCodCicloFact);
		else
			sprintf(szDirLogs,"%s/pasocobros/NoCiclo/%8.8s/",szDirLogs,szSysDate);
		
		sprintf (pstStatus->LogName, "%s/PasoCobros_%d_%s.log", szDirLogs, pstConfig->iCodTipDocum,szSysDate);
		sprintf (pstStatus->ErrName, "%s/PasoCobros_%d_%s.err", szDirLogs, pstConfig->iCodTipDocum,szSysDate);
	}
	   
	sprintf(szComando,"/usr/bin/mkdir -p %s",szDirLogs);
	if (system (szComando))
	{
		printf( "\n\t***   Fallo mkdir de Directorio LOG : %s \n",szComando);
		return FALSE;
	}
	
	unlink (pstStatus->LogName);
	unlink (pstStatus->ErrName);
	
	if (!bOpenLog (pstStatus->LogName))
	{
		vDTrazasError (szExePasoC, "\n\t=> No se puede Abrir el fichero de Log\n",LOG01);
		return FALSE; 
	}
	if (!bOpenError (pstStatus->ErrName))
	{
		vDTrazasError (szExePasoC, "\n\t=> No se puede Abrir el fichero de Err\n",LOG01);
		return FALSE; 
	}

	printf("\n\t Directorio Log : %s\n",szDirLogs);
	strcpy (szExePasoC,"Paso Cobros");
	
	pstStatus->LogNivel = pstConfig->iNivelLog;
	
	vDTrazasLog  (szExePasoC,	"\n     *******************************************************************"
								"\n     *                   PASO A COBROS => %s                         *"
								"\n     *******************************************************************", LOG03, szVERSION );
								
	vDTrazasError(szExePasoC,	"\n     *******************************************************************"
								"\n     *                   PASO A COBROS => %s                         *"
								"\n     *******************************************************************", LOG03, szVERSION );
	
	if (pstConfig->bOptCodCicloFact)
	{                                                      
		if (!bfnValidaTrazaProc(pstConfig->lCodCicloFact, iPROC_PASOCOBROS, iIND_FACT_ENPROCESO))
		return FALSE; 
		if (!bfnOraCommit ())
		{
			iDError (szExePasoC,ERR000,vInsertarIncidencia, "CommitWork",szfnORAerror());
			return FALSE;
		}
		bfnSelectTrazaProc ( pstConfig->lCodCicloFact, iPROC_PASOCOBROS, &stTrazaProc);    
		bPrintTrazaProc(stTrazaProc);
		
		if (!bCargaConversion (pstConversion, &NUM_CONVERSION, szFechDesde,szFechHasta))
			return FALSE;
		
		if (!bfnInsFaRepPasocobros(pstConfig, pstConfig->szUsuario))
			return FALSE;
	}
	else /* NO CICLO */
	{
		/* RAO: obtiene paramteros de la cola de procesos */
		memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
		if (pstConfig->bOptUnico) 
		{
			strcpy( stIntQueueProc.szCodModGener , szhCodModGener);
		}
		else
		{
			strcpy( stIntQueueProc.szCodModGener , pstConfig->szCodModGener);
		}
		
		strcpy(stIntQueueProc.szCodAplic,"FAC");
		stIntQueueProc.lCodProceso = iPROCESO_INT_PASOCOBROS;
		if(!bfnGetIntQueueProc(&stIntQueueProc))
		{
			return FALSE;
		}
		
		if (pstConfig->bOptBatch)
		{
			if (!bfnInsFaRepPasocobros(pstConfig, pstConfig->szUsuario))
				return FALSE;
		}
		else  /*On Line o Unico */
		{
			ihCodTipDocum = pstConfig->iCodTipDocum;
			strcpy(szhCodModGener,pstConfig->szCodModGener);
	        
	        /* Inicio Requerimiento de Soporte - 41321_3 - 13.07.2007 */
			/*EXEC SQL
			SELECT NUM_PROCPASOCOB
			INTO   :lNumProcPasoCob
			FROM   FA_REPPASOCOBROS
			WHERE  COD_TIPDOCUM = :ihCodTipDocum
			AND    TO_CHAR( FEC_EFECTIVIDAD, :szhddmmyy ) = TO_CHAR(SYSDATE,:szhddmmyy)
			AND    NOM_USUARIO  = :szhPUNTUAL
			AND    COD_MODGENER = :szhCodModGener;
			   
			if (SQLCODE == SQLNOTFOUND)
			{*/
				if( !bfnInsFaRepPasocobros( pstConfig, "PUNTUAL" ) )
					return FALSE;
			/*}*/
			/* Fin Requerimiento de Soporte - 41321_3 - 13.07.2007 */
		}
	}
	return TRUE;
}/************************** Final bfnInitPasoCobros *************************/ 
/*****************************************************************************/
/*                       funcion : bfnInsFaRepPasocobros                     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnInsFaRepPasocobros (CONFIG *pstConfig, char* szUsuario)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	double dhSaldoDebe;
	double dhSaldoHaber;
    char   szhPUNTUAL [8];
/* EXEC SQL END DECLARE SECTION; */ 

	
    strcpy(szhPUNTUAL,"PUNTUAL");

    /* Inicio Requerimiento de Soporte - 41321_3 - 13.07.2007 */
    /* Se comenta insert a tabla FA_REPPASOCOBROS */
	/* Inicio Requerimiento de Soporte - 39289 - 27.04.2007 */
	/* EXEC SQL
	SELECT FA_SEQ_PROCPASOCOB.NEXTVAL
	INTO :lNumProcPasoCob
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select FA_SEQ_PROCPASOCOB.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )112;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lNumProcPasoCob;
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


	
	if( SQLCODE != SQLOK )	{
		iDError( szExePasoC, ERR000, vInsertarIncidencia, "Select Secuencia", szfnORAerror() );
		return FALSE; 
	}
		
	vDTrazasLog( szExePasoC, "\n\t\tSECUENCIA FA_SEQ_PROCPASOCOB => [%d].\n", LOG03, lNumProcPasoCob );
	
	/*EXEC SQL
	SELECT NVL( SUM( IMPORTE_DEBE ), :ihValor_cero )
	INTO   :dhSaldoDebe
	FROM   CO_CARTERA;
	
	if( SQLCODE != SQLOK )	{
		iDError( szExePasoC, ERR000, vInsertarIncidencia, "Select Cartera", szfnORAerror() );
		return FALSE; 
	}*/
	
	
	/*EXEC SQL
	SELECT NVL( SUM( IMPORTE_DEBE  ), :ihValor_cero ), 
	       NVL( SUM( IMPORTE_HABER ), :ihValor_cero ), 
	       FA_SEQ_PROCPASOCOB.NEXTVAL * Requerimiento de Soporte - 39289 - 27.04.2007 *
	INTO   :dhSaldoDebe    , 
	       :dhSaldoHaber   , 
	       :lNumProcPasoCob
	FROM   CO_CARTERA;

	if( SQLCODE != SQLOK )	{
		iDError( szExePasoC, ERR000, vInsertarIncidencia, "Select Cartera Saldos, FA_SEQ_PROCPASOCOB ", szfnORAerror() );
		return FALSE; 
	}*/
	/* Fin Requerimiento de Soporte - 39289 - 27.04.2007 */
	/* dhSaldoDebe = 0;
	 dhSaldoHaber= 0;*/
	/* Fin Requerimiento de Soporte - 41321 - 07.06.2007 */

	/*EXEC SQL
	INSERT  INTO FA_REPPASOCOBROS 	(
		     COD_TIPDOCUM,
		     FEC_EFECTIVIDAD,
		     NUM_PROCPASOCOB,
		     SALDO_DEBE,
		     SALDO_HABER,
		     NOM_USUARIO,
		     COD_MODGENER,
		     COD_CICLFACT 	)
	VALUES (:pstConfig->iCodTipDocum,
		     SYSDATE,
		     :lNumProcPasoCob,
		     :dhSaldoDebe,
		     :dhSaldoHaber,
		     DECODE( :szUsuario, :szhPUNTUAL, :szUsuario, USER ),
		     :pstConfig->szCodModGener,
		     :pstConfig->lCodCicloFact );

	if( SQLCODE != SQLOK )	{
		iDError( szExePasoC, ERR000, vInsertarIncidencia, "INSERT FA_REPPASOCOBROS.", szfnORAerror() );
		if( !bfnOraRollBack() )
		{
			iDError( szExePasoC, ERR000, vInsertarIncidencia, "RollBackWork", szfnORAerror() );
			return FALSE;
		}
		return FALSE; 
	}*/

	/* hacemos commit a todo los ultimos movimientos de la base de datos */
	/*if( !bfnOraCommit())	{
		iDError( szExePasoC, ERR000, vInsertarIncidencia, "GRABAR SECUENCIA FA_REPPASOCOBROS", szfnORAerror() );
		return FALSE;
	}*/
    /*Fin Requerimiento de Soporte - 41321_3 - 13.07.2007 */


	return TRUE;
}/************************** Final bfnInsFaRepPasocobros *************************/ 

/*****************************************************************************/
/*                           funcion : bfnExitPasoCobros                     */
/* -Funcion que cierra Logs, libera memoria, se desconecta de Oracle,...     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnExitPasoCobros (void)
{
	/* Desconexion Oracle */
	if (!bfnDisconnectORA(0))
	{
		iDError(szExePasoC,ERR000,vInsertarIncidencia,"Desconexion",szfnORAerror());
		return FALSE;
	}
	stStatus.OraConnected = FALSE;
	vDTrazasLog (szExePasoC,"\n\t\t*** Desconexion a Oracle ***\n",LOG04);
	
	/* Datos Fin de Tiempo */
	times (&tms);
	cpu_fin = clock();
	time (&real_fin);
	
	real = (real_fin - real_ini);
	cpu  = (float)cpu_fin/(float)CLOCKS_PER_SEC;
	
	vDTrazasLog( szExePasoC, "\n\t=> Tiempo de CPU : [%g]\n\t=> Tiempo Real   : [%g]", LOG03, cpu,real ); 
}/*************************** Final bfnExitPasoCobros ************************/

/*****************************************************************************/
/*                          funcion : ifnFactIntercalada                     */
/*****************************************************************************/
static int ifnFactIntercalada(DATOS_FACT *pstHistDocu)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhNumSecuRel           = pstHistDocu->lNumSecuRel  ;
    int  ihCodTipDocumRel       = pstHistDocu->iCodTipDocumRel  ;      
    long lhCodVendedorAgenteRel = pstHistDocu->lCodVendedorAgenteRel ;
    char szhLetraRel[2]         = "" ; /* EXEC SQL VAR szhLetraRel IS STRING (2); */ 

    int  ihCodCentrRel          = pstHistDocu->iCodCentrRel  ;      
    int  ihCuenta               = 0  ;
/* EXEC SQL END DECLARE SECTION; */ 

    
 	strcpy( szhLetraRel,        pstHistDocu->szLetraRel);

    /* EXEC SQL
    SELECT COUNT(*)
    INTO   :ihCuenta
    FROM   FA_HISTDOCU
    WHERE  NUM_SECUENCI         = :lhNumSecuRel
    AND    COD_TIPDOCUM         = :ihCodTipDocumRel
    AND    COD_VENDEDOR_AGENTE  = :lhCodVendedorAgenteRel
    AND    LETRA                = :szhLetraRel
    AND    COD_CENTREMI         = :ihCodCentrRel
    AND    IND_ANULADA          = :ihValor_cero; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from FA_HISTDOCU where (((((NU\
M_SECUENCI=:b1 and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3) and LETRA=:b\
4) and COD_CENTREMI=:b5) and IND_ANULADA=:b6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )131;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCuenta;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuRel;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumRel;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodVendedorAgenteRel;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhLetraRel;
    sqlstm.sqhstl[4] = (unsigned long )2;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrRel;
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



    if (SQLCODE)   {
        iDError (szExePasoC,ERR000,vInsertarIncidencia, "Select Count FA_HISTDOCU",szfnORAerror());
        return -1; 
    }
    
    if ( ihCuenta != 0 )  {
        /* La encontró, (no esta anulada) : por lo tanto la pasa a cobros la nota de credito */
        return  1;
    }
    else /* no la encontro en la fa_histdocu la busca en fa_factdocu_nociclo */
    {
        /* EXEC SQL
        SELECT COUNT(*)
        INTO   :ihCuenta
        FROM   FA_FACTDOCU_NOCICLO
        WHERE  NUM_SECUENCI         = :lhNumSecuRel
        AND    COD_TIPDOCUM         = :ihCodTipDocumRel
        AND    COD_VENDEDOR_AGENTE  = :lhCodVendedorAgenteRel
        AND    LETRA                = :szhLetraRel
        AND    COD_CENTREMI         = :ihCodCentrRel
        AND    IND_ANULADA          = :ihValor_cero
        AND    IND_PASOCOBRO        = :ihValor_uno ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(*)  into :b0  from FA_FACTDOCU_NOCICLO w\
here ((((((NUM_SECUENCI=:b1 and COD_TIPDOCUM=:b2) and COD_VENDEDOR_AGENTE=:b3)\
 and LETRA=:b4) and COD_CENTREMI=:b5) and IND_ANULADA=:b6) and IND_PASOCOBRO=:\
b7)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )174;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCuenta;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuRel;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumRel;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodVendedorAgenteRel;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhLetraRel;
        sqlstm.sqhstl[4] = (unsigned long )2;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrRel;
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
        sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_uno;
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


        if (SQLCODE)   {
            iDError (szExePasoC,ERR000,vInsertarIncidencia, "Select Count FA_FACTDOCU_NOCICLO",szfnORAerror());
            return -1; 
        }
        
        if ( ihCuenta != 0 )  {
            /* La encontró, (no esta anulada)(esta pasada a cobros) : por lo tanto la pasa a cobros la nota de credito */
            return  1;
        }
        else
        {
            /* No la encontró en ninguna de las 2 tablas : no pasa a cobros la nota de credito y toma la siguiente */
            return  0;
        }
    }
    
}/********************* fin ifnFactIntercalada *************************************/

/*****************************************************************************/
/*                          funcion : bfnPasoCobros                          */
/*****************************************************************************/
static BOOL bfnPasoCobros( CONFIG stConfig, STATUS *pstStatus )
{
int	     iRes			= 0;	/* Resultado de la Funcion ifnFetchHistDocu */
int	     i				= 0;
int	     j				= 0;
long     lCantConc      = 0;
BOOL	 bError			= FALSE;
BOOL	 bBreak			= FALSE;
int	     iCodAbono		= 0;
long	 lNumDocPasoCob	= 0;
double   dTotPasoCob	= 0;
int	     ihCodEstaDocSal;
int	     ihCodModVenta;
long	 lhNumProceso;
BOOL	 bConcepNegativos;

COFACTCOBR	stFactCobr;
DATOS_FACT	stHistDocu;
/*HISTCONCP   stHistConcP; Soporte RyC - Ticket 40533 - 04.06.2007 */
ACUMABO		stAcumAbo;
DATCON		stCobros;

DATDOC		stDatDoc;
DATPAG		stDatPag;
DATCON		stConc;

ACUMABO	     stAcumCon; /* Requerimiento de Soporte - 84622 - 13.04.2009 MQG */

/* Requerimiento de Soporte - 41321 - 07.06.2007 */
HISTCONCAUX    stHistConc;
HISTCONCPAUX   stHistConcP;

int  iAux                       ;
long xx; 

double lTotalFactura ; /*XO-200508310542 Soporte RyC capc 05-09-2005*/

long lNumCuotas                 ; 
/*long lValorCuota                ; */
double lValorCuota              ; /*XO-200508310542 Soporte RyC capc 05-09-2005*/
ldiv_t stDiv                    ;
	
/* EXEC SQL BEGIN DECLARE SECTION  ; */ 

	long	lhCodCliente;
	char	szhFechaCuota[9];
	char	szhFechaCuotaUno[9];
	char	szhSgteCuota [9];
	int	 	ihIndCuotas = 0;
	int	 	ihMoroso = 0;
	char	szhFecVencimiento[9]= "" ;	/* EXEC SQL VAR szhFecVencimiento IS STRING (9); */ 

	short	shFecVenc    	;
	char	szhNumIdent[21] 	= "" ;	/* EXEC SQL VAR szhNumIdent IS STRING(21); */ 

	char	szhCodTipIdent[3] 	= "" ;	/* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

	char	szhNumIdent_a[21] 	= "" ;	/* EXEC SQL VAR szhNumIdent_a IS STRING(21); */ 

	char	szhCodTipIdent_a[3] = "" ;	/* EXEC SQL VAR szhCodTipIdent_a IS STRING(3); */ 

	double 	dhSaldoVenc;
	double 	dhSaldoNoVenc;
	int	 	ihIndPagado 		= 0;
	int	 	ihCodCauPago 		= 0;
	char	szhDesPago[41] 		= "" ;	/* EXEC SQL VAR szhDesPago IS STRING(41); */ 

	long	lhNumVenta;
	double 	dhImpAbono;
	double  dhImpAbonoAcumulado; /* RA-200601260641 27.01.2006 Soporte RyC */
	double  dhImpAbono_aux     ; /* RA-200601260641 27.01.2006 Soporte RyC */
	double  dhImpVenta		   ; /* RA-200601260641 27.01.2006 Soporte RyC */
	double  lTotalConcepto	   ; /* RA-200601260641 27.01.2006 Soporte RyC */
	char   	szhCO      [3];
	char   	szhENTIDAD[20];
	char   	szhINDTOTFACTURA    [17];   /* EXEC SQL VAR szhINDTOTFACTURA IS STRING(17); */ 
     /* RA-200601130570 19.01.2006 Soporte RyC */
	char   	szhDIAS_VCTO_FACTURA[18];   /* EXEC SQL VAR szhDIAS_VCTO_FACTURA IS STRING(18); */ 
 /* Soporte RyC MCO-200606060001 17-07-2006 capc */
	char    szD_Vcto_Fact       [10];   /* EXEC SQL VAR szD_Vcto_Fact IS STRING(10); */ 
        /* Soporte RyC MCO-200606060001 17-07-2006 capc */
	
/* EXEC SQL END DECLARE SECTION    ; */ 

	
	vDTrazasLog (szExePasoC,"\n\t\t* Paso A Cobros\n",LOG03);
   	strcpy(szhCO,"CO");
   	strcpy(szhENTIDAD,"ENTIDAD_GESTION_COB");
   	strcpy(szhINDTOTFACTURA,"IND_TOTALFACTURA");      /* RA-200601130570 19.01.2006 Soporte RyC */
   	strcpy(szhDIAS_VCTO_FACTURA,"DIAS_VCTO_FACTURA"); /* Soporte RyC MCO-200606060001 17-07-2006 capc */
	dhImpAbonoAcumulado = 0; /* RA-200601260641 27.01.2006 Soporte RyC */
	dhImpAbono_aux      = 0; /* RA-200601260641 27.01.2006 Soporte RyC */ 
	dhImpVenta			= 0; /* RA-200601260641 27.01.2006 Soporte RyC */

   	/* 18-05-2004 XM-200405180055 */
   	/* Obtiene ENTIDAD DE GESTION DE COBRANZA desde la tabla GED_PARAMETROS */
   	/* EXEC SQL
   	SELECT VAL_PARAMETRO
   	INTO   :szEntGestion
   	FROM   GED_PARAMETROS
   	WHERE  COD_MODULO    = :szhCO
   	AND    NOM_PARAMETRO = :szhENTIDAD; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(COD_MODULO=:b1 and NOM_PARAMETRO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )221;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szEntGestion;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCO;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhENTIDAD;
    sqlstm.sqhstl[2] = (unsigned long )20;
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


   
   	if( SQLCODE != SQLOK ) {   
   		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Select GED_PARAMETROS" );   
   		return FALSE;
   	}
   	/* fin 18-05-2004 XM-200405180055 */


   	/* Inicio RA-200601130570 19.01.2006 Soporte RyC */
   	/* Obtiene Indicador Total Factura desde la tabla GED_PARAMETROS */
   	/* EXEC SQL
   	SELECT VAL_PARAMETRO
   	INTO   :szInd_TotalFactura
   	FROM   GED_PARAMETROS
   	WHERE  COD_MODULO    = :szhCO
   	AND    NOM_PARAMETRO = :szhINDTOTFACTURA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(COD_MODULO=:b1 and NOM_PARAMETRO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )248;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szInd_TotalFactura;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCO;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhINDTOTFACTURA;
    sqlstm.sqhstl[2] = (unsigned long )17;
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


   
   	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
   		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Select GED_PARAMETROS (2)" );   
   		return FALSE;
   	} else {   /*if( SQLCODE == SQLNOTFOUND )*/
	    strcpy( szInd_TotalFactura, "N" );    /* Valor por defecto */
   	}

   	vDTrazasLog( szExePasoC, "\n szInd_TotalFactura [%s].", LOG03, szInd_TotalFactura);
   	/*Fin RA-200601130570 19.01.2006 Soporte RyC */

   	/* Inicio Soporte RyC MCO-200606060001 17-07-2006 capc*/
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
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(COD_MODULO='GA' and NOM_PARAMETRO=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )275;
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


   
   	if( SQLCODE != SQLOK ) {   
   		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Select GED_PARAMETROS szhDIAS_VCTO_FACTURA" );   
   		return FALSE;
   	}
   	/* fin Soporte RyC MCO-200606060001 17-07-2006 capc*/


   	/* Inicio P-MIX-09003 */
   	/* el lucho pidio este cambio..ta maire!! */
   	/* EXEC SQL
   	SELECT VAL_NUMERICO
   	  INTO :ihNotaAbono
   	  FROM FAD_PARAMETROS
   	 WHERE COD_PARAMETRO = 676; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_NUMERICO into :b0  from FAD_PARAMETROS where C\
OD_PARAMETRO=676";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )298;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNotaAbono;
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
}


   
   	if( SQLCODE != SQLOK ) {   
   		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Select FAD_PARAMETROS Nota Abono" );   
   		return FALSE;
   	}
   	/* fin P-MIX-09003*/

   	if( !bfnLimpiaEstructura() )
		return FALSE;

    /* Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
    if (!bfnDBVerificaConceptos(stConfig)) return FALSE;

   	memset (&stFactCobr ,0,sizeof(COFACTCOBR)) ;

   	if (!bfnDBObtConCreFA (&iCodAbono))	{   
		iDError (szExePasoC,ERR043,vInsertarIncidencia,0,"bfnDBObtConCre2");
		return  FALSE;  }

   	if (!bfnDBCargaFactCobr (&stFactCobr))  return FALSE;

   	if (ifnDBOpenHistDocu (stConfig)) return FALSE;

   	if( !bfnDescargaDoctosInter( stConfig ) )
   	{
		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Descarga de Documentos a intercalar" );
		return FALSE;
   	}


	for( xx = 0; xx < glTotalDoctosInter; xx++ )
	{
		vDTrazasLog( szExePasoC, "\nPROCESANDO REGISTRO => [%d] de un TOTAL DE [%d] Documentos.", LOG03, xx + 1, glTotalDoctosInter);

      	bError = FALSE;
      	bConcepNegativos = FALSE;
      	memset( &stHistDocu, 0, sizeof( DATOS_FACT ) );

	   	if( !bfnCargaEstructuraWork( xx, &stHistDocu ) )  {
			iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Cargar estructura de Trabajo" );
			return FALSE;
		}
		
        /* memset( &stHistConcP, 0 ,sizeof( HISTCONCP ) );  Requerimiento de Soporte - 41321 - 07.06.2007 */
     	memset( &stHistConcP, 0 ,sizeof( HISTCONCPAUX ) );
      	memset( &stAcumAbo  , 0 ,sizeof( ACUMABO ) );
      	memset( &stConc     , 0 ,sizeof( DATCON ) );
      	memset( &stDatDoc   , 0 ,sizeof( DATDOC ) );
      	memset( &stDatPag   , 0 ,sizeof( DATPAG ) );

      	/* Inicio Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
      	/* Estructura para acumular totales por conceptos, para un posterior ajuste */
      	memset( &stAcumCon , 0 ,sizeof( ACUMABO ) );
        /* Fin Requerimiento de Soporte - 84622 - 13.04.2009 MQG */

	   	if( !bfnGetDatosCliente( stHistDocu.lCodCliente ) )  {
			vDTrazasError( szExePasoC, "Error al recuperar datos del CLIENTE.", LOG01 );
			giEstadoDocumento = iNOEXISTECLIE;
			bError = TRUE;
		}
	   	else 
		{
			/* Ve si la modalidad de venta se intercala pagada o no jlr_04.01.01 */
			/* EXEC SQL
			SELECT  NVL(IND_PAGADO,:ihValor_cero), V.COD_CAUPAGO, DES_CAUPAGO
			INTO    :ihIndPagado, :ihCodCauPago, :szhDesPago
			FROM    GE_MODVENTA V, CO_CAUSASPAGO P
			WHERE   V.COD_MODVENTA= :stHistDocu.iCodModVenta
			AND	  	V.COD_CAUPAGO = P.COD_CAUPAGO; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(IND_PAGADO,:b0) ,V.COD_CAUPAGO ,DES_CAUPAGO int\
o :b1,:b2,:b3  from GE_MODVENTA V ,CO_CAUSASPAGO P where (V.COD_MODVENTA=:b4 a\
nd V.COD_CAUPAGO=P.COD_CAUPAGO)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )317;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&ihIndPagado;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCauPago;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhDesPago;
   sqlstm.sqhstl[3] = (unsigned long )41;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&(stHistDocu.iCodModVenta);
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


		
			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
			{
				iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "Select Ge_ModVenta" );
				bError = TRUE;
			}
			else 
			{
				if( SQLCODE == SQLNOTFOUND )
				{
					ihIndPagado  = 0;
					ihCodCauPago = stDatosGener.iCauPagoRegalo;
					strcpy( szhDesPago, "Pago Regalo" );
				}

            	vDTrazasLog (szExePasoC,"\n\t\t*** ihIndPagado             : [%d] \n", LOG06, ihIndPagado);
            	vDTrazasLog (szExePasoC,"\n\t\t*** stHistDocu.iIndSuperTel : [%d] \n", LOG06, stHistDocu.iIndSuperTel);
            	vDTrazasLog (szExePasoC,"\n\t\t*** stHistDocu.iIndFactur   : [%d] \n", LOG06, stHistDocu.iIndFactur);

				if( (ihIndPagado == 1 || stHistDocu.iIndSuperTel == 1 || stHistDocu.iIndFactur == 0 ) && stHistDocu.dTotFactura > 0.0)
				{
					stDatDoc.iCodTipDocum = (stHistDocu.iIndFactur)?stHistDocu.iCodTipDocum:stDatosGener.iDocStaff;
					stDatDoc.lCodAgente   = stDatosGener.lAgenteInterno;
					strcpy (stDatDoc.szLetra, stDatosGener.szLetraCobros);
					strcpy (stDatPag.szNomUsu, stConfig.szUsuario);
					stDatPag.iCodTipDocum = stDatosGener.iDocStaff; 
					stDatPag.iCodSisPago  = stDatosGener.iSisPagoRegalo;
					stDatPag.iCodCauPago  = (stHistDocu.iIndSuperTel == 1)?iCAUPAGOSUPERTEL:ihCodCauPago;
					stDatPag.iCodOriPago  = stDatosGener.iOriPagoRegalo;
					stDatPag.iCodForPago  = 0; 
					strcpy (stDatDoc.szDesPago,(stHistDocu.iIndFactur)?szhDesPago:"Pago Staff");
				}
	
				stConc.iCodTipDocum = stHistDocu.iCodTipDocum;
				stConc.lCodAgente   = stHistDocu.lCodVendedorAgente;
				stConc.lNumSecuenci = stHistDocu.lNumSecuenci;
				strcpy (stConc.szLetra, stHistDocu.szLetra);
				stConc.iCodCentremi = stHistDocu.iCodCentrEmi;
				
				strncpy (stConc.szFecVencimie   , stHistDocu.szFecVencimie, 8);
				strncpy (stConc.szFecEfectividad, stHistDocu.szFecEmision , 8);
				strncpy (stConc.szFecCaducida   , stHistDocu.szFecCaducida, 8);
				strncpy (stConc.szFecAntiguedad , szSysDate               , 8);
				strncpy (stConc.szFecPago       , szSysDate               , 8);
				stConc.szFecVencimie    [8] = '\0';
				stConc.szFecEfectividad [8] = '\0';
				stConc.szFecCaducida    [8] = '\0';
				stConc.szFecAntiguedad  [8] = '\0';
				stConc.szFecPago        [8] = '\0';
	
                /* Inicio Requerimiento de Soporte - 84622 - 13.04.2009 MQG */	
				/* Carga los Conceptos de una Factura y Acumula por Abonado-Producto*/
				/*if (!bfnDBCargaHistConc( stHistDocu.szIndOrdenTotal, &stHistConcP, &stAcumAbo, &stFactCobr, &bConcepNegativos ) )*/
				/*{*/
					/* return FALSE; */
				/*	continue;			*//* sigue con el proximo documento */
				/*}*/
	
		    	if (!bfnDBCargaAcumulaConceptos( stHistDocu, &stAcumAbo, &stFactCobr, &bConcepNegativos, &stAcumCon ) ) {
					continue;
		    	} /* end if (!bfnDBCargaAcumulaConceptos) */
                /* Fin Requerimiento de Soporte - 84622 - 13.04.2009 MQG */	
	
				if( bConcepNegativos )
				{
					bError = TRUE;
					giEstadoDocumento = iDOCTOCONCEPNEG;
				} 
				else
				{            
					if( (ihIndPagado == 1 || stHistDocu.iIndSuperTel == 1 || stHistDocu.iIndFactur == 0 ) && stHistDocu.dTotFactura > 0.0)
					{
						stDatPag.lCodCliente  = stHistDocu.lCodCliente;
						stDatPag.dImpPago     = stHistDocu.dTotFactura;
						stDatDoc.iCodCentrEmi = stHistDocu.iCodCentrEmi;
						strcpy(stDatPag.szNomUsu, stConfig.szUsuario);
					
						if( !bfnDBInsertPagos (&stDatDoc, &stDatPag, stDatosGener.szOficinaPago) )
						{
							/* return FALSE; */
							bError = TRUE;		/* error de hara ROLLBACK */
						}
					} /* end if( (ihIndPagado == 1  .... */
				} /* end if( bConcepNegativos ) */
				
	        	bBreak = FALSE;
			
				vDTrazasLog( szExePasoC, "\n  stAcumAbo.iNumReg => [%d]", LOG03, stAcumAbo.iNumReg );
				dhImpAbonoAcumulado = 0; /* RA-200603160926 16.03.2006 Soporte RyC */
				lCantConc = 1;

				for( j = 0; ( j < stAcumAbo.iNumReg && !bError && !bBreak ); j++ )
				{
			   		for( i = 0; ( i < stAcumAbo.pAboCobr[j].iNumConceptos && !bError && !bBreak ); i++ )
			   		{				    					    	
						stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr=fnCnvDouble(stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, pstParamGener.iNumDecimal);/* 28-12-2004 Homolog. TM-872 GAC*/
				    	if (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr != 0.0)
				    	{
            
				    		if (( ihIndPagado == 1 || stHistDocu.iIndSuperTel == 1 || stHistDocu.iIndFactur == 0 )&& stHistDocu.dTotFactura > 0.0)
				        	{
				        		if (stHistDocu.iIndSuperTel == 1)
				            	{
				                	stDatDoc.iCodTipDocum = stHistDocu.iCodTipDocum      ;
				                 	stDatDoc.lCodAgente   = stHistDocu.lCodVendedorAgente;
				                 	strcpy (stDatDoc.szLetra , stHistDocu.szLetra) ;
				            	}
				
				            	stConc.lNumFolio     = stHistDocu.lNumFolio;
				            	strcpy(stConc.szFolioCTC, stHistDocu.szNumCTC) ;
				            	stConc.dImporteHaber = fnCnvDouble (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, 4);
				            	stConc.dImporteDebe  = fnCnvDouble (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, 4);
				
				            	stConc.iCodConcepto = stAcumAbo.pAboCobr[j].pConcCobr[i].iCodConcCobr;
				            	stConc.iCodProducto = stAcumAbo.pAboCobr[j].iCodProducto             ;
				            	stConc.lNumAbonado  = stAcumAbo.pAboCobr[j].lNumAbonado              ;
				            	stConc.lNumTransa   = stHistDocu.lNumTransaccion   ;
				            	stConc.lNumVenta    = stHistDocu.lNumVenta         ;

				            	strcpy(stConc.szPrefPlaza, stHistDocu.szPrefPlaza);
				            	strcpy(stConc.szCodOperadoraScl,stHistDocu.szCodOperadoraScl);
				            	strcpy(stConc.szCodPlaza,  stHistDocu.szCodPlaza);
				
				            	if( !bfnPagado (&stDatDoc, &stDatPag, &stConc ) )
				            	{
				            		bError = TRUE;
				             		break;
				             		/* return FALSE; */
								}
					  		} 
			            	else
			            	{			            	   	
								memset (&stCobros,0,sizeof (DATCON));
								if( !bfnGetCobros(  &stCobros, iCodAbono, stAcumAbo.pAboCobr[j], stAcumAbo.pAboCobr[j].pConcCobr[i], stHistDocu ) )
					        	{
					        		bError = TRUE;
					            	break;
					            	/* return FALSE; */
								}
					
								if ( stHistDocu.dTotFactura > 0.0)  
								{
					        		lhCodCliente  = stHistDocu.lCodCliente;
									ihCodModVenta = stHistDocu.iCodModVenta;
					            	lhNumVenta    = stHistDocu.lNumVenta;
					                 
					            	if( stHistDocu.iNumCuotas <= 0 )  {                              
					               		stCobros.lNumCuota = 0;
					               		stCobros.iSecCuota = 0;
					                  
							    		/* si es nota de credito --- o nota de abono..este cambio lo pidieron los maratrucha de GUA.. */
							    		if(( stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre ) || (stHistDocu.iCodTipMovimie == ihNotaAbono))
										{
									   		/* se comprueba si la NC queda como abono o sera devolucion de dinero */
											stCobros.iIndFacturado = ifnTipDevolucionCliente( &stHistDocu );
										}
							    		else
										{
											stCobros.iIndFacturado = 1;
										} /* end if( stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre )*/
											
					               		if( !bfnDBIntCartera( &stCobros, stHistDocu.lCodCliente ) )
					               		{
					                		iDError (szExePasoC,ERR043, vInsertarIncidencia, 0,"bfnDBIntCartera");
					                  		bError = TRUE;
					                  		break;
					               		}
					            	} 
									else if ((stHistDocu.iCodTipMovimie != stDatosGener.iCodNotaCre ) && (stHistDocu.iCodTipMovimie != ihNotaAbono) )
				                	{
				               		/* stHistDocu.iNumCuotas > 0, 16-05-2000 : do the new alternative piece of ... code */
				                  	stCobros.lNumCuota = 1;
				                  	stCobros.iSecCuota = 1;
				                  	stCobros.iIndFacturado = 0;
										   dhImpAbono     = 0; /* RA-200601260641 27.01.2006 Soporte RyC */
										   lTotalConcepto = 0; /* RA-200601260641 27.01.2006 Soporte RyC */
										   dhImpAbono_aux = 0; /* RA-200601260641 27.01.2006 Soporte RyC */
                                 
										   /* Inicio RA-200601260641 27.01.2006 Soporte RyC */
										   /*EXEC SQL 	 Determina si la Venta tiene Abono jlr_04.04.01 																	
										   SELECT IMP_ABONO
										   INTO   :dhImpAbono
										   FROM   GA_VENTAS
										   WHERE  NUM_VENTA = :lhNumVenta
										   AND    IND_ABONO > :ihValor_cero
										   AND    IMP_ABONO > :ihValor_cero;*/

								   		if (strcmp(szInd_TotalFactura, "N") == 0) {	
								   			lTotalConcepto = (fnCnvDouble (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, pstParamGener.iNumDecimal));
					               		} else { 
					               			lTotalConcepto = (stHistDocu.dTotFactura);
                                   		} 

										vDTrazasLog( szExePasoC, "\nlCantConc - lTotalConcCartera => [%d]- [%d]", LOG03, lCantConc,lTotalConcCartera );
										if (lCantConc == lTotalConcCartera) {
										/* if ((i == (stAcumAbo.pAboCobr[j].iNumConceptos -1 )) && (j == stAcumAbo.iNumReg - 1)) {*/
										/*if (i == (stAcumAbo.pAboCobr[j].iNumConceptos -1 )) { RA-200602130762 07.03.2006 Soporte RyC */
										/* Solo para cuando quede el ultimo concepto */

								   			vDTrazasLog( szExePasoC, "\nCantidad de Abonado - Conceptos(2)  => [%d]- [%d]", LOG03, j,i );

											/* EXEC SQL 	
											SELECT IMP_ABONO, IMP_VENTA
											INTO   :dhImpAbono_aux, :dhImpVenta
											FROM   GA_VENTAS
											WHERE  NUM_VENTA = :lhNumVenta
											AND    IND_ABONO > :ihValor_cero
											AND    IMP_ABONO > :ihValor_cero; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 8;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "select IMP_ABONO ,IMP_VENTA into :b0,:b1  from GA_\
VENTAS where ((NUM_VENTA=:b2 and IND_ABONO>:b3) and IMP_ABONO>:b3)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )352;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqhstv[0] = (unsigned char  *)&dhImpAbono_aux;
           sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[0] = (         int  )0;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)&dhImpVenta;
           sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[1] = (         int  )0;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&lhNumVenta;
           sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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


					
				                  			if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
					               			{
				                  				iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes,"Select Monto Abono Ga_Venta");
						               			bError = TRUE;
						               			break;
					               			}

					               			if (SQLCODE == SQLNOTFOUND)	dhImpAbono = 0;

											dhImpAbono = dhImpAbono_aux  - dhImpAbonoAcumulado; 
										}
										else 
										{
								   			vDTrazasLog( szExePasoC, "\nCantidad de Abonado - Conceptos(1)  => [%d] - [%d]", LOG03, j, i );
								   			vDTrazasLog( szExePasoC, "\nstAcumAbo.pAboCobr[j].iNumConceptos => [%d]", LOG03,stAcumAbo.pAboCobr[j].iNumConceptos );

											/* EXEC SQL 	
											SELECT (:lTotalConcepto - ROUND((:lTotalConcepto- (:lTotalConcepto*(IMP_ABONO/IMP_VENTA))), 0))
											INTO   :dhImpAbono
											FROM   GA_VENTAS
											WHERE  NUM_VENTA = :lhNumVenta
											AND    IND_ABONO > :ihValor_cero
											AND    IMP_ABONO > :ihValor_cero; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 8;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "select (:b0-ROUND((:b0-(:b0* (IMP_ABONO/IMP_VENTA)\
)),0)) into :b3  from GA_VENTAS where ((NUM_VENTA=:b4 and IND_ABONO>:b5) and I\
MP_ABONO>:b5)";
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )387;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqhstv[0] = (unsigned char  *)&lTotalConcepto;
           sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[0] = (         int  )0;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)&lTotalConcepto;
           sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[1] = (         int  )0;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&lTotalConcepto;
           sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[2] = (         int  )0;
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqinds[2] = (         int  )0;
           sqlstm.sqharm[2] = (unsigned long )0;
           sqlstm.sqadto[2] = (unsigned short )0;
           sqlstm.sqtdso[2] = (unsigned short )0;
           sqlstm.sqhstv[3] = (unsigned char  *)&dhImpAbono;
           sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[3] = (         int  )0;
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqinds[3] = (         int  )0;
           sqlstm.sqharm[3] = (unsigned long )0;
           sqlstm.sqadto[3] = (unsigned short )0;
           sqlstm.sqtdso[3] = (unsigned short )0;
           sqlstm.sqhstv[4] = (unsigned char  *)&lhNumVenta;
           sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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


					
				                  			if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
					               			{
				                  				iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes,"Select Monto Abono Ga_Venta");
						               			bError = TRUE;
						               			break;
					               			}

					               			if (SQLCODE == SQLNOTFOUND)	dhImpAbono = 0;
					               
											dhImpAbonoAcumulado = dhImpAbonoAcumulado + dhImpAbono; 
											lCantConc = lCantConc + 1;
										}
										/* Fin RA-200601260641 27.01.2006 Soporte RyC */

										/*Inicio RA-200601260641 27.01.2006 Soporte RyC */
								   		/*Inicio RA-200601130570 19.01.2006 Soporte RyC */
					               		/*lTotalFactura = (long) (stHistDocu.dTotFactura - dhImpAbono) / 1;*/ /* Total de la Factura */                                      
					               		/*lTotalFactura = (stHistDocu.dTotFactura - dhImpAbono) / 1; */ /* Total de la Factura */
								   		/*lTotalFactura = (fnCnvDouble (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, pstParamGener.iNumDecimal) - dhImpAbono) / 1;*/

								   		/*if (strcmp(szInd_TotalFactura, "N") == 0) {	
								   			lTotalFactura = (fnCnvDouble (stAcumAbo.pAboCobr[j].pConcCobr[i].dImpConcCobr, pstParamGener.iNumDecimal)- dhImpAbono) / 1;
					               		} else { 
					               			lTotalFactura = (stHistDocu.dTotFactura - dhImpAbono) / 1;  
                                   		} */

										lTotalFactura = lTotalConcepto - dhImpAbono;

								   		/* Fin RA-200601130570 19.01.2006 Soporte RyC */
										/* Fin RA-200601260641 27.01.2006 Soporte RyC */

					               		/*RA-200601050512 07-01-2006 Soporte RyC capc */
								   		vDTrazasLog( szExePasoC, "\nTotal Factura (Concepto)=> [%f] ", LOG03, lTotalFactura );
								   		vDTrazasLog( szExePasoC, "\nTotal Abono Prorroteado => [%f] ", LOG03, dhImpAbono );
								   		vDTrazasLog( szExePasoC, "\nTotal Abono Acumulado   => [%f] ", LOG03, dhImpAbonoAcumulado );
								   		
														                     				                        				                      				                        
					               		lNumCuotas    = (long) stHistDocu.iNumCuotas;    /* Total de cuotas */ 
	
										if (stHistDocu.dTotFactura <= 0) /* CO-200605120125 Soporte RyC 03.07.2006 */
					               		{
			                            	vDTrazasLog( szExePasoC, "\nTotal Facturado es igual a cero \n", LOG03 );
			                            	giEstadoDocumento = iTOTALFACTURA0;
			                            	bError = TRUE;
			                            	break;
					               		}
	
					               		if (lTotalFactura > 0)  /* CO-200605120125 Soporte RyC 03.07.2006 */
					               		{
								   			vDTrazasLog( szExePasoC, "\nTotal Factura => [%f] Se generaran [%ld] Cuotas.", LOG03, lTotalFactura, lNumCuotas );
	
					               			if ( lNumCuotas ) /* Si cuotas es != 0 */
					               			{
						                		stDiv = ldiv(lTotalFactura,lNumCuotas); /* divide para obtener valor de cada cuota */
					               			} 
											else
					               			{
					               				stDiv.quot = lTotalFactura;
					               			}

											/* Soporte RyC MCO-200606060001 17-07-2006 capc*/
											/*SELECT TO_CHAR( MIN(F.FEC_EMISION + TO_NUMBER(:szD_Vcto_Fact)), 'YYYYMMDD' )*/
					               			/* EXEC SQL 
					               			SELECT TO_CHAR( MIN(F.FEC_EMISION), 'YYYYMMDD' )
					               			INTO   :szhFechaCuotaUno 
					               			FROM   FA_CICLFACT F,GE_CLIENTES G
					               			WHERE  G.COD_CLIENTE    = :lhCodCliente
					               			AND    F.COD_CICLO      = G.COD_CICLO
					               			AND    F.IND_FACTURACION=:ihValor_cero; */ 

{
                       struct sqlexd sqlstm;
                       sqlstm.sqlvsn = 12;
                       sqlstm.arrsiz = 8;
                       sqlstm.sqladtp = &sqladt;
                       sqlstm.sqltdsp = &sqltds;
                       sqlstm.stmt = "select TO_CHAR(min(F.FEC_EMISION),'YYY\
YMMDD') into :b0  from FA_CICLFACT F ,GE_CLIENTES G where ((G.COD_CLIENTE=:b1 \
and F.COD_CICLO=G.COD_CICLO) and F.IND_FACTURACION=:b2)";
                       sqlstm.iters = (unsigned int  )1;
                       sqlstm.offset = (unsigned int  )430;
                       sqlstm.selerr = (unsigned short)1;
                       sqlstm.cud = sqlcud0;
                       sqlstm.sqlest = (unsigned char  *)&sqlca;
                       sqlstm.sqlety = (unsigned short)256;
                       sqlstm.occurs = (unsigned int  )0;
                       sqlstm.sqhstv[0] = (unsigned char  *)szhFechaCuotaUno;
                       sqlstm.sqhstl[0] = (unsigned long )9;
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
                       sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
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


					                  	
					               			if (SQLCODE != SQLOK)
					               			{
						               			iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Fecha Cuota 1");
						              			bError = TRUE;
						              			break;
					               			}
											strcpy(szhFechaCuota,szhFechaCuotaUno); 
					
					               			for( iAux = 1; iAux <= lNumCuotas; iAux++ )
					               			{
					               				if (iAux < lNumCuotas) /* valor de la i-esima cuota */
					                  			{
					                  				lValorCuota = stDiv.quot; 
					                  			}
					                  			else if (iAux == lNumCuotas) /* valor de la ultima cuota */
					                  			{
					                    			lValorCuota = ( lTotalFactura - ( ( lNumCuotas - 1 ) * stDiv.quot ) );
					                  			}
					
					                  			/*stCobros.dImporteDebe = (double) lValorCuota;*/
					                  			stCobros.dImporteDebe 	= lValorCuota; /*XO-200508310542 Soporte RyC capc 05-09-2005*/
					                  			stCobros.dImporteHaber 	= 0; 
					                  			strcpy( stCobros.szFecVencimie, szhFechaCuota );
					                  			stCobros.lNumCuota = lNumCuotas;
					                  			stCobros.iSecCuota = iAux;
					                  			/*stCobros.iIndFacturado = 0;*/
					                      
												vDTrazasLog( szExePasoC, "CUOTA => [%d] FEC.VENC => [%s]  MONTO => [%f]",LOG03, stCobros.iSecCuota, stCobros.szFecVencimie, lValorCuota );
	
					                  			/*RA-200512130309 14-12-2005 Soporte RyC capc */
					                  			/*if (stAcumAbo.iNumReg > 1 ) * tiene mas de un abonado *
					                  				{
					                          			stCobros.lNumAbonado = 0; * se genera con abonado 0 *
					                          			bBreak = TRUE;
					                  				}*/
                                           
												/* Soporte RA-200603160926 - 16.03.2006 */
                                            	if( lValorCuota > 0) {
					                  				if( !bfnDBIntCartera( &stCobros, stHistDocu.lCodCliente ) )
					                  				{
					                    				iDError (szExePasoC,ERR043, vInsertarIncidencia, 0,"bfnDBIntCartera");
					                        			bError = TRUE;
					                       				break;
					                  				}
					                      		}
												/* Soporte RA-200603160926 - 16.03.2006 */

					                  			/* define la fecha para la sgte cuota un mes despues de la fecha de la cuota anterior */
					                  			
					                  			/* Inicio Requerimiento de Soporte - 39289 - 27.04.2007 */
					                  			/* Soporte RyC MCO-200606060001 17-07-2006 capc*/
					                  			/*SELECT TO_CHAR( ADD_MONTHS ( TO_DATE(:szhFechaCuota,'YYYYMMDD'), 1 ),'YYYYMMDD' )*/
					                  			/*EXEC SQL 
					                  			SELECT TO_CHAR( ADD_MONTHS ( TO_DATE(:szhFechaCuota,'YYYYMMDD'), 1 ),'YYYYMMDD' )
					                  			INTO :szhSgteCuota
					                  			FROM DUAL;*/

												/* EXEC SQL EXECUTE
													BEGIN
		    											:szhSgteCuota:=TO_CHAR( ADD_MONTHS ( TO_DATE(:szhFechaCuota,'YYYYMMDD'), 1 ),'YYYYMMDD' ); 
	  												END;
												END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 8;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin :szhSgteCuota := TO_CHAR ( ADD_MONTHS ( TO_\
DATE ( :szhFechaCuota , 'YYYYMMDD' ) , 1 ) , 'YYYYMMDD' ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )457;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhSgteCuota;
            sqlstm.sqhstl[0] = (unsigned long )9;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhFechaCuota;
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


                                                /* Fin Requerimiento de Soporte - 39289 - 27.04.2007 */
                                                
					                  			if (SQLCODE != SQLOK)
					                  			{
						                    		iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Fecha Sgte Cuota");
					                        		bError = TRUE;
					                        		break;
					                  			}
					
					                  			strcpy(szhFechaCuota,szhSgteCuota);
					               			} /* fin del for de la cuotas */
					               		}
					               		else  /* CO-200605120125 Soporte RyC 03.07.2006 */
					               		{
											vDTrazasLog( szExePasoC, "\nTotal Facturado para concepto es igual a cero \n", LOG03 );
			                        		vDTrazasLog( szExePasoC, "\nContinua con el siguiente concepto \n", LOG03 );
					               		}					
					            	} /* fin (stHistDocu.iNumCuotas <= 1) */ 
					         	}/* fin TotFactura > 0.0*/
				        	}/* fin ihIndPagado == 1, supertel ...*/
						}/* fin if Imp != 0.0 */				    				    
               		}/* fin for i ... */              
				    
			    	if( bError )	/* hubo un error */
			   		break;
				}/* fin for j ... */
							
	        	if( stAcumAbo.iNumReg > 0 && !bError && stHistDocu.dTotFactura > 0.0 )
	        	{
               
					if( ( stHistDocu.iCodTipMovimie == stDatosGener.iCodContado && ihIndPagado == 0 && stHistDocu.iIndFactur == 1)
				 	 || ( stHistDocu.iCodTipMovimie == stDatosGener.iCodMiscela && ihIndPagado == 0 && stHistDocu.iIndFactur == 1) )
					 
					{
				    	vDTrazasLog (szExePasoC,"\n\t\t* Parametros de Entrada: ifnDBPasoCob"
											 	"\n\t\t=> Cod.Cliente         [%ld]"
											 	"\n\t\t=> Cod.TipDocum        [%d] "
											 	"\n\t\t=> Cod.Vendedor Agente [%ld]" 
											 	"\n\t\t=> Letra               [%s] "
											 	"\n\t\t=> Cod.Centr.Emisor    [%d] "
											 	"\n\t\t=> Num.Secuenci        [%ld]"
											 	"\n\t\t=> Cod.Producto        [%d] "
											 	"\n\t\t=> Num.Transaccion     [%ld]"
											 	"\n\t\t=> Num.Venta           [%ld]"
											 	"\n\t\t=> Fec.Emision         [%s] "
											 	"\n\t\t=> Fec.CuotaUno        [%s] "
											 	"\n\t\t=> Num.Proceso         [%d] "
											 	"\n\t\t=> Num.Abonado         [%d] "
											 	"\n\t\t=> iCodTipMovimie      [%d]\n\n"
											 	,LOG04, 
											 	stHistDocu.lCodCliente,
											 	stHistDocu.iCodTipDocum,
											 	stHistDocu.lCodVendedorAgente,
											 	stHistDocu.szLetra,
											 	stHistDocu.iCodCentrEmi,
											 	stHistDocu.lNumSecuenci,
											 	stAcumAbo.pAboCobr[0].iCodProducto,
											 	stHistDocu.lNumTransaccion,
											 	stHistDocu.lNumVenta,
											 	stHistDocu.szFecEmision,
											 	szhFechaCuotaUno,
											 	stHistDocu.lNumProceso,
											 	stCobros.lNumAbonado,
											 	stHistDocu.iCodTipMovimie );
	
               			if( !bfnInicializaLogFac( pstStatus->LogFile ) )
                  		{
	                		vDTrazasLog( szExePasoC, "\t\tERROR AL INICIALIZAR ARCHIVO LOG FAC.\n\n", LOG01 );
	               			bError = TRUE;
                  		}
						else
						{
							iRes = ifnDBPasoCob(stHistDocu.lCodCliente,
						                  		stHistDocu.iCodTipDocum,
								            	stHistDocu.lCodVendedorAgente,
								            	stHistDocu.szLetra,
								            	stHistDocu.iCodCentrEmi,
								            	stHistDocu.lNumSecuenci,
								            	stAcumAbo.pAboCobr [0].iCodProducto,
								            	stHistDocu.lNumTransaccion,
								            	stHistDocu.lNumVenta,
								            	stHistDocu.szFecEmision,
								            	szhFechaCuotaUno, 			
								            	stHistDocu.lNumProceso,
								            	stCobros.lNumAbonado,
								            	stHistDocu.iCodTipMovimie,
								            	stHistDocu.szPrefPlaza,
								            	stHistDocu.szCodOperadoraScl,
								            	stHistDocu.szCodPlaza );

							if( iRes != 0 )
					 		{
						   		iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes,"ifnDBPasoCob");
						   		bError = TRUE ;  
							}
						} /* end if( !bfnInicializaLogFac( pstStatus->LogFile ) )*/
					} /* fin Contado */
		
					if( !bError && (stHistDocu.iCodTipMovimie == stDatosGener.iCodCiclo
								||( stHistDocu.iCodTipMovimie == stDatosGener.iCodMiscela && ihIndPagado == 0 )
								|| 	stHistDocu.iCodTipMovimie == stDatosGener.iCodBaja
								|| 	stHistDocu.iCodTipMovimie == stDatosGener.iCodLiquidacion ) )
					{

			   			if( stHistDocu.iCodTipMovimie == stDatosGener.iCodCiclo )
						{
							/* si el documento es de ciclo, vemos pago limite consumo */
							if( !bProcesaPagoLimiteConsumo( stHistDocu.lCodCliente ) )
							{
								vDTrazasLog( szExePasoC, "\t\tERROR AL PROCESAR PAGO LIMITE CONSUMO.\n\n", LOG01 );
								bError = TRUE;
							}
						}
						
						if( !bError )
						{	
							
							if( !bfnInicializaLogFac( pstStatus->LogFile ) )
							{
								vDTrazasLog( szExePasoC, "\t\tERROR AL INICIALIZAR ARCHIVO LOG FAC.\n\n", LOG01 );
								bError = TRUE;
							}
							else
							{
								/*iRes = ifnCancelacionCreditos( stHistDocu.lCodCliente, &stCobros, iCodAbono, stHistDocu.szFecEmision, 0 );*/
								iRes = ifnLlamaCancelacion( stHistDocu.lCodCliente, stHistDocu.szFecEmision, xx + 1 );
								if( iRes != 0 )
								{
									iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "ifnCancelacionCreditos" );
									bError = TRUE;
								}
							} /* end if( !bfnInicializaLogFac( pstStatus->LogFile ) ) */
						} /* end if( !bError )*/
					} /* end if( !bError && (stHistDocu. ....*/
	
	      			/*if( !bError && stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre ) el lucho pidio este cambio*/
	      			if( !bError && (stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre) || (stHistDocu.iCodTipMovimie == ihNotaAbono) )
	      			{

						vDTrazasLog (szExePasoC,  	"\n\t\t* Paso de Nota de Credito"
													"\n\t\t=> Num.Secuenci   [%d]"
													"\n\t\t=> Cod.TipDocum   [%d] "
													"\n\t\t=> Cod.VendedorA  [%d]"
													"\n\t\t=> Letra          [%s] "
													"\n\t\t=> Cod.CentrEmi   [%d] "
													"\n\t\t=> Num.SecuenciRel[%d]"
													"\n\t\t=> Cod.TipDocumRel[%d] "
													"\n\t\t=> Cod.VendedorRel[%d]"
													"\n\t\t=> LetraRel       [%s] "
													"\n\t\t=> Cod.CentrEmiRel[%d] "
													"\n\t\t=> Cod.Cliente    [%d]"
													"\n\t\t=> iCodTipMovimie [%d]"
													"\n\t\t=> szPrefPlaza    [%s]" /* jlr_11.01.03 */
													"\n\t\t=> szCodOperadora [%s]" /* jlr_11.01.03 */
													"\n\t\t=> szCodPlaza     [%s]" /* jlr_11.01.03 */
													,LOG05,
													stHistDocu.lNumSecuenci,
													stHistDocu.iCodTipDocum,
													stHistDocu.lCodVendedorAgente,
													stHistDocu.szLetra,
													stHistDocu.iCodCentrEmi,
													stHistDocu.lNumSecuRel,
													stHistDocu.iCodTipDocumRel,
													stHistDocu.lCodVendedorAgenteRel,
													stHistDocu.szLetraRel,
													stHistDocu.iCodCentrRel,
													stHistDocu.lCodCliente,
													stHistDocu.iCodTipMovimie,
													stHistDocu.szPrefPlaza,       /* jlr_11.01.03 */
													stHistDocu.szCodOperadoraScl, /* jlr_11.01.03 */
													stHistDocu.szCodPlaza );	  /* jlr_11.01.03 */
										
						/******************************************** jlr_01.10.01 **************************************/
	                	/* (1):Factura intercalada  | (0):Factura no intercalada  | (-1):Error  */

	                	if( ifnFactIntercalada(&stHistDocu) != 1 )
	                	{
	                		vDTrazasLog (szExePasoC,"\n\t\t* No se intercala NC pues Factura asociada no esta intercalada\n\n",LOG01);
	        	      		if(!bfnOraRollBack() )
					    	{
								iDError( szExePasoC, ERR000, vInsertarIncidencia, "RollBackWork NC", szfnORAerror() );
						    	vfnFreeAcumAbo( &stAcumAbo );						        						        
						    	return FALSE ;
		   	        		}

					    	continue; /* tomar la sgte factura */
	                	}
						/**************************************************************************************************/                                      
	               		if (stHistDocu.dTotFactura > 0.0)
	                	{ 
	                		vDTrazasLog (szExePasoC,"\n\t\t* Antes de llamar a bfnInicializaLogNc \n",LOG05);  /*XO-200509130656, 27-09-2005 rvc Soporte RyC*/
		               		if( !bfnInicializaLogNc( pstStatus->LogFile ) )
	                		{
			            		vDTrazasLog( szExePasoC, "\t\tERROR AL INICIALIZAR ARCHIVO LOG NC.\n\n", LOG01 );
			                	iRes = -1;
	        	        	}
					    	else
					    	{	    
					    		vDTrazasLog (szExePasoC,"\n\t\t* Antes de llamar a ifnPasoCobNcNd \n",LOG05); /*XO-200509130656, 27-09-2005 rvc Soporte RyC*/
		                    	iRes = ifnPasoCobNcNd ( stHistDocu.lNumSecuenci         ,    
		                           	                 	stHistDocu.iCodTipDocum         ,
		                                   	         	stHistDocu.lCodVendedorAgente   ,
		                                           	 	stHistDocu.szLetra              ,
			                                         	stHistDocu.iCodCentrEmi         ,
			                	                     	stHistDocu.lNumSecuRel          ,
			                                         	stHistDocu.iCodTipDocumRel      ,
		        	                                 	stHistDocu.lCodVendedorAgenteRel,
		                	                         	stHistDocu.szLetraRel           ,
		                                             	stHistDocu.iCodCentrRel         ,
		                          	                 	stHistDocu.lCodCliente			,
		                                  	         	stHistDocu.iCodTipMovimie       ,
				                	                 	stHistDocu.szPrefPlaza          , /* jlr_11.01.03 */
					                		         	stHistDocu.szCodOperadoraScl    , /* jlr_11.01.03 */
					                		         	stHistDocu.szCodPlaza           , /* jlr_11.01.03 */
		        	                                 	stHistDocu.szNomUsuarioORA);      /* GAC 08-08-2003 */
		        	                                 	/*pstStatus->LogFile );*/
							} /* end if( !bfnInicializaLogNc( pstStatus->LogFile ) )*/
	                	}
	                	else
	                	{
	                   		iRes   = 0    ;
	                   		bError = FALSE;
	                	} /* end if (stHistDocu.dTotFactura > 0.0)*/
	
	                	/* La factura no Existe en la Cartera */
	                	vDTrazasLog (szExePasoC,"\n\t\t* iRes %d", LOG05, iRes);
	
	                	if( iRes )
	                	{
	                		iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "ifnPasoCobNcNd");
	                    	bError = TRUE ; 
	                	}
	                    
	            	} /* fin (stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre) */
       			} /* fin (stAcumAbo.iNumReg > 0 && !bError) */   /* Solicitado por JLR. 12.05.2003 -MQG- */

		    	if( !bError )
            	{
                	stHistDocu.iIndPasoCobro = 1;
                	if (!bfnDBUpdateHistDocu (stHistDocu))   bError = TRUE; 

                	if (!stConfig.bOptCodCicloFact)
                	{
                    	/* ihCodEstaDocSal = stInterProc.iCodEstaDocSal; */
                    	ihCodEstaDocSal = stIntQueueProc.iCodEstaDocSal;
                    	lhNumProceso 	= stHistDocu.lNumProceso;

                    	/* EXEC SQL
                    	UPDATE  FA_INTERFACT
                    	SET     COD_ESTADOC = :ihCodEstaDocSal,
                            	COD_ESTPROC = :iProcTermOk,
                            	FEC_PASOCOBRO = SYSDATE
                    	WHERE   NUM_PROCESO = :lhNumProceso; */ 

{
                     struct sqlexd sqlstm;
                     sqlstm.sqlvsn = 12;
                     sqlstm.arrsiz = 8;
                     sqlstm.sqladtp = &sqladt;
                     sqlstm.sqltdsp = &sqltds;
                     sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0\
,COD_ESTPROC=:b1,FEC_PASOCOBRO=SYSDATE where NUM_PROCESO=:b2";
                     sqlstm.iters = (unsigned int  )1;
                     sqlstm.offset = (unsigned int  )480;
                     sqlstm.cud = sqlcud0;
                     sqlstm.sqlest = (unsigned char  *)&sqlca;
                     sqlstm.sqlety = (unsigned short)256;
                     sqlstm.occurs = (unsigned int  )0;
                     sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaDocSal;
                     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                     sqlstm.sqhsts[0] = (         int  )0;
                     sqlstm.sqindv[0] = (         short *)0;
                     sqlstm.sqinds[0] = (         int  )0;
                     sqlstm.sqharm[0] = (unsigned long )0;
                     sqlstm.sqadto[0] = (unsigned short )0;
                     sqlstm.sqtdso[0] = (unsigned short )0;
                     sqlstm.sqhstv[1] = (unsigned char  *)&iProcTermOk;
                     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
                     sqlstm.sqhsts[1] = (         int  )0;
                     sqlstm.sqindv[1] = (         short *)0;
                     sqlstm.sqinds[1] = (         int  )0;
                     sqlstm.sqharm[1] = (unsigned long )0;
                     sqlstm.sqadto[1] = (unsigned short )0;
                     sqlstm.sqtdso[1] = (unsigned short )0;
                     sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
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
}



                    	if( SQLCODE != SQLOK )
                    	{
                        	iDError( szExePasoC,ERR043,vInsertarIncidencia, iRes, "Update Fa_Interfact" );
                        	bError = TRUE;
                    	}
                	} /* end if (!stConfig.bOptCodCicloFact) */

                	/* redondeamos a la cantidad de decimales configurados para la operadora */
                	dTotPasoCob = fnCnvDouble( stHistDocu.dTotFactura, pstParamGener.iNumDecimal ); /*TM-200412091155 13-06-2005 Desarrollo RyC */

					/* Inicio Requerimiento de Soporte - 41321_3 - 13.07.2007 */
					/*EXEC SQL
					UPDATE FA_REPDETALLE_TO
				   	   SET NUM_DOCOPERADORA = NUM_DOCOPERADORA + 1,
					       TOT_OPERADORA 	= TOT_OPERADORA + :dTotPasoCob
					WHERE NUM_PROCPASOCOBRO = :lNumProcPasoCob
				  	 AND COD_OPERADORA_SCL  = :stHistDocu.szCodOperadoraScl;
                    
                	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
                	{
                		iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "UPDATE FA_REPDETALLE_TO" );
                    	bError = TRUE;
                	}
                	else
                	{
	            		if( SQLCODE == SQLNOTFOUND )
                    	{
							-- insertamos el registro 
							EXEC SQL
							INSERT INTO FA_REPDETALLE_TO
							(  
								NUM_PROCPASOCOBRO,
								COD_OPERADORA_SCL,
								NUM_DOCOPERADORA,
								TOT_OPERADORA,
								MTO_AJUSTE
							)
							VALUES
							(
								:lNumProcPasoCob,
								:stHistDocu.szCodOperadoraScl,
								1,
								:dTotPasoCob,
								0
							);	

	                   		if( SQLCODE != SQLOK )
	                   		{
	                   			iDError( szExePasoC, ERR043, vInsertarIncidencia, iRes, "INSERT FA_REPDETALLE_TO" );
	                        	bError = TRUE;
	                   		}
	                	} -- end if( SQLCODE == SQLNOTFOUND )
					} -- if( SQLCODE != SQLOK ) */
					/* Fin Requerimiento de Soporte - 41321_3 - 13.07.2007 */

					/* Ve si el cliente es Moroso  jlr_12.10.00 */
					ihMoroso = 0;

					/* EXEC SQL
					SELECT  COUNT(*)
					INTO 	:ihMoroso
					FROM 	CO_MOROSOS
					WHERE 	COD_CLIENTE = :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  into :b0  from CO_MOROSOS where COD_CLI\
ENTE=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )507;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihMoroso;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



					if (SQLCODE != SQLOK)
					{
				  		iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Co_Morosos");
				  		bError = TRUE;
					}

					if( ihMoroso ) /* si es moroso recalcula la deuda */
					{
						/* EXEC SQL
						SELECT 	TO_CHAR(MIN(FEC_VENCIMIE),'YYYYMMDD'),
							    NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
						INTO 	:szhFecVencimiento:shFecVenc,
								:dhSaldoVenc
						FROM 	CO_CARTERA
						WHERE	COD_CLIENTE   = :lhCodCliente
						AND		IND_FACTURADO = 1
						AND		FEC_VENCIMIE < TRUNC(SYSDATE)
						AND		COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
														FROM	CO_CODIGOS
														WHERE	NOM_TABLA   = 'CO_CARTERA'
													 		AND	NOM_COLUMNA = 'COD_TIPDOCUM' ); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 8;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select TO_CHAR(min(FEC_VENCIMIE),'YYYYMMDD') ,NVL(sum((\
IMPORTE_DEBE-IMPORTE_HABER)),0) into :b0:b1,:b2  from CO_CARTERA where (((COD_\
CLIENTE=:b3 and IND_FACTURADO=1) and FEC_VENCIMIE<TRUNC(SYSDATE)) and COD_TIPD\
OCUM not  in (select TO_NUMBER(COD_VALOR)  from CO_CODIGOS where (NOM_TABLA='C\
O_CARTERA' and NOM_COLUMNA='COD_TIPDOCUM')))";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )530;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhFecVencimiento;
      sqlstm.sqhstl[0] = (unsigned long )9;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)&shFecVenc;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoVenc;
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

 /* jlr_23.01.01 */
						if( SQLCODE != SQLOK )
						{
							iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Co_Cartera(1)");
							bError = TRUE;
						}

						/* EXEC SQL
						SELECT	NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),0)
						INTO	:dhSaldoNoVenc
						FROM	CO_CARTERA
						WHERE	COD_CLIENTE   = :lhCodCliente
						AND		IND_FACTURADO = 1
						AND		FEC_VENCIMIE >= TRUNC(SYSDATE); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 8;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) into :b\
0  from CO_CARTERA where ((COD_CLIENTE=:b1 and IND_FACTURADO=1) and FEC_VENCIM\
IE>=TRUNC(SYSDATE))";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )557;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldoNoVenc;
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



						if (SQLCODE != SQLOK)
						{
							iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Co_Cartera(2)");
							bError = TRUE;
						}

						strcpy(szhFecVencimiento,(shFecVenc==ORA_NULL)?"":szhFecVencimiento);

						/* EXEC SQL
						UPDATE CO_MOROSOS
						   SET FEC_DEUDVENC = TO_DATE(:szhFecVencimiento,'YYYYMMDD'),
							   DEU_VENCIDA  = :dhSaldoVenc,
							   DEU_NOVENC   = :dhSaldoNoVenc
						WHERE 	COD_CLIENTE = :lhCodCliente; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 8;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "update CO_MOROSOS  set FEC_DEUDVENC=TO_DATE(:b0,'YYYYMM\
DD'),DEU_VENCIDA=:b1,DEU_NOVENC=:b2 where COD_CLIENTE=:b3";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )580;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhFecVencimiento;
      sqlstm.sqhstl[0] = (unsigned long )9;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoVenc;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&dhSaldoNoVenc;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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



						if (SQLCODE != SQLOK)
						{
							iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Update Co_Morosos");
							bError = TRUE;
						}
					} /* end if( ihMoroso )*/
					
					/* EXEC SQL
					SELECT NUM_IDENT, COD_TIPIDENT
					INTO szhNumIdent_a, szhCodTipIdent_a
					FROM GE_CLIENTES
					WHERE COD_CLIENTE = :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 8;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select NUM_IDENT ,COD_TIPIDENT into :b0,:b1  from GE_CLI\
ENTES where COD_CLIENTE=:b2";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )611;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent_a;
     sqlstm.sqhstl[0] = (unsigned long )21;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent_a;
     sqlstm.sqhstl[1] = (unsigned long )3;
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


					
					if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  /*Homol. a XC-0002 GAC 2004-09-06*/
					{
						iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Ge_Clientes(1)");
						bError = TRUE;
					}

					if (SQLCODE != SQLNOTFOUND) /* Existe Clientes en GE_CLIENTES  Homol. a CH-1761 GAC 2004-09-06*/ 
					{
						/* Ve si el cliente esta en Cobranza Externa jlr_12.10.00 */
						/* Se busca en la CO_COBEXTERNA por RUT  Homol. a CH-1761 GAC 2004-09-06*/
						/* EXEC SQL
						SELECT NUM_IDENT, COD_TIPIDENT
						INTO szhNumIdent, szhCodTipIdent
						FROM CO_COBEXTERNA
						WHERE NUM_IDENT    = trim(:szhNumIdent_a)
						AND COD_TIPIDENT   = trim(:szhCodTipIdent_a)
						AND COD_CLIENTE    = DECODE(cod_cliente, 0, 0,:lhCodCliente) /ocapc  PH-0239 23-06-2004o/
						AND COD_MOVIMIENTO = 'SM' 						/o Alta no, Baja no, Movimiento no o/
						AND COD_ENVIO NOT IN ( 'B', 'R', 'I', 'G', 'V', 'E', 'N' ) /o jlr_26.02.01, Baja, Reasignado, Ingresado, Generado, Visado o/
						AND COD_CLIENTE    = DECODE(:szEntGestion, 'C', :lhCodCliente, COD_CLIENTE ); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 8;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select NUM_IDENT ,COD_TIPIDENT into :b0,:b1  from CO_CO\
BEXTERNA where (((((NUM_IDENT=trim(:b2) and COD_TIPIDENT=trim(:b3)) and COD_CL\
IENTE=DECODE(cod_cliente,0,0,:b4)) and COD_MOVIMIENTO='SM') and COD_ENVIO not \
 in ('B','R','I','G','V','E','N')) and COD_CLIENTE=DECODE(:b5,'C',:b4,COD_CLIE\
NTE))";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )638;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
      sqlstm.sqhstl[0] = (unsigned long )21;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
      sqlstm.sqhstl[1] = (unsigned long )3;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhNumIdent_a;
      sqlstm.sqhstl[2] = (unsigned long )21;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipIdent_a;
      sqlstm.sqhstl[3] = (unsigned long )3;
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
      sqlstm.sqhstv[5] = (unsigned char  *)szEntGestion;
      sqlstm.sqhstl[5] = (unsigned long )2;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
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

  /* 18-05-2004 XM-200405180055 */
						
						if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  /* Homol.a XC-0002 GAC 2004-09-06 */
						{
							vDTrazasError(szExeName,"\n\t**  Error en SELECT CO_COBEXTERNA **"
													"\n\t\t=> Error : [%d]  [%s] ",LOG00,SQLCODE,SQLERRM);
							iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Select Co_Cobexterna");
							bError = TRUE;
						}

						if (SQLCODE != SQLNOTFOUND) /* si esta en cobranza externa marca el Movimiento */
						{
							/* EXEC SQL
							UPDATE CO_COBEXTERNA
							   SET COD_MOVIMIENTO = 'M',
						       	   FEC_MOVIMIENTO = SYSDATE
							WHERE NUM_IDENT 	= :szhNumIdent
							AND COD_TIPIDENT	= :szhCodTipIdent
							AND COD_CLIENTE    	= DECODE(cod_cliente, 0, 0,:lhCodCliente) /o Solicitado por JLR. 07.05.2003 -MQG- o/
							AND COD_MOVIMIENTO  = 'SM'					/o Alta no, Baja no, Movimiento no o/
							AND COD_ENVIO NOT IN ( 'B', 'R', 'I', 'G', 'V', 'E', 'N' ) 	/o jlr_26.02.01, Baja, Reasignado, Ingresado, Generado, Visado o/
							AND COD_CLIENTE    = DECODE(:szEntGestion, 'C', :lhCodCliente, COD_CLIENTE ); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 8;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update CO_COBEXTERNA  set COD_MOVIMIENTO='M',FEC_MOVIM\
IENTO=SYSDATE where (((((NUM_IDENT=:b0 and COD_TIPIDENT=:b1) and COD_CLIENTE=D\
ECODE(cod_cliente,0,0,:b2)) and COD_MOVIMIENTO='SM') and COD_ENVIO not  in ('B\
','R','I','G','V','E','N')) and COD_CLIENTE=DECODE(:b3,'C',:b2,COD_CLIENTE))";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )681;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
       sqlstm.sqhstl[0] = (unsigned long )21;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
       sqlstm.sqhstl[1] = (unsigned long )3;
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
       sqlstm.sqhstv[3] = (unsigned char  *)szEntGestion;
       sqlstm.sqhstl[3] = (unsigned long )2;
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

  /* 18-05-2004 XM-200405180055 */
							   
							if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
							{
								vDTrazasError(szExeName,"\n\t**  Error en UPDATE CO_COBEXTERNA **"
														"\n\t\t=> Error : [%d]  [%s] ",LOG00,SQLCODE,SQLERRM);
								iDError (szExePasoC,ERR043,vInsertarIncidencia, iRes, "Update Co_Cobexterna");
								bError = TRUE;
							}
						}	
					}/* endif Cobranza externa */
				} /* fin (!bError) */
	           /* } fin (stAcumAbo.iNumReg > 0 && !bError) */
			}  /*if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) */    
		} /* if( !bfnGetDatosCliente( lhCodCliente ) ) */
		            
        /* aca marcamos el documento con error y deshacemos los cambios o grabamos OK */
        if( bError )
        {
			if(!bfnOraRollBack() )
		    {
		        iDError( szExePasoC, ERR000, vInsertarIncidencia, "RollBackWork Docto ERROR", szfnORAerror() );
		        vfnFreeAcumAbo( &stAcumAbo );
		        return FALSE ;
		    }

			if( giEstadoDocumento != iDOCTOCONCEPNEG && giEstadoDocumento != iNOEXISTECLIE  && giEstadoDocumento != iTOTALFACTURA0) /* no viene con error */
				giEstadoDocumento = iDOCTOCONERROR;
            
			vDTrazasLog( szExeName, "CLIENTE => [%d] SECUENCIA => [%d] DOCUMENTO CON ERROR => [%d].", 
									  LOG03, stHistDocu.lCodCliente, stHistDocu.lNumSecuenci, giEstadoDocumento );
			
			/* guardamos datos de los documentos con error, para insertarlos mas tarde */
			strcpy( stAcumDoctoPaso[giCntRegistrosProc].szRowid, stHistDocu.szRowid );
			stAcumDoctoPaso[giCntRegistrosProc].iIndPasoCobro = giEstadoDocumento; /* puede ser -5 o -6 */
			stAcumDoctoPaso[giCntRegistrosProc].lNumProcPasoCobro = lNumProcPasoCob;
			
            if (!stConfig.bOptCodCicloFact)
			{
				stAcumDoctoPaso[giCntRegistrosProc].iCodEstaDocSal = stIntQueueProc.iCodEstaDocSal;
				stAcumDoctoPaso[giCntRegistrosProc].lNumProceso = stHistDocu.lNumProceso;
			}

			giCntRegistrosProc++;
			giEstadoDocumento = 0;

            iRes = 0; /* continuamos con el siguiente registro */
        }
        else	/* todo OK */
        {
        	/* grabamos los registros con error si los hubiere */
        	if( !bfnGrabaRegistrosError( stConfig ) )
				return FALSE;
			
			giCntRegistrosProc = 0;
				
            /* hacemos commit a todo los ultimos movimientos de la base de datos */
            if( !bfnOraCommit() )
            {
                iDError( szExePasoC, ERR000, vInsertarIncidencia, "CommitWork", szfnORAerror() );
                /*vfnFreeAcumAbo( &stAcumAbo ); MIX-09003 - 30.09.2009 - MQG */
                return FALSE;
            }
        } /* fin (bError) */
    }/* for( xx = 0; xx < glTotalDoctosInter; xx++ ) */

	/* por si es el ultimo con error */
	if( giCntRegistrosProc > 0  )
	{
		/* grabamos los registros con error si los hubiere */
		if( !bfnGrabaRegistrosError( stConfig ) )
			return FALSE;
	
	    /* hacemos commit a todo los ultimos movimientos de la base de datos */
	    if( !bfnOraCommit() )
	    {
	        iDError( szExePasoC, ERR000, vInsertarIncidencia, "CommitWork", szfnORAerror() );
	        /*vfnFreeAcumAbo( &stAcumAbo );MIX-09003 - 30.09.2009 - MQG */
	        return FALSE;
	    }
	} /* end if( giCntRegistrosProc > 0  )*/

    /* Inicio MIX-09003 - 30.09.2009 - MQG */
	/*vfnFreeAcumAbo( &stAcumAbo );*/

	if( giCntRegistrosProc > 0  ) 
	    vfnFreeAcumAbo( &stAcumAbo );

    /* Fin MIX-09003 - 30.09.2009 - MQG */

	return TRUE;   

} /* fin bfnPasoCobros()*/

	
/*****************************************************************************/
/*Funcion : ifnLlamaCancelacion 	                 	                          */
/*****************************************************************************/
int ifnLlamaCancelacion( long lCodCliente, char *szFec_pago, int k)
{
int      iResul = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNum_Transaccion      ;
	long lhCodCliente           ;
	char szhFec_Pago        [20]; /* EXEC SQL VAR szhFec_Pago IS STRING(20); */ 

	int  ihRetorno              ;
	char szhGlosa          [500]; 
	int  ihCarrier  	    = 0 ;
	char szhYYYYMMDD         [9];
	char szhYYYYMMDDHH24MISS[17];
	char szhCodOperadora     [3]; /* EXEC SQL VAR szhCodOperadora IS STRING(3); */ 

/* EXEC SQL END DECLARE SECTION; */ 

	
	/*---------------------------------------------------------------------*/
	vDTrazasLog( szExeName,"En funcion ifnLlamaCancelacion() \n",LOG03);
	vDTrazasLog( szExeName,"CO_CANCELACION_PG.CO_CANCELACREDITOS_PR\n",LOG03);
	
	memset(szhGlosa,'\0',sizeof(szhGlosa));
	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");
	strcpy(szhYYYYMMDD,"YYYYMMDD");
	ihRetorno=99;

	/* EXEC SQL
	SELECT GA_SEQ_TRANSACABO.NEXTVAL
	INTO   :lhNum_Transaccion
	FROM   DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )716;
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
	    iDError( szExePasoC, ERR000, vInsertarIncidencia, "En SELECT GA_SEQ_TRANSACABO.NEXTVAL.", szfnORAerror() );
	    return -1;
	}
	
	lhCodCliente=lCodCliente;
	strncpy(szhFec_Pago,szFec_pago,8);
	szhFec_Pago[8] = '\0'; 

	/* EXEC SQL EXECUTE
		BEGIN
	  		:szhFec_Pago:=TO_CHAR(TO_DATE(:szhFec_Pago,:szhYYYYMMDDHH24MISS),:szhYYYYMMDD);	  		
	  	END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szhFec_Pago := TO_CHAR ( TO_DATE ( :szhFec_Pago , :sz\
hYYYYMMDDHH24MISS ) , :szhYYYYMMDD ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )735;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFec_Pago;
 sqlstm.sqhstl[0] = (unsigned long )20;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDDHH24MISS;
 sqlstm.sqhstl[1] = (unsigned long )17;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
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


	if (sqlca.sqlcode != SQLOK) {
	    iDError( szExePasoC, ERR000, vInsertarIncidencia, "En szhFec_Pago y lhNum_Transaccion.", szfnORAerror() );
	    return -1;
	}

	vDTrazasLog( szExeName,"\n\t****** Registro #[%03d] ******"
					       "\n\t\t=> lhCodCliente      [%ld]"
						   "\n\t\t=> szFecPago         [%s] "
						   "\n\t\t=> lhNum_Transaccion [%ld]\n\n",LOG03,k ,lhCodCliente ,szhFec_Pago, lhNum_Transaccion );

	/* EXEC SQL EXECUTE
		BEGIN
				CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(:lhCodCliente, TO_DATE(:szhFec_Pago,:szhYYYYMMDD), :lhNum_Transaccion , :ihCarrier , NULL , NULL , NULL, :ihRetorno , :szhGlosa );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin CO_CANCELACION_PG . CO_CANCELACREDITOS_PR ( :lhCodClie\
nte , TO_DATE ( :szhFec_Pago , :szhYYYYMMDD ) , :lhNum_Transaccion , :ihCarrie\
r , NULL , NULL , NULL , :ihRetorno , :szhGlosa ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )762;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhNum_Transaccion;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCarrier;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihRetorno;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhGlosa;
 sqlstm.sqhstl[6] = (unsigned long )500;
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


	
	/*if (sqlca.sqlcode != SQLOK ) {
    	iDError( szExePasoC, ERR000, vInsertarIncidencia, "En CO_CANCELACREDITOS_PR.\n", szfnORAerror() );

	}*/
	if (sqlca.sqlcode != SQLOK ) {
  	 	if (sqlca.sqlcode != -1405 ) {  /* Soporte RyC 34635 - Colombia 16.11.2006 */
        	iDError( szExePasoC, ERR000, vInsertarIncidencia, "En CO_CANCELACREDITOS_PR.\n", szfnORAerror() );
     	}
	}

   	if (ihRetorno == 99) {
   		iDError( szExePasoC, ERR000, vInsertarIncidencia, "Valor de Retorno es 99. Posible error en la PL\n", szfnORAerror() );   
   	}
   	else if (ihRetorno != 0)   {
   		rtrim(szhGlosa);
   		vDTrazasLog( szExeName,"Valor ihRetorno [%d]",LOG03,ihRetorno);
   		vDTrazasLog( szExeName,"En CO_CANCELACREDITOS_PR. [%s]\n ",LOG03,szhGlosa);
  
   	}

  	vDTrazasLog( szExeName,"Fin a Cancelacion de Creditos. <== %d ==>\n\n",LOG03,ihRetorno);
	return ihRetorno;

}/* Fin ifnLlamaCancelacion() */
	
	
/*****************************************************************************/
/*					funcion : bfnGrabaRegistrosError 	                 	 */
/*****************************************************************************/
static BOOL bfnGrabaRegistrosError( CONFIG stConfig )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCodEstaDocSal;
    long lhNumProceso;
/* EXEC SQL END DECLARE SECTION; */ 

    
	int zz;
    
    /* si llegamos aca, un documento esta bueno, y puede haber documentos con error
       que reflejar en la base de datos */
    if( giCntRegistrosProc > 0 ) /* hay documentos en la estructura de documentos con error */
    {
		/* recorremos la estructura de documentos con error */
		for( zz = 0; zz < giCntRegistrosProc; zz++ )
		{
            if( !bfnDBUpdateHistDocuError( 	stAcumDoctoPaso[zz].szRowid, 
            								stAcumDoctoPaso[zz].iIndPasoCobro,
            								stAcumDoctoPaso[zz].lNumProcPasoCobro ) )
            	return FALSE;

			if( !stConfig.bOptCodCicloFact )
			{
				ihCodEstaDocSal =stAcumDoctoPaso[zz].iCodEstaDocSal;
				lhNumProceso = stAcumDoctoPaso[zz].lNumProceso;

				/* EXEC SQL
				UPDATE FA_INTERFACT
				   SET COD_ESTADOC 	 = :ihCodEstaDocSal,
					   COD_ESTPROC 	 = :iProcTermErr,
					   FEC_PASOCOBRO = SYSDATE
				 WHERE NUM_PROCESO = :lhNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0,COD_ESTPROC=:b1,\
FEC_PASOCOBRO=SYSDATE where NUM_PROCESO=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )805;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaDocSal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iProcTermErr;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
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
}


				
				if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
				{
					vDTrazasLog( szExePasoC, "\n\n\tERROR al Actualizar FA_INTERFACT en bfnGrabaRegistrosError.\n", LOG05 );
					return FALSE;
				}	
			}
		} /* for( z = 0; z < giCntRegistrosProc; zz++ ) */
	} /* if( giCntRegistrosProc > 0 ) */
	
	giCntRegistrosProc = 0; /* reiniciamos la variable */
	
	/* limpiamos la estructura de documentos con error */
	if( !bfnLimpiaEstructura() )
		return FALSE;

	return TRUE;

} /* fin bfnGrabaRegistrosError() */

/**************************** Final bfnPasoCobros ***************************/

/*****************************************************************************/
/*					funcion : ifnTipDevolucionCliente 	                 	 */
/* 	Indica si una NC, asociada a una factura de venta, se intercala como	 */
/*  abono o como devolucion de dinero										 */
/* -Valores Retorno : < 0 	Error											 */ 					
/*						0 	Intercala para devolucion 						 */
/*						1	Intercala como abono                             */
/*****************************************************************************/
static int ifnTipDevolucionCliente( DATOS_FACT *pstHistDocu )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int		iCntCount;
	int		ihCodTipDocumRel;
	int		ihIndDevolucion;
    long    lhNumSecuenciRel;
/* EXEC SQL END DECLARE SECTION; */ 

	
	int iIndDevolucion = 1, iRes = 0;
	
	/* debemos saber si la NC, tiene documento asociado */
	if( pstHistDocu->lNumSecuRel != ORA_NULL )
	{
		ihCodTipDocumRel = pstHistDocu->iCodTipDocumRel;
		lhNumSecuenciRel = pstHistDocu->lNumSecuRel;
		/* debemos saber la NC esta asociada a una factura de venta */
		/* EXEC SQL
		SELECT 	COUNT(*)
		INTO	:iCntCount
		FROM	FA_TIPMOVIMIEN
		WHERE	COD_TIPMOVIMIEN = 1
		AND		COD_TIPDOCUM    = :ihCodTipDocumRel; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select count(*)  into :b0  from FA_TIPMOVIMIEN where (COD_T\
IPMOVIMIEN=1 and COD_TIPDOCUM=:b1)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )832;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iCntCount;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumRel;
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


	
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
		{
			iDError( szExePasoC, ERR043, vInsertarIncidencia, "Comprobando Tipo de Movimiento de Facturacion" );
			return -1;
		}
	
	    vDTrazasLog( szExePasoC, "DoctoRel => [%d] SecuenciaRel => [%d] FA_TIPMOVIMIE => [%d].", LOG03, ihCodTipDocumRel, lhNumSecuenciRel, iCntCount );

		if( iCntCount > 0 )	/* es factura de venta */
		{
			/* debemos determinar si debe quedar como abono o devolucion */
			/* EXEC SQL
			SELECT	P.IND_DEVOLUCION
			INTO	:ihIndDevolucion
			FROM	PV_VENTAS_ANULADAS P, FA_HISTDOCU C  
			WHERE   C.NUM_SECUENCI  =   :lhNumSecuenciRel
			AND		C.NUM_VENTA     = P.NUM_VENTA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select P.IND_DEVOLUCION into :b0  from PV_VENTAS_ANULADAS \
P ,FA_HISTDOCU C where (C.NUM_SECUENCI=:b1 and C.NUM_VENTA=P.NUM_VENTA)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )855;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihIndDevolucion;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenciRel;
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


			
			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
			{
				iDError( szExePasoC, ERR043, vInsertarIncidencia, "Comprobando tipo de Devolucion." );
				return -1;
			}
			
			iIndDevolucion = ( ihIndDevolucion != 0 ) ? 1 : 0; 
		} /* end if( iCntCount > 0 )*/
	} /* if( stHistDocu.lNumSecuRel != ORA_NULL ) */ 

    vDTrazasLog( szExePasoC, "Devolucion ifnTipDevolucionCliente iIndDevolucion => [%d].", LOG03, iIndDevolucion );

	return iIndDevolucion;	

} /* int ifnTipDevolucionCliente( DATOS_FACT *pstHistDocu ) */

/*****************************************************************************/
/*                           funcion : bfnDBOpenHistDocu                     */
/* -Funcion que carga en Abre cursor sobre la tabla Fa_HistDocu (Cabecera de */
/*  Documento).                                                              */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL ifnDBOpenHistDocu (CONFIG stConfig)
{
char szFuncion [30] = "";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    static char szhQuery [2048]		 ; /* EXEC SQL VAR szhQuery IS STRING(2048); */ 

    static char szhCodTipDocum [5]	 ; /* EXEC SQL VAR szhCodTipDocum IS STRING(5); */ 

    static char szhCodTipMovimien [3]; /* EXEC SQL VAR szhCodTipMovimien IS STRING(3); */ 

    static char szhCodCicloFact [9]	 ; /* EXEC SQL VAR szhCodCicloFact IS STRING(9); */ 

    static char szhIndOrdenTotal [13]; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13); */ 

    static int  ihCodTipDocum;
    static int  ihCodTipMovimien;
    static long lhCodCicloFact;
    static int  ihCodEstaDocEnt;
    static char szhCodEstaDocEnt [4] ; /* EXEC SQL VAR szhCodEstaDocEnt IS STRING(4); */ 

    static char szhCodEstProcOk [2]  ; /* EXEC SQL VAR szhCodEstProcOk IS STRING(2); */ 

    static char szhCodModGener [6]   ; /* EXEC SQL VAR szhCodModGener IS STRING(6); */ 

    char   	szhDIAS_VCTO_FACTURA[18];   /* EXEC SQL VAR szhDIAS_VCTO_FACTURA IS STRING(18); */ 
 /* Soporte RyC MCO-200606060001 17-07-2006 capc */
    char    szD_Vcto_Fact[10];   /* EXEC SQL VAR szD_Vcto_Fact IS STRING(10); */ 
 /* Soporte RyC MCO-200606060001 17-07-2006 capc */
/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhDIAS_VCTO_FACTURA,"DIAS_VCTO_FACTURA"); /* Soporte RyC MCO-200606060001 17-07-2006 capc */
   	/* Inicio Soporte RyC MCO-200606060001 17-07-2006 capc*/
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
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
(COD_MODULO='GA' and NOM_PARAMETRO=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )878;
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


   
   	if( SQLCODE != SQLOK ) {
   		vDTrazasLog (szExePasoC,"\n\n\tERROR Select GED_PARAMETROS szhDIAS_VCTO_FACTURA 2\n", LOG03);
   		return SQLCODE;
   	}
   	/* fin Soporte RyC MCO-200606060001 17-07-2006 capc*/

    strcpy(szhQuery,"SELECT F.ROWID,");
    strcat(szhQuery,"F.NUM_SECUENCI,");
    strcat(szhQuery,"F.COD_TIPDOCUM,");
    strcat(szhQuery,"F.COD_VENDEDOR_AGENTE,");
    strcat(szhQuery,"F.LETRA,");
    strcat(szhQuery,"F.COD_CENTREMI,");
    strcat(szhQuery,"F.TOT_FACTURA,");
    strcat(szhQuery,"F.COD_CLIENTE,");
    strcat(szhQuery,"TO_CHAR(F.FEC_EMISION ,'YYYYMMDDHH24MISS'),");
    strcat(szhQuery,"F.IND_ORDENTOTAL,");
    strcat(szhQuery,"F.IND_SUPERTEL,");
    strcat(szhQuery,"F.NUM_FOLIO,");
    strcat(szhQuery,"F.NUM_CTC,");
    strcat(szhQuery,"TO_CHAR(F.FEC_VENCIMIE,'YYYYMMDDHH24MISS'),"); 
    strcat(szhQuery,"TO_CHAR(F.FEC_CADUCIDA,'YYYYMMDDHH24MISS'),");
    strcat(szhQuery,"F.NUM_SECUREL,");
    strcat(szhQuery,"F.LETRAREL,");
    strcat(szhQuery,"F.COD_TIPDOCUMREL,");
    strcat(szhQuery,"F.COD_VENDEDOR_AGENTEREL,");
    strcat(szhQuery,"F.COD_CENTRREL,");
    strcat(szhQuery,"F.NUM_VENTA,");
    strcat(szhQuery,"F.NUM_TRANSACCION,");
    strcat(szhQuery,"F.COD_MODVENTA,");
    strcat(szhQuery,"F.IND_FACTUR,");
    strcat(szhQuery,"F.NUM_PROCESO,");
    strcat(szhQuery,"F.PREF_PLAZA,"); /* jlr_11.10.03 */
    strcat(szhQuery,"F.COD_OPERADORA,"); /* jlr_11.10.03 */
    strcat(szhQuery,"F.COD_PLAZA,"); /* jlr_11.10.03 */

    ihCodTipDocum = stConfig.iCodTipDocum;
    sprintf(szhCodTipDocum,"%d",ihCodTipDocum);

    if( stConfig.bOptCodCicloFact ) /* 16-05-2000 >> !=0 : Caso que es Ciclo */
    {
        ihCodTipMovimien = stDatosGener.iCodCiclo;
        sprintf(szhCodTipMovimien,"%d ",ihCodTipMovimien);
        strcat(szhQuery,szhCodTipMovimien);
        
        strcat(szhQuery,",0 ");    /* 16-05-2000 >> Se agrega '1' como num_cuotas */
        strcat(szhQuery,",F.NOM_USUARORA "); /* GAC 08-08-2003 */

        strcat(szhQuery,"FROM ");

        lhCodCicloFact = stConfig.lCodCicloFact;
        sprintf(szhCodCicloFact,"%d ",lhCodCicloFact);

        /* Define tabla a utilizar */
        strcpy(szNomTablaCab,"FA_FACTDOCU_");
        strcat(szNomTablaCab,szhCodCicloFact);
        strcpy(szNomTablaDet,"FA_FACTCONC_");
        strcat(szNomTablaDet,szhCodCicloFact);
        strcat(szhQuery,szNomTablaCab);
        strcat(szhQuery," F ");

        /* Define query a utilizar */
        strcat(szhQuery,"WHERE  F.NUM_SECUENCI > 0 ");
        strcat(szhQuery," AND   F.COD_TIPDOCUM = ");
        strcat(szhQuery,szhCodTipDocum);
        strcat(szhQuery," AND   F.NUM_FOLIO > 0 ");
        strcat(szhQuery," AND   F.IND_PASOCOBRO = 0 ");
        strcat(szhQuery," AND   F.IND_ANULADA = 0 ");
    }
    else /*  NO CICLO */
    {
        strcat(szhQuery,"I.COD_TIPMOVIMIEN ");
        strcat(szhQuery,",F.NUM_CUOTAS ");    /* 16-05-2000 >> Se agrega num_cuotas de FA_FACTDOCU_NOCICLO */
        strcat(szhQuery,",F.NOM_USUARORA "); /* GAC 08-08-2003 */
        
        strcat(szhQuery,"FROM ");

        /* Define tabla a utilizar */
        strcpy(szNomTablaCab,"FA_FACTDOCU_NOCICLO ");
        strcpy(szNomTablaDet,"FA_FACTCONC_NOCICLO ");
        strcat(szhQuery,szNomTablaCab);
        strcat(szhQuery,"F, FA_INTERFACT I ");

vDTrazasLog (szExePasoC,"\n\n\t szNomTablaDet [%s] \n", LOG05, szNomTablaDet);

        /* ihCodEstaDocEnt = stInterProc.iCodEstaDocEnt; */
        ihCodEstaDocEnt = stIntQueueProc.iCodEstaDocEnt;
        sprintf(szhCodEstaDocEnt,"%3d\0",ihCodEstaDocEnt);
        sprintf(szhCodEstProcOk,"%1d\0",iProcTermOk);
        sprintf(szhCodModGener,"'%-3.3s'\0",stConfig.szCodModGener);

        /* Define query a utilizar */
        if (stConfig.bOptUnico)
        {
            strcat(szhQuery,"WHERE  I.NUM_PROCESO = ");
            strcat(szhQuery,stConfig.szNumProceso);
            strcat(szhQuery," AND   F.NUM_PROCESO = I.NUM_PROCESO ");
            strcat(szhQuery," AND   I.COD_ESTADOC = ");
            strcat(szhQuery,szhCodEstaDocEnt);
            strcat(szhQuery," AND   I.COD_ESTPROC = ");
            strcat(szhQuery,szhCodEstProcOk);
            strcat(szhQuery," AND   F.NUM_FOLIO > 0 ");
            strcat(szhQuery," AND   F.IND_PASOCOBRO = 0 ");
            strcat(szhQuery," AND   F.IND_ANULADA = 0 ");
        }
        else /* Batch , Online */
        {
            strcat(szhQuery,"WHERE  F.NUM_PROCESO = I.NUM_PROCESO ");
            strcat(szhQuery," AND   I.COD_ESTADOC = ");
            strcat(szhQuery,szhCodEstaDocEnt);
            strcat(szhQuery," AND   I.COD_ESTPROC = ");
            strcat(szhQuery,szhCodEstProcOk);
            strcat(szhQuery," AND   I.COD_MODGENER = ");
            strcat(szhQuery,szhCodModGener);
            strcat(szhQuery," AND   F.NUM_SECUENCI > 0 ");
            if (stConfig.bOptCodTipDocum)
            {
                strcat(szhQuery," AND   F.COD_TIPDOCUM = ");
                strcat(szhQuery,szhCodTipDocum);
            }
            strcat(szhQuery," AND   F.NUM_FOLIO > 0 ");
            strcat(szhQuery," AND   F.IND_PASOCOBRO = 0 ");
            strcat(szhQuery," AND   F.IND_ANULADA = 0 ");
        }
	} /* end if( stConfig.bOptCodCicloFact ) */
    
    vDTrazasLog(szExePasoC,"\n\t\t%s\n", LOG05,szhQuery);

    /* EXEC SQL PREPARE sql_query_cabecera FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )901;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
    sqlstm.sqhstl[0] = (unsigned long )2048;
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


    if (SQLCODE)
    {
        vDTrazasLog (szExePasoC,"\n\n\tERROR al PREPARAR QUERY en ifnDBOpenHistDocu\n", LOG05);
        return SQLCODE;
    }

    /* EXEC SQL DECLARE cursor_cabecera CURSOR FOR sql_query_cabecera; */ 

    if (SQLCODE)
    {
        vDTrazasLog (szExePasoC,"\n\n\tERROR al DECLARAR CURSOR en ifnDBOpenHistDocu\n", LOG05);
        return SQLCODE;
    }

    /* EXEC SQL OPEN cursor_cabecera; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )920;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
        vDTrazasLog (szExePasoC,"\n\n\tERROR al ABRIR CURSOR en ifnDBOpenHistDocu\n", LOG05);
        return SQLCODE;
    }
    
    return SQLCODE;

}/**************************** Final ifnDBOpenHistDocu ***********************/

/*****************************************************************************/
/*****************************************************************************/
static BOOL bfnDescargaDoctosInter( CONFIG stConfig )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char 	szhRowid[iMAXHOST][19];
	long 	lhNumSecuenci[iMAXHOST];
	int  	ihCodTipDocum[iMAXHOST];
	long 	lhCodVendedorAgente[iMAXHOST];
	char 	szhLetra[iMAXHOST][2];
	int  	ihCodCentrEmi[iMAXHOST];
	double 	dhTotFactura[iMAXHOST];
	long 	lhCodCliente[iMAXHOST];
	/*char 	szhFecEmision[iMAXHOST][15];Requerimiento de Soporte - 41321 - 07.06.2007 */
	char 	szhFecEmision[iMAXHOST][9];	
	char 	szhIndOrdenTotal[iMAXHOST][13];
	char 	szhNumCTC[iMAXHOST][13];
	short 	shIndSuperTel[iMAXHOST];
	long 	lhNumFolio[iMAXHOST];
	long 	lhCodPlanCom[iMAXHOST];
	/*char 	szhFecVencimie[iMAXHOST][15];
	char 	szhFecCaducida[iMAXHOST][15];Requerimiento de Soporte - 41321 - 07.06.2007 */
    char 	szhFecVencimie[iMAXHOST][9];
	char 	szhFecCaducida[iMAXHOST][9];	
	long 	lhNumSecuRel[iMAXHOST];
	char 	szhLetraRel[iMAXHOST][2];
	int 	ihCodTipDocumRel[iMAXHOST];
	long 	lhCodVendedorAgenteRel[iMAXHOST];
	int 	ihCodCentrRel[iMAXHOST];
	long 	lhNumVenta[iMAXHOST];
	long 	lhNumTransaccion[iMAXHOST];
	int 	ihCodModVenta[iMAXHOST];
	int 	ihIndFactur[iMAXHOST];
	long 	lhNumProceso[iMAXHOST];
	int 	ihCodTipMovimie[iMAXHOST];
	int 	ihNumCuotas[iMAXHOST]; 				/* 16-05-2000 >> Define num_cuotas, no define short porque esta definido not null */
	char  	szhNomUsuarORA[iMAXHOST][31];  /* GAC 08-08-2003 */
	short 	i_shFecVencimie[iMAXHOST];
	short 	i_shFecCaducida[iMAXHOST];
	short 	i_shNumSecuRel[iMAXHOST];
	short 	i_shLetraRel[iMAXHOST];
	short 	i_shCodTipDocumRel[iMAXHOST];
	short	i_shCodVendedorAgenteRel[iMAXHOST];
	short 	i_shCodCentrRel[iMAXHOST];
	short 	i_shNumVenta[iMAXHOST];
	short 	i_shNumTransaccion[iMAXHOST];
	short 	i_shCodModVenta[iMAXHOST];
	short 	i_shNumCTC[iMAXHOST];
	char 	szhPrefPlaza[iMAXHOST][26];      /* jlr_11.01.03 */
	char 	szhCodOperadoraScl[iMAXHOST][6];/* jlr_11.01.03 */
	char 	szhCodPlaza[iMAXHOST][6];       /* jlr_11.01.03 */
/* EXEC SQL END DECLARE SECTION; */ 

		
char 	szFuncion[30];
int 	j, iSQLCODEAUX = 0, iError = 0;
long 	lTotalRows     = 0, lRowsThisLoop = 0, lRowsProcessed = 0, lRow = 0;
		
	memset( szFuncion, '\0', sizeof( szFuncion ) );
		
	while( 1 )
	{
		/* EXEC SQL FETCH cursor_cabecera 
		INTO	:szhRowid                                       , 
				:lhNumSecuenci                                  ,
				:ihCodTipDocum                                  ,
				:lhCodVendedorAgente                            ,
				:szhLetra                                       ,
				:ihCodCentrEmi                                  ,
				:dhTotFactura                                   ,
				:lhCodCliente                                   ,
				:szhFecEmision                                  ,
				:szhIndOrdenTotal                               ,
				:shIndSuperTel                                  ,
				:lhNumFolio                                     ,
				:szhNumCTC             :i_shNumCTC              ,
				:szhFecVencimie        :i_shFecVencimie         ,
				:szhFecCaducida        :i_shFecCaducida         ,
				:lhNumSecuRel          :i_shNumSecuRel          ,  
				:szhLetraRel           :i_shLetraRel            ,
				:ihCodTipDocumRel      :i_shCodTipDocumRel      ,
				:lhCodVendedorAgenteRel:i_shCodVendedorAgenteRel,
				:ihCodCentrRel         :i_shCodCentrRel         ,
				:lhNumVenta            :i_shNumVenta            ,
				:lhNumTransaccion      :i_shNumTransaccion      ,
				:ihCodModVenta         :i_shCodModVenta         ,
				:ihIndFactur                                    ,
				:lhNumProceso                                   ,
				:szhPrefPlaza                                   , /o jlr_11.01.03 o/
				:szhCodOperadoraScl                             , /o jlr_11.01.03 o/
				:szhCodPlaza                                    , /o jlr_11.01.03 o/
				:ihCodTipMovimie                                ,
				:ihNumCuotas                                    , /o 16-05-2000 o/
				:szhNomUsuarORA	; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )10000;
  sqlstm.offset = (unsigned int  )935;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )19;
  sqlstm.sqhsts[0] = (         int  )19;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhNumSecuenci;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ihCodTipDocum;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)lhCodVendedorAgente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )2;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)ihCodCentrEmi;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )sizeof(int);
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqharc[5] = (unsigned long  *)0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)dhTotFactura;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[6] = (         int  )sizeof(double);
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqharc[6] = (unsigned long  *)0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)lhCodCliente;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )sizeof(long);
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqharc[7] = (unsigned long  *)0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhFecEmision;
  sqlstm.sqhstl[8] = (unsigned long )9;
  sqlstm.sqhsts[8] = (         int  )9;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqharc[8] = (unsigned long  *)0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhIndOrdenTotal;
  sqlstm.sqhstl[9] = (unsigned long )13;
  sqlstm.sqhsts[9] = (         int  )13;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqharc[9] = (unsigned long  *)0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)shIndSuperTel;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[10] = (         int  )sizeof(short);
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqharc[10] = (unsigned long  *)0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)lhNumFolio;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[11] = (         int  )sizeof(long);
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqharc[11] = (unsigned long  *)0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhNumCTC;
  sqlstm.sqhstl[12] = (unsigned long )13;
  sqlstm.sqhsts[12] = (         int  )13;
  sqlstm.sqindv[12] = (         short *)i_shNumCTC;
  sqlstm.sqinds[12] = (         int  )sizeof(short);
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqharc[12] = (unsigned long  *)0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhFecVencimie;
  sqlstm.sqhstl[13] = (unsigned long )9;
  sqlstm.sqhsts[13] = (         int  )9;
  sqlstm.sqindv[13] = (         short *)i_shFecVencimie;
  sqlstm.sqinds[13] = (         int  )sizeof(short);
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqharc[13] = (unsigned long  *)0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhFecCaducida;
  sqlstm.sqhstl[14] = (unsigned long )9;
  sqlstm.sqhsts[14] = (         int  )9;
  sqlstm.sqindv[14] = (         short *)i_shFecCaducida;
  sqlstm.sqinds[14] = (         int  )sizeof(short);
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqharc[14] = (unsigned long  *)0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)lhNumSecuRel;
  sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[15] = (         int  )sizeof(long);
  sqlstm.sqindv[15] = (         short *)i_shNumSecuRel;
  sqlstm.sqinds[15] = (         int  )sizeof(short);
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqharc[15] = (unsigned long  *)0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhLetraRel;
  sqlstm.sqhstl[16] = (unsigned long )2;
  sqlstm.sqhsts[16] = (         int  )2;
  sqlstm.sqindv[16] = (         short *)i_shLetraRel;
  sqlstm.sqinds[16] = (         int  )sizeof(short);
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqharc[16] = (unsigned long  *)0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)ihCodTipDocumRel;
  sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[17] = (         int  )sizeof(int);
  sqlstm.sqindv[17] = (         short *)i_shCodTipDocumRel;
  sqlstm.sqinds[17] = (         int  )sizeof(short);
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqharc[17] = (unsigned long  *)0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)lhCodVendedorAgenteRel;
  sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[18] = (         int  )sizeof(long);
  sqlstm.sqindv[18] = (         short *)i_shCodVendedorAgenteRel;
  sqlstm.sqinds[18] = (         int  )sizeof(short);
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqharc[18] = (unsigned long  *)0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)ihCodCentrRel;
  sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[19] = (         int  )sizeof(int);
  sqlstm.sqindv[19] = (         short *)i_shCodCentrRel;
  sqlstm.sqinds[19] = (         int  )sizeof(short);
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqharc[19] = (unsigned long  *)0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)lhNumVenta;
  sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[20] = (         int  )sizeof(long);
  sqlstm.sqindv[20] = (         short *)i_shNumVenta;
  sqlstm.sqinds[20] = (         int  )sizeof(short);
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqharc[20] = (unsigned long  *)0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)lhNumTransaccion;
  sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[21] = (         int  )sizeof(long);
  sqlstm.sqindv[21] = (         short *)i_shNumTransaccion;
  sqlstm.sqinds[21] = (         int  )sizeof(short);
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqharc[21] = (unsigned long  *)0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)ihCodModVenta;
  sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[22] = (         int  )sizeof(int);
  sqlstm.sqindv[22] = (         short *)i_shCodModVenta;
  sqlstm.sqinds[22] = (         int  )sizeof(short);
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqharc[22] = (unsigned long  *)0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)ihIndFactur;
  sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[23] = (         int  )sizeof(int);
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqharc[23] = (unsigned long  *)0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)lhNumProceso;
  sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[24] = (         int  )sizeof(long);
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqharc[24] = (unsigned long  *)0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
  sqlstm.sqhstv[25] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[25] = (unsigned long )26;
  sqlstm.sqhsts[25] = (         int  )26;
  sqlstm.sqindv[25] = (         short *)0;
  sqlstm.sqinds[25] = (         int  )0;
  sqlstm.sqharm[25] = (unsigned long )0;
  sqlstm.sqharc[25] = (unsigned long  *)0;
  sqlstm.sqadto[25] = (unsigned short )0;
  sqlstm.sqtdso[25] = (unsigned short )0;
  sqlstm.sqhstv[26] = (unsigned char  *)szhCodOperadoraScl;
  sqlstm.sqhstl[26] = (unsigned long )6;
  sqlstm.sqhsts[26] = (         int  )6;
  sqlstm.sqindv[26] = (         short *)0;
  sqlstm.sqinds[26] = (         int  )0;
  sqlstm.sqharm[26] = (unsigned long )0;
  sqlstm.sqharc[26] = (unsigned long  *)0;
  sqlstm.sqadto[26] = (unsigned short )0;
  sqlstm.sqtdso[26] = (unsigned short )0;
  sqlstm.sqhstv[27] = (unsigned char  *)szhCodPlaza;
  sqlstm.sqhstl[27] = (unsigned long )6;
  sqlstm.sqhsts[27] = (         int  )6;
  sqlstm.sqindv[27] = (         short *)0;
  sqlstm.sqinds[27] = (         int  )0;
  sqlstm.sqharm[27] = (unsigned long )0;
  sqlstm.sqharc[27] = (unsigned long  *)0;
  sqlstm.sqadto[27] = (unsigned short )0;
  sqlstm.sqtdso[27] = (unsigned short )0;
  sqlstm.sqhstv[28] = (unsigned char  *)ihCodTipMovimie;
  sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[28] = (         int  )sizeof(int);
  sqlstm.sqindv[28] = (         short *)0;
  sqlstm.sqinds[28] = (         int  )0;
  sqlstm.sqharm[28] = (unsigned long )0;
  sqlstm.sqharc[28] = (unsigned long  *)0;
  sqlstm.sqadto[28] = (unsigned short )0;
  sqlstm.sqtdso[28] = (unsigned short )0;
  sqlstm.sqhstv[29] = (unsigned char  *)ihNumCuotas;
  sqlstm.sqhstl[29] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[29] = (         int  )sizeof(int);
  sqlstm.sqindv[29] = (         short *)0;
  sqlstm.sqinds[29] = (         int  )0;
  sqlstm.sqharm[29] = (unsigned long )0;
  sqlstm.sqharc[29] = (unsigned long  *)0;
  sqlstm.sqadto[29] = (unsigned short )0;
  sqlstm.sqtdso[29] = (unsigned short )0;
  sqlstm.sqhstv[30] = (unsigned char  *)szhNomUsuarORA;
  sqlstm.sqhstl[30] = (unsigned long )31;
  sqlstm.sqhsts[30] = (         int  )31;
  sqlstm.sqindv[30] = (         short *)0;
  sqlstm.sqinds[30] = (         int  )0;
  sqlstm.sqharm[30] = (unsigned long )0;
  sqlstm.sqharc[30] = (unsigned long  *)0;
  sqlstm.sqadto[30] = (unsigned short )0;
  sqlstm.sqtdso[30] = (unsigned short )0;
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

 				  /* GAC 08-08-2003 */
		
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
		{
			strcpy( szFuncion, "Fetch Cursor cursor_cabecera" );
			iDError( szExePasoC, ERR000, vInsertarIncidencia, szFuncion, szfnORAerror() );
			iError = 1;
			break;
		}
		
		iSQLCODEAUX   = SQLCODE;
		lTotalRows 	  = SQLROWS;    /* Total de filas recuperadas */
       	lRowsThisLoop = ( lTotalRows - lRowsProcessed );    /* filas recuperadas en esta iteracion (Total-Procesadas) */
	
        vDTrazasLog( szExePasoC, "\tlTotalRows = [%d], lRowsThisLoop = [%d]\n\t", LOG03, lTotalRows, lRowsThisLoop );
	
		/* pasamos los clientes, a la estructura principal de trabajo */
		for( j = 0; j < lRowsThisLoop; j++ )
		{
			strcpy( stDoctosInter[lRow].szRowid, szhRowid[j] );
			stDoctosInter[lRow].lNumSecuenci 		= lhNumSecuenci[j];
			stDoctosInter[lRow].iCodTipDocum 		= ihCodTipDocum[j];
			stDoctosInter[lRow].lCodVendedorAgente 	= lhCodVendedorAgente[j];
			strcpy( stDoctosInter[lRow].szLetra, szhLetra[j] );
			stDoctosInter[lRow].iCodCentrEmi 		= ihCodCentrEmi[j];
			stDoctosInter[lRow].lCodCliente		 	= lhCodCliente[j];
			strcpy( stDoctosInter[lRow].szFecEmision, szhFecEmision[j] );
			strcpy( stDoctosInter[lRow].szIndOrdenTotal, szhIndOrdenTotal[j] );
			stDoctosInter[lRow].iIndSuperTel 		= shIndSuperTel[j];
			stDoctosInter[lRow].lNumFolio 			= lhNumFolio[j];
			strcpy( stDoctosInter[lRow].szFecVencimie, szhFecVencimie[j] );
			strcpy( stDoctosInter[lRow].szFecCaducida, szhFecCaducida[j] );
			stDoctosInter[lRow].lNumSecuRel 		= (i_shNumSecuRel[j] == ORA_NULL)?ORA_NULL: lhNumSecuRel[j];
			strcpy( stDoctosInter[lRow].szLetraRel, szhLetraRel[j] );
			stDoctosInter[lRow].iCodTipDocumRel 	= (i_shCodTipDocumRel[j] == ORA_NULL) ? ORA_NULL : ihCodTipDocumRel[j];
			stDoctosInter[lRow].lCodVendedorAgenteRel= (i_shCodVendedorAgenteRel[j] == ORA_NULL) ? ORA_NULL : lhCodVendedorAgenteRel[j];
			stDoctosInter[lRow].iCodCentrRel 		= (i_shCodCentrRel[j] == ORA_NULL) ? ORA_NULL : ihCodCentrRel[j];
			stDoctosInter[lRow].lNumVenta 			= (i_shNumVenta[j] == ORA_NULL) ? ORA_NULL : lhNumVenta[j];
			stDoctosInter[lRow].lNumTransaccion 	= (i_shNumTransaccion[j] == ORA_NULL) ? ORA_NULL : lhNumTransaccion[j];

			if( i_shNumCTC[j] == -1 )
				stDoctosInter[lRow].szNumCTC[0] = 0;
			else
				strcpy( stDoctosInter[lRow].szNumCTC, szhNumCTC[j] );

			stDoctosInter[lRow].iCodModVenta 	= (i_shCodModVenta[j] == ORA_NULL) ? ORA_NULL : ihCodModVenta[j];
			stDoctosInter[lRow].dTotFactura 	= dhTotFactura[j];
			stDoctosInter[lRow].iIndFactur 		= ihIndFactur[j];
			stDoctosInter[lRow].iCodTipMovimie 	= ihCodTipMovimie[j];
			stDoctosInter[lRow].lNumProceso 	= lhNumProceso[j];
			stDoctosInter[lRow].iIndPasoCobro 	= 0;
			stDoctosInter[lRow].iNumCuotas 		= ihNumCuotas[j];
			strcpy( stDoctosInter[lRow].szPrefPlaza, szhPrefPlaza[j] );            /* jlr_11.01.03 */
			strcpy( stDoctosInter[lRow].szCodOperadoraScl, szhCodOperadoraScl[j] );/* jlr_11.01.03 */
			strcpy( stDoctosInter[lRow].szCodPlaza, szhCodPlaza[j] );              /* jlr_11.01.03 */
			strcpy( stDoctosInter[lRow].szNomUsuarioORA,szhNomUsuarORA[j]);         /* GAC 08-08-2003 */

			/* quitamos de blanco las cadenas de caracteres a la derecha */
			rtrim( stDoctosInter[lRow].szRowid );
			rtrim( stDoctosInter[lRow].szLetra );
			rtrim( stDoctosInter[lRow].szFecEmision );
			rtrim( stDoctosInter[lRow].szIndOrdenTotal );
			rtrim( stDoctosInter[lRow].szFecVencimie );
			rtrim( stDoctosInter[lRow].szFecCaducida );
			rtrim( stDoctosInter[lRow].szLetraRel );
			rtrim( stDoctosInter[lRow].szNumCTC );
			rtrim( stDoctosInter[lRow].szPrefPlaza );      /* jlr_11.01.03 */
			rtrim( stDoctosInter[lRow].szCodOperadoraScl );/* jlr_11.01.03 */
			rtrim( stDoctosInter[lRow].szCodPlaza );       /* jlr_11.01.03 */
			rtrim( stDoctosInter[lRow].szNomUsuarioORA);   /* GAC 08-08-2003 */

			lRow++;
			
			/* controlamos el desbordamiento del arrglo */
			if( lRow >= iMAXARRAYWORK )
			{
		        vDTrazasLog( szExePasoC, "DEBE AUMENTAR LA CAPACIDAD DE ALMACENAMIENTO DEL ARREGLO DE TRABAJO\n\t", LOG01 );
				iError = 1;
				break;			
			} 
		} /* for( j = 0; j < lRowsThisLoop; j++ ) */

		if( iError )
			break;

       	lRowsProcessed = lTotalRows; /* Resetea Contador, Total las filas recuperadas se han procesado */
   		
       	vDTrazasLog( szExePasoC, "\tClientes revisados = [%d], Recuperados = [%d]\n\t", LOG03, lTotalRows, lRow );

   		if( iSQLCODEAUX == SQLNOTFOUND )
   		{
	       	vDTrazasLog( szExePasoC, "\tAlcanzando Fin de Datos cursor_cabecera\n\t", LOG03 );
   			break;
		}
	} /* while( 1 ) */

	if( ifnDBCloseHistDocu( stConfig ) )
		iError = 1;

	if( iError )
		return FALSE;
		
	glTotalDoctosInter = lRow;
	
	return TRUE;
}/********************* Final bfnDescargaDoctosInter *************************/

/*****************************************************************************/
/*****************************************************************************/
/*****************************************************************************/
/*                          funcion : ifnDBCloseHistDocu                     */
/* -Funcion que cierra el cursor abierto de Fa_HistDocu                      */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int ifnDBCloseHistDocu( CONFIG stConfig )
{
char szFuncion [30] = "";

  /* EXEC SQL CLOSE cursor_cabecera ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 31;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1074;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if( SQLCODE )
  {
      strcpy( szFuncion, "Close Cursor" );
      iDError( szExePasoC, ERR000, vInsertarIncidencia, szFuncion, szfnORAerror() ); 
  }

  return SQLCODE;

}/************************* Final ifnDBCloseHistDocu *************************/

/*****************************************************************************/
/*****************************************************************************/
static BOOL bfnCargaEstructuraWork( int lRow, DATOS_FACT *pstHistDocu )
{
	strcpy( pstHistDocu->szRowid	    ,	 stDoctosInter[lRow].szRowid );
	strcpy( pstHistDocu->szLetra        ,    stDoctosInter[lRow].szLetra );
	strcpy( pstHistDocu->szFecEmision   ,    stDoctosInter[lRow].szFecEmision );
	strcpy( pstHistDocu->szIndOrdenTotal,    stDoctosInter[lRow].szIndOrdenTotal );
	strcpy( pstHistDocu->szFecVencimie  ,    stDoctosInter[lRow].szFecVencimie );
	strcpy( pstHistDocu->szFecCaducida  ,    stDoctosInter[lRow].szFecCaducida );
	strcpy( pstHistDocu->szLetraRel     ,    stDoctosInter[lRow].szLetraRel );
	strcpy( pstHistDocu->szNumCTC       ,    stDoctosInter[lRow].szNumCTC );
	strcpy( pstHistDocu->szNomUsuarioORA,    stDoctosInter[lRow].szNomUsuarioORA);
	pstHistDocu->lNumSecuenci       =    stDoctosInter[lRow].lNumSecuenci;
	pstHistDocu->iCodTipDocum       =    stDoctosInter[lRow].iCodTipDocum;
	pstHistDocu->lCodVendedorAgente =    stDoctosInter[lRow].lCodVendedorAgente;
	pstHistDocu->iCodCentrEmi       =    stDoctosInter[lRow].iCodCentrEmi;
	pstHistDocu->dTotFactura        =    stDoctosInter[lRow].dTotFactura;
	pstHistDocu->lCodCliente        =    stDoctosInter[lRow].lCodCliente;
	pstHistDocu->iIndSuperTel       =    stDoctosInter[lRow].iIndSuperTel;
	pstHistDocu->lNumFolio          =    stDoctosInter[lRow].lNumFolio;
	pstHistDocu->iIndFactur         =    stDoctosInter[lRow].iIndFactur;
	pstHistDocu->iCodTipMovimie     =    stDoctosInter[lRow].iCodTipMovimie;
	pstHistDocu->lNumProceso        =    stDoctosInter[lRow].lNumProceso;
	pstHistDocu->iNumCuotas         =    stDoctosInter[lRow].iNumCuotas;
	pstHistDocu->lNumSecuRel        =    stDoctosInter[lRow].lNumSecuRel;
	pstHistDocu->iCodTipDocumRel    =    stDoctosInter[lRow].iCodTipDocumRel;
	pstHistDocu->lCodVendedorAgenteRel =  stDoctosInter[lRow].lCodVendedorAgenteRel;
	pstHistDocu->iCodCentrRel       =    stDoctosInter[lRow].iCodCentrRel;
	pstHistDocu->lNumVenta          =    stDoctosInter[lRow].lNumVenta;
	pstHistDocu->lNumTransaccion    =    stDoctosInter[lRow].lNumTransaccion;
	pstHistDocu->iCodModVenta       =    stDoctosInter[lRow].iCodModVenta;
	pstHistDocu->iIndPasoCobro      =    stDoctosInter[lRow].iIndPasoCobro;
	strcpy( pstHistDocu->szPrefPlaza      , stDoctosInter[lRow].szPrefPlaza );      /* jlr_11.01.03 */
	strcpy( pstHistDocu->szCodOperadoraScl, stDoctosInter[lRow].szCodOperadoraScl );/* jlr_11.01.03 */
	strcpy( pstHistDocu->szCodPlaza       , stDoctosInter[lRow].szCodPlaza );       /* jlr_11.01.03 */

	return TRUE;
}

/*****************************************************************************/
/*                          funcion : bfnDBCargaFactCobr                     */
/* -Funcion que carga la tabla Fa_FactCobr en memoria (tabla que relaciona   */
/*  los Conceptos de Facturacion y Cobros. La carga se hace sobre stFactCobr.*/
/* -Valores Retorno : Error->FALSE, !Error->TRUE.                            */
/*****************************************************************************/
static BOOL bfnDBCargaFactCobr (COFACTCOBR *pstFactCobr)
{
   	/* int iNumReg = 0;Requerimiento de Soporte - 41321 - 07.06.2007 */
    long iNumReg = 0;
    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static int ihCodConcFact;
   	static int ihCodConcCobr;
/* EXEC SQL END DECLARE SECTION; */ 


   	/* EXEC SQL DECLARE Cur_FactCobr CURSOR FOR
   	SELECT /o+ full (FA_FACTCOBR) o/
          	COD_CONCFACT,
          	COD_CONCCOBR
   	FROM   FA_FACTCOBR; */ 


   	/* EXEC SQL OPEN Cur_FactCobr; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 31;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0031;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1089;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   	if (SQLCODE)
   	{
       iDError (szExePasoC,ERR000,vInsertarIncidencia,"Open:Fa_FactCobr=>", szfnORAerror ());
       return  FALSE            ;
   	}

   	while (SQLCODE == SQLOK)
   	{
      	/* EXEC SQL FETCH Cur_FactCobr INTO :ihCodConcFact,
                                       	 :ihCodConcCobr; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 31;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )1104;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqfoff = (         int )0;
       sqlstm.sqfmod = (unsigned int )2;
       sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcFact;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcCobr;
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



		if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      	{
      		iDError (szExePasoC,ERR000,vInsertarIncidencia, "Fetch:Fa_FactCobr=>",szfnORAerror());
      	}

      	if (SQLCODE == SQLOK)
      	{
      		iNumReg = pstFactCobr->iNumReg;

            if ((pstFactCobr->pFacCob = 
                (REGFACTCOBR *)realloc ((REGFACTCOBR *)pstFactCobr->pFacCob,
                (iNumReg+1)*sizeof(REGFACTCOBR)))==(REGFACTCOBR *)NULL)
            {
            	iDError (szExePasoC,ERR005,vInsertarIncidencia, "stFactCobr.pFacCob");
                return  FALSE;
            }
            else
            {
            	pstFactCobr->pFacCob[iNumReg].iCodConcFact = ihCodConcFact;
                pstFactCobr->pFacCob[iNumReg].iCodConcCobr = ihCodConcCobr;
                pstFactCobr->iNumReg++                                    ;
            }
		} 

	}/* fin While ... */

   	if (SQLCODE == SQLNOTFOUND)
   	{
    	/* EXEC SQL CLOSE Cur_FactCobr; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 31;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1127;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


       	if (SQLCODE)
           iDError(szExePasoC,ERR000,vInsertarIncidencia,"Close:Fa_FactCobr=>", szfnORAerror());
   	}
   	vDTrazasLog (szExeName, "\n\t\t* Registros Cargados de Fa_FactCobr [%d]\n",LOG05, pstFactCobr->iNumReg); 

   	return (SQLCODE != SQLOK)?FALSE:TRUE;

}/************************* Final bfnDBCargaFactCobr *************************/


/*****************************************************************************/
/*                         funcion : bfnDBCargaHistConc                      */
/* -Funcion que carga todos los conceptos de una Factura (Fa_HistConc)       */
/* -El Campo IndOrdenTotal identifica dicha Factura.                         */
/*  El puntero pstHistConcP se carga los conceptos de Fa_HistConc para esa   */
/*  Factura, pstAcumAbo se van agrupando por abonado y producto los concep-  */
/*  tos de Facturacion que se trasforman en un Concepto de Cobros, con dos   */
/*  observaciones :                                                          */
/*     1.-  No se recogen los Conceptos Recargos ya que son generados por el */
/*        modulo de Cobros.                                                  */
/*     2.-  En el caso de ser parte de una Cuota el Concepto de Facturacion  */
/*        la relacion con los conceptos de Cobros es uno a uno y no se acumu-*/
/*        la, y se informa el SeqCuota y OrdCuota.                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
/*static BOOL bfnDBCargaHistConc(	char *szIndOrdenTotal, HISTCONCP *pstHistConcP, ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos )  Requerimiento de Soporte - 41321 - 07.06.2007 */
static BOOL bfnDBCargaHistConc(	char *szIndOrdenTotal, HISTCONCPAUX *pstHistConcP, ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos )
{
int iRes    = 0;
BOOL bOk    = TRUE;
/***int iNumReg = 0, iErrorNeg = 0;  Requerimiento de Soporte - 41321 - 07.06.2007 */
long iNumReg   = 0;
int  iErrorNeg = 0;
	
	if( ifnDBOpenHistConc( szIndOrdenTotal ) )
		return FALSE;
	
	while (bOk)
	{
        /* iNumReg = pstHistConcP->iNumReg;  Requerimiento de Soporte - 41321 - 07.06.2007 */
		iRes = ifnDBFetchHistConc( &pstHistConcP->stHistConc, iNumReg );
		switch( iRes )
		{
			case SQLOK :
				if( !bfnAcumulaAboProd( iNumReg, &( pstHistConcP->stHistConc ), pstAcumAbo, pstFactCobr ) )
				{
					/* vDTrazasLog( szExePasoC, "\nError en Funcion bfnAcumulaAboProd.", LOG02, pstHistConcP->iNumReg );Requerimiento de Soporte - 41321 - 07.06.2007 */
					vDTrazasLog( szExePasoC, "\nError en Funcion bfnAcumulaAboProd.", LOG02);
					return FALSE;
				}	
				
                /* pstHistConcP->iNumReg++; Requerimiento de Soporte - 41321 - 07.06.2007 */
				break;
			default    :
				bOk = FALSE;
				break;
		}
	}/* fin while bOk */
	
	if( iRes == SQLNOTFOUND )
	{
		vDTrazasLog( szExePasoC, "\n\t\t=> Numero de Conceptos [%d]", LOG04, pstHistConcP->iNumReg );
		vfnPrintAcumAbo( pstAcumAbo, &iErrorNeg );
		
		if( ifnDBCloseHistConc() )
			return FALSE;
		
		if( iErrorNeg ) /* si hay conceptos negativos */
			*bConcepNegativos = TRUE;
	}
	
	return TRUE;

}/************************** Final bfnDBCargaHistConc ************************/

/*****************************************************************************/
/*                        funcion : vfnPrintAcumAbo                          */
/*****************************************************************************/
static BOOL vfnPrintAcumAbo( ACUMABO *pstAcumAbo, int *iErrorNeg )
{
/**int i = 0;
   int j = 0;  Requerimiento de Soporte - 41321 - 07.06.2007 */
long i = 0;
long j = 0;

	lTotalConcCartera= 0;
	vDTrazasLog( szExePasoC, "\n\t\t*** Acumulados por Abonado-Producto ***"
							 "\n\t\t=> Numero de Registros [%d]            ", LOG04, pstAcumAbo->iNumReg );
	
	for( i = 0; i < pstAcumAbo->iNumReg; i++ )
	{
		vDTrazasLog( szExePasoC, "\t\t[%d]-Num.Abonado  [%ld]", LOG04, i,pstAcumAbo->pAboCobr[i].lNumAbonado  );
		vDTrazasLog( szExePasoC, "\t\t[%d]-Cod.Producto [%d] ", LOG04, i,pstAcumAbo->pAboCobr[i].iCodProducto );
		vDTrazasLog( szExePasoC, "\t\t[%d]-Num.Conceptos[%d]\n",LOG04, i,pstAcumAbo->pAboCobr[i].iNumConceptos );		

		for( j = 0; j < pstAcumAbo->pAboCobr[i].iNumConceptos; j++ )
		{
			vDTrazasLog( szExePasoC, "\t\t\t[%d]-Cod.ConcCobr  [%d]"  , LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].iCodConcCobr );
			/*vDTrazasLog( szExePasoC, "\t\t\t[%d]-Imp.ConcCobr  [%f]", LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr );*/
			/*vDTrazasLog( szExePasoC, "\t\t\t[%d]-Imp.ConcCobr  [%f]", LOG04, j,fnCnvDouble(pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr,4) ); 28-12-2004 Homolog TM-0496_2 GAC*/
			vDTrazasLog( szExePasoC, "\t\t\t[%d]-Imp.ConcCobr  [%f]"  , LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr); /*GAC 22-06-2205 Homol. a TM-200505251430 27.05.2005 Soporte RyC CAPC*/
			vDTrazasLog( szExePasoC, "\t\t\t[%d]-Seq.Cuotas    [%d]"  , LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].lSeqCuotas );
			vDTrazasLog( szExePasoC, "\t\t\t[%d]-Ord.Cuota     [%d]\n", LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].iOrdCuota );
			vDTrazasLog( szExePasoC, "\t\t\t[%d]-Ind.Factur    [%d]\n", LOG04, j,pstAcumAbo->pAboCobr[i].pConcCobr[j].iIndFactur );

			/*if( pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr < 0 )  conceptos negativos */
			/*if( fnCnvDouble(pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr,4) < 0 ) 28-12-2004 Homolog TM-0496_2 GAC*/
			/*GAC 22-06-2205 Homol. a TM-200505251430 27.05.2005 Soporte RyC CAPC
	        Mejora para la validación de valores negativos en los conceptos facturables agrupados por abonado*/
			if( pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr < -0.01 ) /* conceptos negativos */
			{
				vDTrazasLog( szExePasoC, "ATENCION => Documento presenta CONCEPTOS NEGATIVOS", LOG01 );
				*iErrorNeg = 1;
			}
	
			if( pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr > 0.00 ) /* conceptos contabilizables  */
			{
				lTotalConcCartera++;		
			}
		}/* fin for j ... */
	}/* fin for i ... */

	vDTrazasLog( szExePasoC, "\t\t[%ld]- Total de Documentos en Cartera ", LOG03, lTotalConcCartera );
	return TRUE;	

}/************************** Final vfnPrintAcumAbo ***************************/

/*****************************************************************************/
/*                          funcion : ifnDBOpenHistConc                      */
/* -Funcion que abre el Cursor sobre Fa_HistConc para una factura determinada*/
/*  ,definida por el IndOrdenTotal.                                          */
/* -Valores Retorno : SQLCODE.                                               */
/*****************************************************************************/
static int ifnDBOpenHistConc (char *szIndOrdenTotal)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	/*static char szhQuery [500];EXEC SQL VAR szhQuery IS STRING(500);*/
	static char szhQuery [1024];/* EXEC SQL VAR szhQuery IS STRING(1024); */ 
	/*XO-200507290237 Soporte RyC capc 02-08-2005*/	
	static char szhIndOrdenTotal[13]; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13); */ 

/* EXEC SQL END DECLARE SECTION; */ 

	
	memset(szhIndOrdenTotal, 0, sizeof(szhIndOrdenTotal)); /*XO-200507290237 Soporte RyC capc 02-08-2005*/
	
	strcpy (szhIndOrdenTotal, szIndOrdenTotal);
	
	strcpy(szhQuery,"SELECT TO_CHAR(IND_ORDENTOTAL),");
	strcat(szhQuery,"COD_CONCEPTO,");
	strcat(szhQuery,"COLUMNA,");
	strcat(szhQuery,"COD_MONEDA,");
	strcat(szhQuery,"COD_PRODUCTO,");
	strcat(szhQuery,"COD_TIPCONCE,");
	strcat(szhQuery,"TO_CHAR(FEC_VALOR      ,'YYYYMMDDHH24MISS'),");
	strcat(szhQuery,"TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS'),");
	strcat(szhQuery,"IMP_CONCEPTO,");
	strcat(szhQuery,"COD_REGION,");
	strcat(szhQuery,"COD_PROVINCIA,");
	strcat(szhQuery,"COD_CIUDAD,");
	strcat(szhQuery,"IMP_MONTOBASE,");
	strcat(szhQuery,"IND_FACTUR,");
	strcat(szhQuery,"IMP_FACTURABLE,");
	strcat(szhQuery,"IND_SUPERTEL,");
	strcat(szhQuery,"NUM_ABONADO,");
	strcat(szhQuery,"COD_PORTADOR,");
	strcat(szhQuery,"DES_CONCEPTO,");
	strcat(szhQuery,"SEQ_CUOTAS,");
	strcat(szhQuery,"NUM_CUOTAS,");
	strcat(szhQuery,"ORD_CUOTA,");
	strcat(szhQuery,"NUM_UNIDADES,");
	strcat(szhQuery,"NUM_SERIEMEC,");
	strcat(szhQuery,"NUM_SERIELE,");
	strcat(szhQuery,"PRC_IMPUESTO,");
	strcat(szhQuery,"VAL_DTO,");
	strcat(szhQuery,"TIP_DTO,");
	strcat(szhQuery,"MES_GARANTIA,");
	strcat(szhQuery,"TO_CHAR (NUM_GUIA),");
	strcat(szhQuery,"IND_ALTA,");
	strcat(szhQuery,"NUM_PAQUETE,");
	strcat(szhQuery,"FLAG_IMPUES,");
	strcat(szhQuery,"FLAG_DTO,");
	strcat(szhQuery,"IND_FACTUR,");
	strcat(szhQuery,"COD_CONCEREL,");
	strcat(szhQuery,"COLUMNA_REL ");
	strcat(szhQuery,"FROM ");
	strcat(szhQuery,szNomTablaDet);
	strcat(szhQuery," WHERE IND_ORDENTOTAL = ");
	strcat(szhQuery,szhIndOrdenTotal);
	strcat(szhQuery," ORDER BY COLUMNA_REL");
	
	/* EXEC SQL PREPARE sql_query_detalle FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1142;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
	{
		vDTrazasLog (szExePasoC,"\n\n\tERROR al PREPARAR QUERY en ifnDBOpenHistConc\n", LOG05);
		return SQLCODE;
	}
	/* EXEC SQL DECLARE cursor_detalle CURSOR FOR sql_query_detalle; */ 

	if (SQLCODE)
	{
		vDTrazasLog (szExePasoC,"\n\n\tERROR al DECLARAR CURSOR en ifnDBOpenHistConc\n", LOG05);
		return SQLCODE;
	}
	vDTrazasLog (szExePasoC, "\n\t\t* Parametros Entra Open Fa_HistConc"
							 "\n\t\t=>Ind.OrdenTotal  [%s]",LOG04,szIndOrdenTotal);
	
	/* EXEC SQL OPEN cursor_detalle; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 31;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1161;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE)
		iDError (szExePasoC,ERR000,vInsertarIncidencia,"Open Fa_HistConc", szfnORAerror ());
		
	return SQLCODE; 

}/************************* Final ifnDBOpenHistConc **************************/


/*****************************************************************************/
/*                          funcion : ifnDBFetchHistConc                     */
/* -Funcion que hace un Fetch sobre Fa_HistConc.                             */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
/*static int ifnDBFetchHistConc (HISTCONC *pstHistConc, int       iNumReg)  Requerimiento de Soporte - 41321 - 07.06.2007 */
static int ifnDBFetchHistConc (HISTCONCAUX *pstHistConc, long      iNumReg)
{
   /* EXEC SQL BEGIN DECLARE SECTION ; */ 

   static char  *szhIndOrdenTotal ;/* EXEC SQL VAR szhIndOrdenTotal  IS STRING(13); */ 

   static int    ihCodConcepto    ;
   static long   lhColumna        ;
   static char  *szhCodMoneda     ;/* EXEC SQL VAR szhCodMoneda      IS STRING(4) ; */ 

   static int    ihCodProducto    ;
   static int    ihCodTipConce    ;
   /*static char  *szhFecValor      ;EXEC SQL VAR szhFecValor       IS STRING(15);
   static char  *szhFecEfectividad;EXEC SQL VAR szhFecEfectividad IS STRING(15);*/
   static char  *szhFecValor      ;/* EXEC SQL VAR szhFecValor       IS STRING(9); */ 
 /* Requerimiento de Soporte - 41321 - 07.06.2007 */
   static char  *szhFecEfectividad;/* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 
 /* Requerimiento de Soporte - 41321 - 07.06.2007 */
   static double dhImpConcepto    ;
   static char  *szhCodRegion     ;/* EXEC SQL VAR szhCodRegion      IS STRING(4) ; */ 

   static char  *szhCodProvincia  ;/* EXEC SQL VAR szhCodProvincia   IS STRING(6) ; */ 

   static char  *szhCodCiudad     ;/* EXEC SQL VAR szhCodCiudad      IS STRING(6) ; */ 

   static double dhImpMontoBase   ;
   static short  shIndFactur      ;
   static double dhImpFacturable  ;
   static short  shIndSuperTel    ;
   static long   lhNumAbonado     ;
   static int    ihCodPortador    ;
   static char  *szhDesConcepto   ;/* EXEC SQL VAR szhDesConcepto    IS STRING(61); */ 

   static long   lhSeqCuotas      ;
   static int    ihNumCuotas      ;
   static int    ihOrdCuota       ;
   static long   lhNumUnidades    ;
   static char  *szhNumSerieMec   ;/* EXEC SQL VAR szhNumSerieMec    IS STRING(26); */ 
 /* jlr 10.01.03 GSM */
   static char  *szhNumSerieLe    ;/* EXEC SQL VAR szhNumSerieLe     IS STRING(26); */ 

   static float  fhPrcImpuesto    ;
   static double dhValDto         ;
   static short  shTipDto         ;
   static int    ihMesGarantia    ;
   static char  *szhNumGuia       ;/* EXEC SQL VAR szhNumGuia        IS STRING(11); */ 

   static short  shIndAlta        ;
   static int    ihNumPaquete     ;
   static short  shFlagImpues     ;
   static short  shFlagDto        ;
   static int    ihCodConceRel    ;
   static long   lhColumnaRel     ;
   static int    ihIndFactur      ;
   static short  i_shSeqCuotas    ;
   static short  i_shNumCuotas    ;
   static short  i_shOrdCuota     ;
   static short  i_shNumUnidades  ;
   static short  i_shNumSerieMec  ;
   static short  i_shNumSerieLe   ;
   static short  i_shPrcImpuesto  ;
   static short  i_shValDto       ;
   static short  i_shTipDto       ;
   static short  i_shMesGarantia  ;
   static short  i_shNumGuia      ;
   static short  i_shIndAlta      ;
   static short  i_shNumPaquete   ;
   static short  i_shFlagImpues   ;
   static short  i_shFlagDto      ;
   static short  i_shCodConceRel  ;
   static short  i_shColumnaRel   ; 
/* EXEC SQL END DECLARE SECTION; */ 

	CONCEPTO stConcepto;

   	szhIndOrdenTotal = pstHistConc->szIndOrdenTotal [iNumReg];
   	szhCodMoneda     = pstHistConc->szCodMoneda     [iNumReg];
   	szhFecValor      = pstHistConc->szFecValor      [iNumReg];
   	szhFecEfectividad= pstHistConc->szFecEfectividad[iNumReg];
   	szhCodRegion     = pstHistConc->szCodRegion     [iNumReg];
   	szhCodProvincia  = pstHistConc->szCodProvincia  [iNumReg];
   	szhCodCiudad     = pstHistConc->szCodCiudad     [iNumReg];
   	szhDesConcepto   = pstHistConc->szDesConcepto   [iNumReg];
   	szhNumSerieMec   = pstHistConc->szNumSerieMec   [iNumReg];
   	szhNumSerieLe    = pstHistConc->szNumSerieLe    [iNumReg];
   	szhNumGuia       = pstHistConc->szNumGuia       [iNumReg];
 
   	/* EXEC SQL FETCH cursor_detalle 
            INTO  :szhIndOrdenTotal              ,
                  :ihCodConcepto                 ,
                  :lhColumna                     ,
                  :szhCodMoneda                  ,
                  :ihCodProducto                 ,
                  :ihCodTipConce                 ,
                  :szhFecValor                   ,
                  :szhFecEfectividad             ,
                  :dhImpConcepto                 ,
                  :szhCodRegion                  ,
                  :szhCodProvincia               ,
                  :szhCodCiudad                  ,
                  :dhImpMontoBase                ,
                  :shIndFactur                   ,
                  :dhImpFacturable               ,
                  :shIndSuperTel                 ,
                  :lhNumAbonado                  ,
                  :ihCodPortador                 ,
                  :szhDesConcepto                ,
                  :lhSeqCuotas:i_shSeqCuotas     ,
                  :ihNumCuotas:i_shNumCuotas     ,  
                  :ihOrdCuota:i_shOrdCuota       , 
                  :lhNumUnidades:i_shNumUnidades ,
                  :szhNumSerieMec:i_shNumSerieMec,
                  :szhNumSerieLe:i_shNumSerieLe  ,
                  :fhPrcImpuesto:i_shPrcImpuesto ,
                  :dhValDto:i_shValDto           ,
                  :shTipDto:i_shTipDto           ,
                  :ihMesGarantia:i_shMesGarantia ,
                  :szhNumGuia:i_shNumGuia        ,
                  :shIndAlta:i_shIndAlta         ,
                  :ihNumPaquete:i_shNumPaquete   ,
                  :shFlagImpues:i_shFlagImpues   ,
                  :shFlagDto:i_shFlagDto         ,
                  :ihIndFactur                   ,
                  :ihCodConceRel:i_shCodConceRel ,
                  :lhColumnaRel:i_shColumnaRel; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 37;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1176;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIndOrdenTotal;
    sqlstm.sqhstl[0] = (unsigned long )13;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhColumna;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodMoneda;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodProducto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecValor;
    sqlstm.sqhstl[6] = (unsigned long )9;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecEfectividad;
    sqlstm.sqhstl[7] = (unsigned long )9;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhImpConcepto;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhCodRegion;
    sqlstm.sqhstl[9] = (unsigned long )4;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhCodProvincia;
    sqlstm.sqhstl[10] = (unsigned long )6;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhCodCiudad;
    sqlstm.sqhstl[11] = (unsigned long )6;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&dhImpMontoBase;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&shIndFactur;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&dhImpFacturable;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&shIndSuperTel;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihCodPortador;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhDesConcepto;
    sqlstm.sqhstl[18] = (unsigned long )61;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&lhSeqCuotas;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)&i_shSeqCuotas;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&ihNumCuotas;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)&i_shNumCuotas;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&ihOrdCuota;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)&i_shOrdCuota;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&lhNumUnidades;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)&i_shNumUnidades;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhNumSerieMec;
    sqlstm.sqhstl[23] = (unsigned long )26;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)&i_shNumSerieMec;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)szhNumSerieLe;
    sqlstm.sqhstl[24] = (unsigned long )26;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)&i_shNumSerieLe;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)&fhPrcImpuesto;
    sqlstm.sqhstl[25] = (unsigned long )sizeof(float);
    sqlstm.sqhsts[25] = (         int  )0;
    sqlstm.sqindv[25] = (         short *)&i_shPrcImpuesto;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)&dhValDto;
    sqlstm.sqhstl[26] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[26] = (         int  )0;
    sqlstm.sqindv[26] = (         short *)&i_shValDto;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)&shTipDto;
    sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[27] = (         int  )0;
    sqlstm.sqindv[27] = (         short *)&i_shTipDto;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)&ihMesGarantia;
    sqlstm.sqhstl[28] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[28] = (         int  )0;
    sqlstm.sqindv[28] = (         short *)&i_shMesGarantia;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
    sqlstm.sqhstv[29] = (unsigned char  *)szhNumGuia;
    sqlstm.sqhstl[29] = (unsigned long )11;
    sqlstm.sqhsts[29] = (         int  )0;
    sqlstm.sqindv[29] = (         short *)&i_shNumGuia;
    sqlstm.sqinds[29] = (         int  )0;
    sqlstm.sqharm[29] = (unsigned long )0;
    sqlstm.sqadto[29] = (unsigned short )0;
    sqlstm.sqtdso[29] = (unsigned short )0;
    sqlstm.sqhstv[30] = (unsigned char  *)&shIndAlta;
    sqlstm.sqhstl[30] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[30] = (         int  )0;
    sqlstm.sqindv[30] = (         short *)&i_shIndAlta;
    sqlstm.sqinds[30] = (         int  )0;
    sqlstm.sqharm[30] = (unsigned long )0;
    sqlstm.sqadto[30] = (unsigned short )0;
    sqlstm.sqtdso[30] = (unsigned short )0;
    sqlstm.sqhstv[31] = (unsigned char  *)&ihNumPaquete;
    sqlstm.sqhstl[31] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[31] = (         int  )0;
    sqlstm.sqindv[31] = (         short *)&i_shNumPaquete;
    sqlstm.sqinds[31] = (         int  )0;
    sqlstm.sqharm[31] = (unsigned long )0;
    sqlstm.sqadto[31] = (unsigned short )0;
    sqlstm.sqtdso[31] = (unsigned short )0;
    sqlstm.sqhstv[32] = (unsigned char  *)&shFlagImpues;
    sqlstm.sqhstl[32] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[32] = (         int  )0;
    sqlstm.sqindv[32] = (         short *)&i_shFlagImpues;
    sqlstm.sqinds[32] = (         int  )0;
    sqlstm.sqharm[32] = (unsigned long )0;
    sqlstm.sqadto[32] = (unsigned short )0;
    sqlstm.sqtdso[32] = (unsigned short )0;
    sqlstm.sqhstv[33] = (unsigned char  *)&shFlagDto;
    sqlstm.sqhstl[33] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[33] = (         int  )0;
    sqlstm.sqindv[33] = (         short *)&i_shFlagDto;
    sqlstm.sqinds[33] = (         int  )0;
    sqlstm.sqharm[33] = (unsigned long )0;
    sqlstm.sqadto[33] = (unsigned short )0;
    sqlstm.sqtdso[33] = (unsigned short )0;
    sqlstm.sqhstv[34] = (unsigned char  *)&ihIndFactur;
    sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[34] = (         int  )0;
    sqlstm.sqindv[34] = (         short *)0;
    sqlstm.sqinds[34] = (         int  )0;
    sqlstm.sqharm[34] = (unsigned long )0;
    sqlstm.sqadto[34] = (unsigned short )0;
    sqlstm.sqtdso[34] = (unsigned short )0;
    sqlstm.sqhstv[35] = (unsigned char  *)&ihCodConceRel;
    sqlstm.sqhstl[35] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[35] = (         int  )0;
    sqlstm.sqindv[35] = (         short *)&i_shCodConceRel;
    sqlstm.sqinds[35] = (         int  )0;
    sqlstm.sqharm[35] = (unsigned long )0;
    sqlstm.sqadto[35] = (unsigned short )0;
    sqlstm.sqtdso[35] = (unsigned short )0;
    sqlstm.sqhstv[36] = (unsigned char  *)&lhColumnaRel;
    sqlstm.sqhstl[36] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[36] = (         int  )0;
    sqlstm.sqindv[36] = (         short *)&i_shColumnaRel;
    sqlstm.sqinds[36] = (         int  )0;
    sqlstm.sqharm[36] = (unsigned long )0;
    sqlstm.sqadto[36] = (unsigned short )0;
    sqlstm.sqtdso[36] = (unsigned short )0;
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



	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
   	{
    	iDError (szExePasoC,ERR000,vInsertarIncidencia,"Fetch:Fa_HistConc=>", szfnORAerror ());
   	}

   	if (SQLCODE == SQLOK)
   	{
       	pstHistConc->iCodConcepto  [iNumReg] = ihCodConcepto  ;
       	pstHistConc->lColumna      [iNumReg] = lhColumna      ;
       	pstHistConc->iCodProducto  [iNumReg] = ihCodProducto  ;
       	pstHistConc->iCodTipConce  [iNumReg] = ihCodTipConce  ;
       	pstHistConc->dImpConcepto  [iNumReg] = dhImpConcepto  ;
       	pstHistConc->dImpMontoBase [iNumReg] = dhImpMontoBase ;
       	pstHistConc->iIndFactur    [iNumReg] = shIndFactur    ;
       	pstHistConc->dImpFacturable[iNumReg] = dhImpFacturable;
       	pstHistConc->iIndSuperTel  [iNumReg] = shIndSuperTel  ;
       	pstHistConc->lNumAbonado   [iNumReg] = (lhNumAbonado == ORA_NULL ? 0 : lhNumAbonado);
       	pstHistConc->iCodPortador  [iNumReg] = ihCodPortador  ;
       	pstHistConc->lSeqCuotas    [iNumReg] = (i_shSeqCuotas   == -1)?-1:lhSeqCuotas  ;
       	pstHistConc->iNumCuotas    [iNumReg] = (i_shNumCuotas   == -1)?-1:ihNumCuotas  ;
       	pstHistConc->iOrdCuota     [iNumReg] = (i_shOrdCuota    == -1)?-1:ihOrdCuota   ;
       	pstHistConc->lNumUnidades  [iNumReg] = (i_shNumUnidades == -1)?-1:lhNumUnidades;
       	pstHistConc->fPrcImpuesto  [iNumReg] = (i_shPrcImpuesto == -1)?-1:fhPrcImpuesto;
       	pstHistConc->dValDto       [iNumReg] = (i_shValDto      == -1)?-1:dhValDto     ;
       	pstHistConc->iTipDto       [iNumReg] = (i_shTipDto      == -1)?-1:shTipDto     ;
       	pstHistConc->iMesGarantia  [iNumReg] = (i_shMesGarantia == -1)?-1:ihMesGarantia;
       	pstHistConc->iIndAlta      [iNumReg] = (i_shIndAlta     == -1)?-1:shIndAlta    ;
       	pstHistConc->iNumPaquete   [iNumReg] = (i_shNumPaquete  == -1)?-1:ihNumPaquete ;
       	pstHistConc->iFlagImpues   [iNumReg] = (i_shFlagImpues  == -1)?-1:shFlagImpues ;
       	pstHistConc->iFlagDto      [iNumReg] = (i_shFlagDto     == -1)?-1:shFlagDto    ;
       	pstHistConc->iCodConceRel  [iNumReg] = (i_shCodConceRel == -1)?-1:ihCodConceRel;
       	pstHistConc->lColumnaRel   [iNumReg] = (i_shColumnaRel  == -1)?-1:lhColumnaRel ;

       	pstHistConc->iIndFactur    [iNumReg] = ihIndFactur    ;

       	if (i_shNumSerieMec == ORA_NULL)
           pstHistConc->szNumSerieMec[iNumReg][0] = 0;

       	if (i_shNumSerieLe  == ORA_NULL)
           pstHistConc->szNumSerieLe [iNumReg][0] = 0;

       	if (i_shNumGuia     == ORA_NULL)
           pstHistConc->szNumGuia    [iNumReg][0] = 0;

       	if ( ihCodProducto == stDatosGener.iProdGeneral )
       	{
        	if ( !bFindConcepto(ihCodConcepto,&stConcepto) )
        	{
                iDError (szExePasoC,ERR000,vInsertarIncidencia, "Error en bFindConcepto", szfnORAerror ());
        	}
        	else
        	{
            	pstHistConc->iCodProducto  [iNumReg] = stConcepto.iCodProducto;
       	 	}
    	}
   	}   

	return SQLCODE; 

}/************************** Final ifnDBFetchHistConc ************************/

/*****************************************************************************/
/*                           funcion : ifnDBCloseHistConc                    */
/* -Funcion que cierra el Cusor : cursor_detalle (Fa_HistConc)                 */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int ifnDBCloseHistConc (void)
{
	/* EXEC SQL CLOSE cursor_detalle; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1339;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  	if (SQLCODE)
      iDError (szExePasoC,ERR000,vInsertarIncidencia,"Close:Fa_HistConc=>", szfnORAerror ());

  	return SQLCODE;

}/************************** Final ifnDBCloseHistConc ************************/

/*****************************************************************************/
/*                        funcion : bfnAcumulaAboProd                        */
/* -Funcion que agrupa los varios conceptos iguales de Facturacion en un uni-*/
/*  co concepto de Cobro, por Abonado y Producto, (desglosandolo en factura- */
/*  ble o no).                                                               */ 
/* -Observacion :                                                            */
/*        1.- En el caso que el Concepto de Facturacion sea un Recargo.      */
/*        2.- En el caso que sea un Concepto incorporado a una Cuota se debe */
/*            asociar a un concepto de cobros sin acumular.                  */
/* -Se hacen sobre el ultimo Registro cargado de Fa_HistConc de tal manera   */
/*  los anteriores ya han sido acumulados.                                   */
/* -iNumReg : Registro del Host-Array stHistConc                             */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
/*static BOOL bfnAcumulaAboProd (int iInd, HISTCONC *pstHistConc, ACUMABO  *pstAcumAbo, COFACTCOBR *pstFactCobr) Requerimiento de Soporte - 41321 - 07.06.2007 */
static BOOL bfnAcumulaAboProd (long iInd, HISTCONCAUX *pstHistConc, ACUMABO  *pstAcumAbo, COFACTCOBR *pstFactCobr)
{
/***int  i       = 0    ; Requerimiento de Soporte - 41321 - 07.06.2007 *//* Indice de Abonados       */
/***int  j       = 0    ; Requerimiento de Soporte - 41321 - 07.06.2007 *//* Indice de Conceptos      */
/***int  k       = 0    ; Requerimiento de Soporte - 41321 - 07.06.2007 *//* Indice de stFactCobr     */
long  i       = 0    ; /* Indice de Abonados       */
long  j       = 0    ; /* Indice de Conceptos      */
long  k       = 0    ; /* Indice de stFactCobr     */
BOOL bEnc    = FALSE; /* Encuentra Concepto Cobro */
BOOL bEnc1   = FALSE; /* Encuentra Abonado        */
BOOL bEnc2   = FALSE; /* Encuentra Concepto       */
BOOL bAnade  = FALSE; /* Anade Concepto           */
/***int  iNumAbo = -1   ;
int  iNumConc= -1   ; Requerimiento de Soporte - 41321 - 07.06.2007*/
long  iNumAbo = -1   ;
long  iNumConc= -1   ;

	vDTrazasLog ( szExePasoC,"\n\t\t*** Acumula Conceptos ***"
							 "\n\t\t=> Num.Abonado  [%ld]"
							 "\n\t\t=> Cod.Producto [%d] "
							 "\n\t\t=> Cod.Concepto [%d] ", 
							 LOG06, 
							 pstHistConc->lNumAbonado [iInd],
							 pstHistConc->iCodProducto[iInd],
							 pstHistConc->iCodConcepto[iInd]);

	if (pstHistConc->iCodConcepto [iInd] != stDatosGener.iCodRecargo)
	{
		bEnc = FALSE;
		k = 0;

		while (!bEnc && k<pstFactCobr->iNumReg) 
		{
			if (pstFactCobr->pFacCob [k].iCodConcFact== pstHistConc->iCodConcepto[iInd])
				bEnc = TRUE;
			else
				k++; 
		}

		if (!bEnc)
		{
			vDTrazasError (szExePasoC, "\n\t\t* No Existe Relacion para Concepto [%d]\n", LOG03,pstHistConc->iCodConcepto [iInd]);
			return FALSE;
		}

		while (i<pstAcumAbo->iNumReg && !bEnc1)
		{
			if (pstAcumAbo->pAboCobr   [i].lNumAbonado == pstHistConc->lNumAbonado [iInd]        &&
				pstAcumAbo->pAboCobr   [i].iCodProducto== pstHistConc->iCodProducto[iInd])
			{
				iNumAbo= i   ;
				bEnc1  = TRUE;
				vDTrazasLog ( szExePasoC, "\n\t\t=> [%d]-Acumulo en Num.Abonado [%ld]", LOG06, iNumAbo,
				pstAcumAbo->pAboCobr [i].lNumAbonado); 
			}
			else
			{
				i++;
			}
		}/* fin while bEnc1 */

		if (bEnc1)
		{
			if (pstHistConc->lSeqCuotas [iInd] > 0 && pstHistConc->iOrdCuota  [iInd] > 0) 
			{
				/* Anadimos Concepto */ 
				bAnade = TRUE;
			}
			else
			{
				/* Buscamos el Concepto y Acumulamos */
				j     = 0    ;
				bEnc2 = FALSE;

				while (!bEnc2 && j<pstAcumAbo->pAboCobr [i].iNumConceptos)
				{
/*					Requerimiento de Soporte - 66709 - 11.06.2008 mgg /
					if (pstAcumAbo->pAboCobr[i].pConcCobr[j].iCodConcCobr == pstFactCobr->pFacCob  [k].iCodConcCobr &&
						pstAcumAbo->pAboCobr[i].pConcCobr[j].iIndFactur   == pstHistConc->iIndFactur [iInd]) 
*/
					if (pstAcumAbo->pAboCobr[i].pConcCobr[j].iCodConcCobr == pstFactCobr->pFacCob[k].iCodConcCobr)
					{
						bEnc2   = TRUE;
						vDTrazasLog (szExePasoC, "\n\t\t=> Acumulo Concepto [%d]", LOG06, pstFactCobr->pFacCob[k].iCodConcCobr);
					}
					else
					{
						j++;
					}
				}/* fin while bEnc2 ... */

				if (bEnc2)
				{
					/*pstHistConc->dImpFacturable [iInd]=fnCnvDouble(pstHistConc->dImpFacturable [iInd], 4); */
					pstHistConc->dImpFacturable [iInd]=fnCnvDouble(pstHistConc->dImpFacturable [iInd], pstParamGener.iNumDecimal);  /*TM-200412091155 13-06-2005 Desarrollo RyC */
					/*pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr += pstHistConc->dImpFacturable [iInd];*/
					/*pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr += fnCnvDouble(pstHistConc->dImpFacturable [iInd], 4); / 28-12-2004 Homolog TM-0496_2 GAC*/
					pstAcumAbo->pAboCobr[i].pConcCobr[j].dImpConcCobr += fnCnvDouble(pstHistConc->dImpFacturable [iInd], pstParamGener.iNumDecimal ); /* TM-200412091155 13-06-2005 Desarrollo RyC*/
					bAnade = FALSE;
				}
				else
					bAnade = TRUE ;
			}
		}/* fin if (bEnc1) */
		else
		{
			/* Anade Abonado */
			vDTrazasLog( szExePasoC, "\n\t\t=> [%d]-Introducir Abonado [%ld]", LOG06, pstAcumAbo->iNumReg, pstHistConc->lNumAbonado[iInd] );

			if ((pstAcumAbo->pAboCobr = (ABOCOBR *)realloc ((ABOCOBR *)pstAcumAbo->pAboCobr,(pstAcumAbo->iNumReg+1)*sizeof(ABOCOBR)))==(ABOCOBR *)NULL)
			{
				iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumAbo->pAboCobr");
				return  FALSE                   ;
			}

			pstAcumAbo->pAboCobr[pstAcumAbo->iNumReg].lNumAbonado  = pstHistConc->lNumAbonado [iInd];
			pstAcumAbo->pAboCobr[pstAcumAbo->iNumReg].iCodProducto = pstHistConc->iCodProducto[iInd];
			pstAcumAbo->pAboCobr[pstAcumAbo->iNumReg].iNumConceptos= 0    ;
			pstAcumAbo->pAboCobr[pstAcumAbo->iNumReg].pConcCobr    = (CONCCOBR *)NULL;
			pstAcumAbo->iNumReg++;
			bAnade = TRUE        ; 
		}

		if(bAnade)
		{
			if (iNumAbo < 0)
				iNumAbo = pstAcumAbo->iNumReg-1;

			vDTrazasLog (szExePasoC, "\n\t\t=> [%d]-Num.Abonado [%ld]:      " 
									 "\n\t\t=> [%d]-Introducir Concepto [%d]", LOG06,
									 iNumAbo, pstHistConc->lNumAbonado [iInd]     ,
									 pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos,
									 pstFactCobr->pFacCob [k].iCodConcCobr);

			if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr = realloc ((CONCCOBR *)pstAcumAbo->pAboCobr[iNumAbo].pConcCobr,
				sizeof(CONCCOBR)*(pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos+1))) == (CONCCOBR *)NULL)
			{
				iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumAbo->pAboCobr->pConcCobr");
				return  FALSE                              ;
			}

			iNumConc = pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos;
			pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iCodConcCobr = pstFactCobr->pFacCob[k].iCodConcCobr;
			/*pstHistConc->dImpFacturable[iInd] = fnCnvDouble(pstHistConc->dImpFacturable[iInd], 4);  /28-12-2004 Homolog. TM-872 GAC*/
			pstHistConc->dImpFacturable[iInd] = fnCnvDouble(pstHistConc->dImpFacturable[iInd], pstParamGener.iNumDecimal);  /*TM-200412091155 13-06-2005 Desarrollo RyC*/
			/*pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].dImpConcCobr = pstHistConc->dImpFacturable[iInd];*/
			pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].dImpConcCobr = fnCnvDouble(pstHistConc->dImpFacturable[iInd], pstParamGener.iNumDecimal);
			pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].lSeqCuotas   = ( pstHistConc->lSeqCuotas[iInd] > 0 ) ? pstHistConc->lSeqCuotas[iInd] : 0;
			pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iOrdCuota    = ( pstHistConc->iOrdCuota [iInd] > 0) ? pstHistConc->iOrdCuota [iInd] : 0;
			pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iIndFactur   = pstHistConc->iIndFactur[iInd];
			pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos++;
		}
	}/* fin primer if ... */

	return TRUE;
}/**************************** Final bfnAcumulaAboProd ***********************/

/*****************************************************************************/
/*                            funcion : bfnGetCobros                         */
/* -Funcion que rellena la estructura pstCobros para realizar el Interface   */
/*  con el modulo de Cobros y asi actualizar la Cartera.                     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnGetCobros( DATCON *pstCobros, int iCodAbono, ABOCOBR stAboCobr, CONCCOBR stConcCobr, DATOS_FACT stHistDocu )
{
static double dImpConcepto = 0.0;
	
	/*stConcCobr.dImpConcCobr = fnCnvDouble(stConcCobr.dImpConcCobr, 1);  /28-12-2004 Homolog. TM-872 GAC*/
	stConcCobr.dImpConcCobr = fnCnvDouble(stConcCobr.dImpConcCobr, pstParamGener.iNumDecimal);  /*TM-200412091155 13-06-2004 Desarrollo RyC */
	if( stConcCobr.dImpConcCobr != 0.0 )
	{
		/****************************************************************/
		/* if(stHistDocu.iCodTipMovimie != stDatosGener.iCodCiclo)      */
		/*        pstCobros->szFolioCTC[0]=0;                           */
		/* else                                                         */
		/*        strcpy (pstCobros->szFolioCTC,stHistDocu.szNumCTC);   */
		/****************************************************************/
		/*  Se Cambio para que todos los documentos se carge el Numero  */
		/*  de Folio CTC, cilclo y no ciclo                             */
		/****************************************************************/
		strcpy (pstCobros->szFolioCTC,stHistDocu.szNumCTC)     ; 
		/****************************************************************/
		pstCobros->iCodTipDocum = stHistDocu.iCodTipDocum      ;
		pstCobros->lCodAgente   = stHistDocu.lCodVendedorAgente; 
		strcpy (pstCobros->szLetra,stHistDocu.szLetra)         ;
		pstCobros->iCodCentremi = stHistDocu.iCodCentrEmi      ;
		pstCobros->lNumSecuenci = stHistDocu.lNumSecuenci      ;
		pstCobros->iColumna     = 1                            ;
		pstCobros->iCodProducto = stAboCobr.iCodProducto       ;
		pstCobros->iCodConcepto = (stHistDocu.iCodTipMovimie == stDatosGener.iCodNotaCre)?iCodAbono:stConcCobr.iCodConcCobr;
		
		dImpConcepto            = stConcCobr.dImpConcCobr      ;
		
		if( !bConverMoneda( stDatosGener.szCodMoneFact, stDatosGener.szMonedaCobros, szSysDate, 
							&dImpConcepto, stHistDocu.iCodTipDocum ) )
			return FALSE;
		
		/******************************************************************/
		/* En las Notas de Credito se actuac de la siguiente manera:      */
		/*    # if (dImpConcepto < 0) Debe = (-1)*ImpConcepto             */
		/*      else Haber = (-1)*ImpConcepto                             */
		/******************************************************************/
		if( dImpConcepto > 0.0 )
		{
			
			/*if( stDatosGener.iCodNotaCre == stHistDocu.iCodTipMovimie ) pa' variar el lucho..!!*/
			if( (stDatosGener.iCodNotaCre == stHistDocu.iCodTipMovimie ) || (ihNotaAbono == stHistDocu.iCodTipMovimie))
			{
				pstCobros->dImporteHaber = dImpConcepto;
				pstCobros->dImporteDebe  = 0;
			}
			else
			{
				pstCobros->dImporteDebe = dImpConcepto;
				pstCobros->dImporteHaber= 0;
			}
		}
		else
		{
			if( stDatosGener.iCodNotaDeb == stHistDocu.iCodTipMovimie )
			{
				pstCobros->dImporteDebe  = dImpConcepto * (-1); /* para que genere el valor positivo */
				pstCobros->dImporteHaber = 0;
			}
			else
			{
				pstCobros->dImporteHaber = dImpConcepto * (-1); /* para que genere el valor positivo */
				pstCobros->dImporteDebe  = 0;
			}
		}
	
		if( stHistDocu.iCodTipMovimie == stDatosGener.iCodContado )
			pstCobros->iIndContado   = 1;
		else
			pstCobros->iIndContado   = 0;
		
		pstCobros->iIndFacturado = 1;
				
		strncpy (pstCobros->szFecEfectividad, stHistDocu.szFecEmision ,8);
		strncpy (pstCobros->szFecVencimie   , stHistDocu.szFecVencimie,8);
		strncpy (pstCobros->szFecCaducida   , stHistDocu.szFecCaducida,8);
		strncpy (pstCobros->szFecAntiguedad , stHistDocu.szFecVencimie,8);
		strcpy  (pstCobros->szFecPago       , "")                        ;
		
		pstCobros->szFecEfectividad[8] ='\0';
		pstCobros->szFecVencimie   [8] ='\0';
		pstCobros->szFecCaducida   [8] ='\0';
		pstCobros->szFecAntiguedad [8] ='\0';
		
		pstCobros->iDiasVencimiento = 0                               ;
		pstCobros->lNumAbonado      = stAboCobr.lNumAbonado           ;
		pstCobros->lNumFolio        = stHistDocu.lNumFolio            ;
		
		pstCobros->lNumCuota        = (stConcCobr.lSeqCuotas > 0)?stConcCobr.lSeqCuotas:0;
		pstCobros->iSecCuota        = (stConcCobr.iOrdCuota  > 0)?stConcCobr.iOrdCuota :0;
		
		pstCobros->lNumTransa       = stHistDocu.lNumTransaccion      ;
		pstCobros->lNumVenta        = stHistDocu.lNumVenta            ;

		strncpy (pstCobros->szPrefPlaza      , stHistDocu.szPrefPlaza ,     25);
		strncpy (pstCobros->szCodOperadoraScl, stHistDocu.szCodOperadoraScl,5); 
		strncpy (pstCobros->szCodPlaza       , stHistDocu.szCodPlaza,       5); 
		rtrim( pstCobros->szPrefPlaza );      
		rtrim( pstCobros->szCodOperadoraScl );
		rtrim( pstCobros->szCodPlaza );       
		
		vDTrazasLog (szExeName, "\n\t\t* Contenido stCobros  "
								"\n\t\t=> Cod.TipDocum  [%d] "
								"\n\t\t=> Cod.Agente    [%ld]" 
								"\n\t\t=> Letra         [%s] "
								"\n\t\t=> Cod.CentrEmi  [%d] "
								"\n\t\t=> Num.Secuenci  [%ld]"
								"\n\t\t=> Columna       [%d] "
								"\n\t\t=> Cod.Producto  [%d] "
								"\n\t\t=> Cod.Concepto  [%d] "
								"\n\t\t=> Imp.Haber     [%f] "
								"\n\t\t=> Imp.Debe      [%f] "
								"\n\t\t=> Num.Transacc. [%ld]"
								"\n\t\t=> Num.Venta     [%ld]"
								"\n\t\t=> Num.Cuota     [%ld]"
								"\n\t\t=> Sec.Cuotra    [%d] "
								"\n\t\t=> Num.Folio     [%ld]"
								"\n\t\t=> Num.Abonado   [%ld]"
								"\n\t\t=> Ind.Contado   [%d] "
								"\n\t\t=> Ind.Facturado [%d] "
								"\n\t\t=> Fec.Vencimie  [%s] "
								"\n\t\t=> Fec.Efectivid.[%s] "
								"\n\t\t=> Fec.Caducida  [%s] " 
								"\n\t\t=> Fec.Antiguedad[%s] "
								"\n\t\t=> Fec.Pago      [%s] " 
								"\n\t\t=> Num.CTC       [%s] "
								"\n\t\t=> Dias.Vencimie.[%d] "
								"\n\t\t=> Prefijo Plaza [%s] " 
								"\n\t\t=> Cod. Operadora[%s] " 
								"\n\t\t=> Codigo Plaza  [%s] " 
								, LOG04,
								pstCobros->iCodTipDocum,
								pstCobros->lCodAgente             ,
								pstCobros->szLetra                ,
								pstCobros->iCodCentremi           ,
								pstCobros->lNumSecuenci           ,
								pstCobros->iColumna               ,
								pstCobros->iCodProducto           ,
								pstCobros->iCodConcepto           ,
								pstCobros->dImporteHaber          ,
								pstCobros->dImporteDebe           ,
								pstCobros->lNumTransa             ,
								pstCobros->lNumVenta              ,
								pstCobros->lNumCuota              ,
								pstCobros->iSecCuota              ,
								pstCobros->lNumFolio              ,
								pstCobros->lNumAbonado            ,
								pstCobros->iIndContado            ,
								pstCobros->iIndFacturado          ,
								pstCobros->szFecVencimie          ,
								pstCobros->szFecEfectividad       ,
								pstCobros->szFecCaducida          ,
								pstCobros->szFecAntiguedad        ,
								pstCobros->szFecPago              ,
								pstCobros->szFolioCTC             ,
								pstCobros->iDiasVencimiento       ,
								pstCobros->szPrefPlaza            , /* jlr_11.01.03 */
								pstCobros->szCodOperadoraScl      , /* jlr_11.01.03 */
								pstCobros->szCodPlaza             );/* jlr_11.01.03 */
	} 

	return TRUE;

}/**************************** Final bfnGetCobros ****************************/

/*****************************************************************************/
/*                             funcion : bfnDBUpdateHistDocu                 */
/* -Funcion que actualiza el indicador de paso a cobros (IndPasoCobro) a 1 en*/
/*  la tabla Fa_HistDocu.                                                    */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnDBUpdateHistDocu (DATOS_FACT stHDocu)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static char szhQuery [100];/* EXEC SQL VAR szhQuery IS STRING(100); */ 

  	static char *szhRowid	  ;/* EXEC SQL VAR szhRowid IS STRING(19); */ 

  	int ihind_pasocobro ;
/* EXEC SQL END DECLARE SECTION; */ 


	szhRowid 		= stHDocu.szRowid;
  	ihind_pasocobro = stHDocu.iIndPasoCobro;

  	vDTrazasLog (szExeName, "\n\t\t* Parametros Entrada a Update TablaCabecera"
                         	"\n\t\t=>Rowid  [%s]"
                         	"\n\t\t=>Valor  [%d]",LOG04,stHDocu.szRowid,ihind_pasocobro);

  	strcpy(szhQuery,"UPDATE ");
  	strcat(szhQuery,szNomTablaCab);
  	strcat(szhQuery," SET IND_PASOCOBRO = :v0 , NUM_PROCPASOCOBRO = :v1 ");
  	strcat(szhQuery," WHERE ROWID = :v2");

  	/* EXEC SQL PREPARE alias_update FROM :szhQuery; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 37;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1354;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
   sqlstm.sqhstl[0] = (unsigned long )100;
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


 	if (SQLCODE)
 	{
 		vDTrazasLog (szExePasoC,"\n\n\tERROR al PREPARAR QUERY en bfnDBUpdateHistDocu\n", LOG05);
 		return SQLCODE;
 	}

  	/* EXEC SQL EXECUTE alias_update USING :ihind_pasocobro, :lNumProcPasoCob,:szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 37;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1373;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihind_pasocobro;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lNumProcPasoCob;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
   sqlstm.sqhstl[2] = (unsigned long )19;
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


  	if (SQLCODE)
	{
      iDError (szExeName,ERR000,vInsertarIncidencia,"Update:Fa_HistDocu", szfnORAerror());
  	}

	return (SQLCODE)?FALSE:TRUE; 

}/****************************** Final bfnDBUpdateHistDocu *******************/

/********************************************************************************/
/*	Funcion : bfnDBUpdateHistDocuError											*/
/* -Funcion que actualiza el indicador de paso a cobros (IndPasoCobro) al valor	*/
/*  pasado como parametro en la tabla de facturacion relacinadad               	*/
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             	*/
/********************************************************************************/
static BOOL bfnDBUpdateHistDocuError( char *szRowid, int iIndPasoCobro, long lNumProcPasoCobro )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhQuery[100]; /* EXEC SQL VAR szhQuery IS STRING(100); */ 

	char szhRowid[19];	/* EXEC SQL VAR szhRowid IS STRING(19); */ 

	long lhNumProcPasoCobro;
	int ihIndPasoCobro;
/* EXEC SQL END DECLARE SECTION; */ 


	memset( szhQuery, '\0', sizeof( szhQuery ) );
	memset( szhRowid, '\0', sizeof( szhRowid ) );
		
	strcpy( szhRowid, szRowid );
	ihIndPasoCobro = iIndPasoCobro;
	lhNumProcPasoCobro = lNumProcPasoCobro;
	
	vDTrazasLog( szExeName, "\n\t\t* Parametros Entrada a Update TablaCabecera"
							"\n\t\t=>Rowid  [%s]"
							"\n\t\t=>Valor  [%d]", LOG04, szhRowid, ihIndPasoCobro );
							
	strcpy( szhQuery, "UPDATE ");
	strcat( szhQuery, szNomTablaCab );
	
	/***** CH-1328 ****
	strcat( szhQuery, " SET IND_PASOCOBRO = :v0 , NUM_PROCPASOCOBRO = :v1 " );  
	*** CH-1328 */
	strcat( szhQuery, " SET IND_PASOCOBRO = :v0 " ); 
	strcat( szhQuery, "WHERE ROWID = :v1" );
	
	/* EXEC SQL PREPARE alias_update FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1400;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )100;
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


	if( SQLCODE )
	{
		vDTrazasLog( szExePasoC, "\n\n\tERROR al PREPARAR QUERY en bfnDBUpdateHistDocuError.\n", LOG05 );
		return SQLCODE;
	}
	
	/******  CH-1328 ****
	EXEC SQL EXECUTE alias_update USING :ihIndPasoCobro, :lhNumProcPasoCobro, :szhRowid;
	********/
	/* EXEC SQL EXECUTE alias_update USING :ihIndPasoCobro, :szhRowid; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1419;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndPasoCobro;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[1] = (unsigned long )19;
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


	if( SQLCODE )
	{
		iDError( szExeName, ERR000, vInsertarIncidencia, "Update:Fa_HistDocu.", szfnORAerror() );
	}
	
	return (SQLCODE)?FALSE:TRUE; 

}/****************************** Final bfnDBUpdateHistDocuError *******************/

/*****************************************************************************/
/*                            funcion : vfnFreeAcumAbo                       */
/*****************************************************************************/
static BOOL bfnLimpiaEstructura()
{
	int zz;
		
	for( zz = 0; zz < iCNTDOCTOS; zz++ )
	{
		stAcumDoctoPaso[zz].szRowid[0]			= '\0'; 			                        
		stAcumDoctoPaso[zz].iIndPasoCobro 		= 0; 			                         
		stAcumDoctoPaso[zz].lNumProcPasoCobro	= 0;
		stAcumDoctoPaso[zz].iCodEstaDocSal		= 0;
		stAcumDoctoPaso[zz].lNumProceso			= 0; 			                         
	}
	return TRUE;
}

/*****************************************************************************/
/*                            funcion : vfnFreeAcumAbo                       */
/*****************************************************************************/
static void vfnFreeAcumAbo (ACUMABO *pstAcumAbo)
{
  int i = 0;

  if (pstAcumAbo->pAboCobr != (ABOCOBR *)NULL)
  {
      for (i=0;i<pstAcumAbo->iNumReg;i++)
      {
           if (pstAcumAbo->pAboCobr[i].pConcCobr != (CONCCOBR *)NULL)
           {
               free (pstAcumAbo->pAboCobr[i].pConcCobr)            ;
               pstAcumAbo->pAboCobr[i].pConcCobr = (CONCCOBR *)NULL;
           }
      }
      free (pstAcumAbo->pAboCobr);
      pstAcumAbo->pAboCobr = (ABOCOBR *)NULL;
  }
}/****************************** Final vfnFreeAcumAbo ************************/


/*****************************************************************************/
/*                           funcion : bfnPagado                             */
/*****************************************************************************/
static BOOL bfnPagado (DATDOC *pstDatDoc, DATPAG *pstDatPag, DATCON *pstConc)
{
	pstConc->iCodTipDocum   = pstDatDoc->iCodTipDocum;
  	pstDatDoc->iCodTipDocum = pstDatPag->iCodTipDocum; /* jlr_05.01.01 */
  	pstConc->iCodCentremi   = pstDatDoc->iCodCentrEmi;
  	pstConc->lNumSecuenci   = pstDatDoc->lNumSecuenci;

  	strcpy (pstConc->szLetra, pstDatDoc->szLetra);

  	pstConc->lNumCuota     =  0                  ; /*rbr -1*/
  	pstConc->iSecCuota     = -1                  ;
  	pstConc->iIndContado   =  1                  ;
  	pstConc->iIndFacturado =  1                  ;

  	printf( "\n\t\t* Llamada a bfnDBSecCol "
			"\n\t\t* pstConc->lNumSecuenci  [%d] "
			"\n\t\t* pstConc->iCodTipDocum  [%d] "
			"\n\t\t* pstConc->szLetra       [%s] "     
			"\n\t\t* pstConc->iCodCentremi  [%d] "
			"\n\t\t* pstConc->iCodConcepto  [%d] " 
			"\n\t\t* pstConc->lCodAgente    [%d] ",
			pstConc->lNumSecuenci,
			pstConc->iCodTipDocum,
			pstConc->szLetra,     
			pstConc->iCodCentremi,
			pstConc->iCodConcepto, 
			pstConc->lCodAgente  );  

  	if (!bfnDBSecCol (pstConc))
       return FALSE;

  	if (!bfnDBInsertPagosConc(*pstDatDoc, *pstConc))
  	{
    	vDTrazasError (szExeName, "\n\t\t=> Error funcion (Cobros) : bfnDBInsPagoConc", LOG03);
       	return         FALSE ;
  	}

	if (!bfnDBInsertCancelados (*pstConc, pstDatPag->lCodCliente))
  	{
    	vDTrazasError (szExeName, "\n\t\t=> Error funcion (Cobros) : bfnDBInsertCancelados", LOG03);
       	return         FALSE ;       
  	}

  	return TRUE; 

}/****************************** Final bfnPagado *****************************/

/*****************************************************************************/
/*                             funcion : bfnDBInsertPagos                    */
/*****************************************************************************/
static BOOL bfnDBInsertPagos (DATDOC *pstDatDoc,
                              DATPAG *pstDatPag, char *szOficina)
{
	if (!bGetCentrEmi (szOficina, pstDatPag->iCodTipDocum, &pstDatDoc->iCodCentrEmi))
    	return FALSE;
  	if (!bGenNumSecuenciasEmi (pstDatPag->iCodTipDocum, pstDatDoc->szLetra, pstDatDoc->iCodCentrEmi,&pstDatDoc->lNumSecuenci))
    	return FALSE;

  	vDTrazasLog (szExeName,	"\n\t\t* Insert=> Co_Pagos"
                         	"\n\t\t=> Cod.TipDocum [%d] "
                         	"\n\t\t=> Cod.CentrEmi [%d] " 
                         	"\n\t\t=> Num.Secuenci [%ld]" 
                         	"\n\t\t=> Cod.Vendedor [%ld]" 
	                       	"\n\t\t=> Letra        [%s] " 
                         	"\n\t\t=> Cod.Cliente  [%ld]" 
                         	"\n\t\t=> Imp.Pago     [%f] " 
                         	"\n\t\t=> Nom.UsuarOra [%s] " 
                         	"\n\t\t=> Cod.ForPago  [%d] " 
                         	"\n\t\t=> Cod.SisPago  [%d] " 
                         	"\n\t\t=> Cod.OriPago  [%d] " 
                         	"\n\t\t=> Cod.CauPago  [%d] "
                         	"\n\t\t=> Des.Pago     [%s] " , LOG05,
                         	pstDatPag->iCodTipDocum, pstDatDoc->iCodCentrEmi ,
                         	pstDatDoc->lNumSecuenci, pstDatDoc->lCodAgente   ,
                         	pstDatDoc->szLetra     , pstDatPag->lCodCliente  ,
                         	pstDatPag->dImpPago    , pstDatPag->szNomUsu     ,
                         	pstDatPag->iCodForPago ,
                         	pstDatPag->iCodSisPago , pstDatPag->iCodOriPago  ,
                         	pstDatPag->iCodCauPago , pstDatDoc->szDesPago);

   
     /* EXEC SQL INSERT INTO CO_PAGOS
             (COD_TIPDOCUM       ,
              COD_CENTREMI       ,
              NUM_SECUENCI       ,
              COD_VENDEDOR_AGENTE,
              LETRA              ,
              COD_CLIENTE        ,
              IMP_PAGO           ,
              FEC_EFECTIVIDAD    ,
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
              PREF_PLAZA)           /o GAC 08-08-2003 o/
       VALUES(:pstDatPag->iCodTipDocum ,
              :pstDatDoc->iCodCentrEmi ,
              :pstDatDoc->lNumSecuenci ,
              :pstDatDoc->lCodAgente   ,
              :pstDatDoc->szLetra      ,
              :pstDatPag->lCodCliente  ,
              :pstDatPag->dImpPago     ,
               SYSDATE                 ,
               SYSDATE                 ,
              USER					   , /o:pstDatPag->szNomUsu     ,o/
              0                        ,
              :pstDatPag->iCodSisPago  ,
              :pstDatPag->iCodOriPago  ,
              :pstDatPag->iCodCauPago  ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              :pstDatDoc->szDesPago    ,
              :szPrefPlazaDefault); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 37;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CO_PAGOS (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CLIENTE,IMP_PAGO,FEC_EFECTIVIDAD,FEC_VALOR,\
NOM_USUARORA,COD_FORPAGO,COD_SISPAGO,COD_ORIPAGO,COD_CAUPAGO,COD_BANCO,COD_TIP\
TARJETA,COD_SUCURSAL,CTA_CORRIENTE,NUM_TARJETA,DES_PAGO,PREF_PLAZA) values (:b\
0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,SYSDATE,USER,0,:b7,:b8,:b9,null ,null ,null \
,null ,null ,:b10,:b11)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1442;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&(pstDatPag->iCodTipDocum);
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&(pstDatDoc->iCodCentrEmi);
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&(pstDatDoc->lNumSecuenci);
     sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&(pstDatDoc->lCodAgente);
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)(pstDatDoc->szLetra);
     sqlstm.sqhstl[4] = (unsigned long )2;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&(pstDatPag->lCodCliente);
     sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&(pstDatPag->dImpPago);
     sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&(pstDatPag->iCodSisPago);
     sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&(pstDatPag->iCodOriPago);
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&(pstDatPag->iCodCauPago);
     sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)(pstDatDoc->szDesPago);
     sqlstm.sqhstl[10] = (unsigned long )41;
     sqlstm.sqhsts[10] = (         int  )0;
     sqlstm.sqindv[10] = (         short *)0;
     sqlstm.sqinds[10] = (         int  )0;
     sqlstm.sqharm[10] = (unsigned long )0;
     sqlstm.sqadto[10] = (unsigned short )0;
     sqlstm.sqtdso[10] = (unsigned short )0;
     sqlstm.sqhstv[11] = (unsigned char  *)szPrefPlazaDefault;
     sqlstm.sqhstl[11] = (unsigned long )26;
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

       /* GAC 08-08-2003 */

	if (SQLCODE)
		iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_Pagos", szfnORAerror ());

	vDTrazasLog (szExeName,"\n\t\t* Insert=> Co_Pagos OK ", LOG05 );      /*TM-200412091155 13-12-2004 Soporte RyC PRM*/

	return (SQLCODE)?FALSE:TRUE;
}/**************************** Final bfnDBInsertPagos ************************/


/*****************************************************************************/
/*                            funcion : bfnDBInsertPagosConc                 */
/*****************************************************************************/
static BOOL bfnDBInsertPagosConc (DATDOC stPago, DATCON stPagConc)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   static short i_shCodTipDocRel  ;
   static short i_shCodCentrRel   ;
   static short i_shNumSecuRel    ;
   static short i_shLetraRel      ;
   static short i_shCodAgenteRel  ;
   static short i_shCodConcepto   ;
   static short i_shImpConcepto   ;
   static short i_shColumna       ;
   static short i_shNumAbonado    ;
   static short i_shNumFolio      ;
   static short i_shNumCuota      ;
   static short i_shSecCuota      ;
   static short i_shNumTransa     ;
   static short i_shNumVenta      ;
   static short i_shFolioCTC      ;

   /*TM-200412091155 13-12-2004 Soporte RyC PRM*/
   /*Se declaran Variables locales, para asignar valores de la estructura de co_pagos y co_pagosconc */
   int     ihCodTipDocum;
   long    lhCodAgente;
   char    szhLetra[2]; 				/* EXEC SQL VAR szhLetra IS STRING(2); */ 

   int     ihCodCentremi;
   long    lhNumSecuenci;
   int     ihCodTipDocum_P;
   long    lhCodAgente_P;
   char    szhLetra_P[2]; 				/* EXEC SQL VAR szhLetra_P IS STRING(2); */ 

   int     ihCodCentremi_P;
   long    lhNumSecuenci_P;
   int     ihCodConcepto;
   int     ihColumna;
   int     ihCodProducto;
   double  dhImporteDebe;
   double  dhImporteHaber;
   int     ihIndContado;
   int     ihIndFacturado;
   char    szhFecEfectividad[9];		/* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

   char    szhFecVencimie[9];			/* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 

   char    szhFecCaducida[9];			/* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 

   char    szhFecAntiguedad[9];			/* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 

   char    szhFecPago[9];				/* EXEC SQL VAR szhFecPago IS STRING(9); */ 

   int     ihDiasVencimiento;
   long    lhNumAbonado;
   long    lhNumFolio;
   long    lhNumCuota;
   int     ihSecCuota;
   long    lhNumTransa;
   long    lhNumVenta;
   char    szhFolioCTC[12];				/* EXEC SQL VAR szhFolioCTC IS STRING(12); */ 

   char    szhPrefPlaza[26];			/* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

   char    szhCodOperadoraScl[6];		/* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 

   char    szhCodPlaza[6];       		/* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 


/* EXEC SQL END DECLARE SECTION  ; */ 


    /*TM-200412091155 13-12-2004 Soporte RyC PRM*/
    /*Asignación de Variables desde las estructuras de pagos a variables locales*/
    
    /*Estructura de CO_PAGOS*/
    ihCodTipDocum	=	stPago.iCodTipDocum;
    ihCodCentremi	=	stPago.iCodCentrEmi;
    lhNumSecuenci	=	stPago.lNumSecuenci;
    lhCodAgente		=	stPago.lCodAgente;
    strcpy(szhLetra,stPago.szLetra);
    
    /*Estructura de CO_PAGOSCONC*/
    dhImporteDebe	=	stPagConc.dImporteDebe;
    ihCodProducto	=	stPagConc.iCodProducto;    
    ihCodTipDocum_P	=	stPagConc.iCodTipDocum;
    lhCodAgente_P	=	stPagConc.lCodAgente;
    ihCodCentremi_P	=	stPagConc.iCodCentremi;
    lhNumSecuenci_P	=	stPagConc.lNumSecuenci;
    strcpy(szhLetra_P, stPagConc.szLetra);    
    ihCodConcepto	=	stPagConc.iCodConcepto;
    ihColumna		=	stPagConc.iColumna;
    lhNumAbonado	=	stPagConc.lNumAbonado;
    lhNumFolio		=	stPagConc.lNumFolio;
    lhNumCuota		=	stPagConc.lNumCuota;
    ihSecCuota		=	stPagConc.iSecCuota;
    lhNumTransa		=	stPagConc.lNumTransa;
    lhNumVenta		=	stPagConc.lNumVenta;
    strcpy(szhFolioCTC, stPagConc.szFolioCTC);
    strcpy(szhPrefPlaza, stPagConc.szPrefPlaza);
    strcpy(szhCodOperadoraScl, stPagConc.szCodOperadoraScl);
    strcpy(szhCodPlaza, stPagConc.szCodPlaza);

   	vDTrazasLog (szExeName,
                "\n\t\t* Insert=> Co_PagosConc"
                "\n\t\t=> Cod.TipDocum  [%d] "
                "\n\t\t=> Cod.CentrEmi  [%d] " 
                "\n\t\t=> Num.Secuenci  [%ld]" 
                "\n\t\t=> Cod.Agente    [%ld]" 
                "\n\t\t=> Letra         [%s] "
                "\n\t\t=> Imp.Concepto  [%f] " 
                "\n\t\t=> Cod.Producto  [%d] " 
                "\n\t\t=> Cod.TipDocRel [%d] " 
                "\n\t\t=> Cod.AgenteRel [%ld]"
                "\n\t\t=> Cod.CentrRel  [%ld]" 
                "\n\t\t=> Num.SecuRel   [%ld]" 
                "\n\t\t=> LetraRel      [%s] " 
                "\n\t\t=> Cod.Concepto  [%d] " 
                "\n\t\t=> Columna       [%d] " 
                "\n\t\t=> Num.Abonado   [%ld]"
                "\n\t\t=> Num.Folio     [%ld]"
                "\n\t\t=> Num.Cuota     [%ld]" 
                "\n\t\t=> Sec.Cuota     [%ld]" 
                "\n\t\t=> Num.Transacc. [%ld]" 
                "\n\t\t=> Num.Venta     [%ld]" 
                "\n\t\t=> Num.FolioCTC  [%s] "
                "\n\t\t=> Prefijo Plaza [%s] " /* jlr_11.01.03 */
                "\n\t\t=> Cod.Operadora [%s] " /* jlr_11.01.03 */
                "\n\t\t=> Codigo Plaza  [%s] " /* jlr_11.01.03 */
                ,LOG05, 
                stPago.iCodTipDocum      , stPago.iCodCentrEmi   , 
                stPago.lNumSecuenci      , stPago.lCodAgente     ,
                stPago.szLetra           , stPagConc.dImporteDebe,
                stPagConc.iCodProducto   , stPagConc.iCodTipDocum,
                stPagConc.lCodAgente     , stPagConc.iCodCentremi,
                stPagConc.lNumSecuenci   , stPagConc.szLetra     ,
                stPagConc.iCodConcepto   , stPagConc.iColumna    ,
                stPagConc.lNumAbonado    , stPagConc.lNumFolio   ,
                stPagConc.lNumCuota      , stPagConc.iSecCuota   ,
                stPagConc.lNumTransa     , stPagConc.lNumVenta   , 
                stPagConc.szFolioCTC	 ,
                stPagConc.szPrefPlaza	 ,    /* jlr_11.01.03 */
                stPagConc.szCodOperadoraScl , /* jlr_11.01.03 */
                stPagConc.szCodPlaza	 );   /* jlr_11.01.03 */

  
   /*i_shCodCentrRel    = (stPagConc.iCodCentremi    == -1)?-1:0;
   i_shCodTipDocRel   = (stPagConc.iCodTipDocum    == -1)?-1:0;
   i_shLetraRel       = (stPagConc.szLetra [0]     ==  0)?-1:0;
   i_shNumSecuRel     = (stPagConc.lNumSecuenci    == -1)?-1:0;
   i_shCodAgenteRel   = (stPagConc.lCodAgente      == -1)?-1:0;
   i_shCodConcepto    = (stPagConc.iCodConcepto    == -1)?-1:0;
   i_shColumna        = (stPagConc.iColumna        == -1)?-1:0;
   i_shNumAbonado     = (stPagConc.lNumAbonado     == -1)?-1:0;
   i_shNumFolio       = (stPagConc.lNumFolio       == -1)?-1:0;
   i_shNumCuota       = (stPagConc.lNumCuota       == -1)?-1:0;
   i_shSecCuota       = (stPagConc.iSecCuota       == -1)?-1:0;
   i_shNumVenta       = (stPagConc.lNumVenta       == -1)?-1:0;
   i_shNumTransa      = (stPagConc.lNumTransa      == -1)?-1:0;  
   i_shFolioCTC       = (stPagConc.szFolioCTC [0]  ==  0)?-1:0;*/

	/*TM-200412091155 13-12-2004 Soporte RyC PRM*/
   	i_shCodCentrRel    = (ihCodCentremi_P    == -1)?-1:0;
   	i_shCodTipDocRel   = (ihCodTipDocum_P    == -1)?-1:0;
   	i_shLetraRel       = (szhLetra_P     	==  0)?-1:0;
   	i_shNumSecuRel     = (lhNumSecuenci_P    == -1)?-1:0;
   	i_shCodAgenteRel   = (lhCodAgente_P      == -1)?-1:0;
   	i_shCodConcepto    = (ihCodConcepto    	== -1)?-1:0;
   	i_shColumna        = (ihColumna        	== -1)?-1:0;
   	i_shNumAbonado     = (lhNumAbonado     	== -1)?-1:0;
   	i_shNumFolio       = (lhNumFolio       	== -1)?-1:0;
   	i_shNumCuota       = (lhNumCuota       	== -1)?-1:0;
   	i_shSecCuota       = (ihSecCuota       	== -1)?-1:0;
   	i_shNumVenta       = (lhNumVenta       	== -1)?-1:0;
   	i_shNumTransa      = (lhNumTransa      	== -1)?-1:0;  
   	i_shFolioCTC       = (szhFolioCTC  		==  0)?-1:0;   

   	/* EXEC SQL INSERT INTO CO_PAGOSCONC
                       (COD_TIPDOCUM       ,
                        COD_CENTREMI       ,
                        NUM_SECUENCI       ,
                        COD_VENDEDOR_AGENTE,
                        LETRA              ,
                        IMP_CONCEPTO       ,
                        COD_PRODUCTO       ,
                        COD_TIPDOCREL      ,
                        COD_CENTRREL       ,
                        NUM_SECUREL        ,
                        COD_AGENTEREL      ,
                        LETRA_REL          ,
                        COD_CONCEPTO       ,
                        COLUMNA            ,
                        NUM_ABONADO        ,
                        NUM_FOLIO          ,
                        NUM_CUOTA          ,
                        SEC_CUOTA          ,
                        NUM_TRANSACCION    ,
                        NUM_VENTA          ,
                        NUM_FOLIOCTC       ,
                        PREF_PLAZA         , /o jlr_11.01.03 o/
                        COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
                        COD_PLAZA          ) /o jlr_11.01.03 o/
                 VALUES(:ihCodTipDocum      ,
                        :ihCodCentremi      ,
                        :lhNumSecuenci      ,
                        :lhCodAgente        ,
                        :szhLetra           ,
                        :dhImporteDebe   	,
                        :ihCodProducto   	,
                        :ihCodTipDocum_P   	:i_shCodTipDocRel  ,
                        :ihCodCentremi_P   	:i_shCodCentrRel   ,
                        :lhNumSecuenci_P   	:i_shNumSecuRel    ,   
                        :lhCodAgente_P     	:i_shCodAgenteRel  ,
                        :szhLetra_P        	:i_shLetraRel      ,
                        :ihCodConcepto   	:i_shCodConcepto   ,
                        :ihColumna       	:i_shColumna       ,
                        :lhNumAbonado    	:i_shNumAbonado    ,
                        :lhNumFolio      	:i_shNumFolio      ,
                        :lhNumCuota      	:i_shNumCuota      ,
                        :ihSecCuota      	:i_shSecCuota      ,
                        :lhNumTransa     	:i_shNumTransa     ,
                        :lhNumVenta      	:i_shNumVenta      ,
                        :szhFolioCTC     	:i_shFolioCTC      ,
	                	:szhPrefPlaza	 	,	
	                	:szhCodOperadoraScl ,	
	                	:szhCodPlaza	 	); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 37;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_S\
ECUENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCREL,COD_\
CENTRREL,NUM_SECUREL,COD_AGENTEREL,LETRA_REL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,\
NUM_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLAZ\
A,COD_OPERADORA_SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7:b8,:b9:\
b10,:b11:b12,:b13:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b\
27:b28,:b29:b30,:b31:b32,:b33:b34,:b35,:b36,:b37)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1505;
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
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocum_P;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&i_shCodTipDocRel;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCentremi_P;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&i_shCodCentrRel;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhNumSecuenci_P;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)&i_shNumSecuRel;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&lhCodAgente_P;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&i_shCodAgenteRel;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_P;
    sqlstm.sqhstl[11] = (unsigned long )2;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)&i_shLetraRel;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihCodConcepto;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)&i_shCodConcepto;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&ihColumna;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)&i_shColumna;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)&i_shNumAbonado;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)&i_shNumFolio;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&lhNumCuota;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)&i_shNumCuota;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihSecCuota;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)&i_shSecCuota;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&lhNumTransa;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)&i_shNumTransa;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)&i_shNumVenta;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhFolioCTC;
    sqlstm.sqhstl[20] = (unsigned long )12;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)&i_shFolioCTC;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[21] = (unsigned long )26;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhCodOperadoraScl;
    sqlstm.sqhstl[22] = (unsigned long )6;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhCodPlaza;
    sqlstm.sqhstl[23] = (unsigned long )6;
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

	

/*                 VALUES(:stPago.iCodTipDocum      ,
                        :stPago.iCodCentrEmi      ,
                        :stPago.lNumSecuenci      ,
                        :stPago.lCodAgente        ,
                        :stPago.szLetra           ,
                        :stPagConc.dImporteDebe   ,
                        :stPagConc.iCodProducto   ,
                        :stPagConc.iCodTipDocum   :i_shCodTipDocRel  ,
                        :stPagConc.iCodCentremi   :i_shCodCentrRel   ,
                        :stPagConc.lNumSecuenci   :i_shNumSecuRel    ,   
                        :stPagConc.lCodAgente     :i_shCodAgenteRel  ,
                        :stPagConc.szLetra        :i_shLetraRel      ,
                        :stPagConc.iCodConcepto   :i_shCodConcepto   ,
                        :stPagConc.iColumna       :i_shColumna       ,
                        :stPagConc.lNumAbonado    :i_shNumAbonado    ,
                        :stPagConc.lNumFolio      :i_shNumFolio      ,
                        :stPagConc.lNumCuota      :i_shNumCuota      ,
                        :stPagConc.iSecCuota      :i_shSecCuota      ,
                        :stPagConc.lNumTransa     :i_shNumTransa     ,
                        :stPagConc.lNumVenta      :i_shNumVenta      ,
                        :stPagConc.szFolioCTC     :i_shFolioCTC      ,
	                :stPagConc.szPrefPlaza	 		     ,	/ jlr_11.01.03 /
	                :stPagConc.szCodOperadoraScl 		 ,	/ jlr_11.01.03 /
	                :stPagConc.szCodPlaza	 		     );	/ jlr_11.01.03 */


	if (SQLCODE)
    	iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_PagosConc", szfnORAerror ());

  	return (SQLCODE)?FALSE:TRUE;

}/******************************* Final bfnDBInsertPagosConc *****************/

/*****************************************************************************/
/*                             funcion : bfnDBInsertCancelados               */
/*****************************************************************************/
static BOOL bfnDBInsertCancelados (DATCON stConc, long lCodCliente)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static long  lhCodCliente      ;
		static short i_shFecEfectividad;
		static short i_shFecVencimie   ;
		static short i_shFecCaducida   ;
		static short i_shFecAntiguedad ;
		static short i_shFecPago       ;
		static short i_shNumAbonado    ;
		static short i_shNumTransa     ;
		static short i_shNumVenta      ;
		static short i_shNumCuota      ;
		static short i_shSecCuota      ;
		static short i_shNumFolio      ;
		static short i_shFolioCTC      ;

		/*TM-200412091155 13-06-2005 Desarrollo */
		/*Se declaran Variables locales, para asignar valores de la estructura de CO_CANCELADOS*/
		int     ihCodTipDocum;
		long    lhCodAgente;
		char    szhLetra[2]; 				/* EXEC SQL VAR szhLetra IS STRING(2); */ 

		int     ihCodCentremi;
		long    lhNumSecuenci;
		int     ihCodConcepto;
		int     ihColumna;
		int     ihCodProducto;                                                                      
		double  dhImporteDebe;                                                                      
		double  dhImporteHaber;                                                                     
		int     ihIndContado;                                                                       
		int     ihIndFacturado;                                                                     
		char    szhFecEfectividad[9];		/* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 
         
		char    szhFecVencimie[9];			/* EXEC SQL VAR szhFecVencimie IS STRING(9); */ 
            
		char    szhFecCaducida[9];			/* EXEC SQL VAR szhFecCaducida IS STRING(9); */ 
            
		char    szhFecAntiguedad[9];		/* EXEC SQL VAR szhFecAntiguedad IS STRING(9); */ 
          
		char    szhFecPago[9];				/* EXEC SQL VAR szhFecPago IS STRING(9); */ 
                  
		long    lhNumAbonado;                                                                       
		long    lhNumFolio;                                                                            
		long    lhNumCuota;                                                                         
		int     ihSecCuota;                                                                         
		long    lhNumTransa;                                                                        
		long    lhNumVenta;                                                                         
		char    szhFolioCTC[12];			/* EXEC SQL VAR szhFolioCTC IS STRING(12)  ; */ 
              
		char    szhPrefPlaza[26];			/* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 
  
		char    szhCodOperadoraScl[6];		/* EXEC SQL VAR szhCodOperadoraScl IS STRING(6); */ 
                  
		char    szhCodPlaza[6];       		/* EXEC SQL VAR szhCodPlaza IS STRING(6); */ 
                           
	
	/* EXEC SQL END DECLARE SECTION  ; */ 


    /*TM-200412091155 13-12-2004 Soporte RyC PRM*/
    /*Asignación de Variables desde las estructuras de pagos a variables locales*/    
    /*Estructura de CO_CANCELADOS*/    
    lhNumSecuenci		=	stConc.lNumSecuenci;
    ihCodTipDocum		=	stConc.iCodTipDocum;
    lhCodAgente			=	stConc.lCodAgente;
    strcpy(szhLetra, 		stConc.szLetra);    
    ihCodCentremi		=	stConc.iCodCentremi;
    ihCodConcepto		=	stConc.iCodConcepto;
    ihColumna			=	stConc.iColumna;
    ihCodProducto		=	stConc.iCodProducto;
    dhImporteDebe		=	stConc.dImporteDebe;
    dhImporteHaber		=	stConc.dImporteHaber;
    ihIndContado		=	stConc.iIndContado;
    ihIndFacturado		=	stConc.iIndFacturado;
    strcpy(szhFecEfectividad,stConc.szFecEfectividad);
	strcpy(szhFecVencimie,	stConc.szFecVencimie);
	strcpy(szhFecCaducida,	stConc.szFecCaducida);
	strcpy(szhFecAntiguedad,stConc.szFecAntiguedad);
	strcpy(szhFecPago,		stConc.szFecPago);
    lhNumAbonado		=	stConc.lNumAbonado;
    lhNumFolio			=	stConc.lNumFolio;
    lhNumCuota			=	stConc.lNumCuota;
    ihSecCuota			=	stConc.iSecCuota;
    lhNumTransa			=	stConc.lNumTransa;
    lhNumVenta			=	stConc.lNumVenta;
    strcpy(szhFolioCTC, 	stConc.szFolioCTC);
    strcpy(szhPrefPlaza, 	stConc.szPrefPlaza);
    strcpy(szhCodOperadoraScl, stConc.szCodOperadoraScl);
    strcpy(szhCodPlaza, 	stConc.szCodPlaza);

   	vDTrazasLog (szExeName,
                "\n\t\t* Insert Co_Cancelados"
                "\n\t\t=> Cod.Cliente [%ld]"
                "\n\t\t=> Cod.TipDocum[%d] " 
                "\n\t\t=> Cod.Agente  [%ld]" 
                "\n\t\t=> Letra       [%s] " 
                "\n\t\t=> Cod.CentrEmi[%d] " 
                "\n\t\t=> Num.Secuenci[%ld]" 
                "\n\t\t=> Cod.Concepto[%d] " 
                "\n\t\t=> Cod.Producto[%d] " 
                "\n\t\t=> Imp.Debe    [%f] "
                "\n\t\t=> Imp.Haber   [%f] "
                "\n\t\t=> Fec.Efectivi[%s] " 
                "\n\t\t=> Fec.Vencimie[%s] " 
                "\n\t\t=> Fec.Caducida[%s] " 
                "\n\t\t=> Fec.Antigued[%s] " 
                "\n\t\t=> Fec.Pago    [%s] " 
                "\n\t\t=> Num.Abonado [%ld]" 
                "\n\t\t=> Num.Folio   [%ld]" 
                "\n\t\t=> Num.Cuota   [%ld]" 
                "\n\t\t=> Sec.Cuota   [%d] " 
                "\n\t\t=> Num.Transacc[%ld]" 
                "\n\t\t=> Num.Venta   [%ld]"
                "\n\t\t=> Num.CTC     [%s] "
                "\n\t\t=> Pref. Plaza [%s] " /* jlr_11.01.03 */
                "\n\t\t=> Cod.Operador[%s] " /* jlr_11.01.03 */
                "\n\t\t=> Codigo Plaza[%s] " /* jlr_11.01.03 */
                ,LOG05, 
                lCodCliente            , stConc.iCodTipDocum   ,   
                stConc.lCodAgente      , stConc.szLetra        ,
                stConc.iCodCentremi    , stConc.lNumSecuenci   ,
                stConc.iCodConcepto    , stConc.iCodProducto   , 
                stConc.dImporteDebe    , stConc.dImporteHaber  ,
                stConc.szFecEfectividad, stConc.szFecVencimie  ,
                stConc.szFecCaducida   , stConc.szFecAntiguedad,
                stConc.szFecPago       , stConc.lNumAbonado    ,
                stConc.lNumFolio       , stConc.lNumCuota      ,
                stConc.iSecCuota       , stConc.lNumTransa     ,
                stConc.lNumVenta       , stConc.szFolioCTC     ,
                stConc.szPrefPlaza	   ,	/* jlr_11.01.03 */
                stConc.szCodOperadoraScl,	/* jlr_11.01.03 */
                stConc.szCodPlaza	   );	/* jlr_11.01.03 */

   	lhCodCliente       = lCodCliente                             ;
/*   i_shFecEfectividad = (stConc.szFecEfectividad [0] ==  0)?-1:0;
   i_shFecVencimie    = (stConc.szFecVencimie    [0] ==  0)?-1:0;
   i_shFecCaducida    = (stConc.szFecCaducida    [0] ==  0)?-1:0;
   i_shFecPago        = (stConc.szFecPago        [0] ==  0)?-1:0;
   i_shNumFolio       = (stConc.lNumFolio            == -1)?-1:0;
   i_shSecCuota       = (stConc.iSecCuota            == -1)?-1:0;
   i_shNumVenta       = (stConc.lNumVenta            == -1)?-1:0;
   i_shNumTransa      = (stConc.lNumTransa           == -1)?-1:0;
   i_shFolioCTC       = (stConc.szFolioCTC       [0] ==  0)?-1:0;*/

   /*TM-200412091155 13-06-2005 Desarrollo */
   	i_shFecEfectividad = (szhFecEfectividad 	==  0)?-1:0;
   	i_shFecVencimie    = (szhFecVencimie 	==  0)?-1:0;
   	i_shFecCaducida    = (szhFecCaducida 	==  0)?-1:0;
   	i_shFecPago        = (szhFecPago        	==  0)?-1:0;
   	i_shNumFolio       = (lhNumFolio         == -1)?-1:0;
   	i_shSecCuota       = (ihSecCuota         == -1)?-1:0;
   	i_shNumVenta       = (lhNumVenta         == -1)?-1:0;
   	i_shNumTransa      = (lhNumTransa        == -1)?-1:0;
   	i_shFolioCTC       = (szhFolioCTC       	==  0)?-1:0;
  	 
   	/* EXEC SQL INSERT
            INTO CO_CANCELADOS
                 (COD_CLIENTE    ,
                  NUM_SECUENCI   ,
                  COD_TIPDOCUM   ,
                  COD_VENDEDOR_AGENTE,
                  LETRA          ,
                  COD_CENTREMI   ,
                  COD_CONCEPTO   ,
                  COLUMNA        ,
                  COD_PRODUCTO   ,
                  IMPORTE_DEBE   ,
                  IMPORTE_HABER  ,
                  IND_CONTADO    ,
                  IND_FACTURADO  ,
                  FEC_EFECTIVIDAD,
                  FEC_VENCIMIE   ,
                  FEC_CADUCIDA   ,
                  FEC_ANTIGUEDAD ,
                  FEC_PAGO       ,
                  NUM_ABONADO    ,
                  NUM_FOLIO      , 
                  NUM_CUOTA      ,
                  SEC_CUOTA      ,
                  NUM_TRANSACCION,
                  NUM_VENTA      ,
                  FEC_CANCELACION,
                  IND_PORTADOR   ,
                  NUM_FOLIOCTC   ,
                  PREF_PLAZA         , /o jlr_11.01.03 o/
                  COD_OPERADORA_SCL  , /o jlr_11.01.03 o/
                  COD_PLAZA          ) /o jlr_11.01.03 o/
            VALUES
                 (:lhCodCliente        ,
                  :lhNumSecuenci ,
                  :ihCodTipDocum ,
                  :lhCodAgente   ,
                  :szhLetra      ,
                  :ihCodCentremi ,
                  :ihCodConcepto ,
                  :ihColumna     ,
                  :ihCodProducto ,
                  :dhImporteDebe ,
                  :dhImporteHaber,
                  :ihIndContado  ,
                  :ihIndFacturado,
                  TO_DATE(:szhFecEfectividad, 'YYYYMMDD'),
                  TO_DATE(:szhFecVencimie    :i_shFecVencimie  , 'YYYYMMDD'),
                  TO_DATE(:szhFecCaducida    :i_shFecCaducida  , 'YYYYMMDD'),
                  TO_DATE(:szhFecAntiguedad  :i_shFecAntiguedad, 'YYYYMMDD'),
                  TO_DATE(:szhFecPago        :i_shFecPago      , 'YYYYMMDD'),
                  :lhNumAbonado              :i_shNumAbonado   ,
                  :lhNumFolio                :i_shNumFolio     ,
                  :lhNumCuota                :i_shNumCuota     ,
                  :ihSecCuota                :i_shSecCuota     ,
                  :lhNumTransa               :i_shNumTransa    ,
                  :lhNumVenta                :i_shNumVenta     ,
                  SYSDATE                                      ,
                  0                                            ,
                  :szhFolioCTC               :i_shFolioCTC     ,
	          	  :szhPrefPlaza	        ,
	          	  :szhCodOperadoraScl 	,
	          	  :szhCodPlaza	 		); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 37;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_CANCELADOS (COD_CLIENTE,NUM_SECUENCI,COD_T\
IPDOCUM,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUC\
TO,IMPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_VE\
NCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_ABONADO,NUM_FOLIO,NUM_CUOTA,SE\
C_CUOTA,NUM_TRANSACCION,NUM_VENTA,FEC_CANCELACION,IND_PORTADOR,NUM_FOLIOCTC,PR\
EF_PLAZA,COD_OPERADORA_SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,\
:b8,:b9,:b10,:b11,:b12,TO_DATE(:b13,'YYYYMMDD'),TO_DATE(:b14:b15,'YYYYMMDD'),T\
O_DATE(:b16:b17,'YYYYMMDD'),TO_DATE(:b18:b19,'YYYYMMDD'),TO_DATE(:b20:b21,'YYY\
YMMDD'),:b22:b23,:b24:b25,:b26:b27,:b28:b29,:b30:b31,:b32:b33,SYSDATE,0,:b34:b\
35,:b36,:b37,:b38)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1616;
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
    sqlstm.sqindv[14] = (         short *)&i_shFecVencimie;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhFecCaducida;
    sqlstm.sqhstl[15] = (unsigned long )9;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)&i_shFecCaducida;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhFecAntiguedad;
    sqlstm.sqhstl[16] = (unsigned long )9;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)&i_shFecAntiguedad;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhFecPago;
    sqlstm.sqhstl[17] = (unsigned long )9;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)&i_shFecPago;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)&i_shNumAbonado;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)&i_shNumFolio;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&lhNumCuota;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)&i_shNumCuota;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&ihSecCuota;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)&i_shSecCuota;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&lhNumTransa;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)&i_shNumTransa;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)&i_shNumVenta;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)szhFolioCTC;
    sqlstm.sqhstl[24] = (unsigned long )12;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)&i_shFolioCTC;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[25] = (unsigned long )26;
    sqlstm.sqhsts[25] = (         int  )0;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)szhCodOperadoraScl;
    sqlstm.sqhstl[26] = (unsigned long )6;
    sqlstm.sqhsts[26] = (         int  )0;
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)szhCodPlaza;
    sqlstm.sqhstl[27] = (unsigned long )6;
    sqlstm.sqhsts[27] = (         int  )0;
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
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



				/*TM-200412091155 13-06-2005 Desarrollo */
/*                  :stConc.lNumSecuenci ,
                  :stConc.iCodTipDocum ,
                  :stConc.lCodAgente   ,
                  :stConc.szLetra      ,
                  :stConc.iCodCentremi ,
                  :stConc.iCodConcepto ,
                  :stConc.iColumna     ,
                  :stConc.iCodProducto ,
                  :stConc.dImporteDebe ,
                  :stConc.dImporteHaber,
                  :stConc.iIndContado  ,
                  :stConc.iIndFacturado,
                  TO_DATE(:stConc.szFecEfectividad, 'YYYYMMDD'),
                  TO_DATE(:stConc.szFecVencimie    :i_shFecVencimie  , 'YYYYMMDD'),
                  TO_DATE(:stConc.szFecCaducida    :i_shFecCaducida  , 'YYYYMMDD'),
                  TO_DATE(:stConc.szFecAntiguedad  :i_shFecAntiguedad, 'YYYYMMDD'),
                  TO_DATE(:stConc.szFecPago        :i_shFecPago      , 'YYYYMMDD'),
                  :stConc.lNumAbonado              :i_shNumAbonado   ,
                  :stConc.lNumFolio                :i_shNumFolio     ,
                  :stConc.lNumCuota                :i_shNumCuota     ,
                  :stConc.iSecCuota                :i_shSecCuota     ,
                  :stConc.lNumTransa               :i_shNumTransa    ,
                  :stConc.lNumVenta                :i_shNumVenta     ,
                  SYSDATE                                            ,
                  0                                                  ,
                  :stConc.szFolioCTC               :i_shFolioCTC     ,
	          	  :stConc.szPrefPlaza	 		             ,	/ jlr_11.01.03 /
	          	  :stConc.szCodOperadoraScl 		         ,	/ jlr_11.01.03 /
	          	  :stConc.szCodPlaza	 		             );	/ jlr_11.01.03 */

   	if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_Cancelados", szfnORAerror ());

   	return (SQLCODE)?FALSE:TRUE;

}/**************************** Final bfnDBInsertCancelados *******************/

/****************************************************************************************************/
/* rtrim()																		   					*/
/****************************************************************************************************/
void rtrim( char *szCadena )
/*
	Definicion		:	Quita los espacios en blanco a la derecha de una cadena.
	
	Parametros		:	szCadena	cadena de trabajo.
	
*/
{
	char modulo[] = "rtrim";
	 int i, iLen, iCnt;

    iLen = strlen( szCadena ) - 1;
    for( iCnt = iLen; iCnt >= 0; iCnt-- ) if( szCadena[iCnt] != ' ' && szCadena[iCnt] != '\0' ) break;
    szCadena[ iCnt + 1 ] = '\0'; 	/* reemplaza primer ' ' por '\0' produciendo un rtrim */
    return;
} /* void rtrim( char *szCadena ) */

/****************************************************************************************************/
/* bProcesaPagoLimiteConsumo()													   					*/
/****************************************************************************************************/
BOOL bProcesaPagoLimiteConsumo( long lCodCliente )
/*
	Definicion		:	Verifica si el cliente tiene pago por limite de consumo y si lo hubiera
						deja el indicador ind_facturado de 3 en 1..
	
	Parametros		:	lCodCliente		Codigo de Cliente.
*/
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente;
	int  ihCntDoc;
	char szhCARTERA    [11];
	char szhCONSUMO    [16];
	char szhCO          [3];
	int  ihValor_uno = 1   ;
/* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente = lCodCliente;
	strcpy(szhCARTERA,"CO_CARTERA");
	strcpy(szhCONSUMO,"PAG_LIM_CONSUMO");
	strcpy(szhCO,"CO");

	/* vemos si hay pagos por limite de consumo */
	/* EXEC SQL
	SELECT COUNT(*)
	INTO  :ihCntDoc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE = :lhCodCliente
	AND   COD_TIPDOCUM IN ( SELECT COD_VALOR 
	   						FROM GED_CODIGOS
	   						WHERE NOM_TABLA = :szhCARTERA
	   						  AND NOM_COLUMNA = :szhCONSUMO
	   						  AND COD_MODULO  = :szhCO ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from CO_CARTERA where (COD_CLIENT\
E=:b1 and COD_TIPDOCUM in (select COD_VALOR  from GED_CODIGOS where ((NOM_TABL\
A=:b2 and NOM_COLUMNA=:b3) and COD_MODULO=:b4)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1743;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntDoc;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCONSUMO;
 sqlstm.sqhstl[3] = (unsigned long )16;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCO;
 sqlstm.sqhstl[4] = (unsigned long )3;
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

  

	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
		iDError( szExePasoC, ERR043, vInsertarIncidencia, "Comprobando Pagos Limite Consumo." );
		return FALSE;
	}

    vDTrazasLog( szExePasoC, "Cliente => [%d] Documentos Pago. Limite de Consumo => [%d].", LOG03, lhCodCliente, ihCntDoc );

	if( ihCntDoc > 0 )
	{
		/* debemos cambiar el valor del campo ind_facturado de 3 a 1 */
		/* EXEC SQL
		UPDATE CO_CARTERA SET 
		       IND_FACTURADO = :ihValor_uno
		WHERE  COD_CLIENTE   = :lhCodCliente
		AND    COD_TIPDOCUM IN (SELECT COD_VALOR 
		   					    FROM GED_CODIGOS
		   						WHERE NOM_TABLA = :szhCARTERA
		   						  AND NOM_COLUMNA = :szhCONSUMO
		   						  AND COD_MODULO  = :szhCO ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 37;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update CO_CARTERA  set IND_FACTURADO=:b0 where (COD_CLIENTE\
=:b1 and COD_TIPDOCUM in (select COD_VALOR  from GED_CODIGOS where ((NOM_TABLA\
=:b2 and NOM_COLUMNA=:b3) and COD_MODULO=:b4)))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )1778;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCARTERA;
  sqlstm.sqhstl[2] = (unsigned long )11;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCONSUMO;
  sqlstm.sqhstl[3] = (unsigned long )16;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCO;
  sqlstm.sqhstl[4] = (unsigned long )3;
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

  

		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
		{
			iDError( szExePasoC, ERR043, vInsertarIncidencia, "Actualizando Pagos Limite de Consumo." );
			return FALSE;
		}
	} /* if( ihCntDoc > 0 ) */
	
	return TRUE;
} /* bProcesaPagoLimiteConsumo( long lCodCliente ) */

/* Inicio Requerimiento de Soporte - 84622 - 13.04.2009 MQG */
/*****************************************************************************/
/*                         funcion : bfnDBCargaAcumulaConceptos              */
/* -Funcion que carga todos los conceptos de una Factura (Fa_HistConc),      */
/*  reemplaza a la funcion bfnDBCargaHistConc()                              */
/* -El Campo IndOrdenTotal identifica dicha Factura.                         */
/*  Se cargan los conceptos de Fa_HistConc de la Factura en proceso,         */
/*  pstAcumAbo se van agrupando por abonado y producto los conceptos de      */
/*  Facturacion que se trasforman en un Concepto de Cobros, con dos          */
/*  observaciones :                                                          */
/*     1.-  No se recogen los Conceptos Recargos ya que son generados por el */
/*        modulo de Cobros.                                                  */
/*     2.-  En el caso de ser parte de una Cuota el Concepto de Facturacion  */
/*        la relacion con los conceptos de Cobros es uno a uno y no se acumu-*/
/*        la, y se informa el SeqCuota y OrdCuota.                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnDBCargaAcumulaConceptos(	DATOS_FACT stFactDocu, ACUMABO *pstAcumAbo , COFACTCOBR *pstFactCobr, BOOL *bConcepNegativos, ACUMABO *pstAcumCon )
{
int  iRes      = 0;
int  iErrorNeg = 0;
BOOL bError    = FALSE; 

	lTotalConceptos = 0; 
	iRes = ifnDBFetchConceptos( pstAcumAbo, pstFactCobr, stFactDocu.szIndOrdenTotal, pstAcumCon);

	if (lTotalConceptos == 0 ) {
   	    vDTrazasLog( szExePasoC, "\n\t\t=> Documento NO contiene detalle - szIndOrdenTotal [%s]", LOG04, stFactDocu.szIndOrdenTotal); 
   	    stFactDocu.iIndPasoCobro = 1;                                 
       	if (!bfnDBUpdateHistDocu (stFactDocu))   bError = TRUE;       

		return bError;  
	} /* end if (lTotalConceptos == 0 ) */

	if( lTotAbonados > 0) {
		vDTrazasLog( szExePasoC, "\n\t\t=> Numero de Abonados [%ld]", LOG04, lTotAbonados );
		vfnPrintAcumAbo( pstAcumAbo, &iErrorNeg );

		if( ifnDBCloseHistConc() )
			return FALSE;

		if( iErrorNeg ) /* si hay conceptos negativos */
			*bConcepNegativos = TRUE;
	} /* end if( iRes == SQLNOTFOUND ) */

	return TRUE;

}/* End bfnDBCargaAcumulaConceptos */

/*****************************************************************************/
/*                          funcion : ifnDBFetchConceptos                    */
/* Funcion reemplaza a ifnDBFetchHistConc                                    */
/* -Funcion que hace un Fetch sobre Fa_HistConc y acumula conceptos          */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static int ifnDBFetchConceptos (ACUMABO *pstAcumAbo, COFACTCOBR *pstFactCobr, char *szIndOrdenTotal, ACUMABO *pstAcumCon)
{
BOOL bHayRegistros   = TRUE ;
long  iNumConc       = 0    ;
long  iNumAbo        = 0    ;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char   szhIndOrdenTotal[13]; /* EXEC SQL VAR szhIndOrdenTotal IS STRING(13); */ 

   static char   szhQuery      [1024]; /* EXEC SQL VAR szhQuery         IS STRING(1024); */ 

   static long   lhNumAbonado     ;
   static int    ihCodConcepto    ;
   static double dhImpFacturable  ;
   static long   lhSeqCuotas      ;
   static int    ihOrdCuota       ;
   static short  shIndFactur      ;
   static int    ihCodProducto    ;
          long   lhNumAbonadoAux  ;
   static char   shCodRecargo  [3]; /* EXEC SQL VAR shCodRecargo         IS STRING(3); */ 

          int    ihCreaLista      ; 
          int    ihTotConAjuste   ; 
          int    ihIndConcepto    ; 
          int    ihExisteConcepto ; 
          int    ihIndice         ; 
/* EXEC SQL END DECLARE SECTION; */ 


	ihCreaLista	    =  0; 
	lhNumAbonadoAux = -1;
	memset(szhIndOrdenTotal, 0, sizeof(szhIndOrdenTotal));
	memset(shCodRecargo    , 0, sizeof(shCodRecargo));
	strcpy (szhIndOrdenTotal, szIndOrdenTotal);
	sprintf(shCodRecargo,"%d",stDatosGener.iCodRecargo);

vDTrazasLog (szExePasoC,"\n\n\t szNomTablaDet [%s] \n", LOG05, szNomTablaDet);
vDTrazasLog (szExePasoC,"\n\n\t szNomTablaDetalle [%s] \n", LOG05, szNomTablaDetalle);

	strcpy(szhQuery,"SELECT 0 as NUM_ABONADO,");
	strcat(szhQuery,"B.COD_CONCCOBR,");
	strcat(szhQuery,"ge_pac_general.redondea (SUM(IMP_FACTURABLE),2,0),");
	strcat(szhQuery,"1 as SEQ_CUOTAS,");
	strcat(szhQuery,"1 as ORD_CUOTA ,");
	strcat(szhQuery,"1 as IND_FACTUR,");
	strcat(szhQuery,"A.COD_PRODUCTO ");
	strcat(szhQuery,"FROM ");
	strcat(szhQuery,szNomTablaDetalle);
	strcat(szhQuery," A, FA_FACTCOBR B ");
	strcat(szhQuery," WHERE A.IND_ORDENTOTAL = ");
	strcat(szhQuery,szhIndOrdenTotal);
	strcat(szhQuery," AND A.COLUMNA  > 0 ");
	strcat(szhQuery," AND A.COD_CONCEPTO  = B.COD_CONCFACT ");
	strcat(szhQuery," AND B.COD_CONCCOBR <> ");
	strcat(szhQuery,shCodRecargo);
	strcat(szhQuery," GROUP BY B.COD_CONCCOBR, A.COD_PRODUCTO "); 

	vDTrazasLog (szExePasoC,"\n\n\t szhQuery [%s] \n", LOG05, szhQuery);

	/* EXEC SQL PREPARE sql_query_detalle FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1813;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE) {
		vDTrazasLog (szExePasoC,"\n\n\tERROR al PREPARAR QUERY en ifnDBFetchConceptos\n", LOG05);
		return SQLCODE;
	}

	/* EXEC SQL DECLARE cursor_detalleconcepto CURSOR FOR sql_query_detalle; */ 

	if (SQLCODE) {
		vDTrazasLog (szExePasoC,"\n\n\tERROR al DECLARAR CURSOR en ifnDBFetchConceptos\n", LOG05);
		return SQLCODE;
	}

	vDTrazasLog (szExePasoC, "\n\t\t* Parametros Entra Open [%s] "
							 "\n\t\t=>Ind.OrdenTotal  [%s]",LOG04,szNomTablaDet, szIndOrdenTotal);

	/* EXEC SQL OPEN cursor_detalleconcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1832;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE)
		iDError (szExePasoC,ERR000,vInsertarIncidencia,"Open cursor_detalleconcepto", szfnORAerror ());

    iNumAbo = -1;
	while (bHayRegistros) {
  		/* EXEC SQL FETCH cursor_detalleconcepto
            INTO :lhNumAbonado    ,
                 :ihCodConcepto   ,
                 :dhImpFacturable ,
                 :lhSeqCuotas     ,
                 :ihOrdCuota      ,
                 :shIndFactur     ,
           	     :ihCodProducto   ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 37;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1847;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[2] = (unsigned char  *)&dhImpFacturable;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhSeqCuotas;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihOrdCuota;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&shIndFactur;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
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



		if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)	{
   			iDError (szExePasoC,ERR000,vInsertarIncidencia,"Fetch:cursor_detalleconcepto (2)=>", szfnORAerror ());
   		}

		if (SQLCODE == SQLNOTFOUND)	{
			bHayRegistros = FALSE;
   			break;
   		}

   		if (SQLCODE == SQLOK) {
	        if (lhNumAbonadoAux == lhNumAbonado) {
   	  			iNumConc++;
   	  		} else {
   	  		   	iNumAbo++;
   	  		   	iNumConc = 0;
   	  		   	lhNumAbonadoAux = lhNumAbonado;

        		if ((pstAcumAbo->pAboCobr = (ABOCOBR *)realloc ((ABOCOBR *)pstAcumAbo->pAboCobr,
           									(iNumAbo+1)*sizeof(ABOCOBR)))==(ABOCOBR *)NULL)	{
         			iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumAbo->pAboCobr");
           			return  FALSE;
        		} /* end if ((pstAcumAbo->pAboCobr = ...*/

          		pstAcumAbo->pAboCobr[iNumAbo].lNumAbonado  = lhNumAbonado;
         		pstAcumAbo->pAboCobr[iNumAbo].iCodProducto = ihCodProducto;
          		pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos= 0    ;
          		pstAcumAbo->pAboCobr[iNumAbo].pConcCobr    = (CONCCOBR *)NULL;
          		pstAcumAbo->iNumReg++;

        		vDTrazasLog( szExePasoC, "\n\t=> [%ld]-Introducir Abonado [%ld]", LOG06, pstAcumAbo->iNumReg, lhNumAbonado );
        		vDTrazasLog( szExePasoC, "\n\t=> [%ld]-Introducir Abonado [%ld]", LOG06, iNumAbo, lhNumAbonado );

        		if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr =
        		    realloc ((CONCCOBR *)pstAcumAbo->pAboCobr[iNumAbo].pConcCobr,
        		    sizeof(CONCCOBR)*(pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos))) == (CONCCOBR *)NULL) {

            		iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumAbo->pAboCobr->pConcCobr");
            		return  FALSE;
       			} /* end if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr = realloc...*/

            	/* Crear Lista para acumular montos por conceptos. Abonado = 0 */
            	if(ihCreaLista == 0) {
        			if ((pstAcumCon->pAboCobr = (ABOCOBR *)realloc ((ABOCOBR *)pstAcumCon->pAboCobr,
           				(iNumAbo+1)*sizeof(ABOCOBR)))==(ABOCOBR *)NULL)	{
         				iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumCon->pAboCobr");
           				return  FALSE;
        			} /* end if ((pstAcumAbo->pAboCobr = ...*/

          			pstAcumCon->pAboCobr[0].lNumAbonado  = 0;
          			pstAcumCon->pAboCobr[0].iNumConceptos= 0;
          			pstAcumCon->pAboCobr[0].pConcCobr    = (CONCCOBR *)NULL;
          			pstAcumCon->iNumReg++;

        			if((pstAcumCon->pAboCobr[0].pConcCobr =
        		    	realloc ((CONCCOBR *)pstAcumCon->pAboCobr[0].pConcCobr,
        		    	sizeof(CONCCOBR)*(pstAcumCon->pAboCobr[0].iNumConceptos))) == (CONCCOBR *)NULL) {

            			iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumCon->pAboCobr->pConcCobr");
            			return  FALSE;
       				} /* end if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr = realloc...*/
            		ihTotConAjuste = 0;
            		ihCreaLista    = 1;
            	} /* end if(ihCreaLista === 0) */

   	  		} /* end if (lhNumAbonadoAux == lhNumAbonado) */

        	vDTrazasLog( szExePasoC, "\t=> [%ld] Introducir Concepto [%ld] Abonado [%ld]", LOG06, iNumConc, ihCodConcepto, lhNumAbonado );

        	pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iCodConcCobr = ihCodConcepto;
        	dhImpFacturable = fnCnvDouble(dhImpFacturable, pstParamGener.iNumDecimal);
        	pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].dImpConcCobr = dhImpFacturable;
        	pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].lSeqCuotas   = lhSeqCuotas;
        	pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iOrdCuota    = ihOrdCuota ;
        	pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iIndFactur   = shIndFactur;
        	pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos++;

			vDTrazasLog( szExePasoC, "\t=> iNumAbo [%ld] -  iNumConc [%ld]" , LOG06, iNumAbo, iNumConc );
			vDTrazasLog( szExePasoC, "\t=> lNumAbonado     [%ld]" , LOG07, pstAcumAbo->pAboCobr[iNumAbo].lNumAbonado );
			vDTrazasLog( szExePasoC, "\t=> iCodProducto    [%d] " , LOG07, pstAcumAbo->pAboCobr[iNumAbo].iCodProducto );
			vDTrazasLog( szExePasoC, "\t=> ihCodConcepto   [%d]"  , LOG07, pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iCodConcCobr );
			vDTrazasLog( szExePasoC, "\t=> dhImpFacturable [%f]"  , LOG07, pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].dImpConcCobr );
			vDTrazasLog( szExePasoC, "\t=> lhSeqCuotas     [%d]"  , LOG07, pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].lSeqCuotas );
			vDTrazasLog( szExePasoC, "\t=> iOrdCuota       [%d] " , LOG07, pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iOrdCuota );
			vDTrazasLog( szExePasoC, "\t=> iIndFactur      [%d] " , LOG07, pstAcumAbo->pAboCobr[iNumAbo].pConcCobr[iNumConc].iIndFactur );
			vDTrazasLog( szExePasoC, "\t=> iNumConceptos   [%d] " , LOG07, pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos );

        	if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr =
        	    realloc ((CONCCOBR *)pstAcumAbo->pAboCobr[iNumAbo].pConcCobr,
        	    sizeof(CONCCOBR)*(pstAcumAbo->pAboCobr[iNumAbo].iNumConceptos+1))) == (CONCCOBR *)NULL) {

            	iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumAbo->pAboCobr->pConcCobr");
            	return  FALSE;

       		} /* end if((pstAcumAbo->pAboCobr[iNumAbo].pConcCobr = realloc...*/

            /* Crear Lista para acumular montos por conceptos. Abonado = 0 */
       		if (ihTotConAjuste > 0) {
       			ihExisteConcepto = 0;
       			/* Buscando si existe codigo de concepto */
				for( ihIndConcepto = 0; ihIndConcepto < pstAcumCon->pAboCobr[0].iNumConceptos; ihIndConcepto++ )
				{
					if (pstAcumCon->pAboCobr[0].pConcCobr[ihIndConcepto].iCodConcCobr == ihCodConcepto) {
						ihExisteConcepto = 1;
						ihIndice = ihIndConcepto;
						exit;
				    } /* end if */
				}/* end for( ihIndConcepto = 0; ihIndConcepto < pstAcumCon->pAboCobr[0].iNumConceptos; ihIndConcepto++ ) */

               if (ihExisteConcepto == 1) {
        			pstAcumCon->pAboCobr[0].pConcCobr[ihIndice].dImpConcCobr = pstAcumCon->pAboCobr[0].pConcCobr[ihIndice].dImpConcCobr +
        			                                                           dhImpFacturable;
               } else {
       				pstAcumCon->pAboCobr[0].pConcCobr[ihTotConAjuste].iCodConcCobr = ihCodConcepto;
        			pstAcumCon->pAboCobr[0].pConcCobr[ihTotConAjuste].dImpConcCobr = dhImpFacturable;
        			pstAcumCon->pAboCobr[0].iNumConceptos++;
               		ihTotConAjuste = ihTotConAjuste + 1;

        			if((pstAcumCon->pAboCobr[0].pConcCobr =
        	    		realloc ((CONCCOBR *)pstAcumCon->pAboCobr[0].pConcCobr,
        	    		sizeof(CONCCOBR)*(pstAcumCon->pAboCobr[0].iNumConceptos+1))) == (CONCCOBR *)NULL) {
            			iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumCon->pAboCobr->pConcCobr");
            			return  FALSE;
       				} /* end if((pstAcumCon->pAboCobr[iNumAbo].pConcCobr = realloc...*/

       		   } /* end if (ihExisteConcepto == 1) {*/

       		} else { /* Primer registro */
       			pstAcumCon->pAboCobr[0].pConcCobr[ihTotConAjuste].iCodConcCobr = ihCodConcepto;
        		pstAcumCon->pAboCobr[0].pConcCobr[ihTotConAjuste].dImpConcCobr = dhImpFacturable;
        		pstAcumCon->pAboCobr[0].iNumConceptos++;

        		ihTotConAjuste = ihTotConAjuste + 1;

        		if((pstAcumCon->pAboCobr[0].pConcCobr =
        	    	realloc ((CONCCOBR *)pstAcumCon->pAboCobr[0].pConcCobr,
        	    	sizeof(CONCCOBR)*(pstAcumCon->pAboCobr[0].iNumConceptos+1))) == (CONCCOBR *)NULL) {
            		iDError (szExePasoC,ERR005,vInsertarIncidencia, "pstAcumCon->pAboCobr->pConcCobr");
            		return  FALSE;
       			} /* end if((pstAcumCon->pAboCobr[iNumAbo].pConcCobr = realloc...*/

       		} /* end if (ihTotConAjuste > 0)*/
       		lTotalConceptos++; /* Total conceptos del documento */
   		} /* end if (SQLCODE == SQLOK) */

	}/* ènd while (bHayRegistros) */

    lTotAbonados = iNumAbo;
	return TRUE;

}/* End ifnDBFetchConceptos */

/*****************************************************************************/
/*                          funcion : bfnDBVerificaConceptos                 */
/*****************************************************************************/
BOOL bfnDBVerificaConceptos(CONFIG stConfig)
{
BOOL bHayRegistros   = TRUE ;
       int  iConceptos;
static long lhCodCicloFactura;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char   szhQuery         [1024];/* EXEC SQL VAR szhQuery           IS STRING(1024); */ 

   static char   szhCodCicloFactura  [9];/* EXEC SQL VAR szhCodCicloFactura IS STRING(9); */ 

   int ihCodConcepto       ;
   int ihCntConcepto       ;
/* EXEC SQL END DECLARE SECTION; */ 


	iConceptos = 0;
    lhCodCicloFactura = stConfig.lCodCicloFact;
    sprintf(szhCodCicloFactura,"%d ",lhCodCicloFactura);

    if( stConfig.bOptCodCicloFact ) /* Caso que es Ciclo */
    {
        strcpy(szNomTablaDetalle,"FA_FACTCONC_");
        strcat(szNomTablaDetalle,szhCodCicloFactura);
    } else {/*  NO CICLO */
        strcpy(szNomTablaDetalle,"FA_FACTCONC_NOCICLO ");
    }

	strcpy(szhQuery,"SELECT DISTINCT COD_CONCEPTO ");
	strcat(szhQuery,"FROM ");
	strcat(szhQuery,szNomTablaDetalle);

	vDTrazasLog (szExePasoC,"\n\n\t szhQuery [%s] \n", LOG05, szhQuery);

	/* EXEC SQL PREPARE sql_query_concepto FROM :szhQuery; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1890;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE) {
		vDTrazasLog (szExePasoC,"\n\n\tERROR al PREPARAR QUERY en bfnDBVerificaConceptos \n", LOG05);
		return FALSE;
	}

	/* EXEC SQL DECLARE cursor_concepto CURSOR FOR sql_query_concepto; */ 

	if (SQLCODE) {
		vDTrazasLog (szExePasoC,"\n\n\tERROR al DECLARAR CURSOR en cursor_concepto\n", LOG05);
		return FALSE;
	}

	vDTrazasLog (szExePasoC, "\n\t\t* Parametros Entra Open cursor_concepto [%s] ",LOG04,szNomTablaDetalle);

	/* EXEC SQL OPEN cursor_concepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 37;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1909;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE)
		iDError (szExePasoC,ERR000,vInsertarIncidencia,"Open cursor_concepto", szfnORAerror ());

	while (bHayRegistros) {
  		/* EXEC SQL FETCH cursor_concepto
            INTO :ihCodConcepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 37;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1924;
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



		if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)	{
   			iDError (szExePasoC,ERR000,vInsertarIncidencia,"Fetch:cursor_concepto (2)=>", szfnORAerror ());
   		}

		if (SQLCODE == SQLNOTFOUND)	{
			bHayRegistros = FALSE;
   			break;
   		}

   		if (SQLCODE == SQLOK) {
   		    ihCntConcepto = 0;
			/* EXEC SQL
			SELECT COUNT(1)
			INTO  :ihCntConcepto
            FROM FA_FACTCOBR
	        WHERE COD_CONCFACT = :ihCodConcepto; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 37;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(1) into :b0  from FA_FACTCOBR where COD_CONCF\
ACT=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )1943;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCntConcepto;
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



	        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
		        iDError( szExePasoC, ERR043, vInsertarIncidencia, "Comprobando Conceptos de Facturacion." );
		        return FALSE;
	        }

   		    if (ihCntConcepto == 0)	{
    			vDTrazasLog (szExePasoC,"\n\n\t ERROR...!!!! Concepto [%d] No se encuentra configurado ", LOG05,ihCodConcepto);
		        iDError( szExePasoC, ERR043, vInsertarIncidencia, " Concepto No se encuentra configurado... \n");
		        iConceptos = 1;
   		    }
   		} /* end if (SQLCODE == SQLOK) */
     } /* end while (bHayRegistros) {*/

	 if (iConceptos == 1) return FALSE;
	 return TRUE;
}/* end bfnDBVerificaConceptos */

/* Fin Requerimiento de Soporte - 84622 - 13.04.2009 MQG */

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
