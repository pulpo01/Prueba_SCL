
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
    "./pc/CritAsigMens.pc"
};


static unsigned int sqlctx = 55241587;


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
   unsigned char  *sqhstv[12];
   unsigned long  sqhstl[12];
            int   sqhsts[12];
            short *sqindv[12];
            int   sqinds[12];
   unsigned long  sqharm[12];
   unsigned long  *sqharc[12];
   unsigned short  sqadto[12];
   unsigned short  sqtdso[12];
} sqlstm = {12,12};

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

 static char *sq0003 = 
"select CRIT.rowid  ,CRIT.COD_FORMULARIO ,CRIT.COD_BLOQUE ,CRIT.CORR_MENSAJE \
,CRIT.NUM_LINEAS ,CRIT.COD_ORIGEN ,ORI.COD_PRIORIDAD ,NVL(CRIT.VAL_PARAM,'-1')\
 ,NVL(CRIT.VAL_OPERADOR,'<') ,TO_CHAR(CRIT.FEC_DESDE,'YYYYMMDD') ,TO_CHAR(CRIT\
.FEC_HASTA,'YYYYMMDD') ,CRIT.IND_CICLO  from FA_CRITASIGMEN CRIT ,FA_ORIMENSAJ\
E ORI where (CRIT.COD_CRITMENS=:b0 and CRIT.COD_ORIGEN=ORI.COD_ORIGEN)        \
   ";

 static char *sq0008 = 
"select MEN.rowid  ,MEN.COD_CLIENTE ,MEN.COD_FORMULARIO ,MEN.COD_BLOQUE ,NVL(\
MEN.COD_PRIORIDAD,999) ,MEN.NUM_LINEAS ,PAR.CANT_LINEASMEN  from FA_MENSCICLO \
MEN ,FA_PARMENSAJE PAR where ((((MEN.COD_CLIENTE>0 and MEN.COD_FORMULARIO>0) a\
nd MEN.COD_BLOQUE>0) and MEN.COD_FORMULARIO=PAR.COD_FORMULARIO) and MEN.COD_BL\
OQUE=PAR.COD_BLOQUE) order by MEN.COD_CLIENTE,MEN.COD_FORMULARIO,MEN.COD_BLOQU\
E,MEN.COD_PRIORIDAD            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,26,0,2,416,0,0,0,0,0,1,0,
20,0,0,2,136,0,2,420,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
51,0,0,3,391,0,9,504,0,0,1,1,0,1,0,1,97,0,0,
70,0,0,3,0,0,13,563,0,0,12,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
133,0,0,4,79,0,5,650,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
156,0,0,3,0,0,15,679,0,0,0,0,0,1,0,
171,0,0,5,165,0,4,727,0,0,5,1,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
206,0,0,6,0,0,17,964,0,0,1,1,0,1,0,1,97,0,0,
225,0,0,6,0,0,45,984,0,0,0,0,0,1,0,
240,0,0,7,168,0,3,1035,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,
283,0,0,6,0,0,13,1111,0,0,1,0,0,1,0,2,3,0,0,
302,0,0,6,0,0,15,1161,0,0,0,0,0,1,0,
317,0,0,8,419,0,9,1256,0,0,0,0,0,1,0,
332,0,0,8,0,0,13,1313,0,0,7,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,
375,0,0,9,58,0,5,1372,0,0,2,2,0,1,0,1,97,0,0,1,5,0,0,
398,0,0,8,0,0,15,1388,0,0,0,0,0,1,0,
413,0,0,10,552,0,3,1431,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
};


/*********************************************************************************
	Aplicacion : CritAsigMens = CRITerio de ASIGnacion de MENSajes.
	Fecha 	   : 06/01/2000 // 13/01/2000
	Basado en CritAsigDesp = CRITerio de ASIGnacion de secuencia de DESPacho.
	Ultima modificacion : Nuevo parametro que condiciona la accion del programa
	                      -p : priorizacion de los mensajes a imprimir
*********************************************************************************/

#include "CritAsigMens.h"
#define _CRITMENS_PC_

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

	fprintf( stdout, "\n\t***** CritAsigMens *****"
					 "\n\t%s"
					 "\n\t** pid : [ %8ld ] **"
					 "\n\t************************\n", 
	                 cfnGetTime(1),getpid() );


/* Validacion de parámetros y carga de estructura */

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
	       char  opt[] = ":u:l:c:d:p";
	
/* Variables locales */  
  	       char  *psztmp = "";

/* Flags de los valores recibidos*/
	        int  Userflag=FALSE;
 	        int  Logflag=FALSE;
 	        int  Ciclflag=FALSE;
 	        int  Asigflag=FALSE;
 	        int  Prioflag=FALSE;

    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	opterr=0;


