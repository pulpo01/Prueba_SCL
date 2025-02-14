
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned long magic;
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
    "./pc/Co_Intmorciclo.pc"
};


static unsigned long sqlctx = 221202675;


static struct sqlexd {
   unsigned int   sqlvsn;
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
            void  **sqphsv;
   unsigned int   *sqphsl;
            int   *sqphss;
            void  **sqpind;
            int   *sqpins;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
            void  *sqhstv[26];
   unsigned int   sqhstl[26];
            int   sqhsts[26];
            void  *sqindv[26];
            int   sqinds[26];
   unsigned int   sqharm[26];
   unsigned int   *sqharc[26];
   unsigned short  sqadto[26];
   unsigned short  sqtdso[26];
} sqlstm = {10,26};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned long *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

 static char *sq0013 = 
"select A.COD_CLIENTE ,A.NUM_SECUENCI ,A.COD_TIPDOCUM ,A.NUM_FOLIO ,A.SEC_CUO\
TA ,A.PREF_PLAZA ,NVL(sum((A.IMPORTE_DEBE-A.IMPORTE_HABER)),:b0) ,TO_CHAR(SYSD\
ATE,:b1) ,A.COD_VENDEDOR_AGENTE ,A.COD_CENTREMI ,A.NUM_CUOTA ,A.LETRA  from CO\
_CARTERA A ,GE_CLIENTES B where (((((((A.COD_CLIENTE=B.COD_CLIENTE and A.COD_T\
IPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from CO_CODIGOS where (NOM_TABLA\
=:b2 and NOM_COLUMNA=:b3))) and A.COD_CONCEPTO not  in (:b4,:b5)) and A.FEC_VE\
NCIMIE<(SYSDATE-:b6)) and A.IND_FACTURADO=:b6) and B.COD_CICLO=:b8) and  not e\
xists (select COD_CLIENTE  from CO_INMUNIDAD where (COD_CLIENTE=B.COD_CLIENTE \
and SYSDATE between FEC_DESDE and FEC_HASTA))) and  not exists (select COD_CLI\
ENTE  from CO_CLIESINTER where (COD_CLIENTE=B.COD_CLIENTE and SYSDATE between \
FEC_DESDE and FEC_HASTA))) group by A.COD_CLIENTE,A.NUM_SECUENCI,A.COD_TIPDOCU\
M,A.NUM_FOLIO,A.SEC_CUOTA,A.PREF_PLAZA,A.COD_VENDEDOR_AGENTE,A.COD_CENTREMI,A.\
NUM_CUOTA,A.LETRA           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{10,4130,0,0,0,
5,0,0,1,60,0,6,212,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
28,0,0,2,66,0,4,240,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
51,0,0,3,82,0,4,271,0,0,3,1,0,1,0,2,97,0,0,2,5,0,0,1,3,0,0,
78,0,0,4,60,0,6,352,0,0,2,2,0,1,0,2,97,0,0,1,97,0,0,
101,0,0,5,63,0,4,438,0,0,1,0,0,1,0,2,5,0,0,
120,0,0,6,78,0,6,478,0,0,2,2,0,1,0,2,3,0,0,1,97,0,0,
143,0,0,7,54,0,4,507,0,0,1,0,0,1,0,2,3,0,0,
162,0,0,8,201,0,6,511,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,1,4,0,0,1,3,0,0,1,5,0,0,
213,0,0,9,158,0,4,578,0,0,9,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,2,4,0,0,2,
4,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
264,0,0,10,50,0,4,609,0,0,1,0,0,1,0,2,3,0,0,
283,0,0,11,160,0,6,621,0,0,8,8,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,97,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,
330,0,0,12,504,0,3,631,0,0,26,26,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,
3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,
449,0,0,13,962,0,9,724,0,0,9,9,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
500,0,0,13,0,0,13,733,0,0,12,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
563,0,0,13,0,0,15,804,0,0,0,0,0,1,0,
};


#line 1 "./pc/Co_Intmorciclo.pc"
/*==========================================================================================================
Nombre      : Co_Intmorciclo.pc
Programa    : Detalle de Transacciones Facturadas en Pasocobros.
Autor       : G.A.C.
Creado      : 22-Abril-2005 (COL)
==========================================================================================================*/

#include <deftypes.h>
#include <geora.h>
#include <ORAcarga.h>
#include <GenFA.h>
#include <genco.h>
#include <trazafact.h>
#include <New_Interfact.h>
#include "Co_Intmorciclo.h"
#include <errores.h>

/* EXEC SQL INCLUDE sqlca;
 */ 
#line 1 "/app/oracle/OraHome1/precomp/public/sqlca.h"
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
#line 1 "/app/oracle/OraHome1/precomp/public/sqlca.h"
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

#line 19 "./pc/Co_Intmorciclo.pc"

/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 20 "./pc/Co_Intmorciclo.pc"

	int   ihDecimal         ;
	char  szHoraIni        [11]; /* EXEC SQL VAR szHoraIni IS STRING(11); */ 
#line 22 "./pc/Co_Intmorciclo.pc"

	char  szhCod_Portadora [6]; /* EXEC SQL VAR szhCod_Portadora IS STRING(6); */ 
#line 23 "./pc/Co_Intmorciclo.pc"

	char  szhhhmiss  [11];
	int   ihCiclo ;
	char  szhCod_moneda [4];

/* EXEC SQL END DECLARE SECTION; */ 
#line 28 "./pc/Co_Intmorciclo.pc"

int   iDiffSeg = 0;
char  szHoraFin[9];
char  szTmpProc[9];
int   iTotalReg;

Lista_Pasoc pLista_Aux=NULL;
Lista_Pasoc stListaAux=NULL;

char szUsage[] = "\n\tUso : \n\tCo_Intmorciclo  -u [Usuario]/[Password]\n\t\t\t-l [Nivel de log. Por default es 3]\n\t\t\t-c [Ciclo de Facturacion]\n\n ";
 
int main( int argc, char* argv[] )
{
char modulo[]="main";
	
   memset (&stConfig,0,sizeof (CONFIG));
	memset( szHoraIni, '\0', sizeof( szHoraIni ) );
	strcpy(szhhhmiss,"HH24:MI:SS");

   if (argc < 3) {
   	fprintf (stdout,"\n\tFaltan parametros.\n%s",szUsage);
      fflush  (stdout);
      exit(1);
   }

   /*- Validacion de parametros de entrada -*/
   memset(&stConfig,0,sizeof(CONFIG));
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
			if (ifnIntmorciclo() != 0) {
		   	fprintf (stdout,"\n\tError >> Fallo Funcion Principal \n");
		   	fflush  (stdout);
			}
			else {
				if (ifnFinTrazaFacturacion()!=0) {
				fprintf (stdout,"\n\tError >> Fallo Funcion de Actualizacion de Traza \n");	
			}
		}

		}

		if( ifnExitIntmorciclo() != 0 ) {
			fprintf (stdout,"\n\tError >> Fallo Funcion de estadistica \n");
			fflush  (stdout);
		}


	}
	return 0;

}/* Fin main */


