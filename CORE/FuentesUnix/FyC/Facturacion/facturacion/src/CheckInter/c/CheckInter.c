
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
           char  filnam[19];
};
static struct sqlcxp sqlfpn =
{
    18,
    "./pc/CheckInter.pc"
};


static unsigned int sqlctx = 13778939;


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
   unsigned char  *sqhstv[11];
   unsigned long  sqhstl[11];
            int   sqhsts[11];
            short *sqindv[11];
            int   sqinds[11];
   unsigned long  sqharm[11];
   unsigned long  *sqharc[11];
   unsigned short  sqadto[11];
   unsigned short  sqtdso[11];
} sqlstm = {12,11};

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
"select A.COD_ESTPROC ,A.NUM_PROCESO ,B.IND_ORDENTOTAL ,B.COD_TIPDOCUM ,C.COD\
_TIPDOCUM COD_TIPDOCUMALM ,NVL(B.PREF_PLAZA,'0000000000') ,NVL(B.NUM_FOLIO,0) \
,NVL(B.COD_VENDEDOR,0) ,NVL(B.COD_OFICINA,' ') ,B.COD_MODVENTA ,B.TOT_FACTURA \
 from FA_INTERFACT A ,FA_FACTDOCU_NOCICLO B ,FA_TIPDOCUMEN C where (((A.COD_AP\
LIC='FAC' and A.COD_ESTADOC=:b0) and A.NUM_PROCESO=B.NUM_PROCESO) and B.COD_TI\
PDOCUM=C.COD_TIPDOCUMMOV)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,424,0,9,790,0,0,1,1,0,1,0,1,3,0,0,
24,0,0,1,0,0,13,837,0,0,11,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,4,0,0,
83,0,0,1,0,0,15,909,0,0,0,0,0,1,0,
98,0,0,2,119,0,4,950,0,0,7,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,
3,0,0,2,97,0,0,
141,0,0,3,108,0,4,978,0,0,7,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
1,3,0,0,2,97,0,0,
184,0,0,4,83,0,4,1019,0,0,1,0,0,1,0,2,3,0,0,
203,0,0,5,0,0,17,1073,0,0,1,1,0,1,0,1,97,0,0,
222,0,0,5,0,0,21,1085,0,0,1,1,0,1,0,1,3,0,0,
241,0,0,6,0,0,17,1196,0,0,1,1,0,1,0,1,97,0,0,
260,0,0,6,0,0,21,1208,0,0,1,1,0,1,0,1,3,0,0,
279,0,0,7,0,0,17,1243,0,0,1,1,0,1,0,1,97,0,0,
298,0,0,7,0,0,21,1255,0,0,1,1,0,1,0,1,3,0,0,
317,0,0,8,0,0,17,1365,0,0,1,1,0,1,0,1,97,0,0,
336,0,0,8,0,0,21,1377,0,0,1,1,0,1,0,1,3,0,0,
355,0,0,9,0,0,17,1390,0,0,1,1,0,1,0,1,97,0,0,
374,0,0,9,0,0,21,1402,0,0,1,1,0,1,0,1,3,0,0,
393,0,0,10,0,0,17,1519,0,0,1,1,0,1,0,1,97,0,0,
412,0,0,10,0,0,21,1531,0,0,1,1,0,1,0,1,3,0,0,
431,0,0,11,0,0,17,1544,0,0,1,1,0,1,0,1,97,0,0,
450,0,0,11,0,0,21,1556,0,0,1,1,0,1,0,1,3,0,0,
469,0,0,5,0,0,17,1664,0,0,1,1,0,1,0,1,97,0,0,
488,0,0,5,0,0,21,1676,0,0,1,1,0,1,0,1,3,0,0,
507,0,0,12,0,0,17,1688,0,0,1,1,0,1,0,1,97,0,0,
526,0,0,12,0,0,21,1700,0,0,1,1,0,1,0,1,3,0,0,
545,0,0,12,0,0,17,1820,0,0,1,1,0,1,0,1,97,0,0,
564,0,0,12,0,0,21,1832,0,0,1,1,0,1,0,1,3,0,0,
583,0,0,10,0,0,17,1890,0,0,1,1,0,1,0,1,97,0,0,
602,0,0,10,0,0,21,1902,0,0,1,1,0,1,0,1,3,0,0,
621,0,0,11,0,0,17,1915,0,0,1,1,0,1,0,1,97,0,0,
640,0,0,11,0,0,21,1927,0,0,1,1,0,1,0,1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : CheckInter.pc                                            * */
/* *********************************************************************** */
/* *********************************************************************** */
/* *********************************************************************** */
/* *********************************************************************** */
/***************************************************************************/

#define _CHECKINTER_PC_