/* Esta validacion corresponde sólo si se tiene al menos un parámetro que no sea opcional (necesario) */

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

			case 'p':
				if(Prioflag==FALSE)
				{
	                pstLineaCom->iPriorizar=1;/*TRUE*/                      
                    Prioflag=TRUE;
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

	/* Valida la ocurrencia del parametro -p */
	if (Prioflag==FALSE)
	{
		/* Revisa ocurrencia de parametros necesarios */
		if (( Asigflag == FALSE)&&( Ciclflag==FALSE))
		{
			fprintf (stderr,"\n\t<< Error : Falta definir una de las opciones necesarias '-p' o '-c y -d'  >>\n%s\n",szUsage);
			return -6;			
		}
	
		if(Ciclflag==FALSE)
		{	
			fprintf (stderr,"\n\t<< Error : Falta definir opcion '-c' Cod Ciclo Facturacion >>\n%s\n",szUsage);
			return -6;
		}

		if(Asigflag==FALSE)
		{	
			fprintf (stderr,"\n\t<< Error : Falta definir opcion '-d' Cod Criterio Asignacion Mensaje >>\n%s\n",szUsage);
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
	else
	{
		if (( Asigflag==FALSE )&&( Ciclflag==FALSE ))
		{
             sprintf(pstLineaCom->szCodCritAsig,"PRI");  /* Priorizar Mensajes */
		}
		else
		{
			fprintf (stderr,"\n\t<< Error : La opcion '-p' debe ir sola  >>\n%s\n",szUsage);
			return -6;			
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

	if ( (strcmp(szCriterio,critTODOS)==0)     || (strcmp(szCriterio,critTIPOCLI)==0)  || 
	     (strcmp(szCriterio,critCICLOFACT)==0) || (strcmp(szCriterio,critPLAN)==0)     || 
	     (strcmp(szCriterio,critPRODUCTO)==0)  || (strcmp(szCriterio,critINICIO)==0)   ||
	     (strcmp(szCriterio,critPAGOAUTOM)==0)   ) 
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
	sprintf(szArchivo,"CritMens_%s_%s",szCriterio,cfnGetTime(4));

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/CritAsigMens/%s",pathDir,cfnGetTime(2)); 
	free(pathDir);

	fprintf(stdout, "\n\t Creando directorio de log y errores : \n\t %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath); 
	if (system (szComando)!=0) return -7;

	fprintf(stdout, "\n\t Creando archivos de log y errores   : \n\t %s\n\n", szArchivo);
	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo); 
	if ((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -8;    }
	vDTrazasError(modulo, "%s [%ld] << Abre Archivo de Errores >>", LOG03, cfnGetTime(1),getpid());

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo); 
	if ((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -9;    }
	vDTrazasLog(modulo, "%s [%ld] << Abre Archivo de Log >>", LOG03, cfnGetTime(1),getpid());


	if ( strcmp(szCriterio,"PRI")==0 )
		vDTrazasLog(modulo, "%s [%ld] *** Priorizando los Mensajes a Imprimir ***", LOG03, cfnGetTime(1),getpid());
	
	
	return 0;
	
}/* ifnAbreArchivosLog */

/********************************************************************************************************/

/************************************************************************************/
/* ifnAccesoBaseDatos : Acceso a la Base y Procesamiento de la Información          */
/************************************************************************************/
int ifnAccesoBaseDatos(LINEACOMANDOGENERICA *pstLineaCom)
{
	char modulo[]="ifnAccesoBaseDatos";
 
    
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
		
	if(!bfnConnectORA(pstLineaCom->szOraAccount,pstLineaCom->szOraPasswd))
	{
        vDTrazasError(modulo, "No Hay Conexion a la Base de Datos", LOG01);
        return -10;
    }

    
    if (!bGetDatosGener (&stDatosGener, szSysDate))		
	{
        vDTrazasError(modulo, "No pudo recuperar FA_DATOSGENER", LOG01);
        return -11;
    }


	if (pstLineaCom->iPriorizar == 1)
	{
        if (!bfnPriorizaMensajes())
        {
	        vDTrazasError(modulo, "No pudo priorizar los mensajes",LOG01);
        	return -12;
        }		
	}
	else
	{
	    if (!bfnGetCriterios(pstLineaCom->szCodCritAsig,pstLineaCom->lCodCiclFact))		
		{
	        vDTrazasError(modulo, "No pudo recuperar detalles del Criterio %s", LOG01,pstLineaCom->szCodCritAsig);
	        return -14;
	    }
	}    	
	
	if (!fnOraCommitRelease())
	{	
		vDTrazasError(modulo,"ERROR EN COMMIT.  Intentará hacer Rollback\n\t=> Detalle : %s\n", 
		                     LOG01, sqlca.sqlerrm.sqlerrmc);
		if (!fnOraRollBackRelease())
		{
	    	vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
	    	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}
		
		return -15;	
	}

	return 0;
	
}

/********************************************************************************************************/

/***************************************************************************************/
/* bfnDeleteMensCiclo()  */
/***************************************************************************************/
BOOL bfnDeleteMensCiclo(char *szCrit, int iCodForm, int iCodBloq, long lCorrMsje, char *szCodOri) 
{
	char modulo[]="bfnDeleteMensCiclo";
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		 int ihCodForm = 0    ;
		 int ihCodBloq = 0    ;
		long lhCorrMsje = 0   ;
		char szhCodOri[3] ="" ;
	/* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	
	ihCodForm  = iCodForm;
	ihCodBloq  = iCodBloq;
	lhCorrMsje = lCorrMsje;
	strcpy(szhCodOri,szCodOri);
	
    vDTrazasLog (modulo, "\tCriterio       %s" , LOG05, szCrit  );
    vDTrazasLog (modulo, "\tCod_formulario %d" , LOG05, ihCodForm  );
    vDTrazasLog (modulo, "\tCod_Bloque     %d" , LOG05, ihCodBloq  );
    vDTrazasLog (modulo, "\tCorr_Mensaje   %ld", LOG05, lhCorrMsje );
    vDTrazasLog (modulo, "\tCod_Origen     %s" , LOG05, szhCodOri  );
	
	
	vDTrazasLog(modulo, "%s << Inicio Borrado >>", LOG05, cfnGetTime(1));
	
	if (strcmp(szCrit,critINICIO)==0) /* Si es inicio borra toda la tabla */
	{
		/* EXEC SQL DELETE FA_MENSCICLO ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 0;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from FA_MENSCICLO ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

	
	}
	else /* Si no borra solo lo que corresponde al criterio */
	{
		/* EXEC SQL DELETE FA_MENSCICLO 
		          WHERE COD_CLIENTE > 0
		          	AND COD_FORMULARIO  = :ihCodForm
		            AND COD_BLOQUE      = :ihCodBloq
		            AND CORR_MENSAJE    = :lhCorrMsje
		            AND COD_ORIGEN      = :szhCodOri; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "delete  from FA_MENSCICLO  where ((((COD_CLIENTE>0 and COD_\
FORMULARIO=:b0) and COD_BLOQUE=:b1) and CORR_MENSAJE=:b2) and COD_ORIGEN=:b3)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )20;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodForm;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodBloq;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCorrMsje;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodOri;
  sqlstm.sqhstl[3] = (unsigned long )3;
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


	}


	if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
	{
        vDTrazasError(modulo , "<< Al limpiar la tabla FA_MENSCICLO >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		if (!fnOraRollBack())
		{
 				vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
   	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}
		return FALSE;
	}
	else
	{
		vDTrazasLog(modulo, "%s << TerminoBorrado >>", LOG05, cfnGetTime(1));
	}
    

	if(!fnOraCommit())
	{
		vDTrazasError(modulo,"ERROR EN COMMIT.  Intentará hacer Rollback\n\t=> Detalle : %s\n", 
	            	         LOG01, sqlca.sqlerrm.sqlerrmc);
		if (!fnOraRollBack())
		{
 				vDTrazasError(modulo,"ERROR EN ROLLBACK\n\t=>Detalle : %s\n", 
   	                     LOG01, sqlca.sqlerrm.sqlerrmc);
		}
		
		return FALSE;
			
	}

	return TRUE;
}


/***************************************************************************************/
/* bfnPreparaCursorCriterios  */
/***************************************************************************************/

BOOL bfnPreparaCursorCriterios(char *szCriterio)
{
	char modulo[]="bfnPreparaCursorCriterios";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char  szhCodCritAsig  [4] ;
    /* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

	strcpy(szhCodCritAsig,szCriterio);
	
    /* EXEC SQL DECLARE CursorCRITERIOS CURSOR FOR 	
    SELECT CRIT.ROWID, 
		   CRIT.COD_FORMULARIO, 
		   CRIT.COD_BLOQUE, 
		   CRIT.CORR_MENSAJE, 
		   CRIT.NUM_LINEAS, 
		   CRIT.COD_ORIGEN, 
		   ORI.COD_PRIORIDAD, 
		   NVL(CRIT.VAL_PARAM,'-1'), 
		   NVL(CRIT.VAL_OPERADOR,'<'), 
		   TO_CHAR(CRIT.FEC_DESDE,'YYYYMMDD'), 
		   TO_CHAR(CRIT.FEC_HASTA,'YYYYMMDD'), 
		   CRIT.IND_CICLO 
	  FROM FA_CRITASIGMEN CRIT, FA_ORIMENSAJE ORI 
	 WHERE CRIT.COD_CRITMENS   =  :szhCodCritAsig
	   AND CRIT.COD_ORIGEN     = ORI.COD_ORIGEN ; */ 


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
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0003;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )51;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodCritAsig;
 sqlstm.sqhstl[0] = (unsigned long )4;
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
	long lCont=0;
	 int iAux = 0;
	 int StsCicl=0;
	BOOL bTerminoOK_CRI=TRUE;
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	 int ihCodFormulario   ;
		 int ihCodBloque	   ;
		long lhCorrMensaje	   ;
		 int ihNumLineas	   ;
		char szhCodOrigen  [3] ;
		 int ihCodPrioridad	   ;
		char szhValParam  [21] ;
		char szhValOper    [3] ;
		char szhFecDesde   [9] ;
		char szhFecHasta   [9] ;
		char szhIndCiclo   [2] ;
		char szhFecProceso [9] ;
		char szhRowid     [20] ; /* EXEC SQL VAR szhRowid IS STRING(20) ; */ 

		long lhCodCiclFact     ; /**/
    /* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
    vDTrazasLog (modulo, "<< '%s' v/s '%s' >>", LOG05, szCritAsig,critINICIO);
	
	if (strcmp(szCritAsig,critINICIO)==0) return bfnCargaMensajesDefault(lCodCiclFact);
		
	lhCodCiclFact=lCodCiclFact;

	if (!bfnPreparaCursorCriterios(szCritAsig))
		return FALSE;
	
	bTerminoOK_CRI=TRUE;
	lCont=0;
	while (1)
	{
		memset(szhValParam,0,sizeof(szhValParam));
	    memset(&stDatos,0,sizeof(REGISTRODATOS));	

		/* EXEC SQL FETCH CursorCRITERIOS	
			      INTO :szhRowid,
			      	   :ihCodFormulario	,
					   :ihCodBloque		,
					   :lhCorrMensaje	,
					   :ihNumLineas		,
					   :szhCodOrigen	,
					   :ihCodPrioridad	,
					   :szhValParam		,
					   :szhValOper		,
					   :szhFecDesde		,
					   :szhFecHasta		,
					   :szhIndCiclo		; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )70;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFormulario;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodBloque;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCorrMensaje;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihNumLineas;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhCodOrigen;
  sqlstm.sqhstl[5] = (unsigned long )3;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihCodPrioridad;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhValParam;
  sqlstm.sqhstl[7] = (unsigned long )21;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhValOper;
  sqlstm.sqhstl[8] = (unsigned long )3;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[9] = (unsigned long )9;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[10] = (unsigned long )9;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhIndCiclo;
  sqlstm.sqhstl[11] = (unsigned long )2;
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

			stDatos.lCodCiclFact		= lhCodCiclFact		;
			strcpy(stDatos.szCriterio   , szCritAsig )		;
			stDatos.iCodFormulario		= ihCodFormulario	; 
			stDatos.iCodBloque			= ihCodBloque		; 
			stDatos.lCorrMensaje		= lhCorrMensaje		;
			stDatos.iNumLineas			= ihNumLineas		;
			strcpy(stDatos.szCodOrigen	, szhCodOrigen )	;
			stDatos.iCodPrioridad		= ihCodPrioridad	;
			strcpy(stDatos.szValParam	, szhValParam   )	;
			strcpy(stDatos.szValOper	, szhValOper    )	;
			strcpy(stDatos.szFecDesde	, szhFecDesde   )	;
			strcpy(stDatos.szFecHasta	, szhFecHasta   )	;
			strcpy(stDatos.szIndCiclo	, szhIndCiclo   )	;

		    vDTrazasLog (modulo, "\t\t Ocurrencia Criterio    [%ld]", LOG05,lCont                  );
		    vDTrazasLog (modulo, "\t\t stDatos.lCodCiclFact   [%ld]", LOG05,stDatos.lCodCiclFact   );
		    vDTrazasLog (modulo, "\t\t stDatos.szCriterio     [%s]" , LOG05,stDatos.szCriterio     );
		    vDTrazasLog (modulo, "\t\t stDatos.iCodFormulario [%d]" , LOG05,stDatos.iCodFormulario );
		    vDTrazasLog (modulo, "\t\t stDatos.iCodBloque     [%d]" , LOG05,stDatos.iCodBloque     );
		    vDTrazasLog (modulo, "\t\t stDatos.lCorrMensaje   [%ld]", LOG05,stDatos.lCorrMensaje   );
		    vDTrazasLog (modulo, "\t\t stDatos.iNumLineas     [%d]" , LOG05,stDatos.iNumLineas     );
		    vDTrazasLog (modulo, "\t\t stDatos.szCodOrigen    [%s]" , LOG05,stDatos.szCodOrigen    );
		    vDTrazasLog (modulo, "\t\t stDatos.iCodPrioridad  [%d]" , LOG05,stDatos.iCodPrioridad  );
			vDTrazasLog (modulo, "\t\t stDatos.szValParam     [%s]" , LOG05,stDatos.szValParam     );
			vDTrazasLog (modulo, "\t\t stDatos.szValOper      [%s]" , LOG05,stDatos.szValOper      );
			vDTrazasLog (modulo, "\t\t stDatos.szFecDesde     [%s]" , LOG05,stDatos.szFecDesde     );
			vDTrazasLog (modulo, "\t\t stDatos.szFecHasta     [%s]" , LOG05,stDatos.szFecHasta     );
			vDTrazasLog (modulo, "\t\t stDatos.szIndCiclo     [%s]" , LOG05,stDatos.szIndCiclo     );
			
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
	       			sprintf(szMotivo,"No pudo procesar el Criterio %s\n",szCritAsig);
	       			bTerminoOK_CRI=FALSE;
	       			break;    	
				}
				else /* Se proceso correctamente el criterio */
				{    /* Se actualiza la tabla de los criterios */
					vDTrazasLog (modulo, "<< Actualizando FA_CRITASIGMEN >>\n", LOG03); 
					/* EXEC SQL UPDATE FA_CRITASIGMEN 
								SET COD_CICLFACT = :lhCodCiclFact,
								    FEC_PROCESO = SYSDATE
							  WHERE ROWID = :szhRowid; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 12;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update FA_CRITASIGMEN  set COD_CICLFACT=:b0,FEC_PROCESO=\
SYSDATE where ROWID=:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )133;
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
						vDTrazasError(modulo,"ERROR EN COMMIT.  Intentará hacer Rollback\n\t=> Detalle : %s\n", 
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
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )156;
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

	lhCodCiclFact = pstDatos->lCodCiclFact; 	/* ciclo de facturacion */
	
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
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLO ,IND_FACTURACION ,TO_CHAR(FEC_HASTACFIJOS,'\
YYYYMMDD') ,TO_CHAR(FEC_EMISION,'YYYYMMDD') into :b0,:b1,:b2,:b3  from FA_CICL\
FACT where COD_CICLFACT=:b4";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )171;
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
		pstDatos->iCodCiclo = ihCodCiclo ;
		strcpy (pstDatos->szFecHastaCFijos ,szhFecHastaCFijos); 
		strcpy (pstDatos->szFecEmision ,szhFecEmision); 
		vDTrazasLog ( modulo, "\t\t stDatos.iCodCiclo        [%d]" , LOG05, pstDatos->iCodCiclo        );
		vDTrazasLog ( modulo, "\t\t stDatos.szFecHastaCFijos [%s]" , LOG05, pstDatos->szFecHastaCFijos );
		vDTrazasLog ( modulo, "\t\t stDatos.szFecEmision     [%s]" , LOG05, pstDatos->szFecEmision     );
	}

	if (strcmp(pstDatos->szCriterio,critINICIO)!=0) /* Si no es carga inicial, Valida la fecha */
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
	if (ihIndFacturacion > 0) /* periodo de tasacion cerrado, en facturacion o facturado */
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

/*******************************************************************************************************/

/*********************************************************************************************/
/*	bfnInitSqlDinamico() */
/*********************************************************************************************/
BOOL bfnInitSqlDinamico (char *szCadena, REGISTRODATOS stDat)
{
    char modulo[]="bfnInitSqlDinamico";
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

	if (strcmp(stDat.szCriterio,critTODOS)==0)  
	{
		sprintf(szCadena,  " SELECT DISTINCT COD_CLIENTE"
							 " FROM FA_CICLOCLI"
							 " WHERE COD_CICLO = %d"
							 " AND IND_MASCARA = 1",
							 stDat.iCodCiclo );
	}
	else if (strcmp(stDat.szCriterio,critTIPOCLI)==0)	
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
	else if (strcmp(stDat.szCriterio,critPLAN)==0)
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
	else if (strcmp(stDat.szCriterio,critPRODUCTO)==0)
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
	else if (strcmp(stDat.szCriterio,critCICLOFACT)==0) 
	{
		sprintf(szCadena,  " SELECT DISTINCT COD_CLIENTE "
							 " FROM FA_CICLOCLI"
							" WHERE COD_CICLO = %d"
							 " AND IND_MASCARA = 1", 
							stDat.iCodCiclo   );
	}
	else if (strcmp(stDat.szCriterio,critPAGOAUTOM)==0)  /* Revisar */
	{
		sprintf(szCadena,    " SELECT DISTINCT PAC.COD_CLIENTE"
		 					   " FROM CO_UNIPAC PAC, FA_CICLOCLI FCC"
		 					  " WHERE FCC.COD_CICLO = %d"
		 					    " AND FCC.IND_MASCARA = 1"
		 					    " AND PAC.COD_CLIENTE = FCC.COD_CLIENTE",
							stDat.iCodCiclo   );
	}
	else 
	{
	    vDTrazasLog   (modulo, "<< Criterio Inesperado  ' %s '>>", LOG01, stDat.szCriterio);
	    vDTrazasError (modulo, "<< Criterio Inesperado  ' %s '>>", LOG01, stDat.szCriterio);
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
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )206;
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
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )225;
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
/**************************************************************************************/
/*  bfnInsertaClientes() */
/**************************************************************************************/

BOOL bfnInsertaClientes(long lCodCliente, REGISTRODATOS *pstDat)
{
	char modulo[]="bfnInsertaClientes";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	long lhCodCliente       ;
    	 int ihCodFormulario  	;
		 int ihCodBloque		;
		long lhCorrMensaje		;
		 int ihNumLineas		;
		char szhCodOrigen    [3];
		 int ihCodPrioridad		;
    /* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

    lhCodCliente		= lCodCliente			 ;
    ihCodFormulario		= pstDat->iCodFormulario ;
	ihCodBloque			= pstDat->iCodBloque	 ;
	lhCorrMensaje		= pstDat->lCorrMensaje	 ;
	ihNumLineas			= pstDat->iNumLineas	 ;
	strcpy( szhCodOrigen, pstDat->szCodOrigen )  ;
	ihCodPrioridad		= pstDat->iCodPrioridad	 ;

	vDTrazasLog  (modulo,"\tInsertando...",LOG05);
	vDTrazasLog  (modulo,"\tCOD_CLIENTE    [%ld]",LOG05,lhCodCliente	);
	vDTrazasLog  (modulo,"\tCOD_FORMULARIO [%d]", LOG05,ihCodFormulario	);
	vDTrazasLog  (modulo,"\tCOD_BLOQUE     [%d]", LOG05,ihCodBloque		);
	vDTrazasLog  (modulo,"\tCORR_MENSAJE   [%ld]",LOG05,lhCorrMensaje	);
	vDTrazasLog  (modulo,"\tNUM_LINEAS     [%d]", LOG05,ihNumLineas		);
	vDTrazasLog  (modulo,"\tCOD_ORIGEN     [%s]", LOG05,szhCodOrigen 	);
	vDTrazasLog  (modulo,"\tCOD_PRIORIDAD  [%d]", LOG05,ihCodPrioridad	);
	vDTrazasLog  (modulo,"\tIND_FACTURADO  [I] ", LOG05				    );
	
	/* EXEC SQL INSERT INTO FA_MENSCICLO
						(
							COD_CLIENTE		,
							COD_FORMULARIO	,
							COD_BLOQUE		,
							CORR_MENSAJE	,
							NUM_LINEAS		,
							COD_ORIGEN		,
							COD_PRIORIDAD	,
							IND_FACTURADO
						)
					VALUES
						(
							:lhCodCliente		,
							:ihCodFormulario	,
							:ihCodBloque		,
							:lhCorrMensaje		,
							:ihNumLineas		,
							:szhCodOrigen 		,
							:ihCodPrioridad		,
							'N'
						); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FA_MENSCICLO (COD_CLIENTE,COD_FORMULARIO,COD_BLO\
QUE,CORR_MENSAJE,NUM_LINEAS,COD_ORIGEN,COD_PRIORIDAD,IND_FACTURADO) values (:b\
0,:b1,:b2,:b3,:b4,:b5,:b6,'N')";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )240;
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
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFormulario;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodBloque;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCorrMensaje;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihNumLineas;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodOrigen;
 sqlstm.sqhstl[5] = (unsigned long )3;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodPrioridad;
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


	if (SQLCODE)
	{
		vDTrazasLog  (modulo,"<< Al Insertar Cliente %ld>>",LOG01,lCodCliente);
		vDTrazasError(modulo,"<< Al Insertar Cliente %ld>>"
	                     "\n\t\t=> Detalle : %s \n",LOG01,lCodCliente,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}                 
	
	return TRUE;	 

}                    
                     
                     
/*********************************************************************************************/
/*	bfnProcesaCriterio() */
/*********************************************************************************************/
BOOL bfnProcesaCriterio(REGISTRODATOS stDat) 	
{
	char modulo[]="bfnProcesaCriterio";
	char szCadenaSQL[1024]=""; 
	char szMotivo[128]="";
	long lContCli;
	BOOL bTerminoOK=TRUE;
	 
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	long lhCodCliente       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	
	if(!bfnDeleteMensCiclo(stDat.szCriterio,stDat.iCodFormulario,stDat.iCodBloque,stDat.lCorrMensaje,stDat.szCodOrigen)) /* Nota : hay un commit incluido en la funcion de borrado */
	{
        vDTrazasError(modulo, "No pudo eliminar datos de la FA_MENSCICLO ", LOG01);
        return FALSE;
	}

 	if (!bfnInitSqlDinamico (szCadenaSQL, stDat)) 
 	{
 		return FALSE;
	}
	
    vDTrazasLog ( modulo , "*** Query ***\n\t\t %s",LOG03, szCadenaSQL);
    
    if (!bfnPreparaCursorClientes(szCadenaSQL)) 
    {
    	return FALSE ;
    }
    
    vDTrazasLog  (modulo, "<< Insertando Clientes ... >>", LOG03);
	
	lContCli=0;
	
	while (1) /* ciclo infinito */
	{
    	/* EXEC SQL FETCH CursorCLIENTES INTO
					:lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 12;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )283;
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
			if (bfnInsertaClientes(lhCodCliente,&stDat))  
			{    		
				if(!fnOraCommit())
				{
					vDTrazasError(modulo,"ERROR EN COMMIT.  Intentará hacer Rollback\n\t=> Detalle : %s\n", 
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
				lContCli++; /* Aumenta el contador de los clientes insertados */

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
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )302;
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

    vDTrazasLog  (modulo, "\n<< Insertados : %ld Clientes >>\n", LOG03, lContCli);
	
	return TRUE;
	
}

/*******************************************************************************************************/

/* ******************************************************************************** */
/* cfnGetTime : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora) */
/* ******************************************************************************** */
/*char *cfnGetTime(int fmto)
{
	char modulo[]="cfnGetTime";

	static time_t timer;
	static size_t nbytes;
	static char szTime[26]="";

	memset(szTime,'\0',26);
	timer = time((time_t *)0);

	switch (fmto)
	{
		case 1 :
				nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		case 2 :
				nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
				break;
		case 3 :
				nbytes = strftime(szTime, 26, "[%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		case 4 :
				nbytes = strftime(szTime, 26, "%H%M%S", (struct tm *)localtime(&timer));	
				break;
		default :
				nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
				break;
	}
	
	return szTime;

}

******************************************************************************************/
/* bfnPreparaCursorMensajes() */
/******************************************************************************************/
	
BOOL bfnPreparaCursorMensajes()
{
	char modulo[]="bfnPreparaCursorMensajes";
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	
	/* EXEC SQL DECLARE CursorMENSAJES CURSOR FOR
			 SELECT MEN.ROWID,
					MEN.COD_CLIENTE,
					MEN.COD_FORMULARIO,
					MEN.COD_BLOQUE,
					NVL(MEN.COD_PRIORIDAD,999),
					MEN.NUM_LINEAS,
					PAR.CANT_LINEASMEN
			   FROM FA_MENSCICLO MEN, FA_PARMENSAJE PAR
	          WHERE MEN.COD_CLIENTE > 0
	            AND MEN.COD_FORMULARIO > 0 
	            AND MEN.COD_BLOQUE > 0 		
	          	AND MEN.COD_FORMULARIO = PAR.COD_FORMULARIO /o join entre las tablas o/
	            AND MEN.COD_BLOQUE     = PAR.COD_BLOQUE
	       ORDER BY MEN.COD_CLIENTE,MEN.COD_FORMULARIO,MEN.COD_BLOQUE,MEN.COD_PRIORIDAD; */ 


	if(SQLCODE)
	{
		vDTrazasError(modulo , "<< Al declarar el Cursor de los Mensajes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	/* EXEC SQL OPEN CursorMENSAJES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0008;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )317;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if(SQLCODE)
	{
		vDTrazasError(modulo , "<< Al Abrir el Cursor de los Mensajes >>"
                               "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	return TRUE;
}

/***************************************************************************************/
/* bfnPriorizaMensajes()  */
/***************************************************************************************/
BOOL bfnPriorizaMensajes()
{
	char modulo[]="bfnPriorizaMensajes";
	char szMotivo[128]="";
	BOOL bTerminoOK_MSG=FALSE;
	long lCont=0;
	long lClientAnt;
	 int iFormulAnt;
	 int iBloqueAnt;
	 int iPrioriAnt;
	 int iTamMsjAnt;
	 int iTamBlqAnt;				
	 
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhRowid     [20]	; /* EXEC SQL VAR szhRowid IS STRING(20) ; */ 

		long lhCodCliente		;
		 int ihCodFormulario	;
		 int ihCodBloque		;
		 int ihCodPrioridad		;
		 int ihTamMensaje		;  /* Tamaño del mensaje */    
		 int ihTamBloque		;  /* Tamaño del bloque  */
		char szhIndFactur [2]   ;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

/*
    vDTrazasLog  (modulo, "Funcion no definida", LOG01);
    vDTrazasError(modulo, "Funcion no definida", LOG01);	
	return FALSE;
*/
	if (!bfnPreparaCursorMensajes()) return FALSE;

	bTerminoOK_MSG=TRUE;
	lCont=0;
	lClientAnt= -1 ; /* valores ficticios para la primera comparacion */
	iFormulAnt= -1 ;
	iBloqueAnt= -1 ;

    vDTrazasLog (modulo, "Recorriendo Cursor", LOG05);
	while (1)
	{
		memset(szhIndFactur,0,sizeof(szhIndFactur));

		/* EXEC SQL FETCH CursorMENSAJES
	              INTO :szhRowid,
	           		   :lhCodCliente,
	           		   :ihCodFormulario,
	           		   :ihCodBloque,
	           		   :ihCodPrioridad,
	           		   :ihTamMensaje,
	           		   :ihTamBloque; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 12;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )332;
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
  sqlstm.sqhstv[2] = (unsigned char  *)&ihCodFormulario;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodBloque;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ihCodPrioridad;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihTamMensaje;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihTamBloque;
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


	
		if (SQLCODE == SQLNOTFOUND) 
		{
		    vDTrazasLog (modulo, "\t\t** Fin del Cursor **\n", LOG03); 
			bTerminoOK_MSG=TRUE;
			break;
		}
		else if (SQLCODE)
		{	
			bTerminoOK_MSG=FALSE;
			sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
			break;
		}
		else /* SQLOK */
		{												
			lCont++;

			if ((lClientAnt==lhCodCliente)&&(iFormulAnt==ihCodFormulario)&&(iBloqueAnt==ihCodBloque))	
			{
				/* si es el mismo cliente, formulario y bloque que el registro anterior */
				if(ihTamMensaje<=iTamBlqAnt)		/* si el mensaje cabe en lo que queda del bloque */
				{
					iTamBlqAnt -= ihTamMensaje; /* disminuye el espacio restante del bloque */
					szhIndFactur[0]='I';
				}
				else
				{
					szhIndFactur[0]='N';
				}
			}
			else 
			{
				/* Si se trata de un nuevo cliente, o un nuevo formulario o un nuevo bloque, lo trata como el primero */
				lClientAnt=lhCodCliente		;
				iFormulAnt=ihCodFormulario	;
				iBloqueAnt=ihCodBloque		;
				iPrioriAnt=ihCodPrioridad	;
				iTamMsjAnt=ihTamMensaje		;
				iTamBlqAnt=ihTamBloque		;				

				if(ihTamMensaje<=iTamBlqAnt)		/* si el mensaje cabe en el bloque */
				{
					iTamBlqAnt -= ihTamMensaje; /* disminuye el espacio restante del bloque */
					szhIndFactur[0]='I';
				}
				else
				{
					szhIndFactur[0]='N';
				}
			}		
			
			/* EXEC SQL UPDATE FA_MENSCICLO 
			            SET IND_FACTURADO = :szhIndFactur
			          WHERE ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 12;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_MENSCICLO  set IND_FACTURADO=:b0 where ROWID=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )375;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhIndFactur;
   sqlstm.sqhstl[0] = (unsigned long )2;
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
				vDTrazasError(modulo,"<< Al Updatear FA_MENSCICLO >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
				sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
				bTerminoOK_MSG=FALSE;
				break;
			}
			
		}/*SQLOK*/
	} /* endwhile */			

	/* EXEC SQL CLOSE CursorMENSAJES; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )398;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (SQLCODE)
	{	
		vDTrazasError(modulo,"<< Al Cerrar Cursor de los Mensajes >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		sprintf(szMotivo,"%s",sqlca.sqlerrm.sqlerrmc);
		bTerminoOK_MSG=FALSE;
	}
	
	
	if (!bTerminoOK_MSG)
	{
		vDTrazasLog    (modulo,"<< Cursor de los Mensajes No termino OK >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		vDTrazasError  (modulo,"<< Cursor de los Mensajes No termino OK >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,szMotivo);
		return FALSE;
	}
    else
    {
		vDTrazasLog    (modulo,"<< Revisado %ld Registros >>",LOG03,lCont);
		return TRUE;
    }	
}

/******************************************************************************************/

/***********************************************************************************/
/* BOOL bfnCargaDefault()*/
/***********************************************************************************/
BOOL bfnCargaDefault(REGISTRODATOS stDatos)
{
	char modulo[]="bfnCargaDefault";
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	  char szhFecEmision[9];
	   int ihCodCiclo;
	/* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);
	strcpy(szhFecEmision,stDatos.szFecEmision);
	ihCodCiclo = stDatos.iCodCiclo;
	
	/* EXEC SQL INSERT INTO FA_MENSCICLO      (
							COD_CLIENTE		,
							COD_FORMULARIO	,
							COD_BLOQUE		,
							CORR_MENSAJE	,
							NUM_LINEAS		,
							COD_ORIGEN		,
							COD_PRIORIDAD	,
							IND_FACTURADO	)	
			SELECT DISTINCT CLIE.COD_CLIENTE,
							CLIE.COD_FORMULARIO,
							CLIE.COD_BLOQUE,
							CLIE.CORR_MENSAJE,
							CLIE.NUM_LINEAS,
							CLIE.COD_ORIGEN,
							ORI.COD_PRIORIDAD,
							'N'
					   FROM  FA_MENSCLIENTE CLIE, FA_ORIMENSAJE ORI, FA_CICLOCLI FCC
					  WHERE FCC.COD_CICLO = :ihCodCiclo
					    AND FCC.IND_MASCARA = 1
					    AND FCC.COD_CLIENTE = CLIE.COD_CLIENTE
					    AND CLIE.FEC_DESDE <= TO_DATE(:szhFecEmision,'YYYYMMDD')
					    AND CLIE.FEC_HASTA >= TO_DATE(:szhFecEmision,'YYYYMMDD')
					    AND CLIE.COD_ORIGEN=ORI.COD_ORIGEN; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FA_MENSCICLO (COD_CLIENTE,COD_FORMULARIO,COD_BLO\
QUE,CORR_MENSAJE,NUM_LINEAS,COD_ORIGEN,COD_PRIORIDAD,IND_FACTURADO)select dist\
inct CLIE.COD_CLIENTE ,CLIE.COD_FORMULARIO ,CLIE.COD_BLOQUE ,CLIE.CORR_MENSAJE\
 ,CLIE.NUM_LINEAS ,CLIE.COD_ORIGEN ,ORI.COD_PRIORIDAD ,'N'  from FA_MENSCLIENT\
E CLIE ,FA_ORIMENSAJE ORI ,FA_CICLOCLI FCC where (((((FCC.COD_CICLO=:b0 and FC\
C.IND_MASCARA=1) and FCC.COD_CLIENTE=CLIE.COD_CLIENTE) and CLIE.FEC_DESDE<=TO_\
DATE(:b1,'YYYYMMDD')) and CLIE.FEC_HASTA>=TO_DATE(:b1,'YYYYMMDD')) and CLIE.CO\
D_ORIGEN=ORI.COD_ORIGEN)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )413;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
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



	if (SQLCODE)
	{
		vDTrazasError(modulo,"<< En el insert de la FA_MENSCICLO >>"
		                     "\n\t\t=> Detalle : %s \n",LOG01,sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	
	return TRUE;
	
}

/********************************************************************************************/
/* bfnCargaMensajesDefault() */
/********************************************************************************************/
BOOL bfnCargaMensajesDefault(long CodCiclFact)
{
	char modulo[]="bfnCargaMensajesDefault";
	 int StsCicl=0;
	 
    vDTrazasLog (modulo, "<< Entrando en %s >>", LOG04, modulo);

 	
    memset(&stDatos,0,sizeof(REGISTRODATOS));	
	stDatos.lCodCiclFact	  = CodCiclFact	;
	strcpy(stDatos.szCriterio , critINICIO );

    vDTrazasLog (modulo, "\t\t stDatos.lCodCiclFact   [%ld]", LOG05,stDatos.lCodCiclFact   );
    vDTrazasLog (modulo, "\t\t stDatos.szCriterio     [%s]" , LOG05,stDatos.szCriterio     );

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
  		if(!bfnDeleteMensCiclo(critINICIO,0,0,0," ")) /* Borrar toda la tabla */
		{
	        vDTrazasError(modulo, "No pudo eliminar datos de la FA_MENSCICLO ", LOG01);
	        return FALSE;
		}
		
		if (!bfnCargaDefault(stDatos)) 
		{
		    vDTrazasLog  (modulo, "\t\t** Fallo Carga de Mensajes por Defecto **", LOG01); 
		    vDTrazasError(modulo, "\t\t** Fallo Carga de Mensajes por Defecto **", LOG01); 
	    	return FALSE;
		}
	}
	
	
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

