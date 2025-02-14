
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
static const struct sqlcxp sqlfpn =
{
    22,
    "./pc/New_PHistorico.pc"
};


static unsigned int sqlctx = 221629283;


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
"select FACT.NUM_PROCESO  from FA_INTERFACT FACT ,FA_FACTDOCU_NOCICLO DOCU wh\
ere ((((((FACT.COD_MODGENER=:b0 and FACT.COD_ESTADOC=:b1) and FACT.COD_ESTPROC\
=:b2) and FACT.COD_APLIC=:b3) and FACT.FEC_PASOCOBRO<(SYSDATE-(:b4/24))) and D\
OCU.NUM_PROCESO=FACT.NUM_PROCESO) and DOCU.IND_LIBROIVA>:b5)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,118,0,4,97,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
36,0,0,2,299,0,4,130,0,0,4,3,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,
67,0,0,3,303,0,9,436,0,0,6,6,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,
106,0,0,3,0,0,13,448,0,0,1,0,0,1,0,2,3,0,0,
125,0,0,3,0,0,15,564,0,0,0,0,0,1,0,
140,0,0,4,471,0,4,635,0,0,23,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,1,3,0,0,1,3,0,0,
247,0,0,5,0,0,17,797,0,0,1,1,0,1,0,1,97,0,0,
266,0,0,5,0,0,21,812,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
289,0,0,6,0,0,17,829,0,0,1,1,0,1,0,1,97,0,0,
308,0,0,6,0,0,21,844,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
331,0,0,7,0,0,17,920,0,0,1,1,0,1,0,1,97,0,0,
350,0,0,7,0,0,21,935,0,0,1,1,0,1,0,1,3,0,0,
369,0,0,8,0,0,17,1142,0,0,1,1,0,1,0,1,97,0,0,
388,0,0,8,0,0,21,1154,0,0,1,1,0,1,0,1,3,0,0,
407,0,0,9,0,0,17,1167,0,0,1,1,0,1,0,1,97,0,0,
426,0,0,9,0,0,21,1179,0,0,1,1,0,1,0,1,3,0,0,
445,0,0,10,0,0,17,1306,0,0,1,1,0,1,0,1,97,0,0,
464,0,0,10,0,0,21,1318,0,0,1,1,0,1,0,1,3,0,0,
483,0,0,11,0,0,17,1331,0,0,1,1,0,1,0,1,97,0,0,
502,0,0,11,0,0,21,1343,0,0,1,1,0,1,0,1,3,0,0,
521,0,0,12,0,0,17,1456,0,0,1,1,0,1,0,1,97,0,0,
540,0,0,12,0,0,21,1468,0,0,1,1,0,1,0,1,3,0,0,
559,0,0,13,0,0,17,1481,0,0,1,1,0,1,0,1,97,0,0,
578,0,0,13,0,0,21,1493,0,0,1,1,0,1,0,1,3,0,0,
597,0,0,7,0,0,17,1597,0,0,1,1,0,1,0,1,97,0,0,
616,0,0,7,0,0,21,1609,0,0,1,1,0,1,0,1,3,0,0,
635,0,0,14,0,0,17,1620,0,0,1,1,0,1,0,1,97,0,0,
654,0,0,14,0,0,21,1631,0,0,1,1,0,1,0,1,3,0,0,
673,0,0,15,0,0,17,1642,0,0,1,1,0,1,0,1,97,0,0,
692,0,0,15,0,0,21,1654,0,0,1,1,0,1,0,1,3,0,0,
711,0,0,15,0,0,17,1777,0,0,1,1,0,1,0,1,97,0,0,
730,0,0,15,0,0,21,1789,0,0,1,1,0,1,0,1,3,0,0,
749,0,0,16,101,0,5,1843,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
776,0,0,17,226,0,4,1985,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,5,0,0,
815,0,0,18,0,0,17,2268,0,0,1,1,0,1,0,1,97,0,0,
834,0,0,18,0,0,21,2279,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,4,0,0,
861,0,0,19,0,0,17,2307,0,0,1,1,0,1,0,1,97,0,0,
880,0,0,19,0,0,21,2319,0,0,3,3,0,1,0,1,4,0,0,1,3,0,0,1,3,0,0,
907,0,0,20,75,0,4,2347,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : New_PHistorico.pc                                        * */
/* *                                                                     * */
/* *  Autor : Roy Barrera R.                                             * */
/* *********************************************************************** */
/**************************************************************************** */
/* ************************************************************************** */
/* *	Incorporacion del campo COD_APLIC en las llamadas 		    * */
/* *			a las sgtes. funciones:				    * */
/* *		bfnGetInterFact		bfnGetIntQueueProc		    * */
/* *		bfnUpdInterFact 	bfnCambiaEstCola		    * */
/* *	Patricio Gonzalez G.	31-01-2002			            * */
/* ************************************************************************** */
/******************************************************************************/

#include "deftypes.h"
#include "New_Interfact.h"
#include "New_PHistorico.h"

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


long pid;
char	szModulo[20];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char 	szAplica_Cod_Autorizacion[2];
/* EXEC SQL END DECLARE SECTION; */ 


/* ********************************************************************************************* */
/* modulo principal */
/* ********************************************************************************************* */
int main(int argc,char *argv[])
{
	char modulo[]="main";

	 int sts=0;
	 int iLogLevel=3;
	 int iModExec=0;
	char szOraAccount[32]="";
	char szOraPasswd[32]="";
	char szCodModGener[4]="";
	char status[16]="";


	pid=getpid();
	fprintf( stdout, "\n\t***  New_PHistorico  ***\n"
	                   "\t%s\n\t** pid : [ %8ld ] **\n"
	                 "\t************************\n"
	                 , cfnGetTime(1)
	                 , pid );
    fprintf(stdout,"\n\t ** Version de compilacion: ["__DATE__"] ["__TIME__"]\n");

	
	sts = ifnValidaParametros(argc,argv,szOraAccount, szOraPasswd, &iLogLevel, szCodModGener, &iModExec);
	if ( sts != 0 ) 
	    return sts;

	fprintf(stdout,"\n\tNew_PHistorico -u[%s/%s] -l[%d] -m[%s] -[%s]\n",
				   szOraAccount,szOraPasswd,iLogLevel,szCodModGener,(iModExec==EXEC_ONLINE)?"Online":"Batch");

	sts = ifnAbreArchivosLog(iLogLevel);
	if ( sts != 0 ) 
	    return sts;

	sts = ifnPasoHistOnline(szOraAccount,szOraPasswd,szCodModGener,iModExec);
	if (sts != 0)
		strcpy(status,"Anormal");
	else
		strcpy(status,"Controlado");

	vDTrazasError(modulo,"%s[%ld] Termino %s del Paso Historico Online (%d)", LOG03, cfnGetTime(1),pid,status,sts);
	vDTrazasLog  (modulo,"%s[%ld] Termino %s del Paso Historico Online (%d)", LOG03, cfnGetTime(1),pid,status,sts);

	fprintf(stdout,"\n");
	return sts;

} /* main */

int GargaGedParametros( void )
{
	/* Modificación Proyecto Ecu-05002 Codigo de Autorización.
	  Se agrega SQL para obtener el campo para saber si aplica el codigo de autorizacion. Las variables 
del select into estan definidas en el ImpSclSt.h. Se modifica el SQL para que en este mismo se rescate el valor
de la tabla y saber si aplica el cod autirizacion (se agrega alias F para ged_parametros).
	*/

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     ihValorUno   = 1;
    char    szhCodModulo[3] = "FA";
    char    szhNomParametro[32] = "APLICA_CODAUTORIZA"; 
    /* EXEC SQL END   DECLARE SECTION; */ 
    

    strcpy (szModulo, "GargaGedParametros");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);


    /* EXEC SQL
    SELECT VAL_PARAMETRO
      INTO :szAplica_Cod_Autorizacion
      FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO = :szhNomParametro
       AND COD_MODULO   = :szhCodModulo   
       AND COD_PRODUCTO = :ihValorUno; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
((NOM_PARAMETRO=:b1 and COD_MODULO=:b2) and COD_PRODUCTO=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szAplica_Cod_Autorizacion;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNomParametro;
    sqlstm.sqhstl[1] = (unsigned long )32;
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

    

       
    if (SQLCODE != SQLOK )
    {
        vDTrazasLog(szModulo, "Error en SELECT de GED_PARAMETROS [%d]", LOG01, SQLCODE);
        return (FALSE);
    }
    return (TRUE);
}

/***************************************************************/
/*** Funcion : szfnObtieneCod_autorizacion()                 ***/
/***************************************************************/
int szfnObtieneCod_autorizacion (long lIOrdenTotal)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
 
    char    szhCodModulo[3]      = "AL";
    char    szhNomTablaFolio[32] = "AL_AUTORIZACION_FOLIO_TD";
    /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy (szModulo, "ObtieneCod_autorizacion");
    vDTrazasLog(szModulo,"\tEntrando a %s ",LOG04,szModulo);
    printf("\nEn funcion ObtieneCod_autorizacion");


    
    /* EXEC SQL 
    	SELECT A.COD_AUTORIZACION    
    	  INTO :szCod_Autorizacion
		  FROM AL_AUTORIZACION_FOLIO_TD A, 
			   GED_CODIGOS B, 
			   FA_FACTDOCU_NOCICLO C
		 WHERE A.COD_SISTEMA 	= B.COD_VALOR
           AND B.COD_MODULO     = :szhCodModulo     /o'AL'o/
           AND B.NOM_TABLA      = :szhNomTablaFolio /o'AL_AUTORIZACION_FOLIO_TD'o/
		   AND C.IND_ORDENTOTAL = :lIOrdenTotal
		   AND C.FEC_EMISION BETWEEN A.FEC_DESDE AND A.FEC_TERMINO
		   AND C.NUM_FOLIO IS NOT NULL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_AUTORIZACION into :b0  from AL_AUTORIZACION_\
FOLIO_TD A ,GED_CODIGOS B ,FA_FACTDOCU_NOCICLO C where (((((A.COD_SISTEMA=B.CO\
D_VALOR and B.COD_MODULO=:b1) and B.NOM_TABLA=:b2) and C.IND_ORDENTOTAL=:b3) a\
nd C.FEC_EMISION between A.FEC_DESDE and A.FEC_TERMINO) and C.NUM_FOLIO is  no\
t null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )36;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCod_Autorizacion;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodModulo;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhNomTablaFolio;
    sqlstm.sqhstl[2] = (unsigned long )32;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lIOrdenTotal;
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


    
    
    if (SQLCODE == SQLNOTFOUND )
    {
    	strcpy(szCod_Autorizacion, "0");
    }
    else 
    {
       if (SQLCODE != SQLOK ) 
       {
           vDTrazasLog(szModulo, "Error en SELECT de ObtieneCod_autorizacion [%d]", LOG01, SQLCODE);
           return (FALSE);
       } 
    }
    
    return (TRUE);

    
}


/* ********************************************************************************************* */
/* ifnValidaParametros () */
/* ********************************************************************************************* */
int ifnValidaParametros ( int argc, char *argv[], char *szOraAccount, char *szOraPasswd,
						  int *iLogLevel, char *szCodModGener, int *iModExec  )

