
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
           char  filnam[29];
};
static const struct sqlcxp sqlfpn =
{
    28,
    "./pc/Co_PagosConsolidados.pc"
};


static unsigned int sqlctx = 1270806755;


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
   unsigned char  *sqhstv[8];
   unsigned long  sqhstl[8];
            int   sqhsts[8];
            short *sqindv[8];
            int   sqinds[8];
   unsigned long  sqharm[8];
   unsigned long  *sqharc[8];
   unsigned short  sqadto[8];
   unsigned short  sqtdso[8];
} sqlstm = {12,8};

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

 static const char *sq0002 = 
"select COD_ENTIDAD ,DES_ENTIDAD  from CO_ENTCOB  order by COD_ENTIDAD       \
     ";

 static const char *sq0003 = 
"select distinct B.COD_CLIENTE  from CO_PAGOS A ,CO_GESTION_COBEX_TO B where \
((((A.COD_CLIENTE=B.COD_CLIENTE and B.TIP_GESTION=:b0) and A.FEC_EFECTIVIDAD b\
etween TO_DATE(:b1,:b2) and TO_DATE(:b3,:b2)) and B.COD_ENTIDAD=:b5) and COD_T\
IPDOCUM in (8,9,25,83))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,141,0,6,227,0,0,4,4,0,1,0,2,5,0,0,1,5,0,0,2,5,0,0,1,5,0,0,
36,0,0,2,81,0,9,403,0,0,0,0,0,1,0,
51,0,0,2,0,0,13,411,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
74,0,0,2,0,0,15,439,0,0,0,0,0,1,0,
89,0,0,3,266,0,9,491,0,0,6,6,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,
128,0,0,3,0,0,13,499,0,0,1,0,0,1,0,2,3,0,0,
147,0,0,3,0,0,15,561,0,0,0,0,0,1,0,
162,0,0,4,241,0,4,593,0,0,8,6,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,2,5,0,0,1,
3,0,0,1,3,0,0,1,5,0,0,
209,0,0,5,84,0,4,646,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
236,0,0,6,175,0,4,690,0,0,6,5,0,1,0,2,4,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,
275,0,0,7,167,0,4,736,0,0,8,7,0,1,0,1,5,0,0,2,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  PROCESO
    Nombre      :  Co_PagosConsolidados.pc

    Descripcion :  Generacion de archivos de pagos consolidados por entidad de 
                   cobranza                        
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "Co_PagosConsolidados.h"

LINEACOMANDO	stLineaComando;			/* Datos con los que se invoco al proceso */
char            *pathDir ;
char            szPathLog   [256] = "";
char            szPathDat   [256] = "";

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


/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhMORA                 [2]; /* EXEC SQL VAR szhMORA                 IS STRING (2); */ 
   
	char	szhNULO                 [5]; /* EXEC SQL VAR szhNULO                 IS STRING (5); */ 
   
	char	szRangoInicial         [17]; /* EXEC SQL VAR szRangoInicial          IS STRING(17); */ 
   
	char	szRangoFinal           [17]; /* EXEC SQL VAR szRangoFinal            IS STRING(17); */ 
   
	char	szhPagco                [9]; /* EXEC SQL VAR szhPagco                IS STRING (9); */ 
   	
	char	szhYYYYMMDD             [9]; /* EXEC SQL VAR szhYYYYMMDD             IS STRING (9); */ 
   	
	char	szFechayyyymmdd         [9]; /* EXEC SQL VAR szFechayyyymmdd         IS STRING (9); */ 
   	
	char    szhYYYYMMDDHH24MISS    [17]; /* EXEC SQL VAR szhYYYYMMDDHH24MISS     IS STRING(17); */ 
   	
	char    szFechayyyymmddHH24MISS[17]; /* EXEC SQL VAR szFechayyyymmddHH24MISS IS STRING(17); */ 
   	
	char    szFormato000000         [7]; /* EXEC SQL VAR szFormato000000         IS STRING (7); */ 
  
	char    szFormato235959         [7]; /* EXEC SQL VAR szFormato235959         IS STRING (7); */ 
   	
/* EXEC SQL END DECLARE SECTION; */ 


td_Entidad sthEntidad;         /* Estructura de Entidades de Cobranza        */
long       lIndEnt   ;         /* Indice de array para Parametros            */
long       lIndCobex ;

