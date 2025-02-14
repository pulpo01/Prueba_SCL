
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
    "./pc/infctlfactur.pc"
};


static unsigned int sqlctx = 55274299;


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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,17,486,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,504,0,0,0,0,0,1,0,
39,0,0,1,0,0,13,515,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,9,
0,0,2,4,0,0,
82,0,0,1,0,0,15,540,0,0,0,0,0,1,0,
97,0,0,1,0,0,15,561,0,0,0,0,0,1,0,
112,0,0,2,69,0,4,581,0,0,1,0,0,1,0,2,97,0,0,
131,0,0,3,72,0,4,622,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
154,0,0,4,207,0,3,777,0,0,10,10,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
209,0,0,5,83,0,4,825,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
232,0,0,6,0,0,17,1042,0,0,1,1,0,1,0,1,97,0,0,
251,0,0,6,0,0,45,1060,0,0,1,1,0,1,0,1,3,0,0,
270,0,0,6,0,0,13,1071,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,3,0,0,
297,0,0,6,0,0,15,1091,0,0,0,0,0,1,0,
312,0,0,6,0,0,15,1105,0,0,0,0,0,1,0,
327,0,0,7,205,0,3,1154,0,0,10,10,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
382,0,0,8,0,0,17,1397,0,0,1,1,0,1,0,1,97,0,0,
401,0,0,8,0,0,45,1415,0,0,1,1,0,1,0,1,3,0,0,
420,0,0,8,0,0,13,1426,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
455,0,0,8,0,0,15,1448,0,0,0,0,0,1,0,
470,0,0,8,0,0,15,1466,0,0,0,0,0,1,0,
485,0,0,9,259,0,3,1551,0,0,13,13,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
552,0,0,10,88,0,5,1671,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,
579,0,0,11,0,0,17,1725,0,0,1,1,0,1,0,1,97,0,0,
598,0,0,11,0,0,45,1743,0,0,0,0,0,1,0,
613,0,0,11,0,0,13,1752,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
636,0,0,11,0,0,15,1764,0,0,0,0,0,1,0,
651,0,0,12,280,0,3,1768,0,0,10,10,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
706,0,0,13,55,0,4,1819,0,0,1,0,0,1,0,2,3,0,0,
725,0,0,14,75,0,4,1834,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : infctlfactur.pc                                         * */
/* *  Reporte de Facturación de Ciclo                                   * */
/* *  Autor : Mauricio Villagra V.                                      * */
/* *  Comentarios :                                                     * */
/* ********************************************************************** */


#define _INFCTLFACTUR_PC_

#include <memory.h>  
#include <GenFA.h>
#include <rutinasgen.h>
#include <trazafact.h>
#include "infctlfactur.h"

char szUsage[]=
   "\nUso:  infctlfactur -u Usuario/Password    "
   "\n\tOPCIONES:                               "
   "\n                                          "
   "\n          -c Cod_CiclFact (DDMMYY)        "
   "\n          -m  Mes_Emision   (MM)          "
   "\n          -a  Ano_Emision   (YYYY)        "
   "\n          -l [LogNivel]                   "
   "\n";

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



/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{

    extern  char *optarg        ;
    char    opt[]="u:c:a:m:l:"  ;
    int     iOpt =0             ;
    char    szUsuario [63] = "" ;
    char    *psztmp      = ""   ;
    char    szaux     [10]      ;
    BOOL    bOptUsuario = FALSE ;
    char    szComando   [256]   ;
    char    *szDirLogs          ;
    char    szSysDate   [20]    ;

    memset(&stLineaComando,0,sizeof(PCF_LINEACOMANDO));
    
    stLineaComando.bOptNoCiclico    = FALSE ;
    stLineaComando.bOptCiclico      = FALSE ;

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {   
            case 'u':
                    if (strlen (optarg))
                    {
                        strcpy(szUsuario, optarg);
                        bOptUsuario = TRUE;
                        fprintf (stdout," -u %s ", szUsuario);
                    }
                    break;
            case 'c':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        
                        stLineaComando.lCodCiclFact = atol(szaux);
                        stLineaComando.bOptCiclico  = TRUE;
                        fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                    }
                    break;
            case 'm':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.bOptNoCiclico    = TRUE;
                        stLineaComando.lMesEmision= atol(szaux);
                        fprintf (stdout,"-f %ld ", stLineaComando.lMesEmision);
                    }
                    break;
            case 'a':
                    if (strlen (optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.bOptNoCiclico    = TRUE;
                        stLineaComando.lAnoEmision= atol(szaux);
                        fprintf (stdout,"-f %ld ", stLineaComando.lAnoEmision);
                    }
                    break;
            case 'l':
                    if (strlen (optarg))
                    {
                        stStatus.LogNivel =
                        (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                        fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                    }
                    break;
        }
    }

    /********************************************************************/
    /*              Informe de facturación de Ciclo                     */
    /********************************************************************/
    if (stLineaComando.bOptCiclico)
    {
        if (stLineaComando.bOptNoCiclico)
        {
            fprintf (stderr, "\n\t# Error: Informe de Ciclo No Requerie Patametros -a/-m\n%s\n", szUsage);
            return 1;
        }
        
    }
    else
    {
        if (!stLineaComando.bOptNoCiclico)
        {
            fprintf (stderr, "\n\t# Error de Parametros.\n%s\n", szUsage);
            return 1;
        }
        if (stLineaComando.lMesEmision <= 0 || stLineaComando.lAnoEmision <= 0)
        {
            fprintf (stderr,"\n\t# Error: Informe No Ciclico debe ingresar"
                            "\n\t\t Mes y Ano de Emision [-m -a] \n%s\n", szUsage);        
            return 1;

        }
    }

    /********************************************************************/
    /*              Validacion de Usuario Oracle                        */
    /********************************************************************/
    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
        if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
        {
            fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
            return (3);
        }
        else
        {
            strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
            strcpy  (stLineaComando.szPass, psztmp+1)                 ;
        }
    }

    if (stStatus.LogNivel <= 0)
        stStatus.LogNivel = iLOGNIVEL_DEF     ;
    stLineaComando.iNivLog = stStatus.LogNivel;
     
    /********************************************************************/
    /*              Establece Conexion a ORACLE                         */
    /********************************************************************/
    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------"
                ,stLineaComando.szUser);
    }
    /*********************************************************************************************/
    if (!bGetDatosGener (&stDatosGener, szSysDate))
        return FALSE;
    /**************************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    if (stLineaComando.bOptCiclico)
        sprintf(stLineaComando.szDirLogs,"%s/informes/Ciclo/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    else
        sprintf(stLineaComando.szDirLogs,"%s/informes/NoCiclo/%04ld%02ld/"
                                        ,szDirLogs,stLineaComando.lAnoEmision
                                        ,stLineaComando.lMesEmision);
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );
    
    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName, "%sInfCtlFactur_%s.err",
            stLineaComando.szDirLogs, szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return (4);
    }
    
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%sInfCtlFactur_%s.log",
            stLineaComando.szDirLogs, szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de log %s\n", stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*********************************************************************************************/
    vDTrazasLog  (szExeInfCtlFactur,"\n\n\t******************************************"
                                    "\n\n\t****        Log   InfCtlFactur          **"
                                    "\n\n\t******************************************"
                                    ,LOG03);

    vDTrazasError(szExeInfCtlFactur,"\n\n\t***************************************"
                                    "\n\n\t****     Errores de InfCtlFactur     **"
                                    "\n\n\t***************************************"
                                    ,LOG03);
    /*********************************************************************************************/

    if(!bMainReporte())
        bfnOraRollBackRelease();
    else 
    {
        if (!bfnOraCommit())
        {
           vDTrazasError(szExeInfCtlFactur, "\n\n\tError en Commit ", LOG01);
           return FALSE;
        }
    }                                        
    /*********************************************************************************************/
    if(!bfnDisconnectORA(0))
    {
     /*No estaba conectado*/
    }
    else                                       
    {
        vDTrazasLog(szExeInfCtlFactur,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE  %s"
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);
    }
}

