
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
           char  filnam[14];
};
static const struct sqlcxp sqlfpn =
{
    13,
    "./pc/geora.pc"
};


static unsigned int sqlctx = 431203;


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

 static const char *sq0013 = 
"select A.ROLE ,NVL(B.PASSWORD,CHR(0))  from GE_SEG_USUROLES A ,GE_SEG_ROLE B\
 ,GE_SEG_USUARIO C where ((A.ROLE=B.ROLE and A.NOM_USUARIO=C.NOM_USUARIO) and \
A.NOM_USUARIO=:b0)           ";

 static const char *sq0014 = 
"select A.ROLE ,NVL(B.PASSWORD,CHR(0))  from GE_SEG_GRPROLES A ,GE_SEG_ROLE B\
 ,GE_SEG_GRPUSUARIO C where ((A.ROLE=B.ROLE and A.COD_GRUPO=C.COD_GRUPO) and C\
.NOM_USUARIO=:b0)           ";

 static const char *sq0016 = 
"select NOM_PARAMETRO ,VAL_PARAMETRO  from GED_PARAMETROS where NOM_PARAMETRO\
 in (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,27,41,0,0,4,4,0,1,0,1,5,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
36,0,0,2,32,0,4,47,0,0,1,0,0,1,0,2,5,0,0,
55,0,0,3,12,0,1,57,0,0,0,0,0,1,0,
70,0,0,4,0,0,32,82,0,0,0,0,0,1,0,
85,0,0,5,0,0,30,96,0,0,0,0,0,1,0,
100,0,0,6,0,0,31,110,0,0,0,0,0,1,0,
115,0,0,7,0,0,29,123,0,0,0,0,0,1,0,
130,0,0,8,0,0,17,153,0,0,1,1,0,1,0,1,97,0,0,
149,0,0,8,0,0,21,156,0,0,0,0,0,1,0,
164,0,0,8,0,0,17,175,0,0,1,1,0,1,0,1,97,0,0,
183,0,0,8,0,0,21,178,0,0,0,0,0,1,0,
198,0,0,9,0,0,24,201,0,0,1,1,0,1,0,1,97,0,0,
217,0,0,10,0,0,17,214,0,0,1,1,0,1,0,1,97,0,0,
236,0,0,10,0,0,11,240,0,0,1,1,0,1,0,1,32,0,0,
255,0,0,10,0,0,14,254,0,0,1,0,0,1,0,2,32,0,0,
274,0,0,10,0,0,15,270,0,0,0,0,0,1,0,
289,0,0,10,0,0,19,289,0,0,1,1,0,1,0,3,32,0,0,
308,0,0,11,0,0,24,589,0,0,1,1,0,1,0,1,5,0,0,
327,0,0,12,0,0,24,595,0,0,1,1,0,1,0,1,5,0,0,
346,0,0,13,183,0,9,605,0,0,1,1,0,1,0,1,97,0,0,
365,0,0,13,0,0,13,612,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
388,0,0,13,0,0,15,624,0,0,0,0,0,1,0,
403,0,0,14,182,0,9,634,0,0,1,1,0,1,0,1,97,0,0,
422,0,0,14,0,0,13,641,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
445,0,0,14,0,0,15,652,0,0,0,0,0,1,0,
460,0,0,15,0,0,24,662,0,0,1,1,0,1,0,1,5,0,0,
479,0,0,16,137,0,9,730,0,0,11,11,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
538,0,0,16,0,0,13,737,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
561,0,0,16,0,0,15,744,0,0,0,0,0,1,0,
};


#define __GEORA__
#include <stdio.h>
#include <ctype.h>
#include <sqlcpr.h>
#include "geora.h"

#define	DEC(c)	(((c) - ' ') & 077)		

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
/* EXEC SQL INCLUDE sqlda;
 */ 
/*
 * $Header: sqlda.h 08-may-2002.12:13:42 apopat Exp $ sqlda.h 
 */

/***************************************************************
*      The SQLDA descriptor definition                         *
*--------------------------------------------------------------*
*      VAX/3B Version                                          *
*                                                              *
* Copyright (c) 1987, 2002, Oracle Corporation.  All rights reserved.  *
***************************************************************/


/* NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************
*/

/*  MODIFIED
    apopat     05/08/02  - [2362423] MVS PE to make lines shorter than 79
    apopat     07/31/99 -  [707588] TAB to blanks for OCCS
    lvbcheng   10/27/98 -  change long to int for sqlda
    lvbcheng   08/15/97 -  Move sqlda protos to sqlcpr.h
    lvbcheng   06/25/97 -  Move sqlda protos to this file
    jbasu      01/29/95 -  correct typo
    jbasu      01/27/95 -  correct comment - ub2->sb2
    jbasu      12/12/94 - Bug 217878: note this is an SOSD file
    Morse      12/01/87 - undef L and S for v6 include files
    Richey     07/13/87 - change int defs to long 
    Clare      09/13/84 - Port: Ch types to match SQLLIB structs
    Clare      10/02/86 - Add ifndef SQLDA
*/

#ifndef SQLDA_
#define SQLDA_ 1
 
#ifdef T
# undef T
#endif
#ifdef F
# undef F
#endif

#ifdef S
# undef S
#endif
#ifdef L
# undef L
#endif
 