static char szUsage [] =
   "\n\tUso : Co_PagosConsolidados"
   "\n\t\t -u [Usuario]/[Password]"
   "\n\t\t -l [NivelLog]"
   "\n\t\t -i [Fecha Inicio  yyyyymmdd]"
   "\n\t\t -f [Fecha Final   yyyyymmdd]\n\n";

/*=======================================================================================*/
/* int main(int argc,char *argv[])                                                       */
/*=======================================================================================*/
int main(int argc,char *argv[])
{
    char modulo[]="main";
    char szError[1024] = "";
    int  iResult = 0;
        
    fprintf(stdout, "\n%s PAGOS CONSOLIDADOS PID(%ld) VERSION(%s)\n", szGetTime(1),getpid(),szVERSION);
    fflush (stdout);

   	strcpy(szFormato000000,"000000");
   	strcpy(szFormato235959,"235959");

    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));

    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0)    
    {
        fprintf (stdout,"\n\t=>Error Faltan Parametros de Entrada: \n%s\n\n",szUsage);
        fflush  (stdout);
        iResult = 1; /* Fallo validacion */
    } else {    
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)   
        {
            fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
            fflush  (stdout);
            iResult = 2; /* Fallo conexion */
        } else {
        	
    	    /* Inicializacion de Parametros */
    	    vfnInicializacionParametros();    

            /*- Prepara Archivo de Log -*/ 
            if (ifnAbreArchivoLog() != 0)    
            {
                fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
                fflush  (stdout);
                iResult = 3;  /* Fallo Log */
            } else {
                /*- Ejecuta el proceso propiamente tal -*/
                if( ifnEjecutaProceso( szError ) < 0 ) 
                {
                    fprintf (stdout,"\n\tError >> Fallo el proceso \n");
                    fflush  (stdout);
                    iResult = 4; /* Fallo Proceso */
                }
                vfnCierraArchivoLog();
            } /* end ifnAbreArchivoLog*/
        } /* end if (ifnConexionDB(&stLineaComando) != 0)  */
    } /* end if (ifnValidaParametros(argc,argv,&stLineaComando) != 0) */

    return iResult;
   
} /* end main */    

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
    char modulo[]="ifnValidaParametros";

    /*- Definicion de variables para controlar la lista de argumentos recibidos -*/
    extern char *optarg;
    extern  int optind, opterr, optopt;
            int iOpt=0;
           char opt[] = "u:l:i:f:";
    /*- Variables locales -------------------------------------------------------*/  
           char *psztmp = "";
    /*-- Flags de los valores recibidos -----------------------------------------*/
            int Userflag=0;
            int Logflag=0;

    /*-- Seteo de Valores Iniciles y por defecto --------------------------------*/
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;
    
    /*- Analisis de los argumentos recibidos ------------------------------------*/
    while ((iOpt=getopt(argc, argv, opt))!=EOF)
    {
        switch(iOpt)
        {
            case 'u':  /*-- Usuario/Password --*/
                 if(!Userflag)
                 {
                    strcpy(pstLC->szUsuarioOra, optarg);                      
                    Userflag=1;
                    if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL)
                    {
                        fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/' \n");
                        fflush  (stderr);
                        return -1;
                    } else {
                        strncpy (pstLC->szOraAccount,pstLC->szUsuarioOra,psztmp-pstLC->szUsuarioOra);
                        strcpy  (pstLC->szOraPasswd, psztmp+1);
                    }
                } else {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;

            case 'l': /*-- Nivel de Log --*/
                if(!Logflag)
                {
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
                } else {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;

			case 'i': /*-- Rango de Fecha de Inicio --*/
			    memset(szFechayyyymmdd,0,sizeof(szFechayyyymmdd));
                strcpy  (szFechayyyymmdd, optarg);			    
				sprintf( szRangoInicial, "%s%s", szFechayyyymmdd, szFormato000000);
				break;

			case 'f': /*-- Rango de Fecha de Final  --*/
			    memset(szFechayyyymmdd,0,sizeof(szFechayyyymmdd));
                strcpy  (szFechayyyymmdd, optarg);			    
				sprintf( szRangoFinal, "%s%s", szFechayyyymmdd, szFormato235959);				
				break;

            case '?':
                fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida\n",optopt);
                fflush  (stderr);
                return -1;

            case ':':
                fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'\n",optopt);
                fflush  (stderr);
                return -1;
        } /* end switch*/
    } /* end while */
    pstLC->iLogLevel=stStatus.iLogNivel;
    return 0;

} /* end ifnValidaParametros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB(LINEACOMANDO *pstLC)
{
    char modulo[]="ifnConexionDB";
    
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  )
    {
        fprintf (stderr,"\nNo hay conexion a ORACLE \n");
        fflush  (stderr);
        return -1;
    }
    
    return 0;
} /* end ifnConexionDB */
/* ============================================================================= */

