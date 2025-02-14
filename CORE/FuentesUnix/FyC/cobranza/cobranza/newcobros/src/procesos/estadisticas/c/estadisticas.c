
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
           char  filnam[21];
};
static const struct sqlcxp sqlfpn =
{
    20,
    "./pc/estadisticas.pc"
};


static unsigned int sqlctx = 55290339;


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

 static const char *sq0004 = 
"select sec_analisis ,to_char((sysdate-1),'dd/mm/yyyy')  from co_analisis whe\
re ind_estado='V'           ";

 static const char *sq0005 = 
"categoria ,0 morosos_num_ident ,0 morosos_cod_cliente ,0 morosos_cnt_abocelu\
 ,0 morosos_cnt_abobeep ,0 morosos_deu_vencida ,count(unique hm.num_ident) hmo\
rosos_num_ident ,count(hm.cod_cliente) hmorosos_cod_cliente ,sum(hm.cnt_abocel\
u) hmorosos_cnt_abocelu ,sum(hm.cnt_abobeep) hmorosos_cnt_abobeep ,sum(hm.deu_\
vencida) hmorosos_deu_vencida  from co_hmorosos hm where (hm.sec_analisis=:b0 \
and trunc(hm.fec_historico)=to_date(:b3,'dd/mm/yyyy')) group by hm.cod_categor\
ia)  group by cod_categoria           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,71,0,4,80,0,0,1,0,0,1,0,2,5,0,0,
24,0,0,2,65,0,5,100,0,0,0,0,0,1,0,
39,0,0,3,0,0,29,111,0,0,0,0,0,1,0,
54,0,0,4,104,0,9,506,0,0,0,0,0,1,0,
69,0,0,4,0,0,13,522,0,0,2,0,0,1,0,2,3,0,0,2,97,0,0,
92,0,0,5,1528,0,9,620,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,
123,0,0,5,0,0,13,630,0,0,13,0,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
190,0,0,6,377,0,3,683,0,0,14,14,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,
261,0,0,5,0,0,15,724,0,0,0,0,0,1,0,
276,0,0,4,0,0,15,736,0,0,0,0,0,1,0,
291,0,0,7,1037,0,3,763,0,0,0,0,0,1,0,
};


/* ============================================================================= */
/*
    Tipo        :  COLA DE PROCESO

    Nombre      :  estadisticas.pc

    Descripcion :  Ejecuta el vaciado de datos desde las tablas co_morosos
    			   y co_hmorosos para analisis de estado de pago de morosidades.	

    Recibe      :  Usuario/Password. ( por defecto asume los de la cuenta )
                   Nivel de Log ( por defecto asume 3 : Log Normal ) 
                   
                   
    Devuelve    :  Valor entero para indicar el status de termino.
                   Interactua con la Base de Datos y el archivo de Log para registrar
                   como se desarrolla su ejecucion.
    
    Autor       :  Manuel Garcia G.
    Fecha       :  Febrero 2000.
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_
#include "estadisticas.h"

#define iLOGNIVEL_DEF     3       /* Define el nivel de Log por Defecto */

LINEACOMANDO  stLineaComando;     /* Datos con los que se invoco al proceso */
char szgCodProceso[6]="";
char szArchivoLog[256]="";        /* log */

long lAuxSeqGlobal=0;             /* variable de ambito global ( Auxiliar Secuencia ) */

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


