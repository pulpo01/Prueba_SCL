
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
           char  filnam[17];
};
static const struct sqlcxp sqlfpn =
{
    16,
    "./pc/PlanDcto.pc"
};


static unsigned int sqlctx = 3459763;


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
   unsigned char  *sqhstv[10];
   unsigned long  sqhstl[10];
            int   sqhsts[10];
            short *sqindv[10];
            int   sqinds[10];
   unsigned long  sqharm[10];
   unsigned long  *sqharc[10];
   unsigned short  sqadto[10];
   unsigned short  sqtdso[10];
} sqlstm = {12,10};

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
5,0,0,1,0,0,17,593,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,615,0,0,3,3,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,
51,0,0,1,0,0,13,633,0,0,8,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,5,0,0,2,3,
0,0,2,3,0,0,2,5,0,0,
98,0,0,1,0,0,15,658,0,0,0,0,0,1,0,
113,0,0,2,141,0,4,797,0,0,5,3,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
148,0,0,3,209,0,4,1045,0,0,6,2,0,1,0,2,3,0,0,2,3,0,0,2,9,0,0,2,9,0,0,1,3,0,0,1,
3,0,0,
187,0,0,4,363,0,4,1145,0,0,10,2,0,1,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,97,0,0,2,3,0,0,2,4,0,0,1,97,0,0,1,97,0,0,
242,0,0,5,173,0,4,1348,0,0,5,2,0,1,0,2,3,0,0,2,9,0,0,2,4,0,0,1,3,0,0,1,5,0,0,
277,0,0,6,156,0,4,1433,0,0,4,2,0,1,0,2,3,0,0,2,3,0,0,1,3,0,0,1,5,0,0,
308,0,0,7,216,0,4,1524,0,0,7,2,0,1,0,2,4,0,0,2,4,0,0,2,9,0,0,2,4,0,0,2,9,0,0,1,
3,0,0,1,5,0,0,
351,0,0,8,100,0,4,1870,0,0,3,2,0,1,0,1,97,0,0,1,97,0,0,2,3,0,0,
378,0,0,9,108,0,5,2753,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
401,0,0,10,100,0,4,3111,0,0,3,2,0,1,0,1,97,0,0,1,97,0,0,2,3,0,0,
428,0,0,11,0,0,17,3179,0,0,1,1,0,1,0,1,97,0,0,
447,0,0,11,0,0,45,3201,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
478,0,0,11,0,0,13,3219,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
509,0,0,11,0,0,15,3240,0,0,0,0,0,1,0,
};


/****************************************************************************/
/*  Fichero     : PlanDcto.pc                                               */
/*  Descripcion : Planes de Descuento                                       */
/*  Autor       : Guido Antio Cares                                         */
/****************************************************************************/

#define _DESCUENTOS_PC_

#include "PlanDcto.h"

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


char szEntidad[9];
long lgAbonado;
/* EXEC SQL BEGIN DECLARE SECTION; */ 

     char szhFmtFecha      [17]  ; /* EXEC SQL VAR szhFmtFecha  IS STRING(17); */ 

/* EXEC SQL END DECLARE SECTION; */ 


/*****************************************************************************/
/*  Funcion : bfnDescuentos                                                  */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
access BOOL bfnDescuentos (long lCliente, char *szFecParam)
{
    char         modulo[]             = "bfnDescuentos" ;
    double       dTotalMontoPrefactura= 0.0 ;
    register int ind_Abo, ind_Plan;
    int          x;
    int 	 i, j;			
    long	 lConceptoCargo;         
    long	 lColumnaCargo ;         
    long	 dImporteCargo ;         
    long 	 dAjuste;                
    long 	 dMtoDesc;               
    long 	 sw;                     
	
    vDTrazasLog (modulo,"\n\t\t*--> Plan de Descuento : Version %s Fecha Version %s.<---- *****"
                 ,LOG05,NUM_VERSION,FECHA_VERSION);

    stAnomProceso.lNumProceso  = stStatus.IdPro       ;
    stAnomProceso.lCodCliente  = stCliente.lCodCliente;
    stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact ;
    stAnomProceso.iCodConcepto = -1                   ;
    strcpy (stAnomProceso.szDesProceso ,"Descuentos") ;
    strcpy (stAnomProceso.szObsAnomalia,"")           ;
    indGrupo=0; /* INDICADOR DE PLANES GRUPALES */

    memset (&stPlanesDesc   ,0,sizeof (REGPLANES));
    memset (&stValDesc      ,0,sizeof (DESCUENTOS));
    memset (&stPlanesGrupo  ,0,sizeof (PLANESGRUPALES));
    
    memset (&stPlanesLoc    ,0,sizeof (PLANESLOCUTORIOS)); /* P-MIX-09003 */ 
    
    idxDesc =0; /* INDICE DE LA ESTRUCTURA DE DESCUENTOS */
    
    vDTrazasLog(modulo, "\n\t*** PLAN DESCUENTOS ***\n"
                        "\t\t*** Cliente        [%ld] ***\n"
                        "\t\t*** Ind. Locutorio [%d] ***\n"                        
                      , LOG05
                      , lCliente
                      , stCliente.iIndClieLoc);          
    
    if (stCliente.iIndClieLoc)
    {
        vDTrazasLog(modulo, "\n\t** Comienzo ejecución Planes Descuentos Locutorios ***\n"
                      , LOG05);    	
        if( !bfnCargaPlanDescLocutorio(lCliente) )
        {
            vDTrazasLog(modulo,"*** No se cargo Plan de Descuento para cliente Locutorio [%ld] ***",LOG05,lCliente);
            return(FALSE);
        }

        if (stPlanesLoc.lNumRegs > 0)
        {
            dTotalMontoPrefactura = dValidaMontoMinimo();

            if( !bfnDescBolsasClieLoc (szFecParam))
            {
                vDTrazasLog(modulo, "*** Error al aplicar descuentos Bolsa para Cliente Locutorio [%ld] ***"
                                  , LOG05, lCliente);
                return(FALSE);
            }

            if( !bfnDescporConceptoClieLoc (szFecParam))
            {
                vDTrazasLog(modulo, "*** Error al aplicar descuentos Concepto para cliente Locutorio [%ld] ***"
                                  , LOG05, lCliente);
                return(FALSE);
            }
        }
    }    
    else
    {   
        if( !bfnCargaPlanDesc(lCliente) )
        {
            vDTrazasLog(modulo,"*** No se cargo Plan de Descuento para cliente [%ld] ***",LOG05,lCliente);
            return(FALSE);
        }

        for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
        {
             vDTrazasLog (modulo, "\n\t\t*--> Abonado [%ld] con [%d] Planes de Descuento.<---- *****"
                                , LOG04
                                , stPlanesDesc.stAbonado[ind_Abo].lNumAbonado
                                , stPlanesDesc.stAbonado[ind_Abo].iNumPlanes);

             for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
             {
                  if( !bfnCargaDatosPlan  ( szFecParam,
                                            &stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD,
                                            stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szCod_Plandesc ) )
                  {
                      vDTrazasLog(modulo, "*** No se cargaron datos de Plan de Descuento %s para cliente %ld ***"
                                        , LOG05
                                        , stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szCod_Plandesc
                                        , lCliente);
                      return(FALSE);
                  }
                  else
                  {                                       
                      vDTrazasLog (modulo, "\n\t\t ModifBeneficios Entidad A o C Cli[%ld] Sec [%ld], Entidad[%s] "
                                         , LOG04
                                         , stCliente.lCodCliente
                                         , stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.lNumSecuencia
                                         , stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad);

                      if( !bModifBeneficios ( stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.lNumSecuencia) )
                      {
                          vDTrazasLog (modulo , "\n\t\t ModifBeneficios Entidad A o C RETURN FALSE. "
                                              , LOG03);
                          return(FALSE);
                      }
                  }
                  /* Cliente sin Plan Descuento */
                  if( strlen(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szCod_Plandesc)==0 )
                  {
                      return(TRUE);
                  }

                  /*rutina para mostrar registros de evaluacion*/
                  vPrintPlanDcto (&stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD);
             }
        }

        /*Validar monto */
        dTotalMontoPrefactura = dValidaMontoMinimo();
        /* y actualiza remanentes de cargo */
        dTotalMontoPrefacDesc = dActualizaDescuentos();

        vDTrazasLog (modulo,"\t\tTotal Monto Prefactura por [%f] ",LOG04,dTotalMontoPrefactura);

        if( indGrupo == 1 )/* Procesa Planes Grupales si existen */
        {
            vDTrazasLog (modulo,"\t\t** Planes Grupales **",LOG04);

            if( !bfnCargaPlanesGrupo () ) /* Carga a la estructura los Planes Grupo */
            {
                vDTrazasLog(modulo,"*** No se cargaron Planes de Descuento por Grupo para cliente [%ld] ***",LOG05,lCliente);
                return(FALSE);
            }

            if( !bfnDescporGrupo ( szFecParam, dTotalMontoPrefactura ) )
            {
                vDTrazasLog(modulo,"*** No se realizo Descuentos por Grupo para cliente [%ld] ***",LOG05,lCliente);
                return(FALSE);
            }

        }

        /* DESCUENTOS X CONCEPTO ABONADO*/
        vDTrazasLog(modulo,"DESCUENTOS X CONCEPTO ABONADO cliente [%ld] con [%d] Abonados",LOG05,lCliente, stPlanesDesc.lNumAbonados);
    
        for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
        {
             if( stPlanesDesc.stAbonado[ind_Abo].lNumAbonado > -1 )
             {
                 lgAbonado=stPlanesDesc.stAbonado[ind_Abo].lNumAbonado;
                 for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
                 {
                      if( strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.szCod_Tipapli,PORCONCEPTO)== 0
                      && strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad,TIPOENTABONA)  == 0 )
                      {
                         strcpy( szEntidad,stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad);
                         if( !bfnDescporConceptoAbonado( stPlanesDesc.stAbonado[ind_Abo].lNumAbonado,
                                                         &stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD,
                                                         szFecParam, dTotalMontoPrefactura) )
                         {
                             vDTrazasLog(modulo,"*** No se realizaron Descuentos por Concepto/Abonado cliente %ld ***",LOG05,lCliente);
                             return(FALSE);
                         }
                      }
                 }
             }
        }
    
        /* DESCUENTOS X FACTURA ABONADO*/
        vDTrazasLog(modulo,"DESCUENTOS X FACTURA ABONADO cliente [%ld] con [%d] Abonados",LOG05,lCliente, stPlanesDesc.lNumAbonados);
        for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
        {
             if( stPlanesDesc.stAbonado[ind_Abo].lNumAbonado > -1 )
             {
                 lgAbonado=stPlanesDesc.stAbonado[ind_Abo].lNumAbonado;
                 for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
                 {
                      if( strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.szCod_Tipeval,PORFACTURA) == 0
                      && strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad, TIPOENTABONA)    == 0 )
                      {
                         strcpy( szEntidad,stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad);
                         if( !bfnDescporConceptoAbonado  (stPlanesDesc.stAbonado[ind_Abo].lNumAbonado
                                                     ,&stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD
                                                     ,szFecParam, dTotalMontoPrefactura) )
                         {
                             vDTrazasLog(modulo,"*** No se realizaron Descuentos por Factura/Abonado cliente [%ld] ***",LOG03,lCliente);
                             return(FALSE);
                         }
                      }
                 }
             }
        }

        /* DESCUENTOS X CONCEPTO CLIENTE*/
        vDTrazasLog(modulo,"DESCUENTOS X CONCEPTO CLIENTE cliente [%ld] con [%d] Abonados",LOG05,lCliente, stPlanesDesc.lNumAbonados);
        for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
        {
             if( stPlanesDesc.stAbonado[ind_Abo].lNumAbonado == -1
             || stPlanesDesc.stAbonado[ind_Abo].lNumAbonado == 0 )
             {
                lgAbonado=stPlanesDesc.stAbonado[ind_Abo].lNumAbonado;
                for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
                {
                     if( strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.szCod_Tipapli,PORCONCEPTO)==0
                     && strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad, TIPOENTCLIEN)    == 0 )
                     {
                        strcpy( szEntidad,stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad);
                        if( !bfnDescporConceptoCliente  (stPlanesDesc.stAbonado[ind_Abo].lNumAbonado
                                                     ,&stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD
                                                     ,szFecParam, dTotalMontoPrefactura) )
                        {
                            vDTrazasLog(modulo,"*** No se realizaron Descuentos por Concepto/Cliente [%ld] ***",LOG05,lCliente);
                            return(FALSE);
                        }
                     }
                }
             }
        }

       /* DESCUENTOS X FACTURA CLIENTE */
       vDTrazasLog(modulo,"DESCUENTOS X FACTURA CLIENTE cliente [%d] con [%d] Abonados",LOG05,lCliente, stPlanesDesc.lNumAbonados);
       for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
       {
            lgAbonado=stPlanesDesc.stAbonado[ind_Abo].lNumAbonado;
            for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
            {
                 if( strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.szCod_Tipeval,PORFACTURA) == 0
                 && strcmp(stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad, TIPOENTCLIEN)    == 0 )
                 {
                    strcpy( szEntidad,stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].szTipEntidad);
                    if( !bfnDescporFacturaCliente (stPlanesDesc.stAbonado[ind_Abo].lNumAbonado
                                               ,&stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD
                                               ,szFecParam, dTotalMontoPrefactura) )
                    {
                        vDTrazasLog(modulo,"*** No se realizaron Descuentos por Factura/Cliente [%ld] ***",LOG05,lCliente);
                        return(FALSE);
                    }
                 }
            }
        }

    } /* P-MIX-09003 */

    /* Aplica Dctos. a stPrefactura */
    vDTrazasLog (modulo,"\n\tNro Descuentos [%d]",LOG04, stValDesc.iNumDescuentos);

    for( x=0;x < stValDesc.iNumDescuentos;x++ )
    {
        vDTrazasLog (modulo,"\n\t Descuentos #[%d]=[%c%.02lf] [%lf] [%d] [%s]"
                    ,LOG05, x, (stValDesc.stDescuentos[x].szTip_Descuento[0]=='P'?'%':'$')
                    ,stValDesc.stDescuentos[x].dVal_Descuento
                    ,stValDesc.stDescuentos[x].dValor_Monto
                    ,stValDesc.stDescuentos[x].iCod_Concepto
                    ,stValDesc.stDescuentos[x].szDescConcepto);
        if( !bCargaPreFactura ( stPreFactura.iNumRegistros, &stValDesc.stDescuentos[x]) )
        {
            vDTrazasLog(modulo,"*** No se Cargo prefactura cliente [%ld] ***",LOG05,lCliente);
            return(FALSE);
        }
    }

    for (i=0; i < stPreFactura.iNumRegistros; i++)
    {
         if ((stPreFactura.A_PFactura[i].iCodTipConce != 1) &&	/* 1 = IMPUESTOS */
             (stPreFactura.A_PFactura[i].iCodTipConce != 2))		/* 2 = DESCUENTOS */

         {
	      lConceptoCargo 	= stPreFactura.A_PFactura[i].iCodConcepto  ;
	      lColumnaCargo 	= stPreFactura.A_PFactura[i].lColumna    	;
	      dImporteCargo 	= stPreFactura.A_PFactura[i].dImpConcepto  ;
              dMtoDesc = 0;
	      sw = 0;
	      
	      for(j = 0; j < stPreFactura.iNumRegistros; j++)
	      {
		  if (stPreFactura.A_PFactura[j].iCodTipConce == 2)	/* 2 = DESCUENTOS */
		  {					
		      if ((lConceptoCargo == stPreFactura.A_PFactura[j].iCodConceRel  ) &&
			  (lColumnaCargo	== stPreFactura.A_PFactura[j].lColumnaRel   ))
                      {
                           if (sw == 1)
                           {
                               stPreFactura.A_PFactura[j].dImpConcepto  	= 0;
                               stPreFactura.A_PFactura[j].dImpMontoBase   = 0;
                               stPreFactura.A_PFactura[j].dImpFacturable  = 0;
                           }
                           else
                           {
                               dMtoDesc += stPreFactura.A_PFactura[j].dImpConcepto  ;
                               if (dImporteCargo <= (dMtoDesc * -1))
                               {
                                   dAjuste = (dMtoDesc * -1) - dImporteCargo;
                                   stPreFactura.A_PFactura[j].dImpConcepto  	+=  dAjuste;
                                   stPreFactura.A_PFactura[j].dImpMontoBase   +=  dAjuste;
                                   stPreFactura.A_PFactura[j].dImpFacturable  +=  dAjuste;								
                                   sw = 1;
				}
			   }
		      }
		  }
	      }
         }
    }

    /* Actualiza estado de ejecucion de Dctos en tabla de Beneficios */
    for( ind_Abo=0;ind_Abo < stPlanesDesc.lNumAbonados;ind_Abo++ )
    {
        for( ind_Plan=0;ind_Plan < stPlanesDesc.stAbonado[ind_Abo].iNumPlanes;ind_Plan++ )
        {
            if( stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.iCodEstado == 1 ) /* Dcto. aplicado */
            {
                vDTrazasLog (modulo,"\n\t\t ModifBeneficios [%ld] ",LOG05, stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.lNumSecuencia);
                if( !bModifBeneficios ( stPlanesDesc.stAbonado[ind_Abo].stPlanDes[ind_Plan].stPD.lNumSecuencia) )
                {
                    vDTrazasLog (modulo,"\n\t\t ModifBeneficios RETURN FALSE. ",LOG03);
                    return(FALSE);
                }
            }
        }
    }

    vDTrazasLog  (modulo,"\t***** Fin a la Funcion Plan de Descuentos *****", LOG04);
    return(TRUE);

}

/*****************************************************************************/
/*  Funcion : bfnCargaPlanDesc                                               */
/*****************************************************************************/
static BOOL bfnCargaPlanDesc (long       lCliente)
{
    char modulo[]   = "bfnCargaPlanDesc";
    int iOra;
    long lNumReg  = 0;
    register long  i = 0, ind_Abon =0, ind_Plan =0;
    long lpNumAbonado;

    static PLANDESCABO_HOSTS stGatPanDescAboHosts;
    static PLANDESCABO_HOSTS_NULL stGatPanDescAboNull;

    vDTrazasLog (modulo,"\n\t\t* Funcion %s ",LOG05,modulo);

    iOra= ifnOraDeclararGatPlanDescAbo (lCliente);
    if (iOra != SQLOK)
    {
        vDTrazasLog (modulo,"\n\t\tError declarar cursor GAT_PLANDESCABO SQLCODE [%ld]",LOG01, SQLCODE);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos", szfnORAerror());
        return(FALSE);
    }

    while (iOra != NOTFOUND)
    {
        iOra= ifnOraLeerGatPlanDescAbo(&stGatPanDescAboHosts, &stGatPanDescAboNull, &lNumReg);
        if (iOra != SQLOK  && iOra != NOTFOUND)
        {
            vDTrazasLog (modulo,"\n\t\tError al  realizar el FETCH sobre GAT_PLANDESCABO SQLCODE [%ld]",LOG01, SQLCODE);
            iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos", szfnORAerror());
            return FALSE;
        }

        if (!lNumReg)
            break;

        if (stPlanesDesc.lNumAbonados == 0)
        {   /* se inicializa */
            stPlanesDesc.stAbonado = (REGPLANABO*)malloc(sizeof(REGPLANABO));
            memset (&stPlanesDesc.stAbonado[0],0,sizeof (REGPLANABO));
            stPlanesDesc.lNumAbonados = 1;
            stPlanesDesc.stAbonado[ind_Abon].iNumPlanes = 0;
            lpNumAbonado = stGatPanDescAboHosts.lNumAbonado[i];
        }

        for( i=0;i<lNumReg;i++ )
        {
            if( lpNumAbonado!=stGatPanDescAboHosts.lNumAbonado[i] )
            {
                stPlanesDesc.lNumAbonados++;
                stPlanesDesc.stAbonado = (REGPLANABO*)realloc(stPlanesDesc.stAbonado,(stPlanesDesc.lNumAbonados)*sizeof(REGPLANABO));
                memset (&stPlanesDesc.stAbonado[stPlanesDesc.lNumAbonados-1],0,sizeof (REGPLANABO));
                stPlanesDesc.stAbonado[stPlanesDesc.lNumAbonados-1].iNumPlanes=0;
                lpNumAbonado=stGatPanDescAboHosts.lNumAbonado[i];
            }

            ind_Abon = stPlanesDesc.lNumAbonados -1 ;
            ind_Plan = stPlanesDesc.stAbonado[ind_Abon].iNumPlanes ;

            stPlanesDesc.stAbonado[ind_Abon].lNumAbonado = stGatPanDescAboHosts.lNumAbonado[i];

            strcpy(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szCod_Plandesc,stGatPanDescAboHosts.szCod_Plandesc[i]);
            stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].stPD.lNumSecuencia = stGatPanDescAboHosts.lNumSecuencia[i];

            if(stGatPanDescAboNull.sszTipEntidad[i]!= ORA_NULL)
                strcpy(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad,stGatPanDescAboHosts.szTipEntidad[i]);
            else
                strcpy(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad,"");

            if( strcmp(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad, TIPOENTGRUPO) == 0 )
            {   /* HABILITA INDICADOR DE PLANES DE GRUPO */
                indGrupo = 1;
            }

            vDTrazasLog (modulo,"\t\t\t=> Num. Abonado        : [%ld]**"
                              "\n\t\t\t=> Cod. Plan Descuento : [%s]**"
                              "\n\t\t\t=> Num. Secuencia      : [%ld]**"
                              "\n\t\t\t=> Tipo Entidad        : [%s]**"
                              ,LOG05,stPlanesDesc.stAbonado[ind_Abon].lNumAbonado
                              ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szCod_Plandesc
                              ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].stPD.lNumSecuencia
                              ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad);

            stPlanesDesc.stAbonado[ind_Abon].iNumPlanes++;
        }
    }

    iOra=ifnOraCerrarGatPlanDescAbo();
    if (iOra != SQLOK)
    {
        vDTrazasLog (modulo,"\n\t\tError al cerrar el cursor sobre GAT_PLANDESCABO SQLCODE [%ld]",LOG01, SQLCODE);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos", szfnORAerror());
        return FALSE;
    }

    return(TRUE);
}

