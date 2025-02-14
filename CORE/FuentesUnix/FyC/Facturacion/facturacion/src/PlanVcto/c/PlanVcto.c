
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
           char  filnam[17];
};
static const struct sqlcxp sqlfpn =
{
    16,
    "./pc/PlanVcto.pc"
};


static unsigned int sqlctx = 3460915;


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
   unsigned char  *sqhstv[8];
   unsigned long  sqhstl[8];
            int   sqhsts[8];
            short *sqindv[8];
            int   sqinds[8];
   unsigned long  sqharm[8];
   unsigned long  *sqharc[8];
   unsigned short  sqadto[8];
   unsigned short  sqtdso[8];
} sqlstm = {12,8};

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

 static const char *sq0001 = 
"select B.NUM_DIASVENCIMIE  from FAT_PLANVENCICLIE A ,FAD_PLANVENCIMIE B wher\
e (((A.COD_CLIENTE=:b0 and COD_TIPMOVIMIENT=:b1) and A.COD_PLANVENCIMIE=B.COD_\
PLANVENCIMIE) and TO_DATE(:b2,:b3) between FEC_DESDE and FEC_HASTA) union all \
select B.NUM_DIASVENCIMIE  from FAT_PLANVENCICTA A ,FAD_PLANVENCIMIE B where (\
((A.COD_CUENTA=:b4 and COD_TIPMOVIMIENT=:b1) and A.COD_PLANVENCIMIE=B.COD_PLAN\
VENCIMIE) and TO_DATE(:b2,:b3) between FEC_DESDE and FEC_HASTA)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,462,0,9,67,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,5,0,0,
52,0,0,1,0,0,13,80,0,0,1,0,0,1,0,2,3,0,0,
71,0,0,1,0,0,15,93,0,0,0,0,0,1,0,
86,0,0,2,233,0,4,109,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
};


/*****************************************************************************/
/*  Fichero    : PlanVcto.pc                                                 */
/*  Descripcion: Planes de Descuento                                         */
/*****************************************************************************/
#define _PLANVCTO_PC_


#include "PlanVcto.h"

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

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szFormatoFec  [17];/* EXEC SQL VAR szFormatoFec IS STRING(17); */ 

    long    lhCodCliente    ;
    long    lhCodCuenta     ;
    int     ihCodTipMovimien;
    char    szhFecEmision  [15];/* EXEC SQL VAR szhFecEmision IS STRING(15); */ 

/* EXEC SQL END DECLARE SECTION; */ 


/* EXEC SQL DECLARE Cur_Venci CURSOR FOR
	SELECT B.NUM_DIASVENCIMIE
      FROM FAT_PLANVENCICLIE A, FAD_PLANVENCIMIE B
     WHERE A.COD_CLIENTE       =:lhCodCliente
       AND COD_TIPMOVIMIENT=:ihCodTipMovimien
       AND A.COD_PLANVENCIMIE=B.COD_PLANVENCIMIE
       AND TO_DATE(:szhFecEmision, :szFormatoFec) BETWEEN FEC_DESDE AND FEC_HASTA
	UNION ALL
	SELECT B.NUM_DIASVENCIMIE
	  FROM FAT_PLANVENCICTA A, FAD_PLANVENCIMIE B
     WHERE A.COD_CUENTA			=:lhCodCuenta
       AND COD_TIPMOVIMIENT		=:ihCodTipMovimien
       AND A.COD_PLANVENCIMIE	=B.COD_PLANVENCIMIE
       AND TO_DATE(:szhFecEmision, :szFormatoFec) BETWEEN FEC_DESDE AND FEC_HASTA; */ 


