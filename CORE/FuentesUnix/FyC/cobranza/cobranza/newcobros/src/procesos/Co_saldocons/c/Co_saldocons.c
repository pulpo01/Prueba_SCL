
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
    "./pc/Co_saldocons.pc"
};


static unsigned int sqlctx = 55300915;


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

 static const char *sq0007 = 
"select COD_CLIENTE ,sum((IMPORTE_DEBE-IMPORTE_HABER))  from CO_CARTERA where\
 (((FEC_VENCIMIE>=TRUNC(SYSDATE) and exists (select COD_CLIENTE  from CO_SALDO\
CONS_TO )) and  not exists (select COD_VALOR  from CO_CODIGOS where ((NOM_TABL\
A=:b0 and NOM_COLUMNA=:b1) and TO_CHAR(COD_TIPDOCUM)=COD_VALOR))) and IND_FACT\
URADO=:b2) group by COD_CLIENTE having sum((IMPORTE_DEBE-IMPORTE_HABER))>:b3  \
         ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,67,0,4,75,0,0,2,1,0,1,0,2,5,0,0,1,97,0,0,
28,0,0,2,61,0,5,93,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
51,0,0,3,0,0,29,105,0,0,0,0,0,1,0,
66,0,0,4,0,0,29,393,0,0,0,0,0,1,0,
81,0,0,5,462,0,3,422,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
116,0,0,6,29,0,2,466,0,0,0,0,0,1,0,
131,0,0,7,397,0,9,510,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
162,0,0,7,0,0,13,518,0,0,2,0,0,1,0,2,3,0,0,2,4,0,0,
185,0,0,8,69,0,5,537,0,0,2,2,0,1,0,1,4,0,0,1,3,0,0,
208,0,0,7,0,0,15,554,0,0,0,0,0,1,0,
};


/* ================================================================================================================ */
/*
   Tipo        :  COLA DE PROCESO
   Nombre      :  Co_saldocons.pc
   Parametros  :  Usuario/Password. ( por defecto asume los de la cuenta )
                  Nivel de Log ( por defecto asume 3 : Log Normal ) 
                  Nombre de la Cola (Opcional), para nombrar archivos de log
   Autor       :  GAC
   Fecha       :  Diciembre-2003
*/ 
/* ================================================================================================================ */
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_

#include "Co_saldocons.h"

LINEACOMANDO  	stLineaComando;     		/* Datos con los que se invoco al proceso */
char 			szgCodProceso[6]  = "";
char 			szArchivoLog[256] = ""; 	/* log */

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

	  char	szhCodEstado[2]; 		/* EXEC SQL VAR szhCodEstado IS STRING (2); */ 

     char   szhSalco        [6];
     char   szhWait         [2];
     char   szhCo_cartera   [11];
     char   szhCod_tipdocum [13];
	  int    ihValor_Cero = 0 ;
	  int    ihValor_Uno  = 1 ;
/* EXEC SQL END DECLARE SECTION; */ 


