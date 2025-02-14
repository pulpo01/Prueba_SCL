
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
           char  filnam[17];
};
static const struct sqlcxp sqlfpn =
{
    16,
    "./pc/regucola.pc"
};


static unsigned int sqlctx = 3460739;


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
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

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
{12,4130,1,0,0,
5,0,0,1,0,0,29,76,0,0,0,0,0,1,0,
};


/* ============================================================================= */
/*
    Tipo        :  APLICACION DE APOYO

    Nombre      :  regucola.pc

    Descripcion :  Se ejecuta al determinarse que una cola de proceso termino
				   con error(retorno > 0). De ser asi, este proceso le cambia el
				   estado a la cola a W para que se pueda volver a ejecutar
				   automaticamente cuando corresponda segun sea la definicion de
				   la cola.

    Recibe      :  Usuario/Password. ( por defecto asume los de la cuenta )
                   Nivel de Log ( por defecto asume 3 : Log Normal ) 
                   Punto de Gestion.
                   Accion.
                       
    Devuelve    :  
    
    Autor       :  Jorge Lizama Rojas
    Fecha       :  11 - Diciembre - 2000
*/ 
/* ============================================================================= */


#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "regucola.h"

#define iLOGNIVEL_DEF 	3       /* Define el nivel de Log por Defecto */
LINEACOMANDO  stLineaComando;   /* Datos con los que se invoco al proceso */

char gszColaProc[6]="";   /* NOMBRE DE COLA DE PROCESO A REGULARIZAR */

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


int main(int argc,char *argv[])
{
     char modulo[]="main";
    int iResult = 0;
    
    fprintf(stdout, "\n%s - REGUCOLA -\n", szGetTime(1));

    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));
    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0)    
    {
        iResult = 1; /* Fallo validacion */
    }
	else
	{    
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)   
        {
            iResult = 2; /* Fallo conexion */
        }
        else
        {
            /*- Prepara Archivo de Log -*/ 
            if (ifnPreparaArchivoLog() != 0)    
            {
                iResult = 3;  /* Fallo Log */
            }
            else
            {
                fprintf(stdout, "\n\n%s INICIO EJECUCION\n", szGetTime(1));

                if (!bfnCambiaEstadoCola(gszColaProc,"?","W")) /* de cualquiera a W */   
                {
					fprintf (stdout,"\n\tError >> Fallo bfnCambiaEstadoCola : %s\n", SQLERRM );
					fflush  (stdout);
                    iResult = 4; /* Fallo la Ejecucion */
                }
				else
				{
					/* EXEC SQL COMMIT; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 0;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )5;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


					if (SQLCODE)
					{
						fprintf (stdout,"\n\tError >> Fallo Commit : %s\n", SQLERRM );
						fflush  (stdout);
						iResult = 5; /* Fallo Proceso */
					}
				}
                fprintf(stdout, "\n\n%s FIN EJECUCION\n\n", szGetTime(1));

                vfnCierraArchivoLog();
            }
        }
    }

    fprintf(stdout, "\n%s - REGUCOLA -\n", szGetTime(1));

    return iResult;
   
} /* end main */    
/* ============================================================================= */

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
    char modulo[]="ifnValidaParametros";

/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
	extern char  *optarg;
	extern  int  optind, opterr, optopt;
	        int  iOpt=0;
	       char  opt[] = ":u:l:n:"; 

/*-- Variables locales -----------------------------------------------------------*/  
  	       char  *psztmp = "";
/*-- Flags de los valores recibidos ----------------------------------------------*/
	        int  Userflag=0;
 	        int  Logflag=0;
 	        int  Colaflag=0;
 	        
/*--Variables para controlar los nuevos parametros--------------------------------*/

/*-- Seteo de Valores Iniciles y por defecto -------------------------------------*/
	opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;
    
/*-- En caso de Invocacion sin Parametros ----------------------------------------*/
	if(argc == 1)
	{
        fprintf(stdout, "\nPARAMETROS");
        fprintf(stdout, "\n\t Cola de Proceso      : [XXXXX]"
        				"\n\t Usuario (default)    : [/]"
                        "\n\t Nivel de Log (def)   : [%d]",iLOGNIVEL_DEF );
        return 0; 
	}

