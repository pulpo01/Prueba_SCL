
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
    "./pc/errores.pc"
};


static unsigned int sqlctx = 1728387;


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
5,0,0,1,716,0,6,69,0,0,11,11,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,
0,0,1,5,0,0,1,3,0,0,1,5,0,0,2,3,0,0,2,5,0,0,
64,0,0,2,88,0,4,590,0,0,3,1,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,
};


/*******************************************************************************
 Fichero    :  errores.c
 Descripcion:  Funcion de control de errores.

 Fecha      :  15-02-97
 Autor      :  Javier Garcia Paredes
*******************************************************************************/

#define _ERRORES_PC_

#include <errores.h>

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


/* -------------------------------------------------------------------------- */
/*   bInsertaAnomProceso (ANOMPROCESO*)                                       */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bInsertaAnomProceso (ANOMPROCESO* pAnomProc)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static int   ihCodConcepto      ;
   static short shCodProducto      ;
   static long  lhNumAbonado       ;
   static long  lhNumProceso       ;
   static long  lhCodCliente       ;
   static long  lhCodCiclFact      ;
   static int   ihCodAnomalia      ;
   static char  szhDesProceso  [41]; /* EXEC SQL VAR szhDesProceso  IS STRING (41); */ 

   static char  szhObsAnomalia [101]; /* EXEC SQL VAR szhObsAnomalia IS STRING (101); */ 

   static int   ihFlgError;
   static char  szhDesError    [251]; /* EXEC SQL VAR szhDesError IS STRING (251); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


   ihCodConcepto  = pAnomProc->iCodConcepto;
   lhNumProceso   = pAnomProc->lNumProceso ;
   lhCodCliente   = pAnomProc->lCodCliente ;
   lhCodCiclFact  = pAnomProc->lCodCiclFact;
   lhNumAbonado   = pAnomProc->lNumAbonado ;
   shCodProducto  = pAnomProc->iCodProducto;
   ihCodAnomalia  = pAnomProc->iCodAnomalia;

   strncpy (szhDesProceso,pAnomProc->szDesProceso,sizeof (szhDesProceso)-1);
   szhDesProceso [strlen (szhDesProceso)] = '\0';

   strncpy (szhObsAnomalia,pAnomProc->szObsAnomalia,sizeof(szhObsAnomalia)-1);
   szhObsAnomalia [strlen (szhObsAnomalia)] = '\0';

   lhNumProceso   = stStatus.IdPro;
   lhCodCliente   = stStatus.lCodCliActual;

   vDTrazasLog ("bInsertaAnomProceso","\n\t*** Registro insertado en FA_ANOPROCESO ***"
               "\n\tNumero de Proceso.............. [%ld]"
               "\n\tCodigo de Cliente.............. [%d] "
               "\n\tCodigo de Concepto............. [%d] "
               "\n\tCodigo de Producto............. [%d] "
               "\n\tCodigo de Ciclo Facturacion.... [%ld]"
               "\n\tDescripcion del Proceso........ [%s] "
               "\n\tObservaciones Anomalia......... [%s] "
               "\n\tNumero de Abonado.............. [%ld]"
               "\n\tCodigo de Anomalia............. [%d] "
               ,LOG04,lhNumProceso
               ,lhCodCliente        ,ihCodConcepto
               ,shCodProducto       ,lhCodCiclFact
               ,szhDesProceso       ,szhObsAnomalia
               ,lhNumAbonado        ,ihCodAnomalia);

    /* EXEC SQL EXECUTE
        DECLARE
            LS_regAnoProceso    fa_anoproceso%ROWTYPE;
        BEGIN
            LS_regAnoProceso.num_proceso  := :lhNumProceso;
            LS_regAnoProceso.cod_cliente  := NVL(:lhCodCliente,-1);
            LS_regAnoProceso.cod_concepto := :ihCodConcepto;
            LS_regAnoProceso.cod_producto := :shCodProducto;
            LS_regAnoProceso.cod_ciclfact := :lhCodCiclFact;
            LS_regAnoProceso.num_abonado  := :lhNumAbonado;
            LS_regAnoProceso.des_proceso  := NVL(:szhDesProceso, 'MAIN');
            LS_regAnoProceso.cod_anomalia := :ihCodAnomalia;
            LS_regAnoProceso.obs_anomalia := :szhObsAnomalia;
            FA_GESTION_ERRORES_PG.Fa_InsertaAnomalia_Pr(LS_regAnoProceso);
        EXCEPTION
            WHEN OTHERS THEN
                :ihFlgError  := 1;
                :szhDesError := SUBSTR(SQLERRM, 1, 100);
        END;
    END-EXEC; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "declare LS_regAnoProceso fa_anoproceso % ROWTYPE ; BEGIN \
LS_regAnoProceso . num_proceso := :lhNumProceso ; LS_regAnoProceso . cod_clien\
te := NVL ( :lhCodCliente , -1 ) ; LS_regAnoProceso . cod_concepto := :ihCodCo\
ncepto ; LS_regAnoProceso . cod_producto := :shCodProducto ; LS_regAnoProceso \
. cod_ciclfact := :lhCodCiclFact ; LS_regAnoProceso . num_abonado := :lhNumAbo\
nado ; LS_regAnoProceso . des_proceso := NVL ( :szhDesProceso , 'MAIN' ) ; LS_\
regAnoProceso . cod_anomalia := :ihCodAnomalia ; LS_regAnoProceso . obs_anomal\
ia := :szhObsAnomalia ; FA_GESTION_ERRORES_PG . Fa_InsertaAnomalia_Pr ( LS_reg\
AnoProceso ) ; EXCEPTION WHEN OTHERS THEN :ihFlgError := 1 ; :szhDesError := S\
UBSTR ( SQLERRM , 1 , 100 ) ; END ;";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
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
    sqlstm.sqhstv[3] = (unsigned char  *)&shCodProducto;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
    sqlstm.sqhstv[6] = (unsigned char  *)szhDesProceso;
    sqlstm.sqhstl[6] = (unsigned long )41;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodAnomalia;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhObsAnomalia;
    sqlstm.sqhstl[8] = (unsigned long )101;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihFlgError;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhDesError;
    sqlstm.sqhstl[10] = (unsigned long )251;
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



    if (ihFlgError == 1)
    {
        szhDesError [strlen (szhDesError)] = '\0';
        vDTrazasError ("bInsertaAnomProceso",szhDesError,LOG01);
        vDTrazasLog   ("bInsertaAnomProceso",szhDesError,LOG01);
    }
    return (ihFlgError != 0)?FALSE:TRUE;
}/************************** Final bInsertaAnoProceso ************************/

