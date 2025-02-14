
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
    "./pc/prebilbaj.pc"
};


static unsigned int sqlctx = 6925243;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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
5,0,0,1,369,0,4,398,0,0,13,5,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,
0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
72,0,0,2,325,0,4,424,0,0,11,3,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,97,0,0,2,97,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
131,0,0,3,196,0,4,513,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
170,0,0,4,290,0,4,581,0,0,8,5,0,1,0,2,3,0,0,2,3,0,0,2,5,0,0,1,3,0,0,1,3,0,0,1,
5,0,0,1,3,0,0,1,3,0,0,
217,0,0,5,254,0,4,598,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,
3,0,0,
256,0,0,6,204,0,4,660,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
291,0,0,7,186,0,4,672,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
322,0,0,8,317,0,4,752,0,0,10,4,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
377,0,0,9,227,0,4,862,0,0,6,5,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,
3,0,0,
416,0,0,10,343,0,4,912,0,0,11,4,0,1,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/*****************************************************************************/
/* Fichero    :  prebilbaj.pc                                                */ 
/* Descripcion:  Realiza el prebilling para una solicitud de baja de abonado */
/* Autor      :  Javier Garcia Paredes                                       */
/* Fecha      :  22-04-97                                                    */
/*****************************************************************************/
#define _PREBILBAJ_PC_

#include <prebilbaj.h>

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


/* ------------------------------------------------------------------------- */
/*    bPreBillingClienteBajaAbo (long,int)                                   */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
BOOL bfnPreBillingClienteBajaAbo (long  lCodCliente ,
                                  int   iCodCiclo   ,
                                  long  lNumAbonado ,
                                  int   iCodProducto,
                                  long  lNumAlquiler,
                                  long  lNumEstaDia ,
                                  int   iTipoFact)
{
   /* Se inicializa la estructura de anomalias */
   memset (&stAnomProceso,0,sizeof(ANOMPROCESO));
   vInitEstructuras ()                          ;

   stAnomProceso.lCodCliente = lCodCliente ;
   stAnomProceso.lNumAbonado = lNumAbonado ;
   stAnomProceso.iCodProducto= iCodProducto;


   if (iTipoFact == FACT_BAJA)
   {
       strcpy (stAnomProceso.szDesProceso,"PreBilling Baja");

       vDTrazasLog   (szExeName,"\n\t\t******* FACTURA BAJA *******\n"
                                "\t\t=> Cliente      [%ld]\n"
                                "\t\t=> Ciclo        [%d] \n"
                                "\t\t=> Cod.CiclFact [%ld]\n"
                                "\t\t=> Num.Abonado  [%ld]\n"
                                "\t\t=> Cod.Producto [%d] \n",LOG03,
                                lCodCliente,iCodCiclo,stCiclo.lCodCiclFact,
                                lNumAbonado,iCodProducto);

       vDTrazasError (szExeName,"\n\t\t******* FACTURA BAJA *******\n"
                                "\t\t=> Cliente      [%ld]\n"
                                "\t\t=> Ciclo        [%d] \n"
                                "\t\t=> Cod.CiclFact [%ld]\n"
                                "\t\t=> Num.Abonado  [%ld]\n"
                                "\t\t=> Cod.Producto [%d] \n",LOG03,
                                lCodCliente,iCodCiclo,stCiclo.lCodCiclFact,
                                lNumAbonado,iCodProducto);
   }
   else if (iTipoFact == FACT_LIQUIDACION)
   {
       strcpy (stAnomProceso.szDesProceso,"PreBilling Liquidacion");

       vDTrazasLog   (szExeName,"\n\t\t******* FACTURA LIQUIDACION *******\n"
                                "\t\t=> Cliente      [%ld]\n"
                                "\t\t=> Ciclo        [%d] \n"
                                "\t\t=> Num.Abonado  [%ld]\n"
                                "\t\t=> Cod.Producto [%d] \n",LOG03,
                                lCodCliente,iCodCiclo,lNumAbonado,iCodProducto);

       vDTrazasError (szExeName,"\n\t\t******* FACTURA LIQUIDACION *******\n"
                                "\t\t=> Cliente      [%ld]\n"                  
                                "\t\t=> Ciclo        [%d] \n"                  
                                "\t\t=> Num.Abonado  [%ld]\n"                  
                                "\t\t=> Cod.Producto [%d] \n",LOG03,           
                                lCodCliente,iCodCiclo,lNumAbonado,iCodProducto);
   }

   if (iTipoFact == FACT_RENTAPHONE || iTipoFact == FACT_ROAMINGVIS)
   {
       if (iTipoFact == FACT_RENTAPHONE)
       {
	       strcpy (stAnomProceso.szDesProceso,"PreBilling Renta Phone");
	
	       vDTrazasLog   (szExeName,"\n\t\t******* FACTURA RENTA PHONE  *******\n"
	                                "\t\t=> Cliente      [%ld]\n"
	                                "\t\t=> Num.Abonado  [%ld]\n"
	                                "\t\t=> Num.Alquiler [%ld]\n",LOG03,
	                                lCodCliente,lNumAbonado,lNumAlquiler);
	       vDTrazasError (szExeName,"\n\t\t******* FACTURA RENTA PHONE  *******\n"
	                                "\t\t=> Cliente      [%ld]\n"
	                                "\t\t=> Num.Abonado  [%ld]\n"
	                                "\t\t=> Num.Alquiler [%ld]\n",LOG03,
	                                lCodCliente,lNumAbonado,lNumAlquiler);
           if (!bfnGetInfacRent (lCodCliente ,
                                 lNumAbonado ,
                                 lNumAlquiler,
                                 &stCliente.pAboRent))
                return FALSE;
           stCliente.iNumAbonados = 1;

           if (!bfnGetIntaRent  (lCodCliente ,
                                 stCliente.pAboRent[0].lNumAbonado ,
                                 stCliente.pAboRent[0].lNumAlquiler,
                                 &stCliente.lCodPlanCom))
                return FALSE;
       }
       else if (iTipoFact == FACT_ROAMINGVIS)
       {
	       vDTrazasLog (szExeName,
	                    "\n\t\t******* FACTURA ROAMING VISITANTE *******\n"
	                    "\n\t\t=> Cliente     [%ld]"
	                    "\n\t\t=> Num.Abonado [%ld]"
	                    "\n\t\t=> Num.Esta.Dia[%ld]",LOG03,
	                    lCodCliente,lNumAbonado,lNumEstaDia);
	       vDTrazasError(szExeName,
	                    "\n\t\t******* FACTURA ROAMING VISITANTE *******\n"
	                    "\n\t\t=> Cliente     [%ld]"
	                    "\n\t\t=> Num.Abonado [%ld]"
	                    "\n\t\t=> Num.Esta.Dia[%ld]",LOG03,
	                    lCodCliente,lNumAbonado,lNumEstaDia);
           if (!bfnGetInfacRoaVis (lCodCliente ,
                                   lNumAbonado ,
                                   lNumEstaDia , 
                                   &stCliente.pAboRoaVis))
                return FALSE;
       } 
   }
   else
   {
       memset (&stAbonoCli,0,sizeof(ABONOCLI));
       if (!bfnCargaCicloCli (lCodCliente ,iCodCiclo,lNumAbonado,
                              iCodProducto,iTipoFact))
            return FALSE;
       
       memset (&stFactCli,0,sizeof(FACTCLI));

       if (!bfnGetIndCliente (&stFactCli))
            return FALSE;
       if (iTipoFact == FACT_BAJA)
       {
           if (!bfnCargaCuotasBaja ())
                return FALSE;
       }
   }
   /* Carga en memoria datos Modulos */
   if(!bfnInterfazModulosBaja (lNumAbonado,iCodProducto,iTipoFact)) 
       return FALSE   ;

   /* Paso a tablas datos Modulos */
   if(!bfnPreEmisionModulosBaja (iTipoFact)) 
       return FALSE;
   if (stPreFactura.iNumRegistros > 0)
   {
       /* Calculo de Impuestos */
       if(!bImptosIvaClienteGeneral(iTipoFact))
       {
           vDTrazasError(szExeName,"Procesando Impuestos incompleto\n",LOG01); 
           vDTrazasLog  (szExeName,"Procesando Impuestos incompleto\n",LOG01);
           return FALSE;
       }
       if (!bfnPasoHistoricos ())
       {
            vDTrazasLog   (szExeName,
                           "Proceso Paso a Historicos Impcompleto\n",LOG01);
            vDTrazasError (szExeName,
                           "Proceso Paso a Historicos Impcompleto\n",LOG01);
            return FALSE;
       }
   }
   return TRUE;
}/*************************** Final bPreBillingClienteBajaAbo ****************/

