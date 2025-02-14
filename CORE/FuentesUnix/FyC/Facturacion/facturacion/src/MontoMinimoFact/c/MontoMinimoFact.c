
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
           char  filnam[24];
};
static const struct sqlcxp sqlfpn =
{
    23,
    "./pc/MontoMinimoFact.pc"
};


static unsigned int sqlctx = 443308171;


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
   unsigned char  *sqhstv[14];
   unsigned long  sqhstl[14];
            int   sqhsts[14];
            short *sqindv[14];
            int   sqinds[14];
   unsigned long  sqharm[14];
   unsigned long  *sqharc[14];
   unsigned short  sqadto[14];
   unsigned short  sqtdso[14];
} sqlstm = {12,14};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,17,444,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,477,0,0,0,0,0,1,0,
39,0,0,1,0,0,13,497,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,4,0,0,
66,0,0,1,0,0,15,576,0,0,0,0,0,1,0,
81,0,0,2,0,0,17,630,0,0,1,1,0,1,0,1,97,0,0,
100,0,0,2,0,0,21,641,0,0,0,0,0,1,0,
115,0,0,3,294,0,4,676,0,0,4,2,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,1,3,0,0,
146,0,0,4,624,0,3,921,0,0,14,14,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,4,0,0,
1,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/*****************************************************************************/
/*  Fichero    : MontoMinimoFact.pc                                          */
/*  Descripcion: Proceso Validación Monto Minimo Facturable                  */
/*****************************************************************************/
#define _MONTOMINIMOFACT_PC_