/****************************************************************************/
/*  Funcion :   bMainReporte                                                */
/****************************************************************************/
BOOL  bMainReporte()
{
   vDTrazasLog(szExeInfCtlFactur,  "Entrando a bMainReporte",   LOG03);
    
    if (stLineaComando.bOptNoCiclico)
    {
        if (stLineaComando.lMesEmision < 0 || stLineaComando.lMesEmision > 12)
        {
            vDTrazasError(szExeInfCtlFactur, "Mes Invalido [%ld] (bMainReporte)"
                                            ,LOG01,stLineaComando.lMesEmision );
            return FALSE;
        }        
        if (stLineaComando.lAnoEmision < 1997 || stLineaComando.lAnoEmision > 3000)
        {
            vDTrazasError(szExeInfCtlFactur, "Ano Invalido 1998-2999 [%ld] (bMainReporte)"
                                          , LOG01, stLineaComando.lAnoEmision );
            return FALSE;
        }
    }
    else
    {
        if (stLineaComando.lCodCiclFact == 0)
        {
            vDTrazasError(szExeInfCtlFactur, "Codigo de Ciclo de Facturacion Invalido [%ld] (bMainReporte)"
                                          ,LOG01,stLineaComando.lCodCiclFact);
            return FALSE;
        }        
    }
    /****************************************************************/
    /*  Obtiene Numero de Secuencia de Informe                      */
    /****************************************************************/
    if (!bfnGetSecuInfo())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Obtener Secuencia de Informe (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Planes Tarifarios de Planes Familiares                */
    /****************************************************************/
    if (!bfnCargaPlanFamiliar())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Carga de Planes Familiares (bMainReporte)",LOG01);
        return FALSE;
    }
    /****************************************************************/
    /*  Carga Datos de Ciclo de Facturacion                         */
    /****************************************************************/
    memset(&pstCiclo,0,sizeof(CICLO));
    pstCiclo.lCodCiclFact = stLineaComando.lCodCiclFact;
    if (!bFindCiclFact (&pstCiclo))
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Carga de Ciclo Facturacion (bMainReporte)",LOG01);
        return FALSE;
    }
    
    /****************************************************************/
    /*  Carga Documentos a Considerar Como Universo de Datos        */
    /****************************************************************/
    if (!bfnCargaDoctos())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Carga de Documentos (bMainReporte)",LOG01);
        return FALSE;
    }

    /****************************************************************/
    /*  Analiza Información de Clientes para Documentos Cargados    */
    /****************************************************************/
    if (!bfnStatClientes())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Estadisticas de Clientes (bMainReporte)",LOG01);
        return FALSE;
    }
    vPrintStClientes();
    
    
    /****************************************************************/
    /*  Analiza Información de Abonados para Documentos Cargados    */
    /****************************************************************/
    if (!bfnStatAbonados())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Estadisticas de Abonados (bMainReporte)",LOG01);
        return FALSE;
    }
    vPrintStAbonados();

    /****************************************************************/
    /*  Analiza Información de Conceptos para Documentos Cargados   */
    /****************************************************************/

    if (!bfnStatConceptos())
    {
        vDTrazasError(szExeInfCtlFactur,"Error en Estadisticas de Conceptos (bMainReporte)",LOG01);
        return FALSE;
    }
    vPrintStConceptos();


    /****************************************************************/
    /*  Inserta Resumen de Documentos Facturados                    */
    /****************************************************************/
    if (!bfnInsertHeaderInfCtl())
    {
        vDTrazasError(szExeInfCtlFactur,"Error al Insertar Estadsticas de Clientes (bMainReporte)",LOG01);
        return FALSE;
    }

    if (!bfnInsertStatClientes())
    {
        vDTrazasError(szExeInfCtlFactur,"Error al Insertar Estadsticas de Clientes (bMainReporte)",LOG01);
        return FALSE;
    }

    if (!bfnInsertStatAbonados())
    {
        vDTrazasError(szExeInfCtlFactur,"Error al Insertar Estadsticas de Abonados (bMainReporte)",LOG01);
        return FALSE;
    }
    if (!bfnInsertStatConceptos())
    {
        vDTrazasError(szExeInfCtlFactur,"Error al Insertar Estadsticas de Abonados (bMainReporte)",LOG01);
        return FALSE;
    }

    
    return TRUE;
}


/****************************************************************************/
/*  Funcion :   vCargaDatos                                                 */
/****************************************************************************/
BOOL bfnCargaDoctos()
{
    char    szTabla     [50]    ="";
    char    szSelectSQL [1024]  ="";
    char    szFromSQL   [512]   ="";
    char    szWhereSQL  [512]   ="";
    char    szCadenaSQL [1024]  ="";
    int     iIndCiclo           = 0;
    int     iContFetch          = 0;
    int     iContRowsFetch      = 0;
    int     iContRowsFetchAux   = 0;
    int     iContRow            = 0;
    int     i                   = 0;

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

        char    szhFecha1   [20];   /* EXEC SQL VAR szhFecha1   IS STRING(20); */ 

        char    szhFecha2   [20];   /* EXEC SQL VAR szhFecha2   IS STRING(20); */ 

        long    lhvIndOrdenTotal    [MAX_DOCTOS_CONTROL_FETCH]      ;
        long    lhvCodCliente       [MAX_DOCTOS_CONTROL_FETCH]      ;
        long    lhvCodCiclFact      [MAX_DOCTOS_CONTROL_FETCH]      ;
        int     ihvCodTipDocum      [MAX_DOCTOS_CONTROL_FETCH]      ;
        int     ihvIndFactur        [MAX_DOCTOS_CONTROL_FETCH]      ;
        int     ihvIndSupertel      [MAX_DOCTOS_CONTROL_FETCH]      ;
        /* VARCHAR szvCodDespacho      [MAX_DOCTOS_CONTROL_FETCH][6]   ; */ 
struct { unsigned short len; unsigned char arr[6]; } szvCodDespacho[1000];

        double  dhvTotFactura       [MAX_DOCTOS_CONTROL_FETCH]      ;
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    memset(&stDetCtlInfDoctos,0,sizeof(FADETDOCTOS));

    vDTrazasLog(szExeInfCtlFactur,      "\n\t Carga de Docuentos en Memoria",LOG03);

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    if (stLineaComando.bOptCiclico)
    {
        vDTrazasLog(szExeInfCtlFactur,  "\t Ciclo de Facturacion [%ld]"
                                     ,  LOG03
                                     ,  stLineaComando.lCodCiclFact );

        if (!bfnEstadoProcCiclo(&iIndCiclo))
        {
            vDTrazasError(szExeInfCtlFactur,"Error en Recuperar Estado del Proceso de Facturacion ",LOG01);
            return FALSE;
        }
        stLineaComando.iIndFacturacion = iIndCiclo;
        vDTrazasLog(szExeInfCtlFactur,  "\t Estado Ciclo de Facturacion [%d]",LOG03,iIndCiclo);
    }
    else
    {
        vDTrazasLog(szExeInfCtlFactur,  "\t\t\t Periodo de Facturacion %02ld-%04ld"
                                    ,   LOG03
                                    ,   stLineaComando.lMesEmision 
                                    ,   stLineaComando.lAnoEmision );
        sprintf(szhFecha1,  "%04ld%02ld01000000"
                        ,   stLineaComando.lMesEmision
                        ,   stLineaComando.lAnoEmision );
        sprintf(szhFecha2,  "%04ld%02ld01000000"
                        ,   (stLineaComando.lMesEmision+1>12?stLineaComando.lAnoEmision+1:stLineaComando.lAnoEmision)
                        ,   (stLineaComando.lMesEmision+1>12?1:stLineaComando.lMesEmision+1));

    }
    /************************************************************************/
    sprintf(szSelectSQL,
                "SELECT  F.IND_ORDENTOTAL , "
                        "F.COD_CLIENTE    , "
                        "F.COD_TIPDOCUM   , "
                        "F.IND_FACTUR     , "
                        "F.IND_SUPERTEL   , "
                        "F.COD_DESPACHO   , "
                        "F.TOT_FACTURA      ");

    if (stLineaComando.iIndFacturacion == iIND_FACT_NOPROCESADO)
    {
        vDTrazasError(szExeInfCtlFactur,"Ciclo No ha Sido Procesado\n\t\tTermino Proceso..!!! ",LOG01);
        return FALSE;
    }
    
    if (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO)
    {
        sprintf(szFromSQL ,"FROM   FA_FACTDOCU_%ld F ", stLineaComando.lCodCiclFact);
        sprintf(szWhereSQL,"WHERE  F.TOT_FACTURA > 0 ");
    }
    
    if (stLineaComando.iIndFacturacion == iIND_FACT_TERMINADO)
    {
        sprintf(szFromSQL,  "FROM   FA_HISTDOCU F ");
        sprintf(szWhereSQL, "WHERE  F.FEC_EMISION     = '%s "
                            "AND    F.COD_CICLFACT    = %ld "
                            ,szhFecha1
                            ,stLineaComando.lCodCiclFact  );
    }
    sprintf(szCadenaSQL,"%s %s %s\0", szSelectSQL, szFromSQL, szWhereSQL);

    /* EXEC SQL PREPARE sql_CtlInf_Documentos FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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
        vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Prepare SQL (bfnCargaDoctos) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }   

    /* EXEC SQL DECLARE C_CURSOR_CTLINFDOC CURSOR FOR sql_CtlInf_Documentos; */ 

    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Declare Cursor (bfnCargaDoctos) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }    

    /* EXEC SQL OPEN C_CURSOR_CTLINFDOC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Open Cursor (bfnCargaDoctos) **"
                                        "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }    

    for (;;)
    {
        /* EXEC SQL 
            FETCH C_CURSOR_CTLINFDOC 
            INTO    :lhvIndOrdenTotal   ,
                    :lhvCodCliente      ,
                    :ihvCodTipDocum     ,
                    :ihvIndFactur       ,
                    :ihvIndSupertel     ,
                    :szvCodDespacho     ,
                    :dhvTotFactura      ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1000;
        sqlstm.offset = (unsigned int  )39;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lhvIndOrdenTotal;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lhvCodCliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)ihvCodTipDocum;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )sizeof(int);
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)ihvIndFactur;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)ihvIndSupertel;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )sizeof(int);
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szvCodDespacho;
        sqlstm.sqhstl[5] = (unsigned long )8;
        sqlstm.sqhsts[5] = (         int  )8;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)dhvTotFactura;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[6] = (         int  )sizeof(double);
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
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



        if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Fetch de Documentos (bfnCargaDoctos) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
        /************************************************************************/
        /*  Carga Doucmentos recuperados del Fetch en Arreglo Global en Memoria */
        /************************************************************************/
        iContFetch++;
        iContRowsFetchAux=SQLROWS-iContRowsFetch;
        iContRowsFetch=SQLROWS;
        if (iContRowsFetchAux <= 0)
        {
            /* EXEC SQL CLOSE C_CURSOR_CTLINFDOC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )82;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;
        }
        vDTrazasLog(szExeInfCtlFactur,  "\t\t**  Fetch Numero     [%d]"
                                        "\n\t\t Numero Registros      [%d]"
                                        "\n\t\t Registros Acumulados  [%d]"
                                       ,LOG03,iContFetch,iContRowsFetchAux,SQLROWS);
        for (i=0;i<iContRowsFetchAux;i++)              
        {
            stDetCtlInfDoctos.stUnivDoctos[iContRow].lIndOrdentotal    =   lhvIndOrdenTotal    [i] ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].lCodCliente       =   lhvCodCliente       [i] ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].lCodTipdocum      =   ihvCodTipDocum      [i] ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].iIndFactur        =   ihvIndFactur        [i] ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].iIndSupertel      =   ihvIndSupertel      [i] ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].lCodEmpresa       =   0                       ;
            stDetCtlInfDoctos.stUnivDoctos[iContRow].dTotFactura       =   dhvTotFactura       [i] ;
            sprintf(stDetCtlInfDoctos.stUnivDoctos[iContRow].szCodDespacho,"%.*s\0",szvCodDespacho[i].len,szvCodDespacho[i].arr);
            iContRow++;
        }
        if (SQLCODE == SQLNOTFOUND)
        {
            /* EXEC SQL CLOSE C_CURSOR_CTLINFDOC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )97;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


            break;
        }

    } /*  for (;;)  */
    stDetCtlInfDoctos.lNumDocumentos = iContRow;
    vDTrazasLog(szExeInfCtlFactur,   "\t**  Documentos Cargados   [%ld] **",LOG03,iContRow);
    return TRUE;                                                                               
}


