
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
static const struct sqlcxp sqlfpn =
{
    20,
    "./pc/co_scheduler.pc"
};


static unsigned int sqlctx = 55300667;


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

 static const char *sq0005 = 
"select COD_PROCESO ,NOM_PROCESO ,NOM_EJECUTABLE ,IND_NIVLOG ,IND_INTERVALO ,\
NVL(NUM_SEGUNDOS,0) ,NVL(IND_HORADIA,'-1') ,TO_CHAR(FEC_ESTADO,'YYYYMMDDHH24MI\
SS') ,COD_ESTADO  from CO_COLASPROC where ((COD_ACTIVACION='H' and TO_CHAR(SYS\
DATE,'HH24:MI:SS') between IND_HORAINI and IND_HORAFIN) and NOM_SERVIDOR is nu\
ll )           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,60,0,6,329,0,0,1,1,0,1,0,2,5,0,0,
24,0,0,2,60,0,6,437,0,0,1,1,0,1,0,2,5,0,0,
43,0,0,3,68,0,4,489,0,0,2,0,0,1,0,2,5,0,0,2,3,0,0,
66,0,0,4,63,0,5,521,0,0,1,1,0,1,0,1,3,0,0,
85,0,0,5,325,0,9,566,0,0,0,0,0,1,0,
100,0,0,5,0,0,13,573,0,0,9,0,0,1,0,2,9,0,0,2,97,0,0,2,9,0,0,2,3,0,0,2,97,0,0,2,
3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
151,0,0,5,0,0,15,582,0,0,0,0,0,1,0,
166,0,0,6,110,0,6,665,0,0,3,3,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
193,0,0,7,153,0,6,698,0,0,3,3,0,1,0,2,3,0,0,1,97,0,0,2,97,0,0,
220,0,0,8,110,0,6,829,0,0,3,3,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  LANZADOR DE COLAS DE PROCESO

    Nombre      :  co_scheduler.pc

    Descripcion :  Corazon del Sistema.  Se preocupa de ejecutar las distintas
                   colas de proceso en los momentos oportunos.
                   
    Recibe      :  Usuario/Password. ( por defecto asume los de la cuenta )
                   Nivel de Log ( por defecto asume 3 : Log Normal ) 
                   
    Devuelve    :  Valor entero para indicar el status de termino.
                   Interactua con la Base de Datos y el archivo de Log para registrar
                   como se desarrolla su ejecucion.
    
    Autor       :  Roy Barrera Richards
    Fecha       :  09 - Agosto - 2000
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_

#include "co_scheduler.h"

#define MAX_COLASPROC    50    /* cantidad maxima de colas de proceso , para definir host_array */
#define MAXSEGSLAUNCHED  30    /* maximo de segundos que puede estar lanzado sin cambiar de estado */
#define iLOGNIVEL_DEF     3    /* Define el nivel de Log por Defecto para este y los otros programas */

LINEACOMANDO  stLineaComando;  /* Datos con los que se invoco al proceso */

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


/* define variables globales */
/* EXEC SQL BEGIN DECLARE SECTION; */ 

static char szgHoyDia[9];    /* EXEC SQL VAR szgHoyDia IS STRING(9); */ 
      /* fecha actual para manejar los cambios de dia del log */
static char szgDiaAux[9];    /* EXEC SQL VAR szgDiaAux IS STRING(9); */ 

/* EXEC SQL END DECLARE SECTION; */ 


int igSegSleep=10;                /* cuanto tiempo duerme cuando no hay colas que procesar (def 10 segs) */
int igTotalColas=0;               /* total de colas de proceso activables, en espera y dentro del horario */
char szgDirLog[256]="";
char szError[256]="";

/* ============================================================================= */
typedef struct REG_CO_COLASPROC
{
    /* VARCHAR szCodProceso      [MAX_COLASPROC][6]; */ 
struct { unsigned short len; unsigned char arr[6]; } szCodProceso[50];

    char szNomProceso         [MAX_COLASPROC][31];
    /* VARCHAR szNomEjecutable   [MAX_COLASPROC][31]; */ 
struct { unsigned short len; unsigned char arr[34]; } szNomEjecutable[50];

    int   iIndNivLog          [MAX_COLASPROC];
    char  szIndIntervalo      [MAX_COLASPROC][2];
    int   iNumSegundos        [MAX_COLASPROC];
    char  szIndHoraDia        [MAX_COLASPROC][9];
    char  szFecEstado         [MAX_COLASPROC][15];
    char  szCodEstado         [MAX_COLASPROC][2];
}co_colasproc ;

typedef struct REG_PID_COLASPROC
{
	char szNomEjec[31];
	long lPidProceso;
}pid_colasproc;

/* ============================================================================= */

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    co_colasproc  sthColasProc;   /* host array para contener la colas de proceso */
    char szhPathKsh[256]  ; /* EXEC SQL VAR szhPathKsh IS STRING (256); */ 

    char szhPathExe[256]  ; /* EXEC SQL VAR szhPathExe IS STRING (256); */ 

/* EXEC SQL END DECLARE SECTION; */ 


pid_colasproc stPidColas[MAX_COLASPROC];


