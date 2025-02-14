
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
static const struct sqlcxp sqlfpn =
{
    19,
    "./pc/DobleCuenta.pc"
};


static unsigned int sqlctx = 27593571;


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
{12,4130,2,0,0,
};


/****************************************************************************/
/* Fichero    : DobleCuentaFnc.pc                                           */
/* Descripcion: fichero de funciones auxiliares al ejecutable de factura    */
/* Fecha      : 02-09-2007                                                  */
/* Autor      : Carlos A. Ortiz Hijar                                       */
/****************************************************************************/

#define _DOBLECUENTAFNC_C_

#include "DobleCuenta.h"

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


int     igLogLevel;

int main ( int argc, char *argv[])
{
	char modulo[]="main";

	long	lCodCicloFact;
	char    szOraAccount[32];
	char    szOraPasswd[32];

	PARAMETROSENTRADA 	stParametrosIn;

	/*** Inicializacion de Variables ***/
	igLogLevel = 3;
	memset(szOraAccount,'\0',sizeof(szOraAccount));
	memset(szOraPasswd,'\0',sizeof(szOraPasswd));

	fprintf(stderr,"\n  Doble Cuenta version " __DATE__ " " __TIME__ " PAN\n");
    
	memset(&stParametrosIn,0,sizeof(PARAMETROSENTRADA));

	if (!bfnValidaParametrosIn (argc, argv, szOraAccount, szOraPasswd, &stParametrosIn, &igLogLevel)) 
		return (ERROR_PARAMETROS);

	/* Obtencion de usuario/password como cadena conjunta */
	sprintf(szUsuarioPasswd,"%s/%s", szOraAccount, szOraPasswd);

	if (!bfnAbreArchivosLog(igLogLevel))
		return (ERROR_ARCHIVOSLOG);
		
	vDTrazasLog  (modulo, "\n  Doble Cuenta version " __DATE__ " " __TIME__ " PAN\n",LOG03); /* PGG SOPORTE - 11-12-2008 - 74293 */

	if (!ifnAcessoOracle(szOraAccount,szOraPasswd))
		return (ERROR_ACCESSORA);

	vDTrazasLog  (modulo, "\n\t**  Parametros de Entrada : Doble Cuenta ***",LOG03); 
	vDTrazasLog  (modulo, "\t\t=> Cod. Ciclo Fact  [%ld]",LOG03, stParametrosIn.lCodCicloFact); 
	vDTrazasLog  (modulo, "\t\t=> Cod. Cliente Ini [%ld]",LOG03, stParametrosIn.lCodClienteIni); 
	vDTrazasLog  (modulo, "\t\t=> Cod. Cliente Fin [%ld]",LOG03, stParametrosIn.lCodClienteFin); 
	
	/*** Se Obtiene el Ciclo de Facturacion ***/
	if(!bfnGetCicloFact(&stParametrosIn))
    {
        vDTrazasError(modulo," Error, en bfnGetCicloFact\n", LOG01);
        vDTrazasLog  (modulo," Error, en bfnGetCicloFact\n", LOG01);
        return FALSE;
	}
/* Cargo una sola vez los datos generales. */
	if (!bfnCargaDatosGenerales(stParametrosIn.lCodCicloFact))
	{
				vDTrazasError(modulo," Error, en bfnCargaDatosGenerales\n", LOG01);
        vDTrazasLog  (modulo," Error, en bfnCargaDatosGenerales\n", LOG01);
        return FALSE;
	}

/* Cargo Datos de Conversion de Moneda. */	
	if (!bCargaConversion (pstConversion,&NUM_CONVERSION, stFecProceso.szFecEmision, stFecProceso.szFecEmision))
	{
				vDTrazasError(modulo," Error, en bCargaConversion\n", LOG01);
        vDTrazasLog  (modulo," Error, en bCargaConversion\n", LOG01);
        return FALSE;		
	}

/* Cargo Parametros de uso de decimales */
	if( !bGetParamDecimales() )
	{
		vDTrazasError(modulo, "en retorno de bGetParamDecimales().",LOG01);
		vDTrazasLog(modulo, "en retorno de bGetParamDecimales().",LOG01);
		return FALSE;
	}
	
	vDTrazasLog(modulo, "---> PPV <--- pstParamGener.iNumDecimal	[%ld]		 \n"
	                  , LOG05, pstParamGener.iNumDecimal);
	vDTrazasLog(modulo, "---> PPV <--- pstParamGener.iNumDecimalFact	[%ld]\n"
	                  , LOG05, pstParamGener.iNumDecimalFact);

	/*** Se inicaliza el Proceso de Traza de Procesos ***/
	if (!bfnFacturacionDiferenciada(&stParametrosIn))
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

	fprintf(stdout,"\nTermino del Proceso Doble Cuenta \n\n");
    return 0;

} /*** Fin main() ***/

/***************************  Fin  Bloque Principal  ***************************/