#include "CheckInter.h"

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
/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/
int main(int argc, char *argv[])
{
	char modulo[]="main";

	pid =getpid();

	fprintf( stdout, "\n\t******  CheckInter   *******\n"
			 "\t**%s**\n\t**** pid : [ %8ld ] ****"
	                 "\n\t****************************\n",
	         		 cfnGetTime(1),pid );


    memset(&stLineaComandoCheck,0,sizeof(LINEACOMANDOCHECK));
    memset(&stStatus,'\0',sizeof(STATUS));

    if (!bfnValidaParametros(argc,argv,&stLineaComandoCheck)) return 1;


    if(!bfnConnectORA(stLineaComandoCheck.szOraAccount,stLineaComandoCheck.szOraPasswd))
    {
        vDTrazasError(modulo, "<< Usuario/Password Invalido >>", LOG01);
        return 2;
    }

	if (!bfnValidaOperadora())								return 3;

    if (!bfnAbreArchivos(&stLineaComandoCheck,szSysDate)) 	return 4;

	if (!bGetDatosGener (&stDatosGener, szSysDate))			return 5;

    if(!bfnRevisaInterfaz(&stLineaComandoCheck))
    {
        vDTrazasError(modulo, " \n\t------------------------------------"
                              " \n\tProceso Terminado de Forma Irregular"
                              " \n\t------------------------------------"
                              ,LOG01);
        vDTrazasLog  (modulo, " \n\t------------------------------------"
                              " \n\tProceso Terminado de Forma Irregular"
                              " \n\t------------------------------------"
                              ,LOG01);
        return 6;
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
            return 7;
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
BOOL bfnValidaParametros( int argc, char *argv[], LINEACOMANDOCHECK *pstLineaCom )
{

	       char modulo[]="bfnValidaParametros";

	extern char *optarg;
	extern  int optind, opterr, optopt;

	       char opt[] = ":u:l:";
	        int iOpt=0;

  	       char *psztmp = "";

	        int Userflag=FALSE;
 	        int Logflag=FALSE;
 	        int MGenflag=FALSE;


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG04,modulo);

	opterr=0;

	if(argc == 1)
	{
		fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsageCheck);
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
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsageCheck);
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
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsageCheck);
					return FALSE;
				}
				break;

			case '?':
				fprintf (stderr,"\n\t<< Error : opcion '-%c' es desconocida >>\n%s\n",optopt,szUsageCheck);
				return FALSE;

			case ':':
				fprintf (stderr,"\n\t<< Error : Falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsageCheck);
				return FALSE;

		}

	}


	if(Logflag==FALSE)
	{
       stStatus.LogNivel = iLOGNIVEL_DEF ; /* asume nivel de log por defecto */
       vDTrazasLog ( modulo, "Log : -l %d (default)", LOG03, stStatus.LogNivel );
	}

    pstLineaCom->iNivLog=stStatus.LogNivel ;

	if(Userflag==TRUE)
	{
        if ( (psztmp=(char *)strstr(pstLineaCom->szUsuarioOra,"/"))==(char *)NULL)
		{
			fprintf (stderr,"\n\t<< Error : Usuario Oracle no valido. Requiere '/' >>\n%s\n",szUsageCheck);
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
/* * Realiza la apertura de archivos de Logs, Errores y Datos              * */
/* ************************************************************************* */
BOOL bfnAbreArchivos(LINEACOMANDOCHECK *pstLineaCom, char *szDate)
{
 	char modulo[]="bfnAbreArchivos";

    char    *szDirLogs               ;
    char    *szNomArchivo            ;
    char    szComando[1024] = ""     ;

    /*vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***", LOG04, modulo); */

    szDirLogs    = (char *)malloc(1024);
    szNomArchivo = (char *)malloc(128);


    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL) return FALSE;

   	sprintf (pstLineaCom->szDirLogs,"%s/CheckInter",szDirLogs);
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

   	fprintf (stdout, "\n\tCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01,szComando);
        return FALSE;
    }


   	sprintf (pstLineaCom->szDirLogs,"%s/%s",pstLineaCom->szDirLogs,cfnGetTime(2));
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

   	fprintf (stdout, "\n\tCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01,szComando);
        return FALSE;
    }

	fprintf(stdout, "\n\tCrea Archivo Log/Err : CheckInter_%s\n\n", szDate );

    sprintf(szNomArchivo,"%s/CheckInter_%s",
    					pstLineaCom->szDirLogs);


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
                         "\n\t****        Log   CheckInter       **"
                         "\n\t*************************************"
                         ,LOG03);

    vDTrazasLog(modulo, "\n\t***  Parametro de Entrada CheckInter  ***"
                        "\n\t=> Usuario               [%s]"
                        "\n\t=> Password              [************]"
                        "\n\t=> Niv.Log               [%d]"
                        ,LOG05
                        ,pstLineaCom->szOraAccount
                        ,pstLineaCom->iNivLog);

    return TRUE;

} /* bfnAbreArchivos */



/* ************************************************************************* */
/* * Funcion bfnRevisaInterfaz                                            * */
/* ************************************************************************* */
BOOL bfnRevisaInterfaz ( LINEACOMANDOCHECK *pstLineaCom )
{
	char modulo[]="bfnRevisaInterfaz";

    vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***", LOG04, modulo);

    if (!bfnCheck800())
	{
        vDTrazasError(modulo, " Al procesar Documentos 800 " ,LOG01);
        vDTrazasLog  (modulo, " Al procesar Documentos 800 " ,LOG01);
		return FALSE;
	}
    if (!bfnCheck900())
	{
        vDTrazasError(modulo, " Al procesar Documentos 900 " ,LOG01);
        vDTrazasLog  (modulo, " Al procesar Documentos 900 " ,LOG01);
		return FALSE;
	}
    if (!bfnCheck920())
	{
        vDTrazasError(modulo, " Al procesar Documentos 920 " ,LOG01);
        vDTrazasLog  (modulo, " Al procesar Documentos 920 " ,LOG01);
		return FALSE;
	}
    if (!bfnCheck600())
	{
        vDTrazasError(modulo, " Al procesar Documentos 600 " ,LOG01);
        vDTrazasLog  (modulo, " Al procesar Documentos 600 " ,LOG01);
		return FALSE;
	}
	return TRUE;
}
 
