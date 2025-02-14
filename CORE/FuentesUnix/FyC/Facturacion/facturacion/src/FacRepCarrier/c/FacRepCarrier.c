
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
           char  filnam[22];
};
static struct sqlcxp sqlfpn =
{
    21,
    "./pc/FacRepCarrier.pc"
};


static unsigned long sqlctx = 110247451;


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
            void  *sqhstv[9];
   unsigned int   sqhstl[9];
            int   sqhsts[9];
            void  *sqindv[9];
            int   sqinds[9];
   unsigned int   sqharm[9];
   unsigned int   *sqharc[9];
   unsigned short  sqadto[9];
   unsigned short  sqtdso[9];
} sqlstm = {10,9};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{10,4130,0,0,0,
5,0,0,1,45,0,1,252,0,0,0,0,0,1,0,
20,0,0,2,167,0,4,347,0,0,3,1,0,1,0,2,3,0,0,2,97,0,0,1,3,0,0,
47,0,0,3,68,0,4,389,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
70,0,0,4,0,0,17,475,0,0,1,1,0,1,0,1,97,0,0,
89,0,0,4,0,0,45,492,0,0,0,0,0,1,0,
104,0,0,4,0,0,13,525,0,0,9,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,
4,0,0,2,3,0,0,2,4,0,0,2,97,0,0,
155,0,0,4,0,0,15,623,0,0,0,0,0,1,0,
};


#line 1 "./pc/FacRepCarrier.pc"
/* *********************************************************************** */
/* *  Fichero : FacRepFacCarrier.pc (Generador de FacRepFacCarrier.c)    * */
/* *  Reporte de detalle de facturacion Carrier                          * */
/* *  Autor   : Jorge Quintanilla.                                       * */
/* *********************************************************************** */


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

#line 9 "./pc/FacRepCarrier.pc"


#define _REPCARRIER_C_

#include "FacRepCarrier.h"