/****************************************************************************/
/*  Funcion :   bfnCargaPlanFamiliar                                        */
/****************************************************************************/
BOOL bfnCargaPlanFamiliar()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodPlanTarif[MAX_REGPLAN_FAMILIAR][4];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    /* EXEC SQL    SELECT  COD_PLANTARIF 
                INTO    :szhCodPlanTarif
                FROM    TA_PLANTARIF
                WHERE   IND_FAMILIAR = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PLANTARIF into :b0  from TA_PLANTARIF where IN\
D_FAMILIAR=1";
    sqlstm.iters = (unsigned int  )1000;
    sqlstm.offset = (unsigned int  )112;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlFactur, "\n\tError en Select TA_PLANTARIF (bfnCargaPlanFamiliar)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        for (iNumRegPlanFamiliar = 0; iNumRegPlanFamiliar < SQLROWS; iNumRegPlanFamiliar++)
        {
            sprintf(szCodPlanTarifFamiliar[iNumRegPlanFamiliar],"%s\0",szhCodPlanTarif[iNumRegPlanFamiliar]);
            
            vDTrazasLog(szExeInfCtlFactur   ,"\t PLAN TARIFARIO FAMILIAR [%d][%s]"
                                            ,LOG04
                                            ,iNumRegPlanFamiliar
                                            ,szhCodPlanTarif[iNumRegPlanFamiliar]);
        }
        return TRUE;
    }
    vDTrazasError(szExeInfCtlFactur, "\n\tDesbordamiento de Arreglo de PLantes Tarifarios Familiar", LOG01);
    return FALSE;
}



/****************************************************************************/
/*  Funcion :   bfnEstadoProcCiclo                                          */
/****************************************************************************/
BOOL bfnEstadoProcCiclo(int* piIndCiclo)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     ihIndFacturacion;
    long    lhCodCiclFact   ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclFact = stLineaComando.lCodCiclFact;
    
    /* EXEC SQL    SELECT  IND_FACTURACION
                INTO    :ihIndFacturacion
                FROM    FA_CICLFACT
                WHERE   COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION into :b0  from FA_CICLFACT where C\
OD_CICLFACT=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )131;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndFacturacion;
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


    
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlFactur, "\n\tError en Select en FA_CICLFACT (bfnEstadoProcCiclo)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlFactur, "\n\tCodigo de Ciclo de Facturación No Valido (bfnEstadoProcCiclo)", LOG01);
        return FALSE;
    }
    *piIndCiclo=ihIndFacturacion;
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   bfnStatClientes                                             */
/****************************************************************************/
BOOL bfnStatClientes()
{
    char    szTipClie       [3] ="";
    int     iCont               = 0;
    int     iStat               = 0;

    memset(&stCtlInfCliente,0,sizeof(FACTLINFCLIENTES));
    
    vDTrazasLog(szExeInfCtlFactur,      "\n\t Analiza Estadisticas de Clientes ",LOG03);

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    for (iCont=0;iCont<stDetCtlInfDoctos.lNumDocumentos;iCont++)
    {
        /********************************************************************/
        /*  Analiza Tipo de Cliente en la Tabla GA_EMPRESA                  */
        /********************************************************************/
        if (!bfnValTipClie(stDetCtlInfDoctos.stUnivDoctos[iCont].lCodCliente,szTipClie))
        {
            vDTrazasError(szExeInfCtlFactur,  "\n\n\t**  Error en Declare Cursor (bfnCargaDoctos) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
        sprintf(stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie,"%s\0",szTipClie);
   
        vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnStatClientes) Valores de Documento "
                                         "\n\t\t** Ind Factur         [%d]"
                                         "\n\t\t** Ind Supertel       [%d]"
                                         "\n\t\t** Tipo Cliente       [%s]"
                                         "\n\t\t** Tipo Documento     [%ld]"
                                         "\n\t\t** Cod. Despacho      [%s]"
                                        ,LOG05
                                        ,stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur
                                        ,stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel
                                        ,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie
                                        ,stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum
                                        ,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho);
        
        /********************************************************************/
        /*  Valida si existe Combinacion de Estadistica generada            */
        /********************************************************************/
        for (iStat=0;iStat<stCtlInfCliente.lNumStadisticas;iStat++)
        {
            if ((stCtlInfCliente.stUnivClie[iStat].iIndFactur    == stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur            ) &&
                (stCtlInfCliente.stUnivClie[iStat].iIndSupertel  == stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel          ) &&
                (strcmp(stCtlInfCliente.stUnivClie[iStat].szCodTipClie,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie)==0   ) &&
                (stCtlInfCliente.stUnivClie[iStat].lCodTipdocum  == stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum          ) &&
                (strcmp(stCtlInfCliente.stUnivClie[iStat].szCodDespacho ,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho)==0) )
            {
            /********************************************************************/
            /*  Actualiza Combinacion de Estadistica                            */
            /********************************************************************/
                vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatClientes) Actualiza Estadistica [%d] Docto [%d]"
                                                ,LOG05,iStat,iCont);
                                            
                stCtlInfCliente.stUnivClie[iStat].dTotFactura     += stDetCtlInfDoctos.stUnivDoctos[iCont].dTotFactura;
                stCtlInfCliente.stUnivClie[iStat].lNumClientes    ++;
                stCtlInfCliente.stUnivClie[iStat].lNumDoctos      ++;
                break;
            }
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatClientes) Incrementa iStat [%d]",LOG05,iStat);
        }
        
        /********************************************************************/
        /*  Agrega Nueva Combinacion de Estadistica                         */
        /********************************************************************/
        if (iStat == stCtlInfCliente.lNumStadisticas || stCtlInfCliente.lNumStadisticas == 0)
        {
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatClientes) Agrega Nuevo Estadistica [%ld] iStat[%d]"
                                            ,LOG05,stCtlInfCliente.lNumStadisticas,iStat);
            
            stCtlInfCliente.stUnivClie[iStat].iIndFactur      = 
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur;
            stCtlInfCliente.stUnivClie[iStat].iIndSupertel    =
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel;
            sprintf(stCtlInfCliente.stUnivClie[iStat].szCodTipClie,"%s\0",
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie);
            stCtlInfCliente.stUnivClie[iStat].lCodTipdocum    = 
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum;
            sprintf(stCtlInfCliente.stUnivClie[iStat].szCodDespacho,"%s\0",
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho);
            stCtlInfCliente.stUnivClie[iStat].dTotFactura     += 
                                                    stDetCtlInfDoctos.stUnivDoctos[iCont].dTotFactura;
            stCtlInfCliente.stUnivClie[iStat].lNumClientes    ++;
            stCtlInfCliente.stUnivClie[iStat].lNumDoctos      ++;
            stCtlInfCliente.lNumStadisticas++;
        }
    } /*  for (iCont=0....    */
    return (TRUE);
}



/****************************************************************************/
/*  Funcion :   bfnInsertStatClientes                                       */
/****************************************************************************/
BOOL bfnInsertStatClientes()
{
    int i=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    long    lhNumClientes       ;
    long    lhNumDoctos         ;
    double  dhTotFacturable     ;    
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertStatClientes) [%d]",LOG03,stCtlInfCliente.lNumStadisticas);
    
    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo = lhNumSecuenciaInforme;
    
    for (i=0;i<stCtlInfCliente.lNumStadisticas;i++)
    {
        ihIndFactur     =   stCtlInfCliente.stUnivClie[i].iIndFactur;
        ihIndSupertel   =   stCtlInfCliente.stUnivClie[i].iIndSupertel;
        sprintf(szhCodTipClie,"%s\0",stCtlInfCliente.stUnivClie[i].szCodTipClie);
        lhCodTipDocum   =   stCtlInfCliente.stUnivClie[i].lCodTipdocum;
        sprintf(szhCodDespacho,"%s\0",stCtlInfCliente.stUnivClie[i].szCodDespacho);
        lhNumClientes   =   stCtlInfCliente.stUnivClie[i].lNumDoctos;
        lhNumDoctos     =   stCtlInfCliente.stUnivClie[i].lNumDoctos;
        dhTotFacturable =   stCtlInfCliente.stUnivClie[i].dTotFactura;
        
        /* EXEC SQL INSERT INTO FAD_CTLINFCLIE (
                    COD_INFORME     ,
                    NUM_SECUINFO    ,
                    IND_FACTUR      ,
                    IND_SUPERTEL    ,
                    COD_TIPCLIE     ,
                    COD_TIPDOCUM    ,
                    COD_DESPACHO    ,
                    NUM_CLIENTES    ,
                    NUM_DOCUMENTOS  ,
                    IMP_FACTURABLE  )
        VALUES (    :szhCodInforme  ,
                    :lhNumSecuInfo  ,
                    :ihIndFactur    ,
                    :ihIndSupertel  ,
                    :szhCodTipClie  ,
                    :lhCodTipDocum  ,
                    :szhCodDespacho ,
                    :lhNumClientes  ,
                    :lhNumDoctos    ,
                    :dhTotFacturable); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAD_CTLINFCLIE (COD_INFORME,NUM_SECUINFO,\
IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,NUM_CLIENTES,NUM\
_DOCUMENTOS,IMP_FACTURABLE) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )154;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lhNumClientes;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhNumDoctos;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&dhTotFacturable;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
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
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnInsertStatClientes) Error En Insert de Estadisticas "
                                             "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnValTipClie                                               */
/****************************************************************************/
BOOL bfnValTipClie(long lCodClie, char * pszTipClie)
{
    int i=0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodPlanTarif[4];
    long    lhCodCliente      ;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    lhCodCliente = lCodClie;
    
    /* EXEC SQL    SELECT  COD_PLANTARIF 
                INTO    :szhCodPlanTarif
                FROM    GA_EMPRESA
                WHERE   COD_CLIENTE = :lhCodCliente
                AND     ROWNUM = 1      ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_PLANTARIF into :b0  from GA_EMPRESA where (COD\
_CLIENTE=:b1 and ROWNUM=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )209;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodPlanTarif;
    sqlstm.sqhstl[0] = (unsigned long )4;
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


        
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasError(szExeInfCtlFactur, "\n\tError en Select GA_EMPRESA (bfnValTipClie)", LOG01);
        return FALSE;
    }
    if(SQLCODE == SQLNOTFOUND)
    {
        sprintf(pszTipClie,"I\0");
        return TRUE;
    }
    sprintf(pszTipClie,"E\0");
    for (i=0;i<iNumRegPlanFamiliar;i++)
    {
        if (strcmp(szCodPlanTarifFamiliar[i],szhCodPlanTarif)==0)
        {
            sprintf(pszTipClie,"F\0");
            break;
        }
    }
    return TRUE;
}



/****************************************************************************/
/*  Funcion :   vPrintStClientes                                            */
/****************************************************************************/
void vPrintStClientes()
{
    int i=0;
    vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(vPrintStClientes) Estadisticas de Clientes [%d]",LOG03,stCtlInfCliente.lNumStadisticas);
    for (i=0;i<stCtlInfCliente.lNumStadisticas;i++)
    {
        vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t[%d]** Ind Factur     [%d]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].iIndFactur);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Ind Supertel   [%d]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].iIndSupertel);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Clie       [%s]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].szCodTipClie);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Docuem     [%ld]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].lCodTipdocum);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Despacho   [%s]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].szCodDespacho);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tot Factura    [%.f]",LOG03,i
                                        ,stCtlInfCliente.stUnivClie[i].dTotFactura);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Num Documentos [%ld]",LOG03,i          
                                        ,stCtlInfCliente.stUnivClie[i].lNumDoctos);
    }
}



