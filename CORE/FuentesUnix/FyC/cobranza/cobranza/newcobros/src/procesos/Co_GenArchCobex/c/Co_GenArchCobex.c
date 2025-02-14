
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
    "./pc/Co_GenArchCobex.pc"
};


static unsigned int sqlctx = 442246187;


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
   unsigned char  *sqhstv[26];
   unsigned long  sqhstl[26];
            int   sqhsts[26];
            short *sqindv[26];
            int   sqinds[26];
   unsigned long  sqharm[26];
   unsigned long  *sqharc[26];
   unsigned short  sqadto[26];
   unsigned short  sqtdso[26];
} sqlstm = {12,26};

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
"select B.COD_CLIENTE ,B.NUM_SECUENCIA  from CO_PARAM_COBEX_TO A ,CO_GESTION_\
COBEX_TO B where (((B.COD_ENTIDAD=:b0 and A.COD_ESTADO in (:b1,:b2)) and A.NUM\
_SECUENCIA=B.NUM_SECUENCIA) and B.FEC_TERMINO is null ) order by A.COD_ENTIDAD\
            ";

 static const char *sq0008 = 
"select NUM_FOLIO ,sum((IMPORTE_DEBE-IMPORTE_HABER)) ,TO_CHAR(min(FEC_VENCIMI\
E),'DDMMYYYY')  from CO_CARTERA where ((COD_CLIENTE=:b0 and IND_FACTURADO=:b1)\
 and COD_CONCEPTO not  in (:b2,:b3)) group by NUM_FOLIO           ";

 static const char *sq0009 = 
"select  /*+  RULE  +*/ NUM_CELULAR ,NVL(COD_PRESTACION,'-1')  from GA_ABOCEL\
 where (COD_SITUACION not  in (:b0,:b1) and COD_CLIENTE=:b2)           ";

 static const char *sq0011 = 
"select A.COD_CLIENTE ,C.DES_VALOR  from GA_ABOCEL A ,GE_PRESTACIONES_TD B ,(\
select COD_VALOR ,DES_VALOR  from GED_CODIGOS where ((NOM_TABLA=:b0 and NOM_CO\
LUMNA=:b1) and COD_MODULO=:b2)) C where ((A.COD_PRESTACION=B.COD_PRESTACION an\
d B.GRP_PRESTACION=C.COD_VALOR) and A.COD_CLIENTE=:b3)           ";

 static const char *sq0026 = 
"select COD_ENTIDAD  from CO_ENTCOB where SYSDATE between FEC_INI_VIGENCIA an\
d FEC_FIN_VIGENCIA order by COD_ENTIDAD            ";

 static const char *sq0027 = 
"select NUM_SECUENCIA ,NVL(COD_ENTIDAD,'-1')  from CO_PARAM_COBEX_TO where CO\
D_ESTADO in (:b0,:b1) order by NUM_SECUENCIA            ";

 static const char *sq0028 = 
"select B.COD_CLIENTE ,B.COD_ENTIDAD  from CO_PARAM_COBEX_TO A ,CO_GESTION_CO\
BEX_TO B where (A.NUM_SECUENCIA=:b0 and A.NUM_SECUENCIA=B.NUM_SECUENCIA)      \
     ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,1,0,0,
5,0,0,1,67,0,4,114,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
28,0,0,2,61,0,5,131,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
51,0,0,3,0,0,29,142,0,0,0,0,0,1,0,
66,0,0,4,68,0,6,298,0,0,2,2,0,1,0,2,5,0,0,1,5,0,0,
89,0,0,5,0,0,29,455,0,0,0,0,0,1,0,
104,0,0,6,140,0,9,497,0,0,0,0,0,1,0,
119,0,0,6,0,0,13,505,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
142,0,0,6,0,0,15,570,0,0,0,0,0,1,0,
157,0,0,7,244,0,9,616,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,
184,0,0,7,0,0,13,624,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
207,0,0,7,0,0,15,668,0,0,0,0,0,1,0,
222,0,0,8,220,0,9,742,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
253,0,0,8,0,0,13,750,0,0,3,0,0,1,0,2,3,0,0,2,4,0,0,2,5,0,0,
280,0,0,8,0,0,15,776,0,0,0,0,0,1,0,
295,0,0,9,147,0,9,857,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
322,0,0,9,0,0,13,865,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
345,0,0,9,0,0,15,899,0,0,0,0,0,1,0,
360,0,0,10,80,0,4,927,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
383,0,0,11,297,0,9,986,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,3,0,0,
414,0,0,11,0,0,13,994,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
437,0,0,11,0,0,15,1019,0,0,0,0,0,1,0,
452,0,0,12,698,0,4,1062,0,0,26,11,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,
5,0,0,1,3,0,0,
571,0,0,13,74,0,4,1165,0,0,2,1,0,1,0,2,5,0,0,1,5,0,0,
594,0,0,14,151,0,4,1204,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
617,0,0,15,85,0,4,1246,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
640,0,0,16,66,0,4,1286,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
663,0,0,17,179,0,4,1301,0,0,3,1,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,
690,0,0,18,608,0,4,1349,0,0,6,2,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
1,3,0,0,
729,0,0,19,272,0,4,1376,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
756,0,0,20,183,0,4,1422,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
779,0,0,21,185,0,4,1438,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
802,0,0,22,223,0,4,1479,0,0,7,4,0,1,0,2,3,0,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,3,0,0,
845,0,0,23,236,0,4,1523,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
876,0,0,24,195,0,4,1541,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
911,0,0,25,196,0,4,1559,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,
946,0,0,26,127,0,9,1620,0,0,0,0,0,1,0,
961,0,0,26,0,0,13,1629,0,0,1,0,0,1,0,2,5,0,0,
980,0,0,26,0,0,15,1649,0,0,0,0,0,1,0,
995,0,0,27,132,0,9,1692,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
1018,0,0,27,0,0,13,1701,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
1041,0,0,27,0,0,15,1739,0,0,0,0,0,1,0,
1056,0,0,28,159,0,9,1781,0,0,1,1,0,1,0,1,3,0,0,
1075,0,0,28,0,0,13,1789,0,0,2,0,0,1,0,2,3,0,0,2,5,0,0,
1098,0,0,29,59,0,5,1803,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
1121,0,0,28,0,0,15,1815,0,0,0,0,0,1,0,
1136,0,0,30,68,0,5,1846,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
};


/* ================================================================================================================ */
/*
   Tipo        :  COLA DE PROCESO
   Nombre      :  Co_GenArchCobex.pc
   Parametros  :  Usuario/Password. ( por defecto asume los de la cuenta )
                  Nivel de Log ( por defecto asume 3 : Log Normal ) 
                  Nombre de la Cola (Opcional), para nombrar archivos de log
   Autor       :  
   Fecha       :  01-Septiembre-2009
*/ 
/* ================================================================================================================ */
#define _COLIBGENERALES_PC_
#define _COLIBPROCESOS_PC_

#include "Co_GenArchCobex.h"

LINEACOMANDO  	stLineaComando;     		/* Datos con los que se invoco al proceso */
char 			szgCodProceso[6]  = "";
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

    char    szhGacob              [6]; /* EXEC SQL VAR szhGacob              IS STRING (6); */ 

    char    szhWait               [2]; /* EXEC SQL VAR szhWait               IS STRING (2); */ 

    char    szhYYYYMMDD           [9]; /* EXEC SQL VAR szhYYYYMMDD           IS STRING (9); */ 

    char    szFechayyyymmdd       [9]; /* EXEC SQL VAR szFechayyyymmdd       IS STRING (9); */ 
    
    char    szVIS                 [4]; /* EXEC SQL VAR szVIS                 IS STRING (4); */ 
   
    char    szREA                 [4]; /* EXEC SQL VAR szREA                 IS STRING (4); */ 
   
    char    szMOROSOS            [11]; /* EXEC SQL VAR szMOROSOS             IS STRING(11); */ 
   
    char    szCLIENTES           [12]; /* EXEC SQL VAR szCLIENTES            IS STRING(12); */ 
       
    char    szGCATEGORIAS        [14]; /* EXEC SQL VAR szGCATEGORIAS         IS STRING(14); */ 
       
    char    szGPRESTACIONES      [19]; /* EXEC SQL VAR szGPRESTACIONES       IS STRING(19); */ 
       
    char    szCATEGORIA          [14]; /* EXEC SQL VAR szCATEGORIA           IS STRING(14); */ 
       
    char    szSEGMENTO           [13]; /* EXEC SQL VAR szCATEGORIA           IS STRING(13); */ 
           
    char    szPRESTACION         [15]; /* EXEC SQL VAR szPRESTACION          IS STRING(15); */ 
           
    char    szhBAA                [4]; /* EXEC SQL VAR szhBAA                IS STRING (4); */ 
    
    char    szhBAP                [4]; /* EXEC SQL VAR szhBAP                IS STRING (4); */ 
    
    char    szhTM                 [3]; /* EXEC SQL VAR szhTM                 IS STRING (3); */ 
    
    char    szhNULL               [2]; /* EXEC SQL VAR szhNULL               IS STRING (2); */ 
    
    char    szhGA                 [3]; /* EXEC SQL VAR szhGA                 IS STRING (3); */ 
      
    char    szhACTIVO             [7]; /* EXEC SQL VAR szhACTIVO             IS STRING (7); */ 
      
    char    szhBAJA               [5]; /* EXEC SQL VAR szhBAJA               IS STRING (5); */ 
            
    char    szhSININFORMACION    [16]; /* EXEC SQL VAR szhSININFORMACION     IS STRING(16); */ 
            
    char    szhSI                 [4]; /* EXEC SQL VAR szhSI                 IS STRING (4); */ 
            
    char    szhYYYY               [5]; /* EXEC SQL VAR szhYYYY               IS STRING (5); */ 
            
    int     ihUno                    ;
    int     ihDos                    ;
    int     ihSeis                   ;
/* EXEC SQL END DECLARE SECTION; */ 


td_Detafac     sthDetafac;          /* Estructura de Archivo DETAFAC             */
td_Facturas    sthFactura;          /* Estructura de Archivo FACTURAS            */
td_Cuentas     sthCuentas;          /* Estructura de Archivo CUENTAS             */    
td_Telefonos   sthTelefono;         /* Estructura de Archivo TELEFONOS           */    
td_TelesCuenta sthTCuentas;         /* Estructura de Archivo TELESCUENTA         */    

long        lIndDetafac;            /* Indice de archivos DETAFAC                */
long        lIndFactura;            /* Indice de archivos FACTURAS               */
long        lIndCuentas;            /* Indice de archivos CUENTAS                */
long        lIndTelefon;            /* Indice de archivos TELEFONOS              */
long        lIndTeleCta;            /* Indice de archivos TELESCUENTAS           */

