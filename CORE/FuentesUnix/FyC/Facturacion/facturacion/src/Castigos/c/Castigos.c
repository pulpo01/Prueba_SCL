
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
    "./pc/Castigos.pc"
};


static unsigned int sqlctx = 3446595;


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
"select COD_CUENTA ,COD_CLIENTE ,TIP_DOC ,FOLIO ,TO_NUMBER(TO_CHAR(FEC_EMI,'Y\
YYYMMDD')) ,DEBE ,HABER ,SALDO ,MONTO  from FA_CASTIGO where IND_CASTIGO is nu\
ll  order by COD_CUENTA            ";

 static char *sq0002 = 
"select COD_VENDEDOR_AGENTE ,LETRA ,COD_CENTREMI ,COLUMNA ,COD_PRODUCTO ,IMPO\
RTE_DEBE ,IMPORTE_HABER ,IND_CONTADO ,IND_FACTURADO ,TO_CHAR(FEC_VENCIMIE,'YYY\
YMMDDHH24MISS') ,TO_CHAR(FEC_CADUCIDA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_ANTIGUE\
DAD,'YYYYMMDDHH24MISS') ,NUM_ABONADO ,NUM_FOLIO ,NVL(TO_CHAR(FEC_PAGO,'YYYYMMD\
DHH24MISS'),' ') ,NVL(NUM_CUOTA,0) ,NVL(SEC_CUOTA,0) ,NVL(NUM_TRANSACCION,0) ,\
NVL(NUM_VENTA,0) ,NVL(NUM_FOLIOCTC,0)  from CO_CARTERA where (((COD_CLIENTE=:b\
0 and COD_TIPDOCUM=:b1) and NUM_FOLIO=:b2) and TO_NUMBER(TO_CHAR(FEC_EFECTIVID\
AD,'YYYYMMDD'))=:b3)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,189,0,9,249,0,0,0,0,0,1,0,
20,0,0,1,0,0,13,269,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,
71,0,0,2,575,0,9,490,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
102,0,0,2,0,0,13,496,0,0,20,0,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
197,0,0,3,164,0,5,564,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
232,0,0,4,56,0,4,603,0,0,1,0,0,1,0,2,3,0,0,
251,0,0,5,59,0,3,615,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
286,0,0,6,541,0,3,630,0,0,20,20,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
381,0,0,7,48,0,4,699,0,0,1,0,0,1,0,2,3,0,0,
400,0,0,8,325,0,3,720,0,0,13,13,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
467,0,0,9,311,0,3,767,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
97,0,0,
506,0,0,10,59,0,5,823,0,0,1,1,0,1,0,1,3,0,0,
525,0,0,11,59,0,5,893,0,0,1,1,0,1,0,1,3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : Castigo.pc                                               * */
/* *  Castigo a cliente                                                  * */
/* *  Autor : Nelson Contreras Helena                                    * */
/* *********************************************************************** */
/* Modificado 14-07-2003 : A peticion de Solange Quintanilla               */
/* En registro CO_PAGOS :                                                  */
/*  COD_ORIPAGO=  39       -- CASTIGO CONTABLE                             */
/*  COD_CAUPAGO=  39       -- CASTIGO CONTABLE                             */
/***************************************************************************/


#include <deftypes.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "Castigos.h"

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


long    lContDoc		= 0;
long    lContDocCastigados	= 0;
long    lContDocRechazados	= 0;
long    lContDocumentos;
int	iContInsert;

