
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
           char  filnam[17];
};
static struct sqlcxp sqlfpn =
{
    16,
    "./pc/repropac.pc"
};


static unsigned int sqlctx = 3463299;


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
   unsigned char  *sqhstv[28];
   unsigned long  sqhstl[28];
            int   sqhsts[28];
            short *sqindv[28];
            int   sqinds[28];
   unsigned long  sqharm[28];
   unsigned long  *sqharc[28];
   unsigned short  sqadto[28];
   unsigned short  sqtdso[28];
} sqlstm = {12,28};

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
"select unique B.COD_CLIENTE ,B.COD_BANCO ,NVL(B.NUM_FOLIO,:b0) ,TO_CHAR(B.CO\
D_TIPDOCUM) ,B.IMPORTE_DEBE ,NVL(B.COD_RESPUBANCO,:b0)  from FA_HISTDOCU A ,CO\
_PAGOSPAC B where (((((((B.COD_CLIENTE=A.COD_CLIENTE and A.NUM_FOLIO=B.NUM_FOL\
IO) and A.COD_TIPDOCUM in (select COD_TIPDOCUM  from FA_TIPMOVIMIEN where COD_\
TIPMOVIMIEN=:b2)) and A.COD_CICLFACT=:b3) and A.COD_OPERADORA=B.COD_OPERADORA)\
 and A.LETRA=:b4) and A.IND_SUPERTEL=:b0) and B.COD_RESPUBANCO in (select COD_\
RESPUBANCO  from CO_RESPUBANCO where COD_RESPUBANCO in (select COD_VALOR  from\
 CO_CODIGOS where ((NOM_TABLA=:b6 and NOM_COLUMNA=:b7) and COD_VALOR=B.COD_RES\
PUBANCO))))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,180,0,6,264,0,0,6,6,0,1,0,2,5,0,0,1,97,0,0,2,5,0,0,1,97,0,0,2,97,0,0,1,
97,0,0,
44,0,0,2,66,0,4,370,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
67,0,0,3,60,0,6,398,0,0,2,2,0,1,0,2,97,0,0,1,97,0,0,
90,0,0,4,78,0,6,492,0,0,2,2,0,1,0,2,3,0,0,1,97,0,0,
113,0,0,5,644,0,9,604,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
3,0,0,1,97,0,0,1,97,0,0,
160,0,0,5,0,0,13,613,0,0,6,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,
3,0,0,
199,0,0,6,228,0,4,640,0,0,6,4,0,1,0,1,97,0,0,1,97,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1,3,0,0,
238,0,0,5,0,0,15,682,0,0,0,0,0,1,0,
253,0,0,7,542,0,4,752,0,0,28,17,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,97,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,97,0,0,
380,0,0,8,325,0,4,786,0,0,11,8,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,2,3,0,0,2,5,0,0,
2,5,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
439,0,0,9,77,0,4,805,0,0,3,2,0,1,0,1,97,0,0,2,5,0,0,1,97,0,0,
466,0,0,10,177,0,5,1038,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,
};


/*=============================================================================
   Nombre         : repropac.pc
   Programa       : Reproceso de archivo Pac
   Autor          : L.B.H. Indra
   Fecha Creacion : 06 - Mayo - 2005
==============================================================================*/

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <pasoc.h>
#include <unistd.h>
#include "repropac.h"

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

	int   ihDecimal         ;
	char  szHoraIni        [11]; /* EXEC SQL VAR szHoraIni IS STRING(11); */ 

	char  szhCod_Portadora [6]; /* EXEC SQL VAR szhCod_Portadora IS STRING(6); */ 

	char  szhhhmiss  [11];
	char szhFecha_ddmmyyyy[11]       ;
	char szhdd_mm_yyyy      [11];
	int   ihCiclo ;
	char  szhCod_moneda [4];
   char szFechayyyymmdd   [9]        ; /* EXEC SQL VAR szFechayyyymmdd          IS STRING(9); */ 

   char szhYYYYMMDD       [9];
   char szhHH24miss       [11];
   char szhyyyymm         [7];
   char szhAAA            [4];
   char szhFiller         [2];
   char szhZero		  [2];
   char szhZeroUno        [3];
   int  ihValor_Veinte     ;
   int  ihValor_Dos        ;
   int  ihValor_Cero       ;
   int  ihValor_uno        ;
   int  ihValor_tres       ;
   int  ihValor_cuatro     ;
/* EXEC SQL END DECLARE SECTION; */ 

int   iDiffSeg = 0;
char  szHoraFin[9];
char  szTmpProc[9];
int   iTotalReg;
char szFileDat  [128]   ="";
int iResultado, iFinProc=TRUE;

Lista_Pasoc pLista_Aux=NULL;
Lista_Pasoc stListaAux=NULL;

char szUsage[] = "\n\tUso : \n\trepropac -u [Usuario]/[Password]\n\t\t -l [Nivel de log. Por default es 3]\n\t\t -c [Ciclo de Facturacion]\n\n ";
 