#include <deftypes.h>
#include <string.h>
#include "MontoMinimoFact.h"

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
int main( int  argc, char *argv[])
{
    char        modulo       []="main";
    char        szFecha       [20]= "";
    long        lCiclFact             ;
    char        szNomTabla        [20];
    extern char *optarg               ;
    int         iOpt                  ;
    char        opt []  = "u:l:c:i:f:";
    char        szUsuario    [102]= "";
    char        szFormato     [10]= "";
    char        szaux             [10];    
    char        *psztmp           = "";
    char        *szDirLogs            ;
    char        *szDirDats            ;
    char        szComando   [1024]= "";
    BOOL        bOptUsuario    = FALSE;
    BOOL        bClieIniFlag   = FALSE;   
    BOOL        bClieFinFlag   = FALSE;    
    char        szValParametro [512+1];
    long        lhMontoMinimo         ;

    puts("\n MontoMinimoFact version " __DATE__ " " __TIME__ " TMG\n");

    memset(&stLineaComando,0,sizeof(stLineaComando));
    memset(&stStatus    ,'\0'   ,sizeof(STATUS)); 
    
    stLineaComando.bOptUsuario  = FALSE;
    stLineaComando.bOptCiclo    = FALSE;


    if(argc == 1)
    {
       fprintf (stderr,"\n<< Error : Parámetros insuficientes >>\n%s\n",szUsage);
       return FALSE;
    }


    while( (iOpt = getopt(argc, argv, opt) ) != EOF )
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
		    case 'l':
			     if( strlen (optarg) )
			     {
				 stStatus.LogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF;
				 fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
			     }
			     break;
		    case 'c':
			     if( strlen (optarg) )
			     {		 			     
                                 stLineaComando.bOptCiclo = TRUE;
                                 strcpy(szaux,optarg);
                                 stLineaComando.lCodCiclFact = atol(szaux);
                                 fprintf(stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                             }			     			     
			     break;			     
                    case 'i':
                             stLineaComando.lCodClienteIni = atol(optarg);
                             bClieIniFlag = TRUE;
                             break;
                    case 'f':
                             stLineaComando.lCodClienteFin = atol(optarg);
                             bClieFinFlag = TRUE;
                             break; 
                    case '?':
                             fprintf(stdout,"\n\t<< Error: opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
                             return (FALSE);
                    case ':':
                             fprintf(stdout,"\n\t<< Error: falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
                             return (FALSE);                             			     
			     
	    } /* Fin Case */
    }/* Fin While */

    /* Validación de Usuario a conectar */
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

    /* Asignación de Nivel de Log */
    if( stStatus.LogNivel <= 0 )
    {
	stStatus.LogNivel = iLOGNIVEL_DEF     ;
    }

    stLineaComando.iNivLog = stStatus.LogNivel;
    
    /* Rango de Clientes */
    if ((bClieIniFlag==FALSE) && (bClieFinFlag==FALSE))
    {
    	stLineaComando.bRngClientes = FALSE;
    }
    else
    {
        if(((bClieIniFlag==TRUE) && (bClieFinFlag==FALSE)) ||
	   ((bClieIniFlag==FALSE) && (bClieFinFlag==TRUE)))
        {
             fprintf (stderr,"\n\t<< Error : Rango de Clientes no valido, debe indicar Cliente Inicial y Cliente Final >>\n%s\n"
                            , szUsage);
             return (FALSE);
        }
    }

    if((bClieIniFlag==TRUE) && (bClieFinFlag==TRUE))
    {
	 stLineaComando.bRngClientes = TRUE;    
    }        
        
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

    /* Creación de Directorio en LOG */
    sprintf(stLineaComando.szDirLogs,"%s/MontoMinimoFact/Ciclo/%ld/"
	                                 ,szDirLogs,stLineaComando.lCodCiclFact);
    free(szDirLogs);
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );
    fprintf( stdout, "\n\tCrea Directorio Log  : %s\n", stLineaComando.szDirLogs);
    if( system (szComando) )
    {
	printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
	return(FALSE);
    }

    /* Creación de Archivo ERR */
    sprintf(stStatus.ErrName, "%sMontoMinimoFact_%s.err",
    stLineaComando.szDirLogs,szSysDate);

    unlink (stStatus.ErrName);

    if( (stStatus.ErrFile = (FILE *)fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
	 fprintf( stderr, "\n ### Error: No puede abrirse el fichero de error %s\n", stStatus.ErrName);
	 return(4);
    }

    sprintf(stStatus.LogName, "%sMontoMinimoFact_%s.log",
    stLineaComando.szDirLogs,szSysDate);

    unlink (stStatus.LogName);

    if( (stStatus.LogFile = (FILE *)fopen(stStatus.LogName,"a")) == (FILE*)NULL )
    {
	 fprintf( stderr, "\n ### Error: No puede abrirse el fichero de log %s\n", stStatus.LogName);
	 return(5);
    }

    vDTrazasLog (modulo, "\n\t\t********************************************************************************************"
	                 "\n\t\t*                 MONTO MINIMO FACTURABLE versión " __DATE__ " " __TIME__ " TMG                 *"
	                 "\n\t\t*               NIVEL DE LOG  %d                                                            *"
	                 "\n\t\t********************************************************************************************"
	               , LOG03,stLineaComando.iNivLog);
    vDTrazasError(modulo,"\n\t\t*******************************************************************************************"
	                 "\n\t\t*                 MONTO MINIMO FACTURABLE versión " __DATE__ " " __TIME__ " TMG                *"
	                 "\n\t\t*               NIVEL DE LOG  %d                                                           *"
	                 "\n\t\t*******************************************************************************************"
	                ,LOG03,stLineaComando.iNivLog);

    lCiclFact = stLineaComando.lCodCiclFact;
    if( !bfnValidaTrazaProc(lCiclFact, iPROC_MONTOMINIMOFACT, iIND_FACT_ENPROCESO) )
    {
        printf("\n\t** Proceso Monto Mínimo Facturable con Error **\n") ;    	
	return(FALSE);
    }
    if( !fnOraCommit() )
    {
        vDTrazasLog  (modulo , "\n\tERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG03, SQLERRM);
	vDTrazasError(modulo , "\n\tERROR AL HACER EL COMMIT EN VALIDA TRAZA",LOG01, SQLERRM);
	return(FALSE);
    }

    if( !bfnSelectSysDate(szFecha) )
    {
	return(FALSE);
    }
	 
    bfnSelectTrazaProc (lCiclFact, iPROC_MONTOMINIMOFACT, &stTrazaProc);
    bPrintTrazaProc(stTrazaProc);
    
    /***********************************/
    /* Proceso Monto Minimo Facturable */
    /***********************************/
    vDTrazasLog  (modulo , "\n\t** INICIO Proceso Monto Mínimo Facturable **",LOG03);      
    
    /* Recupera parámetro Monto Mínimo Facturable */
    if (!bGetParamMontoMinimo(szValParametro))
    {
    	return (FALSE);
    }    
    lhMontoMinimo = atol(szValParametro);    
    vDTrazasLog  (modulo , "\n\tParámetro Monto Mínimo Facturable : [%ld]",LOG03, lhMontoMinimo);    
    
    if( !bfnProcMontoMinimoFact( lCiclFact, lhMontoMinimo ) )
    {
	 stTrazaProc.iCodEstaProc       = iPROC_EST_ERR ;
	 strcpy(stTrazaProc.szGlsProceso,"Proceso Monto Minimo Facturable Finalizado con Error");
	 printf("\n\t** Proceso Monto Minimo Facturable con Error **\n");
    }
    else
    {
	 stTrazaProc.iCodEstaProc       = iPROC_EST_OK  ;
	 strcpy(stTrazaProc.szGlsProceso,"Proceso Monto Minimo Facturable Terminado OK") ;
	 printf("\n\t** Proceso Monto Minimo Facturable Ok **\n");
    }    

    if( !bfnSelectSysDate(szFecha) )
    {
	printf("\n\t<< Error en Funcion bfnSelectSysDate!!!. >> \n");
	printf("\n\t<< No se Actualizo Traza con Ultimo Proceso de Monto Minimo Facturable. >>\n");
    }
    else
    {
	strcpy(stTrazaProc.szFecTermino,szFecha)      ;
	stTrazaProc.lCodCliente        = 0 ;
	stTrazaProc.lNumAbonado        = 0            ;
	stTrazaProc.lNumRegistros      = 0            ;
	bPrintTrazaProc(stTrazaProc)                  ;
	if( !bfnUpdateTrazaProc(stTrazaProc) )
	{
	    return(FALSE);
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

    return(0);
}
/****************************   FIN MAIN    **********************************/

/*****************************************************************************/
/* FUNCION     : bfnProcMontoMinimoFact                                      */
/* DESCRIPCION : Función Principal                                           */
/*****************************************************************************/
BOOL bfnProcMontoMinimoFact (long lCiclFact, long lMontoMinimo)
{
    char szFuncion []= "bfnProcMontoMinimoFact";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCiclFact;
         long lhMontoMinimo; 
    /* EXEC SQL END DECLARE SECTION; */ 
    
    
    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);    
    
    lhMontoMinimo = lMontoMinimo;
    lhCodCiclFact = lCiclFact;    
    
    if(!bfnSelectFactDocu( lhCodCiclFact, lhMontoMinimo ))
    {
       return FALSE;
    }
    
    return TRUE;
}    

/*****************************************************************************/
/* FUNCION     : bfnSelectFactDocu                                           */
/* DESCRIPCION : Recuperar Datos desde Tabla FA_FACTDOCU....                 */
/*****************************************************************************/
BOOL bfnSelectFactDocu ( long lCodCiclFact, long lMontoMinimo)
{
    char  szFuncion   []="bfnSelectFactDocu";
    char  szTabla1                   [50]="";
    char  szCadenaSQL              [2500]="";  
    char  szValParametro             [512+1];
    char  szNextFecEmision         [19+1]="";
    long  lNextCodCiclFact                  ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long   lhCodCiclFact           ;
         long   lhMontoMinimo           ;          
         long   lhCodConcepto           ;
         long   lhCodTipoDocumento      ;         
         int    ihAplicaAcumNetoGrav    ; /* P-MIX-09003 138632 */
         long   lhCodCliente            ;
         double dhAcumNetoGrav          ; /* P-MIX-09003 136182 */
         double dhTotFactura            ; /* P-MIX-09003 138632 */
         double dhMontoCargo        =0.0; /* P-MIX-09003 138632 */         
         long   lhNextCodCiclFact       ;         
         char   szhNextFecEmision [19+1]; /* EXEC SQL VAR szhNextFecEmision IS STRING(19+1); */ 

         long   lhCodClienteIni         ;
         long   lhCodClienteFin         ;         
    /* EXEC SQL END DECLARE SECTION; */ 

                                
    lhCodCiclFact = lCodCiclFact;
    lhMontoMinimo = lMontoMinimo;     

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);
    
    /* Recupera parámetro Cod. Concepto */
    if (!bGetParamCodConcepto(szValParametro))
    {
    	return (FALSE);
    }    
    lhCodConcepto = atol(szValParametro);    
    
    /* Recupera parámetro Cod. Tipo Documento */
    if (!bGetParamTipoDocumento(szValParametro))
    {
    	return (FALSE);
    }    
    lhCodTipoDocumento = atol(szValParametro);  
    
    /* Recupera parámetro Aplica Acum. Neto Grav. */
    if (!bGetParamAplicaAcumNetoGrav(szValParametro))
    {
    	return (FALSE);
    }    
    ihAplicaAcumNetoGrav = atol(szValParametro);      

    sprintf(szTabla1,"FA_FACTDOCU_%ld",stLineaComando.lCodCiclFact);
    
    if (stLineaComando.bRngClientes)
    {   
    	/* Con Rango de Clientes */
    	
        lhCodClienteIni = stLineaComando.lCodClienteIni;
        lhCodClienteFin = stLineaComando.lCodClienteFin; 
        
        vDTrazasLog ( szFuncion, "\n\t** Con Rango de Clientes : Cliente Inicial [%ld] **\n"
                                 "  \t**                         Cliente Final   [%ld] **\n"
                               , LOG05
                               , lhCodClienteIni
                               , lhCodClienteFin);           	
        
        sprintf(szCadenaSQL, "\tSELECT A.COD_CLIENTE, A.ACUM_NETOGRAV, A.TOT_FACTURA " /* P-MIX-09003 138632 */
                             "\n\tFROM %s A "
                             "\n\tWHERE A.TOT_FACTURA   < %ld "
                             "\n\t AND  A.IMP_SALDOANT  = 0 "
                             "\n\t AND  A.COD_TIPDOCUM  != %ld "
                             "\n\t AND  A.COD_CLIENTE   >= %ld "
                             "\n\t AND  A.COD_CLIENTE   <= %ld "                             
                           , szTabla1
                           , lhMontoMinimo
                           , lhCodTipoDocumento
                           , lhCodClienteIni
                           , lhCodClienteFin);
    }
    else
    {
    	/* Sin Rango de Clientes */
    	 
        vDTrazasLog ( szFuncion, "\n\t** Sin Rango de Clientes **\n"
                            , LOG05);     	
                            
        sprintf(szCadenaSQL, "\tSELECT A.COD_CLIENTE, A.ACUM_NETOGRAV, A.TOT_FACTURA "
                             "\n\tFROM %s A "
                             "\n\tWHERE A.TOT_FACTURA   < %ld "
                             "\n\t AND  A.IMP_SALDOANT  = 0 "
                             "\n\t AND  A.COD_TIPDOCUM  != %ld "
                           , szTabla1
                           , lhMontoMinimo
                           , lhCodTipoDocumento); 	
    	}
    
    vDTrazasLog( szFuncion,"\n\t=> query curFactDocu (\n%s\n\t)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Facturas FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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


    
    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szFuncion, "\n\tError en PREPARE sql_Facturas. Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE curFactDocu CURSOR FOR sql_Facturas; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szFuncion, "\n\tError en DECLARE. curFactDocu. Error [%d][%s]"
                             , LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
        
    vDTrazasLog( szFuncion, "\n\t CiclFact      : [%ld] "
                            "\n\t MontoMinimo   : [%ld] "
                         , LOG05,lhCodCiclFact,lhMontoMinimo);        
    
    /* Recupera Valores proximo Ciclo Facturacion */
    memset(szNextFecEmision,'\0',sizeof(szNextFecEmision));
    memset(szhNextFecEmision,'\0',sizeof(szhNextFecEmision));
    if (!bfnGetProxCiclFact(lhCodCiclFact, &lNextCodCiclFact,szNextFecEmision))
    {
    	return (FALSE);
    }           
    lhNextCodCiclFact = lNextCodCiclFact;    
    strcpy(szhNextFecEmision, szNextFecEmision);
    
    vDTrazasLog  (szFuncion, "\n\t** Ciclo Proceso Clientes **",LOG05);    
    
    /* EXEC SQL OPEN curFactDocu; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if(SQLCODE == SQLNOTFOUND)
    {
       vDTrazasLog  (szFuncion," ** No Existen Datos en curFactDocu **",LOG01);
       vDTrazasError(szFuncion," ** No Existen Datos en curFactDocu **",LOG01);
       return (FALSE);
    }       
    
    if(sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog ( szFuncion, "\n\tError en OPEN curFactDocu. Error [%i][%s]"
                             , LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }    
    
    while (SQLCODE != SQLNOTFOUND)
    {
           vDTrazasLog  (szFuncion, "\n\t** Leyendo Cursor curFactDocu **",LOG05);     	
           
           /* EXEC SQL 
                FETCH curFactDocu
                INTO  :lhCodCliente,
                      :dhAcumNetoGrav, /o P-MIX-09003 136182 o/ 
                      :dhTotFactura; */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 3;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.iters = (unsigned int  )1;
           sqlstm.offset = (unsigned int  )39;
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
           sqlstm.sqhstv[1] = (unsigned char  *)&dhAcumNetoGrav;
           sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[1] = (         int  )0;
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)&dhTotFactura;
           sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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

   /* P-MIX-09003 138632 */ 
                
        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
           vDTrazasError(szFuncion, "\t\tError en Fetch de Cursor curFactDocu [%ld]: %s",LOG01, SQLCODE, SQLERRM);        	
           vDTrazasLog  (szFuncion, "\t\tError en Fetch de Cursor curFactDocu [%ld]: %s",LOG01, SQLCODE, SQLERRM);
           return (FALSE);
        }
        else
        {        	        	
           if (SQLCODE != SQLNOTFOUND)
           {
                /* Evaluando Total Factura para generar cargo*/
                vDTrazasLog  (szFuncion, "\n\t** PROCESANDO CLIENTE [%ld]**"
                                         "\n\t=> Aplica Acum. Neto Grav. (1=si,0=no) [%d]" /* P-MIX-09003 136182 */                
                                         "\n\t=> Acum. Neto Grav.                    [%f]" /* P-MIX-09003 136182 */
                                         "\n\t=> Tot. Factura                        [%f]"                                         
                                       , LOG05
                                       , lhCodCliente                                       
                                       , ihAplicaAcumNetoGrav
                                       , dhAcumNetoGrav
                                       , dhTotFactura);
                                       
                if (ihAplicaAcumNetoGrav == 1) /* Aplica Acum. Neto Grav. */ /* P-MIX-09003 138632 */
                {
                    dhMontoCargo = dhAcumNetoGrav;                   	 
           	} 
           	else /* NO Aplica Acum. Neto Grav. */ /* P-MIX-09003 138632 */
           	{
                    dhMontoCargo = dhTotFactura;           	                    	                    		
           	}
           	
                if ( dhMontoCargo > 0.0) 
                {
                     vDTrazasLog  (szFuncion, "\n\t\tINSERTANDO CARGO"
                                              "\n\t\tCod. Concepto       [%ld]"
                                              "\n\t\tCod. Cliente        [%ld]"
                                              "\n\t\tMonto Cargo         [%f]"
                                              "\n\t\tProx. Ciclo Fact.   [%ld]"
                                              "\n\t\tProx. Fecha Emision [%s]"                                                                                                                                                                                    
                                            , LOG05
                                            , lhCodConcepto
                                            , lhCodCliente
                                            , dhMontoCargo
                                            , lhNextCodCiclFact
                                            , szhNextFecEmision);                	
                                            
                    /* Insertando Cargo en Tabla GE_CARGOS */                                            
                    if (!bfnDBInsertCargo( lhCodConcepto, lhCodCliente, dhMontoCargo,  
           	                       lhNextCodCiclFact, szhNextFecEmision))
           	    {
           	        return FALSE;
           	    }
           	}
           	else
           	{
           	    vDTrazasLog  (szFuncion, "\n\t*** No se genera cargo por Monto Cargo <= 0 ***", LOG03);
           	}
           	
                vDTrazasLog  (szFuncion, "\n\t\tACTUALIZANDO DOCUMENTO"
                                         "\n\t\tCod. Ciclo Fact     [%ld]"
                                         "\n\t\tCod. Cliente        [%ld]"
                                         "\n\t\tCod. Tipo Documento [%ld]"
                                       , LOG05
                                       , lhCodCiclFact
                                       , lhCodCliente
                                       , lhCodTipoDocumento);         	
           	if (!bfnUpdateFactDocu(lhCodCiclFact, lhCodCliente, lhCodTipoDocumento))
           	{
           	     return FALSE;
           	}           	           	           	           	           	           	           	           	
           }
        }                                 	
    } /* Fin WHILE */
    
    /* EXEC SQL CLOSE curFactDocu; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if(SQLCODE != SQLOK)
    {
       vDTrazasError(szFuncion,"\t\tError al cerrar el Cursor curFactDocu [%ld]: %s",LOG01, SQLCODE, SQLERRM);
       vDTrazasLog  (szFuncion,"\t\tError al cerrar el Cursor curFactDocu [%ld]: %s",LOG01, SQLCODE, SQLERRM);       
       return FALSE;
    }    
    
    return (TRUE);

}/**************************** Final bfnSelectFactDocu ****************************/

/*******************************************************************************/
/* FUNCION     : bfnUpdateFactDocu                                             */
/* DESCRIPCION : Actualiza Tabla FA_FACTDOCU de acuerdo a Ciclo que se procesa */
/*******************************************************************************/
BOOL bfnUpdateFactDocu( long  lCodCiclFact, long lCodCliente, long lCodTipoDocumento)
{
    char szFuncion []= "bfnUpdateFactDocu";
    char  szTabla                  [50]="";
    char  szCadenaSQL            [2500]="";       
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long  lhCodCiclFact     ;
         long  lhCodCliente      ;         
         long  lhCodTipoDocumento;                  
    /* EXEC SQL END DECLARE SECTION; */ 
    
    	
    lhCodCiclFact      = lCodCiclFact;
    lhCodCliente       = lCodCliente;
    lhCodTipoDocumento = lCodTipoDocumento;
    
    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);
    
    sprintf(szTabla,"FA_FACTDOCU_%ld",stLineaComando.lCodCiclFact);    
    
    vDTrazasLog( szFuncion , "\n\t**  Valores UPDATE %s **"
                                 "\n\t\t=> Tipo Documento [%ld]"
                                 "\n\t\t=> Ind. Impresa   [1] "
                                 "\n\t\t=> Ind. PasoCobro [1] "                                 
                                 "\n\t\t=> Ind. LibroIva  [1] "                                 
                               , LOG05, szTabla, lhCodTipoDocumento);    
    
    sprintf(szCadenaSQL, "\t UPDATE %s "
                         "\t SET COD_TIPDOCUM  = %ld, "
                         "\t     IND_IMPRESA   = 1, "
                         "\t     IND_PASOCOBRO = 1, "
                         "\t     IND_LIBROIVA  = 1  "                         
                         "\n\tWHERE COD_CLIENTE = %ld "
                       , szTabla
                       , lhCodTipoDocumento
                       , lhCodCliente); 
                       
    /* EXEC SQL PREPARE sql_update_dinamica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )81;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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


    
    if (SQLCODE)
    {
	vDTrazasError(szFuncion, "\n\tError PREPARE sql_update_dinamica Tabla [%s] [%s]"
	                       , LOG01, szTabla, SQLERRM);
	vDTrazasLog  (szFuncion, "\n\tError PREPARE sql_update_dinamica Tabla [%s] [%s]"
	                       , LOG01, szTabla, SQLERRM);
	return FALSE;
    }    
    
    /* EXEC SQL EXECUTE sql_update_dinamica; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )100;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    
                       
    if ( SQLCODE != SQLOK)
    {
        vDTrazasLog( szFuncion , "\n\t**  Error UPDATE %s **"
                                 "\n\t\t=> Error : [%d]  [%s] "
                               , LOG01, szTabla, SQLCODE, SQLERRM);
        vDTrazasError( szFuncion , "\n\t**  Error UPDATE %s **"
                                   "\n\t\t=> Error : [%d]  [%s] "
                                 , LOG01, szTabla, SQLCODE, SQLERRM);
        return FALSE;
    }  
    	
    return TRUE;
}

/*****************************************************************************/
/* FUNCION     : bfnGetProxCiclFact                                          */
/* DESCRIPCION : Recuperar Valores Proximo Ciclo Facturación y Fecha Emision */
/*****************************************************************************/
BOOL bfnGetProxCiclFact(long lCodCiclFact, long *lNextCiclFact, char *szNextFecEmision)
{
    char szFuncion []= "bfnGetProxCiclFact";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long  lhCodCiclFact;
         long  lhNextCodCiclFact;         
         char  szhNextFecEmision [19+1]; /* EXEC SQL VAR szhNextFecEmision IS STRING(19+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 
    

    memset(szhNextFecEmision,'\0',sizeof(szhNextFecEmision));
    lhCodCiclFact = lCodCiclFact;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);
    
    /* EXEC SQL
         SELECT TO_CHAR(MIN(FEC_EMISION),'DD-MM-YYYY HH24:MI:SS'), COD_CICLFACT 
         INTO   :szhNextFecEmision,:lhNextCodCiclFact
         FROM   FA_CICLFACT 
         WHERE  COD_CICLO = (SELECT COD_CICLO FROM FA_CICLFACT 
                             WHERE  COD_CICLFACT = :lhCodCiclFact)
         AND    FEC_EMISION > (SELECT FEC_EMISION FROM FA_CICLFACT 
                               WHERE COD_CICLFACT = :lhCodCiclFact)
         AND    ROWNUM = 1                     
         GROUP BY COD_CICLFACT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(min(FEC_EMISION),'DD-MM-YYYY HH24:MI:SS') \
,COD_CICLFACT into :b0,:b1  from FA_CICLFACT where ((COD_CICLO=(select COD_CIC\
LO  from FA_CICLFACT where COD_CICLFACT=:b2) and FEC_EMISION>(select FEC_EMISI\
ON  from FA_CICLFACT where COD_CICLFACT=:b2)) and ROWNUM=1) group by COD_CICLF\
ACT";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )115;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNextFecEmision;
    sqlstm.sqhstl[0] = (unsigned long )20;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNextCodCiclFact;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
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

    
    
    
    if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasLog( szFuncion , "\n\t**  Error SELECT FA_CICLFACT **"
                                 "\n\t\t=> Error : [%d]  [%s] "
                               , LOG01,SQLCODE,SQLERRM);
        vDTrazasError( szFuncion , "\n\t**  Error SELECT FA_CICLFACT **"
                                   "\n\t\t=> Error : [%d]  [%s] "
                                 , LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
        
    *lNextCiclFact = lhNextCodCiclFact;    
    strcpy(szNextFecEmision,szhNextFecEmision);
    
    vDTrazasLog(szFuncion,"\n\tSiguiente Ciclo Facturacion : [%ld] ",LOG04,*lNextCiclFact);
    vDTrazasLog(szFuncion,"\n\t          Fecha Emision     : [%s] ",LOG04,szNextFecEmision);        
    
    return TRUE;
}

/*****************************************************************************/
/* FUNCION     : bGetParamTipoDocumento                                      */
/* DESCRIPCION : Recuperar parámetro Tipo Documento (673) desde              */
/*               Tabla FAD_PARAMETROS                                        */
/*****************************************************************************/
BOOL bGetParamTipoDocumento (char *szValor)
{
    char szFuncion []= "bGetParamTipoDocumento";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhValorParametro[512+1]; /* EXEC SQL VAR szhValorParametro   IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [32+1] ="";
    char szValParametro [512+1]="";
    int  iRes;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);

    /* Obtencion Valor Tipo Documento */
    iRes = ifnGetParametro(673,szTipParametro,szhValorParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro de TIPO DOCUMENTO 673 error [%d] **"
                                 , LOG01
                                 , iRes);
            return (FALSE);
        }
        strcpy(szValor,szhValorParametro);
    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t\t=> ADVETENCIA, No existe parámetro 673 TIPO DOCUMENTO",LOG03);
        return (FALSE);
    }

    return (TRUE);
} /************************* FIN bGetParamTipoDocumento ************************/

