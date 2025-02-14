
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
           char  filnam[24];
};
static const struct sqlcxp sqlfpn =
{
    23,
    "./pc/Co_GestionCobex.pc"
};


static unsigned int sqlctx = 442304043;


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

 static const char *sq0009 = 
"select B.COD_ENTIDAD ,B.COD_RANGO ,B.PRC_ASIGNACION ,C.DIA_INICIAL ,C.DIA_FI\
NAL  from CO_ENTCOB A ,CO_ENTIDAD_RANGO_TD B ,CO_RANGOS_COBEX_TD C where ((A.C\
OD_ENTIDAD=B.COD_ENTIDAD and B.COD_RANGO=C.COD_RANGO) and SYSDATE between A.FE\
C_INI_VIGENCIA and A.FEC_FIN_VIGENCIA) order by A.COD_ENTIDAD            ";

 static const char *sq0010 = 
"select NUM_SECUENCIA ,TIP_GESTION ,NVL(COD_ENTIDAD,'-1') ,NVL(COD_CICLFACT,(\
-1)) ,NVL(COD_SEGMENTO,'-1') ,NVL(COD_CATEGORIA,(-1)) ,NVL(COD_CALIFICACION,'-\
1') ,NVL(COD_RANGO,'-1') ,NVL(MTO_DESDE,(-1)) ,NVL(MTO_HASTA,(-1)) ,NVL(NUM_VE\
CESMORA,'-1') ,NVL(IND_HISTORICO,(-1)) ,NVL(NUM_MESES,(-1))  from CO_PARAM_COB\
EX_TO where COD_ESTADO in (:b0) order by TIP_GESTION,COD_ENTIDAD            ";

 static const char *sq0016 = 
"select A.COD_ENTIDAD  from CO_ENTIDAD_RANGO_TD A ,CO_RANGOS_COBEX_TD B ,CO_E\
NTCOB C where (((A.COD_RANGO=:b0 and A.COD_RANGO=B.COD_RANGO) and A.COD_ENTIDA\
D=C.COD_ENTIDAD) and SYSDATE between C.FEC_INI_VIGENCIA and C.FEC_FIN_VIGENCIA\
)           ";

 static const char *sq0017 = 
"select A.COD_ENTIDAD ,A.PRC_ASIGNACION ,B.DIA_INICIAL ,B.DIA_FINAL  from CO_\
ENTIDAD_RANGO_TD A ,CO_RANGOS_COBEX_TD B ,CO_ENTCOB C where (((A.COD_RANGO=:b0\
 and A.COD_RANGO=B.COD_RANGO) and A.COD_ENTIDAD=C.COD_ENTIDAD) and SYSDATE bet\
ween C.FEC_INI_VIGENCIA and C.FEC_FIN_VIGENCIA)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,67,0,4,94,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
28,0,0,2,61,0,5,111,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
51,0,0,3,0,0,29,122,0,0,0,0,0,1,0,
66,0,0,4,68,0,6,262,0,0,2,2,0,1,0,2,5,0,0,1,5,0,0,
89,0,0,5,0,0,29,401,0,0,0,0,0,1,0,
104,0,0,6,0,0,17,503,0,0,1,1,0,1,0,1,5,0,0,
123,0,0,6,0,0,45,517,0,0,0,0,0,1,0,
138,0,0,6,0,0,13,525,0,0,5,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,
173,0,0,6,0,0,15,566,0,0,0,0,0,1,0,
188,0,0,7,146,0,5,601,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,
215,0,0,8,89,0,4,635,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
238,0,0,9,305,0,9,696,0,0,0,0,0,1,0,
253,0,0,9,0,0,13,704,0,0,5,0,0,1,0,2,5,0,0,2,5,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
288,0,0,9,0,0,15,755,0,0,0,0,0,1,0,
303,0,0,10,386,0,9,811,0,0,1,1,0,1,0,1,5,0,0,
322,0,0,10,0,0,13,819,0,0,13,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,
3,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
389,0,0,10,0,0,15,882,0,0,0,0,0,1,0,
404,0,0,11,68,0,5,915,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
427,0,0,12,0,0,17,996,0,0,1,1,0,1,0,1,5,0,0,
446,0,0,12,0,0,45,1010,0,0,0,0,0,1,0,
461,0,0,12,0,0,13,1020,0,0,1,0,0,1,0,2,3,0,0,
480,0,0,12,0,0,15,1050,0,0,0,0,0,1,0,
495,0,0,13,142,0,3,1145,0,0,5,5,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
530,0,0,14,69,0,5,1183,0,0,1,1,0,1,0,1,3,0,0,
549,0,0,15,59,0,5,1190,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
572,0,0,16,244,0,9,1369,0,0,1,1,0,1,0,1,5,0,0,
591,0,0,16,0,0,13,1377,0,0,1,0,0,1,0,2,5,0,0,
610,0,0,16,0,0,15,1399,0,0,0,0,0,1,0,
625,0,0,17,290,0,9,1457,0,0,1,1,0,1,0,1,5,0,0,
644,0,0,17,0,0,13,1465,0,0,4,0,0,1,0,2,5,0,0,2,4,0,0,2,3,0,0,2,3,0,0,
675,0,0,17,0,0,15,1527,0,0,0,0,0,1,0,
690,0,0,18,287,0,4,1555,0,0,2,1,0,1,0,2,4,0,0,1,5,0,0,
713,0,0,19,308,0,4,1611,0,0,3,2,0,1,0,2,4,0,0,1,5,0,0,1,5,0,0,
740,0,0,20,0,0,17,1732,0,0,1,1,0,1,0,1,5,0,0,
759,0,0,20,0,0,45,1746,0,0,0,0,0,1,0,
774,0,0,20,0,0,13,1756,0,0,1,0,0,1,0,2,3,0,0,
793,0,0,20,0,0,15,1890,0,0,0,0,0,1,0,
808,0,0,21,0,0,29,1897,0,0,0,0,0,1,0,
823,0,0,22,378,0,4,1971,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
846,0,0,23,66,0,4,2059,0,0,2,1,0,1,0,2,4,0,0,1,3,0,0,
};


/* ================================================================================================================ */
/*
   Tipo        :  COLA DE PROCESO
   Nombre      :  Co_GestionCobex.pc
   Parametros  :  Usuario/Password. ( por defecto asume los de la cuenta )
                  Nivel de Log ( por defecto asume 3 : Log Normal ) 
                  Nombre de la Cola (Opcional), para nombrar archivos de log
   Autor       :  
   Fecha       :  02-Septiembre-2009
*/ 
/* ================================================================================================================ */
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_

#include "Co_GestionCobex.h"

LINEACOMANDO  	stLineaComando;     		/* Datos con los que se invoco al proceso */
char 			szgCodProceso[6]  = "";
char 			szArchivoLog[256] = ""; 	/* log */
char            *pathDir ;
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

    char    szhGecob              [6]; /* EXEC SQL VAR szhGecob              IS STRING (6); */ 

    char    szhWait               [2]; /* EXEC SQL VAR szhWait               IS STRING (2); */ 

    char    szhYYYYMMDD           [9]; /* EXEC SQL VAR szhYYYYMMDD           IS STRING (9); */ 

    char    szFechayyyymmdd       [9]; /* EXEC SQL VAR szFechayyyymmdd       IS STRING (9); */ 
  
    char    szPND                 [4]; /* EXEC SQL VAR szPND                 IS STRING (4); */ 
   
    char    szREA                 [4]; /* EXEC SQL VAR szREA                 IS STRING (4); */ 
   
    double  dzMorosidadTotal         ;
    char    szhProcesado          [4]; /* EXEC SQL VAR szhProcesado          IS STRING (4); */ 
   
    char    szhError              [4]; /* EXEC SQL VAR szhError              IS STRING (4); */ 
   
    char    szhMORA               [2]; /* EXEC SQL VAR szhMORA               IS STRING (2); */ 
   
    char    szhNOASIGNADO        [12]; /* EXEC SQL VAR szhNOASIGNADO         IS STRING (12); */ 
    
/* EXEC SQL END DECLARE SECTION; */ 


td_Parametros    sthParam;         /* Estructura de Parametros para Gestion      */
td_Entidad_Rango sthCobex;         /* Estructura de Entidades de Cobranza        */
td_Cliente       sthClien;         /* Estructura de Clientes a reasignar         */
long             lIndParam;        /* Indice de array para Parametros            */
long             lIndCobex;        /* Indice de array para Entidades de Cobranza */ 
long             lIndClien;        /* Indice de array para Clientes a reasignar  */ 

