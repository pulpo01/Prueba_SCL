
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
    "./pc/CO_oracle.pc"
};


static unsigned int sqlctx = 6912803;


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
   unsigned char  *sqhstv[4];
   unsigned long  sqhstl[4];
            int   sqhsts[4];
            short *sqindv[4];
            int   sqinds[4];
   unsigned long  sqharm[4];
   unsigned long  *sqharc[4];
   unsigned short  sqadto[4];
   unsigned short  sqtdso[4];
} sqlstm = {12,4};

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

 static const char *sq0012 = 
"select A.ROLE ,NVL(B.PASSWORD,CHR(0))  from GE_SEG_USUROLES A ,GE_SEG_ROLE B\
 ,GE_SEG_USUARIO C where ((A.ROLE=B.ROLE and A.NOM_USUARIO=C.NOM_USUARIO) and \
A.NOM_USUARIO=:b0)           ";

 static const char *sq0013 = 
"select A.ROLE ,NVL(B.PASSWORD,CHR(0))  from GE_SEG_GRPROLES A ,GE_SEG_ROLE B\
 ,GE_SEG_GRPUSUARIO C where ((A.ROLE=B.ROLE and A.COD_GRUPO=C.COD_GRUPO) and C\
.NOM_USUARIO=:b0)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,0,0,27,46,0,0,4,4,0,1,0,1,5,0,0,1,10,0,0,1,10,0,0,1,10,0,0,
36,0,0,2,32,0,4,52,0,0,1,0,0,1,0,2,5,0,0,
55,0,0,3,0,0,32,82,0,0,0,0,0,1,0,
70,0,0,4,0,0,30,96,0,0,0,0,0,1,0,
85,0,0,5,0,0,31,110,0,0,0,0,0,1,0,
100,0,0,6,0,0,29,123,0,0,0,0,0,1,0,
115,0,0,7,0,0,17,156,0,0,1,1,0,1,0,1,97,0,0,
134,0,0,7,0,0,21,159,0,0,0,0,0,1,0,
149,0,0,7,0,0,17,180,0,0,1,1,0,1,0,1,97,0,0,
168,0,0,7,0,0,21,183,0,0,0,0,0,1,0,
183,0,0,8,0,0,24,213,0,0,1,1,0,1,0,1,97,0,0,
202,0,0,9,0,0,17,233,0,0,1,1,0,1,0,1,97,0,0,
221,0,0,9,0,0,11,260,0,0,1,1,0,1,0,1,32,0,0,
240,0,0,9,0,0,14,274,0,0,1,0,0,1,0,2,32,0,0,
259,0,0,9,0,0,15,290,0,0,0,0,0,1,0,
274,0,0,9,0,0,19,309,0,0,1,1,0,1,0,3,32,0,0,
293,0,0,9,0,0,20,350,0,0,1,1,0,1,0,3,32,0,0,
312,0,0,10,0,0,24,597,0,0,1,1,0,1,0,1,5,0,0,
331,0,0,11,0,0,24,606,0,0,1,1,0,1,0,1,5,0,0,
350,0,0,12,183,0,9,617,0,0,1,1,0,1,0,1,5,0,0,
369,0,0,12,0,0,13,623,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
392,0,0,12,0,0,15,641,0,0,0,0,0,1,0,
407,0,0,13,182,0,9,653,0,0,1,1,0,1,0,1,5,0,0,
426,0,0,13,0,0,13,659,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
449,0,0,13,0,0,15,678,0,0,0,0,0,1,0,
464,0,0,14,0,0,24,690,0,0,1,1,0,1,0,1,5,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  FUNCIONES ORACLE

    Nombre      :  CO_oracle.pc

    Descripcion :  Rutinas Generales a todos los modulos de newcobros.
                   Incluyen funciones de conexion y desconexion a Oracle,etc

    Autor       :  Roy Barrera Richards                 
    Fecha       :  09 - Agosto - 2000 