/* ============================================================================= */
/*  main                                                                         */
/* ============================================================================= */
int main( int argc, char *argv[] )
{
char modulo[] = "main";
int iResult = 0;

    fprintf(stdout, "\n%s GACOB pid(%ld) VERSION [%s]\n", szGetTime(1),getpid(),szVERSION);
    fflush (stdout);

    /*- Inicializacion de parametros  -*/    
    memset(szgCodProceso,0,sizeof(szgCodProceso));    
    strcpy(szgCodProceso,"GACOB"); 
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
		            WHERE COD_PROCESO=:szhGacob; */ 

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
     sqlstm.sqhstv[1] = (unsigned char  *)szhGacob;
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
		                     WHERE COD_PROCESO = :szhGacob; */ 

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
                      sqlstm.sqhstv[1] = (unsigned char  *)szhGacob;
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

    
    strcpy(szhGacob         ,GACOB);
  	strcpy(szhYYYYMMDD      ,"YYYYMMDD");
    strcpy(szhWait          ,W );
    strcpy(szVIS            ,VIS);
    strcpy(szREA            ,REA);
    strcpy(szMOROSOS        ,CO_MOROSOS);
    strcpy(szCLIENTES       ,GE_CLIENTES);
    strcpy(szGCATEGORIAS    ,GE_CATEGORIAS);
    strcpy(szGPRESTACIONES  ,GE_PRESTACIONES_TD);
    strcpy(szCATEGORIA      ,COD_CATEGORIA);    
    strcpy(szSEGMENTO       ,COD_SEGMENTO);
    strcpy(szPRESTACION     ,GRP_PRESTACION);
    strcpy(szhBAA           ,BAA);
    strcpy(szhBAP           ,BAP);
    strcpy(szhTM            ,TM);
    strcpy(szhNULL          ,NULO);
    strcpy(szhGA            ,GA);
    strcpy(szhACTIVO        ,ACTIVO);
    strcpy(szhBAJA          ,BAJA);
    strcpy(szhSININFORMACION,SIN_INFORMACION);    
    strcpy(szhSI            ,SI);    
    strcpy(szhYYYY          ,"YYYY");
                                                                                                 
    ihUno = UNO;
    ihDos = DOS;
    ihSeis= SEIS;
    
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


	
	lIndDetafac = 0;
    lIndFactura = 0;
    lIndCuentas = 0;
    lIndTelefon = 0;
    lIndTeleCta = 0;

	sprintf(stStatus.szFileName   ,"%s",szgCodProceso);
	sprintf(szhPathLogSched       ,"%s/CO_SCHEDULER",getenv("XPC_LOG"));    
	sprintf(stStatus.szLogPathGene,"%s",szhPathLogSched);
    
  	pathDir =(char *)malloc(228);
	pathDir =szGetEnv("HOME");

    sprintf(szPathDat  ,"%s/newcobros/dat/ArchivosCOBEX/%s",pathDir,szFechayyyymmdd);
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
	ifnTrazasLog(modulo,"GACOB VERSION [%s]\n",LOG03, szVERSION);
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
	
	if (ifnGeneraUnivArchCob() !=0 ) {
		ifnTrazasLog( modulo, "Error en Llamada a ifnGeneraUnivArchCob().", LOG03 );
		return -1;
	}		
	
	/* Informacion Estadistica */
	sprintf( szFinProc, "%s", szSysDate( "HH24:MI:SS" ) );    
	if( (iDifSegs=ifnRestaHoras(szIniProc,szFinProc,szTmpProc)) >= 0 )	{
	    ifnTrazasLog(modulo,"\n\tRESUMEN DEL PROCESO GACOB"
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
/*  ifnGeneraUniverso() : Funcion que rescata los datos de la empresa de cobranza*/
/* ============================================================================= */
int ifnGeneraUniverso()
{
char modulo[]   = "ifnGeneraUniverso";
int  iError     = 0;     
int  iRes       = 0;    

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   char   shDesEntidad   [31]; /* EXEC SQL VAR shDesEntidad IS STRING(31); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

   ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      

    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_UniCob CURSOR for        
    SELECT COD_ENTIDAD, DES_ENTIDAD
      FROM CO_ENTCOB 
     WHERE SYSDATE BETWEEN FEC_INI_VIGENCIA AND FEC_FIN_VIGENCIA                                     
     ORDER BY COD_ENTIDAD ; */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_UniCob - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_UniCob; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )104;
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
        sqlstm.arrsiz = 2;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )119;
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
	    	    	    	    
        /* Inicializacion de Array por Tipo de Archivos */
        /* Archivo DETAFAC */
        strcpy(sthDetafac.sCodAgente[lIndDetafac], shCodEntidad);
        sthDetafac.lNumRegistr[lIndDetafac] = 0;
        
        /* Archivo FACTURA */        
        strcpy(sthFactura.sCodAgente[lIndFactura], shCodEntidad);
        sthFactura.lNumRegistr[lIndFactura] = 0;
        
        /* Archivo CUENTAS */        
        strcpy(sthCuentas.sCodAgente[lIndCuentas], shCodEntidad);
        sthCuentas.lNumRegistr[lIndCuentas] = 0;
                       
        /* Archivo TELEFONOS */
        strcpy(sthTelefono.sCodAgente[lIndTelefon], shCodEntidad);
        sthTelefono.lNumRegistr[lIndTelefon] = 0;
                                              
        /* Archivo TELESCUENTA */
        strcpy(sthTCuentas.sCodAgente[lIndTeleCta], shCodEntidad);
        sthTCuentas.lNumRegistr[lIndTeleCta] = 0;
                                                                                                                                          
        lIndDetafac = lIndDetafac + 1;
        lIndFactura = lIndFactura + 1;
        lIndCuentas = lIndCuentas + 1;
        lIndTelefon = lIndTelefon + 1;
        lIndTeleCta = lIndTeleCta + 1;
                             
        iRes = ifnGeneraDetalle(shCodEntidad);
        if( iRes < 0 ) break;        	    	   	                                                            
                                           
        /* Fin de registro por Entidad de Cobranza */
        lIndDetafac = lIndDetafac + 1;
        lIndFactura = lIndFactura + 1;
        lIndCuentas = lIndCuentas + 1;
        lIndTelefon = lIndTelefon + 1;
        lIndTeleCta = lIndTeleCta + 1;

        sthDetafac.lNumRegistr[lIndDetafac] = -1;
        sthFactura.lNumRegistr[lIndFactura] = -1; 
        sthCuentas.lNumRegistr[lIndCuentas] = -1; 
        sthTelefono.lNumRegistr[lIndTelefon] = -1; 
        sthTCuentas.lNumRegistr[lIndTeleCta] = -1; 

        strcpy(sthDetafac.sCodAgente[lIndDetafac], shCodEntidad);        
        strcpy(sthFactura.sCodAgente[lIndFactura], shCodEntidad);
        strcpy(sthCuentas.sCodAgente[lIndCuentas], shCodEntidad);
        strcpy(sthTelefono.sCodAgente[lIndTelefon], shCodEntidad);
        strcpy(sthTCuentas.sCodAgente[lIndTeleCta], shCodEntidad);

	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_UniCob; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )142;
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
/*  ifnGeneraDetalle() : Funcion que busca el detalle por tipo de archivo        */
/* ============================================================================= */
int ifnGeneraDetalle(char *phCodEntidad)
{
char modulo[]   = "ifnGeneraDetalle";
int  iError     = 0;     
int  iRes       = 0;    

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lhCodCliente     ;
   char   shCodEntidad  [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   long   lhNumSecuencia   ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    strcpy(shCodEntidad, phCodEntidad);

    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_Det CURSOR for        
    SELECT B.COD_CLIENTE, B.NUM_SECUENCIA 
      FROM CO_PARAM_COBEX_TO A, CO_GESTION_COBEX_TO B
     WHERE B.COD_ENTIDAD  = :shCodEntidad
       AND A.COD_ESTADO IN  (:szVIS, :szREA)
       AND A.NUM_SECUENCIA= B.NUM_SECUENCIA  
       AND B.FEC_TERMINO IS NULL     
     ORDER BY A.COD_ENTIDAD ; */ 
 

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Det - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_Det; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )157;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shCodEntidad;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szVIS;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szREA;
    sqlstm.sqhstl[2] = (unsigned long )4;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Det - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Det INTO :lhCodCliente, :lhNumSecuencia; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )184;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
	        ifnTrazasLog( modulo, "\t No existen mas registros a procesar...", LOG03 );
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

        ifnTrazasLog( modulo, " - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -", LOG05);
        ifnTrazasLog( modulo, "Cliente - Secuencia [%ld] - [%ld]", LOG05, lhCodCliente, lhNumSecuencia);
	    	    	    	    	 
        strcpy(sthDetafac.sCodAgente[lIndDetafac], shCodEntidad);
        sthDetafac.lCodCliente  [lIndDetafac] = lhCodCliente;
        sthDetafac.lNumSecuencia[lIndDetafac] = lhNumSecuencia;
        
        iRes = ifnDetalleDETAFAC(lhCodCliente);
        if( iRes < 0 ) break;        	    	   	

        iRes = ifnDetalleFACTURA(lhCodCliente, shCodEntidad, lhNumSecuencia);
        if( iRes < 0 ) break;        	    	   	

        strcpy(sthCuentas.sCodAgente[lIndCuentas], shCodEntidad);
        sthCuentas.lCodCliente  [lIndCuentas] = lhCodCliente;
        sthCuentas.lNumSecuencia[lIndCuentas] = lhNumSecuencia;

        iRes = ifnDetalleCUENTAS(lhCodCliente);
        if( iRes < 0 ) break;        	    	   	

        iRes = ifnDetalleTELEFONOS(lhCodCliente, shCodEntidad, lhNumSecuencia);
        if( iRes < 0 ) break;        	    	   	

        iRes = ifnDetalleTELESCUENTA(lhCodCliente, shCodEntidad, lhNumSecuencia);
        if( iRes < 0 ) break;   
     
        lIndDetafac = lIndDetafac + 1;        
        lIndCuentas = lIndCuentas + 1;
        lIndTelefon = lIndTelefon + 1;
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Det; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )207;
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
  
} /* end ifnGeneraDetalle() */

/* ============================================================================= */
/*  ifnDetalleDETAFAC : Funcion que busca el detalle para el archivo DETAFAC     */
/* ============================================================================= */
int ifnDetalleDETAFAC(long lhCodCliente)
{
char  modulo[]   = "ifnDetalleDETAFAC";
int   iError     = 0;     
int   iRes       = 0;    
long  lCodCliente   ;

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    lCodCliente = lhCodCliente;

    iRes = ifnBuscaClasificacion(lCodCliente);
    if( iRes < 0 ) return -1;        	    

    iRes = ifnBuscaMontoDocMora(lCodCliente);
    if( iRes < 0 ) return -1;        	    

    iRes = ifnBuscaProducto(lCodCliente);
    if( iRes < 0 ) return -1;        	    
               	
    sthDetafac.lNumRegistr[lIndDetafac] = lIndDetafac;
                       	
    return iError;
  
} /* end ifnDetalleDETAFAC() */