/* ============================================================================= */
/*  main                                                                         */
/* ============================================================================= */
int main( int argc, char *argv[] )
{
char modulo[] = "main";
int iResult = 0;

    fprintf(stdout, "\n%s GECOB pid(%ld) VERSION [%s]\n", szGetTime(1),getpid(),szVERSION);
    fflush (stdout);

    /*- Inicializacion de parametros  -*/    
    memset(szgCodProceso,0,sizeof(szgCodProceso));    
    strcpy(szgCodProceso,"GECOB"); 
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
		            WHERE COD_PROCESO=:szhGecob; */ 

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
     sqlstm.sqhstv[1] = (unsigned char  *)szhGecob;
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
		                     WHERE COD_PROCESO = :szhGecob; */ 

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
                      sqlstm.sqhstv[1] = (unsigned char  *)szhGecob;
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
int  iRes = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

    char szhPathLogSched[256]; /* EXEC SQL VAR szhPathLogSched IS STRING (256); */ 

/* EXEC SQL END DECLARE SECTION; */ 

    
    strcpy(szhGecob     ,GECOB);
  	strcpy(szhYYYYMMDD	,"YYYYMMDD");
    strcpy(szhWait      ,W );
    strcpy(szPND        ,PND);
    strcpy(szREA        ,REA);
    strcpy(szhProcesado ,PROCESADO);
    strcpy(szhError     ,ERROR);
    strcpy(szhMORA      ,MORA);
    strcpy(szhNOASIGNADO,NOASIGNADO);
       
    /* EXEC SQL EXECUTE
		BEGIN
			:szFechayyyymmdd        :=TO_CHAR(SYSDATE  ,:szhYYYYMMDD);
		END;
	END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "begin :szFechayyyymmdd := TO_CHAR ( SYSDATE , :szhYYYYMMD\
D ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )66;
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


	
	lIndParam = 0;
	lIndCobex = 0;
	lIndClien = 0;

	sprintf(stStatus.szFileName   ,"%s",szgCodProceso);
	sprintf(szhPathLogSched       ,"%s/CO_SCHEDULER",getenv("XPC_LOG"));    
	sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    
  	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

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

    sprintf(szComando,"mkdir -p %s",szPathLog);

    if (system (szComando)!=0) {
        fprintf (stderr,"Error al intentar crear directorio de Log\n");
        fflush  (stderr);
        return -1;
    }

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
char  modulo[] ="ifnEjecutaCola";
char  szIniProc[9], szFinProc[9], szTmpProc[9];
int   iDifSegs = 0;

	sprintf( szIniProc, "%s", szSysDate( "HH24:MI:SS" ) );

	ifnTrazasLog( modulo, "Corriendo la cola lanzada ", LOG03 );
	ifnTrazasLog(modulo,"GECOB VERSION [%s]\n",LOG03, szVERSION);
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
		
	/* Informacion Estadistica */
	sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );    
	if( (iDifSegs=ifnRestaHoras(szIniProc,szFinProc,szTmpProc)) >= 0 )	{
	    ifnTrazasLog(modulo,"\n\tRESUMEN DEL PROCESO GECOB"
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
 sqlstm.arrsiz = 2;
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


	if (SQLCODE) {
	    fprintf (stdout,"\n\tError >> Fallo el Commit -  %s\n", SQLERRM );
	    fflush  (stdout);
	    return -1;
	}                            

	ifnTrazasLog( modulo, "Saliendo de %s ( Cola Wait )\n", LOG02, szgCodProceso );
	return 0;
	
} /* end ifnEjecutaCola */


/* ============================================================================= */
/*  ifnReasignacion: Funcion que reasigna aquellos clientes que pasan a otro     */ 
/*  rango de gestion                                                             */
/* ============================================================================= */
int ifnReasignacion(char *sCodAgente, char *sRango, int j)
{
char   modulo[]   = "ifnReasignacion";
int    iError     = 0;     
int    iRes       = 0;    
char   shMontoDesde     [8]; /* EXEC SQL VAR shMontoDesde IS STRING(8); */ 

char   shMontoHasta     [8]; /* EXEC SQL VAR shMontoHasta IS STRING(8); */ 
   
char   szhCicloFact     [3]; /* EXEC SQL VAR szhCicloFact IS STRING(3); */ 
   
char   szhCategoria     [5]; /* EXEC SQL VAR szhCategoria IS STRING(5); */ 
   
int    ihDiasMora    ;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lhCodCliente       ;
   long   lhNumSecuencia     ;
   char   shCodAgente     [6]; /* EXEC SQL VAR shCodAgente     IS STRING(6); */ 

   char   shCodRango      [6]; /* EXEC SQL VAR shCodRango      IS STRING(6); */ 

   char   shCodRangoClie  [6]; /* EXEC SQL VAR shCodRangoClie  IS STRING(6); */ 

   static char szhQuery[2048]; /* EXEC SQL VAR szhQuery        IS STRING(2048); */ 
      
   int    ihDiaIniClie;
   int    ihDiaFinClie;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

    memset(shCodRango ,0,sizeof(shCodRango));    
    memset(shCodAgente,0,sizeof(shCodAgente));    

    strcpy(shCodAgente, sCodAgente); 
    strcpy(shCodRango , sRango); 

    ifnTrazasLog( modulo, " Codigo Agente [%s] ", LOG09, shCodAgente);
                            
    /************************************************************************/
    /* Obtiene el Universo de clientes con mora                             */
    /************************************************************************/   
    strcpy(szhQuery,"SELECT B.NUM_SECUENCIA, A.COD_CLIENTE, B.COD_RANGO, D.DIA_INICIAL, D.DIA_FINAL ");
    strcat(szhQuery,"  FROM GE_CLIENTES A, CO_GESTION_COBEX_TO B, CO_MOROSOS C, CO_RANGOS_COBEX_TD D ");
    strcat(szhQuery," WHERE A.COD_CLIENTE = B.COD_CLIENTE ");
    strcat(szhQuery,"   AND B.COD_CLIENTE = C.COD_CLIENTE ");
    strcat(szhQuery,"   AND B.COD_ENTIDAD = '");
    strcat(szhQuery,shCodAgente);
    strcat(szhQuery,"'");
    strcat(szhQuery,"   AND B.TIP_GESTION = '");
    strcat(szhQuery,szhMORA);
    strcat(szhQuery,"'");
    strcat(szhQuery,"   AND B.FEC_TERMINO IS NULL ");
    strcat(szhQuery,"   AND B.COD_RANGO   = D.COD_RANGO ");
    strcat(szhQuery,"   AND NOT EXISTS (SELECT 1 FROM CO_COBEX_INMUNE_TO E WHERE E.COD_CLIENTE = C.COD_CLIENTE) ");   
    
    if(( sthParam.dMontoDesde[j] == 0 ) && (sthParam.dMontoHasta[j] == 0 )) {
       sprintf(shMontoDesde,"%d",sthParam.dMontoDesde[j]);
       strcat(szhQuery," AND C.DEU_VENCIDA > ");
       strcat(szhQuery,(shMontoDesde));
       sprintf(shMontoHasta,"%d",sthParam.dMontoHasta[j]);
       strcat(szhQuery," AND C.DEU_VENCIDA < ");
       strcat(szhQuery,(shMontoHasta));
       strcat(szhQuery," ) ");           
    }

    if( sthParam.lCicloFact[j] > 0 ) {
       sprintf(szhCicloFact,"%d",sthParam.lCicloFact[j]);
       strcat(szhQuery," AND A.COD_CICLO = ");
       strcat(szhQuery,szhCicloFact);
    }
        
    if  (strcmp(sthParam.sCodSegmento[j],CARNULL)!= 0) {
       strcat(szhQuery," AND A.COD_SEGMENTO = '");
       strcat(szhQuery,sthParam.sCodSegmento[j]);
       strcat(szhQuery,"'");
    }

    if( sthParam.iCodCategoria[j] > 0 ) {
       sprintf(szhCategoria,"%d",sthParam.iCodCategoria[j]);
       strcat(szhQuery," AND A.COD_CATEGORIA = ");
       strcat(szhQuery,szhCategoria);
    }

    if  (strcmp(sthParam.sCodCalifica[j],CARNULL )!= 0) {
       strcat(szhQuery," AND A.COD_CALIFICACION = '");
       strcat(szhQuery,sthParam.sCodCalifica[j]);
       strcat(szhQuery,"'");       
    }
    
    ifnTrazasLog( modulo, "\t szhQuery - [%s]", LOG05,szhQuery );

    /* EXEC SQL PREPARE sql_cabecera_3 FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )104;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
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


    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR al PREPARAR QUERY Cur_EntCob", LOG05 );
        return SQLCODE;
    }

    /* EXEC SQL DECLARE Cur_EntCob CURSOR FOR sql_cabecera_3; */ 

    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR en DECLARE QUERY Cur_EntCob", LOG05 );
        return SQLCODE;
    }
   
   /* EXEC SQL OPEN Cur_EntCob; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 2;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )123;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if( SQLCODE != SQLOK ) {
       ifnTrazasLog( modulo, "\tOPEN Cur_EntCob - %s", LOG00,SQLERRM );
       return -1;
   }
   
   while(1) {

        /* EXEC SQL FETCH Cur_EntCob INTO :lhNumSecuencia, :lhCodCliente, :shCodRangoClie, :ihDiaIniClie, :ihDiaFinClie; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )138;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
        sqlstm.sqhstv[2] = (unsigned char  *)shCodRangoClie;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihDiaIniClie;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihDiaFinClie;
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


                                                      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas registros pendientes */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

		ifnTrazasLog( modulo, " ======== EVALUACION DE CLIENTE PARA REASIGNACION =============", LOG03);
		ifnTrazasLog( modulo, " Secuencia     [%ld] ", LOG09, lhNumSecuencia);
		ifnTrazasLog( modulo, " Cliente       [%ld] ", LOG09, lhCodCliente);
		ifnTrazasLog( modulo, " Rango Actual  [%s] ", LOG09, shCodRangoClie);
		ifnTrazasLog( modulo, " Dia Inicial   [%d] ", LOG09, ihDiaIniClie);
		ifnTrazasLog( modulo, " Dia Final     [%d] ", LOG09, ihDiaFinClie);
                                    
        iRes = ifnDiasMorosidad(lhCodCliente, &ihDiasMora);
        if( iRes < 0 ) {
        	iError = -1;        	    	   	
        	break;
        }

		ifnTrazasLog( modulo, " ihDiasMora     [%d] ", LOG09, ihDiasMora);

        if (ihDiasMora > 0) {
            if(( ihDiasMora > ihDiaIniClie  ) && ( ihDiasMora < ihDiaFinClie))  {

  		       ifnTrazasLog( modulo, " Cliente se mantiene en rango asignado...", LOG05);		     

            } else {

		       ifnTrazasLog( modulo, " Cliente debe ser reasignado de rango y/o empresa...", LOG05);        
               iRes = ifnCierraRegistro(lhNumSecuencia, lhCodCliente, shCodAgente);
            
            } /* end if(( ihDiasMora > ihDiaIniClie */
        } /* end if (ihDiasMora > 0) */
         
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_EntCob; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )173;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if(  SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
                	
    return iError;
  
} /* end ifnReasignacion() */