int main( int argc, char *argv[] )
{
char modulo[] = "main";
int iResult = 0;

    fprintf(stdout, "\n%s SALCO pid(%ld) VERSION [%s]\n", szGetTime(1),getpid(),szVERSION);
    fflush (stdout);
    
    strcpy(szhSalco,SALCO);
    strcpy(szhWait ,W );
    strcpy(szhCo_cartera ,CO_CARTERA);
    strcpy(szhCod_tipdocum,COD_TIPDOCUM);

    
    /*- Validacion de parametros de entrada -*/
    memset(&stLineaComando,0,sizeof(LINEACOMANDO));
    if (ifnValidaParametros(argc,argv,&stLineaComando) != 0) {
        fprintf (stdout,"\n\tError >> Fallo la Validacion de Parametros \n");
        fflush  (stdout);
        iResult = 1; /* Fallo validacion */
    } else {    
        /*- Conexion a la Base de Datos -*/
        if (ifnConexionDB(&stLineaComando) != 0)   {
            fprintf (stdout,"\n\tError >> Fallo la Conexion a la Base \n");
            fflush  (stdout);
            iResult = 2; /* Fallo conexion */

        } else  {
            /*- Prepara Archivo de Log -*/ 
            if (ifnPreparaArchivoLog() != 0)    {
                fprintf (stdout,"\n\tError >> Fallo Archivo de Log (Local al proceso) \n");
                fflush  (stdout);
                iResult = 3;  /* Fallo Log */
            
	    } else {
                /*- Ejecuta el proceso propiamente tal -*/
					if (ifnEjecutaCola() != 0)   {
			                    fprintf (stdout,"\n\tError >> Fallo el proceso \n");
			                    fflush  (stdout);
			                    iResult = 4; /* Fallo Proceso */
					} else {
               	
						/* EXEC SQL 
		            SELECT COD_ESTADO 
		            INTO :szhCodEstado
		            FROM CO_COLASPROC 
		            WHERE COD_PROCESO=:szhSalco; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 2;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLASPROC where COD\
_PROCESO=:b1";
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
      sqlstm.sqhstv[1] = (unsigned char  *)szhSalco;
      sqlstm.sqhstl[1] = (unsigned long )6;
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


		            
		            if (SQLCODE)  {
		                fprintf (stdout,"\n\tError >> Fallo el proceso ( Validacion Cola Wait ) \n");
		                fflush  (stdout);
		                ifnMailAlert("SALCO","TODOS","FALLO LA VALIDACION FINAL DE LA COLA.");
		                iResult = 5; /* Fallo Proceso */
		
		            } else {
		
		                if ( strcmp(szhCodEstado,"W")!=0 ) {
		                    /* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT */
		                    /* SEÑALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
		                    ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
		                    /* EXEC SQL 
		                    UPDATE CO_COLASPROC
		                    SET COD_ESTADO = :szhWait
		                    WHERE COD_PROCESO = :szhSalco; */ 

{
                      struct sqlexd sqlstm;
                      sqlstm.sqlvsn = 12;
                      sqlstm.arrsiz = 2;
                      sqlstm.sqladtp = &sqladt;
                      sqlstm.sqltdsp = &sqltds;
                      sqlstm.stmt = "update CO_COLASPROC  set COD_ESTADO=:b0\
 where COD_PROCESO=:b1";
                      sqlstm.iters = (unsigned int  )1;
                      sqlstm.offset = (unsigned int  )28;
                      sqlstm.cud = sqlcud0;
                      sqlstm.sqlest = (unsigned char  *)&sqlca;
                      sqlstm.sqlety = (unsigned short)256;
                      sqlstm.occurs = (unsigned int  )0;
                      sqlstm.sqhstv[0] = (unsigned char  *)szhWait;
                      sqlstm.sqhstl[0] = (unsigned long )2;
                      sqlstm.sqhsts[0] = (         int  )0;
                      sqlstm.sqindv[0] = (         short *)0;
                      sqlstm.sqinds[0] = (         int  )0;
                      sqlstm.sqharm[0] = (unsigned long )0;
                      sqlstm.sqadto[0] = (unsigned short )0;
                      sqlstm.sqtdso[0] = (unsigned short )0;
                      sqlstm.sqhstv[1] = (unsigned char  *)szhSalco;
                      sqlstm.sqhstl[1] = (unsigned long )6;
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


		
		                    if (SQLCODE) {
		                        fprintf (stdout,"\n\tError >> Fallo el proceso ( Update Cola Wait ) %s\n",SQLERRM );
		                        fflush  (stdout);
		                        ifnMailAlert("SALCO","TODOS","FALLO AL ACTUALIZAR LA COLA A 'WAIT'.");
		                        iResult = 6; /* Fallo Proceso */
		                    }                            
		
		                    /* EXEC SQL COMMIT; */ 

{
                      struct sqlexd sqlstm;
                      sqlstm.sqlvsn = 12;
                      sqlstm.arrsiz = 2;
                      sqlstm.sqladtp = &sqladt;
                      sqlstm.sqltdsp = &sqltds;
                      sqlstm.iters = (unsigned int  )1;
                      sqlstm.offset = (unsigned int  )51;
                      sqlstm.cud = sqlcud0;
                      sqlstm.sqlest = (unsigned char  *)&sqlca;
                      sqlstm.sqlety = (unsigned short)256;
                      sqlstm.occurs = (unsigned int  )0;
                      sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		                    if (SQLCODE) {
		                        fprintf (stdout,"\n\tError >> Fallo el proceso ( Commit Cola Wait ) %s\n", SQLERRM );
		                        fflush  (stdout);
		                        ifnMailAlert("SALCO","TODOS","FALLO EL COMMIT DE LA COLA 'WAIT'.");
		                        iResult = 7; /* Fallo Proceso */
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
extern  char  *optarg;
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
    strcpy(szgCodProceso,"SALCO"); /*valor por defecto es "SALCO" por SALCO */
    rtrim(szgCodProceso);

    
/*-- En caso de Invocacion sin Parametros ----------------------------------------*/
    if(argc == 1)   {
        return 0; /*ok asume valores por defecto */
    }

/*-- Analisis de los argumentos recibidos ----------------------------------------*/
    while ((iOpt=getopt(argc, argv, opt))!=EOF)    {

        switch(iOpt)
        {
            case 'u':  /*-- Usuario/Password --*/
                if(!Userflag) {
                    strcpy(pstLC->szUsuarioOra, optarg);                      
                    Userflag=1;
                    
                    if ((psztmp=(char *)strchr(pstLC->szUsuarioOra,'/'))==(char *)NULL) {
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
                if(!Logflag) {
                    stStatus.iLogNivel = (atoi(optarg) > 0)? atoi(optarg):iLOGNIVEL_DEF ;
                    Logflag=1;
                
                } else {
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
        }
    } 
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
    
    if( bfnOraConnect(pstLC->szOraAccount,pstLC->szOraPasswd) == FALSE )    {
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
    
    ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO <%ld> -\n", LOG03,szGetTime(1),getpid());

    return 0;
    
}/* end ifnAbreArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs  */
/* ============================================================================= */
void vfnCierraArchivoLog(void)
{
char modulo[]="vfnCierraArchivoLog";
    
    ifnTrazasLog(modulo, "%s -  CIERRE  DE ARCHIVO <%ld> -\n\n", LOG03,szGetTime(1),getpid());

    if ( fclose(stStatus.LogFile) != 0 )    {    
        fprintf (stderr,"Error al cerrar archivo de Log\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.ErrFile) != 0 )    {    
        fprintf (stderr,"Error al cerrar archivo de Errores\n");
        fflush  (stderr);
    }

    if ( fclose(stStatus.EstFile) != 0 )    {    
        fprintf (stderr,"Error al cerrar archivo de Estadisticas\n");
        fflush  (stderr);
    }
        
    return ;    
} /* end vfnCierraArchivoLog */
/* ============================================================================= */

/* ============================================================================= */
/*  ifnEjecutaCola() : Ejecuta la cola de acciones                               */
/* ============================================================================= */
int ifnEjecutaCola(void)
{
char modulo[]="ifnEjecutaCola";
char	szIniProc[9], szFinProc[9], szTmpProc[9];
int   iDifSegs = 0;

	sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );

	ifnTrazasLog( modulo, "Corriendo la cola lanzada ", LOG03 );
	ifnTrazasLog(modulo,"SALCO VERSION [%s]\n",LOG03, szVERSION);
	/*'Launched->Running'*/
	if( !bfnCambiaEstadoCola( szgCodProceso, "L", "R" ) ) {
	    if( !bfnOraRollBack() ) ifnTrazasLog( modulo, "En Rollback 'L->R' : %s", LOG00, SQLERRM );
	    return -1;

	}	else	{    
	    if( !bfnOraCommit() )   {    
	        ifnTrazasLog( modulo, "En Commit 'L->R' : %s", LOG00, SQLERRM );
	        if( !bfnOraRollBack() ) ifnTrazasLog( modulo, "En Rollback : %s", LOG00, SQLERRM );
	        return FALSE;    
	    }
	}
	/* Carga la estructura de manejo de decimales para la operadora local */
	if( !bGetParamDecimales() )	{
		ifnTrazasLog( modulo, "Error al realizar carga de bGetParamDecimales().", LOG03 );
		return -1;
	}
	
	if (ifnSaldoCliente() !=0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnSaldoCliente().", LOG03 );
		return -1;
	}
	
	/* Informacion Estadistica */
	sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );    
	if ( (iDifSegs=ifnRestaHoras(szIniProc,szFinProc,szTmpProc)) >= 0 )	{
	    ifnTrazasLog(modulo,"\n\tRESUMEN DEL PROCESO SALCO"
	                        "\n\t       HORA INICIO  : %s "
	                        "\n\t       HORA TERMINO : %s "
	                        "\n\t       TIEMPO TOTAL : %s  (%d segs)"
	                        "\n",EST00
	                        ,szIniProc,szFinProc,szTmpProc,iDifSegs);
	}


	ifnTrazasLog( modulo, "Volviendo la cola a espera ", LOG03 );
	/*'Running->Wait'*/
	if( !bfnCambiaEstadoCola( szgCodProceso, "R", "W") ) 	{
		if( !bfnOraRollBack() ) ifnTrazasLog( modulo, "En Rollback 'R->W' : %s", LOG00, SQLERRM );
		return -1;
	}

	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
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


	if (SQLCODE) {
	    fprintf (stdout,"\n\tError >> Fallo el Commit -  %s\n", SQLERRM );
	    fflush  (stdout);
		 return -1;
	}                            

	ifnTrazasLog( modulo, "Saliendo de %s ( Cola Wait )\n", LOG02, szgCodProceso );
	return 0;
}

/* ============================================================================= */
/*  ifnSaldoCliente() : Funcion que rescata los datos necesarios para poblar la  */
/*  tabla co_saldocons_to                                                           */
/* ============================================================================= */
int ifnSaldoCliente()
{
char modulo[]="ifnSaldoCliente";
long i, lTotalRows=0, lRowsThisLoop=0, lRowsProcessed=0, iRetSQLCODE=0; 
/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhaCod_Cliente  [MAX_REG];
		char   szhaFec_Vencim  [MAX_REG][20];
		double dhaSaldo_Ven	  [MAX_REG];
/* EXEC SQL END DECLARE SECTION; */ 
    

	if (ifnDeleteSaldosCons()!=0) return -1;

	ifnTrazasLog( modulo, "Procedemos a Insertar \n\t", LOG03);
	/*EXEC SQL DECLARE curClientes CURSOR FOR */
	/* EXEC SQL
	INSERT INTO CO_SALDOCONS_TO
			(COD_CLIENTE    , 
			 FEC_VENCIMIE   , 
			 SALDO_VENCIDO  ,
			 SALDO_NOVENCIDO,
			 FEC_SALDO      )
	SELECT COD_CLIENTE,
	       MIN(FEC_VENCIMIE),
		    SUM(IMPORTE_DEBE - IMPORTE_HABER),
		    :ihValor_Cero ,
		    SYSDATE
	FROM   CO_CARTERA 
	WHERE  TRUNC(FEC_VENCIMIE) < TRUNC(SYSDATE)
	AND    NOT EXISTS (SELECT COD_VALOR		 FROM  CO_CODIGOS
					 		 WHERE  NOM_TABLA     = :szhCo_cartera
	                 	 AND    NOM_COLUMNA   = :szhCod_tipdocum 
					 		 AND    TO_CHAR(COD_TIPDOCUM) = COD_VALOR)							   						   
	AND    IND_FACTURADO = :ihValor_Uno
	GROUP BY  COD_CLIENTE
	HAVING SUM(IMPORTE_DEBE - IMPORTE_HABER) > :ihValor_Cero; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_SALDOCONS_TO (COD_CLIENTE,FEC_VENCIMIE,SALDO_\
VENCIDO,SALDO_NOVENCIDO,FEC_SALDO)select COD_CLIENTE ,min(FEC_VENCIMIE) ,sum((\
IMPORTE_DEBE-IMPORTE_HABER)) ,:b0 ,SYSDATE  from CO_CARTERA where ((TRUNC(FEC_\
VENCIMIE)<TRUNC(SYSDATE) and  not exists (select COD_VALOR  from CO_CODIGOS wh\
ere ((NOM_TABLA=:b1 and NOM_COLUMNA=:b2) and TO_CHAR(COD_TIPDOCUM)=COD_VALOR))\
) and IND_FACTURADO=:b3) group by COD_CLIENTE having sum((IMPORTE_DEBE-IMPORTE\
_HABER))>:b0";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )81;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCo_cartera;
 sqlstm.sqhstl[1] = (unsigned long )11;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhCod_tipdocum;
 sqlstm.sqhstl[2] = (unsigned long )13;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihValor_Cero;
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




	lTotalRows = SQLROWS;    
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)	{
	    ifnTrazasLog(modulo,"Insert Select Co_SaldoCons_To - %s",LOG01,SQLERRM);
	    return -1;
	}

	ifnTrazasLog( modulo, "Total de registros insertados [%d]\n\t", LOG03, lTotalRows);

	if (ifnUpdateSaldoNoven()!=0) return -1;
	
	return 0;
}

/* ============================================================================= */
/*  ifnDeleteSaldosCons() : Funcion que borra la tabla co_saldocons_to              */
/* ============================================================================= */
int ifnDeleteSaldosCons()
{
char modulo[]="ifnSaldoCliente";

	ifnTrazasLog( modulo, "Eliminando Datos de CO_SALDOCONS_TO.\n", LOG03 );
	/* EXEC SQL
	DELETE FROM CO_SALDOCONS_TO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from CO_SALDOCONS_TO ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )116;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

	
	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)	{
	    ifnTrazasLog(modulo,"DELETE FROM CO_SALDOCONS_TO - %s",LOG01,SQLERRM);
	    return -1;
	}

	return 0;
}


/* ============================================================================= */
/*  ifnUpdateSaldoNoven() : Funcion que actualiza el saldo no vencido del cliente*/
/* ============================================================================= */
int ifnUpdateSaldoNoven()
{
char modulo[]="ifnUpdateSaldoNoven";
int  iRetSQLCODE = 0, i=0;
long lTotalRows = 0, lRowsThisLoop = 0, lRowsProcessed = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	  long    lahClientes   [MAX_REG];
	  double  dahSaldoNoven [MAX_REG];
/* EXEC SQL END DECLARE SECTION; */ 


	ifnTrazasLog( modulo, "Cargando clientes de CO_SALDOCONS_TO.\n", LOG03 );
	/* EXEC SQL DECLARE c_ClientesNV CURSOR FOR
	SELECT COD_CLIENTE,SUM(IMPORTE_DEBE - IMPORTE_HABER)
	FROM   CO_CARTERA 
	/oWHERE  FEC_VENCIMIE > TRUNC(SYSDATE)o/
	WHERE  FEC_VENCIMIE >= TRUNC(SYSDATE)    /oHM-200505160045 18-05-2005 Soporte RyC PRM. Homologación de incidencia xc-200502250235 o/
	AND    EXISTS (SELECT COD_CLIENTE FROM CO_SALDOCONS_TO)
	AND    NOT EXISTS (SELECT COD_VALOR	FROM  CO_CODIGOS
							 WHERE  NOM_TABLA     = :szhCo_cartera
				          AND    NOM_COLUMNA   = :szhCod_tipdocum 
							 AND    TO_CHAR(COD_TIPDOCUM) = COD_VALOR)							   						   
	AND    IND_FACTURADO = :ihValor_Uno
	GROUP BY COD_CLIENTE
	HAVING SUM(IMPORTE_DEBE - IMPORTE_HABER) > :ihValor_Cero; */ 


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error CURSOR c_ClientesNV %s.", LOG00, SQLERRM );  
		return -1;
	}	
	
	/* EXEC SQL OPEN c_ClientesNV; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0007;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )131;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCo_cartera;
 sqlstm.sqhstl[0] = (unsigned long )11;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCod_tipdocum;
 sqlstm.sqhstl[1] = (unsigned long )13;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_Uno;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Cero;
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


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error OPEN c_ClientesNV %s.", LOG00, SQLERRM );  
		return -1;
	}	

	while( 1 ) 
	{
		/* EXEC SQL 
		FETCH c_ClientesNV
	   INTO :lahClientes,
	   	  :dahSaldoNoven; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )30000;
  sqlstm.offset = (unsigned int  )162;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)lahClientes;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )sizeof(long);
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqharc[0] = (unsigned long  *)0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)dahSaldoNoven;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )sizeof(double);
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqharc[1] = (unsigned long  *)0;
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



		if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
			ifnTrazasLog( modulo, "\tEn FETCH c_ClientesNV\n\t %s", LOG01, SQLERRM );
			return -1;
		}

		lTotalRows = SQLROWS;    /* Total de filas recuperadas */
     	iRetSQLCODE = SQLCODE;
     	lRowsThisLoop = ( lTotalRows - lRowsProcessed );    /* filas recuperadas en esta iteracion (Total-Procesadas) */
		ifnTrazasLog( modulo, "lTotalRows = [%d], lRowsThisLoop = [%d]\n\t", LOG03, lTotalRows, lRowsThisLoop );


		for( i = 0; i < lRowsThisLoop; i++ ) {

				ifnTrazasLog( modulo, "\tlahClientes[i]     [%d]", LOG06, lahClientes[i] );
				/* EXEC SQL
				UPDATE CO_SALDOCONS_TO SET
						 SALDO_NOVENCIDO = :dahSaldoNoven[i]
				WHERE  COD_CLIENTE = :lahClientes[i]; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_SALDOCONS_TO  set SALDO_NOVENCIDO=:b0 where COD\
_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )185;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dahSaldoNoven[i];
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lahClientes[i];
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


				if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
					ifnTrazasLog( modulo, "\tEn UPDATE CO_SALDOCONS_TO SET\n\t %s", LOG01, SQLERRM );
					return -1;
				}
		}

      lRowsProcessed = lTotalRows; /* Resetea Contador, Total las filas recuperadas se han procesado */
		if( iRetSQLCODE == SQLNOTFOUND )  {
			ifnTrazasLog( modulo, "\tFin de Datos c_ClientesNV.\n", LOG03 );
			break;
		}
	} 

	/* EXEC SQL CLOSE c_ClientesNV; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )208;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )	{
		ifnTrazasLog( modulo, "Error CLOSE c_ClientesNV %s.", LOG00, SQLERRM );  
		return -1;
	}	

	return 0;
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
