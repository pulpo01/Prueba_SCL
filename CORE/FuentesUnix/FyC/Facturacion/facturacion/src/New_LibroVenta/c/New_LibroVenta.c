
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/New_LibroVenta.pc"
};


static unsigned int sqlctx = 221606371;


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
   unsigned char  *sqhstv[17];
   unsigned long  sqhstl[17];
            int   sqhsts[17];
            short *sqindv[17];
            int   sqinds[17];
   unsigned long  sqharm[17];
   unsigned long  *sqharc[17];
   unsigned short  sqadto[17];
   unsigned short  sqtdso[17];
} sqlstm = {12,17};

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
5,0,0,1,95,0,4,434,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
28,0,0,2,95,0,4,448,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
51,0,0,3,354,0,4,470,0,0,6,2,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,1,5,0,0,1,5,
0,0,
90,0,0,4,0,0,17,812,0,0,1,1,0,1,0,1,97,0,0,
109,0,0,4,0,0,45,830,0,0,0,0,0,1,0,
124,0,0,4,0,0,13,839,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
155,0,0,4,0,0,15,868,0,0,0,0,0,1,0,
170,0,0,5,0,0,17,1035,0,0,1,1,0,1,0,1,97,0,0,
189,0,0,5,0,0,45,1056,0,0,0,0,0,1,0,
204,0,0,5,0,0,13,1108,0,0,17,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
2,3,0,0,2,3,0,0,
287,0,0,5,0,0,15,1234,0,0,0,0,0,1,0,
302,0,0,6,279,0,3,1318,0,0,13,13,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,
369,0,0,7,70,0,4,1398,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
392,0,0,8,0,0,17,1484,0,0,1,1,0,1,0,1,97,0,0,
411,0,0,8,0,0,45,1502,0,0,0,0,0,1,0,
426,0,0,8,0,0,13,1534,0,0,6,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,
97,0,0,
465,0,0,8,0,0,15,1605,0,0,0,0,0,1,0,
480,0,0,9,266,0,3,1656,0,0,7,7,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,
523,0,0,10,295,0,3,1774,0,0,14,14,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,97,0,0,
594,0,0,11,0,0,17,1883,0,0,1,1,0,1,0,1,97,0,0,
613,0,0,11,0,0,21,1892,0,0,0,0,0,1,0,
628,0,0,12,64,0,5,1940,0,0,1,1,0,1,0,1,97,0,0,
647,0,0,13,64,0,5,1945,0,0,1,1,0,1,0,1,97,0,0,
666,0,0,14,350,0,3,1985,0,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
693,0,0,15,91,0,5,2011,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
716,0,0,16,260,0,4,2077,0,0,4,2,0,1,0,2,9,0,0,2,9,0,0,1,5,0,0,1,5,0,0,
747,0,0,17,0,0,17,2161,0,0,1,1,0,1,0,1,97,0,0,
766,0,0,17,0,0,45,2175,0,0,0,0,0,1,0,
781,0,0,17,0,0,13,2310,0,0,15,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,5,0,0,2,5,0,
0,
856,0,0,17,0,0,15,2387,0,0,0,0,0,1,0,
871,0,0,18,184,0,4,2895,0,0,8,2,0,1,0,2,97,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
2,4,0,0,1,3,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : LibroVenta.pc                                           * */
/* *  El libro de ventas                                                * */
/* *  Autor : Guido Antio Cares                                         * */
/* *                                                                    * */
/* ********************************************************************** */
/**************************************************************************** */
/* ************************************************************************** */
/* *	Incorporacion del campo COD_APLIC en las llamadas 		    * */
/* *			a las sgtes. funciones:				    * */
/* *		bfnGetInterFact		bfnUpdInterFact			    * */
/* *	Patricio Gonzalez G.	31-01-2002			            * */
/* ************************************************************************** */
/******************************************************************************/

#define _LIBRO_C_

#include <New_LibroVenta.h>

char     szBuffer[MAX_NUMREGISTROS * MAX_LARGOREGISTRO]="";

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
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

/****************************************************************************/
/*    funcion int main(argc, argv)                                          */
/****************************************************************************/

int main(int argc, char *argv[])
{
	char    modulo      []  ="main";
    char    szFecha     [20]=""  ;   /*  Fecha de Sistema Para Update de Traza   */
    long    lCiclFact      ;
    char    szNomTabla  [20]         ;

    extern  char    *optarg                     ;
            int     iRes                        ;
            int     iOpt                        ;
            char    opt   []        ="u:m:a:d:l:c:n h i " ;
            char    szUsuario [63]  = ""        ;
            char    szFormato [10]  = ""        ;
            char    *psztmp         = ""        ;
            char    szaux     [10]              ;
            char    *szDirLogs                  ;
            char    *szDirDats                  ;
            char    szComando[1024] = ""        ;
            BOOL    bOptUsuario     = FALSE     ;


    memset(&stLineaComando      ,0,sizeof(LINEACOMANDO));
    memset(&stAcumuladorFinal   ,0,sizeof(GACUMULADORFINAL ));
    memset(&stTotTipDocFin      ,0,sizeof(GTOTTIPDOCUMFINAL)*NUM_TIPDOCUM);
    stLineaComando.iTipDoc=0;

    while ( (iOpt = getopt (argc, argv, opt) ) != EOF)
    {
        switch (iOpt)
        {
            case 'u':
                if (strlen (optarg))   {
                    strcpy(szUsuario, optarg);
                    bOptUsuario = TRUE;
                    fprintf (stdout," -u %s ", szUsuario);
                }
                break;
            case 'm' :
                if ( strlen (optarg) ) {
                    stLineaComando.iMes    = atoi (optarg);
                    fprintf (stdout," -m %d ",stLineaComando.iMes);
                }
                break;
            case 'a' :
                if ( strlen (optarg) ) {
                    stLineaComando.iAno    = atoi (optarg);
                    fprintf (stdout," -a %d ",stLineaComando.iAno);
                }
                break;
            case 'd' :
                if ( strlen (optarg) ) {
                    stLineaComando.iTipDoc    = atoi (optarg);
                    fprintf (stdout," -d %d ",stLineaComando.iTipDoc);
                }
                break;
            case 'l':
                if (strlen (optarg))   {
                    stStatus.LogNivel =
                    (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                }
                break;
            case 'c':
                if (strlen (optarg))   {
                    sprintf(stLineaComando.szTabla,"%d",atoi(optarg));
                    fprintf (stdout," -c %s ",stLineaComando.szTabla);
                }
                break;
            case 'n':
                    sprintf(stLineaComando.szTabla,"%s",NOCICLO);
                    fprintf (stdout," -n %s ",stLineaComando.szTabla);
                    break;
            case 'h':
                    sprintf(stLineaComando.szTabla,"%s",HISTDOCU);
                    fprintf (stdout," -h %s ",stLineaComando.szTabla);
                    break;
            case 'i':
                    stLineaComando.bImprime = TRUE;
                    fprintf (stdout," -i IMPRIME\n ");
                    break;
           }
    }


    if ((strcmp(stLineaComando.szTabla,NOCICLO)==0)
     || (strcmp(stLineaComando.szTabla,HISTDOCU)==0)
     || (stLineaComando.bImprime == TRUE))
    {
        if (stLineaComando.iMes < 1    ||  stLineaComando.iMes > 12  ||
            stLineaComando.iAno < 1998 ||  stLineaComando.iAno > 2002 )
        {
            fprintf (stderr, "\n\t=> Parametros Incorrectos (mes/ano) %s\n", szUsage);
            return  (1);
        }
    }

    if ((strcmp(stLineaComando.szTabla,NOCICLO)==0) && (stLineaComando.iTipDoc == 0)) {
            fprintf (stderr, "\n\t=> Debe Ingresar Tipo de Documento.\n\n", szUsage);
            return  (1);
    }

    if ( (stLineaComando.bImprime == TRUE) && (strlen(stLineaComando.szTabla)>0) ) {
            fprintf (stderr, "\n\t=> Debe Ingresar solo una Opcion \n"
                    "\t   Tipo de Tabla a Cargar [-c,-n,-h]  o  Impresion [-i] )\n\n", szUsage);
            return  (1);
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

    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n");
        return (1);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------"
                ,stLineaComando.szUser);
    }


    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;

    /**************************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    if ((strcmp(stLineaComando.szTabla,NOCICLO)!=0) && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0) && (strlen(stLineaComando.szTabla)>4)) {
        sprintf(stLineaComando.szDirLogs,"%s/New_LibroVenta/Ciclo/%s/",
                szDirLogs,stLineaComando.szTabla);
    } else {
        sprintf(stLineaComando.szDirLogs,"%s/New_LibroVenta/%04d%02d/",
                szDirLogs,stLineaComando.iAno,stLineaComando.iMes);
    }

    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName, "%sNew_LibroVenta_%04d%02d_%s.err",
            stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.ErrName);

    if( (stStatus.ErrFile = (FILE *)fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero de error %s\n", stStatus.ErrName);
        return (4);
    }
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%sNew_LibroVenta_%04d%02d_%s.log",
            stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.LogName);

    if ((stStatus.LogFile = (FILE *)fopen(stStatus.LogName,"a")) == (FILE*)NULL)
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero de log %s\n", stStatus.LogName);
        return (5);
    }
    /*********************************************************************************************/

    if (stLineaComando.bImprime) {
        szDirDats=(char *)malloc(1024);
        if ((szDirDats = szGetEnv("XPFACTUR_DAT")) == (char *)NULL)
            return (FALSE);
        /**************************************************************************************/
        sprintf(stLineaComando.szDirDats,"%s/New_LibroVenta/%04d%02d/",
                szDirDats,stLineaComando.iAno,stLineaComando.iMes);

        sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirDats);

        if (system (szComando))
        {
            printf( "\n\t***   Fallo mkdir de Directorio Datos : %s \n",szComando);
            return (FALSE);
        }
        /*********************************************************************************************/

        sprintf(stLineaComando.szFileDat,"%sNew_LibroVenta_%04d%02d_%s.dat",
                stLineaComando.szDirDats,stLineaComando.iAno,stLineaComando.iMes,
                szSysDate);

        unlink (stLineaComando.szFileDat);

        if (( stLineaComando.fpDat = (FILE *)fopen(stLineaComando.szFileDat,"a")) == (FILE *)NULL)
        {
           vDTrazasError(modulo,"\n\n\tError al abrir el Fichero de Datos ",LOG01);
           return FALSE;
        }
    }
    /*********************************************************************************************/

    vDTrazasLog (modulo,
                 "\n\t*********************************************************"
                 "\n\t*                    LIBRO VTA                          *"
                 "\n\t*                  NIVEL DE LOG  %d                      *"
                 "\n\t*********************************************************"
                 ,LOG03,stLineaComando.iNivLog);
    vDTrazasError(modulo,
                 "\n\t*********************************************************"
                 "\n\t*                    LIBRO VTA                          *"
                 "\n\t*                  NIVEL DE LOG  %d                      *"
                 "\n\t*********************************************************"
                 ,LOG03,stLineaComando.iNivLog);


    if    ((strcmp(stLineaComando.szTabla,NOCICLO)!=0)
        && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
        && (strlen(stLineaComando.szTabla)>4) )
    {
        lCiclFact = atol(stLineaComando.szTabla);
        if (!bfnValidaTrazaProc(lCiclFact, iPROC_LIBROIVA, iIND_FACT_ENPROCESO))   {
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
        bfnSelectTrazaProc (lCiclFact, iPROC_LIBROIVA, &stTrazaProc);
        bPrintTrazaProc(stTrazaProc);
    }

    /* ************************************************************************* */

    if (!bfnOraGenLibro (stLineaComando))
    {
        stTrazaProc.iCodEstaProc       = iPROC_EST_ERR ;
        strcpy(stTrazaProc.szGlsProceso,"Proceso de Libro de Ventas Finalizado con Error") ;
        printf("\n Salida de  Libro Vta con Error \n") ;
    }
    else
    {
        stTrazaProc.iCodEstaProc       = iPROC_EST_OK  ;
        strcpy(stTrazaProc.szGlsProceso,"Proceso de Libro de Ventas Terminado OK") ;
        printf("\n Salida de  Libro Vta Ok \n")        ;
    }


    /* ************************************************************************* */

    if    ((strcmp(stLineaComando.szTabla,NOCICLO)!=0)
        && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
        && (strlen(stLineaComando.szTabla)>4))
    {

        if (!bfnSelectSysDate(szFecha))
        {
            printf("<< Error en Funcion bfnSelectSysDate!!!. >> \n");
            printf("<< No se Actualizo Traza con Ultimo Proceso del Libro de Ventas. >>\n");
        }
        else
        {
            strcpy(stTrazaProc.szFecTermino,szFecha)      ;
            stTrazaProc.lCodCliente        = lConRegFinal ;
            stTrazaProc.lNumAbonado        = 0            ;
            stTrazaProc.lNumRegistros      = 0            ;
            bPrintTrazaProc(stTrazaProc)                  ;
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }
    }

    if(!bfnDisconnectORA(0))
    {
        printf("\n Desconexion de Oracle con Error \n");
    }
    else
    {
        printf("\n Desconexion de Oracle OK\n");
        vDTrazasLog(modulo,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03);
        vDTrazasError(modulo,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03);
    }

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    fclose(stLineaComando.fpDat);

    return(0);
}
/***************************   fin  main    **********************************/


/*****************************************************************************/
/* bfnOraGenLibro(int iMesAux,int iAnoAux)                                   */
/*****************************************************************************/

