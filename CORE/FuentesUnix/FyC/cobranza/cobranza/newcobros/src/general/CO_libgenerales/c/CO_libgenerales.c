
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
           char  filnam[24];
};
static const struct sqlcxp sqlfpn =
{
    23,
    "./pc/CO_libgenerales.pc"
};


static unsigned int sqlctx = 442316867;


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
   unsigned char  *sqhstv[12];
   unsigned long  sqhstl[12];
            int   sqhsts[12];
            short *sqindv[12];
            int   sqinds[12];
   unsigned long  sqharm[12];
   unsigned long  *sqharc[12];
   unsigned short  sqadto[12];
   unsigned short  sqtdso[12];
} sqlstm = {12,12};

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

 static const char *sq0015 = 
"select COD_CLIENTE  from GE_CLIENTES where (COD_TIPIDENT=:b0 and NUM_IDENT=:\
b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,0,0,17,124,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,142,0,0,0,0,0,1,0,
39,0,0,1,0,0,13,153,0,0,1,0,0,1,0,2,5,0,0,
58,0,0,1,0,0,15,165,0,0,0,0,0,1,0,
73,0,0,2,0,0,17,379,0,0,1,1,0,1,0,1,97,0,0,
92,0,0,2,0,0,21,388,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
119,0,0,3,241,0,4,404,0,0,12,11,0,1,0,1,97,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
182,0,0,4,0,0,17,441,0,0,1,1,0,1,0,1,97,0,0,
201,0,0,4,0,0,21,449,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
232,0,0,5,265,0,4,481,0,0,10,8,0,1,0,1,97,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
287,0,0,6,267,0,4,503,0,0,10,8,0,1,0,1,97,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
342,0,0,7,86,0,4,555,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
369,0,0,8,0,0,17,585,0,0,1,1,0,1,0,1,97,0,0,
388,0,0,8,0,0,21,594,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
427,0,0,9,86,0,5,605,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
450,0,0,10,0,0,17,633,0,0,1,1,0,1,0,1,97,0,0,
469,0,0,10,0,0,21,643,0,0,5,5,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
504,0,0,11,0,0,17,735,0,0,1,1,0,1,0,1,97,0,0,
523,0,0,11,0,0,45,752,0,0,6,6,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,3,0,0,
562,0,0,11,0,0,45,754,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
585,0,0,11,0,0,13,762,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
608,0,0,11,0,0,15,774,0,0,0,0,0,1,0,
623,0,0,12,286,0,4,833,0,0,7,6,0,1,0,1,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,1,5,0,0,
666,0,0,13,271,0,4,853,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,
705,0,0,14,272,0,4,872,0,0,6,5,0,1,0,1,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,
744,0,0,15,90,0,9,934,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
767,0,0,15,0,0,13,945,0,0,1,0,0,1,0,2,3,0,0,
786,0,0,15,0,0,15,974,0,0,0,0,0,1,0,
801,0,0,16,269,0,4,1012,0,0,5,4,0,1,0,2,4,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
836,0,0,17,132,0,4,1084,0,0,5,4,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
871,0,0,18,118,0,4,1132,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
};


/* ============================================================================= 
 Tipo          :  FUNCIONES GENERALES 
 Nombre        :  CO_libgenerales.pc
 Descripcion   :  Rutinas Generales de los procesos y rutinas de newcobros
 Fecha         :  14-Oct-2004  GAC.
 Creada 14-10-2004 por Proyecto P-MAS-04037 Mejoras Ejecutor y Excluidor
 Version 4.0.0 
 ============================================================================ */

#define _COLIBGENERALES_PC_
#include <CO_deftypes.h>
#include <CO_oracle.h>
#include "CO_stPtoRut.h"
#include "CO_libgenerales.h"

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