/* ----------------------------------------------------------------------------------- */
/* iDError (int,...)                                                                   */
/* Parametros: pszExeName      Nombre del programa que llama a vDTrazasLog             */
/*             iCode          Codigo de Error                                          */
/*             fnInsertAnom   Puntero a funcion de Insertar anomalias                  */
/*             ...            Parametros variables                                     */
/* Si la tabla de anomalias (FA_ANOMALIAS) no estuviera en memoria se                  */
/* accede directamente a la tabla.                                                     */
/* Modificación :                                                                      */
/*                 Proyecto    : Optimización del Facturador                           */
/*                 Fecha       : 22-12-2005                                            */
/*                 Autor       : Fabián Aedo R.                                        */
/*                 Descripción :                                                       */
/*                               Se incorpora lógica a la IdError que permitirá :      */
/*                                   - Manejar propagación de error                    */
/*                                   - Una tasa mínima de Errores                      */
/*                                   - Una cantidad mínima de errores consecutivos     */
/* ----------------------------------------------------------------------------------- */
int iDError(char* pszExeName,int iCode,void(*fnInsertAnom)(void),...)
{
 int        iSqlCode = SQLCODE    ;
 char       szMsgError[BUFSIZ*3]= "";
 ANOMALIAS  stAnomalia       ;
 va_list    ap;

    memset (&stAnomalia,0,sizeof(ANOMALIAS));

    if (!bFindAnomalias (iCode,&stAnomalia) )
         return FALSE;

    SQLCODE = iSqlCode       ;

    va_start(ap,fnInsertAnom);
    vsnprintf(szMsgError,BUFSIZ*3,stAnomalia.szDesAnomalia,ap);
    va_end  (ap);

    stAnomProceso.lCodCliente = stStatus.lCodCliActual;
    stAnomProceso.iCodAnomalia = iCode                                      ;

    strncpy (stAnomProceso.szObsAnomalia,szMsgError, sizeof(stAnomProceso.szObsAnomalia)-1)                         ;
    stAnomProceso.szObsAnomalia [strlen(stAnomProceso.szObsAnomalia)] = '\0';
    /* Graba en la traza el error recibido */

	vDTrazasLog(pszExeName,"\n\t*** Error Facturacion Cliente [%ld]***\n\t***[%s]***\n",LOG03, stAnomProceso.lCodCliente,stAnomProceso.szObsAnomalia);
	
    bInsertaAnomProceso(&stAnomProceso);
    if ( stStatus.lCodCliErr != stStatus.lCodCliActual )
    {
        /* Se cuenta errores concecutivos */
        stStatus.lConCliCons++;
        stStatus.lCodCliErr = stStatus.lCodCliActual;
        stStatus.lNumRegErr++;

        switch (stAnomalia.iIndGravedad)
        {
          case GRV0: /* Error Grave (Oracle): Finalizar */
                stStatus.ExitCode = -1  ;
                stStatus.ExitApp  = TRUE;  /* TRUE!=0 */
                vDTrazasError (pszExeName,szMsgError,LOG00);
                vDTrazasLog   (pszExeName,szMsgError,LOG00);
                break;
          case GRV1:/* Error Leve, Incidencia y continuar con siguiente registro.*/
                stStatus.SkipCode = iCode;
                stStatus.SkipRec  = TRUE ; /* TRUE!=0 */
                vDTrazasError (pszExeName,szMsgError,LOG01);
                vDTrazasLog   (pszExeName,szMsgError,LOG01);
                break;
          default:
                vDTrazasError (pszExeName,"Error, Indicador de Gravedad Desconocido.",LOG01);
                vDTrazasLog   (pszExeName,"Error, Indicador de Gravedad Desconocido.",LOG01);
                return TRUE;
        }

        /*Se evalua Mínimo de clientes para poder realizar evaluación*/
        if (stStatus.lNumReg >= stStatus.lCantCliMinEval && stStatus.lNumReg > 0)
        {
            /*Se re-calcula Tasa de Exito Observada*/
            stStatus.hTasaObservada =  (short )( ((stStatus.lNumReg - stStatus.lNumRegErr)*100) / stStatus.lNumReg );
            if ( stStatus.hTasaObservada <= stStatus.hTasaExitoMinReq )
            {
                /*error tasa no complida*/
                stStatus.ExitCode = -1  ;
                stStatus.ExitApp  = TRUE;  /* TRUE!=0 */
                vDTrazasError (pszExeName,"\n\t*** Error Grave ****"
                                          "\n\tEl proceso no cumple con la tasa de EXITO mínima requerida."
                                          "\n\tRegistros Processados     : [%ld]"
                                          "\n\tRegistros con Error       : [%ld]"
                                          "\n\tTasa de Exito Observada   : [%d] "
                                          "\n\tTasa de Exito Requerida   : [%d] ",
                                          stStatus.lNumReg,
                                          stStatus.lNumRegErr,
                                          stStatus.hTasaObservada,
                                          stStatus.hTasaExitoMinReq,
                                          LOG00);

                vDTrazasLog  (pszExeName,"\n\t*** Error Grave ****"
                                          "\n\tEl proceso no cumple con la tasa de EXITO mínima requerida."
                                          "\n\tRegistros Processados     : [%ld]"
                                          "\n\tRegistros con Error       : [%ld]"
                                          "\n\tTasa de Exito Observada   : [%d] "
                                          "\n\tTasa de Exito Requerida   : [%d] ",
                                          stStatus.lNumReg,
                                          stStatus.lNumRegErr,
                                          stStatus.hTasaObservada,
                                          stStatus.hTasaExitoMinReq,
                                          LOG00);
                strcpy(stAnomProceso.szObsAnomalia,"Error Grave. El proceso no cumple con la tasa de EXITO mínima requerida.");
                stAnomProceso.szObsAnomalia [strlen(stAnomProceso.szObsAnomalia)] = '\0';
                /* Graba en la traza el error modificado */
                bInsertaAnomProceso(&stAnomProceso);
            }
        }
        /* se evalua la cantidad de errores consecutivos... */
        if (stStatus.lConCliCons >= stStatus.lMaxCliConsError)
        {
            /*error tasa no complida*/
            stStatus.ExitCode = -1  ;
            stStatus.ExitApp  = TRUE;  /* TRUE!=0 */

            vDTrazasLog  (pszExeName,"\n\t*** Error Grave ****"
                                      "\n\tSe ha detectado una cantidad demasiado grande de errores consecutivos."
                                      "\n\tRegistros Processados               : [%ld]"
                                      "\n\tRegistros con Error Consecutivos    : [%ld]"
                                      "\n\tMáximo de Errores Consecutivos      : [%d] ",
                                      LOG00,
                                      stStatus.lNumReg,
                                      stStatus.lConCliCons,
                                      stStatus.lMaxCliConsError);

            vDTrazasError (pszExeName,"\n\t*** Error Grave ****"
                                      "\n\tSe ha detectado una cantidad demasiado grande de errores consecutivos."
                                      "\n\tRegistros Processados               : [%ld]"
                                      "\n\tRegistros con Error Consecutivos    : [%ld]"
                                      "\n\tMáximo de Errores Consecutivos      : [%d] ",
                                      LOG00,
                                      stStatus.lNumReg,
                                      stStatus.lConCliCons,
                                      stStatus.lMaxCliConsError);
            strcpy(stAnomProceso.szObsAnomalia,"Error Grave. Se ha detectado una cantidad demasiado grande de errores consecutivos.");
            stAnomProceso.szObsAnomalia [strlen(stAnomProceso.szObsAnomalia)] = '\0';
            /* Graba en la traza el error modificado */
            bInsertaAnomProceso(&stAnomProceso);
        }
    }
    return FALSE;
}/********************** Final iDError ***************************************/

