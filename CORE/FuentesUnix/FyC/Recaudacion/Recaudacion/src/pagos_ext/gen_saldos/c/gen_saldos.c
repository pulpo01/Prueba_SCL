
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
    "./pc/gen_saldos.pc"
};


static unsigned int sqlctx = 13813283;


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
   unsigned char  *sqhstv[11];
   unsigned long  sqhstl[11];
            int   sqhsts[11];
            short *sqindv[11];
            int   sqinds[11];
   unsigned long  sqharm[11];
   unsigned long  *sqharc[11];
   unsigned short  sqadto[11];
   unsigned short  sqtdso[11];
} sqlstm = {12,11};

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

 static char *sq0004 = 
"select NVL(sum((IMPORTE_DEBE-IMPORTE_HABER)),:b0) ,COD_CLIENTE  from CO_CART\
ERA where ((((FEC_VENCIMIE<(SYSDATE-:b1) and COD_PRODUCTO=:b1) and IND_FACTURA\
DO=:b1) and COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from CO_CODIGOS\
 where (NOM_TABLA=:b4 and NOM_COLUMNA=:b5))) and ROWNUM<1001) group by COD_CLI\
ENTE           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,176,0,6,195,0,0,6,6,0,1,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,5,0,0,1,
97,0,0,
44,0,0,2,60,0,6,286,0,0,2,2,0,1,0,2,97,0,0,1,97,0,0,
67,0,0,3,78,0,6,380,0,0,2,2,0,1,0,2,3,0,0,1,97,0,0,
90,0,0,4,325,0,9,519,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
97,0,0,
129,0,0,4,0,0,13,528,0,0,2,0,0,1,0,2,4,0,0,2,3,0,0,
152,0,0,4,0,0,15,606,0,0,0,0,0,1,0,
167,0,0,5,605,0,4,636,0,0,11,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,2,3,0,0,2,3,0,0,2,
4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
226,0,0,6,419,0,4,694,0,0,9,7,0,1,0,1,97,0,0,1,3,0,0,2,5,0,0,2,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
277,0,0,7,357,0,4,748,0,0,10,6,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
332,0,0,8,111,0,6,771,0,0,4,4,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/*=============================================================================
   Nombre         : gen_saldos.pc
   Programa       : Generacion de Archivo de saldos de la cartera de clientes
   Autor          : G.A.C.
   Fecha Creacion : 09 - Mayo - 2005
   Proyecto       : Ecuador
==============================================================================*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pasoc.h>
#include <unistd.h>
#include "gen_saldos.h"

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

	int   ihDecimal            ;
	char  szHoraIni        [11]; /* EXEC SQL VAR szHoraIni IS STRING(11); */ 

	char  szhhhmiss        [11];
   char  szFechayyyymmdd  [9] ; /* EXEC SQL VAR szFechayyyymmdd IS STRING(9); */ 

   char  szhYYYYMMDD      [9] ;
   char  szhHH24miss      [11];
   char  szFechaddmmyyyy  [11]; /* EXEC SQL VAR szFechaddmmyyyy IS STRING(11); */ 

	char  szhDDMMYYYY      [11];
/* EXEC SQL END DECLARE SECTION; */ 

int   iDiffSeg = 0;
char  szHoraFin[9];
char  szTmpProc[9];
long  lTotalReg;
char  szFileDat  [128]   ="" ;

Lista_Pasoc pLista_Aux=NULL;
Lista_Pasoc stListaAux=NULL;

char szUsage[] = "\n\tUso : gen_saldos  -u [Usuario]/[Password]\n"
                 "\t                  -l [Nivel de log. Por default es 3]\n\n";
 
int main( int argc, char* argv[] )
{
char modulo[]="main";
	
   memset (&stConfig,0,sizeof (CONFIGLOCAL));
	memset( szHoraIni, '\0', sizeof( szHoraIni ) );

   if (argc < 2) {
   	fprintf (stdout,"\n\tFaltan parametros.\n%s",szUsage);
      fflush  (stdout);
      exit(1);
   }

   /*- Validacion de parametros de entrada -*/
   memset(&stConfig,0,sizeof(CONFIGLOCAL));
   if (ifnValidaParametros(argc,argv,&stConfig) != 0)  {
        fprintf (stdout,"\n\tError >> Fallo en la Validacion de Parametros \n");
        fflush  (stdout);

   } else {

		if (ifnInicio(stConfig) != 0 ) {
		    fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
		    fflush  (stdout);
		}
		else
		{
			fprintf (stdout,"\t Generando Saldos.... \n");
			if (ifnSaldos() != 0) {
		   	vDTrazasLog( modulo, "\tProceso de Generacion de Saldos Finalizado con ERROR.\n\n", LOG03,modulo);
		   	fprintf (stdout,"\n\tError >> Fallo Funcion Principal \n");
		   	fflush  (stdout);
			}
		}

		if( ifnExitSaldos() != 0 ) {
			fprintf (stdout,"\n\tError >> Fallo Funcion de estadistica \n");
			fflush  (stdout);
		}
	

	}
	fprintf(stderr, "\t< FIN DEL PROCESO: GENERACION DE SALDOS DE CLIENTES SCL >\n\n");
	return 0;

}/* Fin main */


