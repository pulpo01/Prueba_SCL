
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
static const struct sqlcxp sqlfpn =
{
    18,
    "./pc/cierrefact.pc"
};


static unsigned int sqlctx = 13788811;


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
   unsigned char  *sqhstv[6];
   unsigned long  sqhstl[6];
            int   sqhsts[6];
            short *sqindv[6];
            int   sqinds[6];
   unsigned long  sqharm[6];
   unsigned long  *sqharc[6];
   unsigned short  sqadto[6];
   unsigned short  sqtdso[6];
} sqlstm = {12,6};

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
"select ROWID ,COD_CLIENTE ,COD_CICLO ,NUM_ABONADO ,IND_CAMBIO ,COD_CICLONUE \
 from FA_CICLOCLI where (COD_CICLO=:b0 and IND_CAMBIO=2) order by COD_CLIENTE,\
NUM_ABONADO            ";

 static const char *sq0005 = 
"select COD_CLIENTE ,NUM_ABONADO  from FA_CICLOCLI where ((COD_CICLO=:b0 and \
IND_MASCARA=1) and NUM_PROCESO<=0)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,145,0,4,328,0,0,5,1,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
40,0,0,2,177,0,9,484,0,0,1,1,0,1,0,1,3,0,0,
59,0,0,2,0,0,13,511,0,0,6,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,
98,0,0,3,144,0,4,590,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,
125,0,0,4,85,0,5,619,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
148,0,0,2,0,0,15,651,0,0,0,0,0,1,0,
163,0,0,5,121,0,9,727,0,0,1,1,0,1,0,1,3,0,0,
182,0,0,5,0,0,13,759,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
205,0,0,5,0,0,15,789,0,0,0,0,0,1,0,
220,0,0,6,0,0,17,840,0,0,1,1,0,1,0,1,97,0,0,
239,0,0,6,0,0,21,863,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
262,0,0,7,0,0,17,890,0,0,1,1,0,1,0,1,97,0,0,
281,0,0,7,0,0,21,911,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
304,0,0,8,64,0,5,1239,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
327,0,0,9,51,0,4,1334,0,0,1,0,0,1,0,2,3,0,0,
346,0,0,10,224,0,3,1348,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
381,0,0,11,169,0,3,1384,0,0,1,1,0,1,0,1,3,0,0,
400,0,0,12,0,0,17,1434,0,0,1,1,0,1,0,1,97,0,0,
419,0,0,12,0,0,21,1446,0,0,0,0,0,1,0,
434,0,0,13,62,0,5,1467,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : cierrefact.pc                                           * */
/* *  Proceso de "FACTURACION"                                          * */
/* *  Autor : Mauricio Villagra Villaobos                               * */
/* *                                                                    * */
/* *  Comentarios : El ejecutable en cuestion cierra el ciclo           * */
/* *  de Facturacion en la tabla FA_CICLOCLI , realizando el Cambio de  * */
/* *  Ciclo de los registros con indicador de Cambio en 2 para los      * */
/* *  Ciclo validos en la tabla FA_CICLFACT.                            * */
/* *  Devuelve el trafico de los clientes no facturados desde la tabla  * */
/* *  PF_TARIFICADAS a las tablas TA_TARIFICADAS0..9 segun corresponda. * */
/* *                                                                    * */
/* *  Modificaciones :                                                  * */
/* *  05-04-1999 : Creacion del Ejecutable                              * */
/* *  26-05-99   : Agrega Funcionalidad de Devolver el trafico de los   * */
/* *                Clientes No Facturados en el Ciclo a Cerrar         * */
/* *  10-06-99   : Pasar a historico llamdas Roaming , Acumuladores y   * */
/* *               Detalle de Trafico cambiando el ciclo de facturacion * */
/* *               al ciclo en que se facturo realmente                 * */
/* *  15-09-99   : Devolucion de Trafico No Facturado por Cliete-Abonado* */
/* *               Modificando el Cursor de la rutina                   * */
/* *               bfnDevuelveTraficoNoFact y agregando como parametro  * */
/* *               el Numero de Abonado del Cliente en la rutina        * */
/* *               bfnDevuelveTraficoCliente                            * */
/* *  02-06-00   : Creacion del procedimiento que inerta dumentos a     * */
/* *               emitir en facturacion de Ciclo y que serán despacha- * */
/* *               por correspondencia                                  * */
/* *  20-12-02   : Se incluye diferenciacion entre tasacion clasica y   * */
/* *               tasacion on line                                     * */
/* ********************************************************************** */

#define _CIERREFACT_PC_

#include "cierrefact.h"


long lTotClientes               = 0l;
long lTotLlamadas               = 0l;
long lLlamadasOK                = 0l;
long lLlamadasErr               = 0l;

long lTotClientesRoa            = 0l;
long lTotLlamadasRoa            = 0l;
long lLlamadasOKRoa             = 0l;
long lLlamadasErrRoa            = 0l;


long lTotales                   = 0l;
long lCorrectos                 = 0l;
long lIncorrectos               = 0l;



char szUsage[]=
   "\nUso:   CierreFact -u  Usuario/Password    "
   "\n                  -c  Ciclo Facturacion   "
   "\n\tOPCIONES:                               "
   "\n\t           -l [LogNivel]                ";


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


/****************************************************************************/
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

static BOOL     bfnCierreCicloFact(long)                        ;
static BOOL     bfnCambiosDeCiclo2(long,char*)                  ;
static BOOL     bfnDevuelveTraficoNoFact(long, int)             ;
static BOOL     bfnDevuelveTraficoCliente(long,long,int)        ;
static void     vfnInitCadenaInsertPFTar(char *,int, int)       ;
static void     vfnInitCadenaDeletePFTar(char *, int)           ;
static BOOL     bfnCreateFaDetCelular(long,char *)              ;
static BOOL     bfnUpdateTrazaDetFortas(long)                   ;
static BOOL     bfnGenEventoCorreo(long)                        ;
/****************************************************************************/
/*    funcion int main(argc, argv)                                          */
/****************************************************************************/
/*  Funcion principal del proceso que realizar las operaciones de validar   */
/*  parametros crear archivos de log, errores.   Se conecta a la base de    */
/*  datos y llama a los procedimientos de cambios de Ciclo y Devolucion     */
/*  de trafico no facturado desde la tabla PF_TARIFICADA hacia las tablas   */
/*  TA_TARIFICADAS0..9                                                      */
/*                                                                          */
/*  20.12.2002 Se Agrego funcionalidad que permite discriminar entre        */
/*             informacion proveniente de la Tasacion Clasica y la          */
/*             Tasacion On Line alternado la tabla FA_CICLFACT con el       */
/*             campo IND_TASADOR.Se integran una serie de tablas adic.      */
/*                                                                          */
/****************************************************************************/

