
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/CambioDespacho.pc"
};


static unsigned int sqlctx = 220347955;


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
   unsigned char  *sqhstv[12];
   unsigned long  sqhstl[12];
            int   sqhsts[12];
            short *sqindv[12];
            int   sqinds[12];
   unsigned long  sqharm[12];
   unsigned long  *sqharc[12];
   unsigned short  sqadto[12];
   unsigned short  sqtdso[12];
} sqlstm = {12,12};

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
{12,4130,2,0,0,
5,0,0,1,260,0,6,473,0,0,12,12,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
1,97,0,0,1,3,0,0,1,97,0,0,1,97,0,0,2,3,0,0,2,97,0,0,2,3,0,0,
68,0,0,2,44,0,4,641,0,0,3,2,0,1,0,1,97,0,0,1,97,0,0,2,97,0,0,
};


/* *********************************************************************** */
/* *  Fichero : CargaDesoacho.pc                                         * */
/* *  Carga Masiva de Despachos                                          * */
/* *  Autor : Jaime Espinoza Matamala                                    * */
/* *  Modif : 28-08-2008                                                 * */
/* *********************************************************************** */

#include <GenFA.h>
#include "CambioDespacho.h"

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




/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/
int main(int argc, char *argv[])
{
    char modulo[]="main";
    char *szUserid_Aux;

    extern  char *optarg             ;
    char    opt[]=":u:a:l:" ;
    int     iOpt =0                  ;
    BOOL    bUserpass    = FALSE      ;
    BOOL    bNomArchivo  = FALSE      ;
    BOOL    bRetorno     = TRUE       ;
    int     sts;
    char    szHelpString[1024] = " " ;
    
    memset(&stLineaComando,0    ,sizeof(LINEACOMANDOCARGADES));

    fprintf(stdout, "\n\tCambiodespachos, Fecha de compilacion: [%s]-[%s]\n",__DATE__, __TIME__);

    sprintf(szHelpString," Argumentos de entrada de proceso Cambiodespacho : "
                         "\n  -u Usuario/Password"
                         "\n  -a NomArchivo"
                         "\n  -l Nivel de Log\n");

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
            case 'u':
                    strcpy(stLineaComando.szUsuario, optarg);
                    if((szUserid_Aux=(char *)strstr(stLineaComando.szUsuario,"/")) == (char *)NULL)
                    {
                        fprintf(stderr, "\nUsuario Oracle no es valido\n");
                        return(1);
                    }
                    else
                    {
                        strncpy(stLineaComando.szUser,stLineaComando.szUsuario, szUserid_Aux-stLineaComando.szUsuario);
                        strcpy(stLineaComando.szPass, szUserid_Aux+1);
                        bUserpass = TRUE;
                    }
                    break;
            case 'a':
                    if (strlen (optarg))
                    {
                        strcpy(stLineaComando.szNomArchivo,optarg);
                        bNomArchivo = TRUE;
                    }
                    break;
            case 'l':
                    if (strlen (optarg) )
                    {
                        stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    }
                    break;
            case '?':
                    fprintf(stderr,"\n<< ERROR (main): Se ha ingresado parametro desconocido: -%c >>\n%s\n",optopt,szHelpString);
                    return -1;
            case ':':
                    if ( optopt == 'u' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para usuario/password o \"/\" >>\n%s\n",szHelpString);
                        return -1;
                    }
                    if ( optopt == 'a' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para Nombre de Archivo. >>\n%s\n",szHelpString);
                        return -1;
                    }
                    if ( optopt == 'l' ) {
                        fprintf(stderr,"\n<< ERROR (main): Falta parametro para Nivel de Log. >>\n%s\n",szHelpString);
                        return -1;
                    }
            default:
                    fprintf (stdout,"\n %s ", szHelpString)     ;
                    return -1;

        }/*End Switch */

    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */
	
	if (!bUserpass || !bNomArchivo)
	{
		fprintf (stdout,"\n Faltan %s ", szHelpString)     ;
        return -1;
	}
		
    
    if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF     ;

    stLineaComando.iNivLog = stStatus.LogNivel;

    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'<usuario> <passwd> '\n");
        return (2);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------\n",
                stLineaComando.szUser);
    }

    /**************************************************************************************/
    /* Crear archivos y directorios de log y errores */

    sts = ifnAbreArchivosLog();
    if ( sts != 0 ) return sts;

    /*********************************************************************************************/

    vDTrazasLog  ( modulo ,"\n\n\t*************************************"
                           "\n\n\t****        Log   Cambiodespacho    **"
                           "\n\n\t*************************************"
                           ,LOG03);

    vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada Cambiodespacho ***"
                           "\n\t\t=> Usuario               [%s]"
                           "\n\t\t=> Nombre Archivo        [%s]"
                           "\n\t\t=> Niv.Log               [%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.szNomArchivo
                           ,stLineaComando.iNivLog);

    /************************************************************************************/
    /*          Proceso Principal                       */
    /************************************************************************************/

    vDTrazasError( modulo ," \n\t------------------------------------"
                           " \n\t   Inicio Proceso Cambiodespacho    "
                           " \n\t------------------------------------"
                           ,LOG03);
    
    vDTrazasLog  ( modulo ,"\n\t\t***  Inicio Proceso principal  ***"
                           ,LOG03);

    if (!bCambiodespacho(stLineaComando.szNomArchivo))
    {
    	vDTrazasLog  ( modulo ,"\n\t\tERROR al procesar bCambiodespacho",LOG03);
    	bRetorno=FALSE;
    }
    
    /********************************************************************************/
    if(!bRetorno)
    {
        vDTrazasError( modulo ," \n\t------------------------------------"
                               " \n\tProceso Terminado de Forma Irregular"
                               " \n\t------------------------------------"
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
      vDTrazasLog  ( modulo ,"\n\t--------------------------------------------"
                             "\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
      vDTrazasError( modulo ,"\n\t--------------------------------------------"
                             "\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
                             "\n\t--------------------------------------------\n"
                             ,LOG03);
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

    return (0);
}/* ********************* Fin Main * *************************************** */


/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog(void)
{
    char modulo[]="ifnAbreArchivosLog";

    char *pathDir;
    char szArchivo[32]="";
    char szPath[128]="";
    char szComando[128]="";

    memset(szArchivo,'\0',sizeof(szArchivo));
    sprintf(szArchivo,"CambioDespacho");

    pathDir=(char *)malloc(128);
    pathDir=szGetEnv("XPF_LOG");
    sprintf(szPath,"%s/CambioDespacho/%s",pathDir,cfnGetTime(2)); 
    free(pathDir);

    fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
    sprintf(szComando,"mkdir -p %s", szPath);
    system (szComando);

    fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

    sprintf(stStatus.ErrName,"%s/%s_%s.err",szPath,szArchivo,cfnGetTime(5));
    if((stStatus.ErrFile = fopen(stStatus.ErrName,"w")) == (FILE*)NULL )/* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
        return -7;    }

    vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

    sprintf(stStatus.LogName,"%s/%s_%s.log",szPath,szArchivo,cfnGetTime(5));
    if((stStatus.LogFile = fopen(stStatus.LogName,"w")) == (FILE*)NULL ) /* "wb+" */
    {   fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
        vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
        return -8;    }

    vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));
    vDTrazasLog(modulo, "%s << Inicio de CambioDespacho >>" , LOG03, cfnGetTime(1));

    return 0;


} /* Fin ifnAbreArchivosLog  */