int main(int argc,char *argv[])
{
   	char modulo[]="main";
    int iResult = 0;
   
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhCodEstado[2]; /* EXEC SQL VAR szhCodEstado IS STRING (2); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

    
    fprintf(stdout, "\n%s ESTADISTICAS pid(%ld)\n", szGetTime(1),getpid());
    fflush (stdout);

    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));

    if ( ifnValidaParametros( argc, argv, &stLineaComando ) != 0 ) {    
        fprintf (stdout,"\n\tError >> Fallo la Validacion de Parametros \n");
        fflush  (stdout);
        iResult = -1; /* Fallo validacion */
    }
    else {    
        /*- Conexion a la Base de Datos -*/
        if ( ifnConexionDB ( &stLineaComando ) != 0 ) {   
            fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
            fflush  (stdout);
            iResult = -2; /* Fallo conexion */
        }
        else {
            /*- Prepara Archivo de Log -*/ 
            if ( ifnPreparaArchivoLog() != 0 ) {
                fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
                fflush  (stdout);
                iResult = -3;  /* Fallo Log */
            }
            else
            {
                /*- Ejecuta el proceso propiamente tal -*/
                if ( ifnEjecutaCola() != 0 ) {
                    fprintf (stdout,"\n\tError >> Fallo el proceso ifnEjecutaCola\n");
                    fflush  (stdout);
                    iResult = -4; /* Fallo Proceso */
                }
                else { /* estadisticas salio con 0 ( supuestamente cola de vuelta en wait ) */
                    /* EXEC SQL 
                    SELECT COD_ESTADO 
                    INTO :szhCodEstado
                    FROM CO_COLASPROC 
                    WHERE COD_PROCESO='ESTAD'; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 1;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLAS\
PROC where COD_PROCESO='ESTAD'";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )5;
                    sqlstm.selerr = (unsigned short)1;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhCodEstado;
                    sqlstm.sqhstl[0] = (unsigned long )2;
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
                        fprintf (stdout,"\n\tError >> Fallo el proceso ( Validacion Cola Wait ) \n");
                        fflush  (stdout);
                        ifnMailAlert("ESTADISTICAS","TODOS","FALLO LA VALIDACION FINAL DE LA COLA.");
                        iResult = -5; /* Fallo Proceso */
                    }
                    else
                    {
                        if ( strcmp(szhCodEstado,"W")!=0 )
                        {
                            /* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT */
                            /* SEÑALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
                            ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
                            /* EXEC SQL 
                            UPDATE CO_COLASPROC
                            SET COD_ESTADO = 'W'
                            WHERE COD_PROCESO = 'ESTAD' ; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 1;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.stmt = "update CO_COLASPROC  set COD_ESTA\
DO='W' where COD_PROCESO='ESTAD'";
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )24;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                            if (SQLCODE)
                            {
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Update Cola Wait ) %s\n",SQLERRM );
                                fflush  (stdout);
                                ifnMailAlert("ESTADISTICAS","TODOS","FALLO AL ACTUALIZAR LA COLA A 'WAIT'.");
                                iResult = -6; /* Fallo Proceso */
                            }                            
                            /* EXEC SQL COMMIT; */ 

{
                            struct sqlexd sqlstm;
                            sqlstm.sqlvsn = 12;
                            sqlstm.arrsiz = 1;
                            sqlstm.sqladtp = &sqladt;
                            sqlstm.sqltdsp = &sqltds;
                            sqlstm.iters = (unsigned int  )1;
                            sqlstm.offset = (unsigned int  )39;
                            sqlstm.cud = sqlcud0;
                            sqlstm.sqlest = (unsigned char  *)&sqlca;
                            sqlstm.sqlety = (unsigned short)256;
                            sqlstm.occurs = (unsigned int  )0;
                            sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


                            if (SQLCODE)
                            {
                                fprintf (stdout,"\n\tError >> Fallo el proceso ( Commit Cola Wait ) %s\n", SQLERRM );
                                fflush  (stdout);
                                ifnMailAlert("ESTADISTICAS","TODOS","FALLO EL COMMIT DE LA COLA 'WAIT'.");
                                iResult = -7; /* Fallo Proceso */
                            }                            
                            ifnTrazasLog(modulo,"OK. Cola forzada a espera",LOG02);
                        }
                    }
                }

                vfnCierraArchivoLog();
            }
        }
    }

    return iResult;
   
} /* end main */    
/* ============================================================================= */

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
    char modulo[]="ifnValidaParametros";

/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
    extern char  *optarg;
    extern  int  optind, opterr, optopt;
            int  iOpt=0;
           char  opt[] = ":u:l:n:";
/*-- Variables locales -----------------------------------------------------------*/  
           char  *psztmp = "";
/*-- Flags de los valores recibidos ----------------------------------------------*/
            int  Userflag=0;
            int  Logflag=0;

/*-- Seteo de Valores Iniciles y por defecto -------------------------------------*/
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;
    memset(szgCodProceso,0,sizeof(szgCodProceso));
    strcpy(szgCodProceso,"ESTAD"); /*valor por defecto es "ESTAD" por ESTADisticas */
    
/*-- En caso de Invocacion sin Parametros ----------------------------------------*/
    if(argc == 1)
    	return 0; /*ok asume valores por defecto */
    

/*-- Analisis de los argumentos recibidos ----------------------------------------*/
    while ((iOpt = getopt(argc, argv, opt)) != EOF) {
        
        fprintf (stderr,"\n\tParametro >> %s '/' \n", optarg);
        fflush  (stderr);

        switch (iOpt) {

            case 'u':  /*-- Usuario/Password --*/
            
                 if(!Userflag) {
                    strcpy(pstLC->szUsuarioOra, optarg);                      
                    Userflag=1;
                    if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL) {
                        fprintf (stderr,"\n\tError >> Usuario no valido. Requiere '/' \n");
                        fflush  (stderr);
                        return -1;
                    }
                    else {
                        strncpy (pstLC->szOraAccount,pstLC->szUsuarioOra,psztmp-pstLC->szUsuarioOra);
                        strcpy  (pstLC->szOraPasswd, psztmp+1);
                    }
                }
                else {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;

            case 'l': /*-- Nivel de Log --*/
            
                if(!Logflag) {
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
                }
                else {
                    fprintf (stderr,"\n\tError >> opcion '-%c' duplicada\n",optopt);
                    fflush  (stderr);
                    return -1;
                }
                break;
            
            case 'n': /*-- Nombre de la Cola (codigo del proceso) --*/
            
                strcpy(szgCodProceso,optarg);
                break;
            
            case '?':
            
                fprintf (stderr,"\n\tError >> opcion '-%c' es desconocida\n",optopt);
                fflush  (stderr);
                return -1;

            case ':':
            
                fprintf (stderr,"\n\tError >> falta argumento para opcion '-%c'\n",optopt);
                fflush  (stderr);
                return -1;
        
        } /* switch (iOpt) */
    } /* while ((iOpt = getopt(argc, argv, opt)) != EOF) */
    
    pstLC->iLogLevel=stStatus.iLogNivel;
       return 0;

} /* bfnValidaParamatros */
/* ============================================================================= */