static BOOL bfnOraGenLibro(LINEACOMANDO stLineaComando)
{
	char modulo[]="bfnOraGenLibro";

     int  iTipDocumento = 0        ;
     char *szFecInicio             ;
     char *szFecFin                ;
     int  iSqlCodeFactLib = SQLOK  ;
     int  iSqlCodeConsumo = SQLOK  ;
     char szNomTabla   [20]        ;
     int  iMesAux                  ;
     int  iAnoAux                  ;
     int  iConReg = 0              ;
     int  iDoc = 0                 ;
     char szCod_Oficina [3]        ;
     BOOL OptInsert                ;
     BOOL BFlagOficina             ;

    GHISTDOCU stGHistDocu          ;

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char    szhNomRepLegal[132] ;  /* EXEC SQL VAR szhNomRepLegal  IS STRING (132); */ 

        char    szhRutRepLegal[22]  ;  /* EXEC SQL VAR szhRutRepLegal  IS STRING (22); */ 

	    char    szhFecInicio [9]    ;  /* EXEC SQL VAR szhFecInicio    IS STRING (9); */ 

	    char    szhFecFin    [9]    ;  /* EXEC SQL VAR szhFecFin       IS STRING (9); */ 

		long    lhBoletasAmistar    = 0;
        long    lhNetoAmistar       = 0;
        long    lhIvaAmistar        = 0;
        long    lhTotalAmistar      = 0;
        int     ihNomRepLegal       ;
        int     ihRutRepLegal       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 



    iMesAux = stLineaComando.iMes;
    iAnoAux = stLineaComando.iAno;
    strcpy(szNomTabla,stLineaComando.szTabla);

    vDTrazasLog ( modulo,"\n\tParametros de Entrada"
                         "\n\t\t==>  Mes Actual [%02d]"
                         "\n\t\t==>  Ano Actual [%04d]"
                         "\n\t\t==>  Tabla      [%s]"
                         ,LOG03,iMesAux,iAnoAux,szNomTabla);


    szFecInicio = (char *) malloc(8);
    szFecFin    = (char *) malloc(8);
    sprintf(szFecInicio ,"01%02d%04d", iMesAux, iAnoAux );
    sprintf(szFecFin    ,"01%02d%04d", ((iMesAux != 12) ? iMesAux+1 : 1) ,((iMesAux != 12) ? iAnoAux : iAnoAux+1));

	strcpy(szhFecInicio,szFecInicio);
	strcpy(szhFecFin,szFecFin);

    vDTrazasLog ( modulo,"\n\tParametros Calculados"
                         "\n\t\t==>  szFecInicio [%s]"
                         "\n\t\t==>  szFecFinal  [%s]"
                         ,LOG03,szhFecInicio,szhFecFin );



    /****************************************************************/
    /*  Rescata Informacion del Representante Legal de la Empresa   */
    /****************************************************************/
    ihNomRepLegal   = FAD_NOM_REP_LEGAL;
    ihRutRepLegal   = FAD_RUT_REP_LEGAL;

    vDTrazasLog ( modulo,"\n\tFAD_NOM_REP_LEGAL [%d]",LOG06,FAD_RUT_REP_LEGAL);
    vDTrazasLog ( modulo,"\n\tFAD_RUT_REP_LEGAL [%d]",LOG06,FAD_RUT_REP_LEGAL);
    vDTrazasLog ( modulo,"\n\tSelecciona Nombre del Representante Legal",LOG04);
    /* EXEC SQL
        SELECT  VAL_CARACTER
        INTO    :szhNomRepLegal
        FROM    FAD_PARAMETROS
        WHERE   COD_PARAMETRO = :ihNomRepLegal
        AND     COD_MODULO = 'FA'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_CARACTER into :b0  from FAD_PARAMETROS where (\
COD_PARAMETRO=:b1 and COD_MODULO='FA')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomRepLegal;
    sqlstm.sqhstl[0] = (unsigned long )132;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNomRepLegal;
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
	    vDTrazasLog   ( modulo,"Al seleccionar Nom.Rep.Legal desde FAD_PARAMETROS\n\tDetalle : %s" ,LOG01,SQLERRM);
	    vDTrazasError ( modulo,"Al seleccionar Nom.Rep.Legal desde FAD_PARAMETROS\n\tDetalle : %s" ,LOG01,SQLERRM);
		return (FALSE);
	}

    vDTrazasLog ( modulo,"\n\tSelecciona Rut del Representante Legal",LOG04);
    /* EXEC SQL
        SELECT  VAL_CARACTER
        INTO    :szhRutRepLegal
        FROM    FAD_PARAMETROS
        WHERE   COD_PARAMETRO = :ihRutRepLegal
        AND     COD_MODULO = 'FA'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_CARACTER into :b0  from FAD_PARAMETROS where (\
COD_PARAMETRO=:b1 and COD_MODULO='FA')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )28;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRutRepLegal;
    sqlstm.sqhstl[0] = (unsigned long )22;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihRutRepLegal;
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
	    vDTrazasLog   ( modulo,"Al seleccionar Rut Rep.Legal desde FAD_PARAMETROS\n\tDetalle : %s" ,LOG01,SQLERRM);
	    vDTrazasError ( modulo,"Al seleccionar Rut Rep.Legal desde FAD_PARAMETROS\n\tDetalle : %s" ,LOG01,SQLERRM);
		return (FALSE);
	}
	strcpy(szNomRepLegal, szhNomRepLegal);
    strcpy(szRutRepLegal, szhRutRepLegal);

    if (strlen(szNomTabla)>0) 
    {
        if ( (strcmp(szNomTabla,NOCICLO)==0) || (strcmp(szNomTabla,HISTDOCU)==0) ) {

            /****************************************************************/
            /* Comienza a Procesar aqui las boletas Amistar                 */
            /****************************************************************/
            /* EXEC SQL SELECT count(*) cantidad,
        					NVL(round(round (sum(nvl(PRC_TOTAL,0)))/1.18),0) neto ,
        					NVL(round(sum(nvl(PRC_TOTAL,0)))-round(round (sum(nvl(PRC_TOTAL,0)))/1.18),0) iva ,
        					NVL(round (sum(nvl(PRC_TOTAL,0))),0) total
                       INTO :lhBoletasAmistar,
                            :lhNetoAmistar,
                            :lhIvaAmistar,
                            :lhTotalAmistar
                       FROM AL_HCAB_BOLETA
                      WHERE NUM_BOLETA > 0
                        AND FEC_BOLETA >= TO_DATE(:szhFecInicio,'DDMMYYYY')
                        AND FEC_BOLETA < TO_DATE(:szhFecFin,'DDMMYYYY') ; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 6;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select count(*)  cantidad ,NVL(round((round(sum(n\
vl(PRC_TOTAL,0)))/1.18)),0) neto ,NVL((round(sum(nvl(PRC_TOTAL,0)))-round((rou\
nd(sum(nvl(PRC_TOTAL,0)))/1.18))),0) iva ,NVL(round(sum(nvl(PRC_TOTAL,0))),0) \
total into :b0,:b1,:b2,:b3  from AL_HCAB_BOLETA where ((NUM_BOLETA>0 and FEC_B\
OLETA>=TO_DATE(:b4,'DDMMYYYY')) and FEC_BOLETA<TO_DATE(:b5,'DDMMYYYY'))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )51;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhBoletasAmistar;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhNetoAmistar;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhIvaAmistar;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhTotalAmistar;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhFecInicio;
            sqlstm.sqhstl[4] = (unsigned long )9;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhFecFin;
            sqlstm.sqhstl[5] = (unsigned long )9;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
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



        	if (SQLCODE) {
        	    vDTrazasLog   ( modulo,"\tAl seleccionar datos desde AL_HCAB_BOLETA\n\t %s" ,LOG01,SQLERRM);
        	    vDTrazasError ( modulo,"\tAl seleccionar datos desde AL_HCAB_BOLETA\n\t %s" ,LOG01,SQLERRM);
        		return (FALSE);
        	}

        	stAcumuladorFinal.lNumBoletaAmis    = lhBoletasAmistar  ;
        	stAcumuladorFinal.dExentoBoletaAmis = 0			        ;
        	stAcumuladorFinal.dNetoBoletaAmis   = lhNetoAmistar     ;
        	stAcumuladorFinal.dIvaBoletaAmis    = lhIvaAmistar      ;
        	stAcumuladorFinal.dTotalBoletaAmis  = lhTotalAmistar    ;

            /* Termina de Procesar aqui las boletas Amistar */  /* marca */

        }


        /************************************************************************/
        /*  iDoc 1 : Procesa Facturas Emitidas en el periodo                    */
        /*  iDoc 2 : Procesa Facturas Exentas Emitidas en el periodo            */
        /*  iDoc 3 : Procesa Notas de Credito Emitidas en el periodo            */
        /*  iDoc 4 : Procesa Boletas Emitidas en el periodo                     */
        /*  iDoc 5 : Procesa Boletas Exentas Emitidas en el periodo             */
        /************************************************************************/
        if ( strcmp(szNomTabla,HISTDOCU)==0 ) {

            vDTrazasLog ( modulo,"\n\t\t**Validacion de Documentos**"
                             "\n\t\t Nombre de Tabla : [%s]",LOG04,szNomTabla);

            for (iDoc=1; iDoc<6;iDoc++)
            {
        	    iSqlCodeFactLib = ifnOpenDocumentos(iDoc,szFecInicio,szFecFin,stLineaComando);

        	    while ( iSqlCodeFactLib == SQLOK )  {
          	        memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
        	        iSqlCodeFactLib = ifnFetchDocumentos(iDoc,&stGHistDocu,stLineaComando);

        	        if (iSqlCodeFactLib == SQLOK) 
        	        {
                        BFlagOficina = FALSE;
                        if (strcmp(stGHistDocu.szCod_Oficina," ")!=0) {
                            if ((stGHistDocu.iInd_Supertel==0) && (stGHistDocu.iInd_Factur==1)) {
                                OptInsert = TRUE;
                                if (!bfnInsertaLibroIva(stGHistDocu,&OptInsert,HISTO))
                                    return FALSE;
                                BFlagOficina = TRUE;
                                lConRegFinal++;
                            }
                        }

                        if (!bfnUpdateIndLibro(szNomTabla,stGHistDocu,OptInsert,BFlagOficina))
                            return FALSE;

                        iConReg++;
                        if (iConReg == MAXREG_COMMIT) {
                            if (!bfnOraCommit())    {
                                vDTrazasLog  (szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
                                vDTrazasError(szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
                                return FALSE;
                            }
                            iConReg = 0;
                        }

        	        }
        	    }

        		if (iSqlCodeFactLib != SQLNOTFOUND ) return (FALSE);

            	if (!bfnCloseDocumentos())
                	return (FALSE);


                if (!bfnConsumos(iDoc, szFecInicio, szFecFin))
                   return FALSE;

        	}
        } 
        else 
        {
            iSqlCodeFactLib = ifnOpenDocumentos(0,szFecInicio,szFecFin,stLineaComando);

            while ( iSqlCodeFactLib == SQLOK ) 
            {
          	    memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
        	    iSqlCodeFactLib = ifnFetchDocumentos(0,&stGHistDocu,stLineaComando);

        	    if (iSqlCodeFactLib == SQLOK) 
        	    {
                    if (strcmp(stLineaComando.szTabla,NOCICLO)==0) /* obtiene registro de la interfaz */
                    {
                        memset(&stInterFact,0,sizeof(INTERFACT));
                        stInterFact.lNumProceso     = stGHistDocu.lNumProceso;
                        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
                        
                        if (!bfnGetInterFact(&stInterFact))
                        {
                            vDTrazasError(modulo,"Error obtencion de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            vDTrazasLog  (modulo,"Error obtencion de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            return FALSE;
                        }
                        /* stInterFact.iCodEstaDoc     =   stIntQueueProc.iCodEstaDocSal; */
                        stInterFact.iCodEstaProc    =   iESTAPROC_PROCESANDO;
                        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
                        
                        if (!bfnUpdInterFact(stInterFact))
                        {
                            vDTrazasError(szExeName,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            vDTrazasLog  (szExeName,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            return FALSE;
                        }
                        else
                        {
                            if (!bfnOraCommit())
                            {
                                vDTrazasLog  (szExeName,"Error en Commit de marca de FA_INTERFACT [%ld] [%s] " ,LOG03,SQLCODE,SQLERRM);
                                vDTrazasError(szExeName,"Error en Commit de marca de FA_INTERFACT [%ld] [%s]"  ,LOG01,SQLCODE,SQLERRM);
                                return FALSE;
                            }
                        }
                    }

                    BFlagOficina = FALSE;
                    if (strcmp(stGHistDocu.szCod_Oficina," ")!=0) 
                    {
                        if ((stGHistDocu.iInd_Supertel==0) && (stGHistDocu.iInd_Factur==1)) 
                        {
                            OptInsert = TRUE;
                            if (strcmp(stLineaComando.szTabla,NOCICLO)==0) 
                            {
                                if (!bfnInsertaLibroIva(stGHistDocu,&OptInsert,NOCIC))
                                {
                                    /* marca el registro con error en la interfaz */
                                    /* stInterFact.iCodEstaDoc     =   stIntQueueProc.iCodEstaDocSal; */
                                    stInterFact.iCodEstaProc    =   iESTAPROC_TERMINADO_ERROR;      
                                    strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
                                    
                                    if (!bfnUpdInterFact(stInterFact))
                                    {
                                        vDTrazasError(modulo,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                                        vDTrazasLog  (modulo,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                                    }
                                    return FALSE;
                                }
                            } 
                            else 
                            {
                                if (!bfnInsertaLibroIva(stGHistDocu,&OptInsert,CICLO))
                                        return FALSE;
                            }
                            lConRegFinal++;
                            BFlagOficina = TRUE;
                        }
                    }
                    if (!bfnUpdateIndLibro(szNomTabla,stGHistDocu,OptInsert,BFlagOficina))
                            return FALSE;

                    if (strcmp(stLineaComando.szTabla,NOCICLO)==0) /* marca el registro de la interfaz OK */
                    {
                        /* stInterFact.iCodEstaDoc     =   stIntQueueProc.iCodEstaDocSal;*/
                        stInterFact.iCodEstaProc    =   iESTAPROC_TERMINADO_OK;
                        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 31-01-2002 */
                        
                        if (!bfnUpdInterFact(stInterFact))
                        {
                            vDTrazasError(modulo,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            vDTrazasLog  (modulo,"Error en marca de FA_INTERFACT [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
                            return FALSE;
                        }
                    }

                    iConReg++;
                    if (iConReg == MAXREG_COMMIT)
                    {
                        if (!bfnOraCommit())    
                        {
                            vDTrazasLog  (szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA con Tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
                            vDTrazasError(szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA con Tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
                            return FALSE;
                        }
                        iConReg = 0;
                    }
           	    }
        	}

        	if (iSqlCodeFactLib != SQLNOTFOUND )
        	    return (FALSE);

            if (!bfnCloseDocumentos())
                return (FALSE);

            if (strcmp(stLineaComando.szTabla,NOCICLO)==0) 
            {
                vDTrazasLog ( modulo,"\n\tNo es Ciclo. Se Procesa Al_Consumos_Documentos",LOG04);
                for (iDoc=1; iDoc<6;iDoc++) 
                {
                    if (!bfnConsumos(iDoc, szFecInicio, szFecFin))  
                    {
                        return FALSE;
                    }
                }
            }
        }
    }

    if (lConRegFinal > 0){
        if (!bfnOraCommit())    {
            vDTrazasLog  (szExeName,"\n\n\tError en Commit Final de (Insert de FAT_DETLIBROIVA con tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
            vDTrazasError(szExeName,"\n\n\tError en Commit Final de (Insert de FAT_DETLIBROIVA con tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
            return FALSE;
        }
        vDTrazasLog  (szExeName,"\n\t\tCOMMIT FINAL.  [%ld] Registros Procesados. ",LOG03,lConRegFinal);
    }

/***************************************************************************************/
/**** IMPRESION DEL LIBRO DE VENTAS ****************************************************/
/***************************************************************************************/

    if (stLineaComando.bImprime) {
        vDTrazasLog  (szExeName,"\n\t************ Funciones de Impresion  ***********",LOG03);
        if (!bfnLlenaArchivoImpresion(szFecInicio,szFecFin))
             return FALSE;
    }

    vDTrazasLog  (szExeName,"\n\n\tTermino Ok Funcion OraGenLibro",LOG03);
    return TRUE;
}/************************   Final bfnOraGenLibro  **************************/


/****************************************************************************/
/*                         funcion : bfnConsumos                            */
/****************************************************************************/
static BOOL bfnConsumos(int iDoc, char *szFecInicio, char *szFecFin)
{
char modulo[]="bfnConsumos";
int  iTipDocumento = 0        ;
int  iSqlCodeConsumo = SQLOK  ;
int  iConReg = 0              ;
BOOL OptInsert                ;
GHISTDOCU stGHistDocu         ;

    vDTrazasLog ( modulo,"\n\t\tFuncion Procesa Al_Consumos_Documentos",LOG04);
    iSqlCodeConsumo = ifnOpenConsumos(iDoc,szFecInicio,szFecFin);
    while ( iSqlCodeConsumo == SQLOK )  {
        memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
        iSqlCodeConsumo = ifnFetchConsumos(iDoc,&stGHistDocu);

        if (iSqlCodeConsumo == SQLOK)  {
            iConReg++;
            OptInsert = TRUE;
            if (!bfnInsertaConsumosenLibroIva(stGHistDocu,&OptInsert))
                return FALSE;

            /*if (OptInsert && !bfnUpdateIndConsumosLibroIva(stGHistDocu))*/
            if (!bfnUpdateIndConsumosLibroIva(stGHistDocu, OptInsert))
                return FALSE;

            if (iConReg == MAXREG_COMMIT){
                if (!bfnOraCommit())    {
                    vDTrazasLog  (szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA ) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
                    vDTrazasError(szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA ) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
                    return FALSE;
                }
                iConReg = 0;
            }
            lConRegFinal++;
        }
    }

	if (iSqlCodeConsumo != SQLNOTFOUND ) return (FALSE);
	if (!bfnCloseConsumos())
    	return FALSE;

    return TRUE;
} /************************   Final bfnConsumos  **************************/


/****************************************************************************/
/*                         funcion : bfnGetHistClie                         */
/****************************************************************************/
static BOOL bfnGetHistClie(GHISTCLIE *pstGHistClie, LINEACOMANDO stLineaComando)
{

/* EXEC SQL BEGIN DECLARE SECTION; */ 

char    szhNomCliente    [91];  /* EXEC SQL VAR szhNomCliente IS STRING (91); */ 

char    szhApellido1     [21];  /* EXEC SQL VAR szhApellido1  IS STRING (21); */ 

char    szhApellido2     [21];  /* EXEC SQL VAR szhApellido2  IS STRING (21); */ 

char    szhRut           [12];  /* EXEC SQL VAR szhRut        IS STRING (12); */ 

/* EXEC SQL END DECLARE SECTION ; */ 


static  ENLACEHIST   stEnlaceHist;
char    Sql_Query   [256]        ;
char    szNombreCompleto [140]   ;
int     iLargoNombre             ;
char    szNomTabla  [20]         ;

    vDTrazasLog ( szExeLibro , "\n\t*** Entrada a bfnGetHistClie() ***"
                                "\n\t\t ==> Ind_OrdenTotal  [%ld]"
                                "\n\t\t ==> Cod_CiclFact    [%ld]"
                                ,LOG05,pstGHistClie->lIndOrdenTotal,pstGHistClie->lCodCiclFact);

    strcpy(szNomTabla,stLineaComando.szTabla);


    if (strcmp(szNomTabla,HISTDOCU)==0)  {
        memset(&stEnlaceHist,0,sizeof(ENLACEHIST));
        stEnlaceHist.lCodCiclFact = pstGHistClie->lCodCiclFact;
        if (!bGetEnlaceHist(&stEnlaceHist))
            return FALSE;
    }


    memset(&Sql_Query,0,sizeof(Sql_Query));

    sprintf(Sql_Query, "SELECT  nvl(NOM_CLIENTE,' '),\n");
    sprintf(Sql_Query, "%s\t    nvl(NOM_APECLIEN1,' '),\n",Sql_Query);
    sprintf(Sql_Query, "%s\t    nvl(NOM_APECLIEN2,' '),\n",Sql_Query);
    sprintf(Sql_Query, "%s\t    nvl(NUM_IDENTTRIB,' ')\n",Sql_Query);

    if (strcmp(szNomTabla,HISTDOCU)==0)
        sprintf(Sql_Query, "%s\tFROM   %s \n",Sql_Query,stEnlaceHist.szDetCliente);
    else if (strcmp(szNomTabla,NOCICLO)==0)
        sprintf(Sql_Query, "%s\tFROM  FA_FACTCLIE_NOCICLO  \n",Sql_Query);
    else
        sprintf(Sql_Query, "%s\tFROM  FA_FACTCLIE_%s \n",Sql_Query,szNomTabla);

    sprintf(Sql_Query, "%s\tWHERE  IND_ORDENTOTAL = %ld",Sql_Query,pstGHistClie->lIndOrdenTotal);

    vDTrazasLog ( szExeLibro , "\n\t*** Query ***\n\t[%s]\n",LOG06,Sql_Query);

    /* EXEC SQL PREPARE sql_Facturas_Libro FROM :Sql_Query; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )90;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)Sql_Query;
    sqlstm.sqhstl[0] = (unsigned long )256;
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


    if (SQLCODE)  {
        vDTrazasLog  (szExeLibro,"\n\t**  Error en SQL-PREPARE sql_Facturas_Libro **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeLibro,"\n\t**  Error en SQL-PREPARE sql_Facturas_Libro **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL DECLARE Cur_FacturLibro CURSOR FOR sql_Facturas_Libro; */ 

    if (SQLCODE)  {
        vDTrazasLog  (szExeLibro,"\n\t**  Error en SQL-DECLARE Cur_FacturLibro  **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeLibro,"\n\t**  Error en SQL-DECLARE Cur_FacturLibro  **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN Cur_FacturLibro ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )109;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)   {
        vDTrazasLog  (szExeLibro,"\n\t**  Error en SQL-OPEN CURSOR Cur_FacturLibro **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeLibro,"\n\t**  Error en SQL-OPEN CURSOR Cur_FacturLibro **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH Cur_FacturLibro INTO
                :szhNomCliente    ,
                :szhApellido1     ,
                :szhApellido2     ,
                :szhRut           ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )124;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomCliente;
    sqlstm.sqhstl[0] = (unsigned long )91;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhApellido1;
    sqlstm.sqhstl[1] = (unsigned long )21;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhApellido2;
    sqlstm.sqhstl[2] = (unsigned long )21;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhRut;
    sqlstm.sqhstl[3] = (unsigned long )12;
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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
        vDTrazasLog  (szExeLibro,  "\n\t**  Error en FETCH sobre CURSOR Cur_FacturLibro  [%s] **",LOG01,SQLERRM);
        vDTrazasError(szExeLibro,  "\n\t**  Error en FETCH sobre CURSOR Cur_FacturLibro  [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        sprintf(szNombreCompleto, "%*.*s %*.*s %*.*s\0", strlen(szhNomCliente), strlen(szhNomCliente), szhNomCliente,
                                                         strlen(szhApellido1),  strlen(szhApellido1),  szhApellido1,
                                                         strlen(szhApellido2),  strlen(szhApellido2),  szhApellido2);
        iLargoNombre = strlen(szNombreCompleto);
        if (iLargoNombre  > 60)     szNombreCompleto[59] = '\0';



        strncpy(pstGHistClie->szNomCliente   ,szNombreCompleto,60                      );
        strncpy(pstGHistClie->szRut          ,szhRut          ,strlen(szhRut)          );

        vDTrazasLog ( szExeLibro,"\n\t\tNombre     : [%s]",LOG04,pstGHistClie->szNomCliente);
        vDTrazasLog ( szExeLibro,"\t\tRut        : [%s]",LOG04,pstGHistClie->szRut);

    }

    /* EXEC SQL CLOSE Cur_FacturLibro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )155;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
        return FALSE;


    return (TRUE);

}


/************************************************************************/
/*  Abre cursor OpenDocumentos                                          */
/************************************************************************/
static int ifnOpenDocumentos(int iTipDocumento, char *szFecInicio, char *szFecFin, LINEACOMANDO stLineaComando)
{
char modulo[]="ifnOpenDocumentos";
int bTipDocError=FALSE;
static char szCadenaSQL[2048];
static char szSUBCadena1[500];

/* EXEC SQL BEGIN DECLARE SECTION ; */ 

     char szhNomTabla  [20]    ;
	 int  ihCodTipDocum	       ;
     char szhFecInicio [9]     ;   /* EXEC SQL VAR szhFecInicio IS STRING (9); */ 
   /*  DDMMYYYY  */
     char szhFecFin    [9]     ;   /* EXEC SQL VAR szhFecFin    IS STRING (9); */ 
   /*  DDMMYYYY  */
/* EXEC SQL END DECLARE SECTION   ; */ 



    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   , szFecFin  );
    strcpy(szhNomTabla ,stLineaComando.szTabla);

    vDTrazasLog ( modulo,"\n\t**  Funcion ifnOpenDocumentos  **"
                         "\n\t\t==>  Fecha  Desde  [%s]"
                         "\n\t\t==>  Fecha  Hasta  [%s]"
                         "\n\t\t==>  Nombre Tabla  [%s]"
                         ,LOG03, szFecInicio, szFecFin,szhNomTabla);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));
	memset(szSUBCadena1,0,sizeof(szSUBCadena1));

    /*if ((strcmp(szhNomTabla,NOCICLO)==0) || (strcmp(szhNomTabla,HISTDOCU)==0))  {*/

    if (strcmp(szhNomTabla,NOCICLO)==0)  ihCodTipDocum = stLineaComando.iTipDoc;

    if (strcmp(szhNomTabla,HISTDOCU)==0)  {
    	switch(iTipDocumento) {
    	    case iTipFactura :
    			 ihCodTipDocum = stDatosGener.iCodFactura; /* 28; */
    			 break;
    		case iTipFacturaExen :
    			 ihCodTipDocum =  stDatosGener.iCodFacturaExen; /* 47;*/
    			 break;
    		case iTipNotaCred :
    			 ihCodTipDocum = stDatosGener.iCodNotaCre;      /*  25  */
    			 break;
    		case iTipBoleta :
    			 ihCodTipDocum =  stDatosGener.iCodBoleta;  /* 45;*/
    			 break;
    		case iTipBoletaExen :
    			 ihCodTipDocum =  stDatosGener.iCodBoletaExen; /* 46; */
    			 break;
    		default :
    			 bTipDocError=TRUE;
    			 break;
    	}
    }

	if (bTipDocError)	{
		vDTrazasError(modulo,"<< Error con el Tipo de Documento :[%d] >>\n\t%s", LOG01, iTipDocumento);
		vDTrazasLog  (modulo,"<< Error con el Tipo de Documento :[%d] >>\n\t%s", LOG01, iTipDocumento);
	    return SQLNOTFOUND;
	}


    sprintf(szCadenaSQL,"%s SELECT H.IND_ANULADA,\n"                                ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s 	   H.IND_ORDENTOTAL ,\n"                            ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.COD_TIPDOCUM ,\n"                              ,szCadenaSQL);
    sprintf(szCadenaSQL,"%s		   nvl(H.COD_CICLFACT,0),\n"                        ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.NUM_FOLIO ,\n"                                 ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(TO_CHAR(H.FEC_EMISION,'DD/MM/YYYY'),' ') ,\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.ACUM_NETONOGRAV,0) ,\n"                    ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.ACUM_NETOGRAV,0) ,\n"                      ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.ACUM_IVA,0) ,\n"                           ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.TOT_FACTURA,0),\n"                         ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.COD_VENDEDOR_AGENTE,0),\n"                 ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   nvl(H.COD_OFICINA,' '),\n"                       ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.IND_SUPERTEL,\n"                               ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.IND_FACTUR,\n"                                 ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.ROWID,\n"                                      ,szCadenaSQL);
	sprintf(szCadenaSQL,"%s		   H.NUM_PROCESO,\n"                                ,szCadenaSQL);


    if (strcmp(szhNomTabla,NOCICLO)==0)    {
    	/*sprintf(szCadenaSQL,"%s		   0\n",szCadenaSQL);*/
        sprintf(szCadenaSQL,"%s		   D.COD_TIPDOCUM\n",szCadenaSQL);
    	sprintf(szCadenaSQL,"%s \tFROM FA_TIPDOCUMEN D, %s H\n",szCadenaSQL,szhNomTabla);
    	sprintf(szCadenaSQL,"%s \tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n",szCadenaSQL);
    	sprintf(szCadenaSQL,"%s \tAND D.COD_TIPDOCUM = %d\n",szCadenaSQL,ihCodTipDocum);
    	sprintf(szCadenaSQL,"%s \tAND H.FEC_EMISION >= TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecInicio);
    	sprintf(szCadenaSQL,"%s \tAND H.FEC_EMISION < TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecFin);
    }
    else if (strcmp(szhNomTabla,HISTDOCU)==0)    {
    	sprintf(szCadenaSQL,"%s		   0\n",szCadenaSQL);
	    sprintf(szCadenaSQL,"%s \tFROM FA_TIPDOCUMEN D, %s H\n",szCadenaSQL,szhNomTabla );
    	sprintf(szCadenaSQL,"%s \tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n",szCadenaSQL);
    	sprintf(szCadenaSQL,"%s \tAND D.COD_TIPDOCUM = %d\n",szCadenaSQL,ihCodTipDocum);
    	sprintf(szCadenaSQL,"%s \tAND H.FEC_EMISION >= TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecInicio);
    	sprintf(szCadenaSQL,"%s \tAND H.FEC_EMISION < TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecFin);
    }
    else {
        sprintf(szCadenaSQL,"%s		   D.COD_TIPDOCUM\n",szCadenaSQL);
	    sprintf(szCadenaSQL,"%s \tFROM FA_TIPDOCUMEN D, FA_FACTDOCU_%s H\n",szCadenaSQL,szhNomTabla);
       	sprintf(szCadenaSQL,"%s \tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n",szCadenaSQL);
    }


	sprintf(szCadenaSQL,"%s \tAND H.IND_ANULADA = 0\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s \tAND H.NUM_FOLIO > 0\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s \tAND H.IND_LIBROIVA = 0\n",szCadenaSQL);
	/*sprintf(szCadenaSQL,"%s \tAND H.COD_OFICINA IS NOT NULL \n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s \tAND H.IND_FACTUR = 1\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s \tAND H.IND_SUPERTEL = 0\n",szCadenaSQL);*/



    /*18-04-2001*/
    vDTrazasLog (modulo,"\t\tihCodTipDocum [%d] stDatosGener.iCodNotaCre [%d]",LOG05,ihCodTipDocum,stDatosGener.iCodNotaCre);
    if (ihCodTipDocum == stDatosGener.iCodNotaCre) {
    	sprintf(szSUBCadena1,"%s \tAND H.TOT_FACTURA >= 0\n",szSUBCadena1);
        vDTrazasLog (modulo,"\t\t<< Es Nota de Credito. Total de Factura puede ser Mayor o igual a 0.>>\n",LOG05);
    } else {
    	sprintf(szSUBCadena1,"%s \tAND H.TOT_FACTURA > 0\n",szSUBCadena1);
        vDTrazasLog (modulo,"\t\t<< No es Nota de Credito. Total de Factura debe ser Mayor a 0.>>\n",LOG05);
    }



    if ((strcmp(szhNomTabla,NOCICLO)==0) || (strcmp(szhNomTabla,HISTDOCU)==0))  {
    	switch(iTipDocumento) {
    		case iTipFactura :
            	strcat(szCadenaSQL,szSUBCadena1);
    			break;
    		case iTipFacturaExen :
            	strcat(szCadenaSQL,szSUBCadena1);
    			break;
    		case iTipNotaCred :
            	strcat(szCadenaSQL,szSUBCadena1);
    			 break;
    		case iTipBoleta :
            	strcat(szCadenaSQL,szSUBCadena1);
    			break;
    		case iTipBoletaExen :
            	strcat(szCadenaSQL,szSUBCadena1);
    			break;
    		case 0 :
            	strcat(szCadenaSQL,szSUBCadena1);
    			break;
    	}
    }


    vDTrazasLog ( modulo,"\n\t** CadenaSQL  para Select en Open Docum.**\n\t%s"
                         ,LOG05, szCadenaSQL);


	/* EXEC SQL PREPARE stConsultaDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )170;
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



	if (SQLCODE) {
		vDTrazasError(modulo,"<< Fallo en 'PREPARE' de la Consulta Dinamica del Documento >>\n\t%s",
					  LOG01,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Consulta Dinamica del Documento >>",
					  LOG01);
	    return SQLCODE;
	}

	/* EXEC SQL DECLARE CursorDocs CURSOR FOR stConsultaDinamica; */ 


	if (SQLCODE) {
		vDTrazasError(modulo,"<< Fallo en 'DECLARE' del Cursor de Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor de Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}


	/* EXEC SQL OPEN CursorDocs ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )189;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (SQLCODE) {
		vDTrazasError(modulo,"<< Fallo en 'OPEN' del Cursor de Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Fallo en 'OPEN' del Cursor de Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

	return SQLOK ;

}

/****************************************************************************/
/*                         funcion : ifnFetchDocumentos                     */
/****************************************************************************/
static int ifnFetchDocumentos(int iTipDocumento,GHISTDOCU *pstGHistDocu,LINEACOMANDO stLineaComando)
{
char modulo[]="ifnFetchDocumentos";

int  iNotaC = 0;
char szNomTabla   [20];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

  int    ihIndAnulada         ;
  int    ihCodTipDocum        ;
  long   lhIndOrdenTotal      ;
  long   lhCodCiclFact        ;
  long   lhNumFolio           ;
  char   szhFecEmision    [15];  /* EXEC SQL VAR szhFecEmision IS STRING (15); */ 

  double dhAcumNetoNoGrav     ;
  double dhAcumNetoGrav       ;
  double dhAcumIva            ;
  double dhTotDocumento       ;
  /*char   szhFec_Vencimie[15]  ;  EXEC SQL VAR szhFec_Vencimie IS STRING (15);*/
  long   lhCod_Vendedor       ;
  int    ihCod_TipDocumen     ;
  char   szhCod_Oficina   [3] ;  /* EXEC SQL VAR szhCod_Oficina IS STRING (3); */ 

  char   szhRowid         [19];
  int    ihInd_Supertel       ;
  int    ihInd_Factur         ;
  long   lhNumProceso         ;
/* EXEC SQL END DECLARE SECTION  ; */ 


GHISTCLIE stGHistClie;

    iNotaC = stDatosGener.iCodNotaCre;
    strcpy(szNomTabla,stLineaComando.szTabla);

    vDTrazasLog ( modulo,"\n\t** Funcion ifnFetchDocumentos. ",LOG05);

	/* EXEC SQL
	FETCH CursorDocs INTO
		:ihIndAnulada       ,
		:lhIndOrdenTotal    ,
		:ihCodTipDocum      ,
		:lhCodCiclFact      ,
		:lhNumFolio         ,
		:szhFecEmision      ,
		:dhAcumNetoNoGrav   ,
		:dhAcumNetoGrav     ,
		:dhAcumIva          ,
		:dhTotDocumento     ,
        :lhCod_Vendedor     ,
        :szhCod_Oficina     ,
        :ihInd_Supertel     ,
        :ihInd_Factur       ,
        :szhRowid           ,
        :lhNumProceso       ,
        :ihCod_TipDocumen    ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )204;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihIndAnulada;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhIndOrdenTotal;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[5] = (unsigned long )15;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&dhAcumNetoNoGrav;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&dhAcumNetoGrav;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&dhAcumIva;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&dhTotDocumento;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&lhCod_Vendedor;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhCod_Oficina;
 sqlstm.sqhstl[11] = (unsigned long )3;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&ihInd_Supertel;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&ihInd_Factur;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[14] = (unsigned long )19;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&lhNumProceso;
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&ihCod_TipDocumen;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
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




	if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))   	{
		vDTrazasLog  (modulo,"\n\t<< Error en Fetch Cursor Documento >>\n\t[%d] : [%s]"
                            ,LOG01,SQLCODE,SQLERRM);
    	vDTrazasError(modulo,"\n\t<< Error en Fetch Cursor Documento >>\n\t[%d] : [%s]"
                            ,LOG01,SQLCODE,SQLERRM);
        return SQLCODE;
	}
   	if (SQLCODE == SQLNOTFOUND)   	{
		vDTrazasLog  (modulo,"\n\t<< Fin del Cursor de Documentos >>",LOG03);
        return SQLCODE;
	} else	{

        pstGHistDocu->iIndAnulada     = ihIndAnulada  ;
        pstGHistDocu->iCodTipDocum    = ihCodTipDocum ;
        pstGHistDocu->lCodCiclFact    = lhCodCiclFact ;
        pstGHistDocu->lNumFolio       = lhNumFolio    ;

        pstGHistDocu->dAcumNetoNoGrav = (ihCodTipDocum == iNotaC ? dhAcumNetoNoGrav *-1 : dhAcumNetoNoGrav);
        pstGHistDocu->dAcumNetoGrav   = (ihCodTipDocum == iNotaC ? dhAcumNetoGrav   *-1 : dhAcumNetoGrav  );
        pstGHistDocu->dAcumIva        = (ihCodTipDocum == iNotaC ? dhAcumIva        *-1 : dhAcumIva       );
        pstGHistDocu->dTotDocumento   = (ihCodTipDocum == iNotaC ? dhTotDocumento   *-1 : dhTotDocumento  );

        pstGHistDocu->iInd_Supertel   = ihInd_Supertel;
        pstGHistDocu->iInd_Factur     = ihInd_Factur  ;


        strcpy(pstGHistDocu->szFecEmision,szhFecEmision);
        strcpy(pstGHistDocu->szRowid,szhRowid);
        pstGHistDocu->lNumProceso    = lhNumProceso   ;
        /*strcpy(pstGHistDocu->szFec_Vencimie,szhFec_Vencimie);*/

        memset(&stGHistClie,0,sizeof(GHISTCLIE))    ;
        stGHistClie.lIndOrdenTotal = lhIndOrdenTotal;
        stGHistClie.lCodCiclFact   = lhCodCiclFact  ;
        if (!bfnGetHistClie(&stGHistClie,stLineaComando)) {
           return (iERROR_GETCLIENTE);
        }

        strcpy(pstGHistDocu->szNomCliente    ,stGHistClie.szNomCliente   );
        strcpy(pstGHistDocu->szRut           ,stGHistClie.szRut          );
        pstGHistDocu->lIndOrdenTotal = stGHistClie.lIndOrdenTotal;
        strcpy(pstGHistDocu->szCod_Oficina,szhCod_Oficina);


        /* Tipo de Documento (28-47-25-45-46)*/
        if ( strcmp(szNomTabla,HISTDOCU)!=0 )  {
             pstGHistDocu->iCod_tipdocumalm = ihCod_TipDocumen;
        } else {
        	switch(iTipDocumento) 	{
        		case iTipFactura :
        			pstGHistDocu->iCod_tipdocumalm = stDatosGener.iCodFactura; /* 28; */
        			break;
        		case iTipFacturaExen :
        			pstGHistDocu->iCod_tipdocumalm =  stDatosGener.iCodFacturaExen; /* 47;*/
        			break;
        		case iTipNotaCred :
        			pstGHistDocu->iCod_tipdocumalm = stDatosGener.iCodNotaCre;      /*  25  */
        			break;
        		case iTipBoleta :
        			pstGHistDocu->iCod_tipdocumalm =  stDatosGener.iCodBoleta;  /* 45;*/
        			break;
        		case iTipBoletaExen :
        			pstGHistDocu->iCod_tipdocumalm =  stDatosGener.iCodBoletaExen; /* 46; */
        			break;
        	}
        }

        vDTrazasLog  (modulo,"\n\t\tDatos Cargados",LOG03);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->iIndAnulada......[%d]", LOG03,pstGHistDocu->iIndAnulada);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->iCodTipDocum.....[%d]", LOG03,pstGHistDocu->iCodTipDocum);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->lNumFolio........[%ld]",LOG03,pstGHistDocu->lNumFolio);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->lIndOrdenTotal...[%d]", LOG03,pstGHistDocu->lIndOrdenTotal);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->dAcumNetoNoGrav..[%f]", LOG04,pstGHistDocu->dAcumNetoNoGrav);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->dAcumNetoGrav....[%f]", LOG04,pstGHistDocu->dAcumNetoGrav);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->dAcumIva.........[%f]", LOG04,pstGHistDocu->dAcumIva);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->dTotDocumento....[%f]", LOG04,pstGHistDocu->dTotDocumento);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->szFecEmision.....[%s]", LOG04,pstGHistDocu->szFecEmision);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->szNomCliente.....[%s]", LOG04,pstGHistDocu->szNomCliente);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->szRut............[%s]", LOG04,pstGHistDocu->szRut);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->szCod_Oficina....[%s]", LOG03,pstGHistDocu->szCod_Oficina);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->szRowid..........[%s]", LOG04,pstGHistDocu->szRowid);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->lNumProceso......[%ld]",LOG04,pstGHistDocu->lNumProceso);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->iCod_tipdocumalm.[%d]", LOG03,pstGHistDocu->iCod_tipdocumalm);
        /*vDTrazasLog  (modulo,"\t\tstGHistDocu->szFec_Vencimie...[%s]",LOG04,pstGHistDocu->szFec_Vencimie);*/
        vDTrazasLog  (modulo,"\t\tstGHistDocu->lCodCiclFact.....[%ld]",LOG04,pstGHistDocu->lCodCiclFact);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->iInd_Supertel....[%d]", LOG04,pstGHistDocu->iInd_Supertel);
        vDTrazasLog  (modulo,"\t\tstGHistDocu->iInd_Factur......[%d]\n",LOG04,pstGHistDocu->iInd_Factur);


    return SQLCODE;

    }

}/*********************** Final ifnFetchDocumentos  *************************/


/****************************************************************************/
/*                         funcion : bfnCloseDocumentos                     */
/****************************************************************************/
static BOOL bfnCloseDocumentos()
{
	char modulo[]="bfnCloseDocumentos";

    vDTrazasLog (modulo,"\n\t** Close Cursor Documento " ,LOG04);

	/* EXEC SQL CLOSE CursorDocs; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )287;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (modulo,"<< Error en Close Cursor Documento >>\n\t[%d] : [%s]"
                                ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"<< Error en Close Cursor Documento >>\n\t[%d] : [%s]"
                                ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/*********************** Final bfnCloseDocumentos  *************************/


/****************************************************************************/
/*                         funcion : bfnInsertaLibroIva                     */
/****************************************************************************/

static BOOL bfnInsertaLibroIva(GHISTDOCU pstGHistDocu,BOOL *bInsert,char *szOrigen)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int    ihCod_tipdocumalm   ;
    long   lhNum_folio         ;
    char   szhCod_oficina  [3] ;
    int    ihInd_anulada       ;
    long   lhInd_ordentotal    ;
    int    ihCod_tipdocum      ;
    char   szhFec_emision  [15];
    char   szhNum_identtrib[21];
    /*char   szhFec_vencimen [15]; */
    char   szhNom_cliente  [91];
    double dhTot_netograv      ;
    double dhTot_netonograv    ;
    double dhTot_iva           ;
    double dhTot_factura       ;
/* EXEC SQL END DECLARE SECTION; */ 



    vDTrazasLog (szExeName,"\n\t*** Inicio de bfnInsertaLibroIva ***\n",LOG04);

    strcpy(szhCod_oficina,pstGHistDocu.szCod_Oficina);
    strcpy(szhFec_emision,pstGHistDocu.szFecEmision);
    strcpy(szhNum_identtrib,pstGHistDocu.szRut );
    /*strcpy(szhFec_vencimen,pstGHistDocu.szFec_Vencimie);*/
    strcpy(szhNom_cliente,pstGHistDocu.szNomCliente);

    if  ((pstGHistDocu.iCod_tipdocumalm!=stDatosGener.iCodFactura)    &&
         (pstGHistDocu.iCod_tipdocumalm!=stDatosGener.iCodFacturaExen)&&
         (pstGHistDocu.iCod_tipdocumalm!=stDatosGener.iCodNotaCre) 	 &&
         (pstGHistDocu.iCod_tipdocumalm!=stDatosGener.iCodBoleta) 	 &&
         (pstGHistDocu.iCod_tipdocumalm!=stDatosGener.iCodBoletaExen) )
            return TRUE;



    ihCod_tipdocumalm = pstGHistDocu.iCod_tipdocumalm;
    lhNum_folio       = pstGHistDocu.lNumFolio      ;
    ihInd_anulada     = pstGHistDocu.iIndAnulada    ;
    lhInd_ordentotal  = pstGHistDocu.lIndOrdenTotal  ;
    ihCod_tipdocum    = pstGHistDocu.iCodTipDocum   ;
    dhTot_netograv    = pstGHistDocu.dAcumNetoGrav  ;
    dhTot_netonograv  = pstGHistDocu.dAcumNetoNoGrav;
    dhTot_iva         = pstGHistDocu.dAcumIva       ;
    dhTot_factura     = pstGHistDocu.dTotDocumento  ;


    vDTrazasLog (szExeName,"\t*** Datos a Insertar en FAT_DETLIBROIVA ***\n",LOG04);
    vDTrazasLog (szExeName,"\t\t ihInd_anulada ------> [%d]" ,LOG04,ihInd_anulada);
    vDTrazasLog (szExeName,"\t\t ihCod_tipdocum -----> [%d]" ,LOG04,ihCod_tipdocum);
    vDTrazasLog (szExeName,"\t\t lhNum_folio --------> [%ld]",LOG04,lhNum_folio);
    vDTrazasLog (szExeName,"\t\t lhInd_ordentotal ---> [%ld]",LOG04,lhInd_ordentotal);
    vDTrazasLog (szExeName,"\t\t dhTot_netonograv ---> [%f]" ,LOG04,dhTot_netonograv);
    vDTrazasLog (szExeName,"\t\t dhTot_netograv -----> [%f]" ,LOG04,dhTot_netograv);
    vDTrazasLog (szExeName,"\t\t dhTot_iva ----------> [%f]" ,LOG04,dhTot_iva);
    vDTrazasLog (szExeName,"\t\t dhTot_factura ------> [%f]" ,LOG04,dhTot_factura);
    vDTrazasLog (szExeName,"\t\t szhFec_emision -----> [%s]" ,LOG04,szhFec_emision);
    vDTrazasLog (szExeName,"\t\t szhNom_cliente -----> [%s]" ,LOG04,szhNom_cliente);
    vDTrazasLog (szExeName,"\t\t szhNum_identtrib ---> [%s]" ,LOG04,szhNum_identtrib);
    vDTrazasLog (szExeName,"\t\t szhCod_oficina -----> [%s]" ,LOG04,szhCod_oficina);
    vDTrazasLog (szExeName,"\t\t ihCod_tipdocumalm --> [%d]" ,LOG04,ihCod_tipdocumalm);


    /* EXEC SQL
    INSERT INTO FAT_DETLIBROIVA (
           COD_TIPDOCUMALM,
           NUM_FOLIO,
           COD_OFICINA,
           IND_ANULADA,
           IND_ORDENTOTAL,
           COD_TIPDOCUM,
           FEC_EMISION,
           NUM_IDENTTRIB,
           NOM_CLIENTE,
           TOT_NETOGRAV,
           TOT_NETONOGRAV,
           TOT_IVA,
           TOT_FACTURA)
    VALUES (
            :ihCod_tipdocumalm,
            :lhNum_folio      ,
            :szhCod_oficina   ,
            :ihInd_anulada    ,
            :lhInd_ordentotal ,
            :ihCod_tipdocum   ,
            TO_DATE(:szhFec_emision,'dd/mm/yyyy') ,
            :szhNum_identtrib ,
            :szhNom_cliente   ,
            :dhTot_netograv   ,
            :dhTot_netonograv ,
            :dhTot_iva        ,
            :dhTot_factura    ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DETLIBROIVA (COD_TIPDOCUMALM,NUM_FOLIO,CO\
D_OFICINA,IND_ANULADA,IND_ORDENTOTAL,COD_TIPDOCUM,FEC_EMISION,NUM_IDENTTRIB,NO\
M_CLIENTE,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_FACTURA) values (:b0,:b1,:b2\
,:b3,:b4,:b5,TO_DATE(:b6,'dd/mm/yyyy'),:b7,:b8,:b9,:b10,:b11,:b12)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )302;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_tipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_folio;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCod_oficina;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihInd_anulada;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhInd_ordentotal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_tipdocum;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFec_emision;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNum_identtrib;
    sqlstm.sqhstl[7] = (unsigned long )21;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNom_cliente;
    sqlstm.sqhstl[8] = (unsigned long )91;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhTot_netograv;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTot_netonograv;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&dhTot_iva;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&dhTot_factura;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
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



    vDTrazasLog (szExeName,"\n\t<<< Insertados en FAT_DETLIBROIVA >>>",LOG03);
    vDTrazasLog (szExeName,"\t\t Num_folio       [%ld]",LOG03,lhNum_folio);
    vDTrazasLog (szExeName,"\t\t Ind_ordentotal  [%ld]\n",LOG03,lhInd_ordentotal);

    if (SQLCODE == SQLUNIQUE) {
		vDTrazasLog  (szExeName,"\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
		                        "Tipo de Docto. [%d]   Numero Orden [%ld]"
		                        ,LOG01,SQLCODE,SQLERRM,lhNum_folio,ihCod_tipdocum,lhInd_ordentotal);
        vDTrazasError(szExeName,"\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
		                        "Tipo de Docto. [%d]   Numero Orden [%ld]"
		                        ,LOG01,SQLCODE,SQLERRM,lhNum_folio,ihCod_tipdocum,lhInd_ordentotal);
        *bInsert = FALSE;


        if (!bfnInsertaDuplicados(pstGHistDocu, szOrigen))
            return FALSE;

        if(!bfnUpdateaIndDuplicado(ihCod_tipdocumalm,lhNum_folio, szOrigen))
            return FALSE;

    	return TRUE;
    }

	if (SQLCODE != SQLOK)   {
		vDTrazasLog  (szExeName,"\n\t\t<< Error en Insert de FAT_DETLIBROIVA >>\n\t\t[%d] : %s",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szExeName,"\n\t\t<< Error en Insert de FAT_DETLIBROIVA >>\n\t\t[%d] : %s",LOG01,SQLCODE,SQLERRM);
    	return FALSE;
	}


    vDTrazasLog (szExeName,"\n\t*** Fin de bfnInsertaLibroIva ***\n",LOG04);
    return TRUE;
}

/****************************************************************************/
/*                         funcion : ifnOficina_Vendedor                     */
/****************************************************************************/
static BOOL bfnOficina_Vendedor(long lCod_Vendedor)
{
char modulo[]="bfnOficina_Vendedor";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhCod_Oficina [3] ;
     long lhCod_Vendedor;
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( modulo,"\n\t\t** Funcion bfnOficina_Vendedor  **",LOG04);

    lhCod_Vendedor = lCod_Vendedor;

    /* EXEC SQL
    SELECT cod_oficina
    INTO   :szhCod_Oficina
    FROM   ve_vendedores
    WHERE  cod_vendedor = :lhCod_Vendedor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select cod_oficina into :b0  from ve_vendedores where cod\
_vendedor=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )369;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Vendedor;
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



    if (SQLCODE == SQLOK) {
        strcpy(szCod_Oficina,szhCod_Oficina);
        vDTrazasLog ( modulo,"\t\t** Cod. Oficina : [%s]  **",LOG04,szCod_Oficina);
        return TRUE;
    }
    if ((SQLCODE == SQLNOTFOUND) || (SQLCODE != SQLOK)) {
		vDTrazasLog  (modulo,"\n\t\t<< Error al Seleccionar Codigo de Oficina >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t\t<< Error al Seleccionar Codigo de Oficina >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

}



/****************************************************************************/
/*                         funcion : ifnOpenconsumos                        */
/****************************************************************************/
static int ifnOpenConsumos(int iTipDocumento, char *szFecInicio,char *szFecFin)
{
char modulo[]="ifnOpenConsumos";
int  bTipDocError=FALSE;
static char szCadenaSQL[2048];

/* EXEC SQL BEGIN DECLARE SECTION ; */ 

     char szhNomTabla  [20]    ;
	 int  ihCodTipDocumalm     ;
     char szhFecInicio [9]     ;   /* EXEC SQL VAR szhFecInicio IS STRING (9); */ 
   /*  DDMMYYYY  */
     char szhFecFin    [9]     ;   /* EXEC SQL VAR szhFecFin    IS STRING (9); */ 
   /*  DDMMYYYY  */
/* EXEC SQL END DECLARE SECTION   ; */ 



    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   , szFecFin)  ;
    	switch(iTipDocumento) {
    		case iTipFactura :
    			ihCodTipDocumalm = stDatosGener.iCodFactura;        /* 28 */
    			break;
    		case iTipFacturaExen :
    			ihCodTipDocumalm =  stDatosGener.iCodFacturaExen;   /* 47 */
    			break;
    		case iTipNotaCred :
    			ihCodTipDocumalm = stDatosGener.iCodNotaCre;        /* 25 */
    			break;
    		case iTipBoleta :
    			ihCodTipDocumalm =  stDatosGener.iCodBoleta;        /* 45 */
    			break;
    		case iTipBoletaExen :
    			ihCodTipDocumalm =  stDatosGener.iCodBoletaExen;    /* 46 */
    			break;
    		default :
    			bTipDocError=TRUE;
    			break;
    	}


    vDTrazasLog ( modulo,"\n\t\t** Funcion ifnOpenConsumos  **"
                         "\n\t\t==>  Fecha Desde   [%s]"
                         "\n\t\t==>  Fecha Hasta   [%s]"
                         "\n\t\t==>  TipDocumalm   [%d]"
                         ,LOG04,szFecInicio, szFecFin,ihCodTipDocumalm);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    sprintf(szCadenaSQL,"%s\tSELECT nvl(COD_OFICINA,' '),\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s\t      TIP_DOCUM  ,\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s\t      NUM_FOLIO  ,\n",szCadenaSQL);
    sprintf(szCadenaSQL,"%s\t      TO_CHAR(FEC_CONSUMO,'DD/MM/YYYY'),\n",szCadenaSQL);
    sprintf(szCadenaSQL,"%s\t      IND_ANULACION,\n",szCadenaSQL);
    sprintf(szCadenaSQL,"%s\t      ROWID\n",szCadenaSQL);
  	sprintf(szCadenaSQL,"%s\tFROM  AL_CONSUMO_DOCUMENTOS\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s\tWHERE FEC_CONSUMO  >= TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecInicio);
	sprintf(szCadenaSQL,"%s\tAND   FEC_CONSUMO  < TO_DATE('%s','DDMMYYYY')\n",szCadenaSQL,szhFecFin);
	sprintf(szCadenaSQL,"%s\tAND   TIP_DOCUM     = %d\n",szCadenaSQL,ihCodTipDocumalm);
	sprintf(szCadenaSQL,"%s\tAND   IND_ANULACION = 1\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s\tAND   IND_LIBROIVA  = 0\n",szCadenaSQL);


    vDTrazasLog ( modulo,"\n\t** Cadena Sql **\n%s\n",LOG06,szCadenaSQL);

	/* EXEC SQL PREPARE stAl_Consumos FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )392;
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


	if (SQLCODE) {
		vDTrazasError(modulo,"<< Error en 'PREPARE' de la Consulta Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Error en 'PREPARE' de la Consulta Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

	/* EXEC SQL DECLARE CursorConsumos CURSOR FOR stAl_Consumos; */ 

	if (SQLCODE) {
		vDTrazasError(modulo,"<< Error en 'DECLARE' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Error en 'DECLARE' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

	/* EXEC SQL OPEN CursorConsumos ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )411;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE) {
		vDTrazasError(modulo,"<< Error en 'OPEN' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Error en 'OPEN' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]",
					  LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

    vDTrazasLog ( modulo,"\n\t** Fin Funcion ifnOpenConsumos  **",LOG04);

	return SQLOK ;

}
/****************************************************************************/
/*                         funcion : ifnFetchDocumentos                     */
/****************************************************************************/
static int ifnFetchConsumos(int iDoc,GHISTDOCU *pstGHistDocu)
{
char modulo[]="ifnFetchConsumos";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

  char   szhCod_Oficina[3]    ;
  int    ihTip_Docum          ;
  long   lhNumFolio           ;
  char   szhFec_Consumo[15]   ;  /* EXEC SQL VAR szhFec_Consumo IS STRING (15); */ 

  int    ihIndAnulacion       ;
  char   szhRowid      [19]   ;
/* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog ( modulo,"\n\t** Fetch Cursor Consumos **",LOG04);

	/* EXEC SQL
	FETCH CursorConsumos INTO
  		 :szhCod_Oficina     ,
		 :ihTip_Docum        ,
		 :lhNumFolio         ,
		 :szhFec_Consumo     ,
		 :ihIndAnulacion     ,
		 :szhRowid           ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )426;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Oficina;
 sqlstm.sqhstl[0] = (unsigned long )3;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihTip_Docum;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFec_Consumo;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihIndAnulacion;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhRowid;
 sqlstm.sqhstl[5] = (unsigned long )19;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
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



	if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))   	{
		vDTrazasLog  (modulo,"\n\t<< Error en Fetch Cursor Consumos >>\n\t[%d] : [%s]"
                            ,LOG01,SQLCODE,SQLERRM);
    	vDTrazasError(modulo,"\n\t<< Error en Fetch Cursor Consumos >>\n\t[%d] : [%s]"
                            ,LOG01,SQLCODE,SQLERRM);
        return SQLCODE;
	}


  	if (SQLCODE == SQLNOTFOUND)   	{
    		vDTrazasLog  (modulo,"\n\t<< Fin de Cursor Consumos de [%s]>>\n\t[%d] : [%s]"
                                ,LOG04,szNombreDocs[iDoc],SQLCODE,SQLERRM);
        return SQLCODE;
	} else	{

    	switch(iDoc) 	{
    		case iTipFactura :
    			pstGHistDocu->iCod_tipdocumalm = 28; break;
    		case iTipFacturaExen :
    			pstGHistDocu->iCod_tipdocumalm = 47; break;
    		case iTipNotaCred :
    			pstGHistDocu->iCod_tipdocumalm = 25; break;
    		case iTipBoleta :
    			pstGHistDocu->iCod_tipdocumalm = 45; break;
    		case iTipBoletaExen :
    			pstGHistDocu->iCod_tipdocumalm = 46; break;
    	}

        pstGHistDocu->iIndAnulada     = ihIndAnulacion ;
        pstGHistDocu->iCodTipDocum    = ihTip_Docum    ;
        pstGHistDocu->lNumFolio       = lhNumFolio     ;

        strcpy(pstGHistDocu->szFecEmision,szhFec_Consumo) ;
        strcpy(pstGHistDocu->szCod_Oficina,szhCod_Oficina);
        strcpy(pstGHistDocu->szRowid,szhRowid);

        vDTrazasLog ( modulo,"\n\t\t** Datos Cargados **",LOG04);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->szCod_Oficina......[%s]",LOG04,pstGHistDocu->szCod_Oficina);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->iCodTipDocum.......[%d]",LOG04,pstGHistDocu->iCodTipDocum);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->lNumFolio..........[%ld]",LOG04,pstGHistDocu->lNumFolio);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->szFecEmision.......[%s]",LOG04,pstGHistDocu->szFecEmision);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->iIndAnulada........[%d]",LOG04,pstGHistDocu->iIndAnulada);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->iCod_tipdocumalm...[%d]",LOG04,pstGHistDocu->iCod_tipdocumalm);
        vDTrazasLog ( modulo,"\t\t** stGHistDocu->szRowid............[%d]",LOG04,pstGHistDocu->szRowid);

        vDTrazasLog ( modulo,"\n\t** Fin Fetch Cursor Documento Consumos **",LOG04);

        return SQLCODE;
    }

}/*********************** Final ifnFetchConsumos  *************************/


/****************************************************************************/
/*                         funcion : bfnCloseConsumos                     */
/****************************************************************************/
static BOOL bfnCloseConsumos()
{
char modulo[]="Close Cursor Consumos";

    vDTrazasLog (modulo,"\n\t** Close Cursor Consumos" ,LOG04);

	/* EXEC SQL CLOSE CursorConsumos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )465;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)  {
  		vDTrazasLog  (modulo,"<< Error en Close Cursor Consumos >>\n\t[%d] : [%s]"
                               ,LOG01,SQLCODE,SQLERRM);
       	vDTrazasError(modulo,"<< Error en Close Cursor Consumos >>\n\t[%d] : [%s]"
                               ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/*********************** Final bfnCloseConsumos  *************************/


/****************************************************************************/
/*                         funcion : bfnInsertaConsumosenLibroIva                     */
/****************************************************************************/
static BOOL bfnInsertaConsumosenLibroIva(GHISTDOCU pstGHistDocu, BOOL *bInsert)
{
char modulo[]="Inserta Consumos en LibroIva";
int  iCod_tipdocumalm;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long   lhNum_folio         ;
    char   szhCod_oficina  [3] ;
    int    ihInd_anulada       ;
    int    ihCod_tipdocum      ;
    char   szhFec_emision  [15];
    char   szhNom_cliente  [50];
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de bfnInsertaConsumosenLibroIva ***\n",LOG04);

    iCod_tipdocumalm = pstGHistDocu.iCod_tipdocumalm;
    sprintf(szhCod_oficina,"%s\0",pstGHistDocu.szCod_Oficina);
    sprintf(szhFec_emision,"%s\0",pstGHistDocu.szFecEmision);
    sprintf(szhNom_cliente,"DOCUMENTO ANULADO\0")      ;

    lhNum_folio       = pstGHistDocu.lNumFolio      ;
    ihInd_anulada     = pstGHistDocu.iIndAnulada    ;
    ihCod_tipdocum    = pstGHistDocu.iCodTipDocum   ;

    vDTrazasLog ( modulo,"\n\t\t** Datos de Consumos a Insertar en FAT_DETLIBROIVA **",LOG03);
    vDTrazasLog ( modulo,"\t\t** szhCod_Oficina......[%s]",LOG03,szhCod_oficina);
    vDTrazasLog ( modulo,"\t\t** ihCod_tipdocum......[%d]",LOG03,ihCod_tipdocum);
    vDTrazasLog ( modulo,"\t\t** lhNum_folio.........[%ld]",LOG03,lhNum_folio);
    vDTrazasLog ( modulo,"\t\t** szhFec_emision......[%s]",LOG03,szhFec_emision);
    vDTrazasLog ( modulo,"\t\t** ihInd_anulada.......[%d]",LOG03,ihInd_anulada);
    vDTrazasLog ( modulo,"\t\t** szhNom_cliente......[%s]",LOG03,szhNom_cliente);
    vDTrazasLog ( modulo,"\t\t** iCod_tipdocumalm....[%d]",LOG03,iCod_tipdocumalm);

    /* EXEC SQL
    INSERT INTO FAT_DETLIBROIVA (
           NUM_FOLIO,
           COD_OFICINA,
           IND_ANULADA,
           COD_TIPDOCUM,
           FEC_EMISION,
           NOM_CLIENTE,
           COD_TIPDOCUMALM,
           IND_ORDENTOTAL,
           NUM_IDENTTRIB,
           TOT_NETOGRAV,
           TOT_NETONOGRAV,
           TOT_IVA,
           TOT_FACTURA)
    VALUES (
            :lhNum_folio      ,
            :szhCod_oficina   ,
            :ihInd_anulada    ,
            :ihCod_tipdocum   ,
            TO_DATE(:szhFec_emision,'dd-mm-yyyy')  ,
            :szhNom_cliente   ,
            :iCod_tipdocumalm ,
            0,
            ' ',
            0,
            0,
            0,
            0); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DETLIBROIVA (NUM_FOLIO,COD_OFICINA,IND_AN\
ULADA,COD_TIPDOCUM,FEC_EMISION,NOM_CLIENTE,COD_TIPDOCUMALM,IND_ORDENTOTAL,NUM_\
IDENTTRIB,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_FACTURA) values (:b0,:b1,:b2\
,:b3,TO_DATE(:b4,'dd-mm-yyyy'),:b5,:b6,0,' ',0,0,0,0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )480;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_folio;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCod_oficina;
    sqlstm.sqhstl[1] = (unsigned long )3;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihInd_anulada;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_tipdocum;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFec_emision;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhNom_cliente;
    sqlstm.sqhstl[5] = (unsigned long )50;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&iCod_tipdocumalm;
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



            /*:ihCod_tipdocum   ,*/

    if (SQLCODE == SQLUNIQUE) {
		/*vDTrazasLog  (szExeName,"\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
	   	                        "Tipo de Docto. [%d]",LOG03,SQLCODE,SQLERRM,lhNum_folio,ihCod_tipdocum);*/
		vDTrazasLog  (szExeName,"\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
       	                        "Tipo de Docto Almacen. [%d]",LOG03,SQLCODE,SQLERRM,lhNum_folio,iCod_tipdocumalm);
        *bInsert = FALSE;

        if (!bfnInsertaDuplicados(pstGHistDocu, CONSU))
            return FALSE;

        if(!bfnUpdateaIndDuplicado(iCod_tipdocumalm,lhNum_folio, CONSU))
            return FALSE;

    	return TRUE;
    }

	if (SQLCODE != SQLOK)   {
		vDTrazasLog  (modulo,"\n\t\t<< Error al Insertar Consumos en FAT_DETLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	vDTrazasError(modulo,"\n\t\t<< Error al Insertar Consumos en FAT_DETLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	return FALSE;
	}

    vDTrazasLog (szExeName,"\n\t*** Fin de bfnInsertaConsumosenLibroIva ***\n",LOG04);

    return TRUE;
}

/****************************************************************************/
/*                         funcion : bfnInsertaDuplicados                     */
/****************************************************************************/
static BOOL bfnInsertaDuplicados(GHISTDOCU pstGHistDocu, char *szOrigen)
{
char modulo[]="Inserta Duplicados";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

    int    ihCod_tipdocumalm   ;
    long   lhNum_folio         ;
    char   szhCod_oficina  [3] ;
    int    ihInd_anulada       ;
    long   lhInd_ordentotal    ;
    int    ihCod_tipdocum      ;
    char   szhFec_emision  [15];
    char   szhNum_identtrib[21];
    char   szhNom_cliente  [61];
    double dhTot_netograv      ;
    double dhTot_netonograv    ;
    double dhTot_iva           ;
    double dhTot_factura       ;
    char   szhOrigen       [2] ;
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de bfnInsertaDuplicados ***",LOG04);

    strcpy(szhCod_oficina,pstGHistDocu.szCod_Oficina);
    strcpy(szhFec_emision,pstGHistDocu.szFecEmision);
    strcpy(szhNum_identtrib,pstGHistDocu.szRut );
    strcpy(szhNom_cliente,pstGHistDocu.szNomCliente)      ;
    strcpy(szhOrigen,szOrigen);

    ihCod_tipdocumalm = pstGHistDocu.iCod_tipdocumalm;
    lhNum_folio       = pstGHistDocu.lNumFolio      ;
    ihInd_anulada     = pstGHistDocu.iIndAnulada    ;
    lhInd_ordentotal  = pstGHistDocu.lIndOrdenTotal  ;
    ihCod_tipdocum    = pstGHistDocu.iCodTipDocum   ;
    dhTot_netograv    = pstGHistDocu.dAcumNetoGrav  ;
    dhTot_netonograv  = pstGHistDocu.dAcumNetoNoGrav;
    dhTot_iva         = pstGHistDocu.dAcumIva       ;
    dhTot_factura     = pstGHistDocu.dTotDocumento  ;

    vDTrazasLog ( modulo,"\t**** Datos a Insertar en FAT_DUPLIBROIVA ***\n",LOG04);
    vDTrazasLog ( modulo,"\t\t** ihInd_anulada ------> [%d]",LOG04,ihInd_anulada);
    vDTrazasLog ( modulo,"\t\t** ihCod_tipdocum -----> [%d]",LOG04,ihCod_tipdocum);
    vDTrazasLog ( modulo,"\t\t** lhNum_folio --------> [%ld]",LOG04,lhNum_folio);
    vDTrazasLog ( modulo,"\t\t** lhInd_ordentotal ---> [%ld]",LOG04,lhInd_ordentotal);
    vDTrazasLog ( modulo,"\t\t** dhTot_netonograv ---> [%f]",LOG04,dhTot_netonograv);
    vDTrazasLog ( modulo,"\t\t** dhTot_netograv -----> [%f]",LOG04,dhTot_netograv);
    vDTrazasLog ( modulo,"\t\t** dhTot_iva ----------> [%f]",LOG04,dhTot_iva);
    vDTrazasLog ( modulo,"\t\t** dhTot_factura ------> [%f]",LOG04,dhTot_factura);
    vDTrazasLog ( modulo,"\t\t** szhFec_emision -----> [%s]",LOG04,szhFec_emision);
    vDTrazasLog ( modulo,"\t\t** szhNom_cliente -----> [%s]",LOG04,szhNom_cliente);
    vDTrazasLog ( modulo,"\t\t** szhNum_identtrib ---> [%s]",LOG04,szhNum_identtrib);
    vDTrazasLog ( modulo,"\t\t** szhCod_oficina -----> [%s]",LOG04,szhCod_oficina);
    vDTrazasLog ( modulo,"\t\t** ihCod_tipdocumalm --> [%d]",LOG04,ihCod_tipdocumalm);
    vDTrazasLog ( modulo,"\t\t** szhOrigen-----------> [%s]",LOG04,szhOrigen);


    /* EXEC SQL
    INSERT INTO FAT_DUPLIBROIVA (
           COD_TIPDOCUMALM,
           NUM_FOLIO,
           COD_OFICINA,
           IND_ANULADA,
           IND_ORDENTOTAL,
           COD_TIPDOCUM,
           FEC_EMISION,
           NUM_IDENTTRIB,
           NOM_CLIENTE,
           TOT_NETOGRAV,
           TOT_NETONOGRAV,
           TOT_IVA,
           TOT_FACTURA,
           COD_ORIGEN)
    VALUES (
            :ihCod_tipdocumalm,
            :lhNum_folio      ,
            :szhCod_oficina   ,
            :ihInd_anulada    ,
            :lhInd_ordentotal ,
            :ihCod_tipdocum   ,
            TO_DATE(:szhFec_emision,'dd/mm/yyyy') ,
            :szhNum_identtrib ,
            :szhNom_cliente   ,
            :dhTot_netograv   ,
            :dhTot_netonograv ,
            :dhTot_iva        ,
            :dhTot_factura    ,
            :szhOrigen        ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DUPLIBROIVA (COD_TIPDOCUMALM,NUM_FOLIO,CO\
D_OFICINA,IND_ANULADA,IND_ORDENTOTAL,COD_TIPDOCUM,FEC_EMISION,NUM_IDENTTRIB,NO\
M_CLIENTE,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_FACTURA,COD_ORIGEN) values (\
:b0,:b1,:b2,:b3,:b4,:b5,TO_DATE(:b6,'dd/mm/yyyy'),:b7,:b8,:b9,:b10,:b11,:b12,:\
b13)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )523;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_tipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_folio;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCod_oficina;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihInd_anulada;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhInd_ordentotal;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_tipdocum;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFec_emision;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhNum_identtrib;
    sqlstm.sqhstl[7] = (unsigned long )21;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNom_cliente;
    sqlstm.sqhstl[8] = (unsigned long )61;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhTot_netograv;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTot_netonograv;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&dhTot_iva;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&dhTot_factura;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhOrigen;
    sqlstm.sqhstl[13] = (unsigned long )2;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
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



	if (SQLCODE != SQLOK)   {
		vDTrazasLog  (modulo,"\n\t\t<< Error al Insertar Duplicados en FAT_DUPLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	vDTrazasError(modulo,"\n\t\t<< Error al Insertar Duplicados en FAT_DUPLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	return FALSE;
	}

    vDTrazasLog (szExeName,"\n\t*** Fin de bfnInsertaDuplicados ***\n",LOG04);
    return TRUE;
}




/****************************************************************************/
/*                         funcion : bfnInsertaConsumosenLibroIva                     */
/****************************************************************************/
static BOOL bfnUpdateIndLibro(char *szNomTabla, GHISTDOCU stGHistDocu, BOOL OptInsert, BOOL BFlagOficina)
{
char modulo[]="Update Ind. Libro";
static char szCadenaSQL[2048];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char   szhNomTabla  [20];
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de bfnUpdateIndLibro ***\n",LOG05);

    strcpy(szhNomTabla,szNomTabla);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    if ((strcmp(szhNomTabla,NOCICLO)==0) || (strcmp(szhNomTabla,HISTDOCU)==0))
       sprintf(szCadenaSQL,"%s UPDATE %s SET \n",szCadenaSQL,szhNomTabla);
    else
       sprintf(szCadenaSQL,"%s UPDATE FA_FACTDOCU_%s SET \n",szCadenaSQL,szhNomTabla);


    if (BFlagOficina) {
        if (strcmp(szhNomTabla,NOCICLO)==0) {
            if (!OptInsert) {
            	sprintf(szCadenaSQL,"%s\t IND_LIBROIVA    = 2\n",szCadenaSQL);
                sprintf(szCadenaSQL,"%s\t WHERE NUM_FOLIO = '%ld'\n",szCadenaSQL,stGHistDocu.lNumFolio);
            } else {
                if  ((stGHistDocu.iCod_tipdocumalm==stDatosGener.iCodFactura)    ||
                     (stGHistDocu.iCod_tipdocumalm==stDatosGener.iCodFacturaExen)||
                     (stGHistDocu.iCod_tipdocumalm==stDatosGener.iCodNotaCre) 	 ||
                     (stGHistDocu.iCod_tipdocumalm==stDatosGener.iCodBoleta) 	 ||
                     (stGHistDocu.iCod_tipdocumalm==stDatosGener.iCodBoletaExen) )
                {
       			   sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 1\n",szCadenaSQL);
                   sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
                } else {
           	       sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 3\n",szCadenaSQL);
                   sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
                }
           	}

        } else {
            if (!OptInsert) {
            	sprintf(szCadenaSQL,"%s\t IND_LIBROIVA    = 2\n",szCadenaSQL);
                sprintf(szCadenaSQL,"%s\t WHERE NUM_FOLIO = '%ld'\n",szCadenaSQL,stGHistDocu.lNumFolio);
            } else {
                sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 1\n",szCadenaSQL);
                sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
            }

        }

    } else {
        /* Indica que documento es de consignacion*/
      	sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 3\n",szCadenaSQL);
        sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
    }

    vDTrazasLog (modulo,"\n\t*** CadenaSQL de bfnUpdateIndLibro ***",LOG06);
    vDTrazasLog (modulo,"\t%s",LOG06,szCadenaSQL);

    /* EXEC SQL PREPARE stUpdateTabla FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )594;
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


    if (SQLCODE) {
            vDTrazasError(modulo,"\n\t<< Error en 'PREPARE' de Update en Tabla [%s] >>\n\t[%d] : [%s]",
                                      LOG01,szhNomTabla, SQLCODE,SQLERRM);
            vDTrazasLog  (modulo,"\n\t<< Error en 'PREPARE' de Update en Tabla [%s] >>\n\t[%d] : [%s]",
                                      LOG01,szhNomTabla, SQLCODE,SQLERRM);
        return FALSE;
    }

    /* EXEC SQL EXECUTE stUpdateTabla ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )613;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE) {
            vDTrazasError(modulo,"\n\t<< Error en 'EXECUTE' del Update en Tabla [%s] >>\n\t[%d] : [%s]",
                                      LOG01,szhNomTabla,SQLCODE,SQLERRM);
            vDTrazasLog  (modulo,"\n\t<< Error en 'EXECUTE' del Update en Tabla [%s] >>\n\t[%d] : [%s]",
                                      LOG01,szhNomTabla,SQLCODE,SQLERRM);
        return FALSE;
    }

    vDTrazasLog (modulo,"\n\t*** Update Ind_Libroiva OK ***\n",LOG04);

    return TRUE;

}/*  fin  bfnUpdateIndLibro */


/****************************************************************************/
/*                         funcion : bfnUpdateIndConsumosLibroIva                     */
/****************************************************************************/
static BOOL bfnUpdateIndConsumosLibroIva( GHISTDOCU stGHistDocu, BOOL OptInsert)
{
char modulo[]="Update Consumos";
static char szCadenaSQL[2048];

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char  szhNomTabla   [20];
 	 long  lhNumFolio         ;
	 long  ihIndAnulada       ;
  	 int   ihCodTipDocum      ;
	 int   lhIndOrdenTotal    ;
	 char  szhRowid      [19] ;
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de bfnUpdateIndConsumosLibroIva***\n",LOG04);

	lhNumFolio      = stGHistDocu.lNumFolio     ;
	ihIndAnulada    = stGHistDocu.iIndAnulada   ;
	ihCodTipDocum   = stGHistDocu.iCodTipDocum  ;
	lhIndOrdenTotal = stGHistDocu.lIndOrdenTotal;
    strcpy(szhRowid,stGHistDocu.szRowid);

    vDTrazasLog (modulo,"\n\t*** lhNumFolio [%ld]***",LOG04,lhNumFolio);
    vDTrazasLog (modulo,"\t*** ihIndAnulada [%ld]***",LOG04,ihIndAnulada);
    vDTrazasLog (modulo,"\t*** ihCodTipDocum [%ld]***",LOG04,ihCodTipDocum);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    if (!OptInsert)
        /* EXEC SQL
        UPDATE AL_CONSUMO_DOCUMENTOS SET
    	   	   IND_LIBROIVA   = 2
    	WHERE  ROWID          = :szhRowid; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update AL_CONSUMO_DOCUMENTOS  set IND_LIBROIVA=2 wher\
e ROWID=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )628;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )19;
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


    else
        /* EXEC SQL
        UPDATE AL_CONSUMO_DOCUMENTOS SET
    	   	   IND_LIBROIVA   = 1
    	WHERE  ROWID          = :szhRowid; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 17;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update AL_CONSUMO_DOCUMENTOS  set IND_LIBROIVA=1 wher\
e ROWID=:b0";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )647;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )19;
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




	if (SQLCODE != SQLCODE) {
		vDTrazasError(modulo,"\n\t<< Error en 'UPDATE' de Tabla [AL_CONSUMO_DOCUMENTOS] >>\n\t[%d] : [%s]",
					  LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"\n\t<< Error en 'UPDATE' de Tabla [AL_CONSUMO_DOCUMENTOS] >>\n\t[%d] : [%s]",
					  LOG01,SQLCODE,SQLERRM);
	    return FALSE;
	}

    return TRUE;
}
/****************************************************************************/


/****************************************************************************/
/*                         funcion : bfnUpdateaIndDuplicado                 */
/****************************************************************************/
static BOOL bfnUpdateaIndDuplicado(int iCod_tipdocumalm, long lNum_folio, char *szOrigen)
{
char modulo[]="Update Ind.Duplicado";

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char   szhOrigen    [2]  ;
     long   lhNum_folio       ;
     int    ihCod_tipdocumalm ;
/* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t*** Inicio de bfnUpdateaIndDuplicado ***\n",LOG04);
    vDTrazasLog (modulo,"\t**** Numero de Folio : [%ld] ***\n",LOG03,lNum_folio);

    ihCod_tipdocumalm = iCod_tipdocumalm ;
    lhNum_folio = lNum_folio ;
    strcpy(szhOrigen,szOrigen); /* N=Nociclo  C=Ciclo  H=Historico A=Consumos*/

    /*Inserta registro duplicado. Si ya existe solo Updateara  */
    /* EXEC SQL
    INSERT INTO FAT_DUPLIBROIVA
    SELECT COD_TIPDOCUMALM,
           NUM_FOLIO,
           COD_OFICINA,
           IND_ANULADA,
           IND_ORDENTOTAL,
           COD_TIPDOCUM,
           FEC_EMISION,
           NUM_IDENTTRIB,
           NOM_CLIENTE,
           TOT_NETOGRAV,
           TOT_NETONOGRAV,
           TOT_IVA,
           TOT_FACTURA,
           :szhOrigen,
           COD_CLIENTE,
           FEC_VENCIMIENTO,
           PREF_PLAZA
    FROM   FAT_DETLIBROIVA
    WHERE  COD_TIPDOCUMALM = :ihCod_tipdocumalm
    AND    NUM_FOLIO  = :lhNum_folio
    AND    IND_DUPLICADO = 'N'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DUPLIBROIVA  select COD_TIPDOCUMALM ,NUM_\
FOLIO ,COD_OFICINA ,IND_ANULADA ,IND_ORDENTOTAL ,COD_TIPDOCUM ,FEC_EMISION ,NU\
M_IDENTTRIB ,NOM_CLIENTE ,TOT_NETOGRAV ,TOT_NETONOGRAV ,TOT_IVA ,TOT_FACTURA ,\
:b0 ,COD_CLIENTE ,FEC_VENCIMIENTO ,PREF_PLAZA  from FAT_DETLIBROIVA where ((CO\
D_TIPDOCUMALM=:b1 and NUM_FOLIO=:b2) and IND_DUPLICADO='N')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )666;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhOrigen;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCod_tipdocumalm;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_folio;
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




    /*Actualiza registro duplicado con ind_duplicado = S*/
    /* EXEC SQL
    UPDATE FAT_DETLIBROIVA SET
           IND_DUPLICADO = 'S'
    WHERE  COD_TIPDOCUMALM = :ihCod_tipdocumalm
    AND    NUM_FOLIO = :lhNum_folio ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_DETLIBROIVA  set IND_DUPLICADO='S' where (COD_\
TIPDOCUMALM=:b0 and NUM_FOLIO=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )693;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_tipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_folio;
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



	if (SQLCODE != SQLOK)   {
		vDTrazasLog  (modulo,"\n\t\t<< Error al Updatear Ind Duplicado de Fat_DetLibroIva >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	vDTrazasError(modulo,"\n\t\t<< Error al Updatear Ind Duplicado de Fat_DetLibroIva >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
    	return FALSE;
	}

    vDTrazasLog (modulo,"\t**** Fin de bfnUpdateaIndDuplicado ****\n",LOG04);
    return TRUE;
}
/****************************************************************************/
/*************** FIN  DEL PROCESO SQL****************************************/
/****************************************************************************/
/****************************************************************************/







/****************************************************************************/
/****************************************************************************/
/****************************************************************************/
/************************         Impresion         *************************/
/*                         Funcion bfnLlenaArchivoImpresion                         */
/****************************************************************************/
static BOOL bfnLlenaArchivoImpresion(char *szFecInicio, char *szFecFin)
{
char modulo[]="bfnLlenaArchivoImpresion";
static char szCadenaSQL[2048];
int    iSqlLibroIva = 0;
int    iNumPag  = 1  		   ;
int    iDoc=0				   ;
long   lCon_Reg = 0            ;
long   lTot_Reg = 0            ;
int    iCant_Regs = 0          ;
int    i  = 0                  ;
int    iCargaFile = 0          ;


/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhFecInicio [9]     ;   /* EXEC SQL VAR szhFecInicio  IS STRING (9); */ 
   /*  DDMMYYYY  */
     char szhFecFin    [9]     ;   /* EXEC SQL VAR szhFecFin     IS STRING (9); */ 
   /*  DDMMYYYY  */
     int  ihCod_tipdocumalm    ;
     char szhCodOficina[3]     ;
     char szhDesOficina[3]     ;
     /* VARCHAR szahCod_Oficina [MAX_REGISTROS][3]; */ 
struct { unsigned short len; unsigned char arr[6]; } szahCod_Oficina[500];

     /* VARCHAR szahDes_Oficina [MAX_REGISTROS][41]; */ 
struct { unsigned short len; unsigned char arr[42]; } szahDes_Oficina[500];

/* EXEC SQL END DECLARE SECTION; */ 


GHISTDOCU stGHistDocu;

    vDTrazasLog ( modulo,"\n\t\t** Funcion bfnLlenaArchivoImpresion  **",LOG04);

    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   ,szFecFin)  ;
    strcpy(szDia_Aux,"\0");

    memset(szahCod_Oficina,0,sizeof(szahCod_Oficina));

    /* EXEC SQL
    SELECT COD_OFICINA      ,
           DES_OFICINA
    INTO   :szahCod_Oficina ,
           :szahDes_Oficina
    FROM   GE_OFICINAS
    WHERE  COD_OFICINA IN (SELECT COD_OFICINA FROM FAT_DETLIBROIVA
                           WHERE FEC_EMISION >= TO_DATE(:szhFecInicio,'ddmmyyyy')
                           AND   FEC_EMISION < TO_DATE(:szhFecFin,'ddmmyyyy'))
    ORDER BY COD_REGION, COD_COMUNA , COD_OFICINA ASC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA ,DES_OFICINA into :b0,:b1  from GE_OFI\
CINAS where COD_OFICINA in (select COD_OFICINA  from FAT_DETLIBROIVA where (FE\
C_EMISION>=TO_DATE(:b2,'ddmmyyyy') and FEC_EMISION<TO_DATE(:b3,'ddmmyyyy'))) o\
rder by COD_REGION,COD_COMUNA,COD_OFICINA asc  ";
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )716;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szahCod_Oficina;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )8;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szahDes_Oficina;
    sqlstm.sqhstl[1] = (unsigned long )43;
    sqlstm.sqhsts[1] = (         int  )44;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[2] = (unsigned long )9;
    sqlstm.sqhsts[2] = (         int  )9;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecFin;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )9;
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




    iCant_Regs = SQLROWS;


    vDTrazasLog ( modulo,"\n\t** Cantidad de Registros en LlenaArchivoImpresion  [%d]**",LOG06,iCant_Regs);
    vDTrazasLog ( modulo,"\t** SQLCODE  en LlenaArchivoImpresion  [%d]**",LOG06,SQLCODE);

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)   {
		vDTrazasError(modulo,"\n\t<< Error en Select de Codigos de Oficina >>\n\t",LOG01);
		vDTrazasLog  (modulo,"\n\t<< Select de Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }
    if ((SQLCODE == SQLNOTFOUND) && (iCant_Regs == 0))  {
		vDTrazasError(modulo,"\n\t<< No Existen Codigos de Oficina >>\n\t",LOG01);
		vDTrazasLog  (modulo,"\n\t<< No Existen Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

    for (i=0;i<iCant_Regs;i++)   {

        memset(&stTotTipDoc   ,0,sizeof(GTOTTIPDOCUM)*NUM_TIPDOCUM);
        memset(&stAcumulador  ,0,sizeof(GACUMULADOR ));

        memset(szhCodOficina,0,sizeof(szhCodOficina));
        sprintf(szhCodOficina,"%.*s\0",szahCod_Oficina[i].len, szahCod_Oficina[i].arr);

        memset(szhDesOficina,0,sizeof(szhDesOficina));
        sprintf(szhDesOficina,"%.*s\0",szahDes_Oficina[i].len, szahDes_Oficina[i].arr);

        vDTrazasLog ( modulo,"\n\t** szhCodOficina  [%s %s]**",LOG06,szhCodOficina,szhDesOficina);

        for (iDoc=1;iDoc<6;iDoc++) {
            lCon_Reg = 0 ;
        	switch(iDoc) 	{
        		case 1 :
        			ihCod_tipdocumalm = 28; break;
        		case 2 :
        			ihCod_tipdocumalm = 47; break;
        		case 3 :
        			ihCod_tipdocumalm = 25; break;
        		case 4 :
        			ihCod_tipdocumalm = 45; break;
        		case 5 :
        			ihCod_tipdocumalm = 46; break;
        	}

        	memset(szCadenaSQL,0,sizeof(szCadenaSQL));
            sprintf(szCadenaSQL,"%s\tSELECT COD_TIPDOCUMALM,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       NUM_FOLIO,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       COD_OFICINA,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       IND_ANULADA,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       IND_ORDENTOTAL,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       COD_TIPDOCUM,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TO_CHAR(FEC_EMISION,'dd/mm/yyyy'),\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       NUM_IDENTTRIB,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       NOM_CLIENTE,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TOT_NETOGRAV,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TOT_NETONOGRAV,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TOT_IVA,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TOT_FACTURA,\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TO_CHAR(FEC_EMISION,'DD'),\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\t       TO_CHAR(FEC_EMISION,'mm/yyyy')\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\tFROM   FAT_DETLIBROIVA\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\tWHERE  FEC_EMISION  >= TO_DATE('%s','ddmmyyyy') \n",szCadenaSQL,szhFecInicio);
            sprintf(szCadenaSQL,"%s\tAND    FEC_EMISION  < TO_DATE('%s','ddmmyyyy')\n",szCadenaSQL,szhFecFin);
            sprintf(szCadenaSQL,"%s\tAND    COD_TIPDOCUMALM = %d\n",szCadenaSQL,ihCod_tipdocumalm);
            sprintf(szCadenaSQL,"%s\tAND    COD_OFICINA     = '%s'\n",szCadenaSQL,szhCodOficina);
            sprintf(szCadenaSQL,"%s\tAND    IND_DUPLICADO   = 'N'\n",szCadenaSQL);
            sprintf(szCadenaSQL,"%s\tORDER BY 14 asc, 2 \n",szCadenaSQL);


            vDTrazasLog ( modulo,"\n\t** Cadena Sql **\n%s\n",LOG04,szCadenaSQL);

        	/* EXEC SQL PREPARE stLibroIva FROM :szCadenaSQL; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 17;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )747;
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


        	if (SQLCODE != SQLOK) {
        		vDTrazasError(modulo,"\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

         	/* EXEC SQL DECLARE  CursorLibroIva CURSOR for stLibroIva; */ 

        	if (SQLCODE != SQLOK) {
        		vDTrazasError(modulo,"\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

        	/* EXEC SQL OPEN CursorLibroIva ; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 17;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )766;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqcmod = (unsigned int )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        	if (SQLCODE != SQLOK) {
        		vDTrazasError(modulo,"\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

            memset(&stGHistDocu,0,sizeof(GHISTDOCU));
            iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);

            if (iSqlLibroIva==SQLOK)  {
                strcpy(szDia_Aux,stGHistDocu.szDia_Emision);
                lFolio_Desde    = stGHistDocu.lNumFolio;
                lFolio_Hasta    = stGHistDocu.lNumFolio;
                lFolio_Anterior = stGHistDocu.lNumFolio;
            }

            while (iSqlLibroIva == SQLOK) {
                if (stGHistDocu.iIndAnulada != iDocAnulado ) bfnAcumulaDocumentoFinal(iDoc,stGHistDocu);
                if (stGHistDocu.iIndAnulada != iDocAnulado ) bfnAcumulaDocumento(iDoc,stGHistDocu);

                if ((strlen(szBuffer)+1+MAX_LARGOREGISTRO) >= MAX_SIZEBUFFER) {
                    if (!bfnEscribeLibro ( szBuffer,iNumPag,iDoc,stLineaComando.iMes, stLineaComando.iAno,szhCodOficina,szhDesOficina))
                        return (FALSE);
                    else
                        iNumPag++;
                }

                if (stGHistDocu.iIndAnulada != iDocAnulado ) {
                    bfnEscribeBuffer(iDoc, stGHistDocu, &iCargaFile);
                    lCon_Reg++;lTot_Reg++;
                }

                iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);

                if (iDoc > 3) 
                {
                	vDTrazasLog  (modulo,"\t\t\t-->>>> lFolio_Anterior.......[%ld]",LOG05,lFolio_Anterior);
               		vDTrazasLog  (modulo,"\t\t\t-->>>> lNumFolio      .......[%ld]",LOG05,stGHistDocu.lNumFolio);

                    /* carga los datos acumulados al buffer si documento esta anulado */
                    if ((stGHistDocu.iIndAnulada == iDocAnulado ) && (iCargaFile==0)  ) {
                         bfnCargaBoletas(iDoc, stGHistDocu);
                         iSqlLibroIva  = bfnFetchLibroIva(&stGHistDocu);
                         lFolio_Desde  = stGHistDocu.lNumFolio;
                         lFolio_Hasta  = stGHistDocu.lNumFolio;
                         strcpy(szDia_Aux,stGHistDocu.szDia_Emision);
                         iCargaFile=1;
                    }

                    /* si los folios no son correlativos */
                    if ((lFolio_Anterior+1 != stGHistDocu.lNumFolio) && (iCargaFile==0) ) {
                         bfnCargaBoletas(iDoc, stGHistDocu);
                         lFolio_Desde   = stGHistDocu.lNumFolio;
                         lFolio_Hasta   = stGHistDocu.lNumFolio;
                         strcpy(szDia_Aux,stGHistDocu.szDia_Emision);
                         iCargaFile=1;
                    }

                    lFolio_Anterior = stGHistDocu.lNumFolio;

                    /* si el ultimo dia tiene un solo registro */
                    if ((iSqlLibroIva == SQLNOTFOUND ) && (dTotDocumentoBol>0)  ) bfnCargaBoletas(iDoc, stGHistDocu);

                }

            }


        	if ((iSqlLibroIva != SQLOK ) && (iSqlLibroIva != SQLNOTFOUND )) return (FALSE);

        	if (!bfnCloseFat_DetLibroIva())
            	return (FALSE);


            if (lCon_Reg > 0) {

                if (strlen(szBuffer) > 0 )	{
            	    if (!bfnEscribeLibro(szBuffer,iNumPag,iDoc,stLineaComando.iMes,stLineaComando.iAno,szhCodOficina,szhDesOficina))
               		    return (FALSE);
            		else
                		iNumPag++;
                }

           		vDTrazasLog  (modulo,"\t\t  Entra a Escribe Tot Docum por iDoc.......",LOG06);
            	if (!bfnEscribeTotDocum(iDoc))
                	return (FALSE);

            }
        } /*end for 2*/

    }   /*end for 1*/


    if (lTot_Reg > 0) {
        vDTrazasLog ( modulo,"\t\t** Funcion EscribeTotLibro  **",LOG05);
        if (!bfnEscribeTotLibro(stLineaComando.iMes,stLineaComando.iAno))
            return (FALSE);

        vDTrazasLog ( modulo,"\t\t** Funcion EscribeEstadisticas  **",LOG05);
        vfnEscribeEstadisticas();
    }

    vDTrazasLog ( modulo,"\n\t** Fin Funcion Llena Archivo de Impresion OK **",LOG04);
	return TRUE ;
}

/****************************************************************************/
/*                         Funcion bfnFetchLibroIva                         */
/****************************************************************************/
static int bfnFetchLibroIva( GHISTDOCU *stGHistDocu)
{
char modulo[]="bfnFetchLibroIva";

/* EXEC SQL BEGIN DECLARE SECTION ; */ 

    int    ihCod_tipdocumalm   ;
    long   lhNum_folio         ;
    char   szhCod_oficina  [3] ; /* EXEC SQL VAR szhCod_oficina IS STRING (3); */ 

    int    ihInd_anulada       ;
    long   lhInd_ordentotal    ;
    int    ihCod_tipdocum      ;
    char   szhFec_emision  [15]; /* EXEC SQL VAR szhFec_emision IS STRING (15); */ 

    char   szhNum_identtrib[21]; /* EXEC SQL VAR szhNum_identtrib IS STRING (21); */ 

    char   szhNom_cliente  [60]; /* EXEC SQL VAR szhNom_cliente IS STRING (60); */ 

    char   szhDia_Emision  [3] ; /* EXEC SQL VAR szhDia_Emision IS STRING (3); */ 

    char   szhMesAno       [8] ; /* EXEC SQL VAR szhMesAno IS STRING (8); */ 

    double dhTot_netograv      ;
    double dhTot_netonograv    ;
    double dhTot_iva           ;
    double dhTot_factura       ;
/* EXEC SQL END DECLARE SECTION   ; */ 



    vDTrazasLog ( modulo,"\n\t** Funcion bfnFetchLibroIva  **",LOG05);

	/* EXEC SQL
	FETCH  CursorLibroIva INTO
           :ihCod_tipdocumalm,
           :lhNum_folio      ,
           :szhCod_oficina   ,
           :ihInd_anulada    ,
           :lhInd_ordentotal ,
           :ihCod_tipdocum   ,
           :szhFec_emision   ,
           :szhNum_identtrib ,
           :szhNom_cliente   ,
           :dhTot_netograv   ,
           :dhTot_netonograv ,
           :dhTot_iva        ,
           :dhTot_factura    ,
           :szhDia_Emision   ,
           :szhMesAno        ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )781;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_tipdocumalm;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_folio;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCod_oficina;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihInd_anulada;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhInd_ordentotal;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_tipdocum;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFec_emision;
 sqlstm.sqhstl[6] = (unsigned long )15;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhNum_identtrib;
 sqlstm.sqhstl[7] = (unsigned long )21;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNom_cliente;
 sqlstm.sqhstl[8] = (unsigned long )60;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&dhTot_netograv;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&dhTot_netonograv;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&dhTot_iva;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&dhTot_factura;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhDia_Emision;
 sqlstm.sqhstl[13] = (unsigned long )3;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhMesAno;
 sqlstm.sqhstl[14] = (unsigned long )8;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
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



    vDTrazasLog ( modulo,"\n\t** SQLCODE EN bfnFetchLibroIva [%d] **",LOG06,SQLCODE);

	if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND)) {
		vDTrazasError(modulo,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

	if (SQLCODE == SQLNOTFOUND) {
		vDTrazasLog  (modulo,"\n\t<< Fin de Registros en CursorLibroIva >>", LOG03);
	    return SQLCODE;
	}


    vDTrazasLog ( modulo,"\n\t\t** Datos del FetchLibroIva (Impresion)**",LOG04);
    vDTrazasLog ( modulo,"\t\t** szhFec_emision......[%s]",LOG04,szhFec_emision);
    vDTrazasLog ( modulo,"\t\t** szhNom_cliente......[%s]",LOG04,szhNom_cliente);
    vDTrazasLog ( modulo,"\t\t** szhNum_identtrib....[%s]",LOG04,szhNum_identtrib);
    vDTrazasLog ( modulo,"\t\t** szhCod_oficina......[%s]",LOG04,szhCod_oficina);
    vDTrazasLog ( modulo,"\t\t** lhNum_folio.........[%ld]",LOG04,lhNum_folio);
    vDTrazasLog ( modulo,"\t\t** dhTot_netonograv....[%f]",LOG04,dhTot_netonograv);
    vDTrazasLog ( modulo,"\t\t** dhTot_netograv......[%f]",LOG04,dhTot_netograv);
    vDTrazasLog ( modulo,"\t\t** dhTot_iva...........[%f]",LOG04,dhTot_iva);
    vDTrazasLog ( modulo,"\t\t** dhTot_factura.......[%f]",LOG04,dhTot_factura);
    vDTrazasLog ( modulo,"\t\t** ihInd_anulada.......[%d]",LOG04,ihInd_anulada);
    vDTrazasLog ( modulo,"\t\t** ihCod_tipdocumalm...[%d]",LOG04,ihCod_tipdocumalm);
    vDTrazasLog ( modulo,"\t\t** szhCod_oficina......[%s]",LOG04,szhCod_oficina);
    vDTrazasLog ( modulo,"\t\t** szDia_Emision.......[%s]",LOG04,szhDia_Emision);
    vDTrazasLog ( modulo,"\t\t** szhMesAno...........[%s]",LOG04,szhMesAno);


    strcpy(stGHistDocu->szFecEmision ,szhFec_emision);
    strcpy(stGHistDocu->szNomCliente ,szhNom_cliente);
    strcpy(stGHistDocu->szRut        ,szhNum_identtrib);
    strcpy(stGHistDocu->szCod_Oficina,szhCod_oficina);
    strcpy(stGHistDocu->szDia_Emision,szhDia_Emision);
    strcpy(stGHistDocu->szMesAno,szhMesAno);

    stGHistDocu->lNumFolio       = lhNum_folio      ;
    stGHistDocu->dAcumNetoNoGrav = dhTot_netonograv ;
    stGHistDocu->dAcumNetoGrav   = dhTot_netograv   ;
    stGHistDocu->dAcumIva        = dhTot_iva        ;
    stGHistDocu->dTotDocumento   = dhTot_factura    ;
    stGHistDocu->iIndAnulada     = ihInd_anulada    ;
    stGHistDocu->iCod_tipdocumalm= ihCod_tipdocumalm;


    return SQLCODE;

}
/****************************************************************************/
/*                         funcion : bfnCloseFat_DetLibroIva                     */
/****************************************************************************/
static BOOL bfnCloseFat_DetLibroIva()
{
	char modulo[]="bfnCloseDocumentos";

    vDTrazasLog (modulo,"\n\t** Close Cursor LibroIva " ,LOG04);

	/* EXEC SQL CLOSE CursorLibroIva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )856;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)    {
        vDTrazasLog  (modulo,"<< Error en Close Close Cursor LibroIva >>"
                                ,LOG01);
        vDTrazasError(modulo,"<< Error en Close Close Cursor LibroIva >>\n\t[%d] : [%s]"
                                ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/*********************** Final bfnCloseFat_DetLibroIva  *************************/


/****************************************************************************/
/*                         Funcion bfnEscribeBuffer                         */
/****************************************************************************/
static void bfnEscribeBuffer(int iDoc, GHISTDOCU  pstGHistDocu, int *iCargaFile)
{
char modulo[]="bfnEscribeBuffer";
static char szaux1[MAX_LARGOREGISTRO];
static char szaux2[MAX_LARGOREGISTRO];


    vDTrazasLog  (modulo,"\n\t** Escribe en Buffer (bfnEscribeBuffer)  **",LOG02);

    vDTrazasLog(modulo,"\tDatos . \n\tFecha Emision  : %s\n\tNum Folio      : %10ld\n"
            "\tNom Cliente    : %s\n\tRut            : %s\n\tNeto no grav   :%f\n\tNeto Grav      :%f\n"
            "\tAcum Iva       :%f\n\tTot Documento  : %f\n\tDia Emision    : %s",LOG04,
            pstGHistDocu.szFecEmision   ,pstGHistDocu.lNumFolio ,pstGHistDocu.szNomCliente ,
            pstGHistDocu.szRut          ,pstGHistDocu.dAcumNetoNoGrav,pstGHistDocu.dAcumNetoGrav  ,
            pstGHistDocu.dAcumIva       ,pstGHistDocu.dTotDocumento ,pstGHistDocu.szDia_Emision );


    if ((iDoc == iTipBoleta) || (iDoc == iTipBoletaExen)) {
        vDTrazasLog  (modulo,"\t\t** Dia_Emision [%s] **",LOG04,pstGHistDocu.szDia_Emision);

         *iCargaFile = 0;

        if (strcmp(szDia_Aux,pstGHistDocu.szDia_Emision)==0){
            vDTrazasLog  (modulo,"\t\t** Cargando montos **",LOG06);
            dTotNetoNoGravBol +=  pstGHistDocu.dAcumNetoNoGrav;
            dTotNetoGravBol   +=  pstGHistDocu.dAcumNetoGrav  ;
            dTotIvaBol        +=  pstGHistDocu.dAcumIva       ;
            dTotDocumentoBol  +=  pstGHistDocu.dTotDocumento  ;

        } else {

           vDTrazasLog  (modulo,"\n\t\t** Dia de Emision [%s] es distinto del Dia_Aux [%s].**",LOG04,pstGHistDocu.szDia_Emision,szDia_Aux);
           if (dTotDocumentoBol>0) {
               bfnCargaBoletas(iDoc, pstGHistDocu);
               *iCargaFile = 1;
           }

           lFolio_Desde = pstGHistDocu.lNumFolio;
           strcpy(szDia_Aux,pstGHistDocu.szDia_Emision);

           dTotNetoNoGravBol =  pstGHistDocu.dAcumNetoNoGrav;
           dTotNetoGravBol   =  pstGHistDocu.dAcumNetoGrav  ;
           dTotIvaBol        =  pstGHistDocu.dAcumIva       ;
           dTotDocumentoBol  =  pstGHistDocu.dTotDocumento  ;


        }

        lFolio_Hasta = pstGHistDocu.lNumFolio;


    } else {
        sprintf(szaux1,"%-10s %10ld %-60s %12s   %15.0f  %15.0f  %15.0f  %15.0f",  /*  Largo de Registros 164 < 170 bytes */
                pstGHistDocu.szFecEmision   ,
                pstGHistDocu.lNumFolio      ,
                pstGHistDocu.szNomCliente   ,
                pstGHistDocu.szRut          ,
                pstGHistDocu.dAcumNetoNoGrav,
                pstGHistDocu.dAcumNetoGrav  ,
                pstGHistDocu.dAcumIva       ,
                pstGHistDocu.dTotDocumento  );
        /************************************************/
        /*  Formatea la Linea a 200 bytes   199 + \n    */
        /************************************************/
        sprintf(szaux2,"%-199s\n",szaux1);
        strcat(szBuffer, szaux2);
    }
    return;
}/***********************   Final bfnEscribeBuffer   ********************/



/****************************************************************************/
/*                         Funcion bfnCargaBoletas                         */
/****************************************************************************/
static void bfnCargaBoletas(int iDoc, GHISTDOCU  pstGHistDocu)
{
char modulo[]="bfnCargaBoletas";
static char szaux1[MAX_LARGOREGISTRO];
static char szaux2[MAX_LARGOREGISTRO];

vDTrazasLog  (modulo,"\n\t** bfnCargaBoletas.**",LOG05);

   sprintf(szaux1,"%2s/%7s  %16ld %33ld %33s  %15.0f  %15.0f  %15.0f  %15.0f",
                   szDia_Aux,pstGHistDocu.szMesAno   ,  lFolio_Desde    , lFolio_Hasta   ," ",
                   dTotNetoNoGravBol,  dTotNetoGravBol  ,
                   dTotIvaBol       ,  dTotDocumentoBol);
   vDTrazasLog(modulo,"[%s/%s] [%ld] [%ld] [%15.0f] [%15.0f] [%15.0f] [%15.0f]",LOG04,
                   szDia_Aux,pstGHistDocu.szMesAno ,  lFolio_Desde    , lFolio_Hasta   ,
                   dTotNetoNoGravBol,  dTotNetoGravBol  ,
                   dTotIvaBol       ,  dTotDocumentoBol);

   sprintf(szaux2,"%-199s\n",szaux1);
   strcat(szBuffer, szaux2);

   dTotNetoNoGravBol =  0;
   dTotNetoGravBol   =  0;
   dTotIvaBol        =  0;
   dTotDocumentoBol  =  0;

   return;
}/***********************   Final bfnCargaBoletas   ********************/



/************************************************************************/
/*  Escribe el contenido de buffer un fichero de Datos                  */
/************************************************************************/

static BOOL bfnEscribeLibro(char *szBuf, int iPag, int iTipDoc,int iMesAux, int iAnoAux, char *szCodOficina,char *szDesOficina)
{
char modulo[]="bfnEscribeLibro";
int  retprint ;

    vDTrazasLog  (modulo,"\n\t** Escribe en Archivo (bfnEscribeLibro)  **",LOG05);

    if (strlen(szBuf) == 0)
        return (TRUE);

    if (!bfnEscribeCab(iPag, iTipDoc, iMesAux, iAnoAux, szCodOficina,szDesOficina))
        return (FALSE);


    if ( (retprint= fprintf(stLineaComando.fpDat,szBuf)) <= 0 )   {
        vDTrazasLog  (modulo,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);
        vDTrazasError(modulo,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);

        memset(szBuf,0,sizeof(szBuf));
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat); */
    memset(szBuf,0,sizeof(szBuf));
    return (TRUE);
}/******************* Final bfnEscribeFich **************************/







/************************************************************************/
/*  Escribe la cabecera de cada Pagina                                  */
/************************************************************************/
static BOOL bfnEscribeCab(int iPag, int iTipDoc, int iMesAux, int iAnoAux, char *szCodOficina, char *szDesOficina)
{
char modulo[]="bfnEscribeCab";
static int  retprint                                            ;
static char szCabecera [MAX_LARGOREGISTRO*LINEAS_CABECERA]  = "";
static char szlinaux1  [MAX_LARGOREGISTRO]               = "";
static char szlinaux2  [MAX_LARGOREGISTRO]               = "";
static char szVacio    [1]                                  = "";

    vDTrazasLog  (modulo,"\n\t** Escribe Cabecera en Archivo (bfnEscribeCab)  **",LOG05);

    /********************************************************************/
    /* Creacion de la Cabecera                                          */
    /********************************************************************/

    sprintf(szlinaux1,"\f\n\t\t\t\t\t\t\t\tLIBRO DE VENTAS DE %s DEL %d"
                ,szNombreMes[iMesAux-1],iAnoAux);
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    sprintf(szlinaux1,"  Rep.    : %-s %105s Pag.Nro. %10d",szNomRepLegal,szVacio,iPag);
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    sprintf(szlinaux1,"  Rut     : %-s ",szRutRepLegal);
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    sprintf(szlinaux1,"  Oficina : %s  %s",szCodOficina,szDesOficina);
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    strcpy (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);


    if ((iTipDoc == iTipBoleta) || (iTipDoc == iTipBoletaExen)) {
        sprintf(szlinaux1,"%10s %17s %33s %49s %17s %16s %16s"
                         ,"Fecha","Folio Desde","Folio Hasta","Exento","Afecto","Iva","Total");
        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

        /*sprintf(szlinaux1,"%23s %38s %47s ","Boletas Diarias","Folio Desde","Folio Hasta");
        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);*/

        strcpy (szlinaux1,"-------------------------------------------------------");
        strcat (szlinaux1,"-------------------------------------------------------");
        strcat (szlinaux1,"-------------------------------------------------------");
        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);


    } else {
        sprintf(szlinaux1,"%10s %10s %10s %58s %20s %17s %16s %16s"
                         ,"Fecha","Folio","Nombre","Rut","Exento","Afecto","Iva","Total");
        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);

        strcpy (szlinaux1,"-------------------------------------------------------");
        strcat (szlinaux1,"-------------------------------------------------------");
        strcat (szlinaux1,"-------------------------------------------------------");
        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szCabecera, szlinaux2);
    }

    if (strlen(szCabecera) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szCabecera)) <= 0 )
    {
        vDTrazasLog  (modulo,   "\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,   "\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat); */
    memset(szCabecera,0,sizeof(szCabecera));
    return (TRUE);
}/********************* Final bfnEscribeCab   **************************/


/****************************************************************************/
/*                        Funcion bfnAcumulaDocumento                       */
/****************************************************************************/
static void bfnAcumulaDocumento(int iTipDocumento, GHISTDOCU pstGHistDocu )
{
char modulo[]="bfnAcumulaDocumento";

    vDTrazasLog  (modulo,"\n\t** Acumulando Documento : %s (bfnAcumulaDocumento)**"
                             "\n\t\t==>  Folio   [%ld]"
                            ,LOG05,szNombreDocs[iTipDocumento],pstGHistDocu.lNumFolio);

    if (pstGHistDocu.iIndAnulada == iDocOk)
        stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosOk++;
    else
        stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosAnul++;

    stTotTipDoc[pstGHistDocu.iCodTipDocum].dNetoDocumentos   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dExentoDocumentos += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dIvaDocumentos    += pstGHistDocu.dAcumIva        ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dTotalDocumentos  += pstGHistDocu.dAcumNetoGrav   +
                                                                pstGHistDocu.dAcumNetoNoGrav +
                                                                pstGHistDocu.dAcumIva ;

    /* stTotTipDoc[pstGHistDocu.iCodTipDocum].dTotalDocumentos  += pstGHistDocu.dTotDocumento   ; */

	switch(iTipDocumento)
	{
		case iTipFactura :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
	    	    {
	    	        stAcumulador.lNumFactAnul++;
				}
	        	stAcumulador.lNumFacturas       ++                               ;
	        	stAcumulador.dNetoFacturas      +=  pstGHistDocu.dAcumNetoGrav   ;
	        	stAcumulador.dExentoFacturas    +=  pstGHistDocu.dAcumNetoNoGrav ;
	        	stAcumulador.dIvaFacturas       +=  pstGHistDocu.dAcumIva        ;
	        	stAcumulador.dTotalFacturas     +=  pstGHistDocu.dAcumNetoGrav   +
	            	                                pstGHistDocu.dAcumNetoNoGrav +
	                	                            pstGHistDocu.dAcumIva        ;
	        	/* stAcumulador.dTotalFacturas  +=  pstGHistDocu.dTotDocumento   ; */
	        	break;

	    case iTipFacturaExen :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
	    	    {
	    	        stAcumulador.lNumFactAnulExen++;
				}
	        	stAcumulador.lNumFacturasExen       ++                               ;
	        	stAcumulador.dNetoFacturasExen      +=  pstGHistDocu.dAcumNetoGrav   ;
	        	stAcumulador.dExentoFacturasExen    +=  pstGHistDocu.dAcumNetoNoGrav ;
	        	stAcumulador.dIvaFacturasExen       +=  pstGHistDocu.dAcumIva        ;
	        	stAcumulador.dTotalFacturasExen     +=  pstGHistDocu.dAcumNetoGrav   +
	            	                           		    pstGHistDocu.dAcumNetoNoGrav +
	                	                            	pstGHistDocu.dAcumIva        ;
	        	/* stAcumulador.dTotalFacturasExen  +=  pstGHistDocu.dTotDocumento   ; */
	        	break;

    	case iTipNotaCred :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
        		{
        			stAcumulador.lNumNotCredAnul++;
        		}
		        stAcumulador.lNumNotCredito      ++                              ;
    		    stAcumulador.dNetoNotCredito     += pstGHistDocu.dAcumNetoGrav   ;
    		    stAcumulador.dExentoNotCredito   += pstGHistDocu.dAcumNetoNoGrav ;
        		stAcumulador.dIvaNotCredito      += pstGHistDocu.dAcumIva        ;
        		stAcumulador.dTotalNotCredito    += pstGHistDocu.dAcumNetoGrav   +
                		                            pstGHistDocu.dAcumNetoNoGrav +
                        		                    pstGHistDocu.dAcumIva        ;
           		/* stAcumulador.dTotalNotCredito += pstGHistDocu.dTotDocumento   ;*/
    			break;

		case iTipBoleta :
				if (pstGHistDocu.iIndAnulada == iDocAnulado)
	            {
	            	stAcumulador.lNumBoletaAnul++;
	            }
		        stAcumulador.lNumBoleta      ++                              ;
		        stAcumulador.dNetoBoleta     += pstGHistDocu.dAcumNetoGrav   ;
	    	    stAcumulador.dExentoBoleta    =  0						  	 ;
	        	stAcumulador.dIvaBoleta      += pstGHistDocu.dAcumIva        ;
	        	stAcumulador.dTotalBoleta    += pstGHistDocu.dAcumNetoGrav   +
	        								    pstGHistDocu.dAcumIva        ;
	        	/* stAcumulador.dTotalBoleta += pstGHistDocu.dTotDocumento   ;*/
				break;

    	case iTipBoletaExen :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumulador.lNumBoletaExenAnul++;
	        	}
		        stAcumulador.lNumBoletaExen      ++                               ;
		        stAcumulador.dNetoBoletaExen      =  0							  ;
	    	    stAcumulador.dExentoBoletaExen   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumulador.dIvaBoletaExen       =  0							  ;
	        	stAcumulador.dTotalBoletaExen    += pstGHistDocu.dAcumNetoNoGrav  ;
	        	/* stAcumulador.dTotalBoletaExen += pstGHistDocu.dTotDocumento    ;*/
				break;

    }/* end switch */

    return;
}/*********************** Final bfnAcumulaDocumento *************************/



/************************************************************************/
/*  Escribe Total por Tipo de Documento                                 */
/************************************************************************/
static BOOL bfnEscribeTotDocum(int iTipDocumento)
{
    char modulo[]="bfnEscribeTotDocum";

    static int  retprint                                            ;
    static char szTotDocum  [MAX_LARGOREGISTRO*LINEAS_SUBTOTAL]= "" ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = "" ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = "" ;
    static char szVacio     [1]                                = "" ;
    static char szDia_Aux   [3]                                = "" ;
    static char szDia_Emi   [3]                                = "" ;

    vDTrazasLog  (modulo,"\n\t** Escribe Total por Documento : %s **",LOG04,szNombreDocs[iTipDocumento]);

    /********************************************************************/
    /* Creacion de la Total de Documento                                */
    /********************************************************************/

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);

	switch(iTipDocumento)
	{
    	case iTipFactura :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
    	                        ,"SUB-TOTAL FACTURAS AFECTAS"
        	                    ,stAcumulador.lNumFacturas
            	                ,szVacio
                    	        ,stAcumulador.dExentoFacturas
                	            ,stAcumulador.dNetoFacturas
                        	    ,stAcumulador.dIvaFacturas
                            	,stAcumulador.dTotalFacturas );
        	sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;

    	case iTipFacturaExen :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
    	                        ,"SUB-TOTAL FACTURAS EXENTAS"
        	                    ,stAcumulador.lNumFacturasExen
            	                ,szVacio
                    	        ,stAcumulador.dExentoFacturasExen
                	            ,stAcumulador.dNetoFacturasExen
                        	    ,stAcumulador.dIvaFacturasExen
                            	,stAcumulador.dTotalFacturasExen );
        	sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;


    	case iTipNotaCred :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL NOTAS DE CREDITO"
            	                ,stAcumulador.lNumNotCredito
                	            ,szVacio
                    	        ,stAcumulador.dExentoNotCredito
                        	    ,stAcumulador.dNetoNotCredito
                            	,stAcumulador.dIvaNotCredito
                            	,stAcumulador.dTotalNotCredito );
        	sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;

		case iTipBoleta :


            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETAS AFECTAS"
            	                ,stAcumulador.lNumBoleta
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoleta
                        	    ,stAcumulador.dNetoBoleta
                            	,stAcumulador.dIvaBoleta
                            	,stAcumulador.dTotalBoleta );
        	sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;

    	case iTipBoletaExen :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETAS EXENTAS"
            	                ,stAcumulador.lNumBoletaExen
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoletaExen
                        	    ,stAcumulador.dNetoBoletaExen
                            	,stAcumulador.dIvaBoletaExen
                            	,stAcumulador.dTotalBoletaExen );
        	sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;


    } /*end switch */

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotDocum, szlinaux2);

    if (strlen(szTotDocum) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szTotDocum)) <= 0 )
    {
        vDTrazasLog  (modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat);*/
    memset(szTotDocum,0,sizeof(szTotDocum));
    return (TRUE);
}/********************* Final bfnEscribeTotDocum ************************/

/************************************************************************/
/*  Funcion: bfnEscribeTotLibro(int, int)                               */
/************************************************************************/
/*  Escribe Total de Libro de Venta                                     */
/************************************************************************/

static BOOL bfnEscribeTotLibro(int iMesAux, int iAnoAux)
{
    char modulo[]="bfnEscribeTotLibro";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    int     ihMes   = iMesAux       ;
    int     ihAno   = iAnoAux       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    static int  retprint                                                ;
    static char szTotLibro  [MAX_LARGOREGISTRO*LINEAS_TATALIZADOR]= ""  ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = ""     ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = ""     ;
    static char szVacio     [1]                                = ""     ;

    int     iNUMORDEN       [10];
    int     iINDLIBRO       [10];
    char    szDESAUXILIAR   [10][45];
    int     iNUMREGISTROS   [10];
    double  dIMPEXENTO      [10];
    double  dIMPAFECTO      [10];
    double  dIMPIVA         [10];
    double  dIMPTOTAL       [10];
    int     iFilasAux           ;
    int     iInd                ;

    double  dTGenExento     = 0 ;
    double  dTGenAfecto     = 0 ;
    double  dTGenIVA        = 0 ;
    double  dTGenLibro      = 0 ;



    vDTrazasLog  (modulo,   "\n\t** Escribe Total de Libro  **"
                                "\n\t\t==>  Mes   [%d]"
                                "\n\t\t==>  Ano   [%d]"
                                ,LOG04,iMesAux,iAnoAux);

    /********************************************************************/
    /* Carga Datos Auxiliares desde FA_LIBROVTAAUX                      */
    /********************************************************************/
    /* EXEC SQL SELECT DES_AUXILIAR   ,NUM_REGISTROS   ,
                    IMP_EXENTO     ,IMP_AFECTO      ,
                    IMP_IVA        ,IMP_TOTAL
            INTO    :szDESAUXILIAR ,:iNUMREGISTROS  ,
                    :dIMPEXENTO    ,:dIMPAFECTO     ,
                    :dIMPIVA       ,:dIMPTOTAL
            FROM    FA_LIBROVTAAUX
            WHERE   COD_MES     = :ihMes
            AND     COD_ANO     = :ihAno
            ORDER BY NUM_ORDEN; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DES_AUXILIAR ,NUM_REGISTROS ,IMP_EXENTO ,IMP_AFECT\
O ,IMP_IVA ,IMP_TOTAL into :b0,:b1,:b2,:b3,:b4,:b5  from FA_LIBROVTAAUX where \
(COD_MES=:b6 and COD_ANO=:b7) order by NUM_ORDEN ";
    sqlstm.iters = (unsigned int  )10;
    sqlstm.offset = (unsigned int  )871;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szDESAUXILIAR;
    sqlstm.sqhstl[0] = (unsigned long )45;
    sqlstm.sqhsts[0] = (         int  )45;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)iNUMREGISTROS;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)dIMPEXENTO;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )sizeof(double);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)dIMPAFECTO;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)dIMPIVA;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )sizeof(double);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)dIMPTOTAL;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )sizeof(double);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihMes;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihAno;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )sizeof(int);
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


    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (modulo,"\n\t** Error en Select de FA_LIBROVTAAUX (bfnEscribeTotLibro) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t** Error en Select de FA_LIBROVTAAUX (bfnEscribeTotLibro) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    iFilasAux = SQLROWS;
    vDTrazasLog  (modulo,"\n\t** Totales Auxiliares (bfnEscribeTotLibro) [%d] **"
                                ,LOG04,iFilasAux);


    /********************************************************************/
    /* Creacion de la Total de Libro de Venta                           */
    /********************************************************************/


    strcpy (szlinaux1,"\f=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1,"RESUMEN GENERAL");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalFacturas >= 0 ? "(+)" : "(-)")
                        ,"TOTAL FACTURAS AFECTAS "
                        ,stAcumuladorFinal.lNumFacturas
                        ,szVacio
                        ,stAcumuladorFinal.dExentoFacturas
                        ,stAcumuladorFinal.dNetoFacturas
                        ,stAcumuladorFinal.dIvaFacturas
                        ,stAcumuladorFinal.dTotalFacturas );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalFacturasExen >= 0 ? "(+)" : "(-)")
                        ,"TOTAL FACTURAS EXENTAS "
                        ,stAcumuladorFinal.lNumFacturasExen
                        ,szVacio
                        ,stAcumuladorFinal.dExentoFacturasExen
                        ,stAcumuladorFinal.dNetoFacturasExen
                        ,stAcumuladorFinal.dIvaFacturasExen
                        ,stAcumuladorFinal.dTotalFacturasExen );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalNotCredito >= 0 ? "(+)":"(-)")
                        ,"TOTAL NOTAS DE CREDITO"
                        ,stAcumuladorFinal.lNumNotCredito
                        ,szVacio
                        ,stAcumuladorFinal.dExentoNotCredito
                        ,stAcumuladorFinal.dNetoNotCredito
                        ,stAcumuladorFinal.dIvaNotCredito
                        ,stAcumuladorFinal.dTotalNotCredito );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalBoleta >= 0 ? "(+)":"(-)")
                        ,"TOTAL BOLETAS AFECTAS"
                        ,stAcumuladorFinal.lNumBoleta
                        ,szVacio
                        ,stAcumuladorFinal.dExentoBoleta
                        ,stAcumuladorFinal.dNetoBoleta
                        ,stAcumuladorFinal.dIvaBoleta
                        ,stAcumuladorFinal.dTotalBoleta );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalBoletaExen  >= 0 ? "(+)":"(-)")
                        ,"TOTAL BOLETAS EXENTAS"
                        ,stAcumuladorFinal.lNumBoletaExen /*rbr*/
                        ,szVacio
                        ,stAcumuladorFinal.dExentoBoletaExen
                        ,stAcumuladorFinal.dNetoBoletaExen
                        ,stAcumuladorFinal.dIvaBoletaExen
                        ,stAcumuladorFinal.dTotalBoletaExen );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalBoletaAmis  >= 0 ? "(+)":"(-)")
                        ,"TOTAL BOLETAS AMISTAR"
                        ,stAcumuladorFinal.lNumBoletaAmis
                        ,szVacio
                        ,stAcumuladorFinal.dExentoBoletaAmis
                        ,stAcumuladorFinal.dNetoBoletaAmis
                        ,stAcumuladorFinal.dIvaBoletaAmis
                        ,stAcumuladorFinal.dTotalBoletaAmis );

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


    dTGenExento     = 	stAcumuladorFinal.dExentoFacturas 	 +
    					stAcumuladorFinal.dExentoFacturasExen +
    					stAcumuladorFinal.dExentoNotCredito	 +
    					stAcumuladorFinal.dExentoBoleta  	 +
    					stAcumuladorFinal.dExentoBoletaExen	 +
    					stAcumuladorFinal.dExentoBoletaAmis	 ; /* rbr */

    dTGenAfecto     = 	stAcumuladorFinal.dNetoFacturas   	 +
    					stAcumuladorFinal.dNetoFacturasExen	 +
    					stAcumuladorFinal.dNetoNotCredito  	 +
    					stAcumuladorFinal.dNetoBoleta    	 +
    					stAcumuladorFinal.dNetoBoletaExen  	 +
    					stAcumuladorFinal.dNetoBoletaAmis  	 ; /* rbr */

    dTGenIVA        = 	stAcumuladorFinal.dIvaFacturas    	 +
    					stAcumuladorFinal.dIvaFacturasExen  	 +
    					stAcumuladorFinal.dIvaNotCredito   	 +
    					stAcumuladorFinal.dIvaBoleta    	     +
    					stAcumuladorFinal.dIvaBoletaExen   	 +
    					stAcumuladorFinal.dIvaBoletaAmis   	 ; /* rbr */

    dTGenLibro      = 	stAcumuladorFinal.dTotalFacturas  	 +
    					stAcumuladorFinal.dTotalFacturasExen	 +
    					stAcumuladorFinal.dTotalNotCredito 	 +
    					stAcumuladorFinal.dTotalBoleta    	 +
    					stAcumuladorFinal.dTotalBoletaExen 	 +
    					stAcumuladorFinal.dTotalBoletaAmis	 ; /* rbr */


    for (iInd=0;iInd<iFilasAux;iInd++)
    {
        sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                            ,(dIMPTOTAL      [iInd] >= 0 ? "(+)" : "(-)")
                            ,szDESAUXILIAR  [iInd]
                            ,iNUMREGISTROS  [iInd]
                            ,szVacio
                            ,dIMPEXENTO     [iInd]
                            ,dIMPAFECTO     [iInd]
                            ,dIMPIVA        [iInd]
                            ,dIMPTOTAL      [iInd]);

        sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

        dTGenExento     += dIMPEXENTO     [iInd];
        dTGenAfecto     += dIMPAFECTO     [iInd];
        dTGenIVA        += dIMPIVA        [iInd];
        dTGenLibro      += dIMPTOTAL      [iInd];
     }

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1   ,"%-97s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,"TOTAL GENERAL LIBRO VENTA"
                        ,dTGenExento
                        ,dTGenAfecto
                        ,dTGenIVA
                        ,dTGenLibro);

    sprintf(szlinaux2,"%-199s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


    if (strlen(szTotLibro) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szTotLibro)) <= 0 )
    {
        vDTrazasLog  (modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    fflush(stLineaComando.fpDat);
    memset(szTotLibro,0,sizeof(szTotLibro));
    return (TRUE);
}/********************* Final bfnEscribeTotLibro  ***********************/


/************************************************************************/
/*  Funcion: vfnEscribeEstadisticas(void)                               */
/************************************************************************/
/*  Escribe Total de Libro de Venta                                     */
/************************************************************************/

static void vfnEscribeEstadisticas(void)
{
    char modulo[]="vfnEscribeEstadisticas";

    int iInd;
    vDTrazasLog  (modulo,"\n===================================="
                             "======================================"
                            ,LOG05);
    vDTrazasLog  (modulo,"\n\t\t** Estadisticas del Libro de Venta **",LOG04);

    vDTrazasLog  (modulo,"\n===================================="
                             "======================================"
                            ,LOG05);

    for (iInd=0;iInd<NUM_TIPDOCUM;iInd++)
    {
        if ((stTotTipDocFin[iInd].lNumDocumentosAnulFinal+stTotTipDocFin[iInd].lNumDocumentosOkFinal) > 0)
        {
            vDTrazasLog  (modulo, "\n\t\t==> Tipo de Documento        [%15d]"
                                  "\n\t\t==> Documentos Anulados      [%15ld]"
                                  "\n\t\t==> Documentos Emitidos      [%15ld]"
                                  "\n\t\t==> Monto Exento             [%15.0f]"
                                  "\n\t\t==> Monto Afecto             [%15.0f]"
                                  "\n\t\t==> Monto Iva                [%15.0f]"
                                  "\n\t\t==> Monto Total              [%15.0f]"
                                  ,LOG04
                                  ,iInd
                                  ,stTotTipDocFin[iInd].lNumDocumentosAnulFinal
                                  ,stTotTipDocFin[iInd].lNumDocumentosOkFinal
                                  ,stTotTipDocFin[iInd].dExentoDocumentosFinal
                                  ,stTotTipDocFin[iInd].dNetoDocumentosFinal
                                  ,stTotTipDocFin[iInd].dIvaDocumentosFinal
                                  ,stTotTipDocFin[iInd].dTotalDocumentosFinal  );
        }
    }

    vDTrazasLog  (modulo,"\n======================================================================\n",LOG04);
    return;
}/********************* Final vfnEscribeEstadisticas  ***********************/


/****************************************************************************/
/*                        Funcion bfnAcumulaDocumentoFinal                       */
/****************************************************************************/
static void bfnAcumulaDocumentoFinal(int iTipDocumento, GHISTDOCU pstGHistDocu )
{
char modulo[]="bfnAcumulaDocumentoFinal";

    vDTrazasLog  (modulo,"\n\t** Acumulando Total Final Documento : %s (bfnAcumulaDocumentoFinal)**"
                             "\n\t\t==>  Folio   [%ld]"
                            ,LOG05,szNombreDocs[iTipDocumento],pstGHistDocu.lNumFolio);

    if (pstGHistDocu.iIndAnulada == iDocOk)
        stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosOkFinal++;
    else
        stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosAnulFinal++;

    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dNetoDocumentosFinal   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dExentoDocumentosFinal += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dIvaDocumentosFinal    += pstGHistDocu.dAcumIva        ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dTotalDocumentosFinal     += pstGHistDocu.dAcumNetoGrav   +
                                                                        pstGHistDocu.dAcumNetoNoGrav +
                                                                        pstGHistDocu.dAcumIva ;

    /* stTotTipDocFin[pstGHistDocu.iCodTipDocum].dTotalDocumentosFinal += pstGHistDocu.dTotDocumento   ; */

	switch(iTipDocumento)
	{
		case iTipFactura :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
	    	    {
	    	        stAcumuladorFinal.lNumFactAnul++;
				}
	        	stAcumuladorFinal.lNumFacturas       ++                               ;
	        	stAcumuladorFinal.dNetoFacturas      +=  pstGHistDocu.dAcumNetoGrav   ;
	        	stAcumuladorFinal.dExentoFacturas    +=  pstGHistDocu.dAcumNetoNoGrav ;
	        	stAcumuladorFinal.dIvaFacturas       +=  pstGHistDocu.dAcumIva        ;
	        	stAcumuladorFinal.dTotalFacturas     +=  pstGHistDocu.dAcumNetoGrav   +
	            	                                     pstGHistDocu.dAcumNetoNoGrav +
	                	                                 pstGHistDocu.dAcumIva        ;
	        	/* stAcumuladorFinal.dTotalFacturas  +=  pstGHistDocu.dTotDocumento   ; */
	        	break;

	    case iTipFacturaExen :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
	    	    {
	    	        stAcumuladorFinal.lNumFactAnulExen++;
				}
	        	stAcumuladorFinal.lNumFacturasExen       ++                               ;
	        	stAcumuladorFinal.dNetoFacturasExen      +=  pstGHistDocu.dAcumNetoGrav   ;
	        	stAcumuladorFinal.dExentoFacturasExen    +=  pstGHistDocu.dAcumNetoNoGrav ;
	        	stAcumuladorFinal.dIvaFacturasExen       +=  pstGHistDocu.dAcumIva        ;
	        	stAcumuladorFinal.dTotalFacturasExen     +=  pstGHistDocu.dAcumNetoGrav   +
	            	                           		    pstGHistDocu.dAcumNetoNoGrav +
	                	                            	pstGHistDocu.dAcumIva        ;
	        	/* stAcumuladorFinal.dTotalFacturasExen  +=  pstGHistDocu.dTotDocumento   ; */
	        	break;

    	case iTipNotaCred :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
        		{
        			stAcumuladorFinal.lNumNotCredAnul++;
        		}
		        stAcumuladorFinal.lNumNotCredito      ++                              ;
    		    stAcumuladorFinal.dNetoNotCredito     += pstGHistDocu.dAcumNetoGrav   ;
    		    stAcumuladorFinal.dExentoNotCredito   += pstGHistDocu.dAcumNetoNoGrav ;
        		stAcumuladorFinal.dIvaNotCredito      += pstGHistDocu.dAcumIva        ;
        		stAcumuladorFinal.dTotalNotCredito    += pstGHistDocu.dAcumNetoGrav   +
                		                            pstGHistDocu.dAcumNetoNoGrav +
                        		                    pstGHistDocu.dAcumIva        ;
           		/* stAcumuladorFinal.dTotalNotCredito += pstGHistDocu.dTotDocumento   ;*/
    			break;

		case iTipBoleta :
				if (pstGHistDocu.iIndAnulada == iDocAnulado)
	            {
	            	stAcumuladorFinal.lNumBoletaAnul++;
	            }
		        stAcumuladorFinal.lNumBoleta      ++                              ;
		        stAcumuladorFinal.dNetoBoleta     += pstGHistDocu.dAcumNetoGrav   ;
	    	    stAcumuladorFinal.dExentoBoleta    =  0						  	 ;
	        	stAcumuladorFinal.dIvaBoleta      += pstGHistDocu.dAcumIva        ;
	        	stAcumuladorFinal.dTotalBoleta    += pstGHistDocu.dAcumNetoGrav   +
	        								    pstGHistDocu.dAcumIva        ;
	        	/* stAcumuladorFinal.dTotalBoleta += pstGHistDocu.dTotDocumento   ;*/
				break;

    	case iTipBoletaExen :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumuladorFinal.lNumBoletaExenAnul++;
	        	}
		        stAcumuladorFinal.lNumBoletaExen      ++                               ;
		        stAcumuladorFinal.dNetoBoletaExen      =  0							  ;
	    	    stAcumuladorFinal.dExentoBoletaExen   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumuladorFinal.dIvaBoletaExen       =  0							  ;
	        	stAcumuladorFinal.dTotalBoletaExen    += pstGHistDocu.dAcumNetoNoGrav  ;
	        	/* stAcumuladorFinalFinal.dTotalBoletaExen += pstGHistDocu.dTotDocumento    ;*/
				break;

    }/* end switch */

    return;
}/*********************** Final bfnAcumulaDocumentoFinal *************************/




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