/* ============================================================================= */
/* szGetTime : Recupera la fecha del sistema en el formato deseado (pudiendo ser */
/*             fecha y hora) Permite cualquier valor numerico, con las sgtes     */
/*             restricciones                                                     */
/*              fmto = 0 : fecha de hoy en fmto por defecto (dd/mm/yyyy)         */
/*              fmto > 0 : fecha de hoy en fmto definido en el switch (y/u hora) */
/*              fmto < 0 : fecha pasada en fmto 2(yyyymmdd), vuelve 'fmto' dias  */
/* ============================================================================= */
char *szGetTime(int fmto)
{
char modulo[]="szGetTime";

static time_t timer;
static size_t nbytes;
static char szTime[26]="";
int iDia = 86400;

	memset(szTime,'\0',26);
	
	if (fmto >= 0)
	{	
		timer = time((time_t *)0);
	}
	else
	{	
		timer = time((time_t *)0)+fmto*iDia; 
		fmto = 2;
	}

	switch (fmto)
	{
		case 1 :
				nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> [04-Feb-2000] [11:22:38] (escritura de log)*/
		case 2 :
				nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000->  20000204  (nombre de archivo) */
		case 3 :
				nbytes = strftime(szTime, 26, "[%H:%M:%S]", (struct tm *)localtime(&timer));	
				break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  [11:22:38] (escritura de log) */
		case 4 :
				nbytes = strftime(szTime, 26, "%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  112238 (nombre de archivo) */
		case 5 :
				nbytes = strftime(szTime, 26, "%Y%m%d_%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 20000204_112238 (nombre de archivo: 1_3)*/
		case 6 :
				nbytes = strftime(szTime, 26, "%j", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 035 (fecha juliana 001-366 )*/
		case 7 :
				nbytes = strftime(szTime, 26, "%Y%m%d%H%M%S", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 20000204112238 (tipo Oracle)*/
		default :
				nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
				break; /* Ej.: 4 de febrero de 2000 -> 04/02/2000 (formato comun)*/
	}
	
	return (char *) szTime;
}

/* ============================================================================= */
/* szDate : Obtiene la fecha del sistema mas o menos 'n' dias en el fmto deseado */
/* ============================================================================= */
char *szDate(int iNDias,char *szFmto)
{
static time_t timer;
static size_t nbytes;
static char szTime[26]="";
int UnDia = 86400;

	memset(szTime,'\0',26);
	timer = time((time_t *)0)+(iNDias*UnDia); 
   nbytes = strftime(szTime, 26, szFmto, (struct tm *)localtime(&timer));	
	return (char *) szTime;

}

/* ============================================================================= */
/* Recibe el formato en el que desea retornar SYSDATE                            */
/* Asume que se encuentra conectado a Oracle                                     */
/* ============================================================================= */
char *szSysDate (char *szFmto)
{
static char szDT[32]="";
int iSqlCode=0;
    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char  szhDateTime [32]; /* EXEC SQL VAR szhDateTime IS STRING(32); */ 

    char szCadena[128]="";
/* EXEC SQL END DECLARE SECTION; */ 


    memset(szDT,'\0',sizeof(szDT));
    memset(szhDateTime,'\0',sizeof(szhDateTime));
    memset(szCadena,'\0',sizeof(szCadena));

    iSqlCode=SQLCODE; /*guarda el estado de oracle antes de entrar*/

    if ( *szFmto == '\0' ) 
    {
        sprintf(szDT,"-nullstring-");
        return (char *)szDT; 
    }

    sprintf(szCadena,"SELECT TO_CHAR(SYSDATE,'%s') FROM DUAL",szFmto);

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL PREPARE SQL_DINAMICO FROM :szCadena; */ 

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
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )128;
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


    if ( SQLCODE ) 
    {
        sprintf(szDT,"prepare:%d",SQLCODE);
        SQLCODE=iSqlCode;
        return (char *)  szDT;
    }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL DECLARE CUR_DINAMICO CURSOR FOR SQL_DINAMICO; */ 

    if ( SQLCODE ) 
    {
        sprintf(szDT,"declare:%d",SQLCODE);
        SQLCODE=iSqlCode;
        return (char *)  szDT;
    }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL OPEN CUR_DINAMICO; */ 

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


    if ( SQLCODE ) 
    {
        sprintf(szDT,"open:%d",SQLCODE);
        SQLCODE=iSqlCode;
        return (char *)  szDT;
    }

    do
    {
    	sqlca.sqlcode=0; /* XO-200508280498 rvc */
        /* EXEC SQL FETCH CUR_DINAMICO INTO :szhDateTime; */ 

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
        sqlstm.sqhstv[0] = (unsigned char  *)szhDateTime;
        sqlstm.sqhstl[0] = (unsigned long )32;
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


        if( SQLCODE == SQLOK ) 
        {
            sprintf( szDT, "%s\0", szhDateTime );
        }
        else
        {
            sprintf( szDT, "Fetch:%d", SQLCODE );
        }
    } while ( FALSE );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
    /* EXEC SQL CLOSE CUR_DINAMICO; */ 

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


    if( SQLCODE ) 
    {
        sprintf(szDT,"Close:%d",SQLCODE);
        SQLCODE=iSqlCode;
        return (char *)  szDT;
    }


    SQLCODE=iSqlCode; /*vuelve al estado de oracle antes de entrar*/
    return (char *) szDT;
}



/* ============================================================================= */
/* ifnTrazasLog (char*,char*,int,...)                                            */ 
/* Parametros: szExeNameApp      Nombre del programa que llama a ifnTrazasLog    */  
/*             szTxt          Texto a incluir el el fichero de log               */  
/*             iNivel         Nivel de log                                       */ 
/* ============================================================================= */
int ifnTrazasLog (char* szExeNameApp, char* szTxt, int iNivel,...)
{
char szMsg[TAMBUFSIZ]="";
va_list ap;
int iAux = 0;
FILE *fh;    /* file handler generico */   
int iTrLog = 0;

	fh = ( stStatus.LogFile == (FILE *)NULL ) ? stderr : stStatus.LogFile;  
	/* Si no hay archivo definido, escribe a stderr */
    
	memset(szMsg,'\0',sizeof(szMsg));
	va_start( ap, szTxt );
	vsprintf (szMsg,szTxt,ap);
	va_end( ap );  

	/* NUEVO CONCEPTO */
	if (iNivel == INFALL) /* si es un mensaje para todos los archivos abiertos */
	{
		iAux = fprintf (fh,"\n\t%s",szMsg);			/* Log */
		if (stStatus.ErrFile != (FILE *)NULL) 
		{
			fprintf (stStatus.ErrFile,"\n\t%s",szMsg);	/* Errores */
			fflush (stStatus.ErrFile);
		}  
		if (stStatus.EstFile != (FILE *)NULL)
		{
			fprintf (stStatus.EstFile,"\n\t%s",szMsg);	/* Estadisticas */
			fflush (stStatus.EstFile);
		}
	}

	if (iNivel == EST00) /* si es un mensaje que va a la estadistica */
	{
		iNivel = LOG03 ; /* baja nivel de log, para que tambien vaya al Log */
		if (stStatus.EstFile != (FILE *)NULL) 
		{
			fprintf(stStatus.EstFile,"\n\t%s %s",szGetTime(1),szMsg);
			fflush (stStatus.EstFile);
		}
	}
	
	if (iNivel <= stStatus.iLogNivel) 
	{
		switch (iNivel) 
		{
			case LOG00: iAux = fprintf (fh,"\n\t%s\n\tError Oracle (%s): %s",szGetTime(1),szExeNameApp,szMsg);
				if (stStatus.ErrFile != (FILE *)NULL) 
				{
					fprintf(stStatus.ErrFile,"\n\t%s\n\tError Oracle (%s): %s",szGetTime(1),szExeNameApp,szMsg); 
					fflush (stStatus.ErrFile);
				}  
				break;
				
			case LOG01: iAux = fprintf (fh,"\n\t%s\tError (%s): %s",szGetTime(1),szExeNameApp,szMsg);
				if (stStatus.ErrFile != (FILE *)NULL)
				{
					fprintf(stStatus.ErrFile,"\n\t%s\n\tError (%s): %s",szGetTime(1),szExeNameApp,szMsg); 
					fflush (stStatus.ErrFile);
				}  
				break;
			
			case LOG02: iAux = fprintf (fh,"\n\tAviso (%s): %s",szExeNameApp,szMsg);
				break;
			
			case LOG03: iAux = fprintf (fh,"\n\t%s",szMsg);
				break;
			
			default:    iAux = fprintf (fh,"\n\t%s",szMsg);
				break;
		
		}/* end switch */

	}/*end if */

	if (iAux < 0) return -1; /* fallo el fprintf del archivo de log */
    
	if ( fflush(fh) != 0 )  return -2; /* fallo el fflush */
    
	return 0; /* todo salio bien */
}

/*==================================================================================================*/
/* Funcion que Quita los espacios en blanco a la derecha de una cadena										 */
/*==================================================================================================*/
void rtrim( char *szCadena )
{
	char modulo[] = "rtrim";
	 int i, iLen, iCnt;

    iLen = strlen( szCadena ) - 1;
    for( iCnt = iLen; iCnt >= 0; iCnt-- ) if( szCadena[iCnt] != ' ' && szCadena[iCnt] != '\0' ) break;
    szCadena[ iCnt + 1 ] = '\0'; 	/* reemplaza primer ' ' por '\0' produciendo un rtrim */
    return;
} /* void rtrim( char *szCadena ) */

/* ============================================================================= 
   Funcion que Actualiza la co_gestion para un cliente dado.                     
	Parametros	lCodCliente		Cliente dado.
					lCodCuenta		Cuenta a la que pertenece el Cliente.
					szNumIdent		Rut al que pertenece el cliente.
					szCodTipIdent	
					szCodEntidad	Entidad de cobranza del cliente.
					pszRutina		Rutina que llama:
					               A : Asignacion Transitoria (ACEXT, ASDIC).
										D : Desasignacion Transitoria (DACEX, DADIC).
										P : Proceso asignacion definitiva (DICOM, COBEX).
			   pszCodMovimiento  Codigo de movimiento involucrado: 	
					               A : Alta (DICOM, COBEX).
										B : Baja (DICOM, COBEX).
										R : Reasignado (COBEX).
										M : Modificado (DICOM, COBEX).
 ============================================================================= */
BOOL bfnActualizaCoGestionCliente( long lCodCliente  , long lCodCuenta, char *szNumIdent , char *szCodTipIdent,
								           char *szCodEntidad, char *pszRutina, char *pszCodMovimiento )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	lhCodCliente;
	long	lhCodCuenta;
	char	szhNumIdent    [iLENNUMIDENT] = ""; 
	char	szhCodTipIdent    [3] = "";
	char	szhCodGestionAct  [5] = "";
	char	szhCodGestionNew  [5] = "";
	char	szhCodAlta        [6] = "";
	char	szhCodBaja        [6] = "";
	char	szhCodAltaTran    [6] = "";
	char	szhCodBajaTran    [6] = "";
	char	szhSql         [1000] = "";
	char	szhObsGestion    [51] = "";
	char	szhCodEntidad     [6] = "";
	char	szhSituacion      [2] = "";
   int   iCountGest   =0;
   /*********************/
   char  szhLetra_X  [2];
   char  szhLetra_C  [2];
   char  szhLetra_H  [2];
   int   ihValor_dos  = 2;
/* EXEC SQL END DECLARE SECTION; */ 

char	modulo[] = "bfnActualizaCoGestionCliente";
char	szCodMovimiento[6], szRutina[6];
BOOL	bInserta = FALSE, bEncon = FALSE;
int	ilong = 0, rr;

	memset( szhSql, '\0', sizeof( szhSql ) );
	memset( szRutina, '\0', sizeof( szRutina ) );
	memset( szCodMovimiento, '\0', sizeof( szCodMovimiento ) );
	memset( szhCodEntidad, '\0', sizeof( szhCodEntidad ) );
	memset( szhCodTipIdent, '\0', sizeof( szhCodTipIdent ) );
	memset( szhNumIdent, '\0', sizeof( szhNumIdent ) );
	memset( szhCodGestionNew, '\0', sizeof( szhCodGestionNew ) );
	memset( szhSituacion, '\0', sizeof( szhSituacion ) );

	lhCodCliente = lCodCliente;
	lhCodCuenta  = lCodCuenta;
	strcpy( szRutina, pszRutina );
	strcpy( szCodMovimiento, pszCodMovimiento );
	strcpy( szhCodEntidad, szCodEntidad );
	strcpy( szhCodTipIdent, szCodTipIdent );
	strcpy( szhNumIdent, szNumIdent );
	strcpy( szhCodGestionNew, "X" );
	strcpy( szhSituacion, "X" );
	strcpy(szhLetra_X,"X");
	strcpy(szhLetra_C,"C");
	strcpy(szhLetra_H,"H");
	
	ifnTrazasLog( modulo, "(Cliente:%ld) Ingreso %s - szCodEntidad = [%s] - szRutina = [%s].", 
							LOG05, lhCodCliente, modulo, szCodEntidad, szRutina );  
	
	if( strcmp( szhCodEntidad, "DICOM" ) == 0 ) /* si es para DICOM */
	{
		strcpy( szhCodAlta, "788\0" );				
		strcpy( szhCodBaja, "789\0" );				
		strcpy( szhCodAltaTran, "-788\0" );				
		strcpy( szhCodBajaTran, "-789\0" );				
	}
	else /* es Cobranza Externa */
	{
		strcpy( szhCodAlta, "778\0" );				
		strcpy( szhCodBaja, "779\0" );				
		strcpy( szhCodAltaTran, "-778\0" );				
		strcpy( szhCodBajaTran, "-779\0" );				
	}
	
	if( strcmp( szRutina, "A" ) == 0 ) /* acciones de asignacion, dar alta transitoria en la co_gestion */
	{
		/* debemos limpiar cualquier valor negativo, anterior */
		sprintf( szhSql, "DELETE  FROM CO_GESTION "
						      "WHERE  COD_CLIENTE = :v1 "
						      "AND    COD_GESTION IN ( :v2, :v3 )");

		ifnTrazasLog( modulo, "[%s]\n", LOG05, szhSql );

		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL PREPARE deleteCoGestionTran FROM :szhSql; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 1;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )73;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
  sqlstm.sqhstl[0] = (unsigned long )1000;
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

	

		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 
		{
			ifnTrazasLog( modulo, "(Cliente:%ld) PREPARE deleteCoGestionTran %s.", LOG00, lhCodCliente, SQLERRM );  
			return FALSE;
		}

		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL EXECUTE deleteCoGestionTran USING :lhCodCliente, :szhCodAltaTran, :szhCodAltaTran ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 3;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )92;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodAltaTran;
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



		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
		{
			ifnTrazasLog( modulo, "(Cliente:%ld) EXECUTE deleteCoGestionTran %s.", LOG00, lhCodCliente, SQLERRM );  
			return FALSE;
		}

		strcpy( szhCodGestionNew, szhCodAltaTran );
		bInserta = TRUE;
	}

	if( strcmp( szRutina, "D" ) == 0 ) /* acciones de desasignacion, dar baja transitoria en la co_gestion */
	{
		/* debemos averiguar si tiene un codigo de alta transitoria que aun no se ejecuta */
		sqlca.sqlcode=0; /* XO-200508280498 rvc */
		/* EXEC SQL
		SELECT NVL( MAX( COD_GESTION ), :szhLetra_X )
		INTO	 :szhCodGestionAct
		FROM	 CO_GESTION
		WHERE	 COD_CLIENTE = :lhCodCliente
		AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
								     FROM	CO_GESTION
								     WHERE	COD_CLIENTE = :lhCodCliente 
								     AND    COD_GESTION IN( :szhCodAltaTran, :szhCodBajaTran, :szhCodAlta, :szhCodBaja ) )
		AND    COD_GESTION IN( :szhCodAltaTran, :szhCodBajaTran, :szhCodAlta, :szhCodBaja ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select NVL(max(COD_GESTION),:b0) into :b1  from CO_GESTION \
where ((COD_CLIENTE=:b2 and FEC_GESTION=(select max(FEC_GESTION)  from CO_GEST\
ION where (COD_CLIENTE=:b2 and COD_GESTION in (:b4,:b5,:b6,:b7)))) and COD_GES\
TION in (:b4,:b5,:b6,:b7))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )119;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
  sqlstm.sqhstl[1] = (unsigned long )5;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
  sqlstm.sqhstl[5] = (unsigned long )6;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodAlta;
  sqlstm.sqhstl[6] = (unsigned long )6;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodBaja;
  sqlstm.sqhstl[7] = (unsigned long )6;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhCodAltaTran;
  sqlstm.sqhstl[8] = (unsigned long )6;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCodBajaTran;
  sqlstm.sqhstl[9] = (unsigned long )6;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhCodAlta;
  sqlstm.sqhstl[10] = (unsigned long )6;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhCodBaja;
  sqlstm.sqhstl[11] = (unsigned long )6;
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


		
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
			ifnTrazasLog( modulo, "(Cliente:%ld) SELECT COD_GESTION %s.", LOG00, lhCodCliente, SQLERRM );  
			return FALSE;
		} 
		else if( SQLCODE != SQLNOTFOUND )
		{
			ilong = strlen( szhCodGestionAct ) - 1;
			for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodGestionAct[rr] != ' ') break ;
			szhCodGestionAct[rr + 1] = '\0';

			ifnTrazasLog( modulo, "(Cliente:%ld) szhCodGestionAct [%s].", LOG05, lhCodCliente, szhCodGestionAct );  
	
			if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 ) /* si hay alta transitoria */
			{
				/* borramos el registro de alta transitoria, el cliente pago, antes del alta definitiva */
				sprintf( szhSql, "DELETE FROM CO_GESTION "
								     "WHERE	 COD_CLIENTE = :v1 "
								     "AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION ) "
								     "						     FROM	CO_GESTION "
								     "						     WHERE	COD_CLIENTE = :v2 "
								     "						     AND    COD_GESTION = :v3 ) "
								     "AND    COD_GESTION = :v4 ");

				ifnTrazasLog( modulo, "[%s]\n", LOG05, szhSql );

				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL PREPARE deleteCoGestion FROM :szhSql; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )182;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
    sqlstm.sqhstl[0] = (unsigned long )1000;
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

	

				if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
					ifnTrazasLog( modulo, "(Cliente:%ld) PREPARE deleteCodGestion %s.", LOG00, lhCodCliente, SQLERRM );  
					return FALSE;
				}

				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL EXECUTE deleteCoGestion USING :lhCodCliente, :lhCodCliente, :szhCodAltaTran, :szhCodAltaTran; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )201;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[3] = (unsigned long )6;
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



				if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
					ifnTrazasLog( modulo, "(Cliente:%ld) EXECUTE deleteCodGestion %s.", LOG00, lhCodCliente, SQLERRM );  
					return FALSE;
				}

				strcpy( szhCodGestionNew, "X" ); /* no se inserta la baja transitoria */
			} /* if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 ) */
			else
			{
				strcpy( szhCodGestionNew, szhCodBajaTran ); /* insertamos la baja transitoria */
				bInserta = TRUE;
			}	
		}
		else
		{
			strcpy( szhCodGestionNew, szhCodBajaTran ); /* insertamos la baja transitoria */
			bInserta = TRUE;
		}
	} /* if( strcmp( szRutina, "D" ) == 0 ) */

	if( strcmp( szRutina, "P" ) == 0 ) /* colas de proceso, dar alta o baja definitiva en la co_gestion o la co_hgestion*/
	{
		if( strcmp( szCodMovimiento, "A" ) == 0 ) /* es alta, nunca estara en historia */
		{
			strcpy( szhCodGestionNew, szhCodAlta );
			strcpy( szhCodGestionAct, szhCodAltaTran );
		}
		else
		{
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL
			SELECT COD_GESTION, :szhLetra_C
			INTO	 :szhCodGestionAct,
					 :szhSituacion
			FROM	 CO_GESTION
			WHERE	 COD_CLIENTE = :lhCodCliente
			AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran )
			AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
									     FROM	CO_GESTION
									     WHERE	COD_CLIENTE = :lhCodCliente 
									     AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran ) )
			AND     ROWNUM  	<  :ihValor_dos			/o siempre tiene preferencia la baja, ya que en una reasignacion esto	o/
			ORDER BY COD_GESTION DESC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_GESTION ,:b0 into :b1,:b2  from CO_GESTION wher\