/****************************************************************************/
/*  Funcion :   bfnStatAbonados                                             */
/****************************************************************************/
BOOL bfnStatAbonados()
{
    int     iCont               = 0;
    int     iStat               = 0;
    int     iAbon               = 0;

    memset(&stCtlInfAbonados,0,sizeof(FACTLINFABONADOS));
    
    vDTrazasLog(szExeInfCtlFactur,      "\n\t Analiza Estadisticas de Abonados ",LOG03);

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    for (iCont=0;iCont<stDetCtlInfDoctos.lNumDocumentos;iCont++)
    {
        memset(&stDetCtlInfAbon,0, sizeof(FADETABONADOS));
        if (!bfnCargaAbonados(stDetCtlInfDoctos.stUnivDoctos[iCont], &stDetCtlInfAbon))
        {
            return FALSE;    
        }
        /************************************************************************************/
        /*  Por cada Abonado seleccionado del documento revisar las estadisticas generadas  */
        /************************************************************************************/
        for(iAbon=0; iAbon < stDetCtlInfAbon.lNumAbonados;iAbon++)
        {
            /************************************************************************/
            /*  Copia Valores del Documento en Estructura de Abonados               */
            /************************************************************************/
            vDTrazasLog(szExeInfCtlFactur  ,"\t\t**(bfnStatAbonados) Valores de Abonados Docto [%d] Abon [%d]"
                                            "\n\t\t\t** Ind Factur         [%d]"
                                            "\n\t\t\t** Ind Supertel       [%d]"
                                            "\n\t\t\t** Tipo Cliente       [%s]"
                                            "\n\t\t\t** Tipo Documento     [%ld]"
                                            "\n\t\t\t** Cod. Despacho      [%s]"
                                            "\n\t\t\t** Cod. Producto      [%d]"
                                            ,LOG05
                                            ,iCont,iAbon
                                            ,stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur
                                            ,stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel
                                            ,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie
                                            ,stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum
                                            ,stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho
                                            ,stDetCtlInfAbon.stUnivAbon[iAbon].iCodProducto  );
        
            /********************************************************************/
            /* Valida si existe Combinacion de Estadistica de Abonados generada */
            /********************************************************************/
            for (iStat=0;iStat < stCtlInfAbonados.lNumStadisticas;iStat++)
            {
            vDTrazasLog(szExeInfCtlFactur  ,"\t\t**(bfnStatAbonados) Valores de Estadisticas stCtlInfAbonados.stUnivStatAbon"
                                            "\n\t\t\t[%d]** Ind Factur         [%d]"
                                            "\n\t\t\t[%d]** Ind Supertel       [%d]"
                                            "\n\t\t\t[%d]** Tipo Cliente       [%s]"
                                            "\n\t\t\t[%d]** Tipo Documento     [%ld]"
                                            "\n\t\t\t[%d]** Cod. Despacho      [%s]"
                                            "\n\t\t\t[%d]** Cod. Producto      [%d]"
                                            ,LOG05
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].iIndFactur 
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].iIndSupertel
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].szCodTipClie
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].lCodTipdocum
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].szCodDespacho
                                            ,iStat,stCtlInfAbonados.stUnivStatAbon[iStat].iCodProducto  );

                if ((stCtlInfAbonados.stUnivStatAbon[iStat].iIndFactur          ==
                                stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur         )   &&
                    (stCtlInfAbonados.stUnivStatAbon[iStat].iIndSupertel        ==
                                stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel       )   &&
                    (strcmp(stCtlInfAbonados.stUnivStatAbon[iStat].szCodTipClie ,   
                                stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie   )==0)   &&
                    (stCtlInfAbonados.stUnivStatAbon[iStat].lCodTipdocum        ==
                                stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum       )   &&
                    (strcmp(stCtlInfAbonados.stUnivStatAbon[iStat].szCodDespacho,   
                                stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho  )==0)   &&
                    (stCtlInfAbonados.stUnivStatAbon[iStat].iCodProducto        ==  
                                stDetCtlInfAbon.stUnivAbon[iAbon].iCodProducto       )   )  
                {
                    /********************************************************************/
                    /*  Actualiza Combinacion de Estadistica                            */
                    /********************************************************************/
                    vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatAbonados) Actualiza Estadistica [%d] Documento [%d]"
                                                    ,LOG05,iStat,iCont);
                    stCtlInfAbonados.stUnivStatAbon[iStat].dTotCargosMes    += stDetCtlInfAbon.stUnivAbon[iAbon].dTotCargosMes;
                    stCtlInfAbonados.stUnivStatAbon[iStat].lNumAbonados     += stDetCtlInfAbon.stUnivAbon[iAbon].lNumAbonados ;
                    break;
                }
            
            }  /* for (iStat=0....    */
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatAbonados) Incrementa iStat [%d]",LOG05,iStat);

            /********************************************************************/
            /*  Agrega Nueva Combinacion de Estadistica                         */
            /********************************************************************/
            if (iStat == stCtlInfAbonados.lNumStadisticas || stCtlInfAbonados.lNumStadisticas == 0)
            {
                vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatAbonados) Agrega Nuevo Estadistica [%ld] iStat [%d]"
                                                ,LOG05,stCtlInfAbonados.lNumStadisticas,iStat);
    
                stCtlInfAbonados.stUnivStatAbon[iStat].iIndFactur       = stDetCtlInfDoctos.stUnivDoctos[iCont].iIndFactur   ;
                stCtlInfAbonados.stUnivStatAbon[iStat].iIndSupertel     = stDetCtlInfDoctos.stUnivDoctos[iCont].iIndSupertel ;
                sprintf(stCtlInfAbonados.stUnivStatAbon[iStat].szCodTipClie,"%s\0",stDetCtlInfDoctos.stUnivDoctos[iCont].szCodTipClie);
                stCtlInfAbonados.stUnivStatAbon[iStat].lCodTipdocum     = stDetCtlInfDoctos.stUnivDoctos[iCont].lCodTipdocum ;
                sprintf(stCtlInfAbonados.stUnivStatAbon[iStat].szCodDespacho,"%s\0",stDetCtlInfDoctos.stUnivDoctos[iCont].szCodDespacho);
                stCtlInfAbonados.stUnivStatAbon[iStat].iCodProducto     = stDetCtlInfAbon.stUnivAbon[iAbon].iCodProducto;
                stCtlInfAbonados.stUnivStatAbon[iStat].dTotCargosMes   += stDetCtlInfAbon.stUnivAbon[iAbon].dTotCargosMes;
                stCtlInfAbonados.stUnivStatAbon[iStat].lNumAbonados    += stDetCtlInfAbon.stUnivAbon[iAbon].lNumAbonados ;
                stCtlInfAbonados.lNumStadisticas++;
            }
        } /*  ( for iAbon=0 .....  )   */
    } /*  for ( iCont=0....    */
    return (TRUE);
}