int main( int argc, char* argv[] )
{
char modulo[]="main";

   strcpy(szhZero,"0");
   strcpy(szhFiller," ");	
   strcpy(szhyyyymm,"yyyymm");
   strcpy(szhZeroUno,"01");
   strcpy(szhAAA,"AAA");
   strcpy(szhdd_mm_yyyy,"dd/mm/yyyy");
   ihValor_Veinte  = 20;
   ihValor_Dos     = 2;
   ihValor_Cero    = 0;
   ihValor_uno     = 1;
   ihValor_tres    = 3;
   ihValor_cuatro  = 4;
   lNumOperaciones  = 0;
   lContRegPac   = 0;
   memset (&stConfig,0,sizeof (CONFIGLOCAL));
	memset( szHoraIni, '\0', sizeof( szHoraIni ) );
	strcpy(szhhhmiss,"HH24:MI:SS");

   if (argc < 3) {
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
			if (ifnReproceso() != 0) {
		   	   fprintf (stdout,"\n\tError >> Fallo Funcion Principal \n");
		   	   fflush  (stdout);
		   	   iFinProc=FALSE;
		   	   if (!bfnOraRollBack()) return FALSE; 		
			}else {
	   	               if (!bfnOraCommit())	return FALSE; 
	                }
			
		}
		
		if (iFinProc)  {
	           fprintf(stdout,	"================================================\n");									 
	           fprintf(stdout, "Estadistica del proceso\n");								 
	           fprintf(stdout,	"================================================\n");									 
	           fprintf(stdout, "Cantidad de Registros del Universo [%ld]\n",iTotalReg);			       
	           fprintf(stdout, "Cantidad de Registros Procesados   [%ld]\n",lContRegPac);			       	           
	           fprintf(stdout, "Proceso [%s] finalizado ok.\n\n\n", LOGNAME);
                } else 
	           fprintf(stdout,"\n\t* Proceso genero Anomalias. Favor Revisar. *\n\n");
	        /*---------------------------------------------------------------------------*/
                /* Cierre de Archivo Banco   					             */
               /*---------------------------------------------------------------------------*/		    	
	       fclose(FichBancos       );   
                /*---------------------------------------------------------------------------*/
                /* Ordena Archivo Banco   					             */
               /*---------------------------------------------------------------------------*/		    
               if (lContRegPac >0  ){               	   
	           iResultado = ifnOrdenaArchivo();
  	           if (iResultado != 0) exit(1);
               }
               	
               if( ifnExitReproceso() != 0 ) {
			fprintf (stdout,"\n\tError >> Fallo Funcion de estadistica \n");
			fflush  (stdout);
		}

	}	
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
char   opt[] = ":u:l:c:";

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
                 case 'c':
                   if ( strlen (optarg) )
                   {
                        stConfig.bOptCodCicloFact= TRUE         ;
                        stConfig.lCodCicloFact  = atol(optarg); 
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
         return (1);
    }
    else
    {
       if ( (pszTmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tFormato Usuario Oracle Incorrecto:\n%s\n", szUsage);
             return (1);
       }
       else
       {
          strncpy (stConfig.szUsuario ,szUsuario,pszTmp-szUsuario);
          strcpy  (stConfig.szPassWord, pszTmp+1);
       }
    }

    if( !stConfig.bOptCodCicloFact )
    {
           fprintf (stderr, "\n\tError.Falta parametros de Ciclo : %s\n",szUsage);
           return (1);
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
       /*-----------------------------------------------------------------------*/
	/* Obtencion y tratamiento de Fecha para ser utilizada en archivos       */
	/*-----------------------------------------------------------------------*/	
	strcpy( szTime, cfnGetTimePac() );
	
	strcpy(szhYYYYMMDD,"YYYYMMDD");
	strcpy(szhHH24miss,"hh24:mi:ss");

	/* Valida Parametro del Ciclo de Facturacion */
	if (ifnValidaCicloFact()!=0) return -1;
	
	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraIni := TO_CHAR(SYSDATE,:szhHH24miss);
        	:szFechayyyymmdd  :=TO_CHAR(SYSDATE	 ,:szhYYYYMMDD)  ;
        	:szhFecha_ddmmyyyy:=TO_CHAR(SYSDATE	,:szhdd_mm_yyyy);
			
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin :szHoraIni := TO_CHAR ( SYSDATE , :szhHH24miss ) ; :sz\
Fechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMDD ) ; :szhFecha_ddmmyyyy := TO\
_CHAR ( SYSDATE , :szhdd_mm_yyyy ) ; END ;";
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
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecha_ddmmyyyy;
 sqlstm.sqhstl[4] = (unsigned long )11;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhdd_mm_yyyy;
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
  	
	fprintf(stdout, "\nProcesando ...\n");                                        
       vDTrazasLog( modulo, "%s"      ,LOG03 , szRaya);                    
       vDTrazasLog( modulo, "FECHA            [%s]",LOG03 , szhFecha_ddmmyyyy);
       vDTrazasLog( modulo, "PROGRAMA         [%s]",LOG03 , LOGNAME    );                
       vDTrazasLog( modulo, "%s"                   ,LOG03 , GLOSA_PROG );                
       vDTrazasLog( modulo, "VERSION          [%s]",LOG03 , szhVersion );      
       vDTrazasLog( modulo, "%s\n"    ,LOG03, szRaya); 

       fprintf( stdout, "%s\n"      , szRaya);                    
       fprintf( stdout, "FECHA            [%s]\n", szhFecha_ddmmyyyy);
       fprintf( stdout, "PROGRAMA         [%s]\n", LOGNAME    );                
       fprintf( stdout, "%s\n"                   , GLOSA_PROG );                
       fprintf( stdout, "VERSION          [%s]\n", szhVersion );      
       fprintf( stdout, "%s\n"    , szRaya); 

  	
	vDTrazasError( modulo, "\n\t***************************************************************"
					 	  "\n\t%s  Reproceso Clientes PAC Rechazados      Hora : %s      "
						  "\n\t***************************************************************\n\n",LOG03,szhVersion,szHoraIni);	


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
/*char szFileDat  [128]   ="" ;*/
char szFileBanco[60] = "";
   /*-----------------------------------------------------------------------*/
   /* Inicializacion de estructura	de archivo								*/
   /*-----------------------------------------------------------------------*/
	memset(szArchivo,'\0',sizeof(szArchivo));

	sprintf(szArchivo,"repropac%s",szTime);
	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

	if (iTipfile == 0) {
		sprintf(szPathLog  ,"%s/LOG/Recaudacion/Reproceso/%s",pathDir,szFechayyyymmdd);
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
		sprintf( szFileBanco, "repropac%s.dat", szTime);
		sprintf(szPathDat  ,"%s/DAT/Recaudacion/%s",pathDir,szFechayyyymmdd);
		free(pathDir);
		sprintf(szComando,"/usr/bin/mkdir -p %s", szPathDat);
		system (szComando);
	
		sprintf(szFileDat,"%s/%s\0",szPathDat,szFileBanco);
		vDTrazasLog( modulo, "\n\t Fichero REPRO PAC : %s\n\n\n", LOG07, szFileDat);
		if( ( FichBancos = fopen( szFileDat,"a" ) ) == (FILE*)NULL )  {
		    vDTrazasError(modulo, "\t\t### Error: No puede abrirse el fichero para enviar al Banco\n\n\t [%s]\n", LOG01, szFilePac );
			return -1;
		}
	}
	
   return 0;
}/* ifnAbreArchivosLog */