/* ------------------------------------------------------------------------- */
/*    bInterfazModulosBaja (int)                                             */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
static BOOL bfnInterfazModulosBaja (long lNumAbonado ,
                                    int  iCodProducto,
                                    int  iTipoFact)
{
  VENTAS       stVenta          ;
  TRANSCONTADO stTransC         ;
  long         lNumA        = -1;
  int          iUltimoAbono =  0;
  int          iIndActuac   =  0;
  int          iIndPenaliza =  0;

  memset (&stVenta ,0,sizeof(VENTAS))      ;
  memset (&stTransC,0,sizeof(TRANSCONTADO));

  if (iTipoFact == FACT_BAJA)
  {
      /****************************************************************/
      /* Se deben ejecutar en Orden : 1. Abonos 2. Trafico            */
      /****************************************************************/
      if (!bIFAbonos (stAbonoCli,FACT_BAJA))
           return FALSE;
      if (!bfnIFTarificacion (FACT_BAJA))
           return FALSE;
      if (!bIFSac (FACT_BAJA, stCliente.iIndFactur,lNumAbonado,iCodProducto))
           return FALSE;
      if (!bIFCargos(stVenta,stTransC,lNumAbonado,iCodProducto,FACT_BAJA))
           return FALSE;
      if (!bfnUltimoAbono (stCliente.lCodCliente,stCiclo.iCodCiclo,
                         lNumAbonado,&iUltimoAbono))
      {
           return FALSE;
      }
      else
      {
         if (iUltimoAbono == 0)
         {
             /* Penalizaciones a Nivel de Cliente */
             if (stFactCli.iIndPenaliza == 1 && 
                 !bIFSac (FACT_BAJA,stCliente.iIndFactur, -1,-1))
                 return FALSE;

             /* Cargos a Nivel de Cliente */
             if (stFactCli.iIndCargos && 
                 !bIFCargos (stVenta,stTransC,-1,-1,FACT_BAJA))
                 return FALSE;

             /* Pagare's a Nivel de Cliente */
             if (stFactCli.iIndPagare &&
                 !bIFPagares(stCliente.lCodCliente,-1,stCliente.iIndFactur,
                             FACT_BAJA))
                 return FALSE;
          }
       }
  }
  else if ( iTipoFact == FACT_LIQUIDACION ||
      		iTipoFact == FACT_RENTAPHONE  ||
      		iTipoFact == FACT_ROAMINGVIS) 
  {
      if (!bfnIFTarificacion (iTipoFact))
           return FALSE;
	  if (iTipoFact == FACT_RENTAPHONE ||
	      iTipoFact == FACT_ROAMINGVIS)
	  {
	      /**********************************************************************/
	      /* Si el IndActuac == BAJA        => Cargos, Penalizaciones, Trafico  */
	      /* Si el IndActuac == LIQUIDACION => Trafico                          */
	      /**********************************************************************/
	      switch (iTipoFact)
	      {
	          case FACT_RENTAPHONE:
	               lNumA        = stCliente.pAboRent->lNumAbonado ;
	               iIndActuac   = stCliente.pAboRent->iIndActuac  ; 
	               iIndPenaliza = stCliente.pAboRent->iIndPenaliza;
	               break;
	          case FACT_ROAMINGVIS:
	               lNumA        = stCliente.pAboRoaVis->lNumAbonado;
	               iIndActuac   = stCliente.pAboRoaVis->iIndActuac ;
	               iIndPenaliza = stCliente.pAboRoaVis->iIndPenaliza;
	               break;
	      }
	      if (iIndActuac == BAJA) 
	      {
	          if (!bIFCargos (stVenta                  ,
	                          stTransC                 ,
	                          lNumA                    ,
	                          stDatosGener.iProdCelular,
	                          iTipoFact))
	               return FALSE;
	          if (iIndPenaliza == 1)
	          {
	              if (!bIFSac (iTipoFact, stCliente.iIndFactur,
	                           lNumA    , 
	                           stDatosGener.iProdCelular))
	                  return FALSE;
	          }
	      }
	  }
  }
  return TRUE;

}/*************************** Final bInterfazModulosBaja *********************/

