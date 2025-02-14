
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

/* File name & Package Name */
struct sqlcxp
{
  unsigned short fillen;
           char  filnam[18];
};
static struct sqlcxp sqlfpn =
{
    17,
    "./pc/VisOnline.pc"
};


static unsigned long sqlctx = 6939843;


static struct sqlexd {
   unsigned int   sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   unused;
            short *cud;
   unsigned char  *sqlest;
            char  *stmt;
   unsigned char  **sqphsv;
   unsigned int   *sqphsl;
            short **sqpind;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned char  *sqhstv[6];
   unsigned int   sqhstl[6];
            short *sqindv[6];
   unsigned int   sqharm[6];
   unsigned int   *sqharc[6];
} sqlstm = {8,6};

/* Prototypes */
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

 static char *sq0002 = 
"select I.rowid  ,I.NUM_VENTA ,I.NUM_PROCESO ,I.COD_TIPMOVIMIEN ,I.COD_TIPDOC\
UM ,D.COD_TIPDOCUM  from FA_TIPDOCUMEN D ,FA_INTERFACT I where (((I.COD_MODGEN\
ER=:b0 and I.COD_ESTADOC=:b1) and I.COD_ESTPROC=:b2) and I.COD_TIPDOCUM=D.COD_\
TIPDOCUMMOV) order by I.NUM_PROCESO            ";
typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static short sqlcud0[] =
{8,4130,
2,0,0,1,126,0,4,472,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,3,0,0,
28,0,0,2,279,0,9,511,0,3,3,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,
54,0,0,2,0,0,13,549,0,6,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,
92,0,0,3,98,0,4,691,0,3,1,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,
118,0,0,4,67,0,5,719,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
140,0,0,5,60,0,5,731,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
162,0,0,6,69,0,5,744,0,1,1,0,1,0,1,3,0,0,
180,0,0,7,356,0,4,785,0,3,1,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,
206,0,0,8,67,0,5,821,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
228,0,0,9,60,0,5,833,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
250,0,0,10,94,0,5,874,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,
276,0,0,2,0,0,15,906,0,0,0,0,1,0,
290,0,0,11,166,0,5,976,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,
3,0,0,
};


/* *********************************************************************** */
/* *  Fichero : folonline.pc                                             * */
/* *  VisOnline ONLINE de Documentos                                     * */
/* *  Autor    : Roy Barrera R.											 * */
/* *  Complice : Mauricio Villagra V.                                    * */
/* *********************************************************************** */
#define _VISONLINE_PC_

#include "VisOnline.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/
/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986 by Oracle Corporation. */
 
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
         /* b4  */ long    sqlabc;
         /* b4  */ long    sqlcode;
         struct
           {
           /* ub2 */ unsigned short sqlerrml;
           /* ub1 */ char           sqlerrmc[70];
           } sqlerrm;
         /* ub1 */ char    sqlerrp[8];
         /* b4  */ long    sqlerrd[6];
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

long pid=0;
/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/
int main(int argc, char *argv[])
{
	char modulo[]="main";

	pid =getpid();
	
	fprintf( stdout, "\n\t******** VisOnline *********\n"
					 "\t**%s**\n\t**** pid : [ %8ld ] ****"
	                 "\n\t****************************\n", 
	         		 cfnGetTime(1),pid );


    memset(&stLineaComando,0,sizeof(VISONLINELINEACOMANDO));
    memset(&stStatus,'\0',sizeof(STATUS));

    if (!bfnValidaParametros(argc,argv,&stLineaComando)) return 1;


    if(!bfnConnectORA(stLineaComando.szOraAccount,stLineaComando.szOraPasswd))
    {
        vDTrazasError(modulo, "<< Usuario/Password Invalido >>", LOG01);
        return 2;
    }
    else
    {
        /*
        vDTrazasLog(modulo, "\n\t-------------------------------------------------------"
                			"\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                			"\n\t-------------------------------------------------------\n",
                			LOG03,stLineaComando.szOraAccount);
		*/
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))		return 3; 

    if (!bfnAbreArchivos(&stLineaComando,szSysDate)) 	return 4;
	
                        		
    if(!bfnVisOnlineOnline(&stLineaComando))
    {   
        vDTrazasError(modulo, " \n\t------------------------------------" 
                              " \n\tProceso Terminado de Forma Irregular" 
                              " \n\t------------------------------------"
                              ,LOG03);
        vDTrazasLog  (modulo, " \n\t------------------------------------" 
                              " \n\tProceso Terminado de Forma Irregular"
                              " \n\t------------------------------------"
                              ,LOG03);
        return 5;                                
    } 
    else
    {
        vDTrazasLog  (modulo, " \n\t------------------------------------" 
                              " \n\tProceso Terminado Correctamente" 
                              " \n\t------------------------------------"
                              ,LOG03);
                             
        vDTrazasError(modulo, " \n\t------------------------------------" 
                              " \n\tProceso Terminado Correctamente" 
                              " \n\t------------------------------------"
                              ,LOG03);
                             
        if (!bfnOraCommit())
        {

            vDTrazasLog  (modulo, " \n\t------------------------------------" 
                                  " \n\tFallo en el Commit"
                                  " \n\t------------------------------------"
                                  ,LOG03);
            vDTrazasError(modulo, " \n\t------------------------------------" 
                                  " \n\tFallo en el Commit"
                                  " \n\t------------------------------------"
                                  ,LOG03);
            return 6;
        }
    
    }

    if(!bfnDisconnectORA(0))
    {
    }
    else
    {
      vDTrazasLog  (modulo, "\n\t--------------------------------------------"
                            "\n\tDesconectado de  ORACLE"
                            "\n\t--------------------------------------------"
                            ,LOG03);
                            
      vDTrazasError(modulo, "\n\t--------------------------------------------"
                            "\n\tDesconectado de  ORACLE"
                            "\n\t--------------------------------------------"
                            ,LOG03);

	}

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    
	/*fprintf(stdout,"\n\tTermino de la foliacion Online \n\n");*/
    return 0;                                                          
    
} /* Main */