int bCambiodespacho (char *szhNomArchivo ) 
{
	char modulo[]="bCambiodespacho";
	char szNomArchivo[51]="";
	FILE	*fpent=NULL;		/* File entrada */
	
	strcpy(szNomArchivo,szhNomArchivo);
	
	vDTrazasLog  ( modulo ,"\n\t\t Ingreso a bCambiodespacho"
				 		   "\n\t\t Nom. Archivo  [%s]       "
				 		  ,LOG03, szNomArchivo);
				 		  
	if (!bAbrirArchivoDespacho(szNomArchivo, &fpent))
		return FALSE;
		
	if (!bProcesarArchivoDespacho(szNomArchivo, fpent))
		return FALSE;
		
	if (!bCerrarArchivoDespacho(szNomArchivo, &fpent))
		return FALSE;
	
	return TRUE;
}

int bAbrirArchivoDespacho( char *szNomArchivo, FILE **fpent)
{
	char modulo[]="bAbrirArchivoDespacho";
	char *pathDir;
	char szPathArchivo[256]="";
	
	pathDir=(char *)malloc(256);
    pathDir=szGetEnv("XPF_DAT");
    sprintf(szPathArchivo,"%s/CambioDespacho/%s",pathDir,szNomArchivo); 
    free(pathDir);
    
    vDTrazasLog  ( modulo ,"\n\t\t bAbrirArchivoDespacho"
				 		   "\n\t\t Archivo  [%s]       "
				 		  ,LOG03, szPathArchivo);
	
	*fpent = fopen(szPathArchivo,"r");
	if ( *fpent == NULL )
	{
		vDTrazasLog(modulo, "<< Error al Abrir Archivo de Despacho [%s] >>", LOG03, szPathArchivo);
		return FALSE;
	}
	return TRUE;
}

