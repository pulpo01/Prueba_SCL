
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
    "./pc/ImpSclD.pc"
};


static unsigned int sqlctx = 1728667;


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
   unsigned char  *sqhstv[33];
   unsigned long  sqhstl[33];
            int   sqhsts[33];
            short *sqindv[33];
            int   sqinds[33];
   unsigned long  sqharm[33];
   unsigned long  *sqharc[33];
   unsigned short  sqadto[33];
   unsigned short  sqtdso[33];
} sqlstm = {12,33};

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
"select COD_FACTURACION ,IND_TABLA  from TA_CONCEPFACT  union select COD_CONC\
FACT ,4  from FA_FACTCARRIERS            ";

 static const char *sq0001 = 
"select COD_REGISTRO ,IND_IMPRESION ,TO_NUMBER(COD_TIPDOCUM)  from FA_REGISIM\
PRESION_TD where COD_TIPDOCUM=:b0 order by COD_TIPDOCUM,COD_REGISTRO          \
  ";

 static const char *sq0009 = 
"select NOM_PARAMETRO ,VAL_PARAMETRO ,DES_PARAMETRO  from GED_PARAMETROS wher\
e NOM_PARAMETRO in ('LLAMADA_LD_04','LLAMADA_LD_03')           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,2,0,0,17,245,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,2,0,0,45,259,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
55,0,0,2,0,0,13,306,0,0,23,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,
0,0,2,5,0,0,2,4,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,4,0,0,2,4,0,0,2,
5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,4,0,0,2,5,0,0,
162,0,0,2,0,0,15,379,0,0,0,0,0,1,0,
177,0,0,3,0,0,17,1478,0,0,1,1,0,1,0,1,97,0,0,
196,0,0,3,0,0,45,1494,0,0,7,7,0,1,0,1,3,0,0,1,5,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,1,3,0,0,
239,0,0,3,0,0,13,1537,0,0,8,0,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,4,0,0,2,5,0,0,
286,0,0,3,0,0,15,1595,0,0,0,0,0,1,0,
301,0,0,4,117,0,9,1725,0,0,0,0,0,1,0,
316,0,0,4,0,0,13,1736,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
339,0,0,4,0,0,15,1755,0,0,0,0,0,1,0,
354,0,0,1,156,0,9,1837,0,0,1,1,0,1,0,1,3,0,0,
373,0,0,1,0,0,13,1848,0,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,3,0,0,
400,0,0,1,0,0,15,1863,0,0,0,0,0,1,0,
415,0,0,5,0,0,17,1977,0,0,1,1,0,1,0,1,97,0,0,
434,0,0,5,0,0,45,1994,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
465,0,0,6,0,0,17,2087,0,0,1,1,0,1,0,1,97,0,0,
484,0,0,6,0,0,45,2103,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
515,0,0,5,0,0,13,2114,0,0,28,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,
97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,97,0,0,
642,0,0,6,0,0,13,2161,0,0,29,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,3,0,0,2,97,0,0,
2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,97,0,0,
773,0,0,5,0,0,15,2247,0,0,0,0,0,1,0,
788,0,0,6,0,0,15,2259,0,0,0,0,0,1,0,
803,0,0,7,0,0,17,2631,0,0,1,1,0,1,0,1,97,0,0,
822,0,0,7,0,0,13,2678,0,0,33,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,
2,97,0,0,
969,0,0,8,0,0,17,3068,0,0,1,1,0,1,0,1,97,0,0,
988,0,0,8,0,0,45,3089,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
1011,0,0,7,0,0,45,3126,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,
1042,0,0,7,0,0,13,3150,0,0,33,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,4,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,4,0,0,
2,97,0,0,
1189,0,0,7,0,0,15,3221,0,0,0,0,0,1,0,
1204,0,0,9,139,0,9,3263,0,0,0,0,0,1,0,
1219,0,0,9,0,0,13,3277,0,0,3,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,
1246,0,0,9,0,0,15,3310,0,0,0,0,0,1,0,
1261,0,0,10,184,0,4,3397,0,0,7,5,0,1,0,2,4,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,
1304,0,0,11,144,0,4,3435,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
};


/*  Version  FAC_DES_MAS ImpSclD.pc  6.000   */
#include <ImpSclD.h>

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


    int swifnPrepareDetLlams=0;
    
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCliente           ;
         long lhNumAbonado           ;
         long lhNumProceso           ;
         char szhFormatoFecha    [22];   /* EXEC SQL VAR szhFormatoFecha IS STRING(22); */ 

         char szhFormatoHora      [9];   /* EXEC SQL VAR szhFormatoHora  IS STRING(9); */ 

         int  ihTipConce             ;
         int  ihCodTipDocum          ;
         char szhformato_fecha   [22];
         char szhformato_hora     [9];
         int  ihDValorCero         =0;
         char szhDWhere         [513];
    /* EXEC SQL END DECLARE SECTION; */ 


    /* EXEC SQL DECLARE cRegImpre CURSOR FOR
                SELECT COD_REGISTRO,IND_IMPRESION, TO_NUMBER(COD_TIPDOCUM)
                  FROM FA_REGISIMPRESION_TD
                 WHERE COD_TIPDOCUM =  :ihCodTipDocum
                 ORDER BY COD_TIPDOCUM, COD_REGISTRO; */ 


/****************************************************************************/
/* FUNCION     : bfnDetLlamRoaming                                          */
/* DESCRIPCION : Imprime Detalle de Llamadas Locales por Cliente/Abonado    */
/****************************************************************************/
BOOL bfnDetLlamRoaming  ( ST_ABONADO *pst_Abonados
                        , ST_FACTCLIE *pst_Cliente
                        , int iIndice
                        , int iTipoLlamada
                        , FILE *fArchImp
                        , char *szBuffer
                        , int *bImprimioD1000
                        , int iTasador
                        , long lCodCiclFact
                        , char *szhCodRegistro)                       
{
    int             iSqlCodeDetRoaming     ;
    DETROAMING      stDetRoaming           ;
    char            szRegistro[160]        ;
    char            szBuffer_local[25 ]="" ;
    char            szMinutos[7+1];
    int             bImprimioD2000 = FALSE;
    long            lCont = 0;

    strcpy (szModulo, "bfnDetLlamRoaming");
    vDTrazasLog("","\n\t Entrada a %s"
                   "\n\t\t==> Cod. Cliente     [%ld]"
                   "\n\t\t==> Ind. OrdenTotal  [%ld]"
                   "\n\t\t==> Num. Abonado     [%ld]"
                   "\n\t\t==> Num. Celular     [%ld]"
                   "\n\t\t==> Indice           [%d]"                  
                   ,LOG04
                   ,szModulo
                   ,pst_Cliente->lCodCliente
                   ,pst_Cliente->lIndOrdenTotal
                   ,pst_Abonados->lNumAbonado[iIndice]
                   ,pst_Abonados->lNumCelular[iIndice]
                   ,iIndice);

    memset(szBuffer_local,0,sizeof(szBuffer_local));

    /************************************************************************************/
    /*    Recupera Detalle de Llamadas Roaming                                          */
    /************************************************************************************/
    iSqlCodeDetRoaming = ifnOpenDetRoaming( pst_Cliente->lCodCliente,
                                            pst_Abonados->lNumAbonado[iIndice],
                                            pst_Cliente->lNumProceso,
                                            iTasador,
                                            lCodCiclFact);

    while (iSqlCodeDetRoaming)    {

        memset(&stDetRoaming    , 0, sizeof (DETROAMING));

        iSqlCodeDetRoaming = ifnFetchDetRoaming(&stDetRoaming,iTasador);

        if(iSqlCodeDetRoaming)  {
            if(iSqlCodeDetRoaming & !*bImprimioD1000)
            {
              put_D1000(pst_Abonados,fArchImp,iIndice,szBuffer);
              *bImprimioD1000 = TRUE;
            }

            if (!bImprimioD2000)
            {
                /******************************** ************/
                /* Escribe cabecera de tipo de registro          */
                /*********************************************/

                sprintf(szBuffer_local ,"%5s%013d%05d\n"
                                       ,COD_TIPOLLAMADA
                                       ,iTipoLlamada
                                       ,atoi(pst_Cliente->szCod_Idioma));
                if (!bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local))
                {
                   vDTrazasLog(szModulo,"\n\t (%s) : Error en función bEscribeEnArchivo ", LOG05, szModulo);
                }
        
                bImprimioD2000=TRUE;
            }

            sprintf(szMinutos,"%7.7ld",stDetRoaming.lSegundos);
            sprintf(szRegistro  ,"%5s%05d%-20.20s%-8.8s%-6.6s%015.4f%-7.7s%-6.6s%-20.20s%-22.22s%05d%015.4f%015.4f%-7.7s%-7.7s%6.6ld%-2.2s%-5.5s%-5.5s%015.4f%-100.100s\n"
                                ,stDetRoaming.szCodRegistro
                                ,stDetRoaming.iCodOperRoa
                                ,stDetRoaming.szNumMovil
                                ,stDetRoaming.szFecLlamada
                                ,stDetRoaming.szHraLlamada
                                ,stDetRoaming.dImporte
                                ,szMinutos
                                ,stDetRoaming.szIndEntSal
                                ,stDetRoaming.szNumDestino
                                ,stDetRoaming.szDesDestino
                                ,stDetRoaming.iCod_Carg
                                ,stDetRoaming.dImpLocal1       
                                ,stDetRoaming.dImpLarga2       
                                ,stDetRoaming.szDurLocal1      
                                ,stDetRoaming.szDurLarga2      
                                ,stDetRoaming.lNumPulsos        
                                ,stDetRoaming.szRecordType      
                                ,stDetRoaming.szCodDcto         
                                ,stDetRoaming.szTipDcto         
                                ,stDetRoaming.dValorUnidad
                                ,stDetRoaming.szDesLlamada /* P-MIX-09003 */   
                                );

            if (!bEscribeEnArchivo(fArchImp,szBuffer,szRegistro))
            {
            	vDTrazasLog(szModulo,"\n\t (%s) : Error en funcion bEscribeEnArchivo ", LOG05, szModulo);
            }
        }
        lCont++;
    }
    
    if(bImprimioD2000)
    {
        sprintf(szBuffer_local,"%s\n",PIE_TIPOLLAMADA);
        if (!bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local))
        {
            vDTrazasLog(szModulo,"\n\t (%s) : Error en funcion bEscribeEnArchivo ", LOG05, szModulo);
        }        
    }

    if ((iSqlCodeDetRoaming != SQLOK) && (iSqlCodeDetRoaming != SQLNOTFOUND))   {
        vDTrazasLog(szModulo,"\n\t\t\t** (bfnDetLlamRoaming) Fetch"
                    "\n\t\t IndOrdenTotal  [%ld]"
                    "\n\t\t Error Oracle   [%s]"
                    ,LOG01, pst_Cliente->lIndOrdenTotal,SQLERRM);
        vDTrazasError(szModulo,"\n\t\t\t** (bfnDetLlamRoaming) Fetch"
                    "\n\t\t IndOrdenTotal  [%ld]"
                    "\n\t\t Error Oracle   [%s]"
                    ,LOG01, pst_Cliente->lIndOrdenTotal,SQLERRM);
        return (FALSE);
    }

    if (!bfnCloseDetRoaming(iTasador))
        return FALSE;

    return (TRUE);
}/*********************** FIN bfnDetLlamRoaming *****************************/

