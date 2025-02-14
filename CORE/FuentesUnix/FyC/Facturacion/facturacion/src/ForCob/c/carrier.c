
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
           char  filnam[16];
};
static struct sqlcxp sqlfpn =
{
    15,
    "./pc/carrier.pc"
};


static unsigned int sqlctx = 1722907;


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
   unsigned char  *sqhstv[21];
   unsigned long  sqhstl[21];
            int   sqhsts[21];
            short *sqindv[21];
            int   sqinds[21];
   unsigned long  sqharm[21];
   unsigned long  *sqharc[21];
   unsigned short  sqadto[21];
   unsigned short  sqtdso[21];
} sqlstm = {12,21};

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

 static char *sq0005 = 
"select distinct A.COD_CLIENTE  from CO_CARTERA A where (A.COD_CONCEPTO=:b0 a\
nd A.FEC_EFECTIVIDAD between TO_DATE(:b1,'YYYYMMDD') and TO_DATE(:b2,'YYYYMMDD\
')) order by A.COD_CLIENTE            ";

 static char *sq0006 = 
"select distinct A.COD_CLIENTE ,A.NUM_ABONADO ,A.COD_TIPDOCUM ,A.COD_CENTREMI\
 ,A.NUM_SECUENCI ,A.COD_VENDEDOR_AGENTE ,A.LETRA ,A.COD_CONCEPTO ,A.COLUMNA ,A\
.NUM_FOLIO ,A.IMPORTE_HABER  from CO_CANCELADOS A ,GE_DATOSGENER B where (((A.\
IMPORTE_DEBE=A.IMPORTE_HABER and A.COD_CONCEPTO=:b0) and A.FEC_EFECTIVIDAD bet\
ween TO_DATE(:b1,'YYYYMMDD') and TO_DATE(:b2,'YYYYMMDD')) and A.COD_PRODUCTO=B\
.PROD_CELULAR) order by A.COD_CLIENTE,A.NUM_SECUENCI,A.COD_TIPDOCUM,A.COD_VEND\
EDOR_AGENTE,A.LETRA,A.COD_CENTREMI,A.COD_CONCEPTO,A.COLUMNA,A.NUM_ABONADO,A.NU\
M_FOLIO            ";

 static char *sq0009 = 
"select B.IMP_CONCEPTO ,B.NUM_SECUENCI ,B.COD_TIPDOCUM ,B.COD_VENDEDOR_AGENTE\
 ,B.LETRA ,B.COD_CENTREMI ,TO_CHAR(B.FEC_CANCELACION,'YYYYMMDD') ,TO_CHAR(A.FE\
C_EFECTIVIDAD,'YYYYMMDD') ,TO_CHAR(A.FEC_EFECTIVIDAD,'DD')  from CO_CANCELADOS\
 A ,CO_PAGOSCONC B where (((((((((((((((A.COD_CLIENTE=:b0 and A.COD_TIPDOCUM=:\
b1) and A.COD_CENTREMI=:b2) and A.NUM_SECUENCI=:b3) and A.COD_VENDEDOR_AGENTE=\
:b4) and A.LETRA=:b5) and A.COD_CONCEPTO=:b6) and A.COLUMNA=:b7) and A.NUM_ABO\
NADO=:b8) and A.NUM_SECUENCI=B.NUM_SECUREL) and A.COD_TIPDOCUM=B.COD_TIPDOCREL\
) and A.COD_VENDEDOR_AGENTE=B.COD_AGENTEREL) and A.LETRA=B.LETRA_REL) and A.CO\
D_CENTREMI=B.COD_CENTRREL) and A.NUM_ABONADO=B.NUM_ABONADO) and A.COD_CONCEPTO\
=B.COD_CONCEPTO)           ";

 static char *sq0014 = 
"select A.COD_TIPDOCUM ,A.COD_CENTREMI ,A.NUM_SECUENCI ,A.COD_VENDEDOR_AGENTE\
 ,A.LETRA ,A.NUM_ABONADO ,A.COD_PRODUCTO ,A.COD_CONCEPTO ,A.COLUMNA ,A.IMPORTE\
_DEBE ,A.IMPORTE_HABER ,A.NUM_FOLIO ,A.NUM_CUOTA ,A.SEC_CUOTA ,A.NUM_TRANSACCI\
ON ,A.NUM_VENTA ,A.NUM_FOLIOCTC  from CO_CARTERA A ,CO_CONCEPTOS B where (((A.\
COD_CLIENTE=:b0 and A.COD_CONCEPTO=:b1) and A.COD_CONCEPTO=B.COD_CONCEPTO) and\
 A.FEC_EFECTIVIDAD between TO_DATE(:b2,'YYYYMMDD') and TO_DATE(:b3,'YYYYMMDD')\
) order by A.COD_TIPDOCUM,A.NUM_SECUENCI,A.FEC_ANTIGUEDAD,B.ORDEN_CAN  for upd\
ate ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,12,0,1,139,0,0,0,0,0,1,0,
20,0,0,2,57,0,4,180,0,0,1,0,0,1,0,2,5,0,0,
39,0,0,3,57,0,4,220,0,0,2,0,0,1,0,2,5,0,0,2,5,0,0,
62,0,0,4,0,0,29,269,0,0,0,0,0,1,0,
77,0,0,5,192,0,9,331,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
104,0,0,5,0,0,13,343,0,0,1,0,0,1,0,2,3,0,0,
123,0,0,5,0,0,15,362,0,0,0,0,0,1,0,
138,0,0,6,563,0,9,543,0,0,3,3,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,
165,0,0,6,0,0,13,555,0,0,11,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,
224,0,0,7,65,0,4,613,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
247,0,0,8,66,0,4,623,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
270,0,0,6,0,0,15,657,0,0,0,0,0,1,0,
285,0,0,9,727,0,9,761,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
336,0,0,9,0,0,13,769,0,0,9,0,0,1,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,
0,0,2,5,0,0,2,5,0,0,2,5,0,0,
387,0,0,9,0,0,15,977,0,0,0,0,0,1,0,
402,0,0,10,55,0,4,1004,0,0,1,0,0,1,0,2,5,0,0,
421,0,0,11,271,0,5,1044,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,
460,0,0,12,256,0,4,1087,0,0,7,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,
503,0,0,13,444,0,3,1213,0,0,17,17,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,3,0,0,1,4,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,
586,0,0,14,548,0,9,1359,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
617,0,0,14,0,0,13,1371,0,0,17,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,2,5,0,0,
700,0,0,14,0,0,15,1472,0,0,0,0,0,1,0,
715,0,0,15,442,0,3,1654,0,0,21,21,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,
0,1,4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
814,0,0,16,975,0,3,1746,0,0,11,11,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
873,0,0,17,247,0,2,1824,0,0,10,10,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,
0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
928,0,0,18,178,0,4,1936,0,0,5,4,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
963,0,0,19,178,0,4,1953,0,0,5,4,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/****************************************************************************/
/*                                                                          */
/*    Programa    : Generacion de FORCOB para los Carrier.                  */
/*                                                                          */
/****************************************************************************/
/*                                                                          */
/*    Patricio Gonzalez Gomez.                                              */
/*    18-02-2002                                                            */
/*  - Modificacion referente a la incorporacion de la causa de              */
/*  pago en el archivo .cob que se genera. La optencion de la               */
/*  causa de pago se hace de la tabla CO_PAGOS.                             */
/*  - Incorporacion en el archivo de Log del resumen de parametros          */
/*  leidos por la aplicacion                                                */
/****************************************************************************/
/*  13-06-2002 Modificado por Nelson Contreras Helena                       */
/*              Inclusion de rutina bGetCausaPago                           */
/****************************************************************************/
/*  -PGonzaleg 1-08-2002                                                    */
/*      Modificacion del largo del los campos "Codigo de Banco"             */
/****************************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>
#include <math.h>
#include <signal.h>
#include <time.h>
#include <sys/types.h>
#include <sys/times.h>
#include <sys/time.h>

#include <GenTypes.h>
#include <GenORA.h>
#include <coerr.h>

#include "carrier.h"

double rint(double);

/***************************************************************************/
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

/***************************************************************************/


/***************************************************************************/
/*   VARIABLES GLOBALES                            */
/***************************************************************************/

static DATGEN  stDatGen;  /* Datos Generales                               */
static DATPRO  stDatPro;  /* Datos de Proceso                              */

/****************************************************************************/
/******************************* Inicio del programa ************************/
/****************************************************************************/


int main(int argc, char *argv[])
{
  int       iResul  ;
  char      sFich[336];

    fprintf (stderr, "Version [%s] con fecha [%s]\n",szVersionActual, szUltimaModificacion);

    memset(&stLineaComando,0    ,sizeof(FOLIACIONLINEACOMANDO));

    /* Carga de Variables Globales, apertura de Ficheros conexion Oracle*/
    iResul = ifnInitInstance(argc, argv);

    if (iResul != OK)
        return iResul;

    stDatPro.lNumReg = 0;
    stDatPro.dImpTotal = 0.0;

    /* Cancelacion de la deuda en cartera */
    iResul = ifnDBTratCartera(argv[4]);


    if (iResul != OK)
    {
        return iResul;
    }

    /* Generar el fichero del carrier */
    iResul = ifnDBTratAbonados();

    if (iResul != OK)
    {
        return iResul;
    }

    /* Liberar memoria, desconexion, cierre de ficheros */
    vfnExitInstance(TRUE);

  return OK;

} /* Fin main() */

/***************************************************************************/
/* Descripcion: Inicializar Variables Globales, comprobar linea de comandos
                ,apertura de ficheros, recogida de datos generales...
Salida     : En caso de Error devuelve ERR_XXX y si todo va bien OK.       */
/***************************************************************************/
int ifnInitInstance(int argc, char *argv[])
{
    char szTraza[81];
    char sFich[336];
    char sLog[336];
    int  iRet;
    char Ciclo[3];
    int  Causa;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char szhFechaHoy[11]; /* EXEC SQL VAR szhFechaHoy IS STRING(11); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    FOLIACIONLINEACOMANDO *pstLineaCom;


    /* Comprobamos linea de comandos */
    if (argc != 6)
    {
        fprintf(stderr,"\nForma de Ejecucion :\n");
        fprintf(stderr,"\tFechas con el siguiente formato [YYYYMMDD]\n");
        fprintf(stderr,"\tCodigo Carrier sin 1. [188] = [88]\n");
        fprintf(stderr,"\n\t%s CodCarrier fechaIni fechaFin usuario password \n", argv[0]);
        fprintf(stderr,"\tEjemplo : carrier2000 88 20020728 20020801 factura pepito\n");

        return ERR_PARAMETROS;
    }

    if (ifnConnectORA(argv[4],argv[5]))
    {
        fprintf(stderr,"\nImposible Conectar a Oracle\n");
        return ERR_CONEXION;
    }

    /* EXEC SQL SET ROLE ALL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 0;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "set role ALL";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (!bfnDBCargaDatGen())
        return ERR_DATGEN;

    stDatPro.iCarrier = atoi(argv[1]);
    strcpy(stDatPro.szFecIni,argv[2]);
    strcpy(stDatPro.szFecFin,argv[3]);


    /* Preparamos apertura de archivos */
    sprintf(sFich,"%s/%d%s.cob",stDatGen.szPathFich,stDatPro.iCarrier,stDatPro.szFecFin);
    sprintf(sLog,"%s/%d%s.log",stDatGen.szPathFich,stDatPro.iCarrier,stDatPro.szFecFin);

    fprintf(stdout,"\nArchivo de Datos : %s\n",sFich);
    fprintf(stdout,"\nArchivo de Log   : %s\n\n",sLog);

    /* Apertura del fichero */
    if ((stDatPro.pFich = fopen(sFich,"w")) == (FILE*) NULL)
    {
        fprintf(stderr,"\n No se pudo abrir : %s\n",sFich);
        perror("fopen");
        return ERR_ABRIRFICH;
    }

    /* Apertura del fichero de log */
    if ((stDatPro.pLog = fopen(sLog,"w")) == (FILE*) NULL)
    {
        fprintf(stderr,"\n No se pudo abrir : %s\n",sLog);
        perror("fopen");
        return ERR_ABRIRFICH;
    }

    /* Nivel de log e inicializacion de contadores */
    stDatPro.lNumReg = 0;
    stDatPro.iNumAno = 0;
    stDatPro.iNumPag = 0;
    stDatPro.dImpTotal     = 0.0;
    stDatPro.dImpAnomalias = 0.0;
    stDatPro.dImpPagos     = 0.0;

    /* EXEC SQL                                    /o Incorporado por PGonzaleg 19-02-2002 o/
        SELECT TO_CHAR (SYSDATE,'DD-MM-YYYY')
        INTO :szhFechaHoy FROM dual; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(SYSDATE,'DD-MM-YYYY') into :b0  from dual ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )20;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFechaHoy;
    sqlstm.sqhstl[0] = (unsigned long )11;
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



    fprintf(stDatPro.pLog, "################################################################\n"
                           "#                 GENERACION DEL FICHERO DE CARRIER            #\n"
                           "################################################################\n"
                           "=> Version [%s] con fecha [%s]                 \n"
                           "################################################################\n"
                           "PARAMETROS DE ENTRADA\n\n"
                           "CODIGO CARRIER          [%i] \n"
                           "FECHA DESDE             [%s] \n"
                           "FECHA HASTA             [%s] \n"
                           "USUARIO                 [%s] \n"
                           "FECHA HOY (DD-MM-YYY)   [%s] \n\n\n"
                           ,szVersionActual, szUltimaModificacion, stDatPro.iCarrier
                           ,stDatPro.szFecIni, stDatPro.szFecFin, argv[4],szhFechaHoy); /* Incorporado por PGonzaleg 19-02-2002 */

    fprintf(stDatPro.pLog, "%s [ifnInitInstance] Creacion del archivo y la cabecera del LOG\n\n",cfnGetTime(3)); /* Incorporado por PGonzaleg 28-02-2002 */

    return OK;

} /* Fin InitInstance */