e (((COD_CLIENTE=:b3 and COD_GESTION in (:b4,:b5)) and FEC_GESTION=(select max\
(FEC_GESTION)  from CO_GESTION where (COD_CLIENTE=:b3 and COD_GESTION in (:b4,\
:b5)))) and ROWNUM<:b9) order by COD_GESTION desc  ";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )232;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_C;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
   sqlstm.sqhstl[1] = (unsigned long )5;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhSituacion;
   sqlstm.sqhstl[2] = (unsigned long )2;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
   sqlstm.sqhstl[5] = (unsigned long )6;
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
   sqlstm.sqhstv[7] = (unsigned char  *)szhCodAltaTran;
   sqlstm.sqhstl[7] = (unsigned long )6;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCodBajaTran;
   sqlstm.sqhstl[8] = (unsigned long )6;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_dos;
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

			/* se debe ejecutar primero, para no limpiar la tabla co_cobexternadoc 	*/

			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
				ifnTrazasLog( modulo, "(Cliente:%ld) SELECT COD_GESTION FROM CO_GESTION%s.", LOG00, lhCodCliente, SQLERRM );  
				return FALSE;
			} 

			if( SQLCODE == SQLNOTFOUND ) /* no esta en la co_gestion, puede estar en la co_hgestion */
			{
				sqlca.sqlcode=0; /* XO-200508280498 rvc */
				/* EXEC SQL
				SELECT COD_GESTION, :szhLetra_H
				INTO	 :szhCodGestionAct,
						 :szhSituacion
				FROM	 CO_HGESTION
				WHERE	 COD_CLIENTE = :lhCodCliente
				AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran )
				AND	 FEC_GESTION = ( SELECT MAX( FEC_GESTION )
										     FROM	CO_HGESTION
										     WHERE	COD_CLIENTE = :lhCodCliente 
										     AND    COD_GESTION IN ( :szhCodAltaTran, :szhCodBajaTran ) )
				AND     ROWNUM  	<  :ihValor_dos			/o siempre tiene preferencia la baja, ya que en una reasignacion esto	o/ 		
				ORDER BY COD_GESTION DESC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_GESTION ,:b0 into :b1,:b2  from CO_HGESTION wh\
ere (((COD_CLIENTE=:b3 and COD_GESTION in (:b4,:b5)) and FEC_GESTION=(select m\
ax(FEC_GESTION)  from CO_HGESTION where (COD_CLIENTE=:b3 and COD_GESTION in (:\
b4,:b5)))) and ROWNUM<:b9) order by COD_GESTION desc  ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )287;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhLetra_H;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionAct;
    sqlstm.sqhstl[1] = (unsigned long )5;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhSituacion;
    sqlstm.sqhstl[2] = (unsigned long )2;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodBajaTran;
    sqlstm.sqhstl[5] = (unsigned long )6;
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
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodAltaTran;
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhCodBajaTran;
    sqlstm.sqhstl[8] = (unsigned long )6;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_dos;
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

			/* se debe ejecutar primero, para no limpiar la tabla co_cobexternadoc 	*/
	
				if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
				{
					ifnTrazasLog( modulo, "(Cliente:%ld) SELECT COD_GESTION FROM CO_HGESTION%s.", LOG00, lhCodCliente, SQLERRM );  
					return FALSE;
				} 
			}			
			
			if( strcmp( szhSituacion, "X" ) != 0 ) /* si lo encontramos en alguna de las tablas se procesa */
			{	
				if( strcmp( szCodMovimiento, "R" ) == 0 || strcmp( szCodMovimiento, "B" ) == 0 ) /* el rut del cliente fue reasignado, o se da de baja */
				{
					strcpy( szhCodGestionNew, szhCodBaja );
					strcpy( szhCodGestionAct, szhCodBajaTran );
				}
	
				if( strcmp( szCodMovimiento, "M" ) == 0 )
				{
					ilong = strlen( szhCodGestionAct ) - 1;
					for( rr = ilong; rr >= 0; rr = rr - 1 ) if( szhCodGestionAct[rr] != ' ') break ;
					szhCodGestionAct[rr + 1] = '\0';
	
					if( strcmp( szhCodGestionAct, szhCodAltaTran ) == 0 )
						strcpy( szhCodGestionNew, szhCodAlta );
					else
						if( strcmp( szhCodGestionAct, szhCodBajaTran ) == 0 )
							strcpy( szhCodGestionNew, szhCodBaja );
				} /* if( strcmp( szCodMovimiento, "M" ) == 0 ) */
			}
			else
			{
				strcpy( szhCodGestionNew, "X\0" );
			} /* if( strcmp( szhSituacion, 'X' ) != 0 ) */
		} /* if( strcmp( szCodMovimiento, "A" ) == 0 ) */
	} /* if( strcmp( szRutina, "P" ) == 0 ) */	
	
	if( bInserta ) /* se inserta al dar alta, baja transitoria o reasignacion */ 
	{
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
	    	/* EXEC SQL 
	    	SELECT COUNT(*)
	    	INTO  :iCountGest
	    	FROM  CO_GESTION
	    	WHERE COD_CLIENTE = :lhCodCliente
	    	AND   COD_GESTION = :szhCodGestionNew; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select count(*)  into :b0  from CO_GESTION where (COD_C\
LIENTE=:b1 and COD_GESTION=:b2)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )342;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&iCountGest;
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
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodGestionNew;
      sqlstm.sqhstl[2] = (unsigned long )5;
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
		 ifnTrazasLog( modulo, "(Cliente:%ld)(COD_GESTION:%s) SELECT count(*) FROM CO_GESTION: %s", LOG00, lhCodCliente,szhCodGestionNew, SQLERRM );
		 return FALSE;
		}

    	/* Si no existe el cliente + codigo de gestion se inserta*/
    	if (iCountGest == 0) {
			sprintf( szhSql,"INSERT INTO CO_GESTION ( "
						       " COD_CLIENTE , "
						       " COD_CUENTA  , "
						       " COD_TIPIDENT, "
						       " NUM_IDENT   , "
						       " COD_GESTION , "
						       " FEC_GESTION , "
						       " OBS_GESTION , "
						       " NOM_USUARIO "
						       " ) VALUES ("
						       " :v1, :v2, :v3, :v4, :v5, SYSDATE, :v6, USER ) ");

			ifnTrazasLog( modulo, "[%s]\n", LOG05, szhSql );
	
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL PREPARE insertCoGestion FROM :szhSql; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )369;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
   sqlstm.sqhstl[0] = (unsigned long )1000;
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
				ifnTrazasLog( modulo, "(Cliente:%ld) PREPARE insertCoGestion %s.", LOG00, lhCodCliente, SQLERRM );  
				return FALSE;
			}
	
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL EXECUTE insertCoGestion USING :lhCodCliente, :lhCodCuenta, :szhCodTipIdent, :szhNumIdent, :szhCodGestionNew, :szhLetra_X; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )388;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNumIdent;
   sqlstm.sqhstl[3] = (unsigned long )21;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[4] = (unsigned long )5;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_X;
   sqlstm.sqhstl[5] = (unsigned long )2;
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


		
			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
				ifnTrazasLog( modulo, "(Cliente:%ld) EXECUTE insertCoGestion %s.", LOG00, lhCodCliente, SQLERRM );  
				return FALSE;
			}
	   }
      else
      {
			/* Si existe el cliente + codigo de gestion se actualiza fecha*/
			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL 
			UPDATE CO_GESTION SET   
			       FEC_GESTION = SYSDATE
			WHERE  COD_CLIENTE = :lhCodCliente
			AND    COD_GESTION = :szhCodGestionNew; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_GESTION  set FEC_GESTION=SYSDATE where (COD_CLIE\
NTE=:b0 and COD_GESTION=:b1)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )427;
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
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[1] = (unsigned long )5;
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


			
			if( SQLCODE != SQLOK ) 
			{
			   ifnTrazasLog( modulo, "(Cliente:%ld) Actualizando CO_GESTION %s.", LOG00, lhCodCliente, SQLERRM );  
			   return FALSE;
			}
      }  /* if iCountGest = 0 */
	}
	else /* si hay que dar alta o baja definitiva actualizamos */
	{
		if( strcmp( szhCodGestionNew, "X" ) != 0 )	/* si hay que actualizar algo realmente */
		{
			sprintf( szhObsGestion, "%s %s", strcmp( szhCodGestionNew, szhCodAlta ) == 0 ? "SE ENVIO A" : "SE DESASIGNO DE", szhCodEntidad );			
			
			sprintf( szhSql, "UPDATE %s SET             "
			                 "       COD_GESTION = :v1, "
							 "       COD_CUENTA  = :v2, "
							 "       OBS_GESTION = :v3, "
                          	 "       FEC_GESTION = SYSDATE "
							 "WHERE  COD_CLIENTE = :v4 "
							 "AND    COD_GESTION = :v5",!strcmp( szhSituacion, "C" ) ? "CO_GESTION" : "CO_GESTION");

			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL PREPARE updateCoGestion FROM :szhSql; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )450;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
   sqlstm.sqhstl[0] = (unsigned long )1000;
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

	

			ifnTrazasLog( modulo, "[%s]\n", LOG05, szhSql );

			if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
				ifnTrazasLog( modulo, "(Cliente:%ld) PREPARE updateCodGestion %s.", LOG00, lhCodCliente, SQLERRM );  
				return FALSE;
			}

			sqlca.sqlcode=0; /* XO-200508280498 rvc */
			/* EXEC SQL EXECUTE updateCoGestion USING :szhCodGestionNew, :lhCodCuenta, :szhObsGestion, :lhCodCliente, :szhCodGestionAct; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )469;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodGestionNew;
   sqlstm.sqhstl[0] = (unsigned long )5;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuenta;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhObsGestion;
   sqlstm.sqhstl[2] = (unsigned long )51;
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
   sqlstm.sqhstv[4] = (unsigned char  *)szhCodGestionAct;
   sqlstm.sqhstl[4] = (unsigned long )5;
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
				ifnTrazasLog( modulo, "(Cliente:%ld) EXECUTE updateCodGestion %s.", LOG00, lhCodCliente, SQLERRM );  
				return FALSE;
			}
		} /* if( strcmp( szhCodGestionNew, "X" ) != 0 ) */
	} /* if( bInsert ) */		

	return TRUE;
} /* BOOL bfnActualizaCoGestionCliente( long lCodCliente, char *szRutina ) */