/************************************************************************/
/*  FUNCION    : ifnOpenDetRoaming                                      */
/*  DESCRIPCION: Abre el cursor cDetRoaming_Tol                         */
/************************************************************************/
int ifnOpenDetRoaming(long lCodCliente, 
                      long lNumAbonado,
                      long lNumProceso,
                      int  iTasador,
                      long lCodCiclFact)
{

    char  szCadenaSQL [2048]="";
    long  lhCodCiclFact        ;

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    lhCodCliente  = lCodCliente;
    lhNumAbonado  = lNumAbonado;
    lhNumProceso  = lNumProceso;
    lhCodCiclFact = lCodCiclFact;

    strcpy (szhFormatoFecha,szformato_fecha);
    strcpy (szhFormatoHora,szformato_hora);
    
    strcpy (szModulo, "ifnOpenDetRoaming");

    vDTrazasLog(szModulo, "\n\t\t(%s) Abriendo Detalle Carrier "
                          "\n\t\t==> Cliente         [%ld]"
                          "\n\t\t==> Abonado         [%ld]"
                          "\n\t\t==> Num.Proceso     [%ld]"
                          "\n\t\t==> Ind.Tasador      [%d]"
                          "\n\t\t==> Cod.CiclFact    [%ld]"                   
                          "\n\t\t==> [%s] [%s]*"
                        , LOG03
                        , szModulo
                        , lCodCliente
                        , lNumAbonado
                        , lNumProceso
                        , iTasador
                        , lhCodCiclFact
                        , szhFormatoFecha,szhFormatoFecha);                        

    sprintf(szCadenaSQL, "\n SELECT B.COD_REGISTRO, "
                         "\n        NVL(A.SEC_EMPA, ' '), NVL(A.SEC_CDR, ' '), NVL(MAX(A.COD_OPERA), ' '), "
                         "\n        NVL(MAX(A.A_SUSC_NUMBER), ' '), "
                         "\n        NVL(MAX(to_char(TO_DATE(A.DATE_START_CHARG,'YYYYMMDD'),:szhFormatoFecha)), ' '), "
                         "\n        NVL(MAX(to_char(to_date(A.TIME_START_CHARG,'HH24MISS'),:szhFormatoHora)), ' '), "
                         "\n        NVL(SUM(A.MTO_FACT), 0), "
                         "\n        NVL(SUM(A.DUR_FACT), 0), "
                         "\n        NVL(MAX(A.COD_SENT), ' '), "
                         "\n        NVL(MAX(A.B_SUSC_NUMBER), ' '), "
                         "\n        NVL(MAX(A.DES_DESTINO),'.'), "
                         "\n        NVL(A.COD_CARG, 0), "
                         "\n        SUM(DECODE(A.IND_BILLETE,'01',A.MTO_FACT,0)),    "
                         "\n        SUM(DECODE(A.IND_BILLETE,'02',A.MTO_FACT,0)),    "
                         "\n        MAX(DECODE(A.IND_BILLETE,'01',TO_CHAR(A.DUR_FACT),'0')),    "
                         "\n        MAX(DECODE(A.IND_BILLETE,'02',TO_CHAR(A.DUR_FACT),'0')),    "
                         "\n        SUM(NVL(A.NUM_PULSO,0)) ,"
                         "\n        NVL(MAX(A.RECORD_TYPE),' '), "
                         "\n        NVL(MAX(A.COD_DCTO),' '), "
                         "\n        NVL(MAX(A.TIP_DCTO),' '), "
                         "\n        SUM(NVL(A.VALOR_UNIDAD,0)),  "
                         "\n        NVL(MAX(A.DES_LLAMADA),'.') "
                         "\n FROM   PF_TOLTARIFICA_%ld A, "
                         "\n        (SELECT COD_REGISTRO, VALOR "
                         "\n         FROM   FA_REGDETLLAM_TD "
                         "\n         WHERE  TIP_REGISTRO IN ('ROA')) B "
                         "\n WHERE  A.NUM_CLIE = :lhCodCliente "
                         "\n  AND   A.NUM_ABON = :lhNumAbonado "
                         /* "\n  AND   A.COD_TCOR = 'VE' " */ /* P-MIX-09003 141767 */
                         "\n  AND   A.COD_AGRL = B.VALOR "                         
                         "\n GROUP BY B.COD_REGISTRO,A.SEC_EMPA,A.SEC_CDR,A.COD_CARG "
                         "\n ORDER BY B.COD_REGISTRO, A.SEC_EMPA,A.SEC_CDR,MAX(A.COD_OPERA),MAX(A.DATE_START_CHARG),MAX(A.TIME_START_CHARG) "
                       , lhCodCiclFact);

    vDTrazasLog( szModulo,"=> query cDetRoaming_Tol(\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_cDetRoaming_Tol FROM :szCadenaSQL; */ 

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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE cDetRoaming_Tol Error [%d][%s]",LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE cDetRoaming_Tol CURSOR FOR sql_cDetRoaming_Tol; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. cDetRoaming_Tol Error [%d][%s]",LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    
    /* EXEC SQL OPEN cDetRoaming_Tol USING :szhFormatoFecha, :szhFormatoHora, :lhCodCliente, :lhNumAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
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
    sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
    sqlstm.sqhstl[0] = (unsigned long )22;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoHora;
    sqlstm.sqhstl[1] = (unsigned long )9;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
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


    if (SQLCODE !=  SQLOK)  {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN CURSOR curDetRoaming **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN CURSOR curDetRoaming **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    return TRUE;
}/*****************  Final de ifnOpenDetRoaming  ********************/

/************************************************************************/
/*  FUNCION    : ifnFetchDetRoaming                                     */
/*  DESCRIPCION: Realiza FETCH sobre TA_LLAMADASROA                     */
/************************************************************************/
int ifnFetchDetRoaming(DETROAMING *stDetRoaming ,int iTasador)
{
/* EXEC SQL BEGIN DECLARE SECTION ; */ 

    int     ihCodOperRoam      ;
    char    szhNumMovil    [16]; /* EXEC SQL VAR szhNumMovil    IS STRING(16); */ 

    char    szhFecLlamada  [22]; /* EXEC SQL VAR szhFecLlamada  IS STRING(22); */ 

    char    szhHraLlamada  [9] ; /* EXEC SQL VAR szhHraLlamada  IS STRING(9); */ 

    double  dhImporte          ;
    long    lhSegundos         ;
    char    szhIndEntSal   [6] ; /* EXEC SQL VAR szhIndEntSal   IS STRING(6); */ 

    char    szhNumDestino  [19]; /* EXEC SQL VAR szhNumDestino  IS STRING(19); */ 

    char    szhDesDestino  [31]; /* EXEC SQL VAR szhDesDestino  IS STRING(31); */ 

    char    szhSecEmpa     [31]; /* EXEC SQL VAR szhSecEmpa     IS STRING(31); */ 

    char    szhSecCdr      [7] ; /* EXEC SQL VAR szhSecCdr      IS STRING(7); */ 

    int     ihCodCarg          ; 
    double  dhImpLocal1        ; 
    double  dhImpLarga2        ; 
    char    szhDurLocal1   [10]; /* EXEC SQL VAR szhDurLocal1   IS STRING(10); */ 

    char    szhDurLarga2   [10]; /* EXEC SQL VAR szhDurLarga2   IS STRING(10); */ 

    long    lNumPulsos         ;
    char    szRecordType   [3] ; /* EXEC SQL VAR szRecordType   IS STRING(3); */ 

    char    szCodDcto      [6] ; /* EXEC SQL VAR szCodDcto      IS STRING(6); */ 

    char    szTipDcto      [6] ; /* EXEC SQL VAR szTipDcto      IS STRING(6); */ 

    char    szhDesLlamada [101]; /* EXEC SQL VAR szhDesLlamada  IS STRING(101); */ 
 /* P-MIX-09003 */   
    char    szhCodRegistro  [6]; /* EXEC SQL VAR szhCodRegistro IS STRING(6); */ 
 /* P-MIX-09003 */    
    double  dValorUnidad       ; 

/* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "ifnFetchDetRoaming");
    vDTrazasLog("","\n\tEntrada en %s", LOG04,szModulo);

    /* EXEC SQL FETCH cDetRoaming_Tol INTO
            :szhCodRegistro ,
            :szhSecEmpa     ,
            :szhSecCdr      ,
            :ihCodOperRoam  ,
            :szhNumMovil    ,
            :szhFecLlamada  ,
            :szhHraLlamada  ,
            :dhImporte      ,
            :lhSegundos     ,
            :szhIndEntSal   ,
            :szhNumDestino  ,
            :szhDesDestino  ,
            :ihCodCarg      , 
            :dhImpLocal1    , 
            :dhImpLarga2    , 
            :szhDurLocal1   , 
            :szhDurLarga2   , 
            :lNumPulsos     , 
            :szRecordType   , 
            :szCodDcto      , 
            :szTipDcto      , 
            :dValorUnidad   ,
            :szhDesLlamada  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )55;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegistro;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhSecEmpa;
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhSecCdr;
    sqlstm.sqhstl[2] = (unsigned long )7;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCodOperRoam;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhNumMovil;
    sqlstm.sqhstl[4] = (unsigned long )16;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFecLlamada;
    sqlstm.sqhstl[5] = (unsigned long )22;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhHraLlamada;
    sqlstm.sqhstl[6] = (unsigned long )9;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhImporte;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhSegundos;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhIndEntSal;
    sqlstm.sqhstl[9] = (unsigned long )6;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhNumDestino;
    sqlstm.sqhstl[10] = (unsigned long )19;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhDesDestino;
    sqlstm.sqhstl[11] = (unsigned long )31;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)&ihCodCarg;
    sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)&dhImpLocal1;
    sqlstm.sqhstl[13] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)&dhImpLarga2;
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )0;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)szhDurLocal1;
    sqlstm.sqhstl[15] = (unsigned long )10;
    sqlstm.sqhsts[15] = (         int  )0;
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)szhDurLarga2;
    sqlstm.sqhstl[16] = (unsigned long )10;
    sqlstm.sqhsts[16] = (         int  )0;
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)&lNumPulsos;
    sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[17] = (         int  )0;
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)szRecordType;
    sqlstm.sqhstl[18] = (unsigned long )3;
    sqlstm.sqhsts[18] = (         int  )0;
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)szCodDcto;
    sqlstm.sqhstl[19] = (unsigned long )6;
    sqlstm.sqhsts[19] = (         int  )0;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)szTipDcto;
    sqlstm.sqhstl[20] = (unsigned long )6;
    sqlstm.sqhsts[20] = (         int  )0;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)&dValorUnidad;
    sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[21] = (         int  )0;
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)szhDesLlamada;
    sqlstm.sqhstl[22] = (unsigned long )101;
    sqlstm.sqhsts[22] = (         int  )0;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
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

 /* P-MIX-09003 */ 

    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  {
        vDTrazasLog (szModulo, "\n\t\t Error Oracle : %s - %s", LOG01,"Fetch=> PF_TOLTARIFICA", SQLERRM );
        vDTrazasError(szModulo,"\n\t\t Error Oracle : %s - %s", LOG01,"Fetch=> PF_TOLTARIFICA", SQLERRM );
        return FALSE;
    }

    if (SQLCODE == SQLOK) {
        stDetRoaming->iCodOperRoa   = ihCodOperRoam ;
        stDetRoaming->dImporte      = dhImporte;
        stDetRoaming->lSegundos     = (lhSegundos);

        sprintf(stDetRoaming->szCodRegistro,"%s\0",szhCodRegistro); /* P-MIX-09003 */ 
        sprintf(stDetRoaming->szIndEntSal  ,"%s\0",szhIndEntSal  );
        sprintf(stDetRoaming->szNumMovil   ,"%s\0",szhNumMovil   );
        sprintf(stDetRoaming->szFecLlamada ,"%s\0",szhFecLlamada );
        sprintf(stDetRoaming->szHraLlamada ,"%s\0",szhHraLlamada );
        sprintf(stDetRoaming->szNumDestino ,"%s\0",szhNumDestino );
        sprintf(stDetRoaming->szDesDestino ,"%s\0",szhDesDestino );
        sprintf(stDetRoaming->szDesLlamada ,"%s\0",szhDesLlamada ); /* P-MIX-09003 */ 
        stDetRoaming->iCod_Carg   = ihCodCarg; 
        stDetRoaming->dImpLocal1  = dhImpLocal1; 
        stDetRoaming->dImpLarga2  = dhImpLarga2; 
        strcpy(stDetRoaming->szDurLocal1,  szhDurLocal1);
        strcpy(stDetRoaming->szDurLarga2,  szhDurLarga2);

        stDetRoaming->lNumPulsos  = lNumPulsos; 
        strcpy(stDetRoaming->szRecordType,  szRecordType);
        strcpy(stDetRoaming->szCodDcto,  szCodDcto);  
        strcpy(stDetRoaming->szTipDcto,  szTipDcto);  
        stDetRoaming->dValorUnidad  = dValorUnidad;

    }
    else
            return FALSE;

    return TRUE;
}/****************  Final de ifnFetchDetRoaming    ******************/


/************************************************************************/
/*  FUNCION     : bfnClosseDetRoaming                                   */
/*  DESCRIPCION : Cierra el cursor sobre TA_LLAMADASROA                 */
/************************************************************************/
BOOL bfnCloseDetRoaming(int iTasador)
{
    strcpy (szModulo, "bfnCloseDetRoaming");
    vDTrazasLog("","\n\tEntrada en %s", LOG04,szModulo);

    /* EXEC SQL CLOSE cDetRoaming_Tol ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szModulo, "\n\n\t Error al cerrar el Cursor DetRoaming: %s", LOG01, SQLERRM);
        vDTrazasError(szModulo, "\n\n\t Error al cerrar el Cursor DetRoaming: %s", LOG01, SQLERRM);
        return FALSE;
    }
    return TRUE;
}/***********************  bfnCloseDetRoaming   *********************/

/****************************************************************************/
/* FUNCION : bfnDetLlamCelularTOL                                           */
/****************************************************************************/
BOOL bfnDetLlamCelularTOL( ST_ABONADO  *pst_Abonados,
                           ST_FACTCLIE *pst_Cliente,
                           int         iIndice,
                           FILE        *fArchImp,
                           char        *szBuffer,
                           int         *bImprimioD1000,
                           DETALLEOPER *pst_MascaraOper,
                           long        lCodCiclFact)
{

    char                     szTipoRegistro[20]              ;
    BOOL                     bEscribe = TRUE                 ;
    DETLLAMADAS              *pstDetLlamadasTemp             ;
    DETLLAMADAS              *pstDetLDITemp                  ;
    DETCELULAR_AGRUP         *stDetCelularTemp               ;
    DETCELULAR_AGRUP         *stDetLDITemp                   ;
    static DETLLAMADAS_HOSTS stDetLlamHost                   ;
    NUMORDEN                 pstNumOrden                     ;
    char                     szRegistro[MAX_BYTES_REGISTRO+1];
    char                     szBuffer_local              [25];
    char                     szDurReal                  [7+1];
    char                     szDurDcto                  [7+1];
    int                      iDurReal                        ;
    int                      iDurDcto                        ;
    int                      bImprimioD2000           = FALSE;
    int                      iOra                            ;
    int                      iNumFilas                    = 0;
    register int             iCont,i,j                       ;
    long                     lPosicion                       ;
    double                   dTotalLocal1Larga2              ; 
    double                   dTotalUnidad                    ;
    double                   dTotalUnidadAlta                ;
    double                   dTotalUnidadBaja                ;   
    int                      iPosRegistro                 = 0;
    int                      iMascara                     = 0;
    long                     lhCodCiclFact                   ;

    memset(&pstNumOrden, 0, sizeof(NUMORDEN));
    
    strcpy (szModulo, "bfnDetLlamCelularTOL");
    
    lhCodCiclFact = lCodCiclFact;
    
    vDTrazasLog(szModulo, "\n\tEntrada en %s"
                          "\n\t\t==> Cod_Cliente  [%ld]"
                          "\n\t\t==> Num. Abonado [%ld]"
                          "\n\t\t==> Num. Celular [%ld]"
                          "\n\t\t==> Indice       [%d]"
                          "\n\t\t==> Ciclo Fact.  [%ld]"                    
                        , LOG04,szModulo
                        , pst_Cliente->lCodCliente
                        , pst_Abonados->lNumAbonado[iIndice]
                        , pst_Abonados->lNumCelular[iIndice]
                        , iIndice
                        , lCodCiclFact);

    iOra= ifnOraDeclaraTraficoTolTarifica ( pst_Cliente->lCodCliente, 
                                            pst_Abonados->lNumAbonado[iIndice],
                                            lhCodCiclFact);

    if (iOra != SQLOK)
    {
        vDTrazasLog (szExeName, "\n\nERROR (%s): Error al declarar cursor sobre DETCELULAR"
                                , LOG05,szModulo );
        return (FALSE);
    }

    vDTrazasLog (szExeName,"\n\n (%s): Antes del While Principal", LOG04,szModulo );
    while (iOra != SQLNOTFOUND)
    {
        iOra = ifnOraLeerTolTarifica(&stDetLlamHost,&iNumFilas);

        if (iOra != SQLOK  && iOra != SQLNOTFOUND)
        {
            vDTrazasLog (szExeName,"\n\n (%s): Salida de FETCH sobre DETCELULAR", LOG05,szModulo );
            return (FALSE);
        }

        if (!iNumFilas)
            break;

        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            if (bfnDeterminaGrupo(stDetLlamHost.iCod_Carg[iCont], &stDetCelular, &lPosicion, &pstNumOrden))
            {
                vDTrazasLog (szExeName,"\t(bfnDetLlamCelularTOL): Existe grupo... solo agrega llamada \n", LOG04 );

                if ( stDetLlamHost.lCodConcCarrier[iCont] > 0 )
                {
                    stDetCelular.stAgrupacion[lPosicion].stDetLlamadas = (DETLLAMADAS*) realloc(stDetCelular.stAgrupacion[lPosicion].stDetLlamadas, sizeof(DETLLAMADAS)* (stDetCelular.stAgrupacion[lPosicion].iCantLlamadas + 1));
                    pstDetLDITemp = &(stDetCelular.stAgrupacion[lPosicion].stDetLlamadas)[(stDetCelular.stAgrupacion[lPosicion].iCantLlamadas)];
                    memset(pstDetLDITemp, 0, sizeof(DETLLAMADAS));

                    strcpy(pstDetLDITemp->szSec_Empa           , stDetLlamHost.szSec_Empa[iCont]   );
                    strcpy(pstDetLDITemp->szSec_Cdr            , stDetLlamHost.szSec_Cdr[iCont]    );
                    strcpy(pstDetLDITemp->szFecIniTasa         , stDetLlamHost.szFecIniTasa[iCont] );
                    strcpy(pstDetLDITemp->szTieIniLlam         , stDetLlamHost.szTieIniLlam[iCont] );
                    strcpy(pstDetLDITemp->szNumMovil1          , stDetLlamHost.szNumMovil1[iCont]  );
                    strcpy(pstDetLDITemp->szNumMovil2          , stDetLlamHost.szNumMovil2[iCont]  );
                    strcpy(pstDetLDITemp->szCodFranHoraSoc     , stDetLlamHost.szCodFranHoraSoc[iCont] );
                    strcpy(pstDetLDITemp->szCodAlm             , stDetLlamHost.szCodAlm[iCont]     );
                    strcpy(pstDetLDITemp->szDesMovil2          , stDetLlamHost.szDesMovil2[iCont]  );
                    strcpy(pstDetLDITemp->szDurLocal1          , stDetLlamHost.szDurLocal1[iCont]  );
                    strcpy(pstDetLDITemp->szDurLarga2          , stDetLlamHost.szDurLarga2[iCont]  );
                    strcpy(pstDetLDITemp->szIndEntSal1         , stDetLlamHost.szIndEntSal1[iCont] );

                    pstDetLDITemp->dMto_Real  = stDetLlamHost.dMto_Real[iCont] ;
                    pstDetLDITemp->dMto_Dcto  = stDetLlamHost.dMto_Dcto[iCont] ;
                    pstDetLDITemp->iDur_Real  = stDetLlamHost.iDur_Real[iCont] ;
                    pstDetLDITemp->iDur_Dcto  = stDetLlamHost.iDur_Dcto[iCont] ;
                    pstDetLDITemp->iCod_Carg  = stDetLlamHost.iCod_Carg[iCont] ;
                    pstDetLDITemp->dImpLocal1 = stDetLlamHost.dImpLocal1[iCont];
                    pstDetLDITemp->dImpLarga2 = stDetLlamHost.dImpLarga2[iCont];

                    strcpy(pstDetLDITemp->szCodFCob        , stDetLlamHost.szCodFCob[iCont]    );
                    pstDetLDITemp->dValorUndad= stDetLlamHost.dValorUndad[iCont];
                    pstDetLDITemp->lCodConcCarrier = stDetLlamHost.lCodConcCarrier[iCont];    
                    pstDetLDITemp->lNumPulsos       = stDetLlamHost.lNumPulsos[iCont]; 
                    strcpy(pstDetLDITemp->szRecordType , stDetLlamHost.szRecordType[iCont]);
                    strcpy(pstDetLDITemp->szCodDcto    , stDetLlamHost.szCodDcto[iCont]);
                    strcpy(pstDetLDITemp->szTipDcto    , stDetLlamHost.szTipDcto[iCont]);
                    pstDetLDITemp->dValorUnidad    = stDetLlamHost.dValorUnidad[iCont]; 
                    strcpy(pstDetLDITemp->szDesLlamada    , stDetLlamHost.szDesLlamada[iCont]); /* P-MIX-09003 */                    
                    stDetCelular.stAgrupacion[lPosicion].iCantLlamadas++;
                    
                }else{

                    if ( ( strcmp (pstNumOrden.szCodRegistro, COD_LOCALES)          == 0 && pst_Abonados->iIndLocal[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_INTERZONA)        == 0 && pst_Abonados->iIndInterzona[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_LDI)              == 0 && pst_Abonados->iIndLdi[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_ESPECIALES)       == 0 && pst_Abonados->iIndEspeciales[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_ESPECIALES_DATA)  == 0 && pst_Abonados->iIndEspeciales[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_TARIFA_ADICIONAL) == 0 && pst_Abonados->iIndLocal[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_LOCALES)          == 0 && pst_Abonados->iIndLocal[iIndice] ) )
                    {

                        stDetCelular.stAgrupacion[lPosicion].stDetLlamadas = (DETLLAMADAS*) realloc(stDetCelular.stAgrupacion[lPosicion].stDetLlamadas, sizeof(DETLLAMADAS)* (stDetCelular.stAgrupacion[lPosicion].iCantLlamadas + 1));
                        pstDetLlamadasTemp = &(stDetCelular.stAgrupacion[lPosicion].stDetLlamadas)[(stDetCelular.stAgrupacion[lPosicion].iCantLlamadas)];
                        memset(pstDetLlamadasTemp, 0, sizeof(DETLLAMADAS));

                        strcpy(pstDetLlamadasTemp->szSec_Empa           , stDetLlamHost.szSec_Empa[iCont]   );
                        strcpy(pstDetLlamadasTemp->szSec_Cdr            , stDetLlamHost.szSec_Cdr[iCont]    );
                        strcpy(pstDetLlamadasTemp->szFecIniTasa         , stDetLlamHost.szFecIniTasa[iCont] );
                        strcpy(pstDetLlamadasTemp->szTieIniLlam         , stDetLlamHost.szTieIniLlam[iCont] );
                        strcpy(pstDetLlamadasTemp->szNumMovil1          , stDetLlamHost.szNumMovil1[iCont]  );
                        strcpy(pstDetLlamadasTemp->szNumMovil2          , stDetLlamHost.szNumMovil2[iCont]  );
                        strcpy(pstDetLlamadasTemp->szCodFranHoraSoc     , stDetLlamHost.szCodFranHoraSoc[iCont] );
                        strcpy(pstDetLlamadasTemp->szCodAlm             , stDetLlamHost.szCodAlm[iCont]     );
                        strcpy(pstDetLlamadasTemp->szDesMovil2          , stDetLlamHost.szDesMovil2[iCont]  );
                        strcpy(pstDetLlamadasTemp->szDurLocal1          , stDetLlamHost.szDurLocal1[iCont]  );
                        strcpy(pstDetLlamadasTemp->szDurLarga2          , stDetLlamHost.szDurLarga2[iCont]  );
                        strcpy(pstDetLlamadasTemp->szIndEntSal1         , stDetLlamHost.szIndEntSal1[iCont] );

                        pstDetLlamadasTemp->dMto_Real  = stDetLlamHost.dMto_Real[iCont] ;
                        pstDetLlamadasTemp->dMto_Dcto  = stDetLlamHost.dMto_Dcto[iCont] ;
                        pstDetLlamadasTemp->iDur_Real  = stDetLlamHost.iDur_Real[iCont] ;
                        pstDetLlamadasTemp->iDur_Dcto  = stDetLlamHost.iDur_Dcto[iCont] ;
                        pstDetLlamadasTemp->iCod_Carg  = stDetLlamHost.iCod_Carg[iCont] ;
                        pstDetLlamadasTemp->dImpLocal1 = stDetLlamHost.dImpLocal1[iCont];
                        pstDetLlamadasTemp->dImpLarga2 = stDetLlamHost.dImpLarga2[iCont];
                        strcpy(pstDetLlamadasTemp->szCodFCob        , stDetLlamHost.szCodFCob[iCont]    );
                        pstDetLlamadasTemp->dValorUndad = stDetLlamHost.dValorUndad[iCont];
                        pstDetLlamadasTemp->lCodConcCarrier = stDetLlamHost.lCodConcCarrier[iCont];                                                
                        pstDetLlamadasTemp->lNumPulsos      = stDetLlamHost.lNumPulsos[iCont]; 
                        strcpy(pstDetLlamadasTemp->szRecordType , stDetLlamHost.szRecordType[iCont]);
                        strcpy(pstDetLlamadasTemp->szCodDcto    , stDetLlamHost.szCodDcto[iCont]);
                        strcpy(pstDetLlamadasTemp->szTipDcto    , stDetLlamHost.szTipDcto[iCont]);
                        pstDetLlamadasTemp->dValorUnidad    = stDetLlamHost.dValorUnidad[iCont]; 
                        strcpy(pstDetLlamadasTemp->szDesLlamada    , stDetLlamHost.szDesLlamada[iCont]); /* P-MIX-09003 */                      

                        stDetCelular.stAgrupacion[lPosicion].iCantLlamadas++;
                    }/* Fin if valida mascara */
                }
            }
            else
            {
        if ( stDetLlamHost.lCodConcCarrier[iCont] > 0 ) 
        {
             /* No existe el grupo, por lo que hay q crearlo y agregar el registro de llamadas */
                    vDTrazasLog (szExeName,"\t(bfnDetLlamLdiTOL): No Existe grupo. Lo crea y agrega llamada \n", LOG04 );

                    stDetCelular.stAgrupacion = (DETCELULAR_AGRUP*) realloc(stDetCelular.stAgrupacion, sizeof(DETCELULAR_AGRUP) * (stDetCelular.iCantEstructuras + 1) );
                    stDetLDITemp = &(stDetCelular.stAgrupacion)[(stDetCelular.iCantEstructuras)];
                    memset(stDetLDITemp, 0, sizeof(DETCELULAR_AGRUP));

                    stDetCelular.iCantEstructuras++;

                    stDetLDITemp->iNum_OrdenGr      = pstNumOrden.iNum_OrdenGr  ;
                    stDetLDITemp->iNum_OrdenSubGr   = pstNumOrden.iNum_OrdenSubGr;
                    stDetLDITemp->iCodGrupo         = pstNumOrden.iCodGrupo     ;
                    stDetLDITemp->iCodSubGrupo      = pstNumOrden.iCodSubGrupo  ;
                    stDetLDITemp->iCriterio         = pstNumOrden.iCodCriterio  ;
                    stDetLDITemp->iTipo_Llamada     = pstNumOrden.iTipo_Llamada ;
                    strcpy (stDetLDITemp->szCodRegistro , pstNumOrden.szCodRegistro);
                    stDetLDITemp->iCantLlamadas     = 1;

                    stDetLDITemp->stDetLlamadas = (DETLLAMADAS *)malloc (sizeof(DETLLAMADAS));

                    if(stDetLDITemp->stDetLlamadas == NULL)
                    {
                        vDTrazasLog (szExeName,"\n\nERROR(%s): En asignacion de memoria a stDetLDITemp->stDetLlamadas.", LOG05,szModulo );
                        vDTrazasError (szExeName,"\n\nERROR(%s): En asignacion de memoria a stDetLDITemp->stDetLlamadas.", LOG05,szModulo );
                        return (FALSE);
                    }

                    strcpy(stDetLDITemp->stDetLlamadas->szSec_Empa    , stDetLlamHost.szSec_Empa[iCont]   );
                    strcpy(stDetLDITemp->stDetLlamadas->szSec_Cdr     , stDetLlamHost.szSec_Cdr[iCont]  );
                    strcpy(stDetLDITemp->stDetLlamadas->szFecIniTasa      , stDetLlamHost.szFecIniTasa[iCont]   );
                    strcpy(stDetLDITemp->stDetLlamadas->szTieIniLlam      , stDetLlamHost.szTieIniLlam[iCont]   );
                    strcpy(stDetLDITemp->stDetLlamadas->szNumMovil1       , stDetLlamHost.szNumMovil1[iCont]    );
                    strcpy(stDetLDITemp->stDetLlamadas->szNumMovil2       , stDetLlamHost.szNumMovil2[iCont]    );
                    strcpy(stDetLDITemp->stDetLlamadas->szCodFranHoraSoc  , stDetLlamHost.szCodFranHoraSoc[iCont]);
                    strcpy(stDetLDITemp->stDetLlamadas->szCodAlm          , stDetLlamHost.szCodAlm[iCont]   );
                    strcpy(stDetLDITemp->stDetLlamadas->szDesMovil2       , stDetLlamHost.szDesMovil2[iCont]    );
                    strcpy(stDetLDITemp->stDetLlamadas->szDurLocal1       , stDetLlamHost.szDurLocal1[iCont]    );
                    strcpy(stDetLDITemp->stDetLlamadas->szDurLarga2       , stDetLlamHost.szDurLarga2[iCont]    );
                    strcpy(stDetLDITemp->stDetLlamadas->szIndEntSal1      , stDetLlamHost.szIndEntSal1[iCont]   );
                    stDetLDITemp->stDetLlamadas->dMto_Real          = stDetLlamHost.dMto_Real[iCont]    ;
                    stDetLDITemp->stDetLlamadas->dMto_Dcto          = stDetLlamHost.dMto_Dcto[iCont]    ;
                    stDetLDITemp->stDetLlamadas->iDur_Real          = stDetLlamHost.iDur_Real[iCont]    ;
                    stDetLDITemp->stDetLlamadas->iDur_Dcto          = stDetLlamHost.iDur_Dcto[iCont]    ;
                    stDetLDITemp->stDetLlamadas->iCod_Carg          = stDetLlamHost.iCod_Carg[iCont]    ;
                    stDetLDITemp->stDetLlamadas->dImpLocal1         = stDetLlamHost.dImpLocal1[iCont]   ;
                    stDetLDITemp->stDetLlamadas->dImpLarga2         = stDetLlamHost.dImpLarga2[iCont]   ;
                    strcpy(stDetLDITemp->stDetLlamadas->szCodFCob         , stDetLlamHost.szCodFCob[iCont]    );
                    stDetLDITemp->stDetLlamadas->dValorUndad        = stDetLlamHost.dValorUndad[iCont];
                    stDetLDITemp->stDetLlamadas->lCodConcCarrier    = stDetLlamHost.lCodConcCarrier[iCont];                                        
                    stDetLDITemp->stDetLlamadas->lNumPulsos         = stDetLlamHost.lNumPulsos[iCont]; 
                    strcpy(stDetLDITemp->stDetLlamadas->szRecordType , stDetLlamHost.szRecordType[iCont]);
                    strcpy(stDetLDITemp->stDetLlamadas->szCodDcto    , stDetLlamHost.szCodDcto[iCont]);
                    strcpy(stDetLDITemp->stDetLlamadas->szTipDcto    , stDetLlamHost.szTipDcto[iCont]);
                    stDetLDITemp->stDetLlamadas->dValorUnidad       = stDetLlamHost.dValorUnidad[iCont];
                    strcpy(stDetLDITemp->stDetLlamadas->szDesLlamada    , stDetLlamHost.szDesLlamada[iCont]); /* P-MIX-09003 */                 
        }else{
                    if ( ( strcmp (pstNumOrden.szCodRegistro, COD_LOCALES)          == 0 && pst_Abonados->iIndLocal[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_INTERZONA)        == 0 && pst_Abonados->iIndInterzona[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_LDI)      == 0 && pst_Abonados->iIndLdi[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_ESPECIALES)       == 0 && pst_Abonados->iIndEspeciales[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_ESPECIALES_DATA)  == 0 && pst_Abonados->iIndEspeciales[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_TARIFA_ADICIONAL) == 0 && pst_Abonados->iIndLocal[iIndice] ) ||
                         ( strcmp (pstNumOrden.szCodRegistro, COD_LOCALES)          == 0 && pst_Abonados->iIndLocal[iIndice] ) )
                    {

                        /* No existe el grupo, por lo que hay q crearlo y agregar el registro de llamadas */
                        vDTrazasLog (szExeName,"\t(bfnDetLlamCelularTOL): No Existe grupo. Lo crea y agrega llamada \n", LOG04 );

                        stDetCelular.stAgrupacion = (DETCELULAR_AGRUP*) realloc(stDetCelular.stAgrupacion, sizeof(DETCELULAR_AGRUP) * (stDetCelular.iCantEstructuras + 1) );
                        stDetCelularTemp = &(stDetCelular.stAgrupacion)[(stDetCelular.iCantEstructuras)];
                        memset(stDetCelularTemp, 0, sizeof(DETCELULAR_AGRUP));

                        stDetCelular.iCantEstructuras++;
                        stDetCelularTemp->iNum_OrdenGr      = pstNumOrden.iNum_OrdenGr  ;
                        stDetCelularTemp->iNum_OrdenSubGr   = pstNumOrden.iNum_OrdenSubGr;
                        stDetCelularTemp->iCodGrupo         = pstNumOrden.iCodGrupo     ;
                        stDetCelularTemp->iCodSubGrupo      = pstNumOrden.iCodSubGrupo  ;
                        stDetCelularTemp->iCriterio         = pstNumOrden.iCodCriterio  ;
                        stDetCelularTemp->iTipo_Llamada     = pstNumOrden.iTipo_Llamada ;
                        strcpy (stDetCelularTemp->szCodRegistro , pstNumOrden.szCodRegistro);
                        stDetCelularTemp->iCantLlamadas     = 1;
                        stDetCelularTemp->stDetLlamadas = (DETLLAMADAS *)malloc (sizeof(DETLLAMADAS));

                        if(stDetCelularTemp->stDetLlamadas == NULL)
                        {
                            vDTrazasLog (szExeName,"\n\nERROR(%s): En asignacion de memoria a stDetCelularTemp->stDetLlamadas.", LOG05,szModulo );
                            vDTrazasError (szExeName,"\n\nERROR(%s): En asignacion de memoria a stDetCelularTemp->stDetLlamadas.", LOG05,szModulo );
                            return (FALSE);
                        }


                        strcpy(stDetCelularTemp->stDetLlamadas->szSec_Empa    , stDetLlamHost.szSec_Empa[iCont]   );
                        strcpy(stDetCelularTemp->stDetLlamadas->szSec_Cdr     , stDetLlamHost.szSec_Cdr[iCont]  );
                        strcpy(stDetCelularTemp->stDetLlamadas->szFecIniTasa      , stDetLlamHost.szFecIniTasa[iCont]   );
                        strcpy(stDetCelularTemp->stDetLlamadas->szTieIniLlam      , stDetLlamHost.szTieIniLlam[iCont]   );
                        strcpy(stDetCelularTemp->stDetLlamadas->szNumMovil1       , stDetLlamHost.szNumMovil1[iCont]    );
                        strcpy(stDetCelularTemp->stDetLlamadas->szNumMovil2       , stDetLlamHost.szNumMovil2[iCont]    );
                        strcpy(stDetCelularTemp->stDetLlamadas->szCodFranHoraSoc  , stDetLlamHost.szCodFranHoraSoc[iCont]);
                        strcpy(stDetCelularTemp->stDetLlamadas->szCodAlm          , stDetLlamHost.szCodAlm[iCont]   );
                        strcpy(stDetCelularTemp->stDetLlamadas->szDesMovil2       , stDetLlamHost.szDesMovil2[iCont]    );
                        strcpy(stDetCelularTemp->stDetLlamadas->szDurLocal1       , stDetLlamHost.szDurLocal1[iCont]    );
                        strcpy(stDetCelularTemp->stDetLlamadas->szDurLarga2       , stDetLlamHost.szDurLarga2[iCont]    );
                        strcpy(stDetCelularTemp->stDetLlamadas->szIndEntSal1      , stDetLlamHost.szIndEntSal1[iCont]   );
                        stDetCelularTemp->stDetLlamadas->dMto_Real          = stDetLlamHost.dMto_Real[iCont]    ;
                        stDetCelularTemp->stDetLlamadas->dMto_Dcto          = stDetLlamHost.dMto_Dcto[iCont]    ;
                        stDetCelularTemp->stDetLlamadas->iDur_Real          = stDetLlamHost.iDur_Real[iCont]    ;
                        stDetCelularTemp->stDetLlamadas->iDur_Dcto          = stDetLlamHost.iDur_Dcto[iCont]    ;
                        stDetCelularTemp->stDetLlamadas->iCod_Carg          = stDetLlamHost.iCod_Carg[iCont]    ;
                        stDetCelularTemp->stDetLlamadas->dImpLocal1         = stDetLlamHost.dImpLocal1[iCont]   ;
                        stDetCelularTemp->stDetLlamadas->dImpLarga2         = stDetLlamHost.dImpLarga2[iCont]   ;
                        strcpy(stDetCelularTemp->stDetLlamadas->szCodFCob         , stDetLlamHost.szCodFCob[iCont]    );
                        stDetCelularTemp->stDetLlamadas->dValorUndad        = stDetLlamHost.dValorUndad[iCont];
                        stDetCelularTemp->stDetLlamadas->lCodConcCarrier    = stDetLlamHost.lCodConcCarrier[iCont];
                        stDetCelularTemp->stDetLlamadas->lNumPulsos         = stDetLlamHost.lNumPulsos[iCont]; 
                        strcpy(stDetCelularTemp->stDetLlamadas->szRecordType , stDetLlamHost.szRecordType[iCont]);
                        strcpy(stDetCelularTemp->stDetLlamadas->szCodDcto    , stDetLlamHost.szCodDcto[iCont]);
                        strcpy(stDetCelularTemp->stDetLlamadas->szTipDcto    , stDetLlamHost.szTipDcto[iCont]);
                        stDetCelularTemp->stDetLlamadas->dValorUnidad       = stDetLlamHost.dValorUnidad[iCont]; 
                        strcpy(stDetCelularTemp->stDetLlamadas->szDesLlamada    , stDetLlamHost.szDesLlamada[iCont]); /* P-MIX-09003 */                       
                    }
                }
            }
        }

    }

    vDTrazasLog (szExeName,"\n\n(/bfnDetLlamCelular): Despues del While Principal", LOG04 );

    iOra=ifnOraCerrarTraficoTolTarifica();
    if (iOra != SQLOK)
    {
        vDTrazasLog (szExeName,"\n\nERROR(bfnDetLlamCelularTOL):"
                "\n\tError al cerrar el cursor", LOG05 );
        return (FALSE);
    }

    if (!bfnImprimeEstruc(&stDetCelular))
        vDTrazasLog (szExeName,"\nImpresion Con Error.", LOG05);


    if (!bfnOrdenaEstructuras(&stDetCelular))
        vDTrazasLog (szExeName,"\nOrdenamiento Con Error.", LOG05);


    if (!bfnImprimeEstruc(&stDetCelular))
        vDTrazasLog (szExeName,"\nImpresion Con Error.", LOG05);

    /* Recoriendo la estructura completa para llevarla al Punto DAT */
    for (i=0; i< stDetCelular.iCantEstructuras; i++)
    {
        for (j=0; j < stDetCelular.stAgrupacion[i].iCantLlamadas; j++)
        {

            if( stDetCelular.stAgrupacion[i].stDetLlamadas[j].lCodConcCarrier == 0 )
            {
                if(!*bImprimioD1000)
                {
                    put_D1000(pst_Abonados,fArchImp,iIndice,szBuffer);
                    *bImprimioD1000 = TRUE;
                }

                if (!bImprimioD2000)
                {
                    /*********************************************/
                    /* Escribe cabecera de tipo de registro      */
                    /*********************************************/

                    sprintf(szBuffer_local ,"%5s%013d%05d\n"
                                           ,COD_TIPOLLAMADA
                                           ,stDetCelular.stAgrupacion[i].iTipo_Llamada
                                           ,atoi(pst_Cliente->szCod_Idioma));

                    if (!bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local))
                    {
            	        vDTrazasLog(szModulo,"\n\t (%s) : Error en funcion bEscribeEnArchivo ", LOG05, szModulo);
                    }
                                        
                    bImprimioD2000=TRUE;
                }


                /************************************************************************/
                /* Escribimos en buffer Validando Tamano del Buffer  o                  */
                /* Escribimos en Archivo y Limpiamos Buffer                             */
                /************************************************************************/

                iDurReal = stDetCelular.stAgrupacion[i].stDetLlamadas[j].iDur_Real;
                iDurDcto = stDetCelular.stAgrupacion[i].stDetLlamadas[j].iDur_Dcto;

                sprintf(szDurReal,"%7.7d",iDurReal);
                sprintf(szDurDcto,"%7.7d",iDurDcto);

                /*strcpy (szTipoRegistro, stDetCelular.stAgrupacion[i].szCodRegistro);*/

                dTotalLocal1Larga2=stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLocal1 +
                                   stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLarga2;

                dTotalUnidad = 0.0;
                if (strcmp(stDetCelular.stAgrupacion[i].stDetLlamadas[j].szCodFCob,"D"))
                {
                    dTotalUnidad = stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLocal1 + stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLarga2;
                }
                else
                {
                    dTotalUnidad = stDetCelular.stAgrupacion[i].stDetLlamadas[j].dValorUndad;

                }
                dTotalUnidadAlta = 0.0;
                dTotalUnidadBaja = 0.0;
                if (strcmp(stDetCelular.stAgrupacion[i].stDetLlamadas[j].szCodFranHoraSoc,"N" ))
                {
                    dTotalUnidadBaja= dTotalUnidad ;
                }
                else
                {
                    dTotalUnidadAlta= dTotalUnidad ;
                }
                
                /* P-MIX-09003 141767 */
                if (stDetCelular.stAgrupacion[i].stDetLlamadas[j].lNumPulsos > 0)
                {   
                    dTotalUnidadAlta = stDetCelular.stAgrupacion[i].stDetLlamadas[j].dMto_Real / stDetCelular.stAgrupacion[i].stDetLlamadas[j].lNumPulsos;
                    vDTrazasLog(szModulo, "\n\t (%s) : Calculo "
                                          "\n\t\t Monto Real        [%f]"
                                          "\n\t\t Num.Pulsos        [%ld]"                                          
                                          "\n\t\t Monto Uni. Normal [%f]"                                          
                                        , LOG05
                                        , szModulo
                                        , stDetCelular.stAgrupacion[i].stDetLlamadas[j].dMto_Real
                                        , stDetCelular.stAgrupacion[i].stDetLlamadas[j].lNumPulsos
                                        , dTotalUnidadAlta);                    
                }
                else
                {                	
                    dTotalUnidadAlta = 0.0;
                    vDTrazasLog(szModulo, "\n\t (%s) : Calculo "
                                          "\n\t\t Monto Uni. Normal [%f]"
                                        , LOG05
                                        , szModulo
                                        , dTotalUnidadAlta);                    
                }
                /* P-MIX-09003 141767 */

                iPosRegistro = BuscaMascara(pst_MascaraOper,szTipoRegistro,pst_MascaraOper->iCantRegistros, pst_Cliente->iCodTipDocum);
                iMascara = (iPosRegistro>=0)? pst_MascaraOper->iIndImp[iPosRegistro]:0;
                if(iMascara == 1)
                {
                	
                	
                    sprintf(szRegistro,"%-5s%-8.8s%-6s%-20s%-20s%015.4f%015.4f%-6s%-3s%-30s%-7s%-7s%-6s%015.4f%015.4f%-7s%-7s%04d%015.4f%015.4f%015.4f%-10s%-1s%6.6ld%-2.2s%-5.5s%-5.5s%015.4f%-100.100s\n"
                                ,szTipoRegistro
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szFecIniTasa
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szTieIniLlam
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szNumMovil1
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szNumMovil2
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLocal1                                
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].dImpLarga2
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szCodFranHoraSoc
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szCodAlm
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szDesMovil2 /* P-MIX-09003 141767 */
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szDurLocal1
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szDurLarga2
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szIndEntSal1
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].dMto_Real
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].dMto_Dcto                                
                                ,szDurReal
                                ,szDurDcto
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].iCod_Carg
                                ,dTotalLocal1Larga2
                                ,dTotalUnidadAlta
                                ,dTotalUnidadBaja                                
                                ,"          "
                                ," "
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].lNumPulsos
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szRecordType
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szCodDcto
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szTipDcto
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].dValorUnidad 
                                ,stDetCelular.stAgrupacion[i].stDetLlamadas[j].szDesLlamada /* P-MIX-09003 */
                                );                                                             
                                

                        bEscribe= bEscribeEnArchivo(fArchImp,szBuffer,szRegistro);

                    if ( !bEscribe )
                    {
            	         vDTrazasLog(szModulo,"\n\t (%s) : Error en funcion bEscribeEnArchivo ", LOG01, szModulo);
                         return (FALSE);            	         
                    }                    
                }/* if(iMascara == 1) */
            } /* if( stDetCelular.stAgrupacion[i].stDetLlamadas[j]lCodConcCarrier == 0 ) */
        }
    }

    if(bImprimioD2000)
        {
            sprintf(szBuffer_local,"%s\n"
                              ,PIE_TIPOLLAMADA);

            bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
            
            if ( !bEscribe )
            {
                 vDTrazasLog(szModulo,"\n\t (%s) : Error en funcion bEscribeEnArchivo ", LOG05, szModulo);
            }            
            
        }
    return (TRUE);
}/************************* FIN bfnDetLlamCelularTOL ***************************/