/* ============================================================================= */
/* vfnInicializacionParametros():                                                */
/* ============================================================================= */
void vfnInicializacionParametros(void)
{
char modulo[]="vfnInicializacionParametros";
    
    strcpy(szhPagco           ,PAGCO);
  	strcpy(szhYYYYMMDD     	  ,"YYYYMMDD");
  	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");
    strcpy(szhMORA            , MORA);
    strcpy(szhNULO            , NULO);

    memset(szFechayyyymmdd,0,sizeof(szFechayyyymmdd));
       
    /* EXEC SQL EXECUTE
		BEGIN
			:szFechayyyymmdd        :=TO_CHAR(SYSDATE, :szhYYYYMMDD);
			:szFechayyyymmddHH24MISS:=TO_CHAR(SYSDATE, :szhYYYYMMDDHH24MISS);
		END;
	END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szFechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMD\
D ) ; :szFechayyyymmddHH24MISS := TO_CHAR ( SYSDATE , :szhYYYYMMDDHH24MISS ) ;\
 END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szFechayyyymmdd;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szFechayyyymmddHH24MISS;
    sqlstm.sqhstl[2] = (unsigned long )17;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDDHH24MISS;
    sqlstm.sqhstl[3] = (unsigned long )17;
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


	
	lIndEnt   = 0;
	lIndCobex = 0;

	sprintf(stStatus.szFileName   ,"%s%s",szhPagco, szFechayyyymmddHH24MISS  );
	sprintf(stStatus.szLogPathGene,"%s","/LOG");
    
  	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

    sprintf(szPathLog  ,"%s/%s",stStatus.szLogPathGene,szFechayyyymmdd);
    sprintf(szPathDat  ,"%s/%s","/DAT",szFechayyyymmdd);

    return;
} /* end vfnInicializacionParametros */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* if iCreaDir != 0 : crear directorio antes que el archivo                      */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
    char modulo[]="ifnAbreArchivoLog";
    char szArchivoLog[256]=""; /* log */
    char szArchivoErr[256]=""; /* errores */
    char szArchivoPag[256]=""; /* pagos consolidados */
    char szComando   [256]="";
    
    memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log */         
    memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores */     
    memset(szArchivoPag,0,sizeof(szArchivoPag)); /* errores */     
        
	sprintf(szComando,"/usr/bin/mkdir -p %s",szPathLog);	
	fprintf( stderr, "%s %s\n",szComando, szPathLog);

    if (system (szComando)!=0)  /* no pudo crear el directorio */
    {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
    }
    sprintf(szArchivoLog,"%s/%s.log",szPathLog,stStatus.szFileName);
    sprintf(szArchivoErr,"%s/%s.err",szPathLog,stStatus.szFileName);
    
    if((stStatus.LogFile = fopen(szArchivoLog,"a")) == (FILE*)NULL )
    {    
        fprintf (stderr,"Error al crear archivo de Log\n");
        fflush  (stderr);
        return -1;    
    }
    
    if((stStatus.ErrFile = fopen(szArchivoErr,"a")) == (FILE*)NULL )
    {    
        fprintf (stderr,"Error al crear archivo de Errores\n");
        fflush  (stderr);
        return -1;    
    }

	sprintf(szComando,"/usr/bin/mkdir -p %s",szPathDat);	
	fprintf( stderr, "%s %s\n",szComando, szPathDat);
    sprintf(szArchivoPag,"%s/%s.txt",szPathDat,stStatus.szFileName);

    if((ArchPag = fopen(szArchivoPag,"a")) == (FILE*)NULL )
    {    
        fprintf (stderr,"Error al crear archivo de Pagos Consolidados \n");
        fflush  (stderr);
        return -1;    
    }    
    
    ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO <%ld> -\n", INFALL
                       ,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

    return 0;
    
}/* end ifnAbreArchivoLog */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs        */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
    char modulo[]="vfnCierraArchivoLog";
    
    ifnTrazasLog(modulo, "%s -  CIERRE  DE ARCHIVO <%ld> -\n", INFALL
                       ,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

    if ( fclose(stStatus.LogFile) != 0 )
    {    
        fprintf (stderr,"Error al cerrar archivo de Log\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.ErrFile) != 0 )
    {    
        fprintf (stderr,"Error al cerrar archivo de Errores\n");
        fflush  (stderr);
    }
        
    return;    
} /* end vfnCierraArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/*  ifnEjecutaProceso()                                                          */
/* ============================================================================= */
int ifnEjecutaProceso(void)
{
    char	modulo[] = "ifnEjecutaProceso";
    char	szError[1024] = "";

    ifnTrazasLog(modulo,"Corriendo la cola lanzada ",LOG05);

   	/* Carga de datos de uso general */
	if( !bfnObtieneDatosGenerales() )
	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bfnObtieneDatosGenerales().", LOG03 );	    
	    return -1;
	}

    if( ifnGeneraUniverso() != 0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnGeneraUniverso().", LOG03 );
		return -1;
	}		 
    
   	if (ifnGeneraArchivos() !=0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnGeneraArchivos().", LOG03 );
		return -1;
	}		

    if (!bfnOraCommit())  {    
        ifnTrazasLog(modulo,"Erro en el proceso' : %s",LOG00,SQLERRM);
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM); {
             return -1;    
        }
    } /* end bfnOraCommit */

    return 0; 
} /* end ifnEjecutaProceso */
/* ============================================================================= */