{
	extern char *optarg;
	extern int optind, opterr, optopt;
	char opt[] = ":u:l:e:O:B:";
	int iOpt=0;
	char *psztmp = "";
	char szUser [64] = "";

	int  Userflag=FALSE;
	int  Logflag=FALSE;
	int  Modflag=FALSE;
	int  OnlineFlag=FALSE;
	int  BatchFlag=FALSE;

	char szAux[16]="";

	opterr=0;

	if(argc == 1)
	{
		fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
		return -1;
	}

	while ( (iOpt = getopt(argc, argv, opt) ) != EOF)
	{
		switch(iOpt)
		{
			case 'u':
				if(Userflag==FALSE)
				{
					strcpy(szUser, optarg);
					Userflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'l':
				if(Logflag==FALSE)
				{
					*iLogLevel=(atoi(optarg)<=0)?iLOGNIVEL_DEF:atoi(optarg);
					Logflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'e':
				if(Modflag==FALSE)
				{
					strcpy(szCodModGener,optarg);
					Modflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'O': /* 21-Enero-2000 */
				if(OnlineFlag==FALSE)
				{
					strcpy(szAux,optarg);
					if (strcmp(szAux,"nline")==0) { OnlineFlag=TRUE; *iModExec=EXEC_ONLINE; }
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'B': /* 21-Enero-2000 */
				if(BatchFlag==FALSE)
				{
					strcpy(szAux,optarg);
					if (strcmp(szAux,"atch")==0) { BatchFlag=TRUE;*iModExec=EXEC_BATCH; }
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case '?':
				fprintf(stdout,"\n\t<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
				return -3;

			case ':':
				fprintf(stdout,"\n\t<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
				return -4;

		}/* endswitch */

	} /* enwhile */


	if(Modflag==FALSE)
	{
		fprintf (stderr,"\n\t<< Error : falta opcion '-m' >>\n%s\n",szUsage);
		return -1;
	}

	if(Logflag==FALSE)
	{
		*iLogLevel=iLOGNIVEL_DEF;
		/*fprintf (stderr,"\n\t<< Error : falta opcion '-l' >>\n%s\n",szUsage);
		return -1;*/
	}

	if(Userflag==TRUE)
	{
		if ( (psztmp=(char *)strstr(szUser,"/") )==(char *)NULL )
		{
			fprintf (stderr,"\n\t<< Error : usuario no valido. Requiere \"/\" >>\n%s\n",szUsage);
			return -5;
		}
		else
		{
			strncpy (szOraAccount,szUser,psztmp-szUser);
			strcpy  (szOraPasswd, psztmp+1);
		}
	}

	if ((BatchFlag==FALSE) && (OnlineFlag==FALSE))
	{
		fprintf (stderr,"\n\t<< Error : Falta modo de ejecucion '-Online' o '-Batch' >>\n%s\n",szUsage);
		return -7;
	}
	else if ((BatchFlag==TRUE) && (OnlineFlag==TRUE))
	{
		fprintf (stderr,"\n\t<< Error : '-Online' y '-Batch' no pueden ir juntos >>\n%s\n",szUsage);
		return -7;
	}

	return 0; /* Validacion ok */

} /* ifnValidaParamatros */


/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog(int iLogLevel)
{
	char modulo[]="ifnAbreArchivosLog";

	char *pathDir;
	char szArchivo[32]="";
	char szPath[128]="";
	char szComando[128]="";

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"New_PHistorico_%s",cfnGetTime(2)); /*YYYYMMDD*/
	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/New_PHistorico/%s",pathDir,cfnGetTime(2)); /* '....log/New_PHistorico/YYYYMMDD/' */
	free(pathDir);

	fprintf(stdout, "\n\tCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\n\tCrea Archivo Log/Err : %s\n\n", szArchivo);

	stStatus.LogNivel = iLogLevel;

	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;    }

	/* vDTrazasError(modulo, "\n%s[%ld] << Abre Archivo de Errores >>", LOG03, cfnGetTime(1),pid); */

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;    }

	vDTrazasLog(modulo, "\n%s[%ld] << Abre Archivo de Log >>", LOG03, cfnGetTime(1),pid);
	
	return 0;
}


/* ***************************************************************************** */
/* ifnPasoHistOnline()*/
/* ***************************************************************************** */
int ifnPasoHistOnline(char *szAccount, char *szPasswd, char *szCodModGener, int iModExec)
{
	char modulo[]="PasoHistOnline";

	BOOL bOptRetPasoHist=FALSE;
	 int iStatusFin=iESTAQUEUE_WAIT;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhNumProceso=0;
		 int ihOk=0;
		 int ihCodEstaDocEnt=0;
		 int ihCodEstaDocSal=0;
		char szhCodModGener[4];
		 int ihCodProceso;
	     int ihNumDeltaHoras;
	     int ihValorCero = 0;
	     char szhCodAplic[4]="FAC";
	/* EXEC SQL END DECLARE SECTION; */ 


	ihOk = iESTAPROC_TERMINADO_OK ;

	strcpy(szhCodModGener,szCodModGener);

	ihCodProceso = iPROCESO_INT_PASOHISTORICO; 	/* 700 */

	if (!fnOraConnect(szAccount,szPasswd))
	{	
		vDTrazasError   (modulo, "%s No Hay Conexion a la Base de Datos", LOG01,cfnGetTime(3));
		vDTrazasLog     (modulo, "%s No Hay Conexion a la Base de Datos", LOG01,cfnGetTime(3));
		return -10;	
	}

	vDTrazasLog(modulo,"%s[%ld] Conectado a la Base de Datos", LOG04, cfnGetTime(1),pid);
    /*********************************************************************************/
    /* Fa_IntQueueProc								     */
    /*********************************************************************************/
    vDTrazasLog(modulo,"%s[%ld] Obtencion datos cola  ", LOG04, cfnGetTime(1),pid);
    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
    strcpy( stIntQueueProc.szCodModGener , szCodModGener);
            stIntQueueProc.lCodProceso   = iPROCESO_INT_PASOHISTORICO;
    strcpy(stIntQueueProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
            
    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
		return -13;
	}
    ihNumDeltaHoras = stIntQueueProc.iNumDeltaHoras ;
    ihCodEstaDocEnt	= stIntQueueProc.iCodEstaDocEnt ;
    ihCodEstaDocSal	= stIntQueueProc.iCodEstaDocSal ;
    /*********************************************************************************/

	vDTrazasLog(modulo,"%s[%ld] Preparando Cursor sobre FA_INTERFACT ", LOG04, cfnGetTime(1),pid);

	/* EXEC SQL DECLARE Cur_FaInterFact CURSOR FOR
			 SELECT FACT.NUM_PROCESO
			   FROM FA_INTERFACT FACT , FA_FACTDOCU_NOCICLO DOCU
			  WHERE FACT.COD_MODGENER = :szhCodModGener    	/o 'xxx' o/
			    AND FACT.COD_ESTADOC  = :ihCodEstaDocEnt   	/o 600 : Pasada a Cobros o/
			    AND FACT.COD_ESTPROC  = :ihOk              	/o 3 :terminada Ok o/
			    AND FACT.COD_APLIC    = :szhCodAplic        /o'FAC'o/	/o Incorporado por PGonzaleg 31-01-2002 o/
			    AND FACT.FEC_PASOCOBRO < (SYSDATE - (:ihNumDeltaHoras / 24)) /o nuevo delta de tiempo o/
                AND DOCU.NUM_PROCESO  = FACT.NUM_PROCESO
			    AND DOCU.IND_LIBROIVA > :ihValorCero ; */ 


	if (SQLCODE != SQLOK)
	{	vDTrazasError(modulo,"Al declarar Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog (modulo,"Al declarar Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -14;	}

	/* EXEC SQL OPEN Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0003;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )67;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodModGener;
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodEstaDocEnt;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihOk;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodAplic;
 sqlstm.sqhstl[3] = (unsigned long )4;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihNumDeltaHoras;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValorCero;
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



	if (SQLCODE != SQLOK)
	{	vDTrazasError(modulo,"Al Abrir Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"Al Abrir Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -15;	}

	vDTrazasLog ( modulo,"%s[%ld] Recorriendo Cursor y formando Comandos "
	            , LOG04 , cfnGetTime(1),pid);

	for (;;)
	{
		/* EXEC SQL FETCH Cur_FaInterFact
			      INTO :lhNumProceso ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )106;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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



		if (sqlca.sqlcode == SQLNOTFOUND)
		{
			vDTrazasLog(modulo,"%s[%ld] Fin del Cursor",LOG04,cfnGetTime(1),pid);
			iStatusFin=iESTAQUEUE_WAIT;
			break;
		}
		else if (SQLCODE != SQLOK)
		{
			vDTrazasError(modulo,"En el Fetch del Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
			iStatusFin=iESTAQUEUE_ERROR;
			break;
		}
    	vDTrazasLog(modulo,"\t\tNro. Proceso :[%ld] ", LOG04, lhNumProceso);
    
        memset(&stInterFact,0,sizeof(INTERFACT));
        stInterFact.lNumProceso     = lhNumProceso;
        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
        
        if (!bfnGetInterFact(&stInterFact))
        {
            vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            fnGrabaAnomalia(lhNumProceso, 0,"New_PHistOnline", strcat(cfnGetTime(1), "=> Error obtencion de FA_INTERFACT" ));
            return FALSE;
        }

        stInterFact.iCodEstaDoc     =   ihCodEstaDocSal;
        stInterFact.iCodEstaProc    =   iESTAPROC_PROCESANDO;
        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
        
        if (!bfnUpdInterFact(stInterFact))
		{
			vDTrazasLog  ( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
			vDTrazasError( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
    	    fnOraRollBack();
		}
		else
		{
		    vDTrazasLog  ( modulo, "\t\tCommit Actualiza Interfaz [iESTAPROC_PROCESANDO]' ",LOG04);
			if (!bfnOraCommit())	
			{
				vDTrazasLog  ( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
				vDTrazasError( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
			}
			else
			{

				memset(&stEstPasoHist,  0   ,sizeof(ESTADISTICASPASHIS));

				bOptRetPasoHist = bfnPasoHistPuntual(lhNumProceso, stInterFact.iCodTipMovimien);

				if(!bOptRetPasoHist)
				{
					vDTrazasLog(modulo,"Fallo el Paso a Historico del Num Proceso %ld",LOG01,lhNumProceso);
					fnOraRollBack();
                    stInterFact.iCodEstaProc    =   iESTAPROC_TERMINADO_ERROR;
                    strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
                    
                    bfnUpdInterFact(stInterFact);
					vDTrazasLog  ( modulo, " Commit Actualiza Interfaz [iESTAPROC_TERMINADO_ERROR]' ",LOG04);
					bfnOraCommit();
					iStatusFin=iESTAQUEUE_ERROR;
					/*break;*/
				}
				else
				{
					vDTrazasLog  (modulo, "\n\t**  Estadisticas de Paso a Historico  **"
										  "\n\t\t\t=> Num Proceso :[%ld]"
				    	                  "\n\t\t\t=> Cantidad de Facturas  :[%d]"
				        	              "\n\t\t\t=> Cantidad de Clientes  :[%d]"
				            	          "\n\t\t\t=> Cantidad de Abonados  :[%d]"
				                	      "\n\t\t\t=> Cantidad de Conceptos :[%d]"
				                          ,LOG03
				                          ,lhNumProceso
				                          ,stEstPasoHist.lNumFacturas
				                          ,stEstPasoHist.lNumClientes
				                          ,stEstPasoHist.lNumAbonados
				                          ,stEstPasoHist.lNumConceptos );
                    vDTrazasLog  ( modulo, " Commit de Transaccion Paso Historico Factura' ",LOG04);
				    	if ( !bfnOraCommit()) 				    	
					{
						vDTrazasLog  (modulo,"Fallo en el Commit para el num proceso %ld ",LOG01,lhNumProceso);
						vDTrazasError(modulo,"Fallo en el Commit para el num proceso %ld ",LOG01,lhNumProceso);
					}
					else
					{
						if(!bfnUpdateInterfazHist(ihCodEstaDocSal,iESTAPROC_TERMINADO_OK,lhNumProceso))
						{
							vDTrazasLog  ( modulo, " Al Marcar registro como 'Terminado Ok' ",LOG01);
							vDTrazasError( modulo, " Al Marcar registro como 'Terminado Ok' ",LOG01);
		    	    		fnOraRollBack();
						}
						else
						{
						    vDTrazasLog  ( modulo, " Commit Actualiza Interfaz [iESTAPROC_TERMINADO_OK]' ",LOG04);
							if (!bfnOraCommit()) 
							{
								vDTrazasLog  ( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
								vDTrazasError( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
							}
						}
					}

				}
			}
		}

	} /* end for */

	vDTrazasLog(modulo,"%s[%ld] Cerrando Cursor ", LOG04, cfnGetTime(1),pid);

	/* EXEC SQL CLOSE Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )125;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (SQLCODE != SQLOK)
	{	vDTrazasError(modulo,"Al cerrar el Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog(modulo,"Al cerrar el Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -16;	}

	if (iModExec == EXEC_ONLINE)
	{		
		if (!bfnCambiaEstCola(szhCodModGener, ihCodProceso, iESTAQUEUE_RUNNING, iStatusFin, "FAC" ))  /* Incorporado por PGonzaleg 31-01-2002 */
		{
			if (!fnOraRollBackRelease())
		    	vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
		    return -11;
		}
		else
		{
		    vDTrazasLog  ( modulo, " fnOraCommitRelease Termino del Proceso ' ",LOG04);		    
		    if (!fnOraCommitRelease())		    
			{	vDTrazasError(modulo,"En Commit release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				if (!fnOraRollBackRelease())
		    		vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				return -11;
			}
		}
	}

	return 0;
} /* PasoHistOnline() */

/*****************************************************************/
/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnPasoHistPuntual                                            * */
/* * Realizamos Paso Historico de Facturas No Ciclicas o Notas de Creditro * */
/* * Paso Cargos Facturados                                                * */
/* * Paso Factura o Nota de Credito                                        * */
/* ************************************************************************* */
BOOL bfnPasoHistPuntual ( long lNumProceso, int iCodTipMovimiento)
{
	char modulo[]="bfnPasoHistPuntual";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhIndOrdenTotal    ;
        char    szhRowid       [20];   /* EXEC SQL VAR szhRowid         IS STRING(20); */ 

        long    lhCodCliente       ;
        long    lhCodTipDocum      ;
        long    lhNumProceso       ;
        long    lhCodCiclFact      ;
        long    lhIndAnulada       ;
        long    lhIndImpresa       ;
        long    lhIndPasoCobro     ;
        long    lhNumFolio         ;
        int     ihNumMes           ;
        long    lhNumSecuRel       ;
        char    szhLetraRel    [2] ;   /* EXEC SQL VAR szhLetraRel      IS STRING(2); */ 

        int     ihCodTipDocumRel   ;
        int     ihCodVendedorAgenteRel;
        int     ihCodCentrRel      ;
        double  dhTotFactura       ;
        char    szhPrefPlaza   [4] ;   /* EXEC SQL VAR szhPrefPlaza     IS STRING(4); */ 

        short 	s_ihPrefPlaza	   ;
        int     ihValorCero = 0;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhNumProceso    = lNumProceso;

    vDTrazasLog ( modulo , "\n\t** Entrada en %s **"
                           "\n\t\t => lhNumProceso... [%ld]"
                            , LOG03, modulo, lhNumProceso);

    /* EXEC SQL SELECT  ROWID           ,
                     COD_CLIENTE     ,
                     COD_TIPDOCUM    ,
                     IND_ORDENTOTAL	 ,
                     COD_CICLFACT    ,
                     IND_ANULADA     ,
                     IND_IMPRESA     ,
                     IND_PASOCOBRO   ,
                     PREF_PLAZA		 ,
                     NUM_FOLIO       ,
                     TO_NUMBER(TO_CHAR(FEC_EMISION, 'YYYYMM')),
                     NVL(NUM_SECUREL,:ihValorCero),
                     NVL(LETRAREL,' ') ,
                     NVL(COD_TIPDOCUMREL,:ihValorCero) ,
                     NVL(COD_VENDEDOR_AGENTEREL,:ihValorCero),
                     NVL(COD_CENTRREL,:ihValorCero),
                     TOT_FACTURA
               INTO  :szhRowid       ,
                     :lhCodCliente   ,
                     :lhCodTipDocum  ,
                     :lhIndOrdenTotal,
                     :lhCodCiclFact  ,
                     :lhIndAnulada   ,
                     :lhIndImpresa   ,
                     :lhIndPasoCobro ,
                     :szhPrefPlaza	 :s_ihPrefPlaza ,
                     :lhNumFolio     ,
                     :ihNumMes       ,
                     :lhNumSecuRel   ,
                     :szhLetraRel     ,
                     :ihCodTipDocumRel,
                     :ihCodVendedorAgenteRel,
                     :ihCodCentrRel  ,
                     :dhTotFactura
               FROM  FA_FACTDOCU_NOCICLO
              WHERE  IND_LIBROIVA  > :ihValorCero
              AND    NUM_PROCESO = :lhNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ROWID ,COD_CLIENTE ,COD_TIPDOCUM ,IND_ORDENTOTAL ,\
COD_CICLFACT ,IND_ANULADA ,IND_IMPRESA ,IND_PASOCOBRO ,PREF_PLAZA ,NUM_FOLIO ,\
TO_NUMBER(TO_CHAR(FEC_EMISION,'YYYYMM')) ,NVL(NUM_SECUREL,:b0) ,NVL(LETRAREL,'\
 ') ,NVL(COD_TIPDOCUMREL,:b0) ,NVL(COD_VENDEDOR_AGENTEREL,:b0) ,NVL(COD_CENTRR\
EL,:b0) ,TOT_FACTURA into :b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12:b13,:b14,:b15\
,:b16,:b17,:b18,:b19,:b20,:b21  from FA_FACTDOCU_NOCICLO where (IND_LIBROIVA>:\
b0 and NUM_PROCESO=:b23)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )140;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihValorCero;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[4] = (unsigned long )20;
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
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodTipDocum;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhIndOrdenTotal;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhIndAnulada;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&lhIndImpresa;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhIndPasoCobro;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[12] = (unsigned long )4;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)&s_ihPrefPlaza;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihNumMes;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&lhNumSecuRel;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhLetraRel;
    sqlstm.sqhstl[16] = (unsigned long )2;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihCodTipDocumRel;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&ihCodVendedorAgenteRel;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&ihCodCentrRel;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&dhTotFactura;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&ihValorCero;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
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


  
    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (modulo,"\n\t**  No Existe Factura en FA_FACTDOCU_NOCICLO **"
                             "\n\t\t=> Para el Num_Proceso [%ld]",LOG01,lhNumProceso);
        vDTrazasError(modulo,"\n\t**  No Existe Factura en FA_FACTDOCU_NOCICLO **"
                             "\n\t\t=> Para el Num_Proceso [%ld]",LOG01,lhNumProceso);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,"\n\t**  Error en Select sobre FA_FACTDOCU_NOCICLO  **",LOG01);
        vDTrazasLog  (modulo,"\n\t**  Error en Select sobre FA_FACTDOCU_NOCICLO  **",LOG01);
        return (FALSE);
    } 
       
    if (!bfnPasHisValInd (  lhIndAnulada, lhIndImpresa, lhIndPasoCobro, lhNumFolio))
    {  
        vDTrazasError(modulo,"\n\t**  Indicadores No Validos para Paso a Historico **"
                             "\n\t\t=> Para el Num_Proceso [%ld]",LOG01,lhNumProceso);

        vDTrazasLog  (modulo,"\n\t**  Indicadores No Validos para Paso a Historico **"
                             "\n\t\t=> Para el Num_Proceso [%ld]",LOG01,lhNumProceso);

        vDTrazasError(modulo,"\t\t=> Ind_Anulada               [%ld]"
                             "\n\t\t=> Ind_Impresa               [%ld]"
                             "\n\t\t=> Ind_PasoCobro             [%ld]"
                             "\n\t\t=> Num_Folio                 [%ld]"
                             ,LOG03,lhIndAnulada, lhIndImpresa, lhIndPasoCobro, lhNumFolio);

        vDTrazasLog  (modulo,"\t\t=> Ind_Anulada               [%ld]"
                             "\n\t\t=> Ind_Impresa               [%ld]"
                             "\n\t\t=> Ind_PasoCobro             [%ld]"
                             "\n\t\t=> Num_Folio                 [%ld]"
                             ,LOG05,lhIndAnulada, lhIndImpresa, lhIndPasoCobro, lhNumFolio);
        return (FALSE);
    }

    if (!bfnUpdateConsMensClie  (lhCodCliente
                                ,iCodTipMovimiento
                                ,ihNumMes
                                ,lhNumSecuRel
                                ,szhLetraRel     
                                ,ihCodTipDocumRel
                                ,ihCodVendedorAgenteRel
                                ,ihCodCentrRel  
                                ,dhTotFactura))
        return FALSE;
                            
    if (!bfnDBPasarCargosConProceso (lhNumProceso,lhCodCliente))
        return FALSE;

    if (!bfnDBPasarHistFactura (lhIndOrdenTotal,lhCodCiclFact))
        return FALSE;

    if (!bfnDBPasarHistDetalle (lhIndOrdenTotal,lhCodCiclFact))
        return FALSE;

    if (!bfnDBPasarHistCliente (lhIndOrdenTotal,lhCodCiclFact))
        return FALSE;

    if (!bfnDBPasarHistAbonado (lhIndOrdenTotal,lhCodCiclFact))
        return FALSE;

    if (!bfnDBEliminarFactura (lhIndOrdenTotal,lhCodCiclFact))
        return FALSE;

    if( !bfnDBPasarHistInterfact(lhNumProceso))
    	return FALSE;

    return TRUE;
}


/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnPasHisValInd  ()                                           * */
/* * Valida Indicadores de Facturas para Paso a Historico                  * */
/* ************************************************************************* */
BOOL bfnPasHisValInd (  long lIndAnulada, long lIndImpresa, long lIndPasoCobro, long lNumFolio)
{

    if (lIndAnulada != 0)
        return FALSE;

    if (lIndImpresa   <= 0)
        return FALSE;

    if (lIndPasoCobro <=0)
        return FALSE;

    if (lNumFolio == 0)
        return FALSE;

    return TRUE;
}


/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnDBPasarCargosConProceso ( )                                * */
/* * Pasamos datos de la tabla GE_CARGOS --> FA_HISTCARGOS                 * */
/* * Realizamos un INSERT SELECT y posteriormente Borramos los datos de    * */
/* * la primera tabla, la forma de acceder a la primera tabla sera con el  * */
/* * Numero de Factura = lNumProceso                                       * */
/* ************************************************************************* */
BOOL bfnDBPasarCargosConProceso( long lNumProceso, long lCodCliente )
{
	char   modulo[]="bfnDBPasarCargosConProceso";

    char    szCadenaInsert[2048]="";
    char    szCadenaDelete[2048]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;


    vDTrazasLog ( modulo,  "\n\t\t\t Entrada en bfnDBPasarCargosConProceso "
                           "\n\t\t\t\t => NumProceso .. [%ld]"
                            , LOG05,lNumProceso);

    vfnInitCadenaInsertCargos(szCadenaInsert,lNumProceso );
    vfnInitCadenaDeleteCargos(szCadenaDelete,lNumProceso );


    /* EXEC SQL PREPARE sql_insert_cargos FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )247;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_cargos  USING   :lCodCliente, :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )266;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_cargos FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )289;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete  CARGOS**"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete  CARGOS**"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_delete_cargos  USING   :lCodCliente, :lNumProceso ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )308;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lNumProceso;
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete CARGOS **"
                                "\n\t\t=> lNumProceso   [%ld]"
                                "\n\t\t=> Error : [%d]  [%s] "
                                ,LOG01, lNumProceso,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    vDTrazasLog(modulo," \n\t\t\t\t   Estadisticas  GE_CARGOS "
                        " \n\t\t\t\t    Filas Insertadas     [%ld]      "
                        " \n\t\t\t\t    Filas Borradas       [%ld]      "
                        " \n\t\t\t\t------------------------------------",
                        LOG05,lFilasInsert,lFilasDelete);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    vDTrazasLog  ( modulo, " Commit de Transaccion Paso Historico Cargos ' ",LOG04);
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (modulo,  " \n\t------------------------------------"
                                " \n\tFallo en el Commit GE_CARGOS        "
                                " \n\t------------------------------------",
                                LOG01);
        vDTrazasError(modulo,  " \n\t------------------------------------"
                                " \n\tFallo en el Commit GE_CARGOS        "
                                " \n\t------------------------------------",
                                LOG01);
        return (FALSE);
    }
    return (TRUE);
}/* **************** * End bfnDBPasarCargosConProceso * ******************** */

/*-----------------------------------------------------------------------------------------------------*/

/* ************************************************************************* */
/* * Funcion bfnDBPasarHistFactura( ),                                     * */
/* * Pasamos a Historicas Facturas                                         * */
/* ************************************************************************* */
BOOL bfnDBPasarHistFactura(long lIndOrdenTotal,long lCodCiclFact)
{
    char modulo[]="bfnDBPasarHistFactura";

    char    szCadenaInsert[5120] ="";

    vDTrazasLog  (modulo,  "\n\t\t\t**  Paso Historico de Facturas **",LOG05);
    vDTrazasLog  (modulo,  "\t\t\t\t ==> Ind.OrdenTotal   [%ld]"
                            "\n\t\t\t\t ==> Cod.CiclFact     [%ld]"
                            ,LOG05,lIndOrdenTotal,lCodCiclFact);
    
    
    
    GargaGedParametros();
    /* WWWW compare*/
    
    
    if(strcmp(szAplica_Cod_Autorizacion,"S") == 0)
    {
    	szfnObtieneCod_autorizacion(lIndOrdenTotal);
    }
    
    vfnInitCadenaInsertFactura (szCadenaInsert);
    
    
    /* EXEC SQL PREPARE sql_insert_factura FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )331;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )5120;
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


 
    if (SQLCODE != SQLOK)
    {
                                
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    
    
   

    /* EXEC SQL EXECUTE sql_insert_factura USING :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )350;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }


    return (TRUE);
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertFactura()                                  * */
/* * Inicilaiza Sql para Insertar Facturas                                 * */
/* ************************************************************************* */
void vfnInitCadenaInsertFactura(char *szCadena)
{
/* Modificación Proyecto Ecu-05002 Codigo de Autorización.
Se modifica sql para insertar campo cod_autorizacion SI ES QUE APLICA INSERTARLO.
*/

    char modulo[]="vfnInitCadenaInsertFactura";
    char szValCodAut[32]="";
    
    sprintf(szValCodAut,", '%s'",szCod_Autorizacion);


       sprintf(szCadena,
               "INSERT INTO FA_HISTDOCU "
                       "(NUM_SECUENCI             , COD_TIPDOCUM              ,"
                       "COD_VENDEDOR_AGENTE       , LETRA                     ,"
                       "COD_CENTREMI              , TOT_PAGAR                 ,"
                       "TOT_CARGOSME              , COD_VENDEDOR              ,"
                       "COD_CLIENTE               , FEC_EMISION               ,"
                       "FEC_CAMBIOMO              , NOM_USUARORA              ,"
                       "ACUM_NETOGRAV             , ACUM_NETONOGRAV           ,"
                       "ACUM_IVA                  , IND_ORDENTOTAL            ,"
                       "IND_VISADA                , IND_LIBROIVA              ,"
                       "IND_PASOCOBRO             , IND_SUPERTEL              ,"
                       "IND_ANULADA               , NUM_PROCESO               ,"
                       "NUM_FOLIO                 , COD_PLANCOM               ,"
                       "COD_CATIMPOS              , FEC_VENCIMIE              ,"
                       "FEC_CADUCIDA              , FEC_PROXVENC              ,"
                       "COD_CICLFACT              , NUM_SECUREL               ,"
                       "LETRAREL                  , COD_TIPDOCUMREL           ,"
                       "COD_VENDEDOR_AGENTEREL    , COD_CENTRREL              ,"
                       "NUM_VENTA                 , NUM_TRANSACCION           ,"
                       "IMP_SALDOANT              , IND_IMPRESA               ,"
                       "SEQ_FORCOB                , SEQ_PAC                   ,"
                       "SEQ_SUPERTFN              , SEQ_FORFAC                ,"
                       "COD_OPREDFIJA             , NUM_CTC                   ,"
                       "COD_MODVENTA              , TOT_FACTURA               ,"
                       "TOT_CUOTAS                , TOT_DESCUENTO             ,"
                       "COD_BARRAS                , IND_FACTUR                ,"
                       "COD_DESPACHO	          , IND_RECUPIVA              ,"
                       "NUM_CUOTAS                , NUM_PROCPASOCOBRO         ,"
                       "COD_OFICINA               , PREF_PLAZA	              ,"
                       "COD_OPERADORA	          , COD_ZONAIMPO	      ,"
                       "COD_PLAZA		  , COD_MONEDAIMP             ,"
                       "IMP_CONVERSION         %s , FEC_ULTMOD                ,"
                       "COD_SEGMENTACION          , IND_BALANCE               ,"
                       "COD_CICLFACT_BAL          , KEY_CONTECNICO            ,"
                       "CONT_TECNICO              , NOM_EMAIL                 ,"
                       "RESOLUCION                , FEC_RESOLUCION            ,"
                       "SERIE                     , ETIQUETA                  ,"
                       "RAN_DESDE                 , RAN_HASTA                 )"
               "SELECT "
                       "NUM_SECUENCI              , COD_TIPDOCUM              ,"
                       "COD_VENDEDOR_AGENTE       , LETRA                     ,"
                       "COD_CENTREMI              , TOT_PAGAR                 ,"
                       "TOT_CARGOSME              , COD_VENDEDOR              ,"
                       "COD_CLIENTE               , FEC_EMISION               ,"
                       "FEC_CAMBIOMO              , NOM_USUARORA              ,"
                       "ACUM_NETOGRAV             , ACUM_NETONOGRAV           ,"
                       "ACUM_IVA                  , IND_ORDENTOTAL            ,"
                       "IND_VISADA                , IND_LIBROIVA              ,"
                       "IND_PASOCOBRO             , IND_SUPERTEL              ,"
                       "IND_ANULADA               , NUM_PROCESO               ,"
                       "NUM_FOLIO                 , COD_PLANCOM               ,"
                       "COD_CATIMPOS              , FEC_VENCIMIE              ,"
                       "FEC_CADUCIDA              , FEC_PROXVENC              ,"
                       "COD_CICLFACT              , NUM_SECUREL               ,"
                       "LETRAREL                  , COD_TIPDOCUMREL           ,"
                       "COD_VENDEDOR_AGENTEREL    , COD_CENTRREL              ,"
                       "NUM_VENTA                 , NUM_TRANSACCION           ,"
                       "IMP_SALDOANT              , IND_IMPRESA               ,"
                       "SEQ_FORCOB                , SEQ_PAC                   ,"
                       "SEQ_SUPERTFN              , SEQ_FORFAC                ,"
                       "COD_OPREDFIJA             , NUM_CTC                   ,"
                       "COD_MODVENTA              , TOT_FACTURA               ,"
                       "TOT_CUOTAS                , TOT_DESCUENTO             ,"
                       "COD_BARRAS                , IND_FACTUR                ,"
                       "COD_DESPACHO	          , IND_RECUPIVA              ,"
                       "NUM_CUOTAS                , NUM_PROCPASOCOBRO         ,"
                       "COD_OFICINA               , PREF_PLAZA                ,"
                       "COD_OPERADORA	          , COD_ZONAIMPO              ,"
                       "COD_PLAZA	          , COD_MONEDAIMP             ,"
                       "IMP_CONVERSION	       %s , FEC_ULTMOD                ,"
                       "COD_SEGMENTACION          , IND_BALANCE               ,"
                       "COD_CICLFACT_BAL          , KEY_CONTECNICO            ,"
                       "CONT_TECNICO              , NOM_EMAIL                 ,"                       
                       "RESOLUCION                , FEC_RESOLUCION            ,"
                       "SERIE                     , ETIQUETA                  ,"
                       "RAN_DESDE                 , RAN_HASTA                  "                                              
               "FROM   FA_FACTDOCU_NOCICLO "
               "WHERE  IND_LIBROIVA  > 0   "
               "AND    IND_ORDENTOTAL = :lhIndOrdenTotal "
            ,(strcmp(szAplica_Cod_Autorizacion,"S")==0)?", COD_AUTORIZACION":" "
            ,(strcmp(szAplica_Cod_Autorizacion,"S")==0)?szValCodAut:" ");
               
               vDTrazasLog  (modulo,  "\n\t**  szCadena	dentro de la funcion [%s] \n",LOG01,szCadena);
               
    
    return;
}

/*--------------------------------------------------------------------------------------------------*/

/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertCargos ( )                                 * */
/* * Inicilaiza Sql para Insertar Cargos en Historico                      * */
/* ************************************************************************* */
void vfnInitCadenaInsertCargos (char * szCadena, long lpNumProc)
{
    sprintf(szCadena,
        "INSERT INTO FA_HISTCARGOS ( "
                "NUM_CARGO        , COD_CLIENTE      , "
                "COD_PRODUCTO     , COD_CONCEPTO     , "
                "FEC_ALTA         , IMP_CARGO        , "
                "COD_MONEDA       , COD_PLANCOM      , "
                "NUM_UNIDADES     , IND_FACTUR       , "
                "NUM_TRANSACCION  , NUM_VENTA        , "
                "NUM_PAQUETE      , NUM_ABONADO      , "
                "NUM_TERMINAL     , COD_CICLFACT     , "
                "NUM_SERIE        , NUM_SERIEMEC     , "
                "CAP_CODE         , MES_GARANTIA     , "
                "NUM_PREGUIA      , NUM_GUIA         , "
                "NUM_FACTURA      , NUM_PROCESO      , "
                "COD_CONCEPTO_DTO , VAL_DTO          , "
                "TIP_DTO          , IND_CUOTA        , "
                "IND_SUPERTEL     , NOM_USUARIO      ) "
        "SELECT "
                "NUM_CARGO        , COD_CLIENTE      , "
                "COD_PRODUCTO     , COD_CONCEPTO     , "
                "FEC_ALTA         , IMP_CARGO        , "
                "COD_MONEDA       , COD_PLANCOM      , "
                "NUM_UNIDADES     , IND_FACTUR       , "
                "NUM_TRANSACCION  , NUM_VENTA        , "
                "NUM_PAQUETE      , NUM_ABONADO      , "
                "NUM_TERMINAL     , COD_CICLFACT     , "
                "NUM_SERIE        , NUM_SERIEMEC     , "
                "CAP_CODE         , MES_GARANTIA     , "
                "NUM_PREGUIA      , NUM_GUIA         , "
                "NUM_FACTURA      , NUM_FACTURA      , "
                "COD_CONCEPTO_DTO , VAL_DTO          , "
                "TIP_DTO          , IND_CUOTA        , "
                "IND_SUPERTEL     , NOM_USUARORA       "
          "FROM GE_CARGOS "
         "WHERE COD_CLIENTE = :lCodCliente "
           "AND NUM_FACTURA %s :lNumProceso ", (lpNumProc==0?">":"="));
    return;
}


/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteCargos ( )                                 * */
/* * Inicilaiza Sql para Delete de Cargos en Historico                     * */
/* ************************************************************************* */
void vfnInitCadenaDeleteCargos (char * szCadena, long lpNumProc)
{

    sprintf(szCadena,
            "DELETE "
              "FROM GE_CARGOS "
             "WHERE COD_CLIENTE = :lCodCliente "
               "AND NUM_FACTURA %s :lNumProceso ", (lpNumProc==0?">":"="));
    return;
}


/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnDBPasarHistDetalle( ),                                     * */
/* * Pasamos a Historicas Detalle de Facturas                              * */
/* ************************************************************************* */
BOOL bfnDBPasarHistDetalle(long lIndOrdenTotal,long lCodCiclFact)
{
    char  modulo[]="bfnDBPasarHistDetalle";
    char    szCadenaInsert[2200] ="";    
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (modulo, "\n\t\t\t**  Paso Historico Detalle Factura **"
    					  "\t\t\t\t ==> Ind.OrdenTotal   [%ld]"
                          "\n\t\t\t ==> Cod.CiclFact     [%ld]"
                          ,LOG05,lIndOrdenTotal,lCodCiclFact);

    vfnInitCadenaInsertDetalle(szCadenaInsert,lCodCiclFact);
    vfnInitCadenaDeleteDetalle(szCadenaDelete);


    /* EXEC SQL PREPARE sql_insert_detalle FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )369;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )2200;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Detalle **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Detalle **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_detalle USING :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )388;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_detalle FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )407;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_detalle USING  :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )426;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    stEstPasoHist.lNumConceptos += lFilasDelete;
    return (TRUE);
}/* ******************* * End bfnDBPasarHistDetalle * ******************* */


/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertDetalle ()                                 * */
/* * Inicilaiza Sql para Insertar Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaInsertDetalle(char *szCadena, long lCodCiclFact)
{

    sprintf(szCadena,
            "INSERT INTO FA_HISTCONC_%ld ( "
                    "IND_ORDENTOTAL  , COD_CONCEPTO    , "
                    "COLUMNA         , COD_MONEDA      , "
                    "COD_PRODUCTO    , COD_TIPCONCE    , "
                    "FEC_VALOR       , FEC_EFECTIVIDAD , "
                    "IMP_CONCEPTO    , COD_REGION      , "
                    "COD_PROVINCIA   , COD_CIUDAD      , "
                    "IMP_MONTOBASE   , IND_FACTUR      , "
                    "IMP_FACTURABLE  , IND_SUPERTEL    , "
                    "NUM_ABONADO     , COD_PORTADOR    , "
                    "DES_CONCEPTO    , SEG_CONSUMIDO   , "
                    "NUM_CUOTAS      , ORD_CUOTA       , "
                    "NUM_UNIDADES    , NUM_SERIEMEC    , "
                    "NUM_SERIELE     , PRC_IMPUESTO    , "
                    "VAL_DTO         , TIP_DTO         , "
                    "MES_GARANTIA    , NUM_GUIA        , "
                    "IND_ALTA        , NUM_PAQUETE     , "
                    "FLAG_IMPUES     , FLAG_DTO        , "
                    "COD_CONCEREL    , COLUMNA_REL     , "
                    "SEQ_CUOTAS      , COD_CARGOBASICO , "
                    "TIP_PLANTARIF   , IMP_DCTO        , "
                    "IMP_REAL        , DUR_DCTO        , "
                    "DUR_REAL        , CNT_LLAM_REAL   , "
                    "CNT_LLAM_DCTO   , CNT_LLAM_FACT   , "
		    		"GLS_DESCRIP     , IMP_VALUNITARIO , "
                    "NUM_VENTA       )"
            "SELECT "
                    "IND_ORDENTOTAL  , COD_CONCEPTO    , "
                    "COLUMNA         , COD_MONEDA      , "
                    "COD_PRODUCTO    , COD_TIPCONCE    , "
                    "FEC_VALOR       , FEC_EFECTIVIDAD , "
                    "IMP_CONCEPTO    , COD_REGION      , "
                    "COD_PROVINCIA   , COD_CIUDAD      , "
                    "IMP_MONTOBASE   , IND_FACTUR      , "
                    "IMP_FACTURABLE  , IND_SUPERTEL    , "
                    "NUM_ABONADO     , COD_PORTADOR    , "
                    "DES_CONCEPTO    , SEG_CONSUMIDO   , "
                    "NUM_CUOTAS      , ORD_CUOTA       , "
                    "NUM_UNIDADES    , NUM_SERIEMEC    , "
                    "NUM_SERIELE     , PRC_IMPUESTO    , "
                    "VAL_DTO         , TIP_DTO         , "
                    "MES_GARANTIA    , NUM_GUIA        , "
                    "IND_ALTA        , NUM_PAQUETE     , "
                    "FLAG_IMPUES     , FLAG_DTO        , "
                    "COD_CONCEREL    , COLUMNA_REL     , "
                    "SEQ_CUOTAS      , COD_CARGOBASICO , "
                    "TIP_PLANTARIF   , IMP_DCTO        , "
                    "IMP_REAL        , DUR_DCTO        , "
                    "DUR_REAL        , CNT_LLAM_REAL   , "
                    "CNT_LLAM_DCTO   , CNT_LLAM_FACT   , "
                    "GLS_DESCRIP     , IMP_VALUNITARIO , "
                    "NUM_VENTA       "
            "FROM   FA_FACTCONC_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ",lCodCiclFact);
    return;
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteDetalle ()                                 * */
/* * Inicilaiza Sql para Deletear Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaDeleteDetalle (char *szCadena)
{

    sprintf(szCadena,
        "DELETE "
        "FROM    FA_FACTCONC_NOCICLO "
        "WHERE   IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}


/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnDBPasarHistCliente ( ),                                    * */
/* * Pasamos a Historicas de Clientes Facturados                           * */
/* ************************************************************************* */
BOOL bfnDBPasarHistCliente(long lIndOrdenTotal,long lCodCiclFact)
{
	char modulo[]="bfnDBPasarHistCliente";

    char    szCadenaInsert[2048] ="";
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (modulo, "\n\t\t\t**  Paso Historico Cliente Factura **"
    					  "\t\t\t\t ==> Ind.OrdenTotal   [%ld]"
                          "\n\t\t\t ==> Cod.CiclFact     [%ld]"
                          ,LOG05,lIndOrdenTotal,lCodCiclFact);

    vfnInitCadenaInsertCliente(szCadenaInsert,lCodCiclFact);
    vfnInitCadenaDeleteCliente(szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_cliente FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )445;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_cliente USING :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )464;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_cliente FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )483;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_cliente USING  :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )502;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    stEstPasoHist.lNumClientes += lFilasDelete;
    return (TRUE);
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertCliente ()                                 * */
/* * Inicilaiza Sql para Insertar Clientes de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaInsertCliente(char *szCadena, long lCodCiclFact)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTCLIE_%ld ( "
                    "IND_ORDENTOTAL , COD_CLIENTE    , "
                    "NOM_CLIENTE    , COD_PLANCOM    , "
                    "NOM_APECLIEN1  , NOM_APECLIEN2  , "
                    "TEF_CLIENTE1   , TEF_CLIENTE2   , "
                    "DES_ACTIVIDAD  , NOM_CALLE      , "
                    "NUM_CALLE      , NUM_PISO       , "
                    "DES_COMUNA     , DES_CIUDAD     , "
                    "COD_PAIS       , COD_RUTADESP   , "
                    "IND_DEBITO     , IMP_STOPDEBIT  , "
                    "COD_BANCO      , COD_SUCURSAL   , "
                    "IND_TIPCUENTA  , COD_TIPTARJETA , "
                    "NUM_CTACORR    , NUM_TARJETA    , "
                    "FEC_VENCITARJ  , COD_BANCOTARJ  , "
                    "COD_TIPIDTRIB  , NUM_IDENTTRIB  , "
                    "NUM_FAX        , COD_IDIOMA     , "
	            	"GLS_DIRECCLIE)"
            "SELECT "
                    "IND_ORDENTOTAL , COD_CLIENTE    , "
                    "NOM_CLIENTE    , COD_PLANCOM    , "
                    "NOM_APECLIEN1  , NOM_APECLIEN2  , "
                    "TEF_CLIENTE1   , TEF_CLIENTE2   , "
                    "DES_ACTIVIDAD  , NOM_CALLE      , "
                    "NUM_CALLE      , NUM_PISO       , "
                    "DES_COMUNA     , DES_CIUDAD     , "
                    "COD_PAIS       , COD_RUTADESP   , "
                    "IND_DEBITO     , IMP_STOPDEBIT  , "
                    "COD_BANCO      , COD_SUCURSAL   , "
                    "IND_TIPCUENTA  , COD_TIPTARJETA , "
                    "NUM_CTACORR    , NUM_TARJETA    , "
                    "FEC_VENCITARJ  , COD_BANCOTARJ  , "
                    "COD_TIPIDTRIB  , NUM_IDENTTRIB  , "
                    "NUM_FAX        , COD_IDIOMA     , "
	            	"GLS_DIRECCLIE "
            "FROM   FA_FACTCLIE_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ",lCodCiclFact);
    return;
    /* RAO130602: se agrega el cod_idioma */
    
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteCliente ()                                 * */
/* * Inicilaiza Sql para Borrar Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaDeleteCliente (char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    FA_FACTCLIE_NOCICLO  "
        "WHERE   IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}



/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnDBPasarHistAbonado( ),                                     * */
/* * Pasamos a Historicas Abonados Facturados                              * */
/* ************************************************************************* */
BOOL bfnDBPasarHistAbonado(long lIndOrdenTotal,long lCodCiclFact)
{
	char modulo[]="bfnDBPasarHistAbonado";

    char    szCadenaInsert[2048] ="";
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    vDTrazasLog  (modulo,"\n\t\t\t**  Paso Historico Abonados de Factura **"
    					 "\t\t\t\t ==> Ind.OrdenTotal   [%ld]"
                         "\n\t\t\t ==> Cod.CiclFact     [%ld]"
                         ,LOG05,lIndOrdenTotal,lCodCiclFact);

    vfnInitCadenaInsertAbonado (szCadenaInsert,lCodCiclFact);
    vfnInitCadenaDeleteAbonado (szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_abonado FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )521;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_abonado USING :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )540;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_abonado FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )559;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK) 
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_abonado USING  :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )578;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(modulo,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    stEstPasoHist.lNumAbonados += lFilasDelete;
    return (TRUE);
}




/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertAbonado ()                                 * */
/* * Inicilaiza Sql para Insertar Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaInsertAbonado(char *szCadena, long lCodCiclFact)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTABON_%ld ( "
                    "IND_ORDENTOTAL   , COD_CLIENTE      , "
                    "NUM_ABONADO      , COD_PRODUCTO     , "
                    "COD_SITUACION    , TOT_CARGOSME     , "
                    "ACUM_CARGO       , ACUM_DTO         , "
                    "ACUM_IVA         , COD_DETFACT      , "
                    "FEC_FINCONTRA    , IND_FACTUR       , "
                    "COD_CREDMOR      , NOM_USUARIO      , "
                    "NOM_APELLIDO1    , NOM_APELLIDO2    , "
                    "LIM_CREDITO      , NUM_CELULAR      , "
                    "NUM_BEEPER       , CAP_CODE         , "
                    "IND_SUPERTEL     , NUM_TELEFIJA     , "
                    "COD_BARRAS       , COD_ZONAABON     , "
                    "IND_COBRODETLLAM ) "/* JEM P-COL-08012*/
            "SELECT "
                    "IND_ORDENTOTAL   , COD_CLIENTE      , "
                    "NUM_ABONADO      , COD_PRODUCTO     , "
                    "COD_SITUACION    , TOT_CARGOSME     , "
                    "ACUM_CARGO       , ACUM_DTO         , "
                    "ACUM_IVA         , COD_DETFACT      , "
                    "FEC_FINCONTRA    , IND_FACTUR       , "
                    "COD_CREDMOR      , NOM_USUARIO      , "
                    "NOM_APELLIDO1    , NOM_APELLIDO2    , "
                    "LIM_CREDITO      , NUM_CELULAR      , "
                    "NUM_BEEPER       , CAP_CODE         , "
                    "IND_SUPERTEL     , NUM_TELEFIJA     , "
                    "COD_BARRAS       , COD_ZONAABON     , "
                    "IND_COBRODETLLAM "/* JEM P-COL-08012*/
            "FROM   FA_FACTABON_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ",lCodCiclFact);
    return;
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteAbonado ()                                 * */
/* * Inicilaiza Sql para Deletear Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaDeleteAbonado (char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    FA_FACTABON_NOCICLO  "
        "WHERE   IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}

/*-----------------------------------------------------------------------------------------------------*/

/* ************************************************************************* */
/* * Funcion bfnDBPasarHistInterfact( ),                                   * */
/* * Pasamos a Historicas Interfaz                                         * */
/* ************************************************************************* */
BOOL bfnDBPasarHistInterfact(long lNumProceso)
{
    char modulo[]="bfnDBPasarHistInterfact";

    char    szCadenaInsert[4096] ="";
    char    szCadenaDelete[512]  ="";
    char    szCadenaDeleteSerie[512]  ="";
    long    lFilasDelete=0          ;

    vDTrazasLog  (modulo,"\n\t\t\t**  Paso Historico de InterFaz **"
    					 "\t\t\t\t ==> Num.Proceso   [%ld]"
                         ,LOG05,lNumProceso);

    vfnInitCadenaInsertInterfaz (szCadenaInsert);
    vfnInitCadenaDeleteSeries (szCadenaDeleteSerie);
    vfnInitCadenaDeleteInterfaz (szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_factura FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )597;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
    sqlstm.sqhstl[0] = (unsigned long )4096;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_factura USING :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )616;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
  
    /* EXEC SQL PREPARE sql_delete_serie FROM :szCadenaDeleteSerie; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )635;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDeleteSerie;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Series **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Series **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_delete_serie USING  :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )654;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Series **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Series **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL PREPARE sql_delete_factura FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )673;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_factura USING  :lNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )692;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);
    stEstPasoHist.lNumRegInterfaz += lFilasDelete;

    return (TRUE);
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertInterfaz()                                 * */
/* * Inicilaiza Sql para Insertar Interfaz                                 * */
/* ************************************************************************* */
void vfnInitCadenaInsertInterfaz(char *szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTINTERFACT ( "
						"NUM_PROCESO       ,"
						"NUM_VENTA         ,"
						"COD_MODGENER      ,"
						"COD_ESTADOC       ,"
						"COD_ESTPROC       ,"
						"COD_TIPMOVIMIEN   ,"
						"COD_CATRIBUT      ,"
						"COD_CATIMPOSITIVA ,"
						"COD_TIPDOCUM      ,"
						"NUM_FOLIO         ,"
						"NUM_FOLIOREL      ,"
						"FEC_INGRESO       ,"
						"FEC_FACTURACION   ,"
						"FEC_IMPRESION     ,"
						"FEC_FOLIACION     ,"
						"FEC_VISACION      ,"
						"FEC_PASOCOBRO     ,"
						"FEC_CIERRE        ,"
						"FEC_VENCIMIENTO   ,"
						"NUM_CUOTAS        ,"
						"COD_MODVENTA      ,"
						"PREF_PLAZA)"
            "SELECT "
						"NUM_PROCESO       ,"
						"NUM_VENTA         ,"
						"COD_MODGENER      ,"
						"COD_ESTADOC       ,"
						"COD_ESTPROC       ,"
						"COD_TIPMOVIMIEN   ,"
						"COD_CATRIBUT      ,"
						"COD_CATIMPOSITIVA ,"
						"COD_TIPDOCUM      ,"
						"NUM_FOLIO         ,"
						"NUM_FOLIOREL      ,"
						"FEC_INGRESO       ,"
						"FEC_FACTURACION   ,"
						"FEC_IMPRESION     ,"
						"FEC_FOLIACION     ,"
						"FEC_VISACION      ,"
						"FEC_PASOCOBRO     ,"
						"FEC_CIERRE        ,"
						"FEC_VENCIMIENTO   ,"
						"NUM_CUOTAS        ,"
						"COD_MODVENTA      ,"
						"PREF_PLAZA		    "
            "FROM   FA_INTERFACT "
            "WHERE  NUM_PROCESO = :lhNumProceso "
            "AND COD_APLIC = 'FAC' "); /* Incorporado por PGonzaleg 31-01-2002 */
    return;
}


/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteInterfaz ()                                 * */
/* * Inicilaiza Sql para Deletear Interfaz                                 * */
/* ************************************************************************* */
void vfnInitCadenaDeleteInterfaz  (char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    FA_INTERFACT  "
        "WHERE   NUM_PROCESO = :lhNumProceso "
        "AND COD_APLIC = 'FAC' "); /* Incorporado por PGonzaleg 31-01-2002 */
    return;
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteSeries ()                                  * */
/* * Inicializa Sql para Deletear Series                                   * */
/* ************************************************************************* */
void vfnInitCadenaDeleteSeries  (char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    FA_SERIES_TO  "
        "WHERE   NUM_PROCESO = :lhNumProceso ");
    return;
}
/*---------------------------------------------------------------------------------------------*/