/****************************************************************************/
/* FUNCION     : bfnDetLlamCarrier                                          */
/* DESCRIPCION : Imprime Detalle de Llamadas Carrier por Cliente, Abonado   */
/****************************************************************************/
BOOL bfnDetLlamCarrier  ( ST_ABONADO  *pst_Abonados,
                          ST_FACTCLIE *pst_Cliente,
                          int         iIndice,
                          int         iTipoLlamada,
                          FILE        *fArchImp,
                          char        *szBuffer,
                          int         *bImprimioD1000,
                          long        lCodCiclFact,
                          char        *szhCodRegistro)
{

    static DETLLAMADAS_HOSTS stDetLlamHost                   ;
    static DETLLAMADAS_HOSTS stDetLlamHostAnt                ;
    DETCARRIER               stDetCarrier                    ;
    DETCARRIER               stDetCarrierAnt                 ;
    BOOL                     bEscribe = TRUE                 ;
    char                     szRegistro[MAX_BYTES_REGISTRO+1];
    char                     szBuffer_local          [45 ]="";
    char                     szMinutosTasados           [7+1];
    int                      bImprimioD2000           = FALSE;
    long                     iCont                           ;
    int                      iOra                            ;
    int                      iSqlCodeDetCarrier              ;
    long                     iNumFilas = 0                   ;

    strcpy (szModulo, "bfnDetLlamCarrier");

    vDTrazasLog("","\n\t Entrada a %s"
                   "\n\t\t==> Cod. Cliente     [%ld]"
                   "\n\t\t==> Ind. OrdenTotal  [%ld]"
                   "\n\t\t==> Num. Proceso     [%ld]"
                   "\n\t\t==> Num. Abonado     [%ld]"
                   "\n\t\t==> Num. Celular     [%ld]"
                   "\n\t\t==> Indice           [%d]"
                   "\n\t\t==> Cicl. Fact       [%ld]"                   
                   "\n\t\t==> Cod. Registro    [%s]"
                   "\n\t\t==> szhBufferCursor  [%s]"                   
                   ,LOG04,szModulo
                   ,pst_Cliente->lCodCliente
                   ,pst_Cliente->lIndOrdenTotal
                   ,pst_Cliente->lNumProceso
                   ,pst_Abonados->lNumAbonado[iIndice]
                   ,pst_Abonados->lNumCelular[iIndice]
                   ,iIndice
                   ,lCodCiclFact
                   ,szhCodRegistro);

    vDTrazasLog (szExeName,"\n\n%s: Imprimiendo detalle de carrier de forma nueva", LOG04,szModulo );
    iOra= ifnOraDeclaraLlamCarrier ( pst_Cliente->lCodCliente, 
                                     pst_Abonados->lNumAbonado[iIndice],
                                     lCodCiclFact);

    if (iOra != SQLOK)
    {
        vDTrazasLog (szExeName,"\n\nERROR(%s):"
        "\n\tError al declarar cursor sobre DETCELULAR", LOG05,szModulo );
        return (FALSE);
    }


    vDTrazasLog (szExeName,"\n\n%s: Antes del While Principal", LOG04,szModulo );

    memset(&stDetLlamHostAnt , 0, sizeof (DETLLAMADAS_HOSTS));

    while (iOra != SQLNOTFOUND)
    {
        memset(&stDetLlamHost , 0, sizeof (DETLLAMADAS_HOSTS));

        iOra = ifnOraLeerLlamCarrier(&stDetLlamHost,&iNumFilas);

        if (iOra != SQLOK  && iOra != SQLNOTFOUND)
        {
            vDTrazasLog (szExeName,"\n\n%s: Salida de FETCH sobre DETCELULAR por error %d - %s", LOG05,szModulo, iOra, SQLERRM );
            return (FALSE);
        }

        if (!iNumFilas)
            break;


        vDTrazasLog (szExeName,"\n\n%s: Antes de For que imprime detalle de carrier", LOG04,szModulo );
        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            if( stDetLlamHost.lCodConcCarrier[iCont] > 0 )
            {
            vDTrazasLog (szExeName,"\n\n%s: Es una llamada Carrier, stDetLlamHost.lCodConcCarrier[%d]", LOG04,szModulo,stDetLlamHost.lCodConcCarrier[iCont] );
                if( !*bImprimioD1000)
                {
                  put_D1000(pst_Abonados,fArchImp,iIndice,szBuffer);
                  *bImprimioD1000 = TRUE;
                }

                if (!bImprimioD2000)
                {
                    /********************************************/
                    /* Escribe cabecera de tipo de registro     */
                    /********************************************/
                    sprintf(szBuffer_local ,"%5s%013d%05d\n"
                                           ,COD_TIPOLLAMADA
                                           ,iTipoLlamada
                                           ,atoi(pst_Cliente->szCod_Idioma));

                    bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);  
                    
                    if (!bEscribe)
                    {
                        vDTrazasLog (szExeName, "\n\n%s: Error al escribir cabecera en el archivo "
                                              , LOG05,szModulo);
                    }                                                          

                    bImprimioD2000=TRUE;
                }

                if (stDetLlamHostAnt.lCodConcCarrier[iCont] != stDetLlamHost.lCodConcCarrier[iCont])
                {
                    sprintf(szBuffer_local ,"%5s%05d%-30s\n"
                                           ,"D3014"
                                           ,stDetLlamHost.lCodConcCarrier[iCont]
                                           ,szfnBuscaDescPortadora(stDetLlamHost.lCodConcCarrier[iCont]));
                    bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
                    if (!bEscribe)
                    {
                        vDTrazasLog (szExeName, "\n\n%s: Error al escribir cabcera (D3014) en el archivo "
                                              , LOG05,szModulo);
                    }
                }

                sprintf(szRegistro,"%-5s%05d%-3.3s%-8.8s%-6.6s%-20.20s%-20.20s%015.4f%015.4f%6.6ld%-2.2s%-5.5s%-5.5s%015.4f%-100.100s\n"
                                  ,COD_CARRIERS
                                  ,stDetLlamHost.lCodConcCarrier[iCont]
                                  ,stDetLlamHost.szCodLlam[iCont]
                                  ,stDetLlamHost.szFecIniTasa[iCont]
                                  ,stDetLlamHost.szTieIniLlam[iCont]
                                  ,stDetLlamHost.szNumMovil2[iCont]
                                  ,stDetLlamHost.szDurLocal1[iCont]
                                  ,stDetLlamHost.dImpLocal1[iCont]
                                  ,stDetLlamHost.dImpLocal1[iCont]
                                  ,stDetLlamHost.lNumPulsos[iCont]
                                  ,stDetLlamHost.szRecordType[iCont]
                                  ,stDetLlamHost.szCodDcto[iCont]
                                  ,stDetLlamHost.szTipDcto[iCont]
                                  ,stDetLlamHost.dValorUnidad[iCont]
                                  ,stDetLlamHost.szDesLlamada[iCont]
                                  );

                memcpy(&stDetLlamHostAnt, &stDetLlamHost,sizeof(DETLLAMADAS_HOSTS));

                bEscribe=bEscribeEnArchivo(fArchImp,szBuffer,szRegistro);
                
                if (!bEscribe)
                {
                    vDTrazasLog (szExeName, "\n\n%s: Error al escribir en el archivo "
                                          , LOG05,szModulo);
                }                               
                
            }

    }/*End for*/
    vDTrazasLog (szExeName,"\n\n%s: Despues de For que imprime detalle de carrier iCOnt[%ld]", LOG04,szModulo,iCont );
    }


    vDTrazasLog (szExeName,"\n\n%s: Imprimiendo detalle de carrier de forma antigua", LOG04,szModulo );
    memset(szBuffer_local,0,sizeof(szBuffer_local));
    /************************************************************************************/
    /*    Recupera Detalle de Llamadas Carrier                                          */
    /************************************************************************************/
    iSqlCodeDetCarrier = ifnOpenDetCarrier ( pst_Cliente->lCodCliente,
                                             pst_Abonados->lNumAbonado[iIndice],
                                             pst_Cliente->lNumProceso);                                    

    memset(&stDetCarrierAnt , 0, sizeof (DETCARRIER));
    while (iSqlCodeDetCarrier)
    {
        memset(&stDetCarrier    , 0, sizeof (DETCARRIER));

        iSqlCodeDetCarrier = ifnFetchDetCarrier(&stDetCarrier);

        if(iSqlCodeDetCarrier)
        {
            if(iSqlCodeDetCarrier & !*bImprimioD1000)
            {
              put_D1000(pst_Abonados,fArchImp,iIndice,szBuffer);
              *bImprimioD1000 = TRUE;
            }

            if (!bImprimioD2000)
            {
                /********************************************/
                /* Escribe cabecera de tipo de registro     */
                /********************************************/
                sprintf(szBuffer_local ,"%5s%013d%05d\n"
                                       ,COD_TIPOLLAMADA
                                       ,iTipoLlamada
                                       ,atoi(pst_Cliente->szCod_Idioma));

                bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
                
                if (!bEscribe)
                {
                    vDTrazasLog (szExeName, "\n\n%s: Error al escribir cabecera en el archivo "
                                          , LOG05,szModulo);
                }

                bImprimioD2000=TRUE;
            }

            sprintf(szMinutosTasados,"%7.7ld",stDetCarrier.lSegundos);

            if (stDetCarrierAnt.iCodOperCarr != stDetCarrier.iCodOperCarr)
            {
                sprintf(szBuffer_local ,"%5s%05d%-30s\n"
                                       ,"D3014"
                                       ,stDetCarrier.iCodOperCarr
                                       ,szfnBuscaDescPortadora(stDetCarrier.iCodOperCarr));
                bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
                
                if (!bEscribe)
                {
                    vDTrazasLog (szExeName, "\n\n (%s): Error al escribir cabecera (D3014) en el archivo "
                                          , LOG04,szModulo);
                }
            }

            sprintf(szRegistro,"%5s%05d%-3.3s%-8.8s%-6.6s%-20.20s%-20.20s%-7.7s%015.4f%015.4f%6.6ld%-2.2s%-5.5s%-5.5s%015.4f\n"
                              ,COD_CARRIERS
                              ,stDetCarrier.iCodOperCarr
                              ,szfnBuscaTipoTraficoLD(stDetCarrier.szCodTrafico)
                              ,stDetCarrier.szFecLlamada
                              ,stDetCarrier.szHraLlamada
                              ,stDetCarrier.szNumDestino
                              ,stDetCarrier.szDesDestino
                              ,szMinutosTasados
                              ,stDetCarrier.dNeto
                              ,stDetCarrier.dNeto
                              ,0
                              ," "
                              ," "
                              ," "
                              ,0.0);

            memcpy(&stDetCarrierAnt, &stDetCarrier,sizeof(DETCARRIER));

            bEscribe=bEscribeEnArchivo(fArchImp,szBuffer,szRegistro);
            
            if (!bEscribe)
            {
                vDTrazasLog (szExeName,"\n\n (%s): Error al escribir en el archivo ", LOG04,szModulo);
            }
        }
    }
    /**********************************************************/


    if(bImprimioD2000)
    {
        sprintf(szBuffer_local   ,"%s\n",PIE_TIPOLLAMADA);

        bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
        
        if (!bEscribe)
        {
            vDTrazasLog (szExeName,"\n\n (%s): Error al escribir pie de pagina en el archivo ", LOG04,szModulo);
        }
    }

    iOra=ifnOraCerrarTraficoLlamCarrier();
    if (iOra != SQLOK)
    {
        vDTrazasLog (szExeName,"\n\nERROR(%s):"
                "\n\tError al cerrar el cursor", LOG05, szModulo );
        return (FALSE);
    }

   return (TRUE);
}/************************** FIN bfnDetLlamCarrier **************************/

/****************************************************************************/
/* FUNCION     : bObtieneMascara                                            */
/* DESCRIPCION : Genera mascara de impresion de detalle de llamado          */
/****************************************************************************/
BOOL bObtieneMascara( ST_ABONADO     *pst_Abonados
                     ,CONCEPTOS_TAR  *stConceptosTar
                     ,DETALLEOPER    *pst_MascaraOper)
{
    register int i,j,k;

    strcpy (szModulo, "bObtieneMascara");

    vDTrazasLog(szModulo,"\n\t Entrada en %s "
                         "\n\t\tCantidad Abonados     : [%d]"
                         "\n\t\tCantidad de Conceptos : [%d]"
                        ,LOG05, szModulo
                        ,pst_Abonados->CantidadAbonados
                        ,stFaDetCons.iNumReg);

    for (k=0;k<pst_Abonados->CantidadAbonados;k++)
    {   /* Limpia Mascara Abonado */
        pst_Abonados->iIndInterzona[k]  = 0;
        pst_Abonados->iIndLdi[k]        = 0;
        pst_Abonados->iIndEspeciales[k] = 0;
        pst_Abonados->iIndRoaming[k]    = 0;
        pst_Abonados->iIndCarrier[k]    = 0;

        if (pst_Abonados->lNumAbonado[k] == 0 )
            pst_Abonados->iIndDetFact[k] = 0;

        if ( pst_Abonados->iIndDetFact[k]==1)
        {
            pst_Abonados->iIndLocal[k]      = pst_MascaraOper->iIndLocal;
            pst_Abonados->iIndInterzona[k]  = pst_MascaraOper->iIndInterzona;
            pst_Abonados->iIndLdi[k]        = pst_MascaraOper->iIndLDI;
            pst_Abonados->iIndEspeciales[k] = pst_MascaraOper->iIndEspeciales;
            pst_Abonados->iIndCarrier[k]    = pst_MascaraOper->iIndCarrier;
            pst_Abonados->iIndRoaming[k]    = pst_MascaraOper->iIndRoaming;
        }
        else
            pst_Abonados->iIndLocal[k] = 0;

    } /* End for */

    for ( i=0 ; i < stFaDetCons.iNumReg ; i++)
    {
            vDTrazasLog(szModulo,"\t\t Cod Concepto[%d] : [%d]",
                                LOG05,i,stFaDetCons.stDetConsumo[i].iCodConcepto);

            for ( j = 0 ; j < stConceptosTar->iNumConceptos ; j++)
            {
                if ( stFaDetCons.stDetConsumo[i].iCodConcepto == stConceptosTar->iCodConcepto[j] )
                {
                    /* Busca abonado y activa flag de impresion */
                    for (k=0;k<pst_Abonados->CantidadAbonados;k++)
                        if (pst_Abonados->lNumAbonado[k] == stFaDetCons.stDetConsumo[i].lNumAbonado )
                            break;
                    if (pst_Abonados->iIndDetFact[k]==1)
                    {
                        switch (stConceptosTar->iIndTabla[j])
                        {
                            case    iIND_TABLA_INTERZONA_ESPECIAL :
                                if(pst_MascaraOper->iIndInterzona)
                                {
                                    pst_Abonados->iIndInterzona[k]  = iIND_IMPRIME_TRAFICO_SI;
                                }
                                if(pst_MascaraOper->iIndLDI)
                                {
                                    pst_Abonados->iIndLdi[k]  = iIND_IMPRIME_TRAFICO_SI;
                                }
                                if ( pst_MascaraOper->iIndEspeciales)
                                {
                                    pst_Abonados->iIndEspeciales[k] = iIND_IMPRIME_TRAFICO_SI;
                                }

                                break;
                            case    iIND_TABLA_CARRIER :
                                if ( pst_MascaraOper->iIndCarrier)
                                        pst_Abonados->iIndCarrier[k]    = iIND_IMPRIME_TRAFICO_SI;
                                    break;
                            default :
                                break;
                        }
                    }
                }

            }/* For conceptos de tarificacion */
    }/* For conceptos facturados */

    return TRUE;

}/* End bObtieneMascara */

/****************************************************************************/
/* FUNCION     : bfnTrataFactTrafico                                        */
/****************************************************************************/
BOOL bfnTrataFactTrafico ( ST_ABONADO  *pst_Abonados,
                           ST_FACTCLIE *pst_Cliente,
                           FILE        *fArchImp,
                           int         iCont,
                           char        *szBuffer,
                           DETALLEOPER *pstMascaraOper,
                           int         iTasador,
                           long        lCodCiclFact,
                           BOOL        Flag_ExisCarrier)
{
    BOOL  bRes                = TRUE ;
    BOOL  iSqlDeclaraCursores = TRUE ;  
    BOOL  bPrimerAgrupado     = FALSE;
    BOOL  bImprime            = FALSE;    
    char  szBuffer_local        [100];
    int   iImpD1000           = FALSE;
    char  szCodRegistro           [6];       
    int   iCantValor          = 0    ; 
    

    strcpy (szModulo, "bfnTrataFactTrafico");
    
    vDTrazasLog(szModulo,"\n\t Entrada en %s "
                         "\n\t**(bfnTrataFactTrafico) IndOrdenTotal  [%ld]"
                         "\n\t**(bfnTrataFactTrafico) iCont <>-1?    [%d] "
                         ,LOG05,szModulo, pst_Cliente->lIndOrdenTotal, iCont);

    vDTrazasLog  (szModulo, "\n\t** Chequeo Indicadores **"
                            "\n\t========================="
                            "\n\t\t Ind. Local       [%d]"
                            "\n\t\t Ind. Interzona   [%d]"
                            "\n\t\t Ind. Ldi         [%d]"
                            "\n\t\t Ind. Roaming     [%d]"
                            "\n\t\t Ind. Carrier     [%d]"
                            "\n\t\t Ind. Especiales  [%d]"
                            "\n\t\t Ind. LocalDestino[%d]\n"
                          , LOG04
                          , pst_Abonados->iIndLocal[iCont]
                          , pst_Abonados->iIndInterzona[iCont]
                          , pst_Abonados->iIndLdi[iCont]
                          , pst_Abonados->iIndRoaming[iCont]
                          , pst_Abonados->iIndCarrier[iCont]
                          , pst_Abonados->iIndEspeciales[iCont]
                          , pst_Abonados->iIndLocalDestino[iCont]);                     

    if (iCont == -1) 
    {
    	return bRes;
    }
    
    iCantValor = 0;
    bImprime = FALSE;

    vDTrazasLog(szModulo,"\t\t** Evaluando Cod. Tipo Llamada (TOL) **\n", LOG05);	

    if ( pstMascaraOper->iInd_Agrupacion == 0 )
    {
         vDTrazasLog(szModulo,"\t\t Sin Agrupacion\n", LOG05);
            
         if ( bRes  && (pst_Abonados->iIndLocal[iCont] == iIND_IMPRIME_TRAFICO_SI ) )
         {

              vDTrazasLog(szModulo,"\t\t** Llamada función bfnDetLlamCelular (Sin Agrupación) **\n", LOG05);
            	
              bRes = bfnDetLlamCelular( pst_Abonados,
                                        pst_Cliente, 
                                        iCont, 
                                        iTIPLLAMADAS_LOCALES,
                                        fArchImp,
                                        szBuffer,
                                        pstMascaraOper,
                                        &iImpD1000,
                                        iTasador,
                                        lCodCiclFact,
                                        szCodRegistro);
         }
    }
    else
    {
         vDTrazasLog(szModulo,"\t\t** Llamada función bfnDetLlamCelularTOL (Con Agrupación) **\n", LOG05);
             
         bRes = bfnDetLlamCelularTOL( pst_Abonados,
                                      pst_Cliente, 
                                      iCont,
                                      fArchImp,
                                      szBuffer,
                                      &iImpD1000,
                                      pstMascaraOper,
                                      lCodCiclFact);
         bPrimerAgrupado = TRUE;
    }
	
    vDTrazasLog(szModulo,"\t\t** Evaluando Cod. Tipo Llamada (ROA) **\n", LOG05);	
			
    if ( bRes  && (pst_Abonados->iIndRoaming[iCont] == iIND_IMPRIME_TRAFICO_SI ) )
    {                 	
         vDTrazasLog(szModulo,"\t\t** Llamada función bfnDetLlamRoaming **\n", LOG05);
            
         bRes = bfnDetLlamRoaming( pst_Abonados,
                                   pst_Cliente, 
                                   iCont,
                                   iTIPLLAMADAS_ROAMING,
                                   fArchImp,
                                   szBuffer,
                                   &iImpD1000,
                                   iTasador,
                                   lCodCiclFact,
                                   szCodRegistro);
    }

    if ( iImpD1000 )
    {
         sprintf(szBuffer_local,"%5s\n" ,PIE_ABONADO);
         vDTrazasLog(szModulo,"\t\t Impresión Pie Abonado\n", LOG06);
        
         if ( !bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local) )
         {
              vDTrazasLog(szModulo,"\t\t (%s): Error Impresión Pie Abonado\n", LOG05,szModulo);        	
         }
    }

    vFreeEstructuras(&stDetCelular);

    return (bRes);
} /***********************  FIN bfnTrataFactTrafico  *************************/

/****************************************************************************/
/* FUNCION     : put_D1000                                                  */
/****************************************************************************/
int put_D1000(ST_ABONADO *pst_Abonados,FILE *fArchImp, int iCont, char *szBuffer)
{
    char  szBuffer_local[100];
    
    strcpy (szModulo, "put_D1000");
    
    sprintf(szBuffer_local,"%-5s%08ld%-20ld%-20s%-20s%-20s\n"
                          ,COD_ABONADO
                          ,pst_Abonados->lNumAbonado[iCont]
                          ,pst_Abonados->lNumCelular[iCont]
                          ,pst_Abonados->sznom_usuario[iCont]
                          ,pst_Abonados->sznom_apellido1[iCont]
                          ,pst_Abonados->sznom_apellido2[iCont]);

    if (!bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local))
    {
         vDTrazasLog (szModulo,"\n\n (%s): Error al escribir cabecera en el archivo ", LOG04,szModulo);
    }
    
    return (1);
}