/*****************************************************************************/
/*  Funcion : bfnCargaPlanDescLocutorio                                      */
/*****************************************************************************/
static BOOL bfnCargaPlanDescLocutorio (long lCliente)
{
    char modulo[]   = "bfnCargaPlanDescLocutorio";
    int iOra;
    long lNumReg  = 0;
    long  i = 0, ind_plan = 0;

    PLANDCTOLOC_HOST stDescLocHosts;

    vDTrazasLog (modulo,"\n\t\t* Funcion %s  - Cliente [%ld]",LOG05, modulo,lCliente);

    iOra= ifnOraDeclararFaDetDctoClieLoc (lCliente);
    if (iOra != SQLOK)
    {
        vDTrazasLog (modulo,"\n\t\tError al declarar cursor sobre FA_DETDCTOCLIELOC_TO SQLCODE [%ld]",LOG01, SQLCODE);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos Locutorios", szfnORAerror());
        return(FALSE);
    }

    stPlanesLoc.lNumRegs = 0;

    while (iOra != NOTFOUND)
    {
        iOra= ifnOraLeerGatPlanDescClieLoc(&stDescLocHosts, &lNumReg);
        if (iOra != SQLOK  && iOra != NOTFOUND)
        {
            vDTrazasLog (modulo,"\n\t\tError realizando FETCH sobre FA_DETDCTOCLIELOC_TO SQLCODE [%ld]",LOG01, SQLCODE);
            iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos Locutorios", szfnORAerror());
            return FALSE;
        }

        if (!lNumReg)
            break;

        if ((stPlanesLoc.stPlanLocutorio = (PLANDCTOLOC *)realloc ( (PLANDCTOLOC *)stPlanesLoc.stPlanLocutorio,
                                                           sizeof (PLANDCTOLOC) * (stPlanesLoc.lNumRegs+lNumReg) ))
                == (PLANDCTOLOC *)NULL)
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,
                     "stPlanesLoc.stPlanLocutorio");
            return FALSE;
        }

        ind_plan = stPlanesLoc.lNumRegs;

        for( i=0;i<lNumReg;i++ )
        {
            strcpy(stPlanesLoc.stPlanLocutorio[ind_plan].szCodPlandesc, stDescLocHosts.szCodPlandesc[i]);
            stPlanesLoc.stPlanLocutorio[ind_plan].iCodGrupoapli = stDescLocHosts.iCodGrupoapli[i];
            stPlanesLoc.stPlanLocutorio[ind_plan].iNumCuadrante = stDescLocHosts.iNumCuadrante[i];
            stPlanesLoc.stPlanLocutorio[ind_plan].dValorDcto    = stDescLocHosts.dValorDcto[i];
            strcpy(stPlanesLoc.stPlanLocutorio[ind_plan].szTipDescuento, stDescLocHosts.szTipDescuento[i]);
            stPlanesLoc.stPlanLocutorio[ind_plan].lNumSecuencia = stDescLocHosts.lNumSecuencia[i];
            stPlanesLoc.stPlanLocutorio[ind_plan].iCodEstado    = stDescLocHosts.iCodEstado[i];
            strcpy(stPlanesLoc.stPlanLocutorio[ind_plan].szTipEntidad, stDescLocHosts.szTipEntidad[i]);

            
            vDTrazasLog (modulo,"\n\t\t* Carga Planes locutorio  - Cliente [%ld]"
            					"\n\t\t\t szCodPlandesc  [%s] "
            					"\n\t\t\t iCodGrupoapli  [%d] "
            					"\n\t\t\t iNumCuadrante  [%d] "
            					"\n\t\t\t dValorDcto     [%f] "
            					"\n\t\t\t szTipDescuento [%s] "
            					"\n\t\t\t lNumSecuencia  [%ld] "
            					"\n\t\t\t iCodEstado     [%d] "
            					"\n\t\t\t szTipEntidad   [%s] "
            					,LOG05, lCliente
            					,stPlanesLoc.stPlanLocutorio[ind_plan].szCodPlandesc
            					,stPlanesLoc.stPlanLocutorio[ind_plan].iCodGrupoapli
            					,stPlanesLoc.stPlanLocutorio[ind_plan].iNumCuadrante
            					,stPlanesLoc.stPlanLocutorio[ind_plan].dValorDcto
            					,stPlanesLoc.stPlanLocutorio[ind_plan].szTipDescuento
            					,stPlanesLoc.stPlanLocutorio[ind_plan].lNumSecuencia
            					,stPlanesLoc.stPlanLocutorio[ind_plan].iCodEstado
            					,stPlanesLoc.stPlanLocutorio[ind_plan].szTipEntidad
            					);
            
            ind_plan++;
            stPlanesLoc.lNumRegs++;

    	}
    
    	vDTrazasLog (modulo,"\n\t\t* Carga Planes locutorio  - Cliente [%ld] - Total de descuentos Cargados [%ld]",LOG05, lCliente, stPlanesLoc.lNumRegs);
    }

    iOra=ifnOraCerrarGatPlanDescClieLoc();
    if (iOra != SQLOK)
    {
        vDTrazasLog (modulo,"\n\t\tError al cerrar el cursor sobre FA_DETDCTOCLIELOC_TO SQLCODE [%ld]",LOG01, SQLCODE);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos", szfnORAerror());
        return FALSE;
    }


    return(TRUE);
} /*    bfnCargaPlanDescLocutorio */

/******************************************************************************
Funcion         :       ifnOraDeclararGatPlanDescAbo
*******************************************************************************/

static int ifnOraDeclararFaDetDctoClieLoc (long lCodCliente)
{
    char    szCadena [512]="";
    char    szNomTabla [256]="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long lhCodCliente;
         int  ihZero;
         int  ihCodCiclo;
         long lhCodCiclFact;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente  = lCodCliente ;
    ihCodCiclo    = stCiclo.iCodCiclo;
    lhCodCiclFact = stCiclo.lCodCiclFact;
    ihZero        = 0;

    sprintf(szCadena," SELECT COD_PLANDESC   , \n"
                     "        COD_GRUPOAPLI  , \n"
                     "        NUM_CUADRANTE  , \n"
                     "        VALOR_DCTO     , \n"
                     "        TIP_DCTO       , \n"
                     "        NUM_SECUENCIA  , \n"
                     "        :ihZero        , \n"
                     "        TIP_ENTIDAD      \n");

    sprintf(szNomTabla," FROM FA_DETDCTOCLIELOC_%ld",lhCodCiclFact);

    strcat(szCadena,szNomTabla);

    strcat(szCadena, " WHERE COD_CLIENTE  = :lhCodCliente  \n"
                     " AND COD_CICLO = :ihCodCiclo \n"
                     " ORDER BY COD_GRUPOAPLI  \n");

    vDTrazasLog (szExeName,"\n\t\tConsulta Desc. Locutorios [%s]",LOG03,szCadena);

    /* EXEC SQL PREPARE sql_Cur_PlanDescClieLoc FROM :szCadena; */ 

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
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )512;
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
        vDTrazasError(szExeName,"\n\t**  Error en SQL-PREPARE sql_Cur_PlanDescClieLoc **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       iDError (szExeName,ERR000,vInsertarIncidencia,"PREPARE->GAT_PLANDESCABO",
                 szfnORAerror());
        return  (SQLCODE);

    }

    /* EXEC SQL DECLARE Cur_PlanDescClieLoc CURSOR FOR sql_Cur_PlanDescClieLoc; */ 

    if (SQLCODE)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-DECLARE sql_Cur_PlanDescAbo **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName,ERR000,vInsertarIncidencia,"DECLARE->GAT_PLANDESCABO",
             szfnORAerror());
        return  (FALSE);

    }

    /* EXEC SQL OPEN Cur_PlanDescClieLoc USING :ihZero, :lhCodCliente, :ihCodCiclo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
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
    sqlstm.sqhstv[0] = (unsigned char  *)&ihZero;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCiclo;
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
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->GAT_PLANDESCABO",
                 szfnORAerror());

    return SQLCODE;
} /* ifnOraDeclararFaDetDctoClieLoc */

