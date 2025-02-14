
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
    "./pc/New_FoliaOnline.pc"
};


static unsigned int sqlctx = 443191491;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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

 static const char *sq0002 = 
"select nvl(NUM_FOLIO,0) ,NUM_PROCESO ,PREF_PLAZA ,COD_TIPDOCUM ,nvl(NUM_VENT\
A,0)  from FA_INTERFACT where ((((COD_MODGENER=:b0 and COD_ESTADOC=:b1) and CO\
D_ESTPROC=5) and COD_APLIC='FAC') and COD_TIPDOCUM in (select COD_VALOR  from \
GED_CODIGOS where ((NOM_TABLA='FA_PREFOLIADOS' and NOM_COLUMNA='COD_TIPDOCUM')\
 and COD_MODULO='FA'))) union select nvl(NUM_FOLIO,0) ,NUM_PROCESO ,PREF_PLAZA\
 ,COD_TIPDOCUM ,nvl(NUM_VENTA,0)  from FA_INTERFACT where ((((COD_MODGENER=:b0\
 and COD_ESTADOC=:b1) and COD_ESTPROC=3) and COD_APLIC='FAC') and COD_TIPDOCUM\
 not  in (select COD_VALOR  from GED_CODIGOS where ((NOM_TABLA='FA_PREFOLIADOS\
' and NOM_COLUMNA='COD_TIPDOCUM') and COD_MODULO='FA'))) order by 1           \
 ";

 static const char *sq0003 = 
"select nvl(NUM_FOLIO,0) ,NUM_PROCESO ,PREF_PLAZA ,COD_TIPDOCUM ,nvl(NUM_VENT\
A,0)  from FA_INTERFACT where ((((COD_MODGENER=:b0 and COD_ESTADOC=:b1) and CO\
D_ESTPROC=5) and COD_APLIC='FAC') and COD_TIPDOCUM in (select COD_VALOR  from \
GED_CODIGOS where ((NOM_TABLA='FA_PREFOLIADOS' and NOM_COLUMNA='COD_TIPDOCUM')\
 and COD_MODULO='FA'))) union select nvl(NUM_FOLIO,0) ,NUM_PROCESO ,PREF_PLAZA\
 ,COD_TIPDOCUM ,nvl(NUM_VENTA,0)  from FA_INTERFACT where ((((COD_MODGENER=:b0\
 and COD_ESTADOC=:b1) and COD_ESTPROC=3) and COD_APLIC='FAC') and COD_TIPDOCUM\
 not  in (select COD_VALOR  from GED_CODIGOS where ((NOM_TABLA='FA_PREFOLIADOS\
' and NOM_COLUMNA='COD_TIPDOCUM') and COD_MODULO='FA'))) order by 1           \
 ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,112,0,6,348,0,0,4,4,0,1,0,2,5,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
36,0,0,2,701,0,9,599,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
67,0,0,3,701,0,9,654,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
98,0,0,2,0,0,13,693,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
133,0,0,3,0,0,13,702,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
168,0,0,4,569,0,4,1046,0,0,12,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,5,0,0,1,3,0,0,
231,0,0,5,260,0,5,1141,0,0,13,13,0,1,0,1,3,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
298,0,0,6,442,0,4,1238,0,0,9,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
4,0,0,2,4,0,0,2,5,0,0,1,3,0,0,
349,0,0,7,79,0,3,1315,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,
376,0,0,8,220,0,5,1355,0,0,11,11,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
435,0,0,9,358,0,4,1434,0,0,11,4,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
494,0,0,2,0,0,15,1500,0,0,0,0,0,1,0,
509,0,0,3,0,0,15,1504,0,0,0,0,0,1,0,
524,0,0,10,102,0,4,1587,0,0,6,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,2,5,0,0,
};


/* **********************************************************************/
/* *  Fichero : NewF_FoliaOnline.pc                                      */
/* *  Foliacion ONLINE de Documentos                                    */
/* *  Autor    : 				           		*/
/* *  Complice :                                                        */
/* ******************************************************************** */


#define _FOLIACION_PC_
#include <deftypes.h>
#include <string.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include <EncriptaSha1.h>
#include "New_FoliaOnline.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/
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

long pid=0;
/****************************************************************************/
/*                                   MAIN                                   */
/****************************************************************************/
int main(int argc, char *argv[])
{
    char modulo[]="main";
    char prueba[254];
    pid =getpid();

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhOperadora[4+1]; /* EXEC SQL VAR szhOperadora IS STRING(4+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 



    fprintf( stdout, "\n***** Foliacion OnLine *****\n"
	             "**%s**\n**** pid : [ %8ld ] ****"
	             "\n****************************\n",
	         		 cfnGetTime(1),pid );


    memset(&stLineaComando,0,sizeof(FOLIACIONLINEACOMANDO));
    memset(&stStatus,'\0',sizeof(STATUS));
    
    /* Validación de parámetros */
    if (!bfnValidaParametros(argc,argv,&stLineaComando)) 
    {
    	return 1;
    }

    /* Conexión a la Base de Datos */
    if(!bfnConnectORA(stLineaComando.szOraAccount,stLineaComando.szOraPasswd))
    {
        vDTrazasError(modulo, "<< Usuario/Password Invalido >>", LOG01);
        return 2;
    }
    
    /* Obtención de datos a procesar (GenFA.pc)*/
    if (!bGetDatosGener(&stDatosGener, szSysDate))
        return FALSE;                

    /* Realiza la apertura de archivos de Logs, Errores y Datos */
    if (!bfnAbreArchivos(&stLineaComando,szSysDate)) 	
    {
    	return 4;
    }
    
    memset(szhOperadora,'\0',sizeof(szhOperadora));
    /* Obtener Operadora*/
    if (!bfnObtieneOperadora(szhOperadora))
    {
    	return FALSE;
    }
    
    fprintf(stdout,"\n ** OPERADORA VIGENTE : [%s] \n", szhOperadora);

    /* Proceso Foliación */
    if(!bfnFoliacionOnline(&stLineaComando, &stRegDocumFoli, szhOperadora))
    {
        vDTrazasError(modulo, " \n------------------------------------"
                              " \nProceso Terminado de Forma Irregular"
                              " \n------------------------------------"
                              ,LOG03);
        vDTrazasLog  (modulo, " \n------------------------------------"
                              " \nProceso Terminado de Forma Irregular"
                              " \n------------------------------------"
                              ,LOG03);
        return 5;
    }
    else
    {
        vDTrazasLog  (modulo, " \n------------------------------------"
                              " \nProceso Terminado Correctamente"
                              " \n------------------------------------"
                              ,LOG03);
        /* Commit a la Base de Datos */
        if (!bfnOraCommit())
        {
            vDTrazasLog  (modulo, " \n------------------------------------"
                                  " \nFallo en el Commit"
                                  " \n------------------------------------"
                                  ,LOG03);
            vDTrazasError(modulo, " \n------------------------------------"
                                  " \nFallo en el Commit"
                                  " \n------------------------------------"
                                  ,LOG03);                                 
            return 6;
        }
    }

    /* Desconexion Base de Datos */
    if(bfnDisconnectORA(0))
    {
      vDTrazasLog  (modulo, "\n------------------------------------"
                            "\nDesconectado de  ORACLE"
                            "\n------------------------------------"
                            ,LOG04);

      vDTrazasError(modulo, "\n------------------------------------"
                            "\nDesconectado de  ORACLE"
                            "\n------------------------------------"
                            ,LOG04);                            
    }

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    
    printf("\n\tProceso Terminado ..\n");

    return 0;

} /* Main */


/* ************************************************************************* */
/* * FUNCION : bfnValidaParametros                                         * */
/* * USO     : Realiza la validacion de los Parametros de Entrada          * */
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

    vDTrazasLog (modulo , "\n*** Entrada en %s ***",LOG04,modulo);

    opterr=0;

    if(argc == 1)
    {
       fprintf (stderr,"\n<< Error : Parametros insuficientes >>\n%s\n",szUsage);
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
				fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
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
				fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
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
			        fprintf (stderr,"\n<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
				return FALSE;
			     }
			     break;

		    case '?':
			     fprintf (stderr,"\n<< Error : opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
			     return FALSE;

		    case ':':
				
			     fprintf (stderr,"\n<< Error : Falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
			     return FALSE;
             }

    }

    if(Logflag==FALSE)
    {
       /* asume nivel de log por defecto */    	
       stStatus.LogNivel = iLOGNIVEL_DEF ; 
       vDTrazasLog ( modulo, "Log : -l %d (default)", LOG03, stStatus.LogNivel );
    }

    pstLineaCom->iNivLog=stStatus.LogNivel ;

    if(MGenflag==FALSE)
    {
       fprintf (stderr,"\n<< Error : Falta definir opcion '-m' >>\n%s\n",szUsage);
		return FALSE;
    }

    if(Userflag==TRUE)
    {
       if ( (psztmp=(char *)strstr(pstLineaCom->szUsuarioOra,"/"))==(char *)NULL)
       {
	     fprintf (stderr,"\n<< Error : Usuario Oracle no valido. Requiere '/' >>\n%s\n",szUsage);
	     return FALSE;
       }
       else
       {
            strncpy (pstLineaCom->szOraAccount,pstLineaCom->szUsuarioOra,psztmp-pstLineaCom->szUsuarioOra);
            strcpy  (pstLineaCom->szOraPasswd, psztmp+1);
       }
    }

    return TRUE;

} /* FIN bfnValidaParamatros */