/* ============================================================================= */
/* main : Rutina principal                                                       */
/* ============================================================================= */
int main(int argc,char *argv[])
{
    char modulo[]="main";
    int iResult;
    char status[16]="";

    fprintf(stdout, "\n\t%s Subida CO_SCHEDULER  pid(%ld)  Version(%s)\n", szGetTime(1),getpid(), szVERSION);
    fflush (stdout);
    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));

    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0)
    {
    	strcpy(szError,"Scheduler de Cobranzas termino con ERROR al Validar Parametros");
    	ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
        iResult = -1; /* Fallo validacion */
    }
    else
    {
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)
        {
    		strcpy(szError,"Scheduler de Cobranzas termino con ERROR al Tratar de Conectarse a la Base de Datos");
    		ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
            iResult = -2; /* Fallo conexion */
        }
        else
        {
            /*- Prepara Archivo de Log -*/ 
            if (ifnPreparaArchivoLog() != 0)    
            {
    			strcpy(szError,"Scheduler de Cobranzas termino con ERROR al generar Archivos de Log");
    			ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
                iResult = -3;  /* Fallo Log */
            }
            else
            {
                /*- Ejecuta el Scheduler de Cobros propiamente tal -*/
                if (ifnCOScheduler() < 0)   
                {
    				strcpy(szError,"Scheduler de Cobranzas termino con ERROR durante Ejecucion");
    				ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
                    iResult = -4; /* Fallo CO_Scheduler */
                }

                vfnCierraArchivoLog();
            }
        }
    }

    fprintf(stdout, "\n\t%s Bajada CO_SCHEDULER  pid(%ld)\n", szGetTime(1),getpid());
    fflush (stdout);
    strcpy(szError,"Se BAJO el Scheduler de Cobranzas");
    ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
    return iResult;
    
} /* end main */    
/* ============================================================================= */




/* ============================================================================= */
/* szDateOra : Obtiene la fecha del sistema en formato analogo al Oracle dado    */
/* ============================================================================= */
char *szDateOra(char *szFmtoOracle)
{
	static time_t timer;
	static size_t nbytes;
	static char szTime[26]="";

	memset(szTime,'\0',26);
	timer = time((time_t *)0);

    if (!strcmp(szFmtoOracle,"YYYYMMDD"))
    {
	    nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
	}
	else if (!strcmp(szFmtoOracle,"[DD-MON-YYYY][HH24:MI:SS]"))
	{
	    nbytes = strftime(szTime, 26, "[%d-%b-%Y][%T]", (struct tm *)localtime(&timer));	
    }
    else if (!strcmp(szFmtoOracle,"HH24:MI:SS"))
    {
   	    nbytes = strftime(szTime, 26, "[%T]", (struct tm *)localtime(&timer));	
    }
	else
	{
  	    nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
    }
	return (char *) szTime;
}


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
           char  opt[] = ":u:l:";
/*-- Variables locales -----------------------------------------------------------*/  
           char  *psztmp = "";
/*-- Flags de los valores recibidos ----------------------------------------------*/
            int Userflag=0;
            int Logflag=0;

/*-- Seteo de Valores Iniciles y por defecto -------------------------------------*/
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;

/*-- En caso de Invocacion sin Parametros ----------------------------------------*/
    if(argc == 1)
    {
        return 0; /*ok asume valores por defecto */
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
                        fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/' \n");
                        fflush  (stderr);
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
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
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
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;
            case '?':
                fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida\n",optopt);
                fflush  (stderr);
                return -1;

            case ':':
                fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'\n",optopt);
                fflush  (stderr);
                return -1;
        }
    } 
    pstLC->iLogLevel=stStatus.iLogNivel;
    fprintf(stdout, "\n\t Usuario :[%s] Passw:[%s]\n\t \n",pstLC->szOraAccount,pstLC->szOraPasswd );
    fflush (stdout);

       return 0;

} /* end bfnValidaParamatros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB( LINEACOMANDO *pstLC )
{
    char modulo[] = "ifnConexionDB";
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char hszConnectStr[129]; /* EXEC SQL VAR hszConnectStr IS STRING(129); */ 

		char szhUser[30]; /* EXEC SQL VAR szhUser IS STRING(30); */ 

	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy( hszConnectStr, pstLC->szOraAccount );
	strcat( hszConnectStr, "/" );
	strcat( hszConnectStr, pstLC->szOraPasswd);
	
    ifnTrazasLog(modulo,"CONECCION :[%s]", LOG05,hszConnectStr);
    
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )
    {
    	ifnTrazasLog(modulo,"\nNo hay conexion a ORACLE \n", LOG02);
        return -1;
    }

    return 0;
}/* end ifnConexionDB*/
/* ============================================================================= */

