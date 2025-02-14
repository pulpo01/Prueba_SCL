
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
    "./pc/AsigCobJud.pc"
};


static unsigned int sqlctx = 13797195;


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
   unsigned char  *sqhstv[7];
   unsigned long  sqhstl[7];
            int   sqhsts[7];
            short *sqindv[7];
            int   sqinds[7];
   unsigned long  sqharm[7];
   unsigned long  *sqharc[7];
   unsigned short  sqadto[7];
   unsigned short  sqtdso[7];
} sqlstm = {12,7};

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

 static const char *sq0005 = 
"select A.COD_AGENTE ,A.PRC_ASIGNACION ,C.COD_ENTIDAD  from CO_ENTCOB C ,CO_A\
GENCOB B ,CO_AGENCOMU A where ((((A.COD_COMUNA=:b0 and B.COD_AGENTE=A.COD_AGEN\
TE) and C.COD_ENTIDAD=B.COD_ENTIDAD) and C.TIP_ENTIDAD='E') and C.TIP_COBRANZA\
<>'P')           ";

 static const char *sq0012 = 
"select COD_CLIENTE ,COD_AGENTE ,COD_CUENTA  from CO_MOROSOS where (NUM_IDENT\
=:b0 and COD_TIPIDENT=:b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,300,0,4,96,0,0,7,2,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,
0,1,5,0,0,
48,0,0,2,127,0,5,118,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,5,0,0,
75,0,0,3,110,0,5,138,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
98,0,0,4,175,0,4,155,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
129,0,0,5,249,0,9,218,0,0,1,1,0,1,0,1,5,0,0,
148,0,0,5,0,0,13,226,0,0,3,0,0,1,0,2,9,0,0,2,3,0,0,2,9,0,0,
175,0,0,5,0,0,15,241,0,0,0,0,0,1,0,
190,0,0,6,65,0,4,251,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
213,0,0,7,286,0,3,269,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,9,0,0,1,5,0,0,
248,0,0,8,59,0,5,286,0,0,2,2,0,1,0,1,9,0,0,1,3,0,0,
271,0,0,9,235,0,4,312,0,0,4,3,0,1,0,2,3,0,0,1,9,0,0,1,3,0,0,1,5,0,0,
302,0,0,10,286,0,3,351,0,0,5,5,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,9,0,0,1,5,0,0,
337,0,0,11,59,0,5,368,0,0,2,2,0,1,0,1,9,0,0,1,3,0,0,
360,0,0,12,113,0,9,418,0,0,2,2,0,1,0,1,5,0,0,1,5,0,0,
383,0,0,12,0,0,13,430,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,
410,0,0,13,59,0,5,450,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
433,0,0,14,86,0,4,466,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
460,0,0,15,203,0,3,482,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,97,0,0,
495,0,0,16,86,0,5,517,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
518,0,0,12,0,0,15,532,0,0,0,0,0,1,0,
};