/************************************************************************/
/*  FUNCION : ifnOpenDetCarrier                                         */
/************************************************************************/
int ifnOpenDetCarrier( long lCodCliente, 
                       long lNumAbonado,
                       long lNumProceso)
{
    char szCadenaSQL       [25000];
    char szAndCodOperador  [2100];
    char szhBufferCursor  [2100];    
    
    memset(szCadenaSQL,0,sizeof(szCadenaSQL));	
    memset(szAndCodOperador,0,sizeof(szAndCodOperador));    
	
    lhCodCliente = lCodCliente;
    lhNumAbonado = lNumAbonado;
    lhNumProceso = lNumProceso;
    ihTipConce   = iTIPO_CONCEPTO_CARRIER;
    strcpy (szhFormatoFecha,szformato_fecha);
    strcpy (szhFormatoHora,szformato_hora);

    strcpy (szModulo, "ifnOpenDetCarrier");
    vDTrazasLog(szModulo, "\n\t Entrada en %s "
                          "\n\t\t==> Cliente         [%ld]"
                          "\n\t\t==> Abonado         [%ld]"
                          "\n\t\t==> Num.Proceso     [%ld]"
                          "\n\t\t==> szformato_hora  [%s]"
                          "\n\t\t==> ihTipConce      [%d]"
                        , LOG04,szModulo
                        , lCodCliente
                        , lNumAbonado
                        , lNumProceso
                        , szformato_hora
                        , ihTipConce);
                        
    if (strcmp(szhBufferCursor,"NULL")==0)
    {
        strcpy(szAndCodOperador," ");
    }
    else
    {
    	sprintf(szAndCodOperador,"\n AND A.COD_OPERADOR IN (%s) ",szhBufferCursor);
    }
    
    sprintf(szCadenaSQL, "\n SELECT  NVL(A.COD_OPERADOR,:ihDValorCero), "
                             "\n     TO_CHAR(A.FEC_CALL,:szhFormatoFecha), "
                             "\n     TO_CHAR(to_date(A.HORA_CALL,'HH24MISS'),:szformato_hora), "
                             "\n     A.IND_ENTRADA      , "
                             "\n     A.DES_ENTRADA      , "
                             "\n     A.DUR_CALL         , "
                             "\n     A.ACUM_NETOLLAM    , "
                             "\n     A.COD_TRAFICO        "
                         "\n FROM    FA_DETFORTAS   A ,"
                         "\n         FA_ACUMFORTAS  B "
                         "\n WHERE  B.COD_CLIENTE   = :lhCodCliente "
                         "\n AND    B.NUM_ABONADO   = :lhNumAbonado "
                         "\n AND    B.NUM_PROCESO   = :lhNumProceso "
                         "\n AND    B.COD_TIPCONCE  = :ihTipConce "
                         "\n AND    A.COD_CLIENTE   = B.COD_CLIENTE "
                         "\n AND    A.NUM_ABONADO   = B.NUM_ABONADO "
                         "\n AND    A.COD_PERIODO   = B.COD_PERIODO "
                         "\n AND    A.COD_OPERADOR  = B.COD_OPERADOR "
                         "\n AND    A.IND_ALQUILER  = B.IND_ALQUILER "
		         "%s" /* Configuracion del registro D */                         
                         "\n ORDER BY A.COD_OPERADOR,A.COD_TRAFICO,A.FEC_CALL,A.HORA_CALL "
                       , szAndCodOperador);

    vDTrazasLog( szModulo,"=> query Cur_DetCarrier(\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Cur_DetCarrier FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )177;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )25000;
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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE Cur_DetCarrier. Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_DetCarrier CURSOR FOR sql_Cur_DetCarrier; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. Cur_DetCarrier Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }    
    
    /* EXEC SQL OPEN Cur_DetCarrier USING :ihDValorCero, 
                                       :szhFormatoFecha, 
                                       :szformato_hora, 
                                       :lhCodCliente, 
                                       :lhNumAbonado, 
                                       :lhNumProceso, 
                                       :ihTipConce; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )196;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihDValorCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoFecha;
    sqlstm.sqhstl[1] = (unsigned long )22;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szformato_hora;
    sqlstm.sqhstl[2] = (unsigned long )9;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhNumProceso;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihTipConce;
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


    if (SQLCODE != SQLOK) 
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_DetCarrier **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN CURSOR Cur_DetCarrier **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    
    return TRUE;
}/*****************  Final de ifnOpenDetCarrier  ********************/

/************************************************************************/
/*  FUNCION     : ifnFetchDetCarrier                                    */
/*  DESCRIPCION : Realiza FETCH sobre FA_DETFORTAS                      */
/************************************************************************/
int ifnFetchDetCarrier(DETCARRIER * stDetCarrier)
{
    /* EXEC SQL BEGIN DECLARE SECTION ; */ 

         char   szhFecLlamada [11];   /* EXEC SQL VAR szhFecLlamada      IS STRING(11); */ 

         char   szhHraLlamada  [7];   /* EXEC SQL VAR szhHraLlamada      IS STRING(7); */ 

         int    lhCodOperCarr     ;
         char   szhIndEntrada [21];   /* EXEC SQL VAR szhIndEntrada      IS STRING(21); */ 

         char   szhDesEntrada [21];   /* EXEC SQL VAR szhDesEntrada      IS STRING(21); */ 

         long   lhMinTasado       ;
         double dhNeto            ;
         char   szhCodTrafico  [3];   /* EXEC SQL VAR szhCodTrafico      IS STRING(3); */ 

         short  i_hIndEntrada     ;
         short  i_hDesEntrada     ;
         short  i_hMinTasado      ;
         short  i_hdNeto          ;
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "ifnFetchDetCarrier");
    vDTrazasLog(szModulo,"\n\t Entrada en %s ", LOG06,szModulo);

    /* EXEC SQL FETCH Cur_DetCarrier INTO
                :lhCodOperCarr                  ,
                :szhFecLlamada                  ,
                :szhHraLlamada                  ,
                :szhIndEntrada   :i_hIndEntrada ,
                :szhDesEntrada   :i_hDesEntrada ,
                :lhMinTasado     :i_hMinTasado  ,
                :dhNeto          :i_hdNeto      ,
                :szhCodTrafico                  ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )239;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodOperCarr;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecLlamada;
    sqlstm.sqhstl[1] = (unsigned long )11;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhHraLlamada;
    sqlstm.sqhstl[2] = (unsigned long )7;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhIndEntrada;
    sqlstm.sqhstl[3] = (unsigned long )21;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&i_hIndEntrada;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhDesEntrada;
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&i_hDesEntrada;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhMinTasado;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&i_hMinTasado;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&dhNeto;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&i_hdNeto;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodTrafico;
    sqlstm.sqhstl[7] = (unsigned long )3;
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



    if(SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)  {
        vDTrazasLog (szModulo, "\n\t\t Error Oracle : %s - %s", LOG01,"Fetch=> Fa_DetFortas", SQLERRM );
        vDTrazasError(szModulo, "\n\t\t Error Oracle : %s - %s", LOG01,"Fetch=> Fa_DetFortas", SQLERRM );
        return FALSE;
    }

    if (SQLCODE == SQLOK)  {
        stDetCarrier->iCodOperCarr         = lhCodOperCarr       ;
        sprintf(stDetCarrier->szFecLlamada ,"%s\0",szhFecLlamada);
        sprintf(stDetCarrier->szHraLlamada ,"%s\0",szhHraLlamada);
        sprintf(stDetCarrier->szCodTrafico ,"%s\0",szhCodTrafico);

        if (i_hIndEntrada == ORA_NULL)
            memset(stDetCarrier->szNumDestino,0, sizeof(stDetCarrier->szNumDestino));
        else
            strcpy(stDetCarrier->szNumDestino,szhIndEntrada);

        if (i_hDesEntrada == ORA_NULL)
            memset(stDetCarrier->szDesDestino,0, sizeof(stDetCarrier->szDesDestino));
       else
           strcpy(stDetCarrier->szDesDestino,szhDesEntrada);

        if (i_hMinTasado == ORA_NULL )
            stDetCarrier->lSegundos= 0;
        else
            stDetCarrier->lSegundos = (long)(lhMinTasado);

        if (i_hdNeto == ORA_NULL )
            stDetCarrier->dNeto = 0;
        else
            stDetCarrier->dNeto = dhNeto;
    }
    else
        return FALSE;

    return TRUE;
}/****************  Final de ifnFetchDetCarrier    ******************/


/************************************************************************/
/*  FUNCION     : bfnCloseDetCarrier                                    */
/*  DESCRIPCION : Cierra el cursor sobre FA_DETFORTAS                   */
/************************************************************************/
BOOL bfnCloseDetCarrier(void)
{
    strcpy (szModulo, "bfnCloseDetCarrier");
    vDTrazasLog(szModulo,"\n\t Entrada en %s ", LOG04,szModulo);

    /* EXEC SQL CLOSE Cur_DetCarrier ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )286;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE != SQLOK) {
        vDTrazasLog(szModulo, "\n\n\t Error al cerrar el Cursor DetCarrier  : %s", LOG01, SQLERRM);
        vDTrazasError(szModulo, "\n\t\t Error Oracle : %s - %s", LOG01,"Fetch=> Fa_DetFortas", SQLERRM );
        return FALSE;
    }
    return TRUE;
}/***********************  bfnCloseDetCarrier   *********************/

int ManejoArchImp(LINEACOMANDO         *ParEntrada,
                  ST_INFGENERAL        *sthFa_InfGeneral,
                  DETALLEOPER          *stMascaraOper,
                  FILE                 **Fd_ArchImp ,
                  ST_ACUMMTO           *AcumMto,
                  char                 *szNombreArchivo)
{
    char szCodIdioma[6];

    strcpy (szModulo, "ManejoArchImp");
    vDTrazasLog(szModulo,"\n\t** Entrada en %s"
                         "\n\t->iSecuencial [%d]"
                         "\n\t->szPathDir   [%s]"
                         ,LOG04, szModulo, sthFa_InfGeneral->iSecuencial, sthFa_InfGeneral->szPathDir);

   if (sthFa_InfGeneral->iSecuencial == 0 )
   {
        sthFa_InfGeneral->iSecuencial = 1;
        strcpy(szCodIdioma,ParEntrada->szCodIdioma); FillCodIdioma(szCodIdioma);
        if(!ParEntrada->iTipoCiclo)
        {
            sprintf(szNombreArchivo,"%s/ImprScl_%02d_%d_%s_%ld_%s_%s.dat",sthFa_InfGeneral->szPathDir,sthFa_InfGeneral->iSecuencial
                                           ,ParEntrada->iCodTipDocum ,ParEntrada->szCodDespacho, ParEntrada->lCodCiclFact, (strcmp(szgHostId,"-1")==0)?"_":szgHostId
                                           ,ParEntrada->szFechaHoraSis);
        }
        else
        {
            sprintf(szNombreArchivo,"%s/00_%015ld.dat",sthFa_InfGeneral->szPathDir,ParEntrada->lProceso);
        }
        printf("\tManejoArchImp-> entro por 1era vez [%s]\n",szNombreArchivo);
        vDTrazasLog(szModulo,"NMFILE: OPEN1|%d|%d|%s|",LOG06, sthFa_InfGeneral->iContClientesProcesados,sthFa_InfGeneral->iSecuencial,szNombreArchivo);
        if((*Fd_ArchImp = fopen(szNombreArchivo, "w")) == (FILE *)NULL)
        {
            vDTrazasLog(szModulo,"\n\t\tError al abrir archivo-> [%s]\n" ,LOG01,szNombreArchivo);
            vDTrazasError(szModulo,"\n\t\tError al abrir archivo-> [%s]\n" ,LOG01,szNombreArchivo);
            return FALSE;
        }

        return TRUE;
    }

   vDTrazasLog(szModulo,"\t\tsthFa_InfGeneral->iContClientesProcesados [%d]"
                        "\t\tstMascaraOper->iCtesXArchivo [%d]"
                        ,LOG05, sthFa_InfGeneral->iContClientesProcesados, stMascaraOper->iCtesXArchivo);

    if ( sthFa_InfGeneral->iContClientesProcesados >= stMascaraOper->iCtesXArchivo)
    {
    /* Cerrar archivo y crear otro */

        vDTrazasLog(szModulo,"NMFILE: CLOSE|%d|%d|%s|"
                            ,LOG06, sthFa_InfGeneral->iContClientesProcesados,sthFa_InfGeneral->iSecuencial,szNombreArchivo);
        fclose(*Fd_ArchImp);
        if(!ParEntrada->iTipoCiclo)
        {
            if (!bfnInsertar_FadCTLImpres(AcumMto, ParEntrada, sthFa_InfGeneral, szNombreArchivo))
            {
                vDTrazasLog(szModulo,"Error en ejecucion de bfnInsertar_FadCTLImpres ",LOG01);
                return (FALSE);
            }
        }
        sthFa_InfGeneral->iContClientesProcesados = 0;
        sthFa_InfGeneral->iSecuencial++;

        strcpy(szCodIdioma,ParEntrada->szCodIdioma); FillCodIdioma(szCodIdioma);
        if(!ParEntrada->iTipoCiclo)
        {
            sprintf(szNombreArchivo,"%s/ImprScl_%02d_%d_%s_%ld_%s_%s.dat",sthFa_InfGeneral->szPathDir,sthFa_InfGeneral->iSecuencial
                                                             ,ParEntrada->iCodTipDocum,ParEntrada->szCodDespacho, ParEntrada->lCodCiclFact, (strcmp(szgHostId,"-1")==0)?"_":szgHostId
                                                             ,ParEntrada->szFechaHoraSis);
        }
        else
        {
            sprintf(szNombreArchivo,"%s/00_%015ld.dat",sthFa_InfGeneral->szPathDir,ParEntrada->lProceso);
        }
        vDTrazasLog(szModulo,"NMFILE: OPEN2|%d|%d|%s|"
                            ,LOG06, sthFa_InfGeneral->iContClientesProcesados,sthFa_InfGeneral->iSecuencial,szNombreArchivo);
        if( (*Fd_ArchImp = fopen(szNombreArchivo, "w")) == (FILE *)NULL)
        {

            vDTrazasLog(szModulo,  "\n\t\tError al abrir archivo-> [%s]\n",LOG03,szNombreArchivo);
            vDTrazasError(szModulo,"\n\t\tError al abrir archivo-> [%s]\n",LOG03,szNombreArchivo);

            return FALSE;
        }
    }

    return TRUE;
}

/****************************************************************************/
/* FUNCION     : bCargaConceptosTar                                         */
/* DESCRIPCION : Carga tabla TA_CONCEPFACT UNION FA_FACTCARRIERS            */
/****************************************************************************/
BOOL bCargaConceptosTar(CONCEPTOS_TAR *pstConceptos)
{
    int i ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int     ihCodConceptos[MAX_CONCEPTOS_TAR];
         int     ihIndTabla    [MAX_CONCEPTOS_TAR];
    /* EXEC SQL END DECLARE SECTION; */ 


    strcpy (szModulo, "bCargaConceptosTar");

    /* EXEC SQL DECLARE Cursor_Conceptos CURSOR FOR
        SELECT COD_FACTURACION,IND_TABLA
          FROM TA_CONCEPFACT
        UNION
        SELECT COD_CONCFACT, 4
          FROM FA_FACTCARRIERS; */ 


    if (SQLCODE != SQLOK )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-DECLARE Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-DECLARE Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL OPEN Cursor_Conceptos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0004;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )301;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH Cursor_Conceptos INTO :ihCodConceptos,:ihIndTabla; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )100;
    sqlstm.offset = (unsigned int  )316;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)ihCodConceptos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)ihIndTabla;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-FETCH Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-FETCH Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    pstConceptos->iNumConceptos = sqlca.sqlerrd[2];

    for(i=0;i < pstConceptos->iNumConceptos;i++)
    {
        pstConceptos->iCodConcepto[i] = ihCodConceptos[i];
        pstConceptos->iIndTabla   [i] = ihIndTabla    [i];
    }

    /* EXEC SQL CLOSE Cursor_Conceptos; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )339;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-CLOSE Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-CLOSE Cursor_Conceptos **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    return TRUE;

}

/**************************************************************************************/
/* FUNCION     : bCargaMascaraOperadora                                               */
/* DESCRIPCION : Obtiene Mascara de impresion de detalle de llamados por Operadora    */
/**************************************************************************************/
BOOL bCargaMascaraOperadora(DETALLEOPER *pst_MascaraOper,int iTipDoc)
{
    int  i                 ;
    int  iTotal            ;
    int  iExisteMascara = 0;

    strcpy (szModulo, "bCargaMascaraOperadora");
    vDTrazasLog  (szModulo,"\n\t** Entrando a %s **" ,LOG04,szModulo);

    sprintf(pst_MascaraOper->szWhere_Local,"%*.*s\0",sthFadParametros.val_numerico[COD_MASK_WHERE_LOCALES],
    sthFadParametros.val_numerico[COD_MASK_WHERE_LOCALES],sthFadParametros.val_caracter[COD_MASK_WHERE_LOCALES]);

    sprintf(pst_MascaraOper->szWhere_Interzona,"%*.*s\0",sthFadParametros.val_numerico[COD_MASK_WHERE_INTERZONA],
    sthFadParametros.val_numerico[COD_MASK_WHERE_INTERZONA],sthFadParametros.val_caracter[COD_MASK_WHERE_INTERZONA]);

    sprintf(pst_MascaraOper->szWhere_LDI,"%*.*s\0",sthFadParametros.val_numerico[COD_MASK_WHERE_LDI],
    sthFadParametros.val_numerico[COD_MASK_WHERE_LDI],sthFadParametros.val_caracter[COD_MASK_WHERE_LDI]);

    sprintf(pst_MascaraOper->szWhere_Especiales,"%*.*s\0",sthFadParametros.val_numerico[COD_MASK_WHERE_ESPECIALES],
    sthFadParametros.val_numerico[COD_MASK_WHERE_ESPECIALES],sthFadParametros.val_caracter[COD_MASK_WHERE_ESPECIALES]);

    sprintf(pst_MascaraOper->szWhere_Especiales_data,"%*.*s\0",sthFadParametros.val_numerico[COD_MASK_WHERE_ESPECIALESDATA],
    sthFadParametros.val_numerico[COD_MASK_WHERE_ESPECIALESDATA],sthFadParametros.val_caracter[COD_MASK_WHERE_ESPECIALESDATA]);

    sprintf(pst_MascaraOper->szIndFacturado,"%1.1s\0", sthFadParametros.val_caracter[COD_MASK_INDFACTURADO]);

    sprintf(pst_MascaraOper->szServicio,"%-3.3s\0", sthFadParametros.val_caracter[COD_MASK_SERVICIO]);

    pst_MascaraOper->iCodFormulario = sthFadParametros.val_numerico[COD_MASK_FORMULARIO];

    pst_MascaraOper->iCtesXArchivo  = sthFadParametros.val_numerico[COD_MASK_CLIENTESXFILE];

    pst_MascaraOper->iIndLocal      = sthFadParametros.val_numerico[COD_MASK_LOCAL];

    pst_MascaraOper->iIndEspeciales = sthFadParametros.val_numerico[COD_MASK_ESPECIALES];

    pst_MascaraOper->iIndInterzona  = sthFadParametros.val_numerico[COD_MASK_INTERZONA];

    pst_MascaraOper->iIndRoaming    = sthFadParametros.val_numerico[COD_MASK_ROAMING];

    pst_MascaraOper->iIndCarrier    = sthFadParametros.val_numerico[COD_MASK_CARRIER];

    pst_MascaraOper->iIndLDI        = sthFadParametros.val_numerico[COD_MASK_LDI];

    pst_MascaraOper->iInd_Agrupacion = sthFadParametros.val_numerico[COD_MASK_INDAGRUPACION];

    vDTrazasLog  (szModulo,"\n\t\t MascaraOperadora where:\n"
                                  "\n\t\t Locales          [%s]"
                                  "\n\t\t Interzona        [%s]"
                                  "\n\t\t Ldi              [%s]"
                                  "\n\t\t Especiales       [%s]"
                                  "\n\t\t Data             [%s]"
                                  ,LOG04
                                  ,pst_MascaraOper->szWhere_Local
                                  ,pst_MascaraOper->szWhere_Interzona
                                  ,pst_MascaraOper->szWhere_LDI
                                  ,pst_MascaraOper->szWhere_Especiales
                                  ,pst_MascaraOper->szWhere_Especiales_data);

    ihCodTipDocum = iTipDoc;

    vDTrazasLog  (szModulo,"\n\t\t Tipo Documento [%d]\n",LOG05,ihCodTipDocum);

    /* EXEC SQL OPEN cRegImpre ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0001;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )354;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipDocum;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



    if (SQLCODE != SQLOK )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN cRegImpre **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN cRegImpre **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }

    /* EXEC SQL FETCH cRegImpre INTO
                :pst_MascaraOper->szCodRegistro,
                :pst_MascaraOper->iIndImp,
                :pst_MascaraOper->iCod_tipdocum; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )600;
    sqlstm.offset = (unsigned int  )373;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pst_MascaraOper->szCodRegistro);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pst_MascaraOper->iIndImp);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pst_MascaraOper->iCod_tipdocum);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND )
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-FETCH cRegImpre **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-FETCH cRegImpre **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (FALSE);
    }
    iTotal =  sqlca.sqlerrd[2];

    /* EXEC SQL CLOSE cRegImpre ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )400;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    pst_MascaraOper->iCantRegistros = iTotal;

    vDTrazasLog  (szModulo,"\n\t\t MascaraOperadora:\n"
                                  "\n\t\t Formulario        [%d]"
                                  "\n\t\t ClientesXArchivo  [%d]"
                                  "\n\t\t IndFacturado      [%s]"
                                  "\n\t\t iIndLocal         [%d]"
                                  "\n\t\t iIndInterzona     [%d]"
                                  "\n\t\t iIndRoaming       [%d]"
                                  "\n\t\t iIndCarrier       [%d]"
                                  "\n\t\t iIndEspeciales    [%d]"
                                  "\n\t\t iIndLDI           [%d]"
                                  "\n\t\t iTipdoc           [%d]"
                                  "\n\t\t Cant. Registros   [%d]"
                                  ,LOG04
                                  ,pst_MascaraOper->iCodFormulario
                                  ,pst_MascaraOper->iCtesXArchivo
                                  ,pst_MascaraOper->szIndFacturado
                                  ,pst_MascaraOper->iIndLocal
                                  ,pst_MascaraOper->iIndInterzona
                                  ,pst_MascaraOper->iIndRoaming
                                  ,pst_MascaraOper->iIndCarrier
                                  ,pst_MascaraOper->iIndEspeciales
                                  ,pst_MascaraOper->iIndLDI
                                  ,iTipDoc
                                  ,pst_MascaraOper->iCantRegistros);

    for ( i=0; i < iTotal ; i++ )
    {
        vDTrazasLog  (szModulo,"\t\t MascaraOperadora: [%d] [%s]",LOG04,pst_MascaraOper->iIndImp[i],pst_MascaraOper->szCodRegistro[i]);
        iExisteMascara+=(int)pst_MascaraOper->iIndImp;
    }
    if(!iExisteMascara)
    {
        vDTrazasLog  (szModulo,"\t\t MascaraOperadora: No Configurada",LOG01);
        return (FALSE);
    }
    return TRUE;

}/* bCargaMascaraOperadora */

/****************************************************************************************/
/* FUNCION : ifnOraDeclaraTraficoTolTarifica                                            */
/****************************************************************************************/
extern int  ifnOraDeclaraTraficoTolTarifica (long lCodCliente, 
                                             long lNumAbonado, 
                                             long lCodCiclFact)
{
    char  szCadenaSQL [25000]="";
    long lhCodCiclFact;
    
    strcpy (szModulo, "ifnOraDeclaraTraficoTolTarifica");
    
    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
        
    strcpy (szhFormatoFecha,szformato_fecha);
    strcpy (szhFormatoHora,szformato_hora);
    lhCodCliente = lCodCliente;
    lhNumAbonado = lNumAbonado;
    lhCodCiclFact = lCodCiclFact;    

    vDTrazasLog  (szModulo, "\t\t Entrando en %s "
                            "\t\t\t szhFormatoFecha     [%s]"
                            "\t\t\t szhFormatoHora      [%s]"
                            "\t\t\t lhCodCliente        [%ld]"
                            "\t\t\t lhNumAbonado        [%ld]"
                            "\t\t\t lhCodCiclFact       [%ld]"                            
                          , LOG05
                          , szModulo
                          , szhFormatoFecha
                          , szhFormatoHora
                          , lhCodCliente
                          , lhNumAbonado
                          , lhCodCiclFact);                                                  
    
    sprintf(szCadenaSQL, "\n SELECT  SEC_EMPA, "
                                "\n SEC_CDR, "
                                "\n MAX(TO_CHAR(TO_DATE(DATE_START_CHARG || TIME_START_CHARG, 'YYYYMMDDHH24MISS'), :szhFormatoFecha)), "
                                "\n MAX(TO_CHAR(TO_DATE(TIME_START_CHARG,'HH24MISS'), :szhFormatoHora)), "
                                "\n MAX(A_SUSC_NUMBER), "
                                "\n MAX(B_SUSC_NUMBER), "
                                "\n SUM(DECODE(ind_billete,'01',MTO_FACT,0)), "
                                "\n SUM(DECODE(ind_billete,'02',MTO_FACT,0)), "
                                "\n MAX(COD_THOR), "
                                "\n MAX(COD_ALMA), "
                                "\n MAX(DES_DESTINO), "
                                "\n MAX(DECODE(ind_billete,'01',TO_CHAR(DUR_FACT),'0')), "
                                "\n MAX(DECODE(ind_billete,'02',TO_CHAR(DUR_FACT),'0')), "
                                "\n MAX(COD_SENT), "
                                "\n SUM(MTO_REAL), "
                                "\n SUM(MTO_DCTO), "
                                "\n SUM(DUR_REAL), "
                                "\n SUM(DUR_DCTO), "
                                "\n COD_CARG     , "
                                "\n A.COD_FCOB   , "
                                "\n 0            , "
                                "\n 0            , "
                                "\n SUM(NVL(A.NUM_PULSO,0)) , "
                                "\n NVL(MAX(A.RECORD_TYPE),' '), "
                                "\n NVL(MAX(A.COD_DCTO),' '), "
                                "\n NVL(MAX(A.TIP_DCTO),' '), "
                                "\n SUM(NVL(A.VALOR_UNIDAD,0)), "
                                "\n NVL(MAX(A.DES_LLAMADA),'.') "
                         "\n FROM  PF_TOLTARIFICA_%ld A "
                         "\n WHERE  A.NUM_CLIE = :lhCodCliente "
                         "\n  AND  A.NUM_ABON = :lhNumAbonado "
                         "\n  AND  A.COD_TCOR <> 'VE' "
                         "\n GROUP BY SEC_EMPA,SEC_CDR,COD_CARG, A.COD_FCOB "
                       , lhCodCiclFact);

    vDTrazasLog( szModulo,"=> query Cur_TolTarifica(\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Cur_TolTarifica FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )415;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )25000;
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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE Cur_TolTarifica. Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_TolTarifica CURSOR FOR sql_Cur_TolTarifica; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. Cur_TolTarifica Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }                            


    /* EXEC SQL OPEN Cur_TolTarifica USING :szhFormatoFecha, :szhFormatoHora, :lhCodCliente, :lhNumAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )434;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
    sqlstm.sqhstl[0] = (unsigned long )22;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoHora;
    sqlstm.sqhstl[1] = (unsigned long )9;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
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



    return sqlca.sqlcode;
}

/************************************************************************************/
/* FUNCION : ifnOraDeclaraLlamCarrier                                               */
/************************************************************************************/
extern int  ifnOraDeclaraLlamCarrier( long lCodCliente, 
                                      long lNumAbonado, 
                                      long lCodCiclFact)
{
    char szCadenaSQL      [25000];
    char szAndCodOperador [2100];
    char szhBufferCursor  [2100];    
    long lhCodCiclFact    ;
        
    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    memset(szAndCodOperador,0,sizeof(szAndCodOperador));
    
    strcpy (szhFormatoFecha,szformato_fecha);
    strcpy (szhFormatoHora,szformato_hora);
    
    lhCodCliente  = lCodCliente;
    lhNumAbonado  = lNumAbonado;
    lhCodCiclFact = lCodCiclFact;    

    vDTrazasLog  (szModulo, "\t\t Entrando en %s "
                            "\n\t\t\t szhFormatoFecha      [%s]"
                            "\n\t\t\t szhFormatoHora       [%s]"
                            "\n\t\t\t lhCodCliente        [%ld]"
                            "\n\t\t\t lhNumAbonado        [%ld]"
                            "\n\t\t\t lhCodCiclFact       [%ld]"                            
                            "\n\t\t\t szhBufferCursor      [%s]"
                          , LOG05
                          , szModulo
                          , szhFormatoFecha
                          , szhFormatoHora
                          , lhCodCliente
                          , lhNumAbonado
                          , lCodCiclFact
                          , szhBufferCursor);
                            
    if (strcmp(szhBufferCursor,"NULL")==0)
    {
      	strcpy(szAndCodOperador," ");
    }
    else
    {
    	sprintf(szAndCodOperador,"\n AND A.COD_OPERADOR IN (%s) ",szhBufferCursor);                            
    }

    sprintf(szCadenaSQL,"\nSELECT  SEC_EMPA, "
                               "\n SEC_CDR, "
                               "\n MAX(TO_CHAR(TO_DATE(DATE_START_CHARG || TIME_START_CHARG, 'YYYYMMDDHH24MISS'), :szhFormatoFecha)), "
                               "\n MAX(TO_CHAR(TO_DATE(TIME_START_CHARG,'HH24MISS'), :szhFormatoHora)), "
                               "\n MAX(A_SUSC_NUMBER), "
                               "\n MAX(B_SUSC_NUMBER), "
                               "\n SUM(DECODE(ind_billete,'01',MTO_FACT,0)), "
                               "\n SUM(DECODE(ind_billete,'02',MTO_FACT,0)), "
                               "\n MAX(COD_THOR), "
                               "\n MAX(COD_ALMA), "
                               "\n MAX(DES_DESTINO), "
                               "\n MAX(DECODE(ind_billete,'01',TO_CHAR(DUR_FACT),'0')), "
                               "\n MAX(DECODE(ind_billete,'02',TO_CHAR(DUR_FACT),'0')), "
                               "\n MAX(COD_SENT), "
                               "\n SUM(MTO_REAL), "
                               "\n SUM(MTO_DCTO), "
                               "\n SUM(DUR_REAL), "
                               "\n SUM(DUR_DCTO), "
                               "\n COD_CARG     , "
                               "\n A.COD_FCOB   , "
                               "\n 0       , "
                               "\n NVL(B.COD_CONCCARRIER,0), "
                               "\n SUBSTR(A.COD_LLAM,0,3), "
                               "\n SUM(NVL(A.NUM_PULSO,0)), "
                               "\n NVL(MAX(A.RECORD_TYPE),' '), "
                               "\n NVL(MAX(A.COD_DCTO),' '), "
                               "\n NVL(MAX(A.TIP_DCTO),' '), "
                               "\n SUM(NVL(A.VALOR_UNIDAD,0)), "
                               "\n NVL(MAX(A.DES_LLAMADA),'.') "
                         "\n FROM  PF_TOLTARIFICA_%ld A, FA_FACTCARRIERS B  "
                         "\n WHERE  A.NUM_CLIE = :lhCodCliente "
                          "\n AND  A.NUM_ABON = :lhNumAbonado "
                          "\n AND  A.COD_TCOR <> 'VE' "
                          "\n AND  B.COD_CONCFACT = A.COD_CARG "
                        "%s" /* Configuracion Registros Tipo D */ /* P-MIX-09003 */
                        "\n GROUP BY SEC_EMPA,SEC_CDR,COD_CARG, A.COD_FCOB,B.COD_CONCCARRIER,A.COD_LLAM "
                        "\n ORDER BY MAX(DATE_START_CHARG||TIME_START_CHARG) "
                    , lhCodCiclFact, szAndCodOperador);

    vDTrazasLog( szModulo,"=> query Cur_LlamCarrier(\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Cur_LlamCarrier FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )465;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )25000;
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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE Cur_LlamCarrier. Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_LlamCarrier CURSOR FOR sql_Cur_LlamCarrier; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. Cur_LlamCarrier Error [%d][%s]"
                             ,LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    
    /* EXEC SQL OPEN Cur_LlamCarrier USING :szhFormatoFecha, :szhFormatoHora, :lhCodCliente, :lhNumAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 23;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )484;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
    sqlstm.sqhstl[0] = (unsigned long )22;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoHora;
    sqlstm.sqhstl[1] = (unsigned long )9;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhNumAbonado;
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



    return sqlca.sqlcode;
}

/**************************************************************************************/
/* FUNCION     : ifnOraLeerTolTarifica                                                */
/* DESCRIPCION : Leer Cursor Cur_TolTarifica                                          */
/**************************************************************************************/
extern int  ifnOraLeerTolTarifica (DETLLAMADAS_HOSTS  *pstLlamadasHost, int * piNumFilas)
{
    /* EXEC SQL FETCH Cur_TolTarifica
        INTO
        :pstLlamadasHost->szSec_Empa        ,
        :pstLlamadasHost->szSec_Cdr         ,
        :pstLlamadasHost->szFecIniTasa      ,
        :pstLlamadasHost->szTieIniLlam      ,
        :pstLlamadasHost->szNumMovil1       ,
        :pstLlamadasHost->szNumMovil2       ,
        :pstLlamadasHost->dImpLocal1        ,
        :pstLlamadasHost->dImpLarga2        ,
        :pstLlamadasHost->szCodFranHoraSoc  ,
        :pstLlamadasHost->szCodAlm          ,
        :pstLlamadasHost->szDesMovil2       ,
        :pstLlamadasHost->szDurLocal1       ,
        :pstLlamadasHost->szDurLarga2       ,
        :pstLlamadasHost->szIndEntSal1      ,
        :pstLlamadasHost->dMto_Real         ,
        :pstLlamadasHost->dMto_Dcto         ,
        :pstLlamadasHost->iDur_Real         ,
        :pstLlamadasHost->iDur_Dcto         ,
        :pstLlamadasHost->iCod_Carg         ,
        :pstLlamadasHost->szCodFCob         ,
        :pstLlamadasHost->dValorUndad       ,
        :pstLlamadasHost->lCodConcCarrier   ,
        :pstLlamadasHost->lNumPulsos        ,
        :pstLlamadasHost->szRecordType      ,
        :pstLlamadasHost->szCodDcto         ,
        :pstLlamadasHost->szTipDcto         ,
        :pstLlamadasHost->dValorUnidad      ,
        :pstLlamadasHost->szDesLlamada      ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 28;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )515;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstLlamadasHost->szSec_Empa);
    sqlstm.sqhstl[0] = (unsigned long )30;
    sqlstm.sqhsts[0] = (         int  )30;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstLlamadasHost->szSec_Cdr);
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstLlamadasHost->szFecIniTasa);
    sqlstm.sqhstl[2] = (unsigned long )16;
    sqlstm.sqhsts[2] = (         int  )16;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstLlamadasHost->szTieIniLlam);
    sqlstm.sqhstl[3] = (unsigned long )7;
    sqlstm.sqhsts[3] = (         int  )7;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstLlamadasHost->szNumMovil1);
    sqlstm.sqhstl[4] = (unsigned long )20;
    sqlstm.sqhsts[4] = (         int  )20;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstLlamadasHost->szNumMovil2);
    sqlstm.sqhstl[5] = (unsigned long )20;
    sqlstm.sqhsts[5] = (         int  )20;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstLlamadasHost->dImpLocal1);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )sizeof(double);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstLlamadasHost->dImpLarga2);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstLlamadasHost->szCodFranHoraSoc);
    sqlstm.sqhstl[8] = (unsigned long )6;
    sqlstm.sqhsts[8] = (         int  )6;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstLlamadasHost->szCodAlm);
    sqlstm.sqhstl[9] = (unsigned long )4;
    sqlstm.sqhsts[9] = (         int  )4;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstLlamadasHost->szDesMovil2);
    sqlstm.sqhstl[10] = (unsigned long )31;
    sqlstm.sqhsts[10] = (         int  )31;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstLlamadasHost->szDurLocal1);
    sqlstm.sqhstl[11] = (unsigned long )7;
    sqlstm.sqhsts[11] = (         int  )7;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(pstLlamadasHost->szDurLarga2);
    sqlstm.sqhstl[12] = (unsigned long )7;
    sqlstm.sqhsts[12] = (         int  )7;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(pstLlamadasHost->szIndEntSal1);
    sqlstm.sqhstl[13] = (unsigned long )6;
    sqlstm.sqhsts[13] = (         int  )6;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)(pstLlamadasHost->dMto_Real);
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )sizeof(double);
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)(pstLlamadasHost->dMto_Dcto);
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )sizeof(double);
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)(pstLlamadasHost->iDur_Real);
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )sizeof(int);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)(pstLlamadasHost->iDur_Dcto);
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )sizeof(int);
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqharc[17] = (unsigned long  *)0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)(pstLlamadasHost->iCod_Carg);
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )sizeof(int);
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqharc[18] = (unsigned long  *)0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)(pstLlamadasHost->szCodFCob);
    sqlstm.sqhstl[19] = (unsigned long )6;
    sqlstm.sqhsts[19] = (         int  )6;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqharc[19] = (unsigned long  *)0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)(pstLlamadasHost->dValorUndad);
    sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[20] = (         int  )sizeof(double);
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqharc[20] = (unsigned long  *)0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)(pstLlamadasHost->lCodConcCarrier);
    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[21] = (         int  )sizeof(long);
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqharc[21] = (unsigned long  *)0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)(pstLlamadasHost->lNumPulsos);
    sqlstm.sqhstl[22] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[22] = (         int  )sizeof(long);
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqharc[22] = (unsigned long  *)0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)(pstLlamadasHost->szRecordType);
    sqlstm.sqhstl[23] = (unsigned long )3;
    sqlstm.sqhsts[23] = (         int  )3;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqharc[23] = (unsigned long  *)0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)(pstLlamadasHost->szCodDcto);
    sqlstm.sqhstl[24] = (unsigned long )6;
    sqlstm.sqhsts[24] = (         int  )6;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqharc[24] = (unsigned long  *)0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)(pstLlamadasHost->szTipDcto);
    sqlstm.sqhstl[25] = (unsigned long )6;
    sqlstm.sqhsts[25] = (         int  )6;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqharc[25] = (unsigned long  *)0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)(pstLlamadasHost->dValorUnidad);
    sqlstm.sqhstl[26] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[26] = (         int  )sizeof(double);
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqharc[26] = (unsigned long  *)0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)(pstLlamadasHost->szDesLlamada);
    sqlstm.sqhstl[27] = (unsigned long )101;
    sqlstm.sqhsts[27] = (         int  )101;
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqharc[27] = (unsigned long  *)0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
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

 /* P-MIX-09003 */


    if (SQLCODE == SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE == SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

    return sqlca.sqlcode;
}

/******************************************************************************************/
/* FUNCION     : ifnOraLeerLlamCarrier                                                    */
/* DESCRIPCION : Lee Cursor Cur_LlamCarrier                                               */
/******************************************************************************************/
extern int  ifnOraLeerLlamCarrier (DETLLAMADAS_HOSTS  *pstLlamadasHost, long * piNumFilas)
{
    /* EXEC SQL FETCH Cur_LlamCarrier
        INTO
        :pstLlamadasHost->szSec_Empa        ,
        :pstLlamadasHost->szSec_Cdr         ,
        :pstLlamadasHost->szFecIniTasa      ,
        :pstLlamadasHost->szTieIniLlam      ,
        :pstLlamadasHost->szNumMovil1       ,
        :pstLlamadasHost->szNumMovil2       ,
        :pstLlamadasHost->dImpLocal1        ,
        :pstLlamadasHost->dImpLarga2        ,
        :pstLlamadasHost->szCodFranHoraSoc  ,
        :pstLlamadasHost->szCodAlm          ,
        :pstLlamadasHost->szDesMovil2       ,
        :pstLlamadasHost->szDurLocal1       ,
        :pstLlamadasHost->szDurLarga2       ,
        :pstLlamadasHost->szIndEntSal1      ,
        :pstLlamadasHost->dMto_Real         ,
        :pstLlamadasHost->dMto_Dcto         ,
        :pstLlamadasHost->iDur_Real         ,
        :pstLlamadasHost->iDur_Dcto         ,
        :pstLlamadasHost->iCod_Carg         ,
        :pstLlamadasHost->szCodFCob         ,
        :pstLlamadasHost->dValorUndad       ,
        :pstLlamadasHost->lCodConcCarrier   ,
        :pstLlamadasHost->szCodLlam         ,
        :pstLlamadasHost->lNumPulsos        ,
        :pstLlamadasHost->szRecordType      ,
        :pstLlamadasHost->szCodDcto         ,
        :pstLlamadasHost->szTipDcto         ,
        :pstLlamadasHost->dValorUnidad      ,
        :pstLlamadasHost->szDesLlamada      ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )642;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstLlamadasHost->szSec_Empa);
    sqlstm.sqhstl[0] = (unsigned long )30;
    sqlstm.sqhsts[0] = (         int  )30;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstLlamadasHost->szSec_Cdr);
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )6;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstLlamadasHost->szFecIniTasa);
    sqlstm.sqhstl[2] = (unsigned long )16;
    sqlstm.sqhsts[2] = (         int  )16;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstLlamadasHost->szTieIniLlam);
    sqlstm.sqhstl[3] = (unsigned long )7;
    sqlstm.sqhsts[3] = (         int  )7;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstLlamadasHost->szNumMovil1);
    sqlstm.sqhstl[4] = (unsigned long )20;
    sqlstm.sqhsts[4] = (         int  )20;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstLlamadasHost->szNumMovil2);
    sqlstm.sqhstl[5] = (unsigned long )20;
    sqlstm.sqhsts[5] = (         int  )20;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstLlamadasHost->dImpLocal1);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[6] = (         int  )sizeof(double);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstLlamadasHost->dImpLarga2);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstLlamadasHost->szCodFranHoraSoc);
    sqlstm.sqhstl[8] = (unsigned long )6;
    sqlstm.sqhsts[8] = (         int  )6;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstLlamadasHost->szCodAlm);
    sqlstm.sqhstl[9] = (unsigned long )4;
    sqlstm.sqhsts[9] = (         int  )4;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstLlamadasHost->szDesMovil2);
    sqlstm.sqhstl[10] = (unsigned long )31;
    sqlstm.sqhsts[10] = (         int  )31;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstLlamadasHost->szDurLocal1);
    sqlstm.sqhstl[11] = (unsigned long )7;
    sqlstm.sqhsts[11] = (         int  )7;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(pstLlamadasHost->szDurLarga2);
    sqlstm.sqhstl[12] = (unsigned long )7;
    sqlstm.sqhsts[12] = (         int  )7;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(pstLlamadasHost->szIndEntSal1);
    sqlstm.sqhstl[13] = (unsigned long )6;
    sqlstm.sqhsts[13] = (         int  )6;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)(pstLlamadasHost->dMto_Real);
    sqlstm.sqhstl[14] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[14] = (         int  )sizeof(double);
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)(pstLlamadasHost->dMto_Dcto);
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )sizeof(double);
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)(pstLlamadasHost->iDur_Real);
    sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[16] = (         int  )sizeof(int);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)(pstLlamadasHost->iDur_Dcto);
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )sizeof(int);
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqharc[17] = (unsigned long  *)0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)(pstLlamadasHost->iCod_Carg);
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )sizeof(int);
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqharc[18] = (unsigned long  *)0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)(pstLlamadasHost->szCodFCob);
    sqlstm.sqhstl[19] = (unsigned long )6;
    sqlstm.sqhsts[19] = (         int  )6;
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqharc[19] = (unsigned long  *)0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)(pstLlamadasHost->dValorUndad);
    sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[20] = (         int  )sizeof(double);
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqharc[20] = (unsigned long  *)0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)(pstLlamadasHost->lCodConcCarrier);
    sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[21] = (         int  )sizeof(long);
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqharc[21] = (unsigned long  *)0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)(pstLlamadasHost->szCodLlam);
    sqlstm.sqhstl[22] = (unsigned long )4;
    sqlstm.sqhsts[22] = (         int  )4;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqharc[22] = (unsigned long  *)0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)(pstLlamadasHost->lNumPulsos);
    sqlstm.sqhstl[23] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[23] = (         int  )sizeof(long);
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqharc[23] = (unsigned long  *)0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)(pstLlamadasHost->szRecordType);
    sqlstm.sqhstl[24] = (unsigned long )3;
    sqlstm.sqhsts[24] = (         int  )3;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqharc[24] = (unsigned long  *)0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)(pstLlamadasHost->szCodDcto);
    sqlstm.sqhstl[25] = (unsigned long )6;
    sqlstm.sqhsts[25] = (         int  )6;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqharc[25] = (unsigned long  *)0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)(pstLlamadasHost->szTipDcto);
    sqlstm.sqhstl[26] = (unsigned long )6;
    sqlstm.sqhsts[26] = (         int  )6;
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqharc[26] = (unsigned long  *)0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)(pstLlamadasHost->dValorUnidad);
    sqlstm.sqhstl[27] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[27] = (         int  )sizeof(double);
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqharc[27] = (unsigned long  *)0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)(pstLlamadasHost->szDesLlamada);
    sqlstm.sqhstl[28] = (unsigned long )101;
    sqlstm.sqhsts[28] = (         int  )101;
    sqlstm.sqindv[28] = (         short *)0;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqharc[28] = (unsigned long  *)0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
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

 /* P-MIX-09003 */

    if (SQLCODE == SQLOK)
        *piNumFilas = TAM_HOSTS_PEQ;
    else
        if (SQLCODE == SQLNOTFOUND)
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

    return sqlca.sqlcode;
}

/******************************************************************************************/
/* FUNCION     : bfnDeterminaGrupo                                                        */
/******************************************************************************************/
extern BOOL bfnDeterminaGrupo( int iCodCargoHost,  DETCELULAR * pstDetCelular, 
                               long *lPosicion, NUMORDEN *pstNumOrden)
{
    register int j;

    if (BuscaNumOrden (iCodCargoHost,pstNumOrden ))
    {
        if (pstDetCelular->iCantEstructuras == 0)
        {
            *lPosicion = 0;
            return (FALSE);
        }

        for (j=0; j < pstDetCelular->iCantEstructuras; j++)
        {

            if (    (pstDetCelular->stAgrupacion[j].iNum_OrdenGr    == pstNumOrden->iNum_OrdenGr) &&
                    (pstDetCelular->stAgrupacion[j].iNum_OrdenSubGr == pstNumOrden->iNum_OrdenSubGr) &&
                    (pstDetCelular->stAgrupacion[j].iCodGrupo       == pstNumOrden->iCodGrupo      ) &&
                    (pstDetCelular->stAgrupacion[j].iCodSubGrupo    == pstNumOrden->iCodSubGrupo   ))
            {
                *lPosicion = j;

                return (TRUE);
            }
        }

        return (FALSE);
    }


    vDTrazasLog  ("bfnDeterminaGrupo","\n\t** Indica que no existe el Grupo/Subgrupo al que se hace referencia ** "
                                     , LOG01);
    return (FALSE);
}

/******************************************************************************************/
/* FUNCION     : bfnDeterminaGrupo                                                        */
/* DESCRIPCION : Cierra Cursor Cur_TolTarifica                                            */
/******************************************************************************************/
int ifnOraCerrarTraficoTolTarifica ()
{
    /* EXEC SQL CLOSE Cur_TolTarifica; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )773;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    return sqlca.sqlcode;

}

/**************************************************************************************/
/* FUNCION     : ifnOraCerrarTraficoLlamCarrier                                       */
/* DESCRIPCION : Cierra Cursor Cur_LlamCarrier                                        */
/**************************************************************************************/
int ifnOraCerrarTraficoLlamCarrier ()
{
    /* EXEC SQL CLOSE Cur_LlamCarrier; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )788;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    return sqlca.sqlcode;

}

/**************************************************************************************/
/* FUNCION     : bfnOrdenaEstructuras                                                 */
/* DESCRIPCION : Ordena Estructuras                                                   */
/**************************************************************************************/
BOOL bfnOrdenaEstructuras (DETCELULAR * pstDetCelular)
{
    int i;

    for(i=0; i < pstDetCelular->iCantEstructuras; i++)
    {
        vDTrazasLog  ("OrdenaEstructura","\t\t pstDetCelular->stAgrupacion[%i].iCriterio    [%i]",LOG01, i, pstDetCelular->stAgrupacion[i].iCriterio);
        switch(pstDetCelular->stAgrupacion[i].iCriterio)
        {
            case 0: /*Criterio de ordenamieto por default: DATE_START_CHARG||TIME_START_CHARG */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareDefault);
                break;
            case 1: /*Criterio de Ordenamiento : Campo szSec_Empa   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszSec_Empa);
                break;
            case 2: /*Criterio de Ordenamiento : Campo szSec_Cdr    */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszSec_Cdr);
                break;
            case 3: /*Criterio de Ordenamiento : Campo szFecIniTasa */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareDefault);
                break;
            case 4: /*Criterio de Ordenamiento : Campo szTieIniLlam */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszTieIniLlam);
                break;
            case 5: /*Criterio de Ordenamiento : Campo szNumMovil1  */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszNumMovil1);
                break;
            case 6: /*Criterio de Ordenamiento : Campo szNumMovil2  */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszNumMovil2);
                break;
            case 7: /*Criterio de Ordenamiento : Campo dImpLocal1   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnComparedImpLocal1);
                break;
            case 8: /*Criterio de Ordenamiento : Campo dImpLarga2   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnComparedImpLarga2);
                break;
            case 9: /*Criterio de Ordenamiento : Campo szCodFranHoraSoc */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszCodFranHoraSoc);
                break;
            case 10: /*Criterio de Ordenamiento : Campo szCodAlm    */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszCodAlm);
                break;
            case 11: /*Criterio de Ordenamiento : Campo szDesMovil2 */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszDesMovil2);
                break;
            case 12: /*Criterio de Ordenamiento : Campo szDurLocal1 */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszDurLocal1);
                break;
            case 13: /*Criterio de Ordenamiento : Campo szDurLarga2 */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszDurLarga2);
                break;
            case 14: /*Criterio de Ordenamiento : Campo szIndEntSal1*/
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareszIndEntSal1);
                break;
            case 15: /*Criterio de Ordenamiento : Campo dMto_Real   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnComparedMto_Real);
                break;
            case 16: /*Criterio de Ordenamiento : Campo dMto_Dcto   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnComparedMto_Dcto);
                break;
            case 17: /*Criterio de Ordenamiento : Campo iDur_Real   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareiDur_Real);
                break;
            case 18: /*Criterio de Ordenamiento : Campo iDur_Dcto   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareiDur_Dcto);
                break;
            case 19: /*Criterio de Ordenamiento : Campo iCod_Carg   */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareiCod_Carg);
                break;
            default: /*Criterio de ordenamieto por default: DATE_START_CHARG||TIME_START_CHARG */
                qsort((void*)pstDetCelular->stAgrupacion[i].stDetLlamadas, (int)pstDetCelular->stAgrupacion[i].iCantLlamadas, sizeof(DETLLAMADAS),ifnCompareDefault);
                break;
        }

    }
    /* Ordenamiento de estructura principal por grupo y subgrupo */
    qsort((void*)pstDetCelular->stAgrupacion, pstDetCelular->iCantEstructuras, sizeof(DETCELULAR_AGRUP), ifnCompareGrupoSubGrupo);
    vDTrazasLog (szExeName,"\nOrdenamiento Estruc. principal por Grupo. OK", LOG05);

    return (TRUE);
}