/* ------------------------------------------------------------------------- */
/*    bPreEmisionModulosBaja (int)                                           */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
static BOOL bfnPreEmisionModulosBaja (int iTipoFact) 
{
   int iIndPenaliza = 0;
   int iIndActuac   = 0;

   if (iTipoFact == FACT_BAJA)
   {
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
       if (!bfnEMTarificacion (iTipoFact))
       {
           iDError (szExeName,ERR034,vInsertarIncidencia,"Consumos");
           return FALSE;
       }
       if (!bEMCuotas ())
       {
           iDError (szExeName,ERR034,vInsertarIncidencia,"Cuotas");
           return FALSE;
       }
  }
  else if (iTipoFact == FACT_LIQUIDACION)
  {
       /*********************************************************************/
       /* En Factura de Liquidacion solo puede haber un reg. en Fa_CicloCli */
       /*********************************************************************/
       if (!bfnGetDatosGaInfac (&stAbonoCli.pCicloCli[0]))
            return FALSE;
       if (!bfnGetDatosGaIntar (stAbonoCli.pCicloCli[0].lCodCliente ,
                                stAbonoCli.pCicloCli[0].lNumAbonado ,
                                stAbonoCli.pCicloCli[0].iCodProducto,
                                &stCliente.lCodPlanCom))
            return FALSE;

       if (!bfnEMTarificacion (iTipoFact))
       {
           iDError (szExeName,ERR034,vInsertarIncidencia,"Consumos");
           return FALSE;
       }
  }
  else if (iTipoFact == FACT_RENTAPHONE || iTipoFact == FACT_ROAMINGVIS)
  {
      iIndActuac   = 
      (iTipoFact == FACT_RENTAPHONE)?stCliente.pAboRent->iIndActuac:
                                     stCliente.pAboRoaVis->iIndActuac;
      iIndPenaliza =
      (iTipoFact == FACT_RENTAPHONE)?stCliente.pAboRent->iIndPenaliza: 
                                     stCliente.pAboRoaVis->iIndPenaliza;

      if (iIndActuac == BAJA)
      {
          if (!bEMCargos ())
               return FALSE;
          if (iIndPenaliza == 1)
          {
              if (!bEMSac ())
                   return FALSE;
          }
      }
      if (!bfnEMTarificacion (iTipoFact))
           return FALSE;
  }
  return TRUE;

}/************************* Final bPreEmisionModuloBaja **********************/

