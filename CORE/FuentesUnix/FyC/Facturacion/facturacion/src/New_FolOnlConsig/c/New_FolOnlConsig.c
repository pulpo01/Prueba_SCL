
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
           char  filnam[25];
};
static struct sqlcxp sqlfpn =
{
    24,
    "./pc/New_FolOnlConsig.pc"
};


static unsigned int sqlctx = 886405315;


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
   unsigned char  *sqhstv[6];
   unsigned long  sqhstl[6];
            int   sqhsts[6];
            short *sqindv[6];
            int   sqinds[6];
   unsigned long  sqharm[6];
   unsigned long  *sqharc[6];
   unsigned short  sqadto[6];
   unsigned short  sqtdso[6];
} sqlstm = {12,6};

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
"select INT.NUM_PROCESO  from FA_TIPDOCUMEN DOC ,FA_INTERFACT INT where (((((\
((INT.COD_MODGENER=:b0 and INT.COD_ESTADOC=:b1) and INT.COD_ESTPROC=:b2) and I\
NT.COD_APLIC='FAC') and (INT.NUM_FOLIO=0 or INT.NUM_FOLIO is null )) and INT.C\
OD_TIPDOCUM=DOC.COD_TIPDOCUMMOV) and (DOC.COD_TIPDOCUM=:b3 or DOC.COD_TIPDOCUM\
=:b4)) and INT.FEC_IMPRESION<(SYSDATE-(:b5/24))) order by INT.NUM_PROCESO     \
       ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,395,0,9,474,0,0,6,6,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,
44,0,0,1,0,0,13,514,0,0,1,0,0,1,0,2,3,0,0,
63,0,0,2,67,0,5,629,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
86,0,0,3,55,0,4,714,0,0,1,0,0,1,0,2,3,0,0,
105,0,0,4,53,0,4,744,0,0,1,0,0,1,0,2,3,0,0,
124,0,0,1,0,0,15,784,0,0,0,0,0,1,0,
};


/* *********************************************************************** */
/* *  Fichero : New_FolOnlConsig.pc                                      * */
/* *  Foliacion ONLINE de Documentos  en Consignacion                    * */
/* *  Autor    : Roy Barrera R.                                          * */
/* *  Complice : Mauricio Villagra V.                                    * */
/* *********************************************************************** */
/* *    11-05-2001                                                       * */
/* *                                                                     * */
/* *********************************************************************** */
/************************************************************************* */
/* *********************************************************************** */
/* *	Incorporacion del campo COD_APLIC en las llamadas 		 * */
/* *			a las sgtes. funciones:				 * */
/* *		bfnGetInterFact		bfnGetIntQueueProc		 * */
/* *		bfnUpdInterFact 	bfnCambiaEstCola		 * */		
/* *	Patricio Gonzalez G.	31-01-2002			         * */
/* *********************************************************************** */
/***************************************************************************/


#define _FOLIACION_CONSIG_PC_

#include "deftypes.h"
#include "New_Interfact.h"
#include "New_FolOnlConsig.h"


/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/
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

long pid=0;

