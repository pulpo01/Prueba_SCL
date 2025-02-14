
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
           char  filnam[18];
};
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/prebilcic.pc"
};


static unsigned int sqlctx = 6925347;


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
   unsigned char  *sqhstv[3];
   unsigned long  sqhstl[3];
            int   sqhsts[3];
            short *sqindv[3];
            int   sqinds[3];
   unsigned long  sqharm[3];
   unsigned long  *sqharc[3];
   unsigned short  sqadto[3];
   unsigned short  sqtdso[3];
} sqlstm = {12,3};

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
5,0,0,1,130,0,5,353,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
32,0,0,2,99,0,5,379,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
};


/*****************************************************************************/
/* Fichero    : prebilcic.pc                                                 */
/* Descripcion: PreBilling de Ciclo                                          */
/* Autor      : Javier Garcia Paredes                                        */
/* Fecha      : 21-03-1997                                                   */
/*****************************************************************************/

#define _PREBILCIC_PC_

#include <prebilcic.h>

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


/* -------------------------------------------------------------------------- */
/*    bPreBillingClienteCiclo (long,int)                                      */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bPreBillingClienteCiclo (long lNumProceso,int iTipoFact)
{
  BOOL bRes = TRUE;
  int  i    =  0  ;

  /* Se inicializa la estructura de anomalias */
  vInitAnomProceso (&stAnomProceso);
  stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact;

  vInitEstructuras ();

  /***********************************************************************/
  /* # Eliminado de una manera perentoria, hasta que existan cuotas      */
  /*              if (!bfnGetIndCliente (&stFactCli))                    */
  /*                   bRes = FALSE;                                     */
  /***********************************************************************/
 
  memset (&stFactCli, 1, sizeof (FACTCLI));

  if (bRes && !bInterfazModulos (iTipoFact)) 
      bRes = FALSE;
  
  
  if (bRes && !bPreEmisionModulos (FACT_CICLO)) 
      bRes = FALSE;
      
  
  vDTrazasLog(szExeName,"\t\t* Procesando Monto Minimo Facturable *",LOG03); 
  
  if (!bfnMontoMin_Fact(stCliente.lCodCliente) )
  {
     vDTrazasError(szExeName,"\t\tProcesando Monto Minimo Facturable.",LOG01); 
     bRes = FALSE;
  }

  if (stPreFactura.iNumRegistros >= 0)
  {      /* Calculo de Descuentos */

      /* RAO if(bRes && stCliente.iIndFactur && !bfnDescuentos(stCliente.lCodCliente, FACT_CICLO,stCiclo.szFecEmision)) */

      if(bRes && stCliente.iIndFactur )
      {
       	if (!bfnDescuentos(stCliente.lCodCliente, stCiclo.szFecEmision))
	      {
	         vDTrazasLog(szExeName,"\t\tProcesando Descuentos Nuevos.",LOG01); 
	         bRes = FALSE                                             ;
	      }

	  }
      if(bRes && !bImptosIvaClienteGeneral(FACT_CICLO))
      {
         vDTrazasLog(szExeName,"\t\tProcesando Impuestos Iva.\n",LOG01);
         bRes = FALSE                                                  ;
      }
      if (bRes && !bfnPasoHistoricos ())
      {
          vDTrazasLog (szExeName,"\t\tProcesando Paso a Historicos\n",LOG01);
          bRes = FALSE                                                      ;
      }
  }
  return bRes;
}/************************* Final bPreBillingClienteCiclo ********************/


/* -------------------------------------------------------------------------- */
/*   vAnotarError (void)                                                      */
/* -------------------------------------------------------------------------- */
static void vAnotarError(void)
{
/*
   stEstTotTar.iNumErrores++;
   stEstTotSac.iNumErrores++;
   stEstTotSer.iNumErrores++;
   stEstTotAbo.iNumErrores++;
   stEstTotCar.iNumErrores++;
   stEstTotCob.iNumErrores++;
*/
}