/* ************************************************************************* */
/* * Funcion bfnValidaParametros                                           * */
/* ************************************************************************* */
/* * Realiza la validacion de los Parametros de Entrada                    * */
/* ************************************************************************* */
BOOL bfnValidaParametros( int argc, char *argv[], VISONLINELINEACOMANDO *pstLineaCom )
{          
	        
	       char modulo[]="bfnValidaParametros";

	extern char *optarg;
	extern  int optind, opterr, optopt;

	       char opt[] = ":u:l:m:";
	        int iOpt=0;
	
  	       char *psztmp = "";

	        int Userflag=FALSE;
 	        int Logflag=FALSE;
 	        int MGenflag=FALSE;


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG03,modulo);

	opterr=0;

	if(argc == 1)
	{
		/*vDTrazasError (modulo,"\n\t<< Parametros Insuficientes >>\n%s\n",LOG01,szUsage);*/
		fprintf (stderr,"\n\t<< Error : Parametros insuficientes >>\n%s\n",szUsage);
		return FALSE;
	}

	while ( (iOpt = getopt(argc, argv, opt) ) != EOF)
	{
		switch(iOpt)
		{
			case 'u':
				if(Userflag==FALSE)
				{
	                strcpy(pstLineaCom->szUsuarioOra, optarg);                      
    	            Userflag=TRUE;
       	            vDTrazasLog (modulo, " -u %s ", LOG03, pstLineaCom->szUsuarioOra);
				}
				else
				{
					/*vDTrazasError (modulo,"\n\t<< Opcion '-%c' duplicada >>\n%s\n",LOG01,optopt,szUsage);*/
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return FALSE;
				}
				break;

			case 'l':
				if(Logflag==FALSE)
				{
                    stStatus.LogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=TRUE;
				}
				else
				{
					/* vDTrazasError (modulo,"\n\t<< Opcion '-%c' duplicada >>\n%s\n",LOG01,optopt,szUsage); */
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return FALSE;
				}
				break;

			case 'm':
				if(MGenflag==FALSE)
				{
	                strcpy(pstLineaCom->szCodModGener, optarg);                      
                    MGenflag=TRUE;
				}
				else
				{
					/*vDTrazasError (modulo,"\n\t<< Opcion '-%c' duplicada >>\n%s\n",LOG01,optopt,szUsage);*/
					fprintf (stderr,"\n\t<< Error : opcion '-%c' duplicada >>\n%s\n",optopt,szUsage);
					return FALSE;
				}
				break;

			case '?':
				/*vDTrazasError (modulo,"\n\t<< Opcion '-%c' es desconocida >>\n%s\n",LOG01,optopt,szUsage);*/
				fprintf (stderr,"\n\t<< Error : opcion '-%c' es desconocida >>\n%s\n",optopt,szUsage);
				return FALSE;
				break;

			case ':':
				/*vDTrazasError (modulo,"\n\t<< Falta parametro para opcion '-%c' >>\n%s\n",LOG01,optopt,szUsage);*/
				fprintf (stderr,"\n\t<< Error : Falta parametro para opcion '-%c' >>\n%s\n",optopt,szUsage);
				return FALSE;
				break;

		}

	} 


	if(Logflag==FALSE)
	{	
       stStatus.LogNivel = iLOGNIVEL_DEF ; /* asume nivel de log por defecto */
       vDTrazasLog ( modulo, "Log : -l %d (default)", LOG03, stStatus.LogNivel );
	}

    pstLineaCom->iNivLog=stStatus.LogNivel ;

	if(MGenflag==FALSE)
	{	
		/*vDTrazasError (modulo,"\n\t<< Falta definir opcion '-m' >>\n%s\n",LOG01,szUsage);*/
		fprintf (stderr,"\n\t<< Error : Falta definir opcion '-m' >>\n%s\n",szUsage);
		return FALSE;
	}

	if(Userflag==TRUE)
	{
        if ( (psztmp=(char *)strstr(pstLineaCom->szUsuarioOra,"/"))==(char *)NULL)
		{
			/*vDTrazasError (modulo,"\n\t<< Usuario Oracle no valido. Requiere '/' >>\n%s\n",LOG01,szUsage);*/
			fprintf (stderr,"\n\t<< Error : Usuario Oracle no valido. Requiere '/' >>\n%s\n",szUsage);
			return FALSE;
		}
		else
		{
            strncpy (pstLineaCom->szOraAccount,pstLineaCom->szUsuarioOra,psztmp-pstLineaCom->szUsuarioOra);
            strcpy  (pstLineaCom->szOraPasswd, psztmp+1)                 ;
		}
	}

    
	return TRUE;

} /* bfnValidaParamatros */


    
/* ************************************************************************* */
/* * Funcion bfnAbreArchivos                                               * */
/* ************************************************************************* */
/* * Realiza la apertura de archivos de Logs, Errores y Datos              * */
/* ************************************************************************* */
BOOL bfnAbreArchivos(VISONLINELINEACOMANDO *pstLineaCom, char *szDate)
{
 	char modulo[]="bfnAbreArchivos";
 	
    char    *szDirLogs               ;
    char    *szNomArchivo            ;
    char    szComando[1024] = ""     ;

    /*vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***", LOG03, modulo); */

    szDirLogs    = (char *)malloc(1024);
    szNomArchivo = (char *)malloc(128);
 

    if ((szDirLogs = szGetEnv("XPF_LOG")) == (char *)NULL) return FALSE;

   	sprintf (pstLineaCom->szDirLogs,"%s/VisOnline/%s",szDirLogs,cfnGetTime(2));
    sprintf (szComando, "/usr/bin/mkdir -p %s",pstLineaCom->szDirLogs );

   	fprintf (stdout, "\n\tCrea Directorio Log  : %s\n", pstLineaCom->szDirLogs);

    if (system (szComando))
    {
        vDTrazasError(modulo,"*** Fallo mkdir de Directorio Logs : %s",LOG01,szComando);
        return FALSE;
    }

	fprintf(stdout, "\n\tCrea Archivo Log/Err : VisOnline_%s_%s\n\n",pstLineaCom->szCodModGener, szDate );

    sprintf(szNomArchivo,"%s/VisOnline_%s_%s", 
    					pstLineaCom->szDirLogs, 
    					pstLineaCom->szCodModGener,
    					szDate);


    sprintf(stStatus.ErrName,"%s.err",szNomArchivo);
    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        vDTrazasError(modulo,"*** No puede abrirse el fichero de error %s",LOG01, stStatus.ErrName);
        return FALSE;
    }

    sprintf(stStatus.LogName, "%s.log",szNomArchivo);
    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        vDTrazasError(modulo,"*** No puede abrirse el fichero de log %s",LOG01, stStatus.LogName);
        fclose(stStatus.ErrFile);
        return FALSE;
    }
    
    
    vDTrazasError(modulo,"\n\n\t*************************************"
                         "\n\n\t****     Errores de VisOnline      **"
                         "\n\n\t*************************************"
                         ,LOG03);

    vDTrazasLog  (modulo,"\n\n\t*************************************"
                         "\n\n\t****        Log   VisOnline        **"
                         "\n\n\t*************************************"
                         ,LOG03);

    vDTrazasLog(modulo, "\n\t***  Parametro de Entrada VisOnline  ***"
                        "\n\t=> Usuario               [%s]"
                        "\n\t=> Password              [************]"
                        "\n\t=> Cod.ModGener          [%s]"
                        "\n\t=> Niv.Log               [%d]"
                        ,LOG05
                        ,pstLineaCom->szOraAccount
                        ,pstLineaCom->szCodModGener
                        ,pstLineaCom->iNivLog);

    return TRUE;
    
} /* bfnAbreArchivos */



