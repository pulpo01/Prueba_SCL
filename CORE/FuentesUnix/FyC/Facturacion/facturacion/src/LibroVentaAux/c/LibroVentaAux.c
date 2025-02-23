
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
           char  filnam[22];
};
static struct sqlcxp sqlfpn =
{
    21,
    "./pc/LibroVentaAux.pc"
};


static unsigned int sqlctx = 110597131;


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
   unsigned char  *sqhstv[18];
   unsigned long  sqhstl[18];
            int   sqhsts[18];
            short *sqindv[18];
            int   sqinds[18];
   unsigned long  sqharm[18];
   unsigned long  *sqharc[18];
   unsigned short  sqadto[18];
   unsigned short  sqtdso[18];
} sqlstm = {12,18};

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
5,0,0,1,260,0,4,450,0,0,4,2,0,1,0,2,9,0,0,2,9,0,0,1,5,0,0,1,5,0,0,
36,0,0,2,0,0,17,541,0,0,1,1,0,1,0,1,97,0,0,
55,0,0,2,0,0,45,555,0,0,0,0,0,1,0,
70,0,0,2,0,0,13,681,0,0,18,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,5,0,0,2,5,0,0,
157,0,0,2,0,0,15,775,0,0,0,0,0,1,0,
172,0,0,3,184,0,4,1152,0,0,8,2,0,1,0,2,97,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
2,4,0,0,1,3,0,0,1,3,0,0,
219,0,0,4,74,0,4,1338,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
242,0,0,5,184,0,4,1460,0,0,5,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
};


/* ********************************************************************** */
/* *  Fichero : LibroVentaAux.pc                                        * */
/* *  El libro de ventas                                                * */
/* *  Autor : Guido Antio Cares                                         * */
/* *                                                                    * */
/* ********************************************************************** */

#define _LIBRO_C_

#include <LibroVentaAux.h>

char     szBuffer[MAX_NUMREGISTROS * MAX_LARGOREGISTRO]="";

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
/*                  Definicion de Funciones Prototipos                      */
/****************************************************************************/

/****************************************************************************/
/*    funcion int main(argc, argv)                                          */
/****************************************************************************/

int main(int argc, char *argv[])
{
	char modulo[]="main";
    char szFecha [20]  =""  ;   /*  Fecha de Sistema Para Update de Traza   */
    long lCiclFact      ;
    char    szNomTabla  [20]         ;

    extern  char    *optarg                     ;
            int     iRes                        ;
            int     iOpt                        ;
            char    opt   []        ="u:m:a:d:l: i " ;
            char    szUsuario [63]  = ""        ;
            char    szFormato[10]   = ""        ;
            char    *psztmp         = ""        ;
            char    szaux     [10]              ;
            char    *szDirLogs                  ;
            char    *szDirDats                  ;
            char    szComando[1024] = ""        ;
            BOOL    bOptUsuario     = FALSE     ;


    memset(&stLineaComando,0,sizeof(LINEACOMANDO));
    memset(&stAcumuladorFinal,0,sizeof(GACUMULADORFINAL ));
    memset(&stTotTipDocFin,0,sizeof(GTOTTIPDOCUMFINAL)*NUM_TIPDOCUM);
    stLineaComando.iTipDoc=0;

    while ( (iOpt = getopt (argc, argv, opt) ) != EOF)
    {
        switch (iOpt)
        {
            case 'u':
                if (strlen (optarg))   {
                    strcpy(szUsuario, optarg);
                    bOptUsuario = TRUE;
                    fprintf (stdout," -u %s ", szUsuario);
                }
                break;
            case 'm' :
                if ( strlen (optarg) ) {
                    stLineaComando.iMes    = atoi (optarg);
                    fprintf (stdout," -m %d ",stLineaComando.iMes);
                }
                break;
            case 'a' :
                if ( strlen (optarg) ) {
                    stLineaComando.iAno    = atoi (optarg);
                    fprintf (stdout," -a %d ",stLineaComando.iAno);
                }
                break;
            case 'l':
                if (strlen (optarg))   {
                    stStatus.LogNivel =
                    (atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
                    fprintf (stdout,"-l %d ", stStatus.LogNivel)     ;
                }
                break;
            case 'i':
                    stLineaComando.bImprime = TRUE;
                    fprintf (stdout," -i IMPRIME\n ");
                    break;
           }
    }

    if ( (stLineaComando.bImprime == TRUE) && (strlen(stLineaComando.szTabla)>0) ) {
            fprintf (stderr, "\n\t=> Debe Ingresar solo una Opcion \n"
                    "\t   Tipo de Tabla a Cargar [-c,-n,-h]  o  Impresion [-i] )\n\n", szUsage);
            return  (1);
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
        fprintf(stderr, "\n\tUsuario/Passwd Invalido\n");
        return (1);
    }
    else
    {
        printf( "\n\t-------------------------------------------------------"
                "\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                "\n\t-------------------------------------------------------"
                ,stLineaComando.szUser);
    }

    if (!bGetDatosGener (&stDatosGener, szSysDate))
         return FALSE;

    /* Obtiene el codigo de documento para las boletas autofoliadas */
    if (ifnGetParametro (iCodParBolAuto   , szTipParametro, szValParametro))
        return (FALSE);
    
    iCodBoletaAuto=atoi(szValParametro);

    if (ifnGetParametro (iCodParBolAutoExen, szTipParametro, szValParametro))
        return (FALSE);
        
    iCodBoletaAutoExen=atoi(szValParametro);

    /************************************************************************/
    szDirLogs=(char *)malloc(1024);
    if ((szDirLogs = szGetEnv("XPFACTUR_LOG")) == (char *)NULL)
        return (FALSE);
    /************************************************************************/
    sprintf(stLineaComando.szDirLogs,"%s/LibroVentaAux/%04d%02d/",
            szDirLogs,stLineaComando.iAno,stLineaComando.iMes);

    sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirLogs );

    if (system (szComando))
    {
        printf( "\n\t***   Fallo mkdir de Directorio Logs : %s \n",szComando);
        return (FALSE);
    }
    /************************************************************************/
    sprintf(stStatus.ErrName, "%sLibroVentaAux_%04d%02d_%s.err",
            stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.ErrName);

    if( (stStatus.ErrFile = (FILE *)fopen(stStatus.ErrName,"a")) == (FILE*)NULL )
    {
        fprintf ( stderr, "\n ### Error: No puede abrirse el fichero de error %s\n"
                , stStatus.ErrName);
        return (4);
    }
    /************************************************************************/
    sprintf(stStatus.LogName, "%sLibroVentaAux_%04d%02d_%s.log",
            stLineaComando.szDirLogs,stLineaComando.iAno,stLineaComando.iMes,szSysDate);

    unlink (stStatus.LogName);

    if ((stStatus.LogFile = (FILE *)fopen(stStatus.LogName,"a")) == (FILE*)NULL)
    {
        fprintf ( stderr, "\n ### Error: No puede abrirse el fichero de log %s\n"
                , stStatus.LogName);
        return (5);
    }
    /************************************************************************/

    if (stLineaComando.bImprime) 
    {
        szDirDats=(char *)malloc(1024);
        if ((szDirDats = szGetEnv("XPFACTUR_DAT")) == (char *)NULL)
            return (FALSE);
        /********************************************************************/
        sprintf(stLineaComando.szDirDats,"%s/LibroVentaAux/%04d%02d/",
                szDirDats,stLineaComando.iAno,stLineaComando.iMes);

        sprintf (szComando, "/usr/bin/mkdir -p %s",stLineaComando.szDirDats);

        if (system (szComando))
        {
            printf( "\n\t***   Fallo mkdir de Directorio Datos : %s \n",szComando);
            return (FALSE);
        }
        /********************************************************************/

        sprintf(stLineaComando.szFileDat,"%sLibroVentaAux_%04d%02d_%s.dat",
                stLineaComando.szDirDats,stLineaComando.iAno,stLineaComando.iMes,
                szSysDate);

        unlink (stLineaComando.szFileDat);

        if (( stLineaComando.fpDat = (FILE *)fopen(stLineaComando.szFileDat,"a")) == (FILE *)NULL)
        {
           vDTrazasError(modulo,"\n\n\tError al abrir el Fichero de Datos ",LOG01);
           return FALSE;
        }
    }
    /************************************************************************/

    vDTrazasLog (modulo,
                 "\n\t*********************************************************"
                 "\n\t*                 LIBRO VTA                             *"
                 "\n\t*               NIVEL DE LOG  %d                         *"
                 "\n\t*********************************************************"
                 ,LOG03,stLineaComando.iNivLog);
    vDTrazasError(modulo,
                 "\n\t*********************************************************"
                 "\n\t*                 LIBRO VTA                             *"
                 "\n\t*               NIVEL DE LOG  %d                         *"
                 "\n\t*********************************************************"
                 ,LOG03,stLineaComando.iNivLog);


    /* ********************************************************************** */

    if (!bfnOraGenLibro (stLineaComando))
    {
        stTrazaProc.iCodEstaProc       = iPROC_EST_ERR ;
        strcpy(stTrazaProc.szGlsProceso,"Proceso de Libro de Ventas Finalizado con Error") ;
        printf("\n Salida de  Libro Vta con Error \n") ;
    }
    else
    {
        stTrazaProc.iCodEstaProc       = iPROC_EST_OK  ;
        strcpy(stTrazaProc.szGlsProceso,"Proceso de Libro de Ventas Terminado OK") ;
        printf("\n Salida de  Libro Vta Ok \n")        ;
    }


    /* ********************************************************************** */

    if ((  strcmp(stLineaComando.szTabla,NOCICLO)!=0) 
       && (strcmp(stLineaComando.szTabla,HISTDOCU)!=0)
       && (strlen(stLineaComando.szTabla)>4))  
    {
        if (!bfnSelectSysDate(szFecha)) 
        {
            printf("<< Error en Funcion bfnSelectSysDate!!!. >> \n");
            printf("<< No se Actualizo Traza con Ultimo Proceso del Libro de Ventas. >>\n");
        } else {
            strcpy(stTrazaProc.szFecTermino,szFecha)      ;
            stTrazaProc.lCodCliente        = lConRegFinal ;
            stTrazaProc.lNumAbonado        = 0            ;
            stTrazaProc.lNumRegistros      = 0            ;
            bPrintTrazaProc(stTrazaProc)                  ;
            if (!bfnUpdateTrazaProc(stTrazaProc))
                return (FALSE);
        }
    }

    if(!bfnDisconnectORA(0))
    {
        printf("\n Desconexion de Oracle con Error \n");
    }
    else
    {
        printf("\n Desconexion de Oracle OK\n");
        vDTrazasLog(modulo,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03);
        vDTrazasError(modulo,
                "\n\t-------------------------------------------------------"
                "\n\tDesconectado de ORACLE "
                "\n\t-------------------------------------------------------\n",
                LOG03);
    }

    fclose(stStatus.LogFile);
    fclose(stStatus.ErrFile);
    fclose(stLineaComando.fpDat);

    return(0);
}
/***************************   fin  main    **********************************/


