
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
static struct sqlcxp sqlfpn =
{
    18,
    "./pc/Comisiones.pc"
};


static unsigned int sqlctx = 13806467;


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
   unsigned char  *sqhstv[7];
   unsigned long  sqhstl[7];
            int   sqhsts[7];
            short *sqindv[7];
            int   sqinds[7];
   unsigned long  sqharm[7];
   unsigned long  *sqharc[7];
   unsigned short  sqadto[7];
   unsigned short  sqtdso[7];
} sqlstm = {12,7};

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

 static char *sq0005 = 
"select COD_BLOQUE ,ORD_BLOQUE  from CMD_BLOQUES where COD_LINEA_PROC=:b0 ord\
er by ORD_BLOQUE desc             ";

 static char *sq0006 = 
"select A.COD_PROCESO ,A.DIR_PROCESO ,A.NOM_EXE ,B.ORD_PROCESO ,A.IND_ARCHIVO\
 ,A.TIP_PERIODO  from CMD_BLOQUES_PROCESOS B ,CMD_PROCESOS A where (B.COD_BLOQ\
UE=:b0 and B.COD_PROCESO=A.COD_PROCESO) order by B.ORD_PROCESO desc           \
  ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,101,0,5,416,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
28,0,0,2,0,0,29,428,0,0,0,0,0,1,0,
43,0,0,3,95,0,4,445,0,0,3,2,0,1,0,2,1,0,0,1,3,0,0,1,3,0,0,
70,0,0,4,172,0,4,478,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
101,0,0,5,110,0,9,529,0,0,1,1,0,1,0,1,97,0,0,
120,0,0,5,0,0,13,536,0,0,2,0,0,1,0,2,97,0,0,2,3,0,0,
143,0,0,5,0,0,15,556,0,0,0,0,0,1,0,
158,0,0,6,234,0,9,609,0,0,1,1,0,1,0,1,97,0,0,
177,0,0,6,0,0,13,616,0,0,6,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,
2,97,0,0,
216,0,0,6,0,0,15,645,0,0,0,0,0,1,0,
231,0,0,7,69,0,4,698,0,0,1,0,0,1,0,2,97,0,0,
250,0,0,8,202,0,4,720,0,0,5,4,0,1,0,2,1,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,
285,0,0,9,250,0,4,755,0,0,7,6,0,1,0,2,1,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,
328,0,0,10,54,0,2,916,0,0,1,1,0,1,0,1,97,0,0,
347,0,0,11,53,0,2,924,0,0,1,1,0,1,0,1,97,0,0,
366,0,0,12,51,0,2,930,0,0,1,1,0,1,0,1,97,0,0,
385,0,0,13,87,0,2,942,0,0,1,1,0,1,0,1,97,0,0,
404,0,0,14,86,0,2,950,0,0,1,1,0,1,0,1,97,0,0,
423,0,0,15,66,0,5,958,0,0,1,1,0,1,0,1,97,0,0,
442,0,0,16,83,0,2,968,0,0,1,1,0,1,0,1,97,0,0,
461,0,0,17,82,0,2,976,0,0,1,1,0,1,0,1,97,0,0,
480,0,0,18,171,0,3,1052,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,1,0,
0,
515,0,0,19,0,0,29,1075,0,0,0,0,0,1,0,
530,0,0,20,66,0,5,1092,0,0,2,2,0,1,0,1,1,0,0,1,3,0,0,
553,0,0,21,0,0,29,1103,0,0,0,0,0,1,0,
568,0,0,22,67,0,5,1201,0,0,1,1,0,1,0,1,97,0,0,
587,0,0,23,48,0,1,1378,0,0,0,0,0,1,0,
602,0,0,24,0,0,30,1442,0,0,0,0,0,1,0,
};


/*---------------------------------------------------------------------------*/
/* Programa : GEN_CorrProcesos.pc                                            */
/*            Programa encargado de correlacionar los procesos de Comisiones.*/
/* Autora   : Ana Maria Olivos.                                              */
/* Modificado por : Richard Troncoso C.                                      */
/* Fecha Ultimas Modificaciones: Enero-2002                                  */
/* Arreglado y normalizado por Fabián Aedo Ramírez (Ene-2003).               */
/*---------------------------------------------------------------------------*/
/* RAO070302: Se agregan la rutina de recuperacion de parametros para el     */
/*                       manejo de montos y decimales.                       */
/*---------------------------------------------------------------------------*/
/* Versionado Cuzco: (Fabian Aedo R. Julio - 2003)                           */
/* - Se modifica estructura de parámetros. Se elimina flag de salida a arch. */
/*   de dato, y se incorpora tipo de ciclo de comisiones en proceso (P/E).   */
/* - bValidaPeriodos Se incorpora tratamiento para distinguir validaciones   */
/*   según sea el tipo de periodo en ejecución.                              */
/* - Se corrige la emisión de mensajes a salida estandar y log, anteponiendo */
/*   el nombre de la función que origina el mensaje.                         */
/*---------------------------------------------------------------------------*/
#include "Comisiones.h"
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

    fprintf(pfLog, "\n[Comisiones] Error ORACLE: \n");
    fprintf(pfLog, "[Comisiones] %s\n", sqlca.sqlerrm.sqlerrmc); 
    fprintf(pfLog, "SE TERMINA LA EJECUCION DEL PROCESO.\n");
}