/* ============================================================================= */
/*
    Tipo        :  ACCION
    Nombre      :  AsigCobJud.pc ("ACJUD"->szfnAsigCobJud)
    Descripcion :  ASIGna una entidad de COBranza JUDicial
                   a todos los abonados del rut del cliente dado
    Recibe      :  by Val -> Cod Cliente 
    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
                   "NORUT"-> Fue imposible determinar el rut del cliente dado
                   "NOAGE"-> Fue imposible asignar un agente (entidad)
                   "OK"   -> La accion se ejecuto correctamente
    Autor       :  Roy Barrera Richards
    Fecha       :  10 - Agosto - 2000 
Modificacion    :  12-11-2004
						 Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "AsigCobJud.h"
#define HOST_ARRAY_AGENTES  500  

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

/* ============================================================================= */
/* funcion de asignacion de entidad de cobranza judicial                         */
/* ============================================================================= */
char  *szfnAsigCobJud (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
char modulo[]="szfnAsigCobJud";
int iResp=0, iMetropolitana = 13, iAsignado = 0;
int i=0,iMorososComuna=0,iPorcentajeTotal=0;
long lTotalRows=0;
float fPorcentajeDefinido = 0.0;
float fPorcentajeActual = 0.0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long lhCodCliente          = 0  ;
   long lhCodClienteNew       = 0  ;
   char szhCodRegion[4]       = "" ; /* EXEC SQL VAR szhCodRegion IS STRING (4); */ 

   char szhCodComuna[6]       = "" ; /* EXEC SQL VAR szhCodComuna IS STRING (6); */ 

   int  ihDirCorrespondencia  = 3  ;
   char szhNumIdent[21]       = "" ; /* EXEC SQL VAR szhNumIdent IS STRING (21); */ 

   char szhCodTipIdent[3]     = "" ; /* EXEC SQL VAR szhCodTipIdent IS STRING (3); */ 

   char szhCodEntidadAsig[6]  = "" ; /* EXEC SQL VAR szhCodEntidadAsig IS STRING (6); */ 

   char szhCodAgenteAsig[31]  = "" ; /* EXEC SQL VAR szhCodAgenteAsig IS STRING (31); */ 

   char szhCodAgenteNew[31]   = "" ; /* EXEC SQL VAR szhCodAgenteNew IS STRING (31); */ 

   long lhCodCuentaNew        = 0  ;
   char szhCodMovimiento[6]   = "" ; /* EXEC SQL VAR szhCodMovimiento IS STRING (6); */ 

   char szhFecMovimiento[15]  = "" ; /* EXEC SQL VAR szhFecMovimiento IS STRING (15); */ 

   char szhAuxHoy[15]         = "" ; /* EXEC SQL VAR szhAuxHoy IS STRING (15); */ 

   char szhCodEnvio[6]        = "" ; /* EXEC SQL VAR szhCodEnvio IS STRING (6); */ 

   int ihIncrementoClientes  = 0  ;
   char szhRutStgo[2]         = "" ; /* EXEC SQL VAR szhRutStgo IS STRING (2); */ 

/* VARCHAR szhCodAgente    [HOST_ARRAY_AGENTES][31]; */ 
struct { unsigned short len; unsigned char arr[34]; } szhCodAgente[500];

/* VARCHAR szhCodEntidad   [HOST_ARRAY_AGENTES][6] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szhCodEntidad[500];
 
   int ihPrcAsignado   [HOST_ARRAY_AGENTES]    ;
   int ihMorososAgente [HOST_ARRAY_AGENTES]    ;
   char szhCobranzaJudicial[2]= "" ; /* EXEC SQL VAR szhCobranzaJudicial IS STRING (2); */ 

   char szhTipCobranza[2]     = "" ; /* EXEC SQL VAR szhTipCobranza IS STRING (2); */ 

   char szCodGestion[3+1];   
   int iCountGest=0;        
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	 CXX = ctxCont;
	 /* EXEC SQL CONTEXT USE :CXX; */ 

    
	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);
    lhCodCliente = lCliente;
    
    strcpy(szhCobranzaJudicial,"J");

    /*-(0) Obtiene el Rut del Cliente -*/            
    iResp = ifnGetRutCliente(&pfLog, lCliente,szhNumIdent,szhCodTipIdent, CXX); /* el envia mensaje en caso de error */
    if (iResp == 0) /*No encontro el rut */
    {
        return "NORUT";
    }
    else if (iResp < 0 ) /* error oracle */
    {
        return "SQL";
    }
    
    iResp = 0;

    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(NumIdent:%s)(TipIdent:%s)",LOG05,lhCodCliente,szhNumIdent,szhCodTipIdent);  

  
    /*--(1) Verificar si el rut de este cliente ya tiene alguna cobranza externa asignada --*/    
	 sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    SELECT A.COD_ENTIDAD, A.COD_MOVIMIENTO, A.COD_ENVIO
         , TO_CHAR(A.FEC_MOVIMIENTO,'YYYYMMDDHH24MISS')
         , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
    INTO   :szhCodEntidadAsig, :szhCodMovimiento, :szhCodEnvio
         , :szhFecMovimiento
         , :szhAuxHoy
    FROM  CO_ENTCOB B, CO_COBEXTERNA A
    WHERE A.NUM_IDENT = :szhNumIdent
    AND   A.COD_TIPIDENT = :szhCodTipIdent 
    AND   B.COD_ENTIDAD  = A.COD_ENTIDAD
    AND   B.TIP_COBRANZA = 'A' ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_ENTIDAD ,A.COD_MOVIMIENTO ,A.COD_ENVIO ,TO_C\