/****************************************************************************/
/*  Funcion :   bfnCargaAbonados                                            */
/****************************************************************************/
BOOL bfnCargaAbonados(FACTLDOC stCtlDoctos, FADETABONADOS *pstDetCtlInfAbo)
{
    int     iContRowsFetch      = 0;
    int     iContRowsFetchAux   = 0;
    int     iContRow            = 0;
    int     iRow                = 0;
    char    szCadenaSQL [1024]  ="";
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    long    lhIndOrdentotal;
    long    alhNumAbonados  [MAX_ABONADOS_CONTROL] ;
    int     aihCodProducto  [MAX_ABONADOS_CONTROL] ;
    double  adhTotCargosMes [MAX_ABONADOS_CONTROL] ;   
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    lhIndOrdentotal = stCtlDoctos.lIndOrdentotal;
    
    vDTrazasLog(szExeInfCtlFactur,  "\n\t**(bfnCargaAbonados)  Ind Orden Total [%ld]) **",LOG04,lhIndOrdentotal);


    if (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO)
    {
        sprintf(szCadenaSQL,
        "SELECT DECODE(COD_PRODUCTO,1,1,5,5,2,DECODE(COD_NEGO,NULL,2,3,3)) AS COD_PRODUCTO, "
                "SUM(TOT_CARGOSME) ,"
                "COUNT(NUM_ABONADO) "
        "FROM   " 
              "(SELECT   COD_PRODUCTO,  "
                        "DECODE(SUBSTR(NUM_BEEPER,1,1) ,'9',3) AS       COD_NEGO,"
                        "TOT_CARGOSME,  "
                        "NUM_ABONADO    "
                "FROM   FA_FACTABON_%ld "
                "WHERE  IND_ORDENTOTAL = :v0 "
                "AND    NUM_CELULAR IS NOT NULL) "
        "GROUP BY DECODE(COD_PRODUCTO,1,1,5,5,2,DECODE(COD_NEGO,NULL,2,3,3))\0", stLineaComando.lCodCiclFact);

        vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Query (bfnCargaAbonados) **"
                                        "\n\t\t [%s]",LOG06,szCadenaSQL);

        /* EXEC SQL PREPARE sql_CtlInf_Abonados FROM :szCadenaSQL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )232;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
        sqlstm.sqhstl[0] = (unsigned long )1024;
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
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Prepare SQL (bfnCargaAbonados) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   

        /* EXEC SQL DECLARE C_CURSOR_CTLINFABO CURSOR FOR sql_CtlInf_Abonados; */ 

        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Declare Cursor (bfnCargaAbonados) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }    

        /* EXEC SQL OPEN C_CURSOR_CTLINFABO USING :lhIndOrdentotal; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )251;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdentotal;
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


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Open Cursor (bfnCargaAbonados) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }

        for (;;)
        {
            /* EXEC SQL 
                FETCH C_CURSOR_CTLINFABO 
                INTO    :aihCodProducto     ,
                        :adhTotCargosMes    ,
                        :alhNumAbonados     ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 10;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )10000;
            sqlstm.offset = (unsigned int  )270;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)aihCodProducto;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )sizeof(int);
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)adhTotCargosMes;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[1] = (         int  )sizeof(double);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)alhNumAbonados;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )sizeof(long);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
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



            if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
            {
                vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Fetch de Abonados (bfnCargaAbonados) **"
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
                return FALSE;
            }
            /************************************************************************/
            /*  Carga Doucmentos recuperados del Fetch en Arreglo Global en Memoria */
            /************************************************************************/
            iContRowsFetchAux=SQLROWS-iContRowsFetch;
            iContRowsFetch=SQLROWS;
            if (iContRowsFetchAux <= 0)
            {
                /* EXEC SQL CLOSE C_CURSOR_CTLINFABO; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 10;
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


                break;
            }
            vDTrazasLog(szExeInfCtlFactur,  "\n\t\t(bfnCargaAbonados)**  Numero Registros  [%4d]   Registros Acumulados  [%4d]"
                                           ,LOG05,iContRowsFetchAux,SQLROWS);
            for (iRow=0;iRow<iContRowsFetchAux;iRow++)              
            {
                pstDetCtlInfAbo->stUnivAbon[iContRow].lNumAbonados   = alhNumAbonados  [iRow];
                pstDetCtlInfAbo->stUnivAbon[iContRow].iCodProducto   = aihCodProducto  [iRow];
                pstDetCtlInfAbo->stUnivAbon[iContRow].dTotCargosMes  = adhTotCargosMes [iRow];
                iContRow++;
            }
            if (SQLCODE == SQLNOTFOUND)
            {
                /* EXEC SQL CLOSE C_CURSOR_CTLINFABO; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 10;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )312;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                break;
            }
        } /*  for (;;)  */
    } /* (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO) */
    
    pstDetCtlInfAbo->lNumAbonados = iContRow;
    vDTrazasLog(szExeInfCtlFactur,   "\t\t(bfnCargaAbonados)**  Abonados Cargados   [%ld] **",LOG04,iContRow);
    return TRUE;                                                                               
}   
    
    
    
/****************************************************************************/
/*  Funcion :   bfnInsertStatAbonados                                       */
/****************************************************************************/
BOOL bfnInsertStatAbonados()
{
    int iStat=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    int     ihCodProducto       ;
    long    lhNumAbonados       ;
    double  dhTotFacturable     ;    
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertStatAbonados) [%d]",LOG03,stCtlInfAbonados.lNumStadisticas);
    
    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo = lhNumSecuenciaInforme;
    
    for (iStat=0;iStat<stCtlInfAbonados.lNumStadisticas;iStat++)
    {
        ihIndFactur             =           stCtlInfAbonados.stUnivStatAbon[iStat].iIndFactur   ;
        ihIndSupertel           =           stCtlInfAbonados.stUnivStatAbon[iStat].iIndSupertel ;
        sprintf(szhCodTipClie   ,   "%s\0", stCtlInfAbonados.stUnivStatAbon[iStat].szCodTipClie );
        lhCodTipDocum           =           stCtlInfAbonados.stUnivStatAbon[iStat].lCodTipdocum ;
        sprintf(szhCodDespacho  ,   "%s\0", stCtlInfAbonados.stUnivStatAbon[iStat].szCodDespacho);
        ihCodProducto           =           stCtlInfAbonados.stUnivStatAbon[iStat].iCodProducto ;
        lhNumAbonados           =           stCtlInfAbonados.stUnivStatAbon[iStat].lNumAbonados ;
        dhTotFacturable         =           stCtlInfAbonados.stUnivStatAbon[iStat].dTotCargosMes;
        
        /* EXEC SQL INSERT INTO FAD_CTLINFABON (
                    COD_INFORME     ,
                    NUM_SECUINFO    ,
                    IND_FACTUR      ,
                    IND_SUPERTEL    ,
                    COD_TIPCLIE     ,
                    COD_TIPDOCUM    ,
                    COD_DESPACHO    ,
                    COD_PRODUCTO    ,
                    NUM_ABONADOS    ,
                    IMP_FACTURABLE  )
        VALUES (    :szhCodInforme  ,
                    :lhNumSecuInfo  ,
                    :ihIndFactur    ,
                    :ihIndSupertel  ,
                    :szhCodTipClie  ,
                    :lhCodTipDocum  ,
                    :szhCodDespacho ,
                    :ihCodProducto  ,
                    :lhNumAbonados  ,
                    :dhTotFacturable); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAD_CTLINFABON (COD_INFORME,NUM_SECUINFO,\
IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_PRODUCTO,NUM\
_ABONADOS,IMP_FACTURABLE) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )327;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAbonados;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&dhTotFacturable;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
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
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnInsertStatAbonados) Error En Insert de Estadisticas Abonados"
                                             "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   vPrintStAbonados                                            */
/****************************************************************************/
void vPrintStAbonados()
{
    int i=0;
    vDTrazasLog(szExeInfCtlFactur   ,"\n\n\t\t**(vPrintStAbonados) Estadisticas de Abonados [%d]",LOG03,stCtlInfAbonados.lNumStadisticas);
    for (i=0;i<stCtlInfAbonados.lNumStadisticas;i++)
    {
        vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t[%d]** Ind Factur     [%d]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].iIndFactur);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Ind Supertel   [%d]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].iIndSupertel);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Clie       [%s]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].szCodTipClie);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Docuem     [%ld]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].lCodTipdocum);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Despacho   [%s]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].szCodDespacho);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Producto   [%d]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].iCodProducto);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tot Factura    [%.f]",LOG03,i
                                        ,stCtlInfAbonados.stUnivStatAbon[i].dTotCargosMes);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Num Documentos [%ld]",LOG03,i          
                                        ,stCtlInfAbonados.stUnivStatAbon[i].lNumAbonados);
    }
}


