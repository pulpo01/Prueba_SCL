
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
           char  filnam[18];
};
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/loadtarif.pc"
};


static unsigned int sqlctx = 6913755;


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
   unsigned char  *sqhstv[5];
   unsigned long  sqhstl[5];
            int   sqhsts[5];
            short *sqindv[5];
            int   sqinds[5];
   unsigned long  sqharm[5];
   unsigned long  *sqharc[5];
   unsigned short  sqadto[5];
   unsigned short  sqtdso[5];
} sqlstm = {12,5};

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
5,0,0,1,171,0,4,506,0,0,5,1,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,1,3,0,0,
40,0,0,2,0,0,17,664,0,0,1,1,0,1,0,1,97,0,0,
59,0,0,2,0,0,45,703,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
90,0,0,2,0,0,13,722,0,0,1,0,0,1,0,2,3,0,0,
109,0,0,2,0,0,15,730,0,0,0,0,0,1,0,
124,0,0,2,0,0,15,743,0,0,0,0,0,1,0,
139,0,0,3,0,0,21,782,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
170,0,0,3,0,0,21,790,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
201,0,0,4,0,0,21,828,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
232,0,0,4,0,0,21,836,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
263,0,0,5,136,0,6,949,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
298,0,0,6,123,0,4,1318,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
325,0,0,7,80,0,4,1455,0,0,2,1,0,1,0,1,97,0,0,2,9,0,0,
348,0,0,8,87,0,4,1496,0,0,2,1,0,1,0,1,97,0,0,2,9,0,0,
371,0,0,9,70,0,6,1545,0,0,1,1,0,1,0,1,3,0,0,
390,0,0,10,73,0,6,1619,0,0,1,1,0,1,0,1,97,0,0,
409,0,0,3,0,0,17,1653,0,0,1,1,0,1,0,1,97,0,0,
428,0,0,4,0,0,17,1679,0,0,1,1,0,1,0,1,97,0,0,
447,0,0,11,0,0,17,1712,0,0,1,1,0,1,0,1,97,0,0,
466,0,0,11,0,0,45,1751,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
489,0,0,11,0,0,13,1765,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
512,0,0,11,0,0,15,1805,0,0,0,0,0,1,0,
527,0,0,12,150,0,4,1843,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : loadtarif.pc                                            * */
/* *  Proceso de "Facturacion de Ciclo"                                 * */
/* *  Autor : Mauricio Villagra Villalobos                              * */
/* ********************************************************************** */
/* *  Creado    :  12 de Mayo de 1999                                   * */
/* *                                                                    * */
/* *    Proceso que genera tabla de trafico para el ciclo facturacion.  * */
/* *    Esta tabla es creada por el proceso y considera el trafico      * */
/* *    atrasaso no facturado para cada cliente del ciclo.              * */
/* *                                                                    * */
/* * 25.05.1999 Se Agrego Funcionalidad de procesar en paralelo cada    * */
/* *            cada una de las tablas TA_TARIFICADAS0..9               * */
/* * 26.05.1999 Se Agrego funcionalidad que permite eliminar indice     * */
/* *            sobre tabla PF_TARIFICADAS                              * */
/* * 20.12.2002 Se Agrego funcionalidad que permite discriminar entre   * */
/* *            informacion proveniente de la Tasacion Clasica y la     * */
/* *            Tasacion On Line alternado la tabla FA_CICLFACT con el  * */
/* *            campo IND_TASADOR. Se integran una serie de tablas adic.* */
/* *                                                                    * */
/* ********************************************************************** */

#define _LOADTARIF_PC_

#include "loadtarif.h"

/* SAAM-20041019 Se incluye constante y variable segun HD-200403100356, P-MAS-04042 */
#define iNRO_GRUPO_COMMIT 5000	/* PGG new */
long lGrupoCommit       = iNRO_GRUPO_COMMIT;

long lTotClientes       = 0l;
long lTotLlamadas       = 0l; 
long lLlamadasOK        = 0l;
long lLlamadasErr       = 0l;

char szUsage[]=
    "\nUso:   loadtarif -u  Usuario/Password        "
    "\n                 -c  Ciclo Facturacion       "
    "\n                 -d  Digito de Cliente [0..9]"    
    "\n\tOPCIONES:                                  "
    "\n\t               -l  [LogNivel]              "
/* SAAM-20041019 nuevo opciones segun HD-200408301790, P-MAS-04042 */
    "\n\t               -t  [Trafico 0=Todo 1=Entrada 2=Salida ] (por omision, todos) "
    "\n\t               -n  [NroClientesCommit] (omision 5.000 ) ";	/* PGG New */                                                                     
/* SAAM-20041019 nuevo flags segun HD-200408301790, P-MAS-04042 */
#define TRAFICO_COMPLETO 0
#define TRAFICO_ENTRADA  1
#define TRAFICO_SALIDA   2

int iTipoTrafico=TRAFICO_COMPLETO;
char szCondicion_Trafico[30]=" \0";

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



/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/


BOOL        bfnCargaTraficoCicloFact(long,int)          ;
BOOL        bfnCreaTablaTraficoPF(void)                 ;
static void vfnInitCadenaInsertTarif(char*, int,int)    ; /* SAAM-20021220 nuevo parametro */
static void vfnInitCadenaDeleteTarif(char *,int,int)    ; /* SAAM-20021220 nuevo parametro */
BOOL        bfnCargaTraficoCliente(long,long,int)       ; /* SAAM-20021220 nuevo parametro */ 
static void vfnInitCadenaValidaTarif(char *,int,int)    ;  	/* PGG New */ 
static void vfnInitCadenaMaxMinTarif(char *,int,int)    ;       /* PGG New */
int vfnRecuperaMaxMin(int, int, long, long, long *, long *);    /* PGG New */



/* SAAM-20041019 se elimina funcion y se agrega una nueva segun HD-200403100356, P-MAS-04042 */
/* SAAM-20041019 se agregan funciones segun HD-200408301790, P-MAS-04042 */
/* SAAM-20041021 nueva funciones segun diseño P-MAS-04042 */
BOOL        bfnDropIndexPF(int )            ;
BOOL        bfnCreateIndexPF(int )          ;
/* SAAM-20041119 nuevo prototipo, P.MAS-04042 */
BOOL        NoExistenProcesosActuales( );
BOOL        vfnCreaQuerysDinamicos(int, int);

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szCadenaInsert[4096];  
    char    szCadenaDelete[512]; 
    char    szCadenaValida[512];  	/* PGG New */
    char    szCadenaMaxMin[512];        /* PGG New */
    int     ihCodTipoTasador;
/* EXEC SQL END DECLARE SECTION; */ 


/* SAAM-20041019 Se incluye variable y funcion segun Homologacion de PR-200409070586, P-MAS-04042 */
char gszFechaHora[25];
char  *bszFechaHora ( void )
{
	time_t timer;
	size_t nbytes;

	timer = time((time_t *)0);
	nbytes = strftime(gszFechaHora, 25, "[%d/%m/%Y][%H:%M:%S]", (struct tm *)localtime(&timer));

	return(gszFechaHora);
}

/* INICIO  CO-200607290283 CJG */
void trim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}
/* FIN  CO-200607290283 CJG */




/****************************************************************************/
/*    funcion int main(argc, argv)                                          */
/****************************************************************************/
/*  Funcion procipal del proceso que realizar las operaciones de validar    */
/*  parametros crear archivos de log, errores.   Se conecta a la base de    */
/*  datos y llama a los procedimientos de carga de trafico desde las tablas */
/*  TA_TARIFICADAS0..9                                                      */
/****************************************************************************/


int main(int argc, char *argv[])
{

    /****  NUEVO   ****/

    extern  char    *optarg                         ;
    char            opt[]           ="u:c:l:d:n:t:" ; /* SAAM-20041019 nuevois valores segun HD-200403100356 y HD-200408301790, P-MAS-04042 */
    int             iOpt            =0              ;
    char            szUsuario [63]  = ""            ;
    char            *psztmp         = ""            ;
    char            szaux     [10]  = ""            ;
    char            *szDirLogs                      ;
    char            szComando[1024] = ""            ;
    BOOL            bOptUsuario     = FALSE         ;
    
    memset(&stLineaComando  ,0,sizeof(LINEACOMANDO));
    memset(&stTrazaProc     ,0,sizeof(TRAZAPROC))   ;
    
    stLineaComando.iDigitoCli   =-1                 ;
    stLineaComando.lCodCiclFact = 0                 ;
    
    fprintf (stderr, "\n  LoadTarif version " __DATE__ " " __TIME__ " TMG\n"); /* PGG New */

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {   case 'u':
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
                    fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                }
                break;
            case 'd':
                if (strlen (optarg))
                {
                    stLineaComando.iDigitoCli =
                    (((atoi(optarg) >= 0) && (atoi(optarg) <= 9))? atoi (optarg):-1);
                    fprintf (stdout,"-d %d ", stLineaComando.iDigitoCli);
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
            case 'n':
                if (strlen (optarg))
                {
                    lGrupoCommit =(atol(optarg) > 0)? atol(optarg): iNRO_GRUPO_COMMIT ;
                    fprintf (stdout,"-n %ld ", lGrupoCommit)     ;
                }
                break;
            case 't':  /* SAAM-20041019 nueva opcion segun HD-200408301790, P-MAS-04042 */
                if (strlen (optarg))
                {
                    iTipoTrafico =(atol(optarg) > 0)? atol(optarg): TRAFICO_COMPLETO ;
                    fprintf (stdout,"-t %d ", iTipoTrafico)     ;
                }
                break;
            default:
                fprintf (stderr, "\n\t# Error en Parametros de Entrada:\n%s\n", szUsage);
                return 1;
        }
    }

    fprintf (stdout,"\n");

    if (stLineaComando.lCodCiclFact == 0)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return 1;
    }

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
    
    if (stLineaComando.iDigitoCli < 0)
    {
        fprintf (stderr, "\n\t# Error Parametros de Entrada iDigitoCli :\n%s\n", szUsage);
        return  (2);
    }

/* SAAAM-20041019 Validacion Flag Trafico y creacion condicion query segun HD-200408301790, P-MAS-04042 */
    if (iTipoTrafico != TRAFICO_ENTRADA && iTipoTrafico !=TRAFICO_SALIDA && iTipoTrafico != TRAFICO_COMPLETO)
    {
        fprintf (stderr, "\n\t# Error Parametros de Entrada Tipo de Trafico :\n%s\n", szUsage);
        return  (2);
    }
    else
    {
        if (iTipoTrafico == TRAFICO_ENTRADA)
        {
            strcpy(szCondicion_Trafico," AND IND_ENTSAL1 = 1 ");
        }
        else if (iTipoTrafico == TRAFICO_SALIDA)
             {
                 strcpy(szCondicion_Trafico," AND IND_ENTSAL1 = 2 ");
             }
    }