/*****************************************************************************/
/*                          funcion : bCargaCicloCli                         */
/*****************************************************************************/
static BOOL bfnCargaCicloCli (long lCodCliente,int   iCodCiclo   ,
                              long lNumAbonado,short iCodProducto,
                              int  iTipoFact)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char  szhRowid       [19];/* EXEC SQL VAR szhRowid        IS STRING(19); */ 

  static char  szhCodCalClien  [3];/* EXEC SQL VAR szhCodCalClien  IS STRING(3) ; */ 

  static char  szhNomUsuario  [21];/* EXEC SQL VAR szhNomUsuario   IS STRING(21); */ 

  static char  szhNomApellido1[21];/* EXEC SQL VAR szhNomApellido1 IS STRING(21); */ 

  static char  szhNomApellido2[21];/* EXEC SQL VAR szhNomApellido2 IS STRING(21); */ 

  static int   ihCodCredMor       ;
  static char  szhIndDebito    [2];
  static short shIndCambio        ;
  static short i_shNomApellido2   ;
  static short i_shCodCredMor     ;
  static short i_shIndDebito      ;
  static short i_shIndCambio      ;
  static char  szFecUltFact   [15];
  static int   ihNumProc     = 0  ;
  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Fa_CicloCli\n"
                         "\t\t=> Cliente     [%ld]\n"
                         "\t\t=> Ciclo       [%d] \n"
                         "\t\t=> Num.Abonado [%ld]\n"
                         "\t\t=> Cod.Producto[%d] \n",LOG04,
                         lCodCliente,iCodCiclo,lNumAbonado,iCodProducto);
  if (iTipoFact == FACT_BAJA)
  {
      /* EXEC SQL SELECT /o+ index (FA_CICLOCLI PK_FA_CICLOCLI) o/
                      ROWID        ,
                      COD_CALCLIEN ,
                      NOM_USUARIO  ,
                      NOM_APELLIDO1,
                      NOM_APELLIDO2,
                      COD_CREDMOR  ,
                      IND_DEBITO,
                      NVL(TO_CHAR(FEC_ULTFACT,'YYYYMMDDHH24MISS'), ' ')
               INTO   :szhRowid                        ,
                      :szhCodCalClien                  , 
                      :szhNomUsuario                   ,
                      :szhNomApellido1                 ,
                      :szhNomApellido2:i_shNomApellido2,
                      :ihCodCredMor:i_shCodCredMor     ,
                      :szhIndDebito:i_shIndDebito,
                      :szFecUltFact
               FROM   FA_CICLOCLI
               WHERE  COD_CLIENTE  = :lCodCliente
                 AND  COD_CICLO    = :iCodCiclo
                 AND  COD_PRODUCTO = :iCodProducto
                 AND  NUM_ABONADO  = :lNumAbonado
                 AND  NUM_PROCESO  = :ihNumProc; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (FA_CICLOCLI PK_FA_CICLOCLI)  +*/ RO\
WID ,COD_CALCLIEN ,NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_CREDMOR ,IND\
_DEBITO ,NVL(TO_CHAR(FEC_ULTFACT,'YYYYMMDDHH24MISS'),' ') into :b0,:b1,:b2,:b3\
,:b4:b5,:b6:b7,:b8:b9,:b10  from FA_CICLOCLI where ((((COD_CLIENTE=:b11 and CO\
D_CICLO=:b12) and COD_PRODUCTO=:b13) and NUM_ABONADO=:b14) and NUM_PROCESO=:b1\
5)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )5;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodCalClien;
      sqlstm.sqhstl[1] = (unsigned long )3;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhNomUsuario;
      sqlstm.sqhstl[2] = (unsigned long )21;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhNomApellido1;
      sqlstm.sqhstl[3] = (unsigned long )21;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhNomApellido2;
      sqlstm.sqhstl[4] = (unsigned long )21;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)&i_shNomApellido2;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCredMor;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)&i_shCodCredMor;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhIndDebito;
      sqlstm.sqhstl[6] = (unsigned long )2;
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shIndDebito;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)szFecUltFact;
      sqlstm.sqhstl[7] = (unsigned long )15;
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&iCodCiclo;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&iCodProducto;
      sqlstm.sqhstl[10] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)&lNumAbonado;
      sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)0;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)&ihNumProc;
      sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[12] = (         int  )0;
      sqlstm.sqindv[12] = (         short *)0;
      sqlstm.sqinds[12] = (         int  )0;
      sqlstm.sqharm[12] = (unsigned long )0;
      sqlstm.sqadto[12] = (unsigned short )0;
      sqlstm.sqtdso[12] = (unsigned short )0;
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
  else if (iTipoFact == FACT_LIQUIDACION)
  {
      /* EXEC SQL SELECT /o+ index (FA_CICLOCLI PK_FA_CICLOCLI) o/
                      ROWID        ,
                      COD_CALCLIEN ,
                      NOM_USUARIO  ,
                      NOM_APELLIDO1,
                      NOM_APELLIDO2,
                      COD_CREDMOR  ,
                      IND_DEBITO,
                      nvl(TO_CHAR(FEC_ULTFACT,'YYYYMMDDHH24MISS'), ' ')
               INTO   :szhRowid                        ,
                      :szhCodCalClien                  ,
                      :szhNomUsuario                   ,
                      :szhNomApellido1                 ,
                      :szhNomApellido2:i_shNomApellido2,
                      :ihCodCredMor:i_shCodCredMor     ,
                      :szhIndDebito:i_shIndDebito,
                      :szFecUltFact
               FROM   FA_CICLOCLI
               WHERE  COD_CLIENTE  = :lCodCliente
                 AND  COD_PRODUCTO = :iCodProducto
                 AND  NUM_ABONADO  = :lNumAbonado; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index (FA_CICLOCLI PK_FA_CICLOCLI)  +*/ RO\
WID ,COD_CALCLIEN ,NOM_USUARIO ,NOM_APELLIDO1 ,NOM_APELLIDO2 ,COD_CREDMOR ,IND\
_DEBITO ,nvl(TO_CHAR(FEC_ULTFACT,'YYYYMMDDHH24MISS'),' ') into :b0,:b1,:b2,:b3\
,:b4:b5,:b6:b7,:b8:b9,:b10  from FA_CICLOCLI where ((COD_CLIENTE=:b11 and COD_\
PRODUCTO=:b12) and NUM_ABONADO=:b13)";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )72;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
      sqlstm.sqhstl[0] = (unsigned long )19;
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodCalClien;
      sqlstm.sqhstl[1] = (unsigned long )3;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhNomUsuario;
      sqlstm.sqhstl[2] = (unsigned long )21;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhNomApellido1;
      sqlstm.sqhstl[3] = (unsigned long )21;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhNomApellido2;
      sqlstm.sqhstl[4] = (unsigned long )21;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)&i_shNomApellido2;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&ihCodCredMor;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)&i_shCodCredMor;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhIndDebito;
      sqlstm.sqhstl[6] = (unsigned long )2;
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)&i_shIndDebito;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)szFecUltFact;
      sqlstm.sqhstl[7] = (unsigned long )15;
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)&iCodProducto;
      sqlstm.sqhstl[9] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)&lNumAbonado;
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


  }
  if (SQLCODE)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Fa_CicloCli",
               szfnORAerror());
      if (SQLCODE == SQLNOTFOUND)
          vDTrazasLog (szExeName,"\n\t* Cliente Procesado Anteriormente\n",
                       LOG03);
      return FALSE;
  }
  if ((stAbonoCli.pCicloCli = (CICLOCLI *)malloc (sizeof (CICLOCLI)))
       == (CICLOCLI *)NULL)
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,"stAbonoCli.pCicloCli");
       return FALSE;
  }
  else
  {
     stAbonoCli.lNumAbonados = 1;
     memset (&stAbonoCli.pCicloCli[0], 0, sizeof (CICLOCLI));

     strcpy (stAbonoCli.pCicloCli [0].szRowid,szhRowid ) ;
     stAbonoCli.pCicloCli [0].lCodCliente  = lCodCliente ;
     stAbonoCli.pCicloCli [0].iCodCiclo    = iCodCiclo   ;
     stAbonoCli.pCicloCli [0].iCodProducto = iCodProducto;
     stAbonoCli.pCicloCli [0].lNumAbonado  = lNumAbonado ; 

     strcpy (stAbonoCli.pCicloCli [0].szCodCalClien ,szhCodCalClien );
     strcpy (stAbonoCli.pCicloCli [0].szNomUsuario  ,szhNomUsuario  );
     strcpy (stAbonoCli.pCicloCli [0].szNomApellido1,szhNomApellido1);
     strcpy (stAbonoCli.pCicloCli [0].szFecUltFact,szFecUltFact);

     if (i_shNomApellido2 == ORA_NULL)
         strcpy (stAbonoCli.pCicloCli [0].szNomApellido2,"");
     else
         strcpy (stAbonoCli.pCicloCli [0].szNomApellido2,szhNomApellido2);

     stAbonoCli.pCicloCli [0].iCodCredMor = 
                       (i_shCodCredMor == ORA_NULL)?ORA_NULL:ihCodCredMor;
  
     if (i_shIndDebito == ORA_NULL)
         strcpy (stAbonoCli.pCicloCli [0].szIndDebito,"");
     else
         strcpy (stAbonoCli.pCicloCli [0].szIndDebito,szhIndDebito);
   
  }
  return TRUE;
}/**************************** Final bCargaCicloCli **************************/