int main(int argc, char *argv[])
{

    /****  NUEVO   ****/
    LINEACOMANDO stLineaComando;

    extern  char    *optarg                     ;
    char            opt[]="u:c:l:"              ;
    int             iOpt =0                     ;
    char            szUsuario [63] = ""         ;
    char            *psztmp      = ""           ;
    char            szaux     [10]              ;
    char            *szDirLogs                  ;
    char            szComando[1024] = ""        ;
    BOOL bOptUsuario = FALSE                    ;

    memset(&stLineaComando,0,sizeof(LINEACOMANDO));

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
             case 'l':
                 if (strlen (optarg))
                 {
                    stStatus.LogNivel =
                    (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                 }
                 break;
         }
    }


    if (stLineaComando.lCodCiclFact == 0)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return 1;
    }

    if (!bOptUsuario)
    {
        fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szUsage);
        return  (2);
    }
    else
    {
       if ( (psztmp=(char *)strstr (szUsuario,"/"))==(char *)NULL)
       {
             fprintf (stderr,"\n\tUsuario Oracle no Valido\n%s\n",szUsage);
             return (3);
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
    
    if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    {
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                        "'sptel  <usuario> <passwd> '\n");
        return (3);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------",
                stLineaComando.szUser);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;
         
    /**************************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);
    /**************************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/cierrefact/%ld/",szDirLogs,stLineaComando.lCodCiclFact);
    
    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );
    
    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /*********************************************************************************************/
    sprintf(stStatus.ErrName, "%sCierreFact_%ld_%s.err",
            stLineaComando.szDirLogs, stLineaComando.lCodCiclFact, szSysDate);

    if( (stStatus.ErrFile = fopen(stStatus.ErrName,"wb")) == (FILE*)NULL )
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de error %s\n", stStatus.ErrName);
        return (4);
    }
    
    /*********************************************************************************************/
    sprintf(stStatus.LogName, "%sCierreFact_%ld_%s.log",
            stLineaComando.szDirLogs, stLineaComando.lCodCiclFact, szSysDate);

    if ((stStatus.LogFile = fopen(stStatus.LogName,"wb")) == (FILE*)NULL)
    {
        fprintf( stderr, "\n ### Error: No puede abrirse el fichero "
                         "de log %s\n", stStatus.LogName);
        fclose(stStatus.ErrFile);
        return (5);
    }
    /*********************************************************************************************/
    vDTrazasLog  (szExeCierreFact,  "\n\n\t****************************************"
                                    "\n\n\t****        Log   CierreFact          **"
                                    "\n\n\t****************************************"
                                    ,LOG03);

    vDTrazasError(szExeCierreFact,  "\n\n\t*************************************"
                                    "\n\n\t****     Errores de CierreFact     **"
                                    "\n\n\t*************************************"
                                    ,LOG03);

    vDTrazasLog(szExeCierreFact,
                            "\n\t\tParametro de Entrada CierreFact.c ***"
                            "\n\t\t=> Usuario      [%s]"
                            "\n\t\t=> Password     [************]"
                            "\n\t\t=> Cod.CiclFact [%ld]"
                            "\n\t\t=> Niv.Log      [%d]",
                            LOG05,
                            stLineaComando.szUser,
                            stLineaComando.lCodCiclFact,
                            stLineaComando.iNivLog);



    if(!bfnCierreCicloFact(stLineaComando.lCodCiclFact)) 
       fnOraRollBack();
    else 
    {
        if (!bfnOraCommit())
        {
           vDTrazasError(szExeCierreFact, "\n\n\tError en Commit de Estadisticas bfnOraCargaHistDocu ", LOG01);
           return FALSE;
        }
    }

    if(!bfnDisconnectORA(0))
    {
     /*No estaba conectado*/
    }
    else
        vDTrazasLog(szExeCierreFact,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);

        vDTrazasError(szExeCierreFact,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03, stLineaComando.szUser);
    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
}
/****************************************************************************/
/*    Fin int main(argc, argv)                                              */





/****************************************************************************/
/*    funcion BOOL bfnCierreCicloFact (long lCiclParam)                     */
/****************************************************************************/
/*  Selecciona los datos de la Tabla FA_CICLFACT para comprobar si el ciclo */
/*  ha comenzado el proceso de facturacion. Para esto se han definido los   */
/*  siguientes estados del Indicador de Facturacion :                       */
/*  0   :   El Ciclo no ha comenzado el proceso de Facturacion              */
/*  1   :   Comenzo la Facturación de Ciclo.  Marcado por el proceso de     */
/*          Creacion de la Mascara( Pre-Ciclo), siempre y cuando la fecha   */
/*          sea posterior a la Fecha Hasta de Llamadas FEC_HASTALLAM de la  */
/*          tabla FA_CICLFACT                                               */
/****************************************************************************/
/* Valida que el ciclo este en proceso de facturacion (1)                   */
/* Valida el estado de los procesos precedentes (terminados OK)             */
/* Valida el estado del proceso actula |que no este terminado OK            */
/****************************************************************************/