/*****************************************************************************/
/* FUNCION     : bGetParamMontoMinimo                                        */
/* DESCRIPCION : Recuperar parámetro Monto Mínimo Facturable (671) desde     */
/*               Tabla FAD_PARAMETROS                                        */
/*****************************************************************************/
BOOL bGetParamMontoMinimo (char *szValor)
{
    char szFuncion []= "bGetParamMontoMinimo";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhValorParametro[512+1]; /* EXEC SQL VAR szhValorParametro   IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [32+1] ="";
    char szValParametro [512+1]="";
    int  iRes;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);

    /* Obtencion Valor Monto Minimo Facturable */
    iRes = ifnGetParametro(671,szTipParametro,szhValorParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro 671 MONTO MINIMO FACTURABLE error [%d] **"
                                 , LOG01
                                 , iRes);
            return (FALSE);
        }
        strcpy(szValor,szhValorParametro);
    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t\t=> ADVETENCIA, No existe parámetro 671 MONTO MINIMO FACTURABLE",LOG03);
        return (FALSE);
    }

    return (TRUE);
} /************************* FIN bGetParamMontoMinimo ************************/

/*******************************************************************************************/
/* FUNCION     : bGetParamCodConcepto                                                      */
/* DESCRIPCION : Recuperar parámetro Cod. Concepto Monto Mínimo Facturable (672) desde     */
/*               Tabla FAD_PARAMETROS                                                      */
/*******************************************************************************************/
BOOL bGetParamCodConcepto (char *szValor)
{
    char szFuncion []= "bGetParamCodConcepto";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhValorParametro[512+1]; /* EXEC SQL VAR szhValorParametro   IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [32+1] ="";
    char szValParametro [512+1]="";
    int  iRes;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);

    /* Obtencion Valor Cod. de Concepto */
    iRes = ifnGetParametro(672,szTipParametro,szhValorParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro 672 COD. CONCEPTO error [%d] **"
                                 , LOG01
                                 , iRes);
            return (FALSE);
        }
        strcpy(szValor,szhValorParametro);
    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t\t=> ADVETENCIA, No existe parámetro 672 COD. CONCEPTO",LOG03);
        return (FALSE);
    }

    return (TRUE);
} /************************* FIN bGetParamCodConcepto ************************/