/*****************************************************************************/
/*                          funcion : bUltimoAbono                           */
/*****************************************************************************/
static BOOL bfnUltimoAbono (long lCodCliente,int  iCodCiclo,
                            long lNumAbonado,int *iUltimoAbono)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long lhCodCliente = 0;
  static int  ihNumProc    = 0;
  static int  ihRowNum     = 1;
  /* EXEC SQL END DECLARE SECTION; */ 

  

  vDTrazasLog (szExeName,"\n\t\t* Parametros de Ultimo Abonado ?\n"
                         "\t\t=> CodCliente  [%ld]\n"
                         "\t\t=> CodCiclo    [%d] \n"
                         "\t\t=> NumAbonado  [%ld]\n",LOG04,
                         lCodCliente,iCodCiclo,lNumAbonado);

  /* EXEC SQL SELECT /o+ index (FA_CICLOCLI PK_FA_CICLOCLI) o/
                  COD_CLIENTE
           INTO   :lhCodCliente 
           FROM   FA_CICLOCLI
           WHERE  COD_CLIENTE  = :lCodCliente
             AND  COD_CICLO    = :iCodCiclo
             AND  NUM_ABONADO != :lNumAbonado
             AND  NUM_PROCESO  = :ihNumProc
             AND  ROWNUM      <= :ihRowNum; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (FA_CICLOCLI PK_FA_CICLOCLI)  +*/ COD_CL\
IENTE into :b0  from FA_CICLOCLI where ((((COD_CLIENTE=:b1 and COD_CICLO=:b2) \
and NUM_ABONADO<>:b3) and NUM_PROCESO=:b4) and ROWNUM<=:b5)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )131;
  sqlstm.selerr = (unsigned short)1;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&iCodCiclo;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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
  sqlstm.sqhstv[4] = (unsigned char  *)&ihNumProc;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihRowNum;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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



  if (SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "Select->Fa_CicloCli",szfnORAerror());
      return FALSE;
  }
  if (SQLCODE == SQLNOTFOUND)
      *iUltimoAbono = 0;
  else
      *iUltimoAbono = 1;

  return TRUE;
}/************************** bUltimoAbono ************************************/

/*****************************************************************************/
/*                        funcion : bfnGetDatosGaInfac                       */
/* -Funcion que recupera datos de las tablas Ga_Infac%                       */
/*****************************************************************************/
static BOOL bfnGetDatosGaInfac (CICLOCLI *pCicloCli)
{
  char szNomTabla [15] = "";
  char szFuncion  [25] = "";

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static short  shIndDetalle   ;
  static short  shIndSuperTel  ;
  static char*  szhNumTeleFija ;/* EXEC SQL VAR szhNumTeleFija IS STRING(16); */ 

  static char*  szhSysDate     ;/* EXEC SQL VAR szhSysDate     IS STRING(15); */ 

  static short  i_shNumTeleFija;
  static int    ihIndActuac = 4;
  static int    ihRowNum = 1;
  /* EXEC SQL END DECLARE SECTION; */ 


  szhSysDate = szSysDate;

  if (pCicloCli->iCodProducto == stDatosGener.iProdCelular)
  {
      strcpy (szNomTabla,"Ga_InfacCel")  ;
  }
  else if (pCicloCli->iCodProducto == stDatosGener.iProdBeeper )
  {
      strcpy (szNomTabla,"Ga_InfacBeep") ;
  }

  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada en %s \n"
                         "\t\t=> Cod.Cliente   [%ld]\n"
                         "\t\t=> Num.Abonado   [%ld]\n"
                         "\t\t=> Cod.Producto  [%ld]\n"
                         "\t\t=> Fecha         [%s] \n",LOG04,szNomTabla,
                         pCicloCli->lCodCliente ,
                         pCicloCli->lNumAbonado ,
                         pCicloCli->iCodProducto,
                         szSysDate);

  if (stDatosGener.iProdCelular == pCicloCli->iCodProducto)
  {
      szhNumTeleFija = pCicloCli->szNumTeleFija;

      /* EXEC SQL SELECT /o+ index_desc (GA_INFACCEL PK_GA_INFACCEL) o/
                      IND_DETALLE ,
                      IND_SUPERTEL,
                      NUM_TELEFIJA
               INTO   :shIndDetalle ,
                      :shIndSuperTel,
                      :szhNumTeleFija:i_shNumTeleFija
               FROM   GA_INFACCEL
               WHERE  COD_CLIENTE = :pCicloCli->lCodCliente  
                 AND  NUM_ABONADO = :pCicloCli->lNumAbonado
                 AND  FEC_BAJA   <= TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS')
                 AND  IND_ACTUAC  = :ihIndActuac /o Liquidacion o/
                 AND  ROWNUM      = :ihRowNum
              ORDER BY FEC_BAJA DESC; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index_desc (GA_INFACCEL PK_GA_INFACCEL)  +\
*/ IND_DETALLE ,IND_SUPERTEL ,NUM_TELEFIJA into :b0,:b1,:b2:b3  from GA_INFACC\
EL where ((((COD_CLIENTE=:b4 and NUM_ABONADO=:b5) and FEC_BAJA<=TO_DATE(:b6,'Y\
YYYMMDDHH24MISS')) and IND_ACTUAC=:b7) and ROWNUM=:b8) order by FEC_BAJA desc \
 ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )170;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&shIndDetalle;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&shIndSuperTel;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szhNumTeleFija;
      sqlstm.sqhstl[2] = (unsigned long )16;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)&i_shNumTeleFija;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&(pCicloCli->lCodCliente);
      sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&(pCicloCli->lNumAbonado);
      sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhSysDate;
      sqlstm.sqhstl[5] = (unsigned long )15;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)&ihIndActuac;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&ihRowNum;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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

 
  }
  else if (stDatosGener.iProdBeeper == pCicloCli->iCodProducto)
  {
      /* EXEC SQL SELECT /o+ index_desc (GA_INFACBEEP PK_GA_INFACBEEP) o/
                      IND_DETALLE 
               INTO   :shIndDetalle 
               FROM   GA_INFACBEEP
               WHERE  COD_CLIENTE = :pCicloCli->lCodCliente
                 AND  NUM_ABONADO = :pCicloCli->lNumAbonado
                 AND  FEC_BAJA   <= TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS')
                 AND  IND_ACTUAC  = :ihIndActuac  /o Liquidacion o/
                 AND  ROWNUM      = :ihRowNum 
              ORDER BY FEC_BAJA DESC; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index_desc (GA_INFACBEEP PK_GA_INFACBEEP) \
 +*/ IND_DETALLE into :b0  from GA_INFACBEEP where ((((COD_CLIENTE=:b1 and NUM\
_ABONADO=:b2) and FEC_BAJA<=TO_DATE(:b3,'YYYYMMDDHH24MISS')) and IND_ACTUAC=:b\
4) and ROWNUM=:b5) order by FEC_BAJA desc  ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )217;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&shIndDetalle;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&(pCicloCli->lCodCliente);
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&(pCicloCli->lNumAbonado);
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szhSysDate;
      sqlstm.sqhstl[3] = (unsigned long )15;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihIndActuac;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)&ihRowNum;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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

 
  }
  if (SQLCODE)
  {
      strcpy (szFuncion,"Select->");
      strcat (szFuncion,szNomTabla);
      iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,
               szfnORAerror())     ;
      return FALSE                 ;
  }
  if (SQLCODE == SQLOK)
  {
      pCicloCli->iIndDetalle = shIndDetalle ;
      if (stDatosGener.iProdCelular == pCicloCli->iCodProducto)
              pCicloCli->iIndSuperTel= shIndSuperTel;
      else 
              pCicloCli->iIndSuperTel= 0;

      if (i_shNumTeleFija == ORA_NULL)
          strcpy (pCicloCli->szNumTeleFija,"");
  }
  return TRUE;
}/************************ Final bfnGetDatosGaInfac **************************/