struct SQLDA {
  /* ub4    */ int        N; /* Descriptor size in number of entries        */
  /* text** */ char     **V; /* Ptr to Arr of addresses of main variables   */
  /* ub4*   */ int       *L; /* Ptr to Arr of lengths of buffers            */
  /* sb2*   */ short     *T; /* Ptr to Arr of types of buffers              */
  /* sb2**  */ short    **I; /* Ptr to Arr of addresses of indicator vars   */
  /* sb4    */ int        F; /* Number of variables found by DESCRIBE       */
  /* text** */ char     **S; /* Ptr to Arr of variable name pointers        */
  /* ub2*   */ short     *M; /* Ptr to Arr of max lengths of var. names     */
  /* ub2*   */ short     *C; /* Ptr to Arr of current lengths of var. names */
  /* text** */ char     **X; /* Ptr to Arr of ind. var. name pointers       */
  /* ub2*   */ short     *Y; /* Ptr to Arr of max lengths of ind. var. names*/
  /* ub2*   */ short     *Z; /* Ptr to Arr of cur lengths of ind. var. names*/
  };
 
typedef struct SQLDA SQLDA;
 
#endif

/* ----------------- */
/* defines for sqlda */
/* ----------------- */

#define SQLSQLDAAlloc(arg1, arg2, arg3, arg4) sqlaldt(arg1, arg2, arg3, arg4) 

#define SQLSQLDAFree(arg1, arg2) sqlclut(arg1, arg2) 



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
/*  */ 
/*
 * $Header: sqlda.h 08-may-2002.12:13:42 apopat Exp $ sqlda.h 
 */

/***************************************************************
*      The SQLDA descriptor definition                         *
*--------------------------------------------------------------*
*      VAX/3B Version                                          *
*                                                              *
* Copyright (c) 1987, 2002, Oracle Corporation.  All rights reserved.  *
***************************************************************/


/* NOTES
  **************************************************************
  ***                                                        ***
  *** This file is SOSD.  Porters must change the data types ***
  *** appropriately on their platform.  See notes/pcport.doc ***
  *** for more information.                                  ***
  ***                                                        ***
  **************************************************************
*/

/*  MODIFIED
    apopat     05/08/02  - [2362423] MVS PE to make lines shorter than 79
    apopat     07/31/99 -  [707588] TAB to blanks for OCCS
    lvbcheng   10/27/98 -  change long to int for sqlda
    lvbcheng   08/15/97 -  Move sqlda protos to sqlcpr.h
    lvbcheng   06/25/97 -  Move sqlda protos to this file
    jbasu      01/29/95 -  correct typo
    jbasu      01/27/95 -  correct comment - ub2->sb2
    jbasu      12/12/94 - Bug 217878: note this is an SOSD file
    Morse      12/01/87 - undef L and S for v6 include files
    Richey     07/13/87 - change int defs to long 
    Clare      09/13/84 - Port: Ch types to match SQLLIB structs
    Clare      10/02/86 - Add ifndef SQLDA
*/

#ifndef SQLDA_
#define SQLDA_ 1
 
#ifdef T
# undef T
#endif
#ifdef F
# undef F
#endif

#ifdef S
# undef S
#endif
#ifdef L
# undef L
#endif
 
struct SQLDA {
  /* ub4    */ int        N; /* Descriptor size in number of entries        */
  /* text** */ char     **V; /* Ptr to Arr of addresses of main variables   */
  /* ub4*   */ int       *L; /* Ptr to Arr of lengths of buffers            */
  /* sb2*   */ short     *T; /* Ptr to Arr of types of buffers              */
  /* sb2**  */ short    **I; /* Ptr to Arr of addresses of indicator vars   */
  /* sb4    */ int        F; /* Number of variables found by DESCRIBE       */
  /* text** */ char     **S; /* Ptr to Arr of variable name pointers        */
  /* ub2*   */ short     *M; /* Ptr to Arr of max lengths of var. names     */
  /* ub2*   */ short     *C; /* Ptr to Arr of current lengths of var. names */
  /* text** */ char     **X; /* Ptr to Arr of ind. var. name pointers       */
  /* ub2*   */ short     *Y; /* Ptr to Arr of max lengths of ind. var. names*/
  /* ub2*   */ short     *Z; /* Ptr to Arr of cur lengths of ind. var. names*/
  };
 
typedef struct SQLDA SQLDA;
 
#endif

/* ----------------- */
/* defines for sqlda */
/* ----------------- */

#define SQLSQLDAAlloc(arg1, arg2, arg3, arg4) sqlaldt(arg1, arg2, arg3, arg4) 

#define SQLSQLDAFree(arg1, arg2) sqlclut(arg1, arg2) 