/******************************************************************************
Funcion     :       ifnOraLeerGatPlanDescClieLoc
*******************************************************************************/
static int  ifnOraLeerGatPlanDescClieLoc( PLANDCTOLOC_HOST *stDescLocHosts
                                        , long *plNumFilas)
{
    /* EXEC SQL VAR stDescLocHosts->szCodPlandesc IS STRING(6) ; */ 

    /* EXEC SQL VAR stDescLocHosts->szTipDescuento IS STRING(3) ; */ 

    /* EXEC SQL VAR stDescLocHosts->szTipEntidad IS STRING(6) ; */ 


    /* EXEC SQL FETCH Cur_PlanDescClieLoc
        INTO :stDescLocHosts->szCodPlandesc ,
             :stDescLocHosts->iCodGrupoapli   ,
             :stDescLocHosts->iNumCuadrante,
             :stDescLocHosts->dValorDcto  ,
             :stDescLocHosts->szTipDescuento,
             :stDescLocHosts->lNumSecuencia,
             :stDescLocHosts->iCodEstado  ,
             :stDescLocHosts->szTipEntidad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )51;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(stDescLocHosts->szCodPlandesc);
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )6;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(stDescLocHosts->iCodGrupoapli);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(stDescLocHosts->iNumCuadrante);
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(stDescLocHosts->dValorDcto);
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)(stDescLocHosts->szTipDescuento);
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )3;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(stDescLocHosts->lNumSecuencia);
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqharc[5] = (unsigned long  *)0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(stDescLocHosts->iCodEstado);
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )sizeof(int);
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqharc[6] = (unsigned long  *)0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)(stDescLocHosts->szTipEntidad);
    sqlstm.sqhstl[7] = (unsigned long )6;
    sqlstm.sqhsts[7] = (         int  )6;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqharc[7] = (unsigned long  *)0;
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



    if (sqlca.sqlcode==SQLOK)
        *plNumFilas = MAX_REGISTROS;
    else
        if (sqlca.sqlcode==NOTFOUND)
            *plNumFilas = sqlca.sqlerrd[2] % MAX_REGISTROS;

    return SQLCODE;
} /*    ifnOraLeerGatPlanDescClieLoc    */

/******************************************************************************
Funcion     :       ifnOraCerrarGatPlanDescAbo
*******************************************************************************/
static int ifnOraCerrarGatPlanDescClieLoc ()
{

    /* EXEC SQL CLOSE Cur_PlanDescClieLoc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )98;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    return SQLCODE;
    
} /*    ifnOraCerrarGatPlanDescClieLoc  */

/*****************************************************************************/
/*    bfnDescBolsasClieLoc: Descuentos Concepto Cliente para clientes        */
/*                          Locutorios.                                      */
/*****************************************************************************/
static BOOL bfnDescBolsasClieLoc (char *szFecParam)
{
    char   modulo[]    = "bfnDescBolsasClieLoc";

    long   lInd_Pref   = 0;
    long   lIndPlan = 0;
    int    iCodConcRel;
    int    iIndBolsa = 1;

    vDTrazasLog (modulo,"\n\t\t**** Entrada en %s ", LOG04,modulo);

    for (lIndPlan = 0; lIndPlan < stPlanesLoc.lNumRegs; lIndPlan++)
    {
        if (strcmp(stPlanesLoc.stPlanLocutorio[lIndPlan].szTipEntidad,"B")==0 &&
            stPlanesLoc.stPlanLocutorio[lIndPlan].iCodEstado == 0             &&
            strcmp(stPlanesLoc.stPlanLocutorio[lIndPlan].szTipDescuento, TIPOMONTO)==0 &&
            stPlanesLoc.stPlanLocutorio[lIndPlan].dValorDcto > 0.0 )
        {
            if( !bGetConcAplicacion (stPlanesLoc.stPlanLocutorio[lIndPlan].iCodGrupoapli,szFecParam) )
            {
                vDTrazasLog(modulo,"*** No cargaron Conceptos de Aplicacion grupo [%d] ***"
                                   ,LOG05,stPlanesLoc.stPlanLocutorio[lIndPlan].iCodGrupoapli);
                return(FALSE);
            }

            for (lInd_Pref=0; lInd_Pref < stPreFactura.iNumRegistros; lInd_Pref++)
            {
                if (stPlanesLoc.stPlanLocutorio[lIndPlan].dValorDcto <= 0.0)
                	break;
                
                if(!bValidaConcAplicacion(stPreFactura.A_PFactura[lInd_Pref].iCodConcepto, &iCodConcRel))
                {
                    vDTrazasLog(modulo,"*** bValidaConcAplicacion - Cod Concepto[%d] no es aplicable ***"
                                      ,LOG05,stPreFactura.A_PFactura[lInd_Pref].iCodConcepto);
                }
                else
                {
                    if(!bAplicacionConceptosClienteLoc (iIndBolsa, lInd_Pref, iCodConcRel, &stPlanesLoc.stPlanLocutorio[lIndPlan]))
                    {
                        vDTrazasLog(modulo,"*** Error en funcion bfnDescBolsasClieLoc - No se pudo aplicar despuento ***"
                                          ,LOG05);
                        break;
                    }
                }
            }
            stPlanesLoc.stPlanLocutorio[lIndPlan].iCodEstado = 1;
        }
    }
    return(TRUE);
} /* bfnDescBolsasClieLoc */

/*****************************************************************************/
/*    bfnDescporConceptoClieLoc: Descuentos Concepto Cliente para clientes   */
/*                               Locutorios.                                 */
/*****************************************************************************/
static BOOL bfnDescporConceptoClieLoc (char *szFecParam)
{
    char   modulo[]    = "bfnDescporConceptoClieLoc";

    long lInd_Pref  = 0;
    long lIndPlan   = 0;
    int  iCodConcRel;
    int  iIndBolsa  = 0;

    vDTrazasLog (modulo,"\n\t\t**** Entrada en %s ", LOG04,modulo);

    for (lIndPlan = 0; lIndPlan < stPlanesLoc.lNumRegs; lIndPlan++)
    {
        if (strcmp(stPlanesLoc.stPlanLocutorio[lIndPlan].szTipEntidad,"B")!=0 &&
            stPlanesLoc.stPlanLocutorio[lIndPlan].iCodEstado == 0  &&
            stPlanesLoc.stPlanLocutorio[lIndPlan].dValorDcto > 0.0 )
        {
            if( !bGetConcAplicacion (stPlanesLoc.stPlanLocutorio[lIndPlan].iCodGrupoapli,szFecParam) )
            {
                vDTrazasLog(modulo,"*** No cargaron Conceptos de Aplicacion grupo [%d] ***",LOG05,stPlanesLoc.stPlanLocutorio[lIndPlan].iCodGrupoapli);
                return(FALSE);
            }

            for (lInd_Pref=0; lInd_Pref < stPreFactura.iNumRegistros; lInd_Pref++)
            {
                if(!bValidaConcAplicacion(stPreFactura.A_PFactura[lInd_Pref].iCodConcepto, &iCodConcRel))
                {
                    vDTrazasLog(modulo,"*** bValidaConcAplicacion - Cod Concepto[%d] no es aplicable ***"
                                      ,LOG05,stPreFactura.A_PFactura[lInd_Pref].iCodConcepto);
                }
                else
                {
                    if(!bAplicacionConceptosClienteLoc (iIndBolsa, lInd_Pref, iCodConcRel, &stPlanesLoc.stPlanLocutorio[lIndPlan]))
                    {
                        vDTrazasLog(modulo,"*** Error aen funcion bAplicacionConceptosClienteLoc - No se pudo aplicar despuento ***"
                                          ,LOG05);
                        break;
                    }
                }
            }
            stPlanesLoc.stPlanLocutorio[lIndPlan].iCodEstado = 1;
        }
    }
    return(TRUE);
} /* bfnDescporConceptoClieLoc */

/*****************************************************************************/
/*  Funcion : bGetConcAplicacion                                           */
/* -Funcion que carga los conceptos de aplicacion                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/

static BOOL bGetConcAplicacion(int iCod_Grupo, char *szFecParam)
{
    char modulo[]   = "bGetConcAplicacion";
    long lNumRegs;
    long  i=0, lIdx;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhFecParam    [15];  /* EXEC SQL VAR szhFecParam  IS STRING(15); */ 

    int     ihCod_Grupo        ;
    int     iahCod_Concepto [MAX_REGISTROS];
    int     iahCod_ConRel   [MAX_REGISTROS];
    short   i_shCod_ConRel  [MAX_REGISTROS];
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCod_Grupo =  iCod_Grupo;
    strcpy(szhFecParam,szFecParam);
    strcpy(szhFmtFecha, "YYYYMMDDHH24MISS");

    vDTrazasLog (modulo, "\n\t\t***** Function %s *****"
                         "\n\t\t\t Carga Conceptos Aplicacion Grupo [%d]- Fecha [%s]"
                         ,LOG04,modulo, ihCod_Grupo,szhFecParam);

    /* EXEC SQL
    SELECT COD_CONCEPTO          ,
           COD_CONREL
    INTO   :iahCod_Concepto      ,
           :iahCod_ConRel :i_shCod_ConRel
    FROM   FAD_CONCAPLI
    WHERE  COD_GRUPO = :ihCod_Grupo
      AND  TO_DATE(:szhFecParam,:szhFmtFecha) BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CONCEPTO ,COD_CONREL into :b0,:b1:b2  from FAD\
_CONCAPLI where (COD_GRUPO=:b3 and TO_DATE(:b4,:b5) between FEC_DESDE and FEC_\
HASTA)";
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )113;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)iahCod_Concepto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)iahCod_ConRel;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)i_shCod_ConRel;
    sqlstm.sqinds[1] = (         int  )sizeof(short);
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Grupo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecParam;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )15;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFmtFecha;
    sqlstm.sqhstl[4] = (unsigned long )17;
    sqlstm.sqhsts[4] = (         int  )17;
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



    lNumRegs = SQLROWS;

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo,"\n\tError en Select de Grupo de Aplicacion ", LOG01);
        iDError ( szExeName,ERR000,vInsertarIncidencia,"Select de Grupo de Aplicacion"
                , szfnORAerror());
        return(FALSE);
    }

    if( (SQLCODE == SQLNOTFOUND) && (lNumRegs == 0) )
    {
        vDTrazasLog ( modulo,"\n\tGrupo de Aplicacion [%d] no Existe"
                    , LOG04,ihCod_Grupo);
        return(FALSE);
    }

    for( i=0;i<lNumRegs;i++ )
    {
        lIdx = iahCod_Concepto [i];
        stApli[lIdx].iFlagExiste = 1;

        if( i_shCod_ConRel[i] == ORA_NULL )
            stApli[lIdx].iCod_ConRel = ORA_NULL;
        else
            stApli[lIdx].iCod_ConRel = iahCod_ConRel[i];

        vDTrazasLog (szExeName,  "\n\t\t[%d]-Cod. Concepto.[%d] - Cod. Conc. Relacionado.[%d]"
                                 ,LOG06,i,iahCod_Concepto [i] ,stApli[lIdx].iCod_ConRel)      ;
    }

    return(TRUE);

}
/************************ Final bGetConcAplicacion ***************************/

/****************************************************************************/
/*  Funcion : bValidaConcAplicacion                                          */
/* -Funcion que Valida si el concepto es parte del grupo de aplicacion       */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bValidaConcAplicacion(int piCodConcepto, int *piCodConcRel)
{
    char modulo[]   = "bValidaConcAplicacion";
    vDTrazasLog (modulo, "\n\t\t***** Function %s *****"
                         "\n\t\t\t Valida Concepto de Aplicacion [%d]"
                         ,LOG04,modulo, piCodConcepto);

    if (stApli[piCodConcepto].iFlagExiste == 1)
    {
        *piCodConcRel = stApli[piCodConcepto].iCod_ConRel ;

        vDTrazasLog (szExeName,  "\n\t\tCodigo Concepto Relacionado encontrado[%d]"
                                 ,LOG06, *piCodConcRel)      ;
    }else{
        return(FALSE);
    }

    return(TRUE);
}
/*************************** Final bValidaConcAplicacion *********************/

/*****************************************************************************/
/*  Funcion : bAplicacionConceptosCliente                                    */
/* -Funcion que aplica conceptos de descuentos                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bAplicacionConceptosClienteLoc (int         iIndBolsa, 
                                            long        iIndPref, 
                                            int         iCodConcRel, 
                                            PLANDCTOLOC *stPlanLocutorio)
{

    char   modulo[] = "bAplicacionConceptosClienteLoc";

    double dMontoEvaluar;

    vDTrazasLog (modulo,"\n\t\t***** Function bAplicacionConceptosClienteLoc *****"
                        "\n\t\t\t Aplicacion por CONCEPTO indice [%ld] - iIndBolsa [%d]",LOG04,iIndPref,iIndBolsa);

    if( stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  >  0.0 )
    {
        vDTrazasLog (modulo ,"\t\tConcepto de Aplicacion stPrefactura [%d] [%ld]"
                     ,LOG04,stPreFactura.A_PFactura[iIndPref].iCodConcepto
                     ,stPreFactura.A_PFactura[iIndPref].lNumAbonado );

        stValDesc.stDescuentos = (VALORDESCUENTO*)realloc(stValDesc.stDescuentos,(idxDesc+1)*sizeof(VALORDESCUENTO));
        if (stValDesc.stDescuentos == NULL)
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,
                                 "stValDesc.stDescuentos");
        }
        memset(&stValDesc.stDescuentos[idxDesc],0,sizeof(VALORDESCUENTO));

        if (iIndBolsa)
            dMontoEvaluar = stPreFactura.A_PFactura[iIndPref].dImpConcepto;
        else
            dMontoEvaluar = stPreFactura.A_PFactura[iIndPref].dImpConcDescApliBolsa;
            
            
        vDTrazasLog (modulo,"\n\t\tdMontoEvaluar [%f]",LOG05,dMontoEvaluar);

        stValDesc.stDescuentos[idxDesc].dVal_Descuento = stPlanLocutorio->dValorDcto;

        if (strcmp(stPlanLocutorio->szTipDescuento, TIPOMONTO)==0)
        {
            vDTrazasLog (modulo,"\n\t\tDescuento Tipo Monto"
            					"\n\t\tdImpConcDescApli                  [%f]"
            					"\n\t\tdValorDcto                        [%f]"
            					"\n\t\tdImpConcDescApli - dValorDcto     [%f]"
            					"\n\t\tstPlanLocutorio->dValorDcto       [%f]"
            					,LOG05
            					,stPreFactura.A_PFactura[iIndPref].dImpConcDescApli
            					,stPlanLocutorio->dValorDcto
            					,(stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  - stPlanLocutorio->dValorDcto)
            					,stPlanLocutorio->dValorDcto);
            					
            if( (stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  - stPlanLocutorio->dValorDcto) >  0.0 )
            {
                stValDesc.stDescuentos[idxDesc].dValor_Monto = stPlanLocutorio->dValorDcto;
                stPreFactura.A_PFactura[iIndPref].dImpConcDescApli = stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  -  stPlanLocutorio->dValorDcto;
            }
            else
            {
                stValDesc.stDescuentos[idxDesc].dValor_Monto = stPreFactura.A_PFactura[iIndPref].dImpConcDescApli ;
                stPreFactura.A_PFactura[iIndPref].dImpConcDescApli     = 0.0 ;

            }
			
			if (iIndBolsa)
            	stPlanLocutorio->dValorDcto = stPlanLocutorio->dValorDcto - stValDesc.stDescuentos[idxDesc].dValor_Monto;

            vDTrazasLog (modulo,"\n\t\t -- stPlanLocutorio->dValorDcto     [%f]"
            					,LOG05
            					,stPlanLocutorio->dValorDcto);
        }
        else
        {
            vDTrazasLog (modulo,"\n\t\tDescuento Tipo Porcentaje"
            					"\n\t\tdImpConcDescApli                  [%f]"
            					"\n\t\tdValor_Monto                      [%f]"
            					"\n\t\tstPlanLocutorio->dValorDcto       [%f]"
            					,LOG05
            					,stPreFactura.A_PFactura[iIndPref].dImpConcDescApli
            					,stValDesc.stDescuentos[idxDesc].dValor_Monto
            					,stPlanLocutorio->dValorDcto);
            
            
            stValDesc.stDescuentos[idxDesc].dValor_Monto = (dMontoEvaluar*stPlanLocutorio->dValorDcto)/100;
            
            vDTrazasLog (modulo,"\n\t\t -- stValDesc.stDescuentos[idxDesc].dValor_Monto     [%f]"
            					,LOG05
            					,stValDesc.stDescuentos[idxDesc].dValor_Monto);
            /*  Se valida que el remanente del concepto cubra el descuento */
            if( (stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto) >  0.0 )
            {
                stPreFactura.A_PFactura[iIndPref].dImpConcDescApli = stPreFactura.A_PFactura[iIndPref].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto;
            }
            else
            {
                stValDesc.stDescuentos[idxDesc].dValor_Monto = stPreFactura.A_PFactura[iIndPref].dImpConcDescApli ;
                stPreFactura.A_PFactura[iIndPref].dImpConcDescApli     = 0.0 ;
            }
        }

        stValDesc.stDescuentos[idxDesc].lNumSecuencia = stPlanLocutorio->lNumSecuencia;
        stValDesc.stDescuentos[idxDesc].lNumAbonado   = stPreFactura.A_PFactura[iIndPref].lNumAbonado;
        stValDesc.stDescuentos[idxDesc].iCod_Concepto = iCodConcRel;
        stValDesc.stDescuentos[idxDesc].iNum_Cuadrante= stPlanLocutorio->iNumCuadrante;
        stValDesc.stDescuentos[idxDesc].iPosPrefac    = iIndPref;

        if( !bValidacionDto (&stValDesc.stDescuentos[idxDesc]) )
        {
            vDTrazasLog (modulo,"\n\t\tConcepto No Encontrado [%d]",LOG04,stValDesc.stDescuentos[idxDesc].iCod_Concepto);
            return(FALSE);
        }

        strcpy (stValDesc.stDescuentos[idxDesc].szTip_Descuento  ,stPlanLocutorio->szTipDescuento )  ;
        strcpy (stValDesc.stDescuentos[idxDesc].szTip_Moneda     ,"");

        if (strcmp(stPlanLocutorio->szTipDescuento, TIPOMONTO)!=0)
        {
            if( fnCnvDouble(stValDesc.stDescuentos[idxDesc].dValor_Monto,iUSO0) != (fnCnvDouble((dMontoEvaluar*stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100,iUSO0)) )
            {
                dAjuste+= ((dMontoEvaluar * stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100) - stValDesc.stDescuentos[idxDesc].dValor_Monto ;
            }
        }

        vDTrazasLog (modulo,"\n\t\t\tNumero Abonado.....[%ld]"
                     "\n\t\t\tValor descuento....[%f]"
                     "\n\t\t\tValor concepto.....[%f]"
                     "\n\t\t\tMonto a descontar..[%f]"
                     "\n\t\t\tMonto de Ajuste....[%f]"
                     ,LOG04,stValDesc.stDescuentos[idxDesc].lNumAbonado
                     ,stValDesc.stDescuentos[idxDesc].dVal_Descuento
                     ,stPreFactura.A_PFactura[iIndPref].dImpFacturable
                     ,stValDesc.stDescuentos[idxDesc].dValor_Monto
                     ,dAjuste);
        dTotalMontoPrefacDesc= dTotalMontoPrefacDesc - stValDesc.stDescuentos[idxDesc].dValor_Monto;
        
        if (iIndBolsa)
            stPreFactura.A_PFactura[iIndPref].dImpConcDescApliBolsa = stPreFactura.A_PFactura[iIndPref].dImpConcDescApliBolsa - stValDesc.stDescuentos[idxDesc].dValor_Monto;
        
        idxDesc++;
        stValDesc.iNumDescuentos++;


    }

    vDTrazasLog (modulo,"\n\t***** Fin Aplicacion de Conceptos *****",LOG04);
    return(TRUE);
} /*    bAplicacionConceptosClienteLoc   */


/*****************************************************************************/
/*  Funcion : bfnCargaPlanDesc_old                                               */
/*****************************************************************************/
static BOOL bfnCargaPlanDesc_old (long       lCliente)
{
    char modulo[]   = "bfnCargaPlanDesc";
    long lNumReg  = 0;
    long  i = 0, ind_Abon =0, ind_Plan =0;

    long lpNumAbonado;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         long     lahNumSecuencia [NUM_ABONADOS_CLIENTE]    ;
         long     lahNumAbonado   [NUM_ABONADOS_CLIENTE]    ;
         /* VARCHAR  szahCod_Plandesc[NUM_ABONADOS_CLIENTE][6] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szahCod_Plandesc[10000];

         /* VARCHAR  szahTipEntidad  [NUM_ABONADOS_CLIENTE][6] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szahTipEntidad[10000];

         long     lhCodCliente                    ;
         long     lhCodCiclFact                   ;
    /* EXEC SQL END DECLARE SECTION; */ 



    vDTrazasLog (modulo,"\n\t\t* Funcion bfnCargaPlanDesc ",LOG05);

    lhCodCliente = lCliente;
    lhCodCiclFact = stCiclo.lCodCiclFact;

    /* EXEC SQL
    SELECT  NUM_SECUENCIA       ,
            NVL(NUM_ABONADO,0)  ,
    	    TRIM(COD_PLANDESC)  ,
    		TRIM(TIP_ENTIDAD)
      INTO  :lahNumSecuencia    ,
    		:lahNumAbonado      ,
    		:szahCod_Plandesc   ,
    		:szahTipEntidad
      FROM GAT_PLANDESCABO
     WHERE COD_CLIENTE  = :lhCodCliente
       AND (COD_CICLFACT = :lhCodCiclFact OR COD_CICLFACT = 0)
     ORDER BY NUM_ABONADO; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 8;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select NUM_SECUENCIA ,NVL(NUM_ABONADO,0) ,trim(COD_PLANDE\
SC) ,trim(TIP_ENTIDAD) into :b0,:b1,:b2,:b3  from GAT_PLANDESCABO where (COD_C\
LIENTE=:b4 and (COD_CICLFACT=:b5 or COD_CICLFACT=0)) order by NUM_ABONADO ";
    sqlstm.iters = (unsigned int  )10000;
    sqlstm.offset = (unsigned int  )148;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)lahNumSecuencia;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)lahNumAbonado;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szahCod_Plandesc;
    sqlstm.sqhstl[2] = (unsigned long )8;
    sqlstm.sqhsts[2] = (         int  )8;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szahTipEntidad;
    sqlstm.sqhstl[3] = (unsigned long )8;
    sqlstm.sqhsts[3] = (         int  )8;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )sizeof(long);
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[5] = (         int  )sizeof(long);
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



    lNumReg = SQLROWS;

    if( (SQLCODE != SQLOK) && (SQLCODE != SQLNOTFOUND) )
    {
        vDTrazasLog (modulo,"\n\t\tError en Carga de Planes de Descuentos SQLCODE [%ld]",LOG01, SQLCODE);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Carga de Planes de Descuentos", szfnORAerror());
        return(FALSE);
    }
    if( (SQLCODE == SQLNOTFOUND) && (lNumReg == 0) )
    {
        vDTrazasLog (modulo,"\n\t\t**No existen Planes para este Cliente**",LOG03);
        return(TRUE);
    }

    lpNumAbonado=lahNumAbonado[0];
    ind_Abon = 0;
    ind_Plan = 0;
    stPlanesDesc.lNumAbonados=1;

    for( i=0;i<lNumReg;i++ )
    {
        if( lpNumAbonado!=lahNumAbonado[i] )
        {
            ind_Abon++;
            stPlanesDesc.lNumAbonados++;
            ind_Plan=0;
        }
        stPlanesDesc.stAbonado[ind_Abon].lNumAbonado = lahNumAbonado[i];
        stPlanesDesc.stAbonado[ind_Abon].iNumPlanes++;
        sprintf(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szCod_Plandesc,"%.*s\0",szahCod_Plandesc[i].len, szahCod_Plandesc[i].arr);
        stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].stPD.lNumSecuencia=lahNumSecuencia[i];
        sprintf(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad,"%.*s\0",szahTipEntidad[i].len, szahTipEntidad[i].arr);

        if( strcmp(stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad, TIPOENTGRUPO) == 0 )
        {   /* HABILITA INDICADOR DE PLANES DE GRUPO */
            indGrupo = 1;
        }

        vDTrazasLog (modulo,   "\t\t\t=> Num. Abonado   : [%ld]  Cod. Plan Descuento : [%s]**"
		                     "\n\t\t\t=> Num. Secuencia : [%ld]  Tipo Entidad        : [%s]**"
		                     ,LOG05,stPlanesDesc.stAbonado[ind_Abon].lNumAbonado
		                     ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szCod_Plandesc
		                     ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].stPD.lNumSecuencia
		                     ,stPlanesDesc.stAbonado[ind_Abon].stPlanDes[ind_Plan].szTipEntidad);

        ind_Plan++;
        lpNumAbonado=lahNumAbonado[i];
    }

    return(TRUE);
}


/*****************************************************************************/
/*  Funcion : bfnCargaDatosPlan                                              */
/*****************************************************************************/
static BOOL bfnCargaDatosPlan (char *szFecParam, PLANDCTO *pstPD, char *szCod_Plandesc )
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char  szhCod_Plan          [6] ;
    char  szhFecParam          [15];
    char  szhCod_Tipeval       [2] ;
    char  szhCod_Tipapli       [2] ;
    int   ihCod_Grupoeval          ;
    int   ihCod_Grupoapli          ;
    int   ihNum_Cuadrante          ;
    char  szhTip_Unidad        [3] ;
    int   ihCod_Concdesc           ;
    double dhMto_Minfact           ;
    short i_shCod_Grupoeval        ;
    short i_shCod_Grupoapli        ;
    short i_shNum_Cuadrante        ;
    short i_shCod_Concdesc         ;
    short i_shMto_Minfact          ;
    /* EXEC SQL END DECLARE SECTION; */ 


    char modulo[]   = "bfnCargaDatosPlan";

    vDTrazasLog (modulo,"\n\t\t* Funcion bfnCargaDatosPlan "
                 "\n\t\t=> Fecha Parametro   [%s]"
                 "\n\t\t=> Cod.  Plan Desc.  [%s]",
                 LOG04, szFecParam, szCod_Plandesc);

    strcpy(szhCod_Plan,szCod_Plandesc);
    strcpy(szhFecParam,szFecParam);

    /* EXEC SQL
    SELECT C.COD_TIPEVAL      ,
	    C.COD_TIPAPLI      ,
	    C.COD_GRUPOEVAL    ,
	    C.COD_GRUPOAPLI    ,
	    C.NUM_CUADRANTE    ,
	    C.TIP_UNIDAD       ,
	    C.COD_CONCDESC     ,
	    C.MTO_MINFACT
    INTO  :szhCod_Tipeval    ,
	    :szhCod_Tipapli    ,
	    :ihCod_Grupoeval :i_shCod_Grupoeval,
	    :ihCod_Grupoapli :i_shCod_Grupoapli  ,
	    :ihNum_Cuadrante :i_shNum_Cuadrante  ,
	    :szhTip_Unidad     ,
	    :ihCod_Concdesc :i_shCod_Concdesc,
	    :dhMto_Minfact  :i_shMto_Minfact
    FROM   FAD_PLANDESC B,  FAD_DETPLANDESC C
    WHERE  B.COD_PLANDESC = C.COD_PLANDESC
                            AND    TO_DATE(:szhFecParam,'yyyymmddhh24miss') BETWEEN C.FEC_DESDE AND C.FEC_HASTA
                            AND    B.COD_PLANDESC = :szhCod_Plan; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select C.COD_TIPEVAL ,C.COD_TIPAPLI ,C.COD_GRUPOEVAL ,C.C\
OD_GRUPOAPLI ,C.NUM_CUADRANTE ,C.TIP_UNIDAD ,C.COD_CONCDESC ,C.MTO_MINFACT int\
o :b0,:b1,:b2:b3,:b4:b5,:b6:b7,:b8,:b9:b10,:b11:b12  from FAD_PLANDESC B ,FAD_\
DETPLANDESC C where ((B.COD_PLANDESC=C.COD_PLANDESC and TO_DATE(:b13,'yyyymmdd\
hh24miss') between C.FEC_DESDE and C.FEC_HASTA) and B.COD_PLANDESC=:b14)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )187;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Tipeval;
    sqlstm.sqhstl[0] = (unsigned long )2;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Tipapli;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Grupoeval;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)&i_shCod_Grupoeval;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_Grupoapli;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)&i_shCod_Grupoapli;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&ihNum_Cuadrante;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)&i_shNum_Cuadrante;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhTip_Unidad;
    sqlstm.sqhstl[5] = (unsigned long )3;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihCod_Concdesc;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)&i_shCod_Concdesc;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&dhMto_Minfact;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)&i_shMto_Minfact;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhFecParam;
    sqlstm.sqhstl[8] = (unsigned long )15;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhCod_Plan;
    sqlstm.sqhstl[9] = (unsigned long )6;
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog (modulo,"\n\t\tError en Select de Plan Descuento del Cliente",LOG03);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select de Plan Descuento del Cliente", szfnORAerror());
        return(FALSE);
    }

    if( SQLCODE == SQLNOTFOUND )
        vDTrazasLog (modulo,"\n\t\t* Plan de Descuento No-Vigente [%s]",LOG03,szhCod_Plan);


    if( SQLCODE == SQLOK )
    {
        vDTrazasLog (modulo,"\n\t\t* Cliente Con Plan de Descuento [%s]",LOG04,szhCod_Plan);
        strcpy(pstPD->szCod_Tipeval      , szhCod_Tipeval);
        strcpy(pstPD->szCod_Tipapli      , szhCod_Tipapli);
        strcpy(pstPD->szTip_Unidad       , szhTip_Unidad);

        if( i_shCod_Grupoeval == ORA_NULL )
            pstPD->iCod_Grupoeval = ORA_NULL;
        else
            pstPD->iCod_Grupoeval = ihCod_Grupoeval;

        if( i_shCod_Grupoapli == ORA_NULL )
            pstPD->iCod_Grupoapli = ORA_NULL;
        else
            pstPD->iCod_Grupoapli = ihCod_Grupoapli;

        if( i_shNum_Cuadrante == ORA_NULL )
            pstPD->iNum_Cuadrante = ORA_NULL;
        else
            pstPD->iNum_Cuadrante = ihNum_Cuadrante;

        if( i_shCod_Concdesc == ORA_NULL )
            pstPD->iCod_Concdesc  = ORA_NULL;
        else
            pstPD->iCod_Concdesc  = ihCod_Concdesc;

        if( i_shMto_Minfact == ORA_NULL )
            pstPD->dMto_Minfact   = ORA_NULL;
        else
            pstPD->dMto_Minfact   = dhMto_Minfact;

    }
    return(TRUE);
}

/*****************************************************************************/
/*****************************************************************************/