/*****************************************************************************/
/*                         funcion : bfnGetDatosGaIntar                      */
/*****************************************************************************/
static BOOL bfnGetDatosGaIntar (long  lCodCliente ,
                                long  lNumAbonado ,
                                int   iCodProducto,
                                long *lCodPlanCom)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int  ihRowNum     = 1;
  /* EXEC SQL END DECLARE SECTION; */ 


  char  szNomTabla [15] = ""    ;
  char  szFuncion  [25] = ""    ;
  short iIndNumero   = NO_PLEXIS;
  long  lhCodPlanCom = 0        ;

  if (iCodProducto == stDatosGener.iProdCelular)
      strcpy (szNomTabla,"Ga_IntarCel")  ;
  else if (iCodProducto == stDatosGener.iProdBeeper)
      strcpy (szNomTabla,"Ga_IntarBeep") ;

  vDTrazasLog (szExeName,"\n\t\t* Parametros Entra a %s\n"
                         "\t\t=> Cod.Cliente  [%ld]\n"
                         "\t\t=> Num.Abonado  [%ld]\n"
                         "\t\t=> Cod.Producto [%d] \n",LOG04,szNomTabla,
                         lCodCliente,lNumAbonado,iCodProducto); 
  if (iCodProducto == stDatosGener.iProdCelular)
  {
      /* EXEC SQL SELECT /o+ index_desc (GA_INTARCEL PK_GA_INTARCEL) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARCEL
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  NUM_ABONADO = :lNumAbonado
                 AND  IND_NUMERO  = :iIndNumero
                 AND  ROWNUM      = :ihRowNum
               ORDER BY FEC_HASTA DESC; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index_desc (GA_INTARCEL PK_GA_INTARCEL)  +\
*/ COD_PLANCOM into :b0  from GA_INTARCEL where (((COD_CLIENTE=:b1 and NUM_ABO\
NADO=:b2) and IND_NUMERO=:b3) and ROWNUM=:b4) order by FEC_HASTA desc  ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )256;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lNumAbonado;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&iIndNumero;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihRowNum;
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


  }
  else if (iCodProducto == stDatosGener.iProdBeeper)
  {
      /* EXEC SQL SELECT /o+ index_desc (GA_INTARBEEP PK_GA_INTARBEEP) o/
                      COD_PLANCOM
               INTO   :lhCodPlanCom
               FROM   GA_INTARBEEP
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  NUM_ABONADO = :lNumAbonado
                 AND  ROWNUM      = :ihRowNum
               ORDER BY FEC_HASTA DESC; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select  /*+  index_desc (GA_INTARBEEP PK_GA_INTARBEEP) \
 +*/ COD_PLANCOM into :b0  from GA_INTARBEEP where ((COD_CLIENTE=:b1 and NUM_A\
BONADO=:b2) and ROWNUM=:b3) order by FEC_HASTA desc  ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )291;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lNumAbonado;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&ihRowNum;
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


  }
  if (SQLCODE)
  {
      sprintf (szFuncion,"Select->%s",szNomTabla);
      iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,szfnORAerror());
      return FALSE;
  }
  if (SQLCODE == SQLOK)
      *lCodPlanCom = lhCodPlanCom;

  return TRUE;
}/************************ Final bfnGetDatosGaIntar *************************/

/*****************************************************************************/
/*                         funcion : bfnCargaCuotasBaja                      */
/*****************************************************************************/
static BOOL bfnCargaCuotasBaja (void)
{
  int  i     = 0    ;
  int  rc    = 0    ;
  BOOL bRes  = FALSE;
  NUM_CUOTAS = 0    ;

  for (i=0;i<NUM_CABCUOTAS;i++)
  {
       vDTrazasLog (szExeName,"\n\t\t* Cargando Cuotas Baja"
                              "\n\t\t=>Seq.Cuotas : [%ld]  ",LOG05,
                              pstCabCuotas[i].lSeqCuotas);

       if (!bCargaCuotas (pstCuotas,&NUM_CUOTAS,FACT_BAJA,
                          pstCabCuotas[i].lSeqCuotas))
            return FALSE;
  }/* fin for i ... */

  return TRUE;
}/************************ Final bfnCargaCuotasBaja **************************/

