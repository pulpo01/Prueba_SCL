
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
    "./pc/New_FolBatch.pc"
};


static unsigned int sqlctx = 55397835;


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
5,0,0,1,0,0,17,1269,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,1291,0,0,0,0,0,1,0,
39,0,0,1,0,0,13,1330,0,0,12,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,5,0,0,2,
5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,5,0,0,
102,0,0,1,0,0,15,1410,0,0,0,0,0,1,0,
117,0,0,2,0,0,17,1581,0,0,1,1,0,1,0,1,97,0,0,
136,0,0,2,0,0,45,1603,0,0,0,0,0,1,0,
151,0,0,2,0,0,13,1605,0,0,3,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,
178,0,0,3,122,0,4,1633,0,0,9,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,0,
229,0,0,2,0,0,15,1647,0,0,0,0,0,1,0,
244,0,0,4,0,0,17,1665,0,0,1,1,0,1,0,1,97,0,0,
263,0,0,4,0,0,45,1687,0,0,0,0,0,1,0,
278,0,0,4,0,0,13,1689,0,0,1,0,0,1,0,2,5,0,0,
297,0,0,5,78,0,4,1700,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
320,0,0,6,236,0,4,1728,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
351,0,0,7,197,0,4,1740,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
382,0,0,8,61,0,4,1751,0,0,1,0,0,1,0,2,3,0,0,
401,0,0,9,104,0,4,1780,0,0,7,6,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,2,97,0,0,
444,0,0,10,0,0,17,2014,0,0,1,1,0,1,0,1,5,0,0,
463,0,0,10,0,0,21,2027,0,0,0,0,0,1,0,
478,0,0,11,190,0,4,2068,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
505,0,0,12,211,0,4,2078,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,
536,0,0,13,231,0,4,2193,0,0,4,3,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
567,0,0,14,122,0,4,2248,0,0,9,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,2,97,0,0,
618,0,0,15,106,0,4,2313,0,0,8,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,2,97,0,0,
665,0,0,16,0,0,17,2393,0,0,1,1,0,1,0,1,97,0,0,
684,0,0,16,0,0,45,2411,0,0,0,0,0,1,0,
699,0,0,16,0,0,13,2420,0,0,1,0,0,1,0,2,3,0,0,
718,0,0,16,0,0,15,2429,0,0,0,0,0,1,0,
733,0,0,17,183,0,4,2476,0,0,3,1,0,1,0,2,3,0,0,2,97,0,0,1,97,0,0,
760,0,0,18,278,0,4,2498,0,0,9,6,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
811,0,0,19,72,0,4,2556,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
834,0,0,20,141,0,4,2585,0,0,1,0,0,1,0,2,3,0,0,
853,0,0,21,407,0,4,2626,0,0,3,1,0,1,0,2,97,0,0,2,97,0,0,1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : foliacion.pc                                             * */
/* *  Foliacion de Documentos                                            * */
/* *  Autor : Mauricio Villagra V.                                       * */
/* *********************************************************************** */
/************************************************************************* */

#define _FOLIACION_PC_
#include <deftypes.h>
#include <string.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include <EncriptaSha1.h>
#include "New_FolBatch.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/
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

int iTipoFoliacion;
int iFlagFolInicial=0;
/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char modulo[]="main";

    extern  char *optarg                        ;
    char    opt[]=":h:u:a:t:c:i:d:f:g:l:e:o:p:z:";
    char    *psztmp                         = "";
    int     iOpt                              =0;
    char    szaux                           [10];
    char    *szDirLogs                          ;
    char    *szDirDats                          ;
    char    *szNomArchivo                       ;
    char    szComando                 [1024] ="";
    char    szFecEmi                     [9] ="";
    BOOL    bRetorno = FALSE                    ;

    printf("\n  New_FolBatch version " __DATE__ " " __TIME__ " TMG\n");

    memset(&stLineaComando,0    ,sizeof(FOLIACIONLINEACOMANDO));
    memset(&stStatus    ,'\0'   ,sizeof(STATUS));
    memset(&stCiclo     ,'\0'   ,sizeof(CICLO));

    stLineaComando.bOptUsuario  = FALSE;
    stLineaComando.bOptCiclo    = FALSE;
    stLineaComando.lClienteFin  = 0;
    
    if(argc == 1)
    {
       fprintf (stderr,"\n<< Error : Parámetros insuficientes >>\n%s\n",szUsage);
       return FALSE;
    }    
    
    while((iOpt = getopt(argc,argv,opt)) != EOF)
    {
    	
        switch(iOpt)
        {
            case 'h':
                    stLineaComando.bOptHelp  = TRUE;
                    break;
            case 'u':
                    if (strlen(optarg))
                    {
                        strcpy(stLineaComando.szUsuario, optarg);
                        stLineaComando.bOptUsuario  = TRUE;
                        fprintf(stdout," -u%s ", stLineaComando.szUsuario);
                    }
                    break;
            case 'a':
                    if (strlen(optarg))
                    {
                        strcpy(stLineaComando.szOpcion, optarg);
                        fprintf(stdout,"-a%s ", stLineaComando.szOpcion);
                    }
                    break;
            case 't':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lTipoDocumen = atol(szaux);
                        fprintf(stdout,"-t%ld ", stLineaComando.lTipoDocumen);
                    }
                    break;
            case 'c':
                    if (strlen(optarg))
                    {
                        stLineaComando.bOptCiclo = TRUE;
                        strcpy(szaux,optarg);
                        stLineaComando.lCodCiclFact = atol(szaux);
                        fprintf(stdout,"-c%ld ", stLineaComando.lCodCiclFact);
                    }
                    break;
            case 'i':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lClienteIni = atol(szaux);
                        fprintf(stdout,"-i%ld ", stLineaComando.lClienteIni);
                    }
                    break;
            case 'd':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        strcpy(stLineaComando.szFecFoli,szaux);
                        fprintf(stdout,"-d%s ", stLineaComando.szFecFoli);
                    }
                    break;
            case 'f':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lFolioIni= atol(szaux);
                        fprintf(stdout,"-f%ld ", stLineaComando.lFolioIni);
                    }
                    break;
            case 'g':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lCantidad = atol(szaux);
                        fprintf(stdout,"-g%ld ", stLineaComando.lCantidad);
                    }
                    break;
            case 'l':
                    if (strlen(optarg))
                    {
                        stStatus.LogNivel =(atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                        fprintf(stdout,"-l%d ", stStatus.LogNivel)     ;
                    }
                    break;
            case 'e':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        strcpy(stLineaComando.szCodModGener,szaux);
                        fprintf(stdout,"-e%s ", stLineaComando.szCodModGener);
                    }
                    break;
            case 'o':  
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        strcpy(stLineaComando.szCodigoOperadora,szaux);
                        fprintf(stdout,"-o%s ", stLineaComando.szCodigoOperadora);
                    }
                    break;

            case 'p':  
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        strcpy(stLineaComando.szPrefijoFolio,szaux);
                        fprintf(stdout,"-p%s ", stLineaComando.szPrefijoFolio);
                    }
                    break;
            case 'z':
                    if (strlen(optarg))
                    {
                        strcpy(szaux,optarg);
                        stLineaComando.lClienteFin = atol(szaux);
                        fprintf(stdout,"-z%ld ", stLineaComando.lClienteFin);
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
    
    if (!stLineaComando.bOptUsuario)
    {
        fprintf (stderr, "\n\t#Falta usuario/password en parametros de entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
        if ( (psztmp=(char *)strstr (stLineaComando.szUsuario,"/"))==(char *)NULL)
        {
             fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return (3);
        }
        else
        {
            strncpy (stLineaComando.szUser,stLineaComando.szUsuario,psztmp-stLineaComando.szUsuario);
            strcpy  (stLineaComando.szPass, psztmp+1)                 ;
        }
    }    
    
    if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF     ;

    stLineaComando.iNivLog = stStatus.LogNivel;
   
    if (!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'New_FolBatch  <usuario> <passwd> '\n");
        return(2);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------\n",
                stLineaComando.szUser);
    }

    printf( "\n\t-------------------------------------------------------"
            "\n\tDirectorio de logs [%s]                              \n"
            "\n\t-------------------------------------------------------\n",
            szGetEnv("XPF_LOG"));

    /* Validacion de Parametros */
    if (!bfnValidaParams(&stLineaComando))
    {
        fprintf( stderr, "\n\t***   Falla en Validación de Parámetros\n");
        return (1);
    }

    /* Obtención de datos a procesar (GenFA.pc)*/
    if (!bGetDatosGener(&stDatosGener, szSysDate))
    {
    	fprintf( stderr, "\n\t***   Falla en Obtención de datos a procesar\n");
        return FALSE;
    }

    /* Carga parametros de la estructura pstParamGener (geora.pc)*/
    if (!bGetParamDecimales() )
    {
    	fprintf( stderr, "\n\t***   Falla en Obtención de parámetros\n");
        return FALSE;
    }

    /**************************************************************************************/
    szDirLogs   =(char *)malloc(1024);
    szDirDats   =(char *)malloc(1024);
    szNomArchivo=(char *)malloc(128);
    /**************************************************************************************/

    if ((szDirLogs = szGetEnv("XPF_LOG")) ==(char *)NULL)
        return(5);
    /**************************************************************************************/

    if ((szDirDats = szGetEnv("XPF_DAT")) ==(char *)NULL)
        return(5);
    /**************************************************************************************/
    if (stLineaComando.bOptCiclo)
    {
        /* Recupera para COD_CICLFACT datos desde Tabla FA_CICLFACT */    	
        stCiclo.lCodCiclFact = stLineaComando.lCodCiclFact ;        
        if (!bFindCiclFact(&stCiclo))
            return FALSE;
        memset(szFecEmi,0,sizeof(szFecEmi));
        strncpy(szFecEmi,stCiclo.szFecEmision,8);
        sprintf(stLineaComando.szFecFoli,"%s\0", szFecEmi);
        fprintf(stderr, "\n\tFecha de Emision [%s]\n",szFecEmi);

        sprintf(stLineaComando.szDirLogs,"%s/New_FolBatch/%ld",
                szDirLogs,
                stLineaComando.lCodCiclFact);
        sprintf(stLineaComando.szDirDats,"%s/New_FolBatch/%ld",
                szDirDats,
                stLineaComando.lCodCiclFact);
        sprintf(szNomArchivo,"%s/FB_%s_%ld_%ld_%ld_%s",
                stLineaComando.szDirLogs,
                stLineaComando.szOpcion ,
                stLineaComando.lTipoDocumen,
                stLineaComando.lClienteIni,
                stLineaComando.lFolioIni,
                szSysDate);
    }
    else
    {
        sprintf(stLineaComando.szDirLogs,"%s/New_FolBatch/%s",
                szDirLogs,
                cfnGetTime(2));
        sprintf(stLineaComando.szDirDats,"%s/New_FolBatch/%s",
                szDirDats,
                cfnGetTime(2));
        sprintf(szNomArchivo,"%s/FB_%s_%s_%ld_%ld_%ld_%s",
                stLineaComando.szDirLogs,
                stLineaComando.szOpcion ,
                stLineaComando.szCodModGener,
                stLineaComando.lTipoDocumen,
                stLineaComando.lClienteIni,
                stLineaComando.lFolioIni,
                cfnGetTime(4));
    }

    /*********************************************************************************************/
    /* Creación de Directorio LOG */
    sprintf(szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    if (system(szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return(5);
    }
      
    /*********************************************************************************************/
    /* Creación de Directorio DAT */
    sprintf(szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirDats );

    if (system(szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Dats : %s \n",szComando);
        return(5);
    }
          
    /*********************************************************************************************/
    /* Open archivo de errores */
    sprintf(stStatus.ErrName,"%s.err",szNomArchivo);
    if ((stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) ==(FILE*)NULL )
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de error %s\n", stStatus.ErrName);
        return(6);
    }
           
    /*********************************************************************************************/
    /* Open archivo de log */
    sprintf(stStatus.LogName, "%s.log",szNomArchivo);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) ==(FILE*)NULL)
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de log %s\n",stStatus.LogName);
        fclose(stStatus.ErrFile);
        return(6);
    }
               
    /*********************************************************************************************/
    if (stLineaComando.bOptCiclo)
    {
        sprintf(szNomArchivo,"%s/FB_%s_%ld_%ld_%ld_%s",
                stLineaComando.szDirDats,
                stLineaComando.szOpcion ,
                stLineaComando.lTipoDocumen,
                stLineaComando.lClienteIni,
                stLineaComando.lFolioIni,
                szSysDate);
    }
    else
    {
        sprintf(szNomArchivo,"%s/FB_%s_%s_%ld_%ld_%ld_%s",
                stLineaComando.szDirDats,
                stLineaComando.szOpcion ,
                stLineaComando.szCodModGener,
                stLineaComando.lTipoDocumen,
                stLineaComando.lClienteIni,
                stLineaComando.lFolioIni,
                cfnGetTime(4));
    }
              
    /*********************************************************************************************/
    /* Open archivo dat */
    sprintf(stLineaComando.szDataName, "%s.dat",szNomArchivo);
    if ((stLineaComando.DataFile = fopen(stLineaComando.szDataName,"wb")) ==(FILE*)NULL)
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de Datos %s\n",stLineaComando.szDataName);
        fclose(stStatus.ErrFile);
        fclose(stStatus.LogFile);
        return(6);
    }
    
    fprintf(    stLineaComando.DataFile,"   Cliente    Ind_Ordentotal  Tot_Factura       Folio\n");
    /*********************************************************************************************/

    vDTrazasLog  ( modulo ,"\n  New_FolBatch version " __DATE__ " " __TIME__ " TMG\n",LOG03);
    vDTrazasError( modulo ,"\n  New_FolBatch version " __DATE__ " " __TIME__ " TMG\n",LOG03);


    vDTrazasError( modulo ,"\n\t*************************************"
                           "\n\t****     Errores de Foliacion      **"
                           "\n\t*************************************"
                           ,LOG03);

    vDTrazasLog( modulo ,"\n\t*************************************"
                         "\n\t***        Log   Foliacion        ***"
                         "\n\t*************************************"
                         "\n\t\t*** Parametros Entrada Foliacion  ***"
                         "\n\t\t=> Usuario         [%s]"
                         "\n\t\t=> Password        [************]"
                         "\n\t\t=> Operacion       [%s]"
                         "\n\t\t=> Cod.TipDocum    [%ld]"
                         "\n\t\t=> Niv.Log         [%d]"
                         ,LOG05
                         ,stLineaComando.szUser
                         ,stLineaComando.szOpcion
                         ,stLineaComando.lTipoDocumen
                         ,stLineaComando.iNivLog);


    /* Valida Folio Ingresado + Cantidad y Carga Cod. Vendedor y Cod. Oficina*/
    if (!stLineaComando.bOptCiclo && stLineaComando.iOpcion != iPROCESO_ANULAR)
    {
        memset(&stRegAuxiliar,0,sizeof(FOLIACIONAUXILIAR)) ;
        if (!bfnValidaFolioIngreso(stLineaComando, &stRegAuxiliar))
            return FALSE;
    }


    switch(stLineaComando.iOpcion)
    {
    	/* Anular Folio */
        case iPROCESO_ANULAR :
        bRetorno = bfnAnularFolio(  stLineaComando.lTipoDocumen,
									stLineaComando.lFolioIni,
	                                stLineaComando.lCantidad,
	                                stLineaComando.lCodCiclFact,
	                                stLineaComando.szCodigoOperadora,
	                                stLineaComando.szPrefijoFolio );
            break;
        /* Consumir Folio */            
        case iPROCESO_CONSUMIR  :
        case iPROCESO_REPORTE   :
        bRetorno = bfnFoliacion(   stLineaComando.lTipoDocumen,
                            stLineaComando.lClienteIni,
                            stLineaComando.lFolioIni,
                            stLineaComando.lCantidad,
                            stLineaComando.iOpcion,
                            stLineaComando.szCodModGener,
                            stLineaComando.bOptCiclo,
                            stLineaComando.lCodCiclFact,
                            stLineaComando.szCodigoOperadora,
                            stLineaComando.szPrefijoFolio,
                            stLineaComando.lClienteFin);
            break;
    }

    /* Validación de status de fin de la aplicación */
    if (!bRetorno)
    {
        fnOraRollBack();
        vDTrazasError( modulo ,"\n\t------------------------------------"
                               "\n\tProceso Terminado de Forma Irregular"
                               "\n\t------------------------------------\n"
                                    ,LOG03);
        vDTrazasLog( modulo ,  "\n\t------------------------------------"
                               "\n\tProceso Terminado de Forma Irregular"
                               "\n\t------------------------------------\n"
                               ,LOG03);
        return 3;
    }
    else
    {
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado Correctamente"
                               " \n\t------------------------------------\n"
                               ,LOG03);
        if (!fnOraCommit())
        {
            vDTrazasLog( modulo , " \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            vDTrazasError( modulo ," \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            return 4;
        }
    }

    /* Desconectando de Base de Datos */
    if (!bfnDisconnectORA(0))
    {
    }
    else
    {
      vDTrazasLog( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
      vDTrazasError( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);

    }
    
    /* Fin de la aplicación */
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    fclose(stLineaComando.DataFile);
    return(0);
}/* ********************* END  MAIN ********************** */

