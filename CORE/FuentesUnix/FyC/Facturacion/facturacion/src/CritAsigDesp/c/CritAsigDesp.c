
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
           char  filnam[21];
};
static struct sqlcxp sqlfpn =
{
    20,
    "./pc/CritAsigDesp.pc"
};


static unsigned int sqlctx = 55241067;


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
"select CRIT.rowid  ,TO_CHAR(CRIT.FEC_DESDE,'YYYYMMDD') ,CRIT.VAL_PARAM ,CRIT\
.VAL_OPERADOR ,CRIT.COD_DESPACHO ,TO_CHAR(CRIT.FEC_HASTA,'YYYYMMDD') ,PAR.IND_\
PREPROC ,PAR.COD_TIPPARAM ,DESP.COD_PRIORIDAD  from FA_PARCRISEP PAR ,FA_CODES\
PACHO DESP ,FA_CRITASIDESP CRIT where ((CRIT.COD_CRITDESP=:b0 and CRIT.COD_CRI\
TDESP=PAR.COD_CRITDESP) and CRIT.COD_DESPACHO=DESP.COD_DESPACHO) order by DESP\
.COD_PRIORIDAD            ";

 static char *sq0004 = 
"select ROWID ,COD_PRIORIDAD ,COD_DESPACHO ,NUM_ABONADO  from FA_CICLOCLI whe\
re ((COD_CLIENTE=:b0 and COD_CICLO=:b1) and IND_MASCARA=1) order by COD_PRIORI\
DAD  for update ";

 static char *sq0007 = 
"select distinct COD_CLIENTE  from FA_CICLOCLI where (COD_CICLO=:b0 and IND_M\
ASCARA=1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,414,0,9,401,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,13,459,0,0,9,0,0,1,0,2,5,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
75,0,0,2,79,0,5,538,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
98,0,0,1,0,0,15,569,0,0,0,0,0,1,0,
113,0,0,3,165,0,4,624,0,0,5,1,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
148,0,0,4,170,0,9,792,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
171,0,0,4,0,0,13,845,0,0,4,0,0,1,0,2,5,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
202,0,0,5,74,0,5,886,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,5,0,0,
229,0,0,4,0,0,15,925,0,0,0,0,0,1,0,
244,0,0,6,0,0,17,1115,0,0,1,1,0,1,0,1,97,0,0,
263,0,0,6,0,0,45,1135,0,0,0,0,0,1,0,
278,0,0,6,0,0,13,1194,0,0,1,0,0,1,0,2,3,0,0,
297,0,0,6,0,0,15,1247,0,0,0,0,0,1,0,
312,0,0,7,96,0,9,1309,0,0,1,1,0,1,0,1,3,0,0,
331,0,0,7,0,0,13,1322,0,0,1,0,0,1,0,2,3,0,0,
350,0,0,8,288,0,4,1339,0,0,5,3,0,1,0,2,97,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
385,0,0,9,80,0,5,1364,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
412,0,0,7,0,0,15,1382,0,0,0,0,0,1,0,
427,0,0,10,66,0,4,1471,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
450,0,0,6,0,0,17,1501,0,0,1,1,0,1,0,1,97,0,0,
469,0,0,6,0,0,45,1519,0,0,0,0,0,1,0,
484,0,0,11,180,0,4,1563,0,0,4,2,0,1,0,2,3,0,0,2,97,0,0,1,3,0,0,1,3,0,0,
515,0,0,12,0,0,17,1587,0,0,1,1,0,1,0,1,97,0,0,
534,0,0,12,0,0,21,1599,0,0,0,0,0,1,0,
549,0,0,6,0,0,13,1668,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
572,0,0,6,0,0,15,1696,0,0,0,0,0,1,0,
};


/*********************************************************************************
	Aplicacion : CritAsigDesp = CRITerio de ASIGnacion de secuencia DESPacho.
	Fecha 	   : 20/12/1999
    Modificacion : 14-Enero-2000 : 	Agrego validacion de los criterios.
    								Agrego opcion de carga inicial de criterios (default)
    								Agrego la funcionalidad de la aplicacion TrasCrit
*********************************************************************************/

#include "CritAsigDesp.h"
#define _CRITASIGDESP_PC_

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

 
/********************************************************************************************/
/* modulo principal                                                                         */
/********************************************************************************************/
int main(int argc,char *argv[])
{
	
/* Define variables locales */

	char modulo[]="main";
	char status[16]="";
	 int sts;


	memset(status,0,sizeof(status));
    memset(&stLineaComando,0,sizeof(LINEACOMANDOGENERICA));

/* Inicia enviando un mensaje informativo a la salida standard (pantalla) */

	fprintf( stdout, "\n\t***** CritAsigDesp *****"
					 "\n\t%s"
					 "\n\t** pid : [ %8ld ] **"
					 "\n\t************************\n", 
	                 cfnGetTime(1),getpid() );


/* Validacion de par�metros y carga de estructura */

	sts = ifnValidaParametros(argc,argv,&stLineaComando);
	if ( sts != 0 ) return sts;

/* Define archivo de Log y Errores para la traza */

	sts = ifnAbreArchivosLog(stLineaComando.szCodCritAsig);
	if ( sts != 0 ) return sts;


/* Accesa a la Base de Datos y realiza el procesamiento */

	sts = ifnAccesoBaseDatos(stLineaComando);
	if (sts == 0)
		strcpy(status,"normal");
    	else
		strcpy(status,"anormal");
	
	vDTrazasError(modulo,"%s [%ld] Termino %s de la Aplicacion\n\n", LOG03, cfnGetTime(1),getpid(),status);
	vDTrazasLog  (modulo,"%s [%ld] Termino %s de la Aplicacion\n\n", LOG03, cfnGetTime(1),getpid(),status);	

	return sts;
	
} /* main */


/********************************************************************************************************/

