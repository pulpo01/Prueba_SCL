
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
           char  filnam[28];
};
static const struct sqlcxp sqlfpn =
{
    27,
    "./pc/Co_RepPagos_Diarios.pc"
};


static unsigned int sqlctx = 1510654909;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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

 static const char *sq0006 = 
"select COD_ENTIDAD ,DES_ENTIDAD  from CO_ENTCOB where SYSDATE between FEC_IN\
I_VIGENCIA and FEC_FIN_VIGENCIA order by COD_ENTIDAD            ";

 static const char *sq0007 = 
"select COD_ENTIDAD ,DES_ENTIDAD ,EMAIL  from CO_ENTCOB where SYSDATE between\
 FEC_INI_VIGENCIA and FEC_FIN_VIGENCIA order by COD_ENTIDAD            ";

 static const char *sq0008 = 
"select distinct B.COD_CLIENTE  from CO_PAGOS B where ((COD_TIPDOCUM in (9,25\
,8,83,84) and B.FEC_EFECTIVIDAD between TO_DATE(:b0,:b1) and TO_DATE(:b2,:b1))\
 and exists (select COD_CLIENTE  from CO_MOROSOS where (COD_CLIENTE=B.COD_CLIE\
NTE and COD_AGENTE=:b4)))           ";

 static const char *sq0009 = 
"select B.COD_CLIENTE ,B.COD_TIPDOCUM ,B.NUM_SECUENCI ,TO_CHAR(B.FEC_EFECTIVI\
DAD,:b0) ,B.NOM_USUARORA ,A.NUM_SECUREL ,A.COD_TIPDOCREL ,TO_CHAR(A.FEC_CANCEL\
ACION,:b0) ,TO_CHAR(A.FEC_CANCELACION,:b2) ,NVL(B.NUM_COMPAGO,(-1)) ,A.SEC_CUO\
TA ,A.NUM_CUOTA ,sum(A.IMP_CONCEPTO)  from CO_PAGOS B ,CO_PAGOSCONC A where ((\
(((B.NUM_SECUENCI=A.NUM_SECUENCI and B.COD_TIPDOCUM=A.COD_TIPDOCUM) and B.COD_\
TIPDOCUM in (9,25,8,83,84)) and B.COD_CLIENTE=:b3) and B.FEC_EFECTIVIDAD betwe\
en TO_DATE(:b4,:b5) and TO_DATE(:b6,:b5)) and exists (select COD_CLIENTE  from\
 CO_MOROSOS where (COD_CLIENTE=:b3 and COD_AGENTE=:b9))) group by B.COD_CLIENT\
E,B.COD_TIPDOCUM,B.NUM_SECUENCI,B.FEC_EFECTIVIDAD,B.NOM_USUARORA,A.NUM_SECUREL\
,A.COD_TIPDOCREL,TO_CHAR(A.FEC_CANCELACION,:b0),TO_CHAR(A.FEC_CANCELACION,:b2)\
,B.NUM_COMPAGO,A.SEC_CUOTA,A.NUM_CUOTA           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,67,0,4,96,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
28,0,0,2,61,0,5,113,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
51,0,0,3,0,0,29,124,0,0,0,0,0,1,0,
66,0,0,4,245,0,6,262,0,0,7,7,0,1,0,2,5,0,0,1,5,0,0,2,5,0,0,1,5,0,0,2,5,0,0,1,5,
0,0,2,5,0,0,
109,0,0,5,0,0,29,421,0,0,0,0,0,1,0,
124,0,0,6,140,0,9,463,0,0,0,0,0,1,0,
139,0,0,6,0,0,13,471,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
162,0,0,6,0,0,15,525,0,0,0,0,0,1,0,
177,0,0,7,147,0,9,569,0,0,0,0,0,1,0,
192,0,0,7,0,0,13,578,0,0,3,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,
219,0,0,7,0,0,15,601,0,0,0,0,0,1,0,
234,0,0,8,268,0,9,1082,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
269,0,0,8,0,0,13,1092,0,0,1,0,0,1,0,2,3,0,0,
288,0,0,8,0,0,15,1111,0,0,0,0,0,1,0,
303,0,0,9,827,0,9,1203,0,0,12,12,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
366,0,0,9,0,0,13,1213,0,0,13,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,
433,0,0,9,0,0,15,1282,0,0,0,0,0,1,0,
448,0,0,10,175,0,4,1390,0,0,8,6,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
1,3,0,0,1,4,0,0,1,3,0,0,
495,0,0,11,172,0,4,1407,0,0,8,6,0,1,0,1,5,0,0,1,5,0,0,2,3,0,0,2,3,0,0,1,3,0,0,
1,3,0,0,1,4,0,0,1,3,0,0,
542,0,0,12,161,0,4,1456,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
569,0,0,13,248,0,4,1519,0,0,7,3,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
612,0,0,14,252,0,4,1536,0,0,7,3,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
655,0,0,15,190,0,4,1600,0,0,5,2,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
690,0,0,16,192,0,4,1660,0,0,5,2,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
725,0,0,17,197,0,4,1722,0,0,5,3,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
760,0,0,18,81,0,4,1736,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
783,0,0,19,71,0,4,1780,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
806,0,0,20,236,0,4,1828,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
};


/* ================================================================================================================ */
/*
   Tipo        :  COLA DE PROCESO
   Nombre      :  Co_RepPagos_Diarios.pc
   Parametros  :  Usuario/Password. ( por defecto asume los de la cuenta )
                  Nivel de Log ( por defecto asume 3 : Log Normal ) 
                  Nombre de la Cola (Opcional), para nombrar archivos de log
   Autor       :  
   Fecha       :  12-Agosto-2009
*/ 
/* ================================================================================================================ */
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_

#include "Co_RepPagos_Diarios.h"

LINEACOMANDO  	stLineaComando;     		/* Datos con los que se invoco al proceso */
char 			szgCodProceso[6]  = "";
char 			szArchivoLog[256] = ""; 	/* log */
char            *pathDir ;
char            szPathDat   [128] = "";
char            szPathLog   [128] = "";

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

    char	szhCodEstado          [2]; /* EXEC SQL VAR szhCodEstado          IS STRING (2); */ 

    char    szhRpagd              [6]; /* EXEC SQL VAR szhRpagd              IS STRING (6); */ 

    char    szhWait               [2]; /* EXEC SQL VAR szhWait               IS STRING (2); */ 

    char    szhYYYYMMDD           [9]; /* EXEC SQL VAR szhYYYYMMDD           IS STRING (9); */ 

    char    szFechayyyymmdd       [9]; /* EXEC SQL VAR szFechayyyymmdd       IS STRING (9); */ 
    
    char    szhYYYYMMDDHH24miss  [17]; /* EXEC SQL VAR szhYYYYMMDDHH24miss   IS STRING (17); */ 
    
    char    szFechayyyymmddhhmmss[17]; /* EXEC SQL VAR szFechayyyymmddhhmmss IS STRING (17); */ 
    
    char    szhDDMMYYYY1         [11]; /* EXEC SQL VAR szhDDMMYYYY1          IS STRING (11); */ 
                                              
    char    szhDDMMYYYY2          [9]; /* EXEC SQL VAR szhDDMMYYYY2          IS STRING (9); */ 
                                              
    char    szhDDMMYYYY3         [11]; /* EXEC SQL VAR szhDDMMYYYY3          IS STRING (11); */ 
                                              
    char    szhAnteayer          [11]; /* EXEC SQL VAR szhAnteayer           IS STRING (11); */ 
                                              
    char    szhHoy               [11]; /* EXEC SQL VAR szhHoy                IS STRING (11); */ 
                                              
/* EXEC SQL END DECLARE SECTION; */ 


td_ArchiCob sthArcPagos;         /* Estructura de Pagos Diarios                */
td_ArchiCob sthArcNotCr;         /* Estructura de Notas de Creditos            */
td_ArchiCob sthArcRever;         /* Estructura de Reversas                     */

long        lIndAPagos;          /* Indice de archivos para Pagos Diarios      */
long        lIndANotaC;          /* Indice de archivos para Notas de Creditos  */
long        lIndARever;          /* Indice de archivos para Reversas           */

/* ============================================================================= */
/*  main                                                                         */
/* ============================================================================= */
int main( int argc, char *argv[] )
{
char modulo[] = "main";
int iResult = 0;

    fprintf(stdout, "\n%s RPAGD pid(%ld) VERSION [%s]\n", szGetTime(1),getpid(),szVERSION);
    fflush (stdout);

    /*- Inicializacion de parametros  -*/    
    memset(szgCodProceso,0,sizeof(szgCodProceso));    
    strcpy(szgCodProceso,"RPAGD"); 
    rtrim(szgCodProceso);
    
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
    	    /* Inicializacion de Parametros */
    	    vfnInicializacionParametros();    
    	
            /*- Prepara Archivo de Log -*/ 
            if (ifnAbreArchivoLog() != 0)    {
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
		            WHERE COD_PROCESO=:szhRpagd; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 2;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_ESTADO into :b0  from CO_COLASPROC where COD_\
PROCESO=:b1";
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
     sqlstm.sqhstv[1] = (unsigned char  *)szhRpagd;
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
		                iResult = 5; /* Fallo Proceso */
		
		            } else {
		
		                if ( strcmp(szhCodEstado,"W")!=0 ) {
		                    /* LA COLA ESTA EN UN ESTADO DISTINTO DE WAIT         */
		                    /* SEÑALAR ESTO COMO ERROR E INTENTAR FORZARLA A WAIT */
		                    ifnTrazasLog(modulo,"Regresando la Cola a Espera (%s)",LOG02,szhCodEstado);
		                    /* EXEC SQL 
		                    UPDATE CO_COLASPROC
		                       SET COD_ESTADO = :szhWait
		                     WHERE COD_PROCESO = :szhRpagd; */ 

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
                      sqlstm.sqhstv[1] = (unsigned char  *)szhRpagd;
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
		                        iResult = 7; /* Fallo Proceso */
		                     }                            
		                     ifnTrazasLog(modulo,"OK. Cola forzada a espera",LOG02);
		                 }
		             }
                } /* end ifnEjecutaCola */
                vfnCierraArchivoLog();
            } /* end ifnAbreArchivoLog */
        } /* end ifnConexionDB*/
    } /* end ifnValidaParametros */

    return iResult;
   
} /* end main */    