/* ************************************************************************* */
/* * FUNCION : trim                                                        * */
/* ************************************************************************* */
void trim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}/* END trim */

/* ************************************************************************* */
/* * FUNCION : bfnValidaParams                                             * */
/* * USO     : Realiza la validacion de los Parametros de Entrada          * */
/* ************************************************************************* */
BOOL bfnValidaParams(FOLIACIONLINEACOMANDO *pstLineaCom)
{
    char    modulo[]="bfnValidaParams";
    char    *psztmp = "";

    vDTrazasLog( modulo , "\n\t*** Entrada en bfnValidaParams ***",LOG03);
    pstLineaCom->iOpcion = 0  ;         /*  No Existe Opcion por Default */
    
    if (strcmp(pstLineaCom->szOpcion,"A")==0)
    {
        pstLineaCom->iOpcion = iPROCESO_ANULAR      ;
    }
    else if (strcmp(pstLineaCom->szOpcion,"C")==0)
         {
            pstLineaCom->iOpcion = iPROCESO_CONSUMIR    ;
         }
    else if (strcmp(pstLineaCom->szOpcion,"R")==0)
         {
            pstLineaCom->iOpcion = iPROCESO_REPORTE     ;
         }

    if (pstLineaCom->bOptHelp) /* Si sólo se requiere ayuda */
    {
      switch(pstLineaCom->iOpcion)
      {
        case iPROCESO_ANULAR :
                      fprintf(stderr, "%s\n", szUsAnular);
                      break;
        case iPROCESO_CONSUMIR :
                      fprintf(stderr, "%s\n", szUsConsumo);
                      break;
        case iPROCESO_REPORTE :
                      fprintf(stderr, "%s\n", szUsReporte);
                      break;
        default :
                      fprintf(stderr, "%s\n", szUsage);
                      break;
      }
      return FALSE;
    }

    if (!pstLineaCom->bOptUsuario)
    {   /* asume usuario/password por defecto */
        memset(pstLineaCom->szUser,0,sizeof(pstLineaCom->szUser)); /*null*/
        memset(pstLineaCom->szPass,0,sizeof(pstLineaCom->szPass)); /*null*/
        fprintf(stderr, "Asumir Usuario/Password por Defecto\n");        
    }
    else
    {
       if ((psztmp=(char *)strstr(pstLineaCom->szUsuario,"/"))==(char *)NULL)
       {
             fprintf(stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return FALSE;
       }
       else
       {
             strncpy(pstLineaCom->szUser,pstLineaCom->szUsuario,psztmp-pstLineaCom->szUsuario);
             strcpy(pstLineaCom->szPass, psztmp+1)                 ;
       }
    }
    
    switch(pstLineaCom->iOpcion)
    {
        case iPROCESO_ANULAR :
            if (pstLineaCom->lFolioIni <= 0 )
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Folio Inicial) \n%s\n", szUsAnular);
                return FALSE;
            }
            if (pstLineaCom->lCantidad <= 0 )
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cantidad de Folios) \n%s\n", szUsAnular);
                return FALSE;
            }
            if (pstLineaCom->lTipoDocumen <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cod_TipDocum) \n%s\n", szUsAnular);
                return FALSE;
            }
            if (strlen(pstLineaCom->szFecFoli) == 0 )
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Fecha de Anulacion ) \n%s\n", szUsAnular);
                return FALSE;
            }
            else
            {
                if ( atol(pstLineaCom->szFecFoli)<19990101 )
                {
                    fprintf(stderr, "\n\t# Error de formato :(Fecha de Anulacion)  \n%s\n", szUsAnular);
                    return FALSE;
                }
            }
            break;
        case iPROCESO_CONSUMIR  :    
        
            if (pstLineaCom->lCantidad <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cantidad de Folios) \n%s\n", szUsConsumo);
                return FALSE;
            }
            if (pstLineaCom->lTipoDocumen <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cod_TipDocum) \n%s\n", szUsConsumo);
                return FALSE;
            }
            if (pstLineaCom->lClienteIni <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cliente Inicial) \n%s\n", szUsConsumo);
                return FALSE;
            }
            if (pstLineaCom->bOptCiclo == TRUE)  /* Ciclo*/
            {
                iFlagFolInicial = 0;
                if (pstLineaCom->lCodCiclFact <= 0)
                {
                    fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(CodCiclFact) \n%s\n", szUsConsumo);
                    return FALSE;
                }
            }
            else /* No Ciclo */
            {
                iFlagFolInicial = 1;
                if (strlen(pstLineaCom->szCodModGener)== 0)
                {
                    fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(szCodModGener) \n%s\n", szUsConsumo);
                    return FALSE;
                }
            }
            
        /* Validacion de mutua exclusion de las opcines codciclfact y codmodgener */
        if (pstLineaCom->bOptCiclo == TRUE &&(strlen(pstLineaCom->szCodModGener)!= 0) )
        {
           fprintf(stderr, "\n\t#La opcion '-c' no puede ir junto a la opcion '-e' \n%s\n", szUsConsumo);
           return FALSE;
        }

        if (pstLineaCom->bOptCiclo != TRUE) /* NO CICLO */
        {
                if (pstLineaCom->lFolioIni <= 0)
                    {
                        fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Folio Inicial) \n%s\n", szUsConsumo);
                        return FALSE;
                    }

                    if (strlen(pstLineaCom->szPrefijoFolio) == 0)
                    {
                        fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Prefijo Folio) \n%s\n", szUsConsumo);
                        return FALSE;
                    }
        }
        else /* CICLO */
        {

                iTipoFoliacion = ifnObtieneParam();

                if (iTipoFoliacion == -1)
                {          	
                    return FALSE;
                }
                if (iTipoFoliacion == 1)
                {
                    if (pstLineaCom->lFolioIni != 0)
                    {
                       fprintf(stderr, "\n\t# La opcion -f no se debe colocar ante casos ciclicos  \n%s\n", szUsConsumo);
                       return FALSE;
                    }

                    if (strlen(pstLineaCom->szPrefijoFolio)!= 0)
                    {
                       fprintf(stderr, "\n\t# La opcion -p no se debe colocar ante casos ciclicos  \n%s\n", szUsConsumo);
                       return FALSE;
                    }
                }
                else
                {
                    if (pstLineaCom->lFolioIni <= 0)
                    {
                       fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Folio Inicial) \n%s\n", szUsConsumo);
                       return FALSE;
                    }

                    if (strlen(pstLineaCom->szPrefijoFolio)== 0)
                    {
                       fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Prefijo Folio) \n%s\n", szUsConsumo);
                       return FALSE;
                    }
                }
        }

            break;
        case iPROCESO_REPORTE   :
            if (pstLineaCom->lCantidad <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cantidad de Folios) \n%s\n", szUsReporte);
                return FALSE;
            }
            if (pstLineaCom->lTipoDocumen <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cod_TipDocum) \n%s\n", szUsReporte);
                return FALSE;
            }
            if (pstLineaCom->lClienteIni <= 0)
            {
                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Cliente Inicial) \n%s\n", szUsReporte);
                return FALSE;
            }
            if (pstLineaCom->bOptCiclo == TRUE)  /* Ciclo*/
            {
                if (pstLineaCom->lCodCiclFact <= 0)
                {
                    fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(CodCiclFact) \n%s\n", szUsReporte);
                    return FALSE;
                }
            }
            else /* No Ciclo */
            {
                if(strlen(pstLineaCom->szCodModGener)== 0)
                {
                    fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(szCodModGener) \n%s\n", szUsReporte);
                    return FALSE;
                }
            }

            /* Validacion de mutua sxclusion de las opcines codciclfact y codmodgener */
	        if (pstLineaCom->bOptCiclo == TRUE &&(strlen(pstLineaCom->szCodModGener)!= 0) )
	        {
	            fprintf(stderr, "\n\t#La opcion '-c' no puede ir junto a la opcion '-m' \n%s\n", szUsReporte);
	            return FALSE;
	        }

	        if (pstLineaCom->bOptCiclo != TRUE) /* NO CICLO */
	        {
	            if (pstLineaCom->lFolioIni <= 0)
	            {
	                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Folio Inicial) \n%s\n", szUsConsumo);
	                return FALSE;
	            }

	            if (strlen(pstLineaCom->szPrefijoFolio) == 0)
	            {
	                fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Prefijo Folio) \n%s\n", szUsConsumo);
	                return FALSE;
	            }
	        }
	        else /* CICLO */
	        {
                    	        	
	            iTipoFoliacion = ifnObtieneParam();

	            if (iTipoFoliacion == -1)
	                return FALSE;
	            if (iTipoFoliacion == 1)
	            {
	                if (pstLineaCom->lFolioIni != 0)
                    {
                        fprintf(stderr, "\n\t# La opcion -f no se debe colocar ante casos ciclicos  \n%s\n", szUsConsumo);
                        return FALSE;
                    }

                    if (strlen(pstLineaCom->szPrefijoFolio)!= 0)
                    {
                        fprintf(stderr, "\n\t# La opcion -p no se debe colocar ante casos ciclicos  \n%s\n", szUsConsumo);
                        return FALSE;
                    }
                }
                else
                {
                    if (pstLineaCom->lFolioIni <= 0)
                    {
                        fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Folio Inicial) \n%s\n", szUsConsumo);
                        return FALSE;
                    }

                    if (strlen(pstLineaCom->szPrefijoFolio)!= 0)
                    {
                        fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Prefijo Folio) \n%s\n", szUsConsumo);
                        return FALSE;
                    }
                }
        	}
            break;
        default :
            fprintf(stderr, "\n\t# Faltan Parametros de Entrada:(Anular, Consumir o Reporte  -a [A/C/R] \n%s\n", szUsage);
            return FALSE;
    }
    
    printf("\n\t Salida de Valida Parametros \n\n");
    
    return TRUE;
}/* END bfnValidaParams */

