
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
    "./pc/precob.pc"
};


static unsigned int sqlctx = 865595;


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
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

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
};


/****************************************************************************/
/* Fichero    : precob.pc                                                   */
/* Descripcion: Funciones para Interface con el modulo de Cobros            */
/* Autor      : Javier Garcia Paredes                                       */
/* Fecha      : 6-05-1997                                                   */
/****************************************************************************/

#define _PRECOB_PC_

#include <precob.h>

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
/*                              funcion : bIFCobros                          */
/*****************************************************************************/
BOOL bIFCobros (void)
{
   static CONCEPTO stConcepto      ;
   static int  iInd            = 0 ;
   static int  iCodCredito     = 0 ;
   static char szFecCobros [9] = "";
   double dImpConceptoAux          ;

   memset (&stConcepto,0,sizeof(CONCEPTO));

   strcpy (stAnomProceso.szDesProceso,"PreBilling Cobros");

   vDTrazasLog (szExeName,"\n\t\t* Obtencion de Recargos",LOG03);

   if (stArrRec.iCont == 0)
   {
       iDError (szExeName,ERR038,vInsertarIncidencia,"Recargos");
       return FALSE;
   }
   if (stArrCan.iCont == 0)
   {
       iDError (szExeName,ERR038,vInsertarIncidencia,"Cantidades");
       return FALSE;
   }
   if (stArrPor.iCont == 0)
   {
       iDError (szExeName,ERR038,vInsertarIncidencia,"Porcentaje");
       return FALSE;
   }

   if (!bfnDBObtConCre (&iCodCredito))
   {
        iDError (szExeName,ERR000,vInsertarIncidencia,
                 "Select->Obtencion CodCredito",szfnORAerror());
        return FALSE;
   }
   strncpy (szFecCobros,szSysDate,8);
   szFecCobros [8] = '\0'           ;

   vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada para Recargos"
                          "\n\t\t=>Cod.Cliente  [%ld]"
                          "\n\t\t=>Fecha        [%s] "
                          "\n\t\t=>Cod.CalClien [%s] "
                          "\n\t\t=>Cod.Credito  [%d] ",LOG04,
                          stCliente.lCodCliente  ,
                          szFecCobros            ,
                          stCliente.szCodCalClien,
                          iCodCredito);

   if (!bFindConcepto (stDatosGener.iCodRecargo,&stConcepto))
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
        return FALSE;
   }

   if (stCliente.dImpRecargo >= 0.01)
   {
       iInd = stPreFactura.iNumRegistros;
       stPreFactura.A_PFactura[iInd].lNumProceso  = stStatus.IdPro          ;
       stPreFactura.A_PFactura[iInd].lCodCliente  = stCliente.lCodCliente   ;
       stPreFactura.A_PFactura[iInd].iCodConcepto = stDatosGener.iCodRecargo;

       strcpy (stPreFactura.A_PFactura[iInd].szDesConcepto,
               stConcepto.szDesConcepto)                                    ;

       if (!bGetMaxColPreFa (stPreFactura.A_PFactura[iInd].iCodConcepto ,
                             &stPreFactura.A_PFactura[iInd].lColumna    ))
            return FALSE;

       stPreFactura.A_PFactura[iInd].iCodProducto =stConcepto.iCodProducto;
       strcpy (stPreFactura.A_PFactura[iInd].szFecValor       ,stCiclo.szFecEmision) ;
       strcpy (stPreFactura.A_PFactura[iInd].szFecEfectividad ,szSysDate) ;

       stPreFactura.A_PFactura[iInd].dImpConcepto  =stCliente.dImpRecargo ;
       stPreFactura.A_PFactura[iInd].dImpFacturable=stCliente.dImpRecargo ;
       
       dImpConceptoAux = stPreFactura.A_PFactura[iInd].dImpFacturable;

       if (!bConversionMoneda (stCliente.lCodCliente                       ,
                               stConcepto.szCodMoneda                      ,
                               stDatosGener.szCodMoneFact                  ,
                               stCiclo.szFecEmision                        ,
                              &stPreFactura.A_PFactura[iInd].dImpFacturable))
            return FALSE; /* P-MIX-09003 4 */            

       stPreFactura.A_PFactura[iInd].dImpFacturable =
                    fnCnvDouble( stPreFactura.A_PFactura[iInd].dImpFacturable,0);                                                       
       
       if (stPreFactura.A_PFactura[iInd].dImpFacturable == 0) /* P-MIX-09003 134206 */
       {
           stPreFactura.A_PFactura[iInd].dImpMontoBase = 0;
       }
       else
       {
           if (dImpConceptoAux != stPreFactura.A_PFactura[iInd].dImpFacturable)
           {
               stPreFactura.A_PFactura[iInd].dImpMontoBase = fnCnvDouble( stPreFactura.A_PFactura[iInd].dImpFacturable,0) / 
                                                                     fnCnvDouble(dImpConceptoAux, 0);
           }
           else
           {
               stPreFactura.A_PFactura[iInd].dImpMontoBase = 0;
           }
       } /* P-MIX-09003 134206 */       
                                                                                                                                    
       strcpy (stPreFactura.A_PFactura[iInd].szCodMoneda ,
               stConcepto.szCodMoneda)  ;
       strcpy (stPreFactura.A_PFactura[iInd].szCodRegion,
               stCliente.szCodRegion)   ;
       strcpy (stPreFactura.A_PFactura[iInd].szCodProvincia,
               stCliente.szCodProvincia);
       strcpy (stPreFactura.A_PFactura[iInd].szCodCiudad,
               stCliente.szCodCiudad)   ;

       strcpy (stPreFactura.A_PFactura[iInd].szCodModulo,
               stConcepto.szCodMoneda);

       stPreFactura.A_PFactura[iInd].lCodPlanCom = stCliente.lCodPlanCom  ;
       stPreFactura.A_PFactura[iInd].iIndFactur  = FACTURABLE             ;
       stPreFactura.A_PFactura[iInd].iCodCatImpos= stCliente.iCodCatImpos ;
       stPreFactura.A_PFactura[iInd].iCodPortador= 0                      ;
       stPreFactura.A_PFactura[iInd].iIndEstado  = EST_NORMAL             ;
       stPreFactura.A_PFactura[iInd].iCodTipConce= stConcepto.iCodTipConce;
       stPreFactura.A_PFactura[iInd].lNumUnidades= 1                      ;
       stPreFactura.A_PFactura[iInd].lCodCiclFact= stCiclo.lCodCiclFact   ;
       stPreFactura.A_PFactura[iInd].iCodConceRel= 0                      ;
       stPreFactura.A_PFactura[iInd].lColumnaRel = 0                      ;
       stPreFactura.A_PFactura[iInd].lNumAbonado = 0                      ;

       stPreFactura.A_PFactura[iInd].szNumTerminal[0] = 0;
       stPreFactura.A_PFactura[iInd].lCapCode         = 0;
       stPreFactura.A_PFactura[iInd].szNumSerieMec[0] = 0;
       stPreFactura.A_PFactura[iInd].szNumSerieLe [0] = 0;

       stPreFactura.A_PFactura[iInd].iFlagImpues  = 0  ;
       stPreFactura.A_PFactura[iInd].iFlagDto     = 0  ;
       stPreFactura.A_PFactura[iInd].fPrcImpuesto = 0  ;
       stPreFactura.A_PFactura[iInd].dValDto      = 0.0;

       stPreFactura.A_PFactura[iInd].iTipDto         = 0;
       stPreFactura.A_PFactura[iInd].lNumVenta       = 0;
       stPreFactura.A_PFactura[iInd].lNumTransaccion = 0;
       stPreFactura.A_PFactura[iInd].iMesGarantia    = 0;
       stPreFactura.A_PFactura[iInd].iIndAlta        = 0;
       stPreFactura.A_PFactura[iInd].iIndSuperTel    = 0;
       stPreFactura.A_PFactura[iInd].iNumPaquete     = 0;
       stPreFactura.A_PFactura[iInd].iIndCuota       = 0;
       stPreFactura.A_PFactura[iInd].iNumCuotas      = 0;
       stPreFactura.A_PFactura[iInd].iOrdCuota       = 0;

       vDTrazasLog (szExeName,"\t\t=> Importe de Recargo (Pesos) : [%f]",LOG03,
                    stPreFactura.A_PFactura[iInd].dImpFacturable); 

       if(bfnIncrementarIndicePreFactura()==FALSE)
       {
	   vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	   vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	   return FALSE;
       }
   }
   if (!bfnDBUpdImpRecargo (stCliente.lCodCliente))
   {
        iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Co_Cartera",
                 szfnORAerror());
        return FALSE;
   }
   return TRUE; 
}/****************************** Final bIFCobros *****************************/