int ifnCompareszSec_Empa (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szSec_Empa, ((DETLLAMADAS *)cad2)->szSec_Empa) )  != 0 )?rc:0;
}
int ifnCompareszSec_Cdr (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szSec_Cdr, ((DETLLAMADAS *)cad2)->szSec_Cdr) )  != 0 )?rc:0;
}
int ifnCompareszTieIniLlam (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szTieIniLlam, ((DETLLAMADAS *)cad2)->szTieIniLlam) )  != 0 )?rc:0;
}
int ifnCompareszNumMovil1 (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szNumMovil1, ((DETLLAMADAS *)cad2)->szNumMovil1) )  != 0 )?rc:0;
}
int ifnCompareszNumMovil2 (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szNumMovil2, ((DETLLAMADAS *)cad2)->szNumMovil2) )  != 0 )?rc:0;
}
int ifnComparedImpLocal1 (const void* cad1, const void* cad2)
{
    return (int)( ((DETLLAMADAS  *)cad1)->dImpLocal1 - ((DETLLAMADAS  *)cad2)->dImpLocal1 );
}
int ifnComparedImpLarga2 (const void* cad1, const void* cad2)
{
    return (int)( ((DETLLAMADAS  *)cad1)->dImpLarga2 - ((DETLLAMADAS  *)cad2)->dImpLarga2 );
}
int ifnCompareszCodFranHoraSoc(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szCodFranHoraSoc, ((DETLLAMADAS *)cad2)->szCodFranHoraSoc) )  != 0 )?rc:0;
}
int ifnCompareszCodAlm(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szCodAlm, ((DETLLAMADAS *)cad2)->szCodAlm) )  != 0 )?rc:0;
}
int ifnCompareszDesMovil2(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szDesMovil2, ((DETLLAMADAS *)cad2)->szDesMovil2) )  != 0 )?rc:0;
}
int ifnCompareszDurLocal1(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szDurLocal1, ((DETLLAMADAS *)cad2)->szDurLocal1) )  != 0 )?rc:0;
}
int ifnCompareszDurLarga2(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szDurLarga2, ((DETLLAMADAS *)cad2)->szDurLarga2) )  != 0 )?rc:0;
}
int ifnCompareszIndEntSal1(const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szIndEntSal1, ((DETLLAMADAS *)cad2)->szIndEntSal1) )  != 0 )?rc:0;
}
int ifnComparedMto_Real(const void* cad1, const void* cad2)
{
    return (int)( ((DETLLAMADAS  *)cad1)->dMto_Real - ((DETLLAMADAS  *)cad2)->dMto_Real );
}
int ifnComparedMto_Dcto(const void* cad1, const void* cad2)
{
    return (int)( ((DETLLAMADAS  *)cad1)->dMto_Dcto - ((DETLLAMADAS  *)cad2)->dMto_Dcto );
}
int ifnCompareiDur_Real(const void* cad1, const void* cad2)
{
    return ( ((DETLLAMADAS  *)cad1)->iDur_Real - ((DETLLAMADAS  *)cad2)->iDur_Real );
}
int ifnCompareiDur_Dcto(const void* cad1, const void* cad2)
{
    return ( ((DETLLAMADAS  *)cad1)->iDur_Dcto - ((DETLLAMADAS  *)cad2)->iDur_Dcto );
}
int ifnCompareiCod_Carg(const void* cad1, const void* cad2)
{
    return ( ((DETLLAMADAS  *)cad1)->iCod_Carg - ((DETLLAMADAS  *)cad2)->iCod_Carg );
}