/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
    char modulo[]="ifnPreparaArchivoLog";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhPathLogSched[256]; /* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


	sprintf(szhPathLogSched,"%s/CO_SCHEDULER",getenv("XPC_LOG"));
	sprintf(szhPathKsh,"%s",getenv("XPC_KSH"));
	sprintf(szhPathExe,"%s",getenv("XPC_EXE"));
        
    sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    sprintf(stStatus.szFileName,"co_scheduler");
    
    return ifnAbreArchivoLog();
    
} /* end ifnPreparaArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Crea directorio por fecha y abre archivo en modo append  */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
    char modulo[]="ifnAbreArchivoLog";
    char szArchivo[256]="";
    char szComando[256]="";

    memset(szgDirLog,'\0',sizeof(szgDirLog));
        
    /***** mac 11.09.03 MA-0171 MA-0175
    EXEC SQL SELECT TO_CHAR(SYSDATE,'YYYYMMDD') INTO :szgHoyDia FROM DUAL; 
    *******/
    /* EXEC SQL EXECUTE
    Begin
       :szgHoyDia := TO_CHAR(SYSDATE,'YYYYMMDD'); 
    End;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szgHoyDia := TO_CHAR ( SYSDATE , 'YYYYMMDD' ) ; En\
d ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szgHoyDia;
    sqlstm.sqhstl[0] = (unsigned long )9;
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
        fprintf(stdout,"\nFallo al obtener la fecha de la base datos[%d]. Ocupa la Del Sistema\n",SQLCODE);
        strcpy (szgHoyDia,(char *)szDateOra("YYYYMMDD"));
    }
    
    sprintf(szgDirLog,"%s/%s",stStatus.szLogPathGene,szgHoyDia);
    
    memset(szComando,'\0',sizeof(szComando));
    sprintf(szComando,"mkdir -p %s",szgDirLog);
    if (system(szComando)!=0) 
    {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
    }

    fprintf(stdout, "\n\t%s Creando nuevos archivos de Log\n\t en : '%s' \n", szGetTime(1),szgDirLog);
    fflush (stdout);

    memset(szArchivo,0,sizeof(szArchivo));
    sprintf(szArchivo,"%s/%s.log",szgDirLog,stStatus.szFileName);
    if((stStatus.LogFile = fopen(szArchivo,"a")) == (FILE*)NULL )
    {    
        fprintf(stderr,"Error al crear archivo de Log\n");
        fflush (stderr);
        return -1;    
    }
        
    ifnTrazasLog(modulo,"----- APERTURA DEL ARCHIVO DE LOG <%ld> -----",LOG03, getpid());
    return 0;
    
}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/*  void vfnCierraArchivoLog(void)   cierra los descriptores de archivo de logs  */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
    char modulo[]="vfnCierraArchivoLog";
    
    ifnTrazasLog(modulo, "-----  CIERRE  DEL ARCHIVO DE LOG <%ld> -----\n", LOG03,getpid());

    if ( fclose(stStatus.LogFile) != 0 )
    {    
        fprintf(stderr,"Error al cerrar archivo de Log\n");
        fflush (stderr);
    }
    return;    
} /* end vfnCierraArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnCOScheduler : Maneja las colas. Ya esta conectado a la base de datos       */
/* ============================================================================= */
int ifnCOScheduler()
{
    char modulo[]="ifnCOScheduler";

    int sts,i;
    
/*-- Verifica el Estado del Co_Scheduler antes de comenzar -------------------------*/
    sts = ifnEstadoScheduler();
    if ( sts != 0 ) return sts ; /* Error al verificar estado (-1) o esta Inactivo antes de comenzar (1) */
    
/*-- Intenta Registrar la Ejecucion Actual del Co_Scheduler ------------------------*/
    if (!bfnEjecucionActual()) 
    {
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s",LOG00,SQLERRM);
        return -1;
    }
    else
    {    if (!bfnOraCommit())    
        {    
            ifnTrazasLog(modulo,"En Commit 1 : %s",LOG00,SQLERRM);
            if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
            return -1;    
        }
    	strcpy(szError,"Se SUBIO el Scheduler de Cobranzas");
    	ifnMailAlert("CO_SCHEDULER","TODOS","%s",szError);
    }
	
	ifnTrazasLog(modulo,"\n\t CO_SCHEDULER Version:[%s]\n",LOG00,szVERSION);
/*--Inicializa Arreglo que mantendra el PID de cada cola activa */
	memset(&stPidColas,0,sizeof(pid_colasproc));
	for (i=0; i < MAX_COLASPROC; i++)
   	   stPidColas[i].szNomEjec[0]='\0';

/*-- Ciclo principal de Co_Scheduler -----------------------------------------------*/
    while(1)
    {   
        memset(&sthColasProc,0,sizeof(co_colasproc));
/*-- Verifica el Estado del Co_Scheduler antes de continuar ------------------------*/
        sts = ifnEstadoScheduler();
        if ( sts != 0 ) return (sts>0)?0:sts ; /* 0:termino normal , sts (-1) termino anormal */
                        
/*-- Verifica dia actual, contra dia que se inicio el proceso ----------------------*/
        /* strcpy (szgDiaAux, (char *)szSysDateNew("YYYYMMDD"));*/

        /***** mac 11.09.03 MA-0171 MA-0175
        EXEC SQL SELECT TO_CHAR(SYSDATE,'YYYYMMDD') INTO :szgDiaAux FROM DUAL;
        *******/
        /* EXEC SQL EXECUTE
        Begin
           :szgDiaAux := TO_CHAR(SYSDATE,'YYYYMMDD'); 
        End;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin :szgDiaAux := TO_CHAR ( SYSDATE , 'YYYYMMDD' ) \
; End ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )24;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szgDiaAux;
        sqlstm.sqhstl[0] = (unsigned long )9;
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
            fprintf(stdout,"\nFallo al obtener la fecha de la base datos[%d]* Ocupa la Del Sistema\n",SQLCODE);
            strcpy (szgDiaAux,(char *)szDateOra("YYYYMMDD"));
        }
            
        if ( strcmp(szgHoyDia,szgDiaAux) != 0 )                  
        {
            fprintf(stdout, "\n\t%s Diferencia en la fecha : '%s' != '%s' \n", 
                                 szGetTime(1),szgHoyDia,szgDiaAux);
            fflush (stdout);
            ifnTrazasLog (modulo, "-----             FIN DEL DIA             -----", LOG03);
            vfnCierraArchivoLog();
            if ( ifnAbreArchivoLog() != 0 ) return -1;
        }
        
/*-- Verifica las colas de proceso activas ---------------------------------------*/
        if (ifnCargaColasDeProceso() != 0) return -1;

        if (igTotalColas == 0) 
        {    
            sleep(igSegSleep);
        }
        else 
        {
            if (ifnActivaColas() != 0) return -1;
        }    
        
    } /* end while */
    
} /* end ifnCOScheduler */

