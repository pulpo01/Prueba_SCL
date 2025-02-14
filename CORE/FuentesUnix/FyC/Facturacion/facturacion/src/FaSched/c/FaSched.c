
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
           char  filnam[16];
};
static struct sqlcxp sqlfpn =
{
    15,
    "./pc/FaSched.pc"
};


static unsigned int sqlctx = 1723467;


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
   unsigned char  *sqhstv[22];
   unsigned long  sqhstl[22];
            int   sqhsts[22];
            short *sqindv[22];
            int   sqinds[22];
   unsigned long  sqharm[22];
   unsigned long  *sqharc[22];
   unsigned short  sqadto[22];
   unsigned short  sqtdso[22];
} sqlstm = {12,22};

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
"select COD_MODGENER ,COD_PROCESO ,NVL(COD_TIPPROC,'O') ,COD_ACTIVACION ,COD_\
PRIORIDAD ,COD_ESTADO ,FEC_ESTADO ,NVL(PID_PROCESO,0) ,NVL(NOM_USUARIO,' ') ,N\
VL(PAS_USUARIO,' ') ,NVL(COD_NIVLOG,3) ,COD_TIPINTERVALO ,NVL(NUM_SEGUNDOS,(-1\
)) ,NVL(COD_HORADIA,'-1') ,NVL(COD_HORAFECH,sysdate) ,NVL(COD_HORAVIGINI,'-1')\
 ,NVL(COD_HORAVIGFIN,'-1') ,NVL(NUM_DELTAHORAS,0) ,NVL(COD_TIPUNINTER,0) ,COD_\
ESTADOC_ENT ,COD_ESTADOC_SAL ,COD_APLIC  from FA_INTQUEUEPROC where ((COD_ACTI\
VACION='A' and COD_ESTADO=1) and TO_CHAR(sysdate,'HH24:MI:SS') between COD_HOR\
AVIGINI and COD_HORAVIGFIN)           ";

 static char *sq0008 = 
"select COD_MODGENER ,COD_PROCESO ,COD_APLIC ,PID_PROCESO ,COD_ESTADO ,NVL(NO\
M_USUARIO,' ') ,NVL(PAS_USUARIO,' ') ,NVL(COD_NIVLOG,3)  from FA_INTQUEUEPROC \
where COD_ESTADO in (2,3)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,54,0,1,353,0,0,0,0,0,1,0,
20,0,0,2,582,0,9,395,0,0,0,0,0,1,0,
35,0,0,2,0,0,13,414,0,0,22,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
138,0,0,2,0,0,15,439,0,0,0,0,0,1,0,
153,0,0,3,111,0,4,572,0,0,3,1,0,1,0,1,97,0,0,2,3,0,0,2,97,0,0,
180,0,0,4,184,0,4,602,0,0,7,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,
223,0,0,5,48,0,4,727,0,0,1,0,0,1,0,2,97,0,0,
242,0,0,6,60,0,5,766,0,0,1,1,0,1,0,1,3,0,0,
261,0,0,7,90,0,4,845,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,97,0,0,
288,0,0,8,190,0,9,896,0,0,0,0,0,1,0,
303,0,0,8,0,0,13,908,0,0,8,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,
350,0,0,8,0,0,15,975,0,0,0,0,0,1,0,
};


/* ***************************************************************************/
/*            "FaSched.pc"                                                   */
/*       30 de Noviembre de 1999                                             */
/*        Roy Barrera Richards                                               */
/*                                                                           */
/*           Modificaciones                                                  */
/*13-Diciembre-1999 : Se crea Administrador de Colas.                        */
/*19-Enero-2000 : Trabajo sobre archivo Log.                                 */
/*              Defino Log por defecto 3                                     */
/*                Disminuyo el tamaño cuando es LOG03                        */
/*               Cada nuevo día genera nuevo directorio y archivo de Log     */
/*****************************************************************************/
/*****************************************************************************/
/* ***************************************************************************/
/* *    Incorporacion de un nuevo parametro en la llamada                  * */
/* *            a las sgte funcion:                                        * */
/* *        bfnCambiaEstCola                                               * */
/* *    Patricio Gonzalez G.    01-02-2002                                 * */
/* ************************************************************************* */
/* ************************************************************************* */
/* * Se corrige el uso de cod_aplic en duro, al uso parámetrico del mismo. * */
/* *  FAedo. 07/03/2002                                                    * */
/* ************************************************************************* */
/*****************************************************************************/

#include "FaSched.h"

#include <errno.h>
#include <sys/types.h>
#include <sys/wait.h>
				
				
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
char szHoyDia[9]="";

/* 20041013 CH-200409082192 Se declaran funciones nuevas */
int  iVerificaColasEnEjecucion();
int szBuscaExe(int, char *, char *);
int iBuscaProceso(char *);
char *ltrim(char *);
char *rtrim(char *);
char *alltrim(char *);

/* ******************************************************************************** */
/* main : Rutina principal */
/* ******************************************************************************** */
int main(int argc,char *argv[])
{
    char modulo[]="main";

    int  sts;
    char szOraAccount[32]="";
    char szOraPasswd[32]="";
    char status[16]="";

    pid=getpid();
    strcpy(szHoyDia,cfnGetTime(2)); /* YYYYMMDD */

    fprintf( stdout, "\n******* FaSched version " __DATE__ " " __TIME__ ". *******\n%s\n** pid : [ %8ld ] **\n************************\n",
             cfnGetTime(1),pid );

    sts = ifnValidaParametros(argc,argv,szOraAccount, szOraPasswd);


    if ( sts != 0 ) return sts;

    sts = ifnAbreArchivosLog();


    if ( sts != 0 ) return sts;


    sts = ifnCicloColasProc(szOraAccount,szOraPasswd);
    if ( sts != 0 )
    {   sprintf(status,"Anormal [%d]",sts);     }
    else
    {   sprintf(status,"Controlado");   }

    vDTrazasError(modulo,"%s[%ld] << Termino %s del FaSched  version " __DATE__ " " __TIME__ ">>\n", LOG03, cfnGetTime(1),pid,status);
    vDTrazasLog  (modulo,"%s[%ld] << Termino %s del FaSched  version " __DATE__ " " __TIME__ ">>\n", LOG03, cfnGetTime(1),pid,status);
    fprintf(stdout,"\n");
    return sts;

} /* main */


