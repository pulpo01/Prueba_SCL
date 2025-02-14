
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
static struct sqlcxp sqlfpn =
{
    23,
    "./pc/New_ImpreOnline.pc"
};


static unsigned int sqlctx = 443227331;


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

 static char *sq0001 = 
"select NUM_PROCESO  from FA_INTERFACT where ((((COD_MODGENER=:b0 and COD_EST\
ADOC=:b1) and COD_ESTPROC=:b2) and COD_APLIC='FAC') and FEC_FACTURACION<(SYSDA\
TE-(:b3/24)))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,178,0,9,338,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
36,0,0,1,0,0,13,349,0,0,1,0,0,1,0,2,3,0,0,
55,0,0,2,107,0,5,398,0,0,1,1,0,1,0,1,3,0,0,
74,0,0,1,0,0,15,449,0,0,0,0,0,1,0,
};


/* ******************************************************************************/
/*	ImpreOnline  ('Impresion On-line')					*/
/*										*/
/*    Recibe 3 parametros : -u usuario/password  ; -l loglevel ; -e codmodgener	*/
/*										*/
/*	14 de Diciembre de 1999							*/
/*										*/
/*										*/
/***************************************************************************** */
/* ************************************************************************** */
/* *  05-05-2000:   Modificacion de Cursor de Documentos para agregar       * */
/* *  (MVV)         la seleccion de los tipos de Documentos en Consignación * */
/* *                ya que estos documentos se deben marcar como impresos   * */
/* *                independiente del modod de generacion de Doctos.        * */
/* ************************************************************************** */
/* ************************************************************************** */
/* *	Incorporacion del campo COD_APLIC en las llamadas 		    * */
/* *			a las sgtes. funciones:				    * */
/* *		bfnGetInterFact		bfnGetIntQueueProc		    * */
/* *		bfnUpdInterFact 	bfnCambiaEstCola		    * */
/* *	Patricio Gonzalez G.	29-01-2002			            * */
/* ************************************************************************** */
/******************************************************************************/


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <predefs.h>
#include <deftypes.h>
#include <New_Interfact.h>
#include <unistd.h>
#include <GenFA.h>

#include "New_ImpreOnline.h"

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


long pid;

/* ********************************************************************************************* */
/* modulo principal */
/* ********************************************************************************************* */
int main(int argc,char *argv[])
{
	char modulo[]="main";

	 int sts;
	 int iLogLevel          =3;
	char szOraAccount   [32]="";
	char szOraPasswd    [32]="";
	char szCodModGener  [4] ="";
	char status         [16]="";


	pid=getpid();
	fprintf( stdout, "\n*** New_ImpreOnline. ***\n"
	                   "%s\n** pid : [ %8ld ] **\n"
	                   "************************\n",
	         cfnGetTime(1),pid );

	sts = ifnValidaParametros(argc,argv,szOraAccount, szOraPasswd, &iLogLevel, szCodModGener);
	if ( sts != 0 ) return sts;
	
	sts = ifnAbreArchivosLog(iLogLevel);
	if ( sts != 0 ) return sts;

	vDTrazasLog(modulo,"Despues del ifnAbreArchivosLog ", LOG04);

	sts = ifnImpresionOnline(szOraAccount,szOraPasswd,iLogLevel,szCodModGener);
	if (sts != 0)
	{
    	vDTrazasError(modulo,"%s[%ld] Termino Anormal de la Impresion", LOG03, cfnGetTime(1),pid);
	}
	else
	{
    	vDTrazasLog  (modulo,"%s[%ld] Termino Controlado de la Impresion", LOG03, cfnGetTime(1),pid);
	}

	fprintf(stdout,"\n");
	return sts;

} /* main */



/* ********************************************************************************************* */
/* ifnValidaParametros () */
/* ********************************************************************************************* */
int ifnValidaParametros ( int argc, char *argv[], char *szOraAccount, char *szOraPasswd,
						  int *iLogLevel, char *szCodModGener  )