/* ============================================================================= */
/* ifnValidaParametros : Realiza la validacion de los Parametros de Entrada      */
/* ============================================================================= */
int ifnValidaParametros( int argc, char *argv[], LINEACOMANDO *pstLC )
{
char modulo[]="ifnValidaParametros";

/*-- Definicion de variables para controlar la lista de argumentos recibidos ----*/
extern  char *optarg;
extern  int  optind, opterr, optopt;
        int  iOpt=0;
        char opt[] = ":u:l:n:";
/*-- Variables locales -----------------------------------------------------------*/  
char  *psztmp = "";
/*-- Flags de los valores recibidos ----------------------------------------------*/
int  Userflag=0;
int  Logflag=0;

/*-- Seteo de Valores Iniciles y por defecto -------------------------------------*/
    opterr=0;
    stStatus.iLogNivel = iLOGNIVEL_DEF ;
    
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
    } /* end while */
    pstLC->iLogLevel=stStatus.iLogNivel;
    return 0;

} /* ifnValidaParametros */

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
} /* end ifnConexionDB */

/* ============================================================================= */
/* vfnInicializacionParametros():                                                */
/* ============================================================================= */
void vfnInicializacionParametros(void)
{
char modulo[]="vfnInicializacionParametros";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhPathLogSched[256]; /* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

/* EXEC SQL END DECLARE SECTION; */ 


    
    strcpy(szhRpagd           ,RPAGD);
  	strcpy(szhYYYYMMDD	      ,"YYYYMMDD");
  	strcpy(szhYYYYMMDDHH24miss,"YYYYMMDDHH24miss");
    strcpy(szhWait            ,W );
    strcpy(szhDDMMYYYY1       ,"DD-MM-YYYY");
    strcpy(szhDDMMYYYY2       ,"DDMMYYYY");
    strcpy(szhDDMMYYYY3       ,"DD/MM/YYYY");
    
    /* EXEC SQL EXECUTE
		BEGIN
			:szFechayyyymmddhhmmss	:=TO_CHAR(SYSDATE  ,:szhYYYYMMDDHH24miss); 
			:szFechayyyymmdd        :=TO_CHAR(SYSDATE  ,:szhYYYYMMDD);
			:szhAnteayer            :=TO_CHAR(SYSDATE-2,:szhDDMMYYYY1);
			:szhHoy                 :=TO_CHAR(SYSDATE  ,:szhDDMMYYYY1);  
		END;
	END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szFechayyyymmddhhmmss := TO_CHAR ( SYSDATE , :szhY\
YYYMMDDHH24miss ) ; :szFechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMDD ) ; :\
szhAnteayer := TO_CHAR ( SYSDATE -2 , :szhDDMMYYYY1 ) ; :szhHoy := TO_CHAR ( S\
YSDATE , :szhDDMMYYYY1 ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szFechayyyymmddhhmmss;
    sqlstm.sqhstl[0] = (unsigned long )17;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDDHH24miss;
    sqlstm.sqhstl[1] = (unsigned long )17;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szFechayyyymmdd;
    sqlstm.sqhstl[2] = (unsigned long )9;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDD;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhAnteayer;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhDDMMYYYY1;
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhHoy;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
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


	
	lIndAPagos = 0;
    lIndANotaC = 0;
    lIndARever = 0;

	sprintf(stStatus.szFileName   ,"%s",szgCodProceso);
	sprintf(szhPathLogSched       ,"%s/CO_SCHEDULER",getenv("XPC_LOG"));    
	sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    
  	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

    sprintf(szPathDat  ,"%s/newcobros/dat/Cobexterna/%s",pathDir,szFechayyyymmdd);
    sprintf(szPathLog  ,"%s/%s",stStatus.szLogPathGene,szFechayyyymmdd);

    return;
} /* end vfnInicializacionParametros */

/* ============================================================================= */
/* ifnAbreArchivoLog(): Abre archivos de log, errores y estadisticas modo append */
/* if iCreaDir != 0 : crear directorio antes que el archivo                      */
/* ============================================================================= */
int ifnAbreArchivoLog()
{
char modulo[]="ifnAbreArchivoLog";
char szArchivoErr[256]=""; /* errores  */
char szArchivoLog[256]=""; /* log      */
char szComando   [256]="";
static char szAux[9];

    sprintf(szComando,"mkdir -p %s",szPathLog);

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
    }

    sprintf(szComando,"mkdir -p %s",szPathDat);

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar crear directorio de Dat\n");
        fflush  (stderr);
        return -1;
    }

	free(pathDir);    

    memset(szArchivoLog,0,sizeof(szArchivoLog)); /* log                       */         
    memset(szArchivoErr,0,sizeof(szArchivoErr)); /* errores                   */     

    sprintf(szArchivoLog,"%s/%s.log",szPathLog,stStatus.szFileName);
    sprintf(szArchivoErr,"%s/%s.err",szPathLog,stStatus.szFileName);
    
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
    
    ifnTrazasLog(modulo, "%s - APERTURA DE ARCHIVO <%ld> -\n", LOG03,szGetTime(1),getpid());

    return 0;
    
}/* end ifnAbreArchivoLog */

/* ============================================================================= */
/* vfnCierraArchivoLog(): cierra los descriptores de los archivos de logs        */
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
        
    return ;    
} /* end vfnCierraArchivoLog */

/* ============================================================================= */
/*  ifnEjecutaCola() : Ejecuta la cola de acciones                               */
/* ============================================================================= */
int ifnEjecutaCola(void)
{
char  modulo[]="ifnEjecutaCola";
char  szIniProc[9], szFinProc[9], szTmpProc[9];
int   iDifSegs = 0;

	sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );

	ifnTrazasLog( modulo, "Corriendo la cola lanzada ", LOG03 );
	ifnTrazasLog(modulo,"RPAGD VERSION [%s]\n",LOG03, szVERSION);
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
	
	if (ifnGeneraUniverso() !=0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnGeneraUniverso().", LOG03 );
		return -1;
	}
	
	if (ifnGeneraArchivos() !=0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnGeneraArchivos().", LOG03 );
		return -1;
	}		
	
	/* Informacion Estadistica */
	sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );    
	if ( (iDifSegs=ifnRestaHoras(szIniProc,szFinProc,szTmpProc)) >= 0 )	{
	    ifnTrazasLog(modulo,"\n\tRESUMEN DEL PROCESO RPAGD"
	                        "\n\t       HORA INICIO  : %s "
	                        "\n\t       HORA TERMINO : %s "
	                        "\n\t       TIEMPO TOTAL : %s  (%d segs)"
	                        "\n",EST00
	                        ,szIniProc,szFinProc,szTmpProc,iDifSegs);
	}

	ifnTrazasLog( modulo, "Volviendo la cola a espera ", LOG03 );
	if( !bfnCambiaEstadoCola( szgCodProceso, "R", "W") ) 	{
		if( !bfnOraRollBack() ) ifnTrazasLog( modulo, "En Rollback 'R->W' : %s", LOG00, SQLERRM );
		return -1;
	}

	/* EXEC SQL COMMIT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )109;
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
	
} /* end ifnEjecutaCola */

/* ============================================================================= */
/*  ifnGeneraUniverso() : Funcion que rescata los datos de la empresa de cobranza*/
/* ============================================================================= */
int ifnGeneraUniverso()
{
char modulo[]   = "ifnGeneraUniverso";
int  iError     = 0;     
int  iRes       = 0;    

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   	char  shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char  shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_EntCobEx CURSOR for        
    SELECT COD_ENTIDAD, DES_ENTIDAD
      FROM CO_ENTCOB
     WHERE SYSDATE BETWEEN FEC_INI_VIGENCIA AND FEC_FIN_VIGENCIA   
     ORDER BY COD_ENTIDAD; */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_EntCobEx - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_EntCobEx; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )124;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_EntCobEx - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_EntCobEx INTO :shCodEntidad, :shDesEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )139;
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
	    
        /* Inicializacion de Array por Entidad de Cobranza */
        strcpy(sthArcPagos.sCodAgente[lIndAPagos], shCodEntidad);
        strcpy(sthArcPagos.sDesAgente[lIndAPagos], shDesEntidad); 
        sthArcPagos.lNumRegistr[lIndAPagos] = 0;
        
        strcpy(sthArcNotCr.sCodAgente[lIndANotaC], shCodEntidad);
        strcpy(sthArcNotCr.sDesAgente[lIndANotaC], shDesEntidad); 
        sthArcNotCr.lNumRegistr[lIndANotaC] = 0; 

        strcpy(sthArcRever.sCodAgente[lIndARever], shCodEntidad);
        strcpy(sthArcRever.sDesAgente[lIndARever], shDesEntidad);
        sthArcRever.lNumRegistr[lIndARever] = 0; 
        
        lIndAPagos = lIndAPagos + 1;
        lIndANotaC = lIndANotaC + 1;
        lIndARever = lIndARever + 1;
                          	    
        iRes = ifnBuscaClientes(shCodEntidad, shDesEntidad);
	    if( iRes < 0 ) break;        	    

        /* Fin de registro por Entidad de Cobranza */
        lIndAPagos = lIndAPagos + 1;
        lIndANotaC = lIndANotaC + 1;
        lIndARever = lIndARever + 1;

        sthArcPagos.lNumRegistr[lIndAPagos] = -1;
        sthArcNotCr.lNumRegistr[lIndANotaC] = -1; 
        sthArcRever.lNumRegistr[lIndARever] = -1; 

        strcpy(sthArcPagos.sCodAgente[lIndAPagos], shCodEntidad);
        strcpy(sthArcPagos.sDesAgente[lIndAPagos], shDesEntidad); 
        
        strcpy(sthArcNotCr.sCodAgente[lIndANotaC], shCodEntidad);
        strcpy(sthArcNotCr.sDesAgente[lIndANotaC], shDesEntidad); 

        strcpy(sthArcRever.sCodAgente[lIndARever], shCodEntidad);
        strcpy(sthArcRever.sDesAgente[lIndARever], shDesEntidad);        	    

	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_EntCobEx; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )162;
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
  
} /* end ifnGeneraUniverso() */