HAR(A.FEC_MOVIMIENTO,'YYYYMMDDHH24MISS') ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') \
into :b0,:b1,:b2,:b3,:b4  from CO_ENTCOB B ,CO_COBEXTERNA A where (((A.NUM_IDE\
NT=:b5 and A.COD_TIPIDENT=:b6) and B.COD_ENTIDAD=A.COD_ENTIDAD) and B.TIP_COBR\
ANZA='A')";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodEntidadAsig;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodMovimiento;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodEnvio;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecMovimiento;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhAuxHoy;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[5] = (unsigned long )21;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhCodTipIdent;
    sqlstm.sqhstl[6] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* AMBAS ( judicial y Perjudicial) */

    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) CO_COBEXTERNA => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL"; /* error oracle*/
    }
    else if ( sqlca.sqlcode != SQLNOTFOUND )
    {
        /* El cliente ya esta asociado a una entidad de cobranza de tipo Judicial. Cambia el indicador */
        sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
        /* EXEC SQL
        UPDATE CO_COBEXTERNA
        SET    TIP_COBRANZA = :szhCobranzaJudicial,
               COD_MOVIMIENTO = 'M',
               FEC_MOVIMIENTO = SYSDATE
        WHERE  NUM_IDENT = :szhNumIdent
        AND    COD_TIPIDENT = :szhCodTipIdent ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_COBEXTERNA  set TIP_COBRANZA=:b0,COD_MOVIMI\
ENTO='M',FEC_MOVIMIENTO=SYSDATE where (NUM_IDENT=:b1 and COD_TIPIDENT=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )48;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCobranzaJudicial;
        sqlstm.sqhstl[0] = (unsigned long )2;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhNumIdent;
        sqlstm.sqhstl[1] = (unsigned long )21;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
        sqlstm.sqhstl[2] = (unsigned long )3;
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
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


        
        if (sqlca.sqlcode)
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) UPDATE 'J' CO_COBEXTERNA => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
            return "SQL"; /* error oracle*/
        }
            
        return "OK"; /* No hace nada mas, porque ya esta como cobranza Pre-Judicial */

    }
    /* SQLNOTFOUND : El cliente no esta asociado a ninguna entidad de cobranza del tipo Judicial ( reasignar a una )*/
        
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    UPDATE CO_COBEXTERNA
    SET    COD_MOVIMIENTO = 'B',
           FEC_MOVIMIENTO = SYSDATE
    WHERE  NUM_IDENT = :szhNumIdent
    AND    COD_TIPIDENT = :szhCodTipIdent ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_COBEXTERNA  set COD_MOVIMIENTO='B',FEC_MOVIMIEN\
TO=SYSDATE where (NUM_IDENT=:b0 and COD_TIPIDENT=:b1)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )75;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
    sqlstm.sqhstl[1] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) UPDATE 'B' CO_COBEXTERNA => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL"; /* error oracle*/
    }


    /*--(2) Determinar comuna asociada a la direccion de correspondencia del cliente --*/
    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    SELECT C.COD_REGION, C.COD_COMUNA
      INTO :szhCodRegion, :szhCodComuna
      FROM GE_DIRECCIONES C, GA_DIRECCLI B
     WHERE B.COD_CLIENTE      = :lhCodCliente
       AND B.COD_TIPDIRECCION = :ihDirCorrespondencia
       AND C.COD_DIRECCION    = B.COD_DIRECCION; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select C.COD_REGION ,C.COD_COMUNA into :b0,:b1  from GE_D\
