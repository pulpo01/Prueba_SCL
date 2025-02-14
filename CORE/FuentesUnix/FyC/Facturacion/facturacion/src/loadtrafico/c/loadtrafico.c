
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
    "./pc/loadtrafico.pc"
};


static unsigned int sqlctx = 27657571;


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
   unsigned char  *sqhstv[5];
   unsigned long  sqhstl[5];
            int   sqhsts[5];
            short *sqindv[5];
            int   sqinds[5];
   unsigned long  sqharm[5];
   unsigned long  *sqharc[5];
   unsigned short  sqadto[5];
   unsigned short  sqtdso[5];
} sqlstm = {12,5};

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
5,0,0,1,83,0,4,361,0,0,3,1,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,
32,0,0,2,0,0,17,407,0,0,1,1,0,1,0,1,97,0,0,
51,0,0,2,0,0,45,450,0,0,0,0,0,1,0,
66,0,0,2,0,0,13,463,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
89,0,0,2,0,0,15,497,0,0,0,0,0,1,0,
104,0,0,3,0,0,21,536,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
131,0,0,3,0,0,17,746,0,0,1,1,0,1,0,1,5,0,0,
150,0,0,4,103,0,6,808,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
173,0,0,5,113,0,6,849,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
196,0,0,6,70,0,6,899,0,0,1,1,0,1,0,1,3,0,0,
215,0,0,7,103,0,6,952,0,0,2,2,0,1,0,2,5,0,0,1,97,0,0,
238,0,0,8,213,0,6,1008,0,0,5,5,0,1,0,2,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
273,0,0,9,157,0,6,1016,0,0,4,4,0,1,0,2,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,
304,0,0,10,73,0,6,1076,0,0,1,1,0,1,0,1,5,0,0,
323,0,0,11,150,0,4,1112,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : loadtrafico.pc                                          * */
/* *  Proceso de "Facturacion de Ciclo"                                 * */
/* *  Autor : Roberto Fica Domke                                        * */
/* ********************************************************************** */
/* *  Creado    :  04 de Abril de 2006                                  * */
/* *                                                                    * */
/* *    Proceso realizado a partir de shell loadtrafico.sh.             * */
/* *    La cual toma el trafico contenido en las TOL_DETFACTURA_0XXX    * */
/* *    de un rango de clientes pertencientes a un ciclo determinado y  * */
/* *    que tengan IND_MASCARA  = 1, insertando estos en la tabla       * */
/* *    PF_TOLTARIFICA y a su vez son eliminados de la tabla            * */
/* *    TOL_DETFACTURA_0XXX                                             * */
/* ********************************************************************** */

#include "loadtrafico.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

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



/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