/* ------------------------------------------------------------------------- */
/*    bInterfazModulos (int iTipFact)                                        */
/*      Valores Entrada: iTipFact - Tipo de Facturacion                      */
/*                       FACT_CICLO  2                                       */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
BOOL bInterfazModulos (int iTipoFact)
{
  long         lNumAbonado;
  VENTAS       stVenta    ;
  TRANSCONTADO stTransC   ;

  memset (&stVenta,0,sizeof(VENTAS))       ;
  memset (&stTransC,0,sizeof(TRANSCONTADO));

  switch (iTipoFact)
  {
      case FACT_CICLO:
           /*******************************************************/
           /* Interface ABONOS y Servicios                        */
           /* Observ: Engloba a su vez Interface con SAC y CARGOS */
           /*******************************************************/
           if (!bIFAbonos (stAbonoCli,FACT_CICLO))
           {
                vDTrazasError(szExeName,"Interface Abonos",LOG01);
                return FALSE;
           }
           /**************************/
           /* Interface TARIFICACION */
           /**************************/
           if (!bfnIFTarificacion (FACT_CICLO))
           {
                vDTrazasError(szExeName,"Interface Tarificacion",LOG01);
                return FALSE;
           }
           /*************************/
           /* Interface SAC         */
           /*************************/
/*
           if (stFactCli.iIndPenaliza == 1)
           {
               if (!bIFSac (FACT_CICLO,stCliente.iIndFactur, -1,-1))
               {
                    vDTrazasError(szExeName,"Interface SAC",LOG01);
                    return FALSE;
               }
           }
*/
           /************************/
           /* Interface CARGOS     */
           /************************/
	   vDTrazasLog(szExeName, "Interface de Cargos", LOG05);
       /*    if (stFactCli.iIndCargos == 1)
           {*/
	       vDTrazasLog(szExeName, "\t\t*Entro a Interface de Cargos", LOG05);
               if (!bIFCargos (stVenta,stTransC,-1,-1,FACT_CICLO))
               {
                    vDTrazasError(szExeName,"Interface Cargos",LOG01);
                    return FALSE;
               }
      /*     } */
           /*************************************************/
           /* Interface COBROS engloba el Paso a PreFactura */
           /* Si es debito Automatico no hay interface      */
           /*************************************************/
           if (strcmp (stCliente.szIndDebito,"A"))
           {
/*
               if (!bIFCobros (FACT_CICLO))
               {
                    vDTrazasError (szExeName,"Interface Cobros",LOG01);
                    return FALSE;
               }
*/
               if (stFactCli.iIndPagare == 1)
               {
                   lNumAbonado = ORA_NULL;
/*
                   if (!bIFPagares (stCliente.lCodCliente,lNumAbonado,
                                    stCliente.iIndFactur ,iTipoFact))
                   {
                        vDTrazasError(szExeName,"Interface Pagares",LOG01);
                        return FALSE;
                   }
*/
               }
           }
           else
           {
              vDTrazasLog (szExeName,
                           "\n\t\t* Cliente [%ld] con DEBITO AUTOMATICO\n",
                           LOG03,stCliente.lCodCliente);
           } 
           break;
      default:
           return FALSE;
           
  }
  return TRUE;
}/************************ Final bInterfazModulos ****************************/

