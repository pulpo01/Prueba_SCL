
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
           char  filnam[27];
};
static const struct sqlcxp sqlfpn =
{
    26,
    "./pc/AsignacionCourrier.pc"
};


static unsigned int sqlctx = 762573285;


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
   unsigned char  *sqhstv[4];
   unsigned long  sqhstl[4];
            int   sqhsts[4];
            short *sqindv[4];
            int   sqinds[4];
   unsigned long  sqharm[4];
   unsigned long  *sqharc[4];
   unsigned short  sqadto[4];
   unsigned short  sqtdso[4];
} sqlstm = {12,4};

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
5,0,0,1,136,0,4,518,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
32,0,0,2,0,0,17,637,0,0,1,1,0,1,0,1,97,0,0,
51,0,0,2,0,0,45,659,0,0,1,1,0,1,0,1,5,0,0,
70,0,0,2,0,0,13,706,0,0,4,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
101,0,0,2,0,0,15,756,0,0,0,0,0,1,0,
116,0,0,3,119,0,4,871,0,0,4,3,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
147,0,0,2,0,0,17,937,0,0,1,1,0,1,0,1,97,0,0,
166,0,0,2,0,0,45,959,0,0,0,0,0,1,0,
181,0,0,2,0,0,13,982,0,0,1,0,0,1,0,2,5,0,0,
200,0,0,2,0,0,15,1005,0,0,0,0,0,1,0,
215,0,0,4,62,0,5,1037,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
238,0,0,5,85,0,5,1072,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
261,0,0,6,76,0,4,1177,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
284,0,0,2,0,0,17,1267,0,0,1,1,0,1,0,1,97,0,0,
303,0,0,2,0,0,45,1289,0,0,1,1,0,1,0,1,5,0,0,
322,0,0,2,0,0,13,1334,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
345,0,0,2,0,0,15,1378,0,0,0,0,0,1,0,
};


/****************************************************************************/
/* Fichero    : AsignacionCourrier.pc                                       */
/* Descripcion: Programa Proncipal                                          */
/* Fecha      : 16-06-2009                                                  */
/* Autor      : Jorge Hernan Toro Omar                                      */
/****************************************************************************/

#define _ASIGNACIONCOURRIER_C_

#include "AsignacionCourrier.h"

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char    szUsuarioPasswd[80]   ="";	
/* EXEC SQL END DECLARE SECTION; */ 


int  igLogLevel;

/* iPROC_ASIGNACIONCOURRIER = 4500 */

/****************************************************************************/
/*  FUNCION     : bfnCargaDatosGenerales()                                  */
/*  DESCRIPCION : Obtiene Datos Generales una sola vez		            */
/****************************************************************************/
int main ( int argc, char *argv[])
{
    char modulo[]="main";

    long lCodCicloFact;
    char szOraAccount[32];
    char szOraPasswd[32];

    PARAMETROSENTRADA 	stParametrosIn;

    /*** Inicializacion de Variables ***/
    igLogLevel = 3;
    memset(szOraAccount,'\0',sizeof(szOraAccount));
    memset(szOraPasswd,'\0',sizeof(szOraPasswd));

    fprintf(stderr,"\n  Asignación Courrier versión " __DATE__ " " __TIME__ " TMG\n");
    
    memset(&stParametrosIn,0,sizeof(PARAMETROSENTRADA));
    
    /*** Validación de Parámetros Ingresados ***/ 
    if (!bfnValidaParametrosIn (argc, argv, szOraAccount, szOraPasswd, &stParametrosIn, &igLogLevel)) 
    {
	 return (ERROR_PARAMETROS);
    }

    /* Obtencion de usuario/password como cadena conjunta */
    sprintf(szUsuarioPasswd,"%s/%s", szOraAccount, szOraPasswd);

    /*** Apertura de Archivos LOG ***/ 
    if (!bfnAbreArchivosLog(igLogLevel))
    {
	 return (ERROR_ARCHIVOSLOG);
    }		
		
    vDTrazasLog  (modulo, "\n Asignación Courrier versión " __DATE__ " " __TIME__ " TMG\n",LOG03);

    if (!ifnAcessoOracle(szOraAccount,szOraPasswd))
    {
	 return (ERROR_ACCESSORA);
    }

    vDTrazasLog  (modulo, "\n\t**  Parametros de Entrada : Asignación Courrier ***",LOG03); 
    vDTrazasLog  (modulo, "\t\t=> Cod. Ciclo Fact  [%ld]",LOG03, stParametrosIn.lCodCicloFact); 
	
    /*** Se Obtiene el Ciclo de Facturacion ***/
    if(!bfnGetCicloFact(&stParametrosIn))
    {
        vDTrazasError(modulo," Error, en bfnGetCicloFact\n", LOG01);
        vDTrazasLog  (modulo," Error, en bfnGetCicloFact\n", LOG01);
        return FALSE;
    }

    /*** Se inicaliza el Proceso de Traza de Procesos ***/
    if (!bfnAsignacionCourrier(&stParametrosIn))
    {
         vDTrazasError(modulo, " \n------------------------------------"
                               " \nProceso Terminado de Forma Irregular"
                               " \n------------------------------------"
                               ,LOG03);
         vDTrazasLog  (modulo, " \n------------------------------------"
                               " \nProceso Terminado de Forma Irregular"
                               " \n------------------------------------"
                               ,LOG03);
    } 
    else
    {
         vDTrazasError(modulo, " \n------------------------------------"
                               " \nProceso Terminado de Forma Regular"
                               " \n------------------------------------"
                               ,LOG03);
         vDTrazasLog  (modulo, " \n------------------------------------"
                               " \nProceso Terminado de Forma Regular"
                               " \n------------------------------------"
                               ,LOG03);
    }

    if ( bfnDisconnectORA(0))
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
    
    fprintf(stderr,"\n  Termino del Proceso Asignación Courrier %s\n",cfnGetTime(1));   
    
    return 0;

} /*** Fin main() ***/

/***************************  Fin  Bloque Principal  ***************************/