/* P-MIX-09003 138632 */
/*******************************************************************************************/
/* FUNCION     : bGetParamAplicaAcumNetoGrav                                               */
/* DESCRIPCION : Recuperar parámetro Aplica Acum. Neto Grav. (682) desde                   */
/*               Tabla FAD_PARAMETROS                                                      */
/*******************************************************************************************/
BOOL bGetParamAplicaAcumNetoGrav (char *szValor)
{
    char szFuncion []= "bGetParamAplicaAcumNetoGrav";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhValorParametro[512+1]; /* EXEC SQL VAR szhValorParametro   IS STRING(512+1); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    char szTipParametro [32+1] ="";
    char szValParametro [512+1]="";
    int  iRes;

    vDTrazasLog(szFuncion,"\n\tEntrando a %s ",LOG04,szFuncion);

    /* Obtencion Valor Aplica Acum. Neto Grav. */
    iRes = ifnGetParametro(682,szTipParametro,szhValorParametro ) ;

    if (iRes != SQLNOTFOUND)
    {
        if (iRes != SQLOK)
        {
            vDTrazasLog(szFuncion, "\n\t** ERROR, al recuperar parámetro 682 Aplica Acum. Neto Grav. error [%d] **"
                                 , LOG01
                                 , iRes);
            return (FALSE);
        }
        strcpy(szValor,szhValorParametro);
    }
    else
    {
        vDTrazasLog (szFuncion,"\n\t\t=> ADVETENCIA, No existe parámetro 682 Aplica Acum. Neto Grav.",LOG03);
        return (FALSE);
    }

    return (TRUE);
} /************************* FIN bGetParamAplicaAcumNetoGrav ************************/
/* P-MIX-09003 138632 */

