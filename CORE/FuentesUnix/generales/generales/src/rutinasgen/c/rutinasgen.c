
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
    "./pc/rutinasgen.pc"
};


static unsigned int sqlctx = 13885051;


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
   unsigned char  *sqhstv[11];
   unsigned long  sqhstl[11];
            int   sqhsts[11];
            short *sqindv[11];
            int   sqinds[11];
   unsigned long  sqharm[11];
   unsigned long  *sqharc[11];
   unsigned short  sqadto[11];
   unsigned short  sqtdso[11];
} sqlstm = {12,11};

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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,63,0,4,46,0,0,1,0,0,1,0,2,5,0,0,
24,0,0,2,93,0,4,76,0,0,3,2,0,1,0,1,5,0,0,1,3,0,0,2,5,0,0,
51,0,0,3,280,0,4,131,0,0,11,1,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,3,0,0,
};


/****************************************************************************/
/* Programa :rutinasgen                                                     */
/* Fecha : 25/06/1999                                                       */
/* Autor : Mauricio Villagra  (& RBR)                                       */
/****************************************************************************/
#include "rutinasgen.h"
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


/****************************************************************************/
/*   funcion char* szGetEnv ( char VarHost )                                */
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
}

/****************************************************************************/
/*   funcion char* bfnSelectSysDate( char )                                 */
/****************************************************************************/
/*   Rutina que rescata la Hora y Fecha de Sistema                          */
/****************************************************************************/

BOOL bfnSelectSysDate (char* szFecSysDate)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char* pszhFecSysDate; /* EXEC SQL VAR pszhFecSysDate IS STRING (15); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    pszhFecSysDate = szFecSysDate;
    /* EXEC SQL SELECT TO_CHAR(SYSDATE,'yyyymmddhh24miss')
            INTO :pszhFecSysDate
            FROM DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 1;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR(SYSDATE,'yyyymmddhh24miss') into :b0  from\
 DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)pszhFecSysDate;
    sqlstm.sqhstl[0] = (unsigned long )15;
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
         return FALSE;
    }
    return TRUE;
}/************************* Final bGetSysDate ********************************/


/*****************************************************************************/
/*                      funcion : bSumaDias                                  */
/* -Funcion que Suma dias a Fecha1                                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bSumaDias (char *szFecha1,char *szFecha2,int iNumDias)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    static int  ihNumDias           ;
    static char szhFecha1[20]       ; /* EXEC SQL VAR szhFecha1 IS STRING(20); */ 

    static char szhFecha2[20]       ; /* EXEC SQL VAR szhFecha2 IS STRING(20) ; */ 

    /* EXEC SQL END DECLARE SECTION    ; */ 


    ihNumDias = iNumDias           ;
    strcpy (szhFecha2,szFecha2)    ;

/*    vDTrazasLog (szExeName,"\n\t\t* Suma Dias Fechas : %s +  %d \n",LOG05,szhFecha2,ihNumDias); */
    printf("\n\t\t* Suma Dias Fechas : %s +  %d \n",szhFecha2,ihNumDias);

    /* EXEC SQL
        SELECT TO_CHAR((TO_DATE (:szhFecha2,'YYYYMMDDHH24MISS') + :ihNumDias),'YYYYMMDDHH24MISS')
               INTO    :szhFecha1
        FROM    DUAL; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select TO_CHAR((TO_DATE(:b0,'YYYYMMDDHH24MISS')+:b1),'YYY\
YMMDDHH24MISS') into :b2  from DUAL ";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )24;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecha2;
    sqlstm.sqhstl[0] = (unsigned long )20;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&ihNumDias;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecha1;
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



    if (SQLCODE)
/*        iDError (szExeName,ERR000,vInsertarIncidencia,"Select Dual (bSumaDias)->",szfnORAerror()); */
        printf("\n\t\t ERR Select Dual (bSumaDias)-> %s",szhFecha1);

    if (SQLCODE == SQLOK)
        strcpy(szFecha1,szhFecha1);

    return (SQLCODE != 0)?FALSE:TRUE;
}/************************ Final bSumaDias    ********************************/



