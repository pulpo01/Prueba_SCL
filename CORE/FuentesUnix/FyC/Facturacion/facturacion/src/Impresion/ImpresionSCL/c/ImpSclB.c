
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
static const struct sqlcxp sqlfpn =
{
    15,
    "./pc/ImpSclB.pc"
};


static unsigned int sqlctx = 1728651;


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
   unsigned char  *sqhstv[45];
   unsigned long  sqhstl[45];
            int   sqhsts[45];
            short *sqindv[45];
            int   sqinds[45];
   unsigned long  sqharm[45];
   unsigned long  *sqharc[45];
   unsigned short  sqadto[45];
   unsigned short  sqtdso[45];
} sqlstm = {12,45};

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

 static const char *sq0002 = 
"select USU.NUM_IDENT ,DIR.NOM_CALLE ,DIR.NUM_CALLE ,DIR.NUM_PISO ,COM.DES_CO\
MUNA ,CIU.DES_CIUDAD ,DIR.ZIP ,PAIS.DES_PAIS ,NVL(EST.DES_ESTADO,'NO REGISTRA'\
) ,NVL(PUE.DES_PUEBLO,'NO REGISTRA')  from GA_DIRECUSUAR DIREC ,GE_CIUDADES CI\
U ,GE_COMUNAS COM ,GE_DIRECCIONES DIR ,GA_ABOCEL ABON ,GE_DATOSGENER GENER ,GE\
_PAISES PAIS ,GE_ESTADOS EST ,GE_PUEBLOS PUE ,GA_USUARIOS USU where ((((((((((\
(((ABON.NUM_ABONADO=:b0 and DIREC.COD_USUARIO=ABON.COD_USUARIO) and DIREC.COD_\
TIPDIRECCION='2') and DIR.COD_DIRECCION=DIREC.COD_DIRECCION) and CIU.COD_REGIO\
N=DIR.COD_REGION) and CIU.COD_PROVINCIA=DIR.COD_PROVINCIA) and CIU.COD_CIUDAD=\
DIR.COD_CIUDAD) and DIR.COD_REGION=COM.COD_REGION) and DIR.COD_PROVINCIA=COM.C\
OD_PROVINCIA) and DIR.COD_COMUNA=COM.COD_COMUNA) and GENER.COD_PAIS=PAIS.COD_P\
AIS) and DIR.COD_ESTADO=EST.COD_ESTADO(+)) and DIR.COD_PUEBLO=PUE.COD_PUEBLO(+\
)) and USU.COD_USUARIO=ABON.COD_USUARIO)           ";

 static const char *sq0001 = 
"select A.rowid  ,A.COD_CLIENTE ,A.COD_CONCEPTO ,A.NUM_CUOTA ,A.SEC_CUOTA ,A.\
MTO_CUOTA ,NVL(A.NUM_FOLIO,0) ,NUM_FOLIOCTC ,TO_CHAR(A.FEC_COMPRA,'YYYYMMDD') \
,A.IND_FACTURADO ,UPPER(B.DES_TIPDOCUM) ,TO_CHAR(A.FEC_VENCIMIE,'YYYYMMDD') ,A\
.PREF_PLAZA ,A.NUM_ABONADO  from GE_TIPDOCUMEN B ,FA_CUOTCREDITO A ,FA_CICLFAC\
T C where (((A.COD_CLIENTE=:b0 and C.COD_CICLFACT=:b1) and A.COD_TIPDOCUM=B.CO\
D_TIPDOCUM) and A.FEC_COMPRA<=C.FEC_EMISION) order by A.NUM_FOLIO,A.FEC_VENCIM\
IE,A.IND_FACTURADO,A.NUM_SECUENCI,A.COD_TIPDOCUM,A.COLUMNA,A.SEC_CUOTA,A.NUM_C\
UOTA            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,3,0,0,17,502,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,3,0,0,45,521,0,0,5,5,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,0,
59,0,0,3,0,0,13,541,0,0,45,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,97,
0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
2,3,0,0,2,4,0,0,
254,0,0,3,0,0,15,611,0,0,0,0,0,1,0,
269,0,0,4,139,0,5,712,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
304,0,0,5,77,0,5,725,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,5,0,0,
331,0,0,6,139,0,5,765,0,0,5,5,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
366,0,0,7,0,0,29,796,0,0,0,0,0,1,0,
381,0,0,2,907,0,9,1592,0,0,1,1,0,1,0,1,3,0,0,
400,0,0,2,0,0,13,1599,0,0,10,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
455,0,0,8,98,0,2,2092,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,3,0,0,
482,0,0,9,248,0,3,2132,0,0,7,7,0,1,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,3,0,0,
525,0,0,10,83,0,4,2759,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
548,0,0,1,560,0,9,2866,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
571,0,0,1,0,0,13,2875,0,0,14,0,0,1,0,2,9,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
4,0,0,2,3,0,0,2,9,0,0,2,9,0,0,2,3,0,0,2,9,0,0,2,9,0,0,2,5,0,0,2,3,0,0,
642,0,0,1,0,0,15,2936,0,0,0,0,0,1,0,
657,0,0,11,609,0,4,2999,0,0,14,1,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,1,3,
0,0,
728,0,0,12,147,0,4,3036,0,0,3,2,0,1,0,2,97,0,0,1,3,0,0,1,97,0,0,
};


/*  Version  FAC_DES_MAS ImpSclB.pc  7.000   */
#include <ImpSclB.h>

/* VARIABLES GLOBALES */
long   glDuracion;
double gdMonto;
int    iSWdisgregado;

/*     EXEC SQL INCLUDE sqlca;
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

         long lhCodClienteCur;
         int  ihBValorCero =0;
         long lhNumAbonado;
         long lhCodCiclFactCur;
    /* EXEC SQL END DECLARE SECTION; */ 


/*                                            */
/*       Declaracion de Cursores              */
/*                                            */

    /* EXEC SQL DECLARE Cursor_Cuotas CURSOR FOR
         SELECT  A.ROWID         ,
                 A.COD_CLIENTE   ,
                 A.COD_CONCEPTO  ,
                 A.NUM_CUOTA     ,
                 A.SEC_CUOTA     ,
                 A.MTO_CUOTA     ,
                 NVL(A.NUM_FOLIO,0)  ,
                 NUM_FOLIOCTC        ,
                 TO_CHAR(A.FEC_COMPRA,'YYYYMMDD'),
                 A.IND_FACTURADO,
                 UPPER(B.DES_TIPDOCUM),
                 TO_CHAR(A.FEC_VENCIMIE,'YYYYMMDD'),
                 A.PREF_PLAZA,
                 A.NUM_ABONADO
         FROM    GE_TIPDOCUMEN B ,
                 FA_CUOTCREDITO A,
                 FA_CICLFACT C
         WHERE   A.COD_CLIENTE  = :lhCodClienteCur
         AND     C.COD_CICLFACT  = :lhCodCiclFactCur
         AND     A.COD_TIPDOCUM  = B.COD_TIPDOCUM
         AND     A.FEC_COMPRA   <= C.FEC_EMISION
         ORDER BY A.NUM_FOLIO,
                  A.FEC_VENCIMIE  ,
                  A.IND_FACTURADO ,
                  A.NUM_SECUENCI  ,
                  A.COD_TIPDOCUM  ,
                  A.COLUMNA   ,
                  A.SEC_CUOTA,
                  A.NUM_CUOTA ; */ 


    /* EXEC SQL DECLARE Cursor_GetDireccion CURSOR FOR
         SELECT USU.NUM_IDENT,  DIR.NOM_CALLE , DIR.NUM_CALLE , DIR.NUM_PISO , COM.DES_COMUNA ,
                CIU.DES_CIUDAD , DIR.ZIP , PAIS.DES_PAIS, NVL(EST.DES_ESTADO,'NO REGISTRA'),
                NVL(PUE.DES_PUEBLO,'NO REGISTRA')
         FROM   GA_DIRECUSUAR DIREC ,GE_CIUDADES CIU ,GE_COMUNAS COM ,GE_DIRECCIONES DIR, GA_ABOCEL ABON,
                GE_DATOSGENER GENER, GE_PAISES PAIS, GE_ESTADOS EST, GE_PUEBLOS PUE, GA_USUARIOS USU
         WHERE  ABON.NUM_ABONADO        = :lhNumAbonado
         AND    DIREC.COD_USUARIO       = ABON.COD_USUARIO
         AND    DIREC.COD_TIPDIRECCION  = '2'
         AND    DIR.COD_DIRECCION       = DIREC.COD_DIRECCION
         AND    CIU.COD_REGION          = DIR.COD_REGION
         AND    CIU.COD_PROVINCIA       = DIR.COD_PROVINCIA
         AND    CIU.COD_CIUDAD          = DIR.COD_CIUDAD
         AND    DIR.COD_REGION          = COM.COD_REGION
         AND    DIR.COD_PROVINCIA       = COM.COD_PROVINCIA
         AND    DIR.COD_COMUNA          = COM.COD_COMUNA
         AND    GENER.COD_PAIS          = PAIS.COD_PAIS
         AND    DIR.COD_ESTADO          = EST.COD_ESTADO (+)
         AND    DIR.COD_PUEBLO          = PUE.COD_PUEBLO (+)
         AND    USU.COD_USUARIO         = ABON.COD_USUARIO; */ 


/*****************************************************************************/
/*  Funcion para cargar Folio CtC                                            */
/*****************************************************************************/
int CargaFolioCtc ( ST_FACTCLIE      *pstFactDocuClie, 
                    ST_CUOTAS        *pstFaCuotas,  
                    STSALDO_ANTERIOR *pstSaldoAnt)
{
    long lFechaSaldoAnt=0;
    long lFechaCuotasVe=0;
    long lFechaCuotasPv=0;

    strcpy (szModulo, "CargaFolioCtc");
    vDTrazasLog  ("","\n\t** Entrando a %s **"
                     "\n\t=> szNumCtc       [%s]"
                     "\n\t=> dTotFactura    [%f]"
                     ,LOG04,szModulo,pstFactDocuClie->szNumCtc, pstFactDocuClie->dTotFactura);

    if(pstFactDocuClie->dTotFactura == 0)
    {
        if((pstSaldoAnt->iNum_RegSaldo > 0) || (pstFaCuotas->iNum_RegCuotas_venci > 0) || (pstFaCuotas->iNum_RegCuotas_pven > 0))
        {
            lFechaSaldoAnt = (pstSaldoAnt->iNum_RegSaldo > 0   ? atol(pstSaldoAnt->stReg[pstSaldoAnt->iNum_RegSaldo-1].szFechaEfectiva) : 0);
            lFechaCuotasVe = (pstFaCuotas->iNum_RegCuotas_venci > 0 ? atol(pstFaCuotas->stReg_venci[pstFaCuotas->iNum_RegCuotas_venci-1].szFechaEfectiva) : 0);
            lFechaCuotasPv = (pstFaCuotas->iNum_RegCuotas_pven  > 0? atol(pstFaCuotas->stReg_pven[pstFaCuotas->iNum_RegCuotas_pven-1].szFechaEfectiva) : 0);

            vDTrazasLog(szModulo, "\tlFechaSaldoAnt: [%ld]"
                                  "\tlFechaCuotasVe: [%ld]"
                                  "\tlFechaCuotasPv: [%ld]",LOG04,
                                  lFechaSaldoAnt,
                                  lFechaCuotasVe,
                                  lFechaCuotasPv);

            if(lFechaSaldoAnt >= lFechaCuotasVe )
            {
                sprintf(pstFactDocuClie->szNumCtcPago,"%s\0", pstSaldoAnt->stReg[pstSaldoAnt->iNum_RegSaldo-1].szNum_FolioCtc);
                vDTrazasLog(szModulo,"\tNumCtcPago de Saldo Ant.: [%s]",LOG04,pstFactDocuClie->szNumCtcPago);
            }
            else
            {
                if(lFechaCuotasVe > lFechaSaldoAnt )
                {
                    sprintf(pstFactDocuClie->szNumCtcPago,"%s\0", pstFaCuotas->stReg_venci[pstFaCuotas->iNum_RegCuotas_venci-1].szNum_FolioCtc);
                    vDTrazasLog(szModulo,"\tNumCtcPago de Cuotas Ven.: [%s]",LOG04,pstFactDocuClie->szNumCtcPago);
                }
            }
            if((lFechaCuotasVe == 0) && (lFechaSaldoAnt == 0) && (lFechaCuotasPv  > 0 ))
            {
                sprintf(pstFactDocuClie->szNumCtcPago,"%s\0", pstFaCuotas->stReg_pven[pstFaCuotas->iNum_RegCuotas_pven-1].szNum_FolioCtc);
                vDTrazasLog(szModulo,"\tNumCtcPago de Cuotas P.V.: [%s]",LOG04,pstFactDocuClie->szNumCtcPago);
            }
            if(strcmp(pstFactDocuClie->szNumCtcPago," ")!=0)
            {
                sprintf(pstFactDocuClie->szNumCtc,"%s\0", pstFactDocuClie->szNumCtcPago);
            }
        }
    }
    return (TRUE);
}

/****************************************************************************/
/* FUNCION     : bfnCargaConcTrafico (FACTDOC *stHistD)                     */
/* DESCRIPCION : Crea cursor con conceptos de trafico facturado por abonado */
/* luego para cada abonado genera un registro por Abonado que contiene los  */
/* datos por abonado : Num.Celular, indicadores de tablas de tarfico y      */
/* totales facturados                                                       */
/****************************************************************************/
int CargaConceptosDelCliente (ST_FACTCLIE    *pstFactDocuClie,
                              LINEACOMANDO   *pstLineaComando,
                              ST_INFGENERAL  *pstInfGeneral,
                              DETALLEOPER    *pstDetallOper)
{
    int                iSqlCodeConceptos ;
    char               szCodSubGrup [11];
    GRPMULTIIDIOMA     pstIdiomaAux;
    ST_DETCONSUMO_HOST pstFaDetConsumoHosts;
    int                rc = 0;
    long               lNumFilas;
    long               lNumAboAnte = 0L;
    STDETCONSUMO       *stDetConsumoTemp;
    ST_ORDEN           *stOrden2DetConsumoTemp;
    register long      lCont = 0;

    strcpy (szModulo, "CargaConceptosDelCliente");
    vDTrazasLog(szModulo,"\t**IndOrdenTotal  [%ld]",LOG04, pstFactDocuClie->lIndOrdenTotal);

    /************************************************************************************/
    /*    Recupera Conceptos de Trafico de la Factura Identificando el Tipo de Trafico  */
    /************************************************************************************/
   
    iSqlCodeConceptos = OpenConceptos(pstFactDocuClie->lIndOrdenTotal,pstLineaComando->lCodCiclFact,pstInfGeneral->szCOD_SERVICIO,pstDetallOper->iCodFormulario,pstDetallOper, pstFactDocuClie->iCodTipDocum);
    
    if(iSqlCodeConceptos != SQLOK) return (FALSE);

    while (rc != SQLNOTFOUND)
    {
        
        rc = FetchConceptos(&pstFaDetConsumoHosts,&lNumFilas);
        
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        return FALSE;

        if (!lNumFilas)
            break;
        /* estructura global de detalle de conceptos */
        
        stFaDetCons.stDetConsumo =(STDETCONSUMO*) realloc(stFaDetCons.stDetConsumo,(((stFaDetCons.iNumReg)+lNumFilas)*sizeof(STDETCONSUMO)));
        
        if (!stFaDetCons.stDetConsumo)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error CargaConceptosDelCliente", "no se pudo reservar memoria");
            return FALSE;
        }
        
        stDetConsumoTemp = &(stFaDetCons.stDetConsumo)[(stFaDetCons.iNumReg)];
        
        
        memset(stDetConsumoTemp, 0, sizeof(STDETCONSUMO)*lNumFilas);

		/* estructura de orden alterno */
		
        stOrden2DetConsumo.stOrden =(ST_ORDEN*) realloc(stOrden2DetConsumo.stOrden,(((stOrden2DetConsumo.iNumRegs)+lNumFilas)*sizeof(ST_ORDEN)));
       
        if (!stOrden2DetConsumo.stOrden)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error CargaConceptosDelCliente", "no se pudo reservar memoria");
            return FALSE;
        }
        
        stOrden2DetConsumoTemp = &(stOrden2DetConsumo.stOrden)[(stOrden2DetConsumo.iNumRegs)];
        
        memset(stOrden2DetConsumoTemp, 0, sizeof(ST_ORDEN)*lNumFilas);

        for (lCont = 0 ; lCont < lNumFilas ; lCont++)
        {
            stDetConsumoTemp[lCont].iNum_OrdenGr               = pstFaDetConsumoHosts.iNum_OrdenGr[lCont] ;
            stDetConsumoTemp[lCont].iNum_OrdenConc             = pstFaDetConsumoHosts.iNum_OrdenConc[lCont];
            stDetConsumoTemp[lCont].iCodGrupo                  = pstFaDetConsumoHosts.iCodGrupo[lCont];
            strcpy(stDetConsumoTemp[lCont].szGlosaGrupo        , pstFaDetConsumoHosts.szGlosaGrupo[lCont]);
            stDetConsumoTemp[lCont].iNum_OrdenSubGr            = pstFaDetConsumoHosts.iNum_OrdenSubGr[lCont];
            stDetConsumoTemp[lCont].iCodSubGrupo               = pstFaDetConsumoHosts.iCodSubGrupo[lCont];
            strcpy(stDetConsumoTemp[lCont].szGlosaSubGrupo     ,pstFaDetConsumoHosts.szGlosaSubGrupo[lCont]);
            stDetConsumoTemp[lCont].iCod_TipSubGrupo           = pstFaDetConsumoHosts.iCod_TipSubGrupo[lCont];
            stDetConsumoTemp[lCont].lNumAbonado                = pstFaDetConsumoHosts.lNumAbonado [lCont];
            stDetConsumoTemp[lCont].iCod_Producto              = pstFaDetConsumoHosts.iCod_Producto[lCont];
            stDetConsumoTemp[lCont].iCodConcepto               = pstFaDetConsumoHosts.iCodConcepto[lCont];
            stDetConsumoTemp[lCont].iColumna                   = pstFaDetConsumoHosts.iColumna[lCont];
            strcpy(stDetConsumoTemp[lCont].szDes_Concepto      , pstFaDetConsumoHosts.szDes_Concepto[lCont]);
            stDetConsumoTemp[lCont].iCodTipConce               = pstFaDetConsumoHosts.iCodTipConce[lCont];
            stDetConsumoTemp[lCont].lSeg_Consumo               = pstFaDetConsumoHosts.lSeg_Consumo[lCont];
            stDetConsumoTemp[lCont].iNum_Unidades              = pstFaDetConsumoHosts.iNum_Unidades[lCont];
            stDetConsumoTemp[lCont].dTotalFacturableNet        = pstFaDetConsumoHosts.dTotalFacturableNet[lCont];
            stDetConsumoTemp[lCont].dTotalFacturableImp        = pstFaDetConsumoHosts.dTotalFacturableImp[lCont];
            strcpy(stDetConsumoTemp[lCont].szNum_Celular       , pstFaDetConsumoHosts.szNum_Celular[lCont]);
            strcpy(stDetConsumoTemp[lCont].szCod_Nivel         , pstFaDetConsumoHosts.szCod_Nivel [lCont] )      ;
            strcpy(stDetConsumoTemp[lCont].szFec_Pago          , pstFaDetConsumoHosts.szFec_Pago  [lCont] )      ;
            strcpy(stDetConsumoTemp[lCont].szCod_CargoBasico   , pstFaDetConsumoHosts.szCod_CargoBasico[lCont] ) ;
            strcpy(stDetConsumoTemp[lCont].szTip_ConcNoFact    , pstFaDetConsumoHosts.szTip_ConcNoFact [lCont] ) ;
            strcpy(stDetConsumoTemp[lCont].szCod_PlanTarif     , pstFaDetConsumoHosts.szCod_PlanTarif  [lCont] ) ;
            strcpy(stDetConsumoTemp[lCont].szFec_FinContrato   , pstFaDetConsumoHosts.szFec_FinContrato[lCont] ) ;
            stDetConsumoTemp[lCont].lSeg_ConsumoReal           = pstFaDetConsumoHosts.lSeg_ConsumoReal     [lCont];
            stDetConsumoTemp[lCont].lSeg_ConsumoDcto           = pstFaDetConsumoHosts.lSeg_ConsumoDcto     [lCont];
            stDetConsumoTemp[lCont].dTotalFacturableReal       = pstFaDetConsumoHosts.dTotalFacturableReal [lCont];
            stDetConsumoTemp[lCont].dTotalFacturableDcto       = pstFaDetConsumoHosts.dTotalFacturableDcto [lCont];
            stDetConsumoTemp[lCont].lCntLlamReal               = pstFaDetConsumoHosts.lCntLlamReal         [lCont];
            stDetConsumoTemp[lCont].lCntLlamDcto               = pstFaDetConsumoHosts.lCntLlamDcto         [lCont];
            stDetConsumoTemp[lCont].lCntLlamFAct               = pstFaDetConsumoHosts.lCntLlamFAct         [lCont];
            stDetConsumoTemp[lCont].dImpValUnitario            = pstFaDetConsumoHosts.dImpValUnitario      [lCont];
            strcpy(stDetConsumoTemp[lCont].szGlsDescrip        , pstFaDetConsumoHosts.szGlsDescrip         [lCont]);
            stDetConsumoTemp[lCont].iCodConcerel               = pstFaDetConsumoHosts.iCodConcerel         [lCont];
            stDetConsumoTemp[lCont].iColumnaRel                = pstFaDetConsumoHosts.iColumnaRel          [lCont];
            stDetConsumoTemp[lCont].dPrcImpuesto               = pstFaDetConsumoHosts.dPrcImpuesto         [lCont];
            stDetConsumoTemp[lCont].dImpMontoBase              = pstFaDetConsumoHosts.dImpMontoBase        [lCont];
            stDetConsumoTemp[lCont].iTipConcep                 = pstFaDetConsumoHosts.iTipConcep           [lCont];
            stDetConsumoTemp[lCont].iNivelImpresion            = pstFaDetConsumoHosts.iNivelImpresion      [lCont];
            strcpy(stDetConsumoTemp[lCont].szTipUnidad         , pstFaDetConsumoHosts.szTipUnidad          [lCont]);
            strcpy(stDetConsumoTemp[lCont].szTipGrupo          , pstFaDetConsumoHosts.szTipGrupo           [lCont]);
            stDetConsumoTemp[lCont].lNumVenta                  = pstFaDetConsumoHosts.lNumVenta            [lCont];
            stDetConsumoTemp[lCont].lNumPulsos                 = pstFaDetConsumoHosts.lNumPulsos           [lCont];
            stDetConsumoTemp[lCont].dImpFactConIva             = pstFaDetConsumoHosts.dImpFactConIva       [lCont]; /* P-MIX-09003 77 */          
            
            if(  bfnFindCodImptoFact(pstFaDetConsumoHosts.iCodConcepto[lCont]))                  
            {
                 stFaDetCons.dGravFactura  += pstFaDetConsumoHosts.dTotalFacturableNet[lCont];   
            }            
                        
            if ( stDetConsumoTemp[lCont].lNumAbonado > 0 &&                                     
                 stDetConsumoTemp[lCont].iCodConcepto == iCodAbonoCel && 
                 stDetConsumoTemp[lCont].lNumAbonado  != lNumAboAnte )
            {
                lNumAboAnte = stDetConsumoTemp[lCont].lNumAbonado ;
                stFaDetCons.lNumTerminales++;
            }                                                                                    
                                                            
            sprintf(stOrden2DetConsumoTemp[lCont].szKey, "%05d|%05d|%05d|%05d|%05d",
                    stDetConsumoTemp[lCont].iNum_OrdenGr,
                    stDetConsumoTemp[lCont].iNum_OrdenSubGr,
                    stDetConsumoTemp[lCont].iNum_OrdenConc,
                    stDetConsumoTemp[lCont].iCodGrupo,
                    stDetConsumoTemp[lCont].iCodConcepto);
            stOrden2DetConsumoTemp[lCont].iPosicion = stFaDetCons.iNumReg + lCont;
        }
        
        stFaDetCons.iNumReg += lNumFilas;
        stOrden2DetConsumo.iNumRegs += lNumFilas;

    }/* fin while */

    if(!CloseConceptos()) return (FALSE);

    vDTrazasLog(szModulo,"\t====> Cantidad de Conceptos por Cliente [%d]\n"
                         "\tIdioma Operadora [%s] Idioma Cliente [%s]"
                         ,LOG04,stFaDetCons.iNumReg,pstInfGeneral->szIdiomaOper,pstFactDocuClie->szCod_Idioma);

    if(strcmp(pstInfGeneral->szIdiomaOper,pstFactDocuClie->szCod_Idioma) != 0)
    {
        for(lCont=0;lCont<stFaDetCons.iNumReg;lCont++)
        {
            sprintf(szCodSubGrup,"%04d%s",stFaDetCons.stDetConsumo[lCont].iCodSubGrupo,pstFactDocuClie->szCod_Idioma);
            vDTrazasLog("","concepto [%s]",LOG04,szCodSubGrup);
            if (BuscaMultiIdiomas(szCodSubGrup,&pstIdiomaAux) )
            {
                strcpy(stFaDetCons.stDetConsumo[lCont].szGlosaGrupo,pstIdiomaAux.szGlosa_Grupo);
                strcpy(stFaDetCons.stDetConsumo[lCont].szGlosaSubGrupo,pstIdiomaAux.szGlosa_Subgrp);
            }
            else
            {
                vDTrazasError(szModulo,"\tSubGrupo [%d] no encontrado en Ge_MultiIdioma con el indioma [%s]"
                                      ,LOG01,stFaDetCons.stDetConsumo[lCont].iCodSubGrupo,pstFactDocuClie->szCod_Idioma);
            }
        }
    }

    /* Carga de Impuestos */
    for(lCont=0;lCont<stFaDetCons.iNumReg;lCont++)
    {
        if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[lCont].iCodConcepto, 
        					   stFaDetCons.stDetConsumo[lCont].iColumna, 
        					   &stFaDetCons.stDetConsumo[lCont].dTotalPrimeraCateg, 
        					   &stFaDetCons.stDetConsumo[lCont].dTotalSegundaCateg ))
        {
            vDTrazasLog(szModulo, "\t[EE] Error en regreso de funcion bfnTotImptosCateg ", LOG05);
            return(FALSE);
        }
    }

    /* Se ordena la estructura de orden alterno */

    qsort((void*)stOrden2DetConsumo.stOrden, stOrden2DetConsumo.iNumRegs, sizeof(ST_ORDEN),ifnCmpOrden);

    return (TRUE);

}/************************* Fin CargaConceptosDelCliente ********************/