static BOOL bfnDescporConceptoAbonado (long lNumAbonado, PLANDCTO *stPD ,char *szFecParam, double dTotalMontoPrefactura)
{

    char   modulo[]         = "bfnDescporConceptoAbonado";
    double dTotalfac        = 0.0;

    GRUPOCONCEVAL  stEval   ;
    GRUPOCONAPLI   stApli   ;
    GRUPOCUADRANTE stCuadra ;
    VALORDESCUENTO stDescPaso;

    vDTrazasLog (modulo,"\n\t\t*** Entrada en bfnDescporConceptoAbonado "
                 "\n\t\t=> Nro. Abonado : [%ld]", LOG04, lNumAbonado);


    memset (&stEval     ,0,sizeof (GRUPOCONCEVAL));
    memset (&stApli     ,0,sizeof (GRUPOCONAPLI));
    memset (&stCuadra   ,0,sizeof (GRUPOCUADRANTE));
    memset (&stDescPaso ,0,sizeof (VALORDESCUENTO));

    if( dTotalMontoPrefacDesc <= stPD->dMto_Minfact )
    {
        vDTrazasLog (modulo,"\n\t**Monto a Facturar es Menor que el Monto Minimo Permitido"
                     "\n\t**Monto a Facturar [%f] **Monto Minimo Permitido [%f]"
                     ,LOG03,dTotalMontoPrefacDesc,stPD->dMto_Minfact);
        return(TRUE);
    }

    /*Carga Concepto de Evaluacion */
    if( strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0 )
    {
        if( !bCargaConceptoEvalua (stPD->iCod_Grupoeval,szFecParam,&stEval) )
        {
            vDTrazasLog(modulo,"*** No cargaron Conceptos de Evaluacion grupo [%d] ***",LOG05,stPD->iCod_Grupoeval);
            return(FALSE);
        }
    }

    /*Contar cantidad de evaluaciones*/
    if( !bEvaluaciondeConceptos (stPD,&stEval, &dTotalfac, szFecParam,dTotalMontoPrefactura) )
    {
        vDTrazasLog(modulo,"*** No se Evaluaron Conceptos en grupo [%d] ***",LOG05,stPD->iCod_Grupoeval);
        return(FALSE);
    }

    vDTrazasLog  (modulo,"\n\t***** Total a Facturar por Evaluacion [%f]", LOG04,dTotalfac);

    /*calculo de descuentos */
    if( dTotalfac > 0 )
    {
        if( strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0 )
            /*carga Concepto de Aplicacion*/
            if( !bCargaConceptoAplica (stPD->iCod_Grupoapli,szFecParam,&stApli) )
            {
                vDTrazasLog(modulo,"*** No cargaron Conceptos de Aplicacion grupo [%d] ***",LOG05,stPD->iCod_Grupoapli);
                return(FALSE);
            }

        if( (stApli.iNumAplica > 0 && strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0) ||
            strcmp(stPD->szCod_Tipeval,PORFACTURA)==0 )
        {
            /* Carga Cuadrante de Descuento*/
            if( !bCargaCuadrante (stPD->iNum_Cuadrante,szFecParam,&stCuadra) )
            {
                vDTrazasLog(modulo,"*** No se Cargo Cuadrante [%d] ***",LOG05,stPD->iNum_Cuadrante);
                return(FALSE);
            }

            if( !bCalculaDescuento(lNumAbonado, &stDescPaso, &stCuadra, dTotalfac) )
            {
                vDTrazasLog(modulo,"*** No se Calculo Descuento Abonado [%ld] ***",LOG02,lNumAbonado);
                return(FALSE);
            }

            if( (stDescPaso.dVal_Descuento != 0.0)||(stDescPaso.dVal_Descuento != 0) )
            {

                if( strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0 )
                    /*contar cantidad de aplicaciones*/
                    if( !bAplicacionConceptos ( lNumAbonado, stPD, &stApli, &stDescPaso, szFecParam) )
                    {
                        vDTrazasLog(modulo,"*** No se Aplico Descuento Abonado [%ld] ***",LOG05,lNumAbonado);
                        return(FALSE);
                    }

                if( strcmp(stPD->szCod_Tipeval,PORFACTURA)==0 )
                    if( !bAplicacionConceptosFacturaCliente(lNumAbonado,stPD,&stDescPaso,dTotalfac) )
                    {
                        vDTrazasLog(modulo,"*** No se Aplicaron Conceptos Factura Abonado [%ld] ***",LOG05,lNumAbonado);
                        return(FALSE);
                    }

                vfnPrintCuadrante(&stValDesc.stDescuentos[idxDesc-1]);
            }
        }
    }
    else
    {
        vDTrazasLog  (modulo,"\t***** Monto de Evaluacion es [0].No se Pueden Efectuar Descuentos", LOG04);
    }
    return(TRUE);
}


/*****************************************************************************/
/*  Funcion : iCargaGrupoEvalua                                              */
/* -Funcion que carga los conceptos de evaluacion                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaConceptoEvalua(int iCod_Grupo, char *szFecParam, GRUPOCONCEVAL  *pstEval)
{
    char modulo[]   = "bCargaConceptoEvalua";
    int  iNumRegs;
    register int  i=0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhFecParam    [15];  /* EXEC SQL VAR szhFecParam  IS STRING(15); */ 

    int     ihCod_Grupo        ;
    int     iahCod_Concepto       [MAX_REGISTROS]    ;
    /* VARCHAR szahInd_Obliga        [MAX_REGISTROS][2] ; */ 
struct { unsigned short len; unsigned char arr[2]; } szahInd_Obliga[2000];

    double  dahMto_MinFact        [MAX_REGISTROS]    ;
    short   i_shMto_MinFact       [MAX_REGISTROS]    ;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCod_Grupo =  iCod_Grupo;
    strcpy(szhFecParam,szFecParam);

    vDTrazasLog (modulo,"\n\t***** Function bCargaConceptoEvalua *****"
                 "\n\t\t Carga Concepto de Evaluacion con Grupo [%d]- Fecha[%s]"
                 ,LOG04,ihCod_Grupo,szhFecParam);

    /* EXEC SQL
    SELECT COD_CONCEPTO ,
    IND_OBLIGA  ,
    MTO_MINFACT
    INTO   :iahCod_Concepto  ,
    :szahInd_Obliga   ,
    :dahMto_MinFact :i_shMto_MinFact
    FROM   FAD_CONCEVAL
    WHERE  COD_GRUPO = :ihCod_Grupo
                       AND    TO_DATE(:szhFecParam,'yyyymmddhh24miss') BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CONCEPTO ,IND_OBLIGA ,MTO_MINFACT into :b0,:b1\
,:b2:b3  from FAD_CONCEVAL where (COD_GRUPO=:b4 and TO_DATE(:b5,'yyyymmddhh24m\
iss') between FEC_DESDE and FEC_HASTA)";
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )242;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)iahCod_Concepto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szahInd_Obliga;
    sqlstm.sqhstl[1] = (unsigned long )4;
    sqlstm.sqhsts[1] = (         int  )4;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)dahMto_MinFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[2] = (         int  )sizeof(double);
    sqlstm.sqindv[2] = (         short *)i_shMto_MinFact;
    sqlstm.sqinds[2] = (         int  )sizeof(short);
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihCod_Grupo;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[3] = (         int  )sizeof(int);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhFecParam;
    sqlstm.sqhstl[4] = (unsigned long )15;
    sqlstm.sqhsts[4] = (         int  )15;
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



    iNumRegs = SQLROWS;

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog (modulo,"\n\t\tError en Select de Grupo de Evaluacion",LOG03);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select de Grupo de Evaluacion", szfnORAerror());
        return(FALSE);
    }
    if( (SQLCODE == SQLNOTFOUND) && (iNumRegs == 0) )
    {
        vDTrazasLog (modulo,"\n\t\tGrupo de Evaluacion [%d] no existe ",LOG03,ihCod_Grupo);

    }

    if( iNumRegs > 0 )
    {
        for( i=0;i<iNumRegs;i++ )
        {
            pstEval->stRegistro[i].iCod_Grupo          =   ihCod_Grupo;
            pstEval->stRegistro[i].iCod_Concepto       =   iahCod_Concepto      [i];
            sprintf(pstEval->stRegistro[i].szInd_Obliga,"%.*s\0",szahInd_Obliga[i].len, szahInd_Obliga[i].arr);

            if( i_shMto_MinFact[i] == ORA_NULL )
                pstEval->stRegistro[i].dMto_MinFact = ORA_NULL;
            else
                pstEval->stRegistro[i].dMto_MinFact = dahMto_MinFact[i];

            vDTrazasLog (szExeName,  "\n\t\t***** vPrintConceptosEvaluacion *****"
			                         "\n\t\t[%d]-Codigo de Grupo................[%d]"
			                         "\n\t\t[%d]-Codigo Concepto................[%d]"
			                         "\n\t\t[%d]-Indicador Obligatorio..........[%s]"
			                         "\n\t\t[%d]-Monto Minimo Facturado.........[%f]"
			                         ,LOG06
			                         ,i,pstEval->stRegistro[i].iCod_Grupo
			                         ,i,pstEval->stRegistro[i].iCod_Concepto
			                         ,i,pstEval->stRegistro[i].szInd_Obliga
			                         ,i,pstEval->stRegistro[i].dMto_MinFact)        ;
            pstEval->iNumEval ++;
        }
    }

    vDTrazasLog  (modulo,"\t\t***** Fin Funcion Concepto de Grupo de Evaluacion *****", LOG04);
    return(TRUE);

}
/*************************** Final iCargaGrupoEvalua *****************************/


/*****************************************************************************/
/*  Funcion : bCargaConceptoAplica                                           */
/* -Funcion que carga los conceptos de aplicacion                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaConceptoAplica(int iCod_Grupo, char *szFecParam, GRUPOCONAPLI  *pstApli)
{
    char modulo[]   = "bCargaConceptoAplica";
    int  iNumRegs;
    int  i=0;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhFecParam    [15];  /* EXEC SQL VAR szhFecParam  IS STRING(15); */ 

    int     ihCod_Grupo        ;
    int     iahCod_Concepto       [MAX_REGISTROS]    ;
    int     iahCod_ConRel         [MAX_REGISTROS]    ;
    short   i_shCod_ConRel        [MAX_REGISTROS]    ;
    /* EXEC SQL END DECLARE SECTION; */ 


    ihCod_Grupo =  iCod_Grupo;
    strcpy(szhFecParam,szFecParam);

    vDTrazasLog (modulo,"\n\t\t***** Function %s *****"
                 "\n\t\t\t Carga Concepto de Aplicacion con Grupo [%d]- Fecha [%s]"
                 ,LOG04,modulo, ihCod_Grupo,szhFecParam);

    /* EXEC SQL
    SELECT COD_CONCEPTO          ,
		   COD_CONREL
    INTO   :iahCod_Concepto      ,
    	   :iahCod_ConRel :i_shCod_ConRel
    FROM   FAD_CONCAPLI
    WHERE  COD_GRUPO = :ihCod_Grupo
	 AND   TO_DATE(:szhFecParam,'yyyymmddhh24miss') BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CONCEPTO ,COD_CONREL into :b0,:b1:b2  from FAD\
_CONCAPLI where (COD_GRUPO=:b3 and TO_DATE(:b4,'yyyymmddhh24miss') between FEC\
_DESDE and FEC_HASTA)";
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )277;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)iahCod_Concepto;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )sizeof(int);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)iahCod_ConRel;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)i_shCod_ConRel;
    sqlstm.sqinds[1] = (         int  )sizeof(short);
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&ihCod_Grupo;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[2] = (         int  )sizeof(int);
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhFecParam;
    sqlstm.sqhstl[3] = (unsigned long )15;
    sqlstm.sqhsts[3] = (         int  )15;
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




    iNumRegs = SQLROWS;

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo,"\n\tError en Select de Grupo de Aplicacion ", LOG01);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select de Grupo de Aplicacion", szfnORAerror());
        return(FALSE);
    }

    if( (SQLCODE == SQLNOTFOUND) && (iNumRegs == 0) )
    {
        vDTrazasLog  (modulo,"\n\tCodigo de Grupo de Aplicacion [%d] no Existe", LOG04,ihCod_Grupo);
        pstApli->iNumAplica = 0;
    }

    if( iNumRegs > 0 )
    {
        for( i=0;i<iNumRegs;i++ )
        {
            pstApli->stRegistro[i].iCod_Grupo          =   ihCod_Grupo;
            pstApli->stRegistro[i].iCod_Concepto       =   iahCod_Concepto      [i];

            if( i_shCod_ConRel[i] == ORA_NULL )
                pstApli->stRegistro[i].iCod_ConRel = ORA_NULL;
            else
                pstApli->stRegistro[i].iCod_ConRel = iahCod_ConRel[i];

            vDTrazasLog (szExeName, "\n\t\t***** vPrintConceptosAplicacion *****"
                         "\n\t\t[%d]-Codigo de Grupo................[%d]"
                         "\n\t\t[%d]-Codigo Concepto................[%d]"
                         "\n\t\t[%d]-Codigo Concepto Relacionado....[%d]"
                         ,LOG06
                         ,i,pstApli->stRegistro[i].iCod_Grupo
                         ,i,pstApli->stRegistro[i].iCod_Concepto
                         ,i,pstApli->stRegistro[i].iCod_ConRel)      ;
            pstApli->iNumAplica ++;
        }
    }

    vDTrazasLog  (modulo,"\t\t***** Fin Funcion Concepto de Grupo de Aplicacion *****", LOG04);
    return(TRUE);

}
/*************************** Final iCargaconceptoAplica *****************************/



/*****************************************************************************/
/*  Funcion : bCargaCuadrante                                                */
/* -Funcion que carga los cuadrantes de descuentos                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCargaCuadrante (int iNum_Cuadrante, char *szFecParam, GRUPOCUADRANTE  *pstCuadra)
{
    char modulo[]   = "bCargaCuadrante";
    int  iNumRegs =0;
    int  i=0;
    char Cuadra_Err[7];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    char    szhFecParam    [15];/* EXEC SQL VAR szhFecParam  IS STRING(15); */ 

    int     ihNum_Cuadrante    ;
    double  dahVal_Desde        [MAX_REGISTROS]    ;
    double  dahVal_Hasta        [MAX_REGISTROS]    ;
    /* VARCHAR szahTip_Descuento   [MAX_REGISTROS][3] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szahTip_Descuento[2000];

    double  dahVal_Descuento    [MAX_REGISTROS]    ;
    /* VARCHAR szahTip_Moneda      [MAX_REGISTROS][3] ; */ 
struct { unsigned short len; unsigned char arr[6]; } szahTip_Moneda[2000];

    short   i_shVal_Hasta       [MAX_REGISTROS]    ;
    short   i_shTip_Moneda      [MAX_REGISTROS] ;

    /* EXEC SQL END DECLARE SECTION; */ 



    ihNum_Cuadrante =  iNum_Cuadrante;
    strcpy(szhFecParam,szFecParam);
    sprintf(Cuadra_Err,"%d",iNum_Cuadrante);

    vDTrazasLog (modulo,"\n\t\t***** Function bCargaCuadrante *****"
                 "\n\t\t\tCarga Concepto con Numero de Cuadrante [%d] - Fecha [%s]"
                 , LOG04,ihNum_Cuadrante,szhFecParam);

    /* EXEC SQL
    SELECT VAL_DESDE           ,
    VAL_HASTA           ,
    TIP_DESCUENTO       ,
    VAL_DESCUENTO       ,
    TIP_MONEDA
    INTO   :dahVal_Desde       ,
    :dahVal_Hasta :i_shVal_Hasta       ,
    :szahTip_Descuento  ,
    :dahVal_Descuento   ,
    :szahTip_Moneda :i_shTip_Moneda
    FROM   FAD_CUADRANDESC
    WHERE  NUM_CUADRANTE = :ihNum_Cuadrante
                           AND    TO_DATE(:szhFecParam,'yyyymmddhh24miss') BETWEEN FEC_DESDE AND FEC_HASTA; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_DESDE ,VAL_HASTA ,TIP_DESCUENTO ,VAL_DESCUENTO\
 ,TIP_MONEDA into :b0,:b1:b2,:b3,:b4,:b5:b6  from FAD_CUADRANDESC where (NUM_C\
UADRANTE=:b7 and TO_DATE(:b8,'yyyymmddhh24miss') between FEC_DESDE and FEC_HAS\
TA)";
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )308;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)dahVal_Desde;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )sizeof(double);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)dahVal_Hasta;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[1] = (         int  )sizeof(double);
    sqlstm.sqindv[1] = (         short *)i_shVal_Hasta;
    sqlstm.sqinds[1] = (         int  )sizeof(short);
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szahTip_Descuento;
    sqlstm.sqhstl[2] = (unsigned long )5;
    sqlstm.sqhsts[2] = (         int  )8;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)dahVal_Descuento;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[3] = (         int  )sizeof(double);
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szahTip_Moneda;
    sqlstm.sqhstl[4] = (unsigned long )5;
    sqlstm.sqhsts[4] = (         int  )8;
    sqlstm.sqindv[4] = (         short *)i_shTip_Moneda;
    sqlstm.sqinds[4] = (         int  )sizeof(short);
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqharc[4] = (unsigned long  *)0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihNum_Cuadrante;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )sizeof(int);
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecParam;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )15;
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



    iNumRegs = SQLROWS;
    vDTrazasLog (modulo,"\t\tSqlcode [%d]"
                 "\n\t\tCantidad de Registros del Cuadrante [%d] - [%d]"
                 ,LOG04,SQLCODE,ihNum_Cuadrante,iNumRegs);

    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK )
    {
        vDTrazasLog (modulo,"\n\t\tError en Select de Cuadrante de Descuentos",LOG03);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Select de Cuadrante de Descuentos", szfnORAerror());
        return(FALSE);
    }

    if( (SQLCODE == SQLNOTFOUND) && (iNumRegs == 0) )
    {
        vDTrazasLog (modulo,"\n\t\tNumero de Cuadrante [%d] no existe",LOG03,ihNum_Cuadrante);
        iDError (szExeName,ERR000,vInsertarIncidencia,"Numero de Cuadrante no existe", szfnORAerror());
        return(FALSE);
    }

    if( iNumRegs > 0 )
    {
        for( i=0;i<iNumRegs;i++ )
        {
            pstCuadra->stRegistro[i].iNum_Cuadrante    =   ihNum_Cuadrante;
            pstCuadra->stRegistro[i].dVal_Desde        =   dahVal_Desde[i];

            if( i_shVal_Hasta[i] == ORA_NULL )
                pstCuadra->stRegistro[i].dVal_Hasta = ORA_NULL;
            else
                pstCuadra->stRegistro[i].dVal_Hasta = dahVal_Hasta[i];

            sprintf(pstCuadra->stRegistro[i].szTip_Descuento,"%.*s\0",szahTip_Descuento[i].len, szahTip_Descuento[i].arr);
            pstCuadra->stRegistro[i].dVal_Descuento    =   dahVal_Descuento   [i];

            if( i_shTip_Moneda[i] == ORA_NULL )
                sprintf(pstCuadra->stRegistro[i].szTip_Moneda,"\0");
            else
                sprintf(pstCuadra->stRegistro[i].szTip_Moneda,"%.*s\0",szahTip_Moneda[i].len, szahTip_Moneda[i].arr);

            vDTrazasLog (szExeName, "\n\t\t***** Function vPrintCuadrantesDescuentos *****"
                         "\n\t\t[%d]-Numero Cuadrante...............[%d]"
                         "\n\t\t[%d]-Valor Desde....................[%f]"
                         "\n\t\t[%d]-Valor Hasta....................[%f]"
                         "\n\t\t[%d]-Tipo Descuento.................[%s]"
                         "\n\t\t[%d]-Valor Descuento................[%f]"
                         "\n\t\t[%d]-Tipo de Moneda.................[%s]"
                         ,LOG06
                         ,i,pstCuadra->stRegistro[i].iNum_Cuadrante
                         ,i,pstCuadra->stRegistro[i].dVal_Desde
                         ,i,pstCuadra->stRegistro[i].dVal_Hasta
                         ,i,pstCuadra->stRegistro[i].szTip_Descuento
                         ,i,pstCuadra->stRegistro[i].dVal_Descuento
                         ,i,pstCuadra->stRegistro[i].szTip_Moneda)     ;
            pstCuadra->iNumCuadrantes ++;
        }
    }

    return(TRUE);

}
/*************************** Final iCargaGrupoEvalua *****************************/

/*****************************************************************************/
static double dValidaMontoMinimo()
{
    register int    i = 0 ;
    register int    x = 0 ;
    double dtotalfactura = 0.0;
    char   modulo[]="dValidaMontoMinimo";

    for( i=0;i<stPreFactura.iNumRegistros;i++ )
    {
        if( stPreFactura.A_PFactura[i].iCodTipConce!= CARRIER &&
            stPreFactura.A_PFactura[i].iCodTipConce!= IMPUESTO )
        {
            dtotalfactura += stPreFactura.A_PFactura[i].dImpFacturable;
            vDTrazasLog (modulo,"\t\tdImpFacturable [%f]  - cod_tipconce [%d]  - suma [%f]",
                         LOG04,stPreFactura.A_PFactura[i].dImpFacturable,
                         stPreFactura.A_PFactura[i].iCodTipConce, dtotalfactura);
            stPreFactura.A_PFactura[i].dImpConcDescApli = stPreFactura.A_PFactura[i].dImpFacturable;
        }

    }

    /* Actualiza Aplicacion de descuentos a conceptos */
    for( i=0;i<stPreFactura.iNumRegistros;i++ )
    {
        if( stPreFactura.A_PFactura[i].iCodTipConce== DESCUENTO )
        {
            for( x=0;x<stPreFactura.iNumRegistros;x++ )
            {
                if( stPreFactura.A_PFactura[i].iCodConceRel == stPreFactura.A_PFactura[x].iCodConcepto
                    && stPreFactura.A_PFactura[i].lColumnaRel  == stPreFactura.A_PFactura[x].lColumna     )
                {
                    stPreFactura.A_PFactura[x].dImpConcDescApli = stPreFactura.A_PFactura[x].dImpConcDescApli - fabs(stPreFactura.A_PFactura[i].dImpConcDescApli);
                }

            }
        }
    }
    vDTrazasLog (modulo,"\t\t Total de Validamonto() [%f] ",LOG04,dtotalfactura);

    return(dtotalfactura);
}