/* ============================================================================= 
 Funcion que Actualiza la co_gestion para los clientes de un rut dado
 sea Dicom o cobranza externa
 ============================================================================= */
BOOL bfnActualizaCoGestionRut( char *szNumIdent, char *szCodTipIdent, char *szCodMov, char *szCodEntidad, long lSecProceso )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char	szhNumIdent[iLENNUMIDENT]; 
	char	szhCodTipIdent[3];
	char	szhCodGestion[3];
	char	szCodMovimiento[6];
	char	szhCodEntidad[6];		
	long	lhCodCliente[500];
	long	lhCodCuenta[500];
	char	szhSql[1000];
/* EXEC SQL END DECLARE SECTION; */ 


char	modulo[] = "bfnActualizaCoGestionRut";
char	szRutina[] = "P";
int	iError = 0, iTotClientes = 0, i;

	memset( szhNumIdent, '\0', sizeof( szhNumIdent ) );
	memset( szhCodTipIdent, '\0', sizeof( szhCodTipIdent ) );
	memset( szCodMovimiento, '\0', sizeof( szCodMovimiento ) );
	memset( szhCodEntidad, '\0', sizeof( szhCodEntidad ) );

	strcpy( szhNumIdent, szNumIdent );
	strcpy( szhCodTipIdent, szCodTipIdent );
	strcpy( szCodMovimiento, szCodMov );
	strcpy( szhCodEntidad, szCodEntidad );

	rtrim( szhNumIdent );
	rtrim( szhCodTipIdent );
	rtrim( szCodMovimiento );
	rtrim( szhCodEntidad );

	ifnTrazasLog( modulo, "Entrada %s.\n"
						  "\t\t   szhNumIdent     => [%s],\n"
						  "\t\t   szhCodTipIdent  => [%s],\n"
						  "\t\t   szCodMovimiento => [%s],\n"
						  "\t\t   szhCodEntidad   => [%s],\n",
						  	LOG05,
						  	modulo,
							szhNumIdent,
							szhCodTipIdent,
							szCodMovimiento,
							szhCodEntidad );

	if( strcmp( szhCodEntidad, "DICOM" ) == 0 ) /* si es para DICOM */
	{
		sprintf( szhSql," SELECT	UNIQUE COD_CLIENTE, 	"
						    " 			COD_CUENTA FROM  	( 	" 
						    " SELECT UNIQUE COD_CLIENTE	"
						    " 		 COD_CUENTA				"
						    " FROM   CO_DICOMDOC			"
						    " WHERE  NUM_IDENT   = :v1	"
						    " AND	 COD_TIPIDENT= :v2	"
						    " AND    NUM_PROCESO = :v3	"
						    " UNION			  					"
						    " SELECT UNIQUE COD_CLIENTE	"
						    " 		 COD_CUENTA				"
						    " FROM   CO_HDICOMDOC			"
						    " WHERE  NUM_IDENT   = :v4	"
						    " AND	 COD_TIPIDENT= :v5	"
						    " AND    NUM_PROCESO = :v5  )");
	}					 
	else /* si es Cobranza Interna */
	{
		sprintf( szhSql,"SELECT COD_CLIENTE,\n"
						    "       COD_CUENTA  \n"
						    "FROM   GE_CLIENTES \n"
						    "WHERE  COD_TIPIDENT = :v1 \n"
						    "AND    NUM_IDENT    = :v2 ");
	}				 

	ifnTrazasLog( modulo, "Query (%s).", LOG05, szhSql );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL PREPARE SqlClientes FROM :szhSql; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )504;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhSql;
 sqlstm.sqhstl[0] = (unsigned long )1000;
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


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "(szhNumIdent:%s) PREPARE curClientes %s.", LOG00, szhNumIdent, SQLERRM );
		return FALSE;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL DECLARE curClientes CURSOR FOR SqlClientes; */ 

	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
		ifnTrazasLog( modulo, "(szhNumIdent:%s) DECLARE curClientes %s.", LOG00, szhNumIdent, SQLERRM );
		return FALSE;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	if( strcmp( szhCodEntidad, "DICOM" ) == 0 ) /* si es para DICOM */
		/* EXEC SQL OPEN curClientes USING :szhNumIdent, :szhCodTipIdent, :lSecProceso, :szhNumIdent, :szhCodTipIdent, :lSecProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )523;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lSecProceso;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhNumIdent;
  sqlstm.sqhstl[3] = (unsigned long )21;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipIdent;
  sqlstm.sqhstl[4] = (unsigned long )3;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lSecProceso;
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


	else
		/* EXEC SQL OPEN curClientes USING :szhCodTipIdent , :szhNumIdent; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )562;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipIdent;
  sqlstm.sqhstl[0] = (unsigned long )3;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhNumIdent;
  sqlstm.sqhstl[1] = (unsigned long )21;
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


				
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
		ifnTrazasLog( modulo, "(szhNumIdent:%s) OPEN curClientes %s.", LOG00, szhNumIdent, SQLERRM );
		return FALSE;
	}

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL FETCH curClientes
	INTO	:lhCodCliente,
			:lhCodCuenta; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )500;
 sqlstm.offset = (unsigned int  )585;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )sizeof(long);
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqharc[0] = (unsigned long  *)0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)lhCodCuenta;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )sizeof(long);
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
}



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "(szhNumIdent:%s) FETCH CO_MOROSOS %s.", LOG00, szhNumIdent, SQLERRM );
		return FALSE;
	}

	iTotClientes = SQLROWS;

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL CLOSE curClientes; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )608;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "(szhNumIdent:%s) CLOSE CO_MOROSOS %s.", LOG00, szhNumIdent, SQLERRM );
		return FALSE;
	}

	for( i = 0; i < iTotClientes; i++ )
	{
		rtrim( szhNumIdent );
		rtrim( szhCodTipIdent );
		rtrim( szhCodEntidad );
		rtrim( szRutina );
		rtrim( szCodMovimiento );

		if( !bfnActualizaCoGestionCliente( lhCodCliente[i], lhCodCuenta[i], szhNumIdent, 
										   szhCodTipIdent, szhCodEntidad, szRutina, szCodMovimiento ) )
		{
			iError = 1;
			break;
		}
	} /* for( i = 0; i < iTotClientes; i++ ) */
		
	if( iError == 1 )
		return FALSE;
			
	return TRUE;	
} /* BOOL bfnActualizaCoGestionCobExtRut( char *szNumIdent, char *szCodTipIdent, char *szCodMov ) */