int bProcesarArchivoDespacho(char *szNomArchivo, FILE * fpent)
{
	long lLineaArchivo=0;
	long lErroneos=0;
	char szBufferIn[128]="";
	char    **listSplit;
	int iCantReg=0;
	
	FORMATO_ARCH stFormatoLinea;
	
	char modulo[]="bProcesarArchivoDespacho";
	vDTrazasLog  ( modulo ,"\n\t\t bProcesarArchivoDespacho"
				 		   "\n\t\t Archivo  [%s]       "
				 		  ,LOG03, szNomArchivo);
				 		  
	while ( fgets( szBufferIn ,128,fpent) != NULL )
	{
		lLineaArchivo++;
		
		szBufferIn[strlen(szBufferIn)-1]='\0';
		
		vDTrazasLog  ( modulo ,"\n\t\t LINEA %ld [%s]",LOG06, lLineaArchivo,szBufferIn);
		
		listSplit = split(szBufferIn,';',&iCantReg);
		int index=0;
		vDTrazasLog  ( modulo ,"\n\t\t iCantReg [%d]\n\n",LOG06, iCantReg);
		
		
        if (iCantReg != 5)
        {
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
        						   "\n\t\t El formato de la linea no es correcto :"
        						   "\n\t\t Formato [CodCliente;MailClie;TipDistribucion;FecModificacion;CausalModif;]"
        						   "\n\t\t Linea [%s]",LOG06, lLineaArchivo, szBufferIn);
        	
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
        						   "\n\t El formato de la linea no es correcto :"
        						   "\n\t Formato [CodCliente;MailClie;TipDistribucion;FecModificacion;CausalModif;]"
        						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
     		lErroneos++;
        }else{
	        
	        memset(&stFormatoLinea,0,sizeof(FORMATO_ARCH));
	
	        if(!bValidacionLinea(listSplit,lLineaArchivo, szBufferIn, &stFormatoLinea))
	        {
	        	vDTrazasLog  ( modulo ,"\n\t\t Error bValidacionLinea [%ld]",LOG03,lLineaArchivo);
	        	lErroneos++;
	        }else{
	        	
	        	strcpy(stFormatoLinea.UserResp,stLineaComando.szUser);
	        	
	        	vDTrazasLog  ( modulo ,"\n\t\t Informacion Para Actualizacion:"
	        						   "\n\t\t Cod. Cliente        [%ld]"
	        						   "\n\t\t E-Mail              [%s]"
	        						   "\n\t\t Tip.Distribucion    [%d]"
	        						   "\n\t\t Fec. Modificacion   [%s]"
	        						   "\n\t\t Cod. Causa          [%d]"
	        						   "\n\t\t Usuario Responzable [%s]"        	
	        						   ,LOG05
	        						   ,stFormatoLinea.lCodCliente     
									   ,stFormatoLinea.szMail          
									   ,stFormatoLinea.iTipDistribucion
									   ,stFormatoLinea.szFecModif      
									   ,stFormatoLinea.iCodCausa       
									   ,stFormatoLinea.UserResp);
									   
				if(!bActualizaClientes(&stFormatoLinea,lLineaArchivo, szBufferIn))
				{
					vDTrazasLog  ( modulo ,"\n\t\t Error bActualizaDatosClie",LOG03);
					lErroneos++;
				}
	        }
	    }

	}
	
	vDTrazasLog  ( modulo , "\n\n\n\n\n\n==============================================================="
				"\n\t\t Estadistica de Archivo [%s]:"
	        		"\n\t\t Registros Procesados        [%ld]"
	        		"\n\t\t Registros Erroneos          [%ld]"
	        		"\n\t\t Registros Correctos         [%ld]"
	        		"\n===============================================================\n\n\n\n"
	        		,LOG01
	        		,szNomArchivo
				,lLineaArchivo
				,lErroneos
				,(lLineaArchivo-lErroneos));
				
	vDTrazasError( modulo , "\n\n\n\n\n\n==============================================================="
				"\n\t\t Estadistica de Archivo [%s]:"
	        		"\n\t\t Registros Procesados        [%ld]"
	        		"\n\t\t Registros Erroneos          [%ld]"
	        		"\n\t\t Registros Correctos         [%ld]"
	        		"\n===============================================================\n\n\n\n"
	        		,LOG01
	        		,szNomArchivo
				,lLineaArchivo
				,lErroneos
				,(lLineaArchivo-lErroneos));
			
	
	return TRUE;
}