/*****************************************************************************/
static double dActualizaDescuentos()
{
    int    i = 0 ;
    double dtotalfactura = 0.0;
    char   modulo[]="dActualizaDescuentos";

    for( i=0;i<stPreFactura.iNumRegistros;i++ )
    {
        if( stPreFactura.A_PFactura[i].iCodTipConce!= CARRIER  &&
            stPreFactura.A_PFactura[i].iCodTipConce!= IMPUESTO &&
            stPreFactura.A_PFactura[i].iCodTipConce!= DESCUENTO )
        {
            dtotalfactura += stPreFactura.A_PFactura[i].dImpConcDescApli;
            vDTrazasLog (modulo,"\t\tdImpConcDescApli [%f]  - cod_tipconce [%d]  - suma [%f]",
                         LOG04,stPreFactura.A_PFactura[i].dImpConcDescApli,
                         stPreFactura.A_PFactura[i].iCodTipConce, dtotalfactura);
        }
    }

    return(dtotalfactura);
}
/*****************************************************************************/
/*****************************************************************************/

void vPrintPlanDcto (PLANDCTO *stPD)
{
    vDTrazasLog (szExeName, "\n\t\t***** Function vPrintPlanDcto *****"
                 "\n\t\t-Codigo Tipo Evaluacion....[%s]"
                 "\n\t\t-Codigo Tipo Aplicacion....[%s]"
                 "\n\t\t-Codigo Grupo Evaluacion...[%d]"
                 "\n\t\t-Codigo Grupo Aplicacion...[%d]"
                 "\n\t\t-Numero Cuadrante..........[%d]"
                 "\n\t\t-Tipo de Unidad............[%s]"
                 "\n\t\t-Codigo Concepto Descuento.[%d]"
                 "\n\t\t-Monto Minimo Facturado....[%f]"
                 ,LOG04
                 ,stPD->szCod_Tipeval         ,stPD->szCod_Tipapli
                 ,stPD->iCod_Grupoeval        ,stPD->iCod_Grupoapli
                 ,stPD->iNum_Cuadrante        ,stPD->szTip_Unidad
                 ,stPD->iCod_Concdesc         ,stPD->dMto_Minfact);


}/************************* Final vPrintPlanDcto ******************************/


/*****************************************************************************/
/*  Funcion : bEvaluaciondeConceptos                                         */
/* -Funcion que cuenta la cantidad de conceptos de evaluacion                */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bEvaluaciondeConceptos  ( PLANDCTO *stPD
                                      , GRUPOCONCEVAL *stEval
                                      , double *dTotalfac
                                      , char *szFecParam
                                      , double dTotalMontoPrefactura)
{
    register int  iInd  = 0;
    register int  iIndF = 0;
    int    iExiste = 0;
    double dtotal  = 0.0;
    double dtotalunidad = 0.0;
    char   modulo[] = "bEvaluaciondeConceptos";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhFechaAlta ;
    char szhFechaParam   [15];
    char szhFechaCliente [15];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t***** Function %s *****",LOG04, modulo);
    strcpy(szhFechaParam,szFecParam);
    strcpy(szhFechaCliente,stCliente.szFecAlta);

    if( strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0 )
    {
/* 20040413 CH-200403091728 Se agrega control por Abonado */
        if(strcmp(szEntidad, TIPOENTABONA) == 0)
        {
            for( iInd=0;iInd<stEval->iNumEval;iInd++ )
            {
                vDTrazasLog (modulo,"ABO\t Concepto Evaluacion [%d]   Cod.Grupo[%d]   Ind.Obligat[%s]",
                             LOG04,stEval->stRegistro[iInd].iCod_Concepto
                             ,stEval->stRegistro[iInd].iCod_Grupo
                             ,stEval->stRegistro[iInd].szInd_Obliga);
    
                iExiste = 0; dtotalunidad  = 0; dtotal = 0;
    
                for( iIndF=0;iIndF<stPreFactura.iNumRegistros;iIndF++ )
                {
/* 20041019 TM-200409210949 Se controla numero de unidades sin valor */
					if(stPreFactura.A_PFactura[iIndF].lNumUnidades ==0)
				    {
				      	stPreFactura.A_PFactura[iIndF].lNumUnidades =1;
				    }                
                    if( (stEval->stRegistro[iInd].iCod_Concepto == stPreFactura.A_PFactura[iIndF].iCodConcepto)
                        && (stPreFactura.A_PFactura[iIndF].lNumAbonado == lgAbonado )
                        && (stPreFactura.A_PFactura[iIndF].iCodTipConce == ARTICULO ) )
                    {
                        vDTrazasLog (modulo,"ABO\t\t* Conc.Evalua.de PreFactura [%d]"
                                     ,LOG04,stPreFactura.A_PFactura[iIndF].iCodConcepto);
                        if( strcmp(stPD->szTip_Unidad,UNIDADMINUTOS)==0 )
                        {
                            vDTrazasLog (modulo,"ABO\t\t\t Concepto por UNIDADMINUTOS ",LOG04);
                            dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
                            dtotal += stPreFactura.A_PFactura[iIndF].lSegConsumido;
                            iExiste = 1;
                        }
                        else if( strcmp(stPD->szTip_Unidad,MONTOFACTURA)==0 )
                        {
	                        vDTrazasLog (modulo,"ABO\t\t\t Concepto por MONTOFACTURA ",LOG04);
	                    
	                        if( strcmp(stPreFactura.A_PFactura[iIndF].szCodModulo,"TA")==0 )
	                        {
		                        dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable );
		                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable ); 
		                        iExiste = 1;
	                        }
	                        else
	                        {
	                        	dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
		                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
		                        iExiste = 1;
	                        }
                        }
                        vDTrazasLog (modulo,"ABO\t\t\t Valor Monto por Concepto [%f] ",LOG04,dtotal);
                    }
                }
    
                if( (iExiste == 0) && (strcmp(stEval->stRegistro[iInd].szInd_Obliga,CONCEPTOBLIGADO)==0) )
                {
                    *dTotalfac = 0.0;
                    vDTrazasLog (modulo,"\nABO\t\t* Concepto [%d] es Obligatorio y no Existe en PreFactura",LOG04,stEval->stRegistro[iInd].iCod_Concepto);
                    return(TRUE);
                }
                if( (stEval->stRegistro[iInd].dMto_MinFact > 0) && (dtotalunidad < stEval->stRegistro[iInd].dMto_MinFact) )
                {
                    *dTotalfac = 0.0;
                    vDTrazasLog (modulo,"\nABO\t\t* Monto Acumulado es menor al Minimo a Facturar"
                                 "\nABO\t\t* Monto Acumulado [%f] Minimo a Facturar[%f]"
                                 ,LOG04,dtotalunidad,stEval->stRegistro[iInd].dMto_MinFact);
                    return(TRUE);
                }
    
                *dTotalfac += dtotal;
                vDTrazasLog (modulo,"ABO\t\t------> Monto Total a Calcular es [%f]\n",LOG04,*dTotalfac);
            }
        }
        else
        {
            for( iInd=0;iInd<stEval->iNumEval;iInd++ )
            {
                vDTrazasLog (modulo,"\tConcepto Evaluacion [%d]   Cod.Grupo[%d]   Ind.Obligat[%s]",
                             LOG04,stEval->stRegistro[iInd].iCod_Concepto
                             ,stEval->stRegistro[iInd].iCod_Grupo
                             ,stEval->stRegistro[iInd].szInd_Obliga);
    
                iExiste = 0; dtotalunidad  = 0; dtotal = 0;
    
                for( iIndF=0;iIndF<stPreFactura.iNumRegistros;iIndF++ )
                {
                    if( (stEval->stRegistro[iInd].iCod_Concepto == stPreFactura.A_PFactura[iIndF].iCodConcepto)
                        && (stPreFactura.A_PFactura[iIndF].iCodTipConce == ARTICULO ) )
                    {
                        vDTrazasLog (modulo,"\t\t*Conc.Evalua.de PreFactura [%d]"
                                     ,LOG04,stPreFactura.A_PFactura[iIndF].iCodConcepto);
                        if( strcmp(stPD->szTip_Unidad,UNIDADMINUTOS)==0 )
                        {
                            vDTrazasLog (modulo,"\t\t\t Concepto por UNIDADMINUTOS ",LOG04);
                            dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
                            dtotal += stPreFactura.A_PFactura[iIndF].lSegConsumido;
                            iExiste = 1;
                        }
                        else if( strcmp(stPD->szTip_Unidad,MONTOFACTURA)==0 )
                        {
	                        vDTrazasLog (modulo,"ABO\t\t\t Concepto por MONTOFACTURA ",LOG04);
	                    
	                        if( strcmp(stPreFactura.A_PFactura[iIndF].szCodModulo,"TA")==0 )
	                        {
		                        dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable );
		                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable ); 
		                        iExiste = 1;
	                        }
	                        else
	                        {
	                        	dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
		                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
		                        iExiste = 1;
	                        }
                        }
                        vDTrazasLog (modulo,"\t\t\t Valor Monto por Concepto [%f] ",LOG04,dtotal);
                    }
                }
    
                if( (iExiste == 0) && (strcmp(stEval->stRegistro[iInd].szInd_Obliga,CONCEPTOBLIGADO)==0) )
                {
                    *dTotalfac = 0.0;
                    vDTrazasLog (modulo,"\n\t\t* Concepto [%d] es Obligatorio y no Existe en PreFactura",LOG04,stEval->stRegistro[iInd].iCod_Concepto);
                    return(TRUE);
                }
                if( (stEval->stRegistro[iInd].dMto_MinFact > 0) && (dtotalunidad < stEval->stRegistro[iInd].dMto_MinFact) )
                {
                    *dTotalfac = 0.0;
                    vDTrazasLog (modulo,"\n\t\t* Monto Acumulado es menor al Minimo a Facturar"
                                 "\n\t\t* Monto Acumulado [%f] Minimo a Facturar[%f]"
                                 ,LOG04,dtotalunidad,stEval->stRegistro[iInd].dMto_MinFact);
                    return(TRUE);
                }
    
                *dTotalfac += dtotal;
                vDTrazasLog (modulo,"\t\t------> Monto Total a Calcular es [%f]\n",LOG04,*dTotalfac);
            }
        }
    }
    else
    {  /* por factura*/
        if( strcmp(stPD->szTip_Unidad,CANTIDADABONADOS)==0 )
        {
            *dTotalfac = stAbonoCli.lNumAbonados;
            vDTrazasLog (modulo,"\t\t Factura por CANTIDADABONADOS "
                         "\n\t\t Factura por [%f] ",LOG04,*dTotalfac);
        }

        if( strcmp(stPD->szTip_Unidad,ANTIGUEDADCLIENTE)==0 )
        {
            vDTrazasLog (modulo,"\t\t Factura por ANTIGUEDADCLIENTE ",LOG04);

            /* EXEC SQL
            SELECT ROUND(TO_DATE(:szhFechaParam,'yyyymmddhh24miss') - TO_DATE(:szhFechaCliente,'yyyymmddhh24miss'))
            INTO :lhFechaAlta FROM dual; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 10;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select ROUND((TO_DATE(:b0,'yyyymmddhh24miss')-TO_\
DATE(:b1,'yyyymmddhh24miss'))) into :b2  from dual ";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )351;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhFechaParam;
            sqlstm.sqhstl[0] = (unsigned long )15;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhFechaCliente;
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhFechaAlta;
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



            if( SQLCODE != SQLOK )
            {
                vDTrazasLog (modulo,"\n\t\tError en Select para Calcular de Fecha Alta",LOG03);
                iDError (szExeName,ERR000,vInsertarIncidencia,"Select para Calcular de Fecha Alta", szfnORAerror());
                return(FALSE);
            }
            if( SQLCODE == SQLOK )
                *dTotalfac = lhFechaAlta;
            vDTrazasLog (modulo,"\t\t Factura por [%f] ",LOG04,*dTotalfac);
        }
        if( strcmp(stPD->szTip_Unidad,MONTOFACTURA)==0 )
        {
            *dTotalfac = dTotalMontoPrefactura;
            vDTrazasLog (modulo,"\t\t Factura por MONTOFACTURA "
                         "\n\t\t dTotalMontoPrefactura por [%f] ",LOG04,dTotalMontoPrefactura);
            if( *dTotalfac <= stPD->dMto_Minfact )
            {
                vDTrazasLog (modulo,"\t\t--> Monto Minimo es Mayor que el Monto a Facturar"
                             "\t\t--> Monto Minimo [%f] - Monto a Facturar [%f]"
                             ,LOG04,*dTotalfac,stPD->dMto_Minfact);
                return(FALSE);
            }
            vDTrazasLog (modulo,"\t\t Factura por [%f] ",LOG04,*dTotalfac);

        }
    }
    vDTrazasLog (modulo,"\n\t***** Fin Evaluacion de Conceptos *****",LOG04);
    return(TRUE);
}

/*****************************************************************************/

/*****************************************************************************/
/*  Funcion : bAplicacionConceptos                                           */
/* -Funcion que aplica conceptos de descuentos                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bAplicacionConceptos  (long lNumAbonado, PLANDCTO *stPD ,GRUPOCONAPLI *stApli
                                   ,VALORDESCUENTO *pstDescPaso, char *szFecParam)
{
    register int    i    = 0;
    int    iInd          = 0;
    int    iNumConceptos = 0;
    char   modulo[] = "bAplicacionConceptos";
    double dImpConceptoAux ;

    vDTrazasLog (modulo,"\n\t\t***** Function bAplicacionConceptos *****"
                 "\n\t\t\t Aplicacion por PORCONCEPTO MONTO ENTRANTE [%f]"
                 "\n\t\t\t Nro. de Abonado [%ld]",LOG03, dTotalMontoPrefacDesc, lNumAbonado);

    iNumConceptos = stPreFactura.iNumRegistros;

    for( iInd=0;(iInd<stApli->iNumAplica );iInd++ )
    {
        vDTrazasLog (modulo,"\n\t\t\tConcepto de Aplicacion stApli[%d]"
                     ,LOG04,stApli->stRegistro[iInd].iCod_Concepto);

        for( i=0;(i<iNumConceptos);i++ )
        {
            if( stPreFactura.A_PFactura[i].lNumAbonado       == lNumAbonado
                && stPreFactura.A_PFactura[i].iCodConcepto      == stApli->stRegistro[iInd].iCod_Concepto
                && stPreFactura.A_PFactura[i].dImpConcDescApli  >  0 )
            {
                vDTrazasLog (modulo,"\t\t\tConcepto de Aplicacion stPrefactura [%d]"
                             ,LOG04,stPreFactura.A_PFactura[i].iCodConcepto);                             
/* P-MIX-09003*/                             
                stValDesc.stDescuentos = (VALORDESCUENTO*)realloc(stValDesc.stDescuentos,(idxDesc+1)*sizeof(VALORDESCUENTO));
                if (stValDesc.stDescuentos == NULL)
                {
                    iDError (szExeName,ERR005,vInsertarIncidencia,"stValDesc.stDescuentos");
                }
                memset(&stValDesc.stDescuentos[idxDesc],0,sizeof(VALORDESCUENTO));                             
/* P-MIX-09003*/
                strcpy(stValDesc.stDescuentos[idxDesc].szTip_Moneda     ,pstDescPaso->szTip_Moneda);
                stValDesc.stDescuentos[idxDesc].dVal_Descuento = pstDescPaso->dVal_Descuento;
                strcpy(stValDesc.stDescuentos[idxDesc].szTip_Descuento  ,pstDescPaso->szTip_Descuento);

                if( strcmp(stValDesc.stDescuentos[idxDesc].szTip_Descuento,TIPOPORCENTAJE)==0 )
                {
                    vDTrazasLog (modulo,"\t\t\tDescuento por TIPOPORCENTAJE",LOG04);
                    stValDesc.stDescuentos[idxDesc].dValor_Monto = (stPreFactura.A_PFactura[i].dImpConcepto*stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100;
                }
                else if( strcmp(stValDesc.stDescuentos[idxDesc].szTip_Descuento,TIPOMONTO)==0 )
                {
                    vDTrazasLog (modulo,"\t\t\tDescuento por TIPOMONTO",LOG04);
                    stValDesc.stDescuentos[idxDesc].dValor_Monto = stValDesc.stDescuentos[idxDesc].dVal_Descuento;
                    
                    dImpConceptoAux = stValDesc.stDescuentos[idxDesc].dValor_Monto; /* P-MIX-09003 4 */
                    
                    if( !bConversionMoneda (stCliente.lCodCliente                       ,
                                            stValDesc.stDescuentos[idxDesc].szTip_Moneda, 
                                            stDatosGener.szCodMoneFact                  ,
                                            szFecParam                                  ,
                                           &stValDesc.stDescuentos[idxDesc].dValor_Monto))
                        return(FALSE); /* P-MIX-09003 4 */                    
                    
                }
                else
                {
                    vDTrazasError (modulo,"\n\t\t\tTipo de Descuento Invalido",LOG01);
                    vDTrazasLog   (modulo,"\n\t\t\tTipo de Descuento Invalido",LOG01);
                    return(FALSE);
                }

                /* Valida que el descuento pueda ser rebajado del valor del concepto */
                if( (stPreFactura.A_PFactura[i].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto) >  0 )
                {
                    stPreFactura.A_PFactura[i].dImpConcDescApli = stPreFactura.A_PFactura[i].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto;
                }
                else
                {
                    stValDesc.stDescuentos[idxDesc].dValor_Monto = stPreFactura.A_PFactura[i].dImpConcDescApli ;
                    stPreFactura.A_PFactura[i].dImpConcDescApli     = 0 ;
                }

                stValDesc.stDescuentos[idxDesc].lNumAbonado    = lNumAbonado;
                stValDesc.stDescuentos[idxDesc].iCod_Concepto  = stApli->stRegistro[iInd].iCod_ConRel;
                stValDesc.stDescuentos[idxDesc].lNumSecuencia  = stPD->lNumSecuencia;
                stValDesc.stDescuentos[idxDesc].iPosPrefac     = i;

                stValDesc.stDescuentos[idxDesc].iNum_Cuadrante = pstDescPaso->iNum_Cuadrante;
                stValDesc.stDescuentos[idxDesc].dVal_Desde     = pstDescPaso->dVal_Desde;
                stValDesc.stDescuentos[idxDesc].dVal_Hasta     = pstDescPaso->dVal_Hasta;

                if( !bValidacionDto (&stValDesc.stDescuentos[idxDesc]) )
                {
                    vDTrazasLog (modulo,"\t\t\tConcepto No Encontrado [%d]"
                                 ,LOG03,stValDesc.stDescuentos[idxDesc].iCod_Concepto);
                    return(FALSE);
                }

                vDTrazasLog (modulo,"\n\t\t\tValor concepto.....[%f]"
                             "\n\t\t\tMonto a Descontar..[%f]"
                             ,LOG03,stPreFactura.A_PFactura[i].dImpConcepto
                             ,stValDesc.stDescuentos[idxDesc].dValor_Monto);
                dTotalMontoPrefacDesc= dTotalMontoPrefacDesc - stValDesc.stDescuentos[idxDesc].dValor_Monto;
                idxDesc++;
                stValDesc.iNumDescuentos++;
            }
        }
    }

    vDTrazasLog (modulo,"\n\t***** Fin Aplicacion de Conceptos MONTO SALIENTE [%f]*****",LOG03, dTotalMontoPrefacDesc);
    return(TRUE);
}