/* ============================================================================= */
/* ifnGeneraUniverso : Procesamiento real del tema, sin considear la Cola        */
/* ============================================================================= */
int ifnGeneraUniverso()
{
char modulo[]="ifnGeneraUniverso";
int  iError  = 0;     
int  iRes    = 0;
     
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 

/* EXEC SQL END DECLARE SECTION; */ 

    
    memset(shCodEntidad,'\0',sizeof(shCodEntidad));
    memset(shDesEntidad,'\0',sizeof(shDesEntidad));
 
    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_UniCob CURSOR for        
    SELECT  COD_ENTIDAD, DES_ENTIDAD
       FROM CO_ENTCOB 
      ORDER BY COD_ENTIDAD ; */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_UniCob - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_UniCob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )36;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_UniCob - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_UniCob INTO :shCodEntidad  , :shDesEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )51;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)shCodEntidad;
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shDesEntidad;
        sqlstm.sqhstl[1] = (unsigned long )31;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

		ifnTrazasLog( modulo, " =============================================================", LOG03);
		ifnTrazasLog( modulo, " Entidad [%s] - [%s]", LOG03, shCodEntidad,  shDesEntidad);

        strcpy(sthEntidad.sCodAgente[lIndCobex],shCodEntidad); 
        strcpy(sthEntidad.sDesAgente[lIndCobex],shDesEntidad); 

        sthEntidad.dMonto[lIndCobex] = 0;
        
        iRes = ifnGeneraPagosEntidad(shCodEntidad);
        if( iRes < 0 ) return -1; 

        ifnTrazasLog( modulo, " sthEntidad.dMonto [%.2f]", LOG09,sthEntidad.dMonto[lIndCobex]);
        
        lIndCobex = lIndCobex + 1;
        
    } /* end while */       	    	   	

	/* EXEC SQL CLOSE Cur_UniCob; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )74;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
           	
    return iError;

} /* end ifnGeneraUniverso */
/* ============================================================================= */

