
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
           char  filnam[22];
};
static const struct sqlcxp sqlfpn =
{
    21,
    "./pc/co_cierre_web.pc"
};


static unsigned int sqlctx = 110554907;


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
   unsigned char  *sqhstv[9];
   unsigned long  sqhstl[9];
            int   sqhsts[9];
            short *sqindv[9];
            int   sqinds[9];
   unsigned long  sqharm[9];
   unsigned long  *sqharc[9];
   unsigned short  sqadto[9];
   unsigned short  sqtdso[9];
} sqlstm = {12,9};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,119,0,6,198,0,0,4,4,0,1,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,
36,0,0,2,60,0,6,278,0,0,2,2,0,1,0,2,97,0,0,1,97,0,0,
59,0,0,3,143,0,4,396,0,0,5,4,0,1,0,2,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
94,0,0,4,125,0,4,414,0,0,5,4,0,1,0,1,3,0,0,2,3,0,0,1,97,0,0,1,5,0,0,1,97,0,0,
129,0,0,5,95,0,4,432,0,0,3,2,0,1,0,2,5,0,0,1,97,0,0,1,97,0,0,
156,0,0,6,580,0,3,446,0,0,9,9,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,5,0,0,
1,97,0,0,1,97,0,0,1,3,0,0,1,5,0,0,
207,0,0,7,0,0,29,469,0,0,0,0,0,1,0,
222,0,0,8,96,0,5,492,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,
249,0,0,9,0,0,29,504,0,0,0,0,0,1,0,
};


/*=============================================================================
   Nombre         : co_cierre_web.pc
   Programa       : Generacion de registro de cierre para empresa virtual de web
   Autor          : G.A.C.
   Fecha Creacion : 07 - Septiembre - 2005
   Proyecto       : P-CO-05018 Pago de Saldo Potspago a través de WEB
==============================================================================*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pasoc.h>
#include <unistd.h>
#include "co_cierre_web.h"

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char  szhCod_Proceso   [6];
   long  lhPid_Proceso       ;
   char  szhEstado_Proc   [2];
	char  szHoraIni        [11]; /* EXEC SQL VAR szHoraIni IS STRING(11); */ 

	char  szhhhmiss        [11];
   char  szFechayyyymmdd  [9] ; /* EXEC SQL VAR szFechayyyymmdd IS STRING(9); */ 

   char  szhYYYYMMDD      [9] ;
   char  szhHH24miss      [11];
/* EXEC SQL END DECLARE SECTION; */ 

int   iDiffSeg = 0;
char  szHoraFin[9];
char  szTmpProc[9];
long  lTotalReg;

char szUsage[] = "\n\tUso : co_cierre_web  -u [Usuario]/[Password]\n"
                 "\t                     -l [Nivel de log. Por default es 3]\n\n";
 
int main( int argc, char* argv[] )
{
char modulo[]="main";
	
   memset (&stConfig,0,sizeof (CONFIGLOCAL));
	memset( szHoraIni, '\0', sizeof( szHoraIni ) );

   if (argc < 2) {
   	fprintf (stdout,"\n\tFaltan parametros.\n%s",szUsage);
      fflush  (stdout);
      exit(1);
   }

   /*- Validacion de parametros de entrada -*/
   memset(&stConfig,0,sizeof(CONFIGLOCAL));
   if (ifnValidaParametros(argc,argv,&stConfig) != 0)  {
        fprintf (stdout,"\n\tError >> Fallo en la Validacion de Parametros \n");
        fflush  (stdout);

   } else {

		if (ifnInicio(stConfig) != 0 ) {
		    fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
		    fflush  (stdout);
		}
		else
		{
			if (ifnGeneraCierreWeb() != 0) {
		   	vDTrazasLog( modulo, "\tProceso de Generacion de Registro de Cierre Web Finalizado con ERROR.\n\n", LOG03,modulo);
		   	fprintf (stdout,"\n\tError >> Fallo Funcion Principal \n");
		   	fflush  (stdout);
			}
		}

	   if (ifnUpdateColasProc("W")!=0) {
	       vDTrazasLog (modulo,"\t Funcion ifnUpdateColasProc(W) con Error ***\n",LOG03);
	       return -1;
	   }
		if( ifnExitcierreWeb() != 0 ) {
			fprintf (stdout,"\n\tError >> Fallo Funcion de estadistica \n");
			fflush  (stdout);
		}
	

	}
	fprintf(stderr, "\t< FIN DEL PROCESO: GENERACION DE REGISTRO DE CIERRE WEB >\n\n");
	return 0;

}/* Fin main */