/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
	char modulo[]="main";

    extern  char *optarg             ;
    char    opt[]=":u:l" ;
    int     iOpt =0                  ;
    char    szaux     [10]           ;
    char    *szDirLogs               ;
    char    *szDirDats               ;
    char    *szNomArchivo            ;
    char    *szLogName;
    char    szComando[1024] = ""     ;
    BOOL    bRetorno = FALSE         ;
    int      sts;
 
    
    memset(&stLineaComando,0    ,sizeof(CASTIGOSLINEACOMANDO));
    
    
    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                    if (strlen (optarg))
                    {
                        strcpy(stLineaComando.szUsuario, optarg);
                        fprintf (stdout," -u %s ", stLineaComando.szUsuario);
                    }
                    break;
            case 'l':
                    if (strlen (optarg))
                    {
                        stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                        fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                    }
                    break;
            
        }/*End Switch */
        
    } /* End While */
    fprintf (stdout,"\n");

    if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF     ;

    stLineaComando.iNivLog = stStatus.LogNivel;

    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "Usuario  <%s> Password <XXXX> \n",stLineaComando.szUser);
        return (2);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------\n",
                stLineaComando.szUser);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))
        return FALSE;

    
    
    /**************************************************************************************/
    /* Crear archivos y directorios de log y errores */
     
    sts = ifnAbreArchivosLog();
    if ( sts != 0 ) return sts;

    
    
    /*********************************************************************************************/
    
    vDTrazasLog  ( modulo ,"\n\n\t*************************************"
                           "\n\n\t****        Log   Castigos        **"
                           "\n\n\t*************************************"
                           ,LOG03);

    vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada Castigos  ***"
                           "\n\t\t=> Usuario               [%s]"
                           "\n\t\t=> Niv.Log               [%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.iNivLog);
    
    /************************************************************************************/
    /*			Proceso Principal						*/
    /************************************************************************************/
    
    strcpy(modulo,"bProcesaCastigos");
    
    vDTrazasLog  ( modulo ,"\n\t\t***  Inicio Proceso principal  ***"
                           ,LOG03);
                           
    bRetorno = bProcesaCastigos();	                         

    
    if(!bRetorno)
    {
        fnOraRollBack();
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado de Forma Irregular"
                               " \n\t------------------------------------\n"
                                    ,LOG03);
        vDTrazasLog  ( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado de Forma Irregular"
                               " \n\t------------------------------------\n"
                               ,LOG03);
        return 3;
    }
    else
    {
    	vDTrazasLog  ( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado Correctamente"
                               " \n\t------------------------------------\n"
                               ,LOG03);
    	
    	
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado Correctamente"
                               " \n\t------------------------------------\n"
                               ,LOG03);
        if ( !fnOraCommit())
        {

            vDTrazasLog ( modulo , " \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            vDTrazasError( modulo ," \n\t------------------------------------"
                                   " \n\tFallo en el Commit"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            return 4;
        }

    }

    if(!bfnDisconnectORA(0))
    {
    }
    else
    {
      vDTrazasLog  ( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
      vDTrazasError( modulo ,"\n\t--------------------------------------------"
                             "\n\tDesconectado de  ORACLE"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);

}

	
	vDTrazasLog  ( modulo ,"\n\t\t%s***  Estadisticas Finales  ***"
                           "\n\t\t=> Documentos Procesados    [%d]"
                           "\n\t\t=> Documentos Castigados    [%d]"
                           "\n\t\t=> Documentos Rechazados    [%d]"
                           ,LOG03
                           ,cfnGetTime(3)
                           ,lContDoc
                           ,lContDocCastigados++
                           ,lContDocRechazados);


    return (0);
}/* ********************* Fin Main * *************************************** */

/********* Proceso de Castigos                         ****/