/* ============================================================================= */
/* ifnGeneraPagosEntidad                                                         */
/* ============================================================================= */
int ifnGeneraPagosEntidad(char *sEntidad)					
{  
char modulo[]   = "ifnGeneraUniverso";
int  iRes;
int  iError     = 0;
int  iResConsulta;
int  iResMorosidad;

/* EXEC SQL BEGIN DECLARE SECTION; */ 

   char   shCodEntidad  [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   char   shFecInicio  [17]; /* EXEC SQL VAR shFecInicio   IS STRING(17); */ 
   
   char   shFecTermino [17]; /* EXEC SQL VAR shFecTermino  IS STRING(17); */ 
   
   long   lhCodCliente     ;   
/* EXEC SQL END DECLARE SECTION; */ 


   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      

    memset(shCodEntidad,'\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, sEntidad);                              
    
    /************************************************************************/
    /* Obtiene el Universo de Pagos por Entidades de Cobranzas              */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_Pag CURSOR for        
    SELECT DISTINCT B.COD_CLIENTE
      FROM CO_PAGOS A, CO_GESTION_COBEX_TO B 
     WHERE A.COD_CLIENTE = B.COD_CLIENTE 
       AND B.TIP_GESTION = :szhMORA
       AND A.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szRangoInicial, :szhYYYYMMDDHH24MISS) AND TO_DATE(:szRangoFinal, :szhYYYYMMDDHH24MISS)
       AND B.COD_ENTIDAD = :shCodEntidad
       AND COD_TIPDOCUM IN (8,9,25,83); */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Pag - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_Pag; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0003;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )89;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhMORA;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szRangoInicial;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDDHH24MISS;
    sqlstm.sqhstl[2] = (unsigned long )17;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szRangoFinal;
    sqlstm.sqhstl[3] = (unsigned long )17;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhYYYYMMDDHH24MISS;
    sqlstm.sqhstl[4] = (unsigned long )17;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)shCodEntidad;
    sqlstm.sqhstl[5] = (unsigned long )6;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Pag - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Pag INTO :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )128;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

        ifnTrazasLog( modulo, "- - - - - - - - - - - - - - - - - - - - - - - ", LOG09 );
        ifnTrazasLog( modulo, "lhCodCliente  [%ld] ", LOG09, lhCodCliente );
        ifnTrazasLog( modulo, "szRangoInicial[%s] ", LOG09, szRangoInicial );
        ifnTrazasLog( modulo, "szRangoFinal  [%s] ", LOG09, szRangoFinal );
        
        iResConsulta = ifnConsultaFechaTermino(lhCodCliente, shFecInicio, shFecTermino, shCodEntidad);
        if( iResConsulta < 0 ) {
        	iError = -1; 
        	break;
        }

        if( iResConsulta == 1 ) { /* sin fecha de termino en CO_GESTION_COBEX_TO */
        	iResMorosidad = ifnFecMorosidad(lhCodCliente, shCodEntidad);
            if( iResMorosidad < 0 ) {
        	    iError = -1; 
        	    break;
            }
        	
            if( iResMorosidad == 1 ) {            	
            	iRes = ifnMontoPago(lhCodCliente, shFecInicio, szRangoFinal);            	
            	if( iRes < 0 ) {
        	        iError = -1; 
        	        break;
                }
        	} /* end iResMorosidad == 1 */

            if( iResMorosidad == 0 ) {            	
            	iRes = ifnFecHistoricoMoroso(lhCodCliente, szRangoInicial, szRangoFinal, shFecTermino, shCodEntidad);
            	if( iRes < 0 ) {
        	        iError = -1; 
        	        break;
                }
            	
            	iRes = ifnMontoPago(lhCodCliente, shFecInicio, shFecTermino);            	
            	if( iRes < 0 ) {
        	        iError = -1; 
        	        break;
                } 
        	}  /* iResMorosidad == 0*/      	
        }  /* end iResConsulta == 1 */       
       
        if( iResConsulta == 0 ) { /* con fecha de termino en CO_GESTION_COBEX_TO */

            iRes = ifnMontoPago(lhCodCliente, shFecInicio, shFecTermino);            	
            if( iRes < 0 ) {
        	    iError = -1; 
        	    break;
            }         	
        } /* end iResConsulta == 0 */                             
    } /* end while */       	    	   	

	/* EXEC SQL CLOSE Cur_Pag; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 6;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )147;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
           	
    return iError;

} /* end ifnGeneraPagosEntidad */
/* ============================================================================= */