/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], CONFIGLOCAL *pstLC )
{
char modulo[]="ifnValidaParametros";
/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
extern char  *optarg;
extern int  optind, opterr, optopt;
int    iOpt=0;
char   opt[]  = "u:l:n:";

char szUsuario[61] = "";
char *pszTmp       = "";

/*-- Flags de los valores recibidos ----------------------------------------------*/
int  Userflag=0;
int  Logflag=0;

/*-- Seteo de Valores Iniciales y por defecto -------------------------------------*/
    opterr=0;

    while ( (iOpt = getopt (argc,argv,opt)) != EOF)
    {
          switch (iOpt)
             {
                 case 'u':
                   if ( strlen (optarg) )
                   {
                        strcpy (szUsuario,optarg)  ;
                        stConfig.bOptUsuario = TRUE; 
                   }
                   break;
                 case 'l':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptNivelLog = TRUE;
                        stConfig.iNivelLog    = atoi(optarg);
                   }
                   break;   
		           case 'n': 
		             if ( strlen (optarg) ) {
		               sprintf(szhCod_Proceso,"%s",optarg);
		             }
		             break;   

             }/* fin switch */
    }/* fin While de Opciones */
    if (!stConfig.bOptUsuario)
    {
         fprintf(stderr,"\n\tError Falta Usuario en Parametros de Entrada: \n%s\n", szUsage);
         return -1;
    }
    else
    {
       if ( (pszTmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tFormato Usuario Oracle Incorrecto:\n%s\n", szUsage);
             return -1;
       }
       else
       {
          strncpy (stConfig.szUsuario ,szUsuario,pszTmp-szUsuario);
          strcpy  (stConfig.szPassWord, pszTmp+1);
       }
    }


    if( !stConfig.bOptNivelLog )
         stConfig.iNivelLog = iNIVEL_DEF;

    stStatus.LogNivel = stConfig.iNivelLog;
    
    return 0;

} /* ifnValidaParametros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB( CONFIGLOCAL pstLC)
{
char modulo[]="ifnConexionDB";

   if( !bfnConnectORA( pstLC.szUsuario, pstLC.szPassWord ) )   {
       fprintf (stderr,"\nNo hay conexion a ORACLE \n");
       fflush  (stderr);
       return -1;
    }

    return 0;
}
/* ============================================================================= */

/* ============================================================================= */
/* Funcion : ifnInicio										                     */
/* ============================================================================= */
int ifnInicio (CONFIGLOCAL pstConfig)
{
char modulo[]="ifnInicio";

	if (ifnConexionDB(pstConfig) != 0)   {
		fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
      fflush  (stdout);
      return -1;
	}

	strcpy(szhYYYYMMDD,"YYYYMMDD");
	strcpy(szhHH24miss,"hh24:mi:ss");

	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraIni := TO_CHAR(SYSDATE,:szhHH24miss);
        	:szFechayyyymmdd := TO_CHAR(SYSDATE,:szhYYYYMMDD);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szHoraIni := TO_CHAR ( SYSDATE , :szhHH24miss ) ; :sz\
Fechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMDD ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szHoraIni;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24miss;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szFechayyyymmdd;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[3] = (unsigned long )9;
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



   lhPid_Proceso=getpid();
   if (strlen(szhCod_Proceso)<1)  strcpy(szhCod_Proceso,"CCWEB");

	/*-----------------------------------------------------------------------*/
  	/* Inicializacion de Archivos LOG										 */
	/*-----------------------------------------------------------------------*/
  	if (ifnAbreArchivosLog(0)!=0) return -1;
  	

	vDTrazasLog( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  Generacion de Cierre Web               Hora : %s      "
						  "\n\t***************************************************************\n",LOG03,szhVersion,szHoraIni);	
	vDTrazasError( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  Errores en Generacion de Cierre Web    Hora : %s      "
						  "\n\t***************************************************************\n",LOG03,szhVersion,szHoraIni);	

   if (ifnUpdateColasProc("R")!=0) {
        vDTrazasLog (modulo,"\n\n\t Funcion ifnUpdateColasProc(R)***\n",LOG03);
        return -1;
   }
   
	return 0;
}/* fin a ifnInicio */

