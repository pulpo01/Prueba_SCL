
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
static const struct sqlcxp sqlfpn =
{
    19,
    "./pc/gen_ajustes.pc"
};


static unsigned int sqlctx = 27621955;


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
   unsigned char  *sqhstv[24];
   unsigned long  sqhstl[24];
            int   sqhsts[24];
            short *sqindv[24];
            int   sqinds[24];
   unsigned long  sqharm[24];
   unsigned long  *sqharc[24];
   unsigned short  sqadto[24];
   unsigned short  sqtdso[24];
} sqlstm = {12,24};

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

 static const char *sq0005 = 
"select COD_CLIENTE ,sum((IMPORTE_DEBE-IMPORTE_HABER)) MONTO_SALDO  from CO_C\
ARTERA where (COD_TIPDOCUM not  in (select TO_NUMBER(COD_VALOR)  from CO_CODIG\
OS where (NOM_TABLA=:b0 and NOM_COLUMNA=:b1)) and ((IMPORTE_DEBE-IMPORTE_HABER\
)>=:b2 or (IMPORTE_DEBE-IMPORTE_HABER)<=:b3)) group by COD_CLIENTE having (sum\
((IMPORTE_DEBE-IMPORTE_HABER)) between :b4 and :b5 and sum((IMPORTE_DEBE-IMPOR\
TE_HABER))<>:b6)           ";

 static const char *sq0012 = 
"select ct.cod_tipconce ,(ca.importe_debe-ca.importe_haber)  from co_tipconce\
p ct ,co_conceptos cc ,co_cartera ca where (((ct.cod_tipconce=cc.cod_tipconce \
and cc.cod_concepto=ca.cod_concepto) and ca.cod_tipdocum not  in (select TO_NU\
MBER(cod_valor)  from co_codigos where (nom_tabla=:b0 and nom_columna=:b1))) a\
nd ca.cod_cliente=:b2)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,125,0,4,292,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
28,0,0,2,54,0,4,403,0,0,1,0,0,1,0,2,3,0,0,
47,0,0,3,64,0,6,416,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
70,0,0,4,195,0,6,431,0,0,7,7,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,0,3,3,0,0,2,
3,0,0,2,97,0,0,
113,0,0,5,415,0,9,531,0,0,7,7,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
156,0,0,5,0,0,13,554,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
179,0,0,5,0,0,15,577,0,0,0,0,0,1,0,
194,0,0,6,103,0,4,664,0,0,4,2,0,1,0,1,3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,
225,0,0,7,96,0,4,681,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
252,0,0,8,394,0,3,834,0,0,14,14,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,3,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
323,0,0,9,496,0,3,975,0,0,24,24,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
434,0,0,10,277,0,3,1074,0,0,12,12,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,
0,1,3,0,0,1,4,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
497,0,0,11,288,0,3,1136,0,0,7,7,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
1,4,0,0,1,3,0,0,
540,0,0,12,343,0,9,1235,0,0,3,3,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,
567,0,0,12,0,0,13,1244,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
590,0,0,12,0,0,15,1285,0,0,0,0,0,1,0,
};


/* ============================================================================= 
   Tipo        : Aplicacion  
   Nombre      : Gen_Ajustes.pc
   Descripcion : Genera Ajustes a los Clientes con Saldo comprendido
                 entre un valor dado.	( ajustes menores a 100 pesos )
                 Se basa en funcion ajustes.pc (JLR 27-05-99 , ult mod 11-12-00)
   Recibe      : -u [Usuario]/[Password] (necesarios)
                 -m Monto del Saldo 
                 -l [NivelLog]
   Asume       : Nivel de Log por defecto = 3
   Devuelve    : == 0 Termino Ok
                 <> 0 Termino con Error 
   Autor       : Roy Barrera Richards
   Fecha       : 25 - Julio - 2001
   Modificaciones:
   2003.02.05	Se modifica programa por proyecto Prefijo Plaza.
   				Se genera VERSION 1.00
   2003.07.02	Se modifica programa por Incidencia CH-982.
   				Se genera VERSION 1.01
 ============================================================================= 
   21-12-2004  Modificado por Proyecto MAS_03043 Mejoras Cancelacion de Credito.
 ============================================================================= */
#define _PASOC_PC_
#include <pasoc.h>
#include <math.h>
#include "gen_ajustes.h"

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


/*****************************************************************************/
/*                    -- Declaracion de Variables Globales --                */
/*****************************************************************************/
/* EXEC SQL BEGIN DECLARE SECTION; */ 
 
	char szPrefPlazaDefault[26];
	int  ihValor_cero   = 0;
	int  ihValor_uno    = 1;
/* EXEC SQL END DECLARE SECTION; */ 


static char szExeAjustes [1024];
static AJUSTE stAjuste;
double	dTotCredito = 0;
double	dTotDebito = 0;
int   iTipoAjuste = 0;
static char szUsage [] =
   "\nUso : gen_ajustes -u [Usuario]/[Password] "
   "\n\t-m Monto del Saldo -l [NivelLog]\n";