/* ******************************************************************************** */
/* ifnValidaParametro : verifica los parametros de la invocacion  */
/* ******************************************************************************** */
int ifnValidaParametros ( int argc, char *argv[], char *szOraAccount, char *szOraPasswd)
{
    char modulo[]="ifnValidaParametros";

    extern char *optarg;
    extern int optind, opterr, optopt;
    char opt[] = ":u:l:h";
    int iOpt=0,ihCodProc;
    char *psztmp = "";
    char szUser [64] = "";

    int  Userflag=FALSE;
    int  Logflag=FALSE;

    char szAccount[32]="";
    char szPasswd[32]="";

    opterr=0;

    stStatus.LogNivel=0;  /* 19-Enero-2000 */

    if(argc == 1)
    {
        stStatus.LogNivel=LOGDEFAULT;
        fprintf (stdout,"\n%s Iniciando FaSched con valores por defecto ( -u/ -l%d )\n"
                       ,cfnGetTime(1),stStatus.LogNivel);
        return 0;/* validacion ok */
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
                    stStatus.LogNivel = atoi(optarg);
                    Logflag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return -2;
                }
                break;

            case 'h':
                fprintf (stdout,"\n<< Ayuda >>\n%s\n",szUsage);
                return -1;

            case '?':
                fprintf(stdout,"\n<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
                return -3;

            case ':':
                fprintf(stdout,"\n<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
                return -4;

        }/* endswitch */

    } /* enwhile */


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

    if (stStatus.LogNivel <= 0) stStatus.LogNivel = LOGDEFAULT;

    return 0; /* Validacion ok */

} /* ifnValidaParamatros */


/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog()
{
    char modulo[]="ifnAbreArchivosLog";

    char *pathDir;
    char szArchivo[32]="";
    char szPath[256]="";
    char szComando[128]="";

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"FaSched"); /* 'FaSched' */

/*     pathDir=(char *)malloc(128);  */
    pathDir=szGetEnv("XPF_LOG");
    sprintf(szPath,"%s/FaSched/%s",pathDir,cfnGetTime(2)); /* '....log/FaSched/YYYYMMDD/' */
    free(pathDir);

    fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

    sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	
/* 20041012 CH-200409082192 Se cierra antes de volver abrir */
	if(stStatus.ErrFile!=NULL)
		fclose(stStatus.ErrFile);

    if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return -7;    }

    vDTrazasError(modulo, "\n*** FaSched version " __DATE__ " " __TIME__ "***\n\n%s [%ld] << Abre Archivo de Errores >>\n", LOG04, cfnGetTime(1),pid);

    sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
/* 20041012 CH-200409082192 Se cierra antes de volver abrir */
	if(stStatus.LogFile!=NULL)
		fclose(stStatus.LogFile);
    if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return -8;    }

    vDTrazasLog(modulo, "\n*** FaSched version " __DATE__ " " __TIME__ "***\n\n%s[%ld] << Abre Archivo de Log >>", LOG04, cfnGetTime(1),pid);
    vDTrazasLog(modulo, "%s[%ld] << Inicio del FaSched >>" , LOG03, cfnGetTime(1),pid);

    return 0;
}