static BOOL bfnCierreCicloFact (long lCiclParam)
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCod_Ciclo        ;
    long lhCiclParam        ;
    char szhFecActual[15]   ;   /* EXEC SQL VAR szhFecActual IS STRING(15); */ 

    int  ihIndFacturacion   ;

    /* EXEC SQL END DECLARE SECTION; */ 

    char    szFecha [20]     ="";
    int  ihCodTipoTar           ; /* SAAM-20021220 */


    vDTrazasLog(szExeCierreFact,"\n\n\t***  Parametro de Entrada bfnCierreCicloFact  ***"
                                "\n\t\t=> Cod_CiclFact     [%ld]",LOG03,lCiclParam );

    /****************************************************************************************************/
    /*   Selecciona el Codigo de Ciclo y la Fecha Actual del Sistema                                    */
    /****************************************************************************************************/
    
    lhCiclParam = lCiclParam;
    
    /* EXEC SQL SELECT COD_CICLO                               ,
                    TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')     ,
                    IND_FACTURACION                         ,
                    IND_TASADOR /o SAAM-20021220 Campo nuevo que diferencia el tipo de Tasacion o/
             INTO   :lhCod_Ciclo                            , 
                    :szhFecActual                           ,
                    :ihIndFacturacion                       ,
                    :ihCodTipoTar /o SAAM-20021220 o/
             FROM FA_CICLFACT WHERE COD_CICLFACT = :lhCiclParam; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CICLO ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') ,IN\
D_FACTURACION ,IND_TASADOR into :b0,:b1,:b2,:b3  from FA_CICLFACT where COD_CI\
CLFACT=:b4";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_Ciclo;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecActual;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndFacturacion;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodTipoTar;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCiclParam;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeCierreFact,  "\n\n\t**  No Existen Datos en COD_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
        vDTrazasError(szExeCierreFact,  "\n\n\t**  No Existen Datos en COD_CICLFACT **"
                                        "\n\t\t=> Para el Cod_CiclFact     [%ld]",LOG01,lhCiclParam);
        return (FALSE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeCierreFact,  "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_CiclFact) **"
                                        ,LOG01,lhCiclParam);
        vDTrazasLog  (szExeCierreFact,  "\n\n\t**  Error en Select sobre FA_CILCFACT (Cod_CiclFact) **"
                                        ,LOG01,lhCiclParam);
        return (FALSE);
    }
    
    if (ihIndFacturacion != iIND_FACT_ENPROCESO)
    {
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error Ciclo de Facturacion No Esta en Proceso "
                                        "(IND_FACTURACION de FA_CILCFACT) **"
                                        "\n\t\t=>  Cod_CiclFact         [%ld]"
                                        "\n\t\t=>  Ind_Facturacion      [%d]"
                                        ,LOG01,lhCiclParam,ihIndFacturacion);
        vDTrazasError(szExeCierreFact,  "\n\t**  Error Ciclo de Facturacion No Esta en Proceso "
                                        "(IND_FACTURACION de FA_CILCFACT) **"
                                        "\n\t\t=>  Cod_CiclFact         [%ld]"
                                        "\n\t\t=>  Ind_Facturacion      [%d]"
                                        ,LOG01,lhCiclParam,ihIndFacturacion);
        return (FALSE);
    }

    /****************************************************************************/
    /*  Valida Estado del Proceso de Facturacio de Ciclo                        */
    /****************************************************************************/

    if (!bfnValidaTrazaProc(lCiclParam,iPROC_CIERREFACT,iIND_FACT_ENPROCESO))
    {
       return(FALSE);
    }
    else if(!fnOraCommit())
    {
        vDTrazasLog  (szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
        vDTrazasError(szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
        return (FALSE);
    }
    
    bfnSelectTrazaProc ( lCiclParam,iPROC_CIERREFACT,&stTrazaProc);    
    bPrintTrazaProc(stTrazaProc);

/*  rao: se elimina devolucion de trafico dado que no se realiza el borrado de llamadas en la carga */
/*     if (!bfnDevuelveTraficoNoFact(lhCod_Ciclo,ihCodTipoTar)) */
/*         return (FALSE); */

    if (!bfnCambiosDeCiclo2(lhCod_Ciclo,szhFecActual))
        return (FALSE);

    if (!bfnUpdateTrazaDetFortas(lCiclParam))
        return (FALSE);

    if (!bfnGenEventoCorreo(lCiclParam))
        return (FALSE);

    if (!bfnSelectSysDate(szFecha))
        vDTrazasLog(szExeCierreFact ,"\n\t*** Error en bfnSelectSysDate (bfnPasoHistCiclo) ***\n",LOG01); 
    else
    {
        stTrazaProc.iCodEstaProc       = iPROC_EST_OK                           ;
        strcpy(stTrazaProc.szFecTermino,szFecha)                              ;
        strcpy(stTrazaProc.szGlsProceso,"Cierre de Facturacion Terminado OK");
        stTrazaProc.lCodCliente        = 0                                      ;
        stTrazaProc.lNumAbonado        = 0                                      ;
        stTrazaProc.lNumRegistros      = 0                                      ;
        bPrintTrazaProc(stTrazaProc);
        if (!bfnUpdateTrazaProc(stTrazaProc))
            return (FALSE);
    }
    return (TRUE);   
}    
/****************************************************************************/
/*        Fin BOOL bfnCierreCicloFact (long lCiclParam)                     */
/****************************************************************************/





/****************************************************************************/
/*    funcion BOOL bfnCambiosDeCiclo2(long lCicloFact, char * szFecSysDate) */
/****************************************************************************/
/*  Rutina que Selecciona desde la tabla FA_CICLOCLI los registros con      */
/*  con cambio de ciclo pendiente de Cerrar para el Ciclo Facturado,        */
/*  seleccionando los registros con IND_CAMBIO = 2                          */
/****************************************************************************/

static BOOL bfnCambiosDeCiclo2(long lCod_Ciclo, char * szFecSysDate)
{
    BOOL bFinCursor                 = FALSE ;
    long lhCod_CodCliente_Anterior  = 0l    ;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    /* DATOS DE FA_CICLOCLI */

    char szhRowid[20]       ;   /* EXEC SQL VAR szhRowid           IS STRING(20); */ 

    long lhCodCiclo         ;
    long lhCOD_CLIENTE      ; 
    int  ihCOD_CICLO        ;
    long lhCiclFactProx     ;
    long lhNUM_ABONADO      ;
    int  ihIND_CAMBIO       ;
    int  ihCOD_CICLONUE     ;                                                       short i_hCOD_CICLONUE;
    char szhFecSysDate[15]  ;   /* EXEC SQL VAR szhFecSysDate      IS STRING(15); */ 

    
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szExeCierreFact,  "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t\t**  Marca Cambios de Ciclo Realizados (2) **"
                                    "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t* Parametros Entrada (bfnCambiosDeCiclo2)"
                                    "\n\t\t\t---------------------------------------------"
                                    "\n\t\t\t=> Codigo Ciclo [%d]                         "
                                    "\n\t\t\t=> Fecha Actual [%s]                         "
                                    ,LOG03,lCod_Ciclo,szFecSysDate);

        
    lhCodCiclo      = lCod_Ciclo        ;
    strcpy(szhFecSysDate,szFecSysDate)  ;
    
    bFinCursor      = FALSE             ;

    /* EXEC SQL DECLARE cFaCicloCli_CambioCiclo CURSOR FOR
            SELECT 
                ROWID           ,
                COD_CLIENTE     ,
                COD_CICLO       ,
                NUM_ABONADO     ,
                IND_CAMBIO      ,
                COD_CICLONUE    
        FROM    FA_CICLOCLI
        WHERE   COD_CICLO = :lhCodCiclo
        AND     IND_CAMBIO = 2
        ORDER BY COD_CLIENTE, NUM_ABONADO; */ 


    /* EXEC SQL OPEN cFaCicloCli_CambioCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )40;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeCierreFact,  "\n\n\t** No Existen Datos en FA_CICLOCLI **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]",
                                        LOG01, lhCodCiclo);
        vDTrazasError(szExeCierreFact,  "\n\n\t** No Existen Datos en FA_CICLOCLI **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]",
                                        LOG01, lhCodCiclo);
        return (TRUE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(szExeCierreFact,  "\n\n\t**  Error en Select sobre FA_CICLOCLI Cod_Ciclo [%ld] "
                                        "\n\t\t=> Error [%s] **",
                                        LOG01,lhCodCiclo,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\n\t**  Error en Select sobre FA_CICLOCLI Cod_Ciclo [%ld] "
                                        "\n\t\t=> Error [%s] **",
                                        LOG01,lhCodCiclo,SQLERRM);
        return (FALSE);
    }
 
    do
    {
        /* INIZIALIZAMOS LAS VARIABLES HOST */

        /* EXEC SQL FETCH cFaCicloCli_CambioCiclo INTO
                :szhRowid                           ,
                :lhCOD_CLIENTE                      ,
                :ihCOD_CICLO                        ,
                :lhNUM_ABONADO                      ,
                :ihIND_CAMBIO                       ,
                :ihCOD_CICLONUE :i_hCOD_CICLONUE    ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )59;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
        sqlstm.sqhstl[0] = (unsigned long )20;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhCOD_CLIENTE;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCOD_CICLO;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNUM_ABONADO;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihIND_CAMBIO;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCOD_CICLONUE;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)&i_hCOD_CICLONUE;
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



        if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasError(szExeCierreFact, "Error en Cursor  de FA_CICLOCLI : %s", LOG01, SQLERRM);
            vDTrazasLog  (szExeCierreFact, "Error en Cursor  de FA_CICLOCLI : %s", LOG01, SQLERRM);
            return (FALSE);
        }
        if( SQLCODE == SQLNOTFOUND )
        { 
            if(!fnOraCommit())
            {
                lIncorrectos++;
                vDTrazasLog  (szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                vDTrazasError(szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                return (FALSE);
            }
            vDTrazasLog  (szExeCierreFact, "\n\n\t** No Existen Mas Datos en FA_CICLOCLI **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]",
                                        LOG03, lhCodCiclo);
            bFinCursor = TRUE;
        }
        else
        {
            vDTrazasLog  (szExeCierreFact,  "\n\t\tProcesando Cambio de Ciclo "
                                            "\n\t\t\t=> Cod_Cliente   ..... [%ld]"
                                            "\n\t\t\t=> Num_Abonado   ..... [%ld]"
                                            ,LOG04,lhCOD_CLIENTE,lhNUM_ABONADO);

            /*  Controla COMMIT por Cliente ; No grava aboandos del cliente si este no esta Consistente */

            if(lhCod_CodCliente_Anterior != lhCOD_CLIENTE && lhCod_CodCliente_Anterior > 0 ) 
            {
                if(!fnOraCommit())
                {
                    lIncorrectos++;
                    vDTrazasLog  (szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                    vDTrazasError(szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                    return (FALSE);
                }
            }
            lhCod_CodCliente_Anterior           = lhCOD_CLIENTE;
            lTotales++;

            /****************************************************************************************************/
            /* **       Valida si el Cliente-Abonado  tiene Cambio de Ciclo para el Periodo A Cerrar         ** */ 
            /****************************************************************************************************/

            /***************************************************************/
            /*   Cambio de Ciclo en FA_CICLOCLI ,  Cambia de Cod_CiclFact  */
            /***************************************************************/
            if (ihIND_CAMBIO == 2)
            {
                /* Valida el Valor del Campo Cod_Ciclo            */
                /**************************************************/
                if (i_hCOD_CICLONUE == ORA_NULL )
                {
                    vDTrazasError(szExeCierreFact,  "\n\n\t  Error en Cod_CicloNue (Null) de FA_CICLOCLI "
                                                    "con IND_CAMBIO == 1 "
                                                    "\n\t\t==>  Cliente     [%ld]"
                                                    "\n\t\t==>  Abonado     [%ld]"
                                                    ,LOG01,lhCOD_CLIENTE,lhNUM_ABONADO);
                    vDTrazasLog  (szExeCierreFact,  "\n\n\t  Error en Cod_CicloNue (Null) de FA_CICLOCLI "
                                                    "con IND_CAMBIO == 1 "
                                                    "\n\t\t==>  Cliente     [%ld]"
                                                    "\n\t\t==>  Abonado     [%ld]"
                                                    ,LOG01,lhCOD_CLIENTE,lhNUM_ABONADO);
                    return (FALSE);
                }
        
                /* Busca el nuevo Cod_CiclFact para Cod_CicloNue. */
                /**************************************************/
        
                /* EXEC SQL    SELECT  COD_CICLFACT
                            INTO    :lhCiclFactProx
                            FROM    FA_CICLFACT
                            WHERE   COD_CICLO = :ihCOD_CICLONUE
                            AND     to_date(:szhFecSysDate,'YYYYMMDDHH24MISS') 
                               BETWEEN FEC_DESDELLAM 
                               AND     FEC_HASTALLAM; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select COD_CICLFACT into :b0  from FA_CICLFAC\
T where (COD_CICLO=:b1 and to_date(:b2,'YYYYMMDDHH24MISS') between FEC_DESDELL\
AM and FEC_HASTALLAM)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )98;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhCiclFactProx;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&ihCOD_CICLONUE;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhFecSysDate;
                sqlstm.sqhstl[2] = (unsigned long )15;
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
                    vDTrazasError(szExeCierreFact,  "\n\n\t  Error Al Recuperar Nuevo Cod_CiclFact de FA_CICLFACT "
                                                    "\n\t\t==>  Cliente         [%ld]"
                                                    "\n\t\t==>  Abonado         [%ld]"
                                                    "\n\t\t==>  Ciclo           [%d]"
                                                    "\n\t\t==>  Fecha Actual    [%s]"
                                                    ,LOG01,lhCOD_CLIENTE,lhNUM_ABONADO,
                                                    ihCOD_CICLONUE,szhFecSysDate);
                    vDTrazasLog   (szExeCierreFact, "\n\n\t  Error Al Recuperar Nuevo Cod_CiclFact de FA_CICLFACT "
                                                    "\n\t\t==>  Cliente         [%ld]"
                                                    "\n\t\t==>  Abonado         [%ld]"
                                                    "\n\t\t==>  Ciclo           [%d]"
                                                    "\n\t\t==>  Fecha Actual    [%s]"
                                                    ,LOG01,lhCOD_CLIENTE,lhNUM_ABONADO,
                                                    ihCOD_CICLONUE,szhFecSysDate);
                    return (FALSE);
                }

                /* Actualiza el Nuevo Ciclo para el Registro.     */
                /**************************************************/
 
                /* EXEC SQL   UPDATE FA_CICLOCLI
                            SET    COD_CICLO    = :ihCOD_CICLONUE,
                                   IND_CAMBIO   = 0,
                                   COD_CICLONUE = NULL
                            WHERE  ROWID        = :szhRowid; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 6;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update FA_CICLOCLI  set COD_CICLO=:b0,IND_CAM\
BIO=0,COD_CICLONUE=null  where ROWID=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )125;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&ihCOD_CICLONUE;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
                sqlstm.sqhstl[1] = (unsigned long )20;
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



                if(SQLCODE != SQLOK)
                {
                    lIncorrectos++;
                    vDTrazasLog  (szExeCierreFact, "\n\n\t** Error en UPDATE Sobre FA_CICLOCLI ** "
                                                   "\n\t\t\t==>  ROWID  = [%s]"
                                                   "\n\t\t\t==>  Error  %s", LOG01,szhRowid,SQLERRM);
                    vDTrazasError(szExeCierreFact, "\n\n\t** Error en UPDATE Sobre FA_CICLOCLI %s ** "
                                                   "\n\t\t\t==>  ROWID  = [%s]"
                                                   "\n\t\t\t==>  Error  %s", LOG01,szhRowid,SQLERRM);                                                   
                                                    
                    return (FALSE);
                }
            }

            lCorrectos++;
            vDTrazasLog(szExeCierreFact,"\n\t*****************************************************"
                                        "\n\t Abonado Procesado Correctamente                     "
                                        "\n\t\t==> Cliente             [%ld]                      "
                                        "\n\t\t==> Abonado             [%ld]                      "
                                        "\n\t\t==> Codigo Ciclo Actual [%ld]                      "
                                        "\n\t\t==> Codigo Ciclo Nuevo  [%d]                      "
                                        "\n\t*****************************************************",
                                        LOG03, lhCOD_CLIENTE,  lhNUM_ABONADO, lhCodCiclo,ihCOD_CICLONUE);
        }  /*  else  FETCH  */
    } while(!bFinCursor);

    /* EXEC SQL CLOSE cFaCicloCli_CambioCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )148;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                       
    vDTrazasLog(szExeCierreFact,"\n\t***   Termino de Proceso Cambio de Ciclo 2   ***\n",LOG03); 

    if (lTotales == 0)
       return TRUE;
    else
    {
       vDTrazasLog(szExeCierreFact, "\n\t**  SALIENDO DE CAMBIOS DE CICLO 2 "
                                 "\n\t\t==>  [%10ld] abonados procesados    "
                                 "\n\t\t==>  [%10ld] abonados correctos     "
                                 "\n\t\t==>  [%10ld] abonados incorrectos   ",
                                 LOG04, lTotales, lCorrectos  , lIncorrectos);
       return TRUE;
    }
} 
/****************************************************************************/
/*    Fin   BOOL bfnCambiosDeCiclo2(long lCicloFact, char * szFecSysDate)   */
/****************************************************************************/





/****************************************************************************/
/*  funcion BOOL bfnDevuelveTraficoNoFact(lCod_Ciclo,ihCodTipoTar)          */
/****************************************************************************/
/*  Rutina que Selecciona desde la tabla FA_CICLOCLI los registros con      */
/*  Indicador de Mascara de facturacion y No Facturados (Anomalias)         */
/*  SAAM-20021220 Se incluye el tipo de tasacion en la funcion              */
/*  funcion BOOL bfnDevuelveTraficoNoFact(lCod_Ciclo)                       */
/****************************************************************************/

static BOOL bfnDevuelveTraficoNoFact(long lCod_Ciclo, int itipo_tasacion)
{
    BOOL bFinCursor_cFaCicloCliNoFact = FALSE ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    /* DATOS DE FA_CICLOCLI */

    long lhCodCliente       ; 
    long lhNumAbonado       ;
    long lhCodCiclo         ;
    char szhFecSysDate[15]  ;   /* EXEC SQL VAR szhFecSysDate      IS STRING(15); */ 

    
    /* EXEC SQL END DECLARE SECTION; */ 

        
    vDTrazasLog  (szExeCierreFact,  "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t\t**  Devolucion de Trafico   **"
                                    "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t* Parametros Entrada (bfnDevuelveTraficoNoFact)"
                                    "\n\t\t\t---------------------------------------------"
                                    "\n\t\t\t=> Cod_Ciclo..... [%d]                       "
                                    "\n\t\t\t=> Tipo_Tasacion. [%d]                       "
                                    "\n\t**  Seleccionando Clientes No Facturados de FA_CICLOCLI **"
                                    ,LOG03,lCod_Ciclo,itipo_tasacion); /* SAAM-20021223 */

    /****************************************************************************/
    /*  Declara Cursor sobre FA_CICLOCLI considerando la mascara de Facturacion */
    /****************************************************************************/
    
    lhCodCiclo      = lCod_Ciclo    ;        
    
    bFinCursor_cFaCicloCliNoFact = FALSE;

    /* EXEC SQL DECLARE cFaCicloCliNoFact CURSOR FOR
            SELECT  COD_CLIENTE , 
                    NUM_ABONADO
            FROM    FA_CICLOCLI
            WHERE   COD_CICLO           = :lhCodCiclo
            AND     IND_MASCARA         = 1 
            AND     NUM_PROCESO        <= 0; */ 


    /* EXEC SQL OPEN cFaCicloCliNoFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )163;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclo;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (szExeCierreFact,   "\n\t** No Existen Datos en FA_CICLOCLI No Facturados **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        ,LOG01,lhCodCiclo);
        vDTrazasError(szExeCierreFact,   "\n\t** No Existen Datos en FA_CICLOCLI No Facturados **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        ,LOG01,lhCodCiclo);

        return (TRUE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (szExeCierreFact,   "\n\t**  Error en Select sobre FA_CICLOCLI  **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        ,LOG01,lhCodCiclo);
        vDTrazasError(szExeCierreFact,   "\n\t**  Error en Select sobre FA_CICLOCLI  **"
                                        "\n\t\t=> Codigo de Ciclo       [%ld]"
                                        ,LOG01,lhCodCiclo);
        return (FALSE);
    }

    /****************************************************************************/
    /*  Recorre Cursor de FA_CICLOCLI                                           */
    /****************************************************************************/
 
    do
    {
        /* INIZIALIZAMOS LAS VARIABLES HOST */

        /* EXEC SQL FETCH cFaCicloCliNoFact INTO :lhCodCliente, :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )182;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumAbonado;
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



       if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (szExeCierreFact, "Error en Cursor  de FA_CICLOCLI : %s", LOG01, SQLERRM);
            vDTrazasError(szExeCierreFact, "Error en Cursor  de FA_CICLOCLI : %s", LOG01, SQLERRM);
            return (FALSE);
        }
        if( SQLCODE == SQLNOTFOUND )
        { 
            if(!fnOraCommit())
            {
                vDTrazasLog  (szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                vDTrazasError(szExeCierreFact, "ERROR AL HACER EL COMMIT EN FA_CICLOCLI",LOG01, SQLERRM);
                return (FALSE);
            }
            vDTrazasLog  (szExeCierreFact,   "\n\t** No Existen Mas Clientes en FA_CICLOCLI para Devolver Trafico **"
                                            "\n\t\t=> Codigo de Ciclo       [%ld]"
                                            ,LOG03,lhCodCiclo);
            bFinCursor_cFaCicloCliNoFact = TRUE;
        }
        else
        {
            if (!bfnDevuelveTraficoCliente(lhCodCliente,lhNumAbonado,itipo_tasacion)) /* SAAM-20021223 */
            {
                return(FALSE);
            }
        }  /*  else  Do FETCH  */
    } while(!bFinCursor_cFaCicloCliNoFact);
    
    /* EXEC SQL CLOSE cFaCicloCliNoFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )205;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog(szExeCierreFact,"\n\t***   Termino de Proceso Devolucion de Trafico No Facturado  ***\n",LOG03); 

    vDTrazasLog(szExeCierreFact,  "\n\t** ESTADISTICAS DEL PROCESO DEVOLUCION DE TRAFICO"
                                "\n\t\t==>  [%10ld] Clientes Procesadas     "
                                "\n\t\t==>  [%10ld] Llamadas Procesadas     "
                                "\n\t\t==>  [%10ld] Llamadas Correctas      "
                                "\n\t\t==>  [%10ld] Llamadas Errores        ",
                                LOG03, lTotClientes,lTotLlamadas,lLlamadasOK,lLlamadasErr);
    
    return TRUE;
}
/****************************************************************************/
/*      Fin BOOL bfnDevuelveTraficoNoFact(lCod_Ciclo)                       */
/****************************************************************************/





/***********************************************************************************/
/*   funcion BOOL bfnDevuelveTraficoCliente(lhCodCliente,lhNumAbonado,ihCodTipoTar)*/
/***********************************************************************************/
/*  Funcion que cargar el trafico a facturar de un cliente en la tabla de          */
/*  de Proceso  PF_TARIFICADAS, desde TA_TARIFICADAS0..9 eliminando los            */
/*  registros de TA_TARIFICADAS                                                    */
/*  SAAM-20021223 Se incluye el tipo de tasacion en la funcion                     */
/*  funcion BOOL bfnDevuelveTraficoCliente(lhCodCliente,lhNumAbonado)              */
/***********************************************************************************/
static BOOL bfnDevuelveTraficoCliente(long lcarga_CodCliente, long lcarga_NumAbonado, int itipo_tasacion)
{
    char    szCadenaInsert[4096]="";
    char    szCadenaDelete[1024]="";

    long    lFilasInsert=0          ;
    long    lFilasDelete=0          ;
    
    int     iDigClie=(lcarga_CodCliente % 10)      ;
    
    vDTrazasLog(szExeCierreFact, "\n\t* Parametros Entrada (bfnDevuelveTraficoCliente)"
                                "\n\t\t\t------------------------------------"
                                "\n\t\t\t=> Cod_Cliente   ..... [%ld]"
                                "\n\t\t\t=> Num_Abonado   ..... [%ld]"
                                "\n\t\t\t=> Tipo_tasacion ..... [%d]"
                                ,LOG03, lcarga_CodCliente,lcarga_NumAbonado,itipo_tasacion); /* SAAM-20021223 */
    
    vfnInitCadenaInsertPFTar(szCadenaInsert,iDigClie,itipo_tasacion); /* SAAM-20021223 */
    vfnInitCadenaDeletePFTar(szCadenaDelete,itipo_tasacion); /* SAAM-20021223 */
    
   
    /* EXEC SQL PREPARE sql_insert_tarificadas FROM :szCadenaInsert; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )220;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaInsert;
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


    
    if (SQLCODE)
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Insert  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Tipo_tasacion [%d] "
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,itipo_tasacion,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Insert  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Tipo_tasacion [%d] "
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,itipo_tasacion,SQLCODE,SQLERRM);

        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_insert_tarificadas
            USING       :lcarga_CodCliente ,
                        :lcarga_NumAbonado ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )239;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lcarga_CodCliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lcarga_NumAbonado;
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


            
    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Insert  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);

        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Insert  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);

        return  (FALSE);
    }
        
    lFilasInsert=(SQLROWS>0?SQLROWS:0);
    
    
    
    /* EXEC SQL PREPARE sql_delete_tarificadas FROM :szCadenaDelete; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )262;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaDelete;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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


    
    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Delete  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);

        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Delete  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);
        return (FALSE);
    }


    /* EXEC SQL EXECUTE sql_delete_tarificadas
            USING       :lcarga_CodCliente ,
                        :lcarga_NumAbonado ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )281;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lcarga_CodCliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lcarga_NumAbonado;
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


            
    if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Delete  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);

        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Delete  **"
                                        "\n\t\t=> Cliente       [%ld]"
                                        "\n\t\t=> Num_Abonado   [%ld]"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lcarga_CodCliente,lcarga_NumAbonado,SQLCODE,SQLERRM);
        return  (FALSE);
    }
        
    lFilasDelete=(SQLROWS>0?SQLROWS:0);
        
    
    if (lFilasInsert != lFilasDelete)
    {
        vDTrazasLog  (szExeCierreFact,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        vDTrazasError(szExeCierreFact,   "\n\t**  Error Filas Insertadas != Filas Deletadas **",LOG01);
        return (FALSE);
    }
    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szExeCierreFact,   " \n\t------------------------------------"
                                        " \n\tFallo en el Commit PF_TARIFICADAS   "
                                        " \n\t------------------------------------",
                                        LOG01);
        vDTrazasError(szExeCierreFact,   " \n\t------------------------------------"
                                        " \n\tFallo en el Commit PF_TARIFICADAS   "
                                        " \n\t------------------------------------",
                                        LOG01);
        return (FALSE);
    }
    if (lFilasDelete > 0)
    {
        lTotClientes    ++;
        lTotLlamadas    +=lFilasDelete;
        lLlamadasOK     +=lFilasDelete;
    }
    
    return (TRUE);
}
/****************************************************************************/
/*   funcion BOOL bfnDevuelveTraficoCliente(long lhCodCliente)              */
/****************************************************************************/


/************************************************************************************/
/*   funcion void vfnInitCadenaInsertPFTar(char *szCadena ,int iDigito,int iTipoTas)*/
/************************************************************************************/
/*  Rutina que Crea Cadena para Insertar Registros en TA_TARIFICADASX para          */
/*  ejecutar con Query Dinamico                                                     */
/*  SAAM-20021223 Se incluye el tipo de tasacion en la funcion                      */
/*  funcion void vfnInitCadenaInsertPFTar(char *szCadena ,int iDigito)              */
/************************************************************************************/
static void vfnInitCadenaInsertPFTar(char *szCadena ,int iDigito, int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA){
        sprintf(szCadena,       
        "INSERT INTO TA_TARIFICADAS%d ( "               
            "COD_TIPCENTRAL   ,COD_CENTRAL      ,"
            "NUM_BLOQUE       ,FEC_INITASA      ,"
            "COD_CLIENTE      ,NUM_ABONADO      ,"
            "IND_ALQUILER     ,IND_LIMFRA       ,"
            "COD_PERIODO      ,NUM_MOVIL1       ,"
            "NUM_MOVIL2       ,COD_ALM          ,"
            "TIE_INILLAM      ,TIE_INISEND      ,"
            "TIE_INIANSW      ,TIE_DURSEND      ,"
            "TIE_DURANSW      ,FEC_FINLLAM      ,"
            "COD_RUTAA        ,COD_RUTAOPE      ,"
            "COD_RUTAALM      ,COD_RUTACELDA    ,"
            "COD_RUTATOPE     ,IND_RUTA         ,"
            "COD_RUTAB        ,COD_RUTBOPE      ,"
            "COD_RUTBALM      ,COD_RUTBCELDA    ,"
            "COD_RUTBTOPE     ,IND_RUTB         ,"
            "NUM_MSNB1        ,NUM_NSE1         ,"
            "COD_AREA1        ,IND_TIPABO1      ,"
            "IND_TIPLLA1      ,IND_TIPTAR1      ,"
            "IND_ENTSAL1      ,IND_OPERLD1      ,"
            "IND_LOCAL1       ,IND_LARGA1       ,"
            "COD_TARLOC1      ,COD_REDLOC1      ,"
            "IMP_LOCAL1       ,DUR_LOCAL1       ,"
            "NUM_PULSOS1      ,COD_TARLD1       ,"
            "COD_REDLD1       ,IMP_LARGA2       ,"
            "DUR_LARGA2       ,NUM_PULSOS2      ,"
            "COD_AREA2        ,DES_MOVIL2       ,"
            "COD_FRANHORASOC  ,IMSI_A           ,"
/* PRP-20030321 Se inclyen los campos IMSI_A,IMEI_A,IMSI_B,IMEI_B,NETWORK_TYPE,GSM_DATA */
            "IMEI_A           ,IMSI_B           ,"
            "IMEI_B           ,NETWORK_TYPE.....,"
            "GSM_DATA)"                           
        "SELECT "                                 
            "COD_TIPCENTRAL   ,COD_CENTRAL      ,"
            "NUM_BLOQUE       ,FEC_INITASA      ,"
            "COD_CLIENTE      ,NUM_ABONADO      ,"
            "IND_ALQUILER     ,IND_LIMFRA       ,"
            "COD_PERIODO      ,NUM_MOVIL1       ,"
            "NUM_MOVIL2       ,COD_ALM          ,"
            "TIE_INILLAM      ,TIE_INISEND      ,"
            "TIE_INIANSW      ,TIE_DURSEND      ,"
            "TIE_DURANSW      ,FEC_FINLLAM      ,"
            "COD_RUTAA        ,COD_RUTAOPE      ,"
            "COD_RUTAALM      ,COD_RUTACELDA    ,"
            "COD_RUTATOPE     ,IND_RUTA         ,"
            "COD_RUTAB        ,COD_RUTBOPE      ,"
            "COD_RUTBALM      ,COD_RUTBCELDA    ,"
            "COD_RUTBTOPE     ,IND_RUTB         ,"
            "NUM_MSNB1        ,NUM_NSE1         ,"
            "COD_AREA1        ,IND_TIPABO1      ,"
            "IND_TIPLLA1      ,IND_TIPTAR1      ,"
            "IND_ENTSAL1      ,IND_OPERLD1      ,"
            "IND_LOCAL1       ,IND_LARGA1       ,"
            "COD_TARLOC1      ,COD_REDLOC1      ,"
            "IMP_LOCAL1       ,DUR_LOCAL1       ,"
            "NUM_PULSOS1      ,COD_TARLD1       ,"
            "COD_REDLD1       ,IMP_LARGA2       ,"
            "DUR_LARGA2       ,NUM_PULSOS2      ,"
            "COD_AREA2        ,DES_MOVIL2       ,"
            "COD_FRANHORASOC  ,IMSI_A           ,"
/* PRP-20030321 Se inclyen los campos IMSI_A,IMEI_A,IMSI_B,IMEI_B,NETWORK_TYPE,GSM_DATA */
            "IMEI_A           ,IMSI_B           ,"
            "IMEI_B           ,NETWORK_TYPE     ,"
            "GSM_DATA "                            
            "FROM    PF_TARIFICADAS              "
            "WHERE   COD_CLIENTE = :lhCodCliente "
            "AND     NUM_ABONADO = :lhNumAbonado ",iDigito);
    }
    if (iTipoTas==TIPO_TASA_ON_LINE){
        sprintf(szCadena,       
        "INSERT INTO TOL_DETFACTURA_0%d ( "  
            "SEC_EMPA         ,SEC_CDR          ,"
            "RECORD_TYPE      ,A_SUSC_NUMBER    ,"
            "A_SUSC_MS_NUMBER ,B_SUSC_NUMBER    ,"
            "B_SUSC_MS_NUMBER ,A_CATEGORY       ,"
            "IND_BILLETE      ,DATE_START_CHARG ," 
            "TIME_START_CHARG ,CHARGABLE_DURAT  ,"
            "DATE_SEND_CHARG  ,TIME_SEND_CHARG  ,"
            "SEND_DURAT       ,COD_CCC          ,"
            "OUTGOING_ROUTE   ,INCOMING_ROUTE   ,"
            "INSI_CODE        ,COD_AGRL         ,"
            "COD_SENT         ,COD_LLAM         ,"
            "COD_TDIR         ,COD_TCOR         ,"
            "COD_THOR         ,COD_TDIA         ,"
            "COD_FCOB         ,IND_TABLA        ,"
            "COD_CARG         ,COD_CARR         ,"
            "COD_GRUPO        ,NUM_CLIE         ,"
            "NUM_ABON         ,COD_PLAN         ,"
            "COD_CICL         ,COD_CICLFACT     ,"
            "COD_AREAC        ,COD_ALMC         ,"
            "COD_LIMITE       ,IND_APLICA       ,"
            "COD_BOLSA        ,IND_APLB         ,"
            "COD_OPERA        ,COD_TOPRA        ,"
            "COD_DOPERA       ,COD_TRANA        ,"
            "COD_ALMA         ,COD_AREAA        ,"
            "COD_LOCAA        ,COD_OPERB        ,"
            "COD_TOPRB        ,COD_DOPEB        ,"
            "COD_TRANB        ,COD_ALMB         ,"
            "COD_AREAB        ,COD_LOCAB        ,"
            "COD_PAIS         ,COD_SUBFRANJA    ,"
            "IND_DCTO_MLIB    ,IND_MUESTRA_LLAM ,"
            "DUR_REAL         ,NUM_PULSO        ,"
            "DUR_FACT         ,TIP_MONE         ," 
            "MTO_REAL         ,TIP_DCTO         ,"
            "COD_DCTO         ,ITM_DCTO         ,"
            "DUR_DCTO         ,MTO_FACT         ,"
            "MTO_DCTO         ,IND_EXEDENTE     ,"
            "COD_UMBRAL       ,DES_DESTINO      ,"
            "DES_LLAMADA ) "                       /* P-MIX-09003 */
         "SELECT "       
            "SEC_EMPA         ,SEC_CDR          ,"
            "RECORD_TYPE      ,A_SUSC_NUMBER    ,"
            "A_SUSC_MS_NUMBER ,B_SUSC_NUMBER    ,"
            "B_SUSC_MS_NUMBER ,A_CATEGORY       ,"
            "IND_BILLETE      ,DATE_START_CHARG ," 
            "TIME_START_CHARG ,CHARGABLE_DURAT  ,"
            "DATE_SEND_CHARG  ,TIME_SEND_CHARG  ,"
            "SEND_DURAT       ,COD_CCC          ,"
            "OUTGOING_ROUTE   ,INCOMING_ROUTE   ,"
            "INSI_CODE        ,COD_AGRL         ,"
            "COD_SENT         ,COD_LLAM         ,"
            "COD_TDIR         ,COD_TCOR         ,"
            "COD_THOR         ,COD_TDIA         ,"
            "COD_FCOB         ,IND_TABLA        ,"
            "COD_CARG         ,COD_CARR         ,"
            "COD_GRUPO        ,NUM_CLIE         ,"
            "NUM_ABON         ,COD_PLAN         ,"
            "COD_CICL         ,COD_CICLFACT     ,"
            "COD_AREAC        ,COD_ALMC         ,"
            "COD_LIMITE       ,IND_APLICA       ,"
            "COD_BOLSA        ,IND_APLB         ,"
            "COD_OPERA        ,COD_TOPRA        ,"
            "COD_DOPERA       ,COD_TRANA        ,"
            "COD_ALMA         ,COD_AREAA        ,"
            "COD_LOCAA        ,COD_OPERB        ,"
            "COD_TOPRB        ,COD_DOPEB        ,"
            "COD_TRANB        ,COD_ALMB         ,"
            "COD_AREAB        ,COD_LOCAB        ,"
            "COD_PAIS         ,COD_SUBFRANJA    ,"
            "IND_DCTO_MLIB    ,IND_MUESTRA_LLAM ,"
            "DUR_REAL         ,NUM_PULSO        ,"
            "DUR_FACT         ,TIP_MONE         ," 
            "MTO_REAL         ,TIP_DCTO         ,"
            "COD_DCTO         ,ITM_DCTO         ,"
            "DUR_DCTO         ,MTO_FACT         ,"
            "MTO_DCTO         ,IND_EXEDENTE     ,"
            "COD_UMBRAL       ,DES_DESTINO      ,"            
            "DES_LLAMADA "                         /* P-MIX-09003 */
        "FROM   PF_TOLTARIFICA             "
        "WHERE  NUM_CLIE = :lhCodCliente  "
        "AND    NUM_ABON = :lhNumAbonado  ",iDigito);
    } /* SAAM-20021223 Se incluye la consulta a DETALLE a TOL */         
}
/*   funcion void vfnInitCadenaInsertTarif(char *szCadena ,int iDigito,int iTipoTas) */






/****************************************************************************/
/*   funcion void vfnInitCadenaDeletePFTar(char *szCadena,int iTipoTas)     */
/****************************************************************************/
/*  Rutina que Crea Cadena para Deletar Registros en PF_TARIFICADAS         */
/*  para ejecutar con Query Dinamico                                        */
/*  SAAM-20021223 Se incluye el tipo de tasacion en la funcion              */
/*   funcion void vfnInitCadenaDeletePFTar(char *szCadena)                  */
/****************************************************************************/
static void vfnInitCadenaDeletePFTar(char *szCadena,int iTipoTas)
{
    if (iTipoTas==TIPO_TASA_CLASICA){
        sprintf(szCadena,       
            "DELETE FROM   PF_TARIFICADAS        "
            "WHERE   COD_CLIENTE = :lhCodCliente "
            "AND     NUM_ABONADO = :lhNumAbonado ");
    }
    if (iTipoTas==TIPO_TASA_ON_LINE){
        sprintf(szCadena,       
            "DELETE FROM   PF_TOLTARIFICA         "
            "WHERE   NUM_CLIE = :lhCodCliente    "
            "AND     NUM_ABON = :lhNumAbonado    ");
    }
         
}
/* funcion void vfnInitCadenaDeleteTarif(char *szCadena ,int iDigito, int iTipoTas) */




/****************************************************************************/
/*   funcion BOOL bfnCreateFaDetCelular(lCiclParam,szFecha)                 */
/****************************************************************************/
/*  Rutina que Ejecuta Shell remota en maquina de Motor de Base de Datos    */
/****************************************************************************/

static BOOL bfnCreateFaDetCelular(long lCiclParam, char * szFecha)
{
    char            *szDirKsh                   ;
    char            *szDirLog                   ;
    char            szComShell[1024] = ""       ;
        
    szDirKsh =(char *)malloc(1024);
    if ((szDirKsh  = szGetEnv("XPF_KSH")) == (char *)NULL)
        return (FALSE);    
        
    szDirLog =(char *)malloc(1024);
    if ((szDirLog  = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);            
        
    sprintf (szComShell,    "/usr/bin/ksh %s/pashist_llamciclo.ksh %ld > %s/cierrefact/%ld/pashist_llamciclo_%s.log 2>&1\0",
                            szDirKsh,lCiclParam,szDirLog,lCiclParam,szFecha);
    
    if (system (szComShell))
    {
        printf( "\n\t***   Fallo Comando Remoto \n",szComShell);
        return (FALSE);
    }
    return (TRUE);
}




/****************************************************************************/
/*   funcion BOOL bfnUpdateTrazaDetFortas(lCiclParam)                       */
/****************************************************************************/
/*  Rutina que Marca la Traza de Procesos de Carrier                        */
/*  Se Marca la tabla FA_TRAZAFORDET por COD_CICLFACT                       */
/****************************************************************************/

static BOOL     bfnUpdateTrazaDetFortas(long lCiclParam)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


    long    lhCodCiclFact       ;
    char    szhCodEstado [4]    ;   /* EXEC SQL VAR szhCodEstado   IS STRING(4); */ 

    
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szExeCierreFact,  "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t\t**  Marca FA_TRAZAFORDET                  **"
                                    "\n\t*************************************************"
                                    "****************************************************"
                                    "\n\t\t* Parametros Entrada (bfnUpdateTrazaDetFortas)"
                                    "\n\t\t\t---------------------------------------------"
                                    "\n\t\t==>  Codigo Ciclo Facturacion [%ld]"
                                    ,LOG03,lCiclParam);

    /****************************************************************************/
    /*  Inicializa variables de Host                                            */
    /****************************************************************************/
    lhCodCiclFact       =   lCiclParam          ;
    sprintf(szhCodEstado,"CER\0")               ;
    
    /****************************************************************************/
    /*  Marca FA_CICLFACT como Cerrado Ind_facturacion = 3                      */
    /****************************************************************************/
    
    /* EXEC SQL
    UPDATE  FA_TRAZAFORDET
    SET     COD_ESTADO      = :szhCodEstado
    WHERE   COD_CICLFACT    = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_TRAZAFORDET  set COD_ESTADO=:b0 where COD_CICLF\
ACT=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )304;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstado;
    sqlstm.sqhstl[0] = (unsigned long )4;
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


    
    if ( SQLCODE )
    {
        
        if ( SQLCODE != SQLNOTFOUND )
        {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-UPDATE FA_TRAZAFORDET (Cod_Estado = CER )**"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);

        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-UPDATE FA_TRAZAFORDET (Cod_Estado = CER )**"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        "\n\t\t=> Error-Ora                 [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,lhCodCiclFact,SQLCODE,SQLERRM);
        return  (FALSE);
        }
        else
        {
            
            vDTrazasLog  (szExeCierreFact,"\n\t**  NO EXISTEN REGISTROS EN FA_TRAZAFORDET"
                                        "\n\t\t=> Codigo Ciclo Facturacion  [%ld]"
                                        ,LOG01
                                        ,lhCodCiclFact);
            
        }
    }
    /****************************************************************************/
    /*   Commit de Transaccion                                                  */
    /****************************************************************************/

    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szExeCierreFact,   " \n\t------------------------------------------------"
                                        " \n\tFallo en Commit de FA_TRAZAFORDET                "
                                        " \n\t-------------------------------------------------",
                                        LOG01);
        vDTrazasError(szExeCierreFact,   " \n\t------------------------------------------------"
                                        " \n\tFallo en Commit de FA_TRAZAFORDET                "
                                        " \n\t-------------------------------------------------",
                                        LOG01);
        return (FALSE);
    }

    return (TRUE);
}