/* ============================================================================= */
/* Obtiene el saldo en la cartera de un Cliente dado                             */
/* ============================================================================= */
BOOL bfnGetSaldoCliente (long lCliente, double *pdSaldoVenc, double *pdSaldoNoVenc, char *szFecVencimiento  )
{
char modulo[]="dfnGetSaldoCliente";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente = lCliente;
	int    ihIndFacturado = 1; 
	double dhSaldoNoVenc = 0.0;
	double dhSaldoVenc = 0.0;
	char   szhFecVencimiento[9] = ""; /* EXEC SQL VAR szhFecVencimiento IS STRING(9); */ 
 
	short  shFecVenc;
	char   szhFormatoFecha   [9]       ; /* EXEC SQL VAR szhFormatoFecha   IS STRING(9); */ 
 
	char   szhTablaCoCartera[11]       ; /* EXEC SQL VAR szhTablaCoCartera IS STRING(11); */ 
 
	char   szhColumnaTipDoc [13]       ; /* EXEC SQL VAR szhColumnaTipDoc  IS STRING(13); */ 
 
	int    iNumCero;
	int    iNumDos;
/* EXEC SQL END DECLARE SECTION; */ 
    

	strcpy(szhFormatoFecha  , "YYYYMMDD");
	strcpy(szhTablaCoCartera, "CO_CARTERA");
	strcpy(szhColumnaTipDoc , "COD_TIPDOCUM");
	iNumCero = 0;
	iNumDos  = 2;

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT TO_CHAR(MIN(FEC_VENCIMIE),:szhFormatoFecha)
	INTO  :szhFecVencimiento:shFecVenc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND   IND_FACTURADO = :ihIndFacturado
	AND   FEC_VENCIMIE < TRUNC(SYSDATE)
	AND   COD_CONCEPTO != :iNumDos 
	AND   COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
									    FROM	  CO_CODIGOS
									    WHERE  NOM_TABLA   = :szhTablaCoCartera
									    AND	  NOM_COLUMNA = :szhColumnaTipDoc ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TO_CHAR(min(FEC_VENCIMIE),:b0) into :b1:b2  from CO_C\
ARTERA where ((((COD_CLIENTE=:b3 and IND_FACTURADO=:b4) and FEC_VENCIMIE<TRUNC\
(SYSDATE)) and COD_CONCEPTO<>:b5) and COD_TIPDOCUM not  in (select TO_NUMBER(C\
OD_VALOR)  from CO_CODIGOS where (NOM_TABLA=:b6 and NOM_COLUMNA=:b7)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )623;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimiento;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)&shFecVenc;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihIndFacturado;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&iNumDos;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[5] = (unsigned long )11;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhColumnaTipDoc;
 sqlstm.sqhstl[6] = (unsigned long )13;
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



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
	    ifnTrazasLog(modulo,"SELECT FROM CO_CARTERA(1) (Cliente:%ld) : %s ",LOG00,lhCodCliente,SQLERRM);  
	    return FALSE;
	}
       
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:iNumCero)
	INTO :dhSaldoVenc
	FROM CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND IND_FACTURADO = :ihIndFacturado
	AND FEC_VENCIMIE < TRUNC(SYSDATE)
	AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA   = :szhTablaCoCartera
									AND		NOM_COLUMNA = :szhColumnaTipDoc	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) into :b1  \