/* ******************************************************************************** */
/* ifnCicloColasProc : Se conecta y trabaja sobre la base de Datos */
/* ******************************************************************************** */
int ifnCicloColasProc( char *szOraAccount, char *szOraPasswd)
{
    char modulo[]="ifnCicloColasProc";

     int num_elem,sts,i;
    rg_fa_intqueueproc  stFaIntQueueProc;

    vDTrazasLog(modulo,"\n*** FaSched version " __DATE__ " " __TIME__ "***\n\nUsuario : [%s]\n",LOG03,szOraAccount);
    vDTrazasLog(modulo,"Pass    : [%s]\n",LOG03,szOraPasswd);

    if (!fnOraConnect(szOraAccount,szOraPasswd))
    {   vDTrazasError(modulo, "%s No Hay Conexion a la Base de Datos", LOG01,cfnGetTime(3));
        return -10; }

    vDTrazasLog(modulo,"%s[%ld] Conectado...", LOG03, cfnGetTime(3),pid);

    sts=ifnVerificaEstadoScheduler();
    if (sts < 0)      return -12;   /* Error */
    else if(sts == 0) return -13;   /* FaSched desactivado antes de comenzar */

    if (!bfnRegistraEjecucionActual())
    {
        if (!fnOraRollBackRelease())
            vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                          LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        return -14;
    }
    else
    {   if (!fnOraCommit())
        {   vDTrazasError(modulo,"%s En Commit\n%s\n",
                        LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
            if (!fnOraRollBackRelease())
                vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                              LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
            return -15;
        }
    }

    while(1)
    {

        sts=ifnVerificaEstadoScheduler();
        if (sts < 0)
        {
            return -16;
        }
        else if(sts == 0)
        {
            return 0;   /* 0: FaSched desactivado durante la ejecucion */
        }


        if (strcmp(cfnGetTime(2),szHoyDia)>0) /* 19-Enero-2000 */
        {
            fprintf(stderr,"\n entro a if \n");

            strcpy(szHoyDia,cfnGetTime(2));
            vDTrazasLog     ( modulo , "\n*** FaSched version " __DATE__ " " __TIME__ "***\n\n%s[%ld] - Fin del Dia - << Cerrando Archivo de Log >> "
                        , LOG03, cfnGetTime(1),pid);
            fclose(stStatus.LogFile);
            vDTrazasError   ( modulo , "\n*** FaSched version " __DATE__ " " __TIME__ "***\n\n%s[%ld] - Fin del Dia - << Cerrando Archivo de Errores >> "
                            , LOG03, cfnGetTime(1),pid);
            fclose(stStatus.ErrFile);
            if ( ifnAbreArchivosLog() != 0 ) return -17; /* Fallo Cambio Dia */
        }

        num_elem=ifnCargaHostArray(&stFaIntQueueProc);

        if (num_elem < 0)  /* contiene el código del error producido */
        {
            vDTrazasError(modulo,"%s Al Cargar Host Array [%d]\n",LOG01, cfnGetTime(3),num_elem );
            return num_elem ;
        }
        else if (num_elem > 0)
        {
            if (ifnRecorreHostArray(num_elem,&stFaIntQueueProc) < 0)
            {
                return -18;
            }
        }
		sleep(15);
		iVerificaColasEnEjecucion();
    }

    return 0;

} /* ifnAcessoOracle */



/* ********************************************************************* */
/* funcion ifnCargaHostArray() */
/* ********************************************************************* */
int ifnCargaHostArray(rg_fa_intqueueproc *pstFaIntQueueProc)
{
    char modulo[40]="ifnCargaHostArray";
    int i,n=0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        rg_fa_intqueueproc  sthFaIntQueueProc;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( modulo,"%s[%ld] Recuperando colas ..."
                , LOG04, cfnGetTime(3),pid);


    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'yyyymmddhh24miss'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /* EXEC SQL DECLARE Cursor_FaIntQueueProc CURSOR FOR
    SELECT  COD_MODGENER                ,
        COD_PROCESO                 ,
        NVL(COD_TIPPROC             ,'O'),
        COD_ACTIVACION              ,
        COD_PRIORIDAD               ,
        COD_ESTADO                  ,
        FEC_ESTADO                  ,
        NVL(PID_PROCESO     ,0)     ,
        NVL(NOM_USUARIO     ,' ')   ,
        NVL(PAS_USUARIO     ,' ')   ,
        NVL(COD_NIVLOG      ,3)     ,
        COD_TIPINTERVALO            ,
        NVL(NUM_SEGUNDOS    ,-1)    ,
        NVL(COD_HORADIA     ,'-1')  ,
        NVL(COD_HORAFECH,sysdate)   ,
        NVL(COD_HORAVIGINI  ,'-1')  ,
        NVL(COD_HORAVIGFIN  ,'-1')  ,
        NVL(NUM_DELTAHORAS  ,0)     ,
                NVL(COD_TIPUNINTER  ,0)     ,
                COD_ESTADOC_ENT             ,
                COD_ESTADOC_SAL             ,
                COD_APLIC
      FROM  FA_INTQUEUEPROC
     WHERE  COD_ACTIVACION  = 'A'
       AND  COD_ESTADO      = 1    /o wait o/
       AND  TO_CHAR(sysdate,'HH24:MI:SS')  between COD_HORAVIGINI and COD_HORAVIGFIN ; */ 


    if (sqlca.sqlcode)
    {
        vDTrazasError(modulo,"%s Al declarar cursor sobre FA_INTQUEUEPROC\n%s\n",
                        LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);

        if (!fnOraRollBackRelease())
            vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                          LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);

        return -20;
    }

    /* EXEC SQL OPEN Cursor_FaIntQueueProc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)
    {
        vDTrazasError(modulo,"%s Al abrir cursor sobre FA_INTQUEUEPROC\n%s\n",
                      LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);

        if (!fnOraRollBackRelease())
            vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                          LOG01, cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);

        return -21;
    }

    memset(&sthFaIntQueueProc,0,sizeof(sthFaIntQueueProc));

    while(1)
    {

        /* EXEC SQL FETCH Cursor_FaIntQueueProc
        INTO :sthFaIntQueueProc; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 22;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )100;
        sqlstm.offset = (unsigned int  )35;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)sthFaIntQueueProc.szCodModGener;
        sqlstm.sqhstl[0] = (unsigned long )4;
        sqlstm.sqhsts[0] = (         int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)sthFaIntQueueProc.iCodProceso;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )sizeof(int);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)sthFaIntQueueProc.szCodTipProc;
        sqlstm.sqhstl[2] = (unsigned long )2;
        sqlstm.sqhsts[2] = (         int  )2;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)sthFaIntQueueProc.szCodActivacion;
        sqlstm.sqhstl[3] = (unsigned long )2;
        sqlstm.sqhsts[3] = (         int  )2;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)sthFaIntQueueProc.iCodPrioridad;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)sthFaIntQueueProc.iCodEstado;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )sizeof(int);
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)sthFaIntQueueProc.szFecEstado;
        sqlstm.sqhstl[6] = (unsigned long )15;
        sqlstm.sqhsts[6] = (         int  )15;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)sthFaIntQueueProc.lPidProceso;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )sizeof(long);
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)sthFaIntQueueProc.szNomUsuarOra;
        sqlstm.sqhstl[8] = (unsigned long )31;
        sqlstm.sqhsts[8] = (         int  )31;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)sthFaIntQueueProc.szPasUsuarOra;
        sqlstm.sqhstl[9] = (unsigned long )31;
        sqlstm.sqhsts[9] = (         int  )31;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)sthFaIntQueueProc.iCodNivLog;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )sizeof(int);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)sthFaIntQueueProc.iCodTipIntervalo;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[11] = (         int  )sizeof(int);
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)sthFaIntQueueProc.lNumSegundos;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[12] = (         int  )sizeof(int);
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)sthFaIntQueueProc.szCodHoraDia;
        sqlstm.sqhstl[13] = (unsigned long )9;
        sqlstm.sqhsts[13] = (         int  )9;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)sthFaIntQueueProc.szCodHoraFech;
        sqlstm.sqhstl[14] = (unsigned long )15;
        sqlstm.sqhsts[14] = (         int  )15;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)sthFaIntQueueProc.szCodHoraVigIni;
        sqlstm.sqhstl[15] = (unsigned long )9;
        sqlstm.sqhsts[15] = (         int  )9;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)sthFaIntQueueProc.szCodHoraVigFin;
        sqlstm.sqhstl[16] = (unsigned long )9;
        sqlstm.sqhsts[16] = (         int  )9;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)sthFaIntQueueProc.iNumDeltaHoras;
        sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[17] = (         int  )sizeof(int);
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqharc[17] = (unsigned long  *)0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)sthFaIntQueueProc.iCodTipUnInter;
        sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[18] = (         int  )sizeof(int);
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqharc[18] = (unsigned long  *)0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)sthFaIntQueueProc.iCodEstaDocEnt;
        sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[19] = (         int  )sizeof(int);
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqharc[19] = (unsigned long  *)0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)sthFaIntQueueProc.iCodEstaDocSal;
        sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[20] = (         int  )sizeof(int);
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqharc[20] = (unsigned long  *)0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)sthFaIntQueueProc.szCodAplic;
        sqlstm.sqhstl[21] = (unsigned long )4;
        sqlstm.sqhsts[21] = (         int  )4;
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqharc[21] = (unsigned long  *)0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
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



        n = sqlca.sqlerrd[2];

        /* Revisar el tema de pisarse los antes leidos */
        /*vDTrazasError(modulo,"sqlca.sqlcode [%d], SQLNOTFOUND [%d]\n",LOG05,sqlca.sqlcode,SQLNOTFOUND);*/

        if(sqlca.sqlcode == SQLNOTFOUND )
        {
            break;
        }
        else if(sqlca.sqlcode < 0)
        {
            vDTrazasError(modulo,"%s en el Fetch sobre FA_INTQUEUEPROC\n%s\n",
                            LOG01, cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);

            if (!fnOraRollBackRelease())
                vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                              LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
            return -22;
        }
    }/* end while */


    /* EXEC SQL CLOSE Cursor_FaIntQueueProc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )138;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {
        vDTrazasError(modulo,"%s al cerrar el cursor sobre sobre FA_INTQUEUEPROC\n%s\n",
                      LOG01, cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);

        if (!fnOraRollBackRelease())
                vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                              LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
        return -23;
    }

    if(n != 0)
    {
        *pstFaIntQueueProc = sthFaIntQueueProc;
    }

    return n ; /* Cantidad de Filas recuperadas */
}