/* --------------------------------------------------------------- */
/* COPIA (LARGO) CARACTERES SOBRE S1, DESDE S2, PARTIENDO EN (INIC)*/
/* S1 DEBE ESTAR VACIO.                                            */
/* --------------------------------------------------------------- */
void szMidChar(char* pszTarget, char * pszSource, int piInic, int piCant)
{
    int i=0;
    int j=0;
    for (i=piInic, j=0; j<piCant; i++, j++)
        pszTarget[j]=pszSource[i];
    pszTarget[j]='\0';
        
}
/*---------------------------------------------------------------------------*/
/* RUTINA PARA MANEJO Y VALIDACION DE ARGUMENTOS INGRESADOS COMO PARAMETROS  */
/* EXTERNOS.                                                                 */
/*---------------------------------------------------------------------------*/
void  vManejaArgsnew (int argc, char * const argv[])
{
    int         iOpt = 0;
    extern char *optarg;
    char        opstring[] = ":u:l:f:i:";
    char        *szUserid_Aux;
    char        userid[70];
    char        szaux[10];

    while((iOpt=getopt(argc, argv, opstring)) != EOF)
    {
        switch(iOpt)
        {
            case 'l':
            	if(stArgsNew.bFlagCodLineaProc == FALSE)
                {
                	if(optarg[0]=='-')
                    {
                    	fprintf(stderr, "\nOpcion -%c tiene argumento", optopt);
                        fprintf(stderr," invalido. Se cancela.\n");
                        fprintf(stderr, "%s\n\n", szUsonew);
                        exit(EXIT_01);
                     }
                            strcpy(stArgsNew.szCodLineaProc, optarg);
							fprintf(stderr, "\n[vManejaArgsnew]Linea de Proceso:%s\n ",stArgsNew.szCodLineaProc);
                }
                else
                {
                	fprintf(stderr, "\nOpcion -%c duplicada.", optopt);
                    fprintf(stderr," Se cancela.\n");
                    fprintf(stderr, "%s\n\n", szUsonew);
                    exit(EXIT_01);
                }
                stArgsNew.bFlagCodLineaProc=TRUE;
                break;

  			case 'f':
		    	if(stArgsNew.bFlagIndSeleccion == FALSE)
		        {
		        	if(optarg[0]=='-')
		            {
		            	fprintf(stderr, "\nOpcion -%c tiene argumento", optopt);
		               	fprintf(stderr," invalido. Se cancela.\n");
		               	fprintf(stderr, "%s\n\n", szUsonew);
		               	exit(EXIT_01);
		            }
		
		        	stArgsNew.szIndSeleccion = optarg[0];
		        }
		        else
		        {
		        	fprintf(stderr, "\nOpcion -%c duplicada.", optopt);
		            fprintf(stderr," Se cancela.\n");
		            fprintf(stderr, "%s\n\n", szUsonew);
		            exit(EXIT_01);
		        }
		        stArgsNew.bFlagIndSeleccion=TRUE;
		        break;

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

			case 'i':

            	if(stArgsNew.bFlagIdPeriodo == FALSE)
                {
                   if(optarg[0]=='-')
                    {
                    	fprintf(stderr, "\nOpcion -%c tiene argumento", optopt);
                        fprintf(stderr," invalido. Se cancela.\n");
                        fprintf(stderr, "%s\n\n", szUsonew);
                        exit(EXIT_01);
                    }
                    strcpy(stArgsNew.szIdPeriodo , optarg);
                }
                else
                {
                    fprintf(stderr, "\nOpcion -%c duplicada.", optopt);
                    fprintf(stderr," Se cancela.\n");
                    fprintf(stderr, "%s\n\n", szUsonew);
                	exit(EXIT_01);
                }
                stArgsNew.bFlagIdPeriodo = TRUE;
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

    if (stArgsNew.bFlagCodLineaProc == FALSE)
    {
        fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "Se requiere argumento -l[LineaProceso]\n");
        fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "%s\n\n", szUsonew);
        exit(EXIT_01);
    }

    /* Si linea de proceso es Mensual...*/
    if (stArgsNew.szCodLineaProc[1]=='M')
    {
        if (stArgsNew.bFlagCodPeriodo == FALSE)
        {
            fprintf(stderr, "%s\n", szRaya);
            fprintf(stderr, "Se requiere argumento -p[Periodo<YYYYMMDD>]\n");
            fprintf(stderr, "%s\n", szRaya);
            fprintf(stderr, "%s\n\n", szUsonew);
		}
        stArgsNew.bFlagIdPeriodo = TRUE;
    }
    /* Si linea de proceso es Parcial...*/
    if (stArgsNew.szCodLineaProc[1]=='P')
    {
        if (stArgsNew.bFlagIdPeriodo == FALSE)
        {
            fprintf(stderr, "%s\n", szRaya);
            fprintf(stderr, "Se requiere argumento -i[IdPeriodo<YYYYMMDD><M|Q|S><1..4>]\n");
            fprintf(stderr, "%s\n", szRaya);
            fprintf(stderr, "%s\n\n", szUsonew);
            exit(EXIT_104);
         }
         szMidChar(szaux,stArgsNew.szIdPeriodo,0,8);
         stArgsNew.lCodPeriodo = atol(szaux);
         stArgsNew.bFlagCodPeriodo = TRUE;
    }

    if (((stArgsNew.bFlagIndSeleccion) && (stArgsNew.szIndSeleccion != 'S') 
                && (stArgsNew.szIndSeleccion != 'N'))
            || (!(stArgsNew.bFlagIndSeleccion) && (stArgsNew.szCodLineaProc[0] == 'R')))
    {
        fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "Argumento Erroneo. -f[SELECCION(<S|N>]\n");
        fprintf(stderr, "%s\n", szRaya);
        fprintf(stderr, "%s\n\n", szUso);
    	exit(EXIT_104);
	}
}
/*---------------------------------------------------------------------------*/
/* FUNCION ENCARGADA DE VALIDAR EL ESTADO DE LOS PERIODOS ACTUAL Y ANTERIOR  */
/*---------------------------------------------------------------------------*/
int bValidaPeriodos()
{
    reg_ciclo    stCicloAnt;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodPeriodoAnt;
         char    szhIdPeriodoAnt[12];
         char    szCodLineaProc[3];
    /* EXEC SQL END DECLARE SECTION; */ 

    
	fprintf(stderr, "\n[bValidaPeriodos] Inicia Validacion de Estados de Ciclos de Comisiones.\n");
	strcpy(szCodLineaProc,stArgsNew.szCodLineaProc);
         
    if (stCiclo.cTipCiclComis == PERIODICO)
    {
          fprintf(pfLog, "\n[bValidaPeriodos] Validacion de estados de periodo.\n");
          lhCodPeriodoAnt = lNewCiclComis(stCiclo.lCodCiclComis, -1);
		  strcpy(szhIdPeriodoAnt, (char * ) szNewCiclComis(lhCodPeriodoAnt));
    
          fprintf(stderr, "[bValidaPeriodos] Ciclo Anterior        [%s]\n", szhIdPeriodoAnt);
    
          memset(&stCicloAnt, 0, sizeof(reg_ciclo));
    
          if (vCargaCiclo(szhIdPeriodoAnt,&stCicloAnt))
          {
              if (strcmp(stCicloAnt.szCodEstado,estCerrado)!=0)
              {
                   vFechaHora();
                   fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                   fprintf(pfLog, "[bValidaPeriodos] Periodo anterior [%ld] no se encuentra cerrado.\n",lhCodPeriodoAnt);
                   fprintf(pfLog, "[bValidaPeriodos] Imposible ejecutar cualquier proceso sobre periodo actual.\n\n");
                   fprintf(stderr, "[bValidaPeriodos] Periodo Anterior [%ld] no se encuentra cerrado.\n",lhCodPeriodoAnt);
                   fprintf(stderr, "[bValidaPeriodos] Imposible ejecutar cualquier proceso sobre periodo actual.\n\n");
                   return FALSE;
              }
          }
    }   
    
    if (strcmp(stCiclo.szCodEstado,estCerrado)==0)
    {
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog , "[bValidaPeriodos - CER] Periodo Actual [%ld] se encuentra cerrado.\n",stCiclo.lCodCiclComis);
        fprintf(pfLog , "[bValidaPeriodos - CER] Imposible ejecutar cualquier proceso sobre periodo actual.\n\n");
        fprintf(stderr, "[bValidaPeriodos - CER] Periodo Actual [%ld] se encuentra cerrado.\n",stCiclo.lCodCiclComis);
        fprintf(stderr, "[bValidaPeriodos - CER] Imposible ejecutar cualquier proceso sobre periodo actual.\n\n");
        return FALSE;
    }
         
    if (strcmp(stCiclo.szCodEstado,estEnProceso)==0)
    {
        vFechaHora();
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "[bValidaPeriodos - PRC] Periodo Actual [%ld] Se encuentra en ejecucion.\n",stCiclo.lCodCiclComis);
        fprintf(pfLog, "[bValidaPeriodos - PRC] Debe esperar a que termine para realizar cualquier accion.\n\n");
        fprintf(stderr, "[bValidaPeriodos - PRC] Periodo Actual [%ld] Se encuentra en ejecucion.\n",stCiclo.lCodCiclComis);
        fprintf(stderr, "[bValidaPeriodos - PRC] Debe esperar a que termine para realizar cualquier accion.\n\n");
        return FALSE;
    }
    
    /* Valida de acuerdo a la linea de proceso a ejecutar... */
    if ((strcmp(szCodLineaProc,"CM")==0)||(strcmp(szCodLineaProc,"CP")==0))
    {
        /* Para linea de cierre, solo es posible el estado TER */
        if (strcmp(stCiclo.szCodEstado,estTerminado)==0)
        {
                vFechaHora();
                fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                fprintf(pfLog, "[bValidaPeriodos CM-TER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                fprintf(pfLog, "[bValidaPeriodos CM-TER] El comando a ejecutar es válido.\n\n");
                fprintf(stderr, "[bValidaPeriodos CM-TER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                fprintf(stderr, "[bValidaPeriodos CM-TER] El comando a ejecutar es válido.\n\n");
                return TRUE;
        }
        else
        {
                vFechaHora();
                fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                fprintf(pfLog, "[bValidaPeriodos CM-NOTER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                fprintf(pfLog, "[bValidaPeriodos CM-NOTER] El comando a ejecutar NO es valido.\n\n");
                fprintf(stderr, "[bValidaPeriodos CM-NOTER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                fprintf(stderr, "[bValidaPeriodos CM-NOTER] El comando a ejecutar NO es valido.\n\n");
                return FALSE;
        }
    }
    else
    {
        if ((strcmp(szCodLineaProc,"RM")==0)||(strcmp(szCodLineaProc,"RP")==0))
        {
                /* Para linea de reversa, solo es posible el estado TER */
                if ((strcmp(stCiclo.szCodEstado,estTerminado)==0)||(strcmp(stCiclo.szCodEstado,estTermError)==0))
                {
                        vFechaHora();
                        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                        fprintf(pfLog, "[bValidaPeriodos RM-TER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(pfLog, "[bValidaPeriodos RM-TER] El comando a ejecutar es válido.\n\n");
                        fprintf(stderr, "[bValidaPeriodos RM-TER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(stderr, "[bValidaPeriodos RM-TER] El comando a ejecutar es válido.\n\n");
                        return TRUE;
                }
                else
                {
                        vFechaHora();
                        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                        fprintf(pfLog, "[bValidaPeriodos RM-NOTER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(pfLog, "[bValidaPeriodos RM-NOTER] El comando a ejecutar NO es valido.\n\n");
                        fprintf(stderr, "[bValidaPeriodos RM-NOTER] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(stderr, "[bValidaPeriodos RM-NOTER] El comando a ejecutar NO es valido.\n\n");
                        return FALSE;
                }
        }
        else
        {
                if ((strcmp(szCodLineaProc,"PM")==0)||(strcmp(szCodLineaProc,"PP")==0))
                {
                        /* Para linea de proceso, solo son posibles estados INI y FAL */
                        if ((strcmp(stCiclo.szCodEstado,estInicial)==0)||(strcmp(stCiclo.szCodEstado,estTermError)==0))
                        {
                                vFechaHora();
                                fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                                fprintf(pfLog, "[bValidaPeriodos PM-INI] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                                fprintf(pfLog, "[bValidaPeriodos PM-INI] El comando a ejecutar es válido.\n\n");
                                fprintf(stderr, "[bValidaPeriodos PM-INI] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>Correcto.\n",szCodLineaProc,stCiclo.szCodEstado);
                                fprintf(stderr, "[bValidaPeriodos PM-INI] El comando a ejecutar es válido.\n\n");
                                return TRUE;
                        }
                        else
                        {
                                vFechaHora();
                                fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                                fprintf(pfLog, "[bValidaPeriodos PM-NOINI] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                                fprintf(pfLog, "[bValidaPeriodos PM-NOINI] El comando a ejecutar NO es valido.\n\n");
                                fprintf(stderr, "[bValidaPeriodos PM-NOINI] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                                fprintf(stderr, "[bValidaPeriodos PM-NOINI] El comando a ejecutar NO es valido.\n\n");
                                return FALSE;
                        }
                }
                else
                {
                        vFechaHora();
                        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
                        fprintf(pfLog, "[bValidaPeriodos OTRAS] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(pfLog, "[bValidaPeriodos OTRAS] El comando a ejecutar NO es valido.\n\n");
                        fprintf(stderr, "[bValidaPeriodos OTRAS] Linea de Proceso[%s], Estado de Ciclo:[%s]:===>INCORRECTO.\n",szCodLineaProc,stCiclo.szCodEstado);
                        fprintf(stderr, "[bValidaPeriodos OTRAS] El comando a ejecutar NO es valido.\n\n");
                        return FALSE;
                }
        }
    }
}

/*************************************************************************************/
/* Funcion encargada de actualizar el estado del periodo, dejandolo como Iniciado    */
/*************************************************************************************/
int iMarcaEstadoPeriodo(char * pszIdPeriodo, char * pszCodEstado)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhEstado[4];
         char szhIdPeriodo[11];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy(szhIdPeriodo, pszIdPeriodo);
    strcpy(szhEstado   , pszCodEstado);

    /* EXEC SQL UPDATE CM_CICLCOMIS_TD 
         SET COD_ESTADO  = :szhEstado,
             FEC_ULTMOD  = SYSDATE,
             NOM_USUARIO = USER
        WHERE ID_CICLCOMIS = :szhIdPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CM_CICLCOMIS_TD  set COD_ESTADO=:b0,FEC_ULTMOD=SYS\
DATE,NOM_USUARIO=USER where ID_CICLCOMIS=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhEstado;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodo;
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


                                                                                                                   
    if (sqlca.sqlcode != SQLOK) 
    {
       fprintf(pfLog,"[Comisiones] Error modificando periodo a estado <%s>,  ID periodo <%s>\n", pszCodEstado, szhIdPeriodo);
       vSqlErrorNew();
    }
           
    /* EXEC SQL commit; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )28;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    return (TRUE);
}
/* ------------------------------------------------------------------------- */
/* FUNCION ENCARGADA DE TESTEAR EL ESTADO DE EJECUCION DE UN PROCESO.        */
/* ------------------------------------------------------------------------- */
char cGetEstadoProceso(long lSecBloque, long lSecProceso)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char    chEstProceso;
         long    lhSecBloque;
         long    lhSecProceso;
    /* EXEC SQL END DECLARE SECTION; */ 

    
    lhSecBloque     = lSecBloque;
    lhSecProceso    = lSecProceso;
        
    /* EXEC SQL SELECT IND_ESTADO
    INTO  :chEstProceso
    FROM  CMT_TRAZAS_PROCESOS
    WHERE SEC_PROCESO       = :lhSecProceso
    AND   SEC_BLOQUE        = :lhSecBloque; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select IND_ESTADO into :b0  from CMT_TRAZAS_PROCESOS wher\
e (SEC_PROCESO=:b1 and SEC_BLOQUE=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )43;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&chEstProceso;
    sqlstm.sqhstl[0] = (unsigned long )1;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhSecProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhSecBloque;
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



    if (sqlca.sqlcode != SQLOK) 
    {
       fprintf(stderr, "\n(cGetEstadoProceso)Error validando inicio de proceso en CMT_TRAZAS_PROCESOS.\n");
       return 'X';
    }

    return chEstProceso;
}

/* ------------------------------------------------------------------------- */
/* FUNCION ENCARGADA DE VALIDAR EL INICIO DE UN PROCESO DETERMINADO.         */
/* RETORNA 0    : PROCESO NO EXISTE, NO HA PARTIDO.                          */
/* RETORNA >0   : SECUENCIA DE PROCESO, YA PARTIO.                           */
/* ------------------------------------------------------------------------- */
long lValidaInicioProceso(long lSecBloque, char * szCodProceso, char * pszSysDate)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int     lhSeqProcesos;
         long    lhSecBloque;
         char    szhCodProceso[16];
         char    szhSysDate[30];
    /* EXEC SQL END DECLARE SECTION; */ 

    
    lhSecBloque         = lSecBloque;
    strcpy(szhCodProceso, szCodProceso);
    strcpy(szhSysDate   , pszSysDate);
        
    /* EXEC SQL SELECT SEC_PROCESO
    INTO  :lhSeqProcesos
    FROM  CMT_TRAZAS_PROCESOS
    WHERE SEC_PROCESO > 0
    AND   SEC_BLOQUE  = :lhSecBloque
    AND   COD_PROCESO = :szhCodProceso
    AND   FEC_INICIO  >= TO_DATE(:szhSysDate,'DD-MON-YYYY HH24:MI:SS'); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select SEC_PROCESO into :b0  from CMT_TRAZAS_PROCESOS whe\
re (((SEC_PROCESO>0 and SEC_BLOQUE=:b1) and COD_PROCESO=:b2) and FEC_INICIO>=T\
O_DATE(:b3,'DD-MON-YYYY HH24:MI:SS'))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )70;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhSeqProcesos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhSecBloque;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodProceso;
    sqlstm.sqhstl[2] = (unsigned long )16;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhSysDate;
    sqlstm.sqhstl[3] = (unsigned long )30;
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
       fprintf(stderr, "\n(lValidaInicioProceso) Proceso [%s] no fue encontrado en CMT_TRAZAS_PROCESOS.\n",szhCodProceso);
       return 0;
    }
    return lhSeqProcesos;
}
/* ------------------------------------------------------------------------- */
/* FUNCION ENCARGADA DE CARGAR LOS BLOQUES QUE SERAN EJECUTADOS              */
/* ------------------------------------------------------------------------- */
void vCargaBloques()
{
     stBloques * paux;
     stBloques * qaux;
     
     int      i;                                                         
     short    iLastRows    = 0;                                              
     int      iFetchedRows = MAXFETCH;                                       
     int      iRetrievRows = MAXFETCH;                 
     int      iCuentaRegs  = 0;
     
     /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhCodBloque[MAXFETCH][16];
        int     ihOrdBloque[MAXFETCH];
        char    szhLineaProc[3];        
        long    lMaxFetch;             
     /* EXEC SQL END DECLARE SECTION; */ 

     
     qaux  = NULL;
     paux  = NULL;
     
     sprintf(szhLineaProc, stArgsNew.szCodLineaProc);

     /* EXEC SQL DECLARE CUR_BLOQUES CURSOR FOR 
     SELECT  COD_BLOQUE, 
             ORD_BLOQUE
     FROM    CMD_BLOQUES
     WHERE   COD_LINEA_PROC  = :szhLineaProc
     ORDER BY ORD_BLOQUE DESC; */ 

     
     if(sqlca.sqlcode != SQLOK)
        vSqlErrorNew;
     
     /* EXEC SQL OPEN CUR_BLOQUES; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0005;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )101;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhLineaProc;
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


     if(sqlca.sqlcode != SQLOK)
        vSqlErrorNew;
 
     lMaxFetch = MAXFETCH;
     while(iFetchedRows == iRetrievRows)                                            
     {                                                                              
           /* EXEC SQL for :lMaxFetch                                                
                FETCH CUR_BLOQUES INTO
                      :szhCodBloque,
                      :ihOrdBloque; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 4;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )lMaxFetch;
           sqlstm.offset = (unsigned int  )120;
           sqlstm.selerr = (unsigned short)1;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqfoff = (         int )0;
           sqlstm.sqfmod = (unsigned int )2;
           sqlstm.sqhstv[0] = (unsigned char  *)szhCodBloque;
           sqlstm.sqhstl[0] = (unsigned long )16;
           sqlstm.sqhsts[0] = (         int  )16;
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqharc[0] = (unsigned long  *)0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)ihOrdBloque;
           sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[1] = (         int  )sizeof(int);
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
               paux = (stBloques *) malloc(sizeof(stBloques)); 
               strcpy(paux->szCodBloque  , szfnTrim(szhCodBloque[i]));
               paux->iOrdBloque          = ihOrdBloque[i];
               paux->cIndEjecucion       = 'S';
               paux->sgte_proceso        = NULL;
               paux->sgte                = qaux;
               qaux                      = paux;
               iCuentaRegs ++;   
     		}
    }
    /* EXEC SQL CLOSE CUR_BLOQUES; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )143;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de bloques para:[%s] = [%d]\n",szhLineaProc,iCuentaRegs);
    lstBloques = qaux;
}

/* ------------------------------------------------------------------------- */
/* FUNCION ENCARGADA DE CARGAR LOS PROCESOS QUE SERAN EJECUTADOS             */
/* ------------------------------------------------------------------------- */
stProcesos * stCargaProcesos (char * szCodBloque)
{
     stProcesos * paux;
     stProcesos * qaux;

     int        i;                                                         
     short      iLastRows    = 0;                                              
     int        iFetchedRows = MAXFETCH;                                       
     int        iRetrievRows = MAXFETCH;                 
     int        iCuentaRegs  = 0;
     
     /* EXEC SQL BEGIN DECLARE SECTION; */ 

          char    szhCodProceso   [MAXFETCH][16];         
          char    szhDirProceso   [MAXFETCH][51];         
          char    szhNomExe       [MAXFETCH][31];         
          int     ihOrdProceso    [MAXFETCH];
          char    chTipPeriodo    [MAXFETCH][2];
          char    chIndArchivo    [MAXFETCH][2];
          char    szhCodBloque    [16];
          char    szhLineaProc    [3];            
          long    lMaxFetch;             
	 /* EXEC SQL END DECLARE SECTION; */ 


     strcpy(szhCodBloque,szCodBloque);
     qaux  = NULL;
     paux  = NULL;
     
     sprintf(szhLineaProc, stArgsNew.szCodLineaProc);

     /* EXEC SQL DECLARE CUR_PROCESOS CURSOR FOR 
        SELECT  A.COD_PROCESO, 
                A.DIR_PROCESO, 
                A.NOM_EXE, 
                B.ORD_PROCESO, 
                A.IND_ARCHIVO, 
                A.TIP_PERIODO
        FROM    CMD_BLOQUES_PROCESOS B, 
                CMD_PROCESOS A
        WHERE   B.COD_BLOQUE    = :szhCodBloque
        AND     B.COD_PROCESO   = A.COD_PROCESO
     ORDER BY B.ORD_PROCESO DESC; */ 

     
     if(sqlca.sqlcode != SQLOK)
        vSqlErrorNew;
     
     /* EXEC SQL OPEN CUR_PROCESOS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0006;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )158;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodBloque;
     sqlstm.sqhstl[0] = (unsigned long )16;
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


     if(sqlca.sqlcode != SQLOK)
        vSqlErrorNew;

     lMaxFetch = MAXFETCH;
     while(iFetchedRows == iRetrievRows)                                            
     {                                                                              
        /* EXEC SQL for :lMaxFetch                                                
                 FETCH CUR_PROCESOS INTO
                        :szhCodProceso,
                        :szhDirProceso,
                        :szhNomExe,
                        :ihOrdProceso,
                        :chIndArchivo,
                        :chTipPeriodo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )177;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodProceso;
        sqlstm.sqhstl[0] = (unsigned long )16;
        sqlstm.sqhsts[0] = (         int  )16;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhDirProceso;
        sqlstm.sqhstl[1] = (unsigned long )51;
        sqlstm.sqhsts[1] = (         int  )51;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhNomExe;
        sqlstm.sqhstl[2] = (unsigned long )31;
        sqlstm.sqhsts[2] = (         int  )31;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)ihOrdProceso;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )sizeof(int);
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)chIndArchivo;
        sqlstm.sqhstl[4] = (unsigned long )2;
        sqlstm.sqhsts[4] = (         int  )2;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)chTipPeriodo;
        sqlstm.sqhstl[5] = (unsigned long )2;
        sqlstm.sqhsts[5] = (         int  )2;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
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



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;                           
        iLastRows    = sqlca.sqlerrd[2];  
                                                
        for (i=0; i < iRetrievRows; i++)                                       
        {                                   
                paux = (stProcesos *) malloc(sizeof(stProcesos)); 
                strcpy(paux->szCodProceso  , szfnTrim(szhCodProceso[i]));
                strcpy(paux->szDirProceso  , szfnTrim(szhDirProceso[i]));
                strcpy(paux->szNomExe      , szfnTrim(szhNomExe[i]));
                paux->iOrdProceso          = ihOrdProceso[i];
                strcpy(paux->szIndArchivo  ,szfnTrim(chIndArchivo[i]));
                strcpy(paux->szTipPeriodo  ,szfnTrim(chTipPeriodo[i]));
                strcpy(paux->szEstado      ,"N");
                strcpy(paux->szIndEjecucion,"S");
                
                paux->sgte                 = qaux;
                qaux                       = paux;
                iCuentaRegs ++;   
        }
     }
    /* EXEC SQL CLOSE CUR_PROCESOS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )216;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    fprintf(stderr,"\nCantidad de procesos para:[%s] = [%d]\n",szhCodBloque,iCuentaRegs);
    return qaux;
}
/* ------------------------------------------------------------------------- */
/* MUESTRA LAESTRUCTURA DE BLOQUES Y PROCESOS EN PANTALLA                    */
/* ------------------------------------------------------------------------- */
void vMuestraBloquesProcesos()
{
	stBloques 	* paux;
	stProcesos 	* qaux;
	
	for (paux=lstBloques;paux!=NULL;paux=paux->sgte)
	{	
		fprintf(stderr,"\n---------------------------------------------\n");
		fprintf(stderr,"Cod.Bloque              :[%s]\n",paux->szCodBloque);
		fprintf(stderr,"Ind.Ejecucion           :[%c]\n",paux->cIndEjecucion);
		fprintf(stderr,"\n---------------------------------------------\n");
		
		for (qaux=paux->sgte_proceso;qaux!=NULL;qaux=qaux->sgte)
		{	
	        fprintf(stderr,"\tCod.Proceso            :[%s]\n",qaux->szCodProceso);
	        fprintf(stderr,"\tDir.Proceso            :[%s]\n",qaux->szDirProceso);
	        fprintf(stderr,"\tNom.Ejecutable         :[%s]\n",qaux->szNomExe    );
			fprintf(stderr,"\tInd.Ejecucion          :[%s]\n",qaux->szIndEjecucion);
			fprintf(stderr,"\t++++++++++++++++++++++++++++\n");
		}
	}
}
/* ------------------------------------------------------------------------- */
/* SECUENCIA DE LLENADO DE ESTRUCTURA INICIAL DE PROCESOS DE COMISIONES.     */
/* ------------------------------------------------------------------------- */
void vCargaEstructuraProcesos()
{
        stBloques * paux;
        fprintf(pfLog, "[vCargaEstructuraProcesos] Inicia carga de bloques de procesos, para su ejecucion.\n");
        fprintf(stderr, "[vCargaEstructuraProcesos] Inicia carga de bloques de procesos, para su ejecucion.\n");
        vCargaBloques();

        fprintf(pfLog, "[vCargaEstructuraProcesos] Carga procesos de comisiones, para cada uno de los bloques.\n");
        fprintf(stderr, "[vCargaEstructuraProcesos] Carga procesos de comisiones, para cada uno de los bloques.\n");
        for (paux=lstBloques;paux!=NULL;paux=paux->sgte)
                paux->sgte_proceso = stCargaProcesos(paux->szCodBloque);
}
/* ------------------------------------------------------------------------- */
/* RETORNA EL SYSDATE EN FORMATO EXTENSO, PARA VALIDACION DE PROCESOS.       */
/* ------------------------------------------------------------------------- */
char * szFnGetSysDate()
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

             char    szhSysDate[30];
        /* EXEC SQL END DECLARE SECTION; */ 

        
        /* EXEC SQL SELECT TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS')
        INTO :szhSysDate
        FROM DUAL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select TO_CHAR(SYSDATE,'DD-MON-YYYY HH24:MI:SS') into\
 :b0  from DUAL ";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )231;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhSysDate;
        sqlstm.sqhstl[0] = (unsigned long )30;
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



        return szhSysDate;
}
/* ------------------------------------------------------------------------- */
/* Funcion que RETORNA el estado de ejecucion de un BLOQUE....               */
/* ------------------------------------------------------------------------- */
char  cFndBloque(char * pszCodBloque, char * pszIdCiclComis)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

             char    szhCodBloque[16];
             char    szhIdCiclComis[11];
             char    estError;
             char    vEstado;
        /* EXEC SQL END DECLARE SECTION; */ 


        estError = 'X';
        strcpy(szhCodBloque,pszCodBloque);
        strcpy(szhIdCiclComis,pszIdCiclComis);
        
        /* EXEC SQL SELECT IND_ESTADO
        INTO :vEstado
        FROM CMT_TRAZAS_BLOQUES
        WHERE COD_BLOQUE = :szhCodBloque
        AND ID_PERIODO = :szhIdCiclComis
        AND SEC_BLOQUE = (SELECT MAX(SEC_BLOQUE) FROM CMT_TRAZAS_BLOQUES
                                          WHERE COD_BLOQUE = :szhCodBloque
                                          AND ID_PERIODO = :szhIdCiclComis); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select IND_ESTADO into :b0  from CMT_TRAZAS_BLOQUES w\
here ((COD_BLOQUE=:b1 and ID_PERIODO=:b2) and SEC_BLOQUE=(select max(SEC_BLOQU\
E)  from CMT_TRAZAS_BLOQUES where (COD_BLOQUE=:b1 and ID_PERIODO=:b2)))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )250;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&vEstado;
        sqlstm.sqhstl[0] = (unsigned long )1;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodBloque;
        sqlstm.sqhstl[1] = (unsigned long )16;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhIdCiclComis;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodBloque;
        sqlstm.sqhstl[3] = (unsigned long )16;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhIdCiclComis;
        sqlstm.sqhstl[4] = (unsigned long )11;
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


        
        if (sqlca.sqlcode == SQLNOTFOUND)
                return estTrazaNIN;

        if ((sqlca.sqlcode != SQLOK) && (sqlca.sqlcode != SQLNOTFOUND))
                return estError;

        return vEstado;
}
/* ------------------------------------------------------------------------- */
/* Funcion que RETORNA el estado de ejecucion de un PROCESO...               */
/* ------------------------------------------------------------------------- */
char  cFndProceso(char * pszCodBloque, char * pszCodProceso, char * pszIdCiclComis)
{
      /* EXEC SQL BEGIN DECLARE SECTION; */ 

              char    szhCodBloque[16];
              char    szhCodProceso[16];              
              char    szhIdCiclComis[11];
              char    estError;
              char    vEstado;
      /* EXEC SQL END DECLARE SECTION; */ 


      estError = 'X';
      strcpy(szhCodBloque,pszCodBloque);
      strcpy(szhCodProceso,pszCodProceso);
      strcpy(szhIdCiclComis,pszIdCiclComis);
 
      /* EXEC SQL SELECT IND_ESTADO
      INTO :vEstado
      FROM CMT_TRAZAS_PROCESOS
      WHERE COD_BLOQUE = :szhCodBloque
      AND COD_PROCESO  = :szhCodProceso
      AND ID_PERIODO   = :szhIdCiclComis
      AND SEC_PROCESO  = (SELECT MAX(SEC_PROCESO)
                          FROM CMT_TRAZAS_PROCESOS
                          WHERE COD_BLOQUE = :szhCodBloque
                          AND COD_PROCESO  = :szhCodProceso
                          AND ID_PERIODO = :szhIdCiclComis); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 7;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select IND_ESTADO into :b0  from CMT_TRAZAS_PROCESOS wh\
ere (((COD_BLOQUE=:b1 and COD_PROCESO=:b2) and ID_PERIODO=:b3) and SEC_PROCESO\
=(select max(SEC_PROCESO)  from CMT_TRAZAS_PROCESOS where ((COD_BLOQUE=:b1 and\
 COD_PROCESO=:b2) and ID_PERIODO=:b3)))";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )285;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&vEstado;
      sqlstm.sqhstl[0] = (unsigned long )1;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodBloque;
      sqlstm.sqhstl[1] = (unsigned long )16;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhCodProceso;
      sqlstm.sqhstl[2] = (unsigned long )16;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhIdCiclComis;
      sqlstm.sqhstl[3] = (unsigned long )11;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhCodBloque;
      sqlstm.sqhstl[4] = (unsigned long )16;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhCodProceso;
      sqlstm.sqhstl[5] = (unsigned long )16;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhIdCiclComis;
      sqlstm.sqhstl[6] = (unsigned long )11;
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


 
        if (sqlca.sqlcode == SQLNOTFOUND)
                return estTrazaNIN;

        if ((sqlca.sqlcode != SQLOK)&&(sqlca.sqlcode!=SQLNOTFOUND))
                return estError;

        return vEstado;
}
/* ------------------------------------------------------------------------- */
/* ACTUALIZA LA LISTA DE EJECUCION EN FUNCION DE PROCESOS YA EJECUTADOS      */
/* Y LINEA DE PROCESO DE REVERSA CON INDICADOR DE SELECCION....              */
/* ------------------------------------------------------------------------- */
int iActualizaEstadosEjecucion()
{
        stBloques       * paux;
        stProcesos      * qaux;

        char    cEstBloque;
        char    cEstProceso;
        int     bEjecutaBloque;
        char    szIndSeleccion;
        char    szCodLineaProc[3];

        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szIdCiclComis[11];              
        /* EXEC SQL END DECLARE SECTION; */ 

        
        strcpy(szIdCiclComis, stCiclo.szIdCiclComis);
        
        bEjecutaBloque = TRUE;
        strcpy(szCodLineaProc, stArgsNew.szCodLineaProc);

        /* Primero,  encontramos el punto de retoma...                         */
        /* Para la primera ejecución, el punto de retoma el el primer proceso. */

        for (paux = lstBloques; paux!=NULL; paux=paux->sgte)
        {
                cEstBloque = cFndBloque(paux->szCodBloque,stCiclo.szIdCiclComis);
                
                switch(cEstBloque)
                {
                        case estTrazaNIN:
                                        /* El BLOQUE NO ha sido ejecutado con anterioridad.... */
                                        paux->cIndEjecucion ='S';
                                        break;
                        case estTrazaTER:
                                        /* El BLOQUE YA fue ejecutado con anterioridad....(TER) */
                                        paux->cIndEjecucion ='N';
                                        break;
                        case estTrazaPRC:
                                        /* El BLOQUE se esta ejecutando....(PRC) */
                                        fprintf(pfLog, "[iActualizaEstadosEjecucion] Error, el bloque [%s] esta marcado como en proceso... \n", paux->szCodBloque);
                                        fprintf(pfLog, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                        fprintf(stderr, "[iActualizaEstadosEjecucion] Error, el bloque [%s] esta marcado como en proceso... \n", paux->szCodBloque);
                                        fprintf(stderr, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                        return FALSE;
                        case estTrazaFAL:
                                        /* determinar los procesos ya ejecutados... */
                                        
                                        
                                        
                                        for(qaux = paux->sgte_proceso;qaux != NULL; qaux = qaux->sgte)
                                        {
                                                cEstProceso = cFndProceso(paux->szCodBloque, qaux->szCodProceso, stCiclo.szIdCiclComis);
                                                switch(cEstProceso)
                                                {
                                                        case estTrazaNIN:
                                                                strcpy(qaux->szIndEjecucion ,"S");
                                                                break;
                                                        case estTrazaTER:
                                                                strcpy(qaux->szIndEjecucion ,"N");                                                              
                                                                break;
                                                        case estTrazaPRC:
                                                                /* El BLOQUE se esta ejecutando....(PRC) */
                                                                fprintf(pfLog, "[iActualizaEstadosEjecucion] Error, el proceso [%s] esta marcado como en proceso... \n",qaux->szCodProceso);
                                                                fprintf(pfLog, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                                                fprintf(stderr, "[iActualizaEstadosEjecucion] Error, el proceso [%s] esta marcado como en proceso... \n",qaux->szCodProceso);
                                                                fprintf(stderr, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                                                return FALSE;
                                                        case estTrazaFAL:
                                                                strcpy(qaux->szIndEjecucion ,"S");                                                              
                                                                break;                                                  
                                                        default:
                                                                /* El BLOQUE se esta ejecutando....(PRC) */
                                                                fprintf(pfLog, "[iActualizaEstadosEjecucion] Error, No se puede determinar estado de proceso:[%s]  \n",qaux->szCodProceso);
                                                                fprintf(pfLog, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                                                fprintf(stderr, "[iActualizaEstadosEjecucion] Error, No se puede determinar estado de proceso:[%s]\n",qaux->szCodProceso);
                                                                fprintf(stderr, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                                                return FALSE;
                                                }
                                        }
                                        bEjecutaBloque = TRUE;
                                        for(qaux = paux->sgte_proceso;qaux != NULL; qaux = qaux->sgte)
                                                bEjecutaBloque = bEjecutaBloque && (strcmp(qaux->szIndEjecucion, "N") == 0);
                                        if (bEjecutaBloque)
                                                paux->cIndEjecucion ='N';
                                        else
                                                paux->cIndEjecucion ='S';
                                        break;
                        default:
                                        /* El BLOQUE se esta ejecutando....(PRC) */
                                        fprintf(pfLog, "[iActualizaEstadosEjecucion] Error, Determinando punto de retoma de procesos... \n");
                                        fprintf(pfLog, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                        fprintf(stderr, "[iActualizaEstadosEjecucion] Error, Determinando punto de retoma de procesos...  \n");
                                        fprintf(stderr, "[iActualizaEstadosEjecucion] SE CANCELA LA EJECUCION. \n");
                                        return FALSE;
                }
        }

        /* Finalmente, desactiva el bloque de seleccion, cuando el el flag es 'N' */
        /* y la linea de proceso es RP o RM                                       */
        if (((strcmp(szCodLineaProc,"RP")==0)||(strcmp(szCodLineaProc,"RM")==0))&&(stArgsNew.szIndSeleccion=='N'))
        {
                for (paux = lstBloques;paux!=NULL;paux = paux->sgte)
                        if ((strcmp(paux->szCodBloque,"REV_SELECCION")==0 )||(strcmp(paux->szCodBloque,"REV_SEL_PARCIAL")==0 ))
                                        paux->cIndEjecucion = 'N';                                      
        }
        vMuestraBloquesProcesos();
        return TRUE;
}


/*---------------------------------------------------------------------------*/
/* FUNCION QUE REALIZA LA REVERSA DE LAS TRAZAS DE BLOQUES, DE PROCESOS Y DE */
/* TABLA DE ENLACE                                                           */
/* Incorporada por PGonzalez 19-03-2003 23:00 Hrs                            */
/*---------------------------------------------------------------------------*/
BOOL bfnReversaTrazas(char * szCodLineaProc, char * szIdPeriodo, char szIndSelec)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                char    szhCod_LineaProc[3];
                char    szhId_Periodo[11];
                char    szhInd_Seleccion;
        /* EXEC SQL END DECLARE SECTION; */ 


        /* incorporar el borrado de trazas.... f(x)             */
        /* bortra las trazas de bloques y procesos              */
        /* flag en S, no borra selección...                     */
        /* flag en N, borra todo....                            */
        /* tambien borrar las trazas del proceso de reversa...  */
        /* tambien debe actualizar la enalcehist_to...          */
        /* si flg(N), signigica que deja nom_fisico = NULL      */
        /* si flag es S, borra los registros del periodo...     */
        strcpy(szhCod_LineaProc , szCodLineaProc);
        strcpy(szhId_Periodo, szIdPeriodo);
        szhInd_Seleccion    = (char)szIndSelec;
        
        if (szhInd_Seleccion == 'S')
        {
                /* EXEC SQL DELETE CMT_TRAZAS_PROCESOS 
                        WHERE ID_PERIODO = :szhId_Periodo; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CMT_TRAZAS_PROCESOS  where ID_PE\
RIODO=:b0";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )328;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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


                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }

                
                /* EXEC SQL DELETE CMT_TRAZAS_BLOQUES  
                        WHERE ID_PERIODO = :szhId_Periodo; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CMT_TRAZAS_BLOQUES  where ID_PER\
IODO=:b0";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )347;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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

                     
                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }
                /* EXEC SQL DELETE CM_ENLACEHIST_TO 
                        WHERE ID_PERIODO = :szhId_Periodo; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CM_ENLACEHIST_TO  where ID_PERIO\
DO=:b0";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )366;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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


                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }
                
        }
        else if (szhInd_Seleccion == 'N')
        {
                fprintf(pfLog,"\t(bfnReversaTrazas) entro al ind_seleccion = N\n");
                        
                /* EXEC SQL DELETE CMT_TRAZAS_PROCESOS 
                        WHERE   ID_PERIODO = :szhId_Periodo
                        AND     COD_BLOQUE NOT LIKE 'SEL%'; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CMT_TRAZAS_PROCESOS  where (ID_P\
ERIODO=:b0 and COD_BLOQUE not like 'SEL%')";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )385;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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

     
                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }
                
                /* EXEC SQL DELETE CMT_TRAZAS_BLOQUES  
                        WHERE   ID_PERIODO = :szhId_Periodo
                        AND     COD_BLOQUE NOT LIKE 'SEL%'; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "delete  from CMT_TRAZAS_BLOQUES  where (ID_PE\
RIODO=:b0 and COD_BLOQUE not like 'SEL%')";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )404;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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

     
                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }
                                
                /* EXEC SQL UPDATE CM_ENLACEHIST_TO 
                        SET NOM_FISICO = NULL
                        WHERE ID_PERIODO = :szhId_Periodo; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update CM_ENLACEHIST_TO  set NOM_FISICO=null \
 where ID_PERIODO=:b0";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )423;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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


                if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
                {
                        return (FALSE);
                }
        
        }

        /* EXEC SQL DELETE CMT_TRAZAS_PROCESOS 
                WHERE ID_PERIODO = :szhId_Periodo
                AND COD_BLOQUE LIKE 'REV%'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_TRAZAS_PROCESOS  where (ID_PERIODO=:\
b0 and COD_BLOQUE like 'REV%')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )442;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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


        if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
        {
                return (FALSE);
        }
        
        /* EXEC SQL DELETE CMT_TRAZAS_BLOQUES  
                WHERE ID_PERIODO = :szhId_Periodo
                AND COD_BLOQUE LIKE 'REV%'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "delete  from CMT_TRAZAS_BLOQUES  where (ID_PERIODO=:b\
0 and COD_BLOQUE like 'REV%')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )461;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhId_Periodo;
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

     
        if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
        {
                return (FALSE);
        }
        
        return(TRUE);
        
}

/*---------------------------------------------------------------------------*/
/* ACTUALIZA ESTADO FINAL DEL PERIODO, DEPENDIENDO DEL RESULTADO DE LA       */
/* EJECUCION Y LA LINEA DE PROCESO EJECUTADA.                                */
/* Cod_Estado:  TER->Termino Ok del proceso.                                 */
/*                              FAL->Termino erroneo del proceso.            */
/*---------------------------------------------------------------------------*/
void vActEstadoPeriodo (char    * pszCodEstado)
{
        char    szCodLineaProc[3];
        int     iRes;
        strcpy(szCodLineaProc, stArgsNew.szCodLineaProc);
        
        /* Linea de proceso de cierre... */
        if ((strcmp(szCodLineaProc,"CM")==0)||(strcmp(szCodLineaProc,"CP")==0))
                if (strcmp(pszCodEstado,estTerminado)==0)
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estCerrado);
                else
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estTerminado);
                
        /* Linea de proceso de Reversa... */
        if ((strcmp(szCodLineaProc,"RM")==0)||(strcmp(szCodLineaProc,"RP")==0))
                if (strcmp(pszCodEstado,estTerminado)==0)
                {
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estInicial);
                        
                        if (!bfnReversaTrazas(szCodLineaProc, stArgsNew.szIdPeriodo, stArgsNew.szIndSeleccion )) /* Incorporado por PGonzaleg 19-03-2003 22:30 hrs. */
                        {
                                fprintf(pfLog,"(vActEstadoPeriodo) Error Reversando Trazas para el periodo.\n");
                                vSqlErrorNew();
                        }
                }       
                else
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estTerminado);

        /* Linea de proceso de Normal... */
        if ((strcmp(szCodLineaProc,"PM")==0)||(strcmp(szCodLineaProc,"PP")==0))
                if (strcmp(pszCodEstado,estTerminado)==0)
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estTerminado);
                else
                        iRes = iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estTermError);

}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE CREA REGISTRO DE TRAZA DE BLOQUES, PARA BLOQUE RECIBIDO.      */
/* RETORNA SECUENCIA DE BLOQUE CREADO, O 0(CERO) SI HAY ERROR.               */ 
/*---------------------------------------------------------------------------*/
long lCreaTrazaBloque(char * pszBloque)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                long    lhSecBloque;
                char    szhCodBloque[16];
                char    szhIdPeriodo[11];
                long    lhCodPeriodo;
                char    chIndEstado;                
        /* EXEC SQL END DECLARE SECTION; */ 

        
        lhSecBloque=lDBGetSequenceNextVal();
        
        fprintf (stderr, "lCreaTrazaBloque-lhSecBloque  [%ld]\n", lhSecBloque);
        
        strcpy(szhCodBloque,pszBloque);
        strcpy(szhIdPeriodo,stCiclo.szIdCiclComis);
        lhCodPeriodo = stCiclo.lCodCiclComis;
        chIndEstado  = estTrazaPRC;
        /* EXEC SQL INSERT INTO CMT_TRAZAS_BLOQUES(
                SEC_BLOQUE, 
                COD_BLOQUE, 
                ID_PERIODO, 
                COD_PERIODO, 
                IND_ESTADO, 
                FEC_INICIO, 
                FEC_TERMINO, 
                NOM_USUARIO) VALUES (
                :lhSecBloque,
                :szhCodBloque,
                :szhIdPeriodo,
                :lhCodPeriodo,
                :chIndEstado,
                SYSDATE,
                NULL,
                USER); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "insert into CMT_TRAZAS_BLOQUES (SEC_BLOQUE,COD_BLOQUE\
,ID_PERIODO,COD_PERIODO,IND_ESTADO,FEC_INICIO,FEC_TERMINO,NOM_USUARIO) values \
(:b0,:b1,:b2,:b3,:b4,SYSDATE,null ,USER)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )480;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhSecBloque;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodBloque;
        sqlstm.sqhstl[1] = (unsigned long )16;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhIdPeriodo;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodPeriodo;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&chIndEstado;
        sqlstm.sqhstl[4] = (unsigned long )1;
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


                               
        fprintf (stderr, "sqlca.sqlcode [%ld]\n", sqlca.sqlcode);
                        
        if (sqlca.sqlcode != SQLOK)
                return 0;
        
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )515;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        
        return lhSecBloque;
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE ACTUALIZA EL ESTADO DE LAS TRAZAS DE BLOQUES.                 */
/*---------------------------------------------------------------------------*/
void vActTrazaBloque(long lSecBloque, char cEstTraza)
{
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

                long    lhSecBloque;
                char    chEstTraza;
        /* EXEC SQL END DECLARE SECTION; */ 

        
        lhSecBloque     = lSecBloque;
        chEstTraza      = cEstTraza;
        fprintf(pfLog, "\n(vActTrazaBloque) Actualizacion Traza de Bloque:[%ld] a Estado:[%c]",lSecBloque,cEstTraza);
        /* EXEC SQL UPDATE CMT_TRAZAS_BLOQUES
                SET IND_ESTADO = :chEstTraza
                WHERE SEC_BLOQUE = :lhSecBloque; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CMT_TRAZAS_BLOQUES  set IND_ESTADO=:b0 where S\
EC_BLOQUE=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )530;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&chEstTraza;
        sqlstm.sqhstl[0] = (unsigned long )1;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhSecBloque;
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


        
        if (sqlca.sqlcode != SQLOK)
        {
                fprintf(pfLog, "\n(vActTrazaBloque)ERROR ACTUALIZANDO ESTADO DE TRAZAS DE BLOQUES.SEQ:[%ld] EST:[%c]\n", lhSecBloque, chEstTraza);
                fprintf(stderr,"\n(vActTrazaBloque)ERROR ACTUALIZANDO ESTADO DE TRAZAS DE BLOQUES.SEQ:[%ld] EST:[%c]\n", lhSecBloque, chEstTraza);
                vSqlErrorNew();         
        }
        fprintf(pfLog, "===> Termina Satisfactoriamente.\n");
        /* EXEC SQL COMMIT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )553;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        
}
/*---------------------------------------------------------------------------*/
/* LANZA Y GESTIONA LA EJECUCION DE UN PROCESO DE COMISIONES....             */
/*---------------------------------------------------------------------------*/
int bLanzaProceso(long  lSecTrazaBloque,char * szCodBloque,stProcesos * qaux)
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
                strcpy(szUser, szhUser);
        /* construye el comando a ejecutar... */
        sprintf(szComandoUx, "%s/%s -u'%s/%s' -p%s -s%ld -b%s -c%s&",
                qaux->szDirProceso, 
                qaux->szNomExe,
                szUser,
                stArgsNew.szPass,
                stCiclo.szIdCiclComis,                
                lSecTrazaBloque,
                szCodBloque,
                qaux->szCodProceso);
                
        strcpy(szSysDate,(char *)szFnGetSysDate());
        /* Registra ejecucion en el LOG */
        fprintf(pfLog, "\n\n(bLanzaProceso)Prepando proceso a ejecutar: \n");
        fprintf(pfLog, "\t(bLanzaProceso) <%s> \n",szComandoUx);
        fprintf(stderr,"\n\n(bLanzaProceso)Prepando proceso a ejecutar: \n");   
        fprintf(stderr,"\t(bLanzaProceso) <%s> \n",szComandoUx);        

        /* Ejecuta el comando ... */
        iRes=system(szComandoUx);
        i = 0;
        do 
        {
                sleep(5);
                lhSecProceso = lValidaInicioProceso(lSecTrazaBloque, qaux->szCodProceso, szSysDate);
                i++;
        }while (!(lhSecProceso > 0 || (i>7) ));
        if (i>=7) 
                return FALSE;
        /* El proceso partió Ok, ahora esperamos a que termine... */
        i = 0;
        do
        {
                cEstProceso = cGetEstadoProceso(lSecTrazaBloque, lhSecProceso);
                switch  (cEstProceso)
                {
                        case estTrazaFAL:
                                /* El proceso se cayo... salir con false... */
                                fprintf(pfLog, "\n\n(bLanzaProceso)Error Ejecutando proceso [%s]. Revise el Log.\n",qaux->szCodProceso);
                                fprintf(stderr, "\n\n(bLanzaProceso)Error Ejecutando proceso [%s]. Revise el Log.\n",qaux->szCodProceso);
                                bSaleLoop = TRUE;
                                break;
                        case estTrazaPRC:
                                /* El proceso se esta ejecutando... */
                                sleep(10);
                                i++;
                                break;
                        case estTrazaTER:
                                /* El proceso termino Ok... */
                                fprintf(pfLog, "\n\n(bLanzaProceso)Proceso [%s] Termina sin errores.\n",qaux->szCodProceso);
                                fprintf(stderr, "\n\n(bLanzaProceso)Proceso [%s] Termina sin errores.\n",qaux->szCodProceso);
                                bSaleLoop = TRUE;
                                break;
                        default:
                                fprintf(pfLog, "\n\n(bLanzaProceso)Error determinando estado de ejecucion de Proceso [%s].\n",qaux->szCodProceso);
                                fprintf(stderr, "\n\n(bLanzaProceso)Error determinando estado de ejecucion de Proceso [%s].\n",qaux->szCodProceso);
                                bSaleLoop = TRUE;
                                break;
                }
        }while (!bSaleLoop);
        if (cEstProceso!=estTrazaTER)
                return FALSE;
        
        strcpy(qaux->szIndEjecucion, "N");
        return TRUE;
}
/*---------------------------------------------------------------------------*/
/* PROCESO QUE MARCA EL CICLO COMO CERRADO                                   */
/*---------------------------------------------------------------------------*/
void vCierraCiclComis()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIdCiclComis[11];
	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy(szhIdCiclComis, stCiclo.szIdCiclComis);
	              
    /* EXEC SQL UPDATE CM_CICLCOMIS_TD
        SET     COD_ESTADO = 'CER'
        WHERE   ID_CICLCOMIS   = :szhIdCiclComis; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CM_CICLCOMIS_TD  set COD_ESTADO='CER' where ID_CIC\
LCOMIS=:b0";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )568;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIdCiclComis;
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


}
/*---------------------------------------------------------------------------*/
/* EJECUTA LOS PROCESOS CARGADOS EN LA ESTRUCTURA DE PROCESOS.               */
/*---------------------------------------------------------------------------*/
int bEjecutaProcesosCorrelacion()
{
        stBloques * paux;
        stProcesos      * qaux;
        long    lSecTrazaBloque;

        char    szCodLineaProc[3];
        strcpy(szCodLineaProc, stArgsNew.szCodLineaProc);

        for(paux = lstBloques; paux!= NULL; paux = paux->sgte)
        {
                if (paux->cIndEjecucion =='S')
                {
                        /* abre traza de bloques... */
                        lSecTrazaBloque = lCreaTrazaBloque(paux->szCodBloque);
                        
                        if (lSecTrazaBloque == 0)
                                return FALSE;
                        
                        
                        for(qaux = paux->sgte_proceso; qaux != NULL ; qaux = qaux->sgte)
                        {
                                if(strcmp(qaux->szIndEjecucion,"S") == 0)
                                {                                       
                                        if(!bLanzaProceso(lSecTrazaBloque,paux->szCodBloque,qaux))
                                        {
                                                vActTrazaBloque(lSecTrazaBloque,estTrazaFAL);
                                                return FALSE;
                                        }
                                }
                        }

                        /* cierra traza de bloques */
                        vActTrazaBloque(lSecTrazaBloque,estTrazaTER);
                        if ((strcmp(szCodLineaProc,"CM")==0)||(strcmp(szCodLineaProc,"CP")==0))
    					{
    						fprintf(pfLog , "\n[bEjecutaProcesosCorrelacion] Se Cierra Ciclo de Comisiones:[%s]\n", stCiclo.szIdCiclComis);
    						fprintf(stderr, "\n[bEjecutaProcesosCorrelacion] Se Cierra Ciclo de Comisiones:[%s]\n", stCiclo.szIdCiclComis);
    						vCierraCiclComis();
    					}
                }
        }
        return TRUE;
}
/*---------------------------------------------------------------------------*/
/* EJECUTA LA CORRELACION DE LOS PROCESOS DE COMISIONES....                  */
/*---------------------------------------------------------------------------*/
void vEjecutaCorrelacion()
{
    if (!iMarcaEstadoPeriodo(stArgsNew.szIdPeriodo,estEnProceso))
    {   
        fprintf(pfLog, "\n[vEjecutaCorrelacion] Error marcando nuevo estado de procesos.\n");    
        fprintf(stderr, "\n[vEjecutaCorrelacion] Error marcando nuevo estado de procesos.\n");    
        exit(EXIT_100);
    }   
    vCargaEstructuraProcesos();
    if (!iActualizaEstadosEjecucion())
    {   
        fprintf(pfLog, "\n[vEjecutaCorrelacion] Error actualizando estados de Procesos.\n");    
        fprintf(stderr, "\n[vEjecutaCorrelacion] Error actualizando estados de Procesos.\n");    
        vActEstadoPeriodo(estTermError);
        exit(EXIT_100);
    }   
    if (bEjecutaProcesosCorrelacion())
    {
        fprintf(pfLog, "\n===================================\n");
        fprintf(pfLog, "\nProceso de Comisiones terminado OK.\n");
        fprintf(pfLog, "\n===================================\n");
        fprintf(stderr, "\n===================================\n");
        fprintf(stderr, "\nProceso de Comisiones terminado OK.\n");
        fprintf(stderr, "\n===================================\n");
        vActEstadoPeriodo(estTerminado);
        
    }
    else
    {
        fprintf(pfLog, "\n========================================================================\n");
        fprintf(pfLog, "\nProceso de Comisiones Terminado con error. Revise las TRAZAS.\n");
        fprintf(pfLog, "\n========================================================================\n");

        fprintf(stderr, "\n========================================================================\n");
        fprintf(stderr, "\nProceso de Comisiones Terminado con error. Revise las TRAZAS.\n");
        fprintf(stderr, "\n========================================================================\n");
        vActEstadoPeriodo(estTermError);
    }
}
/*---------------------------------------------------------------------------*/
/* Rutina principal.                */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
	
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
    memset(&stCiclo, 0, sizeof(reg_ciclo));
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
    fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)                                                      
    {                                                                                                                         
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));     
    }                                                                                                                         
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);                                          
/*---------------------------------------------------------------------------------------------*/
/* Ingresa parametros para estructura que crea archivo de Log                                  */
/*---------------------------------------------------------------------------------------------*/
    strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
    strncpy(szhSysDate, pszGetDateLog(),16);
    strcpy(stArgsLog.szProceso,LOG_NAME);
    strncpy(stArgsLog.szSysDate,szhSysDate,16);
    sprintf(stArgsLog.szPath,"%s%s/%s", pszEnvLog, stArgsLog.szProceso, szFechaYYYYMMDD);
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)
    {
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);
        fprintf(stderr, "Revise su existencia.\n"); 
        fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
        fprintf(stderr, "Proceso finalizado con error.\n");
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE LOG NO PUDO SER ABIERTO.",0,0));
    }
	fprintf(stderr, "\n[main] Fecha para directorio de LOG...[%s]\n", szFechaYYYYMMDD);
/*---------------------------------------------------------------------------*/
/* HEADER.                                                                   */
/*---------------------------------------------------------------------------*/ 
    vFechaHora();
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION             : [%s]\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision     : [%s]\n", LAST_REVIEW);
	fprintf(pfLog, "Base de datos       : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE      : [%s]\n",(char * )sysGetUserName()); 
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n[Comisiones] Argumentos de Ejecucion\n");
    fprintf(pfLog, "[Comisiones]   Linea de Proceso       	<%s>\n", stArgsNew.szCodLineaProc);
    fprintf(pfLog, "[Comisiones]   Ciclo de Comisiones    	<%d>\n", stArgsNew.lCodPeriodo);
    fprintf(pfLog, "[Comisiones]   IDentificador de Ciclo 	<%s>\n", stArgsNew.szIdPeriodo);
    fprintf(pfLog, "[Comisiones]   Reprocesa Seleccion ?  	<%c>", stArgsNew.szIndSeleccion);
    fprintf(pfLog, "  (considerado para lineas de reproceso).\n");
/*---------------------------------------------------------------------------*/
/* MODIFICACION DE CONFIGURACION AMBIENTAL, PARA MANEJO DE FECHAS EN ORACLE. */
/*---------------------------------------------------------------------------*/
        /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )587;
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
/* CARGA PARAMETROS DE DECIMALES..                                           */
/*---------------------------------------------------------------------------*/
        fprintf(pfLog, "Carga parametros de decimales.\n");     
        if (!bGetParamDecimales ()) /* RUTINA PARA OBTENCION DE PARAMETROS DE DECIMALES */
        {
                fprintf(stderr, "\nError, al obtener parametros de Decimales ");
                exit(EXIT_110);
        }
        fprintf(pfLog, "\nParametro Decimales 1 [%d]", pstParamGener.iNumDecimal);
        fprintf(pfLog, "\nParametro Decimales 1 [%s]", pstParamGener.szSepMilesMonto);
        fprintf(stderr, "\nParametro Decimales 1 [%d]", pstParamGener.iNumDecimal);
        fprintf(stderr, "\nParametro Decimales 1 [%s]", pstParamGener.szSepMilesMonto);

/*---------------------------------------------------------------------------------------------*/
/*    - Recupera fechas que conforman periodo del parametro.                                   */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Carga fechas que definen el periodo actual...\n\n");
    fprintf(stderr, "Carga fechas que definen el periodo actual...\n\n");

    fprintf(stderr, "szIdPeriodo...[%s]\n\n", stArgsNew.szIdPeriodo);

    if (!vCargaCiclo(stArgsNew.szIdPeriodo,&stCiclo))
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	exit(EXIT_101);
    }
/*---------------------------------------------------------------------------*/
/* VALIDA ESTADOS DE PERIODOS PARA LA EJECUCION DEL PROCESO...               */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "[Comisiones]Valida los estados del ciclo actual y del ciclo anterior...\n\n");     
    fprintf(pfLog, "[Comisiones]Valida los estados del ciclo actual y del ciclo anterior...\n\n");     
    if (!bValidaPeriodos())
    {
        vFechaHora();                                                                                   
        fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
        fprintf(pfLog, "[Comisiones]Estado de ciclos no permite la ejecucion solicitada.\n\n");                     
        fprintf(stderr, "[Comisiones]Estado de ciclos no permite la ejecucion solicitada.\n\n");
        exit(EXIT_01);
    }
/*---------------------------------------------------------------------------*/
/* EJECUTA LA CORRELACION DE PROCESOS DE COMISIONES                          */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                                                   
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());                      
    fprintf(pfLog, "[Comisiones]Ejecuta la correlacion de procesos de Comisiones.\n\n");     
    fprintf(pfLog, "[Comisiones]Ejecuta la correlacion de procesos de Comisiones.\n\n");     
	vEjecutaCorrelacion();
/*---------------------------------------------------------------------------*/

    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )602;
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