from CO_CARTERA where (((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCIM\
IE<TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from\
 CO_CODIGOS where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )666;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iNumCero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihIndFacturado;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhColumnaTipDoc;
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

 /* jlr_22.01.01 */

	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	{
	    ifnTrazasLog(modulo,"SELECT FROM CO_CARTERA(1) (Cliente:%ld) : %s ",LOG00,lhCodCliente,SQLERRM);  
	    return FALSE;
	}
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 
	SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:iNumCero)
	INTO :dhSaldoNoVenc
	FROM CO_CARTERA
	WHERE COD_CLIENTE   = :lhCodCliente 
	AND IND_FACTURADO = :ihIndFacturado
	AND FEC_VENCIMIE >= TRUNC(SYSDATE)
	AND COD_TIPDOCUM NOT IN (	SELECT	TO_NUMBER(COD_VALOR)
									FROM	CO_CODIGOS
									WHERE	NOM_TABLA   = :szhTablaCoCartera
									AND		NOM_COLUMNA = :szhColumnaTipDoc	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) into :b1  \
from CO_CARTERA where (((COD_CLIENTE=:b2 and IND_FACTURADO=:b3) and FEC_VENCIM\
IE>=TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  fro\
m CO_CODIGOS where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )705;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iNumCero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoNoVenc;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihIndFacturado;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTablaCoCartera;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhColumnaTipDoc;
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

 /* jlr_22.01.01 */

    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        ifnTrazasLog(modulo,"SELECT FROM CO_CARTERA(2) (Cliente:%ld) : %s ",LOG00,lhCodCliente,SQLERRM);  
        return FALSE;
    }
    else
    {
        *pdSaldoNoVenc = dhSaldoNoVenc;
        *pdSaldoVenc = dhSaldoVenc;
		  strcpy(szFecVencimiento,szhFecVencimiento);
        return TRUE; 
    }
}