/* ============================================================================= */
/* ifnEstadoScheduler :  verifica estado actual de co_scheduler                  */
/* ============================================================================= */
int ifnEstadoScheduler()
{
    char modulo[]="ifnEstadoScheduler";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCodActivacion[2]; /* EXEC SQL VAR szhCodActivacion IS STRING (2); */ 

 		int ihNumSegundos;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    ifnTrazasLog(modulo,"%s", LOG05,modulo);
    
    /* EXEC SQL SELECT COD_ACTIVACION,NUM_SEGUNDOS INTO :szhCodActivacion,:ihNumSegundos FROM CO_SCHEDULER; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ACTIVACION ,NUM_SEGUNDOS into :b0,:b1  from CO\
_SCHEDULER ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )43;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodActivacion;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumSegundos;
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


    
    if (SQLCODE) 
    {
        ifnTrazasLog (modulo,"SELECT FROM CO_SCHEDULER %s",LOG00,SQLERRM);
        return -1; /* ocurrio un error no se pudo verificar el estado*/
    }
    else if (strcmp(szhCodActivacion,"H")==0)  /* Esta Activo */
    {
        igSegSleep=ihNumSegundos; /* tiempo que duerme co_scheduler cuando no hay colas */
        return 0; /* verificado , si esta activo, debe seguir corriendo */
    }
    else /*Estado inesperado */
    {
        ifnTrazasLog(modulo,"co_scheduler en estado '%s'!= 'H' -> termina la ejecucion", LOG03,szhCodActivacion);
           return 1; /* verificado, no esta activo, debe deternerse  */
    }
}/* end ifnEstadoScheduler */
/* ============================================================================= */

/* ============================================================================= */
/* bfnEjecucionActual : Registra en la base de datos la ejecución actual         */
/* ============================================================================= */
BOOL bfnEjecucionActual()
{
    char modulo[]="bfnEjecucionActual";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhPidProc;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhPidProc = getpid();
    
    /* EXEC SQL UPDATE CO_SCHEDULER SET PID_PROCESO = :lhPidProc, FEC_ACTIVACION = SYSDATE ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_SCHEDULER  set PID_PROCESO=:b0,FEC_ACTIVACION=S\
YSDATE";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
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


                    
    if (SQLCODE) 
    {
        ifnTrazasLog(modulo,"UPDATE Co_Scheduler =>%s",LOG00,SQLERRM);
        return FALSE;
    }

    return TRUE;                
    
} /* end bfnEjecucionActual */
/* ============================================================================= */

/* ============================================================================= */
/* ifnCargaColasDeProceso() : Carga colas de procesos en la memoria (host array)  */
/* ============================================================================= */
int ifnCargaColasDeProceso()
{
	int i,j,iFlagExist;
    char modulo[]="ifnCargaColasDeProceso";


    ifnTrazasLog(modulo,"Recuperando colas de proceso ...", LOG05);

    /* EXEC SQL DECLARE cur_CO_COLASPROC CURSOR FOR
    SELECT COD_PROCESO,
           NOM_PROCESO,
           NOM_EJECUTABLE,
           IND_NIVLOG,
           IND_INTERVALO,
           NVL(NUM_SEGUNDOS,0),
           NVL(IND_HORADIA,'-1'),
           TO_CHAR(FEC_ESTADO,'YYYYMMDDHH24MISS'),
           COD_ESTADO
      FROM CO_COLASPROC
     WHERE COD_ACTIVACION = 'H'													/o donde : la cola sea activable (Habilitada) o/
       AND TO_CHAR(SYSDATE,'HH24:MI:SS')  BETWEEN IND_HORAINI AND IND_HORAFIN	/o y este dentro del horario de ejecucion o/
       AND NOM_SERVIDOR IS NULL; */ 
												/* solo los procesoso locales, no los remotos */ 

    if (SQLCODE) 
    {
        ifnTrazasLog(modulo,"DECLARE cur_CO_COLASPROC :%s", LOG00,SQLERRM);
        return -1;
    }

    /* EXEC SQL OPEN cur_CO_COLASPROC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )85;
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
        ifnTrazasLog(modulo,"OPEN cur_CO_COLASPROC :%s", LOG00,SQLERRM);
        return -1;
    }
    
    /* EXEC SQL FETCH cur_CO_COLASPROC INTO :sthColasProc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )50;
    sqlstm.offset = (unsigned int  )100;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)sthColasProc.szCodProceso;
    sqlstm.sqhstl[0] = (unsigned long )8;
    sqlstm.sqhsts[0] = (         int  )8;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)sthColasProc.szNomProceso;
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )31;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)sthColasProc.szNomEjecutable;
    sqlstm.sqhstl[2] = (unsigned long )33;
    sqlstm.sqhsts[2] = (         int  )36;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)sthColasProc.iIndNivLog;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)sthColasProc.szIndIntervalo;
    sqlstm.sqhstl[4] = (unsigned long )2;
    sqlstm.sqhsts[4] = (         int  )2;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)sthColasProc.iNumSegundos;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )sizeof(int);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)sthColasProc.szIndHoraDia;
    sqlstm.sqhstl[6] = (unsigned long )9;
    sqlstm.sqhsts[6] = (         int  )9;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)sthColasProc.szFecEstado;
    sqlstm.sqhstl[7] = (unsigned long )15;
    sqlstm.sqhsts[7] = (         int  )15;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)sthColasProc.szCodEstado;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )2;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
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


    igTotalColas = SQLROWS ; /* cantidad de colas de proceso recuperadas */

    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {
        ifnTrazasLog(modulo,"FETCH cur_CO_COLASPROC :%s", LOG00,SQLERRM);
        return -1;
    }

    /* EXEC SQL CLOSE cur_CO_COLASPROC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 9;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )151;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE) 
    {
        ifnTrazasLog(modulo,"CLOSE cur_CO_COLASPROC :%s", LOG00,SQLERRM);
        return -1;
    }

	for (i=0; i < igTotalColas; i++)
	{
		iFlagExist=0;
		for (j=0; stPidColas[j].szNomEjec[0]!='\0'&& j < MAX_COLASPROC; j++)
		    { 
				if(strcmp(stPidColas[j].szNomEjec,(char *) sthColasProc.szNomEjecutable[i].arr) == 0)
				{
				  iFlagExist=1;
				  break; /* Para que no siga buscando en el arreglo*/
		        }
		    }
		        
		if(!iFlagExist)
		{
			strcpy(stPidColas[j].szNomEjec,(char *) sthColasProc.szNomEjecutable[i].arr);
	        ifnTrazasLog(modulo,"SE REGISTRA COLA DE PROCESO :%s EN ARREGLO DE PID ", LOG05,stPidColas[j].szNomEjec);
	    }
	}

    return 0; 
    
}/* end ifnCargaColasDeProceso */
/* ============================================================================= */