/* ============================================================================= */
/* ifnConexionDB() : Intenta Conectarse a la Base de Datos                       */
/* ============================================================================= */
int ifnConexionDB(LINEACOMANDO *pstLC)
{
    char modulo[]="ifnConexionDB";
    
    fprintf (stderr,"\nUsuario : [%s] , Password : [%s] \n", pstLC->szOraAccount,pstLC->szOraPasswd );
    fflush  (stderr);
    
    if ( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE  ) {
        fprintf (stderr,"\nNo hay conexion a ORACLE \n");
        fflush  (stderr);
        return -1;
    }
    
    return 0;
}
/* ============================================================================= */

/* ============================================================================= */
/* ifnPreparaArchivoLog(): Obtiene las Paths y define el nombre del archivo log  */
/* ============================================================================= */
int ifnPreparaArchivoLog()
{
    char modulo[]="ifnPreparaArchivoLog";

    /* char *szAux; */
    int sts=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhPathLogSched[256]; /* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

    /* EXEC SQL END DECLARE SECTION; */ 

 
    sprintf(stStatus.szFileName,"%s",szgCodProceso);

	sprintf(szhPathLogSched,"%s/CO_SCHEDULER",getenv("XPC_LOG"));
    
    sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    
    
    sts = ifnAbreArchivoLog(1); 
    
    return sts;
    
} /* end ifnPreparaArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* if iCreaDir != 0 : crear directorio antes que el archivo                      */
/* ============================================================================= */
int ifnAbreArchivoLog(int iCrearDir)
{
    char modulo[]="ifnAbreArchivoLog";
    char szArchivoErr[256]=""; /* errores */
    char szArchivoEst[256]=""; /* estadisticas */
    char szComando[256]="";
    static char szAux[9];
    
    memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log */         
    memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores */     
    memset(szArchivoEst,0,sizeof(szArchivoEst)); /* estadisticas */

    strcpy (szAux,(char *)szSysDate("YYYYMMDD"));
    sprintf(szComando,"mkdir -p %s/%s",stStatus.szLogPathGene,szAux);
    
    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
    }
    
    sprintf(szArchivoLog,"%s/%s/%s.log",stStatus.szLogPathGene,szAux,stStatus.szFileName);
    sprintf(szArchivoErr,"%s/%s/%s.err",stStatus.szLogPathGene,szAux,stStatus.szFileName);
    sprintf(szArchivoEst,"%s/%s/%s.est",stStatus.szLogPathGene,szAux,stStatus.szFileName);
    
    if((stStatus.LogFile = fopen(szArchivoLog,"a")) == (FILE*)NULL ) {    
        fprintf (stderr,"Error al crear archivo de Log\n");
        fflush  (stderr);
        return -1;    
    }
    
    if((stStatus.ErrFile = fopen(szArchivoErr,"a")) == (FILE*)NULL ) {
        fprintf (stderr,"Error al crear archivo de Errores\n");
        fflush  (stderr);
        return -1;    
    }

    if((stStatus.EstFile = fopen(szArchivoEst,"a")) == (FILE*)NULL ) {    
        fprintf (stderr,"Error al crear archivo de Estadisticas\n");
        fflush  (stderr);
        return -1;    
    }
    
    ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO <%ld> -\n", INFALL
                       ,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

    return 0;
    
}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs  */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
    char modulo[]="vfnCierraArchivoLog";
    
    ifnTrazasLog(modulo, "%s -  CIERRE  DE ARCHIVO <%ld> -\n", INFALL
                       ,szSysDate("[DD-MON-YYYY][HH24:MI:SS]"),getpid());

    if ( fclose(stStatus.LogFile) != 0 ) {    
        fprintf (stderr,"Error al cerrar archivo de Log\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.ErrFile) != 0 ) {    
        fprintf (stderr,"Error al cerrar archivo de Errores\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.EstFile) != 0 ) {    
        fprintf (stderr,"Error al cerrar archivo de Estadisticas\n");
        fflush  (stderr);
    }
        
    return;    
} /* end vfnCierraArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/*  ifnEjecutaCola() : Ejecuta la cola de acciones                               */
/* ============================================================================= */
int ifnEjecutaCola(void)
{
    char modulo[]="ifnEjecutaCola";
    
    char szError[1024]="";
    
    ifnTrazasLog(modulo,"Corriendo la cola lanzada ",LOG05);
    ifnTrazasLog(modulo,"ESTADISTICAS VERSION [%s]\n",LOG03, szVERSION);
    
    if (!bfnCambiaEstadoCola(szgCodProceso,"L","R")) { /*'Launched->Running'*/
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'L->R' : %s",LOG00,SQLERRM);
        return -1;
    }
    else {    
        if (!bfnOraCommit()) {    
            ifnTrazasLog(modulo,"En Commit 'L->R' : %s",LOG00,SQLERRM);
            if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
            return -1;    
        }
    }
    
   	/* Carga de datos de uso general */
	if( !bfnObtieneDatosGenerales() )
	{
	    ifnTrazasLog( modulo, "Error al realizar carga de bfnObtieneDatosGenerales().", LOG03 );
	    return -1;
	}

    if ( ifnGeneraEstadisticas(szError) < 0) 
    	ifnMailAlert("ESTADISTICAS","TODOS","%s",szError);

    ifnTrazasLog(modulo,"Volviendo la cola a espera ",LOG05);

    if (!bfnCambiaEstadoCola(szgCodProceso,"R","W")) {/*'Running->Wait'*/
        if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback 'R->W' : %s",LOG00,SQLERRM);
        return -1;
    }
    else {    
        if (!bfnOraCommit())  {    
            ifnTrazasLog(modulo,"En Commit 'R->W' : %s",LOG00,SQLERRM);
            if (!bfnOraRollBack()) ifnTrazasLog(modulo,"En Rollback : %s", LOG00,SQLERRM);
            return -1;    
        }
    }
    
    ifnTrazasLog(modulo,"saliendo de %s ( Cola Wait )",LOG02,szgCodProceso);

    return 0;    
}
/* ============================================================================= */

/* ============================================================================= */
/*  ifnGeneraEstadisticas() : Ejecuta las acciones que correspondan              */
/* ============================================================================= */
int ifnGeneraEstadisticas(char* szDescrError)
{
    char modulo[]="ifnGeneraEstadisticas";

	int  iSqlAuxStatus;
	long lRowsProcessed=0;
	char szError[1024]="";
	
	char szIniProc[9],szFinProc[9],szTmpProc[9];
	int iDifSegs=0,ihFlgError=0;
	
	ifnTrazasLog(modulo,"entrando en %s",LOG05,modulo);
	
    sprintf(szIniProc,"%s",szSysDate("HH24:MI:SS"));

	/*- Procesa la tabla de cabecera co_analisis, para obtener datos para analisis   -*/
	/*- los cuales son insertados en la tabla co_det_analisis                        -*/ 
    if ( ifnAnalisisMorosos(szError) < 0) {
    	sprintf( szDescrError, "%s", szError );
        return -1; /*Mail*/
    }

    /*- Procesa datos de la tabla co_morosos para estadisticas y los inserta en la   -*/
    /*- tabla co_estmorosos 														 -*/
	if ( ifnEstadisticaMorosos(szError) < 0) { 
    	sprintf( szDescrError, "%s", szError );
        return -1; /*Mail*/
    }

    sprintf(szFinProc,"%s",szSysDate("HH24:MI:SS"));
    
    /* Informacion Estadistica */
    if ( (iDifSegs = ifnRestaHoras(szIniProc,szFinProc,szTmpProc)) >= 0 ) {
          ifnTrazasLog(modulo,"\n\t RESUMEN DEL PROCESO     "
                              "\n\t       HORA INICIO  : %s "
                              "\n\t       HORA TERMINO : %s "
                              "\n\t       TIEMPO TOTAL : %s  (%d segs)"
                              "\n",EST00
                              ,szIniProc, szFinProc, szTmpProc, iDifSegs);
                            
    }

    ifnTrazasLog(modulo,"saliendo de %s",LOG05,modulo);

    return 0; 
}
/* ============================================================================= */

/* ============================================================================= */
/*  ifnAnalisisMorosos() : Genera estadisticas para analisis en la               */ 
/*                         co_det_analisis                                       */
/* ============================================================================= */
int ifnAnalisisMorosos(char* szDescError)
{
    char modulo[]="ifnAnalisisMorosos";

	int  	iSqlAuxStatus, ihFlgError = 0;
	long 	lRowsProcessed = 0;
	
	    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    	td_Analis		 	td_Analisis;			/* para guardar la entrada de datos para el analisis */
    	td_DetAnalis 		td_DetAnalisis;			/* para guardar la salida de datos del analisis */
    /* EXEC SQL END DECLARE SECTION; */ 

 
     ifnTrazasLog(modulo,"entrando en %s",LOG05,modulo);

     /* se recuperan todos los grupos vigentes desde la tabla co_analisis */
    
    /* EXEC SQL DECLARE curANALISIS CURSOR FOR
       	SELECT 	sec_analisis,
    			to_char( sysdate-1, 'dd/mm/yyyy' )
    			FROM	co_analisis
    	WHERE   ind_estado = 'V'; */ 

    		 
    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
        sprintf(szDescError,"Fallo la declaracion del cursor de analisis %s",SQLERRM);
        ifnTrazasLog(modulo,"Declare curANALISIS %s",LOG00,SQLERRM);
        return -1; /*Mail*/
    }
    else if (SQLCODE == SQLNOTFOUND ) {
        ifnTrazasLog(modulo,"Termino Normal(Anticipado) NO HAY DATOS PARA ANALISIS",LOG03);
        return 0;    
    }

    /* EXEC SQL OPEN curANALISIS ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )54;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) {
        sprintf(szDescError,"Fallo la apertura del cursor de analisis %s",SQLERRM);
        ifnTrazasLog(modulo,"Open curANALISIS %s",LOG00,SQLERRM);
        return -1; /*Mail*/
    }
    else if (SQLCODE == SQLNOTFOUND ) {
        ifnTrazasLog(modulo,"Termino Normal(Anticipado) NO HAY DATOS PARA ANALISIS",LOG03);
        return 0;    
    }
    
    ihFlgError = 0;
        
    while (1) {
        
        /* EXEC SQL FETCH curANALISIS
        INTO :td_Analisis; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )69;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&td_Analisis.sec_analisis;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)td_Analisis.fecha_analisis;
        sqlstm.sqhstl[1] = (unsigned long )11;
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

  
        
        iSqlAuxStatus = SQLCODE;
            
        if ( iSqlAuxStatus != SQLOK && iSqlAuxStatus != SQLNOTFOUND ) {
            sprintf(szDescError,"Fallo el fetch del cursor de analisis");
            ifnTrazasLog(modulo,"Fetch curANALISIS [%d] %s",LOG00, iSqlAuxStatus, SQLERRM);
            return -1; /*Mail*/
        } 
        else if ( iSqlAuxStatus == SQLNOTFOUND ) {
            sprintf(szDescError,"Alcanzado el fin de datos");
            ifnTrazasLog(modulo,"Alcanzado fin de datos [%ld] Grupos procesados ",LOG05,lRowsProcessed );
            break; /* se terminaron los grupos vigentes para analisis */
        }
        
        ifnTrazasLog(modulo,"\tValores Detalle \n       "
    						"\t\t Fec_Actual : [%s] \n  ",LOG05,td_Analisis.fecha_analisis);

		/* EXEC SQL DECLARE curDETANALISIS CURSOR FOR
				SELECT  0, 								/o sec_analisis o/
						' ',  							/o fec_analisis o/
						cod_categoria,
						sum(morosos_num_ident),
						sum(morosos_cod_cliente),
						sum(morosos_cnt_abocelu),
						sum(morosos_cnt_abobeep),
						sum(morosos_deu_vencida),
						sum(hmorosos_num_ident), 
						sum(hmorosos_cod_cliente),
						sum(hmorosos_cnt_abocelu),
						sum(hmorosos_cnt_abobeep),
						sum(hmorosos_deu_vencida)
				FROM  ( SELECT  0,
								' ',
								m.cod_categoria,
								count( unique m.num_ident) as morosos_num_ident,
								count(m.cod_cliente) as morosos_cod_cliente,
								sum(m.cnt_abocelu) as morosos_cnt_abocelu,
								sum(m.cnt_abobeep) as morosos_cnt_abobeep,
								sum(m.deu_vencida) as morosos_deu_vencida,
								0 as hmorosos_num_ident,
								0 as hmorosos_cod_cliente,
								0 as hmorosos_cnt_abocelu,
								0 as hmorosos_cnt_abobeep,
								0 as hmorosos_deu_vencida
						FROM ( SELECT  0,
										' ',
										cod_categoria,
										num_ident,
										cod_cliente,
										cnt_abocelu,
										cnt_abobeep,
										deu_vencida
								FROM 	co_morosos
								WHERE   sec_analisis = :td_Analisis.sec_analisis
								UNION
								SELECT  0,
										' ',
										cod_categoria,
										num_ident,
										cod_cliente,
										cnt_abocelu,
										cnt_abobeep,
										deu_vencida
								FROM 	co_hmorosos
								WHERE   sec_analisis = :td_Analisis.sec_analisis
								AND     fec_historico >= trunc(sysdate)
							 ) m
						GROUP BY m.cod_categoria
						UNION
						SELECT  0,
								' ',
								hm.cod_categoria,
								0 as morosos_num_ident,
								0 as morosos_cod_cliente,
								0 as morosos_cnt_abocelu,
								0 as morosos_cnt_abobeep,
								0 as morosos_deu_vencida,
								count( unique hm.num_ident) as hmorosos_num_ident,
								count(hm.cod_cliente) as hmorosos_cod_cliente,
								sum(hm.cnt_abocelu) as hmorosos_cnt_abocelu,
								sum(hm.cnt_abobeep) as hmorosos_cnt_abobeep,
								sum(hm.deu_vencida) as hmorosos_deu_vencida
						FROM 	co_hmorosos hm
						WHERE   hm.sec_analisis = :td_Analisis.sec_analisis
						AND     trunc(hm.fec_historico) = to_date(:td_Analisis.fecha_analisis,'dd/mm/yyyy')
						GROUP BY hm.cod_categoria
						)
				GROUP BY cod_categoria; */ 

				
	    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	        sprintf(szDescError,"Fallo DECLARE del cursor detalle analisis, Sec Analisis = [%ld] \n %s"
	                           , td_Analisis.sec_analisis, SQLERRM);
	        ifnTrazasLog(modulo,"Declare curDETANALISIS %s",LOG00,SQLERRM);
	        return -1; /*Mail*/
	    }
	
	    /* EXEC SQL OPEN curDETANALISIS ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 4;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlbuft((void **)0, 
       "select 0 ,' ' ,cod_categoria ,sum(morosos_num_ident) ,sum(morosos_co\
d_cliente) ,sum(morosos_cnt_abocelu) ,sum(morosos_cnt_abobeep) ,sum(morosos_\
deu_vencida) ,sum(hmorosos_num_ident) ,sum(hmorosos_cod_cliente) ,sum(hmoros\
os_cnt_abocelu) ,sum(hmorosos_cnt_abobeep) ,sum(hmorosos_deu_vencida)  from \
(select 0 ,' ' ,m.cod_categoria ,count(unique m.num_ident) morosos_num_ident\
 ,count(m.cod_cliente) morosos_cod_cliente ,sum(m.cnt_abocelu) morosos_cnt_a\
bocelu ,sum(m.cnt_abobeep) morosos_cnt_abobeep ,sum(m.deu_vencida) morosos_d\
eu_vencida ,0 hmorosos_num_ident ,0 hmorosos_cod_cliente ,0 hmorosos_cnt_abo\
celu ,0 hmorosos_cnt_abobeep ,0 hmorosos_deu_vencida  from (select 0 ,' ' ,c\
od_categoria ,num_ident ,cod_cliente ,cnt_abocelu ,cnt_abobeep ,deu_vencida \
 from co_morosos where sec_analisis=:b0 union select 0 ,' ' ,cod_categoria ,\
num_ident ,cod_cliente ,cnt_abocelu ,cnt_abobeep ,deu_vencida  from co_hmoro\
sos where (sec_analisis=:b0 and fec_historico>=trunc(sysdate))) m  group by \
m.cod_categoria union select 0 ,' ' ,hm.cod_");
     sqlstm.stmt = sq0005;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )92;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&(td_Analisis.sec_analisis);
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&(td_Analisis.sec_analisis);
     sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&(td_Analisis.sec_analisis);
     sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)(td_Analisis.fecha_analisis);
     sqlstm.sqhstl[3] = (unsigned long )11;
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


	    if ( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND) {
	        sprintf(szDescError,"Fallo OPEN del cursor detalle analisis, Sec Analisis = [%ld] \n %s"
	                           , td_Analisis.sec_analisis, SQLERRM);
	        ifnTrazasLog(modulo,"Open curDETANALISIS %s",LOG00,SQLERRM);
	        return -1; /*Mail*/
	    }

	    while (1) {
	        
	        /* EXEC SQL FETCH curDETANALISIS
	        INTO :td_DetAnalisis; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 13;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )123;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)&td_DetAnalisis.sec_analisis;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)td_DetAnalisis.fec_actual;
         sqlstm.sqhstl[1] = (unsigned long )11;
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)td_DetAnalisis.cod_categoria;
         sqlstm.sqhstl[2] = (unsigned long )6;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)&td_DetAnalisis.cnt_rut_saldo;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&td_DetAnalisis.cnt_cliente_saldo;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)&td_DetAnalisis.cnt_abocelu_saldo;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)&td_DetAnalisis.cnt_abobeep_saldo;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)&td_DetAnalisis.deu_vencida_saldo;
         sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)&td_DetAnalisis.cnt_rut_recup;
         sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[8] = (         int  )0;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)&td_DetAnalisis.cnt_cliente_recup;
         sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[9] = (         int  )0;
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)&td_DetAnalisis.cnt_abocelu_recup;
         sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[10] = (         int  )0;
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)&td_DetAnalisis.cnt_abobeep_recup;
         sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[11] = (         int  )0;
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)&td_DetAnalisis.deu_vencida_recup;
         sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
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

  
	        
	        iSqlAuxStatus = SQLCODE;
	            
	        if ( iSqlAuxStatus != SQLOK && iSqlAuxStatus != SQLNOTFOUND ) {
	        	sprintf(szDescError,"Fallo FETCH del cursor detalle analisis, Sec Analisis = [%ld] \n %s"
	            	               , td_Analisis.sec_analisis, SQLERRM);
	            ifnTrazasLog(modulo,"Fetch curDETANALISIS [%d] %s",LOG00, iSqlAuxStatus, SQLERRM);
	            return -1; /*Mail*/
	        } 
	        else if ( iSqlAuxStatus == SQLNOTFOUND ) {
	            sprintf(szDescError,"Alcanzado el fin de datos detalle analisis para Sec Analisis = [%ld] \n", td_Analisis.sec_analisis);
	            break; /* se terminaron las categorias para la secuencia */
	        }
	
			td_DetAnalisis.sec_analisis = td_Analisis.sec_analisis;
			strcpy ( td_DetAnalisis.fec_actual, td_Analisis.fecha_analisis );
	
            ifnTrazasLog(modulo,"\tValores Detalle a Insertar\n      "
    							"\t\t Sec_Analisis        : [%d] \n "    
    							"\t\t Fec_Actual          : [%s] \n  "
    							"\t\t Cod_Categoria       : [%s] \n  "
    							"\t\t Cnt_Rut_Saldo       : [%d] \n "   
    							"\t\t Cnt_Cliente_Saldo   : [%d] \n "  
    							"\t\t Cnt_Abocelu_Saldo   : [%d] \n " 
    							"\t\t Cnt_Abobeep_Saldo   : [%d] \n "
           						"\t\t Deu_Vencida_Saldo   : [%.4f] \n "
    							"\t\t Cnt_Rut_Recup       : [%d] \n "   
    							"\t\t Cnt_Cliente_Recup   : [%d] \n "  
    							"\t\t Cnt_Abocelu_Recup   : [%d] \n " 
    							"\t\t Cnt_Abobeep_Recup   : [%d] \n "
           						"\t\t Deu_Vencida_Recup   : [%.4f] \n\n "
            					,LOG05, 
            					td_DetAnalisis.sec_analisis,
								td_DetAnalisis.fec_actual,
								td_DetAnalisis.cod_categoria,
								td_DetAnalisis.cnt_rut_saldo,
								td_DetAnalisis.cnt_cliente_saldo,
								td_DetAnalisis.cnt_abocelu_saldo,
								td_DetAnalisis.cnt_abobeep_saldo,
								td_DetAnalisis.deu_vencida_saldo,
								td_DetAnalisis.cnt_rut_recup,
								td_DetAnalisis.cnt_cliente_recup,
								td_DetAnalisis.cnt_abocelu_recup,
								td_DetAnalisis.cnt_abobeep_recup,
								td_DetAnalisis.deu_vencida_recup );

			ifnTrazasLog( modulo, "Valores antes de transformer deu_vencida_saldo = [%.4f], deu_vencida_recup = [%.4f].", LOG05, td_DetAnalisis.deu_vencida_saldo, td_DetAnalisis.deu_vencida_recup );  
			td_DetAnalisis.deu_vencida_saldo = fnCnvDouble( td_DetAnalisis.deu_vencida_saldo, 0 );
			td_DetAnalisis.deu_vencida_recup = fnCnvDouble( td_DetAnalisis.deu_vencida_recup, 0 );
			ifnTrazasLog( modulo, "Valores despues de transformer deu_vencida_saldo = [%.4f], deu_vencida_recup = [%.4f].", LOG05, td_DetAnalisis.deu_vencida_saldo, td_DetAnalisis.deu_vencida_recup );

			/* EXEC SQL INSERT INTO co_det_analisis 
							(	fec_analisis,
								fec_actual,
								cod_categoria,
								cnt_num_ident_saldo,	/o mgg 20030113 o/
								cnt_cliente_saldo,
								cnt_abocelu_saldo,
								cnt_abobeep_saldo,
								deu_vencida_saldo,
								cnt_num_ident_recup,	/o mgg 20030113 o/
								cnt_cliente_recup,
								cnt_abocelu_recup,
								cnt_abobeep_recup,
								deu_vencida_recup,
								sec_analisis
							)
					 VALUES (  	to_date (:td_DetAnalisis.fec_actual, 'dd/mm/yyyy' ), 
								to_date (:td_DetAnalisis.fec_actual, 'dd/mm/yyyy' ),
								:td_DetAnalisis.cod_categoria,
								:td_DetAnalisis.cnt_rut_saldo,
								:td_DetAnalisis.cnt_cliente_saldo,
								:td_DetAnalisis.cnt_abocelu_saldo,
								:td_DetAnalisis.cnt_abobeep_saldo,
								:td_DetAnalisis.deu_vencida_saldo,
								:td_DetAnalisis.cnt_rut_recup,
								:td_DetAnalisis.cnt_cliente_recup,
								:td_DetAnalisis.cnt_abocelu_recup,
								:td_DetAnalisis.cnt_abobeep_recup,
								:td_DetAnalisis.deu_vencida_recup,
								:td_DetAnalisis.sec_analisis
							); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 14;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into co_det_analisis (fec_analisis,fec_actual,cod_c\
ategoria,cnt_num_ident_saldo,cnt_cliente_saldo,cnt_abocelu_saldo,cnt_abobeep_s\
aldo,deu_vencida_saldo,cnt_num_ident_recup,cnt_cliente_recup,cnt_abocelu_recup\
,cnt_abobeep_recup,deu_vencida_recup,sec_analisis) values (to_date(:b0,'dd/mm/\
yyyy'),to_date(:b0,'dd/mm/yyyy'),:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9,:b10,:b11,:b1\
2,:b13)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )190;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)(td_DetAnalisis.fec_actual);
   sqlstm.sqhstl[0] = (unsigned long )11;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)(td_DetAnalisis.fec_actual);
   sqlstm.sqhstl[1] = (unsigned long )11;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)(td_DetAnalisis.cod_categoria);
   sqlstm.sqhstl[2] = (unsigned long )6;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&(td_DetAnalisis.cnt_rut_saldo);
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&(td_DetAnalisis.cnt_cliente_saldo);
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&(td_DetAnalisis.cnt_abocelu_saldo);
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&(td_DetAnalisis.cnt_abobeep_saldo);
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&(td_DetAnalisis.deu_vencida_saldo);
   sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&(td_DetAnalisis.cnt_rut_recup);
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&(td_DetAnalisis.cnt_cliente_recup);
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&(td_DetAnalisis.cnt_abocelu_recup);
   sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&(td_DetAnalisis.cnt_abobeep_recup);
   sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&(td_DetAnalisis.deu_vencida_recup);
   sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)&(td_DetAnalisis.sec_analisis);
   sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
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


							
		    if ( SQLCODE != SQLOK ) {
	        	sprintf(szDescError,"Fallo INSERT co_det_analisis, Sec Analisis = [%ld] \n %s"
	            	               , td_Analisis.sec_analisis, SQLERRM);
		        ifnTrazasLog(modulo,"INSERT co_det_analisis %s",LOG00,SQLERRM);
		        return -1; /*Mail*/
		    }
	     
	 	} /* End While creacion detalle analisis*/
    
	    /* EXEC SQL CLOSE curDETANALISIS; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 14;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )261;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    
	    
	    if ( SQLCODE ) {
	        sprintf(szDescError,"Fallo el cierre del cursor detalle analisis");
	        ifnTrazasLog(modulo,"Close curDETANALISIS %s",LOG00,SQLERRM);
	        return -1; /*Mail*/
	    }

 		lRowsProcessed++;
 		        
 	} /* End While */

    /* EXEC SQL CLOSE curANALISIS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 14;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )276;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

    
    
    if ( SQLCODE ) {
        sprintf(szDescError,"Fallo el cierre del cursor de analisis");
        ifnTrazasLog(modulo,"Close curANALISIS %s",LOG00,SQLERRM);
        ihFlgError = 1;/*NoMail*/
    }

    ifnTrazasLog(modulo,"saliendo de %s",LOG05,modulo);

    if (ihFlgError) /* !=0 ocurrio un error */
        return ihFlgError;

    return 0; 
}
/* ============================================================================= */