/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], CONFIG *pstLC )
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
int ifnConexionDB( CONFIG pstLC)
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
int ifnInicio (CONFIG pstConfig)
{
char modulo[]="ifnInicio";

	if (ifnConexionDB(pstConfig) != 0)   {
		fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
      fflush  (stdout);
      return -1;
	}

	/* Valida Parametro del Ciclo de Facturacion */
	if (ifnValidaCicloFact()!=0) return -1;
	/* Obtiene codigo de moneda */
	if (ifnObtieneMoneda()!=0) return -1;
	
	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraIni := TO_CHAR(SYSDATE,:szhhhmiss);
		END;
	END-EXEC; */ 
#line 216 "./pc/Co_Intmorciclo.pc"

{
#line 212 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 2;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "begin :szHoraIni := TO_CHAR ( SYSDATE , :szhhhmiss ) ; END ;";
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )5;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)szHoraIni;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )11;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)szhhhmiss;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )11;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 212 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 212 "./pc/Co_Intmorciclo.pc"
}

#line 216 "./pc/Co_Intmorciclo.pc"


	if (ifnPreparaArchivoLog()!=0) return -1;

	vDTrazasLog( modulo,
	"\n     **********************************************************************"
	"\n     * %s      Calculo Interes de Mora              HORA : %s  *"
	"\n     **********************************************************************\n", LOG03, szhVersion, szHoraIni );

	return 0;
}/* fin a ifnInicio */

/* ============================================================================= */
/* ifnValidaCicloFact(): Valida ciclo de facturacion y obtiene codigo de ciclo   */
/* ============================================================================= */
int ifnValidaCicloFact()
{
char modulo[]="ifnValidaCicloFact";
/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 234 "./pc/Co_Intmorciclo.pc"

	long  lhCicloFact ;
/* EXEC SQL END DECLARE SECTION; */ 
#line 236 "./pc/Co_Intmorciclo.pc"


	lhCicloFact=stConfig.lCodCicloFact;
	
	/* EXEC SQL
	SELECT COD_CICLO
	INTO   :ihCiclo
	FROM   FA_CICLFACT
	WHERE  COD_CICLFACT = :lhCicloFact; */ 
#line 244 "./pc/Co_Intmorciclo.pc"

{
#line 240 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 2;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "select COD_CICLO into :b0  from FA_CICLFACT where COD_CICLFA\
CT=:b1";
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )28;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.selerr = (unsigned short)1;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)&ihCiclo;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)&lhCicloFact;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 240 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 240 "./pc/Co_Intmorciclo.pc"
}

#line 244 "./pc/Co_Intmorciclo.pc"


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
/* ifnObtieneMoneda(): Obtiene codigo de moneda segun tip_valor = 1              */
/* ============================================================================= */
int ifnObtieneMoneda()
{
char modulo[]="ifnObtieneMoneda";
/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 266 "./pc/Co_Intmorciclo.pc"

	int  ihTip_valor = 1; 
	char szhDes_valor [21]; /* EXEC SQL VAR szhDes_valor IS STRING(21); */ 
#line 268 "./pc/Co_Intmorciclo.pc"

/* EXEC SQL END DECLARE SECTION; */ 
#line 269 "./pc/Co_Intmorciclo.pc"


	/* EXEC SQL
	SELECT COD_MONEDA    , DES_TIPVALOR
	INTO   :szhCod_moneda, :szhDes_valor
	FROM   CO_TIPVALOR
	WHERE  TIP_VALOR = :ihTip_valor; */ 
#line 275 "./pc/Co_Intmorciclo.pc"

{
#line 271 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 3;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "select COD_MONEDA ,DES_TIPVALOR into :b0,:b1  from CO_TIPVAL\
OR where TIP_VALOR=:b2";
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )51;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.selerr = (unsigned short)1;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)szhCod_moneda;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )4;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)szhDes_valor;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )21;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[2] = (         void  *)&ihTip_valor;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[2] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[2] = (         void  *)0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[2] = (         int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[2] = (unsigned int  )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[2] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[2] = (unsigned short )0;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 271 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 271 "./pc/Co_Intmorciclo.pc"
}

#line 275 "./pc/Co_Intmorciclo.pc"


	if( SQLCODE!=SQLOK ) {
		vDTrazasLog( modulo, "\tSELECT COD_MONEDA - %s", LOG00,SQLERRM );
		return -1;
	}

	fprintf(stderr, "==> Codigo de Moneda : [%s]  Descripcion : [%s]\n", szhCod_moneda,szhDes_valor);

	return 0;	
}


/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
char modulo[]="ifnPreparaArchivoLog";
char szhPathLogSched[256];

	strcpy(stConfig.szFileName,"Co_Intmorciclo");
	sprintf(szhPathLogSched,"%s/Co_Intmorciclo/",getenv("XPFACTUR_LOG"));
   sprintf(stConfig.szLogPathGene,"%s/%ld",szhPathLogSched,stConfig.lCodCicloFact);

   if (ifnAbreArchivoLog()!=0) return -1;

   return 0;

} /* end ifnPreparaArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
char modulo[]="ifnAbreArchivoLog";
char szArchivoLog[256]=""; /* log */
char szArchivoErr[256]=""; /* errores */
char szComando   [256]="";

   memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log */
   memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores */

   sprintf(szComando,"mkdir -p %s",stConfig.szLogPathGene);
   if (system (szComando)!=0)
   {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
   }
   sprintf(szArchivoLog,"%s/%s.log",stConfig.szLogPathGene,stConfig.szFileName);
   sprintf(szArchivoErr,"%s/%s.err",stConfig.szLogPathGene,stConfig.szFileName);
   if((stStatus.LogFile = fopen(szArchivoLog,"a")) == (FILE*)NULL )    {
        fprintf (stderr,"Error al crear archivo de Log\n");
        fflush  (stderr);
        return -1;
   }
   if((stStatus.ErrFile = fopen(szArchivoErr,"a")) == (FILE*)NULL )    {
        fprintf (stderr,"Error al crear archivo de Errores\n");
        fflush  (stderr);
        return -1;
   }
   return 0;

}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* Funcion : ifnExitIntmorciclo							                     */
/* ============================================================================= */
int ifnExitIntmorciclo (void)
{
char modulo[]="ifnExitIntmorciclo";

	/* Datos Fin de Tiempo */
	/* EXEC SQL EXECUTE
		BEGIN
			:szHoraFin := TO_CHAR(SYSDATE,:szhhhmiss);
		END;
	END-EXEC; */ 
#line 356 "./pc/Co_Intmorciclo.pc"

{
#line 352 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 3;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "begin :szHoraFin := TO_CHAR ( SYSDATE , :szhhhmiss ) ; END ;";
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )78;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)szHoraFin;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )9;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)szhhhmiss;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )11;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 352 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 352 "./pc/Co_Intmorciclo.pc"
}

#line 356 "./pc/Co_Intmorciclo.pc"


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
}/* fin a ifnExitIntmorciclo */