/*****************************************************************************/
/*                       funcion : main                                      */
/* -Lanza el proceso							     */
/* -Valores de Retorno : 0 => Todo OK                                        */
/*                      !0 => Error en algunas de las funciones que ejecuta  */
/*                           el main.                                        */
/*****************************************************************************/
int main (int argc, char* argv[])
{
/* Primero valida los parámetros de entrada */
extern int   opterr;
extern int   optopt;
extern char *optarg;

char opt[]  = "u:m:l:";
int  iOpt          = 0    ;

char szUsuario[61] = ""   ;
char *pszTmp       = ""   ;

    memset (&stAjuste,0,sizeof (AJUSTE));
    memset (&stStatus,0,sizeof (STATUS));

    /* asigna valores por Default definidas en .h   */
    strcpy( szPrefPlazaDefault, szPREF_PLAZA_DEFAULT );

    while ( (iOpt = getopt (argc,argv,opt)) != EOF)
    {
          switch (iOpt)
             {
		case 'u':   /* usuario/password */
  		if ( strlen (optarg) )
  		{
           		strcpy (szUsuario,optarg)  ;
           		stAjuste.bOptUsuario = TRUE;
  		}
  		break;
                 case 'm': /* monto ( $100 ) */
                   if ( strlen (optarg) )
                   {
                        stAjuste.bOptMonto = TRUE           ;
                        stAjuste.lDiferencia = atol (optarg); 
                   }
                   break;
                 case 'l': /* nivel de log */
                   if ( strlen (optarg) )
                   {
                        stAjuste.bOptNivelLog = TRUE         ;
                        stAjuste.iNivelLog    = atoi (optarg);
                   }
                   break;   
             }/* fin switch */
    }/* fin While de Opciones */

    if (!stAjuste.bOptUsuario)
    {
         fprintf (stderr,"\n\t=>Error Faltan Parametros de Entrada: \n%s\n",szUsage);
         return  (1)      ;
    }
    else
    {
       if ( (pszTmp = (char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\t=>Formato Usuario Oracle Incorrecto:\n%s\n",szUsage);
             return (1)       ;
       }
       else
       {
             strncpy (stAjuste.szUsuario ,szUsuario,pszTmp-szUsuario);
             strcpy  (stAjuste.szPassWord, pszTmp+1)                 ;
       }
    }
    if (!stAjuste.bOptNivelLog)
         stAjuste.iNivelLog = iNIVEL_DEF;

    if (!stAjuste.bOptMonto)
    {
           fprintf (stderr,"\n\tERROR Faltan parametros de Entrada : %s",szUsage);
           bfnExitAjustes ();
           return (3);
    }
    if (stAjuste.lDiferencia < 1)
    {
           fprintf (stderr,"\n\tERROR Monto Ingresado No es valido : %s",szUsage);
           bfnExitAjustes ()                                           ;
           return (3)                                                     ;
    }

/* Verificados los parametros de entrada, procede a conectarse a Oracle      */

    if (!bfnInitAjustes (&stAjuste,&stStatus))
         return (2);

/* Se conectó, abrió archivos de Log y capturó FA_DATOSGENER. Genera Ajustes */

	if (!bfnGenAjustes (stAjuste))
	{
		/* si fallo la generacion de ajustes termina con error */
		iDError (szExeAjustes,ERR042,vInsertarIncidencia);
		bfnExitAjustes ()                           ;
		vDTrazasLog (szExeAjustes,"\n\n\tTotal Importe por Notas de Credito = [%f]",LOG03,dTotCredito);
		vDTrazasLog (szExeAjustes,"\tTotal Importe por Notas de Debito  = [%f]\n",LOG03,dTotDebito);
		fclose(stStatus.LogFile);
		fclose(stStatus.ErrFile);
		return (4)                                     ;
	}

	/* si la generacion de ajustes termino Ok, termina Ok tambien la aplicacion */
	vDTrazasLog (szExeAjustes,"\n\n\tTotal Importe por Notas de Credito = [%f]",LOG03,dTotCredito);
	vDTrazasLog (szExeAjustes,"\tTotal Importe por Notas de Debito  = [%f]\n",LOG03,dTotDebito);
	vDTrazasLog (szExeAjustes,"\n\n\t*** Proceso Termino OK ***\n",LOG03);
	bfnExitAjustes ()                           ;
	fclose(stStatus.LogFile);
	fclose(stStatus.ErrFile);
	
	return (0); 
}/***************************** Final main ***********************************/

/*****************************************************************************/
/*                           funcion : bfnInitAjustes                        */

/* -Funcion que se conecta a Oracle, abre fichero de Errores y de Trazas,car-*/
/*  ga Fa_DatosGener en stDatosGener, ...                                    */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/

static BOOL bfnInitAjustes ( AJUSTE *stAjuste, STATUS *pstStatus )
{
char szFuncion [25] = "";
char szFechDesde [15]= "";
char szFechHasta [15]= "";
	
	if (!bfnConnectORA (stAjuste->szUsuario,stAjuste->szPassWord))
	{
		fprintf (stderr,"\n\t=>Error en la Conexion Oracle\n");
		return   FALSE ;
	}
	
	/* Datos Iniciales de Tiempo */
	
	cpu_ini = clock();
	time (&real_ini) ;
	pstStatus->OraConnected = 1;
	
	if (!bGetDatosGener (&stDatosGener,szSysDate)) return  FALSE;
	
	if (!bfnDBCreaDirPath("PATHLOG", stDatosGener.szDirLogs)) return FALSE;
	
	sprintf (pstStatus->LogName,"%s/Gen_Ajustes%d.log", stDatosGener.szDirLogs,stAjuste->lDiferencia);
	sprintf (pstStatus->ErrName,"%s/Gen_Ajustes%d.err", stDatosGener.szDirLogs,stAjuste->lDiferencia); 
	unlink (pstStatus->LogName);
	unlink (pstStatus->ErrName);
	
	if (!bOpenLog (pstStatus->LogName))
	{
		vDTrazasError (szExeAjustes,"\n\t=> No se puede Abrir el archivo de Log\n",LOG01);
		return FALSE ; 
	}

	if( !bOpenError( pstStatus->ErrName ) )
	{
		vDTrazasError (szExeAjustes,"\n\t=> No se puede Abrir el archivo de Err\n",LOG01);
		return FALSE ; 
	}
	strcpy( szExeAjustes, "Generacion de Ajustes" );
	
	pstStatus->LogNivel = stAjuste->iNivelLog;
	
	vDTrazasLog( szExeAjustes,	"\n     *******************************************************************"
								"\n     *                           AJUSTES     %s                          *"
								"\n     *******************************************************************", LOG03,szVersion );
	
	vDTrazasError(szExeAjustes,	"\n     *******************************************************************"
								"\n     *                           AJUSTES      %s                         *"
								"\n     *******************************************************************", LOG03, szVersion );
	
	return TRUE;
}/************************** Final bfnInitAjustes *************************/ 

/*****************************************************************************/
/*                           funcion : bfnExitAjustes                     */
/* -Funcion que cierra Logs, libera memoria, se desconecta de Oracle,...     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnExitAjustes (void)
{
	/* Desconexion Oracle */
	if (!bfnDisconnectORA(0))
	{
		iDError(szExeAjustes,ERR000,vInsertarIncidencia,"Desconexion",szfnORAerror());
		return FALSE;
	}
	stStatus.OraConnected = FALSE;
	vDTrazasLog (szExeAjustes,"\n\t\t*** Desconexion a Oracle ***\n",LOG04);
	
	/* Datos Fin de Tiempo */
	times (&tms)     ;
	cpu_fin = clock();
	time (&real_fin) ;
	
	real = (real_fin-real_ini)                ;
	cpu  =(float)cpu_fin/(float)CLOCKS_PER_SEC;
	
	vDTrazasLog( szExeAjustes,	"\n\t=> Tiempo de CPU : [%g]"
								"\n\t=> Tiempo Real   : [%g]",LOG03, cpu, real ); 
}/*************************** Final bfnExitAjustes ************************/

/*****************************************************************************/
/*                          funcion : bfnGenAjustes                          */
/*****************************************************************************/
static BOOL bfnGenAjustes (AJUSTE stAjuste)
{
int	iRes		= 0;
int iRetorno    = 0;
int	i			= 0;
int	j			= 0;
int	iCodAbono	= 0;
int   iCantDoc = 0;
CARTERA		stCartera;
DATCON		stCobros;
FACTCOBR	   stFactCobr;
DATDOC		stDatDoc;
DATPAG		stDatPag;
DATCON		stConc;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhNum_Transaccion     ;
	long lhCodCliente          ;
	char szhFec_Pago       [20]; /* EXEC SQL VAR szhFec_Pago IS STRING(20); */ 

	int  ihRetorno             ;
	char szhGlosa         [500]; 
	int  ihCarrier  = 0        ;
	int  ihCodConcepto         ;
	char szhYYYYMMDD        [9];
/* EXEC SQL END DECLARE SECTION; */ 


	
	vDTrazasLog( szExeAjustes, "\n\t\t* Generacion de Ajustes *\n", LOG03 );
	
	memset( &stFactCobr, 0, sizeof( FACTCOBR ) );
	
	/* 
	Invoca a bfnDBObtConCreFA : /unix/src/factura/venta/fac.pc (paso a cobros)  (2)
	para obtener el codigo de concepto de credito from co_conceptos y co_tipconcep where ind_abono = 1.
	*/   
	/* EXEC SQL
	SELECT A.COD_CONCEPTO
	INTO  :ihCodConcepto
	FROM  CO_CONCEPTOS A, CO_TIPCONCEP B
	WHERE A.COD_TIPCONCE = B.COD_TIPCONCE
	AND   B.IND_ABONO = :ihValor_uno; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.COD_CONCEPTO into :b0  from CO_CONCEPTOS A ,CO_TIPC\
ONCEP B where (A.COD_TIPCONCE=B.COD_TIPCONCE and B.IND_ABONO=:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_uno;
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


	if (SQLCODE != SQLOK) {
	   iDError(szExeAjustes,ERR000,vInsertarIncidencia,"En SELECT A.COD_CONCEPTO\n ",SQLERRM);
	   return -1;
	}

	/*
	Invoca a ifnDBOpenCartera ( SI != 0 : error  SI == 0 : ok )
	Abre Cursor de los clientes de la Co_cartera con documentos que no sean :
	Castigo Contable,Pagare,Cheque,Protesto,Prorroga o Letra, donde la diferencia entre el debe y el haber
	sea distinto de cero ( mayor o igual a 1  o menos o igual a -1)
	Agrupado por cliente donde además la suma de las diferencia entre el debe y el haber de todos los documentos
	este entre el valor ingresado ( positivo y negativo )
	*/
	if( ifnDBOpenCartera( stAjuste ) ) 
		return FALSE;

	/* Una vez abierto el cursor, lo recorre */
	while( 1 ) 
	{
		iRes = 0;

		memset( &stCartera, 0, sizeof( CARTERA ) );
		/* obtiene cliente y saldo para esta iteracion */	
		iRes = ifnDBFetchCartera (stAjuste, &stCartera);

		if( iRes == SQLNOTFOUND )
		{
			vDTrazasLog (szExeAjustes,"\n\t\tNO EXISTEN MAS CLIENTES CON ESTE SALDO", LOG03 );
			fprintf( stdout, "NO EXISTEN MAS CLIENTES CON ESTE SALDO\n" );
			iRes=0;
			break;
		}

		if( iRes == SQLOK )
		{
			/* se valida que los conceptos a ajustar esten consistentes */
			iRetorno = ifnValidaConceptos( stCartera.lCodCliente );
			
			if( iRetorno <= 0 ) /* si se produjo un error o el cliente tiene registros inconsistentes */
			{
				if ( iRetorno <= 0 )
				{
					vDTrazasLog( szExeAjustes, "\n\t\t!! NO SE GENERA AJUSTE ¡¡ CLIENTE => [%ld].", LOG03, stCartera.lCodCliente );
					iRes = 1;	/* el cliente tiene registros inconsistentes */
				}
				else
				{
					iRes = 2;	/* se produjo un error de oracle */
				}
			}
			else
			{
				/* se intenta realizar el ajuste (generar el documento y tipo de ajuste adecuados) */
				if( !bfnAjuCobros( &stCobros, iCodAbono, stCartera ) )
				{
					/* Si falla , se termina la ejecucion por error */
					iDError( szExeAjustes, ERR043, vInsertarIncidencia, 0, "bfnAjuCobros" );
					/*return FALSE;*/
					iRes = 1;
				}
				else
				{
					/* si se realizo el ajuste ( se generó el documento ), se llenan las estructuras 
					de datos correspondientes */
					
					memset( &stDatDoc ,0, sizeof( DATDOC ) );
					memset( &stDatPag ,0, sizeof( DATPAG ) );
					memset( &stConc   ,0, sizeof( DATCON ) );
					
					stDatDoc.iCodTipDocum = stCobros.iCodTipDocum;
					stDatDoc.iCodCentrEmi = 1;
					stDatDoc.lNumSecuenci = stCobros.lNumSecuenci;
					stDatDoc.lCodAgente   = stDatosGener.lAgenteInterno;
					strcpy( stDatDoc.szLetra, stDatosGener.szLetraCobros );
					strcpy( stDatDoc.szDesPago, "AJUSTE MASIVO CTA. CTE." );
					
					strcpy( stDatPag.szNomUsu, stAjuste.szUsuario ) ;
					stDatPag.iCodSisPago = stDatosGener.iSisPagoRegalo;
					stDatPag.iCodCauPago = 22;
					stDatPag.iCodOriPago = stDatosGener.iOriPagoRegalo;
					stDatPag.iCodForPago = 0;
					stDatPag.lCodCliente = stCartera.lCodCliente;
					stDatPag.dImpPago    = fabs( stCartera.dMtoSaldo );
				
					/* Intenta aplicar el ajuste ( el documento generado ) en las distintas tablas pertinente */
					if( !bfnPagoAjuste( &stDatDoc, &stDatPag, &stCobros ) ) 
					{
						iDError( szExeAjustes, ERR043, vInsertarIncidencia, 0, "bfnPagoAjuste" );
						iRes = 1;
					}
					else
					{
						/* Intenta insertar en la co_cartera el concepto generado */
						if( !bfnDBIntCartera( &stCobros, stCartera.lCodCliente ) )
						{
							iDError( szExeAjustes, ERR043, vInsertarIncidencia, 0, "bfnDBIntCarteraFac" );
							iRes = 1;
						}
						else
						{
	
							memset(szhGlosa,'\0',sizeof(szhGlosa));
							ihRetorno=99;
							iCantDoc++;				
							
							/* EXEC SQL
							SELECT GA_SEQ_TRANSACABO.NEXTVAL
							INTO   :lhNum_Transaccion
							FROM   DUAL; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 2;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select GA_SEQ_TRANSACABO.nextval  into :b0  from DUAL ";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )28;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhNum_Transaccion;
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


							if (SQLCODE != SQLOK) {
							    iDError(szExeAjustes,ERR000,vInsertarIncidencia,"En SELECT GA_SEQ_TRANSACABO.NEXTVAL.\n ",SQLERRM);
							    return -1;
							}
	
							vDTrazasLog( szExeAjustes, "\n\t\tLlamando a CO_CANCELACION_PG.CO_CANCELACREDITOS_PR.", LOG03 );
							lhCodCliente=stCartera.lCodCliente;
							strcpy(szhYYYYMMDD,"YYYYMMDD");
	
							/* EXEC SQL EXECUTE
								BEGIN
										:szhFec_Pago:=TO_CHAR(SYSDATE ,:szhYYYYMMDD);
								END;
							END-EXEC; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 2;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "begin :szhFec_Pago := TO_CHAR ( SYSDATE , :szhYYYYMMDD\
 ) ; END ;";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )47;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhFec_Pago;
       sqlstm.sqhstl[0] = (unsigned long )20;
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


							
							
							vDTrazasLog ( szExeAjustes,"\n\t\t****** Registro No : [%d] ******"
															   "\n\t\t=> lhCodCliente      [%ld]"
															   "\n\t\t=> szFecPago         [%s] "
															   "\n\t\t=> lhNum_Transaccion [%ld]\n\n",
															   LOG03,iCantDoc ,lhCodCliente ,szhFec_Pago, lhNum_Transaccion );
					
							/* Intenta cancelar los creditos del cliente 
							iRes = ifnCancelacionCreditos( stCartera.lCodCliente, &stCobros, iCodAbono, szSysDate, 0 );*/
							/* EXEC SQL EXECUTE
								BEGIN
										CO_CANCELACION_PG.CO_CANCELACREDITOS_PR(:lhCodCliente, TO_DATE(:szhFec_Pago,:szhYYYYMMDD), :lhNum_Transaccion , :ihCarrier , NULL , NULL , NULL, :ihRetorno , :szhGlosa );
								END;
							END-EXEC; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 7;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "begin CO_CANCELACION_PG . CO_CANCELACREDITOS_PR ( :lhC\
odCliente , TO_DATE ( :szhFec_Pago , :szhYYYYMMDD ) , :lhNum_Transaccion , :ih\
Carrier , NULL , NULL , NULL , :ihRetorno , :szhGlosa ) ; END ;";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )70;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhFec_Pago;
       sqlstm.sqhstl[1] = (unsigned long )20;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDD;
       sqlstm.sqhstl[2] = (unsigned long )9;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)&lhNum_Transaccion;
       sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)&ihCarrier;
       sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)&ihRetorno;
       sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[5] = (         int  )0;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)szhGlosa;
       sqlstm.sqhstl[6] = (unsigned long )500;
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


							
							if (SQLCODE != SQLOK ) 
							{
						   		iDError(szExeAjustes,ERR000,vInsertarIncidencia,"En CO_CANCELACREDITOS_PR.\n ",SQLERRM);
						   	}
						   	if (ihRetorno == 99) 
						   	{
						   		iDError(szExeAjustes,ERR000,vInsertarIncidencia,"Valor de Retorno es 99. Posible error en la PL\n ",SQLERRM);
						   		iRes = -1;
							}
						   	else if (ihRetorno != 0)   
						   	{
						   		rtrim(szhGlosa);
						   		vDTrazasLog (szExeAjustes, "\t\tValor ihRetorno [%d]\n\t\tszhGlosa    [%s]\n",LOG03,ihRetorno,szhGlosa);
						   		iRes = -1;
						   
						   	}
							else
							{
						   		vDTrazasLog (szExeAjustes, "\t\tCANCELACION DE CREDITOS !! OK ¡¡.", LOG03 );

								if (!bfnOraCommit ())
								{
									iDError( szExeAjustes, ERR000, vInsertarIncidencia, "CommitWork", szfnORAerror() );
									iRes = 2;
									break; /* error grave */
								}
								else
								{
									if( stCartera.dMtoSaldo > 0.0 )
										dTotCredito = dTotCredito + stCartera.dMtoSaldo;
									else
										dTotDebito = dTotDebito + stCartera.dMtoSaldo;
								}
							} /* if( iRes != 0 ) */
						} /* if( !bfnDBIntCartera( &stCobros, stCartera.lCodCliente ) ) */
					} /* if( !bfnPagoAjuste( &stDatDoc, &stDatPag, &stCobros ) ) */
				} /* if( !bfnAjuCobros( &stCobros, iCodAbono, stCartera ) ) */
			} /* fin if( iRetorno <= 0 ) */
		} /* fin if sqlok */
		
		if( iRes != SQLOK ) /* es error anterior */
		{
			if( !bfnOraRollBack () )
			{
				iDError( szExeAjustes, ERR000, vInsertarIncidencia, "RollBackWork", szfnORAerror() );
				iRes = 2; /* error grave */
			}
		}
		
		if( iRes == 2 )
			break; /* es un error grave */
			
	} /* while ... */ 

	if( ifnDBCloseCartera() )
		return FALSE;

	return( iRes != 0 ) ? FALSE : TRUE;   
}/**************************** Final bfnGenAjustes ***************************/