/* ************************************************************************************** */
/* ifnRecorreHostArray( ) */
/* ************************************************************************************** */
int ifnRecorreHostArray(int NumElem, rg_fa_intqueueproc *pstFaIntQueueProc)
{
    char modulo[]="ifnRecorreHostArray";
     int i,iCont,iAux,ExeFlag=FALSE;
    char szComando      [1024]   ="" ;
    char szCmdShell		[128];
    char szModGene      [4]     ="" ;
    char szTipProc      [2]     ="" ;
     int iCodProc               =0  ;
    char szDia          [12]        ;
    char szHora         [10]        ;
    char szUsuario      [64]    ="" ;
    char szNomUsuarOra  [32]    ="" ;
    char szPasUsuarOra  [32]    ="" ;
    int iNumMinRunning          = 0 ;
    char *psztmp                    ;
    char szAux          [16]    ="" ;
    double dDifEjec             = 0 ;
    long lTiempo                = 0 ;
    char szUniInt       [10]        ;
    char szCodAplic     [4]         ;
	int ret;


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhN_Segundos=0,lhN_SegundosUlt=0;
         int ihIntervalo=0, ihDias=0, ihDiasUlt=0;
        long lhSegsDia=86400; /* cantidad de segundos que tiene un dia */
        char szhUltimaVez[15];
        char szhSiguienteVez[15];
        char szhHoraEjec[9],szhAhora[9];
        char szhExeComando[31];
         int ihCodProceso   =0;
         int ihLogLevel     =3;
         int ihNumMinRunning=0;
         int  iCodEstado;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(modulo,"%s[%ld] Encontradas %d colas...",
                LOG04, cfnGetTime(3),pid,NumElem);


    for (i=0; i<NumElem; i++)
    {
        strcpy(szModGene, pstFaIntQueueProc->szCodModGener  [i]);
        strcpy(szTipProc, pstFaIntQueueProc->szCodTipProc   [i]);
        strcpy(szCodAplic,pstFaIntQueueProc->szCodAplic     [i]);
        iCodProc        = pstFaIntQueueProc->iCodProceso    [i] ;
        ihCodProceso    = iCodProc;
        ihLogLevel      = pstFaIntQueueProc->iCodNivLog     [i] ;

        strcpy(szhUltimaVez,pstFaIntQueueProc->szFecEstado  [i]);   /* ultima vez que se ejecuto */

 vDTrazasLog(modulo,"%s[%ld] Cola %d [%s_%d_%s] pid %ld estado [%d] ",
                                LOG03, cfnGetTime(3),pid, i+1, szModGene, iCodProc, szCodAplic, pstFaIntQueueProc->lPidProceso[i], pstFaIntQueueProc->iCodEstado[i]);
								
        if (!bfnGetDifUltEjec (szhUltimaVez,&dDifEjec ))
            return -66;

        vDTrazasLog(modulo,"%s diferencia de la ultima ejecucion %f",LOG05, cfnGetTime(3),dDifEjec);

        ExeFlag=FALSE;
        switch (pstFaIntQueueProc->iCodTipIntervalo[i])
        {
            case SEGUNDOS:

                    ihIntervalo = pstFaIntQueueProc->lNumSegundos [i];

                    if      (pstFaIntQueueProc->iCodTipUnInter[i] == 1)  /* Segundos */
                    {
                        lTiempo=  dDifEjec * lhSegsDia;
                        strcpy(szUniInt,    "Segundos");
                    }
                    else if (pstFaIntQueueProc->iCodTipUnInter[i] == 2)  /* minutos  */
                    {
                        lTiempo=  dDifEjec * 1440;
                        strcpy(szUniInt,    "Minutos");
                    }
                    else if (pstFaIntQueueProc->iCodTipUnInter[i] == 3)  /* horas    */
                    {
                        lTiempo=  dDifEjec * 24;
                        strcpy(szUniInt,    "Horas");
                    }
                    else if (pstFaIntQueueProc->iCodTipUnInter[i] == 4)  /* Dias     */
                    {
                        lTiempo=  dDifEjec;
                        strcpy(szUniInt,    "Dias");
                    }
                    else                                                /* Se mantiene por defecto segundos */
                    {
                        lTiempo=  dDifEjec * lhSegsDia;
                        strcpy(szUniInt, "Segundos");
                    }
                    vDTrazasLog(modulo,"%s[%ld] Cola %d [%s_%d_%s] Se activa cada [%d] %s [%d] ",
                                LOG05, cfnGetTime(3),pid, i+1, szModGene, iCodProc, szTipProc, ihIntervalo,szUniInt,pstFaIntQueueProc->iCodTipUnInter[i]);

                    if ( lTiempo >= ihIntervalo )
                    {
                        ExeFlag = TRUE;
                    }

                    break;

            case HORAESPEC:

                    strcpy(szhHoraEjec,pstFaIntQueueProc->szCodHoraDia[i]);

                    vDTrazasLog(modulo,"%s[%ld] Cola %d [%s_%d_%s] Se activa diariamente a las [%s] ",
                                LOG04, cfnGetTime(3),pid, i+1,szModGene, iCodProc, szTipProc, szhHoraEjec);

                    /* EXEC SQL
                        SELECT TRUNC(SYSDATE - TO_DATE (:szhUltimaVez,'yyyymmddhh24miss')),
                                    (TO_CHAR(SYSDATE,'hh24:mi:ss'))
                               INTO :ihDias,
                                    :szhAhora
                               FROM DUAL; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 22;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select TRUNC((SYSDATE-TO_DATE(:b0,'yyyymm\
ddhh24miss'))) ,TO_CHAR(SYSDATE,'hh24:mi:ss') into :b1,:b2  from DUAL ";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )153;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhUltimaVez;
                    sqlstm.sqhstl[0] = (unsigned long )15;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)&ihDias;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhAhora;
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



                    if ( ihDias > 0  && strcmp(szhAhora,szhHoraEjec) >= 0 )
                    {
                        ExeFlag = TRUE;
                    }

                    break;

            case DIAHORAESPEC:

                    strcpy(szhSiguienteVez,pstFaIntQueueProc->szCodHoraFech[i]);/* la proxima vez que se debe ejecutar */

                    strncpy(&szDia[0],&szhSiguienteVez[6],2);  szDia[2]='/';
                    strncpy(&szDia[3],&szhSiguienteVez[4],2);  szDia[5]='/';
                    strncpy(&szDia[6],&szhSiguienteVez[0],4);

                    strncpy(&szHora[0],&szhSiguienteVez[8],2);  szHora[2]=':';
                    strncpy(&szHora[3],&szhSiguienteVez[10],2); szHora[5]=':';
                    strncpy(&szHora[6],&szhSiguienteVez[12],2);


                    vDTrazasLog(modulo,"%s[%ld] Cola %d [%s_%d_%s] Se activa solamente el [%s] a las [%s] ",
                                LOG04, cfnGetTime(3),pid, i+1, szModGene, iCodProc, szTipProc,szDia,szHora);

                    /* EXEC SQL
                        SELECT (SYSDATE - TO_DATE(:szhSiguienteVez,'yyyymmddhh24miss'))*:lhSegsDia,
                                    TRUNC(SYSDATE - TO_DATE (:szhSiguienteVez,'yyyymmddhh24miss')),
                                    TRUNC(SYSDATE - TO_DATE (:szhUltimaVez,'yyyymmddhh24miss'))
                               INTO :lhN_Segundos,
                                    :ihDias,
                                    :ihDiasUlt
                               FROM DUAL; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 22;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select ((SYSDATE-TO_DATE(:b0,'yyyymmddhh2\
4miss'))* :b1) ,TRUNC((SYSDATE-TO_DATE(:b0,'yyyymmddhh24miss'))) ,TRUNC((SYSDA\
TE-TO_DATE(:b3,'yyyymmddhh24miss'))) into :b4,:b5,:b6  from DUAL ";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )180;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhSiguienteVez;
                    sqlstm.sqhstl[0] = (unsigned long )15;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)&lhSegsDia;
                    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhSiguienteVez;
                    sqlstm.sqhstl[2] = (unsigned long )15;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhUltimaVez;
                    sqlstm.sqhstl[3] = (unsigned long )15;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)&lhN_Segundos;
                    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[4] = (         int  )0;
                    sqlstm.sqindv[4] = (         short *)0;
                    sqlstm.sqinds[4] = (         int  )0;
                    sqlstm.sqharm[4] = (unsigned long )0;
                    sqlstm.sqadto[4] = (unsigned short )0;
                    sqlstm.sqtdso[4] = (unsigned short )0;
                    sqlstm.sqhstv[5] = (unsigned char  *)&ihDias;
                    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
                    sqlstm.sqhsts[5] = (         int  )0;
                    sqlstm.sqindv[5] = (         short *)0;
                    sqlstm.sqinds[5] = (         int  )0;
                    sqlstm.sqharm[5] = (unsigned long )0;
                    sqlstm.sqadto[5] = (unsigned short )0;
                    sqlstm.sqtdso[5] = (unsigned short )0;
                    sqlstm.sqhstv[6] = (unsigned char  *)&ihDiasUlt;
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



                    if ( (lhN_Segundos >= 0  && ihDias == 0) && ihDiasUlt > 0 )
                    {
                        ExeFlag = TRUE;
                    }

                    break;

            default :

                    break;

        }


        if (ExeFlag == TRUE)
        {
            vDTrazasLog (modulo,"%s[%ld] Cambiando estado de la cola  ",
                         LOG04, cfnGetTime(3));
            if (! bfnCambiaEstCola( szModGene, iCodProc, iESTAQUEUE_WAIT, iESTAQUEUE_INIT, szCodAplic))
            /* Incorporado por PGonzaleg 01-02-2002 */
            /* Corregido por FAedo. 07-03-02        */
            {
                if (!fnOraRollBackRelease())
                    vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                                  LOG01, cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
                return -25;
            }
            else
            {
                if (!fnOraCommit())
                {   vDTrazasError(modulo,"%s En Commit\n%s\n",
                                  LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                    if (!fnOraRollBackRelease())
                        vDTrazasError(modulo,"%s En Rollback release\n%s\n",
                                      LOG01, cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
                    return -26;
                }
            }


            /**** Usuario ****/
            memset(szUsuario,'\0',sizeof(szUsuario));

            strcpy(szNomUsuarOra,pstFaIntQueueProc->szNomUsuarOra[i]);
            strcpy(szPasUsuarOra,pstFaIntQueueProc->szPasUsuarOra[i]);

            iAux = strlen(szNomUsuarOra) - 1;
            while ((szNomUsuarOra[iAux]==' ') && (iAux>=0))
            {  szNomUsuarOra[iAux]='\0';
               iAux--; }

            iAux = strlen(szPasUsuarOra) - 1;
            while ((szPasUsuarOra[iAux]==' ') && (iAux>=0))
            {  szPasUsuarOra[iAux]='\0';
               iAux--; }


            if ( (psztmp=(char *)strstr(szNomUsuarOra,"\\$") )!=(char *)NULL )
            {
                sprintf(szUsuario,"%s/%s",szNomUsuarOra,szPasUsuarOra);
            }
            else if ((psztmp=(char *)strchr(szNomUsuarOra,'$') )!=(char *)NULL )
            {
                memset(szAux,0,sizeof(szAux));
                strncpy (szAux,szNomUsuarOra,psztmp-szNomUsuarOra);
                sprintf (szUsuario,"%s\\%s/%s",szAux,psztmp,szPasUsuarOra);
            }
            else
            {
                sprintf(szUsuario,"%s/%s",szNomUsuarOra,szPasUsuarOra);
            }

            /* comando de ejecucion de Colas */
            memset(szComando,0,sizeof(szComando));
            strcpy(szhExeComando,"New_QueueAdmin");

  /* parametrizar la invocacion de los Queue.... despues en tablas de colas */


/*             sprintf(szComando,"nohup %s -e%s -p%d -t%s -u%s -l%d -c%s > /dev/null 2>&1 &",  */
/*                               szhExeComando, szModGene, iCodProc, szTipProc, szUsuario, ihLogLevel, szCodAplic);  */
			sprintf(szCmdShell,"%s_%d_%s_%d_%s.ksh",szhExeComando,pid, szModGene, iCodProc, szCodAplic );
/*             sprintf(szComando,"echo \"nohup %s -e%s -p%d -t%s -u%s -l%d -c%s >> %s.out 2>&1 &\nsleep 5\n\" > %s;chmod 777 %s",  */
	        sprintf(szComando,"echo \"%s -e%s -p%d -t%s -u%s -l%d -c%s 1>> %s.out 2>>%s.err \nsleep 1\n\" > %s;chmod 777 %s",
        			szhExeComando, szModGene, iCodProc, szTipProc, szUsuario, ihLogLevel, szCodAplic,szhExeComando,szhExeComando, szCmdShell, szCmdShell);
			
			ret=system(szComando);

			vDTrazasLog(modulo,"**** %s[%ld] Activando Cola %d [%s] con [%s] ret=%d",LOG03, cfnGetTime(3),pid, i+1,szCmdShell, szComando, ret);

			ret=misystem(szCmdShell);
			
			vDTrazasLog(modulo,"**** %s[%ld] Ejecute [%s] ret=%d",LOG03, cfnGetTime(3),pid, szCmdShell, ret);
			sleep(1);
			unlink(szCmdShell);

        }
        ExeFlag = FALSE;
    } /* endfor */
    sleep(1);
    vDTrazasLog ( modulo,"%s[%ld] Fin Colas. ", LOG04, cfnGetTime(3),pid);
    return 0;
}

/* ******************************************************************************** */
/* ifnVerificaEstadoScheduler :  */
/* ******************************************************************************** */
int ifnVerificaEstadoScheduler()
{
    char modulo[]="bfnVerificaEstadoScheduler";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCodEstado[2];
    /* EXEC SQL END DECLARE SECTION; */ 



    /* EXEC SQL SELECT COD_ESTSCHED
               INTO :szhCodEstado
               FROM FA_SCHEDULER; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ESTSCHED into :b0  from FA_SCHEDULER ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )223;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstado;
    sqlstm.sqhstl[0] = (unsigned long )2;
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




    if (sqlca.sqlcode)
    {
        vDTrazasError(modulo,"%s Al recuperar estado del FaSched\n%s\n",
                        LOG01,cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
        vDTrazasLog (modulo,"%s Al recuperar estado del FaSched\n%s\n",
                        LOG01,cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
        return -1;
    }


    if (szhCodEstado[0]!='A')
        return 0;


    return 1;

}


/* ******************************************************************************** */
/* bfnRegistraEjecucionActual :  */
/* ******************************************************************************** */
BOOL bfnRegistraEjecucionActual()
{
    char modulo[40];
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhPidProc;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhPidProc = pid;

    strcpy(modulo,"bfnRegistraEjecucionActual");


    /* EXEC SQL UPDATE FA_SCHEDULER
                SET PID_PROCESO = :lhPidProc,
                    FEC_PROCESO = SYSDATE ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 22;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_SCHEDULER  set PID_PROCESO=:b0,FEC_PROCESO=SYSD\
ATE";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )242;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhPidProc;
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



    if (sqlca.sqlcode)
    {
        vDTrazasError(modulo,"%s Al Actualizar FA_Scheduler\n%s\n",
                        LOG01,cfnGetTime(3),sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

    return TRUE;

}

/* 20041013 CH-200409082192 Funciones nuevas */
#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) ) return(NULL);
    while( *p<=32 && *p>1 ) p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) ) return(NULL);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )  p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}