/* SAAM-20041019 cambio de mensaje segun Homologacion de PR-200409070586, P-MAS-04042 */
    fprintf (stdout,"\n%s\n\t\t*** Procesando Trafico %s ***\n\n", bszFechaHora(), ((iTipoTrafico==1)?"Entrada":((iTipoTrafico==2)?"Salida":"Completo"))) ;

	

    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        fprintf( stderr, "\n\t-------------------------------------------------------"
                         "\n\tConectado a BD ORACLE %s : Usuario %s Passwd xxxxxxxx "
                         "\n\t-------------------------------------------------------\n",(char *)getenv("ORACLE_SID"),
                         stLineaComando.szUser);
    }


    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;
       
    /**************************************************************************************/
    /* SAAM-20041019 Se elimina malloc segun HD-200403100356, P-MAS-04042 */
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/loadtarif/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    
    
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );
    free(szDirLogs); /* SAAM-20041019 Se libera memoria segun HD-200403100356, P-MAS-04042 */
    
    if (system (szComando))
    {
        fprintf(stderr, "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/    
    sprintf(stStatus.ErrName, "%sloadtarif%d_%ld_%s.err",
            stLineaComando.szDirLogs,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return (4);
    }
    /*********************************************************************************************/    
    sprintf(stStatus.LogName, "%sloadtarif%d_%ld_%s.log",
            stLineaComando.szDirLogs,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de log %s\n",stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*********************************************************************************************/
    vDTrazasError(szExeLoadTarif,"\n\n\t*************************************"
				  "\n\n\t   LoadTarif version " __DATE__ " " __TIME__ "TMG"			/* PGG New */
				  "\n\n\t*************************************"                                 /* PGG New */
                                  "\n\n\t****     Errores de loadtarif " __DATE__ " " __TIME__ " **"
                                  "\n\n\t**************************************************************\n%s",
                                   LOG03,bszFechaHora());

    vDTrazasLog(szExeLoadTarif, "\n\n\t***************************************************************" 	/* PGG New */
    				"\n\n\t   LoadTarif version " __DATE__ " " __TIME__ "TMG"                       /* PGG New */
				"\n\n\t*************************************"
                                "\n\n\t****        Log   loadtarif " __DATE__ " " __TIME__ " **"
                                "\n\n\t**************************************************************\n%s",
                                 LOG03,bszFechaHora());                                            

    vDTrazasLog(szExeLoadTarif,"\n***  INICIO DE PROCESO %s ***\n"
                               "\n\t\t***  Parametro de Entrada loadtarif  ***"
                               "\n\t\t=> Base de Datos [%s]"
                               "\n\t\t=> Usuario       [%s]"
                               "\n\t\t=> Password      [************]"
                               "\n\t\t=> Cod.CiclFact  [%ld]"
                               "\n\t\t=> Niv.Log       [%d]",
                                LOG03,bszFechaHora(), (char *)getenv("ORACLE_SID"),
                                stLineaComando.szUser,
                                stLineaComando.lCodCiclFact,
                                stLineaComando.iNivLog);

    if(!bfnCargaTraficoCicloFact(stLineaComando.lCodCiclFact,stLineaComando.iDigitoCli)) 
    {
        fnOraRollBack();
        if (stTrazaProc.lCodCiclFact > 0)
        {

			/* ****************************************** */
			/* FAEDO-20050628 Se vuelve a crear el indice */
			/* ****************************************** */
		    if (!bfnCreateIndexPF(ihCodTipoTasador))
		    {
		        if (ihCodTipoTasador==TIPO_TASA_CLASICA)
		            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al crear indice TAS ***",LOG03 );
		        else
		            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al crear indice TOL ***",LOG03 );
		    }
		    else
		    {
		        if (ihCodTipoTasador==TIPO_TASA_CLASICA)
		            vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TAS Creado Correctamente ***",LOG03 );
		        else
		            vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TOL Creado Correctamente ***",LOG03 );
		    }
			/* ****************************************** */
			/* ****************************************** */


            if (!bfnSelectSysDate(szSysDate))
                vDTrazasLog(szExeLoadTarif,"\n\t*** Error en bfnSelectSysDate (main)***\n",LOG01); 
            else
            {
                stTrazaProc.iCodEstaProc       = iPROC_EST_ERR                                  ;
                strcpy(stTrazaProc.szFecTermino,szSysDate)                                      ;
                strcpy(stTrazaProc.szGlsProceso,"Proceso Carga de Trafico Terminado con Error") ;
                stTrazaProc.lCodCliente        = stTrazaProc.lCodCliente+lTotClientes           ;
                stTrazaProc.lNumAbonado        = 0                                              ;
                stTrazaProc.lNumRegistros      = stTrazaProc.lNumRegistros+lLlamadasOK          ;
                bPrintTrazaProc(stTrazaProc);
                if (!bfnUpdateTrazaProc(stTrazaProc))
                    vDTrazasLog(szExeLoadTarif,"\n\t*** Error en bfnUpdateTrazaProc ***\n",LOG01);
                
                if (!bfnOraCommit())
                {
                    vDTrazasError(szExeLoadTarif, "\n\tError en Commit de Estadisticas"
                                                  " bfnOraCargaHistDocu ", LOG01);
                    return FALSE;
                    
                }
            }
        }
    }    
    else 
    {
        if (!bfnOraCommit())
        {
            vDTrazasError(szExeLoadTarif, "\n\tError en Commit de Estadisticas"
                                        " bfnOraCargaHistDocu ", LOG01);
            return FALSE;
        }
    }
    vDTrazasLog(szExeLoadTarif,"\n***  FIN DE PROCESO %s ***\n", LOG03, bszFechaHora());

    if(!bfnDisconnectORA(0))
    {
     /*No estaba conectado*/
    }
    else
    {
        vDTrazasLog(szExeLoadTarif,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);

        vDTrazasError(szExeLoadTarif,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);
    }
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
}
/****************************  fin main ()  *********************************/



/****************************************************************************/
/*   funcion BOOL bfnCargaTraficoCicloFact(long lCiclParam,int Digito)      */
/****************************************************************************/
/*  Esta funcion principal lleva el control del proceso SQL.                */
/*  Valida los parametros de entrada :  Codigo de Ciclo de Facturacion != 0 */
/*  Selecciona los datos de la Tabla FA_CICLFACT para comprobar si el ciclo */
/*  ha comenzado el proceso de facturacion. Para esto se han definido los   */
/*  siguientes estados del Indicador de Facturacion :                       */
/*  0   :   El Ciclo no ha comenzado el proceso de Facturacion              */
/*  1   :   Comenzo la Facturación de Ciclo.  Marcado por el proceso de     */
/*          Creacion de la Mascara( Pre-Ciclo), siempre y cuando la fecha   */
/*          sea posterior a la Fecha Hasta de Llamadas FEC_HASTALLAM de la  */
/*          tabla FA_CICLFACT                                               */
/* Valida que el ciclo este en proceso de facturacion (1)                   */
/* Valida el estado de los procesos precedentes (terminados OK)             */
/* Valida el estado del proceso actula |que no este terminado OK            */
/****************************************************************************/

BOOL bfnCargaTraficoCicloFact(long lCiclParam,int iDigitoCli)
{
    BOOL bFinCursor_cFaCicloCli = FALSE;
    long    lFilasInsert=0          ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
    long    lFilasDelete=0          ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
       
    /****************************************************************************/
    /*    Variables de Host Oracle-SQL                                          */
    /****************************************************************************/
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    
    /*  DATOS DE FA_CICLOCLI        */
    
    long lhCodCiclFact          ;
    long lhCodCliente           ;
    long lhMinCodCliente        ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
    long lhMaxCodCliente        ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
    long lhTotalClientes        ; /* SAAM-20041019 nueva variable segun HD-200405240798, P-MAS-04042 */
    long lhIniCodCliente        ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
    long lhEndCodCliente        ; /* SAAM-20041019 nueva variable segun HD-200403100356, P-MAS-04042 */
    long lhNumAbonado           ;
    long lhCodCiclo             ;
    int  ihIndFact              ;
    int  ihDigitoCli            ;
    int  ihCodTipoTar           ; /* SAAM-20021220 */
    char szhFecHastaLlam[15]    ;   /* EXEC SQL VAR szhFecHastaLlam     IS STRING(15); */ 

    char szhFecActual[15]       ;   /* EXEC SQL VAR szhFecActual        IS STRING(15); */ 

    long lRows;	/* PGG New */
	long lcod_CodMegError    ;   /* Recibe el codigo de error de la PL */						/* PGG SOPORTE 28/07/2006 CO-200607280274 Desde Aqui - Solucion By AFGS -*/
    	char szmsg_DetMsgError [200]; /* Recibe mensaje error y si esta OK recibe totales registros actualizados */     /* PGG SOPORTE 28/07/2006 CO-200607280274 Desde Aqui - Solucion By AFGS -*/
    	long lnum_Evento ;           /* Recibe numero del evento del error */                                           /* PGG SOPORTE 28/07/2006 CO-200607280274 Desde Aqui - Solucion By AFGS -*/

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog(szExeLoadTarif,"\n\t***  Parametros de Entrada bfnCargaTraficoCicloFact  ***"
                             "\n\t\t=> Cod_CiclFact     [%ld]",
                             LOG03,lCiclParam );
                             
    /* SAAM-20041019 Se elimana llamada a funcion segun HD-200403100356, P-MAS-04042 */
                                 
    /****************************************************************************/
    /*  Selecciona Datos del Ciclo de Facturacion FA_CICLFACT                   */
    /****************************************************************************/

    lhCodCiclFact   = lCiclParam;
    ihDigitoCli     = iDigitoCli;
    
    szmsg_DetMsgError[0]='\0';		/* PGG SOPORTE 28/07/2006 CO-200607280274 Desde Aqui - Solucion By AFGS -*/

    /* EXEC SQL SELECT COD_CICLO                                   ,
                    TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH24MISS')   ,
                    TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')         ,
                    IND_TASADOR /o SAAM-20021220 Campo nuevo que diferencia el tipo de Tasacion o/
             INTO   :lhCodCiclo                                 ,
                    :szhFecHastaLlam                            ,
                    :szhFecActual                               ,
                    :ihCodTipoTar /o SAAM-20021220 o/
             FROM   FA_CICLFACT 
             WHERE  COD_CICLFACT = :lhCodCiclFact               ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH24MISS\
') ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') ,IND_TASADOR into :b0,:b1,:b2,:b3  fro\
m FA_CICLFACT where COD_CICLFACT=:b4";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecHastaLlam;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecActual;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipoTar;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
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


             

    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  No Existen Datos en FA_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeLoadTarif,   "\n\t**  No Existen Datos en FA_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en Select sobre FA_CILCFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en Select sobre FA_CILCFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lCiclParam);
        return (FALSE);
    }
	/* FAEDO 20050628 Para crear los índices fuera del procedimiento, se debe rescatar la variable a global */
	ihCodTipoTasador = ihCodTipoTar;
/* SAAM-20041019 se incluye el desachar indices segun HD-200408301790, P-MAS-04042 */
/*    if (ihCodTipoTar==TIPO_TASA_CLASICA)
    {
        vDTrazasLog(szExeLoadTarif, "\n\t***  Eliminando Indice TAS ***",LOG03 );
        fprintf (stdout,"\n\n\t\t*** Eliminando Indice TAS ***\n") ;
        if (!bfnDropIndexPF())
        {
            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al borrar indice TAS ***",LOG03 );
            return (FALSE);
        }
        vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TAS Eliminado ***",LOG03 );
        fprintf (stdout,"\t\t*** Indice TAS Eliminado ***\n") ;
    }
    else
    {
        if (!bfnDropIndexPF_TOL())
        {
            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al borrar indice TOL ***",LOG03,lCiclParam );
            return (FALSE);
        }
    }
*/

    /****************************************************************************/
    /*  Valida Estado del Proceso de Facturacio de Ciclo                        */
    /****************************************************************************/
    
    if (!bfnValidaTrazaProc(lCiclParam,iPROC_LOADTARIF+iDigitoCli,iIND_FACT_ENPROCESO))
    {
       return(FALSE);
    }
    else if(!fnOraCommit())
    {
        vDTrazasLog  (szExeLoadTarif, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
        vDTrazasError(szExeLoadTarif, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
        return (FALSE);
    }
    
    bfnSelectTrazaProc ( lCiclParam,iPROC_LOADTARIF+iDigitoCli,&stTrazaProc);    
    bPrintTrazaProc(stTrazaProc);

    /* SAAM-20041019 Se elimina logica de creacion de tabla segun HD-200403100356, P-MAS-04042 */
    
    /****************************************************************************/
    /*  Declara Cursor sobre FA_CICLOCLI considerando la mascara de Facturacion */
    /****************************************************************************/
    vDTrazasLog  (szExeLoadTarif, "\n\t\t**  Seleccionando Clientes de FA_CICLOCLI **",LOG03);
    
    bFinCursor_cFaCicloCli = FALSE;

   /* SAAM-20041019 Se hace "prepare" de consultas dinamicas constante y variable segun HD-200403100356, P-MAS-04042 */ 
    vfnInitCadenaInsertTarif(szCadenaInsert,ihDigitoCli,ihCodTipoTar);
    vDTrazasLog(szExeLoadTarif, "\n\t\t\t   vfnInitCadenaInsertTarif() "
                                "\n\t\t\t------------------------------------"
                                "\n\t\t\t=> ihDigitoCli ....... [%ld]"
                                "\n\t\t\t=> ihCodTipoTar....... [%ld]"
                                "\n\t\t\t=> szCadenaInsert..... [%s]"
                                ,LOG06, ihDigitoCli, ihCodTipoTar,szCadenaInsert);

    vfnInitCadenaMaxMinTarif(szCadenaMaxMin,ihDigitoCli,ihCodTipoTar);							/* PGG New */
    vDTrazasLog(szExeLoadTarif, "\n\t\t\t   vfnInitCadenaMaxMinTarif() "                                                /* PGG New */
                                                            "\n\t\t\t------------------------------------"              /* PGG New */
                                                            "\n\t\t\t=> ihDigitoCli ....... [%ld]"                      /* PGG New */
                                                            "\n\t\t\t=> ihCodTipoTar....... [%ld]"                      /* PGG New */
                                                            "\n\t\t\t=> szCadenaDelete..... [%s]"                       /* PGG New */
                                                            ,LOG06, ihDigitoCli, ihCodTipoTar,szCadenaMaxMin);          /* PGG New */

    vfnInitCadenaValidaTarif(szCadenaValida,ihDigitoCli,ihCodTipoTar);                                                  /* PGG New */
    vDTrazasLog(szExeLoadTarif, "\n\t\t\t   vfnInitCadenaValidaTarif() "                                                /* PGG New */
                            "\n\t\t\t------------------------------------"                                              /* PGG New */
                            "\n\t\t\t=> ihDigitoCli ....... [%ld]"                                                      /* PGG New */
                            "\n\t\t\t=> ihCodTipoTar....... [%ld]"                                                      /* PGG New */
                            "\n\t\t\t=> szCadenaDelete..... [%s]"                                                       /* PGG New */
                            ,LOG06, ihDigitoCli, ihCodTipoTar,szCadenaValida);                                          /* PGG New */
    
    vfnInitCadenaDeleteTarif(szCadenaDelete,ihDigitoCli,ihCodTipoTar);
    vDTrazasLog(szExeLoadTarif, "\n\t\t\t   vfnInitCadenaDeleteTarif() "
                                "\n\t\t\t------------------------------------"
                                "\n\t\t\t=> ihDigitoCli ....... [%ld]"
                                "\n\t\t\t=> ihCodTipoTar....... [%ld]"
                                "\n\t\t\t=> szCadenaDelete..... [%s]"
                                ,LOG06, ihDigitoCli, ihCodTipoTar,szCadenaDelete);

/* SAAM-20041021 Se incluye lógica para desechar indice, P-MAS-04042 */
    if (!bfnDropIndexPF(ihCodTipoTar))
    {
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
             vDTrazasLog(szExeLoadTarif, "\n\t***  Error al borrar indice TAS ***",LOG03 );
        else
             vDTrazasLog(szExeLoadTarif, "\n\t***  Error al borrar indice TOL ***",LOG03 );
        return (FALSE);
    }
    else
    {
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
             vDTrazasLog(szExeLoadTarif, "\n\t***  Indices TAS Eliminados Correctamente ***",LOG03 );
        else
             vDTrazasLog(szExeLoadTarif, "\n\t***  Indices TOL Eliminados Correctamente ***",LOG03 );
    }

    vDTrazasLog(szExeLoadTarif, "\n\t*** Función bfnDropIndexPF Finalizada ***",LOG03 );

    if(!vfnCreaQuerysDinamicos(ihDigitoCli, ihCodTipoTar))
    {
        return (FALSE);
    }
    
    vDTrazasLog(szExeLoadTarif, "\n\t*** Función vfnCreaQuerysDinamicos Finalizada ***",LOG03 );

    if(!vfnRecuperaMaxMin(ihDigitoCli, ihCodTipoTar,lhCodCiclo,lhCodCiclFact, &lhMinCodCliente, &lhMaxCodCliente)) /* PGG New */
    {                                                                                                              /* PGG New */
        return (FALSE);                                                                                            /* PGG New */
    }                                                                                                              /* PGG New */
    
    vDTrazasLog(szExeLoadTarif, "\n\t*** Función vfnRecuperaMaxMin Finalizada ***",LOG03 );

    lhIniCodCliente=lhMinCodCliente;
    lhEndCodCliente=lhIniCodCliente + lGrupoCommit  ;
    
    while( bFinCursor_cFaCicloCli == FALSE ) /* Ciclo principal con el grupo de clientes */
    {
    	vDTrazasLog  (szExeLoadTarif, "\n\t*** Rango de proceso de codigos de clientes %ld a %ld, incrememto de %ld ***",LOG03, lhIniCodCliente,lhEndCodCliente, lGrupoCommit); /* PGG New */
        if( lhEndCodCliente >= lhMaxCodCliente ) /* Si el cliente superior es mayor a cliente max, el superior es el max */
        {
            lhEndCodCliente=lhMaxCodCliente;
            bFinCursor_cFaCicloCli = TRUE;
        }
        
        /* EXEC SQL PREPARE sql_valida_tarificadas FROM :szCadenaValida; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )40;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadenaValida;
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


	
	if( SQLCODE )
	{
	        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Valida  **"
	                                                                        "\n\t\t=> Digito        [%d] "                                
	                                                                        "\n\t\t=> Tipo Tasacion [%d] "
	                                                                        "\n\t\t=> Error : [%d]  [%s] "
	                                                                        "\n\t\t=> QUERY : [%s]\n"
	                                                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaValida);
	        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Valida  **"
	                                                                        "\n\t\t=> Digito        [%d] "                                
	                                                                        "\n\t\t=> Tipo Tasacion [%d] "
	                                                                        "\n\t\t=> Error : [%d]  [%s] "
	                                                                        "\n\t\t=> QUERY : [%s]\n"
	                                                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaValida);
	        return (FALSE);
	}
	                         
	
	/* EXEC SQL DECLARE CursorValida CURSOR FOR sql_valida_tarificadas; */ 

	
	if( SQLCODE )
	{
	        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-DECLARE Cursor Valida  **"
	                                                                        "\n\t\t=> Digito        [%d] "                                
	                                                                        "\n\t\t=> Tipo Tasacion [%d] "
	                                                                        "\n\t\t=> Error : [%d]  [%s] "
	                                                                        "\n\t\t=> QUERY : [%s]\n"
	                                                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
	        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-DECLARE Cursor Valida  **"
	                                                                        "\n\t\t=> Digito        [%d] "                                
	                                                                        "\n\t\t=> Tipo Tasacion [%d] "
	                                                                        "\n\t\t=> Error : [%d]  [%s] "
	                                                                        "\n\t\t=> QUERY : [%s]\n"
	                                                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
	        return (FALSE);
	}
	
	/* EXEC SQL OPEN CursorValida
	                USING       :lhCodCiclo,
	                                        :lhIniCodCliente,
	                                        :lhEndCodCliente,
	                                        :lhCodCiclFact  ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )59;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhIniCodCliente;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhEndCodCliente;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
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


	                                        
	if ( SQLCODE )
	{
	    vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Valida  **"
	                                    "\n\t------------------------------------"
	                                    "\n\t\t=> Error : [%d]  [%s] "
	                                    ,LOG01, SQLCODE,SQLERRM);
	    vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Valida  **"
	                                    "\n\t------------------------------------"
	                                    "\n\t\t=> Error : [%d]  [%s] "
	                                    ,LOG01, SQLCODE,SQLERRM);
	    return  (FALSE);
	}
	        
	/* EXEC SQL FETCH CursorValida INTO  :lRows ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )90;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lRows;
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


	        
	        
        if(SQLCODE )
        {
        	lhIniCodCliente=lhEndCodCliente;
                lhEndCodCliente+=lGrupoCommit  ;
                
                /* EXEC SQL CLOSE CursorValida ; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 5;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )109;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                
                if (SQLCODE)
                {
                        vDTrazasLog  (szExeLoadTarif , "<< En CLOSE del Cursor Valida >>"
                                                                   "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
                        vDTrazasError(szExeLoadTarif , "<< En CLOSE del Cursor Valida >>"
                                                                   "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
                        return (FALSE);
                }
                continue;
	}
	        
        /* EXEC SQL CLOSE CursorValida ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )124;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        
        if (SQLCODE)
        {
                vDTrazasLog  (szExeLoadTarif , "<< En CLOSE del Cursor Valida >>"
                                                           "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
                vDTrazasError(szExeLoadTarif , "<< En CLOSE del Cursor Valida >>"
                                                           "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
                return (FALSE);
        }
	        
	if ( lRows < 1 )
	{
                if(!vfnRecuperaMaxMin(ihDigitoCli, ihCodTipoTar,lhCodCiclo,lhCodCiclFact, &lhMinCodCliente, &lhMaxCodCliente))
                {
                        return (FALSE);
                }
                
    		vDTrazasLog  (szExeLoadTarif, "\n\t*** Rango %ld a %ld Sin registros para procesar, ahora comienza de %ld hasta %ld... ***",LOG03, lhIniCodCliente,lhEndCodCliente,lhMinCodCliente,lhMaxCodCliente);
                
                lhIniCodCliente=lhMinCodCliente;
                lhEndCodCliente=lhIniCodCliente + lGrupoCommit  ;

                continue;
	}
	

        vDTrazasLog(szExeLoadTarif, "\n%s\n\t\t\t   EXECUTE   sql_insert_tarificadas "
                                    "\n\t\t\t------------------------------------"
                                    "\n\t\t\t=> lhCodCiclo ....... [%ld]"
                                    "\n\t\t\t=> lhIniCodCliente... [%ld]"
                                    "\n\t\t\t=> lhEndCodCliente... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    ,LOG05, bszFechaHora(), lhCodCiclo, lhIniCodCliente,lhEndCodCliente,ihDigitoCli, lhCodCiclFact);

        /* SAAM-20041019 Se incluye filtro segun HD-200405240798, P-MAS-04042 */
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
        {
            /* EXEC SQL EXECUTE sql_insert_tarificadas
                  USING  :lhCodCiclFact,
                         :lhCodCiclo,
                         :lhIniCodCliente,
                         :lhEndCodCliente; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 5;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )139;
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
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhIniCodCliente;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhEndCodCliente;
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
            /* EXEC SQL EXECUTE sql_insert_tarificadas
                  USING  :lhCodCiclo,
                         :lhIniCodCliente,
                         :lhEndCodCliente,
                         /o :ihDigitoCli, o/
                         :lhCodCiclFact; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 5;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )170;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhIniCodCliente;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhEndCodCliente;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
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

        if ( SQLCODE )
        {
            vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Insert  **"
                                            "\n\t------------------------------------"
                                            "\n\t\t=> Error : [%d]  [%s] "
                                            ,LOG01, SQLCODE,SQLERRM);
            vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Insert  **"
                                            "\n\t------------------------------------"
                                            "\n\t\t=> Error : [%d]  [%s] "
                                            ,LOG01, SQLCODE,SQLERRM);
            return  (FALSE);
        }

        lFilasInsert=(SQLROWS>0?SQLROWS:0);
        
        vDTrazasLog(szExeLoadTarif, "\n%s\n\t\t\t   EXECUTE   sql_delete_tarificadas "
                                    "\n\t\t\t------------------------------------"
                                    "\n\t\t\t=> lhCodCiclo ....... [%ld]"
                                    "\n\t\t\t=> lhIniCodCliente... [%ld]"
                                    "\n\t\t\t=> lhEndCodCliente... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    ,LOG05,bszFechaHora(), lhCodCiclo, lhIniCodCliente,lhEndCodCliente,ihDigitoCli, lhCodCiclFact);

      
	if(lFilasInsert > 0)
	{
		  /* SAAM-20041019 Se incluye filtro segun HD-200405240798, P-MAS-04042 */
	        if (ihCodTipoTar==TIPO_TASA_CLASICA)
	        {
	            /* EXEC SQL EXECUTE sql_delete_tarificadas
	                  USING       :lhCodCiclFact,
	                              :lhCodCiclo,
	                              :lhIniCodCliente,
	                              :lhEndCodCliente; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 5;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )201;
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
             sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
             sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[1] = (         int  )0;
             sqlstm.sqindv[1] = (         short *)0;
             sqlstm.sqinds[1] = (         int  )0;
             sqlstm.sqharm[1] = (unsigned long )0;
             sqlstm.sqadto[1] = (unsigned short )0;
             sqlstm.sqtdso[1] = (unsigned short )0;
             sqlstm.sqhstv[2] = (unsigned char  *)&lhIniCodCliente;
             sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
             sqlstm.sqhsts[2] = (         int  )0;
             sqlstm.sqindv[2] = (         short *)0;
             sqlstm.sqinds[2] = (         int  )0;
             sqlstm.sqharm[2] = (unsigned long )0;
             sqlstm.sqadto[2] = (unsigned short )0;
             sqlstm.sqtdso[2] = (unsigned short )0;
             sqlstm.sqhstv[3] = (unsigned char  *)&lhEndCodCliente;
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
			/* EXEC SQL EXECUTE sql_delete_tarificadas
			USING       :lhCodCiclo,
                        :lhIniCodCliente,
                        :lhEndCodCliente,
                        :lhCodCiclFact  ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )232;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhIniCodCliente;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhEndCodCliente;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
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

		if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
		{
			vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Delete  **"
				"\n\t------------------------------------"
				"\n\t\t=> Error : [%d]  [%s] "
				,LOG01, SQLCODE,SQLERRM);
			vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-EXECUTE Delete  **"
				"\n\t------------------------------------"
				"\n\t\t=> Error : [%d]  [%s] "
				,LOG01, SQLCODE,SQLERRM);
			return  (FALSE);
		}

		lFilasDelete=(SQLROWS>0?SQLROWS:0);	/* PGG New */
	}					/* PGG New */
	else                            	/* PGG New */
	{                               	/* PGG New */
		lFilasDelete=0;         	/* PGG New */
	}                               	/* PGG New */
        
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
        {
            vDTrazasLog(szExeLoadTarif, " \n%s\n\t\t\t   Estadisticas  TA_TARIFICADAS%d   "
                                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                                        " \n\t\t\t    Filas Borradas       [%ld]      "
                                        " \n\t\t\t------------------------------------",
                                        LOG04,bszFechaHora(),iDigitoCli,lFilasInsert,lFilasDelete);
        }
        
        if (ihCodTipoTar==TIPO_TASA_ON_LINE)
        {
            vDTrazasLog(szExeLoadTarif, " \n%s\n\t\t\t   Estadisticas  TOL_DETFACTURA_%d  "
                                        " \n\t\t\t    Filas Insertadas     [%ld]      "
                                        " \n\t\t\t    Filas Borradas       [%ld]      "
                                        " \n\t\t\t------------------------------------",
                                        LOG04,bszFechaHora(),iDigitoCli,lFilasInsert,lFilasDelete);
        }

        if (lFilasInsert != lFilasDelete)
        {
            vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
            vDTrazasError(szExeLoadTarif,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
            return (FALSE);
        }
                     
	if (lFilasInsert > 0 )                                                                                                          /* PGG New */
	{                                                                                                                               /* PGG New */
	        if ( !bfnOraCommit())                                                                                                   /* PGG New */
	        {                                                                                                                       /* PGG New */
	                vDTrazasLog  (szExeLoadTarif,   " \n\t------------------------------------"                                     /* PGG New */
	                                                                                " \n\tFallo en el Commit TA_TARIFICADAS%d "     /* PGG New */
	                                                                                " \n\t             o en TOL_DETFACTURA_%d "     /* PGG New */
	                                                                                " \n\t------------------------------------",    /* PGG New */
	                                                                                LOG01,iDigitoCli,iDigitoCli);                   /* PGG New */
	                vDTrazasError(szExeLoadTarif,   " \n\t------------------------------------"                                     /* PGG New */
	                                                                                " \n\tFallo en el Commit TA_TARIFICADAS%d "     /* PGG New */
	                                                                                " \n\t             o en TOL_DETFACTURA_%d "     /* PGG New */
	                                                                                " \n\t------------------------------------",    /* PGG New */
	                                                                                LOG01,iDigitoCli,iDigitoCli);                   /* PGG New */
	                return (FALSE);                                                                                                 /* PGG New */
	        }                                                                                                                       /* PGG New */
	}																/* PGG New */
	
        if (lFilasDelete > 0)
        {
            lTotClientes    ++;
            lTotLlamadas    +=lFilasDelete;
            lLlamadasOK     +=lFilasDelete;
        }
    
        lhIniCodCliente=lhEndCodCliente;
        lhEndCodCliente+=lGrupoCommit  ;
    }
/* SAAM-20041021 Se vuelve a crear el indice */
    if (!bfnCreateIndexPF(ihCodTipoTar))
    {
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al crear indice TAS ***",LOG03 );
        else
            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al crear indice TOL ***",LOG03 );
        return (FALSE);
    }
    else
    {
        if (ihCodTipoTar==TIPO_TASA_CLASICA)
            vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TAS Creado Correctamente ***",LOG03 );
        else
            vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TOL Creado Correctamente ***",LOG03 );
    }

/* --------------------------------------------------------------------- */
/* PGG SOPORTE 28/07/2006 CO-200607280274 Desde Aqui - Solucion By AFGS -*/
/* --------------------------------------------------------------------- */
/*AFGS*/
vDTrazasLog(szExeLoadTarif, "\n\n\t\t\t FA_MARCALLAM_PG.FA_MARCADET_PR ( "
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> lcod_CodMegError.. [%ld]"
                                    "\n\t\t\t=> szmsg_DetMsgError. [%s]"
                                    "\n\t\t\t=> lnum_Evento....... [%ld] )"                                
                                    ,LOG05,lhCodCiclFact, ihDigitoCli, lcod_CodMegError,szmsg_DetMsgError,lnum_Evento);



        if (ihCodTipoTar==TIPO_TASA_ON_LINE)
        {
         /* EXEC SQL EXECUTE
         BEGIN
             FA_MARCALLAM_PG.FA_MARCADET_PR(:lhCodCiclFact, :ihDigitoCli, :lcod_CodMegError, :szmsg_DetMsgError, :lnum_Evento);
         END;
         END-EXEC; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 5;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "begin FA_MARCALLAM_PG . FA_MARCADET_PR ( :lhCodCiclF\
act , :ihDigitoCli , :lcod_CodMegError , :szmsg_DetMsgError , :lnum_Evento ) ;\
 END ;";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )263;
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
         sqlstm.sqhstv[1] = (unsigned char  *)&ihDigitoCli;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)&lcod_CodMegError;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)szmsg_DetMsgError;
         sqlstm.sqhstl[3] = (unsigned long )200;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lnum_Evento;
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

	 
                  
          if(SQLCODE != SQLOK  || lcod_CodMegError != 0)
           {
        	
             vDTrazasError  ( szExeLoadTarif ,"\n**  Error en Funcion FA_MARCADET_PR( ) **"
                              " [%d]  [%s]",LOG01,SQLCODE,SQLERRM);
                                          
             vDTrazasLog    (szExeLoadTarif, "\n**  Error en Funcion FA_MARCADET_PR( ) **"
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> cod_CodMegError... [%ld]"
                                    "\n\t\t\t=> szmsg_DetMsgError. [%s]"
                                    "\n\t\t\t=> lnum_Evento....... [%ld] )"                                
                                    ,LOG01,lhCodCiclFact, ihDigitoCli, lcod_CodMegError,szmsg_DetMsgError,lnum_Evento);               
                             
             return(FALSE);
           }
           
           vDTrazasLog    (szExeLoadTarif, "\n** Funcion FA_MARCADET_PR( ) termina OK**"
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> :szmsg_DetMsgError... [%s]"
                           ,LOG01,lhCodCiclFact, ihDigitoCli, szmsg_DetMsgError);               
           
        }

        
        
        vDTrazasLog(szExeLoadTarif, "\n%s\n\t\t\t   EXECUTE   sql_delete_tarificadas "
                                    "\n\t\t\t------------------------------------"
                                    "\n\t\t\t=> lhCodCiclo ....... [%ld]"
                                    "\n\t\t\t=> lhIniCodCliente... [%ld]"
                                    "\n\t\t\t=> lhEndCodCliente... [%ld]"
                                    "\n\t\t\t=> ihDigitoCli....... [%d]"
                                    "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                    ,LOG05,bszFechaHora(), lhCodCiclo, lhIniCodCliente,lhEndCodCliente,ihDigitoCli, lhCodCiclFact);

/*AFGS*/
/* --------------------------------------------------------------------- */
/* PGG SOPORTE 28/07/2006 CO-200607280274 Hasta Aqui - Solucion By AFGS -*/
/* --------------------------------------------------------------------- */


    vDTrazasLog(szExeLoadTarif,"\n\t***   Termino de Proceso Cargar de Trafico Para Facturacion de Ciclo  ***\n",LOG03); 

    vDTrazasLog(szExeLoadTarif, "\n%s\n\t** ESTADISTICAS DEL PROCESO LOADTARFIF "
                                "\n\t\t==>  [%10ld] Clientes Procesados     "
                                "\n\t\t==>  [%10ld] Ciclos Insert/Delete    " /* SAAM segun HD-200405240798, P-MAS-04042 */
                                "\n\t\t==>  [%10ld] Llamadas Procesadas     "
                                "\n\t\t==>  [%10ld] Llamadas Correctas      "
                                "\n\t\t==>  [%10ld] Llamadas Errores        ",
                                LOG03,bszFechaHora(), lhTotalClientes, lTotClientes,lTotLlamadas,lLlamadasOK,lLlamadasErr); 

/* SAAM-20041019 se agrega creacion de indice con mensajes a la pantalla segun HD-200408301790, P-MAS-04042 */
/*    if (ihCodTipoTar==TIPO_TASA_CLASICA)
    {
        vDTrazasLog(szExeLoadTarif, "\n\t***  Creando Indice TAS ***",LOG03 );
        fprintf (stdout,"\n\n\t\t*** Creando Indice TAS ***\n") ;
        if (!bfnCreateIndexPF())
        {
            vDTrazasLog(szExeLoadTarif, "\n\t***  Error al Crear indice TAS ***",LOG03 );
            return (FALSE);
        }
        vDTrazasLog(szExeLoadTarif, "\n\t***  Indice TAS Creado ***",LOG03 );
        fprintf (stdout,"\t\t*** Indice TAS Creado ***\n") ;
    }
*/

    if (stTrazaProc.lCodCiclFact > 0)
    {
        if (!bfnSelectSysDate(szSysDate))
            vDTrazasLog(szExeLoadTarif,"\n\t*** Error en bfnSelectSysDate (bfnCargaTraficoCicloFact) ***\n",LOG01); 
        else
        {
            stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
            strcpy(stTrazaProc.szFecTermino,szSysDate)                              ;
            strcpy(stTrazaProc.szGlsProceso,"Proceso Carga de Trafico Terminado OK");
            stTrazaProc.lCodCliente        = stTrazaProc.lCodCliente+lTotClientes   ;
            stTrazaProc.lNumAbonado        = 0                                      ;
            stTrazaProc.lNumRegistros      = stTrazaProc.lNumRegistros+lLlamadasOK  ;
            bPrintTrazaProc(stTrazaProc);
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }
    }
                                
    return TRUE;
    
}/* funcion BOOL bfnCargaTraficoCicloFact(long lCiclParam,int Digito)  */



/**************************************************************************************/
/*   funcion void vfnInitCadenaInsertTarif(char *szCadena ,int iDigito, int iTipoTas) */
/**************************************************************************************/
/*  Rutina que Crea Cadena para Insertar Registros en PF_TARIFICADAS para             */
/*  ejecutar con Query Dinamico                                                       */
/*  SAAM-20021220 Se incluye el tipo de tasacion en la funcion                        */
/*  void vfnInitCadenaInsertTarif(char *szCadena ,int iDigito)                        */
/**************************************************************************************/
static void vfnInitCadenaInsertTarif(char *szCadena ,int iDigito, int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA){
        sprintf(szCadena, "INSERT INTO PF_TARIFICADAS ( "               
            "\nCOD_TIPCENTRAL   ,COD_CENTRAL      ,"
            "\nNUM_BLOQUE       ,FEC_INITASA      ,"
            "\nCOD_CLIENTE      ,NUM_ABONADO      ,"
            "\nIND_ALQUILER     ,IND_LIMFRA       ,"
            "\nCOD_PERIODO      ,NUM_MOVIL1       ,"
            "\nNUM_MOVIL2       ,COD_ALM          ,"
            "\nTIE_INILLAM      ,TIE_INISEND      ,"
            "\nTIE_INIANSW      ,TIE_DURSEND      ,"
            "\nTIE_DURANSW      ,FEC_FINLLAM      ,"
            "\nCOD_RUTAA        ,COD_RUTAOPE      ,"
            "\nCOD_RUTAALM      ,COD_RUTACELDA    ,"
            "\nCOD_RUTATOPE     ,IND_RUTA         ,"
            "\nCOD_RUTAB        ,COD_RUTBOPE      ,"
            "\nCOD_RUTBALM      ,COD_RUTBCELDA    ,"
            "\nCOD_RUTBTOPE     ,IND_RUTB         ,"
            "\nNUM_MSNB1        ,NUM_NSE1         ,"
            "\nCOD_AREA1        ,IND_TIPABO1      ,"
            "\nIND_TIPLLA1      ,IND_TIPTAR1      ,"
            "\nIND_ENTSAL1      ,IND_OPERLD1      ,"
            "\nIND_LOCAL1       ,IND_LARGA1       ,"
            "\nCOD_TARLOC1      ,COD_REDLOC1      ,"
            "\nIMP_LOCAL1       ,DUR_LOCAL1       ,"
            "\nNUM_PULSOS1      ,COD_TARLD1       ,"
            "\nCOD_REDLD1       ,IMP_LARGA2       ,"
            "\nDUR_LARGA2       ,NUM_PULSOS2      ,"
            "\nCOD_AREA2        ,DES_MOVIL2       ,"
            "\nCOD_FRANHORASOC  ,IMSI_A           ,"
            "\nIMEI_A           ,IMSI_B           ,"
            "\nIMEI_B           ,NETWORK_TYPE     ,"
            "\nGSM_DATA)"                           
        "\nSELECT "                                 
            "\nCOD_TIPCENTRAL   ,COD_CENTRAL      ,"
            "\nNUM_BLOQUE       ,FEC_INITASA      ,"
            "\nCOD_CLIENTE      ,NUM_ABONADO      ,"
            "\nIND_ALQUILER     ,IND_LIMFRA       ,"
            "\nCOD_PERIODO      ,NUM_MOVIL1       ,"
            "\nNUM_MOVIL2       ,COD_ALM          ,"
            "\nTIE_INILLAM      ,TIE_INISEND      ,"
            "\nTIE_INIANSW      ,TIE_DURSEND      ,"
            "\nTIE_DURANSW      ,FEC_FINLLAM      ,"
            "\nCOD_RUTAA        ,COD_RUTAOPE      ,"
            "\nCOD_RUTAALM      ,COD_RUTACELDA    ,"
            "\nCOD_RUTATOPE     ,IND_RUTA         ,"
            "\nCOD_RUTAB        ,COD_RUTBOPE      ,"
            "\nCOD_RUTBALM      ,COD_RUTBCELDA    ,"
            "\nCOD_RUTBTOPE     ,IND_RUTB         ,"
            "\nNUM_MSNB1        ,NUM_NSE1         ,"
            "\nCOD_AREA1        ,IND_TIPABO1      ,"
            "\nIND_TIPLLA1      ,IND_TIPTAR1      ,"
            "\nIND_ENTSAL1      ,IND_OPERLD1      ,"
            "\nIND_LOCAL1       ,IND_LARGA1       ,"
            "\nCOD_TARLOC1      ,COD_REDLOC1      ,"
            "\nIMP_LOCAL1       ,DUR_LOCAL1       ,"
            "\nNUM_PULSOS1      ,COD_TARLD1       ,"
            "\nCOD_REDLD1       ,IMP_LARGA2       ,"
            "\nDUR_LARGA2       ,NUM_PULSOS2      ,"
            "\nCOD_AREA2        ,DES_MOVIL2       ,"
            "\nCOD_FRANHORASOC  ,IMSI_A           ,"
            "\nIMEI_A           ,IMSI_B           ,"
            "\nIMEI_B           ,NETWORK_TYPE     ,"
            "\nGSM_DATA"
        "\nFROM   TA_TARIFICADAS%d "
        "\n WHERE    COD_PERIODO  = :lhCodCiclFact  %s"
        "\n AND  (COD_CLIENTE,NUM_ABONADO) IN "
        "\n ( SELECT B.COD_CLIENTE,B.NUM_ABONADO "
        "\n   FROM    FA_CICLOCLI B            "
        "\n   WHERE   B.COD_CICLO+0         = :lhCodCiclo "
        "\n   AND     B.IND_MASCARA         = 1  "
        "\n   AND     B.COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente )",iDigito,szCondicion_Trafico); /* SAAM-20041019 Se agrega filtro de trafico a query segun HD-200408301790, P-MAS-04042 */        
    }
    if (iTipoTas==TIPO_TASA_ON_LINE){
        sprintf(szCadena, "INSERT INTO PF_TOLTARIFICA ( "               
            "\nSEC_EMPA         ,SEC_CDR          ,"
            "\nRECORD_TYPE      ,A_SUSC_NUMBER    ,"
            "\nA_SUSC_MS_NUMBER ,B_SUSC_NUMBER    ,"
            "\nB_SUSC_MS_NUMBER ,A_CATEGORY       ,"
            "\nIND_BILLETE      ,DATE_START_CHARG ," 
            "\nTIME_START_CHARG ,CHARGABLE_DURAT  ,"
            "\nDATE_SEND_CHARG  ,TIME_SEND_CHARG  ,"
            "\nSEND_DURAT       ,COD_CCC          ,"
            "\nOUTGOING_ROUTE   ,INCOMING_ROUTE   ,"
            "\nINSI_CODE        ,COD_AGRL         ,"
            "\nCOD_SENT         ,COD_LLAM         ,"
            "\nCOD_TDIR         ,COD_TCOR         ,"
            "\nCOD_THOR         ,COD_TDIA         ,"
            "\nCOD_FCOB         ,IND_TABLA        ,"
            "\nCOD_CARG         ,COD_CARR         ,"
            "\nCOD_GRUPO        ,NUM_CLIE         ,"
            "\nNUM_ABON         ,COD_PLAN         ,"
            "\nCOD_CICL         ,COD_CICLFACT     ,"
            "\nCOD_AREAC        ,COD_ALMC         ,"
            "\nCOD_LIMITE       ,IND_APLICA       ,"
            "\nCOD_BOLSA        ,IND_APLB         ,"
            "\nCOD_OPERA        ,COD_TOPRA        ,"
            "\nCOD_DOPERA       ,COD_TRANA        ,"
            "\nCOD_ALMA         ,COD_AREAA        ,"
            "\nCOD_LOCAA        ,COD_OPERB        ,"
            "\nCOD_TOPRB        ,COD_DOPEB        ,"
            "\nCOD_TRANB        ,COD_ALMB         ,"
            "\nCOD_AREAB        ,COD_LOCAB        ,"
            "\nCOD_PAIS         ,COD_SUBFRANJA    ,"
            "\nIND_DCTO_MLIB    ,IND_MUESTRA_LLAM ,"
            "\nDUR_REAL         ,NUM_PULSO        ,"
            "\nDUR_FACT         ,TIP_MONE         ," 
            "\nMTO_REAL         ,TIP_DCTO         ,"
            "\nCOD_DCTO         ,ITM_DCTO         ,"
            "\nDUR_DCTO         ,MTO_FACT         ,"
            "\nMTO_DCTO         ,IND_EXEDENTE     ,"
            "\nCOD_UMBRAL       ,DES_DESTINO      ,"
            "\nDES_LLAMADA) "
        "\nSELECT "            
            "\nSEC_EMPA         ,SEC_CDR          ,"
            "\nRECORD_TYPE      ,A_SUSC_NUMBER    ,"
            "\nA_SUSC_MS_NUMBER ,B_SUSC_NUMBER    ,"
            "\nB_SUSC_MS_NUMBER ,A_CATEGORY       ,"
            "\nIND_BILLETE      ,DATE_START_CHARG ," 
            "\nTIME_START_CHARG ,CHARGABLE_DURAT  ,"
            "\nDATE_SEND_CHARG  ,TIME_SEND_CHARG  ,"
            "\nSEND_DURAT       ,COD_CCC          ,"
            "\nOUTGOING_ROUTE   ,INCOMING_ROUTE   ,"
            "\nINSI_CODE        ,COD_AGRL         ,"
            "\nCOD_SENT         ,COD_LLAM         ,"
            "\nCOD_TDIR         ,COD_TCOR         ,"
            "\nCOD_THOR         ,COD_TDIA         ,"
            "\nCOD_FCOB         ,IND_TABLA        ,"
            "\nCOD_CARG         ,COD_CARR         ,"
            "\nCOD_GRUPO        ,NUM_CLIE         ,"
            "\nNUM_ABON         ,COD_PLAN         ,"
            "\nCOD_CICL         ,COD_CICLFACT     ,"
            "\nCOD_AREAC        ,COD_ALMC         ,"
            "\nCOD_LIMITE       ,IND_APLICA       ,"
            "\nCOD_BOLSA        ,IND_APLB         ,"
            "\nCOD_OPERA        ,COD_TOPRA        ,"
            "\nCOD_DOPERA       ,COD_TRANA        ,"
            "\nCOD_ALMA         ,COD_AREAA        ,"
            "\nCOD_LOCAA        ,COD_OPERB        ,"
            "\nCOD_TOPRB        ,COD_DOPEB        ,"
            "\nCOD_TRANB        ,COD_ALMB         ,"
            "\nCOD_AREAB        ,COD_LOCAB        ,"
            "\nCOD_PAIS         ,COD_SUBFRANJA    ,"
            "\nIND_DCTO_MLIB    ,IND_MUESTRA_LLAM ,"
            "\nDUR_REAL         ,NUM_PULSO        ,"
            "\nDUR_FACT         ,TIP_MONE         ,"
            "\nMTO_REAL         ,TIP_DCTO         ,"
            "\nCOD_DCTO         ,ITM_DCTO         ,"
            "\nDUR_DCTO         ,MTO_FACT         ,"
            "\nMTO_DCTO         ,IND_EXEDENTE     ,"
            "\nCOD_UMBRAL       ,DES_DESTINO      , "
            "\nDES_LLAMADA "
/*----------------------------------------------------------*/
/* Inicio homologacion en CO-200607290283 by PPV 02/08/2006 */
/*----------------------------------------------------------*/
	        /*AFGS INICIO RA-200603130905*/
	        "\nFROM   TOL_DETFACTURA_0%d A " 
	        "WHERE NUM_CLIE BETWEEN :lhinicodcliente AND :lhendcodcliente\n"
	        "AND NUM_ABON > 0"
	        " AND EXISTS (SELECT NULL\n"
	                     "FROM FA_CICLOCLI F\n"
                         "WHERE A.NUM_CLIE = F.COD_CLIENTE\n"
                         "AND F.COD_CICLO = :lhcodciclo\n"
                         "AND IND_MASCARA = 1)\n"
            "AND COD_CICLFACT = :lhcodciclfact\n",iDigito);

  /*AFGS FIN RA-200603130905*/

/*          
        "\nFROM   TOL_DETFACTURA_0%d  "         
	"\nWHERE  (NUM_CLIE, NUM_ABON ) IN "	
	"\n ( SELECT COD_CLIENTE,NUM_ABONADO "  
        "\n   FROM    FA_CICLOCLI             "
        "\n   WHERE   COD_CICLO           = :lhCodCiclo "
        "\n   AND     IND_MASCARA         = 1 "
	"\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente ) "	
        "\n AND    COD_CICLFACT  = :lhCodCiclFact ", iDigito);
*/

/*-------------------------------------------------------*/
/* Fin homologacion en CO-200607290283 by PPV 02/08/2006 */
/*-------------------------------------------------------*/

    }
}/*   funcion void vfnInitCadenaInsertTarif(char *szCadena ,int iDigito)     */



/**************************************************************************************/
/*   funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito, int iTipoTas) */
/**************************************************************************************/
/*  Rutina que Crea Cadena para Deletar Registros en TA_TARIFICADAS0..9               */
/*  para ejecutar con Query Dinamico                                                  */
/*  SAAM-20021220 Se incluye el tipo de tasacion en la funcion                        */
/*  void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito)                        */
/**************************************************************************************/
/* INICIO  CO-200607290283 CJG
static void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito, int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA){
          sprintf(szCadena, "DELETE FROM   TA_TARIFICADAS%d      "
            "\n WHERE    COD_PERIODO  = :lhCodCiclFact  %s"
            "\n AND  (COD_CLIENTE,NUM_ABONADO) IN  "
            "\n ( SELECT B.COD_CLIENTE, B.NUM_ABONADO "            
            "\n   FROM    FA_CICLOCLI B             "
            "\n   WHERE   B.COD_CICLO+0       = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente )" ,iDigito ,szCondicion_Trafico);  SAAM-20041019 Se agrega filtro de trafico a query segun HD-200408301790, P-MAS-04042 
    }
    if (iTipoTas==TIPO_TASA_ON_LINE){
          sprintf(szCadena, "DELETE FROM   TOL_DETFACTURA_0%d     "  SAAM-20030323 Se incluye caracter 0 
            "\nWHERE NUM_CLIE > 0 "
            "\nAND NUM_ABON > 0 "
            "\nAND NUM_CLIE||NUM_ABON IN "
            "\n ( SELECT COD_CLIENTE||NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente "
            "\n   AND     mod(COD_CLIENTE,10) = :ihDigitoCli ) " 
            "\n )AND    COD_CICLFACT  = :lhCodCiclFact ", iDigito);      
    }
}   funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito)     */

static void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito, int iTipoTas)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

char szhTablaTol[31];
char szhTablaTol2[31];
char szhIndexTol[31];
char szhIndexTol2[31];
char szhIndexName[31];
/* EXEC SQL END DECLARE SECTION; */ 


    if (iTipoTas==TIPO_TASA_CLASICA){
          sprintf(szCadena, "DELETE FROM   TA_TARIFICADAS%d      "
            "\n WHERE    COD_PERIODO  = :lhCodCiclFact  %s"
            "\n AND  (COD_CLIENTE,NUM_ABONADO) IN  "
            "\n ( SELECT B.COD_CLIENTE, B.NUM_ABONADO "            
            "\n   FROM    FA_CICLOCLI B             "
            "\n   WHERE   B.COD_CICLO+0       = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente )" ,iDigito ,szCondicion_Trafico); /* SAAM-20041019 Se agrega filtro de trafico a query segun HD-200408301790, P-MAS-04042 */
    }
    if (iTipoTas==TIPO_TASA_ON_LINE){
    	
    	/*AFGS INICIO RA-200603130905*/
    	memset (szhTablaTol,0x00,sizeof(szhTablaTol));
    	memset (szhTablaTol2,0x00,sizeof(szhTablaTol2));
    	memset (szhIndexTol,0x00,sizeof(szhIndexTol));
    	memset (szhIndexTol2,0x00,sizeof(szhIndexTol2));
    	memset (szhIndexName,0x00,sizeof(szhIndexName));
    	
    	sprintf(szhTablaTol,"TOL_DETFACTURA_0%d",iDigito);
    	strcpy(szhTablaTol2,szhTablaTol);
    	sprintf(szhIndexTol,"X01TOL_DETFACTURA_0%d",iDigito);
    	strcpy(szhIndexTol2,szhIndexTol);
    	
      trim(szhTablaTol,szhTablaTol);
      trim(szhIndexTol,szhIndexTol);
      trim(szhTablaTol2,szhTablaTol2);
      trim(szhIndexTol2,szhIndexTol2);
      
      /* EXEC SQL
      SELECT INDEX_NAME
      INTO :szhIndexName
      FROM ALL_INDEXES
      WHERE OWNER = 'TOL_SISCEL'
      AND TABLE_NAME = :szhTablaTol2
      AND INDEX_NAME LIKE :szhIndexTol||'%'; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 5;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select INDEX_NAME into :b0  from ALL_INDEXES where ((OW\
NER='TOL_SISCEL' and TABLE_NAME=:b1) and INDEX_NAME like (:b2||'%'))";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )298;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhIndexName;
      sqlstm.sqhstl[0] = (unsigned long )31;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhTablaTol2;
      sqlstm.sqhstl[1] = (unsigned long )31;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhIndexTol;
      sqlstm.sqhstl[2] = (unsigned long )31;
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


      	
      trim(szhIndexName,szhIndexName);
      	
      vDTrazasLog(szExeLoadTarif,"\n\t*** vfnInitCadenaDeleteTarif szhIndexName [%s] szhTablaTol2[%s] szhIndexTol[%s] ***\n",LOG06,szhIndexName,szhTablaTol2, szhIndexTol); 
      

	    sprintf(szCadena,"DELETE --+ INDEX (T, %s)\n"
	                     "FROM TOL_DETFACTURA_0%d t\n"
	                     "WHERE NUM_CLIE BETWEEN :lhinicodcliente AND :lhendcodcliente\n"
	                     "AND NUM_ABON > 0"
	                     "AND EXISTS (SELECT NULL\n"
	                                  "FROM FA_CICLOCLI F\n"
                                    "WHERE T.NUM_CLIE = F.COD_CLIENTE\n"
                                    "AND F.COD_CICLO = :lhcodciclo\n"
                                    "AND IND_MASCARA = 1)\n"
                       "AND COD_CICLFACT = :lhcodciclfact\n",szhIndexName,iDigito);
	    
	    vDTrazasLog(szExeLoadTarif,"\n\t*** vfnInitCadenaDeleteTarif szCadena [%s] ***\n",LOG06,szCadena); 
	    
   /* sprintf(szCadena, "DELETE FROM   TOL_DETFACTURA_0%d     "
            "\nWHERE NUM_CLIE > 0 "
            "\nAND NUM_ABON > 0 "
            "\nAND NUM_CLIE||NUM_ABON IN "
            "\n ( SELECT COD_CLIENTE||NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente "            
            "\n )AND    COD_CICLFACT  = :lhCodCiclFact ", iDigito);*/
        /*AFGS FIN RA-200603130905*/
    }
}/*   funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito)     */
/* FIN  CO-200607290283 CJG*/

static void vfnInitCadenaValidaTarif(char *szCadena ,int iDigito, int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA)
        {
          sprintf(szCadena, "SELECT COUNT(1)  FROM   TA_TARIFICADAS%d "
            "\nWHERE  (COD_CLIENTE, NUM_ABONADO) IN "
            "\n ( SELECT COD_CLIENTE, NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente )"
            "\n AND    COD_PERIODO  = :lhCodCiclFact  " 
            "\n AND    ROWNUM < 2 "  ,iDigito);      
    }
    if (iTipoTas==TIPO_TASA_ON_LINE)
        {
          sprintf(szCadena, "SELECT COUNT(1) FROM TOL_DETFACTURA_0%d "
            "\nWHERE  (NUM_CLIE,NUM_ABON) IN "
            "\n ( SELECT COD_CLIENTE,NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 "
            "\n   AND     COD_CLIENTE BETWEEN :lhIniCodCliente AND :lhEndCodCliente ) "
            "\n AND    COD_CICLFACT  = :lhCodCiclFact  "
            "\n AND    ROWNUM < 2 "  ,iDigito);      
                        
    }

}/*   funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito)     */


static void vfnInitCadenaMaxMinTarif(char *szCadena ,int iDigito, int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA)
        {
          sprintf(szCadena, "SELECT NVL(MIN(COD_CLIENTE),0), NVL(MAX(COD_CLIENTE),0) FROM  TA_TARIFICADAS%d "
            "\nWHERE  (COD_CLIENTE, NUM_ABONADO) IN "
            "\n ( SELECT COD_CLIENTE, NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 )"
            "\n AND    COD_PERIODO  = :lhCodCiclFact  " ,iDigito);      
    }
    if (iTipoTas==TIPO_TASA_ON_LINE)
        {
          sprintf(szCadena, "SELECT NVL(MIN(NUM_CLIE),0), NVL(MAX(NUM_CLIE),0) FROM TOL_DETFACTURA_0%d "
            "\nWHERE  (NUM_CLIE,NUM_ABON) IN "
            "\n ( SELECT COD_CLIENTE,NUM_ABONADO "
            "\n   FROM    FA_CICLOCLI             "
            "\n   WHERE   COD_CICLO           = :lhCodCiclo "
            "\n   AND     IND_MASCARA         = 1 )"
            "\n AND    COD_CICLFACT  = :lhCodCiclFact  " ,iDigito);      
                        
    }

}/*   funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito)     */



/****************************************************************************/
/*   funcion BOOL bfnDropIndexPF(int ihIndicaTasacion)                                      */
/****************************************************************************/
/*  Elimina Indice PK_PF_TARIFICADAS de tabla PF_TARIFICADAS                */
/****************************************************************************/

BOOL bfnDropIndexPF(int iIndTasacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhTabla[4096];
    char szhIndice[50];
    /* VARCHAR szhCadenaIndice[1024]; */ 
struct { unsigned short len; unsigned char arr[1024]; } szhCadenaIndice;

    /* VARCHAR szhCadenaCreacion[1024]; */ 
struct { unsigned short len; unsigned char arr[1024]; } szhCadenaCreacion;

    int  ihIndTasacion;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    FILE *fp_tmp;
    char szhCadenaAux1[1024];
    char szhCadenaAux2[1024];
    char szhCadenaResultado[8192];
    char szhAux[1024];
    char szArchivoTmp[1024];


    int iCont;
    int iPos;
    
    ihIndTasacion = iIndTasacion;
    vDTrazasLog(szExeLoadTarif,   "\n\t**IND_TASADOR [%d]\n", LOG03,ihIndTasacion);
    
    if (iIndTasacion == 1)
        strcpy(szhTabla,"PF_TOLTARIFICA");
    else
        strcpy(szhTabla,"PF_TARIFICADAS");

    
        
    /* EXEC SQL
    SELECT ltrim(rtrim(FA_UTILFAC_PG.FA_BUSCA_INDICES_FN(:szhTabla)))
    INTO :szhCadenaIndice
    FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ltrim(rtrim(FA_UTILFAC_PG.FA_BUSCA_INDICES_FN(:b0)\
)) into :b1  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )325;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTabla;
    sqlstm.sqhstl[0] = (unsigned long )4096;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&szhCadenaIndice;
    sqlstm.sqhstl[1] = (unsigned long )1026;
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



            
    if ( SQLCODE != SQLOK ) 
    {
       if (( SQLCODE != SQLNOTFOUND )&&  (SQLCODE != -904)&& (SQLCODE != -1405))
       {
           fprintf(stderr,"\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n",szhTabla,SQLCODE,SQLERRM);
           vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
           vDTrazasError(szExeLoadTarif, "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
           return (FALSE);
       }
       else
       {
           vDTrazasLog(szExeLoadTarif,"\n\t** Tabla [%s] sin indices\n", LOG03,szhTabla);
           return (TRUE);
       }
      
    }

    iPos=0;
    sprintf(szhCadenaAux1,"%.*s",szhCadenaIndice.len,szhCadenaIndice.arr);

/* SAAM-2004119 logica de archivo temporal que guarda los valores de creaciones de indice, P-MAS_04042 */
    szArchivoTmp[0]='\0';
    sprintf(szArchivoTmp,"%s%c%s",(char *)getenv("XPF_TMP"),'/',"loadtarif.tmp");

    szhCadenaResultado[0]='\0';
    while (strlen(szhCadenaAux1) > 0)
    {
        for (iCont=0;iCont < strlen(szhCadenaAux1); iCont++)
            if (szhCadenaAux1[iCont] == ':')
            {
                iPos=iCont;
                break;
            }
        sprintf(szhIndice,"%*.*s",1,iPos,szhCadenaAux1);
        vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s]\n", LOG03, szhIndice);
        /* EXEC SQL 
        SELECT ltrim(rtrim(FA_UTILFAC_PG.FA_OBTIENE_DESC_INDICES_FN(:szhIndice)))
        INTO :szhCadenaCreacion
        FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select ltrim(rtrim(FA_UTILFAC_PG.FA_OBTIENE_DESC_INDI\
CES_FN(:b0))) into :b1  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )348;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhIndice;
        sqlstm.sqhstl[0] = (unsigned long )50;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&szhCadenaCreacion;
        sqlstm.sqhstl[1] = (unsigned long )1026;
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



        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE != SQLNOTFOUND )
            {
                fprintf(stderr,"\n\t** ERROR al BUSCAR indice %s %d %s\n",szhIndice,SQLCODE,SQLERRM);
                vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al BUSCAR indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                vDTrazasError(szExeLoadTarif,   "\n\t** ERROR al BUSCAR indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                return (FALSE);
            }
            else
            {
                vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s] ya no existe\n", LOG03,szhIndice);
                return (TRUE);
            }
        }
        sprintf(szhCadenaAux2,"%.*s",szhCadenaCreacion.len,szhCadenaCreacion.arr);
        vDTrazasLog(szExeLoadTarif,"\n\t** Descripcion [%s]\n", LOG03, szhCadenaAux2);
        sprintf(szhCadenaResultado,"%s%s%c",szhCadenaResultado,szhCadenaAux2,':');
        szhAux[0]='\0';
        for (iCont=iPos+1;iCont < strlen(szhCadenaAux1); iCont++)
            sprintf(szhAux,"%s%c",szhAux,szhCadenaAux1[iCont]);
        sprintf(szhAux,"%s%c",szhAux,'\0');
        strcpy(szhCadenaAux1,szhAux);
    }
    szCadenaCreateIndex[0]='\0';
    sprintf(szCadenaCreateIndex,"%s\0",szhCadenaResultado);

    if ((fp_tmp = fopen (szArchivoTmp,"w"))==NULL)
    {
        vDTrazasError(szExeLoadTarif,"\n\t** ERROR No puede generar archivo %s \n", LOG01,szArchivoTmp);
        return FALSE;
    }

    fprintf(fp_tmp,"%s",szCadenaCreateIndex);
    fflush(fp_tmp);
    fclose(fp_tmp);
    
    lLargoCadenaCreateIndex = strlen(szhCadenaResultado);
    vDTrazasLog(szExeLoadTarif,"\n\t** Obtiene Correctamente Sentencias para Crear indice \n\t[%s]"
                              , LOG03
                              , szCadenaCreateIndex);


    vDTrazasLog(szExeLoadTarif,   "\n\t**TABLA [%s]\n", LOG03,szhTabla);
    /* EXEC SQL EXECUTE
      BEGIN
        FA_UTILFAC_PG.FA_DESECHA_INDICES_PR(:ihIndTasacion);
      END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin FA_UTILFAC_PG . FA_DESECHA_INDICES_PR ( :ihIndTasac\
ion ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )371;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndTasacion;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLINDEXNOEXIST )
    {
       fprintf(stderr,"\n\t** ERROR el ELIMINAR indices de %s %d %s\n",szhTabla,SQLCODE,SQLERRM);
       vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al ELIMINAR indices de %s %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
       vDTrazasError(szExeLoadTarif, "\n\t** ERROR al ELIMINAR indices de %s %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
       return (FALSE);
    }
    return (TRUE);
}

/****************************************************************************/
/*   funcion BOOL bfnDropIndexPF(int ihIndicaTasacion)                                      */
/****************************************************************************/
/*  Elimina Indice PK_PF_TARIFICADAS de tabla PF_TARIFICADAS                */
/****************************************************************************/

BOOL bfnCreateIndexPF(int iIndTasacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCadenaCreateIndex[4096];
    char    szhCadenaResultado[4096];
    int     ihIndTasacion;
    /* EXEC SQL END DECLARE SECTION; */ 

    char  szCadenaAux1[8192];
    char  szCadenaAux2[8192];

    FILE *fp_tmp;
    char szArchivoTmp[1024];
    int  iCont;
    int  iPos;

    ihIndTasacion = iIndTasacion;

    if(NoExistenProcesosActuales())
    {
        szArchivoTmp[0]='\0';
        szCadenaCreateIndex[0]='\0';
        sprintf(szArchivoTmp,"%s%c%s",(char *)getenv("XPF_TMP"),'/',"loadtarif.tmp");        
        if ((fp_tmp = fopen (szArchivoTmp,"r"))==NULL)
        {
            vDTrazasError(szExeLoadTarif,"\n\t** ERROR No puede abrir archivo %s \n", LOG01,szArchivoTmp);
            return (FALSE);
        }
        /* fscanf(fp_tmp,"%s",szCadenaCreateIndex); */
        fgets(szCadenaCreateIndex,4096,fp_tmp);
        fclose(fp_tmp);
    }
    else
    {
       vDTrazasLog(szExeLoadTarif,  "\n\t** No crea indices. Aun existen procesos ejecutandose",LOG03);
       vDTrazasLog(szExeLoadTarif,  "\n\t** Ultimo proceso loadtarif creara indices\n",LOG03);
       return(TRUE);
    }

    sprintf(szCadenaAux1,"%.*s",strlen(szCadenaCreateIndex),szCadenaCreateIndex);

    iPos=0;
    while (strlen(szCadenaAux1) > 0)
    {
        for (iCont=0;iCont < strlen(szCadenaAux1); iCont++)
            if (szCadenaAux1[iCont] == ':')
            {
                iPos=iCont;
                break;
            }
        sprintf(szhCadenaCreateIndex,"%*.*s",1,iPos,szCadenaAux1);
        vDTrazasLog(szExeLoadTarif,"\n\t** Creación [%s]\n", LOG03, szhCadenaCreateIndex);

        /* EXEC SQL EXECUTE
           BEGIN
             FA_UTILFAC_PG.FA_EJECUTA_DML_PR(:szhCadenaCreateIndex);
           END;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin FA_UTILFAC_PG . FA_EJECUTA_DML_PR ( :szhCadenaC\
reateIndex ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )390;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaCreateIndex;
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



        if (SQLCODE != SQLOK && SQLCODE != SQLINDEXEXIST )
        {
            vDTrazasLog(szExeLoadTarif,  "\n\t** ERROR al Ejecutar [%s] %d %s\n",LOG01,szhCadenaCreateIndex,SQLCODE,SQLERRM);
            vDTrazasError(szExeLoadTarif,"\n\t** ERROR al Ejecutar [%s] %d %s\n",LOG01,szhCadenaCreateIndex,SQLCODE,SQLERRM);
            return (FALSE);
        }
        szCadenaAux2[0]='\0';
        for (iCont=iPos+1;iCont < strlen(szCadenaAux1); iCont++)
            sprintf(szCadenaAux2,"%s%c",szCadenaAux2,szCadenaAux1[iCont]);
        sprintf(szCadenaAux2,"%s%c",szCadenaAux2,'\0');
        sprintf(szCadenaAux1,szCadenaAux2);
    }
    return (TRUE);    
}



/* SAAM-20041019 nueva funcion segun HD-200403100356, P-MAS-04042 */
BOOL vfnCreaQuerysDinamicos(int iDigito, int itipo_tasacion)
{
    
    vDTrazasLog(szExeLoadTarif, " \n\t\t\t   PREPARE   sql_insert_tarificadas "
                                " \n\t\t\t    Digito        [%d]       " 
                                " \n\t\t\t    Tipo Tasacion [%d]       " /* SAAM-200212202 Se incluye */
                                " \n\t\t\t------------------------------------", 
                                LOG05,iDigito,itipo_tasacion); /*  SAAM-200212202 Se cambia log */
    
   
    /* EXEC SQL PREPARE sql_insert_tarificadas FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )409;
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
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Insert  **"
                                        "\n\t\t=> Digito        [%d] " 
                                        "\n\t\t=> Tipo Tasacion [%d] " /* SAAM-200212202 Se incluye */
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,iDigito,itipo_tasacion,SQLCODE,SQLERRM,szCadenaInsert);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Insert  **"
                                        "\n\t\t=> Digito        [%d] " 
                                        "\n\t\t=> Tipo Tasacion [%d] " /* SAAM-200212202 Se incluye */
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,iDigito,itipo_tasacion,SQLCODE,SQLERRM,szCadenaInsert);
        return (FALSE);
    }


    vDTrazasLog(szExeLoadTarif, " \n\t\t\t   PREPARE   sql_delete_tarificadas "
                                " \n\t\t\t    Digito        [%d]       " 
                                " \n\t\t\t    Tipo Tasacion [%d]       " /* SAAM-200212202 Se incluye */
                                " \n\t\t\t------------------------------------", 
                                LOG05,iDigito,itipo_tasacion); 

    /* EXEC SQL PREPARE sql_delete_tarificadas FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )428;
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


   
    if(SQLCODE) 
    {
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Delete  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] " /* SAAM-200212202 Se incluye */
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,iDigito,itipo_tasacion,SQLCODE,SQLERRM,szCadenaDelete);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE Delete  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] " /* SAAM-200212202 Se incluye */
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,iDigito,itipo_tasacion,SQLCODE,SQLERRM,szCadenaDelete);
        return (FALSE);
    }
    return (TRUE);
}