/* ------------------------------------------------------------------------ */
/* vDTrazasLog (char*,char*,int,...)                                        */
/* Parametros: pszExeName      Nombre del programa que llama a vDTrazasLog   */
/*             szTxt          Texto a incluir el el fichero de log          */
/*             iNivel         Nivel de log                                  */
/* ------------------------------------------------------------------------ */
void vDTrazasLog (char* pszExeName,  char* szTxt, int iNivel,...)
{
 char szMsg[BUFSIZ*3]="";
 va_list ap;
 int iTrLog = 0;

 	iTrLog = (stStatus.LogFile == (FILE *)NULL)?0:1;

 	va_start (ap,szTxt);
 	vsnprintf(szMsg,BUFSIZ*3,szTxt,ap);
 	va_end(ap);

 if (iNivel <= stStatus.LogNivel)
 {
      switch (iNivel)
      {
        case LOG00:
         if (iTrLog)
                fprintf (stStatus.LogFile,"\n\tError Oracle (%s): %s\n",pszExeName,szMsg);
             else
                fprintf (stderr,"Error Oracle (%s): %s\n",pszExeName,szMsg);
         break;
    case LOG01:
         if (iTrLog)
            fprintf (stStatus.LogFile, "\n\tError (%s): %s\n",pszExeName,szMsg);
             else
                fprintf (stderr,"\n\tError (%s): %s\n",pszExeName,szMsg);
         break;
    case LOG02:
         if (iTrLog)
        fprintf (stStatus.LogFile,"\n\tAviso (%s): %s\n",pszExeName,szMsg);
             else
                fprintf (stderr,"Aviso (%s): %s\n",pszExeName,szMsg);
         break;
    case LOG03:
         if (iTrLog)
                fprintf (stStatus.LogFile,"\n%s",szMsg);
             else
                fprintf (stderr,"\n\t%s\n",szMsg);
         break;
        default:
         if (iTrLog)
        fprintf (stStatus.LogFile,"\n%s",szMsg);
             else
                fprintf (stderr,"\n\t%s\n",szMsg);
         break;
      }
    }
    

/* rao
 	if (iNivel <= stStatus.LogNivel)
 	{
      	switch (iNivel)
      	{
        	case LOG00:
                sprintf (szMsg,"\n\tError Oracle (%s): %s\n",pszExeName,szMsg);
         		break;
    		case LOG01:
           		sprintf (szMsg, "\n\tError (%s): %s\n",pszExeName,szMsg);
         		break;
    		case LOG02:
       			sprintf (szMsg, "\n\tAviso (%s): %s\n",pszExeName,szMsg);
         		break;
        	default:
       			sprintf (szMsg,"\n%s",szMsg);
         		break;
      	}
 		if (iTrLog)
			fprintf (stStatus.LogFile,"\n%s",szMsg);
     	else
        	fprintf (stderr,"\n\t%s\n",szMsg);
	}
*/


}/************************** Final vDTrazasLog ******************************/
/* ------------------------------------------------------------------------ */
/* vDTrazasLog (char*,char*,int,...)                                        */
/* Parametros: pszExeName      Nombre del programa que llama a vDTrazasLog   */
/*             szTxt          Texto a incluir el el fichero de log          */
/*             iNivel         Nivel de log                                  */
/* ------------------------------------------------------------------------ */
void vDTrazasLog_old (char* pszExeName,  char* szTxt, int iNivel,...)
{
    char szMsg[BUFSIZ*3]="";
    char buffer_local[BUFSIZ*3]="";
    va_list ap;

    szMsg[0]='\0';
    va_start (ap,szTxt);
    vsnprintf(szMsg,BUFSIZ*3,szTxt,ap);
    va_end(ap);

    if (iNivel <= stStatus.LogNivel)
    {
        switch (iNivel)
        {
            case LOG00:
                sprintf (buffer_local,"\n\tError Oracle (%s): %s",pszExeName,szMsg);
                break;
            case LOG01:
                sprintf (buffer_local, "\n\tError (%s): %s",pszExeName,szMsg);
                break;
            case LOG02:
                sprintf (buffer_local, "\n\tAviso (%s): %s",pszExeName,szMsg);
                break;
            default:
                sprintf (buffer_local,"\n%s",szMsg);
            break;
        }
    }
    if (!bfnEscribeArchivoLog(stStatus.LogFile, buffer_local ))
    {
        iDError(pszExeName, ERR000, vInsertarIncidencia, "\nError en Generación de Registro de Log\n");
    }
}/************************** Final vDTrazasLog ******************************/