/*****************************************************************************/
/*****************************************************************************/
static BOOL bfnDescporConceptoCliente (long lNumAbonado, PLANDCTO *stPD,char *szFecParam
                                       , double dTotalMontoPrefactura )
{
    char   modulo[]    = "bfnDescporConceptoCliente";
    double dTotalfac   = 0.0;
    register int   x   = 0;
    int    iAbo0       = 0;

    GRUPOCONCEVAL   stEval    ;
    GRUPOCONAPLI    stApli    ;
    GRUPOCUADRANTE  stCuadra  ;
    VALORDESCUENTO  stDescPaso;

    memset (&stEval     ,0,sizeof (GRUPOCONCEVAL));
    memset (&stApli     ,0,sizeof (GRUPOCONAPLI));
    memset (&stCuadra   ,0,sizeof (GRUPOCUADRANTE));
    memset (&stDescPaso ,0,sizeof (VALORDESCUENTO));

    dAjuste = 0;

    vDTrazasLog (modulo,"\n\t\t**** Entrada en bfnDescporConceptoCliente "
                 "\n\t\t=> Nro. Abonado : [%ld]", LOG04, lNumAbonado);
    /* Rao031001: se cambia dTotalMontoPrefactura * dTotalMontoPrefacDesc */
    if( dTotalMontoPrefacDesc < stPD->dMto_Minfact )
    {
        vDTrazasLog (modulo,"\n\t**Monto a Facturar es Menor que el Monto Minimo Permitido"
                     "\n\t**Monto a Facturar [%f] **Monto Minimo Permitido [%f]"
                     ,LOG04,dTotalMontoPrefactura,stPD->dMto_Minfact);
        return(TRUE);
    }

    /*Carga Concepto de Evaluacion */
    if( !bCargaConceptoEvalua (stPD->iCod_Grupoeval,szFecParam,&stEval) )
    {
        vDTrazasLog(modulo,"*** No cargaron Conceptos de Evaluacion grupo [%d] ***",LOG05,stPD->iCod_Grupoeval);
        return(FALSE);
    }

    /*Contar cantidad de evaluaciones*/
    if( !bEvaluaciondeConceptos (stPD,&stEval, &dTotalfac, szFecParam,dTotalMontoPrefactura) )
    {
        vDTrazasLog(modulo,"*** No se Evaluaron Conceptos en grupo [%d] ***",LOG05,stPD->iCod_Grupoeval);
        return(FALSE);
    }

    vDTrazasLog  (modulo,"\n\t***** Total a Facturar por Evaluacion [%f]", LOG04,dTotalfac);

    /*calculo de descuentos */
    if( dTotalfac > 0 )
    {
        /*carga Concepto de Aplicacion*/
        if( !bCargaConceptoAplica (stPD->iCod_Grupoapli,szFecParam,&stApli) )
        {
            vDTrazasLog(modulo,"*** No cargaron Conceptos de Aplicacion grupo [%d] ***",LOG05,stPD->iCod_Grupoapli);
            return(FALSE);
        }

        if( stApli.iNumAplica > 0 )
        {
            /* Carga Cuadrante de Descuento*/
            if( !bCargaCuadrante (stPD->iNum_Cuadrante,szFecParam,&stCuadra) )
            {
                vDTrazasLog(modulo,"*** No se Cargo Cuadrante [%d] ***",LOG05,stPD->iNum_Cuadrante);
                return(FALSE);
            }

            for( x=0;x < (stAbonoCli.lNumAbonados);x++ )
            {
                if( stAbonoCli.pCicloCli[x].lNumAbonado == 0 )
                    iAbo0=-1;
            }

            if( !bCalculaDescuento(iAbo0, &stDescPaso, &stCuadra, dTotalfac) )
            {
                vDTrazasLog(modulo,"*** No se Calculo Descuento Abonado [%ld] ***",LOG02,iAbo0);
                return(FALSE);
            }

            if( (stDescPaso.dVal_Descuento != 0.0)||(stDescPaso.dVal_Descuento != 0) )
            {

                if( strcmp(stDescPaso.szTip_Descuento,TIPOMONTO)==0 )
                    dAjuste = stDescPaso.dValor_Monto - (( stDescPaso.dVal_Descuento * dTotalfac ) / 100) ;

                vDTrazasLog  (modulo,"\t\t***** Nro Abonados [%ld]", LOG04,stAbonoCli.lNumAbonados);

                /* Se Aplican a los conceptos del Abonado 0 */
                for( x=0;x < (stAbonoCli.lNumAbonados);x++ )
                {
                    if( stAbonoCli.pCicloCli[x].lNumAbonado == 0 )
                    {
                        if( !bAplicacionConceptosCliente(stAbonoCli.pCicloCli[x].lNumAbonado,
                                                         -1,
                                                         stPD,
                                                         &stApli,
                                                         &stDescPaso) )
                        {
                            vDTrazasLog(modulo,"*** No se Aplico Conceptos Cliente Abonado [%ld] ***",LOG05,stAbonoCli.pCicloCli[x].lNumAbonado);
                            return(FALSE);
                        }
                    }
                }

                /* Se Aplican a los conceptos de cada Abonado */
                for( x=0;x < (stAbonoCli.lNumAbonados);x++ )
                {
                    if( stAbonoCli.pCicloCli[x].lNumAbonado != 0 )
                    {
                        if( !bAplicacionConceptosCliente(stAbonoCli.pCicloCli[x].lNumAbonado,
                                                         stAbonoCli.pCicloCli[x].lNumAbonado,
                                                         stPD,
                                                         &stApli,
                                                         &stDescPaso) )
                        {
                            vDTrazasLog(modulo,"*** No se Aplico Conceptos Cliente Abonado [%ld] ***",LOG05,stAbonoCli.pCicloCli[x].lNumAbonado);
                            return(FALSE);
                        }
                    }
                }

                stValDesc.stDescuentos[idxDesc -1].dValor_Monto+= dAjuste;
            }
        }
    }
    else
    {
        vDTrazasLog  (modulo,"\t***** Monto de Evaluacion es [0].No se Pueden Efectuar Descuentos", LOG04);
    }
    return(TRUE);
}
/*****************************************************************************/
/*****************************************************************************/
static BOOL bfnDescporFacturaCliente (long lNumAbonado,PLANDCTO *stPD, char *szFecParam
                                      , double dTotalMontoPrefactura)
{
    char   modulo[]         = "bfnDescporFacturaCliente";
    double dTotalfac        = 0.0;
    int    x;
    int    iAbo0 = 0;

    GRUPOCONCEVAL   stEval    ;
    GRUPOCONAPLI    stApli    ;
    GRUPOCUADRANTE  stCuadra  ;
    VALORDESCUENTO  stDescPaso;

    memset (&stEval     ,0,sizeof (GRUPOCONCEVAL)) ;
    memset (&stApli     ,0,sizeof (GRUPOCONAPLI))  ;
    memset (&stCuadra   ,0,sizeof (GRUPOCUADRANTE));
    memset (&stDescPaso ,0,sizeof (VALORDESCUENTO));

    vDTrazasLog (modulo,"\n\t\t*** Entrada en bfnDescporFacturaCliente "
                 "\n\t\t=> Nro. Abonado : [%ld]", LOG04, lNumAbonado);

    /* Rao031001: se cambia dTotalMontoPrefactura * dTotalMontoPrefacDesc */
    if( dTotalMontoPrefacDesc < stPD->dMto_Minfact )
    {
        vDTrazasLog (modulo,"\n\t**Monto a Facturar es Menor que el Monto Minimo Permitido"
                     "\n\t**Monto a Facturar [%f] **Monto Minimo Permitido [%f]"
                     ,LOG04,dTotalMontoPrefactura,stPD->dMto_Minfact);
        return(TRUE);
    }

    /*Contar cantidad de evaluaciones*/
    if( !bEvaluaciondeConceptos (stPD, &stEval, &dTotalfac, szFecParam, dTotalMontoPrefactura) )
    {
        vDTrazasLog(modulo,"*** No se Evaluaron Conceptos en grupo [%d] ***",LOG05,stPD->iCod_Grupoeval);
        return(FALSE);
    }

    vDTrazasLog  (modulo,"\n\t***** Total a Facturar por Evaluacion [%f]", LOG04,dTotalfac);

    /*calculo de descuentos */
    if( dTotalfac > 0 )
    {
        /* Carga Cuadrante de Descuento*/
        if( !bCargaCuadrante (stPD->iNum_Cuadrante, szFecParam, &stCuadra) )
        {
            vDTrazasLog(modulo,"*** No se Cargo Cuadrante [%d] ***",LOG05,stPD->iNum_Cuadrante);
            return(FALSE);
        }

        for( x=0;x < (stAbonoCli.lNumAbonados);x++ ) 
        {
            if( stAbonoCli.pCicloCli[x].lNumAbonado == 0 )
                iAbo0=-1;
        }
        if( !bCalculaDescuento(iAbo0, &stDescPaso, &stCuadra, dTotalfac) )
        {
            vDTrazasLog(modulo,"*** No se Calculo Descuento Abonado [%ld] ***",LOG05,iAbo0);
            return(FALSE);
        }

        if( (stDescPaso.dVal_Descuento != 0.0)||(stDescPaso.dVal_Descuento != 0) )
        {

            for( x=0;x < (stAbonoCli.lNumAbonados);x++ )
            {
                if( !bAplicacionConceptosFacturaCliente(stAbonoCli.pCicloCli[x].lNumAbonado,
                                                        stPD,
                                                        &stDescPaso,
                                                        dTotalMontoPrefactura) )
                {
                    vDTrazasLog(modulo,"*** No se Aplico Conceptos Factura Cliente Abonado [%ld] ***",LOG05,stAbonoCli.pCicloCli[x].lNumAbonado);
                    return(FALSE);
                }
            }
        }
    }
    else
    {
        vDTrazasLog  (modulo,"\t***** Monto de Evaluacion es [0].No se Pueden Efectuar Descuentos", LOG04);
    }
    return(TRUE);
}
/*****************************************************************************/
/*  Funcion : bAplicacionConceptosCliente                                    */
/* -Funcion que aplica conceptos de descuentos                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bAplicacionConceptosCliente (long lNumAbonadoDest   , long lNumAbonadoOrig
                                         ,PLANDCTO *stPD          , GRUPOCONAPLI *stApli
                                         ,VALORDESCUENTO *stDescuentos)
{
    register int    i     = 0;
    int    iInd    		  = 0;
    int    iNumConceptos  = 0;
    char   modulo[] = "bAplicacionConceptosCliente";

    vDTrazasLog (modulo,"\n\t\t***** Function bAplicacionConceptosCliente *****"
                 "\n\t\t\t Aplicacion por CONCEPTO",LOG04);

    iNumConceptos = stPreFactura.iNumRegistros;

    for( iInd=0;(iInd<stApli->iNumAplica );iInd++ )
    {
        vDTrazasLog (modulo,"\t\tConcepto de Aplicacion stApli [%d]"
                     ,LOG04,stApli->stRegistro[iInd].iCod_Concepto);

        for( i=0;(i<iNumConceptos);i++ )
        {

            if( stPreFactura.A_PFactura[i].lNumAbonado       == lNumAbonadoOrig
                && stPreFactura.A_PFactura[i].iCodConcepto      == stApli->stRegistro[iInd].iCod_Concepto
                && stPreFactura.A_PFactura[i].dImpConcDescApli  >  0 )
            {
                vDTrazasLog (modulo ,"\t\tConcepto de Aplicacion stPrefactura [%d] [%ld] [%ld] [%ld]"
                             ,LOG04,stPreFactura.A_PFactura[i].iCodConcepto
                             ,stPreFactura.A_PFactura[i].lNumAbonado 
                             ,lNumAbonadoDest,lNumAbonadoOrig );
/* P-MIX-09003 */		        	
                stValDesc.stDescuentos = (VALORDESCUENTO*)realloc(stValDesc.stDescuentos,(idxDesc+1)*sizeof(VALORDESCUENTO));
                if (stValDesc.stDescuentos == NULL)
                {
                    iDError (szExeName,ERR005,vInsertarIncidencia,"stValDesc.stDescuentos");
                }
                memset(&stValDesc.stDescuentos[idxDesc],0,sizeof(VALORDESCUENTO));		        	
/* P-MIX-09003 */                             
                stValDesc.stDescuentos[idxDesc].dVal_Descuento= stDescuentos->dVal_Descuento;

                stValDesc.stDescuentos[idxDesc].dValor_Monto = (stPreFactura.A_PFactura[i].dImpConcepto*stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100;
                /*  Se valida que el remanente del concepto cubra el descuento */
                if( (stPreFactura.A_PFactura[i].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto) >  0 )
                {
                    stPreFactura.A_PFactura[i].dImpConcDescApli = stPreFactura.A_PFactura[i].dImpConcDescApli  - stValDesc.stDescuentos[idxDesc].dValor_Monto;
                }
                else
                {
                    stValDesc.stDescuentos[idxDesc].dValor_Monto = stPreFactura.A_PFactura[i].dImpConcDescApli ;
                    stPreFactura.A_PFactura[i].dImpConcDescApli     = 0 ;
                }

                stValDesc.stDescuentos[idxDesc].lNumSecuencia = stPD->lNumSecuencia;
                stValDesc.stDescuentos[idxDesc].lNumAbonado   = lNumAbonadoDest;
                stValDesc.stDescuentos[idxDesc].iCod_Concepto = stApli->stRegistro[iInd].iCod_ConRel;
                stValDesc.stDescuentos[idxDesc].iNum_Cuadrante= stDescuentos->iNum_Cuadrante;
                stValDesc.stDescuentos[idxDesc].dVal_Desde    = stDescuentos->dVal_Desde;
                stValDesc.stDescuentos[idxDesc].dVal_Hasta    = stDescuentos->dVal_Hasta;
                stValDesc.stDescuentos[idxDesc].iPosPrefac    = i;

                if( !bValidacionDto (&stValDesc.stDescuentos[idxDesc]) )
                {
                    vDTrazasLog (modulo,"\n\t\tConcepto No Encontrado [%d]",LOG04,stValDesc.stDescuentos[idxDesc].iCod_Concepto);
                    return(FALSE);
                }

                strcpy (stValDesc.stDescuentos[idxDesc].szTip_Descuento  ,stDescuentos->szTip_Descuento )  ;
                strcpy (stValDesc.stDescuentos[idxDesc].szTip_Moneda     ,stDescuentos->szTip_Moneda);


                if( fnCnvDouble(stValDesc.stDescuentos[idxDesc].dValor_Monto,iUSO0) != (fnCnvDouble((stPreFactura.A_PFactura[i].dImpConcepto*stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100,iUSO0)) )
                {
                    dAjuste+= ((stPreFactura.A_PFactura[i].dImpConcepto * stValDesc.stDescuentos[idxDesc].dVal_Descuento)/100) - stValDesc.stDescuentos[idxDesc].dValor_Monto ;
                }

                vDTrazasLog (modulo,"\n\t\t\tNumero Abonado.....[%ld]"
                             "\n\t\t\tValor descuento....[%f]"
                             "\n\t\t\tValor concepto.....[%f]"
                             "\n\t\t\tMonto a descontar..[%f]"
                             "\n\t\t\tMonto de Ajuste....[%f]"
                             ,LOG04,stValDesc.stDescuentos[idxDesc].lNumAbonado
                             ,stValDesc.stDescuentos[idxDesc].dVal_Descuento
                             ,stPreFactura.A_PFactura[i].dImpFacturable
                             ,stValDesc.stDescuentos[idxDesc].dValor_Monto
                             ,dAjuste);
                dTotalMontoPrefacDesc= dTotalMontoPrefacDesc - stValDesc.stDescuentos[idxDesc].dValor_Monto;
                idxDesc++;
                stValDesc.iNumDescuentos++;
            }
        }
    }
    vDTrazasLog (modulo,"\n\t***** Fin Aplicacion de Conceptos *****",LOG04);
    return(TRUE);
}

/*****************************************************************************/
/*  Funcion : bAplicacionConceptosFacturaCliente                             */
/* -Funcion que aplica conceptos de descuentos                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bAplicacionConceptosFacturaCliente (long lNumAbonado, PLANDCTO *stPD
                                                , VALORDESCUENTO *stDescuentos
                                                , double dTotalMontoPrefactura )
{
    int    i       = 0;
    char   modulo[] = "bAplicacionConceptosFacturaCliente";

    vDTrazasLog (modulo,"\n\t***** Function bAplicacionConceptosFacturaCliente *****",LOG04);

    if( dTotalMontoPrefactura > 0 )
    {
        for( i=0;i<stPreFactura.iNumRegistros;i++ )
        {
            if( stPreFactura.A_PFactura[i].iCodTipConce!= CARRIER  &&
                stPreFactura.A_PFactura[i].iCodTipConce!= IMPUESTO &&
                stPreFactura.A_PFactura[i].lNumAbonado == lNumAbonado )
            {
		        if( stPreFactura.A_PFactura[i].dImpConcDescApli > 0 )
		        {		        	
/* P-MIX-09003 */		        	
                            stValDesc.stDescuentos = (VALORDESCUENTO*)realloc(stValDesc.stDescuentos,(idxDesc+1)*sizeof(VALORDESCUENTO));
                            if (stValDesc.stDescuentos == NULL)
                            {
                                iDError (szExeName,ERR005,vInsertarIncidencia,"stValDesc.stDescuentos");
                            }
                            memset(&stValDesc.stDescuentos[idxDesc],0,sizeof(VALORDESCUENTO));		        	
/* P-MIX-09003 */
		            stValDesc.stDescuentos[idxDesc].iCod_Concepto = stPD->iCod_Concdesc;
		            stValDesc.stDescuentos[idxDesc].lNumSecuencia = stPD->lNumSecuencia;
		            stValDesc.stDescuentos[idxDesc].iPosPrefac=i;
		            strcpy(stValDesc.stDescuentos[idxDesc].szTip_Moneda     ,stDescuentos->szTip_Moneda);
		            strcpy(stValDesc.stDescuentos[idxDesc].szTip_Descuento  ,stDescuentos->szTip_Descuento);
		            stValDesc.stDescuentos[idxDesc].dVal_Descuento = stDescuentos->dVal_Descuento;
		            stValDesc.stDescuentos[idxDesc].lNumAbonado   = lNumAbonado;
		
		            vDTrazasLog (modulo,"\t\tCodigo Concepto......[%d]",LOG04,stValDesc.stDescuentos[idxDesc].iCod_Concepto);
		
		            if( !bValidacionDto (&stValDesc.stDescuentos[idxDesc]) )
		            {
		                vDTrazasLog (modulo,"\t\tConcepto No Encontrado [%d]"
		                             ,LOG04,stValDesc.stDescuentos[idxDesc].iCod_Concepto);
		                return(FALSE);
		            }
		            /* RAO20021213: Se asume que se aplica por porcentaje, y por monto se convirtio en % */
		            vDTrazasLog (modulo,"\t\tDescuento por TIPOPORCENTAJE",LOG04);
		            stValDesc.stDescuentos[idxDesc].dValor_Monto = (stPreFactura.A_PFactura[i].dImpFacturable * stValDesc.stDescuentos[idxDesc].dVal_Descuento);
		            stValDesc.stDescuentos[idxDesc].dValor_Monto =  stValDesc.stDescuentos[idxDesc].dValor_Monto / 100;
		 
					vDTrazasLog (modulo,"\n\t\t\tMonto Concepto dcto. a aplicar: [%f]",LOG04,stPreFactura.A_PFactura[i].dImpConcDescApli);
					if ((stPreFactura.A_PFactura[i].dImpConcDescApli - stValDesc.stDescuentos[idxDesc].dValor_Monto) < 0) /* rao 18012006 */
						stValDesc.stDescuentos[idxDesc].dValor_Monto = stPreFactura.A_PFactura[i].dImpConcDescApli;
		
					stPreFactura.A_PFactura[i].dImpConcDescApli = stPreFactura.A_PFactura[i].dImpConcDescApli - stValDesc.stDescuentos[idxDesc].dValor_Monto ;
					
		            dTotalMontoPrefacDesc= dTotalMontoPrefacDesc - stValDesc.stDescuentos[idxDesc].dValor_Monto;
		
		            if( stValDesc.stDescuentos[idxDesc].dValor_Monto > dTotalMontoPrefactura )
		                stValDesc.stDescuentos[idxDesc].dValor_Monto = dTotalMontoPrefactura;
		
		            vDTrazasLog (modulo,"\n\t\t\tMonto a Descontar..[%f]",LOG04,stValDesc.stDescuentos[idxDesc].dValor_Monto);
		
		            idxDesc++;
		            stValDesc.iNumDescuentos++;
		        }
		 	}
		}
	}
    return(TRUE);

}