int main(int argc, char *argv[])
{
    
    char szPath  [256] = "";

/* -Variables acerca de la version---------------------------------------------------- */
	char szAppName[]="FacRepCarrier";
	char szAppVerN[]="1.0";
	char szAppDate[]="27-Abr-2005";

/* -Variables para manejo de archivos y opciones de invocacion------------------------- */
	char szUsuario [128] = "";
	char *psztmp , szOraAccount[32]="", szOraPasswd[32]="";
	char *pathDir;
    char szAux[30]= "";
    char szModulo[10]="main";
    
	char szUsage[]=
	"\n Uso: FacRepCarrier -u [usuario/password | / ] -c {ciclo} -p {portadora} [-d]"
	"\n Donde      -u : Usuario/Password Oracle."
	"\n            -c : Ciclo de facturacion. "
	"\n            -p : Portadora (Carrier)."
	"\n            -d : Delimitador (opcional)."
	"\n";

	int Userflag       =FALSE;
	int iIngresoCarrier=FALSE;
	int iIngresoCiclo  =FALSE;

	extern char *optarg;
	extern int optind, opterr, optopt;

	char opt[] = "u:c:p:d";
	int iOpt=0;
	
	long lCodCiclFact  = 0;
    char szCodCarrier[6] = "";
    char szDelim[2]= "";
    
    long lNumProceso = 0;
    long lNumRegs=0;
    char szFecEmision[11+1] = "";
    char szTablaVenc[20]    = "";
    
	
    /** Muestra Informacion de la version **/
    fprintf(stdout, "\n\tAplicacion : \"%s\" \n\tVersion    : %s\n\tRevision   : %s\n\n",
                    szAppName,szAppVerN,szAppDate);

    /** Seteo inicial de fecha, nivel de Log y contador de errores **/
    stStatus.LogNivel = 5;
    strcpy(szfecproceso, cfnGetTime(2)); 

    /** Validacion de parametros de invocacion **/

    if(argc == 1)
    {   
        fprintf(stderr,"\n\t<< Numero invalido de parametros >>\n%s\n",szUsage);
        return FALSE;
    }

	opterr=0;

	while ((iOpt = getopt(argc, argv, opt)) != EOF)
	{
		switch(iOpt)
		{
			case 'u': /* username */
				if (strlen(optarg))
                {
                    strcpy(szUsuario,optarg);
                    Userflag=TRUE;
                }
				break;

			case 'c':
                if (strlen (optarg))
                {
                    strncpy(szAux,optarg,iMaxLargoCiclo);
                    szAux[iMaxLargoCiclo] = '\0';
                    lCodCiclFact = atol(szAux);
                    iIngresoCiclo=TRUE;
                }
                else
                {
                    fprintf(stderr, "\n\t<< Error: Debe ingresar ciclo >>\n%s",szUsage);
                    return -1;        
                }
                break;
                
            case 'p':
                if (strlen (optarg))
                {
                    strncpy(szCodCarrier,optarg,iMaxLargoCarrier);
                    szCodCarrier[iMaxLargoCarrier] = '\0';
                    iIngresoCarrier= TRUE;
                }
                else
                {
                    fprintf(stderr, "\n\t<< Error: Debe ingresar Carrier >>\n%s",szUsage);
                    return -2;        
                }
                break;
            
            case 'd': /* username */
				
                strcpy(szDelim,";");
				break;
			
			case '?':
				fprintf(stderr,"\n<< Error: Se ha ingresado parametro desconocido: -%c >>\n%s\n",optopt,szUsage);
				return FALSE;

            
			case ':':
				if ( optopt == 'u' )
					fprintf(stderr,"\n<< Error: Falta especificar usuario/password o \"/\" >>\n%s",szUsage);
				if ( optopt == 'c' )
					fprintf(stderr,"\n<< Error: Falta especificar ciclo. >>\n%s",szUsage);
                if ( optopt == 'p' )
					fprintf(stderr,"\n<< Error: Falta especificar portadora. >>\n%s",szUsage);

				return FALSE;
            
			default :
			    return FALSE;
		}
	}
    
    if (lCodCiclFact == 0)
    {
        fprintf (stderr, "\n<< Error: Falta especificar ciclo. >>\n%s", szUsage);
        return -1;
    }

    if (lCodCiclFact < 1000 || lCodCiclFact > 999999)
    {
        fprintf (stderr, "\n<< Error: Ciclo de Facturacion Invalido.>>\n%s\n", szUsage);
        return -1;
    }
    
    if(!iIngresoCarrier)
    {
        fprintf(stderr,"\n<< Error: Falta especificar portadora. >>\n%s",szUsage);
        return -1;    
    }
    else
    {
        /* Validacion de la cadena */
        if(strpbrk(szCodCarrier,szCadValidacion) != NULL) {
            fprintf(stderr,"\n<< Error: Caracteres no permitidos en cadena de portadora. >>\n%s",szUsage);
            return -1;    
            
        }
        if(!ifnEsNumerico(szCodCarrier)) {
            fprintf(stderr,"\n<< Error: Caracteres no permitidos en cadena de portadora. >>\n%s",szUsage);
            return -1;    
            
        }
            
            
    }
    
    
	if (Userflag == FALSE)	/*Si no se especifico usuario/password asume los de oracle */
	{
		fprintf (stdout,"\tUsuario  : [default]\n\tPassword : [default]");
	}
	else
	{
		if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
		{
			fprintf (stderr,"\n\t<< Usuario Oracle especificado [%s] no Valido >> \n", szUsuario);
			return -1;
		}
		else if (strlen(szUsuario) == 1)
		{
			fprintf (stdout,"\n\tUsuario  : [default]\n\tPassword : [default]");
		}
		else
		{
			strncpy (szOraAccount,szUsuario,psztmp-szUsuario);
			strcpy  (szOraPasswd, psztmp+1);
		    fprintf (stdout,"\n\tUsuario  : [%s]"
		                    "\n\tPassword : [%s]"
		                    "\n\tCiclo    : [%ld]"
		                    "\n\tCarrier  : [%s]",
		    	 			 szOraAccount, szOraPasswd,lCodCiclFact,szCodCarrier);
		}

    }

    fprintf(stdout,"\n\tFec Proc : [%s]\n",szfecproceso);

    /** Conexion a Oracle **/
	if (!fnOraConnect(szOraAccount,szOraPasswd))
	{
		fprintf (stderr, "\n\t<< Fallo la conexion a la Base de Datos >> \n");
        return -1;
    }
    else
    {
        fprintf(stdout,"\n\t--> Conectado a Oracle <--\n\n");    
    }
    
    /** Apertura de archivos de Log y de reporte **/ 
	pathDir=(char *)malloc(512*sizeof(char));
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/carrier",pathDir);
	free(pathDir);    

	sprintf(stStatus.ErrName,"%s/FacRepCarrier_%ld_%s.err", szPath, lCodCiclFact, szCodCarrier);
	if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
      	fprintf( stderr, "\n*Error: No se pudo abrir el archivo de errores %s \n", stStatus.ErrName);
        return -1;
    }
    
    sprintf(stStatus.LogName, "%s/FacRepCarrier_%ld_%s.log", szPath, lCodCiclFact, szCodCarrier);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
      	fprintf(stderr, "\n*Error: No pudo abrirse el archivo de log %s\n", stStatus.LogName);
        vDTrazasError(szModulo , "\n<< No pudo abrirse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return -1;
    }    
    
    vDTrazasLog(szModulo , "\n\tAplicacion : \"%s\" \n\tVersion    : %s\n\tRevision   : %s\n\n",
                    LOG03,szAppName,szAppVerN,szAppDate);
    vDTrazasLog(szModulo , "\n\tUsuario  : [%s]"
	                      "\n\tPassword : [%s]"
	                      "\n\tCiclo    : [%ld]"
	                      "\n\tCarrier  : [%s]",
	 			          LOG03,szOraAccount, szOraPasswd,lCodCiclFact,szCodCarrier);
    
    /** Extraccion de los datos necesarios para la creacion del reporte **/ 
    
    /* Ambiente: Espanol */
    /* EXEC SQL ALTER SESSION SET NLS_DATE_LANGUAGE=SPANISH; */ 