/*----------------------------------------------------------------------------*/
/* BOOL fnOraConnect( char *szUser, char *szPasw )                            */
/*----------------------------------------------------------------------------*/
BOOL fnOraConnect( char *szUser, char *szPasw )
{

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

       char hszConnectStr[129]; /* EXEC SQL VAR hszConnectStr IS STRING(129); */ 

       char szhUser[30]; /* EXEC SQL VAR szhUser IS STRING(30); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


  Ora.Connected=FALSE;
  strcpy(hszConnectStr,szUser);
  strcat(hszConnectStr,"/");
  strcat(hszConnectStr,szPasw);

/*
  if(szPasw) {
    if(strlen(szPasw)) {
      strcat(hszConnectStr,"/");
      strcat(hszConnectStr,szPasw);
    }
  }
*/

  /* EXEC SQL CONNECT :hszConnectStr; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )10;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)hszConnectStr;
  sqlstm.sqhstl[0] = (unsigned long )129;
  sqlstm.sqhsts[0] = (         int  )129;
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
  sqlstm.sqlcmax = (unsigned int )100;
  sqlstm.sqlcmin = (unsigned int )2;
  sqlstm.sqlcincr = (unsigned int )1;
  sqlstm.sqlctimeout = (unsigned int )0;
  sqlstm.sqlcnowait = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0)
      return FALSE;
  
  Ora.Connected=TRUE;

  /* EXEC SQL SELECT USER INTO :szhUser FROM DUAL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select USER into :b0  from DUAL ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )36;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhUser;
  sqlstm.sqhstl[0] = (unsigned long )30;
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

   
  
   strcpy(szUser,szhUser); 
/*     
  if((szPasw) || (szUser)) 
    return fnOraActivaRoles(szUser);
  else
      return (TRUE); */
  
/* Solicitado el 16-07-2002 */      
  /* EXEC SQL SET ROLE ALL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "set role ALL";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )55;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    

return (TRUE);
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraDisconnect(int iOraErr)                                          */
/*----------------------------------------------------------------------------*/
BOOL fnOraDisconnect(int iOraErr)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  if(iOraErr) return fnOraRollBackRelease();
  else        return fnOraCommitRelease();
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraRollBackRelease(void)                                            */
/*----------------------------------------------------------------------------*/
BOOL fnOraRollBackRelease(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL ROLLBACK WORK RELEASE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )70;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  Ora.Connected=FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraCommitRelease(void)                                              */
/*----------------------------------------------------------------------------*/
BOOL fnOraCommitRelease(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL COMMIT WORK RELEASE; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )85;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE; 
  Ora.Connected=FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraRollBack(void)					              */
/*----------------------------------------------------------------------------*/
BOOL fnOraRollBack(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL ROLLBACK WORK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )100;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraCommit(void)                                                     */
/*----------------------------------------------------------------------------*/
BOOL fnOraCommit(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL COMMIT WORK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )115;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* char *fnOraGetErrorMsg(void)                                               */
/*----------------------------------------------------------------------------*/
char *fnOraGetErrorMsg(void)
{
  static char szMsg[BUFSIZ-1];
  size_t iMaxSize=BUFSIZ;
  size_t iOutSize;
  sqlglm(szMsg,&iMaxSize,&iOutSize);
  szMsg[iOutSize]=0;
  return szMsg;
}

/*----------------------------------------------------------------------------*/
/* char *fnOraSetSavepoint(char* szSP)                                        */
/*----------------------------------------------------------------------------*/
BOOL fnOraSetSavepoint(char* szSP)
{
  char szSentencia[BUFSIZ];
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


  sprintf(szSentencia,"SAVEPOINT %s",szSP);

  /* EXEC SQL PREPARE S FROM :szSentencia; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )130;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szSentencia;
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


  if(sqlca.sqlcode<0) return FALSE;

  /* EXEC SQL EXECUTE S; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )149;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraRestoreSP(char* szSP)                                            */
/*----------------------------------------------------------------------------*/
BOOL fnOraRestoreSP(char *szSP)
{
  char szSentencia[BUFSIZ];

  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


  sprintf(szSentencia,"ROLLBACK TO %s",szSP);

  /* EXEC SQL PREPARE S FROM :szSentencia; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )164;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szSentencia;
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


  if(sqlca.sqlcode<0) return FALSE;

  /* EXEC SQL EXECUTE S; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )183;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* Implementacion de SQL Dinamico                                            */
/*---------------------------------------------------------------------------*/

/*---------------------------------------------------------------------------*/
/* Implementacion de Metodo 1                                                */
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/* BOOL fnOraExecute(char* szStm)                                            */
/*   Dynamic SQL Method 1                                                    */
/*     The statement must not be a query                                     */
/*     The statement is parsed every time it is executed                     */ 
/*---------------------------------------------------------------------------*/
BOOL fnOraExecute(char *szStm)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL EXECUTE IMMEDIATE :szStm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )198;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szStm;
  sqlstm.sqhstl[0] = (unsigned long )0;
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


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraPrepareStm(char* szStm)                                         */
/*---------------------------------------------------------------------------*/
BOOL fnOraPrepareStm(char *szStm)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL PREPARE STM FROM :szStm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )217;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szStm;
  sqlstm.sqhstl[0] = (unsigned long )0;
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


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraDecCursorStm(void)                                              */
/*---------------------------------------------------------------------------*/
BOOL fnOraDecCursorStm(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL DECLARE STM_CURSOR CURSOR FOR STM; */ 

  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraOpenCursorStm(SQLDA *desc)                                      */
/*---------------------------------------------------------------------------*/
BOOL fnOraOpenCursorStm(SQLDA *desc)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL OPEN STM_CURSOR USING DESCRIPTOR desc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )236;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)desc;
  sqlstm.sqhstl[0] = (unsigned long )0;
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


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* int fnOraFetchDesc(SQLDA* desc)                                           */
/*---------------------------------------------------------------------------*/
int fnOraFetchDesc(SQLDA* desc)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

    
  /* EXEC SQL FETCH STM_CURSOR USING DESCRIPTOR desc; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )255;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)desc;
  sqlstm.sqhstl[0] = (unsigned long )0;
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



  if(sqlca.sqlcode == NOTFOUND) return sqlca.sqlcode;
  if(sqlca.sqlcode) return sqlca.sqlcode;

  return sqlca.sqlcode;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraCloseCursorStm(void)                                            */
