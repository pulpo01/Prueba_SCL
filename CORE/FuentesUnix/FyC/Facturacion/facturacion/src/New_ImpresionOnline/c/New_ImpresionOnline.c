
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
           char  filnam[28];
};
static const struct sqlcxp sqlfpn =
{
    27,
    "./pc/New_ImpresionOnline.pc"
};


static unsigned int sqlctx = 1498281277;


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
   unsigned char  *sqhstv[3];
   unsigned long  sqhstl[3];
            int   sqhsts[3];
            short *sqindv[3];
            int   sqinds[3];
   unsigned long  sqharm[3];
   unsigned long  *sqharc[3];
   unsigned short  sqadto[3];
   unsigned short  sqtdso[3];
} sqlstm = {12,3};

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
"select NUM_PROCESO ,COD_TIPMOVIMIEN ,COD_TIPDOCUM  from FA_INTERFACT where (\
((COD_MODGENER=:b0 and COD_ESTADOC=:b1) and COD_ESTPROC=:b2) and COD_APLIC='FA\
C')           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,168,0,9,343,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
32,0,0,1,0,0,13,357,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
59,0,0,1,0,0,15,446,0,0,0,0,0,1,0,
};


/* ******************************************************************************** */
/*	New_ImresionOnline ('máscara sobre ImpresionScl.ksh')			    */
/*										    */
/*  Parametros : -u usuario/password  ; -l loglevel ; -m codmodgener		    */
/*	 20 de Septiembre de 2005						    */
/********************************************************************************** */
/*  22032001 :Se modifca la obtencion de los estado de doc. de entrada y salida     */
/*  para ser tomados desde la cola de ejecucion					    */
/********************************************************************************** */
/*	Incorporacion del Campo COD_APLIC en las llamadas a las funciones	  * */
/*		bfnGetInterFact			bfnGetIntQueueProc  		  * */
/*		bfnUpdInterFact			bfnCambiaEstCola		  * */		
/********************************************************************************** */


#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <deftypes.h>
#include <predefs.h>
#include <unistd.h>

#include <New_Interfact.h>
#include <GenFA.h>
#include "New_ImpresionOnline.h"

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

FILE *fpShell; /* SAAM-20030805 */
char szCodModGenerGlobal[4] ="" ; /* SAAM-20030805 */


/* ******************************************************************************** */
/* modulo principal                                                                 */
/* ******************************************************************************** */
int main(int argc,char *argv[])
{
	char modulo[]="main";

	 int sts;
	 int iLogLevel          =3  ;
	char szOraAccount   [32]="" ;
	char szOraPasswd    [32]="" ;
	char szCodModGener  [4] ="" ;

	pid=getpid();
	fprintf( stdout, "\n***** Impresion_Online. *****\n"
	                   "%s\n** pid : [ %8ld ] **\n"
	                   "************************\n",
	         cfnGetTime(1),pid );
	sts = ifnValidaParametros   (argc,argv
	                            ,szOraAccount
	                            ,szOraPasswd
	                            ,&iLogLevel
	                            ,szCodModGener);
	                            
	 vDTrazasLog(modulo, "\n%s[%ld] << Retorno ifnValidaParametros : %d >>"
	 			,LOG03, cfnGetTime(1),pid,sts);                           
	                            
	if ( sts != 0 ) return sts;


	sts = ifnAbreArchivosLog    (iLogLevel, szCodModGener);
	if ( sts != 0 ) return sts;

	vDTrazasLog(modulo, "\n%s[%ld] << Inicia  Ejecucion >>", LOG03, cfnGetTime(1),pid);
	sprintf(szCodModGenerGlobal,"%s",szCodModGener); /* SAAM-20030805 */

	sts = ifnImpresionOnline  (szOraAccount
	                            ,szOraPasswd
	                            ,iLogLevel
	                            ,szCodModGener);

	vDTrazasLog(modulo, "%s[%ld] << Termina Ejecucion >>", LOG03, cfnGetTime(1),pid);

	fprintf(stdout,"\n");
	return sts;

} /* main */




