
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
    "./pc/His_Ventas.pc"
};


static unsigned int sqlctx = 13832387;


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
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

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
{12,4128,2,27,0,
5,0,0,1,947,0,3,56,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,2,52,0,2,155,0,0,1,1,0,1,0,1,97,0,0,
43,0,0,3,48,0,1,282,0,0,0,0,0,1,0,
58,0,0,4,0,0,30,341,0,0,0,0,0,1,0,
};


/*****************************************************************************/
/* Programa encargado de generar registros historicos de tablas de venta     */
/*---------------------------------------------------------------------------*/
/* Version 2 - Revision 00.                                                  */
/* Inicio: Jueves 11 de Julio de 2002 .                                      */
/* Fin:                                                                      */
/* Autor : Nelson Contreras Helena                                           */
/*****************************************************************************/
/* Modificacion                                                              */
/* Inicio  Jueves 23 de Enero de 2003                                        */
/* Autor   Jaime Vargas Morales                                              */
/* Descripcion : se incorporaron nuevos campos a la tabla CMT_HABIL_CELULAR  */
/*               COD_TECNOLOGIA VARCHAR2(7) , IND_CONVENIO NUMBER(1)         */
/*---------------------------------------------------------------------------*/
/* 20030930 Marcelo Quiroz G. Versionado Cuzco.                              */
/* Se filtra carga de tablas historicas por los campos ID_PERIODO            */
/*                                                                           */
/*****************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "His_Ventas.h"
#include "GEN_biblioteca.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
/* EXEC SQL END DECLARE SECTION; */ 