int main(int argc, char *argv[])
{

    extern  char    *optarg                         ;
    char            opt[]           ="u:c:d:l:"     ;
    int             iOpt            =0              ;


    char            szSysDate[15];
    char            szSysDate2[30];
    char            szComando[1024] = ""            ;
    char            *szExeLoadTrafico = "loadtrafico";
    char            szUsuario [63]  = ""            ;
    char            *psztmp         = ""            ;
    char            szaux     [10]  = ""            ;
    char            *szDirLogs                      ;

    BOOL            bEstadoProc     = FALSE        ;
    BOOL            bOptUsuario     = FALSE        ;

    time_t          tInicio;
    time_t          tFin;
    double          dTiempoSeg      = 0.0;

    clock_t         clInicio;
    clock_t         clFin;
    double          dTiempoCPU      = 0.0;

    time(&tInicio);
    clInicio = clock();

    memset(&stLineaComando  ,0,sizeof(LINEACOMANDO));
    memset(&stTrazaProc     ,0,sizeof(TRAZAPROC))   ;

    stLineaComando.iDigitoCli   = -1;
    stLineaComando.lCodCiclFact = 0;

    stStatus.IdPro        = 0            ;
    stStatus.IdPro2       = 0            ;
    stStatus.ExitApp      = FALSE        ;
    stStatus.ExitCode     = 0            ;
    stStatus.SkipRec      = FALSE        ;
    stStatus.SkipCode     = 0            ;
    stStatus.LogNivel     = iLOGNIVEL_DEF;
    stStatus.LogFile      = (FILE*)NULL  ;
    stStatus.ErrFile      = (FILE*)NULL  ;
    stStatus.OraConnected = 0            ;

    strcpy(szSysDate, cfnGetTime(7));    /* Formato AAAAMMDDHHMMSS */
    strcpy(szSysDate2, cfnGetTime(1));   /* Formato Para Log */

    fprintf (stderr, "\nloadtrafico version [%s] - [%s] \n", __DATE__, __TIME__);

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {   case 'u':
                if (strlen (optarg))
                {
                    strcpy(szUsuario, optarg);
                    bOptUsuario = TRUE;
                    fprintf (stdout," -u %s ", szUsuario);
                }
                break;
            case 'c':
                if (strlen (optarg))
                {
                    strcpy(szaux,optarg);
                    stLineaComando.lCodCiclFact = atol(szaux);
                    fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                }
                break;
            case 'd':
                if (strlen (optarg))
                {
                    stLineaComando.iDigitoCli =
                    (((atoi(optarg) >= 0) && (atoi(optarg) <= 9))? atoi (optarg):-1);
                    fprintf (stdout,"-d %d ", stLineaComando.iDigitoCli);
                }
                break;
            case 'l':
                if (strlen (optarg))
                {
                    stStatus.LogNivel =
                    (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                }
                break;
            default:
                fprintf (stderr, "\n\t# Error en Parametros de Entrada:\n%s\n", szUsage);
                return 1;
        }
    }

    fprintf (stdout,"\n");

    if (stLineaComando.lCodCiclFact == 0)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return -1;
    }

    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  -2;
    }
    else
    {
       if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return -3;
       }
       else
       {
             strncpy (stLineaComando.szUser,szUsuario,psztmp-szUsuario);
             strcpy  (stLineaComando.szPass, psztmp+1)                 ;
       }
    }

    if (stStatus.LogNivel <= 0)
        stStatus.LogNivel = iLOGNIVEL_DEF     ;
    stLineaComando.iNivLog = stStatus.LogNivel;

    if (stLineaComando.iDigitoCli < 0)
    {
        fprintf (stderr, "\n\t# Error Parametros de Entrada iDigitoCli :\n%s\n", szUsage);
        return  -4;
    }


    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return -5;
    }
    else
    {
        fprintf( stderr, "\n\t-------------------------------------------------------"
                         "\n\tConectado a BD ORACLE %s : Usuario %s Passwd xxxxxxxx "
                         "\n\t-------------------------------------------------------\n",(char *)getenv("ORACLE_SID"),
                         stLineaComando.szUser);
    }


    /*** Se obtiene path de creacion del directorio de LOG ***/
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
    {
        fprintf(stderr,"Error: En obtencion de path XPFACTUR_LOG");
        return -6;
    }

    sprintf(stLineaComando.szDirLogs,"%s/loadtrafico/%ld/",szDirLogs,stLineaComando.lCodCiclFact);

    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    free(szDirLogs);

    if (system (szComando))
    {
        fprintf(stderr, "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return -7;
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName, "%sloadtrafico%d_%ld_%s.err",
            stLineaComando.szDirLogs,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return -8;
    }
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%sloadtrafico%d_%ld_%s.log",
            stLineaComando.szDirLogs,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf(stderr,"\n ** Error: No puede abrirse el fichero de log %s\n",stStatus.LogName);
        fclose(stStatus.ErrFile);
        return -9;
    }

    /*********************************************************************************************/
    vDTrazasError(szExeLoadTrafico, "\n\n\t**************************************************************"
                                    "\n\n\t   LoadTrafico version " __DATE__ " " __TIME__ ""
                                    "\n\n\t**************************************************************"
                                    "\n\n\t****     Errores de LoadTrafico " __DATE__ " " __TIME__ " **"
                                    "\n\n\t**************************************************************",
                    LOG03);

    vDTrazasLog(szExeLoadTrafico, "\n\n\t***************************************************************"
                                  "\n\n\t   LoadTrafico version " __DATE__ " " __TIME__ ""
                                  "\n\n\t***************************************************************"
                                  "\n\n\t****        Log   LoadTrafico " __DATE__ " " __TIME__ " **"
                                  "\n\n\t***************************************************************",
                    LOG03);

    vDTrazasLog(szExeLoadTrafico,"\n***  INICIO DE PROCESO %s ***\n"
                                "\n\t\t***  Parametro de Entrada LoadTrafico  ***"
                                "\n\t\t=> Base de Datos [%s]"
                                "\n\t\t=> Usuario       [%s]"
                                "\n\t\t=> Password      [************]"
                                "\n\t\t=> Cod.CiclFact  [%ld]"
                                "\n\t\t=> Niv.Log       [%d]",
                                LOG03,szSysDate2, (char *)getenv("ORACLE_SID"),
                                stLineaComando.szUser,
                                stLineaComando.lCodCiclFact,
                                stLineaComando.iNivLog);


    /*** Llamado a la funcion que carga el trafico  ***/
    bEstadoProc = bfnCargarTrafico();

    if(bEstadoProc == TRUE)
    {
        if (stTrazaProc.lCodCiclFact > 0)
        {

            vDTrazasLog(szExeLoadTrafico, "\n***  PROCESO Terminado con Exito ***"
                                        "\n\t\t***  %s  ***",
                                        LOG03,cfnGetTime(1));

            if (!bfnSelectSysDate(szSysDate))
            {
                vDTrazasLog(szExeLoadTrafico, "\n\t*** Error en bfnSelectSysDate (bfnCargaTraficoCicloFact) ***\n"
                                            , LOG01);
            }
            else
            {
                stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
                strcpy(stTrazaProc.szFecTermino,szSysDate)                              ;
                strcpy(stTrazaProc.szGlsProceso,"Proceso Carga de Trafico Terminado OK");
                stTrazaProc.lNumAbonado        = 0                                      ;
                bPrintTrazaProc(stTrazaProc);
                if (!bfnUpdateTrazaProc(stTrazaProc))
                    return -1;
            }
        }

    }
    else
    {

        if (!bfnSelectSysDate(szSysDate))
            vDTrazasLog(szExeLoadTrafico,"\n\t*** Error en bfnSelectSysDate (main)***\n",LOG01);
        else
        {
            stTrazaProc.iCodEstaProc       = iPROC_EST_ERR                                  ;
            strcpy(stTrazaProc.szFecTermino,szSysDate)                                      ;
            strcpy(stTrazaProc.szGlsProceso,"Proceso Carga de Trafico Terminado con Error") ;
            stTrazaProc.lNumAbonado        = 0                                              ;
            bPrintTrazaProc(stTrazaProc);
            if (!bfnUpdateTrazaProc(stTrazaProc))
                vDTrazasLog(szExeLoadTrafico,"\n\t*** Error en bfnUpdateTrazaProc ***\n",LOG01);

        }


    }

    if (!bfnOraCommit())
    {
        vDTrazasError(szExeLoadTrafico, "\n\tError en COMMIT de Estadisticas"
                                      " bfnOraCargaHistDocu ", LOG01);
        return FALSE;

    }

    time(&tFin);
    clFin = clock();

    dTiempoSeg = difftime(tFin,tInicio);

    dTiempoCPU = ((double) (clFin - clInicio)) / CLOCKS_PER_SEC;

    vDTrazasLog(szExeLoadTrafico, "\n\t* Tiempo Real de Proceso       :\t\t[%10.0f] segundos."
                                "\n\t* Tiempo de CPU para el Proceso:\t\t[%10.0f] segundos."
                                ,LOG03
                                ,dTiempoSeg
                                ,dTiempoCPU);

    fprintf(stdout, "\n\t* Tiempo Real de Proceso       :\t\t[%10.0f] segundos."
                    "\n\t* Tiempo de CPU para el Proceso:\t\t[%10.0f] segundos.\n"
                    ,dTiempoSeg
                    ,dTiempoCPU);

    return 0;

}