int iBuscaProceso(char *szComando)
{
	char cmd[99];
	char buf[BUFSIZ];
	FILE *ptr;
	int cnt=0;
	
	/* ps -fea|grep -w FaSched|grep -v grep */
	sprintf(cmd, "ps -fea|grep -w '%s'|grep -v grep",szComando);
	if ((ptr = popen(cmd, "r")) != NULL)
	{
			while (fgets(buf, BUFSIZ, ptr) != NULL)
			{
				cnt++;
			}
	}
	pclose(ptr);
	return(cnt);
}

int szBuscaExe(int iCodProceso, char *szCodAplic, char *szComandoExe)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int  ihCodProceso ;
	char szhCodAplic[4];
	char szhExeComando[31];
/* EXEC SQL END DECLARE SECTION; */ 


	ihCodProceso=iCodProceso;
	strcpy(szhCodAplic, szCodAplic);

	/* EXEC SQL SELECT EXE_COMANDO
			   INTO :szhExeComando
			   FROM FA_INTPROCESOS
			   WHERE COD_PROCESO = :ihCodProceso
			   AND COD_APLIC = :szhCodAplic; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select EXE_COMANDO into :b0  from FA_INTPROCESOS where (COD_\
PROCESO=:b1 and COD_APLIC=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )261;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhExeComando;
 sqlstm.sqhstl[0] = (unsigned long )31;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodAplic;
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


			   
  	if (SQLCODE)
	{	
		return(FALSE);	
	}
	strcpy(szComandoExe, alltrim(szhExeComando)); 
	return(TRUE);
}

/* ********************************************************************************************************** */
/* iVerificaColasEnEjecucion : verifica que las colas de procesos no queden en estado de ejecucion eternamente  */
/* ********************************************************************************************************** */

