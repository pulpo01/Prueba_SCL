
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
           char  filnam[19];
};
static const struct sqlcxp sqlfpn =
{
    18,
    "./pc/LibroVenta.pc"
};


static unsigned int sqlctx = 13824483;


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
   unsigned char  *sqhstv[20];
   unsigned long  sqhstl[20];
            int   sqhsts[20];
            short *sqindv[20];
            int   sqinds[20];
   unsigned long  sqharm[20];
   unsigned long  *sqharc[20];
   unsigned short  sqadto[20];
   unsigned short  sqtdso[20];
} sqlstm = {12,20};

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

 static const char *sq0018 = 
"select PROC.DES_PROCESO ,PROC.COD_PROCPREC ,PROC.DES_PROCPREC ,PROC.COD_ESTA\
PREC ,NVL(TRAZ.COD_ESTAPROC,0) ,TRAZ.FEC_INICIO ,TRAZ.FEC_TERMINO  from FA_TRA\
ZAPROC TRAZ ,(select A.COD_PROCESO COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.C\
OD_PROCPREC COD_PROCPREC ,C.DES_PROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAP\
REC  from FA_PROCFACTPREC A ,FA_PROCFACT B ,FA_PROCFACT C where ((A.COD_PROCES\
O=:b0 and A.COD_PROCESO=B.COD_PROCESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC\
 where (TRAZ.COD_CICLFACT(+)=:b1 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) or\
der by PROC.COD_PROCESO            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,563,0,4,493,0,0,10,6,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,1,5,0,0,1,5,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
60,0,0,2,0,0,17,841,0,0,1,1,0,1,0,1,97,0,0,
79,0,0,2,0,0,45,865,0,0,1,1,0,1,0,1,3,0,0,
98,0,0,2,0,0,13,876,0,0,4,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
129,0,0,2,0,0,15,917,0,0,0,0,0,1,0,
144,0,0,3,0,0,17,1191,0,0,1,1,0,1,0,1,97,0,0,
163,0,0,3,0,0,45,1227,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
190,0,0,3,0,0,45,1232,0,0,0,0,0,1,0,
205,0,0,3,0,0,13,1289,0,0,20,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
2,3,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,
0,2,97,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,3,0,0,
300,0,0,3,0,0,15,1464,0,0,0,0,0,1,0,
315,0,0,4,377,0,3,1624,0,0,17,17,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,
4,0,0,1,3,0,0,1,97,0,0,
398,0,0,5,70,0,4,1715,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
421,0,0,6,0,0,17,1826,0,0,1,1,0,1,0,1,97,0,0,
440,0,0,6,0,0,45,1848,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
467,0,0,6,0,0,13,1887,0,0,7,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,97,0,0,
510,0,0,6,0,0,15,1994,0,0,0,0,0,1,0,
525,0,0,7,338,0,3,2067,0,0,8,8,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,97,0,0,1,3,0,0,
572,0,0,8,393,0,3,2213,0,0,18,18,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,
4,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
659,0,0,9,0,0,17,2350,0,0,1,1,0,1,0,1,97,0,0,
678,0,0,9,0,0,21,2361,0,0,0,0,0,1,0,
693,0,0,10,64,0,5,2418,0,0,1,1,0,1,0,1,97,0,0,
712,0,0,11,64,0,5,2425,0,0,1,1,0,1,0,1,97,0,0,
731,0,0,12,620,0,3,2470,0,0,4,4,0,1,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
762,0,0,13,118,0,5,2499,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
789,0,0,14,260,0,4,2564,0,0,4,2,0,1,0,2,9,0,0,2,9,0,0,1,5,0,0,1,5,0,0,
820,0,0,15,0,0,17,2638,0,0,1,1,0,1,0,1,97,0,0,
839,0,0,15,0,0,45,2660,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,97,0,0,
866,0,0,15,0,0,13,2806,0,0,17,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,
0,2,5,0,0,2,5,0,0,
949,0,0,15,0,0,15,2906,0,0,0,0,0,1,0,
964,0,0,16,184,0,4,3383,0,0,5,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
999,0,0,17,160,0,4,3488,0,0,4,1,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1030,0,0,18,579,0,9,3567,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1053,0,0,18,0,0,13,3587,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
1088,0,0,18,0,0,15,3625,0,0,0,0,0,1,0,
1103,0,0,19,192,0,4,3635,0,0,4,2,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
1134,0,0,20,179,0,3,3701,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
1161,0,0,21,165,0,4,3760,0,0,5,4,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,
1196,0,0,22,138,0,4,3820,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,
};


/* ********************************************************************** */
/* *  Fichero : LibroVenta.pc                                           * */
/* *  El libro de ventas                                                * */
/* *  Autor : Guido Antio Cares                                         * */
/* *  Modificaciones : Jorge Toro Omar                                  * */
/* ********************************************************************** */

#define _LIBRO_C_

#include <LibroVenta.h>

/* Código Proceso para Traza Proceso */
/*#define iPROC_LIBROIVA           9020*/

char     szBuffer[MAX_NUMREGISTROS * MAX_LARGOREGISTRO]="";

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