int bActualizaClientes(FORMATO_ARCH *stFormatoLinea,long lLineaArchivo,char *szBufferIn)
{
	char modulo[]="bActualizaGeClientes";
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lCodRetorno;
		char szMensRetorno[1024];
		long lNumEvento;
		char szTipModif[3];
		int  ihCodCausa;
		char szhUserORA       [50];
		long lhCodCliente;
		int  ihTipDistribucion;
		char szhMail[71];
		char szhFecModif[15];
		char szhFormatoFecha[18];
		char szhUserResp[31];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	vDTrazasLog  ( modulo ,"\n\t\t bActualizaGeClientes"
				 		   "\n\t\t NumLinea   [%d]"
				 		   "\n\t\t szBufferIn [%s]"
				 		  ,LOG03, lLineaArchivo,szBufferIn);
				 		  
	strcpy(szhFormatoFecha,"YYYYMMDDHH24MISS");
	
	lCodRetorno=0;
	strcpy(szMensRetorno,"");
	lNumEvento=0;
	strcpy(szTipModif,"Z1");
	
	ihCodCausa = stFormatoLinea->iCodCausa;
	strcpy(szhUserORA,stLineaComando.szUser);
	strcpy(szhUserResp,stFormatoLinea->UserResp);
	lhCodCliente = stFormatoLinea->lCodCliente;
	ihTipDistribucion = stFormatoLinea->iTipDistribucion;
	strcpy(szhMail,stFormatoLinea->szMail);
	strcpy(szhFecModif,stFormatoLinea->szFecModif);
	
	vDTrazasLog  ( modulo ,"\n\t\t ACTUALIZA GE_CLIENTES"
				 		   "\n\t\t Cod.Cliente   [%d]"
				 		   ,LOG03, lhCodCliente);
	
	/* EXEC SQL EXECUTE
    	BEGIN
        	GA_CARGADESPACHO_BATCH_PG.GA_CARGADESPACHO_PR ( :lhCodCliente, TO_DATE(:szhFecModif,:szhFormatoFecha), :ihTipDistribucion, :szhMail, :szhUserResp, :ihCodCausa, :szTipModif, :szhUserORA, :lCodRetorno, :szMensRetorno, :lNumEvento );
		END;
	END-EXEC; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 12;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "begin GA_CARGADESPACHO_BATCH_PG . GA_CARGADESPACHO_PR ( :lhC\
odCliente , TO_DATE ( :szhFecModif , :szhFormatoFecha ) , :ihTipDistribucion ,\
 :szhMail , :szhUserResp , :ihCodCausa , :szTipModif , :szhUserORA , :lCodReto\
rno , :szMensRetorno , :lNumEvento ) ; END ;";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecModif;
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFormatoFecha;
 sqlstm.sqhstl[2] = (unsigned long )18;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihTipDistribucion;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhMail;
 sqlstm.sqhstl[4] = (unsigned long )71;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhUserResp;
 sqlstm.sqhstl[5] = (unsigned long )31;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCausa;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szTipModif;
 sqlstm.sqhstl[7] = (unsigned long )3;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhUserORA;
 sqlstm.sqhstl[8] = (unsigned long )50;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&lCodRetorno;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)szMensRetorno;
 sqlstm.sqhstl[10] = (unsigned long )1024;
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&lNumEvento;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
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


	
	
	if(lCodRetorno != 0)
	{
		vDTrazasLog  ( modulo ,"\n\t\t Error en GA_CARGADESPACHO_BATCH_PG.GA_CARGADESPACHO_PR"
				 		   	   "\n\t\t lCodRetorno   [%ld]"
				 		   	   "\n\t\t szMensRetorno [%s]"
				 		   	   "\n\t\t lNumEvento    [%ld]"
				 		   	   ,LOG03, lCodRetorno,alltrim(szMensRetorno),lNumEvento);
		
		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
							   "\n\t Al Ejecutar PL GA_CARGADESPACHO_BATCH_PG.GA_CARGADESPACHO_PR:"
	    					   "\n\t Codigo de Retorno [%ld]:"
	    					   "\n\t Mensaje de Error  [%s]"
	    					   "\n\t [%s]"
	    					   ,LOG01, lLineaArchivo,lCodRetorno,alltrim(szMensRetorno),szBufferIn);		 		   	   
		
		return FALSE;
	}
	return TRUE;
}

int bValidacionLinea(char **listSplit, long lLineaArchivo, char *szBufferIn, FORMATO_ARCH *stFormatoLinea)
{
	char modulo[]="bValidacionLinea";
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char szhFecModif[15];
	char szhFormatoFecha[18];
	char szhValFec[51];
	char szVarAux [256];
	/* EXEC SQL END DECLARE SECTION; */ 

	
	strcpy(szhFormatoFecha,"YYYYMMDDHH24MISS");
	
		strcpy(szVarAux,listSplit[0]);
		if(strcmp(listSplit[0],"")==0 || strcmp(alltrim(szVarAux),"")==0)
        {
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
    						   "\n\t\t Falta Codigo de Cliente :"
    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
    						   "\n\t Falta Codigo de Cliente :"
    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    		return FALSE;
    	}else{
    		if (!isNumber(szVarAux))
    		{
    			vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
    						   "\n\t\t El Codigo de Cliente debe ser Numerico :"
    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
    						   "\n\t El Codigo de Cliente debe ser Numerico :"
    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    			return FALSE;
    		}else{
    			stFormatoLinea->lCodCliente = atol(szVarAux);
    		}
    	}
        
        strcpy(szVarAux,listSplit[2]);
		if(strcmp(listSplit[2],"")==0 || strcmp(alltrim(szVarAux),"")==0)
        {
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
    						   "\n\t\t Falta Tipo de Distribucion :"
    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
    						   "\n\t Falta Tipo de Distribucion :"
    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    		return FALSE;
    	}else{
    		
    		if (!isNumber(szVarAux))
    		{
    			vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
    						   "\n\t\t El Tipo de Distribucion debe ser Numerico :"
    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
    						   "\n\t El Tipo de Distribucion debe ser Numerico :"
    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    			return FALSE;
    		}else{
    		
	    		stFormatoLinea->iTipDistribucion = atoi(szVarAux);
	    		
	    		if (stFormatoLinea->iTipDistribucion < 0 || stFormatoLinea->iTipDistribucion > 1)
	    		{
	    			vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
			    						   "\n\t\t El Tipo de Distribucion debe tener valores 0 ó 1:"
			    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
	    						   
		        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
			    						   "\n\t El Tipo de Distribucion debe tener valores 0 ó 1:"
			    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
	    			return FALSE;
	    		}
	    	}
    	}
        
        strcpy(szVarAux,listSplit[1]);
		if (stFormatoLinea->iTipDistribucion == 1 && ( strcmp(listSplit[1],"")==0 || strcmp(alltrim(szVarAux),"")==0))
        {
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
	    						   "\n\t\t Falta el E-Mail ya que el tipo de Distribucion es ELECTRONICA:"
	    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
	    						   "\n\t Falta el E-Mail ya que el tipo de Distribucion es ELECTRONICA:"
	    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    		return FALSE;
        }
        
        if (strcmp(alltrim(szVarAux),"")!=0 )
        {
        	strcpy(stFormatoLinea->szMail,szVarAux);
        	
        	if (strlen(stFormatoLinea->szMail)< 3 || strlen(stFormatoLinea->szMail)>70)
        	{
        		vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
		    						   "\n\t\t El correo debe ser mayor a 3 y menor a 70 caracteres:"
		    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
	        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
		    						   "\n\t El correo debe ser mayor a 3 y menor a 70 caracteres:"
		    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
		    	return FALSE;
        	}
        	
        	if (strstr (stFormatoLinea->szMail, "@")==NULL)
        	{
        		vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
		    						   "\n\t\t El E-Mail debe poseer el caracter @ :"
		    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
		    						   "\n\t  El E-Mail debe poseer el caracter @ :"
		    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
		    	return FALSE;
        	}
        }
        
        
        strcpy(szVarAux,listSplit[3]);
		if(strcmp(listSplit[3],"")==0 || strcmp(alltrim(szVarAux),"")==0)
        {
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
	    						   "\n\t\t Falta Fecha de Modificacion :"
	    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
	    						   "\n\t Falta Fecha de Modificacion :"
	    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    		return FALSE;
    	}else{
    		strcpy(stFormatoLinea->szFecModif,szVarAux);
    		
    		strcpy(szhFecModif,stFormatoLinea->szFecModif);
    		
    		
    		/* EXEC SQL SELECT to_date(:szhFecModif,:szhFormatoFecha) 
    					INTO :szhValFec
	    			FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 12;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select to_date(:b0,:b1) into :b2  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )68;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhFecModif;
      sqlstm.sqhstl[0] = (unsigned long )15;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoFecha;
      sqlstm.sqhstl[1] = (unsigned long )18;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhValFec;
      sqlstm.sqhstl[2] = (unsigned long )51;
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


				
			if (SQLCODE < SQLOK && SQLCODE != SQLNOTFOUND)  {
        		vDTrazasLog  (modulo , "\t\tError al validar la Fecha de Modificacion SELECT SQLCODE[%d]", LOG05, SQLCODE);
        		
        		vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
		    						   "\n\t\t No se pudo Validar la Fecha (YYYYMMDDHHMISS): [%s]"
		    						   "\n\t\t [%s]",LOG03, lLineaArchivo,szhFecModif, szBufferIn);
    						   
        		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
		    						   "\n\t No se pudo Validar la Fecha (YYYYMMDDHHMISS): [%s] "
		    						   "\n\t [%s]",LOG01, lLineaArchivo,szhFecModif, szBufferIn);
        		
		        return(FALSE);
		    }
    	}
    	
    	strcpy(szVarAux,listSplit[4]);
		if(strcmp(listSplit[4],"")==0 || strcmp(alltrim(szVarAux),"")==0)
    	{
        	vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
	    						   "\n\t\t Falta Causal de Modificacion :"
	    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        	vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
	    						   "\n\t Falta Causal de  Modificacion :"
	    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    		return FALSE;
    	}else{
    		if (!isNumber(szVarAux))
    		{
    			vDTrazasLog  ( modulo ,"\n\t\t Error, En la linea [%ld]"
    						   "\n\t\t El Causal de  Modificacion debe ser Numerico :"
    						   "\n\t\t [%s]",LOG03, lLineaArchivo, szBufferIn);
    						   
        		vDTrazasError( modulo ,"\n\t Error, En la linea [%ld]"
    						   "\n\t El Causal de  Modificacion debe ser Numerico :"
    						   "\n\t [%s]",LOG01, lLineaArchivo, szBufferIn);
    			return FALSE;
    		}else{
    			stFormatoLinea->iCodCausa = atoi(szVarAux);
    		}
    	}
    	
    return TRUE;
}

int bCerrarArchivoDespacho(char *szNomArchivo, FILE **fpent)
{
	char *pathDir;
	char szMV[1024]="";
	
	pathDir=(char *)malloc(256);
    pathDir=szGetEnv("XPF_DAT");
    sprintf(szMV,"mv %s/CambioDespacho/%s %s/CambioDespacho/procesados/.",pathDir, szNomArchivo,pathDir ); 
    free(pathDir);
	
	char modulo[]="bCerrarArchivoDespacho";
	vDTrazasLog  ( modulo ,"\n\t\t bCerrarArchivoDespacho"
				 		   "\n\t\t Archivo  [%s]       "
				 		  ,LOG03, szNomArchivo);
	if(fclose(*fpent))
	{
		vDTrazasLog  ( modulo ,"\n\t\t Error No se pudo cerrar el archivo",LOG03);
	}
	
	
	vDTrazasLog  ( modulo ,"\n\t\t El Archivo  [%s] se mueve a la carpeta procesados"
				 		  ,LOG03, szNomArchivo);
	system (szMV);
	
	return TRUE;
}

char **split ( char *string, const char sep, int *iCantReg) {
 
    char       **lista;
    char       *p = string;
    int         i = 0;
 
    int         pos;
    const int   len = strlen (string);
 
    lista = (char **) malloc (sizeof (char *));
    if (lista == NULL) {                      /* Cannot allocate memory */
        return NULL;
    }
 
    lista[pos=0] = NULL;
    
    if (p[0] == sep)
    {
    	if (i <len) {
	 			 char **tmp = (char **) realloc (lista , (pos + 2) * sizeof (char *));
	            if (tmp == NULL) {       /* Cannot allocate memory */
	                free (lista);
	                return NULL;
	            }
	            lista = tmp;
	            tmp = NULL;
	 
	            lista[pos + 1] = NULL;
	            lista[pos] = (char *) malloc (sizeof (char));
	            if (lista[pos] == NULL) {         /* Cannot allocate memory */
	                for (i = 0; i <pos; i++)
	                    free (lista[i]);
	                free (lista);
	                return NULL;
	            }
	 
	            lista[pos][0] = '\0';
	            pos++;
	        }
    }
 
    while (i <len) {
    	if (((p[i] == sep) && (p[i+1] == sep)))
    	{
    		if (i <len) {
	 			 char **tmp = (char **) realloc (lista , (pos + 2) * sizeof (char *));
	            if (tmp == NULL) {       /* Cannot allocate memory */
	                free (lista);
	                return NULL;
	            }
	            lista = tmp;
	            tmp = NULL;
	 
	            lista[pos + 1] = NULL;
	            lista[pos] = (char *) malloc (sizeof (char));
	            if (lista[pos] == NULL) {         /* Cannot allocate memory */
	                for (i = 0; i <pos; i++)
	                    free (lista[i]);
	                free (lista);
	                return NULL;
	            }
	 
	            lista[pos][0] = '\0';
	            pos++;
	            i++;
	        }
    		
    	}else{
		    while ((p[i] == sep) && (i <len))
	            i++;
	 		
	 		if (i <len) {
	 
	            char **tmp = (char **) realloc (lista , (pos + 2) * sizeof (char *));
	            if (tmp == NULL) {       /* Cannot allocate memory */
	                free (lista);
	                return NULL;
	            }
	            lista = tmp;
	            tmp = NULL;
	 
	            lista[pos + 1] = NULL;
	            lista[pos] = (char *) malloc (sizeof (char));
	            if (lista[pos] == NULL) {         /* Cannot allocate memory */
	                for (i = 0; i <pos; i++)
	                    free (lista[i]);
	                free (lista);
	                return NULL;
	            }
	 
	            int j = 0;
	            for (i; ((p[i] != sep) && (i <len)); i++) {
	                lista[pos][j] = p[i];
	                j++;
	 		        char *tmp2 = (char *) realloc (lista[pos],(j + 1) * sizeof (char));
	                if (lista[pos] == NULL) {     /* Cannot allocate memory */
	                    for (i = 0; i <pos; i++)
	                        free (lista[i]);
	                    free (lista);
	                    return NULL;
	                }
	                lista[pos] = tmp2;
	                tmp2 = NULL;
	            }
	            
	            lista[pos][j] = '\0';
	            pos++;
	        }
	    }
    }
 	*iCantReg=pos;
 	
    return lista;
}

#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) ) return(s);
    while( *p<=32 && *p>1 ) p++;
    strcpy(s,p);
    return(s);
}

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) ) return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )  p--;
    *(++p)=0;
    return(s);
}

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
}

int isNumber(char *szVarAux)
{
	BOOL bNumeric = TRUE;
	int i = 0;
	
	for(i = 0; szVarAux[i]; i++)
	{
		if(!isdigit(szVarAux[i]))
		{
			bNumeric = FALSE;
		}
	}
 	
 	return bNumeric;
}