/****************************************************************************/
/*                          funcion vDTrazasErr                             */
/* -Funcion que escribe los mensajes de Error en stStatus.ErrFile           */
/****************************************************************************/
void vDTrazasError (char *pszExeName,char *szTxt,int iNivel,...)
{
  char szMsg [BUFSIZ*3]="";
  va_list ap;

  iTrErr = ( stStatus.ErrFile == (FILE *)NULL )?0:1;

  va_start (ap,szTxt);
  vsnprintf (szMsg,BUFSIZ*3,szTxt,ap);
  va_end (ap);

  if (iNivel <= stStatus.LogNivel)
  {
      switch (iNivel)
      {
        case LOG00:
             if (iTrErr)
                fprintf (stStatus.ErrFile,"\n\tError Oracle (%s): %s\n",
                         pszExeName,szMsg);
             else 
                fprintf (stderr,"\n\tError Oracle (%s): %s\n",
                         pszExeName,szMsg);
             break;
        case LOG01:
             if (iTrErr)
                fprintf (stStatus.ErrFile,
                         "\n\tError (%s): %s\n",pszExeName,szMsg);
             else
                fprintf (stderr,"\n\tError (%s): %s\n",pszExeName,szMsg);
             break;
        case LOG02:
             if (iTrErr)
                fprintf (stStatus.ErrFile,
                         "\n\tAviso (%s): %s\n",pszExeName,szMsg);
             else
                fprintf (stderr,"\n\tAviso (%s): %s\n",pszExeName,szMsg);

             break;
        case LOG03:
             if (iTrErr)
                fprintf (stStatus.ErrFile,"\n%s",szMsg);
             else
                fprintf (stderr,"\n\t%s",szMsg);
             break;
        default:
             if (iTrErr)
                fprintf (stStatus.ErrFile,"%s\n",szMsg);
             else
                fprintf (stderr,"\n\t%s",szMsg);
             break;
      }
  }
}/************************ Final vDTrazasError ******************************/