/* ******************************************************************************** */
/* FUNCION     : bfnValidaParametrosIn                                              */
/* DESCRIPCION : verifica los parametros de la invocacion                           */
/* ******************************************************************************** */
BOOL bfnValidaParametrosIn (int               argc,
                            char              *argv[],
                            char              *szOraAccount ,
                            char              *szOraPasswd,
			    PARAMETROSENTRADA *stParametrosIn,
                            int               *igLogLevel)
{
    char        modulo[]="bfnValidaParametrosIn";
    extern char *optarg;
    extern int  opterr, optopt;
    char        opt[] = "u:c:l:i:f:";
    int         iOpt=0;
    char        *psztmp = "";
    char        szUser[64];

    BOOL bUserFlag     = FALSE;
    BOOL bCodCicloFlag = FALSE;
    BOOL bLogFlag      = FALSE;
    BOOL bClieIniFlag  = FALSE;
    BOOL bClieFinFlag  = FALSE;        

    memset(szUser,'\0',sizeof(szUser));
    opterr=0;

    if(argc == 1)
    {
        fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
        return (FALSE);
    }

    while ( (iOpt = getopt(argc, argv , opt) ) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                if(bUserFlag==FALSE)
                {
                    strcpy(szUser, optarg);
                    bUserFlag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'c':
                if(bCodCicloFlag==FALSE)
                {
                    stParametrosIn->lCodCicloFact=atol(optarg);
                    bCodCicloFlag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;

            case 'l':
                if(bLogFlag==FALSE)
                {
                    *igLogLevel=atoi(optarg);
                    bLogFlag=TRUE;
                }
                else
                {
                    fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
                    return (FALSE);
                }
                break;
                
            case 'i':
                stParametrosIn->lCodClienteIni = atol(optarg);
                bClieIniFlag = TRUE;
                break;

            case 'f':
                stParametrosIn->lCodClienteFin = atol(optarg);
                bClieFinFlag = TRUE;
                break;                

            case '?':
                fprintf(stdout,"\n\t<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
                return (FALSE);

            case ':':
                fprintf(stdout,"\n\t<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
                return (FALSE);
        }/* endswitch */
    } /* enwhile */

    if ( bUserFlag==TRUE )
    {
        if ( (psztmp=(char *)strstr(szUser,"/") )==(char *)NULL )
        {
            fprintf (stderr,"\n\t<< Error : usuario no valido. Requiere \"/\" >>\n%s\n",szUsage);
            return (FALSE);
        }
        else
        {
            strncpy (szOraAccount,szUser,psztmp-szUser);
            strcpy  (szOraPasswd, psztmp+1);
        }
    }

    if ( bCodCicloFlag==FALSE )
    {
       fprintf (stderr,"\n\t<< Error : falta opcion '-c' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if(bLogFlag==FALSE)
    {
        fprintf (stderr,"\n\t<< Error : falta opcion '-l' >>\n%s\n",szUsage);
        return (FALSE);
    }
    
    if ((bClieIniFlag==FALSE) && (bClieFinFlag==FALSE))
    {
    	stParametrosIn->bRngClientes = FALSE;
    }
    else
    {
        if(((bClieIniFlag==TRUE) && (bClieFinFlag==FALSE)) ||
	   ((bClieIniFlag==FALSE) && (bClieFinFlag==TRUE)))
        {
             fprintf (stderr,"\n\t<< Error : Rango de Clientes Invalido, debe indicar Cliente Inicial y Clinte Final >>\n%s\n"
                            , szUsage);
             return (FALSE);
        }
    }

    if((bClieIniFlag==TRUE) && (bClieFinFlag==TRUE))
    {
	 stParametrosIn->bRngClientes = TRUE;    
    }

    return (TRUE); /* Validacion ok */

} /******************************  Fin  bfnValidaParametros  *****************************/

/* ************************************************************************************* */
/* FUNCION     : bfnAbreArchivosLog                                                      */
/* DESCRIPCION : Abre Archivos de LOG y ERRORES                                          */
/* ************************************************************************************* */
BOOL bfnAbreArchivosLog(int igLogLevel)
{
    char modulo[]   ="bfnAbreArchivosLog";
    char *pathDir       ;
    char szArchivo  [52];
    char szPath    [128];
    char szComando [128];

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"AsignacionCourrier_%s",cfnGetTime(5));

    pathDir=(char *)malloc(128);
    pathDir=szGetEnv("XPF_LOG");
    memset(szPath,'\0',sizeof(szPath));
    sprintf(szPath,"%s/AsignacionCourrier",pathDir);
    free(pathDir);

    fprintf( stdout, "\n\tCrea Directorio Log  : %s\n", szPath);
    memset(szComando,'\0',sizeof(szComando));
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf( stdout, "\n\tCrea Archivo Log/Err : %s\n\n", szArchivo);

    stStatus.LogNivel = igLogLevel;

    sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
    if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
    {
        fprintf( stderr, "\n\t<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return (FALSE);
    }

    vDTrazasError(modulo, "%s << Abre Archivo de Errores >>", LOG03, cfnGetTime(1));

    sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
    if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
    {
        fprintf(stderr, "\n\t<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, " << No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return (FALSE);
    }

    vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG03, cfnGetTime(1));

    return (TRUE);

} /****************************    Fin bfnAbreArchivosLog   ******************************/

/* ******************************************************************************** */
/* FUNCION     : ifnAcessoOracle                                                    */
/* DESCRIPCION : Se conecta y trabaja sobre la base de Datos                        */
/* ******************************************************************************** */
BOOL ifnAcessoOracle(char    *szOraAccount,
                     char    *szOraPasswd)
{
    char    modulo[]="ifnAcessoOracle";
    char    szUsuario[64];
    char    szAux[16];
    char    *psztmp = "";
    char    szhNomUsuarOra[32];
    char    szhPasUsuarOra[32];

    memset(szhNomUsuarOra,'\0',sizeof(szhNomUsuarOra));
    strcpy(szhNomUsuarOra,szOraAccount);
    memset(szhPasUsuarOra,'\0',sizeof(szhPasUsuarOra));
    strcpy(szhPasUsuarOra,szOraPasswd);

    /*  Formateo adecuado del Usuario/Password recuperado de la base */
    memset(szUsuario,'\0',sizeof(szUsuario));

    if ( (psztmp=(char *)strstr(szhNomUsuarOra,"\\$") )!=(char *)NULL )
    {
        sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
    }
    else if ((psztmp=(char *)strchr(szhNomUsuarOra,'$') )!=(char *)NULL )
    {
        memset(szAux,'\0',sizeof(szAux));
        strncpy (szAux,szhNomUsuarOra,psztmp-szhNomUsuarOra);
        sprintf (szUsuario,"%s\\%s/%s",szAux,psztmp,szhPasUsuarOra);
    }
    else
    {
        sprintf(szUsuario,"%s/%s",szhNomUsuarOra,szhPasUsuarOra);
    }

    if (!fnOraConnect(szOraAccount,szOraPasswd))
    {
        vDTrazasError(modulo, " No Hay Conexion a la Base de Datos", LOG01);
        return (FALSE);
    }

    vDTrazasLog(modulo,"%s Conectado a la Base de Datos", LOG03, cfnGetTime(1));

    return (TRUE);

} /*********************************  Fin  ifnAcessoOracle *******************************/

/* ******************************************************************************** */
/* FUNCION     : bfnAsignacionCourrier                                              */
/* DESCRIPCION : Función de llamadas principales                                    */
/* ******************************************************************************** */
int bfnAsignacionCourrier (PARAMETROSENTRADA *stParametrosIn)
{
    char  modulo[]="bfnAsignacionCourrier";

    int   iSqlCodeInt    = SQLOK;	
    long  lCodCicloFact         ;
    char  szFecha           [15];
    BOOL  bRptFnc           = TRUE;
    int   iInd              = iINI_INDICE;
    int   iCountClientes    = iINI_COUNTCLIENTES;
    int   iIndEsp           = iINI_INDICE;
    int   iCountClientesEsp = iINI_COUNTCLIENTES;    

     memset(szFecha,'\0',sizeof(szFecha));

    /*** Validacion de TRaza de Proceso ***/
    if (!bfnValidaTrazaProc(stParametrosIn->lCodCicloFact, 
                            iPROC_ASIGNACIONCOURRIER, 
                            iIND_FACT_ENPROCESO))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnValidaTrazaProc", LOG01);
        return (FALSE);
    }

    bfnSelectTrazaProc ( stParametrosIn->lCodCicloFact, iPROC_ASIGNACIONCOURRIER, &stTrazaProc);

    bPrintTrazaProc(stTrazaProc);
    
    vDTrazasLog  (modulo, "\n\n\t** INICIO PROCESO CLIENTES COURRIER **\n"
                          "\t======================================\n"
                        , LOG03);

    /*** Carga Clientes a procesar ****/
    if( ifnOpenClientesCourrier(stParametrosIn) == SQLOK )
    { 
    	if( ifnFetchClientesCourrier(&iInd, &iCountClientes) == SQLOK )
    	{    		
    	    if ( !bfnCloseClientesCourrier())
    	    {     return (FALSE); }  
    	}
    	else
    	{   return (FALSE); }
    }
    else
    {  	return (FALSE); }

    /* Proceso Asignación Cód. Courrier a Clientes */
    bRptFnc = bfnProcesaClientesCourrier(iInd, iCountClientes);

    if (!bfnSelectSysDate(szFecha))
    {
        return FALSE;
    }

    if (!bRptFnc)
    {
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Asignación/Clientes Especiales con Error");
    }
    else 
    {
        vDTrazasLog  (modulo, "\n\n\t** INICIO PROCESO CLIENTES ESPECIALES COURRIER **\n"
                              "\t=================================================\n"
                            , LOG03);    	
        /*** Carga Clientes Especiales a procesar ****/
        if( ifnOpenClientesEspeciales(stParametrosIn) == SQLOK )
        { 
    	    if( ifnFetchClientesEspeciales(&iIndEsp, &iCountClientesEsp) == SQLOK )
    	    {    		
    	        if ( !bfnCloseClientesEspeciales())
    	        {     return (FALSE); }  
    	    }
    	    else
    	        {   return (FALSE); }
        }
        else
           {  	return (FALSE); }    	
    	
    	/* Proceso Asignación Cód. Courrier Clientes Especiales */
        bRptFnc = bfnProcesaClientesEspeciales(iIndEsp, iCountClientesEsp);
    	
    	if (!bRptFnc)
    	{
            stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
            strcpy(stTrazaProc.szFecTermino,szFecha);
            strcpy(stTrazaProc.szGlsProceso,"Proceso Asignación/Clientes Especiales con Error");    		
    	}
    	else
    	{
            stTrazaProc.iCodEstaProc = iPROC_EST_OK;
            strcpy(stTrazaProc.szFecTermino,szFecha);
            strcpy(stTrazaProc.szGlsProceso,"Proceso Asignación/Clientes Especiales OK");
        }
    }

    bPrintTrazaProc(stTrazaProc);

    if(!bfnUpdateTrazaProc(stTrazaProc))
    {
        return (FALSE);
    }

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnUpdateTrazaProc", LOG01);
        return FALSE;
    }

    return (TRUE);

} /******************************  Fin  bfnAsignacionCourrier ***************************/

/****************************************************************************/
/*  FUNCION     : bfnGetCicloFact()                                         */
/*  DESCRIPCION : Obtiene Ciclo de Facturacion   		            */
/****************************************************************************/
BOOL bfnGetCicloFact (PARAMETROSENTRADA *stParametrosIn)
{
    char modulo[]   = "bfnGetCicloFact";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 long lhCodCiclFact  = stParametrosIn->lCodCicloFact;
	 int  ihCodCiclo;
	 char szhFecEmision [10+1]; /* EXEC SQL VAR szhFecEmision    IS STRING(10+1) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhFecEmision,'\0',sizeof(szhFecEmision));

    vDTrazasLog (modulo,"\n\t** Parametros Entrada a bfnGetCicloFact\n"
			"\t\t=> Cod.CiclFact [%ld]\n",
			LOG05, 
			stParametrosIn->lCodCicloFact);

    /* EXEC SQL
	 SELECT COD_CICLO, TO_CHAR(TRUNC(FEC_EMISION),'DD-MM-YYYY')
	 INTO   :ihCodCiclo, :szhFecEmision
	 FROM   FA_CICLFACT
	 WHERE  COD_CICLFACT  = :lhCodCiclFact
	 AND    IND_FACTURACION < 2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,TO_CHAR(TRUNC(FEC_EMISION),'DD-MM-YYYY'\
) into :b0,:b1  from FA_CICLFACT where (COD_CICLFACT=:b2 and IND_FACTURACION<2\
)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
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



    if (SQLCODE != SQLOK)
    {
	iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_CiclFact",szfnORAerror());
	return (FALSE);
    }

    stParametrosIn->iCodCiclo = ihCodCiclo;
    strcpy(stParametrosIn->szFecEmision,szhFecEmision);
    
    return (TRUE);
}/******************** Fin bfnGetCicloFact *********************/

/****************************************************************************/
/*  FUNCION     : ifnOpenClientesCourrier()                                 */
/*  DESCRIPCION : Abre cursor Clientes          		            */
/****************************************************************************/
int ifnOpenClientesCourrier(PARAMETROSENTRADA *stParamIn)
{
    char modulo[]   = "ifnOpenClientesCourrier";

    static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCicloFact  = stParamIn->lCodCicloFact;
         int  ihCodCiclo      = stParamIn->iCodCiclo;
         long lhCodClienteIni ;
         long lhCodClienteFin ;
	 char szhFecEmision [10+1]; /* EXEC SQL VAR szhFecEmision    IS STRING(10+1) ; */ 
         
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo, "\n\t** Parametros entrada a ifnOpenClientesCourrier\n"
			  "\t\t=> Cod_CiclFact   [%ld]\n"
			  "\t\t=> Cod Ciclo      [%d]\n"
			  "\t\t=> Fec Emision    [%s]\n"
			, LOG03
			, stParamIn->lCodCicloFact
			, stParamIn->iCodCiclo
			, stParamIn->szFecEmision);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    
    memset(szhFecEmision,0,sizeof(szhFecEmision));
    
    strcpy(szhFecEmision,stParamIn->szFecEmision);    
       
    if (stParamIn->bRngClientes)
    { 	
    	/* Con Rango de Clientes */
        lhCodClienteIni = stParamIn->lCodClienteIni;
        lhCodClienteFin = stParamIn->lCodClienteFin;    	        

        vDTrazasLog ( modulo, "\n\t** Con Rango de Clientes : Cliente Inicial [%ld] **\n"
                              "  \t**                         Cliente Final   [%ld] **\n"
                            , LOG05
                            , lhCodClienteIni
                            , lhCodClienteFin);   
        
        sprintf(szCadenaSQL, " SELECT\n"
		         "\t  DISTINCT CLI.COD_CLIENTE,\n"
		         "\t  NVL(DIRE.COD_CIUDAD,' '),\n"
		         "\t  NVL(DIRE.COD_PROVINCIA,' '),\n"
		         "\t  NVL(DIRE.COD_REGION,' ')\n"
		         "\t FROM \n"
		         "\t  FA_CICLOCLI CLI,\n"
		         "\t  GA_DIRECCLI DIR,\n"
		         "\t  GE_DIRECCIONES DIRE,\n"		        
		         "\t  FA_CLIENTESCOURRIER COU\n"		         
		         "\t WHERE\n"
		         "\t     CLI.COD_CICLO = %d\n"
		         "\t AND CLI.COD_CLIENTE = DIR.COD_CLIENTE\n"
		         "\t AND DIR.COD_TIPDIRECCION = %d\n"
		         "\t AND DIR.COD_DIRECCION = DIRE.COD_DIRECCION\n"
		         "\t AND CLI.COD_CLIENTE   = COU.COD_CLIENTE(+)\n"
		         "\t AND NVL(COU.FEC_VIGENCIA,TO_DATE('01011900','DDMMYYYY')) < TO_DATE(:szhFecEmision,'DD-MM-YYYY')\n"
		         "\t AND CLI.COD_CLIENTE >= %ld\n"
		         "\t AND CLI.COD_CLIENTE <= %ld\n"
		       , ihCodCiclo
		       , iTIPODIRECCION
		       , lhCodClienteIni
		       , lhCodClienteFin);
    }
    else
    {
        vDTrazasLog ( modulo, "\n\t** Sin Rango de Clientes **\n"
                            , LOG05);    	
    	/* Sin Rango de Clientes */
        sprintf(szCadenaSQL, " SELECT\n"
		         "\t  DISTINCT CLI.COD_CLIENTE,\n"
		         "\t  NVL(DIRE.COD_CIUDAD,' '),\n"
		         "\t  NVL(DIRE.COD_PROVINCIA,' '),\n"
		         "\t  NVL(DIRE.COD_REGION,' ')\n"
		         "\t FROM \n"
		         "\t  FA_CICLOCLI CLI,\n"
		         "\t  GA_DIRECCLI DIR,\n"
		         "\t  GE_DIRECCIONES DIRE,\n"		        
		         "\t  FA_CLIENTESCOURRIER COU\n"
		         "\t WHERE\n"
		         "\t     CLI.COD_CICLO = %d\n"
		         "\t AND CLI.COD_CLIENTE = DIR.COD_CLIENTE\n"
		         "\t AND DIR.COD_TIPDIRECCION = %d\n"
		         "\t AND DIR.COD_DIRECCION = DIRE.COD_DIRECCION\n"
		         "\t AND CLI.COD_CLIENTE   = COU.COD_CLIENTE(+)\n"		         
		         "\t AND NVL(COU.FEC_VIGENCIA,TO_DATE('01011900','DDMMYYYY')) < TO_DATE(:szhFecEmision,'DD-MM-YYYY')\n"		         
		       , ihCodCiclo
		       , iTIPODIRECCION);    	
    }

    /*** FIN Declara Cursor ***/

    vDTrazasLog ( modulo,"\n\t** Query for cCursor_Clientes_Courrier \n\t [%s]\n"
                        ,LOG05, alltrim(szCadenaSQL));

    /* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )32;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
	vDTrazasError  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL DECLARE cCursor_Clientes_Courrier CURSOR FOR stQueryDinamica; */ 


    if (SQLCODE) 
    {
	vDTrazasError  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_Courrier >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_Courrier >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL OPEN cCursor_Clientes_Courrier USING :szhFecEmision; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )51;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    if(SQLCODE == SQLNOTFOUND)
    {
       vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Clientes_Courrier **",LOG01);
       vDTrazasError(modulo," ** No Existen Datos en cCursor_Clientes_Courrier **",LOG01);
       return (SQLCODE);
    }
    
    if(SQLCODE != SQLOK)
    {
       vDTrazasError(modulo, " en Open cCursor_Clientes_Courrier **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
       vDTrazasLog  (modulo, " en Open cCursor_Clientes_Courrier **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    return (SQLOK);

}/******************** Fin ifnOpenClientesCourrier ********************/

/****************************************************************************/
/*  FUNCION     : ifnFetchClientesCourrier()                                */
/*  DESCRIPCION : Fetch Clientes            		                    */
/****************************************************************************/
int ifnFetchClientesCourrier( int *iInd,
			      int *iCountClientes)
{
    char modulo[]   = "ifnFetchClientesCourrier";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 long    lhCodCliente;
	 char    szhCodCiudad    [5+1]; /* EXEC SQL VAR szhCodCiudad    IS STRING(5+1) ; */ 

	 char    szhCodProvincia [5+1]; /* EXEC SQL VAR szhCodProvincia IS STRING(5+1) ; */ 

	 char    szhCodRegion    [5+1]; /* EXEC SQL VAR szhCodRegion    IS STRING(3+1) ; */ 
	 
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t** Parametros entrada a ifnFetchClientesCourrier\n"
			 "\t\t=> CountClientes [%d]\n"
			 "\t\t=> Ind registro  [%d]\n",
			 LOG03,
			 *iCountClientes,
			 *iInd);					 

    while (SQLCODE == SQLOK)
    {
           /* EXEC SQL 
                FETCH cCursor_Clientes_Courrier
                INTO  :lhCodCliente,
                      :szhCodCiudad,
                      :szhCodProvincia,
                      :szhCodRegion; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 4;
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
           sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
           sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[0] = (         int  )0;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)szhCodCiudad;
           sqlstm.sqhstl[1] = (unsigned long )6;
           sqlstm.sqhsts[1] = (         int  )0;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)szhCodProvincia;
           sqlstm.sqhstl[2] = (unsigned long )6;
           sqlstm.sqhsts[2] = (         int  )0;
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqinds[2] = (         int  )0;
           sqlstm.sqharm[2] = (unsigned long )0;
           sqlstm.sqadto[2] = (unsigned short )0;
           sqlstm.sqtdso[2] = (unsigned short )0;
           sqlstm.sqhstv[3] = (unsigned char  *)szhCodRegion;
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



           if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
           {
               vDTrazasError(modulo," en Fetch Cursor cCursor_Clientes_Courrier %s ",LOG01,SQLERRM);
               vDTrazasLog  (modulo," en Fetch Cursor cCursor_Clientes_Courrier %s ",LOG01,SQLERRM);
           }

           if( SQLCODE == SQLOK )
	   {
   	       (*iCountClientes)++; 
	       memset(&stClientesInd[*iCountClientes],0,sizeof(CLIENTESIND));       
	       stClientesInd[*iCountClientes].lCodCliente   = lhCodCliente;
               strcpy(stClientesInd[*iCountClientes].szCodCiudad , szhCodCiudad);
	       strcpy(stClientesInd[*iCountClientes].szCodProvincia , szhCodProvincia);
	       strcpy(stClientesInd[*iCountClientes].szCodRegion , szhCodRegion);
	       stClientesInd[*iCountClientes].iIndFin       = *iInd;

	       (*iInd)++;
	   }
       

    } /*** Fin del While ***/
 
    if ( SQLCODE == SQLNOTFOUND)
    {
         vDTrazasLog  (modulo,"\n\t en Fetch se cargaron [%d] Clientes ",LOG03,*iInd);
         SQLCODE = SQLOK;    
         return (SQLCODE);
    }
    else
    {
    	return (FALSE);
    }

}/************************* Fin ifnFetchClientesCourrier *************************/

/****************************************************************************/
/*  FUNCION     : bfnCloseClientesCourrier()                                */
/*  DESCRIPCION : Cierra Cursor de Clientes    		                    */
/****************************************************************************/
BOOL bfnCloseClientesCourrier()
{
    char modulo[]   = "bfnCloseClientesCourrier";

    /* EXEC SQL CLOSE cCursor_Clientes_Courrier; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )101;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/******************** Fin bfnCloseClientesCourrier *******************/

/****************************************************************************/
/*  FUNCION : bfnProcesaClientesCourrier()                                  */
/****************************************************************************/
BOOL bfnProcesaClientesCourrier( int  iInd,
				 int  iCountClientes)
{
    char    modulo[]          = "bfnProcesaClientesCourrier";
    int     iCountAux            ;
    int     iClientesUpdate   = 0;
    int     iClientesNoUpdate = 0;    
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCliente         ;
         char szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier  IS STRING(10+1) ; */ 

         char szhCodCiudad    [5+1]; /* EXEC SQL VAR szhCodCiudad    IS STRING(5+1) ; */ 

         char szhCodProvincia [5+1]; /* EXEC SQL VAR szhCodProvincia IS STRING(5+1) ; */ 

         char szhCodRegion    [3+1]; /* EXEC SQL VAR szhCodRegion    IS STRING(3+1) ; */ 
                           
    /* EXEC SQL END DECLARE SECTION; */ 

    
    

    vDTrazasLog  (modulo,"\n\t** Parametros entrada a bfnProcesaClientesCourrier\n"
			 "\t\t CountClientes  [%d]\n"
			 "\t\t Ind registro   [%d]\n",
			 LOG03,
			 iCountClientes,
			 iInd);
    
    for ( iCountAux = 0; iCountAux <= iCountClientes; iCountAux++)
    { 
    	  /* inicializando variables*/
    	  memset(szhCodCourrier,0,sizeof(szhCodCourrier));
    	  memset(szhCodCiudad,0,sizeof(szhCodCiudad));
    	  memset(szhCodProvincia,0,sizeof(szhCodProvincia));
    	  memset(szhCodRegion,0,sizeof(szhCodRegion));
    	  
    	  /* asignando valores */
    	  lhCodCliente          = stClientesInd[iCountAux].lCodCliente;
    	  strcpy(szhCodCiudad   , stClientesInd[iCountAux].szCodCiudad);
    	  strcpy(szhCodProvincia, stClientesInd[iCountAux].szCodProvincia);
    	  strcpy(szhCodRegion   , stClientesInd[iCountAux].szCodRegion); 	      
    	      	      	  
    	  if (bfnBuscaCodCourrier( szhCodCiudad,
    	                           szhCodProvincia,
    	                           szhCodRegion,
    	                           szhCodCourrier))
    	  {
    	  	
    	      if (bfnProcesoUpdateClientes( lhCodCliente , szhCodCourrier))
    	      {
    	      	  iClientesUpdate++;
    	      }
    	      else
    	      {
                  vDTrazasLog  (modulo,"\n\t WARNING Problemas para actualizar Cliente [%ld]", LOG06,lhCodCliente);    	      	  
    	      	  iClientesNoUpdate++;
    	      }    	  	
    	  }
    }
    
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo,"\nen Commit bfnUpdateClientesCourrier", LOG01);
        vDTrazasLog  (modulo,"\n\t ERROR en Commit bfnUpdateClientesCourrier", LOG01);
        return FALSE;
    }
    
    vDTrazasLog  (modulo,"\n\t** Proceso Clientes Courrier **\n", LOG03);
    vDTrazasLog  (modulo,"\t===============================", LOG03);
    vDTrazasLog  (modulo,"\n\t\t=> Clientes Actualizados    [%d] **", LOG03,iClientesUpdate);
    vDTrazasLog  (modulo,"\n\t\t=> Clientes No Actualizados [%d] **", LOG03,iClientesNoUpdate);    
    vDTrazasLog  (modulo,"\n\t\t=> Clientes Procesados      [%d] **", LOG03,iCountAux);
    
    return (TRUE);      
}/********************* Fin bfnProcesaClientesCourrier **********************/

/****************************************************************************/
/*  FUNCION     : bfnBuscaCodCourrier                                       */
/****************************************************************************/
BOOL bfnBuscaCodCourrier( char *szCodCiudad,
                          char *szCodProvincia,
                          char *szCodRegion,
                          char *szCodCourrier)
{
    char modulo[]   = "bfnBuscaCodCourrier";

    static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char    szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier  IS STRING(10+1) ; */ 

	 char    szhCodCiudad    [5+1]; /* EXEC SQL VAR szhCodCiudad    IS STRING(5+1) ; */ 

	 char    szhCodProvincia [5+1]; /* EXEC SQL VAR szhCodProvincia IS STRING(5+1) ; */ 

	 char    szhCodRegion    [3+1]; /* EXEC SQL VAR szhCodRegion    IS STRING(3+1) ; */ 
	 	 	 
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodCourrier,0,sizeof(szhCodCourrier));
    memset(szhCodCiudad,0,sizeof(szhCodCiudad));
    memset(szhCodProvincia,0,sizeof(szhCodProvincia));
    memset(szhCodRegion,0,sizeof(szhCodRegion));

    strcpy(szhCodCiudad,szCodCiudad);
    strcpy(szhCodProvincia,szCodProvincia);
    strcpy(szhCodRegion,szCodRegion);        
						 
    /* EXEC SQL
	 SELECT COD_COURRIER
	 INTO   :szhCodCourrier
	 FROM   FA_COURRIERDISTRIB
	 WHERE  COD_CIUDAD    = :szhCodCiudad
	 AND    COD_PROVINCIA = :szhCodProvincia 
	 AND    COD_REGION    = :szhCodRegion; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_COURRIER into :b0  from FA_COURRIERDISTRIB whe\
re ((COD_CIUDAD=:b1 and COD_PROVINCIA=:b2) and COD_REGION=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )116;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodCourrier;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodCiudad;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodProvincia;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodRegion;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
	iDError (szExeName,ERR000,vInsertarIncidencia,"Select->FA_COURRIERDISTRIB",szfnORAerror());
        vDTrazasLog  (modulo,"\n\t ERROR en SELECT -> FA_COURRIERDISTRIB : %d  %s ",LOG06,SQLCODE,SQLERRM);	
        vDTrazasError(modulo,"\n\t en SELECT -> FA_COURRIERDISTRIB : %d  %s **",LOG06,SQLCODE,SQLERRM);
    }
    
    if (SQLCODE == SQLNOTFOUND)
    {
        return (FALSE);    	
    }
    
    strcpy(szCodCourrier,szhCodCourrier);
    
    return (TRUE);

}/************************* Fin bfnBuscaCodCourrier *************************/

/****************************************************************************/
/*  FUNCION     : bfnProcesoUpdateClientes                                  */
/*  DESCRIPCION : Actualiza Tabla FA_CICLOCLI con el Cod. Courrier asignado */
/****************************************************************************/
BOOL bfnProcesoUpdateClientes( long lCodCliente,
                                char *szCodCourrier)
{
    char modulo[]   = "bfnProcesoUpdateClientes";
    
    static char szCadenaSQL[2048];    	

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente         ;
	 char    szhCodCourrier    [10+1]; /* EXEC SQL VAR szhCodCourrier    IS STRING(10+1) ; */ 

	 char    szhCodCourrierSql [10+1]; /* EXEC SQL VAR szhCodCourrierSql IS STRING(10+1) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
    memset(szhCodCourrier,0,sizeof(szhCodCourrier));    

    lhCodCliente = lCodCliente;
    strcpy(szhCodCourrier,szCodCourrier);    
    
    vDTrazasLog  (modulo,"\n\t** Parametros entrada a bfnProcesoUpdateClientes\n"
			 "\t\t=> Cod. Cliente         [%ld]\n"
			 "\t\t=> Cod. Courrier(input) [%s]\n",
			 LOG03,
			 lhCodCliente,
			 szhCodCourrier);
			 
    sprintf(szCadenaSQL, " SELECT\n"
		         "\t  NVL(COD_COURRIER,' ')\n"
		         "\t FROM \n"
		         "\t  FA_CICLOCLI CLI\n"
		         "\t WHERE\n"
		         "\t     COD_CLIENTE = %ld\n"
		       , lhCodCliente);	
		       
    vDTrazasLog ( modulo,"\n\t** Query for cCursor_CicloCli \n\t [%s]\n"
                        ,LOG05, alltrim(szCadenaSQL));

    /* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )147;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
	vDTrazasError  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL DECLARE cCursor_CicloCli CURSOR FOR stQueryDinamica; */ 


    if (SQLCODE) 
    {
	vDTrazasError  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_CicloCli >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_CicloCli >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL OPEN cCursor_CicloCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )166;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
       vDTrazasLog  (modulo,"\t ** No Existen Datos en cCursor_CicloCli **\n",LOG01);
       vDTrazasError(modulo,"\t ** No Existen Datos en cCursor_CicloCli **\n",LOG01);
       return (SQLCODE);
    }
    
    if(SQLCODE != SQLOK)
    {
       vDTrazasError(modulo, " en Open cCursor_CicloCli **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
       vDTrazasLog  (modulo, " en Open cCursor_CicloCli **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    } 
    
    while (SQLCODE == SQLOK)
    {
    	
           memset(szhCodCourrierSql,0,sizeof(szhCodCourrierSql));    	
    	
           /* EXEC SQL 
                FETCH cCursor_CicloCli
                INTO  :szhCodCourrierSql; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 4;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )181;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqfoff = (         int )0;
           sqlstm.sqfmod = (unsigned int )2;
           sqlstm.sqhstv[0] = (unsigned char  *)szhCodCourrierSql;
           sqlstm.sqhstl[0] = (unsigned long )11;
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



           if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
           {
               vDTrazasError(modulo,"\t en Fetch Cursor cCursor_CicloCli %s \n",LOG01,SQLERRM);
               vDTrazasLog  (modulo,"\t en Fetch Cursor cCursor_CicloCli %s \n",LOG01,SQLERRM);
           }

           if( SQLCODE == SQLOK )
	   {
               if (!strcmp(szhCodCourrier,szhCodCourrierSql)==0)
               {               	   
               	   if (!bfnUpdateCodZonaCourrier(lhCodCliente,szhCodCourrier))
               	   {
               	       return (FALSE);               	   
               	   }
               	   break;
               }
	   }
    } /*** Fin del While ***/    
    
    /* EXEC SQL CLOSE cCursor_CiCloCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )200;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor cCursor_CiCloCli : %d  %s **\n",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor cCursor_CiCloCli : %d  %s **\n",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }    
        
    return (TRUE);
    
}/********************** Fin bfnProcesoUpdateClientes ***********************/

/****************************************************************************/
/*  FUNCION     : bfnUpdateClientesCourrier                                 */
/*  DESCRIPCION : Actualiza Tabla FA_CICLOCLI con el Cod. Courrier asignado */
/****************************************************************************/
BOOL bfnUpdateClientesCourrier( long lCodCliente,
                                char *szCodCourrier)
{
    char modulo[]   = "bfnUpdateClientesCourrier";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente         ;
	 char    szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier  IS STRING(10+1) ; */ 
	 	 	 
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodCourrier,0,sizeof(szhCodCourrier));

    lhCodCliente = lCodCliente;
    strcpy(szhCodCourrier,szCodCourrier);
						 
    /* EXEC SQL
	 UPDATE FA_CICLOCLI
	        SET COD_COURRIER = :szhCodCourrier
	 WHERE  COD_CLIENTE    = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_CICLOCLI  set COD_COURRIER=:b0 where COD_CLIENT\
E=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )215;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodCourrier;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    if (SQLCODE != SQLOK)
    {
	iDError (szExeName,ERR000,vInsertarIncidencia,"Update->FA_CICLOCLI",szfnORAerror());
        vDTrazasLog  (modulo,"\n\t ERROR en UPDATE -> FA_CICLOCLI : %d  %s ",LOG06,SQLCODE,SQLERRM);	
        vDTrazasError(modulo,"\n\t en UPDATE -> FA_CICLOCLI : %d  %s **",LOG06,SQLCODE,SQLERRM);
    }
    
    return (TRUE);

}/************************* Fin bfnUpdateClientesCourrier *************************/

/****************************************************************************/
/*  FUNCION     : bfnUpdateCodZonaCourrier                                 */
/*  DESCRIPCION : Actualiza Tabla FA_CICLOCLI con el Cod. Courrier asignado */
/****************************************************************************/
BOOL bfnUpdateCodZonaCourrier( long lCodCliente,
                                char *szCodCourrier)
{
    char modulo[]   = "bfnUpdateCodZonaCourrier";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente         ;
	 char    szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier  IS STRING(10+1) ; */ 
	 	 	 
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhCodCourrier,0,sizeof(szhCodCourrier));

    lhCodCliente = lCodCliente;
    strcpy(szhCodCourrier,szCodCourrier);
						 
    /* EXEC SQL
	 UPDATE FA_CICLOCLI
	        SET COD_COURRIER = :szhCodCourrier,
	            COD_ZONACOURRIER = NULL
	 WHERE  COD_CLIENTE    = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_CICLOCLI  set COD_COURRIER=:b0,COD_ZONACOURRIER\
=null  where COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )238;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodCourrier;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    if (SQLCODE != SQLOK)
    {
	iDError (szExeName,ERR000,vInsertarIncidencia,"Update->FA_CICLOCLI",szfnORAerror());
        vDTrazasLog  (modulo,"\n\t ERROR en UPDATE -> FA_CICLOCLI : %d  %s ",LOG06,SQLCODE,SQLERRM);	
        vDTrazasError(modulo,"\n\t en UPDATE -> FA_CICLOCLI : %d  %s **",LOG06,SQLCODE,SQLERRM);
    }
    
    return (TRUE);

}/************************* Fin bfnUpdateCDodZonaCourrier *************************/


/****************************************************************************/
/*  FUNCION : bfnProcesaClientesEspeciales()                                */
/****************************************************************************/
BOOL bfnProcesaClientesEspeciales( int  iIndEsp,
				   int  iCountClientesEsp)
{
    char    modulo[]           = "bfnProcesaClientesEspeciales";
    int     iCountAux             ;
    int     iClientesUpdate    = 0;
    int     iClientesNoUpdate  = 0;
    int     iClientesEspNoFind = 0;       
        
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCliente         ;
         char szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier  IS STRING(10+1) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
    

    vDTrazasLog  (modulo,"\n\t** Parametros entrada a bfnProcesaClientesEspeciales\n"
			 "\t\t CountClientes  [%d]\n"
			 "\t\t Ind registro   [%d]\n",
			 LOG03,
			 iCountClientesEsp,
			 iIndEsp);
    
    for ( iCountAux = 0; iCountAux <= iCountClientesEsp; iCountAux++)
    { 
    	  /* inicializando variables*/
    	  memset(szhCodCourrier,0,sizeof(szhCodCourrier));
    	  
    	  /* asignando valores */
    	  lhCodCliente          = stClientesEspInd[iCountAux].lCodCliente;
    	  strcpy(szhCodCourrier   , stClientesEspInd[iCountAux].szCodCourrier);
    	      	      	  
    	  if (bfnBuscaClienteCourrier( lhCodCliente) )
    	  {
    	      if (bfnProcesoUpdateClientes( lhCodCliente , szhCodCourrier))
    	      {
    	      	  iClientesUpdate++;
    	      }
    	      else
    	      {
                  vDTrazasLog  (modulo,"\n\t WARNING Problemas para actualizar Cliente [%ld]", LOG06,lhCodCliente);    	      	  
    	      	  iClientesNoUpdate++;
    	      }    	  	    	  	    	  	
    	  }
    	  else
    	  {
                  vDTrazasLog  (modulo,"\n\t ** WARNING No existe Cliente [%ld] **", LOG06,lhCodCliente);    	  	
    	  	  iClientesEspNoFind++;
    	  }
    }
    
    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo,"\nen Commit bfnUpdateClientesCourrier (Especiales)", LOG01);
        vDTrazasLog  (modulo,"\n\t ERROR en Commit bfnUpdateClientesCourrier (Especiales)", LOG01);
        return FALSE;
    }
    
    vDTrazasLog  (modulo,"\n\t**   Proceso Clientes Especiales   **\n", LOG03);
    vDTrazasLog  (modulo,"\t=====================================", LOG03);
    vDTrazasLog  (modulo,"\n\t\t=> Clientes Actualizados    [%d] **", LOG03,iClientesUpdate);
    vDTrazasLog  (modulo,"\n\t\t=> Clientes No Actualizados [%d] **", LOG03,iClientesNoUpdate);
    vDTrazasLog  (modulo,"\n\t\t=> Clientes No Encontrados  [%d] **", LOG03,iClientesEspNoFind);    
    vDTrazasLog  (modulo,"\n\t\t=> Clientes Procesados      [%d] **", LOG03,iCountAux);
    
    return (TRUE);      
}/********************* Fin bfnProcesaClientesEspeciales **********************/


/****************************************************************************/
/*  FUNCION     : bfnBuscaClienteCourrier                                    */
/****************************************************************************/
BOOL bfnBuscaClienteCourrier( long lCodCliente)
{
    char modulo[]   = "bfnBuscaClienteCourrier";

    static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente         ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente = lCodCliente;
						 
    /* EXEC SQL
	 SELECT DISTINCT COD_CLIENTE
	 INTO   :lhCodCliente
	 FROM   FA_CICLOCLI
         WHERE  COD_CLIENTE    = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select distinct COD_CLIENTE into :b0  from FA_CICLOCLI wh\
ere COD_CLIENTE=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )261;
    sqlstm.selerr = (unsigned short)1;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
	iDError (szExeName,ERR000,vInsertarIncidencia,"Select->FA_CICLOCLI",szfnORAerror());
        vDTrazasLog  (modulo,"\n\t ERROR en SELECT -> FA_CICLOCLI : %d  %s ",LOG06,SQLCODE,SQLERRM);	
        vDTrazasError(modulo,"\n\t en SELECT -> FA_CICLOCLI : %d  %s **",LOG06,SQLCODE,SQLERRM);
    }
    
    if (SQLCODE == SQLNOTFOUND)
    {
        return (FALSE);    	
    }
    
    return (TRUE);

}/************************* Fin bfnBuscaClienteCourrier *************************/


/****************************************************************************/
/*  FUNCION     : ifnOpenClientesEspeciales()                               */
/*  DESCRIPCION : Abre cursor Clientes Especiales      		            */
/****************************************************************************/
int ifnOpenClientesEspeciales( PARAMETROSENTRADA *stParamIn )
{
    char modulo[]   = "ifnOpenClientesEspeciales";
    static char szCadenaSQL[2048];
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhFecEmision [10+1]; /* EXEC SQL VAR szhFecEmision    IS STRING(10+1) ; */ 

         long lhCodClienteIni ;
         long lhCodClienteFin ;	 
    /* EXEC SQL END DECLARE SECTION; */ 
    

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    memset(szhFecEmision,0,sizeof(szhFecEmision));
    
    strcpy(szhFecEmision,stParamIn->szFecEmision);

    vDTrazasLog ( modulo, "\n\t** Fecha Emision : [%s] \n"
                        , LOG05
                        , szhFecEmision);
                        
    if (stParamIn->bRngClientes)
    {
    	/* Con Rango de Clientes */
        lhCodClienteIni = stParamIn->lCodClienteIni;
        lhCodClienteFin = stParamIn->lCodClienteFin;                         
        
        vDTrazasLog ( modulo, "\n\t** Con Rango de Clientes : Cliente Inicial [%ld] **\n"
                              "  \t**                         Cliente Final   [%ld] **\n"
                            , LOG05
                            , lhCodClienteIni
                            , lhCodClienteFin);        

        sprintf(szCadenaSQL, " SELECT\n"
	    	             "\t  COD_CLIENTE,\n"
		             "\t  NVL(COD_COURRIER,' ')\n"
		             "\t FROM \n"
		             "\t  FA_CLIENTESCOURRIER\n"		        
		             "\t WHERE\n"
		             "\t     TO_DATE(:szhFecEmision,'DD-MM-YYYY') <= TRUNC(FEC_VIGENCIA)\n"		             
		             "\t AND COD_CLIENTE >= %ld\n"
		             "\t AND COD_CLIENTE <= %ld\n"
		           , lhCodClienteIni
		           , lhCodClienteFin);
    }		             		             
    else
    {
    	/* Sin Rango de Clientes */  
        vDTrazasLog ( modulo, "\n\t** Sin Rango de Clientes **\n" , LOG05);    	  	
        sprintf(szCadenaSQL, " SELECT\n"
	    	             "\t  COD_CLIENTE,\n"
		             "\t  NVL(COD_COURRIER,' ')\n"
		             "\t FROM \n"
		             "\t  FA_CLIENTESCOURRIER\n"		        
		             "\t WHERE\n"
		             "\t     TO_DATE(:szhFecEmision,'DD-MM-YYYY') <= TRUNC(FEC_VIGENCIA)\n");    	    	
    }		             
		         

    /*** FIN Declara Cursor ***/

    vDTrazasLog ( modulo,"\n\t** Query for cCursor_Clientes_Especiales \n\t [%s]\n"
                        ,LOG05, alltrim(szCadenaSQL));

    /* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )284;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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
	vDTrazasError  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL DECLARE cCursor_Clientes_Especiales CURSOR FOR stQueryDinamica; */ 


    if (SQLCODE) 
    {
	vDTrazasError  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_Especiales >>"
			       "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_Especiales >>"
			     "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return (SQLCODE);
    }

    /* EXEC SQL OPEN cCursor_Clientes_Especiales USING :szhFecEmision; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )303;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    if(SQLCODE == SQLNOTFOUND)
    {
       vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Clientes_Especiales **",LOG01);
       vDTrazasError(modulo," ** No Existen Datos en cCursor_Clientes_Especiales **",LOG01);
       return (SQLCODE);
    }
    
    if(SQLCODE != SQLOK)
    {
       vDTrazasError(modulo, " en Open cCursor_Clientes_Especiales **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
       vDTrazasLog  (modulo, " en Open cCursor_Clientes_Especiales **"
                             "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    return (SQLOK);

}/******************** Fin ifnOpenClientesEspeciales ********************/

/****************************************************************************/
/*  FUNCION     : ifnFetchClientesEspeciales()                              */
/*  DESCRIPCION : Fetch Clientes Especiales    		                    */
/****************************************************************************/
int ifnFetchClientesEspeciales( int *iIndEsp,
			        int *iCountClientesEsp)
{
    char modulo[]   = "ifnFetchClientesEspeciales";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 long    lhCodCliente;
	 char    szhCodCourrier [10+1]; /* EXEC SQL VAR szhCodCourrier    IS STRING(10+1) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t** Parametros entrada a ifnFetchClientesEspeciales\n"
			 "\t\t=> CountClientes [%d]\n"
			 "\t\t=> Ind registro  [%d]\n",
			 LOG03,
			 *iCountClientesEsp,
			 *iIndEsp);					 

    while (SQLCODE == SQLOK)
    {
           /* EXEC SQL 
                FETCH cCursor_Clientes_Especiales
                INTO  :lhCodCliente,
                      :szhCodCourrier; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 4;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )322;
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
           sqlstm.sqhstv[1] = (unsigned char  *)szhCodCourrier;
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



           if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
           {
               vDTrazasError(modulo," en Fetch Cursor cCursor_Clientes_Especiales %s ",LOG01,SQLERRM);
               vDTrazasLog  (modulo," en Fetch Cursor cCursor_Clientes_Especiales %s ",LOG01,SQLERRM);
           }

           if( SQLCODE == SQLOK )
	   {
   	       (*iCountClientesEsp)++; 
	       memset(&stClientesEspInd[*iCountClientesEsp],0,sizeof(CLIENTESESPIND));       
	       stClientesEspInd[*iCountClientesEsp].lCodCliente   = lhCodCliente;
               strcpy(stClientesEspInd[*iCountClientesEsp].szCodCourrier , szhCodCourrier);
	       stClientesEspInd[*iCountClientesEsp].iIndFin       = *iIndEsp;

	       (*iIndEsp)++;
	   }
    } /*** Fin del While ***/
 
    if ( SQLCODE == SQLNOTFOUND)
    {
         vDTrazasLog  (modulo,"\n\t en Fecht se cargaron [%d] Clientes Especiales ",LOG03,*iIndEsp);
         SQLCODE = SQLOK;    
         return (SQLCODE);
    }
    else
    {
    	return (FALSE);
    }

}/************************* Fin ifnFetchClientesEspeciales *************************/

/****************************************************************************/
/*  FUNCION     : bfnCloseClientesEspeciales()                              */
/*  DESCRIPCION : Cierra Cursor de Clientes Especiales                      */
/****************************************************************************/
BOOL bfnCloseClientesEspeciales()
{
    char modulo[]   = "bfnCloseClientesEspeciales";

    /* EXEC SQL CLOSE cCursor_Clientes_Especiales; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )345;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/******************** Fin bfnCloseClientesEspeciales *******************/

/*** Funciones para Manejo de Strings ***/

#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) )
        return(s);
    while( *p<=32 && *p>1 )
        p++;
    strcpy(s,p);
    return(s);
} /*** FIN ltrim ***/

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) )
        return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )
        p--;
    *(++p)=0;
    return(s);
} /*** FIN rtrim ***/

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
} /*** FIN alltrim ***/

/*** FIN alltrim ***/