/* ************************************************************************* */
/* * FUNCION : bfnAbreArchivos                                             * */
/* * USO     : Realiza la apertura de archivos de Logs, Errores y Datos    * */
/* ************************************************************************* */
BOOL bfnAbreArchivos(FOLIACIONLINEACOMANDO *pstLineaCom, char *szDate)
{
    char modulo[]="bfnAbreArchivos";

    char    *szDirLogs               ;
    char    *szNomArchivo            ;
    char    szComando[1024] = ""     ;

    szDirLogs    = (char *)malloc(1024);
    szNomArchivo = (char *)malloc(128);

    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL) 
    {
    	return FALSE;
    }

    sprintf (pstLineaCom->szDirLogs,"%s/New_FoliaOnline/%s",szDirLogs,cfnGetTime(2));
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

    fprintf (stdout, "\nCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01,szComando);
        return FALSE;
    }

    fprintf(stdout, "\nCrea Archivo Log/Err : New_FoliaOnline_%s_%s\n\n",pstLineaCom->szCodModGener, szDate );

    sprintf(szNomArchivo,"%s/New_FoliaOnline_%s",
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
        vDTrazasError(modulo,"*** ERROR => No puede abrirse el fichero de log %s",LOG01, stStatus.LogName);
        fclose(stStatus.ErrFile);
        return FALSE;
    }

    vDTrazasLog  (modulo,"\n\t*************************************"
                         "\n\t****        Log   Foliacion        **"
                         "\n\t*************************************"
                         ,LOG03);

    vDTrazasLog(modulo, "\n\t***  Parametro de Entrada Foliacion  ***"
                        "\n\t\t=> Usuario               [%s]"
                        "\n\t\t=> Password              [************]"
                        "\n\t\t=> Cod.ModGener          [%s]"
                        "\n\t\t=> Niv.Log               [%d]"
                        ,LOG05
                        ,pstLineaCom->szOraAccount
                        ,pstLineaCom->szCodModGener
                        ,pstLineaCom->iNivLog);

    return TRUE;

} /* bfnAbreArchivos */