/*---------------------------------------------------------------------------*/
/* Carga Tablas Historicas                                                   */
/*---------------------------------------------------------------------------*/
int  iCargaTablasHist()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIdPeriodo[11];
		char	szNomTablaProceso[31];
		char	szNomTablaHistorica[31];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);
	
	fprintf(pfLog , "\n[iCargaTablasHist] Carga los datos en Histórico Ciclo:[%s]\n", szhIdPeriodo);
	fprintf(stderr, "\n[iCargaTablasHist] Carga los datos en Histórico Ciclo:[%s]\n", szhIdPeriodo);
	
	/* EXEC SQL
    	INSERT INTO CM_HABIL_CELULAR_TH 
                (NUM_GENERAL, 
                 NUM_VENTA, 
                 FEC_VENTA, 
                 FEC_RECEPCION, 
                 FEC_ACEPTACION, 
                 NUM_CONTRATO, 
                 COD_MODVENTA, 
                 IND_DOCUM, 
                 COD_OFICINA, 
                 COD_TIPCOMIS, 
                 COD_COMISIONISTA, 
                 COD_AGENCIA, 
                 COD_VEND_FINAL, 
                 COD_CLIENTE, 
                 NUM_ABONADO, 
                 COD_AFINIDAD, 
                 NUM_CELULAR, 
                 NUM_IDENT, 
                 COD_CATEGCLIENTE, 
                 COD_PLANTARIF, 
                 NUM_SERIE, 
                 COD_ARTICULO, 
                 IND_PROCEQUI, 
                 NUM_DIAS_REALES, 
                 NUM_DIAS_HABILES, 
                 COD_PERIODO, 
                 ID_PERIODO, 
                 OBS_INCUMP,
                 COD_TECNOLOGIA,
                 IND_CONVENIO,
                 COD_TIPORED,
                 COD_TIPVENDEDOR)
                (SELECT NUM_GENERAL, 
		                 NUM_VENTA, 
		                 FEC_VENTA, 
		                 FEC_RECEPCION, 
		                 FEC_ACEPTACION, 
		                 NUM_CONTRATO, 
		                 COD_MODVENTA, 
		                 IND_DOCUM, 
		                 COD_OFICINA, 
		                 COD_TIPCOMIS, 
		                 COD_COMISIONISTA, 
		                 COD_AGENCIA, 
		                 COD_VEND_FINAL, 
		                 COD_CLIENTE, 
		                 NUM_ABONADO, 
		                 COD_AFINIDAD, 
		                 NUM_CELULAR, 
		                 NUM_IDENT, 
		                 COD_CATEGCLIENTE, 
		                 COD_PLANTARIF, 
		                 NUM_SERIE, 
		                 COD_ARTICULO, 
		                 IND_PROCEQUI, 
		                 NUM_DIAS_REALES, 
		                 NUM_DIAS_HABILES, 
		                 COD_PERIODO, 
		                 ID_PERIODO, 
		                 OBS_INCUMP,
		                 COD_TECNOLOGIA,
		                 IND_CONVENIO,
		                 COD_TIPORED,
		                 COD_TIPVENDEDOR
                 FROM CMT_HABIL_CELULAR
                WHERE ID_PERIODO = :szhIdPeriodo); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CM_HABIL_CELULAR_TH (NUM_GENERAL,NUM_VENTA,FEC_V\
ENTA,FEC_RECEPCION,FEC_ACEPTACION,NUM_CONTRATO,COD_MODVENTA,IND_DOCUM,COD_OFIC\
INA,COD_TIPCOMIS,COD_COMISIONISTA,COD_AGENCIA,COD_VEND_FINAL,COD_CLIENTE,NUM_A\
BONADO,COD_AFINIDAD,NUM_CELULAR,NUM_IDENT,COD_CATEGCLIENTE,COD_PLANTARIF,NUM_S\
ERIE,COD_ARTICULO,IND_PROCEQUI,NUM_DIAS_REALES,NUM_DIAS_HABILES,COD_PERIODO,ID\
_PERIODO,OBS_INCUMP,COD_TECNOLOGIA,IND_CONVENIO,COD_TIPORED,COD_TIPVENDEDOR)(s\
elect NUM_GENERAL ,NUM_VENTA ,FEC_VENTA ,FEC_RECEPCION ,FEC_ACEPTACION ,NUM_CO\
NTRATO ,COD_MODVENTA ,IND_DOCUM ,COD_OFICINA ,COD_TIPCOMIS ,COD_COMISIONISTA ,\
COD_AGENCIA ,COD_VEND_FINAL ,COD_CLIENTE ,NUM_ABONADO ,COD_AFINIDAD ,NUM_CELUL\
AR ,NUM_IDENT ,COD_CATEGCLIENTE ,COD_PLANTARIF ,NUM_SERIE ,COD_ARTICULO ,IND_P\
ROCEQUI ,NUM_DIAS_REALES ,NUM_DIAS_HABILES ,COD_PERIODO ,ID_PERIODO ,OBS_INCUM\
P ,COD_TECNOLOGIA ,IND_CONVENIO ,COD_TIPORED ,COD_TIPVENDEDOR  from CMT_HABIL_\
CELULAR where ID_PERIODO=:b0)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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
 if (sqlca.sqlcode < 0) vSqlError();
}


    
    if ( sqlca.sqlcode != SQLOK )
    {
         fprintf(pfLog , "\n[iCargaTablasHist] Error al insertar en CM_HABIL_CELULAR_TH ORA[%d]\n",sqlca.sqlcode);
         fprintf(stderr, "\n[iCargaTablasHist] Error al insertar en CM_HABIL_CELULAR_TH ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }
    
    strcpy(szNomTablaProceso, "CMT_HABIL_CELULAR");
    strcpy(szNomTablaHistorica, "CM_HABIL_CELULAR_TH");
    
    vCierraEnlace(szNomTablaProceso,szNomTablaHistorica,szhIdPeriodo);
    
    stStatusProc.lRegInsertos = sqlca.sqlerrd[2] ;
    return TRUE;
}
/*---------------------------------------------------------------------------*/
/* Borra tablas actuales                                                    */
/*---------------------------------------------------------------------------*/
int iBorraTablasTo()
{
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char	szhIdPeriodo[11];
		int		iCantidad;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);
	
	fprintf(pfLog , "\n[iBorraTablasTo] Borra los datos de Proceso Ciclo:[%s]\n", szhIdPeriodo);
	fprintf(stderr, "\n[iBorraTablasTo] Borra los datos de Proceso Ciclo:[%s]\n", szhIdPeriodo);
	
	/* EXEC SQL DELETE FROM CMT_HABIL_CELULAR WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CMT_HABIL_CELULAR  where ID_PERIODO=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )24;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
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
 if (sqlca.sqlcode < 0) vSqlError();
}

 

    if ( sqlca.sqlcode != SQLOK )
    {
         fprintf(pfLog , "\n[iBorraTablasTo]Error al borrar CMT_HABIL_CELULAR ORA[%d]\n",sqlca.sqlcode);
         fprintf(stderr, "\n[iBorraTablasTo]Error al borrar CMT_HABIL_CELULAR ORA[%d]\n",sqlca.sqlcode);
         return FALSE;
    }
    
    iCantidad = sqlca.sqlerrd[2];
    fprintf(pfLog , "\n[iBorraTablasTo] Registros Eliminados:[%d].\n", iCantidad);
    fprintf(stderr, "\n[iBorraTablasTo] Registros Eliminados:[%d].\n", iCantidad);    
    return TRUE ;
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
	long  lSegIni, lSegFin;         
	short ibiblio;                      
    int   iRetorno;
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();    
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
    memset(&stCiclo, 0, sizeof(reg_ciclo));   
    memset(&stStatusProc, 0, sizeof(rg_estadistica));
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
    memset(&stArgs, 0, sizeof(rg_argumentos));
    vManejaArgs(argc, argv);        
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
	fprintf(stderr, "\nstArgs.szUser        [%s]\n", stArgs.szUser);
	fprintf(stderr, "\nstArgs.szPass        [%s]\n", stArgs.szPass);
	
	strcpy(szhUser, stArgs.szUser);                                                      
	strcpy(szhPass, stArgs.szPass);                                                    
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
/*---------------------------------------------------------------------------*/
/* Inicia estructura de proceso y bloques.                                   */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUser, stArgs.izSecuencia);
    ibiblio = iAccesa_Traza_Procesos(ABRIR_TRAZA,0,"",0,0);
    if (ibiblio)
    {
       fprintf(stderr, "Error al Abrir Traza");
       fprintf(stderr, "Error [%d] al escribir Traza de Proceso.\n", ibiblio);
       exit(ibiblio);
    }        