/* ============================================================================= */
/* ifnActivaColas() : Decide que colas corresponde activar ahora y que otras no  */
/* ============================================================================= */
int ifnActivaColas()
{
    char modulo[]="ifnActivaColas";
    long lPid;
     int i,j,iFlagExist,stsCola=0;
    char szComando[1024]="",szArch[256]="", szTipIntervalo[2]="", szCola[6]="";
    BOOL ExeFlag=FALSE;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int ihDias=0,ihSegundos=0,ihEstaActivo=0;
        long lhN_Segundos=0, lhSegsDia=86400; /* cantidad de segundos que tiene un dia */
        char szhEjecAnterior[15]="",szhHoraEjec[9]="",szhAhora[9]="",szhNomEjecutable[50]="";
    /* EXEC SQL END DECLARE SECTION; */ 

 
/*-- Para todas las colas recuperadas --*/
    for ( i=0 ; i < igTotalColas ; i++ ) 
    {
        ExeFlag=FALSE;

        sprintf(szCola,"%.*s",sthColasProc.szCodProceso[i].len,sthColasProc.szCodProceso[i].arr);
        strcpy(szTipIntervalo,sthColasProc.szIndIntervalo[i]);
        strcpy(szhEjecAnterior,sthColasProc.szFecEstado[i]);
        
        /* 
           NOTA IMPORTANTE :  
           Esta validacion asume que FEC_ESTADO de la tabla CO_COLASPROC representa 
           la ultima vez que la cola se ejecutó, independiente del exito o fracaso obtenido.
           Por lo tanto asume que la operacion que define o modifica el intervalo de tiempo
           sea este segundos o una hora especifica NO MODIFICA dicha fecha en la tabla.
           
           Considerar tambien que si la cola estuvo definida con intervalo cada 'N' segundos
           y se la quiere cambiar a una Hora especifica, la primera ejecución en esta modalidad
           tendrá efecto el dia siguiente de la ultima fecha de ejecución de la cola 
           ( se puede modificar la fecha en este caso para que se ejecute hoy )
        */
        
        if (strcmp(sthColasProc.szCodEstado[i],"W")==0) /* 'Si la cola esta Wait '*/
        {      
            /*-- Verificamos la ultima ejecucion para determinar si corresponde ejecutarse en este instante --*/
            if (!strcmp(szTipIntervalo,"S")) /* si el intervalo es CADA N SEGUNDOS */
            {
               ihSegundos = sthColasProc.iNumSegundos[i];
               ifnTrazasLog(modulo,"Cola '%s' Se activa cada [%d] Segundos ", LOG07,szCola,ihSegundos);
    
               /***** mac 11.09.03 MA-0171 MA-0175   
               EXEC SQL SELECT (SYSDATE - TO_DATE(:szhEjecAnterior,'YYYYMMDDHH24MISS'))*:lhSegsDia 
                        INTO :lhN_Segundos  FROM DUAL;
               ****************/
                        
               /* EXEC SQL EXECUTE
               Begin
                  :lhN_Segundos := (SYSDATE - TO_DATE(:szhEjecAnterior,'YYYYMMDDHH24MISS'))*(:lhSegsDia);
               End;
               END-EXEC; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 9;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "begin :lhN_Segundos := ( SYSDATE -TO_DATE ( :s\
zhEjecAnterior , 'YYYYMMDDHH24MISS' ) ) * ( :lhSegsDia ) ; End ;";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )166;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&lhN_Segundos;
               sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
               sqlstm.sqhsts[0] = (         int  )0;
               sqlstm.sqindv[0] = (         short *)0;
               sqlstm.sqinds[0] = (         int  )0;
               sqlstm.sqharm[0] = (unsigned long )0;
               sqlstm.sqadto[0] = (unsigned short )0;
               sqlstm.sqtdso[0] = (unsigned short )0;
               sqlstm.sqhstv[1] = (unsigned char  *)szhEjecAnterior;
               sqlstm.sqhstl[1] = (unsigned long )15;
               sqlstm.sqhsts[1] = (         int  )0;
               sqlstm.sqindv[1] = (         short *)0;
               sqlstm.sqinds[1] = (         int  )0;
               sqlstm.sqharm[1] = (unsigned long )0;
               sqlstm.sqadto[1] = (unsigned short )0;
               sqlstm.sqtdso[1] = (unsigned short )0;
               sqlstm.sqhstv[2] = (unsigned char  *)&lhSegsDia;
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
                    ifnTrazasLog(modulo,"verificando ultima ejecucion 'S' : %s", LOG00,SQLERRM);
                	return -1;
               }
               
               if ( lhN_Segundos >= ihSegundos )  ExeFlag = TRUE;
               
               /* 
                  Si la cantidad de segundos transcurridos desde 
                  la ultima vez que se ejecutó la cola es mayor o 
                  igual a la cantidad definida, entonces marca 
                  la cola como "EJECUTABLE" 
               */
    
            }                                    
            else if (!strcmp(szTipIntervalo,"H")) /* si el intervalo es A CIERTA HORA */
            {
               strcpy(szhHoraEjec,sthColasProc.szIndHoraDia[i]);
               ifnTrazasLog(modulo,"Cola '%s' Se activa diariamente a las [%s]", LOG07,szCola,szhHoraEjec);

               /***** mac 11.09.03 MA-0171 MA-0175
               EXEC SQL SELECT TRUNC(SYSDATE) - TRUNC(TO_DATE (:szhEjecAnterior,'YYYYMMDDHH24MISS')),
                               (TO_CHAR(SYSDATE,'HH24:MI:SS'))
                        INTO :ihDias,:szhAhora FROM DUAL;
               **************/

               /* EXEC SQL EXECUTE
               Begin
                  :ihDias := TRUNC(SYSDATE) - TRUNC(TO_DATE (:szhEjecAnterior,'YYYYMMDDHH24MISS'));
		          :szhAhora :=  TO_CHAR(SYSDATE,'HH24:MI:SS');
               End;
               END-EXEC; */ 

{
               struct sqlexd sqlstm;
               sqlstm.sqlvsn = 12;
               sqlstm.arrsiz = 9;
               sqlstm.sqladtp = &sqladt;
               sqlstm.sqltdsp = &sqltds;
               sqlstm.stmt = "begin :ihDias := TRUNC ( SYSDATE ) -TRUNC ( TO\
_DATE ( :szhEjecAnterior , 'YYYYMMDDHH24MISS' ) ) ; :szhAhora := TO_CHAR ( SYS\
DATE , 'HH24:MI:SS' ) ; End ;";
               sqlstm.iters = (unsigned int  )1;
               sqlstm.offset = (unsigned int  )193;
               sqlstm.cud = sqlcud0;
               sqlstm.sqlest = (unsigned char  *)&sqlca;
               sqlstm.sqlety = (unsigned short)256;
               sqlstm.occurs = (unsigned int  )0;
               sqlstm.sqhstv[0] = (unsigned char  *)&ihDias;
               sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
               sqlstm.sqhsts[0] = (         int  )0;
               sqlstm.sqindv[0] = (         short *)0;
               sqlstm.sqinds[0] = (         int  )0;
               sqlstm.sqharm[0] = (unsigned long )0;
               sqlstm.sqadto[0] = (unsigned short )0;
               sqlstm.sqtdso[0] = (unsigned short )0;
               sqlstm.sqhstv[1] = (unsigned char  *)szhEjecAnterior;
               sqlstm.sqhstl[1] = (unsigned long )15;
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


					
    
               if (SQLCODE) 
               {
                    ifnTrazasLog(modulo,"verificando ultima ejecucion 'H' : %s", LOG00,SQLERRM);
                	return -1;
               }
                    
               if ( ihDias > 0  && strcmp(szhAhora,szhHoraEjec) >= 0 ) ExeFlag = TRUE;
               
               /* 
                  Si hoy es un dia distinto (posterior) al de la ultima vez 
                  que se ejecutó la cola (ihDias >0) y la hora actual es la 
                  misma o posterior a la hora fijada para ejecutar la cola 
                  strcmp(szhAhora,szhHoraEjec) >= 0 entonces , asumo que aun 
                  no se ha ejecutado y que se debe ejecutar, por lo tanto marca 
                  la cola como "EJECUTABLE" 
               */
               
            }                    
            else 
            {
                ifnTrazasLog(modulo,"Tipo de Intervalo '%s' No definido", LOG01,szTipIntervalo);
                return -1;
            }

            /*-- Si corresponde en este instante ejecutar la cola ---------------------------------*/
            if (ExeFlag)
            {

                /* Setea archivo al cual re-direccionara la salida standar y de errores */
                memset(szArch,0,sizeof(szArch));
                sprintf(szArch,"%s/%s",szgDirLog,szCola);
                                 
                /* Re-direcciona la salida standard a Cola.log y la salida de errores standard a Cola.err */

                if (!bfnCambiaEstadoCola(szCola,"W","L")) /*'Wait->Launched'*/
                {
                	ifnTrazasLog(modulo,"en funcion bfnCambiaEstadoCola(%s,W,L) : %s",LOG00,szCola,SQLERRM);
                    if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'W->L' : %s",LOG00,SQLERRM);
                    return -1;
                }
                else
                {    
                    if (!bfnOraCommit())    
                    {    
                        ifnTrazasLog(modulo,"En Commit 'W->L' : %s",LOG00,SQLERRM);
                        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
                        return -1;
                    }
                }
                /* Forma el comando que copia la shell RunCola a Run_<nombre_ejecutable>*/
                memset(szComando,0,sizeof(szComando));
                sprintf(szComando,"/bin/cp %s/RunCola.sh %s/Run_%.*s",
               	 											szhPathKsh,
                											szhPathKsh,
									sthColasProc.szNomEjecutable[i].len,
								 	sthColasProc.szNomEjecutable[i].arr);
                stsCola=WEXITSTATUS(system(szComando));
                if(stsCola){
                   ifnTrazasLog(modulo,"\nNo pudo copiar shell RunCola \n", LOG01);
				}
			
                /*-- Forma el Comando que se ejecutara en modo nohup --*/
                free(szComando);
                memset(szComando,0,sizeof(szComando));
                sprintf(szComando,"nohup Run_%.*s %.*s "
                                  "-l%d -u/ -n%s "
                                  ">>%s.log 2>>%s.err &",
								   sthColasProc.szNomEjecutable[i].len
								  ,sthColasProc.szNomEjecutable[i].arr                                   
								  ,sthColasProc.szNomEjecutable[i].len
								  ,sthColasProc.szNomEjecutable[i].arr
                                  ,sthColasProc.iIndNivLog[i], szCola
                                  ,szArch, szArch ); 
                stsCola=WEXITSTATUS(system(szComando)); /*  Lanza efectivamente la cola */
                if(stsCola)
                {
                   ifnTrazasLog(modulo,"\nNo PUDO Lanzar efectivamente la cola \n", LOG01);
				}
				ifnTrazasLog(modulo,"Comando ejecuta: %s",LOG06,szComando);
   				/* Obtiene el PID de la cola y lo deja en un archivo */
   				free( szComando );
                memset(szComando,0,sizeof(szComando));
                sprintf(szComando,"ps -fe |grep Run_%.*s|awk '{if($3 == 1) print $2}' > %s/PID_COLASRUN.DAT",
                				   sthColasProc.szNomEjecutable[i].len,
                                   sthColasProc.szNomEjecutable[i].arr,
                                   szhPathKsh);
				ifnTrazasLog(modulo,"Comando que busca PID : %s",LOG05,szComando);								  
                stsCola=WEXITSTATUS(system(szComando));
                if(stsCola)
                {
                   ifnTrazasLog(modulo,"\nNo pudo obtener PID despues de ejecutar shell\n", LOG01);
				}
                /* Lee el PID desde el archivo */
                free( szComando );
				lPid=lfnLeePID();
				ifnTrazasLog(modulo,"\nPID:[%ld] COLA :[%s] EN WAIT  \n", LOG03, lPid,sthColasProc.szNomEjecutable[i].arr);
                if(!lPid) 
                   ifnTrazasLog(modulo,"\nNo pudo obtener PID Run_%s (WAIT)\n", LOG03,sthColasProc.szNomEjecutable[i].arr);
				/* Busca en el arreglo stPidColas la cola correspondiente para asignarle el PID */
				iFlagExist=0;
				for (j=0; stPidColas[j].szNomEjec[0]!='\0'&& j < MAX_COLASPROC; j++)
				{ 
					 if(!strcmp((char*) sthColasProc.szNomEjecutable[i].arr,stPidColas[j].szNomEjec))
					 {
					   iFlagExist=1;
					   break; /* Para que no siga buscando en el arreglo*/
					 }
 				}    
				if(iFlagExist)
				{
				  stPidColas[j].lPidProceso=lPid;
				  ifnTrazasLog(modulo,"NUEVO PID:[%d] de la COLA:[%s]\n", LOG03,stPidColas[j].lPidProceso,stPidColas[j].szNomEjec);
				}  
            } /* endif ExeFlag */
        } 

        if (strcmp(sthColasProc.szCodEstado[i],"L")==0)  /* 'Si la cola esta Launched '*/
        {
            /***** mac 11.09.03 MA-0171 MA-0175
            EXEC SQL SELECT (SYSDATE - TO_DATE(:szhEjecAnterior,'YYYYMMDDHH24MISS'))*:lhSegsDia 
                    INTO :lhN_Segundos  FROM DUAL;
            **************/
                           
            /* EXEC SQL EXECUTE
            Begin
               :lhN_Segundos := (SYSDATE - TO_DATE(:szhEjecAnterior,'YYYYMMDDHH24MISS'))*(:lhSegsDia);
            End;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 9;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin :lhN_Segundos := ( SYSDATE -TO_DATE ( :szhE\
jecAnterior , 'YYYYMMDDHH24MISS' ) ) * ( :lhSegsDia ) ; End ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )220;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhN_Segundos;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhEjecAnterior;
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhSegsDia;
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
                ifnTrazasLog(modulo,"verificando ultimo lanzamiento : %s", LOG00,SQLERRM);
				return -1;
            }
            
            if ( lhN_Segundos > MAXSEGSLAUNCHED )  /* definir MAXSEGSLAUNCHED */
            {
 				iFlagExist=0;
				for (j=0; stPidColas[j].szNomEjec[0]!='\0'&& j < MAX_COLASPROC; j++)
				{ 
					if(!strcmp((char *) sthColasProc.szNomEjecutable[i].arr,stPidColas[j].szNomEjec))
					{
						iFlagExist=1;
						break; /* Para que no siga buscando en el arreglo*/
					}
				}
				free( szComando );
                memset(szComando,0,sizeof(szComando));
                sprintf(szComando,"ps -fe |grep Run_%.*s|awk '{if($3 == 1) print $2}' > %s/PID_COLASRUN.DAT",
                				   sthColasProc.szNomEjecutable[i].len,
                                   sthColasProc.szNomEjecutable[i].arr,
                                   szhPathKsh);
                stsCola=WEXITSTATUS(system(szComando));
                if(stsCola)
                {
                   ifnTrazasLog(modulo,"\nNo pudo obtener PID despues de ejecutar shell(LUNCH)\n", LOG01);
				}
                free( szComando );
                lPid=lfnLeePID();
                ifnTrazasLog(modulo,"\nPID:[%ld] EN LUNCH  \n",LOG05,lPid );
                if(lPid > 0 && stPidColas[j].lPidProceso ==lPid)
                {
                 ifnTrazasLog(modulo,"\nProceso Continua Activo \n", LOG05);
				}
				else
				{
	                if (!bfnCambiaEstadoCola(szCola,"L","W")) /*'Launched->Wait'*/
	                {
                		ifnTrazasLog(modulo,"La Cola '%s' ha estado 'L' mas de %d segundos. Y el PID no existe\n",LOG03,szCola,MAXSEGSLAUNCHED);
	                	ifnTrazasLog(modulo,"en funcion bfnCambiaEstadoCola(%s,L,W) : %s",LOG00,szCola,SQLERRM);
	                    if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'L->W' : %s",LOG00,SQLERRM);
						return -1;
	                }
	                else
	                {    
	                    if (!bfnOraCommit())    
	                    {    
	                        ifnTrazasLog(modulo,"En Commit 'L->W' : %s",LOG00,SQLERRM);
	                        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
							return -1;
	                    }
	                }
	            }    
            }
        }
        
        if (strcmp(sthColasProc.szCodEstado[i],"R")==0 ) /* Si estan Running jlr_02.01.01 */
        {
            sprintf(szhNomEjecutable,"%.*s%%", sthColasProc.szNomEjecutable[i].len, sthColasProc.szNomEjecutable[i].arr);

			iFlagExist=0;
			for (j=0; stPidColas[j].szNomEjec[0]!='\0'&& j < MAX_COLASPROC; j++)
			{ 
				if(!strcmp((char *)sthColasProc.szNomEjecutable[i].arr,stPidColas[j].szNomEjec))
				{
					iFlagExist=1;
					break; /* Para que no siga buscando en el arreglo*/
				}
			}
			free( szComando );
            memset(szComando,0,sizeof(szComando));
            sprintf(szComando,"ps -fe |grep Run_%.*s|awk '{if($3 == 1) print $2}' > %s/PID_COLASRUN.DAT",
            				   sthColasProc.szNomEjecutable[i].len,
                               sthColasProc.szNomEjecutable[i].arr,
                               szhPathKsh);
            stsCola=WEXITSTATUS(system(szComando));
            if(stsCola)
            {
               ifnTrazasLog(modulo,"\nNo pudo obtener PID despues de ejecutar shell(RUN)\n", LOG01);
			}
            free( szComando );
            lPid=lfnLeePID();
            ifnTrazasLog(modulo,"\nPID:[%ld] COLA :[%s] EN RUN  \n", LOG05, lPid, stPidColas[j].szNomEjec);
            if(lPid > 0 && stPidColas[j].lPidProceso ==lPid)
            {
             ifnTrazasLog(modulo,"\nProceso Continua Activo \n", LOG05);
			}
            else
            {
                ifnTrazasLog(modulo,"La Cola '%s' esta 'R' pero no existe el proceso asociado. Retorna a 'W'",LOG01,szhNomEjecutable);
            
                if (!bfnCambiaEstadoCola(szCola,"R","W")) /*'Running->Wait'*/
                {
                	ifnTrazasLog(modulo,"en funcion bfnCambiaEstadoCola(%s,R,W) : %s",LOG00,szCola,SQLERRM);
                    if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'R->W' : %s",LOG00,SQLERRM);
					return -1;
                }
                else
                {    
                    if (!bfnOraCommit())    
                    {    
                        ifnTrazasLog(modulo,"En Commit 'R->W' : %s",LOG00,SQLERRM);
                        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
						return -1;
                    }
                }
            }
        }
    } /* endfor */
    
    ifnTrazasLog(modulo,"No hay mas colas que activar", LOG05);
    return 0;

}/* end ifnActivaColas */
/* ============================================================================= */
/* ============================================================================= */
/* lfnLeePID() : Lee desde un archivo el PID del Run_<cola> ejecutado 			 */
/* ============================================================================= */
long lfnLeePID()
{
    char modulo[]="lfnLeePID";
    long lPidLeido=0;
    int  iStsArch=0;
    char szArchivos[100], szPidLeido[20], szTest[200];
    FILE	*fpArchivos = (FILE*) NULL;
    
    
	memset( szArchivos, '\0', sizeof( szArchivos ) );
	sprintf( szArchivos, "%s/PID_COLASRUN.DAT", szhPathKsh );
	sprintf( szTest," test -s %s ",szArchivos);
	iStsArch=WEXITSTATUS(system(szTest));
	if(!iStsArch)
	{	if( ( fpArchivos = fopen( szArchivos, "r" ) ) == (FILE*)NULL )
		{    
		    ifnTrazasLog( modulo, "Error al abrir Archivo [%s].", LOG03, szArchivos );  
		    return 0;  
		}
		
		/* recuperamos Pid */
		
		while( fscanf( fpArchivos, "%s", szPidLeido ) != EOF )
		{
			lPidLeido=atol(szPidLeido);
		} /* while( 1 ) */  
		ifnTrazasLog( modulo, "PID recuperado [%d](desde archivo).", LOG05, lPidLeido );  
		fclose( fpArchivos );
		free ( fpArchivos );
	}
    return lPidLeido;
}/* end lfnLeePID */
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