#line 252 "./pc/FacRepCarrier.pc"

{
#line 252 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 0;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.stmt = "alter SESSION SET NLS_DATE_LANGUAGE = SPANISH";
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )5;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 252 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 252 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 252 "./pc/FacRepCarrier.pc"
}

#line 252 "./pc/FacRepCarrier.pc"

    
    /* Obtencion del numero de proceso y fecha de emision */
    if(!bfnObtenerDatosProceso(lCodCiclFact,&lNumProceso,szFecEmision))
    {
        /* Error */
        fprintf(stderr,"*ERROR(main) : En la extraccion del numero de proceso para el ciclo [%ld]\n",lCodCiclFact);
        vDTrazasError(szModulo , "\n<< En la extraccion del numero de proceso para el ciclo [%ld] >>\n", LOG01, lCodCiclFact);
        fprintf(stderr,"** Proceso finalizado debido a errores. \n");
        return -1;
    }
    
    vDTrazasLog( szModulo, "\n\tNumero de proceso: [%ld]"
                    "\n\tFecha de emision : [%s]\n",LOG03, lNumProceso, szFecEmision);
    
    /* Identificar la tabla desde la cual obtener fecha de vencimientos */
    if(!bfnDetectarTablaVencimientos(lCodCiclFact, szTablaVenc))
    {
        /* Error */
        vDTrazasError(szModulo , "\n<< En la extraccion de tabla de vencimento ciclo [%ld] >>\n", LOG01, lCodCiclFact);
        fprintf(stderr,"*Error: En la extraccion de tabla de vencimento ciclo [%ld]\n",lCodCiclFact);
        fprintf(stderr,"** Proceso finalizado debido a errores. \n");
        return -1;
    }
    
    vDTrazasLog(szModulo ,"*(main):Tabla desde la cual obtener fechas de vencimiento : [%s]\n",LOG05,szTablaVenc);
    
    /* Impresion por pantalla de rutas de Archivos de Log y de Error. */
    fprintf(stdout,"\tArchivo de Log: %s\n",stStatus.LogName);
    fprintf(stdout,"\tArchivo de Errores: %s\n",stStatus.ErrName);
    
    /* Recuperacion de los datos necesarios para el reporte */
    
    lNumRegs = lfnCargarReporte(szTablaVenc,lCodCiclFact, szCodCarrier, lNumProceso,szFecEmision);
    if( lNumRegs < 0 )
    {
        /* Error */
        vDTrazasError(szModulo , "\n<< En la carga del reporte para ciclo [%ld] >>\n", LOG01, lCodCiclFact);
        fprintf(stderr,"*Error: En la carga del reporte para ciclo [%ld]\n",lCodCiclFact);
        fprintf(stderr,"** Proceso finalizado debido a errores. \n");
        bfnLiberarReporte();
        return -1;
        
    }

    if( lNumRegs == 0 )
    {
        /* No se recuperaron registros para procesar */
        vDTrazasError(szModulo , "\n<< No se encontraron registros para crear el Reporte. >>\n", LOG01);
        fprintf(stderr,"*Error: No se encontraron registros para crear el Reporte.\n");
        fprintf(stderr,"** Proceso finalizado. \n");
        bfnLiberarReporte();
        return -1;
        
    }    
    
    /** Imprimir reporte en archivo de impresion **/
    if( (lNumRegs = lfnImprimirReporte(lCodCiclFact,szCodCarrier,szDelim)) <= 0)
    {
        vDTrazasError(szModulo , "\n<< Han ocurrido errores en el proceso de Impresion del reporte. >>\n", LOG01);
        fprintf(stderr,"*Error: en la Impresion del Reporte.\n");
        fprintf(stderr,"** Proceso finalizado debido a errores. \n");
        return -1;
    }
    
    fprintf(stdout,"\n\tCantidad de abonados impresos en el Reporte: [%ld].\n",lNumRegs);
    vDTrazasLog(szModulo ,"\n\tCantidad de abonados impresos en el Reporte: [%ld].\n",LOG05,lNumRegs);
    
    /** Liberar la memoria asignada al reporte **/
    bfnLiberarReporte();
    
    /** Programa terminado OK **/
    vDTrazasLog(szModulo ,"\n\t** Proceso Finalizado OK. **\n",LOG05);
    fprintf(stdout,"\n\t** Proceso Finalizado OK. **\n");
    
    return 0;
}



/**
 * Funcion     : bfnObtenerDatosProceso
 * Descripcion : Obtener el numero de proceso y fecha de emision dado un ciclo de facturacion <lCodCiclFact>
 * Retorna     : El numero de proceso y la fecha de emision del ciclo ingresado por parametro
 */
BOOL bfnObtenerDatosProceso(long lCodCiclFact,long *lNumProceso, char *pszFecEmision)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 339 "./pc/FacRepCarrier.pc"

    long lhCodCiclFact       = 0;
    char szhFecEmision[11+1] = "";
    long lhNumProceso        = 0;
    /* EXEC SQL END   DECLARE SECTION; */ 