*/ 
/* ============================================================================= */

#define _COORACLE_PC_

#include <stdio.h>
#include <ctype.h>
#include "CO_oracle.h"

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
BOOL bfnOraConnect( char *szUser, char *szPasw )
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char hszConnectStr[129]; /* EXEC SQL VAR hszConnectStr IS STRING(129); */ 

		char szhUser[30]; /* EXEC SQL VAR szhUser IS STRING(30); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

	/* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

	/* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

	
	OraDb.Connected=FALSE;
	strcpy( hszConnectStr, szUser );
	strcat( hszConnectStr, "/" );
	strcat( hszConnectStr, szPasw );
	
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


	if( sqlca.sqlcode < 0 )
		return FALSE;
	
	OraDb.Connected=TRUE;
	
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


	
	strcpy( szUser, szhUser );
	
	if( ( szPasw ) || ( szUser ) )
		return bfnOraActivaRoles( szUser );
	else
		return (TRUE);
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraDisconnect(int iOraErr)                                          */
/*----------------------------------------------------------------------------*/
BOOL bfnOraDisconnect(int iOraErr)
{
  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

  if(iOraErr) return bfnOraRollBackRelease();
  else        return bfnOraCommitRelease();
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraRollBackRelease(void)                                            */
/*----------------------------------------------------------------------------*/
BOOL bfnOraRollBackRelease(void)
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
  sqlstm.offset = (unsigned int  )55;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE;
  OraDb.Connected=FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraCommitRelease(void)                                              */
/*----------------------------------------------------------------------------*/
BOOL bfnOraCommitRelease(void)
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
  sqlstm.offset = (unsigned int  )70;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if(sqlca.sqlcode<0) return FALSE; 
  OraDb.Connected=FALSE;
  return TRUE;
}

/*----------------------------------------------------------------------------*/
/* BOOL fnOraRollBack(void)													  */
/*----------------------------------------------------------------------------*/
BOOL bfnOraRollBack(void)
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
  sqlstm.offset = (unsigned int  )85;
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
BOOL bfnOraCommit(void)
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
/* char *fnOraGetErrorMsg(void)                                               */
/*----------------------------------------------------------------------------*/
char *szfnOraGetErrorMsg(void)
{
  static char szMsg[BUFSIZ-1];
  int iMaxSize = BUFSIZ;
  int iOutSize = 0;
  /*sqlglm( szMsg, &iMaxSize, &iOutSize );  MGG */
  szMsg [iOutSize] = 0;
  return szMsg;
}

/*----------------------------------------------------------------------------*/
/* char *fnOraSetSavepoint(char* szSP)                                        */
/*----------------------------------------------------------------------------*/
BOOL bfnOraSetSavepoint(char* szSP)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhSentencia[BUFSIZ];
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

    /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

    /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

    
    sprintf(szhSentencia,"SAVEPOINT %s",szSP);
    
    /* EXEC SQL PREPARE S FROM :szhSentencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )115;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhSentencia;
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
    sqlstm.offset = (unsigned int  )134;
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
BOOL bfnOraRestoreSP(char *szSP)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhSentencia[BUFSIZ];  
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

    /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

    /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

    
    sprintf(szhSentencia,"ROLLBACK TO %s",szSP);
    
    /* EXEC SQL PREPARE S FROM :szhSentencia; */ 

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
    sqlstm.sqhstv[0] = (unsigned char  *)szhSentencia;
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
    sqlstm.offset = (unsigned int  )168;
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
BOOL bfnOraExecute(char *szStm)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhStm[BUFSIZ];  
    /* EXEC SQL END DECLARE SECTION; */ 

 
    /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

    /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

    /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

    
    sprintf(szhStm,"%s",szStm);
    /* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

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


    if(sqlca.sqlcode<0) return FALSE;

    return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraPrepareStm(char* szStm)                                         */