/* ------------------------------------------------------------------------- */
/*   bOpenLog (char*)                                                        */
/*      Abre el fichero de Log                                               */
/*      Valores de Retorno: FALSE - Error                                    */
/*                          TRUE  - Ningun error                             */
/* ------------------------------------------------------------------------- */
BOOL bOpenLog (char *szFileName)
{
     char szComando [1024] = "";
     char szAux     [1024] = "";

     int  i = strlen (szFileName);

     while (i >= 0)
     {
        if (szFileName [i] == '/')
            break;
        else
            i--  ;
     }
     strcpy (szAux, szFileName);

     szAux [i+1] = 0;

     sprintf (szComando, "/usr/bin/mkdir -p %s", szAux);

     if (system (szComando))
     {
         iDError ("bOpenLog", ERR054, vInsertarIncidencia, szFileName);
         return  FALSE;
     }
     if((stStatus.LogFile=fopen(szFileName,"a"))==(FILE*)NULL)
         return FALSE;
     else
         return TRUE ;
}/*********************** Final bOpenLog *************************************/

/*****************************************************************************/
/*                         funcion : bOpenError                              */
/* -Funcion que abre el fichero de errores                                   */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bOpenError (char *szFileName)
{
     char szComando [1024] = "";
     char szAux     [1024] = "";

     int  i = strlen (szFileName);

     while (i >= 0)
     {
            if (szFileName [i] == '/')
                break;
            else
                i--  ;
     }
     strcpy (szAux, szFileName);

     szAux [i+1] = 0;

     sprintf (szComando, "/usr/bin/mkdir -p %s", szAux);

     if (system (szComando))
     {
         iDError ("bOpenError", ERR054, vInsertarIncidencia, szFileName);
         return  FALSE;
     }
     if ((stStatus.ErrFile = (FILE *)fopen (szFileName,"a") )==(FILE *)NULL)
          return FALSE;
     else
          return TRUE;
}/********************** Final bOpenError ************************************/