/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], CONFIGLOCAL *pstLC )
{
char modulo[]="ifnValidaParametros";
/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
extern char  *optarg;
extern int  optind, opterr, optopt;
int    iOpt=0;
char   opt[] = ":u:l:";

char szUsuario[61] = "";
char *pszTmp       = "";

/*-- Flags de los valores recibidos ----------------------------------------------*/
int  Userflag=0;
int  Logflag=0;

/*-- Seteo de Valores Iniciales y por defecto -------------------------------------*/
    opterr=0;

    while ( (iOpt = getopt (argc,argv,opt)) != EOF)
    {
          switch (iOpt)
             {
                 case 'u':
                   if ( strlen (optarg) )
                   {
                        strcpy (szUsuario,optarg)  ;
                        stConfig.bOptUsuario = TRUE; 
                   }
                   break;
                 case 'l':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptNivelLog = TRUE;
                        stConfig.iNivelLog    = atoi(optarg);
                   }
                   break;   

             }/* fin switch */
    }/* fin While de Opciones */
    if (!stConfig.bOptUsuario)
    {
         fprintf(stderr,"\n\tError Falta Usuario en Parametros de Entrada: \n%s\n", szUsage);
         return -1;
    }
    else
    {
       if ( (pszTmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tFormato Usuario Oracle Incorrecto:\n%s\n", szUsage);
             return -1;
       }
       else
       {
          strncpy (stConfig.szUsuario ,szUsuario,pszTmp-szUsuario);
          strcpy  (stConfig.szPassWord, pszTmp+1);
       }
    }


    if( !stConfig.bOptNivelLog )
         stConfig.iNivelLog = iNIVEL_DEF;

    stStatus.LogNivel = stConfig.iNivelLog;
    
    return 0;

} /* ifnValidaParametros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB( CONFIGLOCAL pstLC)
{
char modulo[]="ifnConexionDB";

   if( !bfnConnectORA( pstLC.szUsuario, pstLC.szPassWord ) )   {
       fprintf (stderr,"\nNo hay conexion a ORACLE \n");
       fflush  (stderr);
       return -1;
    }

    return 0;
}
/* ============================================================================= */

/* ============================================================================= */
/* Funcion : ifnInicio										                     */
/* ============================================================================= */
int ifnInicio (CONFIGLOCAL pstConfig)
{
char modulo[]="ifnInicio";

	if (ifnConexionDB(pstConfig) != 0)   {
		fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
      fflush  (stdout);
      return -1;
	}

	strcpy(szhYYYYMMDD,"YYYYMMDD");
	strcpy(szhHH24miss,"hh24:mi:ss");
	strcpy(szhDDMMYYYY,"DD-MM-YYYY");

	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraIni := TO_CHAR(SYSDATE,:szhHH24miss);
        	:szFechayyyymmdd := TO_CHAR(SYSDATE,:szhYYYYMMDD);
			:szFechaddmmyyyy := TO_CHAR(SYSDATE,:szhDDMMYYYY);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szHoraIni := TO_CHAR ( SYSDATE , :szhHH24miss ) ; :sz\
Fechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMDD ) ; :szFechaddmmyyyy := TO_C\
HAR ( SYSDATE , :szhDDMMYYYY ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szHoraIni;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhHH24miss;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szFechayyyymmdd;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDD;
 sqlstm.sqhstl[3] = (unsigned long )9;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szFechaddmmyyyy;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhDDMMYYYY;
 sqlstm.sqhstl[5] = (unsigned long )11;
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



	/*-----------------------------------------------------------------------*/
  	/* Inicializacion de Archivos LOG										 */
	/*-----------------------------------------------------------------------*/
  	if (ifnAbreArchivosLog(0)!=0) return -1;
  	

	vDTrazasLog( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  Generacion de Saldos de Clientes       Hora : %s      "
						  "\n\t***************************************************************\n",LOG03,szhVersion,szHoraIni);	
	vDTrazasError( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  Errores en Generacion de Saldos        Hora : %s      "
						  "\n\t***************************************************************\n",LOG03,szhVersion,szHoraIni);	


	return 0;
}/* fin a ifnInicio */

/*===========================================================================*/
/* Funcion que abre los archivos de log y de error                           */
/*===========================================================================*/
int ifnAbreArchivosLog(int iTipfile)
{
char modulo[]="ifnAbreArchivosLog";
char *pathDir               ;
char szComando  [128]   ="" ;
char szPathLog  [128]   ="" ;
char szFileBanco[60] = "";
   /*-----------------------------------------------------------------------*/
   /* Inicializacion de estructura	de archivo								*/
   /*-----------------------------------------------------------------------*/
	memset(szArchivo,'\0',sizeof(szArchivo));

	sprintf(szArchivo,"gen_saldos");
	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

	if (iTipfile == 0) {
		sprintf(szPathLog  ,"%s/LOG/Recaudacion/Gen_saldos/%s",pathDir,szFechayyyymmdd);
		free(pathDir);
		sprintf(szComando,"/usr/bin/mkdir -p %s", szPathLog);
		system (szComando);
	
		sprintf(stStatus.ErrName,"%s/%s.err",szPathLog,szArchivo);
		if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL ){
		    fprintf( stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		    return -1;
		}
	
		sprintf(stStatus.LogName,"%s/%s.log",szPathLog,szArchivo);
		if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) {
		    fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
	    	return -1;
	   }
    
	} else {
		sprintf( szFileBanco, "Saldo_clientes_%s.dat",szFechayyyymmdd);
		sprintf(szPathDat  ,"%s/DAT/Recaudacion/%s",pathDir,szFechayyyymmdd);
		free(pathDir);
		sprintf(szComando,"/usr/bin/mkdir -p %s", szPathDat);
		system (szComando);
	
		sprintf(szFileDat,"%s/%s\0",szPathDat,szFileBanco);
		fprintf( stderr, "\nArchivo de Saldos : %s\n\n\n", szFileDat);
		if( ( FichBancos = fopen( szFileDat,"a" ) ) == (FILE*)NULL )  {
		    vDTrazasError(modulo, "\t\t### Error: No puede abrirse el archivo de saldos\n\n\t [%s]\n", LOG01, szFilePac );
			return -1;
		}
	}
	
   return 0;
}/* ifnAbreArchivosLog */