/****************************************************************************/
/*  Funcion :   bfnStatConceptos                                            */
/****************************************************************************/
BOOL bfnStatConceptos()
{
    int     iClie               = 0;
    int     iConc               = 0;
    int     iStat               = 0;

    memset(&stCtlInfConceptos,0,sizeof(FACTLINFCONCEPTOS));
    
    vDTrazasLog(szExeInfCtlFactur,      "\n\t Analiza Estadisticas de Conceptos ",LOG03);

    /************************************************************************/
    /*   Inicializa Valores de Variables                                    */
    /************************************************************************/
    for (iClie=0;iClie<stDetCtlInfDoctos.lNumDocumentos;iClie++)
    {
        
        memset(&stDetCtlInfConc,0, sizeof(FADETCONCEPTOS));
        if (!bfnCargaConceptos(stDetCtlInfDoctos.stUnivDoctos[iClie], &stDetCtlInfConc))
        {
            return FALSE;    
        }
        /************************************************************************************/
        /*  Por cada Abonado seleccionado del documento revisar las estadisticas generadas  */
        /************************************************************************************/
        for(iConc=0; iConc < stDetCtlInfConc.lNumConceptos;iConc++)
        {
            /************************************************************************/
            /*  Copia Valores del Documento en Estructura de Abonados               */
            /************************************************************************/
            vDTrazasLog(szExeInfCtlFactur  ,"\t\t**(bfnStatConceptos) Valores de Conceptos del Docto [%d] Abon [%d]"
                                            "\n\t\t\t** Ind Factur         [%d]"
                                            "\n\t\t\t** Ind Supertel       [%d]"
                                            "\n\t\t\t** Tipo Cliente       [%s]"
                                            "\n\t\t\t** Tipo Documento     [%ld]"
                                            "\n\t\t\t** Cod. Despacho      [%s]"
                                            "\n\t\t\t** Cod. CiclFact      [%ld]"
                                            "\n\t\t\t** Cod. Producto      [%d]"
                                            "\n\t\t\t** Cod. Concepto      [%d]"
                                            ,LOG05
                                            ,iClie,iConc
                                            ,stDetCtlInfDoctos.stUnivDoctos[iClie].iIndFactur
                                            ,stDetCtlInfDoctos.stUnivDoctos[iClie].iIndSupertel
                                            ,stDetCtlInfDoctos.stUnivDoctos[iClie].szCodTipClie
                                            ,stDetCtlInfDoctos.stUnivDoctos[iClie].lCodTipdocum
                                            ,stDetCtlInfDoctos.stUnivDoctos[iClie].szCodDespacho
                                            ,stDetCtlInfConc.stUnivConc[iConc].lCodCiclFact
                                            ,stDetCtlInfConc.stUnivConc[iConc].iCodProducto
                                            ,stDetCtlInfConc.stUnivConc[iConc].iCodConcepto  );
        
            /********************************************************************/
            /* Valida si existe Combinacion de Estadistica de Abonados generada */
            /********************************************************************/
            for (iStat=0;iStat < stCtlInfConceptos.lNumStadisticas;iStat++)
            {
            vDTrazasLog(szExeInfCtlFactur  ,"\t\t**(bfnStatConceptos) Valores de Estadisticas stCtlInfConceptos.stUnivStatConc"
                                            "\n\t\t\t[%d]** Ind Factur         [%d]"
                                            "\n\t\t\t[%d]** Ind Supertel       [%d]"
                                            "\n\t\t\t[%d]** Tipo Cliente       [%s]"
                                            "\n\t\t\t[%d]** Tipo Documento     [%ld]"
                                            "\n\t\t\t[%d]** Cod. Despacho      [%s]"
                                            "\n\t\t\t[%d]** Cod. CiclFact      [%ld]"
                                            "\n\t\t\t[%d]** Cod. Producto      [%d]"
                                            "\n\t\t\t[%d]** Cod. Concepto      [%d]"
                                            ,LOG05
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].iIndFactur 
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].iIndSupertel
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].szCodTipClie
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].lCodTipdocum
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].szCodDespacho
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].lCodCiclFact
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].iCodProducto
                                            ,iStat,stCtlInfConceptos.stUnivStatConc[iStat].iCodConcepto  );

                if ((stCtlInfConceptos.stUnivStatConc[iStat].iIndFactur          ==
                                stDetCtlInfDoctos.stUnivDoctos[iClie].iIndFactur         )   &&
                    (stCtlInfConceptos.stUnivStatConc[iStat].iIndSupertel        ==
                                stDetCtlInfDoctos.stUnivDoctos[iClie].iIndSupertel       )   &&
                    (strcmp(stCtlInfConceptos.stUnivStatConc[iStat].szCodTipClie ,   
                                stDetCtlInfDoctos.stUnivDoctos[iClie].szCodTipClie   )==0)   &&
                    (stCtlInfConceptos.stUnivStatConc[iStat].lCodTipdocum        ==
                                stDetCtlInfDoctos.stUnivDoctos[iClie].lCodTipdocum       )   &&
                    (strcmp(stCtlInfConceptos.stUnivStatConc[iStat].szCodDespacho,   
                                stDetCtlInfDoctos.stUnivDoctos[iClie].szCodDespacho  )==0)   &&
                    (stCtlInfConceptos.stUnivStatConc[iStat].lCodCiclFact        ==  
                                stDetCtlInfConc.stUnivConc[iConc].lCodCiclFact           )   &&
                    (stCtlInfConceptos.stUnivStatConc[iStat].iCodProducto        ==  
                                stDetCtlInfConc.stUnivConc[iConc].iCodProducto           )   &&
                    (stCtlInfConceptos.stUnivStatConc[iStat].iCodConcepto==  
                                stDetCtlInfConc.stUnivConc[iConc].iCodConcepto           )  )
                {
                    /********************************************************************/
                    /*  Actualiza Combinacion de Estadistica                            */
                    /********************************************************************/
                    vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatConceptos) Actualiza Estadistica [%d] Documento [%d]"
                                                    ,LOG05,iStat,iClie);
                    stCtlInfConceptos.stUnivStatConc[iStat].dImpFacturable  += stDetCtlInfConc.stUnivConc[iConc].dImpFacturable;
                    stCtlInfConceptos.stUnivStatConc[iStat].lNumConceptos   += stDetCtlInfConc.stUnivConc[iConc].lNumConceptos ;
                    stCtlInfConceptos.stUnivStatConc[iStat].lSegConsumido   += stDetCtlInfConc.stUnivConc[iConc].lSegConsumido ;
                    break;
                }
            
            }  /* for (iStat=0....    */
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatConceptos) Incrementa iStat [%d]",LOG05,iStat);

            /********************************************************************/
            /*  Agrega Nueva Combinacion de Estadistica                         */
            /********************************************************************/
            if (iStat == stCtlInfConceptos.lNumStadisticas || stCtlInfConceptos.lNumStadisticas == 0)
            {
                vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnStatConceptos) Agrega Nuevo Estadistica [%ld] iStat [%d]"
                                                ,LOG05,stCtlInfConceptos.lNumStadisticas,iStat);
    
                stCtlInfConceptos.stUnivStatConc[iStat].iIndFactur       = stDetCtlInfDoctos.stUnivDoctos[iClie].iIndFactur   ;
                stCtlInfConceptos.stUnivStatConc[iStat].iIndSupertel     = stDetCtlInfDoctos.stUnivDoctos[iClie].iIndSupertel ;
                sprintf(stCtlInfConceptos.stUnivStatConc[iStat].szCodTipClie,"%s\0",stDetCtlInfDoctos.stUnivDoctos[iClie].szCodTipClie);
                stCtlInfConceptos.stUnivStatConc[iStat].lCodTipdocum     = stDetCtlInfDoctos.stUnivDoctos[iClie].lCodTipdocum ;
                sprintf(stCtlInfConceptos.stUnivStatConc[iStat].szCodDespacho,"%s\0",stDetCtlInfDoctos.stUnivDoctos[iClie].szCodDespacho);
                stCtlInfConceptos.stUnivStatConc[iStat].lCodCiclFact     = stDetCtlInfConc.stUnivConc[iConc].lCodCiclFact;
                stCtlInfConceptos.stUnivStatConc[iStat].iCodProducto     = stDetCtlInfConc.stUnivConc[iConc].iCodProducto;
                stCtlInfConceptos.stUnivStatConc[iStat].iCodConcepto     = stDetCtlInfConc.stUnivConc[iConc].iCodConcepto;
                stCtlInfConceptos.stUnivStatConc[iStat].lNumConceptos   += stDetCtlInfConc.stUnivConc[iConc].lNumConceptos ;
                stCtlInfConceptos.stUnivStatConc[iStat].dImpFacturable  += stDetCtlInfConc.stUnivConc[iConc].dImpFacturable;
                stCtlInfConceptos.stUnivStatConc[iStat].lSegConsumido   += stDetCtlInfConc.stUnivConc[iConc].lSegConsumido ;
                stCtlInfConceptos.lNumStadisticas++;
            }
        } /*  ( for iConc=0 .....  )   */
    } /*  for ( iClie=0....    */
    return (TRUE);
}




/****************************************************************************/
/*  Funcion :   bfnCargaConceptos                                           */
/****************************************************************************/
BOOL bfnCargaConceptos(FACTLDOC stCtlDoctos, FADETCONCEPTOS *pstDetCtlInfConc)
{
    int     iContRowsFetch      = 0;
    int     iContRowsFetchAux   = 0;
    int     iContRow            = 0;
    int     iRow                = 0;
    char    szCadenaSQL [1024]  ="";
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    long    lhIndOrdentotal;
    int     aihCodConcepto    [MAX_CONCEPTOS_CONTROL];
    int     aihCodProducto    [MAX_CONCEPTOS_CONTROL];
    long    alhCodCiclFact    [MAX_CONCEPTOS_CONTROL];
    long    alhNumConceptos   [MAX_CONCEPTOS_CONTROL];
    double  adhImpFacturable  [MAX_CONCEPTOS_CONTROL];
    long    alhSegConsumido   [MAX_CONCEPTOS_CONTROL];
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    lhIndOrdentotal = stCtlDoctos.lIndOrdentotal;
    
    vDTrazasLog(szExeInfCtlFactur,  "\n\t**(bfnCargaConceptos)  Ind Orden Total [%ld]) **",LOG04,lhIndOrdentotal);


    if (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO)
    {
        sprintf(szCadenaSQL,
        "SELECT  COD_CONCEPTO           COD_CONCEPTO    ,"
                "COD_PRODUCTO           COD_PRODUCTO    ,"
                "COUNT(COD_CONCEPTO)    NUM_CONCEPTOS   ,"
                "SUM(IMP_FACTURABLE)    IMP_FACTURABLE  ,"
                "SUM(SEG_CONSUMIDO)     SEG_CONSUMIDOS   "
        "FROM   FA_FACTCONC_%ld "
        "WHERE  IND_ORDENTOTAL = :v0 "
        "AND    IMP_FACTURABLE != 0 "
        "GROUP BY COD_CONCEPTO, COD_PRODUCTO \0" , stLineaComando.lCodCiclFact);

        vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Query (bfnCargaConceptos) **"
                                        "\n\t\t [%s]",LOG06,szCadenaSQL);

        /* EXEC SQL PREPARE sql_CtlInf_Conceptos FROM :szCadenaSQL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )382;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
        sqlstm.sqhstl[0] = (unsigned long )1024;
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
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Prepare SQL (bfnCargaConceptos) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   

        /* EXEC SQL DECLARE C_CURSOR_CTLINFCONC CURSOR FOR sql_CtlInf_Conceptos; */ 

        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Declare Cursor (bfnCargaConceptos) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }    

        /* EXEC SQL OPEN C_CURSOR_CTLINFCONC USING :lhIndOrdentotal; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 10;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )401;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdentotal;
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


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Open Cursor (bfnCargaConceptos) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }

        for (;;)
        {
            /* EXEC SQL 
                FETCH C_CURSOR_CTLINFCONC 
                INTO    :aihCodConcepto   ,
                        :aihCodProducto   ,
                        :alhNumConceptos  ,
                        :adhImpFacturable ,
                        :alhSegConsumido  ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 10;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )50000;
            sqlstm.offset = (unsigned int  )420;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)aihCodConcepto;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )sizeof(int);
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)aihCodProducto;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )sizeof(int);
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)alhNumConceptos;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )sizeof(long);
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)adhImpFacturable;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
            sqlstm.sqhsts[3] = (         int  )sizeof(double);
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)alhSegConsumido;
            sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[4] = (         int  )sizeof(long);
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
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



            if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
            {
                vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Fetch de Conceptos (bfnCargaConceptos) **"
                                                "\n\t\t Error Oracle [%d] [%s]"
                                                ,LOG01,SQLCODE,SQLERRM);
                return FALSE;
            }
            /************************************************************************/
            /*  Carga Doucmentos recuperados del Fetch en Arreglo Global en Memoria */
            /************************************************************************/
            iContRowsFetchAux=SQLROWS-iContRowsFetch;
            iContRowsFetch=SQLROWS;
            if (iContRowsFetchAux <= 0)
            {
                /* EXEC SQL CLOSE C_CURSOR_CTLINFCONC; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 10;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )455;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                break;
            }
            vDTrazasLog(szExeInfCtlFactur,  "\n\t\t(bfnCargaConceptos)**  Numero Registros  [%4d]   Registros Acumulados  [%4d]"
                                           ,LOG05,iContRowsFetchAux,SQLROWS);
            for (iRow=0;iRow<iContRowsFetchAux;iRow++)              
            {
                pstDetCtlInfConc->stUnivConc[iContRow].iCodConcepto    = aihCodConcepto   [iRow];
                pstDetCtlInfConc->stUnivConc[iContRow].iCodProducto    = aihCodProducto   [iRow];
                pstDetCtlInfConc->stUnivConc[iContRow].lCodCiclFact    = stLineaComando.lCodCiclFact;
                pstDetCtlInfConc->stUnivConc[iContRow].lNumConceptos   = alhNumConceptos  [iRow];
                pstDetCtlInfConc->stUnivConc[iContRow].dImpFacturable  = adhImpFacturable [iRow];
                pstDetCtlInfConc->stUnivConc[iContRow].lSegConsumido   = alhSegConsumido  [iRow];

                iContRow++;
            }
            if (SQLCODE == SQLNOTFOUND)
            {
                /* EXEC SQL CLOSE C_CURSOR_CTLINFCONC; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 10;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )470;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                break;
            }
        } /*  for (;;)  */
    } /* (stLineaComando.iIndFacturacion == iIND_FACT_ENPROCESO) */
    
    pstDetCtlInfConc->lNumConceptos = iContRow;
    vDTrazasLog(szExeInfCtlFactur,   "\t\t(bfnCargaConceptos)**  Conceptos Cargados   [%ld] **",LOG04,iContRow);
    return TRUE;                                                                               
}   
    
    
    