/*****************************************************************************/
/*                           funcion : ifnDBOpenCartera                      */
/* -Funcion que carga en Abre cursor sobre la tabla CO_CARTERA               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL ifnDBOpenCartera (AJUSTE stAjuste)
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int   ihDiferenciaPos;
		int   ihDiferenciaNeg;
		char  szhCARTERA    [11];
		char  szhTIPDOCUM   [13];
		int   ihValor_cerouno = 0.1;
		int   ihValor_cerounoNeg =-0.1;
	/* EXEC SQL END DECLARE SECTION; */ 


	ihDiferenciaPos = stAjuste.lDiferencia;
	ihDiferenciaNeg = stAjuste.lDiferencia * -1;
	strcpy(szhCARTERA ,"CO_CARTERA");
	strcpy(szhTIPDOCUM,"COD_TIPDOCUM");

	/* EXEC SQL DECLARE Cur_Maxivo CURSOR FOR
	SELECT COD_CLIENTE, 
	       SUM( IMPORTE_DEBE - IMPORTE_HABER ) MONTO_SALDO 
	  FROM CO_CARTERA
	 WHERE COD_TIPDOCUM NOT IN (	SELECT TO_NUMBER(COD_VALOR)
									  FROM CO_CODIGOS
									 WHERE NOM_TABLA   = :szhCARTERA
									   AND NOM_COLUMNA = :szhTIPDOCUM )
	   AND ( IMPORTE_DEBE - IMPORTE_HABER >= :ihValor_cerouno OR	IMPORTE_DEBE - IMPORTE_HABER <= :ihValor_cerounoNeg )
	GROUP BY COD_CLIENTE
	HAVING SUM( IMPORTE_DEBE - IMPORTE_HABER ) BETWEEN :ihDiferenciaNeg AND :ihDiferenciaPos
	   AND SUM( IMPORTE_DEBE - IMPORTE_HABER ) != :ihValor_cero; */ 


	/* EXEC SQL OPEN Cur_Maxivo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
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
 sqlstm.sqhstv[0] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[1] = (unsigned long )13;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cerouno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_cerounoNeg;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihDiferenciaNeg;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihDiferenciaPos;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
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



	if( SQLCODE )
	{
		iDError( szExeAjustes, ERR000, vInsertarIncidencia, "ifnDBOpenCartera", szfnORAerror() );
	}
	return SQLCODE;
}/**************************** Final ifnDBOpenCartera ***********************/