/* ******************************************************************************** */
/* bfnValidaParametrosIn : verifica los parametros de la invocacion  */
/* ******************************************************************************** */
BOOL bfnValidaParametrosIn (int     argc,
                            char    *argv[],
                            char    *szOraAccount ,
                            char    *szOraPasswd,
			    PARAMETROSENTRADA    *stParametrosIn,
                            int     *igLogLevel)
{
    char modulo[]="bfnValidaParametrosIn";

    extern char *optarg;
    extern int opterr, optopt;

    char opt[] = "u:c:l:i:f:";
    int iOpt=0;
    char *psztmp = "";
    char szUser[64];

    BOOL bUserFlag=FALSE;
    BOOL bCodCicloFlag=FALSE;
    BOOL bLogFlag=FALSE;
    BOOL bClieIniFlag=FALSE;
    BOOL bClieFinFlag=FALSE;

	memset(szUser,'\0',sizeof(szUser));
    opterr=0;

    if(argc == 1)
    {
        fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
        return (FALSE);
    }

	stParametrosIn->iRngClientes = FALSE;

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


    if(bUserFlag==TRUE)
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

	if(bCodCicloFlag==FALSE)
    {
        fprintf (stderr,"\n\t<< Error : falta opcion '-c' >>\n%s\n",szUsage);
        return (FALSE);
    }

    if(bLogFlag==FALSE)
    {
        fprintf (stderr,"\n\t<< Error : falta opcion '-l' >>\n%s\n",szUsage);
        return (FALSE);
    }

	if(((bClieIniFlag==TRUE) && (bClieFinFlag==FALSE)) ||
		((bClieIniFlag==FALSE) && (bClieFinFlag==TRUE)))
	{
        fprintf (stderr,"\n\t<< Error : Rango de Clientes Invalido >>\n%s\n",szUsage);
        return (FALSE);
	}

    if((bClieIniFlag==TRUE) && (bClieFinFlag==TRUE))
		 stParametrosIn->iRngClientes = TRUE;

    return (TRUE); /* Validacion ok */

} /***************************  Fin  bfnValidaParametros  ***************************/

/* ************************************************************************************* */
/* bfnAbreArchivosLog                                                                    */
/* ************************************************************************************* */
BOOL bfnAbreArchivosLog(int igLogLevel)
{

    char modulo[]="bfnAbreArchivosLog";

    char *pathDir;
    char szArchivo[52];
    char szPath[128];
    char szComando[128];

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"DobleCuenta_%s",cfnGetTime(5));

    pathDir=(char *)malloc(128);
    pathDir=szGetEnv("XPF_LOG");
    memset(szPath,'\0',sizeof(szPath));
    sprintf(szPath,"%s/DobleCuenta",pathDir);
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
/* ifnAcessoOracle : Se conecta y trabaja sobre la base de Datos */
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

int bfnFacturacionDiferenciada (PARAMETROSENTRADA *stParametrosIn)
{
    char    modulo[]="bfnFacturacionDiferenciada";

	int     iSqlCodeInt= SQLOK;	
	long	lCodCicloFact;
	char    szFecha[15];
	BOOL	bRptFnc=TRUE;
	int		iInd = iINI_INDICE;
	int		iCountClientes = iINI_COUNTCLIENTES;

	memset(szFecha,'\0',sizeof(szFecha));

    /****************************************************************************/
    if (!bfnValidaTrazaProc(stParametrosIn->lCodCicloFact, 
							iPROC_DOBLECUENTA, 
							iIND_FACT_ENPROCESO))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnValidaTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnValidaTrazaProc", LOG01);
        return (FALSE);
    }

    bfnSelectTrazaProc (stParametrosIn->lCodCicloFact, 
						iPROC_DOBLECUENTA, 
						&stTrazaProc);

    bPrintTrazaProc(stTrazaProc);

    /****************************************************************************/

    if( ifnOpenClientesFactuDif(stParametrosIn) == SQLOK )
        if( ifnFetchClientesFactuDif(&iInd, &iCountClientes) == SQLOK )
    		if (!bfnCloseClientesFactuDif())
				return (FALSE);

    /****************************************************************************/

	bRptFnc = bfnProcesaClientesFactuDif(stParametrosIn->lCodCicloFact,
										iInd,
										iCountClientes);

    if (!bfnSelectSysDate(szFecha))
        return FALSE;

	/*** Cambiar esta funcion, por la de proceso real ***/
    if (!bRptFnc)
	{
        stTrazaProc.iCodEstaProc = iPROC_EST_ERR;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Doble Cuenta Termino con Error");
    }
    else 
	{
        stTrazaProc.iCodEstaProc = iPROC_EST_OK;
        strcpy(stTrazaProc.szFecTermino,szFecha);
        strcpy(stTrazaProc.szGlsProceso,"Proceso Doble Cuenta Terminado OK");
    }


    bPrintTrazaProc(stTrazaProc);

    if(!bfnUpdateTrazaProc(stTrazaProc))
        return (FALSE);

    if (!bfnOraCommit ())
    {
        vDTrazasError(modulo," en Commit bfnUpdateTrazaProc", LOG01);
        vDTrazasLog  (modulo," en Commit bfnUpdateTrazaProc", LOG01);
        return FALSE;
    }
    /****************************************************************************/

    return (TRUE);

} /******************************  Fin  bfnFacturacionDiferenciada ***************************/