int ifnCompareDefault (const void* cad1, const void* cad2)
{
    int     rc = 0;
    return ( (rc = strcmp ( ((DETLLAMADAS *)cad1)->szFecIniTasa, ((DETLLAMADAS *)cad2)->szFecIniTasa) )  != 0 )?rc:0;
}

int ifnCompareGrupoSubGrupo(const void* cad1, const void* cad2)
{
    int     rc = 0;

    return  ((rc =  ((DETCELULAR_AGRUP *)cad1)->iCodGrupo -
                    ((DETCELULAR_AGRUP *)cad2)->iCodGrupo) != 0)?rc:
            ((rc =  ((DETCELULAR_AGRUP *)cad1)->iCodSubGrupo -
                    ((DETCELULAR_AGRUP *)cad2)->iCodSubGrupo) != 0)?rc:0;
}

/**************************************************************************************/
/* FUNCION     : bfnImprimeEstruc                                                     */
/* DESCRIPCION : Imprime Estructuras                                                  */
/**************************************************************************************/
BOOL bfnImprimeEstruc(DETCELULAR * pstDetCelular)
{
    int i, j;
    i    = 0;
    j    = 0;
    
    if (stStatus.LogNivel >= LOG06)
    {

        for(i=0; i < pstDetCelular->iCantEstructuras; i++)
        {
            vDTrazasLog (szExeName,"\n=================================================================="
                                   "\n\t pstDetCelular->stAgrupacion[%i].iCodGrupo      :[%i]"
                                   "\n\t pstDetCelular->stAgrupacion[%i].iCodSubGrupo   :[%i]"
                                   "\n\t pstDetCelular->stAgrupacion[%i].iNum_OrdenGr   :[%i]"
                                   "\n\t pstDetCelular->stAgrupacion[%i].iNum_OrdenSubGr:[%i]"
                                   "\n\t pstDetCelular->iCantEstructuras                :[%i]"
                                  , LOG06, i, pstDetCelular->stAgrupacion[i].iCodGrupo
                                  , i, pstDetCelular->stAgrupacion[i].iCodSubGrupo
                                  , i, pstDetCelular->stAgrupacion[i].iNum_OrdenGr
                                  , i, pstDetCelular->stAgrupacion[i].iNum_OrdenSubGr
                                  , pstDetCelular->iCantEstructuras);

            for(j=0; j < pstDetCelular->stAgrupacion[i].iCantLlamadas; j++)
            {
                vDTrazasLog (szExeName,"\n------------------------------------------------------------------", LOG06);
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szSec_Empa      : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szSec_Empa   );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szSec_Cdr       : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szSec_Cdr    );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szFecIniTasa    : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szFecIniTasa     );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szTieIniLlam    : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szTieIniLlam     );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szNumMovil1     : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szNumMovil1      );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szNumMovil2     : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szNumMovil2      );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].dImpLocal1      : [%f] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].dImpLocal1       );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].dImpLarga2      : [%f] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].dImpLarga2       );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szCodFranHoraSoc: [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szCodFranHoraSoc );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szCodAlm        : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szCodAlm         );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szDesMovil2     : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szDesMovil2      );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szDurLocal1     : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szDurLocal1      );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szDurLarga2     : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szDurLarga2      );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].szIndEntSal1    : [%s] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].szIndEntSal1     );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].dMto_Real       : [%f] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].dMto_Real        );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].dMto_Dcto       : [%f] ", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].dMto_Dcto        );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].iDur_Real       : [%ld]", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].iDur_Real        );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].iDur_Dcto       : [%ld]", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].iDur_Dcto        );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].iCod_Carg       : [%ld]", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].iCod_Carg        );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].stDetLlamadas[%i].lNumPulsos      : [%ld]", LOG06, i, j, pstDetCelular->stAgrupacion[i].stDetLlamadas[j].lNumPulsos       );
                vDTrazasLog (szExeName,"\n\t\t stAgrupacion[%i].iCantLlamadas                     : [%d] ", LOG06, i, pstDetCelular->stAgrupacion[i].iCantLlamadas);
            }
        }
    }
    return  (TRUE);
}

void vFreeEstructuras (DETCELULAR * pstDetCelular)
{

    if (pstDetCelular->stAgrupacion != (DETCELULAR_AGRUP *)NULL)
    {
        free (pstDetCelular->stAgrupacion);
    }
}

void vFreeEstructurasTAS (DETCELULAR_AGRUP * pstDetLlamadasTAS)
{
    if (pstDetLlamadasTAS->stDetLlamadas != (DETLLAMADAS *)NULL)
    {
        vDTrazasLog (szExeName,"\n\tFreeEstructurasTAS: Liberando estructura DETLLAMADAS\n", LOG05);
        
        free (pstDetLlamadasTAS->stDetLlamadas);
        pstDetLlamadasTAS->stDetLlamadas = (DETLLAMADAS*)NULL;
    }
}

/**************************************************************************************/
/* FUNCION     : bfnDetLlamCelular                                                    */
/* DESCRIPCION : Detalle Llamadas Celular                                             */
/**************************************************************************************/
BOOL bfnDetLlamCelular ( ST_ABONADO  *pst_Abonados,
                         ST_FACTCLIE *pst_Cliente,
                         int         iIndice,
                         int         iTipoLlamada,
                         FILE        *fArchImp,
                         char        *szBuffer,
                         DETALLEOPER *pstMascara,
                         int         *bImprimioD1000,
                         int         iTasador,
                         long        lCodCiclFact,
                         char        *szCodRegistro)
{

    int                      iSqlCodeDetLocal             = 0;
    char                     szTipoRegistro              [20];
    BOOL                     bEscribe                  = TRUE;
    char                     szRegistro[MAX_BYTES_REGISTRO+1];
    char                     szBuffer_local              [25];
    char                     szDurReal                  [7+1];
    char                     szDurDcto                  [7+1];
    int                      iDurReal                        ;
    int                      iDurDcto                        ;
    int                      bImprimioD2000 = FALSE          ;
    double                   dTotalLocal1Larga2              ;
    double                   dTotalUnidad                    ;
    double                   dTotalUnidadAlta                ;
    double                   dTotalUnidadBaja                ;
    DETLLAMADAS              *pstDetLlamadasTemp             ;
    static DETLLAMADAS_HOSTS stDetLlamHost                   ;
    int                      iNumFilas                    = 0;
    int                      iCont                           ;
    int                      i                               ; 
    char                     szCadenaSQL            [2500]="";    
    
    strcpy (szModulo, "bfnDetLlamCelular");
    vDTrazasLog("","\n\tEntrada en %s"
                   "\n\t\t==> Num. Abonado  [%ld]"
                   "\n\t\t==> Num. Celular  [%ld]"
                   "\n\t\t==> Indice        [%d]"
                   "\n\t\t==> Tipo Trafico  [%d]"
                   ,LOG04,szModulo
                   ,pst_Abonados->lNumAbonado[iIndice]
                   ,pst_Abonados->lNumCelular[iIndice]
                   ,iIndice
                   ,iTipoLlamada);

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));

    /************************************************************************************/
    /*    Recupera Detalle de Llamadas Locales                                          */
    /************************************************************************************/

    sprintf(szCadenaSQL,"\nSELECT B.COD_REGISTRO, "
                        "\n  A.SEC_EMPA, "    
                        "\n  A.SEC_CDR, "
                        "\n  MAX(TO_CHAR(TO_DATE(A.DATE_START_CHARG||A.TIME_START_CHARG,'YYYYMMDDHH24MISS'),:szhFormatoFecha)), "
                        "\n  MAX(TO_CHAR(TO_DATE(A.TIME_START_CHARG,'HH24MISS'),:szhFormatoHora)), "
                        "\n  MAX(A.A_SUSC_NUMBER), "
                        "\n  MAX(A.B_SUSC_NUMBER), "
                        "\n  SUM(DECODE(A.IND_BILLETE,'01',MTO_FACT,0)), "
                        "\n  SUM(DECODE(A.IND_BILLETE,'02',MTO_FACT,0)), "
                        "\n  MAX(A.COD_THOR), "
                        "\n  MAX(A.COD_ALMA), "
                        "\n  MAX(A.DES_DESTINO), "
                        "\n  MAX(DECODE(A.IND_BILLETE,'01',TO_CHAR(DUR_FACT),'0')), "
                        "\n  MAX(DECODE(A.IND_BILLETE,'02',TO_CHAR(DUR_FACT),'0')), "
                        "\n  MAX(A.COD_SENT), "
                        "\n  SUM(A.MTO_REAL), "
                        "\n  SUM(A.MTO_DCTO), "
                        "\n  SUM(A.DUR_REAL), "
                        "\n  SUM(A.DUR_DCTO), "
                        "\n  A.COD_CARG   , "
                        "\n  A.COD_FCOB   , "
                        "\n  0            , "
                        "\n  NVL(A.COD_TDIR ,'     '), "
                        "\n  NVL(A.COD_OPERA,'     '), "
                        "\n  NVL(A.COD_MARCA,'      '), "
                        "\n  NVL(A.IND_IMPRESION,'  '), "
                        "\n  0, "
                        "\n  SUM(NVL(A.NUM_PULSO,0)) ,"
                        "\n  NVL(MAX(A.RECORD_TYPE),' '), "
                        "\n  NVL(MAX(A.COD_DCTO),' '), "
                        "\n  NVL(MAX(A.TIP_DCTO),' '), "
                        "\n  SUM(NVL(A.VALOR_UNIDAD,0)),  "
                        "\n  NVL(MAX(A.DES_LLAMADA),'.') "
                        "\nFROM PF_TOLTARIFICA_%ld A, "
                         "\n    (SELECT COD_REGISTRO, VALOR "
                         "\n     FROM   FA_REGDETLLAM_TD "
                         "\n     WHERE  TIP_REGISTRO IN ('TOL')) B "                        
                        "\nWHERE A.NUM_CLIE   = :lhCodCliente "
                        "\n  AND A.NUM_ABON   = :lhNumAbonado "
                        "\n  AND A.COD_TCOR <> 'VE' "
                        "\n  AND A.COD_AGRL = B.VALOR "
                        "\n GROUP BY B.COD_REGISTRO,A.SEC_EMPA,A.SEC_CDR,A.COD_CARG,A.COD_FCOB,A.COD_TDIR,A.COD_OPERA,A.COD_MARCA,A.IND_IMPRESION "
                        "\n ORDER BY B.COD_REGISTRO,MAX(A.DATE_START_CHARG||A.TIME_START_CHARG) "
                      , lCodCiclFact);

    vDTrazasLog( szModulo,"=> query Cur_TolTarifica_2(\n%s\n)",LOG05,szCadenaSQL);

    /* EXEC SQL PREPARE sql_Cur_TolTarifica_2 FROM :szCadenaSQL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 29;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )803;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
    sqlstm.sqhstl[0] = (unsigned long )2500;
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


    if (sqlca.sqlcode != SQLOK)
    {
        vDTrazasLog (szModulo, "Error en PREPARE Cur_TolTarifica_2. Error [%d][%s]",LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }

    /* EXEC SQL DECLARE Cur_TolTarifica_2 CURSOR FOR sql_Cur_TolTarifica_2; */ 

    if (sqlca.sqlcode < SQLOK)
    {
        vDTrazasLog (szModulo, "Error en DECLARE. Cur_TolTarifica_2 Error [%d][%s]",LOG00,  sqlca.sqlcode, sqlca.sqlerrm.sqlerrmc);
        return(FALSE);
    }
    
    /* Open Cursor Cur_TolTarifica_2 */
    iSqlCodeDetLocal = ifnOpenDetCelular  ( pst_Cliente->lCodCliente,
                                            pst_Abonados->lNumAbonado[iIndice],
                                            iTipoLlamada,
                                            iTasador, 
                                            pstMascara);

    if (iSqlCodeDetLocal != SQLOK)
    {
        vDTrazasLog (szExeName,"\n\nERROR(bfnDetLlamCelular):"
        "\n\tError al Abrir Cursor en Funcion ifnOpenDetCelular TAS ", LOG05 );
        return (FALSE);
    }

    memset(szBuffer_local,0,sizeof(szBuffer_local));


    /*********************************************/
    /* Escribe cabecera de registros D           */
    /*********************************************/
    memset(&stDetLlamadasTAS.stDetLlamadas    , 0, sizeof (DETLLAMADAS));
    
    vDTrazasLog (szExeName,"\n\n(bfnDetLlamCelular):"
        "\n\tstDetLlamadasTAS.iCantLlamadas [%d] ", LOG05,stDetLlamadasTAS.iCantLlamadas);
    
    /* EXEC SQL WHENEVER NOT FOUND CONTINUE; */ 
 
    /* initialize loop variables */ 
    long rows_before       = 0;      
    long rows_this_time = 1000; 
    
    while (iSqlCodeDetLocal != SQLNOTFOUND)
    {

        /* EXEC SQL 
        FETCH Cur_TolTarifica_2
              INTO
                  :stDetLlamHost.szCodRegistro    ,
                  :stDetLlamHost.szSec_Empa       ,
                  :stDetLlamHost.szSec_Cdr        ,
                  :stDetLlamHost.szFecIniTasa     ,
                  :stDetLlamHost.szTieIniLlam     ,
                  :stDetLlamHost.szNumMovil1      ,
                  :stDetLlamHost.szNumMovil2      ,
                  :stDetLlamHost.dImpLocal1       ,
                  :stDetLlamHost.dImpLarga2       ,
                  :stDetLlamHost.szCodFranHoraSoc ,
                  :stDetLlamHost.szCodAlm         ,
                  :stDetLlamHost.szDesMovil2      ,
                  :stDetLlamHost.szDurLocal1      ,
                  :stDetLlamHost.szDurLarga2      ,
                  :stDetLlamHost.szIndEntSal1     ,
                  :stDetLlamHost.dMto_Real        ,
                  :stDetLlamHost.dMto_Dcto        ,
                  :stDetLlamHost.iDur_Real        ,
                  :stDetLlamHost.iDur_Dcto        ,
                  :stDetLlamHost.iCod_Carg        ,
                  :stDetLlamHost.szCodFCob        ,
                  :stDetLlamHost.dValorUndad      ,
                  :stDetLlamHost.szCodTdir        ,
                  :stDetLlamHost.CodOperB         ,
                  :stDetLlamHost.szCodMarca       ,
                  :stDetLlamHost.szIndImpresion   ,
                  :stDetLlamHost.lCodConcCarrier  , 
                  :stDetLlamHost.lNumPulsos       ,
                  :stDetLlamHost.szRecordType     , 
                  :stDetLlamHost.szCodDcto        , 
                  :stDetLlamHost.szTipDcto        , 
                  :stDetLlamHost.dValorUnidad     ,
                  :stDetLlamHost.szDesLlamada     ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )5000;
        sqlstm.offset = (unsigned int  )822;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)(stDetLlamHost.szCodRegistro);
        sqlstm.sqhstl[0] = (unsigned long )6;
        sqlstm.sqhsts[0] = (         int  )6;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)(stDetLlamHost.szSec_Empa);
        sqlstm.sqhstl[1] = (unsigned long )30;
        sqlstm.sqhsts[1] = (         int  )30;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)(stDetLlamHost.szSec_Cdr);
        sqlstm.sqhstl[2] = (unsigned long )6;
        sqlstm.sqhsts[2] = (         int  )6;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)(stDetLlamHost.szFecIniTasa);
        sqlstm.sqhstl[3] = (unsigned long )16;
        sqlstm.sqhsts[3] = (         int  )16;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)(stDetLlamHost.szTieIniLlam);
        sqlstm.sqhstl[4] = (unsigned long )7;
        sqlstm.sqhsts[4] = (         int  )7;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)(stDetLlamHost.szNumMovil1);
        sqlstm.sqhstl[5] = (unsigned long )20;
        sqlstm.sqhsts[5] = (         int  )20;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)(stDetLlamHost.szNumMovil2);
        sqlstm.sqhstl[6] = (unsigned long )20;
        sqlstm.sqhsts[6] = (         int  )20;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)(stDetLlamHost.dImpLocal1);
        sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[7] = (         int  )sizeof(double);
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)(stDetLlamHost.dImpLarga2);
        sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[8] = (         int  )sizeof(double);
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)(stDetLlamHost.szCodFranHoraSoc);
        sqlstm.sqhstl[9] = (unsigned long )6;
        sqlstm.sqhsts[9] = (         int  )6;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)(stDetLlamHost.szCodAlm);
        sqlstm.sqhstl[10] = (unsigned long )4;
        sqlstm.sqhsts[10] = (         int  )4;
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)(stDetLlamHost.szDesMovil2);
        sqlstm.sqhstl[11] = (unsigned long )31;
        sqlstm.sqhsts[11] = (         int  )31;
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)(stDetLlamHost.szDurLocal1);
        sqlstm.sqhstl[12] = (unsigned long )7;
        sqlstm.sqhsts[12] = (         int  )7;
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)(stDetLlamHost.szDurLarga2);
        sqlstm.sqhstl[13] = (unsigned long )7;
        sqlstm.sqhsts[13] = (         int  )7;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)(stDetLlamHost.szIndEntSal1);
        sqlstm.sqhstl[14] = (unsigned long )6;
        sqlstm.sqhsts[14] = (         int  )6;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)(stDetLlamHost.dMto_Real);
        sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[15] = (         int  )sizeof(double);
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)(stDetLlamHost.dMto_Dcto);
        sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[16] = (         int  )sizeof(double);
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)(stDetLlamHost.iDur_Real);
        sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[17] = (         int  )sizeof(int);
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqharc[17] = (unsigned long  *)0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)(stDetLlamHost.iDur_Dcto);
        sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[18] = (         int  )sizeof(int);
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqharc[18] = (unsigned long  *)0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
        sqlstm.sqhstv[19] = (unsigned char  *)(stDetLlamHost.iCod_Carg);
        sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[19] = (         int  )sizeof(int);
        sqlstm.sqindv[19] = (         short *)0;
        sqlstm.sqinds[19] = (         int  )0;
        sqlstm.sqharm[19] = (unsigned long )0;
        sqlstm.sqharc[19] = (unsigned long  *)0;
        sqlstm.sqadto[19] = (unsigned short )0;
        sqlstm.sqtdso[19] = (unsigned short )0;
        sqlstm.sqhstv[20] = (unsigned char  *)(stDetLlamHost.szCodFCob);
        sqlstm.sqhstl[20] = (unsigned long )6;
        sqlstm.sqhsts[20] = (         int  )6;
        sqlstm.sqindv[20] = (         short *)0;
        sqlstm.sqinds[20] = (         int  )0;
        sqlstm.sqharm[20] = (unsigned long )0;
        sqlstm.sqharc[20] = (unsigned long  *)0;
        sqlstm.sqadto[20] = (unsigned short )0;
        sqlstm.sqtdso[20] = (unsigned short )0;
        sqlstm.sqhstv[21] = (unsigned char  *)(stDetLlamHost.dValorUndad);
        sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[21] = (         int  )sizeof(double);
        sqlstm.sqindv[21] = (         short *)0;
        sqlstm.sqinds[21] = (         int  )0;
        sqlstm.sqharm[21] = (unsigned long )0;
        sqlstm.sqharc[21] = (unsigned long  *)0;
        sqlstm.sqadto[21] = (unsigned short )0;
        sqlstm.sqtdso[21] = (unsigned short )0;
        sqlstm.sqhstv[22] = (unsigned char  *)(stDetLlamHost.szCodTdir);
        sqlstm.sqhstl[22] = (unsigned long )6;
        sqlstm.sqhsts[22] = (         int  )6;
        sqlstm.sqindv[22] = (         short *)0;
        sqlstm.sqinds[22] = (         int  )0;
        sqlstm.sqharm[22] = (unsigned long )0;
        sqlstm.sqharc[22] = (unsigned long  *)0;
        sqlstm.sqadto[22] = (unsigned short )0;
        sqlstm.sqtdso[22] = (unsigned short )0;
        sqlstm.sqhstv[23] = (unsigned char  *)(stDetLlamHost.CodOperB);
        sqlstm.sqhstl[23] = (unsigned long )6;
        sqlstm.sqhsts[23] = (         int  )6;
        sqlstm.sqindv[23] = (         short *)0;
        sqlstm.sqinds[23] = (         int  )0;
        sqlstm.sqharm[23] = (unsigned long )0;
        sqlstm.sqharc[23] = (unsigned long  *)0;
        sqlstm.sqadto[23] = (unsigned short )0;
        sqlstm.sqtdso[23] = (unsigned short )0;
        sqlstm.sqhstv[24] = (unsigned char  *)(stDetLlamHost.szCodMarca);
        sqlstm.sqhstl[24] = (unsigned long )7;
        sqlstm.sqhsts[24] = (         int  )7;
        sqlstm.sqindv[24] = (         short *)0;
        sqlstm.sqinds[24] = (         int  )0;
        sqlstm.sqharm[24] = (unsigned long )0;
        sqlstm.sqharc[24] = (unsigned long  *)0;
        sqlstm.sqadto[24] = (unsigned short )0;
        sqlstm.sqtdso[24] = (unsigned short )0;
        sqlstm.sqhstv[25] = (unsigned char  *)(stDetLlamHost.szIndImpresion);
        sqlstm.sqhstl[25] = (unsigned long )3;
        sqlstm.sqhsts[25] = (         int  )3;
        sqlstm.sqindv[25] = (         short *)0;
        sqlstm.sqinds[25] = (         int  )0;
        sqlstm.sqharm[25] = (unsigned long )0;
        sqlstm.sqharc[25] = (unsigned long  *)0;
        sqlstm.sqadto[25] = (unsigned short )0;
        sqlstm.sqtdso[25] = (unsigned short )0;
        sqlstm.sqhstv[26] = (unsigned char  *)(stDetLlamHost.lCodConcCarrier);
        sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[26] = (         int  )sizeof(long);
        sqlstm.sqindv[26] = (         short *)0;
        sqlstm.sqinds[26] = (         int  )0;
        sqlstm.sqharm[26] = (unsigned long )0;
        sqlstm.sqharc[26] = (unsigned long  *)0;
        sqlstm.sqadto[26] = (unsigned short )0;
        sqlstm.sqtdso[26] = (unsigned short )0;
        sqlstm.sqhstv[27] = (unsigned char  *)(stDetLlamHost.lNumPulsos);
        sqlstm.sqhstl[27] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[27] = (         int  )sizeof(long);
        sqlstm.sqindv[27] = (         short *)0;
        sqlstm.sqinds[27] = (         int  )0;
        sqlstm.sqharm[27] = (unsigned long )0;
        sqlstm.sqharc[27] = (unsigned long  *)0;
        sqlstm.sqadto[27] = (unsigned short )0;
        sqlstm.sqtdso[27] = (unsigned short )0;
        sqlstm.sqhstv[28] = (unsigned char  *)(stDetLlamHost.szRecordType);
        sqlstm.sqhstl[28] = (unsigned long )3;
        sqlstm.sqhsts[28] = (         int  )3;
        sqlstm.sqindv[28] = (         short *)0;
        sqlstm.sqinds[28] = (         int  )0;
        sqlstm.sqharm[28] = (unsigned long )0;
        sqlstm.sqharc[28] = (unsigned long  *)0;
        sqlstm.sqadto[28] = (unsigned short )0;
        sqlstm.sqtdso[28] = (unsigned short )0;
        sqlstm.sqhstv[29] = (unsigned char  *)(stDetLlamHost.szCodDcto);
        sqlstm.sqhstl[29] = (unsigned long )6;
        sqlstm.sqhsts[29] = (         int  )6;
        sqlstm.sqindv[29] = (         short *)0;
        sqlstm.sqinds[29] = (         int  )0;
        sqlstm.sqharm[29] = (unsigned long )0;
        sqlstm.sqharc[29] = (unsigned long  *)0;
        sqlstm.sqadto[29] = (unsigned short )0;
        sqlstm.sqtdso[29] = (unsigned short )0;
        sqlstm.sqhstv[30] = (unsigned char  *)(stDetLlamHost.szTipDcto);
        sqlstm.sqhstl[30] = (unsigned long )6;
        sqlstm.sqhsts[30] = (         int  )6;
        sqlstm.sqindv[30] = (         short *)0;
        sqlstm.sqinds[30] = (         int  )0;
        sqlstm.sqharm[30] = (unsigned long )0;
        sqlstm.sqharc[30] = (unsigned long  *)0;
        sqlstm.sqadto[30] = (unsigned short )0;
        sqlstm.sqtdso[30] = (unsigned short )0;
        sqlstm.sqhstv[31] = (unsigned char  *)(stDetLlamHost.dValorUnidad);
        sqlstm.sqhstl[31] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[31] = (         int  )sizeof(double);
        sqlstm.sqindv[31] = (         short *)0;
        sqlstm.sqinds[31] = (         int  )0;
        sqlstm.sqharm[31] = (unsigned long )0;
        sqlstm.sqharc[31] = (unsigned long  *)0;
        sqlstm.sqadto[31] = (unsigned short )0;
        sqlstm.sqtdso[31] = (unsigned short )0;
        sqlstm.sqhstv[32] = (unsigned char  *)(stDetLlamHost.szDesLlamada);
        sqlstm.sqhstl[32] = (unsigned long )101;
        sqlstm.sqhsts[32] = (         int  )101;
        sqlstm.sqindv[32] = (         short *)0;
        sqlstm.sqinds[32] = (         int  )0;
        sqlstm.sqharm[32] = (unsigned long )0;
        sqlstm.sqharc[32] = (unsigned long  *)0;
        sqlstm.sqadto[32] = (unsigned short )0;
        sqlstm.sqtdso[32] = (unsigned short )0;
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

 /* P-MIX-09003 */
    
        rows_this_time = sqlca.sqlerrd[2] - rows_before; 
        rows_before = sqlca.sqlerrd[2]; 

        iSqlCodeDetLocal = SQLCODE;
        iNumFilas = rows_this_time;

        vDTrazasLog (szExeName,"\n\niSqlCodeDetLocal[%d]\n", LOG05, iSqlCodeDetLocal);

        if (iSqlCodeDetLocal != SQLOK  && iSqlCodeDetLocal != SQLNOTFOUND)
        {
            vDTrazasLog (szExeName,"\n\nERROR(bfnDetLlamCelular):"
                            "\n\tError al  realizar el FETCH sobre DETCELULAR   [%d]", LOG05 , iSqlCodeDetLocal);
            return (FALSE);
        }

        vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:Paso el Fetch iNumFilas   [%d]\n", LOG05, iNumFilas);

        if (iNumFilas < 1)
            break;

        vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:realloc  ([%d]*([%d]+[%d]))=[%d]\n"
                              , LOG05, sizeof(DETLLAMADAS), stDetLlamadasTAS.iCantLlamadas,iNumFilas, (sizeof(DETLLAMADAS)* (stDetLlamadasTAS.iCantLlamadas + iNumFilas)));

        stDetLlamadasTAS.stDetLlamadas = (DETLLAMADAS*) realloc(stDetLlamadasTAS.stDetLlamadas, (sizeof(DETLLAMADAS)* (stDetLlamadasTAS.iCantLlamadas + iNumFilas)));
        
        if (!stDetLlamadasTAS.stDetLlamadas)
        {
            iDError (szExeName,ERR000,vInsertarIncidencia,
                          "Error bfnDetLlamCelular", "no se pudo reservar memoria");
            return FALSE;
        }
        pstDetLlamadasTemp = &(stDetLlamadasTAS.stDetLlamadas)[(stDetLlamadasTAS.iCantLlamadas)];

        memset(pstDetLlamadasTemp, 0, sizeof(DETLLAMADAS)*iNumFilas);

        for (iCont = 0 ; iCont < iNumFilas ; iCont++)
        {
            strcpy(pstDetLlamadasTemp[iCont].szCodRegistro    , stDetLlamHost.szCodRegistro[iCont]);        	
            strcpy(pstDetLlamadasTemp[iCont].szSec_Empa       , stDetLlamHost.szSec_Empa[iCont]  );
            strcpy(pstDetLlamadasTemp[iCont].szSec_Cdr        , stDetLlamHost.szSec_Cdr[iCont]    );
            strcpy(pstDetLlamadasTemp[iCont].szFecIniTasa     , stDetLlamHost.szFecIniTasa[iCont] );
            strcpy(pstDetLlamadasTemp[iCont].szTieIniLlam     , stDetLlamHost.szTieIniLlam[iCont] );
            strcpy(pstDetLlamadasTemp[iCont].szNumMovil1      , stDetLlamHost.szNumMovil1[iCont]  );
            strcpy(pstDetLlamadasTemp[iCont].szNumMovil2      , stDetLlamHost.szNumMovil2[iCont]  );
            strcpy(pstDetLlamadasTemp[iCont].szCodFranHoraSoc , stDetLlamHost.szCodFranHoraSoc[iCont] );
            strcpy(pstDetLlamadasTemp[iCont].szCodAlm         , stDetLlamHost.szCodAlm[iCont]     );
            strcpy(pstDetLlamadasTemp[iCont].szDesMovil2      , stDetLlamHost.szDesMovil2[iCont]   );
            strcpy(pstDetLlamadasTemp[iCont].szDurLocal1      , stDetLlamHost.szDurLocal1[iCont]   );
            strcpy(pstDetLlamadasTemp[iCont].szDurLarga2      , stDetLlamHost.szDurLarga2[iCont]   );
            strcpy(pstDetLlamadasTemp[iCont].szIndEntSal1     , stDetLlamHost.szIndEntSal1[iCont]  );
            strcpy(pstDetLlamadasTemp[iCont].szCodFCob        , stDetLlamHost.szCodFCob[iCont]     );
            strcpy(pstDetLlamadasTemp[iCont].szCodTdir        , stDetLlamHost.szCodTdir[iCont]     );    
            strcpy(pstDetLlamadasTemp[iCont].CodOperB         , stDetLlamHost.CodOperB[iCont]      );    
            strcpy(pstDetLlamadasTemp[iCont].szCodMarca       , stDetLlamHost.szCodMarca[iCont]    );    
            strcpy(pstDetLlamadasTemp[iCont].szIndImpresion   , stDetLlamHost.szIndImpresion[iCont]);    
            pstDetLlamadasTemp[iCont].dMto_Real  = stDetLlamHost.dMto_Real[iCont] ;
            pstDetLlamadasTemp[iCont].dMto_Dcto  = stDetLlamHost.dMto_Dcto[iCont] ;
            pstDetLlamadasTemp[iCont].iDur_Real  = stDetLlamHost.iDur_Real[iCont] ;
            pstDetLlamadasTemp[iCont].iDur_Dcto  = stDetLlamHost.iDur_Dcto[iCont] ;
            pstDetLlamadasTemp[iCont].iCod_Carg  = stDetLlamHost.iCod_Carg[iCont] ;
            pstDetLlamadasTemp[iCont].dImpLocal1 = stDetLlamHost.dImpLocal1[iCont];
            pstDetLlamadasTemp[iCont].dImpLarga2 = stDetLlamHost.dImpLarga2[iCont];
            pstDetLlamadasTemp[iCont].dValorUndad= stDetLlamHost.dValorUndad[iCont];
            pstDetLlamadasTemp[iCont].lNumPulsos = stDetLlamHost.lNumPulsos[iCont];
            strcpy(pstDetLlamadasTemp[iCont].szRecordType      , stDetLlamHost.szRecordType[iCont]   );
            strcpy(pstDetLlamadasTemp[iCont].szCodDcto         , stDetLlamHost.szCodDcto[iCont]      );
            strcpy(pstDetLlamadasTemp[iCont].szTipDcto         , stDetLlamHost.szTipDcto[iCont]      );
            pstDetLlamadasTemp[iCont].dValorUnidad= stDetLlamHost.dValorUnidad[iCont];
            strcpy(pstDetLlamadasTemp[iCont].szDesLlamada      , stDetLlamHost.szDesLlamada[iCont]   ); /* P-MIX-09003 */
            strcpy(pstDetLlamadasTemp[iCont].szCodRegistro      , stDetLlamHost.szCodRegistro[iCont]   ); /* P-MIX-09003 */            
            

            stDetLlamadasTAS.iCantLlamadas++;
        }
    }
    vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:Fin asignacion datos iNumFilas=[%d] iCont=[%d] stDetLlamadasTAS.iCantLlamadas=[%d]\n", LOG05, iNumFilas,iCont,stDetLlamadasTAS.iCantLlamadas);


    for (i=0; i< stDetLlamadasTAS.iCantLlamadas; i++)
    {
        if(!*bImprimioD1000)
        {
            put_D1000(pst_Abonados,fArchImp,iIndice,szBuffer);
            *bImprimioD1000 = TRUE;
        }

        if (!bImprimioD2000)
        {
                /******************************** ************/
                /* Escribe cabecera de tipo de registro          */
                /*********************************************/

                sprintf(szBuffer_local ,"%-5s%013d%05d\n"
                                   ,COD_TIPOLLAMADA
                                   ,iTipoLlamada
                                   ,atoi(pst_Cliente->szCod_Idioma));
            vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:bEscribeEnArchivo szBuffer_local=[%s]\n", LOG05, szBuffer_local);
            
            if (!bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local))
            {
            	vDTrazasLog (szExeName, "\n\t (%s): Error en función bEscribeEnArchivo ", LOG05, szModulo);
            }
            
            bImprimioD2000=TRUE;
        }

        switch(iTipoLlamada)
        {
            case    iTIPLLAMADAS_LOCALES :
                    vDTrazasLog ("vfnCargarDesOperador","\n\t\t(INFO)* Dentro de case iTIPLLAMADAS_LOCALES :", LOG05);
                    strcpy(szTipoRegistro,COD_LOCALES);
                    vfnCargarDesOperador(atoi(stDetLlamadasTAS.stDetLlamadas[i].CodOperB),
                                         stDetLlamadasTAS.stDetLlamadas[i].szCodTdir,
                                         stDetLlamadasTAS.stDetLlamadas[i].szDesMovil2);
                    break;
            case    iTIPLLAMADAS_INTERZONA :
                    strcpy(szTipoRegistro,COD_INTERZONA);
                    break;
            case    iTIPLLAMADAS_ESPECIALES :
                    strcpy(szTipoRegistro,COD_ESPECIALES);
                    break;
            case    iTIPLLAMADAS_ESPECIALES_DATA:
                    strcpy(szTipoRegistro,COD_ESPECIALES_DATA);
                    break;
            case    iTIPLLAMADAS_LDI:
                    strcpy(szTipoRegistro,COD_LDI);
                    break;
            case    iTIPLLAMADAS_TARIFA_ADICIONAL :
                    strcpy(szTipoRegistro,COD_TARIFA_ADICIONAL);
                    break;
        }

        /************************************************************************/
        /* Escribimos en buffer Validando Tamano del Buffer  o                  */
        /* Escribimos en Archivo y Limpiamos Buffer                             */
        /************************************************************************/

        iDurReal = stDetLlamadasTAS.stDetLlamadas[i].iDur_Real;
        iDurDcto = stDetLlamadasTAS.stDetLlamadas[i].iDur_Dcto;

        sprintf(szDurReal,"%7.7d",iDurReal);
        sprintf(szDurDcto,"%7.7d",iDurDcto);

        dTotalLocal1Larga2=stDetLlamadasTAS.stDetLlamadas[i].dImpLocal1 + stDetLlamadasTAS.stDetLlamadas[i].dImpLarga2;

        dTotalUnidad = 0.0;
        if (strcmp(stDetLlamadasTAS.stDetLlamadas[i].szCodFCob,"D")) /* rao */
        {
            dTotalUnidad = stDetLlamadasTAS.stDetLlamadas[i].dImpLocal1 + stDetLlamadasTAS.stDetLlamadas[i].dImpLarga2;
        }
        else
        {
            dTotalUnidad = stDetLlamadasTAS.stDetLlamadas[i].dValorUndad;

        }
        dTotalUnidadAlta = 0.0;
        dTotalUnidadBaja = 0.0;
        if (strcmp(stDetLlamadasTAS.stDetLlamadas[i].szCodFranHoraSoc,"N" )) /* Noche */
        {
            dTotalUnidadBaja= dTotalUnidad ;
        }
        else
        {
            dTotalUnidadAlta= dTotalUnidad ;
        }
        
        /* P-MIX-09003 141767 */
        if (stDetLlamadasTAS.stDetLlamadas[i].lNumPulsos > 0)
        {                    
            dTotalUnidadAlta = stDetLlamadasTAS.stDetLlamadas[i].dMto_Real / stDetLlamadasTAS.stDetLlamadas[i].lNumPulsos;
                    vDTrazasLog(szModulo, "\n\t (%s) : Calculo "
                                          "\n\t\t Monto Real        [%f]"
                                          "\n\t\t Num.Pulsos        [%ld]"                                          
                                          "\n\t\t Monto Uni. Normal [%f]"                                          
                                        , LOG05
                                        , szModulo
                                        , stDetLlamadasTAS.stDetLlamadas[i].dMto_Real
                                        , stDetLlamadasTAS.stDetLlamadas[i].lNumPulsos
                                        , dTotalUnidadAlta);            
        }
        else
        {
            dTotalUnidadAlta = 0.0;                	
            vDTrazasLog(szModulo, "\n\t (%s) : Calculo "
                                  "\n\t\t Monto Uni. Normal [%f]"                                          
                                , LOG05
                                , szModulo
                                , dTotalUnidadAlta);            
        }
        /* P-MIX-09003 141767 */        
        
        
        sprintf(szRegistro,"%-5s%-8.8s%-6s%-20s%-20s%015.4f%015.4f%-6s%-3s%-30s%-7s%-7s%-6s%015.4f%015.4f%-7s%-7s%-05d%015.4f%015.4f%015.4f%-10.10s%-1.1s%6.6ld%-2.2s%-5.5s%-5.5s%015.4f%-100.100s\n"
                            ,stDetLlamadasTAS.stDetLlamadas[i].szCodRegistro
                            ,stDetLlamadasTAS.stDetLlamadas[i].szFecIniTasa
                            ,stDetLlamadasTAS.stDetLlamadas[i].szTieIniLlam
                            ,stDetLlamadasTAS.stDetLlamadas[i].szNumMovil1
                            ,stDetLlamadasTAS.stDetLlamadas[i].szNumMovil2
                            ,stDetLlamadasTAS.stDetLlamadas[i].dImpLocal1
                            ,stDetLlamadasTAS.stDetLlamadas[i].dImpLarga2
                            ,stDetLlamadasTAS.stDetLlamadas[i].szCodFranHoraSoc
                            ,stDetLlamadasTAS.stDetLlamadas[i].szCodAlm
                            ,stDetLlamadasTAS.stDetLlamadas[i].szDesMovil2 /* P-MIX-09003 141767 */
                            ,stDetLlamadasTAS.stDetLlamadas[i].szDurLocal1
                            ,stDetLlamadasTAS.stDetLlamadas[i].szDurLarga2
                            ,stDetLlamadasTAS.stDetLlamadas[i].szIndEntSal1
                            ,stDetLlamadasTAS.stDetLlamadas[i].dMto_Real
                            ,stDetLlamadasTAS.stDetLlamadas[i].dMto_Dcto
                            ,szDurReal
                            ,szDurDcto
                            ,stDetLlamadasTAS.stDetLlamadas[i].iCod_Carg
                            ,dTotalLocal1Larga2
                            ,dTotalUnidadAlta /* aqui va la modificacion jhto 141767 */
                            ,dTotalUnidadBaja                     
                            ,stDetLlamadasTAS.stDetLlamadas[i].szCodMarca
                            ,stDetLlamadasTAS.stDetLlamadas[i].szIndImpresion
                            ,stDetLlamadasTAS.stDetLlamadas[i].lNumPulsos
                            ,stDetLlamadasTAS.stDetLlamadas[i].szRecordType
                            ,stDetLlamadasTAS.stDetLlamadas[i].szCodDcto
                            ,stDetLlamadasTAS.stDetLlamadas[i].szTipDcto
                            ,stDetLlamadasTAS.stDetLlamadas[i].dValorUnidad
                            ,stDetLlamadasTAS.stDetLlamadas[i].szDesLlamada /* P-MIX-09003 */
                            );

        vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:bEscribeEnArchivo szRegistro[%d][%d]=[%s]\n", LOG05, strlen(szRegistro), sizeof(szRegistro), szRegistro);

        bEscribe= bEscribeEnArchivo(fArchImp,szBuffer,szRegistro);

        if ( !bEscribe )
        {
             vDTrazasLog (szExeName, "\n\t (%s): Error en función bEscribeEnArchivo ", LOG05, szModulo);
             return FALSE;
        }        
    }

    if(bImprimioD2000)
    {
            sprintf(szBuffer_local,"%s\n", PIE_TIPOLLAMADA);

        vDTrazasLog (szExeName,"\n\nbfnDetLlamCelular:bImprimioD2000 bEscribeEnArchivo szBuffer_local=[%s]\n", LOG05, szBuffer_local);
        bEscribe = bEscribeEnArchivo(fArchImp,szBuffer,szBuffer_local);
        if ( !bEscribe )
        {
             vDTrazasLog (szExeName, "\n\t (%s): Error en función bEscribeEnArchivo ", LOG05, szModulo);
        }        
    }

    if (!bfnCloseDetCelular(iTasador))
            return (FALSE);

    vFreeEstructurasTAS(&stDetLlamadasTAS);


        return (TRUE);
}