/*==================================================================================================*/
/* Funcion que Obtiene el Saldo en la Cta. Cte. de los Clientes que asocia ese rut                  */
/*==================================================================================================*/
BOOL bfnGetSaldoPorRut( char *szNumIdent, char *szCodTipIdent,double *dMtoSaldoRut )
{
char modulo[]="ifnGetSaldoPorRut";
int iError=0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCodCliente      = 0  ;
	double dhMtoSaldo        = 0.0 ;  
	double dhMtoSaldoParcial = 0.0 ;
	double dhMtoAux          = 0.0 ;
	char   szhFecAux      [9]=""             ; /* EXEC SQL VAR szhFecAux IS STRING(9); */ 

	char   szhNumIdent    [iLENNUMIDENT] ="" ; /* EXEC SQL VAR szhNumIdent IS STRING(iLENNUMIDENT); */ 

	char   szhCodTipIdent [3]=""             ; /* EXEC SQL VAR szhCodTipIdent IS STRING(3); */ 

/* EXEC SQL END DECLARE SECTION; */ 


   strcpy(szhNumIdent,szNumIdent);
	strcpy(szhCodTipIdent,szCodTipIdent);
    
    sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	DECLARE curRuts CURSOR FOR
	SELECT COD_CLIENTE
	FROM	 GE_CLIENTES
	WHERE	 COD_TIPIDENT = :szhCodTipIdent
	AND	 NUM_IDENT = :szhNumIdent; */ 

    
   if (SQLCODE)  {   
   	ifnTrazasLog(modulo,"Declare curRuts : %s ",LOG00,SQLERRM);  
      return FALSE; 
   }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL 
   OPEN curRuts ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0015;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )744;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodTipIdent;
   sqlstm.sqhstl[0] = (unsigned long )3;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNumIdent;
   sqlstm.sqhstl[1] = (unsigned long )21;
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


   if (SQLCODE)  {   
      ifnTrazasLog(modulo,"Open curRuts : %s ",LOG00,SQLERRM);  
      return FALSE;   
   }

   dhMtoSaldo=0.0;
   for (;;)  /* Ciclo infinito */
   {
   		sqlca.sqlcode=0; /* XO-200508280498 rvc */
      /* EXEC SQL 
      FETCH curRuts   INTO :lhCodCliente; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )767;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
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


       
      if (SQLCODE == SQLNOTFOUND)  {   
          iError = 0; 
          ifnTrazasLog(modulo,"Fetch curRuts : Fin Datos del Cursor ",LOG05);  
          break;  
      }  
      else if (SQLCODE)
      {   
          iError = 1;
          ifnTrazasLog(modulo,"Fetch curRuts : %s ",LOG00,SQLERRM);  
          break;  
      } 

      dhMtoSaldoParcial = 0.0;
      
      /*-Obtiene el Saldo del Cliente ---*/
      if ( !bfnGetSaldoCliente (lhCodCliente, &dhMtoSaldoParcial, &dhMtoAux, szhFecAux ) )  {
    	   iError = 1;
    	   break;	
      }
	   else
	   {
	      dhMtoSaldo += dhMtoSaldoParcial;
	   }
   }

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
   /* EXEC SQL
   CLOSE curRuts ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )786;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE) 	{   
	   iError = 1;
      ifnTrazasLog(modulo,"Close curRuts : %s ",LOG00,SQLERRM);  
   }
    
   if (iError == 1) {   
      return FALSE;   
   }
   else  
   {   
   	*dMtoSaldoRut=dhMtoSaldo;
      return TRUE;    
   }
}


/*==================================================================================================*/
/* Funcion que Obtiene el saldo vencido de un cliente.                  									 */
/*==================================================================================================*/
BOOL bfnGetSaldoVencido( long lCodCliente, double *pdSaldoVenc )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long   lhCodCliente;
	double dhSaldoVenc  = 0.0;
	char   szhCARTERA    [11];
	char   szhTIPDOCUM   [13];
	int    ihValor_uno  = 1  ;
