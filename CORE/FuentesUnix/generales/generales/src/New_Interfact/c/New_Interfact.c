
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
static const struct sqlcxp sqlfpn =
{
    21,
    "./pc/New_Interfact.pc"
};


static unsigned int sqlctx = 110807051;


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
   unsigned char  *sqhstv[24];
   unsigned long  sqhstl[24];
            int   sqhsts[24];
            short *sqindv[24];
            int   sqinds[24];
   unsigned long  sqharm[24];
   unsigned long  *sqharc[24];
   unsigned short  sqadto[24];
   unsigned short  sqtdso[24];
} sqlstm = {12,24};

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
"select COD_TIPDOCUM ,TO_CHAR(TRUNC(FEC_EMISION),'YYYYMMDD') ,(MONTHS_BETWEEN\
(TRUNC(SYSDATE,'MONTH'),TRUNC(FEC_EMISION,'MONTH'))+1)  from FA_HISTDOCU where\
 (NUM_FOLIO=:b0 and PREF_PLAZA=:b1) union select COD_TIPDOCUM ,TO_CHAR(TRUNC(F\
EC_EMISION),'YYYYMMDD') ,(MONTHS_BETWEEN(TRUNC(SYSDATE,'MONTH'),TRUNC(FEC_EMIS\
ION,'MONTH'))+1)  from FA_FACTDOCU_NOCICLO where (NUM_FOLIO=:b0 and PREF_PLAZA\
=:b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,764,0,4,197,0,0,24,2,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,
0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,1,5,0,0,
116,0,0,2,595,0,5,413,0,0,18,18,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,3,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,0,1,5,0,
0,1,5,0,0,1,3,0,0,1,5,0,0,
203,0,0,3,671,0,3,470,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
226,0,0,4,68,0,2,505,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
249,0,0,5,149,0,4,666,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
284,0,0,6,62,0,4,849,0,0,3,2,0,1,0,1,5,0,0,1,3,0,0,2,3,0,0,
311,0,0,7,404,0,9,928,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
342,0,0,7,0,0,13,940,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,
369,0,0,7,0,0,15,983,0,0,0,0,0,1,0,
384,0,0,8,126,0,4,1018,0,0,5,2,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,1,3,0,0,1,5,0,0,
419,0,0,9,561,0,4,1108,0,0,22,3,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,
2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,
522,0,0,10,163,0,5,1348,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,
561,0,0,11,69,0,4,1387,0,0,2,1,0,1,0,1,5,0,0,2,4,0,0,
584,0,0,12,91,0,4,1419,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,
611,0,0,13,101,0,3,1430,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
642,0,0,14,102,0,5,1440,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
673,0,0,15,190,0,4,1483,0,0,5,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,5,0,0,
708,0,0,16,158,0,4,1538,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
731,0,0,17,184,0,4,1593,0,0,5,1,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
};


/****************************************************************************/
/* Libreria : interfact                                                     */
/* Fecha    : 17/11/1999                                                    */
/* Autor    : Mauricio Villagra                                             */
/****************************************************************************/
/*  Rutinas de proposito General para el Manejo de Interfaz de Facturacion  */
/*  considerando rutinas de : Select, Update, Paso Historico de Interfaz    */
/*  Estas rutinas deben quedar disponibles para cualquier programa que este */
/*  bajo la norma del modulo de facturacion.                                */
/****************************************************************************/
/*  22032001 : Se crea New_Interfact, para modificar rutinas de manejo de   */
/*  los estados de los documentos de entrada y salida de los procesos       */
/*  desde las colas de ejecucion de proceso                                 */
/****************************************************************************/
/*  23-01-2002: Modificaciones a las sgtes. funciones para la incorporacion */
/*  del campo Cod_Aplic como condicion de las sentencias SQL  		    */
/*  		bfnGetInterFact		bfnGetInterProc			    */
/*  		bfnUpdInterFact		bfnGetIntQueueProc		    */
/*  		bfnDelInterFact		bfnCambiaEstCola		    */
/*		vfnPrintInterFact					    */
/*  Autor: Patricio Gonzalez G.	(PGonzaleg)				    */
/****************************************************************************/

#include "deftypes.h"
#include "FaORA.h"
#include "errores.h"
#include "GenFA.h"
#include "New_Interfact.h"

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
/*                      funcion : bfnInitInterFact                          */
/****************************************************************************/
/* - Funcion que Valida un Registro en la Tabla de Interfaz de Facturacion  */
/*   FA_INTERFACT para un NUMERO de PROCESO y para un PROCESO de Facturacion*/
/*   Determinado                                                            */
/****************************************************************************/
/*   Valida Si existe el Registro, esta estado del Documento y el estado    */
/*   del proceso.                                                           */
/*   Actualiza el estado del Proceso Marcandolo como EN PROCESO             */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/