/******************************************************************************/

/***************************************************************************/
BOOL bfnDBCargaDatGen()
/**
Recupera datos de la tabla CO_DATGEN en la variable globla stDatGen.
En caso de Error devuelve FALSE.
**/
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 


        char szhPathCarrier[256]  ; /* EXEC SQL VAR szhPathCarrier IS STRING(256); */ 

        char szhPathLog[256]   ; /* EXEC SQL VAR szhPathLog IS STRING(256); */ 


    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL
        SELECT PATHCARRIER   ,
               PATHLOG
        INTO   :szhPathCarrier,
               :szhPathLog
        FROM   CO_DATGEN; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select PATHCARRIER ,PATHLOG into :b0,:b1  from CO_DATGEN ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )39;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhPathCarrier;
    sqlstm.sqhstl[0] = (unsigned long )256;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPathLog;
    sqlstm.sqhstl[1] = (unsigned long )256;
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



    if (sqlca.sqlcode)
    {
        fprintf(stderr,"Error al recuperar datos generales %s\n",
                    szfnORAerror());
        return FALSE;
    }

    strcpy(stDatGen.szPathFich     ,szhPathCarrier);
    strcpy(stDatGen.szPathProc     ,szhPathCarrier);
    strcpy(stDatGen.szPathLog      ,szhPathLog);

    return TRUE;

} /* Fin bfnDBCargaDatGen() */

/***************************************************************************/
void TRAZA (const char* szCad)
/**
Imprime la cadena el el fichero de log.
Usa la variable general stDatPro.
**/
{
/*  if (stDatPro.iLog)*/
        fprintf(stDatPro.pLog,"%s",szCad);

} /* Fin TRAZA() */
/***************************************************************************/
void vfnExitInstance(BOOL bBien)
/**
Funcion final del proceso.
Libera memoria de estructuras en memoria.
Cierra ficheros.
Desconecta de Oracle.
**/
{
    char szSystem[512];
    int  iRet;


    TRAZA ("#############################################################\n");
    TRAZA ("ExitInstance() ");

    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )62;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode)
    {
        fprintf(stderr,"** ERROR: No se Pudo hacer COMMIT Final\n");
        fprintf(stDatPro.pLog,"** ERROR: No se Pudo hacer COMMIT Final\n");
        fprintf(stDatPro.pLog,"%s\n\n",szfnORAerror());
    }


    /* Desconexion de Oracle */
    iRet = ifnDisConnORA();

    fprintf(stDatPro.pLog,
            "\n############################################################\n"
              "##                      FIN PROCESO                       ##\n"
              "############################################################\n");
    /* Cerramos ficheritos */
    fclose(stDatPro.pFich);
    fclose(stDatPro.pLog);

    if (bBien)
    {
        /* Llevamos el fichero procesado a otro directorio */
        /*sprintf(szSystem,"mv %s/%s %s/%s.PROC",stDatGen.szPathFich,
            stDatPro.szNomFich,stDatGen.szPathProc,stDatPro.szNomFich);
        system(szSystem);*/
    }

    return;

} /* Fin ExitInstance */