/* ****************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o append archivos de Log y de Errores */
/* ****************************************************************************** */
int ifnAbreArchivosLog(int iLogLevel, char *szCodModGener)
{
	char modulo[]="ifnAbreArchivosLog";

	char *pathDir;
	char szArchivo  [32]    ="";
	char szPath     [128]   ="";
	char szComando  [128]   ="";

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"New_ImpresionOnline_%s", szCodModGener); 


	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/New_ImpresionOnline/%s",pathDir,cfnGetTime(2)); /* '....log/New_ImpresionOnline/YYYYMMDD/' */
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	stStatus.LogNivel = iLogLevel;

	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;    }

	vDTrazasError(modulo, "\n%s[%ld] << Abre Archivo de Errores >>", LOG04, cfnGetTime(1),pid);

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;    }

        vDTrazasLog(modulo, "\n\n%s\tVersion [%s] con fecha [%s]\n", LOG03, __FILE__, szVersionActual,szUltimaModificacion);

	vDTrazasLog(modulo, "\n%s[%ld] << Abre Archivo de Log >>", LOG04, cfnGetTime(1),pid);

	return 0; /* Validacion ok */
}

int  iShellEjecucion(char *szLineaComando,char *szNombreLog)
{
	char modulo[]="iShellEjecucion";

	char *pathDir;
	char szArchivo  [128]    ="";
	char szArchivoCompleto  [256]    ="";
	char szPath     [128]   ="";
	char szComando  [128]   ="";
	char szRaya		[51]	="";

	strcpy (szRaya , "--------------------------------------------------");
	
	vDTrazasLog(modulo, "\n\t%s\n\t%s\n",LOG04,modulo,szRaya);

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"New_ImpresionOnline_%s_%s.ksh",szCodModGenerGlobal,cfnGetTime(5)); 

	pathDir=szGetEnv("XPF_KSH");
	

	sprintf(szArchivoCompleto,"%s/%s",pathDir,szArchivo);
	
/* HB-200311180185 20040107  Se libera Malloc  */
	free(pathDir);	
	vDTrazasLog(modulo, "\tCrea Archivo Ksh : %s", LOG04, szArchivoCompleto);

	if((fpShell = fopen(szArchivoCompleto,"w")) == (FILE*)NULL ){
		vDTrazasLog(modulo, "\t<< No pudo crearse el archivo de shell %s \n\t%s\n>>",LOG04,szArchivoCompleto,szRaya);
		vDTrazasError(modulo,"\t<< No pudo crearse el archivo de shell %s >>",LOG04,szArchivoCompleto);
		return (1);
	}

	fprintf(fpShell,"echo '\tEjecución de Comando : %s' >> %s 2>&1\n", szLineaComando, szNombreLog); 
	fprintf(fpShell,"echo '+++++++++++++++++++++++++'`date`'+++++++++++++++++++++++++' >> %s 2>&1\n",szNombreLog); 
	fprintf(fpShell,"%s >> %s 2>&1\n", szLineaComando, szNombreLog); 
	fprintf(fpShell,"echo ' ' >> %s 2>&1\n", szNombreLog); 
	fprintf(fpShell,"echo ' ' >> %s 2>&1\n", szNombreLog); 
	fprintf(fpShell,"echo '+++++++++++++++++++++++++'`date`'+++++++++++++++++++++++++' >> %s 2>&1\n",szNombreLog); 
	fprintf(fpShell,"echo '\tFin de Ejecución de Comando' >> %s 2>&1\n", szNombreLog); 

	fclose(fpShell);

	sprintf(szComando,"/usr/bin/chmod 777 %s", szArchivoCompleto);
	vDTrazasLog(modulo, "\tComando : %s",LOG04,szComando);

	if (system (szComando))
	{
		vDTrazasLog(modulo,"\t<< Fallo en cambios de permisos del Archivo [%s] >>"
        				   "\n\t<< Error Numero: %d     %s >>"
						   "\n\t%s\n",LOG04,szArchivoCompleto,errno,strerror(errno),szRaya);
		vDTrazasError(modulo,"\t<< Fallo en cambios de permisos del Archivo [%s] >>"
        					 "\n\t<< Error Numero: %d     %s >>"
        					 ,LOG04,szArchivoCompleto,errno,strerror(errno));
        return (1);
    	}

	memset(szComando,'\0',sizeof(szComando));

	sprintf(szComando,"%s", szArchivoCompleto);
	vDTrazasLog(modulo, "\tComando : %s",LOG04,szArchivoCompleto);

	if (system (szComando))
	{
		vDTrazasLog(modulo, "\t<< Fallo en la ejecucion de [%s] >>"
        					"\n\t<< Error Numero: %d     %s >>\n\t%s"
        					,LOG04,szComando,errno,strerror(errno),szRaya);
    	vDTrazasError(modulo,"\t<< Fallo en la ejecucion de [%s] >>"
        					 "\n\t<< Error Numero: %d     %s >>"
        					 ,LOG04,szComando,errno,strerror(errno));
	            return (1);
    	}

	memset(szComando,'\0',sizeof(szComando));
	
	sprintf(szComando,"rm -f %s", szArchivoCompleto);
	
	vDTrazasLog(modulo, "\tComando : %s",LOG04,szComando);

	if (system (szComando))
	{
		vDTrazasLog(modulo, "\tFallo en el borrado de shell [%s]"
        					"\t<< Error Numero: %d     %s >>\n\t%s\n"
        					,LOG04,szArchivo,errno,strerror(errno),szRaya);
		vDTrazasError(modulo,"\tFallo en el borrado de shell [%s]"
        					 "\t<< Error Numero: %d     %s >>"
        					 ,LOG04,szArchivo,errno,strerror(errno));
                return (1);
   	}
	
	vDTrazasLog(modulo, "\t%s\n",LOG04,szRaya);
	return (0); /* Validacion ok */
}


