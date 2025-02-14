
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
static struct sqlcxp sqlfpn =
{
    19,
    "./pc/Extractores.pc"
};


static unsigned int sqlctx = 27680131;


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

 static char *sq0001 = 
"select distinct A.COD_UNIVERSO ,B.DES_UNIVERSO  from CM_ARCHIVOS_TD A ,CMD_U\
NIVERSOS B where (A.IND_EJECUCION=:b0 and A.COD_UNIVERSO=B.COD_UNIVERSO)      \
     ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,159,0,9,194,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,13,198,0,0,2,0,0,1,0,2,97,0,0,2,97,0,0,
47,0,0,1,0,0,15,217,0,0,0,0,0,1,0,
62,0,0,2,218,0,4,264,0,0,4,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,
93,0,0,3,163,0,3,328,0,0,4,4,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
124,0,0,4,0,0,29,345,0,0,0,0,0,1,0,
139,0,0,5,81,0,4,469,0,0,3,2,0,1,0,1,3,0,0,1,97,0,0,2,3,0,0,
166,0,0,6,87,0,4,493,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
189,0,0,7,109,0,4,525,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,97,0,0,
216,0,0,8,48,0,1,753,0,0,0,0,0,1,0,
231,0,0,9,0,0,30,769,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa : Extractores.pc                                                 */
/*            Programa encargado de ejecutar los extractores de Comisiones.  */
/* Autora   : Fabián Aedo R.                                                 */
/* Modificado por :                                                          */
/* Fecha Ultimas Modificaciones:                                             */
/*---------------------------------------------------------------------------*/
#include "Extractores.h"
#include "GEN_biblioteca.h"
#include <geora.h>

/*---------------------------------------------------------------------------*/
/* Inclusion de biblioteca para manejo de interaccion con Oracle.            */
/*---------------------------------------------------------------------------*/
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlErrorNew(); */ 

/*---------------------------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.                                */
/*---------------------------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 
     
char    szhUser[30]="";         
char    szhPass[30]="";         
char    szhSysDate[17]="";        
char    szFechaYYYYMMDD[9]="";  
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* RUTINA PARA MANEJO DE MENSAJES DE ERRORES ORACLE.                         */
/*---------------------------------------------------------------------------*/
void    vSqlErrorNew ()
{
    /* EXEC SQL WHENEVER SQLERROR CONTINUE; */ 

    fprintf(pfLog, "\n[Extractor] Error ORACLE: \n");
    fprintf(pfLog, "[Extractor] %s\n", sqlca.sqlerrm.sqlerrmc); 
    fprintf(pfLog, "SE TERMINA LA EJECUCION DEL PROCESO.\n");
}