/*****************************************************************************/
/*                            funcion : bfnGetInfacRent                      */
/* -Funcion que recuepera la informacion de Ga_InfacRent para el Cliente , el*/
/*  Abonado y el Periodo (marcado por el NumAlquiler) del Rent Phone.        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnGetInfacRent (long      lCodCliente ,
                             long      lNumAbonado ,
                             long      lNumAlquiler,
                             ABORENT **pAboRent)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhCodCliente     ;
  static long  lhNumAbonado     ;
  static long  lhNumAlquiler    ;
  static char  szhFecAlta   [15]; /* EXEC SQL VAR szhFecAlta    IS STRING(15); */ 

  static char  szhFecBaja   [15]; /* EXEC SQL VAR szhFecBaja    IS STRING(15); */ 

  static long  lhNumCelular     ;
  static short shIndActuac      ;
  static short shIndFactur      ;
  static short shIndDetalle     ;
  static short shIndPenaliza    ;
  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ga_InfacRent\n"
                         "\t\t=> Cod.Cliente   [%ld]\n"
                         "\t\t=> Num.Abonado   [%ld]\n"
                         "\t\t=> Num.Alquiler  [%ld]\n",LOG04,
                         lCodCliente,lNumAbonado,lNumAlquiler);

  lhCodCliente = lCodCliente ;
  lhNumAbonado = lNumAbonado ;
  lhNumAlquiler= lNumAlquiler;
  shIndFactur  = FACTURABLE  ;

  /* EXEC SQL SELECT /o+ index (GA_INFACRENT PK_GA_INFACRENT) o/
                  TO_CHAR (FEC_ALTA,'YYYYMMDDHH24MISS'),
                  TO_CHAR (FEC_BAJA,'YYYYMMDDHH24MISS'),
                  NUM_CELULAR                          ,
                  IND_ACTUAC                           ,
                  IND_DETALLE                          ,
                  IND_PENALIZA
           INTO   :szhFecAlta   ,
                  :szhFecBaja   ,
                  :lhNumCelular ,
                  :shIndActuac  ,
                  :shIndDetalle ,
                  :shIndPenaliza
           FROM   GA_INFACRENT
           WHERE  COD_CLIENTE  = :lhCodCliente
             AND  NUM_ABONADO  = :lhNumAbonado
             AND  NUM_ALQUILER = :lhNumAlquiler
             AND  IND_FACTUR   = :shIndFactur; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GA_INFACRENT PK_GA_INFACRENT)  +*/ TO_C\
HAR(FEC_ALTA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_BAJA,'YYYYMMDDHH24MISS') ,NUM_CE\
LULAR ,IND_ACTUAC ,IND_DETALLE ,IND_PENALIZA into :b0,:b1,:b2,:b3,:b4,:b5  fro\
m GA_INFACRENT where (((COD_CLIENTE=:b6 and NUM_ABONADO=:b7) and NUM_ALQUILER=\
:b8) and IND_FACTUR=:b9)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )322;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecAlta;
  sqlstm.sqhstl[0] = (unsigned long )15;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecBaja;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumCelular;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&shIndActuac;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&shIndDetalle;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&shIndPenaliza;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
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
  sqlstm.sqhstv[7] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAlquiler;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&shIndFactur;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(short);
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


  if (SQLCODE)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Ga_InfacRent",
               szfnORAerror());
      return FALSE            ;
  }
  if (SQLCODE == SQLOK)
  {
      if ((*pAboRent =
          (ABORENT *)malloc (sizeof(ABORENT)))==(ABORENT *)NULL)
      {
           iDError (szExeName,ERR005,vInsertarIncidencia,"stCliente.pAboRent");
           return  FALSE                                                      ;
      }
      else
      {
           (*pAboRent)->lNumAbonado = lNumAbonado     ;
           (*pAboRent)->lNumAlquiler= lNumAlquiler    ;
           (*pAboRent)->iIndActuac  = shIndActuac     ;

           strcpy ((*pAboRent)->szFecAlta, szhFecAlta);
           strcpy ((*pAboRent)->szFecBaja, szhFecBaja);

           (*pAboRent)->lNumCelular = lhNumCelular    ;
           (*pAboRent)->iIndDetalle = shIndDetalle    ;
           (*pAboRent)->iIndPenaliza= shIndPenaliza   ;
           (*pAboRent)->iNumConcTar = 0               ;
           (*pAboRent)->pConcTar    = NULL            ;
      }
  }
  return TRUE;
}/************************** Final bfnGetInfacRent ***************************/

/*****************************************************************************/
/*                         funcion : vfnFreeAboRent                          */
/*****************************************************************************/
void vfnFreeAboRent (void)
{
  if (stCliente.pAboRent != (ABORENT *)NULL)
  {
      if (stCliente.pAboRent->pConcTar != (CONCTAR *)NULL)
      {
          free (stCliente.pAboRent->pConcTar)           ;
          stCliente.pAboRent->pConcTar = (CONCTAR *)NULL;
      }
      stCliente.pAboRent->iNumConcTar = 0 ;
      free (stCliente.pAboRent)           ;
      stCliente.pAboRent = (ABORENT *)NULL;
  }
}/************************* Final vfnFreeAboRent *****************************/

/*****************************************************************************/
/*                         funcion : vfnFreeAboRoaVis                        */
/*****************************************************************************/
void vfnFreeAboRoaVis (void)
{
  if (stCliente.pAboRoaVis != (ABOROAVIS *)NULL)
  {
      if (stCliente.pAboRoaVis->pConcTar != (CONCTAR *)NULL)
      {
          free (stCliente.pAboRoaVis->pConcTar)           ;
          stCliente.pAboRoaVis->pConcTar = (CONCTAR *)NULL;
      }
      stCliente.pAboRoaVis->iNumConcTar = 0   ;
      free (stCliente.pAboRoaVis)             ;
      stCliente.pAboRoaVis = (ABOROAVIS *)NULL;
  }
}/************************* Final vfnFreeAboRoaVis **************************/