/*===========================================================================*/
/* Funcion que abre los archivos de log y de error                           */
/*===========================================================================*/
int ifnAbreArchivosLog()
{
char modulo[]="ifnAbreArchivosLog";
char *pathDir               ;
char szComando  [128]   ="" ;
char szPathLog  [128]   ="" ;
   /*-----------------------------------------------------------------------*/
   /* Inicializacion de estructura	de archivo								*/
   /*-----------------------------------------------------------------------*/
	memset(szArchivo,'\0',sizeof(szArchivo));
	strcpy(szArchivo,szhCod_Proceso);
	pathDir =(char *)malloc(228);

	pathDir =szGetEnv("XPC_LOG");
	sprintf(szPathLog  ,"%s/CO_SCHEDULER/%s",pathDir,szFechayyyymmdd);
	free(pathDir);
	sprintf(szComando,"/usr/bin/mkdir -p %s", szPathLog);
	system (szComando);

	sprintf(stStatus.ErrName,"%s/%s.err",szPathLog,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL ){
	    fprintf( stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
	    return -1;
	}

	sprintf(stStatus.LogName,"%s/%s.log",szPathLog,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) {
	    fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
    	return -1;
   }
   

   return 0;
}/* ifnAbreArchivosLog */


/* ============================================================================= */
/* Funcion ifnExitcierreWeb: finaliza proceso    				                     */
/* ============================================================================= */
int ifnExitcierreWeb (void)
{
char modulo[]="ifnExitcierreWeb";

	strcpy(szhhhmiss,"HH24:MI:SS");

	/* Datos Fin de Tiempo */
	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraFin := TO_CHAR(SYSDATE,:szhhhmiss);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szHoraFin := TO_CHAR ( SYSDATE , :szhhhmiss ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )36;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szHoraFin;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhhhmiss;
 sqlstm.sqhstl[1] = (unsigned long )11;
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



	iDiffSeg = ifnRestaHoras(szHoraIni,szHoraFin,szTmpProc);

   vDTrazasLog(modulo,"\n\t         HORA INICIO  : %s "
                      "\n\t         HORA TERMINO : %s "
                      "\n\t         TIEMPO TOTAL : %s  (%d segs)"
                      "\n\t REGISTROS PROCESADOS : %ld"
                      "\n\t PROMEDIO  x  REGISTRO: %.5f segs "
                      "\n\n",LOG03,szHoraIni,szHoraFin,szTmpProc,iDiffSeg,lTotalReg,(float)((float)iDiffSeg/(float)lTotalReg) );

	vDTrazasLog( modulo, "\tFin del Proceso de Generacion de Registro de Cierre Web.\n\n", LOG03,modulo);
	
	if ( fclose(stStatus.LogFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Log\n");
	    fflush  (stderr);
	}

	if ( fclose(stStatus.ErrFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Errores\n");
	    fflush  (stderr);
	}

	return 0;
}/* fin a ifnExitcierreWeb */


/*===========================================================================*/
/* Funcion RighTrim : Limpia blancos a la derecha                            */
/*===========================================================================*/
int RighTrim (char *szVar)
{
int  iLenVar = 0;
int  i       = 0;

   iLenVar = strlen(szVar);
   for (i=iLenVar-1;i>-1;i--) {
        if (szVar[i]==' ') {
            szVar[i]='\0';
        } else break;
   }
   return (0);        
} /* RighTrim */

/* ============================================================================= */
/* Copia un substr de un char a otro                                             */
/* ============================================================================= */
void Strcpysub(char *str1, int Largo, char *str2)
{
   int i;
   str2[0]='\0';
   for(i=0;i<=Largo-1;str2[i]=str1[i],i++);
   str2[i]='\0';
}

/* ============================================================================= */
/* Lleva una Hora dada a un valor equivalente en segundos                        */
/* ============================================================================= */
int HoraToSegs(char *HoraFmto)
{
  char *Hora,HH[3],MI[3],SS[3];
  int iHH,iMI,iSS;
  Hora=HoraFmto;
  Strcpysub(Hora,2,HH); Hora=Hora+3; /*HH:*/ iHH=atoi(HH); if (iHH<00||iHH>23) return -1;
  Strcpysub(Hora,2,MI); Hora=Hora+3; /*MI:*/ iMI=atoi(MI); if (iMI<00||iMI>59) return -1;
  Strcpysub(Hora,2,SS);              /*SS */ iSS=atoi(SS); if (iSS<00||iSS>59) return -1;
  return (iHH*3600+iMI*60+iSS);
}

/* ============================================================================= */
/* Resta dos string en fmto hora y retorna la diferencia en fmto hora y segundos */
/* ============================================================================= */
int ifnRestaHoras( char *h1, char *h2, char *hh)
{
  int ih1,ih2,ih;
  div_t hmsH,hmsMS;
  if ((ih1=HoraToSegs(h1))<0) return -1;
  if ((ih2=HoraToSegs(h2))<0) return -1;
  ih=(ih2>=ih1)?(ih2-ih1):(((24*3600)-ih1)+ih2); /* restando horas en segundos , considerando cambio de dia */
  hmsH=div(ih,3600);
  hmsMS=div(hmsH.rem,60);
  sprintf(hh,"%02d:%02d:%02d\0",hmsH.quot,hmsMS.quot,hmsMS.rem);
  return ih;
}

/* ============================================================================= */
/* Funcion principal que genera un registro de cierre web en la interfaz de pago */
/* ============================================================================= */
int ifnGeneraCierreWeb()
{
char modulo[]="ifnGeneraCierreWeb";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char   szhNum_Ejercicio[13]; /* EXEC SQL VAR szhNum_Ejercicio IS STRING(13); */ 
 
	char   szhNom_Usuario  [21]; /* EXEC SQL VAR szhNom_Usuario IS STRING(21); */ 
 
	int    ihCount             ;
	char   szhUSUARIO_SERV [20];
	char   szhModulo       [3];
	char   szhEmpresa_WEB  [4];
   char   szhServicio_INT [4];
	char   szhLetra_A      [2];
	char   szhLetra_O      [2];
	int    ihValor_cero    = 0 ;
	int    ihValor_uno     = 1 ;
	int    ihValor_ocho    = 8 ;
/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	strcpy(szhUSUARIO_SERV,"USUARIO_SERV_PL_SQL");
	strcpy(szhModulo,"GE");
	strcpy(szhEmpresa_WEB,"WEB");
	strcpy(szhServicio_INT,"INT");
	strcpy(szhLetra_A,"A");
	strcpy(szhLetra_O,"O");

   /* EXEC SQL
   SELECT UNIQUE NUM_EJERCICIO 
   INTO   :szhNum_Ejercicio
   FROM   CO_INTERFAZ_PAGOS 
   WHERE  EMP_RECAUDADORA = :szhEmpresa_WEB
   AND    SUBSTR(NUM_EJERCICIO,:ihValor_uno,:ihValor_ocho)=TO_CHAR(SYSDATE,:szhYYYYMMDD); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NUM_EJERCICIO into :b0  from CO_INTERFAZ_PAG\
OS where (EMP_RECAUDADORA=:b1 and SUBSTR(NUM_EJERCICIO,:b2,:b3)=TO_CHAR(SYSDAT\
E,:b4))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )59;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Ejercicio;
   sqlstm.sqhstl[0] = (unsigned long )13;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhEmpresa_WEB;
   sqlstm.sqhstl[1] = (unsigned long )4;
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
   sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_ocho;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhYYYYMMDD;
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



	if( SQLCODE==SQLNOTFOUND ) 	{
		vDTrazasLog( modulo, "\tNo existen Registros para este Periodo", LOG02,SQLERRM );
		return 0;
	}
	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tSELECT UNIQUE NUM_EJERCICIO CO_INTERFAZ_PAGOS  - %s", LOG00,SQLERRM );
		return -1;
	}
	vDTrazasLog( modulo, "\t\t ==> szhNum_Ejercicio [%s]\n", LOG03,szhNum_Ejercicio);


   /* EXEC SQL
   SELECT COUNT(:ihValor_uno)
   INTO   :ihCount
   FROM   CO_INTERFAZ_PAGOS 
   WHERE  EMP_RECAUDADORA = :szhEmpresa_WEB
   AND    NUM_EJERCICIO   = :szhNum_Ejercicio
   AND    SER_SOLICITADO  = :szhServicio_INT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(:b0) into :b1  from CO_INTERFAZ_PAGOS where (\
(EMP_RECAUDADORA=:b2 and NUM_EJERCICIO=:b3) and SER_SOLICITADO=:b4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )94;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_uno;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCount;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhEmpresa_WEB;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhNum_Ejercicio;
   sqlstm.sqhstl[3] = (unsigned long )13;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhServicio_INT;
   sqlstm.sqhstl[4] = (unsigned long )4;
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


	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tSELECT UNIQUE NUM_EJERCICIO CO_INTERFAZ_PAGOS  - %s", LOG00,SQLERRM );
		return -1;
	}

	if (ihCount > 0)  {
		vDTrazasLog( modulo, "\n\tYa existe un Registro de Cierre para este Periodo", LOG02,SQLERRM );
		return 0;
	}
   
   memset(szhNom_Usuario,'\0',sizeof(szhNom_Usuario));
   /* EXEC SQL
   SELECT VAL_PARAMETRO
   INTO   :szhNom_Usuario
   FROM   GED_PARAMETROS
   WHERE  NOM_PARAMETRO = :szhUSUARIO_SERV
   AND    COD_MODULO    = :szhModulo; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where (\
NOM_PARAMETRO=:b1 and COD_MODULO=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )129;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhNom_Usuario;
   sqlstm.sqhstl[0] = (unsigned long )21;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhUSUARIO_SERV;
   sqlstm.sqhstl[1] = (unsigned long )20;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
   sqlstm.sqhstl[2] = (unsigned long )3;
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



	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tSELECT VAL_PARAMETRO GED_PARAMETROS  - %s", LOG00,SQLERRM );
		return -1;
	}

	vDTrazasLog( modulo, "\t\t ==> szhNom_Usuario   [%s]\n\n", LOG03,szhNom_Usuario);

	/* EXEC SQL
	INSERT INTO CO_INTERFAZ_PAGOS 
			 (EMP_RECAUDADORA , COD_CAJA_RECAUDA , SER_SOLICITADO  , FEC_EFECTIVIDAD, NUM_TRANSACCION, 
			  NOM_USUARORA    , TIP_TRANSACCION  , SUB_TIP_TRANSAC , COD_SERVICIO   , NUM_EJERCICIO  ,
			  COD_CLIENTE     , NUM_CELULAR      , IMP_PAGO        , NUM_FOLIOCTC   , NUM_IDENT      , 
			  TIP_VALOR       , NUM_DOCUMENTO    , COD_BANCO       , CTA_CORRIENTE  , COD_AUTORIZA   , 
			  CAN_DEBE        , MTO_DEBE         , CAN_HABER       , MTO_HABER      , COD_ESTADO     , 
			  COD_ERROR       , NUM_COMPAGO      , NUM_TARJETA     , COD_TIPIDENT   , PREF_PLAZA     ) 
	VALUES (:szhEmpresa_WEB , :ihValor_uno     , :szhServicio_INT, SYSDATE        , :ihValor_cero  ,
	        :szhNom_Usuario , :szhLetra_A      , :szhLetra_O     , :ihValor_ocho  , :szhNum_Ejercicio, 
	        NULL            , NULL             , NULL            , NULL           , NULL           , 
	        NULL            , NULL             , NULL            , NULL           , NULL           , 
	        NULL            , NULL             , NULL            , NULL           , NULL           , 
	        NULL            , NULL             , NULL            , NULL           , NULL          ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_INTERFAZ_PAGOS (EMP_RECAUDADORA,COD_CAJA_RECA\
UDA,SER_SOLICITADO,FEC_EFECTIVIDAD,NUM_TRANSACCION,NOM_USUARORA,TIP_TRANSACCIO\
N,SUB_TIP_TRANSAC,COD_SERVICIO,NUM_EJERCICIO,COD_CLIENTE,NUM_CELULAR,IMP_PAGO,\
NUM_FOLIOCTC,NUM_IDENT,TIP_VALOR,NUM_DOCUMENTO,COD_BANCO,CTA_CORRIENTE,COD_AUT\
ORIZA,CAN_DEBE,MTO_DEBE,CAN_HABER,MTO_HABER,COD_ESTADO,COD_ERROR,NUM_COMPAGO,N\
UM_TARJETA,COD_TIPIDENT,PREF_PLAZA) values (:b0,:b1,:b2,SYSDATE,:b3,:b4,:b5,:b\
6,:b7,:b8,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,null ,nu\
ll ,null ,null ,null ,null ,null ,null ,null ,null )";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )156;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhEmpresa_WEB;
 sqlstm.sqhstl[0] = (unsigned long )4;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhServicio_INT;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhNom_Usuario;
 sqlstm.sqhstl[4] = (unsigned long )21;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_O;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&ihValor_ocho;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNum_Ejercicio;
 sqlstm.sqhstl[8] = (unsigned long )13;
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

 
	
	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tINSERT INTO CO_INTERFAZ_PAGOS  - %s", LOG00,SQLERRM );
		return -1;
	}

	lTotalReg++;
	vDTrazasLog( modulo, "\t* Registro de Cierre Insertado con Exito en Co_Interfaz_Pagos\n", LOG03);

   /* EXEC SQL COMMIT WORK; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 9;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )207;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if (SQLCODE != SQLOK ) {
       vDTrazasLog (modulo,"\t Error en COMMIT WORK\n",LOG00);
       return -1;
   }

	return 0;

}/* Fin ifnGeneraCierreWeb */

/* ============================================================================= */
/* Funcion que actualiza la cola de proceso en la tabla co_colasproc             */
/* ============================================================================= */
int ifnUpdateColasProc(char *pszEstado)
{
char modulo[]="ifnUpdateColasProc";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhEstado  [2];
/* EXEC SQL END DECLARE SECTION; */ 
    
    
    strcpy(szhEstado,pszEstado);

    vDTrazasLog (modulo,"\t Actualizando CO_COLASPROC con Estado [%s]*****",LOG03,pszEstado);
    /* EXEC SQL
    UPDATE CO_COLASPROC SET
           COD_ESTADO  = :szhEstado,
           FEC_ESTADO  = SYSDATE,
           PID_PROCESO = :lhPid_Proceso
    WHERE  COD_PROCESO = :szhCod_Proceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_COLASPROC  set COD_ESTADO=:b0,FEC_ESTADO=SYSDAT\
E,PID_PROCESO=:b1 where COD_PROCESO=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )222;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhPid_Proceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Proceso;
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


    
    if (SQLCODE != SQLOK ) {
        vDTrazasLog (modulo,"\t Error en ifnUpdateColasProc\n",LOG00);
        return -1;
    }
        
    /* EXEC SQL COMMIT WORK; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )249;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE != SQLOK ) {
        vDTrazasLog (modulo,"\t Error en COMMIT WORK CO_COLASPROC\n",LOG00);
        return -1;
    }

    return 0;
}

/******************************************************************************************/
/** Informaci¢n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi¢n                                            : */
/**  %PR% */
/** Autor de la Revisi¢n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi¢n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci¢n de la Revisi¢n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