/****************************************************************************/
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada */
/****************************************************************************/
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDOGENERICA *pstLineaCom )
{          
	       char modulo[]="ifnValidaParametros";

/* Definicion de variables para controlar la lista de argumentos recibidos */
	extern char  *optarg;
	extern  int  optind, opterr, optopt;
	        int  iOpt=0;
	       char  opt[] = ":u:l:c:d:t";
	
/* Variables locales */  
  	       char  *psztmp = "";

/* Flags de los valores recibidos*/
	        int  Userflag=FALSE;
 	        int  Logflag=FALSE;
 	        int  Ciclflag=FALSE;
 	        int  Asigflag=FALSE;
 	        int  Trasflag=FALSE;


    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	opterr=0;
    

/* Esta validacion corresponde s�lo si se tiene al menos un par�metro que no sea opcional (necesario) */

	if(argc == 1)
	{
		fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
		return -1;
	}

/* Analisis de los argumentos recibidos */

	while ( (iOpt = getopt(argc, argv, opt) ) != EOF)
	{
		switch(iOpt)
		{
			case 'u':  /* Validacion del Usuario / Password Oracle*/
 				if(Userflag==FALSE)
				{
	                strcpy(pstLineaCom->szUsuarioOra, optarg);                      
    	            Userflag=TRUE;
					if ( (psztmp=(char *)strstr(pstLineaCom->szUsuarioOra,"/"))==(char *)NULL)
					{
						fprintf (stderr,"\n\t<< Error : Usuario Oracle no valido. Requiere '/' >>\n%s\n",szUsage);
						return -5;
					}
					else
					{
						strncpy (pstLineaCom->szOraAccount,pstLineaCom->szUsuarioOra,psztmp-pstLineaCom->szUsuarioOra);
						strcpy  (pstLineaCom->szOraPasswd, psztmp+1)                 ;
					}
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'l': /* Validacion del Nivel de Log definido */
				if(Logflag==FALSE)
				{
                    stStatus.LogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
				    pstLineaCom->iLogLevel=stStatus.LogNivel ;
                    Logflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'c':
				if(Ciclflag==FALSE)
				{
	                pstLineaCom->lCodCiclFact = atol(optarg);                      
                    Ciclflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 'd':
				if(Asigflag==FALSE)
				{
	                strncpy(pstLineaCom->szCodCritAsig, optarg,3);                      
                    Asigflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;

			case 't':
				if(Trasflag==FALSE)
				{
	                pstLineaCom->iTraspasar=1;/*TRUE*/                      
                    Trasflag=TRUE;
				}
				else
				{
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return -2;
				}
				break;


			case '?':
				fprintf (stderr,"\n\t<< Error : opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
				return -3;
				/*break;*/

			case ':':
				fprintf (stderr,"\n\t<< Error : Falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
				return -4;
				/*break;*/
		}
	} 

/* Revisa ocurrencia de parametros necesarios */
	if(Ciclflag==FALSE)
	{	
		fprintf (stderr,"\n\t<< Error : Falta definir opcion '-c' Cod Ciclo Facturacion >>\n%s\n",szUsage);
		return -6;
	}

	if (Trasflag==FALSE) /* No es traspaso de Criterio despacho */
	{
		if(Asigflag==FALSE)
		{	
			fprintf (stderr,"\n\t<< Error : Falta definir opcion '-d' Cod Criterio Asignacion Secuencia Despacho >>\n%s\n",szUsage);
			return -6;
		}
		else
		{  
			if(!bfnValidaCriterio(pstLineaCom->szCodCritAsig))
			{	
				fprintf (stderr,"\n\t<< Error : Criterio ' %s ' Inesperado >>\n%s\n",pstLineaCom->szCodCritAsig,szUsage);
				return -6;
			}
		}
	}
	else /* Es Traspaso */
	{
		if (Asigflag==TRUE)
		{
			fprintf (stderr,"\n\t<< Error : No puede incluir las opciones '-d' y '-t' juntas >>\n%s\n",szUsage);
			return -6;			
		}
		else
		{
            sprintf(pstLineaCom->szCodCritAsig,"TRA");  /* Traspasar Criterios */
		}
	}


	if(Logflag==FALSE) /* Si no se definio log, se asumira por defecto  */
	{
        stStatus.LogNivel = iLOGNIVEL_DEF ;
	    pstLineaCom->iLogLevel=stStatus.LogNivel ;
	}

	return 0;

} /* bfnValidaParametros */

/********************************************************************************************************/

/************************************************************************************/
/* bfnValidaCriterio  */
/************************************************************************************/
BOOL bfnValidaCriterio(char *szCriterio)
{
	char modulo[]="bfnValidaCriterio";

	if ( (strcmp(szCriterio,critMONTO)==0)    || (strcmp(szCriterio,critTIPOCLI)==0)  || 
	     (strcmp(szCriterio,critCLIENTE)==0)  || (strcmp(szCriterio,critCUENTA)==0)   || 
	     (strcmp(szCriterio,critCANTABON)==0) || (strcmp(szCriterio,critPLAN)==0)     || 
	     (strcmp(szCriterio,critPRODUCTO)==0) || (strcmp(szCriterio,critINICIO)==0)      ) 
	{     
	     return TRUE;
	}
	else
	{
		return FALSE;
	}    
}

/************************************************************************************/
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/************************************************************************************/
int ifnAbreArchivosLog(char *szCriterio)
{
	char modulo[]="ifnAbreArchivosLog";

	char szArchivo[32]="";
	char *pathDir;
	char szPath[128]="";
	char szComando[128]="";	

    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"CritDespa_%s_%s",szCriterio,cfnGetTime(4));

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/CritAsigDesp/%s",pathDir,cfnGetTime(2)); 
	free(pathDir);

	fprintf(stdout, "\n\t Creando directorio de log y errores : \n\t %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath); 
	if (system (szComando)!=0) return -7;

	fprintf(stdout, "\n\t Creando archivos de log y errores   : \n\t %s\n\n", szArchivo);
	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo); 
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -8;    }
	vDTrazasError(modulo, "%s [%ld] << Abre Archivo de Errores >>", LOG03, cfnGetTime(1),getpid());

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo); 
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -9;    }
	vDTrazasLog(modulo, "%s [%ld] << Abre Archivo de Log >>", LOG03, cfnGetTime(1),getpid());

	
	return 0;
	
}/* ifnAbreArchivosLog */

/********************************************************************************************************/

/************************************************************************************/
/* ifnAccesoBaseDatos : Acceso a la Base y Procesamiento de la Informaci�n          */
/************************************************************************************/
int ifnAccesoBaseDatos(LINEACOMANDOGENERICA *pstLineaCom)
{
char modulo[]="ifnAccesoBaseDatos";
    
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
		
	if(!bfnConnectORA(pstLineaCom->szOraAccount,pstLineaCom->szOraPasswd))	{
        vDTrazasError(modulo, "No Hay Conexion a la Base de Datos", LOG01);
        return -10;
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))	{
        vDTrazasError(modulo, "No pudo recuperar FA_DATOSGENER", LOG01);
        return -11;
    }

	if (pstLineaCom->iTraspasar == 1)	{
        if (!bfnTraspasaCriterios(pstLineaCom->lCodCiclFact))        {
	        vDTrazasError(modulo, "No pudo traspasar los criterios",LOG01);
        	return -12;
        }		

	} else  {

	    if (!bfnGetCriterios(pstLineaCom->szCodCritAsig,pstLineaCom->lCodCiclFact))	{
	        vDTrazasError(modulo, "No pudo recuperar detalles del Criterio %s", LOG01,pstLineaCom->szCodCritAsig);
	        return -13;
	    }
    }	
	
	if (!fnOraCommitRelease())	{	
		vDTrazasError(modulo,"ERROR EN COMMIT.  Intentar� hacer Rollback\n\t=> Detalle : %s\n", 
		                     LOG01, sqlca.sqlerrm.sqlerrmc);
		if (!fnOraRollBackRelease()) {
	    	vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
	    	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}
		return -15;	
	}

	return 0;
	
}

/********************************************************************************************************/

/***************************************************************************************/
/* bfnPreparaCursorCriterios  */
/***************************************************************************************/

BOOL bfnPreparaCursorCriterios(char *szCriterio)
{
	char modulo[]="bfnPreparaCursorCriterios";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char  szhCodCritAsig  [6] ;
    /* EXEC SQL END DECLARE SECTION; */ 

	strcpy(szhCodCritAsig,szCriterio);

    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);


	/* EXEC SQL DECLARE CursorCRITERIOS CURSOR FOR
	  SELECT CRIT.ROWID,
	  		 TO_CHAR(CRIT.FEC_DESDE,'YYYYMMDD'),
	  		 CRIT.VAL_PARAM		,
	  		 CRIT.VAL_OPERADOR		,
	  		 CRIT.COD_DESPACHO		,
	  		 TO_CHAR(CRIT.FEC_HASTA,'YYYYMMDD'),
	  		 PAR.IND_PREPROC		,
	  		 PAR.COD_TIPPARAM		,
	  		 DESP.COD_PRIORIDAD
	    FROM FA_PARCRISEP PAR, FA_CODESPACHO DESP, FA_CRITASIDESP CRIT
	   WHERE CRIT.COD_CRITDESP = :szhCodCritAsig
	     AND CRIT.COD_CRITDESP = PAR.COD_CRITDESP
	     AND CRIT.COD_DESPACHO = DESP.COD_DESPACHO
	ORDER BY DESP.COD_PRIORIDAD ; */ 


	if (SQLCODE)
	{    
        vDTrazasError(modulo , "<< Al declarar el Cursor de los Criterios >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
		
	/* EXEC SQL OPEN CursorCRITERIOS; */ 

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
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodCritAsig;
 sqlstm.sqhstl[0] = (unsigned long )6;
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
        vDTrazasError(modulo , "<< Al Abrir el Cursor de los Criterios >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	return TRUE;
}

/********************************************************************************************************/

/***************************************************************************************/
/* bfnGetCriterios : Obtiene informacion adicional segun el Cod Criterio dado (cursor) */
/***************************************************************************************/
BOOL bfnGetCriterios(char *szCritAsig, long lCodCiclFact)
{
	char modulo[]="bfnGetCriterios";
	char szMotivo[128]="";
	int iAux = 0,StsCicl=0;
	long lCont=0;
	BOOL bTerminoOK_CRI=TRUE;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char  szhCodCritAsig  [6] ;
    	char  szhCodCritDesp  [4] ;
		char  szhFecDesde     [9] ;
		char  szhValParam    [21] ;
		char  szhValOper      [3] ;
		char  szhCodDesp      [6] ;
		char  szhFecHasta     [9] ;
		char  szhIndPreProc   [2] ;
		char  szhCodTipParam  [2] ;
		 int  ihCodPrioridad      ;
 		char  szhRowid        [20]; /* EXEC SQL VAR szhRowid IS STRING(20) ; */ 

 		long  lhCodCiclFact       ; /**/
    /* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
    vDTrazasLog (modulo, "<< '%s' v/s '%s' >>", LOG05, szCritAsig,critINICIO);

	if (strcmp(szCritAsig,critINICIO)==0) return bfnCargaSecDespDefault(lCodCiclFact);
	lhCodCiclFact=lCodCiclFact;

	strcpy(szhCodCritAsig,szCritAsig);

	if (!bfnPreparaCursorCriterios(szhCodCritAsig))
		return FALSE;
	
	bTerminoOK_CRI=TRUE;
	lCont=0;
	while (1)
	{
		memset(szhValParam,0,sizeof(szhValParam));
	    memset(&stDatos,0,sizeof(REGISTRODATOS));	

		/* EXEC SQL FETCH CursorCRITERIOS
			      INTO :szhRowid			,
			           :szhFecDesde			,
					   :szhValParam			,
					   :szhValOper			,
					   :szhCodDesp			,
					   :szhFecHasta			,
					   :szhIndPreProc		,
					   :szhCodTipParam		,
					   :ihCodPrioridad		; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
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
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[1] = (unsigned long )9;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhValParam;
  sqlstm.sqhstl[2] = (unsigned long )21;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhValOper;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhCodDesp;
  sqlstm.sqhstl[4] = (unsigned long )6;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[5] = (unsigned long )9;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhIndPreProc;
  sqlstm.sqhstl[6] = (unsigned long )2;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhCodTipParam;
  sqlstm.sqhstl[7] = (unsigned long )2;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&ihCodPrioridad;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
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


	
		if (SQLCODE == SQLNOTFOUND) 
		{
		    vDTrazasLog (modulo, "\t\t** Fin del Cursor **\n", LOG03); 
			bTerminoOK_CRI=TRUE;
			break;
		}
		else if (SQLCODE)
		{	
			bTerminoOK_CRI=FALSE;
			sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
			break;
		}
		else /* SQLOK */
		{												
			lCont++;
			
			iAux = strlen(szhValParam) - 1; /* rtrim del 'valor del parametro' */
			while ((szhValParam[iAux]==' ') && (iAux>0))
			{  szhValParam[iAux]='\0';
			   iAux--; }
		
			strcpy(stDatos.szCodCritDesp,szhCodCritAsig); 
			stDatos.lCodCiclFact=lCodCiclFact			;
			strcpy(stDatos.szFecDesde,szhFecDesde)		; 
			strcpy(stDatos.szValParam,szhValParam)		;
			strcpy(stDatos.szValOper,szhValOper)		;
			strcpy(stDatos.szCodDesp,szhCodDesp)		;
			strcpy(stDatos.szFecHasta,szhFecHasta)		;
			strcpy(stDatos.szIndPreProc,szhIndPreProc)	;
			strcpy(stDatos.szCodTipParam,szhCodTipParam);
			stDatos.iCodPrioridad=ihCodPrioridad		;

	
		    vDTrazasLog (modulo, "\t\t Ocurrencia Criterio   [%ld]", LOG05,lCont)	;
		    vDTrazasLog (modulo, "\t\t stDatos.lCodCiclFact  [%ld]", LOG05,stDatos.lCodCiclFact)	;
		    vDTrazasLog (modulo, "\t\t stDatos.szCodCritDesp [%s]", LOG05,stDatos.szCodCritDesp)	;
		    vDTrazasLog (modulo, "\t\t stDatos.szFecDesde    [%s]", LOG05,stDatos.szFecDesde)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szValParam    [%s]", LOG05,stDatos.szValParam)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szValOper     [%s]",	LOG05,stDatos.szValOper)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szCodDesp     [%s]", LOG05,stDatos.szCodDesp)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szFecHasta    [%s]", LOG05,stDatos.szFecHasta)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szIndPreProc  [%s]", LOG05,stDatos.szIndPreProc)		;
		    vDTrazasLog (modulo, "\t\t stDatos.szCodTipParam [%s]", LOG05,stDatos.szCodTipParam)	;
		    vDTrazasLog (modulo, "\t\t stDatos.iCodPrioridad [%d]", LOG05,stDatos.iCodPrioridad)	;
			
			StsCicl=0;
			StsCicl=ifnValidaCiclo(&stDatos);
			if ( StsCicl < 0 )
    		{
        		sprintf(szMotivo,"Fallo la Validacion del Ciclo %ld, por error Oracle\n",lCodCiclFact);
        		bTerminoOK_CRI=FALSE;
        		break;    	
    		}
    		else if (StsCicl > 0)
    		{
			    vDTrazasLog (modulo, "\t\t** Fallo Validacion de Ciclo. NO SE PROCESA y pasa al sgte **\n", LOG03); 
    		}
    		else /* StsCicl == 0 */
    		{
		 		if (!bfnProcesaCriterio(stDatos))
				{
        			sprintf(szMotivo,"No pudo procesar el Criterio %s\n",szhCodCritAsig);
        			bTerminoOK_CRI=FALSE;
        			break;    	
				}
				else /* Se proceso correctamente el criterio */
				{    /* Se actualiza la tabla de los criterios */
					vDTrazasLog (modulo, "<< Actualizando FA_CRITASIGMEN >>\n", LOG03); 
					/* EXEC SQL UPDATE FA_CRITASIDESP 
								SET COD_CICLFACT = :lhCodCiclFact,
								    FEC_PROCESO = SYSDATE
							  WHERE ROWID = :szhRowid; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update FA_CRITASIDESP  set COD_CICLFACT=:b0,FEC_PROCESO=\
SYSDATE where ROWID=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )75;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
     sqlstm.sqhstl[1] = (unsigned long )20;
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


					
					if (SQLCODE)
					{	
						bTerminoOK_CRI=FALSE;
						sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
						break;
					}
					else if(!fnOraCommit())
					{
						vDTrazasError(modulo,"ERROR EN COMMIT.  Intentar� hacer Rollback\n\t=> Detalle : %s\n", 
			            	         LOG01, sqlca.sqlerrm.sqlerrmc);
							if (!fnOraRollBack())
							{
			    				vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
			    	                     LOG01, sqlca.sqlerrm.sqlerrmc);
							}
						bTerminoOK_CRI=FALSE;
						strcpy(szMotivo,sqlca.sqlerrm.sqlerrmc);
						break;
					}					 
				}

			}

		}
	} /* endwhile */			

	/* EXEC SQL CLOSE CursorCRITERIOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )98;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (SQLCODE)
	{	
		vDTrazasError(modulo,"<< Al Cerrar Cursor de los Criterios >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
		bTerminoOK_CRI=FALSE;
	}
	
	
	if (!bTerminoOK_CRI)
	{
		vDTrazasLog    (modulo,"<< Cursor de los Criterios No termino OK >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		vDTrazasError  (modulo,"<< Cursor de los Criterios No termino OK >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		if (!fnOraRollBack())
		{
			vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
		  	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}

		return FALSE;
	}
    
	return TRUE;

}


/********************************************************************************************************/

/*********************************************************************************************/
/*	ifnValidaCiclo() */
/*********************************************************************************************/
BOOL ifnValidaCiclo(REGISTRODATOS *pstDatos)
{
	char modulo[]="ifnValidaCiclo";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhCodCiclFact = 0;
		 int ihCodCiclo = 0;
		 int ihIndFacturacion=0;
		char szhPreproc [2]="";	
		char szhFecHastaCFijos[9]="";
		char szhFecEmision[9]="";
		char szhFecDesde[9]="";
		char szhFecHasta[9]="";
	/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

	lhCodCiclFact = pstDatos->lCodCiclFact; 				/* ciclo de facturacion */
	
	/* EXEC SQL SELECT COD_CICLO
	                ,IND_FACTURACION
	                ,TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDD')
	                ,TO_CHAR(FEC_EMISION,'YYYYMMDD')
	           INTO  :ihCodCiclo
	                ,:ihIndFacturacion
	                ,:szhFecHastaCFijos
	                ,:szhFecEmision
			   FROM FA_CICLFACT
			  WHERE COD_CICLFACT = :lhCodCiclFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLO ,IND_FACTURACION ,TO_CHAR(FEC_HASTACFIJOS,'\
YYYYMMDD') ,TO_CHAR(FEC_EMISION,'YYYYMMDD') into :b0,:b1,:b2,:b3  from FA_CICL\
FACT where COD_CICLFACT=:b4";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )113;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihIndFacturacion;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecHastaCFijos;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[3] = (unsigned long )9;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCiclFact;
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



	if (SQLCODE)
	{    
        vDTrazasLog  (modulo , "<< En el SELECT de FA_CICLFACT >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En el SELECT de FA_CICLFACT >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return -1; /* Error Oracle */
	}
	else
	{
		pstDatos->iCodCiclo    = ihCodCiclo	    ;
		strcpy (pstDatos->szFecHastaCFijos ,szhFecHastaCFijos); 
		strcpy (pstDatos->szFecEmision ,szhFecEmision); 
	}


	if (strcmp(pstDatos->szCodCritDesp,critINICIO)!=0) /* Si no es carga inicial, Valida la fecha */
	{	

		strcpy (szhFecDesde,pstDatos->szFecDesde); 
		strcpy (szhFecHasta,pstDatos->szFecHasta); 
	
	 	/* Validacion de la Fecha de Emision contra las fechas desde y hasta */    							
		if  (strcmp(szhFecDesde,szhFecEmision) > 0) 
		{
	    	vDTrazasLog   (modulo, " Fecha Emision [%s] anterior a Fecha Desde [%s]", 
	    							LOG01,szhFecEmision,szhFecDesde );
	    	vDTrazasError (modulo, " Fecha Emision [%s] anterior a Fecha Desde [%s]", 
	    							LOG01,szhFecEmision,szhFecDesde );
	    	return 1; /* Error Validacion : NO PROCESAR */
		}
		else if (strcmp(szhFecEmision,szhFecHasta) > 0)
		{
	    	vDTrazasLog   (modulo, " Fecha Emision [%s] posterior a Fecha Hasta [%s]", 
	    							LOG01,szhFecEmision,szhFecHasta );
	    	vDTrazasError (modulo, " Fecha Emision [%s] posterior a Fecha Hasta [%s]", 
	    							LOG01,szhFecEmision,szhFecHasta );
	    	return 1; /* Error Validacion : NO PROCESAR */
		}
	}

			
	/* Validacion del Ciclo */
	strcpy(szhPreproc,pstDatos->szIndPreProc);	/* indicador si es pre o pos facturacion */
	if (ihIndFacturacion > 0) /* periodo de tasacion cerrado, en facturacion o facturado */
	{
		if (strcmp(szhPreproc,PREFACT)==0 ) /* es prefacturacion */
		{   
		    vDTrazasLog (modulo, "\n\t == PREFACT", LOG05 );
		    if (!bfnSelectTrazaProc(pstDatos->lCodCiclFact,iPROC_FAMASCARA,&stTrazaProc)) /*2000*/
		    {
		    	vDTrazasLog   (modulo, "\t Al seleccionar proceso [%ld][%d]", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	vDTrazasError (modulo, "\t Al seleccionar proceso [%ld][%d]", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	return -1; /* Error Oracle */
		    }

	    	vDTrazasLog   (modulo, "\t\tlCodCiclFact  %ld", LOG05,stTrazaProc.lCodCiclFact);
	    	vDTrazasLog   (modulo, "\t\tiCodProceso   %d" , LOG05,stTrazaProc.iCodProceso);
	    	vDTrazasLog   (modulo, "\t\tiCodEstaProc  %d" , LOG05,stTrazaProc.iCodEstaProc);
	    	vDTrazasLog   (modulo, "\t\tszFecInicio   %s" , LOG05,stTrazaProc.szFecInicio);
	    	vDTrazasLog   (modulo, "\t\tszFecTermino  %s" , LOG05,stTrazaProc.szFecTermino);
	    	vDTrazasLog   (modulo, "\t\tszGlsProceso  %s" , LOG05,stTrazaProc.szGlsProceso);
	    	vDTrazasLog   (modulo, "\t\tlCodCliente   %ld", LOG05,stTrazaProc.lCodCliente);
	    	vDTrazasLog   (modulo, "\t\tlNumAbonado   %ld", LOG05,stTrazaProc.lNumAbonado);
	    	vDTrazasLog   (modulo, "\t\tlNumRegistros %ld", LOG05,stTrazaProc.lNumRegistros);
		    
		    if (stTrazaProc.iCodEstaProc != iESTAPROC_TERMINADO_OK)
		    {    
		    	vDTrazasLog   (modulo, "\t El proceso [%ld][%d] No ha terminado OK", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	vDTrazasError (modulo, "\t El proceso [%ld][%d] No ha terminado OK", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	return 1; /* Error Validacion : NO PROCESAR */
		    }
       	
		    return 0; /* Ciclo Valido : PROCESAR */
		    
		}
		else
		{
		    vDTrazasLog (modulo, "\n\t != PREFACT", LOG05 );
		    if (!bfnSelectTrazaProc(pstDatos->lCodCiclFact,iPROC_FACTURACION,&stTrazaProc)) /*3000*/
		    {  
		    	vDTrazasLog   (modulo, "\t Al seleccionar proceso [%ld][%d]", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	vDTrazasError (modulo, "\t Al seleccionar proceso [%ld][%d]", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	return -1; /* Error Oracle */
		    }
		    
	    	vDTrazasLog   (modulo, "\t\tlCodCiclFact  %ld", LOG05,stTrazaProc.lCodCiclFact);
	    	vDTrazasLog   (modulo, "\t\tiCodProceso   %d" , LOG05,stTrazaProc.iCodProceso);
	    	vDTrazasLog   (modulo, "\t\tiCodEstaProc  %d" , LOG05,stTrazaProc.iCodEstaProc);
	    	vDTrazasLog   (modulo, "\t\tszFecInicio   %s" , LOG05,stTrazaProc.szFecInicio);
	    	vDTrazasLog   (modulo, "\t\tszFecTermino  %s" , LOG05,stTrazaProc.szFecTermino);
	    	vDTrazasLog   (modulo, "\t\tszGlsProceso  %s" , LOG05,stTrazaProc.szGlsProceso);
	    	vDTrazasLog   (modulo, "\t\tlCodCliente   %ld", LOG05,stTrazaProc.lCodCliente);
	    	vDTrazasLog   (modulo, "\t\tlNumAbonado   %ld", LOG05,stTrazaProc.lNumAbonado);
	    	vDTrazasLog   (modulo, "\t\tlNumRegistros %ld", LOG05,stTrazaProc.lNumRegistros);
		           	    
		    if (stTrazaProc.iCodEstaProc != iESTAPROC_TERMINADO_OK)
		    {   
		    	vDTrazasLog   (modulo, "\t El proceso [%ld][%d] No ha terminado OK", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	vDTrazasError (modulo, "\t El proceso [%ld][%d] No ha terminado OK", LOG01,pstDatos->lCodCiclFact, iPROC_FAMASCARA );
		    	return 1; /* Error Validacion : NO PROCESAR */
		    }
		    
		    return 0; /* Ciclo Valido : PROCESAR */
		}
	}
	else
	{
        vDTrazasLog  (modulo , "<< En la validacion de pre o pos facturacion >>"
                      "\n\t\t=> Detalle : IND_FACTUACION = 0  en FA_CICLFACT para COD_CICLFACT  %ld \n",LOG01,lhCodCiclFact);
        vDTrazasError(modulo , "<< En la validacion de pre o pos facturacion >>"
                      "\n\t\t=> Detalle : IND_FACTUACION = 0  en FA_CICLFACT para COD_CICLFACT  %ld \n",LOG01,lhCodCiclFact);
		return 1; /* Error Validacion : NO PROCESAR */
	}	
	
	/* RAO07052002: Se elimina ya que no se ejecuta nunca */
	/* return 0; Ciclo Valido : PROCESAR */
	

}
 
/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnPreparaCursorFACICLOCLI() */
/*********************************************************************************************/
BOOL bfnPreparaCursorFACICLOCLI(long lCliente, int iCiclo)
{
char modulo[]="bfnPreparaCursorFACICLOCLI";
    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   	 long lhCliente       ;
     int  ihCiclo         ;
/* EXEC SQL END DECLARE SECTION; */ 

    
   	lhCliente = lCliente;
    ihCiclo   = iCiclo;
    
    vDTrazasLog ( modulo, "\t<< Entrando en %s >>", LOG04, modulo);
    
	/* EXEC SQL DECLARE CursorFACICLOCLI CURSOR FOR
			 SELECT ROWID,
			 		COD_PRIORIDAD,
				    COD_DESPACHO,
				    NUM_ABONADO
			   FROM FA_CICLOCLI
			  WHERE COD_CLIENTE = :lhCliente
				AND COD_CICLO   = :ihCiclo
				AND IND_MASCARA = 1
		   ORDER BY COD_PRIORIDAD
		 FOR UPDATE ; */ 

	
	if (SQLCODE)	{
		vDTrazasError(modulo,"Al declarar CursorFACICLOCLI \n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	/* EXEC SQL OPEN CursorFACICLOCLI; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )148;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCiclo;
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

	
 
	if (SQLCODE)	{	
		vDTrazasError(modulo,"Al Abrir CursorFACICLOCLI \n\t%s\n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}


	return TRUE;

}

/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnRecorreFaCicloCli() */
/*********************************************************************************************/
BOOL bfnRecorreFaCicloCli(long lCodCliente,int iCodCiclo, int iCodPri, char *szCodDesp, long *lContAbo, long *lContAboUpd)
{
    char modulo[]="vfnRecorreFaCicloCli";
	BOOL bTerminoOK_CLI=TRUE;
	char motivo[256]="";
	long lCantAbonados=0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	long lhCodCliente       ;
         int ihCodCiclo         ;
    	 int ihCodPri           ;
		char szhCodDesp     [6] ;
		char szhRowid      [20] ;  /* EXEC SQL VAR szhRowid IS STRING(20) ; */ 

    	 int ihCodPrioridad     ;
		char szhCodDespacho [6] ;
    	long lhNumAbonado		;
    	 int ihPrimerCodPri		;
		char szhPrimerCodDesp[6];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    ihCodPri = iCodPri;
    ihCodCiclo = iCodCiclo;
    lhCodCliente = lCodCliente;
    strcpy(szhCodDesp,szCodDesp);
    
    vDTrazasLog ( modulo, "\t<< Entrando en %s >>", LOG04, modulo);
    
    if (!bfnPreparaCursorFACICLOCLI(lhCodCliente,ihCodCiclo))
       return FALSE;
    
    bTerminoOK_CLI=TRUE;		
    lCantAbonados=0;
	*lContAboUpd=0; /* reseteo Abonados Updateados */
	
	while (1)
	{
		/* EXEC SQL FETCH CursorFACICLOCLI
				  INTO :szhRowid		,
					   :ihCodPrioridad	,
					   :szhCodDespacho	,
					   :lhNumAbonado	; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )171;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
  sqlstm.sqhstl[0] = (unsigned long )20;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPrioridad;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhCodDespacho;
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
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

	
	
		if (SQLCODE == SQLNOTFOUND) 
		{
			bTerminoOK_CLI=TRUE;
			break;
		}
		else if (SQLCODE)
		{	
			bTerminoOK_CLI=FALSE;
			strcpy(motivo,sqlca.sqlerrm.sqlerrmc);
			break;
		}
		else /* SQLOK */
		{												
			lCantAbonados++;
			*lContAbo = *lContAbo + 1 ;
			
			if (lCantAbonados == 1) /* Primer abonado marca el criterio del cliente ...*/
			{
				ihPrimerCodPri = ihCodPrioridad; /* marca patron de comparacion */
				strcpy(szhPrimerCodDesp,szhCodDespacho);
				vDTrazasLog  (modulo , "\n\t<< El Cliente %ld - Abonado %ld (primero) >>\n"
									   "\t<< Tiene Cod.Despacho : %s, Cod_Prioridad : %d >>\n",
						               LOG03, lhCodCliente, lhNumAbonado,szhPrimerCodDesp,ihPrimerCodPri);
			}
			else if (strcmp(szhPrimerCodDesp,szhCodDespacho)!=0) /* verifica los siguientes para el log */
			{	
				vDTrazasLog  (modulo , "\t\tEl Cliente %ld - Abonado %ld, tiene \n"
				                       "\t\tCod Despacho [%s] y Cod Prioridad [%d]\n" 
				                       "\t\tdistintos del primer Abonado de este Cliente", 
				                       LOG02,lhCodCliente,lhNumAbonado,szhCodDespacho,ihCodPrioridad);
			}
		

			if ( ihCodPri < ihPrimerCodPri ) /* si la prioridad es menor que la del criterio max= 0 min 1,2,3, etc. */
			{								 /* se cambian criterio y prioridad en la tabla  */
				/* EXEC SQL UPDATE FA_CICLOCLI
							SET COD_DESPACHO = :szhCodDesp, 
								COD_PRIORIDAD = :ihCodPri
						  WHERE ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_CICLOCLI  set COD_DESPACHO=:b0,COD_PRIORIDAD=:b\
1 where ROWID=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )202;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodDesp;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPri;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[2] = (unsigned long )20;
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
					vDTrazasLog  (modulo , "\t\t<< En UPDATE cliente %ld - abonado %ld en FA_CICLO_CLI >>"
							               "\n\t\t\t\t=> Detalle : %s \n",LOG01, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc);
					vDTrazasError(modulo , "\t\t<< En UPDATE cliente %ld - abonado %ld en FA_CICLO_CLI >>"
							               "\n\t\t\t\t=> Detalle : %s \n",LOG01, lhCodCliente, lhNumAbonado, sqlca.sqlerrm.sqlerrmc);
					
					bTerminoOK_CLI=FALSE;
					strcpy(motivo,sqlca.sqlerrm.sqlerrmc);
					break;
				}
				else
				{
					*lContAboUpd = *lContAboUpd + 1;
					vDTrazasLog  (modulo , "\t\t<< Cambio Cod_Despacho para el cliente %ld - abonado %ld>>",
					                       LOG04, lhCodCliente, lhNumAbonado);

					vDTrazasLog  (modulo , "\t\t\tCOD_DESPACHO : [%s] -> [%s]"
					                       "\n\t\t\tCOD_PRIORIDAD: [%d] -> [%d]",
					                       LOG05, szhCodDespacho, szhCodDesp, ihCodPrioridad, ihCodPri  );

					if (strcmp(szhPrimerCodDesp,szhCodDespacho)!=0)
					{	
						vDTrazasLog  (modulo , "\t\tCod Despacho y Cod Prioridad distintos del primer Abonado de este Cliente", LOG02);
					}

				}
			}									
		}
		
		vDTrazasLog  (modulo, "\t\t<< Continua con el siguiente Abonado >>\n", LOG05);
		
	}/*endwhile*/

	/* EXEC SQL CLOSE CursorFACICLOCLI; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )229;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (SQLCODE)
	{	
		vDTrazasLog  (modulo,"<< Al Cerrar Cursor FA_CICLOCLI >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasError(modulo,"<< Al Cerrar Cursor FA_CICLOCLI >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
	}
	
	if (!bTerminoOK_CLI)
	{
		vDTrazasLog  (modulo,"<< Cursor FA_CICLOCLI No termino OK para este cliente - abonado >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,motivo);
		return FALSE;
	}
    
	return TRUE;

}


/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnInitSqlDinamico() */
/*********************************************************************************************/
BOOL bfnInitSqlDinamico  (char *szCadena, REGISTRODATOS stDat)
{
    char modulo[]="bfnInitSqlDinamico";
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);



	if (strcmp(stDat.szCodCritDesp,critMONTO)==0)
	{
		sprintf(szCadena,  " SELECT COD_CLIENTE"
							 " FROM FA_FACTDOCU_%ld"
							" WHERE TOT_FACTURA %s %s", 
							 stDat.lCodCiclFact, 
							 stDat.szValOper, 
							 stDat.szValParam);
	}
	else if (strcmp(stDat.szCodCritDesp,critTIPOCLI)==0)
	{
		sprintf(szCadena,   " SELECT DISTINCT COD_CLIENTE FROM" 
		                         " ( "
							     " SELECT CEL.COD_CLIENTE"
							       " FROM GA_INTARCEL CEL, FA_CICLOCLI FCC"
							      " WHERE FCC.COD_CICLO = %d"
							        " AND FCC.IND_MASCARA = 1"
							        " AND CEL.COD_CLIENTE = FCC.COD_CLIENTE"
							        " AND CEL.NUM_ABONADO = FCC.NUM_ABONADO"
							        " AND ( TO_DATE(%s,'YYYYMMDD') BETWEEN CEL.FEC_DESDE AND CEL.FEC_HASTA)"
							        " AND CEL.TIP_PLANTARIF %s '%s'"
							        " AND CEL.COD_CICLO = %d" 
							      " UNION ALL" 
							     " SELECT BEEP.COD_CLIENTE"
							       " FROM GA_INTARBEEP BEEP, FA_CICLOCLI FCC"
							      " WHERE FCC.COD_CICLO = %d"
							        " AND FCC.IND_MASCARA = 1"
							        " AND BEEP.COD_CLIENTE = FCC.COD_CLIENTE"
							        " AND BEEP.NUM_ABONADO = FCC.NUM_ABONADO"
							        " AND ( TO_DATE(%s,'YYYYMMDD') BETWEEN BEEP.FEC_DESDE AND BEEP.FEC_HASTA)"
							        " AND BEEP.TIP_PLANTARIF %s '%s' "
							        " AND BEEP.COD_CICLO = %d"
							        " ) ",
							stDat.iCodCiclo,
							stDat.szFecHastaCFijos,
							stDat.szValOper, 
							stDat.szValParam,
							stDat.iCodCiclo,
							stDat.iCodCiclo,
							stDat.szFecHastaCFijos,
							stDat.szValOper, 
							stDat.szValParam,
							stDat.iCodCiclo   );
	}
	else if (strcmp(stDat.szCodCritDesp,critPLAN)==0)
	{
		sprintf(szCadena,   " SELECT DISTINCT COD_CLIENTE FROM "
		                         " ( "
							     " SELECT CEL.COD_CLIENTE"
							       " FROM GA_INTARCEL CEL, FA_CICLOCLI FCC"
							      " WHERE FCC.COD_CICLO = %d"
							        " AND FCC.IND_MASCARA = 1"
							        " AND CEL.COD_CLIENTE = FCC.COD_CLIENTE"
							        " AND CEL.NUM_ABONADO = FCC.NUM_ABONADO"
							        " AND ( TO_DATE(%s,'YYYYMMDD') BETWEEN CEL.FEC_DESDE AND CEL.FEC_HASTA)"
							        " AND CEL.COD_PLANTARIF %s '%s' " 
							        " AND CEL.COD_CICLO = %d" 
							      " UNION ALL" 
							     " SELECT BEEP.COD_CLIENTE"
							       " FROM GA_INTARBEEP BEEP, FA_CICLOCLI FCC"
							      " WHERE FCC.COD_CICLO = %d"
							        " AND FCC.IND_MASCARA = 1"
							        " AND BEEP.COD_CLIENTE = FCC.COD_CLIENTE"
							        " AND BEEP.NUM_ABONADO = FCC.NUM_ABONADO"
							        " AND ( TO_DATE(%s,'YYYYMMDD') BETWEEN BEEP.FEC_DESDE AND BEEP.FEC_HASTA)"
							        " AND BEEP.COD_PLANTARIF %s '%s' "
							        " AND BEEP.COD_CICLO = %d"
							        " ) ",
							stDat.iCodCiclo,
							stDat.szFecHastaCFijos,
							stDat.szValOper, 
							stDat.szValParam,
							stDat.iCodCiclo,
							stDat.iCodCiclo,
							stDat.szFecHastaCFijos,
							stDat.szValOper, 
							stDat.szValParam,
							stDat.iCodCiclo   );
	}
	else if (strcmp(stDat.szCodCritDesp,critCANTABON)==0)
	{
		sprintf(szCadena,    " SELECT FFD.COD_CLIENTE"
		 					   " FROM FA_FACTABON_%ld FFA, FA_FACTDOCU_%ld FFD"
						      " WHERE FFA.IND_ORDENTOTAL = FFD.IND_ORDENTOTAL"
						   " GROUP BY FFD.COD_CLIENTE"
	   						 " HAVING COUNT(FFA.NUM_ABONADO) %s %s" , 
							stDat.lCodCiclFact, 
							stDat.lCodCiclFact, 
							stDat.szValOper, 
							stDat.szValParam   );
	}
	else if (strcmp(stDat.szCodCritDesp,critPRODUCTO)==0)
	{
		sprintf(szCadena,   "SELECT DISTINCT COD_CLIENTE "
							 " FROM FA_CICLOCLI"
							" WHERE COD_CICLO = %d"
							  " AND IND_MASCARA = 1" 
							  " AND COD_PRODUCTO %s %s ", 
							stDat.iCodCiclo,
							stDat.szValOper, 
							stDat.szValParam);
	}
	else if (strcmp(stDat.szCodCritDesp,critCLIENTE)==0)
	{
		sprintf(szCadena,   "SELECT distinct FA.COD_CLIENTE "
		                    "FROM FA_FACTDOCU_%d FA , GE_CLIENTES GE, "
		                    "( SELECT UNIQUE CLI.COD_CUENTA "
		                    "  FROM  GE_CLIENTES CLI, FA_FACTDOCU_%d FAC "
		                    "  WHERE FAC.TOT_FACTURA %s %s "
		                    "  AND   CLI.COD_CLIENTE = FAC.COD_CLIENTE) SEL "
		                    "WHERE GE.COD_CUENTA  = SEL.COD_CUENTA  "
		                    "AND   FA.COD_CLIENTE = GE.COD_CLIENTE ",
							stDat.lCodCiclFact, 
							stDat.lCodCiclFact, 
							stDat.szValOper, 
							stDat.szValParam);
	}
	else if (strcmp(stDat.szCodCritDesp,critCUENTA)==0)
	{
		sprintf(szCadena,   "SELECT FAC.COD_CLIENTE "
		                    "FROM FA_FACTDOCU_%d FAC, GE_CLIENTES CLI, "
		                    " (SELECT GE.COD_CUENTA , SUM(FA.TOT_FACTURA) "
							"  FROM  GE_CLIENTES GE, FA_FACTDOCU_%d FA   "
							"  WHERE GE.COD_CLIENTE = FA.COD_CLIENTE     "
							"  GROUP BY GE.COD_CUENTA  "
							"  HAVING SUM(FA.TOT_FACTURA) %s %s ) SEL "
							"WHERE SEL.COD_CUENTA  = CLI.COD_CUENTA   "
							"AND   CLI.COD_CLIENTE = FAC.COD_CLIENTE  ",
							stDat.lCodCiclFact, 
							stDat.lCodCiclFact, 
							stDat.szValOper, 
							stDat.szValParam);
	}
	else 
	{
	    vDTrazasLog   (modulo, "<< Criterio Inesperado  ' %s '>>", LOG01, stDat.szCodCritDesp);
	    vDTrazasError (modulo, "<< Criterio Inesperado  ' %s '>>", LOG01, stDat.szCodCritDesp);
	    return FALSE;
	}

    return TRUE;
}


/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnPreparaCursorClientes() */
/*********************************************************************************************/
BOOL bfnPreparaCursorClientes(char *szCadena)
{
    char modulo[]="bfnPreparaPrimerCursor";
    
    vDTrazasLog ( modulo, "<< Entrando en %s >>", LOG04, modulo);
    
    
    /* EXEC SQL PREPARE SQL_DINAMICO FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )244;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
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


    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "<< En PREPARE de la Consulta Dinamica >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En PREPARE de la Consulta Dinamica >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }

    /* EXEC SQL DECLARE CursorCLIENTES CURSOR FOR SQL_DINAMICO; */ 

    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "<< En DECLARE del Cursor Clientes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En DECLARE del Cursor Clientes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }

    /* EXEC SQL OPEN CursorCLIENTES; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )263;
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
        vDTrazasLog  (modulo , "<< En OPEN del Cursor Clientes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En OPEN del Cursor Clientes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }
    
    return TRUE;
}

/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnProcesaCriterio() */
/*********************************************************************************************/
BOOL bfnProcesaCriterio(REGISTRODATOS stDat)
{
	char modulo[]="bfnProcesaCriterio";
	char szCadenaSQL[1024]=""; 
	char szMotivo[128]="";
	long lContCli, lContUpd, lContAbo, lContAboUpd;
	BOOL bTerminoOK=TRUE;
	 
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	long lhCodCliente       ;
         int ihCodCiclo         ;
    	 int ihCodPri           ;
		char szhCodDesp     [6] ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

 	if (!bfnInitSqlDinamico (szCadenaSQL, stDat))
 	{
 		return FALSE;
	}
	
    vDTrazasLog ( modulo , "*** Query ***\n\t\t %s",LOG03, szCadenaSQL);
    
    if (!bfnPreparaCursorClientes(szCadenaSQL))
    {
    	return FALSE ;
    }
    
    vDTrazasLog  (modulo, "<< Verificando Clientes ... >>", LOG03);
	ihCodCiclo = stDat.iCodCiclo;
	ihCodPri   = stDat.iCodPrioridad;
	strcpy(szhCodDesp,stDat.szCodDesp);
	
	lContCli=0;
	lContUpd=0;
	lContAbo=0;
	lContAboUpd=0;
	
	while (1) /* ciclo infinito */
	{
    	/* EXEC SQL FETCH CursorCLIENTES 
    	         INTO  :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )278;
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


					
		if (SQLCODE == SQLNOTFOUND) 
		{
			bTerminoOK=TRUE;
			break;
		}
		else if (SQLCODE)
		{	
			bTerminoOK=FALSE;
			strcpy(szMotivo,sqlca.sqlerrm.sqlerrmc);
			break;
		}
		else
		{
			lContCli++; /* Aumenta el contador de los clientes verificados */
			if (bfnRecorreFaCicloCli(lhCodCliente,ihCodCiclo,ihCodPri,szhCodDesp,&lContAbo,&lContAboUpd))
			{    
				if (lContAboUpd > 0) lContUpd++; /* Si updateo al menos un abonado, aumenta los updateados*/
				
				if(!fnOraCommit())
				{
					vDTrazasError(modulo,"ERROR EN COMMIT.  Intentar� hacer Rollback\n\t=> Detalle : %s\n", 
		            	         LOG01, sqlca.sqlerrm.sqlerrmc);
					if (!fnOraRollBack())
					{
	    				vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
	    	                     LOG01, sqlca.sqlerrm.sqlerrmc);
					}
					
					bTerminoOK=FALSE;
					strcpy(szMotivo,sqlca.sqlerrm.sqlerrmc);
					break;
				}
			}
			else
			{
				if (!fnOraRollBack())
				{
    				vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
    	                     LOG01, sqlca.sqlerrm.sqlerrmc);
				}
				
				bTerminoOK=FALSE;
				strcpy(szMotivo,sqlca.sqlerrm.sqlerrmc);
				break;
			}
		}	
		vDTrazasLog  (modulo, "<< Continua con el siguiente Cliente >>\n", LOG05);
	}/* endwhile */
	
	vDTrazasLog(modulo,"<< Cerrando Cursor >>", LOG03);
	/* EXEC SQL CLOSE CursorCLIENTES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )297;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (SQLCODE)
	{	
		vDTrazasLog  (modulo,"<< Al Cerrar Cursor Clientes >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasError(modulo,"<< Al Cerrar Cursor Clientes >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
	}


	if (!bTerminoOK)
	{
		vDTrazasError(modulo,"<< Sale por error inesperado  >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		return FALSE;
	}

    vDTrazasLog  (modulo, "\n<< Revisados : %ld Clientes, %ld Abonados.  [ Clientes Updateados : %ld ] >>\n", 
    					  LOG03, lContCli, lContAbo, lContUpd);
	
	return TRUE;
	
}

/*******************************************************************************************************/



/***********************************************************************************/
/* BOOL bfnCargaDefault()*/
/***********************************************************************************/
BOOL bfnCargaDefault(REGISTRODATOS stDatos)
{
	char modulo[]="bfnCargaDefault";
	BOOL bTerminoOK_INI=TRUE;
	char szMotivo[256]="";
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	  char szhFecEmision[9]	;
	   int ihCodCiclo		;
	  long lhCodCliente		;
	  char szhCodDespacho[6]	;
       int ihCodPrioridad	;
	/* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	strcpy(szhFecEmision,stDatos.szFecEmision);
	ihCodCiclo = stDatos.iCodCiclo;
	
	
	/* EXEC SQL DECLARE CursorCARGACLIE CURSOR FOR
			SELECT DISTINCT COD_CLIENTE
			           FROM FA_CICLOCLI
			          WHERE COD_CICLO = :ihCodCiclo
			            AND IND_MASCARA = 1; */ 

	if (SQLCODE)
	{
		vDTrazasError(modulo,"<< Al declarar el Cursor CARGACLIE >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	/* EXEC SQL OPEN CursorCARGACLIE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )312;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
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
		vDTrazasError(modulo,"<< Al Abrir el Cursor CARGACLIE >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	bTerminoOK_INI=TRUE;
	memset(szMotivo,0,sizeof(szMotivo));
	while (1)
	{
		/* EXEC SQL FETCH CursorCARGACLIE
		          INTO :lhCodCliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )331;
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


		
		if (SQLCODE == SQLNOTFOUND) 
		{
		    vDTrazasLog (modulo, "\t\t** Fin del Cursor **\n", LOG03); 
			bTerminoOK_INI=TRUE;
			break;
		}
		else if (SQLCODE)
		{	
			bTerminoOK_INI=FALSE;
			sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
			break;
		}
		else /* SQLOK */
		{												
		 	/* EXEC SQL SELECT SECDESP.COD_DESPACHO,
		 					CODESP.COD_PRIORIDAD
		 			   INTO :szhCodDespacho,
		 			        :ihCodPrioridad
		 	           FROM FA_CODESPACHO CODESP, GA_SECDESPCLIE SECDESP
		 	          WHERE SECDESP.COD_CLIENTE = :lhCodCliente
		 	            AND SECDESP.FEC_DESDE <= TO_DATE(:szhFecEmision,'YYYYMMDD')
		 	            AND SECDESP.FEC_HASTA >= TO_DATE(:szhFecEmision,'YYYYMMDD')
		 	            AND CODESP.COD_DESPACHO = SECDESP.COD_DESPACHO ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select SECDESP.COD_DESPACHO ,CODESP.COD_PRIORIDAD into :b\
0,:b1  from FA_CODESPACHO CODESP ,GA_SECDESPCLIE SECDESP where (((SECDESP.COD_\
CLIENTE=:b2 and SECDESP.FEC_DESDE<=TO_DATE(:b3,'YYYYMMDD')) and SECDESP.FEC_HA\
STA>=TO_DATE(:b3,'YYYYMMDD')) and CODESP.COD_DESPACHO=SECDESP.COD_DESPACHO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )350;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPrioridad;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecEmision;
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



			if (SQLCODE == SQLNOTFOUND)
			{
				vDTrazasLog  (modulo,"<< Cliente No Encontrado [%ld], Verifica el Siguiente >>",LOG01,lhCodCliente);
				vDTrazasError(modulo,"<< Cliente No Encontrado [%ld] >>",LOG01,lhCodCliente);
			}
			else if (SQLCODE)
			{
				vDTrazasError(modulo,"<< Al Seleccionar COD_DESPACHO y COD_PRIORIDAD para el cliente [%ld] >>"
									 "\n\t\t=> Detalle : %s \n",LOG01,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
				bTerminoOK_INI=FALSE;
				sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
				break;
			}
			else /* SQLOK */
			{
				/* EXEC SQL UPDATE FA_CICLOCLI
						    SET COD_DESPACHO  =  :szhCodDespacho,
						        COD_PRIORIDAD =  :ihCodPrioridad
						  WHERE COD_CLIENTE   =  :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_CICLOCLI  set COD_DESPACHO=:b0,COD_PRIORIDAD=:b\
1 where COD_CLIENTE=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )385;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodDespacho;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPrioridad;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
					vDTrazasError(modulo,"<< Al UPDATEAR FA_CICLOCLI >>"
					                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
					bTerminoOK_INI=FALSE;
					sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
					break;
				}
				
			}
		}
	} /* endwhile*/
	
	/* EXEC SQL CLOSE CursorCARGACLIE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )412;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE)
	{
		vDTrazasError(modulo,"<< Al Cerrar el Cursor CARGACLIE >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
	}
	
	if (bTerminoOK_INI==TRUE)
	{	
		return TRUE;
	}
	else
	{
		vDTrazasError(modulo,"<< Al Iniciar Tablas >>"
							 "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		return FALSE;
	}
	
}

/********************************************************************************************/
/* bfnCargaSecDespDefault() */
/********************************************************************************************/
BOOL bfnCargaSecDespDefault(long CodCiclFact)
{
	char modulo[]="bfnCargaSecDespDefault";
	 int StsCicl=0;
	 
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

 	
    memset(&stDatos,0,sizeof(REGISTRODATOS));	
	stDatos.lCodCiclFact	  = CodCiclFact	;			/* Ciclo de Facturacion */
	strcpy(stDatos.szCodCritDesp , critINICIO );		/* indica INICIO de tablas */
	strcpy(stDatos.szIndPreProc,PREFACT);				/* indica pre facturacion */

    vDTrazasLog (modulo, "\t\t stDatos.lCodCiclFact   [%ld]", LOG05,stDatos.lCodCiclFact   );
    vDTrazasLog (modulo, "\t\t stDatos.szCriterio     [%s]" , LOG05,stDatos.szCodCritDesp  );
    vDTrazasLog (modulo, "\t\t stDatos.szIndPreProc   [%s]" , LOG05,stDatos.szIndPreProc   );

	StsCicl=ifnValidaCiclo(&stDatos);
	if ( StsCicl < 0 )
 	{
	    vDTrazasLog  (modulo, "\t\t** Fallo Validacion de Ciclo por error Oracle **", LOG01); 
	    vDTrazasError(modulo, "\t\t** Fallo Validacion de Ciclo por error Oracle **", LOG01); 
	    return FALSE;
 	}
	else if (StsCicl > 0)
	{
	    vDTrazasLog  (modulo, "\t\t** Fallo Validacion de Ciclo **", LOG01); 
	    vDTrazasError(modulo, "\t\t** Fallo Validacion de Ciclo **", LOG01); 
	    return FALSE;
 	}
    else /* StsCicl == 0 */
    {
		if (!bfnCargaDefault(stDatos)) 
		{
		    vDTrazasLog  (modulo, "** Fallo Carga de Secuencias de Despacho por Defecto **", LOG01); 
		    vDTrazasError(modulo, "** Fallo Carga de Secuencias de Despacho por Defecto **", LOG01); 
	    	return FALSE;
		}
	}
	
	
	return TRUE;
}


/*************************************************************************************************************/
/*************************************************************************************************************/
/*************************************************************************************************************/


/***************************************************************************************/
/* ifnGetCiclo () */
/***************************************************************************************/
int ifnGetCiclo(long lCodCiclFact)
{
	char modulo[]="ifnGetCiclo";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	      int ihCodCiclo;
	     long lhCodCiclFact;
	/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( modulo, "<< Entrando en %s >>", LOG04, modulo);
    
 	lhCodCiclFact = lCodCiclFact;

	/* EXEC SQL SELECT COD_CICLO
	           INTO :ihCodCiclo
			   FROM FA_CICLFACT
			  WHERE COD_CICLFACT = :lhCodCiclFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLO into :b0  from FA_CICLFACT where COD_CICLFA\
CT=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )427;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
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


			  
	if (SQLCODE)
	{
        vDTrazasLog  (modulo , "<< En el SELECT de FA_CICLFACT >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En el SELECT de FA_CICLFACT >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return 0;
	}
    else
    {
	    vDTrazasLog ( modulo, "<< Encontrado Ciclo %d >>", LOG05, ihCodCiclo);
    	return ihCodCiclo;
    }
}


/******************************************************************************/
/* bfnPreparaCursorClie2() */
/******************************************************************************/
BOOL bfnPreparaCursorClie2(char *szCadena)
{
    char modulo[]="bfnPreparaCursorClie2";
    
    vDTrazasLog ( modulo, "<< Entrando en %s >>", LOG04, modulo);
    
    /* EXEC SQL PREPARE SQL_DINAMICO FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )450;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
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


    if (SQLCODE)    {
        vDTrazasLog  (modulo , "<< En PREPARE de la Consulta Dinamica >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En PREPARE de la Consulta Dinamica >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }

    /* EXEC SQL DECLARE CursorCLIE2 CURSOR FOR SQL_DINAMICO; */ 

    if (SQLCODE)    {
        vDTrazasLog  (modulo , "<< En DECLARE del Cursor Clie2 >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En DECLARE del Cursor Clie2 >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }

    /* EXEC SQL OPEN CursorCLIE2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )469;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)    {
        vDTrazasLog  (modulo , "<< En OPEN del Cursor Clie2 >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError(modulo , "<< En OPEN del Cursor Clie2 >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
    }
    return TRUE;

}



/* ************************************************************************** */
/* bfnProcesoTraspaso()  */
/* ************************************************************************** */
BOOL bfnProcesoTraspaso(char *szRowid,long lCodCliente, long lCodCiclFact, int iCiclo)
{

char modulo[]="bfnProcesoTraspaso";
char szCadenaUPDATE[128]="";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     int ihCodCiclo		   ;
	long lhCodCliente 	   ;
	long lhCliente 	   	   ;
	char szhCodDespacho[6] ;
	char szhRowid[20]      ; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog (modulo, "<< Entrando en %s >>", LOG03, modulo);

	ihCodCiclo = iCiclo;
	lhCodCliente = lCodCliente;
	strcpy(szhRowid,szRowid);

	vDTrazasLog (modulo, "\tCod_CiclFact [%ld]\n"
						 "\tCod_Ciclo    [%d] \n"
						 "\tCod_Cliente  [%ld]", 
						 LOG06, lCodCiclFact,ihCodCiclo, lhCodCliente );
			  
			  
			  
	/* EXEC SQL SELECT /o+ index (FA_CICLOCLI PK_FA_CICLOCLI) o/
	                DISTINCT COD_CLIENTE,
						     COD_DESPACHO
					    INTO lhCliente,
						     szhCodDespacho
					    FROM FA_CICLOCLI
					   WHERE COD_CLIENTE = :lhCodCliente
					     AND COD_CICLO = :ihCodCiclo
					     AND IND_MASCARA = 1; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (FA_CICLOCLI PK_FA_CICLOCLI)  +*/ distinc\
t COD_CLIENTE ,COD_DESPACHO into :b0,:b1  from FA_CICLOCLI where ((COD_CLIENTE\
=:b2 and COD_CICLO=:b3) and IND_MASCARA=1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )484;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodDespacho;
 sqlstm.sqhstl[1] = (unsigned long )6;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCiclo;
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

 /* 20-Enero-2000*/
	if (SQLCODE) 
    {
   	    vDTrazasLog(modulo,"<< Al Seleccionar COD_DESPACHO desde FA_CICLOCLI >>"
   	                       "\n\t Cliente : %ld, Ciclo :%d",LOG01,lhCodCliente,ihCodCiclo);
   	    vDTrazasError(modulo,"<< Al Seleccionar COD_DESPACHO desde FA_CICLOCLI >>"
   	                        "\n\t Cliente : %ld, Ciclo:%d"
                            "\n\t\t=> Detalle : %s \n",
                            LOG01,lhCodCliente,ihCodCiclo,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
	}
	
	sprintf(szCadenaUPDATE, "UPDATE FA_FACTDOCU_%ld SET COD_DESPACHO = '%s' WHERE ROWID = '%s' ",
						     lCodCiclFact,szhCodDespacho,szhRowid);
    vDTrazasLog(modulo,"\tUPDATE>> %s",LOG05,szCadenaUPDATE);
	
	/* EXEC SQL PREPARE sql_Update FROM :szCadenaUPDATE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )515;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaUPDATE;
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


	if(SQLCODE != SQLOK)
    {
   	    vDTrazasLog(modulo,"<< Al Preparar el UPDATE de la FA_FACTDOCU_%ld >>"
   	    				   "\n\t>> %s",LOG01,lCodCiclFact,szCadenaUPDATE);
   	    vDTrazasError(modulo,"<< Al Preparar el UPDATE de la FA_FACTDOCU_%ld >>"
   	                        "\n\t Cliente : %ld"
                            "\n\t\t=> Detalle : %s \n",
                            LOG01,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }  
	
	/* EXEC SQL EXECUTE sql_Update; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )534;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE) 
    {
   	    vDTrazasLog(modulo,"<< Al UPDATEAR FA_FACTDOCU_%ld >>"
   	    				   "\n\t>> %s",LOG01,lCodCiclFact,szCadenaUPDATE);
   	    vDTrazasError(modulo,"<< Al UPDATEAR FA_FACTDOCU_%ld >>"
   	                        "\n\t Cliente : %ld"
                            "\n\t\t=> Detalle : %s \n",
                            LOG01,lhCodCliente,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
	}
		 
	return TRUE;
}


/*********************************************************************************************/
/* bfnTraspasaCriterios */
/*********************************************************************************************/
BOOL bfnTraspasaCriterios(long CodCiclFact)
{
char modulo[]="bfnTraspasaCriterios";
int  iCodCiclo=0;
long lContador=0;
BOOL bTerminoOK=TRUE;
char szCadenaSQL[64]="";    
char szFecha [20]  =""  ;   /*  Fecha de Sistema Para Update de Traza   */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char  szhRowid[20]  ; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

	long  lhCodCliente  ;
/* EXEC SQL END DECLARE SECTION; */ 

    
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	
    /************************************************************/
    /***VALIDA TRAZAPROC ***************************************/
    
        if (!bfnValidaTrazaProc(CodCiclFact, iPROC_CRITERIOS, iIND_FACT_ENPROCESO))   {
            return FALSE;
        }
        if(!fnOraCommit())    {
            vDTrazasLog  (modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG03, SQLERRM);
            vDTrazasError(modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            return (FALSE);
        }
        /* ************************************************************************* */
        if (!bfnSelectSysDate(szFecha))
            return (FALSE);
        bfnSelectTrazaProc (CodCiclFact, iPROC_CRITERIOS, &stTrazaProc);
        bPrintTrazaProc(stTrazaProc);
    /************************************************************/
    /************************************************************/
    
	
	iCodCiclo=ifnGetCiclo(CodCiclFact);
	vDTrazasLog(modulo,"Cod_CiclFact:[%ld]->Cod_Ciclo:[%d]",LOG05,CodCiclFact,iCodCiclo);
	if (iCodCiclo == 0 ) return FALSE;
	
	vDTrazasLog(modulo,"Abriendo Cursor DATOS", LOG05);
	sprintf(szCadenaSQL, "SELECT ROWID, COD_CLIENTE FROM FA_FACTDOCU_%ld ",CodCiclFact);
    vDTrazasLog (modulo, "\tSELECT>> %s", LOG05, szCadenaSQL);
	if (!bfnPreparaCursorClie2(szCadenaSQL))return FALSE;

	lContador=0;
	while (1) /* ciclo infinito */
	{
	    memset(&stDatos,0,sizeof(REGISTRODATOS));	

	    /* EXEC SQL FETCH CursorCLIE2 
	    		  INTO :szhRowid,
   			           :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 9;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )549;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
     sqlstm.sqhstl[0] = (unsigned long )20;
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



		if (SQLCODE == SQLNOTFOUND) {
			bTerminoOK=TRUE;
			break;
		}
		else if (SQLCODE)  {	
			bTerminoOK=FALSE;
			break;
		}
		else /* SQLOK */
		{ 
			if(!bfnProcesoTraspaso(szhRowid,lhCodCliente,CodCiclFact,iCodCiclo))
			{
				bTerminoOK=FALSE;
				break;			
			}
			else
			{
				lContador++;
			}
		}	
	}/* endwhile */
	
	vDTrazasLog(modulo,"%s [%ld] Cerrando Cursor ", LOG03, cfnGetTime(1),getpid());
	
    /* EXEC SQL CLOSE CursorClie2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )572;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
   	if (SQLCODE)
	{	
        vDTrazasError(modulo,"<< Al Cerrar Cursor >>"
                             "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
	}
	
    /************************************************************/
    /***UPDATEA TRAZAPROC ****************************************/
        if (!bfnSelectSysDate(szFecha))
            return (FALSE);
        else
        {
            stTrazaProc.iCodEstaProc       = iPROC_EST_OK                                 ;
            strcpy(stTrazaProc.szFecTermino,szFecha)                                      ;
            strcpy(stTrazaProc.szGlsProceso,"Proceso de Criterios de Despacho OK")        ;
            stTrazaProc.lCodCliente        = 0                                 ;
            stTrazaProc.lNumAbonado        = 0                                            ;
            stTrazaProc.lNumRegistros      = 0                                            ;
            bPrintTrazaProc(stTrazaProc)                                                  ;
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }


    /************************************************************/
    /************************************************************/


	if (bTerminoOK==TRUE)
	{
		vDTrazasLog(modulo,"\t\t*** Total de registros : %ld ***", LOG05, lContador);
		return TRUE;
	}
	else 
	{
		if (!fnOraRollBack())
		{
			vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
		  	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}
		return FALSE;
	}


}




/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