/*************************************************************************************************/
/* Cargar el trafico de clientes del ciclo ingresado por linea de comando.                       */
/* @return TRUE Proceso realizado en forma correcta, FALSE si se produjo un error en el proceso. */
/*************************************************************************************************/
BOOL  bfnCargarTrafico(void)
{
    char            *pszModulo   ="bfnCargarTrafico";

    time_t          tTpoCrIndIni;
    time_t          tTpoCrIndFin;

    double          dTpoCrIndSeg = 0.0;


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCiclFact          ;
        long lhMinCodCliente        ;
        long lhMaxCodCliente        ;
        long lhCodCiclo             ;
        int  ihIndTasador           ;
        int  ihDigitoCli            ;
        char szqueryTolDetFac[10000] ; /* EXEC SQL VAR szqueryTolDetFac   IS STRING(10000); */ 
        
        char szqueryMinMax[512]     ;
        long lCantTDF   = 0L        ;  /* Cantidad de filas obtendidas desde la tabla TOL_DETFACTURA_0X */
        int  ihValorUno = 1         ;
        long lcod_CodMegError       ;  /* Recibe el codigo de error de la PL */
        char szmsg_DetMsgError [200];  /* Recibe mensaje error y si esta OK recibe totales registros actualizados */
        long lnum_Evento            ;  /* Recibe numero del evento del error */
    /* EXEC SQL END DECLARE SECTION; */ 

    
    memset(szqueryTolDetFac,'\0',sizeof(szqueryTolDetFac));

    ihDigitoCli = stLineaComando.iDigitoCli;

    /*********** Se obtiene COD_CICLO *************/

    lhCodCiclFact = stLineaComando.lCodCiclFact;

    /* EXEC SQL SELECT COD_CICLO
                   ,IND_TASADOR
               INTO :lhCodCiclo
                   ,:ihIndTasador
               FROM FA_CICLFACT
              WHERE COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,IND_TASADOR into :b0,:b1  from FA_CICLF\
ACT where COD_CICLFACT=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihIndTasador;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(pszModulo, "No existen datos en FA_CICLFACT para Codigo de Ciclo."
                                        "\n\t SQLCODE: [%d]",LOG01, SQLCODE);
        vDTrazasLog  (pszModulo, "No existen datos en FA_CICLFACT para Codigo de Ciclo."
                                        "\n\t SQLCODE: [%d]",LOG01, SQLCODE);
        return FALSE;
    }

    /****************************************************************************/
    /*  Valida Estado del Proceso de Facturacio de Ciclo                        */
    /****************************************************************************/
    if (!bfnValidaTrazaProc(lhCodCiclFact,iPROC_LOADTARIF+stLineaComando.iDigitoCli,iIND_FACT_ENPROCESO))
    {
       return(FALSE);
    }
    else if(!fnOraCommit())
    {
        vDTrazasLog  (szExeLoadTarif, "ERROR AL HACER COMMIT EN FA_CICLOCLI",LOG01);
        vDTrazasError(szExeLoadTarif, "ERROR AL HACER COMMIT EN FA_CICLOCLI",LOG01);
        return (FALSE);

    }

    bfnSelectTrazaProc ( lhCodCiclFact,iPROC_LOADTARIF+stLineaComando.iDigitoCli,&stTrazaProc);
    bPrintTrazaProc(stTrazaProc);


    /**** Cadena de query que permitira obtener el cliente minimo y maximo a procesar ****/
    sprintf(szqueryMinMax,  "SELECT  NVL(MIN(NUM_CLIE),0) "
                            "\n ,NVL(MAX(NUM_CLIE),0)     "
                            "\n FROM TOL_DETFACTURA_0%d   "
                            "\n WHERE COD_CICLFACT = %ld  "
                            , stLineaComando.iDigitoCli
                            , stLineaComando.lCodCiclFact);

    vDTrazasLog  (pszModulo,   "\n QUERY : [%s]", LOG05,szqueryMinMax);

    /*********** Se obtiene minimos y maximos *****/
    /* EXEC SQL PREPARE sql_maxmin_tarificadas FROM :szqueryMinMax; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )32;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szqueryMinMax;
    sqlstm.sqhstl[0] = (unsigned long )512;
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




    if(SQLCODE != SQLOK)
    {
        vDTrazasError(pszModulo,   "\n\t**  Error en SQL-PREPARE MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "
                                        "\n\t\t=> Cod_Ciclfact  [%ld] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,SQLCODE,SQLERRM,szqueryMinMax);
        vDTrazasLog  (pszModulo,   "\n\t**  Error en SQL-PREPARE MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "
                                        "\n\t\t=> Tipo Tasacion [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,SQLCODE,SQLERRM,szqueryMinMax);

        return (FALSE);
    }


    /* EXEC SQL DECLARE CursorMaxMin CURSOR FOR sql_maxmin_tarificadas; */ 


    if( SQLCODE != SQLOK)
    {
        vDTrazasError(pszModulo,   "\n\t**  Error en SQL-DECLARE Cursor MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "
                                        "\n\t\t=> Cod_Ciclfact  [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,SQLCODE,SQLERRM,szqueryMinMax);
        vDTrazasLog  (pszModulo,   "\n\t**  Error en SQL-DECLARE Cursor MaxMin  **"
                                        "\n\t\t=> Digito        [%d] "
                                        "\n\t\t=> Cod_Ciclfact  [%d] "
                                        "\n\t\t=> Error : [%d]  [%s] "
                                        "\n\t\t=> QUERY : [%s]\n"
                                        ,LOG01,stLineaComando.iDigitoCli,stLineaComando.lCodCiclFact,SQLCODE,SQLERRM,szqueryMinMax);

        return (FALSE);
    }


    /* EXEC SQL OPEN CursorMaxMin; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )51;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (pszModulo , "<< En OPEN del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(pszModulo , "<< En OPEN del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);

        return (FALSE);
    }


    /* EXEC SQL FETCH CursorMaxMin INTO :lhMinCodCliente, :lhMaxCodCliente ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhMinCodCliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhMaxCodCliente;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (pszModulo,   "\n\t** No Existen Datos en TOL_DETFACTURA_0%d Para Facturar **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]", LOG01, ihDigitoCli, lhCodCiclo,ihDigitoCli);
        vDTrazasError(pszModulo,   "\n\t** No Existen Datos en TOL_DETFACTURA_0%d Para Facturar **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        "\n\t\t=> Digito Cliente        [%d]", LOG01, ihDigitoCli, lhCodCiclo,ihDigitoCli);

        return TRUE;
    }
    else
    {
        if(SQLCODE != SQLOK)
        {
            vDTrazasLog  (pszModulo,   "\n\t**  Error en Select sobre TOL_DETFACTURA_0%d_TEMP  **"
                                            "\n\t\t=> Codigo de Ciclo       [%ld]"
                                            "\n\t\t=> Digito Cliente        [%d]"
                                            "\n\t\t=> Error Oracle          [%d]"
                                            "\n\t\t=> Error Oracle          [%s]"
                                            ,LOG01,ihDigitoCli, lhCodCiclo,ihDigitoCli,SQLCODE,SQLERRM);
            vDTrazasError(pszModulo,   "\n\t**  Error en Select sobre TOL_DETFACTURA_0%d_TEMP  **"
                                            "\n\t\t=> Codigo de Ciclo       [%ld]"
                                            "\n\t\t=> Digito Cliente        [%d]"
                                            "\n\t\t=> Error Oracle          [%d]"
                                            "\n\t\t=> Error Oracle          [%s]"
                                            ,LOG01,ihDigitoCli, lhCodCiclo,ihDigitoCli,SQLCODE,SQLERRM);

            return (FALSE);
        }
    }

    /* EXEC SQL CLOSE CursorMaxMin ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )89;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (pszModulo , "<< En CLOSE del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(pszModulo , "<< En CLOSE del Cursor MaxMin >>"
                               "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    if(lhMinCodCliente==0 || lhMaxCodCliente==0)
    {
         vDTrazasLog   (pszModulo, "\n\t*** NO HAY Rangos de codigos de clientes para procesar, TERMINA PROCESO... ***",LOG03);
         vDTrazasError (pszModulo, "\n\t*** NO HAY Rangos de codigos de clientes para procesar, TERMINA PROCESO... ***",LOG03);
         return (TRUE);
    }

    vDTrazasLog  (pszModulo,   "\n lhMinCodCliente  [%d] lhMaxCodCliente [%d]\n", LOG05,lhMinCodCliente, lhMaxCodCliente);

    /*** Preparar Consultas Dinamicas ***/
    if( !bfnPrepararConsultasSQL(szqueryTolDetFac) )
    {
        vDTrazasLog  (pszModulo , "<< En funcion bfnPrepararConsultasSQL() >>", LOG01);
        vDTrazasError(pszModulo , "<< En funcion bfnPrepararConsultasSQL() >>", LOG01);

        return FALSE;

    }

    /*** Ejecucion de Query Preparada en bfnPrepararConsultasSQL() ***/
    vDTrazasLog  (pszModulo,   "INFO (%s) Ejecucion de cursor queryTolDetFac USING [%ld] [%ld] [%ld]"
                           , LOG05
                           , pszModulo
                           , lhCodCiclo
                           , ihValorUno
                           , lhCodCiclFact);

    /* EXEC SQL EXECUTE queryTolDetFac USING :lhCodCiclo,  :ihValorUno, :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )104;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihValorUno;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



    if( SQLCODE != SQLOK)
    {
        vDTrazasError(pszModulo, "\n\t**  Error en SQL-EXECUTE TOL_DETFACTURA  **"
                                 "\n\t\t=> digito        [%d] "
                                 "\n\t\t=> Cod. ciclfact [%ld] "
                                 "\n\t\t=> Error : [%d]  [%s] "
                                 "\n\t\t=> QUERY : [%s]\n"
                               , LOG01,stLineaComando.iDigitoCli, lhCodCiclFact, SQLCODE
                               , SQLERRM, szqueryTolDetFac);
       vDTrazasLog   (pszModulo, "\n\t**  Error en SQL-EXECUTE TOL_DETFACTURA  **"
                                 "\n\t\t=> Cod_Ciclo     [%d] "
                                 "\n\t\t=> Cod. ciclfact [%ld] "
                                 "\n\t\t=> Error : [%d]  [%s] "
                                 "\n\t\t=> QUERY : [%s]\n"
                               , LOG01,stLineaComando.iDigitoCli, lhCodCiclFact, SQLCODE
                               , SQLERRM, szqueryTolDetFac);
       fnOraRollBack();
       return (FALSE);
    }

    /* Obtencion de registros insertados por queryTolDetFac */
    lCantTDF = (long)sqlca.sqlerrd[2];

    vDTrazasLog  (pszModulo, "INFO (%s) Registros Insertados con queryTolDetFac CicloFact [%ld] : [%ld]"
                           , LOG05
                           , pszModulo
                           , lhCodCiclFact
                           , lCantTDF);

    stTrazaProc.lCodCliente        = 0;
    stTrazaProc.lNumRegistros      = lCantTDF;

    if ( !bfnOraCommit())
    {
       vDTrazasLog  (pszModulo , "<< En Commit >>"
                                      "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
       vDTrazasError(pszModulo , "<< En Commit  >>"
                                      "\n\t\t=> Detalle : %d %s \n",LOG01,SQLCODE,SQLERRM);
       fnOraRollBack();
       return (FALSE);
    }

    /* Llamado a PL de marca de llamadas */
    /*if(NoExistenProcesosActuales())
    {
        EXEC SQL EXECUTE
        BEGIN
            FA_MARCALLAM_PG.FA_MARCADET_PR(:lhCodCiclFact, 0, :lcod_CodMegError, :szmsg_DetMsgError, :lnum_Evento);
        END;
        END-EXEC;

        if(SQLCODE != SQLOK  || lcod_CodMegError != 0)
        {
            vDTrazasError  ( szExeLoadTarif ,"\n**  Error en Funcion FA_MARCADET_PR( ) **"
                                 " [%d]  [%s]",LOG01,SQLCODE,SQLERRM);

            vDTrazasLog    (szExeLoadTarif, "\n**  Error en Funcion FA_MARCADET_PR( ) **"
                                       "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                       "\n\t\t\t=> cod_CodMegError... [%ld]"
                                       "\n\t\t\t=> szmsg_DetMsgError. [%s]"
                                       "\n\t\t\t=> lnum_Evento....... [%ld] )"
                                       ,LOG01,lhCodCiclFact, lcod_CodMegError,szmsg_DetMsgError,lnum_Evento);

            return(FALSE);
        }

        vDTrazasLog    (szExeLoadTarif, "\n** Funcion FA_MARCADET_PR( ) termina OK**"
                                       "\n\t\t\t=> lhCodCiclFact..... [%ld]"
                                       "\n\t\t\t=> :szmsg_DetMsgError... [%s]"
                                      ,LOG01,lhCodCiclFact, szmsg_DetMsgError);

    }
    else
    {
        vDTrazasLog(szExeLoadTarif,  "\n\t** Proceso no llama a FA_MARCALLAM_PG.FA_MARCADET_PR"
                                     "\n\t** Lo realiza ultimo proceso loadtrafico."
                                     ,LOG03);
    }*/ /* P-MIX-09003 137725 */
    
    /*** Creacion de indices en PF_TOLTARIFICA ***/
    time(&tTpoCrIndIni);
    if ( !bfnCreateIndexPF(ihIndTasador) )
    {
         vDTrazasLog(pszModulo, "\n\t***  Error al crear indice TOL ***",LOG03 );
         return (FALSE);
    }
    else
    {
         vDTrazasLog(pszModulo, "\n\t***  Indice TOL Creado Correctamente ***",LOG03 );
    }

    time(&tTpoCrIndFin);

    dTpoCrIndSeg = difftime(tTpoCrIndFin, tTpoCrIndIni);
    vDTrazasLog(pszModulo, "\n\t* Tiempo Utilizado en Creacion de Indices :\t[%10.0f] segundos."
                         , LOG03
                         , dTpoCrIndSeg);

    return TRUE;
}

/***********************************************************************************************/
/* Preparacion de consultas dinamicas SQL a utilizar en el programa.                           */
/* @param   pszQueryDetalle cadena que contendrá consulta de insercion en PF_TOLTARIFICA       */
/* @param   pzsQueryDelete  cadena que contendrá instruccion de borrado de datos traspasados a */
/*                          PF_TOLTARIFICA desde TOL_DETFACTURA_0X.                            */
/* @return  TRUE si la operacion es exitosa, FALSE de lo contrario.                            */
/***********************************************************************************************/
BOOL bfnPrepararConsultasSQL(char *pszQueryDetalle)
{
    char *pszModulo = "bfnPrepararConsultasSQL";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char pszhQueryDetalle[10000] ; /* EXEC SQL VAR pszhQueryDetalle   IS STRING(10000); */ 
        
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(pszhQueryDetalle,'\0',sizeof(pszhQueryDetalle));

    /**** Cadena de query que permitira insertar el trafico de un cliente ****/
    sprintf(pszhQueryDetalle  , "INSERT INTO PF_TOLTARIFICA_%ld("
                                    "\n SEC_EMPA,SEC_CDR,"
                                    "\n RECORD_TYPE,A_SUSC_NUMBER,"
                                    "\n A_SUSC_MS_NUMBER,B_SUSC_NUMBER,"
                                    "\n B_SUSC_MS_NUMBER,A_CATEGORY,"
                                    "\n IND_BILLETE,DATE_START_CHARG,"
                                    "\n TIME_START_CHARG,CHARGABLE_DURAT,"
                                    "\n DATE_SEND_CHARG,TIME_SEND_CHARG,"
                                    "\n SEND_DURAT,COD_CCC,"
                                    "\n OUTGOING_ROUTE,INCOMING_ROUTE,"
                                    "\n INSI_CODE,COD_AGRL,"
                                    "\n COD_SENT,COD_LLAM,"
                                    "\n COD_TDIR,COD_TCOR,"
                                    "\n COD_THOR,COD_TDIA,"
                                    "\n COD_FCOB,IND_TABLA,"
                                    "\n COD_CARG,COD_CARR,"
                                    "\n COD_GRUPO,NUM_CLIE,"
                                    "\n NUM_ABON,COD_PLAN,"
                                    "\n COD_CICL,COD_CICLFACT,"
                                    "\n COD_AREAC,COD_ALMC,"
                                    "\n COD_LIMITE,IND_APLICA,"
                                    "\n COD_BOLSA,IND_APLB,"
                                    "\n COD_OPERA,COD_TOPRA,"
                                    "\n COD_DOPERA,COD_TRANA,"
                                    "\n COD_ALMA,COD_AREAA,"
                                    "\n COD_LOCAA,COD_OPERB,"
                                    "\n COD_TOPRB,COD_DOPEB,"
                                    "\n COD_TRANB,COD_ALMB,"
                                    "\n COD_AREAB,COD_LOCAB,"
                                    "\n COD_PAIS,COD_SUBFRANJA,"
                                    "\n IND_DCTO_MLIB,IND_MUESTRA_LLAM,"
                                    "\n DUR_REAL,NUM_PULSO,"
                                    "\n DUR_FACT,TIP_MONE,"
                                    "\n MTO_REAL,TIP_DCTO,"
                                    "\n COD_DCTO,ITM_DCTO,"
                                    "\n DUR_DCTO,MTO_FACT,"
                                    "\n MTO_DCTO,IND_EXEDENTE,"
                                    "\n COD_UMBRAL,DES_DESTINO,"                                    
                                    "\n DES_LLAMADA)"
                               "\n SELECT /*+ index(AK_FA_CICLOCLI_CICLO CLI)*/ "
                                   "\n DET.SEC_EMPA ,DET.SEC_CDR ,"
                                   "\n DET.RECORD_TYPE,DET.A_SUSC_NUMBER,"
                                   "\n DET.A_SUSC_MS_NUMBER,DET.B_SUSC_NUMBER,"
                                   "\n DET.B_SUSC_MS_NUMBER,DET.A_CATEGORY,"
                                   "\n DET.IND_BILLETE,DET.DATE_START_CHARG,"
                                   "\n DET.TIME_START_CHARG,DET.CHARGABLE_DURAT,"
                                   "\n DET.DATE_SEND_CHARG,DET.TIME_SEND_CHARG,"
                                   "\n DET.SEND_DURAT,DET.COD_CCC,"
                                   "\n DET.OUTGOING_ROUTE,DET.INCOMING_ROUTE,"
                                   "\n DET.INSI_CODE,DET.COD_AGRL,"
                                   "\n DET.COD_SENT,DET.COD_LLAM,"
                                   "\n DET.COD_TDIR,DET.COD_TCOR,"
                                   "\n DET.COD_THOR,DET.COD_TDIA,"
                                   "\n DET.COD_FCOB,DET.IND_TABLA,"
                                   "\n DET.COD_CARG,DET.COD_CARR,"
                                   "\n DET.COD_GRUPO,DET.NUM_CLIE,"
                                   "\n DET.NUM_ABON,DET.COD_PLAN,"
                                   "\n DET.COD_CICL,DET.COD_CICLFACT,"
                                   "\n DET.COD_AREAC,DET.COD_ALMC,"
                                   "\n DET.COD_LIMITE,DET.IND_APLICA,"
                                   "\n DET.COD_BOLSA,DET.IND_APLB,"
                                   "\n DET.COD_OPERA,DET.COD_TOPRA,"
                                   "\n DET.COD_DOPERA,DET.COD_TRANA,"
                                   "\n DET.COD_ALMA,DET.COD_AREAA,"
                                   "\n DET.COD_LOCAA,DET.COD_OPERB,"
                                   "\n DET.COD_TOPRB,DET.COD_DOPEB,"
                                   "\n DET.COD_TRANB,DET.COD_ALMB,"
                                   "\n DET.COD_AREAB,DET.COD_LOCAB,"
                                   "\n DET.COD_PAIS,DET.COD_SUBFRANJA,"
                                   "\n DET.IND_DCTO_MLIB,DET.IND_MUESTRA_LLAM,"
                                   "\n DET.DUR_REAL,DET.NUM_PULSO,"
                                   "\n DET.DUR_FACT,DET.TIP_MONE,"
                                   "\n DET.MTO_REAL,DET.TIP_DCTO,"
                                   "\n DET.COD_DCTO,DET.ITM_DCTO,"
                                   "\n DET.DUR_DCTO,DET.MTO_FACT,"
                                   "\n DET.MTO_DCTO,DET.IND_EXEDENTE,"
                                   "\n DET.COD_UMBRAL,DET.DES_DESTINO,"
                                   "\n DET.DES_LLAMADA"
                               "\n FROM TOL_DETFACTURA_0%d DET, FA_CICLOCLI CLI"
                               "\n WHERE DET.NUM_CLIE   = CLI.COD_CLIENTE"
                               "\n AND DET.NUM_ABON     = CLI.NUM_ABONADO"
                               "\n AND CLI.COD_CICLO    = :v1"
                               "\n AND CLI.IND_MASCARA  = :v2" 
                               "\n AND DET.COD_CICLFACT = :v3"
                               ,stLineaComando.lCodCiclFact
                               ,stLineaComando.iDigitoCli);

    vDTrazasLog  (pszModulo,   "\n QUERY : [%s] \n", LOG05,pszhQueryDetalle);

    /* EXEC SQL PREPARE queryTolDetFac FROM :pszhQueryDetalle; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )131;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)pszhQueryDetalle;
    sqlstm.sqhstl[0] = (unsigned long )10000;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasError(pszModulo,  "\n\t**  En SQL-PREPARE TOL_DETFACTURA_0%d  **"
                                  "\n\t\t=> Error : [%d]  [%s] "
                                  , LOG01
                                  , stLineaComando.iDigitoCli
                                  , SQLCODE
                                  , SQLERRM);

        vDTrazasLog  (pszModulo,  "\n\t**  En SQL-PREPARE TOL_DETFACTURA_0%d  **"
                                  "\n\t\t=> Error : [%d]  [%s] "
                                  , LOG01
                                  , stLineaComando.iDigitoCli
                                  , SQLCODE
                                  , SQLERRM);
        fnOraRollBack();
        return FALSE;
    }
    
    strcpy (pszQueryDetalle,pszhQueryDetalle);

    return TRUE;

}

/***********************************************************************************/
/* Elimina Indice PK_PF_TARIFICADAS de tabla PF_TARIFICADAS                        */
/* @param   iIndTasacion  Indicador de tipo de tasador.                            */
/* @return  TRUE si la operacion es realizada con exito, FALSE en caso contrario.  */
/***********************************************************************************/
BOOL bfnDropIndexPF(int iIndTasacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhTabla[4096];
    char szhIndice[50];
    char szhCadenaIndice  [1024]; /* EXEC SQL VAR szhCadenaIndice   IS STRING(1024); */ 

    char szhCadenaCreacion[1024]; /* EXEC SQL VAR szhCadenaCreacion IS STRING(1024); */ 

    int  ihIndTasacion;
    long lhCodCiclFact =0;
    /* EXEC SQL END DECLARE SECTION; */ 


    FILE *fp_tmp;
    char szhCadenaAux1[1024];
    char szhCadenaAux2[1024];
    char szhCadenaResultado[8192];
    char szhAux[1024];
    char szArchivoTmp[1024];


    register int iCont;
    int iPos;

    ihIndTasacion = iIndTasacion;
    vDTrazasLog(szExeLoadTarif,   "\n\t**IND_TASADOR [%d]\n", LOG03,ihIndTasacion);

    lhCodCiclFact=stLineaComando.lCodCiclFact;

    sprintf(szhTabla,"PF_TOLTARIFICA_%ld",lhCodCiclFact);
    vDTrazasLog(szExeLoadTarif,   "\n\t**TABLA NUEVA [%s]\n", LOG03,szhTabla);

    /* EXEC SQL EXECUTE
        BEGIN
            :szhCadenaIndice := ltrim(rtrim(FA_UTILFAC_PG.FA_BUSCA_INDICES_FN(:szhTabla)));
        END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szhCadenaIndice := ltrim ( rtrim ( FA_UTILFAC_PG .\
 FA_BUSCA_INDICES_FN ( :szhTabla ) ) ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )150;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaIndice;
    sqlstm.sqhstl[0] = (unsigned long )1024;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhTabla;
    sqlstm.sqhstl[1] = (unsigned long )4096;
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




    if ( SQLCODE != SQLOK )
    {
       if (( SQLCODE != SQLNOTFOUND )&&  (SQLCODE != -904)&& (SQLCODE != -1405))
       {
           fprintf(stderr,"\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n",szhTabla,SQLCODE,SQLERRM);
           vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
           vDTrazasError(szExeLoadTarif, "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
           return (FALSE);
       }
       else
       {
           vDTrazasLog(szExeLoadTarif,"\n\t** Tabla [%s] sin indices\n", LOG03,szhTabla);
           return (TRUE);
       }

    }

    iPos=0;
    sprintf(szhCadenaAux1,"%s",szhCadenaIndice);
    szArchivoTmp[0]='\0';
    sprintf(szArchivoTmp,"%s%cloadtarif_%ld.tmp",(char *)getenv("XPF_TMP"),'/',lhCodCiclFact);

    szhCadenaResultado[0]='\0';
    while (strlen(szhCadenaAux1) > 0)
    {
        for (iCont=0;iCont < strlen(szhCadenaAux1); iCont++)
            if (szhCadenaAux1[iCont] == ':')
            {
                iPos=iCont;
                break;
            }
        sprintf(szhIndice,"%*.*s",1,iPos,szhCadenaAux1);
        vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s]\n", LOG03, szhIndice);

        /* EXEC SQL EXECUTE
            BEGIN
                :szhCadenaCreacion := ltrim(rtrim(FA_UTILFAC_PG.FA_OBTIENE_DESC_INDICES_FN(:szhIndice)));
            END;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin :szhCadenaCreacion := ltrim ( rtrim ( FA_UTILFA\
C_PG . FA_OBTIENE_DESC_INDICES_FN ( :szhIndice ) ) ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )173;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaCreacion;
        sqlstm.sqhstl[0] = (unsigned long )1024;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhIndice;
        sqlstm.sqhstl[1] = (unsigned long )50;
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



        if ( SQLCODE != SQLOK )
        {
            if ( SQLCODE != SQLNOTFOUND )
            {
                fprintf(stderr,"\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n",szhIndice,SQLCODE,SQLERRM);
                vDTrazasLog(szExeLoadTarif,   "\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                vDTrazasError(szExeLoadTarif,   "\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                return (TRUE);
            }
            else
            {
                vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s] ya no existe\n", LOG03,szhIndice);
                return (TRUE);
            }
        }
        sprintf(szhCadenaAux2,"%s", szhCadenaCreacion);
        vDTrazasLog(szExeLoadTarif,"\n\t** Descripcion [%s]\n", LOG03, szhCadenaAux2);
        sprintf(szhCadenaResultado,"%s%s%c",szhCadenaResultado,szhCadenaAux2,':');
        szhAux[0]='\0';
        for (iCont=iPos+1;iCont < strlen(szhCadenaAux1); iCont++)
            sprintf(szhAux,"%s%c",szhAux,szhCadenaAux1[iCont]);
        sprintf(szhAux,"%s%c",szhAux,'\0');
        strcpy(szhCadenaAux1,szhAux);
    }
    szCadenaCreateIndex[0]='\0';
    sprintf(szCadenaCreateIndex,"%s\0",szhCadenaResultado);

    if ((fp_tmp = fopen (szArchivoTmp,"w"))==NULL)
    {
        vDTrazasError(szExeLoadTarif,"\n\t** ERROR No puede generar archivo %s \n", LOG01,szArchivoTmp);
        return FALSE;
    }

    fprintf(fp_tmp,"%s",szCadenaCreateIndex);
    fflush(fp_tmp);
    fclose(fp_tmp);

    lLargoCadenaCreateIndex = strlen(szhCadenaResultado);
    vDTrazasLog(szExeLoadTarif,"\n\t** Obtiene Correctamente Sentencias para Crear indice \n\t[%s]"
                              , LOG03
                              , szCadenaCreateIndex);


    vDTrazasLog(szExeLoadTarif,   "\n\t**TABLA [%s]\n", LOG03,szhTabla);
    /* EXEC SQL EXECUTE
      BEGIN
        FA_UTILFAC_PG.FA_DESECHA_INDICES_PR(:ihIndTasacion);
      END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin FA_UTILFAC_PG . FA_DESECHA_INDICES_PR ( :ihIndTasac\
ion ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )196;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIndTasacion;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



    if (SQLCODE != SQLOK && SQLCODE != SQLINDEXNOEXIST )
    {
       fprintf(stderr,"\n\t** ERROR el ELIMINAR indices de %s %d %s\n",szhTabla,SQLCODE,SQLERRM);
       vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al ELIMINAR indices de %s %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
       vDTrazasError(szExeLoadTarif, "\n\t** ERROR al ELIMINAR indices de %s %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
       return (FALSE);
    }
    return (TRUE);
}

/**********************************************************************************/
/* Creacion de indices en la tabla PF_TOLTARIFICA                                 */
/* @param   iIndTasacion  Indicador de tipo de tasador.                           */
/* @return  TRUE si la operacion es realizada con exito, FALSE en caso contrario. */
/**********************************************************************************/
BOOL bfnCreateIndexPF(int iIndTasacion)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCadenaCreateIndex[4096]; /* EXEC SQL VAR szhCadenaCreateIndex   IS STRING(4096); */ 

        char szhCadenaResultado[4096]; /* EXEC SQL VAR szhCadenaResultado   IS STRING(4096); */ 

        long lhCodCiclFact=0;
        char szhCadenaIndice  [1024]; /* EXEC SQL VAR szhCadenaIndice   IS STRING(1024); */ 

        char szhTolTarifica[1024]; /* EXEC SQL VAR szhTolTarifica  IS STRING(1024); */ 

        char szhTablaCiclo[1024]; /* EXEC SQL VAR szhTablaCiclo  IS STRING(1024); */ 

        char szhIndice[50];/* EXEC SQL VAR szhIndice  IS STRING(50); */ 

        char szhIndiceCiclFact[50];/* EXEC SQL VAR szhIndiceCiclFact  IS STRING(50); */ 


    /* EXEC SQL END DECLARE SECTION; */ 

    char  szhTabla[1024];
    char  szhCadenaAux1[8192];
    char  szhCadenaAux2[8192];
    char szhAux[1024];
    char szhIndice_aux[50];    
    char szhIndiceCiclFact_aux[50];      

    int  iCont;
    int  iPos;

    lhCodCiclFact=stLineaComando.lCodCiclFact;
    if(NoExistenProcesosActuales())
    {    	    
            strcpy(szhTabla           , "PF_TOLTARIFICA");
            strcpy(szhTolTarifica     , "PF_TOLTARIFICA");
            vDTrazasLog(szExeLoadTarif, "\n\t**TABLA NUEVA [%s]\n", LOG03,szhTabla);
            sprintf(szhTablaCiclo     , "PF_TOLTARIFICA_%ld",lhCodCiclFact);
            vDTrazasLog(szExeLoadTarif, "\n\t** Creando Indice con TABLA [%s]\n", LOG03,szhTabla);             

            /* EXEC SQL EXECUTE
                BEGIN
                    :szhCadenaIndice := ltrim(rtrim(FA_UTILFAC_PG.FA_BUSCA_INDICES_FN(:szhTabla)));
                END;
            END-EXEC; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 3;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "begin :szhCadenaIndice := ltrim ( rtrim ( FA_UTIL\
FAC_PG . FA_BUSCA_INDICES_FN ( :szhTabla ) ) ) ; END ;";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )215;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaIndice;
            sqlstm.sqhstl[0] = (unsigned long )1024;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhTabla;
            sqlstm.sqhstl[1] = (unsigned long )1024;
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



            if ( SQLCODE != SQLOK )
            {
               if (( SQLCODE != SQLNOTFOUND )&&  (SQLCODE != -904)&& (SQLCODE != -1405))
               {
                   fprintf(stderr,"\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n",szhTabla,SQLCODE,SQLERRM);
                   vDTrazasLog(szExeLoadTarif,   "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
                   vDTrazasError(szExeLoadTarif, "\n\t** ERROR al BUSCAR indices de Tabla [%s] %d %s\n", LOG01,szhTabla,SQLCODE,SQLERRM);
                   return (FALSE);
               }
               else
               {
                   vDTrazasLog(szExeLoadTarif,"\n\t** Tabla [%s] sin indices\n", LOG03,szhTabla);
                   return (TRUE);
               }

            }

            iPos=0;
            sprintf(szhCadenaAux1,"%s",szhCadenaIndice);


            szhCadenaResultado[0]='\0';

            while (strlen(szhCadenaAux1) > 0)
            {
                for (iCont=0;iCont < strlen(szhCadenaAux1); iCont++)
                    if (szhCadenaAux1[iCont] == ':')
                    {
                        iPos=iCont;
                        break;
                    }
                    
                sprintf(szhIndice,"%*.*s",1,iPos,szhCadenaAux1);
                sprintf(szhIndiceCiclFact,"%s_%ld",szhIndice,lhCodCiclFact);
                
                if (strlen(szhIndice) + 6 > 30)
                {                                        
                    sprintf (szhIndice_aux,"%*.*s",1,24,szhIndice);
                    
                    sprintf(szhIndiceCiclFact_aux,"%s_%ld",szhIndice_aux,lhCodCiclFact);                    
                    
                    sprintf (szhIndiceCiclFact,"%s",szhIndiceCiclFact_aux);
                    
                    sprintf (szhIndice,"%s",szhIndice_aux);                    
                }                                                  

                vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s]\n", LOG03, szhIndice);
               
                if (!strstr(szhIndice, szhTabla))
                {
                    /* EXEC SQL EXECUTE
                         BEGIN
                            :szhCadenaCreateIndex := ltrim(rtrim(replace ((replace (FA_UTILFAC_PG.FA_OBTIENE_DESC_INDICES_FN(:szhIndice),:szhTolTarifica,:szhTablaCiclo)), :szhIndice, :szhIndiceCiclFact)));
                         END;
                    END-EXEC; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 5;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "begin :szhCadenaCreateIndex := ltrim ( rt\
rim ( replace ( ( replace ( FA_UTILFAC_PG . FA_OBTIENE_DESC_INDICES_FN ( :szhI\
ndice ) , :szhTolTarifica , :szhTablaCiclo ) ) , :szhIndice , :szhIndiceCiclFa\
ct ) ) ) ; END ;";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )238;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaCreateIndex;
                    sqlstm.sqhstl[0] = (unsigned long )4096;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhIndice;
                    sqlstm.sqhstl[1] = (unsigned long )50;
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhTolTarifica;
                    sqlstm.sqhstl[2] = (unsigned long )1024;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhTablaCiclo;
                    sqlstm.sqhstl[3] = (unsigned long )1024;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhIndiceCiclFact;
                    sqlstm.sqhstl[4] = (unsigned long )50;
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


                }
		else
                {
                    /* EXEC SQL EXECUTE
                        BEGIN
                           :szhCadenaCreateIndex := ltrim(rtrim(replace (FA_UTILFAC_PG.FA_OBTIENE_DESC_INDICES_FN(:szhIndice), :szhTabla, :szhTablaCiclo)));
                        END;
                    END-EXEC; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 5;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "begin :szhCadenaCreateIndex := ltrim ( rt\
rim ( replace ( FA_UTILFAC_PG . FA_OBTIENE_DESC_INDICES_FN ( :szhIndice ) , :s\
zhTabla , :szhTablaCiclo ) ) ) ; END ;";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )273;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaCreateIndex;
                    sqlstm.sqhstl[0] = (unsigned long )4096;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhIndice;
                    sqlstm.sqhstl[1] = (unsigned long )50;
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)szhTabla;
                    sqlstm.sqhstl[2] = (unsigned long )1024;
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)szhTablaCiclo;
                    sqlstm.sqhstl[3] = (unsigned long )1024;
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


                }

                if ( SQLCODE != SQLOK )
                {
                    if ( SQLCODE != SQLNOTFOUND )
                    {
                        fprintf(stderr,"\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n",szhIndice,SQLCODE,SQLERRM);
                        vDTrazasLog(szExeLoadTarif,   "\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                        vDTrazasError(szExeLoadTarif, "\n\t** WARNING *** No Se Puede Ubicar Indice %s %d %s\n", LOG01,szhIndice,SQLCODE,SQLERRM);
                        return (TRUE);
                    }
                    else
                    {
                        vDTrazasLog(szExeLoadTarif,"\n\t** Indice [%s] ya no existe\n", LOG03,szhIndice);
                        return (TRUE);
                    }
                }
                sprintf(szhCadenaAux2,"%s", szhCadenaCreateIndex);
                vDTrazasLog(szExeLoadTarif,"\n\t** Descripcion [%s]\n", LOG03, szhCadenaAux2);
                sprintf(szhCadenaResultado,"%s%s%c",szhCadenaResultado,szhCadenaAux2,':');
                szhAux[0]='\0';
                for (iCont=iPos+1;iCont < strlen(szhCadenaAux1); iCont++)
                    sprintf(szhAux,"%s%c",szhAux,szhCadenaAux1[iCont]);
                sprintf(szhAux,"%s%c",szhAux,'\0');
                strcpy(szhCadenaAux1,szhAux);
            }
            szCadenaCreateIndex[0]='\0';
            sprintf(szCadenaCreateIndex,"%s\0",szhCadenaResultado);

            lLargoCadenaCreateIndex = strlen(szhCadenaResultado);
            vDTrazasLog(szExeLoadTarif,"\n\t** Obtiene Correctamente Sentencias para Crear indice \n\t[%s]"
                                      , LOG03
                                      , szCadenaCreateIndex);
    }
    else
    {
       vDTrazasLog(szExeLoadTarif,  "\n\t** No crea indices. Aun existen procesos ejecutandose"
                                    "\n\t** Ultimo proceso loadtarif creara indices\n",LOG03);
       return(TRUE);
    }

    sprintf(szhCadenaAux1,"%.*s",strlen(szCadenaCreateIndex),szCadenaCreateIndex);

    iPos=0;
    while (strlen(szhCadenaAux1) > 0)
    {
        for (iCont=0;iCont < strlen(szhCadenaAux1); iCont++)
            if (szhCadenaAux1[iCont] == ':')
            {
                iPos=iCont;
                break;
            }
        sprintf(szhCadenaCreateIndex,"%*.*s",1,iPos,szhCadenaAux1);
        vDTrazasLog(szExeLoadTarif,"\n\t** Creación [%s]\n", LOG03, szhCadenaCreateIndex);

        /* EXEC SQL EXECUTE
           BEGIN
             FA_UTILFAC_PG.FA_EJECUTA_DML_PR(:szhCadenaCreateIndex);
           END;
        END-EXEC; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "begin FA_UTILFAC_PG . FA_EJECUTA_DML_PR ( :szhCadenaC\
reateIndex ) ; END ;";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )304;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaCreateIndex;
        sqlstm.sqhstl[0] = (unsigned long )4096;
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



        if (SQLCODE != SQLOK && SQLCODE != SQLINDEXEXIST )
        {
            vDTrazasLog(szExeLoadTarif,  "\n\t** ERROR al Ejecutar [%s] %d %s\n",LOG01,szhCadenaCreateIndex,SQLCODE,SQLERRM);
            vDTrazasError(szExeLoadTarif,"\n\t** ERROR al Ejecutar [%s] %d %s\n",LOG01,szhCadenaCreateIndex,SQLCODE,SQLERRM);
            return (FALSE);
        }
        szhCadenaAux2[0]='\0';
        for (iCont=iPos+1;iCont < strlen(szhCadenaAux1); iCont++)
            sprintf(szhCadenaAux2,"%s%c",szhCadenaAux2,szhCadenaAux1[iCont]);
        sprintf(szhCadenaAux2,"%s%c",szhCadenaAux2,'\0');
        sprintf(szhCadenaAux1,szhCadenaAux2);
    }
    return (TRUE);
}

/**********************************************************************************/
/* Verificacion de No existencia de procesos de carga de trafico                  */
/* @return  TRUE si la operacion es realizada con exito, FALSE en caso contrario. */
/**********************************************************************************/
BOOL NoExistenProcesosActuales(void)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int     iCont;
         long    lhCodCiclFact;
         int     iCodProceso;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCiclFact = stLineaComando.lCodCiclFact;
    iCodProceso = 4000 + stLineaComando.iDigitoCli;

    /* EXEC SQL
         SELECT count(1)
         INTO :iCont
         FROM FA_TRAZAPROC
         WHERE COD_CICLFACT = :lhCodCiclFact
         AND   COD_PROCESO BETWEEN 4000 AND 4009
         AND   COD_PROCESO <> :iCodProceso
         AND   COD_ESTAPROC = 1; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from FA_TRAZAPROC where (((COD_\
CICLFACT=:b1 and COD_PROCESO between 4000 and 4009) and COD_PROCESO<>:b2) and \
COD_ESTAPROC=1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )323;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCont;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iCodProceso;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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



    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szExeLoadTarif,   "\n\t**  Error en FA_TRAZAPROC [%d:%s] **"
                                        ,LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeLoadTarif,   "\n\t**  Error en FA_TRAZAPROC [%d:%s] **"
                                        ,LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
   if(SQLCODE == SQLNOTFOUND)
       return(TRUE);
   if (iCont>0)
       return(FALSE);
   else
       return(TRUE);

}

/******************************************************************************************/
/** Informaciï¿½ de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisiï¿½                                            : */
/**  %PR% */
/** Autor de la Revisiï¿½                                : */
/**  %AUTHOR% */
/** Estado de la Revisiï¿½ ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaciï¿½ de la Revisiï¿½                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