/* ============================================================================= */
/*  ifnDetalleFACTURA : Funcion que busca las facturas en mora del cliente       */
/* ============================================================================= */
int ifnDetalleFACTURA(long lhCodCliente, char *sCodEntidad, long lSecuencia)
{
char    modulo[]   = "ifnDetalleFACTURA";
int     iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente      ;
   char   shCodEntidad  [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   long   lhNumFolio       ;
   double dhSaldoFactura   ;
   char   shFecVence    [9]; /* EXEC SQL VAR shFecVence    IS STRING(9); */ 

   long   lhNumSecuencia   ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    lCodCliente   = lhCodCliente;
    lhNumSecuencia= lSecuencia;
    strcpy(shCodEntidad, sCodEntidad);

    /* EXEC SQL DECLARE Cur_Fact CURSOR for        
    SELECT NUM_FOLIO, SUM(IMPORTE_DEBE-IMPORTE_HABER), TO_CHAR(MIN(FEC_VENCIMIE) , 'DDMMYYYY')
      FROM CO_CARTERA 
     WHERE COD_CLIENTE   = :lCodCliente   
       AND IND_FACTURADO = :ihUno
       AND COD_CONCEPTO NOT IN (:ihDos,:ihSeis)
     GROUP BY NUM_FOLIO; */ 
   

    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Fact - %s", LOG00,SQLERRM );
        return -1;
    }
   
    /* EXEC SQL OPEN Cur_Fact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0008;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )222;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihDos;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihSeis;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Fact - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Fact INTO :lhNumFolio, dhSaldoFactura, shFecVence; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
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
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&dhSaldoFactura;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)shFecVence;
        sqlstm.sqhstl[2] = (unsigned long )9;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }	    	    	    	    	 

        ifnTrazasLog( modulo, " lhNumFolio     [%ld]", LOG09,lhNumFolio);                      
        ifnTrazasLog( modulo, " dhSaldoFactura [%.2f]", LOG09,dhSaldoFactura);                      
        ifnTrazasLog( modulo, " shFecVence     [%s]", LOG09,shFecVence);                      
        
        strcpy(sthFactura.sCodAgente[lIndFactura], shCodEntidad);
        sthFactura.lCodCliente  [lIndFactura] = lCodCliente;
        sthFactura.lNumSecuencia[lIndFactura] = lhNumSecuencia;
        sthFactura.dSaldoMora   [lIndFactura] = dhSaldoFactura;
        sthFactura.lNumFolio    [lIndFactura] = lhNumFolio;
        strcpy(sthFactura.sFecVencim[lIndFactura], shFecVence);
        sthFactura.lNumRegistr  [lIndFactura] = lIndFactura;
        lIndFactura = lIndFactura + 1;
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Fact; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )280;
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
  
} /* end ifnDetalleFACTURA() */

/* ============================================================================= */
/*  ifnDetalleCUENTAS : Funcion que busca las informacion de la cuenta del       */
/* cliente                                                                       */
/* ============================================================================= */
int ifnDetalleCUENTAS(long lhCodCliente)
{
char  modulo[]   = "ifnDetalleCUENTAS";
int   iError     = 0;     
int   iRes       = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente          ;      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lCodCliente = lhCodCliente;

    iRes = ifnBuscaDatosCliente(lCodCliente, lIndCuentas);
    if( iRes < 0 ) return -1;        	    

    iRes = ifnVerificaEmpresa(lCodCliente, lIndCuentas);
    if( iRes < 0 ) return -1;        	    
    
    iRes = ifnBuscaDirecciones(lCodCliente, lIndCuentas);
    if( iRes < 0 ) return -1;        	    
        
    sthCuentas.lNumRegistr[lIndCuentas] = lIndCuentas;
        
    return iError;
    
} /* end ifnDetalleCUENTAS */

/* ============================================================================= */
/*  ifnDetalleTELEFONOS : Funcion que busca los telefonos del cliente            */
/* ============================================================================= */
int ifnDetalleTELEFONOS(long lCodCliente, char *sCodEntidad, long lSecuencia)
{
char  modulo[] = "ifnDetalleTELEFONOS";
int   iError   = 0;     
int   iRes     = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lhCodCliente      ;
   char   shCodEntidad   [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   long   lhNumCelular      ;   
   char   shProducto     [6]; /* EXEC SQL VAR shProducto    IS STRING(6); */ 

   char   shSegmento   [513]; /* EXEC SQL VAR shSegmento    IS STRING(513); */ 

   char   shDesProducto[513]; /* EXEC SQL VAR shDesProducto IS STRING(513); */ 
   
   char   shClasifica  [513]; /* EXEC SQL VAR shClasifica   IS STRING(513); */ 
   
   long   lhNumSecuencia    ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lhCodCliente   = lCodCliente;
    lhNumSecuencia = lSecuencia ;
    strcpy(shCodEntidad, sCodEntidad);

    /* EXEC SQL DECLARE Cur_Fono CURSOR for        
    SELECT /o+ RULE o/ 
          NUM_CELULAR, 
          NVL(COD_PRESTACION ,'-1')
     FROM GA_ABOCEL 
    WHERE COD_SITUACION NOT IN (:szhBAP, :szhBAA)
      AND COD_CLIENTE = :lCodCliente; */ 


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Fono - %s", LOG00,SQLERRM );
        return -1;
    }
   
    /* EXEC SQL OPEN Cur_Fono; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )295;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhBAP;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhBAA;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lCodCliente;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Fono - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Fono INTO :lhNumCelular, :shProducto; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
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
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelular;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shProducto;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }	    	    	    	    	 

        sthTelefono.lCodCliente  [lIndTelefon] = lhCodCliente;    
        sthTelefono.lNumSecuencia[lIndTelefon] = lhNumSecuencia;    
        sthTelefono.lNumCelular  [lIndTelefon] = lhNumCelular;

        strcpy(sthTelefono.sCodAgente    [lIndTelefon], shCodEntidad);
        strcpy(sthTelefono.sDesSegment   [lIndTelefon], sthCuentas.sDesSegment   [lIndCuentas]);
        strcpy(sthTelefono.sClasificacion[lIndTelefon], sthCuentas.sClasificacion[lIndCuentas]);

        sthTelefono.lNumRegistr[lIndTelefon] = lIndTelefon;
                        
        ifnTrazasLog( modulo, " lCodCliente     [%ld]", LOG09,lhCodCliente);                          
        ifnTrazasLog( modulo, " lNumCelular     [%ld]", LOG09,lhNumCelular);                      
        ifnTrazasLog( modulo, " sCodAgente      [%s]", LOG09,shCodEntidad);                      
        ifnTrazasLog( modulo, " sDesSegment     [%s]", LOG09,sthCuentas.sDesSegment    [lIndCuentas]);                      
        ifnTrazasLog( modulo, " sClasificacion  [%s]", LOG09,sthCuentas.sClasificacion [lIndCuentas]);                      

        iRes = ifnBBuscaProducto(shProducto, lIndTelefon);
        if( iRes < 0 ) return -1;        	    
        
        lIndTelefon = lIndTelefon + 1;
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Fono; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )345;
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
  
} /* end ifnDetalleTELEFONOS() */

/* ============================================================================= */
/*  ifnBBuscaProducto() : Funcion que busca descripcion del producto             */
/* ============================================================================= */
int ifnBBuscaProducto(char *sCodProducto, long j)
{
char modulo[]="ifnBBuscaProducto";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  char   shCodProducto   [6]; /* EXEC SQL VAR shCodProducto IS STRING(6); */ 
      
  char   shDesProducto  [51]; /* EXEC SQL VAR shDesProducto IS STRING(51); */ 
      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   strcpy(shCodProducto, sCodProducto);

   ifnTrazasLog( modulo, "\n\t En funcion %s", LOG09, modulo );
   ifnTrazasLog( modulo, " shCodProducto  [%s]", LOG09, shCodProducto );
                                                                
   /* EXEC SQL
   SELECT DES_PRESTACION
     INTO :shDesProducto
     FROM GE_PRESTACIONES_TD
    WHERE COD_PRESTACION = :shCodProducto; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 4;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DES_PRESTACION into :b0  from GE_PRESTACIONES_TD wh\
ere COD_PRESTACION=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )360;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shDesProducto;
   sqlstm.sqhstl[0] = (unsigned long )51;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shCodProducto;
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


       
   if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	  ifnTrazasLog( modulo, "\t En funcion ifnBBuscaProducto - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {
       strcpy(shDesProducto, SIN_INFORMACION);
   }
    
   ifnTrazasLog( modulo, " shDesProducto - [%s]", LOG09, shDesProducto );    	   
   strcpy(sthTelefono.sDesProducto[j], shDesProducto);
   
   return 0;	
   
} /* end ifnBBuscaProducto */

/* ============================================================================= */
/*  ifnDetalleTELESCUENTA : Funcion que busca los servicios del cliente          */
/* ============================================================================= */
int ifnDetalleTELESCUENTA(long lhCodCliente, char *sCodEntidad, long lSecuencia)
{
char    modulo[]   = "ifnDetalleTELESCUENTA";
int     iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente        ;
   long   lCodCliente1       ;
   char   shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   char   shDesProducto [513]; /* EXEC SQL VAR shDesProducto IS STRING(513); */ 
   
   long   lhNumSecuencia     ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lCodCliente    = lhCodCliente;
    lhNumSecuencia = lSecuencia;
    strcpy(shCodEntidad, sCodEntidad);

    /* EXEC SQL DECLARE Cur_TCta CURSOR for        
    SELECT A.COD_CLIENTE, C.DES_VALOR 
      FROM GA_ABOCEL A, GE_PRESTACIONES_TD B,
         (SELECT COD_VALOR, DES_VALOR FROM GED_CODIGOS
           WHERE NOM_TABLA   = :szGPRESTACIONES
           AND   NOM_COLUMNA = :szPRESTACION
           AND   COD_MODULO  = :szhGA) C
    WHERE A.COD_PRESTACION = B.COD_PRESTACION
      AND B.GRP_PRESTACION = C.COD_VALOR
      AND A.COD_CLIENTE    = :lCodCliente; */ 


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_TCta - %s", LOG00,SQLERRM );
        return -1;
    }
   
    /* EXEC SQL OPEN Cur_TCta; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0011;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )383;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szGPRESTACIONES;
    sqlstm.sqhstl[0] = (unsigned long )19;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szPRESTACION;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhGA;
    sqlstm.sqhstl[2] = (unsigned long )3;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lCodCliente;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Fono - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_TCta INTO :lCodCliente, :shDesProducto; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )414;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lCodCliente;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shDesProducto;
        sqlstm.sqhstl[1] = (unsigned long )513;
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

        sthTCuentas.lCodCliente  [lIndTeleCta] = lCodCliente;        
        sthTCuentas.lNumSecuencia[lIndTeleCta] = lhNumSecuencia;        

        strcpy(sthTCuentas.sCodAgente    [lIndTeleCta], shCodEntidad);
        strcpy(sthTCuentas.sDesProducto  [lIndTeleCta], shDesProducto);
        sthTCuentas.lNumRegistr[lIndTeleCta] = lIndTeleCta;
        
        lIndTeleCta = lIndTeleCta + 1;
        
        ifnTrazasLog( modulo, " shDesProducto [%s]", LOG09,shDesProducto);                      
        
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_TCta; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )437;
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
  
} /* end ifnDetalleTELESCUENTA() */

/* ============================================================================= */
/*  ifnBuscaDatosCliente : Funcion que busca datos generales del cliente         */
/* ============================================================================= */
int ifnBuscaDatosCliente(long lhCodCliente, long j)
{
char  modulo[]   = "ifnBuscaDatosCliente";
int   iError     = 0;     
int   iRes       = 0;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente     ;
   char   shEstado          [7]; /* EXEC SQL VAR shEstado         IS STRING(7); */ 

   char   shApellido1      [42]; /* EXEC SQL VAR shApellido1      IS STRING(42); */ 

   char   shApellido2      [42]; /* EXEC SQL VAR shApellido2      IS STRING(42); */ 

   char   shApellidos      [42]; /* EXEC SQL VAR shApellidos      IS STRING(42); */ 

   char   shNombres        [52]; /* EXEC SQL VAR shNombres        IS STRING(52); */ 

   char   shNumIdent       [21]; /* EXEC SQL VAR shNumIdent       IS STRING(21); */ 
   
   char   shTipDoc         [21]; /* EXEC SQL VAR shTipDoc         IS STRING(21); */ 

   char   shNumDoc         [21]; /* EXEC SQL VAR shNumDoc         IS STRING(21); */ 
   
   char   shTelCliente     [16]; /* EXEC SQL VAR shTelCliente     IS STRING(16); */ 
   
   char   shNomRefer1      [51]; /* EXEC SQL VAR shNomRefer1      IS STRING(51); */ 
   
   char   shTelRefer1      [16]; /* EXEC SQL VAR shTelRefer1      IS STRING(16); */ 
   
   char   shTelRefer2      [16]; /* EXEC SQL VAR shTelRefer2      IS STRING(16); */ 
   
   char   shCodOcupacion    [4]; /* EXEC SQL VAR shCodOcupacion   IS STRING(4); */ 
   
   char   shEdad            [3]; /* EXEC SQL VAR shEdad           IS STRING(4); */ 
   
   int    ihCodSegmento        ;
   int    ihCodCategoria       ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL      
    SELECT DECODE(A.FEC_BAJA, NULL, :szhACTIVO, :szhBAJA )                   AS ESTADO    , 
           NVL(A.NOM_APECLIEN1, :szhSININFORMACION)                          AS APELLIDOS1, 
           NVL(A.NOM_APECLIEN2, :szhSININFORMACION)                          AS APELLIDOS2, 
           A.NOM_CLIENTE                                                     AS NOMBRES   , 
           A.NUM_IDENT                                                       AS NIT       , 
           B.DES_TIPIDENT                                                    AS TIPO_DOCUMENTO, 
           A.NUM_IDENT                                                       AS NUM_DOCUMENTO,
           NVL(A.TEF_CLIENTE1 , :szhSININFORMACION)                          AS TEL_CLIENTE, 
           NVL(A.NOM_REFER1   , :szhSININFORMACION)                          AS NOM_REFER1,
           NVL(A.TEF_REFER1   , :szhSININFORMACION)                          AS TEL_REFER1,
           NVL(A.TEF_REFER2   , :szhSININFORMACION)                          AS TEL_REFER2, 
           NVL(A.COD_SEGMENTO , 0)                                           AS COD_SEGMENTO, 
           A.COD_CATEGORIA                                                   AS CATEGORIA ,
           NVL(A.COD_OCUPACION, '-1')                                        AS OCUPACION , 
           NVL(TO_CHAR(sysdate,:szhYYYY) - TO_CHAR(FEC_NACIMIEN,:szhYYYY), '-1') AS EDAD          
      INTO :shEstado      ,  
           :shApellido1   , 
           :shApellido2   , 
           :shNombres     , 
           :shNumIdent    , 
           :shTipDoc      , 
           :shNumDoc      , 
           :shTelCliente  , 
           :shNomRefer1   , 
           :shTelRefer1   , 
           :shTelRefer2   , 
           :ihCodSegmento , 
           :ihCodCategoria, 
           :shCodOcupacion, 
           :shEdad
      FROM GE_CLIENTES A, GE_TIPIDENT B 
     WHERE A.COD_CLIENTE  = :lCodCliente
       AND A.COD_TIPIDENT = B.COD_TIPIDENT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DECODE(A.FEC_BAJA,null ,:b0,:b1) ESTADO ,NVL(A.NOM\
_APECLIEN1,:b2) APELLIDOS1 ,NVL(A.NOM_APECLIEN2,:b2) APELLIDOS2 ,A.NOM_CLIENTE\
 NOMBRES ,A.NUM_IDENT NIT ,B.DES_TIPIDENT TIPO_DOCUMENTO ,A.NUM_IDENT NUM_DOCU\
MENTO ,NVL(A.TEF_CLIENTE1,:b2) TEL_CLIENTE ,NVL(A.NOM_REFER1,:b2) NOM_REFER1 ,\
NVL(A.TEF_REFER1,:b2) TEL_REFER1 ,NVL(A.TEF_REFER2,:b2) TEL_REFER2 ,NVL(A.COD_\
SEGMENTO,0) COD_SEGMENTO ,A.COD_CATEGORIA CATEGORIA ,NVL(A.COD_OCUPACION,'-1')\
 OCUPACION ,NVL((TO_CHAR(sysdate,:b8)-TO_CHAR(FEC_NACIMIEN,:b8)),'-1') EDAD in\
to :b10,:b11,:b12,:b13,:b14,:b15,:b16,:b17,:b18,:b19,:b20,:b21,:b22,:b23,:b24 \
 from GE_CLIENTES A ,GE_TIPIDENT B where (A.COD_CLIENTE=:b25 and A.COD_TIPIDEN\
T=B.COD_TIPIDENT)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )452;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhACTIVO;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhBAJA;
    sqlstm.sqhstl[1] = (unsigned long )5;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[2] = (unsigned long )16;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[3] = (unsigned long )16;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[4] = (unsigned long )16;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[5] = (unsigned long )16;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[6] = (unsigned long )16;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhSININFORMACION;
    sqlstm.sqhstl[7] = (unsigned long )16;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhYYYY;
    sqlstm.sqhstl[8] = (unsigned long )5;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhYYYY;
    sqlstm.sqhstl[9] = (unsigned long )5;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)shEstado;
    sqlstm.sqhstl[10] = (unsigned long )7;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)shApellido1;
    sqlstm.sqhstl[11] = (unsigned long )42;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)shApellido2;
    sqlstm.sqhstl[12] = (unsigned long )42;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)shNombres;
    sqlstm.sqhstl[13] = (unsigned long )52;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)shNumIdent;
    sqlstm.sqhstl[14] = (unsigned long )21;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)shTipDoc;
    sqlstm.sqhstl[15] = (unsigned long )21;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)shNumDoc;
    sqlstm.sqhstl[16] = (unsigned long )21;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)shTelCliente;
    sqlstm.sqhstl[17] = (unsigned long )16;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)shNomRefer1;
    sqlstm.sqhstl[18] = (unsigned long )51;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)shTelRefer1;
    sqlstm.sqhstl[19] = (unsigned long )16;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)shTelRefer2;
    sqlstm.sqhstl[20] = (unsigned long )16;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&ihCodSegmento;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&ihCodCategoria;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)shCodOcupacion;
    sqlstm.sqhstl[23] = (unsigned long )4;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)shEdad;
    sqlstm.sqhstl[24] = (unsigned long )4;
    sqlstm.sqhsts[24] = (         int  )0;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[25] = (         int  )0;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
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
	   ifnTrazasLog( modulo, "\t En funcion %s - %s", LOG00, modulo, SQLERRM );
       return -1;				
    }

    strcpy(sthCuentas.sEstado       [j], shEstado);
    strcpy(sthCuentas.sEstatus      [j], shEstado);
    
    sprintf(shApellidos,"%s %s",shApellido1,shApellido2);
    
    strcpy(sthCuentas.sApellidos    [j], shApellidos);
    strcpy(sthCuentas.sNombreClie   [j], shNombres);
    strcpy(sthCuentas.sNIT          [j], shNumIdent);
    strcpy(sthCuentas.sTipDocumento [j], shTipDoc);
    strcpy(sthCuentas.sNumDocumento [j], shNumDoc);
    strcpy(sthCuentas.sEdad         [j], shEdad);
    strcpy(sthCuentas.sTelTitular   [j], shTelCliente);
    strcpy(sthCuentas.sNomRefere1   [j], shNomRefer1);
    strcpy(sthCuentas.sTelRefere1   [j], shTelRefer1);
    strcpy(sthCuentas.sTelRefere2   [j], shTelRefer2);
        
    sthCuentas.iCodSegment  [j] = ihCodSegmento;

    ifnTrazasLog( modulo, " shEstado      [%s]", LOG09,shEstado);                      
    ifnTrazasLog( modulo, " shApellidos   [%s]", LOG09,shApellidos);                      
    ifnTrazasLog( modulo, " shNombres     [%s]", LOG09,shNombres);                      
    ifnTrazasLog( modulo, " shNumIdent    [%s]", LOG09,shNumIdent);                      
    ifnTrazasLog( modulo, " shTipDoc      [%s]", LOG09,shTipDoc);                      
    ifnTrazasLog( modulo, " shNumDoc      [%s]", LOG09,shNumDoc);                      
    ifnTrazasLog( modulo, " sEdad         [%s]", LOG09,shEdad);                      
    ifnTrazasLog( modulo, " shTelCliente  [%s]", LOG09,shTelCliente);                      
    ifnTrazasLog( modulo, " shNomRefer1   [%s]", LOG09,shNomRefer1);                      
    ifnTrazasLog( modulo, " shTelRefer1   [%s]", LOG09,shTelRefer1);                      
    ifnTrazasLog( modulo, " shTelRefer2   [%s]", LOG09,shTelRefer2);                      
                        
    ifnTrazasLog( modulo, " ihCodSegmento [%d]", LOG09,ihCodSegmento);                          
    iRes = ifnBBuscaSegmento(ihCodSegmento,j);
    if (iRes < -1) return -1;

    ifnTrazasLog( modulo, " ihCodCategoria[%d]", LOG09,ihCodCategoria);          
    iRes = ifnBBuscaClasificacion(ihCodCategoria,j);
    if (iRes < -1) return -1;
    
    ifnTrazasLog( modulo, " shCodOcupacion[%s]", LOG09,shCodOcupacion);       
    iRes = ifnBBuscaOcupacion(shCodOcupacion,j);
    if (iRes < -1) return -1;

    return iError;
  
} /* end ifnBuscaDatosCliente() */