/******************************************************************************/
void vfnPrintCuadrante (VALORDESCUENTO* stDescuentos)
{
    char   modulo[] = "vfnPrintCuadrante";

    vDTrazasLog (modulo,"\n\t\t\t***** Registro del Cuadrante seleccionado *****"
                 "\n\t\t\tNumero Cuadrante......[%d]"
                 "\n\t\t\tCodigo Concepto.......[%d]"
                 "\n\t\t\tDescripcion Concepto..[%s]"
                 "\n\t\t\tValor Desde...........[%f]"
                 "\n\t\t\tValor Hasta...........[%f]"
                 "\n\t\t\tValor Descuento.......[%f]"
                 "\n\t\t\tTipo de Descuento.....[%s]"
                 "\n\t\t\tTipo de Moneda........[%s]"
                 "\n\t\t\tValor Monto...........[%f]"
                 ,LOG05
                 ,stDescuentos->iNum_Cuadrante
                 ,stDescuentos->iCod_Concepto
                 ,stDescuentos->szDescConcepto
                 ,stDescuentos->dVal_Desde
                 ,stDescuentos->dVal_Hasta
                 ,stDescuentos->dVal_Descuento
                 ,stDescuentos->szTip_Descuento
                 ,stDescuentos->szTip_Moneda
                 ,stDescuentos->dValor_Monto);

}

/*****************************************************************************/
/*  Funcion :                                                 */
/* -Funcion que calcula el cuadrante de descuento                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bCalculaDescuento ( long lNumAbonado
                                , VALORDESCUENTO *stValDesc1
                                , GRUPOCUADRANTE *stCuadra
                                , double dTotalfac)
{
    int    i        = 0;
    int    iExiste  = 0;
    char   modulo[] = "bCalculaDescuento";


    vDTrazasLog (modulo,"\n\t***** Function bCalculaDescuento *****"
                 "\n\t\t Monto Cuadrante Entrada [%f]"
                 "\n\t\t Abonado : [%ld]",LOG04,dTotalfac,lNumAbonado );

    for( i=0;i<stCuadra->iNumCuadrantes;i++ )
    {
        if( (dTotalfac >= stCuadra->stRegistro[i].dVal_Desde)
            && (dTotalfac <=stCuadra->stRegistro[i].dVal_Hasta) )
        {
            stValDesc1->iNum_Cuadrante    = stCuadra->stRegistro[i].iNum_Cuadrante;
            stValDesc1->dVal_Desde        = stCuadra->stRegistro[i].dVal_Desde;
            stValDesc1->dVal_Hasta        = stCuadra->stRegistro[i].dVal_Hasta;

            strcpy(stValDesc1->szTip_Descuento  ,stCuadra->stRegistro[i].szTip_Descuento);

            if( lNumAbonado == -1 || lNumAbonado == 0 )
            {   /* se convierte del monto a porcentaje si el Dcto. se aplica al cliente */
                /* lPaso= stCuadra->stRegistro[i].dVal_Descuento; */
                if( strcmp(stValDesc1->szTip_Descuento,TIPOMONTO)==0 )
                {
                    stValDesc1->dVal_Descuento    = (( stCuadra->stRegistro[i].dVal_Descuento * 100 ) / dTotalfac);
                    strcpy( stValDesc1->szTip_Descuento,TIPOPORCENTAJE);
                }
                else
                {
                    stValDesc1->dVal_Descuento    = stCuadra->stRegistro[i].dVal_Descuento;
                }
            }
            else
            {
                stValDesc1->dVal_Descuento    = stCuadra->stRegistro[i].dVal_Descuento;
            }

            strcpy(stValDesc1->szTip_Moneda     ,stCuadra->stRegistro[i].szTip_Moneda);

            vDTrazasLog (modulo,"\n\t\tNumero Cuadrante.....[%d]"
                         "\n\t\tValor Desde..........[%f]"
                         "\n\t\tValor Hasta..........[%f]"
                         "\n\t\tValor Descuento......[%f]"
                         "\n\t\tTipo de Descuento....[%s]"
                         "\n\t\tTipo de Moneda.......[%s]"
                         ,LOG03,stValDesc1->iNum_Cuadrante
                         ,stValDesc1->dVal_Desde
                         ,stValDesc1->dVal_Hasta
                         ,stValDesc1->dVal_Descuento
                         ,stValDesc1->szTip_Descuento
                         ,stValDesc1->szTip_Moneda);

            iExiste = 1;
            break;
        }
    }

    if( iExiste == 0 )
    {
        vDTrazasLog (modulo,"\n\t\t**No se Encontro Valor en Cuadrante. No se aplica Descuento, abonado [%ld]",LOG03, lNumAbonado);
    }

    return(TRUE);
}

static BOOL bValidacionDto (VALORDESCUENTO *stValDesc1)
{
    char modulo [] = "bValidacionDto";
    int iRes = 0;
    CONCEPTO stConcepto;
    memset (&stConcepto,0,sizeof (CONCEPTO));

    vDTrazasLog (modulo,"\n\t\t** Entrada en bValidacionDto **"
                 "\n\t\t=> Cod. Concepto [%d] ",LOG04,stValDesc1->iCod_Concepto );

    if( !bFindConcepto (stValDesc1->iCod_Concepto,&stConcepto) )
    {
        vDTrazasLog (modulo,"\n\t\tNo Existe Cod_Concepto en Funcion bFindConcepto..[%d]",LOG04,stValDesc1->iCod_Concepto);
        sprintf (stAnomProceso.szObsAnomalia,"Concepto no encontrado [%d]",
                 stValDesc1->iCod_Concepto);
        iRes = ERR015;
    }
    else
    {
        if( stConcepto.iIndActivo == 0 )
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
                     stConcepto.iIndActivo);
            iRes = ERR001;
        }
        else if( stConcepto.iCodTipConce != DESCUENTO )
        {
            sprintf (stAnomProceso.szObsAnomalia,"%s %d",
                     "Tipo de Concepto (Impuesto o Articulo)",
                     stConcepto.iCodTipConce);
            iRes = ERR001;
        }

        if( iRes != 0 )
        {
            stAnomProceso.iCodConcepto = stValDesc1->iCod_Concepto  ;
            stAnomProceso.iCodProducto = 0  ;
            strcpy (stAnomProceso.szDesProceso,"PreBilling.Descuento");
            stAnomProceso.lNumAbonado  = 0;

            /*stEstDtos.iNumAnomalias++;*/
            vDTrazasLog (modulo,"\n\t\tAnomalias en Validacion de Descuento",LOG03);
            iDError (szExeName,ERR001,vInsertarIncidencia,"Anomalias en Validacion de Descuento");
        }
        else
        {
            strncpy(stValDesc1->szDescConcepto,stConcepto.szDesConcepto, 60);
        }
    }

    return(iRes == 0)?TRUE:FALSE;

}/************************** Final bValidacionDto ***************************/

/*****************************************************************************/
/*****************************************************************************/
/*  Funcion : bCargaPreFactura                                               */
/* -Funcion que carga nuevo registro en PreFactura                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bCargaPreFactura ( int iNumConceptos, VALORDESCUENTO *pstDesc)
{
    int iNumTotDto    = 0;
    int iNumTotDtoSac = 0;
    int iNumTotDtoSer = 0;
    int iNumTotDtoTra = 0;
    int iNumTotDtoAbo = 0;
    int idzAbon = 0;
    int idzPlan = 0;
    char modulo[] = "bCargaPreFactura";

    vDTrazasLog (modulo,"\n\t***** Function bCargaPreFactura *****"
                 "\n\t\tValor de Descuento a Cargar en Prefactura [%f]"
                 "\n\t\tNumero Indice-----> iNumconceptos=[%d]",LOG04, pstDesc->dValor_Monto, iNumConceptos);

    if( pstDesc->dValor_Monto!=0.00 )
    {
        stPreFactura.A_PFactura[iNumConceptos].dImpMontoBase  = (pstDesc->dValor_Monto)*-1;
        stPreFactura.A_PFactura[iNumConceptos].dImpFacturable = fnCnvDouble ((pstDesc->dValor_Monto)*-1,iUSO0);
        stPreFactura.A_PFactura[iNumConceptos].dImpConcepto   = (pstDesc->dValor_Monto)*-1;
        stPreFactura.A_PFactura[iNumConceptos].lNumAbonado    = pstDesc->lNumAbonado;
        stPreFactura.A_PFactura[iNumConceptos].iCodConcepto   = pstDesc->iCod_Concepto;
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szCodMoneda,stDatosGener.szCodMoneFact);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szDesConcepto,pstDesc->szDescConcepto);

        stPreFactura.A_PFactura[iNumConceptos].lNumProceso    = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lNumProceso ;
        stPreFactura.A_PFactura[iNumConceptos].lCodCliente    = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lCodCliente ;

        if( !bGetMaxColPreFa(stPreFactura.A_PFactura[iNumConceptos].iCodConcepto,
                             &stPreFactura.A_PFactura[iNumConceptos].lColumna ) )
            return(FALSE);

        stPreFactura.A_PFactura[iNumConceptos].iCodProducto   = stPreFactura.A_PFactura[pstDesc->iPosPrefac].iCodProducto ;
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szFecValor,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szFecValor);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szFecEfectividad,szSysDate);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szCodRegion,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szCodRegion);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szCodProvincia,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szCodProvincia);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szCodCiudad,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szCodCiudad);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szCodModulo,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szCodModulo);

        stPreFactura.A_PFactura[iNumConceptos].lCodPlanCom    = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lCodPlanCom ;
        stPreFactura.A_PFactura[iNumConceptos].iIndFactur     = FACTURABLE;
        stPreFactura.A_PFactura[iNumConceptos].iCodCatImpos   = stPreFactura.A_PFactura[pstDesc->iPosPrefac].iCodCatImpos;
        stPreFactura.A_PFactura[iNumConceptos].iIndEstado     = EST_NORMAL;
        stPreFactura.A_PFactura[pstDesc->iPosPrefac].iIndEstado                 = EST_DTO   ;
        stPreFactura.A_PFactura[iNumConceptos].iCodTipConce   = DESCUENTO ;
        stPreFactura.A_PFactura[iNumConceptos].lNumUnidades   = 1         ; /* Incorporado por PGonzaleg 4-03-2002 */
        stPreFactura.A_PFactura[iNumConceptos].lCodCiclFact   = stCiclo.lCodCiclFact;

        stPreFactura.A_PFactura[iNumConceptos].iCodConceRel = stPreFactura.A_PFactura[pstDesc->iPosPrefac].iCodConcepto;
        stPreFactura.A_PFactura[iNumConceptos].lColumnaRel  = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lColumna    ;
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szNumTerminal,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szNumTerminal);
        stPreFactura.A_PFactura[iNumConceptos].lCapCode     = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lCapCode;
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szNumSerieMec ,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szNumSerieMec);
        strcpy (stPreFactura.A_PFactura[iNumConceptos].szNumSerieLe  ,stPreFactura.A_PFactura[pstDesc->iPosPrefac].szNumSerieLe );
        stPreFactura.A_PFactura[iNumConceptos].lNumVenta    = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lNumVenta ;
        stPreFactura.A_PFactura[iNumConceptos].lNumTransaccion = stPreFactura.A_PFactura[pstDesc->iPosPrefac].lNumTransaccion ;

        stPreFactura.A_PFactura[iNumConceptos].iFlagImpues   = 0  ;
        stPreFactura.A_PFactura[iNumConceptos].iFlagDto      = 0  ;
        stPreFactura.A_PFactura[pstDesc->iPosPrefac].iFlagDto      = 1  ;
        stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto  = 0.0;
        stPreFactura.A_PFactura[iNumConceptos].dValDto       = 0.0;
        stPreFactura.A_PFactura[iNumConceptos].iTipDto       = 0  ;
        stPreFactura.A_PFactura[iNumConceptos].iMesGarantia  = 0;
        stPreFactura.A_PFactura[iNumConceptos].iIndAlta      = 0;
        stPreFactura.A_PFactura[iNumConceptos].iIndSuperTel  = 0;
        stPreFactura.A_PFactura[iNumConceptos].iNumPaquete   = 0;
        stPreFactura.A_PFactura[iNumConceptos].iIndCuota     = 0;
        stPreFactura.A_PFactura[iNumConceptos].iNumCuotas    = 0;
        stPreFactura.A_PFactura[iNumConceptos].iOrdCuota     = 0;

        if( stPreFactura.A_PFactura[pstDesc->iPosPrefac].bOptPenaliza  )
        {
            stPreFactura.A_PFactura[iNumConceptos].bOptPenaliza  = TRUE;
            iNumTotDtoSac++;
            iNumTotDto++   ;
        }
        if( stPreFactura.A_PFactura[pstDesc->iPosPrefac].bOptServicios  )
        {
            stPreFactura.A_PFactura[iNumConceptos].bOptServicios = TRUE;
            iNumTotDtoSer++;
            iNumTotDto++   ;
        }
        if( stPreFactura.A_PFactura[pstDesc->iPosPrefac].bOptAbonos  )
        {
            stPreFactura.A_PFactura[iNumConceptos].bOptAbonos  =  TRUE;
            iNumTotDtoAbo++;
            iNumTotDto++   ;
        }
        if( stPreFactura.A_PFactura[pstDesc->iPosPrefac].bOptTrafico  )
        {
            stPreFactura.A_PFactura[iNumConceptos].bOptTrafico  = TRUE;
            iNumTotDtoTra++;
            iNumTotDto++   ;
        }
        
        
        stPreFactura.A_PFactura[iNumConceptos].dhImpConversion  =  stPreFactura.A_PFactura[0].dhImpConversion;
		strcpy(stPreFactura.A_PFactura[iNumConceptos].szhCodMonedaImp  , stPreFactura.A_PFactura[0].szhCodMonedaImp);
	
	if(bfnIncrementarIndicePreFactura()==FALSE)
	{
	     vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	     vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	     return FALSE;
	}

        
        vDTrazasLog (modulo,"\n\t\tFin de la Carga de PreFactura"
                     "\n\t\t\tNumero de Proceso.....[%ld]"
                     "\n\t\t\tCodigo Cliente........[%ld]"
                     "\n\t\t\tNumero Abonado........[%ld]"
                     "\n\t\t\tCodigo Concepto.......[%d]"
                     ,LOG04,stPreFactura.A_PFactura[iNumConceptos].lNumProceso 
                     ,stPreFactura.A_PFactura[iNumConceptos].lCodCliente 
                     ,stPreFactura.A_PFactura[iNumConceptos].lNumAbonado 
                     ,pstDesc->iCod_Concepto);

        for( idzPlan=0; idzPlan<stPlanesGrupo.iNumPlanesGrupo - 1; idzPlan++ )
        {
            for( idzAbon=0; idzAbon<stPlanesGrupo.stPlanGrupo[idzPlan].iNumAbonados ; idzAbon++ )
            {
                if( !bfnMarcaDcto (stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumSecuencia) )
                    return(FALSE);
            }
        }
    }
    vDTrazasLog (modulo,"\t\t***** Fin Function bCargaPreFactura *****",LOG04);

    return(TRUE);
}/************************** Final bCargaPreFactura **********************/


/*****************************************************************************/
/*  Funcion : bfnMarcaDcto                                                   */
/* -Funcion que carga nuevo registro en PreFactura                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnMarcaDcto (long lNumSecuencia)
{
    char modulo[] = "bfnMarcaDcto";
    int i,x ;

    vDTrazasLog (modulo,"\n\t\t ********* bfnMarcaDcto ********",LOG05);
    for( i=0; i<stPlanesDesc.lNumAbonados;i++ )
    {
        for( x=0; x<stPlanesDesc.stAbonado[i].iNumPlanes;x++ )
        {
            if( stPlanesDesc.stAbonado[i].stPlanDes[x].stPD.lNumSecuencia == lNumSecuencia )
            {
                stPlanesDesc.stAbonado[i].stPlanDes[x].stPD.iCodEstado = 1;
            }
        }
    }
    return(TRUE);
}/************************* Fin bfnMarcaDcto *********************************/

static BOOL bModifBeneficios (long lNumSecuencia)
{
    char modulo[] = "bfnBeneficios";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhNumSecuencia;
    long lhCodCliente ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo, "\n\t\t***** Function bModifBeneficios *****"
		                 "\n\t\t\tNro Secuencia  [%ld]"
		                 "\n\t\t\tCliente        [%ld]"
		                 ,LOG04,lNumSecuencia, stCliente.lCodCliente);
		                 
    if (stCliente.iIndClieLoc == 0)		                 
    {
        if( lNumSecuencia >0 )
        {
            lhNumSecuencia  = lNumSecuencia;
            lhCodCliente    = stCliente.lCodCliente;
            /* EXEC SQL
        	 UPDATE BPT_BENEFICIOS
        	        SET COD_ESTADO = 'EJE' , FEC_ESTADO = SYSDATE
                 WHERE COD_CLIENTE = :lhCodCliente
                 AND NUM_SECUENCIA = :lhNumSecuencia; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 10;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update BPT_BENEFICIOS  set COD_ESTADO='EJE',FEC_E\
STADO=SYSDATE where (COD_CLIENTE=:b0 and NUM_SECUENCIA=:b1)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )378;
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



            vDTrazasLog (modulo,"\t\t\tREG ACTUALIZADOS [%ld]",LOG05,sqlca.sqlerrd[2]);

            if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
            {
                vDTrazasLog (modulo,"\n\t\tError Update de BPT_BENEFICIOS",LOG01);
                iDError (szExeName,ERR000,vInsertarIncidencia,"update BPT_BENEFICIOS Plan Dcto.", szfnORAerror());
                return(FALSE);
            }

        }
    }
    return(TRUE);
}

/*****************************************************************************/
/*  Funcion : bfnCargaPlanesGrupo                                            */
/* -Funcion que carga los planes de descuentos de Grupo                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnCargaPlanesGrupo ()
{
    int     idxAbon = 0, idxPlan = 0, idzAbon = 0, idzPlan = 0;
    char    plCodPlan[6];
    char    modulo[] = "bfnCargaPlanesGrupo";
    BOOL    bExiste=FALSE;

    vDTrazasLog (modulo,"\n\t\t***** Entrada en %s *****", LOG04, modulo);

    strcpy(plCodPlan, stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].szCod_Plandesc);

    stPlanesGrupo.iNumPlanesGrupo = 1;

    for( idxAbon=0;idxAbon < stPlanesDesc.lNumAbonados;idxAbon++ )
    {
        for( idxPlan=0;idxPlan < stPlanesDesc.stAbonado[idxAbon].iNumPlanes;idxPlan++ )
        {
            if( strcmp(stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].szTipEntidad ,TIPOENTGRUPO)==0 )
            {
                for( idzPlan=0;idzPlan<stPlanesGrupo.iNumPlanesGrupo;idzPlan++ )
                {

                    if( strcmp(stPlanesGrupo.stPlanGrupo[idzPlan].szCod_Plandesc, stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].szCod_Plandesc)==0 )
                    {
                        bExiste=TRUE;
                        break;
                    }
                }
                if( !bExiste )
                {
                    idzPlan=stPlanesGrupo.iNumPlanesGrupo-1;           
                    idzAbon = stPlanesGrupo.stPlanGrupo[idzPlan].iNumAbonados;                                   
                    stPlanesGrupo.iNumPlanesGrupo++; 
                }
                else
                {
                    idzAbon = stPlanesGrupo.stPlanGrupo[idzPlan].iNumAbonados;  /* - 1; */
                }

                stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumAbonado = stPlanesDesc.stAbonado[idxAbon].lNumAbonado;
                strcpy(stPlanesGrupo.stPlanGrupo[idzPlan].szCod_Plandesc           , stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].szCod_Plandesc);
                strcpy(stPlanesGrupo.stPlanGrupo[idzPlan].stPD.szCod_Tipeval       , stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.szCod_Tipeval);
                strcpy(stPlanesGrupo.stPlanGrupo[idzPlan].stPD.szCod_Tipapli       , stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.szCod_Tipapli);
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.iCod_Grupoeval             = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.iCod_Grupoeval;
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.iCod_Grupoapli             = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.iCod_Grupoapli;
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.iNum_Cuadrante             = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.iNum_Cuadrante;
                strcpy(stPlanesGrupo.stPlanGrupo[idzPlan].stPD.szTip_Unidad        , stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.szTip_Unidad);
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.iCod_Concdesc              = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.iCod_Concdesc;
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.dMto_Minfact               = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.dMto_Minfact;

                stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumSecuencia  = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.lNumSecuencia;
                stPlanesGrupo.stPlanGrupo[idzPlan].stPD.iCodEstado                 = stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.iCodEstado;

                vDTrazasLog (modulo ,"\n\t\t\t=> Abonado..........[%ld] *****"
                             "\n\t\t\t=> Tipo Apliicacion.[%s] *****"
                             "\n\t\t\t=> Secuencia       .[%ld] *****"
                             , LOG05, stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumAbonado
                             , stPlanesGrupo.stPlanGrupo[idzPlan].stPD.szCod_Tipapli
                             , stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumSecuencia);
                idzAbon++;
                stPlanesGrupo.stPlanGrupo[idzPlan].iNumAbonados++;
                bExiste=FALSE;

            }
            else
            {    /* Incidencia CH-1403 : Correccion a la marcacion de estado de la BPT_BENEFICIO a estado 'EJE' para los
                                         descuentos de tipo 'A' y 'C'. */
                vDTrazasLog (modulo,"\n\t\t ModifBeneficios Entidad A o C [%ld], Entidad[%s] ",LOG05, 
                             stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.lNumSecuencia, 
                             stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].szTipEntidad);
                if( !bModifBeneficios ( stPlanesDesc.stAbonado[idxAbon].stPlanDes[idxPlan].stPD.lNumSecuencia) )
                {
                    vDTrazasLog (modulo,"\n\t\t ModifBeneficios Entidad A o C RETURN FALSE. ",LOG03);
                    return(FALSE);
                }
            }
        }
    }

    vDTrazasLog (modulo ,"\n\t=> CONTENIDO DE STPLANESGRUPO..........[%ld] *****"
                 , LOG05, stPlanesGrupo.iNumPlanesGrupo);
    for( idzPlan=0; idzPlan<stPlanesGrupo.iNumPlanesGrupo - 1; idzPlan++ )
    {
        for( idzAbon=0; idzAbon<stPlanesGrupo.stPlanGrupo[idzPlan].iNumAbonados ; idzAbon++ )
        {
            vDTrazasLog (modulo ,  "\t\t\t=> lNumAbonado  [%d] ........[%ld] *****"
                         "\n\t\t\t=> lNumSecuencia[%d] ........[%ld] *****"
                         , LOG03, idzAbon, stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumAbonado,
                         idzAbon, stPlanesGrupo.stPlanGrupo[idzPlan].stAbonadosGrupo[idzAbon].lNumSecuencia);     
        }
    }
    return(TRUE);

}

