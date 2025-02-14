
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
           char  filnam[20];
};
static struct sqlcxp sqlfpn =
{
    19,
    "./pc/New_FolAuto.pc"
};


static unsigned int sqlctx = 27699507;


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
   unsigned char  *sqhstv[7];
   unsigned long  sqhstl[7];
            int   sqhsts[7];
            short *sqindv[7];
            int   sqinds[7];
   unsigned long  sqharm[7];
   unsigned long  *sqharc[7];
   unsigned short  sqadto[7];
   unsigned short  sqtdso[7];
} sqlstm = {12,7};

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
"select NUM_PROCESO  from FA_INTERFACT where (((COD_MODGENER=:b0 and COD_ESTA\
DOC=:b1) and COD_ESTPROC=:b2) and COD_APLIC=:b3) order by NUM_PROCESO         \
   ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,157,0,9,421,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
36,0,0,1,0,0,13,452,0,0,1,0,0,1,0,2,3,0,0,
55,0,0,2,321,0,4,627,0,0,7,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,
0,0,1,3,0,0,
98,0,0,3,92,0,5,681,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
129,0,0,4,52,0,4,721,0,0,1,0,0,1,0,2,5,0,0,
148,0,0,1,0,0,15,760,0,0,0,0,0,1,0,
};


/* ************************************************************************* */
/* *  Fichero : New_FolAuto.pc                                             * */
/* *  Foliacion de Documentos autofoliados                                 * */
/* ************************************************************************* */

#define _FOLIACION_PC_
#include "New_FolAuto.h"

/********** ******************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                            */
/*****************************************************************************/
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
/*****************************************************************************/
/*  Funcion :   main                                                         */
/*****************************************************************************/
int main(int argc, char *argv[])
{
	char modulo[]="main";
	char prueba[254];
	pid =getpid();

	fprintf( stdout, "\n***** Auto - Foliacion *****\n"
					 "**%s**\n**** pid : [ %8ld ] ****"
	                 "\n****************************\n", cfnGetTime(1),pid );
    memset(&stLineaComando,0,sizeof(FOLIACIONLINEACOMANDO));
    memset(&stStatus,'\0',sizeof(STATUS));

    if (!bfnValidaParametros(argc,argv,&stLineaComando))
    	return 1;

    if(!bfnConnectORA(stLineaComando.szOraAccount,stLineaComando.szOraPasswd))
    {
        vDTrazasError(modulo, "<< Usuario/Password Invalido >>", LOG01);
        return 2;
    }

    if (!bfnAbreArchivos(&stLineaComando,szSysDate)) 	return 4;

    if(!bfnFoliacionOnline(&stLineaComando))
    {
        vDTrazasError(modulo, "\n**** Proceso Terminado de Forma Irregular ****",LOG03);
        vDTrazasLog  (modulo, "\n**** Proceso Terminado de Forma Irregular ****",LOG03);
        return 5;
    }
    else
    {
        vDTrazasLog  (modulo, "\n**** Proceso Terminado Correctamente ****",LOG03);
        if (!bfnOraCommit())
        {
            vDTrazasLog  (modulo, "\n**** Fallo en el Commit ****",LOG03);
            vDTrazasError(modulo, "\n**** Fallo en el Commit ****",LOG03);
            return 6;
        }
    }

    if(!bfnDisconnectORA(0))
    {
      	vDTrazasLog  (modulo, "\nError, Desconectando de  ORACLE",LOG04);
      	vDTrazasError(modulo, "\nError, Desconectando de  ORACLE",LOG04);
	}

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);

    return 0;

} /* ******************************* Main ********************************** */


/* ************************************************************************* */
/* * Funcion bfnValidaParametros                                           * */
/* ************************************************************************* */
/* * Realiza la validacion de los Parametros de Entrada                    * */
/* ************************************************************************* */
BOOL bfnValidaParametros( int argc, char *argv[]
						, FOLIACIONLINEACOMANDO *pstLineaCom )
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
       stStatus.LogNivel = iLOGNIVEL_DEF ; /* asume nivel de log por defecto */
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
            strcpy  (pstLineaCom->szOraPasswd, psztmp+1)                 ;
		}
	}

	return TRUE;

} /* ************************ bfnValidaParamatros ************************** */