/* ============================================================================= */
/* Funcion ifnExitSaldos: finaliza proceso    				                     */
/* ============================================================================= */
int ifnExitSaldos (void)
{
char modulo[]="ifnExitSaldos";

	strcpy(szhhhmiss,"HH24:MI:SS");

	/* Datos Fin de Tiempo */
	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraFin := TO_CHAR(SYSDATE,:szhhhmiss);
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szHoraFin := TO_CHAR ( SYSDATE , :szhhhmiss ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )44;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szHoraFin;
 sqlstm.sqhstl[0] = (unsigned long )9;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhhhmiss;
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



	iDiffSeg = ifnRestaHoras(szHoraIni,szHoraFin,szTmpProc);

   vDTrazasLog(modulo,"\n\t         HORA INICIO  : %s "
                       "\n\t         HORA TERMINO : %s "
                       "\n\t         TIEMPO TOTAL : %s  (%d segs)"
                       "\n\t REGISTROS PROCESADOS : %ld"
                       "\n\t PROMEDIO  x  REGISTRO: %.5f segs "
                       "\n\n",LOG03,szHoraIni,szHoraFin,szTmpProc,iDiffSeg,lTotalReg,(float)((float)iDiffSeg/(float)lTotalReg) );

	vDTrazasLog( modulo, "\tFin del Proceso de Generacion de Saldos.\n\n", LOG03,modulo);
	
	if ( fclose(stStatus.LogFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Log\n");
	    fflush  (stderr);
	}

	if ( fclose(stStatus.ErrFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Errores\n");
	    fflush  (stderr);
	}

	return 0;
}/* fin a ifnExitSaldos */


/* ============================================================================= */
/* ============================================================================= */
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaPasoc(Lista_Pasoc *ant)
{
	Lista_Pasoc p;
	if ((p=(struct SALDOS *) malloc(sizeof(struct SALDOS))) == NULL)
		return -1;
	p->sig=*ant;
	*ant=p;
	return 0;
}

/* Destruye la lista totalmente, liberando toda la memoria. */
/* Tras esto ES necesario Inicializar la lista para reusarla. */
void vfnBorraListaPasoc(Lista_Pasoc *list)
{
	Lista_Pasoc L = NULL;
	if ((*list) != NULL)
	  L = (*list)->sig;

	while (L != NULL){
	   ifnBorraPasoc(&L);
	}
	free((*list)); /* Liberar la cabecera */
	(*list)=NULL;
}

/* Borra el elemento en la posición pos de la lista ant. */
int ifnBorraPasoc(Lista_Pasoc *ant)
{
	Lista_Pasoc aux ;
	if ((*ant) == NULL)
	   return -1; /* Lista Vacia */
	else{
		/* Borrar elemento apuntado por aux, teniendo un puntero al siguiente */
		aux = (*ant);
		(*ant)=aux->sig;
		free(aux);
		return 0;
	} /* end if */
}
/* ============================================================================= */
/* ============================================================================= */

/* ============================================================================= */
/* Funcion principal que ejecuta llamadas a distintas funciones de seleccion     */
/* ============================================================================= */
int ifnSaldos()
{
char modulo[]="ifnSaldos";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente     ;

	char   szhNum_decimal  [12];
	int    ihValor_cero    = 0 ;
	int    ihValor_uno     = 1 ;
/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	strcpy(szhNum_decimal,"num_decimal");

	/* EXEC SQL EXECUTE
		BEGIN
			:ihDecimal := GE_PAC_GENERAL.PARAM_GENERAL( :szhNum_decimal );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :ihDecimal := GE_PAC_GENERAL . PARAM_GENERAL ( :szhNum\
_decimal ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )67;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihDecimal;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhNum_decimal;
 sqlstm.sqhstl[1] = (unsigned long )12;
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



	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tGE_PAC_GENERAL.PARAM_GENERAL( 'num_decimal' ) - %s", LOG00,SQLERRM );
		return -1;
	}

	/* Genera lista de trabajo*/
	if (ifnCargaListaQuery()!=0) return -1;
	
	if (lTotalReg > 0 )
	{
		/* Abre archivo plano de saldos a generar*/
		if (ifnAbreArchivosLog(1)!=0) return -1;

		stListaAux=pLista_Aux;
     	while (stListaAux!= NULL)
	   {
			/* Va a poblar el archivo de saldos */
			if (ifnGeneraArchivo()!=0) return -1;

			stListaAux=stListaAux->sig;
		}

		vDTrazasLog( modulo, "\tArchivo de Saldos Generado con %ld registros", LOG03, lTotalReg );
		vDTrazasLog( modulo, "\tFin a funcion %s", LOG03, modulo );
		vDTrazasLog( modulo, "\tDestruyendo lista de trabajo. Liberando memoria...", LOG03);

		if (ifnOrdenaArchivo()!=0) {
			vDTrazasLog( modulo, "\tFallo el Ordenamiento del archivo", LOG03);
		}
	} else {
		vDTrazasLog( modulo, "\tNo existen registos para generar Saldos....", LOG03);

	}
	/* Destruye la lista liberando memoria */
	vfnBorraListaPasoc( &pLista_Aux );


	return 0;

}/* Fin ifnSaldos */

/*===========================================================================*/
/* Funcion ifnFormatoUnico : Imprime en archivo plano, con formato Unico     */
/*===========================================================================*/
int ifnGeneraArchivo()
{
char modulo[]="ifnGeneraArchivo";
char szFiller [2]=" ";

	if( (fprintf( FichBancos , "%3s%10s%15s%08ld%-50s%-60s%015ld%21s%11s%1s%02dUSD%09ld%15s%15s%015.04f%015.04f\n",
	             			    stListaAux->szCod_Operadora,
	             			    szFechaddmmyyyy,
	             			    stListaAux->szCod_banco,
	             			    stListaAux->lCod_cliente,
	             			    stListaAux->szNom_cliente,
	             			    stListaAux->szDirec_clie,
	             			    stListaAux->lNum_celular,
	             			    stListaAux->szNum_contrato,
	             			    szFiller,
	             			    stListaAux->szInd_pertrib,
	             			    stListaAux->iCod_tipdocum,
	             			    stListaAux->lNum_folio,
	             			    szFiller,
	             			    szFiller,
	             			    stListaAux->dTot_pagar_fa,
	             			    stListaAux->dTot_pagar_ca	  )   ) == -1 )
	{	
		vDTrazasError(modulo,"Error al Escribir en Archivo de Saldos",LOG01);
		vDTrazasLog( modulo, "Error al Escribir en Archivo de Saldos", LOG01);
		return -1; 
	}

	return 0;

}/*ifnFormatoUnico*/


/* ============================================================================= */
/* Genera listas enlazadas con clientes rechazados                               */
/* ============================================================================= */
int ifnCargaListaQuery() 
{
char   modulo[]="ifnCargaListaQuery";
long   lRowsCiclo=0, lTotalRows=0,lRowsProcesadas=0;
int    iSalir=FALSE, j=0;
char   szCod_banco	  [16];
char   szInd_pertrib  [2] ;
char   szNom_cliente  [51];
char   szDirec_clie   [61];
char   szOperadora    [4] ;
long   lNum_celular   ;
char   szNum_contrato [22];
int    iCod_tipdocum  ;
long   lNum_folio     ;
double dTot_pagar     ;
int    iRet           ;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente   [MAX_ARRAY];
	double dhImporte       [MAX_ARRAY];
	
	int    iValorCero = 0;
	int    iValorUno  = 1;
	int    iValorTres = 3;
	char   szFiller     [2];
	char   szhCartera  [11];
	char   szhTipDocum [13];
/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	strcpy(szhCartera,"CO_CARTERA");
	strcpy(szhTipDocum,"COD_TIPDOCUM");
	strcpy(szFiller," ");

	/************************************************************************/
	/* Toma el Universo de clientes pac rechazados por ciclo                */
	/************************************************************************/
	/* EXEC SQL DECLARE Cur_SaldosCar CURSOR FOR
   SELECT NVL(SUM(IMPORTE_DEBE - IMPORTE_HABER),:iValorCero), COD_CLIENTE
   FROM   CO_CARTERA 
   WHERE  FEC_VENCIMIE < SYSDATE-:iValorUno
   AND    COD_PRODUCTO  = :iValorUno
	AND    IND_FACTURADO = :iValorUno
	AND    COD_TIPDOCUM NOT IN (SELECT TO_NUMBER(COD_VALOR)
  			                		 FROM   CO_CODIGOS
		                    		 WHERE  NOM_TABLA   = :szhCartera
		                         AND    NOM_COLUMNA = :szhTipDocum) AND ROWNUM < 1001
	GROUP BY COD_CLIENTE; */ 

	
	if( SQLCODE != SQLOK )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"DECLARE Cur_SaldosCar",SQLERRM);
		return -1;
	}

	/* EXEC SQL OPEN Cur_SaldosCar; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0004;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )90;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iValorUno;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&iValorUno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&iValorUno;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCartera;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhTipDocum;
 sqlstm.sqhstl[5] = (unsigned long )13;
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


	if( SQLCODE != SQLOK )	{
		iDError(modulo,ERR000,vInsertarIncidencia,"OPEN Cur_SaldosCar",SQLERRM);
		return -1;
	}

	iSalir=FALSE;
	while(!iSalir)
	{
		/* EXEC SQL
		FETCH Cur_SaldosCar
		INTO :dhImporte, 
			  :lhCod_cliente; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 6;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )129;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)dhImporte;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )sizeof(double);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)lhCod_cliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
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


		
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
			iDError(modulo,ERR000,vInsertarIncidencia,"FETCH Cur_SaldosCar",SQLERRM);
			break;
		}

		if( SQLCODE == SQLNOTFOUND )  {
			iSalir = TRUE;
		}

      lTotalRows = SQLROWS;
      lRowsCiclo = ( lTotalRows - lRowsProcesadas );
		vDTrazasLog( modulo, "\tlTotalRows[%ld]", LOG03,lTotalRows);
		vDTrazasLog( modulo, "\tlRowsCiclo[%ld]\n", LOG03,lRowsCiclo);

		/* traspasamos los datos desde el host array a la lista de trabajo */
		for( j = 0; j < lRowsCiclo; j++ )	{

			vDTrazasLog( modulo, "\n\t[%d] ",LOG05, j+1);
			vDTrazasLog( modulo, "\tlCod_cliente  ======>  [%ld]",LOG03, lhCod_cliente[j]);
			/* Selecciona datos de la Fa_histdocu*/
			iRet=ifnDatosFa_Histdocu(lhCod_cliente [j], &iCod_tipdocum , &lNum_folio , &dTot_pagar);

			if (iRet==0) {
				/* Selecciona datos de la Ga_abocel  */
				iRet=ifnDatosGa_Abocel(lhCod_cliente [j], &lNum_celular , szNum_contrato);
				
				if (iRet==0) {
					/* Selecciona datos de la Ge_clientes*/
					iRet=ifnDatosGe_Clientes(lhCod_cliente [j], szCod_banco, szInd_pertrib, szNom_cliente, szDirec_clie, szOperadora);
		
					if (iRet==0) {
					   /* Insertamos un nodo para el codigo de cliente */
					   if (ifnInsertaPasoc(&pLista_Aux)!=0) {
							vDTrazasLog( modulo, "\tError al Insertar Nodo en pLista_Aux.", LOG00);
					   	return -1;
					   }
			        		   
						/* Vacía los valores de variables a los campos de la lista */
						pLista_Aux->lCod_cliente  = lhCod_cliente [j];
						pLista_Aux->dTot_pagar_ca = dhImporte [j];
						pLista_Aux->iCod_tipdocum = iCod_tipdocum;
						pLista_Aux->lNum_folio    = lNum_folio;
						pLista_Aux->dTot_pagar_fa = dTot_pagar;
						pLista_Aux->lNum_celular  = lNum_celular;
						strcpy(pLista_Aux->szNum_contrato,szNum_contrato);
						strcpy(pLista_Aux->szCod_banco	,szCod_banco	);
						strcpy(pLista_Aux->szInd_pertrib ,szInd_pertrib);
						strcpy(pLista_Aux->szNom_cliente ,szNom_cliente);
						strcpy(pLista_Aux->szDirec_clie  ,szDirec_clie );
						strcpy(pLista_Aux->szCod_Operadora,szOperadora);
						vDTrazasLog( modulo, "\t\t pLista_Aux->lNum_folio      ===>  [%ld]", LOG05,pLista_Aux->lNum_folio);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szCod_banco     ===>  [%s]", LOG05,pLista_Aux->szCod_banco);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->iCod_tipdocum   ===>  [%d]", LOG06,pLista_Aux->iCod_tipdocum);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->lNum_celular    ===>  [%ld]", LOG06,pLista_Aux->lNum_celular);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szNum_contrato  ===>  [%s]", LOG07,pLista_Aux->szNum_contrato);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szInd_pertrib   ===>  [%s]", LOG07,pLista_Aux->szInd_pertrib);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szNom_cliente   ===>  [%s]", LOG06,pLista_Aux->szNom_cliente);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szDirec_clie    ===>  [%s]", LOG07,pLista_Aux->szDirec_clie);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->szCod_Operadora ===>  [%s]", LOG07,pLista_Aux->szCod_Operadora);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->dTot_pagar_ca   ===>  [%f]", LOG07,pLista_Aux->dTot_pagar_ca);			
						vDTrazasLog( modulo, "\t\t pLista_Aux->dTot_pagar_fa   ===>  [%f]\n", LOG07,pLista_Aux->dTot_pagar_fa);			
			
						lTotalReg++;
					}
				}
			}
		}

		lRowsProcesadas = lRowsProcesadas + lRowsCiclo; /* Resetea Contador, ya que las filas recuperadas se han procesado */
		if( iSalir )	vDTrazasLog( modulo, "\tAlcanzando Fin de Datos Cur_SaldosCar.\n", LOG03);

	} /* fin while cursor Cur_SaldosCar */

	/* EXEC SQL
	CLOSE Cur_SaldosCar; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )152;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE != SQLOK )  {
		iDError(modulo,ERR000,vInsertarIncidencia,"CLOSE Cur_SaldosCar",SQLERRM);
	}
	
	vDTrazasLog( modulo, "\tLista de trabajo cargada con %ld registros\n", LOG03,lTotalReg);
	return 0;
		
}

/*==================================================================================*/
/* Funcion que selecciona los datos necesarios de la Fa_Histdocu  para el archivo   */
/*==================================================================================*/
int ifnDatosFa_Histdocu(long pCod_cliente, int *piCod_tipdocum , long *plNum_folio , double *pdTot_pagar)
{
char modulo[]="ifnDatosFa_Histdocu";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente ;
   int    ihCod_tipdocum;
   long   lhNum_folio   ;
   double dhTot_pagar   ;

	int    iValorCero = 0;
	int    iValorUno  = 1;
/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog( modulo, "\tEn funcion [%s]  <====>  Cliente [%ld]", LOG05,modulo,pCod_cliente);
   lhCod_cliente = pCod_cliente;

	/* EXEC SQL
   SELECT UNIQUE NVL(A.COD_TIPDOCUM,:iValorCero)  , 
          NVL(A.NUM_FOLIO,:iValorCero) , 
          NVL(C.TOT_PAGAR,:iValorCero)
   INTO   :ihCod_tipdocum , 
   		 :lhNum_folio    , 
   		 :dhTot_pagar   
   FROM   FA_HISTDOCU A , 
         (SELECT MAX(FA.FEC_EMISION) AS FEC_EMISION	FROM  FA_HISTDOCU FA
   	    WHERE  FA.COD_CLIENTE = :lhCod_cliente
   	    AND    FA.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = :iValorUno)) B,
   	   (SELECT  SUM(HI.TOT_PAGAR) AS TOT_PAGAR, HI.COD_CLIENTE
   	    FROM    FA_HISTDOCU HI  
   	    WHERE   HI.COD_CLIENTE = :lhCod_cliente GROUP BY HI.COD_CLIENTE) C
   WHERE  A.COD_CLIENTE = :lhCod_cliente
   AND    A.COD_CLIENTE = C.COD_CLIENTE
   AND    A.FEC_EMISION = B.FEC_EMISION
   AND    A.COD_TIPDOCUM IN (SELECT COD_TIPDOCUMMOV FROM FA_TIPDOCUMEN WHERE IND_CICLO = :iValorUno); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 11;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select unique NVL(A.COD_TIPDOCUM,:b0) ,NVL(A.NUM_FOLIO,:b0) \
,NVL(C.TOT_PAGAR,:b0) into :b3,:b4,:b5  from FA_HISTDOCU A ,(select max(FA.FEC\
_EMISION) FEC_EMISION  from FA_HISTDOCU FA where (FA.COD_CLIENTE=:b6 and FA.CO\
D_TIPDOCUM in (select COD_TIPDOCUMMOV  from FA_TIPDOCUMEN where IND_CICLO=:b7)\
)) B ,(select sum(HI.TOT_PAGAR) TOT_PAGAR ,HI.COD_CLIENTE  from FA_HISTDOCU HI\
 where HI.COD_CLIENTE=:b6 group by HI.COD_CLIENTE) C where (((A.COD_CLIENTE=:b\
6 and A.COD_CLIENTE=C.COD_CLIENTE) and A.FEC_EMISION=B.FEC_EMISION) and A.COD_\
TIPDOCUM in (select COD_TIPDOCUMMOV  from FA_TIPDOCUMEN where IND_CICLO=:b7))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )167;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&iValorCero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iValorCero;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&iValorCero;
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
 sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_folio;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&dhTot_pagar;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_cliente;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&iValorUno;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&lhCod_cliente;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lhCod_cliente;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&iValorUno;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
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



	if( (SQLCODE != SQLOK ) && (SQLCODE != SQLNOTFOUND))	{
		iDError(modulo,ERR000,vInsertarIncidencia,"Select Fa_Histdocu",SQLERRM);
		return -1;
	}
   if (SQLCODE == SQLNOTFOUND) {
   	ihCod_tipdocum=0;
   	lhNum_folio =0;
   	dhTot_pagar =0;
	}
   *piCod_tipdocum=ihCod_tipdocum;
   *plNum_folio=lhNum_folio;
   *pdTot_pagar=dhTot_pagar;  

	return 0;
}

/*==================================================================================*/
/* Funcion que selecciona los datos necesarios de la Ga_abocel  para el archivo     */
/*==================================================================================*/
int ifnDatosGa_Abocel(long pCod_cliente, long *plNum_celular, char *pszNum_contrato)
{
char modulo[]="ifnDatosGa_Abocel";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente       ;
	long   lhNum_celular       ;
	char   szhNum_contrato [22]; /* EXEC SQL VAR szhNum_contrato IS STRING(22); */ 


	int    iValorCero = 0;
	int    iValorUno  = 1;
	char   szhSituacion[4];
	char   szFiller   [2];
/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog( modulo, "\tEn funcion [%s]    <====>  Cliente [%ld]", LOG06,modulo,pCod_cliente);
	strcpy(szhSituacion,"AAA");
	strcpy(szFiller," ");
   lhCod_cliente = pCod_cliente;

	/* Selecciona datos de la Ga_Abocel*/
   /* EXEC SQL
   SELECT UNIQUE NVL(A.NUM_CONTRATO,:szFiller) , 
          NVL(A.NUM_CELULAR,:iValorCero)
   INTO   :szhNum_contrato , 
          :lhNum_celular 
   FROM   GA_ABOCEL A, (SELECT MAX(GA.FEC_ALTA) AS FEC_ALTA , MAX(NUM_ABONADO) AS NUM_ABONADO
                        FROM GA_ABOCEL GA 
   				         WHERE GA.COD_CLIENTE=:lhCod_cliente 
   				         AND   (GA.COD_SITUACION = :szhSituacion OR GA.FEC_BAJA IS NULL)) B
   WHERE  A.COD_CLIENTE   = :lhCod_cliente
   AND   (A.COD_SITUACION = :szhSituacion OR A.FEC_BAJA IS NULL)
   AND    A.COD_PRODUCTO  = :iValorUno
   AND    A.NUM_ABONADO   = B.NUM_ABONADO
	AND    A.FEC_ALTA      = B.FEC_ALTA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select unique NVL(A.NUM_CONTRATO,:b0) ,NVL(A.NUM_CELULAR,:\
b1) into :b2,:b3  from GA_ABOCEL A ,(select max(GA.FEC_ALTA) FEC_ALTA ,max(NUM\
_ABONADO) NUM_ABONADO  from GA_ABOCEL GA where (GA.COD_CLIENTE=:b4 and (GA.COD\
_SITUACION=:b5 or GA.FEC_BAJA is null ))) B where ((((A.COD_CLIENTE=:b4 and (A\
.COD_SITUACION=:b5 or A.FEC_BAJA is null )) and A.COD_PRODUCTO=:b8) and A.NUM_\
ABONADO=B.NUM_ABONADO) and A.FEC_ALTA=B.FEC_ALTA)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )226;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&iValorCero;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhNum_contrato;
   sqlstm.sqhstl[2] = (unsigned long )22;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNum_celular;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_cliente;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhSituacion;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_cliente;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhSituacion;
   sqlstm.sqhstl[7] = (unsigned long )4;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&iValorUno;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
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



	if( (SQLCODE != SQLOK ) && (SQLCODE != SQLNOTFOUND))	{
		iDError(modulo,ERR000,vInsertarIncidencia,"Select Ga_Abocel ",SQLERRM);
		return -1;
	}
   if (SQLCODE == SQLNOTFOUND) {
	   lhNum_celular=0;
	   strcpy(szhNum_contrato," ");
   }

   *plNum_celular=lhNum_celular;
   strcpy(pszNum_contrato,szhNum_contrato	);

	return 0;
}

/*==================================================================================*/
/* Funcion que selecciona los datos necesarios de la Ge_clientes  para el archivo   */
/*==================================================================================*/
int ifnDatosGe_Clientes(long pCod_cliente, char *pszCod_banco, char *pszInd_pertrib, char *pszNom_cliente, char *pszDirec_clie, char *pszOperadora)
{
char modulo[]="ifnDatosGe_Clientes";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente       ;
	char   szhCod_banco	  [16]; /* EXEC SQL VAR szhCod_banco IS STRING(16); */ 
 
	char   szhInd_pertrib  [2] ; /* EXEC SQL VAR szhInd_pertrib IS STRING(2); */ 

	char   szhNom_cliente  [51]; /* EXEC SQL VAR szhNom_cliente IS STRING(51); */ 

	char   szhDirec_clie   [61]; /* EXEC SQL VAR szhDirec_clie IS STRING(61); */ 

	char   szhDireccion   [961]; /* EXEC SQL VAR szhDireccion IS STRING(961); */ 

	char   szhCod_Operadora[4] ; /* EXEC SQL VAR szhCod_Operadora IS STRING(4); */ 


	int    iValorUno  = 1;
	int    iValorTres = 3;
	char   szFiller   [2];
/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog( modulo, "\tEn funcion [%s]  <====>  Cliente [%ld]", LOG07,modulo,pCod_cliente);
	strcpy(szFiller," ");
   lhCod_cliente = pCod_cliente;

   /* EXEC SQL
   SELECT DECODE(A.COD_BANCO, NULL, (DECODE(A.COD_BANCOTARJ, NULL, :szFiller, A.COD_BANCOTARJ)),A.COD_BANCO), 
          NVL(B.IND_PERTRIB,:szFiller) ,
          NVL(A.NOM_CLIENTE,:szFiller)||' '||NVL(A.NOM_APECLIEN1,:szFiller)||' '||NVL(A.NOM_APECLIEN2,:szFiller),
          SUBSTR(A.COD_OPERADORA,1,3)
   INTO   :szhCod_banco	 ,
          :szhInd_pertrib,
          :szhNom_cliente,
          :szhCod_Operadora
   FROM   GE_CLIENTES A ,GE_TIPIDENT B
   WHERE  A.COD_CLIENTE = :lhCod_cliente
   AND    A.COD_TIPIDENT= B.COD_TIPIDENT; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DECODE(A.COD_BANCO,null ,DECODE(A.COD_BANCOTARJ,nul\
l ,:b0,A.COD_BANCOTARJ),A.COD_BANCO) ,NVL(B.IND_PERTRIB,:b0) ,((((NVL(A.NOM_CL\
IENTE,:b0)||' ')||NVL(A.NOM_APECLIEN1,:b0))||' ')||NVL(A.NOM_APECLIEN2,:b0)) ,\
SUBSTR(A.COD_OPERADORA,1,3) into :b5,:b6,:b7,:b8  from GE_CLIENTES A ,GE_TIPID\
ENT B where (A.COD_CLIENTE=:b9 and A.COD_TIPIDENT=B.COD_TIPIDENT)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )277;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[0] = (unsigned long )2;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[1] = (unsigned long )2;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[2] = (unsigned long )2;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szFiller;
   sqlstm.sqhstl[4] = (unsigned long )2;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhCod_banco;
   sqlstm.sqhstl[5] = (unsigned long )16;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhInd_pertrib;
   sqlstm.sqhstl[6] = (unsigned long )2;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhNom_cliente;
   sqlstm.sqhstl[7] = (unsigned long )51;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCod_Operadora;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&lhCod_cliente;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
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


   
   if( (SQLCODE != SQLOK ) && (SQLCODE != SQLNOTFOUND))	{
		iDError(modulo,ERR000,vInsertarIncidencia,"Select Ge_Clientes",SQLERRM);
      return -1;
   }

   if (SQLCODE == SQLNOTFOUND) {
      vDTrazasLog( modulo, "\tSelect Ge_Clientes - %s", LOG00,SQLERRM );
      return 100;
   }
   
   /* EXEC SQL EXECUTE
   	BEGIN
   		:szhDireccion:=GE_FN_OBTIENE_DIRCLIE(:lhCod_cliente,:iValorUno,:iValorTres,:iValorUno);
		END;
	END-EXEC; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "begin :szhDireccion := GE_FN_OBTIENE_DIRCLIE ( :lhCod_clie\
nte , :iValorUno , :iValorTres , :iValorUno ) ; END ;";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )332;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhDireccion;
   sqlstm.sqhstl[0] = (unsigned long )961;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_cliente;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&iValorUno;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&iValorTres;
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


   if (SQLCODE != SQLOK ) 	{
      strcpy(szhDirec_clie," ");
      vDTrazasLog( modulo, "\tDireccion no encontrada - %s", LOG02,SQLERRM );
   } else {
	   strncpy(szhDirec_clie,&szhDireccion[0],60);
   }
   
   strcpy(pszCod_banco,szhCod_banco	);
   strcpy(pszInd_pertrib,szhInd_pertrib);
   strcpy(pszNom_cliente,szhNom_cliente);
   strcpy(pszDirec_clie,szhDirec_clie );
   strcpy(pszOperadora,szhCod_Operadora);

	return 0;
}

/*===========================================================================*/
/* Ordenamiento x banco Archivo Salida		     	 */
/*===========================================================================*/
int ifnOrdenaArchivo(void)
{
char modulo[]="ifnOrdenaArchivo";
char 	szComando      [500]; 
vDTrazasLog(modulo,"\t=> Ordenando Archivo [%s].\n",LOG03,szFileDat);
   memset(&szComando,'\0',sizeof(szComando));
   strcpy(szComando,"sort -o ");
   strcat(szComando,szFileDat);
   strcat(szComando,"-tmp");   /* Salida */
   strcat(szComando," +0.0 -0.29 ");
   strcat(szComando,szFileDat);  /* Entrada */
   system(szComando);
   
   memset(&szComando,'\0',sizeof(szComando));
   strcpy(szComando,"mv ");
   strcat(szComando,szFileDat);
   strcat(szComando,"-tmp  ");
   strcat(szComando,szFileDat);
   system(szComando);
   return (0);
}

/*===========================================================================*/
/* Funcion RighTrim : Limpia blancos a la derecha                            */
/*===========================================================================*/
int RighTrim (char *szVar)
{
int  iLenVar = 0;
int  i       = 0;

   iLenVar = strlen(szVar);
   for (i=iLenVar-1;i>-1;i--) {
        if (szVar[i]==' ') {
            szVar[i]='\0';
        } else break;
   }
   return (0);        
} /* RighTrim */

/* ============================================================================= */
/* Copia un substr de un char a otro                                             */
/* ============================================================================= */
void Strcpysub(char *str1, int Largo, char *str2)
{
   int i;
   str2[0]='\0';
   for(i=0;i<=Largo-1;str2[i]=str1[i],i++);
   str2[i]='\0';
}

/* ============================================================================= */
/* Lleva una Hora dada a un valor equivalente en segundos                        */
/* ============================================================================= */
int HoraToSegs(char *HoraFmto)
{
  char *Hora,HH[3],MI[3],SS[3];
  int iHH,iMI,iSS;
  Hora=HoraFmto;
  Strcpysub(Hora,2,HH); Hora=Hora+3; /*HH:*/ iHH=atoi(HH); if (iHH<00||iHH>23) return -1;
  Strcpysub(Hora,2,MI); Hora=Hora+3; /*MI:*/ iMI=atoi(MI); if (iMI<00||iMI>59) return -1;
  Strcpysub(Hora,2,SS);              /*SS */ iSS=atoi(SS); if (iSS<00||iSS>59) return -1;
  return (iHH*3600+iMI*60+iSS);
}

/* ============================================================================= */
/* Resta dos string en fmto hora y retorna la diferencia en fmto hora y segundos */
/* ============================================================================= */
int ifnRestaHoras( char *h1, char *h2, char *hh)
{
  int ih1,ih2,ih;
  div_t hmsH,hmsMS;
  if ((ih1=HoraToSegs(h1))<0) return -1;
  if ((ih2=HoraToSegs(h2))<0) return -1;
  ih=(ih2>=ih1)?(ih2-ih1):(((24*3600)-ih1)+ih2); /* restando horas en segundos , considerando cambio de dia */
  hmsH=div(ih,3600);
  hmsMS=div(hmsH.rem,60);
  sprintf(hh,"%02d:%02d:%02d\0",hmsH.quot,hmsMS.quot,hmsMS.rem);
  return ih;
}


/******************************************************************************************/
/** Informaci¢n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi¢n                                            : */
/**  %PR% */
/** Autor de la Revisi¢n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi¢n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci¢n de la Revisi¢n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