/*****************************************************************************/
/*  Funcion : bfnDescporGrupo                                                */
/* -Funcion que procesa los descuentos a nivel de grupo                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnDescporGrupo ( char          *szFecParam
                              , double        dTotalMontoPrefactura )
{
    int     idxPlan = 0;
    char    modulo[] = "bfnDescporGrupo";

    vDTrazasLog (modulo,"\n\t\t***** Entrada en %s *****"
                 "\n\t\t==> Procesando Planes Grupo por Conceptos", LOG04, modulo);

    for( idxPlan=0;idxPlan < stPlanesGrupo.iNumPlanesGrupo;idxPlan++ )
    {
        vDTrazasLog (modulo, "\n\t\t\t=> Plan Descuento [%s]", LOG04
                     , stPlanesGrupo.stPlanGrupo[idxPlan].szCod_Plandesc);
        if( strcmp(stPlanesGrupo.stPlanGrupo[idxPlan].stPD.szCod_Tipapli , PORCONCEPTO)  == 0 )
        {
            if( !bfnDescporConceptoGrupo  (&stPlanesGrupo.stPlanGrupo[idxPlan].stPD
                                           ,&stPlanesGrupo.stPlanGrupo[idxPlan]
                                           ,szFecParam, dTotalMontoPrefactura) )
                return(FALSE);
        }
    }

    vDTrazasLog (modulo,"\n\t\t==> Procesando Planes Grupo por Factura", LOG04);

    for( idxPlan=0;idxPlan < stPlanesGrupo.iNumPlanesGrupo;idxPlan++ )
    {
        if( strcmp(stPlanesGrupo.stPlanGrupo[idxPlan].stPD.szCod_Tipeval , PORFACTURA)   == 0 )
        {
            if( !bfnDescporConceptoGrupo ( &stPlanesGrupo.stPlanGrupo[idxPlan].stPD
                                           ,&stPlanesGrupo.stPlanGrupo[idxPlan]
                                           ,szFecParam, dTotalMontoPrefactura) )
                return(FALSE);
        }
    }
    return(TRUE);
}

/*****************************************************************************/
/*  Funcion : bfnDescporConceptoGrupo                                        */
/* -Funcion que procesa los descuentos de grupo por conceptos                */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bfnDescporConceptoGrupo ( PLANDCTO      *stPD
                                      , PLANGRUPO     *pstPlanGrupo
                                      , char          *szFecParam
                                      , double        dTotalMontoPrefactura)
{

    char    modulo[]        = "bfnDescporConceptoGrupo";
    int     idxAbon         = 0;

    GRUPOCONCEVAL  stEval   ;
    GRUPOCONAPLI   stApli   ;
    GRUPOCUADRANTE stCuadra ;
    VALORDESCUENTO stDescPaso;

    vDTrazasLog (modulo,"\n\t\t*** Entrada en %s ", LOG04, modulo);


    memset (&stEval     ,0,sizeof (GRUPOCONCEVAL));
    memset (&stApli     ,0,sizeof (GRUPOCONAPLI));
    memset (&stCuadra   ,0,sizeof (GRUPOCUADRANTE));
    memset (&stDescPaso ,0,sizeof (VALORDESCUENTO));

    if( dTotalMontoPrefacDesc < stPD->dMto_Minfact )
    {
        vDTrazasLog (modulo,"\n\t**Monto a Facturar es Menor que el Monto Minimo Permitido"
                     "\n\t**Monto a Facturar [%f] **Monto Minimo Permitido [%f]"
                     ,LOG04,dTotalMontoPrefacDesc,stPD->dMto_Minfact);
        return(TRUE);
    }

    /*Carga Conceptos de Evaluacion */
    if( !bCargaConceptoEvalua (stPD->iCod_Grupoeval,szFecParam,&stEval) )
        return(FALSE);

    /*carga Concepto de Aplicacion*/
    if( !bCargaConceptoAplica (stPD->iCod_Grupoapli,szFecParam,&stApli) )
        return(FALSE);

/* SAAM-20030526 Se modifica salida segun incidecia CH-200520030751 para que solo siga si el indicador d conceptos a aplicar es mayor que cero */

    if( stApli.iNumAplica > 0 )
    {
        /* Carga Cuadrante de Descuento*/
        if( !bCargaCuadrante (stPD->iNum_Cuadrante,szFecParam,&stCuadra) )
            return(FALSE);

        /*Contar cantidad de evaluaciones*/
        if( !bfnEvaluaciondeConceptosGrupo (stPD,&stEval,pstPlanGrupo,szFecParam,dTotalMontoPrefactura) )
            return(FALSE);

        vDTrazasLog (modulo,"\n\t***** Total a Facturar por Evaluacion [%f]",LOG05,pstPlanGrupo->dTotMonto);

        /*calculo de descuentos */
        if( pstPlanGrupo->dTotMonto <= 0 )
        {
            vDTrazasLog(modulo,"\t***** Monto de Evaluacion es [0].No se Pueden Efectuar Descuentos",LOG04);
        }
        else
        {
            if( !bCalculaDescuento( -1, &stDescPaso, &stCuadra, pstPlanGrupo->dTotMonto) )
                return(FALSE);

/* SAAM-20030526 Evaluamos que el descuento sea mayor a cero */
            if( (stDescPaso.dVal_Descuento != 0.0)||(stDescPaso.dVal_Descuento != 0) )
            {
                /*contar cantidad de aplicaciones*/
                for( idxAbon=0; idxAbon < pstPlanGrupo->iNumAbonados;idxAbon++ )
                {

                    if( !bAplicacionConceptos ( pstPlanGrupo->stAbonadosGrupo[idxAbon].lNumAbonado,
                                                stPD,
                                                &stApli,
                                                &stDescPaso,
                                                szFecParam) )
                        return(FALSE);
                    vfnPrintCuadrante(&stValDesc.stDescuentos[idxDesc-1]);
                }
            }
        }
    }
    return(TRUE);
}


/*****************************************************************************/
/*  Funcion : bfnEvaluaciondeConceptosGrupo                                  */
/* -Funcion que evalua los conceptos de evaluacion                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
static BOOL bfnEvaluaciondeConceptosGrupo ( PLANDCTO      *stPD
                                            , GRUPOCONCEVAL *stEval
                                            , PLANGRUPO     *pstPlanGrupo
                                            , char          *szFecParam
                                            , double        dTotalMontoPrefactura)
{
    int    iInd    = 0, iIndF   = 0, iExiste = 0, idxAbon = 0;
    double dtotal  = 0.0;
    double dtotalunidad = 0.0;
    char   modulo[] = "bfnEvaluaciondeConceptosGrupo";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhFechaAlta ;
    char szhFechaParam   [15];
    char szhFechaCliente [15];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo,"\n\t***** Function bfnEvaluaciondeConceptosGrupo *****",LOG04);
    strcpy(szhFechaParam,szFecParam);
    strcpy(szhFechaCliente,stCliente.szFecAlta);

    if( strcmp(stPD->szCod_Tipeval,PORCONCEPTO)==0 )
    {
        for( iInd=0;iInd<stEval->iNumEval;iInd++ )
        {
            vDTrazasLog (modulo,"\tConcepto Evaluacion [%d]   Cod.Grupo[%d]   Ind.Obligat[%s]",
                         LOG04,stEval->stRegistro[iInd].iCod_Concepto
                         ,stEval->stRegistro[iInd].iCod_Grupo
                         ,stEval->stRegistro[iInd].szInd_Obliga);

            iExiste = 0;

            for( iIndF=0;iIndF<stPreFactura.iNumRegistros;iIndF++ )
            {
                if( (stEval->stRegistro[iInd].iCod_Concepto == stPreFactura.A_PFactura[iIndF].iCodConcepto)
                    && (stPreFactura.A_PFactura[iIndF].iCodTipConce == ARTICULO ) )
                {
                    for( idxAbon=0; idxAbon < pstPlanGrupo->iNumAbonados; idxAbon++ )
                    {
                        if( pstPlanGrupo->stAbonadosGrupo[idxAbon].lNumAbonado == stPreFactura.A_PFactura[iIndF].lNumAbonado )
                        {
                            vDTrazasLog (modulo,"\t\t*Conc.Evalua.de PreFactura [%d]"
                                         ,LOG04,stPreFactura.A_PFactura[iIndF].iCodConcepto);
                            if( strcmp(stPD->szTip_Unidad,UNIDADMINUTOS)==0 )
                            {
                                vDTrazasLog (modulo,"\t\t\t Concepto por UNIDADMINUTOS ",LOG04);
                                pstPlanGrupo->lTotUnidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
                                pstPlanGrupo->dTotMonto  += stPreFactura.A_PFactura[iIndF].lSegConsumido;
                                iExiste = 1;
                            }
                            else if( strcmp(stPD->szTip_Unidad,MONTOFACTURA)==0 )
	                        {
		                        vDTrazasLog (modulo,"ABO\t\t\t Concepto por MONTOFACTURA ",LOG04);
		                    
		                        if( strcmp(stPreFactura.A_PFactura[iIndF].szCodModulo,"TA")==0 )
		                        {
			                        dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable );
			                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable ); 
			                        iExiste = 1;
		                        }
		                        else
		                        {
		                        	dtotalunidad += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
			                        dtotal += (stPreFactura.A_PFactura[iIndF].dImpFacturable * stPreFactura.A_PFactura[iIndF].lNumUnidades ); /* Incorporado por PGonzaleg 4-03-2002 */
			                        iExiste = 1;
		                        }
	                        }
                            vDTrazasLog (modulo,"\t\t\t Valor Monto por Concepto [%f] ",LOG04,pstPlanGrupo->dTotMonto);
                        }
                    }
                }
            }

            if( (strcmp(stEval->stRegistro[iInd].szInd_Obliga,CONCEPTOBLIGADO)==0) && (iExiste == 0) )
            {
                pstPlanGrupo->dTotMonto = 0.0;
                vDTrazasLog (modulo,"\n\t\t* Concepto [%d] es Obligatorio y no Existe en PreFactura",LOG04,stEval->stRegistro[iInd].iCod_Concepto);
                return(TRUE);
            }
            if( (stEval->stRegistro[iInd].dMto_MinFact > 0) && (pstPlanGrupo->lTotUnidad < stEval->stRegistro[iInd].dMto_MinFact) )
            {
                pstPlanGrupo->dTotMonto = 0.0;
                vDTrazasLog (modulo,"\n\t\t* Monto Acumulado es menor al Minimo a Facturar"
                             "\n\t\t* Monto Acumulado [%f] Minimo a Facturar[%f]"
                             ,LOG04,pstPlanGrupo->lTotUnidad,stEval->stRegistro[iInd].dMto_MinFact);
                return(TRUE);
            }

            vDTrazasLog (modulo,"\t\t------> Monto Total a Calcular es [%f]\n",LOG04,pstPlanGrupo->dTotMonto);
        }
    }
    else
    {  /* por factura*/
        if( strcmp(stPD->szTip_Unidad,CANTIDADABONADOS)==0 )
        {
            pstPlanGrupo->dTotMonto = pstPlanGrupo->iNumAbonados;
            vDTrazasLog (modulo,"\t\t Factura por CANTIDADABONADOS "
                         "\n\t\t Factura por [%f] ",LOG04,pstPlanGrupo->dTotMonto);
        }

        if( strcmp(stPD->szTip_Unidad,ANTIGUEDADCLIENTE)==0 )
        {
            vDTrazasLog (modulo,"\t\t Factura por ANTIGUEDADCLIENTE ",LOG04);

            /* EXEC SQL
            SELECT ROUND(TO_DATE(:szhFechaParam,'yyyymmddhh24miss') - TO_DATE(:szhFechaCliente,'yyyymmddhh24miss'))
            INTO :lhFechaAlta FROM dual; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 10;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select ROUND((TO_DATE(:b0,'yyyymmddhh24miss')-TO_\
DATE(:b1,'yyyymmddhh24miss'))) into :b2  from dual ";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )401;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)szhFechaParam;
            sqlstm.sqhstl[0] = (unsigned long )15;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhFechaCliente;
            sqlstm.sqhstl[1] = (unsigned long )15;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)&lhFechaAlta;
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



            if( SQLCODE != SQLOK )
            {
                vDTrazasLog (modulo,"\n\t\tError en Select para Calcular de Fecha Alta",LOG03);
                iDError (szExeName,ERR000,vInsertarIncidencia,"Select para Calcular de Fecha Alta", szfnORAerror());
                return(FALSE);
            }
            if( SQLCODE == SQLOK )
                pstPlanGrupo->dTotMonto = lhFechaAlta;
            vDTrazasLog (modulo,"\t\t Factura por [%f] ",LOG04,pstPlanGrupo->dTotMonto);
        }
        if( strcmp(stPD->szTip_Unidad,MONTOFACTURA)==0 )
        {
            pstPlanGrupo->dTotMonto = dTotalMontoPrefactura;
            vDTrazasLog (modulo,"\t\t Factura por MONTOFACTURA "
                         "\n\t\t dTotalMontoPrefactura por [%f] ",LOG04,dTotalMontoPrefactura);
            if( pstPlanGrupo->dTotMonto <= stPD->dMto_Minfact )
            {
                vDTrazasLog (modulo,"\t\t--> Monto Minimo es Mayor que el Monto a Facturar"
                             "\t\t--> Monto Minimo [%f] - Monto a Facturar [%f]"
                             ,LOG04,pstPlanGrupo->dTotMonto,stPD->dMto_Minfact);
                return(FALSE);
            }
            vDTrazasLog (modulo,"\t\t Factura por [%f] ",LOG04,pstPlanGrupo->dTotMonto);

        }
    }
    vDTrazasLog (modulo,"\n\t***** Fin Evaluacion de Conceptos *****",LOG04);
    return(TRUE);
}

/******************************************************************************************/

/******************************************************************************
Funcion         :       ifnOraDeclararGatPlanDescAbo
*******************************************************************************/

static int ifnOraDeclararGatPlanDescAbo (long lCodCliente)
{
    char    szCadena [512]="";
    char    szNomTabla [256]="";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodCliente;
    long lhCodCiclFact;
    int  ihZero;
    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodCliente  = lCodCliente ;
    lhCodCiclFact = stCiclo.lCodCiclFact;
    ihZero    = 0;

    sprintf(szCadena," SELECT NUM_SECUENCIA            , \n"
                     "       NVL(NUM_ABONADO,:ihZero)  , \n"
                     "       COD_PLANDESC              , \n"
                     "       TIP_ENTIDAD                 \n");

    sprintf(szNomTabla," FROM GAT_PLANDESCABO");

    strcat(szCadena,szNomTabla);

    strcat(szCadena, " WHERE COD_CLIENTE  = :lhCodCliente  \n"
                     " AND (COD_CICLFACT = :lhCodCiclFact OR COD_CICLFACT = :ihZero)  \n"
                     " ORDER BY NUM_ABONADO  \n");

    /* EXEC SQL PREPARE sql_Cur_PlanDescAbo FROM :szCadena; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )428;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szCadena;
    sqlstm.sqhstl[0] = (unsigned long )512;
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
        vDTrazasError(szExeName,"\n\t**  Error en SQL-PREPARE sql_Cur_PlanDescAbo **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
       iDError (szExeName,ERR000,vInsertarIncidencia,"PREPARE->GAT_PLANDESCABO",
                 szfnORAerror());
        return  (SQLCODE);

    }

    /* EXEC SQL DECLARE Cur_PlanDescAbo CURSOR FOR sql_Cur_PlanDescAbo; */ 

    if (SQLCODE)
    {
        vDTrazasError(szExeName,"\n\t**  Error en SQL-DECLARE sql_Cur_PlanDescAbo **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG01,SQLCODE,SQLERRM);
        iDError (szExeName,ERR000,vInsertarIncidencia,"DECLARE->GAT_PLANDESCABO",
             szfnORAerror());
        return  (FALSE);

    }

    /* EXEC SQL OPEN Cur_PlanDescAbo USING :ihZero, :lhCodCliente, :lhCodCiclFact, :ihZero; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )447;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihZero;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCiclFact;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&ihZero;
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


    if (SQLCODE)
        iDError (szExeName,ERR000,vInsertarIncidencia,"Open->GAT_PLANDESCABO",
                 szfnORAerror());

    return SQLCODE;
}

/******************************************************************************
Funcion     :       ifnOraLeerGatPlanDescAbo
*******************************************************************************/
static int  ifnOraLeerGatPlanDescAbo( PLANDESCABO_HOSTS *pstGatPanDescAbo
                                    , PLANDESCABO_HOSTS_NULL *pstGatPanDescAbo_Null
                                    , long *plNumFilas)
{
    /* EXEC SQL VAR pstGatPanDescAbo->szCod_Plandesc IS STRING(6) ; */ 

    /* EXEC SQL VAR pstGatPanDescAbo->szTipEntidad   IS STRING(6) ; */ 


    /* EXEC SQL FETCH Cur_PlanDescAbo
        INTO :pstGatPanDescAbo->lNumSecuencia ,
             :pstGatPanDescAbo->lNumAbonado   ,
             :pstGatPanDescAbo->szCod_Plandesc,
             :pstGatPanDescAbo->szTipEntidad:pstGatPanDescAbo_Null->sszTipEntidad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )2000;
    sqlstm.offset = (unsigned int  )478;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)(pstGatPanDescAbo->lNumSecuencia);
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )sizeof(long);
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(pstGatPanDescAbo->lNumAbonado);
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )sizeof(long);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(pstGatPanDescAbo->szCod_Plandesc);
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )6;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)(pstGatPanDescAbo->szTipEntidad);
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )6;
    sqlstm.sqindv[3] = (         short *)(pstGatPanDescAbo_Null->sszTipEntidad);
    sqlstm.sqinds[3] = (         int  )sizeof(short);
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqharc[3] = (unsigned long  *)0;
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



    if (sqlca.sqlcode==SQLOK)
        *plNumFilas = MAX_REGISTROS;
    else
        if (sqlca.sqlcode==NOTFOUND)
            *plNumFilas = sqlca.sqlerrd[2] % MAX_REGISTROS;

    return SQLCODE;
}

/******************************************************************************
Funcion     :       ifnOraCerrarGatPlanDescAbo
*******************************************************************************/
static int ifnOraCerrarGatPlanDescAbo ()
{

    /* EXEC SQL CLOSE Cur_PlanDescAbo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 10;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )509;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    return SQLCODE;
}


/******************************************************************************************/
BOOL bfnLiberaDsctos (REGPLANES *pstDsctos)
{
    register long i;

    for (i=0; i<pstDsctos->lNumAbonados;i++)
    {
        if (&pstDsctos->stAbonado[i] != (REGPLANABO *)NULL)
        {
            free (&pstDsctos->stAbonado[i]);
        }
    }

    pstDsctos->lNumAbonados = 0;

    return (TRUE);

}
/******************************************************************************************/


/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/src/plandcto/pc/PlanDcto.pc */
/** Identificador en PVCS                               : */
/**  SCL:A628.A-UNIX;des#2.7 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#2.7 */
/** Autor de la Revisión                                : */
/**  MWN70299 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  16-MAY-2004 20:46:01 */
/** Worksets ******************************************************************************/
/******************************************************************************************/