#line 343 "./pc/FacRepCarrier.pc"
        
    
    lhCodCiclFact = lCodCiclFact;
    
    /* EXEC SQL
        SELECT 
            A.NUM_PROCESO, TO_CHAR(B.FEC_EMISION,'DD/MON/YYYY')
        INTO
            :lhNumProceso, :szhFecEmision        
        FROM 
            FA_PROCESOS A, FA_CICLFACT B     
        WHERE 
            A.COD_CICLFACT = B.COD_CICLFACT
            AND A.COD_CICLFACT = :lhCodCiclFact; */ 
#line 356 "./pc/FacRepCarrier.pc"

{
#line 347 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 3;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.stmt = "select A.NUM_PROCESO ,TO_CHAR(B.FEC_EMISION,'DD/MON/YYYY'\
) into :b0,:b1  from FA_PROCESOS A ,FA_CICLFACT B where (A.COD_CICLFACT=B.COD_\
CICLFACT and A.COD_CICLFACT=:b2)";
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )20;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.selerr = (unsigned short)1;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[0] = (         void  *)&lhNumProceso;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[0] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[0] = (         void  *)0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[0] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[0] = (unsigned int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[0] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[0] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[1] = (         void  *)szhFecEmision;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[1] = (unsigned int  )12;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[1] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[1] = (         void  *)0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[1] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[1] = (unsigned int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[1] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[1] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[2] = (         void  *)&lhCodCiclFact;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[2] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[2] = (         void  *)0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[2] = (         int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[2] = (unsigned int  )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[2] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[2] = (unsigned short )0;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsv = sqlstm.sqhstv;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsl = sqlstm.sqhstl;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqphss = sqlstm.sqhsts;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqpind = sqlstm.sqindv;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqpins = sqlstm.sqinds;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqparm = sqlstm.sqharm;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqparc = sqlstm.sqharc;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqpadto = sqlstm.sqadto;
#line 347 "./pc/FacRepCarrier.pc"
    sqlstm.sqptdso = sqlstm.sqtdso;
#line 347 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 347 "./pc/FacRepCarrier.pc"
}

#line 356 "./pc/FacRepCarrier.pc"
 
            
    if(SQLCODE!=SQLOK)
    {
        fprintf(stderr,"* ERROR(lfnObtenerNumProceso): No se ha logrado obtener datos de fecha y proceso para ciclo [%ld].\n",
                        lCodCiclFact);
        return FALSE;    
        
    }
    
    *lNumProceso = lhNumProceso;
    strcpy(pszFecEmision, szhFecEmision);
    
    return TRUE;
    
}

/**
 * Funcion     : bfnDetectarTablaVencimientos
 * Descripcion : Detectar la tabla desde la cual obtener los vencimientos de los clientes.
 * Retorna     : TRUE       Se ha logrado ejecutar la consulta.
 *               FALSE      No se ha logrado ejecutar la consulta.
 */
BOOL bfnDetectarTablaVencimientos(long lCodCiclFact, char *pszTablaVenc)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 382 "./pc/FacRepCarrier.pc"

    int  ihContReg     = 0;
    long lhCodCiclFact = 0;      
    /* EXEC SQL END   DECLARE SECTION; */ 
#line 385 "./pc/FacRepCarrier.pc"

    
    lhCodCiclFact = lCodCiclFact;
    
    /* EXEC SQL
        SELECT 
            COUNT(*)
        INTO
            :ihContReg
        FROM
            FA_ENLACEHIST
        WHERE 
            COD_CICLFACT = :lhCodCiclFact; */ 
#line 397 "./pc/FacRepCarrier.pc"

{
#line 389 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 3;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.stmt = "select count(*)  into :b0  from FA_ENLACEHIST where COD_C\
ICLFACT=:b1";
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )47;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.selerr = (unsigned short)1;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[0] = (         void  *)&ihContReg;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[0] = (unsigned int  )sizeof(int);
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[0] = (         int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[0] = (         void  *)0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[0] = (         int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[0] = (unsigned int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[0] = (unsigned short )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[0] = (unsigned short )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[1] = (         void  *)&lhCodCiclFact;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[1] = (         int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[1] = (         void  *)0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[1] = (         int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[1] = (unsigned int  )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[1] = (unsigned short )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[1] = (unsigned short )0;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsv = sqlstm.sqhstv;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsl = sqlstm.sqhstl;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqphss = sqlstm.sqhsts;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqpind = sqlstm.sqindv;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqpins = sqlstm.sqinds;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqparm = sqlstm.sqharm;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqparc = sqlstm.sqharc;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqpadto = sqlstm.sqadto;
#line 389 "./pc/FacRepCarrier.pc"
    sqlstm.sqptdso = sqlstm.sqtdso;
#line 389 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 389 "./pc/FacRepCarrier.pc"
}

#line 397 "./pc/FacRepCarrier.pc"

            
    if(SQLCODE!=SQLOK)
    {
        fprintf(stderr,"* ERROR(bfnDetectarTablaVencimientos): En sentencia de acceso a FA_ENLACEHIST.\n");
        return FALSE;    
        
    }
    
    if(ihContReg == 0)
    {
        /* Se debe obtener la fecha de vencimiento desde FA_FACTDOCU */    
        sprintf(pszTablaVenc,"FA_FACTDOCU_%ld",lCodCiclFact);
       
    }
    else
    { 
        /* Se debe obtener la fecha de vencimiento desde FA_HISTDOCU */    
        strcpy(pszTablaVenc,"FA_HISTDOCU");    
        
    }
    return TRUE;
}

/**
 * Funcion     : lfnCargarReporte
 * Descripcion : Cargar en la lista de Reporte los abonados a imprimir.
 * Retorna     : >=0        Numero de registros procesados por la consulta.
 *               < 0       Se ha producido un error dentro de la funcion.
 */
long lfnCargarReporte(char *pszTablaVenc,long lCodCiclFact,char *pszCarrier, long lNumProceso, char *pszFecEmi)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 
#line 429 "./pc/FacRepCarrier.pc"

    char    szStmtSql[1024] = "";
   
    long    lhNumAbonado    = 0;
    long    lhCodCliente    = 0;
    long    lhNumCelular    = 0;
    long    lhCodPeriodo    = 0;
    char    szhCodTrafico[3]= "";
    double  dhTotImpNeto  = 0.0;
    long    lhCodTipConce  = 0;
    double  dhImpConsumido= 0.0;
    char    szhFecVenc[12]  = ""; 
    /* EXEC SQL END   DECLARE SECTION; */ 
#line 441 "./pc/FacRepCarrier.pc"
    
    
    int  i=1,iPrimeraVez=1;
    long lAboAnt =0;
    char *pszModulo = "lfnCargarReporte";
    
    int  iCelularCargado = 0;
    int  iFecEmiCargada  = 0;
    int  iFecVenCargada  = 0;
    
    TReporte *pstNodo=NULL;
    TReporte *pstActual=NULL;
    
    
    /* Preparacion de la sentencia SQL */
    sprintf(szStmtSql,
                     "SELECT /*+ FIRST_ROWS (100) */ A.NUM_ABONADO, A.COD_CLIENTE, C.NUM_CELULAR, A.COD_PERIODO, B.COD_TRAFICO"
                    "\n, ROUND(B.TOT_IMP_NETO,2), ROUND(A.COD_TIPCONCE,2), ROUND(A.IMP_CONSUMIDO,2), TO_CHAR(D.FEC_VENCIMIE,'DD/MON/YYYY')" 
                    "\nFROM FA_ACUMFORTAS A, FA_SUBFORTAS_TO B "
                    "\n,GA_ABOCEL C, %s D "
                    "\nWHERE A.NUM_ABONADO = B.NUM_ABONADO "
                    "\nAND A.COD_CLIENTE = B.COD_CLIENTE "
                    "\nAND A.COD_PERIODO = B.COD_PERIODO "
                    "\nAND A.NUM_ABONADO = C.NUM_ABONADO "
                    "\nAND A.COD_CLIENTE = D.COD_CLIENTE "
                    "\nAND A.COD_OPERADOR = B.COD_OPERADOR "
                    "\nAND A.COD_OPERADOR = %s "
                    "\nAND A.NUM_PROCESO =  %ld "
                    "\nORDER BY A.NUM_ABONADO, A.COD_CLIENTE, B.COD_TRAFICO, A.COD_TIPCONCE "
                    ,pszTablaVenc,pszCarrier, lNumProceso);
   
    vDTrazasLog(pszModulo,"Sentencia SQL para FETCH: [\n%s\n]\n",LOG03,szStmtSql);
    
    
    /* EXEC SQL PREPARE select_stmt FROM :szStmtSql; */ 
#line 475 "./pc/FacRepCarrier.pc"

{
#line 475 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 3;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.stmt = "";
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )70;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstv[0] = (         void  *)szStmtSql;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqhstl[0] = (unsigned int  )1024;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqhsts[0] = (         int  )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqindv[0] = (         void  *)0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqinds[0] = (         int  )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqharm[0] = (unsigned int  )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqadto[0] = (unsigned short )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqtdso[0] = (unsigned short )0;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsv = sqlstm.sqhstv;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqphsl = sqlstm.sqhstl;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqphss = sqlstm.sqhsts;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqpind = sqlstm.sqindv;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqpins = sqlstm.sqinds;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqparm = sqlstm.sqharm;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqparc = sqlstm.sqharc;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqpadto = sqlstm.sqadto;
#line 475 "./pc/FacRepCarrier.pc"
    sqlstm.sqptdso = sqlstm.sqtdso;
#line 475 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 475 "./pc/FacRepCarrier.pc"
}

#line 475 "./pc/FacRepCarrier.pc"

    
    if(SQLCODE!=SQLOK)
    {
        vDTrazasError(pszModulo,"En EXEC SQL PREPARE\nCodigo:[%ld]\n[%s]\n",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Error: En EXEC SQL PREPARE\nCodigo:[%ld]\n[%s]\n", sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return -1;        
    }
        
    /* EXEC SQL DECLARE curRepCursor CURSOR FOR select_stmt; */ 
#line 484 "./pc/FacRepCarrier.pc"

    if(SQLCODE!=SQLOK)
    {
        vDTrazasError(pszModulo,"En EXEC SQL DECLARE curRepCursor\nCodigo:[%ld]\n[%s]\n",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Error: En EXEC SQL DECLARE curRepCursor\nCodigo:[%ld]\n[%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return -1;        
    }
        
    /* EXEC SQL OPEN curRepCursor; */ 
#line 492 "./pc/FacRepCarrier.pc"

{
#line 492 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 3;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.stmt = "";
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )89;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.selerr = (unsigned short)1;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 492 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 492 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 492 "./pc/FacRepCarrier.pc"
}

#line 492 "./pc/FacRepCarrier.pc"

    if(SQLCODE!=SQLOK)
    {
        vDTrazasError(pszModulo,"En EXEC SQL DECLARE curRepCursor\nCodigo:[%ld]\n[%s]\n",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Error: En EXEC SQL DECLARE curRepCursor\nCodigo:[%ld]\n[%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);             
        return -1;        
    }
    
    /* EXEC SQL WHENEVER NOT FOUND DO break; */ 
#line 500 "./pc/FacRepCarrier.pc"

    if(SQLCODE!=SQLOK)
    {
        vDTrazasError(pszModulo,"EXEC SQL WHENEVER NOT FOUND\nCodigo:[%ld]\n[%s]\n",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Error: EXEC SQL WHENEVER NOT FOUND\nCodigo:[%ld]\n[%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return -1;        
    }
    
    /* Crear el primer nodo antes de entrar */
    pstActual = (TReporte*)malloc(sizeof(TReporte));
    if(pstActual==NULL)
    {
        vDTrazasError(pszModulo,"Asignacion de memoria fallida a pstActual para Creacion de Reporte.\n",LOG01);
        fprintf(stderr,"Error: Asignacion de memoria fallida para Creacion de Reporte.\n");
        return -1;             
    }
    memset(pstActual,'\0',sizeof(TReporte));
    pstActual->sgte = NULL;
    pstLista = pstActual;   /* Inicio de la lista */
    
    iPrimeraVez = 1;
    
    for(i=1;;i++)
    {
        
        /* EXEC SQL 
            FETCH 
                curRepCursor 
            INTO
                :lhNumAbonado,  
                :lhCodCliente,
                :lhNumCelular,  
                :lhCodPeriodo,  
                :szhCodTrafico,
                :dhTotImpNeto,  
                :lhCodTipConce, 
                :dhImpConsumido,
                :szhFecVenc; */ 
#line 537 "./pc/FacRepCarrier.pc"

{
#line 525 "./pc/FacRepCarrier.pc"
        struct sqlexd sqlstm;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqlvsn = 10;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.arrsiz = 9;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqladtp = &sqladt;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqltdsp = &sqltds;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.iters = (unsigned int  )1;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.offset = (unsigned int  )104;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.cud = sqlcud0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqlety = (unsigned short)256;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.occurs = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[0] = (         void  *)&lhNumAbonado;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[0] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[0] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[0] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[0] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[0] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[0] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[1] = (         void  *)&lhCodCliente;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[1] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[1] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[1] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[1] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[1] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[1] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[2] = (         void  *)&lhNumCelular;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[2] = (unsigned int  )sizeof(long);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[2] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[2] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[2] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[2] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[2] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[2] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[3] = (         void  *)&lhCodPeriodo;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[3] = (unsigned int  )sizeof(long);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[3] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[3] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[3] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[3] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[3] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[3] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[4] = (         void  *)szhCodTrafico;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[4] = (unsigned int  )3;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[4] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[4] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[4] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[4] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[4] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[4] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[5] = (         void  *)&dhTotImpNeto;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[5] = (unsigned int  )sizeof(double);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[5] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[5] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[5] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[5] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[5] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[5] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[6] = (         void  *)&lhCodTipConce;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[6] = (unsigned int  )sizeof(long);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[6] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[6] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[6] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[6] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[6] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[6] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[7] = (         void  *)&dhImpConsumido;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[7] = (unsigned int  )sizeof(double);
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[7] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[7] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[7] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[7] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[7] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[7] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstv[8] = (         void  *)szhFecVenc;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhstl[8] = (unsigned int  )12;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqhsts[8] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqindv[8] = (         void  *)0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqinds[8] = (         int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqharm[8] = (unsigned int  )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqadto[8] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqtdso[8] = (unsigned short )0;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqphsv = sqlstm.sqhstv;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqphsl = sqlstm.sqhstl;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqphss = sqlstm.sqhsts;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqpind = sqlstm.sqindv;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqpins = sqlstm.sqinds;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqparm = sqlstm.sqharm;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqparc = sqlstm.sqharc;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqpadto = sqlstm.sqadto;
#line 525 "./pc/FacRepCarrier.pc"
        sqlstm.sqptdso = sqlstm.sqtdso;
#line 525 "./pc/FacRepCarrier.pc"
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 525 "./pc/FacRepCarrier.pc"
        if (sqlca.sqlcode == 1403) break;
#line 525 "./pc/FacRepCarrier.pc"
}

#line 537 "./pc/FacRepCarrier.pc"

        
        if(SQLCODE!=SQLOK)
        {
            vDTrazasError(pszModulo,"En consulta SQL FETCH de reporte.\nCodigo:[%ld]\n[%s]\n"
                        ,LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            fprintf(stderr,"* ERROR(bfnCargarReporte): En consulta SQL FETCH de reporte.\nCodigo:[%ld]\n[%s]\n"
                        ,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
            return -1;         
            
        }
        
        /*Si el Abonado Anterior != Actual -> Crear Nuevo Nodo */
        if(lAboAnt!=lhNumAbonado && iPrimeraVez==0){
            
            pstNodo = (TReporte*)malloc(sizeof(TReporte));
            if(pstNodo==NULL)
            {
                vDTrazasError(pszModulo,"Asignacion de memoria fallida a pstNodo para Creacion de Reporte.\n",LOG01);
                fprintf(stderr,"Error: Asignacion de memoria fallida a pstNodo para Creacion de Reporte.\n");
                return -1;             
            }
            memset(pstNodo,'\0',sizeof(TReporte));
            pstActual->sgte = pstNodo;
            pstActual = pstNodo;
            pstActual->sgte =NULL;
           
            /* Reinicializar variables de asignacion de datos */
            iCelularCargado = 0;
            iFecEmiCargada  = 0;
            iFecVenCargada  = 0;
        
        }
        else
            iPrimeraVez = 0;    
        
                
        /*printf("fetch: [%d]\n",i);*/
        vDTrazasLog(pszModulo,"NumAbo:[%ld] CodCli:[%ld] Cel:[%ld] Periodo:[%ld] CodTraf:[%s] TotImpNet:[%.0lf] TipCon:[%ld] ImpCons:[%.0lf] "
               "FeVen:[%s]\n",
                             LOG05,               
                             lhNumAbonado,  
                             lhCodCliente,
                             lhNumCelular,  
                             lhCodPeriodo,  
                             szhCodTrafico, 
                             dhTotImpNeto,  
                             lhCodTipConce, 
                             dhImpConsumido,
                             szhFecVenc);    
                       
        /* Cargar los datos necesarios en la Lista de impresion */ 
        
        if(!iCelularCargado) {
            sprintf(pstActual->szNumServicio,"%ld",lhNumCelular);
            iCelularCargado = 1;
        }
       
        if(lhCodTipConce==1)
            pstActual->dFacturadoImpto = dhImpConsumido;    
            
        if(lhCodTipConce==4)
            pstActual->dTotFacturado   = dhImpConsumido + pstActual->dFacturadoImpto;                   

        if(!strcmp(szhCodTrafico,szCarrierLDN))        
            pstActual->dFacturadoLDN = dhTotImpNeto;

        if(!strcmp(szhCodTrafico,szCarrierLDI))
            pstActual->dFacturadoLDI = dhTotImpNeto;
        
        if(!iFecEmiCargada) {
            strcpy(pstActual->szFecFacturacion,pszFecEmi);
            iFecEmiCargada = 1;
        }
        
        if(!iFecVenCargada) {
            strcpy(pstActual->szFecVencimiento,szhFecVenc);
            iFecVenCargada = 1;
        }
        
        /* Antes de tomar el siguiente registro, guardar el abonado actual para despues comparar */
        lAboAnt = lhNumAbonado;
        
    }/*for(;;)*/
    
    /* Cierre del cursor */
    /* EXEC SQL CLOSE curRepCursor; */ 
#line 623 "./pc/FacRepCarrier.pc"

{
#line 623 "./pc/FacRepCarrier.pc"
    struct sqlexd sqlstm;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.sqlvsn = 10;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.arrsiz = 9;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.sqladtp = &sqladt;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.sqltdsp = &sqltds;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.iters = (unsigned int  )1;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.offset = (unsigned int  )155;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.cud = sqlcud0;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.sqlest = (unsigned char  *)&sqlca;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.sqlety = (unsigned short)256;
#line 623 "./pc/FacRepCarrier.pc"
    sqlstm.occurs = (unsigned int  )0;
#line 623 "./pc/FacRepCarrier.pc"
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
#line 623 "./pc/FacRepCarrier.pc"
}

#line 623 "./pc/FacRepCarrier.pc"

    if(SQLCODE!=SQLOK)
    {
        vDTrazasError(pszModulo,"En EXEC SQL CLOSE curRepCursor.\nCodigo:[%ld]\n[%s]\n",LOG01,sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        fprintf(stderr,"Error: En EXEC SQL CLOSE curRepCursor.\nCodigo:[%ld]\n[%s]\n",sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return -1;        
    }
    
    vDTrazasLog(pszModulo, " Se han procesado [%ld] registros mediante el FETCH\n\n",LOG05, sqlca.sqlerrd[2]);
    
    if(sqlca.sqlerrd[2]==0)
    {
        vDTrazasLog(pszModulo, " ATENCION: No se han recuperado registros\n\n",LOG05);        
    }
    
    /* Retornar los registros procesados */
    return sqlca.sqlerrd[2];            
    
}

/**
 * Funcion     : lfnImprimirReporte
 * Descripcion : Imprimir el reporte a Archivo de reportes.
 * Retorna     :  > 0       Cantidad de Abonados impresos en el reporte.
 *               -1         Se ha producido un error en la impresion del reporte.
 */
long lfnImprimirReporte(long lCodCiclFact, char *pszCarrier, char *pszDelim)
{
    TReporte *pstActual = NULL;
    char szPath[256] = "";
    char szArchivoRep[100] = "";
    char szRuta[512] = "";
    char szFormatoRep[512] = "";
    char szFormatoCab[512] = "";
    char *pathDir = NULL;
    char *pszModulo = "lfnImprimirReporte";
    
    FILE *fpRep=NULL;
    
    long lNumRegs=0;
    

    /* Creacion de la Ruta del archivo de impresion */
        
  	pathDir=(char *)malloc(512*sizeof(char));
	pathDir=szGetEnv("XPF_DAT");
    sprintf(szPath,"%s/carrier/reporte",pathDir);
	free(pathDir);

    sprintf(szArchivoRep,"Reporte_%ld_%s.rep", lCodCiclFact, pszCarrier);
    
	sprintf(szRuta,"%s/%s",szPath,szArchivoRep); /* facturacion/dat/carrier/reporte/muxxyyzz.rp */
    if((fpRep = fopen(szRuta,"w")) == (FILE*)NULL )
    {
		vDTrazasError(pszModulo,"No se pudo crear el archivo de Reporte %s\n",LOG01,szRuta);
		fprintf (stderr,"\n\t*Error: No se pudo crear el archivo de Reporte %s \n",szRuta);
        return -1;
    }
    fprintf(stdout,"\tArchivo de Impresion: %s\n",szRuta);
    
    /* Determinar si se debe insertar delimitador en el reporte */
    if(!strcmp(pszDelim,";"))
    {
        strcpy(szFormatoCab,"%s;%s;%s;%s;%s;%s;%s\n"); 
        strcpy(szFormatoRep,"%s;%f;%f;%f;%f;%s;%s\n");
    }
    else
    {
        strcpy(szFormatoCab,"%-16.16s|%-12.12s|%-12.12s|%-12.12s|%-12.12s|%-11.11s|%-11.11s\n");
        strcpy(szFormatoRep,"%16.16s|%12.2f|%12.2f|%12.2f|%12.2f|%11.11s|%11.11s\n");    
    }
    
    /* Enviar los datos al archivo de impresion. */
    
    fprintf(fpRep,szFormatoCab,"Numero de","Total","Facturado en","Facturado en","Facturacion de","Fecha de","Fecha de");
    fprintf(fpRep,szFormatoCab,"Servicio","Facturado","LDN","LDI","Impuestos","Facturacion","Vencimiento");
    
    /*fprintf(fpRep,"---------------------------------------------------------------------------------------------\n");*/

    pstActual = pstLista;
    while(pstActual!=NULL)
    {
         
        fprintf(fpRep,szFormatoRep,
                    pstActual->szNumServicio,
                    pstActual->dTotFacturado,        
                    pstActual->dFacturadoLDN,        
                    pstActual->dFacturadoLDI,        
                    pstActual->dFacturadoImpto,        
                    pstActual->szFecFacturacion,            
                    pstActual->szFecVencimiento);
        
        lNumRegs++;
        pstActual = pstActual->sgte;
    }        
    
    fclose(fpRep);
    
    return lNumRegs;
    
}  


/**
 * Funcion     : bfnLiberarReporte
 * Descripcion : Libera la memoria asignada al listado de Reporte.
 * Retorna     : TRUE       Se ha liberado la memoria con exito.
 */
BOOL bfnLiberarReporte(void)
{
    TReporte *pstActual=NULL;
    
    /* Mostrar los datos por pantalla */
    pstActual = pstLista;
    while(pstLista!=NULL) 
    {
        pstLista = pstActual->sgte;
        free(pstActual);
        pstActual = pstLista;    
    }
        
    return TRUE;
    
}

/**
 * Funcion     : bfnEsNumerico
 * Descripcion : Indica si una cadena es numerica.
 * Retorna     : TRUE       La cadena es numerica.
 *               FALSE      La cadena no es numerica.
 */
int ifnEsNumerico(char *pszCad)
{
    int iLargoCad=0;
    int i=0;
    
    iLargoCad = strlen(pszCad);
    if(iLargoCad<=0)
        return 0;
    
    for(i=0;i<iLargoCad;i++)
    {
      if(!isdigit(pszCad[i]))
        return 0;
    
    }

    return 1;
    
}