/* ************************************************************************* */
/* * Funcion bfnAbreArchivos                                               * */
/* ************************************************************************* */
/* * Realiza la apertura de archivos de Logs, Errores y Datos              * */
/* ************************************************************************* */
BOOL bfnAbreArchivos(FOLIACIONLINEACOMANDO *pstLineaCom, char *szDate)
{
 	char modulo[]="bfnAbreArchivos";

    char    *szDirLogs               ;
    char    *szNomArchivo            ;
    char    szComando[1024] = ""     ;

    szDirLogs    = (char *)malloc(1024);
    szNomArchivo = (char *)malloc(128);

    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL) return FALSE;

   	sprintf (pstLineaCom->szDirLogs,"%s/New_FolAuto/%s",szDirLogs,cfnGetTime(2));
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

   	fprintf (stdout, "\nCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01
        			 ,szComando);
        return FALSE;
    }

	fprintf(stdout, "\nCrea Archivo Log/Err : New_FolOnline_%s_%s\n\n"
				  ,pstLineaCom->szCodModGener, szDate );

    sprintf(szNomArchivo,"%s/New_FolOnline_%s_%s",pstLineaCom->szDirLogs
    					,pstLineaCom->szCodModGener,szDate);

    sprintf(stStatus.ErrName,"%s.err",szNomArchivo);
    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
        vDTrazasError ( modulo,"*** No puede abrirse el fichero de error %s",LOG01
        			  , stStatus.ErrName);
        return FALSE;
    }

    sprintf(stStatus.LogName, "%s.log",szNomArchivo);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL)
    {
        vDTrazasError( modulo,"*** No puede abrirse el fichero de log %s",LOG01
        			 , stStatus.LogName);
        fclose(stStatus.ErrFile);
        return FALSE;
    }

    vDTrazasLog  (modulo,"\n*************************************"
                         "\n****        Log   Foliacion        **"
                         "\n*************************************" ,LOG03);
    vDTrazasLog  (modulo,"\n*** Parametro de Entrada Foliacion **"
                         "\n=> Usuario               [%s]"
                         "\n=> Password              [************]"
                         "\n=> Cod.ModGener          [%s]"
                         "\n=> Niv.Log               [%d]"
                         ,LOG05,pstLineaCom->szOraAccount
                         ,pstLineaCom->szCodModGener
                         ,pstLineaCom->iNivLog);

    return TRUE;

} /* ************************** bfnAbreArchivos **************************** */