/*---------------------------------------------------------------------------*/
/* Configuracion de idioma espanol para tratamiento de fechas.               */
/*---------------------------------------------------------------------------*/
    if(strcmp(getenv("LC_TIME"), LC_TIME_SPANISH) == 0)
    {
       setlocale(LC_TIME, LC_TIME_SPANISH);
    }
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
   fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
   if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)
   {
       exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));
   }
   if((pszEnvCfg = (char *)pszEnviron("XPCM_CFG", "")) == (char *)NULL)
   {
       exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_CFG NO RECONOCIDA.",0,0));
   }
       
   fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);
/*------------------------------------------------------------*/        
/* Ingresa parametros para estructura que crea archivo de Log */
/*------------------------------------------------------------*/  
	strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
        strncpy(szhSysDate, pszGetDateLog(),16);                                                            
	strcpy(stArgsLog.szProceso,LOGNAME);                                                                     
	strncpy(stArgsLog.szSysDate,szhSysDate,16);                                                                  
	sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
	                                                                                                         
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)                                                          
	{                                                                                                        
	    fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", LOGNAME);                                 
	    fprintf(stderr, "Revise su existencia.\n");                                                          
	    fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
	    fprintf(stderr, "Proceso finalizado con error.\n");                                                  
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE DATOS NO PUDO SER ABIERTO.",0,0));
	}                                                                                                               
/*---------------------------------------------------------------------------*/
/* Header.                                                                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                               
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision: [%s]\n", LAST_REVIEW);      
    fprintf(pfLog, "Base de datos       : [%s]\n", (strcmp(getenv((const char *)"TWO_TASK"), "")!=0?getenv((const char *)"TWO_TASK"):getenv((const char *)"ORACLE_SID")));
    fprintf(pfLog, "Usuario ORACLE      : [%s]\n",(char * )sysGetUserName());                            
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )43;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/* Procesamiento principal.                                                  */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de ciclo de proceso...\n\n");       
    fprintf(stderr, "Carga estructura de ciclo de proceso...\n\n");       
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	exit(EXIT_101);
    }
    
/*---------------------------------------------------------------------------------------------*/
/*    - Carga tablas                                                      */
/*---------------------------------------------------------------------------------------------*/
    vFechaHora();
	fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
	fprintf(pfLog ,"\n(vCargaTablasHist) Carga Tablas Historicas.\n");
	fprintf(stderr,"\n(vCargaTablasHist) Carga Tablas Historicas.\n");
    iRetorno = iCargaTablasHist();       
/*---------------------------------------------------------------------------------------------*/
/*    - Borra tablas ya pasadas a historico                                                    */
/*---------------------------------------------------------------------------------------------*/
    if ( iRetorno )
    {
    	vFechaHora();
		fprintf(pfLog, "[%s]\n", (char *)pszGetDateLog());
		fprintf(pfLog ,"\n(iBorraTablasTo) Borra Tablas Actuales.\n");
		fprintf(stderr,"\n(iBorraTablasTo) Borra Tablas Actuales.\n");
        iRetorno = iBorraTablasTo(); 
    }
    else
        fprintf(pfLog ,"No Carga tablas Historicas , proceso con ERROR\n");	            
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
	fprintf(pfLog,  "Estadistica del proceso\n");
	fprintf(pfLog,  "------------------------\n");
	fprintf(pfLog,  "Segundos Reales Utilizados             : [%d]\n\n", stStatusProc.lSegProceso);
	fprintf(pfLog,  "Registros pasados a historico Ventas   : [%d]\n"  , stStatusProc.lRegInsertos);   
	
	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr,"------------------------\n");
	fprintf(stderr, "Segundos Reales Utilizados             : [%d]\n\n", stStatusProc.lSegProceso);
	fprintf(stderr, "Registros pasados a historico Ventas   : [%d]\n"  , stStatusProc.lRegInsertos);   
/*---------------------------------------------------------------------------*/
    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,stStatusProc.lRegInsertos);
	if (ibiblio)
	        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
	/* EXEC SQL COMMIT WORK RELEASE; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )58;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
 if (sqlca.sqlcode < 0) vSqlError();
}


	
	vFechaHora();
	fprintf(stderr, "Programa [%s] finalizado ok.\n", basename(argv[0]));
	fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
	fprintf(pfLog, "Proceso [%s] finalizado ok.\n", basename(argv[0]));
	fclose(pfLog);
	return(EXIT_0);        
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