int iRegVer;
int iRegFol;
/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/
int main(int argc, char *argv[])
{
    char modulo[]="main";

    pid =getpid();

    fprintf( stdout, "\n\t***** Foliacion OnLine Consignacion *****\n"
                     "\t**%s**\n\t**** pid : [ %8ld ]  ****"
                     "\n\t*****************************************\n",
                     cfnGetTime(1),pid );

    memset(&stLineaComando,0,sizeof(FOLIACIONLINEACOMANDO));
    memset(&stStatus,'\0',sizeof(STATUS));

    if (!bfnValidaParametros(argc,argv,&stLineaComando)) return 1;


    if(!bfnConnectORA(stLineaComando.szOraAccount,stLineaComando.szOraPasswd))
    {
        vDTrazasError(modulo, "<< Usuario/Password Invalido >>", LOG01);
        return 2;
    }
    else
    {
        vDTrazasLog(modulo, "\n\t-------------------------------------------------------"
                            "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                            "\n\t-------------------------------------------------------",
                            LOG04,stLineaComando.szOraAccount);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))     return 3;

    if (!bfnAbreArchivos(&stLineaComando,szSysDate))    return 4;

    if(!bfnFoliacionOnline(&stLineaComando))
    {
        vDTrazasError(modulo, " \n\t------------------------------------"
                              " \n\tProceso Terminado de Forma Irregular"
                              " \n\t------------------------------------"
                              ,LOG01);
        vDTrazasLog  (modulo, " \n\t------------------------------------"
                              " \n\tProceso Terminado de Forma Irregular"
                              " \n\t------------------------------------"
                              ,LOG01);
        return 5;
    }
    else
    {
        vDTrazasLog  (modulo, " \n\t------------------------------------"
                              " \n\tProceso Terminado Correctamente"
                              " \n\t------------------------------------"
                              ,LOG04);

        if (!bfnOraCommit())
        {
            vDTrazasLog  (modulo, " \n\t------------------------------------"
                                  " \n\tFallo en el Commit"
                                  " \n\t------------------------------------"
                                  ,LOG01);
            vDTrazasError(modulo, " \n\t------------------------------------"
                                  " \n\tFallo en el Commit"
                                  " \n\t------------------------------------"
                                  ,LOG01);
            return 6;
        }
    }

    if(bfnDisconnectORA(0))
    {
      vDTrazasLog  (modulo, "\n\t--------------------------------------------"
                            "\n\tDesconectado de  ORACLE"
                            "\n\t--------------------------------------------"
                            ,LOG04);
    }

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);

    return 0;

} /* Main */


/* ************************************************************************* */
/* * Funcion bfnValidaParametros                                           * */
/* ************************************************************************* */
/* * Realiza la validacion de los Parametros de Entrada                    * */
/* ************************************************************************* */
BOOL bfnValidaParametros( int argc, char *argv[], FOLIACIONLINEACOMANDO *pstLineaCom )
{
           char modulo[]="bfnValidaParametros";

    extern char *optarg;
    extern  int optind, opterr, optopt;

           char opt[] = ":u:l:e:";
            int iOpt=0;

           char *psztmp = "";

            int Userflag=FALSE;
            int Logflag=FALSE;
            int MGenflag=FALSE;


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG05,modulo);

    opterr=0;

    if(argc == 1)
    {
        fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
        return FALSE;
    }

    while ( (iOpt = getopt(argc, argv, opt) ) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                if(Userflag==FALSE)
                {
                    strcpy(pstLineaCom->szUsuarioOra, optarg);
                    Userflag=TRUE;
                    vDTrazasLog (modulo, " -u %s ", LOG03, pstLineaCom->szUsuarioOra);
                }
                else
                {
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return FALSE;
                }
                break;

            case 'l':
                if(Logflag==FALSE)
                {
                    stStatus.LogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=TRUE;
                }
                else
                {
                    /* vDTrazasError (modulo,"\n\t<< Opcion '-%c' duplicada >>\n%s\n",LOG01,optopt,szUsage); */
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return FALSE;
                }
                break;

            case 'e':
                if(MGenflag==FALSE)
                {
                    strcpy(pstLineaCom->szCodModGener, optarg);
                    MGenflag=TRUE;
                }
                else
                {
                    /*vDTrazasError (modulo,"\n\t<< Opcion '-%c' duplicada >>\n%s\n",LOG01,optopt,szUsage);*/
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return FALSE;
                }
                break;

            case '?':
                fprintf (stderr,"\n\t<< Error : opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
                return FALSE;
                /*break;*/

            case ':':
                fprintf (stderr,"\n\t<< Error : Falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
                return FALSE;
                /*break;*/

        }

    }


    if(Logflag==FALSE)
    {
       stStatus.LogNivel = iLOGNIVEL_DEF ; /* asume nivel de log por defecto */
       vDTrazasLog ( modulo, "Log : -l %d (default)", LOG03, stStatus.LogNivel );
    }

    pstLineaCom->iNivLog=stStatus.LogNivel ;

    if(MGenflag==FALSE)
    {
        /*vDTrazasError (modulo,"\n\t<< Falta definir opcion '-e' >>\n%s\n",LOG01,szUsage);*/
        fprintf (stderr,"\n\t<< Error : Falta definir opcion '-e' >>\n%s\n",szUsage);
        return FALSE;
    }

    if(Userflag==TRUE)
    {
        if ( (psztmp=(char *)strstr(pstLineaCom->szUsuarioOra,"/"))==(char *)NULL)
        {
            /*vDTrazasError (modulo,"\n\t<< Usuario Oracle no valido. Requiere '/' >>\n%s\n",LOG01,szUsage);*/
            fprintf (stderr,"\n\t<< Error : Usuario Oracle no valido. Requiere '/' >>\n%s\n",szUsage);
            return FALSE;
        }
        else
        {
            strncpy (pstLineaCom->szOraAccount,pstLineaCom->szUsuarioOra,psztmp-pstLineaCom->szUsuarioOra);
            strcpy  (pstLineaCom->szOraPasswd, psztmp+1)                 ;
        }
    }

    return TRUE;

} /* bfnValidaParamatros */