/* ************************************************************************* */
/* * Funcion bfnFoliacionOnline                                            * */
/* ************************************************************************* */
/* * Realiza la asignacion de folios legales por tipo de dopcumento        * */
/* * por rangos de clientes segun el orden generado                        * */
/* ************************************************************************* */
BOOL bfnFoliacionOnline ( FOLIACIONLINEACOMANDO *pstLineaCom )
{
	char modulo[]="bfnFoliacionOnline";

    char    szFecha [20]	=   ""  		;/* Fecha de Sistema para Update de Traza */
    long    lFolioUpdate	= 0     		;/* Folio Asignado para Update            */
    int     iSql        	= 0  			;/* Retorno de Fetch de Documentos        */
    BOOL    bFinCursor 		= FALSE			;
    BOOL	bTerminoOK		= TRUE			;
    int 	iCont 			= 0				;
    int 	iFol 			= 0 			;
    int     iStatusFin 		= iESTAQUEUE_WAIT; /* Estado de la cola de procesos */
    char    *szStatusFin					;
    char	szCodOficina[3]	= ""			;

    vDTrazasLog ( modulo, "\n*** Entrada en %s ***"
    					  "\n%s[%ld] Obtencion datos cola"
    					  ,LOG04,modulo, cfnGetTime(1), pid);

    memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );

    strcpy(stIntQueueProc.szCodAplic     , "FAC" );
    strcpy( stIntQueueProc.szCodModGener , pstLineaCom->szCodModGener);
    stIntQueueProc.lCodProceso   		 = iPROCESO_INT_FOLIACION_AUTO;

    if(!bfnGetIntQueueProc(&stIntQueueProc))
    {
		return FALSE;
	}
    if (!bfnOpenInterfaz(stIntQueueProc, iESTAPROC_TERMINADO_OK))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

    /* Carga Codigo de Oficina Central */

    if (!bfnGetOficinaCentral(szCodOficina))
    {
        return FALSE;
	}

    iCont=0;
    iFol=0;
    do
    {
		memset(&stRegDocumFoli,0,sizeof(FOLIACIONREGINTERFAZ));

		iSql=ifnFetchInterfaz(&stRegDocumFoli);

		if(iSql !=SQLOK && iSql !=SQLNOTFOUND)
		{
	        vDTrazasError(modulo, " Oracle Inesperado [%d] " ,LOG01,iSql);
	        vDTrazasLog  (modulo, " Oracle Inesperado [%d] " ,LOG01,iSql);
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
			if(!bfnUpdateFolios(&stRegDocumFoli, szCodOficina, &iFol))
			{
				vDTrazasLog  ( modulo, "**Al Marcar Folio a Documento ",LOG01);
				vDTrazasError( modulo, "**Al Marcar Folio a Documento ",LOG01);
				bFinCursor = TRUE;
				bTerminoOK = FALSE;
	        	iStatusFin = iESTAQUEUE_ERROR;
			}
			iCont++;
		}
	}while (!bFinCursor);

    vDTrazasLog  (modulo, "\n** Total de Registros Verificados : %d "
    					  "\n** Total de Registros Foliados    : %d ", LOG03, iCont, iFol);

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
    }

	if (!bfnCambiaEstCola(pstLineaCom->szCodModGener, iPROCESO_INT_FOLIACION_AUTO, iESTAQUEUE_RUNNING, iStatusFin,"FAC"))
	{
		if (!fnOraRollBack())
	    	vDTrazasError(modulo,"En Rollback \n%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
	    return FALSE;
	}
	else
	{	if (!fnOraCommit())
		{	vDTrazasError(modulo,"En Commit \n%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			if (!fnOraRollBack())
	    		vDTrazasError(modulo,"En Rollback \n%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
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
    char modulo[]="bfnOpenInterfaz" ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char szhCodAplic	[4];
    	char szhCodModGener [4] = "";
    	 int ihCodEstaDocEnt    = 0 ;
    	 int ihCodEstProc       = 0 ;
 	     int ihNumDeltaHoras;
    /* EXEC SQL END DECLARE SECTION; */ 


	strcpy( szhCodAplic		, stIntQueueProc.szCodAplic);
    strcpy( szhCodModGener  , stIntQueueProc.szCodModGener);
   	ihCodEstaDocEnt 		= stIntQueueProc.iCodEstaDocEnt;
   	ihCodEstProc    		= iCodEstProc  ;
   	/* RAO07062002: revisar com ose puede implemetar el deltahoras sin campo fijo */
   	/* ihNumDeltaHoras 		= stIntQueueProc.iNumDeltaHoras; */
	/* AND  FEC_IMPRESION  < (SYSDATE - (:ihNumDeltaHoras / 24)) */

    vDTrazasLog (modulo,"\n*** Entrada en %s ***"
    					"\n=> COD_ESTADOC = :ihCodEstaDocEnt [%d] "
    					"\n=> COD_ESTPROC = :ihCodEstProc    [%d] "
	            		, LOG04, modulo, ihCodEstaDocEnt, ihCodEstProc);

	/* EXEC SQL DECLARE  Cur_Interfaz  CURSOR FOR
			  SELECT  NUM_PROCESO
			    FROM  FA_INTERFACT
			   WHERE  COD_MODGENER = :szhCodModGener
			     AND  COD_ESTADOC  = :ihCodEstaDocEnt
			     AND  COD_ESTPROC  = :ihCodEstProc
			     AND  COD_APLIC    = :szhCodAplic
 			ORDER BY  NUM_PROCESO ; */ 


    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "\n** En SQL-DECLARE Cur_Interfaz **"
                               "\n=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo , "\n**  En SQL-DECLARE Cur_Interfaz **"
                               "\n=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    /* EXEC SQL OPEN Cur_Interfaz ; */ 

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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstProc;
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
        vDTrazasLog  (modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/* bfnOpenInterfaz */


/* ************************************************************************* */
/* * Funcion ifnFetchInterfaz                                              * */
/* ************************************************************************* */
/* * Lee Un Registro de los documentos a Foliar                            * */
/* ************************************************************************* */
int ifnFetchInterfaz(FOLIACIONREGINTERFAZ *pstRegDocumFoli)
{
	char modulo[]="ifnFetchInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long  lhNumProceso	;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo , "\n*** Entrada en %s ***",LOG04,modulo);

    /* EXEC SQL FETCH Cur_Interfaz INTO
				   :lhNumProceso; */ 

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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (modulo,"En FETCH sobre CURSOR Cur_Interfaz [%s]"
        			 ,LOG01,SQLERRM);
        vDTrazasError(modulo,"En FETCH sobre CURSOR Cur_Interfaz [%s]"
        			 ,LOG01,SQLERRM);
        return SQLCODE ;
    }

    if( SQLCODE == SQLNOTFOUND )
    {
        vDTrazasLog  (modulo, "\nNo Existen Mas Documentos en CURSOR Cur_FacturFolios ",LOG04);
        return SQLCODE ;
    }
    else
    {
        pstRegDocumFoli->lNumProceso = lhNumProceso;
    }

    vDTrazasLog (modulo , "\n=> Num Proceso [%ld]"
                          ,LOG05 ,pstRegDocumFoli->lNumProceso );
    return SQLCODE ;

} /* ifnFetchInterfaz */


/* ************************************************************************* */
/* * Funcion bfnUpdateFolios                                               * */
/* ************************************************************************* */
/* * Modifica el Folio de un Documento                                     * */
/* ************************************************************************* */
BOOL bfnUpdateFolios(FOLIACIONREGINTERFAZ *pstRegDocumFoli, char *szCodOficina, int *iFol)
{
	char modulo[]="bfnUpdateFolios";

	BOOL bContinuar =TRUE;
	BOOL bVerSgte   =TRUE;

    vDTrazasLog (modulo , "\n*** Entrada en %s ***",LOG04,modulo);

    memset(&stInterFact,0,sizeof(INTERFACT));
    stInterFact.lNumProceso     = pstRegDocumFoli->lNumProceso ;
    strcpy(stInterFact.szCodAplic,"FAC");  /* Incorporado por PGonzaleg 25-01-2002 */


    if (!bfnGetInterFact(&stInterFact))
    {
        vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                     ,LOG01,SQLCODE,szfnORAerror());
        return FALSE;
    }

	memset(&stRegAlConDoc,0,sizeof(FOLIACIONALCONSUDOCUM)) ;

	stInterFact.iCodEstaDoc = stIntQueueProc.iCodEstaDocSal;/* FOLIADA */
	stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;        /* PROCESANDO */
	strcpy(stInterFact.szCodAplic,"FAC");  /* Incorporado por PGonzaleg 25-01-2002 */

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
			vDTrazasLog  ( modulo, " Al hacer Commit ",LOG01);
			vDTrazasError( modulo, " Al hacer Commit ",LOG01);
			bContinuar=FALSE;
			bVerSgte=TRUE;
		}
		else
		{
			/* Se reemplaza por la funcion que usa Pl/sql */
			/* if (!bfnGetFolio(szCodOficina,stInterFact.iCodTipDocum, &pstRegDocumFoli->lNumFolio )) */

    		if (!bfnUpdateFactDocuNoCiclo   (pstRegDocumFoli->lNumProceso
    		                                ,szCodOficina))
	    	{
		    	vDTrazasLog  ( modulo, " Al hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
			    vDTrazasError( modulo, " Al hacer Update sobre FA_FACTDOCU_NOCICLO ",LOG01);
	            fnOraRollBack();
	            stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_ERROR ;/* ERROR   */
	            strcpy(stInterFact.szCodAplic,"FAC");  /* Incorporado por PGonzaleg 25-01-2002 */

			    bfnUpdInterFact(stInterFact);
			    bfnOraCommit();
			    bContinuar=FALSE;
		    }
		    else
		    {
		        stInterFact.iCodEstaProc    = iESTAPROC_TERMINADO_OK ;   /* OK      */
		        strcpy(stInterFact.szFecFoliacion, cfnGetTime(7));
		        strcpy(stInterFact.szCodAplic,"FAC");  /* Incorporado por PGonzaleg 25-01-2002 */

    			if (!bfnUpdInterFact(stInterFact))
			    {
    				vDTrazasLog  ( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
				    vDTrazasError( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
			        fnOraRollBack();
				    bContinuar=FALSE;
			    }
			    else
			    {
			        if (!bfnOraCommit())
        			{
		    	    	vDTrazasLog  ( modulo, " Al hacer Commit ",LOG01);
			    	    vDTrazasError( modulo, " Al hacer Commit ",LOG01);
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
		vDTrazasLog  ( modulo, "\n********* No sigue con este registro pasa al siguiente ******** ",LOG04);
		vDTrazasError( modulo, "\n********* No sigue con este registro pasa al siguiente ******** ",LOG04);
	}


	return TRUE;

}/* bfnUpdateFolios */



/* ************************************************************************* */
/* * Funcion bfnUpdateFactDocuNoCiclo					                   * */
/* ************************************************************************* */
/* * Modifica el Folio de un Documento en la Fa_FactDocu_NoCiclo           * */
/* ************************************************************************* */
BOOL bfnUpdateFactDocuNoCiclo(long lNumProceso, char *szCodOficina)
{
    char modulo[]="bfnUpdateFactDocuNoCiclo";


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long lhFolio         		;
   			long lhNumProceso    		;
   			 int ihCodTipDocum   		;
   			char szhRowid[20]="" 		;	/* EXEC SQL VAR szhRowid IS STRING(20); */ 

			 int ihCodCentrEmi   		;
			char szhFecEmision[15]=""	;	/* EXEC SQL VAR szhFecEmision IS STRING(15); */ 

			long lhCodTipDocum			;
			long lhCodVendedorAgente	;
            char szhCodOficina   [3]="" ;	/* EXEC SQL VAR szhCodOficina IS STRING(3); */ 

            char szhCodOperadora [6]="" ;	/* EXEC SQL VAR szhCodOperadora IS STRING(6); */ 

            /*char szhPrefPlaza    [4]="" ;	EXEC SQL VAR szhPrefPlaza IS STRING(4);*/
            char szhPrefPlaza    [11]="" ;	/* EXEC SQL VAR szhPrefPlaza IS STRING(11); */ 
	/* Incorporado por PGonzalez 19-03-2004 */
    /* EXEC SQL END DECLARE SECTION; */ 


	lhNumProceso = lNumProceso    ;
	strcpy (szhCodOficina, szCodOficina);

    vDTrazasLog (modulo , "\n*** Entrada en %s ***"
                          "\n*** Parametros ***"
                          "\n*** lNumProceso  [%ld]***"
                          , LOG03
                          , modulo
                          , lNumProceso);

	/* EXEC SQL SELECT A.ROWID,
					A.COD_CENTREMI ,
					TO_CHAR(A.FEC_EMISION,'YYYYMMDDHH24MISS'),
 					B.COD_TIPDOCUM,
				    A.COD_VENDEDOR_AGENTE,
				    A.COD_OPERADORA
			   INTO :szhRowid,
			   		:ihCodCentrEmi,
			   		:szhFecEmision,
			   		:lhCodTipDocum,
			   		:lhCodVendedorAgente,
			   		:szhCodOperadora
			   FROM FA_FACTDOCU_NOCICLO A, FA_TIPDOCUMEN B
		      WHERE A.NUM_PROCESO = :lhNumProceso
				AND A.IND_ANULADA  = 0
				AND A.NUM_FOLIO    = 0
				AND A.COD_TIPDOCUM=B.COD_TIPDOCUMMOV
		 FOR UPDATE ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.rowid  ,A.COD_CENTREMI ,TO_CHAR(A.FEC_EMISION,'YYYY\
MMDDHH24MISS') ,B.COD_TIPDOCUM ,A.COD_VENDEDOR_AGENTE ,A.COD_OPERADORA into :b\
0,:b1,:b2,:b3,:b4,:b5  from FA_FACTDOCU_NOCICLO A ,FA_TIPDOCUMEN B where (((A.\
NUM_PROCESO=:b6 and A.IND_ANULADA=0) and A.NUM_FOLIO=0) and A.COD_TIPDOCUM=B.C\
OD_TIPDOCUMMOV) for update ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )55;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodTipDocum;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorAgente;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[5] = (unsigned long )6;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhNumProceso;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
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



    if (SQLCODE)
    {
        vDTrazasLog  (modulo," En SQL-SELECT "
                                "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);

        vDTrazasError(modulo," En SQL-SELECT FA_FACTDOCU_NOCICLO WHERE"
        					 "\n NUM_PROCESO = %ld AND IND_ANULADA = 0  AND IND_IMPRESA > 0 AND NUM_FOLIO = 0"
        					 "\n=> Error : [%d]  [%s] ",
        					 LOG01,lhNumProceso,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso
                        , 0
                        ,"New_FolOnline"
                        , strcat(cfnGetTime(1), "=> select FA_FACTDOCU_NOCICLO err:") );
        return FALSE;
    }

	/* Modificacion de la foliacion a travez de Pl/Sql */

    	if (!bfnConsumeFolio( szCodOficina
							, lhCodTipDocum
							, szhCodOperadora
							, lhNumProceso
							, szhFecEmision
							, &lhFolio
							, szhPrefPlaza))
	{
		vDTrazasLog  (modulo," Error, en consumo de folio \n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," Error, en consumo de folio \n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
	}

    vDTrazasLog  (modulo ,"Valores a actualizar en Fa_Factdocu_Nociclo"
    					  "Folio [%ld] - Codigo Oficina [%s] - Pref. Plaza [%s] "
    					  ,LOG04, lhFolio, szhCodOficina, szhPrefPlaza);

	/* EXEC SQL UPDATE FA_FACTDOCU_NOCICLO
		        SET NUM_FOLIO   = :lhFolio,
		            COD_OFICINA = :szhCodOficina,
		            PREF_PLAZA	= :szhPrefPlaza
		      WHERE ROWID = :szhRowid; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0,COD_OFICINA=:b\
1,PREF_PLAZA=:b2 where ROWID=:b3";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )98;
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
 sqlstm.sqhstl[2] = (unsigned long )11;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[3] = (unsigned long )20;
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
        vDTrazasLog  (modulo," En SQL-UPDATE "
                             "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-UPDATE "
                             "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        fnGrabaAnomalia(lhNumProceso
                        , 0
                        ,"New_FolOnline"
                        , strcat(cfnGetTime(1), "=> update FA_FACTDOCU_NOCICLO err:") );

        return FALSE;
    }

    return TRUE;

} /* bfnUpdateFactDocuNoCiclo */


/* ************************************************************************* */
/* * Funcion bfnGetOficinaCentral                                          * */
/* * Carga Codigo de Oficina Central						               * */
/* ************************************************************************* */
BOOL bfnGetOficinaCentral(char *szCodOficina)
{
char modulo[]="bfnGetOficinaCentral";

/* EXEC SQL BEGIN DECLARE SECTION ; */ 

     char szhCod_Oficina [3] ;  /* EXEC SQL VAR szhCod_Oficina IS STRING(3); */ 

/* EXEC SQL END DECLARE SECTION; */ 



    vDTrazasLog  (modulo, "\n** Entrada en %s",LOG04,modulo);

    /* EXEC SQL
	    SELECT 	COD_OFICCENTRAL
    	  INTO  :szhCod_Oficina
    	  FROM  GE_DATOSGENER; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICCENTRAL into :b0  from GE_DATOSGENER ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )129;
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
        vDTrazasLog  ( modulo,	"\n**  No Existe Codigo de Oficina Central **",
                                LOG01);
        vDTrazasLog  ( modulo, 	"\n**  No Existe Codigo de Oficina Central **",
                                LOG01);
        return FALSE;
    }

    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  ( modulo,	"\n**  Error en Select GE_DATOSGENER (Codigo Oficina) **"
                                "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo,	"\n**  Error en Select GE_DATOSGENER (Codigo Oficina) **"
                                "\n=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    strcpy(szCodOficina,szhCod_Oficina);
    vDTrazasLog  (modulo ,"=> Codigo de Oficina [%s] ",LOG04,szCodOficina);

    return TRUE;

}/* Fin bfnGetOficinaCentral*/

/* ************************************************************************* */
/* * Funcion bfnCloseInterfaz                                              * */
/* * Cierra el Cursor de documentos a Foliar                               * */
/* ************************************************************************* */
BOOL bfnCloseInterfaz( void )
{
	char modulo[]="bfnCloseInterfaz";
    vDTrazasLog  (modulo, "\n** Entrada en %s",LOG04,modulo);

    /* EXEC SQL CLOSE Cur_Interfaz; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )148;
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