/****************************************************************************/
int ifnDBTratCartera(char *szUsuario)
/**
Descripcion: Funcion que cancela la deuda del carrier en cartera
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCliente   ;
    int     ihCodCarrier  ;
    char    szhFecIni[9]; /* EXEC SQL VAR szhFecIni IS STRING(9); */ 

    char    szhFecFin[9]; /* EXEC SQL VAR szhFecFin IS STRING(9); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


   int      iResul     ;
   BOOL     bResul      ;

    fprintf(stdout,"CANCELANDO CARRIER . . .\n");
    ihCodCarrier = stDatPro.iCarrier;
    strcpy(szhFecIni,stDatPro.szFecIni);
    strcpy(szhFecFin,stDatPro.szFecFin);

    /* Cursor para recuperar todos los abonados con Conceptos carrier . */
    /* EXEC SQL DECLARE C_CANCARCLI CURSOR FOR
        SELECT  DISTINCT(A.COD_CLIENTE)
        FROM    CO_CARTERA A
        WHERE   A.COD_CONCEPTO = :ihCodCarrier
        AND A.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhFecIni,'YYYYMMDD') AND TO_DATE(:szhFecFin,'YYYYMMDD')
        ORDER BY A.COD_CLIENTE; */ 


    /* EXEC SQL OPEN C_CANCARCLI; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )77;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCarrier;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecIni;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecFin;
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



    fprintf(stDatPro.pLog, "%s [ifnDBTratCartera] Inicia Cursor -CANCELANDO CARRIER- \n\n",cfnGetTime(3)); /* Incorporado por PGonzaleg 28-02-2002 */

    if (sqlca.sqlcode)
    {
        fprintf(stderr,"* Error en Apertura de Cursor TratAbonado%s\n", szfnORAerror());
        return ERR_OPENCURSOR;
    }

    while (TRUE)
    {
        /* EXEC SQL FETCH C_CANCARCLI
            INTO    :lhCodCliente; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 3;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )104;
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



        if (sqlca.sqlcode < 0)
        {
            fprintf(stderr,"* Error en Fetch  %s\n",szfnORAerror());
            return ERR_FETCH;
        }

        if (sqlca.sqlcode == NOT_FOUND)
        {
            break;
        }

        iResul = ifnDBTratCarteCelular(lhCodCliente,szUsuario);
        if (iResul != OK)
            return ERR_CARRABO;
    }

    /* EXEC SQL CLOSE C_CANCARCLI; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )123;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    fprintf(stDatPro.pLog, "%s [ifnDBTratCartera] Finaliza Cursor -CANCELANDO CARRIER- \n\n",cfnGetTime(3)); /* Incorporado por PGonzaleg 28-02-2002 */

    if (sqlca.sqlcode != 0)
    {
        fprintf(stderr,"* Error en Cierre de Cursor %s\n",szfnORAerror());
        return ERR_CLOSECURSOR;
    }

    return OK;

}/* Fin ifnDBTratCartera() */
/****************************************************************************/
int ifnDBTratCarteCelular(long lCodCliente,char *szUsuario)
/**
Descripcion: Funcion que se encarga de cancelar la deuda de los carrier en la
                 cartera del cliente
Salida     : OK si todo va bien o ERR_xxx si falla algo
**/
{
    BOOL    bResul ;
    int     iResul ;
    char    szFecha[9];
    int     iCodTipDocum;
    int     iCodCentremi;
    long    lCodAgente;
    char    szLetra[2];
    long    lNumSecuenci;
    int     iSisPago;
    int     iCauPago;
    int     iOriPago;
    DATPAG  stDatPag;

    /* Tomar los datos generales del pago */
    bResul = bDBTomarSecuencia( &iCodTipDocum,&iCodCentremi,&lCodAgente,
                    szLetra, &lNumSecuenci, &iSisPago, &iOriPago,&iCauPago);
    if (!bResul)
        return ERR_SELPAG;

    /* Obtener la fecha del sistema formato yyyymmdd */
    bResul = bfnDBFechaSys(szFecha);
    if (!bResul)
        return ERR_FECHA;

    /* Preparar valores para insercion en co_pagos */
    stDatPag.stDatDocPago.iCodTipDocum = iCodTipDocum;
    stDatPag.stDatDocPago.lCodAgente = lCodAgente;
    strcpy(stDatPag.stDatDocPago.szLetra, szLetra);
    stDatPag.stDatDocPago.iCodCentrEmi = iCodCentremi;
    stDatPag.stDatDocPago.lNumSecuenci = lNumSecuenci;
    stDatPag.lCodCliente = lCodCliente;
    strcpy(stDatPag.szFecValor  , szFecha);
    strcpy(stDatPag.szNomUsu,szUsuario);
    stDatPag.iCodSisPago = iSisPago;
    stDatPag.iCodOriPago = iOriPago;
    stDatPag.iCodCauPago = iCauPago;
    strcpy(stDatPag.szCodBanco,"");
    strcpy(stDatPag.szCodSucursal,"");
    strcpy(stDatPag.szCtaCorriente,"");
    strcpy(stDatPag.szCodTipTarjeta,"");
    strcpy(stDatPag.szNumTarjeta,"");

    /* Tratar todas las facturas de los carrier no canceladas por cliente */
    iResul = ifnDBPagoUnAbonado(&stDatPag,lCodCliente,stDatPro.iCarrier);
    if (iResul != OK)
        return iResul;

    /* Al final de tratar al cliente se ha de hacer un insert en CO_PAGOS */
    bResul = bfnDBInsDatosPago(&stDatPag);
    if (!bResul)
        return ERR_INSPAG;

    return OK;

}/* Fin ifnDBTratCarteCelular() */
/****************************************************************************/
int ifnDBTratAbonados(void)
/**
Descripcion: Funcion que se encarga de insertar el importe por abonado en el
                 fichero de carrier.
Salida     :    OK si todo va bien,
        ERR_xxx si falla algo
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      long      lhCodCliente        ;
      long      lhNumAbonado        ;
      long      lhNumCelular        ;
      long      lhCodTipdocum       ;
      long      lhCodCentremi       ;
      long      lhNumSecuenci       ;
      long      lhCodVendedorAgente ;
      char      szhLetra[2]         ;/* EXEC SQL VAR szhLetra IS STRING(2); */ 

      long      lhCodConcepto       ;
      long      lhCodColumna        ;
      long      lhNumFolio          ;
      double    dhImporte           ;
      int       ihCodCarrier        ;
      char      szhFecIni[9]        ; /* EXEC SQL VAR szhFecIni IS STRING(9); */ 

      char      szhFecFin[9]        ; /* EXEC SQL VAR szhFecFin IS STRING(9); */ 

      long      lhCodClienteAux     ;
      long      lhNumAbonadoAux     ;
      long      lhNumCelularAux     ;
      long      lhCodTipdocumAux    ;
      long      lhCodCentremiAux    ;
      long      lhNumSecuenciAux    ;
      long      lhCodVendedorAgenteAux  ;
      char      szhLetraAux[2]      ;/* EXEC SQL VAR szhLetraAux IS STRING(2); */ 

      long      lhCodConceptoAux    ;
      long      lhCodColumnaAux     ;
      long      lhNumFolioAux       ;
   /* EXEC SQL END DECLARE SECTION; */ 


    int      iResul     ;
    BOOL     bResul      ;
    char        szFecha[9];
    long        lCount = 0;
    LOCALPARAM  stlocalparam;
    lhCodClienteAux         =0;
    lhNumAbonadoAux         =0;
    lhNumCelularAux         =0;
    lhCodTipdocumAux        =0;
    lhCodCentremiAux        =0;
    lhNumSecuenciAux        =0;
    lhCodVendedorAgenteAux  =0;
    szhLetraAux[0]          = '\0';
    lhCodConceptoAux        =0;
    lhCodColumnaAux         =0;
    lhNumFolioAux           =0;

    memset(&stlocalparam,0    ,sizeof(LOCALPARAM));

    ihCodCarrier = stDatPro.iCarrier;
    strcpy(szhFecIni,stDatPro.szFecIni);
    strcpy(szhFecFin,stDatPro.szFecFin);
    fprintf(stdout,"GENERANDO ARCHIVO . . .\n");

    bResul = bfnDBFechaSys(szFecha);
    if (!bResul)
        return ERR_FECHA;

     /* escribe CABECERA en blanco */
    fprintf(stDatPro.pFich,"000000000000000000000000000000000000000000000000000000000000000000000000000\n");

    fprintf(stDatPro.pLog,"%s Parametros Cursor \n"
                          "Cod Concepto : [%d]\n"
                          "Fecha  INI   : [%s]\n"
                          "Fecha  FIN   : [%s]\n",cfnGetTime(3), ihCodCarrier,szhFecIni,szhFecFin);

    /* Cursor para recuperar todos los abonados con Conceptos carrier . */
    /* Solo se recuperan los que estan cancelados es decir importes iguales */

    /* EXEC SQL DECLARE C_TODABO CURSOR FOR
        SELECT  distinct(A.COD_CLIENTE),
                A.NUM_ABONADO,
                A.COD_TIPDOCUM,
                A.COD_CENTREMI,
                A.NUM_SECUENCI,
                A.COD_VENDEDOR_AGENTE,
                A.LETRA,
                A.COD_CONCEPTO,
                A.COLUMNA,
                A.NUM_FOLIO,
                A.IMPORTE_HABER
    	  FROM  CO_CANCELADOS A    , GE_DATOSGENER B
    	 WHERE  A.IMPORTE_DEBE = A.IMPORTE_HABER 
      	   AND  A.COD_CONCEPTO = :ihCodCarrier   
      	   AND  A.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhFecIni, 'YYYYMMDD') 
      	   AND  TO_DATE(:szhFecFin, 'YYYYMMDD') 
      	   AND  A.COD_PRODUCTO = B.PROD_CELULAR
         ORDER  BY
            A.COD_CLIENTE,A.NUM_SECUENCI,A.COD_TIPDOCUM,A.COD_VENDEDOR_AGENTE, A.LETRA,
            A.COD_CENTREMI,A.COD_CONCEPTO,A.COLUMNA,A.NUM_ABONADO,A.NUM_FOLIO; */ 


    if (sqlca.sqlcode)
    {
        fprintf(stderr,"* Error en Declare de Cursor TratAbonado%s\n",szfnORAerror());
        return ERR_OPENCURSOR;
    }

    /* EXEC SQL OPEN C_TODABO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0006;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )138;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCarrier;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecIni;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecFin;
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



    fprintf(stDatPro.pLog, "%s [ifnDBTratAbonados] Inicia Cursor Principal de -GENERANDO ARCHIVO- \n\n",cfnGetTime(3)); /* Incorporado por PGonzaleg 28-02-2002 */

    if (sqlca.sqlcode)
    {
        fprintf(stderr,"* Error en Apertura de Cursor TratAbonado%s\n",szfnORAerror());
        return ERR_OPENCURSOR;
    }

    while (TRUE)
    {
        /* EXEC SQL FETCH C_TODABO
            INTO    :lhCodCliente,
                :lhNumAbonado,
                :lhCodTipdocum,
                :lhCodCentremi,
                :lhNumSecuenci,
                :lhCodVendedorAgente,
                :szhLetra,
                :lhCodConcepto,
                :lhCodColumna,
                :lhNumFolio,
                :dhImporte; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )165;
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
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodTipdocum;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCentremi;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
        sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&lhCodVendedorAgente;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
        sqlstm.sqhstl[6] = (unsigned long )2;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)&lhCodConcepto;
        sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)&lhCodColumna;
        sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)&lhNumFolio;
        sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)&dhImporte;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[10] = (         int  )0;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
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



        if (lhCodCliente        ==  lhCodClienteAux         &&
            lhNumAbonado        ==  lhNumAbonadoAux         &&
            lhCodTipdocum       ==  lhCodTipdocumAux        &&
            lhCodCentremi       ==  lhCodCentremiAux        &&
            lhNumSecuenci       ==  lhNumSecuenciAux        &&
            lhCodVendedorAgente ==  lhCodVendedorAgenteAux  &&
            (strcmp(szhLetraAux,szhLetra))==0               &&
            lhCodConcepto       ==  lhCodConceptoAux        &&
            lhNumFolio          ==  lhNumFolioAux           &&
            sqlca.sqlcode != NOT_FOUND)
        {
             fprintf(stDatPro.pLog,"\n\nRegistro Co_cancelados Repetido\n");
             fprintf(stDatPro.pLog,"\t\tlhCodCliente           [%d]\n",lhCodCliente);
             fprintf(stDatPro.pLog,"\t\tlhNumAbonado           [%d]\n",lhNumAbonado);
             fprintf(stDatPro.pLog,"\t\tlhCodTipdocum          [%d]\n",lhCodTipdocum);
             fprintf(stDatPro.pLog,"\t\tlhCodCentremi          [%d]\n",lhCodCentremi);
             fprintf(stDatPro.pLog,"\t\tlhNumSecuenci          [%d]\n",lhNumSecuenci);
             fprintf(stDatPro.pLog,"\t\tlhCodVendedorAgente    [%d]\n",lhCodVendedorAgente);
             fprintf(stDatPro.pLog,"\t\tszhLetra               [%s]\n",szhLetra);
             fprintf(stDatPro.pLog,"\t\tlhCodConcepto          [%d]\n",lhCodConcepto);
             fprintf(stDatPro.pLog,"\t\tlhNumFolio             [%d]\n",lhNumFolio);

        }
        else
        {
            lhCodClienteAux           = lhCodCliente;
            lhNumAbonadoAux           = lhNumAbonado;
            lhCodTipdocumAux          = lhCodTipdocum;
            lhCodCentremiAux          = lhCodCentremi;
            lhNumSecuenciAux          = lhNumSecuenci;
            lhCodVendedorAgenteAux  = lhCodVendedorAgente;
            strcpy(szhLetraAux,szhLetra);
            lhCodConceptoAux        = lhCodConcepto;
            lhNumFolioAux           = lhNumFolio;
            if (sqlca.sqlcode < 0)
            {
                fprintf(stderr,"* Error en Fetch  %s\n",szfnORAerror());
                return ERR_FETCH;
            }

            if (sqlca.sqlcode == NOT_FOUND)
            {
                break;
            }

            /* EXEC SQL
                SELECT  num_celular
                INTO    :lhNumCelular
                FROM    ga_abocel
                WHERE   num_abonado = :lhNumAbonado; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select num_celular into :b0  from ga_abocel where\
 num_abonado=:b1";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )224;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelular;
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


            /* NCH TMC2602-001: Si no encuentro abonado en GA_ABOCEL, debe buscarse en la GA_HABOCEL */
            if (sqlca.sqlcode == NOT_FOUND)
            {
                fprintf(stDatPro.pLog, "%s Abonado %d No se encuentra en GA_ABOCEL,busca en GA_HABOCEL\n\n",cfnGetTime(3),lhNumAbonado);

                /* EXEC SQL
                    SELECT    num_celular
                      INTO    :lhNumCelular
                      FROM    ga_habocel
                     WHERE    num_abonado = :lhNumAbonado; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 11;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select num_celular into :b0  from ga_habocel \
where num_abonado=:b1";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )247;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCelular;
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


            }

            if (sqlca.sqlcode == NOT_FOUND)
            {
                fprintf(stDatPro.pLog, "%s Error : Abonado %d No se encuentra\n\n",cfnGetTime(3),lhNumAbonado);
                break;
            }

            lCount ++;

            strcpy(stlocalparam.szLetra,szhLetra);
            stlocalparam.lCodCliente    = lhCodCliente;
            stlocalparam.lNumAbonado    = lhNumAbonado;
            stlocalparam.lNumCelular    =lhNumCelular;
            stlocalparam.lCodTipdocum   =lhCodTipdocum;
            stlocalparam.lCodCentremi   =lhCodCentremi;
            stlocalparam.lNumSecuenci   =lhNumSecuenci;
            stlocalparam.lCodVendedorAgente=lhCodVendedorAgente;
            stlocalparam.lCodConcepto   =lhCodConcepto;
            stlocalparam.lCodColumna    =lhCodColumna;
            stlocalparam.lNumFolio      =lhNumFolio;
            stlocalparam.dImporte       =dhImporte;

            iResul = ifnDBTratCelular(stlocalparam);
            if (iResul != OK)
                return ERR_CARRABO;
        }
    }

    /* EXEC SQL CLOSE C_TODABO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )270;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    fprintf(stDatPro.pLog, "%s [ifnDBTratAbonados] Finaliza Cursor Principal de -GENERANDO ARCHIVO- \n\n",cfnGetTime(3)); /* Incorporado por PGonzaleg 28-02-2002 */

    if (sqlca.sqlcode != 0)
    {
        fprintf(stderr,"* Error en Cierre de Cursor %s\n",szfnORAerror());
        return ERR_CLOSECURSOR;
    }

    /* Si existen registros cancelados para el carrier creo el fichero */
    if (lCount > 0)
    {
        fseek(stDatPro.pFich,0L,SEEK_SET); /* retrocede a la primera linea del archivo */
        /* reescribe CABECERA con los valores correctos */
        fprintf(stDatPro.pFich,
            "%03d%011ld%8s%013.0f00                                    70\n",
            ihCodCarrier,
            stDatPro.lNumReg,
            szFecha,
            stDatPro.dImpTotal                      );

        fprintf(stDatPro.pLog, "SE HA GENERADO EL FICHERO DEL CARRIER \n");
        fprintf(stDatPro.pLog, "\n\nNumero de registros: %ld\n",stDatPro.lNumReg);
        fprintf(stDatPro.pLog, "Importe total      : %f\n\n\n",stDatPro.dImpTotal);
    }
    return OK;

}/* Fin ifnDBTratAbonados() */
/****************************************************************************/
int ifnDBTratCelular(LOCALPARAM pstlocalparam)
/**
Descripcion: Funcion que obtiene los importes carrier cancelados
Salida     : OK si todo esta bien
                 ERR_xxx si hay algun error.
**/
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char      szhLetra          [2]; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

        char      szhFecEfectividad [9]; /* EXEC SQL VAR szhFecEfectividad IS STRING(9); */ 

        char      szhFecPago        [9]; /* EXEC SQL VAR szhFecPago IS STRING(9); */ 

        char      szhFecIni         [9]; /* EXEC SQL VAR szhFecIni IS STRING(9); */ 

        char      szhFecFin         [9]; /* EXEC SQL VAR szhFecFin IS STRING(9); */ 

        char      szhFecEfec        [9]; /* EXEC SQL VAR szhFecEfec IS STRING(9); */ 

        char      szhFecPag         [9]; /* EXEC SQL VAR szhFecPag IS STRING(9); */ 

        char      szhFecEfe         [9]; /* EXEC SQL VAR szhFecEfe IS STRING(9); */ 

        char      szhCodCiclo       [3]; /* EXEC SQL VAR szhCodCiclo IS STRING(3); */ 

        char      szhCodCauPago     [3];/* EXEC SQL VAR szhCodCauPago IS STRING(3); */ 

        int       ihCodCarrier;
        double    dhImpConcepto;
        long      lhNumSecuenciPago;
        int       ihCodCentrEmiPago;
        int       ihCodTipDocumPago;
        long      lhCodVendedorPago;
        char      szhLetraPago      [2];/* EXEC SQL VAR szhLetraPago IS STRING(2); */ 

        char      szhCodCiclo_ANT   [4]; /* EXEC SQL VAR szhCodCiclo_ANT IS STRING(4); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    BOOL    bResul;
    BOOL    res;
    double  dAcumImporte=0;
    double  dAcumImporte_Nuevo=0;
    double  dAcumImporte_Nuevo_ANT=0;
    char    szhFecPago_ANT[9];
    char    szhImporte[900];

    char    szCodCauPago[5];
    char    szCodCauPago_ant[5];
    strcpy(szCodCauPago_ant, "*");
    strcpy(szhFecPago_ANT, "*");

    ihCodCarrier     = stDatPro.iCarrier;
    strcpy(szhFecIni,stDatPro.szFecIni);
    strcpy(szhFecFin,stDatPro.szFecFin);

    fprintf(stDatPro.pLog, "%s [ifnDBTratCelular] Procesa Cada Registro \n\n",cfnGetTime(3));/* Incorporado por PGonzaleg 28-02-2002 */

    /* EXEC SQL DECLARE C_FILAS CURSOR FOR     /o Incorporado por PGonzaleg 25-02-2002 o/
        SELECT  B.IMP_CONCEPTO,
            B.NUM_SECUENCI,
            B.COD_TIPDOCUM,
            B.COD_VENDEDOR_AGENTE,
            B.LETRA,
            B.COD_CENTREMI,
            TO_CHAR(B.FEC_CANCELACION,'YYYYMMDD'),
            TO_CHAR(A.FEC_EFECTIVIDAD,'YYYYMMDD'),
            TO_CHAR(A.FEC_EFECTIVIDAD,'DD')
        FROM CO_CANCELADOS A, CO_PAGOSCONC B
        WHERE   A.COD_CLIENTE         = :pstlocalparam.lCodCliente
          AND   A.COD_TIPDOCUM        = :pstlocalparam.lCodTipdocum
          AND   A.COD_CENTREMI        = :pstlocalparam.lCodCentremi
          AND   A.NUM_SECUENCI        = :pstlocalparam.lNumSecuenci
          AND   A.COD_VENDEDOR_AGENTE = :pstlocalparam.lCodVendedorAgente
          AND   A.LETRA               = :pstlocalparam.szLetra
          AND   A.COD_CONCEPTO        = :pstlocalparam.lCodConcepto
          AND   A.COLUMNA             = :pstlocalparam.lCodColumna
          AND   A.NUM_ABONADO         = :pstlocalparam.lNumAbonado
          AND   A.NUM_SECUENCI        = B.NUM_SECUREL
          AND   A.COD_TIPDOCUM        = B.COD_TIPDOCREL
          AND   A.COD_VENDEDOR_AGENTE = B.COD_AGENTEREL
          AND   A.LETRA               = B.LETRA_REL
          AND   A.COD_CENTREMI        = B.COD_CENTRREL
          AND   A.NUM_ABONADO         = B.NUM_ABONADO
          AND   A.COD_CONCEPTO        = B.COD_CONCEPTO; */ 

    /* EXEC SQL OPEN C_FILAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )285;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(pstlocalparam.lCodCliente);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pstlocalparam.lCodTipdocum);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&(pstlocalparam.lCodCentremi);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&(pstlocalparam.lNumSecuenci);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&(pstlocalparam.lCodVendedorAgente);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstlocalparam.szLetra);
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&(pstlocalparam.lCodConcepto);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&(pstlocalparam.lCodColumna);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&(pstlocalparam.lNumAbonado);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
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



    memset(szhImporte, 0x00, sizeof(szhImporte));
    dAcumImporte =0;
    dAcumImporte_Nuevo = 0;
    dAcumImporte_Nuevo_ANT = -1;
    while (TRUE)
    {
        /* EXEC SQL FETCH C_FILAS
            INTO    :dhImpConcepto,
                :lhNumSecuenciPago,
                :ihCodTipDocumPago,
                :lhCodVendedorPago,
                :szhLetraPago,
                :ihCodCentrEmiPago,
                :szhFecPago,
                :szhFecEfe,
                :szhCodCiclo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )336;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&dhImpConcepto;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuenciPago;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocumPago;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhCodVendedorPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhLetraPago;
        sqlstm.sqhstl[4] = (unsigned long )2;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCentrEmiPago;
        sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szhFecPago;
        sqlstm.sqhstl[6] = (unsigned long )9;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szhFecEfe;
        sqlstm.sqhstl[7] = (unsigned long )9;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szhCodCiclo;
        sqlstm.sqhstl[8] = (unsigned long )3;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
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



        fprintf(stDatPro.pLog," FECTH C_FILAS \n"
        					  "       NumCelular        [%ld] \n"
        					  "       dImporte          [%013.0f] \n"
        					  "       dhImpConcepto     [%f] \n"
        					  "       lhNumSecuenciPago [%ld]\n"
        					  "       ihCodTipDocumPago [%d] \n"
        					  "       lhCodVendedorPago [%ld]\n"
        					  "       szhLetraPago      [%s] \n"
        					  "       ihCodCentrEmiPago [%d] \n"
        					  "       szhFecEfe         [%8s]\n"
        					  "       szhFecPago        [%8s]\n"
        					  "       szhCodCiclo       [%2s]\n"
        					  , pstlocalparam.lNumCelular, pstlocalparam.dImporte
        					  , dhImpConcepto, lhNumSecuenciPago
        					  , ihCodTipDocumPago, lhCodVendedorPago
        					  , szhLetraPago, ihCodCentrEmiPago
        					  , szhFecEfe, szhFecPago, szhCodCiclo);
        /*strcpy(szCodCiclo,szhCodCiclo);     */
        if (sqlca.sqlcode < 0)  {
            fprintf(stderr,"* Error en Fetch  %s\n",szfnORAerror());
            return ERR_FETCH;
           }

        if (sqlca.sqlcode == NOT_FOUND) {
            dAcumImporte_Nuevo_ANT = dAcumImporte_Nuevo;
            memset(szhCodCiclo, 0x00, sizeof(szhCodCiclo));
            strncpy(szhCodCiclo,szhCodCiclo_ANT,2);
            fprintf(stDatPro.pLog, "       dAcumImporte  [%013.0f] \n"
            					   "       szCodCauPago  [%s]      \n"
            					   "       szhFecEfe     [%8s]     \n"
            					   "       szhFecPago    [%8s]     \n"
            					   "       szhFecPago_ANT[%8s]     \n"
            					   "       szhCodCiclo   [%s]      \n"
            					   , dAcumImporte_Nuevo_ANT, szCodCauPago_ant
            					   , szhFecEfe, szhFecPago, szhFecPago_ANT, szhCodCiclo);

            fprintf(stDatPro.pLog,        /* Generación de Registro al salir */
                    "A[%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s]\n",
                    ihCodCarrier,
                    pstlocalparam.lNumCelular,
                    pstlocalparam.lNumFolio,
                    szhFecEfe,
                    szhFecPago_ANT,
                    pstlocalparam.dImporte,
                    dAcumImporte_Nuevo_ANT,
                    szhCodCiclo,
                    szCodCauPago_ant );

            fprintf(stDatPro.pFich,
                    "%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s\n",
                    ihCodCarrier,
                    pstlocalparam.lNumCelular,
                    pstlocalparam.lNumFolio,
                    szhFecEfe,
                    szhFecPago_ANT,
                    pstlocalparam.dImporte,
                    dAcumImporte_Nuevo_ANT,
                    szhCodCiclo,
                    szCodCauPago_ant    );

            break;
           }

        strcpy(szhCodCiclo_ANT,szhCodCiclo);

        fprintf(stDatPro.pLog, "Funcion bGetCausaPago() \n"
        					   "   	szCodCauPago ANTES DEL LLAMADO [%s] \n", dAcumImporte_Nuevo_ANT, szCodCauPago);
        res = bGetCausaPago(ihCodTipDocumPago,
                            ihCodCentrEmiPago,
                            lhNumSecuenciPago,
                            lhCodVendedorPago,
                            szhLetraPago,
                            szCodCauPago);
        fprintf(stDatPro.pLog, "    szCodCauPago RECUPERADO        [%s] \n"
        					   "    Retorno de  bGetCausaPago()    [%d] \n", szCodCauPago, res);


        if (!res) {
            fprintf(stDatPro.pLog, " No hay datos en tabla CO_PAGOS \n"
            					   " ihCodTipDocumPago    [%d]\n"
            					   " ihCodCentrEmiPago    [%d]\n"
            					   " lhNumSecuenciPago    [%d]\n"
            					   " lhCodVendedorPago    [%d]\n"
            					   " szhLetraPago        [%s]\n"
            					   ,ihCodTipDocumPago,ihCodCentrEmiPago
            					   ,lhNumSecuenciPago,lhCodVendedorPago,szhLetraPago);
            fprintf(stderr,"* Error al obtener los datos %s\n",szfnORAerror());
            break;
        }

        dAcumImporte = dAcumImporte + dhImpConcepto;
        dAcumImporte_Nuevo = dAcumImporte_Nuevo + dhImpConcepto;
        memset(szhCodCiclo, 0x00, sizeof(szhCodCiclo));
        strncpy(szhCodCiclo,szhCodCiclo_ANT,2);

        if (strcmp(szCodCauPago_ant, "*") == 0) {
            strcpy(szCodCauPago_ant, szCodCauPago);
           }
        if (strlen(szhFecPago_ANT) == 1) {
            strcpy(szhFecPago_ANT, szhFecPago);
           }
        if (dAcumImporte_Nuevo_ANT == -1) {
            dAcumImporte_Nuevo_ANT = dAcumImporte_Nuevo;
           }


        if ( dAcumImporte ==  pstlocalparam.dImporte || strcmp(szCodCauPago_ant,szCodCauPago) != 0) {
            if (dAcumImporte == pstlocalparam.dImporte && strcmp(szCodCauPago_ant,szCodCauPago) == 0) {
                strcpy(szhFecPago_ANT, szhFecPago);
                dAcumImporte_Nuevo_ANT = dAcumImporte_Nuevo;
                strcpy(szCodCauPago_ant, szCodCauPago);
               }

            sprintf(szhImporte,    "%013.0f", dAcumImporte_Nuevo_ANT);
            fprintf(stDatPro.pLog, "       dAcumImporte  [%013.0f] \n"
            					   "       Largo Importe [%d]      \n"
            					   "       szCodCauPago  [%s]      \n"
            					   "       szhFecEfe     [%8s]     \n"
            					   "       szhFecPago    [%8s]     \n"
            					   "       szhFecPago_ANT[%8s]     \n"
            					   "       szhCodCiclo   [%s]      \n"
            					   , dAcumImporte_Nuevo_ANT, strlen(szhImporte)
            					   , szCodCauPago_ant, szhFecEfe, szhFecPago
            					   , szhFecPago_ANT, szhCodCiclo);

            if (strlen(szhImporte) == 13) {
                fprintf(stDatPro.pLog,
                        "B[%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s]\n",
                        ihCodCarrier,
                        pstlocalparam.lNumCelular,
                        pstlocalparam.lNumFolio,
                        szhFecEfe,
                        szhFecPago_ANT,
                        pstlocalparam.dImporte,
                        dAcumImporte_Nuevo_ANT,
                        szhCodCiclo,
                        szCodCauPago_ant );

                fprintf(stDatPro.pFich,
                        "%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s\n",
                        ihCodCarrier,
                        pstlocalparam.lNumCelular,
                        pstlocalparam.lNumFolio,
                        szhFecEfe,
                        szhFecPago_ANT,
                        pstlocalparam.dImporte,
                        dAcumImporte_Nuevo_ANT,
                        szhCodCiclo,
                        szCodCauPago_ant );
               }
            else {
                fprintf(stDatPro.pLog, " Corrigiendo Importe:\n"
        							   " DE dAcumImporte  [%013.0f] \n"
        							   " A  dAcumImporte  [%013.0f] \n"
        							   , dAcumImporte_Nuevo_ANT, pstlocalparam.dImporte);
                fprintf(stDatPro.pLog,
                        "B[%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s]\n",
                        ihCodCarrier,
                        pstlocalparam.lNumCelular,
                        pstlocalparam.lNumFolio,
                        szhFecEfe,
                        szhFecPago_ANT,
                        pstlocalparam.dImporte,
                        pstlocalparam.dImporte,
                        szhCodCiclo,
                        szCodCauPago_ant );

                fprintf(stDatPro.pFich,
                        "%03d%010ld%011ld%8s%8s%013.0f00%013.0f00 %2s%s\n",
                        ihCodCarrier,
                        pstlocalparam.lNumCelular,
                        pstlocalparam.lNumFolio,
                        szhFecEfe,
                        szhFecPago_ANT,
                        pstlocalparam.dImporte,
                        pstlocalparam.dImporte,
                        szhCodCiclo,
                        szCodCauPago_ant );
               }


            stDatPro.lNumReg ++;

            if (strcmp(szCodCauPago_ant,szCodCauPago) != 0) {
                dAcumImporte_Nuevo = dhImpConcepto;
                strcpy(szCodCauPago_ant, "*");
               }
            else
                break;
        }

        strcpy(szCodCauPago_ant, szCodCauPago);
        dAcumImporte_Nuevo_ANT = dAcumImporte_Nuevo;
        strcpy(szhFecPago_ANT, szhFecPago);
    }


    /* EXEC SQL CLOSE C_FILAS; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )387;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}

 
    if (sqlca.sqlcode != 0)
    {
            fprintf(stderr,"* Error en Cierre de Cursor %s\n",szfnORAerror());
            return ERR_CLOSECURSOR;
    }

    stDatPro.dImpTotal = stDatPro.dImpTotal + pstlocalparam.dImporte;
    stDatPro.dImpTotal = rint(stDatPro.dImpTotal * INVMIN)/INVMIN;

    bResul = bfnDBUpdProcesado(pstlocalparam.lCodCliente,pstlocalparam.lNumAbonado,pstlocalparam.lNumFolio);
    if (!bResul)
        return ERR_UPDPROCESO;

      return OK;

}/* Fin ifnDBTratCelular() */
/***************************************************************************/
BOOL bfnDBFechaSys(char *szFecha)
/**
Descripcion: Funcion que obtiene la fecha del sistema
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhFecha[9]; /* EXEC SQL VAR szhFecha IS STRING(9); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL
        SELECT TO_CHAR(SYSDATE,'YYYYMMDD')
        INTO szhFecha
        FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(SYSDATE,'YYYYMMDD') into :b0  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )402;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[0] = (unsigned long )9;
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



   if (sqlca.sqlcode != 0)
   {
      fprintf(stderr,"* Error al obtener la fecha del sistema %s\n",szfnORAerror());
      return FALSE;
   }

    strcpy(szFecha,szhFecha);

    return TRUE;

}/* Fin bfnDBFechaSys() */
/***************************************************************************/
BOOL bfnDBUpdProcesado(long lCodCliente, long lNumAbonado, long lNumFolio)
/**
Descripcion: Funcion que indica que el concepto ya ha sido enviado al carrier
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      long    lhCodCliente   ;
      long    lhNumAbonado   ;
      int     ihCodCarrier   ;
      long    lhNumFolio     ;
      char    szhFecIni[9]; /* EXEC SQL VAR szhFecIni IS STRING(9); */ 

      char    szhFecFin[9]; /* EXEC SQL VAR szhFecFin IS STRING(9); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente   = lCodCliente;
   	lhNumAbonado   = lNumAbonado;
   	lhNumFolio     = lNumFolio;
    ihCodCarrier    = stDatPro.iCarrier;
    strcpy(szhFecIni,stDatPro.szFecIni);
    strcpy(szhFecFin,stDatPro.szFecFin);

   fprintf(stDatPro.pLog, "%s [bfnDBUpdProcesado] Actualiza Tabla CO_CANCELADOS \n\n",cfnGetTime(3));/* Incorporado por PGonzaleg 28-02-2002 */

   /* EXEC SQL
         UPDATE CO_CANCELADOS
        SET IND_PORTADOR    = 1
        WHERE NUM_FOLIO     = :lhNumFolio
        AND COD_CLIENTE     = :lhCodCliente
        AND NUM_ABONADO     = :lhNumAbonado
        AND COD_CONCEPTO    = :ihCodCarrier
        AND FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhFecIni,'YYYYMMDD') AND TO_DATE(:szhFecFin,'YYYYMMDD')
        AND COD_PRODUCTO    = (SELECT PROD_CELULAR   FROM GE_DATOSGENER); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 11;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_CANCELADOS  set IND_PORTADOR=1 where (((((NUM_FO\
LIO=:b0 and COD_CLIENTE=:b1) and NUM_ABONADO=:b2) and COD_CONCEPTO=:b3) and FE\
C_EFECTIVIDAD between TO_DATE(:b4,'YYYYMMDD') and TO_DATE(:b5,'YYYYMMDD')) and\
 COD_PRODUCTO=(select PROD_CELULAR  from GE_DATOSGENER ))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )421;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumFolio;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCarrier;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhFecIni;
   sqlstm.sqhstl[4] = (unsigned long )9;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFecFin;
   sqlstm.sqhstl[5] = (unsigned long )9;
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



   if (sqlca.sqlcode != 0)
   {
        fprintf(stderr,"* Error al realizar el update de ind_procesado %s\n",szfnORAerror());
        fprintf(stDatPro.pLog, "%s [bfnDBUpdProcesado] Error al Actualizar Tabla CO_CANCELADOS -el msg dice ind_procesado- \n\n",cfnGetTime(3));/* Incorporado por PGonzaleg 28-02-2002 */

      return FALSE;
   }

    return TRUE;

}/* Fin bfnDBUpdProcesado() */
/***************************************************************************/
BOOL bDBTomarSecuencia(int *iCodTipDocum,int *iCodCentremi,long *lCodAgente,
                                char *szLetra, long *lNumSecuenci,int *iSisPago,
                                int *iOriPago, int *iCauPago )