/* ============================================================================= */
/*  ifnCierraRegistro :                                                          */
/* ============================================================================= */
int ifnCierraRegistro(long lNumSecuencia, long lCodCliente, char *sEntidad)
{	
   char        modulo[]="ifnCierraRegistro";
   int         iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   long   lhCodCliente   ;
   char   shCodAgente[6] ; /* EXEC SQL VAR shCodAgente IS STRING(6); */ 
   
   long   lhNumSecuencia ;      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
    ifnTrazasLog( modulo, "\n En funcion %s", LOG06,modulo);                      
    lhCodCliente   = lCodCliente;
    lhNumSecuencia = lNumSecuencia;
    strcpy(shCodAgente, sEntidad); 

    ifnTrazasLog( modulo, " lhCodCliente   [%ld]", LOG09, lhCodCliente  );
    ifnTrazasLog( modulo, " lhNumSecuencia [%ld]", LOG09, lhNumSecuencia);
    ifnTrazasLog( modulo, " shCodAgente    [%s]", LOG09, shCodAgente);
                       
    /* EXEC SQL                       
    UPDATE CO_GESTION_COBEX_TO
       SET FEC_TERMINO = SYSDATE
     WHERE COD_CLIENTE  = :lhCodCliente
       AND COD_ENTIDAD  = :shCodAgente
       AND NUM_SECUENCIA= :lhNumSecuencia
       AND FEC_TERMINO IS NULL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_GESTION_COBEX_TO  set FEC_TERMINO=SYSDATE where\
 (((COD_CLIENTE=:b0 and COD_ENTIDAD=:b1) and NUM_SECUENCIA=:b2) and FEC_TERMIN\
O is null )";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )188;
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
    sqlstm.sqhstv[1] = (unsigned char  *)shCodAgente;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuencia;
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
	  ifnTrazasLog( modulo, "\t En UPDATE CO_GESTION_COBEX_TO  - %s", LOG00, SQLERRM );
	  return -1;				
    }
		
	return iError;
	
} /* end ifnCierraRegistro */

/* ============================================================================= */
/*  ifnDiasMorosidad : Funcion que obtiene los dias morosidad del cliente        */
/* ============================================================================= */
int ifnDiasMorosidad(long lCodCliente, int *iDiasMora)
{	
   char        modulo[]="ifnDiasMorosidad";
   int         iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   long   lhCodCliente    ;
   int    ihMorodidad     ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
    ifnTrazasLog( modulo, " En funcion %s", LOG09,modulo);                      
    ifnTrazasLog( modulo, " lCodCliente [%ld]", LOG09,lCodCliente);                      
    lhCodCliente = lCodCliente;
                       
    /* EXEC SQL                       
    SELECT TRUNC(SYSDATE-MIN(FEC_VENCIMIE))
      INTO :ihMorodidad
      FROM CO_CARTERA
     WHERE COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TRUNC((SYSDATE-min(FEC_VENCIMIE))) into :b0  from \
CO_CARTERA where COD_CLIENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )215;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihMorodidad;
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
	    ifnTrazasLog( modulo, "\t En SELECT TRUNC(SYSDATE-MIN(FEC_VENCIMIE))  - %s", LOG00, SQLERRM );
	    return -1;				
    }

    if( SQLCODE  == SQLNOTFOUND) {
		ifnTrazasLog( modulo, "\t Cliente no se encuentra moroso ...", LOG00 );
		ihMorodidad = 0;
	}
	
	*iDiasMora = ihMorodidad;
	return iError;
	
} /* end ifnDiasMorosidad */

/* ============================================================================= */
/*  ifnLlenaEstructuraCOBEX: Funcion que llena estructura de entidades de        */
/*  cobranza                                                                     */ 
/* ============================================================================= */
int ifnLlenaEstructuraCOBEX()
{
char    modulo[]   = "ifnLlenaEstructuraCOBEX";
int     iError     = 0;     
int     iRes       = 0;    
double  dhMonto_Asig  ;
double  dhPrcAsignado ;    
double  dhMontoUtilizado; 
double  dhPorAsignar  ;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   char   shCodAgente     [6]; /* EXEC SQL VAR shCodAgente IS STRING(6); */ 

   char   shCodRango      [6]; /* EXEC SQL VAR shCodRango  IS STRING(6); */ 

   double dhPrcAsignacion    ;
   int    ihDiasIni          ;
   int    ihDiasFin          ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

   /************************************************************************/
   /* Obtiene las entidades de cobranzas con sus respectivos atributos     */
   /************************************************************************/
   /* EXEC SQL DECLARE Cur_ECob CURSOR for        
     SELECT B.COD_ENTIDAD, B.COD_RANGO, B.PRC_ASIGNACION, C.DIA_INICIAL, C.DIA_FINAL 
       FROM CO_ENTCOB A,CO_ENTIDAD_RANGO_TD B, CO_RANGOS_COBEX_TD C 
      WHERE A.COD_ENTIDAD = B.COD_ENTIDAD    
        AND B.COD_RANGO   = C.COD_RANGO 
        AND SYSDATE BETWEEN A.FEC_INI_VIGENCIA AND A.FEC_FIN_VIGENCIA                                
      ORDER BY A.COD_ENTIDAD; */ 
 
         
   if( SQLCODE != SQLOK ) {
       ifnTrazasLog( modulo, "\tDECLARE Cur_ECob - %s", LOG00,SQLERRM );
       return -1;
   }
   
   /* EXEC SQL OPEN Cur_ECob; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0009;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )238;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


   if( SQLCODE != SQLOK ) {
       ifnTrazasLog( modulo, "\tOPEN Cur_ECob - %s", LOG00,SQLERRM );
       return -1;
   }
   
   while(1) {

        /* EXEC SQL FETCH Cur_ECob INTO :shCodAgente , :shCodRango , :dhPrcAsignacion, 
                                     :ihDiasIni   , :ihDiasFin; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 5;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )253;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)shCodAgente;
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shCodRango;
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&dhPrcAsignacion;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihDiasIni;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihDiasFin;
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

  
                                                      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas registros pendientes */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

		ifnTrazasLog( modulo, " =============================================================", LOG03);
		ifnTrazasLog( modulo, " Codigo Agente             [%s] ", LOG03, shCodAgente);
		ifnTrazasLog( modulo, " Codigo Rango              [%s] ", LOG03, shCodRango);
		ifnTrazasLog( modulo, " Porcentaje Asignacion     [%.2f] ", LOG03, dhPrcAsignacion);
		ifnTrazasLog( modulo, " Dias de Inicio            [%d] ", LOG03, ihDiasIni);
		ifnTrazasLog( modulo, " Dias de Fin               [%d] ", LOG03, ihDiasFin);
            
        strcpy(sthCobex.sCodAgente[lIndCobex], shCodAgente); 
        strcpy(sthCobex.sCodRango [lIndCobex], shCodRango); 
        
        sthCobex.iDiasDesde  [lIndCobex] = ihDiasIni;
        sthCobex.iDiasHasta  [lIndCobex] = ihDiasFin;
        sthCobex.dPrcAsignado[lIndCobex] = dhPrcAsignacion; 

		ifnTrazasLog( modulo, " =============================================================", LOG03);
		ifnTrazasLog( modulo, " Codigo Agente             [%s] ", LOG03, sthCobex.sCodAgente[lIndCobex]);
		ifnTrazasLog( modulo, " Codigo Rango              [%s] ", LOG03, sthCobex.sCodRango [lIndCobex]);
		ifnTrazasLog( modulo, " Porcentaje Asignacion     [%.2f] ", LOG03, sthCobex.dPrcAsignado[lIndCobex]);
		ifnTrazasLog( modulo, " Dias de Inicio            [%d] ", LOG03, sthCobex.iDiasDesde  [lIndCobex]);
		ifnTrazasLog( modulo, " Dias de Fin               [%d] ", LOG03, sthCobex.iDiasHasta  [lIndCobex]);
                
        dhMonto_Asig = 0;
        dhPrcAsignado= 0;    
        dhMontoUtilizado = 0; 

        iRes = ifnMorosidadEntidad(dhPrcAsignacion, &dhMonto_Asig, &dhMontoUtilizado, &dhPorAsignar, shCodAgente, shCodRango);
        if( iRes < 0 ) {
           iError = -1;
           break;        	    	   	
        } else  {
           sthCobex.dMtoAsignado  [lIndCobex]= dhMonto_Asig;   
           sthCobex.dMtoUtilizado [lIndCobex]= dhMontoUtilizado;
           sthCobex.dMtoPorAsignar[lIndCobex]= dhPorAsignar;  
        }        
                                               
        lIndCobex = lIndCobex + 1;
                 	    
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_ECob; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
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


	if(  SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
           	
    return iError;
  
} /* end ifnLlenaEstructuraCOBEX() */

/* ============================================================================= */
/*  ifnGeneraUniverso: Funcion que rescata los datos agendados para la gestion   */
/* ============================================================================= */
int ifnGeneraUniverso()
{
char modulo[]   = "ifnGeneraUniverso";
int  iError     = 0;     
int  iRes       = 0;    

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lhNumSecuencia     ;
   char   shTipGestion    [2]; /* EXEC SQL VAR shTipGestion  IS STRING(2); */ 

   char   shCodAgente     [6]; /* EXEC SQL VAR shCodAgente   IS STRING(6); */ 

   long   lhCicloFact        ;
   char   shCodSegmento   [6]; /* EXEC SQL VAR shCodSegmento IS STRING(6); */ 

   int    ihCodCategoria     ;
   char   shCodCalifica   [6]; /* EXEC SQL VAR shCodCalifica IS STRING(6); */ 

   char   shCodRango      [6]; /* EXEC SQL VAR shCodRango    IS STRING(6); */ 

   double dhMontoDesde       ;
   double dhMontoHasta       ;
   int    ihVecesMora        ;
   int    ihHistorico        ;
   int    ihCantMeses        ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

   /************************************************************************/
   /* Obtiene el Universo Agendado para la Gestion de Cobranzas            */
   /************************************************************************/
   /* EXEC SQL DECLARE Cur_GesCobex CURSOR for        
   SELECT  NUM_SECUENCIA             , TIP_GESTION            , NVL(COD_ENTIDAD  , '-1'), 
           NVL(COD_CICLFACT    , -1) , NVL(COD_SEGMENTO ,'-1'), NVL(COD_CATEGORIA, -1  ), 
           NVL(COD_CALIFICACION,'-1'), NVL(COD_RANGO    ,'-1'), NVL(MTO_DESDE    , -1  ), 
           NVL(MTO_HASTA       , -1 ), NVL(NUM_VECESMORA,'-1'), NVL(IND_HISTORICO, -1  ), 
           NVL(NUM_MESES       , -1 )            
     FROM CO_PARAM_COBEX_TO
    WHERE COD_ESTADO IN (:szPND)     
   ORDER BY TIP_GESTION, COD_ENTIDAD; */ 
 
         
   if( SQLCODE != SQLOK ) {
       ifnTrazasLog( modulo, "\tDECLARE Cur_GesCobex - %s", LOG00,SQLERRM );
       return -1;
   }
   
   /* EXEC SQL OPEN Cur_GesCobex; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 5;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0010;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )303;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szPND;
   sqlstm.sqhstl[0] = (unsigned long )4;
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


   if( SQLCODE != SQLOK ) {
       ifnTrazasLog( modulo, "\tOPEN Cur_GesCobex - %s", LOG00,SQLERRM );
       return -1;
   }
   
   while(1) {

        /* EXEC SQL FETCH Cur_GesCobex INTO :lhNumSecuencia, :shTipGestion  , :shCodAgente   , 
                                         :lhCicloFact   , :shCodSegmento , :ihCodCategoria, 
                                         :shCodCalifica , :shCodRango    , :dhMontoDesde  , 
                                         :dhMontoHasta  , :ihVecesMora   , :ihHistorico   , 
                                         :ihCantMeses   ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )322;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shTipGestion;
        sqlstm.sqhstl[1] = (unsigned long )2;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)shCodAgente;
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCicloFact;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)shCodSegmento;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCategoria;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)shCodCalifica;
        sqlstm.sqhstl[6] = (unsigned long )6;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)shCodRango;
        sqlstm.sqhstl[7] = (unsigned long )6;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&dhMontoDesde;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&dhMontoHasta;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&ihVecesMora;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)&ihHistorico;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[11] = (         int  )0;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)&ihCantMeses;
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

            
                                                      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas registros pendientes */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

		ifnTrazasLog( modulo, " =============================================================", LOG03);
		ifnTrazasLog( modulo, " Tipo de Gestion           [%s] ", LOG03, shTipGestion);
		ifnTrazasLog( modulo, " Codigo Agente             [%s] ", LOG03, shCodAgente);
		ifnTrazasLog( modulo, " Ciclo Facturacion         [%ld] ", LOG03, lhCicloFact);
		ifnTrazasLog( modulo, " Segmento                  [%s] ", LOG03, shCodSegmento);
		ifnTrazasLog( modulo, " Categoria                 [%d] ", LOG03, ihCodCategoria);
		ifnTrazasLog( modulo, " Calificacion              [%s] ", LOG03, shCodCalifica);
		ifnTrazasLog( modulo, " Codigo de Rango           [%s] ", LOG03, shCodRango);
		ifnTrazasLog( modulo, " Monto desde               [%f] ", LOG03, dhMontoDesde);
		ifnTrazasLog( modulo, " Monto hasta               [%f] ", LOG03, dhMontoHasta);
		ifnTrazasLog( modulo, " Cantidad de veces en mora [%d] ", LOG03, ihVecesMora);
		ifnTrazasLog( modulo, " Se incluye el historico   [%d] ", LOG03, ihHistorico);
		ifnTrazasLog( modulo, " Meses pre-mora            [%d] ", LOG03, ihCantMeses);
		ifnTrazasLog( modulo, " lhNumSecuencia            [%ld] ", LOG03, lhNumSecuencia);
            
        /* Inicializacion de Array de Parametros  */
        strcpy(sthParam.sTipGestion [lIndParam], shTipGestion ); 
        strcpy(sthParam.sCodAgente  [lIndParam], shCodAgente  );
        strcpy(sthParam.sCodSegmento[lIndParam], shCodSegmento); 
        strcpy(sthParam.sCodCalifica[lIndParam], shCodCalifica);
        strcpy(sthParam.sCodRango   [lIndParam], shCodRango   );

        sthParam.lNumSecuencia [lIndParam] = lhNumSecuencia;
        sthParam.lCicloFact    [lIndParam] = lhCicloFact;
        sthParam.iCodCategoria [lIndParam] = ihCodCategoria; 
        sthParam.dMontoDesde   [lIndParam] = dhMontoDesde; 
        sthParam.dMontoHasta   [lIndParam] = dhMontoHasta; 
        sthParam.iVecesMora    [lIndParam] = ihVecesMora; 
        sthParam.iHistorico    [lIndParam] = ihHistorico; 
        sthParam.iCantMeses    [lIndParam] = ihCantMeses; 
        
	    if ( strcmp(shTipGestion,PREMORA)== 0)  {
           iRes = ifnGestionPreMora(lIndParam);
	       if( iRes < 0 ) iError = -1;        	    	   	
        }

	    if ( strcmp(shTipGestion,MORA) == 0)  {
           iRes = ifnGestionMora(lIndParam);
	       if( iRes < 0 ) iError = -1;        	    	   	
        }
                        
        iRes = ifnUpdateGestion(lhNumSecuencia, iError);
        if( iRes < 0 ) iError = -1;        	    	   	
                
        lIndParam = lIndParam + 1;
                 	    
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_GesCobex; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )389;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if(  SQLCODE )
	{
		ifnTrazasLog( modulo, "en CLOSE : %s", LOG00, SQLERRM );
		return -1;
	}
           	
    return iError;
  
} /* end ifnGeneraUniverso() */

/* ============================================================================= */
/*  ifnUpdateGestion : Funcion que obtiene la morosidad total en cobros          */
/* ============================================================================= */
int ifnUpdateGestion(long lNumSecuencia, int iEstado)
{	
   char        modulo[]="ifnUpdateGestion";
   int         iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
    long   lhNumSecuencia ;                                       
    char   shEstado    [4]; /* EXEC SQL VAR shEstado IS STRING(4); */ 
   
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lhNumSecuencia = lNumSecuencia;

    if( iEstado == 0) {
    	strcpy(shEstado, szhProcesado);
    } else {
        strcpy(shEstado, szhError);	 	
    }                   
                       
    /* EXEC SQL                       
    UPDATE CO_PARAM_COBEX_TO
      SET  COD_ESTADO = :shEstado
     WHERE NUM_SECUENCIA = :lhNumSecuencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_PARAM_COBEX_TO  set COD_ESTADO=:b0 where NUM_SE\
CUENCIA=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )404;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shEstado;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
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


      
    if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En SELECT SUM(DEU_VENCIDA)  - %s", LOG00, SQLERRM );
	  return -1;				
    }
	
	return iError;
} /* end ifnUpdateGestion */

/* ============================================================================= */
/*  ifnGestionPreMora : Funcion que busca los clientes para gestion pre-mora     */
/* ============================================================================= */
int ifnGestionPreMora(long i)
{	
   char        modulo[]="ifnGestionPreMora";
   static char szhQuery      [2048]; /* EXEC SQL VAR szhQuery     IS STRING(2048); */ 

   char        szhCicloFact     [3]; /* EXEC SQL VAR szhCicloFact IS STRING(3); */ 
   
   char        szhCantMeses     [3]; /* EXEC SQL VAR szhCantMeses IS STRING(3); */ 
   
   char        szhCategoria     [5]; /* EXEC SQL VAR szhCategoria IS STRING(5); */ 
   
   
   int         iSalir = FALSE;                                                            
   int         iError = 0;                
   int         iRes   = 0;                
                                        
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
    long   lzhCod_Cliente     ;                                       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
                              
    /************************************************************************/
    /* Obtiene el Universo de clientes con pre-mora                         */
    /************************************************************************/
    strcpy(szhQuery,"SELECT A.COD_CLIENTE ");
    strcat(szhQuery," FROM  GE_CLIENTES A ");
    strcat(szhQuery,"WHERE NOT EXISTS (SELECT 1 FROM CO_MOROSOS  C WHERE C.COD_CLIENTE = A.COD_CLIENTE ) ");
    strcat(szhQuery,"  AND     EXISTS (SELECT 1 FROM CO_HMOROSOS D WHERE D.COD_CLIENTE = A.COD_CLIENTE ) ");
    strcat(szhQuery,"  AND     EXISTS (SELECT 1 FROM CO_CARTERA  B "); 
    strcat(szhQuery,"                   WHERE B.COD_CLIENTE = A.COD_CLIENTE ");
    strcat(szhQuery,"                     AND B.COD_CONCEPTO NOT IN (2,6)   ");

    if( sthParam.iCantMeses[i] > 0 ) {
       sprintf(szhCantMeses,"%d",(sthParam.iCantMeses[i]*-1));
       strcat(szhQuery,"                     AND B.FEC_VENCIMIE > TRUNC(ADD_MONTHS(SYSDATE, ");
       strcat(szhQuery,(szhCantMeses));
       strcat(szhQuery," ))");           
    }
    strcat(szhQuery," ) ");

    strcat(szhQuery,"  AND NOT EXISTS (SELECT 1 FROM CO_COBEX_INMUNE_TO E WHERE E.COD_CLIENTE = A.COD_CLIENTE) ");

    if( sthParam.lCicloFact[i] > 0 ) {
       sprintf(szhCicloFact,"%d",sthParam.lCicloFact[i]);
       strcat(szhQuery,"  AND A.COD_CICLO = ");
       strcat(szhQuery,szhCicloFact);
    }
        
    if  (strcmp(sthParam.sCodSegmento[i],CARNULL)!= 0) {
       strcat(szhQuery,"  AND A.COD_SEGMENTO = '");
       strcat(szhQuery,sthParam.sCodSegmento[i]);
       strcat(szhQuery,"'");                  
    }

    if( sthParam.iCodCategoria[i] > 0 ) {
       sprintf(szhCategoria,"%d",sthParam.iCodCategoria[i]);
       strcat(szhQuery,"  AND A.COD_CATEGORIA = ");
       strcat(szhQuery,szhCategoria);
    }

    if  (strcmp(sthParam.sCodCalifica[i],CARNULL )!= 0) {
       strcat(szhQuery,"  AND A.COD_CALIFICACION ='");
       strcat(szhQuery,sthParam.sCodCalifica[i]);
       strcat(szhQuery,"'");                         
    }
    
    ifnTrazasLog( modulo, "\t szhQuery - [%s]", LOG05,szhQuery );

    /* EXEC SQL PREPARE sql_cabecera FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )427;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
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


    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR al PREPARAR QUERY Cur_ClientesPreMora", LOG05 );
        return SQLCODE;
    }

    /* EXEC SQL DECLARE Cur_ClientesPreMora CURSOR FOR sql_cabecera; */ 

    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR en DECLARE QUERY Cur_ClientesPreMora", LOG05 );
        return SQLCODE;
    }

    /* EXEC SQL OPEN Cur_ClientesPreMora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )446;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR en OPEN QUERY Cur_ClientesPreMora", LOG05 );
        return SQLCODE;
    }

    iSalir=FALSE;
    while(!iSalir)
    {    	
        /* EXEC SQL
        FETCH Cur_ClientesPreMora
        INTO :lzhCod_Cliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )461;
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
            ifnTrazasLog( modulo, "\tFETCH Cur_ClientesPreMora - %s", LOG00,SQLERRM );
            iError = -1;
            break;
        }

        if( SQLCODE == SQLNOTFOUND ) {
            break;
        }

        iRes = ifnVerificaSaldo(lzhCod_Cliente); 
        if( iRes > 0 ) {
            iRes = ifnRegistraGestion(lzhCod_Cliente,PREMORA, sthParam.lNumSecuencia[i], NULO, sthParam.sCodAgente[i]);
            if( iRes < 0 ) {
        	   iError = -1;
               break;
            }
        }

        if( iRes < 0 ) {
           iError = -1;
           break;
        }                       
        
    } /* fin while cursor Cur_ClientesPreMora */

    /* EXEC SQL
    CLOSE Cur_ClientesPreMora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )480;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tCLOSE Cur_ClientesPreMora - %s", LOG00, SQLERRM );
        iError = -1;
    }
			
	return iError;	
	
} /* end ifnGestionPreMora */

/* ============================================================================= */
/*  ifnVerificaSaldo: Funcion que verifica el saldo del cliente                  */
/* ============================================================================= */
int ifnVerificaSaldo(long pCodCliente)
{	
   char    modulo[]   ="ifnVerificaSaldo";
   int     iRespuesta = 0;                 
                                                                                  
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
    long   lzCod_Cliente  ;     
    double dhDeuVencida   ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);   

    lzCod_Cliente   = pCodCliente;
    
	if( !bfnGetSaldoVencido( lzCod_Cliente, &dhDeuVencida ))	{
 		 return -1;
	}

    if( dhDeuVencida <= 0) {
        iRespuesta = 0;
    } else {
        iRespuesta = 1;    	
    }

	return iRespuesta;
} /* end ifnVerificaSaldo */

/* ============================================================================= */
/*  ifnRegistraGestion: Funcion que ingresa el registro de premora o mora para   */
/*  la gestion de cobranza                                                       */
/* ============================================================================= */
int ifnRegistraGestion(long pCodCliente, char *cTipoGestion, long lNumSecuencia, char *cRango, char *cAgente)
{	
   char  modulo[]="ifnRegistraGestion";
   int   iError = 0;                
   int   iRes = 0;
                                                                                  
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

   	char   shCodRango      [6]; /* EXEC SQL VAR shCodRango   IS STRING(6); */ 

    long   lzCod_Cliente      ;      
    long   lzNum_Secuencia    ;                                  
    char   szTipoMora      [2]; /* EXEC SQL VAR szTipoMora   IS STRING(2); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);   
                   
    lzCod_Cliente   = pCodCliente;
    lzNum_Secuencia = lNumSecuencia;

    memset(shCodEntidad,0,sizeof(shCodEntidad));    
    memset(shCodRango  ,0,sizeof(shCodRango));    
    memset(szTipoMora  ,0,sizeof(szTipoMora));    

    strcpy(shCodEntidad, cAgente);
    strcpy(shCodRango, cRango);                              
    
    if  (strcmp(cTipoGestion,PREMORA )== 0) {
        strcpy(szTipoMora, PREMORA);                              
    }

    if  (strcmp(cTipoGestion,MORA )== 0) {
        strcpy(szTipoMora, MORA);                              

        ifnTrazasLog( modulo, " shCodEntidad    [%s] ", LOG09, shCodEntidad);   
        ifnTrazasLog( modulo, " lzCod_Cliente   [%ld]", LOG09, lzCod_Cliente);   
        
        /*iRes = ifnActualizaAgente(lzCod_Cliente, shCodEntidad);*/
        if( iRes < 0 ) return -1;
                
    } /* end if  (strcmp(cTipoGestion,MORA )== 0) {*/

    ifnTrazasLog( modulo, " \n Insertando en CO_GESTION_COBEX_TO \n", LOG09);   
    ifnTrazasLog( modulo, " lzNum_Secuencia [%ld]", LOG09, lzNum_Secuencia);   
    ifnTrazasLog( modulo, " shCodEntidad    [%s] ", LOG09, shCodEntidad);   
    ifnTrazasLog( modulo, " lzCod_Cliente   [%ld]", LOG09, lzCod_Cliente);   
    ifnTrazasLog( modulo, " szTipoMora      [%s] ", LOG09, szTipoMora);   
    ifnTrazasLog( modulo, " shCodRango      [%s] ", LOG09, shCodRango);   

    ifnTrazasLog( modulo, "\n - - - - - - - - - - - - - - - - - - - - - - - - ", LOG09);   
                       
    /* EXEC SQL                       
    INSERT INTO CO_GESTION_COBEX_TO
          (NUM_SECUENCIA, COD_ENTIDAD, COD_CLIENTE, FEC_INGRESO, TIP_GESTION, COD_RANGO)
    VALUES
          (:lzNum_Secuencia, :shCodEntidad, :lzCod_Cliente, SYSDATE, :szTipoMora, :shCodRango); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_GESTION_COBEX_TO (NUM_SECUENCIA,COD_ENTIDA\
D,COD_CLIENTE,FEC_INGRESO,TIP_GESTION,COD_RANGO) values (:b0,:b1,:b2,SYSDATE,:\
b3,:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )495;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lzNum_Secuencia;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)shCodEntidad;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lzCod_Cliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szTipoMora;
    sqlstm.sqhstl[3] = (unsigned long )2;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)shCodRango;
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



    if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En INSERT INTO CO_GESTION_COBEX_TO (1) - %s", LOG00, SQLERRM );
	  return -1;				
    }
		
	return iError;
} /* end ifnRegistraGestion */

/* ============================================================================= */
/*  ifnActualizaAgente: Funcion que actualiza entidad del cliente                */
/* ============================================================================= */
int ifnActualizaAgente(long pCodCliente, char *cAgente)
{	
   char        modulo[]="ifnActualizaAgente";
   int         iError = 0;                
                                                                                  
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   	char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

    long   lzCod_Cliente      ;      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);   
    memset(shCodEntidad,0,sizeof(shCodEntidad));    

    lzCod_Cliente   = pCodCliente;
    strcpy(shCodEntidad, cAgente);

    ifnTrazasLog( modulo, " shCodEntidad  [%s]" , LOG09,shCodEntidad);   
    ifnTrazasLog( modulo, " lzCod_Cliente [%ld]", LOG09,lzCod_Cliente);   

    if  (strcmp(shCodEntidad,NOASIGNADO )== 0) {
    
         /* EXEC SQL                       
         UPDATE CO_MOROSOS 
            SET COD_AGENTE = 'NO ASIGNADO' 
          WHERE COD_CLIENTE= :lzCod_Cliente; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 13;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE='NO ASIGNADO' wher\
e COD_CLIENTE=:b0";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )530;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)&lzCod_Cliente;
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



    } else {

         /* EXEC SQL                       
         UPDATE CO_MOROSOS 
            SET COD_AGENTE = :shCodEntidad
          WHERE COD_CLIENTE= :lzCod_Cliente; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 13;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIE\
NTE=:b1";
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )549;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqhstv[0] = (unsigned char  *)shCodEntidad;
         sqlstm.sqhstl[0] = (unsigned long )6;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&lzCod_Cliente;
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


	
	}

    if( SQLCODE != SQLOK) {
        ifnTrazasLog( modulo, "\t En UPDATE CO_MOROSOS - %s", LOG00, SQLERRM );
        return -1;				
    }

	return iError;
} /* end ifnActualizaAgente */

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

/* ============================================================================= */
/*  ifnGestionMora : Funcion que busca los clientes para gestion mora            */
/* ============================================================================= */
int ifnGestionMora(long i)
{	
   char        modulo[]="ifnGestionMora";
   int         iError = 0;                
   int         iRes   = 0;             

   iRes = ifnReasignar(i); 
   if( iRes < 0 ) return -1;

   iRes = ifnAsignar(i);
   if( iRes < 0 ) return -1;
   
   if( lIndClien > 0 ) { /* existen clientes por reasignar */
   	  
       iRes = ifnLlenaEstructuraCOBEX();
       if( iRes < 0 ) return -1;        	    	   	
       
       iRes = ifnClientesPendientes(i);
       if( iRes < 0 ) return -1;        	    	   	
    
   }
   
   return iError;	
	
} /* end ifnGestionMora */

/* ============================================================================= */
/*  ifnClientesPendientes :                                                      */
/* ============================================================================= */
int ifnClientesPendientes(int iIndice)
{	
    char    modulo[]="ifnClientesPendientes";
    int     iError = 0;                
    long    i;
    int     j;
    int     ihBuscoEntidad;
    int     iRes;
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
	char   shEntidadAntigua [6]; /* EXEC SQL VAR shEntidadAntigua IS STRING(6); */ 

	char   shEntidadGestion [6]; /* EXEC SQL VAR shEntidadGestion IS STRING(6); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                            
    ifnTrazasLog( modulo, "\n En funcion %s", LOG03,modulo);  

     /* Clientes pendientes a asignar */
    for (i=0;i<=lIndClien;i++)   {

        if (sthClien.iProcesado[i] == 0) {

            memset(shEntidadAntigua  ,0,sizeof(shEntidadAntigua  ));    
            ihBuscoEntidad = 0;
            iRes = ifnVerificaEmpresaAnterior(sthClien.lCodCliente[i], shEntidadAntigua);
            if( iRes < 0 ) {
                iError = -1;
                break;
            }
            
            ihBuscoEntidad = 0;                            	     
            if (strcmp(shEntidadAntigua,CARNULL)==0)  {
                 ihBuscoEntidad = 1;
            } else {
               	 strcpy(shEntidadGestion, shEntidadAntigua);
            }
    	    
            for (j=0;j<=lIndCobex;j++)   {
            
                if ((strcmp(shEntidadGestion,sthCobex.sCodAgente[j])==0) || (ihBuscoEntidad == 1))  {
            
	                if ((sthClien.iDiasMorosidad[i] > sthCobex.iDiasDesde[j]) && (sthClien.iDiasMorosidad[i] < sthCobex.iDiasHasta[j])){
	          	  	          	  
	               	    if ((sthCobex.dMtoPorAsignar[j] > sthClien.dDeudaCliente[i]) && ((sthCobex.dMtoPorAsignar[j] - sthClien.dDeudaCliente[i]) > 0)){
                          	                               	                                      	                
                          	   if (ihBuscoEntidad == 1)  {           
                          	       strcpy(shEntidadGestion, sthCobex.sCodAgente[j]);
                          	   } /* end if (ihBuscoEntidad == 1) */
                          	                                      	                           	                           	     
                               iRes = ifnRegistraGestion(sthClien.lCodCliente[i],MORA,sthParam.lNumSecuencia[iIndice], sthCobex.sCodRango[j], shEntidadGestion);
                               if( iRes < 0 ) {
                                   iError = -1;
                                   break;
                               }
                                
                               sthCobex.dMtoUtilizado [j]= sthCobex.dMtoUtilizado [j] + sthClien.dDeudaCliente[i];
                               sthCobex.dMtoPorAsignar[j]= sthCobex.dMtoPorAsignar[j] - sthClien.dDeudaCliente[i];  
                               sthClien.iProcesado[i] = 1;

                               break;                             
                                                                                               	
                        } /* end if ((sthCobex.dMtoPorAsignar[i] > dMonto)*/     
	          	    } /* end if ((sthCobex.iDiasHasta[j]*/	      	  
                } /* end if ((strcmp(shEntidadGestion,sthCobex.sCodAgente)==0) */
            } /* end for j*/
            
            if( iError < 0 ) {
                break;
            }

		} /* end if (sthClien.iProcesado[i] == 0) */
    } /* end for i*/
            
	return iError;
	
} /* end ifnClientesPendientes */

/* ============================================================================= */
/*  ifnReasignar :                                                               */
/* ============================================================================= */
int ifnReasignar(long i)
{	
   char        modulo[]="ifnReasignar";
   int         iError = 0;                
   int         iRes   = 0;             
                                         
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
    char   shCodRango   [6]; /* EXEC SQL VAR shCodRango   IS STRING(6); */ 

	char   shCodEntidad [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset(shCodRango,0,sizeof(shCodRango));                   
    strcpy(shCodRango,sthParam.sCodRango[i]);

    ifnTrazasLog( modulo, " shCodRango [%s]", LOG03,shCodRango);   
                                      
    /************************************************************************/
    /* Obtiene el Universo de entidades de cobranza por rangos              */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_Rangos CURSOR FOR
    SELECT A.COD_ENTIDAD
      FROM CO_ENTIDAD_RANGO_TD A, CO_RANGOS_COBEX_TD B, CO_ENTCOB C
     WHERE A.COD_RANGO   = :shCodRango
       AND A.COD_RANGO   = B.COD_RANGO
       AND A.COD_ENTIDAD = C.COD_ENTIDAD
       AND SYSDATE BETWEEN C.FEC_INI_VIGENCIA AND C.FEC_FIN_VIGENCIA; */ 


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Rangos - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_Rangos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0016;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )572;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shCodRango;
    sqlstm.sqhstl[0] = (unsigned long )6;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Rangos - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Rangos INTO :shCodEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )591;
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
		ifnTrazasLog( modulo, " Entidad [%s] ", LOG03, shCodEntidad);
                
	    if (ifnReasignacion(shCodEntidad, shCodRango, i) !=0 ) {
		    ifnTrazasLog( modulo, "Error en Llamada a ifnReasignacion().", LOG03 );
            iError = -1;
            break;        	    	   	
	    }
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Rangos; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )610;
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
	
} /* end ifnReasignar */


/* ============================================================================= */
/*  ifnAsignar                                                                   */
/* ============================================================================= */
int ifnAsignar(long i)
{	
   char        modulo[]="ifnAsignar";
   int         iSalir = FALSE;                                                            
   int         iError = 0;                
   int         iRes   = 0;             
   td_Entidad  stEnt;         
   double      dhMonto_Asig ;
   double      dhPorAsignar ;
   double      dhMontoUtilizado;   
   double      dhPrcAsignado;
                                         
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
    char   shCodRango   [6]; /* EXEC SQL VAR shCodRango   IS STRING(6); */ 

	char   shCodEntidad [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

    double dhPorcentaje    ;
    int    ihDiaInicial    ; 
    int    ihDiaFinal      ; 
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset(shCodRango,0,sizeof(shCodRango));                   
    strcpy(shCodRango,sthParam.sCodRango[i]);
            
    iRes = ifnMorosidadActual(shCodRango); 
    if( iRes < 0 ) return -1;        	    	   	
                          
    /************************************************************************/
    /* Obtiene el Universo de entidades de cobranza por rangos              */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_Rangos2 CURSOR FOR
    SELECT A.COD_ENTIDAD, A.PRC_ASIGNACION, B.DIA_INICIAL, B.DIA_FINAL  
      FROM CO_ENTIDAD_RANGO_TD A, CO_RANGOS_COBEX_TD B, CO_ENTCOB C
     WHERE A.COD_RANGO   = :shCodRango
       AND A.COD_RANGO   = B.COD_RANGO
       AND A.COD_ENTIDAD = C.COD_ENTIDAD
       AND SYSDATE BETWEEN C.FEC_INI_VIGENCIA AND C.FEC_FIN_VIGENCIA; */ 


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Rangos2 - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_Rangos2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0017;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )625;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shCodRango;
    sqlstm.sqhstl[0] = (unsigned long )6;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Rangos2 - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Rangos2 INTO :shCodEntidad, :dhPorcentaje, :ihDiaInicial, :ihDiaFinal; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )644;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&dhPorcentaje;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihDiaInicial;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihDiaFinal;
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


      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

		ifnTrazasLog( modulo, " =============================================================", LOG03);
		ifnTrazasLog( modulo, " Entidad [%s] - [%.2f]", LOG03, shCodEntidad,  dhPorcentaje);

        strcpy(stEnt.sCodAgente , shCodEntidad);
        stEnt.dPrcAsignado = dhPorcentaje;
        
        dhMonto_Asig    = 0.0;
        dhPrcAsignado   = 0.0;    
        dhMontoUtilizado= 0.0; 

        iRes = ifnMorosidadEntidad(dhPorcentaje, &dhMonto_Asig, &dhMontoUtilizado, &dhPorAsignar, shCodEntidad, shCodRango);
        
        if( iRes < 0 ) {
           iError = -1;
           break;        	    	   	
        } else  {
           stEnt.dMtoAsignado  = dhMonto_Asig;   
           stEnt.dMtoUtilizado = dhMontoUtilizado;
           stEnt.dMtoPorAsignar= dhPorAsignar;  
           stEnt.iDiasDesde    = ihDiaInicial;
           stEnt.iDiasHasta    = ihDiaFinal;           
        }        
                
        ifnTrazasLog( modulo, " stEnt.sCodAgente       [%s]", LOG09, stEnt.sCodAgente );
        ifnTrazasLog( modulo, " shCodRango             [%s]", LOG09, shCodRango );
        ifnTrazasLog( modulo, " stEnt.dMtoAsignado     [%.2f]", LOG09, stEnt.dMtoAsignado );
        ifnTrazasLog( modulo, " stEnt.dhMontoUtilizado [%.2f]", LOG09, stEnt.dMtoUtilizado );
        ifnTrazasLog( modulo, " stEnt.dMtoPorAsignar   [%.2f]", LOG09, stEnt.dMtoPorAsignar );
        ifnTrazasLog( modulo, " stEnt.iDiasDesde       [%d]", LOG09, stEnt.iDiasDesde );
        ifnTrazasLog( modulo, " stEnt.iDiasHasta       [%d]", LOG09, stEnt.iDiasHasta );

        /* Para clientes ya asignados a una entidad (0)*/                                                               
        if( stEnt.dMtoPorAsignar > 0.0 ) {
        	iRes = ifnAsignaEntidad(stEnt, i, shCodRango, 0);
            if( iRes < 0 ) {
               iError = -1;
               break;        	    	   	
            }
        }

        /* Para clientes que se encuentran como NO ASIGNADOS (1) */                                                               
        if( stEnt.dMtoPorAsignar > 0.0 ) {
        	iRes = ifnAsignaEntidad(stEnt, i, shCodRango, 1);
            if( iRes < 0 ) {
               iError = -1;
               break;        	    	   	
            }
        }
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Rangos2; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )675;
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
	
} /* end ifnAsignar */
     