/* ============================================================================= */
/* ============================================================================= */
/* Inserta el elemento e en la lista ant */
/* Devuelve -1 si no hay memoria suficiente para la inserción. */
int ifnInsertaPasoc(Lista_Pasoc *ant)
{
	Lista_Pasoc p;
	if ((p=(struct INTERMORO *) malloc(sizeof(struct INTERMORO))) == NULL)
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
/* Carga el o los nombres de las operadoras					                        */
/* ============================================================================= */
int ifnCarga_Portadoras()
{
char modulo[]="ifnCarga_Portadoras";

	vDTrazasLog( modulo, "\n\tEn funcion [%s]", LOG03,modulo );
	memset( szhCod_Portadora, '\0', sizeof( szhCod_Portadora ) );

	/* EXEC SQL
	SELECT COD_OPERADORA_SCL
	INTO   :szhCod_Portadora
	FROM   GE_OPERADORA_SCL_LOCAL; */ 
#line 441 "./pc/Co_Intmorciclo.pc"

{
#line 438 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 3;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "select COD_OPERADORA_SCL into :b0  from GE_OPERADORA_SCL_LOC\
AL ";
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )101;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.selerr = (unsigned short)1;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)szhCod_Portadora;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )6;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 438 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 438 "./pc/Co_Intmorciclo.pc"
}

#line 441 "./pc/Co_Intmorciclo.pc"

	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tSELECT COD_OPERADORA_SCL - %s", LOG00,SQLERRM );
		return -1;
	}

	vDTrazasLog( modulo, "\tszhCod_Portadora  [%s]", LOG03, szhCod_Portadora);
	return 0;
}/* fin a ifnCarga_Portadoras */

/* ============================================================================= */
/* Genera listas enlazadas,                                                      */
/* ============================================================================= */
int ifnIntmorciclo()
{
char modulo[]="ifnIntmorciclo";
/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 457 "./pc/Co_Intmorciclo.pc"

	long   lhCod_cliente     ;
	long   lhNum_secuenci    ;
	int    ihCod_tipdocum    ;
	long   lhNum_folio       ;
	int    ihSec_cuota       ;
	double dhMonto_pagar     ;
	char   szhPref_plaza [11]; /* EXEC SQL VAR szhPref_plaza IS STRING(11); */ 
#line 464 "./pc/Co_Intmorciclo.pc"

	char   szhFec_Sydate [11]; /* EXEC SQL VAR szhFec_Sydate IS STRING(11); */ 
#line 465 "./pc/Co_Intmorciclo.pc"

	char   szhNombrePL   [50]; /* EXEC SQL VAR szhNombrePL IS STRING(50); */ 
#line 466 "./pc/Co_Intmorciclo.pc"

	char   szEjecuta_PL [750];

	char   szhNum_decimal  [12];
	int    ihValor_cero    = 0 ;
	int    ihValor_uno     = 1 ;
	long   lhSecu_transac      ;
/* EXEC SQL END DECLARE SECTION; */ 
#line 473 "./pc/Co_Intmorciclo.pc"


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	strcpy(szhNum_decimal,"num_decimal");

	/* EXEC SQL EXECUTE
		BEGIN
			:ihDecimal := GE_PAC_GENERAL.PARAM_GENERAL( :szhNum_decimal );
		END;
	END-EXEC; */ 
#line 482 "./pc/Co_Intmorciclo.pc"

{
#line 478 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 3;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "begin :ihDecimal := GE_PAC_GENERAL . PARAM_GENERAL ( :szhNum\
_decimal ) ; END ;";
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )120;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)&ihDecimal;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)szhNum_decimal;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )12;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 478 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 478 "./pc/Co_Intmorciclo.pc"
}

#line 482 "./pc/Co_Intmorciclo.pc"


	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tGE_PAC_GENERAL.PARAM_GENERAL( 'num_decimal' ) - %s", LOG00,SQLERRM );
		return -1;
	}

	if (ifnTrazaFacturacion()!=0) return -1;
	if (ifnCarga_Portadoras()!=0) return -1;
	if (ifnCargaListaQuery()!=0) return -1;
	
	if (iTotalReg > 0 )
	{
		stListaAux=pLista_Aux;
     	while (stListaAux!= NULL)
	   {
         lhCod_cliente =stListaAux->lCod_cliente ;
         lhNum_secuenci=stListaAux->lNum_secuenci;
         ihCod_tipdocum=stListaAux->iCod_tipdocum;
         lhNum_folio   =stListaAux->lNum_folio   ;
         ihSec_cuota   =stListaAux->iSec_cuota   ;
         dhMonto_pagar =stListaAux->dMonto_pagar ;
         strcpy(szhPref_plaza,stListaAux->szPref_plaza);
         strcpy(szhFec_Sydate,stListaAux->szFec_Sydate);
			
			/* EXEC SQL SELECT CO_SEQ_TRANSACINT.NEXTVAL INTO :lhSecu_transac FROM DUAL; */ 
#line 507 "./pc/Co_Intmorciclo.pc"

{
#line 507 "./pc/Co_Intmorciclo.pc"
   struct sqlexd sqlstm;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlvsn = 10;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.arrsiz = 3;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqladtp = &sqladt;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqltdsp = &sqltds;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.stmt = "select CO_SEQ_TRANSACINT.nextval  into :b0  from DUAL ";
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.iters = (unsigned int  )1;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.offset = (unsigned int  )143;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.selerr = (unsigned short)1;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.cud = sqlcud0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlety = (unsigned short)256;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.occurs = (unsigned int  )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[0] = (         void  *)&lhSecu_transac;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[0] = (         int  )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[0] = (         void  *)0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[0] = (         int  )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[0] = (unsigned int  )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[0] = (unsigned short )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[0] = (unsigned short )0;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphsv = sqlstm.sqhstv;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphsl = sqlstm.sqhstl;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphss = sqlstm.sqhsts;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpind = sqlstm.sqindv;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpins = sqlstm.sqinds;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqparm = sqlstm.sqharm;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqparc = sqlstm.sqharc;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpadto = sqlstm.sqadto;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqptdso = sqlstm.sqtdso;
#line 507 "./pc/Co_Intmorciclo.pc"
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 507 "./pc/Co_Intmorciclo.pc"
}

#line 507 "./pc/Co_Intmorciclo.pc"


			vDTrazasLog( modulo, "\tEjecuta Package [CO_INTERESMORA_PG.CO_CALCULO_PR]", LOG05);

			/* EXEC SQL EXECUTE
				BEGIN
					CO_INTERESMORA_PG.CO_CALCULO_PR(:lhSecu_transac, :lhCod_cliente, :lhNum_folio, :szhPref_plaza, :lhNum_secuenci, :ihCod_tipdocum, :dhMonto_pagar, :ihSec_cuota, :szhFec_Sydate);
				END;
			END-EXEC; */ 
#line 515 "./pc/Co_Intmorciclo.pc"

{
#line 511 "./pc/Co_Intmorciclo.pc"
   struct sqlexd sqlstm;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlvsn = 10;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.arrsiz = 9;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqladtp = &sqladt;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqltdsp = &sqltds;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.stmt = "begin CO_INTERESMORA_PG . CO_CALCULO_PR ( :lhSecu_transac \
, :lhCod_cliente , :lhNum_folio , :szhPref_plaza , :lhNum_secuenci , :ihCod_ti\
pdocum , :dhMonto_pagar , :ihSec_cuota , :szhFec_Sydate ) ; END ;";
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.iters = (unsigned int  )1;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.offset = (unsigned int  )162;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.cud = sqlcud0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqlety = (unsigned short)256;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.occurs = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[0] = (         void  *)&lhSecu_transac;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[0] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[0] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[0] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[0] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[0] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[0] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[1] = (         void  *)&lhCod_cliente;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[1] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[1] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[1] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[1] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[1] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[1] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[2] = (         void  *)&lhNum_folio;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[2] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[2] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[2] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[2] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[2] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[2] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[3] = (         void  *)szhPref_plaza;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[3] = (unsigned int  )11;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[3] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[3] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[3] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[3] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[3] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[3] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[4] = (         void  *)&lhNum_secuenci;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[4] = (unsigned int  )sizeof(long);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[4] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[4] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[4] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[4] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[4] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[4] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[5] = (         void  *)&ihCod_tipdocum;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[5] = (unsigned int  )sizeof(int);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[5] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[5] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[5] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[5] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[5] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[5] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[6] = (         void  *)&dhMonto_pagar;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[6] = (unsigned int  )sizeof(double);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[6] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[6] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[6] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[6] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[6] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[6] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[7] = (         void  *)&ihSec_cuota;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[7] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[7] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[7] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[7] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[7] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[7] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstv[8] = (         void  *)szhFec_Sydate;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhstl[8] = (unsigned int  )11;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqhsts[8] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqindv[8] = (         void  *)0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqinds[8] = (         int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqharm[8] = (unsigned int  )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqadto[8] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqtdso[8] = (unsigned short )0;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphsv = sqlstm.sqhstv;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphsl = sqlstm.sqhstl;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqphss = sqlstm.sqhsts;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpind = sqlstm.sqindv;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpins = sqlstm.sqinds;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqparm = sqlstm.sqharm;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqparc = sqlstm.sqharc;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqpadto = sqlstm.sqadto;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlstm.sqptdso = sqlstm.sqtdso;
#line 511 "./pc/Co_Intmorciclo.pc"
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 511 "./pc/Co_Intmorciclo.pc"
}

#line 515 "./pc/Co_Intmorciclo.pc"

			if( SQLCODE!=SQLOK ) 	{
				vDTrazasLog( modulo, "\tEXECUTE CO_INTERESMORA_PG	 - %s", LOG00,SQLERRM );
				return -1;
			}

			if (ifnGeneraCargos(lhSecu_transac)!=0) return -1;
			stListaAux=stListaAux->sig;

		}
	}
	else
	{
		vDTrazasLog( modulo, "\tNo existen Documentos Vencidos Impagos...Sorry man", LOG02);
	}

	vDTrazasLog( modulo, "\tFin a funcion %s", LOG03, modulo );
	vfnBorraListaPasoc( &pLista_Aux );

	return 0;

}/* Fin ifnIntmorciclo */