/*****************************************************************************/
/* bfnOraGenLibro(int iMesAux,int iAnoAux)                                   */
/*****************************************************************************/

static BOOL bfnOraGenLibro(LINEACOMANDO stLineaComando)
{
	char modulo[]="bfnOraGenLibro";

     int  iTipDocumento = 0        ;
     char *szFecInicio             ;
     char *szFecFin                ;
     int  iSqlCodeFactLib = SQLOK  ;
     int  iSqlCodeConsumo = SQLOK  ;
     char szNomTabla   [20]        ;
     int  iMesAux                  ;
     int  iAnoAux                  ;
     int  iConReg = 0              ;
     int  iDoc = 0                 ;
     char szCod_Oficina [3]        ;
     BOOL OptInsert                ;
     BOOL BFlagOficina             ;

    GHISTDOCU stGHistDocu          ;

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        char    szhNomRepLegal[132] ;  /* EXEC SQL VAR szhNomRepLegal  IS STRING (132); */ 

        char    szhRutRepLegal[22]  ;  /* EXEC SQL VAR szhRutRepLegal  IS STRING (22); */ 

	    char    szhFecInicio [9]    ;  /* EXEC SQL VAR szhFecInicio    IS STRING (9); */ 

	    char    szhFecFin    [9]    ;  /* EXEC SQL VAR szhFecFin       IS STRING (9); */ 

		long    lhBoletasAmistar    = 0;
        long    lhNetoAmistar       = 0;
        long    lhIvaAmistar        = 0;
        long    lhTotalAmistar      = 0;
        int     ihNomRepLegal       ;
        int     ihRutRepLegal       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 



    iMesAux = stLineaComando.iMes;
    iAnoAux = stLineaComando.iAno;
    strcpy(szNomTabla,stLineaComando.szTabla);

    vDTrazasLog ( modulo,"\n\tParametros de Entrada"
                         "\n\t\t==>  Mes Actual [%02d]"
                         "\n\t\t==>  Ano Actual [%04d]"
                         "\n\t\t==>  Tabla      [%s]"
                         ,LOG03,iMesAux,iAnoAux,szNomTabla);


    szFecInicio = (char *) malloc(8);
    szFecFin    = (char *) malloc(8);
    sprintf(szFecInicio ,"01%02d%04d", iMesAux, iAnoAux );
    sprintf(szFecFin    ,"01%02d%04d", ((iMesAux != 12) ? iMesAux+1 : 1) ,((iMesAux != 12) ? iAnoAux : iAnoAux+1));

	strcpy(szhFecInicio,szFecInicio);
	strcpy(szhFecFin,szFecFin);

    vDTrazasLog ( modulo,"\n\tParametros Calculados"
                         "\n\t\t==>  szFecInicio [%s]"
                         "\n\t\t==>  szFecFinal  [%s]"
                         ,LOG03,szhFecInicio,szhFecFin );

    /****************************************************************/
    /*  Rescata Informacion del Representante Legal de la Empresa   */
    /****************************************************************/

    vDTrazasLog ( modulo,"\n\tFAD_NOM_REP_LEGAL [%d]"
                         "\n\tFAD_RUT_REP_LEGAL [%d]"
                         ,LOG06,FAD_NOM_REP_LEGAL, FAD_RUT_REP_LEGAL);
    vDTrazasLog ( modulo,"\n\tSelecciona Nombre del Representante Legal",LOG04);


    if (ifnGetParametro (FAD_NOM_REP_LEGAL, szTipParametro, szValParametro))
    {
        vDTrazasError(szExeName,"\n\tError en obtencion de codigo de documento [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	strcpy(szNomRepLegal, szValParametro);

    if (ifnGetParametro (FAD_RUT_REP_LEGAL, szTipParametro, szValParametro))
        return (FALSE);

    strcpy(szRutRepLegal, szValParametro);


/***************************************************************************************/
/**** IMPRESION DEL LIBRO DE VENTAS ****************************************************/
/***************************************************************************************/

    if (stLineaComando.bImprime) 
    {
        vDTrazasLog  (szExeName,"\n\t************ Funciones de Impresion  ***********",LOG03);
        if (!bfnLlenaArchivoImpresion(szFecInicio,szFecFin))
             return FALSE;
    }

    vDTrazasLog  (szExeName,"\n\n\tTermino Ok Funcion OraGenLibro",LOG03);
    return TRUE;
}/************************   Final bfnOraGenLibro  **************************/


/****************************************************************************/
/************************         Impresion         *************************/
/*                    Funcion bfnLlenaArchivoImpresion                      */
/****************************************************************************/
static BOOL bfnLlenaArchivoImpresion(char *szFecInicio, char *szFecFin)
{
char modulo[]="bfnLlenaArchivoImpresion";
static char szCadenaSQL[2048];
int    iSqlLibroIva = 0;
int    iNumPag  = 1          ;
int    iDoc=0				 ;
long   lCon_Reg = 0          ;
long   lTot_Reg = 0          ;
int    iCant_Regs = 0        ;
int    i  = 0                ;
int    iCargaFile = 0        ;
char   szTipParametro [33] ="";
char   szValParametro [512]=""; 

/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhFecInicio [9]     ;   /* EXEC SQL VAR szhFecInicio  IS STRING (9); */ 
   /*  DDMMYYYY  */
     char szhFecFin    [9]     ;   /* EXEC SQL VAR szhFecFin     IS STRING (9); */ 
   /*  DDMMYYYY  */
     int  ihCod_tipdocumalm    ;
     char szhCodOficina[3]     ;
     char szhDesOficina[41]    ;
     /* VARCHAR szahCod_Oficina [MAX_REGISTROS][3]; */ 
struct { unsigned short len; unsigned char arr[6]; } szahCod_Oficina[500];

     /* VARCHAR szahDes_Oficina [MAX_REGISTROS][41]; */ 
struct { unsigned short len; unsigned char arr[42]; } szahDes_Oficina[500];

/* EXEC SQL END DECLARE SECTION; */ 


GHISTDOCU stGHistDocu;

    vDTrazasLog ( modulo,"\n\t\t** Funcion bfnLlenaArchivoImpresion  **",LOG04);

    strcpy(szhFecInicio,szFecInicio);
    strcpy(szhFecFin   ,szFecFin)  ;
    strcpy(szDia_Aux,"\0");

    iIndPrefFolio = 0;
	/* 03-09-2003 Obtiene parametro de mascara de prefijo folio */
    if (ifnGetParametro2 (104, szTipParametro, szValParametro))
    {
        vDTrazasError(szExeName,"\n\tError en obtencion de indicador de mascara de pref.folio  [%d]:[%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    iIndPrefFolio=atoi(szValParametro);

    memset(szahCod_Oficina,0,sizeof(szahCod_Oficina));

    /* EXEC SQL
    SELECT COD_OFICINA      ,
           DES_OFICINA
    INTO   :szahCod_Oficina ,
           :szahDes_Oficina
    FROM   GE_OFICINAS
    WHERE  COD_OFICINA IN (SELECT COD_OFICINA FROM FAT_DETLIBROIVA
                           WHERE FEC_EMISION >= TO_DATE(:szhFecInicio,'ddmmyyyy')
                           AND   FEC_EMISION <  TO_DATE(:szhFecFin   ,'ddmmyyyy'))
    ORDER BY COD_REGION, COD_COMUNA , COD_OFICINA ASC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA ,DES_OFICINA into :b0,:b1  from GE_OFI\
CINAS where COD_OFICINA in (select COD_OFICINA  from FAT_DETLIBROIVA where (FE\
C_EMISION>=TO_DATE(:b2,'ddmmyyyy') and FEC_EMISION<TO_DATE(:b3,'ddmmyyyy'))) o\
rder by COD_REGION,COD_COMUNA,COD_OFICINA asc  ";
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szahCod_Oficina;
    sqlstm.sqhstl[0] = (unsigned long )5;
    sqlstm.sqhsts[0] = (         int  )8;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szahDes_Oficina;
    sqlstm.sqhstl[1] = (unsigned long )43;
    sqlstm.sqhsts[1] = (         int  )44;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecInicio;
    sqlstm.sqhstl[2] = (unsigned long )9;
    sqlstm.sqhsts[2] = (         int  )9;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecFin;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )9;
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



    iCant_Regs = SQLROWS;

    vDTrazasLog ( modulo,"\n\t** Cantidad de Registros en LlenaArchivoImpresion  [%d]**"
                         "\n\t** SQLCODE  en LlenaArchivoImpresion  [%d]**"
                         ,LOG06,iCant_Regs, SQLCODE);

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)   {
		vDTrazasError(modulo,"\n\t<< Error en Select de Codigos de Oficina >>\n\t",LOG01);
		vDTrazasLog  (modulo,"\n\t<< Select de Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }
    if ((SQLCODE == SQLNOTFOUND) && (iCant_Regs == 0))  {
		vDTrazasError(modulo,"\n\t<< No Existen Codigos de Oficina >>\n\t",LOG01);
		vDTrazasLog  (modulo,"\n\t<< No Existen Codigos de Oficina >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        return (FALSE);
    }

    for (i=0;i<iCant_Regs;i++)   {

        memset(&stTotTipDoc   ,0,sizeof(GTOTTIPDOCUM)*NUM_TIPDOCUM);
        memset(&stAcumulador  ,0,sizeof(GACUMULADOR ));

        memset(szhCodOficina  ,0,sizeof(szhCodOficina));
        sprintf(szhCodOficina ,"%.*s\0",szahCod_Oficina[i].len, szahCod_Oficina[i].arr);

        memset(szhDesOficina,0,sizeof(szhDesOficina));
        sprintf(szhDesOficina,"%.*s\0",szahDes_Oficina[i].len, szahDes_Oficina[i].arr);

        vDTrazasLog ( modulo,"\n\t** szhCodOficina  [%s %s]**",LOG06,szhCodOficina,szhDesOficina);

        for (iDoc=1;iDoc<=2;iDoc++) 
        {
            lCon_Reg = 0 ;
        	switch(iDoc) 	
        	{
        		case 1 :
        		    ihCod_tipdocumalm = iCodBoletaAuto;
        			break;
        		case 2 :
        			ihCod_tipdocumalm = iCodBoletaAutoExen;
        			break;
        		case 3 :
        		    ihCod_tipdocumalm = 69;
        			break;
        		case 4 :
        			ihCod_tipdocumalm = 73;
        			break;
        	}

        	memset(szCadenaSQL,0,sizeof(szCadenaSQL));
            sprintf(szCadenaSQL,"\tSELECT COD_TIPDOCUMALM,\n"
            					"\t       NUM_FOLIO,\n"
            					"\t       COD_OFICINA,\n"
            					"\t       IND_ANULADA,\n"
            					"\t       IND_ORDENTOTAL,\n"
            					"\t       COD_TIPDOCUM,\n"
            					"\t       TO_CHAR(FEC_EMISION,'dd/mm/yyyy'),\n"
            					"\t       NUM_IDENTTRIB,\n"
            					"\tSUBSTR(NOM_CLIENTE,1,31),\n"
            					"\t       TOT_NETOGRAV,\n"
            					"\t       TOT_NETONOGRAV,\n" 
            					"\t       TOT_IVA,\n"
            					"\t       TOT_FACTURA,\n" 
            					"\t       TO_CHAR(FEC_EMISION,'DD'),\n"
            					"\t       TO_CHAR(FEC_EMISION,'mm/yyyy'),\n"
            					"\t       COD_CLIENTE,\n"
            					"\t       TO_CHAR(FEC_VENCIMIENTO,'dd/mm/yyyy') , \n"
            					"\t       PREF_PLAZA \n"
            					"\tFROM   FAT_DETLIBROIVA\n"
            					"\tWHERE  FEC_EMISION  >= TO_DATE('%s','ddmmyyyy') \n"
            					"\tAND    FEC_EMISION  < TO_DATE('%s','ddmmyyyy')\n"
            					"\tAND    COD_TIPDOCUMALM = %d\n" 
            					"\tAND    COD_OFICINA     = '%s'\n"
            					"\tAND    IND_DUPLICADO   = 'N'\n"
            					"\tORDER BY 14 asc, 2 \n"
            					,szhFecInicio,szhFecFin,ihCod_tipdocumalm,szhCodOficina);


            vDTrazasLog ( modulo,"\n\t** Cadena Sql **\n%s\n",LOG04,szCadenaSQL);

        	/* EXEC SQL PREPARE stLibroIva FROM :szCadenaSQL; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )36;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
         sqlstm.sqhstl[0] = (unsigned long )2048;
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
        		vDTrazasError(modulo,"\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'PREPARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

         	/* EXEC SQL DECLARE  CursorLibroIva CURSOR for stLibroIva; */ 

        	if (SQLCODE != SQLOK) {
        		vDTrazasError(modulo,"\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'DECLARE' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

        	/* EXEC SQL OPEN CursorLibroIva ; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )55;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqcmod = (unsigned int )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


        	if (SQLCODE != SQLOK) {
        		vDTrazasError(modulo,"\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        		vDTrazasLog  (modulo,"\n\t<< Error en 'OPEN' de CursorLibroIva >>\n\t[%d] : [%s]",LOG01, SQLCODE,SQLERRM);
        	    return FALSE;
        	}

            memset(&stGHistDocu,0,sizeof(GHISTDOCU));
            iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);

            if (iSqlLibroIva==SQLOK)  
            {
                strcpy(szDia_Aux,stGHistDocu.szDia_Emision);
                lFolio_Desde    = stGHistDocu.lNumFolio;
                lFolio_Hasta    = stGHistDocu.lNumFolio;
                lFolio_Anterior = stGHistDocu.lNumFolio;
            }

            while (iSqlLibroIva == SQLOK) {
                if (stGHistDocu.iIndAnulada != iDocAnulado ) 
                   bfnAcumulaDocumentoFinal(iDoc,stGHistDocu);
                if (stGHistDocu.iIndAnulada != iDocAnulado ) 
                   bfnAcumulaDocumento(iDoc,stGHistDocu);

                if ((strlen(szBuffer)+1+MAX_LARGOREGISTRO) >= MAX_SIZEBUFFER) 
                {
                    if (!bfnEscribeLibro ( szBuffer
                                          ,iNumPag
                                          ,iDoc
                                          ,stLineaComando.iMes
                                          , stLineaComando.iAno
                                          ,szhCodOficina
                                          ,szhDesOficina))
                        return (FALSE);
                    else
                        iNumPag++;
                }

                if (stGHistDocu.iIndAnulada != iDocAnulado ) 
                {
                    bfnEscribeBuffer(iDoc, stGHistDocu, &iCargaFile);
                    lCon_Reg++;
                    lTot_Reg++;
                }

                iSqlLibroIva = bfnFetchLibroIva(&stGHistDocu);

            }


        	if ((iSqlLibroIva != SQLOK ) && (iSqlLibroIva != SQLNOTFOUND )) return (FALSE);

        	if (!bfnCloseFat_DetLibroIva())
            	return (FALSE);


            if (lCon_Reg > 0) {

                if (strlen(szBuffer) > 0 )	{
            	    if (!bfnEscribeLibro(szBuffer
            	                        ,iNumPag
            	                        ,iDoc
            	                        ,stLineaComando.iMes
            	                        ,stLineaComando.iAno
            	                        ,szhCodOficina
            	                        ,szhDesOficina))
               		    return (FALSE);
            		else
                		iNumPag++;
                }

           		vDTrazasLog  (modulo,"\t\t  Entra a Escribe Tot Docum por iDoc.......",LOG06);
            	if (!bfnEscribeTotDocum(iDoc))
                	return (FALSE);

            }
        } /*end for 2*/

    }   /*end for 1*/


    if (lTot_Reg > 0) {
        vDTrazasLog ( modulo,"\t\t** Funcion EscribeTotLibro  **",LOG05);
        if (!bfnEscribeTotLibro(stLineaComando.iMes,stLineaComando.iAno))
            return (FALSE);

        vDTrazasLog ( modulo,"\t\t** Funcion EscribeEstadisticas  **",LOG05);
        vfnEscribeEstadisticas();
    }

    vDTrazasLog ( modulo,"\n\t** Fin Funcion Llena Archivo de Impresion OK **",LOG04);
	return TRUE ;
}

/****************************************************************************/
/*                         Funcion bfnFetchLibroIva                         */
/****************************************************************************/
static int bfnFetchLibroIva( GHISTDOCU *stGHistDocu)
{
char modulo[]="bfnFetchLibroIva";

/* EXEC SQL BEGIN DECLARE SECTION ; */ 

    int    ihCod_tipdocumalm   ;
    long   lhNum_folio         ;
    char   szhCod_oficina  [3] ; /* EXEC SQL VAR szhCod_oficina    IS STRING (3); */ 

    int    ihInd_anulada       ;
    long   lhInd_ordentotal    ;
    int    ihCod_tipdocum      ;
    char   szhFec_emision  [15]; /* EXEC SQL VAR szhFec_emision    IS STRING (15); */ 

    char   szhNum_identtrib[21]; /* EXEC SQL VAR szhNum_identtrib  IS STRING (21); */ 

    char   szhNom_cliente  [60]; /* EXEC SQL VAR szhNom_cliente    IS STRING (60); */ 

    char   szhDia_Emision  [3] ; /* EXEC SQL VAR szhDia_Emision    IS STRING (3); */ 

    char   szhMesAno       [8] ; /* EXEC SQL VAR szhMesAno         IS STRING (8); */ 

    double dhTot_netograv      ;
    double dhTot_netonograv    ;
    double dhTot_iva           ;
    double dhTot_factura       ;
    long   lhCod_Cliente       ;
    char   szhFec_Vencimien[15]; /* EXEC SQL VAR szhFec_Vencimien IS STRING (15); */ 

    char   szhPrefPlaza	    [4]; /* EXEC SQL VAR szhPrefPlaza IS STRING (4); */ 

    short  s_ihPrefPlaza       ;
/* EXEC SQL END DECLARE SECTION   ; */ 



    vDTrazasLog ( modulo,"\n\t** Funcion bfnFetchLibroIva  **",LOG05);

	/* EXEC SQL
	FETCH  CursorLibroIva INTO
           :ihCod_tipdocumalm,
           :lhNum_folio      ,
           :szhCod_oficina   ,
           :ihInd_anulada    ,
           :lhInd_ordentotal ,
           :ihCod_tipdocum   ,
           :szhFec_emision   ,
           :szhNum_identtrib ,
           :szhNom_cliente   ,
           :dhTot_netograv   ,
           :dhTot_netonograv ,
           :dhTot_iva        ,
           :dhTot_factura    ,
           :szhDia_Emision   ,
           :szhMesAno        ,
           :lhCod_Cliente    ,
           :szhFec_Vencimien ,
           :szhPrefPlaza	 :s_ihPrefPlaza; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 18;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )70;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_tipdocumalm;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_folio;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCod_oficina;
 sqlstm.sqhstl[2] = (unsigned long )3;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihInd_anulada;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhInd_ordentotal;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_tipdocum;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)szhFec_emision;
 sqlstm.sqhstl[6] = (unsigned long )15;
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhNum_identtrib;
 sqlstm.sqhstl[7] = (unsigned long )21;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhNom_cliente;
 sqlstm.sqhstl[8] = (unsigned long )60;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&dhTot_netograv;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&dhTot_netonograv;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)&dhTot_iva;
 sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)&dhTot_factura;
 sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)szhDia_Emision;
 sqlstm.sqhstl[13] = (unsigned long )3;
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
 sqlstm.sqadto[13] = (unsigned short )0;
 sqlstm.sqtdso[13] = (unsigned short )0;
 sqlstm.sqhstv[14] = (unsigned char  *)szhMesAno;
 sqlstm.sqhstl[14] = (unsigned long )8;
 sqlstm.sqhsts[14] = (         int  )0;
 sqlstm.sqindv[14] = (         short *)0;
 sqlstm.sqinds[14] = (         int  )0;
 sqlstm.sqharm[14] = (unsigned long )0;
 sqlstm.sqadto[14] = (unsigned short )0;
 sqlstm.sqtdso[14] = (unsigned short )0;
 sqlstm.sqhstv[15] = (unsigned char  *)&lhCod_Cliente;
 sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[15] = (         int  )0;
 sqlstm.sqindv[15] = (         short *)0;
 sqlstm.sqinds[15] = (         int  )0;
 sqlstm.sqharm[15] = (unsigned long )0;
 sqlstm.sqadto[15] = (unsigned short )0;
 sqlstm.sqtdso[15] = (unsigned short )0;
 sqlstm.sqhstv[16] = (unsigned char  *)szhFec_Vencimien;
 sqlstm.sqhstl[16] = (unsigned long )15;
 sqlstm.sqhsts[16] = (         int  )0;
 sqlstm.sqindv[16] = (         short *)0;
 sqlstm.sqinds[16] = (         int  )0;
 sqlstm.sqharm[16] = (unsigned long )0;
 sqlstm.sqadto[16] = (unsigned short )0;
 sqlstm.sqtdso[16] = (unsigned short )0;
 sqlstm.sqhstv[17] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[17] = (unsigned long )4;
 sqlstm.sqhsts[17] = (         int  )0;
 sqlstm.sqindv[17] = (         short *)&s_ihPrefPlaza;
 sqlstm.sqinds[17] = (         int  )0;
 sqlstm.sqharm[17] = (unsigned long )0;
 sqlstm.sqadto[17] = (unsigned short )0;
 sqlstm.sqtdso[17] = (unsigned short )0;
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



    vDTrazasLog ( modulo,"\n\t** SQLCODE EN bfnFetchLibroIva [%d] **",LOG06,SQLCODE);

	if ((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND)) {
		vDTrazasError(modulo,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"\n\t<< Error en 'FETCH' de CursorLibroIva >>\n\t[%d] : [%s]", LOG01, SQLCODE,SQLERRM);
	    return SQLCODE;
	}

	if (SQLCODE == SQLNOTFOUND) {
		vDTrazasLog  (modulo,"\n\t<< Fin de Registros en CursorLibroIva >>", LOG03);
	    return SQLCODE;
	}


    vDTrazasLog ( modulo,"\n\t\t** Datos del FetchLibroIva (Impresion)**"
                         "\n\t\t** szhFec_emision......[%s]" 
                         "\n\t\t** szhCod_cliente......[%ld]" 
                         "\n\t\t** szhNom_cliente......[%s]" 
                         "\n\t\t** szhNum_identtrib....[%s]" 
                         "\n\t\t** szhCod_oficina......[%s]" 
                         "\n\t\t** lhNum_folio.........[%ld]"
                         "\n\t\t** dhTot_netonograv....[%f]" 
                         "\n\t\t** dhTot_netograv......[%f]" 
                         "\n\t\t** dhTot_iva...........[%f]" 
                         "\n\t\t** dhTot_factura.......[%f]" 
                         "\n\t\t** ihInd_anulada.......[%d]" 
                         "\n\t\t** ihCod_tipdocumalm...[%d]" 
                         "\n\t\t** szhCod_oficina......[%s]" 
                         "\n\t\t** szDia_Emision.......[%s]" 
                         "\n\t\t** szhMesAno...........[%s]" 
                         ,LOG04,szhFec_emision      ,lhCod_Cliente
                         ,szhNom_cliente            ,szhNum_identtrib
                         ,szhCod_oficina            ,lhNum_folio
                         ,dhTot_netonograv          ,dhTot_netograv
                         ,dhTot_iva                 ,dhTot_factura
                         ,ihInd_anulada             ,ihCod_tipdocumalm
                         ,szhCod_oficina            ,szhDia_Emision
                         ,szhMesAno);        
    

	
	
    strcpy(stGHistDocu->szFecEmision    ,szhFec_emision)   ;
    strcpy(stGHistDocu->szNomCliente    ,szhNom_cliente)   ;
    strcpy(stGHistDocu->szRut           ,szhNum_identtrib) ;
    strcpy(stGHistDocu->szCod_Oficina   ,szhCod_oficina)   ;
    strcpy(stGHistDocu->szDia_Emision   ,szhDia_Emision)   ;
    strcpy(stGHistDocu->szMesAno        ,szhMesAno)        ;
    strcpy(stGHistDocu->szFecVencimiento,szhFec_Vencimien) ;
    if (s_ihPrefPlaza == ORA_NULL)    sprintf(stGHistDocu->szPrefPlaza, "   \0" );
        else                          sprintf(stGHistDocu->szPrefPlaza  ,"%s\0" ,szhPrefPlaza);

    stGHistDocu->lNumFolio       = lhNum_folio      ;
    stGHistDocu->dAcumNetoNoGrav = dhTot_netonograv ;
    stGHistDocu->dAcumNetoGrav   = dhTot_netograv   ;
    stGHistDocu->dAcumIva        = dhTot_iva        ;
    stGHistDocu->dTotDocumento   = dhTot_factura    ;
    stGHistDocu->iIndAnulada     = ihInd_anulada    ;
    stGHistDocu->iCod_tipdocumalm= ihCod_tipdocumalm;
    stGHistDocu->lCodCliente     = lhCod_Cliente    ;

    return SQLCODE;

}
/****************************************************************************/
/*                         funcion : bfnCloseFat_DetLibroIva                */
/****************************************************************************/
static BOOL bfnCloseFat_DetLibroIva()
{
	char modulo[]="bfnCloseDocumentos";

    vDTrazasLog (modulo,"\n\t** Close Cursor LibroIva " ,LOG04);

	/* EXEC SQL CLOSE CursorLibroIva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 18;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )157;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)    {
        vDTrazasLog  (modulo,"<< Error en Close Close Cursor LibroIva >>"
                                ,LOG01);
        vDTrazasError(modulo,"<< Error en Close Close Cursor LibroIva >>\n\t[%d] : [%s]"
                                ,LOG01,SQLCODE,SQLERRM);
        return FALSE;
    }

    return TRUE;

}/********************* Final bfnCloseFat_DetLibroIva  **********************/


/****************************************************************************/
/*                         Funcion bfnEscribeBuffer                         */
/****************************************************************************/
static void bfnEscribeBuffer(int iDoc, GHISTDOCU  pstGHistDocu, int *iCargaFile)
{
char modulo[]="bfnEscribeBuffer";
static char szaux1[MAX_LARGOREGISTRO];
static char szaux2[MAX_LARGOREGISTRO];


    vDTrazasLog  (modulo,"\n\t** Escribe en Buffer (bfnEscribeBuffer)  **",LOG04);

    vDTrazasLog(modulo,"\tDatos . \n\tFecha Emision  : %s\n\tNum Folio      : %10ld\n"
                       "\tNom Cliente    : %s\n\tRut            : %s\n\tNeto no grav   : %f\n\tNeto Grav      : %f\n"
                       "\tAcum Iva       : %f\n\tTot Documento  : %f\n\tDia Emision    : %s\n\tPrefijo Plaza  : %s",LOG04,
			            pstGHistDocu.szFecEmision   ,pstGHistDocu.lNumFolio ,pstGHistDocu.szNomCliente ,
			            pstGHistDocu.szRut          ,pstGHistDocu.dAcumNetoNoGrav,pstGHistDocu.dAcumNetoGrav  ,
			            pstGHistDocu.dAcumIva       ,pstGHistDocu.dTotDocumento ,pstGHistDocu.szDia_Emision,
			            pstGHistDocu.szPrefPlaza );

    sprintf(szaux1,"%-10s %s%s%9ld %-10s %10ld %-31s %20s   %14.0f  %14.0f  %14.0f  %14.0f",  /*  Largo de Registros 164 < 170 bytes */
                pstGHistDocu.szFecEmision   ,
                (iIndPrefFolio == 0 ?  pstGHistDocu.szPrefPlaza : "   " )    ,
                (iIndPrefFolio == 0 ? "-" : " " )    ,
                pstGHistDocu.lNumFolio      ,
                pstGHistDocu.szFecVencimiento,
                pstGHistDocu.lCodCliente    ,
                pstGHistDocu.szNomCliente   ,
                pstGHistDocu.szRut          ,
                pstGHistDocu.dAcumNetoNoGrav,
                pstGHistDocu.dAcumNetoGrav  ,
                pstGHistDocu.dAcumIva       ,
                pstGHistDocu.dTotDocumento  );
    /************************************************/
    /*  Formatea la Linea a 200 bytes   199 + \n    */
    /************************************************/
    sprintf(szaux2,"%-.198s\n",szaux1);
    strcat(szBuffer, szaux2);
    return;
}/***********************   Final bfnEscribeBuffer   ********************/

/************************************************************************/
/*  Escribe el contenido de buffer un fichero de Datos                  */
/************************************************************************/
static BOOL bfnEscribeLibro ( char *szBuf
                            , int iPag
                            , int iTipDoc
                            , int iMesAux
                            , int iAnoAux
                            , char *szCodOficina
                            , char *szDesOficina)
{
char modulo[]="bfnEscribeLibro";
int  retprint ;

    vDTrazasLog  (modulo,"\n\t** Escribe en Archivo (bfnEscribeLibro)  **",LOG05);

    if (strlen(szBuf) == 0)
        return (TRUE);

    if (!bfnEscribeCab(iPag, iTipDoc, iMesAux, iAnoAux, szCodOficina,szDesOficina))
        return (FALSE);


    if ( (retprint= fprintf(stLineaComando.fpDat,szBuf)) <= 0 )   {
        vDTrazasLog  (modulo,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);
        vDTrazasError(modulo,"\n\t(bEscribeFich) Error al Escribir Archivo  [%d]",LOG01,retprint);

        memset(szBuf,0,sizeof(szBuf));
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat); */
    memset(szBuf,0,sizeof(szBuf));
    return (TRUE);
}/******************* Final bfnEscribeFich **************************/

/************************************************************************/
/*  Escribe la cabecera de cada Pagina                                  */
/************************************************************************/
static BOOL bfnEscribeCab(int iPag, int iTipDoc, int iMesAux, int iAnoAux, char *szCodOficina, char *szDesOficina)
{
char modulo[]="bfnEscribeCab";
static int  retprint                                            ;
static char szCabecera [MAX_LARGOREGISTRO*LINEAS_CABECERA]  = "";
static char szlinaux1  [MAX_LARGOREGISTRO]                  = "";
static char szlinaux2  [MAX_LARGOREGISTRO]                  = "";
static char szVacio    [1]                                  = "";

    vDTrazasLog  (modulo,"\n\t** Escribe Cabecera en Archivo (bfnEscribeCab)  **",LOG05);

    /********************************************************************/
    /* Creacion de la Cabecera                                          */
    /********************************************************************/

    sprintf(szlinaux1,"\f\n\t\t\t\t\t\t\t\tLIBRO DE VENTAS DE %s DEL %d"
                     ,szNombreMes[iMesAux-1],iAnoAux);
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);
    sprintf(szlinaux1,"  Rep.    : %-s %105s Pag.Nro. %10d",szNomRepLegal,szVacio,iPag);
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);
    sprintf(szlinaux1,"  Rut     : %-s ",szRutRepLegal);
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);
    sprintf(szlinaux1,"  Oficina : %s  %s",szCodOficina,szDesOficina);
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);
    strcpy (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    sprintf(szlinaux1,"%6s %12s %13s %10s %18s %28s %20s %16s %15s %16s"
                     ,"Fecha","Folio","Vencimento","Cuenta", "Nombre","Rut"
                     ,"Exento","Afecto","Iva","Total");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    strcpy (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    strcat (szlinaux1,"-------------------------------------------------------");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szCabecera, szlinaux2);

    if (strlen(szCabecera) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szCabecera)) <= 0 )
    {
        vDTrazasLog  (modulo,"\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,"\n\t(bfnEscribeCab) Error al Escribir Cabecera en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat); */
    memset(szCabecera,0,sizeof(szCabecera));
    return (TRUE);
}/********************* Final bfnEscribeCab   **************************/


/****************************************************************************/
/*                        Funcion bfnAcumulaDocumento                       */
/****************************************************************************/
static void bfnAcumulaDocumento(int iTipDocumento, GHISTDOCU pstGHistDocu )
{
char modulo[]="bfnAcumulaDocumento";

    vDTrazasLog  (modulo,"\n\t** Acumulando Documento : %s (bfnAcumulaDocumento)**"
                             "\n\t\t==>  Pref. Plaza [%s]  Folio   [%ld]"
                            ,LOG05,szNombreDocs[iTipDocumento],pstGHistDocu.szPrefPlaza , pstGHistDocu.lNumFolio);

    if (pstGHistDocu.iIndAnulada == iDocOk)
        stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosOk++;
    else
        stTotTipDoc[pstGHistDocu.iCodTipDocum].lNumDocumentosAnul++;

    stTotTipDoc[pstGHistDocu.iCodTipDocum].dNetoDocumentos   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dExentoDocumentos += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dIvaDocumentos    += pstGHistDocu.dAcumIva        ;
    stTotTipDoc[pstGHistDocu.iCodTipDocum].dTotalDocumentos  += pstGHistDocu.dAcumNetoGrav   +
                                                                pstGHistDocu.dAcumNetoNoGrav +
                                                                pstGHistDocu.dAcumIva ;

	switch(iTipDocumento)
	{
		case 1 :
			if (pstGHistDocu.iIndAnulada == iDocAnulado)
			{
	            		stAcumulador.lNumBoletaAnul++;
	            	}
		        stAcumulador.lNumBoleta      ++                              ;
		        stAcumulador.dNetoBoleta     += pstGHistDocu.dAcumNetoGrav   ;
	    		stAcumulador.dExentoBoleta   += pstGHistDocu.dAcumNetoNoGrav ;
	        	stAcumulador.dIvaBoleta      += pstGHistDocu.dAcumIva        ;
	        	stAcumulador.dTotalBoleta    += pstGHistDocu.dAcumNetoGrav   +
	        					pstGHistDocu.dAcumIva        +
					                pstGHistDocu.dAcumNetoNoGrav ; /* CH-200312091557 */
			break;

		case 2 :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumulador.lNumBoletaExenAnul++;
	        	}
		        stAcumulador.lNumBoletaExen      ++                               ;
		        stAcumulador.dNetoBoletaExen      =  0							  ;
	    	        stAcumulador.dExentoBoletaExen   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumulador.dIvaBoletaExen       =  0							  ;
	        	stAcumulador.dTotalBoletaExen    += pstGHistDocu.dAcumNetoNoGrav  ;
			break;
		case 3 :
			if (pstGHistDocu.iIndAnulada == iDocAnulado)
			{
	            	    stAcumulador.lNumBoletaAnulAfec69++; 
	            	}
		        stAcumulador.lNumBoletaAfec69    ++                              ;
		        stAcumulador.dNetoBoletaAfec69   += pstGHistDocu.dAcumNetoGrav   ;
  	    	    	stAcumulador.dExentoBoletaAfec69 += pstGHistDocu.dAcumNetoNoGrav ; /* CH-200312091557 */
	        	stAcumulador.dIvaBoletaAfec69    += pstGHistDocu.dAcumIva        ;
	        	stAcumulador.dTotalBoletaAfec69  += pstGHistDocu.dAcumNetoGrav + 
					                    pstGHistDocu.dAcumIva +
					                    pstGHistDocu.dAcumNetoNoGrav ; /* CH-200312091557 */
			break;
    		case 4 :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumulador.lNumBoletaExenAnul73++;
	        	}
		        stAcumulador.lNumBoletaExen73++                               ;
		        stAcumulador.dNetoBoletaExen73      =  0							  ;
	    	        stAcumulador.dExentoBoletaExen73   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumulador.dIvaBoletaExen73       =  0							  ;
	        	stAcumulador.dTotalBoletaExen73    += pstGHistDocu.dAcumNetoNoGrav  ;
		        break;

    }/* end switch */

    return;
}/*********************** Final bfnAcumulaDocumento *************************/

/************************************************************************/
/*  Escribe Total por Tipo de Documento                                 */
/************************************************************************/
static BOOL bfnEscribeTotDocum(int iTipDocumento)
{
    char modulo[]="bfnEscribeTotDocum";

    static int  retprint                                            ;
    static char szTotDocum  [MAX_LARGOREGISTRO*LINEAS_SUBTOTAL]= "" ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = "" ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = "" ;
    static char szVacio     [1]                                = "" ;
    static char szDia_Aux   [3]                                = "" ;
    static char szDia_Emi   [3]                                = "" ;

    vDTrazasLog  (modulo,"\n\t** Escribe Total por Documento : %s **",LOG04,szNombreDocs[iTipDocumento]);

    /********************************************************************/
    /* Creacion de la Total de Documento                                */
    /********************************************************************/

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);

	switch(iTipDocumento)
	{
		case 1 :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETAS AFECTAS"
            	                ,stAcumulador.lNumBoleta
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoleta
                        	    ,stAcumulador.dNetoBoleta
                            	,stAcumulador.dIvaBoleta
                            	,stAcumulador.dTotalBoleta );
        	sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;

    	case 2 :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETAS EXENTAS"
            	                ,stAcumulador.lNumBoletaExen
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoletaExen
                        	    ,stAcumulador.dNetoBoletaExen
                            	,stAcumulador.dIvaBoletaExen
                            	,stAcumulador.dTotalBoletaExen );
        	sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;
    	case 3 :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETA CICLO AFECTA FA"
            	                ,stAcumulador.lNumBoletaAfec69
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoletaAfec69
                        	    ,stAcumulador.dNetoBoletaAfec69
                            	,stAcumulador.dIvaBoletaAfec69
                            	,stAcumulador.dTotalBoletaAfec69 );
        	sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;
    	case 4 :
            sprintf(szlinaux1   ,"%-49s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
        	                    ,"SUB-TOTAL BOLETA CICLO EXENTA FA"
            	                ,stAcumulador.lNumBoletaExen73
                	            ,szVacio
                    	        ,stAcumulador.dExentoBoletaExen73
                        	    ,stAcumulador.dNetoBoletaExen73
                            	,stAcumulador.dIvaBoletaExen73
                            	,stAcumulador.dTotalBoletaExen73 );
        	sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);
        	break;


    } /*end switch */

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotDocum, szlinaux2);

    if (strlen(szTotDocum) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szTotDocum)) <= 0 )
    {
        vDTrazasLog  (modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    /* fflush(stLineaComando.fpDat);*/
    memset(szTotDocum,0,sizeof(szTotDocum));
    return (TRUE);
}/********************* Final bfnEscribeTotDocum ************************/

/************************************************************************/
/*  Funcion: bfnEscribeTotLibro(int, int)                               */
/************************************************************************/
/*  Escribe Total de Libro de Venta                                     */
/************************************************************************/

static BOOL bfnEscribeTotLibro(int iMesAux, int iAnoAux)
{
    char modulo[]="bfnEscribeTotLibro";

    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    int     ihMes   = iMesAux       ;
    int     ihAno   = iAnoAux       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    static int  retprint                                                ;
    static char szTotLibro  [MAX_LARGOREGISTRO*LINEAS_TATALIZADOR]= ""  ;
    static char szlinaux1   [MAX_LARGOREGISTRO]                = ""     ;
    static char szlinaux2   [MAX_LARGOREGISTRO]                = ""     ;
    static char szVacio     [1]                                = ""     ;

    int     iNUMORDEN       [10];
    int     iINDLIBRO       [10];
    char    szDESAUXILIAR   [10][45];
    int     iNUMREGISTROS   [10];
    double  dIMPEXENTO      [10];
    double  dIMPAFECTO      [10];
    double  dIMPIVA         [10];
    double  dIMPTOTAL       [10];
    int     iFilasAux           ;
    int     iInd                ;

    double  dTGenExento     = 0 ;
    double  dTGenAfecto     = 0 ;
    double  dTGenIVA        = 0 ;
    double  dTGenLibro      = 0 ;



    vDTrazasLog  (modulo,   "\n\t** Escribe Total de Libro  **"
                                "\n\t\t==>  Mes   [%d]"
                                "\n\t\t==>  Ano   [%d]"
                                ,LOG04,iMesAux,iAnoAux);

    /********************************************************************/
    /* Carga Datos Auxiliares desde FA_LIBROVTAAUX                      */
    /********************************************************************/
    /* EXEC SQL SELECT DES_AUXILIAR   ,NUM_REGISTROS   ,
                    IMP_EXENTO     ,IMP_AFECTO      ,
                    IMP_IVA        ,IMP_TOTAL
            INTO    :szDESAUXILIAR ,:iNUMREGISTROS  ,
                    :dIMPEXENTO    ,:dIMPAFECTO     ,
                    :dIMPIVA       ,:dIMPTOTAL
            FROM    FA_LIBROVTAAUX
            WHERE   COD_MES     = :ihMes
            AND     COD_ANO     = :ihAno
            ORDER BY NUM_ORDEN; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 18;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DES_AUXILIAR ,NUM_REGISTROS ,IMP_EXENTO ,IMP_AFECT\
O ,IMP_IVA ,IMP_TOTAL into :b0,:b1,:b2,:b3,:b4,:b5  from FA_LIBROVTAAUX where \
(COD_MES=:b6 and COD_ANO=:b7) order by NUM_ORDEN ";
    sqlstm.iters = (unsigned int  )10;
    sqlstm.offset = (unsigned int  )172;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szDESAUXILIAR;
    sqlstm.sqhstl[0] = (unsigned long )45;
    sqlstm.sqhsts[0] = (         int  )45;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)iNUMREGISTROS;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)dIMPEXENTO;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )sizeof(double);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)dIMPAFECTO;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)dIMPIVA;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )sizeof(double);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)dIMPTOTAL;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )sizeof(double);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihMes;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihAno;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )sizeof(int);
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


    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (modulo,"\n\t** Error en Select de FA_LIBROVTAAUX (bfnEscribeTotLibro) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t** Error en Select de FA_LIBROVTAAUX (bfnEscribeTotLibro) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    iFilasAux = SQLROWS;
    vDTrazasLog  (modulo,"\n\t** Totales Auxiliares (bfnEscribeTotLibro) [%d] **"
                                ,LOG04,iFilasAux);


    /********************************************************************/
    /* Creacion de la Total de Libro de Venta                           */
    /********************************************************************/


    strcpy (szlinaux1,"\f=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1,"RESUMEN GENERAL");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalBoleta >= 0 ? "(+)":"(-)")
                        ,"TOTAL BOLETAS AFECTAS"
                        ,stAcumuladorFinal.lNumBoleta
                        ,szVacio
                        ,stAcumuladorFinal.dExentoBoleta
                        ,stAcumuladorFinal.dNetoBoleta
                        ,stAcumuladorFinal.dIvaBoleta
                        ,stAcumuladorFinal.dTotalBoleta );

    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

/* rbr */
    sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,(stAcumuladorFinal.dTotalBoletaExen  >= 0 ? "(+)":"(-)")
                        ,"TOTAL BOLETAS EXENTAS"
                        ,stAcumuladorFinal.lNumBoletaExen /*rbr*/
                        ,szVacio
                        ,stAcumuladorFinal.dExentoBoletaExen
                        ,stAcumuladorFinal.dNetoBoletaExen
                        ,stAcumuladorFinal.dIvaBoletaExen
                        ,stAcumuladorFinal.dTotalBoletaExen );

    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


    dTGenExento     = 	stAcumuladorFinal.dExentoBoleta  	 +
    					stAcumuladorFinal.dExentoBoletaExen	 ;

    dTGenAfecto     = 	stAcumuladorFinal.dNetoBoleta    	 +
    					stAcumuladorFinal.dNetoBoletaExen  	 ;

    dTGenIVA        = 	stAcumuladorFinal.dIvaBoleta    	 +
    					stAcumuladorFinal.dIvaBoletaExen   	 ;

    dTGenLibro      = 	stAcumuladorFinal.dTotalBoleta    	 +
    					stAcumuladorFinal.dTotalBoletaExen 	 ;


    for (iInd=0;iInd<iFilasAux;iInd++)
    {
        sprintf(szlinaux1   ,"%3s %-45s %10d %36s %15.0f  %15.0f  %15.0f  %15.0f"
                            ,(dIMPTOTAL      [iInd] >= 0 ? "(+)" : "(-)")
                            ,szDESAUXILIAR  [iInd]
                            ,iNUMREGISTROS  [iInd]
                            ,szVacio
                            ,dIMPEXENTO     [iInd]
                            ,dIMPAFECTO     [iInd]
                            ,dIMPIVA        [iInd]
                            ,dIMPTOTAL      [iInd]);

        sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

        dTGenExento     += dIMPEXENTO     [iInd];
        dTGenAfecto     += dIMPAFECTO     [iInd];
        dTGenIVA        += dIMPIVA        [iInd];
        dTGenLibro      += dIMPTOTAL      [iInd];
     }

    strcpy (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    strcat (szlinaux1,"=======================================================");
    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);

    sprintf(szlinaux1   ,"%-97s %15.0f  %15.0f  %15.0f  %15.0f"
                        ,"TOTAL GENERAL LIBRO VENTA"
                        ,dTGenExento
                        ,dTGenAfecto
                        ,dTGenIVA
                        ,dTGenLibro);

    sprintf(szlinaux2,"%-.198s\n",szlinaux1); strcat(szTotLibro, szlinaux2);


    if (strlen(szTotLibro) == 0)
        return (TRUE);

    if ( (retprint= fprintf(stLineaComando.fpDat,szTotLibro)) <= 0 )
    {
        vDTrazasLog  (modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        vDTrazasError(modulo,   "\n\t(bfnEscribeTotDocum) Error al Escribir "
                                    "Total de Documento en Archivo  [%d]"
                                    ,LOG01,retprint);
        return (FALSE);
    }
    fflush(stLineaComando.fpDat);
    memset(szTotLibro,0,sizeof(szTotLibro));
    return (TRUE);
}/********************* Final bfnEscribeTotLibro  ***********************/


/************************************************************************/
/*  Funcion: vfnEscribeEstadisticas(void)                               */
/************************************************************************/
/*  Escribe Total de Libro de Venta                                     */
/************************************************************************/

static void vfnEscribeEstadisticas(void)
{
    char modulo[]="vfnEscribeEstadisticas";

    int iInd;
    vDTrazasLog  (modulo,"\n==================================="
                           "==================================="
    					 "\n\t\t** Estadisticas del Libro de Venta **"
    					 "\n==================================="
                           "===================================",LOG05);

    for (iInd=0;iInd<NUM_TIPDOCUM;iInd++)
    {
        if ((stTotTipDocFin[iInd].lNumDocumentosAnulFinal+stTotTipDocFin[iInd].lNumDocumentosOkFinal) > 0)
        {
            vDTrazasLog  (modulo, "\n\t\t==> Tipo de Documento        [%15d]"
                                  "\n\t\t==> Documentos Anulados      [%15ld]"
                                  "\n\t\t==> Documentos Emitidos      [%15ld]"
                                  "\n\t\t==> Monto Exento             [%15.0f]"
                                  "\n\t\t==> Monto Afecto             [%15.0f]"
                                  "\n\t\t==> Monto Iva                [%15.0f]"
                                  "\n\t\t==> Monto Total              [%15.0f]"
                                  ,LOG04
                                  ,iInd
                                  ,stTotTipDocFin[iInd].lNumDocumentosAnulFinal
                                  ,stTotTipDocFin[iInd].lNumDocumentosOkFinal
                                  ,stTotTipDocFin[iInd].dExentoDocumentosFinal
                                  ,stTotTipDocFin[iInd].dNetoDocumentosFinal
                                  ,stTotTipDocFin[iInd].dIvaDocumentosFinal
                                  ,stTotTipDocFin[iInd].dTotalDocumentosFinal  );
        }
    }

    vDTrazasLog  (modulo,"\n==================================="
                           "===================================",LOG05);
    return;
}/********************* Final vfnEscribeEstadisticas  ***********************/

static BOOL bfnLeeCodLibroVta (int iCodTipDocMov, int *iCodLibroVta )
{
 	char modulo[]="bfnLeeCodLibroVta";
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        int ihCodTipDocMov;
        int ihCodLibroVta ;
    /* EXEC SQL END   DECLARE SECTION  ; */ 


    ihCodTipDocMov=iCodTipDocMov;
    
    /* EXEC SQL SELECT COD_LIBROVTA
            INTO    :ihCodLibroVta
            FROM    FA_TIPDOCUMEN
            WHERE   COD_TIPDOCUMMOV = :ihCodTipDocMov; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 18;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_LIBROVTA into :b0  from FA_TIPDOCUMEN where CO\
D_TIPDOCUMMOV=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )219;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodLibroVta;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocMov;
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



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo,"\n\t** Error en Select de FA_TIPDOCUMEN (bfnLeeCodLibroVta) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo,"\n\t** Error en Select de FA_TIPDOCUMEN (bfnLeeCodLibroVta) :%d  %s **"
                                ,LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    *iCodLibroVta=ihCodLibroVta;
    
    return (TRUE);
    
}


/****************************************************************************/
/*                        Funcion bfnAcumulaDocumentoFinal                       */
/****************************************************************************/
static void bfnAcumulaDocumentoFinal(int iTipDocumento, GHISTDOCU pstGHistDocu )
{
char modulo[]="bfnAcumulaDocumentoFinal";

    vDTrazasLog  (modulo,"\n\t** Acumulando Total Final Documento : %s (bfnAcumulaDocumentoFinal)**"
                         "\n\t\t==>  Pref. Plaza [%s] Folio   [%ld]"
                         ,LOG05,szNombreDocs[iTipDocumento], pstGHistDocu.szPrefPlaza, pstGHistDocu.lNumFolio);

    if (pstGHistDocu.iIndAnulada == iDocOk)
        stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosOkFinal++;
    else
        stTotTipDocFin[pstGHistDocu.iCodTipDocum].lNumDocumentosAnulFinal++;
    
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dNetoDocumentosFinal   += pstGHistDocu.dAcumNetoGrav   ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dExentoDocumentosFinal += pstGHistDocu.dAcumNetoNoGrav ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dIvaDocumentosFinal    += pstGHistDocu.dAcumIva        ;
    stTotTipDocFin[pstGHistDocu.iCodTipDocum].dTotalDocumentosFinal  += pstGHistDocu.dAcumNetoGrav   + 
                                                                        pstGHistDocu.dAcumNetoNoGrav + 
                                                                        pstGHistDocu.dAcumIva ;       
                                                                 
	switch(iTipDocumento)
	{
   			
		case 1 :
				if (pstGHistDocu.iIndAnulada == iDocAnulado)
	            {
	            	stAcumuladorFinal.lNumBoletaAnul++;
	            }
		        stAcumuladorFinal.lNumBoleta      ++                              ;
		        stAcumuladorFinal.dNetoBoleta     += pstGHistDocu.dAcumNetoGrav   ;
	    	    stAcumuladorFinal.dExentoBoleta   += pstGHistDocu.dAcumNetoNoGrav ; /* CH-200312091557 */
	        	stAcumuladorFinal.dIvaBoleta      += pstGHistDocu.dAcumIva        ;
	        	stAcumuladorFinal.dTotalBoleta    += pstGHistDocu.dAcumNetoGrav   + 
					                                 pstGHistDocu.dAcumNetoNoGrav + /* CH-200312091557 */
	        								         pstGHistDocu.dAcumIva        ;
				break;

    	case 2 :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumuladorFinal.lNumBoletaExenAnul++;
	        	}
		        stAcumuladorFinal.lNumBoletaExen      ++                               ;
		        stAcumuladorFinal.dNetoBoletaExen      =  0							  ;
	    	    stAcumuladorFinal.dExentoBoletaExen   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumuladorFinal.dIvaBoletaExen       =  0							  ;
	        	stAcumuladorFinal.dTotalBoletaExen    += pstGHistDocu.dAcumNetoNoGrav  ;                  
				break;
		case 3 :
		        if (pstGHistDocu.iIndAnulada == iDocAnulado)
	                {
	            		stAcumuladorFinal.lNumBoletaAnulAfec69++;
	                }
		        stAcumuladorFinal.lNumBoletaAfec69    ++                              ;
		        stAcumuladorFinal.dNetoBoletaAfec69   += pstGHistDocu.dAcumNetoGrav   ;
	    	    stAcumuladorFinal.dExentoBoletaAfec69 += pstGHistDocu.dAcumNetoNoGrav ; /* CH-200312091557 */
	        	stAcumuladorFinal.dIvaBoletaAfec69    += pstGHistDocu.dAcumIva        ;
	        	stAcumuladorFinal.dTotalBoletaAfec69  += pstGHistDocu.dAcumNetoGrav  + 
					                                     pstGHistDocu.dAcumIva       +
					                                     pstGHistDocu.dAcumNetoNoGrav ;  /* CH-200312091557 */
			break;

    	case 4 :
	        	if (pstGHistDocu.iIndAnulada == iDocAnulado)
	        	{
	        		stAcumuladorFinal.lNumBoletaExenAnul73++;
	        	}
		        stAcumuladorFinal.lNumBoletaExen73      ++                               ;
		        stAcumuladorFinal.dNetoBoletaExen73      =  0							  ;
	    	    stAcumuladorFinal.dExentoBoletaExen73   += pstGHistDocu.dAcumNetoNoGrav  ;
	        	stAcumuladorFinal.dIvaBoletaExen73       =  0							  ;
	        	stAcumuladorFinal.dTotalBoletaExen73    += pstGHistDocu.dAcumNetoNoGrav  ;                  
				break;		
    }/* end switch */

    return;
}/*********************** Final bfnAcumulaDocumentoFinal *************************/
ifnGetParametro2 (int iCodParametro, char *szTipParametro, char *szValParametro )
{
char modulo[]="ifnGetParametro2";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	    int     ihCodParametro      ;
	    long    lhValNumerico       ;
	    char    szhTipParametro [33]; /* EXEC SQL VAR szhTipParametro  IS STRING(33); */ 

        char    szhValCaracter [513]; /* EXEC SQL VAR szhValCaracter   IS STRING(513); */ 

        char    szhValFecha     [20]; /* EXEC SQL VAR szhValFecha      IS STRING(20); */ 

        short   s_lhValNumerico     ;
        short   s_szhValCaracter    ;
        short   s_szhValFecha       ;
	/* EXEC SQL END DECLARE SECTION; */ 


    ihCodParametro= iCodParametro;


    vDTrazasLog  (modulo,"\n\t** Funcion %s **"
    					 "\n\t=> parametro [%d]",LOG04,modulo, iCodParametro);

	/* EXEC SQL
	    SELECT TIP_PARAMETRO, VAL_NUMERICO, VAL_CARACTER, TO_CHAR(VAL_FECHA,'YYYYMMDDHH24MISS')
	      INTO :szhTipParametro   ,
	           :lhValNumerico  :s_lhValNumerico,
	           :szhValCaracter :s_szhValCaracter,
	           :szhValFecha    :s_szhValFecha
	      FROM FAD_PARAMETROS
	     WHERE COD_MODULO='FA'
	       AND COD_PARAMETRO=:ihCodParametro; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 18;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select TIP_PARAMETRO ,VAL_NUMERICO ,VAL_CARACTER ,TO_CHAR(VA\
L_FECHA,'YYYYMMDDHH24MISS') into :b0,:b1:b2,:b3:b4,:b5:b6  from FAD_PARAMETROS\
 where (COD_MODULO='FA' and COD_PARAMETRO=:b7)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )242;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhTipParametro;
 sqlstm.sqhstl[0] = (unsigned long )33;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhValNumerico;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)&s_lhValNumerico;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhValCaracter;
 sqlstm.sqhstl[2] = (unsigned long )513;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)&s_szhValCaracter;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhValFecha;
 sqlstm.sqhstl[3] = (unsigned long )20;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)&s_szhValFecha;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihCodParametro;
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



	if(sqlca.sqlcode == SQLOK)
 	{
        if (strcmp (szhTipParametro ,"VARCHAR2") == 0)
        {
            if (s_szhValCaracter== ORA_NULL)    sprintf(szValParametro,"\0" );
            else                                sprintf(szValParametro,"%s\0" ,szhValCaracter);
        }
        else if (strcmp (szhTipParametro,"NUMBER") ==0)
        {
            if (s_lhValNumerico == ORA_NULL)    sprintf(szValParametro,"\0" );
            else                                sprintf(szValParametro,"%ld\0" ,lhValNumerico);
        }
	    else if (strcmp (szhTipParametro,"DATE") == 0)
	    {
            if (s_szhValFecha   == ORA_NULL)    sprintf(szValParametro,"\0" );
            else                                sprintf(szValParametro,"%s\0" ,szhValFecha);
	    }
   	}
    else
    {
    	if (sqlca.sqlcode != SQLNOTFOUND)
   	    	fprintf(stderr, "Error al recuperar parametro, desde FAD_PARAMETROS.\n");
    }
    return(sqlca.sqlcode);
}


/******************************************************************************************/
/** Informaci�n de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisi�n                                            : */
/**  %PR% */
/** Autor de la Revisi�n                                : */
/**  %AUTHOR% */
/** Estado de la Revisi�n ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creaci�n de la Revisi�n                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