{
	char modulo[]="ifnValidaParametros";

	extern char *optarg;
	extern int  optind, opterr, optopt;
	char        opt[] = ":u:l:e:";
	int         iOpt=0,ihCodProc;
	char        *psztmp = "";
	char        szUser [64] = "";

	int  Userflag       =FALSE;
	int  Logflag        =FALSE;
	int  Modflag        =FALSE;

	char szAccount  [32]="";
	char szPasswd   [32]="";

	opterr=0;

	if(argc == 1)
	{
		fprintf (stderr,"\n<< Error : Parametros insuficientes >>\n%s\n",szUsage);
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
					fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'l':
				if(Logflag==FALSE)
				{
					*iLogLevel=atoi(optarg);
					Logflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
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
					fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case '?':
				fprintf(stdout,"\n<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
				return -3;

			case ':':
				fprintf(stdout,"\n<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
				return -4;

		}/* endswitch */

	} /* enwhile */


	if(Modflag==FALSE)
	{
		fprintf (stderr,"\n<< Error : falta opcion '-m' >>\n%s\n",szUsage);
		return -1;
	}

	if(Logflag==FALSE)
	{
		fprintf (stderr,"\n<< Error : falta opcion '-l' >>\n%s\n",szUsage);
		return -1;
	}

	if(Userflag==TRUE)
	{
		if ( (psztmp=(char *)strstr(szUser,"/") )==(char *)NULL )
		{
			fprintf (stderr,"\n<< Error : usuario no valido. Requiere \"/\" >>\n%s\n",szUsage);
			return -5;
		}
		else
		{
			strncpy (szOraAccount,szUser,psztmp-szUser);
			strcpy  (szOraPasswd, psztmp+1);
		}
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
	char szArchivo  [32] ="";
	char szPath     [128]="";
	char szComando  [128]="";

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"New_ImpreOnline");

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/New_ImpreOnline/%s",pathDir,cfnGetTime(2)); /* '....log/New_ImpreOnline/YYYYMMDD/' */
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	stStatus.LogNivel = iLogLevel;

	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
	{
	    fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;
	}

	vDTrazasError(modulo, "\n%s[%ld] << Abre Archivo de Errores >>", LOG04, cfnGetTime(1),pid);

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;    }

	vDTrazasLog(modulo, "\n%s[%ld] << Abre Archivo de Log New_ImpreOnline >>", LOG04, cfnGetTime(1),pid);

	return 0 ; /* Validacion ok */
}


/* ***************************************************************************** */
/* ifnImpresionOnline()*/
/* ***************************************************************************** */
ifnImpresionOnline(char *szAccount, char *szPasswd, int iLogLevel, char *szCodModGener)
{
	char modulo[]="ImpresionOnline";

	 int iCont=0;
	 int iStatusFin=iESTAQUEUE_WAIT;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 


		long lhNumProceso=0;
		 int ihFactOk=0;

		 int ihCodEstaDocEnt=0;
		 int ihCodEstaDocSal=0;
		 int ihCodNivLog;

		char szhNomUsuarOra[30];
		char szhPasUsuarOra[30];
		char szhCodModGener[4];

		 int ihCodProceso;

	     int ihNumDeltaHoras;

	/* EXEC SQL END DECLARE SECTION; */ 


	ihFactOk = iESTAPROC_TERMINADO_OK ;

	strcpy(szhNomUsuarOra,szAccount);
	strcpy(szhPasUsuarOra,szPasswd);
	strcpy(szhCodModGener,szCodModGener);
	ihCodNivLog = iLogLevel;

	ihCodProceso = iPROCESO_INT_IMPRESION; 	/* 300 */

	if (!fnOraConnect(szAccount,szPasswd))
	{
	    vDTrazasError   (modulo, "%s No Hay Conexion a la Base de Datos"
	                    ,LOG01,cfnGetTime(3));
		return -10;
	}

	vDTrazasLog (modulo,"%s[%ld] Conectado a la Base de Datos"
	            ,LOG04, cfnGetTime(1),pid);
    vDTrazasLog (modulo,"%s[%ld] Obtencion datos cola  "
                ,LOG04, cfnGetTime(1),pid);
    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
    strcpy( stIntQueueProc.szCodModGener , szCodModGener);
            stIntQueueProc.lCodProceso   = ihCodProceso;
    strcpy(stIntQueueProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 29-01-2002 */            
            
    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
		return -14;
	}

    ihCodEstaDocEnt	= stIntQueueProc.iCodEstaDocEnt;
    ihNumDeltaHoras = stIntQueueProc.iNumDeltaHoras;

	vDTrazasLog (modulo,"%s[%ld] Preparando Cursor sobre FA_INTERFACT [%s][%d]"
	            ,LOG04, cfnGetTime(1),pid,szhCodModGener,ihCodEstaDocEnt);
	/* EXEC SQL DECLARE Cur_FaInterFact CURSOR FOR
			 SELECT NUM_PROCESO
			   FROM FA_INTERFACT
			  WHERE COD_MODGENER = :szhCodModGener      	/o 'xxx'    o/
			    AND COD_ESTADOC  = :ihCodEstaDocEnt     	/o Facturadao/
			    AND COD_ESTPROC  = :ihFactOk            	/o Fact Ok  o/
			    AND COD_APLIC    = 'FAC'			/o Incorporado por PGonzaleg 31-01-2002 o/
			    AND FEC_FACTURACION < (SYSDATE - (:ihNumDeltaHoras / 24)) ; */ 
 /* nuevo delta de tiempo */

	if (SQLCODE)
	{
	    vDTrazasError   (modulo,"Al declarar Cursor\n%s\n"
	                    ,LOG01,sqlca.sqlerrm.sqlerrmc);
		return -14;
	}

	/* EXEC SQL OPEN Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihFactOk;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihNumDeltaHoras;
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



	if (SQLCODE)
	{
	    vDTrazasError   (modulo,"Al Abrir Cursor\n%s\n"
	                    ,LOG01,sqlca.sqlerrm.sqlerrmc);
		return -15;
	}

	while (1)
	{
		/* EXEC SQL FETCH Cur_FaInterFact
			      INTO :lhNumProceso; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )36;
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
			iStatusFin=iESTAQUEUE_WAIT;
			break;
		}
		else if (sqlca.sqlcode)
		{
			vDTrazasError   (modulo,"En el Fetch del Cursor\n%s\n"
			                ,LOG01,sqlca.sqlerrm.sqlerrmc);
			iStatusFin=iESTAQUEUE_ERROR;
			break;
		}

        memset(&stInterFact,0,sizeof(INTERFACT));
        stInterFact.lNumProceso     = lhNumProceso ;
	strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 29-01-2002 */
	
        if (!bfnGetInterFact(&stInterFact))
        {
            vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            break;
        }

			  				   /* impresa */
		stInterFact.iCodEstaDoc = stIntQueueProc.iCodEstaDocSal;
	    stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;
	    strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 29-01-2002 */
	    
		if (!bfnUpdInterFact(stInterFact))
		{
			vDTrazasLog  ( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
			vDTrazasError( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
    	    fnOraRollBack();
		}
		else
		{
			if (!bfnOraCommit())
			{
				vDTrazasLog  ( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
				vDTrazasError( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
			}
			else
			{
				/* EXEC SQL UPDATE FA_FACTDOCU_NOCICLO
	    		    SET IND_IMPRESA = 1
	    		  WHERE NUM_PROCESO = :lhNumProceso
					AND IND_ANULADA = 0
					AND IND_IMPRESA = 0 ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set IND_IMPRESA=1 where ((NUM\
_PROCESO=:b0 and IND_ANULADA=0) and IND_IMPRESA=0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )55;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
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



	    		if (SQLCODE)
    			{
        			vDTrazasLog  (modulo," En el UPDATE de la FA_FACTDOCU_NOCICLO "
        		                         "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        			vDTrazasError(modulo," En el UPDATE de la FA_FACTDOCU_NOCICLO "
            	    	                 "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
					bfnOraRollBack();
					fnGrabaAnomalia(lhNumProceso, 0,"New_ImpreOnline"
                                    , strcat(cfnGetTime(1), "=> update FA_FACTDOCU_NOCICLO err:") );
					stInterFact.iCodEstaProc     = iESTAPROC_TERMINADO_ERROR ;
					strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 29-01-2002 */
					
					bfnUpdInterFact(stInterFact);
					bfnOraCommit();
					iStatusFin=iESTAQUEUE_ERROR;
					/*break;*/
    			}
    			else 
    			{
                    stInterFact.iCodEstaProc     = iESTAPROC_TERMINADO_OK ;
    			    strcpy(stInterFact.szFecImpresion, cfnGetTime(7)) ;
    			    strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 29-01-2002 */
    			    
    			    if(!bfnUpdInterFact(stInterFact))
				    {
    					vDTrazasLog  ( modulo, " Al Marcar registro como 'Terminado OK' ",LOG01);
					    vDTrazasError( modulo, " Al Marcar registro como 'Terminado OK' ",LOG01);
    	    		    bfnOraRollBack();
				    }
				    else
				    {
    					if (!bfnOraCommit())
					    {
    						vDTrazasLog     ( modulo, " Al hacer Commit sobre la Interfact ",LOG01);
		    				vDTrazasError   (modulo, " Al hacer Commit sobre la Interfact " ,LOG01);
				    	}
				    }
				}
			}
		}
		vDTrazasLog  ( modulo, " Registro [%ld] Procesado ",LOG03, lhNumProceso);
	} /* end while */

	vDTrazasLog (modulo,"%s[%ld] Cerrando Cursor " , LOG04, cfnGetTime(1),pid);

	/* EXEC SQL CLOSE Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )74;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode)
	{
	    vDTrazasError(modulo,"Al cerrar el Cursor\n%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -18;
	}
    vDTrazasLog (modulo,"%s[%ld] Cambiando cola [%s / %d / %d / %d ]"
	            , LOG04, cfnGetTime(1),pid,szhCodModGener, ihCodProceso, iESTAQUEUE_RUNNING, iStatusFin);	             
	if (!bfnCambiaEstCola(szhCodModGener, ihCodProceso, iESTAQUEUE_RUNNING, iStatusFin, "FAC")) /* Incorporacion del ultimo parametro por PGonzaleg 29-01-2002 */
	{
		if (!fnOraRollBackRelease())
	    	vDTrazasError   (modulo,"En Rollback release\n%s\n" ,LOG01, sqlca.sqlerrm.sqlerrmc);
	    return -11;
	}
	else
	{	if (!fnOraCommitRelease())
		{	
		    vDTrazasError   (modulo,"En Commit release\n%s\n",LOG01, sqlca.sqlerrm.sqlerrmc);
			if (!fnOraRollBackRelease())
	    		vDTrazasError   (modulo,"En Rollback release\n%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			return -11;
		}
	}

 	return 0;

} /* ifnImpresionOnline() */



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