/* EXEC SQL END DECLARE SECTION; */ 
    
char modulo[] = "bfnGetSaldoVencido";

 	ifnTrazasLog( modulo, "Ingreso modulo : [%s].", LOG05, modulo );
	lhCodCliente = lCodCliente;
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL 	
	SELECT NVL( SUM( IMPORTE_DEBE - IMPORTE_HABER ), 0 )
	INTO  :dhSaldoVenc
	FROM  CO_CARTERA
	WHERE COD_CLIENTE = :lhCodCliente 
	AND   IND_FACTURADO = :ihValor_uno
	AND   FEC_VENCIMIE < TRUNC( SYSDATE )
	AND   COD_TIPDOCUM NOT IN (SELECT	TO_NUMBER(COD_VALOR)
								      FROM	CO_CODIGOS
								      WHERE	NOM_TABLA = :szhCARTERA
								      AND NOM_COLUMNA = :szhTIPDOCUM); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),0) into :b0  fr\
om CO_CARTERA where (((COD_CLIENTE=:b1 and IND_FACTURADO=:b2) and FEC_VENCIMIE\
<TRUNC(SYSDATE)) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from C\
O_CODIGOS where (NOM_TABLA=:b3 and NOM_COLUMNA=:b4)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )801;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhSaldoVenc;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[3] = (unsigned long )11;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[4] = (unsigned long )13;
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



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
        ifnTrazasLog( modulo, "Cliente => [%ld] Obteniendo Saldo Vencido => [%s].", LOG00, lhCodCliente, SQLERRM );  
        return FALSE;
   }

	*pdSaldoVenc = dhSaldoVenc;
   return TRUE; 
} /* bfnGetSaldoVencido */


/*==================================================================================================*/
/*==================================================================================================*/
double fnCnvDouble( double d, int uso )
{
	char szTemp[BUFSIZ] = "";
	sprintf( szTemp, "%.*f", pstParamGener.iNumDecimal, d + 0.0000001 );
	return( double )atof( szTemp );
}


/*==================================================================================================*/
/* Funcion que Busca el codigo de Activacion en Central para la actuacion de abonado                */
/*==================================================================================================*/
int ifnGetActuacionCentralCelular( char *szActAbo, int iCodProducto, char *szCodModulo, char *szCodTecnologia )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int ihCodActCen   = 0;
	int ihCodProducto = 0;
	char szhActAbo    [3];	/* EXEC SQL VAR szhActAbo IS STRING(3); */ 

	char szhCodModulo [3];  /* EXEC SQL VAR szhCodModulo IS STRING(3); */ 

	char szhCodTecnologia[iLENCODTECNO];	/* EXEC SQL VAR szhCodTecnologia IS STRING(iLENCODTECNO); */ 

/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "ifnGetActuacionCentralCelular";

 	ifnTrazasLog( modulo, "Ingreso modulo => [%s].", LOG05, modulo );
 	ifnTrazasLog( modulo, 	"Parametros entrada.\n"
							"\t\t   szhActAbo        => [%s],\n"
							"\t\t   ihCodProducto    => [%d],\n"
							"\t\t   szhCodModulo     => [%s],\n"
							"\t\t   szhCodTecnologia => [%s],\n",
							LOG05,
							szActAbo,
							iCodProducto,
							szCodModulo,
							szCodTecnologia );

	memset( szhActAbo, '\0', sizeof( szhActAbo ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	
	strcpy( szhActAbo, szActAbo );
	strcpy( szhCodModulo, szCodModulo );
	strcpy( szhCodTecnologia, szCodTecnologia );
	ihCodProducto = iCodProducto;
	
	rtrim( szhActAbo );
	rtrim( szhCodModulo );
	rtrim( szhCodTecnologia );
	
	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT COD_ACTCEN
	INTO  :ihCodActCen
	FROM  GA_ACTABO
	WHERE COD_ACTABO = :szhActAbo
	AND   COD_PRODUCTO = :ihCodProducto
	AND   COD_MODULO = :szhCodModulo
	AND   COD_TECNOLOGIA = :szhCodTecnologia; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ACTCEN into :b0  from GA_ACTABO where (((COD_ACTA\
BO=:b1 and COD_PRODUCTO=:b2) and COD_MODULO=:b3) and COD_TECNOLOGIA=:b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )836;
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
 sqlstm.sqhstl[4] = (unsigned long )9;
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



	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {  
		ifnTrazasLog( modulo, "ACTABO => [%s], TECNOLOGIA => [%s], Recuperando Actuacion Central => [%s].", LOG00, szhActAbo, szhCodTecnologia, SQLERRM );
		return -1;
	} 

	if( SQLCODE == SQLNOTFOUND )	 {  
		ifnTrazasLog( modulo, "ACTABO => [%s], TECNOLOGIA => [%s], No se encuentra definida en Actuaciones Abonado.", LOG01, szhActAbo, szhCodTecnologia );
		return -1;
	} 

	ifnTrazasLog( modulo, "ACTABO => [%s], TECNOLOGIA => [%s], Actuacion Central => [%d].", LOG05, szhActAbo, szhCodTecnologia, ihCodActCen );
	return ihCodActCen;
} /* int ifnGetActuacionCentralCelular( char *szActAbo ) */


		
/*==================================================================================================*/
/* Funcion que Obtiene el valor de un parametro.       									 						 */
/*==================================================================================================*/
char *szfnRecuperaGedParametro( char *szNomParametro, char *szCodModulo )
{	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhValParametro[21];
	char szhNomParametro[21];
	char szhCodModulo[iLENCODMODULO];
	int  ihValor_uno = 1;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "szfnRecuperaGedParametro";
	
 	memset( szhValParametro, '\0', sizeof( szhValParametro ) );
	memset( szhNomParametro, '\0', sizeof( szhNomParametro ) );
	memset( szhCodModulo, '\0', sizeof( szhCodModulo ) );
	
	strcpy( szhNomParametro, szNomParametro );
	strcpy( szhCodModulo, szCodModulo );
	rtrim( szhCodModulo );
	rtrim( szhNomParametro );

	sqlca.sqlcode=0; /* XO-200508280498 rvc */
	/* EXEC SQL
	SELECT VAL_PARAMETRO
	INTO  :szhValParametro
	FROM  GED_PARAMETROS
	WHERE NOM_PARAMETRO= :szhNomParametro
	AND   COD_MODULO   = :szhCodModulo
	AND   COD_PRODUCTO = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where ((N\
OM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )871;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhValParametro;
 sqlstm.sqhstl[0] = (unsigned long )21;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNomParametro;
 sqlstm.sqhstl[1] = (unsigned long )21;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodModulo;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_uno;
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


	
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 
	{  
		ifnTrazasLog( modulo, "Error al recuperar Valor de Parametro ==> [%s][%s].", LOG00, szhNomParametro, SQLERRM );
		return "ERROR";
	}  

	if( SQLCODE == SQLNOTFOUND ) 
	{  
		ifnTrazasLog( modulo, "Parametro no encontrado para ==> [%s].", LOG00, szhNomParametro );
		return "ERROR";
	}  

	rtrim( szhValParametro );
	return szhValParametro;

} /* szfnRecuperaGedParametro */