/* **************************************************************************** */
/* * FUNCION : bfnFoliacion                                                   * */
/* * USO     : Realiza la asignacion de folios legales por tipo de dopcumento * */
/* *           por rangos de clientes segun el orden generado.                * */
/* **************************************************************************** */
BOOL bfnFoliacion( long lTipDocum
                   ,long lClieIni
                   ,long lFolIni
                   ,long lCant
                   ,int  iOpcion
                   ,char *szCodModGener
                   ,BOOL bpOptCiclo
                   ,long lCodCiclFact
                   ,char *szCodigoOperadora
                   ,char *szPrefijoFolio
                   ,long lClieFin)
{
    char modulo[]="bfnFoliacion";

    char              szFecha    [20] = "";   /*  Fecha de Sistema Para Update de Traza   */
    int               iSql            = 0 ;   /*  Retorno de Fetch de Documentos          */
    long              lConFolio       = 0 ;
    char              sTipoFoliacion[2]   ;
    int               iCodProceso     = 0 ;
    int               i               = 0 ;
    FOLIACIONREGDOCUM stAux;
    char              szHostId     [25];
    long              lClieIniBD      = 0;
    long              lClieFinBD      = 0;
    int               iExisteHostID   = 0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char  szhOficina [4]   ;
         long  lhCodTipDocum    ;
         long  lhFolioUpdate = 0;        /*  Folio Asignado para Update              */
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(&stRegDocumFoli,0,sizeof(FOLIACIONREGDOCUM));

    vDTrazasLog( modulo , "\n\t*** Entrada en %s ***"
                           "\n\t\t=> Cod.TipDocum          [%ld]"
                           "\n\t\t=> Cliente Inicial       [%ld]"
                           "\n\t\t=> PrefijoFolio          [%s]"
                           "\n\t\t=> Folio Inicial         [%ld]"
                           "\n\t\t=> Cantidad de Folios    [%ld]"
                           "\n\t\t=> Opcion de Foliacion   [%d]"
                           "\n\t\t=> Cod. Modo Generacion  [%s]"
                           "\n\t\t=> Cod.CiclFact          [%ld]"
                           ,LOG03
                           ,modulo
                           ,lTipDocum
                           ,lClieIni
                           ,szPrefijoFolio
                           ,lFolIni
                           ,lCant
                           ,iOpcion
                           ,szCodModGener
                           ,lCodCiclFact);

    strcpy(szhOficina,stRegAuxiliar.szCodOficina);
    lhCodTipDocum =  lTipDocum;
    
    strcpy(szHostId,"");
    if ((ifnGetHostId(szHostId))== 0)
    {
        iExisteHostID  = 1; /* Existe Host Id */
        vDTrazasLog(modulo, "\n\t ** HOST ID [%s] **",LOG03,szHostId);
    }
    else
    {
        iExisteHostID  = 0; /* NO Existe Host Id */
        vDTrazasLog(modulo, "\n\t ** No está configurado HOST ID **",LOG03);
    }
    
    /* Recupera Tipo Foliacion desde Tabla GE_TIPDOCUMEN de acuerdo a Tipo Documento */
    if (!bfnGetTipoFoliacion( lhCodTipDocum ,sTipoFoliacion ))
    {
        return FALSE;
    }

    /*  C I C L O  */
    if (bpOptCiclo &&(iOpcion == iPROCESO_CONSUMIR))
    {
       if (strcmp(sTipoFoliacion,"P")==0)
       {
          iCodProceso =iPROC_FOLIACION;
       }
       else
       {
          iCodProceso =iPROC_AUTOFOLIACION;
       }

       if (iExisteHostID ==0)
       {
           if (!bfnValidaTrazaProc( lCodCiclFact, iCodProceso, iIND_FACT_ENPROCESO))
           {
                return (FALSE);
           }
           bfnSelectTrazaProc( lCodCiclFact, iCodProceso, &stTrazaProc);
       }
       else
       {
           if (!bfnValidaTrazaProcHost( lCodCiclFact, iCodProceso, iIND_FACT_ENPROCESO, szHostId))
           {
                return (FALSE);
           }
           if ((iGetRangosHost(szHostId, lCodCiclFact, &lClieIniBD, &lClieFinBD))==0 )
           {
                lClieIni = lClieIniBD;
                lClieFin = lClieFinBD;
           }
           else
           {
                vDTrazasLog(modulo, "(AVISO) main(): No se rescatan datos de Rango de clientes desde base de datos\n"
                                    "\t\tSe mantienen datos ingresados desde linea de comando (Si existen).", LOG05);
           }
           
           bfnSelectTrazaProcHost (lCodCiclFact, iCodProceso, &stTrazaProc, szHostId);
       }

        if (!fnOraCommit())
        {
            vDTrazasLog( modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            vDTrazasError( modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
            return(FALSE);
        }
        if (!bfnSelectSysDate(szFecha))
        {
            return(FALSE);
        }
        bPrintTrazaProc(stTrazaProc);
    }

/***************************************************************************************************/
     /*  N O   C I C L O  */
    if (!bpOptCiclo)
    {
        memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
        strcpy( stIntQueueProc.szCodModGener , szCodModGener);
        stIntQueueProc.lCodProceso   = iPROCESO_INT_FOLIACION_BATCH;
        strcpy(stIntQueueProc.szCodAplic,"FAC");

        if (!bfnGetIntQueueProc(&stIntQueueProc))
        {
            return FALSE;
        }
    }
/***************************************************************************************************/
    if (!bfnOpenDocumFoli(lTipDocum,lClieIni,stIntQueueProc.iCodEstaDocEnt,iESTAPROC_TERMINADO_OK,szCodModGener,
                         bpOptCiclo,lCodCiclFact,sTipoFoliacion,lClieFin))
    {
        return(FALSE);
    }

    lhFolioUpdate = lFolIni;
    while (iSql == SQLOK)
    {
           iSql=bfnFetchDocumFoli(&stAux);

           if ((iSql !=SQLOK) &&(iSql !=SQLNOTFOUND))
           {
                return(FALSE);
           }

           if (iSql == SQLOK)
           {
               if ((stRegDocumFoli.stRegFolio =
                   (FOLIACIONREGDOCUM*)realloc((FOLIACIONREGDOCUM*)stRegDocumFoli.stRegFolio,
                   (stRegDocumFoli.iNumReg + 1) * sizeof (FOLIACIONREGDOCUM)))
                                        ==  (FOLIACIONREGDOCUM *)NULL)
               {
                    vDTrazasError(szExeName,"Error en redimension stRegDocumFoli realloc ",LOG01);
                    vDTrazasLog(szExeName,"Error en redimension stRegDocumFoli realloc ",LOG01);
                    return FALSE;
               }

               memcpy (&stRegDocumFoli.stRegFolio [stRegDocumFoli.iNumReg], &stAux,sizeof (FOLIACIONREGDOCUM));
               stRegDocumFoli.iNumReg++              ;
           }
    }
    
    if (!bfnCloseDocumFoli())
    {
       vDTrazasLog( modulo , "\n\n\tError al cerrar el Cursor Cur_FacturFolios : %s", LOG01, SQLERRM);
       vDTrazasError( modulo , "\n\n\tError al cerrar el Cursor Cur_FacturFolios : %s", LOG01, SQLERRM);
       return FALSE;
    }

    for (i=0;i<stRegDocumFoli.iNumReg;i++)
    {
        if (lhFolioUpdate != lFolIni + lCant )
        {
          /****************************************************************/
          /*   Foliar Documento Impreso                                   */
          /****************************************************************/
          if (iOpcion == iPROCESO_CONSUMIR)
          {
             /* N O   C I C L O */          	
             if (!bpOptCiclo)
             {
                /****************************************************************/
                /*  Obtiene registro de la Interfaz           */
                /****************************************************************/
                memset(&stInterFact,0,sizeof(INTERFACT));
                stInterFact.lNumProceso     = stRegDocumFoli.stRegFolio[i].lhNumProceso ;
                strcpy(stInterFact.szCodAplic,"FAC");

                if (!bfnGetInterFact(&stInterFact))
                {
                    vDTrazasError(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                                           ,LOG01,SQLCODE,szfnORAerror());
                    vDTrazasLog(szExeName,"Error obtencion de FA_INTERFACT [%ld] [%s]"
                                         ,LOG01,SQLCODE,szfnORAerror());
                    return FALSE;
                }
                /****************************************************************/
                stInterFact.iCodEstaDoc = stIntQueueProc.iCodEstaDocSal;    /* Foliada */
                stInterFact.iCodEstaProc= iESTAPROC_PROCESANDO ;        /* PROCESANDO */
                strcpy(stInterFact.szCodAplic,"FAC");

                if (!bfnUpdInterFact(stInterFact))
                {
                   vDTrazasLog( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
                   vDTrazasError( modulo, " Al Marcar registro como 'Procesando' ",LOG01);
                   fnOraRollBack();
                }
                else
                {
                   if (!bfnOraCommit())
                   {
                       vDTrazasLog( modulo, " Al hacer Commit ",LOG01);
                       vDTrazasError( modulo, " Al hacer Commit ",LOG01);
                   }
                }
             }
                
             if (!bfnUpdateFolio(&stRegDocumFoli.stRegFolio[i],lhFolioUpdate,bpOptCiclo,lConFolio,szCodigoOperadora,szPrefijoFolio))
             {
                 vDTrazasLog( modulo , "\n\t** Error al Marcar Folio a Documento(bfnUpdateFolio)",LOG01);
                 vDTrazasError( modulo , "\n\t** Error al Marcar Folio a Documento(bfnUpdateFolio)",LOG01);

                 if (!bpOptCiclo) /* N O   C I C L O */
                 {
                    stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_ERROR ; /* ERROR */
                    strcpy(stInterFact.szCodAplic,"FAC");

                    if (!bfnUpdInterFact(stInterFact))
                    {
                       vDTrazasLog( modulo, " Al Marcar registro como 'Erroneo' ",LOG01);
                       vDTrazasError( modulo, " Al Marcar registro como 'Erroneo' ",LOG01);
                       fnOraRollBack();
                    }
                 }
                 return(FALSE);
             }
             
             if (!bfnOraCommit())
             {
                 vDTrazasLog( modulo, " Al hacer Commit ",LOG01);
                 vDTrazasError( modulo, " Al hacer Commit ",LOG01);
             }
                 if (!bpOptCiclo) /* N O   C I C L O */
                 {
                    strcpy(stInterFact.szFecFoliacion, cfnGetTime(7)); /* Fecha Foliacion */
                    stInterFact.iCodEstaProc= iESTAPROC_TERMINADO_OK ;
                    strcpy(stInterFact.szCodAplic, "FAC");

                    if (!bfnUpdInterFact(stInterFact))
                    {
                        vDTrazasLog( modulo, " Al Marcar registro como 'Terminado' ",LOG01);
                        vDTrazasError( modulo, " Al Marcar registro como 'Terminado' ",LOG01);
                        fnOraRollBack();
                    }
                    else
                    {
                        if (!bfnOraCommit())
                        {
                            vDTrazasLog( modulo, " Al hacer Commit ",LOG01);
                            vDTrazasError( modulo, " Al hacer Commit ",LOG01);
                        }
                    }
                 }
          }

          /****************************************************************/
          /*   Imprimir Documento Impreso                                 */
          /****************************************************************/
          if (!bfnPrintFolio(&stRegDocumFoli.stRegFolio[i],lhFolioUpdate))
          {
              vDTrazasLog( modulo , "\n\t** Error al Imprimir Archivo de Folios(bfnPrintFolio)",LOG01);
              vDTrazasError( modulo , "\n\t** Error al Imprimir Archivo de Folios(bfnPrintFolio)",LOG01);
              return(FALSE);
          }
          lhFolioUpdate++; lConFolio ++;
        }
    }

    vDTrazasLog( modulo , "\n\t**  Ultimo Rango Usado con Folio [%ld] [%ld]**",LOG03,lhFolioUpdate - 1,lConFolio);

    if (bpOptCiclo &&(iOpcion == iPROCESO_CONSUMIR) )
    {
       if (bfbFinFoliacion(lCodCiclFact,iExisteHostID,lClieIni,lClieFin))
       {
          if (!bfnSelectSysDate(szFecha))
          {
             return(FALSE);
          }
          else
          {
             stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
             strcpy(stTrazaProc.szFecTermino,szFecha)                                ;
             strcpy(stTrazaProc.szGlsProceso,"Proceso de Foliacion de Documentos OK");
             stTrazaProc.lCodCliente        = 0                                      ;
             stTrazaProc.lNumAbonado        = 0                                      ;
             stTrazaProc.lNumRegistros      = 0                                      ;
             bPrintTrazaProc(stTrazaProc);

             if (iExisteHostID ==0)
             {
                 if (!bfnUpdateTrazaProc (stTrazaProc))
                 {
                      return (FALSE);
                 }
             }
             else
             {
                 if (!bfnUpdateTrazaProcHost (stTrazaProc, szHostId))
                 {
                     return (FALSE);
                 }
             }
          }
       }
    }

    return TRUE;

}/* END bfnFoliacion */


/* ************************************************************************* */
/* * FUNCION : bfnOpenDocumFoli                                            * */
/* * USO     : Crea y Abre un Cursor sobre los documentos a Foliar         * */
/* ************************************************************************* */
BOOL bfnOpenDocumFoli ( long lTipoDocumen
                       ,long lCodClieIni
                       ,int iCodEstaDocEnt
                       ,int iCodEstProc
                       ,char *szModGen
                       ,BOOL bpOptCiclo
                       ,long lCodCiclFact
                       ,char *psTipoFoliacion
                       ,long lCodClieFin)
{
    char modulo[]="bfnOpenDocumFoli";
    char szCadenaSQL[2048] = "";
    char szCadena[512] = "";

    vDTrazasLog( modulo ,"\n\t*** Entrada en %s ***"
                         "\n\t\t=> Cod.TipDocum          [%ld]"
                         "\n\t\t=> Cliente Inicial       [%ld]"
                         "\n\t\t=> Cod. Modo Generacion  [%s]"
                         "\n\t\t=> Foliacion de Ciclo    [%s]"
                         "\n\t\t=> Cod.CiclFact          [%ld]"
                        ,LOG03
                        ,modulo
                        ,lTipoDocumen
                        ,lCodClieIni
                        ,szModGen
                        ,(bpOptCiclo?"SI":"NO")
                        ,lCodCiclFact);

    vDTrazasLog ( modulo , " Flag de Procesamiento de documento en cero: [%c]",LOG03,pstParamGener.sDocumentoCero);
    if (pstParamGener.sDocumentoCero == 'N')
    {
        strcpy(szCadena,"AND FACT.TOT_FACTURA  >  0 ");
    }
    else
    {
        strcpy(szCadena,"AND FACT.TOT_FACTURA  >= 0 ");
    }

    if (lCodClieFin > 0)
    {
        sprintf (szCadena,"%s AND FACT.COD_CLIENTE  <= %ld",szCadena, lCodClieFin );
    }

    if (bpOptCiclo)
    {
        sprintf(szCadenaSQL,
        " SELECT FACT.ROWID, "
        " FACT.COD_CLIENTE, "
        " FACT.IND_ORDENTOTAL, "
        " FACT.TOT_FACTURA, "
        " TO_CHAR(FACT.FEC_EMISION,'YYYYMMDD'), "
        " TO_CHAR(FACT.FEC_EMISION,'HH24MISS'), "
        " FACT.COD_CENTREMI, "
        " FACT.COD_TIPDOCUM, "
        " 0,  " /* Se inserta tapa llenar num_proceso */
        " FACT.TOT_CARGOSME, " 
        " FACT.ACUM_IVA, "     
        /*" DECODE(IDENT.COD_TIPIDENTDIAN,'43','0',REPLACE(CLIE.NUM_IDENTTRIB,'-')), "*/ /* P-MIX-09003 137744 */
        " NVL(IDENT.COD_TIPIDENTDIAN, '00') "
        " FROM FA_FACTDOCU_%ld FACT, "
        "      FA_CODESPACHO   ARCH, "
        "      FA_FACTCLIE_%ld CLIE, "
        "      GE_TIPIDENT IDENT "
        " WHERE FACT.NUM_FOLIO = 0 "
        " AND TRIM(FACT.COD_DESPACHO) = TRIM(ARCH.COD_DESPACHO) "
        " AND FACT.COD_TIPDOCUM = %ld "
        " AND FACT.COD_CLIENTE  >= %ld "
        " AND FACT.IND_ANULADA  = 0 "
        " AND FACT.IND_IMPRESA  = %d "
        " AND FACT.IND_SUPERTEL = 0 "
        " AND FACT.IND_FACTUR   = 1 "
        " AND FACT.IND_ORDENTOTAL = CLIE.IND_ORDENTOTAL "
        " AND CLIE.COD_TIPIDTRIB = IDENT.COD_TIPIDENT "
        " %s "
        " ORDER BY FACT.COD_TIPDOCUM, "
        " ARCH.COD_PRIORIDAD, "
        " FACT.COD_CLIENTE, "
        " FACT.IND_ORDENTOTAL"
        ,lCodCiclFact        
        ,lCodCiclFact         
        ,lTipoDocumen
        ,lCodClieIni
        ,(strcmp(psTipoFoliacion,"P")==0?1:0)
        ,szCadena
        );
    }
    else
    {
      sprintf(szCadenaSQL,
      " SELECT A.ROWID, "
      " A.COD_CLIENTE, "
      " A.IND_ORDENTOTAL, "
      " A.TOT_FACTURA, "
      " TO_CHAR(A.FEC_EMISION,'YYYYMMDD'), "
      " A.COD_CENTREMI, "
      " A.COD_TIPDOCUM, "
      " B.NUM_PROCESO "             /* NumProceso -- szhRowidInterfaz */
      " FROM FA_FACTDOCU_NOCICLO A, FA_INTERFACT B "
      " WHERE A.NUM_PROCESO  = B.NUM_PROCESO "
      " AND COD_APLIC = 'FAC' "   
      " AND B.COD_ESTADOC  = %d "         /* 300(impresion) nuevo */
      " AND B.COD_ESTPROC  = %d "         /*   3(termino ok) nuevo */
      " AND A.COD_TIPDOCUM = %ld "        /* parametro */
      " AND A.IND_ANULADA  = 0 "
      " AND A.COD_CLIENTE  >= %ld "       /* parametro */
      " AND A.IND_IMPRESA  = %d "         /* Prefoliado = 1: Auto = 0 */
      " AND B.COD_MODGENER = '%s' "       /* parametro */
      " AND A.NUM_FOLIO    = 0 "
      " AND( B.NUM_FOLIO  = 0 OR B.NUM_FOLIO IS NULL ) "
      " %s "
      " ORDER BY A.COD_CLIENTE, A.IND_ORDENTOTAL "  /* FOR UPDATE "  se elimina el lockeo por problemas con los commit  */
      ,iCodEstaDocEnt
      ,iCodEstProc
      ,lTipoDocumen
      ,lCodClieIni
      ,(strcmp(psTipoFoliacion,"P")==0?1:0)
      ,szModGen
      ,(lTipoDocumen == 25 ? " ": pstParamGener.sDocumentoCero == 'N' ? " AND A.TOT_FACTURA > 0 ": " AND A.TOT_FACTURA >= 0 "));
    }

    vDTrazasLog( modulo , "\n\t*** Query ***\n\t\t[%s]",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Facturas_Folios FROM :szCadenaSQL; */ 

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
        vDTrazasLog( modulo , "\n\t**  Error en SQL-PREPARE sql_Facturas_Folios **"
                              "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo , "\n\t**  Error en SQL-PREPARE sql_Facturas_Folios **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_FacturFolios CURSOR FOR sql_Facturas_Folios; */ 

    
    if (SQLCODE)
    {
        vDTrazasLog( modulo , "\n\t**  Error en SQL-DECLARE Cur_FacturFolios **"
                              "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo , "\n\t**  Error en SQL-DECLARE Cur_FacturFolios **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL OPEN Cur_FacturFolios ; */ 

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


    
    if (SQLCODE)
    {
        vDTrazasLog( modulo , "\n\t**  Error en SQL-OPEN CURSOR Cur_FacturFolios **"
                              "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo , "\n\t**  Error en SQL-OPEN CURSOR Cur_FacturFolios **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }
    return(TRUE);
}/* END bfnOpenDocumFoli */

/* ************************************************************************* */
/* * FUNCION : bfnFetchDocumFoli                                           * */
/* * USO     : Lee Un Registro de los documentos a Foliar                  * */
/* ************************************************************************* */
BOOL bfnFetchDocumFoli(FOLIACIONREGDOCUM *pstRegDocumFoli)
{
    char modulo[]="bfnFetchDocumFoli"; 

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    szhRowid         [20]; /* EXEC SQL VAR szhRowid        IS STRING(20); */ 

         long    lhCodCliente         ;
         long    lhIndOrdenTotal      ;
         double  dhTotFactura         ;
         char    szhFecEmision    [20]; /* EXEC SQL VAR szhFecEmision   IS STRING(20); */ 

         char    szhHorEmision    [20]; /* EXEC SQL VAR szhHorEmision   IS STRING(20); */ 

         int     ihCodCentrEmi        ;
         long    lhCodTipDocum        ;
         long    lhNumProceso         ;
         double  dhTotCargosMe        ; 
         double  dhAcumIva            ; 
         char    szhNumIdTrib     [21]; /* EXEC SQL VAR szhNumIdTrib    IS STRING(21); */ 

         char    szhCodIdTipDian   [3]; /* EXEC SQL VAR szhCodIdTipDian IS STRING(3); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo , "\n\t*** Entrada en %s ***",LOG03,modulo);

    /* EXEC SQL FETCH Cur_FacturFolios INTO
                :szhRowid           ,
                :lhCodCliente       ,
                :lhIndOrdenTotal    ,
                :dhTotFactura       ,
                :szhFecEmision      ,
                :szhHorEmision      ,
                :ihCodCentrEmi      ,
                :lhCodTipDocum      ,
                :lhNumProceso       ,
                :dhTotCargosMe      ,
                :dhAcumIva          ,
                /o:szhNumIdTrib       ,o/ /o P-MIX-09003 137744 o/
                :szhCodIdTipDian    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )39;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhIndOrdenTotal;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&dhTotFactura;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[4] = (unsigned long )20;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhHorEmision;
    sqlstm.sqhstl[5] = (unsigned long )20;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCentrEmi;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodTipDocum;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhTotCargosMe;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhAcumIva;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhCodIdTipDian;
    sqlstm.sqhstl[11] = (unsigned long )3;
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

                                        

    if ( SQLCODE == SQLNOTFOUND )
    {
         vDTrazasLog( modulo ,  "\n\t**  No Existen Mas Documentos en CURSOR Cur_FacturFolios **",LOG02);
         return(SQLCODE);
    }
    else if (SQLCODE )
         {
             vDTrazasLog(modulo ,  "\n\t**  Error en FETCH sobre CURSOR Cur_FacturFolios  [%s] **"
                                ,LOG01,SQLERRM);
             vDTrazasError(modulo ,  "\n\t**  Error en FETCH sobre CURSOR Cur_FacturFolios  [%s] **"
                                  ,LOG01,SQLERRM);
             return(SQLCODE);
         }
    else
    {
        strcpy(pstRegDocumFoli->szhRowid       , szhRowid       )   ;
        strcpy(pstRegDocumFoli->szhFecEmision  , szhFecEmision  )   ;
        strcpy(pstRegDocumFoli->szhHorEmision  , szhHorEmision  )   ;
        pstRegDocumFoli->lhCodCliente        = lhCodCliente         ;
        pstRegDocumFoli->lhIndOrdenTotal     = lhIndOrdenTotal      ;
        pstRegDocumFoli->dhTotFactura        = dhTotFactura         ;
        pstRegDocumFoli->ihCodCentrEmi       = ihCodCentrEmi        ;
        pstRegDocumFoli->lhCodTipDocum       = lhCodTipDocum        ;
        pstRegDocumFoli->lhNumProceso        = lhNumProceso         ;
        pstRegDocumFoli->dhTotCargosMe       = dhTotCargosMe        ;
        pstRegDocumFoli->dhAcumIva           = dhAcumIva            ;
        /*strcpy(pstRegDocumFoli->szhNumIdTrib, szhNumIdTrib)         ;*/ /* P-MIX-09003 137744 */
        strcpy(pstRegDocumFoli->szhCodIdTipDian, szhCodIdTipDian)   ;
    }

    vDTrazasLog( modulo ,   "\t\t=> RowId              [%s]\n"
                            "\t\t=> Fecha Emision      [%s]\n"
                            "\t\t=> Hora Emision       [%s]\n" 
                            "\t\t=> Cliente            [%d]\n"
                            "\t\t=> Ind OrdenTotal     [%ld]\n"
                            "\t\t=> Total Factura      [%f]\n"
                            "\t\t=> Valor Factura      [%f]\n" 
                            "\t\t=> Valor Iva          [%f]\n" 
                            /*"\t\t=> Id. Tributaria     [%s]\n"*/ /* P-MIX-09003 137744 */
                            "\t\t=> Cod. Tipo Id. Dian [%s]"
                            ,LOG05
                            ,pstRegDocumFoli->szhRowid
                            ,pstRegDocumFoli->szhFecEmision
                            ,pstRegDocumFoli->szhHorEmision    
                            ,pstRegDocumFoli->lhCodCliente
                            ,pstRegDocumFoli->lhIndOrdenTotal
                            ,pstRegDocumFoli->dhTotFactura   
                            ,pstRegDocumFoli->dhTotCargosMe    
                            ,pstRegDocumFoli->dhAcumIva        
                            /*,pstRegDocumFoli->szhNumIdTrib*/ /* P-MIX-09003 137744 */
                            ,pstRegDocumFoli->szhCodIdTipDian);

    return(SQLCODE);
}/* END bfnFetchDocumFoli */

/* ************************************************************************* */
/* * FUNCION : bfnCloseDocumFoli                                           * */
/* * USO     : Cierra el Cursor de documentos a Foliar                     * */
/* ************************************************************************* */
BOOL bfnCloseDocumFoli()
{
    char modulo[]="bfnCloseDocumFoli";

    vDTrazasLog( modulo , "\n\t*** Entrada en %s ***",LOG03,modulo);

    /* EXEC SQL CLOSE Cur_FacturFolios; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )102;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
    {
        return FALSE;
    }
    
    return TRUE;
}/* END bfnCloseDocumFoli */

/* ************************************************************************* */
/* * FUNCION : bfnUpdateFolio(stRegDocumFoli,lFolioUpdate)                 * */
/* * USO     : Modifica el Folio de un Documento                           * */
/* ************************************************************************* */
BOOL bfnUpdateFolio(FOLIACIONREGDOCUM *pstRegDocumFoli
                   ,long lFolUpd
                   ,BOOL bpOptCic
                   ,int iNumFoli
                   ,char *sCod_oper
                   ,char *szPrefijo_in)
{
    char        modulo[]="bfnUpdateFolio";
    int         iNumParametros;
    int         lNumParametros;
    char        *szArregloParametros[10];
    int         iEstadoFolio;
    char        szCadenaSQL[2048] = "";
    long        lTip_Docum ;
    char        szCadenaResultado [500]; 
    char        szCamposEncriptados[41]; 

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char  szhRowid         [20]; /* EXEC SQL VAR szhRowid        IS STRING(20); */ 

         char  szhFecEmision    [20]; /* EXEC SQL VAR szhFecEmision   IS STRING(20); */ 

         char  szhHorEmision    [20]; /* EXEC SQL VAR szhHorEmision   IS STRING(20); */ 

         long  lhFolio              ;
         char  szhCodOficina     [3]; /* EXEC SQL VAR szhCodOficina   IS STRING(3); */ 

         long  lCorre_Folio         ;
         long  lCodVendedor         ;
         char  sCodOperadora     [6];
         char  szpref_folio   [25+1]; /* EXEC SQL VAR szpref_folio    IS STRING(25+1); */ 

         char  szprefini         [7];
         char  szhRetorno   [250]="";
         int   lNumeroVenta    = 10 ;
         long  lhRanDesde           ;
         int   lNumeroProceso  = 100;
         long  lhCodTipDocum        ;
         char  szhCodigoOper     [5];
         long  lhTipDocumento       ;
         long  lhCantidad           ;
         long  lhCodVendedor        ;
         char  szhCadena      [1999]; /* EXEC SQL VAR szhCadena       IS STRING(1999); */ 

         long  lhInd_Ordentotal     ;
         char  szNumIdTrib      [21]; /* EXEC SQL VAR szNumIdTrib     IS STRING(21); */ 
 
         char  szNitOperadora   [16]; /* EXEC SQL VAR szNitOperadora  IS STRING(16); */ 

         char  szKeyConTecnico  [41]; /* EXEC SQL VAR szKeyConTecnico IS STRING(41); */ 

         char  szCodIdTipDian    [3]; /* EXEC SQL VAR szCodIdTipDian  IS STRING(3); */ 
 
         /* P-MIX-09003 */
         char  szResolucion   [25+1]; /* EXEC SQL VAR szCodIdTipDian  IS STRING(25+1); */ 
 
         char  szSerie        [10+1]; /* EXEC SQL VAR szCodIdTipDian  IS STRING(10+1); */ 
 
         char  szEtiqueta     [10+1]; /* EXEC SQL VAR szCodIdTipDian  IS STRING(10+1); */ 
 
         char  szFecResolucion[10+1]; /* EXEC SQL VAR szCodIdTipDian  IS STRING(10+1); */ 
 
         long  lhRangoDesde         ;
         long  lhRangoHasta         ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo ,   "\n\t*** Entrada en %s ***"
                     		"\n\t\t=> Cod.TipDocum     [%ld]"
                            "\n\t\t=> Cod. Ciclo Fact. [%ld]"
                            "\n\t\t=> Cliente          [%ld]"
                            "\n\t\t=> Numero de Folio  [%ld]"
                            "\n\t\t=> Folios           [%d] "
                            ,LOG03
                            ,modulo
                            ,stLineaComando.lTipoDocumen
                            ,stLineaComando.lCodCiclFact
                            ,pstRegDocumFoli->lhCodCliente
                            ,lFolUpd
                            ,iNumFoli );

    strcpy(szhCodOficina,"\0");
    lhFolio = lFolUpd;
    lTip_Docum = pstRegDocumFoli->lhCodTipDocum  ;
    strcpy(szhRowid, "\0")  ;
    strcpy(szhRowid, pstRegDocumFoli->szhRowid)  ;
    
    strcpy(szhFecEmision,pstRegDocumFoli->szhFecEmision);
    strcpy(szhHorEmision,pstRegDocumFoli->szhHorEmision);    

    lhCodTipDocum = stRegAuxiliar.lCodTipDocum;  
    lCodVendedor  = stRegAuxiliar.lCodVendedor;
    lhRanDesde    = stRegAuxiliar.lRanDesde;

    strcpy(sCodOperadora,sCod_oper);
    strcpy(szprefini,szPrefijo_in);

    vDTrazasLog(modulo ,"\n\t****  Ejecuta función de CONSUMO DE FOLIO "
                        "\n\t\t=>Rowid [%s]  "
                        "\n\t\t=>p_ntipo_documento IN NUMBER [%ld]"
                        "\n\t\t=>p_nCod_vendedor   IN NUMBER [%ld]"
                        "\n\t\t=>p_vCod_oficina    IN VARCHAR[%s]"
                        "\n\t\t=>p_vCod_operadora  IN VARCHAR[%s]"
                        "\n\t\t=>p_nNumero_venta   IN NUMBER [%ld]"
                        "\n\t\t=>p_nNumero_proceso IN NUMBER [%ld]"
                        "\n\t\t=>p_vprefijo_folio  IN VARCHAR[%s]"
                        "\n\t\t=>p_ncorrela_folio  IN NUMBER [%ld]"
                        "\n\t\t=>lhRanDesde                  [%ld]"
                       ,LOG04
                       ,szhRowid
                       ,lhCodTipDocum
                       ,lCodVendedor
                       ,szhCodOficina
                       ,sCodOperadora
                       ,lNumeroVenta 
                       ,lNumeroProceso
                       ,szprefini    
                       ,lhFolio
                       ,lhRanDesde);

    /*------------------------------------------------------------------------------------
      Se ejecuta la función fa_foliacion_pg.FA_CONSUME_FOLIO_FN
    -------------------------------------------------------------------------------------*/

    if ((ifnObtieneParam() == 1) && (bpOptCic))
    {
        /* Obtención del Código de Oficina Primera Venta, szhCodigoOper (retorno), szhCodOficina (retorno) */
        bfnObtOficEmis(pstRegDocumFoli->lhCodCliente, szhCodigoOper, szhCodOficina);
        if (strcmp(szhCodOficina, "--") == 0)
        {
            vDTrazasLog  (szExeName,"\n\t** Error En la obtencion de Oficina Emisora**\n",LOG01);
            return FALSE;
        }

        trim(szhCodigoOper, szhCodigoOper);
        lhTipDocumento = stLineaComando.lTipoDocumen;
        lhCantidad     = stLineaComando.lCantidad;

        vDTrazasLog (szExeName,"\n\t** Oficina Emisora=[%s]\n"
                               "\t** Operadora      =[%s]\n"
                               "\t** Tipo Documento =[%ld]\n"
                               "\t** Nro Venta      =[%ld]\n"
                               "\t** Nro Proceso    =[%ld]\n"
                               "\t** Cantidad       =[%ld]\n"
                              ,LOG03
                              ,szhCodOficina
                              ,szhCodigoOper
                              ,lhTipDocumento
                              ,lNumeroVenta
                              ,lNumeroProceso
                              ,lhCantidad );

        vDTrazasLog  (szExeName,"\n\t** RAN_DESDE    =[%ld]\n"
                                "\t** COD_TIPDOCUM =[%ld]\n"
                                "\t** COD_VENDEDOR =[%ld]\n"
                               ,LOG03
                               ,lhRanDesde
                               ,lhTipDocumento
                               ,lhCodVendedor );
                               
        sprintf(szCadenaSQL,"SELECT RAN_DESDE, COD_TIPDOCUM, NVL(COD_VENDEDOR,0) "
                            "FROM   AL_ASIG_DOCUMENTOS "
                            "WHERE  COD_OFICINA = FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN('%s') "
                            "AND    COD_TIPDOCUM = (SELECT COD_TIPDOCUM "
                            "                       FROM FA_TIPDOCUMEN "
                            "                       WHERE COD_TIPDOCUMMOV = %ld ) "
                            "AND    RAN_USADO + %ld  <= RAN_HASTA "
                            "ORDER BY RAN_DESDE, FEC_RESOLUCION ASC "                             
                            ,szhCodOficina
                            ,lhTipDocumento
                            ,lhCantidad);
                            
        /* EXEC SQL PREPARE sql_al_asig_documentos FROM :szCadenaSQL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )117;
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
            vDTrazasLog( modulo , "\n\t**  Error en SQL-PREPARE sql_al_asig_documentos **"
                                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError( modulo , "\n\t**  Error en SQL-PREPARE sql_al_asig_documentos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return(FALSE);
        }  
        
        /* EXEC SQL DECLARE Cur_al_asig_documentos CURSOR FOR sql_al_asig_documentos; */ 

                
        if (SQLCODE)
        {
            vDTrazasLog( modulo , "\n\t**  Error en SQL-DECLARE Cur_al_asig_documentos **"
                                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError( modulo , "\n\t**  Error en SQL-DECLARE Cur_al_asig_documentos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return(FALSE);
        }
        
        /* EXEC SQL OPEN Cur_al_asig_documentos ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )136;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



        /* EXEC SQL FETCH Cur_al_asig_documentos INTO :lhRanDesde, :lhTipDocumento, :lhCodVendedor; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )151;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhRanDesde;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhTipDocumento;
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
            vDTrazasLog  (modulo ,"\n\t**  Error en FETCH sobre CURSOR Cur_al_asig_documentos  [%s] **"
                                 ,LOG01,SQLERRM);
            vDTrazasError(modulo ,"\n\t**  Error en FETCH sobre CURSOR Cur_al_asig_documentos  [%s] **"
                                 ,LOG01,SQLERRM);
            return(FALSE);
        }        

        vDTrazasLog  (szExeName,"\n\t**Antes de la llamada a consumir folios "
                                "\t=> Tip Documento  [%ld]\n"
                                "\t=> Cod Vendedor   [%ld]\n"
                                "\t=> Cod Oficina    [%s] \n"
                                "\t=> CodOperadora   [%s] \n"
                                "\t=> Rango Desde    [%ld]\n"
                                "\t=> Numero Venta   [%ld]\n"
                                "\t=> Numero Proceso [%ld]\n"
                               ,LOG05
                               ,lhTipDocumento
                               ,lCodVendedor
                               ,szhCodOficina
                               ,sCodOperadora
                               ,lhRanDesde
                               ,lNumeroVenta
                               ,lNumeroProceso);
                               
        /* EXEC SQL 
             SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(
                    :lhTipDocumento
                    ,decode(:lhCodVendedor,0,NULL,:lhCodVendedor)
                    ,:szhCodOficina
                    ,:szhCodigoOper
                    ,:lhRanDesde
                    ,:lNumeroVenta
                    ,:lNumeroProceso
                    ,SYSDATE
                    ,2 )
            INTO    :szhRetorno
            FROM    DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(:b0,decode\
(:b1,0,null ,:b1),:b3,:b4,:b5,:b6,:b7,SYSDATE,2) into :b8  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )178;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhTipDocumento;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodigoOper;
        sqlstm.sqhstl[4] = (unsigned long )5;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhRanDesde;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lNumeroVenta;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lNumeroProceso;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhRetorno;
        sqlstm.sqhstl[8] = (unsigned long )250;
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


    
        /* EXEC SQL CLOSE Cur_al_asig_documentos; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
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

    
            
    }
    else
    {
        /* Obtiene oficina donde se realizó la Nota de credito */
        if (lTip_Docum == 25) /* Nota de credito */
        {
            lhInd_Ordentotal = pstRegDocumFoli->lhIndOrdenTotal;

            if (bpOptCic)
            {
                sprintf(szCadenaSQL,"SELECT COD_OFICINA "
                                    "FROM   FA_FACTDOCU_%ld "
                                    "WHERE  IND_ORDENTOTAL = %ld"
                                   ,stLineaComando.lCodCiclFact
                                   ,lhInd_Ordentotal);

                /* EXEC SQL PREPARE sql_oficina_NC FROM :szCadenaSQL; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 12;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )244;
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
                    vDTrazasLog( modulo , "\n\t**  Error en SQL-PREPARE sql_oficina_NC **"
                                          "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasError( modulo , "\n\t**  Error en SQL-PREPARE sql_oficina_NC **"
                                            "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    return(FALSE);
                }

                /* EXEC SQL DECLARE Cur_Oficina_NC CURSOR FOR sql_oficina_NC; */ 

                
                if (SQLCODE)
                {
                    vDTrazasLog( modulo , "\n\t**  Error en SQL-DECLARE Cur_Oficina_NC **"
                                         "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasError( modulo , "\n\t**  Error en SQL-DECLARE Cur_Oficina_NC **"
                                           "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
                    return(FALSE);
                }

                /* EXEC SQL OPEN Cur_Oficina_NC ; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 12;
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



                /* EXEC SQL FETCH Cur_Oficina_NC INTO :szhCodOficina; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 12;
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
                sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
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



                if (SQLCODE != SQLOK)
                {
                    vDTrazasLog  (modulo ,  "\n\t**  Error en FETCH sobre CURSOR Cur_Oficina_NC  [%s] **",LOG01,SQLERRM);
                    vDTrazasError(modulo ,  "\n\t**  Error en FETCH sobre CURSOR Cur_Oficina_NC  [%s] **",LOG01,SQLERRM);
                    return(FALSE);
                }
            }
            else
            {
                /* EXEC SQL 
                     SELECT COD_OFICINA
                     INTO   :szhCodOficina
                     FROM   FA_FACTDOCU_NOCICLO
                     WHERE IND_ORDENTOTAL = :lhInd_Ordentotal; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 12;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select COD_OFICINA into :b0  from FA_FACTDOCU\
_NOCICLO where IND_ORDENTOTAL=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )297;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
                sqlstm.sqhstl[0] = (unsigned long )3;
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhInd_Ordentotal;
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
                    vDTrazasLog(modulo ,  "\n\t**  Error en SELECT COD_OFICINA FA_FACTDOCU_NOCICLO   [%s] **",LOG01,SQLERRM);
                    vDTrazasError(modulo ,  "\n\t**  Error en SELECT COD_OFICINA FA_FACTDOCU_NOCICLO  [%s] **",LOG01,SQLERRM);
                    return(FALSE);
                }
            }
        }
        else
        {
            if (!bfnCargaOficinaAlAsigDocumento(lhFolio, lTip_Docum, szhCodOficina, szprefini))
            {
                return (FALSE);
            }
        } /* FIN Obtiene oficina donde se realizó la Nota de credito */


        lhTipDocumento  = lTip_Docum;
        lhCantidad      = stLineaComando.lCantidad;

        if (ifnObtieneParam() == 1)
        {
            /* EXEC SQL 
                 SELECT MIN(RAN_DESDE)
                 INTO   :lhRanDesde
                 FROM   AL_ASIG_DOCUMENTOS
                 WHERE COD_OFICINA   = FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN(:szhCodOficina)
                 AND COD_TIPDOCUM    = (SELECT COD_TIPDOCUM
                                        FROM FA_TIPDOCUMEN
                                        WHERE  COD_TIPDOCUMMOV = :lhTipDocumento)
                 AND RAN_USADO + :lhCantidad  <= RAN_HASTA; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select min(RAN_DESDE) into :b0  from AL_ASIG_DOCU\
MENTOS where ((COD_OFICINA=FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN(:b1) and COD_\
TIPDOCUM=(select COD_TIPDOCUM  from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b2)) \
and (RAN_USADO+:b3)<=RAN_HASTA)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )320;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhRanDesde;
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
            sqlstm.sqhstv[2] = (unsigned char  *)&lhTipDocumento;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCantidad;
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


        }
        else
        {
            /* EXEC SQL 
                 SELECT MIN(RAN_DESDE)
                 INTO :lhRanDesde
                 FROM AL_ASIG_DOCUMENTOS
                 WHERE COD_OFICINA     = :szhCodOficina
                 AND COD_TIPDOCUM    = (SELECT COD_TIPDOCUM
                                        FROM FA_TIPDOCUMEN
                                        WHERE  COD_TIPDOCUMMOV = :lhTipDocumento)
                 AND RAN_USADO + :lhCantidad  <= RAN_HASTA; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 12;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select min(RAN_DESDE) into :b0  from AL_ASIG_DOCU\
MENTOS where ((COD_OFICINA=:b1 and COD_TIPDOCUM=(select COD_TIPDOCUM  from FA_\
TIPDOCUMEN where COD_TIPDOCUMMOV=:b2)) and (RAN_USADO+:b3)<=RAN_HASTA)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )351;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhRanDesde;
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
            sqlstm.sqhstv[2] = (unsigned char  *)&lhTipDocumento;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCantidad;
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


        }

        /* EXEC SQL 
             SELECT NVL(COD_AGENTESTARTEL, 0)
             INTO  :lCodVendedor
             FROM  GE_DATOSGENER; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NVL(COD_AGENTESTARTEL,0) into :b0  from GE_DAT\
OSGENER ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )382;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lCodVendedor;
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
            vDTrazasLog( modulo ,  "\n\t**  No existe codigo de vendedor asociado. **", LOG02);
            return(FALSE);
        }


        vDTrazasLog  (szExeName,"\n\t**Antes de la llamada a consumir folios "
                                "\t=> Tip Documento  [%ld]\n"
                                "\t=> Cod Vendedor   [%ld]\n"
                                "\t=> Cod Oficina    [%s] \n"
                                "\t=> CodOperadora   [%s] \n"
                                "\t=> Rango Desde    [%ld]\n"
                                "\t=> Numero Venta   [%ld]\n"
                                "\t=> Numero Proceso [%ld]\n"
                               ,LOG05
                               ,lhTipDocumento
                               ,lCodVendedor
                               ,szhCodOficina
                               ,sCodOperadora
                               ,lhRanDesde
                               ,lNumeroVenta
                               ,lNumeroProceso);

        /* EXEC SQL 
             SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(
             :lhTipDocumento
             ,null
             ,:szhCodOficina
             ,:sCodOperadora
             ,:lhRanDesde
             ,:lNumeroVenta
             ,:lNumeroProceso
             ,SYSDATE
             ,2
             )
             INTO :szhRetorno
             FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(:b0,null ,\
:b1,:b2,:b3,:b4,:b5,SYSDATE,2) into :b6  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )401;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhTipDocumento;
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
        sqlstm.sqhstv[2] = (unsigned char  *)sCodOperadora;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhRanDesde;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lNumeroVenta;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lNumeroProceso;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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


    }

    /* Controla si la Función FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN retorno error */
    if (SQLCODE != SQLOK)
    {
        if (iNumFoli==0)
        {
            vDTrazasLog(modulo , " Retorno de funcion FA_CONSUME_FOLIO_FN FOLIO [%d] [%s] "
                               ,LOG01,SQLCODE,SQLERRM );
            vDTrazasError(modulo , " Retorno de funcion FA_CONSUME_FOLIO_FN FOLIO [%d] [%s] "
                                 ,LOG01,SQLCODE,SQLERRM );
        }
        else
        {
            vDTrazasLog(modulo , " Retorno de funcion FA_CONSUME_FOLIO_FN [%d] [%s]"
                               ,LOG01,SQLCODE,SQLERRM );
            vDTrazasError(modulo , " Retorno de funcion FA_CONSUME_FOLIO_FN [%d] [%s]"
                                 ,LOG01,SQLCODE,SQLERRM );
        }
        return(FALSE);
    }

    if (strcmp(szhRetorno,"") == 0)
    {
        vDTrazasLog  (szExeName,"\t** ERROR en Retorno fa_consume_folio_fn()=[%s]\n",LOG03, szhRetorno );
        return  FALSE;        
    }
    else
    {
        vDTrazasLog  (szExeName,"\t** Retorno fa_consume_folio_fn()=[%s]\n",LOG03, szhRetorno );
    }

    /* Recupera Parametros de szhRetorno función y setea iNumParametros = 3 */
    iNumParametros = 0;
    RecupParam(&iNumParametros,szArregloParametros,szhRetorno,cSEPARADOR_COMA);

    vDTrazasLog(szExeName,"\t** Parametros = [%d] [%s] [%s] [%s]\n"
                          "\t**            = [%s] [%s] [%s] [%s]\n" /* P-MIX-09003 */
                          "\t**            = [%s] [%s]\n"           /* P-MIX-09003 */
                         ,LOG05
                         ,iNumParametros
                         ,szArregloParametros[0]
                         ,szArregloParametros[1]
                         ,szArregloParametros[2]
                         ,szArregloParametros[3]  /*P-MIX-09003 */ /* RESOLUCION */
                         ,szArregloParametros[4]  /*P-MIX-09003 */ /* SERIE */                         
                         ,szArregloParametros[5]  /*P-MIX-09003 */ /* ETIQUETA */                                                  
                         ,szArregloParametros[6]  /*P-MIX-09003 */ /* RAN_DESDE */                                                  
                         ,szArregloParametros[7]  /*P-MIX-09003 */ /* RAN_HASTA */ 
                         ,szArregloParametros[8]  /*P-MIX-09003 */ /* FEC_RESOLUCION */                                                                          
                         );

    /*  Controla si retorna la cantidad de parametros incorrectos */
    if (iNumParametros!=10)
    {
        vDTrazasLog(modulo , " Retorno de funcion  RecupParam  numero de parametros entregados incorrecto = [%d]"
                           ,LOG05,iNumParametros);
        vDTrazasError(modulo , " Retorno de funcion  RecupParam  numero de parametros entregados incorrecto = [%d]"
                             ,LOG05,iNumParametros);
        return  FALSE;
    }

    /* ESTADO FOLIO */
    iEstadoFolio=atoi(szArregloParametros[0]);
    /* PREFIJO FOLIO */
    memset(szpref_folio,0,sizeof(szpref_folio));
    strncpy(szpref_folio,szArregloParametros[1],sizeof(szpref_folio)-1);
    /* CORRELATIVO FOLIO */
    lCorre_Folio = atol(szArregloParametros[2]);
    /* RESOLUCION FOLIO */
    memset(szResolucion,0,sizeof(szResolucion));
    strncpy(szResolucion,szArregloParametros[3],sizeof(szResolucion)-1);
    /* SERIE FOLIO */
    memset(szSerie,0,sizeof(szSerie));
    strncpy(szSerie,szArregloParametros[4],sizeof(szSerie)-1);
    /* ETIQUETA FOLIO */
    memset(szEtiqueta,0,sizeof(szEtiqueta));
    strncpy(szEtiqueta,szArregloParametros[5],sizeof(szEtiqueta)-1);    
    /* RANGO DESDE FOLIO */
    lhRangoDesde = atoi(szArregloParametros[6]);
    /* RANGO HASTA FOLIO */    
    lhRangoHasta = atoi(szArregloParametros[7]);
    /* FECHA RESOLUCION FOLIO */
    memset(szFecResolucion,0,sizeof(szFecResolucion));
    strncpy(szFecResolucion,szArregloParametros[8],sizeof(szFecResolucion)-1);        
    
    vDTrazasLog(modulo,"\t** Parametros Retorno Función FA_CONSUME_FOLIO_FN"
                       "\n\t =============================================="
                       "\n\t\tEstado Folio           [%d]"
                       "\n\t\tPrefijo Folio          [%s]"
                       "\n\t\tCorrelativo Folio      [%ld]"
                       "\n\t\tResolución Folio       [%s]"
                       "\n\t\tSerie Folio            [%s]"
                       "\n\t\tEtiqueta Folio         [%s]"
                       "\n\t\tRango Desde Folio      [%ld]"
                       "\n\t\tRango Hasta Folio      [%ld]"
                       "\n\t\tFecha Resolución Folio [%s]"
                      ,LOG05
                      ,iEstadoFolio
                      ,szpref_folio
                      ,lCorre_Folio
                      ,szResolucion
                      ,szSerie
                      ,szEtiqueta
                      ,lhRangoDesde
                      ,lhRangoHasta
                      ,szFecResolucion );

    /* Valida retorno de funcion */
    if ( iEstadoFolio==G_NFOLIOS_NOCOINCIDEN )
    {
         vDTrazasLog(modulo , "\nfuncion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN FOLIO  Prefijo Ingresado = [%s] <> Prefijo Retornado [%s] "
                              "\nfuncion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN FOLIO  Folio Ingresado   = [%ld] <> Folio Retornado  [%ld]"
                            ,LOG05
                            ,szprefini
                            ,szpref_folio
                            ,lhFolio
                            ,lCorre_Folio);
        vDTrazasError(modulo , "\nfuncion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN FOLIO  Prefijo Ingresado = [%s] <> Prefijo Retornado [%s]  "
                               "\nfuncion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN FOLIO  Folio Ingresado   = [%ld] <> Folio Retornado  [%ld]  "
                             ,LOG05
                             ,szprefini
                             ,szpref_folio
                             ,lhFolio
                             ,lCorre_Folio);
        return FALSE;
    }

    if (iEstadoFolio!=G_NESTADO_CONSUMIDO )
    {
        if (iNumFoli==0)
        {
            vDTrazasLog(modulo , " retorno de funcion   fa_foliacion_pg.FA_CONSUME_FOLIO_FN FOLIO [%d]",LOG05,iEstadoFolio);
            vDTrazasError(modulo , " retorno de funcion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN [%d]",LOG05,iEstadoFolio);
        }
        else
        {
            vDTrazasLog(modulo , " retorno de funcion   fa_foliacion_pg.FA_CONSUME_FOLIO_FN [%d]",LOG05,iEstadoFolio);
            vDTrazasError(modulo , " retorno de funcion  fa_foliacion_pg.FA_CONSUME_FOLIO_FN [%d]",LOG05,iEstadoFolio);
        }
        return FALSE;
    }
    
    /* Cod. Tipo Id. Dian */
    strcpy(szCodIdTipDian,pstRegDocumFoli->szhCodIdTipDian);
    /* Número Id. Tributaria */
    /*strcpy(szNumIdTrib, pstRegDocumFoli->szhNumIdTrib);*/ /* P-MIX-09003 137744 */
    /* Nit Operadora */
    strcpy(szNitOperadora,stDatosGener.szNitOperadora);
    /* Clave Contenido Tecnico */
    strcpy(szKeyConTecnico,stDatosGener.szClaConTecnico);
          
    /* Encripta campos concatenados */
    /*if (!bfnEncriptaContTec (szCadenaResultado,szpref_folio,
                             lCorre_Folio,szhFecEmision,szhHorEmision,
                             pstRegDocumFoli->dhTotCargosMe,pstRegDocumFoli->dhAcumIva,
                             szKeyConTecnico,szCodIdTipDian,
                             szNumIdTrib, szNitOperadora))
    {
       return(FALSE);    	
    }*/ /* P-MIX-09003 137744 */
        
    strcpy(szCadenaResultado,"."); /* P-MIX-09003 137744 */
        
    sprintf(szCamposEncriptados,"%s\0",szCadenaResultado);
    
    vDTrazasLog(modulo , "\n\t\tRetorno Funcion Encriptación [%s]",LOG05,szCamposEncriptados);     

    /* Limpia RecupParam */
    for(lNumParametros=0;lNumParametros<iNumParametros;lNumParametros++)    
    {
    	free(szArregloParametros[lNumParametros]);
    }

    strcpy(szhCadena, "\0");

    if(!bpOptCic)
    {
        sprintf(szCadenaSQL,"UPDATE FA_FACTDOCU_NOCICLO ");
    }
    else
    {
        sprintf(szCadenaSQL,"UPDATE FA_FACTDOCU_%ld ",stLineaComando.lCodCiclFact);
    }

    sprintf(szCadenaSQL,"%s "
                        "SET NUM_FOLIO  = %ld  , "
                        "PREF_PLAZA     = '%s' , "
                        "COD_OFICINA    = '%s' , "
                        "KEY_CONTECNICO = '%s' , "
                        "CONT_TECNICO   = '%s' , "
                        /* P-MIX-09003 */
                        "RESOLUCION     = '%s' , "
                        "FEC_RESOLUCION = TO_DATE('%s','DD-MM-YYYY') , "
                        "SERIE          = '%s' , "                        
                        "ETIQUETA       = '%s' , "                        
                        "RAN_DESDE      = %ld  , "
                        "RAN_HASTA      = %ld  "                        
                        /* P-MIX-09003 */
                        "WHERE ROWID    = '%s'"
                       ,szCadenaSQL
                       ,lCorre_Folio
                       ,szpref_folio
                       ,szhCodOficina
                       ,szKeyConTecnico
                       ,szCamposEncriptados
                        /* P-MIX-09003 */
                       ,szResolucion
                       ,szFecResolucion
                       ,szSerie
                       ,szEtiqueta
                       ,lhRangoDesde
                       ,lhRangoHasta
                        /* P-MIX-09003 */
                       ,szhRowid);

    vDTrazasLog( modulo , "\n\t*** Query ***\n\t\t[%s]",LOG05,szCadenaSQL);

    strcpy(szhCadena, szCadenaSQL);

    /* EXEC SQL PREPARE sql_Update_Folio FROM :szhCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )444;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadena;
    sqlstm.sqhstl[0] = (unsigned long )1999;
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
       vDTrazasLog( modulo , "\n\t**  Error en SQL-PREPARE sql_Update_Folio **"
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       vDTrazasError( modulo , "\n\t**  Error en SQL-PREPARE sql_Update_Folio **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       fnGrabaAnomalia( pstRegDocumFoli->lhNumProceso, 0,"New_FolBatch"
                       ,strcat(cfnGetTime(1), "=> Error en SQL-PREPARE sql_Update_Folio "));
       return(FALSE);
    }

    /* EXEC SQL EXECUTE sql_Update_Folio; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )463;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE != SQLOK)
    {
       vDTrazasLog( modulo,  "\n\t**  Error en SQL-UPDATE sql_Update_Folio **"
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       vDTrazasError( modulo , "\n\t**  Error en SQL-UPDATE sql_Update_Folio **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       fnGrabaAnomalia(pstRegDocumFoli->lhNumProceso, 0,"New_FolBatch"
                       , strcat(cfnGetTime(1), "=> Error en SQL-UPDATE sql_Update_Folio "));
       return(FALSE);
    }

    return(TRUE);
}/* END bfnUpdateFolio */

/* ***************************************************************************************************************** */
/* * FUNCION : bfnCargaOficinaAlAsigDocumento(long lFolio, long lTip_Docum, char *szCodOficina, char *szPrefPlaza) * */
/* * USO     : Carga Codigo de Oficina segun Num. Folio y Tipo de Docum.                                           * */
/* ***************************************************************************************************************** */
BOOL bfnCargaOficinaAlAsigDocumento(long lFolio, long lTip_Docum, char *szCodOficina, char *szPrefPlaza)
{
    char modulo[]="bfnCargaOficinaAlAsigDocumento";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhFolio               ;
         long lhTip_Docum           ;
         char szhCod_Oficina     [3]; /* EXEC SQL VAR szhCod_Oficina IS STRING(3); */ 

         char szhPrefPlaza      [26]; /* EXEC SQL VAR szhPrefPlaza   IS STRING(26)  ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    lhFolio = lFolio        ;
    lhTip_Docum = lTip_Docum ;
    strcpy(szhPrefPlaza, szPrefPlaza);

    vDTrazasLog(modulo ,"\tParametros en bfnCargaOficinaAlAsigDocumento: "
                        "\tFolio [%ld] - Tipo Docum [%ld]  "
                        ,LOG03,lFolio,lTip_Docum);

    if (ifnObtieneParam() == 1)
    {
        /* EXEC SQL
             SELECT DISTINCT COD_OFICINA
             INTO   :szhCod_Oficina
             FROM   AL_ASIG_DOCUMENTOS
             WHERE  :lhFolio BETWEEN RAN_DESDE AND RAN_HASTA
             AND    COD_TIPDOCUM =(SELECT COD_TIPDOCUM  FROM FA_TIPDOCUMEN
                                   WHERE  COD_TIPDOCUMMOV = :lhTip_Docum); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select distinct COD_OFICINA into :b0  from AL_ASIG_DO\
CUMENTOS where (:b1 between RAN_DESDE and RAN_HASTA and COD_TIPDOCUM=(select C\
OD_TIPDOCUM  from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b2))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )478;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhFolio;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhTip_Docum;
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


    }
    else
    {
        /* EXEC SQL
             SELECT DISTINCT COD_OFICINA
             INTO   :szhCod_Oficina
             FROM   AL_ASIG_DOCUMENTOS
             WHERE  :lhFolio BETWEEN RAN_DESDE AND RAN_HASTA
             AND    PREF_PLAZA = :szhPrefPlaza
             AND    COD_TIPDOCUM =(SELECT COD_TIPDOCUM  FROM FA_TIPDOCUMEN
                                   WHERE  COD_TIPDOCUMMOV = :lhTip_Docum); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select distinct COD_OFICINA into :b0  from AL_ASIG_DO\
CUMENTOS where ((:b1 between RAN_DESDE and RAN_HASTA and PREF_PLAZA=:b2) and C\
OD_TIPDOCUM=(select COD_TIPDOCUM  from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b3\
))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )505;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhFolio;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[2] = (unsigned long )26;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhTip_Docum;
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


    }

    if (SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog( modulo ,"\n\t**  No Existe Codigo de Oficina para Tipo de Documento [%ld] Folio [%ld] **"
                            ,LOG03,lhTip_Docum,lhFolio);
        return FALSE;
    }

    if (SQLCODE != SQLOK)
    {
        vDTrazasLog( modulo ,"\n\t**  Error en Select Al_Asig_Documentos(Codigo Oficina) **"
                             "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError( modulo ,"\n\t**  Error en Select Al_Asig_Documentos(Codigo Oficina) **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    strcpy(szCodOficina,szhCod_Oficina);
    vDTrazasLog(modulo ,"\tCodigo de Oficina [%s] ",LOG03,szCodOficina);

    return TRUE;

}/* END bfnCargaOficinaAlAsigDocumento */

/* ************************************************************************** */
/* * FUNCION : bfnPrintFolio                                                * */
/* * USO     : Imprime Documento y Folio Asignado para Control de Foliacion * */
/* ************************************************************************** */
BOOL bfnPrintFolio(FOLIACIONREGDOCUM *pstRegDocumFoli,long lFolUpd)
{
    char modulo[]="bfnPrintFolio";

    vDTrazasLog( modulo , "\n\t*** Entrada en %s ***",LOG05,modulo);

    fprintf(    stLineaComando.DataFile, "%10ld  %16ld %12.f  %10ld\n",
                pstRegDocumFoli->lhCodCliente    ,
                pstRegDocumFoli->lhIndOrdenTotal ,
                pstRegDocumFoli->dhTotFactura    ,
                lFolUpd                         );

    return(TRUE);
}/* END bfnPrintFolio */

/* ************************************************************************* */
/* * FUNCION : Funcion bfnAnularFolio                                      * */
/* * USO     : Realiza la Anulacion de Folios por tipo de dopcumento       * */
/* ************************************************************************* */
BOOL bfnAnularFolio( long lTipDocum
                    ,long lFolIni
                    ,long lCant
                    ,long lCodCiclFact
                    ,char *szCodigoOperadora
                    ,char *szPrefijoFolio )
{
    /* Variables locales */
    char modulo[]="bfnAnularFolio";
    long    iNumFoli = 0;
    long    lConFolio= 0;
    int     iNumParametros;
    int     lNumParametros;
    char    *szArregloParametros[5];
    int     iEstadoFolio;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long  lhFolio_Ini        ;
         long  lhCantidad         ;
         int   iTipodocumento     ;
         long  lCodVendedor       ;
         char  szhOficina[3]      ; /* EXEC SQL VAR szhOficina IS STRING(3); */ 

         char  sCodOperadora[6]   ;
         long  lNumeroVenta       ;
         long  lNumeroProceso     ;
         char  szhRetorno[250]    ;
         char  szprefi_folio[7]   ;   
         long  lhRanDesde         ;
         char  szprefini[7]       ;   
         long  lCorre_Folio       ;
    /* EXEC SQL END DECLARE SECTION ; */ 


    memset(&stRegAlConDoc,0,sizeof(FOLIACIONALCONSUDOCUM));

    vDTrazasLog( modulo ,
          "\n\t*** Entrada en %s ***"
          "\n\t\t=> Cod.TipDocum          [%ld]"
          "\n\t\t=> Folio Inicial         [%ld]"
          "\n\t\t=> Cantidad de Folios    [%ld]"
          "\n\t\t=> Cod.CiclFact          [%ld]"
          "\n\t\t=> Cod Operadora         [%s]"
          "\n\t\t=> Prefijo Folio         [%s]"
          ,LOG03
          ,modulo
          ,lTipDocum
          ,lFolIni
          ,lCant
          ,lCodCiclFact
          ,szCodigoOperadora
          ,szPrefijoFolio);

    /* PGG SOPORTE 19-10-2005. Incidencia XO-200510150886 DESDE */

    if(!bfnCargaOficinaAlAsigDocumento(lFolIni, lTipDocum, szhOficina, szPrefijoFolio))
    {
        vDTrazasLog( modulo ,"\n Error en la obtencion del Codigo de OFicina ***",LOG03);
        return FALSE;
    }

    /* EXEC SQL 
         SELECT RAN_DESDE
         INTO :lhRanDesde
         FROM AL_ASIG_DOCUMENTOS
         WHERE COD_OFICINA     = FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN(:szhOficina)
         AND COD_TIPDOCUM    = (SELECT COD_TIPDOCUM
                                FROM FA_TIPDOCUMEN
                                WHERE  COD_TIPDOCUMMOV = :lTipDocum)
         AND RAN_USADO + :lhCantidad  <= RAN_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select RAN_DESDE into :b0  from AL_ASIG_DOCUMENTOS where \
((COD_OFICINA=FA_FOLIACION_PG.FA_OFICINA_CONSUMO_FN(:b1) and COD_TIPDOCUM=(sel\
ect COD_TIPDOCUM  from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b2)) and (RAN_USAD\
O+:b3)<=RAN_HASTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )536;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhRanDesde;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhOficina;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lTipDocum;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCantidad;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
       vDTrazasLog( modulo , "\n\t**  Error en Select Al_Asig_Documentos(RAN_DESDE) **"
                             "\n\t\t=> Error : [%d]  [%s] ",LOG03,SQLCODE,SQLERRM);
       vDTrazasError( modulo , "\n\t**  Error en Select Al_Asig_Documentos(RAN_DESDE) **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       return FALSE;
    }

    iTipodocumento = lTipDocum;
    lCodVendedor   = 0;

    /* PGG SOPORTE 19-10-2005. Incidencia XO-200510150886 HASTA */

    strcpy(sCodOperadora,szCodigoOperadora );
    strcpy(szprefini,szPrefijoFolio);

    lhFolio_Ini    = lFolIni ;
    lhCantidad     = lCant ;
    iNumParametros = 3;
    lNumeroVenta   = 10;
    lNumeroProceso = 100;

    /*------------------------------------------------------------------------------------
    LECTURA DE DOCUMENTOS :
    -------------------------------------------------------------------------------------*/
    for(iNumFoli=0;iNumFoli<lCant;iNumFoli++) /* Inicio de For */
    {
        stRegAlConDoc.lNumFolio = lFolIni + iNumFoli;
        /*------------------------------------------------------------------------------------
        EJECUTA FUNCION  fa_foliacion_pg.FA_CONSUME_FOLIOPUNTUAL_FN
       -------------------------------------------------------------------------------------*/
        vDTrazasLog(modulo,"\np_ntipo_documento IN NUMBER(%d)"
                     "\np_nCod_vendedor   IN NUMBER[%ld]"
                     "\np_vCod_oficina    IN VARCHA[%s]"
                     "\np_vCod_operadora  IN VARCHA[%s]"
                     "\np_nNumero_venta   IN NUMBER[%ld]"
                     "\np_nNumero_proceso IN NUMBER[%ld]"
                     "\np_vprefijo_folio  IN VARCHA[%s]"
                     "\np_ncorrela_folio  IN NUMBER[%ld]"
                     , LOG05,iTipodocumento ,lCodVendedor,szhOficina
                     ,sCodOperadora,lNumeroVenta,lNumeroProceso,szprefini,lhFolio_Ini);

        vDTrazasLog(modulo,"ejecucion de fa_foliacion_pg.fa_consume_folio_fn\n", LOG05);

        /* EXEC SQL SELECT FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(
                  :iTipodocumento
                  ,decode(:lCodVendedor,0,NULL,:lCodVendedor)
                  ,:szhOficina
                  ,:sCodOperadora
                  ,:lhRanDesde
                  ,:lNumeroVenta
                  ,:lNumeroProceso
                  ,SYSDATE
                  ,2
                  )
                 INTO :szhRetorno
                 FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select FA_FOLIACION_PG.FA_CONSUME_FOLIO_FN(:b0,decode\
(:b1,0,null ,:b1),:b3,:b4,:b5,:b6,:b7,SYSDATE,2) into :b8  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )567;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&iTipodocumento;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lCodVendedor;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lCodVendedor;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhOficina;
        sqlstm.sqhstl[3] = (unsigned long )3;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)sCodOperadora;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhRanDesde;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lNumeroVenta;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lNumeroProceso;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhRetorno;
        sqlstm.sqhstl[8] = (unsigned long )250;
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




        /* Controla si la función fa_foliacion_pg.fa_consume_folio_fn retorno error */
        if (SQLCODE != SQLOK)
        {
            vDTrazasLog(modulo , "bfnAnularFolio:fa_consume_folio_fn retorno error:(%d|%s)",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo , "bfnAnularFolio:fa_consume_folio_fn retorno error:(%d|%s)",LOG01,SQLCODE,SQLERRM);
            return(FALSE);
        }

        /* Recupera Parametros de szhRetorno función y setea iNumParametros = 3 */
        iNumParametros = 0;
        RecupParam(&iNumParametros,szArregloParametros,szhRetorno,cSEPARADOR_COMA);

        /*  Controla si retorna la cantidad de parametros incorrectos */
        if (iNumParametros!=3){
            vDTrazasLog(modulo , "bfnAnularFolio:fa_consume_folio_fn:RecupParam:Error numero parametros(%d)",LOG01,iNumParametros);
            vDTrazasError(modulo , "bfnAnularFolio:fa_consume_folio_fn:RecupParam:Error numero parametros(%d)",LOG01,iNumParametros);
            return  FALSE;
        }

        iEstadoFolio = atoi(szArregloParametros[0]);
        strcpy(szprefi_folio,szArregloParametros[1]);
        lCorre_Folio = atol(szArregloParametros[2]);

        vDTrazasLog(modulo,
              "\nEstado de retorno de folio     [%d] "
              "\nPrefijo de folio    retornado [%s] "
              "\nCorrelativo de folio retornado(%ld) "
              , LOG05, iEstadoFolio,szprefi_folio, lCorre_Folio );

         /*si el folio no fue consumido en forma exitosa*/
         if (iEstadoFolio!=G_NESTADO_CONSUMIDO){
             vDTrazasLog(modulo , "bfnAnularFolio:fa_consume_folio_fn:iEstadoFolio:Folio no pudo ser consumido(%d)",LOG05,iEstadoFolio);
             vDTrazasError(modulo , "bfnAnularFolio:fa_consume_folio_fn:iEstadoFolio:Folio no pudo ser consumido(%d)",LOG05,iEstadoFolio);
             return FALSE;
         }

        /* Limpia RecupParam */
        for(lNumParametros=0;lNumParametros<iNumParametros;lNumParametros++){free(szArregloParametros[lNumParametros]);}
             /*------------------------------------------------------------------------------------
              EJECUTA FUNCION  fa_foliacion_pg.fa_anula_folio_fn
             -------------------------------------------------------------------------------------*/

        vDTrazasLog(modulo,"\np_ntipo_documento IN NUMBER(%d)"
                           "\np_nCod_vendedor   IN NUMBER(%ld)"
                           "\np_vCod_oficina    IN VARCHA(%s)"
                           "\np_vCod_operadora  IN VARCHA(%s)"
                           "\np_vprefijo_folio  IN VARCHA(%s)"
                           "\np_ncorrela_folio  IN NUMBER(%ld)"
                          ,LOG05,iTipodocumento,lCodVendedor,szhOficina,sCodOperadora,szprefi_folio,lCorre_Folio   );

        /* EXEC SQL SELECT FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(
                 :iTipodocumento
                ,decode(:lCodVendedor,0,NULL,:lCodVendedor)
                ,:szhOficina
                ,:sCodOperadora
                ,:szprefi_folio
                ,:lCorre_Folio)
                INTO :szhRetorno
                FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 12;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(:b0,decode(:\
b1,0,null ,:b1),:b3,:b4,:b5,:b6) into :b7  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )618;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&iTipodocumento;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lCodVendedor;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lCodVendedor;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhOficina;
        sqlstm.sqhstl[3] = (unsigned long )3;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)sCodOperadora;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szprefi_folio;
        sqlstm.sqhstl[5] = (unsigned long )7;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lCorre_Folio;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhRetorno;
        sqlstm.sqhstl[7] = (unsigned long )250;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
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




        /* Controla si la función fa_foliacion_pg.fa_anula_folio_fn retorno error */
        if(SQLCODE != SQLOK)  
        {
           vDTrazasLog(modulo , "bfnAnularFolio:fa_anula_folio_fn retorno error:(%d|%s)",LOG01,SQLCODE,SQLERRM);
           vDTrazasError(modulo , "bfnAnularFolio:fa_anula_folio_fn retorno error:(%d|%s)",LOG01,SQLCODE,SQLERRM);
           return(FALSE);
        }

         /* Recupera Parametros de szhRetorno función y setea iNumParametros = 3 */
        iNumParametros = 0;
        RecupParam(&iNumParametros,szArregloParametros,szhRetorno,cSEPARADOR_COMA);

        /*  Controla si retorna la cantidad de parametros incorrectos */
        if (iNumParametros!=3)
        {
            vDTrazasLog(modulo , "bfnAnularFolio:fa_anula_folio_fn:RecupParam:Error numero parametros(%d)",LOG01,iNumParametros);
            vDTrazasError(modulo , "bfnAnularFolio:fa_anula_folio_fn:RecupParam:Error numero parametros(%d)",LOG01,iNumParametros);
            return(FALSE);
        }

        iEstadoFolio=atoi(szArregloParametros[0]);

        /*  Controla si la funcion retorna el valor de anulado correctamente */
        if (iEstadoFolio!=G_NESTADO_ANULADO)
        {
            vDTrazasLog(modulo , "bfnAnularFolio:fa_anula_folio_fn:iEstadoFolio:Folio no fue anulado(%d)",LOG05,iEstadoFolio);
            vDTrazasError(modulo , "bfnAnularFolio:fa_anula_folio_fn:iEstadoFolio:Folio no fue anulado(%d)",LOG05,iEstadoFolio);
            return FALSE;
        }


        /*fprintf(stLineaComando.DataFile,"%44s %10ld\n"," ",stRegAlConDoc.lNumFolio);*/
        lConFolio++;

        /* Limpia  */
        for(lNumParametros=0;lNumParametros<iNumParametros;lNumParametros++)
        {
            free(szArregloParametros[lNumParametros]);
        }

    }/* Fin For */

    return TRUE;
}/* END bfnAnularFolio */

/* **************************************************************************************************** */
/* * FUNCION : bfbFinFoliacion(long lhCodCiclFact, int ihExisteRango, long lhClieIni, long lhClieFin) * */
/* * USO     : Marca Fin de Foliacion de Ciclo                                                        * */
/* **************************************************************************************************** */
BOOL bfbFinFoliacion(long lhCodCiclFact, int ihExisteRango, long lhClieIni, long lhClieFin)
{
    char modulo[]="bfbFinFoliacion";

    char    szCadenaSQL [1024]  ="";
    long    lhNumReg               ;

    vDTrazasLog( modulo , "\n\t*** Entrada en %s ***",LOG03,modulo);

    sprintf(szCadenaSQL,"SELECT  NVL(COUNT(*),0) "
                        "FROM FA_FACTDOCU_%ld "
                        "WHERE NUM_FOLIO = 0 "
                        "AND ((COD_CLIENTE BETWEEN %ld AND %ld) OR (1 <> %d)) "
                       ,lhCodCiclFact
                       ,lhClieIni
                       ,lhClieFin
                       ,ihExisteRango);
    
    vDTrazasLog( modulo ,"CADENA [%s]",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_fin_folio FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )665;
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


    
    if(SQLCODE)
    {
       vDTrazasError( modulo ,  "\n\t**  Error en SQL-PREPARE sql_fin_folio **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       return(FALSE);
    }

    /* EXEC SQL DECLARE cur_count_anulada CURSOR FOR sql_fin_folio; */ 

    
    if(SQLCODE)
    {
       vDTrazasError( modulo ,  "\n\t**  Error en SQL-DECLARE cur_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       return(FALSE);
    }

    /* EXEC SQL OPEN cur_count_anulada; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )684;
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
        vDTrazasError( modulo ,  "\n\t**  Error en SQL-OPEN CURSOR cur_count_anulada **"
                                 "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }

    /* EXEC SQL FETCH cur_count_anulada INTO :lhNumReg; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )699;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumReg;
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


    
    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
       vDTrazasError( modulo ,  "\n\t**  Error en SQL-FETCH cur_count_anulada **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       return(FALSE);
    }

    /* EXEC SQL CLOSE cur_count_anulada; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )718;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog( modulo , "\n\t\t  ==> Cod_CiclFact          [%ld]\n"
                          "\n\t\t  ==> Numero de Facturas    [%ld]"
                        ,(lhNumReg==0?LOG03:LOG01)
                        ,lhCodCiclFact
                        ,lhNumReg);

    if(lhNumReg > 0)
    {
       vDTrazasError( modulo ,"\n\t ** Documentos Sin Folio **"
                              "\n\t\t  ==> Cod_CiclFact          [%ld]"
                              "\n\t\t  ==> Numero de Facturas    [%ld]"
                              ,LOG03,lhCodCiclFact,lhNumReg);
       return FALSE;
    }
    return TRUE;
}/* END bfbFinFoliacion */

/*************************************************************************************************/
/* FUNCION : bfnValidaFolioIngreso                                                               */
/*************************************************************************************************/
BOOL bfnValidaFolioIngreso( FOLIACIONLINEACOMANDO stLineaComando , FOLIACIONAUXILIAR *pstRegAuxiliar)
{
    char modulo[]="bfnValidaFolioIngreso";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhFolioIngreso    ;
         long lhCantidad        ;
         long lhTip_DocumMov    ;
         long lhCodTipDocum     ;
         long lhRanDesde     ;
         long lhCodVendedor     ;
         char szhCodOficina[3]  ;
         char szhUser      [51] ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog( modulo ,"\t<< Entrando en %s >>",LOG03,modulo);
    vDTrazasLog( modulo ,"\t<< szUser [%s]>>",LOG06,stLineaComando.szUser);

    lhFolioIngreso = stLineaComando.lFolioIni ;
    lhCantidad     = stLineaComando.lCantidad ;
    lhTip_DocumMov = stLineaComando.lTipoDocumen;

    strcpy(szhUser,stLineaComando.szUser);

    /*Cod. Oficina y Cod. Vendedor*/
    /* EXEC SQL
         SELECT B.COD_VENDEDOR ,
                B.COD_OFICINA
         INTO   :lhCodVendedor ,
                :szhCodOficina
         FROM   VE_VENDEDORES B, GE_SEG_USUARIO A
         WHERE  A.NOM_USUARIO  = :szhUser
         AND    A.COD_VENDEDOR = B.COD_VENDEDOR
         AND    A.COD_OFICINA  = B.COD_OFICINA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select B.COD_VENDEDOR ,B.COD_OFICINA into :b0,:b1  from V\
E_VENDEDORES B ,GE_SEG_USUARIO A where ((A.NOM_USUARIO=:b2 and A.COD_VENDEDOR=\
B.COD_VENDEDOR) and A.COD_OFICINA=B.COD_OFICINA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )733;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodVendedor;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhUser;
    sqlstm.sqhstl[2] = (unsigned long )51;
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



    if(SQLCODE != SQLOK)   
    {
       vDTrazasLog(modulo ,"\n\t**  Error en Select de Oficina y Vendedor  [%s] **"
                          ,LOG01,sqlca.sqlerrm.sqlerrmc);
       vDTrazasError(modulo ,"\n\t**  Error en Select de Oficina y Vendedor  [%s] **"
                            ,LOG01,sqlca.sqlerrm.sqlerrmc);
       return FALSE;
    }

    vDTrazasLog( modulo ,"\n\tSeleccionados Vendedor [%ld] y Oficina [%s] " ,LOG05,lhCodVendedor,szhCodOficina);
    
   /* SAAM-20030612 Se modifica Query para que obtenga el codigo de vendedor si es que aplica, se soluciona con esto la incidencia XP-110620030219 */
    /* EXEC SQL
         SELECT RAN_DESDE,COD_TIPDOCUM,nvl(COD_VENDEDOR,0)
         INTO   :lhRanDesde,:lhCodTipDocum,lhCodVendedor
         FROM   AL_ASIG_DOCUMENTOS
         WHERE  COD_OFICINA     = :szhCodOficina
         AND    :lhFolioIngreso<= RAN_HASTA
         AND    RAN_USADO + 1   = :lhFolioIngreso
         AND(:lhFolioIngreso +(:lhCantidad-1)) <= RAN_HASTA
         AND    COD_TIPDOCUM    =(SELECT COD_TIPDOCUM    
                                  FROM FA_TIPDOCUMEN
                                  WHERE  COD_TIPDOCUMMOV =    :lhTip_DocumMov); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select RAN_DESDE ,COD_TIPDOCUM ,nvl(COD_VENDEDOR,0) into \
:b0,:b1,:b2  from AL_ASIG_DOCUMENTOS where ((((COD_OFICINA=:b3 and :b4<=RAN_HA\
STA) and (RAN_USADO+1)=:b4) and (:b4+(:b7-1))<=RAN_HASTA) and COD_TIPDOCUM=(se\
lect COD_TIPDOCUM  from FA_TIPDOCUMEN where COD_TIPDOCUMMOV=:b8))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )760;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhRanDesde;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodTipDocum;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&lhFolioIngreso;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhFolioIngreso;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhFolioIngreso;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCantidad;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhTip_DocumMov;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
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



    if(SQLCODE == SQLNOTFOUND) 
    {
       vDTrazasLog(modulo ,"\n\t**  No Existe Rango para este Folio [%ld] y Cantidad [%ld]**\n\n"
                          ,LOG03,lhFolioIngreso,lhCantidad);
       vDTrazasError(modulo ,"\n\t**  No Existe Rango para este Folio [%ld] y Cantidad [%ld]**\n\n"
                            ,LOG01,lhFolioIngreso,lhCantidad);
       return FALSE;
    }
    
    if(SQLCODE != SQLOK) 
    {
       vDTrazasLog(modulo ,"\n\t**Validacion del Folio Ingresado [%ld]\n\t%s\n **"
                          ,LOG01,lhFolioIngreso,sqlca.sqlerrm.sqlerrmc);
       vDTrazasError(modulo ,"\n\t**Validacion del Folio Ingresado [%ld]\n\t%s\n **"
                            ,LOG01,lhFolioIngreso,sqlca.sqlerrm.sqlerrmc);
       return FALSE;
    }

    vDTrazasLog(modulo ,"\n\tRango Permitido para Folio [%ld] Cantidad [%ld] "
                       ,LOG05,lhFolioIngreso,lhCantidad);

    pstRegAuxiliar->lCodTipDocum=lhCodTipDocum;
    pstRegAuxiliar->lRanDesde=lhRanDesde;

    pstRegAuxiliar->lCodVendedor=lhCodVendedor;
    strcpy(pstRegAuxiliar->szCodOficina,szhCodOficina);


    vDTrazasLog( modulo ,"\n\t<< Fin de %s >>\n",LOG03,modulo);
    return TRUE;
}/* END bfnValidaFolioIngreso */

/*****************************************************************************/
/* FUNCION : bfnGetTipoFoliacion                                             */
/*****************************************************************************/
BOOL bfnGetTipoFoliacion( int lCod_Tipodocumen , char *szinTIpoFoliacion )
{
    char modulo[]="bfnGetTipoFoliacion";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodTipDocum=0  ;
         char szTipFoliacion[2];
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodTipDocum = lCod_Tipodocumen;

    /* EXEC SQL
         SELECT TIP_FOLIACION
         INTO   :szTipFoliacion
         FROM   GE_TIPDOCUMEN
         WHERE  COD_TIPDOCUM = :lhCodTipDocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TIP_FOLIACION into :b0  from GE_TIPDOCUMEN where C\
OD_TIPDOCUM=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )811;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szTipFoliacion;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodTipDocum;
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
        vDTrazasLog( modulo ,"\n\t**  Error en bfnGetTipoFoliacion [%s] **",LOG01,sqlca.sqlerrm.sqlerrmc);
        vDTrazasError( modulo ,"\n\t**  Error en bfnGetTipoFoliacion [%s] **",LOG01,sqlca.sqlerrm.sqlerrmc);
        return FALSE;
    }

    strcpy(szinTIpoFoliacion,szTipFoliacion);

    return TRUE;
}/* END bfnGetTipoFoliacion */

/*****************************************************************************************/
/* FUNCION : ifnObtieneParam()                                                           */
/* USO     : Obtención de parámetros para determinar si se va a foliar igual que siempre */
/*           o se folea usando la oficina emisora                                        */
/*****************************************************************************************/
int ifnObtieneParam()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int ihTipoFoliacion;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL 
         SELECT TO_NUMBER(VAL_PARAMETRO)
         INTO :ihTipoFoliacion
         FROM GED_PARAMETROS
         WHERE NOM_PARAMETRO = 'TIPO FOLIACION'
         AND COD_MODULO = 'FA'
         AND COD_PRODUCTO = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_NUMBER(VAL_PARAMETRO) into :b0  from GED_PARAME\
TROS where ((NOM_PARAMETRO='TIPO FOLIACION' and COD_MODULO='FA') and COD_PRODU\
CTO=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )834;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTipoFoliacion;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        return -1; /* Error */
    }
    if(SQLCODE != SQLOK)
    {
        fprintf(stderr,"\n\t**  Error en SELECT TO_NUMBER(VAL_PARAMETRO)FROM GED_PARAMETROS [%s] **",LOG01,SQLERRM);    	  	
        return -1; /* Error */
    }
    else
    {
        return ihTipoFoliacion; /* OK */
    }
}/* END ifnObtieneParam*/

/****************************************************************************************/
/* FUNCION : bfnObtOficEmis(long  lCodCliente,  char *Operadora, char *Cod_OficinaEmis) */
/* USO     : Obtencion de Oficina Emisora a partir de la Oficina de la primera venta    */
/****************************************************************************************/
char * bfnObtOficEmis(long  lCodCliente,  char *Operadora, char *Cod_OficinaEmis)
{
    char modulo[] ="bfnObtOficEmis";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente         ;
         char    szhCod_OficinaEmis[3];
         char    szhCod_Operadora  [5];
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente= lCodCliente;

    vDTrazasLog( modulo ,"\n\t**  Cod_Cliente  [%ld] **", LOG06, lhCodCliente);

    /* EXEC SQL 
          SELECT E.COD_OFICINA, A.COD_OPERADORA
          INTO   :szhCod_OficinaEmis, :szhCod_Operadora
          FROM   GE_CLIENTES A,
                 GE_OFICINAS B,
                 GE_DIRECCIONES C,
                 GE_CIUDADES D,
                 GE_OPERPLAZA_TD E
          WHERE A.COD_CLIENTE   = :lhCodCliente
          AND   B.COD_OFICINA   = A.COD_OFICINA
          AND   C.COD_DIRECCION = B.COD_DIRECCION
          AND   D.COD_REGION    = C.COD_REGION
          AND   D.COD_PROVINCIA = C.COD_PROVINCIA
          AND   D.COD_CIUDAD    = C.COD_CIUDAD
          AND   E.COD_PLAZA     = D.COD_PLAZA          
          AND   E.COD_OPERADORA_SCL = A.COD_OPERADORA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select E.COD_OFICINA ,A.COD_OPERADORA into :b0,:b1  from \
GE_CLIENTES A ,GE_OFICINAS B ,GE_DIRECCIONES C ,GE_CIUDADES D ,GE_OPERPLAZA_TD\
 E where (((((((A.COD_CLIENTE=:b2 and B.COD_OFICINA=A.COD_OFICINA) and C.COD_D\
IRECCION=B.COD_DIRECCION) and D.COD_REGION=C.COD_REGION) and D.COD_PROVINCIA=C\
.COD_PROVINCIA) and D.COD_CIUDAD=C.COD_CIUDAD) and E.COD_PLAZA=D.COD_PLAZA) an\
d E.COD_OPERADORA_SCL=A.COD_OPERADORA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )853;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_OficinaEmis;
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Operadora;
    sqlstm.sqhstl[1] = (unsigned long )5;
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



    if (SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog(szExeName,"\n\t=>No hay registros para la obtencion de la Oficina Emisora\n",LOG01);
        strcpy(szhCod_OficinaEmis,"--");
    }
    
    if (SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeName,"\n\t=>Error en la obtencion de la Oficina Emisora\n",LOG01);
        strcpy(szhCod_OficinaEmis,"--");
    }

    strcpy (Operadora,szhCod_Operadora );
    strcpy (Cod_OficinaEmis,szhCod_OficinaEmis);

    vDTrazasLog( modulo ,"\n\t**  szhCod_Operadora  [%s] **"
                         "\n\t**  szhCod_OficinaEmis  [%s] **"
                        ,LOG03
                        ,szhCod_Operadora
                        ,szhCod_OficinaEmis);

    return (szhCod_OficinaEmis);
    
}/* END bfnObtOficEmis */

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