/*---------------------------------------------------------------------------*/
BOOL bfnOraPrepareStm(char *szStm)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhStm[BUFSIZ];  
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

    /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

    /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


    sprintf(szhStm,"%s",szStm);
    /* EXEC SQL PREPARE STM FROM :szhStm; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )202;
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


    if(sqlca.sqlcode<0) return FALSE;
    
    return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraDecCursorStm(void)                                              */
/*---------------------------------------------------------------------------*/
BOOL bfnOraDecCursorStm(void)
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
BOOL bfnOraOpenCursorStm(SQLDA *desc)
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
  sqlstm.offset = (unsigned int  )221;
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
int ifnOraFetchDesc(SQLDA* desc)
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
  sqlstm.offset = (unsigned int  )240;
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



  if(sqlca.sqlcode == SQLNOTFOUND) return sqlca.sqlcode;
  if(sqlca.sqlcode) return sqlca.sqlcode;

  return sqlca.sqlcode;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraCloseCursorStm(void)                                            */
/*---------------------------------------------------------------------------*/
BOOL bfnOraCloseCursorStm(void)
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
  sqlstm.offset = (unsigned int  )259;
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
BOOL bfnOraSetBindVars(SQLDA *bind_dp)
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
  sqlstm.offset = (unsigned int  )274;
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

/*---------------------------------------------------------------------------*/
/* BOOL fnOraDescSelect(SQLDA *select_dp)                                    */
/*---------------------------------------------------------------------------*/
BOOL bfnOraDescSelect(SQLDA *select_dp)
{
  register int i=0;
  int null_ok,precision,scale = 0;

  /* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

  /* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

  /* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 


  select_dp->N = MAX_ITEMS;

  /* EXEC SQL DESCRIBE SELECT LIST FOR STM INTO select_dp; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )293;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)select_dp;
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
  if(select_dp->F < 0)  return FALSE;
  
  select_dp->N = select_dp->F;

  for(i=0;i<select_dp->F;i++) {

    /* sqlnul(&(select_dp->T[i]),&(select_dp->T[i]),&null_ok); MGG */

    switch(select_dp->T[i]) {
      case 1:  /* CHAR */
        break;
      case 2:  /* NUMBER */
        /* sqlprc(&(select_dp->L[i]),&precision,&scale); MGG */
        if(precision==0) precision=40;
        if(scale>0) select_dp->L[i] = sizeof(float);
        else        select_dp->L[i] = sizeof(int);
        break;
      case 8:  /* LONG */
        select_dp->L[i] = 240;
        break;
      case 11: /* ROWID */ 
        select_dp->L[i] = 18;
        break;
      case 12: /* DATE */ 
        select_dp->L[i] = 9;
        break;
      case 23: /* RAW */ 
        break;
      case 24: /* LONG RAW */ 
        select_dp->L[i] = 240;
        break;
    }
    if(select_dp->T[i] != 2)
      select_dp->V[i] = (char*) realloc(select_dp->V[i],select_dp->L[i]+1);
    else 
      select_dp->V[i] = (char*) realloc(select_dp->V[i],select_dp->L[i]);
    if(select_dp->T[i] != 24 && select_dp->T[i] !=2 ) select_dp->T[i] = 1;
    if(select_dp->T[i] == 2 ) {
      if(scale > 0) select_dp->T[i] = 4; /* FLOAT */
      else          select_dp->T[i] = 3; /* INT   */
    }
  }
  
  if(sqlca.sqlcode<0) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraIniDescs(SQLDA* select_dp,SQLDA* bind_dp)                       */