/* ************************************************************************* */
/* * Funcion bfnDBEliminarFactura( ),                                      * */
/* * Eliminamos Facturas ya pasadas a Historicas                           * */
/* ************************************************************************* */
BOOL bfnDBEliminarFactura(long lIndOrdenTotal,long lCodCiclFact)
{
    char modulo[]="bfnDBEliminarFactura";

    char    szCadenaDelete[512]  ="";
    long    lFilasDelete=0          ;

    vDTrazasLog  (modulo, "\n\t\t\t**  Paso Eliminar Facturas **"
    					  "\t\t\t\t ==> Ind.OrdenTotal   [%ld]"
                          "\n\t\t\t ==> Cod.CiclFact     [%ld]"
                          ,LOG05,lIndOrdenTotal,lCodCiclFact);

    vfnInitCadenaDeleteFactura (szCadenaDelete);

    /* EXEC SQL PREPARE sql_delete_factura FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )711;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )512;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_factura USING  :lIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )730;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);
    stEstPasoHist.lNumFacturas += lFilasDelete;

    return (TRUE);

}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteFactura ()                                 * */
/* * Inicilaiza Sql para Deletear Facturas                                 * */
/* ************************************************************************* */
void vfnInitCadenaDeleteFactura  (char *szCadena)
{
    sprintf(szCadena,
        "DELETE "
        "FROM    FA_FACTDOCU_NOCICLO  "
        "WHERE   IND_LIBROIVA  >  0   "
        "AND     IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}


/* ************************************************************************* */
/* * Funcion bfnUpdateInterfazHist              			   * */
/* ************************************************************************* */
/* * Modifica el Estado de un Documento en la Histórica de la Interfaz     * */
/* ************************************************************************* */
BOOL bfnUpdateInterfazHist(long lEstaDoc, long lEstProc, long lNumProceso)
{
    char modulo[]="bfnUpdateInterfazHist";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long lhEstaDoc  ;
   			long lhEstProc  ;
			long lhNumProc 	;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhEstaDoc = lEstaDoc  	;
	lhEstProc = lEstProc  	;
	lhNumProc = lNumProceso	;

    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***", LOG03, modulo);

    /* EXEC SQL UPDATE FA_HISTINTERFACT
		        SET COD_ESTADOC = :lhEstaDoc,      /o PasoHistorico o/
		        	COD_ESTPROC = :lhEstProc,      /o Procesando OK o Error  o/
		        	FEC_CIERRE = SYSDATE
		      WHERE NUM_PROCESO = :lhNumProc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_HISTINTERFACT  set COD_ESTADOC=:b0,COD_ESTPROC=\
:b1,FEC_CIERRE=SYSDATE where NUM_PROCESO=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )749;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhEstaDoc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhEstProc;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProc;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (modulo," En SQL-UPDATE "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-UPDATE "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  FALSE;
    }

    return TRUE;

}/* bfnUpdateInterfazHist */

/*****************************************************************************/
/* bfnUpdateConsMensClie :    */
/*****************************************************************************/
BOOL bfnUpdateConsMensClie  (long   lCodCliente
                            ,int    iCodTipMovimiento
                            ,int    iNumMes
                            ,long   lNumSecuRel
                            ,char   *szLetraRel     
                            ,int    iCodTipDocumRel
                            ,int    iCodVendedorAgenteRel
                            ,int    iCodCentrRel  
                            ,double dTotFactura)
{
    char modulo[]="bfnUpdateConsMensClie";

    char szCadenaInsert[4096] ="";

    vDTrazasLog  (modulo, "\n\t\t\t**  Actualizacion Estadistica de Consumo mensual del Cliente **"
                          "\n\t\t\t==> Codigo Cliente   [%ld]"
                          ,LOG05,lCodCliente);

    if (    iCodTipMovimiento == VENTA 
        ||  iCodTipMovimiento == MISCELANEA)
    {
        vfnInitCadenaInsertCiclo(szCadenaInsert);
        if (!bfnInsertEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotFactura))
        {
            vfnInitCadenaUpdateCiclo(szCadenaInsert);
            if (!bfnUpdateEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotFactura))
            {
                vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return (FALSE);
               
            }
        }
    }
    else if (iCodTipMovimiento == NOTACRED )
    {
        if (!bfnEstadConsumNC( lCodCliente
                             , iNumMes
                             , lNumSecuRel 
                             , szLetraRel
                             , iCodTipDocumRel
                             , iCodVendedorAgenteRel
                             , iCodCentrRel
                             , dTotFactura)) /* PGG SOPORTE 41308 13-06-2007 */
        {
            vDTrazasError(modulo,"\n\t**  Error al procesar Estadisticas Consumo Nota credito **"
                                 "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasLog  (modulo,"\n\t**  Error al procesar Estadisticas Consumo Nota credito **"
                                 "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return (FALSE);
        }
    }
    return (TRUE);
}


/*****************************************************************************/
/* bfnEstadConsumNC :    */
/*****************************************************************************/
BOOL bfnEstadConsumNC (long   lCodCliente
                      ,int    iNumMes
                      ,long   lNumSecuRel
                      ,char   *szLetraRel     
                      ,int    iCodTipDocumRel
                      ,int    iCodVendedorAgenteRel
                      ,int    iCodCentrRel
                      ,double dTotOriginalDocto) /* PGG SOPORTE 41308 13-06-2007 */
{
    char modulo[]="bfnEstadConsumNC";

    char szCadenaInsert[4096] ="";
    
    double  dTotDocCiclo    =0.0; /* PGG SOPORTE 41308 13-06-2007 */
    double  dTotDocNoCiclo  =0.0; /* PGG SOPORTE 41308 13-06-2007 */
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumSecuRel          ;
        char    szhLetraRel        [2];/* EXEC SQL VAR szhLetraRel         IS STRING(2); */ 

        int     ihCodTipDocumRel      ;
        int     ihCodVendedorAgenteRel;
        int     ihCodCentrRel         ;
        int     ihCodTipMovimien      ;
		double  dhTotFactura          ;
		long    lhInd_Ciclo			  ;

    /* EXEC SQL END DECLARE SECTION; */ 
  
                                   
    vDTrazasLog  (modulo,"\n\t\t\t\t** Entrada en bfnEstadConsumNC  "
                         "\n\t\t\t\t\t=>Nro. de Secuencia   : [%ld] "
                         "\n\t\t\t\t\t=>Letra               : [%s]  "
                         "\n\t\t\t\t\t=>Cod.Tipo Documento  : [%d]  "
                         "\n\t\t\t\t\t=>Cod.Vendedor Agente : [%d]  "
                         "\n\t\t\t\t\t=>Cod.Centro Emisor   : [%d]  "
                         ,LOG05,lNumSecuRel,szLetraRel,iCodTipDocumRel
                         ,iCodVendedorAgenteRel,iCodCentrRel);

    lhNumSecuRel          =lNumSecuRel;
    strcpy (szhLetraRel,szLetraRel);
    ihCodTipDocumRel      =iCodTipDocumRel;
    ihCodVendedorAgenteRel=iCodVendedorAgenteRel;
    ihCodCentrRel         =iCodCentrRel;

/* PGG SOPORTE 41308 13-06-2007 Se comenta esta query */
/*
	EXEC SQL DECLARE Cur_FaFactDocu_NC CURSOR FOR
            SELECT B.COD_TIPMOVIMIEN--, A.TOT_FACTURA
              FROM FA_HISTDOCU A, FA_TIPMOVIMIEN B
             WHERE A.COD_TIPDOCUM       =:ihCodTipDocumRel
               AND NUM_SECUENCI         =:lhNumSecuRel
               AND A.COD_VENDEDOR_AGENTE=:ihCodVendedorAgenteRel
               AND A.COD_CENTREMI       =:ihCodCentrRel
               AND A.LETRA              =:szhLetraRel
               AND A.COD_TIPDOCUM       =B.COD_TIPDOCUM ;
*/



/* PGG SOPORTE 41308 13-06-2007 */
	/* EXEC SQL
		SELECT B.IND_CICLO
		INTO :lhInd_Ciclo
		FROM FA_HISTDOCU A, FA_TIPDOCUMEN B
		WHERE A.COD_TIPDOCUM       =:ihCodTipDocumRel
		AND NUM_SECUENCI         =:lhNumSecuRel
		AND A.COD_VENDEDOR_AGENTE=:ihCodVendedorAgenteRel
		AND A.COD_CENTREMI       =:ihCodCentrRel
		AND A.LETRA              =:szhLetraRel
		AND A.COD_TIPDOCUM       =B.COD_TIPDOCUMMOV; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 23;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select B.IND_CICLO into :b0  from FA_HISTDOCU A ,FA_TIPDOCUM\
EN B where (((((A.COD_TIPDOCUM=:b1 and NUM_SECUENCI=:b2) and A.COD_VENDEDOR_AG\
ENTE=:b3) and A.COD_CENTREMI=:b4) and A.LETRA=:b5) and A.COD_TIPDOCUM=B.COD_TI\
PDOCUMMOV)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )776;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhInd_Ciclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuRel;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodVendedorAgenteRel;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentrRel;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhLetraRel;
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


 	if (SQLCODE != SQLOK)
	{	
	    vDTrazasError(modulo,"Al declarar Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"Al declarar Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return (FALSE);	
		}
    
    if (lhInd_Ciclo == 1) /* CICLO */
		{
			dTotDocCiclo  = dTotOriginalDocto;
		}
		else 
		{
			dTotDocNoCiclo= dTotOriginalDocto;
    }
    
/* PGG SOPORTE 41308 13-06-2007 Se comenta todo esto */
/*
	EXEC SQL OPEN Cur_FaFactDocu_NC;

	if (SQLCODE != SQLOK)
	{	
	    vDTrazasError(modulo,"Al Abrir Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"Al Abrir Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return (FALSE);	
	}

	for (;;)
	{
		EXEC SQL FETCH Cur_FaFactDocu_NC
			      INTO :ihCodTipMovimien,:dhTotFactura ;

		if (SQLCODE == SQLNOTFOUND)
		    break;
		else if (SQLCODE == SQLOK )
		{
        	if (ihCodTipMovimien==CICLO)
        	{
                dTotDocCiclo  += dhTotFactura;
            }
            else if (ihCodTipMovimien==VENTA || ihCodTipMovimien==MISCELANEA)
            {
                dTotDocNoCiclo+= dhTotFactura;
            }
        }
		else 
		{
    	    vDTrazasError(modulo,"En Fetch Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
    		vDTrazasLog  (modulo,"En Fetch Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
    		return (FALSE);
    	}
    }
	
	EXEC SQL CLOSE Cur_FaFactDocu_NC;

	if (SQLCODE != SQLOK)
	{	
	    vDTrazasError(modulo,"Al cerrar el Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"Al cerrar el Cursor Cur_FaFactDocu_NC\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return (FALSE);
	}
	
*/
  
    if (dTotDocCiclo)
    {
        vfnInitCadenaInsertNCCiclo(szCadenaInsert);
        if (!bfnInsertEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotDocCiclo))
        {           
            vDTrazasLog(modulo,"\n\t** Advertencia, el Insert de la estadistica de NC. Ciclo resulto con Error **",LOG01);

            vfnInitCadenaUpdateNCCiclo (szCadenaInsert);
            
            if (!bfnUpdateEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotDocCiclo))
            {
                vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo Nota credito No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo Nota credito No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return (FALSE);
                
            }
        }
    }
    if (dTotDocNoCiclo)
    {
        vfnInitCadenaInsertNCNoCiclo(szCadenaInsert);
        if (!bfnInsertEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotDocNoCiclo))
        {
            vDTrazasLog(modulo,"\n\t** Advertencia, el Insert de la estadistica de NC. No-Ciclo resulto con Error **",LOG01);

            vfnInitCadenaUpdateNCNoCiclo (szCadenaInsert);

            if (!bfnUpdateEstadist(szCadenaInsert, lCodCliente, iNumMes, dTotDocNoCiclo))
            {
                vDTrazasError(modulo,"\n\t**  Error al hacer Update del Consumo Nota credito No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasLog  (modulo,"\n\t**  Error al hacer Update del Consumo Nota credito No-Ciclo **"
                                     "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return (FALSE);
                
            }
        }
    }

    return (TRUE);
}/* bfnEstadConsumNC */


/*******************************************************************/
void vfnInitCadenaInsertCiclo(char * szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FAT_CONMESCLIE (  "
						"COD_CLIENTE     , "
						"NUM_MES         , "
						"MTO_FACTNOCICLO , "
    					"NUM_MINREBA     , "
    					"NUM_MINADIC     , "
    					"NUM_MINFREC     , "
    					"NUM_MINOPER     , "
    					"NUM_MINRFIJA    , "
    					"NUM_MINTMOV     , "
    					"MTO_FACTCICLO   , "
    					"MTO_NCCICLO	 , "
    					"MTO_NCNOCICLO   , "
    					"NUM_MINESPE	 ) "
            "VALUES (    :lhCodCliente, "
						":ihNumMes    , "
						":dhTotEstad  , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            ) ");
	return;
}

void vfnInitCadenaUpdateCiclo(char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET MTO_FACTNOCICLO=MTO_FACTNOCICLO + :dhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}

/*******************************************************************/
void vfnInitCadenaInsertNCCiclo(char * szCadena)
{
    sprintf(szCadena,
                "INSERT INTO FAT_CONMESCLIE "
                       "(COD_CLIENTE    , "
    					"NUM_MES        , "
    					"MTO_NCCICLO    , "
						"MTO_FACTNOCICLO, "
    					"NUM_MINREBA    , "
    					"NUM_MINADIC    , "
    					"NUM_MINFREC    , "
    					"NUM_MINOPER    , "
    					"NUM_MINRFIJA   , "
    					"NUM_MINTMOV    , "
    					"MTO_FACTCICLO  , "
    					"MTO_NCNOCICLO  , "
    					"NUM_MINESPE	) "
                "VALUES (:lhCodCliente, "
    					":ihNumMes    , "
    					":dhTotEstad  , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            ) ");

	return;
}
void vfnInitCadenaUpdateNCCiclo(char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET MTO_NCCICLO=MTO_NCCICLO + :dhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");
	return;
    
}
/*******************************************************************/
void vfnInitCadenaInsertNCNoCiclo(char * szCadena)
{
    sprintf(szCadena,
                "INSERT INTO FAT_CONMESCLIE "
                       "(COD_CLIENTE    , "
    					"NUM_MES        , "
    					"MTO_NCNOCICLO  , "
    					"MTO_NCCICLO    , "
						"MTO_FACTNOCICLO, "
    					"NUM_MINREBA    , "
    					"NUM_MINADIC    , "
    					"NUM_MINFREC    , "
    					"NUM_MINOPER    , "
    					"NUM_MINRFIJA   , "
    					"NUM_MINTMOV    , "
    					"MTO_FACTCICLO  , "
    					"NUM_MINESPE	) "
                "VALUES (:lhCodCliente, "
    					":ihNumMes    , "
    					":dhTotEstad  , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            , "
    					"0            ) ");
	return;
    
}

void vfnInitCadenaUpdateNCNoCiclo(char * szCadena)
{
    sprintf(szCadena,
            "UPDATE FAT_CONMESCLIE "
				    "SET MTO_NCNOCICLO=MTO_NCNOCICLO + :dhTotEstad "
            "WHERE "
					"COD_CLIENTE = :lhCodCliente "
					"AND NUM_MES = :ihNumMes ");

	return;
}



/*****************************************************************************/
/* bfnInsertEstadNCNoCiclo :    */
/*****************************************************************************/
BOOL bfnInsertEstadist (char *szCadenaInsert,long lCodCliente,int iNumMes,double dTotEstad)
{
    char modulo[]="bfnInsertEstadist";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long    lhCodCliente;
   			int     ihNumMes    ;
			double  dhTotEstad  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente=lCodCliente;
    ihNumMes    =iNumMes    ;
    dhTotEstad  =dTotEstad  ;

    vDTrazasLog  (modulo,  "\n\t\t\t\t**  Entrada en bfnInsertEstadist **"
                           "\n\t\t\t\t\t=> Cod. Cliente  : [%ld] "
                           "\n\t\t\t\t\t=> Nro. Mes      : [%d] "
                           "\n\t\t\t\t\t=> Total Estad.  : [%.0f] "
                           "\n\t\t\t\t\t=> Cadena SQL    : [%s] "
                           ,LOG03,lhCodCliente,ihNumMes,dhTotEstad, szCadenaInsert);
    
    /* EXEC SQL PREPARE sql_insert_estadist FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )815;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Estadisticas **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL EXECUTE sql_insert_estadist USING :lhCodCliente, :ihNumMes, :dhTotEstad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )834;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumMes;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&dhTotEstad;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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
        return  (FALSE);
    }

    return (TRUE);
}    


/*****************************************************************************/
/* bfnUpdateEstadist :    */
/*****************************************************************************/
BOOL bfnUpdateEstadist (char *szCadenaUpdate,long lCodCliente,int iNumMes,double dTotEstad)
{
    char modulo[]="bfnUpdateEstadist";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long    lhCodCliente;
   			int     ihNumMes    ;
			double  dhTotEstad  ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente=lCodCliente;
    ihNumMes    =iNumMes    ;
    dhTotEstad  =dTotEstad;

    /* EXEC SQL PREPARE sql_update_estadist FROM :szCadenaUpdate; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )861;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaUpdate;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Update Facturas **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Update Facturas **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_update_estadist USING :dhTotEstad, :lhCodCliente, :ihNumMes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )880;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotEstad;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihNumMes;
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



    if ( SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Update Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Update Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return (TRUE);
}    

/*****************************************************************************/
/* bfnGetCodTipMov : Obtiene el codigo de movimiento del tipo de documento   */
/*****************************************************************************/
BOOL bfnGetCodTipMov (int iCodTipDocum, int *iCodTipMovim)
{
    char modulo[]="bfnGetCodTipMov";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			int ihCodTipDocum;
   			int ihCodTipMovim;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    ihCodTipDocum=iCodTipDocum;
    
    /* EXEC SQL  SELECT COD_TIPMOVIMIEN
                INTO   :ihCodTipMovim
                FROM   FA_TIPMOVIMIEN
               WHERE  COD_TIPDOCUM = :ihCodTipDocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_TIPMOVIMIEN into :b0  from FA_TIPMOVIMIEN wher\
e COD_TIPDOCUM=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )907;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipMovim;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
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



    if(SQLCODE != SQLOK)
    {    
        vDTrazasError(modulo,"\n\t\t\t**  Error en Select sobre FA_TIPMOVIMIEN (COD_TIPMOVIMIEN) **"
                             "\n\t\t\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,"\n\t\t\t**  Error en Select sobre FA_TIPMOVIMIEN (COD_TIPMOVIMIEN) **"
                             "\n\t\t\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    *iCodTipMovim =ihCodTipMovim;
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