/****************************************************************************/
/*   funcion BOOL bfnGenEventoCorreo (lCiclParam)                           */
/****************************************************************************/
/*  Rutina que Genera Evento de Correspondencia                             */
/****************************************************************************/

static BOOL bfnGenEventoCorreo (long lCiclParam)
{
    char szCadena_CRT   [1024]="";
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCiclFact       ;
    int     ihCodTipDocCiclo    ;
    int     ihCodSector         ;
    long    lhNumSecEvento      ;
    char    szhCodEstado [4]    ;   /* EXEC SQL VAR szhCodEstado   IS STRING(4); */ 

    long    lhNumFacturas       ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (szExeCierreFact,  "\n\t*************************************************"
                                    "****************************************************"
    								"\n\t\t\t**  Genera Evento Correspondecia          **"
    								"\n\t*************************************************"
                                    "****************************************************"
    								"\n\t\t* Parametros Entrada (bfnGenEventoCorreo)"
                                    "\n\t\t\t---------------------------------------------"
                                    "\n\t\t==>  Codigo Ciclo Facturacion [%ld]"
                                    ,LOG03 ,lCiclParam);

    /****************************************************************************/
    /*  Inicializa variables de Host                                            */
    /****************************************************************************/
    lhCodCiclFact       =   lCiclParam  ;
    ihCodTipDocCiclo    =   2           ;
    ihCodSector         =   3           ;
    lhNumFacturas       =   0           ;
    /****************************************************************************/
    /*  Marca FA_CICLFACT como Cerrado Ind_facturacion = 3                      */
    /****************************************************************************/
    
    /* EXEC SQL SELECT CR_SEQ_EVENTOS.NEXTVAL INTO :lhNumSecEvento FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select CR_SEQ_EVENTOS.nextval  into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )327;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecEvento;
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


    
    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SELECT NEXVAL SEC_EVENTO [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SELECT NEXVAL SEC_EVENTO [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /****************************************************************************/
    /*   Inserta Registro de Evento a Generar                                   */
    /****************************************************************************/

    vDTrazasLog  (szExeCierreFact,  "\n\t\t\t**  Inserta Control de Evento [%ld] **",LOG03,lhNumSecEvento);
    /* EXEC SQL 
        INSERT INTO CRH_EVENTOS     (
                NUM_EVENTO          ,
                FEC_INGRESO_DH      ,
                COD_TIPDOCUM        ,
                COD_SECTOR          ,
                CAN_DESPACHAR       ,
                COD_CICLFACT        ,
                DOC_IMPRESOS        ,
                DOC_DESPACHADOS     ,
                DOC_REVISADOS       ,
                DOC_REV_CORRECTOS   )
        VALUES  (
                :lhNumSecEvento     ,
                SYSDATE             ,
                :ihCodTipDocCiclo   ,
                :ihCodSector        ,
                :lhNumFacturas      ,
                :lhCodCiclFact      ,
                NULL                ,
                NULL                ,
                NULL                ,
                NULL                ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CRH_EVENTOS (NUM_EVENTO,FEC_INGRESO_DH,COD_TI\
PDOCUM,COD_SECTOR,CAN_DESPACHAR,COD_CICLFACT,DOC_IMPRESOS,DOC_DESPACHADOS,DOC_\
REVISADOS,DOC_REV_CORRECTOS) values (:b0,SYSDATE,:b1,:b2,:b3,:b4,null ,null ,n\
ull ,null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )346;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecEvento;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocCiclo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodSector;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFacturas;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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



    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en Insert CRH_EVENTOS [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en Insert CRH_EVENTOS [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /****************************************************************************/
    /*   Inserta Registro de Estado de Evento                                   */
    /****************************************************************************/

    vDTrazasLog  (szExeCierreFact,  "\n\t\t\t**  Inserta Estado de Evento [%ld] **",LOG03,lhNumSecEvento);
    /* EXEC SQL 
        INSERT INTO CRH_ESTAEVENTOS (
                NUM_EVENTO      ,
                COD_ESTADOEVE   , 
                FEC_INGRESO_DH  , 
                FEC_ESTADO_DH   ,
                NOM_USUARIO     ,
                GLS_ESTAEVENTO  ,
                NUM_CORREO      ) 
        VALUES (:lhNumSecEvento ,
                1               ,
                SYSDATE         ,
                SYSDATE         ,
                USER            ,
                NULL            ,
                NULL            ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CRH_ESTAEVENTOS (NUM_EVENTO,COD_ESTADOEVE,FEC\
_INGRESO_DH,FEC_ESTADO_DH,NOM_USUARIO,GLS_ESTAEVENTO,NUM_CORREO) values (:b0,1\
,SYSDATE,SYSDATE,USER,null ,null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )381;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecEvento;
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



    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en Insert CRH_ESTAEVENTOS [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en Insert CRH_ESTAEVENTOS [%d][%s]**",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /****************************************************************************/
    /*   Genera Query con Insert de Detalles                                    */
    /****************************************************************************/

    sprintf(szCadena_CRT,
        "INSERT INTO CRT_DETALLES ( "
                "NUM_EVENTO      , "
                "COD_TIPDOCUM    , "
                "PREF_PLAZA      , "
                "NUM_FOLIO       , "
                "COD_CLIENTE     , "
                "NUM_IDENT       , "
                "NUM_ABONADO     ) "
        "SELECT  %ld , "
                "A.COD_TIPDOCUM  , "
                "A.PREF_PLAZA    , "
                "A.NUM_FOLIO     , "
                "A.COD_CLIENTE   , "
                "NULL            , "
                "NULL              "
        "FROM    FA_FACTDOCU_%ld A, FA_TIPDOCUMEN B "
        "WHERE   B.IND_CICLO=1     "
        "  AND   B.COD_TIPDOCUMMOV=A.COD_TIPDOCUM"
        ,lhNumSecEvento , lhCodCiclFact);

        
    /* EXEC SQL PREPARE sql_insert_CRT_Detalles FROM :szCadena_CRT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )400;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena_CRT;
    sqlstm.sqhstl[0] = (unsigned long )1024;
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
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Insert CRT_DETALLES **"
                                        "\t\t[%ld] [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-PREPARE Insert CRT_DETALLES **"
                                        "\t\t[%ld] [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    vDTrazasLog  (szExeCierreFact,  "\n\t\t\t**  Inserta Detelle de Evento [%ld] **",LOG03,lhNumSecEvento);
    /* EXEC SQL EXECUTE sql_insert_CRT_Detalles; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )419;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Insert CRT_DETALLES **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error en SQL-EXECUTE Insert CRT_DETALLES **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
        
    lhNumFacturas = (SQLROWS>0?SQLROWS:0);

    /****************************************************************************/
    /*   Actualiza Cantidad de Registros de Detalle Insertados                  */
    /****************************************************************************/
    
    /* EXEC SQL 
        UPDATE  CRH_EVENTOS     
        SET     CAN_DESPACHAR = :lhNumFacturas
        WHERE   NUM_EVENTO    = :lhNumSecEvento; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CRH_EVENTOS  set CAN_DESPACHAR=:b0 where NUM_EVENT\
O=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )434;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFacturas;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecEvento;
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




    if ( SQLCODE )
    {
        vDTrazasError(szExeCierreFact,  "\n\t**  Error al Actualizar Cantidad de Facturas  **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (szExeCierreFact,  "\n\t**  Error al Actualizar Cantidad de Facturas  **"
                                        "\n\t\t=> Error-Ora     [%ld]"
                                        "\n\t\t=> Error-Text    %s   "
                                        ,LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /****************************************************************************/
    /*   Commit de Transaccion de Generacion de Evento                          */
    /****************************************************************************/

    if ( !bfnOraCommit())
    {
        vDTrazasLog  (szExeCierreFact,   " \n\t------------------------------------------------"
                                        " \n\tFallo en Commit de Eventos de Correspondencia "
                                        " \n\t-------------------------------------------------",
                                        LOG01);
        vDTrazasError(szExeCierreFact,   " \n\t------------------------------------------------"
                                        " \n\tFallo en Commit de Eventos de Correspondencia "
                                        " \n\t-------------------------------------------------",
                                        LOG01);
        return (FALSE);
    }

    return (TRUE);
}