/* ------------------------------------------------------------------------- */
/*   bCloseLog (void)                                                        */
/*      Cierra el fichero de Log. Si no ha habido errores lo borra.          */
/*      Valores de Retorno: FALSE - Error                                    */
/*                          TRUE  - Ningun error                             */
/* ------------------------------------------------------------------------- */
BOOL bCloseLog (void)
{
    struct stat stStatLog;

    /* VACIA LO QUE QUEDE DE LOG... */
    if (!bfnEscribeArchivoLog(stStatus.LogFile, FLUSH))
    {
        fprintf(stderr, "\n\tError en FLUSH de Archivo de Log\n");
        return FALSE;
    }
    if(fclose(stStatus.LogFile))
        return FALSE;

    stat(stStatus.LogName,&stStatLog);

    if(stStatLog.st_size == 0)
        unlink (stStatus.LogName);
 return TRUE;
}/*********************** Final bCloseLog ************************************/


/*****************************************************************************/
/*                          funcion : bCloseError                            */
/* -Funcion que Cierra el fichero de Errores.Si no ha habido errores lo borra*/
/* -Valores Retorno :Error->FALSE,!Error->TRUE                               */
/*****************************************************************************/
BOOL bCloseError (void)
{
  struct stat stStatErr;

  if (fclose(stStatus.ErrFile))
      return FALSE;
  stat (stStatus.ErrName,&stStatErr);

  if (stStatErr.st_size == 0)
      unlink(stStatus.ErrName);
  return TRUE;
}/************************ Final bCloseError *********************************/
/*****************************************************************************/
/*                       funcion : bFindAnomalias                            */
/* -Funcion de busqueda de un reg. en pstAnomalias (Fa_Anomalias),con el pa- */
/*  rametro de entrada iCodAnomalia                                          */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bFindAnomalias (int iCodAnomalia, ANOMALIAS *pAnomalias)
{
  /* ANOMALIAS stkey;
  ANOMALIAS *pAnom = (ANOMALIAS *)NULL;
  */
  BOOL bRes = TRUE;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char szhDesAnomalia [61];/* EXEC SQL VAR szhDesAnomalia IS STRING(61); */ 

  static int  ihCodAnomalia     ;
  static int  ihIndGravedad     ;
  /* EXEC SQL END DECLARE SECTION  ; */ 

/*
  memset (&stkey,0,sizeof(ANOMALIAS));

  stkey.iCodAnomalia = iCodAnomalia;

  if (NUM_ANOMALIAS > 0)
  {
      if ( (pAnom = (ANOMALIAS *)bsearch (&stkey,pstAnomalias,NUM_ANOMALIAS,
                     sizeof(ANOMALIAS),iCmpAnomalias) )==(ANOMALIAS *)NULL)
      {
            iDError (pszExeName,ERR021,vInsertarIncidencia,
                     "pstAnomalias (Fa_Anomalias)");
            bRes = FALSE;
      }
      else
      {
          pAnomalias->iCodAnomalia = pAnom->iCodAnomalia          ;
          strcpy (pAnomalias->szDesAnomalia, pAnom->szDesAnomalia);
          pAnomalias->iIndGravedad = pAnom->iIndGravedad          ;
      }
  }
  else
  {
*/
      ihCodAnomalia = iCodAnomalia;

      /* EXEC SQL SELECT DES_ANOMALIA,
                      IND_GRAVEDAD
               INTO   :szhDesAnomalia,
                      :ihIndGravedad
               FROM   FA_ANOMALIAS
               WHERE  COD_ANOMALIA = :ihCodAnomalia; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 11;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select DES_ANOMALIA ,IND_GRAVEDAD into :b0,:b1  from FA\
_ANOMALIAS where COD_ANOMALIA=:b2";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )64;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhDesAnomalia;
      sqlstm.sqhstl[0] = (unsigned long )61;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&ihIndGravedad;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihCodAnomalia;
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


      if (SQLCODE)
      {
          vDTrazasLog ("bFindAnomalias","Error Oracle :Select=>Fa_Anomalias %s",
                        LOG01,szfnORAerror ());
          bRes = FALSE;
      }
      else
      {
          pAnomalias->iIndGravedad= ihIndGravedad;
          pAnomalias->iCodAnomalia = iCodAnomalia           ;
          strcpy (pAnomalias->szDesAnomalia, szhDesAnomalia);
      }

  return bRes;
}/*********************** Final bFindAnomalias *******************************/

/*****************************************************************************/
/*                        funcion : iCmpAnomalias                            */
/*****************************************************************************/
int iCmpAnomalias (const void *cad1, const void *cad2)
{
  int rc = 0;

  return
   ( (rc = ((ANOMALIAS *)cad1)->iCodAnomalia-
           ((ANOMALIAS *)cad2)->iCodAnomalia ) != 0)?rc:0;
}/*********************** Final iCmpAnomalias ********************************/

/*****************************************************************************/
/*                       funcion : vPrintAnomalias                           */
/*****************************************************************************/
void vPrintAnomalias (ANOMALIAS *pAnom, int iNumAnom)
{
  int iInd = 0;

  vDTrazasLog ("vPrintAnomalias","\n\t*** Tabla FA_ANOMALIAS ***\n",LOG06);

  for (iInd=0;iInd<60;iInd++)
  {
       vDTrazasLog ("vPrintAnomalias", "\n\t[%d]-CodAnomalia........[%d]"
						       		   "\n\t[%d]-Des.Anomalia.......[%s]"
						       		   "\n\t[%d]-Ind.Gravedad.......[%d]"
       						   		   , LOG06,iInd,pAnom->iCodAnomalia
       						   		   , iInd,pAnom->szDesAnomalia
       						   		   , iInd,pAnom->iIndGravedad );
       pAnom++;
  }
}/*********************** Final vPrintAnomalias ******************************/

void vInsertarIncidencia (void)
{
}
/*****************************************************************************/
/*                       funcion : bfnEscribeArchivoLog                      */
/*****************************************************************************/
BOOL bfnEscribeArchivoLog(FILE *Fd_ArchImp, char * buffer_local)
{
    int rc = 0;
    if(strncmp(buffer_local,FLUSH,strlen(FLUSH))==0)
    {
        if(strlen(stStatus.szBuffLog)>0)
        {
            rc = fprintf(Fd_ArchImp,"%s",stStatus.szBuffLog);
            if(rc<=0)
            {
                fprintf(stderr,"\n*******************FLUSH LOG***************************\n");
                fprintf(stderr,"\nError en funcion:[bfnEscribeArchivoLog]. RETORNO ERROR.\n");
                fprintf(stderr,"\n*******************************************************\n");
                return(FALSE);
            }
            memset(stStatus.szBuffLog,0,sizeof(stStatus.szBuffLog));
            stStatus.szBuffLog[0]='\0';
        }
    }
    else
    {
        buffer_local[strlen(buffer_local)]='\0';
        if((strlen(buffer_local) + strlen(stStatus.szBuffLog)) < MAX_BYTES_BUFFER)
        {
            strcat(stStatus.szBuffLog,buffer_local);
            stStatus.szBuffLog[strlen(stStatus.szBuffLog)]='\0';
        }
        else
        {
            rc = fprintf(Fd_ArchImp,"%s",stStatus.szBuffLog);
            if(rc<=0){
                fprintf(stderr,"\n*******************IMPRIME BUFFER DE LOG***************\n");
                fprintf(stderr,"\nError en funcion:[bfnEscribeArchivoLog]. RETORNO ERROR.\n");
                fprintf(stderr,"\n*******************************************************\n");
                return(FALSE);
            }
            memset(stStatus.szBuffLog,0,sizeof(stStatus.szBuffLog));
            stStatus.szBuffLog[0]='\0';
            strncpy(stStatus.szBuffLog,buffer_local, strlen(buffer_local));
            stStatus.szBuffLog[strlen(buffer_local)]=0;

        }
    }
    return (TRUE);
}/****************** Final bfnEscribeArchivoLog *******************/


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