/* ============================================================================= */
/*  ifnMorosidadActual : Funcion que obtiene la morosidad total en cobros        */
/* ============================================================================= */
int ifnMorosidadActual(char *sCodRango)
{	
   char  modulo[]="ifnMorosidadActual";
   int   iError  = 0;                
                     
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   char        shCodRango [6]; /* EXEC SQL VAR shCodRango IS STRING(6); */ 
                                       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                      
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    memset(shCodRango,0,sizeof(shCodRango));                   
    strcpy(shCodRango,sCodRango);
    ifnTrazasLog( modulo, " shCodRango [%s]", LOG09,shCodRango);                      
                       
    /* EXEC SQL                       
    SELECT NVL(SUM(DEU_VENCIDA),0)
      INTO :dzMorosidadTotal
      FROM CO_MOROSOS A, CO_RANGOS_COBEX_TD B, CO_ENTCOB C
     WHERE TRUNC(SYSDATE-A.FEC_INGRESO) BETWEEN B.DIA_INICIAL AND B.DIA_FINAL
       AND B.COD_RANGO = :shCodRango
       AND A.COD_AGENTE= C.COD_ENTIDAD
       AND SYSDATE BETWEEN C.FEC_INI_VIGENCIA AND C.FEC_FIN_VIGENCIA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(sum(DEU_VENCIDA),0) into :b0  from CO_MOROSOS \
A ,CO_RANGOS_COBEX_TD B ,CO_ENTCOB C where (((TRUNC((SYSDATE-A.FEC_INGRESO)) b\
etween B.DIA_INICIAL and B.DIA_FINAL and B.COD_RANGO=:b1) and A.COD_AGENTE=C.C\
OD_ENTIDAD) and SYSDATE between C.FEC_INI_VIGENCIA and C.FEC_FIN_VIGENCIA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )690;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dzMorosidadTotal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)shCodRango;
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


             
    if( SQLCODE != SQLOK) {
	  ifnTrazasLog( modulo, "\t En SELECT SUM(DEU_VENCIDA)  - %s", LOG00, SQLERRM );
	  return -1;				
    }

    ifnTrazasLog( modulo, " dzMorosidadTotal [%.2f]", LOG09,dzMorosidadTotal);                      
	
	return iError;
} /* end ifnMorosidadActual */
    
/* ============================================================================= */
/*  ifnMorosidadEntidad : Funcion que obtiene los montos de morosidad asignados  */
/*  por entidad                                                                  */
/* ============================================================================= */
int ifnMorosidadEntidad(double dPorcentaje, double *dAsignado, double *dUtilizado, double *dPorAsignar, char *cEntidad, char *sCodRango)
{	
   char        modulo[]="ifnMorosidadEntidad";
   int         iError = 0;                
   double      dhMonto_Asig ;
   double      dhPrcAsignado;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   double      dhMontoUtilizado;   
   char        shCodEntidad [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 
                                       
   char        shCodRango   [6]; /* EXEC SQL VAR shCodRango   IS STRING(6); */ 
                                       
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                  
   memset(shCodEntidad,0,sizeof(shCodEntidad));                                                                                             
   memset(shCodRango  ,0,sizeof(shCodRango));                                                                                             
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);     
                                  
   dhMontoUtilizado = 0.0;
   dhPrcAsignado    = 0.0;
   dhMonto_Asig     = 0.0;
                
   dhPrcAsignado = dPorcentaje;              
   dhMonto_Asig  = (dzMorosidadTotal * dhPrcAsignado )/100;              
   
   *dAsignado    = dhMonto_Asig;
                       
   strcpy(shCodEntidad, cEntidad);
   strcpy(shCodRango  , sCodRango);

   ifnTrazasLog( modulo, " shCodEntidad     [%s]", LOG09,shCodEntidad);                      
   ifnTrazasLog( modulo, " dhPrcAsignado    [%.2f]", LOG09,dhPrcAsignado);                      
   ifnTrazasLog( modulo, " dzMorosidadTotal [%.2f]", LOG09,dzMorosidadTotal);                      
                       
   /* EXEC SQL                       
   SELECT NVL(SUM(DEU_VENCIDA), 0)
     INTO :dhMontoUtilizado
     FROM CO_MOROSOS A, CO_RANGOS_COBEX_TD B, CO_ENTCOB C
    WHERE COD_AGENTE  = :shCodEntidad
      AND TRUNC(SYSDATE-A.FEC_INGRESO) BETWEEN B.DIA_INICIAL AND B.DIA_FINAL
      AND B.COD_RANGO = :shCodRango
      AND A.COD_AGENTE= C.COD_ENTIDAD
      AND SYSDATE BETWEEN C.FEC_INI_VIGENCIA AND C.FEC_FIN_VIGENCIA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(sum(DEU_VENCIDA),0) into :b0  from CO_MOROSOS A\
 ,CO_RANGOS_COBEX_TD B ,CO_ENTCOB C where ((((COD_AGENTE=:b1 and TRUNC((SYSDAT\
E-A.FEC_INGRESO)) between B.DIA_INICIAL and B.DIA_FINAL) and B.COD_RANGO=:b2) \
and A.COD_AGENTE=C.COD_ENTIDAD) and SYSDATE between C.FEC_INI_VIGENCIA and C.F\
EC_FIN_VIGENCIA)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )713;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhMontoUtilizado;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shCodEntidad;
   sqlstm.sqhstl[1] = (unsigned long )6;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)shCodRango;
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
	  ifnTrazasLog( modulo, "\t En SELECT SUM(DEU_VENCIDA) (1) - %s", LOG00, SQLERRM );
	  return -1;				
    }
		
	*dUtilizado = dhMontoUtilizado;
	*dPorAsignar= dhMonto_Asig - dhMontoUtilizado;

	ifnTrazasLog( modulo, " dAsignado   [%.2f]", LOG09,*dAsignado);                      
	ifnTrazasLog( modulo, " dUtilizado  [%.2f]", LOG09,*dUtilizado);                      
	ifnTrazasLog( modulo, " dPorAsignar [%.2f]", LOG09,*dPorAsignar);                      
	
	return iError;
} /* end ifnMorosidadEntidad */

/* ============================================================================= */
/*  ifnAsignaEntidad : Funcion que asigna clientes a entidades de cobranza de    */ 
/*  acuerdo al porcentaje asignado                                               */
/* ============================================================================= */
int ifnAsignaEntidad(td_Entidad st, int j, char *sCodRango, int iIndicador)
{
   char        modulo[]="ifnAsignaEntidad";
   int         iError  = 0;                
   static char szhQuery      [2048]; /* EXEC SQL VAR szhQuery     IS STRING(2048); */ 
   
   char        shMontoDesde     [8]; /* EXEC SQL VAR shMontoDesde IS STRING(8); */ 

   char        shMontoHasta     [8]; /* EXEC SQL VAR shMontoHasta IS STRING(8); */ 
   
   char        szhCicloFact     [3]; /* EXEC SQL VAR szhCicloFact IS STRING(3); */ 
   
   char        szhCategoria     [5]; /* EXEC SQL VAR szhCategoria IS STRING(5); */ 
   
   int         iSalir = FALSE;                                                            
   int         iRes       = 0;    
   int         iResValida = 0;       
   int         ihDiasMora    ;  
   double      dhDeudaCliente;
   int         ihRegGestion  ;
   double dhDeudaCliente2;
         
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   long        lzhCod_Cliente;   
   char        shCodRango       [6]; /* EXEC SQL VAR shCodRango       IS STRING(6); */ 

   char        shCodEntidadClie [6]; /* EXEC SQL VAR shCodEntidadClie IS STRING(6); */ 
   
   char        shEntidadAntigua [6]; /* EXEC SQL VAR shEntidadAntigua IS STRING(6); */ 
    
   char        shEntidadGestion [6]; /* EXEC SQL VAR shEntidadGestion IS STRING(6); */ 
    
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
         
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    memset(shCodRango,0,sizeof(sCodRango));   
    strcpy(shCodRango, sCodRango);
                                                                                          
    /************************************************************************/
    /* Obtiene el Universo de clientes con mora                             */
    /************************************************************************/   
    strcpy(szhQuery,"SELECT A.COD_CLIENTE ");
    strcat(szhQuery," FROM  GE_CLIENTES A ");
    strcat(szhQuery,"WHERE  EXISTS (SELECT 1 FROM CO_MOROSOS  C ");
    strcat(szhQuery," WHERE C.COD_CLIENTE = A.COD_CLIENTE  ");

    if  (iIndicador == 0) {
        strcat(szhQuery,"   AND C.COD_AGENTE  = '");
        strcat(szhQuery,st.sCodAgente);
        strcat(szhQuery,"' ");                
    } else {
        strcat(szhQuery,"   AND C.COD_AGENTE  = '");
        strcat(szhQuery,NOASIGNADO);
        strcat(szhQuery,"' ");        
    }

    if(( sthParam.dMontoDesde[j] == 0 ) && (sthParam.dMontoHasta[j] == 0 )) {
       sprintf(shMontoDesde,"%d",sthParam.dMontoDesde[j]);
       strcat(szhQuery," AND C.DEU_VENCIDA > ");
       strcat(szhQuery,(shMontoDesde));
       sprintf(shMontoHasta,"%d",sthParam.dMontoHasta[j]);
       strcat(szhQuery," AND C.DEU_VENCIDA < ");
       strcat(szhQuery,(shMontoHasta));
    }
    strcat(szhQuery,") ");
        
    strcat(szhQuery," AND NOT EXISTS (SELECT 1 FROM CO_GESTION_COBEX_TO D ");
    strcat(szhQuery," WHERE A.COD_CLIENTE = D.COD_CLIENTE ");
    strcat(szhQuery," AND D.FEC_TERMINO IS NULL ");     
    strcat(szhQuery," AND D.TIP_GESTION = '");     
    strcat(szhQuery,(szhMORA));
    strcat(szhQuery,"') ");   
    strcat(szhQuery," AND NOT EXISTS (SELECT 1 FROM CO_COBEX_INMUNE_TO E WHERE E.COD_CLIENTE = A.COD_CLIENTE) ");
        
    if( sthParam.lCicloFact[j] > 0 ) {
       sprintf(szhCicloFact,"%d",sthParam.lCicloFact[j]);
       strcat(szhQuery,"  AND A.COD_CICLO = ");
       strcat(szhQuery,szhCicloFact);
    }
        
    if  (strcmp(sthParam.sCodSegmento[j],CARNULL)!= 0) {
       strcat(szhQuery,"  AND A.COD_SEGMENTO = '");
       strcat(szhQuery,sthParam.sCodSegmento[j]);
       strcat(szhQuery,"'");
    }

    if( sthParam.iCodCategoria[j] > 0 ) {
       sprintf(szhCategoria,"%d",sthParam.iCodCategoria[j]);
       strcat(szhQuery,"  AND A.COD_CATEGORIA = ");
       strcat(szhQuery,szhCategoria);
    }

    if  (strcmp(sthParam.sCodCalifica[j],CARNULL )!= 0) {
       strcat(szhQuery,"  AND A.COD_CALIFICACION = '");
       strcat(szhQuery,sthParam.sCodCalifica[j]);
       strcat(szhQuery,"'");
    }
        
    ifnTrazasLog( modulo, " szhQuery - [%s]", LOG05,szhQuery );

    /* EXEC SQL PREPARE sql_cabecera_2 FROM :szhQuery; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )740;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhQuery;
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


    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR al PREPARAR QUERY Cur_ClientesMora", LOG05 );
        return SQLCODE;
    }

    /* EXEC SQL DECLARE Cur_ClientesMora CURSOR FOR sql_cabecera_2; */ 

    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR en DECLARE QUERY Cur_ClientesMora", LOG05 );
        return SQLCODE;
    }

    /* EXEC SQL OPEN Cur_ClientesMora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )759;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE)
    {
    	ifnTrazasLog( modulo, "\t ERROR en OPEN QUERY Cur_ClientesMora", LOG05 );
        return SQLCODE;
    }

    iSalir=FALSE;
    while(!iSalir)
    {    	
        /* EXEC SQL
        FETCH Cur_ClientesMora
         INTO :lzhCod_Cliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 13;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )774;
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
            ifnTrazasLog( modulo, "\tFETCH Cur_ClientesMora - %s", LOG00,SQLERRM );
            iError = -1;
            break;
        }

        if( SQLCODE == SQLNOTFOUND ) {
            break;
        }

        ifnTrazasLog( modulo, "\nlzhCod_Cliente [%ld]", LOG05, lzhCod_Cliente );

        ihRegGestion    = 0;
        dhDeudaCliente2 = 0.0;
        
        if(st.dMtoPorAsignar > 0) {    	   
           iResValida = ifnValidaCliente(lzhCod_Cliente, st, &dhDeudaCliente);
           if( iResValida < 0 ) {
              iError = -1;
              break;
           }

           if( iResValida == 0 ) {          
                    iRes = ifnDiasMorosidad(lzhCod_Cliente, &ihDiasMora);
                    if( iRes < 0 ) {
        	            iError = -1;        	    	   	
        	            break;
                    }
                
                    ifnTrazasLog( modulo, " ihDiasMora [%d]", LOG05, ihDiasMora );
                    ifnTrazasLog( modulo, " st.iDiasDesde [%d]", LOG05, st.iDiasDesde );
                    ifnTrazasLog( modulo, " st.iDiasHasta [%d]", LOG05, st.iDiasHasta );
                
                    if (ihDiasMora > 0) {
                                                                
                          if(( ihDiasMora > st.iDiasDesde  ) && ( ihDiasMora < st.iDiasHasta))  {
    
                               if  (iIndicador == 0) {  

                         	         strcpy(shEntidadGestion, st.sCodAgente);
                        	         ihRegGestion = 1;  

                               } else { /* Clientes No Asignado */

                            	     iRes = ifnVerificaEmpresaAnterior(lzhCod_Cliente, shEntidadAntigua);
                                     if( iRes < 0 ) {
                                         iError = -1;
                                         break;
                                     }
                            	     
                            	     if (strcmp(shEntidadAntigua,CARNULL)==0)  { 
                           	             strcpy(shEntidadGestion, st.sCodAgente);
                           	             ihRegGestion = 1;
                           	         } else  {
                            	                                 	     
                            	         if (strcmp(shEntidadAntigua,st.sCodAgente)==0)  { 
                           	                strcpy(shEntidadGestion, shEntidadAntigua);
                           	                ihRegGestion = 1;
                           	             } else  {
                           	           	    ihRegGestion = 0;
                           	             }
                           	            
                            	     } /* end if (strcmp(shEntidadAntigua,CARNULL)==0)*/
                            	     
                               } /* end if  (iIndicador == 0) */
                                                              
                               /* Registra Gestion de Cobranza */
                               if  (ihRegGestion == 1) {  

                                   iRes = ifnRegistraGestion(lzhCod_Cliente,MORA,sthParam.lNumSecuencia[j], shCodRango, shEntidadGestion);
                                   if( iRes < 0 ) {
                                       iError = -1;
                                       break;
                                   }
                             
                                   st.dMtoUtilizado = st.dMtoUtilizado  + dhDeudaCliente;
                                   st.dMtoPorAsignar= st.dMtoPorAsignar - dhDeudaCliente;  
                                   
                                   iRes = ifnVerificaClienteArray(lzhCod_Cliente);
                                   
                               } /* end if  (ihRegGestion == 0) */ 
                             
                           }  /* end if(( st.iDiasDesde  > ihDiasMora ) && ( st.iDiasDesde < ihDiasMora)) */   
                    
                    } else {
                	
                	     ifnTrazasLog( modulo, " Cliente no se encuentra moroso (1)...", LOG05 );            	   
                	                         
                    } /* end if (ihDiasMora > 0) */
                     
                 
            } else  {
            	
            	if(iResValida == 2) {
            	   ifnTrazasLog( modulo, " Cliente no tiene deuda ...", LOG05 );            	   
            	} else {
            	   ifnTrazasLog( modulo, " Cliente debe ser reasignado...", LOG05 );    
            	               	   
                   iRes = ifnDiasMorosidad(lzhCod_Cliente, &ihDiasMora);
                   if( iRes < 0 ) {
        	           iError = -1;        	    	   	
        	           break;
                   }
                
                   ifnTrazasLog( modulo, " ihDiasMora [%d]", LOG05, ihDiasMora );
                
                   if (ihDiasMora > 0) {

                       iRes = ifnExisteClienteArray(lzhCod_Cliente);
            	       if (iRes == 1) {
            	          sthClien.lCodCliente   [lIndClien] = lzhCod_Cliente;
           	              sthClien.dDeudaCliente [lIndClien] = dhDeudaCliente;            	   
            	          sthClien.iDiasMorosidad[lIndClien] = ihDiasMora;
            	          sthClien.iProcesado    [lIndClien] = 0;
            	          lIndClien = lIndClien + 1;
            	       }
            	       
            	   } else {
            	       ifnTrazasLog( modulo, " Cliente no se encuentra moroso (2)...", LOG05 );            	   
            	   } /* end if (ihDiasMora > 0) */
            	   
            	}
            	ifnTrazasLog( modulo, "\n - - - - - - - - - - - - - - - - - - - - - - - - ", LOG05);   
            	
            }/* end if( iResValida) */
        } else {
            break;	      
        } /* end if(st.dMtoPorAsignar > 0) */        
    } /* fin while cursor Cur_ClientesMora */

    /* EXEC SQL
    CLOSE Cur_ClientesMora; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )793;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tCLOSE Cur_ClientesMora - %s", LOG00, SQLERRM );
        iError = -1;
    }
				
    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )808;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if (SQLCODE) {
        ifnTrazasLog( modulo, "\tError al realizar COMMIT - %s", LOG00, SQLERRM );
        iError = -1;
    }                            
	
	return iError;
} /* end ifnAsignaEntidad */