/* ============================================================================= */
/*  ifnConsultaFechaTermino                                                      */
/* ============================================================================= */
int ifnConsultaFechaTermino(long lCodCliente, char *sFecIngreso, char *sFecTermino, char *sCodEntidad)
{	
char   modulo[]="ifnConsultaFechaTermino";
int    iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
  long   lhCodCliente   ;
  char   shFecTermino[17]; /* EXEC SQL VAR shFecTermino  IS STRING(17); */ 

  char   shFecInicio [17]; /* EXEC SQL VAR shFecInicio   IS STRING(17); */ 

  char   shCodEntidad [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 
  
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
   memset(shCodEntidad,'\0',sizeof(shCodEntidad));
   strcpy(shCodEntidad, sCodEntidad);                              
   lhCodCliente = lCodCliente;              
                                           
   /* EXEC SQL                       
   SELECT NVL(TO_CHAR(FEC_TERMINO, :szhYYYYMMDDHH24MISS), :szhNULO), TO_CHAR(FEC_INGRESO, :szhYYYYMMDDHH24MISS)
     INTO :shFecTermino, :shFecInicio
     FROM CO_GESTION_COBEX_TO
    WHERE COD_CLIENTE = :lhCodCliente
      AND FEC_INGRESO = (SELECT MAX(FEC_INGRESO) 
                           FROM CO_GESTION_COBEX_TO 
                          WHERE COD_CLIENTE = :lhCodCliente
                            AND COD_ENTIDAD = :shCodEntidad); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(TO_CHAR(FEC_TERMINO,:b0),:b1) ,TO_CHAR(FEC_INGR\
ESO,:b0) into :b3,:b4  from CO_GESTION_COBEX_TO where (COD_CLIENTE=:b5 and FEC\
_INGRESO=(select max(FEC_INGRESO)  from CO_GESTION_COBEX_TO where (COD_CLIENTE\
=:b5 and COD_ENTIDAD=:b7)))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )162;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[0] = (unsigned long )17;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhNULO;
   sqlstm.sqhstl[1] = (unsigned long )5;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[2] = (unsigned long )17;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)shFecTermino;
   sqlstm.sqhstl[3] = (unsigned long )17;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)shFecInicio;
   sqlstm.sqhstl[4] = (unsigned long )17;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)shCodEntidad;
   sqlstm.sqhstl[7] = (unsigned long )6;
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

    
                    
   if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En SELECT NVL(FEC_TERMINO) - %s", LOG00, SQLERRM );
	  return -1;				
   }
	           	
   if  (strcmp(shFecTermino,NULO)!= 0) {
      iError = 0; 
      strcpy(sFecIngreso, shFecInicio);                              
      strcpy(sFecTermino, shFecTermino);                              
   }

   if  (strcmp(shFecTermino,NULO)== 0) {
      iError = 1; 
   }

   ifnTrazasLog( modulo, " shFecInicio  [%s]", LOG09,shFecInicio);                      
   ifnTrazasLog( modulo, " shFecTermino [%s]", LOG09,shFecTermino);                      
   ifnTrazasLog( modulo, " iError [%d]", LOG09,iError);                      
	           	
   return iError;

} /* end ifnConsultaFechaTermino */


/* ============================================================================= */
/*  ifnFecMorosidad                                                              */
/* ============================================================================= */
int ifnFecMorosidad(long lCodCliente, char *sCodEntidad)
{	
char   modulo[]="ifnFecMorosidad";
int    iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
  long   lhCodCliente   ;
  int    ihExiste       ;
  char   shCodEntidad [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 
    
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);        
   memset(shCodEntidad,'\0',sizeof(shCodEntidad));
   strcpy(shCodEntidad, sCodEntidad);                                               
   lhCodCliente = lCodCliente;              
                       
   /* EXEC SQL                       
   SELECT COUNT(1)
     INTO :ihExiste
     FROM CO_MOROSOS 
    WHERE COD_CLIENTE = :lhCodCliente
      AND COD_AGENTE  = :shCodEntidad; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(1) into :b0  from CO_MOROSOS where (COD_CLIEN\
TE=:b1 and COD_AGENTE=:b2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )209;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihExiste;
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
   sqlstm.sqhstv[2] = (unsigned char  *)shCodEntidad;
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


                    
   if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En SELECT COD_CLIENTE FROM CO_MOROSOS - %s", LOG00, SQLERRM );
	  return -1;				
   }
	           	
   iError = ihExiste; 

   ifnTrazasLog( modulo, " ihExiste [%ld]", LOG09,ihExiste);                      
	           	
   return iError;

} /* end ifnFecMorosidad */


/* ============================================================================= */
/*  ifnMontoPago                                                                 */
/* ============================================================================= */
int ifnMontoPago(long lCodCliente, char *sRango1, char *sRango2)
{	
char   modulo[]="ifnMontoPago";
int    iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
  long   lhCodCliente   ;
  char   shFecInicio [17]; /* EXEC SQL VAR shFecInicio   IS STRING(17); */ 

  char   shFecTermino[17]; /* EXEC SQL VAR shFecTermino  IS STRING(17); */ 

  double dhMontoPago;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
   lhCodCliente = lCodCliente;              
   strcpy(shFecInicio  , sRango1);                              
   strcpy(shFecTermino , sRango2 );                              
                       
   ifnTrazasLog( modulo, " shFecInicio  [%s]", LOG09,shFecInicio);                      
   ifnTrazasLog( modulo, " shFecTermino [%s]", LOG09,shFecTermino);                      
                       
   /* EXEC SQL                       
   SELECT NVL(SUM(IMP_PAGO),0)
     INTO :dhMontoPago
     FROM CO_PAGOS
    WHERE COD_CLIENTE = :lhCodCliente
      AND FEC_EFECTIVIDAD BETWEEN TO_DATE(:shFecInicio, :szhYYYYMMDDHH24MISS) AND TO_DATE(:shFecTermino, :szhYYYYMMDDHH24MISS)      
      AND COD_TIPDOCUM IN (8,9,25,83); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(sum(IMP_PAGO),0) into :b0  from CO_PAGOS where \
((COD_CLIENTE=:b1 and FEC_EFECTIVIDAD between TO_DATE(:b2,:b3) and TO_DATE(:b4\
,:b3)) and COD_TIPDOCUM in (8,9,25,83))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )236;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhMontoPago;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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
   sqlstm.sqhstv[2] = (unsigned char  *)shFecInicio;
   sqlstm.sqhstl[2] = (unsigned long )17;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[3] = (unsigned long )17;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)shFecTermino;
   sqlstm.sqhstl[4] = (unsigned long )17;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[5] = (unsigned long )17;
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

       
                    
   if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En SELECT SUM(IMP_PAGO) FROM CO_PAGOS - %s", LOG00, SQLERRM );
	  return -1;				
   }
	           	
   sthEntidad.dMonto[lIndCobex] = sthEntidad.dMonto[lIndCobex] + dhMontoPago;	           	

   ifnTrazasLog( modulo, " dhMontoPago [%.2f]", LOG09,dhMontoPago);                      
   	           	
   return iError;

} /* end ifnMontoPago */

/* ============================================================================= */
/*  ifnFecHistoricoMoroso                                                        */
/* ============================================================================= */
int ifnFecHistoricoMoroso(long lCodCliente, char *sFechaInicio, char *sFechaFinal, char *sFechaHistorico, char *sCodEntidad)
{	
char   modulo[]="ifnFecHistoricoMoroso";
int    iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
  long   lhCodCliente     ;
  char   shFecInicio   [17]; /* EXEC SQL VAR shFecInicio     IS STRING(17); */ 

  char   shFecFinal    [17]; /* EXEC SQL VAR shFecFinal      IS STRING(17); */ 

  char   shFecHistorico[17]; /* EXEC SQL VAR shFecHistorico  IS STRING(17); */ 

  char   shCodEntidad   [6]; /* EXEC SQL VAR shCodEntidad    IS STRING(6); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
   lhCodCliente = lCodCliente;              
   strcpy(shFecInicio  , sFechaInicio);                              
   strcpy(shFecFinal   , sFechaFinal );                              
   strcpy(shCodEntidad , sCodEntidad );                              

   ifnTrazasLog( modulo, " shFecInicio [%s]", LOG09,shFecInicio);                      
   ifnTrazasLog( modulo, " sFechaFinal [%s]", LOG09,sFechaFinal);                      
                       
   /* EXEC SQL                       
   SELECT TO_CHAR(FEC_HISTORICO, :szhYYYYMMDDHH24MISS)
     INTO :shFecHistorico
     FROM CO_HMOROSOS     
    WHERE COD_CLIENTE = :lhCodCliente
      AND FEC_INGRESO BETWEEN TO_DATE(:shFecInicio, :szhYYYYMMDDHH24MISS) AND TO_DATE(:shFecFinal, :szhYYYYMMDDHH24MISS)
      AND COD_AGENTE  = :shCodEntidad; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 8;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TO_CHAR(FEC_HISTORICO,:b0) into :b1  from CO_HMOROS\
OS where ((COD_CLIENTE=:b2 and FEC_INGRESO between TO_DATE(:b3,:b0) and TO_DAT\
E(:b5,:b0)) and COD_AGENTE=:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )275;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[0] = (unsigned long )17;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shFecHistorico;
   sqlstm.sqhstl[1] = (unsigned long )17;
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
   sqlstm.sqhstv[3] = (unsigned char  *)shFecInicio;
   sqlstm.sqhstl[3] = (unsigned long )17;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[4] = (unsigned long )17;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)shFecFinal;
   sqlstm.sqhstl[5] = (unsigned long )17;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhYYYYMMDDHH24MISS;
   sqlstm.sqhstl[6] = (unsigned long )17;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)shCodEntidad;
   sqlstm.sqhstl[7] = (unsigned long )6;
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


                          
   if(( SQLCODE != SQLOK) && (SQLCODE  != SQLNOTFOUND)) {
	  ifnTrazasLog( modulo, "\t En SELECT FEC_HISTORICO FROM CO_HMOROSOS - %s", LOG00, SQLERRM );
	  return -1;				
   }
	
   if( SQLCODE == SQLNOTFOUND) {
       strcpy(sFechaHistorico, sFechaFinal);                              
   } else  {	           	
       strcpy(sFechaHistorico, shFecHistorico);                              
   }

   ifnTrazasLog( modulo, " shFecHistorico [%s]", LOG09,shFecHistorico);                      
	           	
   return iError;

} /* end ifnFecHistoricoMoroso */

/* ============================================================================= */
/*  ifnGeneraArchivos() : Funcion que rescata los datos de la empresa de cobranza*/
/* ============================================================================= */
int ifnGeneraArchivos()
{
char modulo[]= "ifnGeneraArchivos";
int  iError  = 0 ;     
int  i           ;   
int  iTitulo   = 0;

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      

    for (i=0;i<=lIndCobex;i++)   {

		if (iTitulo == 0) {
           if ( (fprintf( ArchPag, "ENTIDAD|MONTO\n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);			    
				return FALSE;            			
			}		    	
			iTitulo = 1;
      	}
       	
        ifnTrazasLog(modulo, "sthEntidad.sCodAgente   [i] [%s]", LOG09, sthEntidad.sCodAgente[i]);
        ifnTrazasLog(modulo, "sthEntidad.sDesAgente   [i] [%s]", LOG09, sthEntidad.sDesAgente[i]);
        ifnTrazasLog(modulo, "sthEntidad.dMonto       [i] [%.2f]", LOG09, sthEntidad.dMonto[i]);
        
           /*                   1   |  2  |  3 */
        if( (fprintf( ArchPag, "%s %s %s %s %.2f \n"
                            ,sthEntidad.sCodAgente[i]
                            ,szPipe
                            ,sthEntidad.sDesAgente[i]
                            ,szPipe
                            ,sthEntidad.dMonto[i]                                 
              		)   ) == -1 ){	
		   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
		   return FALSE;            			
		 }
				 				 				             
    } /* end for lIndCobex */			
            	
    return iError;

} /* end ifnGeneraArchivos */

/****************************************************************************/
/*   Rutina que rescata el valor de una variable de Ambiente Host           */
/****************************************************************************/
char* szGetEnv(char * VarHost)
{
    char *ValVarHost;

    ValVarHost=(char *)malloc(1024);
    if (getenv(VarHost) == NULL)
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\t  No Existe Variable de Ambiente %s    "
                "\n\t-------------------------------------------------------\n",
                VarHost);
        return ((char *) NULL);
    }

    strcpy(ValVarHost,getenv(VarHost));
    return (ValVarHost);
} /* szGetEnv */

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