/* ************************************************************************* */
/* * Funcion bfnVisOnlineOnline                                            * */
/* ************************************************************************* */
/* * Realiza la Visacion de los Tipos de Documentos                        * */
/* ************************************************************************* */
BOOL bfnVisOnlineOnline ( VISONLINELINEACOMANDO *pstLineaCom )
{
	char modulo[]="bfnVisOnlineOnline";
	
    char    szFecha [20]    =   ""  ;   /*  Fecha de Sistema Para Update de Traza   */
    long    lFolioUpdate    = 0     ;   /*  Folio Asignado para Update              */
    int     iSql            = 0     ;   /*  Retorno de Fetch de Documentos          */
    BOOL    bFinCursor = FALSE		;
    BOOL	bTerminoOK = TRUE		;
    int 	iCont = 0               ;
    int     iStatusFin = iESTAQUEUE_WAIT; /* Estado de la cola de procesos */
    char    *szStatusFin			;
    VISONLINEREGINTERFAZ stRegDocumVisacion;
    
    vDTrazasLog ( modulo, "\n\t*** Entrada en %s ***", LOG03, modulo); 

    memset(&stInterProc,0,sizeof(INTPROCESOS));
    stInterProc.lCodProceso = iPROCESO_INT_VISACION   ;
    if (!bfnGetInterProc(&stInterProc))  
    {
        vDTrazasError(modulo, " Al obtener valores de FA_INTPROCESOS " ,LOG01);
        vDTrazasLog  (modulo, " Al obtener valores de FA_INTPROCESOS " ,LOG01);
		return FALSE;        
    }
													/* IMPRESA */                    /* TERM_OK */
    if (!bfnOpenInterfaz(pstLineaCom->szCodModGener, stInterProc.iCodEstaDocEnt, iESTAPROC_TERMINADO_OK))
	{
        vDTrazasError(modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
        vDTrazasLog  (modulo, " Al abrir cursor sobre la interfaz " ,LOG01);
		return FALSE;
	}

    iCont=0;
    do
    {
		memset(&stRegDocumVisacion,0,sizeof(VISONLINEREGINTERFAZ));
    
		iSql=ifnFetchInterfaz(&stRegDocumVisacion);
    
		if(iSql !=SQLOK && iSql !=SQLNOTFOUND)
		{			
	        vDTrazasError(modulo, " Oracle Inesperado [%d] " ,LOG01,iSql);
	        vDTrazasLog  (modulo, " Oracle Inesperado [%d] " ,LOG01,iSql);
			return FALSE;
		}
			
        if(iSql == SQLNOTFOUND)
		{
			bFinCursor = TRUE;
            bTerminoOK = TRUE;
            iStatusFin = iESTAQUEUE_WAIT;
        }
		else
		{
			if(!bfnUpdateDocumento(&stRegDocumVisacion,stLineaComando.szOraAccount))
			{           
				bFinCursor = TRUE;
				bTerminoOK = FALSE;
	            iStatusFin = iESTAQUEUE_ERROR;
			}
			iCont++;                                                                                     
		}
	}while (!bFinCursor);

    vDTrazasLog  (modulo, "\tTotal de Registros Verificados : %d ", LOG03, iCont);

    if(!bfnCloseInterfaz())
    {
       vDTrazasLog  (modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       vDTrazasError(modulo, "Al cerrar el Cursor Cur_Interfaz : %s", LOG01, SQLERRM);
       /*return FALSE;*/
    }

	
	if (!bfnCambiaEstCola(pstLineaCom->szCodModGener, iPROCESO_INT_VISACION, "O", iESTAQUEUE_RUNNING, iStatusFin))
	{	
		if (!fnOraRollBack())                         
	    	vDTrazasError(modulo,"En Rollback \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
	    return FALSE;
	}
	else	
	{	if (!fnOraCommit())
		{	vDTrazasError(modulo,"En Commit \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			if (!fnOraRollBack())                         
	    		vDTrazasError(modulo,"En Rollback \n\t%s\n", LOG01, sqlca.sqlerrm.sqlerrmc);
			return FALSE;	
		}
	}
	
	szStatusFin = (bTerminoOK==TRUE)? "TRUE":(bTerminoOK==FALSE)?"FALSE":"???";
    vDTrazasLog  (modulo, "Terminando VisOnline Online con '%s'", LOG05,szStatusFin );
	
	return bTerminoOK;

}/* bfnVisOnlineOnline */



/* ************************************************************************* */
/* * Funcion bfnOpenInterfaz                                               * */
/* ************************************************************************* */
/* * Crea y Abre un Cursor sobre los documentos a Foliar de FA_INTERFACT   * */
/* ************************************************************************* */
BOOL bfnOpenInterfaz(char *szCodModGener,int iCodEstaDocEnt, int iCodEstProc)
{                          
    char modulo[]="bfnOpenInterfaz";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	char szhCodModGener[4]="";
    	 int ihCodEstaDocEnt=0;
    	 int ihCodEstProc=0;
    	 int ihCodProceso=0;
    	 
 	     int ihNumDeltaHoras;

    /* EXEC SQL END DECLARE SECTION; */ 

    
    ihCodProceso=iPROCESO_INT_VISACION;
    
    strcpy(szhCodModGener,szCodModGener);
   	ihCodEstaDocEnt=iCodEstaDocEnt;
   	ihCodEstProc=iCodEstProc;
    
    vDTrazasLog (modulo,"\n\t*** Entrada en %s ***" ,LOG03,modulo);

   vDTrazasLog(modulo,"%s [%ld] Preparando Cursor sobre FA_INTERFACT (DELTAHORAS) ", LOG03, cfnGetTime(1),pid);
	
	/* EXEC SQL SELECT NVL(NUM_DELTAHORAS,0)
	           INTO ihNumDeltaHoras
	           FROM FA_INTQUEUEPROC
   			  WHERE COD_MODGENER = :szhCodModGener	 /o 'xxx' o/
			    AND COD_PROCESO  = :ihCodProceso	 /o  400  o/ 
			   	AND COD_TIPPROC  = 'O' ; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 3;
 sqlstm.stmt = "select NVL(NUM_DELTAHORAS,0) into :b0  from FA_INTQUEUEPROC \
where ((COD_MODGENER=:b1 and COD_PROCESO=:b2) and COD_TIPPROC='O')";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )2;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihNumDeltaHoras;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodModGener;
 sqlstm.sqhstl[1] = (unsigned int  )4;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodProceso;
 sqlstm.sqhstl[2] = (unsigned int  )4;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

			 /*  'O'  */

	if (SQLCODE)
	{	vDTrazasError(modulo,"En select de FA_INTQUEUEPROC con COD_MODGENER:%s; COD_PROCESO:%d; COD_TIPPROC:'O' \n\t%s\n",
	                  LOG01,szhCodModGener,ihCodProceso,sqlca.sqlerrm.sqlerrmc);
		vDTrazasLog  (modulo,"En select de FA_INTQUEUEPROC con COD_MODGENER:%s; COD_PROCESO:%d; COD_TIPPROC:'O' \n\t%s\n",
	                  LOG01,szhCodModGener,ihCodProceso,sqlca.sqlerrm.sqlerrmc);
			return FALSE;	}
	
	vDTrazasLog(modulo,"%s [%ld] Preparando Cursor sobre FA_INTERFACT ", LOG03, cfnGetTime(1),pid);
	/* EXEC SQL DECLARE  Cur_Interfaz  CURSOR FOR
            SELECT  I.ROWID             ,
                    I.NUM_VENTA         ,
                    I.NUM_PROCESO       ,
                    I.COD_TIPMOVIMIEN   ,   /o Tipo de Movimiento de Factruracion   o/
			        I.COD_TIPDOCUM      ,   /o Tipo de Documento de Facturacion     o/
			        D.COD_TIPDOCUM          /o Tipo de Documento de Almacen         o/
            FROM    FA_TIPDOCUMEN   D   ,
                    FA_INTERFACT    I
			WHERE   I.COD_MODGENER = :szhCodModGener    /o Modo de Generacion   o/
			AND     I.COD_ESTADOC  = :ihCodEstaDocEnt   /o Foliada              o/
			AND     I.COD_ESTPROC  = :ihCodEstProc      /o ok                   o/
			AND     I.COD_TIPDOCUM = D.COD_TIPDOCUMMOV
			ORDER BY I.NUM_PROCESO; */ 


    if (SQLCODE)
    {
        vDTrazasLog  (modulo , "\n\t** En SQL-DECLARE Cur_Interfaz **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo , "\n\t**  En SQL-DECLARE Cur_Interfaz **"
                               "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    /* EXEC SQL OPEN Cur_Interfaz ; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 3;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )28;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodModGener;
    sqlstm.sqhstl[0] = (unsigned int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodEstaDocEnt;
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstProc;
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if (SQLCODE)
    {
        vDTrazasLog  (modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"**  En SQL-OPEN CURSOR Cur_Interfaz **"
                             "\n\t\t=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }
    
    return TRUE;
    
    
}/* bfnOpenInterfaz */
  

  
/* ************************************************************************* */
/* * Funcion ifnFetchInterfaz                                             * */
/* ************************************************************************* */
/* * Lee Un Registro de los documentos a Foliar                            * */
/* ************************************************************************* */
int ifnFetchInterfaz(VISONLINEREGINTERFAZ *pstRegDocumVis)    
{
	char modulo[]="ifnFetchInterfaz";
	
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhRowid[20]    ; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

    long    lhNumVenta      ;
    long    lhNumProceso    ;
    int     ihCodTipMovimien;
    int     ihCodTipDocum   ;
    int     ihCodTipDocumAl ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***",LOG03,modulo);

    /* EXEC SQL FETCH Cur_Interfaz INTO
    			   :szhRowid        ,
    			   :lhNumVenta      ,
    			   :lhNumProceso    , 
    			   :ihCodTipMovimien,
    			   :ihCodTipDocum   ,
    			   :ihCodTipDocumAl ; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 6;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )54;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[0] = (unsigned int  )20;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipMovimien;
    sqlstm.sqhstl[3] = (unsigned int  )4;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqharm[3] = (unsigned int  )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[4] = (unsigned int  )4;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqharm[4] = (unsigned int  )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipDocumAl;
    sqlstm.sqhstl[5] = (unsigned int  )4;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqharm[5] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
        vDTrazasError(modulo,  "En FETCH sobre CURSOR Cur_Interfaz [%s]",LOG01,SQLERRM);
        return SQLCODE ;
    }
    
    if( SQLCODE == SQLNOTFOUND )
    {   
        vDTrazasLog  (modulo, " No Existen Mas Documentos en CURSOR Cur_Interfaz ",LOG02);
        return SQLCODE ;
    }
    else
    {
    	strcpy(pstRegDocumVis->szRowid,szhRowid);
    	pstRegDocumVis->lNumVenta       = lhNumVenta        ; 
    	pstRegDocumVis->lNumProceso     = lhNumProceso      ; 
    	pstRegDocumVis->iCodTipMovimien = ihCodTipMovimien  ;
        pstRegDocumVis->iCodTipDocum    = ihCodTipDocum     ;
        pstRegDocumVis->iCodTipDocumAlma= ihCodTipDocumAl   ; 
    }
    return SQLCODE ;
} /* ifnFetchInterfaz */


/* ************************************************************************* */
/* * Funcion bfnUpdateDocumento                                               * */
/* ************************************************************************* */
/* * Modifica el Folio de un Documento                                     * */
/* ************************************************************************* */
BOOL bfnUpdateDocumento(VISONLINEREGINTERFAZ *pstRegDocumVis,char *szOraUser)
{
	char modulo[]="bfnUpdateDocumento";
	
    vDTrazasLog (modulo ,"\n\t*** Entrada en %s ***",LOG03,modulo);
    vDTrazasLog (modulo ,"\t\t\t***=> Numero de Proceso      [%ld]***\n"
                         "\t\t\t***=> Numero de Venta        [%ld]***\n"
                         "\t\t\t***=> Tipo Movimiento        [%d]***\n"
                         "\t\t\t***=> Tipo Documento Fact.   [%d]***\n"
                         "\t\t\t***=> Tipo Documento Alma.   [%d]***"
                        ,LOG03
                        ,pstRegDocumVis->lNumProceso
                        ,pstRegDocumVis->lNumVenta
                        ,pstRegDocumVis->iCodTipMovimien
                        ,pstRegDocumVis->iCodTipDocum   
                        ,pstRegDocumVis->iCodTipDocumAlma );
    
    switch (pstRegDocumVis->iCodTipMovimien)
    {
        case iTIPMOV_VENTA          :
            switch (pstRegDocumVis->iCodTipDocumAlma)
            {
                case    iCODTIPDOCALMAC_CONSIGNACION    :
                    if (!bfnValEstadoVenta(pstRegDocumVis))
                        return (FALSE);
                    vDTrazasLog (modulo ,"\t\t\t***=> Valore de Salida de bfnValEstadoVenta ***\n"
                                         "\t\t\t***=> Estado de Visacion [%d]***"
                                        ,LOG03,pstRegDocumVis->iIndVisacion);

                    break;

                default :
                    pstRegDocumVis->iIndVisacion = IND_VISACION_OK;
                    break;
            }
            break;
        case iTIPMOV_NOTACREDITO    :
            switch (pstRegDocumVis->iCodTipDocumAlma)
            {
                case    iCODTIPDOCALMAC_NOTCREDCONSIG   :
                    if (!bfnValNotaCredConsig(pstRegDocumVis))
                        return (FALSE);
                    vDTrazasLog (modulo ,"\t\t\t***=> Valore de Salida de bfnValNotaCredConsig ***\n"
                                         "\t\t\t***=> Estado de Visacion [%d]***"
                                        ,LOG03,pstRegDocumVis->iIndVisacion);
                    break;

                default     :
                    pstRegDocumVis->iIndVisacion = IND_VISACION_OK;
                    break;
            }
            break;
        default     :
            pstRegDocumVis->iIndVisacion = IND_VISACION_OK;
            break;
    }
    /********************************************************************************/
    /* * Realiza la Visacion del Registro de la interfaz                            */
    /********************************************************************************/
    vDTrazasLog (modulo ,"\t\t\t***=> Valore de Para Marcar Interfaz ***\n"
                         "\t\t\t***=> Estado de Visacion [%d]***"
                        ,LOG03,pstRegDocumVis->iIndVisacion);

    if (pstRegDocumVis->iIndVisacion == IND_VISACION_OK)
    {
        if (!bfnUpdateInterfaz(stInterProc.iCodEstaDocSal, iESTAPROC_TERMINADO_OK, pstRegDocumVis->szRowid))
        {	
            vDTrazasLog  ( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
        	vDTrazasError( modulo, " Al marcar registro como 'terminado ok' ",LOG01);
        	fnOraRollBack();
        	return (FALSE);   
        }
        if (!bfnOraCommit())
        {
            vDTrazasLog  ( modulo, " Al hacer Commit ",LOG01);
            vDTrazasError( modulo, " Al hacer Commit ",LOG01);
            fnOraRollBack();   
        }
	}
    return TRUE;
}/* bfnUpdateDocumento */


/* ************************************************************************* */
/* * Funcion bfnValEstadoVenta              			                   * */
/* ************************************************************************* */
/* * Valida Estado de la Venta Para documento en Consignacion              * */
/* ************************************************************************* */
BOOL bfnValEstadoVenta(VISONLINEREGINTERFAZ *pstRegDocumVis)
{
    char modulo[]="bfnValEstadoVenta";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumVenta          ;
        char    szhIndEstaVenta [3] ; /* EXEC SQL VAR szhIndEstaVenta IS STRING(3); */ 

        int     ihIndIntercalacion  ;
        long    lhNumFolio          ;
        long    lhNumProceso        ;
    /* EXEC SQL END DECLARE SECTION    ; */ 

    
    lhNumVenta   = pstRegDocumVis->lNumVenta          ;
    lhNumProceso = pstRegDocumVis->lNumProceso        ;
/*    pstRegDocumVis->iIndVisacion = IND_VISACION_OK  ; aeo 27/sep/2000 */
    pstRegDocumVis->iIndVisacion = IND_VISACION_NOT;
    /* EXEC SQL 
        SELECT  IND_ESTVENTA,NVL(NUM_FOLDEALER,0)
        INTO    :szhIndEstaVenta,:lhNumFolio
        FROM    GA_PRELIQUIDACION
        WHERE   NUM_VENTA   = :lhNumVenta; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 6;
    sqlstm.stmt = "select IND_ESTVENTA ,NVL(NUM_FOLDEALER,0) into :b0,:b1  f\
rom GA_PRELIQUIDACION where NUM_VENTA=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )92;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstaVenta;
    sqlstm.sqhstl[0] = (unsigned int  )3;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE !=SQLOK && SQLCODE !=SQLNOTFOUND)
    {
        vDTrazasLog  (modulo," En SQL-SELECT GA_PRELIQUIDACION "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-SELECT GA_PRELIQUIDACION "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        if ((strcmp(szhIndEstaVenta, COD_ESTAVENTA_VENTAPENDIENTE)     != 0) && 
            (strcmp(szhIndEstaVenta, COD_ESTVENTA_PENDIENTEDOCUMENTAR) != 0) &&
            (lhNumFolio>0) )
            /*pstRegDocumVis->iIndVisacion = IND_VISACION_NOT; aeo 27/sep/2000 */
            pstRegDocumVis->iIndVisacion = IND_VISACION_OK  ;
    }  
    vDTrazasLog  (modulo,"\t\tGA_PRELIQUIDACION.IND_ESTVENTA [%s]"
                        "\n\t\tpstRegDocumVis->iIndVisacion [%d]"
                        "\n\t\tSQLCODE   [%d]"
                    ,LOG03,szhIndEstaVenta,pstRegDocumVis->iIndVisacion,SQLCODE);
                    
   if (pstRegDocumVis->iIndVisacion == IND_VISACION_OK){
        /* EXEC SQL 
        UPDATE FA_FACTDOCU_NOCICLO  
        SET NUM_FOLIO = :lhNumFolio
        WHERE NUM_PROCESO=:lhNumProceso; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 6;
        sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0 where N\
UM_PROCESO=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )118;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE !=SQLOK)
        {
            vDTrazasLog  (modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (FALSE);
        }
        /* EXEC SQL 
        UPDATE FA_INTERFACT  
        SET NUM_FOLIO = :lhNumFolio
        WHERE NUM_PROCESO=:lhNumProceso; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 6;
        sqlstm.stmt = "update FA_INTERFACT  set NUM_FOLIO=:b0 where NUM_PROC\
ESO=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )140;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE !=SQLOK)
        {
            vDTrazasLog  (modulo," En SQL-UPDATE FA_INTERFACT "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo," En SQL-UPDATE FA_INTERFACT "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (FALSE);
        }
    
       /* EXEC SQL 
       UPDATE GA_PRELIQUIDACION 
       SET IND_INTERCALACION=1
       WHERE NUM_VENTA=:lhNumVenta; */ 

{
       struct sqlexd sqlstm;

       sqlstm.sqlvsn = 8;
       sqlstm.arrsiz = 6;
       sqlstm.stmt = "update GA_PRELIQUIDACION  set IND_INTERCALACION=1 wher\
e NUM_VENTA=:b0";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )162;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
       sqlstm.sqhstl[0] = (unsigned int  )4;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqharm[0] = (unsigned int  )0;
       sqlstm.sqphsv = sqlstm.sqhstv;
       sqlstm.sqphsl = sqlstm.sqhstl;
       sqlstm.sqpind = sqlstm.sqindv;
       sqlstm.sqparm = sqlstm.sqharm;
       sqlstm.sqparc = sqlstm.sqharc;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE !=SQLOK)
        {
            vDTrazasLog  (modulo," En SQL-UPDATE GA_PRELIQUIDACION "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo," En SQL-UPDATE GA_PRELIQUIDACION "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (FALSE);
        }
    }
    return (TRUE);
}





/* ************************************************************************* */
/* * Funcion bfnValNotaCredConsig             			                   * */
/* ************************************************************************* */
/* * Valida Estado de la Nota de Credito en Consignacion                   * */
/* ************************************************************************* */
BOOL bfnValNotaCredConsig(VISONLINEREGINTERFAZ *pstRegDocumVis)
{
    char modulo[]="bfnValNotaCredConsig";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long    lhNumVenta          ;
        char    szhIndEstaVenta [3] ; /* EXEC SQL VAR szhIndEstaVenta IS STRING(3); */ 

        int     ihIndIntercalacion  ;
        long    lhNumFolio          ;
        long    lhNumProceso        ;
    /* EXEC SQL END DECLARE SECTION    ; */ 

    
    lhNumVenta   = pstRegDocumVis->lNumVenta          ;
    lhNumProceso = pstRegDocumVis->lNumProceso        ;
    pstRegDocumVis->iIndVisacion = IND_VISACION_NOT   ;
    
    /* EXEC SQL 
        SELECT  A.IND_ESTVENTA      ,
                A.NOTA_CREDITO
        INTO    :szhIndEstaVenta    ,
                :lhNumFolio
        FROM    GA_PRELIQUIDACION   A,
                FA_HISTDOCU         H,
                FA_FACTDOCU_NOCICLO D
        WHERE   D.NUM_PROCESO           = :lhNumProceso
        AND     H.NUM_SECUENCI          = D.NUM_SECUREL
        AND     H.COD_TIPDOCUM          = D.COD_TIPDOCUMREL
        AND     H.COD_VENDEDOR_AGENTE   = D.COD_VENDEDOR_AGENTEREL
        AND     H.LETRA                 = D.LETRAREL
        AND     H.COD_CENTREMI          = D.COD_CENTREMI
        AND     H.NUM_VENTA             = A.NUM_VENTA; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 6;
    sqlstm.stmt = "select A.IND_ESTVENTA ,A.NOTA_CREDITO into :b0,:b1  from \
GA_PRELIQUIDACION A ,FA_HISTDOCU H ,FA_FACTDOCU_NOCICLO D where ((((((D.NUM_PR\
OCESO=:b2 and H.NUM_SECUENCI=D.NUM_SECUREL) and H.COD_TIPDOCUM=D.COD_TIPDOCUMR\
EL) and H.COD_VENDEDOR_AGENTE=D.COD_VENDEDOR_AGENTEREL) and H.LETRA=D.LETRAREL\
) and H.COD_CENTREMI=D.COD_CENTREMI) and H.NUM_VENTA=A.NUM_VENTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )180;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhIndEstaVenta;
    sqlstm.sqhstl[0] = (unsigned int  )3;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[2] = (unsigned int  )4;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE !=SQLOK && SQLCODE !=SQLNOTFOUND)
    {
        vDTrazasLog  (modulo," En SQL-SELECT GA_PRELIQUIDACION "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-SELECT GA_PRELIQUIDACION "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    if (SQLCODE == SQLOK)
    {
        if ((strcmp(szhIndEstaVenta, COD_ESTVENTA_RECHAZADA)     == 0) && 
            (lhNumFolio>0) )
            pstRegDocumVis->iIndVisacion = IND_VISACION_OK  ;
    }  
    vDTrazasLog  (modulo,"\t\tGA_PRELIQUIDACION.IND_ESTVENTA [%s]"
                        "\n\t\tpstRegDocumVis->iIndVisacion [%d]"
                        "\n\t\tSQLCODE   [%d]"
                    ,LOG03,szhIndEstaVenta,pstRegDocumVis->iIndVisacion,SQLCODE);
                    
   if (pstRegDocumVis->iIndVisacion == IND_VISACION_OK){
        /* EXEC SQL 
        UPDATE FA_FACTDOCU_NOCICLO  
        SET NUM_FOLIO = :lhNumFolio
        WHERE NUM_PROCESO=:lhNumProceso; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 6;
        sqlstm.stmt = "update FA_FACTDOCU_NOCICLO  set NUM_FOLIO=:b0 where N\
UM_PROCESO=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )206;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE !=SQLOK)
        {
            vDTrazasLog  (modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo," En SQL-UPDATE FA_FACTDOCU_NOCICLO "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (FALSE);
        }
        /* EXEC SQL 
        UPDATE FA_INTERFACT  
        SET NUM_FOLIO = :lhNumFolio
        WHERE NUM_PROCESO=:lhNumProceso; */ 

{
        struct sqlexd sqlstm;

        sqlstm.sqlvsn = 8;
        sqlstm.arrsiz = 6;
        sqlstm.stmt = "update FA_INTERFACT  set NUM_FOLIO=:b0 where NUM_PROC\
ESO=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )228;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[0] = (unsigned int  )4;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqharm[0] = (unsigned int  )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
        sqlstm.sqhstl[1] = (unsigned int  )4;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqharm[1] = (unsigned int  )0;
        sqlstm.sqphsv = sqlstm.sqhstv;
        sqlstm.sqphsl = sqlstm.sqhstl;
        sqlstm.sqpind = sqlstm.sqindv;
        sqlstm.sqparm = sqlstm.sqharm;
        sqlstm.sqparc = sqlstm.sqharc;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        if(SQLCODE !=SQLOK)
        {
            vDTrazasLog  (modulo," En SQL-UPDATE FA_INTERFACT "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(modulo," En SQL-UPDATE FA_INTERFACT "
                                    "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (FALSE);
        }
    }
    return (TRUE);
}





/* ************************************************************************* */
/* * Funcion bfnUpdateInterfaz              			                   * */
/* ************************************************************************* */
/* * Modifica el Folio de un Documento en la Interfaz                      * */
/* ************************************************************************* */
BOOL bfnUpdateInterfaz(long lEstaDoc, long lEstProc, char *szRowid)
{
    char modulo[]="bfnUpdateInterfaz";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

   			long lhEstaDoc  ;
   			long lhEstProc  ;
   			char szhRowid[20]; /* EXEC SQL VAR szhRowid IS STRING(20); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
	lhEstaDoc = lEstaDoc  ;
	lhEstProc = lEstProc  ;
	strcpy(szhRowid,szRowid);
        
    vDTrazasLog (modulo , "\n\t*** Entrada en %s ***", LOG03, modulo);

    /* EXEC SQL UPDATE FA_INTERFACT
		        SET COD_ESTADOC = :lhEstaDoc,      /o Foliada o/
		        	COD_ESTPROC = :lhEstProc,      /o Procesando OK o Error  o/
		        	FEC_VISACION= SYSDATE
		      WHERE ROWID = :szhRowid; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 6;
    sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0,COD_ESTPROC=:b1,\
FEC_VISACION=sysdate  where ROWID=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )250;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhEstaDoc;
    sqlstm.sqhstl[0] = (unsigned int  )4;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqharm[0] = (unsigned int  )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhEstProc;
    sqlstm.sqhstl[1] = (unsigned int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqharm[1] = (unsigned int  )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
    sqlstm.sqhstl[2] = (unsigned int  )20;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqharm[2] = (unsigned int  )0;
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		
    if (SQLCODE)
    {
        vDTrazasLog  (modulo," En SQL-UPDATE "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," En SQL-UPDATE "
                                "\n\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  FALSE;
    }
    
    return TRUE;
    
}/* bfnUpdateInterfaz */




/* ************************************************************************* */
/* * Funcion bfnCloseInterfaz                                              * */
/* ************************************************************************* */
/* * Cierra el Cursor de documentos a Foliar                               * */
/* ************************************************************************* */
BOOL bfnCloseInterfaz()
{
	char modulo[]="bfnCloseInterfaz";
    vDTrazasLog  (modulo, "\n\t** Entrada en %s",LOG03,modulo);
    
    /* EXEC SQL CLOSE Cur_Interfaz; */ 

{
    struct sqlexd sqlstm;

    sqlstm.sqlvsn = 8;
    sqlstm.arrsiz = 6;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )276;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if (SQLCODE != SQLOK)
        return FALSE;
        
    return TRUE;        
}


/* ******************************************************************************** */
/* cfnGetTime : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora) */
/* ******************************************************************************** */
char *cfnGetTime(int fmto)
{
	char modulo[]="cfnGetTime";

	static time_t timer;
	static size_t nbytes;
	static char szTime[26]="";

	memset(szTime,'\0',26);
	timer = time((time_t *)0);

	switch (fmto)
	{
		case 1 :
				nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		case 2 :
				nbytes = strftime(szTime, 26, "%Y%m%d", (struct tm *)localtime(&timer));	
				break;
		case 3 :
				nbytes = strftime(szTime, 26, "[%H:%M:%S]", (struct tm *)localtime(&timer));	
				break;
		default :
				nbytes = strftime(szTime, 26, "%d/%m/%Y", (struct tm *)localtime(&timer));	
				break;
	}
	
	return szTime;

}


/* ******************************************************************************** */
/* cfnGetTime : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora) */
/* ******************************************************************************** */

BOOL bfnCambiaEstCola(char *MGener, int CProc, char *TProc, int iDesde, int iHasta)
{
	char modulo[]="bfnCambiaEstCola";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhModGen[4];
		char szhTipPro[2];
		int  ihCodPro;
		int  ihEstIni;
		int  ihEstFin;
	   long  lhPidProc;
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhModGen,MGener);
	strcpy(szhTipPro,TProc);
	ihCodPro = CProc;
	ihEstIni = iDesde;
	ihEstFin = iHasta;
	lhPidProc = pid;
	
	vDTrazasLog(modulo,"%s [%ld] Cambiando estado cola [%d] -> [%d]", LOG03, cfnGetTime(1),pid, iDesde, iHasta);
	
	/* EXEC SQL UPDATE FA_INTQUEUEPROC
				SET COD_ESTADO = :ihEstFin, 
					FEC_ESTADO = SYSDATE,
					PID_PROCESO = :lhPidProc
			  WHERE COD_MODGENER = :szhModGen
			    AND COD_PROCESO = :ihCodPro
			   	AND COD_TIPPROC = :szhTipPro
			   	AND COD_ESTADO = :ihEstIni; */ 

{
 struct sqlexd sqlstm;

 sqlstm.sqlvsn = 8;
 sqlstm.arrsiz = 6;
 sqlstm.stmt = "update FA_INTQUEUEPROC  set COD_ESTADO=:b0,FEC_ESTADO=sysdat\
e ,PID_PROCESO=:b1 where (((COD_MODGENER=:b2 and COD_PROCESO=:b3) and COD_TIPP\
ROC=:b4) and COD_ESTADO=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )290;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihEstFin;
 sqlstm.sqhstl[0] = (unsigned int  )4;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqharm[0] = (unsigned int  )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhPidProc;
 sqlstm.sqhstl[1] = (unsigned int  )4;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqharm[1] = (unsigned int  )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhModGen;
 sqlstm.sqhstl[2] = (unsigned int  )4;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqharm[2] = (unsigned int  )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodPro;
 sqlstm.sqhstl[3] = (unsigned int  )4;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqharm[3] = (unsigned int  )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhTipPro;
 sqlstm.sqhstl[4] = (unsigned int  )2;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqharm[4] = (unsigned int  )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihEstIni;
 sqlstm.sqhstl[5] = (unsigned int  )4;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqharm[5] = (unsigned int  )0;
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (sqlca.sqlcode)
	{	vDTrazasError(modulo,"Al cambiar estado cola [%d] -> [%d]\n\t%s\n", 
	                          LOG01, iDesde, iHasta,sqlca.sqlerrm.sqlerrmc);
	                          
		vDTrazasError(modulo,"%s [%ld] CMG[%s],Cod.Proc[%d], Tip.Proc[%s], IDesde[%d],IHasta[%d]", 
							  LOG03, cfnGetTime(1),pid, 
	                          MGener, CProc, TProc, iDesde, iHasta);
	    return FALSE;	}

	return TRUE;
	
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

