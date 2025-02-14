
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
           char  filnam[15];
};
static const struct sqlcxp sqlfpn =
{
    14,
    "./pc/preext.pc"
};


static unsigned int sqlctx = 865947;


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
   unsigned char  *sqhstv[48];
   unsigned long  sqhstl[48];
            int   sqhsts[48];
            short *sqindv[48];
            int   sqinds[48];
   unsigned long  sqharm[48];
   unsigned long  *sqharc[48];
   unsigned short  sqadto[48];
   unsigned short  sqtdso[48];
} sqlstm = {12,48};

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

 static const char *sq0001 = 
"select  /*+  index (FA_PREFACTURA FK_FA_PREFACTURA)  +*/ NUM_PROCESO ,COD_CL\
IENTE ,COD_CONCEPTO ,COLUMNA ,COD_PRODUCTO ,COD_MONEDA ,TO_CHAR(FEC_VALOR,:b0)\
 ,TO_CHAR(FEC_EFECTIVIDAD,:b0) ,IMP_CONCEPTO ,IMP_MONTOBASE ,IMP_FACTURABLE ,C\
OD_REGION ,COD_PROVINCIA ,COD_CIUDAD ,COD_MODULO ,COD_PLANCOM ,IND_FACTUR ,COD\
_CATIMPOS ,IND_ESTADO ,COD_TIPCONCE ,NUM_UNIDADES ,COD_CICLFACT ,COD_CONCEREL \
,COLUMNA_REL ,NUM_ABONADO ,NUM_TERMINAL ,CAP_CODE ,NUM_SERIEMEC ,NUM_SERIELE ,\
FLAG_IMPUES ,FLAG_DTO ,PRC_IMPUESTO ,VAL_DTO ,TIP_DTO ,NUM_VENTA ,NUM_TRANSACC\
ION ,MES_GARANTIA ,IND_ALTA ,IND_SUPERTEL ,NUM_PAQUETE ,IND_CUOTA ,NUM_CUOTAS \
,ORD_CUOTA ,IND_MODVENTA ,COD_MONEDAIMP ,IMP_CONVERSION ,IMP_VALUNITARIO ,GLS_\
DESCRIP  from FA_PREFACTURA where NUM_PROCESO=:b2           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,760,0,9,204,0,0,3,3,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,
32,0,0,1,0,0,13,210,0,0,48,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,
0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,4,0,0,2,4,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,
0,0,2,4,0,0,2,4,0,0,2,5,0,0,
239,0,0,1,0,0,15,439,0,0,0,0,0,1,0,
};


/*****************************************************************************/
/*  Funcion     : preext.pc                                                  */
/*  Descripcion : funciones y prototipos para facturacion de Conceptos Exter-*/
/*                ternos (Factura Miscelanea y Factura Compra)               */
/*  Autor       : Javier Garcia Paredes                                      */
/*  Fecha       : 17-04-97                                                   */
/*****************************************************************************/

#define _PREEXT_PC_
#define MISCELANEA	   18
#define NOTACRED	   25



#include <preext.h>

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