/*****************************************************************************/
/*                        funcion : bfnGetIntaRent                           */
/*****************************************************************************/
static BOOL bfnGetIntaRent (long  lCodCliente ,
                            long  lNumAbonado ,
                            long  lNumAlquiler,
                            long *lCodPlanCom)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhCodPlanCom ;
  static long  lhNumAlquiler;
  static short shIndNumero  ;
  static int   ihRowNum     = 1;
  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada a Ga_IntaRent"
                         "\n\t\t=> Cod.Cliente   [%ld]"
                         "\n\t\t=> Num.Abonado   [%ld]"
                         "\n\t\t=> Num.Alquiler  [%ld]",LOG04,
                         lCodCliente,lNumAbonado,lNumAlquiler);

  shIndNumero = NO_PLEXIS;

  /* EXEC SQL SELECT /o+ index_desc (GA_INTARENT PK_GA_INTARENT) o/
                  COD_PLANCOM
           INTO   :lhCodPlanCom
           FROM   GA_INTARENT
           WHERE  COD_CLIENTE = :lCodCliente
             AND  NUM_ABONADO = :lNumAbonado
             AND  IND_NUMERO  = :shIndNumero
             AND  NUM_ALQUILER= :lNumAlquiler
             AND  ROWNUM      = :ihRowNum
          ORDER BY FEC_DESDE DESC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index_desc (GA_INTARENT PK_GA_INTARENT)  +*/ C\
OD_PLANCOM into :b0  from GA_INTARENT where ((((COD_CLIENTE=:b1 and NUM_ABONAD\
O=:b2) and IND_NUMERO=:b3) and NUM_ALQUILER=:b4) and ROWNUM=:b5) order by FEC_\
DESDE desc  ";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )377;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lNumAbonado;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&shIndNumero;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lNumAlquiler;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihRowNum;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
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



  if (SQLCODE)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select=>Ga_IntaRent",
               szfnORAerror());
      return  FALSE           ;
  }
  if (SQLCODE == SQLOK)
      *lCodPlanCom = lhCodPlanCom;

  return TRUE;
}/************************ Final bfnGetIntaRent ******************************/

/*****************************************************************************/
/*                         funcion : bfnGetInfacRoaVis                       */
/*****************************************************************************/
static BOOL bfnGetInfacRoaVis (long        lCodCliente,
                               long        lNumAbonado,
                               long        lNumEstaDia,
                               ABOROAVIS **pAboRoaVis)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char  szhFecAlta  [15]; /* EXEC SQL VAR szhFecAlta IS STRING(15); */ 

  static char  szhFecBaja  [15]; /* EXEC SQL VAR szhFecBaja IS STRING(15); */ 

  static long  lhNumCelular    ;
  static long  lhNumCelularOrig;
  static short shIndActuac     ;
  static short shIndFactur     ;
  static short shIndCargos     ;
  static short shIndPenaliza   ;
  /* EXEC SQL END DECLARE SECTION; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada en Ga_InfacRoaVis\n"
                         "\n\t\t=> Cod.Cliente   [%ld]"
                         "\n\t\t=> Num.Abonado   [%ld]"
                         "\n\t\t=> Num.Esta.Dia  [%ld]",LOG04,
                         lCodCliente,lNumAbonado,lNumEstaDia); 
                        
  shIndFactur = FACTURABLE;
 
  /* EXEC SQL SELECT /o+ index (GA_INFACROAVIS PK_GA_INFACROAVIS) o/
                  TO_CHAR (FEC_ALTA,'YYYYMMDDHH24MISS'),
                  TO_CHAR (FEC_BAJA,'YYYYMMDDHH24MISS'),
                  NUM_CELULAR                          ,
                  NUM_CELULARORIG                      ,
                  IND_ACTUAC                           ,
                  IND_CARGOS                           ,
                  IND_PENALIZA
            INTO  :szhFecAlta      ,
                  :szhFecBaja      ,
                  :lhNumCelular    ,
                  :lhNumCelularOrig,
                  :shIndActuac     ,
                  :shIndCargos     ,
                  :shIndPenaliza
            FROM  GA_INFACROAVIS
            WHERE COD_CLIENTE = :lCodCliente
              AND NUM_ABONADO = :lNumAbonado
              AND NUM_ESTADIA = :lNumEstaDia
              AND IND_FACTUR  = :shIndFactur; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select  /*+  index (GA_INFACROAVIS PK_GA_INFACROAVIS)  +*/ \
TO_CHAR(FEC_ALTA,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_BAJA,'YYYYMMDDHH24MISS') ,NU\
M_CELULAR ,NUM_CELULARORIG ,IND_ACTUAC ,IND_CARGOS ,IND_PENALIZA into :b0,:b1,\
:b2,:b3,:b4,:b5,:b6  from GA_INFACROAVIS where (((COD_CLIENTE=:b7 and NUM_ABON\
ADO=:b8) and NUM_ESTADIA=:b9) and IND_FACTUR=:b10)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )416;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhFecAlta;
  sqlstm.sqhstl[0] = (unsigned long )15;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhFecBaja;
  sqlstm.sqhstl[1] = (unsigned long )15;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhNumCelular;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&lhNumCelularOrig;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&shIndActuac;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&shIndCargos;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&shIndPenaliza;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lCodCliente;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lNumAbonado;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)&lNumEstaDia;
  sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)&shIndFactur;
  sqlstm.sqhstl[10] = (unsigned long )sizeof(short);
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


  if (SQLCODE)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Ga_InfacRoaVis",
               szfnORAerror());
  }
  if (SQLCODE == SQLOK)
  { 
      if ((*pAboRoaVis = 
          (ABOROAVIS *)malloc (sizeof(ABOROAVIS))) == (ABOROAVIS *)NULL)
      {
           iDError (szExeName,ERR021,vInsertarIncidencia,"pAboRoaVis");
           return  FALSE                                              ;
      }
      (*pAboRoaVis)->lNumAbonado     = lNumAbonado     ;
      (*pAboRoaVis)->lNumEstaDia     = lNumEstaDia     ;
      strcpy ((*pAboRoaVis)->szFecAlta,szhFecAlta)     ;
      strcpy ((*pAboRoaVis)->szFecBaja,szhFecBaja)     ;
      (*pAboRoaVis)->lNumCelular     = lhNumCelular    ;
      (*pAboRoaVis)->lNumCelularOrig = lhNumCelularOrig;
      (*pAboRoaVis)->iIndActuac      = shIndActuac     ;
      (*pAboRoaVis)->iIndCargos      = shIndCargos     ;
      (*pAboRoaVis)->iIndPenaliza    = shIndPenaliza   ;
  }
  return (SQLCODE != SQLOK)?FALSE:TRUE;
}/************************ Final bfnGetInfacRoaVis ***************************/