/* ************************************************************************* */
/* * Funcion bfnCheck800                                            * */
/* ************************************************************************* */
BOOL bfnCheck800 ( void )
{
	char modulo[]="bfnCheck800";
	int  iCodEstado=800;
	int  i =0;
	int  iCont=0;
	
    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);


    if (!bfnOpenInterfaz(iCodEstado))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

	memset(&stRegDocum,0,sizeof(REGDOCUM));
    
    if(!ifnFetchInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }
    

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }

	for (i=0;i<stRegDocum.iNumReg;i++)
	{
		if ( stRegDocum.stDocum[i].iCodTipDocum == 1  ||
			 stRegDocum.stDocum[i].iCodTipDocum == 35 ||
			 stRegDocum.stDocum[i].iCodTipDocum == 38 )
		{
			if (abs(stRegDocum.stDocum[i].dTotFactura)>0.0) /* Se valida el monto */
			{
	       		vDTrazasLog  (modulo, "El documento tiene un monto <> 0  : %ld"
	       					, LOG03, stRegDocum.stDocum[i].lNumProceso);
	       		vDTrazasError(modulo, "El documento tiene un monto <> 0  : %ld"
	       					, LOG03, stRegDocum.stDocum[i].lNumProceso);
			}
			else 
			{
				
				if (!bfnValidaFolio(i))
					return FALSE;
                                  
				if (!bfnDBPasarHistFactura (stRegDocum.stDocum[i].lIndOrdenTotal))
        			return FALSE;

			    if (!bfnDBPasarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
			        return FALSE;

/* rao: SE comenta para la version de Aranjuez */
/* 				if (!bfnDBPasarHistTecno   (stRegDocum.stDocum[i].lIndOrdenTotal)) */
/* 			        return FALSE; */

				if  (!bfnBorrarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
			        return FALSE;
			
			    if (!bfnDBPasarHistCliente (stRegDocum.stDocum[i].lIndOrdenTotal))
			        return FALSE;
			
			    if (!bfnDBPasarHistAbonado (stRegDocum.stDocum[i].lIndOrdenTotal))
			        return FALSE;
			
			    if (!bfnDBEliminarFactura  (stRegDocum.stDocum[i].lIndOrdenTotal))
			        return FALSE;
			
			    if( !bfnDBPasarHistInterfact(stRegDocum.stDocum[i].lNumProceso))
			    	return FALSE;

	       		vDTrazasLog  (modulo, "El documento fue traspasado a historicos  : %ld"
	       					, LOG03, stRegDocum.stDocum[i].lNumProceso);
	       		iCont++;
			}
		}
		else 
		{
			vDTrazasLog  (modulo, "El documento no se procesa  : %ld"
	       				, LOG03, stRegDocum.stDocum[i].lNumProceso);
	       	vDTrazasError(modulo, "El documento no se procesa  : %ld"
	       				, LOG03, stRegDocum.stDocum[i].lNumProceso);
			
		}

	}

	vDTrazasLog  (modulo, "\t\t** Documentos procesados : %d", LOG03, iCont);

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
        return 7;
    }

	return TRUE;

}/* bfnCheck800 */

/* ************************************************************************* */
/* * Funcion bfnCheck900                                            * */
/* ************************************************************************* */
BOOL bfnCheck900 (  )
{
	char modulo[]="bfnCheck900";
	int  iCodEstado=900;
	int  i =0;
	int  iCont=0;
	
    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);

    if (!bfnOpenInterfaz(iCodEstado))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

	memset(&stRegDocum,0,sizeof(REGDOCUM));
    
    if(!ifnFetchInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }
    

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }

	for (i=0;i<stRegDocum.iNumReg;i++)
	{
		if (!bfnValidaFolio(i))
			return FALSE;
                                  
		if (!bfnDBPasarHistFactura (stRegDocum.stDocum[i].lIndOrdenTotal))
        	return FALSE;

	    if (!bfnDBPasarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
	        return FALSE;

/* rao: SE comenta para la version de Aranjuez */
/*		if (!bfnDBPasarHistTecno   (stRegDocum.stDocum[i].lIndOrdenTotal)) */
/* 	        return FALSE;*/

		if  (!bfnBorrarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
	        return FALSE;
		
		if (!bfnDBPasarHistCliente (stRegDocum.stDocum[i].lIndOrdenTotal))
		    return FALSE;
		
		if (!bfnDBPasarHistAbonado (stRegDocum.stDocum[i].lIndOrdenTotal))
		    return FALSE;
		
		if (!bfnDBEliminarFactura  (stRegDocum.stDocum[i].lIndOrdenTotal))
		    return FALSE;
		
		if( !bfnDBPasarHistInterfact(stRegDocum.stDocum[i].lNumProceso))
			return FALSE;

	    vDTrazasLog  (modulo, "El documento fue traspasado a historicos  : %ld"
	    			, LOG03, stRegDocum.stDocum[i].lNumProceso);
	    iCont++;

	}
	vDTrazasLog  (modulo, "\t\t** Documentos procesados : %d", LOG03, iCont);

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
        return 7;
    }

	return TRUE;

}/* bfnCheck900 */