/*---------------------------------------------------------------------------*/
BOOL fnOraCloseCursorStm(void)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  /* EXEC SQL CLOSE STM_CURSOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )274;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraSetBindVars(SQLDA *bind_dp)                                     */
/*---------------------------------------------------------------------------*/
BOOL fnOraSetBindVars(SQLDA *bind_dp)
{
  register int i,n;
  char bind_var[64];

  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  
  bind_dp->N=MAX_ITEMS;
 
  /* EXEC SQL DESCRIBE BIND VARIABLES FOR STM INTO bind_dp; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )289;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)bind_dp;
  sqlstm.sqhstl[0] = (unsigned long )0;
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


  if(sqlca.sqlcode<0) return FALSE;
  
  /*--------------------------------------------------------------------------*/
  /* Si F es nevativo, existen mas variable bind                              */
  /* que las encontradas en sqlald()                                          */
  /*--------------------------------------------------------------------------*/
  if(bind_dp->F < 0)  return FALSE;

  bind_dp->N = bind_dp->F;

  /*--------------------------------------------------------------------------*/
  /* Obtiene el valor de cada variable bind como cadena de caracteres         */
  /*                                                                          */
  /* C[i] contiene la longitud del nombre de la variable bind de la sentencia */
  /* S[i] contiene el nombre de la variable bind de la sentencia              */
  /* L[i] contiene la longitud del valor de dato entrado                      */
  /* V[i] contiene la direccion del valor de dato entrado                     */
  /* T[i] tipo de dato                                                        */
  /* I[i] apunta a la variable indicadora                                     */
  /*--------------------------------------------------------------------------*/
  /* Cuando Procesemos variables bind se asinan los valores actuales aqui     */

  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/* RAO20021121: se elimina esta funcion ya que presenta problemas al compilar  */
/* 				con distintas versiones de ORACLE */
/*---------------------------------------------------------------------------*/
/* BOOL fnOraDescSelect(SQLDA *select_dp)                                    */
/*---------------------------------------------------------------------------*/
/* BOOL fnOraDescSelect(SQLDA *select_dp) */
/* { */
/*   register int i=0; */
/*   int null_ok,precision,scale; */
/*  */
/*   EXEC SQL WHENEVER SQLERROR      CONTINUE; */
/*   EXEC SQL WHENEVER SQLWARNING    CONTINUE; */
/*   EXEC SQL WHENEVER NOT FOUND     CONTINUE; */
/*  */
/*   select_dp->N = MAX_ITEMS; */
/*  */
/*   EXEC SQL DESCRIBE SELECT LIST FOR STM INTO select_dp; */
/*   if(sqlca.sqlcode<0) return FALSE; */
/*  */
/*   *//*--------------------------------------------------------------------------*/
/*   *//* Si F es nevativo, existen mas variable bind                              */
/*   *//* que las encontradas en sqlald()                                          */
/*   *//*--------------------------------------------------------------------------*/
/*   if(select_dp->F < 0)  return FALSE; */
/*    */
/*   select_dp->N = select_dp->F; */
/*  */
/*   for(i=0;i<select_dp->F;i++) { */
/*  */
/*     unsigned short us1, us2; */
/*     us1 = select_dp->T[i]; */
/*     us2 = select_dp->T[i]; */
/*     sqlnul(&us1, &us2, &null_ok); */
/*     select_dp->T[i] = us1; */
/*     select_dp->T[i] = us2; */
/*     *//* sqlnul(&(select_dp->T[i]),&(select_dp->T[i]),&null_ok); */ 
/*  */
/*     switch(select_dp->T[i]) { */
/*       case 1: */ /* CHAR */
/*         break; */
/*       case 2: */  /* NUMBER */
/*         { */
/*  */
/* #if defined(VERSION) && VERSION==8 */
/*         unsigned int  ui1 = select_dp->L[i]; */   /* Solucion Para Oracle 8.x */
/* #elif defined(VERSION_7) */
/*         unsigned long ui1 = select_dp->L[i];  */  /* Solucion Para Oracle 7.x */ 
/* #else */
/*         unsigned long ui1 = select_dp->L[i];*/	/* version desconocida por ahora */
/* #endif */
/*         sqlprc(&ui1,&precision,&scale); */
/*         select_dp->L[i] = ui1; */
/*         *//* sqlprc(&(select_dp->L[i]),&precision,&scale); */ 
/*         } */
/*         if(precision==0) precision=40; */
/*         if(scale>0) select_dp->L[i] = sizeof(float); */
/*         else        select_dp->L[i] = sizeof(int); */
/*         break; */
/*       case 8: */ /* LONG */
/*         select_dp->L[i] = 240; */
/*         break; */
/*       case 11: */ /* ROWID */ 
/*         select_dp->L[i] = 18; */
/*         break; */
/*       case 12: */ /* DATE */ 
/*         select_dp->L[i] = 9; */
/*         break; */
/*       case 23: *//* RAW */ 
/*         break; */
/*       case 24: *//* LONG RAW */ 
/*         select_dp->L[i] = 240; */
/*         break; */
/*     } */
/*     if(select_dp->T[i] != 2) */
/*       select_dp->V[i] = (char*) realloc(select_dp->V[i],select_dp->L[i]+1); */
/*     else  */
/*       select_dp->V[i] = (char*) realloc(select_dp->V[i],select_dp->L[i]); */
/*     if(select_dp->T[i] != 24 && select_dp->T[i] !=2 ) select_dp->T[i] = 1; */
/*     if(select_dp->T[i] == 2 ) { */
/*       if(scale > 0) select_dp->T[i] = 4;*/ /* FLOAT */ 
/*       else          select_dp->T[i] = 3;*/ /* INT   */
/*     } */
/*   } */
/*    */
/*   if(sqlca.sqlcode<0) return FALSE; */
/*   return TRUE; */
/* } */

/*---------------------------------------------------------------------------*/
/* BOOL fnOraIniDescs(SQLDA* select_dp,SQLDA* bind_dp)                       */
/*---------------------------------------------------------------------------*/
BOOL fnOraIniDescs(SQLDA** select_dp,SQLDA** bind_dp)
{
  if(!fnOraAllocDesc(select_dp,
		     MAX_ITEMS,MAX_VNAME_LEN,MAX_INAME_LEN)) return FALSE;
  if(!fnOraAllocDesc(bind_dp,
		     MAX_ITEMS,MAX_VNAME_LEN,MAX_INAME_LEN)) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraAllocDesc(int size,int max_vname_len,int max_iname_len)         */
/*---------------------------------------------------------------------------*/
BOOL fnOraAllocDesc(SQLDA** desc,int size,int max_vname_len,int max_iname_len)
{
   register int i=0;
   SQLDA* pDesc=(SQLDA*)NULL;
   if((SQLDA*)NULL==(pDesc=(SQLDA*)sqlald(size,max_vname_len,max_iname_len))) {
     fprintf(stderr,"No puede atrapar memoria para el descriptor pDesc\n");
     return FALSE;
   } 
   pDesc->N=MAX_ITEMS;
   for(i=0;i<MAX_ITEMS;i++) {
     pDesc->I[i] = (short*) malloc(sizeof(short));
     pDesc->V[i] = (char*)  malloc(sizeof(char));
   } 
   *desc=pDesc;
   return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraEndDescs(SQLDA* select_dp,SQLDA* bind_dp)                       */
/*---------------------------------------------------------------------------*/
BOOL fnOraEndDescs(SQLDA* select_dp,SQLDA* bind_dp)
{
  if(!fnOraDeAllocDesc(select_dp)) return FALSE;
  if(!fnOraDeAllocDesc(bind_dp)) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraDeAllocDesc(SQLDA* desc)                                        */
/*---------------------------------------------------------------------------*/
BOOL fnOraDeAllocDesc(SQLDA* desc)
{
   register int i=0;
   for(i=0;i<MAX_ITEMS;i++) {
     if((char*)NULL!=desc->V[i]) free (desc->V[i]);
     free(desc->I[i]);
   }
   sqlclu(desc);
   return TRUE;
}

/*---------------------------------------------------------------------------*/
/* static char* strtoupper(char* szChain)                                    */
/*---------------------------------------------------------------------------*/
static char *strtoupper(char *szChain)
{
   int iCont=0;
   int c;

   for(iCont=0;iCont<strlen(szChain);iCont++) {
      c = (int) szChain[iCont];
      c = toupper(c);
      szChain[iCont] = (char) c;
   }

   return ((char *)szChain);
}

/*----------------------------------------------------------------------------*/
/* static int decode(FILE*,FILE*)                                             */
/*----------------------------------------------------------------------------*/
static int decode(char* pfin,char* pfout)
{
  extern int errno;
  register int n;
  register char ch, *p;
  int mode, n1;
  char buf[1024];
  char pfTemp[BUFSIZ]="";
  memset(pfout,0,BUFSIZ);

  strcpy(buf,pfin);
  p=buf;
  /* for each input line */
  for(;;) {
    if((n=DEC(*p))<=0) break;
    for(++p;n>0;p+=4,n-=3)
    if(n>=3){
      ch=DEC(p[0])<<2|DEC(p[1])>>4;
      strcpy(pfTemp,pfout);
      sprintf(pfout,"%s%c",pfTemp,ch);
      ch=DEC(p[1])<<4|DEC(p[2])>>2;
      strcpy(pfTemp,pfout);
      sprintf(pfout,"%s%c",pfTemp,ch);
      ch=DEC(p[2])<<6|DEC(p[3]);
      strcpy(pfTemp,pfout);
      sprintf(pfout,"%s%c",pfTemp,ch);
    } else {
      if(n>=1) {
        ch=DEC(p[0])<<2|DEC(p[1])>>4;
        strcpy(pfTemp,pfout);
        sprintf(pfout,"%s%c",pfTemp,ch);
      }
      if(n>=2) {
        ch=DEC(p[1])<<4|DEC(p[2])>>2;
        strcpy(pfTemp,pfout);
        sprintf(pfout,"%s%c",pfTemp,ch);
      }
      if(n>=3) {
        ch=DEC(p[2])<<6|DEC(p[3]);
        strcpy(pfTemp,pfout);
        sprintf(pfout,"%s%c",pfTemp,ch);
      }
    }
  }
  return(0);
}

/*----------------------------------------------------------------------------*/
/* char* fnOraGetFld(SQLDA* desc,int i)                                       */
/*----------------------------------------------------------------------------*/
char* fnOraGetFld(SQLDA* desc,int i)
{
  static char szBuffer[BUFSIZ];
  if(*desc->I[i]>=0) {
    switch(desc->T[i]) {
      case 3:
       sprintf(szBuffer,"%*d",(int)desc->L[i],*(int*)desc->V[i]);
       break;
      case 4:
       sprintf(szBuffer,"%*.2f",(int)desc->L[i],*(float*)desc->V[i]);
       break;
      default:
       sprintf(szBuffer,"%-*s",(int)desc->L[i],desc->V[i]);
       break;
    }
  } else sprintf(szBuffer,"NULL");
  while(szBuffer[strlen(szBuffer)-1]==' ') szBuffer[strlen(szBuffer)-1]='\0';
  return szBuffer;
}

/*----------------------------------------------------------------------------*/
/* int fnOraGetNFlds(SQLDA* desc)                                             */
/*----------------------------------------------------------------------------*/
int fnOraGetNFlds(SQLDA* desc)
{
  return desc->F;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraActivaRoles (void)                                              */
/*---------------------------------------------------------------------------*/
static BOOL fnOraActivaRoles (char *szUser)
{
  BOOL iAdmin = FALSE;
  char szUsr[62] = "";
  char szCad[BUFSIZ] = "";
  char szPassDec[BUFSIZ] = "";
  char szTmp[BUFSIZ] = "";

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szRole[31]       ; /* EXEC SQL VAR szRole IS STRING(31); */ 

    char szPasswd[1024]   ; /* EXEC SQL VAR szPasswd IS STRING(1024); */ 

    char szhStm[1024]     ; /* EXEC SQL VAR szhStm IS STRING(1024); */ 

  /* EXEC SQL END DECLARE SECTION; */ 


  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


  /* return TRUE; */

  strcpy(szUsr,szUser);
  if(strstr(szUsr,"/")) strcpy(szUsr,strtok(szUsr,"/"));
  else strcpy(szUsr,szUser);

  strtoupper(szUsr);
 
  /* Probamos el ROLE SISCEL_ADMIN (Puede hacer todo) */
  strcpy(szhStm,"SET ROLE SISCEL_ADMIN");
  /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )308;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
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


  if(sqlca.sqlcode) iAdmin = FALSE;
  else iAdmin = TRUE;

  /* Activamos el ROLE SISCEL_SEGUR (Para ver las tablas de Seguridad) */
  strcpy(szhStm,"SET ROLE SISCEL_SEGUR");
  /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )327;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
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


  if(sqlca.sqlcode) return(FALSE);

  /* Roles de Usuario */
  /* EXEC SQL DECLARE UROLES_CURSOR CURSOR FOR
             SELECT A.ROLE, NVL(B.PASSWORD,CHR(0)) 
             FROM GE_SEG_USUROLES A,GE_SEG_ROLE B,GE_SEG_USUARIO C
            WHERE A.ROLE = B.ROLE
              AND A.NOM_USUARIO = C.NOM_USUARIO
              AND A.NOM_USUARIO = :szUsr; */ 

  /* EXEC SQL OPEN UROLES_CURSOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0013;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )346;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szUsr;
  sqlstm.sqhstl[0] = (unsigned long )62;
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

 
/*
  fprintf(stdout, "\nSQLCODE1: %d\n", sqlca.sqlcode);
*/
  if(sqlca.sqlcode) return FALSE;

  for(;;) {
     /* EXEC SQL FETCH UROLES_CURSOR INTO :szRole,:szPasswd; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )365;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szRole;
     sqlstm.sqhstl[0] = (unsigned long )31;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szPasswd;
     sqlstm.sqhstl[1] = (unsigned long )1024;
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


	 /* fprintf(stdout, "\nSQLCODE1: %d\n", sqlca.sqlcode); */
     if(sqlca.sqlcode == NOTFOUND) break;
     if(sqlca.sqlcode) return FALSE;
     /* Compone cadena de roles */
     if(strlen(szPasswd)) {
        decode(szPasswd,szPassDec);
        sprintf(szCad,"%s%s IDENTIFIED BY %s,",szTmp,szRole,szPassDec);
     } else sprintf(szCad,"%s%s,",szTmp,szRole);
     strcpy(szTmp,szCad);
  }

  /* EXEC SQL CLOSE UROLES_CURSOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )388;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
  if(sqlca.sqlcode) return FALSE;
  
  /* Roles de Grupo */
  /* EXEC SQL DECLARE GROLES_CURSOR CURSOR FOR
             SELECT A.ROLE, NVL(B.PASSWORD,CHR(0)) 
             FROM GE_SEG_GRPROLES A,GE_SEG_ROLE B,GE_SEG_GRPUSUARIO C
            WHERE A.ROLE = B.ROLE
              AND A.COD_GRUPO   = C.COD_GRUPO
              AND C.NOM_USUARIO = :szUsr; */ 

  /* EXEC SQL OPEN GROLES_CURSOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0014;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )403;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szUsr;
  sqlstm.sqhstl[0] = (unsigned long )62;
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

 
/*
  fprintf(stdout, "\nSQLCODE2: %d\n", sqlca.sqlcode);
*/
  if(sqlca.sqlcode) return FALSE;

  for(;;) {
     /* EXEC SQL FETCH GROLES_CURSOR INTO :szRole,:szPasswd; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )422;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szRole;
     sqlstm.sqhstl[0] = (unsigned long )31;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szPasswd;
     sqlstm.sqhstl[1] = (unsigned long )1024;
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


     if(sqlca.sqlcode == NOTFOUND) break;
     if(sqlca.sqlcode) return FALSE;
     /* Compone cadena de roles */
     if(strlen(szPasswd)) {
        decode(szPasswd,szPassDec);
        sprintf(szCad,"%s%s IDENTIFIED BY %s,",szTmp,szRole,szPassDec);
     } else sprintf(szCad,"%s%s,",szTmp,szRole);
     strcpy(szTmp,szCad);
  }

  /* EXEC SQL CLOSE GROLES_CURSOR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )445;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
  if(sqlca.sqlcode) return FALSE;
  
  if (strlen(szCad)) szCad[strlen(szCad)-1]='\0';
  else {
     strcpy(szCad,"SISCEL_SEGUR");
  }

  sprintf(szhStm,"SET ROLE %s", szCad);

  /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )460;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
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


  if(sqlca.sqlcode) return FALSE;

  return TRUE;
}

/* -------------------------------------------------------------------------- */
/*   bGetParamGenerales (DATOSGENER*)                                             */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
int bGetParamDecimales ( void )
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    	static char  szhNomParametro[21]; /* EXEC SQL VAR szhNomParametro  IS STRING(21); */ 

    	static char  szhModuloSiscel[3] ; /* EXEC SQL VAR szhModuloSiscel  IS STRING(3); */ 

    	static int   ihCodProducto      ;
    	static char  szhValParametro[7] ; /* EXEC SQL VAR szhValParametro  IS STRING(7); */ 

    	static char  szhNomParametro1[21]; /* EXEC SQL VAR szhNomParametro1 IS STRING(21); */ 

    	static char  szhNomParametro2[21]; /* EXEC SQL VAR szhNomParametro2 IS STRING(21); */ 

    	static char  szhNomParametro3[21]; /* EXEC SQL VAR szhNomParametro3 IS STRING(21); */ 

    	static char  szhNomParametro4[21]; /* EXEC SQL VAR szhNomParametro4 IS STRING(21); */ 

    	static char  szhNomParametro5[21]; /* EXEC SQL VAR szhNomParametro5 IS STRING(21); */ 

    	static char  szhNomParametro6[21]; /* EXEC SQL VAR szhNomParametro6 IS STRING(21); */ 

    	static char  szhNomParametro7[21]; /* EXEC SQL VAR szhNomParametro7 IS STRING(21); */ 

    	static char  szhNomParametro8[21]; /* EXEC SQL VAR szhNomParametro8 IS STRING(21); */ 

    	static char  szhNomParametro9[21]; /* EXEC SQL VAR szhNomParametro9 IS STRING(21); */ 

    	static char  szhNomParametro10[21]; /* EXEC SQL VAR szhNomParametro10 IS STRING(21); */ 

 /* 2005/04/25 Indra
	Modificacion proyecto P-COL-05001-SCL (Colombia) para documentos en 0 (cero):
	Se agrega szhNomParametro11 para guardar valor del campo Val_Documento de la tabla
	GED_PARAMETROS; este valor se carga en la estructura pstParamGener y dejarlo en memoria */
	static char  szhNomParametro11[21]; /* EXEC SQL VAR szhNomParametro11 IS STRING(21); */ 

    	
    /* EXEC SQL END   DECLARE SECTION  ; */ 
 

    sprintf(szhModuloSiscel,"GE\0");
    ihCodProducto = 1;
    pstParamGener.iTipoFoliacion = -1;
    
    strcpy (szhNomParametro1, szNUM_DECIMAL);
    strcpy (szhNomParametro2, szSEP_MILES_MONTOS);
    strcpy (szhNomParametro3, szSEP_DECIMALES_MONTOS);
    strcpy (szhNomParametro4, szSEP_DECIMALES_ORACLE);
    strcpy (szhNomParametro5, szNUM_DECIMAL_FACT);
    strcpy (szhNomParametro6, szCOD_TIP_FOLIACION);
    strcpy (szhNomParametro7, szCOD_PAR_TRAFICO_0);
    strcpy (szhNomParametro8, szIND_ZOMAIMPOCIC);
    strcpy (szhNomParametro9, szMTO_MIN_AJUSTE);
    strcpy (szhNomParametro10, szZONA_IMPO_DEFECTO);
    strcpy (szhNomParametro11, szDOCUMENTO_CERO);
    
    /* EXEC SQL DECLARE Cur_Ged_Parametros CURSOR FOR
        SELECT  NOM_PARAMETRO   ,
                VAL_PARAMETRO   
        FROM   GED_PARAMETROS   
        WHERE  NOM_PARAMETRO in (:szhNomParametro1,
				:szhNomParametro2,
				:szhNomParametro3,
				:szhNomParametro4,
       				:szhNomParametro5,
       				:szhNomParametro6,
       				:szhNomParametro7,
       				:szhNomParametro8,
       				:szhNomParametro9,
       				:szhNomParametro10,
       				:szhNomParametro11); */ 
 /*2005/04/25 Indra: se agrega este parametro para documentos en cero*/

	/* EXEC SQL OPEN Cur_Ged_Parametros; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0016;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )479;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNomParametro1;
 sqlstm.sqhstl[0] = (unsigned long )21;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNomParametro2;
 sqlstm.sqhstl[1] = (unsigned long )21;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhNomParametro3;
 sqlstm.sqhstl[2] = (unsigned long )21;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhNomParametro4;
 sqlstm.sqhstl[3] = (unsigned long )21;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhNomParametro5;
 sqlstm.sqhstl[4] = (unsigned long )21;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhNomParametro6;
 sqlstm.sqhstl[5] = (unsigned long )21;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhNomParametro7;
 sqlstm.sqhstl[6] = (unsigned long )21;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhNomParametro8;
 sqlstm.sqhstl[7] = (unsigned long )21;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNomParametro9;
 sqlstm.sqhstl[8] = (unsigned long )21;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szhNomParametro10;
 sqlstm.sqhstl[9] = (unsigned long )21;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szhNomParametro11;
 sqlstm.sqhstl[10] = (unsigned long )21;
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


   	if (sqlca.sqlcode)
   	{
   			return  FALSE; 
   	}
   	while (sqlca.sqlcode == 0)
   	{
	  	/* EXEC SQL 
	            FETCH Cur_Ged_Parametros 
	            INTO    :szhNomParametro    ,
	                    :szhValParametro    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )538;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomParametro;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhValParametro;
    sqlstm.sqhstl[1] = (unsigned long )7;
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


		
	     	if (sqlca.sqlcode == NOTFOUND)
	    	{
	    		/* EXEC SQL CLOSE Cur_Ged_Parametros; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 11;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )561;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	    		return TRUE;
	        }
	        if(sqlca.sqlcode<0)
	        {
	      		return FALSE;
	      	}	
	    	else	
	      	{
				if (!strcmp(szhNomParametro, szNUM_DECIMAL))
						pstParamGener.iNumDecimal = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szSEP_MILES_MONTOS))
						strcpy (pstParamGener.szSepMilesMonto, szhValParametro);
				else if (!strcmp(szhNomParametro, szSEP_DECIMALES_MONTOS))
						strcpy (pstParamGener.szSepDecMontos, szhValParametro);
				else if (!strcmp(szhNomParametro, szSEP_DECIMALES_ORACLE))
						strcpy (pstParamGener.szSepDecOracle, szhValParametro);
				else if (!strcmp(szhNomParametro, szNUM_DECIMAL_FACT))
						pstParamGener.iNumDecimalFact= atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szCOD_TIP_FOLIACION))
						pstParamGener.iTipoFoliacion = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szCOD_PAR_TRAFICO_0))
						pstParamGener.iConsConcTrafico = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szIND_ZOMAIMPOCIC))
						pstParamGener.iIndZonaImpCic = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szMTO_MIN_AJUSTE))
						pstParamGener.iMtoMinAjuste = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szZONA_IMPO_DEFECTO))
						pstParamGener.iZonaImpoDefec = atoi(szhValParametro);
				else if (!strcmp(szhNomParametro, szDOCUMENTO_CERO))   /*2005/04/25 Indra: se agrega este elseif para documentos en cero*/
						 /*strcpy (pstParamGener.sDocumentoCero,szhValParametro);*/
						 pstParamGener.sDocumentoCero = szhValParametro[0]; /* 20050510 */
	    	}   
	}
	
	strcpy(pstParamGener.szCodIdioma,"1"); /* Idioma Operadora */
	
	if (pstParamGener.iTipoFoliacion == -1)
    {
    	return FALSE;
	}

  	return (1);
}/************************** bGetParamDecimales ******************************/


/* -------------------------------------------------------------------------- */
/*   fnCnvDouble(void)                                                            */
/* -------------------------------------------------------------------------- */
double fnCnvDouble(double d,int uso)
{
  char szTemp[30];
  double dvalor=0.0;
  double dRedondeo=0.0000001;  
  
  if(d < 0 )
 {
	dRedondeo*=-1;
 }

  memset(szTemp,0,sizeof(szTemp));
/*   sprintf(szTemp,"%.*f",pstParamGener.iNumDecimal, d );  */

  if (uso == USOFACT)                                                          
  {                                                                    
/*        sprintf(szTemp,"%.*f",pstParamGener.iNumDecimalFact, d + 0.0000001); */
        sprintf(szTemp,"%.*f",pstParamGener.iNumDecimalFact, d + dRedondeo); 
  }                                                                    
  else                                                                 
  {                                                                    
/*	sprintf(szTemp,"%.*f",pstParamGener.iNumDecimal, d + 0.0000001);     */
	sprintf(szTemp,"%.*f",pstParamGener.iNumDecimal, d + dRedondeo);     
  };                                                                   
  dvalor=(double)atof(szTemp);
                          
  if (dvalor > -0.000001 && dvalor < 0.000001)    /* PR-200402160376: Aca se controlará el problema de redondeo.   */
      dvalor=(double)0.0;                         /* PR-200402160376: Si el resultado es cerca de 0, retornamos 0. */
  return(dvalor);                                 /* PR-200402160376: Si no, retornamos el valor normal.           */
}

/* -------------------------------------------------------------------------- */
/*   fnCnvFloat(void)                                                         */
/* -------------------------------------------------------------------------- */
float fnCnvFloat(float d,int uso)
{
  char szTemp[30];
  float fvalor=0.0;
  
  memset(szTemp,0,sizeof(szTemp));
/*  sprintf(szTemp,"%.*f",pstParamGener.iNumDecimal,d);*/
  if (uso == USOFACT)                                                                 
  {                                                                             
  	sprintf(szTemp,"%.*f",pstParamGener.iNumDecimalFact, d + 0.0000001);  
  }                                                                             
  else                                                                          
  {                                                                             
  	sprintf(szTemp,"%.*f",pstParamGener.iNumDecimal, d + 0.0000001);      
  }                                                                             

  
  fvalor=(float)atof(szTemp);

  if (fvalor > -0.000001 && fvalor < 0.000001)    /* PR-200402160376: Aca se controlará el problema de redondeo.   */
	  fvalor=(float)0.0;                          /* PR-200402160376: Si el resultado es cerca de 0, retornamos 0. */
  return(fvalor);                                 /* PR-200402160376: Si no, retornamos el valor normal.           */
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