/* -------------------------------------------------------------------------- */
/*    bPreEmisionModulos (void)                                               */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bPreEmisionModulos (int iTipoFact) 
{
  int i = 0;

  vDTrazasLog (szExeName,"\n\t\t* Inicio bPreEmisionModulos\n"
           				,LOG03);
  switch (iTipoFact)
  {
      case FACT_CICLO :
           vDTrazasLog (szExeName,"\n\t\t* PreEmision para Cliente [%ld]\n",
                        LOG03,stCliente.lCodCliente);
/* TOL  */
           if(stCiclo.iInd_Tasacion==TIPO_TASA_ON_LINE)
           {
                if( !bfn_EMTOLTarificacion(iTipoFact) )
                {
                    iDError(szExeName, ERR034, vInsertarIncidencia, "bfnEMTOL_Tarificacion");
                    return(FALSE);
                }
           }
/* TAS  */
           else
           {
                if( !bfnEMTarificacion (iTipoFact) )
                {
                    iDError (szExeName,ERR034,vInsertarIncidencia,"Consumos");
                    return(FALSE);
                }
           }

           if (!bEMAbonos ())
           {
                iDError (szExeName,ERR034,vInsertarIncidencia,"Abonos");
                return FALSE;
           }
           if (!bEMServicios ())
           {
                iDError (szExeName,ERR034,vInsertarIncidencia,"Servicios");
                return FALSE;
           }
           if (!bEMCargos ())
           {
               iDError (szExeName,ERR034,vInsertarIncidencia,"Cargos");
               return FALSE;
           }
           if (!bEMSac ())
           {
                iDError (szExeName,ERR034,vInsertarIncidencia,"Penalizaciones");
                return FALSE;
           }
           if (!bEMCuotas ())
           {
                iDError (szExeName,ERR034,vInsertarIncidencia,"Cuotas");
                return FALSE;
           }
           
           if (!bEMCargosRecurrentes ())
           {
                iDError (szExeName,ERR034,vInsertarIncidencia,"CargosRecurrentes");
                return FALSE;
           }
           break;
      default : 
           break;
  }
  vDTrazasLog (szExeName,"\n\t\t* NUMERO de Conceptos [%d]", LOG05,
               stPreFactura.iNumRegistros);

  return TRUE;

}/************************** bPreEmisionModulos ******************************/ 


/*****************************************************************************/
/*                          funcion : vFreeFactCli                           */
/*****************************************************************************/
void vFreeFactCli (void)
{
   stFactCli.iIndPenaliza = 0;
   stFactCli.iIndPagare   = 0;
   stFactCli.iIndCargos   = 0;
}/************************** Final vFreeFactCli ******************************/