/*********************************************************************************/
/* FUNCION     : bfnDBInsertCargo()                                              */
/* DESCRIPCION : Pasamos datos a la tabla GE_CARGOS                              */
/*********************************************************************************/
BOOL bfnDBInsertCargo( long   lCodConcepto, 
                       long   lCodCliente, 
                       double dMontoCargo, 
                       long   lNextCodCiclFact, 
                       char   *szNextFecEmision)
{
    char szFuncion          []="bfnDBInsertCargo";	
    char szCadenaInsert [2048]="";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhCodCliente;         
         long    lhCodConcepto;
         long    lhNextCodCiclFact;
         char    szhNextFecEmision [19+1]; /* EXEC SQL VAR szhNextFecEmision IS STRING(19+1); */ 

         double  dhMontoCargo; /* P-MIX-09003 136182 */
    /* EXEC SQL END DECLARE SECTION; */ 
    

    memset(szhNextFecEmision,'\0',sizeof(szhNextFecEmision));

    lhCodCliente      = lCodCliente;
    lhCodConcepto     = lCodConcepto;
    dhMontoCargo      = dMontoCargo; /* P-MIX-09003 136182 */    
    lhNextCodCiclFact = lNextCodCiclFact;
    strcpy(szhNextFecEmision,szNextFecEmision);   

    vDTrazasLog ( szFuncion, "\n\tEntrada en bfnDBInsertCargo "
                             "\n\t=> Cód. Cliente               [%ld]"
                             "\n\t=> Cód. Concepto              [%ld]"
                             "\n\t=> Monto Cargo                [%f]"
                             "\n\t=> Prox. Ciclo Facturacion    [%ld]"
                             "\n\t=> Fecha Emision              [%s]"
                            , LOG05
                            , lhCodCliente
                            , lhCodConcepto
                            , dhMontoCargo
                            , lhNextCodCiclFact
                            , szhNextFecEmision);
                            
                      
    /* EXEC SQL 
         INSERT INTO GE_CARGOS (
                       NUM_CARGO,       COD_CLIENTE,
                       COD_PRODUCTO,    COD_CONCEPTO,
                       FEC_ALTA,        IMP_CARGO,
                       COD_MONEDA,      COD_PLANCOM,
                       NUM_UNIDADES,    IND_FACTUR,
                       NUM_TRANSACCION, NUM_VENTA,
                       NUM_PAQUETE,     NUM_ABONADO,
                       NUM_TERMINAL,    COD_CICLFACT,
                       NUM_SERIE,       NUM_SERIEMEC,
                       CAP_CODE,        MES_GARANTIA,
                       NUM_PREGUIA,     NUM_GUIA,
                       NUM_FACTURA,     COD_CONCEPTO_DTO,
                       VAL_DTO,         TIP_DTO,
                       IND_CUOTA,       IND_SUPERTEL,
                       IND_MANUAL,      NOM_USUARORA,
                       PREF_PLAZA,      COD_TECNOLOGIA
                      )
         VALUES (GE_SEQ_CARGOS.NEXTVAL, :lhCodCliente,
                 :iCodProducto,        :lhCodConcepto,
                 TO_DATE(:szhNextFecEmision,'DD-MM-YYYY HH24:MI:SS'), :dhMontoCargo, 
                 :szCodMoneda,          :iCodPlanCom,
                 :iNumUnidades,         :iIndFactur,
                 :iNumTransaccion,      :iNumVenta,
                 NULL,                  NULL,
                 NULL,                  :lhNextCodCiclFact,
                 NULL,                  NULL,
                 NULL,                  NULL,
                 NULL,                  NULL,
                 :iNumFactura ,         NULL,
                 NULL,                  NULL,
                 :iIndCuota,            NULL,
                 NULL,                  NULL,
                 NULL,                  NULL
                ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into GE_CARGOS (NUM_CARGO,COD_CLIENTE,COD_PRODUCTO\
,COD_CONCEPTO,FEC_ALTA,IMP_CARGO,COD_MONEDA,COD_PLANCOM,NUM_UNIDADES,IND_FACTU\
R,NUM_TRANSACCION,NUM_VENTA,NUM_PAQUETE,NUM_ABONADO,NUM_TERMINAL,COD_CICLFACT,\
NUM_SERIE,NUM_SERIEMEC,CAP_CODE,MES_GARANTIA,NUM_PREGUIA,NUM_GUIA,NUM_FACTURA,\
COD_CONCEPTO_DTO,VAL_DTO,TIP_DTO,IND_CUOTA,IND_SUPERTEL,IND_MANUAL,NOM_USUAROR\
A,PREF_PLAZA,COD_TECNOLOGIA) values (GE_SEQ_CARGOS.nextval ,:b0,:b1,:b2,TO_DAT\
E(:b3,'DD-MM-YYYY HH24:MI:SS'),:b4,:b5,:b6,:b7,:b8,:b9,:b10,null ,null ,null ,\
:b11,null ,null ,null ,null ,null ,null ,:b12,null ,null ,null ,:b13,null ,nul\
l ,null ,null ,null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )146;
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
    sqlstm.sqhstv[1] = (unsigned char  *)&iCodProducto;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodConcepto;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhNextFecEmision;
    sqlstm.sqhstl[3] = (unsigned long )20;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&dhMontoCargo;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szCodMoneda;
    sqlstm.sqhstl[5] = (unsigned long )0;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&iCodPlanCom;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&iNumUnidades;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&iIndFactur;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&iNumTransaccion;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&iNumVenta;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&lhNextCodCiclFact;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&iNumFactura;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&iIndCuota;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
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

                           
                           
    if (SQLCODE != SQLOK) 
    {
        vDTrazasError(szFuncion, "\n\tError en INSERT GE_CARGOS : %s"
                              , LOG01, SQLERRM);
        vDTrazasLog  (szFuncion, "\n\tError en INSERT GE_CARGOS : %s"
                               , LOG01, SQLERRM); 
        return(FALSE);
    }                               

    return (TRUE);
}/* **************** * END bfnDBPasarCargosConProceso * ******************** */

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