/*****************************************************************************/
/*                      funcion : bGetEnlaceHist                             */
/* -Funcion que Retorna Registro de FA_ENLACEHIST                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bGetEnlaceHist (ENLACEHIST *stEnlace)
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long    lhCodCiclFact        ;
    int     ihCodTipAlmac        ;
    char    szhDetCelular    [40];/* EXEC SQL VAR szhDetCelular     IS STRING(40); */ 

    char    szhDetRoaming    [40];/* EXEC SQL VAR szhDetRoaming     IS STRING(40); */ 

    char    szhDetFortas     [40];/* EXEC SQL VAR szhDetFortas      IS STRING(40); */ 

    char    szhDetAcumLlam   [40];/* EXEC SQL VAR szhDetAcumLlam    IS STRING(40); */ 

    char    szhDetCliente    [40];/* EXEC SQL VAR szhDetCliente     IS STRING(40); */ 

    char    szhDetAboCel     [40];/* EXEC SQL VAR szhDetAboCel      IS STRING(40); */ 

    char    szhDetAboBep     [40];/* EXEC SQL VAR szhDetAboBep      IS STRING(40); */ 

    char    szhDetDocumento  [40];/* EXEC SQL VAR szhDetDocumento   IS STRING(40); */ 

    char    szhDetConceptos  [40];/* EXEC SQL VAR szhDetConceptos   IS STRING(40); */ 

    short   s_ihCodTipAlmac  ;
    short   s_szhDetCelular  ;
    short   s_szhDetRoaming  ;
    short   s_szhDetFortas   ;
    short   s_szhDetAcumLlam ;
    short   s_szhDetCliente  ;
    short   s_szhDetAboCel   ;
    short   s_szhDetAboBep   ;
    short   s_szhDetDocumento;
    short   s_szhDetConceptos;
    /* EXEC SQL END DECLARE SECTION    ; */ 


    lhCodCiclFact = stEnlace->lCodCiclFact;

    if (lhCodCiclFact  == 0)
    {
/*        vDTrazasLog ("bGetEnlaceHist","\n\t\t* Codigo de Ciclo de Facturacion No Valido **",LOG01); */
        return (FALSE);
    }
    /* EXEC SQL
        SELECT  COD_TIPALMAC      ,
                FA_DETCELULAR     ,
                FA_DETROAMING     ,
                FA_DETFORTAS      ,
                FA_HISTACUMLLAM   ,
                FA_HISTCLIE       ,
                FA_HISTABOCELU    ,
                FA_HISTABOBEEP    ,
                FA_HISTDOCU       ,
                FA_HISTCONC
        into    :ihCodTipAlmac    :s_ihCodTipAlmac  ,
                :szhDetCelular    :s_szhDetCelular  ,
                :szhDetRoaming    :s_szhDetRoaming  ,
                :szhDetFortas     :s_szhDetFortas   ,
                :szhDetAcumLlam   :s_szhDetAcumLlam ,
                :szhDetCliente    :s_szhDetCliente  ,
                :szhDetAboCel     :s_szhDetAboCel   ,
                :szhDetAboBep     :s_szhDetAboBep   ,
                :szhDetDocumento  :s_szhDetDocumento,
                :szhDetConceptos  :s_szhDetConceptos
        FROM    FA_ENLACEHIST
        WHERE   COD_CICLFACT = :lhCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_TIPALMAC ,FA_DETCELULAR ,FA_DETROAMING ,FA_DET\
FORTAS ,FA_HISTACUMLLAM ,FA_HISTCLIE ,FA_HISTABOCELU ,FA_HISTABOBEEP ,FA_HISTD\
OCU ,FA_HISTCONC into :b0:b1,:b2:b3,:b4:b5,:b6:b7,:b8:b9,:b10:b11,:b12:b13,:b1\
4:b15,:b16:b17,:b18:b19  from FA_ENLACEHIST where COD_CICLFACT=:b20";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )51;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodTipAlmac;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)&s_ihCodTipAlmac;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDetCelular;
    sqlstm.sqhstl[1] = (unsigned long )40;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)&s_szhDetCelular;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhDetRoaming;
    sqlstm.sqhstl[2] = (unsigned long )40;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&s_szhDetRoaming;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhDetFortas;
    sqlstm.sqhstl[3] = (unsigned long )40;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&s_szhDetFortas;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhDetAcumLlam;
    sqlstm.sqhstl[4] = (unsigned long )40;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&s_szhDetAcumLlam;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhDetCliente;
    sqlstm.sqhstl[5] = (unsigned long )40;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)&s_szhDetCliente;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhDetAboCel;
    sqlstm.sqhstl[6] = (unsigned long )40;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&s_szhDetAboCel;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhDetAboBep;
    sqlstm.sqhstl[7] = (unsigned long )40;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&s_szhDetAboBep;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhDetDocumento;
    sqlstm.sqhstl[8] = (unsigned long )40;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)&s_szhDetDocumento;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhDetConceptos;
    sqlstm.sqhstl[9] = (unsigned long )40;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)&s_szhDetConceptos;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
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


    if (SQLCODE != SQLOK )
    {
/*        vDTrazasLog ("bGetEnlaceHist","\n\t\t* Codigo de Ciclo de Facturacion No Encontrado [%ld]**",LOG01,lhCodCiclFact);*/
        return (FALSE);

    }
    if (SQLCODE == SQLOK)
    {
        if ( s_ihCodTipAlmac    != ORA_NULL )
            stEnlace->iCodTipAlmac  = ihCodTipAlmac              ;
        else
            stEnlace->iCodTipAlmac  = 0;

        if ( s_szhDetCelular    != ORA_NULL )
            strcpy(stEnlace->szDetCelular   ,  szhDetCelular    );
        else
            strcpy(stEnlace->szDetCelular   ,  "");

        if ( s_szhDetRoaming    != ORA_NULL )
            strcpy(stEnlace->szDetRoaming   ,  szhDetRoaming    );
        else
            strcpy(stEnlace->szDetRoaming   ,  "");

        if ( s_szhDetFortas     != ORA_NULL )
            strcpy(stEnlace->szDetFortas    ,  szhDetFortas     );
        else
            strcpy(stEnlace->szDetFortas    ,  "");

        if ( s_szhDetAcumLlam   != ORA_NULL )
            strcpy(stEnlace->szDetAcumLlam  ,  szhDetAcumLlam   );
        else
            strcpy(stEnlace->szDetAcumLlam  ,  "");

        if ( s_szhDetCliente    != ORA_NULL )
            strcpy(stEnlace->szDetCliente   ,  szhDetCliente    );
        else
            strcpy(stEnlace->szDetCliente   ,  "");

        if ( s_szhDetAboCel     != ORA_NULL )
            strcpy(stEnlace->szDetAboCel    ,  szhDetAboCel     );
        else
            strcpy(stEnlace->szDetAboCel    ,  "");

        if ( s_szhDetAboBep     != ORA_NULL )
            strcpy(stEnlace->szDetAboBep    ,  szhDetAboBep     );
        else
            strcpy(stEnlace->szDetAboBep    ,  "");

        if ( s_szhDetDocumento  != ORA_NULL )
            strcpy(stEnlace->szDetDocumento ,  szhDetDocumento  );
        else
            strcpy(stEnlace->szDetDocumento ,  "");

        if ( s_szhDetConceptos  != ORA_NULL )
            strcpy(stEnlace->szDetConceptos ,  szhDetConceptos  );
        else
            strcpy(stEnlace->szDetConceptos ,  "");
    }
    return (SQLCODE != 0)?FALSE:TRUE;
}/************************ Final bRestaFechas ********************************/



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

/* **************************************************************************************** */ 
/*  bKillProc : Envia señal de termino forsado de ejecucion al proceso identificado PID     */
/*              -Valores Retorno : Error->FALSE, !Error->TRUE                               */
/*                  									    */
/* **************************************************************************************** */
BOOL bKillProc ( long lPidProc )
{
    char szComando [128]    =""     ;
    BOOL flagKill           =FALSE  ;

    sprintf(szComando,"kill -9 %ld \0", lPidProc );

    if ( system ( szComando ) == 0 )
        return 0;
    else
        return 1;


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