/* **************************************************************************** */
/* * FUNCION : bfnObtieneOperadora                                            * */
/* * USO     : Recupera Código de Operadora                                   * */
/* **************************************************************************** */
BOOL bfnObtieneOperadora ( char *szCodOperadora )
{
    char modulo[]="bfnObtieneOperadora";	
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 char szhCodOperadora [4+1]; /* EXEC SQL VAR szhCodOperadora IS STRING(4+1); */ 

    	 int  iCodRetorno;
    	 char szhMensRetorno[255+1];
    	 int  iNumEvento;
    /* EXEC SQL END DECLARE SECTION; */ 
    
    
    memset(szhCodOperadora,'\0',sizeof(szhCodOperadora));
    memset(szhMensRetorno,'\0',sizeof(szhMensRetorno));
    iCodRetorno=0;
    iNumEvento=0;    
    
    vDTrazasLog ( modulo,"\n\t*** Entrada en %s ***"
               		,LOG04, modulo);    
    
    /* EXEC SQL EXECUTE
        BEGIN    
         :szhCodOperadora := GE_OBTIENE_OPERADORA_LOCAL_FN ( :iCodRetorno, :szhMensRetorno, :iNumEvento );
        END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szhCodOperadora := GE_OBTIENE_OPERADORA_LOCAL_FN (\
 :iCodRetorno , :szhMensRetorno , :iNumEvento ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&iCodRetorno;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhMensRetorno;
    sqlstm.sqhstl[2] = (unsigned long )256;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&iNumEvento;
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

  
    
    if (SQLCODE != SQLOK)
    {
       vDTrazasLog("bfnObtieneOperadora", "Error en bfnObtieneOperadora:(%s)", LOG05,szhMensRetorno);
       vDTrazasLog("bfnObtieneOperadora", "Error :(%s)", LOG05,SQLERRM);       
       return(FALSE);
    }           
    
    strcpy(szCodOperadora,szhCodOperadora);
    
    return TRUE;
}

/* **************************************************************************** */
/* * FUNCION : Funcion bfnFoliacionOnline                                     * */
/* * USO     : Realiza la asignacion de folios legales por tipo de dopcumento * */
/* *           por rangos de clientes segun el orden generado                 * */
/* **************************************************************************** */
BOOL bfnFoliacionOnline ( FOLIACIONLINEACOMANDO *pstLineaCom, 
                          FOLIACIONREGINTERFAZ  *stRegDocumFoli,
                          char *szOperadora )
{
    char modulo[]="bfnFoliacionOnline";

    char    szFecha [20]    = ""   ;   /*  Fecha de Sistema Para Update de Traza   */
    long    lFolioUpdate    = 0    ;   /*  Folio Asignado para Update              */
    int     iSql            = 0    ;   /*  Retorno de Fetch de Documentos          */
    BOOL    bFinCursor      = FALSE;
    BOOL    bTerminoOK      = TRUE ;
    int     iCont           = 0    ;
    int     iFol            = 0    ;
    int     iStatusFin      = iESTAQUEUE_WAIT; /* Estado de la cola de procesos */
    char    *szStatusFin;
    int     iEstaproc_terminado_ok;  

    vDTrazasLog ( modulo,"\n\t*** Entrada en %s ***"
                         "\n\t\t%s[%ld] Obtencion datos cola  "
               		,LOG04, modulo,cfnGetTime(1),pid);
                
    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
    strcpy( stIntQueueProc.szCodModGener , pstLineaCom->szCodModGener);
    stIntQueueProc.lCodProceso   = iPROCESO_INT_FOLIACION_ONLINE;
    strcpy(stIntQueueProc.szCodAplic,"FAC");
            
    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
	return FALSE;
    }

/********************************************************************************************************/
    /* Open de Tabla FA_INTERFACT */
    /*if (!bfnOpenInterfaz(stIntQueueProc, iESTAPROC_TERMINADO_OK))*/ /* P-MIX-09003 */
    if (!bfnOpenInterfaz(stIntQueueProc, iESTAPROC_TERMINADO_OK, szOperadora))     /* P-MIX-09003 */
    {
        vDTrazasError(modulo, "\n\tAl abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, "\n\tAl abrir cursor sobre la interfaz " ,LOG01);
	return FALSE;
    }
    
    vDTrazasLog  (modulo, "\n\t\tSalida del OPEN" ,LOG05);
    iCont=0;
    iFol=0;
    do
    {
       /*memset(stRegDocumFoli,0,sizeof(FOLIACIONREGINTERFAZ));*/
       vDTrazasLog  (modulo, "\n\t\tEntrada  al DO" ,LOG05);

       iSql=ifnFetchInterfaz(stRegDocumFoli, iCont, szOperadora);

       if(iSql !=SQLOK && iSql !=SQLNOTFOUND)
       {
	  vDTrazasError(modulo, "\n\t\tOracle Inesperado [%d] " ,LOG01,iSql);
	  vDTrazasLog  (modulo, "\n\t\tOracle Inesperado [%d] " ,LOG01,iSql);
	  return FALSE;
       }
		
       if(iSql == SQLNOTFOUND)
       {
	  bFinCursor = TRUE;
          bTerminoOK = TRUE;
          iStatusFin = iESTAQUEUE_WAIT;                   
       }
       else
       {
	  if (stRegDocumFoli->lNumFolio[iCont] > 0)
	  {
	      if(!bfnUpdateFolios(stRegDocumFoli,stLineaComando.szOraAccount, &iFol, iCont))
	      {
		  vDTrazasLog  ( modulo, "\n\t\t**Al Marcar Folio a Documento ",LOG01);
		  vDTrazasError( modulo, "\n\t\t**Al Marcar Folio a Documento ",LOG01);
		  bFinCursor = TRUE;
		  bTerminoOK = FALSE;
	      	  iStatusFin = iESTAQUEUE_ERROR;
	      }
	  }     
	  else
	  {
              if(!bfnConsumeFolios(stRegDocumFoli,stLineaComando.szOraAccount, &iFol, iCont))
	      {
		  vDTrazasLog  ( modulo, "\n\t\t**Al Marcar Folio a Documento ",LOG01);
		  vDTrazasError( modulo, "\n\t\t**Al Marcar Folio a Documento ",LOG01);
		  bFinCursor = TRUE;
		  bTerminoOK = FALSE;
	          iStatusFin = iESTAQUEUE_ERROR;
	      }
	   } 
	   iCont++;
	}
    } while (!bFinCursor);
	 

    vDTrazasLog  (modulo, "\n\tTotal de Registros Verificados : %d"
    			  "\n\tTotal de Registros Foliados    : %d"
    		        , LOG03, iCont, iFol);

    if(!bfnCloseInterfaz(szOperadora))
    {
       vDTrazasLog  (modulo, "\n\t\tAl cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "\n\t\tAl cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
    }


/********************************************************************************************************/

    if (!bfnCambiaEstCola(pstLineaCom->szCodModGener, iPROCESO_INT_FOLIACION_ONLINE, iESTAQUEUE_RUNNING , iStatusFin,"FAC"))
    {
	if (!fnOraRollBack())
	{
	    vDTrazasError(modulo,"\n\t\tEn Rollback %s", LOG01, sqlca.sqlerrm.sqlerrmc);
	    return FALSE;
	}
	else
	{	
	    if (!fnOraCommit())
	    {    
                vDTrazasError(modulo,"\n\t\tEn Commit %s", LOG01, sqlca.sqlerrm.sqlerrmc);
		if (!fnOraRollBack())
		{
	    	    vDTrazasError(modulo,"\n\t\tEn Rollback %s", LOG01, sqlca.sqlerrm.sqlerrmc);
		    return FALSE;
		}
	    }
	}
    }

    szStatusFin = (bTerminoOK==TRUE)? "TRUE":(bTerminoOK==FALSE)?"FALSE":"???";
    vDTrazasLog  (modulo, "\n\t*** Terminando Foliacion Online con '%s' ***", LOG05,szStatusFin );

    return bTerminoOK;

}/* FIN bfnFoliacionOnline */


/* ********************************************************************************* */
/* * FUNCION : bfnOpenInterfaz                                                     * */
/* * USO     : Crea y Abre un Cursor sobre los documentos a Foliar de FA_INTERFACT * */
/* ********************************************************************************* */
BOOL bfnOpenInterfaz(INTQUEUEPROC stIntQueueProc, int iCodEstProc, char *szOperadora)
{
    char modulo[]="bfnOpenInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 char szhCodModGener [4]="";
    	 char szhCodOperadora [4+1];    	 
    	 int ihCodEstaDocEnt     =0;
    	 int ihCodEstProc        =0;
    	 int ihCodProceso        =0;
 	 int ihNumDeltaHoras;
	 char szhCadenaSelect[3000]; 	 
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodOperadora,'\0',sizeof(szhCodOperadora));
    memset(szhCadenaSelect,'\0',sizeof(szhCadenaSelect));    

    ihCodProceso    = iPROCESO_INT_FOLIACION_ONLINE;
    strcpy( szhCodModGener  ,stIntQueueProc.szCodModGener);
    ihCodEstaDocEnt = stIntQueueProc.iCodEstaDocEnt;
    ihCodEstProc    = iCodEstProc  ;
    ihNumDeltaHoras = stIntQueueProc.iNumDeltaHoras;
    
    strcpy(szhCodOperadora,szOperadora);

    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***"
                        "\n\t********************************"
			"\n\t\tCOD_ESTADOC  = :ihCodEstaDocEnt  [%d] "
			"\n\t\tCOD_ESTPROC  = :ihCodEstProc     [%d] "
			"\n\t\tCOD_MODGENER = :szhCodModGener   [%s] "
			"\n\t\tOPERADORA    = :szhCodOperadora  [%s] "			
	               ,LOG04, modulo, ihCodEstaDocEnt, ihCodEstProc, szhCodModGener,szhCodOperadora);

    if (strcmp(szhCodOperadora,"TMS")== 0)
    {	
    	ihCodEstProc = 5;

        /* EXEC SQL DECLARE  Cur_Interfaz1  CURSOR FOR
	     /oSELECT  nvl(NUM_FOLIO,0),
	             NUM_PROCESO,
		     PREF_PLAZA,
		     COD_TIPDOCUM,
		     nvl(NUM_VENTA,0)
	     FROM  FA_INTERFACT
	     WHERE  COD_MODGENER = :szhCodModGener
	     AND  COD_ESTADOC  = :ihCodEstaDocEnt
	     AND  COD_ESTPROC  = :ihCodEstProc 
	     AND  COD_APLIC    = 'FAC'
   	     ORDER BY  NUM_FOLIO ;o/
	     SELECT  nvl(NUM_FOLIO,0),
	             NUM_PROCESO,
		     PREF_PLAZA,
		     COD_TIPDOCUM,
		     nvl(NUM_VENTA,0)
	     FROM  FA_INTERFACT
	     WHERE  COD_MODGENER = :szhCodModGener
	     AND  COD_ESTADOC  = :ihCodEstaDocEnt
	     AND  COD_ESTPROC  = 5 
	     AND  COD_APLIC    = 'FAC'
	     AND  COD_TIPDOCUM IN (SELECT COD_VALOR FROM GED_CODIGOS
                                   WHERE NOM_TABLA = 'FA_PREFOLIADOS'
                                   AND   NOM_COLUMNA = 'COD_TIPDOCUM'
                                   AND   COD_MODULO  = 'FA')
	     UNION
	     SELECT  nvl(NUM_FOLIO,0),
	             NUM_PROCESO,
		     PREF_PLAZA,
		     COD_TIPDOCUM,
		     nvl(NUM_VENTA,0)
	     FROM  FA_INTERFACT
	     WHERE  COD_MODGENER = :szhCodModGener
	     AND  COD_ESTADOC  = :ihCodEstaDocEnt
	     AND  COD_ESTPROC  = 3 
	     AND  COD_APLIC    = 'FAC'	  
	     AND  COD_TIPDOCUM NOT IN (SELECT COD_VALOR FROM GED_CODIGOS
                                       WHERE NOM_TABLA = 'FA_PREFOLIADOS'
                                       AND   NOM_COLUMNA = 'COD_TIPDOCUM'
                                       AND   COD_MODULO  = 'FA')
   	     ORDER BY  1 ; */ 
     	     
   	     
        if (SQLCODE)
        {
            vDTrazasLog  (modulo , "\n\t** En SQL-DECLARE Cur_Interfaz1 **"
                                   "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo , "\n\t\t**  En SQL-DECLARE Cur_Interfaz1 **"
                                "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   	     

        /* EXEC SQL OPEN Cur_Interfaz1; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )36;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodModGener;
        sqlstm.sqhstl[2] = (unsigned long )4;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaDocEnt;
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


    
        vDTrazasLog (modulo,"\n\t\tOPEN sqlca.sqlcode: [%d]",LOG05,sqlca.sqlcode);
        if (SQLCODE)
        {
            vDTrazasLog  (modulo,"\n\t**  En SQL-OPEN CURSOR Cur_Interfaz1 **"
                                 "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo,"\n\t**  En SQL-OPEN CURSOR Cur_Interfaz1 **"
                                 "\n\t\t=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
   	     
    }
    else
    {
        /* EXEC SQL DECLARE  Cur_Interfaz2  CURSOR FOR
	     SELECT  nvl(NUM_FOLIO,0),
	             NUM_PROCESO,
		     PREF_PLAZA,
		     COD_TIPDOCUM,
		     nvl(NUM_VENTA,0)
	     FROM  FA_INTERFACT
	     WHERE  COD_MODGENER = :szhCodModGener
	     AND  COD_ESTADOC  = :ihCodEstaDocEnt
	     AND  COD_ESTPROC  = 5 
	     AND  COD_APLIC    = 'FAC'
	     AND  COD_TIPDOCUM IN (SELECT COD_VALOR FROM GED_CODIGOS
                                   WHERE NOM_TABLA = 'FA_PREFOLIADOS'
                                   AND   NOM_COLUMNA = 'COD_TIPDOCUM'
                                   AND   COD_MODULO  = 'FA')
	     UNION
	     SELECT  nvl(NUM_FOLIO,0),
	             NUM_PROCESO,
		     PREF_PLAZA,
		     COD_TIPDOCUM,
		     nvl(NUM_VENTA,0)
	     FROM  FA_INTERFACT
	     WHERE  COD_MODGENER = :szhCodModGener
	     AND  COD_ESTADOC  = :ihCodEstaDocEnt
	     AND  COD_ESTPROC  = 3 
	     AND  COD_APLIC    = 'FAC'	  
	     AND  COD_TIPDOCUM NOT IN (SELECT COD_VALOR FROM GED_CODIGOS
                                       WHERE NOM_TABLA = 'FA_PREFOLIADOS'
                                       AND   NOM_COLUMNA = 'COD_TIPDOCUM'
                                       AND   COD_MODULO  = 'FA')
   	     ORDER BY  1 ; */ 
   	       	     
        if (SQLCODE)
        {
            vDTrazasLog  (modulo , "\n\t** En SQL-DECLARE Cur_Interfaz2 **"
                                   "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo , "\n\t\t**  En SQL-DECLARE Cur_Interfaz2 **"
                                "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   	     

        /* EXEC SQL OPEN Cur_Interfaz2; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodModGener;
        sqlstm.sqhstl[2] = (unsigned long )4;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaDocEnt;
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


    
        vDTrazasLog (modulo,"\n\t\tOPEN sqlca.sqlcode: [%d]",LOG05,sqlca.sqlcode);
        if (SQLCODE)
        {
            vDTrazasLog  (modulo,"\n\t**  En SQL-OPEN CURSOR Cur_Interfaz2 **"
                                 "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo,"\n\t**  En SQL-OPEN CURSOR Cur_Interfaz2 **"
                                 "\n\t\t=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   	     
    }

    return TRUE;

}/* FIN bfnOpenInterfaz */

/* ************************************************************************* */
/* * FUNCION : ifnFetchInterfaz                                            * */
/* * USO     : Lee Un Registro de los documentos a Foliar                  * */
/* ************************************************************************* */
int ifnFetchInterfaz(FOLIACIONREGINTERFAZ *pstRegDocumFoli, int i, char *szOperadora)
{
    char modulo[]="ifnFetchInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long  lhNumFolio	;
         long  lhNumProceso	;
         int  ihCodTipDocum     ;
         long  lhNumVenta       ;
         char  szhPrefPlaza [26];  /* EXEC SQL VAR szhPrefPlaza IS STRING(26); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***"
                          "\n\t***********************************",LOG04,modulo);
                          
    if (strcmp(szOperadora,"TMS") == 0)
    {                          
                          
        /* EXEC SQL FETCH Cur_Interfaz1 
                 INTO  :lhNumFolio,
		       :lhNumProceso,
		       :szhPrefPlaza,
		       :ihCodTipDocum,
		       :lhNumVenta; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )98;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[2] = (unsigned long )26;
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
        sqlstm.sqhstv[4] = (unsigned char  *)&lhNumVenta;
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


    }
    else
    {
        /* EXEC SQL FETCH Cur_Interfaz2
                 INTO  :lhNumFolio,
		       :lhNumProceso,
		       :szhPrefPlaza,
		       :ihCodTipDocum,
		       :lhNumVenta; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )133;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
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
        sqlstm.sqhstv[2] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[2] = (unsigned long )26;
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
        sqlstm.sqhstv[4] = (unsigned char  *)&lhNumVenta;
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


    }

    vDTrazasLog (modulo,"\n\t\tFETCH sqlca.sqlcode: [%d]",LOG05,sqlca.sqlcode);
    
    vDTrazasLog  (modulo,"\n\t\tEn FETCH CURSOR Cur_Interfaz"
                         "\n\t\t=> Numero de registros rescatados: [%d]",LOG05,sqlca.sqlerrd[2]);
    
    vDTrazasLog (modulo, "\n\t* Resultado de FETCH:"
                         "\n\t********************"
    			 "\n\t\tlhNumFolio    [%ld]"
    			 "\n\t\tlhNumProceso  [%ld]"
    			 "\n\t\tszhPrefPlaza  [%s]"
    			 "\n\t\tihCodTipDocum [%d]"
    			 "\n\t\tlhNumVenta    [%ld]"  
    			,LOG05
    			,lhNumFolio   
    			,lhNumProceso 
    			,szhPrefPlaza 
    			,ihCodTipDocum
    			,lhNumVenta);   
    			
    			
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (modulo,  "\n\t\tEn FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
        vDTrazasError(modulo,  "\n\t\tEn FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
        return SQLCODE ;
    }

    if( SQLCODE == SQLNOTFOUND )
    {
        vDTrazasLog  (modulo, "\n\t\tNo Existen Mas Documentos en CURSOR Cur_Interfaz ",LOG04);
        return SQLCODE ;
    }
    else
    {
        vDTrazasLog (modulo,"\n\t\tEn else de SQLNOTFOUND..., valor de i: [%d]",LOG05,i);
        
        pstRegDocumFoli->lNumFolio [i]   = lhNumFolio;
        pstRegDocumFoli->lNumProceso[i]  = lhNumProceso;
        strcpy(pstRegDocumFoli->szPrefPlaza[i], szhPrefPlaza);
        pstRegDocumFoli->iCodTipDocum [i]= ihCodTipDocum;
        pstRegDocumFoli->lNumVenta [i]   = lhNumVenta;
        
        vDTrazasLog (modulo,"\n\t\tSaliendo de else de SQLNOTFOUND..., valor de i: [%d]",LOG05,i);
    }

    vDTrazasLog (modulo , "\n\t\t=> Num Folio   [%ld]"
                          "\n\t\t=> Num Proceso [%ld]"
                          "\n\t\t=> i [%d]"
                          ,LOG05
			  ,pstRegDocumFoli->lNumFolio[i]
        		  ,pstRegDocumFoli->lNumProceso[i]
        		  , i );
    return SQLCODE ;

} /* FIN ifnFetchInterfaz */

/* ************************************************************************* */
/* * FUNCION : bfnUpdateFolios                                             * */
/* * USO     : Modifica el Folio de un Documento                           * */
/* ************************************************************************* */
BOOL bfnUpdateFolios(FOLIACIONREGINTERFAZ *pstRegDocumFoli,char *szOraUser, int *iFol, int i)
{
    char modulo[]="bfnUpdateFolios";

    BOOL bContinuar =TRUE;
    BOOL bVerSgte   =TRUE;

    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG04,modulo);

    memset(&stInterFact,0,sizeof(INTERFACT));
    stInterFact.lNumProceso     = pstRegDocumFoli->lNumProceso[i] ;
    strcpy(stInterFact.szCodAplic,"FAC");  
    
    /* Recupera Datos FA_INTERFACT */
    if (!bfnGetInterFact(&stInterFact))
    {
        vDTrazasError(szExeName,"\n\t\tError obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"\n\t\tError obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        return FALSE;
    }

    memset(&stRegAlConDoc,0,sizeof(FOLIACIONALCONSUDOCUM)) ;

    stInterFact.iCodEstaDoc = stIntQueueProc.iCodEstaDocSal;/* FOLIADA */
    stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;        /* PROCESANDO */
    strcpy(stInterFact.szCodAplic,"FAC");  

    /* Update FA_INTERFACT */	
    if (!bfnUpdInterFact(stInterFact))
    {
	vDTrazasLog  ( modulo, "\n\t\tAl Marcar registro como 'Procesando' ",LOG01);
	vDTrazasError( modulo, "\n\t\tAl Marcar registro como 'Procesando' ",LOG01);
        fnOraRollBack();
    }
    else
    {
	if (!bfnOraCommit())
	{
	    vDTrazasLog  ( modulo, "\n\t\tAl hacer Commit ",LOG01);
	    vDTrazasError( modulo, "\n\t\tAl hacer Commit ",LOG01);
	    bContinuar=FALSE;
	    bVerSgte=TRUE;
	}
	else
	{
                 /* Update FA_FACTDOCU_NOCICLO */	
    	         if (!bfnUpdateFactDocuNoCiclo ( pstRegDocumFoli->lNumFolio[i],
    		                                 pstRegDocumFoli->szPrefPlaza[i],
    		                                 pstRegDocumFoli->lNumProceso[i]))
	         {
		      vDTrazasLog  ( modulo, "\n\t\tAl hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
		      vDTrazasError( modulo, "\n\t\tAl hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
	              fnOraRollBack();
	              stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_ERROR ;/* ERROR */
	              strcpy(stInterFact.szCodAplic,"FAC");  
	            
		      bfnUpdInterFact(stInterFact);
		      bfnOraCommit();
		      bContinuar=FALSE;
	         }
	         else
	         {
		      stInterFact.iCodEstaProc    = iESTAPROC_TERMINADO_OK ; /* OK */
		      strcpy(stInterFact.szFecFoliacion, cfnGetTime(7));
		      strcpy(stInterFact.szCodAplic,"FAC");  
		        
		      /* Update FA_INTERFACT */
    		      if (!bfnUpdInterFact(stInterFact))
		      {
    		           vDTrazasLog  ( modulo, "\n\t\tAl marcar registro como 'terminado ok' ",LOG01);
		           vDTrazasError( modulo, "\n\t\tAl marcar registro como 'terminado ok' ",LOG01);
		           fnOraRollBack();
		           bContinuar=FALSE;
	              }
		      else
		      {
		      	   /* Commit sobre cambios realizados */
		           if (!bfnOraCommit())
        	           {
		                vDTrazasLog  ( modulo, "\n\t\tAl hacer Commit ",LOG01);
		                vDTrazasError( modulo, "\n\t\tAl hacer Commit ",LOG01);
            		        fnOraRollBack();
			        bContinuar=FALSE;
		           }
		           else
		           {
			        *iFol=*iFol+1;
		           }
	              }
	         }   
        }
    }

    if (!bContinuar)
    {
	vDTrazasLog  ( modulo, "\n\t*** No sigue con este registro pasa al siguiente ***",LOG04);
	vDTrazasError( modulo, "\n\t*** No sigue con este registro pasa al siguiente ***",LOG04);
    }

	return TRUE;

}/* FIN bfnUpdateFolios */

/** **************************** */
/* FUNCION : bfnConsumeFolios  * */
/* ***************************** */
BOOL bfnConsumeFolios(FOLIACIONREGINTERFAZ *pstRegDocumFoli,char *szOraUser, int *iFol, int i)
{
    char modulo[]="bfnConsumeFolios";

    BOOL bContinuar =TRUE;
    BOOL bVerSgte   =TRUE;

    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG04,modulo);

    memset(&stInterFact,0,sizeof(INTERFACT));
    stInterFact.lNumProceso     = pstRegDocumFoli->lNumProceso[i] ;
    strcpy(stInterFact.szCodAplic,"FAC");  
    
    /* Recupera Datos FA_INTERFACT */
    if (!bfnGetInterFact(&stInterFact))
    {
        vDTrazasError(szExeName,"\n\t\tError obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"\n\t\tError obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        return FALSE;
    }

    memset(&stRegAlConDoc,0,sizeof(FOLIACIONALCONSUDOCUM)) ;

    stInterFact.iCodEstaDoc = stIntQueueProc.iCodEstaDocSal;/* FOLIADA */
    stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;        /* PROCESANDO */
    strcpy(stInterFact.szCodAplic,"FAC");  
    
    /* Update FA_INTERFACT */
    if (!bfnUpdInterFact(stInterFact))
    {
	vDTrazasLog  ( modulo, "\n\t\tAl Marcar registro como 'Procesando' ",LOG01);
	vDTrazasError( modulo, "\n\t\tAl Marcar registro como 'Procesando' ",LOG01);
        fnOraRollBack();
    }
    else
    {
    	/* Commit sobre cambios realizados */
	if (!bfnOraCommit())
	{
	     vDTrazasLog  ( modulo, "\n\t\tAl hacer Commit ",LOG01);
	     vDTrazasError( modulo, "\n\t\tAl hacer Commit ",LOG01);
	     bContinuar=FALSE;
	     bVerSgte=TRUE;
	}
	else
	{
                  /* Update FA_FACTDOCU_NOCICLO */
    	          if (!bfnUpdateDocuNoCiclo ( pstRegDocumFoli->iCodTipDocum[i],
    		                         pstRegDocumFoli->lNumVenta[i],
    		                         pstRegDocumFoli->lNumProceso[i]))
	         {
		       vDTrazasLog  ( modulo, "\n\t\tAl hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
		       vDTrazasError( modulo, "\n\t\tAl hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
	               fnOraRollBack();
	               stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_ERROR ;/* ERROR   */
	               strcpy(stInterFact.szCodAplic,"FAC");  
	            
		       bfnUpdInterFact(stInterFact);
		       bfnOraCommit();
		       bContinuar=FALSE;
	         }
	         else
	         {     	
		       stInterFact.iCodEstaProc    = iESTAPROC_TERMINADO_OK ;   /* OK      */
		       strcpy(stInterFact.szFecFoliacion, cfnGetTime(7));
		       strcpy(stInterFact.szCodAplic,"FAC");  
		        
		       /* Update FA_INTERFACT */ 
    		       if (!bfnUpdInterFact(stInterFact))
		       {
    		            vDTrazasLog  ( modulo, "\n\t\tAl marcar registro como 'terminado ok' ",LOG01);
		            vDTrazasError( modulo, "\n\t\tAl marcar registro como 'terminado ok' ",LOG01);
		            fnOraRollBack();
		            bContinuar=FALSE;
		       }
		       else
		       {
		       	    /* Commit sobre cambios realizados */
		            if (!bfnOraCommit())
        	            {
		                vDTrazasLog  ( modulo, "\n\t\tAl hacer Commit ",LOG01);
			        vDTrazasError( modulo, "\n\t\tAl hacer Commit ",LOG01);
            		        fnOraRollBack();
			        bContinuar=FALSE;
		            }
		            else
		            {
		                *iFol=*iFol+1;
		            }
		       }		 
	         }  
        }
    }

    if (!bContinuar)
    {
	vDTrazasLog  ( modulo, "\n\t*** No sigue con este registro pasa al siguiente ***",LOG04);
	vDTrazasError( modulo, "\n\t*** No sigue con este registro pasa al siguiente ***",LOG04);
    }

    return TRUE;

}/* FIN bfnConsumeFolios */

/* ************************************************************************* */
/* * FUNCION : bfnUpdateFactDocuNoCiclo					   * */
/* * USO     : Modifica el Folio de un Documento en la Fa_FactDocu_NoCiclo * */
/* ************************************************************************* */
BOOL bfnUpdateFactDocuNoCiclo   ( long lNumFolio, char *szPrefPlaza, long lNumProceso)
{
    char modulo[]="bfnUpdateFactDocuNoCiclo";
    char szCadenaResultado [500]; 
    char szCamposEncriptados[41]; 

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 long    lhFolioAux1         	;
	 long    lhFolio                ;
	 long    lhNumProceso    	;
	 int     ihCodTipDocum   	;
	 char    szhRowid        [20]=""; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

	 int     ihCodCentrEmi   	;
	 char    szhFecEmision   [15]=""; /* EXEC SQL VAR szhFecEmision IS STRING(15); */ 

	 char    szhHorEmision   [15]=""; /* EXEC SQL VAR szhHorEmision IS STRING(15); */ 

	 long    lhCodTipDocum		;
	 long    lhCodVendedorAgente	;
	 char    szhCodOficina    [3]   ;
	 char    szhCodOperadora  [6]; /* EXEC SQL VAR szhCodOperadora IS STRING(15); */ 

	 char    szhPrefPlaza    [25+1]; /* EXEC SQL VAR szhPrefPlaza IS STRING(25+1); */ 

	 char    szhPrefPlazaEncrip [25+1]; /* EXEC SQL VAR szhPrefPlazaEncrip IS STRING(25+1); */ 
	 
	 long    lhFolioAux2 =0         ;
         double  dhTotCargosMe          ; 
         double  dhAcumIva              ; 
         char    szhCodIdTipDian  [3]=""; /* EXEC SQL VAR szhCodIdTipDian IS STRING(3); */ 

         char    szhNumIdTrib    [21]=""; /* EXEC SQL VAR szhNumIdTrib IS STRING(21); */ 
 
         char    szNitOperadora  [16]; /* EXEC SQL VAR szNitOperadora IS STRING(16); */ 

         char    szKeyConTecnico [41]; /* EXEC SQL VAR szKeyConTecnico IS STRING(41); */ 

         
         /*P-MIX-09003 Se incluyen campos del Folio. Incidencia 115984*/
         char szhResolucion  [25+1] ; /* EXEC SQL VAR szhResolucion IS STRING(25+1); */ 

         char szhFecResolucion [10+1]=""; /* EXEC SQL VAR szhFecResolucion IS STRING(10+1); */ 

         char szhSerie  [10+1] ; /* EXEC SQL VAR szhSerie IS STRING(10+1); */ 

         char szhEtiqueta  [10+1] ; /* EXEC SQL VAR szhEtiqueta IS STRING(10+1); */ 

         long lhRanDesde;
         long lhRanHasta;
         /*Fin P-MIX-09003 Incidencia 115984*/         
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodOperadora,'\0',sizeof(szhCodOperadora));    
    memset(szhPrefPlaza,'\0',sizeof(szhPrefPlaza));
    memset(szhPrefPlazaEncrip,'\0',sizeof(szhPrefPlazaEncrip));

    lhFolioAux1  = lNumFolio   ;
    lhNumProceso = lNumProceso ;
    strcpy(szhPrefPlazaEncrip,szPrefPlaza);

    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***"
                          "\n\n\t*** Parametros ***"        
                          "\n\t\t*** Num. Folio    [%ld]***" 
                          "\n\t\t*** Num. Proceso  [%ld]***" 
                          "\n\t\t*** Pref. Plaza   [%s]***"  /* P-MIX-09003 */
                          , LOG03
                          , modulo
                          , lNumFolio
                          , lNumProceso
                          , szPrefPlaza); /* P-MIX-09003 */

    /* EXEC SQL 
         SELECT FACT.ROWID,
		FACT.COD_CENTREMI ,
		TO_CHAR(FACT.FEC_EMISION,'YYYYMMDD'),
		TO_CHAR(FACT.FEC_EMISION,'HH24MISS'),
 		FACT.COD_TIPDOCUM,
	        FACT.COD_VENDEDOR_AGENTE,
		FACT.COD_OPERADORA,
		FACT.NUM_FOLIO,
		FACT.TOT_CARGOSME,
		FACT.ACUM_IVA,                       
		/oDECODE(IDENT.COD_TIPIDENTDIAN,'43','0',REPLACE(CLIE.NUM_IDENTTRIB,'-')),o/ /o P-MIX-09003 137744 o/
                NVL(IDENT.COD_TIPIDENTDIAN,'00')                       
	 INTO :szhRowid,
	      :ihCodCentrEmi,
	      :szhFecEmision,
	      :szhHorEmision,                        
	      :lhCodTipDocum,
	      :lhCodVendedorAgente,
	      :szhCodOperadora,
	      :lhFolioAux2,
              :dhTotCargosMe,                        
              :dhAcumIva,                            
              /o:szhNumIdTrib,o/ /o P-MIX-09003 137744 o/
              :szhCodIdTipDian                       
	 FROM FA_FACTDOCU_NOCICLO FACT,
	      FA_FACTCLIE_NOCICLO CLIE,              
              GE_TIPIDENT IDENT                      
	 WHERE FACT.NUM_PROCESO = :lhNumProceso
	 AND FACT.IND_ANULADA  = 0
	 AND FACT.IND_IMPRESA  >= 0 /oP-MIX-09003 Se incluye el =. Incidencia 115984 Req. 103o/
         AND FACT.IND_ORDENTOTAL = CLIE.IND_ORDENTOTAL 
         AND CLIE.COD_TIPIDTRIB  = IDENT.COD_TIPIDENT  
	 FOR UPDATE ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FACT.rowid  ,FACT.COD_CENTREMI ,TO_CHAR(FACT.FEC_E\
MISION,'YYYYMMDD') ,TO_CHAR(FACT.FEC_EMISION,'HH24MISS') ,FACT.COD_TIPDOCUM ,F\
ACT.COD_VENDEDOR_AGENTE ,FACT.COD_OPERADORA ,FACT.NUM_FOLIO ,FACT.TOT_CARGOSME\
 ,FACT.ACUM_IVA ,NVL(IDENT.COD_TIPIDENTDIAN,'00') into :b0,:b1,:b2,:b3,:b4,:b5\
,:b6,:b7,:b8,:b9,:b10  from FA_FACTDOCU_NOCICLO FACT ,FA_FACTCLIE_NOCICLO CLIE\
 ,GE_TIPIDENT IDENT where ((((FACT.NUM_PROCESO=:b11 and FACT.IND_ANULADA=0) an\
d FACT.IND_IMPRESA>=0) and FACT.IND_ORDENTOTAL=CLIE.IND_ORDENTOTAL) and CLIE.C\
OD_TIPIDTRIB=IDENT.COD_TIPIDENT) for update ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )168;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[0] = (unsigned long )20;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentrEmi;
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
    sqlstm.sqhstv[3] = (unsigned char  *)szhHorEmision;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodTipDocum;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedorAgente;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhFolioAux2;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhTotCargosMe;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhAcumIva;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhCodIdTipDian;
    sqlstm.sqhstl[10] = (unsigned long )3;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
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




    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"\n\tEn SQL-SELECT "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);

        vDTrazasError(modulo,"\n\tEn SQL-SELECT FA_FACTDOCU_NOCICLO WHERE"
                             "\n\t NUM_PROCESO = %ld AND IND_ANULADA = 0  AND IND_IMPRESA > 0 "
                             "\n\t\t=> Error : [%d]  [%s] "
        		    ,LOG01,lhNumProceso,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso, 0,"New_FolOnline", strcat(cfnGetTime(1), "=> select FA_FACTDOCU_NOCICLO err:") );
        return FALSE;
    }
    

    if (lhFolioAux2 > 0)
    {
    	lhFolio = lhFolioAux2;
    }
    else
    {
    	lhFolio = lhFolioAux1;
    }
    
    /* Nit Operadora */
    strcpy(szNitOperadora,stDatosGener.szNitOperadora);
    /* Clave Contenido Tecnico */
    strcpy(szKeyConTecnico,stDatosGener.szClaConTecnico);     
    
    /*if (!bfnEncriptaContTec (szCadenaResultado,szhPrefPlazaEncrip,
                             lhFolio,szhFecEmision,szhHorEmision,
                             dhTotCargosMe,dhAcumIva,
                             szKeyConTecnico,szhCodIdTipDian,
                             szhNumIdTrib, szNitOperadora))
    {
    	return(FALSE); 
    }*/ /* P-MIX-09003 137744 */
    
    strcpy(szCadenaResultado,"."); /* P-MIX-09003 137744 */
    
    sprintf(szCamposEncriptados,"%s\0",szCadenaResultado);
    
    vDTrazasLog(modulo , "\n\t\tRetorno Funcion Encriptación [%s]",LOG05,szCamposEncriptados);         
    
    /* Carga Codigo de Oficina segun Folio y Tipo de Documento*/    	
    if (!bfnCargaOficinaAlAsigDocumento ( lhFolio, lhCodTipDocum, 
                                          szhCodOperadora, szPrefPlaza, 
                                          szhCodOficina, szhResolucion, 
                                          szhFecResolucion, szhSerie, 
                                          szhEtiqueta, &lhRanDesde, &lhRanHasta))
    {
         return FALSE;
    }

    strcpy(szhPrefPlaza, szPrefPlaza);    
	
    vDTrazasLog  (modulo ,"\n\tValores a actualizar en Fa_Factdocu_Nociclo"
    			  "\n\tFolio [%ld] - Codigo Oficina [%s] - Pref. Plaza [%s] "
                         ,LOG04,lhFolio,szhCodOficina,szhPrefPlaza);
                         
    /* EXEC SQL 
             UPDATE FA_FACTDOCU_NOCICLO
	         SET NUM_FOLIO    = :lhFolio,
		     COD_OFICINA  = :szhCodOficina,
		     PREF_PLAZA   = :szhPrefPlaza,
		     KEY_CONTECNICO = :szKeyConTecnico, 
		     CONT_TECNICO = :szCamposEncriptados,
		     RESOLUCION = :szhResolucion,
		     FEC_RESOLUCION = TO_DATE(:szhFecResolucion,'DD-MM-YYYY'),
		     SERIE = :szhSerie,
		     ETIQUETA = DECODE(:szhEtiqueta, ' ', NULL, :szhEtiqueta),
		     RAN_DESDE = :lhRanDesde,
		     RAN_HASTA = :lhRanHasta
             WHERE ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0,COD_OFICINA\
=:b1,PREF_PLAZA=:b2,KEY_CONTECNICO=:b3,CONT_TECNICO=:b4,RESOLUCION=:b5,FEC_RES\
OLUCION=TO_DATE(:b6,'DD-MM-YYYY'),SERIE=:b7,ETIQUETA=DECODE(:b8,' ',null ,:b8)\
,RAN_DESDE=:b10,RAN_HASTA=:b11 where ROWID=:b12";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )231;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhFolio;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[2] = (unsigned long )26;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szKeyConTecnico;
    sqlstm.sqhstl[3] = (unsigned long )41;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szCamposEncriptados;
    sqlstm.sqhstl[4] = (unsigned long )41;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhResolucion;
    sqlstm.sqhstl[5] = (unsigned long )26;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecResolucion;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhSerie;
    sqlstm.sqhstl[7] = (unsigned long )11;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhEtiqueta;
    sqlstm.sqhstl[8] = (unsigned long )11;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhEtiqueta;
    sqlstm.sqhstl[9] = (unsigned long )11;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&lhRanDesde;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhRanHasta;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[12] = (unsigned long )20;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
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
        vDTrazasLog  (modulo,"\n\tEn SQL-UPDATE "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\tEn SQL-UPDATE "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso, 0,"New_FolOnline", strcat(cfnGetTime(1), "=> update FA_FACTDOCU_NOCICLO err:") );

        return FALSE;
    }

    return TRUE;

} /* FIN bfnUpdateFactDocuNoCiclo */

/* ***************************************************************************************************** */
/*                                   FUNCION : bfnUpdateDocuNoCiclo                                    * */
/* ***************************************************************************************************** */
BOOL bfnUpdateDocuNoCiclo   ( int iCodTipDocum, long lNumVenta	, long lNumProceso)
{
    char modulo[]="bfnUpdateDocuNoCiclo";
    
    char szCadenaResultado [200];
    char szCamposEncriptados[41];
    
    char pszPrefPlaza     [25+1]="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 long    plhFolio                  ;
	 char    szFolio            [10]="";
	 long    lhNumVenta                ;
	 long    lhNumProceso              ;
	 int     ihCodTipDocum             ;
	 char    szhRowid           [20]=""; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

	 int     ihCodCentrEmi             ;
	 char    szhFecEmision      [15]=""; /* EXEC SQL VAR szhFecEmision IS STRING(15); */ 

	 char    szhHorEmision      [15]=""; /* EXEC SQL VAR szhHorEmision IS STRING(15); */ 

	 long    lhCodTipDocum	           ;
	 long    lhCodVendedorAgente       ;
	 char    szhCodOficina       [3]=""; /* EXEC SQL VAR szhCodOficina IS STRING(2+1); */ 

	 char    szhCodOperadora     [6]=""; /* EXEC SQL VAR szhCodOperadora IS STRING(5+1); */ 

	 char    szhPrefPlaza     [25+1]=""; /* EXEC SQL VAR szhPrefPlaza IS STRING(25+1); */ 

	 long    lhFolioAux              =0;
	 char    szhPrefijoFolio    [22]="";
         double  dhTotCargosMe             ;
         double  dhAcumIva                 ; 
         char    szhCodIdTipDian     [3]=""; /* EXEC SQL VAR szhCodIdTipDian IS STRING(3); */ 
 
         char    szhNumIdTrib       [21]=""; /* EXEC SQL VAR szhNumIdTrib IS STRING(21); */ 
 
         char    szNitOperadora     [16]=""; /* EXEC SQL VAR szNitOperadora IS STRING(16); */ 

         char    szKeyConTecnico    [41]=""; /* EXEC SQL VAR szKeyConTecnico IS STRING(41); */ 
 
         /**/
         char    pszhResolucion    [25+1]=""; /* EXEC SQL VAR pszhResolucion IS STRING(25+1); */ 

         char    pszhSerie         [10+1]=""; /* EXEC SQL VAR pszhSerie IS STRING(10+1); */ 

         char    pszhEtiqueta      [10+1]=""; /* EXEC SQL VAR pszhEtiqueta IS STRING(10+1); */ 

         char    pszhFecResolucion [10+1]=""; /* EXEC SQL VAR pszhFecResolucion IS STRING(10+1); */ 

         long    plhRanDesde               ;
         long    plhRanHasta               ;
         
    /* EXEC SQL END DECLARE SECTION; */ 


	
    lhNumProceso = lNumProceso    ;
    lhNumVenta =   lNumVenta      ;
    ihCodTipDocum =iCodTipDocum   ;
    
    memset(pszhResolucion,'\0',strlen(pszhResolucion));
    memset(pszhSerie,'\0',strlen(pszhSerie));
    memset(pszhEtiqueta,'\0',strlen(pszhEtiqueta));
    memset(pszhFecResolucion,'\0',strlen(pszhFecResolucion));    

    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***"     
                          "\n\n\t*** Parametros ***"        
                          "\n\t\t*** iCodTipDocum    [%ld]***" 
                          "\n\t\t*** lNumVenta  [%ld]***" 
                          "\n\t\t*** lNumProceso  [%ld]***" 
                          , LOG03
                          , modulo
                          , iCodTipDocum
                          , lNumVenta
                          , lNumProceso);
                                                                                                     

    /* EXEC SQL 
         SELECT FACT.ROWID,
                TO_CHAR(FACT.FEC_EMISION,'YYYYMMDD'),
		TO_CHAR(FACT.FEC_EMISION,'HH24MISS'),
 		FACT.COD_OPERADORA,
		FACT.COD_OFICINA,
		FACT.TOT_CARGOSME,                   
		FACT.ACUM_IVA,                       
		/oDECODE(IDENT.COD_TIPIDENTDIAN,'43','0',REPLACE(CLIE.NUM_IDENTTRIB,'-')),o/ /o P-MIX-09003 137744 o/
                NVL(IDENT.COD_TIPIDENTDIAN,'00')                           
	 INTO   :szhRowid,
	        :szhFecEmision,
	        :szhHorEmision,                        
                :szhCodOperadora,
                :szhCodOficina,
                :dhTotCargosMe,                        
                :dhAcumIva,                            
                /o:szhNumIdTrib,o/ /o P-MIX-09003 137744 o/
                :szhCodIdTipDian                       
         FROM FA_FACTDOCU_NOCICLO FACT,                
              FA_FACTCLIE_NOCICLO CLIE,                
              GE_TIPIDENT IDENT
         WHERE FACT.NUM_PROCESO = :lhNumProceso
         AND FACT.IND_ORDENTOTAL = CLIE.IND_ORDENTOTAL 
         AND CLIE.COD_TIPIDTRIB  = IDENT.COD_TIPIDENT  
	 FOR UPDATE ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FACT.rowid  ,TO_CHAR(FACT.FEC_EMISION,'YYYYMMDD') \
,TO_CHAR(FACT.FEC_EMISION,'HH24MISS') ,FACT.COD_OPERADORA ,FACT.COD_OFICINA ,F\
ACT.TOT_CARGOSME ,FACT.ACUM_IVA ,NVL(IDENT.COD_TIPIDENTDIAN,'00') into :b0,:b1\
,:b2,:b3,:b4,:b5,:b6,:b7  from FA_FACTDOCU_NOCICLO FACT ,FA_FACTCLIE_NOCICLO C\
LIE ,GE_TIPIDENT IDENT where ((FACT.NUM_PROCESO=:b8 and FACT.IND_ORDENTOTAL=CL\
IE.IND_ORDENTOTAL) and CLIE.COD_TIPIDTRIB=IDENT.COD_TIPIDENT) for update ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )298;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[0] = (unsigned long )20;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhHorEmision;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&dhTotCargosMe;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhAcumIva;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodIdTipDian;
    sqlstm.sqhstl[7] = (unsigned long )3;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
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
        vDTrazasLog  (modulo,"\n\tEn SQL-SELECT "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);

        vDTrazasError(modulo,"\n\tEn SQL-SELECT FA_FACTDOCU_NOCICLO WHERE"
                             "\n\tNUM_PROCESO = %ld "
        		     "\n\t\t=> Error : [%d]  [%s] "
        		    ,LOG01,lhNumProceso,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso, 0,"New_FoliaOnline", strcat(cfnGetTime(1), "=> select FA_FACTDOCU_NOCICLO err:") );
        return FALSE;
    }

    vDTrazasLog (modulo , "\n\t*** Saliendo del query SQL-SELECT FA_FACTDOCU_NOCICLO [%s] [%d]***"     
                          , LOG03
                          , modulo
                          , SQLCODE);

    if (!iObtienefolio(pszPrefPlaza, 
                       &plhFolio, 
                       szFolio, 
                       ihCodTipDocum, 
                       szhCodOficina, 
                       szhCodOperadora, 
                       lhNumVenta, 
                       lhNumProceso,
                       pszhResolucion, 
                       pszhSerie,
                       pszhEtiqueta,
                       pszhFecResolucion,
                       &plhRanDesde,
                       &plhRanHasta))                                                              
    {
        return FALSE;
    }
    
    vDTrazasLog (modulo , "\n\t*** Saliendo de iObtienefolio [%s] ***"     
                          , LOG03
                          , modulo);    
        
    stInterFact.lNumFolio=plhFolio ;
    strncpy(stInterFact.szPrefPlaza,pszPrefPlaza,25);
        
    if (lhNumVenta > 0)
    {
       strncat(szhPrefijoFolio,pszPrefPlaza,strlen(pszPrefPlaza));
       strcat(szhPrefijoFolio,"-");
       strncat(szhPrefijoFolio,szFolio , strlen(szFolio));       
       
       /* EXEC SQL 
            INSERT INTO  GA_DOCVENTA 
                   (NUM_VENTA, 
                    COD_TIPDOCUM, 
                    NUM_FOLIO)
            VALUES (:lhNumVenta, 
                    :ihCodTipDocum, 
                    :szhPrefijoFolio); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 13;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "insert into GA_DOCVENTA (NUM_VENTA,COD_TIPDOCUM,NUM_FO\
LIO) values (:b0,:b1,:b2)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )349;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
       sqlstm.sqhstv[2] = (unsigned char  *)szhPrefijoFolio;
       sqlstm.sqhstl[2] = (unsigned long )22;
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
           vDTrazasLog  (modulo,"\n\tEn INSERT GA_DOCVENTA"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
           vDTrazasError(modulo,"\n\tEn SQL-INSERT GA_DOCVENTA "
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
           return FALSE;
       }                              
    }
    
    strncpy(szhPrefPlaza,pszPrefPlaza, 25);
    
    /* Nit Operadora */
    strcpy(szNitOperadora,stDatosGener.szNitOperadora);
    /* Clave Contenido Tecnico */
    strcpy(szKeyConTecnico,stDatosGener.szClaConTecnico);      
    
    /*if (!bfnEncriptaContTec (szCadenaResultado,szhPrefPlaza,
                             plhFolio,szhFecEmision,szhHorEmision,
                             dhTotCargosMe,dhAcumIva,
                             szKeyConTecnico,szhCodIdTipDian,
                             szhNumIdTrib, szNitOperadora))
    {
    	return(FALSE); 
    }*/ /* P-MIX-09003 137744 */
    
    strcpy(szCadenaResultado,"."); /* P-MIX-09003 137744 */
    
    sprintf(szCamposEncriptados,"%s\0",szCadenaResultado);
    
    vDTrazasLog(modulo , "\n\t\tRetorno Funcion Encriptación [%s]",LOG05,szCamposEncriptados); 
   
    /* EXEC SQL 
         UPDATE FA_FACTDOCU_NOCICLO
	     SET NUM_FOLIO      = :plhFolio,
	         PREF_PLAZA     = :szhPrefPlaza,
	         KEY_CONTECNICO = :szKeyConTecnico,  
	         CONT_TECNICO   = :szCamposEncriptados,
	         RESOLUCION     = :pszhResolucion,
	         SERIE          = :pszhSerie,
	         ETIQUETA       = :pszhEtiqueta,
	         FEC_RESOLUCION = TO_DATE(:pszhFecResolucion,'DD-MM-YYYY'),
	         RAN_DESDE      = :plhRanDesde,
	         RAN_HASTA      = :plhRanHasta
	 WHERE ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0,PREF_PLAZA=\
:b1,KEY_CONTECNICO=:b2,CONT_TECNICO=:b3,RESOLUCION=:b4,SERIE=:b5,ETIQUETA=:b6,\
FEC_RESOLUCION=TO_DATE(:b7,'DD-MM-YYYY'),RAN_DESDE=:b8,RAN_HASTA=:b9 where ROW\
ID=:b10";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )376;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&plhFolio;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szKeyConTecnico;
    sqlstm.sqhstl[2] = (unsigned long )41;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szCamposEncriptados;
    sqlstm.sqhstl[3] = (unsigned long )41;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)pszhResolucion;
    sqlstm.sqhstl[4] = (unsigned long )26;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)pszhSerie;
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)pszhEtiqueta;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)pszhFecResolucion;
    sqlstm.sqhstl[7] = (unsigned long )11;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&plhRanDesde;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&plhRanHasta;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[10] = (unsigned long )20;
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



    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"\n\tEn SQL-UPDATE "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\tEn SQL-UPDATE "
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso, 0, "New_FolOnline", strcat(cfnGetTime(1), "=> update FA_FACTDOCU_NOCICLO err:") );

        return FALSE;
    }

    return TRUE;

} /* FIN bfnUpdateDocuNoCiclo */

/* ************************************************************************* */
/* * FUNCION : bfnCargaOficinaAlAsigDocumento                              * */
/* * USO     : Carga Codigo de Oficina segun Num. Folio y Tipo de Docum.   * */
/* ************************************************************************* */
BOOL bfnCargaOficinaAlAsigDocumento ( long lFolio,           long lTipDocum, 
                                      char *szCodOperadora,  char *szPrefPlaza, 
                                      char *szCodOficina,    char *szResolucion, 
                                      char *szFecResolucion, char *szSerie, 
                                      char *szEtiqueta,      long *lRanDesde, long *lRanHasta)
{
    char modulo[]="bfnCargaOficinaAlAsigDocumento";

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

         long lhFolio             ;
         long lhTipDocum         ;
         char szhCod_Oficina         [3]; /* EXEC SQL VAR szhCod_Oficina   IS STRING(3); */ 

         char szhCodOperadora        [6]; /* EXEC SQL VAR szhCodOperadora  IS STRING(6); */ 

         char szhPrefPlaza        [25+1]; /* EXEC SQL VAR szhPrefPlaza     IS STRING(25+1); */ 

         /*P-MIX-09003 Se incluyen campos del Folio. Incidencia 115984*/
         char szhResolucion       [25+1]; /* EXEC SQL VAR szhResolucion    IS STRING(25+1); */ 

         char szhFecResolucion    [10+1]; /* EXEC SQL VAR szhFecResolucion IS STRING(10+1); */ 

         char szhSerie            [10+1]; /* EXEC SQL VAR szhSerie         IS STRING(10+1); */ 

         char szhEtiqueta         [10+1]; /* EXEC SQL VAR szhEtiqueta      IS STRING(10+1); */ 

         long lhRanDesde;
         long lhRanHasta;
         /*Fin P-MIX-09003 Incidencia 115984*/
         
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodOperadora, '\0',sizeof(szhCodOperadora));    
    memset(szhPrefPlaza,    '\0',sizeof(szhPrefPlaza));
    
    memset(szhResolucion,   '\0',sizeof(szhResolucion));    
    memset(szhFecResolucion,'\0',sizeof(szhFecResolucion));
    memset(szhSerie,        '\0',sizeof(szhSerie));
    memset(szhEtiqueta,     '\0',sizeof(szhEtiqueta));    

    vDTrazasLog  (modulo ,"\n\t *** Parametros de Entrada en bfnCargaOficinaAlAsigDocumento: "
                          "\n\t\tFolio [%ld] - Tipo Docum [%ld] - Cod. Oper. [%s] - Pref. Plaza [%s]"
    			 ,LOG04,lFolio, lTipDocum, szCodOperadora, szPrefPlaza);

    lhFolio = lFolio         ;
    lhTipDocum = lTipDocum ;
    strcpy (szhCodOperadora,szCodOperadora);
    strcpy (szhPrefPlaza,szPrefPlaza);
    
    vDTrazasLog  (modulo ,"\n\t *** Parametros Asignados en bfnCargaOficinaAlAsigDocumento: "
                          "\n\t\tFolio [%ld] - Tipo Docum [%ld] - Cod. Oper. [%s] - Pref. Plaza [%s]"
    			 ,LOG05,lhFolio, lhTipDocum, szhCodOperadora, szhPrefPlaza);    

    /* EXEC SQL
         SELECT DISTINCT COD_OFICINA, RESOLUCION, TO_CHAR(FEC_RESOLUCION, 'DD-MM-YYYY'), SERIE, NVL(ETIQUETA,' '), 
                         RAN_DESDE, RAN_HASTA
         INTO   :szhCod_Oficina, :szhResolucion, :szhFecResolucion, :szhSerie, :szhEtiqueta, 
                :lhRanDesde, :lhRanHasta
         FROM   AL_ASIG_DOCUMENTOS
         WHERE  COD_OPERADORA = :szhCodOperadora
         AND    :lhFolio BETWEEN RAN_DESDE AND RAN_HASTA
         AND    COD_TIPDOCUM = (SELECT COD_TIPDOCUM  FROM FA_TIPDOCUMEN
                                WHERE  COD_TIPDOCUMMOV = :lhTipDocum)
	 AND    PREF_PLAZA = :szhPrefPlaza ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select distinct COD_OFICINA ,RESOLUCION ,TO_CHAR(FEC_RESO\
LUCION,'DD-MM-YYYY') ,SERIE ,NVL(ETIQUETA,' ') ,RAN_DESDE ,RAN_HASTA into :b0,\
:b1,:b2,:b3,:b4,:b5,:b6  from AL_ASIG_DOCUMENTOS where (((COD_OPERADORA=:b7 an\
d :b8 between RAN_DESDE and RAN_HASTA) and COD_TIPDOCUM=(select COD_TIPDOCUM  \
from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b9)) and PREF_PLAZA=:b10)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )435;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Oficina;
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhResolucion;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecResolucion;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhSerie;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhEtiqueta;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhRanDesde;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhRanHasta;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhFolio;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhTipDocum;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[10] = (unsigned long )26;
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



    if (SQLCODE == SQLNOTFOUND) 
    {
        vDTrazasLog  ( modulo ,"\n\t**  No Existe Codigo de Oficina para Tipo de Documento [%ld] Folio [%ld] **",
                               LOG01,lhTipDocum,lhFolio);
        vDTrazasError  ( modulo ,"\n\t**  No Existe Codigo de Oficina para Tipo de Documento [%ld] Folio [%ld] **",
                               LOG01,lhTipDocum,lhFolio);
        return FALSE;
    }

    if (SQLCODE != SQLOK) {
        vDTrazasLog  ( modulo ,"\n\t**  Error en Select Al_Asig_Documentos (Codigo Oficina) **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo ,"\n\t**  Error en Select Al_Asig_Documentos (Codigo Oficina) **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    strcpy(szCodOficina,szhCod_Oficina);
    strcpy(szResolucion,szhResolucion);
    strcpy(szFecResolucion,szhFecResolucion);
    strcpy(szSerie,szhSerie);
    strcpy(szEtiqueta,szhEtiqueta);
    *lRanDesde = lhRanDesde;
    *lRanHasta = lhRanHasta;
    
    vDTrazasLog  (modulo ,"\n\tCodigo de Oficina [%s] " , LOG04,szCodOficina);
    vDTrazasLog  (modulo ,"\tResolucion          [%s] " , LOG04,szResolucion);
    vDTrazasLog  (modulo ,"\tFecha Resolucion    [%s] " , LOG04,szFecResolucion);
    vDTrazasLog  (modulo ,"\tSerie               [%s] " , LOG04,szSerie);
    vDTrazasLog  (modulo ,"\tEtiqueta            [%s] " , LOG04,szEtiqueta);
    vDTrazasLog  (modulo ,"\tRango Desde         [%ld] ", LOG04,*lRanDesde);
    vDTrazasLog  (modulo ,"\tRango Hasta         [%ld] ", LOG04,*lRanHasta);

    return TRUE;

}/* FIN bfnCargaOficinaAlAsigDocumento*/


/* ************************************************************************* */
/* * FUNCION : bfnCloseInterfaz                                            * */
/* * USO     : Cierra el Cursor de documentos a Foliar                     * */
/* ************************************************************************* */
BOOL bfnCloseInterfaz(char *szOperadora)
{
    char modulo[]="bfnCloseInterfaz";
    vDTrazasLog  (modulo, "\n\t** Entrada en %s"
                          "\n\t=============================="
                          "\n\tOPERADORA : [%s]"
                        , LOG04
                        , modulo
                        , szOperadora);

    if (strcmp(szOperadora,"TMS") == 0)
    {
        /* EXEC SQL CLOSE Cur_Interfaz1; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )494;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }
    else
    {
        /* EXEC SQL CLOSE Cur_Interfaz2; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )509;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    	
    }

    if (SQLCODE != SQLOK)
    {
        return FALSE;
    }

    return TRUE;
} /* FIN bfnCloseInterfaz */

/* ************************************************************************* */
/* * FUNCION : iObtienefolio                                               * */
/* ************************************************************************* */
int iObtienefolio ( char *pszPrefPlaza , long *pszlFolio, 
                    char *pszFolio     , int  iCodTipDocum, 
                    char *szCodOficina , char *szCodOperadora, 
                    long lNumVenta     , long lNumProceso,
                    char *pszResolucion, char *pszSerie,
                    char *pszEtiqueta  , char *pszFecResolucion,
                    long *pszlRanDesde , long *pszlRanHasta)
{
    char szDelim[2]            = ";";
    char *pCadResp                  ;
    int  iCantTokens             = 0;
    char szCodRetorno            [5];
    char szFolio               [9+1];    
    char modulo[]   ="iObtienefolio";
    long lFolio                     ;
    
    char szResolucion         [25+1];
    char szSerie              [10+1];    
    char szEtiqueta           [10+1];
    char szFecResolucion      [10+1];    
    char szRanDesde            [9+1];
    char szRanHasta            [9+1];        
    long lRanDesde                  ;
    long lRanHasta                  ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhCadResp    [100]; /* EXEC SQL VAR szhCadResp IS STRING(100); */ 

         int  ihCodTipDocum      ;
         int  ihCodTipDocuV      ;
         char szhCodOficina   [3];
         char szhCodOperadora [6];
         long lhNumVenta         ;
         long lhNumProceso       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szResolucion,'\0',26);
    memset(szSerie,'\0',11);    
    memset(szEtiqueta,'\0',11);
    memset(szFecResolucion,'\0',11);
    
    memset(szhCadResp,'\0',100);

    memset(szhCodOficina,'\0',3);        
    

    strncpy(szhCodOficina,szCodOficina,2);
    strncpy(szhCodOperadora,szCodOperadora,5);
    lhNumVenta = lNumVenta;
    lhNumProceso = lNumProceso;
    ihCodTipDocum = iCodTipDocum;  
    
    vDTrazasLog (modulo , "\n\t*** Entrando a FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN [%s] ***"     
                          , LOG03
                          , modulo);         
        
    vDTrazasLog (modulo, "\n\t**Valores para FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN:"
                         "\n\t***************************************************"
    			 "\n\t\tlhNumProceso  [%ld]"
    			 "\n\t\tszhCodOficina  [%s]"
    			 "\n\t\tihCodTipDocum [%d]"
    			 "\n\t\tlhNumVenta    [%ld]"  
    			 "\n\t\tszhCodOperadora    [%s]" 
    			,LOG05
    			,lhNumProceso 
    			,szhCodOficina 
    			,ihCodTipDocum
    			,lhNumVenta
    			,szhCodOperadora);   
       
    /* EXEC SQL
         SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(:ihCodTipDocum, NULL, :szhCodOficina, 
                                                    :szhCodOperadora, 0, :lhNumVenta, 
                                                    :lhNumProceso,sysdate,0)
         INTO    :szhCadResp
         FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(:b0,null ,:b1,\
:b2,0,:b3,:b4,sysdate,0) into :b5  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )524;
    sqlstm.selerr = (unsigned short)1;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodOperadora;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCadResp;
    sqlstm.sqhstl[5] = (unsigned long )100;
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


              
    vDTrazasLog (modulo, "\n\t** Resultado Cadena FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN: **"
    			 "\n\t\tszhCadResp   [%s]" 
    			,LOG05
    			,szhCadResp); 
    if(SQLCODE != SQLOK)
    {
       vDTrazasLog  ( modulo ,"\n\t** Error en Funcion FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN () [%d] **",LOG04,SQLCODE);
       return(FALSE);
    }
        
    /* DESCOMPOSICION DE LA CADENA DE RESPUESTA */
    
    /* Estado */
    pCadResp = strtok( szhCadResp, szDelim );
    vDTrazasLog (modulo, "\n\tPrimer Token pCadResp  [%s]" ,LOG05,pCadResp);
         		
    if(strncmp(pCadResp,"2",1) != 0)
    {
       vDTrazasLog  ( modulo ,"\n\t** NO encuentra folio FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN ( ) [%s] **",LOG04,szCodRetorno);
       return(FALSE);
    }
    if(pCadResp!=NULL)
    {
       strncpy(szCodRetorno,pCadResp,1);
       iCantTokens++;
    }
    else
    {
       vDTrazasLog (modulo, "\n\tPrimer valor **"   
                            "\n\t\t szCodRetorno [%s]" 
    			  ,LOG05
    			  ,szCodRetorno); 
    }

    /* Prefijo Folio */
    pCadResp = strtok( NULL, szDelim );
    vDTrazasLog (modulo, "\n\tSegundo Token pCadResp  [%s]" ,LOG05,pCadResp);    
    
    if(pCadResp!=NULL)
    {
       strncpy(pszPrefPlaza,pCadResp,strlen(pCadResp)); 
       iCantTokens++;
    }

    /* Numero Folio */
    pCadResp = strtok( NULL, szDelim );
    vDTrazasLog (modulo, "\n\tTercer Token pCadResp  [%s]" ,LOG05,pCadResp);
    
    if(pCadResp!=NULL)
    {
       strncpy(szFolio,pCadResp,strlen(pCadResp)); 
       lFolio= atol(szFolio);
       *pszlFolio= lFolio;
       strncpy(pszFolio,szFolio,9);
       iCantTokens++;
    }
    
    /****************************/
    
    /* Resolucion */
    pCadResp = strtok( NULL, szDelim );    
    if(pCadResp!=NULL)
    {
       strncpy(szResolucion,pCadResp,strlen(pCadResp)); 
       strcpy(pszResolucion,szResolucion);
       vDTrazasLog (modulo, "\n\tCuarto Token Resolucion = [%s]" ,LOG05,pszResolucion);
       iCantTokens++;
    }    
    
    /* Serie */    
    pCadResp = strtok( NULL, szDelim );    
    if(pCadResp!=NULL)
    {
       strncpy(szSerie,pCadResp,strlen(pCadResp)); 
       strcpy(pszSerie,szSerie);
       vDTrazasLog (modulo, "\n\tQuinto Token Serie = [%s]" ,LOG05,pszSerie);       
       iCantTokens++;
    } 
    
    /* Etiqueta */    
    pCadResp = strtok( NULL, szDelim );    
    if(pCadResp!=NULL)
    {
       strncpy(szEtiqueta,pCadResp,strlen(pCadResp)); 
       strcpy(pszEtiqueta,szEtiqueta);
       vDTrazasLog (modulo, "\n\tSexto Token Etiqueta = [%s]" ,LOG05,pszEtiqueta);
       iCantTokens++;
    }
        
    /* Rango Desde */    
    pCadResp = strtok( NULL, szDelim );
    if(pCadResp!=NULL)
    {
       strncpy(szRanDesde,pCadResp,strlen(pCadResp)); 
       lRanDesde = atol(szRanDesde);
       *pszlRanDesde= lRanDesde;
       vDTrazasLog (modulo, "\n\tSeptimo Token Rango Desde = [%ld]" ,LOG05,lRanDesde);
       iCantTokens++;
    }
        
    /* Rango Hasta */
    pCadResp = strtok( NULL, szDelim );    
    if(pCadResp!=NULL)
    {
       strncpy(szRanHasta,pCadResp,strlen(pCadResp)); 
       lRanHasta= atol(szRanHasta);
       *pszlRanHasta= lRanHasta;
       vDTrazasLog (modulo, "\n\tOctavo Token Rango Hasta = [%ld]" ,LOG05,lRanHasta);       
       iCantTokens++;
    }
        
    /* Fecha Resolucion */    
    pCadResp = strtok( NULL, szDelim );    
    if(pCadResp!=NULL)
    {
       strncpy(szFecResolucion,pCadResp,strlen(pCadResp));
       strcpy(pszFecResolucion,szFecResolucion);
       vDTrazasLog (modulo, "\n\tNoveno Token Fecha Resolucion = [%s]" ,LOG05,pszFecResolucion);
       iCantTokens++;
    }            
            
    /****************************/

    return(iCantTokens);
}/* FIN iObtienefolio */

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