/* ============================================================================= */
/* Valida generacion de cargos                                                   */
/* ============================================================================= */
int ifnGeneraCargos(long lSecuencia)
{
char modulo[]="ifnGeneraCargos";
/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 545 "./pc/Co_Intmorciclo.pc"

	double dhImp_Cargo      ;
	double dhFac_cobro      ;
	int    ihDiasint        ;
	int    ihConc_Mora      ;
	long   lhSecuencia      ;
	long   lhSecuCargo      ;
                           
	long   lhCod_cliente    ;
	long   lhNum_secuenci   ;
	int    ihCod_tipdocum   ;
	long   lhNum_folio      ;
	int    ihSec_cuota      ;
	double dhMonto_pagar    ;    
	char   szhPref_plaza[11];
	int    ihCod_vendedor   ;
	int    ihCod_centremi   ;
	int    ihNum_cuota      ;
	char   szhLetra      [2];
	long   lhCod_ciclfact   ;
	
	int    ihNum_abonado = 0;
	int    ihCod_producto= 5;
	int    ihValor_cero  = 0;
	char   szhModulo     [4];
/* EXEC SQL END DECLARE SECTION; */ 
#line 570 "./pc/Co_Intmorciclo.pc"


	vDTrazasLog( modulo, "\tEn funcion %s", LOG05,modulo);
	vDTrazasLog( modulo, "\tlhSecuencia [%ld]", LOG05,lSecuencia);
	lhSecuencia=lSecuencia;
	lhCod_ciclfact=stConfig.lCodCicloFact;
	strcpy(szhModulo,"IMC");
	
	/* EXEC SQL
	SELECT NVL(MTO_INTERESES,:ihValor_cero),	
	       NVL(FAC_COBRO,:ihValor_cero),	
	       NVL(NUM_DIAS,:ihValor_cero) , 
	       NVL(COD_CONCFACT,:ihValor_cero)
	INTO 	 :dhImp_Cargo  ,
	       :dhFac_cobro  , 
	       :ihDiasint    ,
	       :ihConc_Mora
	FROM   CO_TRANSACINT 
	WHERE  NUM_TRANSACCION = :lhSecuencia; */ 
#line 588 "./pc/Co_Intmorciclo.pc"

{
#line 578 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 9;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = "select NVL(MTO_INTERESES,:b0) ,NVL(FAC_COBRO,:b0) ,NVL(NUM_D\
IAS,:b0) ,NVL(COD_CONCFACT,:b0) into :b4,:b5,:b6,:b7  from CO_TRANSACINT where\
 NUM_TRANSACCION=:b8";
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )213;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.selerr = (unsigned short)1;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)&ihValor_cero;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)&ihValor_cero;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[2] = (         void  *)&ihValor_cero;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[2] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[2] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[2] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[2] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[2] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[2] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[3] = (         void  *)&ihValor_cero;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[3] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[3] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[3] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[3] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[3] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[3] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[3] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[4] = (         void  *)&dhImp_Cargo;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[4] = (unsigned int  )sizeof(double);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[4] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[4] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[4] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[4] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[4] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[4] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[5] = (         void  *)&dhFac_cobro;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[5] = (unsigned int  )sizeof(double);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[5] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[5] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[5] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[5] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[5] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[5] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[6] = (         void  *)&ihDiasint;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[6] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[6] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[6] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[6] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[6] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[6] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[6] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[7] = (         void  *)&ihConc_Mora;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[7] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[7] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[7] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[7] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[7] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[7] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[8] = (         void  *)&lhSecuencia;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[8] = (unsigned int  )sizeof(long);
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[8] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[8] = (         void  *)0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[8] = (         int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[8] = (unsigned int  )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[8] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[8] = (unsigned short )0;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 578 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 578 "./pc/Co_Intmorciclo.pc"
}