IRECCIONES C ,GA_DIRECCLI B where ((B.COD_CLIENTE=:b2 and B.COD_TIPDIRECCION=:\
b3) and C.COD_DIRECCION=B.COD_DIRECCION)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )98;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodComuna;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihDirCorrespondencia;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
    if (sqlca.sqlcode)
    {   
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) DIRECCIONES => %s",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL";     /* error oracle */
    }
    
    if ( atoi(szhCodRegion) != iMetropolitana ) /* la direccion no es de la region metropolitana */
    {
        /*-- Verificar si el Rut tiene asociados clientes con direccion en Santiago */
        iResp = ifnRutMetropolitano (&pfLog,lhCodCliente, &i, CXX );
        if ( iResp < 0 )
        {
            return "SQL";       /* error oracle */
        }
        else if ( iResp == 0 )
        {
            return "NORUT";     /* no hallo el rut */
        }
    }
    else
    {
        i = 1 ; /* marca como metropolitano */
    }

    strcpy(szhRutStgo,"N");
    if (i == 1)   
    {
        strcpy(szhCodComuna,"13112"); /* si es metropolitana COMUNA = STGO_CENTRO*/
        strcpy(szhRutStgo,"S");
    }

	 ifnTrazaHilos( modulo,&pfLog, "Cliente :[%ld]  Comuna : [%s]",LOG03,lhCodCliente,szhCodComuna);  
    /*- (3) Obtiene los agentes de cobranzas de la comuna y sus porcentajes definidos---------------*/
    sqlca.sqlcode=0;    
    /* EXEC SQL 
    DECLARE curEntExt CURSOR FOR
    SELECT A.COD_AGENTE
         , A.PRC_ASIGNACION
         , C.COD_ENTIDAD
      FROM CO_ENTCOB C,
           CO_AGENCOB B,
           CO_AGENCOMU A
     WHERE A.COD_COMUNA  = :szhCodComuna 
       AND B.COD_AGENTE  = A.COD_AGENTE
       AND C.COD_ENTIDAD = B.COD_ENTIDAD
       AND C.TIP_ENTIDAD = 'E'  /o EXTERNO o/
       AND C.TIP_COBRANZA != 'P' ; */ 
 /* PREJUDICIAL */

    if (sqlca.sqlcode)
    {   
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Declare curAgentes => %s", LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL";   
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL OPEN curEntExt ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0005;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )129;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodComuna;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {   
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Open curAgentes => %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL";   
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL FETCH curEntExt INTO :szhCodAgente, :ihPrcAsignado, :szhCodEntidad ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )148;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente;
    sqlstm.sqhstl[0] = (unsigned long )33;
    sqlstm.sqhsts[0] = (         int  )36;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)ihPrcAsignado;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodEntidad;
    sqlstm.sqhstl[2] = (unsigned long )8;
    sqlstm.sqhsts[2] = (         int  )8;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    lTotalRows=SQLROWS;    
            
    if ( sqlca.sqlcode != SQLNOTFOUND && sqlca.sqlcode != SQLOK )
	{
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Fetch curAgentes => %s ",LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
		return "SQL";
	}
	else if ( sqlca.sqlcode != SQLNOTFOUND )
	{
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Fetch curAgentes => Sobrepasado Maximo de elementos ",LOG00,lhCodCliente);  
        return "SQL";
	}
	
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL CLOSE curEntExt ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )175;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {   
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Close curAgentes => %s "
                     ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL";            
    }
	
    /*--(0) Obtiene el cod_cuenta del cliente en la CO_MOROSOS --*/    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    SELECT COD_CUENTA
    INTO :lhCodCuentaNew
    FROM CO_MOROSOS
    WHERE COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CUENTA into :b0  from CO_MOROSOS where COD_CLI\
ENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )190;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCuentaNew;
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
    sqlstm.sqphsv = sqlstm.sqhstv;
    sqlstm.sqphsl = sqlstm.sqhstl;
    sqlstm.sqphss = sqlstm.sqhsts;
    sqlstm.sqpind = sqlstm.sqindv;
    sqlstm.sqpins = sqlstm.sqinds;
    sqlstm.sqparm = sqlstm.sqharm;
    sqlstm.sqparc = sqlstm.sqharc;
    sqlstm.sqpadto = sqlstm.sqadto;
    sqlstm.sqptdso = sqlstm.sqtdso;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( sqlca.sqlcode )
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Select Cod_cuenta from CO_MOROSOS => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "SQL"; /* error oracle*/
    }

	iAsignado = 0;
	
	if ( lTotalRows > 0 ) 
	{
        if ((ihPrcAsignado[0] == 100)) 
        {    
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL 
            INSERT INTO CO_COBEXTERNA
            ( 
                NUM_IDENT,          COD_TIPIDENT,       COD_CUENTA,      COD_ENTIDAD,     
                TIP_COBRANZA,       FEC_INGRESO,        NUM_PROCESO,     COD_MOVIMIENTO,  
                FEC_MOVIMIENTO,     MTO_DEUDA,          MTO_VENCIDO,     CNT_CLIENTES,    
                COD_ENVIO,          NUM_IDENT_SANTIAGO, NOM_USUARIO     
            )
            VALUES
            (   
                :szhNumIdent,       :szhCodTipIdent,    :lhCodCuentaNew,   :szhCodEntidad[0],
                'J',                SYSDATE,            0,                 'A',                
                SYSDATE,            0,                  0,                 1,                 
                'X',                :szhRutStgo,        USER           
            ); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "insert into CO_COBEXTERNA (NUM_IDENT,COD_TIPIDENT\
,COD_CUENTA,COD_ENTIDAD,TIP_COBRANZA,FEC_INGRESO,NUM_PROCESO,COD_MOVIMIENTO,FE\
C_MOVIMIENTO,MTO_DEUDA,MTO_VENCIDO,CNT_CLIENTES,COD_ENVIO,NUM_IDENT_SANTIAGO,N\
OM_USUARIO) values (:b0,:b1,:b2,:b3,'J',SYSDATE,0,'A',SYSDATE,0,0,1,'X',:b4,US\
ER)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )213;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
            sqlstm.sqhstl[0] = (unsigned long )21;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
            sqlstm.sqhstl[1] = (unsigned long )3;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCuentaNew;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)&szhCodEntidad[0];
            sqlstm.sqhstl[3] = (unsigned long )8;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhRutStgo;
            sqlstm.sqhstl[4] = (unsigned long )2;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL 
            UPDATE CO_MOROSOS
               SET COD_AGENTE  = :szhCodAgente[0] 
             WHERE COD_CLIENTE = :lhCodCliente; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_C\
LIENTE=:b1";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )248;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&szhCodAgente[0];
            sqlstm.sqhstl[0] = (unsigned long )33;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



            if (sqlca.sqlcode)
            {   
                ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)->(Agente:%.*s) Insert CO_COBEXTERNA => %s "
                             ,LOG00,lhCodCliente,szhCodAgente[0].len,szhCodAgente[0].arr,sqlca.sqlerrm.sqlerrmc);  
                return "SQL";            
            }
            else
            {   
                ifnTrazaHilos( modulo,&pfLog, "%s : (Cliente:%ld)->(Agente:%.*s) Ok "
                             ,LOG03,modulo,lhCodCliente,szhCodAgente[0].len,szhCodAgente[0].arr);
                sprintf(szhCodEntidadAsig,"%.*s",szhCodEntidad[0].len,szhCodEntidad[0].arr);
                sprintf(szhCodAgenteAsig,"%.*s",szhCodAgente[0].len,szhCodAgente[0].arr);
                iAsignado = 1;
               /* return "OK"; */
            }/*endif*/
        }            
        else /* el primero no tenia el 100% */
        {
            for(i=0; i < lTotalRows; i++) /* procesar cada agente (contar sus morosos) */
            {
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                /* EXEC SQL      
                SELECT COUNT(A.COD_CLIENTE)   
                  INTO :ihMorososAgente[i]
                  FROM GE_DIRECCIONES C, GA_DIRECCLI B, CO_MOROSOS A /o CO_COBEXTERNA A o/
                 WHERE A.COD_AGENTE = :szhCodAgente[i] /oA.COD_ENTIDAD = :szhCodEntidad[i]o/
                   AND B.COD_CLIENTE = A.COD_CLIENTE
                   AND B.COD_TIPDIRECCION = :ihDirCorrespondencia
                   AND C.COD_DIRECCION = B.COD_DIRECCION
                   AND C.COD_COMUNA= :szhCodComuna; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select count(A.COD_CLIENTE) into :b0  from GE\
_DIRECCIONES C ,GA_DIRECCLI B ,CO_MOROSOS A where ((((A.COD_AGENTE=:b1 and B.C\
OD_CLIENTE=A.COD_CLIENTE) and B.COD_TIPDIRECCION=:b2) and C.COD_DIRECCION=B.CO\
D_DIRECCION) and C.COD_COMUNA=:b3)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )271;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&ihMorososAgente[i];
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&szhCodAgente[i];
                sqlstm.sqhstl[1] = (unsigned long )33;
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)&ihDirCorrespondencia;
                sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhCodComuna;
                sqlstm.sqhstl[3] = (unsigned long )6;
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



                if (sqlca.sqlcode)
                {   
                    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(Agente:%.*s) Count CO_COBEXTERNA => %s "
                                 ,LOG00,lhCodCliente,szhCodAgente[i].len,szhCodAgente[i].arr,sqlca.sqlerrm.sqlerrmc);  
                    return "SQL";
                }
        
                iMorososComuna += ihMorososAgente[i];      /* Acumula el total de morosos de la comuna */
                iPorcentajeTotal += ihPrcAsignado[i];      /* Suma los porcentajes de cada agente */
            }/* end for i  */

            if ( iPorcentajeTotal != 100 )
            {
                ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(Agente:%.*s) LA SUMA DE PORCENTAJES NO DA 100%% [%d]"
                             ,LOG02,lhCodCliente,szhCodAgente[i].len,szhCodAgente[i].arr,iPorcentajeTotal);  
                /*return "SQL";*/
            }

        	for(i=0; i < lTotalRows; i++) /* procesar cada agente (elegir cual asignar) */
            {
                fPorcentajeDefinido = (float) ihPrcAsignado[i];
                fPorcentajeActual   = (iMorososComuna==0)?0.0:(float) ( (100 * (float)ihMorososAgente[i]) / (float)iMorososComuna );

                ifnTrazaHilos( modulo,&pfLog, "i[%d] COD_AGENTE [%.*s] fPorcentajeDefinido [%f] fPorcentajeActual[%f] "
                             ,LOG05,i,szhCodAgente[i].len,szhCodAgente[i].arr,fPorcentajeDefinido,fPorcentajeActual);  
                
                if ( fPorcentajeDefinido >= fPorcentajeActual )
                {   
                    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                    /* EXEC SQL 
                    INSERT INTO CO_COBEXTERNA
                    ( 
                        NUM_IDENT,          COD_TIPIDENT,       COD_CUENTA,      COD_ENTIDAD,     
                        TIP_COBRANZA,       FEC_INGRESO,        NUM_PROCESO,     COD_MOVIMIENTO,  
                        FEC_MOVIMIENTO,     MTO_DEUDA,          MTO_VENCIDO,     CNT_CLIENTES,    
                        COD_ENVIO,          NUM_IDENT_SANTIAGO, NOM_USUARIO     
                    )
                    VALUES
                    (   
                        :szhNumIdent,       :szhCodTipIdent,    :lhCodCuentaNew,   :szhCodEntidad[i],
                        'J',                SYSDATE,            0,                 'A',                
                        SYSDATE,            0,                  0,                 1,                 
                        'X',                :szhRutStgo,        USER           
                    ); */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 7;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "insert into CO_COBEXTERNA (NUM_IDENT,COD_\
TIPIDENT,COD_CUENTA,COD_ENTIDAD,TIP_COBRANZA,FEC_INGRESO,NUM_PROCESO,COD_MOVIM\
IENTO,FEC_MOVIMIENTO,MTO_DEUDA,MTO_VENCIDO,CNT_CLIENTES,COD_ENVIO,NUM_IDENT_SA\
NTIAGO,NOM_USUARIO) values (:b0,:b1,:b2,:b3,'J',SYSDATE,0,'A',SYSDATE,0,0,1,'X\
',:b4,USER)";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )302;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
                    sqlstm.sqhstl[0] = (unsigned long )21;
                    sqlstm.sqhsts[0] = (         int  )0;
                    sqlstm.sqindv[0] = (         short *)0;
                    sqlstm.sqinds[0] = (         int  )0;
                    sqlstm.sqharm[0] = (unsigned long )0;
                    sqlstm.sqadto[0] = (unsigned short )0;
                    sqlstm.sqtdso[0] = (unsigned short )0;
                    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
                    sqlstm.sqhstl[1] = (unsigned long )3;
                    sqlstm.sqhsts[1] = (         int  )0;
                    sqlstm.sqindv[1] = (         short *)0;
                    sqlstm.sqinds[1] = (         int  )0;
                    sqlstm.sqharm[1] = (unsigned long )0;
                    sqlstm.sqadto[1] = (unsigned short )0;
                    sqlstm.sqtdso[1] = (unsigned short )0;
                    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCuentaNew;
                    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
                    sqlstm.sqhsts[2] = (         int  )0;
                    sqlstm.sqindv[2] = (         short *)0;
                    sqlstm.sqinds[2] = (         int  )0;
                    sqlstm.sqharm[2] = (unsigned long )0;
                    sqlstm.sqadto[2] = (unsigned short )0;
                    sqlstm.sqtdso[2] = (unsigned short )0;
                    sqlstm.sqhstv[3] = (unsigned char  *)&szhCodEntidad[i];
                    sqlstm.sqhstl[3] = (unsigned long )8;
                    sqlstm.sqhsts[3] = (         int  )0;
                    sqlstm.sqindv[3] = (         short *)0;
                    sqlstm.sqinds[3] = (         int  )0;
                    sqlstm.sqharm[3] = (unsigned long )0;
                    sqlstm.sqadto[3] = (unsigned short )0;
                    sqlstm.sqtdso[3] = (unsigned short )0;
                    sqlstm.sqhstv[4] = (unsigned char  *)szhRutStgo;
                    sqlstm.sqhstl[4] = (unsigned long )2;
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
                    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


                    
                    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                    /* EXEC SQL 
                    UPDATE CO_MOROSOS
                       SET COD_AGENTE  = :szhCodAgente[i] 
                     WHERE COD_CLIENTE = :lhCodCliente; */ 

{
                    struct sqlexd sqlstm;
                    sqlstm.sqlvsn = 12;
                    sqlstm.arrsiz = 7;
                    sqlstm.sqladtp = &sqladt;
                    sqlstm.sqltdsp = &sqltds;
                    sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 whe\
re COD_CLIENTE=:b1";
                    sqlstm.iters = (unsigned int  )1;
                    sqlstm.offset = (unsigned int  )337;
                    sqlstm.cud = sqlcud0;
                    sqlstm.sqlest = (unsigned char  *)&sqlca;
                    sqlstm.sqlety = (unsigned short)256;
                    sqlstm.occurs = (unsigned int  )0;
                    sqlstm.sqhstv[0] = (unsigned char  *)&szhCodAgente[i];
                    sqlstm.sqhstl[0] = (unsigned long )33;
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
                    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



                    if (sqlca.sqlcode)
                    {   
                        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)->(Agente:%.*s) Update CO_MOROSOS+ => %s "
                                     ,LOG00,lhCodCliente,szhCodAgente[i].len,szhCodAgente[i].arr,sqlca.sqlerrm.sqlerrmc);  
                        return "SQL";
                    }  
                    else
                    {   
                        ifnTrazaHilos( modulo,&pfLog, "%s : (Cliente:%ld)->(Agente:%.*s) Ok+ "
                             ,LOG03,modulo,lhCodCliente,szhCodAgente[i].len,szhCodAgente[i].arr);  
                        sprintf(szhCodEntidadAsig,"%.*s",szhCodEntidad[i].len, szhCodEntidad[i].arr);
                        sprintf(szhCodAgenteAsig,"%.*s",szhCodAgente[i].len,szhCodAgente[i].arr);
                        iAsignado = 1;     
                        /* return "OK"; */
                    }
                    break;
                }
            } /* end for i */
        } 
    }

    if ( iAsignado == 0)
    {
        /* 2 situaciones : ( lTotalRows <= 0 ) o nunca se cumplio que (fPorcentajeDefinido >= fPorcentajeActual )*/
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) NOAGE => No se encontro agente" ,LOG01,lhCodCliente);  
        return "NOAGE";
    }

    /*--(4) Ya asigno una entidad de cobranza externa Actualizar la CO_MOROSOS ---*/

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL 
    DECLARE curClientes CURSOR FOR
    SELECT COD_CLIENTE,COD_AGENTE, COD_CUENTA
    FROM CO_MOROSOS
    WHERE NUM_IDENT = :szhNumIdent
    AND COD_TIPIDENT = :szhCodTipIdent ; */ 

    
    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) DECLARE CURSOR Clientes => %s" ,LOG03,lhCodCliente, sqlca.sqlerrm.sqlerrmc);  
        return "SQL";
    }
    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL 
    OPEN curClientes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0012;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )360;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
    sqlstm.sqhstl[1] = (unsigned long )3;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) OPEN CURSOR Clientes => %s" ,LOG03,lhCodCliente, sqlca.sqlerrm.sqlerrmc);  
        return "SQL";
    }
    
    iResp = 0; 
    while (1)
    {
        sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
        /* EXEC SQL
        FETCH curClientes 
        INTO :lhCodClienteNew, :szhCodAgenteNew, :lhCodCuentaNew; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 7;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )383;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodAgenteNew;
        sqlstm.sqhstl[1] = (unsigned long )31;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCuentaNew;
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
        sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


        
        if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) FETCH CURSOR Clientes => %s" ,LOG03,lhCodCliente, sqlca.sqlerrm.sqlerrmc);  
            iResp = 1; 
            break; /* error sql */
        }
        else if ( sqlca.sqlcode == SQLNOTFOUND )
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Fin CURSOR Clientes" ,LOG03,lhCodCliente);  
            iResp = 0; 
            break; /* no mas datos */
        }
        
        if ( strcmp(szhCodAgenteNew,szhCodAgenteAsig) ) /* si son != */
        {
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL 
            UPDATE CO_MOROSOS
               SET COD_AGENTE  = :szhCodAgenteAsig 
             WHERE COD_CLIENTE = :lhCodClienteNew; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_C\
LIENTE=:b1";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )410;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgenteAsig;
            sqlstm.sqhstl[0] = (unsigned long )31;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteNew;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


             
            if (sqlca.sqlcode)
            {
                ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Update CO_MOROSOS => %s" ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
                iResp = 1; 
                break; /* error sql */
            }

            /* rvc 23.07.03 */
            memset(szCodGestion, 0, sizeof(szCodGestion));
            strcpy(szCodGestion,"007");
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL SELECT count(*)
                      INTO   :iCountGest
                      FROM CO_GESTION
                      WHERE COD_CLIENTE = :lhCodClienteNew
                      AND   COD_GESTION = :szCodGestion; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 7;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select count(*)  into :b0  from CO_GESTION where \
(COD_CLIENTE=:b1 and COD_GESTION=:b2)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )433;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&iCountGest;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteNew;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szCodGestion;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



            if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
            {
                ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(COD_GESTION:%s) SELECT count(*) FROM CO_GESTION: %s", LOG00, lhCodClienteNew, szCodGestion, sqlca.sqlerrm.sqlerrmc );
                return FALSE;
            }

            /* Si no existe el cliente + codigo de gestion se inserta*/
            if (iCountGest == 0)
            {
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                /* EXEC SQL
                INSERT INTO CO_GESTION
                (
                    COD_CLIENTE ,
                    COD_CUENTA  ,
                    COD_TIPIDENT,
                    NUM_IDENT   ,
                    COD_GESTION ,
                    FEC_GESTION ,
                    OBS_GESTION ,
                    NOM_USUARIO 
                )
                VALUES
                (
                    :lhCodClienteNew,
                    :lhCodCuentaNew,
                    :szhCodTipIdent,
                    :szhNumIdent,
                    :szCodGestion,
                    SYSDATE,
                    'CAMBIA EJECUTIVO COBRANZA A PRE-JUDICIAL',
                    USER
                ); */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "insert into CO_GESTION (COD_CLIENTE,COD_CUENT\
A,COD_TIPIDENT,NUM_IDENT,COD_GESTION,FEC_GESTION,OBS_GESTION,NOM_USUARIO) valu\
es (:b0,:b1,:b2,:b3,:b4,SYSDATE,'CAMBIA EJECUTIVO COBRANZA A PRE-JUDICIAL',USE\
R)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )460;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuentaNew;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
                sqlstm.sqhstl[2] = (unsigned long )3;
                sqlstm.sqhsts[2] = (         int  )0;
                sqlstm.sqindv[2] = (         short *)0;
                sqlstm.sqinds[2] = (         int  )0;
                sqlstm.sqharm[2] = (unsigned long )0;
                sqlstm.sqadto[2] = (unsigned short )0;
                sqlstm.sqtdso[2] = (unsigned short )0;
                sqlstm.sqhstv[3] = (unsigned char  *)szhNumIdent;
                sqlstm.sqhstl[3] = (unsigned long )21;
                sqlstm.sqhsts[3] = (         int  )0;
                sqlstm.sqindv[3] = (         short *)0;
                sqlstm.sqinds[3] = (         int  )0;
                sqlstm.sqharm[3] = (unsigned long )0;
                sqlstm.sqadto[3] = (unsigned short )0;
                sqlstm.sqtdso[3] = (unsigned short )0;
                sqlstm.sqhstv[4] = (unsigned char  *)szCodGestion;
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



                if (sqlca.sqlcode)
                {
                    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Insert CO_GESTION => %s" ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
                    iResp = 1; 
                    break; /* error sql */
                }
            }
            else
            {
                /* Si existe el cliente + codigo de gestion se actualiza fecha*/
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                /* EXEC SQL UPDATE CO_GESTION
                         SET   FEC_GESTION = SYSDATE
                         WHERE COD_CLIENTE = :lhCodClienteNew
                         AND   COD_GESTION = :szCodGestion; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 7;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "update CO_GESTION  set FEC_GESTION=SYSDATE wh\
ere (COD_CLIENTE=:b0 and COD_GESTION=:b1)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )495;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)szCodGestion;
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
                sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



                if( sqlca.sqlcode != SQLOK )
                {
                   ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Actualizando CO_GESTION %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
                   return FALSE;
                }
            } /* if (iCountGest == 0) */
        }
    }/* endwhile */
    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    CLOSE curClientes; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 7;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )518;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) close CURSOR Clientes => %s" ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        iResp = 1; 
    }
    
    if (iResp == 1)
    {
        return "SQL";
    }

    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)-->(Entidad:%s) -OK- " ,LOG03,lhCodCliente,szhCodEntidadAsig);  

    return "OK";

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