/*---------------------------------------------------------------------------*/
BOOL bfnOraIniDescs(SQLDA** select_dp,SQLDA** bind_dp)
{
  if(!bfnOraAllocDesc(select_dp,
		     MAX_ITEMS,MAX_VNAME_LEN,MAX_INAME_LEN)) return FALSE;
  if(!bfnOraAllocDesc(bind_dp,
		     MAX_ITEMS,MAX_VNAME_LEN,MAX_INAME_LEN)) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraAllocDesc(int size,int max_vname_len,int max_iname_len)         */
/*---------------------------------------------------------------------------*/
BOOL bfnOraAllocDesc(SQLDA** desc,int size,int max_vname_len,int max_iname_len)
{
   register int i=0;
   SQLDA* pDesc=(SQLDA*)NULL;
   /*if((SQLDA*)NULL==(pDesc=(SQLDA*)sqlald(size,max_vname_len,max_iname_len))) {
     fprintf(stderr,"No puede atrapar memoria para el descriptor pDesc\n");
     return FALSE;
   } */
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
BOOL bfnOraEndDescs(SQLDA* select_dp,SQLDA* bind_dp)
{
  if(!bfnOraDeAllocDesc(select_dp)) return FALSE;
  if(!bfnOraDeAllocDesc(bind_dp)) return FALSE;
  return TRUE;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraDeAllocDesc(SQLDA* desc)                                        */
/*---------------------------------------------------------------------------*/
BOOL bfnOraDeAllocDesc(SQLDA* desc)
{
   register int i=0;
   for(i=0;i<MAX_ITEMS;i++) {
     if((char*)NULL!=desc->V[i]) free (desc->V[i]);
     free(desc->I[i]);
   }
   /* sqlclu(desc); MGG */
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
char* szfnOraGetFld(SQLDA* desc,int i)
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
int ifnOraGetNFlds(SQLDA* desc)
{
  return desc->F;
}

/*---------------------------------------------------------------------------*/
/* BOOL fnOraActivaRoles (void)                                              */
/*---------------------------------------------------------------------------*/
static BOOL bfnOraActivaRoles (char *szUser)
{
	BOOL iAdmin = FALSE;
	char szCad[MAX_BUFSIZE] = "";
	char szPassDec[MAX_BUFSIZE] = "";
	char szTmp[MAX_BUFSIZE] = "";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szRole[31];			/* EXEC SQL VAR szRole IS STRING(31); */ 

		char szPasswd[MAX_BUFSIZE];	/* EXEC SQL VAR szPasswd IS STRING(MAX_BUFSIZE); */ 

		char szhStm[MAX_BUFSIZE];	/* EXEC SQL VAR szhStm IS STRING(MAX_BUFSIZE); */ 

		char szUsr[62];				/* EXEC SQL VAR szUsr IS STRING(62); */ 

	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL WHENEVER SQLERROR      CONTINUE; */ 

	/* EXEC SQL WHENEVER SQLWARNING    CONTINUE; */ 

	/* EXEC SQL WHENEVER NOT FOUND     CONTINUE; */ 

	
	memset( szCad, '\0', sizeof( szCad ) );
	memset( szPassDec, '\0', sizeof( szPassDec ) );
	memset( szTmp, '\0', sizeof( szTmp ) );
	memset( szPasswd, '\0', sizeof( szPasswd ) );
	memset( szRole, '\0', sizeof( szRole ) );
	memset( szhStm, '\0', sizeof( szhStm ) );
	memset( szUsr, '\0', sizeof( szUsr ) );
	
	strcpy( szUsr, szUser );
	if( strstr( szUsr, "/" ) != NULL ) 
		strcpy( szUsr, strtok( szUsr, "/" ) );
	else 
		strcpy( szUsr, szUser );
	
	strtoupper(szUsr);
	
	strcpy( szhStm, "SET ROLE SISCEL_ADMIN" );
	
	/* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )312;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
 sqlstm.sqhstl[0] = (unsigned long )5001;
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
		iAdmin = FALSE;
	else 
		iAdmin = TRUE;
	
	strcpy( szhStm, "SET ROLE SISCEL_SEGUR" );
	
	/* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )331;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
 sqlstm.sqhstl[0] = (unsigned long )5001;
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
		return( FALSE );
	
	/* Roles de Usuario */
	/* EXEC SQL DECLARE UROLES_CURSOR CURSOR FOR
	SELECT A.ROLE, NVL(B.PASSWORD,CHR(0))
	FROM   GE_SEG_USUROLES A,GE_SEG_ROLE B,GE_SEG_USUARIO C
	WHERE  A.ROLE = B.ROLE
	AND    A.NOM_USUARIO = C.NOM_USUARIO
	AND    A.NOM_USUARIO = :szUsr; */ 

	/* EXEC SQL OPEN UROLES_CURSOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0012;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )350;
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



	if( sqlca.sqlcode ) return FALSE;
	
	for(;;) 
	{
		/* EXEC SQL 
		FETCH UROLES_CURSOR 
		INTO  :szRole,:szPasswd; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )369;
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
  sqlstm.sqhstl[1] = (unsigned long )5001;
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


		
		if( sqlca.sqlcode == SQLNOTFOUND ) break;
		if( sqlca.sqlcode) return FALSE;
		/* Compone cadena de roles */
		if( strlen( szPasswd ) ) 
		{
			decode( szPasswd, szPassDec );
			sprintf( szCad, "%s%s IDENTIFIED BY %s,", szTmp, szRole, szPassDec );
		} 
		else 
			sprintf( szCad, "%s%s,", szTmp, szRole );
			
		strcpy( szTmp, szCad );
	}
	
	/* EXEC SQL CLOSE UROLES_CURSOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )392;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode ) return FALSE;
	
	fprintf( stdout, "Obtuvimos roles de usuario.\n" );

	/* Roles de Grupo */
	/* EXEC SQL DECLARE GROLES_CURSOR CURSOR FOR
	SELECT A.ROLE, NVL(B.PASSWORD,CHR(0))
	FROM   GE_SEG_GRPROLES A,GE_SEG_ROLE B,GE_SEG_GRPUSUARIO C
	WHERE  A.ROLE = B.ROLE
	AND    A.COD_GRUPO   = C.COD_GRUPO
	AND    C.NOM_USUARIO = :szUsr; */ 

	/* EXEC SQL OPEN GROLES_CURSOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0013;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )407;
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



	if( sqlca.sqlcode ) return FALSE;
	
	for(;;) 
	{
		/* EXEC SQL 
		FETCH GROLES_CURSOR 
		INTO  :szRole,:szPasswd; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )426;
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
  sqlstm.sqhstl[1] = (unsigned long )5001;
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


		
		if( sqlca.sqlcode == SQLNOTFOUND ) break;
		if( sqlca.sqlcode ) return FALSE;
		/* Compone cadena de roles */
		if( strlen( szPasswd ) ) 
		{
			decode( szPasswd, szPassDec );
			sprintf( szCad, "%s%s IDENTIFIED BY %s,", szTmp, szRole, szPassDec );
		} 
		else 
		{
			sprintf( szCad, "%s%s,", szTmp, szRole );
		}	
		strcpy( szTmp, szCad );
	}
	
	/* EXEC SQL CLOSE GROLES_CURSOR; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )449;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode ) return FALSE;
	
	fprintf( stdout, "Obtuvimos roles de Grupo.\n" );

	if( strlen( szCad ) ) 
		szCad[strlen( szCad ) - 1] = '\0';
	else 
		strcpy( szCad, "SISCEL_SEGUR" );
	
	sprintf( szhStm, "SET ROLE %s", szCad );
	
	/* EXEC SQL EXECUTE IMMEDIATE :szhStm; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )464;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhStm;
 sqlstm.sqhstl[0] = (unsigned long )5001;
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



	fprintf( stdout, "[%d]", sqlca.sqlcode );
	fprintf( stdout, "SET ROLE [%s]", szhStm );
	if( sqlca.sqlcode ) return FALSE;
	
	fprintf( stdout, "Roles OK.\n" );
	return TRUE;
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