/* ============================================================================= */
/*  ifnBBuscaOcupacion() : Funcion que busca ocupacion del cliente               */
/* ============================================================================= */
int ifnBBuscaOcupacion(char *sCodOcupacion, long j)
{
char modulo[]="ifnBBuscaOcupacion";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  char   shCodOcupacion   [4]; /* EXEC SQL VAR shCodOcupacion    IS STRING(4); */ 
      
  char   shDesOcupacion  [31]; /* EXEC SQL VAR shDesOcupacion    IS STRING(31); */ 
      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   strcpy(shCodOcupacion, sCodOcupacion);

   ifnTrazasLog( modulo, "\n\t En funcion %s", LOG09, modulo );
   ifnTrazasLog( modulo, " shCodOcupacion  [%s]", LOG09, shCodOcupacion );
                                                                
   /* EXEC SQL
     SELECT DES_OCUPACION
       INTO :shDesOcupacion
       FROM GE_OCUPACIONES
      WHERE COD_OCUPACION = :shCodOcupacion; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 26;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DES_OCUPACION into :b0  from GE_OCUPACIONES where C\
OD_OCUPACION=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )571;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shDesOcupacion;
   sqlstm.sqhstl[0] = (unsigned long )31;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)shCodOcupacion;
   sqlstm.sqhstl[1] = (unsigned long )4;
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
	  ifnTrazasLog( modulo, "\t En funcion ifnBBuscaOcupacion - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {
       strcpy(shDesOcupacion, SIN_INFORMACION);
   }
    
   ifnTrazasLog( modulo, "\t shDesOcupacion - [%s]", LOG09, shDesOcupacion );    	   
   strcpy(sthCuentas.sOcupacion[j], shDesOcupacion);
   
   return 0;	
   
} /* end ifnBBuscaOcupacion */

/* ============================================================================= */
/*  ifnBBuscaClasificacion() : Funcion que busca clasificacion del cliente       */
/* ============================================================================= */
int ifnBBuscaClasificacion(int iCodCategoria, long j)
{
char modulo[]="ifnBBuscaClasificacion";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  int    ihCodCategoria       ;    
  char   shDesClasific   [513]; /* EXEC SQL VAR shDesClasific    IS STRING(513); */ 
      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   ihCodCategoria = iCodCategoria;

   ifnTrazasLog( modulo, "\n\t En funcion %s", LOG09, modulo );
   ifnTrazasLog( modulo, " ihCodCategoria  [%d]", LOG09, ihCodCategoria );
                                                                
   /* EXEC SQL
   SELECT DES_VALOR 
     INTO :shDesClasific
     FROM GED_CODIGOS 
    WHERE NOM_TABLA   = 'GE_CATEGORIAS' 
      AND NOM_COLUMNA = 'COD_CATEGORIA' 
      AND COD_MODULO  = 'GA'
      AND COD_VALOR   = :ihCodCategoria; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 26;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DES_VALOR into :b0  from GED_CODIGOS where (((NOM_T\
ABLA='GE_CATEGORIAS' and NOM_COLUMNA='COD_CATEGORIA') and COD_MODULO='GA') and\
 COD_VALOR=:b1)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )594;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shDesClasific;
   sqlstm.sqhstl[0] = (unsigned long )513;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCategoria;
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
	  ifnTrazasLog( modulo, "\t En funcion ifnBBuscaClasificacion - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {
       strcpy(shDesClasific, SIN_INFORMACION);
   }
    
   ifnTrazasLog( modulo, "\t shDesClasific - [%s]", LOG09, shDesClasific );    	   
   strcpy(sthCuentas.sClasificacion[j], shDesClasific);
   
   return 0;	
   
} /* end ifnBBuscaClasificacion */

/* ============================================================================= */
/*  ifnBBuscaSegmento() : Funcion que busca segmento del cliente                 */
/* ============================================================================= */
int ifnBBuscaSegmento(int iCodSegmento, long j)
{
char modulo[]="ifnBBuscaSegmento";
	
/* EXEC SQL BEGIN DECLARE SECTION; */ 
                                               
  int    ihCod_Segmento     ;    
  char   shDes_Segmento[101]; /* EXEC SQL VAR shDes_Segmento IS STRING(101); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 
	
   ihCod_Segmento = iCodSegmento;

   ifnTrazasLog( modulo, "\n\t En funcion %s", LOG09, modulo );
   ifnTrazasLog( modulo, " ihCod_Segmento  [%d]", LOG09, ihCod_Segmento );
                                                                
   /* EXEC SQL
   SELECT DES_SEGMENTO
     INTO :shDes_Segmento
     FROM GE_SEGMENTACION_CLIENTES_TD 
    WHERE COD_SEGMENTO = :ihCod_Segmento; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 26;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select DES_SEGMENTO into :b0  from GE_SEGMENTACION_CLIENTE\
S_TD where COD_SEGMENTO=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )617;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)shDes_Segmento;
   sqlstm.sqhstl[0] = (unsigned long )101;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCod_Segmento;
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
	  ifnTrazasLog( modulo, "\t En funcion ifnBBuscaSegmento - %s", LOG00, SQLERRM );
	  return -1;				
    }
    
   if( SQLCODE == SQLNOTFOUND ) {
       strcpy(shDes_Segmento, SIN_INFORMACION);
   }
    
   ifnTrazasLog( modulo, "\t shDes_Segmento - [%s]", LOG09, shDes_Segmento );    	   
   strcpy(sthCuentas.sDesSegment [j], shDes_Segmento);
   
   return 0;	
   
} /* end ifnBBuscaSegmento */

/* ============================================================================= */
/*  ifnVerificaEmpresa : Funcion que verifica si cliente corresponde a empresa   */
/* ============================================================================= */
int ifnVerificaEmpresa(long lhCodCliente, long j)
{
char  modulo[]   = "ifnVerificaEmpresa";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente     ;
   char   shNomEmpresa     [52]; /* EXEC SQL VAR shNomEmpresa     IS STRING(52); */ 

   char   shTipDoc         [21]; /* EXEC SQL VAR shTipDoc         IS STRING(21); */ 

   char   shNumDoc         [21]; /* EXEC SQL VAR shNumDoc         IS STRING(21); */ 
      
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL      
    SELECT DES_EMPRESA
      INTO :shNomEmpresa
      FROM GA_EMPRESA
     WHERE COD_CLIENTE = :lCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DES_EMPRESA into :b0  from GA_EMPRESA where COD_CL\
IENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )640;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shNomEmpresa;
    sqlstm.sqhstl[0] = (unsigned long )52;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
	   ifnTrazasLog( modulo, "\t En funcion %s (1) - %s", LOG00, modulo, SQLERRM );
       return -1;				
    }

    if( SQLCODE == SQLNOTFOUND ) {
        strcpy(sthCuentas.sNombreEmpr [j], SIN_INFORMACION);            	
    } else  {

        /* EXEC SQL      
    	SELECT B.DES_TIPIDENT    AS TIPO_DOCUMENTO, 
               A.NUM_IDENTAPOR   AS NUM_DOCUMENTO 
          INTO :shTipDoc   , 
               :shNumDoc    
          FROM GE_CLIENTES A, GE_TIPIDENT B
         WHERE A.COD_CLIENTE      = :lCodCliente
           AND A.COD_TIPIDENTAPOR = B.COD_TIPIDENT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select B.DES_TIPIDENT TIPO_DOCUMENTO ,A.NUM_IDENTAPOR\
 NUM_DOCUMENTO into :b0,:b1  from GE_CLIENTES A ,GE_TIPIDENT B where (A.COD_CL\
IENTE=:b2 and A.COD_TIPIDENTAPOR=B.COD_TIPIDENT)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )663;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)shTipDoc;
        sqlstm.sqhstl[0] = (unsigned long )21;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)shNumDoc;
        sqlstm.sqhstl[1] = (unsigned long )21;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lCodCliente;
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
	       ifnTrazasLog( modulo, "\t En funcion %s (2) - %s", LOG00, modulo, SQLERRM );
           return -1;				
        }
    	    	
        strcpy(sthCuentas.sApellidos   [j], SIN_INFORMACION);
        strcpy(sthCuentas.sNombreClie  [j], SIN_INFORMACION);
        strcpy(sthCuentas.sNombreEmpr  [j], shNomEmpresa);             
        strcpy(sthCuentas.sTipDocumento[j], shTipDoc);
        strcpy(sthCuentas.sNumDocumento[j], shNumDoc);   

        ifnTrazasLog( modulo, " shNomEmpresa  [%s]", LOG03,shNomEmpresa);                      
        
    } 
      
    return iError;
  
} /* end ifnVerificaEmpresa() */

/* ============================================================================= */
/*  ifnBuscaDirecciones : Funcion que busca direcciones del cliente              */
/* ============================================================================= */
int ifnBuscaDirecciones(long lhCodCliente, long j)
{
char  modulo[]   = "ifnBuscaDirecciones";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente     ;
   char   shDireccion1     [81]; /* EXEC SQL VAR shDireccion1  IS STRING(81); */ 

   char   shDireccion2     [81]; /* EXEC SQL VAR shDireccion2  IS STRING(81); */ 

   char   shZona           [31]; /* EXEC SQL VAR shZona        IS STRING(31); */ 

   char   shDepartamen     [31]; /* EXEC SQL VAR shDepartamen  IS STRING(31); */ 

   char   shMunicipio      [31]; /* EXEC SQL VAR shMunicipio   IS STRING(31); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL      
    SELECT B.NOM_CALLE||' '||B.NUM_CALLE||' '||B.NUM_PISO AS DIRECCION, 
           E.DES_CIUDAD AS ZONA, 
           F.DES_REGION AS DEPARTAMENTO, 
           G.DES_PROVINCIA AS MUNICIPIO
      INTO :shDireccion1, 
           :shZona, 
           :shDepartamen, 
           :shMunicipio
      FROM GE_DIRECCIONES B, GA_DIRECCLI C, GE_TIPDIRECCION D, 
           GE_CIUDADES    E, GE_REGIONES F, GE_PROVINCIAS   G     
     WHERE C.COD_CLIENTE   = :lCodCliente
       AND B.COD_DIRECCION = C.COD_DIRECCION
       AND C.COD_TIPDIRECCION = D.COD_TIPDIRECCION 
       AND C.COD_TIPDIRECCION = :ihUno
       AND B.COD_PROVINCIA = E.COD_PROVINCIA
       AND B.COD_REGION    = E.COD_REGION
       AND B.COD_CIUDAD    = E.COD_CIUDAD
       AND B.COD_REGION    = F.COD_REGION
       AND B.COD_REGION    = G.COD_REGION 
       AND B.COD_PROVINCIA = G.COD_PROVINCIA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ((((B.NOM_CALLE||' ')||B.NUM_CALLE)||' ')||B.NUM_P\
ISO) DIRECCION ,E.DES_CIUDAD ZONA ,F.DES_REGION DEPARTAMENTO ,G.DES_PROVINCIA \
MUNICIPIO into :b0,:b1,:b2,:b3  from GE_DIRECCIONES B ,GA_DIRECCLI C ,GE_TIPDI\
RECCION D ,GE_CIUDADES E ,GE_REGIONES F ,GE_PROVINCIAS G where (((((((((C.COD_\
CLIENTE=:b4 and B.COD_DIRECCION=C.COD_DIRECCION) and C.COD_TIPDIRECCION=D.COD_\
TIPDIRECCION) and C.COD_TIPDIRECCION=:b5) and B.COD_PROVINCIA=E.COD_PROVINCIA)\
 and B.COD_REGION=E.COD_REGION) and B.COD_CIUDAD=E.COD_CIUDAD) and B.COD_REGIO\
N=F.COD_REGION) and B.COD_REGION=G.COD_REGION) and B.COD_PROVINCIA=G.COD_PROVI\
NCIA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )690;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shDireccion1;
    sqlstm.sqhstl[0] = (unsigned long )81;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)shZona;
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)shDepartamen;
    sqlstm.sqhstl[2] = (unsigned long )31;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)shMunicipio;
    sqlstm.sqhstl[3] = (unsigned long )31;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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


                     
    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	   ifnTrazasLog( modulo, "\t En funcion %s (1) - %s", LOG00, modulo, SQLERRM );
       return -1;				
    }

    /* EXEC SQL      
    SELECT B.NOM_CALLE||' '||B.NUM_CALLE||' '||B.NUM_PISO AS DIRECCION   
      INTO :shDireccion2
      FROM GE_DIRECCIONES B, GA_DIRECCLI C, GE_TIPDIRECCION D   
     WHERE C.COD_CLIENTE      = :lCodCliente
       AND B.COD_DIRECCION    = C.COD_DIRECCION
       AND C.COD_TIPDIRECCION = D.COD_TIPDIRECCION 
       AND C.COD_TIPDIRECCION = :ihDos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select ((((B.NOM_CALLE||' ')||B.NUM_CALLE)||' ')||B.NUM_P\
ISO) DIRECCION into :b0  from GE_DIRECCIONES B ,GA_DIRECCLI C ,GE_TIPDIRECCION\
 D where (((C.COD_CLIENTE=:b1 and B.COD_DIRECCION=C.COD_DIRECCION) and C.COD_T\
IPDIRECCION=D.COD_TIPDIRECCION) and C.COD_TIPDIRECCION=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )729;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shDireccion2;
    sqlstm.sqhstl[0] = (unsigned long )81;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihDos;
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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
	   ifnTrazasLog( modulo, "\t En funcion %s (2) - %s", LOG00, modulo, SQLERRM );
       return -1;				
    }

    strcpy(sthCuentas.sDireccion1 [j], shDireccion1);
    strcpy(sthCuentas.sDireccion2 [j], shDireccion2);
    strcpy(sthCuentas.sZona       [j], shZona);
    strcpy(sthCuentas.sDepartamen [j], shDepartamen);
    strcpy(sthCuentas.sMunicipio  [j], shMunicipio);
    
    ifnTrazasLog( modulo, " shDireccion1  [%s]", LOG09,shDireccion1);                      
    ifnTrazasLog( modulo, " shDireccion2  [%s]", LOG09,shDireccion2);                      
    ifnTrazasLog( modulo, " shZona        [%s]", LOG09,shZona);                      
    ifnTrazasLog( modulo, " shDepartamen  [%s]", LOG09,shDepartamen);                      
    ifnTrazasLog( modulo, " shMunicipio   [%s]", LOG09,shMunicipio);                      
   
    return iError;
  
} /* end ifnBuscaDirecciones) */

/* ============================================================================= */
/*  ifnBuscaClasificacion : Funcion que busca la clasificacion de cobros         */
/* ============================================================================= */
int ifnBuscaClasificacion(long lhCodCliente)
{
char  modulo[]   = "ifnBuscaClasificacion";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lCodCliente     ;
   char   shClasificacion[6]; /* EXEC SQL VAR shClasificacion IS STRING(6); */ 
   
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL      
    SELECT COD_VALOR
      INTO :shClasificacion
      FROM CO_MOROSOS A, CO_CODIGOS B 
     WHERE A.COD_CLIENTE  = :lCodCliente
       AND A.COD_CATEGORIA= B.COD_VALOR 
       AND B.NOM_TABLA    = 'CO_MOROSOS'
       AND B.NOM_COLUMNA  = 'COD_CATEGORIA'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_VALOR into :b0  from CO_MOROSOS A ,CO_CODIGOS \
B where (((A.COD_CLIENTE=:b1 and A.COD_CATEGORIA=B.COD_VALOR) and B.NOM_TABLA=\
'CO_MOROSOS') and B.NOM_COLUMNA='COD_CATEGORIA')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )756;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)shClasificacion;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
	  ifnTrazasLog( modulo, "\t En funcion ifnBuscaClasificacion(1) - %s", LOG00, SQLERRM );
	  return -1;				
    }

    if( SQLCODE == SQLNOTFOUND ) {
    	
        /* EXEC SQL      
        SELECT DES_VALOR
          INTO :shClasificacion
          FROM GE_CLIENTES A, CO_CODIGOS B 
         WHERE A.COD_CLIENTE  = :lCodCliente
           AND A.COD_CATEGORIA= B.COD_VALOR 
           AND B.NOM_TABLA    = 'GE_CLIENTES'
           AND B.NOM_COLUMNA  = 'COD_CATEGORIA'; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select DES_VALOR into :b0  from GE_CLIENTES A ,CO_COD\
IGOS B where (((A.COD_CLIENTE=:b1 and A.COD_CATEGORIA=B.COD_VALOR) and B.NOM_T\
ABLA='GE_CLIENTES') and B.NOM_COLUMNA='COD_CATEGORIA')";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )779;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)shClasificacion;
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
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
	      ifnTrazasLog( modulo, "\t En funcion ifnBuscaClasificacion(2) - %s", LOG00, SQLERRM );
	      return -1;				
        }
    }

    ifnTrazasLog( modulo, "shClasificacion [%s]", LOG09,shClasificacion);                      

    strcpy(sthDetafac.sClasificac[lIndDetafac], shClasificacion);
    return iError;
  
} /* end ifnBuscaClasificacion() */

/* ============================================================================= */
/*  ifnBuscaMontoMora : Funcion que busca el monto, documentos y dias en mora de */ 
/*  un cliente determinado                                                       */
/* ============================================================================= */
int ifnBuscaMontoDocMora(long lhCodCliente)
{
char  modulo[]   = "ifnBuscaMontoDocMora";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
  long   lCodCliente       ;
  int    iTotDocVencidos   ;
  int    iDiasMora         ;
  double dDeudaVencida     ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL	
    SELECT COUNT(DISTINCT NUM_SECUENCI), SUM(IMPORTE_DEBE-IMPORTE_HABER), TRUNC(SYSDATE - MIN(FEC_VENCIMIE))
      INTO :iTotDocVencidos,  :dDeudaVencida, :iDiasMora
      FROM CO_CARTERA 
     WHERE COD_CLIENTE   = :lCodCliente
       AND IND_FACTURADO = :ihUno
       AND COD_CONCEPTO NOT IN (:ihDos,:ihSeis); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(distinct NUM_SECUENCI) ,sum((IMPORTE_DEBE-IM\
PORTE_HABER)) ,TRUNC((SYSDATE-min(FEC_VENCIMIE))) into :b0,:b1,:b2  from CO_CA\
RTERA where ((COD_CLIENTE=:b3 and IND_FACTURADO=:b4) and COD_CONCEPTO not  in \
(:b5,:b6))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )802;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iTotDocVencidos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&dDeudaVencida;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&iDiasMora;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihUno;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihDos;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihSeis;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
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
	  ifnTrazasLog( modulo, "\t SELECT DISTINCT COUNT(NUM_SECUENCI) - %s", LOG00, SQLERRM );
	  return -1;				
    }

    ifnTrazasLog( modulo, "iTotDocVencidos [%d]", LOG09,iTotDocVencidos);                      
    ifnTrazasLog( modulo, "dDeudaVencida   [%.2f]", LOG09,dDeudaVencida);                      
    ifnTrazasLog( modulo, "iDiasMora       [%d]", LOG09,iDiasMora);                      

    sthDetafac.iTotFactMor[lIndDetafac] = iTotDocVencidos;
    sthDetafac.dMontoMora [lIndDetafac] = dDeudaVencida;
    sthDetafac.iDiasenMora[lIndDetafac] = iDiasMora;

    return iError;
  
} /* end ifnBuscaMontoDocMora() */

/* ============================================================================= */
/*  ifnBuscaProducto : Funcion que busca datos de los productos del cliente      */
/* ============================================================================= */
int ifnBuscaProducto(long lhCodCliente)
{
char  modulo[]   = "ifnBuscaProducto";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
  long   lCodCliente         ;
  char   shCod_Prestacion [6]; /* EXEC SQL VAR shCod_Prestacion IS STRING(6); */ 

  char   shDes_Prestacion[51]; /* EXEC SQL VAR shDes_Prestacion IS STRING(51); */ 

  int    ihMovil             ;
  int    ihNoMovil           ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      
    lCodCliente = lhCodCliente;

    /* EXEC SQL	
    SELECT A.COD_PRESTACION , B.DES_PRESTACION 
      INTO :shCod_Prestacion, :shDes_Prestacion 
      FROM GA_ABOCEL A, GE_PRESTACIONES_TD B 
     WHERE A.COD_PRESTACION = B.COD_PRESTACION 
       AND A.COD_CLIENTE    = :lCodCliente
       AND A.FEC_ALTA = (SELECT MIN(FEC_ALTA) FROM GA_ABOCEL WHERE COD_CLIENTE = :lCodCliente); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_PRESTACION ,B.DES_PRESTACION into :b0,:b1  f\
rom GA_ABOCEL A ,GE_PRESTACIONES_TD B where ((A.COD_PRESTACION=B.COD_PRESTACIO\
N and A.COD_CLIENTE=:b2) and A.FEC_ALTA=(select min(FEC_ALTA)  from GA_ABOCEL \
where COD_CLIENTE=:b2))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )845;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lCodCliente;
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
       strcpy(shCod_Prestacion, SI);
       strcpy(shDes_Prestacion, SIN_INFORMACION);
    }
   
    /* EXEC SQL                       
     SELECT COUNT(1)
     INTO :ihMovil
     FROM GA_ABOCEL A, GE_PRESTACIONES_TD B  
    WHERE A.COD_CLIENTE    = :lCodCliente
      AND A.COD_SITUACION NOT IN (:szhBAA, :szhBAP)
      AND A.COD_PRESTACION = B.COD_PRESTACION
      AND B.GRP_PRESTACION = :szhTM; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from GA_ABOCEL A ,GE_PRESTACION\
ES_TD B where (((A.COD_CLIENTE=:b1 and A.COD_SITUACION not  in (:b2,:b3)) and \
A.COD_PRESTACION=B.COD_PRESTACION) and B.GRP_PRESTACION=:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )876;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihMovil;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhBAP;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhTM;
    sqlstm.sqhstl[4] = (unsigned long )3;
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
	  ifnTrazasLog( modulo, "\t SELECT COUNT(MOVIL) - %s", LOG00, SQLERRM );
	  return -1;				
    }

    if( SQLCODE == SQLNOTFOUND ) {
       ihMovil = 0;
    }

    /* EXEC SQL                       
    SELECT COUNT(1)
     INTO :ihNoMovil
     FROM GA_ABOCEL A, GE_PRESTACIONES_TD B  
    WHERE A.COD_CLIENTE    = :lCodCliente
      AND A.COD_SITUACION NOT IN (:szhBAA, :szhBAP)
      AND A.COD_PRESTACION = B.COD_PRESTACION
      AND B.GRP_PRESTACION <> :szhTM; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from GA_ABOCEL A ,GE_PRESTACION\
ES_TD B where (((A.COD_CLIENTE=:b1 and A.COD_SITUACION not  in (:b2,:b3)) and \
A.COD_PRESTACION=B.COD_PRESTACION) and B.GRP_PRESTACION<>:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )911;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNoMovil;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhBAA;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhBAP;
    sqlstm.sqhstl[3] = (unsigned long )4;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhTM;
    sqlstm.sqhstl[4] = (unsigned long )3;
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
	  ifnTrazasLog( modulo, "\t SELECT COUNT(NOMOVIL) - %s", LOG00, SQLERRM );
	  return -1;				
    }

    if( SQLCODE == SQLNOTFOUND ) {
       ihNoMovil = 0;
    }

    ifnTrazasLog( modulo, " shCod_Prestacion [%s]", LOG09,shCod_Prestacion);                      
    ifnTrazasLog( modulo, " shDes_Prestacion [%s]", LOG09,shDes_Prestacion);                      
    ifnTrazasLog( modulo, " ihMovil          [%ld]", LOG09,ihMovil);                      
    ifnTrazasLog( modulo, " ihNoMovil        [%ld]", LOG09,ihNoMovil);                      

    strcpy(sthDetafac.sCodProducto[lIndDetafac], shCod_Prestacion);
    strcpy(sthDetafac.sDesProducto[lIndDetafac], shDes_Prestacion);
    sthDetafac.iTotLinMovil[lIndDetafac] = ihMovil;    
    sthDetafac.iTotNotMovil[lIndDetafac] = ihNoMovil;    
    
    return iError;
  
} /* end ifnBuscaProducto() */

/* ============================================================================= */
/*  ifnGeneraArchivosEntidad()                                                   */
/* ============================================================================= */
int ifnGeneraArchivosEntidad(long lNumSecuencia)
{
char modulo[]= "ifnGeneraArchivosEntidad";
int  iError  = 0 ;     
int  iRes    = 0 ;

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   	char  shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      

    /************************************************************************/
    /* Obtiene el Universo de Entidades de Cobranzas                        */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_EntCobEx2 CURSOR for        
    SELECT COD_ENTIDAD
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
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0026;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )946;
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

        /* EXEC SQL FETCH Cur_EntCobEx2 INTO :shCodEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )961;
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



		if (SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }
	    
	    iRes = ifnGeneraArchCob(shCodEntidad, lNumSecuencia);
	    if( iRes < 0 ) {
           iError = -1;
           break;           
        }
        
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_EntCobEx2; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )980;
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

} /* end ifnGeneraArchivosEntidad */

/* ============================================================================= */
/*  ifnGeneraUnivArchCob() : Funcion que el universo genera los archivos de      */
/*  cobranza                                                                     */
/* ============================================================================= */
int ifnGeneraUnivArchCob()
{
char modulo[]= "ifnGeneraUnivArchCob";
int  iError  = 0 ;     
int  iRes    = 0 ;
char shEstado [4];

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   	char  shCodEntidad    [6]; /* EXEC SQL VAR shCodEntidad IS STRING(6); */ 

   	long  lhNumSecuencia     ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      

    /************************************************************************/
    /* Obtiene el Universo de Numero de Procesos a imprimir                 */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_EntCobEx3 CURSOR for        
    SELECT NUM_SECUENCIA, NVL(COD_ENTIDAD, '-1')  
      FROM CO_PARAM_COBEX_TO
     WHERE COD_ESTADO IN (:szVIS, :szREA)
     ORDER BY NUM_SECUENCIA; */ 


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_EntCobEx3 - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_EntCobEx3; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0027;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )995;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szVIS;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szREA;
    sqlstm.sqhstl[1] = (unsigned long )4;
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



    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_EntCobEx3 - %s", LOG00,SQLERRM );
        return -1;
    }
       
	while(1) {

        /* EXEC SQL FETCH Cur_EntCobEx3 INTO :lhNumSecuencia, :shCodEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1018;
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
        sqlstm.sqhstv[1] = (unsigned char  *)shCodEntidad;
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



		if (SQLCODE  == SQLNOTFOUND) {
			break; /* No hay mas empresas de cobranzas externa */
		}

        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
        {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }
	    
        if  (strcmp(shCodEntidad,CARNULL)== 0) {
            /* cursor por entidad*/
            iRes = ifnGeneraArchivosEntidad(lhNumSecuencia);
        } else {
        	iRes = ifnGeneraArchCob(shCodEntidad, lhNumSecuencia);
        } /* end if  (strcmp(shCodEntidad,CARNULL)== 0) */
                
        if  (iRes == 0) strcpy(shEstado, TERMINADO);
        else strcpy(shEstado, ERROR);
        	
        iRes = ifnActualizaEstado(lhNumSecuencia, shEstado);
        if  (iRes < 0) {
        	iError = -1;
        	break;
        }
        
        if  (strcmp(shEstado, TERMINADO)== 0) {
            iRes = ifnActualizaEntidadMorosos(lhNumSecuencia);
            if  (iRes < 0) {
            	iError = -1;
            	break;
            }             	
		} /* end if  (strcmp(shEstado, TERMINADO)== 0) */               
		
	} /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_EntCobEx3; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1041;
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

} /* end ifnGeneraUnivArchCob( */