int iVerificaColasEnEjecucion()
{
	char modulo[]="iVerificaColasEnEjecucion";
	int ret=0, iAux;
    char szUsuario      [65]    ="" ;
    char szAux          [32]    ="" ;
    char szComando      [128]   ="" ;
    char *psztmp                    ;
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szCod_ModGener[4];
	int  ihCodProceso ;
	char szhCodAplic[4];
	long lhPidProceso;
	int iCodEstado; 
	int iNivelLog; 
	char szComandoExe[32];
    char szNomUsuarOra  [32]    ="" ;
    char szPasUsuarOra  [32]    ="" ;
	
/* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL DECLARE Cur_FaInQueueProc CURSOR for
	SELECT COD_MODGENER, COD_PROCESO, COD_APLIC, PID_PROCESO, COD_ESTADO, NVL(NOM_USUARIO,' '), NVL(PAS_USUARIO,' '), NVL(COD_NIVLOG,3)
	FROM FA_INTQUEUEPROC
	WHERE COD_ESTADO   IN (2,3)  ; */ 
/* Estado Corriendo (INICIADO y RUNNING) */
       
  	if (SQLCODE)
	{	
	    vDTrazasError(modulo,"Al declarar Cursor Cur_FaInQueueProc\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return(-14);	
	}

	/* EXEC SQL OPEN Cur_FaInQueueProc ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )288;
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
	    vDTrazasError(modulo,"Al Abrir Cursor Cur_FaInQueueProc\n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return(-15);	
	}

	while (SQLCODE == SQLOK)
	{
		ret=TRUE;
		
	    /* EXEC SQL FETCH Cur_FaInQueueProc INTO  :szCod_ModGener, :ihCodProceso, :szhCodAplic, :lhPidProceso, iCodEstado, :szNomUsuarOra, :szPasUsuarOra, :iNivelLog ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 22;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )303;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szCod_ModGener;
     sqlstm.sqhstl[0] = (unsigned long )4;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCodAplic;
     sqlstm.sqhstl[2] = (unsigned long )4;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&lhPidProceso;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&iCodEstado;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szNomUsuarOra;
     sqlstm.sqhstl[5] = (unsigned long )32;
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szPasUsuarOra;
     sqlstm.sqhstl[6] = (unsigned long )32;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&iNivelLog;
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



		if (SQLCODE == SQLOK )
		{	
			if(!szBuscaExe(ihCodProceso, szhCodAplic, szComandoExe))
			{
				vDTrazasError(modulo,"Al Buscar Nombre a Aplicacion para %d %s\n\t%s\n",LOG01,ihCodProceso, szhCodAplic, sqlca.sqlerrm.sqlerrmc);
			}


			memset(szUsuario,'\0',sizeof(szUsuario));

			iAux = strlen(szNomUsuarOra) - 1;
			while ((szNomUsuarOra[iAux]==' ') && (iAux>=0))
			{  szNomUsuarOra[iAux]='\0';
			   iAux--; }

			iAux = strlen(szPasUsuarOra) - 1;
			while ((szPasUsuarOra[iAux]==' ') && (iAux>=0))
			{  szPasUsuarOra[iAux]='\0';
			   iAux--; }

			if ( (psztmp=(char *)strstr(szNomUsuarOra,"\\$") )!=(char *)NULL )
			{
				sprintf(szUsuario,"%s/%s",szNomUsuarOra,szPasUsuarOra);
			}
			else if ((psztmp=(char *)strchr(szNomUsuarOra,'$') )!=(char *)NULL )
			{
				memset(szAux,0,sizeof(szAux));
				strncpy (szAux,szNomUsuarOra,psztmp-szNomUsuarOra);
				sprintf (szUsuario,"%s\\%s/%s",szAux,psztmp,szPasUsuarOra);
			}
			else
			{
				sprintf(szUsuario,"%s/%s",szNomUsuarOra,szPasUsuarOra);
			}
															    
			sprintf(szComando,"%s -u%s -l%d -e%s", szComandoExe, szUsuario, iNivelLog, szCod_ModGener);
			
			vDTrazasLog(modulo,"%s[%ld] Verificando %s %d %s %d [%s]", LOG03, cfnGetTime(1),pid,szCod_ModGener,ihCodProceso, szhCodAplic, lhPidProceso,szComando);
			
			if((ret=iBuscaProceso(szComando)) == FALSE)
			{
				if (!bfnCambiaEstCola(szCod_ModGener, ihCodProceso, iCodEstado, iESTAQUEUE_WAIT, szhCodAplic ))
				{
					vDTrazasError(modulo,"Al inicializar estado de la cola a WAIT en iVerificaColasEnEjecucion Pid %d\n\t%s\n",LOG01,pid, sqlca.sqlerrm.sqlerrmc);
				}
				else if(!bfnOraCommit())
				{
					vDTrazasError(modulo,"En Commit - iVerificaColasEnEjecucion Pid 0 \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
					if (!fnOraRollBackRelease())
					{
						vDTrazasError(modulo,"En Rollback release iVerificaColasEnEjecucion Pid %d\n\t%s\n", LOG01, pid, sqlca.sqlerrm.sqlerrmc);
					}
				}
				else
				{
					vDTrazasLog(modulo,"%s[%ld] cola %s %d %s %d Reseteado de %d a %d\n", LOG03, cfnGetTime(1),pid,szCod_ModGener,ihCodProceso, szhCodAplic, lhPidProceso, iCodEstado, iESTAQUEUE_WAIT );
				}
			}
			else
			{
				vDTrazasLog(modulo,"*** Proceso [%s] ejecutado %d Veces ***\n", LOG03, szComandoExe, ret);
			}
			
		}
	}
	/* EXEC SQL CLOSE Cur_FaInQueueProc ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 22;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )350;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  return(0); /* Validacion ok */

} /* iVerificaColasEnEjecucion */


int misystem(char *cmd)
{
    char modulo[]="misystem";
	pid_t ppid1, ppid2=-99; /* Process ID of the child process */
	pid_t wpid;	/* Process ID from wait() */
	pid_t lpid;	/* Local Process ID  */
	pid_t hpid;	/* Hijo Process ID  */
	int status;	/* Exit status from wait() */

	fflush(stdout); fflush(stderr);			   
	
	lpid=(long)getpid(); 	 
	
	signal(SIGCHLD, SIG_IGN);
	signal(SA_NOCLDWAIT, SIG_IGN);

	if( (ppid1 = fork()) == -1 )
	{
		vDTrazasLog(modulo,"%s[%ld]\t ERROR %s: Failed to fork()... ADIOS !\n",LOG05,cfnGetTime(3),pid, strerror(errno));
		return(-1);
	}
	else if( ppid1 == 0 )
	{
			status=execlp(cmd, cmd, NULL);
			vDTrazasLog(modulo,"%s[%ld]\t PID %ld: %s PID %ld  hpid=%d status=%d\n", LOG05,cfnGetTime(3),pid,
				   lpid, cmd, (long)ppid1, hpid, status);
			
			vDTrazasLog(modulo,"%s[%ld]\t Voy a MORIR mipid=%d!.\n", LOG05,cfnGetTime(3),pid,lpid);
			sleep(1);
			exit(0);
	}
	do
	{
		wpid = wait(&status);
		vDTrazasLog(modulo,"%s[%ld]\t wait ret : wpid=%d apid=%d status=%d ppid1=%d!\n",LOG05,cfnGetTime(3),pid, wpid, getpid(),status, ppid1);
	} while( wpid != -1 && wpid != ppid1 );
	
	vDTrazasLog(modulo,"%s[%ld]\t lpid=%ld ppid1=%d ppid2=%d wpid=%d hpid=%d\n",LOG05,cfnGetTime(3),pid, lpid,ppid1,ppid2,wpid,hpid);
	if( wpid == -1 )
	{
		/* * The wait() call failed : */
		vDTrazasLog(modulo,"%s[%ld]\t ERROR %s: wait(%d) errno=%d ... !\n",LOG05,cfnGetTime(3),pid,strerror(errno), status, errno);
	}
	else if( wpid != ppid1 )
	{
		/* Should never happen in this program: */
		vDTrazasLog(modulo,"%s[%ld]\t Termino ejecucion de %s  (lpid=%ld ppid1=%d ppid2=%d wpid=%d hpid=%d)...  ADIOS !.\n", LOG05,cfnGetTime(3),pid,cmd,lpid,ppid1,ppid2,wpid,hpid);
		exit(0);
	}
	
	if( WIFEXITED(status) )
	{
		vDTrazasLog(modulo,"%s[%ld]\t %s salio = %d !\n",LOG05,cfnGetTime(3),pid,cmd, WEXITSTATUS(status));
	}
	else if( WIFSIGNALED(status) )
	{
		vDTrazasLog(modulo,"%s[%ld]\t Signal: %d%s\n",LOG05,cfnGetTime(3),pid,
			   WTERMSIG(status),
			   WCOREDUMP(status) ? " with core file." : ".");
	}
	else
	{
		vDTrazasLog(modulo,"%s[%ld]\t Stopped child process status=%d.", LOG05,cfnGetTime(3),pid,status);
	}
	
	if (pid != lpid || pid != getpid())
	{
		vDTrazasLog(modulo,"%s[%ld]\t No tengo nada que hacer, me suicido %d!=%d (%d) (lpid=%ld ppid1=%d ppid2=%d wpid=%d hpid=%d).\n", LOG05,cfnGetTime(3),pid,pid,lpid, getpid(),lpid,ppid1,ppid2,wpid,hpid);
		exit(0);
	}
	signal(SIGCHLD, SIG_DFL);
	signal(SA_NOCLDWAIT, SIG_DFL);
	
	return(0);
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