/*****************************************************************************/
/*                         funcion : ifnDBFetchCartera                       */
/* -Funcion que realiza el Fetch sobre CO_CARTERA, y determina el universo al*/
/*  cual se le generara el ajuste.                                           */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static ifnDBFetchCartera ( AJUSTE stAjuste, CARTERA *pstCartera)
{
	int	rows = 0;
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhCodCliente;
		double dhMtoSaldo	 ;	
	/* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL 
	FETCH Cur_Maxivo 
     INTO :lhCodCliente, 
          :dhMtoSaldo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )156;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhMtoSaldo;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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



	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) 
	{
		iDError (szExeAjustes,ERR000,vInsertarIncidencia,"ifnDBFetchCartera",szfnORAerror());
   	}
   
	pstCartera->lCodCliente  = lhCodCliente ;
   	pstCartera->dMtoSaldo    = dhMtoSaldo   ;

  	return SQLCODE;
}/************************* Final ifnDBFetchCartera *************************/

/*****************************************************************************/
/*                          funcion : ifnDBCloseCartera                     */
/* -Funcion que cierra el cursor abierto de CO_CARTERA                      */
/* -Valores Retorno : SQLCODE                                                */
/*****************************************************************************/
static int ifnDBCloseCartera (void)
{
   /* EXEC SQL CLOSE Cur_Maxivo; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 7;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )179;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



   if (SQLCODE)   {
      iDError(szExeAjustes,ERR000,vInsertarIncidencia,"ifnDBCloseCartera",szfnORAerror ()); 
   }
  return SQLCODE;
}/************************* Final ifnDBCloseCartera *************************/

/*****************************************************************************/
/*                            funcion : bfnAjuCobros                         */
/* -Funcion que rellena la estructura pstCobros para realizar el Interface   */
/*  con el modulo de Cobros y asi actualizar la Cartera.                     */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnAjuCobros( DATCON *pstCobros, int iCodAbono, CARTERA stCartera )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhPrefPlaza[26];
	char szhCodOperadoraScl[6];
	char szhCodPlaza[6];		
	long lhCodCliente;
/* EXEC SQL END DECLARE SECTION; */ 


int iResul = 0;
long lhNumSecuenci = 0;

	vDTrazasLog( szExeName, "\n\t\t# Cliente  [%ld] \n\t\t  Saldo    [%f] ", LOG04, stCartera.lCodCliente, stCartera.dMtoSaldo );
	
	lhCodCliente = stCartera.lCodCliente;
	
	/* crea los documentos necesarios para ajustar los montos */
	if( stCartera.dMtoSaldo > 0.0 )
	{
		pstCobros->iCodTipDocum  = 9; /* NC interna */
		pstCobros->iCodConcepto  = 2; /* Abono */
		pstCobros->dImporteDebe  = 0;
		pstCobros->dImporteHaber = stCartera.dMtoSaldo;    
		iTipoAjuste = 3; /* ajuste sencillo masivo NC */
	}
	else
	{
		pstCobros->iCodTipDocum = 10; /* ND interna */
		pstCobros->iCodConcepto = 1; /* Recargo */
		pstCobros->dImporteDebe  = stCartera.dMtoSaldo * -1;
		pstCobros->dImporteHaber = 0;
		iTipoAjuste = 7; /* ajuste sencillo masivo ND */
	}
	
	pstCobros->iCodCentremi = 1;
	strcpy( pstCobros->szLetra, "X" );
	strcpy( pstCobros->szFolioCTC, "0" );
	
	/* obtiene la secuencia adecuada de la tabla correspondiente 
	en funcion del tipo de documento*/
	
	iResul = iDBTomarSecuencia(	pstCobros->iCodTipDocum, pstCobros->iCodCentremi, pstCobros->szLetra, &lhNumSecuenci );
	
	/* si falla la obtencion de la secuencia se aborta el proceso */
	if( iResul ) return FALSE;
	
	/* si recupero la secuencia, lleana la estructura de datos adecuada */
	
	pstCobros->lNumSecuenci = lhNumSecuenci;
	pstCobros->lCodAgente   = 100001; 
	pstCobros->iColumna     = 1;
	pstCobros->iCodProducto = 5;
	pstCobros->iIndContado   = 0;
	pstCobros->iIndFacturado = 1;
	strncpy (pstCobros->szFecEfectividad, szSysDate,8);
	strncpy (pstCobros->szFecVencimie   , szSysDate,8);
	strncpy (pstCobros->szFecCaducida   , szSysDate,8);
	strncpy (pstCobros->szFecAntiguedad , szSysDate,8);
	strncpy  (pstCobros->szFecPago      , szSysDate,8);
	pstCobros->szFecEfectividad[8] ='\0';
	pstCobros->szFecVencimie   [8] ='\0';
	pstCobros->szFecCaducida   [8] ='\0';
	pstCobros->szFecAntiguedad [8] ='\0';
	pstCobros->szFecPago       [8] ='\0';
	pstCobros->iDiasVencimiento = 0         ;
	pstCobros->lNumAbonado      = 0         ;
	pstCobros->lNumFolio        = lhNumSecuenci         ;
	pstCobros->lNumCuota        = NULL      ;
	pstCobros->iSecCuota        = NULL      ;
	pstCobros->lNumTransa       = NULL      ;
	pstCobros->lNumVenta        = NULL      ;
	
	/* buscamos la operadora y plaza del cliente */
	/* EXEC SQL
	SELECT COD_OPERADORA, 
		   Fn_Obtiene_PlazaCliente( :lhCodCliente )
	INTO  :szhCodOperadoraScl, 
		   :szhCodPlaza
	FROM  GE_CLIENTES
	WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_OPERADORA ,Fn_Obtiene_PlazaCliente(:b0) into :b1,\
:b2  from GE_CLIENTES where COD_CLIENTE=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )194;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[2] = (unsigned long )6;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
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


	
	if( sqlca.sqlcode != SQLOK )	{
		vDTrazasError( szExeName, "\n\t\t=> Cliente => [%d] Error al recuperar OPERADORA.",LOG03, lhCodCliente );
		return FALSE;
	}
	
	rtrim( szhCodOperadoraScl );
	rtrim( szhCodPlaza );
	vDTrazasLog( szExeName, "\n\t\tszhCodOperadoraScl [%s] - szhCodPlaza  [%s]", LOG04, szhCodOperadoraScl,szhCodPlaza);
	
	/* EXEC SQL
	SELECT PREF_PLAZA
	INTO  :szhPrefPlaza
	FROM  GE_OPERPLAZA_TD
	WHERE COD_OPERADORA_SCL = :szhCodOperadoraScl
	AND   COD_PLAZA = :szhCodPlaza; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select PREF_PLAZA into :b0  from GE_OPERPLAZA_TD where (COD_\
OPERADORA_SCL=:b1 and COD_PLAZA=:b2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )225;
 sqlstm.selerr = (unsigned short)1;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodOperadoraScl;
 sqlstm.sqhstl[1] = (unsigned long )6;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCodPlaza;
 sqlstm.sqhstl[2] = (unsigned long )6;
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


	   
	if( sqlca.sqlcode != SQLOK )	{
		vDTrazasError( szExeName, "\n\t\t=> Cliente => [%d] Error al recuperar PREFIJO PLAZA.",LOG03, lhCodCliente );
		return FALSE;
	}

	rtrim( szhPrefPlaza );

	strcpy( pstCobros->szPrefPlaza, szhPrefPlaza );				/* mgg 04-02-03 */
	strcpy( pstCobros->szCodOperadoraScl, szhCodOperadoraScl );	/* mgg 04-02-03 */
	strcpy( pstCobros->szCodPlaza, szhCodPlaza );				/* mgg 04-02-03 */

	vDTrazasLog (szExeName,	"\n\t\t* Contenido stCobros  "
							"\n\t\t=> Cod.TipDocum  [%d] "
							"\n\t\t=> Cod.Agente    [%ld]" 
							"\n\t\t=> Letra         [%s] "
							"\n\t\t=> Cod.CentrEmi  [%d] "
							"\n\t\t=> Num.Secuenci  [%ld]"
							"\n\t\t=> Columna       [%d] "
							"\n\t\t=> Cod.Producto  [%d] "
							"\n\t\t=> Cod.Concepto  [%d] "
							"\n\t\t=> Imp.Haber     [%f] "
							"\n\t\t=> Imp.Debe      [%f] "
							"\n\t\t=> Num.Transacc. [%ld]"
							"\n\t\t=> Num.Venta     [%ld]"
							"\n\t\t=> Num.Cuota     [%ld]"
							"\n\t\t=> Sec.Cuotra    [%d] "
							"\n\t\t=> Num.Folio     [%ld]"
							"\n\t\t=> Num.Abonado   [%ld]"
							"\n\t\t=> Ind.Contado   [%d] "
							"\n\t\t=> Ind.Facturado [%d] "
							"\n\t\t=> Fec.Vencimie  [%s] "
							"\n\t\t=> Fec.Efectivid.[%s] "
							"\n\t\t=> Fec.Caducida  [%s] " 
							"\n\t\t=> Fec.Antiguedad[%s] "
							"\n\t\t=> Fec.Pago      [%s] " 
							"\n\t\t=> Num.CTC       [%s] "
							"\n\t\t=> Dias.Vencimie.[%d] " 
							"\n\t\t=> Pref Plaza.   [%s] " 
							"\n\t\t=> Operadora.    [%s] " 
							"\n\t\t=> Plaza.        [%s] ", 
							LOG04, 
							pstCobros->iCodTipDocum,
							pstCobros->lCodAgente,
							pstCobros->szLetra,
							pstCobros->iCodCentremi,
							pstCobros->lNumSecuenci,
							pstCobros->iColumna,
							pstCobros->iCodProducto,
							pstCobros->iCodConcepto,
							pstCobros->dImporteHaber,
							pstCobros->dImporteDebe,
							pstCobros->lNumTransa,
							pstCobros->lNumVenta,
							pstCobros->lNumCuota,
							pstCobros->iSecCuota,
							pstCobros->lNumFolio,
							pstCobros->lNumAbonado,
							pstCobros->iIndContado,
							pstCobros->iIndFacturado,
							pstCobros->szFecVencimie,
							pstCobros->szFecEfectividad,
							pstCobros->szFecCaducida,
							pstCobros->szFecAntiguedad,
							pstCobros->szFecPago,
							pstCobros->szFolioCTC,
							pstCobros->iDiasVencimiento,
							pstCobros->szPrefPlaza,			/* mgg 04-02-03 */
							pstCobros->szCodOperadoraScl,	/* mgg 04-02-03 */
							pstCobros->szCodPlaza );		/* mgg 04-02-03 */
 
 	return TRUE;
}/**************************** Final bfnAjuCobros ****************************/

/*****************************************************************************/
/*                         funcion : bfnPagoAjuste                           */
/*****************************************************************************/
static BOOL bfnPagoAjuste (DATDOC *pstDatDoc, DATPAG *pstDatPag, DATCON *pstCobros)
{

  /* inserta documento generado en la tabla CO_PAGOS */
  if( !bfnDBInsertPagos( pstDatDoc, pstDatPag, stDatosGener.szOficinaPago ) )
  {
       vDTrazasError (szExeName, "\n\t\t=> Error funcion (Cobros) : bfnDBInsertPagos",LOG03);
       return FALSE ;
  }

  if (pstCobros->dImporteDebe > 0 ) /* si tiene saldo a favor inserta en la Co_PagosConc */
  {
  	/* intenta obtener la secuencia de la proxima columna */	
  	if( !bfnDBSecCol( pstCobros ) ) return FALSE;

	/* inserta documento generado en la tabla CO_PAGOSCONC */
  	if (!bfnDBInsertPagosConc(*pstDatDoc, *pstCobros))
  	{
       		vDTrazasError (szExeName,"\n\t\t=> Error funcion (Cobros) : bfnDBInsPagoConc", LOG03);
       		return FALSE ;
  	}
  }

  /* Inserta documento en la CO_AJUSTES */
  if (!bfnDBInsertAjustes (*pstCobros, *pstDatPag))
  {
       vDTrazasError (szExeName, "\n\t\t=> Error funcion (Cobros) : bfnDBInsertAjustes", LOG03);
       return FALSE ;
  }

  /* Inserta documentos en la CO_AJUSTESCONC */
  if (!bfnDBInsertAjusteConc(*pstCobros))
  {
       vDTrazasError (szExeName,"\n\t\t=> Error funcion (Cobros) : bfnDBInsAjusteConc",LOG03);
       return FALSE ;
  }
  
  return TRUE; 
}/**************************** Final bfnPagoAjuste ***************************/

/*****************************************************************************/
/*                             funcion : bfnDBInsertPagos                    */
/*****************************************************************************/
static BOOL bfnDBInsertPagos (DATDOC *pstDatDoc, DATPAG *pstDatPag, char *szOficina)
{
int	iResul = 0;

  vDTrazasLog (szExeName,"\n\t\t* Insert=> Co_Pagos"
                         "\n\t\t=> Cod.TipDocum [%d] "
                         "\n\t\t=> Cod.CentrEmi [%d] " 
                         "\n\t\t=> Num.Secuenci [%ld]" 
                         "\n\t\t=> Cod.Vendedor [%ld]" 
                         "\n\t\t=> Letra        [%s] " 
                         "\n\t\t=> Cod.Cliente  [%ld]" 
                         "\n\t\t=> Imp.Pago     [%f] " 
                         "\n\t\t=> Nom.UsuarOra [%s] " 
                         "\n\t\t=> Cod.ForPago  [%d] " 
                         "\n\t\t=> Cod.SisPago  [%d] " 
                         "\n\t\t=> Cod.OriPago  [%d] " 
                         "\n\t\t=> Cod.CauPago  [%d] "
                         "\n\t\t=> Des.Pago     [%s] " , LOG05,
                         pstDatDoc->iCodTipDocum, pstDatDoc->iCodCentrEmi ,
                         pstDatDoc->lNumSecuenci, pstDatDoc->lCodAgente   ,
                         pstDatDoc->szLetra     , pstDatPag->lCodCliente  ,
                         pstDatPag->dImpPago    , pstDatPag->szNomUsu     ,
                         pstDatPag->iCodForPago ,
                         pstDatPag->iCodSisPago , pstDatPag->iCodOriPago  ,
                         pstDatPag->iCodCauPago , pstDatDoc->szDesPago);

   
     /* EXEC SQL INSERT INTO CO_PAGOS
             (COD_TIPDOCUM       ,
              COD_CENTREMI       ,
              NUM_SECUENCI       ,
              COD_VENDEDOR_AGENTE,
              LETRA              ,
              COD_CLIENTE        ,
              IMP_PAGO           ,
              FEC_EFECTIVIDAD    ,
              FEC_VALOR          ,
              NOM_USUARORA       ,
              COD_FORPAGO        ,
              COD_SISPAGO        ,
              COD_ORIPAGO        ,
              COD_CAUPAGO        ,
              COD_BANCO          ,
              COD_TIPTARJETA     ,
              COD_SUCURSAL       ,
              CTA_CORRIENTE      ,
              NUM_TARJETA        ,
              DES_PAGO           ,
              PREF_PLAZA)                   
       VALUES(:pstDatDoc->iCodTipDocum ,
              :pstDatDoc->iCodCentrEmi ,
              :pstDatDoc->lNumSecuenci ,
              :pstDatDoc->lCodAgente   ,
              :pstDatDoc->szLetra      ,
              :pstDatPag->lCodCliente  ,
              :pstDatPag->dImpPago     ,
               SYSDATE                 ,
               SYSDATE                 ,
              :pstDatPag->szNomUsu     ,
              :ihValor_cero            ,
              :pstDatPag->iCodSisPago  ,
              :pstDatPag->iCodOriPago  ,
              :pstDatPag->iCodCauPago  ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              NULL                     ,
              :pstDatDoc->szDesPago    ,
              :szPrefPlazaDefault); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CO_PAGOS (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CLIENTE,IMP_PAGO,FEC_EFECTIVIDAD,FEC_VALOR,\
NOM_USUARORA,COD_FORPAGO,COD_SISPAGO,COD_ORIPAGO,COD_CAUPAGO,COD_BANCO,COD_TIP\
TARJETA,COD_SUCURSAL,CTA_CORRIENTE,NUM_TARJETA,DES_PAGO,PREF_PLAZA) values (:b\
0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,SYSDATE,:b7,:b8,:b9,:b10,:b11,null ,null ,nu\
ll ,null ,null ,:b12,:b13)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )252;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&(pstDatDoc->iCodTipDocum);
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&(pstDatDoc->iCodCentrEmi);
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&(pstDatDoc->lNumSecuenci);
     sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&(pstDatDoc->lCodAgente);
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)(pstDatDoc->szLetra);
     sqlstm.sqhstl[4] = (unsigned long )2;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&(pstDatPag->lCodCliente);
     sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&(pstDatPag->dImpPago);
     sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)(pstDatPag->szNomUsu);
     sqlstm.sqhstl[7] = (unsigned long )31;
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&ihValor_cero;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&(pstDatPag->iCodSisPago);
     sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)&(pstDatPag->iCodOriPago);
     sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[10] = (         int  )0;
     sqlstm.sqindv[10] = (         short *)0;
     sqlstm.sqinds[10] = (         int  )0;
     sqlstm.sqharm[10] = (unsigned long )0;
     sqlstm.sqadto[10] = (unsigned short )0;
     sqlstm.sqtdso[10] = (unsigned short )0;
     sqlstm.sqhstv[11] = (unsigned char  *)&(pstDatPag->iCodCauPago);
     sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[11] = (         int  )0;
     sqlstm.sqindv[11] = (         short *)0;
     sqlstm.sqinds[11] = (         int  )0;
     sqlstm.sqharm[11] = (unsigned long )0;
     sqlstm.sqadto[11] = (unsigned short )0;
     sqlstm.sqtdso[11] = (unsigned short )0;
     sqlstm.sqhstv[12] = (unsigned char  *)(pstDatDoc->szDesPago);
     sqlstm.sqhstl[12] = (unsigned long )41;
     sqlstm.sqhsts[12] = (         int  )0;
     sqlstm.sqindv[12] = (         short *)0;
     sqlstm.sqinds[12] = (         int  )0;
     sqlstm.sqharm[12] = (unsigned long )0;
     sqlstm.sqadto[12] = (unsigned short )0;
     sqlstm.sqtdso[12] = (unsigned short )0;
     sqlstm.sqhstv[13] = (unsigned char  *)szPrefPlazaDefault;
     sqlstm.sqhstl[13] = (unsigned long )26;
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

         

	if (SQLCODE) {
   	iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_Pagos",szfnORAerror ());
	}

 return (SQLCODE)?FALSE:TRUE;
}/**************************** Final bfnDBInsertPagos ************************/

/*****************************************************************************/
/*                            funcion : bfnDBInsertPagosConc                 */
/*****************************************************************************/
static BOOL bfnDBInsertPagosConc( DATDOC stPago, DATCON stPagConc )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	static short i_shCodTipDocRel;
	static short i_shCodCentrRel;
	static short i_shNumSecuRel;
	static short i_shLetraRel;
	static short i_shCodAgenteRel;
	static short i_shCodConcepto;
	static short i_shImpConcepto;
	static short i_shColumna;
	static short i_shNumAbonado;
	static short i_shNumFolio;
	static short i_shNumCuota;
	static short i_shSecCuota;
	static short i_shNumTransa;
	static short i_shNumVenta;
	static short i_shFolioCTC;
/* EXEC SQL END DECLARE SECTION; */ 


   vDTrazasLog (szExeName,
                "\n\t\t* Insert=> Co_PagosConc"
                "\n\t\t=> Cod.TipDocum      [%d]"
                "\n\t\t=> Cod.CentrEmi      [%d]" 
                "\n\t\t=> Num.Secuenci      [%ld]" 
                "\n\t\t=> Cod.Agente        [%ld]" 
                "\n\t\t=> Letra             [%s]"
                "\n\t\t=> Imp.Concepto      [%f]" 
                "\n\t\t=> Cod.Producto      [%d]" 
                "\n\t\t=> Cod.TipDocRel     [%d]" 
                "\n\t\t=> Cod.AgenteRel     [%ld]"
                "\n\t\t=> Cod.CentrRel      [%ld]" 
                "\n\t\t=> Num.SecuRel       [%ld]" 
                "\n\t\t=> LetraRel          [%s]" 
                "\n\t\t=> Cod.Concepto      [%d]" 
                "\n\t\t=> Columna           [%d]" 
                "\n\t\t=> Num.Abonado       [%ld]"
                "\n\t\t=> Num.Folio         [%ld]"
                "\n\t\t=> Num.Cuota         [%ld]" 
                "\n\t\t=> Sec.Cuota         [%ld]" 
                "\n\t\t=> Num.Transacc.     [%ld]" 
                "\n\t\t=> Num.Venta         [%ld]" 
                "\n\t\t=> Num.FolioCTC      [%s]" 
                "\n\t\t=> szPrefPlaza       [%s]" 
                "\n\t\t=> szCodOperadoraScl [%s]" 
                "\n\t\t=> szCodPlaza        [%s]", 
                LOG05, 
                stPago.iCodTipDocum, 
                stPago.iCodCentrEmi, 
                stPago.lNumSecuenci, 
                stPago.lCodAgente,
                stPago.szLetra, 
                stPagConc.dImporteDebe, 
                stPagConc.iCodProducto, 
                stPagConc.iCodTipDocum,
                stPagConc.lCodAgente, 
                stPagConc.iCodCentremi,
                stPagConc.lNumSecuenci, 
                stPagConc.szLetra,
                stPagConc.iCodConcepto, 
                stPagConc.iColumna,
                stPagConc.lNumAbonado, 
                stPagConc.lNumFolio,
                stPagConc.lNumCuota, 
                stPagConc.iSecCuota,
                stPagConc.lNumTransa, 
                stPagConc.lNumVenta, 
                stPagConc.szFolioCTC,
                stPagConc.szPrefPlaza,
                stPagConc.szCodOperadoraScl,
                stPagConc.szCodPlaza );
  
	i_shCodCentrRel    = (stPagConc.iCodCentremi    == -1)?-1:0;
	i_shCodTipDocRel   = (stPagConc.iCodTipDocum    == -1)?-1:0;
	i_shLetraRel       = (stPagConc.szLetra [0]     ==  0)?-1:0;
	i_shNumSecuRel     = (stPagConc.lNumSecuenci    == -1)?-1:0;
	i_shCodAgenteRel   = (stPagConc.lCodAgente      == -1)?-1:0;
	i_shCodConcepto    = (stPagConc.iCodConcepto    == -1)?-1:0;
	i_shColumna        = (stPagConc.iColumna        == -1)?-1:0;
	i_shNumAbonado     = (stPagConc.lNumAbonado     == -1)?-1:0;
	i_shNumFolio       = (stPagConc.lNumFolio       == -1)?-1:0;
	i_shNumCuota       = (stPagConc.lNumCuota       == -1)?-1:0;
	i_shSecCuota       = (stPagConc.iSecCuota       == -1)?-1:0;
	i_shNumVenta       = (stPagConc.lNumVenta       == -1)?-1:0;
	i_shNumTransa      = (stPagConc.lNumTransa      == -1)?-1:0;  
	i_shFolioCTC       = (stPagConc.szFolioCTC [0]  ==  0)?-1:0;

	/* EXEC SQL INSERT INTO CO_PAGOSCONC (
                        COD_TIPDOCUM,
                        COD_CENTREMI,
                        NUM_SECUENCI,
                        COD_VENDEDOR_AGENTE,
                        LETRA,
                        IMP_CONCEPTO,
                        COD_PRODUCTO,
                        COD_TIPDOCREL,
                        COD_CENTRREL,
                        NUM_SECUREL,
                        COD_AGENTEREL,
                        LETRA_REL,
                        COD_CONCEPTO,
                        COLUMNA,
                        NUM_ABONADO,
                        NUM_FOLIO,
                        NUM_CUOTA,
                        SEC_CUOTA,
                        NUM_TRANSACCION,
                        NUM_VENTA,
                        NUM_FOLIOCTC,
					         PREF_PLAZA         , 
					         COD_OPERADORA_SCL  , 
					         COD_PLAZA          ) 
                 VALUES(:stPago.iCodTipDocum,
                        :stPago.iCodCentrEmi,
                        :stPago.lNumSecuenci,
                        :stPago.lCodAgente,
                        :stPago.szLetra,
                        :stPagConc.dImporteDebe,
                        :stPagConc.iCodProducto,
                        :stPagConc.iCodTipDocum   :i_shCodTipDocRel,
                        :stPagConc.iCodCentremi   :i_shCodCentrRel,
                        :stPagConc.lNumSecuenci   :i_shNumSecuRel,   
                        :stPagConc.lCodAgente     :i_shCodAgenteRel,
                        :stPagConc.szLetra        :i_shLetraRel,
                        :stPagConc.iCodConcepto   :i_shCodConcepto,
                        :stPagConc.iColumna       :i_shColumna,
                        :stPagConc.lNumAbonado    :i_shNumAbonado,
                        :stPagConc.lNumFolio      :i_shNumFolio,
                        :stPagConc.lNumCuota      :i_shNumCuota,
                        :stPagConc.iSecCuota      :i_shSecCuota,
                        :stPagConc.lNumTransa     :i_shNumTransa,
                        :stPagConc.lNumVenta      :i_shNumVenta,
                        :stPagConc.szFolioCTC     :i_shFolioCTC,
		                  :stPagConc.szPrefPlaza,
		                  :stPagConc.szCodOperadoraScl,
		                  :stPagConc.szCodPlaza ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCREL,COD_CEN\
TRREL,NUM_SECUREL,COD_AGENTEREL,LETRA_REL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,NUM\
_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC,PREF_PLAZA,C\
OD_OPERADORA_SCL,COD_PLAZA) values (:b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7:b8,:b9:b10\
,:b11:b12,:b13:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:\
b28,:b29:b30,:b31:b32,:b33:b34,:b35,:b36,:b37)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )323;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&(stPago.iCodTipDocum);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&(stPago.iCodCentrEmi);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(stPago.lNumSecuenci);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&(stPago.lCodAgente);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(stPago.szLetra);
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&(stPagConc.dImporteDebe);
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&(stPagConc.iCodProducto);
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&(stPagConc.iCodTipDocum);
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)&i_shCodTipDocRel;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&(stPagConc.iCodCentremi);
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)&i_shCodCentrRel;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&(stPagConc.lNumSecuenci);
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)&i_shNumSecuRel;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&(stPagConc.lCodAgente);
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)&i_shCodAgenteRel;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(stPagConc.szLetra);
 sqlstm.sqhstl[11] = (unsigned long )2;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)&i_shLetraRel;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&(stPagConc.iCodConcepto);
 sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)&i_shCodConcepto;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&(stPagConc.iColumna);
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)&i_shColumna;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&(stPagConc.lNumAbonado);
 sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)&i_shNumAbonado;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&(stPagConc.lNumFolio);
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)&i_shNumFolio;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&(stPagConc.lNumCuota);
 sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)&i_shNumCuota;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&(stPagConc.iSecCuota);
 sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&i_shSecCuota;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&(stPagConc.lNumTransa);
 sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)&i_shNumTransa;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)&(stPagConc.lNumVenta);
 sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[19] = (         int  )0;
 sqlstm.sqindv[19] = (         short *)&i_shNumVenta;
 sqlstm.sqinds[19] = (         int  )0;
 sqlstm.sqharm[19] = (unsigned long )0;
 sqlstm.sqadto[19] = (unsigned short )0;
 sqlstm.sqtdso[19] = (unsigned short )0;
 sqlstm.sqhstv[20] = (unsigned char  *)(stPagConc.szFolioCTC);
 sqlstm.sqhstl[20] = (unsigned long )12;
 sqlstm.sqhsts[20] = (         int  )0;
 sqlstm.sqindv[20] = (         short *)&i_shFolioCTC;
 sqlstm.sqinds[20] = (         int  )0;
 sqlstm.sqharm[20] = (unsigned long )0;
 sqlstm.sqadto[20] = (unsigned short )0;
 sqlstm.sqtdso[20] = (unsigned short )0;
 sqlstm.sqhstv[21] = (unsigned char  *)(stPagConc.szPrefPlaza);
 sqlstm.sqhstl[21] = (unsigned long )26;
 sqlstm.sqhsts[21] = (         int  )0;
 sqlstm.sqindv[21] = (         short *)0;
 sqlstm.sqinds[21] = (         int  )0;
 sqlstm.sqharm[21] = (unsigned long )0;
 sqlstm.sqadto[21] = (unsigned short )0;
 sqlstm.sqtdso[21] = (unsigned short )0;
 sqlstm.sqhstv[22] = (unsigned char  *)(stPagConc.szCodOperadoraScl);
 sqlstm.sqhstl[22] = (unsigned long )6;
 sqlstm.sqhsts[22] = (         int  )0;
 sqlstm.sqindv[22] = (         short *)0;
 sqlstm.sqinds[22] = (         int  )0;
 sqlstm.sqharm[22] = (unsigned long )0;
 sqlstm.sqadto[22] = (unsigned short )0;
 sqlstm.sqtdso[22] = (unsigned short )0;
 sqlstm.sqhstv[23] = (unsigned char  *)(stPagConc.szCodPlaza);
 sqlstm.sqhstl[23] = (unsigned long )6;
 sqlstm.sqhsts[23] = (         int  )0;
 sqlstm.sqindv[23] = (         short *)0;
 sqlstm.sqinds[23] = (         int  )0;
 sqlstm.sqharm[23] = (unsigned long )0;
 sqlstm.sqadto[23] = (unsigned short )0;
 sqlstm.sqtdso[23] = (unsigned short )0;
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



	if( SQLCODE )  {
		iDError( szExeName, ERR000, vInsertarIncidencia, "Insert=> Co_PagosConc", szfnORAerror () );
	}
	
	return( SQLCODE ) ? FALSE : TRUE;
}/******************************* Final bfnDBInsertPagosConc *****************/


/*****************************************************************************/
/*                           funcion : bfnDBInsertAjustes                    */
/*****************************************************************************/
static BOOL bfnDBInsertAjustes (DATCON pstCobros, DATPAG pstDatPag)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char szGlosa[50] = "";
   int  ihTipoAjuste= 0 ;
   int  ihNCND      = 0 ; /* por default nota de debito*/
   double dhImpPago = 0;
/* EXEC SQL END DECLARE SECTION; */ 


   ihTipoAjuste = iTipoAjuste;
   
   if (iTipoAjuste==3) ihNCND=1 ; 
   
   dhImpPago = fabs(pstCobros.dImporteDebe - pstCobros.dImporteHaber);
   strcpy (szGlosa,"Ajuste Masivo en Cta. Cte.");

   vDTrazasLog (szExeName,"\n\t\t* Insert=> Co_Ajustes"
                         "\n\t\t=> Num.Secuenci [%ld]" 
                         "\n\t\t=> Cod.TipDocum [%d] "
                         "\n\t\t=> Cod.Vendedor [%ld]" 
                         "\n\t\t=> Letra        [%s] " 
                         "\n\t\t=> Cod.CentrEmi [%d] " 
                         "\n\t\t=> Cod.Cliente  [%ld]" 
                         "\n\t\t=> ImporteDebe  [%4f] " 
                         "\n\t\t=> Nom.UsuarOra [%s] " 
                         "\n\t\t=> Cod.TipAjus  [%d] " 
                         "\n\t\t=> Ind.NC       [%d] " 
                         "\n\t\t=> Ind.Procesa  [%d] "
                         "\n\t\t=> Des.Observ   [%s] " , LOG05,
                         pstCobros.lNumSecuenci, 
                         pstCobros.iCodTipDocum, 
			                pstCobros.lCodAgente  ,
                         pstCobros.szLetra     , 
			                pstCobros.iCodCentremi,
			                pstDatPag.lCodCliente, dhImpPago, 
			                pstDatPag.szNomUsu, 1, 1, 1, szGlosa);

  
     /* EXEC SQL INSERT INTO CO_AJUSTES
             (NUM_SECUENCI       ,
	           COD_TIPDOCUM       ,
              COD_VENDEDOR_AGENTE,
              LETRA              ,
              COD_CENTREMI       ,
              COD_CLIENTE        ,
              IMPORTE_DEBE       ,
              FEC_EFECTIVIDAD    ,
              NOM_USUARORA       ,
              COD_TIPAJUSTE      ,
              IND_NC             ,
              IND_PROCESADO      ,
              FEC_PROCESO        ,
              DES_OBSERVA)
       VALUES(:pstCobros.lNumSecuenci ,
	           :pstCobros.iCodTipDocum ,
              :pstCobros.lCodAgente   ,
              :pstCobros.szLetra      ,
              :pstCobros.iCodCentremi ,
              :pstDatPag.lCodCliente  ,
              :dhImpPago              ,
               SYSDATE                ,
              :pstDatPag.szNomUsu     ,
              :ihTipoAjuste           ,   /o tipo de ajuste o/
              :ihNCND                 ,   /o indicador nota de credito o/
              :ihValor_uno            ,   /o indicador procesado o/
              SYSDATE                 ,
              :szGlosa); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 24;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "insert into CO_AJUSTES (NUM_SECUENCI,COD_TIPDOCUM,COD_VE\
NDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CLIENTE,IMPORTE_DEBE,FEC_EFECTIVIDAD,NOM_\
USUARORA,COD_TIPAJUSTE,IND_NC,IND_PROCESADO,FEC_PROCESO,DES_OBSERVA) values (:\
b0,:b1,:b2,:b3,:b4,:b5,:b6,SYSDATE,:b7,:b8,:b9,:b10,SYSDATE,:b11)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )434;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&(pstCobros.lNumSecuenci);
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&(pstCobros.iCodTipDocum);
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&(pstCobros.lCodAgente);
     sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)(pstCobros.szLetra);
     sqlstm.sqhstl[3] = (unsigned long )2;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&(pstCobros.iCodCentremi);
     sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&(pstDatPag.lCodCliente);
     sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&dhImpPago;
     sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)(pstDatPag.szNomUsu);
     sqlstm.sqhstl[7] = (unsigned long )31;
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&ihTipoAjuste;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&ihNCND;
     sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
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
     sqlstm.sqhstv[11] = (unsigned char  *)szGlosa;
     sqlstm.sqhstl[11] = (unsigned long )50;
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



	if (SQLCODE)  {
     iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_Ajustes",szfnORAerror ());
   }

	return (SQLCODE)?FALSE:TRUE;
}/**************************** Final bfnDBInsertAjustes ************************/

/*****************************************************************************/
/*                           funcion : bfnDBInsertAjusteConc                 */
/*****************************************************************************/
static BOOL bfnDBInsertAjusteConc (DATCON pstCobros)
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	double	dhImpPago = 0;
/* EXEC SQL END DECLARE SECTION; */ 
	

	dhImpPago = fabs(pstCobros.dImporteDebe - pstCobros.dImporteHaber);
   vDTrazasLog (szExeName,
                "\n\t\t* Insert=> Co_AjusteConc"
                "\n\t\t=> Cod.TipDocum  [%d]  "
                "\n\t\t=> Cod.CentrEmi  [%d]  " 
                "\n\t\t=> Num.Secuenci  [%ld] " 
                "\n\t\t=> Cod.Agente    [%ld] " 
                "\n\t\t=> Letra         [%s]  "
                "\n\t\t=> Imp.Concepto  [%4f] " 
                "\n\t\t=> Ord.Sec       [%d]  ", LOG05, 
                pstCobros.iCodTipDocum      , pstCobros.iCodCentremi   , 
                pstCobros.lNumSecuenci      , pstCobros.lCodAgente     ,
                pstCobros.szLetra           , dhImpPago,
                1);

 
	/* EXEC SQL INSERT INTO CO_AJUSTECONC
                       (COD_TIPDOCUM       ,
                        COD_CENTREMI       ,
                        NUM_SECUENCI       ,
                        COD_VENDEDOR_AGENTE,
                        LETRA              ,
                        IMP_CONCEPTO       ,
                        COD_PRODUCTO       ,
                        COD_TIPDOCUMREL    ,
                        COD_CENTREMIREL    ,
                        NUM_SECUENCIREL    ,
                        COD_AGENTEREL      ,
                        LETRAREL           ,
                        NUM_ABONADO        ,
			               ORD_SEC			    )
                 VALUES(:pstCobros.iCodTipDocum      ,
                        :pstCobros.iCodCentremi      ,
                        :pstCobros.lNumSecuenci      ,
                        :pstCobros.lCodAgente        ,
                        :pstCobros.szLetra           ,
                        :dhImpPago                   ,
                        NULL   ,
                        NULL   ,
                        NULL   ,
                        NULL   ,
                        NULL   ,
                        NULL   ,
                        NULL   ,
                        :ihValor_uno); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_AJUSTECONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SEC\
UENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCUMREL,COD_\
CENTREMIREL,NUM_SECUENCIREL,COD_AGENTEREL,LETRAREL,NUM_ABONADO,ORD_SEC) values\
 (:b0,:b1,:b2,:b3,:b4,:b5,null ,null ,null ,null ,null ,null ,null ,:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )497;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&(pstCobros.iCodTipDocum);
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&(pstCobros.iCodCentremi);
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(pstCobros.lNumSecuenci);
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&(pstCobros.lCodAgente);
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(pstCobros.szLetra);
 sqlstm.sqhstl[4] = (unsigned long )2;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&dhImpPago;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_uno;
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




  if (SQLCODE)  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Insert=> Co_AjusteConc",szfnORAerror ());
  }

  return (SQLCODE)?FALSE:TRUE;

}/******************************* Final bfnDBInsertAjusteConc *****************/

/****************************************************************************************************/
/* rtrim()																		   					*/
/****************************************************************************************************/
void rtrim( char *szCadena )
/*
	Definicion		:	Quita los espacios en blanco a la derecha de una cadena.
	Parametros		:	szCadena	cadena de trabajo.
*/
{
char modulo[] = "rtrim";
int i, iLen, iCnt;

    iLen = strlen( szCadena ) - 1;
    for( iCnt = iLen; iCnt >= 0; iCnt-- ) if( szCadena[iCnt] != ' ' && szCadena[iCnt] != '\0' ) break;
    szCadena[ iCnt + 1 ] = '\0'; 	/* reemplaza primer ' ' por '\0' produciendo un rtrim */
    return;
} /* void rtrim( char *szCadena ) */

/****************************************************************************************************/
/* ifnValidaConceptos() : Selecciona los conceptos a cancelar           		   					*/
/****************************************************************************************************/
int ifnValidaConceptos( long lCodCliente ) 
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhCodCliente;
		int		ihCodTipConcepto;
		double	dhImporteConcepto;
		char	szhCARTERA[11];
		char	szhTIPDOCUM[13];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	char	modulo[] = "ifnValidaConceptos";
	int		iRes = 1;

   	vDTrazasLog( szExeName, "\n\t\t===================================================================.", LOG03 );
   	vDTrazasLog( szExeName, "\t\t===================================================================.", LOG03 );
   	vDTrazasLog( szExeName, "\n\t\tCliente => [%ld] Ingreso MODULO [%s].", LOG03, lCodCliente, modulo );

	lhCodCliente = lCodCliente;
	strcpy( szhCARTERA, "CO_CARTERA" );
	strcpy( szhTIPDOCUM, "COD_TIPDOCUM" );

	/* EXEC SQL DECLARE CurValConceptos CURSOR FOR
	SELECT ct.cod_tipconce,
		   ca.importe_debe - ca.importe_haber 
	  FROM co_tipconcep ct, co_conceptos cc, co_cartera ca
	 WHERE ct.cod_tipconce = cc.cod_tipconce
	   AND cc.cod_concepto = ca.cod_concepto  
	   AND ca.cod_tipdocum NOT IN (	SELECT TO_NUMBER( cod_valor )
									  FROM co_codigos
									 WHERE nom_tabla   = :szhCARTERA
									   AND nom_columna = :szhTIPDOCUM )
	   AND ca.cod_cliente = :lhCodCliente; */ 


	if (SQLCODE != SQLOK) 
	{
		iDError( szExeName, ERR000, vInsertarIncidencia, "En DECLARE CurValConceptos.\n ", szfnORAerror() );
		return -1;
	}

	/* EXEC SQL OPEN CurValConceptos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0012;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )540;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCARTERA;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhTIPDOCUM;
 sqlstm.sqhstl[1] = (unsigned long )13;
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


	if (SQLCODE != SQLOK) 
	{
		iDError( szExeName, ERR000, vInsertarIncidencia, "En OPEN CurValConceptos.\n ", szfnORAerror() );
		return -1;
	}

    while(1) 
    {
		/* EXEC SQL
		FETCH CurValConceptos
	  	 INTO :ihCodTipConcepto,
	  	 	  :dhImporteConcepto; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 24;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )567;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipConcepto;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhImporteConcepto;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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



        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) 
        {
			iDError( szExeName, ERR000, vInsertarIncidencia, "En FETCH CurValConceptos.\n ", szfnORAerror() );
			iRes = -1;
			break;
        }

        if( SQLCODE == SQLNOTFOUND ) 
        {
	    	vDTrazasLog( szExeName, "\n\t\tTermino revision de conceptos del cliente [%ld].", LOG03, lhCodCliente );
        	iRes = 1;
        	break;
        }

		vDTrazasLog (szExeAjustes,"\n\t\tTipo Concepto => [%d] Importe Concepto => [%.4f]", LOG03, ihCodTipConcepto, dhImporteConcepto );

		if( ihCodTipConcepto == 2 || ihCodTipConcepto == 6 ) /* son abonos */
		{	
			if ( dhImporteConcepto >= 0 ) /* esto quiere decir que el debe es mayor al haber */
			{	
				vDTrazasLog( szExeAjustes, "\n\t\t!! ATENCION ¡¡ CLIENTE => [%ld] SALDO DE ABONO INCONSISTENTE.", LOG03, lhCodCliente );
				iRes = 0;
				break;
			}
		}
		else /* son cargos */
		{	
			if ( dhImporteConcepto <= 0 ) /* esto quiere decir que el haber es mayor al debe */
			{	
				vDTrazasLog( szExeAjustes, "\n\t\t!! ATENCION ¡¡ CLIENTE => [%ld] SALDO DE CARGO INCONSISTENTE.", LOG03, lhCodCliente );
				iRes = 0;
				break;
			}
		}
    } /* while(1) */

    /* EXEC SQL 
    CLOSE CurValConceptos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )590;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if (SQLCODE != SQLOK) 
    {
        iDError(modulo,ERR000,vInsertarIncidencia,"En CLOSE Cur_Canga.\n ",SQLERRM);
        iRes = -1;
    }

	vDTrazasLog( szExeAjustes, "\n\t\tFin funcion ifnValidaConceptos.", LOG03 );

    return iRes;
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