/* ============================================================================= */
/*  ifnExisteClienteArray                                                      */
/* ============================================================================= */
int ifnExisteClienteArray(long pCodCliente)
{	
   char  modulo[]="ifnVerificaClienteArray";
   long  lhCodCliente  ;
   int   iRes = 0;
   int   i;
   
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
   lhCodCliente = pCodCliente;              

   for (i=0;i<=lIndClien;i++)   {
      if (sthClien.lCodCliente[i] == lhCodCliente) {
      	  iRes = 1;
      	  break;
      }
   } /* end for */
	           	
   return iRes;
} /* end ifnVerificaClienteArray */

/* ============================================================================= */
/*  ifnVerificaClienteArray                                                      */
/* ============================================================================= */
int ifnVerificaClienteArray(long pCodCliente)
{	
   char  modulo[]="ifnVerificaClienteArray";
   long  lhCodCliente  ;
   int   iError = 0;
   int   i;
   
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
   lhCodCliente = pCodCliente;              

   for (i=0;i<=lIndClien;i++)   {
      if (sthClien.lCodCliente[i] == lhCodCliente) {
      	  sthClien.iProcesado[i] = 1;
      	  break;
      }
   } /* end for */
	           	
   return iError;
} /* end ifnVerificaClienteArray */


/* ============================================================================= */
/*  ifnVerificaEmpresaAnterior                                                   */
/* ============================================================================= */
int ifnVerificaEmpresaAnterior(long pCodCliente, char *sEntidadAntigua)
{	
   char  modulo[]="ifnVerificaEmpresaAnterior";
   int   iError = 0;      

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
   long     lhCodCliente    ;
   char     shEntidadCob [6]; /* EXEC SQL VAR shEntidadCob IS STRING(6); */ 
      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
   lhCodCliente = pCodCliente;              
   
   ifnTrazasLog( modulo, " lhCodCliente [%ld]", LOG09, lhCodCliente);                      
                          
   /* EXEC SQL                       
   SELECT NVL(B.COD_AGENTE, '-1')
     INTO :shEntidadCob
     FROM CO_MOROSOS A, CO_HMOROSOS B, CO_ENTCOB D  
    WHERE A.COD_CLIENTE = :lhCodCliente 
      AND A.COD_CLIENTE = B.COD_CLIENTE 
      AND B.FEC_HISTORICO = (SELECT MAX(FEC_HISTORICO) FROM CO_HMOROSOS C 
                              WHERE C.COD_CLIENTE = B.COD_CLIENTE
                                AND C.COD_AGENTE <> 'NO ASIGNADO')
      AND B.COD_AGENTE = D.COD_ENTIDAD                                 
      AND SYSDATE BETWEEN D.FEC_INI_VIGENCIA AND D.FEC_FIN_VIGENCIA; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select NVL(B.COD_AGENTE,'-1') into :b0  from CO_MOROSOS A \
,CO_HMOROSOS B ,CO_ENTCOB D where ((((A.COD_CLIENTE=:b1 and A.COD_CLIENTE=B.CO\
D_CLIENTE) and B.FEC_HISTORICO=(select max(FEC_HISTORICO)  from CO_HMOROSOS C \
where (C.COD_CLIENTE=B.COD_CLIENTE and C.COD_AGENTE<>'NO ASIGNADO'))) and B.CO\
D_AGENTE=D.COD_ENTIDAD) and SYSDATE between D.FEC_INI_VIGENCIA and D.FEC_FIN_V\
IGENCIA)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )823;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shEntidadCob;
   sqlstm.sqhstl[0] = (unsigned long )6;
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

                                
                                          
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	  ifnTrazasLog( modulo, "\t En SELECT B.COD_AGENTE - %s", LOG00, SQLERRM );
	  return -1;				
   }
   
   if( SQLCODE  == SQLNOTFOUND) {
      strcpy(shEntidadCob, CARNULL); 
   }   
           	
   strcpy(sEntidadAntigua, shEntidadCob); 

   ifnTrazasLog( modulo, " sEntidadAntigua [%s]", LOG09, sEntidadAntigua);                      
           	
   return iError;
} /* end ifnVerificaEmpresaAnterior */

/* ============================================================================= */
/*  ifnValidaCliente : Funcion valida si el cliente puede ser asignado a la      */
/*  entidad de cobranza de turno                                                 */
/* ============================================================================= */
int ifnValidaCliente(long pCodCliente, td_Entidad stEnt, double *dDeudaCliente)
{	
   char  modulo[]="ifnValidaCliente";
   int   iError = 0;      
   int   iRes   = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
     long        lhCodCliente  ;
     double      dhDeudaCliente;   
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
   lhCodCliente = pCodCliente;              
   
   ifnTrazasLog( modulo, " lhCodCliente [%ld]", LOG09, lhCodCliente);                      
                          
   if( !bfnGetSaldoVencido( lhCodCliente, &dhDeudaCliente ))	{   
 		 return -1;
   }

   ifnTrazasLog( modulo, " stEnt.dMtoPorAsignar [%.2f]", LOG09,stEnt.dMtoPorAsignar);                      
   ifnTrazasLog( modulo, " dhDeudaCliente [%.2f]", LOG09,dhDeudaCliente);                      

   if(stEnt.dMtoPorAsignar >=  dhDeudaCliente) {    	   
       iError = 0;         	   
       *dDeudaCliente = dhDeudaCliente;
   } 
   if(stEnt.dMtoPorAsignar <  dhDeudaCliente) {    	   
       iError = 1;         	   
       *dDeudaCliente = dhDeudaCliente;
   } 

   if(dhDeudaCliente == 0.0) {    	   
       iError = 2;         	   
       *dDeudaCliente = 0.0;
   } 
           	
   return iError;
} /* end ifnValidaCliente */

/* ============================================================================= */
/*  ifnDeudaCliente :                                                            */
/* ============================================================================= */
int ifnDeudaCliente(long pCodCliente, double *dDeuda)
{	
   char        modulo[]="ifnDeudaCliente";
   int         iError = 0;                

/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                           
     long        lhCodCliente  ;
     double      dhDeudaCliente;   
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
                                                                                         
   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
   lhCodCliente = pCodCliente;              
                       
   /* EXEC SQL                       
   SELECT DEU_VENCIDA
     INTO :dhDeudaCliente
     FROM CO_MOROSOS
    WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DEU_VENCIDA into :b0  from CO_MOROSOS where COD_CLI\
ENTE=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )846;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&dhDeudaCliente;
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
	  ifnTrazasLog( modulo, "\t En SELECT SUM(DEU_VENCIDA) (2) - %s", LOG00, SQLERRM );
	  return -1;				
   }
	           	
   *dDeuda = dhDeudaCliente;
   return iError;
} /* end ifnDeudaCliente */

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