/****************************************************************************/
/*  Funcion :   bfnInsertStatConceptos                                      */
/****************************************************************************/
BOOL bfnInsertStatConceptos()
{
    int iStat=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7] ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo       ;
    int     ihIndFactur         ;
    int     ihIndSupertel       ;
    char    szhCodTipClie   [3] ;/* EXEC SQL VAR szhCodTipClie  IS STRING(3); */ 

    long    lhCodTipDocum       ;
    char    szhCodDespacho  [6] ;/* EXEC SQL VAR szhCodDespacho  IS STRING(6); */ 

    long    lhCodCiclFact       ;
    int     ihCodProducto       ;
    int     ihCodConcepto       ;
    long    lhNumConceptos      ;
    double  dhImpFacturable     ;
    long    lhSegConsumido      ;
    /* EXEC SQL END DECLARE SECTION ; */ 
    

    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertStatConceptos) [%d]",LOG03,stCtlInfConceptos.lNumStadisticas);
    
    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo = lhNumSecuenciaInforme;
    
    for (iStat=0;iStat<stCtlInfConceptos.lNumStadisticas;iStat++)
    {
        ihIndFactur             =   stCtlInfConceptos.stUnivStatConc[iStat].iIndFactur           ;
        ihIndSupertel           =   stCtlInfConceptos.stUnivStatConc[iStat].iIndSupertel         ;
        sprintf(szhCodTipClie   ,   "%s\0",stCtlInfConceptos.stUnivStatConc[iStat].szCodTipClie) ;
        lhCodTipDocum           =   stCtlInfConceptos.stUnivStatConc[iStat].lCodTipdocum         ;
        sprintf(szhCodDespacho  ,   "%s\0",stCtlInfConceptos.stUnivStatConc[iStat].szCodDespacho);
        lhCodCiclFact           =   stCtlInfConceptos.stUnivStatConc[iStat].lCodCiclFact  ;
        ihCodProducto           =   stCtlInfConceptos.stUnivStatConc[iStat].iCodProducto  ;
        ihCodConcepto           =   stCtlInfConceptos.stUnivStatConc[iStat].iCodConcepto  ;
        lhNumConceptos          =   stCtlInfConceptos.stUnivStatConc[iStat].lNumConceptos ;
        dhImpFacturable         =   stCtlInfConceptos.stUnivStatConc[iStat].dImpFacturable;
        lhSegConsumido          =   stCtlInfConceptos.stUnivStatConc[iStat].lSegConsumido ;
        lhSegConsumido          =   (lhSegConsumido/60);

        vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertStatConceptos) [%d]"
                                        "\n\t\t[%d]** Cod. Informe        [%s]"
                                        "\n\t\t[%d]** Secuencia Infortme  [%d]"
                                        "\n\t\t[%d]** Ind Factur          [%d]"
                                        "\n\t\t[%d]** Ind Supertel        [%d]"
                                        "\n\t\t[%d]** Tip Clie            [%s]"
                                        "\n\t\t[%d]** Tip Docuem          [%ld]"
                                        "\n\t\t[%d]** Cod Despacho        [%s]"
                                        "\n\t\t[%d]** Cod CiclFact        [%ld]"
                                        "\n\t\t[%d]** Cod Producto        [%d]"
                                        "\n\t\t[%d]** Cod Concepto        [%d]"
                                        "\n\t\t[%d]** Num. Conceptoa      [%ld]"
                                        "\n\t\t[%d]** Imp. Facturable     [%.f]"
                                        "\n\t\t[%d]** Seg. Consumidos     [%ld]"
                                        ,LOG05,stCtlInfConceptos.lNumStadisticas
                                        ,iStat, szhCodInforme  
                                        ,iStat, lhNumSecuInfo  
                                        ,iStat, ihIndFactur    
                                        ,iStat, ihIndSupertel  
                                        ,iStat, szhCodTipClie  
                                        ,iStat, lhCodTipDocum  
                                        ,iStat, szhCodDespacho 
                                        ,iStat, lhCodCiclFact  
                                        ,iStat, ihCodProducto  
                                        ,iStat, ihCodConcepto  
                                        ,iStat, lhNumConceptos 
                                        ,iStat, dhImpFacturable
                                        ,iStat, lhSegConsumido );

        /* EXEC SQL INSERT INTO FAD_CTLINFCONC(
                    COD_INFORME     ,
                    NUM_SECUINFO    ,
                    IND_FACTUR      ,
                    IND_SUPERTEL    ,
                    COD_TIPCLIE     ,
                    COD_TIPDOCUM    ,
                    COD_DESPACHO    ,
                    COD_PRODUCTO    ,
                    COD_CICLFACT    ,
                    COD_CONCEPTO    ,
                    NUM_CONCEPTOS   ,
                    IMP_FACTURABLE  ,
                    NUM_MINUTOS     )               
        VALUES (    :szhCodInforme  ,
                    :lhNumSecuInfo  ,
                    :ihIndFactur    ,
                    :ihIndSupertel  , 
                    :szhCodTipClie  ,
                    :lhCodTipDocum  ,
                    :szhCodDespacho ,
                    :ihCodProducto  ,
                    :lhCodCiclFact  ,
                    :ihCodConcepto  ,
                    :lhNumConceptos ,
                    :dhImpFacturable,
                    :lhSegConsumido ); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAD_CTLINFCONC (COD_INFORME,NUM_SECUINFO,\
IND_FACTUR,IND_SUPERTEL,COD_TIPCLIE,COD_TIPDOCUM,COD_DESPACHO,COD_PRODUCTO,COD\
_CICLFACT,COD_CONCEPTO,NUM_CONCEPTOS,IMP_FACTURABLE,NUM_MINUTOS) values (:b0,:\
b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )485;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
        sqlstm.sqhstl[0] = (unsigned long )7;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFactur;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihIndSupertel;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipClie;
        sqlstm.sqhstl[4] = (unsigned long )3;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodTipDocum;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhCodDespacho;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCiclFact;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&ihCodConcepto;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&lhNumConceptos;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhImpFacturable;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&lhSegConsumido;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
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
            vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnInsertStatConceptos) Error En Insert de Estadisticas Conceptos"
                                             "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
    }
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   vPrintStConceptos                                           */
/****************************************************************************/
void vPrintStConceptos()
{
    int i=0;
    vDTrazasLog(szExeInfCtlFactur   ,"\n\n\t\t**(vPrintStConceptos) Estadisticas de Conceptos [%d]",LOG03,stCtlInfConceptos.lNumStadisticas);
    for (i=0;i<stCtlInfConceptos.lNumStadisticas;i++)
    {
        vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t[%d]** Ind Factur        [%d]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].iIndFactur);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Ind Supertel       [%d]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].iIndSupertel);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Clie           [%s]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].szCodTipClie);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Tip Docuem         [%ld]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].lCodTipdocum);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Despacho       [%s]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].szCodDespacho);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod CiclFact       [%ld]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].lCodCiclFact);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Producto       [%d]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].iCodProducto);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Cod Concepto       [%d]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].iCodConcepto);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Num. Conceptoa     [%ld]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].lNumConceptos);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Imp. Facturable    [%ld]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].dImpFacturable);
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t[%d]** Seg. Consumidos    [%ld]",LOG03,i
                                        ,stCtlInfConceptos.stUnivStatConc[i].lSegConsumido);

    }
}