/****************************************************************************/
/*  Funcion: int ifnOpenConcTrafico(long, long)                             */
/*  Funcion que Abre el cursor de Conceptos de Trafico Facturados           */
/****************************************************************************/
int OpenConceptos ( long        lIndOrdenTotal,
                    long        lCodCiclFact,
                    char        *szCod_Servicio, 
                    int         iCodFormulario,
                    DETALLEOPER *pstDetallOper, 
                    int         iCodTipDocum)
{
    char    szTablaConc [50]    ="";
    char    szTablaAbon [50]    ="";
    char    szFlagB06   [100];
    char    szCadenaSQL [3000]  ="";
    int     iMascara      ;
    int     iPosicionRegistro;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhIndOrdenTotal;
         char szhCod_Servicio[4];
         int  ihCodFormulario;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhIndOrdenTotal = lIndOrdenTotal;
    strcpy(szhCod_Servicio,  szCod_Servicio);
    ihCodFormulario = iCodFormulario;

    strcpy (szModulo, "OpenConceptos");
    iPosicionRegistro=BuscaMascara(pstDetallOper,"A1100",pstDetallOper->iCantRegistros,iCodTipDocum);
    iMascara = (iPosicionRegistro>=0)? pstDetallOper->iIndImp[iPosicionRegistro]:0;
    if (iMascara != 1)
    {
      strcpy(szFlagB06,"");
    }
    else    {
      strcpy(szFlagB06,"\nAND COD_TIPSUBGRUPO != 6");
    }

    if ( !lCodCiclFact ) {
        sprintf(szTablaAbon,"FA_FACTABON_NOCICLO");
        sprintf(szTablaConc,"FA_FACTCONC_NOCICLO");
    }
    else {
        sprintf(szTablaAbon,"FA_FACTABON_%ld",lCodCiclFact);
        sprintf(szTablaConc,"FA_FACTCONC_%ld",lCodCiclFact);
    }

    vDTrazasLog(szModulo,"\t** Abriendo Conceptos de Trafico...(%ld) (%ld)", LOG04,lIndOrdenTotal,lCodCiclFact);

    sprintf(szCadenaSQL, "\n SELECT D.NUM_ORDEN,"
                         "\n D.COD_GRUPO,"
                         "\n NVL(D.DES_GLOSA, ' '),"
                         "\n C.NUM_ORDEN,"
                         "\n C.COD_SUBGRUPO,"
                         "\n NVL(C.DES_GLOSA,' '),"
                         "\n C.COD_TIPSUBGRUPO,"
                         "\n A.NUM_ABONADO,"
                         "\n A.COD_PRODUCTO,"
                         "\n A.COD_CONCEPTO,"
                         "\n A.COLUMNA,"
                         "\n replace(A.DES_CONCEPTO,'%%'),"
                         "\n A.COD_TIPCONCE,"
                         "\n A.SEG_CONSUMIDO,"
                         "\n NVL(A.NUM_UNIDADES,0),"
                         "\n A.IMP_FACTURABLE,"
                         "\n 0,"
                         "\n TO_CHAR(NVL(E.NUM_CELULAR,0)),"
                         "\n G.COD_NIVEL,"
                         "\n TO_CHAR(A.FEC_VALOR,'YYYYMMDD'),"
                         "\n NVL(A.COD_CARGOBASICO,' '),"
                         "\n ' ' ,"
                         "\n NVL(A.COD_PLANTARIF,' '),"
                         "\n NVL(TO_CHAR(E.FEC_FINCONTRA,'YYYYMMDD'),' '),"
                         "\n B.NUM_ORDEN,"
                         "\n NVL(A.DUR_REAL,0),"
                         "\n NVL(A.DUR_DCTO,0),"
                         "\n NVL(A.IMP_REAL,0),"
                         "\n NVL(A.IMP_DCTO,0), "
                         "\n NVL(A.CNT_LLAM_REAL,0),"
                         "\n NVL(A.CNT_LLAM_DCTO,0),"
                         "\n NVL(A.CNT_LLAM_FACT,0), "
                         "\n A.IMP_VALUNITARIO, "
                         "\n NVL(A.GLS_DESCRIP,' '), "
                         "\n A.COD_CONCEREL,"         
                         "\n A.COLUMNA_REL,"          
                         "\n A.PRC_IMPUESTO,"         
                         "\n A.IMP_MONTOBASE,"
                         "\n B.TIP_CONCEP,"           
                         "\n NVL(D.NIV_IMPRESION,0)," 
                         "\n NVL(D.TIP_UNIDAD,'     '),"
                         "\n NVL(D.TIP_GRUPO,'     ')," 
                         "\n NVL(A.NUM_VENTA,0),"
                         "\n NVL(A.NUM_PULSO,0),"                         
                         "\n NVL(A.IMP_FACT_CON_IVA,0) " /* P-MIX-09003 77 */    
                         "\n FROM FAD_IMPSERVIMPRES G,"
                         "\n %s E,"
                         "\n FAD_IMPGRUPOS D,"
                         "\n FAD_IMPSUBGRUPOS C,"
                         "\n FAD_IMPCONCEPTOS B,"
                         "\n %s A"
                         "\n WHERE A.IND_ORDENTOTAL = :lhIndOrdenTotal"
                         "\n AND A.IND_ORDENTOTAL = E.IND_ORDENTOTAL(+)"
                         "\n AND A.NUM_ABONADO    = E.NUM_ABONADO(+)"
                         "\n AND A.COD_CONCEPTO   = B.COD_CONCEPTO"
                         "\n AND B.COD_SUBGRUPO   = C.COD_SUBGRUPO"
                         "\n AND C.COD_GRUPO      = D.COD_GRUPO"
                         "\n AND D.COD_FORMULARIO = :ihCodFormulario " 
                         "\n AND G.COD_SERVICIO   = TRIM(:szhCod_Servicio) "
                         "\n AND G.COD_FORMULARIO = D.COD_FORMULARIO"
                         "\n AND G.COD_GRUPO      = D.COD_GRUPO"
                      "\nUNION ALL"
                         "\nSELECT %d,"
                               "\n AG.COD_GRUPO,"
                               "\n NVL(AG.DES_GLOSA,' '),"
                               "\n BG.NUM_ORDEN,"
                               "\n BG.COD_SUBGRUPO,"
                               "\n NVL(BG.DES_GLOSA,' '),"
                               "\n BG.COD_TIPSUBGRUPO,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n ' ',"
                               "\n 0,"
                               "\n -1,"
                               "\n 0,"
                               "\n 0,"
                               "\n -1,"
                               "\n '0',"
                               "\n DG.COD_NIVEL,"
                               "\n ' ',"
                               "\n ' ',"
                               "\n CG.TIP_CONCNOFACT,"
                               "\n ' ',"
                               "\n ' ',"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0,"
                               "\n 0, "
                               "\n 0, "  
                               "\n ' ',"
                               "\n 0,"   
                               "\n 0,"   
                               "\n 0,"   
                               "\n 0,"   
                               "\n 0,"   
                               "\n 0,"   
                               "\n ' '," 
                               "\n ' '," 
                               "\n 0,"   
                               "\n 0,"                               
                               "\n 0 " /* P-MIX-09003 77 */  
                           "\nFROM FAD_IMPGRUPOS AG,"
                               "\n FAD_IMPSUBGRUPOS BG,"
                               "\n FAD_IMPCONC_NOFACT CG,"
                               "\n FAD_IMPSERVIMPRES DG"
                          "\nWHERE DG.COD_FORMULARIO = :ihCodFormulario" 
                            "\nAND DG.COD_SERVICIO = TRIM(:szhCod_Servicio) "
                            "\nAND DG.COD_GRUPO = AG.COD_GRUPO"
                            "\nAND DG.COD_GRUPO = BG.COD_GRUPO"
                            "\nAND BG.COD_SUBGRUPO > 0"
                            "\nAND BG.COD_SUBGRUPO = CG.COD_SUBGRUPO"
                            "%s"
                          "\nORDER BY 18,1,4"
                               ,szTablaAbon,szTablaConc,NO_FACTURABLE,szFlagB06);

    vDTrazasLog(szModulo,"QRY:OpenConceptos(%s)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Conceptos_DetLlam FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )3000;
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


    if(SQLCODE != SQLOK)
    {
      vDTrazasLog  (szModulo,"\t\tError en SQL-PREPARE sql_Conceptos_DetLlam **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
      vDTrazasError(szModulo,"\t\tError en SQL-PREPARE sql_Conceptos_DetLlam **"
                                      "\t\tError : [%s] [%d]  [%s] ",LOG01,szCadenaSQL,SQLCODE,SQLERRM);
      return  (SQLCODE);
    }
    /* EXEC SQL DECLARE curConcTrafico CURSOR FOR sql_Conceptos_DetLlam; */ 

    if(SQLCODE != SQLOK)
    {
      vDTrazasLog  (szModulo,"\t\tError en SQL-DECLARE curConcTrafico **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
      vDTrazasError(szModulo,"\t\tError en SQL-DECLARE curConcTrafico **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
      return  (SQLCODE);
    }
    vDTrazasLog  ("ImpSclB:OpenConceptos","\t\tOPEN curConcTrafico using %ld %d '%s' %d '%s' **", LOG03, lhIndOrdenTotal, ihCodFormulario, szhCod_Servicio, ihCodFormulario, szhCod_Servicio);
    /* EXEC SQL OPEN curConcTrafico USING :lhIndOrdenTotal, :ihCodFormulario, :szhCod_Servicio, :ihCodFormulario, :szhCod_Servicio; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodFormulario;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Servicio;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodFormulario;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Servicio;
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

 
    if(SQLCODE != SQLOK)
    {
      vDTrazasLog  (szModulo,"\t\tError en SQL-OPEN CURSOR curConcTrafico **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
      vDTrazasError(szModulo,"\t\tError en SQL-OPEN CURSOR curConcTrafico **"
                                      "\t\tError : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
    }
    return (SQLCODE);
}/************************ Final de OpenConceptos ***********************/

/************************************************************************/
/* Fon: int ifnFetchConcTrafico(FACTDOC *)                              */
/* Fon que realiza Fetch en el cursor de curFactDoc                     */
/************************************************************************/
int FetchConceptos(ST_DETCONSUMO_HOST *pstConcTrafico, long *plNumFilas)
{
    strcpy (szModulo, "FetchConceptos");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);

    /* EXEC SQL
    FETCH curConcTrafico
    INTO :pstConcTrafico->iNum_OrdenGr         ,
         :pstConcTrafico->iCodGrupo            ,
         :pstConcTrafico->szGlosaGrupo         ,
         :pstConcTrafico->iNum_OrdenSubGr      ,
         :pstConcTrafico->iCodSubGrupo         ,
         :pstConcTrafico->szGlosaSubGrupo      ,
         :pstConcTrafico->iCod_TipSubGrupo     ,
         :pstConcTrafico->lNumAbonado          ,
         :pstConcTrafico->iCod_Producto        ,
         :pstConcTrafico->iCodConcepto         ,
         :pstConcTrafico->iColumna             ,
         :pstConcTrafico->szDes_Concepto       ,
         :pstConcTrafico->iCodTipConce         ,
         :pstConcTrafico->lSeg_Consumo         ,
         :pstConcTrafico->iNum_Unidades        ,
         :pstConcTrafico->dTotalFacturableNet  ,
         :pstConcTrafico->dTotalFacturableImp  ,
         :pstConcTrafico->szNum_Celular        ,
         :pstConcTrafico->szCod_Nivel          ,
         :pstConcTrafico->szFec_Pago           ,
         :pstConcTrafico->szCod_CargoBasico    ,
         :pstConcTrafico->szTip_ConcNoFact     ,
         :pstConcTrafico->szCod_PlanTarif      ,
         :pstConcTrafico->szFec_FinContrato    ,
         :pstConcTrafico->iNum_OrdenConc       ,
         :pstConcTrafico->lSeg_ConsumoReal     ,
         :pstConcTrafico->lSeg_ConsumoDcto     ,
         :pstConcTrafico->dTotalFacturableReal ,
         :pstConcTrafico->dTotalFacturableDcto ,
         :pstConcTrafico->lCntLlamReal         ,
         :pstConcTrafico->lCntLlamDcto         ,
         :pstConcTrafico->lCntLlamFAct         ,
         :pstConcTrafico->dImpValUnitario      ,
         :pstConcTrafico->szGlsDescrip         ,
         :pstConcTrafico->iCodConcerel         ,
         :pstConcTrafico->iColumnaRel          ,
         :pstConcTrafico->dPrcImpuesto         ,
         :pstConcTrafico->dImpMontoBase        ,
         :pstConcTrafico->iTipConcep           ,
         :pstConcTrafico->iNivelImpresion      ,
         :pstConcTrafico->szTipUnidad          ,
         :pstConcTrafico->szTipGrupo           ,
         :pstConcTrafico->lNumVenta            ,
         :pstConcTrafico->lNumPulsos           ,
         :pstConcTrafico->dImpFactConIva       ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )15000;
    sqlstm.offset = (unsigned int  )59;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstConcTrafico->iNum_OrdenGr);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstConcTrafico->iCodGrupo);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstConcTrafico->szGlosaGrupo);
    sqlstm.sqhstl[2] = (unsigned long )51;
    sqlstm.sqhsts[2] = (         int  )51;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstConcTrafico->iNum_OrdenSubGr);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstConcTrafico->iCodSubGrupo);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )sizeof(int);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstConcTrafico->szGlosaSubGrupo);
    sqlstm.sqhstl[5] = (unsigned long )51;
    sqlstm.sqhsts[5] = (         int  )51;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstConcTrafico->iCod_TipSubGrupo);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstConcTrafico->lNumAbonado);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )sizeof(long);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstConcTrafico->iCod_Producto);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[8] = (         int  )sizeof(int);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstConcTrafico->iCodConcepto);
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )sizeof(int);
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstConcTrafico->iColumna);
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )sizeof(int);
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstConcTrafico->szDes_Concepto);
    sqlstm.sqhstl[11] = (unsigned long )61;
    sqlstm.sqhsts[11] = (         int  )61;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(pstConcTrafico->iCodTipConce);
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )sizeof(int);
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(pstConcTrafico->lSeg_Consumo);
    sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[13] = (         int  )sizeof(long);
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)(pstConcTrafico->iNum_Unidades);
    sqlstm.sqhstl[14] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[14] = (         int  )sizeof(int);
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)(pstConcTrafico->dTotalFacturableNet);
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )sizeof(double);
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)(pstConcTrafico->dTotalFacturableImp);
    sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[16] = (         int  )sizeof(double);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)(pstConcTrafico->szNum_Celular);
    sqlstm.sqhstl[17] = (unsigned long )21;
    sqlstm.sqhsts[17] = (         int  )21;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqharc[17] = (unsigned long  *)0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)(pstConcTrafico->szCod_Nivel);
    sqlstm.sqhstl[18] = (unsigned long )4;
    sqlstm.sqhsts[18] = (         int  )4;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqharc[18] = (unsigned long  *)0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)(pstConcTrafico->szFec_Pago);
    sqlstm.sqhstl[19] = (unsigned long )11;
    sqlstm.sqhsts[19] = (         int  )11;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqharc[19] = (unsigned long  *)0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)(pstConcTrafico->szCod_CargoBasico);
    sqlstm.sqhstl[20] = (unsigned long )4;
    sqlstm.sqhsts[20] = (         int  )4;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqharc[20] = (unsigned long  *)0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)(pstConcTrafico->szTip_ConcNoFact);
    sqlstm.sqhstl[21] = (unsigned long )6;
    sqlstm.sqhsts[21] = (         int  )6;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqharc[21] = (unsigned long  *)0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)(pstConcTrafico->szCod_PlanTarif);
    sqlstm.sqhstl[22] = (unsigned long )4;
    sqlstm.sqhsts[22] = (         int  )4;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqharc[22] = (unsigned long  *)0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)(pstConcTrafico->szFec_FinContrato);
    sqlstm.sqhstl[23] = (unsigned long )11;
    sqlstm.sqhsts[23] = (         int  )11;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqharc[23] = (unsigned long  *)0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)(pstConcTrafico->iNum_OrdenConc);
    sqlstm.sqhstl[24] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[24] = (         int  )sizeof(int);
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqharc[24] = (unsigned long  *)0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)(pstConcTrafico->lSeg_ConsumoReal);
    sqlstm.sqhstl[25] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[25] = (         int  )sizeof(long);
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqharc[25] = (unsigned long  *)0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)(pstConcTrafico->lSeg_ConsumoDcto);
    sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[26] = (         int  )sizeof(long);
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqharc[26] = (unsigned long  *)0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)(pstConcTrafico->dTotalFacturableReal);
    sqlstm.sqhstl[27] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[27] = (         int  )sizeof(double);
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqharc[27] = (unsigned long  *)0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)(pstConcTrafico->dTotalFacturableDcto);
    sqlstm.sqhstl[28] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[28] = (         int  )sizeof(double);
    sqlstm.sqindv[28] = (         short *)0;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqharc[28] = (unsigned long  *)0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
    sqlstm.sqhstv[29] = (unsigned char  *)(pstConcTrafico->lCntLlamReal);
    sqlstm.sqhstl[29] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[29] = (         int  )sizeof(long);
    sqlstm.sqindv[29] = (         short *)0;
    sqlstm.sqinds[29] = (         int  )0;
    sqlstm.sqharm[29] = (unsigned long )0;
    sqlstm.sqharc[29] = (unsigned long  *)0;
    sqlstm.sqadto[29] = (unsigned short )0;
    sqlstm.sqtdso[29] = (unsigned short )0;
    sqlstm.sqhstv[30] = (unsigned char  *)(pstConcTrafico->lCntLlamDcto);
    sqlstm.sqhstl[30] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[30] = (         int  )sizeof(long);
    sqlstm.sqindv[30] = (         short *)0;
    sqlstm.sqinds[30] = (         int  )0;
    sqlstm.sqharm[30] = (unsigned long )0;
    sqlstm.sqharc[30] = (unsigned long  *)0;
    sqlstm.sqadto[30] = (unsigned short )0;
    sqlstm.sqtdso[30] = (unsigned short )0;
    sqlstm.sqhstv[31] = (unsigned char  *)(pstConcTrafico->lCntLlamFAct);
    sqlstm.sqhstl[31] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[31] = (         int  )sizeof(long);
    sqlstm.sqindv[31] = (         short *)0;
    sqlstm.sqinds[31] = (         int  )0;
    sqlstm.sqharm[31] = (unsigned long )0;
    sqlstm.sqharc[31] = (unsigned long  *)0;
    sqlstm.sqadto[31] = (unsigned short )0;
    sqlstm.sqtdso[31] = (unsigned short )0;
    sqlstm.sqhstv[32] = (unsigned char  *)(pstConcTrafico->dImpValUnitario);
    sqlstm.sqhstl[32] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[32] = (         int  )sizeof(double);
    sqlstm.sqindv[32] = (         short *)0;
    sqlstm.sqinds[32] = (         int  )0;
    sqlstm.sqharm[32] = (unsigned long )0;
    sqlstm.sqharc[32] = (unsigned long  *)0;
    sqlstm.sqadto[32] = (unsigned short )0;
    sqlstm.sqtdso[32] = (unsigned short )0;
    sqlstm.sqhstv[33] = (unsigned char  *)(pstConcTrafico->szGlsDescrip);
    sqlstm.sqhstl[33] = (unsigned long )100;
    sqlstm.sqhsts[33] = (         int  )100;
    sqlstm.sqindv[33] = (         short *)0;
    sqlstm.sqinds[33] = (         int  )0;
    sqlstm.sqharm[33] = (unsigned long )0;
    sqlstm.sqharc[33] = (unsigned long  *)0;
    sqlstm.sqadto[33] = (unsigned short )0;
    sqlstm.sqtdso[33] = (unsigned short )0;
    sqlstm.sqhstv[34] = (unsigned char  *)(pstConcTrafico->iCodConcerel);
    sqlstm.sqhstl[34] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[34] = (         int  )sizeof(int);
    sqlstm.sqindv[34] = (         short *)0;
    sqlstm.sqinds[34] = (         int  )0;
    sqlstm.sqharm[34] = (unsigned long )0;
    sqlstm.sqharc[34] = (unsigned long  *)0;
    sqlstm.sqadto[34] = (unsigned short )0;
    sqlstm.sqtdso[34] = (unsigned short )0;
    sqlstm.sqhstv[35] = (unsigned char  *)(pstConcTrafico->iColumnaRel);
    sqlstm.sqhstl[35] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[35] = (         int  )sizeof(int);
    sqlstm.sqindv[35] = (         short *)0;
    sqlstm.sqinds[35] = (         int  )0;
    sqlstm.sqharm[35] = (unsigned long )0;
    sqlstm.sqharc[35] = (unsigned long  *)0;
    sqlstm.sqadto[35] = (unsigned short )0;
    sqlstm.sqtdso[35] = (unsigned short )0;
    sqlstm.sqhstv[36] = (unsigned char  *)(pstConcTrafico->dPrcImpuesto);
    sqlstm.sqhstl[36] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[36] = (         int  )sizeof(double);
    sqlstm.sqindv[36] = (         short *)0;
    sqlstm.sqinds[36] = (         int  )0;
    sqlstm.sqharm[36] = (unsigned long )0;
    sqlstm.sqharc[36] = (unsigned long  *)0;
    sqlstm.sqadto[36] = (unsigned short )0;
    sqlstm.sqtdso[36] = (unsigned short )0;
    sqlstm.sqhstv[37] = (unsigned char  *)(pstConcTrafico->dImpMontoBase);
    sqlstm.sqhstl[37] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[37] = (         int  )sizeof(double);
    sqlstm.sqindv[37] = (         short *)0;
    sqlstm.sqinds[37] = (         int  )0;
    sqlstm.sqharm[37] = (unsigned long )0;
    sqlstm.sqharc[37] = (unsigned long  *)0;
    sqlstm.sqadto[37] = (unsigned short )0;
    sqlstm.sqtdso[37] = (unsigned short )0;
    sqlstm.sqhstv[38] = (unsigned char  *)(pstConcTrafico->iTipConcep);
    sqlstm.sqhstl[38] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[38] = (         int  )sizeof(int);
    sqlstm.sqindv[38] = (         short *)0;
    sqlstm.sqinds[38] = (         int  )0;
    sqlstm.sqharm[38] = (unsigned long )0;
    sqlstm.sqharc[38] = (unsigned long  *)0;
    sqlstm.sqadto[38] = (unsigned short )0;
    sqlstm.sqtdso[38] = (unsigned short )0;
    sqlstm.sqhstv[39] = (unsigned char  *)(pstConcTrafico->iNivelImpresion);
    sqlstm.sqhstl[39] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[39] = (         int  )sizeof(int);
    sqlstm.sqindv[39] = (         short *)0;
    sqlstm.sqinds[39] = (         int  )0;
    sqlstm.sqharm[39] = (unsigned long )0;
    sqlstm.sqharc[39] = (unsigned long  *)0;
    sqlstm.sqadto[39] = (unsigned short )0;
    sqlstm.sqtdso[39] = (unsigned short )0;
    sqlstm.sqhstv[40] = (unsigned char  *)(pstConcTrafico->szTipUnidad);
    sqlstm.sqhstl[40] = (unsigned long )10;
    sqlstm.sqhsts[40] = (         int  )10;
    sqlstm.sqindv[40] = (         short *)0;
    sqlstm.sqinds[40] = (         int  )0;
    sqlstm.sqharm[40] = (unsigned long )0;
    sqlstm.sqharc[40] = (unsigned long  *)0;
    sqlstm.sqadto[40] = (unsigned short )0;
    sqlstm.sqtdso[40] = (unsigned short )0;
    sqlstm.sqhstv[41] = (unsigned char  *)(pstConcTrafico->szTipGrupo);
    sqlstm.sqhstl[41] = (unsigned long )10;
    sqlstm.sqhsts[41] = (         int  )10;
    sqlstm.sqindv[41] = (         short *)0;
    sqlstm.sqinds[41] = (         int  )0;
    sqlstm.sqharm[41] = (unsigned long )0;
    sqlstm.sqharc[41] = (unsigned long  *)0;
    sqlstm.sqadto[41] = (unsigned short )0;
    sqlstm.sqtdso[41] = (unsigned short )0;
    sqlstm.sqhstv[42] = (unsigned char  *)(pstConcTrafico->lNumVenta);
    sqlstm.sqhstl[42] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[42] = (         int  )sizeof(long);
    sqlstm.sqindv[42] = (         short *)0;
    sqlstm.sqinds[42] = (         int  )0;
    sqlstm.sqharm[42] = (unsigned long )0;
    sqlstm.sqharc[42] = (unsigned long  *)0;
    sqlstm.sqadto[42] = (unsigned short )0;
    sqlstm.sqtdso[42] = (unsigned short )0;
    sqlstm.sqhstv[43] = (unsigned char  *)(pstConcTrafico->lNumPulsos);
    sqlstm.sqhstl[43] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[43] = (         int  )sizeof(long);
    sqlstm.sqindv[43] = (         short *)0;
    sqlstm.sqinds[43] = (         int  )0;
    sqlstm.sqharm[43] = (unsigned long )0;
    sqlstm.sqharc[43] = (unsigned long  *)0;
    sqlstm.sqadto[43] = (unsigned short )0;
    sqlstm.sqtdso[43] = (unsigned short )0;
    sqlstm.sqhstv[44] = (unsigned char  *)(pstConcTrafico->dImpFactConIva);
    sqlstm.sqhstl[44] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[44] = (         int  )sizeof(double);
    sqlstm.sqindv[44] = (         short *)0;
    sqlstm.sqinds[44] = (         int  )0;
    sqlstm.sqharm[44] = (unsigned long )0;
    sqlstm.sqharc[44] = (unsigned long  *)0;
    sqlstm.sqadto[44] = (unsigned short )0;
    sqlstm.sqtdso[44] = (unsigned short )0;
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

 /* P-MIX-09003 77 */

    vDTrazasLog(szModulo, "\n\t\tFetch FetchConceptos SQLCODE= %ld"
      					  "\n\t\tFetch FetchConceptos cantidad retornada = %ld"
      					  ,LOG05, SQLCODE, sqlca.sqlerrd[2]);

    if (SQLCODE==SQLOK)
        *plNumFilas = MAX_CONCEPTOS_LOCAL_HOST;
    else
        if (SQLCODE==SQLNOTFOUND)
            *plNumFilas = sqlca.sqlerrd[2] % MAX_CONCEPTOS_LOCAL_HOST;

    return(SQLCODE);
}/*************************** Final de FetchConceptos ***************************/

/****************************************************************************/
/*  Funcion: int CloseConceptos(void)                                       */
/*  Funcion que cierra el cursor de Conceptos                               */
/****************************************************************************/
int CloseConceptos(void)
{
    strcpy (szModulo, "CloseConceptos");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);

    /* EXEC SQL CLOSE curConcTrafico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )254;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK) {
        vDTrazasError(szModulo,"\t\tError al cerrar el Cursor FA_FACTDOCU_CICLO: %s",LOG01, SQLERRM);
        return(FALSE);
    }
    return(TRUE);
}/****************Final de CloseConceptos *******************/

/****************************************************************************/
/*     Funcion CargaAbonadosdeCliente                                       */
/*     recupera todos los abonados de un cliente                            */
/****************************************************************************/
int CargaAbonadosdelCliente(ST_FACTCLIE * pstFactDocuClie,ST_ABONADO * pst_Abonados,LINEACOMANDO * pstLineaComando )
{
int  iSqlCodeAbonado ;

    strcpy (szModulo, "CargaAbonadosdelCliente");
    vDTrazasLog(szModulo,"\t(Carga_Abonados) IndOrdenTotal  [%ld]",LOG04, pstFactDocuClie->lIndOrdenTotal);

	memset(pst_Abonados,0,sizeof(pst_Abonados));	
	
    /************************************************************************************/
    /*    Recupera Conceptos de Trafico de la Factura Identificando el Tipo de Trafico  */
    /************************************************************************************/
    iSqlCodeAbonado = OpenAbonado( pstLineaComando->lCodCiclFact, pstFactDocuClie->lIndOrdenTotal);

    if(iSqlCodeAbonado == SQLOK)
    {
        iSqlCodeAbonado  = FetchAbonado( pst_Abonados );

        if(iSqlCodeAbonado == SQLOK &&
           pst_Abonados->CantidadAbonados >= BUFF_ABONADO)
		{
        	vDTrazasLog  (szModulo, "\t\tCliente Sobrepaso Maximo de Abonados"
                                    "\t\t ==> Cliente [%ld]" "\t\t ==> Num. Abonados   [%d]"
                                    ,LOG01, pstFactDocuClie->lIndOrdenTotal,pst_Abonados->CantidadAbonados);
            vDTrazasError(szModulo, "\t\tCliente Sobrepaso Maximo de Abonados"
                                    "\t\t ==> Cliente [%ld]" "\t\t ==> Num. Abonados   [%d]"
                                    ,LOG01, pstFactDocuClie->lIndOrdenTotal,pst_Abonados->CantidadAbonados);
            return (FALSE);
        }
    }
    if((iSqlCodeAbonado != SQLOK) && (iSqlCodeAbonado != SQLNOTFOUND))
    {
        vDTrazasError(szModulo,  "\n\t\t(CargaAbonados) Fetch\t\tIndOrdenTotal  [%ld]"
                                 "\n\t\t Error Oracle   [%s]",LOG01, pstFactDocuClie->lIndOrdenTotal,SQLERRM);
        vDTrazasLog(szModulo,    "\n\t\t(CargaAbonados) Fetch\t\tIndOrdenTotal  [%ld]"
                                 "\n\t\t Error Oracle   [%s]",LOG01, pstFactDocuClie->lIndOrdenTotal,SQLERRM);
      return (FALSE);
    }

     if (!CloseAbonado()) return (FALSE);
   /****************************************************/
   /* Cantidad de Abonados por Clientes o Factura      */
    vDTrazasLog(szModulo,"\t====> Cantidad de Abonados por Cliente [%d]",LOG04,pst_Abonados->CantidadAbonados);

    return (TRUE);
}/************************* Fin bfnCargaAbonados *************************/


/*****************************************************************************/
/* Funcion encargada de actualizar los campos pertinentes en la tabla de     */
/* cuotas del periodo, FA_CUOTCREDITO.                                       */
/*****************************************************************************/
int Update_CuotaCredito (ST_FACTCLIE * FactDocuClie,ST_CUOTAS *pstFaCuotas)
{
int k = 0;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char   szhNumFolioCtc[13]; /* EXEC SQL VAR szhNumFolioCtc IS STRING(13); */ 

     char   szhRowid      [20]; /* EXEC SQL VAR szhRowid IS STRING(20)   ; */ 

     int    iIndImpreso       ;
/* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "Update_CuotaCredito");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);

    if(FactDocuClie->dTotFactura == 0)
    {
      sprintf(szhNumFolioCtc,"%11.11s\0",FactDocuClie->szNumCtcPago);
    }
    else
    {
      sprintf(szhNumFolioCtc,"%11.11s\0",FactDocuClie->szNumCtc);
    }
    vDTrazasLog(szModulo,"\n\t\tFec_Vencimiento : [%s] Folio ctc [%s]"
                         "\n\t\tAntes de for: pstFaCuotas->iNum_RegCuotas_venci [%d]"
                         ,LOG05, FactDocuClie->szFecVencimie
                         ,szhNumFolioCtc, pstFaCuotas->iNum_RegCuotas_venci);

    iIndImpreso = 1;
    for(k=0; k < pstFaCuotas->iNum_RegCuotas_venci; k++)
    {
        strcpy(szhRowid, pstFaCuotas->stReg_venci[k].szRowid);
        vDTrazasLog(szModulo,"\t\tVencido --> Previo actualizacion, Numero de Registro k:[%d] - iInd_Facturado: [%d]"
                            ,LOG05, k, pstFaCuotas->stReg_venci[k].iInd_Facturado);

        if((pstFaCuotas->stReg_venci[k].iInd_Facturado == 0)||(pstFaCuotas->stReg_venci[k].iInd_Facturado == 3))/*Nunca debe entrar todas tienens ind_facturado=1*/
        {
            vDTrazasLog(szModulo,"\t\tVencido --> k:[%d] Dentro de if solo si iInd_Facturado in [0,3], iInd_Facturado:[%d]"
                                ,LOG05,k,pstFaCuotas->stReg_venci[k].iInd_Facturado);

            /* EXEC SQL
            UPDATE FA_CUOTCREDITO SET
                IND_ORDENTOTAL  = :FactDocuClie->lIndOrdenTotal,
                FEC_VENCIMIE    = TO_DATE(:FactDocuClie->szFecVencimie,'YYYYMMDDHH24MISS'),
                IND_IMPRESO     = :iIndImpreso,
                NUM_FOLIOCTC    = :szhNumFolioCtc
            WHERE  ROWID        = :szhRowid; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 45;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_CUOTCREDITO  set IND_ORDENTOTAL=:b0,FEC\
_VENCIMIE=TO_DATE(:b1,'YYYYMMDDHH24MISS'),IND_IMPRESO=:b2,NUM_FOLIOCTC=:b3 whe\
re ROWID=:b4";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )269;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(FactDocuClie->lIndOrdenTotal);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)(FactDocuClie->szFecVencimie);
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&iIndImpreso;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNumFolioCtc;
            sqlstm.sqhstl[3] = (unsigned long )13;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
            sqlstm.sqhstl[4] = (unsigned long )20;
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


        }

        else
        {
              vDTrazasLog(szModulo,"\t\t   Vencido --> k:[%d] Dentro de else solo si iInd_Facturado not in [0,3], iInd_Facturado:[%d]",LOG05,k,pstFaCuotas->stReg_venci[k].iInd_Facturado);

            /* EXEC SQL
            UPDATE FA_CUOTCREDITO SET
                IND_ORDENTOTAL  = :FactDocuClie->lIndOrdenTotal,
                IND_IMPRESO     = :iIndImpreso
            WHERE  ROWID        = :szhRowid; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 45;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_CUOTCREDITO  set IND_ORDENTOTAL=:b0,IND\
_IMPRESO=:b1 where ROWID=:b2";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )304;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(FactDocuClie->lIndOrdenTotal);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&iIndImpreso;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhRowid;
            sqlstm.sqhstl[2] = (unsigned long )20;
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


            vDTrazasLog(szModulo,"Dentro del Update Vencidas :FEC_VENCI[%s],INDD_ORDENTOTAL[%ld]\n",LOG04, FactDocuClie->szFecVencimie,FactDocuClie->lIndOrdenTotal);/*RA-134*/
        }
        if(sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog(szModulo,"Error en  UPDATE. (FA_CUOTCREDITO) Venci",LOG04);
            return(FALSE);
        }

        vDTrazasLog(szModulo,   "Cuota vencida         \n"
                                "Registro        : [%d]\n"
                                "Rowid           : [%s]\n"
                                "Ind_OrdenTotal  : [%d]\n"
                                "Num_FolioCtc    : [%s]\n"
                                ,LOG04, k,
                                szhRowid,
                                FactDocuClie->lIndOrdenTotal,
                                szhNumFolioCtc);

        if(pstFaCuotas->stReg_venci[k].iInd_Facturado == 0)
        {
            vDTrazasLog(szModulo," if ind_facturado=0 Fec_Vencimiento : [%s]",LOG04, FactDocuClie->szFecVencimie);
        }
        vDTrazasLog(szModulo,"\t\t Cuota Venc.despues for,Fec_Vencimiento : [%s] Folio ctc [%s]",LOG04, FactDocuClie->szFecVencimie,szhNumFolioCtc);/*fph*/
    }

    vDTrazasLog(szModulo,"\t\t   Antes de for: pstFaCuotas->iNum_RegCuotas_pven [%d]",LOG05, pstFaCuotas->iNum_RegCuotas_pven);
    for(k=0; k < pstFaCuotas->iNum_RegCuotas_pven; k++)
    {
        strcpy(szhRowid, pstFaCuotas->stReg_pven[k].szRowid);

        vDTrazasLog(szModulo,"\t\t   Por Vencer --> Previo actualizacion, Numero de Registro k:[%d] - stReg_pven[k].iInd_Facturado: [%d]",LOG05, k, pstFaCuotas->stReg_pven[k].iInd_Facturado);

        if(pstFaCuotas->stReg_pven[k].iInd_Facturado == 2)
        {
            vDTrazasLog(szModulo,"\t\t   Por Vencer --> k:[%d] Dentro de if solo si pstFaCuotas->stReg_pven[k].iInd_Facturado == 2, iInd_Facturado:[%d]",LOG05,k,pstFaCuotas->stReg_pven[k].iInd_Facturado);
            /* EXEC SQL
            UPDATE FA_CUOTCREDITO SET
                IND_ORDENTOTAL  = :FactDocuClie->lIndOrdenTotal,
                FEC_VENCIMIE    = TO_DATE(:FactDocuClie->szFecVencimie,'YYYYMMDDHH24MISS'),
                IND_IMPRESO     = :iIndImpreso,
                NUM_FOLIOCTC    = :szhNumFolioCtc
            WHERE  ROWID        = :szhRowid; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 45;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update FA_CUOTCREDITO  set IND_ORDENTOTAL=:b0,FEC\
_VENCIMIE=TO_DATE(:b1,'YYYYMMDDHH24MISS'),IND_IMPRESO=:b2,NUM_FOLIOCTC=:b3 whe\
re ROWID=:b4";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )331;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&(FactDocuClie->lIndOrdenTotal);
            sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)(FactDocuClie->szFecVencimie);
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&iIndImpreso;
            sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNumFolioCtc;
            sqlstm.sqhstl[3] = (unsigned long )13;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhRowid;
            sqlstm.sqhstl[4] = (unsigned long )20;
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



        }
        if(sqlca.sqlcode != SQLOK)
        {
            vDTrazasLog(szModulo,"Error en  UPDATE. (FA_CUOTCREDITO) pven [%d]",LOG04,sqlca.sqlcode);
            return(FALSE);
        }

        vDTrazasLog(szModulo,   "Cuota por vencer      \n"
                                "Registro        : [%d]\n"
                                "Rowid           : [%s]\n"
                                "Ind_OrdenTotal  : [%d]\n"
                                "Num_FolioCtc    : [%s]\n",
                                LOG04,k,
                                szhRowid,
                                FactDocuClie->lIndOrdenTotal,
                                szhNumFolioCtc);

        if(pstFaCuotas->stReg_pven[k].iInd_Facturado == 0)
        {
            vDTrazasLog(szModulo,"Fec_Vencimiento : [%s]",LOG04, FactDocuClie->szFecVencimie);
        }
    }

    /* EXEC SQL COMMIT; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )366;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4008                                     */
/**********************************************************************************************/
int put_b4008(FILE *Fd_ArchImp, int iRegConcep, char * buffer)
{
    char buffer_local[200];
    int iCodTipoImpuesto;

    memset(buffer_local,0,sizeof(buffer_local));

    if(!bfnTipoImpuesto(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,&iCodTipoImpuesto,stFaDetCons.stDetConsumo[iRegConcep].dPrcImpuesto))
    {
        vDTrazasLog("bfnTipoImpuesto", "No pudo encontrar el concepto con su Codigo de impuesto %d"
                                     , LOG05
                                     , stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto);
        return(FALSE);
    }

    sprintf(buffer_local,REG_B4008,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                         stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                         iCodTipoImpuesto,
                         stFaDetCons.stDetConsumo[iRegConcep].dImpMontoBase,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet);

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
        vDTrazasLog("put_b4008","No pudo escribir en archivo",LOG01);
        return(FALSE);
    }

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4007                                     */
/**********************************************************************************************/
int put_b4007 ( FILE      *Fd_ArchImp,
                rg_cuotas *pstReg,
                int       iRegConcep,
                int       iNum_RegCuotas, 
                int       Tip_Cuota, 
                long      lNumAbonado, 
                char      *buffer)
{
    int    iesCuota;
    int    iRegCuotas;
    char   buffer_local[300];
    double dTotalPrimeraCateg       = 0.0;   
    double dTotalSegundaCateg       = 0.0;   
    double dTotalNetoImpto          = 0.0;      
    double dTotalPorcenPrimeraCateg = 0.0;
    double dTotalPorcenSegundaCateg = 0.0;
    double dMtoTotalDeuda           = 0.0;
    double dSaldoPendiente          = 0.0;

    int ihTipoImp = 0; /** 2 imprime vencida , 3 imprime por vencer **/

    strcpy (szModulo, "put_b4007");
    memset(buffer_local,0,sizeof(buffer_local));

    vDTrazasLog("put_b4007", "**Entrando a funcion (%s):\n"
                             "\tiRegConcep    : [%d]\n"
                             "\tiNum_RegCuotas: [%d]\n"
                             "\tTip_Cuota     : [%d]\n"
                           , LOG05
                           , szModulo
                           , iRegConcep
                           , iNum_RegCuotas
                           , Tip_Cuota);

    iesCuota=(((atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA)||
             (atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)))? TRUE:FALSE;


/* Llama a la funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
    {
        if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna, &dTotalPrimeraCateg, &dTotalSegundaCateg ))
        {
            vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
            return(FALSE);
        }
        dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
        dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
    }

    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
    {
        vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
        return(FALSE);
    }

    vDTrazasLog("put_b4007", "**Funcion (put_b4007), antes de for:\n"
                             "\tatoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact : [%d]\n"
                             "\tstFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact:       [%s]\n"
                             "\tTip_Cuota : [%d]\n"
                           , LOG06
                           , atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)
                           , stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact
                           , Tip_Cuota);

    for(iRegCuotas=0;(iRegCuotas<iNum_RegCuotas)&&(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==Tip_Cuota);iRegCuotas++)
    {

      vDTrazasLog("put_b4007", "**Funcion (put_b4007), dentro de for:\n"
                               "\tiRegCuotas: [%d]\n"
                               "\tpstReg[iRegCuotas].iInd_Facturado: [%d]\n"
                               "\tNumAbonado                       : [%ld]\n"
                               "\tpstReg[iRegCuotas].lNumAbonado:    [%ld]\n"
                             , LOG06
                             , iRegCuotas
                             , pstReg[iRegCuotas].iInd_Facturado
                             , lNumAbonado
                             , pstReg[iRegCuotas].lNumAbonado);

      if (Tip_Cuota == CUOTA_VENCIDA)
          ihTipoImp = 2;
      else if (Tip_Cuota == CUOTA_PORVENCER)
          ihTipoImp = 3;

      if(pstReg[iRegCuotas].iInd_Facturado==ihTipoImp && lNumAbonado==pstReg[iRegCuotas].lNumAbonado )                                                                                                      
        {
            dTotalNetoImpto=pstReg[iRegCuotas].dMtoCuota + dTotalPrimeraCateg + dTotalSegundaCateg;   
            ifnObtenerMontosTotalesCuota(pstReg[iRegCuotas], &dMtoTotalDeuda, &dSaldoPendiente,2);   

            sprintf(buffer_local,REG_B4007,
                                          stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                                          stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                                          stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                                          stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                                          pstReg[iRegCuotas].dMtoCuota,
                                          (iesCuota)?"C":"P",
                                          pstReg[iRegCuotas].szDes_Cuota,
                                          pstReg[iRegCuotas].iNumCuota,
                                          pstReg[iRegCuotas].iSecCuota,
                                          pstReg[iRegCuotas].szPrefPlaza,
                                          pstReg[iRegCuotas].lNum_Folio,
                                          pstReg[iRegCuotas].szFec_Emision,
                                          dTotalPrimeraCateg,         
                                          dTotalSegundaCateg,         
                                          dTotalPorcenPrimeraCateg,   
                                          dTotalPorcenSegundaCateg,   
                                          dTotalNetoImpto,            
                                          dMtoTotalDeuda,             
                                          dSaldoPendiente,
                                          stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp);

            if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
            {
                vDTrazasLog(szModulo,"No pudo escribir en archivo",LOG01);
                return(FALSE);
            }
        }/* if() */
    }/* for() */

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4006                                     */
/**********************************************************************************************/
int put_b4006 ( FILE             *Fd_ArchImp,
                STSALDO_ANTERIOR *SaldoTot,
                int              iRegConcep,
                char             *buffer)
{
    int iRegSaldo;
    char buffer_local[300];
    double dTotalPrimeraCateg       = 0.0;   
    double dTotalSegundaCateg       = 0.0;   
    double dTotalNetoImpto          = 0.0;      
    double dTotalPorcenPrimeraCateg = 0.0;
    double dTotalPorcenSegundaCateg = 0.0;
    
    memset(buffer_local,0,sizeof(buffer_local));

    strcpy (szModulo, "put_b4006");

    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
    {
        if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna, &dTotalPrimeraCateg, &dTotalSegundaCateg ))
        {
            vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
            return(FALSE);
        }
        dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
        dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
    }

    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
    {
        vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
        return(FALSE);
    }

    for(iRegSaldo=0;iRegSaldo<SaldoTot->iNum_RegSaldo;iRegSaldo++)
    {
        dTotalNetoImpto=SaldoTot->stReg[iRegSaldo].dTotalSaldoAnt + dTotalPrimeraCateg + dTotalSegundaCateg;

        sprintf(buffer_local,REG_B4006,        
                                      stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                                      stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                                      stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                                      stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                                      SaldoTot->stReg[iRegSaldo].dTotalSaldoAnt,
                                      SaldoTot->stReg[iRegSaldo].szDes_Saldo,
                                      SaldoTot->stReg[iRegSaldo].lNum_Folio,
                                      SaldoTot->stReg[iRegSaldo].szFechaEfectiva,
                                      dTotalPrimeraCateg,     	
                                      dTotalSegundaCateg,     	
                                      dTotalPorcenPrimeraCateg,   
                                      dTotalPorcenSegundaCateg,   
                                      dTotalNetoImpto);           

        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
        {
             vDTrazasLog(szModulo,"No pudo escribir en archivo",LOG01);
             return(FALSE);
        }
    }
    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4005                                     */
/**********************************************************************************************/
int put_b4005 ( FILE *Fd_ArchImp,
                int  iRegConcep, 
                char * buffer)
{
    char buffer_local[200];
    double dTotalPrimeraCateg       = 0.0;  
    double dTotalSegundaCateg       = 0.0;  
    double dTotalNetoImpto          = 0.0;     
    double dTotalPorcenPrimeraCateg = 0.0;
    double dTotalPorcenSegundaCateg = 0.0;
    
    memset(buffer_local,0,sizeof(buffer_local));

/*  Llama la a funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
       {
             if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna,&dTotalPrimeraCateg, &dTotalSegundaCateg ))
            {
               vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
               return(FALSE);
            }
            
            dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
            dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
       }
    dTotalNetoImpto=stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet + dTotalPrimeraCateg + dTotalSegundaCateg;
    
    /* Llama a la funcion que Totaliza el porcentaje de impuestos */
    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
    {
        vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
        return(FALSE);
    }
         
    sprintf(buffer_local,REG_B4005,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                         stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet,
                         stFaDetCons.stDetConsumo[iRegConcep].szFec_Pago,
                         0,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp,
                         dTotalPrimeraCateg,
                         dTotalSegundaCateg,
                         dTotalPorcenPrimeraCateg,
                         dTotalPorcenSegundaCateg,
                         dTotalNetoImpto,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp);

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
      vDTrazasLog("put_b4005","No pudo escribir en archivo",LOG01);
      return(FALSE);
    }
    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4004                                     */
/**********************************************************************************************/
int put_b4004 ( FILE *Fd_ArchImp,
                int  iRegConcep,
                char * buffer)
{
    char buffer_local[200];
    double dTotalPrimeraCateg       = 0.0;
    double dTotalSegundaCateg       = 0.0;   
    double dTotalNetoImpto          = 0.0;      
    double dTotalPorcenPrimeraCateg = 0.0;
    double dTotalPorcenSegundaCateg = 0.0;
    
    memset(buffer_local,0,sizeof(buffer_local));

    /*  Llama a funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
       {
         if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna, &dTotalPrimeraCateg, &dTotalSegundaCateg ))
            {
               vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
               return(FALSE);
            }
            dTotalPrimeraCateg  = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
            dTotalSegundaCateg  = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
       }
    dTotalNetoImpto=stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet + dTotalPrimeraCateg + dTotalSegundaCateg;

/* Llama a la funcion que Totaliza el porcentaje de impuestos */
    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
       {
         vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
         return(FALSE);
       }
    sprintf(buffer_local,REG_B4004,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                         stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet,
                         stFaDetCons.stDetConsumo[iRegConcep].iNum_Unidades,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp,
                         dTotalPrimeraCateg,
                         dTotalSegundaCateg,        
                         dTotalPorcenPrimeraCateg,  
                         dTotalPorcenSegundaCateg,  
                         dTotalNetoImpto,
                         stFaDetCons.stDetConsumo[iRegConcep].dImpFactConIva);          

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
      vDTrazasLog("put_b4004","No pudo escribir en archivo",LOG01);
      return(FALSE);
    }

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4003                                     */
/**********************************************************************************************/
int put_b4003(FILE *Fd_ArchImp,int iRegConcep,char * buffer)
{
    char szResultado[13];
    char szSegundosReal[13];
    char szSegundosDcto[13];
    char buffer_local[350];
    double dTotalPrimeraCateg       = 0.0;   
    double dTotalSegundaCateg       = 0.0;   
    double dTotalNetoImpto          = 0.0;      
    double dTotalPorcenPrimeraCateg = 0.0;   
    double dTotalPorcenSegundaCateg = 0.0;   
    
    memset(buffer_local,0,sizeof(buffer_local));

    sprintf(szResultado,"%12.12ld",stFaDetCons.stDetConsumo[iRegConcep].lSeg_Consumo);
    sprintf(szSegundosReal,"%12.12ld",stFaDetCons.stDetConsumo[iRegConcep].lSeg_ConsumoReal);
    sprintf(szSegundosDcto,"%12.12ld",stFaDetCons.stDetConsumo[iRegConcep].lSeg_ConsumoDcto);

/*  Llama a la funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
       {        
           if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna, &dTotalPrimeraCateg, &dTotalSegundaCateg ))
           {
              vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
              return(FALSE);
           }
           dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
           dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
       }
    dTotalNetoImpto=stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet + dTotalPrimeraCateg + dTotalSegundaCateg;

/* Llama a la funcion que Totaliza el porcentaje de impuestos */
    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
         {
            vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
            return(FALSE);
         }

    sprintf(buffer_local,REG_B4003,    
                          stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                          stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                          stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                          stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                          stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet,
                          szResultado,
                          stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp,
                          szSegundosReal,
                          szSegundosDcto,
                          stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableReal,
                          stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableDcto,
                          stFaDetCons.stDetConsumo[iRegConcep].lCntLlamReal,
                          stFaDetCons.stDetConsumo[iRegConcep].lCntLlamDcto,
                          stFaDetCons.stDetConsumo[iRegConcep].lCntLlamFAct,
                          dTotalPrimeraCateg,
                          dTotalSegundaCateg,
                          dTotalPorcenPrimeraCateg,
                          dTotalPorcenSegundaCateg,
                          dTotalNetoImpto,         
                          stFaDetCons.stDetConsumo[iRegConcep].lNumPulsos,
                          stFaDetCons.stDetConsumo[iRegConcep].dImpFactConIva);
    
    vDTrazasLog("put_b4003", "\n\t\t[%d] iColumna=[%d] lNumAbonado=[%ld] iCodConcepto=[%d] lCntLlamReal=[%ld] lCntLlamDcto=[%ld] lCntLlamFAct=[%ld]"
    		             "buffer_local[%s]"
    			   , LOG05,iRegConcep
    			   , stFaDetCons.stDetConsumo[iRegConcep].iColumna
    			   , stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado
    			   , stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto
    			   , stFaDetCons.stDetConsumo[iRegConcep].lCntLlamReal
    			   , stFaDetCons.stDetConsumo[iRegConcep].lCntLlamDcto
    			   , stFaDetCons.stDetConsumo[iRegConcep].lCntLlamFAct
    			   , buffer_local);

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
      vDTrazasLog("put_b4003","No pudo escribir en archivo",LOG01);
      return(FALSE);
    }

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4002                                     */
/**********************************************************************************************/
int put_b4002 ( FILE *Fd_ArchImp,
                int  iRegConcep,
                char * buffer)
{
    char buffer_local[200];
    double dTotalPrimeraCateg       = 0.0;   
    double dTotalSegundaCateg       = 0.0;   
    double dTotalNetoImpto          = 0.0;   
    double dTotalPorcenPrimeraCateg = 0.0;   
    double dTotalPorcenSegundaCateg = 0.0;   
    
    memset(buffer_local,0,sizeof(buffer_local));

/* Llama a la funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
        {
          if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna, &dTotalPrimeraCateg, &dTotalSegundaCateg ))
              {
                 vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
                 return(FALSE);
              }
              
              dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
              dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
         }
    dTotalNetoImpto=stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet + dTotalPrimeraCateg + dTotalSegundaCateg;

    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
         {
            vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
            return(FALSE);
         }

    sprintf(buffer_local,REG_B4002,
                        stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                        stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                        stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                        stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                        stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet,
                        stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp,
                        dTotalPrimeraCateg,        
                        dTotalSegundaCateg,        
                        dTotalPorcenPrimeraCateg,  
                        dTotalPorcenSegundaCateg,  
                        dTotalNetoImpto,
                        stFaDetCons.stDetConsumo[iRegConcep].dImpFactConIva);

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
      vDTrazasLog("put_b4002","No pudo escribir en archivo",LOG01);
      return(FALSE);
    }

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B4001                                     */
/**********************************************************************************************/
int put_b4001 ( FILE           *Fd_ArchImp,
                PLAN_TARIFARIO *pst_PlanTarifario,
                int            iRegConcep,
                char           * buffer)
{

    long           lMinPlan;
    double         dMtoPlan;
    int            iPosicionMinutoAdicional=-1;
    char           szMtoMinAdicNorm[16+1];
    char           szMtoMinAdicRedu[16+1];
    char           szMtoMinAdicRoam[16+1];
    char           szMtoMinAdicFrec[16+1];
    char           szResultado[13];
    char           buffer_local[350];
    char           szPlan[40];
    char           szCodPlan[4];
    char           szllaveMinutos[7];
    PLAN_TARIFARIO pstPlan;
    double         dTotalPrimeraCateg       = 0.0;
    double         dTotalSegundaCateg       = 0.0;
    double         dTotalNetoImpto          = 0.0;
    double         dTotalPorcenPrimeraCateg = 0.0;
    double         dTotalPorcenSegundaCateg = 0.0;

    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

         double dMtoMinAdicNorm = 0;
         double dMtoMinAdicRedu = 0;
         double dMtoMinAdicRoam = 0;
         double dMtoMinAdicFrec = 0;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "put_b4001");
    memset(buffer_local,0,sizeof(buffer_local));

    memset(szCodPlan,0,sizeof(szCodPlan));
    strcpy(szPlan,NO_EXISTE_PLAN);
    lMinPlan = 0;
    dMtoPlan = 0;
    memset(szMtoMinAdicNorm,0,sizeof(szMtoMinAdicNorm));
    memset(szMtoMinAdicRedu,0,sizeof(szMtoMinAdicRedu));
    memset(szMtoMinAdicRoam,0,sizeof(szMtoMinAdicRoam));
    memset(szMtoMinAdicFrec,0,sizeof(szMtoMinAdicFrec));

    sprintf(szResultado,"%12.12ld",stFaDetCons.stDetConsumo[iRegConcep].lSeg_Consumo);
    
    if (bfnFindCod_PlanTarif(stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif ,&pstPlan))
    {
       strcpy(szCodPlan,pstPlan.szCod_Plantarif);
       strcpy(szPlan,pstPlan.szDes_Plantarif);
       lMinPlan = pstPlan.lMinutosPlan;
       dMtoPlan = pstPlan.dValorPlan;


       sprintf(szllaveMinutos,"%s",NUMERO_NORMAL);
       iPosicionMinutoAdicional=buscaMinutoAdicional(szCodPlan,szllaveMinutos);
       if(iPosicionMinutoAdicional < 0)
       {
           vDTrazasLog  (szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Normal**",LOG03,szCodPlan);
           vDTrazasError(szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Normal**",LOG03,szCodPlan);

           memset(szMtoMinAdicNorm,0,sizeof(szMtoMinAdicNorm));
       }
       else
       {
           dMtoMinAdicNorm=sthMinutoAdicional.dMtoAdicional[iPosicionMinutoAdicional];
           sprintf(szMtoMinAdicNorm,"%015.4f\0",dMtoMinAdicNorm);
           iPosicionMinutoAdicional=-1;
       }

       sprintf(szllaveMinutos,"%s",NUMERO_REDUCIDO);
       iPosicionMinutoAdicional=buscaMinutoAdicional(szCodPlan,szllaveMinutos);
       if(iPosicionMinutoAdicional < 0)
       {
           vDTrazasLog  (szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Reducido**",LOG03,szCodPlan);
           vDTrazasError(szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Reducido**",LOG03,szCodPlan);

           memset(szMtoMinAdicRedu,0,sizeof(szMtoMinAdicRedu));
       }
       else
       {
           dMtoMinAdicRedu=sthMinutoAdicional.dMtoAdicional[iPosicionMinutoAdicional];
           sprintf(szMtoMinAdicRedu,"%015.4f\0",dMtoMinAdicRedu);
           iPosicionMinutoAdicional=-1;
       }

       sprintf(szllaveMinutos,"%s",NUMERO_ROAMING);
       iPosicionMinutoAdicional=buscaMinutoAdicional(szCodPlan,szllaveMinutos);
       if(iPosicionMinutoAdicional < 0)
       {
           vDTrazasLog  (szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Roaming**",LOG03,szCodPlan);
           vDTrazasError(szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Roaming**",LOG03,szCodPlan);

           memset(szMtoMinAdicRoam,0,sizeof(szMtoMinAdicRoam));
       }
       else
       {
           dMtoMinAdicRoam=sthMinutoAdicional.dMtoAdicional[iPosicionMinutoAdicional];
           sprintf(szMtoMinAdicRoam,"%015.4f\0",dMtoMinAdicRoam);
           iPosicionMinutoAdicional=-1;
       }

       sprintf(szllaveMinutos,"%s",NUMERO_FRECUENTE);
       iPosicionMinutoAdicional=buscaMinutoAdicional(szCodPlan,szllaveMinutos);
       if(iPosicionMinutoAdicional < 0)
       {
           vDTrazasLog  (szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Frecuente**",LOG03,szCodPlan);
           vDTrazasError(szModulo,"\n\t**  Plan [%s] ===> Error en Estructura de cobros Frecuente**",LOG03,szCodPlan);

           memset(szMtoMinAdicFrec,0,sizeof(szMtoMinAdicFrec));
       }
       else
       {
           dMtoMinAdicFrec=sthMinutoAdicional.dMtoAdicional[iPosicionMinutoAdicional];
           sprintf(szMtoMinAdicFrec,"%015.4f\0",dMtoMinAdicFrec);
           iPosicionMinutoAdicional=-1;
       }
    }
    
    vDTrazasLog(szModulo, "\n\t\tNumero Normal    [%s] "
                          "\n\t\tNumero Reducido  [%s]"
                          "\n\t\tNumero Roaming   [%s]"
                          "\n\t\tNumero Frecuente [%s]"
                          "\n\t\tCodigo           [%s]"
                          "\n\t\tDesc             [%s]"
                          "\n\t\tMinutos          [%ld]"
                          "\n\t\tValor            [%f]\n"
                        , LOG04,szMtoMinAdicNorm
                        , szMtoMinAdicRedu
                        , szMtoMinAdicRoam
                        , szMtoMinAdicFrec
                        , szCodPlan
                        , szPlan
                        , lMinPlan
                        , dMtoPlan);


/* Llama a la funcion que Totaliza los impuestos considerando los conceptos relacionados */
    bfnLimpiaFlag(&pstCatImpues);    
    if (stFaDetCons.stDetConsumo[iRegConcep].iCodTipConce !=1)
    {
        if (!bfnTotImptosCateg(stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto, stFaDetCons.stDetConsumo[iRegConcep].iColumna,&dTotalPrimeraCateg, &dTotalSegundaCateg ))
        {
             vDTrazasLog(szModulo, "\tError en regreso de funcion bfnTotImptosCateg ", LOG05);
             return(FALSE);
        }
        dTotalPrimeraCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalPrimeraCateg;
        dTotalSegundaCateg = stFaDetCons.stDetConsumo[iRegConcep].dTotalSegundaCateg;
    }
    dTotalNetoImpto=stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet + dTotalPrimeraCateg + dTotalSegundaCateg;

/* Llama a la funcion que Totaliza el porcentaje de impuestos */
    if (!bfnPorcenImptosCateg(&dTotalPorcenPrimeraCateg, &dTotalPorcenSegundaCateg ))
    {
        vDTrazasLog(szModulo, "\tError en regreso de funcion bfnPorcenImptosCateg ", LOG05);
        return(FALSE);
    }

    sprintf(buffer_local,REG_B4001,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                         stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto,
                         stFaDetCons.stDetConsumo[iRegConcep].szDes_Concepto,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableNet,
                         szResultado,
                         stFaDetCons.stDetConsumo[iRegConcep].dTotalFacturableImp,
                         stFaDetCons.stDetConsumo[iRegConcep].szCod_CargoBasico,
                         stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif,
                         szPlan,
                         lMinPlan,
                         dMtoPlan,
                         szMtoMinAdicNorm,
                         szMtoMinAdicRedu,
                         szMtoMinAdicRoam,
                         szMtoMinAdicFrec,
                         dTotalPrimeraCateg,
                         dTotalSegundaCateg,
                         dTotalPorcenPrimeraCateg,
                         dTotalPorcenSegundaCateg,
                         dTotalNetoImpto,
                         stFaDetCons.stDetConsumo[iRegConcep].dImpFactConIva); /* P-MIX-09003 77 */

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
       vDTrazasLog(szModulo,"No pudo escribir en archivo",LOG01);
       return(FALSE);
    }

    return(TRUE);
}

/**********************************************************************************************/
/*                               IMPRESION REGISTRO B5000                                     */
/**********************************************************************************************/
int put_b5000(FILE *Fd_ArchImp,int iRegConcepAUX, char * buffer)
{
    char buffer_local[170];
    int i =0;
    long lNumAbonado = 0;

    strcpy(szModulo,"put_b5000");
    
    vDTrazasLog(szModulo, "\tEntro funcion put_b5000", LOG03);
    
    memset(buffer_local,0,sizeof(buffer_local));

    
    lNumAbonado = stFaDetCons.stDetConsumo[iRegConcepAUX].lNumAbonado;
    
    vDTrazasLog(szModulo,   "\tstBenefPromo.lNumBenef               = [%ld]\n"
    						"\tstFaDetCons.stDetConsumo.lNumAbonado = [%ld]\n"
        					,LOG06,stBenefPromo.lNumBenef, lNumAbonado);
  
    for(i=0;i<stBenefPromo.lNumBenef;i++)
    {
        
        vDTrazasLog(szModulo, "\tput_b5000 \n"
        					  "\tstBenefPromo.stNodo.lNumAbonado      = [%ld]\n"
        					  ,LOG06,stBenefPromo.stNodo[i].lNumAbonado);
        					  
        if(stBenefPromo.stNodo[i].lNumAbonado == lNumAbonado)
        {
            
            vDTrazasLog(szModulo, "\tImprime registro b5000", LOG03);
            
            sprintf(buffer_local,REG_B5000            
                            ,stBenefPromo.stNodo[i].szCodEstadoBenef
                            ,stBenefPromo.stNodo[i].szCodPlan
                            ,stBenefPromo.stNodo[i].szDesPlan
                            ,stBenefPromo.stNodo[i].iNumPeriodos
                            ,stBenefPromo.stNodo[i].iPeriodosOtor
                            ,stBenefPromo.stNodo[i].iPeriodosRest
                            ,stBenefPromo.stNodo[i].iMinAdicionales
                            ,stBenefPromo.stNodo[i].dMontCargaAdic
                            ,stBenefPromo.stNodo[i].szNomUsuario
                            ,stBenefPromo.stNodo[i].szFecIngreso
                            ,stBenefPromo.stNodo[i].dValAcumulado
                            ,stBenefPromo.stNodo[i].szCodEstado
                            ,stBenefPromo.stNodo[i].szIndReevalua
                            ,stBenefPromo.stNodo[i].szTipBeneficio
                            );
                                                    
            if (!bEscribeEnArchivo(Fd_ArchImp, buffer, buffer_local))
            {
                vDTrazasLog(szModulo, "\tError en regreso de funcion bEscribeEnArchivo ", LOG05);
                return(FALSE);
            }
            memset(buffer_local,0,sizeof(buffer_local));
        }
    }
    
    return(TRUE);
}

/**********************************************************************************/
/* FUNCION : put_b1000                                                            */
/**********************************************************************************/
int put_b1000 ( ST_ABONADO *Abonado,
                FILE       *Fd_ArchImp,
                int        iRegConcep,
                int        AbonadoEncontrado, 
                long       Abonado_Cero,
                char       * buffer)
{
    char buffer_local[350];

    memset(buffer_local,0,sizeof(buffer_local));
    sprintf(buffer_local,"H1000\n\0");

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
       vDTrazasLog("put_b1000","No pudo escribir en archivo",LOG01);
       return(FALSE);
    }

    lhNumAbonado = stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado;
    if (lhNumAbonado != 0)
    {
        /* EXEC SQL BEGIN DECLARE SECTION; */ 

             char Num_ident  [21];
             char Nom_calle  [51];
             char Num_calle  [11];
             char Num_piso   [11];
             char Des_comuna [31];
             char Des_ciudad [31];
             char Zip        [16];
             char Des_pais   [31];
             char Des_estado [31];
             char Des_pueblo [31];
             char szhCodPrestacionAbon [5+1]; /* EXEC SQL VAR szhCodPrestacionAbon IS STRING(5+1); */ 

        /* EXEC SQL END DECLARE SECTION; */ 


        memset(szhCodPrestacionAbon,'\0',sizeof(szhCodPrestacionAbon));

        /* EXEC SQL OPEN Cursor_GetDireccion; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 45;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = sq0002;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )381;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
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


        if (SQLCODE != SQLOK)
        {
            vDTrazasError("put_b1000","Error en OPEN Cursor_GetDireccion %s", LOG01, SQLERRM);
            return(FALSE);
        }
        
        /* EXEC SQL FETCH Cursor_GetDireccion
                 INTO    :Num_ident,  :Nom_calle, :Num_calle, :Num_piso,   :Des_comuna,
                         :Des_ciudad, :Zip,       :Des_pais,  :Des_estado, :Des_pueblo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 45;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )400;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)Num_ident;
        sqlstm.sqhstl[0] = (unsigned long )21;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)Nom_calle;
        sqlstm.sqhstl[1] = (unsigned long )51;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)Num_calle;
        sqlstm.sqhstl[2] = (unsigned long )11;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)Num_piso;
        sqlstm.sqhstl[3] = (unsigned long )11;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)Des_comuna;
        sqlstm.sqhstl[4] = (unsigned long )31;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)Des_ciudad;
        sqlstm.sqhstl[5] = (unsigned long )31;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)Zip;
        sqlstm.sqhstl[6] = (unsigned long )16;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)Des_pais;
        sqlstm.sqhstl[7] = (unsigned long )31;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)Des_estado;
        sqlstm.sqhstl[8] = (unsigned long )31;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)Des_pueblo;
        sqlstm.sqhstl[9] = (unsigned long )31;
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


                         
        if (sqlca.sqlcode == SQLNOTFOUND)
        {
            vDTrazasLog("put_b1000", "\n\tSQLNOTFOUND Cursor_GetDireccion. Error [%d][%s] "
                                     "\n\tSQLNOTFOUND Numero de abonado => [%ld]"
                                   , LOG05, sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc
                                   , lhNumAbonado);
            return (FALSE);
        }
        
        /* Recupero Cod. Prestacion para Num. Abonado */
        if (!bfnFindCodPrestacionAbon(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado, szhCodPrestacionAbon))
        {
            return (FALSE);
        }

        sprintf(buffer_local, REG_B1000
                            , (Abonado_Cero==0)? Abonado_Cero:(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)
                            , stFaDetCons.stDetConsumo[iRegConcep].szNum_Celular
                            , (AbonadoEncontrado==-1)? "":(Abonado->sznom_usuario[AbonadoEncontrado])
                            , (AbonadoEncontrado==-1)? "":(Abonado->sznom_apellido1[AbonadoEncontrado])
                            , (AbonadoEncontrado==-1)? "":(Abonado->sznom_apellido2[AbonadoEncontrado])
                            , Nom_calle
                            , Num_calle
                            , Num_piso
                            , Des_comuna
                            , Des_pais
                            , Des_estado
                            , Des_ciudad
                            , Des_pueblo
                            , Zip
                            , " "
                            , " "
                            , " "
                            , Num_ident
                            , Abonado->iIndCobroDetLlam[AbonadoEncontrado]
                            , szhCodPrestacionAbon);
    }
    else
    {
      sprintf(buffer_local, REG_B1000
                          , (Abonado_Cero==0)? Abonado_Cero:(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)
                          , stFaDetCons.stDetConsumo[iRegConcep].szNum_Celular
                          , (AbonadoEncontrado==-1)? "":(Abonado->sznom_usuario[AbonadoEncontrado])
                          , (AbonadoEncontrado==-1)? "":(Abonado->sznom_apellido1[AbonadoEncontrado])
                          , (AbonadoEncontrado==-1)? "":(Abonado->sznom_apellido2[AbonadoEncontrado])
                          , "","","","","","","","","","","","","",0,"");
    }
    
    if (!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
        vDTrazasLog("put_b1000","\n\t Error - No se pudo escribir en archivo salida (.DAT)",LOG01);
        return(FALSE);
    }

    return(TRUE);
}
/********************************** Fin put_b1000 *********************************/

int put_b1100(ST_FACTCLIE *pst_Cliente,FILE *Fd_ArchImp,int iRegConcep,long Abonado_Cero,char * buffer)
{
    char buffer_local[200];
    char szllave[17];
    int  iInicio,iTermino,ArrastreEncontrado;

    vDTrazasLog("","put_b1100 ENTRADA CLIENTE/ABONADO=%ld - %ld\n",LOG03,pst_Cliente->lCodCliente, (Abonado_Cero==0)? Abonado_Cero:(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)); 

    memset(buffer_local,0,sizeof(buffer_local));

    sprintf(szllave,"%08ld%08ld\0",pst_Cliente->lCodCliente,(Abonado_Cero==0)? Abonado_Cero:(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado));
    vDTrazasLog("","put_b1100 \t a busca_arrastre Llave=[%s]\n",LOG06,szllave);
    if(!busca_arrastre(szllave,&iInicio,&iTermino))
    {
      sprintf(buffer_local,REG_B1100,
                                    "     ",
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0,
                                    0.0);
    }
    vDTrazasLog("","put_b1100 \t Inicio=%d Termino=%d total=%d\n",LOG06,iInicio,iTermino, sthDetArrastre.iCantidadArrastre);

    for(ArrastreEncontrado=iInicio;ArrastreEncontrado<=iTermino && ArrastreEncontrado<=sthDetArrastre.iCantidadArrastre;ArrastreEncontrado++)
    {
        vDTrazasLog("","put_b1100 \t indice Arrastre =%d <= iTermino=%d\n",LOG06,ArrastreEncontrado,iTermino);
        
         sprintf(buffer_local,REG_B1100,
                            sthDetArrastre.szIndUnidad[ArrastreEncontrado],
                            sthDetArrastre.dValArrastre[ArrastreEncontrado],
                            sthDetArrastre.dValExpirado[ArrastreEncontrado],
                            sthDetArrastre.dValDisponible[ArrastreEncontrado],
                            sthDetArrastre.dValConsumo[ArrastreEncontrado],
                            sthDetArrastre.dValResto[ArrastreEncontrado]);
    }

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
      vDTrazasLog("put_b1100","No pudo escribir en archivo",LOG01);
      return(FALSE);
    }

    vDTrazasLog("","put_b1100 SALIDA CLIENTE/ABONADO=%ld - %ld\n",LOG03,pst_Cliente->lCodCliente, (Abonado_Cero==0)? Abonado_Cero:(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado));
    return(TRUE);
}

/****************************************************************************************/
/* FUNCION : put_b1200                                                                  */
/****************************************************************************************/
int put_b1200(FILE *Fd_ArchImp,int iRegConcep, ST_FACTCLIE *pst_Cliente, char * buffer)
{
    /*Usamos pstPlanes que es una estructura definida en ImpSclSt.h */
    char           buffer_local[200];
    PLAN_TARIFARIO *pstAux = (PLAN_TARIFARIO *)NULL;
    PLAN_TARIFARIO stkey;
    double         dValorHorAlta=0.0;
    double         dValorHorNorm=0.0;
    double         dValorHorBaja=0.0;
    double         dImpMontoBase=0.0; /* P-MIX-09003 */
    MINPLAN        pstMinPlanAux;
    char           szCodThor[21];
    int            piRegConcep=0;
    register long  lIdx=0;
    char           szValorPlan[30]   ="";
    char           szValorHorAlta[30]="";
    char           szValorHorNorm[30]="";
    char           szValorHorBaja[30]="";
    char           szCodPlanTarifAbo [4]="";

    strcpy (szModulo, "put_b1200");

    vDTrazasLog(szModulo,"Entrando a funcion",LOG06);

    if (  stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado > 0)
    {
        if (stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto == iCodAbonoCel) /* corresponde a carga basico */
        {
            piRegConcep = iRegConcep;
        }
        else
        { /* busca cargo basico del abonado */
            for(lIdx=0;lIdx < stFaDetCons.iNumReg;lIdx++)
            {
                if (stFaDetCons.stDetConsumo[lIdx].lNumAbonado == stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado && stFaDetCons.stDetConsumo[lIdx].iCodConcepto == iCodAbonoCel)
                {
                    piRegConcep = lIdx;
                }
            }
        }


       if (stFaDetCons.stDetConsumo[iRegConcep].iCodConcepto != iCodAbonoCel) /* No es cargo basico Error */
       {
           vDTrazasLog(szModulo,"No existe Cargo basico para el abonado, se consulta ",LOG03);
           if (!bfnGetPlanTarifAbo(stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado, pst_Cliente->lCodCliente, szCodPlanTarifAbo))
           {
               vDTrazasLog(szModulo, "Put_B1200:No se enconmtro plan tarifario para el abonado [%ld] en GA_INTARCEL", LOG01, stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado);
               return (FALSE);
           }
           strcpy (stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif, szCodPlanTarifAbo);
           piRegConcep = iRegConcep;
       }
    }
    else
    {
        if(pst_Cliente->szPlanTarif==NULL)
        {
            vDTrazasLog(szModulo,"(put_b1200)Por primer if(NULL), abonado 0",LOG05);
            strcpy (stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif,"   ");
        }
        else
        {
            vDTrazasLog(szModulo,"(put_b1200)Por else (not NULL), abonado 0",LOG05);
            strcpy (stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif, pst_Cliente->szPlanTarif);
        }

        vDTrazasLog(szModulo, "(put_b1200)Abonado 0, stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif[%d]: [%s]"
                            , LOG04, iRegConcep
                            , stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif);

        piRegConcep = iRegConcep;
    }

    strcpy(stkey.szCod_Plantarif,alltrim(stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif));

    if ( (pstAux = (PLAN_TARIFARIO *)bsearch (&stkey, pstPlanes.stPlanesTarifarios , pstPlanes.iNumRegPlanTarif,
        sizeof (PLAN_TARIFARIO),ifnCmpCod_PlanTarif ))== (PLAN_TARIFARIO *)NULL)
    {
        vDTrazasLog(szModulo, "Put_B1200: Codigo Plan Tarifario [%s] no encontrado ..."
                            , LOG01, stFaDetCons.stDetConsumo[iRegConcep].szCod_PlanTarif);
        return  (TRUE);
    }

    dValorHorAlta = 0.0;
    dValorHorNorm = 0.0;
    dValorHorBaja = 0.0;

    /* Horaio Alto */
    memset(&pstMinPlanAux,'\0', sizeof(MINPLAN));
    strcpy (szCodThor, stGedParametros.szTolCodTHorAlta );
    vDTrazasLog(szModulo, "Put_B1200: Horario Alto THor [%s]", LOG05,szCodThor);

    if (bfnFindMinPlan(stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif, szCodThor, &pstMinPlanAux))
    {
        dValorHorAlta = pstMinPlanAux.dMto_Inic;
    }

    /* Horario Normal */
    memset(&pstMinPlanAux,'\0', sizeof(pstMinPlanAux));
    strcpy (szCodThor, stGedParametros.szTolCodTHor );
    vDTrazasLog(szModulo, "Put_B1200: Horario Normal THor [%s]", LOG05,szCodThor);

    if (bfnFindMinPlan (stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif, szCodThor, &pstMinPlanAux))
    {
        dValorHorNorm = pstMinPlanAux.dMto_Inic;
    }

    /* Horario Reducido */
    memset(&pstMinPlanAux,'\0', sizeof(pstMinPlanAux));
    strcpy (szCodThor, stGedParametros.szTolCodTHorBaja );
    vDTrazasLog(szModulo, "Put_B1200: Horario Reducido THor [%s]", LOG05,szCodThor);
    if (bfnFindMinPlan (stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif, szCodThor, &pstMinPlanAux))
    {
        dValorHorBaja = pstMinPlanAux.dMto_Inic;
    }

        /* Imprimir en blanco si los valores totales vienen en cero */
    if(pstAux->dValorPlan==0.0)
    {
        sprintf(szValorPlan,"%s"," ");
    }
    else
    {
        sprintf(szValorPlan,"%015.4f",pstAux->dValorPlan);
    }

    if(dValorHorAlta==0.0)
    {
        vDTrazasLog(szModulo, "Put_B1200: No se encontro tarifa Alta plan [%s] se deja blanco ", LOG01, stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif);
        sprintf(szValorHorAlta,"%s"," ");
    }
    else
        sprintf(szValorHorAlta,"%015.4f",dValorHorAlta);

    if(dValorHorNorm==0.0)
    {
        vDTrazasLog(szModulo, "Put_B1200: No se encontro tarifa Normal plan [%s] se deja blanco ", LOG01, stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif);
        sprintf(szValorHorNorm,"%s"," ");
    }
    else
    {
        sprintf(szValorHorNorm,"%015.4f",dValorHorNorm);
    }

    if(dValorHorBaja==0.0)
    {
        vDTrazasLog(szModulo, "Put_B1200: No se encontro tarifa Baja plan [%s] se deja blanco ", LOG01, stFaDetCons.stDetConsumo[piRegConcep].szCod_PlanTarif);
        sprintf(szValorHorBaja,"%s"," ");
    }
    else
    {
        sprintf(szValorHorBaja,"%015.4f",dValorHorBaja);
    }
        
    dImpMontoBase = stFaDetCons.stDetConsumo[piRegConcep].dImpMontoBase; /* P-MIX-09003 */

    sprintf(buffer_local, REG_B1200
                        , pstAux->szCod_Plantarif
                        , pstAux->szDes_Plantarif
                        , szValorPlan
                        , pstAux->lMinutosPlan
                        , szValorHorAlta
                        , szValorHorNorm
                        , szValorHorBaja
                        , szFec_Desde
                        , szFec_Hasta
                        , dImpMontoBase
                        , pstAux->szCod_Prestacion); /* P-MIX-09003 130964 */

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
        vDTrazasLog("put_b1200","No pudo escribir en archivo",LOG01);
        return(FALSE);
    }
    return  (TRUE);

}

int put_b1300(FILE *Fd_ArchImp,int iRegConcep,char * buffer)
{
    char    buffer_local[200];
    register long  i;
    int     iCategoria;
    long    lTotMinTrafico      = 0;
    double  dTotMtoCargoTrafico = 0.0;
    double  dTotMtoCargoBasico  = 0.0;
    double  dTotMtoServicios    = 0.0;
    double  dTotMtoOtrosCargos  = 0.0;
    double  dTotCargosNetos     = 0.0;
    double  dTotPrimCateg       = 0.0;
    double  dTotSegCateg        = 0.0;
    double  dTotAbonado         = 0.0;
    long    lhNumAbonado;

    strcpy (szModulo, "put_b1300");
    vDTrazasLog(szModulo,"Entrando a funcion %s",LOG05, szModulo);

    lhNumAbonado = stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado;

    vDTrazasLog(szModulo,"abonado [%ld]"
                         "CantidadConceptos [%d]",LOG05, lhNumAbonado, stFaDetCons.iNumReg);

    for (i=0;i < stFaDetCons.iNumReg ;i++)
    {
        if (stFaDetCons.stDetConsumo[i].lNumAbonado == lhNumAbonado)
        {
            lTotMinTrafico = lTotMinTrafico + stFaDetCons.stDetConsumo[i].iNum_Unidades;

            vDTrazasLog(szModulo,"iTipConcep [%d]",LOG05, stFaDetCons.stDetConsumo[i].iTipConcep);
            switch(stFaDetCons.stDetConsumo[i].iTipConcep)
            {
              case 1:
                    dTotMtoCargoTrafico += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                    break;
              case 2:
                    dTotMtoCargoBasico  += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                    break;
              case 3:
                    dTotMtoServicios    += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                    break;
              case 4:
                    dTotMtoOtrosCargos  += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                    break;
            }
            vDTrazasLog(szModulo,"iCodTipConce [%d]"
                                 "dTotalFacturableNet [%15.4f]"
                                 ,LOG05, stFaDetCons.stDetConsumo[i].iCodTipConce, stFaDetCons.stDetConsumo[i].dTotalFacturableNet);
            if (stFaDetCons.stDetConsumo[i].iCodTipConce != 1)
            {
               dTotCargosNetos += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
            }
            else
            {
               if(bfnBuscaCategImpto(stFaDetCons.stDetConsumo[i].iCodConcepto,&iCategoria,stFaDetCons.stDetConsumo[i].dPrcImpuesto))
               {
                  if (iCategoria == iGPrimCateg)
                  {
                     dTotPrimCateg += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                  }
                  else
                  {
                     dTotSegCateg += stFaDetCons.stDetConsumo[i].dTotalFacturableNet;
                  }
               }
            }
        }
    }

    dTotAbonado=dTotCargosNetos + dTotPrimCateg + dTotSegCateg;
    vDTrazasLog(szModulo,"dTotAbonado [%15.4f]",LOG05, dTotAbonado);

    sprintf(buffer_local,REG_B1300,    
                        lTotMinTrafico,
                        dTotMtoCargoTrafico,
                        dTotMtoCargoBasico,
                        dTotMtoServicios,
                        dTotMtoOtrosCargos,
                        dTotCargosNetos,
                        dTotPrimCateg,
                        dTotSegCateg,
                        dTotAbonado);

    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
    {
        vDTrazasLog("put_b1300","No pudo escribir en archivo",LOG01);
        return(FALSE);
    }

    return(TRUE);

}

int put_b2000_b3000(FILE *Fd_ArchImp, int iRegConcep,int breg23, int *impb2000,int *impb3000,char * buffer)
{
    char buffer_local[200];
    register int i = 0;
    long lDuracion = 0L;

    strcpy (szModulo, "put_b2000_b3000");

    memset(buffer_local,0,sizeof(buffer_local));

    if(breg23==2 || breg23==0)
    {
        /* Realizar acumulacion de segundos consumidos. */
        for(i=0;i<stFaDetCons.iNumReg;i++)
        {
            if( (stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo == stFaDetCons.stDetConsumo[i].iCodGrupo)
                    && (stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado == stFaDetCons.stDetConsumo[i].lNumAbonado) )
                lDuracion += stFaDetCons.stDetConsumo[i].lSeg_Consumo;
        }

        sprintf(buffer_local,REG_B2000        
            ,stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo
            ,stFaDetCons.stDetConsumo[iRegConcep].szGlosaGrupo
            ,stFaDetCons.stDetConsumo[iRegConcep].szCod_Nivel
            ,lDuracion                                  
            ,stFaDetCons.stDetConsumo[iRegConcep].iNivelImpresion  
            ,stFaDetCons.stDetConsumo[iRegConcep].szTipUnidad      
            ,stFaDetCons.stDetConsumo[iRegConcep].szTipGrupo);     

        *impb2000 = TRUE;

        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
        {
            vDTrazasLog(szModulo,"No pudo escribir en archivo -2-",LOG01);
            return(FALSE);
        }
    }
    if(breg23 == 3 || breg23==0)
    {
        sprintf(buffer_local,REG_B3000,
                            stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo,
                            stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo,
                            stFaDetCons.stDetConsumo[iRegConcep].szGlosaSubGrupo);
        *impb3000 = TRUE;

        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
        {
            vDTrazasLog(szModulo,"No pudo escribir en archivo -3-",LOG01);
            return(FALSE);
        }
    }

    return(TRUE);
}

int hay_b2000_b3000(FILE *Fd_ArchImp,int iRegConcep,int ihayRegistros_7,int ihayRegistros_6,int breg23,int *impb2000,int *impb3000,char * buffer)
{
    int itipo_7;
    int itipo_6;
    int iesCuota;

    itipo_7=(stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo==CUOTAS_PAGARES)?TRUE:FALSE;
    itipo_6=(stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo==6)?TRUE:FALSE;
    iesCuota=(((atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA)||(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)))? TRUE:FALSE;

    if(((itipo_7&&ihayRegistros_7&&iesCuota)||(itipo_6&&ihayRegistros_6))||(!itipo_7&&!itipo_6))
    {
      if(!put_b2000_b3000(Fd_ArchImp,iRegConcep,breg23,impb2000,impb3000,buffer)) return(FALSE);
    }
    return(TRUE);
}
/*--------------------------------------------------------------------------*/
/*  Funcion :   bfnInsertHeaderInfCtl                                       */
/*--------------------------------------------------------------------------*/
int InsertHeaderInfCtl(ST_CICLOFACT *pstCiclFact, LINEACOMANDO *pstLinComando)
{
/* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        int     ihIndActivo         ;
        char    szhCODINFORME_GENERAR[7];
        long    lhCodCiclFact;
        long    lhNum_SecuInfo;
    char    szhFec_Emision  [9];
    char    szhfec_desde    [9];
    char    szhfec_hasta    [9];
/* EXEC SQL END DECLARE SECTION ; */ 



    strcpy (szModulo, "InsertHeaderInfCtl");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);

    /*  Actualiza Informe Anterior de Facturacion de Ciclo Como Inactivos.      */
    vDTrazasLog(szModulo,"\t\t** Actualiza Informe Anterior como Inactivo"
                   "\t\t** Cod. Informe          [%s]\n"
                   "\t\t** Codigo Ciclo Factur.  [%ld]\n"
                   "\t\t** Ind. Activo           [%d]\n"
                   "\t\t** Num Secuencia         [%ld]\n"
                   ,LOG04
                   ,szCODINFORME_GENERAR
                   ,pstLinComando->lCodCiclFact
                   ,COD_INFORME_CONTROL_INACTIVO
                   ,pstLinComando->lNum_SecuInfo);


    lhCodCiclFact   = pstLinComando->lCodCiclFact;
    lhNum_SecuInfo  = pstLinComando->lNum_SecuInfo;

    strcpy(szhCODINFORME_GENERAR, szCODINFORME_GENERAR);

    /* EXEC SQL DELETE FAD_CTLINFHEADER
                   WHERE COD_CICLFACT   = :lhCodCiclFact
                   AND COD_INFORME      = :szhCODINFORME_GENERAR
                   AND NUM_SECUINFO     = :lhNum_SecuInfo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "delete  from FAD_CTLINFHEADER  where ((COD_CICLFACT=:b0 a\
nd COD_INFORME=:b1) and NUM_SECUINFO=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )455;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCODINFORME_GENERAR;
    sqlstm.sqhstl[1] = (unsigned long )7;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNum_SecuInfo;
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



    if((SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND))
    {
        vDTrazasError(szModulo, "\t\tError en DELETE: %s", LOG03, SQLERRM);
        return(FALSE);
    }

    /*  Genera Nuevo registro Header de Informe de Facturacion de Ciclo         */
    ihIndActivo     = COD_INFORME_CONTROL_ACTIVO;

    vDTrazasLog(szModulo,  "\t\t** Cod. Informe          [%s]\n"
                           "\t\t** Secuencia Informe     [%ld]\n"
                           "\t\t** Ind. Activo           [%d]\n"
                           "\t\t** Fec. Emision          [%s]\n"
                           "\t\t** Fec. Periodo Desde    [%s]\n"
                           "\t\t** Fec. Periodo Hasta    [%s]\n"
                           "\t\t** Usuario Generador     [%s]\n"
                           "\t\t** Usuario Solicitante   [%s]\n"
                           "\t\t** Codigo Ciclo Factur.  [%ld]\n"
                           ,LOG04
                           ,szCODINFORME_GENERAR
                           ,pstLinComando->lNum_SecuInfo
                           ,ihIndActivo
                           ,pstCiclFact->szFec_Emision
                           ,pstCiclFact->fec_desde
                           ,pstCiclFact->fec_hasta
                           ,pstLinComando->szUser
                           ,pstLinComando->szUser
                           ,pstLinComando->lCodCiclFact  );


    strcpy(szhFec_Emision,pstCiclFact->szFec_Emision);
    strcpy(szhfec_desde,pstCiclFact->fec_desde);
    strcpy(szhfec_hasta,pstCiclFact->fec_hasta);


    /* EXEC SQL INSERT INTO FAD_CTLINFHEADER(COD_INFORME ,NUM_SECUINFO ,IND_ACTIVO ,FEC_EMISION ,
        FEC_PERDESDE ,FEC_PERHASTA ,COD_USUAGEN ,COD_USUASOL ,COD_CICLFACT )
        VALUES (:szhCODINFORME_GENERAR,
            :lhNum_SecuInfo ,
            :ihIndActivo ,
            TO_DATE(:szhFec_Emision,'YYYYMMDD') ,
            TO_DATE(:szhfec_desde,'YYYYMMDD') ,
            TO_DATE(:szhfec_hasta,'YYYYMMDD') ,
            USER,
            USER ,
            :lhCodCiclFact ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FAD_CTLINFHEADER (COD_INFORME,NUM_SECUINFO,IN\
D_ACTIVO,FEC_EMISION,FEC_PERDESDE,FEC_PERHASTA,COD_USUAGEN,COD_USUASOL,COD_CIC\
LFACT) values (:b0,:b1,:b2,TO_DATE(:b3,'YYYYMMDD'),TO_DATE(:b4,'YYYYMMDD'),TO_\
DATE(:b5,'YYYYMMDD'),USER,USER,:b6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )482;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCODINFORME_GENERAR;
    sqlstm.sqhstl[0] = (unsigned long )7;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhNum_SecuInfo;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihIndActivo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFec_Emision;
    sqlstm.sqhstl[3] = (unsigned long )9;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhfec_desde;
    sqlstm.sqhstl[4] = (unsigned long )9;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhfec_hasta;
    sqlstm.sqhstl[5] = (unsigned long )9;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCiclFact;
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



        if (SQLCODE != SQLOK) {
            vDTrazasError(szModulo,"\t\tError en bfnInsertHeaderInfCtl Insert: %s", LOG03, SQLERRM);
            return(FALSE);

        }

    return(TRUE);
}

int PutDetConsu(ST_ABONADO           *Abonado,
                FILE                 *Fd_ArchImp,
                ST_CUOTAS            *pstFaCuotas,
                STSALDO_ANTERIOR     *SaldoTot,
                ST_FACTCLIE          *pst_Cliente,
                char                 *buffer,
                DETALLEOPER          *st_MascaraOper,
                PLAN_TARIFARIO       *pst_PlanTarifario,              
                int                  iTasador,
                long                 lCodCiclFact,
                BOOL                 Flag_ExisCarrier)                         
{
    int   iRegConcep;
    int	  iRegConcepAUX;
    long  lhayAbonado;
    int   ihayGrupo;
    int   ihaySubGrupo;
    int   ihayRegistros_7;
    int   ihayRegistros_6;
    int   iesCuota;
    int   iInicio=TRUE;
    int   iesAbonado_0;
    int   itipo;
    int   AbonadoEncontrado;
    int   impb2000=FALSE;
    int   impb3000=FALSE;

    long  lNumAbonadoAux = 0L;
    int   iImprimioB4007 = FALSE;
    register int   i=0;

    char  buffer_local[200];
    int   iDocumentoCeroLocal=0;

    strcpy (szModulo, "PutDetConsu");
    vDTrazasLog(szModulo,"\t** Entrando en %s", LOG04,szModulo);

    memset(buffer_local,0,sizeof(buffer_local));

    vDTrazasLog(szModulo,"***** Detalle Consumo *****",LOG04);
    ihayRegistros_7= ((pstFaCuotas->iNum_RegCuotas_venci>0)||(pstFaCuotas->iNum_RegCuotas_pven>0))? TRUE:FALSE;
    ihayRegistros_6= (SaldoTot->iNum_RegSaldo>0)? TRUE:FALSE;
    iesAbonado_0=(Abonado->lNumAbonado[0]==0)?FALSE:TRUE;

  /*---------------------------------------------------------------
    SOLO IMPRIME SI EXITEN REGISTROS B4006 O B4007 :
    SI ABONADO CERO:
    NO EXISTE CREARLO Y COLOCAR DENTRO B4006 Y B4007
    SI EXISTE COLOCAR B4006 Y B4007 NORMALMENTE EN EL SWITCH
    ---------------------------------------------------------------*/

    vDTrazasLog(szModulo,"Antes de if-PutDetConsu():\n"
                        "\tihayRegistros_7: [%d]\n"
                        "\tihayRegistros_6: [%d]\n"
                        ,LOG06
                        ,ihayRegistros_7
                        ,ihayRegistros_6);
    if((ihayRegistros_7&&iesAbonado_0)||(ihayRegistros_6&&iesAbonado_0))
    {
        vDTrazasLog(szModulo,"Dentro de if PutDetConsu():\n"
                             "\tstFaDetCons.iNumReg: [%d]"
                             ,LOG06
                             ,stFaDetCons.iNumReg);
                            
        for(iRegConcep=0;iRegConcep<stFaDetCons.iNumReg;iRegConcep++)
        {
            vDTrazasLog(szModulo,"Dentro de for de abonado cero: iRegConcep: [%d]",LOG06,iRegConcep);
    /*---------------------------------------------------------------
      REGISTRO B4007
      ---------------------------------------------------------------*/
            if(stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo==CUOTAS_PAGARES)
            {
                iesCuota=(((atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA)||(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)))? TRUE:FALSE;
                if(iesCuota)
                {
                    vDTrazasLog(szModulo,"TipSubGrupo : [%d] Cuota: [%d] Vencida :[%d] Por Vencer :[%d]"
                                        ,LOG04, stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo,atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact), pstFaCuotas->iNum_RegCuotas_venci,pstFaCuotas->iNum_RegCuotas_pven);
                    if(iInicio)
                    {
                      iInicio=FALSE;

                        if(!put_b1000(Abonado,Fd_ArchImp,iRegConcep,-1,0,buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,9,"No pudo Imprimir registro B1000");
                            return(FALSE);
                        }
                        if(!put_b1100(pst_Cliente,Fd_ArchImp,iRegConcep,0,buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,10,"No pudo Imprimir registro B1100");
                            return(FALSE);
                        }
                        if(!put_b1200(Fd_ArchImp,iRegConcep,pst_Cliente, buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,11,"No pudo Imprimir registro B1200");
                            return(FALSE);
                        }
                        if(!put_b1300(Fd_ArchImp,iRegConcep,buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,12,"No pudo Imprimir registro B1300");
                            return(FALSE);
                        }
                    }
                /*---------------------------------------------------------------
                  CUOTA_VENCIDA
                  ---------------------------------------------------------------*/
                    if(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA)
                    {
                        ihayRegistros_7= (pstFaCuotas->iNum_RegCuotas_venci>0)? TRUE:FALSE;
                        if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,0,&impb2000,&impb3000,buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                            return(FALSE);
                        }
                    }
                    vDTrazasLog(szModulo,"\t****PutDetConsu: Se va a entrar a put_b4007(), Desde abonado cero, cuota vencida...",LOG06);
                    if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci,iRegConcep,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_VENCIDA, stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado,buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                        return(FALSE);
                    }

                    if(impb3000==TRUE)
                    {
                        sprintf(buffer_local,"B3333\n\0");
                        impb3000 = FALSE ;

                        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B3333)");
                            vDTrazasLog(szModulo," B3333 No pudo escribir en archivo",LOG01);
                            return(FALSE);
                        }
                    }
                    if(impb2000==TRUE)
                    {
                        sprintf(buffer_local,"B2222\n");
                        impb2000 = FALSE ;

                        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B2222)");
                            vDTrazasLog(szModulo,"B2222 No pudo escribir en archivo",LOG01);
                            return(FALSE);
                        }
                    }
                /*---------------------------------------------------------------
                  CUOTA_PORVENCER
                  ---------------------------------------------------------------*/
                    if(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)
                    {
                        ihayRegistros_7= (pstFaCuotas->iNum_RegCuotas_pven>0)? TRUE:FALSE;
                        if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,0,&impb2000,&impb3000,buffer))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                            return(FALSE);
                        }
                    }
                    vDTrazasLog(szModulo,"\t****PutDetConsu: Se va a entrar a put_b4007(), Desde abonado cero, cuota por vencer...",LOG06);
                    if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci,iRegConcep,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_PORVENCER, stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado,buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                        return(FALSE);
                    }

                    if(impb3000==TRUE)
                    {
                        sprintf(buffer_local,"B3333\n");
                        impb3000 = FALSE ;

                        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B3333)");
                            vDTrazasLog(szModulo,"B3333 No pudo escribir en archivo",LOG01);
                            return(FALSE);
                        }
                    }
                    if(impb2000==TRUE)
                    {
                        sprintf(buffer_local,"B2222\n");
                        impb2000 = FALSE ;

                        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                        {
                            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B2222)");
                            vDTrazasLog(szModulo,"B2222 No pudo escribir en archivo",LOG01);
                            return(FALSE);
                        }
                    }
                } /*  Es Cuota*/

            }  /* Subtipo 7 */
       /*---------------------------------------------------------------
         REGISTRO B4006
         ---------------------------------------------------------------*/
            if(stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo==SALDO_ANTERIOR)
            {
                if(iInicio)
                {
                    iInicio=FALSE;
                    if(!put_b1000(Abonado,Fd_ArchImp,iRegConcep,AbonadoEncontrado,0,buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,9,"No pudo Imprimir registro B1000");
                        return(FALSE);
                    }
                    if(!put_b1100(pst_Cliente,Fd_ArchImp,iRegConcep,0,buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,10,"No pudo Imprimir registro B1100");
                        return(FALSE);
                    }
                    if(!put_b1200(Fd_ArchImp,iRegConcep,pst_Cliente, buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,11,"No pudo Imprimir registro B1200");
                        return(FALSE);
                    }
                    if(!put_b1300(Fd_ArchImp,iRegConcep,buffer))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,12,"No pudo Imprimir registro B1300");
                        return(FALSE);
                    }
                }
                if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,0,&impb2000,&impb3000,buffer))
                {
                    fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                    return(FALSE);
                }

                if(!put_b4006(Fd_ArchImp,SaldoTot,iRegConcep,buffer))
                {
                    fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,16,"No pudo Imprimir registro 4006");
                    return(FALSE);
                }

                if(impb3000==TRUE)
                {
                    sprintf(buffer_local,"B3333\n");
                    impb3000 = FALSE ;

                    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B3333)");
                        vDTrazasLog(szModulo,"B3333 No pudo escribir en archivo",LOG01);
                        return(FALSE);
                    }
                }
                if(impb2000==TRUE)
                {
                    sprintf(buffer_local,"B2222\n");
                    impb2000 = FALSE ;

                    if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                    {
                        fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B2222)");
                        vDTrazasLog(szModulo,"B2222 No pudo escribir en archivo",LOG01);
                        return(FALSE);
                    }
                }
            }  /* Subtipo 6 */
        }  /* For Conceptos */
        if(!iInicio)
        {
            iInicio=FALSE;
            sprintf(buffer_local,"B1111\n");

            if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
            {
                fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B1111)");
                vDTrazasLog(szModulo,"B1111 No pudo escribir en archivo",LOG01);
                return(FALSE);
            }
            sprintf(buffer_local,"H1111\n\0");
            if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
            {
                fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (H1111)");
                vDTrazasLog(szModulo,"H1111 No pudo escribir en archivo",LOG01);
                return(FALSE);
            }
        }
        else
        {
            vDTrazasLog(szModulo,"ADVERTENCIA: Documento asociado al Cliente [%ld] SIN Detalles de Consumo 1ra Validacion",LOG03,pst_Cliente->lCodCliente);
            igDocumentoCero = 1;
        }
    }
   /*****************************************/

    iRegConcep=0;
    impb2000=FALSE;
    impb3000=FALSE;
    iRegConcepAUX=0;

    while(iRegConcep < stFaDetCons.iNumReg)
    {
        vDTrazasLog(szModulo,"\t****PutDetConsu: Dentro de while de stFaDetCons.iNumReg\n"
                             "\t    stFaDetCons.iNumReg:            [%d]\n"
                             "\t    iRegConcep:                                 [%d]\n"
                             "\t    stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo :[%d]\n"
                             "\t    stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado      :[%ld]"
                              ,LOG06
                              ,stFaDetCons.iNumReg
                              ,iRegConcep
                              ,stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo
                              ,stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado);


        itipo=stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo;
        if(!(itipo==CARGOS_BASICOS||itipo==CARGOS_VARIOS||itipo==TRAFICO||itipo==ARRIENDO_VENTA||itipo==COBRANZA||itipo==SALDO_ANTERIOR||itipo==CUOTAS_PAGARES))
        {
            iRegConcep++;
            iDocumentoCeroLocal=1;
            continue;
        }
        iDocumentoCeroLocal=0;
        vDTrazasLog(szModulo,"\t****PutDetConsu: Dentro de while de stFaDetCons.iNumReg, Paso if(itipo)",LOG06);
       /*---------------------------------------------------------------
         BUSCAR ABONADO :
         ---------------------------------------------------------------*/
        if(BuscaAbonado(Abonado,&AbonadoEncontrado,stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,17,"No se encuentra el abonado");
            return(FALSE);
        }
        vDTrazasLog(szModulo,"\t****PutDetConsu: Dentro de while de stFaDetCons.iNumReg, Paso BuscaAbonado()\n"
                             "\t****             AbonadoEncontrado: [%d]",LOG06,AbonadoEncontrado);
       /*---------------------------------------------------------------
         PRINT B1000 :
         ---------------------------------------------------------------*/
        if(AbonadoEncontrado == -1)
        {
            iRegConcep++;
            iDocumentoCeroLocal=1;
            continue;
        }
        iDocumentoCeroLocal=0;
        vDTrazasLog(szModulo,"\t****PutDetConsu: Dentro de while de stFaDetCons.iNumReg, Antes de put_b1000()",LOG06);
        if(!put_b1000(Abonado,Fd_ArchImp,iRegConcep,AbonadoEncontrado,1,buffer))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,9,"No pudo Imprimir registro B1000");
            return(FALSE);
        }
        if(!put_b1100(pst_Cliente,Fd_ArchImp,iRegConcep,1,buffer))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,10,"No pudo Imprimir registro B1100");
            return(FALSE);
        }
        if(!put_b1200(Fd_ArchImp,iRegConcep,pst_Cliente, buffer))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,11,"No pudo Imprimir registro B1200");
            return(FALSE);
        }
        if(!put_b1300(Fd_ArchImp,iRegConcep,buffer))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,12,"No pudo Imprimir registro B1300");
            return(FALSE);
        }
		
		iRegConcepAUX = iRegConcep;
		
       /*---------------------------------------------------------------
         WHILE ABONADO :
         ---------------------------------------------------------------*/
        lhayAbonado=stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado;
        vDTrazasLog(szModulo,"\t\t****PutDetConsu: Antes de while de ABONADO...\n"
                             "\t\t=>RegConcep:       [%d]\n"
                             "\t\t=>hayAbonado:      [%ld]\n"
                             "\t\t=>NumAbonado :     [%ld]\n"
                             "\t\t=>Cod_TipSubGrupo :[%d]"
                            ,LOG06 ,iRegConcep ,lhayAbonado
                            ,stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado
                            ,stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo);

        while((lhayAbonado==stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)&&
             (iRegConcep<stFaDetCons.iNumReg))
        {
             vDTrazasLog(szModulo,"\t\t****PutDetConsu: Dentro de while de ABONADO...\n"
                                  "\t\t=>RegConcep       :[%d]\n"
                                  "\t\t=>NumAbonado      :[%ld]\n"
                                  "\t\t=>Cod_TipSubGrupo :[%d]"
                                 ,LOG06
                                 ,iRegConcep
                                 ,stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado
                                 ,stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo);

             ihayRegistros_7= (((pstFaCuotas->iNum_RegCuotas_venci>0)&&(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA))||
                              ((pstFaCuotas->iNum_RegCuotas_pven>0 )&&(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)))? TRUE:FALSE;

             if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,2,&impb2000,&impb3000,buffer))
             {
                 fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                 return(FALSE);
             }
           /*---------------------------------------------------------------
             WHILE GRUPO :
             ---------------------------------------------------------------*/
             ihayGrupo = stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo;
             
             while((lhayAbonado==stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)&&
                   (iRegConcep<stFaDetCons.iNumReg)&&
                   (ihayGrupo == stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo))
             {

                 ihayRegistros_7= (((pstFaCuotas->iNum_RegCuotas_venci>0)&&(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_VENCIDA))||
                                  ((pstFaCuotas->iNum_RegCuotas_pven>0 )&&(atoi(stFaDetCons.stDetConsumo[iRegConcep].szTip_ConcNoFact)==CUOTA_PORVENCER)))? TRUE:FALSE;
                 if(impb2000==FALSE)
                 {
                     if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,2,&impb2000,&impb3000,buffer))
                     {
                         fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                         return(FALSE);
                     }
                 }

                 if(!hay_b2000_b3000(Fd_ArchImp,iRegConcep,ihayRegistros_7,ihayRegistros_6,3,&impb2000,&impb3000,buffer))
                 {
                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,13,"No pudo Imprimir registros B2000 o B3000");
                     return(FALSE);
                 }
                 ihaySubGrupo = stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo;
                 
                 while((lhayAbonado == stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado)&&
                      (iRegConcep  <  stFaDetCons.iNumReg)&&
                      (ihayGrupo   == stFaDetCons.stDetConsumo[iRegConcep].iCodGrupo)&&
                      (ihaySubGrupo== stFaDetCons.stDetConsumo[iRegConcep].iCodSubGrupo))
                 {
                      switch(stFaDetCons.stDetConsumo[iRegConcep].iCod_TipSubGrupo)
                      {
                            case CARGOS_BASICOS:
                                 if(!put_b4001(Fd_ArchImp,pst_PlanTarifario,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,18,"No pudo Imprimir registro 4001");
                                     return(FALSE);
                                 }
                                 break;
                            case CARGOS_VARIOS:
                                 if(!put_b4002(Fd_ArchImp,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,19,"No pudo Imprimir registro 4002");
                                     return(FALSE);
                                 }
                                 break;
                            case TRAFICO:
                                 if(!put_b4003(Fd_ArchImp,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,20,"No pudo Imprimir registro 4003");
                                     return(FALSE);
                                 }
                                 break;
                            case ARRIENDO_VENTA:
                                 if(!put_b4004(Fd_ArchImp,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,21,"No pudo Imprimir registro 4004");
                                     return(FALSE);
                                 }
                                 break;
                            case COBRANZA:
                                 if(!put_b4005(Fd_ArchImp,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,22,"No pudo Imprimir registro 4005");
                                     return(FALSE);
                                 }
                                 break;
                            case SALDO_ANTERIOR:
                                 if(!put_b4006(Fd_ArchImp,SaldoTot,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,16,"No pudo Imprimir registro 4006");
                                     return(FALSE);
                                 }
                                 break;
                            case CUOTAS_PAGARES:
                                 vDTrazasLog(szModulo,"\t****PutDetConsu: Se va a entrar a put_b4007(), Desde WHILE SUBGRUPO...",LOG06);
                                 if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci,iRegConcep,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_VENCIDA, stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                                     return(FALSE);
                                 }
                                 if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci,iRegConcep,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_PORVENCER, stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                                     return(FALSE);
                                 }
                                 break;
                            case IMPUESTOS:
                                 if(!put_b4008(Fd_ArchImp,iRegConcep,buffer))
                                 {
                                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,23,"No pudo Imprimir registro 4008");
                                     return(FALSE);
                                 }
                                 break;
                      }

                      /* Obtenemos la posicion para rescatar el numero de abonado asociado al concepto*/
                      lNumAbonadoAux = stFaDetCons.stDetConsumo[iRegConcep].lNumAbonado;

                      iRegConcep++;
                 }
                 
                 if(impb3000==TRUE)
                 {
                     vDTrazasLog(szModulo,"\t****PutDetConsu: Se va a entrar a put_b4007(), Desde if(impb3000==TRUE)...",LOG06);
                     if(iImprimioB4007==FALSE)
                     {
                        for(i=0;i<stFaDetCons.iNumReg;i++)
                        {
                            if(stFaDetCons.stDetConsumo[i].iCod_TipSubGrupo==CUOTAS_PAGARES && ( atoi(stFaDetCons.stDetConsumo[i].szTip_ConcNoFact)==CUOTA_VENCIDA )  )
                            {
                                if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci, i,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_VENCIDA,lNumAbonadoAux,buffer))
                                {
                                    fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                                    return(FALSE);
                                }
                            }
                            if(stFaDetCons.stDetConsumo[i].iCod_TipSubGrupo==CUOTAS_PAGARES && ( atoi(stFaDetCons.stDetConsumo[i].szTip_ConcNoFact)==CUOTA_PORVENCER )  )
                            {
                                if(!put_b4007(Fd_ArchImp,pstFaCuotas->stReg_venci, i,pstFaCuotas->iNum_RegCuotas_venci,CUOTA_PORVENCER,lNumAbonadoAux,buffer))
                                {
                                    fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,14,"No pudo Imprimir registro B4007");
                                    return(FALSE);
                                }
                            }
                        }
                        iImprimioB4007=TRUE;
                     }
                     sprintf(buffer_local,"B3333\n\0");
                     impb3000 = FALSE ;

                     if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                     {
                         fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B3333)");
                         vDTrazasLog(szModulo,"B3333, No pudo escribir en archivo",LOG01);
                         return(FALSE);
                     }
                 }
             }
             
             if(impb2000==TRUE)
             {
                 sprintf(buffer_local,"B2222\n");
                 impb2000 = FALSE ;

                 if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
                 {
                     fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B2222)");
                     vDTrazasLog(szModulo,"B2222,No pudo escribir en archivo",LOG01);
                     return(FALSE);
                 }
             }
        }
        
        if(!put_b5000(Fd_ArchImp,iRegConcepAUX,buffer))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,23,"No pudo Imprimir registro 5000");
        	return(FALSE);
        }
        
        sprintf(buffer_local,"B1111\n");

        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (B1111)");
            vDTrazasLog(szModulo,"B1111, No pudo escribir en archivo",LOG01);
            return(FALSE);
        }
               
        if(!bfnTrataFactTrafico(Abonado,pst_Cliente,Fd_ArchImp,AbonadoEncontrado,buffer, st_MascaraOper,iTasador,lCodCiclFact,Flag_ExisCarrier))
        {
            vDTrazasLog(szModulo,"Sin Registros",LOG03);
        }
        sprintf(buffer_local,"H1111\n\0");
        if(!bEscribeEnArchivo(Fd_ArchImp,buffer,buffer_local))
        {
            fnGrabaAnoProceso (pst_Cliente->lCodCliente, lCodCiclFact,15,"No pudo Escribir en el Archivo (H1111)");
            vDTrazasLog(szModulo,"H1111, No pudo escribir en archivo",LOG01);
            return(FALSE);
        }
        iImprimioB4007=FALSE;
    }

    if (stFaDetCons.iNumReg == 0)
    {
        vDTrazasLog(szModulo,"ADVERTENCIA: Documento asociado al Cliente [%ld] SIN Detalles de Consumo 2da Validacion",LOG03,pst_Cliente->lCodCliente);
        igDocumentoCero = 1;
    }
    else
    {
        if (iDocumentoCeroLocal==1)
        {
            vDTrazasLog(szModulo,"ADVERTENCIA: Documento asociado al Cliente [%ld] SIN Detalles de Consumo 3da Validacion",LOG03,pst_Cliente->lCodCliente);
            igDocumentoCero = 1;
        }
    }
    return(TRUE);
}