#line 588 "./pc/Co_Intmorciclo.pc"


	if( SQLCODE!=SQLOK ) 	{
		vDTrazasLog( modulo, "\tSELECT MTO_INTERESES - %s", LOG00,SQLERRM );
		return -1;
	}
	
	if (dhImp_Cargo > 0 ) {
		
		lhCod_cliente =stListaAux->lCod_cliente;
		lhNum_secuenci=stListaAux->lNum_secuenci;
	   ihCod_tipdocum=stListaAux->iCod_tipdocum;
	   lhNum_folio   =stListaAux->lNum_folio ;
	   ihSec_cuota   =stListaAux->iSec_cuota ;
	   dhMonto_pagar =stListaAux->dMonto_pagar;    
		ihCod_vendedor=stListaAux->iCod_vendedor;
		ihCod_centremi=stListaAux->iCod_centremi;
		ihNum_cuota   =stListaAux->iNum_cuota;
		strcpy(szhLetra , stListaAux->szLetra);
	   strcpy(szhPref_plaza , stListaAux->szPref_plaza);

		/* EXEC SQL SELECT GE_SEQ_CARGOS.NEXTVAL	INTO :lhSecuCargo FROM DUAL; */ 
#line 609 "./pc/Co_Intmorciclo.pc"

{
#line 609 "./pc/Co_Intmorciclo.pc"
  struct sqlexd sqlstm;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlvsn = 10;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.arrsiz = 9;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqladtp = &sqladt;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqltdsp = &sqltds;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.stmt = "select GE_SEQ_CARGOS.nextval  into :b0  from DUAL ";
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.iters = (unsigned int  )1;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.offset = (unsigned int  )264;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.selerr = (unsigned short)1;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.cud = sqlcud0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhSecuCargo;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 609 "./pc/Co_Intmorciclo.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 609 "./pc/Co_Intmorciclo.pc"
}

#line 609 "./pc/Co_Intmorciclo.pc"

		
		vDTrazasLog( modulo, "\t Generando Cargos :", LOG03);
		vDTrazasLog( modulo, "\t lhCod_cliente   [%ld]", LOG03,lhCod_cliente);
		vDTrazasLog( modulo, "\t lhNum_folio     [%ld]", LOG03,lhNum_folio);
		vDTrazasLog( modulo, "\t lhNum_secuenci  [%ld]", LOG07,lhNum_secuenci);
		vDTrazasLog( modulo, "\t lhSecuCargo     [%ld]", LOG07,lhSecuCargo);
		vDTrazasLog( modulo, "\t dhImp_Cargo     [%f]", LOG07,dhImp_Cargo);
		vDTrazasLog( modulo, "\t dhFac_cobro     [%f]", LOG07,dhFac_cobro);
		vDTrazasLog( modulo, "\t ihDiasint       [%d]", LOG07,ihDiasint);
		vDTrazasLog( modulo, "\t ihConc_Mora     [%d]\n", LOG07,ihConc_Mora);

		/* EXEC SQL EXECUTE 
			BEGIN
				CO_GEN_CARGO(:lhCod_cliente, :ihNum_abonado, :ihConc_Mora , :dhImp_Cargo, :szhCod_moneda, :ihCod_producto, :lhSecuCargo, :lhCod_ciclfact);
			END;
		END-EXEC; */ 
#line 625 "./pc/Co_Intmorciclo.pc"

{
#line 621 "./pc/Co_Intmorciclo.pc"
  struct sqlexd sqlstm;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlvsn = 10;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.arrsiz = 9;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqladtp = &sqladt;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqltdsp = &sqltds;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.stmt = "begin CO_GEN_CARGO ( :lhCod_cliente , :ihNum_abonado , :ihC\
onc_Mora , :dhImp_Cargo , :szhCod_moneda , :ihCod_producto , :lhSecuCargo , :l\
hCod_ciclfact ) ; END ;";
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.iters = (unsigned int  )1;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.offset = (unsigned int  )283;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.cud = sqlcud0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhCod_cliente;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[1] = (         void  *)&ihNum_abonado;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(int);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[2] = (         void  *)&ihConc_Mora;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[3] = (         void  *)&dhImp_Cargo;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(double);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[4] = (         void  *)szhCod_moneda;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[4] = (unsigned int  )4;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[4] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[5] = (         void  *)&ihCod_producto;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[5] = (unsigned int  )sizeof(int);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[5] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[5] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[5] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[5] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[5] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[5] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[6] = (         void  *)&lhSecuCargo;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[6] = (unsigned int  )sizeof(long);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[6] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[6] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[6] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[6] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[6] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[6] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[7] = (         void  *)&lhCod_ciclfact;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[7] = (unsigned int  )sizeof(long);
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[7] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[7] = (         void  *)0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[7] = (         int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[7] = (unsigned int  )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[7] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[7] = (unsigned short )0;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 621 "./pc/Co_Intmorciclo.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 621 "./pc/Co_Intmorciclo.pc"
}

#line 625 "./pc/Co_Intmorciclo.pc"

		if( SQLCODE!=SQLOK ) 	{
			vDTrazasLog( modulo, "\tEXECUTE CO_GEN_CARGO - %s", LOG00,SQLERRM );
			return -1;
		}

		/* EXEC SQL 
		INSERT INTO CO_INTERESAPLI
				 (NUM_SECUENCI  , COD_TIPDOCUM  , COD_VENDEDOR_AGENTE, LETRA ,
				  COD_CENTREMI  , NUM_SECUREL   , COD_TIPDOCREL, COD_AGENTEREL,
				  LETRA_REL     , COD_CENTRREL  , NUM_CARGO    , NUM_FOLIO,
		        PREF_PLAZA    , SEC_CUOTA     , NUM_CUOTA    , IMP_DEUDA,
		        IMP_CARGO     , FACTOR_COBRO  , NUM_DIAS     , COD_CLIENTE,
		        COD_CICLFACT  , IND_FACTURADO , FEC_CALCULO  , COD_MODULO)
		VALUES (:lhNum_secuenci,:ihCod_tipdocum, :ihCod_vendedor, :szhLetra,
		        :ihCod_centremi,:lhNum_secuenci, :ihCod_tipdocum, :ihCod_vendedor, 
		        :szhLetra      ,:ihCod_centremi, :lhSecuCargo   , :lhNum_folio   ,
              :szhPref_plaza ,:ihSec_cuota   , :ihNum_cuota   ,
              GE_PAC_GENERAL.REDONDEA(:dhMonto_pagar, :ihDecimal, :ihValor_cero), 
              GE_PAC_GENERAL.REDONDEA(:dhImp_Cargo  , :ihDecimal, :ihValor_cero), 
              :dhFac_cobro   , :ihDiasint     , :lhCod_cliente ,
              :lhCod_ciclfact, NULL , SYSDATE , :szhModulo); */ 
#line 646 "./pc/Co_Intmorciclo.pc"

{
#line 631 "./pc/Co_Intmorciclo.pc"
  struct sqlexd sqlstm;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlvsn = 10;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.arrsiz = 26;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqladtp = &sqladt;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqltdsp = &sqltds;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.stmt = "insert into CO_INTERESAPLI (NUM_SECUENCI,COD_TIPDOCUM,COD_V\
ENDEDOR_AGENTE,LETRA,COD_CENTREMI,NUM_SECUREL,COD_TIPDOCREL,COD_AGENTEREL,LETR\
A_REL,COD_CENTRREL,NUM_CARGO,NUM_FOLIO,PREF_PLAZA,SEC_CUOTA,NUM_CUOTA,IMP_DEUD\
A,IMP_CARGO,FACTOR_COBRO,NUM_DIAS,COD_CLIENTE,COD_CICLFACT,IND_FACTURADO,FEC_C\
ALCULO,COD_MODULO) values (:b0,:b1,:b2,:b3,:b4,:b0,:b1,:b2,:b3,:b4,:b10,:b11,:\
b12,:b13,:b14,GE_PAC_GENERAL.REDONDEA(:b15,:b16,:b17),GE_PAC_GENERAL.REDONDEA(\
:b18,:b16,:b17),:b21,:b22,:b23,:b24,null ,SYSDATE,:b25)";
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.iters = (unsigned int  )1;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.offset = (unsigned int  )330;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.cud = sqlcud0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[0] = (         void  *)&lhNum_secuenci;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[0] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[1] = (         void  *)&ihCod_tipdocum;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[1] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[2] = (         void  *)&ihCod_vendedor;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[2] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[3] = (         void  *)szhLetra;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[3] = (unsigned int  )2;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[3] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[4] = (         void  *)&ihCod_centremi;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[4] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[4] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[5] = (         void  *)&lhNum_secuenci;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[5] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[5] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[5] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[5] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[5] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[5] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[5] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[6] = (         void  *)&ihCod_tipdocum;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[6] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[6] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[6] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[6] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[6] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[6] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[6] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[7] = (         void  *)&ihCod_vendedor;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[7] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[7] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[7] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[7] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[7] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[7] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[8] = (         void  *)szhLetra;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[8] = (unsigned int  )2;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[8] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[8] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[8] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[8] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[8] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[8] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[9] = (         void  *)&ihCod_centremi;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[9] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[9] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[9] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[9] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[9] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[9] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[9] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[10] = (         void  *)&lhSecuCargo;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[10] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[10] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[10] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[10] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[10] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[10] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[10] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[11] = (         void  *)&lhNum_folio;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[11] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[11] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[11] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[11] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[11] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[11] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[11] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[12] = (         void  *)szhPref_plaza;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[12] = (unsigned int  )11;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[12] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[12] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[12] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[12] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[12] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[12] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[13] = (         void  *)&ihSec_cuota;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[13] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[13] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[13] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[13] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[13] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[13] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[13] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[14] = (         void  *)&ihNum_cuota;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[14] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[14] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[14] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[14] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[14] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[14] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[14] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[15] = (         void  *)&dhMonto_pagar;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[15] = (unsigned int  )sizeof(double);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[15] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[15] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[15] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[15] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[15] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[15] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[16] = (         void  *)&ihDecimal;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[16] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[16] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[16] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[16] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[16] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[16] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[16] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[17] = (         void  *)&ihValor_cero;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[17] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[17] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[17] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[17] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[17] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[17] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[17] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[18] = (         void  *)&dhImp_Cargo;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[18] = (unsigned int  )sizeof(double);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[18] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[18] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[18] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[18] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[18] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[18] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[19] = (         void  *)&ihDecimal;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[19] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[19] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[19] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[19] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[19] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[19] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[19] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[20] = (         void  *)&ihValor_cero;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[20] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[20] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[20] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[20] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[20] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[20] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[20] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[21] = (         void  *)&dhFac_cobro;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[21] = (unsigned int  )sizeof(double);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[21] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[21] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[21] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[21] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[21] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[21] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[22] = (         void  *)&ihDiasint;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[22] = (unsigned int  )sizeof(int);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[22] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[22] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[22] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[22] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[22] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[22] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[23] = (         void  *)&lhCod_cliente;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[23] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[23] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[23] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[23] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[23] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[23] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[23] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[24] = (         void  *)&lhCod_ciclfact;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[24] = (unsigned int  )sizeof(long);
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[24] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[24] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[24] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[24] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[24] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[24] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[25] = (         void  *)szhModulo;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[25] = (unsigned int  )4;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[25] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[25] = (         void  *)0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[25] = (         int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[25] = (unsigned int  )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[25] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[25] = (unsigned short )0;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 631 "./pc/Co_Intmorciclo.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 631 "./pc/Co_Intmorciclo.pc"
}

#line 646 "./pc/Co_Intmorciclo.pc"


		if( SQLCODE!=SQLOK ) 	{
			vDTrazasLog( modulo, "\tINSERT INTO CO_INTERESAPLI - %s", LOG00,SQLERRM );
			return -1;
		}

	}
	
	return 0;
}

/* ============================================================================= */
/* Genera listas enlazadas,                                                      */
/* ============================================================================= */
int ifnCargaListaQuery() 
{
char modulo[]="ifnCargaListaQuery";
long lRowsCiclo=0, lTotalRows=0,lRowsProcesadas=0;
int  iSalir=FALSE, j=0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 667 "./pc/Co_Intmorciclo.pc"

	long   lhCod_cliente   [MAX_ARRAY];
	long   lhNum_secuenci  [MAX_ARRAY];
	int    ihCod_tipdocum  [MAX_ARRAY];
	long   lhNum_folio     [MAX_ARRAY];
	int    ihSec_cuota     [MAX_ARRAY];
	double dhMonto_pagar   [MAX_ARRAY];
	char   szhPref_plaza   [MAX_ARRAY][11]; /* EXEC SQL VAR szhPref_plaza IS STRING(11); */ 
#line 674 "./pc/Co_Intmorciclo.pc"

	char   szhFec_Sydate   [MAX_ARRAY][11]; /* EXEC SQL VAR szhFec_Sydate IS STRING(11); */ 
#line 675 "./pc/Co_Intmorciclo.pc"

	int    ihCod_vendedor  [MAX_ARRAY];
	int    ihCod_centremi  [MAX_ARRAY];
	int    ihNum_cuota     [MAX_ARRAY];
	char   shzLetra        [MAX_ARRAY][2];
	
	int    ihValor_cero    = 0 ;
	int    ihValor_uno     = 1 ;
	int    ihValor_dos     = 2 ;
	int    ihValor_seis    = 6 ;
	char   szhCO_CARTERA   [11];
	char   szhTIPDOCUM     [13];
	char   szhDDMMYYYY     [11];
/* EXEC SQL END DECLARE SECTION; */ 
#line 688 "./pc/Co_Intmorciclo.pc"


	vDTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);
	strcpy(szhCO_CARTERA,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");
	strcpy(szhDDMMYYYY,"DD-MM-YYYY");

	/************************************************************************/
	/* Toma el Universo de documentos vencidos impagos                      */
	/************************************************************************/
	/* EXEC SQL DECLARE Cur_DoctosMora CURSOR FOR
	SELECT A.COD_CLIENTE, A.NUM_SECUENCI, A.COD_TIPDOCUM, 
	       A.NUM_FOLIO  , A.SEC_CUOTA   , A.PREF_PLAZA  , 
	       NVL(SUM(A.IMPORTE_DEBE - A.IMPORTE_HABER),:ihValor_cero),
	       TO_CHAR(SYSDATE,:szhDDMMYYYY),  A.COD_VENDEDOR_AGENTE, 
	       A.COD_CENTREMI , A.NUM_CUOTA, A.LETRA
	FROM  CO_CARTERA A, GE_CLIENTES B    
	WHERE A.COD_CLIENTE = B.COD_CLIENTE 
	AND   A.COD_TIPDOCUM NOT IN (SELECT	TO_NUMBER(COD_VALOR)
								        FROM	CO_CODIGOS
								        WHERE	NOM_TABLA   = :szhCO_CARTERA
								        AND	   NOM_COLUMNA = :szhTIPDOCUM )
	AND   A.COD_CONCEPTO NOT IN (:ihValor_dos,:ihValor_seis)
	AND   A.FEC_VENCIMIE < (SYSDATE - :ihValor_uno)
	AND   A.IND_FACTURADO = :ihValor_uno
	AND   B.COD_CICLO   = :ihCiclo
	AND   NOT EXISTS (SELECT COD_CLIENTE FROM CO_INMUNIDAD WHERE COD_CLIENTE = B.COD_CLIENTE AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)
	AND   NOT EXISTS (SELECT COD_CLIENTE FROM CO_CLIESINTER WHERE COD_CLIENTE = B.COD_CLIENTE AND SYSDATE BETWEEN FEC_DESDE AND FEC_HASTA)
	GROUP BY A.COD_CLIENTE, A.NUM_SECUENCI, A.COD_TIPDOCUM, A.NUM_FOLIO, A.SEC_CUOTA, 
	         A.PREF_PLAZA, A.COD_VENDEDOR_AGENTE, A.COD_CENTREMI , A.NUM_CUOTA, A.LETRA; */ 
#line 717 "./pc/Co_Intmorciclo.pc"

	
	if( SQLCODE != SQLOK )	{
		vDTrazasLog( modulo, "\tDECLARE Cur_DoctosMora - %s", LOG00,SQLERRM );
		return -1;
	}

	/* EXEC SQL OPEN Cur_DoctosMora; */ 
#line 724 "./pc/Co_Intmorciclo.pc"

{
#line 724 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 26;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.stmt = sq0013;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )449;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.selerr = (unsigned short)1;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[0] = (         void  *)&ihValor_cero;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[0] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[0] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[0] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[0] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[0] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[0] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[1] = (         void  *)szhDDMMYYYY;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[1] = (unsigned int  )11;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[1] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[1] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[1] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[1] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[1] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[1] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[2] = (         void  *)szhCO_CARTERA;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[2] = (unsigned int  )11;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[2] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[2] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[2] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[2] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[2] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[2] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[3] = (         void  *)szhTIPDOCUM;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[3] = (unsigned int  )13;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[3] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[3] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[3] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[3] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[3] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[3] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[4] = (         void  *)&ihValor_dos;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[4] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[4] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[4] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[4] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[4] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[4] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[4] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[5] = (         void  *)&ihValor_seis;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[5] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[5] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[5] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[5] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[5] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[5] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[5] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[6] = (         void  *)&ihValor_uno;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[6] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[6] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[6] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[6] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[6] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[6] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[6] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[7] = (         void  *)&ihValor_uno;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[7] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[7] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[7] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[7] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[7] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[7] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[7] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstv[8] = (         void  *)&ihCiclo;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhstl[8] = (unsigned int  )sizeof(int);
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqhsts[8] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqindv[8] = (         void  *)0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqinds[8] = (         int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqharm[8] = (unsigned int  )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqadto[8] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqtdso[8] = (unsigned short )0;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsv = sqlstm.sqhstv;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphsl = sqlstm.sqhstl;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqphss = sqlstm.sqhsts;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpind = sqlstm.sqindv;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpins = sqlstm.sqinds;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparm = sqlstm.sqharm;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqparc = sqlstm.sqharc;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqpadto = sqlstm.sqadto;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqptdso = sqlstm.sqtdso;
#line 724 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 724 "./pc/Co_Intmorciclo.pc"
}

#line 724 "./pc/Co_Intmorciclo.pc"

	if( SQLCODE != SQLOK )	{
		vDTrazasLog( modulo, "\tOPEN Cur_DoctosMora - %s", LOG00,SQLERRM );
		return -1;
	}

	iSalir=FALSE;
	while(!iSalir)
	{
		/* EXEC SQL
		FETCH Cur_DoctosMora
		INTO :lhCod_cliente , 
		     :lhNum_secuenci,
		     :ihCod_tipdocum,
		     :lhNum_folio   ,
		     :ihSec_cuota   ,
		     :szhPref_plaza ,
		     :dhMonto_pagar ,
		     :szhFec_Sydate ,
		     :ihCod_vendedor,
		     :ihCod_centremi,
		     :ihNum_cuota   ,
		     :shzLetra      ; */ 
#line 746 "./pc/Co_Intmorciclo.pc"

{
#line 733 "./pc/Co_Intmorciclo.pc"
  struct sqlexd sqlstm;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlvsn = 10;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.arrsiz = 26;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqladtp = &sqladt;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqltdsp = &sqltds;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.iters = (unsigned int  )20000;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.offset = (unsigned int  )500;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.cud = sqlcud0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqlety = (unsigned short)256;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.occurs = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[0] = (         void  *)lhCod_cliente;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[0] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[0] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[0] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[0] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[0] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[0] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[1] = (         void  *)lhNum_secuenci;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[1] = (         int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[1] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[1] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[1] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[1] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[1] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[1] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[2] = (         void  *)ihCod_tipdocum;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[2] = (unsigned int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[2] = (         int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[2] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[2] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[2] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[2] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[2] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[2] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[3] = (         void  *)lhNum_folio;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[3] = (         int  )sizeof(long);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[3] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[3] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[3] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[3] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[3] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[3] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[4] = (         void  *)ihSec_cuota;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[4] = (unsigned int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[4] = (         int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[4] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[4] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[4] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[4] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[4] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[4] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[5] = (         void  *)szhPref_plaza;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[5] = (unsigned int  )11;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[5] = (         int  )11;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[5] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[5] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[5] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[5] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[5] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[5] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[6] = (         void  *)dhMonto_pagar;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[6] = (unsigned int  )sizeof(double);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[6] = (         int  )sizeof(double);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[6] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[6] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[6] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[6] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[6] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[6] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[7] = (         void  *)szhFec_Sydate;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[7] = (unsigned int  )11;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[7] = (         int  )11;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[7] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[7] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[7] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[7] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[7] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[7] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[8] = (         void  *)ihCod_vendedor;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[8] = (unsigned int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[8] = (         int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[8] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[8] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[8] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[8] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[8] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[8] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[9] = (         void  *)ihCod_centremi;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[9] = (unsigned int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[9] = (         int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[9] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[9] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[9] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[9] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[9] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[9] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[10] = (         void  *)ihNum_cuota;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[10] = (unsigned int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[10] = (         int  )sizeof(int);
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[10] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[10] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[10] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[10] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[10] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[10] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstv[11] = (         void  *)shzLetra;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhstl[11] = (unsigned int  )2;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqhsts[11] = (         int  )2;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqindv[11] = (         void  *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqinds[11] = (         int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharm[11] = (unsigned int  )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqharc[11] = (unsigned int   *)0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqadto[11] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqtdso[11] = (unsigned short )0;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsv = sqlstm.sqhstv;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphsl = sqlstm.sqhstl;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqphss = sqlstm.sqhsts;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpind = sqlstm.sqindv;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpins = sqlstm.sqinds;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparm = sqlstm.sqharm;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqparc = sqlstm.sqharc;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqpadto = sqlstm.sqadto;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlstm.sqptdso = sqlstm.sqtdso;
#line 733 "./pc/Co_Intmorciclo.pc"
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 733 "./pc/Co_Intmorciclo.pc"
}

#line 746 "./pc/Co_Intmorciclo.pc"

		
		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
			vDTrazasLog( modulo, "\tFETCH Cur_DoctosMora - %s", LOG00,SQLERRM );
			break;
		}

		if( SQLCODE == SQLNOTFOUND )  {
			iSalir = TRUE;
		}

      lTotalRows = SQLROWS;
      lRowsCiclo = ( lTotalRows - lRowsProcesadas );
		vDTrazasLog( modulo, "\tlTotalRows[%ld]", LOG03,lTotalRows);
		vDTrazasLog( modulo, "\tlRowsCiclo[%ld]", LOG03,lRowsCiclo);

		/* traspasamos los datos desde el host array a la lista de trabajo */
		for( j = 0; j < lRowsCiclo; j++ )	{

		   /* Insertamos un nodo para el codigo de cliente */
		   if (ifnInsertaPasoc(&pLista_Aux)!=0) {
				vDTrazasLog( modulo, "\tError al Insertar Nodo en pLista_Aux.", LOG00);
		   	return -1;
		   }

			/* Asigna valor del arreglo al campo de la lista */
			pLista_Aux->lCod_cliente =lhCod_cliente [j];
			pLista_Aux->lNum_secuenci=lhNum_secuenci[j];
			pLista_Aux->iCod_tipdocum=ihCod_tipdocum[j];
			pLista_Aux->lNum_folio   =lhNum_folio   [j];
			pLista_Aux->iSec_cuota   =ihSec_cuota   [j];
			pLista_Aux->dMonto_pagar =dhMonto_pagar [j];
         pLista_Aux->iCod_vendedor=ihCod_vendedor[j];
         pLista_Aux->iCod_centremi=ihCod_centremi[j];
         pLista_Aux->iNum_cuota   = ihNum_cuota  [j];
			strcpy(pLista_Aux->szPref_plaza, szhPref_plaza [j]);
			strcpy(pLista_Aux->szFec_Sydate, szhFec_Sydate[j]);
         strcpy(pLista_Aux->szLetra , shzLetra[j]); 


			vDTrazasLog( modulo, "\n\t[%06d] ",LOG05, j+1);
			vDTrazasLog( modulo, "\tlCod_cliente  ======>  [%ld]",LOG05, pLista_Aux->lCod_cliente);
			vDTrazasLog( modulo, "\tlNum_secuenci ======>  [%ld]",LOG05, pLista_Aux->lNum_secuenci);
			vDTrazasLog( modulo, "\tiCod_tipdocum ======>  [%d]", LOG06, pLista_Aux->iCod_tipdocum);
			vDTrazasLog( modulo, "\tlNum_folio    ======>  [%ld]",LOG05, pLista_Aux->lNum_folio);
			vDTrazasLog( modulo, "\tiSec_cuota    ======>  [%d]", LOG07, pLista_Aux->iSec_cuota);
			vDTrazasLog( modulo, "\tdMonto_pagar  ======>  [%f]", LOG06, pLista_Aux->dMonto_pagar);
			vDTrazasLog( modulo, "\tszPref_plaza  ======>  [%s]", LOG07, pLista_Aux->szPref_plaza);
			vDTrazasLog( modulo, "\tszFec_Sydate  ======>  [%s]", LOG07, pLista_Aux->szFec_Sydate);
			iTotalReg++;

		}

		lRowsProcesadas = lRowsCiclo; /* Resetea Contador, ya que las filas recuperadas se han procesado */
		if( iSalir )	vDTrazasLog( modulo, "\tAlcanzando Fin de Datos Cur_DoctosMora.\n", LOG03);

	} /* fin while cursor Cur_DoctosMora */

	/* EXEC SQL
	CLOSE Cur_DoctosMora; */ 
#line 805 "./pc/Co_Intmorciclo.pc"

{
#line 804 "./pc/Co_Intmorciclo.pc"
 struct sqlexd sqlstm;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlvsn = 10;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.arrsiz = 26;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqladtp = &sqladt;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqltdsp = &sqltds;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.iters = (unsigned int  )1;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.offset = (unsigned int  )563;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.cud = sqlcud0;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.sqlety = (unsigned short)256;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlstm.occurs = (unsigned int  )0;
#line 804 "./pc/Co_Intmorciclo.pc"
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 804 "./pc/Co_Intmorciclo.pc"
}

#line 805 "./pc/Co_Intmorciclo.pc"

	if( SQLCODE != SQLOK )  {
		vDTrazasLog( modulo, "\tCLOSE Cur_DoctosMora - %s", LOG00, SQLERRM );
	}
	
	return 0;
		
}

/* ============================================================================= */
/* Valida traza de facturacion con procesos precedentes y posteriores            */
/* ============================================================================= */
int ifnTrazaFacturacion()
{
char modulo[]="ifnTrazaFacturacion";

	if (!bfnValidaTrazaProc(stConfig.lCodCicloFact, iPROC_INTERMORO, iIND_FACT_ENPROCESO))	return -1; 
	
	if (!bfnOraCommit ())
	{
		iDError (modulo,ERR000,vInsertarIncidencia, "CommitWork",szfnORAerror());
		return -1;
	}
	bfnSelectTrazaProc ( stConfig.lCodCicloFact, iPROC_INTERMORO, &stTrazaProc);    
	bPrintTrazaProc(stTrazaProc);
	
	return 0;

}

/* ============================================================================= */
/* Actualiza la traza de facturacion                                             */
/* ============================================================================= */
int ifnFinTrazaFacturacion()
{
char modulo[]="ifnFinTrazaFacturacion";
char szFecha [15];
	if (!bfnSelectSysDate(szFecha))
	     return -1;
	
	stTrazaProc.iCodEstaProc = iPROC_EST_OK;
	strcpy(stTrazaProc.szFecTermino,szFecha);
	strcpy(stTrazaProc.szGlsProceso,"Proceso de Interes de Mora OK");
	bPrintTrazaProc(stTrazaProc);
	if(!bfnUpdateTrazaProc(stTrazaProc))
	     return -1;
	
	if (!bfnOraCommit ())
	{
	     iDError (modulo,ERR000,vInsertarIncidencia, "CommitWork",szfnORAerror());
	     return -1;
	}
	
	return 0;

}
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