/*****************************************************************************/
/*                          funcion : bUpdateCicloCli                        */
/*****************************************************************************/
BOOL bfnUpdateCicloCli (ABONOCLI stAbonoCli, 
                        long     lNumReg   ,
                        long     lNumProceso)
{
 long lInd, lCont = 0; 
 int  bUpdate     = 0;
 static HA_CICLOCLI stHA ;
 char  szFecAux [15] = "";
 
  
  vDTrazasLog (szExeName,
               "\n\t\t* Entrada Update Fa_CicloCli (Num_Proceso)"
               "\n\t\t=>Num.Abonados [%ld]"
               "\n\t\t=>Num.Reg      [%ld]",LOG05,
               stAbonoCli.lNumAbonados, lNumReg);
               

  if (stProceso.iCodTipDocum == stDatosGener.iCodCiclo)
  {
      for (lInd=0;lInd<stAbonoCli.lNumAbonados;lInd++) 
      {
           strcpy (stHA.szRowid [lCont],
                   stAbonoCli.pCicloCli [lInd].szRowid);
                   
           strcpy (stHA.szFecUltFact [lCont],
                    stCiclo.szFecEmision);        
                   
           stHA.lNumProceso [lCont] = lNumProceso      ; 

           stHA.iCodCicloNue[lCont] =
                  (stAbonoCli.pCicloCli [lInd].iIndCambio   == 1 &&
                   stAbonoCli.pCicloCli [lInd].iCodCicloNue >  0)?
                   stAbonoCli.pCicloCli [lInd].iCodCicloNue :
                   stAbonoCli.pCicloCli [lInd].iCodCiclo    ;

           vDTrazasLog (szExeName,"\n\t\t=> Rowid       [%s]"
                                  "\n\t\t=> Ciclo Nuevo [%d]"
                                  "\n\t\t=> Num.Proceso [%d]", LOG06, 
                        stHA.szRowid [lCont]    , 
                        stHA.iCodCicloNue[lCont],
                        lNumProceso); 
           lCont++;
      }
      
      vDTrazasLog (szExeName,"\n\t\t=> lCont      [%d]"
                             "\n\t\t=> lNumReg    [%d]"
                             "\n\t\t               NCH", LOG06, 
                      		lCont , 
                      		lNumReg);
      
      if (lCont == lNumReg && lNumReg > 0)
      {
          bUpdate = 1;

	 
	  
	  vDTrazasLog (szExeName,
               "\n\t\t* Update Fa_CicloCli (Num_Proceso)"
               "\n\t\t=>Num.Proceso [%ld]"
               "\n\t\t=>Fec Ult Fact[%s]",LOG05,
               lNumProceso,stCiclo.szFecEmision);

          /* EXEC SQL FOR :lCont 
                   UPDATE /o+ Rowid (FA_CICLOCLI) o/
                          FA_CICLOCLI
                      SET NUM_PROCESO = :stHA.lNumProceso,
                      	  FEC_ULTFACT = TO_DATE(:stHA.szFecUltFact,'YYYYMMDDHH24MISS')
                    WHERE ROWID       = :stHA.szRowid; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 3;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "update  /*+  Rowid (FA_CICLOCLI)  +*/ FA_CICLOCLI  \
set NUM_PROCESO=:b1,FEC_ULTFACT=TO_DATE(:b2,'YYYYMMDDHH24MISS') where ROWID=:b\
3";
          sqlstm.iters = (unsigned int  )lCont;
          sqlstm.offset = (unsigned int  )5;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)(stHA.lNumProceso);
          sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[0] = (         int  )sizeof(long);
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqharc[0] = (unsigned long  *)0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)(stHA.szFecUltFact);
          sqlstm.sqhstl[1] = (unsigned long )15;
          sqlstm.sqhsts[1] = (         int  )15;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqharc[1] = (unsigned long  *)0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)(stHA.szRowid);
          sqlstm.sqhstl[2] = (unsigned long )19;
          sqlstm.sqhsts[2] = (         int  )19;
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


                    
           
                     
/************************************************************************/
/*          No debe Actualizar el cod_ciclonue en ningun caso           */
/*          ya que este cambio lo realiza el cierre de Facturacion      */
/*                          COD_CICLONUE= :stHA.iCodCicloNue            */
/************************************************************************/

		

          lCont = 0; 
      }
  }
  else /* Factura Baja */
  {
       bUpdate = 1; 
      
       stCiclo.szFecEmision[14] = '\0';

       /* EXEC SQL UPDATE 
                       FA_CICLOCLI
                   SET NUM_PROCESO = :lNumProceso,
                       FEC_ULTFACT = TO_DATE(:stCiclo.szFecEmision,'YYYYMMDDHH24MISS')
                 WHERE ROWID = :stAbonoCli.pCicloCli [0].szRowid; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 3;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update FA_CICLOCLI  set NUM_PROCESO=:b0,FEC_ULTFACT=TO\
_DATE(:b1,'YYYYMMDDHH24MISS') where ROWID=:b2";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )32;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lNumProceso;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)(stCiclo.szFecEmision);
       sqlstm.sqhstl[1] = (unsigned long )15;
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)((stAbonoCli.pCicloCli)[0].szRowid);
       sqlstm.sqhstl[2] = (unsigned long )19;
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


                 
      
                    
  }

  

  if (bUpdate)
  {
      if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
      {
          iDError (szExeName,ERR000,vInsertarIncidencia,
                   "Update->Fa_CicloCli",szfnORAerror());
          return FALSE;
      }
  }
  return TRUE;
}/************************** Final bfnUpdateCicloCli *************************/


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