/*-- Analisis de los argumentos recibidos ----------------------------------------*/
	while ((iOpt=getopt(argc, argv, opt))!=EOF)
	{
		switch(iOpt)
		{
			case 'u':  /*-- Usuario/Password --*/
 				if(!Userflag)
				{
	                strcpy(pstLC->szUsuarioOra, optarg);                      
    	            Userflag=1;
					if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL)
					{
						fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/'");
						return -1;
					}
					else
					{
						strncpy (pstLC->szOraAccount,pstLC->szUsuarioOra,psztmp-pstLC->szUsuarioOra);
						strcpy  (pstLC->szOraPasswd, psztmp+1);
					}
				}
				else
				{
					fprintf (stderr,"\n\tError >> opcion '-%c' duplicada",optopt);
					return -1;
				}
				break;

			case 'l': /*-- Nivel de Log --*/
				if(!Logflag)
				{
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
				}
				else
				{
					fprintf (stderr,"\n\tError >> opcion '-%c' duplicada",optopt);
					return -1;
				}
				break;
				
			case 'n': /*-- Cola de Proceso --*/
				if(!Colaflag)
				{
	                strcpy(gszColaProc, optarg);                      
    	            Colaflag=1;
				}
				else
				{
					fprintf (stderr,"\n\tError >> opcion '-%c' duplicada",optopt);
					return -1;
				}
				break;
				
			case '?':
				fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida",optopt);
				return -1;

			case ':':
				fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'",optopt);
				return -1;
		}
	} 
    pstLC->iLogLevel=stStatus.iLogNivel;

    fprintf(stdout, "\nPARAMETROS"
                    "\n\t Cola de Proceso      : [%s]"
                    "\n\t Usuario              : [%s/%s]"
                    "\n\t Nivel de Log         : [%d]" 
                    ,gszColaProc
                    ,pstLC->szOraAccount,  pstLC->szOraPasswd
                    ,pstLC->iLogLevel);
   	return 0;

} /* bfnValidaParamatros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB(LINEACOMANDO *pstLC)
{
    char modulo[]="ifnConexionDB";
    
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )
    {
        fprintf(stderr,"\nNo hay conexion a ORACLE");
        return -1;
    }
    
    return 0;
}
/* ============================================================================= */

/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
    char modulo[]="ifnPreparaArchivoLog";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhPathLogSched[128]; /* EXEC SQL VAR szhPathLogSched IS STRING (128); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
	sprintf(szhPathLogSched,"%s/CO_SCHEDULER\0",getenv("XPC_LOG"));

    sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    sprintf(stStatus.szFileName,"%s",gszColaProc);
   
    return ifnAbreArchivoLog();
    
} /* end ifnPreparaArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Crea directorio por fecha y abre ahi el archivo de log   */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
    char modulo[]="ifnAbreArchivoLog";
    char szArchivo[256]="";
    char szComando[256]="";
    static char szAux[9];
    
    strcpy (szAux,(char *)szSysDate("YYYYMMDD"));
    sprintf(szComando,"mkdir -p %s/%s",stStatus.szLogPathGene,szAux);
    if (system (szComando)!=0) 
    {
        fprintf (stderr,"\nError al intentar crear directorio de Log");
		fflush  (stderr);
        return -1;
    }

    memset(szArchivo,0,sizeof(szArchivo));
    sprintf(szArchivo,"%s/%s/%s.log",stStatus.szLogPathGene,szAux,stStatus.szFileName);
  	if((stStatus.LogFile = fopen(szArchivo,"a")) == (FILE*)NULL )
	{	
	    fprintf(stderr,"\nError al crear archivo de Log");
		fflush  (stderr);
		return -1;    
	}
	
    fprintf(stdout, "\n\t Archivo de Log       : %s", szArchivo );

	ifnTrazasLog(modulo, "- APERTURA DEL ARCHIVO DE LOG <%ld> -", LOG03,getpid());
    return 0;
 
}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/*  void vfnCierraArchivoLog(void)   cierra los descriptores de archivo de logs  */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
    char modulo[]="vfnCierraArchivoLog";
    
    ifnTrazasLog(modulo, "- CIERRE DEL ARCHIVO DE LOG <%ld> -", LOG03,getpid());

	if ( fclose(stStatus.LogFile) != 0 )
	{	
	    fprintf(stderr,"\n\tError al cerrar archivo de Log");
	}
    return;    
} /* end vfnCierraArchivoLog */
/* ============================================================================= */


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