/* ************************************************************************* */
/* * Funcion bfnAbreArchivos                                               * */
/* ************************************************************************* */
/* * Realiza la apertura de archivos de Logs y Errores                     * */
/* ************************************************************************* */
BOOL bfnAbreArchivos(FOLIACIONLINEACOMANDO *pstLineaCom, char *szDate)
{
    char modulo[]="bfnAbreArchivos";

    char    *szDirLogs               ;
    char    *szNomArchivo            ;
    char    szComando[1024] = ""     ;

    /*vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***", LOG05, modulo); */

    szDirLogs    = (char *)malloc(1024);
    szNomArchivo = (char *)malloc(128);


    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL) return FALSE;

    sprintf (pstLineaCom->szDirLogs,"%s/New_FolOnlConsig/%s",szDirLogs,cfnGetTime(2));
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

    fprintf (stdout, "\n\tCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01,szComando);
        return FALSE;
    }


    fprintf(stdout, "\n\tCrea Archivo Log/Err : New_FolOnlConsig_%s_%s\n\n",pstLineaCom->szCodModGener, szDate );

    sprintf(szNomArchivo,"%s/New_FolOnlConsig_%s",
                        pstLineaCom->szDirLogs,
                        pstLineaCom->szCodModGener);



    sprintf(stStatus.ErrName,"%s.err",szNomArchivo);
    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
        vDTrazasError(modulo,"*** No puede abrirse el fichero de error %s",LOG01, stStatus.ErrName);
        return FALSE;
    }

    sprintf(stStatus.LogName, "%s.log",szNomArchivo);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL)
    {
        vDTrazasError(modulo,"*** No puede abrirse el fichero de log %s",LOG01, stStatus.LogName);
        fclose(stStatus.ErrFile);
        return FALSE;
    }

    vDTrazasLog  (modulo,"\n\t*************************************"
                         "\n\t****        Log   Foliacion        **"
                         "\n\t*************************************"
                         ,LOG03);

    vDTrazasLog(modulo, "\n\t***  Parametro de Entrada Foliacion  ***"
                        "\n\t=> Usuario               [%s]"
                        "\n\t=> Password              [************]"
                        "\n\t=> Cod.ModGener          [%s]"
                        "\n\t=> Niv.Log               [%d]"
                        ,LOG05
                        ,pstLineaCom->szOraAccount
                        ,pstLineaCom->szCodModGener
                        ,pstLineaCom->iNivLog);

    return TRUE;

} /* bfnAbreArchivos */