int bProcesaCastigos()
{
int iRetorno;
char modulo[]="bProcesaCastigos";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lCuentaCastigo;
	/* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL DECLARE Cursor_Cuentas CURSOR FOR
	
        SELECT
        	COD_CUENTA,
		COD_CLIENTE,
		TIP_DOC,
		FOLIO,
		TO_NUMBER(TO_CHAR(FEC_EMI,'YYYYMMDD')),
		DEBE,
		HABER,
		SALDO,
		MONTO
	FROM FA_CASTIGO
	WHERE IND_CASTIGO IS NULL
	ORDER BY COD_CUENTA; */ 

	
	if (sqlca.sqlcode)
	{
		vDTrazasLog  ( modulo ,"\n\t\t** Error DECLARE cursor_Cuentas  ***"
                           ,LOG03);
		
		vDTrazasError(modulo,"%s Error DECLARE cursor_Cuentasn%s\n",
						LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                
                fnOraRollBack();
		
		return -1;
	}
	
	
	/* EXEC SQL OPEN Cursor_Cuentas; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 0;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	
	if (sqlca.sqlcode)
	{
		vDTrazasLog  ( modulo ,"\n\t\t** Error OPEN cursor_Cuentas  ***"
                           ,LOG03);
		
		vDTrazasError(modulo,"%s Error OPEN cursor_Cuentasn%s\n",
						LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                
                fnOraRollBack();
		
		return -1;
	}
	
	
	while(1)
	{
		iContInsert = 0 ;
		
		/* EXEC SQL FETCH Cursor_Cuentas
		INTO :sthFaCastigo; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )20;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&sthFaCastigo.lCodCuenta;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&sthFaCastigo.lCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&sthFaCastigo.lTipoDoc;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&sthFaCastigo.lFolioDoc;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&sthFaCastigo.iFecEmi;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&sthFaCastigo.lDebe;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&sthFaCastigo.lHaber;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&sthFaCastigo.lSaldo;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&sthFaCastigo.lMonto;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
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


		
		if(sqlca.sqlcode == SQLNOTFOUND)
		{
			break;
		}
		else
		{
		      lContDoc ++;
		 
		      if(sqlca.sqlcode)
		      {	
		      	vDTrazasLog  ( modulo ,"\n\t\t** Error FETCH cursor_Cuentas  ***"
                           ,LOG03);
		
			vDTrazasError(modulo,"%s Error FETCH cursor_Cuentasn%s\n",
						LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                
                	fnOraRollBack();
			
			 return -3;
		      }
		      else
		         {
				iRetorno = bProcesaCuenta();
				
				if ( iRetorno > 0 )
				{
				   vDTrazasLog( modulo ," \n\tCuenta a Castigar : [%d]\n"
                               		,LOG05,sthFaCastigo.lCodCuenta );
					
					
					iRetorno = bCastigaCuenta(sthFaCastigo.lCodCuenta);	
					if ( iRetorno < 0 )
					{
						
					vDTrazasLog( modulo ," \n\t Error-> [%d] en castigar cuenta : [%d]\n"
                               		,LOG05,iRetorno,sthFaCastigo.lCodCuenta );
                               		
                               		fnOraRollBack();
                               		
					}
				}	
				else
				{	
					bRechazaCuenta(sthFaCastigo.lCodCuenta,iRetorno);	
				}			         	
		         }
		}
		
		
	if ( !fnOraCommit())
        {

            vDTrazasLog ( modulo , " \n\t------------------------------------"
                                   " \n\tFallo en el Commit por cuenta"
                                   " \n\t------------------------------------"
                                   ,LOG03);
            vDTrazasError( modulo ," \n\t------------------------------------"
                                   " \n\tFallo en el Commit por cuenta"
                                   " \n\t------------------------------------"
                                   ,LOG03);
                                   
            return -1;
        }	
	

	}/* end while Cuentas  */
	
	
}


int bProcesaCuenta()
{
int     iRetorno;

	char modulo[]="bProcesaCuenta";	
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long            lbdCuentaCastigo;
		long		lSaldo;
	/* EXEC SQL END DECLARE SECTION; */ 


	lbdCuentaCastigo = sthFaCastigo.lCodCuenta;

	
	/*******************************************************************************
	No Valida Cuadratura de la Cuenta 
	********************************************************************************
	EXEC SQL 
	SELECT SUM(importe_debe - importe_haber) 
	INTO :lSaldo
	FROM   co_cartera 
	WHERE  cod_cliente in 
		(select cod_cliente from ge_clientes  
		 where cod_cuenta = :sthFaCastigo.lCodCuenta )
	AND    cod_tipdocum in 
		(select unique cod_tipdocummov 
         from fa_tipdocumen
         union 
         select 5 from dual);
	
		
	if ( SQLCODE == SQLOK )
	{
		if ( lSaldo != 	sthFaCastigo.lMonto )
		{
		
							
				return -30;
		}
	
	}
	else
	{
		vDTrazasLog  ( modulo ,"\n\t\t** Error SELECT CO_CARTERA  ***"
                           ,LOG03);
		
		vDTrazasError(modulo,"%s Error SELECT CO_CARTERAn%s\n",
						LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                
                fnOraRollBack();	
		
		
	}
	*******************************************************************************/
    lSaldo = 	sthFaCastigo.lMonto;	
	iRetorno = VerificaCtaCte(sthFaCastigo);

    if (iRetorno < 0 )
    {
		vDTrazasLog  ( modulo ,"\n\t\t** Error en VerificaCtaCte ***"
                           ,LOG03);
		
		vDTrazasError(modulo,"%s Error en VerificaCtaCte [%s]\n",
						LOG03, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
                
        fnOraRollBack();	
	}

	
	return 1;
	
} /* Fin ProcesaCuenta */


int VerificaCtaCte(sthFaCastigo)
reg_fa_castigo  sthFaCastigo;
{
int 	iContador = 0 ;
long	lSuma	  = 0 ;

	char modulo[]="VerificaCtaCte";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		reg_fa_castigo  stbdFaCastigo;
		long	lbdCodCliente;
		long    lbdTipoDoc;
		long	lbdFolioDoc;
		int	ibdFecEmi;   
		
		int	lCodVendedor;
		char	szLetra	[2];
		int     iCodCentremi;
		int     iColumna;
		int 	iCodProducto;
		long	lDebe;
		long    lHaber;
		int	iIndContado;
		int	iIndFacturado;
		char    szFecVencimiento[15];
		char    szFecCaducida	[15];
		char    szFecAntiguedad	[15];
		long	lNumAbonado;
		long	lNumFolio;
		char    szFecPago	[15];
		long	lNumCuota;
		long	lSecCuota;
		long	lNumTrx;
		long	lNumVenta;
		char 	szNumFolioCtc	[12];
 
	/* EXEC SQL END DECLARE SECTION; */ 

	
	
	lbdCodCliente =  sthFaCastigo.lCodCliente;
	lbdTipoDoc    =  sthFaCastigo.lTipoDoc;
	lbdFolioDoc   =  sthFaCastigo.lFolioDoc;
	ibdFecEmi     =  sthFaCastigo.iFecEmi;
	
	
	/* EXEC SQL DECLARE CursorCoCartera CURSOR FOR
	SELECT COD_VENDEDOR_AGENTE,
	       LETRA,
	       COD_CENTREMI,
	       COLUMNA,
	       COD_PRODUCTO,
	       IMPORTE_DEBE,
	       IMPORTE_HABER,
	       IND_CONTADO,
	       IND_FACTURADO,
	       TO_CHAR(FEC_VENCIMIE,'YYYYMMDDHH24MISS'),
	       TO_CHAR(FEC_CADUCIDA,'YYYYMMDDHH24MISS'),
	       TO_CHAR(FEC_ANTIGUEDAD,'YYYYMMDDHH24MISS'),
	       NUM_ABONADO,
	       NUM_FOLIO,
	       NVL(TO_CHAR(FEC_PAGO,'YYYYMMDDHH24MISS'),' '),
	       NVL(NUM_CUOTA,0),
	       NVL(SEC_CUOTA,0),
	       NVL(NUM_TRANSACCION,0),
	       NVL(NUM_VENTA,0),
	       NVL(NUM_FOLIOCTC,0)
	FROM CO_CARTERA
	WHERE COD_CLIENTE   = :lbdCodCliente AND
	      COD_TIPDOCUM  = :lbdTipoDoc    AND
	      NUM_FOLIO     = :lbdFolioDoc   AND
	      TO_NUMBER(TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDD')) =
	         :ibdFecEmi ; */ 

	         
	/* EXEC SQL OPEN CursorCoCartera ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 9;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0002;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )71;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lbdCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lbdTipoDoc;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lbdFolioDoc;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ibdFecEmi;
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


	
	     	 		
	while ( SQLCODE == SQLOK )
	{
		
	/* EXEC SQL FETCH CursorCoCartera INTO 
		:lCodVendedor,   
	       	:szLetra,    
		:iCodCentremi,   
		:iColumna,       
		:iCodProducto,   
		:lDebe,         
		:lHaber, 
		:iIndContado,    
		:iIndFacturado,  
		:szFecVencimiento,
		:szFecCaducida,	
		:szFecAntiguedad,	
		:lNumAbonado,    
		:lNumFolio,      
		:szFecPago,	
	 	:lNumCuota,      
		:lSecCuota,      
		:lNumTrx,
		:lNumVenta,      
		:szNumFolioCtc; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )102;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCodVendedor;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szLetra;
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&iCodCentremi;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&iColumna;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&iCodProducto;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lDebe;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&lHaber;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&iIndContado;
 sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&iIndFacturado;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)szFecVencimiento;
 sqlstm.sqhstl[9] = (unsigned long )15;
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szFecCaducida;
 sqlstm.sqhstl[10] = (unsigned long )15;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szFecAntiguedad;
 sqlstm.sqhstl[11] = (unsigned long )15;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&lNumAbonado;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&lNumFolio;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szFecPago;
 sqlstm.sqhstl[14] = (unsigned long )15;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&lNumCuota;
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&lSecCuota;
 sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&lNumTrx;
 sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&lNumVenta;
 sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)szNumFolioCtc;
 sqlstm.sqhstl[19] = (unsigned long )12;
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


		
		
	if ( SQLCODE == SQLOK )
	{
		
		iContador ++;
		lSuma  = lSuma + (lDebe - lHaber) ;
		
		
		sthCoCartera.lCodCliente[iContInsert]	= lbdCodCliente;
		sthCoCartera.iTipDoc[iContInsert]	= lbdTipoDoc;
		sthCoCartera.lCodVendedor[iContInsert]	= lCodVendedor;
		strcpy(sthCoCartera.szLetra[iContInsert],szLetra);		
		sthCoCartera.lCodCentremi[iContInsert]	= iCodCentremi;
		sthCoCartera.iColumna[iContInsert]	= iColumna;
		sthCoCartera.lCodProducto[iContInsert]	= iCodProducto;
		sthCoCartera.lHaber[iContInsert]	= lDebe - lHaber;
		sthCoCartera.iIndContado[iContInsert]	= iIndContado;
		sthCoCartera.iIndFacturado[iContInsert]	= iIndFacturado;
		strcpy(sthCoCartera.szFecVencimiento[iContInsert],szFecVencimiento);
		strcpy(sthCoCartera.szFecCaducida[iContInsert],szFecCaducida);	
		strcpy(sthCoCartera.szFecAntiguedad[iContInsert],szFecAntiguedad);	
		sthCoCartera.lNumAbonado[iContInsert]	= lNumAbonado;
		sthCoCartera.lNumFolio[iContInsert]	= lNumFolio;
		strcpy(sthCoCartera.szFecPago[iContInsert],szFecPago);	
		sthCoCartera.lNumCuota[iContInsert]	= lNumCuota;
		sthCoCartera.lSecCuota[iContInsert]	= lSecCuota;
		sthCoCartera.lNumTrx	[iContInsert]	= lNumTrx;
		sthCoCartera.lNumVenta[iContInsert]	= lNumVenta;
		strcpy(sthCoCartera.szFolioCtc[iContInsert],szNumFolioCtc);

		iContInsert ++ ;
	}
		 
	}/* END WHILE */
	       
	if ( lSuma == sthFaCastigo.lSaldo )
	{	
		lContDocCastigados ++;	
		return 1;
	}
	else
	{
				
		lContDocRechazados ++;
		iContInsert = iContInsert - iContador;
			
		/* EXEC SQL
		UPDATE FA_CASTIGO
		SET IND_CUADRA2 = 'S'
		WHERE  
			COD_CUENTA    = :sthFaCastigo.lCodCuenta  AND
			COD_CLIENTE   = :lbdCodCliente AND
	      		TIP_DOC       = :lbdTipoDoc    AND
	      		FOLIO         = :lbdFolioDoc   AND
	      		TO_NUMBER(TO_CHAR(FEC_EMI,'YYYYMMDD')) =
	         			:ibdFecEmi ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 20;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update FA_CASTIGO  set IND_CUADRA2='S' where ((((COD_CUENTA\
=:b0 and COD_CLIENTE=:b1) and TIP_DOC=:b2) and FOLIO=:b3) and TO_NUMBER(TO_CHA\
R(FEC_EMI,'YYYYMMDD'))=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )197;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&(sthFaCastigo.lCodCuenta);
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lbdCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lbdTipoDoc;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lbdFolioDoc;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&ibdFecEmi;
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


			
			if ( SQLCODE != SQLOK )
			{
			vDTrazasLog(modulo, "%s << Error update FA_CASTIGO.IND_CUADRA2 >>", 
			LOG05, cfnGetTime(1));
			fnOraRollBack();
				return -1;	
			}
			
		
	}
}              

               
int bCastigaCuenta(lCuentaCastigo)
long lCuentaCastigo;
{              
int i ;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lSecuenciaCastigo;
		long lSecuenciaPago;
	/* EXEC SQL END DECLARE SECTION; */ 

	

	
	for (i = 0 ; i< iContInsert ; i++)
	{
	
	/* EXEC SQL
	SELECT CO_SEQ_CASTCONTABLE.NEXTVAL
	INTO :lSecuenciaCastigo 
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CO_SEQ_CASTCONTABLE.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )232;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lSecuenciaCastigo;
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


	
	if ( SQLCODE != SQLOK )
	{
		printf("Error en obtener secuencia castigo : %s\n",
			sqlca.sqlerrm.sqlerrmc);
		return ( -10);
	}
		
	/* EXEC SQL
	INSERT INTO CO_SECARTERA
	VALUES
	(
	39,
	:sthCoCartera.lCodVendedor[i],
	:sthCoCartera.szLetra[i],
	:sthCoCartera.lCodCentremi[i],
	:lSecuenciaCastigo,
	6,
	:sthCoCartera.iColumna[i]
	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_SECARTERA  values (39,:b0,:b1,:b2,:b3,6,:b4)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )251;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&(sthCoCartera.lCodVendedor)[i];
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)(sthCoCartera.szLetra)[i];
 sqlstm.sqhstl[1] = (unsigned long )2;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(sthCoCartera.lCodCentremi)[i];
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&lSecuenciaCastigo;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&(sthCoCartera.iColumna)[i];
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


		
	if ( SQLCODE == SQLOK)
	{
	/* EXEC SQL
	INSERT INTO CO_CARTERA
	(
	COD_CLIENTE, 
	NUM_SECUENCI, 
	COD_TIPDOCUM, 
	COD_VENDEDOR_AGENTE, 
	LETRA, 
	COD_CENTREMI, 
	COD_CONCEPTO, 
	COLUMNA, 
	COD_PRODUCTO, 
	IMPORTE_DEBE, 
	IMPORTE_HABER, 
	IND_CONTADO, 
	IND_FACTURADO, 
	FEC_EFECTIVIDAD, 
	FEC_VENCIMIE, 
	FEC_CADUCIDA, 
	FEC_ANTIGUEDAD, 
	NUM_ABONADO, 
	NUM_FOLIO, 
	FEC_PAGO, 
	NUM_CUOTA, 
	SEC_CUOTA, 
	NUM_TRANSACCION, 
	NUM_VENTA, 
	NUM_FOLIOCTC
	)
	VALUES
	(
	:sthCoCartera.lCodCliente[i],
	:lSecuenciaCastigo,
	39,
	:sthCoCartera.lCodVendedor[i],
	:sthCoCartera.szLetra[i],
	:sthCoCartera.lCodCentremi[i],
	6,
	:sthCoCartera.iColumna[i],
	:sthCoCartera.lCodProducto[i],
	0,
	:sthCoCartera.lHaber[i],
	:sthCoCartera.iIndContado[i],
	:sthCoCartera.iIndFacturado[i],
	SYSDATE,
	TO_DATE(:sthCoCartera.szFecVencimiento[i],'YYYYMMDDHH24MISS'),
	TO_DATE(:sthCoCartera.szFecCaducida[i],'YYYYMMDDHH24MISS'),
	TO_DATE(:sthCoCartera.szFecAntiguedad[i],'YYYYMMDDHH24MISS'),
	:sthCoCartera.lNumAbonado[i],
	:sthCoCartera.lNumFolio[i],
	SYSDATE,
	:sthCoCartera.lNumCuota[i],
	:sthCoCartera.lSecCuota[i],
	:sthCoCartera.lNumTrx[i],
	:sthCoCartera.lNumVenta[i],
	:sthCoCartera.szFolioCtc[i]
	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_CARTERA (COD_CLIENTE,NUM_SECUENCI,COD_TIPDOCU\
M,COD_VENDEDOR_AGENTE,LETRA,COD_CENTREMI,COD_CONCEPTO,COLUMNA,COD_PRODUCTO,IMP\
ORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_VENCIMIE\
,FEC_CADUCIDA,FEC_ANTIGUEDAD,NUM_ABONADO,NUM_FOLIO,FEC_PAGO,NUM_CUOTA,SEC_CUOT\
A,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC) values (:b0,:b1,39,:b2,:b3,:b4,6,:b5\
,:b6,0,:b7,:b8,:b9,SYSDATE,TO_DATE(:b10,'YYYYMMDDHH24MISS'),TO_DATE(:b11,'YYYY\
MMDDHH24MISS'),TO_DATE(:b12,'YYYYMMDDHH24MISS'),:b13,:b14,SYSDATE,:b15,:b16,:b\
17,:b18,:b19)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )286;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&(sthCoCartera.lCodCliente)[i];
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lSecuenciaCastigo;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(sthCoCartera.lCodVendedor)[i];
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)(sthCoCartera.szLetra)[i];
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&(sthCoCartera.lCodCentremi)[i];
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&(sthCoCartera.iColumna)[i];
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&(sthCoCartera.lCodProducto)[i];
 sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&(sthCoCartera.lHaber)[i];
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&(sthCoCartera.iIndContado)[i];
 sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&(sthCoCartera.iIndFacturado)[i];
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)(sthCoCartera.szFecVencimiento)[i];
 sqlstm.sqhstl[10] = (unsigned long )15;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)(sthCoCartera.szFecCaducida)[i];
 sqlstm.sqhstl[11] = (unsigned long )15;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)(sthCoCartera.szFecAntiguedad)[i];
 sqlstm.sqhstl[12] = (unsigned long )15;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&(sthCoCartera.lNumAbonado)[i];
 sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)&(sthCoCartera.lNumFolio)[i];
 sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&(sthCoCartera.lNumCuota)[i];
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)&(sthCoCartera.lSecCuota)[i];
 sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)&(sthCoCartera.lNumTrx)[i];
 sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)0;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
 sqlstm.sqhstv[18] = (unsigned char  *)&(sthCoCartera.lNumVenta)[i];
 sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[18] = (         int  )0;
 sqlstm.sqindv[18] = (         short *)0;
 sqlstm.sqinds[18] = (         int  )0;
 sqlstm.sqharm[18] = (unsigned long )0;
 sqlstm.sqadto[18] = (unsigned short )0;
 sqlstm.sqtdso[18] = (unsigned short )0;
 sqlstm.sqhstv[19] = (unsigned char  *)(sthCoCartera.szFolioCtc)[i];
 sqlstm.sqhstl[19] = (unsigned long )12;
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


	}
	else
	{
		printf("Error en Insert en CO_SECARTERA : %s\n",
				sqlca.sqlerrm.sqlerrmc);
		return ( -11);
	}
	
	/* Insert en CO_PAGOS  */
	
	if ( SQLCODE == SQLOK )
	{
	/* EXEC SQL
	SELECT CO_SEQ_PAGO.NEXTVAL
	INTO 
	:lSecuenciaPago 	
	FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CO_SEQ_PAGO.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )381;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lSecuenciaPago;
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


	}
	else
	{
		printf("Error al Insertar en CO_CARTERA : %s\n",
			sqlca.sqlerrm.sqlerrmc);
		return(-12);	
	}
	

	if ( SQLCODE != SQLOK )
	{
		printf("Error en obtener secuencia de pago : %s\n",
		sqlca.sqlerrm.sqlerrmc);
		return(-13);
	}

	/* EXEC SQL
	INSERT INTO CO_PAGOSCONC
	(
	COD_TIPDOCUM,
	COD_CENTREMI,
	NUM_SECUENCI,
	COD_VENDEDOR_AGENTE,
	NUM_SECUREL,
	LETRA,
	IMP_CONCEPTO,
	COD_PRODUCTO,
	COD_TIPDOCREL,
	COD_AGENTEREL,
	LETRA_REL,
	COD_CENTRREL,	
	COD_CONCEPTO,
	NUM_ABONADO,
	NUM_FOLIO,
	NUM_CUOTA,
	SEC_CUOTA,
	NUM_FOLIOCTC
	)
	VALUES
	(
	39,
	1,
	:lSecuenciaPago,
	:sthCoCartera.lCodVendedor[i],
	:sthCoCartera.lNumSec[i],
	'X',
	:sthCoCartera.lHaber[i],
	1,
	:sthCoCartera.iTipDoc[i],
	:sthCoCartera.lCodVendedor[i],
	:sthCoCartera.szLetra[i],
	:sthCoCartera.lCodCentremi[i],
	6,
	:sthCoCartera.lNumAbonado[i],
	:sthCoCartera.lNumFolio[i],
	:sthCoCartera.lNumCuota[i],
	:sthCoCartera.lSecCuota[i],
	:sthCoCartera.szFolioCtc[i]
	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SECU\
ENCI,COD_VENDEDOR_AGENTE,NUM_SECUREL,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDO\
CREL,COD_AGENTEREL,LETRA_REL,COD_CENTRREL,COD_CONCEPTO,NUM_ABONADO,NUM_FOLIO,N\
UM_CUOTA,SEC_CUOTA,NUM_FOLIOCTC) values (39,1,:b0,:b1,:b2,'X',:b3,1,:b4,:b1,:b\
6,:b7,6,:b8,:b9,:b10,:b11,:b12)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )400;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lSecuenciaPago;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&(sthCoCartera.lCodVendedor)[i];
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(sthCoCartera.lNumSec)[i];
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&(sthCoCartera.lHaber)[i];
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&(sthCoCartera.iTipDoc)[i];
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&(sthCoCartera.lCodVendedor)[i];
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)(sthCoCartera.szLetra)[i];
 sqlstm.sqhstl[6] = (unsigned long )2;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)&(sthCoCartera.lCodCentremi)[i];
 sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&(sthCoCartera.lNumAbonado)[i];
 sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&(sthCoCartera.lNumFolio)[i];
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&(sthCoCartera.lNumCuota)[i];
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&(sthCoCartera.lSecCuota)[i];
 sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)(sthCoCartera.szFolioCtc)[i];
 sqlstm.sqhstl[12] = (unsigned long )12;
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


	
	if ( SQLCODE == SQLOK )
	{
	
	/* EXEC SQL
	INSERT INTO CO_PAGOS
	(COD_TIPDOCUM,
	 COD_CENTREMI,
	 NUM_SECUENCI,
	 COD_VENDEDOR_AGENTE,
	 LETRA,
	 COD_CLIENTE,
	 IMP_PAGO,
	 FEC_EFECTIVIDAD,
	 FEC_VALOR,
	 NOM_USUARORA,
	 COD_FORPAGO,
	 COD_SISPAGO,
	 COD_ORIPAGO,
	 COD_CAUPAGO,
	 DES_PAGO
	)
	VALUES
	(39,
	 1,
	 :lSecuenciaPago,
	 :sthCoCartera.lCodVendedor[i],
	 'X',
	 :sthCoCartera.lCodCliente[i],
	 :sthCoCartera.lHaber[i],
	 SYSDATE,
	 TO_DATE(:sthCoCartera.szFecVencimiento[i],'YYYYMMDDHH24MISS'),
	 :stLineaComando.szUser,
	 0,
	 1,
	 39,
	 39,
	 'Castigo Contable' 
	); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_PAGOS (COD_TIPDOCUM,COD_CENTREMI,NUM_SECUENCI\
,COD_VENDEDOR_AGENTE,LETRA,COD_CLIENTE,IMP_PAGO,FEC_EFECTIVIDAD,FEC_VALOR,NOM_\
USUARORA,COD_FORPAGO,COD_SISPAGO,COD_ORIPAGO,COD_CAUPAGO,DES_PAGO) values (39,\
1,:b0,:b1,'X',:b2,:b3,SYSDATE,TO_DATE(:b4,'YYYYMMDDHH24MISS'),:b5,0,1,39,39,'C\
astigo Contable')";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )467;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lSecuenciaPago;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&(sthCoCartera.lCodVendedor)[i];
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&(sthCoCartera.lCodCliente)[i];
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&(sthCoCartera.lHaber)[i];
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)(sthCoCartera.szFecVencimiento)[i];
 sqlstm.sqhstl[4] = (unsigned long )15;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)(stLineaComando.szUser);
 sqlstm.sqhstl[5] = (unsigned long )50;
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


	
	
	}
	else
	{
		printf("Error al insertar en CO_PAGOSCONC : %s\n",
			sqlca.sqlerrm.sqlerrmc);
		return(-15);	
	}
	
	
	       	
	if ( SQLCODE != SQLOK )
	{
		printf("Error al insertar en CO_PAGOS : %s\n",
			sqlca.sqlerrm.sqlerrmc);
		return(-15);	
	}
	       	
	}	    /* End For */	
	
	/* EXEC SQL
	UPDATE FA_CASTIGO
	SET    IND_CASTIGO = 'S'
	WHERE  COD_CUENTA  = :lCuentaCastigo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_CASTIGO  set IND_CASTIGO='S' where COD_CUENTA=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )506;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCuentaCastigo;
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


	
	if ( SQLCODE != SQLOK )
	{
		printf("Error Update FA_CASTIGO : %s\n",
			sqlca.sqlerrm.sqlerrmc);
		return(-16);
	}
	else
		return(1);
	
}


/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog()
{
	char modulo[]="ifnAbreArchivosLog";

	char *pathDir;
	char szArchivo[32]="";
	char szPath[128]="";
	char szComando[128]="";

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"Castigos"); /* 'FaSched' */

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/Castigos/%s",pathDir,cfnGetTime(2)); /* '....log/FaSched/YYYYMMDD/' */
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	sprintf(stStatus.ErrName,"%s/%s.err",szPath,szArchivo);
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"a")) == (FILE*)NULL )/* "wb+" */
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;    }

	vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

	sprintf(stStatus.LogName,"%s/%s.log",szPath,szArchivo);
	if((stStatus.LogFile = fopen(stStatus.LogName,"a")) == (FILE*)NULL ) /* "wb+" */
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;    }

	vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));
	vDTrazasLog(modulo, "%s << Inicio de Castigo >>" , LOG03, cfnGetTime(1));


}

int bRechazaCuenta(lCuentaCastigo,iRetorno)
long lCuentaCastigo;
int  iRetorno;
{

char modulo[]="bRechazaCuenta";


	/* EXEC SQL 
	UPDATE	FA_CASTIGO	 
	SET IND_CUADRA1 = 'S'
	WHERE COD_CUENTA = :lCuentaCastigo; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 20;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_CASTIGO  set IND_CUADRA1='S' where COD_CUENTA=:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )525;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lCuentaCastigo;
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


	
	if ( SQLCODE != SQLOK )
	{
		
	vDTrazasLog(modulo, "%s << Error update FA_CASTIGO.IND_CUADRA1 en Cuenta %d>>", 
			LOG05, cfnGetTime(1),lCuentaCastigo);
		return -1;
	}
	else
		return 1;
	

} /* Fin bRechazaCuenta */


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