/************************************************************************/
/*  Funcion: int bfnGetNumProcesoCiclo(LINEACOMANDO)                    */
/*  Funcion que recupera Numero de Proceso para Ciclo de Facturacion    */
/************************************************************************/
int GetNumProcesoCiclo(LINEACOMANDO *pstLineaComando)
{
   /****************************************************************************/
   /*  Selecciona Numero de Proceso para el Ciclo de Facturacion               */
   /****************************************************************************/
    strcpy (szModulo, "GetNumProcesoCiclo");
    vDTrazasLog(szModulo,"\t** Entrando en %s"
                         "\n\t\tCodigo de Ciclo Fact.     [%ld]"
                         "\n\t\tCodigo de Tipo Doc.       [%d]"
                         ,LOG04,szModulo, pstLineaComando->lCodCiclFact,pstLineaComando->iCodTipDocum);
    /* EXEC SQL
      SELECT NUM_PROCESO
        INTO :pstLineaComando->lNumProceso
        FROM FA_PROCESOS
       WHERE COD_CICLFACT = :pstLineaComando->lCodCiclFact
         AND ROWNUM < 2; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NUM_PROCESO into :b0  from FA_PROCESOS where (COD_\
CICLFACT=:b1 and ROWNUM<2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )525;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&(pstLineaComando->lNumProceso);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pstLineaComando->lCodCiclFact);
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




    if(SQLCODE == SQLNOTFOUND)
    {
      vDTrazasLog  (szModulo,"\tNo Existen Datos en FA_PROCESOS **"
                             "\tPara el Cod_CiclFact     [%ld]"
                             "\tCodigo de Tipo Doc.       [%d]"
                             ,LOG04,pstLineaComando->lCodCiclFact,pstLineaComando->iCodTipDocum);
      vDTrazasError(szModulo,"\tNo Existen Datos en FA_PROCESOS  **"
                             "\tPara el Cod_CiclFact     [%ld]"
                             "\tCodigo de Tipo Doc.       [%d]"
                             ,LOG04,pstLineaComando->lCodCiclFact,pstLineaComando->iCodTipDocum);
      return(FALSE);
    }
    if(SQLCODE != SQLOK)
    {
      vDTrazasLog  (szModulo,"\tNo Existen Datos en FA_PROCESOS **"
                             "\tPara el Cod_CiclFact     [%ld]"
                             ,LOG01,pstLineaComando->lCodCiclFact);
      vDTrazasError(szModulo,"\tNo Existen Datos en FA_PROCESOS  **"
                             "\tPara el Cod_CiclFact     [%ld]"
                             ,LOG01,pstLineaComando->lCodCiclFact);
      return(FALSE);
    }
    return(TRUE);
}

int GetCuotas(ST_CUOTAS * pstFaCuotas,long lCicloFact,long lCodCliente,char *szFec_Vencimi)
{
    int   conta,i=0, x=0, k=0;
    long  lNumCuotas=0, lNumCoutasFetch=0;

    long lNumFolioAnterior = 0L;
    int  iSecCuotaAnterior = 0;


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    int         ihValorUno = 1 ;
    /* VARCHAR     szhRowid        [MAX_CUOTAS_LOCAL][19]; */ 
struct { unsigned short len; unsigned char arr[22]; } szhRowid[1000];

    int         ihCodCliente    [MAX_CUOTAS_LOCAL]    ;
    int         ihCod_Concepto  [MAX_CUOTAS_LOCAL]    ;
    int         ihNumCuota      [MAX_CUOTAS_LOCAL]    ;
    int         ihSecCuota      [MAX_CUOTAS_LOCAL]    ;
    double      dhMtoCuota      [MAX_CUOTAS_LOCAL]    ;
    long        lhNum_Folio     [MAX_CUOTAS_LOCAL]    ;
    /* VARCHAR     szhNum_FolioCtc [MAX_CUOTAS_LOCAL][13]; */ 
struct { unsigned short len; unsigned char arr[14]; } szhNum_FolioCtc[1000];

    /* VARCHAR     szhFecEmision   [MAX_CUOTAS_LOCAL][11]; */ 
struct { unsigned short len; unsigned char arr[14]; } szhFecEmision[1000];

    /* VARCHAR     szhDes_Cuota    [MAX_CUOTAS_LOCAL][51]; */ 
struct { unsigned short len; unsigned char arr[54]; } szhDes_Cuota[1000];

    /* VARCHAR     shzFechaEfec    [MAX_CUOTAS_LOCAL][9]; */ 
struct { unsigned short len; unsigned char arr[10]; } shzFechaEfec[1000];

    int         ihInd_Facturado [MAX_CUOTAS_LOCAL]    ;
    char        szhPrefPlaza    [MAX_CUOTAS_LOCAL][25+1]; /* EXEC SQL VAR szhPrefPlaza IS STRING(25+1); */ 

    long        lhNumAbonado    [MAX_CUOTAS_LOCAL]    ; 
    /* EXEC SQL END DECLARE SECTION; */ 



    strcpy (szModulo, "GetCuotas");

  /*SETEO DE ESTRUCTURA A LLENAR :*/
    pstFaCuotas->dTotalCuotas_venci    =0;
    pstFaCuotas->iNum_RegCuotas_venci  =0;
    pstFaCuotas->dTotalCuotas_pven     =0;
    pstFaCuotas->iNum_RegCuotas_pven   =0;
    pstFaCuotas->dTotalCuotas          =0;

    for(conta=0;conta<MAX_CUOTAS_LOCAL;conta++)
    {
       pstFaCuotas->stReg_venci[conta].szDes_Cuota    [0]=0;
       pstFaCuotas->stReg_venci[conta].szFec_Emision  [0]=0;
       pstFaCuotas->stReg_venci[conta].szFechaEfectiva[0]=0;
       pstFaCuotas->stReg_venci[conta].szNum_FolioCtc [0]=0;
       pstFaCuotas->stReg_venci[conta].szRowid        [0]=0;
       pstFaCuotas->stReg_venci[conta].dMtoCuota         =0.0;
       pstFaCuotas->stReg_venci[conta].iCod_Concepto     =0;
       pstFaCuotas->stReg_venci[conta].iCodCliente       =0;
       pstFaCuotas->stReg_venci[conta].iInd_Facturado    =0;
       pstFaCuotas->stReg_venci[conta].iNumCuota         =0;
       pstFaCuotas->stReg_venci[conta].iSecCuota         =0;
       pstFaCuotas->stReg_venci[conta].lNum_Folio        =0;
       pstFaCuotas->stReg_venci[conta].szPrefPlaza    [0]=0; 
       pstFaCuotas->stReg_venci[conta].lNumAbonado       =0;  
       pstFaCuotas->stReg_pven[conta].szDes_Cuota    [0]=0;
       pstFaCuotas->stReg_pven[conta].szFec_Emision  [0]=0;
       pstFaCuotas->stReg_pven[conta].szFechaEfectiva[0]=0;
       pstFaCuotas->stReg_pven[conta].szNum_FolioCtc [0]=0;
       pstFaCuotas->stReg_pven[conta].szRowid        [0]=0;
       pstFaCuotas->stReg_pven[conta].dMtoCuota         =0.0;
       pstFaCuotas->stReg_pven[conta].iCod_Concepto     =0;
       pstFaCuotas->stReg_pven[conta].iCodCliente       =0;
       pstFaCuotas->stReg_pven[conta].iInd_Facturado    =0;
       pstFaCuotas->stReg_pven[conta].iNumCuota         =0;
       pstFaCuotas->stReg_pven[conta].iSecCuota         =0;
       pstFaCuotas->stReg_pven[conta].lNum_Folio        =0;
       pstFaCuotas->stReg_pven[conta].szPrefPlaza    [0]=0;  
       pstFaCuotas->stReg_pven[conta].lNumAbonado       =0;  
    }

    vDTrazasLog(szModulo,"\t\tInicio GetCuotas \n", LOG06);

    lhCodClienteCur= lCodCliente;
    lhCodCiclFactCur= lCicloFact; 

    /* EXEC SQL OPEN Cursor_Cuotas ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )548;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteCur;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFactCur;
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


    if(sqlca.sqlcode < SQLOK)
    {
        vDTrazasError(szModulo,"\n\t\tError en OPEN Cursor_Cuotas (FA_CUOTCREDITO):%s\n", LOG01, SQLERRM);
        return(FALSE);
    }

    while(1)
    {
         /* EXEC SQL FETCH Cursor_Cuotas
         INTO :szhRowid       ,
              :ihCodCliente   ,
              :ihCod_Concepto ,
              :ihNumCuota     ,
              :ihSecCuota     ,
              :dhMtoCuota     ,
              :lhNum_Folio    ,
              :szhNum_FolioCtc,
              :szhFecEmision  ,
              :ihInd_Facturado,
              :szhDes_Cuota   ,
              :shzFechaEfec   ,
	      :szhPrefPlaza   ,
	      :lhNumAbonado; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 45;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1000;
         sqlstm.offset = (unsigned int  )571;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
         sqlstm.sqhstl[0] = (unsigned long )21;
         sqlstm.sqhsts[0] = (         int  )24;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)ihCodCliente;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[1] = (         int  )sizeof(int);
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)ihCod_Concepto;
         sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[2] = (         int  )sizeof(int);
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)ihNumCuota;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[3] = (         int  )sizeof(int);
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqharc[3] = (unsigned long  *)0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)ihSecCuota;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[4] = (         int  )sizeof(int);
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqharc[4] = (unsigned long  *)0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)dhMtoCuota;
         sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[5] = (         int  )sizeof(double);
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqharc[5] = (unsigned long  *)0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)lhNum_Folio;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[6] = (         int  )sizeof(long);
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqharc[6] = (unsigned long  *)0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)szhNum_FolioCtc;
         sqlstm.sqhstl[7] = (unsigned long )15;
         sqlstm.sqhsts[7] = (         int  )16;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqharc[7] = (unsigned long  *)0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)szhFecEmision;
         sqlstm.sqhstl[8] = (unsigned long )13;
         sqlstm.sqhsts[8] = (         int  )16;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqharc[8] = (unsigned long  *)0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)ihInd_Facturado;
         sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[9] = (         int  )sizeof(int);
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqharc[9] = (unsigned long  *)0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)szhDes_Cuota;
         sqlstm.sqhstl[10] = (unsigned long )53;
         sqlstm.sqhsts[10] = (         int  )56;
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqharc[10] = (unsigned long  *)0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)shzFechaEfec;
         sqlstm.sqhstl[11] = (unsigned long )11;
         sqlstm.sqhsts[11] = (         int  )12;
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqharc[11] = (unsigned long  *)0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)szhPrefPlaza;
         sqlstm.sqhstl[12] = (unsigned long )26;
         sqlstm.sqhsts[12] = (         int  )26;
         sqlstm.sqindv[12] = (         short *)0;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqharc[12] = (unsigned long  *)0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)lhNumAbonado;
         sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[13] = (         int  )sizeof(long);
         sqlstm.sqindv[13] = (         short *)0;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqharc[13] = (unsigned long  *)0;
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

     

         if(sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
         {
           vDTrazasError(szModulo,"\n\t\tError en FETCH Cursor_Cuotas (FA_CUOTCREDITO):%s\n", LOG01, SQLERRM);
           vDTrazasLog  (szModulo,"\n\t\tError en FETCH Cursor_Cuotas (FA_CUOTCREDITO):%s\n", LOG01, SQLERRM);
           return(FALSE);
         }

         if((sqlca.sqlcode == SQLNOTFOUND) && (lNumCoutasFetch == sqlca.sqlerrd[2]))
         {
           break;
         }

         lNumCuotas      = sqlca.sqlerrd[2] - lNumCoutasFetch ;
         lNumCoutasFetch = sqlca.sqlerrd[2];

         for(i=0;i< lNumCuotas;i++)
         {
              pstFaCuotas->stReg_venci[x].iCodCliente   =   ihCodCliente[i];
              pstFaCuotas->stReg_venci[x].iCod_Concepto =   ihCod_Concepto[i];
              pstFaCuotas->stReg_venci[x].iNumCuota     =   ihNumCuota[i];
              pstFaCuotas->stReg_venci[x].iSecCuota     =   ihSecCuota[i];
              pstFaCuotas->stReg_venci[x].dMtoCuota     =   dhMtoCuota[i];
              pstFaCuotas->stReg_venci[x].lNum_Folio    =   lhNum_Folio[i];
              if( ihInd_Facturado[i] == ihValorUno)
                  pstFaCuotas->stReg_venci[x].iInd_Facturado=   2; 
              else if( ihInd_Facturado[i] == 0)
                  pstFaCuotas->stReg_venci[x].iInd_Facturado=   3; 
              sprintf(pstFaCuotas->stReg_venci[x].szNum_FolioCtc,"%.*s\0",szhNum_FolioCtc[i].len, szhNum_FolioCtc[i].arr);
              sprintf(pstFaCuotas->stReg_venci[x].szRowid,"%.*s\0",szhRowid[i].len, szhRowid[i].arr);
              sprintf(pstFaCuotas->stReg_venci[x].szFechaEfectiva,"%.*s\0",shzFechaEfec[i].len, shzFechaEfec[i].arr);
              sprintf(pstFaCuotas->stReg_venci[x].szFec_Emision,"%.*s\0",szhFecEmision[i].len, szhFecEmision[i].arr);
              sprintf(pstFaCuotas->stReg_venci[x].szDes_Cuota,"%.*s\0"  ,szhDes_Cuota[i].len, szhDes_Cuota[i].arr);
              sprintf(pstFaCuotas->stReg_venci[x].szPrefPlaza,"%s", szhPrefPlaza[i]);
              pstFaCuotas->stReg_venci[x].lNumAbonado   =   lhNumAbonado[i];
              pstFaCuotas->iNum_RegCuotas_venci++;
              pstFaCuotas->dTotalCuotas_venci += dhMtoCuota[i];
              x++;
         }
         if (sqlca.sqlcode == SQLNOTFOUND) break;
    }

    pstFaCuotas->dTotalCuotas = (pstFaCuotas->dTotalCuotas_venci + pstFaCuotas->dTotalCuotas_pven);

    vDTrazasLog(szModulo,"\t N.de  Cuotas en FA_CUOTCREDITO [%ld]",LOG05,lNumCuotas);

    /* EXEC SQL CLOSE Cursor_Cuotas; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )642;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(sqlca.sqlcode < SQLOK)
    {
      vDTrazasError(szModulo,"\n\t\tError en CLOSE Cursor_Cuotas (FA_CUOTCREDITO):%s\n", LOG01, SQLERRM);
      return(FALSE);
    }

    /*
     *  Se realiza filtrado de cuotas por vencer de acuerdo al siguiente criterio:
     *  Se deben imprimir las cuotas mas vencidas de cada uno de los folios del cliente
     */
    for(k=0; k < pstFaCuotas->iNum_RegCuotas_pven; k++)
    {
        if(k==0) /* Primera vez que se entra al ciclo. */
        {
            pstFaCuotas->stReg_pven[k].iInd_Facturado = 2;
            strcpy(pstFaCuotas->stReg_pven[k].szFechaEfectiva,szFec_Vencimi);
            lNumFolioAnterior = pstFaCuotas->stReg_pven[k].lNum_Folio;
            iSecCuotaAnterior = pstFaCuotas->stReg_pven[k].iSecCuota;
        }
        else
        {
            /* Si el folio actual es distinto al anterior, se marca. */
            if(pstFaCuotas->stReg_pven[k].lNum_Folio != lNumFolioAnterior)
            {
                pstFaCuotas->stReg_pven[k].iInd_Facturado = 2;
                strcpy(pstFaCuotas->stReg_pven[k].szFechaEfectiva,szFec_Vencimi);
                lNumFolioAnterior = pstFaCuotas->stReg_pven[k].lNum_Folio;
                iSecCuotaAnterior = pstFaCuotas->stReg_pven[k].iSecCuota;
            }
            else
            {
                /* Si es igual, verificar sec_cuota. */
                if(pstFaCuotas->stReg_pven[k].iSecCuota == iSecCuotaAnterior)
                {
                    pstFaCuotas->stReg_pven[k].iInd_Facturado = 2;
                    strcpy(pstFaCuotas->stReg_pven[k].szFechaEfectiva,szFec_Vencimi);
                    lNumFolioAnterior = pstFaCuotas->stReg_pven[k].lNum_Folio;
                    iSecCuotaAnterior = pstFaCuotas->stReg_pven[k].iSecCuota;

                }
                else
                {
                    /* Solo se actualiza el folio anterior */
                    lNumFolioAnterior = pstFaCuotas->stReg_pven[k].lNum_Folio;
                }
            }
        }
    }


    vDTrazasLog(szModulo,"\t\t Fin GetCuotas \n", LOG06);

    return(TRUE);
}
/***************************************************************************************/
int GetCiclFact(ST_CICLOFACT * pstCicFact,long lCodCiclFact)
{
    strcpy (szModulo, "GetCiclFact");
    vDTrazasLog(szModulo,"\t** Entrando en %s"
                         "\t*** Inicio de Ciclo de Facturacion (%ld)***"
                         ,LOG04,szModulo,lCodCiclFact);
       /* EXEC SQL
       SELECT COD_CICLO,
              TO_CHAR(FEC_DESDELLAM,'YYYYMMDD')            ,
              TO_CHAR(FEC_HASTALLAM,'YYYYMMDD')            ,
              TO_CHAR(FEC_EMISION,'YYYYMMDD')                ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-1),'YYYYMM')   ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-2),'YYYYMM')   ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-3),'YYYYMM')   ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-4),'YYYYMM')   ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-5),'YYYYMM')   ,
              TO_CHAR(ADD_MONTHS(FEC_EMISION,-6),'YYYYMM')   ,
              IND_TASADOR,
              TO_CHAR(FEC_DESDECFIJOS,'YYYYMMDD')            ,
              TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDD')
         INTO :pstCicFact
         FROM FA_CICLFACT
        WHERE COD_CICLFACT = :lCodCiclFact; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 45;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "select COD_CICLO ,TO_CHAR(FEC_DESDELLAM,'YYYYMMDD') ,T\
O_CHAR(FEC_HASTALLAM,'YYYYMMDD') ,TO_CHAR(FEC_EMISION,'YYYYMMDD') ,TO_CHAR(ADD\
_MONTHS(FEC_EMISION,(-1)),'YYYYMM') ,TO_CHAR(ADD_MONTHS(FEC_EMISION,(-2)),'YYY\
YMM') ,TO_CHAR(ADD_MONTHS(FEC_EMISION,(-3)),'YYYYMM') ,TO_CHAR(ADD_MONTHS(FEC_\
EMISION,(-4)),'YYYYMM') ,TO_CHAR(ADD_MONTHS(FEC_EMISION,(-5)),'YYYYMM') ,TO_CH\
AR(ADD_MONTHS(FEC_EMISION,(-6)),'YYYYMM') ,IND_TASADOR ,TO_CHAR(FEC_DESDECFIJO\
S,'YYYYMMDD') ,TO_CHAR(FEC_HASTACFIJOS,'YYYYMMDD') into :s1 ,:s2 ,:s3 ,:s4 ,:s\
5 ,:s6 ,:s7 ,:s8 ,:s9 ,:s10 ,:s11 ,:s12 ,:s13   from FA_CICLFACT where COD_CIC\
LFACT=:b1";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )657;
       sqlstm.selerr = (unsigned short)1;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&pstCicFact->cod_ciclo;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)pstCicFact->fec_desde;
       sqlstm.sqhstl[1] = (unsigned long )9;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)pstCicFact->fec_hasta;
       sqlstm.sqhstl[2] = (unsigned long )9;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)pstCicFact->szFec_Emision;
       sqlstm.sqhstl[3] = (unsigned long )9;
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)pstCicFact->szMesCiclo_0;
       sqlstm.sqhstl[4] = (unsigned long )7;
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)pstCicFact->szMesCiclo_1;
       sqlstm.sqhstl[5] = (unsigned long )7;
       sqlstm.sqhsts[5] = (         int  )0;
       sqlstm.sqindv[5] = (         short *)0;
       sqlstm.sqinds[5] = (         int  )0;
       sqlstm.sqharm[5] = (unsigned long )0;
       sqlstm.sqadto[5] = (unsigned short )0;
       sqlstm.sqtdso[5] = (unsigned short )0;
       sqlstm.sqhstv[6] = (unsigned char  *)pstCicFact->szMesCiclo_2;
       sqlstm.sqhstl[6] = (unsigned long )7;
       sqlstm.sqhsts[6] = (         int  )0;
       sqlstm.sqindv[6] = (         short *)0;
       sqlstm.sqinds[6] = (         int  )0;
       sqlstm.sqharm[6] = (unsigned long )0;
       sqlstm.sqadto[6] = (unsigned short )0;
       sqlstm.sqtdso[6] = (unsigned short )0;
       sqlstm.sqhstv[7] = (unsigned char  *)pstCicFact->szMesCiclo_3;
       sqlstm.sqhstl[7] = (unsigned long )7;
       sqlstm.sqhsts[7] = (         int  )0;
       sqlstm.sqindv[7] = (         short *)0;
       sqlstm.sqinds[7] = (         int  )0;
       sqlstm.sqharm[7] = (unsigned long )0;
       sqlstm.sqadto[7] = (unsigned short )0;
       sqlstm.sqtdso[7] = (unsigned short )0;
       sqlstm.sqhstv[8] = (unsigned char  *)pstCicFact->szMesCiclo_4;
       sqlstm.sqhstl[8] = (unsigned long )7;
       sqlstm.sqhsts[8] = (         int  )0;
       sqlstm.sqindv[8] = (         short *)0;
       sqlstm.sqinds[8] = (         int  )0;
       sqlstm.sqharm[8] = (unsigned long )0;
       sqlstm.sqadto[8] = (unsigned short )0;
       sqlstm.sqtdso[8] = (unsigned short )0;
       sqlstm.sqhstv[9] = (unsigned char  *)pstCicFact->szMesCiclo_5;
       sqlstm.sqhstl[9] = (unsigned long )7;
       sqlstm.sqhsts[9] = (         int  )0;
       sqlstm.sqindv[9] = (         short *)0;
       sqlstm.sqinds[9] = (         int  )0;
       sqlstm.sqharm[9] = (unsigned long )0;
       sqlstm.sqadto[9] = (unsigned short )0;
       sqlstm.sqtdso[9] = (unsigned short )0;
       sqlstm.sqhstv[10] = (unsigned char  *)&pstCicFact->iIndTasador;
       sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
       sqlstm.sqhsts[10] = (         int  )0;
       sqlstm.sqindv[10] = (         short *)0;
       sqlstm.sqinds[10] = (         int  )0;
       sqlstm.sqharm[10] = (unsigned long )0;
       sqlstm.sqadto[10] = (unsigned short )0;
       sqlstm.sqtdso[10] = (unsigned short )0;
       sqlstm.sqhstv[11] = (unsigned char  *)pstCicFact->szFec_Desde;
       sqlstm.sqhstl[11] = (unsigned long )9;
       sqlstm.sqhsts[11] = (         int  )0;
       sqlstm.sqindv[11] = (         short *)0;
       sqlstm.sqinds[11] = (         int  )0;
       sqlstm.sqharm[11] = (unsigned long )0;
       sqlstm.sqadto[11] = (unsigned short )0;
       sqlstm.sqtdso[11] = (unsigned short )0;
       sqlstm.sqhstv[12] = (unsigned char  *)pstCicFact->szFec_Hasta;
       sqlstm.sqhstl[12] = (unsigned long )9;
       sqlstm.sqhsts[12] = (         int  )0;
       sqlstm.sqindv[12] = (         short *)0;
       sqlstm.sqinds[12] = (         int  )0;
       sqlstm.sqharm[12] = (unsigned long )0;
       sqlstm.sqadto[12] = (unsigned short )0;
       sqlstm.sqtdso[12] = (unsigned short )0;
       sqlstm.sqhstv[13] = (unsigned char  *)&lCodCiclFact;
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



    if(SQLCODE != SQLOK)
    {
      vDTrazasError(szModulo,"\t\tError en Ciclo Facturacion : %s", LOG01, SQLERRM);
      return(FALSE);
    }
    strcpy(szFec_Desde,pstCicFact->szFec_Desde);
    strcpy(szFec_Hasta,pstCicFact->szFec_Hasta);

    return(TRUE);
}
/*****************************************************************************/
/*  Funcion para cargar codigo de servicio del cliente                       */
/*****************************************************************************/
int CargaCodigoServicio(ST_FACTCLIE *pstFactDocuClie,
                        ST_INFGENERAL * pstInfGeneral,
                        char * pstCodServicio)
{
    vDTrazasLog("","\t\tInicio Codigo Carga Servicio [%s]", LOG04,pstFactDocuClie->szFecEmision);

    /* EXEC SQL
    SELECT NVL(COD_SERVICIO,'1')
    INTO   :pstInfGeneral->szCOD_SERVICIO
    FROM   FAD_IMPSERVCLIE
    WHERE  COD_CLIENTE   = :pstFactDocuClie->lCodCliente
    AND    TO_DATE(:pstFactDocuClie->szFecEmision,'YYYYMMDD') BETWEEN FECHA_DESDE AND FECHA_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 45;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NVL(COD_SERVICIO,'1') into :b0  from FAD_IMPSERVCL\
IE where (COD_CLIENTE=:b1 and TO_DATE(:b2,'YYYYMMDD') between FECHA_DESDE and \
FECHA_HASTA)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )728;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstInfGeneral->szCOD_SERVICIO);
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&(pstFactDocuClie->lCodCliente);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstFactDocuClie->szFecEmision);
    sqlstm.sqhstl[2] = (unsigned long )12;
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



    if(sqlca.sqlcode == SQLNOTFOUND)
    {
      sprintf(pstInfGeneral->szCOD_SERVICIO,"%3s",pstCodServicio);
      vDTrazasLog("","\t\tNo Existe Codigo de Servicio. Se Asumira el Codigo por Defecto [%s]." ,LOG04,pstInfGeneral->szCOD_SERVICIO);
      return(TRUE);
    }
    if(sqlca.sqlcode < SQLOK)
    {
      vDTrazasLog("","\t\tError en Carga de Codigo de Servicio.",LOG04);
      return(FALSE);
    }
    return(TRUE);
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