/*****************************************************************************************/
/* FUNCION : ifnOpenDetCelular                                                           */
/*****************************************************************************************/
int ifnOpenDetCelular( long        lCodCliente, 
                       long        lNumAbonado, 
                       int         iTipLlam, 
                       int         iTasador, 
                       DETALLEOPER *st_Mascara)
{
    char    szWhere     [513]   ="" ;
    char    szCadenaSQL [25000]  ="" ;
    char    szTipLlam[50];

    memset(szCadenaSQL,0,sizeof(szCadenaSQL));
    strcpy (szModulo, "ifnOpenDetCelular");
    vDTrazasLog(szModulo, "\n\t\t**  Entrada en %s "
                          "\n\t\t==> Cliente      [%ld]"
                          "\n\t\t==> Abonado      [%ld]"
                          "\n\t\t==> Tipo Llamada [%d]"
                          ,LOG04,szModulo,lCodCliente,lNumAbonado,iTipLlam);
    /********************************************************************/
    /*  Analiza el Tipo de Llamada a Imprimir y determina condiciones   */
    /********************************************************************/

    strcpy(szhFormatoFecha, szformato_fecha);
    strcpy(szhFormatoHora , szformato_hora );

    lhCodCliente = lCodCliente;
    lhNumAbonado = lNumAbonado;

    strcpy (szhFormatoFecha,szformato_fecha);
    strcpy (szhFormatoHora,szformato_hora);

    if(!iTasador)
    {
        switch (iTipLlam)
        {
            case iTIPLLAMADAS_LOCALES:
                sprintf(szWhere,"%s\0",st_Mascara->szWhere_Local);
                strcpy(szTipLlam,"LOCALES");
                break;
            case iTIPLLAMADAS_INTERZONA:
                sprintf(szWhere,"%s\0",st_Mascara->szWhere_Interzona);
                strcpy(szTipLlam,"INTERZONA");
                break;
            case iTIPLLAMADAS_LDI:
                sprintf(szWhere,"%s\0",st_Mascara->szWhere_LDI);
                strcpy(szTipLlam,"LDI");
                break;
            case iTIPLLAMADAS_ESPECIALES:
                sprintf(szWhere,"%s\0",st_Mascara->szWhere_Especiales);
                strcpy(szTipLlam,"ESPECIALES");
                break;
            case iTIPLLAMADAS_ESPECIALES_DATA:
                sprintf(szWhere,"%s\0",st_Mascara->szWhere_Especiales_data);
                strcpy(szTipLlam,"ESPECIALES DATA");
                break;
        }

        strcpy (szhDWhere, szWhere);

        vDTrazasLog(szModulo,"\n\t\t** where selecionado (%s) (%s)",LOG04,szTipLlam,szWhere);

        sprintf(szCadenaSQL,"SELECT  '0','0',   \n"
                            "   TO_CHAR(FEC_INITASA,'YYYYMMDD'),\n"
                            "   TIE_INILLAM    ,                \n"
                            "   LTRIM(NUM_MOVIL1),              \n"
                            "   NVL(LTRIM(NUM_MOVIL2),' '),     \n"
                            "   NVL(IMP_LOCAL1     ,0),         \n"
                            "   NVL(IMP_LARGA2     ,0),         \n"
                            "   NVL(COD_FRANHORASOC,0),         \n"
                            "   NVL(COD_ALM        ,' '),       \n"
                            "   NVL(DES_MOVIL2     ,' '),       \n"
                            "   NVL(DUR_LOCAL1     ,' '),       \n"
                            "   NVL(DUR_LARGA2     ,' '),       \n"
                            "   NVL(IND_ENTSAL1    ,1),         \n"
                            "   0,                              \n"
                            "   0,                              \n"
                            "   0,                              \n"
                            "   0,                              \n"
                            "   0,                              \n"
                            "   0,                              \n"
                            "   0                               \n"
                            "FROM                               \n"
                            "   PF_TARIFICADAS                  \n"
                            "WHERE                              \n"
                            "COD_CLIENTE = :lhCodCliente        \n" 
                            "AND NUM_ABONADO = :lNumAbonado     \n" 
                            "AND %s                             \n"
                            "ORDER  BY FEC_INITASA                "
                            ,szWhere); 

        vDTrazasLog(szModulo,"QRY  : QUERY PARA LLAMADAS %s"
                             "QRY  : PF_TARIFICADAS -(\n%s\n)-"
                             "WHERE: PF_TARIFICADAS(\n%s\n)"
                             ,LOG04,szTipLlam,szCadenaSQL,szWhere);

        /* EXEC SQL PREPARE sql_DetCelular FROM :szCadenaSQL; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )969;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
        sqlstm.sqhstl[0] = (unsigned long )25000;
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
            vDTrazasLog  (szModulo,"\n\t**  Error en SQL-PREPARE sql_DetCelular **"
                                   "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szModulo,"\n\t**  Error en SQL-PREPARE sql_DetCelular **"
                                   "\nQuery =>[%s] \n \t\t=> Error : [%d]  [%s] ",LOG01,szCadenaSQL,SQLCODE,SQLERRM);
            exit(1);
        }

        /* EXEC SQL DECLARE curDetCelular CURSOR FOR sql_DetCelular; */ 

        if (SQLCODE != SQLOK)
        {
            vDTrazasLog  (szModulo,"\n\t**  Error en SQL-DECLARE curDetCelular **"
                                        "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szModulo,"\n\t**  Error en SQL-DECLARE curDetCelular **"
                                        "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return  (SQLCODE);
        }

        /* EXEC SQL OPEN curDetCelular USING :lhCodCliente, :lhNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )988;
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
    else /* TOL */
    {
        switch (iTipLlam)
        {
            case iTIPLLAMADAS_LOCALES:
                sprintf(szWhere,"LLAMADAS_LOCALES\0");
                strcpy(szTipLlam,"LOCALES");
                break;
            case iTIPLLAMADAS_INTERZONA:
                sprintf(szWhere,"LLAMADAS_INTERZONA\0");
                strcpy(szTipLlam,"INTERZONA");
                break;
            case iTIPLLAMADAS_LDI:
                sprintf(szWhere,"LLAMADAS_LDI");
                strcpy(szTipLlam,"LDI");
                break;
            case iTIPLLAMADAS_ESPECIALES:
                sprintf(szWhere,"LLAMADAS_ESPECIALES\0");
                strcpy(szTipLlam,"ESPECIALES");
                break;
            case iTIPLLAMADAS_ESPECIALES_DATA:
                sprintf(szWhere,"LLAMADAS_ESPECIALES_DATA\0");
                strcpy(szTipLlam,"ESPECIALES DATA");
                break;
            case iTIPLLAMADAS_TARIFA_ADICIONAL:
                sprintf(szWhere,"LLAMADAS_TARIFA_ADICIONAL\0");
                strcpy(szTipLlam,"TARIFA_ADICIONAL");
                break;
        }
        vDTrazasLog(szModulo,"\n\t**WHERE: PF_TOLTARIFICA[%s]\n",LOG04,szWhere);

        strcpy (szhDWhere, szWhere);

        /* EXEC SQL OPEN Cur_TolTarifica_2 USING :szhFormatoFecha, :szhFormatoHora, :lCodCliente, :lNumAbonado; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1011;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFormatoFecha;
        sqlstm.sqhstl[0] = (unsigned long )22;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFormatoHora;
        sqlstm.sqhstl[1] = (unsigned long )9;
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
        sqlstm.sqhstv[3] = (unsigned char  *)&lNumAbonado;
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

    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN CURSOR curDetCelular **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN CURSOR curDetCelular **"
                                    "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return  (SQLCODE);
    }

    return (SQLCODE);
}/*****************  Final de ifnOpenDetCelular  ********************/

/**************************************************************************************/
/* FUNCION     : ifnFetchDetCelular                                                   */
/* DESCRIPCION : Lee Cursor Cur_Toltarifica_2                                         */
/**************************************************************************************/
int ifnFetchDetCelular(DETLLAMADAS_HOSTS  *pstLlamadasTASHost, int * piNumFilas,int iTasador)
{

    vDTrazasLog  ("ifnFetchDetCelular","\n\t** iTasador  : [%d] ",LOG05,iTasador);

    /* EXEC SQL FETCH Cur_TolTarifica_2
             INTO
                :pstLlamadasTASHost->szCodRegistro    ,
                :pstLlamadasTASHost->szSec_Empa       ,
                :pstLlamadasTASHost->szSec_Cdr        ,
                :pstLlamadasTASHost->szFecIniTasa     ,
                :pstLlamadasTASHost->szTieIniLlam     ,
                :pstLlamadasTASHost->szNumMovil1      ,
                :pstLlamadasTASHost->szNumMovil2      ,
                :pstLlamadasTASHost->dImpLocal1       ,
                :pstLlamadasTASHost->dImpLarga2       ,
                :pstLlamadasTASHost->szCodFranHoraSoc ,
                :pstLlamadasTASHost->szCodAlm         ,
                :pstLlamadasTASHost->szDesMovil2      ,
                :pstLlamadasTASHost->szDurLocal1      ,
                :pstLlamadasTASHost->szDurLarga2      ,
                :pstLlamadasTASHost->szIndEntSal1     ,
                :pstLlamadasTASHost->dMto_Real        ,
                :pstLlamadasTASHost->dMto_Dcto        ,
                :pstLlamadasTASHost->iDur_Real        ,
                :pstLlamadasTASHost->iDur_Dcto        ,
                :pstLlamadasTASHost->iCod_Carg        ,
                :pstLlamadasTASHost->szCodFCob        ,
                :pstLlamadasTASHost->dValorUndad      ,
                :pstLlamadasTASHost->szCodTdir        ,
                :pstLlamadasTASHost->CodOperB         ,
                :pstLlamadasTASHost->szCodMarca       ,
                :pstLlamadasTASHost->szIndImpresion   ,
                :pstLlamadasTASHost->lCodConcCarrier  ,
                :pstLlamadasTASHost->lNumPulsos       ,
                :pstLlamadasTASHost->szRecordType     ,
                :pstLlamadasTASHost->szCodDcto        ,
                :pstLlamadasTASHost->szTipDcto        ,
                :pstLlamadasTASHost->dValorUnidad     ,
                :pstLlamadasTASHost->szDesLlamada     ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )5000;
    sqlstm.offset = (unsigned int  )1042;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstLlamadasTASHost->szCodRegistro);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstLlamadasTASHost->szSec_Empa);
    sqlstm.sqhstl[1] = (unsigned long )30;
    sqlstm.sqhsts[1] = (         int  )30;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstLlamadasTASHost->szSec_Cdr);
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )6;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstLlamadasTASHost->szFecIniTasa);
    sqlstm.sqhstl[3] = (unsigned long )16;
    sqlstm.sqhsts[3] = (         int  )16;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(pstLlamadasTASHost->szTieIniLlam);
    sqlstm.sqhstl[4] = (unsigned long )7;
    sqlstm.sqhsts[4] = (         int  )7;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(pstLlamadasTASHost->szNumMovil1);
    sqlstm.sqhstl[5] = (unsigned long )20;
    sqlstm.sqhsts[5] = (         int  )20;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(pstLlamadasTASHost->szNumMovil2);
    sqlstm.sqhstl[6] = (unsigned long )20;
    sqlstm.sqhsts[6] = (         int  )20;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(pstLlamadasTASHost->dImpLocal1);
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )sizeof(double);
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)(pstLlamadasTASHost->dImpLarga2);
    sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[8] = (         int  )sizeof(double);
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqharc[8] = (unsigned long  *)0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)(pstLlamadasTASHost->szCodFranHoraSoc);
    sqlstm.sqhstl[9] = (unsigned long )6;
    sqlstm.sqhsts[9] = (         int  )6;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqharc[9] = (unsigned long  *)0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)(pstLlamadasTASHost->szCodAlm);
    sqlstm.sqhstl[10] = (unsigned long )4;
    sqlstm.sqhsts[10] = (         int  )4;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqharc[10] = (unsigned long  *)0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)(pstLlamadasTASHost->szDesMovil2);
    sqlstm.sqhstl[11] = (unsigned long )31;
    sqlstm.sqhsts[11] = (         int  )31;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqharc[11] = (unsigned long  *)0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)(pstLlamadasTASHost->szDurLocal1);
    sqlstm.sqhstl[12] = (unsigned long )7;
    sqlstm.sqhsts[12] = (         int  )7;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqharc[12] = (unsigned long  *)0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)(pstLlamadasTASHost->szDurLarga2);
    sqlstm.sqhstl[13] = (unsigned long )7;
    sqlstm.sqhsts[13] = (         int  )7;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
    sqlstm.sqharc[13] = (unsigned long  *)0;
    sqlstm.sqadto[13] = (unsigned short )0;
    sqlstm.sqtdso[13] = (unsigned short )0;
    sqlstm.sqhstv[14] = (unsigned char  *)(pstLlamadasTASHost->szIndEntSal1);
    sqlstm.sqhstl[14] = (unsigned long )6;
    sqlstm.sqhsts[14] = (         int  )6;
    sqlstm.sqindv[14] = (         short *)0;
    sqlstm.sqinds[14] = (         int  )0;
    sqlstm.sqharm[14] = (unsigned long )0;
    sqlstm.sqharc[14] = (unsigned long  *)0;
    sqlstm.sqadto[14] = (unsigned short )0;
    sqlstm.sqtdso[14] = (unsigned short )0;
    sqlstm.sqhstv[15] = (unsigned char  *)(pstLlamadasTASHost->dMto_Real);
    sqlstm.sqhstl[15] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[15] = (         int  )sizeof(double);
    sqlstm.sqindv[15] = (         short *)0;
    sqlstm.sqinds[15] = (         int  )0;
    sqlstm.sqharm[15] = (unsigned long )0;
    sqlstm.sqharc[15] = (unsigned long  *)0;
    sqlstm.sqadto[15] = (unsigned short )0;
    sqlstm.sqtdso[15] = (unsigned short )0;
    sqlstm.sqhstv[16] = (unsigned char  *)(pstLlamadasTASHost->dMto_Dcto);
    sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[16] = (         int  )sizeof(double);
    sqlstm.sqindv[16] = (         short *)0;
    sqlstm.sqinds[16] = (         int  )0;
    sqlstm.sqharm[16] = (unsigned long )0;
    sqlstm.sqharc[16] = (unsigned long  *)0;
    sqlstm.sqadto[16] = (unsigned short )0;
    sqlstm.sqtdso[16] = (unsigned short )0;
    sqlstm.sqhstv[17] = (unsigned char  *)(pstLlamadasTASHost->iDur_Real);
    sqlstm.sqhstl[17] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[17] = (         int  )sizeof(int);
    sqlstm.sqindv[17] = (         short *)0;
    sqlstm.sqinds[17] = (         int  )0;
    sqlstm.sqharm[17] = (unsigned long )0;
    sqlstm.sqharc[17] = (unsigned long  *)0;
    sqlstm.sqadto[17] = (unsigned short )0;
    sqlstm.sqtdso[17] = (unsigned short )0;
    sqlstm.sqhstv[18] = (unsigned char  *)(pstLlamadasTASHost->iDur_Dcto);
    sqlstm.sqhstl[18] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[18] = (         int  )sizeof(int);
    sqlstm.sqindv[18] = (         short *)0;
    sqlstm.sqinds[18] = (         int  )0;
    sqlstm.sqharm[18] = (unsigned long )0;
    sqlstm.sqharc[18] = (unsigned long  *)0;
    sqlstm.sqadto[18] = (unsigned short )0;
    sqlstm.sqtdso[18] = (unsigned short )0;
    sqlstm.sqhstv[19] = (unsigned char  *)(pstLlamadasTASHost->iCod_Carg);
    sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[19] = (         int  )sizeof(int);
    sqlstm.sqindv[19] = (         short *)0;
    sqlstm.sqinds[19] = (         int  )0;
    sqlstm.sqharm[19] = (unsigned long )0;
    sqlstm.sqharc[19] = (unsigned long  *)0;
    sqlstm.sqadto[19] = (unsigned short )0;
    sqlstm.sqtdso[19] = (unsigned short )0;
    sqlstm.sqhstv[20] = (unsigned char  *)(pstLlamadasTASHost->szCodFCob);
    sqlstm.sqhstl[20] = (unsigned long )6;
    sqlstm.sqhsts[20] = (         int  )6;
    sqlstm.sqindv[20] = (         short *)0;
    sqlstm.sqinds[20] = (         int  )0;
    sqlstm.sqharm[20] = (unsigned long )0;
    sqlstm.sqharc[20] = (unsigned long  *)0;
    sqlstm.sqadto[20] = (unsigned short )0;
    sqlstm.sqtdso[20] = (unsigned short )0;
    sqlstm.sqhstv[21] = (unsigned char  *)(pstLlamadasTASHost->dValorUndad);
    sqlstm.sqhstl[21] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[21] = (         int  )sizeof(double);
    sqlstm.sqindv[21] = (         short *)0;
    sqlstm.sqinds[21] = (         int  )0;
    sqlstm.sqharm[21] = (unsigned long )0;
    sqlstm.sqharc[21] = (unsigned long  *)0;
    sqlstm.sqadto[21] = (unsigned short )0;
    sqlstm.sqtdso[21] = (unsigned short )0;
    sqlstm.sqhstv[22] = (unsigned char  *)(pstLlamadasTASHost->szCodTdir);
    sqlstm.sqhstl[22] = (unsigned long )6;
    sqlstm.sqhsts[22] = (         int  )6;
    sqlstm.sqindv[22] = (         short *)0;
    sqlstm.sqinds[22] = (         int  )0;
    sqlstm.sqharm[22] = (unsigned long )0;
    sqlstm.sqharc[22] = (unsigned long  *)0;
    sqlstm.sqadto[22] = (unsigned short )0;
    sqlstm.sqtdso[22] = (unsigned short )0;
    sqlstm.sqhstv[23] = (unsigned char  *)(pstLlamadasTASHost->CodOperB);
    sqlstm.sqhstl[23] = (unsigned long )6;
    sqlstm.sqhsts[23] = (         int  )6;
    sqlstm.sqindv[23] = (         short *)0;
    sqlstm.sqinds[23] = (         int  )0;
    sqlstm.sqharm[23] = (unsigned long )0;
    sqlstm.sqharc[23] = (unsigned long  *)0;
    sqlstm.sqadto[23] = (unsigned short )0;
    sqlstm.sqtdso[23] = (unsigned short )0;
    sqlstm.sqhstv[24] = (unsigned char  *)(pstLlamadasTASHost->szCodMarca);
    sqlstm.sqhstl[24] = (unsigned long )7;
    sqlstm.sqhsts[24] = (         int  )7;
    sqlstm.sqindv[24] = (         short *)0;
    sqlstm.sqinds[24] = (         int  )0;
    sqlstm.sqharm[24] = (unsigned long )0;
    sqlstm.sqharc[24] = (unsigned long  *)0;
    sqlstm.sqadto[24] = (unsigned short )0;
    sqlstm.sqtdso[24] = (unsigned short )0;
    sqlstm.sqhstv[25] = (unsigned char  *)(pstLlamadasTASHost->szIndImpresion);
    sqlstm.sqhstl[25] = (unsigned long )3;
    sqlstm.sqhsts[25] = (         int  )3;
    sqlstm.sqindv[25] = (         short *)0;
    sqlstm.sqinds[25] = (         int  )0;
    sqlstm.sqharm[25] = (unsigned long )0;
    sqlstm.sqharc[25] = (unsigned long  *)0;
    sqlstm.sqadto[25] = (unsigned short )0;
    sqlstm.sqtdso[25] = (unsigned short )0;
    sqlstm.sqhstv[26] = (unsigned char  *)(pstLlamadasTASHost->lCodConcCarrier);
    sqlstm.sqhstl[26] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[26] = (         int  )sizeof(long);
    sqlstm.sqindv[26] = (         short *)0;
    sqlstm.sqinds[26] = (         int  )0;
    sqlstm.sqharm[26] = (unsigned long )0;
    sqlstm.sqharc[26] = (unsigned long  *)0;
    sqlstm.sqadto[26] = (unsigned short )0;
    sqlstm.sqtdso[26] = (unsigned short )0;
    sqlstm.sqhstv[27] = (unsigned char  *)(pstLlamadasTASHost->lNumPulsos);
    sqlstm.sqhstl[27] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[27] = (         int  )sizeof(long);
    sqlstm.sqindv[27] = (         short *)0;
    sqlstm.sqinds[27] = (         int  )0;
    sqlstm.sqharm[27] = (unsigned long )0;
    sqlstm.sqharc[27] = (unsigned long  *)0;
    sqlstm.sqadto[27] = (unsigned short )0;
    sqlstm.sqtdso[27] = (unsigned short )0;
    sqlstm.sqhstv[28] = (unsigned char  *)(pstLlamadasTASHost->szRecordType);
    sqlstm.sqhstl[28] = (unsigned long )3;
    sqlstm.sqhsts[28] = (         int  )3;
    sqlstm.sqindv[28] = (         short *)0;
    sqlstm.sqinds[28] = (         int  )0;
    sqlstm.sqharm[28] = (unsigned long )0;
    sqlstm.sqharc[28] = (unsigned long  *)0;
    sqlstm.sqadto[28] = (unsigned short )0;
    sqlstm.sqtdso[28] = (unsigned short )0;
    sqlstm.sqhstv[29] = (unsigned char  *)(pstLlamadasTASHost->szCodDcto);
    sqlstm.sqhstl[29] = (unsigned long )6;
    sqlstm.sqhsts[29] = (         int  )6;
    sqlstm.sqindv[29] = (         short *)0;
    sqlstm.sqinds[29] = (         int  )0;
    sqlstm.sqharm[29] = (unsigned long )0;
    sqlstm.sqharc[29] = (unsigned long  *)0;
    sqlstm.sqadto[29] = (unsigned short )0;
    sqlstm.sqtdso[29] = (unsigned short )0;
    sqlstm.sqhstv[30] = (unsigned char  *)(pstLlamadasTASHost->szTipDcto);
    sqlstm.sqhstl[30] = (unsigned long )6;
    sqlstm.sqhsts[30] = (         int  )6;
    sqlstm.sqindv[30] = (         short *)0;
    sqlstm.sqinds[30] = (         int  )0;
    sqlstm.sqharm[30] = (unsigned long )0;
    sqlstm.sqharc[30] = (unsigned long  *)0;
    sqlstm.sqadto[30] = (unsigned short )0;
    sqlstm.sqtdso[30] = (unsigned short )0;
    sqlstm.sqhstv[31] = (unsigned char  *)(pstLlamadasTASHost->dValorUnidad);
    sqlstm.sqhstl[31] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[31] = (         int  )sizeof(double);
    sqlstm.sqindv[31] = (         short *)0;
    sqlstm.sqinds[31] = (         int  )0;
    sqlstm.sqharm[31] = (unsigned long )0;
    sqlstm.sqharc[31] = (unsigned long  *)0;
    sqlstm.sqadto[31] = (unsigned short )0;
    sqlstm.sqtdso[31] = (unsigned short )0;
    sqlstm.sqhstv[32] = (unsigned char  *)(pstLlamadasTASHost->szDesLlamada);
    sqlstm.sqhstl[32] = (unsigned long )101;
    sqlstm.sqhsts[32] = (         int  )101;
    sqlstm.sqindv[32] = (         short *)0;
    sqlstm.sqinds[32] = (         int  )0;
    sqlstm.sqharm[32] = (unsigned long )0;
    sqlstm.sqharc[32] = (unsigned long  *)0;
    sqlstm.sqadto[32] = (unsigned short )0;
    sqlstm.sqtdso[32] = (unsigned short )0;
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

  /* P-MIX-09003 */      

    vDTrazasLog  ("ifnFetchDetCelular", "\n\t** SQLCODE         : [%d] "
                                        "\n\t** sqlca.sqlcode   : [%d] "
                                        "\n\t** sqlca.sqlerrd[2]: [%d] "
                                        ,LOG05,SQLCODE,sqlca.sqlcode,sqlca.sqlerrd[2]);

    if (sqlca.sqlcode == SQLOK)
    {
        vDTrazasLog  ("ifnFetchDetCelular","\n\t** Sale por if (SQLCODE == SQLOK) ",LOG05);
        *piNumFilas = TAM_HOSTS_PEQ_JEM;
    }
    else
    {
        vDTrazasLog  ("ifnFetchDetCelular","\n\t** Sale por else ",LOG01);
        if (sqlca.sqlcode == SQLNOTFOUND)
        {
            vDTrazasLog  ("ifnFetchDetCelular","\n\t** Sale por if (SQLCODE == SQLNOTFOUND) ",LOG05);
            *piNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ_JEM;
        }
    }

    vDTrazasLog  ("ifnFetchDetCelular","\n\t**  piNumFilas  : [%d] ",LOG03, *piNumFilas);

    return (SQLCODE);

}/********************  Final de ifnFetchDetCelular    ******************/

/**************************************************************************************/
/* FUNCION     : bfnCloseDetCelular                                                   */
/* DESCRIPCION : Cierra Cursor Cur_Toltarifica_2                                      */
/**************************************************************************************/
int bfnCloseDetCelular(int iTasador)
{
    strcpy (szModulo, "bfnCloseDetCelular");
    vDTrazasLog("","\n\t** Entrada en %s", LOG04,szModulo);

    /* EXEC SQL CLOSE Cur_TolTarifica_2 ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1189;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE != SQLOK)      {
        vDTrazasLog(szModulo, "\n\t\t Error al cerrar el Cursor DetCelular : %s", LOG01, SQLERRM);
        vDTrazasError(szModulo, "ERROR EN FETCH curDetCelular: %s - %s", LOG01,"Fetch=>Fa_DetCelular", SQLERRM );
        return (FALSE);
    }

    return (TRUE);
}/*********************  bfnCloseDetCelular   ***********************/

/***************************************************************************/
/* FUNCION     : bfnCargaTipoTraficoLD                                     */
/* DESCRIPCION : Recupera Parametros de Tipo de LLamada Larga Distancia    */
/***************************************************************************/
BOOL     bfnCargaTipoTraficoLD(void)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhCod_TipoTraficoLD [20];
         char szhNom_TipoTraficoLD [20];
         char szhDes_TipoTraficoLD [50];
    /* EXEC SQL END DECLARE SECTION; */ 


    int   iNumTipoTrafico;

    /* EXEC SQL DECLARE Cursor_TipoTrafico CURSOR FOR
    SELECT
        NOM_PARAMETRO,
        VAL_PARAMETRO,
        DES_PARAMETRO
    FROM GED_PARAMETROS
    WHERE NOM_PARAMETRO IN ('LLAMADA_LD_04','LLAMADA_LD_03'); */ 


    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-DECLARE Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-DECLARE Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL OPEN Cursor_TipoTrafico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0009;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1204;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-OPEN Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-OPEN Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    iNumTipoTrafico = -1;
    for(;;)
    {
        /* EXEC SQL FETCH Cursor_TipoTrafico INTO :szhCod_TipoTraficoLD,
                                               :szhNom_TipoTraficoLD,
                                               :szhDes_TipoTraficoLD; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 33;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )1219;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)szhCod_TipoTraficoLD;
        sqlstm.sqhstl[0] = (unsigned long )20;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhNom_TipoTraficoLD;
        sqlstm.sqhstl[1] = (unsigned long )20;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhDes_TipoTraficoLD;
        sqlstm.sqhstl[2] = (unsigned long )50;
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



        if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
        {
            vDTrazasLog  (szModulo,"\n\t**  Error en SQL-FETCH Cursor_TipoTrafico **"
                                   "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            vDTrazasError(szModulo,"\n\t**  Error en SQL-FETCH Cursor_TipoTrafico **"
                                   "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
            return (FALSE);
        }
        if (SQLCODE == SQLNOTFOUND)
            break;

        if (iNumTipoTrafico == -1)
            iNumTipoTrafico = 0;

        strcpy(stTipoTrafico[iNumTipoTrafico].szCod_TipoTraficoLD,szhCod_TipoTraficoLD);
        strcpy(stTipoTrafico[iNumTipoTrafico].szNom_TipoTraficoLD,szhNom_TipoTraficoLD);
        strcpy(stTipoTrafico[iNumTipoTrafico].szDes_TipoTraficoLD,szhDes_TipoTraficoLD);
        iNumTipoTrafico++;
    }

    if (iNumTipoTrafico == -1)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-FETCH Cursor_Conceptos **"
                               "\n\t\t=> No existen los parámetros LLAMADA_LD_04 y LLAMADA_LD_03 en la tabla GED_PARAMETROS",LOG01);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-FETCH Cursor_Conceptos **"
                               "\n\t\t=> No existen los parámetros LLAMADA_LD_04 y LLAMADA_LD_03 en la tabla GED_PARAMETROS",LOG01);
        return (FALSE);
    }

    /* EXEC SQL CLOSE Cursor_TipoTrafico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1246;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE != SQLOK)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en SQL-CLOSE Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en SQL-CLOSE Cursor_TipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/*********************  bfnCargaTipoTraficoLD  ***********************/

/************************************************************************/
/* FUNCION : *szfnBuscaTipoTraficoLD                                    */
/* DESCRIPCION : Busca Parametros de Tipo de LLamada Larga Distancia    */
/************************************************************************/
char *szfnBuscaTipoTraficoLD(char *s)
{
    int  i                       ;
    char szhNom_TipoTraficoLD[20];
    char szhCod_TipoTraficoLD[20];

    sprintf(szhCod_TipoTraficoLD,"LLAMADA_LD_%s",s);

    strcpy(szhNom_TipoTraficoLD,"NN");
    for(i=0;i<MAX_TIPOS_LD;i++)
    {
        if (strcmp(szhCod_TipoTraficoLD,alltrim(stTipoTrafico[i].szCod_TipoTraficoLD))==0)
        {
            szhNom_TipoTraficoLD[0] = '\0';
            strcpy(szhNom_TipoTraficoLD,alltrim(stTipoTrafico[i].szNom_TipoTraficoLD));
            break;
        }
    }
    return(szhNom_TipoTraficoLD);
}/*********************  szfnBuscaTipoTraficoLD  ***********************/

/************************************************************************/
/* FUNCION     : bfnObtieneTotalporTipoTrafico                          */
/* DESCRIPCION : Obtiene Total por Tipo Trafico                         */
/************************************************************************/
BOOL bfnObtieneTotalporTipoTrafico(long   lCodCliente
                                  ,long   lNumAbonado
                                  ,long   lCodCiclFact
                                  ,int    iCodOperCarr
                                  ,char   *szCodTrafico
                                  ,long   *lSegundosTotal
                                  ,double *dNetoTotal)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long   lhCodCliente     ;
        long   lhNumAbonado     ;
        long   lhCodCiclFact    ;
        int    ihCodOperCarr    ;
        char   szhCodTrafico[20];
        long   lhSegundosTotal  ;
        double dhNetoTotal      ;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente = lCodCliente ;
    lhNumAbonado = lNumAbonado ;
    lhCodCiclFact = lCodCiclFact;
    ihCodOperCarr = iCodOperCarr;

    strcpy(szhCodTrafico,szCodTrafico);


    vDTrazasLog  (szModulo,"\n\t**  Parametros de bfnObtieneTotalporTipoTrafico\n"
                                   "lCodCliente         [%ld]\n"
                                   "lNumAbonado         [%ld]\n"
                                   "lCodCiclFact        [%ld]\n"
                                   "iCodOperCarr        [%d]\n"
                                   "szCodTrafico        [%s] \n"
                                   "szhCodTrafico       [%s] \n"
                                   "lSegundosTotal      [%ld]\n"
                                   "dNetoTotal          [%f] \n"
                                   ,LOG04
                                   ,lCodCliente
                                   ,lNumAbonado
                                   ,lCodCiclFact
                                   ,iCodOperCarr
                                   ,szCodTrafico
                                   ,szhCodTrafico
                                   ,lSegundosTotal
                                   ,dNetoTotal);

    /* EXEC SQL
    SELECT TOT_IMP_NETO, TOT_SEG_CONSUMIDO
      INTO :dhNetoTotal, :lhSegundosTotal
    FROM FA_SUBFORTAS_TO
    WHERE NUM_ABONADO  = :lhNumAbonado
      AND COD_PERIODO  = :lhCodCiclFact
      AND COD_OPERADOR = :ihCodOperCarr
      AND COD_TRAFICO  = :szhCodTrafico
      AND COD_CLIENTE  = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TOT_IMP_NETO ,TOT_SEG_CONSUMIDO into :b0,:b1  from\
 FA_SUBFORTAS_TO where ((((NUM_ABONADO=:b2 and COD_PERIODO=:b3) and COD_OPERAD\
OR=:b4) and COD_TRAFICO=:b5) and COD_CLIENTE=:b6)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1261;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhNetoTotal;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhSegundosTotal;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihCodOperCarr;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodTrafico;
    sqlstm.sqhstl[5] = (unsigned long )20;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en bfnObtieneTotalporTipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG04,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en bfnObtieneTotalporTipoTrafico **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG04,SQLCODE,SQLERRM);
        return (FALSE);
    }

    *lSegundosTotal = lhSegundosTotal;
    *dNetoTotal     = dhNetoTotal    ;

    return (TRUE);
}/*********************  bfnObtieneTotalporTipoTrafico  ***********************/

/************************************************************************/
/* FUNCION     : *szfnBuscaDescPortadora                                */
/* DESCRIPCION : Obtiene Descripcion de Operadora                       */
/************************************************************************/
char *szfnBuscaDescPortadora(int iCodOperador)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        int    ihCodOperador     ;
        char   szhDesOperador[31];
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCodOperador = iCodOperador;

    /* EXEC SQL
    SELECT RTRIM(LTRIM(A.DES_OPERADOR))
    INTO
        :szhDesOperador
    FROM TA_OPERADORES A,
         GA_OPECARRIER B
    WHERE B.COD_OPERADOR = :ihCodOperador
      AND A.COD_OPERADOR = B.COD_OPERADOR; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 33;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select RTRIM(LTRIM(A.DES_OPERADOR)) into :b0  from TA_OPE\
RADORES A ,GA_OPECARRIER B where (B.COD_OPERADOR=:b1 and A.COD_OPERADOR=B.COD_\
OPERADOR)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1304;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhDesOperador;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihCodOperador;
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



    if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
    {
        vDTrazasLog  (szModulo,"\n\t**  Error en szfnBuscaDescPortadora **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG04,SQLCODE,SQLERRM);
        vDTrazasError(szModulo,"\n\t**  Error en szfnBuscaDescPortadora **"
                               "\n\t\t=> Error : [%d]  [%s] ",LOG04,SQLCODE,SQLERRM);
        return ("Portador Desconocido");
    }
    if (SQLCODE == SQLNOTFOUND)
        return ("Portador Sin Descripción");

    return(szhDesOperador);
}/*********************  szfnBuscaDescPortadora  ***********************/


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