/**
Descripcion: Recupera los datos del pago.
Salida     : Si todo va bien devuelve TRUE.
**/
{
    int iResul;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int ihCodTipDocum   ;
        int ihCodCentremi   ;
        long lhCodAgente  	;
        char szhLetra[2]	; /* EXEC SQL VAR szhLetra is STRING(2); */ 

        long lhNumSecuenci  ;
        int ihOriPago;
        int ihCauPago;
        int ihSisPago;
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL
        SELECT A.DOC_CARRIER,
                 A.AGENTE_INTERNO,
                 B.COD_CENTREMI,
                 A.LETRA_COBROS,
                 A.SIS_CARRIER,
                 A.CAU_CARRIER,
                 A.ORI_CARRIER
        INTO     :ihCodTipDocum,
                 :lhCodAgente,
                 :ihCodCentremi,
                 :szhLetra,
                 :ihSisPago,
                 :ihCauPago,
                 :ihOriPago
        FROM CO_DATGEN A, AL_DOCUM_SUCURSAL B
        WHERE B.COD_OFICINA = A.OFICINA_PAG
        AND B.COD_TIPDOCUM = A.DOC_CARRIER; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.DOC_CARRIER ,A.AGENTE_INTERNO ,B.COD_CENTREMI ,A\
.LETRA_COBROS ,A.SIS_CARRIER ,A.CAU_CARRIER ,A.ORI_CARRIER into :b0,:b1,:b2,:b\
3,:b4,:b5,:b6  from CO_DATGEN A ,AL_DOCUM_SUCURSAL B where (B.COD_OFICINA=A.OF\
ICINA_PAG and B.COD_TIPDOCUM=A.DOC_CARRIER)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )460;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodAgente;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentremi;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhLetra;
    sqlstm.sqhstl[3] = (unsigned long )2;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihSisPago;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCauPago;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihOriPago;
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



    if(sqlca.sqlcode != 0)
    {
      fprintf(stderr,"* Error al obtener los datos generales %s\n",
                                    szfnORAerror());
        return FALSE;
    }

    *iCodTipDocum = ihCodTipDocum;
    *lCodAgente   = lhCodAgente;
    *iCodCentremi = ihCodCentremi;
    strcpy(szLetra,szhLetra);
    *iSisPago     = ihSisPago;
    *iCauPago     = ihCauPago;
    *iOriPago     = ihOriPago;

   iResul = iDBTomarSecuencia(ihCodTipDocum,ihCodCentremi,
                          szhLetra,&lhNumSecuenci);
   if (iResul != OK)
        return iResul;

    *lNumSecuenci = lhNumSecuenci;

    return TRUE;

} /* Fin bfnDBTomarSecuencia() */