/* ************************************************************************* */
/* * Funcion bfnCheck920                          		                   * */
/* ************************************************************************* */
BOOL bfnCheck920 (  )
{
	char modulo[]="bfnCheck920";
	int  iCodEstado=920;
	int  i =0;
	int  iCont=0;
	
    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);

    if (!bfnOpenInterfaz(iCodEstado))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

	memset(&stRegDocum,0,sizeof(REGDOCUM));
    
    if(!ifnFetchInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }
    

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }

	for (i=0;i<stRegDocum.iNumReg;i++)
	{
		if (   stRegDocum.stDocum[i].iCodTipDocum == 1
			|| stRegDocum.stDocum[i].iCodTipDocum == 35)
		{	
			if (!bfnValidaFolio(i))
				return FALSE;
	                                  
			if (!bfnDBPasarHistFactura (stRegDocum.stDocum[i].lIndOrdenTotal))
	        	return FALSE;
	
		    if (!bfnDBPasarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
		        return FALSE;

/* rao: SE comenta para la version de Aranjuez */
/*			if (!bfnDBPasarHistTecno   (stRegDocum.stDocum[i].lIndOrdenTotal))*/
/*		        return FALSE;*/

			if  (!bfnBorrarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
		        return FALSE;
			
			if (!bfnDBPasarHistCliente (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			
			if (!bfnDBPasarHistAbonado (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			
			if (!bfnDBEliminarFactura  (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			
			if( !bfnDBPasarHistInterfact(stRegDocum.stDocum[i].lNumProceso))
				return FALSE;
		    vDTrazasLog  (modulo, "El documento fue traspasado a historicos  : %ld"
		    			, LOG03, stRegDocum.stDocum[i].lNumProceso);
		    iCont++;
		}
		else if (stRegDocum.stDocum[i].iCodTipDocum == 52)
		{
			if (!bfnDBEliminarFactura  (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			if( !bfnDBPasarHistInterfact(stRegDocum.stDocum[i].lNumProceso))
				return FALSE;

		    vDTrazasLog  (modulo, "El documento 52 se borro y paso a Hist. de interfaz  : %ld"
    			, LOG03, stRegDocum.stDocum[i].lNumProceso);
		    iCont++;
		}
	}

	vDTrazasLog  (modulo, "\t\t** Documentos procesados : %d", LOG03, iCont);

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
        return 7;
    }

	return TRUE;

}/* bfnCheck920 */

/* ************************************************************************* */
/* * Funcion bfnCheck600                                            * */
/* ************************************************************************* */
BOOL bfnCheck600 (  )
{
	char modulo[]="bfnCheck600";
	int  iCodEstado=600;
	int  i =0;
	int  iCont=0;
	
    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);

    if (!bfnOpenInterfaz(iCodEstado))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

	memset(&stRegDocum,0,sizeof(REGDOCUM));
    
    if(!ifnFetchInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }
    

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       return FALSE;
    }

	for (i=0;i<stRegDocum.iNumReg;i++)
	{
		if  (  stRegDocum.stDocum[i].iCodTipDocum == 35
		    && !(abs(stRegDocum.stDocum[i].dTotFactura)>0.0) 
			&& stRegDocum.stDocum[i].iCodModVenta== 5	
			&& stRegDocum.stDocum[i].iCodEstProc== 3)    
		{
				
			if (!bfnValidaFolio(i))
				return FALSE;
                                  
			if (!bfnDBPasarHistFactura (stRegDocum.stDocum[i].lIndOrdenTotal))
        		return FALSE;

		    if (!bfnDBPasarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
		        return FALSE;

/* rao: SE comenta para la version de Aranjuez */
/*			if (!bfnDBPasarHistTecno   (stRegDocum.stDocum[i].lIndOrdenTotal))*/
/*		        return FALSE;*/

			if  (!bfnBorrarHistDetalle (stRegDocum.stDocum[i].lIndOrdenTotal))
		        return FALSE;
			
			if (!bfnDBPasarHistCliente (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			
			if (!bfnDBPasarHistAbonado (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
				
			if (!bfnDBEliminarFactura  (stRegDocum.stDocum[i].lIndOrdenTotal))
			    return FALSE;
			
			if( !bfnDBPasarHistInterfact(stRegDocum.stDocum[i].lNumProceso))
				return FALSE;

	       	vDTrazasLog  (modulo, "El documento fue traspasado a historicos  : %ld"
	       				, LOG03, stRegDocum.stDocum[i].lNumProceso);
	       				
	       	iCont++;
		}

	}

	vDTrazasLog  (modulo, "\t\t** Documentos procesados : %d", LOG03, iCont);

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
        return 7;
    }

	return TRUE;

}/* bfnCheck600 */


/* ************************************************************************* */
/* * Funcion bfnOpenInterfaz                                               * */
/* ************************************************************************* */
/* * Crea y Abre un Cursor sobre los documentos a Foliar de FA_INTERFACT   * */
/* ************************************************************************* */
BOOL bfnOpenInterfaz(int iCodEstProc)
{
    char modulo[]="bfnOpenInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int ihCodEstado       =0;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\t\t*** Entrada en %s ***" ,LOG04,modulo);

	ihCodEstado    =iCodEstProc;


	vDTrazasLog (modulo,"\t\t%s [%ld] Preparando Cursor sobre FA_INTERFACT "
	            ,LOG03, cfnGetTime(1),pid);
	/* EXEC SQL DECLARE  Cur_Interfaz  CURSOR for
	        SELECT A.COD_ESTPROC,
	        	   A.NUM_PROCESO, 
	        	   B.IND_ORDENTOTAL, 
	        	   B.COD_TIPDOCUM, 
	        	   C.COD_TIPDOCUM COD_TIPDOCUMALM,
	        	   /oNVL(B.PREF_PLAZA,'000'), o/	/o Comentado   por PGonzalez 15-03-2004 o/
	        	   NVL(B.PREF_PLAZA,'0000000000'),	/o Incorporado por PGonzalez 15-03-2004 o/
	        	   NVL(B.NUM_FOLIO ,0),
	        	   NVL(B.COD_VENDEDOR ,0),
	        	   NVL(B.COD_OFICINA,' '),
	        	   B.COD_MODVENTA ,
	        	   B.TOT_FACTURA
              FROM FA_INTERFACT A, FA_FACTDOCU_NOCICLO B,  FA_TIPDOCUMEN C
			 WHERE A.COD_APLIC='FAC' 
			   AND A.COD_ESTADOC  = :ihCodEstado
			   AND A.NUM_PROCESO =B.NUM_PROCESO
			   AND B.COD_TIPDOCUM =C.COD_TIPDOCUMMOV; */ 


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
    sqlstm.arrsiz = 1;
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
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstado;
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
int ifnFetchInterfaz(void)
{
	char modulo[]="ifnFetchInterfaz";
	BOOL bFinCursor=FALSE;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int		ihCodEstProc	;
    	long    lhNumProceso    ;
    	long 	lhIndOrdenTotal ;
    	int 	ihCodTipDocum	;
    	int 	ihCodTipDocumAlm;
    	/*char	szhPrefPlaza [4]; */ 	/* Comentado   por PGonzalez 15-03-2004 */
    	char	szhPrefPlaza [11]; 	/* Incorporado por PGonzalez 15-03-2004 */
    	long 	lhNumFolio		;
    	long 	lhCodVendedor	;
    	char	szhCodOficina [3];
    	int 	ihCodModVenta	;
    	double  dhTotFactura    ;
    /* EXEC SQL END DECLARE SECTION; */ 


	stRegDocum.iNumReg = 0 ;
	
    vDTrazasLog (modulo , "\t\t*** Entrada en %s ***",LOG04,modulo);
    
    do
    {
		/* EXEC SQL FETCH Cur_Interfaz INTO
						:ihCodEstProc ,
	    			    :lhNumProceso ,
	    			    :lhIndOrdenTotal,
	    			    :ihCodTipDocum,
	    			    :ihCodTipDocumAlm,
	    			    :szhPrefPlaza,
	    			    :lhNumFolio,
	    			    :lhCodVendedor,
	    			    :szhCodOficina,
	    			    :ihCodModVenta,
	    			    :dhTotFactura ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )24;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstProc;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[2] = (unsigned char  *)&lhIndOrdenTotal;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocumAlm;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[5] = (unsigned long )11;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhCodVendedor;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhCodOficina;
  sqlstm.sqhstl[8] = (unsigned long )3;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&ihCodModVenta;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&dhTotFactura;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
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


	
	    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
	    {
	        vDTrazasLog  (modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
	        vDTrazasError(modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
	        return SQLCODE ;
	    }
	
	    if( SQLCODE == SQLNOTFOUND )
	    {
	        vDTrazasLog  (modulo, "\t\t** No Existen Mas Documentos en CURSOR Cur_Interfaz ",LOG03);
	        bFinCursor = TRUE ;
	    }
	    else
	    {
			if( (stRegDocum.stDocum=
			    (REGINTER *)realloc((REGINTER *)stRegDocum.stDocum,
	                        		 sizeof(REGINTER)*(stRegDocum.iNumReg+1) ))
	             ==(REGINTER *)NULL )
	        {
	        	iDError (szExeName,ERR005,vInsertarIncidencia,
	            		"stRegDocum.stDocum");
	            return(FALSE);
			}
			memset(&stRegDocum.stDocum[stRegDocum.iNumReg],0,sizeof(REGINTER));
			
	    	stRegDocum.stDocum[stRegDocum.iNumReg].iCodEstProc	= ihCodEstProc	;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].lNumProceso	= lhNumProceso	;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].lIndOrdenTotal= lhIndOrdenTotal;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].iCodTipDocum	= ihCodTipDocum	;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].iCodTipDocumAlm= ihCodTipDocumAlm;
	    	strcpy (stRegDocum.stDocum[stRegDocum.iNumReg].szPrefPlaza, szhPrefPlaza);
	    	stRegDocum.stDocum[stRegDocum.iNumReg].lNumFolio= lhNumFolio;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].lCodVendedor= lhCodVendedor	;
	    	strcpy (stRegDocum.stDocum[stRegDocum.iNumReg].szCodOficina, szhCodOficina);
	    	stRegDocum.stDocum[stRegDocum.iNumReg].iCodModVenta	= ihCodModVenta	;
	    	stRegDocum.stDocum[stRegDocum.iNumReg].dTotFactura	= dhTotFactura	;
	    	
	    	stRegDocum.iNumReg ++;
	    }
    
	} while (!bFinCursor);

    vDTrazasLog  (modulo, "\t\tTotal de Registros obtenidos : %d ", LOG03, stRegDocum.iNumReg);

    return SQLCODE ;
} /* ifnFetchInterfaz */



/* ************************************************************************* */
/* * Funcion bfnCloseInterfaz                                              * */
/* ************************************************************************* */
/* * Cierra el Cursor de documentos a Foliar                               * */
/* ************************************************************************* */
BOOL bfnCloseInterfaz()
{
	char modulo[]="bfnCloseInterfaz";
    vDTrazasLog  (modulo, "\t\t** Entrada en %s",LOG03,modulo);

    /* EXEC SQL CLOSE Cur_Interfaz; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )83;
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

/* ************************************************************************* */
/* * Funcion bfnValidaFolio                                              * */
/* ************************************************************************* */
BOOL bfnValidaFolio(int i)
{
	char 	modulo[]="bfnValidaFolio";
	int	iNumParametros	;
	char    *szArregloParametros[5];
	int     iEstadoFolio;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	int 	ihCodTipDocum	;
    	int 	ihCodTipDocumAlm;
    	/*char	szhPrefPlaza [4]; */	/* Comentado   por PGonzalez 15-03-2004 */
    	char	szhPrefPlaza [11];	/* Incorporado por PGonzalez 15-03-2004 */
    	long 	lhNumFolio		;
    	long 	lhCodVendedor	;
    	char	szhCodOficina [3];
    	double  dhTotFactura    ;

   	    char  	szhRetorno[250] ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo, "\t\t** Entrada en %s",LOG03,modulo);
	
	if (stRegDocum.stDocum[i].lNumFolio > 0)
	{
		ihCodTipDocumAlm=stRegDocum.stDocum[i].iCodTipDocumAlm;
		lhCodVendedor 	=stRegDocum.stDocum[i].lCodVendedor	;
		strcpy (szhCodOficina, stRegDocum.stDocum[i].szCodOficina);
		strcpy (szhPrefPlaza ,stRegDocum.stDocum[i].szPrefPlaza);
		lhNumFolio 		= stRegDocum.stDocum[i].lNumFolio;
		
		/* EXEC SQL 
			SELECT fa_foliacion_pg.FA_CONSULTA_FOLIO_FN(
						:ihCodTipDocumAlm, 
						decode(:lhCodVendedor,0,NULL,:lhCodVendedor) , 
						:szhCodOficina,
                        'TMC', 
                        :szhPrefPlaza,
                        :lhNumFolio,
                        NULL , 
                        1 )
                        
			  INTO :szhRetorno
          	  FROM DUAL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select fa_foliacion_pg.FA_CONSULTA_FOLIO_FN(:b0,decode(:b1,\
0,null ,:b1),:b3,'TMC',:b4,:b5,null ,1) into :b6  from DUAL ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )98;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocumAlm;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedor;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodOficina;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhPrefPlaza;
  sqlstm.sqhstl[4] = (unsigned long )11;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhRetorno;
  sqlstm.sqhstl[6] = (unsigned long )250;
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



	    if (SQLCODE != SQLOK)
	        return FALSE;
	
	  	/* Recupera Parametros de szhRetorno función y setea iNumParametros = 3 */
	  	iNumParametros = 0;
	    RecupParam(&iNumParametros,szArregloParametros,szhRetorno,cSEPARADOR_COMA);
		
		iEstadoFolio=atoi(szArregloParametros[0]);
		if (iEstadoFolio == G_NESTADO_CONSUMIDO )
		{
	       	vDTrazasLog(modulo , "\t\tDocumento con folio consumido N° Proceso [%ld]"
	       				,LOG03,stRegDocum.stDocum[i].lNumProceso);
	       				
			/* Si el folio se encuentra consumido se anula */
	      	/* EXEC SQL 
	      		SELECT FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(
	      					:ihCodTipDocumAlm, 
							decode(:lhCodVendedor,0,NULL,:lhCodVendedor) , 
							:szhCodOficina,
	                        'TMC', 
	                        :szhPrefPlaza,
	                        :lhNumFolio)
	          	 INTO :szhRetorno
	          	FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(:b0,decode(:\
b1,0,null ,:b1),:b3,'TMC',:b4,:b5) into :b6  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )141;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocumAlm;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedor;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[3] = (unsigned long )3;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[4] = (unsigned long )11;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhRetorno;
        sqlstm.sqhstl[6] = (unsigned long )250;
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


	        if (SQLCODE != SQLOK)
	        {
	        	vDTrazasLog(modulo , "en la Anulacion del folio Docto N° Proceso [%ld]:(%d|%s)"
	        				,LOG01,stRegDocum.stDocum[i].lNumProceso, SQLCODE,SQLERRM);
	        	return FALSE;
	        	
	        }
	       	vDTrazasLog(modulo , "Se anulo el folio del documento N° Proceso  [%ld]"
	       				,LOG03,stRegDocum.stDocum[i].lNumProceso);
	        
	     }
	}     	
    return TRUE;
}


/* ************************************************************************* */
/* * Funcion bfnValidaOperadora                                            * */
/* ************************************************************************* */
/* * VALIDA QUE LA OPERADORA EN LA QUE SE EJECUTA LA APLICACION SEA TMC    * */
/* ************************************************************************* */
BOOL bfnValidaOperadora(void)
{
    char modulo[]="bfnValidaOperadora";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int ihCuenta=0;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG04,modulo);

	/* EXEC SQL 
	        SELECT COUNT(1)
	        INTO :ihCuenta
 			FROM GE_OPERADORA_SCL_LOCAL
 			WHERE COD_OPERADORA_SCL='TMC'; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from GE_OPERADORA_SCL_LOCAL where \
COD_OPERADORA_SCL='TMC'";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )184;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCuenta;
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



    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "\n\t** En Validacion de operadora TMC **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo , "\n\t** En Validacion de operadora TMC **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    if (ihCuenta != 1)
    {
        vDTrazasLog  (modulo,"**  La operadora no es valida para ejecutar el programa  **",LOG01);
        vDTrazasError(modulo,"**  La operadora no es valida para ejecutar el programa  **",LOG01);
        return FALSE;
    }

    return TRUE;

}/* bfnValidaOperadora */




/* *************************************** */
/*                  HISTORICOS			   */
/* *************************************** */

/* ************************************************************************* */
/* * Funcion bfnDBPasarHistFactura( ),                                     * */
/* * Pasamos a Historicas Facturas                                         * */
/* ************************************************************************* */
BOOL bfnDBPasarHistFactura(long lIndOrdenTotal)
{
    char modulo[]="bfnDBPasarHistFactura";
    char    szCadenaInsert[4096] ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhIndOrdenTotal = lIndOrdenTotal ;
	
    vDTrazasLog  (modulo,"\t\t**  Paso Historico de Facturas **"
    					 "\n\t\t==> Ind.OrdenTotal   [%ld]"
                         ,LOG05,lIndOrdenTotal);

    vfnInitCadenaInsertFactura (szCadenaInsert);

    /* EXEC SQL PREPARE sql_insert_factura FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )203;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_factura USING :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )222;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if ( SQLCODE )
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
    sprintf(szCadena,
            "INSERT INTO FA_HISTDOCU ( "
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
                    "COD_DESPACHO			   , IND_RECUPIVA              ,"
                    "NUM_CUOTAS                , NUM_PROCPASOCOBRO         ,"
                    "COD_OFICINA               , PREF_PLAZA				   ,"
                    "COD_OPERADORA			   , COD_ZONAIMPO			   ,"
                    "COD_PLAZA											   )"
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
                    "COD_DESPACHO			   , IND_RECUPIVA              ,"
                    "NUM_CUOTAS                , NUM_PROCPASOCOBRO         ,"
                    "COD_OFICINA               , PREF_PLAZA 			   ,"
                    "COD_OPERADORA			   , COD_ZONAIMPO			   ,"
                    "COD_PLAZA												"
            "FROM   FA_FACTDOCU_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}

/*-----------------------------------------------------------------------------------------------------*/
/* ************************************************************************* */
/* * Funcion bfnDBPasarHistDetalle( ),                                     * */
/* * Pasamos a Historicas Detalle de Facturas                              * */
/* ************************************************************************* */
BOOL bfnDBPasarHistDetalle(long lIndOrdenTotal)
{
 	char  modulo[]="bfnDBPasarHistDetalle";
    char    szCadenaInsert[2048] ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 

	
	lhIndOrdenTotal = lIndOrdenTotal;
	
    vDTrazasLog  (modulo, "\t\t**  Paso Historico Detalle Factura **"
    					  "\n\t\t==> Ind.OrdenTotal   [%ld]"
                          ,LOG05,lIndOrdenTotal);

    vfnInitCadenaInsertDetalle(szCadenaInsert);

    /* EXEC SQL PREPARE sql_insert_detalle FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )241;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Detalle **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Detalle **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_detalle USING :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )260;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if ( SQLCODE )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }


    return (TRUE);
}


/* ************************************************************************* */
/* * Funcion bfnBorrarHistDetalle( ),                                      * */
/* * Borramos a Historicas Detalle de Facturas                             * */
/* ************************************************************************* */
BOOL bfnBorrarHistDetalle(long lIndOrdenTotal)
{
 	char  modulo[]="bfnBorrarHistDetalle";
    char  szCadenaDelete[512]  ="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhIndOrdenTotal = lIndOrdenTotal;
    vDTrazasLog  (modulo, "\t\t**  Borrado del Historico Detalle Factura **"
    					  "\n\t\t==> Ind.OrdenTotal   [%ld]"
                          ,LOG05,lIndOrdenTotal);

   vfnInitCadenaDeleteDetalle(szCadenaDelete);
   /* EXEC SQL PREPARE sql_delete_detalle FROM :szCadenaDelete; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )279;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_detalle USING  :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )298;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Detalle **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return (TRUE);
}/* ******************* * End bfnBorrarHistDetalle * ******************* */


/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertDetalle ()                                 * */
/* * Inicilaiza Sql para Insertar Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaInsertDetalle(char *szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTCONC_19010102 ( "
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
                    "SEQ_CUOTAS       ) "
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
                    "SEQ_CUOTAS      "
            "FROM   FA_FACTCONC_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteDetalle ()                                 * */
/* * Inicilaiza Sql para Deletear Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaDeleteDetalle (char *szCadena)
{
	char modulo[]="vfnInitCadenaDeleteDetalle";

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
BOOL bfnDBPasarHistCliente(long lIndOrdenTotal)
{
	char modulo[]="bfnDBPasarHistCliente";

    char    szCadenaInsert[2048] ="";
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    lhIndOrdenTotal = lIndOrdenTotal;
    vDTrazasLog  (modulo, "\t\t**  Paso Historico Cliente Factura **"
    					  "\n\t\t==> Ind.OrdenTotal   [%ld]"
                          ,LOG05,lIndOrdenTotal);

    vfnInitCadenaInsertCliente(szCadenaInsert);
    vfnInitCadenaDeleteCliente(szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_cliente FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )317;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_cliente USING :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )336;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if ( SQLCODE )
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
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )355;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Cliente **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_cliente USING  :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )374;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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
    return (TRUE);
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertCliente ()                                 * */
/* * Inicilaiza Sql para Insertar Clientes de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaInsertCliente(char *szCadena)
{
    sprintf(szCadena,
            "INSERT INTO FA_HISTCLIE_19010102 ( "
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
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
    
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteCliente ()                                 * */
/* * Inicilaiza Sql para Deletear Detalle de Facturas                      * */
/* ************************************************************************* */
void vfnInitCadenaDeleteCliente (char *szCadena)
{
	char modulo[]="vfnInitCadenaDeleteCliente";

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
BOOL bfnDBPasarHistAbonado(long lIndOrdenTotal)
{
	char modulo[]="bfnDBPasarHistAbonado";

    char    szCadenaInsert[2048] ="";
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhIndOrdenTotal = lIndOrdenTotal;
    vDTrazasLog  (modulo,"\t\t**  Paso Historico Abonados de Factura **"
    					 "\n\t\t==> Ind.OrdenTotal   [%ld]"
                         ,LOG05,lhIndOrdenTotal);

    vfnInitCadenaInsertAbonado (szCadenaInsert);
    vfnInitCadenaDeleteAbonado (szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_abonado FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )393;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_abonado USING :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )412;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if ( SQLCODE )
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
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )431;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Abonados **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_abonado USING  :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )450;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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
    return (TRUE);
}




/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertAbonado ()                                 * */
/* * Inicilaiza Sql para Insertar Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaInsertAbonado(char *szCadena)
{
    char modulo[]="vfnInitCadenaInsertAbonado";

    sprintf(szCadena,
            "INSERT INTO FA_HISTABON_19010102 ( "
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
                    "COD_BARRAS       )"
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
                    "COD_BARRAS       "
            "FROM   FA_FACTABON_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}



/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteAbonado ()                                 * */
/* * Inicilaiza Sql para Deletear Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaDeleteAbonado (char *szCadena)
{
    char modulo[]="vfnInitCadenaDeleteAbonado";

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
    long    lFilasDelete=0          ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhNumProceso	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhNumProceso = lNumProceso;
    vDTrazasLog  (modulo,"\t\t**  Paso Historico de InterFaz **"
    					 "\n\t\t ==> Num.Proceso   [%ld]"
                         ,LOG05,lhNumProceso);

    vfnInitCadenaInsertInterfaz (szCadenaInsert);
    vfnInitCadenaDeleteInterfaz (szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_factura FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )469;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_factura USING :lhNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )488;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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



    if ( SQLCODE )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }


    /* EXEC SQL PREPARE sql_delete_factura FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )507;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_factura USING  :lhNumProceso; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )526;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Interfaz **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

    return (TRUE);
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertInterfaz()                                 * */
/* * Inicilaiza Sql para Insertar Interfaz                                 * */
/* ************************************************************************* */
void vfnInitCadenaInsertInterfaz(char *szCadena)
{
    char modulo[]="vfnInitCadenaInsertInterfaz";

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
    char modulo[]="vfnInitCadenaDeleteInterfaz";

    sprintf(szCadena,
        "DELETE "
        "FROM    FA_INTERFACT  "
        "WHERE   NUM_PROCESO = :lhNumProceso "
        "AND COD_APLIC = 'FAC' "); /* Incorporado por PGonzaleg 31-01-2002 */
    return;
}


/*---------------------------------------------------------------------------------------------*/

/* ************************************************************************* */
/* * Funcion bfnDBEliminarFactura( ),                                      * */
/* * Eliminamos Facturas ya pasadas a Historicas                           * */
/* ************************************************************************* */
BOOL bfnDBEliminarFactura(long lIndOrdenTotal)
{
    char modulo[]="bfnDBEliminarFactura";

    char    szCadenaDelete[512]  ="";
    long    lFilasDelete=0          ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhIndOrdenTotal = lIndOrdenTotal;
	
    vDTrazasLog  (modulo, "\t\t**  Paso Eliminar Facturas **"
    					  "\n\t\t==> Ind.OrdenTotal   [%ld]"
                          ,LOG05,lIndOrdenTotal);

    vfnInitCadenaDeleteFactura (szCadenaDelete);

    /* EXEC SQL PREPARE sql_delete_factura FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )545;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_factura USING  :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )564;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Facturas **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasDelete=(SQLROWS>0?SQLROWS:0);

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
        "WHERE   IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}

/* ************************************************************************* */
/* * Funcion bfnDBPasarHistTecno( ),                                     * */
/* * Pasamos a Historicas Abonados Facturados                              * */
/* ************************************************************************* */
BOOL bfnDBPasarHistTecno(long lIndOrdenTotal)
{
	char modulo[]="bfnDBPasarHistTecno";

    char    szCadenaInsert[2048] ="";
    char    szCadenaDelete[512]  ="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int lhIndOrdenTotal	= 0;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhIndOrdenTotal =lIndOrdenTotal ;
	
    vDTrazasLog  (modulo,"\t\t**  Paso Historico Tenologia de Factura **"
    					 "\n\t\t==> Ind.OrdenTotal   [%ld]"
                         ,LOG05,lIndOrdenTotal);

    vfnInitCadenaInsertTecno (szCadenaInsert);
    vfnInitCadenaDeleteTecno (szCadenaDelete);

    /* EXEC SQL PREPARE sql_insert_abonado FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )583;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Insert Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Insert Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_abonado USING :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )602;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if ( SQLCODE )
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Insert Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Insert Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    lFilasInsert=(SQLROWS>0?SQLROWS:0);

    /* EXEC SQL PREPARE sql_delete_abonado FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )621;
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



    if (SQLCODE)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-PREPARE Delete Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-PREPARE Delete Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_abonado USING  :lhIndOrdenTotal; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )640;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
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



    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo,  "\n\t**  Error en SQL-EXECUTE Delete Tenologia **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo,  "\n\t**  Error en SQL-EXECUTE Delete Tenologia **"
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
    return (TRUE);
}


/* ************************************************************************* */
/* * Funcion vfnInitCadenaInsertAbonado ()                                 * */
/* * Inicilaiza Sql para Insertar Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaInsertTecno(char *szCadena)
{

    sprintf(szCadena,
            "INSERT INTO FA_HISTECNO_TH_19010102 ( "
                    "IND_ORDENTOTAL   , COD_CONCEPTO , "
                    "COLUMNA      , COD_TECNOLOGIA   , "
                    "PRC_TECNOLOGIA ) "
            "SELECT "
                    "IND_ORDENTOTAL   , COD_CONCEPTO , "
                    "COLUMNA      , COD_TECNOLOGIA   , "
                    "PRC_TECNOLOGIA    "
            "FROM   FA_FACTECNO_TO_NOCICLO "
            "WHERE  IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
}

/* ************************************************************************* */
/* * Funcion vfnInitCadenaDeleteTecno ()                                 * */
/* * Inicilaiza Sql para Deletear Abonados de Facturas                     * */
/* ************************************************************************* */
void vfnInitCadenaDeleteTecno (char *szCadena )
{

    sprintf(szCadena,
        "DELETE "
        "FROM    FA_FACTECNO_TO_NOCICLO  "
        "WHERE   IND_ORDENTOTAL = :lhIndOrdenTotal ");
    return;
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