/* ============================================================================= */
/*  ifnGeneraArchivos() : Funcion que rescata los datos de la empresa de cobranza*/
/* ============================================================================= */
int ifnGeneraArchivos()
{
char modulo[]= "ifnGeneraArchivos";
int  iError  = 0 ;     
int  i           ;   
int  iHayRegistro;
int  iRes    = 0 ;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   	char  shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char  shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 

	char  shEMail        [51]; /* EXEC SQL VAR shEMail      IS STRING(51); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_EntCobEx2 CURSOR for        
    SELECT COD_ENTIDAD, DES_ENTIDAD, EMAIL
      FROM CO_ENTCOB      
     WHERE SYSDATE BETWEEN FEC_INI_VIGENCIA AND FEC_FIN_VIGENCIA   
     ORDER BY COD_ENTIDAD; */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_EntCobEx2 - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_EntCobEx2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )177;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_EntCobEx2 - %s", LOG00,SQLERRM );
        return -1;
    }
       
	while(1) {

        /* EXEC SQL FETCH Cur_EntCobEx2 INTO :shCodEntidad, :shDesEntidad, :shEMail; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )192;
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
        sqlstm.sqhstv[2] = (unsigned char  *)shEMail;
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



		if (SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }
	    
	    iRes = ifnGenArchivosPagos(shCodEntidad, shDesEntidad, shEMail);
        if( iRes < 0 ) break;

        iRes = ifnGenArchivosNC(shCodEntidad, shDesEntidad, shEMail);
        if( iRes < 0 ) break;
	   	    	    
	    iRes = ifnGenArchivosRev(shCodEntidad, shDesEntidad, shEMail);
        if( iRes < 0 ) break;	    
	            	    
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_EntCobEx2; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 7;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )219;
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

} /* end ifnGeneraArchivos */

/* ============================================================================= */
/*  ifnGenArchivosPagos: Funcion que genera los archivos con notas de credito    */
/* ============================================================================= */
int ifnGenArchivosRev(char *pCodEntidad, char *pDesEntidad, char *vEmail)
{
char szArchivoRev[256]=""; /* reversas */
char modulo[]="ifnGenArchivosRev";
int  iHayRegistro;
int  i;
int  iError;
int  iRes=0;
char shEMail[51];

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 
       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    memset( shDesEntidad, '\0',sizeof(shDesEntidad));
    memset( shEMail     , '\0',sizeof(shEMail));

    strcpy(shEMail     , vEmail);                   
    strcpy(shCodEntidad, pCodEntidad);
    strcpy(shDesEntidad, pDesEntidad);

	/* Abrir archivo por empresa de cobranza para Reversas de Pago   */
    memset(szArchivoRev,0,sizeof(szArchivoRev)); /* Reversas de Pago */
  	sprintf(stStatusArch.NomArchRev,"%s%s","Reversas_diarias_", shCodEntidad);
    sprintf(szArchivoRev,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchRev,szFechayyyymmdd);
    
    if((ArchRev = fopen(szArchivoRev,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo de Reversas de Pagos \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchRev);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndARever;i++)   {
 
		 if (( strcmp(sthArcRever.sCodAgente[i],shCodEntidad)==0) && (sthArcRever.lNumRegistr[i] == 0)) {
                 if ( (fprintf( ArchRev, "CLIENTE|FACTURA|TRANSACCION| MONTO PAGO | FECHA CANCELACION | FECHA EFECTIVIDAD | ENTIDAD RECEPTORA | SEGMENTO | DIAS MORA | PRODUCTO | AGENTE | USUARIO \n") ) == -1 ){	
				    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				    return FALSE;            			
				 }		    	
       	 }
       	
		 if (( strcmp(sthArcRever.sCodAgente[i],shCodEntidad)==0) && (sthArcRever.lNumRegistr[i] > 0)) {

                iHayRegistro = 1;
                ifnTrazasLog(modulo, "sthArcRever.lCodCliente [i] [%ld]\n", LOG09, sthArcRever.lCodCliente[i]);
                ifnTrazasLog(modulo, "sthArcRever.lNumFactura [i] [%ld]\n", LOG09, sthArcRever.lNumFactura[i]);
                ifnTrazasLog(modulo, "sthArcRever.iTipValor   [i] [%d] \n", LOG09, sthArcRever.iTipValor[i]);
                ifnTrazasLog(modulo, "sthArcRever.sDesValor   [i] [%s] \n", LOG09, sthArcRever.sDesValor[i]);
                ifnTrazasLog(modulo, "sthArcRever.dMontoDcto  [i] [%f] \n", LOG09, sthArcRever.dMontoDcto[i]);
                ifnTrazasLog(modulo, "sthArcRever.sFecCancela [i] [%s] \n", LOG09, sthArcRever.sFecCancela[i]);
                ifnTrazasLog(modulo, "sthArcRever.sFecEfectiv [i] [%s] \n", LOG09, sthArcRever.sFecEfectiv[i]);
                ifnTrazasLog(modulo, "sthArcRever.sCodEntRece [i] [%s] \n", LOG09, sthArcRever.sCodEntRece[i]);
                ifnTrazasLog(modulo, "sthArcRever.sDesSegment [i] [%s] \n", LOG09, sthArcRever.sDesSegment[i]);
                ifnTrazasLog(modulo, "sthArcRever.iTotDiaMora [i] [%d] \n", LOG09, sthArcRever.iTotDiaMora[i]);
                ifnTrazasLog(modulo, "sthArcRever.sCodProducto[i] [%s] \n", LOG09, sthArcRever.sCodProducto[i]);
                ifnTrazasLog(modulo, "sthArcRever.sDesProducto[i] [%s] \n", LOG09, sthArcRever.sDesProducto[i]);
                ifnTrazasLog(modulo, "sthArcRever.sCodAgente  [i] [%s] \n", LOG09, sthArcRever.sCodAgente[i]);
                ifnTrazasLog(modulo, "sthArcRever.sCodUsuario [i] [%s] \n", LOG09, sthArcRever.sCodUsuario[i]);

                /*                        1  |  2   |  3  -  4  |    5     |  6  |  7  |  8  |  9  | 10  | 11  | 12  | 13  - 14  | 15*/
              	if( (fprintf( ArchRev, "%ld %s %ld %s %d %s %s %s %10.02f %s %s %s %s %s %s %s %s %s %d %s %s %s %s %s %s %s %s %s %s\n"
                                      ,sthArcRever.lCodCliente[i] 
                                      ,szPipe
                                      ,sthArcRever.lNumFactura[i]
                                      ,szPipe
                                      ,sthArcRever.iTipValor[i]
                                      ,szGuion
                                      ,sthArcRever.sDesValor[i]
                                      ,szPipe
                                      ,sthArcRever.dMontoDcto[i]
                                      ,szPipe 								 	 
                                      ,sthArcRever.sFecCancela[i]
                                      ,szPipe
                                      ,sthArcRever.sFecEfectiv[i]
                                      ,szPipe
                                      ,sthArcRever.sCodEntRece[i]
                                      ,szPipe
                                      ,sthArcRever.sDesSegment[i]		
                                      ,szPipe
                                      ,sthArcRever.iTotDiaMora[i]
                                      ,szPipe
                                      ,sthArcRever.sCodProducto[i]
                                      ,szGuion
                                      ,sthArcRever.sDesProducto[i]
                                      ,szPipe
                                      ,sthArcRever.sCodAgente[i]
                                      ,szGuion
                                      ,shDesEntidad
                                      ,szPipe
                                      ,sthArcRever.sCodUsuario[i]
                      		)   ) == -1 ){	
				    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
				    return FALSE;            			
				 }
				 				 
        } /* end if ( (sthArcNotCr.sCodAgente[i],shCodEntidad)==0) )  {*/
				             
    	 if ((iHayRegistro == 0) && (sthArcRever.lNumRegistr[i] == -1))  {
             if ( (fprintf( ArchRev, " ***********   NO EXISTEN PAGOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (4)",LOG01);
			    return FALSE;            			
			 }		    	
         }

	} /* end for lIndARever */			

    if ( fclose(ArchRev) != 0 )    {    
        fprintf (stderr,"Error al cerrar archivo de Reversas %s\n", shCodEntidad);
        fflush  (stderr);
    }
    
    iRes = ifnEnvioMail(szArchivoRev, shEMail, 3); 
    if( iRes < 0 ) return -1;

	return iError;	
	
} /* end ifnGenArchivosRev */

/* ============================================================================= */
/*  ifnEnvioMail: Funcion que envia por mail archivo generado                    */
/* ============================================================================= */
int ifnEnvioMail(char *vNomArchivo, char *vEMail, int vTipo)
{
char modulo[] ="ifnEnvioMail";
char szNArchivo[256]=""; 
char szComando [256]="";
char szSubject [256]="";
char szDirEmail[256]="";
int  iTipo = 0;

    iTipo = vTipo;
    strcpy(szDirEmail, vEMail);
    strcpy(szNArchivo, vNomArchivo);
    sprintf(szComando,"uuencode %s %s/$archivo>at.txt ",szNArchivo, szNArchivo);

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar crear archivo at.txt\n");
        fflush  (stderr);
        return -1;
    }

    sprintf(szComando,"cat at.txt>todo.txt");

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar cat\n");
        fflush  (stderr);
        return -1;
    }

    if (iTipo == 3) {       	
       sprintf(szSubject,"%s%s", "ARCHIVO_REVERSAS_",szFechayyyymmdd);
    } else {
       if (iTipo == 2) {       	
          sprintf(szSubject,"%s%s", "ARCHIVO_NOTAS_CREDITO_",szFechayyyymmdd);
       } else {
          if (iTipo == 1) {       	
              sprintf(szSubject,"%s%s", "ARCHIVO_PAGOS_DIARIOS_",szFechayyyymmdd);
          }
       }
    }
    	  
    sprintf(szComando,"mailx -s %s %s < todo.txt", szSubject, szDirEmail);

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al enviar mail\n");
        fflush  (stderr);
        return -1;
    }

    return 0;
    
}/* end ifnEnvioMail */