/*********************************************************************/
/* PROCESO PRINCICPAL : main                                         */
/*********************************************************************/
int main( int  argc, 
          char *argv[])
{
    char        modulo             []="main";
    char        szFecha             [20]= ""; /*  Fecha de Sistema Para Update de Traza   */
    long        lCiclFact                   ;
    char        szNomTabla              [20];
    extern char *optarg                     ;
    int         iOpt                        ;
    char        opt []="u:m:a:d:l:c:n h i " ;
    char        szUsuario          [102]= "";
    char        szFormato           [10]= "";
    char        *psztmp                 = "";
    char        *szDirLogs                  ;
    char        *szDirDats                  ;
    char        szComando         [1024]= "";
    BOOL        bOptUsuario          = FALSE;

    puts("\n LibroVenta version " __DATE__ " " __TIME__ );

    memset(&stLineaComando,0,sizeof(stLineaComando));
    memset(&stAcumuladorFinal,0,sizeof(stAcumuladorFinal));
    memset(&stTotTipDocFin,0,sizeof(stTotTipDocFin));
    stLineaComando.iTipDoc=0;

    while( (iOpt = getopt (argc, argv, opt) ) != EOF )
    {
	    switch( iOpt )
	    {
		    case 'u':
			     if( strlen (optarg) )
			     {
				 strcpy(szUsuario, optarg);
				 bOptUsuario = TRUE;
				 fprintf (stdout," -u %s ", szUsuario);
			     }
			     break;
		    case 'm':
			     if( strlen (optarg) )
			     {
				 stLineaComando.iMes    = atoi (optarg);
				 fprintf (stdout," -m %d ",stLineaComando.iMes);
			     }
			     break;
		    case 'a':
			     if( strlen (optarg) )
			     {
				 stLineaComando.iAno    = atoi (optarg);
				 fprintf (stdout," -a %d ",stLineaComando.iAno);
			     }
			     break;
		    case 'd':
			     if( strlen (optarg) )
			     {
				 stLineaComando.iTipDoc    = atoi (optarg);
				 fprintf (stdout," -d %d ",stLineaComando.iTipDoc);
			     }
			     break;
		    case 'l':
			     if( strlen (optarg) )
			     {
				 stStatus.LogNivel =
				 (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
				 fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
			     }
			     break;
		    case 'c':
			     if( strlen (optarg) )
			     {
				 sprintf(stLineaComando.szTabla,"%d",atoi(optarg));
				 fprintf (stdout," -c %s ",stLineaComando.szTabla);
			     }
			     break;
		    case 'n':
			     strcpy(stLineaComando.szTabla,NOCICLO);
			     fprintf (stdout," -n %s ",stLineaComando.szTabla);
			     break;
		    case 'h':
			     strcpy(stLineaComando.szTabla,HISTDOCU);
			     fprintf (stdout," -h %s ",stLineaComando.szTabla);
			     break;
		    case 'i':
			     stLineaComando.bImprime = TRUE;
			     fprintf (stdout," -i IMPRIME\n ");
			     break;
	    } /* Fin Case */
    }/* Fin While */

    if( (strcmp(stLineaComando.szTabla,NOCICLO)==0) || (strcmp(stLineaComando.szTabla,HISTDOCU)==0) || 
        (stLineaComando.bImprime == TRUE) )
    {
	 if( stLineaComando.iMes < 1    ||  stLineaComando.iMes > 12  ||
	     stLineaComando.iAno < 1998 ||  stLineaComando.iAno > 3000 )
	 {
	     fprintf (stderr, "\n\t=> Parametros Incorrectos (mes/ano) %s\n", szUsage);
	     return(1);
	 }
    }

    if( (strcmp(stLineaComando.szTabla,NOCICLO)==0) && (stLineaComando.iTipDoc == 0) )
    {
	 fprintf (stderr, "\n\t=> Debe Ingresar Tipo de Documento.\n\n", szUsage);
	 return(1);
    }

    if( (stLineaComando.bImprime == TRUE) && (strlen(stLineaComando.szTabla)>0) )
    {
	 fprintf (stderr, "\n\t=> Debe Ingresar solo una Opcion \n"
	                  "\t   Tipo de Tabla a Cargar [-c,-n,-h]  o  Impresion [-i] )\n\n"
	                , szUsage);
	 return(1);
    }

    if( !bOptUsuario )
    {
	 fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
	 return(2);
    }
    else
    {
	 if( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL )
	 {
	      fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
	      return(3);
	 }
	 else
	 {
	      strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
	      strcpy  (stLineaComando.szPass, psztmp+1)                 ;
	 }
    }

    if( stStatus.LogNivel <= 0 )
    {
	stStatus.LogNivel = iLOGNIVEL_DEF     ;
    }

    stLineaComando.iNivLog = stStatus.LogNivel;
        
    /* Conexion a ORACLE */
    if( !bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass) )
    {
	 fprintf(stderr, "\n\tUsuario/Passwd Invalido\n");
	 return(1);
    }
    else
    {
	 printf( "\n\t-------------------------------------------------------"
	         "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
		 "\n\t-------------------------------------------------------"
		,stLineaComando.szUser);
    }

    /* Carga parametros de la estructura pstParamGener */
    if (!bGetParamDecimales() )
    {
        return FALSE;
    }
	
    /* Carga parametros Generales */
    if( !bGetDatosGener (&stDatosGener, szSysDate) )
    {
	return(FALSE);
    }

    /* Creación de archivo LOG y ERR */
    if( (szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL )
    {
	 return(FALSE);
    }

    if( (strcmp(stLineaComando.szTabla,NOCICLO)!=0)
     && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
     && (strlen(stLineaComando.szTabla)>4) )
    {
	 sprintf(stLineaComando.szDirLogs,"%s/LibroVenta/Ciclo/%s/",
	 szDirLogs,stLineaComando.szTabla);
    }
    else
    {
	 sprintf(stLineaComando.szDirLogs,"%s/LibroVenta/%04d%02d/",
	 szDirLogs,stLineaComando.iAno,stLineaComando.iMes);
    }

    free(szDirLogs);
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    if( system (szComando) )
    {
	printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
	return(FALSE);
    }

    sprintf(stStatus.ErrName, "%sLibroVenta_%04d%02d_%s.err",
    stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.ErrName);

    if( (stStatus.ErrFile = (FILE *)fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
	 fprintf( stderr, "\n ### Error: No puede abrirse el fichero de error %s\n", stStatus.ErrName);
	 return(4);
    }

    sprintf(stStatus.LogName, "%sLibroVenta_%04d%02d_%s.log",
    stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.LogName);

    if( (stStatus.LogFile = (FILE *)fopen(stStatus.LogName,"a")) == (FILE*)NULL )
    {
	 fprintf( stderr, "\n ### Error: No puede abrirse el fichero de log %s\n", stStatus.LogName);
	 return(5);
    }

    if( stLineaComando.bImprime )
    {
	if( (szDirDats = szGetEnv("XPFACTUR_DAT")) == (char *)NULL )
	{
	     return(FALSE);
	}

	sprintf(stLineaComando.szDirDats,"%s/LibroVenta/%04d%02d/",
	szDirDats,stLineaComando.iAno,stLineaComando.iMes);
	free(szDirDats);
	sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirDats);

	if( system (szComando) )
	{
	    printf( "\n\t***   Fallo mkdir de Directorio Datos : %s \n",szComando);
	    return(FALSE);
	}

        sprintf(stLineaComando.szFileDat,"%sLibroVenta_%04d%02d_%s.dat",
	stLineaComando.szDirDats,stLineaComando.iAno,stLineaComando.iMes,
	szSysDate);

	unlink (stLineaComando.szFileDat);

	if( ( stLineaComando.fpDat = (FILE *)fopen(stLineaComando.szFileDat,"a")) == (FILE *)NULL )
	{
	      vDTrazasError(modulo,"\n\n\tError al abrir el Fichero de Datos ",LOG01);
	      return(FALSE);
	}
    }

    vDTrazasLog (modulo, "\n\t\t**************************************************************"
	                 "\n\t\t*                 LIBRO VTA version " __DATE__ " " __TIME__ " TGE *"
	                 "\n\t\t*               NIVEL DE LOG  %d                              *"
	                 "\n\t\t**************************************************************"
	               , LOG03,stLineaComando.iNivLog);
    vDTrazasError(modulo,"\n\t\t**************************************************************"
	                 "\n\t\t*                 LIBRO VTA version " __DATE__ " " __TIME__ " TGE *"
	                 "\n\t\t*               NIVEL DE LOG  %d                              *"
	                 "\n\t\t**************************************************************"
	                ,LOG03,stLineaComando.iNivLog);

    if( (strcmp(stLineaComando.szTabla,NOCICLO) !=0)
     && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
     && (strlen(stLineaComando.szTabla)>4) )
    {
	 lCiclFact = atol(stLineaComando.szTabla);
	 if( !bfnValidaTrazaProc2(lCiclFact, iPROC_LIBROIVA, iIND_FACT_ENPROCESO) )
	 {
	      return(FALSE);
	 }
	 if( !fnOraCommit() )
	 {
	     vDTrazasLog  (modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG03, SQLERRM);
	     vDTrazasError(modulo , "ERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
	     return(FALSE);
	 }

	 if( !bfnSelectSysDate(szFecha) )
	 {
	     return(FALSE);
	 }
	 
	 bfnSelectTrazaProc (lCiclFact, iPROC_LIBROIVA, &stTrazaProc);
	 bPrintTrazaProc(stTrazaProc);
    }

    /* Proceso Generación Libro Venta */
    if( !bfnOraGenLibro (stLineaComando) )
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

    if( (strcmp(stLineaComando.szTabla,NOCICLO)!=0)
     && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
     && (strlen(stLineaComando.szTabla)>4) )
    {
	if( !bfnSelectSysDate(szFecha) )
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
	    if( !bfnUpdateTrazaProc(stTrazaProc) )
	    {
	         return(FALSE);
	    }
	}
    }

    if( !bfnDisconnectORA(0) )
    {
	printf("\n Desconexion de Oracle con Error \n");
    }
    else
    {
	printf("\n Desconexion de Oracle OK\n");
	vDTrazasLog(modulo, "\n\t-------------------------------------------------------"
		            "\n\tDesconectado de ORACLE "
		            "\n\t-------------------------------------------------------\n"
		          , LOG03);
	vDTrazasError(modulo,"\n\t-------------------------------------------------------"
		             "\n\tDesconectado de ORACLE "
		             "\n\t-------------------------------------------------------\n"
		            ,LOG03);
    }

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    fclose(stLineaComando.fpDat);

    return(0);
}
/****************************   FIN MAIN    **********************************/

/*********************************************************************/
/* FUNCION      : bfnOraGenLibro                                     */
/*********************************************************************/
static BOOL bfnOraGenLibro( LINEACOMANDO stLineaComando)
{
    char      szFuncion[]="bfnOraGenLibro";
    char      szFecInicio           [9];
    char      szFecFin              [9];
    int       iSqlCodeFactLib   = SQLOK;
    char      szNomTabla           [20];
    int       iMesAux                  ;
    int       iAnoAux                  ;
    int       iConReg               = 0;
    int       iDoc                  = 0;
    char      szCodOficina          [3];
    BOOL      OptInsert                ;
    BOOL      BFlagOficina             ;
    GHISTDOCU stGHistDocu              ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhFecInicio     [9];  /* EXEC SQL VAR szhFecInicio    IS STRING (9); */ 

	 char szhFecFin        [9];  /* EXEC SQL VAR szhFecFin       IS STRING (9); */ 

	 long lhBoletasAmistar = 0;
	 long lhNetoAmistar    = 0;
	 long lhIvaAmistar     = 0;
	 long lhTotalAmistar   = 0;
	 int  icodcatimpo         ; 
	 int  icodzonaimpo        ;
	 int  icodtipimpues       ;
	 int  icodgrpservi        ;
    /* EXEC SQL END DECLARE SECTION; */ 



    if( !bfnRecuperaImpuesto(&icodcatimpo,&icodzonaimpo,&icodtipimpues,&icodgrpservi) )
    {
	vDTrazasError(szFuncion, "\n\tError en obtencion impuesto [%d] [%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }
	
    iMesAux = stLineaComando.iMes;
    iAnoAux = stLineaComando.iAno;
    strcpy(szNomTabla,stLineaComando.szTabla);

    vDTrazasLog ( szFuncion, "\n\tParametros de Entrada bfnOraGenLibro"
	                     "\n\t\t==>  Mes Actual [%02d]"
	                     "\n\t\t==>  Ano Actual [%04d]"
	                     "\n\t\t==>  Tabla      [%s]"
	                   , LOG03,iMesAux,iAnoAux,szNomTabla);
	         
/* P-MIX-09003 */
	                   
    /* Obtiene el código de documento para Nota de Abono */	                   
    if( ifnGetParametro2 (iCodParamNotaAbono, szTipParametro, szValParametro) )
    {
	vDTrazasError(szFuncion, "\n\tError en obtencion de codigo de documento Nota de Abono [%d]:[%s] "
	                       , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }    
    
    iCodNotaAbono=atoi(szValParametro);
    
/* P-MIX-09003 */

    /* Obtiene el codigo de documento para las boletas autofoliadas */
    if( ifnGetParametro2 (iCodParamBoletaAuto, szTipParametro, szValParametro) )
    {
	vDTrazasError(szFuncion, "\n\tError en obtencion de codigo de documento [%d]:[%s] "
	                       , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    iCodBoletaAuto=atoi(szValParametro);

    if( ifnGetParametro2 (iCodParamBoletaAutoExen, szTipParametro, szValParametro) )
    {
	vDTrazasError(szFuncion,"\n\tError en obtencion de codigo de documento [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    iCodBoletaAutoExen=atoi(szValParametro);

    sprintf(szFecInicio ,"01%02d%04d", iMesAux, iAnoAux );
    sprintf(szFecFin, "01%02d%04d"
	            , ((iMesAux != 12) ? iMesAux+1 : 1)
	            , ((iMesAux != 12) ? iAnoAux : iAnoAux+1));

    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin,szFecFin);

    vDTrazasLog ( szFuncion, "\n\tParametros Calculados"
	                  "\n\t\t==>  szFecInicio [%s]"
	                  "\n\t\t==>  szFecFinal  [%s]"
	                , LOG03,szhFecInicio,szhFecFin );

    /****************************************************************/
    /*  Rescata Informacion del Representante Legal de la Empresa   */
    /****************************************************************/
    vDTrazasLog ( szFuncion, "\n\tFAD_NOM_REP_LEGAL [%d]"
	                     "\n\tFAD_RUT_REP_LEGAL [%d]"
	                   , LOG04,FAD_NOM_REP_LEGAL, FAD_RUT_REP_LEGAL);

    if( ifnGetParametro2 (FAD_NOM_REP_LEGAL, szTipParametro, szValParametro) )
    {
    	return(FALSE);
    }

    strcpy(szNomRepLegal, szValParametro);

    vDTrazasLog ( szFuncion, "\n\tNombre Representante legal [%s]", LOG04, szNomRepLegal);

    if( ifnGetParametro2 (FAD_RUT_REP_LEGAL, szTipParametro, szValParametro) )
    {
	return(FALSE);
    }

    strcpy(szRutRepLegal, szValParametro);
    vDTrazasLog ( szFuncion, "\n\tRut Representante legal [%s]", LOG04, szRutRepLegal);

    /****************************************************************/

    if( strlen(szNomTabla)>0 )
    {
	if( (strcmp(szNomTabla,NOCICLO)==0) || (strcmp(szNomTabla,HISTDOCU)==0) )
	{
	    /****************************************************************/
	    /* Comienza a Procesar aqui las boletas Amistar                 */
	    /****************************************************************/
	    /* EXEC SQL SELECT count(*) cantidad,
			    NVL(round(round (sum(nvl(PRC_TOTAL,0)))/(1+(max(PRC_IMPUESTO)/100))),0) NETO ,
			    NVL(round(sum(nvl(PRC_TOTAL,0)))-round(round (sum(nvl(PRC_TOTAL,0)))/(1+(max(PRC_IMPUESTO)/100))),0) IVA ,
			    NVL(round (sum(nvl(PRC_TOTAL,0))),0) TOTAL
		     INTO :lhBoletasAmistar,
			  :lhNetoAmistar,
			  :lhIvaAmistar,
			  :lhTotalAmistar
		     FROM AL_HCAB_BOLETA,GE_IMPUESTOS
		     WHERE NUM_BOLETA > 0
		     AND FEC_BOLETA >= TO_DATE(:szhFecInicio,'DDMMYYYY')
		     AND FEC_BOLETA <  TO_DATE(:szhFecFin,'DDMMYYYY') 
		     AND COD_CATIMPOS  = :icodcatimpo
		     AND COD_ZONAIMPO  = :icodzonaimpo
		     AND COD_TIPIMPUES = :icodtipimpues
		     AND COD_GRPSERVI  = :icodgrpservi
		     AND FEC_DESDE    <= FEC_BOLETA
		     AND FEC_HASTA    >= FEC_BOLETA; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 10;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select count(*)  cantidad ,NVL(round((round(sum(nvl(PRC_\
TOTAL,0)))/(1+(max(PRC_IMPUESTO)/100)))),0) NETO ,NVL((round(sum(nvl(PRC_TOTAL\
,0)))-round((round(sum(nvl(PRC_TOTAL,0)))/(1+(max(PRC_IMPUESTO)/100))))),0) IV\
A ,NVL(round(sum(nvl(PRC_TOTAL,0))),0) TOTAL into :b0,:b1,:b2,:b3  from AL_HCA\
B_BOLETA ,GE_IMPUESTOS where ((((((((NUM_BOLETA>0 and FEC_BOLETA>=TO_DATE(:b4,\
'DDMMYYYY')) and FEC_BOLETA<TO_DATE(:b5,'DDMMYYYY')) and COD_CATIMPOS=:b6) and\
 COD_ZONAIMPO=:b7) and COD_TIPIMPUES=:b8) and COD_GRPSERVI=:b9) and FEC_DESDE<\
=FEC_BOLETA) and FEC_HASTA>=FEC_BOLETA)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )5;
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
     sqlstm.sqhstv[6] = (unsigned char  *)&icodcatimpo;
     sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&icodzonaimpo;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&icodtipimpues;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&icodgrpservi;
     sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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



		     if( SQLCODE )
		     {
			 vDTrazasLog ( szFuncion,"\tAl seleccionar datos desde AL_HCAB_BOLETA\n\t %s" ,LOG01,SQLERRM);
			 vDTrazasError ( szFuncion," \tAl seleccionar datos desde AL_HCAB_BOLETA\n\t %s" ,LOG01,SQLERRM);
			 return(FALSE);
		     }

		     stAcumuladorFinal.lNumBoletaAmis    = lhBoletasAmistar ;
		     stAcumuladorFinal.dExentoBoletaAmis = 0            ;
		     stAcumuladorFinal.dNetoBoletaAmis   = lhNetoAmistar   ;
		     stAcumuladorFinal.dIvaBoletaAmis    = lhIvaAmistar    ;
		     stAcumuladorFinal.dTotalBoletaAmis  = lhTotalAmistar ;

		     /* Termina de Procesar aqui las boletas Amistar */	/* marca */
	}

	/************************************************************************/
	/*  iDoc 1 : Procesa Facturas Emitidas en el periodo                    */
	/*  iDoc 2 : Procesa Facturas Exentas Emitidas en el periodo            */
	/*  iDoc 3 : Procesa Notas de Credito Emitidas en el periodo            */
	/*  iDoc 4 : Procesa Boletas Emitidas en el periodo                     */
	/*  iDoc 5 : Procesa Boletas Exentas Emitidas en el periodo             */
	/*  iDoc 6 : Procesa Boletas Autofoliadas Emitidas en el periodo        */
	/*  iDoc 7 : Procesa Boletas Autofoliadas Exentas Emitidas en el periodo*/
	/*  iDoc 13: Procesa Notas de Abono Emitidas en el periodo              */	
	/************************************************************************/
	if( strcmp(szNomTabla,HISTDOCU)==0 )
	{
	    vDTrazasLog ( szFuncion, "\n\t\t**Validacion de Documentos**"
			             "\n\t\t Nombre de Tabla : [%s]"
			           , LOG04,szNomTabla);

	    for( iDoc=1; iDoc<14;iDoc++ )
	    {
		 iSqlCodeFactLib = ifnOpenDocumentos(iDoc,szFecInicio,szFecFin,stLineaComando);

		 while( iSqlCodeFactLib == SQLOK )
		 {
			memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
			iSqlCodeFactLib = ifnFetchDocumentos(iDoc,&stGHistDocu,stLineaComando);

			if( iSqlCodeFactLib == SQLOK )
			{
			    BFlagOficina = FALSE;
			    if( strcmp(stGHistDocu.szCodOficina," ")!=0 )
			    {
				if( (stGHistDocu.iIndSupertel==0) && (stGHistDocu.iIndFactur==1) )
				{
				     OptInsert = TRUE;
				     if( !bfnInsertaLibroIva(stGHistDocu,&OptInsert,HISTO) )
				     {
					 return(FALSE);
				     }
				     BFlagOficina = TRUE;
				     lConRegFinal++;
				}
			    }
			    if( !bfnUpdateIndLibro(szNomTabla,stGHistDocu,OptInsert,BFlagOficina) )
			    {
				 return(FALSE);
			    }
		 	    iConReg++;
			    if( iConReg == MAXREG_COMMIT )
			    {
				if( !bfnOraCommit() )
				{
				    vDTrazasLog  (szFuncion, "\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA) [%d]:[%s] "
				                           , LOG01,SQLCODE,SQLERRM);
				    vDTrazasError(szFuncion, "\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA) [%d]:[%s] "
				                           , LOG01,SQLCODE,SQLERRM);
				    return(FALSE);
				}
				iConReg = 0;
			    }

			}
		 }
		 if( iSqlCodeFactLib != SQLNOTFOUND ) 
		 {
		     return(FALSE);
		 }
		 if( !bfnCloseDocumentos() )
		 {
		     return(FALSE);
		 }
		 if( !bfnConsumos(iDoc, szFecInicio, szFecFin) )
		 {
		     return(FALSE);
		 }
	    }
	}
	else
	{
	    iSqlCodeFactLib = ifnOpenDocumentos(0,szFecInicio,szFecFin,stLineaComando);

	    while( iSqlCodeFactLib == SQLOK )
	    {
		   memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
		   iSqlCodeFactLib = ifnFetchDocumentos(0,&stGHistDocu,stLineaComando);

		   if( iSqlCodeFactLib == SQLOK )
		   {
		       BFlagOficina = FALSE;
		       if( (strcmp(stGHistDocu.szCodOficina," ")!=0) &&
			   (stGHistDocu.iIndSupertel==0)             &&
			   (stGHistDocu.iIndFactur  ==1) )
		       {
			    OptInsert = TRUE;
			    if( strcmp(stLineaComando.szTabla,NOCICLO)==0 )
			    {
				if( !bfnInsertaLibroIva(stGHistDocu,&OptInsert,NOCIC) )
				{
				    return(FALSE);
				}
			    }
			    else
			    {
				if( !bfnInsertaLibroIva(stGHistDocu,&OptInsert,CICLO) )
				{
				    return(FALSE);
				}
			    }
			    BFlagOficina = TRUE;
			    lConRegFinal++;
		       }
		       if( !bfnUpdateIndLibro(szNomTabla,stGHistDocu,OptInsert,BFlagOficina) )
		       {
			   return(FALSE);
		       }
		       iConReg++;
		       if( iConReg == MAXREG_COMMIT )
		       {
			   if( !bfnOraCommit() )
			   {
			       vDTrazasLog  (szFuncion,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA con Tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
			       vDTrazasError(szFuncion,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA con Tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
			       return(FALSE);
			   }
			   iConReg = 0;
			}
		   }
	    }
	    if( iSqlCodeFactLib != SQLNOTFOUND )
	    {
		return(FALSE);
	    }

	    if( !bfnCloseDocumentos() )
	    {
		return(FALSE);
	    }

	    if( strcmp(stLineaComando.szTabla,NOCICLO)==0 )
	    {
		vDTrazasLog ( szFuncion, "\n\tNo es Ciclo. Se Procesa Al_Consumos_Documentos",LOG04);
		for( iDoc=1; iDoc<14;iDoc++ )
		{
		     if (iDoc == 8)
		     {
		     	iDoc = 13;
		        if( !bfnConsumos(iDoc, szFecInicio, szFecFin) )
		        {
			    return(FALSE);
		        }
		     }
		     else
		     {
		        if( !bfnConsumos(iDoc, szFecInicio, szFecFin) )
		        {
			    return(FALSE);
		        }		     	
		     }		     
		}
	    }
	}
    } /* Fin ( strlen(szNomTabla)>0 )*/

    if( lConRegFinal > 0 )
    {
	if( !bfnOraCommit() )
	{
	    vDTrazasLog  (szExeName,"\n\n\tError en Commit Final de (Insert de FAT_DETLIBROIVA con tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
	    vDTrazasError(szExeName,"\n\n\tError en Commit Final de (Insert de FAT_DETLIBROIVA con tabla :[%s]) [%d]:[%s] ",LOG01,szNomTabla,SQLCODE,SQLERRM);
	    return(FALSE);
	}
	vDTrazasLog  (szExeName,"\n\t\tCOMMIT FINAL.  [%ld] Registros Procesados. ",LOG03,lConRegFinal);
    }

/***************************************************************************************/
/**** IMPRESION DEL LIBRO DE VENTAS ****************************************************/
/***************************************************************************************/

    if( stLineaComando.bImprime )
    {
	vDTrazasLog  (szExeName,"\n\t************ Funciones de Impresion  ***********",LOG03);
	if( !bfnLlenaArchivoImpresion(szFecInicio,szFecFin) )
	{
	    return(FALSE);
	}
    }

    vDTrazasLog  (szExeName,"\n\n\tTermino Ok Funcion OraGenLibro",LOG03);
    return(TRUE);
}/************************   Final bfnOraGenLibro  **************************/

/*********************************************************************/
/* FUNCION      : bfnConsumos                                        */
/*********************************************************************/
static BOOL bfnConsumos( int  iDoc, 
                         char *szFecInicio, 
                         char *szFecFin)
{
    char      szFuncion []="bfnConsumos" ;
    int       iSqlCodeConsumo = SQLOK;
    int       iConReg = 0            ;
    BOOL      OptInsert              ;
    GHISTDOCU stGHistDocu            ;

    vDTrazasLog ( szFuncion,"\n\t\tFuncion Procesa Al_Consumos_Documentos",LOG04);
    iSqlCodeConsumo = ifnOpenConsumos(iDoc,szFecInicio,szFecFin);
    
    while( iSqlCodeConsumo == SQLOK )
    {
	   memset ( &stGHistDocu, 0 , sizeof ( GHISTDOCU ) );
	   iSqlCodeConsumo = ifnFetchConsumos(iDoc,&stGHistDocu);

	   if( iSqlCodeConsumo == SQLOK )
	   {
	       iConReg++;
	       OptInsert = TRUE;
	       if( !bfnInsertaConsumosenLibroIva(stGHistDocu,&OptInsert) )
	       {
		   return(FALSE);
	       }

	       if( !bfnUpdateIndConsumosLibroIva(stGHistDocu, OptInsert) )
	       {
		   return(FALSE);
	       }

	       if( iConReg == MAXREG_COMMIT )
	       {
		   if( !bfnOraCommit() )
		   {
		       vDTrazasLog  (szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA ) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
		       vDTrazasError(szExeName,"\n\n\tError en Commit de (Insert de FAT_DETLIBROIVA ) [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
		       return(FALSE);
		   }
		   iConReg = 0;
		   lConRegFinal++;
	       }
           }

	   if( iSqlCodeConsumo != SQLNOTFOUND ) 
	   {
	       return(FALSE);
	   }
	   if( !bfnCloseConsumos() )
	   {
	       return(FALSE);
	   }
    }
    return(TRUE);
} /************************   Final bfnConsumos  **************************/

/*********************************************************************/
/* FUNCION      : bfnGetHistClie                                     */
/*********************************************************************/
static BOOL bfnGetHistClie( GHISTCLIE    *pstGHistClie, 
                            LINEACOMANDO stLineaComando)
{

    char szFuncion []="bfnGetHistClie";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char    szhNomCliente    [91];  /* EXEC SQL VAR szhNomCliente IS STRING (91); */ 

	 char    szhApellido1     [21];  /* EXEC SQL VAR szhApellido1  IS STRING (21); */ 

	 char    szhApellido2     [21];  /* EXEC SQL VAR szhApellido2  IS STRING (21); */ 

	 char    szhRut           [21];  /* EXEC SQL VAR szhRut        IS STRING (21); */ 

	 long    lhIndOrdentotal;
    /* EXEC SQL END DECLARE SECTION ; */ 


    static  ENLACEHIST   stEnlaceHist;
    char    SqlQuery            [256];
    char    szNombreCompleto    [140];
    int     iLargoNombre             ;
    char    szNomTabla           [20];

    vDTrazasLog ( szFuncion , "\n\t*** Entrada a bfnGetHistClie() ***"
	                       "\n\t==> IndOrdenTotal  [%ld]"
	                       "\n\t==> CodCiclFact    [%ld]"
	                     , LOG05,pstGHistClie->lIndOrdenTotal,pstGHistClie->lCodCiclFact);

    strcpy(szNomTabla,stLineaComando.szTabla);

    if( strcmp(szNomTabla,HISTDOCU)==0 )
    {
	memset(&stEnlaceHist,0,sizeof(ENLACEHIST));
	stEnlaceHist.lCodCiclFact = pstGHistClie->lCodCiclFact;
	if( !bGetEnlaceHist(&stEnlaceHist) )
	{
	    return(FALSE);
	}
    }

    memset(&SqlQuery,0,sizeof(SqlQuery));

    strcpy(SqlQuery, "SELECT  nvl(NOM_CLIENTE,' ')  ,\n"
	              "\t nvl(NOM_APECLIEN1,' '),\n"
	              "\t nvl(NOM_APECLIEN2,' '),\n"
	              "\t nvl(NUM_IDENTTRIB,' ')\n");

    if( strcmp(szNomTabla,HISTDOCU)==0 )
    {
	sprintf(SqlQuery, "%s\tFROM   %s \n",SqlQuery,stEnlaceHist.szDetCliente);
    }
    else if( strcmp(szNomTabla,NOCICLO)==0 )
         {
	     sprintf(SqlQuery, "%s\tFROM  FA_FACTCLIE_NOCICLO  \n",SqlQuery);
	 }
    else
    {
	 sprintf(SqlQuery, "%s\tFROM  FA_FACTCLIE_%s \n",SqlQuery,szNomTabla);
    }

    sprintf(SqlQuery, "%s\tWHERE  IND_ORDENTOTAL = :lhIndOrdentotal ",SqlQuery);

    vDTrazasLog ( szFuncion, "\n\t*** Query ***\n\t[%s]\n",LOG06,SqlQuery);

    /* EXEC SQL PREPARE sql_Facturas_Libro FROM :SqlQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )60;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)SqlQuery;
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


	
    if( SQLCODE )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error en SQL-PREPARE sql_Facturas_Libro **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "\n\t**  Error en SQL-PREPARE sql_Facturas_Libro **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_FacturLibro CURSOR FOR sql_Facturas_Libro; */ 

    
    if( SQLCODE )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error en SQL-DECLARE Cur_FacturLibro  **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "\n\t**  Error en SQL-DECLARE Cur_FacturLibro  **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    lhIndOrdentotal = pstGHistClie->lIndOrdenTotal;

    /* EXEC SQL OPEN Cur_FacturLibro USING :lhIndOrdentotal ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )79;
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


	
    if( SQLCODE )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error en SQL-OPEN CURSOR Cur_FacturLibro **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "\n\t**  Error en SQL-OPEN CURSOR Cur_FacturLibro **"
		                  "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    /* EXEC SQL 
         FETCH Cur_FacturLibro 
         INTO  :szhNomCliente    ,
	       :szhApellido1     ,
	       :szhApellido2     ,
	       :szhRut           ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )98;
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
    sqlstm.sqhstl[3] = (unsigned long )21;
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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
		vDTrazasLog  (szFuncion, "\n\t**  Error en FETCH sobre CURSOR Cur_FacturLibro  [%s] **",LOG01,SQLERRM);
		vDTrazasError(szFuncion,  "\n\t**  Error en FETCH sobre CURSOR Cur_FacturLibro  [%s] **",LOG01,SQLERRM);
		return(FALSE);
    }
	
    if( SQLCODE == SQLOK )
    {
	sprintf(szNombreCompleto, "%*.*s %*.*s %*.*s\0"
	                        , strlen(szhNomCliente)
	                        , strlen(szhNomCliente)
	                        , szhNomCliente
	                        , strlen(szhApellido1)
	                        , strlen(szhApellido1)
	                        , szhApellido1
	                        , strlen(szhApellido2)
	                        , strlen(szhApellido2)
	                        , szhApellido2);	                        
	iLargoNombre = strlen(szNombreCompleto);
	if( iLargoNombre  > 60 )	 
	{
	    szNombreCompleto[59] = '\0';
	}

	strncpy(pstGHistClie->szNomCliente   ,szNombreCompleto,60                      );
	strncpy(pstGHistClie->szRut          ,szhRut          ,strlen(szhRut)          );

	vDTrazasLog ( szFuncion, "\n\t\tNombre     : [%s]"
		                 "\tRut        : [%s]"
		               , LOG04,pstGHistClie->szNomCliente,pstGHistClie->szRut);

    }

    /* EXEC SQL CLOSE Cur_FacturLibro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )129;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK )
    {
	return(FALSE);
    }

    return(TRUE);
}

/*********************************************************************/
/* FUNCION      : ifnOpenDocumentos                                  */
/*********************************************************************/
static int ifnOpenDocumentos( int          iTipDocumento, 
                              char         *szFecInicio, 
                              char         *szFecFin, 
                              LINEACOMANDO stLineaComando)
{
    char        szFuncion[]="ifnOpenDocumentos";	
    int         bTipDocError=FALSE;
    int         bConParametros=FALSE;
    static char szCadenaSQL[2048];
    static char szSUBCadena1[500];

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

	 char szhNomTabla  [20]    ;
	 int  ihCodTipDocum        ;
	 long lhCodConceptoImpRet  ;
	 char szhFecInicio [9]     ;   /* EXEC SQL VAR szhFecInicio IS STRING (9); */ 
	 /*  DDMMYYYY  */
	 char szhFecFin    [9]     ;   /* EXEC SQL VAR szhFecFin    IS STRING (9); */ 
	 /*  DDMMYYYY  */
    /* EXEC SQL END DECLARE SECTION   ; */ 



    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   , szFecFin  );
    strcpy(szhNomTabla ,stLineaComando.szTabla);

    vDTrazasLog ( szFuncion, "\n\t**  Funcion ifnOpenDocumentos  **"
	                  "\n\t\t==>  Fecha  Desde  [%s]"
	                  "\n\t\t==>  Fecha  Hasta  [%s]"
	                  "\n\t\t==>  Nombre Tabla  [%s]"
	                  "\n\t\t==>  iTipDocumento [%d]"
	                , LOG03
	                , szFecInicio
	                , szFecFin
	                , szhNomTabla
	                , iTipDocumento);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    memset(szSUBCadena1,0,sizeof(szSUBCadena1));

    if( strcmp(szhNomTabla,NOCICLO)==0 )  
    {
    	ihCodTipDocum = stLineaComando.iTipDoc;
    }

    if( strcmp(szhNomTabla,HISTDOCU)==0 )
    {
	switch( iTipDocumento )
	{
			case iTipFactura :
				ihCodTipDocum = 28                         ;   /* 28 */
				break;
			case iTipFacturaExen :
				ihCodTipDocum = stDatosGener.iCodFacturaExen;  /* 47 */
				break;
			case iTipNotaCred :
				ihCodTipDocum = stDatosGener.iCodNotaCre    ;  /* 25 */
				break;
			case iTipNotaAbon:             
				ihCodTipDocum = iCodNotaAbono               ;  /* 91 */	   /* P-MIX-09003 */
				break;				
			case iTipFacturaElec :
				ihCodTipDocum = 75                          ;  /* 75 */
				break;
			case iTipFacturaElecExen :
				ihCodTipDocum = 76                          ;  /* 76 */
				break;
			case iTipBoleta :
				ihCodTipDocum = stDatosGener.iCodBoleta     ;  /* 45 */
				break;
			case iTipBoletaExen :
				ihCodTipDocum = stDatosGener.iCodBoletaExen ;  /* 46 */
				break;
			case iTipBoletaAuto :
				ihCodTipDocum = iCodBoletaAuto              ;  /* 69 */
				break;
			case iTipBoletaAutoExen:
				ihCodTipDocum = iCodBoletaAutoExen          ;  /* 73 */
				break;
			case iTipBoletaAuto69:             
				ihCodTipDocum = 69                          ;  /* 69 */	   
				break;
			case iTipBoletaAuto73:             
				ihCodTipDocum = 73                          ;  /* 73 */	   
				break;
			default :
				bTipDocError=TRUE;
				break;
	}
    }

    if( bTipDocError )
    {
	return(SQLNOTFOUND);
    }

    /* Recupera parámetro Cod. Concepto Impuesto Retenido 674 */
    if ( !bGetParamCodConceptoImpRet(szValParametro))
    {
         return (FALSE);
    }    
    lhCodConceptoImpRet = atol(szValParametro);

    strcpy(szCadenaSQL, "SELECT H.IND_ANULADA,\n"
	                "\t H.IND_ORDENTOTAL ,\n"
	                "\t H.COD_TIPDOCUM ,\n"
	                "\t nvl(H.COD_CICLFACT,0),\n"
	                "\t TRIM(H.PREF_PLAZA) ,\n"
	                "\t H.NUM_FOLIO ,\n"
	                "\t nvl(TO_CHAR(H.FEC_EMISION,'DD/MM/YYYY'),' ') ,\n"
	                "\t nvl(H.ACUM_NETONOGRAV,0) ,\n"
	                "\t nvl(H.ACUM_NETOGRAV,0) ,\n"
	                "\t nvl(H.ACUM_IVA,0) ,\n"
	                "\t nvl(H.TOT_FACTURA,0),\n"
	                "\t nvl(H.COD_VENDEDOR_AGENTE,0),\n"
	                "\t nvl(H.COD_OFICINA,' '),\n"
	                "\t H.IND_SUPERTEL,\n"
	                "\t H.IND_FACTUR,\n"
	                "\t H.ROWID,\n"
	                "\t H.COD_CLIENTE,\n"
	                "\t nvl(TO_CHAR(H.FEC_VENCIMIE,'DD/MM/YYYY'),' ') ,\n");

    if( strcmp(szhNomTabla,NOCICLO)==0 )
    {
	sprintf(szCadenaSQL, "%s \t nvl((SELECT SUM(IMP_CONCEPTO) FROM FA_FACTCONC_NOCICLO "
	                     "\t     WHERE IND_ORDENTOTAL = H.IND_ORDENTOTAL \n"
	                     "\t     AND   COD_CONCEPTO = %ld),0) AS IMP_CONCEPTO,\n"
	                     "\t D.COD_TIPDOCUM\n"
		             "\tFROM FA_TIPDOCUMEN D, %s H\n"
		             "\tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n"
		             "\tAND D.COD_TIPDOCUM = :ihCodTipDocum\n"
		             "\tAND H.FEC_EMISION >= TO_DATE(:szhFecInicio,'DDMMYYYY')\n"
		             "\tAND H.FEC_EMISION < TO_DATE(:szhFecFin,'DDMMYYYY')\n"
		           , szCadenaSQL
		           , lhCodConceptoImpRet
		           , szhNomTabla
		           );
		
	bConParametros=TRUE;
    }
    else if( strcmp(szhNomTabla,HISTDOCU)==0 )
	 {
	     sprintf(szCadenaSQL, "%s \t nvl((SELECT SUM(IMP_CONCEPTO) FROM FA_HISTCONC "
	                          "\t     WHERE IND_ORDENTOTAL = H.IND_ORDENTOTAL \n"
	                          "\t     AND   COD_CONCEPTO = %ld),0) AS IMP_CONCEPTO\n"	     	     
		                  "\tFROM FA_TIPDOCUMEN D, %s H\n"
		                  "\tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n"
		                  "\tAND D.COD_TIPDOCUM = :ihCodTipDocum\n"
		                  "\tAND H.FEC_EMISION >= TO_DATE(:szhFecInicio,'DDMMYYYY')\n"
		                  "\tAND H.FEC_EMISION < TO_DATE(:szhFecFin,'DDMMYYYY')\n"
		                , szCadenaSQL
		                , lhCodConceptoImpRet
		                , szhNomTabla);
		
	     bConParametros=TRUE;
	}
	else
	{
	     sprintf(szCadenaSQL, "%s \t nvl((SELECT SUM(IMP_CONCEPTO) FROM FA_FACTCONC_%s "
	                          "\t     WHERE IND_ORDENTOTAL = H.IND_ORDENTOTAL \n"
	                          "\t     AND   COD_CONCEPTO = %ld),0) AS IMP_CONCEPTO,\n"
	                          "\t D.COD_TIPDOCUM\n"
		                  "\tFROM FA_TIPDOCUMEN D, FA_FACTDOCU_%s H\n"
		                  "\tWHERE H.COD_TIPDOCUM = D.COD_TIPDOCUMMOV\n"
		                , szCadenaSQL
		                , szhNomTabla
		                , lhCodConceptoImpRet
		                , szhNomTabla);
	}

    sprintf(szCadenaSQL, "%s \tAND H.IND_ANULADA = 0\n"
	                 "\tAND H.NUM_FOLIO > 0\n"
	                 "\tAND H.IND_LIBROIVA = 0\n"
	               , szCadenaSQL);

    vDTrazasLog (szFuncion, "\t\tihCodTipDocum [%d] stDatosGener.iCodNotaCre [%d]"
                       , LOG04
                       , ihCodTipDocum
                       , stDatosGener.iCodNotaCre);
    
    if( ihCodTipDocum == stDatosGener.iCodNotaCre )
    {
	sprintf(szSUBCadena1,"%s \tAND H.TOT_FACTURA >= 0\n",szSUBCadena1);
	vDTrazasLog (szFuncion,"\t\t<< Es Nota de Credito. Total de Factura puede ser Mayor o igual a 0.>>\n",LOG05);
    }
    else
    {
	vDTrazasLog ( szFuncion , " Flag de Procesamiento de documento en cero: [%c]",LOG03,pstParamGener.sDocumentoCero);
	if( pstParamGener.sDocumentoCero == 'S')
	{
	    sprintf(szSUBCadena1,"%s \tAND H.TOT_FACTURA >= 0\n",szSUBCadena1);
	    vDTrazasLog (szFuncion,"\t\t<< No es Nota de Credito. Total de Factura debe ser Mayor a 0.>>\n",LOG05);		    
	}
	else
	{
	    sprintf(szSUBCadena1,"%s \tAND H.TOT_FACTURA > 0\n",szSUBCadena1);
	    vDTrazasLog (szFuncion,"\t\t<< No es Nota de Credito. Total de Factura debe ser Mayor a 0.>>\n",LOG05);
	}
    }
	
    if( bConParametros == TRUE )
    {
	switch( iTipDocumento )
	{
			case iTipFactura :
                                vDTrazasLog (szFuncion,"\n\t<< Factura >>",LOG05);
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipFacturaExen :
                                vDTrazasLog (szFuncion,"\n\t<< Factura Exenta >>",LOG05);
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipNotaCred :
                                vDTrazasLog (szFuncion,"\n\t<< Nota Credito >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipNotaAbon :
                                vDTrazasLog (szFuncion,"\n\t<< Nota Abono >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;				
			case iTipFacturaElec :
                                vDTrazasLog (szFuncion,"\n\t<< Factura Electronica >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipFacturaElecExen :
                                vDTrazasLog (szFuncion,"\n\t<< Factura Electronica Exenta >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipBoleta :
                                vDTrazasLog (szFuncion,"\n\t<< Boleta >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipBoletaExen :
                                vDTrazasLog (szFuncion,"\n\t<< Boleta Exenta >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipBoletaAuto :
                                vDTrazasLog (szFuncion,"\n\t<< Boleta Auto >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipBoletaAutoExen :
                                vDTrazasLog (szFuncion,"\n\t<< Boleta Auto Exenta >>",LOG05);						
				strcat(szCadenaSQL,szSUBCadena1);
				break;
			case iTipBoletaAuto69:             
                                vDTrazasLog (szFuncion,"\n\t<< Boleta Auto 69 >>",LOG05);
				strcat(szCadenaSQL,szSUBCadena1);		
				break;
			case iTipBoletaAuto73:             
                                vDTrazasLog (szFuncion,"\n\t<< Boleta Auto 73 >>",LOG05);
				strcat(szCadenaSQL,szSUBCadena1);		
				break;
			case 0 :
                                vDTrazasLog (szFuncion,"\n\t<< 0 >>",LOG05);			
				strcat(szCadenaSQL,szSUBCadena1);
				break;
	}
    }

    vDTrazasLog ( szFuncion, "\n\t** CadenaSQL  para Select en Open Docum.**\n\t%s"
	                , LOG04, szCadenaSQL);


    /* EXEC SQL PREPARE stConsultaDinamica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )144;
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



    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Fallo en 'PREPARE' de la Consulta Dinamica del Documento >>\n\t%s"
		            , LOG01,sqlca.sqlerrm.sqlerrmc);
	vDTrazasLog  (szFuncion, "<< Fallo en 'PREPARE' de la Consulta Dinamica del Documento >>"
		            , LOG01);
	return(SQLCODE);
    }

    /* EXEC SQL DECLARE CursorDocs CURSOR FOR stConsultaDinamica; */ 


    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Fallo en 'DECLARE' del Cursor de Documentos >>\n\t[%d] : [%s]"
		            , LOG01, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "<< Fallo en 'DECLARE' del Cursor de Documentos >>\n\t[%d] : [%s]"
		            , LOG01, SQLCODE,SQLERRM);
	return(SQLCODE);
    }

    vDTrazasLog ( szFuncion, "\n\t\t** Funcion ifnOpenDocumentos  **"
	                  "\n\t\t==>  TipDocum      [%d]"
	                  "\n\t\t==>  Fecha Inicio  [%s]"
	                  "\n\t\t==>  Fecha Fin     [%s]"
	                  "\n\t\t==>  Query [%s]"
	                , LOG04
	                , ihCodTipDocum
	                , szFecInicio
	                , szFecFin
	                , szCadenaSQL);

    if( bConParametros == TRUE )
    {
        vDTrazasLog (szFuncion,"\n\t<< Con Parametros TipDocum FecInicio FecFin >>",LOG05);
	/* EXEC SQL OPEN CursorDocs USING :ihCodTipDocum, :szhFecInicio, :szhFecFin ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 10;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )163;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecInicio;
 sqlstm.sqhstl[1] = (unsigned long )9;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecFin;
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


    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t<< Sin Parametros >>",LOG05);    	
	/* EXEC SQL OPEN CursorDocs ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 10;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )190;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    }

    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Fallo en 'OPEN' del Cursor de Documentos >>\n\t[%d] : [%s]"
		            , LOG01, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "<< Fallo en 'OPEN' del Cursor de Documentos >>\n\t[%d] : [%s]"
		            , LOG01, SQLCODE,SQLERRM);
	return(SQLCODE);
    }

    return(SQLOK );
}

/*********************************************************************/
/* FUNCION      : ifnFetchDocumentos                                 */
/*********************************************************************/
static int ifnFetchDocumentos( int          iTipDocumento,
                               GHISTDOCU    *pstGHistDocu,
                               LINEACOMANDO stLineaComando)
{
    char szFuncion[]="bfnOraGenLibro";    
    int  iNotaC     = 0;
    char szNomTabla[20];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 int    ihIndAnulada         ;
	 int    ihCodTipDocum        ;
	 long   lhIndOrdenTotal      ;
	 long   lhCodCiclFact        ;
	 char   szhPrefPlaza     [26];
	 long   lhNumFolio           ;
	 char   szhFecEmision    [15];  /* EXEC SQL VAR szhFecEmision IS STRING (15); */ 

	 double dhAcumNetoNoGrav     ;
	 double dhAcumNetoGrav       ;
	 double dhAcumIva            ;
	 double dhAcumIvaRet         ;	 
	 double dhTotDocumento       ;
	 long   lhCodVendedor        ;
	 int    ihCodTipDocumen      ;
	 char   szhCodOficina     [3];  /* EXEC SQL VAR szhCodOficina IS STRING (3); */ 

	 char   szhRowid         [19];
	 int    ihIndSupertel        ;
	 int    ihIndFactur          ;
	 long   lhCodCliente         ;
	 char   szhFecVencimiento[15];  /* EXEC SQL VAR szhFecVencimiento IS STRING (15); */ 

	 short  sihPrefPlaza         ;
    /* EXEC SQL END DECLARE SECTION  ; */ 


    GHISTCLIE stGHistClie;

    iNotaC = stDatosGener.iCodNotaCre;
    strcpy(szNomTabla,stLineaComando.szTabla);

    vDTrazasLog ( szFuncion,"\n\t** Funcion ifnFetchDocumentos. ",LOG05);

    /* EXEC SQL
	 FETCH CursorDocs 
	 INTO	:ihIndAnulada       ,
	        :lhIndOrdenTotal    ,
	        :ihCodTipDocum      ,
	        :lhCodCiclFact      ,
	        :szhPrefPlaza       : sihPrefPlaza,
	        :lhNumFolio         ,
	        :szhFecEmision      ,
	        :dhAcumNetoNoGrav   ,
	        :dhAcumNetoGrav     ,
	        :dhAcumIva          ,
	        :dhTotDocumento     ,
	        :lhCodVendedor      ,
	        :szhCodOficina      ,
	        :ihIndSupertel      ,
	        :ihIndFactur        ,
	        :szhRowid           ,
	        :lhCodCliente       ,
	        :szhFecVencimiento  ,
	        :dhAcumIvaRet       ,
	        :ihCodTipDocumen    ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )205;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[4] = (unsigned long )26;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&sihPrefPlaza;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecEmision;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhAcumNetoNoGrav;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&dhAcumNetoGrav;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&dhAcumIva;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTotDocumento;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhCodVendedor;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[12] = (unsigned long )3;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&ihIndSupertel;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihIndFactur;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[15] = (unsigned long )19;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhFecVencimiento;
    sqlstm.sqhstl[17] = (unsigned long )15;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&dhAcumIvaRet;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&ihCodTipDocumen;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
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



    if( (SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND) )
    {
	 vDTrazasLog  (szFuncion, "\n\t<< Error en Fetch Cursor Documento >>\n\t[%d] : [%s]"
	                     , LOG01,SQLCODE,SQLERRM);
	 vDTrazasError(szFuncion, "\n\t<< Error en Fetch Cursor Documento >>\n\t[%d] : [%s]"
	                     , LOG01,SQLCODE,SQLERRM);
	 return(SQLCODE);
    }
    
    if( SQLCODE == SQLNOTFOUND )
    {
	vDTrazasLog  (szFuncion,"\n\t<< Fin del Cursor de Documentos >>",LOG03);
	return(SQLCODE);
    }
    else
    {
	pstGHistDocu->iIndAnulada     = ihIndAnulada  ;
	pstGHistDocu->iCodTipDocum    = ihCodTipDocum ;
	pstGHistDocu->lCodCiclFact    = lhCodCiclFact ;

	if( sihPrefPlaza == ORA_NULL )	
	{
	    strcpy(pstGHistDocu->szPrefPlaza, "                         \0" );
	}
 	else
 	{
 	    strcpy(pstGHistDocu->szPrefPlaza, szhPrefPlaza);
 	}

	pstGHistDocu->lNumFolio       = lhNumFolio    ;
	pstGHistDocu->dAcumNetoNoGrav = (ihCodTipDocum == iNotaC ? dhAcumNetoNoGrav *-1 : dhAcumNetoNoGrav);
	pstGHistDocu->dAcumNetoGrav   = (ihCodTipDocum == iNotaC ? dhAcumNetoGrav   *-1 : dhAcumNetoGrav  );
	pstGHistDocu->dAcumIva        = (ihCodTipDocum == iNotaC ? dhAcumIva        *-1 : dhAcumIva       );
	pstGHistDocu->dAcumIvaRet     = (ihCodTipDocum == iNotaC ? dhAcumIvaRet     *-1 : dhAcumIvaRet    );		
	pstGHistDocu->dTotDocumento   = (ihCodTipDocum == iNotaC ? dhTotDocumento   *-1 : dhTotDocumento  );
	pstGHistDocu->iIndSupertel    = ihIndSupertel;
	pstGHistDocu->iIndFactur      = ihIndFactur  ;
	pstGHistDocu->lCodCliente     = lhCodCliente  ;
	strcpy(pstGHistDocu->szFecEmision    ,szhFecEmision);
	strcpy(pstGHistDocu->szRowid         ,szhRowid);
	strcpy(pstGHistDocu->szFecVencimiento,szhFecVencimiento);
	memset(&stGHistClie,0,sizeof(GHISTCLIE))    ;
	stGHistClie.lIndOrdenTotal    = lhIndOrdenTotal;
	stGHistClie.lCodCiclFact      = lhCodCiclFact  ;

	if( !bfnGetHistClie(&stGHistClie,stLineaComando) )
	{
	    return(iERROR_GETCLIENTE);
	}

	strcpy(pstGHistDocu->szNomCliente    ,stGHistClie.szNomCliente   );
	strcpy(pstGHistDocu->szRut           ,stGHistClie.szRut          );
	pstGHistDocu->lIndOrdenTotal  = stGHistClie.lIndOrdenTotal;
	strcpy(pstGHistDocu->szCodOficina   ,szhCodOficina);

	/* Tipo de Documento (28-47-25-45-46)*/
	if( strcmp(szNomTabla,HISTDOCU)!=0 )
	{
	    pstGHistDocu->iCodtipdocumalm = ihCodTipDocumen;
	}
	else
	{
	    switch( iTipDocumento )
	    {
		    case iTipFactura :
			 pstGHistDocu->iCodtipdocumalm = 28                          ; /* 28 */
			 break;
		    case iTipFacturaExen :
			 pstGHistDocu->iCodtipdocumalm = stDatosGener.iCodFacturaExen; /* 47 */
			 break;
		    case iTipNotaCred :
			 pstGHistDocu->iCodtipdocumalm = stDatosGener.iCodNotaCre    ; /* 25 */
			 break;
		    case iTipNotaAbon :
			 pstGHistDocu->iCodtipdocumalm = iCodNotaAbono               ; /* 91 */ /* P-MIX-09003 */ 
			 break;			 
		    case iTipFacturaElec :
			 pstGHistDocu->iCodtipdocumalm = 75                          ; /* 75 */ 
			 break;
		    case iTipFacturaElecExen :
			 pstGHistDocu->iCodtipdocumalm = 76                          ; /* 76 */ 
			 break;
		    case iTipBoleta :
			 pstGHistDocu->iCodtipdocumalm = stDatosGener.iCodBoleta     ; /* 45 */
			 break;
		    case iTipBoletaExen :
			 pstGHistDocu->iCodtipdocumalm = stDatosGener.iCodBoletaExen ; /* 46 */
			 break;
		    case iTipBoletaAuto :
			 pstGHistDocu->iCodtipdocumalm = iCodBoletaAuto              ; /* 69 */
			 break;
		    case iTipBoletaAutoExen :
			 pstGHistDocu->iCodtipdocumalm = iCodBoletaAutoExen          ; /* 73 */
			 break;
		    case iTipBoletaAuto69 :
			 pstGHistDocu->iCodtipdocumalm = 69                          ; /* 69 */
			 break;
		    case iTipBoletaAuto73 :
			 pstGHistDocu->iCodtipdocumalm = 73                          ; /* 73 */
			 break;
	    }
	}

	vDTrazasLog (szFuncion, "\n\t\tDatos Cargados"
		             "\n\t\tstGHistDocu->iIndAnulada......[%d]"
		             "\n\t\tstGHistDocu->iCodTipDocum.....[%d]"
		             "\n\t\tstGHistDocu->lNumFolio........[%ld]"
		             "\n\t\tstGHistDocu->lIndOrdenTotal...[%d]"
		             "\n\t\tstGHistDocu->szCodOficina.....[%s]"
		             "\n\t\tstGHistDocu->iCodtipdocumalm..[%d]"
		           , LOG03,pstGHistDocu->iIndAnulada
		           , pstGHistDocu->iCodTipDocum      ,pstGHistDocu->lNumFolio
		           , pstGHistDocu->lIndOrdenTotal    ,pstGHistDocu->szCodOficina
		           , pstGHistDocu->iCodtipdocumalm);

	vDTrazasLog (szFuncion, "\t\tstGHistDocu->dAcumNetoNoGrav..[%f]"
		             "\n\t\tstGHistDocu->dAcumNetoGrav....[%f]"
		             "\n\t\tstGHistDocu->dAcumIva.........[%f]"
		             "\n\t\tstGHistDocu->dAcumIvaRet......[%f]"		
		             "\n\t\tstGHistDocu->dTotDocumento....[%f]"
		             "\n\t\tstGHistDocu->szFecEmision.....[%s]"
		             "\n\t\tstGHistDocu->szNomCliente.....[%s]"
		             "\n\t\tstGHistDocu->szRut............[%s]"
		             "\n\t\tstGHistDocu->szRowid..........[%s]"
		             "\n\t\tstGHistDocu->lCodCiclFact.....[%ld]"
		             "\n\t\tstGHistDocu->iIndSupertel.....[%d]"
		             "\n\t\tstGHistDocu->iIndFactur.......[%d]"
		             "\n\t\tstGHistDocu->lCodCliente......[%ld]"
		             "\n\t\tstGHistDocu->szFecVencimiento.[%s]"
		           , LOG04,pstGHistDocu->dAcumNetoNoGrav
		           , pstGHistDocu->dAcumNetoGrav    ,pstGHistDocu->dAcumIva        ,pstGHistDocu->dAcumIvaRet
		           , pstGHistDocu->dTotDocumento    ,pstGHistDocu->szFecEmision
		           , pstGHistDocu->szNomCliente     ,pstGHistDocu->szRut
		           , pstGHistDocu->szRowid          ,pstGHistDocu->lCodCiclFact
		           , pstGHistDocu->iIndSupertel     ,pstGHistDocu->iIndFactur
		           , pstGHistDocu->lCodCliente      ,pstGHistDocu->szFecVencimiento);

	return(SQLCODE);

    }

}/*********************** Final ifnFetchDocumentos  *************************/

/*********************************************************************/
/* FUNCION      : bfnCloseDocumentos                                 */
/*********************************************************************/
static BOOL bfnCloseDocumentos()
{
    char szFuncion[]="bfnCloseDocumentos";

    vDTrazasLog (szFuncion,"\n\t** Close Cursor Documento " ,LOG04);

    /* EXEC SQL CLOSE CursorDocs; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )300;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "<< Error en Close Cursor Documento >>\n\t[%d] : [%s]"
		            , LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "<< Error en Close Cursor Documento >>\n\t[%d] : [%s]"
		            , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    return(TRUE);

}/*********************** Final bfnCloseDocumentos  *************************/

/*******************************************************************************************/
/* FUNCION     : bGetParamCodConceptoImpRet                                                */
/* DESCRIPCION : Recuperar parámetro Cod. Concepto Impuesto Retenido (674) desde           */
/*               Tabla FAD_PARAMETROS                                                      */
/*******************************************************************************************/
BOOL bGetParamCodConceptoImpRet (char *szValor)
{
    char szFuncion []= "bGetParamCodConceptoImpRet";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhValorParametro[512+1]; /* EXEC SQL VAR szhValorParametro   IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [32+1] ="";
    char szValParametro [512+1]="";
    int  iRes;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);

    /* Obtencion Valor Cod. de Concepto Impuesto Retenido */
    iRes = ifnGetParametro(674,szTipParametro,szhValorParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro de COD. CONCEPTO IMPUESTO RETENIDO 674 error [%d] **"
                                 , LOG01
                                 , iRes);
            return (FALSE);
        }
        strcpy(szValor,szhValorParametro);
    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t\t=> ADVETENCIA, No existe parámetro 674 COD. CONCEPTO IMPUESTO RETENIDO",LOG03);
        return (FALSE);
    }

    return (TRUE);
} /************************* FIN bGetParamCodConceptoImpRet ************************/

/*********************************************************************/
/* FUNCION      : bfnInsertaLibroIva                                 */
/*********************************************************************/
static BOOL bfnInsertaLibroIva( GHISTDOCU pstGHistDocu,
                                BOOL      *bInsert,
                                char      *szOrigen)
{
    char szFuncion []="bfnInsertaLibroIva";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int    ihCodtipdocumalm    ;
         char   szhPrefPlaza    [26];
         long   lhNumfolio          ;
         char   szhCodOficina    [3];
         int    ihIndanulada        ;
         long   lhIndordentotal     ;
         int    ihCodtipdocum       ;
         char   szhFecemision   [15];
         char   szhNumidenttrib [21];
         char   szhNomcliente   [91];
         double dhTotnetograv       ;
         double dhTotnetonograv     ;
         double dhTotiva            ;
         double dhTotivaret         ;    
         double dhTotfactura        ;
         long   lhCodCliente        ;
         char   szhFecVencimiento[15];
    /* EXEC SQL END DECLARE SECTION; */ 


    BOOL bExiste=FALSE;


    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnInsertaLibroIva ***\n",LOG04);

    if ((pstGHistDocu.iCodtipdocumalm!=stDatosGener.iCodFactura)      &&
        (pstGHistDocu.iCodtipdocumalm!=stDatosGener.iCodFacturaExen)  &&
        (pstGHistDocu.iCodtipdocumalm!=stDatosGener.iCodNotaCre)      &&
        (pstGHistDocu.iCodtipdocumalm!=stDatosGener.iCodBoleta)       &&
        (pstGHistDocu.iCodtipdocumalm!=stDatosGener.iCodBoletaExen)   &&
        (pstGHistDocu.iCodtipdocumalm!=iCodBoletaAuto)                &&
        (pstGHistDocu.iCodtipdocumalm!=iCodBoletaAutoExen)            &&
        (pstGHistDocu.iCodtipdocumalm!=iCodNotaAbono)                 &&        /* P-MIX-09003 */
        (pstGHistDocu.iCodtipdocumalm!=75)                            &&
        (pstGHistDocu.iCodtipdocumalm!=76)                            &&
        (pstGHistDocu.iCodtipdocumalm!=28)                            &&
        (pstGHistDocu.iCodtipdocumalm!=18)                            &&
        (pstGHistDocu.iCodtipdocumalm!=48)                            &&
        (pstGHistDocu.iCodtipdocumalm!=2))
    {
        vDTrazasLog (szFuncion, "\n\t*** Docto. se devuelve como insertado, tipdocumalm [%d] ***\n"
                              , LOG03
                              , pstGHistDocu.iCodtipdocumalm);
        return(TRUE);
    }

    strcpy(szhCodOficina    ,pstGHistDocu.szCodOficina)    ;
    strcpy(szhFecemision    ,pstGHistDocu.szFecEmision)     ;
    strcpy(szhNumidenttrib  ,pstGHistDocu.szRut )           ;
    strcpy(szhNomcliente    ,pstGHistDocu.szNomCliente)     ;
    strcpy(szhFecVencimiento,pstGHistDocu.szFecVencimiento) ;

    ihCodtipdocumalm  = pstGHistDocu.iCodtipdocumalm;
    strcpy(szhPrefPlaza,pstGHistDocu.szPrefPlaza);
    lhNumfolio        = pstGHistDocu.lNumFolio      ;
    ihIndanulada      = pstGHistDocu.iIndAnulada    ;
    lhIndordentotal   = pstGHistDocu.lIndOrdenTotal ;
    ihCodtipdocum     = pstGHistDocu.iCodTipDocum   ;
    dhTotnetograv     = pstGHistDocu.dAcumNetoGrav  ;
    dhTotnetonograv   = pstGHistDocu.dAcumNetoNoGrav;
    dhTotiva          = pstGHistDocu.dAcumIva       ;
    dhTotivaret       = pstGHistDocu.dAcumIvaRet    ;    
    dhTotfactura      = pstGHistDocu.dTotDocumento  ;
    lhCodCliente      = pstGHistDocu.lCodCliente    ;

    vDTrazasLog (szFuncion,"\n\t*** Datos a Insertar en FAT_DETLIBROIVA ***"
                           "\n\t\t ihIndanulada -------> [%d]"
                           "\n\t\t ihCodtipdocum ------> [%d]"
                           "\n\t\t lhNumfolio ---------> [%ld]"
                           "\n\t\t lhIndordentotal ----> [%ld]"
                           "\n\t\t dhTotnetonograv ----> [%f]"
                           "\n\t\t dhTotnetograv ------> [%f]"
                           "\n\t\t dhTotiva -----------> [%f]"
                           "\n\t\t dhTotiva ret -------> [%f]"                           
                           "\n\t\t dhTotfactura -------> [%f]"
                           "\n\t\t szhFecemision ------> [%s]"
                           "\n\t\t szhNomcliente ------> [%s]"
                           "\n\t\t szhNumidenttrib ----> [%s]"
                           "\n\t\t szhCodOficina ------> [%s]"
                           "\n\t\t ihCodtipdocumalm ---> [%d]"
                           "\n\t\t lhCodCliente -------> [%ld]"
                           "\n\t\t szhFecVencimiento --> [%s]"
                           ,LOG04,ihIndanulada    ,ihCodtipdocum
                           ,lhNumfolio            ,lhIndordentotal
                           ,dhTotnetonograv       ,dhTotnetograv
                           ,dhTotiva              ,dhTotivaret     ,dhTotfactura
                           ,szhFecemision         ,szhNomcliente
                           ,szhNumidenttrib       ,szhCodOficina
                           ,ihCodtipdocumalm      ,lhCodCliente
                           ,szhFecVencimiento );

    bExiste = bfnRegistroInsertado(pstGHistDocu);

    if( !bExiste )
    {
        /* EXEC SQL
        INSERT INTO FAT_DETLIBROIVA (
            COD_TIPDOCUMALM,
            PREF_PLAZA,
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
            TOT_IVARET,
            TOT_FACTURA,
            COD_CLIENTE,
            FEC_VENCIMIENTO)
        VALUES (
            :ihCodtipdocumalm,
            TRIM(:szhPrefPlaza),
            :lhNumfolio      ,
            :szhCodOficina   ,
            :ihIndanulada    ,
            :lhIndordentotal ,
            :ihCodtipdocum   ,
            TO_DATE(:szhFecemision,'dd/mm/yyyy') ,
            :szhNumidenttrib ,
            :szhNomcliente   ,
            :dhTotnetograv   ,
            :dhTotnetonograv ,
            :dhTotiva        ,
            :dhTotivaret     ,            
            :dhTotfactura    ,
            :lhCodCliente     ,
            TO_DATE(:szhFecVencimiento,'dd/mm/yyyy')); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 20;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into FAT_DETLIBROIVA (COD_TIPDOCUMALM,PREF_PLA\
ZA,NUM_FOLIO,COD_OFICINA,IND_ANULADA,IND_ORDENTOTAL,COD_TIPDOCUM,FEC_EMISION,N\
UM_IDENTTRIB,NOM_CLIENTE,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_IVARET,TOT_FA\
CTURA,COD_CLIENTE,FEC_VENCIMIENTO) values (:b0,trim(:b1),:b2,:b3,:b4,:b5,:b6,T\
O_DATE(:b7,'dd/mm/yyyy'),:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,TO_DATE(:b16,'d\
d/mm/yyyy'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )315;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodtipdocumalm;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
        sqlstm.sqhstl[1] = (unsigned long )26;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhNumfolio;
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
        sqlstm.sqhstv[4] = (unsigned char  *)&ihIndanulada;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhIndordentotal;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&ihCodtipdocum;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFecemision;
        sqlstm.sqhstl[7] = (unsigned long )15;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhNumidenttrib;
        sqlstm.sqhstl[8] = (unsigned long )21;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhNomcliente;
        sqlstm.sqhstl[9] = (unsigned long )91;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&dhTotnetograv;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhTotnetonograv;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&dhTotiva;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[12] = (         int  )0;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)&dhTotivaret;
        sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[13] = (         int  )0;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)&dhTotfactura;
        sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[14] = (         int  )0;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)&lhCodCliente;
        sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[15] = (         int  )0;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szhFecVencimiento;
        sqlstm.sqhstl[16] = (unsigned long )15;
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



        vDTrazasLog (szFuncion, "\n\t<<< Insertados en FAT_DETLIBROIVA >>>"
                                "\n\t\t Numfolio       [%ld]"
                                "\n\t\t Indordentotal  [%ld]"
                                ,LOG03,lhNumfolio, lhIndordentotal);
    }
    
    if( bExiste )
    {
        vDTrazasLog  (szFuncion, "\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
                                 "Tipo de Docto. [%d]   Numero Orden [%ld]"
                               , LOG01,SQLCODE,SQLERRM
                               , lhNumfolio
                               ,ihCodtipdocum
                               ,lhIndordentotal);
        *bInsert = FALSE;
        
        if( !bfnInsertaDuplicados(pstGHistDocu, szOrigen) )
            return(FALSE);
        
        if( !bfnUpdateaIndDuplicado(ihCodtipdocumalm,szhPrefPlaza,lhNumfolio, szOrigen) )
            return(FALSE);
        
        return(TRUE);
    }
    
    if( SQLCODE != SQLOK && !bExiste )
    {
        vDTrazasLog  (szFuncion,"\n\t\t<< Error en Insert de FAT_DETLIBROIVA >>\n\t\t[%d] : %s",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szFuncion,"\n\t\t<< Error en Insert de FAT_DETLIBROIVA >>\n\t\t[%d] : %s",LOG01,SQLCODE,SQLERRM);
        return(FALSE);
    }
    
    
    vDTrazasLog (szFuncion,"\n\t*** Fin de bfnInsertaLibroIva ***\n",LOG04);
    return(TRUE);
}

/*********************************************************************/
/* FUNCION      : bfnOficinaVendedor                                 */
/*********************************************************************/
static BOOL bfnOficinaVendedor( long lCodVendedor)
{
    char szFuncion[]="bfnOficinaVendedor";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhCodOficina [3] ;
	 long lhCodVendedor;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( szFuncion,"\n\t\t** Funcion bfnOficinaVendedor  **",LOG04);

    lhCodVendedor = lCodVendedor;

    /* EXEC SQL
	 SELECT COD_OFICINA
	 INTO   :szhCodOficina
	 FROM   VE_VENDEDORES
	 WHERE  COD_VENDEDOR = :lhCodVendedor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA into :b0  from VE_VENDEDORES where COD\
_VENDEDOR=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )398;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedor;
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



    if( SQLCODE == SQLOK )
    {
	strcpy(szCodOficina,szhCodOficina);
	vDTrazasLog ( szFuncion, "\t\t** Cod. Oficina : [%s]  **",LOG04,szCodOficina);
	return(TRUE);
    }
    
    if( (SQLCODE == SQLNOTFOUND) || (SQLCODE != SQLOK) )
    {
	 vDTrazasLog  (szFuncion, "\n\t\t<< Error al Seleccionar Codigo de Oficina >>\n\t\t[%d] : [%s]"
	                        , LOG01,SQLCODE,SQLERRM);
	 vDTrazasError(szFuncion, "\n\t\t<< Error al Seleccionar Codigo de Oficina >>\n\t\t[%d] : [%s]"
	                        , LOG01,SQLCODE,SQLERRM);
	 return(FALSE);
	}

}

/*********************************************************************/
/* FUNCION      : ifnOpenConsumos                                    */
/*********************************************************************/
static int ifnOpenConsumos( int  iTipDocumento, 
                            char *szFecInicio,
                            char *szFecFin)
{
    char szFuncion[]="ifnOpenConsumos";
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
    
    switch( iTipDocumento )
    {
	    case iTipFactura :
			ihCodTipDocumalm = 28                           ; /* 28 */
			break;
	    case iTipFacturaExen :
			ihCodTipDocumalm = stDatosGener.iCodFacturaExen ; /* 47;*/
			break;
	    case iTipNotaCred :
			ihCodTipDocumalm = stDatosGener.iCodNotaCre     ; /*  25  */
			break;
	    case iTipNotaAbon :
			ihCodTipDocumalm = iCodNotaAbono                ; /* 91 */ /* P-MIX-09003 */
			break;			
	    case iTipFacturaElec :
			ihCodTipDocumalm = 75                           ; /* 75 */
			break;
	    case iTipFacturaElecExen :
			ihCodTipDocumalm = 76                           ; /* 76 */
			break;
	    case iTipBoleta :
			ihCodTipDocumalm = stDatosGener.iCodBoleta      ; /* 45;*/
			break;
	    case iTipBoletaExen :
			ihCodTipDocumalm = stDatosGener.iCodBoletaExen  ; /* 46; */
			break;
	    case iTipBoletaAuto:
			ihCodTipDocumalm = iCodBoletaAuto               ; /* 69 */
			break;
	    case iTipBoletaAutoExen :
			ihCodTipDocumalm = iCodBoletaAutoExen           ; /* 73 */
			break;
	    case iTipBoletaAuto69:             
			ihCodTipDocumalm = 69                           ; /* 69 */	
			break;
	    case iTipBoletaAuto73:             
			ihCodTipDocumalm = 73                           ; /* 73 */	
			break;
	    default :
			bTipDocError=TRUE;
			break;
    }

    vDTrazasLog ( szFuncion, "\n\t\t** Funcion ifnOpenConsumos  **"
	                     "\n\t\t==>  Fecha Desde   [%s]"
	                     "\n\t\t==>  Fecha Hasta   [%s]"
	                     "\n\t\t==>  TipDocumalm   [%d]"
	                   , LOG04,szFecInicio, szFecFin,ihCodTipDocumalm);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    strcpy(szCadenaSQL, "\tSELECT nvl(COD_OFICINA,' '), \n"
	                "\t      TIP_DOCUM  , \n"
	                "\t      TRIM(PREF_PLAZA) , \n"
	                "\t      NUM_FOLIO  , \n"
	                "\t      TO_CHAR(FEC_CONSUMO,'DD/MM/YYYY'), \n"
	                "\t      IND_ANULACION, \n"
	                "\t      ROWID \n"
	                "\tFROM  AL_CONSUMO_DOCUMENTOS\n"
	                "\tWHERE FEC_CONSUMO  >= TO_DATE(:szhFecInicio, 'DDMMYYYY') \n"
	                "\tAND   FEC_CONSUMO  < TO_DATE(:szhFecFin, 'DDMMYYYY') \n"
	                "\tAND   TIP_DOCUM     = :ihCodTipDocumalm \n"
	                "\tAND   IND_ANULACION = 1 \n"
	                "\tAND   IND_LIBROIVA  = 0 \n");

    vDTrazasLog ( szFuncion, "\n\t** Cadena Sql **\n%s\n", LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE stAl_Consumos FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )421;
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


    
    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Error en 'PREPARE' de la Consulta Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "<< Error en 'PREPARE' de la Consulta Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	return(SQLCODE);
    }

    /* EXEC SQL DECLARE CursorConsumos CURSOR FOR stAl_Consumos; */ 

    
    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Error en 'DECLARE' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "<< Error en 'DECLARE' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	return(SQLCODE);
    }

    /* EXEC SQL OPEN CursorConsumos USING :szhFecInicio, :szhFecFin, :ihCodTipDocumalm ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )440;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[0] = (unsigned long )9;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumalm;
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


    
    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "<< Error en 'OPEN' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "<< Error en 'OPEN' del Cursor de Al_Consumo_Documentos >>\n\t[%d] : [%s]"
	                       , LOG01, SQLCODE,SQLERRM);
	return(SQLCODE);
    }

    vDTrazasLog ( szFuncion,"\n\t** Fin Funcion ifnOpenConsumos  **",LOG04);

    return(SQLOK );

}

/*********************************************************************/
/* FUNCION      : ifnFetchConsumos                                   */
/*********************************************************************/
static int ifnFetchConsumos( int       iTipDocumento,
                             GHISTDOCU *pstGHistDocu)
{
    char szFuncion[]="ifnFetchConsumos";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char   szhCodOficina    [3];
	 int    ihTipDocum          ;
	 char   szhPrefPlaza     [26];  
	 long   lhNumFolio           ;
	 char   szhFecConsumo   [15];  /* EXEC SQL VAR szhFecConsumo IS STRING (15); */ 

	 int    ihIndAnulacion       ;
	 char   szhRowid         [19];
    /* EXEC SQL END DECLARE SECTION  ; */ 


    vDTrazasLog ( szFuncion, "\n\t** Fetch Cursor Consumos **"
	                     "\n\t** => Tipo Documento [%d] **"
	                   , LOG04,iTipDocumento);

    /* EXEC SQL
	 FETCH CursorConsumos 
	 INTO  :szhCodOficina     ,
	       :ihTipDocum        ,
	       :szhPrefPlaza       ,
	       :lhNumFolio         ,
	       :szhFecConsumo     ,
	       :ihIndAnulacion     ,
	       :szhRowid           ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )467;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihTipDocum;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecConsumo;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihIndAnulacion;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[6] = (unsigned long )19;
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



    if( (SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND) )
    {
	 vDTrazasLog  (szFuncion, "\n\t<< Error en Fetch Cursor Consumos >>\n\t[%d] : [%s]"
	                        , LOG01,SQLCODE,SQLERRM);
	 vDTrazasError(szFuncion, "\n\t<< Error en Fetch Cursor Consumos >>\n\t[%d] : [%s]"
	 	                , LOG01,SQLCODE,SQLERRM);
	 return(SQLCODE);
    }

    if( SQLCODE == SQLNOTFOUND )
    {
	vDTrazasLog  (szFuncion, "\n\t<< Fin de Cursor Consumos de [%s]>>\n\t[%d] : [%s]"
	                       , LOG04,szNombreDocs[iTipDocumento],SQLCODE,SQLERRM);
	return(SQLCODE);
    }
    else
    {
	switch( iTipDocumento )
	{
		case iTipFactura :
				pstGHistDocu->iCodtipdocumalm = 28                ; /* 28 */
				break;
		case iTipFacturaExen :
				pstGHistDocu->iCodtipdocumalm = 47                ; /* 47 */
				break;
		case iTipNotaCred :
				pstGHistDocu->iCodtipdocumalm = 25                ; /* 25 */
				break;
		case iTipNotaAbon :
				pstGHistDocu->iCodtipdocumalm = iCodNotaAbono     ; /* 91 */ /* P-MIX-09003 */
				break;				
		case iTipFacturaElec :
				pstGHistDocu->iCodtipdocumalm = 75                ; /* 75 */
				break;
		case iTipFacturaElecExen :
				pstGHistDocu->iCodtipdocumalm = 76                ; /* 76 */
				break;
		case iTipBoleta :
				pstGHistDocu->iCodtipdocumalm = 45                ; /* 45 */
				break;
		case iTipBoletaExen :
				pstGHistDocu->iCodtipdocumalm = 46                ; /* 46 */
				break;
		case iTipBoletaAuto :
				pstGHistDocu->iCodtipdocumalm = iCodBoletaAuto    ; /* 69 */
				break;
		case iTipBoletaAutoExen :
				pstGHistDocu->iCodtipdocumalm = iCodBoletaAutoExen; /* 73 */
				break;
		case iTipBoletaAuto69:             
				pstGHistDocu->iCodtipdocumalm = 69                ; /* 69 */
				break;
		case iTipBoletaAuto73: 
				pstGHistDocu->iCodtipdocumalm = 73                ; /* 73 */
				break;
	}

	pstGHistDocu->iIndAnulada     = ihIndAnulacion ;
		pstGHistDocu->iCodTipDocum    = ihTipDocum    ;
		strcpy(pstGHistDocu->szPrefPlaza,szhPrefPlaza);
		pstGHistDocu->lNumFolio       = lhNumFolio     ;
		strcpy(pstGHistDocu->szFecEmision  ,szhFecConsumo) ;
		strcpy(pstGHistDocu->szCodOficina ,szhCodOficina);
		strcpy(pstGHistDocu->szRowid       ,szhRowid);

		memset(pstGHistDocu->szFecVencimiento,0, sizeof(pstGHistDocu->szFecVencimiento));  

		vDTrazasLog ( szFuncion, "\n\t\t** Datos Cargados **"
		                         "\n\t\t** stGHistDocu->szCodOficina......[%s]"
		                         "\n\t\t** stGHistDocu->iCodTipDocum.......[%d]"
		                         "\n\t\t** stGHistDocu->lNumFolio..........[%ld]"
		                         "\n\t\t** stGHistDocu->szFecEmision.......[%s]"
		                         "\n\t\t** stGHistDocu->iIndAnulada........[%d]"
		                         "\n\t\t** stGHistDocu->iCodtipdocumalm...[%d]"
		                         "\n\t\t** stGHistDocu->szRowid............[%s]"
		                       , LOG04                         ,pstGHistDocu->szCodOficina
		                       , pstGHistDocu->iCodTipDocum    ,pstGHistDocu->lNumFolio
		                       , pstGHistDocu->szFecEmision    ,pstGHistDocu->iIndAnulada
		                       , pstGHistDocu->iCodtipdocumalm ,pstGHistDocu->szRowid);


		vDTrazasLog ( szFuncion,"\n\t** Fin Fetch Cursor Documento Consumos **",LOG04);

		return(SQLCODE);
	}

}/*********************** Final ifnFetchConsumos  *************************/

/*********************************************************************/
/* FUNCION      : bfnCloseConsumos                                   */
/*********************************************************************/
static BOOL bfnCloseConsumos()
{
    char szFuncion[]="bfnCloseConsumos";

    vDTrazasLog (szFuncion, "\n\t** Close Cursor Consumos" ,LOG04);

    /* EXEC SQL CLOSE CursorConsumos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )510;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if( SQLCODE )
    {
	vDTrazasLog  (szFuncion, "<< Error en Close Cursor Consumos >>\n\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "<< Error en Close Cursor Consumos >>\n\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    return(TRUE);

}/*********************** Final bfnCloseConsumos  *************************/

/*********************************************************************/
/* FUNCION      : bfnInsertaConsumosenLibroIva                       */
/*********************************************************************/
static BOOL bfnInsertaConsumosenLibroIva( GHISTDOCU pstGHistDocu, 
                                          BOOL      *bInsert)
{
    char szFuncion[]="bfnInsertaConsumosenLibroIva";
    
    int  iCodtipdocumalm;
    BOOL bExiste = FALSE;    

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char   szhPrefPlaza     [26];
	 long   lhNumfolio          ;
	 char   szhCodOficina    [3];
	 int    ihIndanulada        ;
	 int    ihCodtipdocum       ;
	 char   szhFecemision   [15];
	 char   szhNomcliente   [50];
	 long   lhCodCliente         ;
	 char   szhFecVencimiento[15];/* EXEC SQL VAR szhFecVencimiento IS STRING (15); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

	
    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnInsertaConsumosenLibroIva ***\n",LOG04);

    iCodtipdocumalm = pstGHistDocu.iCodtipdocumalm;
    strcpy(szhCodOficina,pstGHistDocu.szCodOficina);
    strcpy(szhFecemision,pstGHistDocu.szFecEmision);
    strcpy(szhNomcliente,"DOCUMENTO ANULADO\0")      ;
    strcpy(szhPrefPlaza,pstGHistDocu.szPrefPlaza)      ;
	
    lhNumfolio       = pstGHistDocu.lNumFolio      ;
    ihIndanulada     = pstGHistDocu.iIndAnulada    ;
    ihCodtipdocum    = pstGHistDocu.iCodTipDocum   ;
    lhCodCliente      = pstGHistDocu.lCodCliente    ;

    vDTrazasLog ( szFuncion, "\n\t\t** Datos de Consumos a Insertar en FAT_DETLIBROIVA **"
	                     "\n\t\t** szhCodOficina......[%s]"
	                     "\n\t\t** ihCodtipdocum......[%d]"
	                     "\n\t\t** lhNumfolio.........[%ld]"
	                     "\n\t\t** szhFecemision......[%s]"
	                     "\n\t\t** ihIndanulada.......[%d]"
	                     "\n\t\t** szhNomcliente......[%s]"
	                     "\n\t\t** iCodtipdocumalm....[%d]"
	                     "\n\t\t** lCodCliente.........[%ld]"
	                     "\n\t\t** szFecVencimiento....[%s]"
	                   , LOG03,szhCodOficina
	                   , ihCodtipdocum ,lhNumfolio
	                   , szhFecemision ,ihIndanulada
	                   , szhNomcliente ,iCodtipdocumalm
	                   , lhCodCliente   ,szhFecVencimiento);

    vDTrazasLog  (szFuncion,"\n\t\t** A bfnRegistroInsertado \n",LOG03);

    bExiste = bfnRegistroInsertado(pstGHistDocu);

    if( !bExiste )
    {
	/* EXEC SQL
	     INSERT INTO FAT_DETLIBROIVA (
		                PREF_PLAZA,
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
		                TOT_IVARET,
		                TOT_FACTURA,
		                COD_CLIENTE,
		                FEC_VENCIMIENTO)
		       VALUES ( TRIM(:szhPrefPlaza)     ,
		                :lhNumfolio      ,
		                :szhCodOficina   ,
		                :ihIndanulada    ,
		                :ihCodtipdocum   ,
		                TO_DATE(:szhFecemision,'dd/mm/yyyy')  ,
		                :szhNomcliente   ,
		                :iCodtipdocumalm ,
		                0,
		                ' ',
		                0,
		                0,
		                0,
		                0,
		                0,
		                0,
		                sysdate ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FAT_DETLIBROIVA (PREF_PLAZA,NUM_FOLIO,COD_OFICIN\
A,IND_ANULADA,COD_TIPDOCUM,FEC_EMISION,NOM_CLIENTE,COD_TIPDOCUMALM,IND_ORDENTO\
TAL,NUM_IDENTTRIB,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_IVARET,TOT_FACTURA,C\
OD_CLIENTE,FEC_VENCIMIENTO) values (trim(:b0),:b1,:b2,:b3,:b4,TO_DATE(:b5,'dd/\
mm/yyyy'),:b6,:b7,0,' ',0,0,0,0,0,0,sysdate)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )525;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[0] = (unsigned long )26;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNumfolio;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihIndanulada;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodtipdocum;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhFecemision;
 sqlstm.sqhstl[5] = (unsigned long )15;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhNomcliente;
 sqlstm.sqhstl[6] = (unsigned long )50;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&iCodtipdocumalm;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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


    }
    else
    {
	vDTrazasLog  (szFuncion, "\n\t\t<< Registro Duplicado >>\n\t\t[%d] : %s\t\tNum Folio [%ld]  "
	                         "Tipo de Docto Almacen. [%d]"
	                       , LOG03,SQLCODE,SQLERRM,lhNumfolio,iCodtipdocumalm);
	*bInsert = FALSE;

	if( !bfnInsertaDuplicados(pstGHistDocu, CONSU) )
	    return(FALSE);

	if( !bfnUpdateaIndDuplicado(iCodtipdocumalm,szhPrefPlaza,lhNumfolio, CONSU) )
	    return(FALSE);

	return(TRUE);
    }

    if( SQLCODE != SQLOK && !bExiste )
    {
	vDTrazasLog  (szFuncion, "\n\t\t<< Error al Insertar Consumos en FAT_DETLIBROIVA >>\n\t\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "\n\t\t<< Error al Insertar Consumos en FAT_DETLIBROIVA >>\n\t\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    vDTrazasLog (szFuncion,"\n\t*** Fin de bfnInsertaConsumosenLibroIva ***\n",LOG04);

    return(TRUE);
}

/*********************************************************************/
/* FUNCION      : bfnInsertaDuplicados                               */
/*********************************************************************/
static BOOL bfnInsertaDuplicados( GHISTDOCU pstGHistDocu, 
                                  char      *szOrigen)
{
    char szFuncion[]="bfnInsertaDuplicados";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 int    ihCodtipdocumalm     ;
	 char   szhPrefPlaza      [26];
	 long   lhNumfolio           ;
	 char   szhCodOficina     [3];
	 int    ihIndanulada         ;
	 long   lhIndordentotal      ;
	 int    ihCodtipdocum        ;
	 char   szhFecemision    [15];
	 char   szhNumidenttrib  [21];
	 char   szhNomcliente    [61];
	 double dhTotnetograv        ;
	 double dhTotnetonograv      ;
	 double dhTotiva             ;
	 double dhTotivaret          ;	     
	 double dhTotfactura         ;
	 char   szhOrigen          [2];
	 long   lhCodCliente          ;
	 char   szhFecVencimiento [15];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnInsertaDuplicados ***",LOG04);

    strcpy(szhCodOficina   ,pstGHistDocu.szCodOficina)    ;
    strcpy(szhFecemision   ,pstGHistDocu.szFecEmision)     ;
    strcpy(szhNumidenttrib ,pstGHistDocu.szRut )           ;
    strcpy(szhNomcliente   ,pstGHistDocu.szNomCliente)     ;
    strcpy(szhOrigen        ,szOrigen)                      ;
    strcpy(szhFecVencimiento,pstGHistDocu.szFecVencimiento) ;

    ihCodtipdocumalm = pstGHistDocu.iCodtipdocumalm;
    strcpy(szhPrefPlaza,pstGHistDocu.szPrefPlaza)      ;
    lhNumfolio       = pstGHistDocu.lNumFolio      ;
    ihIndanulada     = pstGHistDocu.iIndAnulada    ;
    lhIndordentotal  = pstGHistDocu.lIndOrdenTotal ;
    ihCodtipdocum    = pstGHistDocu.iCodTipDocum   ;
    dhTotnetograv    = pstGHistDocu.dAcumNetoGrav  ;
    dhTotnetonograv  = pstGHistDocu.dAcumNetoNoGrav;
    dhTotiva         = pstGHistDocu.dAcumIva       ;
    dhTotivaret      = pstGHistDocu.dAcumIvaRet    ;	
    dhTotfactura     = pstGHistDocu.dTotDocumento  ;
    lhCodCliente     = pstGHistDocu.lCodCliente    ;

    vDTrazasLog ( szFuncion, "\n\t**** Datos a Insertar en FAT_DUPLIBROIVA ***"
	                     "\n\t\t** ihIndanulada ------> [%d]"
	                     "\n\t\t** ihCodtipdocum -----> [%d]"
	                     "\n\t\t** lhNumfolio --------> [%ld]"
	                     "\n\t\t** lhIndordentotal ---> [%ld]"
	                     "\n\t\t** dhTotnetonograv ---> [%f]"
	                     "\n\t\t** dhTotnetograv -----> [%f]"
	                     "\n\t\t** dhTotiva ----------> [%f]"
	                     "\n\t\t** dhTotivaret -------> [%f]"	
	                     "\n\t\t** dhTotfactura ------> [%f]"
	                     "\n\t\t** szhFecemision -----> [%s]"
	                     "\n\t\t** szhNomcliente -----> [%s]"
	                     "\n\t\t** szhNumidenttrib ---> [%s]"
	                     "\n\t\t** szhCodOficina -----> [%s]"
	                     "\n\t\t** ihCodtipdocumalm --> [%d]"
	                     "\n\t\t** szhOrigen-----------> [%s]"
	                     "\n\t\t** lhCodCliente--------> [%ld]"
	                     "\n\t\t** szhFecVencimiento---> [%s]"
	                   , LOG04,ihIndanulada   ,ihCodtipdocum
	                   , lhNumfolio           ,lhIndordentotal
	                   , dhTotnetonograv      ,dhTotnetograv
	                   , dhTotiva             ,dhTotivaret      ,dhTotfactura
	                   , szhFecemision        ,szhNomcliente
	                   , szhNumidenttrib      ,szhCodOficina
	                   , ihCodtipdocumalm     ,szhOrigen
	                   , lhCodCliente         ,szhFecVencimiento );


    /* EXEC SQL
	 INSERT INTO FAT_DUPLIBROIVA (
	              COD_TIPDOCUMALM,
	              PREF_PLAZA,
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
	              TOT_IVARET,	
	              TOT_FACTURA,
	              COD_ORIGEN,
	              COD_CLIENTE,
	              FEC_VENCIMIENTO
	             )
	VALUES (      :ihCodtipdocumalm,
	              TRIM(:szhPrefPlaza)      ,
	              :lhNumfolio      ,
	              :szhCodOficina   ,
	              :ihIndanulada    ,
	              :lhIndordentotal ,
	              :ihCodtipdocum   ,
	              TO_DATE(:szhFecemision,'dd/mm/yyyy') ,
	              :szhNumidenttrib ,
	              :szhNomcliente   ,
	              :dhTotnetograv   ,
	              :dhTotnetonograv ,
	              :dhTotiva        ,
	              :dhTotivaret     ,	
	              :dhTotfactura    ,
	              :szhOrigen        ,
	              :lhCodCliente     ,
	              TO_DATE(:szhFecVencimiento,'dd/mm/yyyy') ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DUPLIBROIVA (COD_TIPDOCUMALM,PREF_PLAZA,N\
UM_FOLIO,COD_OFICINA,IND_ANULADA,IND_ORDENTOTAL,COD_TIPDOCUM,FEC_EMISION,NUM_I\
DENTTRIB,NOM_CLIENTE,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_IVARET,TOT_FACTUR\
A,COD_ORIGEN,COD_CLIENTE,FEC_VENCIMIENTO) values (:b0,trim(:b1),:b2,:b3,:b4,:b\
5,:b6,TO_DATE(:b7,'dd/mm/yyyy'),:b8,:b9,:b10,:b11,:b12,:b13,:b14,:b15,:b16,TO_\
DATE(:b17,'dd/mm/yyyy'))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )572;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodtipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumfolio;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihIndanulada;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhIndordentotal;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodtipdocum;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecemision;
    sqlstm.sqhstl[7] = (unsigned long )15;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumidenttrib;
    sqlstm.sqhstl[8] = (unsigned long )21;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhNomcliente;
    sqlstm.sqhstl[9] = (unsigned long )61;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTotnetograv;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&dhTotnetonograv;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&dhTotiva;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&dhTotivaret;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&dhTotfactura;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhOrigen;
    sqlstm.sqhstl[15] = (unsigned long )2;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhFecVencimiento;
    sqlstm.sqhstl[17] = (unsigned long )15;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
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



    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "\n\t\t<< Error al Insertar Duplicados en FAT_DUPLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion, "\n\t\t<< Error al Insertar Duplicados en FAT_DUPLIBROIVA >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    vDTrazasLog (szFuncion,"\n\t*** Fin de bfnInsertaDuplicados ***\n",LOG04);
    return(TRUE);
}

/*********************************************************************/
/* FUNCION      : bfnUpdateIndLibro                                  */
/*********************************************************************/
static BOOL bfnUpdateIndLibro( char      *szNomTabla, 
                               GHISTDOCU stGHistDocu, 
                               BOOL      OptInsert, 
                               BOOL      BFlagOficina)
{
    char szFuncion[]="bfnUpdateIndLibro";
    static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char   szhNomTabla  [20];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnUpdateIndLibro ***\n",LOG05);

    strcpy(szhNomTabla,szNomTabla);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    if( (strcmp(szhNomTabla,NOCICLO)==0) || (strcmp(szhNomTabla,HISTDOCU)==0) )
    {
	sprintf(szCadenaSQL,"%s UPDATE %s SET \n",szCadenaSQL,szhNomTabla);
    }
    else
    {
	sprintf(szCadenaSQL,"%s UPDATE FA_FACTDOCU_%s SET \n",szCadenaSQL,szhNomTabla);
    }

    if( BFlagOficina )
    {
	if( strcmp(szhNomTabla,NOCICLO)==0 )
	{
	    if( !OptInsert )
	    {
		sprintf(szCadenaSQL,"%s\t IND_LIBROIVA    = 2\n",szCadenaSQL);
		sprintf(szCadenaSQL,"%s\t WHERE PREF_PLAZA = TRIM('%s')\n",szCadenaSQL,stGHistDocu.szPrefPlaza);
		sprintf(szCadenaSQL,"%s\t   AND NUM_FOLIO = '%ld'\n",szCadenaSQL,stGHistDocu.lNumFolio);
	    }
	    else
	    {
		if( (stGHistDocu.iCodtipdocumalm==stDatosGener.iCodFactura)    ||
		    (stGHistDocu.iCodtipdocumalm==stDatosGener.iCodFacturaExen)||
		    (stGHistDocu.iCodtipdocumalm==stDatosGener.iCodNotaCre)    ||
		    (stGHistDocu.iCodtipdocumalm==91)                          ||		    
		    (stGHistDocu.iCodtipdocumalm==stDatosGener.iCodBoleta)     ||
		    (stGHistDocu.iCodtipdocumalm==iCodFacturaOLD)              ||
		    (stGHistDocu.iCodtipdocumalm==stDatosGener.iCodBoletaExen) )
		{
		     sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 1\n",szCadenaSQL);
		}
		else
		{
		     sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 3\n",szCadenaSQL);
		}
		sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
	    }

	}
	else
	{
	    if( !OptInsert )
	    {
		sprintf(szCadenaSQL,"%s\t IND_LIBROIVA    = 2\n",szCadenaSQL);
		sprintf(szCadenaSQL,"%s\t WHERE PREF_PLAZA = TRIM('%s')\n",szCadenaSQL,stGHistDocu.szPrefPlaza);
		sprintf(szCadenaSQL,"%s\t   AND NUM_FOLIO = '%ld'\n",szCadenaSQL,stGHistDocu.lNumFolio);
	    }
	    else
	    {
		sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 1\n",szCadenaSQL);
		sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
	    }

	}

    }
    else
    {
	/* Indica que documento es de consignacion*/
	sprintf(szCadenaSQL,"%s\t IND_LIBROIVA = 3\n",szCadenaSQL);
	sprintf(szCadenaSQL,"%s\t WHERE ROWID  = '%s'\n",szCadenaSQL,stGHistDocu.szRowid);
    }

    vDTrazasLog (szFuncion,"\n\t*** CadenaSQL de bfnUpdateIndLibro ***\n\t%s",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE stUpdateTabla FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )659;
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



    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "\n\t<< Error en 'PREPARE' de Update en Tabla [%s] >>\n\t[%d] : [%s]"
	                       , LOG01,szhNomTabla, SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "\n\t<< Error en 'PREPARE' de Update en Tabla [%s] >>\n\t[%d] : [%s]"
	                       , LOG01,szhNomTabla, SQLCODE,SQLERRM);
	return(FALSE);
    }

    /* EXEC SQL EXECUTE stUpdateTabla ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )678;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if( SQLCODE )
    {
	vDTrazasError(szFuncion, "\n\t<< Error en 'EXECUTE' del Update en Tabla [%s] >>\n\t[%d] : [%s]"
	                       , LOG01,szhNomTabla,SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "\n\t<< Error en 'EXECUTE' del Update en Tabla [%s] >>\n\t[%d] : [%s]"
	                       , LOG01,szhNomTabla,SQLCODE,SQLERRM);
	return(FALSE);
    }

    vDTrazasLog (szFuncion, "\n\t*** Update Ind_Libroiva OK ***\n",LOG04);

    return(TRUE);

}/*  fin  bfnUpdateIndLibro */

/*********************************************************************/
/* FUNCION      : bfnUpdateIndConsumosLibroIva                       */
/*********************************************************************/
static BOOL bfnUpdateIndConsumosLibroIva( GHISTDOCU stGHistDocu, 
                                          BOOL      OptInsert)
{
    char szFuncion[]="bfnUpdateIndConsumosLibroIva";
    static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char  szhNomTabla     [20];
	 char  szhPrefPlaza    [26];
	 long  lhNumFolio          ;
	 long  ihIndAnulada        ;
	 int   ihCodTipDocum       ;
	 int   lhIndOrdenTotal     ;
	 char  szhRowid        [19];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnUpdateIndConsumosLibroIva***\n",LOG04);

    strcpy(szhPrefPlaza,stGHistDocu.szPrefPlaza);
    lhNumFolio      = stGHistDocu.lNumFolio     ;
    ihIndAnulada    = stGHistDocu.iIndAnulada   ;
    ihCodTipDocum   = stGHistDocu.iCodTipDocum  ;
    lhIndOrdenTotal = stGHistDocu.lIndOrdenTotal;
    strcpy(szhRowid,stGHistDocu.szRowid);

    vDTrazasLog (szFuncion, "\n\t*** lhNumFolio    [%ld]***"
	                    "\n\t*** ihIndAnulada  [%ld]***"
	                    "\n\t*** ihCodTipDocum [%ld]***"
	                  , LOG04
	                  , lhNumFolio
	                  , ihIndAnulada
	                  , ihCodTipDocum);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    if( !OptInsert )
    {
	/* EXEC SQL
	     UPDATE AL_CONSUMO_DOCUMENTOS 
	            SET IND_LIBROIVA   = 2
	     WHERE  ROWID  = :szhRowid; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update AL_CONSUMO_DOCUMENTOS  set IND_LIBROIVA=2 where ROWID\
=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )693;
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


    }
    else
    {
	/* EXEC SQL
	     UPDATE AL_CONSUMO_DOCUMENTOS 
	            SET IND_LIBROIVA   = 1
	WHERE  ROWID = :szhRowid; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update AL_CONSUMO_DOCUMENTOS  set IND_LIBROIVA=1 where ROWID\
=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )712;
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


    }

    if( SQLCODE != SQLCODE )
    {
	vDTrazasError(szFuncion, "\n\t<< Error en 'UPDATE' de Tabla [AL_CONSUMO_DOCUMENTOS] >>\n\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	vDTrazasLog  (szFuncion, "\n\t<< Error en 'UPDATE' de Tabla [AL_CONSUMO_DOCUMENTOS] >>\n\t[%d] : [%s]"
		               , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    return(TRUE);
}
/* FIN bfnUpdateIndConsumosLibroIva */

/*********************************************************************/
/* FUNCION      : bfnUpdateaIndDuplicado                             */
/*********************************************************************/
static BOOL bfnUpdateaIndDuplicado( int  iCodtipdocumalm, 
                                    char *szPrefPlaza, 
                                    long lNumfolio, 
                                    char *szOrigen)
{
    char szFuncion[]="bfnUpdateaIndDuplicado";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char   szhOrigen          [2];
	 char   szhPrefPlaza      [26];
	 long   lhNumfolio           ;
	 int    ihCodtipdocumalm     ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szFuncion,"\n\t*** Inicio de bfnUpdateaIndDuplicado ***\n",LOG04);
    vDTrazasLog (szFuncion,"\t**** Numero de Folio : [%ld] ***\n",LOG03,lNumfolio);

    ihCodtipdocumalm = iCodtipdocumalm ;
    strcpy(szhPrefPlaza,szPrefPlaza);
    lhNumfolio = lNumfolio ;
    strcpy(szhOrigen,szOrigen);	/* N=Nociclo  C=Ciclo  H=Historico A=Consumos*/

    /*Inserta registro duplicado. Si ya existe solo Updateara  */
    /* EXEC SQL
	     INSERT INTO FAT_DUPLIBROIVA(
	                 COD_TIPDOCUMALM,  NUM_FOLIO,
	                 COD_OFICINA,      IND_ANULADA,
	                 IND_ORDENTOTAL,   COD_TIPDOCUM,
	                 FEC_EMISION,      NUM_IDENTTRIB,
	                 NOM_CLIENTE,      TOT_NETOGRAV,
	                 TOT_NETONOGRAV,   TOT_IVA,	            
	                 TOT_FACTURA,      COD_ORIGEN,
	                 COD_CLIENTE,      FEC_VENCIMIENTO,
	                 PREF_PLAZA, TOT_IVARET
	                 )
	     SELECT COD_TIPDOCUMALM,        NUM_FOLIO,
	            COD_OFICINA,            IND_ANULADA,
	            IND_ORDENTOTAL,         COD_TIPDOCUM,
	            FEC_EMISION,            NUM_IDENTTRIB,
	            NOM_CLIENTE,            TOT_NETOGRAV,
	            TOT_NETONOGRAV,         TOT_IVA,	            
	            TOT_FACTURA,            :szhOrigen,
	            COD_CLIENTE,            FEC_VENCIMIENTO,
	            TRIM(PREF_PLAZA),       TOT_IVARET	            
	     FROM   FAT_DETLIBROIVA
	     WHERE  COD_TIPDOCUMALM = :ihCodtipdocumalm
	     AND    PREF_PLAZA      = TRIM(:szhPrefPlaza)
	     AND    NUM_FOLIO       = :lhNumfolio
	     AND    IND_DUPLICADO   = 'N'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAT_DUPLIBROIVA (COD_TIPDOCUMALM,NUM_FOLIO,CO\
D_OFICINA,IND_ANULADA,IND_ORDENTOTAL,COD_TIPDOCUM,FEC_EMISION,NUM_IDENTTRIB,NO\
M_CLIENTE,TOT_NETOGRAV,TOT_NETONOGRAV,TOT_IVA,TOT_FACTURA,COD_ORIGEN,COD_CLIEN\
TE,FEC_VENCIMIENTO,PREF_PLAZA,TOT_IVARET)select COD_TIPDOCUMALM ,NUM_FOLIO ,CO\
D_OFICINA ,IND_ANULADA ,IND_ORDENTOTAL ,COD_TIPDOCUM ,FEC_EMISION ,NUM_IDENTTR\
IB ,NOM_CLIENTE ,TOT_NETOGRAV ,TOT_NETONOGRAV ,TOT_IVA ,TOT_FACTURA ,:b0 ,COD_\
CLIENTE ,FEC_VENCIMIENTO ,trim(PREF_PLAZA) ,TOT_IVARET  from FAT_DETLIBROIVA w\
here (((COD_TIPDOCUMALM=:b1 and PREF_PLAZA=trim(:b2)) and NUM_FOLIO=:b3) and I\
ND_DUPLICADO='N')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )731;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodtipdocumalm;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumfolio;
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




    /*Actualiza registro duplicado con ind_duplicado = S*/
    /* EXEC SQL
	    UPDATE FAT_DETLIBROIVA SET
	           IND_DUPLICADO = 'S'
	    WHERE  COD_TIPDOCUMALM = :ihCodtipdocumalm
	    AND    PREF_PLAZA = TRIM(:szhPrefPlaza)
	    AND    NUM_FOLIO = :lhNumfolio ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FAT_DETLIBROIVA  set IND_DUPLICADO='S' where ((COD\
_TIPDOCUMALM=:b0 and PREF_PLAZA=trim(:b1)) and NUM_FOLIO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )762;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodtipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumfolio;
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



    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion,"\n\t\t<< Error al Updatear Ind Duplicado de Fat_DetLibroIva >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	vDTrazasError(szFuncion,"\n\t\t<< Error al Updatear Ind Duplicado de Fat_DetLibroIva >>\n\t\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    vDTrazasLog (szFuncion,"\t**** Fin de bfnUpdateaIndDuplicado ****\n",LOG04);
    return(TRUE);
}

/*********************************************************************/
/* FUNCION      : bfnLlenaArchivoImpresion                           */
/*********************************************************************/
static BOOL bfnLlenaArchivoImpresion( char *szFecInicio, 
                                      char *szFecFin)
{
    char szFuncion[]="bfnLlenaArchivoImpresion";
    static char szCadenaSQL[2048];
    int       iSqlLibroIva        =0;
    int       iNumPag             =1;
    int       iDoc                =0;
    long      lConReg             =0;
    long      lTotReg             =0;
    int       iCantRegs           =0;
    int       i                   =0;
    int       iCargaFile          =0;
    short     iIndPrefFolio       =0;
    long      lNumReg             =0;
    int       iCodTipDocumAlm     =0;
    GHISTDOCU stGHistDocu           ;    

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhFecInicio                      [8+1]; /* EXEC SQL VAR szhFecInicio IS STRING (9+1); */ 

	 char szhFecFin                         [8+1]; /* EXEC SQL VAR szhFecFin    IS STRING (9+1); */ 

	 int  ihCodtipdocumalm                       ;
	 char szhCodOficina                     [2+1];
	 char szhDesOficina                    [40+1];
	 /* VARCHAR szahCodOficina [MAX_REGISTROS] [2+1]; */ 
struct { unsigned short len; unsigned char arr[6]; } szahCodOficina[500];

	 /* VARCHAR szahDesOficina [MAX_REGISTROS][40+1]; */ 
struct { unsigned short len; unsigned char arr[42]; } szahDesOficina[500];

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( szFuncion,"\n\t\t** Funcion bfnLlenaArchivoImpresion  **",LOG04);

    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   ,szFecFin)  ;
    strcpy(szDiaAux,"\0");

    if( ifnGetParametro2 (104, szTipParametro, szValParametro) )
    {
	vDTrazasError(szFuncion,"\n\tError en obtencion de indicador de mascara de pref.folio  [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }
	
    iIndPrefFolio=atoi(szValParametro);

    memset(szahCodOficina,0,sizeof(szahCodOficina));

    /* EXEC SQL
	     SELECT COD_OFICINA,
	            DES_OFICINA
	     INTO   :szahCodOficina,
	            :szahDesOficina
	     FROM   GE_OFICINAS
	     WHERE  COD_OFICINA IN (SELECT COD_OFICINA FROM FAT_DETLIBROIVA
	                            WHERE FEC_EMISION >= TO_DATE(:szhFecInicio,'ddmmyyyy')
	     AND   FEC_EMISION <  TO_DATE(:szhFecFin   ,'ddmmyyyy'))
	     ORDER BY COD_REGION, COD_COMUNA , COD_OFICINA ASC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA ,DES_OFICINA into :b0,:b1  from GE_OFI\
CINAS where COD_OFICINA in (select COD_OFICINA  from FAT_DETLIBROIVA where (FE\
C_EMISION>=TO_DATE(:b2,'ddmmyyyy') and FEC_EMISION<TO_DATE(:b3,'ddmmyyyy'))) o\
rder by COD_REGION,COD_COMUNA,COD_OFICINA asc  ";
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )789;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szahCodOficina;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )8;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szahDesOficina;
    sqlstm.sqhstl[1] = (unsigned long )43;
    sqlstm.sqhsts[1] = (         int  )44;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[2] = (unsigned long )10;
    sqlstm.sqhsts[2] = (         int  )10;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecFin;
    sqlstm.sqhstl[3] = (unsigned long )10;
    sqlstm.sqhsts[3] = (         int  )10;
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



    iCantRegs = SQLROWS;

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
	vDTrazasError(szFuncion,"\n\t<< Error en Select de Codigos de Oficina >>\n\t",LOG01);
	vDTrazasLog  (szFuncion,"\n\t<< Select de Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
	return(FALSE);
    }
	
    if( (SQLCODE == SQLNOTFOUND) && (iCantRegs == 0) )
    {
	 vDTrazasError(szFuncion,"\n\t<< No Existen Codigos de Oficina >>\n\t",LOG01);
	 vDTrazasLog  (szFuncion,"\n\t<< No Existen Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
	 return(FALSE);
    }

    vDTrazasLog ( szFuncion, "\n\t** Cantidad de Registros en LlenaArchivoImpresion  [%d]**"
	                     "\t** SQLCODE  en LlenaArchivoImpresion  [%d]**"
	                   , LOG06,iCantRegs,SQLCODE);

    for( i=0;i<iCantRegs;i++ )/* for 1 */
    {
	 memset(&stTotTipDoc   ,0,sizeof(GTOTTIPDOCUM)*NUM_TIPDOCUM);
	 memset(&stAcumulador  ,0,sizeof(GACUMULADOR ));
	 
	 memset(szhCodOficina  ,0,sizeof(szhCodOficina));
	 sprintf(szhCodOficina,"%.*s\0",szahCodOficina[i].len, szahCodOficina[i].arr);

	 memset(szhDesOficina  ,0,sizeof(szhDesOficina));
	 sprintf(szhDesOficina,"%.*s\0",szahDesOficina[i].len, szahDesOficina[i].arr);

	 vDTrazasLog ( szFuncion,"\n\t** szhCodOficina  [%s %s]**",LOG06,szhCodOficina,szhDesOficina);

        lConReg = 0 ;

        memset(szCadenaSQL,0,sizeof(szCadenaSQL));

        strcpy(szCadenaSQL, "\tSELECT COD_TIPDOCUMALM,\n"
	                "\t       TRIM(PREF_PLAZA),\n"
			"\t       NUM_FOLIO,\n"
			"\t       COD_OFICINA,\n"
			"\t       IND_ANULADA,\n"
			"\t       IND_ORDENTOTAL,\n"
			"\t       COD_TIPDOCUM,\n"
			"\t       TO_CHAR(FEC_EMISION,'dd/mm/yyyy'),\n"
			"\t       NUM_IDENTTRIB,\n"
			"\t       NOM_CLIENTE,\n"
			"\t       TOT_NETOGRAV,\n"
			"\t       TOT_NETONOGRAV,\n"
			"\t       TOT_IVA,\n"
			"\t       TOT_IVARET,\n"			                   
			"\t       TOT_FACTURA,\n"
			"\t       TO_CHAR(FEC_EMISION,'DD'),\n"
			"\t       TO_CHAR(FEC_EMISION,'mm/yyyy')\n"			         
			"\tFROM   FAT_DETLIBROIVA\n"
			"\tWHERE  FEC_EMISION  >= TO_DATE(:szhFecInicio,'ddmmyyyy') \n"
			"\tAND    FEC_EMISION  < TO_DATE(:szhFecFin,'ddmmyyyy')\n"
			"\tAND    COD_OFICINA     = :szhCodOficina\n"
			"\tAND    IND_DUPLICADO   = 'N'\n"
			"\tORDER BY COD_TIPDOCUMALM asc, FEC_EMISION, NUM_FOLIO \n");

        vDTrazasLog ( szFuncion,"\n\t** Cadena Sql **\n%s\n",LOG04,szCadenaSQL);

	/* EXEC SQL PREPARE stLibroIva FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )820;
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


			
	if( SQLCODE != SQLOK )
	{
	    vDTrazasError(szFuncion, "\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]"
		                   , LOG01,SQLCODE,SQLERRM);
	    vDTrazasLog  (szFuncion, "\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]"
		                   , LOG01, SQLCODE,SQLERRM);
            return(FALSE);
	}

	/* EXEC SQL DECLARE  CursorLibroIva CURSOR FOR stLibroIva; */ 

			
	if( SQLCODE != SQLOK )
	{
	    vDTrazasError(szFuncion, "\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]"
	                           , LOG01, SQLCODE,SQLERRM);
	    vDTrazasLog  (szFuncion, "\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]"
		                   , LOG01, SQLCODE,SQLERRM);
	    return(FALSE);
	}

	/* EXEC SQL OPEN CursorLibroIva USING :szhFecInicio, :szhFecFin, 
	                                   :szhCodOficina; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )839;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFecInicio;
 sqlstm.sqhstl[0] = (unsigned long )10;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecFin;
 sqlstm.sqhstl[1] = (unsigned long )10;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[2] = (unsigned long )3;
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


			
	if( SQLCODE != SQLOK )
	{
	    vDTrazasError(szFuncion, "\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]"
		                   , LOG01, SQLCODE,SQLERRM);
            vDTrazasLog  (szFuncion, "\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]"
		                   , LOG01, SQLCODE,SQLERRM);
	    return(FALSE);
	}

	memset(&stGHistDocu,0,sizeof(GHISTDOCU));
	
	iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);

	if( iSqlLibroIva==SQLOK )
	{
	    strcpy(szDiaAux,stGHistDocu.szDiaEmision);
	    lFolioDesde    = stGHistDocu.lNumFolio;
	    lFolioHasta    = stGHistDocu.lNumFolio;
	    lFolioAnterior = stGHistDocu.lNumFolio;
	}

        lNumReg = 0;
        iCodTipDocumAlm = 0;
	while( iSqlLibroIva == SQLOK )
	     {
		    if( stGHistDocu.iIndAnulada != iDocAnulado )
		    {
			bfnAcumulaDocumentoFinal(iDoc,stGHistDocu);
			bfnAcumulaDocumento(iDoc,stGHistDocu);
		    }
		    
		    if( (strlen(szBuffer)+1+MAX_LARGOREGISTRO) >= MAX_SIZEBUFFER )
		    {	    	
			 if( !bfnEscribeLibro ( szBuffer,
			                        iNumPag,
			                        iDoc,
			                        stLineaComando.iMes, 
			                        stLineaComando.iAno,
			                        szhCodOficina,szhDesOficina) )
			 {
			     return(FALSE);
			 }
			 else
			 {
			     iNumPag++;
			 }
		    }
		    /* Se inicializa contador con cambio de Tipo Documento */
		    if ( iCodTipDocumAlm != stGHistDocu.iCodtipdocumalm )
		    {
		    	lNumReg = 0;
		    	iCodTipDocumAlm = stGHistDocu.iCodtipdocumalm;
                        strcat(szBuffer, sSALTOLINEA);		    	
		    }
		    
		    lNumReg++;
		    bfnEscribeBuffer(iDoc, stGHistDocu, &iCargaFile,lNumReg);
		    lConReg++;lTotReg++;

		    iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);
                    
	} /* Fin While */

	if( ( iSqlLibroIva != SQLOK ) && (iSqlLibroIva != SQLNOTFOUND ) ) 
	{
	      return(FALSE);
	}

	if( !bfnCloseFatDetLibroIva() )
	{
	     return(FALSE);
	}

	if( lConReg > 0 )
	{
	    if( strlen(szBuffer) > 0 )
	    {                    
		if( !bfnEscribeLibro( szBuffer,
		                      iNumPag,
		                      iDoc,
		                      stLineaComando.iMes,
		                      stLineaComando.iAno,
		                      szhCodOficina,szhDesOficina) )
		{
		     return(FALSE);
		}
		else
		{
		     iNumPag++;
		}
	    }

	    if( !bfnEscribeTotDocum(iDoc) )
	    {
		return(FALSE);
	    }
	}

    }	/*end for 1*/

    if( lTotReg > 0 )
    {
	if( !bfnEscribeTotLibro(stLineaComando.iMes,stLineaComando.iAno) )
	{
	    return(FALSE);
	}
    }

    vDTrazasLog ( szFuncion,"\n\t** Fin Funcion Llena Archivo de Impresion OK **",LOG04);
    return(TRUE );
    
}/* FIN bfnLlenaArchivoImpresion */

/*********************************************************************/
/* FUNCION      : bfnFetchLibroIva                                   */
/*********************************************************************/
static int bfnFetchLibroIva( GHISTDOCU *stGHistDocu)
{
    char szFuncion[]="bfnFetchLibroIva";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 int    ihCodtipdocumalm   ;
	 char   szhPrefPlaza    [26];
	 long   lhNumfolio          ;
	 char   szhCodOficina    [3]; /* EXEC SQL VAR szhCodOficina   IS STRING(2+1); */ 

	 int    ihIndanulada        ;
	 long   lhIndordentotal     ;
	 int    ihCodtipdocum       ;
	 char   szhFecemision   [15]; /* EXEC SQL VAR szhFecemision   IS STRING(15); */ 

	 char   szhNumidenttrib [21]; /* EXEC SQL VAR szhNumidenttrib IS STRING(21); */ 

	 char   szhNomcliente   [60]; /* EXEC SQL VAR szhNomcliente   IS STRING(60); */ 

	 char   szhDiaEmision    [3]; /* EXEC SQL VAR szhDiaEmision   IS STRING(2+1); */ 

	 char   szhMesAno        [8]; /* EXEC SQL VAR szhMesAno       IS STRING(8); */ 

	 double dhTotnetograv       ;
	 double dhTotnetonograv     ;
	 double dhTotiva            ;
	 double dhTotivaret         ;	     
	 double dhTotfactura        ;
	 short  sihPrefPlaza        ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog ( szFuncion,"\n\t** Funcion bfnFetchLibroIva  **",LOG05);

    /* EXEC SQL
	     FETCH  CursorLibroIva 
	     INTO   :ihCodtipdocumalm,
	            :szhPrefPlaza     :sihPrefPlaza ,
	            :lhNumfolio      ,
	            :szhCodOficina   ,
	            :ihIndanulada    ,
	            :lhIndordentotal ,
	            :ihCodtipdocum   ,
	            :szhFecemision   ,
	            :szhNumidenttrib ,
	            :szhNomcliente   ,
	            :dhTotnetograv   ,
	            :dhTotnetonograv ,
	            :dhTotiva        ,
	            :dhTotivaret     ,	            
	            :dhTotfactura    ,
	            :szhDiaEmision   ,
	            :szhMesAno        ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )866;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodtipdocumalm;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)&sihPrefPlaza;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumfolio;
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
    sqlstm.sqhstv[4] = (unsigned char  *)&ihIndanulada;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhIndordentotal;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodtipdocum;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecemision;
    sqlstm.sqhstl[7] = (unsigned long )15;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhNumidenttrib;
    sqlstm.sqhstl[8] = (unsigned long )21;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhNomcliente;
    sqlstm.sqhstl[9] = (unsigned long )60;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&dhTotnetograv;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&dhTotnetonograv;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&dhTotiva;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&dhTotivaret;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&dhTotfactura;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhDiaEmision;
    sqlstm.sqhstl[15] = (unsigned long )3;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhMesAno;
    sqlstm.sqhstl[16] = (unsigned long )8;
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



    vDTrazasLog ( szFuncion,"\n\t** SQLCODE EN bfnFetchLibroIva [%d] **",LOG06,SQLCODE);

    if( (SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND) )
    {
	 vDTrazasError(szFuncion,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
	 vDTrazasLog  (szFuncion,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
	 return(SQLCODE);
    }

    if( SQLCODE == SQLNOTFOUND )
    {
	vDTrazasLog  (szFuncion,"\n\t<< Fin de Registros en CursorLibroIva >>", LOG03);
	return(SQLCODE);
    }

    vDTrazasLog (szFuncion, "\n\t\t** Datos del FetchLibroIva (Impresion)**"
	                    "\n\t\t** szhFecemision.......[%s]"
	                    "\n\t\t** szhNomcliente.......[%s]"
	                    "\n\t\t** szhNumidenttrib.....[%s]"
	                    "\n\t\t** szhCodOficina.......[%s]"
	                    "\n\t\t** szhPrefPlaza.........[%s]"
	                    "\n\t\t** lhNumfolio..........[%ld]"
	                    "\n\t\t** dhTotnetonograv.....[%f]"
	                    "\n\t\t** dhTotnetograv.......[%f]"
	                    "\n\t\t** dhTotiva............[%f]"
	                    "\n\t\t** dhTotivaret.........[%f]"	
	                    "\n\t\t** dhTotfactura........[%f]"
	                    "\n\t\t** ihIndanulada........[%d]"
	                    "\n\t\t** ihCodtipdocumalm....[%d]"
	                    "\n\t\t** szhCodOficina.......[%s]"
	                    "\n\t\t** szDiaEmision........[%s]"
	                    "\n\t\t** szhMesAno............[%s]"
	                  , LOG04,szhFecemision   ,szhNomcliente
	                  , szhNumidenttrib       ,szhCodOficina
	                  , szhPrefPlaza
	                  , lhNumfolio
	                  , dhTotnetonograv
	                  , dhTotnetograv         ,dhTotiva     ,dhTotivaret
	                  , dhTotfactura          ,ihIndanulada
	                  , ihCodtipdocumalm      ,szhCodOficina
	                  , szhDiaEmision         ,szhMesAno);

    strcpy(stGHistDocu->szFecEmision ,szhFecemision);
    strcpy(stGHistDocu->szNomCliente ,szhNomcliente);
    strcpy(stGHistDocu->szRut        ,szhNumidenttrib);
    strcpy(stGHistDocu->szCodOficina,szhCodOficina);
    strcpy(stGHistDocu->szDiaEmision,szhDiaEmision);
    strcpy(stGHistDocu->szMesAno,szhMesAno);

    if( sihPrefPlaza == ORA_NULL )	
    {
	strcpy(stGHistDocu->szPrefPlaza, "                         \0" );
    }
    else
    {
	strcpy(stGHistDocu->szPrefPlaza, szhPrefPlaza);
    }

    strcpy(stGHistDocu->szPrefPlaza,szhPrefPlaza)   ;
    stGHistDocu->lNumFolio       = lhNumfolio      ;
    stGHistDocu->dAcumNetoNoGrav = dhTotnetonograv ;
    stGHistDocu->dAcumNetoGrav   = dhTotnetograv   ;
    stGHistDocu->dAcumIva        = dhTotiva        ;
    stGHistDocu->dAcumIvaRet     = dhTotivaret     ;	
    stGHistDocu->dTotDocumento   = dhTotfactura    ;
    stGHistDocu->iIndAnulada     = ihIndanulada    ;
    stGHistDocu->iCodtipdocumalm = ihCodtipdocumalm;

    return(SQLCODE);
}

/*********************************************************************/
/* FUNCION      : bfnCloseFatDetLibroIva                            */
/*********************************************************************/
static BOOL bfnCloseFatDetLibroIva()
{
    char szFuncion[]="bfnCloseDocumentos";

    vDTrazasLog (szFuncion,"\n\t** Close Cursor LibroIva " ,LOG04);

    /* EXEC SQL CLOSE CursorLibroIva; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )949;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "<< Error en Close Close Cursor LibroIva >>"
	                       , LOG01);
	vDTrazasError(szFuncion, "<< Error en Close Close Cursor LibroIva >>\n\t[%d] : [%s]"
	                       , LOG01,SQLCODE,SQLERRM);
	return(FALSE);
    }

    return(TRUE);

}/*********************** Final bfnCloseFatDetLibroIva  *************************/

/*********************************************************************/
/* FUNCION      : bfnEscribeBuffer                                   */
/*********************************************************************/
static void bfnEscribeBuffer(int       iDoc, 
                             GHISTDOCU pstGHistDocu, 
                             int       *iCargaFile,
                             long      lNumReg)
{
    char szFuncion[]="bfnEscribeBuffer";
    static char szaux1[MAX_LARGOREGISTRO];
    static char szaux2[MAX_LARGOREGISTRO];
    static char szVacio           [1]="";
    static char szCero            [1]="0";    
    short  iIndPrefFolio;
    long   lhNumReg;
    
    lhNumReg = lNumReg;

    vDTrazasLog  (szFuncion,"\n\t** Escribe en Buffer (bfnEscribeBuffer)  **",LOG02);

    vDTrazasLog(szFuncion, "\tDatos . \n\tFecha Emision  : %s\n\tNum Folio      : %10ld\n"
	                "\tNom Cliente    : %s\n\tRut            : %s\n\tNeto no grav   :%f\n\tNeto Grav      :%f\n"
	                "\tAcum Iva       :%f\n\tAcum Iva Ret   :%f\n\tTot Documento  : %f\n\tDia Emision    : %s"
	              , LOG04
	              ,	pstGHistDocu.szFecEmision   
	              , pstGHistDocu.lNumFolio 
	              , pstGHistDocu.szNomCliente 
	              ,	pstGHistDocu.szRut          
	              , pstGHistDocu.dAcumNetoNoGrav
	              , pstGHistDocu.dAcumNetoGrav  
	              ,	pstGHistDocu.dAcumIva
	              ,	pstGHistDocu.dAcumIvaRet	              
	              , pstGHistDocu.dTotDocumento 
	              , pstGHistDocu.szDiaEmision );

    sprintf(szaux1, "%ld%s%s%s%ld%s%s%s%ld%s%s%s%s%s%.0f%s%.0f%s%s%s%s%s%.0f%s%s%s%.0f%s%.0f%s%.0f%s%s"
	          , lhNumReg                      ,sDELIMITADOR /* N° Registro */
	          , pstGHistDocu.szFecEmision     ,sDELIMITADOR /* Fecha */
	          , pstGHistDocu.iCodtipdocumalm  ,sDELIMITADOR /* Tipo Documento */    
	          , szVacio                       ,sDELIMITADOR /* Formulario Unico */
	          , pstGHistDocu.lNumFolio        ,sDELIMITADOR /* N° Correlativo Documento */
	          , pstGHistDocu.szNomCliente     ,sDELIMITADOR /* Nombre Cliente */
	          , pstGHistDocu.szRut            ,sDELIMITADOR /* N.C.R. */
	          , pstGHistDocu.dAcumNetoNoGrav  ,sDELIMITADOR /* Ventas Propias Exentas */
	          , pstGHistDocu.dAcumNetoGrav    ,sDELIMITADOR /* Ventas Propias Gravadas*/
	          , szCero                        ,sDELIMITADOR /* Vtas.xCta. Terceros Exentas */
	          , szCero                        ,sDELIMITADOR /* Vtas.xCta. Terceros Gravadas */
	          , pstGHistDocu.dAcumIva         ,sDELIMITADOR /* Débito Fiscal IVA */
	          , szCero                        ,sDELIMITADOR /* Débito Fiscal Terceros */
	          , pstGHistDocu.dTotDocumento    ,sDELIMITADOR /* Ventas Totales */
	          , (pstGHistDocu.dAcumNetoGrav > 0 ? pstGHistDocu.dAcumNetoGrav : 0) ,sDELIMITADOR /* Monto Sujeto */
	          , pstGHistDocu.dAcumIvaRet      ,sDELIMITADOR /* Retencion IVA */
	          , szCero  );	                                /* Percepción Anticipo a Cuenta*/
	            
    strcat(szBuffer, szaux1);
    strcat(szBuffer, sDELIMITADOR);
    strcat(szBuffer, sSALTOLINEA);

    return;
}/***********************   Final bfnEscribeBuffer   ********************/

/*********************************************************************/
/* FUNCION      : bfnEscribeLibro                                    */
/* DESCRICPCION : Escribe el contenido de buffer un fichero de Datos */
/*********************************************************************/
static BOOL bfnEscribeLibro( char *szBuf, 
                             int  iPag, 
                             int  iTipDoc,
                             int  iMesAux, 
                             int  iAnoAux, 
                             char *szCodOficina,
                             char *szDesOficina)
{
    char szFuncion[]="bfnEscribeLibro";
    int  retprint ;

    vDTrazasLog  (szFuncion,"\n\t** Escribe en Archivo (bfnEscribeLibro)  **",LOG05);

    if( strlen(szBuf) == 0 )
    {
	return(TRUE);
    }

    if( !bfnEscribeCab(iPag, iTipDoc, iMesAux, iAnoAux, szCodOficina,szDesOficina) )
    {
	return(FALSE);
    }

    if( (retprint= fprintf(stLineaComando.fpDat,szBuf)) <= 0 )
    {
	 vDTrazasLog  (szFuncion,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);
	 vDTrazasError(szFuncion,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);

	 memset(szBuf,0,sizeof(szBuf));
	 return(FALSE);
    }

    memset(szBuf,0,sizeof(szBuf));
    
    return(TRUE);
}/******************* Final bfnEscribeFich **************************/

/*****************************************************************/
/* FUNCION      : bfnEscribeCab                                  */
/* DESCRICPCION : Escribe la cabecera de cada Pagina             */
/*****************************************************************/
static BOOL bfnEscribeCab( int  iPag, 
                           int  iTipDoc, 
                           int  iMesAux, 
                           int  iAnoAux, 
                           char *szCodOficina, 
                           char *szDesOficina)
{
    char szFuncion[]="bfnEscribeCab";
    static int  retprint                                            ;
    static char szCabecera [MAX_LARGOREGISTRO*LINEAS_CABECERA]  = "";
    static char szlinaux1  [MAX_LARGOREGISTRO]               = "";
    static char szlinaux2  [MAX_LARGOREGISTRO]               = "";
    static char szVacio    [1]                                  = "";

    vDTrazasLog  (szFuncion,"\n\t** Escribe Cabecera en Archivo (bfnEscribeCab)  **",LOG05);

    /********************************************************************/
    /* Creacion de la Cabecera                                          */
    /********************************************************************/
	
    sprintf(szlinaux1,"LIBRO DE VENTAS DE %s DEL %d", szNombreMes[iMesAux-1],iAnoAux);
    strcat(szCabecera, szlinaux1);
    strcat(szCabecera, sDELIMITADOR);
    strcat(szCabecera, sSALTOLINEA);	
	
    sprintf(szlinaux1,"  Rep.    : %s",szNomRepLegal);
    strcat(szCabecera, szlinaux1);	
    strcat(szCabecera, sDELIMITADOR);
    strcat(szCabecera, sSALTOLINEA);

    sprintf(szlinaux1,"  Rut     : %s",szRutRepLegal);	
    strcat(szCabecera, szlinaux1);	
    strcat(szCabecera, sDELIMITADOR);
    strcat(szCabecera, sSALTOLINEA);	
	
    sprintf(szlinaux1,"  Oficina : %s  %s",szCodOficina,szDesOficina);
    strcat(szCabecera, szlinaux1);
    strcat(szCabecera, sDELIMITADOR);
    strcat(szCabecera, sSALTOLINEA);		
    
    sprintf(szlinaux1, "%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s%s"
                     , "N°",sDELIMITADOR
                     , "Fecha",sDELIMITADOR
                     , "Tipo Documento",sDELIMITADOR
                     , "Formulario Unico",sDELIMITADOR
		     , "N° Folio",sDELIMITADOR
		     , "Nombre Cliente",sDELIMITADOR
		     , "N.R.C.",sDELIMITADOR
		     , "Ventas Propias Exentas",sDELIMITADOR
		     , "Ventas Propias Gravadas",sDELIMITADOR
		     , "Vtas.por Cta. de Terceros Exentas",sDELIMITADOR
		     , "Vtas.por Cta. de Terceros Gravadas",sDELIMITADOR		     
		     , "Debito Fiscal Iva",sDELIMITADOR
		     , "Debito Fiscal Terceros",sDELIMITADOR
		     , "Ventas Totales",sDELIMITADOR
		     , "Monto Sujeto",sDELIMITADOR		     
		     , "Retencion Iva",sDELIMITADOR
		     , "Percepción Anticipo a Cuenta");
    strcat(szCabecera, szlinaux1);
    strcat(szCabecera, sDELIMITADOR);
    strcat(szCabecera, sSALTOLINEA);    

    if( strlen(szCabecera) == 0 )
	return(TRUE);

    if( (retprint= fprintf(stLineaComando.fpDat,szCabecera)) <= 0 )
    {
	 vDTrazasLog  (szFuncion, "\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
		             , LOG01,retprint);
	 vDTrazasError(szFuncion, "\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
		             , LOG01,retprint);
	 return(FALSE);
    }
    
    memset(szCabecera,0,sizeof(szCabecera));

    return(TRUE);
}/********************* Final bfnEscribeCab   **************************/

/*****************************************************************/
/* FUNCION     : bfnAcumulaDocumento                             */
/*****************************************************************/
static void bfnAcumulaDocumento( int       iTipDocumento, 
                                 GHISTDOCU pstGHistDocu )
{
    char szFuncion []="bfnAcumulaDocumento";

    vDTrazasLog  (szFuncion,"\n\t** Acumulando Documento : %s (bfnAcumulaDocumento)**"
	                 "\n\t\t==>  Folio   [%ld]"
	                ,LOG05,szNombreDocs[iTipDocumento],pstGHistDocu.lNumFolio);

    if( pstGHistDocu.iIndAnulada == iDocOk )
	stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosOk++;
    else
	stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosAnul++;

    stTotTipDoc[pstGHistDocu.iCodTipDocum].dNetoDocumentos   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dExentoDocumentos += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dIvaDocumentos    += pstGHistDocu.dAcumIva        ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dIvaRetDocumentos += pstGHistDocu.dAcumIvaRet     ;    
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dTotalDocumentos  += pstGHistDocu.dAcumNetoGrav   +
                                                                pstGHistDocu.dAcumNetoNoGrav + 
                                                                pstGHistDocu.dAcumIva        +
                                                                pstGHistDocu.dAcumIvaRet;
                                                                
    if( pstGHistDocu.iIndAnulada == iDocAnulado )
    {
	stAcumulador.lNumFactAnul++;
    }
	
    stAcumulador.lNumFacturas       ++                               ;
    stAcumulador.dNetoFacturas      +=  pstGHistDocu.dAcumNetoGrav   ;
    stAcumulador.dExentoFacturas    +=  pstGHistDocu.dAcumNetoNoGrav ;
    stAcumulador.dIvaFacturas       +=  pstGHistDocu.dAcumIva        ;
    stAcumulador.dIvaRetFacturas    +=  pstGHistDocu.dAcumIvaRet     ;			
    stAcumulador.dTotalFacturas     +=  pstGHistDocu.dAcumNetoGrav + pstGHistDocu.dAcumNetoNoGrav +
			                pstGHistDocu.dAcumIva      + pstGHistDocu.dAcumIvaRet;

    return;
}/*********************** Final bfnAcumulaDocumento *************************/

/*****************************************************************/
/* FUNCION     : bfnEscribeTotDocum                              */
/* DESCRIPCION : Escribe Total por Tipo de Documento             */
/*****************************************************************/
static BOOL bfnEscribeTotDocum( int iTipDocumento)
{
    char szFuncion []="bfnEscribeTotDocum";

    static int  retprint                                            ;
    static char szTotDocum  [MAX_LARGOREGISTRO*LINEAS_SUBTOTAL]= "" ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = "" ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = "" ;
    static char szVacio     [1]                                = "" ;
    static char szCero      [1]                                = "0";
    static char szDiaAux    [3]                                = "" ;
    static char szDiaEmi    [3]                                = "" ;

    vDTrazasLog  (szFuncion,"\n\t** Escribe Total por Documento : %s **",LOG04,szNombreDocs[iTipDocumento]);

    /* SUB-TOTAL DOCUMENTOS */
    strcat(szTotDocum, sSALTOLINEA);
    sprintf(szlinaux1, "%s%s%d%s%s%s%s%s%s%s%s%s%s%s%.0f%s%.0f%s%s%s%s%s%.0f%s%s%s%.0f%s%.0f%s%.0f%s%s"
	             , "TOTAL DOCUMENTOS"	         ,sDELIMITADOR /* N° Registro */
	             , stAcumulador.lNumFacturas	 ,sDELIMITADOR /* Fecha */
	             , szVacio			         ,sDELIMITADOR /* Tipo Documento */
	             , szVacio                           ,sDELIMITADOR /* Formulario Unico */
	             , szVacio                           ,sDELIMITADOR /* N° Correlativo Documento */
	             , szVacio                           ,sDELIMITADOR /* Nombre del Cliente */
	             , szVacio                           ,sDELIMITADOR /* N.C.R.*/
	             , stAcumulador.dExentoFacturas	 ,sDELIMITADOR /* Ventas Propias Exentas */
	             , stAcumulador.dNetoFacturas	 ,sDELIMITADOR /* Ventas Propias Gravadas */
	             , szCero                            ,sDELIMITADOR /* Vtas.xCta. Terceros Exentas */
	             , szCero                            ,sDELIMITADOR /* Vtas.xCta. Terceros Gravadas */
	             , stAcumulador.dIvaFacturas	 ,sDELIMITADOR /* Debito Fiscal IVA */
	             , szCero                            ,sDELIMITADOR /* Debito Fiscal Terceros */
	             , stAcumulador.dTotalFacturas       ,sDELIMITADOR /* Ventas Totales */
	             , (stAcumulador.dNetoFacturas > 0 ? stAcumulador.dNetoFacturas : 0),sDELIMITADOR /* Monto Sujeto */
	             , stAcumulador.dIvaRetFacturas	 ,sDELIMITADOR /* Retención IVA */
	             , szCero );                                       /* Percepción Anticipo a Cuenta*/
    strcat(szTotDocum, szlinaux1);
    strcat(szTotDocum, sDELIMITADOR);
    strcat(szTotDocum, sSALTOLINEA);  
    strcat(szTotDocum, sSALTOLINEA);

    if( strlen(szTotDocum) == 0 )
	return(TRUE);

    if( (retprint= fprintf(stLineaComando.fpDat,szTotDocum)) <= 0 )
    {
	 vDTrazasLog  (szFuncion, "\n\t(bfnEscribeTotDocum) Error al Escribir "
		                  "Total de Documento en Archivo  [%d]"
		                , LOG01,retprint);
	 vDTrazasError(szFuncion, "\n\t(bfnEscribeTotDocum) Error al Escribir "
		                  "Total de Documento en Archivo  [%d]"
		                , LOG01,retprint);
	 return(FALSE);
    }
	
    memset(szTotDocum,0,sizeof(szTotDocum));
    
    return(TRUE);
}/********************* Final bfnEscribeTotDocum ************************/

/*****************************************************************/
/* FUNCION     : bfnEscribeTotLibro                              */
/* DESCRIPCION : Escribe Totales de Libro de Venta               */
/*****************************************************************/
static BOOL bfnEscribeTotLibro( int iMesAux, 
                                int iAnoAux)
{
    char szFuncion[]="bfnEscribeTotLibro";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

	 int     ihMes   = iMesAux       ;
	 int     ihAno   = iAnoAux       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    static int  retprint                                                ;
    static char szTotLibro  [MAX_LARGOREGISTRO*LINEAS_TATALIZADOR]= ""  ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = ""     ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = ""     ;
    static char szVacio     [1]                                = ""     ;
    static char szCero      [1]                                = "0"    ;    
    int     iFilasAux           ;
    int     iInd                ;
    double  dTGenExento     = 0 ;
    double  dTGenAfecto     = 0 ;
    double  dTGenIVA        = 0 ;
    double  dTGenIVARET     = 0 ;	
    double  dTGenLibro      = 0 ;

    vDTrazasLog  ( szFuncion, "\n\t** Escribe Total de Libro  **"
	                      "\n\t\t==>  Mes   [%d]"
	                      "\n\t\t==>  Ano   [%d]"
 	                    , LOG04,iMesAux,iAnoAux);

    /* ACUMULADORES */
    dTGenExento = stAcumuladorFinal.dExentoFacturas           +
	          stAcumuladorFinal.dExentoFacturasExen       +
	          stAcumuladorFinal.dExentoNotCredito         +
	          stAcumuladorFinal.dExentoFacturasElec       +
	          stAcumuladorFinal.dExentoFacturasElecExen   +
	          stAcumuladorFinal.dExentoBoleta             +
	          stAcumuladorFinal.dExentoBoletaExen         +
	          stAcumuladorFinal.dExentoBoletaAmis  ;

    dTGenAfecto = stAcumuladorFinal.dNetoFacturas             +
	          stAcumuladorFinal.dNetoFacturasExen         +
	          stAcumuladorFinal.dNetoNotCredito           +
	          stAcumuladorFinal.dNetoFacturasElec         +
	          stAcumuladorFinal.dNetoFacturasElecExen     +
	          stAcumuladorFinal.dNetoBoleta               +
	          stAcumuladorFinal.dNetoBoletaExen           +
	          stAcumuladorFinal.dNetoBoletaAmis    ;

    dTGenIVA = stAcumuladorFinal.dIvaFacturas              +
	       stAcumuladorFinal.dIvaFacturasExen          +
	       stAcumuladorFinal.dIvaNotCredito            +
	       stAcumuladorFinal.dIvaFacturasElec          +
	       stAcumuladorFinal.dIvaFacturasElecExen      +
	       stAcumuladorFinal.dIvaBoleta                +
	       stAcumuladorFinal.dIvaBoletaExen            +
	       stAcumuladorFinal.dIvaBoletaAmis     ;
	
    dTGenIVARET = stAcumuladorFinal.dIvaRetFacturas           +
	          stAcumuladorFinal.dIvaRetFacturasExen       +
	          stAcumuladorFinal.dIvaRetNotCredito         +
	          stAcumuladorFinal.dIvaRetFacturasElec       +
	          stAcumuladorFinal.dIvaRetFacturasElecExen   +
	          stAcumuladorFinal.dIvaRetBoleta             +
	          stAcumuladorFinal.dIvaRetBoletaExen         +
	          stAcumuladorFinal.dIvaRetBoletaAmis  ;	

    dTGenLibro = stAcumuladorFinal.dTotalFacturas            +
	         stAcumuladorFinal.dTotalFacturasExen        +
	         stAcumuladorFinal.dTotalNotCredito          +
	         stAcumuladorFinal.dTotalFacturasElec        +
	         stAcumuladorFinal.dTotalFacturasElecExen    +
	         stAcumuladorFinal.dTotalBoleta              +
	         stAcumuladorFinal.dTotalBoletaExen          +
	         stAcumuladorFinal.dTotalBoletaAmis   ;

    if( strlen(szTotLibro) == 0 )
    {
	return(TRUE);
    }

    if( (retprint= fprintf(stLineaComando.fpDat,szTotLibro)) <= 0 )
    {
	 vDTrazasLog  (szFuncion, "\n\t(bfnEscribeTotDocum) Error al Escribir "
		                  "Total de Documento en Archivo  [%d]"
		                , LOG01,retprint);
	 vDTrazasError(szFuncion, "\n\t(bfnEscribeTotDocum) Error al Escribir "
		                  "Total de Documento en Archivo  [%d]"
		                , LOG01,retprint);
	 return(FALSE);
    }
	
    fflush(stLineaComando.fpDat);
    memset(szTotLibro,0,sizeof(szTotLibro));
	
    return(TRUE);
}/********************* Final bfnEscribeTotLibro  ***********************/

/*****************************************************************/
/* FUNCION     : bfnAcumulaDocumentoFinal                        */
/*****************************************************************/
static void bfnAcumulaDocumentoFinal( int       iTipDocumento, 
                                      GHISTDOCU pstGHistDocu )
{
    char szFuncion []="bfnAcumulaDocumentoFinal";

    vDTrazasLog  (szFuncion, "\n\t** Acumulando Total Final Documento : %s (bfnAcumulaDocumentoFinal)**"
	                     "\n\t\t==>  Folio   [%ld]"
	                   , LOG05,szNombreDocs[iTipDocumento],pstGHistDocu.lNumFolio);

    if( pstGHistDocu.iIndAnulada == iDocOk )
    {
	stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosOkFinal++;
    }
    else
    {
	stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosAnulFinal++;
    }

    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dNetoDocumentosFinal   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dExentoDocumentosFinal += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dIvaDocumentosFinal    += pstGHistDocu.dAcumIva        ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dIvaRetDocumentosFinal += pstGHistDocu.dAcumIvaRet     ;	
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dTotalDocumentosFinal  += pstGHistDocu.dAcumNetoGrav   +
    pstGHistDocu.dAcumNetoNoGrav +
    pstGHistDocu.dAcumIva        +
    pstGHistDocu.dAcumIvaRet;

    if( pstGHistDocu.iIndAnulada == iDocAnulado )
    {
	stAcumuladorFinal.lNumFactAnul++;
    }

    stAcumuladorFinal.lNumFacturas       ++                               ;
    stAcumuladorFinal.dNetoFacturas      +=  pstGHistDocu.dAcumNetoGrav   ;
    stAcumuladorFinal.dExentoFacturas    +=  pstGHistDocu.dAcumNetoNoGrav ;
    stAcumuladorFinal.dIvaFacturas       +=  pstGHistDocu.dAcumIva        ;
    stAcumuladorFinal.dIvaRetFacturas    +=  pstGHistDocu.dAcumIvaRet     ;			
    stAcumuladorFinal.dTotalFacturas     +=  pstGHistDocu.dAcumNetoGrav + pstGHistDocu.dAcumNetoNoGrav + 
                                             pstGHistDocu.dAcumIva      + pstGHistDocu.dAcumIvaRet;
    return;
}/*********************** Final bfnAcumulaDocumentoFinal *************************/

/*****************************************************************/
/* FUNCION     : ifnGetParametro2                                */
/*****************************************************************/
int ifnGetParametro2 ( int  iCodParametro, 
                       char *szTipParametro, 
                       char *szValParametro )
{
    char szFuncion []="ifnGetParametro2";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 int     ihCodParametro      ;
	 long    lhValNumerico       ;
	 char    szhTipParametro [33]; /* EXEC SQL VAR szhTipParametro  IS STRING(33); */ 

	 char    szhValCaracter [513]; /* EXEC SQL VAR szhValCaracter   IS STRING(513); */ 

	 char    szhValFecha     [20]; /* EXEC SQL VAR szhValFecha      IS STRING(20); */ 

	 short   slhValNumerico      ;
	 short   sszhValCaracter     ;
	 short   sszhValFecha        ;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCodParametro= iCodParametro;

    vDTrazasLog  (szFuncion, "\n\t** Funcion %s **"
	                     "\n\t=> parametro [%d]"
	                   , LOG04, szFuncion, iCodParametro);

    /* EXEC SQL
	 SELECT TIP_PARAMETRO, 
	        VAL_NUMERICO, 
	        VAL_CARACTER, 
	        TO_CHAR(VAL_FECHA,'YYYYMMDDHH24MISS')
	 INTO   :szhTipParametro,
	        :lhValNumerico  :slhValNumerico,
	        :szhValCaracter :sszhValCaracter,
	        :szhValFecha    :sszhValFecha
	 FROM   FAD_PARAMETROS
	 WHERE  COD_MODULO='FA'
	 AND    COD_PARAMETRO=:ihCodParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TIP_PARAMETRO ,VAL_NUMERICO ,VAL_CARACTER ,TO_CHAR\
(VAL_FECHA,'YYYYMMDDHH24MISS') into :b0,:b1:b2,:b3:b4,:b5:b6  from FAD_PARAMET\
ROS where (COD_MODULO='FA' and COD_PARAMETRO=:b7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )964;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhTipParametro;
    sqlstm.sqhstl[0] = (unsigned long )33;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhValNumerico;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)&slhValNumerico;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhValCaracter;
    sqlstm.sqhstl[2] = (unsigned long )513;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&sszhValCaracter;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhValFecha;
    sqlstm.sqhstl[3] = (unsigned long )20;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&sszhValFecha;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodParametro;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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



    if( sqlca.sqlcode == SQLOK )
    {
	if( strcmp (szhTipParametro ,"VARCHAR2") == 0 )
	{
	    if( sszhValCaracter== ORA_NULL )	 
	    {
	    	memset(szValParametro,0, sizeof(szValParametro));
	    }
	    else 
	    {   
	    	strcpy(szValParametro,szhValCaracter);
	    }
	}
	else if( strcmp (szhTipParametro,"NUMBER") ==0 )
	     {
		 if( slhValNumerico == ORA_NULL )	 
		 {
		     memset(szValParametro,0, sizeof(szValParametro));
		 }
		 else	
		 {
		    sprintf(szValParametro,"%ld\0" ,lhValNumerico);
		 }
	     }
	else if( strcmp (szhTipParametro,"DATE") == 0 )
	     {
		 if( sszhValFecha   == ORA_NULL )
		 {	 
		     memset(szValParametro,0, sizeof(szValParametro));
		 }
		 else
		 {
		     strcpy(szValParametro,szhValFecha);
		 }
	     }
    }	     	
    else
    {
        if( sqlca.sqlcode != SQLNOTFOUND )
        {
	    fprintf(stderr, "Error al recuperar parametro, desde FAD_PARAMETROS.\n");
        }
    }
    
    return(sqlca.sqlcode);
}
/*****************************************************************/
/* FUNCION     : bfnValidaTrazaProc2                             */
/* DESCRIPCION : Proceso que valida condiciones para cargar el   */
/*               trafico del ciclo a facturar en tabla de        */ 
/*               proceso, controla puntos de retoma.             */
/*****************************************************************/
BOOL bfnValidaTrazaProc2( long lCiclParam,
                          int  iCodProceso, 
                          int  iIndFacturacion)
{
	
    char szFuncion []="bfnValidaTrazaProc2";	
    BOOL bFinCursorcFaProcTraza=FALSE;	
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

 	 long lhCiclParam            ;
	 int  ihIndFacturacion       ;
	 char szFecHastaLlam   [15]  ;   /* EXEC SQL VAR szFecHastaLlam     IS STRING(15); */ 

	 char szFecActual      [15]  ;   /* EXEC SQL VAR szFecActual        IS STRING(15); */ 

	 int  ihCodProceso           ;
	 char szhDesProceso    [30]  ;   /* EXEC SQL VAR szhDesProceso      IS STRING(30); */ 

	 int  ihCodProcesoPrec       ;
	 char szhDesProcesoPrec[30]  ;   /* EXEC SQL VAR szhDesProcesoPrec  IS STRING(30); */ 

	 int  ihCodEstaPrec          ;
	 int  ihTrazCodEstaProc      ;
	 int  ihTrazCodEstaActual;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szFuncion, "\n\t**  Parametros de Entrada bfnValidaTrazaProc2  **"
	                     "\n\t\t=>  Ciclo de Facturacion     [%ld]"
	                     "\n\t\t=>  Codigo de Proceso        [%d]\n"
	                   , LOG03,lCiclParam,iCodProceso);


    /****************************************************************************/
    /*   Selecciona el Codigo de Ciclo,IND_FACTURACION y la Fecha del Sistema   */
    /****************************************************************************/
    /****************************************************************************/
    /*  Validar Estado de IND_FACTURACION = iIND_FACT_ENPROCESO                 */
    /*  Debe estar marcado como EN PROCESO.  Marcado previamnete por el         */
    /*  proceso de creacion de mascara.                                         */
    /****************************************************************************/
    vDTrazasLog  (szFuncion, "\n\t\t**  Validando FA_CILCFACT  **",LOG03);

    lhCiclParam = lCiclParam;

    /* EXEC SQL 
	 SELECT IND_FACTURACION,
	        TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH24MISS'),
	        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
	 INTO   :ihIndFacturacion,
	        :szFecHastaLlam,
	        :szFecActual
	 FROM   FA_CICLFACT
	 WHERE  COD_CICLFACT = :lhCiclParam; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_FACTURACION ,TO_CHAR(FEC_HASTALLAM,'YYYYMMDDHH\
24MISS') ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') into :b0,:b1,:b2  from FA_CICLFA\
CT where COD_CICLFACT=:b3";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )999;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szFecHastaLlam;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szFecActual;
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCiclParam;
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



    if( SQLCODE == SQLNOTFOUND )
    {
	vDTrazasLog  (szFuncion, "\n\t**  No Existen Datos en FA_CICLFACT **"
		                    "\n\t\t=> Para el CodCiclFact     [%ld]",LOG01,lCiclParam);
        vDTrazasError(szFuncion, "\n\t**  No Existen Datos en FA_CICLFACT **"
		                    "\n\t\t=> Para el CodCiclFact     [%ld]",LOG01,lCiclParam);
	return(FALSE);
    }
    
    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error en Select sobre FA_CILCFACT **"
		                    "\n\t\t=> Para el CodCiclFact     [%ld]",LOG01,lCiclParam);
	vDTrazasError(szFuncion, "\n\t**  Error en Select sobre FA_CILCFACT **"
		                    "\n\t\t=> Para el CodCiclFact     [%ld]",LOG01,lCiclParam);
	return(FALSE);
    }

    if( ihIndFacturacion != iIndFacturacion )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
		                    "\n\t\t=>  CodCiclFact                 [%ld]"
		                    "\n\t\t=>  IndFacturacion Actual       [%d]"
		                    "\n\t\t=>  IndFacturacion Necesario    [%d]"
		                  , LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);
	vDTrazasError(szFuncion, "\n\t**  Error:   Estado del Proceso FA_CICLFACT **"
		                    "\n\t\t=>  CodCiclFact                 [%ld]"
		                    "\n\t\t=>  IndFacturacion Actual       [%d]"
		                    "\n\t\t=>  IndFacturacion Necesario    [%d]"
		                  , LOG01,lCiclParam,ihIndFacturacion,iIndFacturacion);

	return(FALSE);

    }

   /****************************************************************************/
   /*  Selecciona las Condiciones de Procesos Precedentes en la tabla de       */
   /*  de descripcion de procesos FA_PROCFACT y tabla de traza de Procso       */
   /*  FA_TRAZAPROC que contiene la definicion de los procesos de Facturacion  */
   /*  ejecutados.                                                             */
   /****************************************************************************/
   vDTrazasLog  (szFuncion, "\n\t\t**  Validando Procesos Precedentes en FA_TRAZAPROC - FA_PROCFACT **",LOG03);
   
   ihCodProceso = iCodProceso               ;

   /* EXEC SQL DECLARE cFaProcTraza CURSOR FOR
        SELECT  PROC.DES_PROCESO,
                PROC.COD_PROCPREC,
                PROC.DES_PROCPREC,
                PROC.COD_ESTAPREC,
                NVL(TRAZ.COD_ESTAPROC,0),
                TRAZ.FEC_INICIO,
                TRAZ.FEC_TERMINO
    FROM    FA_TRAZAPROC  TRAZ,
	   (SELECT A.COD_PROCESO   COD_PROCESO,
	           B.DES_PROCESO   DES_PROCESO,
	           A.COD_PROCPREC  COD_PROCPREC,
	           C.DES_PROCESO   DES_PROCPREC,
	           A.COD_ESTAPREC  COD_ESTAPREC
	    FROM   FA_PROCFACTPREC A ,
 	           FA_PROCFACT B ,
	           FA_PROCFACT C
	    WHERE   A.COD_PROCESO  = :ihCodProceso
	    AND     A.COD_PROCESO  = B.COD_PROCESO
	    AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
    WHERE   TRAZ.COD_CICLFACT (+)  = :lhCiclParam
    AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
    ORDER BY PROC.COD_PROCESO; */ 


    /* EXEC SQL OPEN cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0018;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1030;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProceso;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCiclParam;
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



    if( SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
		                    "\n\t\t=> Para el Codigo de Proceso [%d]" 
		                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
		                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
		                  , LOG01,iCodProceso,lCiclParam,SQLERRM);
	vDTrazasError(szFuncion, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
		                    "\n\t\t=> Para el Codigo de Proceso [%d]"
		                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
		                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
		                  , LOG01,iCodProceso,lCiclParam,SQLERRM);
	return(FALSE);
    }
    /****************************************************************************/
    bFinCursorcFaProcTraza = FALSE ;
    do
    {
	/* EXEC SQL 
	     FETCH cFaProcTraza 
	     INTO  :szhDesProceso          ,
	           :ihCodProcesoPrec       ,
	           :szhDesProcesoPrec      ,
	           :ihCodEstaPrec          ,
	           :ihTrazCodEstaProc      ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1053;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDesProceso;
 sqlstm.sqhstl[0] = (unsigned long )30;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProcesoPrec;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhDesProcesoPrec;
 sqlstm.sqhstl[2] = (unsigned long )30;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodEstaPrec;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihTrazCodEstaProc;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
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



	if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
	{
	    vDTrazasLog  (szFuncion, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
			              , LOG01, SQLCODE, SQLERRM);
	    vDTrazasError(szFuncion, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
			              , LOG01, SQLCODE, SQLERRM);
	    return(FALSE);
	}
	
	if( SQLCODE == SQLNOTFOUND )
	{
	    bFinCursorcFaProcTraza = TRUE;
	}
	else
	{
	   /****************************************************************************/
	   /*  Valida que el Estado del Proceso Precedente este Actualizado en la      */
	   /*  tabla de Traza  FA_TRAZAPROC.                                           */
	   /****************************************************************************/
	   if( ihCodEstaPrec != ihTrazCodEstaProc )
	   {
	       vDTrazasLog  (szFuncion, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
				         , LOG01, szhDesProcesoPrec, szhDesProceso);
	       vDTrazasError(szFuncion, "\n\t** Error: Proceso %s No ha Terminado Para Ejecutar Proceso %s **\n"
				         , LOG01, szhDesProcesoPrec, szhDesProceso);
	       return(FALSE);
	   }
	}
    } while( !bFinCursorcFaProcTraza );

    /* EXEC SQL CLOSE cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1088;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /****************************************************************************/
    /*  Valida Condiciones del Mismo Proceso.                                   */
    /*  Valida si puede Retomar el Proceso o simplemente iniciar por primera vez*/
    /****************************************************************************/

    vDTrazasLog  (szFuncion, "\n\t\t**  Validando Proceso Actual en FA_TRAZAPROC  **",LOG03);
    ihCodProceso    = iCodProceso               ;

    /* EXEC SQL    
	 SELECT TRAZ.COD_ESTAPROC    ,
	        PROC.DES_PROCESO
	 INTO   :ihTrazCodEstaActual ,
	        :szhDesProceso
	 FROM   FA_TRAZAPROC TRAZ, 
	        FA_PROCFACT     PROC
	 WHERE  TRAZ.COD_CICLFACT = :lhCiclParam
	 AND    TRAZ.COD_PROCESO  = :ihCodProceso
	 AND    TRAZ.COD_PROCESO  = PROC.COD_PROCESO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRAZ.COD_ESTAPROC ,PROC.DES_PROCESO into :b0,:b1  \
from FA_TRAZAPROC TRAZ ,FA_PROCFACT PROC where ((TRAZ.COD_CICLFACT=:b2 and TRA\
Z.COD_PROCESO=:b3) and TRAZ.COD_PROCESO=PROC.COD_PROCESO)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1103;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihTrazCodEstaActual;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[1] = (unsigned long )30;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCiclParam;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodProceso;
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
		                    "\n\t\t=>  Proceso                      [%d]"
		                    "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
		                  , LOG01,iCodProceso,lCiclParam);
	vDTrazasError(szFuncion, "\n\t**  Error es Select Sobre FA_TRAZAPROC de Proceso Actual **"
		                    "\n\t\t=>  Proceso                      [%d]"
		                    "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
		                  , LOG01,iCodProceso,lCiclParam);

	return(FALSE);
    }
    
    if( SQLCODE == SQLOK )
    {
	/****************************************************************************/
	/*  Valida que el Proceso Este Terminado Ok                                 */
	/****************************************************************************/
	if( ihTrazCodEstaActual == iPROC_EST_OK )
	{
	    vDTrazasLog  (szFuncion, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
			                "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
			                "\n\t\t=>  Codigo de Proceso            [%d]"
			                "\n\t\t=>  Estado de Proceso            [%d]"
			              , LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
	    vDTrazasError(szFuncion, "\n\t**  Error Proceso %s Ya Fue Procesado con Estado OK **"
			                "\n\t\t=>  Cod.Ciclo Facturacion        [%ld]"
			                "\n\t\t=>  Codigo de Proceso            [%d]"
			                "\n\t\t=>  Estado de Proceso            [%d]"
			              , LOG01,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);
	    return(FALSE);
	}

	vDTrazasLog  (szFuncion, "\n\t**  Retomando Proceso  %s **"
		                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
		                    "\n\t\t=>  Codigo de Proceso        [%d]"
		                    "\n\t\t=>  Estado del Proceso       [%d]\n"
		                  , LOG03,szhDesProceso,lhCiclParam,ihCodProceso,ihTrazCodEstaActual);

    }

    if( SQLCODE == SQLNOTFOUND )
    {
	/****************************************************************************/
	/*   Proceso NO se ha ejecutado aun para el ciclo de Facturacion.           */
	/*   Inserta Registro en la Tabla de Traza                                  */
	/****************************************************************************/
	ihTrazCodEstaActual = iPROC_EST_RUN;
	
	vDTrazasLog  (szFuncion, "\n\t**  Insertando Proceso de FA_TRAZAPROC  **"
	 	                    "\n\t\t=>  Ciclo de Facturacion     [%ld]"
		                    "\n\t\t=>  Codigo de Proceso        [%d]\n"
		                  ,LOG03,lCiclParam,iCodProceso);

	/* EXEC SQL 
	     INSERT INTO FA_TRAZAPROC(   
	                    COD_CICLFACT        ,
		            COD_PROCESO         ,
		            COD_ESTAPROC        ,
		            FEC_INICIO          ,
		            GLS_PROCESO         ,
		            COD_CLIENTE         ,
		            NUM_ABONADO         ,
		            NUM_REGISTROS       )
		    VALUES( :lhCiclParam        ,
		            :ihCodProceso       ,
		            :ihTrazCodEstaActual,
		            sysdate             ,
		            'Proceso Iniciado'  ,
		            0                   ,
		            0                   ,
		            0                   ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into FA_TRAZAPROC (COD_CICLFACT,COD_PROCESO,COD_ESTAP\
ROC,FEC_INICIO,GLS_PROCESO,COD_CLIENTE,NUM_ABONADO,NUM_REGISTROS) values (:b0,\
:b1,:b2,sysdate,'Proceso Iniciado',0,0,0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1134;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclParam;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodProceso;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihTrazCodEstaActual;
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


		
	if( SQLCODE != SQLOK )
	{
	    vDTrazasLog  (szFuncion, "\n\t\t**  Error Insertando Proceso [%d]"
		                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
		                        "\n\t\t=>  Error Oracle  %s              "
		                      , LOG01,iCodProceso,lCiclParam,SQLERRM);
            vDTrazasError(szFuncion, "\n\t\t**  Error Insertando Proceso [%d]"
		                        "\n\t\t=>  Cod.Ciclo Facturacion    [%ld]"
		                        "\n\t\t=>  Error Oracle  %s              "
		                      , LOG01,iCodProceso,lCiclParam,SQLERRM);
            return(FALSE);
	}
    }
    return(TRUE);
}/**********************   fin  bfnValidaTrazaProc2  **************************/

/*****************************************************************/
/* FUNCION : bfnRecuperaImpuesto                                   */
/*****************************************************************/
BOOL bfnRecuperaImpuesto( int *icodcatimpo, 
                          int *icodzonaimpo, 
                          int *icodtipimpues, 
                          int *icodgrpservi) 
{
	
    char szFuncion []="bfnRecuperaImpuesto";	
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char szhcodcatimpo  [14];
	 char szhcodzonaimpo [14];
	 char szhcodtipimpues[14];
	 char szhcodgrpservi [14]; 
	 int  ihcodimpuesto   [5];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy(szhcodcatimpo  ,  CATEGORIA_IMPOSITIVA);  
    strcpy(szhcodzonaimpo ,  ZONA_IMPOSITIVA);
    strcpy(szhcodtipimpues,  TIPO_IMPUESTO);
    strcpy(szhcodgrpservi ,  GRUPO_SERVICIO);

    /* EXEC SQL
	 SELECT  VAL_PARAMETRO
	 INTO    :ihcodimpuesto
	 FROM    GED_PARAMETROS
	 WHERE   (NOM_PARAMETRO = :szhcodcatimpo 
	 OR       NOM_PARAMETRO = :szhcodzonaimpo
	 OR       NOM_PARAMETRO = :szhcodtipimpues
	 OR       NOM_PARAMETRO = :szhcodgrpservi)
	 AND     COD_MODULO     = 'FA'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where \
((((NOM_PARAMETRO=:b1 or NOM_PARAMETRO=:b2) or NOM_PARAMETRO=:b3) or NOM_PARAM\
ETRO=:b4) and COD_MODULO='FA')";
    sqlstm.iters = (unsigned int  )5;
    sqlstm.offset = (unsigned int  )1161;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)ihcodimpuesto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhcodcatimpo;
    sqlstm.sqhstl[1] = (unsigned long )14;
    sqlstm.sqhsts[1] = (         int  )14;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhcodzonaimpo;
    sqlstm.sqhstl[2] = (unsigned long )14;
    sqlstm.sqhsts[2] = (         int  )14;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhcodtipimpues;
    sqlstm.sqhstl[3] = (unsigned long )14;
    sqlstm.sqhsts[3] = (         int  )14;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhcodgrpservi;
    sqlstm.sqhstl[4] = (unsigned long )14;
    sqlstm.sqhsts[4] = (         int  )14;
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
	vDTrazasLog  (szFuncion, "\n\t\t**  Error Select en ged_parametros"
	                         "\n\t\t=>  Error Oracle  %s              "
		               , LOG01,SQLERRM);
        vDTrazasError(szFuncion, "\n\t\t**  Error Select en ged_parametros"
		                 "\n\t\t=>  Error Oracle  %s              "
		               , LOG01,SQLERRM);
	return(FALSE);
    }

    if( sqlca.sqlerrd[2] < 4 )
    {
	vDTrazasLog  (szFuncion, "\n\t\t**  Error Select en ged_parametros"
	                         "\n\t\t=>  No se recuperaron todos los parametros"
		               , LOG01);
	return(FALSE);
    }

    *icodcatimpo   = ihcodimpuesto[0];
    *icodzonaimpo  = ihcodimpuesto[1];
    *icodtipimpues = ihcodimpuesto[2];
    *icodgrpservi  = ihcodimpuesto[3];

    return(TRUE);
}/************************* bfnRecuperaImpuesto ******************/

/*****************************************************************/
/* FUNCION : bfnRegistroInsertado                                */
/*****************************************************************/
BOOL  bfnRegistroInsertado( GHISTDOCU pstGHistDocu)
{
	
    char szFuncion []="bfnRegistroInsertado";
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char   szhPrefPlaza    [26];
	 long   lhNumfolio         ;
	 char   szhCodOficina   [3];
	 int    ihCodtipdocum      ;
	 int    ihCont              ;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCont=0;

    lhNumfolio       = pstGHistDocu.lNumFolio;
    ihCodtipdocum    = pstGHistDocu.iCodTipDocum; 
    strcpy(szhPrefPlaza,pstGHistDocu.szPrefPlaza);
    strcpy(szhCodOficina,pstGHistDocu.szCodOficina);

    /* EXEC SQL
	 SELECT COUNT(1) 
	 INTO   :ihCont 
	 FROM   FAT_DETLIBROIVA
	 WHERE  NUM_FOLIO     = :lhNumfolio          
	 AND    COD_TIPDOCUM  = :ihCodtipdocum       
	 AND    PREF_PLAZA    = TRIM(:szhPrefPlaza)         
	 AND    COD_OFICINA   = :szhCodOficina; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 20;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from FAT_DETLIBROIVA where (((N\
UM_FOLIO=:b1 and COD_TIPDOCUM=:b2) and PREF_PLAZA=trim(:b3)) and COD_OFICINA=:\
b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1196;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCont;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumfolio;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodtipdocum;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[3] = (unsigned long )26;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[4] = (unsigned long )3;
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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
	vDTrazasLog  (szFuncion, "\n\t\t**  Error Select FAT_DETLIBROIVA "
	                         "\n\t\t=>  Error Oracle  %s              "
		               , LOG01,SQLERRM);
        vDTrazasError(szFuncion, "\n\t\t**  Error Select FAT_DETLIBROIVA "
		                 "\n\t\t=>  Error Oracle  %s              "
		               , LOG01,SQLERRM);
	return(FALSE);
    }

    if( ihCont ) 
    {
	return(TRUE);
    }
	
    return(FALSE);
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