/****************************************************************************/
/*  Funcion :   bfnInsertHeaderInfCtl                                       */
/****************************************************************************/
BOOL bfnInsertHeaderInfCtl()
{
    int iStat=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

    char    szhCodInforme   [7]    ;/* EXEC SQL VAR szhCodInforme  IS STRING(7); */ 

    long    lhNumSecuInfo          ;
    int     ihIndActivo            ;    
    char    szhFecEmision   [15];/* EXEC SQL VAR szhFecEmision  IS STRING(15); */ 

    char    szhFecPerDesde  [15];/* EXEC SQL VAR szhFecPerDesde IS STRING(15); */ 

    char    szhFecPerHasta  [15];/* EXEC SQL VAR szhFecPerHasta IS STRING(15); */ 

    char    szhCodUsuario   [50];/* EXEC SQL VAR szhCodUsuario  IS STRING(50); */ 

    char    szhCodUsuaSoli  [50];/* EXEC SQL VAR szhCodUsuaSoli IS STRING(50); */ 

    long    lhCodCiclFact         ;
    char    szCadenaSQL     [512];
    char    szhMinimo       [13]  ;
    char    szhMaximo       [13]  ;
    /* EXEC SQL END DECLARE SECTION  ; */ 
    

    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertHeaderInfCtl)",LOG03);
    
    sprintf(szhCodInforme,"%s\0",szCodInformeGenerar);
    lhNumSecuInfo = lhNumSecuenciaInforme           ;
    lhCodCiclFact  = pstCiclo.lCodCiclFact          ;    
    ihIndActivo     = COD_INFORME_CONTROL_INACTIVO  ;
    
    /****************************************************************************/
    /*  Actualiza Informe Anterior de Facturacion de Ciclo Como Inactivos.      */
    /****************************************************************************/
    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertHeaderInfCtl) Actualiza Informe Anterior como Inactivo"
                                    "\n\t\t** Cod. Informe          [%s]"
                                    "\n\t\t** Codigo Ciclo Factur.  [%ld]"
                                    "\n\t\t** Ind. Activo           [%d]"
                                    ,LOG03
                                    ,szhCodInforme  
                                    ,lhCodCiclFact  
                                    ,COD_INFORME_CONTROL_INACTIVO);
    /* EXEC SQL 
        UPDATE  FAD_CTLINFHEADER
        SET     IND_ACTIVO  = :ihIndActivo
        WHERE   COD_INFORME = :szhCodInforme
        AND     COD_CICLFACT= :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAD_CTLINFHEADER  set IND_ACTIVO=:b0 where (COD_IN\
FORME=:b1 and COD_CICLFACT=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )552;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndActivo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodInforme;
    sqlstm.sqhstl[1] = (unsigned long )7;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
    {            
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnInsertHeaderInfCtl) Error En Update de Header de Informe"
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    /****************************************************************************/
    /*  Genera Nuevo registro Header de Informe de Facturacion de Ciclo         */
    /****************************************************************************/

    ihIndActivo     = COD_INFORME_CONTROL_ACTIVO            ;
    
    sprintf(szhFecEmision  ,"%s\0",pstCiclo.szFecEmision    );
    sprintf(szhFecPerDesde ,"%s\0",pstCiclo.szFecDesdeCFijos);
    sprintf(szhFecPerHasta ,"%s\0",pstCiclo.szFecHastaCFijos);
    sprintf(szhCodUsuario  ,"%s\0",stLineaComando.szUser    );
    sprintf(szhCodUsuaSoli ,"%s\0",stLineaComando.szUser    );


    vDTrazasLog(szExeInfCtlFactur   ,"\n\t\t**(bfnInsertHeaderInfCtl)"
                                    "\n\t\t** Cod. Informe          [%s]"
                                    "\n\t\t** Secuencia Infortme    [%d]"
                                    "\n\t\t** Ind. Activo           [%d]"
                                    "\n\t\t** Fec. Emision          [%s]"
                                    "\n\t\t** Fec. Periodo Desde    [%s]"
                                    "\n\t\t** Fec. Periodo Hasta    [%s]"
                                    "\n\t\t** Usuario Generador     [%s]"
                                    "\n\t\t** Usuario Solicitante   [%s]"
                                    "\n\t\t** Codigo Ciclo Factur.  [%ld]"
                                    ,LOG03
                                    ,szhCodInforme  
                                    ,lhNumSecuInfo  
                                    ,ihIndActivo    
                                    ,szhFecEmision  
                                    ,szhFecPerDesde 
                                    ,szhFecPerHasta 
                                    ,szhCodUsuario  
                                    ,szhCodUsuaSoli 
                                    ,lhCodCiclFact  );
/* AEO 29/SEP/2000 */
        sprintf(szCadenaSQL,
        "SELECT MIN(NUM_CTC),max(NUM_CTC) "
        "FROM FA_FACTDOCU_%ld \0", pstCiclo.lCodCiclFact);
        vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Query (bfnInsertHeaderInfCtl) **"
                                        "\n\t\t [%s]",LOG06,szCadenaSQL);

        /* EXEC SQL PREPARE sql_Min_Max FROM :szCadenaSQL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )579;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
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


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Prepare SQL (bfnInsertHeaderInfCtl) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }   

        /* EXEC SQL DECLARE C_CURSOR_MINMAX CURSOR FOR sql_Min_Max; */ 

        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,   "\n\n\t**  Error en Declare Cursor (bfnInsertHeaderInfCtl) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }    

        /* EXEC SQL OPEN C_CURSOR_MINMAX; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )598;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE != SQLOK)
        {
            vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Open Cursor (bfnInsertHeaderInfCtl) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }

        /* EXEC SQL 
            FETCH   C_CURSOR_MINMAX 
            INTO    :szhMinimo,
                    :szhMaximo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )613;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhMinimo;
        sqlstm.sqhstl[0] = (unsigned long )13;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhMaximo;
        sqlstm.sqhstl[1] = (unsigned long )13;
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



        if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasLog(szExeInfCtlFactur,  "\n\n\t**  Error en Fetch de Minimo y Maximo NUMCTC (bfnInsertHeaderInfCtl) **"
                                            "\n\t\t Error Oracle [%d] [%s]"
                                            ,LOG01,SQLCODE,SQLERRM);
            return FALSE;
        }
          /* EXEC SQL CLOSE C_CURSOR_MINMAX; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 13;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )636;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


          
        
/* AEO 29/SEP/2000 */
    /* EXEC SQL INSERT INTO FAD_CTLINFHEADER(
                COD_INFORME    ,
                NUM_SECUINFO   ,
                IND_ACTIVO     ,
                FEC_EMISION    ,
                FEC_PERDESDE   ,
                FEC_PERHASTA   ,
                COD_USUAGEN    ,
                COD_USUASOL    ,
                COD_CICLFACT   ,
                MIN_FOLIOCTC   ,
                MAX_FOLIOCTC    )        
    VALUES (    :szhCodInforme  ,
                :lhNumSecuInfo  ,
                :ihIndActivo    ,
                SYSDATE         ,
                TO_DATE(:szhFecPerDesde ,'YYYYMMDDHH24MISS'),
                TO_DATE(:szhFecPerHasta ,'YYYYMMDDHH24MISS'),
                :szhCodUsuario  ,
                :szhCodUsuaSoli ,
                :lhCodCiclFact  ,
                :szhMinimo      ,
                :szhMaximo     ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAD_CTLINFHEADER (COD_INFORME,NUM_SECUINFO,IN\
D_ACTIVO,FEC_EMISION,FEC_PERDESDE,FEC_PERHASTA,COD_USUAGEN,COD_USUASOL,COD_CIC\
LFACT,MIN_FOLIOCTC,MAX_FOLIOCTC) values (:b0,:b1,:b2,SYSDATE,TO_DATE(:b3,'YYYY\
MMDDHH24MISS'),TO_DATE(:b4,'YYYYMMDDHH24MISS'),:b5,:b6,:b7,:b8,:b9)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )651;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInforme;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuInfo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndActivo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecPerDesde;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecPerHasta;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodUsuario;
    sqlstm.sqhstl[5] = (unsigned long )50;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodUsuaSoli;
    sqlstm.sqhstl[6] = (unsigned long )50;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhMinimo;
    sqlstm.sqhstl[8] = (unsigned long )13;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhMaximo;
    sqlstm.sqhstl[9] = (unsigned long )13;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
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
        vDTrazasLog(szExeInfCtlFactur   ,"\t\t**(bfnInsertHeaderInfCtl) Error En Insert de Header de Informe"
                                         "\n\t\t Error Oracle [%d] [%s]"
                                        ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    
    
    return TRUE;
}




/****************************************************************************/
/*  Funcion :   bfnGetSecuInfo Selecciona Numero de Secuencia de Informe    */
/****************************************************************************/
BOOL bfnGetSecuInfo ()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     ihCodTipInforme ;
    long    lhNumSecuInfo   ;
    char    szhCodInformeGenerar[7];/* EXEC SQL VAR szhCodInformeGenerar IS STRING (7); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    ihCodTipInforme = COD_INFORME_FAD_CTLINFOPARAM;

    /* EXEC SQL
        SELECT  FA_SEQ_CTLINFORMES.NEXTVAL 
        INTO    :lhNumSecuInfo 
        FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select FA_SEQ_CTLINFORMES.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )706;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuInfo;
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



    if(SQLCODE != SQLOK)
    {

        vDTrazasError(szExeInfCtlFactur, "\n\n\tError en lhNumSecuInfo"
                                        "\n\t\t Error [%d] [%s]"
                                        , LOG01, SQLCODE, SQLERRM);
        return FALSE;
    }
    lhNumSecuenciaInforme = lhNumSecuInfo;

    /* EXEC SQL
        SELECT  COD_INFORME 
        INTO    :szhCodInformeGenerar
        FROM    FAD_CTLINFOPARAM 
        WHERE   COD_TIPINFORME = :ihCodTipInforme; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_INFORME into :b0  from FAD_CTLINFOPARAM where \
COD_TIPINFORME=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )725;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodInformeGenerar;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipInforme;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeInfCtlFactur, "\n\n\tError en szhCodInformeGenerar"
                                        "\n\t\t Error [%d] [%s]"
                                        , LOG01, SQLCODE, SQLERRM);
        return FALSE;
    }
    sprintf(szCodInformeGenerar,"%s\0",szhCodInformeGenerar);
    vDTrazasLog (szExeInfCtlFactur, "\n\t\t Informe  de Control [%s]"
                                    "\n\t\t Secuencia Informe   [%ld]"
                                    , LOG03, szCodInformeGenerar, lhNumSecuenciaInforme);
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