/* ============================================================================= */
/* ifnValidaCicloFact(): Valida ciclo de facturacion y obtiene codigo de ciclo   */
/* ============================================================================= */
int ifnValidaCicloFact()
{
char modulo[]="ifnValidaCicloFact";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long  lhCicloFact ;
/* EXEC SQL END DECLARE SECTION; */ 


	lhCicloFact=stConfig.lCodCicloFact;
	
	/* EXEC SQL
	SELECT COD_CICLO
	INTO   :ihCiclo
	FROM   FA_CICLFACT
	WHERE  COD_CICLFACT = :lhCicloFact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLO into :b0  from FA_CICLFACT where COD_CICLFA\
CT=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )44;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCicloFact;
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



	if( SQLCODE!=SQLOK ) {
		vDTrazasLog( modulo, "\tSELECT FA_CICLFACT - %s", LOG00,SQLERRM );
		return -1;
	}

	if (ihCiclo > 0) {
		fprintf(stderr, "==> Codigo de Ciclo : [%d]\n", ihCiclo );
		return 0;
	}
	else
		return -1;
	
}

/* ============================================================================= */
/* Funcion ifnExitReproceso: finaliza proceso    				                     */
/* ============================================================================= */
int ifnExitReproceso (void)
{
char modulo[]="ifnExitReproceso";

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
 sqlstm.offset = (unsigned int  )67;
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
                       "\n\t REGISTROS PROCESADOS : %d"
                       "\n\t PROMEDIO  x  REGISTRO: %.5f segs "
                       "\n\n\n",LOG03,szHoraIni,szHoraFin,szTmpProc,iDiffSeg,iTotalReg,(float)((float)iDiffSeg/(float)iTotalReg) );

	if ( fclose(stStatus.LogFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Log\n");
	    fflush  (stderr);
	}

	if ( fclose(stStatus.ErrFile) != 0 )    {
	    fprintf (stderr,"Error al cerrar archivo de Errores\n");
	    fflush  (stderr);
	}

	return 0;
}/* fin a ifnExitReproceso */


/* ============================================================================= */
/* ============================================================================= */
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaPasoc(Lista_Pasoc *ant)
{
	Lista_Pasoc p;
	if ((p=(struct REPROCESO *) malloc(sizeof(struct REPROCESO))) == NULL)
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
/* Genera listas enlazadas,                                                      */
/* ============================================================================= */
int ifnReproceso()
{
char modulo[]="ifnReproceso";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long   lhCod_cliente     ;
	long   lhNumFolio ;        
	char   szhNum_decimal  [12];
	int    ihValor_cero    = 0 ;
	int    ihValor_uno     = 1 ;
	long   lhSecu_transac      ;
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
 sqlstm.offset = (unsigned int  )90;
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

	if (ifnCargaListaQuery()!=0) return -1;
	
	if (iTotalReg > 0 )
	{
		stListaAux=pLista_Aux;
		/*-----------------------------------------------------------------------*/
	   /* Inicializacion de Archivos Bancos										 */
	   /*-----------------------------------------------------------------------*/
      if (ifnAbreArchivosLog(1)!=0) return -1;
  		
     	while (stListaAux!= NULL)
	   {
			lhCod_cliente = stListaAux->lCod_cliente ;
			lhNumFolio    = stListaAux->lNum_folio ;		 
			vDTrazasLog( modulo, "\n\t Cliente %ld Folio %ld respubanco %d \n\n", LOG07,lhCod_cliente,lhNumFolio,stListaAux->iRespubanco);	
			
			lContRegPac++  ;
			if (ifnFormatoUnico()!=0) return -1;
			if (!bfnDBUpdatePagospac( ) )	return -1;
			
			stListaAux=stListaAux->sig;
		}
	}
	else
	{
		vDTrazasLog( modulo, "\tNo existen Pagos Rechazados", LOG02);
	}

	vDTrazasLog( modulo, "\tFin a funcion %s", LOG03, modulo );
	vfnBorraListaPasoc( &pLista_Aux );

	return 0;

}/* Fin ifnReproceso */


/* ============================================================================= */
/* Genera listas enlazadas con clientes rechazados                               */
/* ============================================================================= */
int ifnCargaListaQuery() 
{
char modulo[]="ifnCargaListaQuery";
long lRowsCiclo=0, lTotalRows=0,lRowsProcesadas=0;
int  iSalir=FALSE, j=0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long  lhCod_cliente   [MAX_ARRAY];
	char  szhCodBanco     [MAX_ARRAY][16];
	char  szhCodTipDocum  [MAX_ARRAY][3];
	long  lhNumFolio      [MAX_ARRAY];
	double dhImpDebe      [MAX_ARRAY];	
	int   ihRespubanco    [MAX_ARRAY];
	long  ihCod_Ciclfact             ;
	char  szhCO_RESPUBANCO       [14];
	char  szhCOD_RESPUBANCO      [15];
	char  szhLetra_I              [2];
	long  lhCodcliente               ;
	long  lhNum_Folio                ;
	char  szFecProyyyymmdd  [9]      ; /* EXEC SQL VAR szFecProyyyymmdd   IS STRING(9); */ 

   char  szFecEfeyyyymmdd  [9]      ; /* EXEC SQL VAR szFecEfeyyyymmdd   IS STRING(9); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	
   strcpy(szhCO_RESPUBANCO,"CO_RESPUBANCO");
   strcpy(szhCOD_RESPUBANCO,"COD_RESPUBANCO");
   strcpy(szhLetra_I,"I");
        
	ihCod_Ciclfact=stConfig.lCodCicloFact;
	
	vDTrazasLog( modulo, "\n\tCiclo  %ld\n", LOG03,ihCod_Ciclfact);
	/************************************************************************/
	/* Toma el Universo de clientes pac rechazados por ciclo                */
	/************************************************************************/	
	/* EXEC SQL DECLARE Cur_PagosRech CURSOR FOR
	SELECT UNIQUE B.COD_CLIENTE, 
	              B.COD_BANCO ,                       
	              NVL(B.NUM_FOLIO,:ihValor_Cero),
	              TO_CHAR(B.COD_TIPDOCUM),
	              B.IMPORTE_DEBE,                       
	NVL(B.COD_RESPUBANCO,:ihValor_Cero)
	FROM   FA_HISTDOCU A, CO_PAGOSPAC B
	WHERE  B.COD_CLIENTE  = A.COD_CLIENTE
	AND    A.NUM_FOLIO    = B.NUM_FOLIO
	AND    A.COD_TIPDOCUM IN (SELECT COD_TIPDOCUM
	                	 FROM 	FA_TIPMOVIMIEN
	                    WHERE	COD_TIPMOVIMIEN = :ihValor_Dos	)                    	                         
	AND    A.COD_CICLFACT    = :ihCod_Ciclfact
	AND    A.COD_OPERADORA   = B.COD_OPERADORA
	AND	 A.LETRA           = :szhLetra_I
	AND	 A.IND_SUPERTEL    = :ihValor_Cero
	AND    B.COD_RESPUBANCO  IN (SELECT COD_RESPUBANCO FROM CO_RESPUBANCO
	            					  WHERE COD_RESPUBANCO IN (SELECT COD_VALOR FROM CO_CODIGOS
	                                                      WHERE NOM_TABLA = :szhCO_RESPUBANCO
	                                                      AND NOM_COLUMNA = :szhCOD_RESPUBANCO
	                                                      AND COD_VALOR   = B.COD_RESPUBANCO)); */ 

	if( SQLCODE != SQLOK )	{
		vDTrazasLog( modulo, "\tDECLARE Cur_PagosRech - %s", LOG00,SQLERRM );
		return -1;
	}

	/* EXEC SQL OPEN Cur_PagosRech; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0005;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )113;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Dos;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_Ciclfact;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_I;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhCO_RESPUBANCO;
 sqlstm.sqhstl[6] = (unsigned long )14;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhCOD_RESPUBANCO;
 sqlstm.sqhstl[7] = (unsigned long )15;
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


	if( SQLCODE != SQLOK )	{
		vDTrazasLog( modulo, "\tOPEN Cur_PagosRech - %s", LOG00,SQLERRM );
		return -1;
	}

	iSalir=FALSE;
	while(!iSalir)
	{
		/* EXEC SQL
		FETCH Cur_PagosRech
		INTO :lhCod_cliente,
		     :szhCodBanco,		     
		     :lhNumFolio,
		     :szhCodTipDocum,
		     :dhImpDebe,		     
		     :ihRespubanco; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 8;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )20000;
  sqlstm.offset = (unsigned int  )160;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lhCod_cliente;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodBanco;
  sqlstm.sqhstl[1] = (unsigned long )16;
  sqlstm.sqhsts[1] = (         int  )16;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)lhNumFolio;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )sizeof(long);
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqharc[2] = (unsigned long  *)0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCodTipDocum;
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )3;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqharc[3] = (unsigned long  *)0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)dhImpDebe;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[4] = (         int  )sizeof(double);
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqharc[4] = (unsigned long  *)0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)ihRespubanco;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )sizeof(int);
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


		     
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
			vDTrazasLog( modulo, "\tFETCH Cur_PagosRech - %s", LOG00,SQLERRM );
			break;
		}

		if( SQLCODE == SQLNOTFOUND )  iSalir = TRUE;

      lTotalRows = SQLROWS;
      lRowsCiclo = ( lTotalRows - lRowsProcesadas );
		vDTrazasLog( modulo, "\tlTotalRows[%ld]", LOG03,lTotalRows);
		vDTrazasLog( modulo, "\tlRowsCiclo[%ld]", LOG03,lRowsCiclo);

		/* traspasamos los datos desde el host array a la lista de trabajo */
		for( j = 0; j < lRowsCiclo; j++ )	{

			lhCodcliente  = lhCod_cliente [j];
         lhNum_Folio   = lhNumFolio [j];
         /* Validacion Registro no ha sido pagado */
         /* EXEC SQL
		   SELECT TO_CHAR(A.FEC_EFECTIVIDAD,:szhYYYYMMDD), 
		   		 TO_CHAR(B.FEC_PROCESO,:szhYYYYMMDD)		             
	      INTO   :szFecEfeyyyymmdd , :szFecProyyyymmdd
   	   FROM   CO_PAGOS A, CO_PAGOSPAC B
   	   WHERE  A.COD_CLIENTE  = :lhCodcliente
	      AND    B.NUM_FOLIO    = :lhNum_Folio
	      AND    A.COD_CLIENTE  = B.COD_CLIENTE	                 
	      AND    A.FEC_EFECTIVIDAD > B.FEC_PROCESO ; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 8;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "select TO_CHAR(A.FEC_EFECTIVIDAD,:b0) ,TO_CHAR(B.FEC\
_PROCESO,:b0) into :b2,:b3  from CO_PAGOS A ,CO_PAGOSPAC B where (((A.COD_CLIE\
NTE=:b4 and B.NUM_FOLIO=:b5) and A.COD_CLIENTE=B.COD_CLIENTE) and A.FEC_EFECTI\
VIDAD>B.FEC_PROCESO)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )199;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDD;
         sqlstm.sqhstl[0] = (unsigned long )9;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDD;
         sqlstm.sqhstl[1] = (unsigned long )9;
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)szFecEfeyyyymmdd;
         sqlstm.sqhstl[2] = (unsigned long )9;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)szFecProyyyymmdd;
         sqlstm.sqhstl[3] = (unsigned long )9;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lhCodcliente;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)&lhNum_Folio;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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



 	      if (SQLCODE!=SQLOK && SQLCODE!=NOTFOUND )  {
		   	vDTrazasLog( modulo, "\tSELECT CO_PAGOS CO_PAGOSPAC - %s", LOG00,SQLERRM );
		      return -1;
	      }
	                
	      if (SQLCODE==NOTFOUND )  {	  
	      	/* Insertamos un nodo para el codigo de cliente */
		      if (ifnInsertaPasoc(&pLista_Aux)!=0) {
					vDTrazasLog( modulo, "\tError al Insertar Nodo en pLista_Aux.", LOG00);
		   	   return -1;
		      }     	
	                	
	         /* Asigna valor del arreglo al campo de la lista */
			   pLista_Aux->lCod_cliente  = lhCod_cliente [j];
			   strcpy(pLista_Aux->szCodBanco, szhCodBanco [j]);
            strcpy(pLista_Aux->szCod_TipDocum,szhCodTipDocum [j]);                            
            pLista_Aux->lNum_folio    = lhNumFolio [j];
            pLista_Aux->dMonto_pagar  = dhImpDebe [j];                            
            pLista_Aux->iRespubanco   = ihRespubanco [j];
                            
         }    
			vDTrazasLog( modulo, "\n\t[%06d] ",LOG05, j+1);
			vDTrazasLog( modulo, "\tlCod_cliente  ======>  [%ld]",LOG05, pLista_Aux->lCod_cliente);
			iTotalReg++;

		}

		lRowsProcesadas = lRowsProcesadas + lRowsCiclo; /* Resetea Contador, ya que las filas recuperadas se han procesado */
		if( iSalir )	vDTrazasLog( modulo, "\tAlcanzando Fin de Datos Cur_PagosRech.\n", LOG03);

	} /* fin while cursor Cur_PagosRech */

	/* EXEC SQL
	CLOSE Cur_PagosRech; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 8;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )238;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE != SQLOK )  {
		vDTrazasLog( modulo, "\tCLOSE Cur_PagosRech - %s", LOG00, SQLERRM );
	}
	
	return 0;
		
}

/*===========================================================================*/
/* Funcion ifnFormatoUnico : Imprime en archivo plano, con formato Unico     */
/*===========================================================================*/
int ifnFormatoUnico()
{
/*---------------------------------------------------------------------------*/
/* Definicion de variables.                         		         		 */
/*---------------------------------------------------------------------------*/	    
char modulo[]="ifnFormatoUnico";
char szNombreCliente [51];
int	 iCon     = 0;
char szMontoFin      [18];
char szOperadora      [4] ;
/*---------------------------------------------------------------------------*/
/* Definicion de variables para ser usadas con	Oracle.		         		 */
/*---------------------------------------------------------------------------*/	    
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long lhCodCliente          ; 
	char szhCodBanco       [16]; /* EXEC SQL VAR szhCodBanco       IS STRING(16); */ 
			
   char szhNombreCliente  [51]; /* EXEC SQL VAR szhNombreCliente    IS STRING(51) ; */ 

	long lhCodCuenta       [9] ;
	long lhCod_Cliente         ;
	char szhOperadora      [4] ; /* EXEC SQL VAR szhOperadora      IS STRING(4) ; */ 
	
   char szhNombreUsuario  [41]; /* EXEC SQL VAR szhNombreUsuario  IS STRING(41); */ 

   char szhNumRFC         [21]; /* EXEC SQL VAR szhNumRFC         IS STRING(21); */ 

   char szhNum_ctacorr    [19]; /* EXEC SQL VAR szhNum_ctacorr    IS STRING(19); */ 

   char szhNum_Tarjeta    [19]; /* EXEC SQL VAR szhNum_Tarjeta    IS STRING(19); */ 

   char szTip_Cuenta      [2];
   int  ihCod_sispago         ;
   long lhNumCelular   ;
   char szhNumContrato  [22]; /* EXEC SQL VAR szhNumContrato  IS STRING(22); */ 

   char szhFecVenTarj   [07]; /* EXEC SQL VAR szhFecVenTarj   IS STRING(07); */ 

   char szhCodRegion    [04]; /* EXEC SQL VAR szhCodRegion    IS STRING(04); */ 

   char szhTipoDocIdent     [02]; /* EXEC SQL VAR szhTipoDocIdent     IS STRING(02); */ 

   char szhTipTarjeta     [04]; /* EXEC SQL VAR szhTipTarjeta     IS STRING(04); */ 

   long lhFecVenTarj  ;
   char szhTipTarj     [04]; /* EXEC SQL VAR szhTipTarj     IS STRING(04); */ 

/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog(modulo,"\n\tEn Funcion ifnFormatoUnico()",LOG03);
	lCuentaRegUnico++;
	lhCod_Cliente = stListaAux->lCod_cliente;
	
	/*strcpy(szhOperadora, pszOperadora);*/
	
        memset(&szhNombreCliente,'\0',sizeof(szhNombreCliente));        
        memset(&szhNumRFC,'\0',sizeof(szhNumRFC));
        memset(&szhNum_ctacorr,'\0',sizeof(szhNum_ctacorr));
        memset(&szTip_Cuenta,'\0',sizeof(szTip_Cuenta));
        memset(&szhFecVenTarj,'\0',sizeof(szhFecVenTarj));
        memset(&szhCodBanco,'\0',sizeof(szhCodBanco));
        memset(&szhNum_Tarjeta,'\0',sizeof(szhNum_Tarjeta));
        memset(&szhNumContrato,'\0',sizeof(szhNumContrato));
        memset(&szhCodRegion,'\0',sizeof(szhCodRegion));
        memset(&szhTipTarjeta,'\0',sizeof(szhTipTarjeta));
        memset(&szhOperadora,'\0',sizeof(szhOperadora));
        lhNumCelular=0;
        vDTrazasLog(modulo,"\n\t lhCod_Cliente  [%ld]",LOG07,lhCod_Cliente);
        
        
	/* EXEC SQL
	SELECT 	   NVL(A.NOM_CLIENTE||:szhFiller||A.NOM_APECLIEN1||:szhFiller||A.NOM_APECLIEN2,:szhFiller), 			 
		   A.COD_CLIENTE    , 
		   A.NUM_IDENT      ,
		   NVL(A.NUM_CTACORR,:szhFiller),
		   NVL(A.NUM_TARJETA,:szhFiller),
		   NVL(A.COD_SISPAGO,:ihValor_Cero),
		   NVL(A.IND_TIPCUENTA,:szhFiller),
		   NVL(TO_CHAR(A.FEC_VENCITARJ,:szhyyyymm),:szhFiller),
		   DECODE(A.COD_SISPAGO,:ihValor_tres,A.COD_BANCO,:ihValor_cuatro,A.COD_BANCOTARJ,:szhFiller) AS COD_BANCO_SIS,
		   NVL(A.COD_TIPTARJETA,:szhFiller),
		   SUBSTR(A.COD_OPERADORA,:ihValor_uno,:ihValor_tres)		   
	INTO  	   :szhNombreCliente,  		   
		   :lhCodCliente    ,
		   :szhNumRFC	    ,
		   :szhNum_ctacorr  ,
		   :szhNum_Tarjeta  ,
		   :ihCod_sispago   ,
		   :szTip_Cuenta    ,
		   :szhFecVenTarj   ,
		   :szhCodBanco     ,
		   :szhTipTarjeta ,
		   :szhOperadora                   
	FROM  GE_CLIENTES A
   	WHERE A.COD_CLIENTE  = :lhCod_Cliente
  	AND   A.FEC_BAJA    IS NULL 
	AND   A.COD_TIPIDENT = :szhZeroUno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NVL(((((A.NOM_CLIENTE||:b0)||A.NOM_APECLIEN1)||:b0)||\
A.NOM_APECLIEN2),:b0) ,A.COD_CLIENTE ,A.NUM_IDENT ,NVL(A.NUM_CTACORR,:b0) ,NVL\
(A.NUM_TARJETA,:b0) ,NVL(A.COD_SISPAGO,:b5) ,NVL(A.IND_TIPCUENTA,:b0) ,NVL(TO_\
CHAR(A.FEC_VENCITARJ,:b7),:b0) ,DECODE(A.COD_SISPAGO,:b9,A.COD_BANCO,:b10,A.CO\
D_BANCOTARJ,:b0) COD_BANCO_SIS ,NVL(A.COD_TIPTARJETA,:b0) ,SUBSTR(A.COD_OPERAD\
ORA,:b13,:b9) into :b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b24,:b25  fro\
m GE_CLIENTES A where ((A.COD_CLIENTE=:b26 and A.FEC_BAJA is null ) and A.COD_\
TIPIDENT=:b27)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )253;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[0] = (unsigned long )2;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[2] = (unsigned long )2;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhyyyymm;
 sqlstm.sqhstl[7] = (unsigned long )7;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[8] = (unsigned long )2;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_tres;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_cuatro;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[11] = (unsigned long )2;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhFiller;
 sqlstm.sqhstl[12] = (unsigned long )2;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&ihValor_tres;
 sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)szhNombreCliente;
 sqlstm.sqhstl[15] = (unsigned long )51;
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
 sqlstm.sqhstv[17] = (unsigned char  *)szhNumRFC;
 sqlstm.sqhstl[17] = (unsigned long )21;
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)szhNum_ctacorr;
 sqlstm.sqhstl[18] = (unsigned long )19;
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)szhNum_Tarjeta;
 sqlstm.sqhstl[19] = (unsigned long )19;
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)0;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)&ihCod_sispago;
 sqlstm.sqhstl[20] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)0;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)szTip_Cuenta;
 sqlstm.sqhstl[21] = (unsigned long )2;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)szhFecVenTarj;
 sqlstm.sqhstl[22] = (unsigned long )7;
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)0;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)szhCodBanco;
 sqlstm.sqhstl[23] = (unsigned long )16;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)0;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
 sqlstm.sqhstv[24] = (unsigned char  *)szhTipTarjeta;
 sqlstm.sqhstl[24] = (unsigned long )4;
 sqlstm.sqhsts[24] = (         int  )0;
 sqlstm.sqindv[24] = (         short *)0;
 sqlstm.sqinds[24] = (         int  )0;
 sqlstm.sqharm[24] = (unsigned long )0;
 sqlstm.sqadto[24] = (unsigned short )0;
 sqlstm.sqtdso[24] = (unsigned short )0;
 sqlstm.sqhstv[25] = (unsigned char  *)szhOperadora;
 sqlstm.sqhstl[25] = (unsigned long )4;
 sqlstm.sqhsts[25] = (         int  )0;
 sqlstm.sqindv[25] = (         short *)0;
 sqlstm.sqinds[25] = (         int  )0;
 sqlstm.sqharm[25] = (unsigned long )0;
 sqlstm.sqadto[25] = (unsigned short )0;
 sqlstm.sqtdso[25] = (unsigned short )0;
 sqlstm.sqhstv[26] = (unsigned char  *)&lhCod_Cliente;
 sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[26] = (         int  )0;
 sqlstm.sqindv[26] = (         short *)0;
 sqlstm.sqinds[26] = (         int  )0;
 sqlstm.sqharm[26] = (unsigned long )0;
 sqlstm.sqadto[26] = (unsigned short )0;
 sqlstm.sqtdso[26] = (unsigned short )0;
 sqlstm.sqhstv[27] = (unsigned char  *)szhZeroUno;
 sqlstm.sqhstl[27] = (unsigned long )3;
 sqlstm.sqhsts[27] = (         int  )0;
 sqlstm.sqindv[27] = (         short *)0;
 sqlstm.sqinds[27] = (         int  )0;
 sqlstm.sqharm[27] = (unsigned long )0;
 sqlstm.sqadto[27] = (unsigned short )0;
 sqlstm.sqtdso[27] = (unsigned short )0;
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

	
	
   	if( SQLCODE != SQLOK  )  	{ 
   	    vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Clientes Unico : \n\t%s", LOG01, SQLERRM);
   	    vDTrazasError( modulo,	"\t No se genera registro para Codigo Cliente : %ld", LOG01, lhCod_Cliente);		
   	    return 0;
   	}
   	
        /* EXEC SQL
        SELECT NVL(A.NUM_CELULAR,:ihValor_Cero),
               NVL(A.NUM_CONTRATO,:szhFiller),
               NVL(A.COD_REGION,:szhFiller)               
        INTO  :lhNumCelular, :szhNumContrato,
              :szhCodRegion
        FROM  GA_ABOCEL A , (SELECT MAX(GA.FEC_ALTA) AS FEC_ALTA
                              FROM GA_ABOCEL GA
                             WHERE GA.COD_CLIENTE  = :lhCod_Cliente
                               AND GA.COD_SITUACION = :szhAAA) B
        WHERE A.COD_CLIENTE  = :lhCod_Cliente
          AND A.COD_SITUACION = :szhAAA
          AND A.COD_PRODUCTO  = :ihValor_uno
          AND A.FEC_ALTA = B.FEC_ALTA; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 28;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NVL(A.NUM_CELULAR,:b0) ,NVL(A.NUM_CONTRATO,:b1\
) ,NVL(A.COD_REGION,:b1) into :b3,:b4,:b5  from GA_ABOCEL A ,(select max(GA.FE\
C_ALTA) FEC_ALTA  from GA_ABOCEL GA where (GA.COD_CLIENTE=:b6 and GA.COD_SITUA\
CION=:b7)) B where (((A.COD_CLIENTE=:b6 and A.COD_SITUACION=:b7) and A.COD_PRO\
DUCTO=:b10) and A.FEC_ALTA=B.FEC_ALTA)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )380;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFiller;
        sqlstm.sqhstl[1] = (unsigned long )2;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFiller;
        sqlstm.sqhstl[2] = (unsigned long )2;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumCelular;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhNumContrato;
        sqlstm.sqhstl[4] = (unsigned long )22;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodRegion;
        sqlstm.sqhstl[5] = (unsigned long )4;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_Cliente;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhAAA;
        sqlstm.sqhstl[7] = (unsigned long )4;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCod_Cliente;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szhAAA;
        sqlstm.sqhstl[9] = (unsigned long )4;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_uno;
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

        
        if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
    	vDTrazasError( modulo,	"\n\n\tError en SELECT Ga_Abocel Unico : \n\t%s", LOG01, SQLERRM);
    	return -1;
   	}   	
   	
        /* EXEC SQL
        SELECT NVL(IND_PERTRIB,:szhFiller)               
        INTO  :szhTipoDocIdent
        FROM  GE_TIPIDENT
        WHERE COD_TIPIDENT  = :szhZeroUno; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 28;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select NVL(IND_PERTRIB,:b0) into :b1  from GE_TIPIDEN\
T where COD_TIPIDENT=:b2";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )439;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFiller;
        sqlstm.sqhstl[0] = (unsigned long )2;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhTipoDocIdent;
        sqlstm.sqhstl[1] = (unsigned long )2;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhZeroUno;
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

        
        if( SQLCODE != SQLOK && SQLCODE != NOTFOUND )  	{
    	vDTrazasError( modulo,	"\n\n\tError en SELECT Ge_Tipident Unico : \n\t%s", LOG01, SQLERRM);
    	return -1;
   	}
        
	memset(&szNombreCliente,'\0',sizeof(szNombreCliente));
   	strncpy(szNombreCliente,&szhNombreCliente[0],50);
   	szNombreCliente[strlen(szNombreCliente)]='\0';
	
	if (ihCod_sispago==ihValor_cuatro){ 
		strcpy(szTip_Cuenta,"T");
	}	
	
	vDTrazasLog(modulo,"\t szTip_Cuenta     [%s]",LOG07,szTip_Cuenta);
	vDTrazasLog(modulo,"\t szhNum_Tarjeta   [%s]",LOG07,szhNum_Tarjeta);
	vDTrazasLog(modulo,"\t szhNum_ctacorr   [%s]",LOG07,szhNum_ctacorr);
	RighTrim(szhNum_ctacorr);
	if (strlen(szhNum_ctacorr)==0) {
		vDTrazasLog(modulo,"Numero de Cuenta Corriente o Numero de Tarjeta no esta Registrado en Ge_Clientes.",LOG02);
	 	return 0; 
	}
	
   
   vDTrazasLog(modulo,  "\t stListaAux->dMonto_pagar   [%.4f]  ",LOG07,stListaAux->dMonto_pagar);

   
	strncpy(szOperadora ,szhOperadora,3);
	vDTrazasLog(modulo,  "\t szhOperadora                          [%03s]  ",LOG07,szhOperadora);   
	vDTrazasLog(modulo,  "\t szhNombreCliente                      [%50s]  ",LOG07,szhNombreCliente);   
	vDTrazasLog(modulo,  "\t szhCodBanco                           [%15s]  ",LOG07,szhCodBanco);
	vDTrazasLog(modulo,  "\t lhCod_Cliente                        [%08ld]  ",LOG07,lhCod_Cliente);
	
	vDTrazasLog(modulo,  "\t stListaAux->szCod_TipDocum              [%s]  ",LOG07,stListaAux->szCod_TipDocum);
	vDTrazasLog(modulo,  "\t lhNumCelular                           [%ld]  ",LOG07,lhNumCelular);
	vDTrazasLog(modulo,  "\t szhNumIdent                            [%s]  ",LOG07,szhNumRFC);
	
	vDTrazasLog(modulo,  "\t stListaAux->lNum_folio                 [%ld]  ",LOG07,stListaAux->lNum_folio);
	vDTrazasLog(modulo,  "\t szhFecVenTarj                           [%s]  ",LOG07,szhFecVenTarj);
	vDTrazasLog(modulo,  "\t largo szhNombreCliente                 [%ld]  ",LOG07,strlen(szhNombreCliente));
	vDTrazasLog(modulo,  "\t szhTipTarjeta                           [%s]  ",LOG07,szhTipTarjeta);
	vDTrazasLog(modulo,  "\t szhFecVenTarj                           [%s]  ",LOG07,szhFecVenTarj);

  
	/* registro detalle */	
   if( (fprintf( FichBancos, "%03s%10sR%15ld%08ld%-50.50s%-20.20s%015ld%21s%1s%-3.3s%18s%11s%18s%6s%6s%03s%01s%02ldUSD%09ld%15s%15s%15s%15s%15s%015.04f\n"
     					 ,szhOperadora
     					 ,szhFecha_ddmmyyyy
     					 ,atol(stListaAux->szCodBanco)
     					 ,lhCod_Cliente 								 	 
					 	 ,szNombreCliente
					 	 ,szhNumRFC 
					 	 ,lhNumCelular
					    ,szhNumContrato
					    ,szTip_Cuenta
					    ,szhTipTarjeta
					    ,szhNum_ctacorr
					    ,szhFiller
					    ,szhNum_Tarjeta
					    ,szhFiller
				       ,szhFecVenTarj	 
				       ,szhCodRegion
				       ,szhTipoDocIdent
				       ,atol(stListaAux->szCod_TipDocum)
				       ,stListaAux->lNum_folio
				       ,szhFiller
				       ,szhFiller
				       ,szFiller
				       ,szhFiller
				       ,szhFiller
           			 ,stListaAux->dMonto_pagar					 
           			            )   ) == -1 )
	{	
			vDTrazasError(modulo,"Error al Escribir en Fichero con Banco [%d]",LOG01,atoi(stListaAux->szCodBanco));
			return -1; 
	}
	lNumOperaciones++;
	vDTrazasLog(modulo,"\n\t%ld Registro generado.",LOG03,lNumOperaciones);
	return 0;

}/*ifnFormatoUnico*/

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
   vDTrazasLog(modulo,"\t=> Ordenando [%s] .\n\n\n",LOG07, szComando);
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

/*===========================================================================*/
/* Tratamiento de Fecha para ser utilizada en nombre de archivos             */
/*===========================================================================*/
char* cfnGetTimePac()
{
	int i;
	char c[255] = "";
	char a[255] = "";
	time_t ltime;
	
	time(&ltime);
	
	strcpy(c,ctime(&ltime));
	
	for( i = 22; i < 24; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i =  4; i <  7; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i =  8; i < 10; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	strcat(a,"_");
	
	for( i = 11; i < 13; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i = 14; i < 16; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	for( i = 17; i < 19; i++ )
		sprintf(a, "%s%c", a, ((c[i] == ' ') ? '0' : c[i]));
	
	return (char*)a;
} /* cfnGetTimePac */
/*===========================================================================*/
/* Funcion: BOOL bfnDBUpdatePagospac(Lista_Pasoc  *pstPagos)                     */
/* Actualizamos la Tabla CO_PAGOSPAC IND_PROCESADO = 0 y COD_RESPUBANCO = NULL. */
/*===========================================================================*/
BOOL bfnDBUpdatePagospac()
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente     ; 	
    long lhNumFolio       ;
    int  ihRespubanco     ;
    int  ihValor_Cero  = 0;
    int  ihValor_Uno   = 1;
/* EXEC SQL END DECLARE SECTION; */ 

	
char modulo[]="bfnDBUpdatePagospac";
    lhCodCliente = stListaAux->lCod_cliente;
    lhNumFolio   = stListaAux->lNum_folio;
    ihRespubanco = stListaAux->iRespubanco;
    
    vDTrazasLog( modulo, "\n\t Inicio bfnDBUpdatePagospac()",LOG03);
    vDTrazasLog( modulo, "\t stListaAux->lCod_cliente  [%ld]",LOG03,stListaAux->lCod_cliente);
    vDTrazasLog( modulo, "\t stListaAux->lNum_folio    [%ld]",LOG03,stListaAux->lNum_folio);
    vDTrazasLog( modulo, "\t stListaAux->iRespubanco   [%ld]",LOG03,stListaAux->iRespubanco);
    
	/* EXEC SQL 
	UPDATE CO_PAGOSPAC SET	
	       IND_PROCESADO  = :ihValor_Cero,	
          COD_RESPUBANCO = NULL
	WHERE  COD_CLIENTE    = :lhCodCliente
	AND    NUM_FOLIO      = :lhNumFolio
	AND    COD_RESPUBANCO = :ihRespubanco
	AND    IND_PROCESADO  = :ihValor_Uno
	AND    IND_CANCELADO  = :ihValor_Cero; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 28;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_PAGOSPAC  set IND_PROCESADO=:b0,COD_RESPUBANCO=nul\
l  where ((((COD_CLIENTE=:b1 and NUM_FOLIO=:b2) and COD_RESPUBANCO=:b3) and IN\
D_PROCESADO=:b4) and IND_CANCELADO=:b0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )466;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihRespubanco;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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


	
   vDTrazasLog( modulo, "\n\t Paso Update CO_PAGOSPAC",LOG03);
	if (SQLCODE)  {
		iDError(modulo,ERR000,vInsertarIncidencia,"\t Al Hacer Update en CO_PAGOSPAC.\n\t\t\t\t ",SQLERRM);
		return FALSE;
	}
	else
		vDTrazasLog(modulo,"\t*Actualizacion de IND_PROCESADO y COD_RESPUBANCO en CO_PAGOSPAC",LOG05);
	return TRUE;
}/* bfnDBUpdatePagospac */