BOOL bfnInitInterFact(int iCodProcInt,long lNumProcInt,int iTipoFact)
{
    BOOL    bOK = TRUE  ;
    int     iTipoMov = 0;


    vDTrazasLog (szExeName, "\n\t\t* Parametro de Entrada (bfnInitInterFact)"
                            "\n\t\t=> Num Proceso       [%ld]"
                            "\n\t\t=> Tipo Movimiento   [%d]"
                            ,LOG03,lNumProcInt,iTipoMov);
    /********************************************************************/
    /*  Determina el Tipo de Movimiento Dependiendo del Tipo de Factura */
    /********************************************************************/
    switch (iTipoFact)
    {
        case FACT_CONTADO   :
            iTipoMov = stDatosGener.iCodContado ;
            break;
        case FACT_CICLO     :
            iTipoMov= stDatosGener.iCodCiclo    ;
            break;
        case FACT_NOTACRED  :
            iTipoMov= stDatosGener.iCodNotaCre  ;
            break;
        case FACT_MISCELAN  :
            iTipoMov= stDatosGener.iCodMiscela  ;
            break;
        default :
            iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Fa_InterProc",szfnORAerror ());
            bOK = FALSE;
            break;
    }
    if (bOK)
    {
        /********************************************************************/
        /*                      Registros de FA_INTPROCESOS                 */
        /********************************************************************/
        memset(&stInterProc,0,sizeof(INTPROCESOS));
        stInterProc.lCodProceso     = iCodProcInt ;
        strcpy(stInterProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 23-01-2002 */

        if (!bfnGetInterProc(&stInterProc))
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Fa_InterProc",szfnORAerror ());
            bOK = FALSE;
        }
    }

    if (bOK)
    {
        /********************************************************************/
        /*                      Registros de FA_INTERFACT                   */
        /********************************************************************/
        memset(&stInterFact,0,sizeof(INTERFACT));
        stInterFact.lNumProceso     =   lNumProcInt                 ;
        stInterFact.iCodTipMovimien =   iTipoMov                    ;
        strcpy(stInterFact.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 23-01-2002 */

        if (!bfnGetInterFact(&stInterFact))
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Fa_InterFact",szfnORAerror ());
            bOK = FALSE;
        }
        else
        {
            /********************************************************************/
            /*                  Registros de FA_INTQUEUEPROC                    */
            /********************************************************************/
            memset(&stIntQueueProc,0,sizeof(INTQUEUEPROC)      );
            strcpy(stIntQueueProc.szCodModGener ,stInterFact.szCodModGener );
            stIntQueueProc.lCodProceso   =       stInterProc.lCodProceso    ;
            strcpy(stIntQueueProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 23-01-2002 */

            if(!bfnGetIntQueueProc(&stIntQueueProc))
            {
                iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Fa_InterQueueProc",szfnORAerror ());
                bOK = FALSE;
            }
            else
            {
            	strcpy(stIntQueueProc.szCodAplic,"FAC"); /* Incorporado por PGonzaleg 23-01-2002 */
                vfnPrintQueueProc(stIntQueueProc);
            }
        }
    }
    return (bOK);
}



/****************************************************************************/
/*                      funcion : bfnGetInterFact                           */
/****************************************************************************/
/* - Funcion que recupera un registro de la tabla FA_INTERFACT por NUMERO de*/
/*   Proceso                                                                */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/

BOOL bfnGetInterFact (INTERFACT *stpInterFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhNumProceso         ;
    char    szhCodAplic	     [4] ;/* EXEC SQL VAR szhCodAplic     	    IS STRING(4); */ 
 /* Incorporado por PGonzaleg 23-01-2002 */
    int     lhNumVenta           ;
    char    szhCodModGener   [4] ;/* EXEC SQL VAR szhCodModGener       IS STRING(4); */ 

    int     ihCodEstaDoc         ;
    int     ihCodEstaProc        ;
    int     ihCodTipMovimien     ;
    char    szhCodCaTribut   [2] ;/* EXEC SQL VAR szhCodCaTribut       IS STRING(2); */ 

    int     ihTipImpositiva      ;
    int     ihCodModVenta        ;
    int     ihNumCuotas          ;
    int     ihCodTipDocum        ;
    long    lhNumFolio           ;
    long    lhNumFolioRel        ;
    char    szhFecIngreso    [20];/* EXEC SQL VAR szhFecIngreso        IS STRING(20); */ 

    char    szhFecFacturacion[20];/* EXEC SQL VAR szhFecFacturacion    IS STRING(20); */ 

    char    szhFecImpresion  [20];/* EXEC SQL VAR szhFecImpresion      IS STRING(20); */ 

    char    szhFecFoliacion  [20];/* EXEC SQL VAR szhFecFoliacion      IS STRING(20); */ 

    char    szhFecVisacion   [20];/* EXEC SQL VAR szhFecVisacion       IS STRING(20); */ 

    char    szhFecPasoCobro  [20];/* EXEC SQL VAR szhFecPasoCobro      IS STRING(20); */ 

    char    szhFecCierre     [20];/* EXEC SQL VAR szhFecCierre         IS STRING(20); */ 

    char    szhFecVencimiento[20];/* EXEC SQL VAR szhFecVencimiento    IS STRING(20); */ 

    char    szhPrefPlaza   [25+1];/* EXEC SQL VAR szhPrefPlaza         IS STRING(25+1); */ 

    char    szhPrefPlazaRel[25+1];/* EXEC SQL VAR szhPrefPlazaRel      IS STRING(25+1); */ 

    short   s_ihNumVenta         ;
    short   s_ihNumFolio         ;
    short   s_ihNumFolioRel      ;
    short   s_ihTipImpositiva    ;
    short   s_ihFecIngreso       ;
    short   s_ihFecFacturacion   ;
    short   s_ihFecImpresion     ;
    short   s_ihFecFoliacion     ;
    short   s_ihFecVisacion      ;
    short   s_ihFecPasoCobro     ;
    short   s_ihFecCierre        ;
    short   s_ihFecVencimiento   ;
    short   s_ihPrefPlaza	 ;
    short   s_ihPrefPlazaRel     ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhNumProceso    = stpInterFact->lNumProceso;
/* 20040620 TM-200406200758 Se cambia forma de copiar */
    strcpy(szhCodAplic,stpInterFact->szCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

    vDTrazasLog (szExeName, "\n\t\t\t* Parametro de Entrada (bfnGetInterFact)"
                            "\n\t\t\t=> Num Proceso             [%ld]"
                            "\n\t\t\t=> Codigo Aplicacion       [%s]"
                            ,LOG04
                            ,lhNumProceso
                            ,szhCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

    /* EXEC SQL
        SELECT  NUM_VENTA           ,
                COD_MODGENER        ,
                COD_CATRIBUT        ,
                COD_CATIMPOSITIVA   ,
                COD_MODVENTA        ,
                NUM_CUOTAS          ,
                COD_TIPDOCUM        ,
                NUM_FOLIO           ,
                NUM_FOLIOREL        ,
                TO_CHAR(FEC_INGRESO    ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_FACTURACION,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_IMPRESION  ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_FOLIACION  ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_VISACION   ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_PASOCOBRO  ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_CIERRE     ,'YYYYMMDDHH24MISS'),
                TO_CHAR(FEC_VENCIMIENTO,'YYYYMMDDHH24MISS'),
                COD_ESTADOC         ,
                COD_ESTPROC         ,
                COD_TIPMOVIMIEN		,
                PREF_PLAZA			,
                PREF_PLAZAREL
        INTO    :lhNumVenta         :s_ihNumVenta       ,
                :szhCodModGener                         ,
                :szhCodCaTribut                         ,
                :ihTipImpositiva    :s_ihTipImpositiva  ,
                :ihCodModVenta                          ,
                :ihNumCuotas                            ,
                :ihCodTipDocum                          ,
                :lhNumFolio         :s_ihNumFolio       ,
                :lhNumFolioRel      :s_ihNumFolioRel    ,
                :szhFecIngreso      :s_ihFecIngreso     ,
                :szhFecFacturacion  :s_ihFecFacturacion ,
                :szhFecImpresion    :s_ihFecImpresion   ,
                :szhFecFoliacion    :s_ihFecFoliacion   ,
                :szhFecVisacion     :s_ihFecVisacion    ,
                :szhFecPasoCobro    :s_ihFecPasoCobro   ,
                :szhFecCierre       :s_ihFecCierre      ,
                :szhFecVencimiento  :s_ihFecVencimiento ,
                :ihCodEstaDoc                           ,
                :ihCodEstaProc                          ,
                :ihCodTipMovimien                       ,
                :szhPrefPlaza       :s_ihPrefPlaza      ,
                :szhPrefPlazaRel    :s_ihPrefPlazaRel
        FROM    FA_INTERFACT
        WHERE   NUM_PROCESO = :lhNumProceso
        AND     COD_APLIC 	= :szhCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NUM_VENTA ,COD_MODGENER ,COD_CATRIBUT ,COD_CATIMPO\
SITIVA ,COD_MODVENTA ,NUM_CUOTAS ,COD_TIPDOCUM ,NUM_FOLIO ,NUM_FOLIOREL ,TO_CH\
AR(FEC_INGRESO,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_FACTURACION,'YYYYMMDDHH24MISS'\
) ,TO_CHAR(FEC_IMPRESION,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_FOLIACION,'YYYYMMDDH\
H24MISS') ,TO_CHAR(FEC_VISACION,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_PASOCOBRO,'YY\
YYMMDDHH24MISS') ,TO_CHAR(FEC_CIERRE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_VENCIMIE\
NTO,'YYYYMMDDHH24MISS') ,COD_ESTADOC ,COD_ESTPROC ,COD_TIPMOVIMIEN ,PREF_PLAZA\
 ,PREF_PLAZAREL into :b0:b1,:b2,:b3,:b4:b5,:b6,:b7,:b8,:b9:b10,:b11:b12,:b13:b\
14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24,:b25:b26,:b27:b28,:b29,:b30,:b\
31,:b32:b33,:b34:b35  from FA_INTERFACT where (NUM_PROCESO=:b36 and COD_APLIC=\
:b37)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)&s_ihNumVenta;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodModGener;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCaTribut;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihTipImpositiva;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&s_ihTipImpositiva;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodModVenta;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihNumCuotas;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&s_ihNumFolio;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhNumFolioRel;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&s_ihNumFolioRel;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhFecIngreso;
    sqlstm.sqhstl[9] = (unsigned long )20;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)&s_ihFecIngreso;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhFecFacturacion;
    sqlstm.sqhstl[10] = (unsigned long )20;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&s_ihFecFacturacion;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFecImpresion;
    sqlstm.sqhstl[11] = (unsigned long )20;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)&s_ihFecImpresion;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFecFoliacion;
    sqlstm.sqhstl[12] = (unsigned long )20;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)&s_ihFecFoliacion;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhFecVisacion;
    sqlstm.sqhstl[13] = (unsigned long )20;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)&s_ihFecVisacion;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhFecPasoCobro;
    sqlstm.sqhstl[14] = (unsigned long )20;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)&s_ihFecPasoCobro;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhFecCierre;
    sqlstm.sqhstl[15] = (unsigned long )20;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)&s_ihFecCierre;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhFecVencimiento;
    sqlstm.sqhstl[16] = (unsigned long )20;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)&s_ihFecVencimiento;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihCodEstaDoc;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)&ihCodTipMovimien;
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[20] = (unsigned long )26;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)&s_ihPrefPlaza;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhPrefPlazaRel;
    sqlstm.sqhstl[21] = (unsigned long )26;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)&s_ihPrefPlazaRel;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)szhCodAplic;
    sqlstm.sqhstl[23] = (unsigned long )4;
    sqlstm.sqhsts[23] = (         int  )0;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
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

 

    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en Select bfnGetInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en Select bfnGetInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
    }
    if (SQLCODE == SQLOK)
    {
        /* 20040620 TM-200406200758 Se cambia forma de copiar */
        strcpy(stpInterFact->szCodModGener     ,szhCodModGener   );

        stpInterFact->lNumVenta      = ((s_ihNumVenta == ORA_NULL)?0:lhNumVenta);

        strcpy(stpInterFact->szCodCaTribut     , szhCodCaTribut  );

        stpInterFact->iTipImpositiva = ((s_ihTipImpositiva == ORA_NULL)?0:ihTipImpositiva);

        stpInterFact->iCodModVenta   = ihCodModVenta                       ;
        stpInterFact->iNumCuotas     = ihNumCuotas                         ;
        stpInterFact->iCodTipDocum   = ihCodTipDocum                       ;

        stpInterFact->lNumFolio      = ((s_ihNumFolio == ORA_NULL)?0:lhNumFolio);
        stpInterFact->lNumFolioRel   = ((s_ihNumFolioRel == ORA_NULL)?0:lhNumFolioRel);

/* 20040620 TM-200406200758 Se cambia forma copiar */                                                       
        if (s_ihFecIngreso      == ORA_NULL)    strcpy(stpInterFact->szFecIngreso     ,"\0" );              
        else                                    strcpy(stpInterFact->szFecIngreso     ,szhFecIngreso     ); 
        if (s_ihFecFacturacion  == ORA_NULL)    strcpy(stpInterFact->szFecFacturacion ,"\0" );              
        else                                    strcpy(stpInterFact->szFecFacturacion ,szhFecFacturacion ); 
        if (s_ihFecImpresion    == ORA_NULL)    strcpy(stpInterFact->szFecImpresion   ,"\0" );              
        else                                    strcpy(stpInterFact->szFecImpresion   ,szhFecImpresion   ); 
        if (s_ihFecFoliacion    == ORA_NULL)    strcpy(stpInterFact->szFecFoliacion   ,"\0" );              
        else                                    strcpy(stpInterFact->szFecFoliacion   ,szhFecFoliacion   ); 
        if (s_ihFecVisacion     == ORA_NULL)    strcpy(stpInterFact->szFecVisacion    ,"\0" );              
        else                                    strcpy(stpInterFact->szFecVisacion    ,szhFecVisacion    ); 
        if (s_ihFecPasoCobro    == ORA_NULL)    strcpy(stpInterFact->szFecPasoCobro   ,"\0" );              
        else                                    strcpy(stpInterFact->szFecPasoCobro   ,szhFecPasoCobro   ); 
        if (s_ihFecCierre       == ORA_NULL)    strcpy(stpInterFact->szFecCierre      ,"\0" );              
        else                                    strcpy(stpInterFact->szFecCierre      ,szhFecCierre      ); 
        if (s_ihFecVencimiento  == ORA_NULL)    strcpy(stpInterFact->szFecVencimiento ,"\0" );              
        else                                    strcpy(stpInterFact->szFecVencimiento ,szhFecVencimiento ); 


        stpInterFact->iCodEstaDoc       = ihCodEstaDoc                      ;
        stpInterFact->iCodEstaProc      = ihCodEstaProc                     ;
        stpInterFact->iCodTipMovimien   = ihCodTipMovimien                  ;

        if (s_ihPrefPlaza       == ORA_NULL)    strcpy(stpInterFact->szPrefPlaza      ,"\0" );                  
        else                                    strcpy(stpInterFact->szPrefPlaza      ,szhPrefPlaza       );        
        if (s_ihPrefPlazaRel    == ORA_NULL)    strcpy(stpInterFact->szPrefPlazaRel   ,"\0" );                      
        else                                    strcpy(stpInterFact->szPrefPlazaRel   ,szhPrefPlazaRel   );         

    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/*********************** Final bfnGetInterFact ******************************/



/****************************************************************************/
/*                      funcion : bfnUpdInterFact                           */
/****************************************************************************/
/* - Funcion que Modifica el Valor de Un Registro en la tabla FA_INTERFACT  */
/*   por NUMERO de Proceso                                                  */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/

BOOL bfnUpdInterFact(INTERFACT stpInterFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhNumProceso         ;
    char    szhCodAplic	     [4] ;/* EXEC SQL VAR szhCodAplic     	    IS STRING(4); */ 
 /* Incorporado por PGonzaleg 23-01-2002 */
    int     ihCodEstaDoc         ;
    int     ihCodEstaProc        ;
    int     ihCodTipDocum        ;
    char    szhFecIngreso    [20];/* EXEC SQL VAR szhFecIngreso        IS STRING(20); */ 

    char    szhFecFacturacion[20];/* EXEC SQL VAR szhFecFacturacion    IS STRING(20); */ 

    char    szhFecImpresion  [20];/* EXEC SQL VAR szhFecImpresion      IS STRING(20); */ 

    char    szhFecFoliacion  [20];/* EXEC SQL VAR szhFecFoliacion      IS STRING(20); */ 

    char    szhFecVisacion   [20];/* EXEC SQL VAR szhFecVisacion       IS STRING(20); */ 

    char    szhFecPasoCobro  [20];/* EXEC SQL VAR szhFecPasoCobro      IS STRING(20); */ 

    char    szhFecCierre     [20];/* EXEC SQL VAR szhFecCierre         IS STRING(20); */ 

    char    szhFecVencimiento[20];/* EXEC SQL VAR szhFecVencimiento    IS STRING(20); */ 

    char    szhPrefPlaza     [25+1];/* EXEC SQL VAR szhPrefPlaza         IS STRING(25+1); */ 

    char    szhPrefPlazaRel  [25+1];/* EXEC SQL VAR szhPrefPlazaRel      IS STRING(25+1); */ 

    long    lhNumFolio          ;
    long    lhNumFolioRel       ;
    int     ihTipImpositiva     ;
    short   s_ihNumFolio        ;
    short   s_ihNumFolioRel     ;
    short   s_ihTipImpositiva   ;
    short   s_ihPrefPlaza	;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    vDTrazasLog (szExeName, "\n\t\t\t* Parametro de Entrada (bfnUpdInterFact)"
                            "\n\t\t\t=> Num Proceso         [%ld]"
                            "\n\t\t\t=> Cod. Esta. Doc      [%ld]"
                            "\n\t\t\t=> Cod. Esta. Proc     [%ld]"
                            "\n\t\t\t=> Cod. Aplicacion     [%s]"
                            ,LOG04
                            ,stpInterFact.lNumProceso
                            ,stpInterFact.iCodEstaDoc
                            ,stpInterFact.iCodEstaProc
                            ,stpInterFact.szCodAplic ); /* Incorporado por PGonzaleg 23-01-2002 */

    vfnPrintInterFact(stpInterFact);

    lhNumProceso = stpInterFact.lNumProceso;
    /* 20040620 TM-200406200758 Se cambia forma de copiar */
    strcpy(szhCodAplic,stpInterFact.szCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */    

    if  (stpInterFact.lNumFolio <= 0)       s_ihNumFolio        = ORA_NULL  ;
    else                                    s_ihNumFolio        = SQLOK     ;
    if  (stpInterFact.lNumFolioRel <= 0)    s_ihNumFolioRel     = ORA_NULL  ;
    else                                    s_ihNumFolioRel     = SQLOK     ;
    if  (stpInterFact.iTipImpositiva <= 0)  s_ihTipImpositiva   = ORA_NULL  ;
    else                                    s_ihTipImpositiva   = SQLOK     ;

    if  (strlen(stpInterFact.szPrefPlaza ) == 0) s_ihPrefPlaza 	= ORA_NULL  ;
    else                                         s_ihPrefPlaza  = SQLOK     ;

    ihCodEstaDoc                =stpInterFact.iCodEstaDoc;
    ihCodEstaProc               =stpInterFact.iCodEstaProc;
    ihCodTipDocum               =stpInterFact.iCodTipDocum;         
    strcpy(szhFecIngreso       ,stpInterFact.szFecIngreso) ;     
    strcpy(szhFecFacturacion   ,stpInterFact.szFecFacturacion) ; 
    strcpy(szhFecImpresion     ,stpInterFact.szFecImpresion) ;   
    strcpy(szhFecFoliacion     ,stpInterFact.szFecFoliacion) ;   
    strcpy(szhFecVisacion      ,stpInterFact.szFecVisacion) ;    
    strcpy(szhFecPasoCobro     ,stpInterFact.szFecPasoCobro) ;   
    strcpy(szhFecCierre        ,stpInterFact.szFecCierre) ;      
    strcpy(szhFecVencimiento   ,stpInterFact.szFecVencimiento) ; 
    lhNumFolio                  =stpInterFact.lNumFolio;
    lhNumFolioRel               =stpInterFact.lNumFolioRel;
    ihTipImpositiva             =stpInterFact.iTipImpositiva;
    strcpy(szhPrefPlaza         ,stpInterFact.szPrefPlaza);   
    strcpy(szhPrefPlazaRel      ,stpInterFact.szPrefPlazaRel);

    /* Salida a LOG */
    vDTrazasLog  (szExeName,"[INFO] Datos pasados a Update:\n"
    						"[INFO] ihCodEstaDoc: 		[%d]\n"
    						"[INFO] ihCodEstaProc: 		[%d]\n"
    						"[INFO] lhNumFolio: 		[%ld], s_ihNumFolio: [%d]\n"
    						"[INFO] lhNumFolioRel: 		[%ld], s_ihNumFolioRel: [%d]\n"
    						"[INFO] ihTipImpositiva:	[%d], s_ihTipImpositiva: [%d]\n"
    						"[INFO] ihCodTipDocum: 		[%d]\n"
    						"[INFO] szhFecIngreso: 		[%s]\n"
    						"[INFO] szhFecFacturacion: 	[%s]\n"
    						"[INFO] szhFecImpresion: 	[%s]\n"
    						"[INFO] szhFecFoliacion: 	[%s]\n"
    						"[INFO] szhFecVisacion: 	[%s]\n"
    						"[INFO] szhFecPasoCobro: 	[%s]\n"
    						"[INFO] szhFecCierre: 		[%s]\n"
    						"[INFO] szhFecVencimiento: 	[%s]\n"
    						"[INFO] szhPrefPlaza: 		[%s], s_ihPrefPlaza: [%d]\n"
    						"[INFO] szhPrefPlazaRel: 	[%s], s_ihPrefPlaza: [%d]\n"
    						"[INFO] lhNumProceso: 		[%ld]\n"
    						"[INFO] szhCodAplic: 		[%s]\n"
    						,LOG06, ihCodEstaDoc,ihCodEstaProc
    						,lhNumFolio, s_ihNumFolio
    						,lhNumFolioRel,s_ihNumFolioRel
    						,ihTipImpositiva,s_ihTipImpositiva
    						,ihCodTipDocum,szhFecIngreso
    						,szhFecFacturacion,szhFecImpresion
    						,szhFecFoliacion,szhFecVisacion
    						,szhFecPasoCobro,szhFecCierre
    						,szhFecVencimiento,szhPrefPlaza,s_ihPrefPlaza
    						,szhPrefPlazaRel,s_ihPrefPlaza,lhNumProceso,szhCodAplic);
    
    /* EXEC SQL
        UPDATE FA_INTERFACT
        SET     COD_ESTADOC         = :ihCodEstaDoc                                 ,
                COD_ESTPROC         = :ihCodEstaProc                                ,
                NUM_FOLIO           = :lhNumFolio        	:s_ihNumFolio         	,
                NUM_FOLIOREL        = :lhNumFolioRel        :s_ihNumFolioRel      	,
                COD_CATIMPOSITIVA   = :ihTipImpositiva      :s_ihTipImpositiva    	,
                COD_TIPDOCUM        = :ihCodTipDocum                                ,
                FEC_INGRESO         = TO_DATE(:szhFecIngreso    ,'YYYYMMDDHH24MISS'),
                FEC_FACTURACION     = TO_DATE(:szhFecFacturacion,'YYYYMMDDHH24MISS'),
                FEC_IMPRESION       = TO_DATE(:szhFecImpresion  ,'YYYYMMDDHH24MISS'),
                FEC_FOLIACION       = TO_DATE(:szhFecFoliacion  ,'YYYYMMDDHH24MISS'),
                FEC_VISACION        = TO_DATE(:szhFecVisacion   ,'YYYYMMDDHH24MISS'),
                FEC_PASOCOBRO       = TO_DATE(:szhFecPasoCobro  ,'YYYYMMDDHH24MISS'),
                FEC_CIERRE          = TO_DATE(:szhFecCierre     ,'YYYYMMDDHH24MISS'),
                FEC_VENCIMIENTO     = TO_DATE(:szhFecVencimiento,'YYYYMMDDHH24MISS'),
                PREF_PLAZA          = :szhPrefPlaza     :s_ihPrefPlaza,
                PREF_PLAZAREL       = :szhPrefPlazaRel  :s_ihPrefPlaza
        WHERE   NUM_PROCESO         = :lhNumProceso			
        AND	COD_APLIC	    = :szhCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update FA_INTERFACT  set COD_ESTADOC=:b0,COD_ESTPROC=:b1,\
NUM_FOLIO=:b2:b3,NUM_FOLIOREL=:b4:b5,COD_CATIMPOSITIVA=:b6:b7,COD_TIPDOCUM=:b8\
,FEC_INGRESO=TO_DATE(:b9,'YYYYMMDDHH24MISS'),FEC_FACTURACION=TO_DATE(:b10,'YYY\
YMMDDHH24MISS'),FEC_IMPRESION=TO_DATE(:b11,'YYYYMMDDHH24MISS'),FEC_FOLIACION=T\
O_DATE(:b12,'YYYYMMDDHH24MISS'),FEC_VISACION=TO_DATE(:b13,'YYYYMMDDHH24MISS'),\
FEC_PASOCOBRO=TO_DATE(:b14,'YYYYMMDDHH24MISS'),FEC_CIERRE=TO_DATE(:b15,'YYYYMM\
DDHH24MISS'),FEC_VENCIMIENTO=TO_DATE(:b16,'YYYYMMDDHH24MISS'),PREF_PLAZA=:b17:\
b18,PREF_PLAZAREL=:b19:b20 where (NUM_PROCESO=:b21 and COD_APLIC=:b22)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )116;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaDoc;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodEstaProc;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&s_ihNumFolio;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumFolioRel;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&s_ihNumFolioRel;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihTipImpositiva;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&s_ihTipImpositiva;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecIngreso;
    sqlstm.sqhstl[6] = (unsigned long )20;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhFecFacturacion;
    sqlstm.sqhstl[7] = (unsigned long )20;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhFecImpresion;
    sqlstm.sqhstl[8] = (unsigned long )20;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhFecFoliacion;
    sqlstm.sqhstl[9] = (unsigned long )20;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhFecVisacion;
    sqlstm.sqhstl[10] = (unsigned long )20;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFecPasoCobro;
    sqlstm.sqhstl[11] = (unsigned long )20;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFecCierre;
    sqlstm.sqhstl[12] = (unsigned long )20;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhFecVencimiento;
    sqlstm.sqhstl[13] = (unsigned long )20;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[14] = (unsigned long )26;
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)&s_ihPrefPlaza;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhPrefPlazaRel;
    sqlstm.sqhstl[15] = (unsigned long )26;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)&s_ihPrefPlaza;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)szhCodAplic;
    sqlstm.sqhstl[17] = (unsigned long )4;
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
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

 /* Incorporado por PGonzaleg 23-01-2002 */

    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en bfnUpdInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnUpdInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/*********************** Final bfnUpdInterFact ******************************/



/****************************************************************************/
/*                      funcion : bfnDelInterFact                           */
/****************************************************************************/
/* - Funcion que elimina un Registro de la tabla FA_INTERFACT y lo inserta  */
/*   en la tabla historica FA_HISTINTERFACT por NUMERO de Proceso              */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/

BOOL bfnDelInterFact( long lNumProceso, char *szCodAplic )
/* 	Incorporacion de nuevo  parametro de entrada	*/
/* 	- char szCodAplic - por PGonzaleg 23-01-2002    */
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

    long    lhNumProceso            ;
    char    szhCodAplic		[4] ; /* EXEC SQL VAR szhCodAplic     IS STRING(4); */ 
 /* Incorporado por PGonzaleg 23-01-2002 */
    /* EXEC SQL END DECLARE SECTION    ; */ 


    lhNumProceso = lNumProceso;
    strcpy(szhCodAplic,szCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

    vDTrazasLog (szExeName, "\n\t\t\t* Parametro de Entrada (bfnDelInterFact)"
                            "\n\t\t\t=> Num Proceso  [%ld]"
                            "\n\t\t\t=> Cod. Aplic.  [%s]"
                            ,LOG04,lNumProceso
                            ,szCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

    /* EXEC SQL
        INSERT INTO FA_HISTINTERFACT (
                NUM_PROCESO         ,NUM_VENTA           ,
                COD_MODGENER        ,COD_ESTADOC         ,
                COD_ESTPROC         ,COD_TIPMOVIMIEN     ,
                COD_CATRIBUT        ,COD_CATIMPOSITIVA   ,
                COD_TIPDOCUM        ,NUM_FOLIO           ,
                NUM_FOLIOREL        ,FEC_INGRESO         ,
                FEC_FACTURACION     ,FEC_IMPRESION       ,
                FEC_FOLIACION       ,FEC_VISACION        ,
                FEC_PASOCOBRO       ,FEC_CIERRE          ,
                FEC_VENCIMIENTO     ,PREF_PLAZA		 ,
                PREF_PLAZAREL		)
        SELECT  NUM_PROCESO         ,NUM_VENTA           ,
                COD_MODGENER        ,COD_ESTADOC         ,
                COD_ESTPROC         ,COD_TIPMOVIMIEN     ,
                COD_CATRIBUT        ,COD_CATIMPOSITIVA   ,
                COD_TIPDOCUM        ,NUM_FOLIO           ,
                NUM_FOLIOREL        ,FEC_INGRESO         ,
                FEC_FACTURACION     ,FEC_IMPRESION       ,
                FEC_FOLIACION       ,FEC_VISACION        ,
                FEC_PASOCOBRO       ,FEC_CIERRE          ,
                FEC_VENCIMIENTO	    ,PREF_PLAZA          ,
                PREF_PLAZAREL
        FROM    FA_INTERFACT
        WHERE   NUM_PROCESO = :lhNumProceso
        AND 	COD_APLIC   = :szhCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_HISTINTERFACT (NUM_PROCESO,NUM_VENTA,COD_M\
ODGENER,COD_ESTADOC,COD_ESTPROC,COD_TIPMOVIMIEN,COD_CATRIBUT,COD_CATIMPOSITIVA\
,COD_TIPDOCUM,NUM_FOLIO,NUM_FOLIOREL,FEC_INGRESO,FEC_FACTURACION,FEC_IMPRESION\
,FEC_FOLIACION,FEC_VISACION,FEC_PASOCOBRO,FEC_CIERRE,FEC_VENCIMIENTO,PREF_PLAZ\
A,PREF_PLAZAREL)select NUM_PROCESO ,NUM_VENTA ,COD_MODGENER ,COD_ESTADOC ,COD_\
ESTPROC ,COD_TIPMOVIMIEN ,COD_CATRIBUT ,COD_CATIMPOSITIVA ,COD_TIPDOCUM ,NUM_F\
OLIO ,NUM_FOLIOREL ,FEC_INGRESO ,FEC_FACTURACION ,FEC_IMPRESION ,FEC_FOLIACION\
 ,FEC_VISACION ,FEC_PASOCOBRO ,FEC_CIERRE ,FEC_VENCIMIENTO ,PREF_PLAZA ,PREF_P\
LAZAREL  from FA_INTERFACT where (NUM_PROCESO=:b0 and COD_APLIC=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )203;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAplic;
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

 /* Incorporado por PGonzaleg 23-01-2002 */

    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en bfnDelInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnDelInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
		return FALSE;
	}

	/* EXEC SQL
	    DELETE FROM FA_INTERFACT
	    WHERE   NUM_PROCESO = :lhNumProceso
	    AND     COD_APLIC   = :szhCodAplic; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "delete  from FA_INTERFACT  where (NUM_PROCESO=:b0 and COD_AP\
LIC=:b1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )226;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodAplic;
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

 /* Incorporado por PGonzaleg 23-01-2002 */;
    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en bfnDelInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnDelInterFact [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
		return FALSE;
	}
    return TRUE;
}/*********************** Final bfnDelInterFact ******************************/


/****************************************************************************/
/*                      funcion : bfnGetCodTipDocum                         */
/****************************************************************************/
/* - Funcion que Selecciona el Tipo de Documento de Facturacion a Emitir    */
/*   de acuerdo al Tipo de Movimiento, Tipo de Categoria Tributaria y       */
/*   Tipo de Categoria Impositiva                                           */
/*   Segun los Datos Carga dos en la Interfaz y Categoria Impositiva        */
/*   Afecto o Exento devolviendo el Tipo de Documento en la estructura      */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/
BOOL bfnGetCodTipDocum( INTERFACT *pstpInterFact, int ipTipImpositiva)
{
    char    szTipParametro  [32+1] ="";
    char    szValParametro [512+1] ="";
    int     iRes		   = 0;
    int     iParametro		   = 0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int     ihTipMovimien                ;
         int     ihOcurrencias                ;         
         char    szhCodCaTribut  [2]          ;/* EXEC SQL VAR szhCodCaTribut IS STRING(2); */ 

         int     ihTipImpositiva              ;
         int     ihCodModVenta                ;
         int     ihCodTipDocum                ;
         long    lhNumSecuenciRel             ; /* P-MIX-09003 */
         char    szhPrefPlazaRel        [25+1];/* EXEC SQL VAR szhPrefPlazaRel IS STRING(25+1); */ 
 /* P-MIX-09003 */         
         int     ihCodTipoDocRel              ; /* P-MIX-09003 */
         int     ihParamCodTipoDocRel         ; /* P-MIX-09003 */         
         char    szhFecDocRel            [8+1];/* EXEC SQL VAR szhFecDocRel    IS STRING(8+1); */ 
 /* P-MIX-09003 */
         int     ihCantidadMeses              ; /* P-MIX-09003 */
         int     ihParamCantidadMeses         ; /* P-MIX-09003 */
         int     ihParamCodTipDocum           ; /* P-MIX-09003 */         
         char    szhParamCodTipoDocRel [512+1];/* EXEC SQL VAR szhParamCodTipoDocRel IS STRING(512+1); */ 
 /* P-MIX-09003 */         
    /* EXEC SQL END DECLARE SECTION  ; */ 

    
/* P-MIX-09003 */

    memset(szhParamCodTipoDocRel,0,sizeof(szhParamCodTipoDocRel));

    /* El Documento a generar tiene Documento Relacionado */                      
    if (pstpInterFact->lNumFolioRel != 0)
    {
    	
        vDTrazasLog (szExeName, "\n\t\t** Num. Documento Rel [%ld] **"
                                "\n\t\t** Pref.Plaza Rel     [%s] **"
                              , LOG05
                              , pstpInterFact->lNumFolioRel
                              , pstpInterFact->szPrefPlazaRel);    	
    	
        memset(szhPrefPlazaRel,'\0',sizeof(szhPrefPlazaRel));
        memset(szhFecDocRel,'\0',sizeof(szhFecDocRel));
        
        lhNumSecuenciRel = pstpInterFact->lNumFolioRel;
        strcpy(szhPrefPlazaRel, pstpInterFact->szPrefPlazaRel);        

        /* Recupero Datos de Documento Relacionado */
        if ( !bfnGetDocumentoRel(lhNumSecuenciRel,szhPrefPlazaRel,&ihCodTipoDocRel,szhFecDocRel,&ihCantidadMeses) )
        {
    	     return FALSE;
        }        
        
        vDTrazasLog (szExeName, "\n\t\t** Documento Relacionado **"
                                "\n\t\t==========================="
                                "\n\t\t=> Num. Documento  [%ld]"
                                "\n\t\t=> Pref. Plaza Rel [%s]"                            
                                "\n\t\t=> Tipo Documento  [%d]"
                                "\n\t\t=> Fecha Documento [%s]"
                                "\n\t\t=> Cantidad Meses  [%d]"                            
                              , LOG05
                              , lhNumSecuenciRel , szhPrefPlazaRel
                              , ihCodTipoDocRel  , szhFecDocRel
                              , ihCantidadMeses );        
    }                                                    
    
/* P-MIX-09003 */

    /* Sigo procesando Documento a Generar */
    ihTipMovimien   = pstpInterFact->iCodTipMovimien   ;
    strcpy(szhCodCaTribut,pstpInterFact->szCodCaTribut);
    ihTipImpositiva = ipTipImpositiva                  ;
    ihCodModVenta   = pstpInterFact->iCodModVenta      ;

    vDTrazasLog (szExeName, "\n\t*** Parametros de Entrada (bfnGetCodTipDocum) ***"
                            "\n\t================================================="
                            "\n\t=> Num Proceso       [%ld]"
                            "\n\t=> Tipo Movimiento   [%d]"
                            "\n\t=> Cat. Tributaria   [%s]"
                            "\n\t=> Cat. Impositiva   [%d]"
                            "\n\t=> Cod. Mod. Venta   [%d]"
                            "\n\t=> SuperTelefono     [%d]"
                            "\n\t=> Facturable        [%d]"
                            "\n\t=> Total facturado   [%f]"
                          , LOG05
                          , pstpInterFact->lNumProceso
                          , ihTipMovimien
                          , szhCodCaTribut
                          , ihTipImpositiva
                          , ihCodModVenta
                          , stHistDocu.iIndSuperTel
                          , stHistDocu.iIndFactur
                          , stHistDocu.dTotFactura );
    
    if ((ihTipMovimien == stDatosGener.iCodCiclo) &&
        (((stHistDocu.dTotFactura >= -0.00001 && stHistDocu.dTotFactura <= 0.00001) && pstParamGener.sDocumentoCero == 'N')
        || !stHistDocu.iIndFactur  || stHistDocu.iIndSuperTel))
    {
        if (stHistDocu.dTotFactura >= -0.00001 && stHistDocu.dTotFactura <= 0.00001)
        {
            iParametro =16;
        }
        else if (!stHistDocu.iIndFactur)
        {
                  iParametro =14;
        }
        else if (stHistDocu.iIndSuperTel)
        {
                 iParametro =15;
        }

	iRes =ifnGetParametro (iParametro, szTipParametro, szValParametro );

	if (iRes != SQLNOTFOUND && iRes != SQLOK)
	{
	    vDTrazasError(szExeName, "Error en bfnGetCodTipDocum parametro %d [%ld] [%s]"
	                           , LOG01,iParametro,SQLCODE,szfnORAerror());
	    vDTrazasLog  (szExeName, "Error en bfnGetCodTipDocum parametro %d [%ld] [%s]"
	                           , LOG01,iParametro,SQLCODE,szfnORAerror());
	    return FALSE;
	}

        ihCodTipDocum= atoi (szValParametro);
        vDTrazasLog (szExeName, "\n\t\t* (bfnGetCodTipDocum) codigo de tipo doc : [%s]"
                              , LOG05
                              , szValParametro);
    }
    else
    {
        vDTrazasLog (szExeName, "\n\t** Aplicando query Tabla FA_TIPMOVIMIEN **"
                                "\n\t\t => Tipo Movimiento [%d]"
                                "\n\t\t => Cat. Tributaria [%s]"
                                "\n\t\t => Tipo Impositiva [%d]"
                                "\n\t\t => Mod. Venta      [%d]"                                                                                                
                              , LOG05
                              , ihTipMovimien
                              , szhCodCaTribut
                              , ihTipImpositiva
                              , ihCodModVenta);    	
        /* EXEC SQL
            SELECT  COD_TIPDOCUM
            INTO    :ihCodTipDocum
            FROM    FA_TIPMOVIMIEN
            WHERE   COD_TIPMOVIMIEN     = :ihTipMovimien
            AND     COD_CATRIBUT        = :szhCodCaTribut
            AND     COD_TIPIMPOSITIVA   = :ihTipImpositiva
            AND     COD_MODVENTA        = :ihCodModVenta    ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 24;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select COD_TIPDOCUM into :b0  from FA_TIPMOVIMIEN whe\
re (((COD_TIPMOVIMIEN=:b1 and COD_CATRIBUT=:b2) and COD_TIPIMPOSITIVA=:b3) and\
 COD_MODVENTA=:b4)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )249;
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
        sqlstm.sqhstv[1] = (unsigned char  *)&ihTipMovimien;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodCaTribut;
        sqlstm.sqhstl[2] = (unsigned long )2;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&ihTipImpositiva;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)&ihCodModVenta;
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



        if (SQLCODE != SQLOK)
        {
            vDTrazasError(szExeName,"Error en bfnGetCodTipDocum [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
            vDTrazasLog  (szExeName,"Error en bfnGetCodTipDocum [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
    	    return FALSE;
    	}
    }
    
/* P-MIX-09003 */

    /* El Documento a generar tiene Documento Relacionado */
    if (pstpInterFact->lNumFolioRel != 0)
    {
        vDTrazasLog  (szExeName, "\n\t** Es Nota de Credito..!! **",LOG05);    	         
                                           
        /* Recuperando Parámetro (678)COD_DOCUM_CCF */    
	iRes =ifnGetParam(sCOD_DOCUM_CCF, szTipParametro, szValParametro ); 

	if (iRes != SQLNOTFOUND && iRes != SQLOK)
	{
	    vDTrazasError(szExeName, "Error en bfnGetCodTipDocum(ifnGetParam) parametro %s [%ld] [%s]"
	                           , LOG01,sCOD_DOCUM_CCF,SQLCODE,szfnORAerror());
	    vDTrazasLog  (szExeName, "Error en bfnGetCodTipDocum()(ifnGetParam) parametro %s [%ld] [%s]"
	                           , LOG01,sCOD_DOCUM_CCF,SQLCODE,szfnORAerror());
	    return FALSE;
	}
	
        strcpy(szhParamCodTipoDocRel,szValParametro);
        
        vDTrazasLog (szExeName, "\n\t\t* (ifnGetParam) Código Doc. CCF : [%s]"
                              , LOG05
                              , szValParametro);
                              
/********************************************************************************************************/
        /* Si Tipo Documento relacionado esta en la GED_CODIGOS es candidato a generar Nota de Abono */
        iRes =ifnGetCodigosTipDocum(ihCodTipoDocRel);
        
	if (iRes == -99)
	{
	    vDTrazasError(szExeName, "Error en ifnGetCodigosTipDocum Tip. Docum. [%d] [%ld] [%s]"
	                           , LOG01,ihCodTipoDocRel,SQLCODE,szfnORAerror());
	    vDTrazasLog  (szExeName, "Error en ifnGetCodigosTipDocum Tip. Docum. [%d] [%ld] [%s]"
	                           , LOG01,ihCodTipoDocRel,SQLCODE,szfnORAerror());
	    return FALSE;
	}                                             
        else /* Si Doc. Rel esta entre los Tipos de Documentos que generan Nota de Abono */
        {   
            if (iRes != 0)           
            {            	            	            	            	            	            	
                vDTrazasLog (szExeName, "\n\t** Documento Rel existe en GED_CODIGOS - Posible Nota de Abono **", LOG05);                
                
                /* Recuperando Parámetro (676)DOCUMENTO NOTA DE ABONO */
                /* Codigo Nota de Abono será asignado en Cod. Tip. Docum. si corresponde */
                vDTrazasLog  (szExeName, "\n\t** Recuperando Parámetro Documento Nota de Abono",LOG05);
        
	        iRes =ifnGetParam(sCOD_DOCUM_NA, szTipParametro, szValParametro );

         	if ( iRes != SQLNOTFOUND && iRes != SQLOK )
	        {
	            vDTrazasError(szExeName, "Error en bfnGetCodTipDocum parametro(ifnGetParam) %s [%ld] [%s]"
	                           , LOG01,sCOD_DOCUM_NA,SQLCODE,szfnORAerror());
	            vDTrazasLog  (szExeName, "Error en bfnGetCodTipDocum parametro(ifnGetParam) %s [%ld] [%s]"
	                           , LOG01,sCOD_DOCUM_NA,SQLCODE,szfnORAerror());
	            return FALSE;
	        }

                ihParamCodTipDocum = atoi (szValParametro);
                vDTrazasLog (szExeName, "\n\t** (ifnGetParam) Codigo Doc. Nota de Abono  : [%s] **"
                                      , LOG05, szValParametro);                
                                                                
            	/* Verifico si es un Documento CCF */
                vDTrazasLog (szExeName, "\n\t** Verificando si es Documento CCF - Posible Nota de Abono **"
                                      , LOG05);            	            	 
            	if ( !bfnDocCCF(ihCodTipoDocRel,szhParamCodTipoDocRel,&ihOcurrencias) )
                {    
                    /* ERROR FALLO FUNCION */            	                	                	
 	            vDTrazasError(szExeName, "Error en bfnDocCCF Tip. Docum. [%d] [%ld] [%s]"
	                                   , LOG01,ihCodTipoDocRel,SQLCODE,szfnORAerror());
	            vDTrazasLog  (szExeName, "Error en bfnDocCCF Tip. Docum. [%d] [%ld] [%s]"
	                                   , LOG01,ihCodTipoDocRel,SQLCODE,szfnORAerror());
	            return FALSE;
	        }
	        else
	        {	        	
                    /* Evaluo si el Doc. Rel es un CCF */
                    if ( ihOcurrencias != 0 )
                    {
                         /* Es Documento CCF */
            	         /* Doc. Rel encontrado por lo tanto Cod. Tip. Doc. es Nota de Abono */            	
                         vDTrazasLog (szExeName, "\n\t** Doc. Relacionado existe - Posible Nota de Abono **"
                                          , LOG05);            	
                         /* Recuperando Parámetro (677)PERIODOS_NOTA_ABONO */
                         vDTrazasLog (szExeName, "\n\t** Recuperando parametro Periodos Nota de Abono - Posible Nota de Abono **"
                                                , LOG05);
	                 iRes =ifnGetParam( sPERIODOS_NOTA_ABONO, szTipParametro, szValParametro );

	                 if ( iRes != SQLNOTFOUND && iRes != SQLOK )
	                 {
	                      vDTrazasError(szExeName, "Error en bfnGetCodTipDocum(ifnGetParam) parametro %s [%ld] [%s]"
	                                   , LOG01,sPERIODOS_NOTA_ABONO,SQLCODE,szfnORAerror());
	                      vDTrazasLog  (szExeName, "Error en bfnGetCodTipDocum(ifnGetParam) parametro %s [%ld] [%s]"
	                                   , LOG01,sPERIODOS_NOTA_ABONO,SQLCODE,szfnORAerror());
	                      return FALSE;
	                 }                    
	            
                         ihParamCantidadMeses = atoi (szValParametro);
                         vDTrazasLog (szExeName, "\n\t** Periodos Nota Abono : [%s] **"
                                          , LOG05, szValParametro);
                         if ( ihCantidadMeses != 99 )
                         {
    	                      if ( ihCantidadMeses >  ihParamCantidadMeses )
    	                      {
    	             	           /* Cantidad meses transcurridos es mayor que el parametro */
    	             	           /* Genera Nota de Abono */
    	                           ihCodTipDocum =  ihParamCodTipDocum;
                                   vDTrazasLog (szExeName, "\n\t** Cantidad meses > Cantidad meses Parametro - Genera Nota de Abono **"
                                                    , LOG05);    	                  
    	                      }
    	                      else    	            
    	                      {
                                   /* Cantidad meses transcurridos es menor que el parametro */
    	             	           /* Genera Nota de Credito */    	             	
                                   vDTrazasLog (szExeName, "\n\t** Cantidad meses < Cantidad meses Parametro - Genera Nota de Credito **"
                                                    , LOG05);
    	                      }
                         }
                         else
                         {
                              vDTrazasLog (szExeName, "\n\t** No se encontro Documento Rel. en FA_HISTDOCU **", LOG05);                	
                         }                                       	                        	
                    }
                    else
                    {
                         /* No es Documento CCF Genero Nota de Abono siempre */
                         vDTrazasLog (szExeName, "\n\t** No es Documento CCF Genero Nota de Abono siempre **", LOG05);                    
    	                 ihCodTipDocum =  ihParamCodTipDocum;                    
                    }                                               	        		        
	        }                                                            
            }                            	                       
        }                   
    }
    
/* P-MIX-09003*/    
 
    pstpInterFact->iCodTipDocum = ihCodTipDocum;
    
    vDTrazasLog (szExeName, "\n\t=> (bfnGetCodTipDocum) Cod. Tip. Docum   [%d]",LOG03,ihCodTipDocum);

    return TRUE;
}/*********************** Final bfnGetCodTipDocum ***************************/

BOOL bfnDocCCF( int  iCodTipoDocRel, 
                char *szParamCodTipoDocRel,
                int  *iOcurrencias)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int   ihCodTipoDocRel;
         int   ihOcurrencias;         
         char  szhParamCodTipoDocRel [512+1]; /* EXEC SQL VAR szhParamCodTipoDocRel IS STRING(512+1); */ 
         
    /* EXEC SQL END DECLARE SECTION; */ 

    
    vDTrazasLog (szExeName, "\n\t\t** Entrada en %s **"
                            "\n\t\t==========================="
                            "\n\t\t=> Doc. Rel         [%d]"
                            "\n\t\t=> Param. Doc. Rel. [%s]"                            
                          , LOG05, "bfnDocCCF"
                          , iCodTipoDocRel , szParamCodTipoDocRel);
    
    memset(szhParamCodTipoDocRel,0,sizeof(szhParamCodTipoDocRel));
    
    ihCodTipoDocRel = iCodTipoDocRel;
    
    strcpy(szhParamCodTipoDocRel,szParamCodTipoDocRel);    
    
    /* EXEC SQL
         SELECT nvl(INSTR(:szhParamCodTipoDocRel, TO_CHAR(:ihCodTipoDocRel), 1, 1 ),0)
         INTO   :ihOcurrencias
         FROM   DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select nvl(INSTR(:b0,TO_CHAR(:b1),1,1),0) into :b2  from \
DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )284;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhParamCodTipoDocRel;
    sqlstm.sqhstl[0] = (unsigned long )513;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoDocRel;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihOcurrencias;
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


         
    vDTrazasLog (szExeName, "n\t => Ocurrencias [%d]",LOG05,ihOcurrencias);         
         
    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)     
    {
        vDTrazasError(szExeName,"\n\t** Error en función bfnDocCCF [%ld] [%s] **",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"\n\t** Error en función bfnDocCCF [%ld] [%s] **",LOG01,SQLCODE,szfnORAerror());   
        *iOcurrencias = -99;
        return FALSE; 	
    }
    else
    {
    	if (SQLCODE != SQLNOTFOUND)
    	{
    	    *iOcurrencias = ihOcurrencias;    	    
    	}
    	else
    	{
    	    *iOcurrencias = 0;
    	}
    }                         
    
    return TRUE;
}
/******************************* Fin bfnDocCCF ******************************/

BOOL bfnGetDocumentoRel( long lNumSecuenciRel, 
                         char *szPrefPlazaRel,
                         int  *iCodTipoDocRel, 
                         char *szFecDocRel, 
                         int  *iCantidadMeses)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumSecuenciRel      ;
         char    szhPrefPlazaRel [25+1]; /* EXEC SQL VAR szhPrefPlazaRel IS STRING(25+1); */ 
         
         int     ihCodTipoDocRel       ;
         char    szhFecDocRel     [8+1]; /* EXEC SQL VAR szhFecDocRel    IS STRING(8+1); */ 
 
         int     ihCantidadMeses       ;
    /* EXEC SQL END DECLARE SECTION; */ 
	
    
    memset(szhPrefPlazaRel,'\0',sizeof(szhPrefPlazaRel));
    memset(szhFecDocRel,'\0',sizeof(szhFecDocRel));        
    
    lhNumSecuenciRel = lNumSecuenciRel;
    strcpy(szhPrefPlazaRel, szPrefPlazaRel);

    vDTrazasLog (szExeName, "\n\t* Parametro de Entrada (bfnGetDocumentoRel) *"
                            "\n\t\t=> Num. Documento  [%ld]"
                            "\n\t\t=> Pref. Plaza Rel [%s]"                            
                          ,LOG04
                          ,lhNumSecuenciRel
                          ,szhPrefPlazaRel);
                            
    /* EXEC SQL DECLARE  Cur_Histdocu_NoCiclo  CURSOR for
         SELECT COD_TIPDOCUM, TO_CHAR(TRUNC(FEC_EMISION),'YYYYMMDD'),
                MONTHS_BETWEEN( TRUNC(SYSDATE,'MONTH'), TRUNC(FEC_EMISION,'MONTH') ) + 1
          FROM  FA_HISTDOCU
          WHERE NUM_FOLIO  = :lhNumSecuenciRel
          AND   PREF_PLAZA = :szhPrefPlazaRel
         UNION
         SELECT COD_TIPDOCUM, TO_CHAR(TRUNC(FEC_EMISION),'YYYYMMDD'),
                MONTHS_BETWEEN( TRUNC(SYSDATE,'MONTH'), TRUNC(FEC_EMISION,'MONTH') ) + 1
          FROM  FA_FACTDOCU_NOCICLO
          WHERE NUM_FOLIO  = :lhNumSecuenciRel
          AND   PREF_PLAZA = :szhPrefPlazaRel; */ 
 
          
    if ( SQLCODE != SQLOK )
    {
         vDTrazasLog  ("bfnGetDocumentoRel" , "\n\t** En SQL-DECLARE Cur_Histdocu_NoCiclo **"
                                              "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
         vDTrazasError("bfnGetDocumentoRel" , "\n\t\t**  En SQL-DECLARE Cur_Histdocu_NoCiclo **"
                                              "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
         return FALSE;
    }
    
    /* EXEC SQL OPEN Cur_Histdocu_NoCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0007;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )311;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumSecuenciRel;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlazaRel;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumSecuenciRel;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhPrefPlazaRel;
    sqlstm.sqhstl[3] = (unsigned long )26;
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

 
    
    vDTrazasLog ("bfnGetDocumentoRel", "\n\t\tOPEN Cur_Histdocu_NoCiclo sqlca.sqlcode: [%d]",LOG05,sqlca.sqlcode);
    if ( SQLCODE != SQLOK )
    {
         vDTrazasLog  ("bfnGetDocumentoRel", "\n\t**  En SQL-OPEN CURSOR Cur_Interfaz2 **"
                                             "\n\t\t=> Detalle : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
         vDTrazasError("bfnGetDocumentoRel", "\n\t**  En SQL-OPEN CURSOR Cur_Interfaz2 **"
                                             "\n\t\t=> Detale : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
         return FALSE;
    }
    
    /* EXEC SQL FETCH Cur_Histdocu_NoCiclo
             INTO  :ihCodTipoDocRel,
		   :szhFecDocRel,
		   :ihCantidadMeses; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )342;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipoDocRel;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecDocRel;
    sqlstm.sqhstl[1] = (unsigned long )9;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCantidadMeses;
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


		   
    vDTrazasLog ("bfnGetDocumentoRel","\n\t\tFETCH Cur_Histdocu_NoCiclo sqlca.sqlcode: [%d]",LOG05,sqlca.sqlcode);
    
    vDTrazasLog  ("bfnGetDocumentoRel","\n\t\tEn FETCH CURSOR Cur_Histdocu_NoCiclo"
                         "\n\t\t=> Numero de registros rescatados: [%d]",LOG05,sqlca.sqlerrd[2]);
    
    vDTrazasLog ("bfnGetDocumentoRel", "\n\t\t* Resultado de FETCH: *"
                                       "\n\t\t***********************"
    			               "\n\t\tTipo Doc. Rel. => [%d]"
    			               "\n\t\tFecha Doc. Rel.=> [%s]"
    			               "\n\t\tCantidad Meses => [%d]"
    			             , LOG05
    			             , ihCodTipoDocRel   
    			             , szhFecDocRel 
    			             , ihCantidadMeses); 	   
         
    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)     
    {
        vDTrazasError(szExeName,"Error en bfnGetDocumentoRel [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnGetDocumentoRel [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());   
        return FALSE; 	
    }     
    
    if (SQLCODE == SQLNOTFOUND)
    {
    	vDTrazasLog  (szExeName, "\n\t** No se encontro documento [], aplica Cantidad Meses default [99]**"
    	                       , LOG03
    	                       , lhNumSecuenciRel);
        ihCantidadMeses = 99;
           
    }
    else
    {
        *iCodTipoDocRel = ihCodTipoDocRel;
        strcpy(szFecDocRel,szhFecDocRel);    	
    }
    
    *iCantidadMeses = ihCantidadMeses;
    
    /* EXEC SQL CLOSE Cur_Histdocu_NoCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )369;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    
    return TRUE;
}

/****************************************************************************/
/*                      funcion : bfnGetInterProc                           */
/****************************************************************************/
/* - Funcion que recupera un registro de la tabla FA_INTPROCESOS por        */
/*   Codigo de Proceso                                                      */
/*   Error->FALSE, !Error->TRUE                                             */
/****************************************************************************/

BOOL bfnGetInterProc( INTPROCESOS *stpIntProcesos)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodProceso        ;
    char    szhCodAplic     [4]	;/* EXEC SQL VAR szhCodAplic     	IS STRING(4); */ 

    char    szhDesProceso   [31];/* EXEC SQL VAR szhDesProceso     IS STRING(31); */ 

    int     ihCodPrioridad      ;
    char    szhNomEjecutable[31];/* EXEC SQL VAR szhNomEjecutable  IS STRING(31); */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 


    vDTrazasLog (szExeName, "\n\t\t\t* Parametro de Entrada (bfnGetInterProc)"
                            "\n\t\t\t=> Cod. Proceso  [%ld]"
                            "\n\t\t\t=> Cod. Aplic.   [%s]"
                            ,LOG04
                            ,stpIntProcesos->lCodProceso
                            ,stpIntProcesos->szCodAplic);


    lhCodProceso    =   stpIntProcesos->lCodProceso;
    strcpy(szhCodAplic,stpIntProcesos->szCodAplic); 


    /* EXEC SQL
        SELECT  DES_PROCESO         ,
                COD_PRIORIDAD       ,
                EXE_COMANDO
        INTO    :szhDesProceso      ,
                :ihCodPrioridad     ,
                :szhNomEjecutable
        FROM    FA_INTPROCESOS
        WHERE   COD_PROCESO  = :lhCodProceso
        AND	COD_APLIC    = :szhCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select DES_PROCESO ,COD_PRIORIDAD ,EXE_COMANDO into :b0,:\
b1,:b2  from FA_INTPROCESOS where (COD_PROCESO=:b3 and COD_APLIC=:b4)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )384;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPrioridad;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhNomEjecutable;
    sqlstm.sqhstl[2] = (unsigned long )31;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodProceso;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodAplic;
    sqlstm.sqhstl[4] = (unsigned long )4;
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



    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en bfnGetInterProc [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnGetInterProc [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
    }
    if (SQLCODE == SQLOK)
    {
        strcpy(stpIntProcesos->szDesProceso,szhDesProceso)     ;
        stpIntProcesos->iPrioridad      = ihCodPrioridad        ;
        strcpy(stpIntProcesos->szNomEjecutable,szhNomEjecutable);
    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/*********************** Final bfnGetInterProc ******************************/


/****************************************************************************/
/*                      funcion : bfnGetIntQueueProc                        */
/****************************************************************************/
/* - Funcion que recupera un registro de la tabla FA_INTQUEUEPROC por       */
/*   Cod.Mod. Gener y Codigo de Proceso                                     */
/*   Error->FALSE, !Error->TRUE                                             */
/* - Modif.RAO.22032001.Se anexan campos: Cod_TipUnInter, Cod_EstaDoc_Ent,  */
/*   Cod_EstaDoc_Sal							    */
/****************************************************************************/

BOOL bfnGetIntQueueProc(INTQUEUEPROC *stpIntQueueProc)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhCodModGener  [4] ;/* EXEC SQL VAR szhCodModGener    IS STRING(4); */ 

    long    lhCodProceso	;
    char    szhCodAplic	    [4] ;/* EXEC SQL VAR szhCodAplic    	IS STRING(4); */ 
 /* Incorporado por PGonzaleg 23-01-2002 */
    char    szhCodTipProc   [2] ;/* EXEC SQL VAR szhCodTipProc     IS STRING(2); */ 

    char    szhCodActivacion[2] ;/* EXEC SQL VAR szhCodTipProc     IS STRING(2); */ 

    int     ihCodPrioridad      ;
    int     ihCodEstado         ;
    char    szhFecEstado    [20];/* EXEC SQL VAR szhFecEstado      IS STRING(20); */ 

    long    lhPidProceso        ;
    char    szhNomUsuario   [31];/* EXEC SQL VAR szhNomUsuario     IS STRING(31); */ 

    char    szhPasUsuario   [31];/* EXEC SQL VAR szhPasUsuario     IS STRING(31); */ 

    int     ihCodNivelLog       ;
    int     ihTipIntervalo      ;
    long    lhNumSegundos       ;
    char    szhCodHoraDia   [8] ;/* EXEC SQL VAR szhCodHoraDia     IS STRING(8); */ 

    char    szhCodHoraFecha [20];/* EXEC SQL VAR szhCodHoraFecha   IS STRING(20); */ 

    char    szhCodHoraIniVig[8] ;/* EXEC SQL VAR szhCodHoraIniVig  IS STRING(8); */ 

    char    szhCodHoraFinVig[8] ;/* EXEC SQL VAR szhCodHoraFinVig  IS STRING(8); */ 

    int     ihCodTipUnInter     ;
    int     ihCodEstaDocEnt     ;
    int     ihCodEstaDocSal     ;
    int     ihNumDeltaHoras     ;
    short   s_lhPidProceso      ;
    short   s_szhNomUsuario     ;
    short   s_szhPasUsuario     ;
    short   s_ihCodNivelLog     ;
    short   s_lhNumSegundos     ;
    short   s_szhCodHoraDia     ;
    short   s_szhCodHoraFecha   ;
    short   s_szhCodHoraIniVig  ;
    short   s_szhCodHoraFinVig  ;
    short   s_ihCodTipUnInter   ;
    short   s_ihNumDeltaHoras   ;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    vDTrazasLog (szExeName, "\n\t\t\t* Parametro de Entrada (bfnGetIntQueueProc)"
                            "\n\t\t\t=> Cod. Mod. Gener     [%s]"
                            "\n\t\t\t=> Cod. Proceso        [%d]"
                            "\n\t\t\t=> Cod. Aplicacion     [%s]"
                            ,LOG04
                            ,stpIntQueueProc->szCodModGener
                            ,stpIntQueueProc->lCodProceso
                            ,stpIntQueueProc->szCodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

    /* 20040620 TM-200406200758 Se cambia forma de copiar */
    strcpy(szhCodModGener  ,stpIntQueueProc->szCodModGener );
    lhCodProceso            =       stpIntQueueProc->lCodProceso    ;
    strcpy(szhCodTipProc   ,stpIntQueueProc->szCodTipProc  );                                             
    strcpy(szhCodAplic     ,stpIntQueueProc->szCodAplic    ); /* Incorporado por PGonzaleg 23-01-2002 */  


    /* EXEC SQL
        SELECT  COD_ACTIVACION                          ,
                COD_PRIORIDAD                           ,
                COD_ESTADO                              ,
                TO_CHAR(FEC_ESTADO,'YYYYMMDDHH24MISS')  ,
                PID_PROCESO                             ,
                NOM_USUARIO                             ,
                PAS_USUARIO                             ,
                COD_NIVLOG                              ,
                COD_TIPINTERVALO                        ,
                NUM_SEGUNDOS                            ,
                COD_HORADIA                             ,
                TO_CHAR(COD_HORAFECH,'YYYYMMDDHH24MISS'),
                COD_HORAVIGINI                          ,
                COD_HORAVIGFIN                          ,
                COD_TIPUNINTER                          ,
                COD_ESTADOC_ENT                         ,
                COD_ESTADOC_SAL                         ,
                NUM_DELTAHORAS                          ,
                COD_TIPPROC
        INTO    :szhCodActivacion                       ,
                :ihCodPrioridad                         ,
                :ihCodEstado                            ,
                :szhFecEstado                           ,
                :lhPidProceso       :s_lhPidProceso     ,
                :szhNomUsuario      :s_szhNomUsuario    ,
                :szhPasUsuario      :s_szhPasUsuario    ,
                :ihCodNivelLog      :s_ihCodNivelLog    ,
                :ihTipIntervalo                         ,
                :lhNumSegundos      :s_lhNumSegundos    ,
                :szhCodHoraDia      :s_szhCodHoraDia    ,
                :szhCodHoraFecha    :s_szhCodHoraFecha  ,
                :szhCodHoraIniVig   :s_szhCodHoraIniVig ,
                :szhCodHoraFinVig   :s_szhCodHoraFinVig ,
                :ihCodTipUnInter    :s_ihCodTipUnInter  ,
                :ihCodEstaDocEnt                        ,
                :ihCodEstaDocSal			,
                :ihNumDeltaHoras    :s_ihNumDeltaHoras  ,
                :szhCodTipProc
        FROM    FA_INTQUEUEPROC
        WHERE   COD_MODGENER    = :szhCodModGener
        AND     COD_PROCESO     = :lhCodProceso
        AND 	COD_APLIC 	= :szhCodAplic; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_ACTIVACION ,COD_PRIORIDAD ,COD_ESTADO ,TO_CHAR\
(FEC_ESTADO,'YYYYMMDDHH24MISS') ,PID_PROCESO ,NOM_USUARIO ,PAS_USUARIO ,COD_NI\
VLOG ,COD_TIPINTERVALO ,NUM_SEGUNDOS ,COD_HORADIA ,TO_CHAR(COD_HORAFECH,'YYYYM\
MDDHH24MISS') ,COD_HORAVIGINI ,COD_HORAVIGFIN ,COD_TIPUNINTER ,COD_ESTADOC_ENT\
 ,COD_ESTADOC_SAL ,NUM_DELTAHORAS ,COD_TIPPROC into :b0,:b1,:b2,:b3,:b4:b5,:b6\
:b7,:b8:b9,:b10:b11,:b12,:b13:b14,:b15:b16,:b17:b18,:b19:b20,:b21:b22,:b23:b24\
,:b25,:b26,:b27:b28,:b29  from FA_INTQUEUEPROC where ((COD_MODGENER=:b30 and C\
OD_PROCESO=:b31) and COD_APLIC=:b32)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )419;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodActivacion;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodPrioridad;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodEstado;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecEstado;
    sqlstm.sqhstl[3] = (unsigned long )20;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhPidProceso;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&s_lhPidProceso;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhNomUsuario;
    sqlstm.sqhstl[5] = (unsigned long )31;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&s_szhNomUsuario;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhPasUsuario;
    sqlstm.sqhstl[6] = (unsigned long )31;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&s_szhPasUsuario;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodNivelLog;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&s_ihCodNivelLog;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&ihTipIntervalo;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&lhNumSegundos;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)&s_lhNumSegundos;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhCodHoraDia;
    sqlstm.sqhstl[10] = (unsigned long )8;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)&s_szhCodHoraDia;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhCodHoraFecha;
    sqlstm.sqhstl[11] = (unsigned long )20;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)&s_szhCodHoraFecha;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhCodHoraIniVig;
    sqlstm.sqhstl[12] = (unsigned long )8;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)&s_szhCodHoraIniVig;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhCodHoraFinVig;
    sqlstm.sqhstl[13] = (unsigned long )8;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)&s_szhCodHoraFinVig;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&ihCodTipUnInter;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)&s_ihCodTipUnInter;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)&ihCodEstaDocEnt;
    sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)&ihCodEstaDocSal;
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&ihNumDeltaHoras;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)&s_ihNumDeltaHoras;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szhCodTipProc;
    sqlstm.sqhstl[18] = (unsigned long )2;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szhCodModGener;
    sqlstm.sqhstl[19] = (unsigned long )4;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)&lhCodProceso;
    sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)szhCodAplic;
    sqlstm.sqhstl[21] = (unsigned long )4;
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
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

 /* Incorporado por PGonzaleg 23-01-2002 */

    if (SQLCODE != SQLOK)
    {
        vDTrazasError(szExeName,"Error en bfnGetIntQueueProc [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"Error en bfnGetIntQueueProc [%ld] [%s]",LOG01,SQLCODE,szfnORAerror());
    }
    if (SQLCODE == SQLOK)
    {
            /* 20040620 TM-200406200758 Se cambia forma de copiar */
            strcpy(stpIntQueueProc->szCodActivacion,szhCodActivacion);
                    stpIntQueueProc->iCodPrioridad      =   ihCodPrioridad  ;
                    stpIntQueueProc->iCodEstado         =   ihCodEstado     ;
            strcpy(stpIntQueueProc->szFecEstado    ,szhFecEstado   );
                    stpIntQueueProc->lPidProceso        =   s_lhPidProceso  == ORA_NULL ? 0:lhPidProceso;

        if (s_szhNomUsuario  == ORA_NULL )
            strcpy(stpIntQueueProc->szNomUsuario   ,"\0"                  );
        else
	    strcpy(stpIntQueueProc->szNomUsuario   ,szhNomUsuario  );            

        if (s_szhPasUsuario  == ORA_NULL )
            strcpy(stpIntQueueProc->szPasUsuario   ,"\0"                  );
        else
            strcpy(stpIntQueueProc->szPasUsuario   ,szhPasUsuario  );

                    stpIntQueueProc->iCodNivelLog       =   s_ihCodNivelLog == ORA_NULL ? 3:ihCodNivelLog;
                    stpIntQueueProc->iTipIntervalo      =   ihTipIntervalo  ;
                    stpIntQueueProc->lNumSegundos       =   s_lhNumSegundos == ORA_NULL ?-1:lhNumSegundos;

        if (s_szhCodHoraDia  == ORA_NULL )
            strcpy(stpIntQueueProc->szCodHoraDia   ,"\0"                  );
        else
            strcpy(stpIntQueueProc->szCodHoraDia   ,szhCodHoraDia  );

        if (s_szhCodHoraFecha== ORA_NULL )
            strcpy(stpIntQueueProc->szCodHoraFecha ,"\0"                  );
        else
            strcpy(stpIntQueueProc->szCodHoraFecha ,szhCodHoraFecha);

        if (s_szhCodHoraIniVig==ORA_NULL )
            strcpy(stpIntQueueProc->szCodHoraIniVig,"\0"                   );
        else
            strcpy(stpIntQueueProc->szCodHoraIniVig,szhCodHoraIniVig);

        if (s_szhCodHoraFinVig==ORA_NULL )
            strcpy(stpIntQueueProc->szCodHoraFinVig,"\0"                   );
        else
            strcpy(stpIntQueueProc->szCodHoraFinVig,szhCodHoraFinVig);

                    stpIntQueueProc->iCodTipUnInter     =   s_ihCodTipUnInter == ORA_NULL ? 0:ihCodTipUnInter;
                    stpIntQueueProc->iCodEstaDocEnt     =   ihCodEstaDocEnt ;
                    stpIntQueueProc->iCodEstaDocSal     =   ihCodEstaDocSal ;
                    stpIntQueueProc->iNumDeltaHoras     =   ihNumDeltaHoras ;
                    strcpy(stpIntQueueProc->szCodTipProc,szhCodTipProc)    ;
    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/*********************** Final bfnGetIntQueueProc ***************************/


/* --------------------------------------------------------------------------*/
/*   bChangeIndEstadoPro (long,int,int)                                      */
/*      Cambia el estado del proceso de iFrom a iTo                          */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* --------------------------------------------------------------------------*/
BOOL bChangeCodEstaProcInterfaz(long lNumProceso,int iTo)
{
    BOOL bOK = TRUE;

    stInterFact.iCodEstaProc    = iTo;
    bfnSelectSysDate (&stInterFact.szFecFacturacion[0]);
    strcpy(stInterFact.szCodAplic,"FAC");  /* Incorporado por PGonzaleg 23-01-2002 */

    if (!bfnUpdInterFact(stInterFact))
    {
        iDError (szExeName,ERR000,vInsertarIncidencia,"(bChangeCodEstaProcInterfaz) Update->Fa_InterFact",szfnORAerror());
        bOK = FALSE;
    }
    return (bOK);
}/*----------------------- Final bChangeCodEstaProcInterfaz -------------------------*/


void vfnPrintQueueProc (INTQUEUEPROC stpIntQueueProc)
{
    vDTrazasLog (szExeName,"\n\t** Datos de Cola de Proceso **"
                "\n\t\t==> Cod. Mod. Generacion   [%s]"
                "\n\t\t==> Cod. Aplicacion        [%s]" /* Incorporado por PGonzaleg 23-01-2002 */
                "\n\t\t==> Codigo de Proceso      [%d]"
                "\n\t\t==> Tipo de Proceso        [%s]"
                "\n\t\t==> Codigo de Activacion   [%s]"
                "\n\t\t==> Prioridad de Proceso   [%d]"
                "\n\t\t==> Codigo de Estado       [%d]"
                "\n\t\t==> Fecha de Estado        [%s]"
                "\n\t\t==> PID del Proceso        [%ld]"
                "\n\t\t==> Nombre de Usuario      [%s]"
                "\n\t\t==> Password de Usuario    [%s]"
                "\n\t\t==> Nivel de Log           [%d]"
                "\n\t\t==> Tipo de Intervalo      [%d]"
                "\n\t\t==> Numero de Segundos     [%ld]"
                "\n\t\t==> Hora de Ejecion        [%s]"
                "\n\t\t==> Fecha de Ejecucion     [%s]"
                "\n\t\t==> Hora Inicio Vigencia   [%s]"
                "\n\t\t==> Hora Termino Vigencia  [%s]"
                "\n\t\t==> Cod. Tipo de Intervalo [%d]"
                "\n\t\t==> Cod. Estado Doc. Ent.  [%d]"
                "\n\t\t==> Cod. Estado Doc. Sal.  [%d]"
                ,LOG05
                ,stpIntQueueProc.szCodModGener
                ,stpIntQueueProc.szCodAplic	    ,stpIntQueueProc.lCodProceso /* Incorporado por PGonzaleg 23-01-2002 */
                ,stpIntQueueProc.szCodTipProc   ,stpIntQueueProc.szCodActivacion
                ,stpIntQueueProc.iCodPrioridad  ,stpIntQueueProc.iCodEstado
                ,stpIntQueueProc.szFecEstado    ,stpIntQueueProc.lPidProceso
                ,stpIntQueueProc.szNomUsuario   ,stpIntQueueProc.szPasUsuario
                ,stpIntQueueProc.iCodNivelLog   ,stpIntQueueProc.iTipIntervalo
                ,stpIntQueueProc.lNumSegundos   ,stpIntQueueProc.szCodHoraDia
                ,stpIntQueueProc.szCodHoraFecha ,stpIntQueueProc.szCodHoraIniVig
                ,stpIntQueueProc.szCodHoraFinVig,stpIntQueueProc.iCodTipUnInter
                ,stpIntQueueProc.iCodEstaDocEnt ,stpIntQueueProc.iCodEstaDocSal);
}


void vfnPrintInterFact  (INTERFACT stpIntFact)
{
    vDTrazasLog (szExeName,"\n\t** Datos de Interfaz **"
                "\n\t\t==> Num. Proceso           [%ld]"
                "\n\t\t==> Cod. Aplicacion        [%s]"  /* Incorporado por PGonzaleg 23-01-2002 */
                "\n\t\t==> Num. Venta             [%ld]"
                "\n\t\t==> Cod.Mod. Generacion    [%s]"
                "\n\t\t==> Estado Documento       [%d]"
                "\n\t\t==> Estado de Proceso      [%d]"
                "\n\t\t==> Tipo de Movimiento     [%d]"
                "\n\t\t==> Categoria Tributaria   [%s]"
                "\n\t\t==> Categoria Impositiva   [%d]"
                "\n\t\t==> Tipo Documento         [%d]"
                "\n\t\t==> Folio                  [%ld]"
                "\n\t\t==> Folio Relacionado      [%ld]"
                "\n\t\t==> Fecha Ingreso          [%s]"
                "\n\t\t==> Fecha Facturacion      [%s]"
                "\n\t\t==> Fecha Impresion        [%s]"
                "\n\t\t==> Fecha Foliacion        [%s]"
                "\n\t\t==> Fecha Visacion         [%s]"
                "\n\t\t==> Fecha Paso Cobros      [%s]"
                "\n\t\t==> Fecha Cierre           [%s]"
                "\n\t\t==> Fecha Vencimiento      [%s]"
                "\n\t\t==> Prefijo Plaza          [%s]"
                "\n\t\t==> Prefijo Plaza Rel.     [%s]"
                ,LOG05,stpIntFact.lNumProceso
                ,stpIntFact.szCodAplic      ,stpIntFact.lNumVenta
                ,stpIntFact.szCodModGener   ,stpIntFact.iCodEstaDoc
                ,stpIntFact.iCodEstaProc    ,stpIntFact.iCodTipMovimien
                ,stpIntFact.szCodCaTribut   ,stpIntFact.iTipImpositiva
                ,stpIntFact.iCodTipDocum    ,stpIntFact.lNumFolio
                ,stpIntFact.lNumFolioRel    ,stpIntFact.szFecIngreso
                ,stpIntFact.szFecFacturacion,stpIntFact.szFecImpresion
                ,stpIntFact.szFecFoliacion  ,stpIntFact.szFecVisacion
                ,stpIntFact.szFecPasoCobro  ,stpIntFact.szFecCierre
                ,stpIntFact.szFecVencimiento,stpIntFact.szPrefPlaza
                ,stpIntFact.szPrefPlazaRel);

}


/* ************************************************************************** */
/*  bfnCambiaEstCola : Cambia el estado de la cola de proceso                 */
/* ************************************************************************** */
BOOL bfnCambiaEstCola(char *MGener, int CProc, int iDesde, int iHasta, char *CodAplic )
/* 	Incorporacion de nuevo  parametro de entrada	*/
/* 	- char CodAplic - por PGonzaleg 23-01-2002      */
{
	char modulo[]="bfnCambiaEstCola";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhModGen  [4] ;
		char szhCodAplic[4] ; /* Incorporado por PGonzaleg 23-01-2002 */
		int  ihCodPro       ;
		int  ihEstIni       ;
		int  ihEstFin       ;
	   	long lhPidProc      ;
	/* EXEC SQL END DECLARE SECTION; */ 


	strcpy( szhModGen, MGener);
	strcpy( szhCodAplic, CodAplic); /* Incorporado por PGonzaleg 23-01-2002 */
	ihCodPro = CProc;
	ihEstIni = iDesde;
	ihEstFin = iHasta;
	lhPidProc= getpid();

	vDTrazasLog(modulo,"%s[%ld] Cambia estado cola '%s_%d'  [ %d -> %d ]  Cod. Aplic [%s] ",
					LOG04
					,cfnGetTime(3)
					,lhPidProc
					,MGener
					,CProc
					,iDesde
					,iHasta
					,CodAplic); /* Incorporado por PGonzaleg 23-01-2002 */

	/* EXEC SQL UPDATE FA_INTQUEUEPROC
				SET COD_ESTADO  = :ihEstFin,
					FEC_ESTADO  = SYSDATE,
					PID_PROCESO = :lhPidProc
				WHERE COD_MODGENER= :szhModGen
			    	AND COD_PROCESO = :ihCodPro
			   	AND COD_ESTADO  = :ihEstIni
			   	AND COD_APLIC   = :szhCodAplic; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_INTQUEUEPROC  set COD_ESTADO=:b0,FEC_ESTADO=SYSDAT\
E,PID_PROCESO=:b1 where (((COD_MODGENER=:b2 and COD_PROCESO=:b3) and COD_ESTAD\
O=:b4) and COD_APLIC=:b5)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )522;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihEstFin;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhPidProc;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhModGen;
 sqlstm.sqhstl[2] = (unsigned long )4;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&ihCodPro;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&ihEstIni;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhCodAplic;
 sqlstm.sqhstl[5] = (unsigned long )4;
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

 /* Incorporado por PGonzaleg 23-01-2002 */

	if (sqlca.sqlcode)
	{
	    vDTrazasError(modulo,"%s al intentar cambiar estado cola ]\n\t%s\n",
						LOG01, cfnGetTime(3), sqlca.sqlerrm.sqlerrmc);
		return FALSE;
	}

	return TRUE;

}


/* ************************************************************************** */
/* ffnGetDifUltEjec : Retorna la diferencia entre la fecha actual y la ultima */
/*                    ejecucion de la cola				      */
/* ************************************************************************** */

BOOL bfnGetDifUltEjec (char *szUltimaVez , double *pDiff)
{
    char modulo[]="ffnGetDifUltEjec";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		char    szhUltimaVez[15]; /* EXEC SQL VAR szhUltimaVez       IS STRING(15); */ 

		double  dhDif           ;
	/* EXEC SQL END DECLARE SECTION; */ 


    dhDif = 0;
    strcpy(szhUltimaVez, szUltimaVez);
    vDTrazasLog(modulo,"%s dfnGetDifUltEjec (%s)",LOG05, cfnGetTime(3),szUltimaVez);

	/* EXEC SQL
	    SELECT (SYSDATE - TO_DATE(:szhUltimaVez,'yyyymmddhh24miss'))
		        INTO :dhDif
				FROM DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select (SYSDATE-TO_DATE(:b0,'yyyymmddhh24miss')) into :b1  f\
rom DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )561;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhUltimaVez;
 sqlstm.sqhstl[0] = (unsigned long )15;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhDif;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
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


    vDTrazasLog(modulo,"%s dfnGetDifUltEjec (%f)",LOG05, cfnGetTime(3),dhDif);
    *pDiff= dhDif;
    return (TRUE);

}

/* ************************************************************************** */
/* fnGrabaAnomalia : Registra errores en la ejecucion de procesos de la       */
/*                   Interfaz.						      */
/* ************************************************************************** */
void fnGrabaAnomalia (long lNumProceso, long lCod_Cliente, char *szDescrip, char *szObsAnomalia)
{
    char modulo[]   ="fnGrabaAnomalia";
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long    lhNumProceso    ;
         long    lhNumProc2      ;
         long    lhCod_Cliente   ;
	 char    szhDescrip      [41]; /* EXEC SQL VAR szhDescrip       IS STRING(41); */ 

	 char    szhObsAnomalia  [61]; /* EXEC SQL VAR szhObsAnomalia   IS STRING(61); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    lhNumProceso    =lNumProceso            ;
    lhCod_Cliente   =lCod_Cliente           ;

    sprintf(szhDescrip      ,"%40s" ,szDescrip    );        
    sprintf(szhObsAnomalia  ,"%60s" ,szObsAnomalia);        


    /* EXEC SQL
         SELECT  NUM_PROCESO
         INTO    :lhNumProc2
         FROM    FA_ANOPROCESO
         WHERE   NUM_PROCESO =:lhNumProceso
	 AND     COD_CLIENTE =:lhCod_Cliente ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NUM_PROCESO into :b0  from FA_ANOPROCESO where (NU\
M_PROCESO=:b1 and COD_CLIENTE=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )584;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProc2;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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



    if (sqlca.sqlcode)
    {
        if (sqlca.sqlcode== SQLNOTFOUND)
        {
            /* EXEC SQL
                 INSERT INTO FA_ANOPROCESO
			    (NUM_PROCESO    ,COD_CLIENTE    ,DES_PROCESO,OBS_ANOMALIA)
		        VALUES
			    (:lhNumProceso ,:lhCod_Cliente ,:szhDescrip ,:szhObsAnomalia); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 24;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into FA_ANOPROCESO (NUM_PROCESO,COD_CLIENT\
E,DES_PROCESO,OBS_ANOMALIA) values (:b0,:b1,:b2,:b3)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )611;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCod_Cliente;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhDescrip;
            sqlstm.sqhstl[2] = (unsigned long )41;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhObsAnomalia;
            sqlstm.sqhstl[3] = (unsigned long )61;
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
    }
    else
    {
	/* EXEC SQL
	     UPDATE FA_ANOPROCESO
	       SET DES_PROCESO =:szhDescrip,
	       OBS_ANOMALIA=:szhObsAnomalia
	     WHERE NUM_PROCESO =:lhNumProceso
	     AND   COD_CLIENTE =:lhCod_Cliente ; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 24;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update FA_ANOPROCESO  set DES_PROCESO=:b0,OBS_ANOMALIA=:b1 w\
here (NUM_PROCESO=:b2 and COD_CLIENTE=:b3)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )642;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDescrip;
 sqlstm.sqhstl[0] = (unsigned long )41;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhObsAnomalia;
 sqlstm.sqhstl[1] = (unsigned long )61;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumProceso;
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


    }

    if (sqlca.sqlcode)
    {
        if ( !fnOraRollBack() )
	     vDTrazasError(modulo, "En Rollback \n%s\n"
	    	                 , LOG01, sqlca.sqlerrm.sqlerrmc);
    }

    if ( !fnOraCommit() )
	 vDTrazasError(modulo, "En Commit \n%s\n"
	    	             , LOG01, sqlca.sqlerrm.sqlerrmc);
}

/* *************************************************************************** */
/* ifnGetParam : Obtiene el valor del parametro indicado de FAD_PARAMETRO      */
/* *************************************************************************** */
int ifnGetParam (char *szDesParametro, char *szTipParametro, char *szValParametro )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 char    szhDesParametro [1024+1]; /* EXEC SQL VAR szhDesParametro  IS STRING(1024+1); */ 

	 long    lhValNumerico           ;
	 char    szhTipParametro     [33]; /* EXEC SQL VAR szhTipParametro  IS STRING(33); */ 

         char    szhValCaracter     [513]; /* EXEC SQL VAR szhValCaracter   IS STRING(513); */ 

         char    szhValFecha         [20]; /* EXEC SQL VAR szhValFecha      IS STRING(20); */ 

         short   s_lhValNumerico         ;
         short   s_szhValCaracter        ;
         short   s_szhValFecha           ;
    /* EXEC SQL END DECLARE SECTION; */ 


    memset(szhDesParametro,'\0',sizeof(szhDesParametro));
    memset(szhTipParametro,'\0',sizeof(szhTipParametro));
    memset(szhValCaracter,'\0',sizeof(szhValCaracter));    
    memset(szhValFecha,'\0',sizeof(szhValFecha));
    
    strcpy(szhDesParametro,szDesParametro);

    /* EXEC SQL
	 SELECT TIP_PARAMETRO, VAL_NUMERICO, VAL_CARACTER, TO_CHAR(VAL_FECHA,'YYYYMMDDHH24MISS')
	 INTO   :szhTipParametro   ,
	        :lhValNumerico  :s_lhValNumerico,
	        :szhValCaracter :s_szhValCaracter,
	        :szhValFecha    :s_szhValFecha
	 FROM FAD_PARAMETROS
	 WHERE COD_MODULO          = 'FA'
	 AND   TRIM(DES_PARAMETRO) = :szhDesParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TIP_PARAMETRO ,VAL_NUMERICO ,VAL_CARACTER ,TO_CHAR\
(VAL_FECHA,'YYYYMMDDHH24MISS') into :b0,:b1:b2,:b3:b4,:b5:b6  from FAD_PARAMET\
ROS where (COD_MODULO='FA' and trim(DES_PARAMETRO)=:b7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )673;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhDesParametro;
    sqlstm.sqhstl[4] = (unsigned long )1025;
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



    if( sqlca.sqlcode == SQLOK )
    {
        if ( strcmp (szhTipParametro ,"VARCHAR2") == 0 )
        {                          
             if (s_szhValCaracter== ORA_NULL)    strcpy(szValParametro,"\0" );         
             else                                strcpy(szValParametro,szhValCaracter);
        }
        else if ( strcmp (szhTipParametro,"NUMBER") ==0 )
        {
	          if (s_lhValNumerico == ORA_NULL)    strcpy(szValParametro,"\0" );                
	          else                                sprintf(szValParametro,"%ld" ,lhValNumerico);
        }
	else if ( strcmp (szhTipParametro,"DATE") == 0 )
	{
	          if (s_szhValFecha   == ORA_NULL)    strcpy(szValParametro,"\0" );      
	          else                                strcpy(szValParametro,szhValFecha);
	}
    }
    else
    {
    	if (sqlca.sqlcode != SQLNOTFOUND)
    	fprintf(stderr, "Error al recuperar parametro, desde FAD_PARAMETROS.\n");
    }
    return(sqlca.sqlcode);
}

/* *************************************************************************** */
/* FUNCION     : ifnGetCodigosTipDocum                                         */
/* DESCRIPCION : Obtiene el valor del parametro indicado de FAD_PARAMETRO      */
/* *************************************************************************** */
int ifnGetCodigosTipDocum (int iCodTipoDocRel)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

	 int    ihCodTipoDocRel           ;
	 int    ihOcurrencias     ;
    /* EXEC SQL END DECLARE SECTION; */ 
   
    
    vDTrazasLog (szExeName, "\n\t** Entrada en %s **"
                            "\n\t========================================"
                            "\n\t=> Doc. Rel         [%d]\n"                           
                          , LOG05, "ifnGetCodigosTipDocum"
                          , iCodTipoDocRel);    

    ihCodTipoDocRel = iCodTipoDocRel;

    /* EXEC SQL
	 SELECT COUNT(1)
	 INTO   :ihOcurrencias
	 FROM   GED_CODIGOS
	 WHERE  COD_MODULO = 'FA'
	 AND    NOM_TABLA  = 'GE_TIPDOCUMEN'
	 AND    NOM_COLUMNA = 'COD_TIPDOCUM'
	 and    COD_VALOR   = TO_CHAR(:ihCodTipoDocRel); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(1) into :b0  from GED_CODIGOS where (((COD_M\
ODULO='FA' and NOM_TABLA='GE_TIPDOCUMEN') and NOM_COLUMNA='COD_TIPDOCUM') and \
COD_VALOR=TO_CHAR(:b1))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )708;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihOcurrencias;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipoDocRel;
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


	 
    if (SQLCODE != SQLOK)     
    {
        vDTrazasError(szExeName,"\n\t** Error en función ifnGetCodigosTipDocum [%ld] [%s] **",LOG01,SQLCODE,szfnORAerror());
        vDTrazasLog  (szExeName,"\n\t** Error en función ifnGetCodigosTipDocum [%ld] [%s] **",LOG01,SQLCODE,szfnORAerror());
        ihOcurrencias = -99;
        return (ihOcurrencias); 	
    }	 
    else
    {
    	if (ihOcurrencias == 0)
    	{
    	    /* Documento Rel. No esta en la GED_CODIGOS, No genera Nota de Abono */
            vDTrazasLog (szExeName, "n\t** Documento Rel. No esta en Tabla GED_CODIGOS, No genera Nota de Abono **"
                                  , LOG05);
            vDTrazasLog (szExeName, "n\t => Ocurrencias [%d]",LOG05,ihOcurrencias);    	    
    	    return (ihOcurrencias);
    	}
    	else
    	{
            /* Documento Rel. esta en la GED_CODIGOS, Genera Nota de Abono */    
            vDTrazasLog (szExeName, "n\t** Documento Rel. esta en Tabla GED_CODIGOS, Posible Nota de Abono **"
                                  , LOG05);    
            vDTrazasLog (szExeName, "n\t => Ocurrencias [%d]",LOG05,ihOcurrencias);    
            return (ihOcurrencias);  
        }  		    	
    }
}

/* ************************************************************************** */
/* ifnGetParametro : Obtiene el valor del parametro indicado de FAD_PARAMETRO */
/* ************************************************************************** */
int ifnGetParametro (int iCodParametro, char *szTipParametro, char *szValParametro )
{
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

    /* EXEC SQL
	 SELECT TIP_PARAMETRO, VAL_NUMERICO, VAL_CARACTER, TO_CHAR(VAL_FECHA,'YYYYMMDDHH24MISS')
	 INTO   :szhTipParametro   ,
	        :lhValNumerico  :s_lhValNumerico,
	        :szhValCaracter :s_szhValCaracter,
	        :szhValFecha    :s_szhValFecha
	 FROM FAD_PARAMETROS
	 WHERE COD_MODULO='FA'
	 AND COD_PARAMETRO=:ihCodParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 24;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TIP_PARAMETRO ,VAL_NUMERICO ,VAL_CARACTER ,TO_CHAR\
(VAL_FECHA,'YYYYMMDDHH24MISS') into :b0,:b1:b2,:b3:b4,:b5:b6  from FAD_PARAMET\
ROS where (COD_MODULO='FA' and COD_PARAMETRO=:b7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )731;
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



    if( sqlca.sqlcode == SQLOK )
    {
        if ( strcmp (szhTipParametro ,"VARCHAR2") == 0 )
        {                          
             if (s_szhValCaracter== ORA_NULL)    strcpy(szValParametro,"\0" );         
             else                                strcpy(szValParametro,szhValCaracter);
        }
        else if ( strcmp (szhTipParametro,"NUMBER") ==0 )
        {
	          if (s_lhValNumerico == ORA_NULL)    strcpy(szValParametro,"\0" );                
	          else                                sprintf(szValParametro,"%ld" ,lhValNumerico);
        }
	else if ( strcmp (szhTipParametro,"DATE") == 0 )
	{
	          if (s_szhValFecha   == ORA_NULL)    strcpy(szValParametro,"\0" );      
	          else                                strcpy(szValParametro,szhValFecha);
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