/****************************************************************************/
BOOL bfnDBInsDatosPago(DATPAG *stDatPag)
/**
Inserta registro en co_pagos  con los datos de la estructura.
En caso de error devuelve FALSE.
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      int    ihCodTipDocum     ;
      long   lhCodAgente       ;
      char  *szhLetra          ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int    ihCodCentrEmi     ;
      long   lhNumSecuenci     ;
      long   lhCodCliente      ;
      double dhImpPago         ;
      char  *szhFecValor       ; /* EXEC SQL VAR szhFecValor IS STRING(9); */ 

      char  *szhNomUsuarOra    ; /* EXEC SQL VAR szhNomUsuarOra IS STRING(31); */ 

      short  shIndContado      ;
      int    ihCodSisPago      ;
      int    ihCodOriPago      ;
      int    ihCodCauPago      ;
      char  *szhCodBanco       ; /* EXEC SQL VAR szhCodBanco IS STRING(16); */ 

      short  shIndCodBan       ;
      char  *szhCodSucursal    ; /* EXEC SQL VAR szhCodSucursal IS STRING(5); */ 

      short  shIndCodSuc       ;
      char  *szhCtaCorriente   ; /* EXEC SQL VAR szhCtaCorriente IS STRING(16); */ 

      short  shIndCtaCor       ;
      char  *szhCodTipTarjeta  ; /* EXEC SQL VAR szhCodTipTarjeta IS STRING(4); */ 

      short  shIndCodTipTar    ;
      char  *szhNumTarjeta     ; /* EXEC SQL VAR szhNumTarjeta IS STRING(21); */ 

      short  shIndNumTar       ;

   /* EXEC SQL END DECLARE SECTION; */ 


    /* Preparar valores para insercion en co_pagos */
   ihCodTipDocum  = stDatPag->stDatDocPago.iCodTipDocum;
   lhCodAgente    = stDatPag->stDatDocPago.lCodAgente;
   szhLetra       = stDatPag->stDatDocPago.szLetra;
   ihCodCentrEmi  = stDatPag->stDatDocPago.iCodCentrEmi;
   lhNumSecuenci  = stDatPag->stDatDocPago.lNumSecuenci;
   lhCodCliente   = stDatPag->lCodCliente;
   dhImpPago      = stDatPag->dImpPago;
   szhFecValor    = stDatPag->szFecValor;
   szhNomUsuarOra = stDatPag->szNomUsu;
   shIndContado   = 0; /* Siempre Consumo */
   ihCodSisPago   = stDatPag->iCodSisPago;
   ihCodOriPago   = stDatPag->iCodOriPago;
   ihCodCauPago   = stDatPag->iCodCauPago;

   szhCodBanco = stDatPag->szCodBanco;
    if (stDatPag->szCodBanco[0] == '\0')
      shIndCodBan = ORA_NULL;
   else
      shIndCodBan = ORA_NOTNULL;


   szhCodSucursal = stDatPag->szCodSucursal;

    if (stDatPag->szCodSucursal[0] == '\0')
      shIndCodSuc = ORA_NULL   ;
   else
      shIndCodSuc = ORA_NOTNULL;

   szhCtaCorriente = stDatPag->szCtaCorriente;
    if (stDatPag->szCtaCorriente[0] == '\0')
      shIndCtaCor = ORA_NULL;
   else
      shIndCtaCor = ORA_NOTNULL;

   szhCodTipTarjeta = stDatPag->szCodTipTarjeta;
    if (stDatPag->szCodTipTarjeta[0] == '\0')
      shIndCodTipTar = ORA_NULL;
   else
      shIndCodTipTar = ORA_NOTNULL;

   szhNumTarjeta = stDatPag->szNumTarjeta;
    if (stDatPag->szNumTarjeta[0] == '\0')
      shIndNumTar = ORA_NULL;
   else
      shIndNumTar = ORA_NOTNULL;

   /* EXEC SQL
     INSERT INTO CO_PAGOS
       (COD_TIPDOCUM       ,
        COD_CENTREMI       ,
        NUM_SECUENCI       ,
        COD_VENDEDOR_AGENTE         ,
        LETRA              ,
        COD_CLIENTE        ,
        IMP_PAGO           ,
        FEC_EFECTIVIDAD    ,
        FEC_VALOR          ,
        NOM_USUARORA       ,
        COD_FORPAGO       ,
        COD_SISPAGO        ,
        COD_ORIPAGO        ,
        COD_CAUPAGO        ,
        COD_BANCO        ,
        COD_TIPTARJETA   ,
        COD_SUCURSAL     ,
        CTA_CORRIENTE       ,
        NUM_TARJETA,
          DES_PAGO
       )
       VALUES
       (:ihCodTipDocum      ,
        :ihCodCentrEmi      ,
        :lhNumSecuenci      ,
        :lhCodAgente       ,
        :szhLetra           ,
        :lhCodCliente       ,
        :dhImpPago          ,
         SYSDATE            ,
        TO_DATE(:szhFecValor,'YYYYMMDD'),
        :szhNomUsuarOra     ,
        1 ,
        :ihCodSisPago       ,
        :ihCodOriPago       ,
        :ihCodCauPago        ,
        :szhCodBanco:shIndCodBan        ,
        :szhCodTipTarjeta:shIndCodTipTar,
        :szhCodSucursal:shIndCodSuc     ,
        :szhCtaCorriente:shIndCtaCor    ,
        :szhNumTarjeta:shIndNumTar,
            'Cancelacion Interna de la Deuda Carrier'); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 17;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_PAGOS (COD_TIPDOCUM,COD_CENTREMI,NUM_SECUEN\
CI,COD_VENDEDOR_AGENTE,LETRA,COD_CLIENTE,IMP_PAGO,FEC_EFECTIVIDAD,FEC_VALOR,NO\
M_USUARORA,COD_FORPAGO,COD_SISPAGO,COD_ORIPAGO,COD_CAUPAGO,COD_BANCO,COD_TIPTA\
RJETA,COD_SUCURSAL,CTA_CORRIENTE,NUM_TARJETA,DES_PAGO) values (:b0,:b1,:b2,:b3\
,:b4,:b5,:b6,SYSDATE,TO_DATE(:b7,'YYYYMMDD'),:b8,1,:b9,:b10,:b11,:b12:b13,:b14\
:b15,:b16:b17,:b18:b19,:b20:b21,'Cancelacion Interna de la Deuda Carrier')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )503;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[4] = (unsigned long )2;
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
   sqlstm.sqhstv[6] = (unsigned char  *)&dhImpPago;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFecValor;
   sqlstm.sqhstl[7] = (unsigned long )9;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhNomUsuarOra;
   sqlstm.sqhstl[8] = (unsigned long )31;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihCodSisPago;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&ihCodOriPago;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&ihCodCauPago;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhCodBanco;
   sqlstm.sqhstl[12] = (unsigned long )16;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)&shIndCodBan;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhCodTipTarjeta;
   sqlstm.sqhstl[13] = (unsigned long )4;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)&shIndCodTipTar;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhCodSucursal;
   sqlstm.sqhstl[14] = (unsigned long )5;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)&shIndCodSuc;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)szhCtaCorriente;
   sqlstm.sqhstl[15] = (unsigned long )16;
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&shIndCtaCor;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)szhNumTarjeta;
   sqlstm.sqhstl[16] = (unsigned long )21;
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&shIndNumTar;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
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



   if (sqlca.sqlcode)
   {
     fprintf (stderr,"* Error en Insert CO_PAGOS - %s\n", szfnORAerror());

     return FALSE;
   }

    return TRUE;

} /* Fin bfnDBInsDatosPago() */