/* ************************************************************************* */
/* * Funcion bfnFoliacionOnline                                            * */
/* ************************************************************************* */
/* * Realiza la asignacion de folios legales por tipo de dopcumento        * */
/* * por rangos de clientes segun el orden generado                        * */
/* ************************************************************************* */
BOOL bfnFoliacionOnline ( FOLIACIONLINEACOMANDO *pstLineaCom )
{
    char modulo[]="bfnFoliacionOnline";

    char    szFecha [20]    =   ""  ;   /*  Fecha de Sistema Para Update de Traza   */
    long    lFolioUpdate    = 0     ;   /*  Folio Asignado para Update              */
    int     iSql            = 0     ;   /*  Retorno de Fetch de Documentos          */
    BOOL    bFinCursor = FALSE      ;
    BOOL    bTerminoOK = TRUE       ;
    int     iCont = 0, iFol = 0     ;
    int     iStatusFin = iESTAQUEUE_WAIT; /* Estado de la cola de procesos */
    char    *szStatusFin            ;

    vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***"       , LOG05, modulo);
    vDTrazasLog ( modulo, "\t%s[%ld] Obtencion datos cola  ", LOG04, cfnGetTime(1),pid);

    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
    strcpy( stIntQueueProc.szCodModGener , pstLineaCom->szCodModGener);
            stIntQueueProc.lCodProceso   = iPROCESO_INT_FOLIACION_CONSIG;
    strcpy(stIntQueueProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
    
    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
		return FALSE;
	}
                                              /* TERM_OK */
    if (!bfnOpenInterfaz( stIntQueueProc , iESTAPROC_TERMINADO_OK))
    {
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        return FALSE;
    }

    vDTrazasError(modulo, " Fetch Cursor Interfact " ,LOG05);
    ifnFetchInterfaz(stIntQueueProc);

    vDTrazasLog  (modulo, "\tTotal de Registros Verificados : %d ", LOG03, iRegVer);
    vDTrazasLog  (modulo, "\tTotal de Registros Foliados    : %d ", LOG03, iRegFol);

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       /*return FALSE;*/
    }


    if (!bfnCambiaEstCola(pstLineaCom->szCodModGener, iPROCESO_INT_FOLIACION_CONSIG, iESTAQUEUE_RUNNING, iESTAQUEUE_WAIT, "FAC"))  /* Incorporado por PGonzaleg 31-01-2002*/
    {
        if (!fnOraRollBack())
            vDTrazasError(modulo,"En Rollback \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }
    else
    {   if (!fnOraCommit())
        {   vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
            if (!fnOraRollBack())
                vDTrazasError(modulo,"En Rollback \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
            return FALSE;
        }
    }

    szStatusFin = (bTerminoOK==TRUE)? "TRUE":(bTerminoOK==FALSE)?"FALSE":"???";
    vDTrazasLog  (modulo, "Terminando Foliacion Online con '%s'", LOG05,szStatusFin );

    return bTerminoOK;

}/* bfnFoliacionOnline */



/* ************************************************************************* */
/* * Funcion bfnOpenInterfaz                                               * */
/* ************************************************************************* */
/* * Crea y Abre un Cursor sobre los documentos a Foliar de FA_INTERFACT   * */
/* ************************************************************************* */
BOOL bfnOpenInterfaz(INTQUEUEPROC stIntQueueProc, int iCodEstProc)
{
    char modulo[]="bfnOpenInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCodModGener[4]="";
         int ihCodEstaDocEnt=0;
         int ihCodEstProc=0;
         int ihCodProceso=0;

         int ihNumDeltaHoras;
         int ihCodTipDocumConsig;
         int ihNotacreditoCons  ;
    /* EXEC SQL END DECLARE SECTION; */ 


            ihCodProceso        = iPROCESO_INT_FOLIACION_CONSIG ;
    strcpy( szhCodModGener      , stIntQueueProc.szCodModGener) ;
   	        ihCodEstaDocEnt     = stIntQueueProc.iCodEstaDocEnt ;
   	        ihCodEstProc        = iCodEstProc                   ;
   	        ihNumDeltaHoras     = stIntQueueProc.iNumDeltaHoras ;
            ihCodTipDocumConsig = stDatosGener.iCodConsignacion ;
            ihNotacreditoCons   = stDatosGener.iNCredConsignacion;

    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);


    vDTrazasLog(modulo,"\t%s [%ld] Preparando Cursor sobre FA_INTERFACT "
                        "\n\t\t=>CodModGener       [%s]"
                        "\n\t\t=>CodEstaDoc        [%d]"
                        "\n\t\t=>CodEstProc        [%d]"
                        "\n\t\t=>CodDocConsig      [%d]"
                        "\n\t\t=>ihNotacreditoCons [%d]"
                        "\n\t\t=>DeltaHoras        [%d]"
                        ,LOG03, cfnGetTime(1),pid
                        ,szhCodModGener
                        ,ihCodEstaDocEnt
                        ,ihCodEstProc
                        ,ihCodTipDocumConsig
                        ,ihNotacreditoCons
                        ,ihNumDeltaHoras    );

    /* EXEC SQL DECLARE  Cur_Interfaz  CURSOR FOR
            SELECT  INT.NUM_PROCESO
            FROM    FA_TIPDOCUMEN       DOC,
                    FA_INTERFACT        INT
            WHERE   INT.COD_MODGENER      = :szhCodModGener
            AND     INT.COD_ESTADOC       = :ihCodEstaDocEnt   		/o impresa o/
            AND     INT.COD_ESTPROC       = :ihCodEstProc      		/o ok o/
            AND     INT.COD_APLIC	  = 'FAC' 			/o Incorporado por PGonzaleg 31-01-2002 o/
            AND     (INT.NUM_FOLIO        = 0 OR INT.NUM_FOLIO IS NULL)
            AND     INT.COD_TIPDOCUM      = DOC.COD_TIPDOCUMMOV
            AND     (   DOC.COD_TIPDOCUM  = :ihCodTipDocumConsig
                     OR DOC.COD_TIPDOCUM  = :ihNotacreditoCons  )
            AND     INT.FEC_IMPRESION < (SYSDATE - (:ihNumDeltaHoras / 24))
            ORDER BY INT.NUM_PROCESO; */ 
  /* nuevo delta de tiempo */


    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "\n\t** En SQL-DECLARE Cur_Interfaz **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo , "\n\t**  En SQL-DECLARE Cur_Interfaz **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    /* EXEC SQL OPEN Cur_Interfaz ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstProc;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipDocumConsig;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihNotacreditoCons;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihNumDeltaHoras;
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



    vDTrazasLog (modulo,"\n\t*** SQL-OPEN CURSOR Cur_Interfaz SQLCODE : [%d] ***" ,LOG05,SQLCODE);

    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n\t\t=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/* bfnOpenInterfaz */



/* ************************************************************************* */
/* * Funcion ifnFetchInterfaz                                             * */
/* ************************************************************************* */
/* * Lee Un Registro de los documentos a Foliar                            * */
/* ************************************************************************* */
int ifnFetchInterfaz(INTQUEUEPROC stIntQueueProc)
{
    char    modulo[]="ifnFetchInterfaz";
    int     iNum_Rows;
    BOOL    bNotFound;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


       FOLIACIONREGINTERFAZ haRegIntFoliacion ;

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG05,modulo);

    for (;;)
    {
        memset(&haRegIntFoliacion,0,sizeof(FOLIACIONREGINTERFAZ));
        /* EXEC SQL FETCH Cur_Interfaz INTO
                   :haRegIntFoliacion; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )44;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)haRegIntFoliacion.lNumProceso;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
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



        vDTrazasError(modulo, "\n\tFETCH sobre CURSOR Cur_Interfaz [%d] " ,LOG05, SQLCODE);

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
            vDTrazasLog  (modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
            vDTrazasError(modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
            return SQLCODE ;
        }

        if (SQLCODE == SQLNOTFOUND) bNotFound=TRUE;

        iNum_Rows=sqlca.sqlerrd[2];

	    vDTrazasLog (modulo,"\t%s%d Cantidad de Filas ",LOG05, cfnGetTime(1),iNum_Rows);

        if (iNum_Rows>0 && SQLCODE != SNAPSHOT)
        {
            bfnUpdateFolios (iNum_Rows, haRegIntFoliacion, stIntQueueProc.iCodEstaDocSal, stIntQueueProc.iCodEstaDocEnt);
        }
        iRegVer=iRegVer + iNum_Rows ;
        if (bNotFound)
        {
            break;
        }
    }
    return SQLCODE ;


} /* ifnFetchInterfaz */


/* ************************************************************************* */
/* * Funcion bfnUpdateFolios                                               * */
/* ************************************************************************* */
/* * Modifica el Folio de un Documento                                     * */
/* ************************************************************************* */
BOOL bfnUpdateFolios(int iNumRows, FOLIACIONREGINTERFAZ pstRegDocumFoli, int iCodEstaDocSal, int iCodEstaDocEnt)
{
    char modulo[]="bfnUpdateFolios";

    int iFolOK  ;
    int iContR  =0 ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


       long lhNumFolio  ;
       long lhNumProceso;

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG04,modulo);
    for (iContR=0; iContR < iNumRows; iContR++)
    {
        /* ** Obtiene registro de la Interfaz                  ** */
        memset(&stInterFact,0,sizeof(INTERFACT));
        stInterFact.lNumProceso     = pstRegDocumFoli.lNumProceso [iContR];
        vDTrazasLog (modulo , "\t\t=> Nº [%d] Num Proceso [%ld] Procesado", LOG04, iContR, stInterFact.lNumProceso);
	strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
	
        if (!bfnGetInterFact(&stInterFact))
        {
            vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]" ,LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]" ,LOG01,SQLCODE,szfnORAerror());
            return FALSE;
        }
        /* ** Marca el registro de la Interfaz como procesando ** */
	    stInterFact.iCodEstaDoc = iCodEstaDocSal;               /* FOLIADA */
	    stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;        /* PROCESANDO */
	    strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
	    
	    if (!bfnUpdInterFact(stInterFact))
	    {
            vDTrazasLog  ( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
            vDTrazasError( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
            fnOraRollBack();
            return (FALSE);
        }
        else
        {
            if (!bfnOraCommit())
			{
		        vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				if (!fnOraRollBackRelease())
			        vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
				return (FALSE);
		    }
	    }

        switch (stInterFact.iCodTipMovimien)
        {
            case iTIPMOV_VENTA          :
                iFolOK=ifnFolVenta      (&stInterFact);
                break;
            case iTIPMOV_MISCELANEO     :
                iFolOK=ifnFolVenta      (&stInterFact);
                break;
            case iTIPMOV_NOTACREDITO    :
                iFolOK=ifnFolNotaCredito(&stInterFact);
                break;
        }
        if      (iFolOK==1)
        {
            /*  FOLIACION */
            lhNumFolio      =stInterFact.lNumFolio;
            lhNumProceso    =stInterFact.lNumProceso;

            vDTrazasLog (modulo , "\n\t\t=> Num Folio   [%ld]"
                                  "\n\t\t=> Num Proceso [%ld]"
                                  ,LOG05
                                  ,stInterFact.lNumFolio
                                  ,stInterFact.lNumProceso );

            /* EXEC SQL
                UPDATE FA_FACTDOCU_NOCICLO
                SET NUM_FOLIO       = :lhNumFolio
                WHERE NUM_PROCESO   = :lhNumProceso; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 6;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0 whe\
re NUM_PROCESO=:b1";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )63;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
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


            if(SQLCODE !=SQLOK)
            {
                vDTrazasLog  (modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                     "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                vDTrazasError(modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                     "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                return  (-2);
            }

            /* ** Marca el registro de la Interfaz como procesada ** */
	        stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_OK ;          /* PROCESANDA       */
            strcpy (stInterFact.szFecFoliacion, cfnGetTime(7));         /* Fecha Foliacion  */
            strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
            
	        if (!bfnUpdInterFact(stInterFact))
	        {
                vDTrazasLog  ( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
                vDTrazasError( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
                fnOraRollBack();
                return (FALSE);
            }
            iRegFol++;
        }
        else if (iFolOK==0)
        {
            /* ** Marca el registro de la Interfaz como Pre-Foliada  ** */
	        stInterFact.iCodEstaDoc = iCodEstaDocEnt;                   /* PRE-FOLIADA      */
	        stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_OK ;          /* PROCESANDO       */
	        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
	        
	        if (!bfnUpdInterFact(stInterFact))
	        {
                vDTrazasLog  ( modulo, " Al marcar registro como Pre-Foliada 'terminado ok' ",LOG01);
                vDTrazasError( modulo, " Al marcar registro como Pre-Foliada 'terminado ok' ",LOG01);
                fnOraRollBack();
                return (FALSE);
            }
        }
        else
        {
            /* ** Marca el registro de la Interfaz como Foliada con ERROR ** */
	        stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_ERROR ;     /* ERROR */
	        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002*/
	        
	        if (!bfnUpdInterFact(stInterFact))
	        {
                vDTrazasLog  ( modulo, " Al marcar registro como 'terminado ERROR' ",LOG01);
                vDTrazasError( modulo, " Al marcar registro como 'terminado ERROR' ",LOG01);
                fnOraRollBack();
                return (FALSE);
            }
            fnGrabaAnomalia(stInterFact.lNumProceso, 0,"New_FolOnlConsig", strcat(cfnGetTime(1), "=> Error en la Foliacion  " ));
            return (FALSE);
        }

        if (!bfnOraCommit())
		{
    	    vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			if (!fnOraRollBackRelease())
    		    vDTrazasError(modulo,"En Rollback release\n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			return (FALSE);
		}
        vDTrazasLog (modulo , "\t\t=> Num Proceso [%ld] Procesado", LOG04, stInterFact.lNumProceso);
    } /* fin del For */


    return TRUE;

}/* bfnUpdateFolios */

int ifnFolNotaCredito (INTERFACT *stInterFact)
{
    char modulo[]="ifnFolNotaCredito";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumFolio          ;
        long    lhNumProceso        ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    /* lhNumProceso = stInterFact->lNumProceso        ; */

    /* EXEC SQL SELECT FA_SEQ_FOLNCCONSIG.NEXTVAL INTO :lhNumFolio
            FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_SEQ_FOLNCCONSIG.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )86;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
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


       
    if(SQLCODE)
    {
        vDTrazasLog  (modulo," En obtencion del folio nota de credito de la sequencia FA_SEQ_FOLNOTCRED "
                             "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En obtencion del folio nota de credito de la sequencia FA_SEQ_FOLNOTCRED "
                             "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (-1);
    }

    stInterFact->lNumFolio       = lhNumFolio ;              /* Nro Folio        */

    return (1);

} /* ifnFolNotaCredito */


int ifnFolVenta (INTERFACT *stInterFact)
{
    char modulo[]="ifnFolVenta";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumFolio          ;
        long    lhNumVenta        ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    /* lhNumVenta = stInterFact->lNumVenta ; */

    /* EXEC SQL SELECT FA_SEQ_FOLCONSIG.NEXTVAL INTO :lhNumFolio
            FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_SEQ_FOLCONSIG.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )105;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
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



    /*EXEC SQL
        SELECT  NUM_FOLDEALER
        INTO    :lhNumFolio
        FROM    GA_PRELIQUIDACION
        WHERE   NUM_VENTA           = :lhNumVenta
        AND     NUM_FOLDEALER > 0
        AND     NUM_FOLDEALER IS NOT NULL;
    */
    
    if (SQLCODE == SQLNOTFOUND)
    {
        return (0);
    }
    if(SQLCODE !=SQLOK )
    {
        vDTrazasLog  (modulo," En SQL-SELECT GA_PRELIQUIDACION "
                             "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-SELECT GA_PRELIQUIDACION "
                             "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (-1);
    }
    stInterFact->lNumFolio       = lhNumFolio ;              /* Nro Folio        */

    return (1);

} /* ifnFolVenta */

/* ************************************************************************* */
/* * Funcion bfnCloseInterfaz                                              * */
/* ************************************************************************* */
/* * Cierra el Cursor de documentos a Foliar                               * */
/* ************************************************************************* */
BOOL bfnCloseInterfaz()
{
    char modulo[]="bfnCloseInterfaz";
    vDTrazasLog  (modulo, "\n\t** Entrada en %s",LOG04,modulo);

    /* EXEC SQL CLOSE Cur_Interfaz; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )124;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        return FALSE;

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