/*****************************************************************************/
/*                         funcion : bfnDBIFCompraMiscela                    */
/*****************************************************************************/
BOOL bfnDBIFCompraMiscela (long lNumProceso)
{
  static   int  i = 0  ;
  CONCEPTO stConcepto  ;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhNumProceso         ;
  static long   lhCodCliente         ;
  static int    ihCodConcepto        ;
  static long   lhColumna            ;
  static char   szhCodMoneda      [4];
                                 /* EXEC SQL VAR szhCodMoneda      IS STRING(4) ; */ 

  static int    ihCodProducto        ;
  static int    ihCodTipConce        ;
  static char   szhFecValor      [15];
                                 /* EXEC SQL VAR szhFecValor       IS STRING(15); */ 

  static char   szhFecEfectividad[15];
                                 /* EXEC SQL VAR szhFecEfectividad IS STRING(15); */ 

  static double dhImpConcepto        ;
  static char   szhCodRegion      [4];
                                 /* EXEC SQL VAR szhCodRegion      IS STRING(4) ; */ 

  static char   szhCodProvincia   [6];
                                 /* EXEC SQL VAR szhCodProvincia   IS STRING(6) ; */ 

  static char   szhCodCiudad      [6];
                                 /* EXEC SQL VAR szhCodCiudad      IS STRING(6) ; */ 

  static double dhImpMontoBase       ;
  static short  shIndFactur          ;
  static double dhImpFacturable      ;
  static char   szhCodModulo      [3];
                                 /* EXEC SQL VAR szhCodModulo      IS STRING(3) ; */ 

  static long   lhCodPlanCom         ;
  static int    ihCodCatImpos        ;
  static short  shIndEstado          ;
  static short  shIndSuperTel        ;
  static long   lhNumAbonado         ;
  static int    ihCodPortador        ;
  static char   szhDesConcepto   [61];
                                 /* EXEC SQL VAR szhDesConcepto    IS STRING(61); */ 

  static long   lhCodCiclFact        ;
  static char   szhNumTerminal   [16];
                                 /* EXEC SQL VAR szhNumTerminal    IS STRING(16); */ 

  static long   lhCapCode            ;
  static int    ihNumCuotas          ;
  static int    ihOrdCuota           ;
  static long   lhNumUnidades        ; /* Incorporado por PGonzaleg 4-03-2002 */
  static char   szhNumSerieMec   [26];
                                 /* EXEC SQL VAR szhNumSerieMec    IS STRING(26); */ 

  static char   szhNumSerieLe    [26];
                                 /* EXEC SQL VAR szhNumSerieLe     IS STRING(26); */ 

  static float  fhPrcImpuesto        ;
  static double dhValDto             ;
  static int    shTipDto             ;
  static int    ihMesGarantia        ;
  static char   szhNumGuia       [11];
                                 /* EXEC SQL VAR szhNumGuia        IS STRING(11); */ 

  static long   lhNumVenta           ;
  static long   lhNumTransaccion     ;
  static short  shIndAlta            ;
  static int    ihNumPaquete         ;
  static short  shFlagImpues         ;
  static short  shFlagDto            ;
  static int    ihCodConceRel        ;
  static long   lhColumnaRel         ;
  static short  shIndCuota           ;
  static int    iCodModVenta         ;

  static char    szFormatoFec[17];    /* EXEC SQL VAR szFormatoFec IS STRING(17); */ 


  static char   szhCodMonedaImp   [4];/* EXEC SQL VAR szhCodMonedaImp IS STRING(4); */ 
/*Incorporado por JJFigueroa 17-02-2005*/ 
  static double dhImpConversion      ;                                          /*Incorporado por JJFigueroa 17-02-2005*/
  static double dImpValunitario      ;                                          /*Incorporado por JJFigueroa 17-02-2005*/
  static char   szhGlsDescrip   [101];/* EXEC SQL VAR szhGlsDescrip IS STRING(101); */ 
/*Incorporado por JJFigueroa 17-02-2005*/
  

  static short  i_shIndCuota         ;
  static short  i_shNumCuotas        ;
  static short  i_shOrdCuota         ;
  static short  i_shNumUnidades      ;
  static short  i_shNumSerieMec      ;
  static short  i_shNumSerieLe       ;
  static short  i_shPrcImpuesto      ;
  static short  i_shValDto           ;
  static short  i_shTipDto           ;
  static short  i_shMesGarantia      ;
  static short  i_shNumGuia          ;
  static short  i_shIndAlta          ;
  static short  i_shNumPaquete       ;
  static short  i_shFlagImpues       ;
  static short  i_shFlagDto          ;
  static short  i_shCodConceRel      ;
  static short  i_shColumnaRel       ;
  static short  i_shSeqCuotas        ;
  static short  i_shIndEstado        ;
  static short  i_shCodTipConce      ;
  static short  i_shCodModulo        ;
  static short  i_shCodCiclFact      ;
  static short  i_shNumTerminal      ;
  static short  i_shCapCode          ;
  static short  i_shCodPlanCom       ;
  static short  i_shCodCatImpos      ;
  static short  i_shNumVenta         ;
  static short  i_shNumTransaccion   ;
  static short  i_shNumAbonado       ;
  static short  i_shIndSuperTel      ;
  static short  i_shCodModVenta      ;
  
  static short  i_shCodMonedaImp     ;/*Incorporado por JJFigueroa 17-02-2005*/ 
  static short  i_shImpConversion    ;/*Incorporado por JJFigueroa 17-02-2005*/
  static short  i_shImpValunitario   ;/*Incorporado por JJFigueroa 17-02-2005*/
  static short  i_shGlsDescripcion   ;/*Incorporado por JJFigueroa 17-02-2005*/

  
  /* EXEC SQL END DECLARE SECTION  ; */ 


  if (stProceso.iCodTipDocum == stDatosGener.iCodCompra)
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada Carga Conceptos Compra"
                   "\n\t\t=> Num.Proceso [%ld]",LOG04, lNumProceso);
  }
  else if (stProceso.iCodTipDocum == stDatosGener.iCodMiscela)
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada Carga Conceptos Miscelanea"
                   "\n\t\t=> Num.Proceso [%ld]",LOG04, lNumProceso);
  }

  strcpy(szFormatoFec,"YYYYMMDDHH24MISS");

  /* EXEC SQL DECLARE Cur_PreFactura CURSOR FOR
       SELECT /o+ index (FA_PREFACTURA FK_FA_PREFACTURA) o/
                   NUM_PROCESO    ,
                   COD_CLIENTE    ,
                   COD_CONCEPTO   ,
                   COLUMNA        ,
                   COD_PRODUCTO   ,
                   COD_MONEDA     ,
                   TO_CHAR (FEC_VALOR,:szFormatoFec)      ,
                   TO_CHAR (FEC_EFECTIVIDAD,:szFormatoFec),
                   IMP_CONCEPTO   ,
                   IMP_MONTOBASE  ,
                   IMP_FACTURABLE ,
                   COD_REGION     ,
                   COD_PROVINCIA  ,
                   COD_CIUDAD     ,
                   COD_MODULO     ,
                   COD_PLANCOM    ,
                   IND_FACTUR     ,
                   COD_CATIMPOS   ,
                   IND_ESTADO     ,
                   COD_TIPCONCE   ,
                   NUM_UNIDADES   ,
                   COD_CICLFACT   ,
                   COD_CONCEREL   ,
                   COLUMNA_REL    ,
                   NUM_ABONADO    ,
                   NUM_TERMINAL   ,
                   CAP_CODE       ,
                   NUM_SERIEMEC   ,
                   NUM_SERIELE    ,
                   FLAG_IMPUES    ,
                   FLAG_DTO       ,
                   PRC_IMPUESTO   ,
                   VAL_DTO        ,
                   TIP_DTO        ,
                   NUM_VENTA      ,
                   NUM_TRANSACCION,
                   MES_GARANTIA   ,
                   IND_ALTA       ,
                   IND_SUPERTEL   ,
                   NUM_PAQUETE    ,
                   IND_CUOTA      ,
                   NUM_CUOTAS     ,
                   ORD_CUOTA      ,
                   IND_MODVENTA	  ,
                   COD_MONEDAIMP  , /oIncorporado por JJFigueroa 17-02-2005o/
                   IMP_CONVERSION , /oIncorporado por JJFigueroa 17-02-2005o/
                   IMP_VALUNITARIO, /oIncorporado por JJFigueroa 17-02-2005o/
                   GLS_DESCRIP      /oIncorporado por JJFigueroa 17-02-2005o/
             FROM  FA_PREFACTURA
             WHERE NUM_PROCESO = :stProceso.lNumProceso; */ 


   /* EXEC SQL OPEN Cur_PreFactura; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 3;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0001;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )5;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[0] = (unsigned long )17;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szFormatoFec;
   sqlstm.sqhstl[1] = (unsigned long )17;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&(stProceso.lNumProceso);
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


   if (SQLCODE)
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=>Fa_PreFactura",
                szfnORAerror ());
   while (SQLCODE == SQLOK)
   {
          /* EXEC SQL FETCH Cur_PreFactura
               INTO :lhNumProceso     ,
                    :lhCodCliente     ,
                    :ihCodConcepto    ,
                    :lhColumna        ,
                    :ihCodProducto    ,
                    :szhCodMoneda     ,
                    :szhFecValor      ,
                    :szhFecEfectividad,
                    :dhImpConcepto    ,
                    :dhImpMontoBase   ,
                    :dhImpFacturable  ,
                    :szhCodRegion     ,
                    :szhCodProvincia  ,
                    :szhCodCiudad     ,
                    :szhCodModulo     ,
                    :lhCodPlanCom     ,
                    :shIndFactur      ,
                    :ihCodCatImpos    ,
                    :shIndEstado      :i_shIndEstado     ,
                    :ihCodTipConce    :i_shCodTipConce   ,
                    :lhNumUnidades    :i_shNumUnidades   , /o Incorporado por PGonzaleg 4-03-2002 o/
                    :lhCodCiclFact    :i_shCodCiclFact   ,
                    :ihCodConceRel    :i_shCodConceRel   ,
                    :lhColumnaRel     :i_shColumnaRel    ,
                    :lhNumAbonado     :i_shNumAbonado    ,
                    :szhNumTerminal   :i_shNumTerminal   ,
                    :lhCapCode        :i_shCapCode       ,
                    :szhNumSerieMec   :i_shNumSerieMec   ,
                    :szhNumSerieLe    :i_shNumSerieLe    ,
                    :shFlagImpues     :i_shFlagImpues    ,
                    :shFlagDto        :i_shFlagDto       ,
                    :fhPrcImpuesto    :i_shPrcImpuesto   ,
                    :dhValDto         :i_shValDto        ,
                    :shTipDto         :i_shTipDto        ,
                    :lhNumVenta       :i_shNumVenta      ,
                    :lhNumTransaccion :i_shNumTransaccion,
                    :ihMesGarantia    :i_shMesGarantia   ,
                    :shIndAlta        :i_shIndAlta       ,
                    :shIndSuperTel    :i_shIndSuperTel   ,
                    :ihNumPaquete     :i_shNumPaquete    ,
                    :shIndCuota       :i_shIndCuota      ,
                    :ihNumCuotas      :i_shNumCuotas     ,
                    :ihOrdCuota       :i_shOrdCuota      ,
                    :iCodModVenta     :i_shCodModVenta   ,
                    :szhCodMonedaImp  :i_shCodMonedaImp  , /o Incorporado por JJFigueroa 17-02-2005o/
                    :dhImpConversion  :i_shImpConversion , /o Incorporado por JJFigueroa 17-02-2005o/
                    :dImpValunitario  :i_shImpValunitario , /o Incorporado por JJFigueroa 17-02-2005o/
                    :szhGlsDescrip    :i_shGlsDescripcion ; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 48;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )32;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqfoff = (         int )0;
          sqlstm.sqfmod = (unsigned int )2;
          sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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
          sqlstm.sqhstv[2] = (unsigned char  *)&ihCodConcepto;
          sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[2] = (         int  )0;
          sqlstm.sqindv[2] = (         short *)0;
          sqlstm.sqinds[2] = (         int  )0;
          sqlstm.sqharm[2] = (unsigned long )0;
          sqlstm.sqadto[2] = (unsigned short )0;
          sqlstm.sqtdso[2] = (unsigned short )0;
          sqlstm.sqhstv[3] = (unsigned char  *)&lhColumna;
          sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[3] = (         int  )0;
          sqlstm.sqindv[3] = (         short *)0;
          sqlstm.sqinds[3] = (         int  )0;
          sqlstm.sqharm[3] = (unsigned long )0;
          sqlstm.sqadto[3] = (unsigned short )0;
          sqlstm.sqtdso[3] = (unsigned short )0;
          sqlstm.sqhstv[4] = (unsigned char  *)&ihCodProducto;
          sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[4] = (         int  )0;
          sqlstm.sqindv[4] = (         short *)0;
          sqlstm.sqinds[4] = (         int  )0;
          sqlstm.sqharm[4] = (unsigned long )0;
          sqlstm.sqadto[4] = (unsigned short )0;
          sqlstm.sqtdso[4] = (unsigned short )0;
          sqlstm.sqhstv[5] = (unsigned char  *)szhCodMoneda;
          sqlstm.sqhstl[5] = (unsigned long )4;
          sqlstm.sqhsts[5] = (         int  )0;
          sqlstm.sqindv[5] = (         short *)0;
          sqlstm.sqinds[5] = (         int  )0;
          sqlstm.sqharm[5] = (unsigned long )0;
          sqlstm.sqadto[5] = (unsigned short )0;
          sqlstm.sqtdso[5] = (unsigned short )0;
          sqlstm.sqhstv[6] = (unsigned char  *)szhFecValor;
          sqlstm.sqhstl[6] = (unsigned long )15;
          sqlstm.sqhsts[6] = (         int  )0;
          sqlstm.sqindv[6] = (         short *)0;
          sqlstm.sqinds[6] = (         int  )0;
          sqlstm.sqharm[6] = (unsigned long )0;
          sqlstm.sqadto[6] = (unsigned short )0;
          sqlstm.sqtdso[6] = (unsigned short )0;
          sqlstm.sqhstv[7] = (unsigned char  *)szhFecEfectividad;
          sqlstm.sqhstl[7] = (unsigned long )15;
          sqlstm.sqhsts[7] = (         int  )0;
          sqlstm.sqindv[7] = (         short *)0;
          sqlstm.sqinds[7] = (         int  )0;
          sqlstm.sqharm[7] = (unsigned long )0;
          sqlstm.sqadto[7] = (unsigned short )0;
          sqlstm.sqtdso[7] = (unsigned short )0;
          sqlstm.sqhstv[8] = (unsigned char  *)&dhImpConcepto;
          sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[8] = (         int  )0;
          sqlstm.sqindv[8] = (         short *)0;
          sqlstm.sqinds[8] = (         int  )0;
          sqlstm.sqharm[8] = (unsigned long )0;
          sqlstm.sqadto[8] = (unsigned short )0;
          sqlstm.sqtdso[8] = (unsigned short )0;
          sqlstm.sqhstv[9] = (unsigned char  *)&dhImpMontoBase;
          sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[9] = (         int  )0;
          sqlstm.sqindv[9] = (         short *)0;
          sqlstm.sqinds[9] = (         int  )0;
          sqlstm.sqharm[9] = (unsigned long )0;
          sqlstm.sqadto[9] = (unsigned short )0;
          sqlstm.sqtdso[9] = (unsigned short )0;
          sqlstm.sqhstv[10] = (unsigned char  *)&dhImpFacturable;
          sqlstm.sqhstl[10] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[10] = (         int  )0;
          sqlstm.sqindv[10] = (         short *)0;
          sqlstm.sqinds[10] = (         int  )0;
          sqlstm.sqharm[10] = (unsigned long )0;
          sqlstm.sqadto[10] = (unsigned short )0;
          sqlstm.sqtdso[10] = (unsigned short )0;
          sqlstm.sqhstv[11] = (unsigned char  *)szhCodRegion;
          sqlstm.sqhstl[11] = (unsigned long )4;
          sqlstm.sqhsts[11] = (         int  )0;
          sqlstm.sqindv[11] = (         short *)0;
          sqlstm.sqinds[11] = (         int  )0;
          sqlstm.sqharm[11] = (unsigned long )0;
          sqlstm.sqadto[11] = (unsigned short )0;
          sqlstm.sqtdso[11] = (unsigned short )0;
          sqlstm.sqhstv[12] = (unsigned char  *)szhCodProvincia;
          sqlstm.sqhstl[12] = (unsigned long )6;
          sqlstm.sqhsts[12] = (         int  )0;
          sqlstm.sqindv[12] = (         short *)0;
          sqlstm.sqinds[12] = (         int  )0;
          sqlstm.sqharm[12] = (unsigned long )0;
          sqlstm.sqadto[12] = (unsigned short )0;
          sqlstm.sqtdso[12] = (unsigned short )0;
          sqlstm.sqhstv[13] = (unsigned char  *)szhCodCiudad;
          sqlstm.sqhstl[13] = (unsigned long )6;
          sqlstm.sqhsts[13] = (         int  )0;
          sqlstm.sqindv[13] = (         short *)0;
          sqlstm.sqinds[13] = (         int  )0;
          sqlstm.sqharm[13] = (unsigned long )0;
          sqlstm.sqadto[13] = (unsigned short )0;
          sqlstm.sqtdso[13] = (unsigned short )0;
          sqlstm.sqhstv[14] = (unsigned char  *)szhCodModulo;
          sqlstm.sqhstl[14] = (unsigned long )3;
          sqlstm.sqhsts[14] = (         int  )0;
          sqlstm.sqindv[14] = (         short *)0;
          sqlstm.sqinds[14] = (         int  )0;
          sqlstm.sqharm[14] = (unsigned long )0;
          sqlstm.sqadto[14] = (unsigned short )0;
          sqlstm.sqtdso[14] = (unsigned short )0;
          sqlstm.sqhstv[15] = (unsigned char  *)&lhCodPlanCom;
          sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[15] = (         int  )0;
          sqlstm.sqindv[15] = (         short *)0;
          sqlstm.sqinds[15] = (         int  )0;
          sqlstm.sqharm[15] = (unsigned long )0;
          sqlstm.sqadto[15] = (unsigned short )0;
          sqlstm.sqtdso[15] = (unsigned short )0;
          sqlstm.sqhstv[16] = (unsigned char  *)&shIndFactur;
          sqlstm.sqhstl[16] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[16] = (         int  )0;
          sqlstm.sqindv[16] = (         short *)0;
          sqlstm.sqinds[16] = (         int  )0;
          sqlstm.sqharm[16] = (unsigned long )0;
          sqlstm.sqadto[16] = (unsigned short )0;
          sqlstm.sqtdso[16] = (unsigned short )0;
          sqlstm.sqhstv[17] = (unsigned char  *)&ihCodCatImpos;
          sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[17] = (         int  )0;
          sqlstm.sqindv[17] = (         short *)0;
          sqlstm.sqinds[17] = (         int  )0;
          sqlstm.sqharm[17] = (unsigned long )0;
          sqlstm.sqadto[17] = (unsigned short )0;
          sqlstm.sqtdso[17] = (unsigned short )0;
          sqlstm.sqhstv[18] = (unsigned char  *)&shIndEstado;
          sqlstm.sqhstl[18] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[18] = (         int  )0;
          sqlstm.sqindv[18] = (         short *)&i_shIndEstado;
          sqlstm.sqinds[18] = (         int  )0;
          sqlstm.sqharm[18] = (unsigned long )0;
          sqlstm.sqadto[18] = (unsigned short )0;
          sqlstm.sqtdso[18] = (unsigned short )0;
          sqlstm.sqhstv[19] = (unsigned char  *)&ihCodTipConce;
          sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[19] = (         int  )0;
          sqlstm.sqindv[19] = (         short *)&i_shCodTipConce;
          sqlstm.sqinds[19] = (         int  )0;
          sqlstm.sqharm[19] = (unsigned long )0;
          sqlstm.sqadto[19] = (unsigned short )0;
          sqlstm.sqtdso[19] = (unsigned short )0;
          sqlstm.sqhstv[20] = (unsigned char  *)&lhNumUnidades;
          sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[20] = (         int  )0;
          sqlstm.sqindv[20] = (         short *)&i_shNumUnidades;
          sqlstm.sqinds[20] = (         int  )0;
          sqlstm.sqharm[20] = (unsigned long )0;
          sqlstm.sqadto[20] = (unsigned short )0;
          sqlstm.sqtdso[20] = (unsigned short )0;
          sqlstm.sqhstv[21] = (unsigned char  *)&lhCodCiclFact;
          sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[21] = (         int  )0;
          sqlstm.sqindv[21] = (         short *)&i_shCodCiclFact;
          sqlstm.sqinds[21] = (         int  )0;
          sqlstm.sqharm[21] = (unsigned long )0;
          sqlstm.sqadto[21] = (unsigned short )0;
          sqlstm.sqtdso[21] = (unsigned short )0;
          sqlstm.sqhstv[22] = (unsigned char  *)&ihCodConceRel;
          sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[22] = (         int  )0;
          sqlstm.sqindv[22] = (         short *)&i_shCodConceRel;
          sqlstm.sqinds[22] = (         int  )0;
          sqlstm.sqharm[22] = (unsigned long )0;
          sqlstm.sqadto[22] = (unsigned short )0;
          sqlstm.sqtdso[22] = (unsigned short )0;
          sqlstm.sqhstv[23] = (unsigned char  *)&lhColumnaRel;
          sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[23] = (         int  )0;
          sqlstm.sqindv[23] = (         short *)&i_shColumnaRel;
          sqlstm.sqinds[23] = (         int  )0;
          sqlstm.sqharm[23] = (unsigned long )0;
          sqlstm.sqadto[23] = (unsigned short )0;
          sqlstm.sqtdso[23] = (unsigned short )0;
          sqlstm.sqhstv[24] = (unsigned char  *)&lhNumAbonado;
          sqlstm.sqhstl[24] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[24] = (         int  )0;
          sqlstm.sqindv[24] = (         short *)&i_shNumAbonado;
          sqlstm.sqinds[24] = (         int  )0;
          sqlstm.sqharm[24] = (unsigned long )0;
          sqlstm.sqadto[24] = (unsigned short )0;
          sqlstm.sqtdso[24] = (unsigned short )0;
          sqlstm.sqhstv[25] = (unsigned char  *)szhNumTerminal;
          sqlstm.sqhstl[25] = (unsigned long )16;
          sqlstm.sqhsts[25] = (         int  )0;
          sqlstm.sqindv[25] = (         short *)&i_shNumTerminal;
          sqlstm.sqinds[25] = (         int  )0;
          sqlstm.sqharm[25] = (unsigned long )0;
          sqlstm.sqadto[25] = (unsigned short )0;
          sqlstm.sqtdso[25] = (unsigned short )0;
          sqlstm.sqhstv[26] = (unsigned char  *)&lhCapCode;
          sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[26] = (         int  )0;
          sqlstm.sqindv[26] = (         short *)&i_shCapCode;
          sqlstm.sqinds[26] = (         int  )0;
          sqlstm.sqharm[26] = (unsigned long )0;
          sqlstm.sqadto[26] = (unsigned short )0;
          sqlstm.sqtdso[26] = (unsigned short )0;
          sqlstm.sqhstv[27] = (unsigned char  *)szhNumSerieMec;
          sqlstm.sqhstl[27] = (unsigned long )26;
          sqlstm.sqhsts[27] = (         int  )0;
          sqlstm.sqindv[27] = (         short *)&i_shNumSerieMec;
          sqlstm.sqinds[27] = (         int  )0;
          sqlstm.sqharm[27] = (unsigned long )0;
          sqlstm.sqadto[27] = (unsigned short )0;
          sqlstm.sqtdso[27] = (unsigned short )0;
          sqlstm.sqhstv[28] = (unsigned char  *)szhNumSerieLe;
          sqlstm.sqhstl[28] = (unsigned long )26;
          sqlstm.sqhsts[28] = (         int  )0;
          sqlstm.sqindv[28] = (         short *)&i_shNumSerieLe;
          sqlstm.sqinds[28] = (         int  )0;
          sqlstm.sqharm[28] = (unsigned long )0;
          sqlstm.sqadto[28] = (unsigned short )0;
          sqlstm.sqtdso[28] = (unsigned short )0;
          sqlstm.sqhstv[29] = (unsigned char  *)&shFlagImpues;
          sqlstm.sqhstl[29] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[29] = (         int  )0;
          sqlstm.sqindv[29] = (         short *)&i_shFlagImpues;
          sqlstm.sqinds[29] = (         int  )0;
          sqlstm.sqharm[29] = (unsigned long )0;
          sqlstm.sqadto[29] = (unsigned short )0;
          sqlstm.sqtdso[29] = (unsigned short )0;
          sqlstm.sqhstv[30] = (unsigned char  *)&shFlagDto;
          sqlstm.sqhstl[30] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[30] = (         int  )0;
          sqlstm.sqindv[30] = (         short *)&i_shFlagDto;
          sqlstm.sqinds[30] = (         int  )0;
          sqlstm.sqharm[30] = (unsigned long )0;
          sqlstm.sqadto[30] = (unsigned short )0;
          sqlstm.sqtdso[30] = (unsigned short )0;
          sqlstm.sqhstv[31] = (unsigned char  *)&fhPrcImpuesto;
          sqlstm.sqhstl[31] = (unsigned long )sizeof(float);
          sqlstm.sqhsts[31] = (         int  )0;
          sqlstm.sqindv[31] = (         short *)&i_shPrcImpuesto;
          sqlstm.sqinds[31] = (         int  )0;
          sqlstm.sqharm[31] = (unsigned long )0;
          sqlstm.sqadto[31] = (unsigned short )0;
          sqlstm.sqtdso[31] = (unsigned short )0;
          sqlstm.sqhstv[32] = (unsigned char  *)&dhValDto;
          sqlstm.sqhstl[32] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[32] = (         int  )0;
          sqlstm.sqindv[32] = (         short *)&i_shValDto;
          sqlstm.sqinds[32] = (         int  )0;
          sqlstm.sqharm[32] = (unsigned long )0;
          sqlstm.sqadto[32] = (unsigned short )0;
          sqlstm.sqtdso[32] = (unsigned short )0;
          sqlstm.sqhstv[33] = (unsigned char  *)&shTipDto;
          sqlstm.sqhstl[33] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[33] = (         int  )0;
          sqlstm.sqindv[33] = (         short *)&i_shTipDto;
          sqlstm.sqinds[33] = (         int  )0;
          sqlstm.sqharm[33] = (unsigned long )0;
          sqlstm.sqadto[33] = (unsigned short )0;
          sqlstm.sqtdso[33] = (unsigned short )0;
          sqlstm.sqhstv[34] = (unsigned char  *)&lhNumVenta;
          sqlstm.sqhstl[34] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[34] = (         int  )0;
          sqlstm.sqindv[34] = (         short *)&i_shNumVenta;
          sqlstm.sqinds[34] = (         int  )0;
          sqlstm.sqharm[34] = (unsigned long )0;
          sqlstm.sqadto[34] = (unsigned short )0;
          sqlstm.sqtdso[34] = (unsigned short )0;
          sqlstm.sqhstv[35] = (unsigned char  *)&lhNumTransaccion;
          sqlstm.sqhstl[35] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[35] = (         int  )0;
          sqlstm.sqindv[35] = (         short *)&i_shNumTransaccion;
          sqlstm.sqinds[35] = (         int  )0;
          sqlstm.sqharm[35] = (unsigned long )0;
          sqlstm.sqadto[35] = (unsigned short )0;
          sqlstm.sqtdso[35] = (unsigned short )0;
          sqlstm.sqhstv[36] = (unsigned char  *)&ihMesGarantia;
          sqlstm.sqhstl[36] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[36] = (         int  )0;
          sqlstm.sqindv[36] = (         short *)&i_shMesGarantia;
          sqlstm.sqinds[36] = (         int  )0;
          sqlstm.sqharm[36] = (unsigned long )0;
          sqlstm.sqadto[36] = (unsigned short )0;
          sqlstm.sqtdso[36] = (unsigned short )0;
          sqlstm.sqhstv[37] = (unsigned char  *)&shIndAlta;
          sqlstm.sqhstl[37] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[37] = (         int  )0;
          sqlstm.sqindv[37] = (         short *)&i_shIndAlta;
          sqlstm.sqinds[37] = (         int  )0;
          sqlstm.sqharm[37] = (unsigned long )0;
          sqlstm.sqadto[37] = (unsigned short )0;
          sqlstm.sqtdso[37] = (unsigned short )0;
          sqlstm.sqhstv[38] = (unsigned char  *)&shIndSuperTel;
          sqlstm.sqhstl[38] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[38] = (         int  )0;
          sqlstm.sqindv[38] = (         short *)&i_shIndSuperTel;
          sqlstm.sqinds[38] = (         int  )0;
          sqlstm.sqharm[38] = (unsigned long )0;
          sqlstm.sqadto[38] = (unsigned short )0;
          sqlstm.sqtdso[38] = (unsigned short )0;
          sqlstm.sqhstv[39] = (unsigned char  *)&ihNumPaquete;
          sqlstm.sqhstl[39] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[39] = (         int  )0;
          sqlstm.sqindv[39] = (         short *)&i_shNumPaquete;
          sqlstm.sqinds[39] = (         int  )0;
          sqlstm.sqharm[39] = (unsigned long )0;
          sqlstm.sqadto[39] = (unsigned short )0;
          sqlstm.sqtdso[39] = (unsigned short )0;
          sqlstm.sqhstv[40] = (unsigned char  *)&shIndCuota;
          sqlstm.sqhstl[40] = (unsigned long )sizeof(short);
          sqlstm.sqhsts[40] = (         int  )0;
          sqlstm.sqindv[40] = (         short *)&i_shIndCuota;
          sqlstm.sqinds[40] = (         int  )0;
          sqlstm.sqharm[40] = (unsigned long )0;
          sqlstm.sqadto[40] = (unsigned short )0;
          sqlstm.sqtdso[40] = (unsigned short )0;
          sqlstm.sqhstv[41] = (unsigned char  *)&ihNumCuotas;
          sqlstm.sqhstl[41] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[41] = (         int  )0;
          sqlstm.sqindv[41] = (         short *)&i_shNumCuotas;
          sqlstm.sqinds[41] = (         int  )0;
          sqlstm.sqharm[41] = (unsigned long )0;
          sqlstm.sqadto[41] = (unsigned short )0;
          sqlstm.sqtdso[41] = (unsigned short )0;
          sqlstm.sqhstv[42] = (unsigned char  *)&ihOrdCuota;
          sqlstm.sqhstl[42] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[42] = (         int  )0;
          sqlstm.sqindv[42] = (         short *)&i_shOrdCuota;
          sqlstm.sqinds[42] = (         int  )0;
          sqlstm.sqharm[42] = (unsigned long )0;
          sqlstm.sqadto[42] = (unsigned short )0;
          sqlstm.sqtdso[42] = (unsigned short )0;
          sqlstm.sqhstv[43] = (unsigned char  *)&iCodModVenta;
          sqlstm.sqhstl[43] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[43] = (         int  )0;
          sqlstm.sqindv[43] = (         short *)&i_shCodModVenta;
          sqlstm.sqinds[43] = (         int  )0;
          sqlstm.sqharm[43] = (unsigned long )0;
          sqlstm.sqadto[43] = (unsigned short )0;
          sqlstm.sqtdso[43] = (unsigned short )0;
          sqlstm.sqhstv[44] = (unsigned char  *)szhCodMonedaImp;
          sqlstm.sqhstl[44] = (unsigned long )4;
          sqlstm.sqhsts[44] = (         int  )0;
          sqlstm.sqindv[44] = (         short *)&i_shCodMonedaImp;
          sqlstm.sqinds[44] = (         int  )0;
          sqlstm.sqharm[44] = (unsigned long )0;
          sqlstm.sqadto[44] = (unsigned short )0;
          sqlstm.sqtdso[44] = (unsigned short )0;
          sqlstm.sqhstv[45] = (unsigned char  *)&dhImpConversion;
          sqlstm.sqhstl[45] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[45] = (         int  )0;
          sqlstm.sqindv[45] = (         short *)&i_shImpConversion;
          sqlstm.sqinds[45] = (         int  )0;
          sqlstm.sqharm[45] = (unsigned long )0;
          sqlstm.sqadto[45] = (unsigned short )0;
          sqlstm.sqtdso[45] = (unsigned short )0;
          sqlstm.sqhstv[46] = (unsigned char  *)&dImpValunitario;
          sqlstm.sqhstl[46] = (unsigned long )sizeof(double);
          sqlstm.sqhsts[46] = (         int  )0;
          sqlstm.sqindv[46] = (         short *)&i_shImpValunitario;
          sqlstm.sqinds[46] = (         int  )0;
          sqlstm.sqharm[46] = (unsigned long )0;
          sqlstm.sqadto[46] = (unsigned short )0;
          sqlstm.sqtdso[46] = (unsigned short )0;
          sqlstm.sqhstv[47] = (unsigned char  *)szhGlsDescrip;
          sqlstm.sqhstl[47] = (unsigned long )101;
          sqlstm.sqhsts[47] = (         int  )0;
          sqlstm.sqindv[47] = (         short *)&i_shGlsDescripcion;
          sqlstm.sqinds[47] = (         int  )0;
          sqlstm.sqharm[47] = (unsigned long )0;
          sqlstm.sqadto[47] = (unsigned short )0;
          sqlstm.sqtdso[47] = (unsigned short )0;
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

 /* Incorporado por JJFigueroa 17-02-2005*/                   
	

             if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
			iDError (szExeName,ERR000,vInsertarIncidencia
			 				  ,"Fetch=>Fa_PreFactura",szfnORAerror ());
             if (SQLCODE == SQLOK)
             {
                 i = stPreFactura.iNumRegistros;

                 stPreFactura.A_PFactura[i].lNumProceso  = lhNumProceso ;
                 stPreFactura.A_PFactura[i].lCodCliente  = lhCodCliente ;

                 if (stCliente.lCodCliente <= 0)
                 {
                     stCliente.lCodCliente = lhCodCliente;
				 	/* RAO110402: se carga el stcliente */
				 	if (!bfnGetDatosCliente (stCliente.lCodCliente))
       					return FALSE;
       					
       		 }
       		 
                 stPreFactura.A_PFactura[i].iCodConcepto = ihCodConcepto;
                 stPreFactura.A_PFactura[i].lColumna     = lhColumna    ;
                 stPreFactura.A_PFactura[i].iCodProducto = ihCodProducto;

                 memset (&stConcepto, 0, sizeof (CONCEPTO));
                 if (!bFindConcepto (ihCodConcepto, &stConcepto))
                      return FALSE;

                 strcpy (stPreFactura.A_PFactura[i].szDesConcepto   , stConcepto.szDesConcepto);
                 strcpy (stPreFactura.A_PFactura[i].szCodMoneda     , szhCodMoneda)            ;
                 strcpy (stPreFactura.A_PFactura[i].szFecValor      , szSysDate )              ;
                 strcpy (stPreFactura.A_PFactura[i].szFecEfectividad, szhFecEfectividad)       ;

                 stPreFactura.A_PFactura[i].dImpConcepto   = dhImpConcepto;
                 /* stPreFactura.A_PFactura.dImpFacturable[i] = fnCnvDouble (dhImpFacturable, USOFACT)  ; PPV 43878 08/10/2007 */
                 stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble (dhImpFacturable, 0)  ;
                 stPreFactura.A_PFactura[i].dImpMontoBase  = fnCnvDouble (dhImpMontoBase , USOFACT)  ;

                 strcpy (stPreFactura.A_PFactura[i].szCodRegion   ,
                         szhCodRegion   );
                 strcpy (stPreFactura.A_PFactura[i].szCodProvincia,
                         szhCodProvincia);
                 strcpy (stPreFactura.A_PFactura[i].szCodCiudad   ,
                         szhCodCiudad   );
                 strcpy (stPreFactura.A_PFactura[i].szCodModulo   ,
                         szhCodModulo   );

                 stPreFactura.A_PFactura[i].lCodPlanCom    = lhCodPlanCom ;
                 stPreFactura.A_PFactura[i].iIndFactur     = shIndFactur  ;
                 stPreFactura.A_PFactura[i].iCodCatImpos   = ihCodCatImpos;

                 if (stCliente.iCodCatImpos <= 0)
                     stCliente.iCodCatImpos = ihCodCatImpos;

                 stPreFactura.A_PFactura[i].iCodPortador   = ihCodPortador;
                 stPreFactura.A_PFactura[i].iIndEstado     =
                                   (i_shIndEstado  == -1)?-1:shIndEstado  ;
                 stPreFactura.A_PFactura[i].iCodTipConce   =
                                   (i_shCodTipConce== -1)?-1:ihCodTipConce;
                 stPreFactura.A_PFactura[i].lNumUnidades   =
                                   (i_shNumUnidades== -1)?-1:lhNumUnidades; /* Incorporado por PGonzaleg 4-03-2002 */
                 stPreFactura.A_PFactura[i].lCodCiclFact   =
                                   (i_shCodCiclFact== -1)?-1:lhCodCiclFact;
                 stPreFactura.A_PFactura[i].iCodConceRel   =
                                   (i_shCodConceRel== -1)?-1:ihCodConceRel;
                 stPreFactura.A_PFactura[i].lColumnaRel    =
                                   (i_shColumnaRel == -1)?-1:lhColumnaRel ;
                 stPreFactura.A_PFactura[i].lNumAbonado    =
                                   (i_shNumAbonado == -1)?-1:lhNumAbonado ;

                 strcpy (stPreFactura.A_PFactura[i].szNumTerminal ,
                         (i_shNumTerminal == -1)?"":szhNumTerminal);

                 stPreFactura.A_PFactura[i].lCapCode       =
                         (i_shCapCode    == -1)?-1:lhCapCode       ;

                 strcpy (stPreFactura.A_PFactura[i].szNumSerieMec ,
                         (i_shNumSerieMec == -1)?"":szhNumSerieMec);
                 strcpy (stPreFactura.A_PFactura[i].szNumSerieLe  ,
                         (i_shNumSerieLe  == -1)?"":szhNumSerieLe );

                 stPreFactura.A_PFactura[i].iFlagImpues    =
                        (i_shFlagImpues == -1)?0:shFlagImpues    ; /* rao XO-200607031158 */
                 stPreFactura.A_PFactura[i].iFlagDto       =
                         (i_shFlagDto    == -1)?-1:shFlagDto       ;
                 stPreFactura.A_PFactura[i].fPrcImpuesto   =
                         (i_shPrcImpuesto== -1)?-1:fhPrcImpuesto   ;
                 stPreFactura.A_PFactura[i].dValDto        =
                         (i_shValDto     == -1)?-1:dhValDto        ;
                 stPreFactura.A_PFactura[i].iTipDto        =
                         (i_shTipDto     == -1)?-1:shTipDto        ;
                 stPreFactura.A_PFactura[i].lNumVenta      =
                         (i_shNumVenta   == -1)?-1:lhNumVenta      ;

                 stPreFactura.A_PFactura[i].lNumTransaccion=
                         (i_shNumTransaccion == -1)?-1:lhNumTransaccion;

                 stPreFactura.A_PFactura[i].iMesGarantia   =
                         (i_shMesGarantia== -1)?-1:ihMesGarantia   ;

                 strcpy (stPreFactura.A_PFactura[i].szNumGuia ,
                         (i_shNumGuia == -1)?"":szhNumGuia)        ;

                 stPreFactura.A_PFactura[i].iIndAlta       =
                         (i_shIndAlta == -1)?-1:shIndAlta          ;
                 stPreFactura.A_PFactura[i].iIndSuperTel   =
                         (i_shIndSuperTel == -1)?-1:shIndSuperTel  ;
                 stPreFactura.A_PFactura[i].iNumPaquete    =
                         (i_shNumPaquete  == -1)?-1:ihNumPaquete   ;
                 stPreFactura.A_PFactura[i].iIndCuota      =
                         (i_shIndCuota    == -1)?-1:shIndCuota     ;
                 stPreFactura.A_PFactura[i].iNumCuotas     =
                         (i_shNumCuotas   == -1)?-1:ihNumCuotas    ;
                 stPreFactura.A_PFactura[i].iOrdCuota      =
                         (i_shOrdCuota    == -1)?-1:ihOrdCuota     ;

                 /**********************************************************/
                 /* Recogemos Informacion para la Cabecera del Documento   */
                 /**********************************************************/
                 if (stPreFactura.A_PFactura[i].iIndSuperTel  == 1 &&
                     stCliente.iIndSuperTel                   <  1 )
                 {
                     stCliente.iIndSuperTel = 1;
                 }
                 if (stPreFactura.A_PFactura[i].iIndCuota  == 1 &&
                     stCliente.iIndCredito                 <  1)
                 {
                     stCliente.iIndCredito = 1;
                 }
                 /*******************************************************************************/
                 /*    13.05.1999.  Mauricio Villagra .  Se Agrego Campo a stPreFactura         */
                 /*  en StFactur.h  "iCodModVenta" para marcar facturas Miscelaneas de Regalo   */
                 /*******************************************************************************/
                 if (i_shCodModVenta != ORA_NULL && iCodModVenta == 0)
                 {
                     stPreFactura.iCodModVenta=iREGALO;
                 }
                         
	         /*INICIO Incorporado por JJFigueroa 17-02-2005*/
	         
                 strcpy (stPreFactura.A_PFactura[i].szhCodMonedaImp ,
                         (i_shCodMonedaImp == -1)?"":szhCodMonedaImp); 
                 stPreFactura.A_PFactura[i].dhImpConversion     =  dhImpConversion;
                 stPreFactura.A_PFactura[i].dImpValunitario     =  dImpValunitario;                 
                 strcpy (stPreFactura.A_PFactura[i].szhGlsDescrip ,szhGlsDescrip); 

                vDTrazasLog (szExeName,"\n\t\t* [Preext]CodMonedaImp  [%s]"
									   "\n\t\t* [Preext]ImpConversion [%f]"
                 					   "\n\t\t* [Preext]ImpValunitario[%f]"
                 					   "\n\t\t* [Preext]GlsDescrip    [%s]"
                 					   ,LOG05, stPreFactura.A_PFactura[i].szhCodMonedaImp
                 					   , stPreFactura.A_PFactura[i].dhImpConversion
                 					   , stPreFactura.A_PFactura[i].dImpValunitario
                 					   , stPreFactura.A_PFactura[i].szhGlsDescrip);       
                 /********************************************************************/
	         /*  Documentos NOTACRED o MISELANEA para Roaming                    */
	         /********************************************************************/

	        if ((stProceso.iCodTipDocum != NOTACRED) && (stProceso.iCodTipDocum != MISCELANEA))    
	        {
	        	strcpy(stDatosGener.szCodMoneFact,stPreFactura.A_PFactura[i].szhCodMonedaImp);
	        	stPreFactura.A_PFactura[i].dhImpConversion = 1;	   	
	        }
                 /*FIN    Incorporado por JJFigueroa 17-02-2005*/
                 
                 /* stPreFactura.iNumRegistros++; */
                 if(bfnIncrementarIndicePreFactura()==FALSE)
                 {
                     vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                     vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                     return FALSE;
                 }


             }/* fin sqlok ... */

   }/* fin while ... */
   if (SQLCODE == SQLNOTFOUND)
   {
       /* EXEC SQL CLOSE Cur_PreFactura; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 48;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )239;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


       if (SQLCODE)
           iDError (szExeName,ERR000,vInsertarIncidencia,
                    "Close=>Fa_PreFactura",szfnORAerror ());
   }
   	vDTrazasLog (szExeName,"\n\t\t* Numero de Conceptos de la Factura [%d]"
   						  , LOG03, stPreFactura.iNumRegistros);

   if (stPreFactura.iNumRegistros > 0)
       strcpy (szSysDate, stPreFactura.A_PFactura[0].szFecValor );

   return (SQLCODE != SQLOK)?FALSE:TRUE;
}/*************************** Final bfnDBIFCompraMiscela *********************/

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