/****************************************************************************/
int ifnDBPagoUnAbonado(DATPAG *stDatPag,long lCodCliente, int iCodConcepto)
/**
Descripcion: Efectua la cancelacion en cartera de un pago contra conceptos
             de consumo para uno de los Abonados de un cliente.
             Mientras queden importe para cancelar y conceptos cancelados
             genera conceptos al haber. Si despues sigue quedando importe
             genera un credito.
Salida     : Si todo va bien devuelve 0 y en caso contrario un numero de error.
**/
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 


      long    lhCodCliente   ;
      long    lhNumAbonado   ;
      int     ihCodTipDocum  ;
      long    lhCodAgente    ;
      char    szhLetra[2]    ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      int     ihCodCentrEmi  ;
      long    lhNumSecuenci  ;
      int     ihCodConcepto  ;
      int     ihColumna      ;
      double  dhImporteDebe  ;
      double  dhImporteHaber ;
      int     ihCodProducto  ;
      long    lhNumFolio     ;
      long    lhNumCuota     ;
      int     ihSecCuota     ;
      long    lhNumTransa    ;
      long    lhNumVenta     ;
      char    szhFolioCTC[12]; /* EXEC SQL VAR szhFolioCTC IS STRING(12); */ 

      short   shIndNumFolio  ;
      short   shIndNumCuota  ;
      short   shIndSecCuota  ;
      short   shIndNumTransa ;
      short   shIndNumVenta  ;
      short   shIndFolioCTC  ;
      char    szhFecIni[9]; /* EXEC SQL VAR szhFecIni IS STRING(9); */ 

      char    szhFecFin[9]; /* EXEC SQL VAR szhFecFin IS STRING(9); */ 



   /* EXEC SQL END DECLARE SECTION; */ 


   double dImporte   = 0.0;
   double dResta     = 0.0;
   double dImpPagConc= 0.0;
   double dAuxImp    = 0.0;
   DATCON stCon      ; /* Estructura para datos de un concepto */
   BOOL   bCanTotal  ; /* Indica si concepto ha sido totalmente cancelado */
   char   szTrace[80];
   int    iResul     ;
   BOOL   bResul     ;
   int    iEncon = 0 ;
   int    iCarrier = 0;

   	dImpPagConc    = 0.0;
   	dAuxImp        = 0.0;
   	lhCodCliente   = lCodCliente;
   	ihCodConcepto  = iCodConcepto;
    strcpy(szhFecIni,stDatPro.szFecIni);
    strcpy(szhFecFin,stDatPro.szFecFin);

   	/* Cursor para recuperar Conceptos al Debe no cancelados. */
   	/* EXEC SQL DECLARE C_DEBESCARABO CURSOR FOR
    	SELECT  A.COD_TIPDOCUM  ,
            	A.COD_CENTREMI  ,
            	A.NUM_SECUENCI  ,
            	A.COD_VENDEDOR_AGENTE,
	            A.LETRA         ,
	            A.NUM_ABONADO   ,
	            A.COD_PRODUCTO  ,
	            A.COD_CONCEPTO  ,
	            A.COLUMNA       ,
	            A.IMPORTE_DEBE  ,
	            A.IMPORTE_HABER ,
	            A.NUM_FOLIO     ,
	            A.NUM_CUOTA     ,
	            A.SEC_CUOTA     ,
	            A.NUM_TRANSACCION,
	            A.NUM_VENTA     ,
	            A.NUM_FOLIOCTC
	       FROM CO_CARTERA A, CO_CONCEPTOS B
	      WHERE A.COD_CLIENTE   = :lhCodCliente
	        AND A.COD_CONCEPTO    = :ihCodConcepto
	        AND A.COD_CONCEPTO    = B.COD_CONCEPTO
	        AND A.FEC_EFECTIVIDAD BETWEEN TO_DATE(:szhFecIni,'YYYYMMDD') AND TO_DATE(:szhFecFin,'YYYYMMDD')
	      ORDER BY A.COD_TIPDOCUM, A.NUM_SECUENCI, A.FEC_ANTIGUEDAD,B.ORDEN_CAN
	      FOR UPDATE; */ 


	/* EXEC SQL OPEN C_DEBESCARABO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = sq0014;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )586;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqcmod = (unsigned int )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecIni;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecFin;
 sqlstm.sqhstl[3] = (unsigned long )9;
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



    if (sqlca.sqlcode)
    {
    	fprintf(stderr,"* Error en Apertura de Cursor %s\n",szfnORAerror());
        return ERR_OPENCURSOR;
    }

    /* Bucle de cancelacion del importe. */
    while (TRUE)
    {

    	/* EXEC SQL FETCH C_DEBESCARABO
          INTO
                :ihCodTipDocum,
                :ihCodCentrEmi,
                :lhNumSecuenci,
                :lhCodAgente,
                :szhLetra,
                :lhNumAbonado,
                :ihCodProducto,
                :ihCodConcepto ,
                :ihColumna      ,
                :dhImporteDebe  ,
                :dhImporteHaber ,
                :lhNumFolio:shIndNumFolio,
                :lhNumCuota:shIndNumCuota,
                :ihSecCuota:shIndSecCuota,
                :lhNumTransa:shIndNumTransa,
                :lhNumVenta:shIndNumVenta,
                :szhFolioCTC:shIndFolioCTC; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 17;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )617;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqfoff = (         int )0;
     sqlstm.sqfmod = (unsigned int )2;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentrEmi;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
     sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
     sqlstm.sqhstl[4] = (unsigned long )2;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)&lhNumAbonado;
     sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)&ihCodProducto;
     sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)&ihCodConcepto;
     sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[7] = (         int  )0;
     sqlstm.sqindv[7] = (         short *)0;
     sqlstm.sqinds[7] = (         int  )0;
     sqlstm.sqharm[7] = (unsigned long )0;
     sqlstm.sqadto[7] = (unsigned short )0;
     sqlstm.sqtdso[7] = (unsigned short )0;
     sqlstm.sqhstv[8] = (unsigned char  *)&ihColumna;
     sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[8] = (         int  )0;
     sqlstm.sqindv[8] = (         short *)0;
     sqlstm.sqinds[8] = (         int  )0;
     sqlstm.sqharm[8] = (unsigned long )0;
     sqlstm.sqadto[8] = (unsigned short )0;
     sqlstm.sqtdso[8] = (unsigned short )0;
     sqlstm.sqhstv[9] = (unsigned char  *)&dhImporteDebe;
     sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[9] = (         int  )0;
     sqlstm.sqindv[9] = (         short *)0;
     sqlstm.sqinds[9] = (         int  )0;
     sqlstm.sqharm[9] = (unsigned long )0;
     sqlstm.sqadto[9] = (unsigned short )0;
     sqlstm.sqtdso[9] = (unsigned short )0;
     sqlstm.sqhstv[10] = (unsigned char  *)&dhImporteHaber;
     sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[10] = (         int  )0;
     sqlstm.sqindv[10] = (         short *)0;
     sqlstm.sqinds[10] = (         int  )0;
     sqlstm.sqharm[10] = (unsigned long )0;
     sqlstm.sqadto[10] = (unsigned short )0;
     sqlstm.sqtdso[10] = (unsigned short )0;
     sqlstm.sqhstv[11] = (unsigned char  *)&lhNumFolio;
     sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[11] = (         int  )0;
     sqlstm.sqindv[11] = (         short *)&shIndNumFolio;
     sqlstm.sqinds[11] = (         int  )0;
     sqlstm.sqharm[11] = (unsigned long )0;
     sqlstm.sqadto[11] = (unsigned short )0;
     sqlstm.sqtdso[11] = (unsigned short )0;
     sqlstm.sqhstv[12] = (unsigned char  *)&lhNumCuota;
     sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[12] = (         int  )0;
     sqlstm.sqindv[12] = (         short *)&shIndNumCuota;
     sqlstm.sqinds[12] = (         int  )0;
     sqlstm.sqharm[12] = (unsigned long )0;
     sqlstm.sqadto[12] = (unsigned short )0;
     sqlstm.sqtdso[12] = (unsigned short )0;
     sqlstm.sqhstv[13] = (unsigned char  *)&ihSecCuota;
     sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[13] = (         int  )0;
     sqlstm.sqindv[13] = (         short *)&shIndSecCuota;
     sqlstm.sqinds[13] = (         int  )0;
     sqlstm.sqharm[13] = (unsigned long )0;
     sqlstm.sqadto[13] = (unsigned short )0;
     sqlstm.sqtdso[13] = (unsigned short )0;
     sqlstm.sqhstv[14] = (unsigned char  *)&lhNumTransa;
     sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[14] = (         int  )0;
     sqlstm.sqindv[14] = (         short *)&shIndNumTransa;
     sqlstm.sqinds[14] = (         int  )0;
     sqlstm.sqharm[14] = (unsigned long )0;
     sqlstm.sqadto[14] = (unsigned short )0;
     sqlstm.sqtdso[14] = (unsigned short )0;
     sqlstm.sqhstv[15] = (unsigned char  *)&lhNumVenta;
     sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[15] = (         int  )0;
     sqlstm.sqindv[15] = (         short *)&shIndNumVenta;
     sqlstm.sqinds[15] = (         int  )0;
     sqlstm.sqharm[15] = (unsigned long )0;
     sqlstm.sqadto[15] = (unsigned short )0;
     sqlstm.sqtdso[15] = (unsigned short )0;
     sqlstm.sqhstv[16] = (unsigned char  *)szhFolioCTC;
     sqlstm.sqhstl[16] = (unsigned long )12;
     sqlstm.sqhsts[16] = (         int  )0;
     sqlstm.sqindv[16] = (         short *)&shIndFolioCTC;
     sqlstm.sqinds[16] = (         int  )0;
     sqlstm.sqharm[16] = (unsigned long )0;
     sqlstm.sqadto[16] = (unsigned short )0;
     sqlstm.sqtdso[16] = (unsigned short )0;
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



		if (sqlca.sqlcode < 0)
        {
        	fprintf(stderr,"* Error en Fetch  %s\n",szfnORAerror());
            return ERR_FETCH;
        }

        if (sqlca.sqlcode == NOT_FOUND)
        {
            break;
        }

        /* Rellenar datos de Concepto */
        stCon.iCodTipDocum = ihCodTipDocum;
        stCon.iCodCentremi = ihCodCentrEmi;
        stCon.lNumSecuenci = lhNumSecuenci;
        stCon.lCodAgente = lhCodAgente;
        strcpy(stCon.szLetra    ,szhLetra);
        stCon.iCodConcepto = ihCodConcepto;
        stCon.iColumna     = ihColumna;
        stCon.iCodProducto = ihCodProducto;
        stCon.dImporteDebe = dhImporteDebe;
        stCon.dImporteHaber = dhImporteHaber;
        stCon.lNumAbonado = lhNumAbonado;
        if (shIndNumFolio == ORA_NULL)
           stCon.lNumFolio = ORA_NULL;
        else
           stCon.lNumFolio   = lhNumFolio;
        if (shIndNumCuota == ORA_NULL)
           stCon.lNumCuota = ORA_NULL;
        else
           stCon.lNumCuota   = lhNumCuota;
        if (shIndSecCuota == ORA_NULL)
           stCon.iSecCuota = ORA_NULL;
        else
           stCon.iSecCuota   = ihSecCuota;
        if (shIndNumTransa == ORA_NULL)
           stCon.lNumTransa = ORA_NULL;
        else
           stCon.lNumTransa  = lhNumTransa;
        if (shIndNumVenta == ORA_NULL)
           stCon.lNumVenta = ORA_NULL;
        else
           stCon.lNumVenta  = lhNumVenta;
        if (shIndFolioCTC == ORA_NULL)
           strcpy(stCon.szFolioCTC , "");
        else
           strcpy(stCon.szFolioCTC  , szhFolioCTC);

        /* Recuperamos importe que queda por cancelar del concepto */
        dResta = stCon.dImporteDebe - stCon.dImporteHaber;
        dResta = rint(dResta * INVMIN)/INVMIN;
        if (dResta <= 0.0)
           	return ERR_CALIMP; /* El importe haber > importe debe ERROR */

		dImporte = dImporte + dResta;
        dImporte = rint(dImporte * INVMIN)/INVMIN;

        dImpPagConc = dResta;

        /* Llevar la relacion del pago con el concepto a pagosconc */
        /* El importe en co_pagosconc es el importe que cancelo del
           concepto no es el importe total del pago */
        dAuxImp = stCon.dImporteHaber;
        dImpPagConc = rint(dImpPagConc * INVMIN) / INVMIN;

        stCon.dImporteHaber = dImpPagConc;
        if (!bfnDBInsPagCon(&stDatPag->stDatDocPago,&stCon))
           	return ERR_INSPAGCON;
        /* Dejo el importe del concepto como estaba */
        stCon.dImporteHaber = dAuxImp;

        /* Si el concepto ha sido cancelado hay que llevar al historico
           de cancelados el concepto */
        /* Borrar de la cartera el registro */
        /* Insertar en co_cancelados el registro cancelado */
        if (!bfnDBLlevarACanCarrier(&stCon,lhCodCliente,
                                 stDatPag->szFecValor))
        	return ERR_MOVCON;

	} /* Fin del bucle de lectura */

    /* EXEC SQL CLOSE C_DEBESCARABO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )700;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (sqlca.sqlcode != 0)
    {
       fprintf(stderr,"* Error en Cierre de Cursor %s\n",szfnORAerror());
       return ERR_CLOSECURSOR;
    }

    /* Si todavia queda pasta del pago tengo que generar un credito */
    dImporte = rint(dImporte * INVMIN)/INVMIN;

    stDatPag->dImpPago = dImporte;

    return OK;

} /* Fin ifnDBPagoUnAbonado() */
/****************************************************************************/
BOOL bfnDBInsPagCon(DATDOC *stDoc,DATCON *stHab)
/**
Descripcion: Lleva la relacion del pago con el concepto a pagosconc.
Salida     : En caso de error devuelve FALSE.
**/
{

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

	  int     ihCodTipDocum  ;
      int     ihCodCentrEmi  ;
      long    lhNumSecuenci  ;
      long    lhCodAgente    ;
      char    *szhLetra      ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

      double  dhImporteDebe  ;
      int     ihCodProducto  ;
      int     ihCodTipDocRel ;
      int     ihCodCenRel    ;
      long    lhNumSecRel    ;
      long    lhCodAgeRel    ;
      char    *szhLetraRel   ; /* EXEC SQL VAR szhLetraRel IS STRING(2); */ 

      int     ihCodConcepto  ;
      int     ihColumna      ;
      long    lhNumAbonado   ;
      long    lhNumFolio     ;
      long    lhNumCuota     ;
      int     ihSecCuota     ;
      long    lhNumTransa    ;
      long    lhNumVenta     ;
      char    szhFolioCTC[12]; /* EXEC SQL VAR szhFolioCTC IS STRING(12); */ 

      short   shIndCodTipDocRel;
      short   shIndCodCenRel ;
      short   shIndNumSecRel ;
      short   shIndCodAgeRel ;
      short   shIndLetraRel  ;
      short   shIndCodConcepto;
      short   shIndColumna   ;
      short   shIndNumAbonado;
      short   shIndNumFolio  ;
      short   shIndNumCuota  ;
      short   shIndSecCuota  ;
      short   shIndNumTransa ;
      short   shIndNumVenta  ;
      short   shIndFolioCTC  ;

   /* EXEC SQL END DECLARE SECTION; */ 


   /* Preparamos datos para insert en pagosconc */
   ihCodTipDocum = stDoc->iCodTipDocum;
   ihCodCentrEmi = stDoc->iCodCentrEmi;
   lhNumSecuenci = stDoc->lNumSecuenci;
   lhCodAgente  = stDoc->lCodAgente;
   szhLetra      = stDoc->szLetra;
   dhImporteDebe  = stHab->dImporteHaber;
   ihCodProducto  = stHab->iCodProducto;

   if (stHab->iCodTipDocum == ORA_NULL)
       shIndCodTipDocRel = ORA_NULL;
   else
   {
      ihCodTipDocRel = stHab->iCodTipDocum;
      shIndCodTipDocRel = 0;
   }
   if (stHab->iCodCentremi == ORA_NULL)
       shIndCodCenRel = ORA_NULL;
   else
   {
      ihCodCenRel    = stHab->iCodCentremi;
      shIndCodCenRel = 0;
   }
   if (stHab->lNumSecuenci == ORA_NULL)
       shIndNumSecRel = ORA_NULL;
   else
   {
      lhNumSecRel    = stHab->lNumSecuenci;
      shIndNumSecRel = 0;
   }
   if (stHab->lCodAgente == ORA_NULL)
       shIndCodAgeRel = ORA_NULL;
   else
   {
      lhCodAgeRel    = stHab->lCodAgente;
      shIndCodAgeRel = 0;
   }

   if ((strlen(stHab->szLetra)) == 0)
   {
       szhLetraRel = "";
       shIndLetraRel = ORA_NULL;
   }
   else
   {
      szhLetraRel = stHab->szLetra;
      shIndLetraRel = 0;
   }

   if (stHab->iCodConcepto == ORA_NULL)
       shIndCodConcepto = ORA_NULL;
   else
   {
      ihCodConcepto  = stHab->iCodConcepto;
      shIndCodConcepto = 0;
   }
   if (stHab->iColumna == ORA_NULL)
       shIndColumna = ORA_NULL;
   else
   {
      ihColumna      = stHab->iColumna;
      shIndColumna = 0;
   }

   if (stHab->lNumAbonado == ORA_NULL)
       shIndNumAbonado = ORA_NULL;
   else
   {
      lhNumAbonado   = stHab->lNumAbonado;
      shIndNumAbonado = 0;
   }
   if (stHab->lNumFolio == ORA_NULL)
       shIndNumFolio = ORA_NULL;
   else
   {
      lhNumFolio     = stHab->lNumFolio;
      shIndNumFolio = 0;
   }
   if (stHab->lNumCuota == ORA_NULL)
       shIndNumCuota = ORA_NULL;
   else
   {
      lhNumCuota     = stHab->lNumCuota;
      shIndNumCuota = 0;
   }
   if (stHab->iSecCuota == ORA_NULL)
       shIndSecCuota = ORA_NULL;
   else
   {
      ihSecCuota     = stHab->iSecCuota;
      shIndSecCuota = 0;
   }
   if (stHab->lNumTransa == ORA_NULL)
       shIndNumTransa = ORA_NULL;
   else
   {
      lhNumTransa   = stHab->lNumTransa;
      shIndNumTransa = 0;
   }
   if (stHab->lNumVenta == ORA_NULL)
       shIndNumVenta = ORA_NULL;
   else
   {
      lhNumVenta    = stHab->lNumVenta;
      shIndNumVenta = 0;
   }

   if ((strlen(stHab->szFolioCTC)) == 0)
   {
       strcpy(szhFolioCTC , "");
       shIndFolioCTC = ORA_NULL;
   }
   else
   {
      strcpy(szhFolioCTC , stHab->szFolioCTC);
      shIndFolioCTC = 0;
   }

   /* Insert en pagosconc */
   /* EXEC SQL
      INSERT INTO CO_PAGOSCONC
      (COD_TIPDOCUM  ,
       COD_CENTREMI  ,
       NUM_SECUENCI  ,
       COD_VENDEDOR_AGENTE    ,
       LETRA         ,
       IMP_CONCEPTO  ,
       COD_PRODUCTO  ,
       COD_TIPDOCREL ,
       COD_CENTRREL  ,
       NUM_SECUREL   ,
       COD_AGENTEREL ,
       LETRA_REL     ,
       COD_CONCEPTO  ,
       COLUMNA       ,
       NUM_ABONADO   ,
       NUM_FOLIO     ,
       NUM_CUOTA     ,
       SEC_CUOTA     ,
       NUM_TRANSACCION,
       NUM_VENTA  ,
         NUM_FOLIOCTC   )
      VALUES
      (:ihCodTipDocum  ,
       :ihCodCentrEmi  ,
       :lhNumSecuenci  ,
       :lhCodAgente   ,
       :szhLetra       ,
       :dhImporteDebe  ,
       :ihCodProducto  ,
       :ihCodTipDocRel:shIndCodTipDocRel,
       :ihCodCenRel:shIndCodCenRel,
       :lhNumSecRel:shIndNumSecRel,
       :lhCodAgeRel:shIndCodAgeRel,
       :szhLetraRel:shIndLetraRel,
       :ihCodConcepto:shIndCodConcepto,
       :ihColumna:shIndColumna,
       :lhNumAbonado:shIndNumAbonado,
       :lhNumFolio:shIndNumFolio,
       :lhNumCuota:shIndNumCuota,
       :ihSecCuota:shIndSecCuota,
       :lhNumTransa:shIndNumTransa,
       :lhNumVenta:shIndNumVenta,
       :szhFolioCTC:shIndFolioCTC); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 21;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_PAGOSCONC (COD_TIPDOCUM,COD_CENTREMI,NUM_SE\
CUENCI,COD_VENDEDOR_AGENTE,LETRA,IMP_CONCEPTO,COD_PRODUCTO,COD_TIPDOCREL,COD_C\
ENTRREL,NUM_SECUREL,COD_AGENTEREL,LETRA_REL,COD_CONCEPTO,COLUMNA,NUM_ABONADO,N\
UM_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC) values (:\
b0,:b1,:b2,:b3,:b4,:b5,:b6,:b7:b8,:b9:b10,:b11:b12,:b13:b14,:b15:b16,:b17:b18,\
:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29:b30,:b31:b32,:b33:b34)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )715;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[4] = (unsigned long )2;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&dhImporteDebe;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodTipDocRel;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)&shIndCodTipDocRel;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodCenRel;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)&shIndCodCenRel;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&lhNumSecRel;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)&shIndNumSecRel;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&lhCodAgeRel;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)&shIndCodAgeRel;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhLetraRel;
   sqlstm.sqhstl[11] = (unsigned long )2;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)&shIndLetraRel;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)&shIndCodConcepto;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)&shIndColumna;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)&shIndNumAbonado;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
   sqlstm.sqhstv[15] = (unsigned char  *)&lhNumFolio;
   sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[15] = (         int  )0;
   sqlstm.sqindv[15] = (         short *)&shIndNumFolio;
   sqlstm.sqinds[15] = (         int  )0;
   sqlstm.sqharm[15] = (unsigned long )0;
   sqlstm.sqadto[15] = (unsigned short )0;
   sqlstm.sqtdso[15] = (unsigned short )0;
   sqlstm.sqhstv[16] = (unsigned char  *)&lhNumCuota;
   sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[16] = (         int  )0;
   sqlstm.sqindv[16] = (         short *)&shIndNumCuota;
   sqlstm.sqinds[16] = (         int  )0;
   sqlstm.sqharm[16] = (unsigned long )0;
   sqlstm.sqadto[16] = (unsigned short )0;
   sqlstm.sqtdso[16] = (unsigned short )0;
   sqlstm.sqhstv[17] = (unsigned char  *)&ihSecCuota;
   sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[17] = (         int  )0;
   sqlstm.sqindv[17] = (         short *)&shIndSecCuota;
   sqlstm.sqinds[17] = (         int  )0;
   sqlstm.sqharm[17] = (unsigned long )0;
   sqlstm.sqadto[17] = (unsigned short )0;
   sqlstm.sqtdso[17] = (unsigned short )0;
   sqlstm.sqhstv[18] = (unsigned char  *)&lhNumTransa;
   sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[18] = (         int  )0;
   sqlstm.sqindv[18] = (         short *)&shIndNumTransa;
   sqlstm.sqinds[18] = (         int  )0;
   sqlstm.sqharm[18] = (unsigned long )0;
   sqlstm.sqadto[18] = (unsigned short )0;
   sqlstm.sqtdso[18] = (unsigned short )0;
   sqlstm.sqhstv[19] = (unsigned char  *)&lhNumVenta;
   sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[19] = (         int  )0;
   sqlstm.sqindv[19] = (         short *)&shIndNumVenta;
   sqlstm.sqinds[19] = (         int  )0;
   sqlstm.sqharm[19] = (unsigned long )0;
   sqlstm.sqadto[19] = (unsigned short )0;
   sqlstm.sqtdso[19] = (unsigned short )0;
   sqlstm.sqhstv[20] = (unsigned char  *)szhFolioCTC;
   sqlstm.sqhstl[20] = (unsigned long )12;
   sqlstm.sqhsts[20] = (         int  )0;
   sqlstm.sqindv[20] = (         short *)&shIndFolioCTC;
   sqlstm.sqinds[20] = (         int  )0;
   sqlstm.sqharm[20] = (unsigned long )0;
   sqlstm.sqadto[20] = (unsigned short )0;
   sqlstm.sqtdso[20] = (unsigned short )0;
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



   if (sqlca.sqlcode)
   {
      fprintf(stderr,"* Error en Insert PAGCONC %s\n",szfnORAerror());
      return FALSE;
   }

   return TRUE;

} /* Fin DBInsPagCon() */

/*****************************************************************************/
BOOL bfnDBLlevarACanCarrier(DATCON *stCon,long lCodCliente,char *szFecHis)
/**
Descripcion: Mueve el concepto de argumento y todos sus relacionados de
             cartera a cancelados.
Salida     : En caso de error devuelve FALSE.
**/
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

      long   lhCodCliente    ;
      int    ihCodTipDocum   ;
      long   lhCodAgente     ;
      char   *szhLetra       ; /* EXEC SQL VAR szhLetra     IS STRING(2); */ 

      int    ihCodCentrEmi   ;
      long   lhNumSecuenci   ;
      int    ihCodConcepto   ;
      int    ihColumna       ;
      char   *szhFecHistorico; /* EXEC SQL VAR szhFecHistorico IS STRING(9); */ 

      int    ihCodProducto   ;
      long   lhNumAbonado    ;
   /* EXEC SQL END DECLARE SECTION; */ 


   /* Prepara datos para "move" */
   lhCodCliente  = lCodCliente ;
   ihCodTipDocum = stCon->iCodTipDocum;
   lhCodAgente   = stCon->lCodAgente ;
   szhLetra      = stCon->szLetra     ;
   ihCodCentrEmi = stCon->iCodCentremi;
   lhNumSecuenci = stCon->lNumSecuenci;
   ihCodConcepto = stCon->iCodConcepto;
   ihColumna     = stCon->iColumna;
   ihCodProducto = stCon->iCodProducto;
   lhNumAbonado  = stCon->lNumAbonado;

   szhFecHistorico = szFecHis;

   /* EXEC SQL INSERT
            INTO CO_CANCELADOS
               (COD_CLIENTE    ,
               COD_TIPDOCUM   ,
               COD_CENTREMI   ,
               NUM_SECUENCI   ,
               COD_VENDEDOR_AGENTE     ,
               LETRA          ,
               COD_CONCEPTO   ,
               COLUMNA        ,
               COD_PRODUCTO   ,
               IMPORTE_DEBE   ,
               IMPORTE_HABER  ,
               IND_CONTADO    ,
               IND_FACTURADO  ,
               FEC_EFECTIVIDAD,
               FEC_CANCELACION,
               IND_PORTADOR   ,
               FEC_VENCIMIE   ,
               FEC_CADUCIDA   ,
               FEC_ANTIGUEDAD ,
               FEC_PAGO       ,
               NUM_ABONADO    ,
               NUM_FOLIO      ,
               NUM_CUOTA      ,
               SEC_CUOTA      ,
               NUM_TRANSACCION,
               NUM_VENTA      ,
                    NUM_FOLIOCTC   )
            SELECT
               COD_CLIENTE    ,
               COD_TIPDOCUM   ,
               COD_CENTREMI   ,
               NUM_SECUENCI   ,
               COD_VENDEDOR_AGENTE     ,
               LETRA          ,
               COD_CONCEPTO   ,
               COLUMNA        ,
               COD_PRODUCTO   ,
               IMPORTE_DEBE   ,
               IMPORTE_DEBE  ,
               /oIMPORTE_HABER  , o/
               IND_CONTADO    ,
               IND_FACTURADO  ,
               FEC_EFECTIVIDAD,
               TO_DATE(:szhFecHistorico,'yyyymmdd'),
               1,
               FEC_VENCIMIE   ,
               FEC_CADUCIDA   ,
               FEC_ANTIGUEDAD ,
               SYSDATE        ,
               NUM_ABONADO    ,
               NUM_FOLIO      ,
               NUM_CUOTA      ,
               SEC_CUOTA      ,
               NUM_TRANSACCION,
               NUM_VENTA      ,
                    NUM_FOLIOCTC
            FROM CO_CARTERA
            WHERE COD_CLIENTE        = :lhCodCliente
                  AND COD_TIPDOCUM   = :ihCodTipDocum
                  AND COD_CENTREMI   = :ihCodCentrEmi
                  AND NUM_SECUENCI   = :lhNumSecuenci
                  AND COD_VENDEDOR_AGENTE     = :lhCodAgente
                  AND LETRA          = :szhLetra
                  AND COD_PRODUCTO   = :ihCodProducto
                  AND NUM_ABONADO    = :lhNumAbonado
                  AND COD_CONCEPTO   = :ihCodConcepto
                  AND COLUMNA        = :ihColumna; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 21;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into CO_CANCELADOS (COD_CLIENTE,COD_TIPDOCUM,COD_CE\
NTREMI,NUM_SECUENCI,COD_VENDEDOR_AGENTE,LETRA,COD_CONCEPTO,COLUMNA,COD_PRODUCT\
O,IMPORTE_DEBE,IMPORTE_HABER,IND_CONTADO,IND_FACTURADO,FEC_EFECTIVIDAD,FEC_CAN\
CELACION,IND_PORTADOR,FEC_VENCIMIE,FEC_CADUCIDA,FEC_ANTIGUEDAD,FEC_PAGO,NUM_AB\
ONADO,NUM_FOLIO,NUM_CUOTA,SEC_CUOTA,NUM_TRANSACCION,NUM_VENTA,NUM_FOLIOCTC)sel\
ect COD_CLIENTE ,COD_TIPDOCUM ,COD_CENTREMI ,NUM_SECUENCI ,COD_VENDEDOR_AGENTE\
 ,LETRA ,COD_CONCEPTO ,COLUMNA ,COD_PRODUCTO ,IMPORTE_DEBE ,IMPORTE_DEBE ,IND_\
CONTADO ,IND_FACTURADO ,FEC_EFECTIVIDAD ,TO_DATE(:b0,'yyyymmdd') ,1 ,FEC_VENCI\
MIE ,FEC_CADUCIDA ,FEC_ANTIGUEDAD ,SYSDATE ,NUM_ABONADO ,NUM_FOLIO ,NUM_CUOTA \
,SEC_CUOTA ,NUM_TRANSACCION ,NUM_VENTA ,NUM_FOLIOCTC  from CO_CARTERA where ((\
(((((((COD_CLIENTE=:b1 and COD_TIPDOCUM=:b2) and COD_CENTREMI=:b3) and NUM_SEC\
UENCI=:b4) and COD_VENDEDOR_AGENTE=:b5) and LETRA=:b6) and COD_PRODUCTO=:b7) a\
nd NUM_ABONADO=:b8) and COD_CONCEPTO=:b9) and COLUMNA=:b10)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )814;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhFecHistorico;
   sqlstm.sqhstl[0] = (unsigned long )9;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[6] = (unsigned long )2;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
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



   if (sqlca.sqlcode != 0)
   {
      fprintf(stderr,"* Error en Insert CANCELADOS %s\n",
                  szfnORAerror());
      return FALSE;
   }

   /* Borramos de cartera */
   /* EXEC SQL
      DELETE CO_CARTERA
            WHERE  COD_CLIENTE    = :lhCodCliente
               AND COD_TIPDOCUM   = :ihCodTipDocum
               AND COD_CENTREMI   = :ihCodCentrEmi
               AND NUM_SECUENCI   = :lhNumSecuenci
               AND COD_VENDEDOR_AGENTE     = :lhCodAgente
               AND LETRA          = :szhLetra
               AND COD_CONCEPTO   = :ihCodConcepto
               AND COLUMNA        = :ihColumna
               AND COD_PRODUCTO   = :ihCodProducto
               AND NUM_ABONADO    = :lhNumAbonado; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 21;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "delete  from CO_CARTERA  where (((((((((COD_CLIENTE=:b0 an\
d COD_TIPDOCUM=:b1) and COD_CENTREMI=:b2) and NUM_SECUENCI=:b3) and COD_VENDED\
OR_AGENTE=:b4) and LETRA=:b5) and COD_CONCEPTO=:b6) and COLUMNA=:b7) and COD_P\
RODUCTO=:b8) and NUM_ABONADO=:b9)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )873;
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
   sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmi;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenci;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&lhCodAgente;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhLetra;
   sqlstm.sqhstl[5] = (unsigned long )2;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&ihCodConcepto;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&ihColumna;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&ihCodProducto;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&lhNumAbonado;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
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



   if (sqlca.sqlcode != 0)
   {
      fprintf(stderr,"* Error en Delete %s\n",szfnORAerror());
      return FALSE;
   }

   return TRUE;

} /* Fin DBLlevarACanCarrier(.)  */
/*****************************************************************************/


/* ********************************************************************************** */
/* szGetTime : Recupera la fecha en el formato deseado (pudiendo ser fecha y hora)   */
/*              Permite cualquier valor numerico, con las siguientes restricciones    */
/*              fmto = 0 : fecha de hoy en formato por defecto (dd/mm/yyyy)           */
/*              fmto > 0 : fecha de hoy en formato definido en el switch (y/u hora)   */
/*              fmto < 0 : fecha pasada en formato 2(yyyymmdd), retrocede 'fmto' dias */
/* ********************************************************************************** */
char *cfnGetTime(int fmto)
{
        char modulo[]="cfnGetTime";

        static time_t timer;
        static size_t nbytes;
        static char szTime[26]="";
        int iDia = 86400;

        memset(szTime,'\0',26);

        if (fmto >= 0)
        {
                timer = time((time_t *)0);
        }
        else
        {
                timer = time((time_t *)0)+fmto*iDia;
                fmto = 2;
        }

        switch (fmto)
        {
                case 1 :
                        nbytes = strftime(szTime, 26, "[%d-%b-%Y] [%H:%M:%S]",  (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000 -> [04-Feb-2000] [11:22:38] (escritura de log)*/
                case 2 :
                        nbytes = strftime(szTime, 26, "%Y%m%d",                 (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000->  20000204  (nombre de archivo) */
                case 3 :
                        nbytes = strftime(szTime, 26, "[%H:%M:%S]",             (struct tm *)localtime(&timer));
                        break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  [11:22:38] (escritura de log) */
                case 4 :
                        nbytes = strftime(szTime, 26, "%H%M%S",                 (struct tm *)localtime(&timer));
                        break; /* Ej.: 11 horas, 22 minutos, 38 segundos ->  112238 (nombre de archivo) */
                case 5 :
                        nbytes = strftime(szTime, 26, "%Y%m%d_%H%M%S",          (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000 -> 20000204_112238 (nombre de archivo: 1_3)*/
                case 6 :
                        nbytes = strftime(szTime, 26, "%j",                     (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000 -> 035 (fecha juliana 001-366 )*/
                case 7 :
                        nbytes = strftime(szTime, 26, "%Y%m%d%H%M%S",           (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000 -> 20000204112238 (tipo Oracle)*/
                default :
                        nbytes = strftime(szTime, 26, "%d/%m/%Y",               (struct tm *)localtime(&timer));
                        break; /* Ej.: 4 de febrero de 2000 -> 04/02/2000 (formato comun)*/
        }

        return (char *) szTime;

}/*******************************final szGetTime *******************************************/

/********************************************************************/
/* Recupera la causa de pago.                                       */
/* Si existe la almancena en variable szhCodCauPago y retorna TRUE  */
/* Si no, retorno FALSE                                             */
/********************************************************************/
BOOL bGetCausaPago(int  ihCodTipDocumPago,
                   int  ihCodCentrEmiPago,
                   long lhNumSecuenciPago,
                   long lhCodVendedorPago,
                   char *szhLetraPago,
                   char *szCodCauPago)
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char      szhCodCauPago[5];/* EXEC SQL VAR szhCodCauPago IS STRING(5); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


	fprintf(stDatPro.pLog, "-- bGetCausaPago --\n"
                           " ihCodTipDocumPago  [%d]\n"
                           " ihCodCentrEmiPago  [%d]\n"
                           " lhNumSecuenciPago  [%d]\n"
                           " lhCodVendedorPago  [%d]\n"
                           " szhLetraPago       [%s]\n"
                           ,ihCodTipDocumPago,ihCodCentrEmiPago
                           ,lhNumSecuenciPago,lhCodVendedorPago,szhLetraPago);


        /* EXEC SQL
            SELECT LPAD(COD_CAUPAGO,2,'0')
            INTO :szhCodCauPago
            FROM    CO_PAGOS
            WHERE   COD_TIPDOCUM        = :ihCodTipDocumPago
              AND   COD_CENTREMI        = :ihCodCentrEmiPago
              AND   NUM_SECUENCI        = :lhNumSecuenciPago
              AND   COD_VENDEDOR_AGENTE = :lhCodVendedorPago
              AND   LETRA              IN ('X','I'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 21;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select LPAD(COD_CAUPAGO,2,'0') into :b0  from CO_PAGO\
S where ((((COD_TIPDOCUM=:b1 and COD_CENTREMI=:b2) and NUM_SECUENCI=:b3) and C\
OD_VENDEDOR_AGENTE=:b4) and LETRA in ('X','I'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )928;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCodCauPago;
        sqlstm.sqhstl[0] = (unsigned long )5;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumPago;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmiPago;
        sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenciPago;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorPago;
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


        strcpy(szCodCauPago,szhCodCauPago);

        if ( sqlca.sqlcode == NOT_FOUND )
        {
            fprintf(stDatPro.pLog, "No encontro, busca con secuencia anterior\n");

            lhNumSecuenciPago--;

            /* EXEC SQL                /o Incorporado por PGonzaleg 25-02-2002 o/
            	SELECT LPAD(COD_CAUPAGO,2,'0')
              	  INTO :szhCodCauPago
            	  FROM    CO_PAGOS
            	 WHERE   COD_TIPDOCUM        = :ihCodTipDocumPago
              	   AND   COD_CENTREMI        = :ihCodCentrEmiPago
              	   AND   NUM_SECUENCI        = :lhNumSecuenciPago
              	   AND   COD_VENDEDOR_AGENTE = :lhCodVendedorPago
              	   AND   LETRA                IN ('X','I'); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 21;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select LPAD(COD_CAUPAGO,2,'0') into :b0  from CO_\
PAGOS where ((((COD_TIPDOCUM=:b1 and COD_CENTREMI=:b2) and NUM_SECUENCI=:b3) a\
nd COD_VENDEDOR_AGENTE=:b4) and LETRA in ('X','I'))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )963;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhCodCauPago;
            sqlstm.sqhstl[0] = (unsigned long )5;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocumPago;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCentrEmiPago;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&lhNumSecuenciPago;
            sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)&lhCodVendedorPago;
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


			strcpy(szCodCauPago,szhCodCauPago);

            if ( sqlca.sqlcode == NOT_FOUND )
            	return FALSE;
            else
            {
                if ( sqlca.sqlcode == 0 )
                {
            		fprintf(stDatPro.pLog, "Saliendo de Causa Pago OK \n");
                	return TRUE;
           		}
				else {
            		fprintf(stDatPro.pLog, "Saliendo de Causa Pago ERROR \n");
        			return FALSE;
				}
			}
        }
        else
        {
            if ( sqlca.sqlcode == 0 )
                return TRUE;
            else
                return FALSE;

        }
}/*Fin bGetCausaPago */


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