/* **************************************************************************** */
/* ifnImpresionOnline()                                                       */
/* **************************************************************************** */
int ifnImpresionOnline( char  *szAccount
                    	, char  *szPasswd
                    	, int   iLogLevel
                    	, char  *szCodModGener)
{
	char    modulo      []  ="ImpresionOnline";

	 int    iCont           =0;
	 int    iStatusFin      =iESTAQUEUE_WAIT;

	char    szUsuario   [64]="";
	char    szAux       [16]="";
	char    *psztmp         ="";
	 int    num_rows        =0;
	 int    tnumrows        =0;
    BOOL    bNotFound       =FALSE;
    
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		 int ihCodEstProc           =0  ;
		 int ihIngrOk               =0  ;
		 int ihCodEstaDocEnt            ;
		 int ihNumDeltaHoras            ;
		 int ihCodNivLog                ;
                char szhNomUsuarOra     [32]    ;
                char szhPasUsuarOra     [32]    ;
		char szhCodModGener     [4]     ;
		 int ihCodProceso               ;
	    	reg_FaInterFact ha_FaInterFact  ;
	/* EXEC SQL END DECLARE SECTION; */ 


    ihIngrOk = iESTAPROC_TERMINADO_OK ;

	strcpy (szhNomUsuarOra  ,szAccount);
	strcpy (szhPasUsuarOra  ,szPasswd);
	strcpy (szhCodModGener  ,szCodModGener);
	        ihCodNivLog     =iLogLevel;
	        ihCodProceso    =iPROCESO_INT_IMPRESION_ONLINE; 	/* 330 */

    memset(szUsuario,0,sizeof(szUsuario));

	if ( (psztmp=(char *)strstr(szhNomUsuarOra,"\\$") )!=(char *)NULL )
	{
		sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
	}
	else if ((psztmp=(char *)strchr(szhNomUsuarOra,'$') )!=(char *)NULL )
	{
		memset(szAux,0,sizeof(szAux));
		strncpy (szAux,szhNomUsuarOra,psztmp-szhNomUsuarOra);
		sprintf (szUsuario,"%s\\%s/%s",szAux,psztmp,szhPasUsuarOra);
	}
	else
	{
		sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
	}

	vDTrazasLog (modulo,"%s Usuario : [%s] "
	            ,LOG04, cfnGetTime(1),szUsuario);

	if (!fnOraConnect(szAccount,szPasswd))
	{	vDTrazasError   (modulo, "%s No Hay Conexion a la Base de Datos"
	                    ,LOG01,cfnGetTime(3));
		return -10;	}

	vDTrazasLog (modulo,"%s[%ld] Conectado a la Base de Datos"
	            ,LOG04, cfnGetTime(1),pid);

    /***********************/
    /* Fa_IntQueueProc RAO */
    /***********************/
    vDTrazasLog(modulo,"%s[%ld] Obtencion datos cola  ", LOG04, cfnGetTime(1),pid);
    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
    strcpy( stIntQueueProc.szCodModGener , szCodModGener);
            stIntQueueProc.lCodProceso   = iPROCESO_INT_IMPRESION_ONLINE;
    strcpy(stIntQueueProc.szCodAplic, "FAC");  /* Agregado por Pgonzaleg 28-01-2002 */
    
    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
		return -14;
	}
    ihNumDeltaHoras = stIntQueueProc.iNumDeltaHoras ;
    ihCodEstaDocEnt	= stIntQueueProc.iCodEstaDocEnt ;

	vDTrazasLog (modulo,"%s[%ld] Preparando Cursor sobre FA_INTERFACT "
			    " CodModGener [%s]\n"
			    " CodEstadoc  [%d]\n"
			    " CodEstProc  [%d]\n"
	            ,LOG04, cfnGetTime(1),pid,szhCodModGener,ihCodEstaDocEnt,ihIngrOk);

	/* EXEC SQL DECLARE Cur_FaInterFact CURSOR FOR
			 SELECT NUM_PROCESO     ,
				COD_TIPMOVIMIEN , 
				COD_TIPDOCUM
			   FROM FA_INTERFACT
			  WHERE COD_MODGENER = :szhCodModGener    /o 'DAF' o/
			    AND COD_ESTADOC  = :ihCodEstaDocEnt   /o Ingresadao/
			    AND COD_ESTPROC  = :ihIngrOk          /o terminada Ok o/
			    AND COD_APLIC    = 'FAC' /o Agregado por Pgonzaleg 31-01-2002 o/
/o                         AND FEC_INGRESO  < (SYSDATE - (:ihNumDeltaHoras / 24))   o/  /o para la impresion no se considerara tiempo o/
			  /oFOR UPDATEo/; */ 

		
	if (SQLCODE)
	{	
	    vDTrazasError(modulo,"Al declarar Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -14;	
	}


	/* EXEC SQL OPEN Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
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
 sqlstm.sqhstv[2] = (unsigned char  *)&ihIngrOk;
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



	if (SQLCODE)
	{	
	    vDTrazasError(modulo,"Al Abrir Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -15;	
	}

	vDTrazasLog(modulo,"%s[%ld] Recorriendo Cursor y formando Comandos ", LOG04, cfnGetTime(1),pid);

	for (;;)
	{
	    memset(&ha_FaInterFact,0,sizeof(reg_FaInterFact));
	    
		/* EXEC SQL FETCH Cur_FaInterFact
			      INTO :ha_FaInterFact; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 3;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1000;
  sqlstm.offset = (unsigned int  )32;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)ha_FaInterFact.lNumProceso;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)ha_FaInterFact.iCodTipMovimien;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )sizeof(int);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)ha_FaInterFact.iCodTipDocumento;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
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


			      
        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND && SQLCODE != SNAPSHOT)
	    {	
            vDTrazasLog (modulo,"%s %ld Error Oracle ",LOG01, cfnGetTime(1),SQLCODE);
            
            if (!bfnCambiaEstCola(szhCodModGener, ihCodProceso, iESTAQUEUE_RUNNING, iESTAQUEUE_ERROR, "FAC" ))
	            vDTrazasError(modulo,"Al declarar Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
	        else
	        {
			    if (!bfnOraCommit())
				{
		    	    vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
					if (!fnOraRollBackRelease())
			    	    vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				    return -11;
				}
            }
		    return -14;
		    	
        }
        
        if (SQLCODE == SQLNOTFOUND) 
            bNotFound=TRUE;

        num_rows=sqlca.sqlerrd[2] - tnumrows;
        tnumrows = tnumrows + num_rows;
	    vDTrazasLog (modulo,"%s %d Cantidad de Filas ",LOG04, cfnGetTime(1),num_rows);

        if (num_rows>0 && SQLCODE != SNAPSHOT)
        {
            if (!bfnEjeComando  ( num_rows
                                , szUsuario
                                , ihCodNivLog
                                , ha_FaInterFact
                                , stIntQueueProc.iCodEstaDocSal ) )
            {
			    vDTrazasLog (modulo,"Entre al if",LOG04);
			    if (!bfnCambiaEstCola   (szhCodModGener
			                            , ihCodProceso
			                            , iESTAQUEUE_RUNNING
			                            , iESTAQUEUE_ERROR 
			                            , "FAC" ))
				{
				    if (!fnOraRollBackRelease())
					    vDTrazasError   (modulo,"En Rollback release\n\t%s\n",LOG01, sqlca.sqlerrm.sqlerrmc);
					return -11;
    			}
	    		else
				{
					if (!bfnOraCommit())
					{
		    		    vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
						if (!fnOraRollBackRelease())
			    			vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				    	return -11;
					}
			    }
    			return -19;
    			
    		}
    		else
    		{
                vDTrazasLog (modulo,"Entre al else",LOG04);
                if (!bfnOraCommit())
				{
		    	    vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
					if (!fnOraRollBackRelease())
			    	    vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				    return -11;
				}
				else
				    vDTrazasLog (modulo,"COMMIT correcto ",LOG04);
				
            }    		    
    		    
    	}
        if (bNotFound)
		{
			break;
		}

    } /* end for */

    vDTrazasLog (modulo,"%s %d Total de Filas procesadas",LOG03, cfnGetTime(1),tnumrows);

	vDTrazasLog(modulo,"%s[%ld] Cerrando Cursor ", LOG04, cfnGetTime(1),pid);

	/* EXEC SQL CLOSE Cur_FaInterFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )59;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode)
	{	
	    vDTrazasError(modulo,"Al cerrar el Cursor\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -17;	
	}


	if (!bfnCambiaEstCola(szhCodModGener, ihCodProceso, iESTAQUEUE_RUNNING,  iESTAQUEUE_WAIT, "FAC" ))
	{
		if (!fnOraRollBackRelease())
	    	vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
	    return -11;
	}
	else
	{	if (!bfnOraCommit())
		{	
		    vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			if (!fnOraRollBackRelease())
	    		vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			return -11;
		}
	}
	

} /* ImpresionOnline() */



/* ******************************************************************************************** */
/* ifnValidaParametros ()                                                                       */
/*												*/
/* ******************************************************************************************** */
int ifnValidaParametros (   int     argc            ,
                            char    *argv[]         ,
                            char    *szOraAccount   ,
                            char    *szOraPasswd    ,
                            int     *iLogLevel      ,
                            char    *szCodModGener  )

{
	char modulo[]="ifnValidaParametros";

	extern char     *optarg;
	extern int      optind, opterr, optopt;
	char            opt         []  = ":u:l:e:";
	int             iOpt=0,ihCodProc;
	char            *psztmp         = "";
	char            szUser      [64]= "";

	int             Userflag        =FALSE;
	int             Logflag         =FALSE;
	int             Modflag         =FALSE;

	char            szAccount   [32]="";
	char            szPasswd    [32]="";

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
					*iLogLevel=atoi(optarg);
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

			case '?':
				fprintf(stdout,"\n\t<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
				return -3;

			case ':':
				fprintf(stdout,"\n\t<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
				return -4;

		}/* endswitch */

	} /* enwhile */


	if  (   Modflag==FALSE
	    ||  Logflag==FALSE)
	{
		fprintf (stderr,"\n\t<< Error : falta opcion '-%c' >>\n%s\n",optopt,szUsage);
		return -1;
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

	return 0; /* Validacion ok */

} /* ifnValidaParamatros */



/********************************************************/
/*  Compone y ejecuta el comando de Impresion           */
/********************************************************/
BOOL bfnEjeComando  (int num_rows
                    ,char *pszUsuario
                    ,int ihCodNivLog
                    ,reg_FaInterFact ha_FaInterFact
                    ,int iCodEstaDocSal)
{
    char     modulo[]       ="bfnEjeComando";
    char     szComando [128]="";
     int     x;
     int     iIngrPrc       =iESTAPROC_PROCESANDO;      
   INTERFACT stInterFact;
   
    for (x=0;x<num_rows;x++)
    {
        memset(&stInterFact,0,sizeof(INTERFACT));
        stInterFact.lNumProceso     = ha_FaInterFact.lNumProceso    [x];
        strcpy(stInterFact.szCodAplic,"FAC"); /* Agregado por Pgonzaleg 28-01-2002 */
        
        if (!bfnGetInterFact(&stInterFact))
        {
            vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            return FALSE;
        }
    	vDTrazasLog (modulo,"%s Usuario : [%s] "
	            ,LOG04, cfnGetTime(1),pszUsuario);


        sprintf(szComando,"%s %ld %d \0","ksh ImpresionSclOnline.ksh", stInterFact.lNumProceso, ha_FaInterFact.iCodTipDocumento[x]); 

	   
        
        
	/**********************************************************************************************/
	/* Marca FA_INTERFACT como procesando							  */
        /**************************************************************************************************/
        stInterFact.iCodEstaDoc     =   iCodEstaDocSal;
        stInterFact.iCodEstaProc    =   iIngrPrc;
	    strcpy(stInterFact.szCodAplic,"FAC");  /* Agregado por Pgonzaleg 28-01-2002 */
	
        /*
        if (!bfnUpdInterFact(stInterFact))
        {
            vDTrazasError(szExeName,"Error en marca de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error en marca de FA_INTERFACT [%ld] [%s]"
                         ,LOG01,SQLCODE,szfnORAerror());
            return FALSE;
        }
        else
        {
            if (!bfnOraCommit())
			{
		        vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				if (!fnOraRollBackRelease())
			        vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				return -11;
		         }
	    }
        */
        
	    if (iShellEjecucion(szComando,stStatus.LogName)!=0)
	    {
	    	vDTrazasError (modulo,"%s[%ld] Falló Comando:[ %s ]" ,LOG03,cfnGetTime(1),pid,szComando);
		return FALSE;
	    }
   }
    
    return TRUE;
 
}