/* ============================================================================= */
/*  ifnActualizaEntidadMorosos()                                                 */
/* ============================================================================= */
int ifnActualizaEntidadMorosos(long lNumSecuencia)
{
char modulo[]   = "ifnActualizaEntidadMorosos";
int  iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
   long   lhCodCliente     ;
   char   shCodEntidad  [6]; /* EXEC SQL VAR shCodEntidad  IS STRING(6); */ 

   long   lhNumSecuencia   ;
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lhNumSecuencia = lNumSecuencia;

    /************************************************************************/
    /* Obtiene el Universo de Clientes a actualizar                         */
    /************************************************************************/
    /* EXEC SQL DECLARE Cur_Moro CURSOR for    
    SELECT B.COD_CLIENTE, B.COD_ENTIDAD
      FROM CO_PARAM_COBEX_TO A, CO_GESTION_COBEX_TO B
     WHERE A.NUM_SECUENCIA= :lhNumSecuencia
       and A.NUM_SECUENCIA= B.NUM_SECUENCIA; */ 
  
        
    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tDECLARE Cur_Moro - %s", LOG00,SQLERRM );
        return -1;
    }
    
    /* EXEC SQL OPEN Cur_Moro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0028;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1056;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuencia;
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


    if( SQLCODE != SQLOK ) {
        ifnTrazasLog( modulo, "\tOPEN Cur_Moro - %s", LOG00,SQLERRM );
        return -1;
    }

	while(1) {

        /* EXEC SQL FETCH Cur_Moro INTO :lhCodCliente, :shCodEntidad; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1075;
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
        sqlstm.sqhstv[1] = (unsigned char  *)shCodEntidad;
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

            
      
		if( SQLCODE  == SQLNOTFOUND) {
	        ifnTrazasLog( modulo, "\t No existen mas registros a procesar...", LOG03 );
			break; /* No hay mas empresas de cobranzas externa */
		}

        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )  {
	       ifnTrazasLog( modulo, "en FETCH : %s", LOG00, SQLERRM );
		   break;
	    }

        ifnTrazasLog( modulo, "Cliente - Secuencia - Entidad [%ld] - [%ld] - [%s]", LOG09, lhCodCliente, lhNumSecuencia, shCodEntidad);

        /* EXEC SQL	
        UPDATE CO_MOROSOS 
           SET COD_AGENTE = :shCodEntidad
         WHERE COD_CLIENTE = :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 26;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIEN\
TE=:b1";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1098;
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


        
        if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
          ifnTrazasLog( modulo, " UPDATE CO_MOROSOS - %s", LOG00, SQLERRM );
	      return -1;				
        }
            
	    } /* endwhile */
	      
	/* EXEC SQL CLOSE Cur_Moro; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 26;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1121;
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
  
} /* end ifnActualizaEntidadMorosos() */