/* **************************************************************** */
access BOOL bGetNumDiasPlanVcto (long plCodCliente,
                                 long plCodCuenta,
                                 int  piCodTipMovimien,
                                 char *szFecEmision,
                                 int  *iNumDias)
{
    char modulo[]   = "bGetNumDiasPlanVcto";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    int     ihNumDias     = 0;
	    int     ihNumDias2    = 0;
	    char    szhCodRegion   [4];/* EXEC SQL VAR szhCodRegion IS STRING(4); */ 

	    char    szhCodProvincia[6];/* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

	    char    szhCodCiudad   [6];/* EXEC SQL VAR szhCodCiudad IS STRING(6); */ 

	    int     ihIndEstado   = 1;
	/* EXEC SQL END DECLARE SECTION; */ 



    ihNumDias     = 0;

    ihCodTipMovimien	= piCodTipMovimien;
    strcpy(szhFecEmision, szFecEmision);
    lhCodCliente		= plCodCliente;
    lhCodCuenta			= plCodCuenta;
    strcpy(szFormatoFec,"YYYYMMDDHH24MISS");

    vDTrazasLog  (modulo,"\tCarga de Vencimientos diferidos %s"
    					 "\n\t\tCodigo Cliente : [%ld]"
    					 "\n\t\tCodigo Cuenta  : [%ld]"
    					 ,LOG05,modulo,lhCodCliente,lhCodCuenta);


	/* EXEC SQL OPEN Cur_Venci; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
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
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipMovimien;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[2] = (unsigned long )15;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szFormatoFec;
 sqlstm.sqhstl[3] = (unsigned long )17;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCuenta;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipMovimien;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[6] = (unsigned long )15;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szFormatoFec;
 sqlstm.sqhstl[7] = (unsigned long )17;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(modulo,"Al consultar FAT_PLANVENCICLIE/FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
                         ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	vDTrazasLog  (modulo,"Al consultar FAT_PLANVENCICLIE/FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
    		             ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	return FALSE;

    }
    if (!SQLCODE)
    {
        /* EXEC SQL FETCH Cur_Venci INTO :ihNumDias; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 8;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )52;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihNumDias;
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



        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasError(modulo,"Al Fetch FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
                             ,LOG01,sqlca.sqlerrm.sqlerrmc);
        	vDTrazasLog  (modulo,"Al Fetch FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
        		             ,LOG01,sqlca.sqlerrm.sqlerrmc);
        	return FALSE;

        }
	}

	/* EXEC SQL CLOSE Cur_Venci; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )71;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE != SQLOK )
    {
        vDTrazasError(modulo,"Al Cerrar FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
                         ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	vDTrazasLog  (modulo,"Al Cerrar FAT_PLANVENCICTA/GAD_PLANVENCIMIE\n%s\n"
    		             ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	return FALSE;

    }

	strcpy (szhCodRegion   ,stCliente.szCodRegion)   ;
	strcpy (szhCodProvincia,stCliente.szCodProvincia);
	strcpy (szhCodCiudad   ,stCliente.szCodCiudad)   ;
	ihIndEstado = 1;

	/* EXEC SQL
	SELECT B.NUM_DIASVENCIMIE
	  INTO :ihNumDias2
	  FROM FA_VENCIMIENTO_ZONA_GEOGRAF_TO A, FAD_PLANVENCIMIE B
	 WHERE A.COD_VENCIME 	 = :szhCodCiudad
	   AND A.COD_REGION  	 = :szhCodRegion
	   AND A.COD_PROVINCIA 	 = :szhCodProvincia
	   AND B.COD_PLANVENCIMIE= A.COD_PLANVENCIMIE
	   AND A.IND_ESTADO      = :ihIndEstado; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select B.NUM_DIASVENCIMIE into :b0  from FA_VENCIMIENTO_ZONA\
_GEOGRAF_TO A ,FAD_PLANVENCIMIE B where ((((A.COD_VENCIME=:b1 and A.COD_REGION\
=:b2) and A.COD_PROVINCIA=:b3) and B.COD_PLANVENCIMIE=A.COD_PLANVENCIMIE) and \
A.IND_ESTADO=:b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )86;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumDias2;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodCiudad;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodRegion;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodProvincia;
 sqlstm.sqhstl[3] = (unsigned long )6;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihIndEstado;
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
        vDTrazasError(modulo,"Al consultar FA_VENCIMIENTO_TO/FAD_PLANVENCIMIE B\n%s\n"
                         ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	vDTrazasLog  (modulo,"Al consultar FA_VENCIMIENTO_TO/GAD_PLANVENCIMIE\n%s\n"
    		             ,LOG01,sqlca.sqlerrm.sqlerrmc);
    	return FALSE;

	}

	ihNumDias += ihNumDias2;

    if (ihNumDias > 0)
    {
        *iNumDias=ihNumDias;
    }
    else
    {
        *iNumDias=0;
    }
    return TRUE;

}

/* **************************************************************** */
/*****************************************************************************/
/*  Funcion : bfnDiasVencimiento                                             */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bfnDiasVencimiento (long lCliente,
                         long lCuenta,
                         int  iCodTipMovimien,
                         char *szFecEmision,
                         char *szFecVencimi,
                         char *szFecFinal)
{
    char modulo[]   = "bfnDiasVencimiento";
    int iNumDias=0;

    vDTrazasLog (modulo,"\n\t*****---> Inicio Funcion de Plan de Vencimientos <---- *****",LOG04);

    if (!bGetNumDiasPlanVcto (lCliente, lCuenta, iCodTipMovimien, szFecEmision, &iNumDias))
    {
        vDTrazasError(modulo,"Al rescatar dias de Plan Vcto. \n%s\n"
                             ,LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasLog  (modulo,"Al rescatar dias de Plan Vcto. \n%s\n"
                            ,LOG01,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }
    vDTrazasLog (modulo,"\t\t Cantidad de Dias de Vcto. [%d] Fecha de Vencinmiento [%s]\n" ,LOG05,iNumDias,szFecVencimi);

    if (iNumDias> 0)
    {
        if (!bSumaDias ( szFecFinal, szFecVencimi, iNumDias))         /* Antes szFecEmision */
        {
            vDTrazasError(modulo,"Al sumar dias a la fecha de emision \n%s\n"
                                ,LOG01,sqlca.sqlerrm.sqlerrmc);
            vDTrazasLog  (modulo,"Al sumar dias a la fecha de emision \n%s\n"
                                ,LOG01,sqlca.sqlerrm.sqlerrmc);
            return FALSE;
        }
        vDTrazasLog(modulo,"\t\t Encontrado Plan Vcto. Fecha Vcto. [%s]\n",LOG05,szFecFinal);
        if (!bBuscaDiaHabil (szFecFinal, szFecFinal))
        {
            vDTrazasError(modulo,"Al buscar dia habil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
            vDTrazasLog  (modulo,"Al buscar dia habil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
            return FALSE;
        }
        vDTrazasLog(modulo,"\t\t Fecha Vcto. Habil [%s]\n",LOG05,szFecFinal);
    }
    else
    {
        strcpy ( szFecFinal, szFecVencimi );
    }
    return TRUE;
}

/* **************************************************************** */
/* **************************************************************** */
BOOL bBuscaDiaHabil (char *pszFecha, char *pszFecFinal)
{
    char modulo[]   = "bBuscaDiaHabil";

    int iIndHabil=0;
    int iIndFeria=0;
    vDTrazasLog  (modulo,"\tempezando %s\n",LOG05,modulo);
    while (1)
    {
        if(!bDiaFeriado(pszFecha, &iIndFeria))
        {
            vDTrazasError(modulo,"Al determinar dia feriado \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
            vDTrazasLog  (modulo,"Al determinar dia feriado \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
            return (FALSE);
        }
        else
        {
            if (iIndFeria==0)
            {
                if (!bGetTipoDia(pszFecha, &iIndHabil))
                {
                    vDTrazasError(modulo,"Al determinar dia habil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
                    vDTrazasLog  (modulo,"Al determinar dia habil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
                    return (FALSE);
                }
            }
        }
        if (iIndFeria==1 || iIndHabil==0)
        {
            if (!bSumaDias ( pszFecha, pszFecha, 1))
            {
                vDTrazasError(modulo,"Al sumar dias a la fecha inhabil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
                vDTrazasLog  (modulo,"Al sumar dias a la fecha inhabil \n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
                return (FALSE);
            }
            vDTrazasLog  (modulo,"Fecha sumada  %s\n",LOG05,pszFecha);
        }
        else
        {
            break;
        }
    }
    strcpy (pszFecFinal, pszFecha);
    return (TRUE);
}

/* **************************************************************** */
/* **************************************************************** */
BOOL bGetTipoDia (char *pszFecha, int *iIndHab)
{
    char modulo[]   = "bGetTipoDia";

	int d,m,y;
	char cadena [10];
	int iNumDia;

	vDTrazasLog  (modulo,"\tempezando %s\n",LOG05,modulo);

    sprintf ( cadena, "%c%c", pszFecha[6],pszFecha[7]);
    d = atoi (cadena);       /* el día del mes -- [1,31] */
    sprintf ( cadena, "%c%c", pszFecha[4],pszFecha[5]);
    m  = atoi (cadena);      /* los meses desde Enero -- [0,11] */
    sprintf ( cadena, "%c%c%c%c", pszFecha[0],pszFecha[1],pszFecha[2],pszFecha[3]);
    y = atoi (cadena) ;      /* los años */

   /** a 45 character C expression by Keith    **/
   /** With 0=Sunday, 1=Monday, ... 6=Saturday **/
   iNumDia =  (d+=m<3?y--:y-2,23*m/9+d+4+y/4-y/100+y/400)%7;

   iNumDia ++; /* se suma un dia para compatibilizar con ORACLE */

	switch(iNumDia)
	{
   		case	2:
   		case 	3:
   		case	4:
   		case	5:
   		case    6:
   			*iIndHab = 1;
   			break;
   		default:
   			*iIndHab = 0;
   			break;
    }
	return(TRUE);
}

/* **************************************************************** */
/* **************************************************************** */
BOOL bDiaFeriado (char *pszFecha, int *iIndFeria)
{
    int i;
    char modulo[]   = "bDiaFeriado";

	vDTrazasLog  (modulo,"\tempezando %s\n",LOG05,modulo);

    *iIndFeria=0;
    for (i=0; i<=NUM_FERIADOS;i++)
    {
        vDTrazasLog  (modulo,"feriados \n%s\n",LOG06, pstFeriados[i].szFecFeriado );
        if (strncmp (pszFecha, pstFeriados[i].szFecFeriado, 8) == 0)
        {
            *iIndFeria=1;
            break;
        }
    }

    return (TRUE);
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