/* ============================================================================= */
/*  ifnGenArchivosNC: Funcion que genera los archivos con notas de credito       */
/* ============================================================================= */
int ifnGenArchivosNC(char *pCodEntidad, char *pDesEntidad, char *vEmail)
{
char szArchivoNot[256]=""; /* notas de creditos diarias */
char modulo[]="ifnGenArchivosNC";
int  iHayRegistro;
int  i;
int  iError;
char shEMail[51];
int  iRes=0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 
       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    memset( shDesEntidad, '\0',sizeof(shDesEntidad));
    memset( shEMail     , '\0',sizeof(shEMail));

    strcpy(shEMail     , vEmail);                                      
    strcpy(shCodEntidad, pCodEntidad);
    strcpy(shDesEntidad, pDesEntidad);

    /* Abrir archivo por empresa de cobranza para Notas de Credito   */
    memset(szArchivoNot,0,sizeof(szArchivoNot)); /* notas de creditos */
 	sprintf(stStatusArch.NomArchNot,"%s%s","Nota_credito_diarias_", shCodEntidad);
    sprintf(szArchivoNot,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchNot,szFechayyyymmdd);
   
    if((ArchNdC = fopen(szArchivoNot,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo de Notas de Creditos \n");
       fflush  (stderr);
       return -1;    
    }
   
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchNot);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
   
    iHayRegistro = 0;
    for (i=0;i<=lIndANotaC;i++)   {

	    if (( strcmp(sthArcNotCr.sCodAgente[i],shCodEntidad)==0) && (sthArcNotCr.lNumRegistr[i] == 0)) {
             if ( (fprintf( ArchPag, "CLIENTE | NUM_FACTURA | TRANSACCION | MONTO PAGO | FECHA EFECTIVIDAD | SEGMENTO | DIAS MORA | PRODUCTO | AGENTE \n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
			    return FALSE;            			
			 }		    	
      	}
      	
	    if (( strcmp(sthArcNotCr.sCodAgente[i],shCodEntidad)==0) && (sthArcNotCr.lNumRegistr[i] > 0)) {

               iHayRegistro = 1;
               ifnTrazasLog(modulo, "sthArcNotCr.lCodCliente [i] [%ld]\n", LOG09, sthArcNotCr.lCodCliente[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.lNumFactura [i] [%ld]\n", LOG09, sthArcNotCr.lNumFactura[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.iTipValor   [i] [%d] \n", LOG09, sthArcNotCr.iTipValor[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sDesValor   [i] [%s] \n", LOG09, sthArcNotCr.sDesValor[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.dMontoDcto  [i] [%f] \n", LOG09, sthArcNotCr.dMontoDcto[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sFecEfectiv [i] [%s] \n", LOG09, sthArcNotCr.sFecEfectiv[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sDesSegment [i] [%s] \n", LOG09, sthArcNotCr.sDesSegment[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.iTotDiaMora [i] [%d] \n", LOG09, sthArcNotCr.iTotDiaMora[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sCodProducto[i] [%s] \n", LOG09, sthArcNotCr.sCodProducto[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sDesProducto[i] [%s] \n", LOG09, sthArcNotCr.sDesProducto[i]);
               ifnTrazasLog(modulo, "sthArcNotCr.sCodAgente  [i] [%s] \n", LOG09, sthArcNotCr.sCodAgente[i]);

               /*                        1  |  2   |  3  -  4  |    5     |  7  |  9  | 10  | 11  - 12  | 13  - 14  */
               if( (fprintf( ArchNdC, "%ld %s %ld %s %d %s %s %s %10.02f %s %s %s %s %s %d %s %s %s %s %s %s %s %s \n"
                                     ,sthArcNotCr.lCodCliente[i] 
                                     ,szPipe
                                     ,sthArcNotCr.lNumFactura[i]
                                     ,szPipe
                                     ,sthArcNotCr.iTipValor[i]
                                     ,szGuion
                                     ,sthArcNotCr.sDesValor[i]
                                     ,szPipe
                                     ,sthArcNotCr.dMontoDcto[i]
                                     ,szPipe 								 	 
                                     ,sthArcNotCr.sFecEfectiv[i]
                                     ,szPipe
                                     ,sthArcNotCr.sDesSegment[i]		
                                     ,szPipe
                                     ,sthArcNotCr.iTotDiaMora[i]
                                     ,szPipe
                                     ,sthArcNotCr.sCodProducto[i]
                                     ,szGuion
                                     ,sthArcNotCr.sDesProducto[i]
                                     ,szPipe
                                     ,sthArcNotCr.sCodAgente[i]
                                     ,szGuion
                                     ,shDesEntidad
                     		)   ) == -1 ){	
			      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (3)",LOG01);
			      return FALSE;            			
			  }
			 				 			 
        } /* end if ( (sthArcNotCr.sCodAgente[i],shCodEntidad)==0) )  {*/
           
   		if ((iHayRegistro == 0) && (sthArcNotCr.lNumRegistr[i] == -1))  {
             if ( (fprintf( ArchNdC, " ***********   NO EXISTEN PAGOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (4)",LOG01);
			    return FALSE;            			
			 }		    	
       }

	} /* end for lIndANotaC */			

    if ( fclose(ArchNdC) != 0 )    {    
        fprintf (stderr,"Error al cerrar archivo de Notas de Credito %s\n", shCodEntidad);
        fflush  (stderr);
    }

    iRes = ifnEnvioMail(szArchivoNot, shEMail, 2); 
    if( iRes < 0 ) return -1;

	return iError;	
	
} /* end ifnGenArchivosNC */

/* ============================================================================= */
/*  ifnGenArchivosPagos: Funcion que genera los archivos con pagos diarios       */
/* ============================================================================= */
int ifnGenArchivosPagos(char *pCodEntidad, char *pDesEntidad, char *vEmail)
{
char szArchivoPag[256]=""; /* pagos diarios             */
char modulo[]="ifnGenArchivosPagos";
int  iHayRegistro;
int  i;
int  iError;
char shEMail[51];
int  iRes=0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 
       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    memset( shDesEntidad, '\0',sizeof(shDesEntidad));
    memset( shEMail     , '\0',sizeof(shEMail));

    strcpy(shEMail     , vEmail);                                                         
    strcpy(shCodEntidad, pCodEntidad);
    strcpy(shDesEntidad, pDesEntidad);
	
    /* Abrir archivo por empresa de cobranza para Pagos Diarios      */
    memset(szArchivoPag,0,sizeof(szArchivoPag)); /* pagos diarios    */
    sprintf(stStatusArch.NomArchPag,"%s%s","Pagos_diarios_", shCodEntidad);
    sprintf(szArchivoPag,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchPag,szFechayyyymmdd);
    
    if((ArchPag = fopen(szArchivoPag,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo de Pagos Diarios \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchPag);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndAPagos;i++)   {
 
		if (( strcmp(sthArcPagos.sCodAgente[i],shCodEntidad)==0) && (sthArcPagos.lNumRegistr[i] == 0)) {
           if ( (fprintf( ArchPag, "CLIENTE|FACTURA|TRANSACCION| MONTO PAGO | FECHA CANCELACION | FECHA EFECTIVIDAD | ENTIDAD RECEPTORA | SEGMENTO | DIAS MORA | PRODUCTO | AGENTE | USUARIO \n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
       	}
       	
		if (( strcmp(sthArcPagos.sCodAgente[i],shCodEntidad)==0) && (sthArcPagos.lNumRegistr[i] > 0)) {

            iHayRegistro = 1;
            ifnTrazasLog(modulo, "sthArcPagos.lCodCliente [i] [%ld]\n", LOG09, sthArcPagos.lCodCliente[i]);
            ifnTrazasLog(modulo, "sthArcPagos.lNumFactura [i] [%ld]\n", LOG09, sthArcPagos.lNumFactura[i]);
            ifnTrazasLog(modulo, "sthArcPagos.iTipValor   [i] [%d] \n", LOG09, sthArcPagos.iTipValor[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sDesValor   [i] [%s] \n", LOG09, sthArcPagos.sDesValor[i]);
            ifnTrazasLog(modulo, "sthArcPagos.dMontoDcto  [i] [%f] \n", LOG09, sthArcPagos.dMontoDcto[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sFecCancela [i] [%s] \n", LOG09, sthArcPagos.sFecCancela[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sFecEfectiv [i] [%s] \n", LOG09, sthArcPagos.sFecEfectiv[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sCodEntRece [i] [%s] \n", LOG09, sthArcPagos.sCodEntRece[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sDesSegment [i] [%s] \n", LOG09, sthArcPagos.sDesSegment[i]);
            ifnTrazasLog(modulo, "sthArcPagos.iTotDiaMora [i] [%d] \n", LOG09, sthArcPagos.iTotDiaMora[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sCodProducto[i] [%s] \n", LOG09, sthArcPagos.sCodProducto[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sDesProducto[i] [%s] \n", LOG09, sthArcPagos.sDesProducto[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sCodAgente  [i] [%s] \n", LOG09, sthArcPagos.sCodAgente[i]);
            ifnTrazasLog(modulo, "sthArcPagos.sCodUsuario [i] [%s] \n", LOG09, sthArcPagos.sCodUsuario[i]);
            /*                        1  |  2   |  3  |  4  |    5     |  6  |  7  |  8  |  9  | 10  | 11  | 12  | 13  | 14  | 15*/
           	if( (fprintf( ArchPag, "%ld %s %ld %s %d %s %s %s %10.02f %s %s %s %s %s %s %s %s %s %d %s %s %s %s %s %s %s %s %s %s\n"
                                 ,sthArcPagos.lCodCliente[i] 
                                 ,szPipe
                                 ,sthArcPagos.lNumFactura[i]
                                 ,szPipe
                                 ,sthArcPagos.iTipValor[i]
                                 ,szGuion
                                 ,sthArcPagos.sDesValor[i]
                                 ,szPipe
                                 ,sthArcPagos.dMontoDcto[i]
                                 ,szPipe 								 	 
                                 ,sthArcPagos.sFecCancela[i]
                                 ,szPipe
                                 ,sthArcPagos.sFecEfectiv[i]
                                 ,szPipe
                                 ,sthArcPagos.sCodEntRece[i]
                                 ,szPipe
                                 ,sthArcPagos.sDesSegment[i]		
                                 ,szPipe
                                 ,sthArcPagos.iTotDiaMora[i]
                                 ,szPipe
                                 ,sthArcPagos.sCodProducto[i]
                                 ,szGuion
                                 ,sthArcPagos.sDesProducto[i]
                                 ,szPipe
                                 ,sthArcPagos.sCodAgente[i]
                                 ,szGuion
                                 ,shDesEntidad
                                 ,szPipe
                                 ,sthArcPagos.sCodUsuario[i]
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (sthArcPagos.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthArcPagos.lNumRegistr[i] == -1))  {
          if ( (fprintf( ArchPag, " ***********   NO EXISTEN PAGOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndAPagos */			

    if ( fclose(ArchPag) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo de Pagos Diarios %s\n", shCodEntidad);
       fflush  (stderr);
    }

    iRes = ifnEnvioMail(szArchivoPag, shEMail, 1); 
    if( iRes < 0 ) return -1;

	return iError;	
	
} /* end ifnGenArchivosPagos */

/* ============================================================================= */
/*  ifnBuscaClientes() : Funcion que busca los clientes con pagos diarios        */
/* ============================================================================= */
int ifnBuscaClientes(char *pCodEntidad, char *pDesEntidad)
{	
   char        modulo[]="ifnBuscaClientes";
   int         iSalir = FALSE;                                                            
   int         iError = 0;                
   int         iRes   = 0;                
                                        
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 
       
    long   lzhCod_Cliente     ;                                       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    memset( shDesEntidad, '\0',sizeof(shDesEntidad));
                   
    strcpy(shCodEntidad, pCodEntidad);
    strcpy(shDesEntidad, pDesEntidad);
                              
    /************************************************************************/
    /* Obtiene el Universo de clientes con pagos diarios                    */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_ClientesPagos CURSOR for        
    SELECT DISTINCT B.COD_CLIENTE  
      FROM CO_PAGOS B
     WHERE COD_TIPDOCUM IN (9,25,8,83,84)
       AND B.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhAnteayer,:szhDDMMYYYY1) AND TO_DATE(:szhHoy,:szhDDMMYYYY1)
       AND EXISTS (SELECT COD_CLIENTE 
                     FROM CO_MOROSOS 
                    WHERE COD_CLIENTE = B.COD_CLIENTE
                      AND COD_AGENTE  = :shCodEntidad); */ 

                
    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_ClientesPagos - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_ClientesPagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0008;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )234;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhAnteayer;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYY1;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhHoy;
    sqlstm.sqhstl[2] = (unsigned long )11;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYYYY1;
    sqlstm.sqhstl[3] = (unsigned long )11;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)shCodEntidad;
    sqlstm.sqhstl[4] = (unsigned long )6;
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



    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_ClientesPagos - %s", LOG00,SQLERRM );
        return -1;
    }

    iSalir=FALSE;
    while(!iSalir)
    {    	
        /* EXEC SQL
        FETCH Cur_ClientesPagos
        INTO :lzhCod_Cliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )269;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lzhCod_Cliente;
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



        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
            ifnTrazasLog( modulo, "\tFETCH Cur_ClientesPagos - %s", LOG00,SQLERRM );
            iError = -1;
            break;
        }

        if( SQLCODE == SQLNOTFOUND ) {
            break;
        }

        iRes = ifnLlenaEstructura(shCodEntidad, shDesEntidad, lzhCod_Cliente);
        if( iRes < 0 ) break;
        
    } /* fin while cursor Cur_PagosDiarios */

    /* EXEC SQL
    CLOSE Cur_ClientesPagos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )288;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tCLOSE Cur_ClientesPagos - %s", LOG00, SQLERRM );
        iError = -1;
    }
	
	return iError;	
	
} /* end ifnBuscaClientes */

/* ============================================================================= */
/*  ifnLlenaEstructura() : Funcion que rescata los datos necesarios de los       */
/*  los clientes para generar los reportes de pagos diarios                      */
/* ============================================================================= */
int ifnLlenaEstructura(char *pCodEntidad, char *pDesEntidad, long pCodCliente)
{	
   char        modulo[]="ifnLlenaEstructura";
   int         iError = 0;                
   td_EstCobex stEst;                       
   long        lContador ;                      
   int         iSalir = FALSE;                                                            
   int         iRes   = 0;                                       
                                                                                  
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

	char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 
       
    long   lzCod_Cliente      ;                                       
    long   lzhCod_Cliente     ;                                       
    int    izhCod_TipdPag     ;                                       
    long   lzhNum_SecuPag     ;                                       
    char   szhFec_EfecPag [11]; /* EXEC SQL VAR szhFec_EfecPag IS STRING(11); */ 

    char   szhNom_Usuario [31]; /* EXEC SQL VAR szhNom_Usuario IS STRING(31); */ 

    long   lzhNum_SecuDoc     ;                                       
    int    izhCod_TipdDoc     ;                                       
    double dzhMonto_Doc       ; 
    long   lzhNumCompago      ;      
    char   szhFec_CancDoc [11]; /* EXEC SQL VAR szhFec_CancDoc  IS STRING(11); */ 
    
    char   szhFec_CancDoc2 [9]; /* EXEC SQL VAR szhFec_CancDoc2 IS STRING(9) ; */ 
    
    double dhzNum_Cuota       ;
    int    ihzSec_Cuota       ;    
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    memset( shDesEntidad, '\0',sizeof(shDesEntidad));
                   
    lzCod_Cliente = pCodCliente;
    strcpy(shCodEntidad, pCodEntidad);
    strcpy(shDesEntidad, pDesEntidad);
    lContador = 1; 

    ifnTrazasLog( modulo, " ---------------------------------------------------------------------------------------------", LOG09);

    stEst.lCodCliente = lzCod_Cliente;  
    strcpy(stEst.sCodAgente  , shCodEntidad);
    strcpy(stEst.sDesAgente  , shDesEntidad);
    
    iRes = ifnBBuscaSegmento(&stEst);
    if( iRes < 0 ) return -1;
     
    iRes = ifnBBuscaProducto(&stEst); 
    if( iRes < 0 ) return -1;
                       
    /************************************************************************/
    /* Obtiene el Universo de pagos de clientes morosos                     */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_PagosDiarios CURSOR for        
    SELECT B.COD_CLIENTE  , B.COD_TIPDOCUM, B.NUM_SECUENCI , TO_CHAR(B.FEC_EFECTIVIDAD, :szhDDMMYYYY3),
           B.NOM_USUARORA , A.NUM_SECUREL , A.COD_TIPDOCREL, TO_CHAR(A.FEC_CANCELACION, :szhDDMMYYYY3), 
           TO_CHAR(A.FEC_CANCELACION, :szhDDMMYYYY2), 
           NVL(B.NUM_COMPAGO,-1), A.SEC_CUOTA, A.NUM_CUOTA , SUM(A.IMP_CONCEPTO) 
      FROM CO_PAGOS B, CO_PAGOSCONC A 
     WHERE B.NUM_SECUENCI = A.NUM_SECUENCI 
       AND B.COD_TIPDOCUM = A.COD_TIPDOCUM
       AND B.COD_TIPDOCUM IN (9,25,8,83,84)
       AND B.COD_CLIENTE  = :lzCod_Cliente
       AND B.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhAnteayer,:szhDDMMYYYY1) AND TO_DATE(:szhHoy,:szhDDMMYYYY1)
       AND EXISTS (SELECT COD_CLIENTE 
                     FROM CO_MOROSOS 
                    WHERE COD_CLIENTE = :lzCod_Cliente
                      AND COD_AGENTE  = :shCodEntidad)
     GROUP BY B.COD_CLIENTE  , B.COD_TIPDOCUM, B.NUM_SECUENCI , B.FEC_EFECTIVIDAD, 
              B.NOM_USUARORA , A.NUM_SECUREL , A.COD_TIPDOCREL, TO_CHAR(A.FEC_CANCELACION, :szhDDMMYYYY3), 
              TO_CHAR(A.FEC_CANCELACION, :szhDDMMYYYY2), 
              B.NUM_COMPAGO  , A.SEC_CUOTA, A.NUM_CUOTA; */ 
 
                
    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_PagosDiarios - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_PagosDiarios; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 12;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )303;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhDDMMYYYY3;
    sqlstm.sqhstl[0] = (unsigned long )11;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYY3;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhDDMMYYYY2;
    sqlstm.sqhstl[2] = (unsigned long )9;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lzCod_Cliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhAnteayer;
    sqlstm.sqhstl[4] = (unsigned long )11;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhDDMMYYYY1;
    sqlstm.sqhstl[5] = (unsigned long )11;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhHoy;
    sqlstm.sqhstl[6] = (unsigned long )11;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhDDMMYYYY1;
    sqlstm.sqhstl[7] = (unsigned long )11;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lzCod_Cliente;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)shCodEntidad;
    sqlstm.sqhstl[9] = (unsigned long )6;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhDDMMYYYY3;
    sqlstm.sqhstl[10] = (unsigned long )11;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhDDMMYYYY2;
    sqlstm.sqhstl[11] = (unsigned long )9;
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



    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_PagosDiarios - %s", LOG00,SQLERRM );
        return -1;
    }

    iSalir=FALSE;
    while(!iSalir)
    {    	
        /* EXEC SQL
        FETCH Cur_PagosDiarios
        INTO :lzhCod_Cliente ,
             :izhCod_TipdPag ,         
             :lzhNum_SecuPag ,
             :szhFec_EfecPag ,
             :szhNom_Usuario ,      
             :lzhNum_SecuDoc ,
             :izhCod_TipdDoc ,  
             :szhFec_CancDoc , 
             :szhFec_CancDoc2,                  
             :lzhNumCompago  , 
             :dzhMonto_Doc   , 
             :dhzNum_Cuota   , 
             :ihzSec_Cuota   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )366;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lzhCod_Cliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&izhCod_TipdPag;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lzhNum_SecuPag;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFec_EfecPag;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhNom_Usuario;
        sqlstm.sqhstl[4] = (unsigned long )31;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lzhNum_SecuDoc;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)&izhCod_TipdDoc;
        sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFec_CancDoc;
        sqlstm.sqhstl[7] = (unsigned long )11;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhFec_CancDoc2;
        sqlstm.sqhstl[8] = (unsigned long )9;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lzhNumCompago;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&dzhMonto_Doc;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&dhzNum_Cuota;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&ihzSec_Cuota;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
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



        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
            ifnTrazasLog( modulo, "\tFETCH Cur_PagosDiarios - %s", LOG00,SQLERRM );
            iError = -1;
            break;
        }

        if( SQLCODE == SQLNOTFOUND ) {
            break;
        }

        stEst.dMontoDcto  = dzhMonto_Doc  ; 
        stEst.iCodTipdPag = izhCod_TipdPag; 
        stEst.lNumSecuPag = lzhNum_SecuPag; 
        stEst.lNumSecDcto = lzhNum_SecuDoc; 
        stEst.iCodTipDcto = izhCod_TipdDoc; 
        stEst.lNumCompago = lzhNumCompago ;
        stEst.lNumRegistr = lContador     ; 
        stEst.dNumCuota   = dhzNum_Cuota  ;
        stEst.iSecCuota   = ihzSec_Cuota  ;    


        strcpy(stEst.sFecCancela , szhFec_CancDoc);
        strcpy(stEst.sFecCancela2, szhFec_CancDoc2);        
        strcpy(stEst.sFecEfectiv , szhFec_EfecPag);
        strcpy(stEst.sCodUsuario , szhNom_Usuario);

        if ((izhCod_TipdPag == 8) || (izhCod_TipdPag == 83)) {
            /* funcion estructura de pagos */
	        iRes = ifnCargaEstructura(&sthArcPagos, lIndAPagos, &stEst, lContador); 
	        if( iRes < 0 ) break;
	        lIndAPagos = lIndAPagos + 1;
        }

        if ((izhCod_TipdPag == 9) || (izhCod_TipdPag == 25)) {
            /* funcion estructura notas de creditos */
	        iRes = ifnCargaEstructura(&sthArcNotCr, lIndANotaC, &stEst, lContador); 
	        if( iRes < 0 ) break;
	        lIndANotaC = lIndANotaC + 1;
   	            
        }

        if (izhCod_TipdPag == 84) {
            /* funcion estructura de reversas */
	        iRes = ifnCargaEstructura(&sthArcRever, lIndARever, &stEst, lContador); 
	        if( iRes < 0 ) break;
	        lIndARever = lIndARever + 1;
   	            
        }     

        lContador = lContador + 1;
        
    } /* fin while cursor Cur_PagosDiarios */

    /* EXEC SQL
    CLOSE Cur_PagosDiarios; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )433;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tCLOSE Cur_PagosDiarios - %s", LOG00, SQLERRM );
        iError = -1;
    }
	
	return iError;
} /* end ifnLlenaEstructura */

/* ============================================================================= */
/*  ifnCargaEstructura() : Funcion que carga la estructura de datos              */
/* ============================================================================= */
int ifnCargaEstructura(td_ArchiCob *stAr, long lIndAC, td_EstCobex *stAux, long pContador)
{
char modulo[]="ifnCargaEstructura";
int  iRes           = 0;
int  izhCod_TipdPag;
      
   izhCod_TipdPag = stAux->iCodTipdPag;
   
   iRes = ifnDiasMoraFolio(stAux); 
   if( iRes < 0 ) return -1;
            
   if( izhCod_TipdPag == 8) {
      
      /* Buscando Tipo de Valor y Entidad */
      iRes = ifnBBuscaTipValorEntidad_MOVCAJA(stAux); 
      if( iRes < 0 ) return -1;
      
      if( iRes == 1 ) {
      	   iRes = 0;
          iRes = ifnBBuscaTipValorEntidadOnLine(stAux); 
          if( iRes < 0 ) return -1;
          
          if( iRes == 1 ) {       
      	       iRes = 0;
              iRes = ifnBBuscaTipValorEntidadRecExt(stAux); 
              if( iRes < 0 ) return -1;
      
              if( iRes == 1 ) {              
                  iRes = ifnBBuscaTipValorEntidadPAC(stAux); 
                  if( iRes < 0 ) return -1;               
              }
         }           
      }
      
   } /* end if( stAux->iCodTipdPag = 8) */


   if(( izhCod_TipdPag == 83) || ( izhCod_TipdPag == 9) || (izhCod_TipdPag == 25) || (izhCod_TipdPag == 84)) {
   	
      iRes = ifnBBuscaTipValorEntidadREGNCI(stAux);
      
   } /* end if( stAux->iCodTipdPag = 83) */
                            
                                                                                                                                                                                         
   stAr->lCodCliente [lIndAC] = stAux->lCodCliente;          
   stAr->lNumFactura [lIndAC] = stAux->lNumFolio; 
   stAr->iTipValor   [lIndAC] = stAux->iTipValor;  
   stAr->dMontoDcto  [lIndAC] = stAux->dMontoDcto;
   stAr->iCodSegment [lIndAC] = stAux->iCodSegmento;
   stAr->iTotDiaMora [lIndAC] = stAux->iTotDiaMora;                                                                                                     
   stAr->lNumRegistr [lIndAC] = pContador;

   strcpy(stAr->sFecCancela [lIndAC], stAux->sFecCancela );
   strcpy(stAr->sFecEfectiv [lIndAC], stAux->sFecEfectiv );
   strcpy(stAr->sCodEntRece [lIndAC], stAux->sEmpRecauda );
   strcpy(stAr->sCodAgente  [lIndAC], stAux->sCodAgente  );
   strcpy(stAr->sDesAgente  [lIndAC], stAux->sDesAgente  );
   strcpy(stAr->sCodUsuario [lIndAC], stAux->sCodUsuario );
   strcpy(stAr->sDesValor   [lIndAC], stAux->sDesValor   );
   strcpy(stAr->sCodProducto[lIndAC], stAux->sCodProducto);
   strcpy(stAr->sDesProducto[lIndAC], stAux->sDesProducto);
   strcpy(stAr->sDesSegment [lIndAC], stAux->sDesSegmento);
            
   return 0;
	
} /* end ifnCargaEstructura */

/* ============================================================================= */
/*  ifnCalculoDiasMora() : Funcion que calcula los dias de mora de un documento  */
/* ============================================================================= */
int ifnDiasMoraFolio(td_EstCobex *st)
{
char modulo[]="ifnDiasMoraFolio";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhNum_Secuenci   ;
  int    ihCod_TipDocum   ;    
  int    ihDiasMora       ;           
  long   lhNumFolio       ;                 
  char   shFec_CancDoc [9]; /* EXEC SQL VAR shFec_CancDoc IS STRING(9); */ 

  double dNum_Cuota       ; 
  int    iSec_Cuota       ; 
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   lhNum_Secuenci = st->lNumSecDcto;
   ihCod_TipDocum = st->iCodTipDcto;                                                   
   strcpy(shFec_CancDoc, st->sFecCancela2);
   
   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t lhNum_Secuenci- %ld", LOG09, lhNum_Secuenci );
   ifnTrazasLog( modulo, "\t ihCod_TipDocum- %ld", LOG09, ihCod_TipDocum );
   ifnTrazasLog( modulo, "\t shFec_CancDoc - %s",  LOG09, shFec_CancDoc  );
   ifnTrazasLog( modulo, "\t dNum_Cuota    - %ld", LOG09, dNum_Cuota     );
   ifnTrazasLog( modulo, "\t iSec_Cuota    - %d",  LOG09, iSec_Cuota  );
                                                                      
   /* EXEC SQL
    SELECT TRUNC(TO_DATE(:shFec_CancDoc, :szhDDMMYYYY2) - FEC_VENCIMIE), NUM_FOLIO
      INTO :ihDiasMora, :lhNumFolio
      FROM CO_CANCELADOS
     WHERE NUM_SECUENCI = :lhNum_Secuenci
       AND COD_TIPDOCUM = :ihCod_TipDocum
       AND NUM_CUOTA    = :dNum_Cuota
       AND SEC_CUOTA    = :iSec_Cuota; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TRUNC((TO_DATE(:b0,:b1)-FEC_VENCIMIE)) ,NUM_FOLIO i\
nto :b2,:b3  from CO_CANCELADOS where (((NUM_SECUENCI=:b4 and COD_TIPDOCUM=:b5\
) and NUM_CUOTA=:b6) and SEC_CUOTA=:b7)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )448;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shFec_CancDoc;
   sqlstm.sqhstl[0] = (unsigned long )9;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYY2;
   sqlstm.sqhstl[1] = (unsigned long )9;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihDiasMora;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolio;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Secuenci;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_TipDocum;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&dNum_Cuota;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&iSec_Cuota;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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


       
          
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	  ifnTrazasLog( modulo, "\t En funcion ifnDiasMoraFolio (1) - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {

       /* EXEC SQL
        SELECT TRUNC(TO_DATE(:shFec_CancDoc, :szhDDMMYYYY2) - FEC_VENCIMIE), NUM_FOLIO
          INTO :ihDiasMora, :lhNumFolio
          FROM CO_CARTERA
         WHERE NUM_SECUENCI = :lhNum_Secuenci
           AND COD_TIPDOCUM = :ihCod_TipDocum
           AND NUM_CUOTA    = :dNum_Cuota
           AND SEC_CUOTA    = :iSec_Cuota; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 13;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select TRUNC((TO_DATE(:b0,:b1)-FEC_VENCIMIE)) ,NUM_FOL\
IO into :b2,:b3  from CO_CARTERA where (((NUM_SECUENCI=:b4 and COD_TIPDOCUM=:b\
5) and NUM_CUOTA=:b6) and SEC_CUOTA=:b7)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )495;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)shFec_CancDoc;
       sqlstm.sqhstl[0] = (unsigned long )9;
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)szhDDMMYYYY2;
       sqlstm.sqhstl[1] = (unsigned long )9;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)&ihDiasMora;
       sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolio;
       sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Secuenci;
       sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_TipDocum;
       sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[5] = (         int  )0;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)&dNum_Cuota;
       sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
       sqlstm.sqhsts[6] = (         int  )0;
       sqlstm.sqindv[6] = (         short *)0;
       sqlstm.sqinds[6] = (         int  )0;
       sqlstm.sqharm[6] = (unsigned long )0;
       sqlstm.sqadto[6] = (unsigned short )0;
       sqlstm.sqtdso[6] = (unsigned short )0;
       sqlstm.sqhstv[7] = (unsigned char  *)&iSec_Cuota;
       sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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


                         
       if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	      ifnTrazasLog( modulo, "\t En funcion ifnDiasMoraFolio (2) - %s", LOG00, SQLERRM );
	      return -1;				
       }

       if( SQLCODE == SQLNOTFOUND ) {
       	 ihDiasMora = 0; 
       	 lhNumFolio = 0;
       }

   }
      
   ifnTrazasLog( modulo, "\t ihDiasMora    - %ld", LOG06, ihDiasMora );
   ifnTrazasLog( modulo, "\t lhNumFolio    - %ld", LOG06, lhNumFolio );
    	   
   st->iTotDiaMora = ihDiasMora; 
   st->lNumFolio   = lhNumFolio;
   
   return 0;
	
} /* end ifnDiasMoraFolio */

/* ============================================================================= */
/*  ifnBBuscaSegmento() : Funcion que busca segmento del cliente                 */
/* ============================================================================= */
int ifnBBuscaSegmento(td_EstCobex *st)
{
char modulo[]="ifnBBuscaSegmento";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente      ;
  int    ihCod_Segmento     ;    
  char   shDes_Segmento[101]; /* EXEC SQL VAR shDes_Segmento IS STRING(101); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   lhCod_Cliente = st->lCodCliente;

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );
                                                                
   /* EXEC SQL
   SELECT A.COD_SEGMENTO, B.DES_SEGMENTO
        INTO :ihCod_Segmento, :shDes_Segmento
     FROM GE_CLIENTES A, GE_SEGMENTACION_CLIENTES_TD B  
    WHERE A.COD_CLIENTE = :lhCod_Cliente
      AND A.COD_SEGMENTO= B.COD_SEGMENTO; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.COD_SEGMENTO ,B.DES_SEGMENTO into :b0,:b1  from G\
E_CLIENTES A ,GE_SEGMENTACION_CLIENTES_TD B where (A.COD_CLIENTE=:b2 and A.COD\
_SEGMENTO=B.COD_SEGMENTO)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )542;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCod_Segmento;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_Segmento;
   sqlstm.sqhstl[1] = (unsigned long )101;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Cliente;
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



   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	  ifnTrazasLog( modulo, "\t En funcion ifnBBuscaSegmento - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {
       ihCod_Segmento = 0;
       strcpy(shDes_Segmento, SIN_INFORMACION);
   }
    
   ifnTrazasLog( modulo, "\t ihCod_Segmento - %d", LOG09, ihCod_Segmento );
   ifnTrazasLog( modulo, "\t shDes_Segmento - %s", LOG09, shDes_Segmento );
    	   
   st->iCodSegmento = ihCod_Segmento; 
   strcpy(st->sDesSegmento, shDes_Segmento);
   
   return 0;	
   
} /* end ifnBBuscaSegmento */

/* ============================================================================= */
/*  ifnBBuscaTipValorEntidad_MOVCAJA: Funcion que busca el tipo de valor y       */
/*  entidad receptora del pago. Si el pago se encuentra en las tablas de         */
/*  movimientos de caja                                                          */
/* ============================================================================= */
int ifnBBuscaTipValorEntidad_MOVCAJA(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaTipValorEntidad_MOVCAJA";
int  iExiste = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente     ;
  long   lhNum_Secuenc     ;
  int    ihTip_Valor       ;
  int    ihCod_TipDocu     ;      
  char   shDes_TipValor[41]; /* EXEC SQL VAR shDes_TipValor IS STRING(41); */ 

  char   shEmp_Recauda [41]; /* EXEC SQL VAR shEmp_Recauda  IS STRING(41); */ 

  char   shCod_Oficina  [3]; /* EXEC SQL VAR shCod_Oficina  IS STRING(3); */ 

  char   shCod_Caja     [5]; /* EXEC SQL VAR shCod_Caja     IS STRING(5); */ 
   
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   lhCod_Cliente = st->lCodCliente;
   ihCod_TipDocu = st->iCodTipdPag;
   lhNum_Secuenc = st->lNumSecuPag;

   memset( shDes_TipValor, '\0',sizeof(shDes_TipValor));
   memset( shEmp_Recauda , '\0',sizeof(shEmp_Recauda));
   memset( shCod_Oficina , '\0',sizeof(shCod_Oficina));
   memset( shCod_Caja    , '\0',sizeof(shCod_Caja));

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );
   ifnTrazasLog( modulo, "\t iCodTipdPag   - %ld", LOG09, ihCod_TipDocu );
   ifnTrazasLog( modulo, "\t lNumSecuPag   - %ld", LOG09, lhNum_Secuenc );
   
   /* EXEC SQL	
   SELECT A.TIP_VALOR , B.DES_TIPVALOR,  A.COD_OFICINA, TO_CHAR(A.COD_CAJA)
     INTO :ihTip_Valor, :shDes_TipValor, :shCod_Oficina, :shCod_Caja
     FROM CO_HISTMOVCAJA A, CO_TIPVALOR B 
    WHERE A.NUM_SECUENCI = :lhNum_Secuenc
      AND A.TIP_DOCUMENT = :ihCod_TipDocu
      AND A.COD_CLIENTE  = :lhCod_Cliente
      AND A.TIP_VALOR    = B.TIP_VALOR
      AND ROWNUM < 2; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.TIP_VALOR ,B.DES_TIPVALOR ,A.COD_OFICINA ,TO_CHAR\
(A.COD_CAJA) into :b0,:b1,:b2,:b3  from CO_HISTMOVCAJA A ,CO_TIPVALOR B where \
((((A.NUM_SECUENCI=:b4 and A.TIP_DOCUMENT=:b5) and A.COD_CLIENTE=:b6) and A.TI\
P_VALOR=B.TIP_VALOR) and ROWNUM<2)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )569;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihTip_Valor;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_TipValor;
   sqlstm.sqhstl[1] = (unsigned long )41;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)shCod_Oficina;
   sqlstm.sqhstl[2] = (unsigned long )3;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)shCod_Caja;
   sqlstm.sqhstl[3] = (unsigned long )5;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Secuenc;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_TipDocu;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_Cliente;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
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
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor(1) - %s", LOG00,SQLERRM );
       return -1;
   }

   if( SQLCODE == SQLNOTFOUND ) {

         /* EXEC SQL	
         SELECT A.TIP_VALOR , B.DES_TIPVALOR,  A.COD_OFICINA, TO_CHAR(A.COD_CAJA)
           INTO :ihTip_Valor, :shDes_TipValor, :shCod_Oficina, :shCod_Caja
           FROM CO_MOVIMIENTOSCAJA A, CO_TIPVALOR B 
          WHERE A.NUM_SECUENCI = :lhNum_Secuenc
            AND A.TIP_DOCUMENT = :ihCod_TipDocu
            AND A.COD_CLIENTE  = :lhCod_Cliente
            AND A.TIP_VALOR    = B.TIP_VALOR
            AND ROWNUM < 2; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 13;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "select A.TIP_VALOR ,B.DES_TIPVALOR ,A.COD_OFICINA ,T\
O_CHAR(A.COD_CAJA) into :b0,:b1,:b2,:b3  from CO_MOVIMIENTOSCAJA A ,CO_TIPVALO\
R B where ((((A.NUM_SECUENCI=:b4 and A.TIP_DOCUMENT=:b5) and A.COD_CLIENTE=:b6\
) and A.TIP_VALOR=B.TIP_VALOR) and ROWNUM<2)";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )612;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&ihTip_Valor;
         sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)shDes_TipValor;
         sqlstm.sqhstl[1] = (unsigned long )41;
         sqlstm.sqhsts[1] = (         int  )0;
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)shCod_Oficina;
         sqlstm.sqhstl[2] = (unsigned long )3;
         sqlstm.sqhsts[2] = (         int  )0;
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)shCod_Caja;
         sqlstm.sqhstl[3] = (unsigned long )5;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Secuenc;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)&ihCod_TipDocu;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)&lhCod_Cliente;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
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
             ifnTrazasLog( modulo, "\t Buscando el Tip_Valor (2) - %s", LOG00,SQLERRM );
             return -1;
         }

         if( SQLCODE == SQLNOTFOUND ) {
              iExiste = 1;
         }      

   }

   if( iExiste == 0 ) {
   	   sprintf(shEmp_Recauda,"%s-%s\0",shCod_Oficina,shCod_Caja);   	
       ifnTrazasLog( modulo, "\t ihTip_Valor    - [%d]", LOG09, ihTip_Valor );
       ifnTrazasLog( modulo, "\t shDes_TipValor - [%s]", LOG09, shDes_TipValor );
       ifnTrazasLog( modulo, "\t sEmpRecauda    - [%s]", LOG09, shEmp_Recauda );

       st->iTipValor = ihTip_Valor;
       strcpy( st->sDesValor  , shDes_TipValor);
       strcpy( st->sEmpRecauda, shEmp_Recauda );   	   
   }
     
   return iExiste; 
   
} /* end ifnBBuscaTipValorEntidad_MOVCAJA */

/* ============================================================================= */
/*  ifnBBuscaTipValorEntidadOnLine() : Funcion que busca el tipo de valor y      */
/*  entidad receptora del pago, si el pago es On Line                            */
/* ============================================================================= */
int ifnBBuscaTipValorEntidadOnLine(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaTipValorEntidadOnLine";
int  iExiste = 1;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente     ;
  long   lhNum_Compago     ;
  int    ihTip_Valor       ;
  char   shDes_TipValor[41]; /* EXEC SQL VAR shDes_TipValor IS STRING(41); */ 

  char   shEmp_Recauda [41]; /* EXEC SQL VAR shEmp_Recauda  IS STRING(41); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   lhCod_Cliente = st->lCodCliente;
   lhNum_Compago = st->lNumCompago;

   memset( shDes_TipValor, '\0',sizeof(shDes_TipValor));
   memset( shEmp_Recauda , '\0',sizeof(shEmp_Recauda));

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );
   ifnTrazasLog( modulo, "\t lhNum_Compago - %ld", LOG09, lhNum_Compago );
   
   /* EXEC SQL	
   SELECT A.TIP_VALOR, B.DES_TIPVALOR, A.EMP_RECAUDADORA
     INTO :ihTip_Valor, :shDes_TipValor, :shEmp_Recauda
     FROM CO_HINTERFAZ_PAGOS A, CO_TIPVALOR B 
    WHERE A.COD_CLIENTE = :lhCod_Cliente
      AND A.NUM_COMPAGO = :lhNum_Compago
      AND A.TIP_VALOR   = B.TIP_VALOR; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.TIP_VALOR ,B.DES_TIPVALOR ,A.EMP_RECAUDADORA into\
 :b0,:b1,:b2  from CO_HINTERFAZ_PAGOS A ,CO_TIPVALOR B where ((A.COD_CLIENTE=:\
b3 and A.NUM_COMPAGO=:b4) and A.TIP_VALOR=B.TIP_VALOR)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )655;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihTip_Valor;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_TipValor;
   sqlstm.sqhstl[1] = (unsigned long )41;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)shEmp_Recauda;
   sqlstm.sqhstl[2] = (unsigned long )41;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_Cliente;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Compago;
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


   
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor (3) - %s", LOG00,SQLERRM );
       return -1;
   }

   if( SQLCODE == SQLNOTFOUND ) {
   	 iExiste = 1;
   }
   
   if( iExiste == 0 ) {
       ifnTrazasLog( modulo, "\t ihTip_Valor    - [%d]", LOG09, ihTip_Valor );
       ifnTrazasLog( modulo, "\t shDes_TipValor - [%s]", LOG09, shDes_TipValor );
       ifnTrazasLog( modulo, "\t sEmpRecauda    - [%s]", LOG09, shEmp_Recauda );

       st->iTipValor = ihTip_Valor;
       strcpy( st->sDesValor  , shDes_TipValor);
       strcpy( st->sEmpRecauda, shEmp_Recauda );   	   
   }
  
   return iExiste; 
   
} /* end ifnBBuscaTipValorEntidadOnLine */


/* ============================================================================= */
/*  ifnBBuscaTipValorEntidadRecExt : Funcion que busca el tipo de valor y        */
/*  entidad receptora del pago, si el pago es realizado por recaudacion externa  */
/* ============================================================================= */
int ifnBBuscaTipValorEntidadRecExt(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaTipValorEntidadRecExt";
int  iExiste = 1;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente     ;
  long   lhNum_Compago     ;
  int    ihTip_Valor       ;
  char   shDes_TipValor[41]; /* EXEC SQL VAR shDes_TipValor IS STRING(41); */ 

  char   shEmp_Recauda [41]; /* EXEC SQL VAR shEmp_Recauda  IS STRING(41); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   lhCod_Cliente = st->lCodCliente;
   lhNum_Compago = st->lNumCompago;

   memset( shDes_TipValor, '\0',sizeof(shDes_TipValor));
   memset( shEmp_Recauda , '\0',sizeof(shEmp_Recauda));

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );
   ifnTrazasLog( modulo, "\t lhNum_Compago - %ld", LOG09, lhNum_Compago );
   
   /* EXEC SQL	
   SELECT A.TIP_VALOR, B.DES_TIPVALOR, A.EMP_RECAUDADORA
     INTO :ihTip_Valor, :shDes_TipValor, :shEmp_Recauda
     FROM CO_HINTERFAZ_EXTERNA A, CO_TIPVALOR B 
    WHERE A.COD_CLIENTE = :lhCod_Cliente
      AND A.NUM_COMPAGO = :lhNum_Compago
      AND A.TIP_VALOR   = B.TIP_VALOR; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.TIP_VALOR ,B.DES_TIPVALOR ,A.EMP_RECAUDADORA into\
 :b0,:b1,:b2  from CO_HINTERFAZ_EXTERNA A ,CO_TIPVALOR B where ((A.COD_CLIENTE\
=:b3 and A.NUM_COMPAGO=:b4) and A.TIP_VALOR=B.TIP_VALOR)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )690;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihTip_Valor;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_TipValor;
   sqlstm.sqhstl[1] = (unsigned long )41;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)shEmp_Recauda;
   sqlstm.sqhstl[2] = (unsigned long )41;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_Cliente;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhNum_Compago;
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


   
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor (4) - %s", LOG00,SQLERRM );
       return -1;
   }

   if( SQLCODE == SQLNOTFOUND ) {
   	 iExiste = 1;
   }
   
   if( iExiste == 0 ) {
       ifnTrazasLog( modulo, "\t ihTip_Valor    - [%d]", LOG09, ihTip_Valor );
       ifnTrazasLog( modulo, "\t shDes_TipValor - [%s]", LOG09, shDes_TipValor );
       ifnTrazasLog( modulo, "\t sEmpRecauda    - [%s]", LOG09, shEmp_Recauda );

       st->iTipValor = ihTip_Valor;
       strcpy( st->sDesValor  , shDes_TipValor);
       strcpy( st->sEmpRecauda, shEmp_Recauda );   	   
   }
   	  
   return iExiste; 
   
} /* end ifnBBuscaTipValorEntidadRecExt */

/* ============================================================================= */
/*  ifnBBuscaTipValorEntidadPAC() : Funcion que busca el tipo de valor y entidad */ 
/*  receptora del pago. Para los pagos PAC                                       */
/* ============================================================================= */
int ifnBBuscaTipValorEntidadPAC(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaTipValorEntidadPAC";

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente     ;
  long   lhNum_Secuenc     ;
  int    ihTip_Valor       ;
  int    ihCod_TipDocu     ;      
  char   shDes_TipValor[41]; /* EXEC SQL VAR shDes_TipValor IS STRING(41); */ 

  char   shCod_Banco   [16]; /* EXEC SQL VAR shCod_Banco    IS STRING(16); */ 

  char   shDes_Banco   [41]; /* EXEC SQL VAR shDes_Banco    IS STRING(41); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   lhCod_Cliente = st->lCodCliente;
   ihCod_TipDocu = st->iCodTipdPag;
   lhNum_Secuenc = st->lNumSecuPag;

   memset( shDes_TipValor, '\0',sizeof(shDes_TipValor));
   memset( shCod_Banco   , '\0',sizeof(shCod_Banco));

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );   
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );
   ifnTrazasLog( modulo, "\t ihCod_TipDocu - %ld", LOG09, ihCod_TipDocu );
   ifnTrazasLog( modulo, "\t lhNum_Secuenc - %ld", LOG09, lhNum_Secuenc );
   
   /* EXEC SQL	
   SELECT NVL(A.COD_BANCO, 'PAGOSONLINE'), B.DES_BANCO
     INTO :shCod_Banco, :shDes_Banco
     FROM CO_PAGOS A, GE_BANCOS B
    WHERE A.NUM_SECUENCI = :lhNum_Secuenc
      AND A.COD_TIPDOCUM = :ihCod_TipDocu
      AND A.COD_CLIENTE  = :lhCod_Cliente
      AND A.COD_BANCO    = B.COD_BANCO; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(A.COD_BANCO,'PAGOSONLINE') ,B.DES_BANCO into :b\
0,:b1  from CO_PAGOS A ,GE_BANCOS B where (((A.NUM_SECUENCI=:b2 and A.COD_TIPD\
OCUM=:b3) and A.COD_CLIENTE=:b4) and A.COD_BANCO=B.COD_BANCO)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )725;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shCod_Banco;
   sqlstm.sqhstl[0] = (unsigned long )16;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_Banco;
   sqlstm.sqhstl[1] = (unsigned long )41;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_Secuenc;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_TipDocu;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCod_Cliente;
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



   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor PAC(5) - %s", LOG00,SQLERRM );
       return -1;
   }

   /* EXEC SQL	
   SELECT TIP_VALOR, DES_TIPVALOR
     INTO :ihTip_Valor, shDes_TipValor
     FROM CO_TIPVALOR A
    WHERE TIP_VALOR = 1; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select TIP_VALOR ,DES_TIPVALOR into :b0,:b1  from CO_TIPVA\
LOR A where TIP_VALOR=1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )760;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihTip_Valor;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_TipValor;
   sqlstm.sqhstl[1] = (unsigned long )41;
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
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor PAC(6) - %s", LOG00,SQLERRM );
       return -1;
   }

   ifnTrazasLog( modulo, "\t ihTip_Valor   - %d", LOG09, ihTip_Valor );
   ifnTrazasLog( modulo, "\t shDes_TipValor- %s", LOG09, shDes_TipValor );
   ifnTrazasLog( modulo, "\t sEmpRecauda   - %s", LOG09, shDes_Banco );

   st->iTipValor = ihTip_Valor;
   strcpy(st->sDesValor  , shDes_TipValor);
   strcpy(st->sEmpRecauda, shDes_Banco);

   return 0; 
   
} /* end ifnBBuscaTipValorEntidadPAC */

/* ============================================================================= */
/*  ifnBBuscaTipValorEntidadREGNCI() : Funcion que busca el tipo de valor y      */
/*  entidad receptora del pago, si el pago es un pago por regularizacion, nota de*/
/*  de credito , ajuste interno o reversas de pago                               */
/* ============================================================================= */
int ifnBBuscaTipValorEntidadREGNCI(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaTipValorEntidadREGNCI";
int  iExiste = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  int    izhCod_TipdPag    ;
  char   shDes_TipValor[41]; /* EXEC SQL VAR shDes_TipValor IS STRING(41); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   izhCod_TipdPag = st->iCodTipdPag;

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );
   ifnTrazasLog( modulo, "\t izhCod_TipdPag - %d", LOG09, izhCod_TipdPag );
      
   /* EXEC SQL                     
     SELECT DES_TIPDOCUM 
       INTO :shDes_TipValor
       FROM GE_TIPDOCUMEN
      WHERE COD_TIPDOCUM = :izhCod_TipdPag; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DES_TIPDOCUM into :b0  from GE_TIPDOCUMEN where COD\
_TIPDOCUM=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )783;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shDes_TipValor;
   sqlstm.sqhstl[0] = (unsigned long )41;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&izhCod_TipdPag;
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


                           
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
       ifnTrazasLog( modulo, "\t Buscando el Tip_Valor (7) - %s", LOG00,SQLERRM );
       return -1;
   }
   
   if( iExiste == 0 ) {

      ifnTrazasLog( modulo, "\t ihTip_Valor    - [%d]", LOG09, izhCod_TipdPag );
      ifnTrazasLog( modulo, "\t shDes_TipValor - [%s]", LOG09, shDes_TipValor );
      ifnTrazasLog( modulo, "\t sEmpRecauda    - [%s]", LOG09, MOVISTAR );

      st->iTipValor = izhCod_TipdPag;
      strcpy( st->sDesValor  , shDes_TipValor);
      strcpy( st->sEmpRecauda, MOVISTAR );   	   
   }
  
   return iExiste; 
   
} /* end ifnBBuscaTipValorEntidadREGNCI */

/* ============================================================================= */
/*  ifnBBuscaProducto() : Funcion que busca el producto del abonado mas antiguo  */ 
/* ============================================================================= */
int ifnBBuscaProducto(td_EstCobex *st ) 
{

char modulo[]="ifnBBuscaProducto";

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  long   lhCod_Cliente       ;
  char   shCod_Prestacion [6]; /* EXEC SQL VAR shCod_Prestacion IS STRING(6); */ 

  char   shDes_Prestacion[51]; /* EXEC SQL VAR shDes_Prestacion IS STRING(51); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   lhCod_Cliente = st->lCodCliente;

   memset( shCod_Prestacion, '\0',sizeof(shCod_Prestacion));
   memset( shDes_Prestacion, '\0',sizeof(shDes_Prestacion));

   ifnTrazasLog( modulo, "\n\t En funcion [%s]", LOG09, modulo );   
   ifnTrazasLog( modulo, "\t lhCod_Cliente - %ld", LOG09, lhCod_Cliente );

   /* EXEC SQL	
   SELECT A.COD_PRESTACION , B.DES_PRESTACION 
     INTO :shCod_Prestacion, :shDes_Prestacion 
     FROM GA_ABOCEL A, GE_PRESTACIONES_TD B 
    WHERE A.COD_PRESTACION = B.COD_PRESTACION 
      AND A.COD_CLIENTE    = :lhCod_Cliente
      AND A.FEC_ALTA = (SELECT MIN(FEC_ALTA) FROM GA_ABOCEL WHERE COD_CLIENTE = :lhCod_Cliente); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.COD_PRESTACION ,B.DES_PRESTACION into :b0,:b1  fr\
om GA_ABOCEL A ,GE_PRESTACIONES_TD B where ((A.COD_PRESTACION=B.COD_PRESTACION\
 and A.COD_CLIENTE=:b2) and A.FEC_ALTA=(select min(FEC_ALTA)  from GA_ABOCEL w\
here COD_CLIENTE=:b2))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )806;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shCod_Prestacion;
   sqlstm.sqhstl[0] = (unsigned long )6;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shDes_Prestacion;
   sqlstm.sqhstl[1] = (unsigned long )51;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Cliente;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_Cliente;
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

      

   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
       ifnTrazasLog( modulo, "\t Buscando el Producto - %s", LOG00,SQLERRM );
       return -1;
   }

   if( SQLCODE == SQLNOTFOUND ) {
       strcpy(shCod_Prestacion, SIN_INFORMACION);
       strcpy(shDes_Prestacion, SIN_INFORMACION);
   }

   ifnTrazasLog( modulo, "\t shCod_Prestacion - %s", LOG09, shCod_Prestacion );
   ifnTrazasLog( modulo, "\t shDes_Prestacion - %s", LOG09, shDes_Prestacion );

   strcpy(st->sCodProducto, shCod_Prestacion);
   strcpy(st->sDesProducto, shDes_Prestacion);

  
   return 0; 
} /* end ifnBBuscaProducto */

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