/*---------------------------------------------------------------------------*/
/* RUTINA PARA MANEJO Y VALIDACION DE ARGUMENTOS INGRESADOS COMO PARAMETROS  */
/* EXTERNOS.                                                                 */
/*---------------------------------------------------------------------------*/
void  vManejaArgsnew (int argc, char * const argv[])
{
    int         iOpt = 0;
    extern char *optarg;
    char        opstring[] = ":u:d:h:";
    char        *szUserid_Aux;
    char        userid[70];
    char        szaux[10];

	while((iOpt=getopt(argc, argv, opstring)) != EOF)
    {
    	switch(iOpt)
        {
			case 'u':
            	if(stArgsNew.bFlagUser == FALSE)
                {
                	if(optarg[0]=='-')
                    {
                        fprintf(stderr, "\nOpcion -%c tiene argumento", optopt);
                        fprintf(stderr," invalido. Se cancela.\n");
                        fprintf(stderr, "%s\n\n", szUsonew);
                        exit(EXIT_01);
                    }
                    sprintf(userid, optarg);
                    if((szUserid_Aux=(char *)strstr(userid,"/")) == (char *)NULL)
                    {
                    	fprintf(stderr, "\nUsuario Oracle no es valido\n");
                        fprintf(stderr, "%s\n\n", szUsonew);
                        exit(EXIT_01);
                    }
                    else
                    {
                    	strncpy(stArgsNew.szUser, userid, szUserid_Aux-userid);
                        strcpy(stArgsNew.szPass, szUserid_Aux+1);
                    }
       			}
                else
                {
                	fprintf(stderr, "\nOpcion -%c duplicada.", optopt);
                    fprintf(stderr," Se cancela.\n");
                    fprintf(stderr, "%s\n\n", szUsonew);
                    exit(EXIT_01);
                }
                stArgsNew.bFlagUser=TRUE;
                break;

			case 'd':
				if(stArgsNew.bFlagFecDesde == FALSE)
				{
					if(optarg[0]=='-')
					{
					   fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
					   fprintf(stderr, "%s\n\n", szUsonew);
					   exit(EXIT_01);
					}
					strcpy(stArgsNew.szFecDesde,optarg);
				}
				else
				{
					fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
					fprintf(stderr, "%s\n\n", szUsonew);
					exit(EXIT_01);
				}
				stArgsNew.bFlagFecDesde = TRUE;
				break;
			
			case 'h':
				if(stArgsNew.bFlagFecHasta == FALSE)
			 	{
			    	if(optarg[0]=='-')
			    	{
				       	fprintf(stderr, "\nOpcion -%c tiene argumento invalido. Se cancela.\n", optopt);
				       	fprintf(stderr, "%s\n\n", szUsonew);
				    	exit(EXIT_01);
			    	}
			    	strcpy(stArgsNew.szFecHasta,optarg);
			 	}
			 	else
			 	{
			    	fprintf(stderr, "\nOpcion -%c duplicada. Se cancela.\n", optopt);
			    	fprintf(stderr, "%s\n\n", szUsonew);
			    	exit(EXIT_01);
			 	}
			 	stArgsNew.bFlagFecHasta = TRUE;
			 	break;

			case '?':
            	fprintf(stderr, "Opcion -%c no reconocida. Se cancela.\n", optopt);
                fprintf(stderr, "%s\n\n", szUsonew);
                exit(EXIT_01);
		}  /* Fin switch */
	}      /* Fin while  */

/*---------------------------------------------------------------------------*/
/* VALIDA LA RELACION DE LOS PARAMETROS...                                   */
/*---------------------------------------------------------------------------*/
    if (stArgsNew.bFlagUser == FALSE)
    {
    	fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "Se requiere argumento -u[Usuario/Password]\n");
        fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "%s\n\n", szUsonew);
        exit(EXIT_01);
    }
   if(stArgsNew.bFlagFecDesde == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -c[Fecha Desde <YYYYMMDD>]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsonew);
      exit(EXIT_01);
   }
   if(stArgsNew.bFlagFecHasta == FALSE)
   {
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "Se requiere argumento -c[Fecha Hasta <YYYYMMDD>]\n");
      fprintf(stderr, "%s\n", szRaya);
      fprintf(stderr, "%s\n\n", szUsonew);
      exit(EXIT_01);
   }
}
/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA DE UNIVERSOS A PROCESAR                                  */
/*---------------------------------------------------------------------------*/
stProcesos * stfnCargaProcesos()
{
    stProcesos 	* qaux = NULL;
    stProcesos 	* paux = NULL;
    long    	iCantidad = 0; 
	int         i; 
	long        iLastRows    = 0;
	int         iFetchedRows = MAXFETCH;
	int         iRetrievRows = MAXFETCH;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhCodUniverso[MAXFETCH][7];
		char	szhDesUniverso[MAXFETCH][51];
		char    szhIndAfirmacion[2];
		long	lMaxFetch;
	/* EXEC SQL END DECLARE SECTION; */ 


	lMaxFetch = MAXFETCH;
	strcpy(szhIndAfirmacion,"S");
	
	/* EXEC SQL DECLARE CUR_PROCESOS CURSOR FOR
		SELECT DISTINCT A.COD_UNIVERSO,
                B.DES_UNIVERSO
		FROM CM_ARCHIVOS_TD A,
		     CMD_UNIVERSOS B
		WHERE A.IND_EJECUCION = :szhIndAfirmacion
		  AND A.COD_UNIVERSO = B.COD_UNIVERSO; */ 

		
    /* EXEC SQL OPEN CUR_PROCESOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIndAfirmacion;
    sqlstm.sqhstl[0] = (unsigned long )2;
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

     
    
	while(iFetchedRows == iRetrievRows)
    {
   		/* EXEC SQL for :lMaxFetch FETCH CUR_PROCESOS INTO :szhCodUniverso, :szhDesUniverso; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 2;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )lMaxFetch;
     sqlstm.offset = (unsigned int  )24;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodUniverso;
     sqlstm.sqhstl[0] = (unsigned long )7;
     sqlstm.sqhsts[0] = (         int  )7;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqharc[0] = (unsigned long  *)0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhDesUniverso;
     sqlstm.sqhstl[1] = (unsigned long )51;
     sqlstm.sqhsts[1] = (         int  )51;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqharc[1] = (unsigned long  *)0;
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


   	     
		iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows    = sqlca.sqlerrd[2];
                
        for (i=0; i < iRetrievRows; i++)
        {                
			paux = (stProcesos *) malloc(sizeof(stProcesos));   	     
			
			strcpy(paux->szCodUniverso	, szfnTrim(szhCodUniverso[i]));
			strcpy(paux->szDesUniverso	, szfnTrim(szhDesUniverso[i]));
			paux->bFlgExisteProceso     = bGetNomProceso(paux->szCodUniverso, paux->szNomExe);
			
			paux->sgte                 	= qaux;
			qaux                	    = paux;
			iCantidad++;
		}
		
	}
	/* EXEC SQL CLOSE CUR_PROCESOS; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )47;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(pfLog ,"\n[stfnCargaProcesos] szhIndAfirmacion Indicador de Afirmacion query:[%s].\n", szhIndAfirmacion);
    fprintf(pfLog ,"\n[stfnCargaProcesos] Cantidad de Procesos a Ejecutar:[%ld].\n", iCantidad);
    fprintf(stderr,"\n[stfnCargaProcesos] Cantidad de Procesos a Ejecutar:[%ld].\n", iCantidad);
    return qaux;
}
/*---------------------------------------------------------------------------*/
/* ASOCIA EL  NOMBRE DEL EJECUTABLE AL UNIVERSO A PROCESAR                   */
/*---------------------------------------------------------------------------*/
int bGetNomProceso(char * pszCodUniverso, char * pszNombre)
{
	if (strcmp(pszCodUniverso, uniLISTOPACK)==0) 
		strcpy(pszNombre, prcLISTOPACK);
	else 
		if (strcmp(pszCodUniverso, uniVENTAS)==0) 
			strcpy(pszNombre, prcVENTAS);
		else 
			if (strcmp(pszCodUniverso, uniBAJAS)==0) 
				strcpy(pszNombre, prcBAJAS);
			else 
				if (strcmp(pszCodUniverso, uniREDVEN)==0) 
					strcpy(pszNombre, prcREDVEN);
				else
				{
					fprintf(pfLog , "\n[szGetNomProceso] Error, UNIVERSO:[%s] No Reconocido.", pszCodUniverso);
					fprintf(stderr, "\n[szGetNomProceso] Error, UNIVERSO:[%s] No Reconocido.", pszCodUniverso);
					return FALSE;
				}	
	fprintf(pfLog , "\n[szGetNomProceso] UNIVERSO:[%s] ---> PROCESO:[%s]", pszCodUniverso, pszNombre);
	fprintf(stderr, "\n[szGetNomProceso] UNIVERSO:[%s] ---> PROCESO:[%s]", pszCodUniverso, pszNombre);
	return TRUE;
	
}

/*---------------------------------------------------------------------------*/
/* VALIDA SI SE ESTA EJECUTANDO EL PROCESO DE EXTRACCION                     */
/*---------------------------------------------------------------------------*/
int bfnGetStatusExtractor(char * szCodEstado, int * piSecuencia)
{
	int		bIndPrimera = FALSE;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char 	szhCodEstaProc[2];
		int	 	ihNumSeq;
		char	szhFecDesde[9];
		char	szhFecHasta[9];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	/* EXEC SQL SELECT 
		COD_ESTAPROC, 
		SEQ_PROCESO,
		TO_CHAR(FEC_DESDE,'YYYYMMDD'),
		TO_CHAR(FEC_HASTA,'YYYYMMDD')
	INTO :szhCodEstaProc, :ihNumSeq, :szhFecDesde, :szhFecHasta
	FROM CM_EJECUTA_PROCESOS_TD
	WHERE SEQ_PROCESO = (SELECT MAX(SEQ_PROCESO)
	                     FROM CM_EJECUTA_PROCESOS_TD); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_ESTAPROC ,SEQ_PROCESO ,TO_CHAR(FEC_DESDE,'YYYYMMD\
D') ,TO_CHAR(FEC_HASTA,'YYYYMMDD') into :b0,:b1,:b2,:b3  from CM_EJECUTA_PROCE\
SOS_TD where SEQ_PROCESO=(select max(SEQ_PROCESO)  from CM_EJECUTA_PROCESOS_TD\
 )";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )62;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstaProc;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihNumSeq;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
 sqlstm.sqhstl[3] = (unsigned long )9;
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


	
    if (sqlca.sqlcode != SQLOK) 
    {
	    if (sqlca.sqlcode != SQLNOTFOUND) 
	    {
			fprintf(pfLog,"[bfnGetStatusExtractor] Error determinando estado de ejecución del Proceso Extractor.\n");
			fprintf(stderr,"[bfnGetStatusExtractor] Error determinando estado de ejecución del Proceso Extractor.\n");
			fprintf(stderr,"[bfnGetStatusExtractor]  [%s]\n", sqlca.sqlerrm.sqlerrmc);
			vSqlErrorNew();
			return FALSE;
	    }
	    else
		{
			fprintf(pfLog ,"[bfnGetStatusExtractor] Tabla de Ejecución de Procesos Vacía. Primera Ejecución.\n");
			fprintf(stderr,"[bfnGetStatusExtractor] Tabla de Ejecución de Procesos Vacía. Primera Ejecución.\n");
			bIndPrimera = TRUE;
	    }
	    
	}
	if (bIndPrimera)
	{
		sprintf(szCodEstado, "%c", extNoIniciado);
		ihNumSeq = 0;
		*piSecuencia = 1;
	}
	else
	{
		strcpy(szCodEstado, szhCodEstaProc);
		*piSecuencia = ihNumSeq + 1;
	}	
	fprintf(pfLog ,"[bfnGetStatusExtractor] Secuencia Anterior:[%d] Status:[%s] Secuencia Nueva:[%d].\n", ihNumSeq, szCodEstado, *piSecuencia);
	fprintf(stderr,"[bfnGetStatusExtractor] Secuencia Anterior:[%d] Status:[%s] Secuencia Nueva:[%d].\n", ihNumSeq, szCodEstado, *piSecuencia);

	return TRUE;
}
/*---------------------------------------------------------------------------*/
/* Inserta nuevo registro de trazas para control de ejecucion...             */
/*---------------------------------------------------------------------------*/
int bfnInsertaNuevaSecuencia(int iNumSeq)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihNumSeq;
		char	szhCodEstProc[2];
		char	szhFecDesde[10];
		char	szhFecHasta[10];
	/* EXEC SQL END DECLARE SECTION; */ 


	fprintf(pfLog ,"[bfnInsertaNuevaSecuencia] Crea Nueva Secuencia de Ejecución:[%d]\n", iNumSeq);
	fprintf(stderr,"[bfnInsertaNuevaSecuencia] Crea Nueva Secuencia de Ejecución:[%d]\n", iNumSeq);
	
	ihNumSeq = iNumSeq;
	sprintf(szhCodEstProc, "%c",extNoIniciado);
	strcpy(szhFecDesde, stArgsNew.szFecDesde);
	strcpy(szhFecHasta, stArgsNew.szFecHasta);
		
	/* EXEC SQL INSERT INTO CM_EJECUTA_PROCESOS_TD
	(SEQ_PROCESO, COD_ESTAPROC, FEC_DESDE, FEC_HASTA, NOM_USUARIO )
	VALUES (
		:ihNumSeq, 
		:szhCodEstProc, 
		TO_DATE(:szhFecDesde,'YYYYMMDD'), 
		TO_DATE(:szhFecHasta,'YYYYMMDD'),
		USER); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CM_EJECUTA_PROCESOS_TD (SEQ_PROCESO,COD_ESTAPROC\
,FEC_DESDE,FEC_HASTA,NOM_USUARIO) values (:b0,:b1,TO_DATE(:b2,'YYYYMMDD'),TO_D\
ATE(:b3,'YYYYMMDD'),USER)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )93;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumSeq;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodEstProc;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
 sqlstm.sqhstl[2] = (unsigned long )10;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
 sqlstm.sqhstl[3] = (unsigned long )10;
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


	
    if (sqlca.sqlcode != SQLOK) 
    {
		fprintf(pfLog ,"[bfnInsertaNuevaSecuencia] Error Generando Secuencia de Ejecución.\n");
		fprintf(stderr,"[bfnInsertaNuevaSecuencia] Error Generando Secuencia de Ejecución.\n");
		fprintf(pfLog ,"[bfnInsertaNuevaSecuencia] Error:[%s]\n", sqlca.sqlerrm.sqlerrmc);
		fprintf(stderr,"[bfnInsertaNuevaSecuencia] Error:[%s]\n", sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
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


	return TRUE;
}
/*---------------------------------------------------------------------------*/
/* Ejecuta Proceso de Extracción                                             */
/*---------------------------------------------------------------------------*/
int bfnEjecutaExtractores()
{
	char 		szCodEstado[2];
	int			iSeqProceso;
	char 		szOK[20] = "Correctamente.";
	char 		szErr[20] = "Con ERROR.";
	
	/* Primero, validamos el estado de ejecución del último proceso de extracción */
	if (!(bfnGetStatusExtractor(szCodEstado, &iSeqProceso)))
	{
		fprintf(stderr,"[bfnEjecutaExtractores] Error determinando estado de ejecución del Proceso Extractor.\n");
		fprintf(pfLog,"[bfnEjecutaExtractores] Error determinando estado de ejecución del Proceso Extractor.\n");
		return FALSE;
	}
	/* si el último proceso se está ejecutando... */
	if (szCodEstado[0] == extIniciado)
	{
		fprintf(stderr,"[bfnEjecutaExtractores] El Proceso Extractor está actualmente EJECUTANDOSE.\n");
		fprintf(pfLog,"[bfnEjecutaExtractores] El Proceso Extractor está actualmente EJECUTANDOSE.\n");
		return FALSE;
	}
	if ((szCodEstado[0] == extNoIniciado)&&(iSeqProceso > 1))
	{
		fprintf(stderr,"[bfnEjecutaExtractores] Error de Consistencia de la traza de Ejecucion.\n");
		fprintf(pfLog ,"[bfnEjecutaExtractores] Error de Consistencia de la traza de Ejecucion.\n");
		return FALSE;
	}
	
	/* si el último proceso terminó su ejecución... */
	if ((szCodEstado[0] == extTermOk)||(szCodEstado[0] == extTermError))
	{
		fprintf(stderr,"[bfnEjecutaExtractores] El último proceso de Extracción Terminó %s\n", (szCodEstado[0] == extTermOk)?szOK:szErr);
		fprintf(pfLog ,"[bfnEjecutaExtractores] El último proceso de Extracción Terminó %s\n", (szCodEstado[0] == extTermOk)?szOK:szErr);
	}
	/* genera nueva secuencia de ejecucion de procesos */
	if (!bfnInsertaNuevaSecuencia(iSeqProceso))
	{
		fprintf(stderr,"[bfnEjecutaExtractores] Error generando trazas de procesos nueva ejecucion.\n");
		fprintf(pfLog ,"[bfnEjecutaExtractores] Error generando trazas de procesos nueva ejecucion.\n");
		return FALSE;
	}
	if (!(bfnControlaEjecucion(iSeqProceso)))
	{
		fprintf(pfLog,"[bfnEjecutaExtractores] Error ejecutando proceso de Extracción.\n");
		fprintf(pfLog,"[bfnEjecutaExtractores] Proceso se Cancela.\n");
		fprintf(stderr,"[bfnEjecutaExtractores] Error ejecutando proceso de Extracción.\n");
		fprintf(stderr,"[bfnEjecutaExtractores] Proceso se Cancela.\n");
		return FALSE;
	}
	return TRUE;
}
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
int bfnControlaEjecucion(int piSecuencia)
{
	stProcesos 	* paux;
	int     bRes = FALSE;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int	ihSecProceso;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihSecProceso = piSecuencia;
    fprintf(pfLog ,"\n(bfnControlaEjecucion) Marca Estado de Trazas INICIO Extractor Secuencia:[%d].\n",ihSecProceso);
    fprintf(stderr,"\n(bfnControlaEjecucion) Marca Estado de Trazas INICIO Extractor Secuencia:[%d].\n",ihSecProceso);
	if (!bfnMarcaEstadoExtractor(ihSecProceso, extIniciado))																	
	{                                                                                                                           
		fprintf(stderr,"[bfnControlaEjecucion] No fue posible modificar estado de ejecución de proceso:[%d]\n", piSecuencia);   
		fprintf(pfLog ,"[bfnControlaEjecucion] No fue posible modificar estado de ejecución de proceso:[%d]\n", piSecuencia);   
		return FALSE;                                                                                                           
	}                                                                                                                           
	
	lstProcesos = stfnCargaProcesos();
	fprintf(stderr,"[bfnControlaEjecucion] Muestra Lista de Procesos a Ejecutar.\n");
	fprintf(pfLog ,"[bfnControlaEjecucion] Muestra Lista de Procesos a Ejecutar.\n");
	vMuestraProcesos();

	for (paux = lstProcesos; paux != NULL; paux = paux->sgte)
	{
		if (paux->bFlgExisteProceso)
		{
		    fprintf(pfLog ,"\n(bfnControlaEjecucion) Actualiza Traza de Extractores(iCREATRAZA): Secuencia:[%d] Proceso:[%s].\n",ihSecProceso, paux->szDesUniverso);	
		    fprintf(stderr,"\n(bfnControlaEjecucion) Actualiza Traza de Extractores(iCREATRAZA): Secuencia:[%d] Proceso:[%s].\n",ihSecProceso, paux->szDesUniverso);    
			ifnActualizaTrazasExtractores(ihSecProceso, paux->szCodUniverso, 0, "X", iCREATRAZA);                                                                       

			fprintf(stderr,"[bfnControlaEjecucion] Ejecutando Proceso de [%s][%s].\n", paux->szCodUniverso, paux->szDesUniverso);
			fprintf(pfLog ,"[bfnControlaEjecucion] Ejecutando Proceso de [%s][%s].\n", paux->szCodUniverso, paux->szDesUniverso);
	        if(!(bLanzaProceso(ihSecProceso, paux->szNomExe, paux->szCodUniverso)))
	        {
				fprintf(stderr,"[bfnControlaEjecucion] Error ejecutando Proceso de [%s][%s].\n", paux->szCodUniverso, paux->szDesUniverso);
				fprintf(pfLog ,"[bfnControlaEjecucion] Error ejecutando Proceso de [%s][%s].\n", paux->szCodUniverso, paux->szDesUniverso);
	            bRes = bfnMarcaEstadoExtractor(ihSecProceso, extTermError);
	            return FALSE;
	        }
		}
		else
		{
			fprintf(stderr,"[bfnControlaEjecucion] Archivos de Universo [%s] no tiene Proceso Asociado. No es Posible Ejecutar.\n", paux->szDesUniverso);
			fprintf(stderr,"[bfnControlaEjecucion] Archivos de Universo [%s] no tiene Proceso Asociado. No es Posible Ejecutar.\n", paux->szDesUniverso);
		}
	}
	fprintf(stderr,"[bfnControlaEjecucion] Termino Exitoso de Ejecución de Procesos.\n");
	fprintf(pfLog ,"[bfnControlaEjecucion] Termino Exitoso de Ejecución de Procesos.\n");
    bRes = bfnMarcaEstadoExtractor(ihSecProceso, extTermOk);
    return TRUE;	
}
/* ------------------------------------------------------------------------- */
/* ------------------------------------------------------------------------- */
int bfnMarcaEstadoExtractor(int piSecuencia, char cNuevoEstado)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSecProceso;
		char 	szhCodEstaProc[2];
		int	    bRes;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihSecProceso = piSecuencia;
	sprintf(szhCodEstaProc, "%c", cNuevoEstado);
	
	/* EXEC SQL SELECT 
		CM_EXTRACTORES_PG.CM_MarcaEstadoExtractor_FN(:ihSecProceso, :szhCodEstaProc)
	INTO :bRes
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CM_EXTRACTORES_PG.CM_MarcaEstadoExtractor_FN(:b0,:b1)\
 into :b2  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )139;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihSecProceso;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodEstaProc;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&bRes;
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


	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr, "\n[bfnMarcaEstadoExtractor] Error en Package:[%s]", sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}
	if (bRes == 0)
		return TRUE;
	return FALSE;}
/* ------------------------------------------------------------------------- */
/* Valida el inicio de la ejecución del proceso XXX para la seq YYY          */
/* ------------------------------------------------------------------------- */
int bfnValidaInicioProceso(int piSecuencia, char * pszUniverso)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSecProceso;
		char 	szhCodUniverso[7];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihSecProceso = piSecuencia;
	
	/* EXEC SQL SELECT NVL(COD_PROCESO, 'N')
	INTO :szhCodUniverso
	FROM CM_EJECUTA_PROCESOS_TD
	WHERE SEQ_PROCESO = :ihSecProceso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(COD_PROCESO,'N') into :b0  from CM_EJECUTA_PROCES\
OS_TD where SEQ_PROCESO=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )166;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodUniverso;
 sqlstm.sqhstl[0] = (unsigned long )7;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihSecProceso;
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


	
	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr,"[bfnValidaInicioProceso] No fue posible verificar inicio de ejecución de proceso:[%s]\n", pszUniverso);
		fprintf(pfLog ,"[bfnValidaInicioProceso] No fue posible modificar estado de ejecución de proceso:[%s]\n", pszUniverso);
		return FALSE;
	}
	/* el solo hecho de que se haya inscrito en la traza indica que ya partió... */
	if (strcmp(pszUniverso,szfnTrim(szhCodUniverso))==0)
		return TRUE;
	return FALSE;
}
/* ------------------------------------------------------------------------- */
/* Recupera Estado de Ejecución de un Proceso                                */
/* ------------------------------------------------------------------------- */
char cfnValidaEjecucionProceso(int piSecuencia, char * pszUniverso)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int 	ihSecProceso;
		char 	szhCodUniverso[7];
		char    szhCodEstadoEjec[2];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	ihSecProceso = piSecuencia;
	strcpy(szhCodUniverso, pszUniverso);
	fprintf(stderr, "\n[cfnValidaEjecucionProceso] Validando Estado de Ejecucion Secuencia:[%d] Proceso:[%s]", ihSecProceso, szhCodUniverso);
	fprintf(pfLog , "\n[cfnValidaEjecucionProceso] Validando Estado de Ejecucion Secuencia:[%d] Proceso:[%s]", ihSecProceso, szhCodUniverso);

	/* EXEC SQL SELECT NVL(COD_ESTAEJEC, '')
	INTO :szhCodEstadoEjec
	FROM CM_EJECUTA_PROCESOS_TD
	WHERE SEQ_PROCESO = :ihSecProceso
	AND COD_PROCESO = :szhCodUniverso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(COD_ESTAEJEC,'') into :b0  from CM_EJECUTA_PROCES\
OS_TD where (SEQ_PROCESO=:b1 and COD_PROCESO=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )189;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstadoEjec;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihSecProceso;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodUniverso;
 sqlstm.sqhstl[2] = (unsigned long )7;
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


	
	if (sqlca.sqlcode != SQLOK)
	{
		fprintf(stderr,"\n[cfnValidaEjecucionProceso] Error determinando estado de ejecución de proceso:[%s]\n", pszUniverso);
		fprintf(stderr,"\n[cfnValidaEjecucionProceso] [[%s]]\n", sqlca.sqlerrm.sqlerrmc);
		fprintf(pfLog ,"\n[cfnValidaEjecucionProceso] Error determinando estado de ejecución de proceso:[%s]\n", pszUniverso);
		fprintf(pfLog ,"\n[cfnValidaEjecucionProceso] [[%s]]\n", sqlca.sqlerrm.sqlerrmc);
		return 0;
	}
	fprintf(stderr, "\n[cfnValidaEjecucionProceso] Estado de Ejecucion Secuencia:[%d] Proceso:[%s]   ----->[%s]", ihSecProceso, szhCodUniverso, szhCodEstadoEjec);
	fprintf(pfLog , "\n[cfnValidaEjecucionProceso] Estado de Ejecucion Secuencia:[%d] Proceso:[%s]   ----->[%s]", ihSecProceso, szhCodUniverso, szhCodEstadoEjec);
	
	return szhCodEstadoEjec[0];
}
/* ------------------------------------------------------------------------- */
/* MUESTRA LAESTRUCTURA DE BLOQUES Y PROCESOS EN PANTALLA                    */
/* ------------------------------------------------------------------------- */
void vMuestraProcesos()
{
	stProcesos 	* paux;
	
	fprintf(stderr,"\n---------------------------------------------\n");
	fprintf(stderr,"UNIVERSOS DE DATOS A PROCESOS \n");
	for (paux=lstProcesos;paux!=NULL;paux=paux->sgte)
	{	
		fprintf(stderr,"\n---------------------------------------------\n");
		fprintf(stderr,"Universo de Datos       :[%s]\n",paux->szCodUniverso);
		fprintf(stderr,"Descripción             :[%s]\n",paux->szDesUniverso);
		fprintf(stderr,"Ejecutable Binario      :[%s]\n",paux->szNomExe);
	}
	fprintf(stderr,"\n---------------------------------------------\n");
}
/*---------------------------------------------------------------------------*/
/* LANZA Y GESTIONA LA EJECUCION DE UN PROCESO DE COMISIONES....             */
/*---------------------------------------------------------------------------*/
int bLanzaProceso(int piSecuencia, char * pszNomExe, char * pszUniverso)
{
        char    szComandoUx[200];
        char    szUser[30];
        int     iRes;
        char    szSysDate[30];
        long    lhSecProceso;
        char    cEstProceso;
        long    i = 0;
        int     bSaleLoop = FALSE;
        
        if (!strlen(stArgsNew.szPass))
                strcpy(szUser,"");
        else
                strcpy(szUser, stArgsNew.szUser);

        /* construye el comando a ejecutar... */
        sprintf(szComandoUx, "%s/%s -u'%s/%s' -d%s -h%s -s%d&",
                pszEnvExe, 
                pszNomExe,
                szUser,
                stArgsNew.szPass,
                stArgsNew.szFecDesde,
                stArgsNew.szFecHasta,
                piSecuencia);
                
        /* Registra ejecucion en el LOG */
        fprintf(pfLog, "\n\n(bLanzaProceso)Preparando proceso a ejecutar: ");
        fprintf(pfLog, "\n(bLanzaProceso) <<%s>> \n",szComandoUx);
        fprintf(stderr,"\n\n(bLanzaProceso) Preparando proceso a ejecutar: ");   
        fprintf(stderr,"\n(bLanzaProceso) <<%s>> \n",szComandoUx);        

        /* Ejecuta el comando ... */
        iRes=system(szComandoUx);
/*                                                                                                */
/*        i = 0;                                                                                  */
/*        do                                                                                      */
/*        {                                                                                       */
/*            sleep(5);                                                                           */
/*            fprintf(stderr, "\n(bLanzaProceso) Valida Inicio del Proceso:[%s]", pszNomExe);     */
/*            fprintf(pfLog , "\n(bLanzaProceso) Valida Inicio del Proceso:[%s]", pszNomExe);     */
/*            if (!(bfnValidaInicioProceso(piSecuencia, pszUniverso)))                            */
/*            	i++;                                                                              */
/*            else                                                                                */
/*            	break;                                                                            */
/*                                                                                                */
/*        }while (i<7);                                                                           */
/*        fprintf(stderr, "\n(bLanzaProceso) Iteración de Validacion:[%d]", i);                   */
/*        fprintf(pfLog , "\n(bLanzaProceso) Iteración de Validacion:[%d]", i);                   */
/*        if (i>=7)                                                                               */
/*                return FALSE;																	  */
/*                                                                                                */
        /* El proceso partió Ok, ahora esperamos a que termine... */

        i = 0;
        do
        {
            cEstProceso = cfnValidaEjecucionProceso(piSecuencia, pszUniverso);
            switch  (cEstProceso)
            {
                case extTermError:
                    /* El proceso se cayo... salir con false... */
                    fprintf(pfLog , "\n\n(bLanzaProceso)Error Ejecutando proceso [%s]. Revise el Log.\n",pszUniverso);
                    fprintf(stderr, "\n\n(bLanzaProceso)Error Ejecutando proceso [%s]. Revise el Log.\n",pszUniverso);
                    bSaleLoop = TRUE;
                    break;
                case extIniciado:
                    /* El proceso se esta ejecutando... */
                    sleep(10);
                    i++;
                    break;
                case extTermOk:
                    /* El proceso termino Ok... */
                    fprintf(pfLog, "\n\n(bLanzaProceso)Proceso [%s] Termina sin errores.\n",pszUniverso);
                    fprintf(stderr, "\n\n(bLanzaProceso)Proceso [%s] Termina sin errores.\n",pszUniverso);
                    bSaleLoop = TRUE;
                    break;
                default:
                    fprintf(pfLog, "\n\n(bLanzaProceso)Error determinando estado de ejecucion de Proceso [%s].\n",pszUniverso);
                    fprintf(stderr, "\n\n(bLanzaProceso)Error determinando estado de ejecucion de Proceso [%s].\n",pszUniverso);
                    bSaleLoop = TRUE;
                    break;
        	}
        }while (!bSaleLoop);
        if (cEstProceso!=extTermOk)
                return FALSE;

        return TRUE;
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.                */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
    memset(&stArgsNew, 0, sizeof(rg_argumentosnew));
    vManejaArgsnew(argc, argv);
/*---------------------------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                                         */
/*---------------------------------------------------------------------------------------------*/
    strcpy(szhUser, stArgsNew.szUser);
    strcpy(szhPass, stArgsNew.szPass);
    if(fnOraConnect(szhUser, szhPass) == FALSE)
    {
            fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
            exit(EXIT_205);
    }
    else
    {
            fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");
            fprintf(stderr, "Username: %s\n\n", szhUser);
    }
/*---------------------------------------------------------------------------------------------*/
/* Configuracion de idioma espanol para tratamiento de fechas.                                 */
/*---------------------------------------------------------------------------------------------*/
    if(strcmp(getenv("LC_TIME"), LC_TIME_SPANISH) == 0)
    {
            setlocale(LC_TIME, LC_TIME_SPANISH);
    }
/*---------------------------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                                       */
/*---------------------------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando ambiente para archivos de log...\n");
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)                                                      
    {                                                                                                                         
        exit(EXIT_03);     
    }                                                                                                                         
    fprintf(stderr, "Recupera Path de Procesos Ejecutables (Binarios) ...\n");
    if((pszEnvExe = (char *)pszEnviron("XPCM_EXE", "")) == (char *)NULL)                                                      
    {                                                                                                                         
        exit(EXIT_03);     
    }                                                                                                                         
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);                                          
    fprintf(stderr, "Directorio de Ejecutables  : [%s]\n", (char *)pszEnvExe);                                          
/*---------------------------------------------------------------------------------------------*/
/* Ingresa parametros para estructura que crea archivo de Log                                  */
/*---------------------------------------------------------------------------------------------*/
	fprintf(stderr, "Abriendo archivo de Log...");
     strncpy(szhSysDate, pszGetDateLog(),16);                                                           

    bGeneraArchivoExtractores(&pfLog, LOGNAME, pszEnvLog,szhSysDate,LOG,szLogName );                                                          
    if(pfLog == NULL)                                                          
    {                                                                                                        
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);                                 
        fprintf(stderr, "Revise su existencia.\n");                                                          
        fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
        fprintf(stderr, "Proceso finalizado con error.\n");
        exit(EXIT_03);                                                  
    }    
/*---------------------------------------------------------------------------*/
/* HEADER.                                                                   */
/*---------------------------------------------------------------------------*/ 
    vFechaHora();
    fprintf(pfLog, "Procesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION             : [%s]\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision     : [%s]\n", LAST_REVIEW);
	fprintf(pfLog, "Base de datos       : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE      : [%s]\n",(char * )sysGetUserName()); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n[Extractores] Argumentos de Ejecucion\n");
    fprintf(pfLog, "[Extractores]   Fecha de Inicio       	<%s>\n", stArgsNew.szFecDesde);
    fprintf(pfLog, "[Extractores]   Fecha de Término    	    <%s>\n", stArgsNew.szFecHasta);

    vFechaHora();
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(stderr, "%s\n", szRaya);                    
    fprintf(stderr, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(stderr, "%s\n", GLOSA_PROG);                
    fprintf(stderr, "VERSION             : [%s]\n", PROG_VERSION);      
    fprintf(stderr, "Ultima Revision     : [%s]\n", LAST_REVIEW);
	fprintf(stderr, "Base de datos       : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(stderr, "Usuario ORACLE      : [%s]\n",(char * )sysGetUserName()); 
    fprintf(stderr, "%s\n\n", szRaya);                  

    fprintf(stderr, "\n[Extractores] Argumentos de Ejecucion\n");
    fprintf(stderr, "[Extractores]   Fecha de Inicio       	<%s>\n", stArgsNew.szFecDesde);
    fprintf(stderr, "[Extractores]   Fecha de Término    	<%s>\n", stArgsNew.szFecHasta);

/*---------------------------------------------------------------------------*/
/* MODIFICACION DE CONFIGURACION AMBIENTAL, PARA MANEJO DE FECHAS EN ORACLE. */
/*---------------------------------------------------------------------------*/
        /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )216;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


/*---------------------------------------------------------------------------*/
/*    INICIA PROCESAMIENTO PRINCIPAL.                                        */
/*---------------------------------------------------------------------------*/
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());     
        fprintf(pfLog, "Inicio procesamiento principal ...\n\n");
/*---------------------------------------------------------------------------*/
/* EJECUTA LA CORRELACION DE PROCESOS DE COMISIONES                          */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "[Comisiones]Ejecuta la correlacion de procesos de Comisiones.\n\n");     
    fprintf(pfLog, "[Comisiones]Ejecuta la correlacion de procesos de Comisiones.\n\n");     
	bfnEjecutaExtractores();
/*---------------------------------------------------------------------------*/

    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )231;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    return(EXIT_0); /*EstadoProceso*/
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