/* ============================================================================= */
/*  ifnActualizaEstado                                                           */ 
/* ============================================================================= */
int ifnActualizaEstado(long lNumSecuencia, char *sEstado)
{
char  modulo[]   = "ifnActualizaEstado";
int   iError     = 0;     

/* EXEC SQL BEGIN DECLARE SECTION; */ 
   
  long   lhNumSecuencia   ;
  char   shEstado      [4]; /* EXEC SQL VAR shEstado IS STRING(4); */ 
  
/* EXEC SQL END DECLARE SECTION; */ 
                                                 

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);                      
    lhNumSecuencia = lNumSecuencia;
    strcpy(shEstado, sEstado);

    ifnTrazasLog( modulo, "lhNumSecuencia [%ld]", LOG09,lhNumSecuencia);                      
    ifnTrazasLog( modulo, "shEstado       [%s]", LOG09,shEstado);                      

    /* EXEC SQL	
    UPDATE CO_PARAM_COBEX_TO
       SET COD_ESTADO = :shEstado
     WHERE NUM_SECUENCIA = :lhNumSecuencia; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 26;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_PARAM_COBEX_TO  set COD_ESTADO=:b0 where NUM_SE\
CUENCIA=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1136;
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



    if( SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND ) {
      ifnTrazasLog( modulo, " UPDATE CO_PARAM_COBEX_TO - %s", LOG00, SQLERRM );
	  return -1;				
    }

    return iError;
  
} /* end ifnActualizaEstado() */