int vfnRecuperaMaxMin(int ihDigitoCli, int ihCodTipoTar, long lCodCiclo, long lCodCiclFact, long *lMinCodCliente, long *lMaxCodCliente)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhMinCodCliente        ;
    long lhMaxCodCliente        ;
    long lhCodCiclo             ;
    long lhCodCiclFact          ;
    /* EXEC SQL END DECLARE SECTION; */ 

        
        lhCodCiclo=lCodCiclo;
        lhCodCiclFact=lCodCiclFact;
        
    /* EXEC SQL PREPARE sql_maxmin_tarificadas FROM :szCadenaMaxMin; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )447;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaMaxMin;
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


    
    if(SQLCODE)
    {
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-PREPARE MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
        return (FALSE);
    }
                                         
    /* EXEC SQL DECLARE CursorMaxMin CURSOR FOR sql_maxmin_tarificadas; */ 

        
    if( SQLCODE )
    {
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en SQL-DECLARE Cursor MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en SQL-DECLARE Cursor MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "                                
                                        "\n\t\t=> Tipo Tasacion [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,ihDigitoCli,ihCodTipoTar,SQLCODE,SQLERRM,szCadenaMaxMin);
        return (FALSE);
    }
        
        
    /* EXEC SQL OPEN CursorMaxMin  USING       :lhCodCiclo, :lhCodCiclFact  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )466;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
        vDTrazasLog  (szExeLoadTarif , "<< En OPEN del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeLoadTarif , "<< En OPEN del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
                                                          
                                                          
/* 20040305 TM-200402190525 Se recupera el menor y mayor cliente  */
    
        /* EXEC SQL FETCH CursorMaxMin INTO :lhMinCodCliente, :lhMaxCodCliente ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )489;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhMinCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhMaxCodCliente;
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


        
/*
     EXEC SQL SELECT  MIN(COD_CLIENTE), MAX(COD_CLIENTE)
             INTO :lhMinCodCliente, :lhMaxCodCliente
             FROM    FA_CICLOCLI
             WHERE   COD_CICLO           = :lhCodCiclo
             AND     IND_MASCARA         = 1
             AND     mod(COD_CLIENTE,10) = :ihDigitoCli;
*/
            
    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeLoadTarif,   "\n\t** No Existen Datos en FA_CICLOCLI Para Facturar **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]", LOG01, lhCodCiclo,ihDigitoCli);
        vDTrazasError(szExeLoadTarif,   "\n\t** No Existen Datos en FA_CICLOCLI Para Facturar **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]", LOG01, lhCodCiclo,ihDigitoCli);
        return (TRUE);
    }
        
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en Select sobre FA_CICLOCLI  **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]"
                                        "\n\t\t=> Error Oracle          [%d]"
                                        "\n\t\t=> Error Oracle          [%s]"
                                        ,LOG01,lhCodCiclo,ihDigitoCli,SQLCODE,SQLERRM);
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en Select sobre FA_CICLOCLI  **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]"
                                        "\n\t\t=> Error Oracle          [%d]"
                                        "\n\t\t=> Error Oracle          [%s]"
                                        ,LOG01,lhCodCiclo,ihDigitoCli,SQLCODE,SQLERRM);
        return (FALSE);
    }
        
        
    /* EXEC SQL CLOSE CursorMaxMin ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )512;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        
    if (SQLCODE)
    {
        vDTrazasLog  (szExeLoadTarif , "<< En CLOSE del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeLoadTarif , "<< En CLOSE del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
        
        if(lhMinCodCliente==0 || lhMaxCodCliente==0)
        {
                vDTrazasLog   (szExeLoadTarif, "\n\t*** NO HAY Rangos de codigos de clientes para procesar, TERMINA PROCESO... ***",LOG03);
                vDTrazasError (szExeLoadTarif, "\n\t*** NO HAY Rangos de codigos de clientes para procesar, TERMINA PROCESO... ***",LOG03);
        return (FALSE);
        }

        
    *lMinCodCliente=lhMinCodCliente;
    *lMaxCodCliente=lhMaxCodCliente;
        
        return (TRUE);
}

        
        
BOOL NoExistenProcesosActuales()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int     iCont;
    long    lhCodCiclFact;
    int     iCodProceso;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclFact = stLineaComando.lCodCiclFact;
    iCodProceso = 4000 + stLineaComando.iDigitoCli;

    /* EXEC SQL 
    SELECT count(1)
    INTO :iCont
    FROM FA_TRAZAPROC
    WHERE COD_CICLFACT = :lhCodCiclFact
      AND COD_PROCESO BETWEEN 4000 AND 4009
      AND COD_PROCESO <> :iCodProceso
      AND COD_ESTAPROC = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from FA_TRAZAPROC where (((COD_\
CICLFACT=:b1 and COD_PROCESO between 4000 and 4009) and COD_PROCESO<>:b2) and \
COD_ESTAPROC=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )527;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCont;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodProceso;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en FA_TRAZAPROC [%d:%s] **"
                                        ,LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en FA_TRAZAPROC [%d:%s] **"
                                        ,LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
   if(SQLCODE == SQLNOTFOUND)
       return(TRUE);
   if (iCont>0)
       return(FALSE);
   else
       return(TRUE);

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