/* ============================================================================= */
/*  ifnEstadisticaMorosos() :  Genera estadisticas para morosos                  */ 
/*                             llena tabla co_estmorosos                         */
/* ============================================================================= */
int ifnEstadisticaMorosos(char* szDescError)
{
    char modulo[] = "ifnEstadisticaMorosos";

    ifnTrazasLog ( modulo,"Entrando en %s", LOG05, modulo );

	/* EXEC SQL INSERT INTO co_estmorosos (fec_analisis,
					        			cod_categoria,
					        			cod_gestion,
					        			cnt_num_ident,	/o mgg 20030113 o/
					        			cnt_cliente,
					        			cnt_abocelu,
					        			cnt_abobeep,
					        			deu_vencida,
					        			deu_inicial,
					        			deu_novenc
        							   ) 	 
										SELECT  m.fec_analisis,
												m.cod_categoria,
												m.cod_gestion,
												count(distinct m.cnt_num_ident),	/o mgg 20030113 o/
												count(m.cnt_cliente),
												sum(m.cnt_abocelu),
												sum(m.cnt_abobeep),
												sum(m.deu_vencida),
												sum(m.deu_inicial),
												sum(m.deu_novenc)
										FROM (  SELECT  trunc(sysdate - 1) as fec_analisis,
														cod_categoria,
														cod_gestion,
														num_ident as cnt_num_ident,	/o mgg 20030113 o/
														cod_cliente as cnt_cliente,
														NVL(cnt_abocelu,0) as cnt_abocelu,  /o GAC  15.09.03 Homol. HB-0007 o/
														NVL(cnt_abobeep,0) as cnt_abobeep,  /o GAC  15.09.03 Homol. HB-0007 o/
														NVL(deu_vencida,0) as deu_vencida,  /o GAC  15.09.03 Homol. HB-0007 o/
														deu_inicial as deu_inicial,
														NVL(deu_novenc,0) as deu_novenc     /o GAC  15.09.03 Homol. HB-0007 o/
												FROM  	co_morosos
												UNION
												SELECT  trunc(sysdate - 1) as fec_analisis,
														cod_categoria,
														cod_gestion,
														num_ident as cnt_num_ident,	/o mgg 20030113 o/
														cod_cliente as cnt_cliente,
														NVL(cnt_abocelu,0) as cnt_abocelu,  /o GAC  15.09.03 Homol. HB-0007 o/
														NVL(cnt_abobeep,0) as cnt_abobeep,  /o GAC  15.09.03 Homol. HB-0007 o/
														NVL(deu_vencida,0) as deu_vencida,  /o GAC  15.09.03 Homol. HB-0007 o/
														deu_inicial as deu_inicial,
														NVL(deu_novenc,0) as deu_novenc     /o GAC  15.09.03 Homol. HB-0007 o/
												FROM  	co_hmorosos
												WHERE   fec_historico >= trunc(sysdate)
											 ) m
										GROUP BY m.cod_categoria, m.cod_gestion, m.fec_analisis; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 14;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlbuft((void **)0, 
   "insert into co_estmorosos (fec_analisis,cod_categoria,cod_gestion,cnt_nu\
m_ident,cnt_cliente,cnt_abocelu,cnt_abobeep,deu_vencida,deu_inicial,deu_nove\
nc)select m.fec_analisis ,m.cod_categoria ,m.cod_gestion ,count(distinct m.c\
nt_num_ident) ,count(m.cnt_cliente) ,sum(m.cnt_abocelu) ,sum(m.cnt_abobeep) \
,sum(m.deu_vencida) ,sum(m.deu_inicial) ,sum(m.deu_novenc)  from (select tru\
nc((sysdate-1)) fec_analisis ,cod_categoria ,cod_gestion ,num_ident cnt_num_\
ident ,cod_cliente cnt_cliente ,NVL(cnt_abocelu,0) cnt_abocelu ,NVL(cnt_abob\
eep,0) cnt_abobeep ,NVL(deu_vencida,0) deu_vencida ,deu_inicial deu_inicial \
,NVL(deu_novenc,0) deu_novenc  from co_morosos  union select trunc((sysdate-\
1)) fec_analisis ,cod_categoria ,cod_gestion ,num_ident cnt_num_ident ,cod_c\
liente cnt_cliente ,NVL(cnt_abocelu,0) cnt_abocelu ,NVL(cnt_abobeep,0) cnt_a\
bobeep ,NVL(deu_vencida,0) deu_vencida ,deu_inicial deu_inicial ,NVL(deu_nov\
enc,0) deu_novenc  from co_hmorosos where fec_historico>=trunc(sysdate)) m  \
group by m.cod_categoria,m.cod_gestion,m");
 sqlstm.stmt = ".fec_analisis";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )291;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

       		 

    if ( SQLCODE != SQLOK ) {
        sprintf(szDescError,"Fallo la creacion de Registros para Estadistica de Morosos %s",SQLERRM);
        ifnTrazasLog(modulo,"INSERT INTO CO_ESTMOROSOS %s",LOG00,SQLERRM);
        return -1; /*Mail*/
    }
    
    ifnTrazasLog(modulo,"saliendo de %s",LOG05,modulo);

    return 0; 
}
/* ============================================================================= */



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