/* ============================================================================= */
/*  ifnGeneraArchCob() : Funcion que genera archivos de cobranza                 */
/* ============================================================================= */
int ifnGeneraArchCob(char *sCodEntidad, long lNumSecuencia)
{
char modulo[]= "ifnGeneraArchCob";
int  iError  = 0 ;     
int  iRes    = 0 ;

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG09,modulo);                      

    iRes = ifnGenArchivosDetafac(sCodEntidad, lNumSecuencia);
    if( iRes < 0 ) return -1;
        
    iRes = ifnGenArchivosFacturas(sCodEntidad, lNumSecuencia);
    if( iRes < 0 ) return -1;
        
    iRes = ifnGenArchivosCuentas(sCodEntidad, lNumSecuencia);
    if( iRes < 0 ) return -1;
        
    iRes = ifnGenArchivosTelefonos(sCodEntidad, lNumSecuencia);
    if( iRes < 0 ) return -1;
       
    iRes = ifnGenArchivosTelesCuenta(sCodEntidad, lNumSecuencia);
    if( iRes < 0 ) return -1;
            	
    return iError;

} /* end ifnGeneraArchCob( */

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
/*  ifnGenArchivosDetafac                                                        */
/* ============================================================================= */
int ifnGenArchivosDetafac(char *pCodEntidad, long lNumSecuencia)
{
char  szArchivoDetafac[256]=""; /* DETAFAC */
char  modulo[]="ifnGenArchivosDetafac";
int   iHayRegistro;
long  i;
int   iError;
char  shCodEntidad    [6]; 
long  lhNumSecuencia     ;    

    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, pCodEntidad);

    lhNumSecuencia = lNumSecuencia;
	
    /* Abrir archivo por empresa de cobranza para Archivo DETAFAC      */
    memset(szArchivoDetafac,0,sizeof(szArchivoDetafac));    /* DETAFAC */
    sprintf(stStatusArch.NomArchDetafac,"%s%s%s%ld","Detafac_",shCodEntidad, "_",lhNumSecuencia);
    sprintf(szArchivoDetafac,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchDetafac,szFechayyyymmdd);
    
    if((ArchDetafac = fopen(szArchivoDetafac,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo Detafac \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchDetafac);
    ifnTrazasLog(modulo, "Entidad - Secuencia [%s] - [%ld] \n", LOG09, shCodEntidad, lhNumSecuencia);

ifnTrazasLog(modulo, "lIndDetafac  [%ld]", LOG09, lIndDetafac);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndDetafac;i++)   {
 
ifnTrazasLog(modulo, "sthDetafac.sCodAgente   [i] [%ld] [%s]", LOG09, i, sthDetafac.sCodAgente[i]);
ifnTrazasLog(modulo, "sthDetafac.lNumRegistr  [i] [%ld] [%ld]", LOG09, i, sthDetafac.lNumRegistr[i]);
ifnTrazasLog(modulo, "sthDetafac.lNumSecuencia[i] [%ld] [%ld]", LOG09, i, sthDetafac.lNumSecuencia[i]);
 
		if (( strcmp(sthDetafac.sCodAgente[i],shCodEntidad)==0) && (sthDetafac.lNumRegistr[i] == 0) ) {
           if ( (fprintf( ArchDetafac, "CUENTA|CLASIFICACION|MONTO MORA| N°FACT.MORA|DIAS MORA|TIPO PRODUCTO|LINEAS MOV.ACTIVAS|LINEAS NO MOV.ACTIVOS\n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
      	}
       	
		if (( strcmp(sthDetafac.sCodAgente[i],shCodEntidad)==0) && (sthDetafac.lNumRegistr[i] > 0) && (sthDetafac.lNumSecuencia[i] == lhNumSecuencia)){

            iHayRegistro = 1;
            ifnTrazasLog(modulo, "sthDetafac.sCodAgente  [i] [%s]", LOG09, sthDetafac.sCodAgente[i]);
            ifnTrazasLog(modulo, "sthDetafac.lCodCliente [i] [%ld]", LOG09, sthDetafac.lCodCliente[i]);
            ifnTrazasLog(modulo, "sthDetafac.sClasificac [i] [%s] ", LOG09, sthDetafac.sClasificac[i]);
            ifnTrazasLog(modulo, "sthDetafac.dMontoMora  [i] [%.2f] ", LOG09, sthDetafac.dMontoMora[i]);
            ifnTrazasLog(modulo, "sthDetafac.iTotFactMor [i] [%d] ", LOG09, sthDetafac.iTotFactMor[i]);
            ifnTrazasLog(modulo, "sthDetafac.iDiasenMora [i] [%d] ", LOG09, sthDetafac.iDiasenMora[i]);
            ifnTrazasLog(modulo, "sthDetafac.sCodProducto[i] [%s] ", LOG09, sthDetafac.sCodProducto[i]);
            ifnTrazasLog(modulo, "sthDetafac.iTotLinMovil[i] [%d] ", LOG09, sthDetafac.iTotLinMovil[i]);
            ifnTrazasLog(modulo, "sthDetafac.iTotNotMovil[i] [%d] \n", LOG09, sthDetafac.iTotNotMovil[i]);
            
                /*                        1  |  2  |  3       |  4  |  5  |  6  |  7  |  8  */
           	if( (fprintf( ArchDetafac, "%ld %s %s %s %10.02f %s %d %s %d %s %s %s %d %s %d \n"
                                 ,sthDetafac.lCodCliente[i]
                                 ,szPipe
                                 ,sthDetafac.sClasificac[i]
                                 ,szPipe
                                 ,sthDetafac.dMontoMora[i]
                                 ,szPipe
                                 ,sthDetafac.iTotFactMor[i]
                                 ,szPipe 								 	 
                                 ,sthDetafac.iDiasenMora[i]
                                 ,szPipe
                                 ,sthDetafac.sCodProducto[i]
                                 ,szPipe
                                 ,sthDetafac.iTotLinMovil[i]
                                 ,szPipe
                                 ,sthDetafac.iTotNotMovil[i]		
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (ArchDetafac.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthDetafac.lNumRegistr[i] == -1))   {
          if ( (fprintf( ArchDetafac, " ***********   NO EXISTEN DATOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndDetafac */			

    if ( fclose(ArchDetafac) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo Detafac %s\n", shCodEntidad);
       fflush  (stderr);
    }

	return iError;	
	
} /* end ifnGenArchivosDetafac */

/* ============================================================================= */
/*  ifnGenArchivosFacturas                                                       */
/* ============================================================================= */
int ifnGenArchivosFacturas(char *pCodEntidad, long lNumSecuencia)
{
char szArchivoFacturas[256]=""; /* FACTURAS */
char modulo[]="ifnGenArchivosFacturas";
int  iHayRegistro;
int  i;
int  iError;
char shCodEntidad    [6]; 
long lhNumSecuencia     ;
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, pCodEntidad);

    lhNumSecuencia = lNumSecuencia;
	
    /* Abrir archivo por empresa de cobranza para Archivo FACTURAS      */
    memset(szArchivoFacturas,0,sizeof(szArchivoFacturas));  /* FACTURAS */
    sprintf(stStatusArch.NomArchFactura,"%s%s%s%ld","Factura_", shCodEntidad, "_",lhNumSecuencia);
    sprintf(szArchivoFacturas,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchFactura,szFechayyyymmdd);
    
    if((ArchFactura = fopen(szArchivoFacturas,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo Factura \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchFactura);
    ifnTrazasLog(modulo, "shCodEntidad [%s] -[%ld] \n", LOG09, shCodEntidad, lhNumSecuencia);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndFactura;i++)   {
 
		if (( strcmp(sthFactura.sCodAgente[i],shCodEntidad)==0) && (sthFactura.lNumRegistr[i] == 0)) {
           if ( (fprintf( ArchFactura, "CUENTA|FOLIO|SALDO MORA|FECHA VENCIMIENTO\n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
      	}
       	
		if (( strcmp(sthFactura.sCodAgente[i],shCodEntidad)==0) && (sthFactura.lNumRegistr[i] > 0) && (sthFactura.lNumSecuencia[i] == lhNumSecuencia)) {

            iHayRegistro = 1;            
             ifnTrazasLog(modulo, "sthFactura.sCodAgente  [i] [%s]", LOG09, sthFactura.sCodAgente[i]);
             ifnTrazasLog(modulo, "sthFactura.lCodCliente [i] [%ld]", LOG09, sthFactura.lCodCliente[i]);
             ifnTrazasLog(modulo, "sthFactura.lNumFolio   [i] [%ld] ", LOG09, sthFactura.lNumFolio[i]);
             ifnTrazasLog(modulo, "sthFactura.dSaldoMora  [i] [%.2f] ", LOG09, sthFactura.dSaldoMora[i]);
             ifnTrazasLog(modulo, "sthFactura.sFecVencim  [i] [%s] ", LOG09, sthFactura.sFecVencim[i]);
                /*                       1   |  2   |  3       |  4 */
           	if( (fprintf( ArchFactura, "%ld %s %ld %s %10.02f %s %s \n"
                                 ,sthFactura.lCodCliente[i]
                                 ,szPipe
                                 ,sthFactura.lNumFolio[i]
                                 ,szPipe
                                 ,sthFactura.dSaldoMora[i]
                                 ,szPipe
                                 ,sthFactura.sFecVencim[i]
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (ArchFactura.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthFactura.lNumRegistr[i] == -1))  {
          if ( (fprintf( ArchDetafac, " ***********   NO EXISTEN DATOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndFactura */			

    if ( fclose(ArchFactura) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo Factura %s\n", shCodEntidad);
       fflush  (stderr);
    }

	return iError;	
	
} /* end ifnGenArchivosFacturas */

/* ============================================================================= */
/*  ifnGenArchivosCuentas                                                        */
/* ============================================================================= */
int ifnGenArchivosCuentas(char *pCodEntidad, long lNumSecuencia)
{
char szArchivoCuentas[256]=""; /* CUENTAS */
char modulo[]="ifnGenArchivosCuentas";
int  iHayRegistro;
int  i;
int  iError;
char shCodEntidad    [6]; 
long lhNumSecuencia     ;
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, pCodEntidad);
    lhNumSecuencia = lNumSecuencia;
	
    /* Abrir archivo por empresa de cobranza para Archivo CUENTAS      */
    memset(szArchivoCuentas,0,sizeof(szArchivoCuentas));    /* CUENTAS */
    sprintf(stStatusArch.NomArchCuentas,"%s%s%s%ld","Cuentas_", shCodEntidad, "_",lhNumSecuencia);
    sprintf(szArchivoCuentas,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchCuentas,szFechayyyymmdd);
    
    if((ArchCuentas = fopen(szArchivoCuentas,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo Cuentas \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchCuentas);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndCuentas;i++)   {
 
		if (( strcmp(sthCuentas.sCodAgente[i],shCodEntidad)==0) && (sthCuentas.lNumRegistr[i] == 0)) {
           if ( (fprintf( ArchCuentas, "CUENTA|ESTADO|APELLIDOS|NOMBRES|NOMBRE EMPRESA|NIT|DIRECCION 1|DIRECCION 2|ZONA|DEPARTAMENTO|MUNICIPIO|TIPO DOCUMENTO|NRO DOCTO|EDAD|OCUPACION|TELEFONO TITULAR|REFERENCIA|TELEFONO REF 1|TELEFONO REF 2|SEGMENTO|CLASIFICACION|ESTATUS \n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
      	}
       	
		if (( strcmp(sthCuentas.sCodAgente[i],shCodEntidad)==0) && (sthCuentas.lNumRegistr[i] > 0) && (sthCuentas.lNumSecuencia[i] == lhNumSecuencia)) {

            iHayRegistro = 1;
            ifnTrazasLog(modulo, "sthCuentas.sCodAgente    [i] [%s]", LOG09, sthCuentas.sCodAgente[i]);
            ifnTrazasLog(modulo, "sthCuentas.lCodCliente   [i] [%ld]", LOG09, sthCuentas.lCodCliente[i]);
            ifnTrazasLog(modulo, "sthCuentas.sEstado       [i] [%s] ", LOG09, sthCuentas.sEstado[i]);
            ifnTrazasLog(modulo, "sthCuentas.sApellidos    [i] [%s] ", LOG09, sthCuentas.sApellidos[i]);
            ifnTrazasLog(modulo, "sthCuentas.sNombreClie   [i] [%s] ", LOG09, sthCuentas.sNombreClie[i]);
            ifnTrazasLog(modulo, "sthCuentas.sNombreEmpr   [i] [%s] ", LOG09, sthCuentas.sNombreEmpr[i]);
            ifnTrazasLog(modulo, "sthCuentas.sNIT          [i] [%s] ", LOG09, sthCuentas.sNIT[i]);
            ifnTrazasLog(modulo, "sthCuentas.sDireccion1   [i] [%s] ", LOG09, sthCuentas.sDireccion1[i]);
            ifnTrazasLog(modulo, "sthCuentas.sDireccion2   [i] [%s] ", LOG09, sthCuentas.sDireccion2[i]);
            ifnTrazasLog(modulo, "sthCuentas.sZona         [i] [%s] ", LOG09, sthCuentas.sZona[i]);
            ifnTrazasLog(modulo, "sthCuentas.sDepartamen   [i] [%s] ", LOG09, sthCuentas.sDepartamen[i]);
            ifnTrazasLog(modulo, "sthCuentas.sMunicipio    [i] [%s] ", LOG09, sthCuentas.sMunicipio[i]);
            ifnTrazasLog(modulo, "sthCuentas.sTipDocumento [i] [%s] ", LOG09, sthCuentas.sTipDocumento[i]);
            ifnTrazasLog(modulo, "sthCuentas.sNumDocumento [i] [%s] ", LOG09, sthCuentas.sNumDocumento[i]);
            ifnTrazasLog(modulo, "sthCuentas.sEdad         [i] [%s] ", LOG09, sthCuentas.sEdad[i]);
            ifnTrazasLog(modulo, "sthCuentas.sOcupacion    [i] [%s] ", LOG09, sthCuentas.sOcupacion[i]);
            ifnTrazasLog(modulo, "sthCuentas.sTelTitular   [i] [%s] ", LOG09, sthCuentas.sTelTitular[i]);
            ifnTrazasLog(modulo, "sthCuentas.sNomRefere1   [i] [%s] ", LOG09, sthCuentas.sNomRefere1[i]);
            ifnTrazasLog(modulo, "sthCuentas.sTelRefere1   [i] [%s] ", LOG09, sthCuentas.sTelRefere1[i]);
            ifnTrazasLog(modulo, "sthCuentas.sTelRefere2   [i] [%s] ", LOG09, sthCuentas.sTelRefere2[i]);
            ifnTrazasLog(modulo, "sthCuentas.sDesSegment   [i] [%s] ", LOG09, sthCuentas.sDesSegment[i]);
            ifnTrazasLog(modulo, "sthCuentas.sClasificacion[i] [%s] ", LOG09, sthCuentas.sClasificacion[i]);
            ifnTrazasLog(modulo, "sthCuentas.sEstatus      [i] [%s] ", LOG09, sthCuentas.sEstatus[i]);

                 /*                       1  |  2  |  3  |  4  |  5  |  6  |  7  |  8  |  9  | 10  | 11  | 12  | 13  |  14  | 15  |  16 |  17 |  18 |  19 |  20 |  21 |  22 */
           	if( (fprintf( ArchCuentas, "%ld %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s  %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s %s\n"
                                 ,sthCuentas.lCodCliente[i]
                                 ,szPipe
                                 ,sthCuentas.sEstado[i]
                                 ,szPipe
                                 ,sthCuentas.sApellidos[i]
                                 ,szPipe
                                 ,sthCuentas.sNombreClie[i]
                                 ,szPipe 								 	 
                                 ,sthCuentas.sNombreEmpr[i]
                                 ,szPipe
                                 ,sthCuentas.sNIT[i]
                                 ,szPipe
                                 ,sthCuentas.sDireccion1[i]
                                 ,szPipe
                                 ,sthCuentas.sDireccion2[i]		
                                 ,szPipe
                                 ,sthCuentas.sZona[i]		
                                 ,szPipe
                                 ,sthCuentas.sDepartamen[i]		
                                 ,szPipe
                                 ,sthCuentas.sMunicipio[i]		
                                 ,szPipe
                                 ,sthCuentas.sTipDocumento[i]		
                                 ,szPipe
                                 ,sthCuentas.sNumDocumento[i]		
                                 ,szPipe
                                 ,sthCuentas.sEdad[i]		
                                 ,szPipe
                                 ,sthCuentas.sOcupacion[i]		
                                 ,szPipe
                                 ,sthCuentas.sTelTitular[i]		
                                 ,szPipe
                                 ,sthCuentas.sNomRefere1[i]		
                                 ,szPipe
                                 ,sthCuentas.sTelRefere1[i]		
                                 ,szPipe
                                 ,sthCuentas.sTelRefere2[i]		
                                 ,szPipe
                                 ,sthCuentas.sDesSegment[i]		
                                 ,szPipe
                                 ,sthCuentas.sClasificacion[i]		
                                 ,szPipe
                                 ,sthCuentas.sEstatus[i]		                                                                  
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (ArchCuentas.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthCuentas.lNumRegistr[i] == -1))  {
          if ( (fprintf( ArchCuentas, " ***********   NO EXISTEN DATOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndCuentas */			

    if ( fclose(ArchCuentas) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo Cuentas %s\n", shCodEntidad);
       fflush  (stderr);
    }

	return iError;	
	
} /* end ifnGenArchivosCuentas */

/* ============================================================================= */
/*  ifnGenArchivosTelefonos                                                      */
/* ============================================================================= */
int ifnGenArchivosTelefonos(char *pCodEntidad, long lNumSecuencia)
{
char  szArchivoTelefono[256]=""; /* TELEFONOS */
char  modulo[]="ifnGenArchivosTelefonos";
int   iHayRegistro;
int   i;
int   iError;
char  shCodEntidad    [6]; 
long  lhNumSecuencia;
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, pCodEntidad);
    lhNumSecuencia = lNumSecuencia;
	
    /* Abrir archivo por empresa de cobranza para Archivo TELEFONOS      */
    memset(szArchivoTelefono,0,sizeof(szArchivoTelefono));/* TELEFONOS */
    sprintf(stStatusArch.NomArchTelefon,"%s%s%s%ld","Telefono_", shCodEntidad, "_",lhNumSecuencia);
    sprintf(szArchivoTelefono,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchTelefon,szFechayyyymmdd);
    
    if((ArchTelefono = fopen(szArchivoTelefono,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo Telefono \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchTelefon);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndTelefon;i++)   {

		if (( strcmp(sthTelefono.sCodAgente[i],shCodEntidad)==0) && (sthTelefono.lNumRegistr[i] == 0) ) {
           if ( (fprintf( ArchTelefono, "CUENTA|TELEFONO|SEGMENTO|PRODUCTO|CLASIFICACION\n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
      	}
       	
		if (( strcmp(sthTelefono.sCodAgente[i],shCodEntidad)==0) && (sthTelefono.lNumRegistr[i] > 0) && (sthTelefono.lNumSecuencia[i] == lhNumSecuencia)) {

             iHayRegistro = 1;            
             ifnTrazasLog(modulo, "sthTelefono.sCodAgente    [i] [%s]", LOG09, sthTelefono.sCodAgente[i]);
             ifnTrazasLog(modulo, "sthTelefono.lCodCliente   [i] [%ld]", LOG09, sthTelefono.lCodCliente[i]);
             ifnTrazasLog(modulo, "sthTelefono.lNumCelular   [i] [%ld]", LOG09, sthTelefono.lNumCelular[i]);
             ifnTrazasLog(modulo, "sthTelefono.sDesSegment   [i] [%s] ", LOG09, sthTelefono.sDesSegment[i]);
             ifnTrazasLog(modulo, "sthTelefono.sDesProducto  [i] [%s] ", LOG09, sthTelefono.sDesProducto[i]);
             ifnTrazasLog(modulo, "sthTelefono.sClasificacion[i] [%s] ", LOG09, sthTelefono.sClasificacion[i]);

                /*                       1   |  2   |  3  |  4  |  5*/
           	if( (fprintf( ArchFactura, "%ld %s %ld %s %s %s %s %s %s\n"
                                 ,sthTelefono.lCodCliente[i]
                                 ,szPipe
                                 ,sthTelefono.lNumCelular[i]
                                 ,szPipe
                                 ,sthTelefono.sDesSegment[i]
                                 ,szPipe
                                 ,sthTelefono.sDesProducto[i]
                                 ,szPipe
                                 ,sthTelefono.sClasificacion[i]
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (sthTelefono.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthTelefono.lNumRegistr[i] == -1)) {
          if ( (fprintf( ArchDetafac, " ***********   NO EXISTEN DATOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndTelefon */			

    if ( fclose(ArchTelefono) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo Telefono %s\n", shCodEntidad);
       fflush  (stderr);
    }

	return iError;	
	
} /* end ifnGenArchivosTelefonos */

/* ============================================================================= */
/*  ifnGenArchivosTelesCuenta                                                    */
/* ============================================================================= */
int ifnGenArchivosTelesCuenta(char *pCodEntidad, long lNumSecuencia)
{
char szArchivoTelesCuenta[256]=""; /* TELESCUENTA */
char modulo[]="ifnGenArchivosTelesCuenta";
int  iHayRegistro;
int  i;
int  iError;
char shCodEntidad    [6]; 
long lhNumSecuencia     ;
    
    ifnTrazasLog( modulo, "\n\tEn funcion %s", LOG03,modulo);   
    memset( shCodEntidad, '\0',sizeof(shCodEntidad));
    strcpy(shCodEntidad, pCodEntidad);
    lhNumSecuencia = lNumSecuencia; 
	
    /* Abrir archivo por empresa de cobranza para Archivo TELESCUENTA          */
    memset(szArchivoTelesCuenta,0,sizeof(szArchivoTelesCuenta));/* TELESCUENTA */
    sprintf(stStatusArch.NomArchTeleCta,"%s%s%s%ld","TelesCuenta_", shCodEntidad, "_",lhNumSecuencia);
    sprintf(szArchivoTelesCuenta,"%s/%s_%s.txt",szPathDat,stStatusArch.NomArchTeleCta,szFechayyyymmdd);
    
    if((ArchTelesCta = fopen(szArchivoTelesCuenta,"a")) == (FILE*)NULL ) {    
       fprintf (stderr,"Error al crear archivo TelesCuenta \n");
       fflush  (stderr);
       return -1;    
    }
    
    ifnTrazasLog(modulo, "[%s] - APERTURA DE ARCHIVO - [%s] \n", LOG09, szFechayyyymmdd, stStatusArch.NomArchTeleCta);
    ifnTrazasLog(modulo, "shCodEntidad [%s] \n", LOG09, shCodEntidad);
	   
	iHayRegistro = 0;
    for (i=0;i<=lIndTeleCta;i++)   {

		if (( strcmp(sthTCuentas.sCodAgente[i],shCodEntidad)==0) && (sthTCuentas.lNumRegistr[i] == 0)) {
           if ( (fprintf( ArchTelesCta, "CUENTA|SERVICIO\n") ) == -1 ){	
			    ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero ",LOG01);
				return FALSE;            			
			}		    	
      	}
       	
		if (( strcmp(sthTCuentas.sCodAgente[i],shCodEntidad)==0) && (sthTCuentas.lNumRegistr[i] > 0)&& (sthTCuentas.lNumSecuencia[i] == lhNumSecuencia)) {

             iHayRegistro = 1;            
             ifnTrazasLog(modulo, "sthTCuentas.sCodAgente    [i] [%s]", LOG09, sthTCuentas.sCodAgente[i]);
             ifnTrazasLog(modulo, "sthTCuentas.lCodCliente   [i] [%ld]", LOG09, sthTCuentas.lCodCliente[i]);
             ifnTrazasLog(modulo, "sthTCuentas.sDesProducto  [i] [%s]", LOG09, sthTCuentas.sDesProducto[i]);

                /*                       1   |  2  */
           	if( (fprintf( ArchFactura, "%ld %s %s \n"
                                 ,sthTCuentas.lCodCliente[i]
                                 ,szPipe
                                 ,sthTCuentas.sDesProducto[i]
                   		)   ) == -1 ){	
			   ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (1)",LOG01);
			   return FALSE;            			
			}
				 				 				 
      } /* end if ( (sthTCuentas.sCodAgente[i],shCodEntidad)==0) )  {*/
            
      if ((iHayRegistro == 0) && (sthTCuentas.lNumRegistr[i] == -1)) {
          if ( (fprintf( ArchDetafac, " ***********   NO EXISTEN DATOS PARA EL DIA DE HOY   *********** \n") ) == -1 ){	
		      ifnTrazasLog(modulo,"Error al Escribir en Fin de Fichero (2)",LOG01);
			  return FALSE;            			
		   }		    	
      }

    } /* end for lIndTeleCta */			

    if ( fclose(ArchTelesCta) != 0 )    {    
       fprintf (stderr,"Error al cerrar archivo TelesCuenta %s\n", shCodEntidad);
       fflush  (stderr);
    }

	return iError;	
	
} /* end ifnGenArchivosTelesCuenta */

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
