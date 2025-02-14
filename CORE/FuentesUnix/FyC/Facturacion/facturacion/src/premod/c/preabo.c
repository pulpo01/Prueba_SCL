
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
    "./pc/preabo.pc"
};


static unsigned int sqlctx = 865427;


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
   unsigned char  *sqhstv[29];
   unsigned long  sqhstl[29];
            int   sqhsts[29];
            short *sqindv[29];
            int   sqinds[29];
   unsigned long  sqharm[29];
   unsigned long  *sqharc[29];
   unsigned short  sqadto[29];
   unsigned short  sqtdso[29];
} sqlstm = {12,29};

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
"select ROWID ,NUM_CARGO ,COD_CLIENTE ,COD_PRODUCTO ,COD_CONCEPTO ,TO_CHAR(FE\
C_ALTA,:b0) ,IMP_CARGO ,COD_MONEDA ,COD_PLANCOM ,NUM_UNIDADES ,NUM_ABONADO ,NU\
M_TERMINAL ,COD_CICLFACT ,NUM_SERIE ,NUM_SERIEMEC ,CAP_CODE ,MES_GARANTIA ,DEC\
ODE(trim(NUM_PREGUIA),'',null ,NUM_PREGUIA) ,DECODE(trim(NUM_GUIA),'',null ,NU\
M_GUIA) ,NUM_TRANSACCION ,NUM_VENTA ,NUM_FACTURA ,COD_CONCEPTO_DTO ,VAL_DTO ,T\
IP_DTO ,IND_CUOTA ,NUM_PAQUETE ,IND_FACTUR ,IND_SUPERTEL  from GE_CARGOS where\
 (((((COD_CLIENTE=:b1 and COD_PRODUCTO=:b2) and NUM_ABONADO=:b3) and FEC_ALTA>\
=TO_DATE(:b4,:b0)) and FEC_ALTA<=TO_DATE(:b6,:b0)) and NUM_FACTURA=:b8)       \
    ";

 static const char *sq0002 = 
"select ROWID ,SEQ_CARGO ,COD_CONCEPTO ,TO_CHAR(FEC_ALTA,:b0) ,IMP_CARGO ,COD\
_MONEDA ,COD_PLANCOM ,NUM_UNIDADES ,NUM_ABONADO ,NUM_TERMINAL ,NUM_SERIE ,NUM_\
SERIEMEC ,CAP_CODE ,MES_GARANTIA ,NUM_PREGUIA ,NUM_GUIA ,NUM_TRANSACCION ,NUM_\
VENTA ,NUM_FACTURA ,COD_CONCEPTO_DTO ,VAL_DTO ,TIP_DTO ,IND_CUOTA ,NUM_PAQUETE\
 ,IND_FACTUR ,IND_SUPERTEL  from FA_CARGOS_TO where ((((COD_CLIENTE=:b1 and CO\
D_CICLFACT=:b2) and FEC_ALTA<=TO_DATE(:b3,:b0)) and NUM_FACTURA=:b5) and IND_F\
ACTUR=:b6)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,626,0,9,529,0,0,9,9,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,
0,0,1,5,0,0,1,5,0,0,1,3,0,0,
56,0,0,1,0,0,13,539,0,0,29,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,
0,0,2,4,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,
2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
187,0,0,1,0,0,15,642,0,0,0,0,0,1,0,
202,0,0,2,487,0,9,773,0,0,7,7,0,1,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,
3,0,0,1,3,0,0,
245,0,0,2,0,0,13,785,0,0,26,0,0,1,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,
5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,5,0,0,
2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,
0,2,3,0,0,
364,0,0,2,0,0,15,916,0,0,0,0,0,1,0,
379,0,0,3,82,0,5,1009,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
402,0,0,4,56,0,5,1037,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
425,0,0,5,164,0,3,1550,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,
4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
476,0,0,6,164,0,3,1597,0,0,9,9,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,4,0,0,1,3,0,0,1,
4,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
};


/*****************************************************************************/
/* Fichero:      preabo.pc                                                   */
/* Descripcion:                                                              */
/*                                                                           */
/* Fecha:        13-12-1996                                                  */
/* Autor:        Javier Garcia Paredes                                       */
/*****************************************************************************/
/*	PGonzaleg: Modificacion de tipo de dato de NUMUNIDADES		     		 */
/*			int ---> long					     							 */
/*	4-03-2002							     								 */
/*****************************************************************************/


#define _PREABO_PC_

#include <preabo.h>

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
/*   bIFCargos (long)                                                         */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bIFCargos (VENTAS       stVenta     ,
                TRANSCONTADO stTransC    ,
                long         lNumAbonado ,
                int          iCodProducto,
                int          iTipoFact)
{
   vDTrazasLog (szExeName,"\n\t\t* Cargando CARGOS",LOG03);

   stEstCargos.iNumProcesad  = 0  ;
   stEstCargos.iNumCorrectos = 0  ;
   stEstCargos.iNumAnomalias = 0  ;

   if (!bfnCargaCargosCliente(stVenta,stTransC,lNumAbonado,iCodProducto,
                              iTipoFact))
        return FALSE;

   vDTrazasLog(szExeName,"\n\t\t* Numero de Cargos procesados ......[%d]"
						 "\n\t\t* Cargos Correctos .................[%d]"
						 "\n\t\t* Cargos Incorrectos ...............[%d]"
               			 ,LOG03,stCliente.iNumCargos
               			 ,stEstCargos.iNumCorrectos
               			 ,stEstCargos.iNumAnomalias);

   return TRUE;
}/**************************** Final bIFCargos *******************************/

/*****************************************************************************/
/*                          funcion : bfnCargaCargosCliente                  */
/* -Funcion que carga los cargos dependiendo de los parametros de entrada.   */
/* -Se Cargan los reg. en stCliente.pCargos y stCliente.iNumCargos (globales)*/
/* -lCodCiclFact == -1 => Primera Venta                                      */
/* -lCodCiclFact != -1 && lNumAbonado != -1 &&                               */
/*  lCodCliente  == -1 => Presupuesto de Baja                                */
/*                                                                           */
/* -lCodCiclFact != -1 && lNumAbonado == -1 => Factura de Ciclo              */
/* -Valores de Retorno: Error->FALSE, !Error->TRUE                           */
/*****************************************************************************/
static BOOL bfnCargaCargosCliente (VENTAS       stVenta     ,
                                   TRANSCONTADO stTransC    ,
                                   long         lNumAbonado ,
                                   int          iCodProducto,
                                   int          iTipoFact)

{
  static char szFecBaja [15] = "";
  static char szFecAlta [15] = "";

  switch (iTipoFact)
  {
      case FACT_CONTADO:
           if (stTransC.lNumTransaccion == ORA_NULL)
           {
               iDError (szExeName,ERR031,vInsertarIncidencia,stVenta.lNumVenta,
                        stTransC.lNumTransaccion);
               return FALSE;
           }
           else
               if (!bfnCargaCargosPVentaContado (stVenta,stTransC))
                    return FALSE;
           break;
      case FACT_CICLO:
           if (!bfnCargaCargosCiclo(lNumAbonado))
                return FALSE;
           if (!bfnCargaCargosOcasionales(lNumAbonado))
                return FALSE;
           break;
      case FACT_BAJA:
            if (!bfnCargaCargosBajaAbo(lNumAbonado,iCodProducto))
                 return FALSE;
            break;
      case FACT_RENTAPHONE:
      case FACT_ROAMINGVIS:
            if (iTipoFact == FACT_RENTAPHONE)
            {
                strcpy (szFecBaja,stCliente.pAboRent->szFecBaja);
                strcpy (szFecAlta,stCliente.pAboRent->szFecAlta);
            }
            else if (iTipoFact == FACT_ROAMINGVIS)
            {
                strcpy (szFecBaja,stCliente.pAboRoaVis->szFecBaja);
                strcpy (szFecAlta,stCliente.pAboRoaVis->szFecAlta);

            }
            if (!bfnCargaCargosRentORoa (lNumAbonado ,
                                         iCodProducto,
                                         szFecBaja   ,
                                         szFecAlta   ,
                                         iTipoFact))
                 return FALSE;
            break;
      default:
            vDTrazasError (szExeName,
                           "\n\t Tipo de Factura [%d] desconocido\n",LOG01,
                           iTipoFact);
            return FALSE;
  }
  return TRUE;

}/************************** Final bfnCargaCargos ******************************/


/*****************************************************************************/
/*                        funcion :                */
/* -Funcion que carga Cargos de Primera Venta y Contado stCliente            */
/* -stCliente.iModCuota indica :                                             */
/*           1 => Una y solo una modalidad Contado o Credito                 */
/*           2 => Contado y Credito en la misma Venta                        */
/* -Valores Retorno :Error->FALSE, !Error->TRUE                              */
/*****************************************************************************/
static BOOL bfnCargaCargosPVentaContado (VENTAS stVenta,TRANSCONTADO stTransC)
{
  long iInd = 0; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */
  int iIndCuota_Aux = 0;
  BOOL bPrimeraVez = TRUE;

  vDTrazasLog (szExeName,"\n\t\t* Cargando PVenta-Contado\n"
                         "\t\t* NumVenta       [%ld]\n"
                         "\t\t* NumTransaccion [%ld]\n",LOG04,
                         stVenta.lNumVenta,stTransC.lNumTransaccion);

  if (stCliente.pCargos != (CARGOS *)NULL)
  {
      free (stCliente.pCargos);
      stCliente.pCargos = (CARGOS *)NULL;
  }
  stCliente.iNumCargos = 0;
  stCliente.iModVenta  = 1;

  for (iInd=0;iInd<NUM_CARGOS;iInd++)
  {
       /*********************************************************************/
       /* Dos casos  : Contado => NumTransaccion y NumVenta                 */
       /*              PVenta  => NumTransaccion y NumVenta = ORA_NULL      */
       /* Observacion: En un mismo proceso solo se da uno de los dos casos  */
       /*********************************************************************/
       if ( pstCargos[iInd].lNumTransaccion == stTransC.lNumTransaccion   &&
            pstCargos[iInd].lNumVenta       == stVenta.lNumVenta          &&
           (pstCargos[iInd].lNumFactura     == SQLOK ||
            pstCargos[iInd].lNumFactura     == ORA_NULL)                  )
       {
           if ((stCliente.pCargos =
                (CARGOS *)realloc((CARGOS *)stCliente.pCargos,
                 sizeof(CARGOS)*(stCliente.iNumCargos+1)))==(CARGOS *)NULL)
           {
                 iDError (szExeName,ERR005,vInsertarIncidencia,"pstCargos");
                 return FALSE;
           }
           memcpy (&stCliente.pCargos[stCliente.iNumCargos],&pstCargos [iInd],
                   sizeof(CARGOS));

           if (!bValidacionCargo(stCliente.iNumCargos))
                return FALSE;
           stCliente.pCargos[stCliente.iNumCargos].iCodModVenta=
                                         pstCargos[iInd].iCodModVenta;
           if (stVenta.lNumVenta        != ORA_NULL &&
               stTransC.lNumTransaccion != ORA_NULL)
           {
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCiudad,
                       stVenta.szCodCiudad);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodRegion,
                       stVenta.szCodRegion);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodProvincia,
                       stVenta.szCodProvincia);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCuota,
                       stVenta.szCodCuota) ;
           }
           if (stTransC.lNumTransaccion != ORA_NULL &&
               stVenta.lNumVenta        == ORA_NULL)
           {
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCiudad,
                       stTransC.szCodCiudad);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodRegion,
                       stTransC.szCodRegion);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodProvincia,
                       stTransC.szCodProvincia);
               strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCuota,
                       stTransC.szCodCuota) ;
           }
           if (stCliente.iIndCredito < 1 && pstCargos[iInd].iIndCuota)
               stCliente.iIndCredito = 1;

           if (stCliente.iNumCargos == 0)
               iIndCuota_Aux = pstCargos[iInd].iIndCuota;
           if (iIndCuota_Aux == pstCargos[iInd].iIndCuota)
               stCliente.pCargos[stCliente.iNumCargos].lNumProceso =
                                                              stStatus.IdPro;
           else
           {
               if (bPrimeraVez)
               {
                   if (!bGetNumProceso(&stStatus.IdPro2))
                        return FALSE;
                   bPrimeraVez = FALSE;
                   stCliente.iModVenta = 2;
               }
               stCliente.pCargos[stCliente.iNumCargos].lNumProceso =
                                                              stStatus.IdPro2;
           }
           stCliente.iNumCargos++;

       }/* fin if ==  */

  }/* fin for iInd ... */
  return TRUE;
}/************************** Final bfnCargaCargosPVentaContado *****************/

/*****************************************************************************/
/*                        funcion : bfnCargaCargosCiclo                      */
/* -Funcion que carga los Cargos de Ciclo en stCliente.pCargos y el numero   */
/*  de reg. en stCliente.iNumCargos.                                         */
/* -Utiliza pstCargos (tabal ga_cargos en memoria) y NUM_CARGOS (numero de   */
/*  de reg. de Ga_Cargos.                                                    */
/* -Valores de Entrada CodCliente, CodCiclFact                               */
/* -Valores de Retorno : Error->FALSE, !Error->TRUE                          */
/*****************************************************************************/
static BOOL bfnCargaCargosCiclo (long lNumAbonado)
{
  long  iInd    = 0    ; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */        
  BOOL bAddReg = FALSE;

  vDTrazasLog (szExeName,"\n\t\t* Cargos Ciclo    \n"
                         "\t\t=> Cliente     [%ld]\n"
                         "\t\t=> Cod.CiclFact[%ld]\n"
                         "\t\t=> Num.Abonado [%ld]\n"
                         ,LOG04,
                         stCliente.lCodCliente,stCiclo.lCodCiclFact,
                         lNumAbonado);

  	for (iInd=0;iInd<NUM_CARGOS;iInd++)
  	{
		vDTrazasLog (szExeName,"\n\t\t* Cargos Ciclo 2   \n"
                         "\t\t=> pstCargos[%d].lCodCliente    [%ld]\n"
                         "\t\t=> pstCargos[%d].lNumAbonado    [%ld]\n"
                         ,LOG04
                         ,iInd
                         ,pstCargos[iInd].lCodCliente
                         ,iInd                    
                         ,pstCargos[iInd].lNumAbonado);
		
		if (pstCargos[iInd].lCodCliente  	== stCliente.lCodCliente &&
/* rao         	pstCargos[iInd].lCodCiclFact    == stCiclo.lCodCiclFact	 && */
           	pstCargos[iInd].lNumAbonado     == lNumAbonado           &&
           	pstCargos[iInd].lNumTransaccion == SQLOK                 &&
          	(pstCargos[iInd].lNumFactura    == SQLOK ||
           	 pstCargos[iInd].lNumFactura    == ORA_NULL)             )
           	bAddReg = TRUE ;
       	else
        	bAddReg = FALSE;
     	
     	if (bAddReg)
     	{
           if ((stCliente.pCargos =
               (CARGOS *)realloc ((CARGOS *)stCliente.pCargos,
                sizeof(CARGOS)*(stCliente.iNumCargos+1)))==(CARGOS *)NULL)
           {
                iDError (szExeName,ERR005,vInsertarIncidencia,"pstCargos");
                return FALSE;
           }
           else
           {
               memcpy (&stCliente.pCargos[stCliente.iNumCargos],
                       &pstCargos[iInd],sizeof(CARGOS));

               strcpy(stCliente.pCargos[stCliente.iNumCargos].szCodCiudad   ,
                      stCliente.szCodCiudad)   ;
               strcpy(stCliente.pCargos[stCliente.iNumCargos].szCodRegion   ,
                      stCliente.szCodRegion)   ;
               strcpy(stCliente.pCargos[stCliente.iNumCargos].szCodProvincia,
                      stCliente.szCodProvincia);

               if (!bValidacionCargo(stCliente.iNumCargos))
                    return FALSE;
               stCliente.iNumCargos++;
           }

       }
  }/* fin for iInd ... */
  return TRUE;
}/************************ Final bfnCargaCargosCiclo **************************/


/*****************************************************************************/
/*                         funcion : bfnCargaCargosBajaAbo                   */
/* -Funcion de carga Cargos para la Baja de un Abonado                       */
/* -Valores de Entrada : NumAbonado, CodProducto                             */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bfnCargaCargosBajaAbo (long lNumAbonado,int iCodProducto)
{
  long iInd = 0; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */        
  BOOL bAddReg = FALSE;

  vDTrazasLog (szExeName,"\n\t\t* Carga Cargos Factura de Baja\n"
                         "\t\t=> Cliente    [%ld]\n"
                         "\t\t=> Num.Abonado[%ld]\n",LOG04,
                         stCliente.lCodCliente,lNumAbonado);

  stAnomProceso.lNumAbonado = lNumAbonado   ;
  stAnomProceso.lNumProceso = stStatus.IdPro;

  strncpy (stAnomProceso.szDesProceso,"Carga Factura Baja",
           sizeof (stAnomProceso.szDesProceso));

  for (iInd=0;iInd<NUM_CARGOS;iInd++)
  {
     if (lNumAbonado != ORA_NULL && iCodProducto != ORA_NULL)
     {/* Cargos a Nivel de Abonado */
         if (pstCargos[iInd].lCodCliente == stCliente.lCodCliente &&
             pstCargos[iInd].lNumAbonado == lNumAbonado           &&
             pstCargos[iInd].iCodProducto== iCodProducto          &&
             pstCargos[iInd].lCodCiclFact<= stCiclo.lCodCiclFact  &&
            (pstCargos[iInd].lNumFactura == SQLOK ||
             pstCargos[iInd].lNumFactura == ORA_NULL)              )
             bAddReg = TRUE;
         else
             bAddReg = FALSE;
     }
     else if (lNumAbonado == ORA_NULL && iCodProducto == ORA_NULL) 
     {/* Cargos a Nivel de Cliente */
         if (pstCargos[iInd].lCodCliente == stCliente.lCodCliente &&
             pstCargos[iInd].lCodCiclFact<= stCiclo.lCodCiclFact  &&
            (pstCargos[iInd].lNumFactura == SQLOK ||
             pstCargos[iInd].lNumFactura == ORA_NULL)              )
             bAddReg = TRUE;
         else
             bAddReg = FALSE;
     }
     if (bAddReg)
     {
         if ((stCliente.pCargos =
              (CARGOS *)realloc((CARGOS *)stCliente.pCargos,
               sizeof(CARGOS)*(stCliente.iNumCargos+1)))==(CARGOS *)NULL)
         {
               iDError (szExeName,ERR005,vInsertarIncidencia,"pstCargos");
               return FALSE;
         }
         else
         {
            memcpy (&stCliente.pCargos[stCliente.iNumCargos],&pstCargos[iInd],
                    sizeof(CARGOS));

            strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodRegion   ,
                    stCliente.szCodRegion)   ;
            strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodProvincia,
                    stCliente.szCodProvincia);
            strcpy (stCliente.pCargos[stCliente.iNumCargos].szCodCiudad   ,
                    stCliente.szCodCiudad)   ;

            if (!bValidacionCargo(stCliente.iNumCargos))
                 return FALSE;
            stCliente.iNumCargos++;
         }

     }

  }/* fin for iInd ... */
  return TRUE;

}/*********************** Final bfnCargaCargosBajaAbo **************************/


/*****************************************************************************/
/*                        funcion : bfnCargaCargosRentPhoneORomingVis        */
/* -Funcion que carga los Cargos del Cliente-Abonado teniendo encuenta la Fec*/
/*  de Alta del Cargo y el Periodo de Alquiler del Celular o los Cargos del  */
/*  Cliente-Abonado de los Roaming Visitante.                                */
/* -Valores Retorno : Error->FALSE, !Error->TRUE.                            */
/*****************************************************************************/
static BOOL bfnCargaCargosRentORoa (long  lNumAbonado ,
                                    int   iCodProducto,
                                    char *szFecAlta   ,
                                    char *szFecBaja   ,
                                    int   iTipoFact)
{
  int i = 0;

  /* EXEC SQL BEGIN DECLARE SECTION ; */ 

  static char*  szhRowid         ; /* EXEC SQL VAR szhRowid        IS STRING(19); */ 

  static long   lhNumCargo       ;
  static long   lhNumVenta       ;
  static long   lhCodCliente     ;
  static long   lhNumAbonado     ;
  static char*  szhNumTerminal   ; /* EXEC SQL VAR szhNumTerminal  IS STRING(16); */ 

  static short  shCodProducto    ;
  static char*  szhFecAlta       ; /* EXEC SQL VAR szhFecAlta      IS STRING(15); */ 

  static int    ihCodConcepto    ;
  static double dhImpCargo       ;
  static char*  szhCodMoneda     ; /* EXEC SQL VAR szhCodMoneda    IS STRING(4) ; */ 

  static long   lhCodPlanCom     ;
  static int    lhNumUnidades    ; /* Incorporado por PGonzaleg 4-03-2002 */
  static long   lhCodCiclFact    ;
  static char*  szhNumSerie      ; /* EXEC SQL VAR szhNumSerie     IS STRING(26); */ 

  static char*  szhNumSerieMec   ; /* EXEC SQL VAR szhNumSerieMec  IS STRING(26); */ 

  static char*  szhFecDesde      ; /* EXEC SQL VAR szhFecDesde     IS STRING(15); */ 

  static char*  szhFecHasta      ; /* EXEC SQL VAR szhFecHasta     IS STRING(15); */ 

  static long   lhCapCode        ;
  static int    ihMesGarantia    ;
  static char*  szhNumPreGuia    ; /* EXEC SQL VAR szhNumPreGuia   IS STRING(11); */ 

  static char*  szhNumGuia       ; /* EXEC SQL VAR szhNumGuia      IS STRING(11); */ 

  static long   lhNumTransaccion ;
  static long   lhNumFactura     ;
  static int    ihCodConceptoDto ;
  static double dhValDto         ;
  static short  shTipDto         ;
  static short  shIndCuota       ;
  static short  shIndFactur      ;
  static int    ihNumPaquete     ;
  static short  shIndSuperTel    ;
  static short  i_shNumVenta     ;
  static short  i_shIndSuperTel  ;
  static short  i_shIndCuota     ;
  static short  i_shNumPaquete   ;
  static short  i_shNumAbonado   ;
  static short  i_shNumTerminal  ;
  static short  i_shCodCiclFact  ;
  static short  i_shNumSerie     ;
  static short  i_shNumSerieMec  ;
  static short  i_shCapCode      ;
  static short  i_shMesGarantia  ;
  static short  i_shNumPreGuia   ;
  static short  i_shNumGuia      ;
  static short  i_shNumTransaccion;
  static short  i_shNumFactura   ;
  static short  i_shCodConceptoDto;
  static short  i_shValDto       ;
  static short  i_shTipDto       ;

  static char  szFormatoFec[17]  ; /* EXEC SQL VAR szFormatoFec  IS STRING(17); */ 

  static int   iCero=0;

  /* EXEC SQL END DECLARE SECTION   ; */ 


  strcpy(szFormatoFec,"YYYYMMDDHH24MISS");

  /* EXEC SQL DECLARE Cur_CargosRentRoa CURSOR FOR
       SELECT
              ROWID                           ,
              NUM_CARGO                       ,
              COD_CLIENTE                     ,
              COD_PRODUCTO                    ,
              COD_CONCEPTO                    ,
              TO_CHAR (FEC_ALTA,:szFormatoFec),
              IMP_CARGO                       ,
              COD_MONEDA                      ,
              COD_PLANCOM                     ,
              NUM_UNIDADES                    ,
              NUM_ABONADO                     ,
              NUM_TERMINAL                    ,
              COD_CICLFACT                    ,
              NUM_SERIE                       ,
              NUM_SERIEMEC                    ,
              CAP_CODE                        ,
              MES_GARANTIA                    ,
              DECODE(TRIM(NUM_PREGUIA),'',NULL,NUM_PREGUIA),              
              DECODE(TRIM(NUM_GUIA),'',NULL,NUM_GUIA),              
              NUM_TRANSACCION                 ,
              NUM_VENTA                       ,
              NUM_FACTURA                     ,
              COD_CONCEPTO_DTO                ,
              VAL_DTO                         ,
              TIP_DTO                         ,
              IND_CUOTA                       ,
              NUM_PAQUETE                     ,
              IND_FACTUR                      ,
              IND_SUPERTEL  		   
       FROM   GE_CARGOS
       WHERE  COD_CLIENTE = :lhCodCliente
         AND  COD_PRODUCTO= :shCodProducto
         AND  NUM_ABONADO = :lhNumAbonado
         AND  FEC_ALTA   >= TO_DATE (:szhFecDesde,:szFormatoFec)
         AND  FEC_ALTA   <= TO_DATE (:szhFecHasta,:szFormatoFec)
         AND  NUM_FACTURA = :iCero; */ 


  lhCodCliente = stCliente.lCodCliente;
  shCodProducto= iCodProducto         ;
  lhNumAbonado = lNumAbonado          ;

  szhFecDesde = szFecAlta;
  szhFecHasta = szFecBaja;

  if (iTipoFact == FACT_RENTAPHONE)
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada Ga_Cargos (Rent Phone)\n"
                   "\t\t=> Cod.Cliente  [%ld]\n"
                   "\t\t=> Num.Abonado  [%ld]\n"
                   "\t\t=> Cod.Producto [%d] \n"
                   "\t\t=> Fec.Alta     [%s] \n"
                   "\t\t=> Fec.Baja     [%s] \n",LOG04,
                   lhCodCliente,lhNumAbonado,shCodProducto,
                   szhFecDesde ,szhFecHasta );
  }
  else if (iTipoFact == FACT_ROAMINGVIS)
  {
      vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada Ga_Cargos(Roming Visitante)\n"
                   "\t\t=> Cod.Cliente  [%ld]\n"
                   "\t\t=> Num.Abonado  [%ld]\n"
                   "\t\t=> Cod.Producto [%d] \n"
                   "\t\t=> Fec.Alta     [%s] \n"
                   "\t\t=> Fec.Baja     [%s] \n",LOG04,
                   lhCodCliente,lhNumAbonado,shCodProducto,
                   szhFecDesde ,szhFecHasta );
  }
  /* EXEC SQL OPEN Cur_CargosRentRoa; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 9;
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
  sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&shCodProducto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(short);
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
  sqlstm.sqhstv[4] = (unsigned char  *)szhFecDesde;
  sqlstm.sqhstl[4] = (unsigned long )15;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szFormatoFec;
  sqlstm.sqhstl[5] = (unsigned long )17;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[6] = (unsigned long )15;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szFormatoFec;
  sqlstm.sqhstl[7] = (unsigned long )17;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&iCero;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Cargos",
               szfnORAerror());
      return FALSE            ;
  }
  while (SQLCODE == SQLOK)
  {
         /* EXEC SQL FETCH Cur_CargosRentRoa INTO
                        :szhRowid                           ,
                        :lhNumCargo                         ,
                        :lhCodCliente                       ,
                        :shCodProducto                      ,
                        :ihCodConcepto                      ,
                        :szhFecAlta                         ,
                        :dhImpCargo                         ,
                        :szhCodMoneda                       ,
                        :lhCodPlanCom                       ,
                        :lhNumUnidades                      , /o Incorporado por PGonzaleg 4-03-2002 o/
                        :lhNumAbonado:i_shNumAbonado        ,
                        :szhNumTerminal:i_shNumTerminal     ,
                        :lhCodCiclFact:i_shCodCiclFact      ,
                        :szhNumSerie:i_shNumSerie           ,
                        :szhNumSerieMec:i_shNumSerieMec     ,
                        :lhCapCode:i_shCapCode              ,
                        :ihMesGarantia:i_shMesGarantia      ,
                        :szhNumPreGuia:i_shNumPreGuia       ,
                        :szhNumGuia:i_shNumGuia             ,
                        :lhNumTransaccion:i_shNumTransaccion,
                        :lhNumVenta:i_shNumVenta            ,
                        :lhNumFactura:i_shNumFactura        ,
                        :ihCodConceptoDto:i_shCodConceptoDto,
                        :dhValDto:i_shValDto                ,
                        :shTipDto:i_shTipDto                ,
                        :shIndCuota:i_shIndCuota            ,
                        :ihNumPaquete:i_shNumPaquete        ,
                        :shIndFactur                        ,
                        :shIndSuperTel:i_shIndSuperTel      ; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 29;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )56;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)szhRowid;
         sqlstm.sqhstl[0] = (unsigned long )19;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCargo;
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
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
         sqlstm.sqhstv[3] = (unsigned char  *)&shCodProducto;
         sqlstm.sqhstl[3] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&ihCodConcepto;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[4] = (         int  )0;
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)szhFecAlta;
         sqlstm.sqhstl[5] = (unsigned long )15;
         sqlstm.sqhsts[5] = (         int  )0;
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)&dhImpCargo;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)szhCodMoneda;
         sqlstm.sqhstl[7] = (unsigned long )4;
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)&lhCodPlanCom;
         sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[8] = (         int  )0;
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)&lhNumUnidades;
         sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[9] = (         int  )0;
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)&lhNumAbonado;
         sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[10] = (         int  )0;
         sqlstm.sqindv[10] = (         short *)&i_shNumAbonado;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)szhNumTerminal;
         sqlstm.sqhstl[11] = (unsigned long )16;
         sqlstm.sqhsts[11] = (         int  )0;
         sqlstm.sqindv[11] = (         short *)&i_shNumTerminal;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)&lhCodCiclFact;
         sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[12] = (         int  )0;
         sqlstm.sqindv[12] = (         short *)&i_shCodCiclFact;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)szhNumSerie;
         sqlstm.sqhstl[13] = (unsigned long )26;
         sqlstm.sqhsts[13] = (         int  )0;
         sqlstm.sqindv[13] = (         short *)&i_shNumSerie;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqadto[13] = (unsigned short )0;
         sqlstm.sqtdso[13] = (unsigned short )0;
         sqlstm.sqhstv[14] = (unsigned char  *)szhNumSerieMec;
         sqlstm.sqhstl[14] = (unsigned long )26;
         sqlstm.sqhsts[14] = (         int  )0;
         sqlstm.sqindv[14] = (         short *)&i_shNumSerieMec;
         sqlstm.sqinds[14] = (         int  )0;
         sqlstm.sqharm[14] = (unsigned long )0;
         sqlstm.sqadto[14] = (unsigned short )0;
         sqlstm.sqtdso[14] = (unsigned short )0;
         sqlstm.sqhstv[15] = (unsigned char  *)&lhCapCode;
         sqlstm.sqhstl[15] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[15] = (         int  )0;
         sqlstm.sqindv[15] = (         short *)&i_shCapCode;
         sqlstm.sqinds[15] = (         int  )0;
         sqlstm.sqharm[15] = (unsigned long )0;
         sqlstm.sqadto[15] = (unsigned short )0;
         sqlstm.sqtdso[15] = (unsigned short )0;
         sqlstm.sqhstv[16] = (unsigned char  *)&ihMesGarantia;
         sqlstm.sqhstl[16] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[16] = (         int  )0;
         sqlstm.sqindv[16] = (         short *)&i_shMesGarantia;
         sqlstm.sqinds[16] = (         int  )0;
         sqlstm.sqharm[16] = (unsigned long )0;
         sqlstm.sqadto[16] = (unsigned short )0;
         sqlstm.sqtdso[16] = (unsigned short )0;
         sqlstm.sqhstv[17] = (unsigned char  *)szhNumPreGuia;
         sqlstm.sqhstl[17] = (unsigned long )11;
         sqlstm.sqhsts[17] = (         int  )0;
         sqlstm.sqindv[17] = (         short *)&i_shNumPreGuia;
         sqlstm.sqinds[17] = (         int  )0;
         sqlstm.sqharm[17] = (unsigned long )0;
         sqlstm.sqadto[17] = (unsigned short )0;
         sqlstm.sqtdso[17] = (unsigned short )0;
         sqlstm.sqhstv[18] = (unsigned char  *)szhNumGuia;
         sqlstm.sqhstl[18] = (unsigned long )11;
         sqlstm.sqhsts[18] = (         int  )0;
         sqlstm.sqindv[18] = (         short *)&i_shNumGuia;
         sqlstm.sqinds[18] = (         int  )0;
         sqlstm.sqharm[18] = (unsigned long )0;
         sqlstm.sqadto[18] = (unsigned short )0;
         sqlstm.sqtdso[18] = (unsigned short )0;
         sqlstm.sqhstv[19] = (unsigned char  *)&lhNumTransaccion;
         sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[19] = (         int  )0;
         sqlstm.sqindv[19] = (         short *)&i_shNumTransaccion;
         sqlstm.sqinds[19] = (         int  )0;
         sqlstm.sqharm[19] = (unsigned long )0;
         sqlstm.sqadto[19] = (unsigned short )0;
         sqlstm.sqtdso[19] = (unsigned short )0;
         sqlstm.sqhstv[20] = (unsigned char  *)&lhNumVenta;
         sqlstm.sqhstl[20] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[20] = (         int  )0;
         sqlstm.sqindv[20] = (         short *)&i_shNumVenta;
         sqlstm.sqinds[20] = (         int  )0;
         sqlstm.sqharm[20] = (unsigned long )0;
         sqlstm.sqadto[20] = (unsigned short )0;
         sqlstm.sqtdso[20] = (unsigned short )0;
         sqlstm.sqhstv[21] = (unsigned char  *)&lhNumFactura;
         sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[21] = (         int  )0;
         sqlstm.sqindv[21] = (         short *)&i_shNumFactura;
         sqlstm.sqinds[21] = (         int  )0;
         sqlstm.sqharm[21] = (unsigned long )0;
         sqlstm.sqadto[21] = (unsigned short )0;
         sqlstm.sqtdso[21] = (unsigned short )0;
         sqlstm.sqhstv[22] = (unsigned char  *)&ihCodConceptoDto;
         sqlstm.sqhstl[22] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[22] = (         int  )0;
         sqlstm.sqindv[22] = (         short *)&i_shCodConceptoDto;
         sqlstm.sqinds[22] = (         int  )0;
         sqlstm.sqharm[22] = (unsigned long )0;
         sqlstm.sqadto[22] = (unsigned short )0;
         sqlstm.sqtdso[22] = (unsigned short )0;
         sqlstm.sqhstv[23] = (unsigned char  *)&dhValDto;
         sqlstm.sqhstl[23] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[23] = (         int  )0;
         sqlstm.sqindv[23] = (         short *)&i_shValDto;
         sqlstm.sqinds[23] = (         int  )0;
         sqlstm.sqharm[23] = (unsigned long )0;
         sqlstm.sqadto[23] = (unsigned short )0;
         sqlstm.sqtdso[23] = (unsigned short )0;
         sqlstm.sqhstv[24] = (unsigned char  *)&shTipDto;
         sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[24] = (         int  )0;
         sqlstm.sqindv[24] = (         short *)&i_shTipDto;
         sqlstm.sqinds[24] = (         int  )0;
         sqlstm.sqharm[24] = (unsigned long )0;
         sqlstm.sqadto[24] = (unsigned short )0;
         sqlstm.sqtdso[24] = (unsigned short )0;
         sqlstm.sqhstv[25] = (unsigned char  *)&shIndCuota;
         sqlstm.sqhstl[25] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[25] = (         int  )0;
         sqlstm.sqindv[25] = (         short *)&i_shIndCuota;
         sqlstm.sqinds[25] = (         int  )0;
         sqlstm.sqharm[25] = (unsigned long )0;
         sqlstm.sqadto[25] = (unsigned short )0;
         sqlstm.sqtdso[25] = (unsigned short )0;
         sqlstm.sqhstv[26] = (unsigned char  *)&ihNumPaquete;
         sqlstm.sqhstl[26] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[26] = (         int  )0;
         sqlstm.sqindv[26] = (         short *)&i_shNumPaquete;
         sqlstm.sqinds[26] = (         int  )0;
         sqlstm.sqharm[26] = (unsigned long )0;
         sqlstm.sqadto[26] = (unsigned short )0;
         sqlstm.sqtdso[26] = (unsigned short )0;
         sqlstm.sqhstv[27] = (unsigned char  *)&shIndFactur;
         sqlstm.sqhstl[27] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[27] = (         int  )0;
         sqlstm.sqindv[27] = (         short *)0;
         sqlstm.sqinds[27] = (         int  )0;
         sqlstm.sqharm[27] = (unsigned long )0;
         sqlstm.sqadto[27] = (unsigned short )0;
         sqlstm.sqtdso[27] = (unsigned short )0;
         sqlstm.sqhstv[28] = (unsigned char  *)&shIndSuperTel;
         sqlstm.sqhstl[28] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[28] = (         int  )0;
         sqlstm.sqindv[28] = (         short *)&i_shIndSuperTel;
         sqlstm.sqinds[28] = (         int  )0;
         sqlstm.sqharm[28] = (unsigned long )0;
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


        if (SQLCODE == SQLOK)
        {
            if ((stCliente.pCargos =
                (CARGOS *)realloc ( (CARGOS *)stCliente.pCargos,
                sizeof(CARGOS)*(stCliente.iNumCargos+1) ))==(CARGOS *)NULL)
            {
                iDError (szExeName,ERR005,vInsertarIncidencia,
                         "stCliente.pCargos");
                return FALSE                 ;
            }
            i = stCliente.iNumCargos         ;

            stCliente.pCargos[i].lNumCargo    = lhNumCargo   ;
            stCliente.pCargos[i].lCodCliente  = lhCodCliente ;
            stCliente.pCargos[i].iCodConcepto = ihCodConcepto;
            stCliente.pCargos[i].iCodProducto = shCodProducto;
            stCliente.pCargos[i].dImpCargo    = dhImpCargo   ;
            stCliente.pCargos[i].lCodPlanCom  = lhCodPlanCom ;
            stCliente.pCargos[i].lNumUnidades = lhNumUnidades; /* Incorporado por PGonzaleg 4-03-2002 */
            stCliente.pCargos[i].iIndFactur   = shIndFactur  ;

            stCliente.pCargos[i].lNumAbonado  =
                            (i_shNumAbonado == ORA_NULL)?-1:lhNumAbonado ;
            stCliente.pCargos[i].lCodCiclFact =
                            (i_shCodCiclFact== ORA_NULL)?-1:lhCodCiclFact;
            stCliente.pCargos[i].lCapCode     =
                            (i_shCapCode    == ORA_NULL)?-1:lhCapCode    ;
            stCliente.pCargos[i].iMesGarantia =
                            (i_shMesGarantia== ORA_NULL)?-1:ihMesGarantia;
            stCliente.pCargos[i].lNumVenta    =
                            (i_shNumVenta   == ORA_NULL)?-1:lhNumVenta   ;
            stCliente.pCargos[i].lNumFactura  =
                            (i_shNumFactura == ORA_NULL)?-1:lhNumFactura ;
            stCliente.pCargos[i].dValDto         =
                            (i_shValDto     == ORA_NULL)?-1:dhValDto     ;
            stCliente.pCargos[i].iTipDto         =
                            (i_shTipDto     == ORA_NULL)?-1:shTipDto     ;
            stCliente.pCargos[i].iIndCuota       =
                            (i_shIndCuota   == ORA_NULL)?-1:shIndCuota   ;
            stCliente.pCargos[i].iNumPaquete     =
                            (i_shNumPaquete == ORA_NULL)?-1:ihNumPaquete ;
            stCliente.pCargos[i].iIndSuperTel    =
                            (i_shIndSuperTel== ORA_NULL)?-1:shIndSuperTel;

            stCliente.pCargos[i].lNumTransaccion =
                            (i_shNumTransaccion==ORA_NULL)?-1:lhNumTransaccion;
            stCliente.pCargos[i].iCodConceptoDto =
                            (i_shCodConceptoDto==ORA_NULL)?-1:ihCodConceptoDto;
            stCliente.pCargos[i].lNumVenta =
                            (i_shNumVenta==ORA_NULL)?-1:lhNumVenta;

            if (i_shNumPreGuia  == ORA_NULL)
                strcpy (stCliente.pCargos[i].szNumPreGuia ,"");
            if (i_shNumGuia     == ORA_NULL)
                strcpy (stCliente.pCargos[i].szNumGuia    ,"");
            if (i_shNumSerie    == ORA_NULL)
                strcpy (stCliente.pCargos[i].szNumSerie   ,"");
            if (i_shNumTerminal == ORA_NULL)
                strcpy (stCliente.pCargos[i].szNumTerminal,"");
            if (i_shNumSerieMec == ORA_NULL)
                strcpy (stCliente.pCargos[i].szNumSerieMec,"");

            stCliente.iNumCargos++;

        }/* fin if SQLCODE == SQLOK */

  }/* fin while ... */
  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->Ge_Cargos",
               szfnORAerror());
      return  FALSE           ;
  }
  /* EXEC SQL CLOSE Cur_CargosRentRoa; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )187;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->Ge_Cargos",
               szfnORAerror());
      return  FALSE           ;
  }
  return TRUE;
}/************************* Final bfnCargaCargosRentPhone ********************/


/*****************************************************************************/
/*                        funcion : bfnCargaCargosOcasionales        */
/* -Funcion que carga los Cargos del Cliente-Abonado teniendo encuenta la Fec*/
/*  de Alta del Cargo y el Periodo de Alquiler del Celular o los Cargos del  */
/*  Cliente-Abonado de los Roaming Visitante.                                */
/* -Valores Retorno : Error->FALSE, !Error->TRUE.                            */
/*****************************************************************************/
static BOOL bfnCargaCargosOcasionales ( long  lNumAbonado )
{
  int i = 0;

  /* EXEC SQL BEGIN DECLARE SECTION ; */ 

  static char   szhRowId[19]         ; /* EXEC SQL VAR szhRowId        IS STRING(19); */ 

  static long   lhNumCargo       ;
  static long   lhCodCliente     ;
  static short  shCodProducto    ;
  static int    ihCodConcepto    ;
  static char   szhFecAlta[15]   ; /* EXEC SQL VAR szhFecAlta      IS STRING(15); */ 

  static double dhImpCargo       ;
  static char   szhCodMoneda[4]  ; /* EXEC SQL VAR szhCodMoneda    IS STRING(4) ; */ 

  static long   lhCodPlanCom     ;
  static int    lhNumUnidades    ;  
  static long   lhNumAbonado     ;
  static char   szhNumTerminal[16]; /* EXEC SQL VAR szhNumTerminal  IS STRING(16); */ 
 
  static long   lhCodCiclFact    ;
  static char   szhNumSerie[26]  ; /* EXEC SQL VAR szhNumSerie     IS STRING(26); */ 

  static char   szhNumSerieMec[26]; /* EXEC SQL VAR szhNumSerieMec  IS STRING(26); */ 

  static long   lhCapCode        ;
  static int    ihMesGarantia    ;
  static char   szhNumPreGuia[11]; /* EXEC SQL VAR szhNumPreGuia   IS STRING(11); */ 

  static char   szhNumGuia[11]   ; /* EXEC SQL VAR szhNumGuia      IS STRING(11); */ 

  static long   lhNumTrans ;
  static long   lhNumVenta       ;
  static long   lhNumFactura     ;
  static int    ihCodConcDto ;
  static double dhValDto         ;
  static short  shTipDto         ;
  static short  shIndCuota       ;
  static int    ihNumPaquete     ;
  static short  shIndFactur      ;
  static short  shIndSuperTel    ;
  
  static short  i_shCodPlanCom   ;
  static short  i_shNumAbonado   ;
  static short  i_shNumTerminal  ;
  static short  i_shCodCiclFact  ;
  static short  i_shNumSerie     ;
  static short  i_shNumSerieMec  ;
  static short  i_shCapCode      ;
  static short  i_shMesGarantia  ;
  static short  i_shNumPreGuia   ;
  static short  i_shNumGuia      ;
  static short  i_shNumTrans     ;
  static short  i_shNumVenta     ;
  static short  i_shNumFactura   ;
  static short  i_shCodConcDto    ;
  static short  i_shValDto       ;
  static short  i_shTipDto       ;
  static short  i_shIndCuota     ;
  static short  i_shNumPaquete   ;  
  static short  i_shIndSuperTel  ;
  static char   szhFecHasta[15]  ; /* EXEC SQL VAR szhFecHasta     IS STRING(15); */ 

  
  static char  szFormatoFec[17]  ; /* EXEC SQL VAR szFormatoFec  IS STRING(17); */ 

  static int   iCero=0;
  static int   ihUno = 1;

  /* EXEC SQL END DECLARE SECTION   ; */ 


  strcpy(szFormatoFec,"YYYYMMDDHH24MISS");

  lhCodCliente  = stCliente.lCodCliente;
  lhCodCiclFact = stCiclo.lCodCiclFact;
  /*lhNumAbonado  = lNumAbonado          ; Se quita el num abonado porque la consulta debe ser a nivel de cliente*/
  strcpy(szhFecHasta,stCiclo.szFecHastaCFijos);

  vDTrazasLog (szExeName,
                   "\n\t\t* Parametros de Entrada bfnCargaCargosOcasionales (FACT_CICLO)\n"
                   "\t\t=> Cod.Cliente  [%ld]\n"
                   "\t\t=> Num.Abonado  [%ld]\n"
                   "\t\t=> Cod.CicloFact[%ld] \n"
                   "\t\t=> Fec.Hasta     [%s] \n",LOG04,
                   lhCodCliente,lhNumAbonado,lhCodCiclFact,szhFecHasta );
  
  
  /* EXEC SQL DECLARE Cur_CargosOcasionales CURSOR FOR
	SELECT
		  ROWID				 ,
		  SEQ_CARGO          , 
		  COD_CONCEPTO       , 
		  TO_CHAR (FEC_ALTA,:szFormatoFec),
		  IMP_CARGO          , 
		  COD_MONEDA         , 
		  COD_PLANCOM        , 
		  NUM_UNIDADES       , 
		  NUM_ABONADO        , 
		  NUM_TERMINAL       , 
		  NUM_SERIE          , 
		  NUM_SERIEMEC       , 
		  CAP_CODE           , 
		  MES_GARANTIA       , 
		  NUM_PREGUIA        , 
		  NUM_GUIA           , 
		  NUM_TRANSACCION    , 
		  NUM_VENTA          , 
		  NUM_FACTURA        , 
		  COD_CONCEPTO_DTO   , 
          VAL_DTO            , 
		  TIP_DTO            , 
		  IND_CUOTA          , 
		  NUM_PAQUETE        , 
		  IND_FACTUR         , 
		  IND_SUPERTEL         
	 FROM FA_CARGOS_TO
	 WHERE  COD_CLIENTE   = :lhCodCliente
       AND  COD_CICLFACT  = :lhCodCiclFact
       AND  FEC_ALTA     <= TO_DATE (:szhFecHasta,:szFormatoFec)
       AND  NUM_FACTURA   = :iCero
       AND  IND_FACTUR    = :ihUno; */ 


  /* EXEC SQL OPEN Cur_CargosOcasionales; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = sq0002;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )202;
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
  sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szFormatoFec;
  sqlstm.sqhstl[4] = (unsigned long )17;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&iCero;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&ihUno;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,"Open->FA_CARGOS_TO",
               szfnORAerror());
      return FALSE            ;
  }
  while (SQLCODE == SQLOK)
  {
 
         
         /* EXEC SQL FETCH Cur_CargosOcasionales INTO
                        :szhRowId							,
                        :lhNumCargo                         ,
                        :ihCodConcepto                      ,
                        :szhFecAlta                         ,
                        :dhImpCargo                         ,
                        :szhCodMoneda                       ,
                        :lhCodPlanCom:i_shCodPlanCom        ,
                        :lhNumUnidades                      , 
                        :lhNumAbonado:i_shNumAbonado        ,
                        :szhNumTerminal:i_shNumTerminal     ,
                        :szhNumSerie:i_shNumSerie           ,
                        :szhNumSerieMec:i_shNumSerieMec     ,
                        :lhCapCode:i_shCapCode              ,
                        :ihMesGarantia:i_shMesGarantia      ,
                        :szhNumPreGuia:i_shNumPreGuia       ,
                        :szhNumGuia:i_shNumGuia             ,
                        :lhNumTrans:i_shNumTrans            ,
                        :lhNumVenta:i_shNumVenta            ,
                        :lhNumFactura:i_shNumFactura        ,
                        :ihCodConcDto:i_shCodConcDto        ,
                        :dhValDto:i_shValDto                ,
                        :shTipDto:i_shTipDto                ,
                        :shIndCuota:i_shIndCuota            ,
                        :ihNumPaquete:i_shNumPaquete        ,
                        :shIndFactur                        ,
                        :shIndSuperTel:i_shIndSuperTel      ; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 29;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )245;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)szhRowId;
         sqlstm.sqhstl[0] = (unsigned long )19;
         sqlstm.sqhsts[0] = (         int  )0;
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)&lhNumCargo;
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
         sqlstm.sqhstv[3] = (unsigned char  *)szhFecAlta;
         sqlstm.sqhstl[3] = (unsigned long )15;
         sqlstm.sqhsts[3] = (         int  )0;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)&dhImpCargo;
         sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
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
         sqlstm.sqhstv[6] = (unsigned char  *)&lhCodPlanCom;
         sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[6] = (         int  )0;
         sqlstm.sqindv[6] = (         short *)&i_shCodPlanCom;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)&lhNumUnidades;
         sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[7] = (         int  )0;
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)&lhNumAbonado;
         sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[8] = (         int  )0;
         sqlstm.sqindv[8] = (         short *)&i_shNumAbonado;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)szhNumTerminal;
         sqlstm.sqhstl[9] = (unsigned long )16;
         sqlstm.sqhsts[9] = (         int  )0;
         sqlstm.sqindv[9] = (         short *)&i_shNumTerminal;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)szhNumSerie;
         sqlstm.sqhstl[10] = (unsigned long )26;
         sqlstm.sqhsts[10] = (         int  )0;
         sqlstm.sqindv[10] = (         short *)&i_shNumSerie;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)szhNumSerieMec;
         sqlstm.sqhstl[11] = (unsigned long )26;
         sqlstm.sqhsts[11] = (         int  )0;
         sqlstm.sqindv[11] = (         short *)&i_shNumSerieMec;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)&lhCapCode;
         sqlstm.sqhstl[12] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[12] = (         int  )0;
         sqlstm.sqindv[12] = (         short *)&i_shCapCode;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)&ihMesGarantia;
         sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[13] = (         int  )0;
         sqlstm.sqindv[13] = (         short *)&i_shMesGarantia;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqadto[13] = (unsigned short )0;
         sqlstm.sqtdso[13] = (unsigned short )0;
         sqlstm.sqhstv[14] = (unsigned char  *)szhNumPreGuia;
         sqlstm.sqhstl[14] = (unsigned long )11;
         sqlstm.sqhsts[14] = (         int  )0;
         sqlstm.sqindv[14] = (         short *)&i_shNumPreGuia;
         sqlstm.sqinds[14] = (         int  )0;
         sqlstm.sqharm[14] = (unsigned long )0;
         sqlstm.sqadto[14] = (unsigned short )0;
         sqlstm.sqtdso[14] = (unsigned short )0;
         sqlstm.sqhstv[15] = (unsigned char  *)szhNumGuia;
         sqlstm.sqhstl[15] = (unsigned long )11;
         sqlstm.sqhsts[15] = (         int  )0;
         sqlstm.sqindv[15] = (         short *)&i_shNumGuia;
         sqlstm.sqinds[15] = (         int  )0;
         sqlstm.sqharm[15] = (unsigned long )0;
         sqlstm.sqadto[15] = (unsigned short )0;
         sqlstm.sqtdso[15] = (unsigned short )0;
         sqlstm.sqhstv[16] = (unsigned char  *)&lhNumTrans;
         sqlstm.sqhstl[16] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[16] = (         int  )0;
         sqlstm.sqindv[16] = (         short *)&i_shNumTrans;
         sqlstm.sqinds[16] = (         int  )0;
         sqlstm.sqharm[16] = (unsigned long )0;
         sqlstm.sqadto[16] = (unsigned short )0;
         sqlstm.sqtdso[16] = (unsigned short )0;
         sqlstm.sqhstv[17] = (unsigned char  *)&lhNumVenta;
         sqlstm.sqhstl[17] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[17] = (         int  )0;
         sqlstm.sqindv[17] = (         short *)&i_shNumVenta;
         sqlstm.sqinds[17] = (         int  )0;
         sqlstm.sqharm[17] = (unsigned long )0;
         sqlstm.sqadto[17] = (unsigned short )0;
         sqlstm.sqtdso[17] = (unsigned short )0;
         sqlstm.sqhstv[18] = (unsigned char  *)&lhNumFactura;
         sqlstm.sqhstl[18] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[18] = (         int  )0;
         sqlstm.sqindv[18] = (         short *)&i_shNumFactura;
         sqlstm.sqinds[18] = (         int  )0;
         sqlstm.sqharm[18] = (unsigned long )0;
         sqlstm.sqadto[18] = (unsigned short )0;
         sqlstm.sqtdso[18] = (unsigned short )0;
         sqlstm.sqhstv[19] = (unsigned char  *)&ihCodConcDto;
         sqlstm.sqhstl[19] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[19] = (         int  )0;
         sqlstm.sqindv[19] = (         short *)&i_shCodConcDto;
         sqlstm.sqinds[19] = (         int  )0;
         sqlstm.sqharm[19] = (unsigned long )0;
         sqlstm.sqadto[19] = (unsigned short )0;
         sqlstm.sqtdso[19] = (unsigned short )0;
         sqlstm.sqhstv[20] = (unsigned char  *)&dhValDto;
         sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[20] = (         int  )0;
         sqlstm.sqindv[20] = (         short *)&i_shValDto;
         sqlstm.sqinds[20] = (         int  )0;
         sqlstm.sqharm[20] = (unsigned long )0;
         sqlstm.sqadto[20] = (unsigned short )0;
         sqlstm.sqtdso[20] = (unsigned short )0;
         sqlstm.sqhstv[21] = (unsigned char  *)&shTipDto;
         sqlstm.sqhstl[21] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[21] = (         int  )0;
         sqlstm.sqindv[21] = (         short *)&i_shTipDto;
         sqlstm.sqinds[21] = (         int  )0;
         sqlstm.sqharm[21] = (unsigned long )0;
         sqlstm.sqadto[21] = (unsigned short )0;
         sqlstm.sqtdso[21] = (unsigned short )0;
         sqlstm.sqhstv[22] = (unsigned char  *)&shIndCuota;
         sqlstm.sqhstl[22] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[22] = (         int  )0;
         sqlstm.sqindv[22] = (         short *)&i_shIndCuota;
         sqlstm.sqinds[22] = (         int  )0;
         sqlstm.sqharm[22] = (unsigned long )0;
         sqlstm.sqadto[22] = (unsigned short )0;
         sqlstm.sqtdso[22] = (unsigned short )0;
         sqlstm.sqhstv[23] = (unsigned char  *)&ihNumPaquete;
         sqlstm.sqhstl[23] = (unsigned long )sizeof(int);
         sqlstm.sqhsts[23] = (         int  )0;
         sqlstm.sqindv[23] = (         short *)&i_shNumPaquete;
         sqlstm.sqinds[23] = (         int  )0;
         sqlstm.sqharm[23] = (unsigned long )0;
         sqlstm.sqadto[23] = (unsigned short )0;
         sqlstm.sqtdso[23] = (unsigned short )0;
         sqlstm.sqhstv[24] = (unsigned char  *)&shIndFactur;
         sqlstm.sqhstl[24] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[24] = (         int  )0;
         sqlstm.sqindv[24] = (         short *)0;
         sqlstm.sqinds[24] = (         int  )0;
         sqlstm.sqharm[24] = (unsigned long )0;
         sqlstm.sqadto[24] = (unsigned short )0;
         sqlstm.sqtdso[24] = (unsigned short )0;
         sqlstm.sqhstv[25] = (unsigned char  *)&shIndSuperTel;
         sqlstm.sqhstl[25] = (unsigned long )sizeof(short);
         sqlstm.sqhsts[25] = (         int  )0;
         sqlstm.sqindv[25] = (         short *)&i_shIndSuperTel;
         sqlstm.sqinds[25] = (         int  )0;
         sqlstm.sqharm[25] = (unsigned long )0;
         sqlstm.sqadto[25] = (unsigned short )0;
         sqlstm.sqtdso[25] = (unsigned short )0;
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



                        
        if (SQLCODE == SQLOK)
        {

            
            if ((stCliente.pCargos = (CARGOS *)realloc ( (CARGOS *)stCliente.pCargos,
            	 sizeof(CARGOS)*(stCliente.iNumCargos+1) ))==(CARGOS *)NULL)
            {
                iDError (szExeName,ERR005,vInsertarIncidencia,
                         "stCliente.pCargos");
                return FALSE                 ;
            }

            i = stCliente.iNumCargos         ;

            strcpy (stCliente.pCargos[i].szRowid, szhRowId)   ;
            
            stCliente.pCargos[i].lNumCargo    = lhNumCargo   ;
            stCliente.pCargos[i].lCodCliente  = lhCodCliente ;
            stCliente.pCargos[i].iCodConcepto = ihCodConcepto;
            stCliente.pCargos[i].iCodProducto = ihUno;
            stCliente.pCargos[i].dImpCargo    = dhImpCargo   ;
            stCliente.pCargos[i].lCodPlanCom  = (i_shCodPlanCom == ORA_NULL)?-1:lhCodPlanCom ;
            stCliente.pCargos[i].lNumUnidades = lhNumUnidades; 
            stCliente.pCargos[i].iIndFactur   = shIndFactur  ;

            stCliente.pCargos[i].lNumAbonado  = (i_shNumAbonado == ORA_NULL)?-1:lhNumAbonado ;
            stCliente.pCargos[i].lCodCiclFact = (i_shCodCiclFact== ORA_NULL)?-1:lhCodCiclFact;
            stCliente.pCargos[i].lCapCode     = (i_shCapCode    == ORA_NULL)?-1:lhCapCode    ;
            stCliente.pCargos[i].iMesGarantia = (i_shMesGarantia== ORA_NULL)?-1:ihMesGarantia;
            stCliente.pCargos[i].lNumVenta    = (i_shNumVenta   == ORA_NULL)?-1:lhNumVenta   ;
            stCliente.pCargos[i].lNumFactura  = (i_shNumFactura == ORA_NULL)?-1:lhNumFactura ;
            stCliente.pCargos[i].dValDto      = (i_shValDto     == ORA_NULL)?-1:dhValDto     ;
            stCliente.pCargos[i].iTipDto      = (i_shTipDto     == ORA_NULL)?-1:shTipDto     ;
            stCliente.pCargos[i].iIndCuota    = (i_shIndCuota   == ORA_NULL)?-1:shIndCuota   ;
            stCliente.pCargos[i].iNumPaquete  = (i_shNumPaquete == ORA_NULL)?-1:ihNumPaquete ;
            stCliente.pCargos[i].iIndSuperTel = (i_shIndSuperTel== ORA_NULL)?-1:shIndSuperTel;
            stCliente.pCargos[i].lNumTransaccion = (i_shNumTrans==ORA_NULL)?-1:lhNumTrans;
            stCliente.pCargos[i].iCodConceptoDto = (i_shCodConcDto==ORA_NULL)?-1:ihCodConcDto;
            stCliente.pCargos[i].lNumVenta    = (i_shNumVenta==ORA_NULL)?-1:lhNumVenta;

            strcpy (stCliente.pCargos[i].szFecAlta ,szhFecAlta);
            strcpy (stCliente.pCargos[i].szCodMoneda,szhCodMoneda);
            
            if (i_shNumPreGuia  == ORA_NULL)
            {
                strcpy (stCliente.pCargos[i].szNumPreGuia ,"");
            }else{
            	strcpy (stCliente.pCargos[i].szNumPreGuia ,szhNumPreGuia);
            }
            
            if (i_shNumGuia     == ORA_NULL)
            {
                strcpy (stCliente.pCargos[i].szNumGuia    ,"");
            }else{
            	strcpy (stCliente.pCargos[i].szNumGuia    ,szhNumGuia);
            }
            
            if (i_shNumSerie    == ORA_NULL)
            {
                strcpy (stCliente.pCargos[i].szNumSerie   ,"");
            }else{
            	strcpy (stCliente.pCargos[i].szNumSerie   ,szhNumSerie);
            }
            
            if (i_shNumTerminal == ORA_NULL)
            {
                strcpy (stCliente.pCargos[i].szNumTerminal,"");
            }else{
            	strcpy (stCliente.pCargos[i].szNumTerminal,szhNumTerminal);
            }
            
            if (i_shNumSerieMec == ORA_NULL)
            {
                strcpy (stCliente.pCargos[i].szNumSerieMec,"");
            }else{
            	strcpy (stCliente.pCargos[i].szNumSerieMec,szhNumSerieMec);
            }
            
			strcpy(stCliente.pCargos[i].szCodCiudad   ,
            	stCliente.szCodCiudad)   ;
            strcpy(stCliente.pCargos[i].szCodRegion   ,
                stCliente.szCodRegion)   ;
            strcpy(stCliente.pCargos[i].szCodProvincia,
                stCliente.szCodProvincia);
            
            if (!bValidacionCargo(stCliente.iNumCargos))
                return FALSE;
            
            stCliente.pCargos[i].iFlagFaCargo = 1;
			
            
            stCliente.iNumCargos++;

        }

  }
  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Fetch->FA_CARGOS_TO",
               szfnORAerror());
      return  FALSE           ;
  }
  /* EXEC SQL CLOSE Cur_CargosOcasionales; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 29;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )364;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if (SQLCODE != SQLOK)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Close->FA_CARGOS_TO",
               szfnORAerror());
      return  FALSE           ;
  }
  return TRUE;
}
/************************* Final bfnCargaCargosOcasionales ********************/



/*****************************************************************************/
/*                           funcion : vPrintRegCargo                        */
/*****************************************************************************/
static void vPrintRegCargo (int iInd)
{
    vDTrazasLog(szExeName,"\n\t\t* Registro de Cargos \n"
    					  "\n\t\t[%d].Numero de Cargo.........[%ld]"
    					  "\n\t\t[%d].Cod.Cliente.............[%ld]"
    					  "\n\t\t[%d].Numero de Abonado.......[%ld]"
    					  "\n\t\t[%d].Numero de Terminal......[%s]"
    					  "\n\t\t[%d].Cod.CiclFact............[%ld]"
    					  "\n\t\t[%d].Fecha de Alta...........[%s]"
    					  "\n\t\t[%d].Codigo de Concepto......[%ld]"
    					  "\n\t\t[%d].Cod.Producto............[%d]"
    					  "\n\t\t[%d].Importe del Cargo.......[%f]"
    					  "\n\t\t[%d].Numero Serie............[%s]"
    					  "\n\t\t[%d].Numero Serie Ele........[%s]"
    					  "\n\t\t[%d].Cap. Code...............[%ld]"
    					  "\n\t\t[%d].Numero Unidades.........[%d]"
    					  "\n\t\t[%d].Codigo Plan Comercial...[%ld]"
    					  "\n\t\t[%d].Codigo Ciudad...........[%s]"
    					  "\n\t\t[%d].Cod.Provincia...........[%s]"
    					  "\n\t\t[%d].Cod.Region..............[%s]"
    					  "\n\t\t[%d].Mes Garantia ...........[%d]"
    					  "\n\t\t[%d].Numero de Preguia.......[%s]"
    					  "\n\t\t[%d].Numero de Guia..........[%s]"
    					  "\n\t\t[%d].Numero de Transaccion...[%ld]"
    					  "\n\t\t[%d].Numero Factura..........[%ld]"
    					  "\n\t\t[%d].Valor Descuento.........[%f]"
    					  "\n\t\t[%d].Tipo Descuento..........[%d]"
    					  "\n\t\t[%d].Ind.Cuota...............[%d]"
    					  "\n\t\t[%d].Ind.Factur..............[%d]"
    					  ,LOG05
                		  ,iInd,stCliente.pCargos[iInd].lNumCargo
                		  ,iInd,stCliente.pCargos[iInd].lCodCliente
                		  ,iInd,stCliente.pCargos[iInd].lNumAbonado
                		  ,iInd,stCliente.pCargos[iInd].szNumTerminal
                		  ,iInd,stCliente.pCargos[iInd].lCodCiclFact
                		  ,iInd,stCliente.pCargos[iInd].szFecAlta
                		  ,iInd,stCliente.pCargos[iInd].iCodConcepto
                		  ,iInd,stCliente.pCargos[iInd].iCodProducto
                		  ,iInd,stCliente.pCargos[iInd].dImpCargo
                		  ,iInd,stCliente.pCargos[iInd].szNumSerieMec
                		  ,iInd,stCliente.pCargos[iInd].szNumSerie
                		  ,iInd,stCliente.pCargos[iInd].lCapCode
                		  ,iInd,stCliente.pCargos[iInd].lNumUnidades	/* Incorporado por PGonzaleg 4-03-2002 */
                		  ,iInd,stCliente.pCargos[iInd].lCodPlanCom
                		  ,iInd,stCliente.pCargos[iInd].szCodCiudad
                		  ,iInd,stCliente.pCargos[iInd].szCodProvincia
                		  ,iInd,stCliente.pCargos[iInd].szCodRegion
                		  ,iInd,stCliente.pCargos[iInd].iMesGarantia
                		  ,iInd,stCliente.pCargos[iInd].szNumPreGuia
                		  ,iInd,stCliente.pCargos[iInd].szNumGuia
                		  ,iInd,stCliente.pCargos[iInd].lNumTransaccion
                		  ,iInd,stCliente.pCargos[iInd].lNumFactura
                		  ,iInd,stCliente.pCargos[iInd].dValDto
                		  ,iInd,stCliente.pCargos[iInd].iTipDto
                		  ,iInd,stCliente.pCargos[iInd].iIndCuota
                		  ,iInd,stCliente.pCargos[iInd].iIndFactur);

}/*********************** Final vPrintRegCargo ********************************/


/*****************************************************************************/
/*                       funcion : bUpdateCargos                             */
/*****************************************************************************/
static BOOL bUpdateCargos (char *szRowid)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static long  lhNumProceso;
   static char* szhRowid    ; /* EXEC SQL VAR szhRowid IS STRING(19); */ 

   /* EXEC SQL END DECLARE SECTION  ; */ 


   if (stStatus.IdPro2 > 0)
       lhNumProceso = stStatus.IdPro2;
   else
       lhNumProceso = stStatus.IdPro;

   szhRowid     = szRowid       ;

   /* EXEC SQL UPDATE /o+ Rowid (GE_CARGOS) o/
                   GE_CARGOS
            SET    NUM_FACTURA = :lhNumProceso
            WHERE  ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update  /*+  Rowid (GE_CARGOS)  +*/ GE_CARGOS  set NUM_FAC\
TURA=:b0 where ROWID=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )379;
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
   sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
   sqlstm.sqhstl[1] = (unsigned long )19;
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


   if (SQLCODE) 
       iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Ga_Cargos",
                szfnORAerror());

   return (SQLCODE)?FALSE:TRUE;
}/********************* Final bUpdateCargos **********************************/

/*****************************************************************************/
/*                       funcion : bUpdateCargosOcacionales                  */
/*****************************************************************************/
static BOOL bUpdateCargosOcacionales (char *szRowid)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static long  lhNumProceso;
   static char* szhRowid    ; /* EXEC SQL VAR szhRowid IS STRING(19); */ 

   /* EXEC SQL END DECLARE SECTION  ; */ 


   if (stStatus.IdPro2 > 0)
       lhNumProceso = stStatus.IdPro2;
   else
       lhNumProceso = stStatus.IdPro;

   szhRowid     = szRowid       ;

   /* EXEC SQL UPDATE 
                   FA_CARGOS_TO
            SET    NUM_FACTURA = :lhNumProceso
            WHERE  ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 29;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_CARGOS_TO  set NUM_FACTURA=:b0 where ROWID=:b1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )402;
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
   sqlstm.sqhstv[1] = (unsigned char  *)szhRowid;
   sqlstm.sqhstl[1] = (unsigned long )19;
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


   if (SQLCODE) 
       iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Fa_Cargos_To",
                szfnORAerror());

   return (SQLCODE)?FALSE:TRUE;
}/********************* Final bUpdateCargosOcacionales ************************/


/*****************************************************************************/
/*                         funcion : bValidacionCargo                        */
/* -Funcion que valida un cargo                                              */
/* -Entrada : CARGO stCargo                                                  */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bValidacionCargo (int iInd)
{
   int iRes = 0;
   CONCEPTO stConcepto;

   memset (&stConcepto,0,sizeof(CONCEPTO));

   if (!bFindConcepto (stCliente.pCargos[iInd].iCodConcepto,&stConcepto))
   {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
       iRes = ERR021                                                ;
   }
   else
   {
       strcpy (stCliente.pCargos[iInd].szCodModulo  , stConcepto.szCodModulo  );
       strcpy (stCliente.pCargos[iInd].szDesConcepto, stConcepto.szDesConcepto);
	   if (stConcepto.iIndActivo == 0)
   	   {
	       sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
	                stConcepto.iIndActivo);
	       iRes = ERR001;
	   }
   }


    vDTrazasLog(szExeName,"\t\tValido Cargo Positivo  \n",LOG05);

   if  (iRes == 0 &&
       (stConcepto.iCodTipConce == IMPUESTO ||
        stConcepto.iCodTipConce == DESCUENTO) )
   {
        sprintf (stAnomProceso.szObsAnomalia,"%s %d",
                 "Tipo de Concepto (Descuento o Impuesto)",
                 stConcepto.iCodTipConce);
        iRes = ERR001;

    }

    if (iRes == 0)
    {
        if ( strcmp (stCliente.pCargos[iInd].szCodMoneda,
                     stConcepto.szCodMoneda) != 0 )
        {
             if (!bConversionMoneda (stCliente.lCodCliente              ,
                                     stCliente.pCargos[iInd].szCodMoneda,
                                     stConcepto.szCodMoneda             ,
                                     stCiclo.szFecDesdeOCargos          ,
                                     &stCliente.pCargos[iInd].dImpCargo ))
             {                                     
             	 return FALSE; /* P-MIX-09003 4*/
             }
             	        	
             strcpy (stCliente.pCargos[iInd].szCodMoneda,stConcepto.szCodMoneda);
        }
    }

    if (iRes != 0)
    {
        stAnomProceso.iCodConcepto = stCliente.pCargos[iInd].iCodConcepto;
        stAnomProceso.iCodProducto = stCliente.pCargos[iInd].iCodProducto;
        strcpy (stAnomProceso.szDesProceso,"PreBilling Cargos")          ;
        stAnomProceso.lNumAbonado  = stCliente.pCargos[iInd].lNumAbonado ;
        stEstCargos.iNumAnomalias++;
        stEstCargos.dImpAnomalias += (stCliente.pCargos[iInd].dImpCargo *
                                     stCliente.pCargos[iInd].lNumUnidades);
        if (iRes == ERR001)
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stConcepto.iIndActivo  ,
                     stConcepto.iCodTipConce,
                     stCliente.pCargos[iInd].dImpCargo);
        }
    }
    else
    {
        vPrintRegCargo (iInd);
        stEstCargos.iNumCorrectos++;
    }
    stEstCargos.iNumProcesad++;

    return (iRes == 0)?TRUE:FALSE;
}/*********************** Final bValidacionCargo *****************************/

/*****************************************************************************/
/*                          funcion : bEMCargos                              */
/* -Funcion que carga en la estructura stPreFactura los registros a Insertar */
/*  en la Tabla Finales de Facturacion.                                      */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bEMCargos (void)
{
  int    iInd       = 0    ;
  int    i          = 0    ;
  int    k          = 0    ;
  int    iCont      = 0    ;
  int    iRegInsert = 0    ;
  double dImpConceptoAux   ;

  CONCEPTO stConcepto;
  VENTADTO stVentaDto;

  memset (&stConcepto,0,sizeof(CONCEPTO));
  memset (&stVentaDto,0,sizeof(VENTADTO));

  i = stPreFactura.iNumRegistros;

  vDTrazasLog (szExeName,"\n\t\t* Paso a PreFactura de CARGOS \n"
                         "\t\t=> Num.Cargos [%d]\n",
                         LOG03,stCliente.iNumCargos);

  for (iCont=0;iCont<stCliente.iNumCargos;iCont++)
  {
        if (stCliente.pCargos[iCont].dImpCargo != 0.0)
       	{
           	if (( stCliente.pCargos[iCont].iCodConceptoDto != ORA_NULL   &&
               	      stCliente.pCargos[iCont].dValDto         != ORA_NULL   &&
               	      stCliente.pCargos[iCont].iTipDto         != ORA_NULL ) &&
               	     (stCliente.pCargos[iCont].iCodConceptoDto != 0          &&
               	      stCliente.pCargos[iCont].dValDto         != 0 ))
           	{
           		/* RAO210302: Se valida que el Dcto no sea > al cargo */
                      if (stCliente.pCargos[iCont].iTipDto == 0 &&
                          stCliente.pCargos[iCont].dValDto > stCliente.pCargos[iCont].dImpCargo)
                      {
                          iDError (szExeName,ERR000,vInsertarIncidencia,"Cargos:"," valor Dcto > cargo");
                          vDTrazasError (szExeName,"\n\t\t* Error el Dcto es mayor que el cargo \n",LOG01);
                          return FALSE;
                      }
                      else if (stCliente.pCargos[iCont].iTipDto != 0 && stCliente.pCargos[iCont].dValDto > 100)
                           {
                               iDError (szExeName,ERR000,vInsertarIncidencia,"Cargos:"," Dcto > cargo");
                               vDTrazasError (szExeName,"\n\t\t* Error el Dcto es mayor que el cargo \n",LOG01);
                               return FALSE;
                           }

                      iRegInsert = 2                          ;
                      stPreFactura.A_PFactura[i].iFlagDto  = 1;
           	}
           	else /* No hay Dto's */
           	{
                      iRegInsert = 1                         ;
                      stPreFactura.A_PFactura[i].iFlagDto = 0;
           	}

           	/* En Ge_Cargos pueden venir los Descuentos del Concepto */
           	for (iInd=1;iInd<iRegInsert+1;iInd++)
           	{
				i = stPreFactura.iNumRegistros;
				
				stPreFactura.A_PFactura[i].lNumProceso  = stStatus.IdPro       ;
                stPreFactura.A_PFactura[i].lCodCliente  = stCliente.lCodCliente;
                stPreFactura.A_PFactura[i].lNumCargo    =
                                          stCliente.pCargos[iCont].lNumCargo   ;
                stPreFactura.A_PFactura[i].iCodProducto =
                                          stCliente.pCargos[iCont].iCodProducto;

                strcpy (stPreFactura.A_PFactura[i].szFecValor      ,
                		stCiclo.szFecEmision);
                strcpy (stPreFactura.A_PFactura[i].szFecEfectividad,
                        szSysDate  );
                strcpy (stPreFactura.A_PFactura[i].szCodMoneda     ,
                        stCliente.pCargos[iCont].szCodMoneda);

                strcpy (stPreFactura.A_PFactura[i].szCodRegion     ,
                        stCliente.pCargos[iCont].szCodRegion   );
                strcpy (stPreFactura.A_PFactura[i].szCodProvincia  ,
                        stCliente.pCargos[iCont].szCodProvincia);
                strcpy (stPreFactura.A_PFactura[i].szCodCiudad     ,
                        stCliente.pCargos[iCont].szCodCiudad   );
                strcpy (stPreFactura.A_PFactura[i].szCodModulo     ,
                        stCliente.pCargos[iCont].szCodModulo   );

                stPreFactura.A_PFactura[i].dImpConcepto    =
                             stCliente.pCargos[iCont].dImpCargo            ;
                stPreFactura.A_PFactura[i].dImpFacturable  =
                             stCliente.pCargos[iCont].dImpCargo            ;
                             
                dImpConceptoAux = stPreFactura.A_PFactura[i].dImpFacturable;

                if (!bConversionMoneda(stCliente.lCodCliente                    ,
                                       stPreFactura.A_PFactura[i].szCodMoneda   ,
                                       stDatosGener.szCodMoneFact               ,
                                       stPreFactura.A_PFactura[i].szFecValor    ,
                                      &stPreFactura.A_PFactura[i].dImpFacturable))
                {
                     return FALSE; /* P-MIX-09003 4 */ 
                }
                
                if (stPreFactura.A_PFactura[i].dImpFacturable == 0)
                {
                    stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                }
                else
                {
                    if (dImpConceptoAux != stPreFactura.A_PFactura[i].dImpFacturable)
                    {
                        stPreFactura.A_PFactura[i].dImpMontoBase = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,0) / 
                                                                     fnCnvDouble(dImpConceptoAux, 0);
                    }
                    else
                    {
                    	stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                    }
                }
                                      
                stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,0);                                                                            
                stPreFactura.A_PFactura[i].iFlagImpues    = 0;
                stPreFactura.A_PFactura[i].lCodPlanCom    = stCliente.pCargos[iCont].lCodPlanCom  ;
                stPreFactura.A_PFactura[i].iCodPortador   = 0;
                stPreFactura.A_PFactura[i].iIndEstado     = EST_DTO     ;
                stPreFactura.A_PFactura[i].fPrcImpuesto   = ORA_NULL    ;
                stPreFactura.A_Ind[i].i_fPrcImpuesto      = ORA_NULL    ;
                stPreFactura.A_PFactura[i].lCodCiclFact   = stCiclo.lCodCiclFact;
                stPreFactura.A_Ind[i].i_lCodCiclFact      = (stCiclo.lCodCiclFact == ORA_NULL)?ORA_NULL:SQLOK;
                stPreFactura.A_PFactura[i].iIndFactur     = stCliente.pCargos[iCont].iIndFactur ;
                stPreFactura.A_PFactura[i].lNumAbonado    = stCliente.pCargos[iCont].lNumAbonado  ;
                stPreFactura.A_Ind[i].i_lNumAbonado       = (stCliente.pCargos [iCont].lNumAbonado==ORA_NULL)?-1:0;
                stPreFactura.A_PFactura[i].iCodCatImpos   = stCliente.iCodCatImpos                ;
                strcpy (stPreFactura.A_PFactura[i].szNumTerminal , stCliente.pCargos[iCont].szNumTerminal);
                stPreFactura.A_Ind[i].i_szNumTerminal     = (stCliente.pCargos[iCont].szNumTerminal [0] ==0)?-1:0;
                strcpy (stPreFactura.A_PFactura[i].szNumGuia , stCliente.pCargos [iCont].szNumGuia    );
                stPreFactura.A_Ind[i].i_szNumGuia         = (stCliente.pCargos[iCont].szNumGuia [0]==0)?-1:0;
                stPreFactura.A_PFactura[i].lCapCode       = stCliente.pCargos[iCont].lCapCode;
                stPreFactura.A_Ind[i].i_lCapCode          = (stCliente.pCargos[iCont].lCapCode == ORA_NULL)?-1:0  ;
                strcpy (stPreFactura.A_PFactura[i].szNumSerieMec , stCliente.pCargos [iCont].szNumSerieMec);
                stPreFactura.A_Ind[i].i_szNumSerieMec     = (stCliente.pCargos[iCont].szNumSerieMec [0]==0)?-1:0;
                strcpy (stPreFactura.A_PFactura[i].szNumSerieLe , (stCliente.pCargos[iCont].szNumSerie  [0] ==0)?"0":stCliente.pCargos [iCont].szNumSerie );
                stPreFactura.A_Ind[i].i_szNumSerieLe      = 0        ;
                stPreFactura.A_PFactura[i].lNumVenta      = stCliente.pCargos[iCont].lNumVenta      ;
                stPreFactura.A_Ind[i].i_lNumVenta         = (stCliente.pCargos [iCont].lNumVenta == ORA_NULL)?-1:0;
                stPreFactura.A_PFactura[i].lNumTransaccion= stCliente.pCargos[iCont].lNumTransaccion;
                stPreFactura.A_Ind[i].i_lNumTransaccion   = (stCliente.pCargos[iCont].lNumTransaccion == -1)?-1:0 ;
                stPreFactura.A_PFactura[i].iMesGarantia   = stCliente.pCargos[iCont].iMesGarantia   ;
                stPreFactura.A_Ind[i].i_iMesGarantia      = (stCliente.pCargos[iCont].iMesGarantia    == -1)?-1:0 ;
                stPreFactura.A_PFactura[i].iIndAlta       = 0        ;
                stPreFactura.A_PFactura[i].iIndSuperTel   = (stCliente.pCargos[iCont].iIndSuperTel    == -1)?0:stCliente.pCargos[iCont].iIndSuperTel;
                stPreFactura.A_PFactura[i].iNumPaquete    = stCliente.pCargos[iCont].iNumPaquete    ;
                stPreFactura.A_Ind[i].i_iNumPaquete       = (stPreFactura.A_PFactura[i].iNumPaquete == -1)?-1:0   ;
                stPreFactura.A_PFactura[i].iNumCuotas     = 0        ;
                stPreFactura.A_PFactura[i].iOrdCuota      = 0        ;
                stPreFactura.A_PFactura[i].bOptCargos     = TRUE     ;
                
                if (stCliente.iIndSuperTel < 1 &&
                    stPreFactura.A_PFactura[i].iIndSuperTel  == 1)
                    stCliente.iIndSuperTel = 1;

                if (iInd == 2)
                {
                	stPreFactura.A_PFactura[i].iCodConceRel =
                                  stCliente.pCargos[iCont].iCodConcepto   ;
                    stPreFactura.A_PFactura[i].lColumnaRel  =
                                  stCliente.pCargos[iCont].lColumna       ;
                    stPreFactura.A_PFactura[i].iCodConcepto =
                                  stCliente.pCargos[iCont].iCodConceptoDto;
                    if (!bFindConcepto(stPreFactura.A_PFactura[i].iCodConcepto,
                                       &stConcepto))
                    {
                    	iDError (szExeName,ERR021,vInsertarIncidencia,
                                 "pstConcepto");
                        return  FALSE          ;
                    }
                    strcpy (stPreFactura.A_PFactura[i].szDesConcepto ,
                            stConcepto.szDesConcepto)                     ;

                    stPreFactura.A_PFactura[i].iTipDto      =
                                  stCliente.pCargos[iCont].iTipDto        ;
                    stPreFactura.A_PFactura[i].dValDto      =
                                          stCliente.pCargos[iCont].dValDto;

                    stPreFactura.A_PFactura[i].dImpConcepto    =
                         (stCliente.pCargos[iCont].iTipDto == 0)?
                          stCliente.pCargos[iCont].dValDto:
                         (stPreFactura.A_PFactura[i].dImpConcepto   *
                          (double)stCliente.pCargos[iCont].dValDto/100)  ;

                    stPreFactura.A_PFactura[i].dImpFacturable  =
                                 stPreFactura.A_PFactura[i].dImpConcepto ;
                                 
                    dImpConceptoAux = stPreFactura.A_PFactura[i].dImpFacturable;

                    if(!bConversionMoneda(stCliente.lCodCliente                    ,
                                          stPreFactura.A_PFactura[i].szCodMoneda   ,
                                          stDatosGener.szCodMoneFact               ,
                                          stPreFactura.A_PFactura[i].szFecValor    ,
                                         &stPreFactura.A_PFactura[i].dImpFacturable))
                    {
                         return FALSE; /* P-MIX-09003 4 */
                    }  
                    
                    if (stPreFactura.A_PFactura[i].dImpFacturable == 0) /* P-MIX-09003 134206 */
                    {
                        stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                    }
                    else
                    {
                        if (dImpConceptoAux != stPreFactura.A_PFactura[i].dImpFacturable)
                        {
                            stPreFactura.A_PFactura[i].dImpMontoBase = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,0) / 
                                                                     fnCnvDouble(dImpConceptoAux, 0);
                        }
                        else
                        {
                    	    stPreFactura.A_PFactura[i].dImpMontoBase = 0;
                        }
                    } /* P-MIX-09003 134206 */
                                                                                                                                                                                                                                
                    stPreFactura.A_PFactura[i].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,0);
                                      
                    stPreFactura.A_PFactura[i].dImpMontoBase =stPreFactura.A_PFactura[i].dImpConcepto;

                    stPreFactura.A_PFactura[i].dImpFacturable  =
                                 stPreFactura.A_PFactura[i].dImpFacturable*-1;
                    stPreFactura.A_PFactura[i].dImpConcepto    =
                                 stPreFactura.A_PFactura[i].dImpConcepto  *-1;
                    stPreFactura.A_PFactura[i].lNumUnidades =
                                 stCliente.pCargos [iCont].lNumUnidades ;
                    stPreFactura.A_PFactura[i].iCodTipConce = DESCUENTO ;
                    stPreFactura.A_PFactura[i].iIndEstado   = EST_NORMAL;
                    stPreFactura.A_PFactura[i].iFlagDto     = 0         ;
                    stPreFactura.A_PFactura[i].dValDto      = 0         ;
                    stPreFactura.A_PFactura[i].iTipDto      = 0         ;

                    if (stProceso.iCodTipDocum == stDatosGener.iCodContado &&
                        stPreFactura.A_PFactura[i].lNumVenta  > 0)
                 	{
                    	if(strcmp (stConcepto.szCodTipDescu,TIPDESCU_ART) == 0)
                     	{
                        	if ((stVentaDto.pVtaDto =
                            	(VTADTO *)realloc ((VTADTO *)stVentaDto.pVtaDto,
                            	(stVentaDto.iNumReg+1)*sizeof (VTADTO)))
                            	== (VTADTO *)NULL)
                        	{
                            	iDError (szExeName,ERR021,vInsertarIncidencia,
                                	     "stVentaDto.pVtaDto");
                            	return FALSE                  ;
                        	}
                        	k = stVentaDto.iNumReg;
                        	memset (&stVentaDto.pVtaDto[k],0,sizeof(VTADTO));

                        	stVentaDto.pVtaDto[k].lNumVenta    =
                         		stCliente.pCargos[iCont].lNumVenta      ;
                        	stVentaDto.pVtaDto[k].lNumItem     =
                                stCliente.pCargos[iCont].lNumCargo      ;
                        	stVentaDto.pVtaDto[k].iCodProducto =
                                stCliente.pCargos[iCont].iCodProducto   ;
                        	stVentaDto.pVtaDto[k].iCodCtoDto   =
                                stCliente.pCargos[iCont].iCodConceptoDto;
                        	stVentaDto.pVtaDto[k].lNumUnidades =
                                stCliente.pCargos[iCont].lNumUnidades   ;
                        	stVentaDto.pVtaDto[k].iIndDto      =
                                stCliente.pCargos[iCont].iTipDto        ;
                        	stVentaDto.pVtaDto[k].dImpVenta    =
                        		fnCnvDouble (stCliente.pCargos[iCont].dImpCargo
                        		,USOFACT)									;
                        	stVentaDto.pVtaDto[k].dValDto      =
                        		fnCnvDouble (stCliente.pCargos[iCont].dValDto
                        		,USOFACT)									;

	                         stVentaDto.iNumReg++;
    	                 }

        			}/* fin if FACT_CONTADO ... */

            	}/* fin if i == 2 .. */
                else
                {
                	stPreFactura.A_PFactura[i].lNumUnidades  =
                                 stCliente.pCargos [iCont].lNumUnidades;
                    stPreFactura.A_PFactura[i].iCodConcepto  =
                                 stCliente.pCargos [iCont].iCodConcepto;
                    strcpy (stPreFactura.A_PFactura[i].szDesConcepto ,
                            stCliente.pCargos [iCont].szDesConcepto)   ;
             	}

                if (!bGetMaxColPreFa (stPreFactura.A_PFactura[i].iCodConcepto,
                                      &stPreFactura.A_PFactura[i].lColumna   ))
                	return FALSE;
                if (iInd == 1)
                {
                	stCliente.pCargos [iCont].lColumna      =
                    	stPreFactura.A_PFactura[i].lColumna  ;
                    stPreFactura.A_PFactura[i].iCodConcepto =
                        stCliente.pCargos[iCont].iCodConcepto;
                    stPreFactura.A_PFactura[i].iCodConceRel = 0       ;
                    stPreFactura.A_PFactura[i].lColumnaRel  = 0       ;
                    stPreFactura.A_PFactura[i].iCodTipConce = ARTICULO;
                    stPreFactura.A_PFactura[i].iIndEstado   = EST_DTO ;
                    stPreFactura.A_PFactura[i].iFlagDto     =
                    	(iRegInsert == 2)?1:0;
                    stPreFactura.A_PFactura[i].dValDto      =
                        stCliente.pCargos[iCont].dValDto  ;
                    stPreFactura.A_Ind[i].i_dValDto         =
                    	(stCliente.pCargos[iCont].dValDto == -1)?-1:0 ;
                    stPreFactura.A_PFactura[i].iTipDto      =
                        stCliente.pCargos[iCont].iTipDto  ;
                    stPreFactura.A_Ind[i].i_iTipDto         =
                    	(stCliente.pCargos[iCont].iTipDto == -1)?-1:0 ;
                    stPreFactura.A_PFactura[i].iIndCuota    =
                    	(stCliente.pCargos [iCont].iIndCuota == -1)?0:
                     	stCliente.pCargos[iCont].iIndCuota			  ;
                    strcpy (stPreFactura.A_PFactura[i].szCodCuota ,
                        stCliente.pCargos [iCont].szCodCuota)     ;
                 }
                 
                 if(bfnIncrementarIndicePreFactura()==FALSE)
                 {
                     vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                     vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
                     return FALSE;
                 }


           	}
			vDTrazasLog (szExeName,"\n\t\t=> Fin Cargo - iFlagFaCargo[%d]", LOG05,stCliente.pCargos [iCont].iFlagFaCargo);
           	
           	if (stCliente.pCargos [iCont].iFlagFaCargo)
           	{
	           	vDTrazasLog (szExeName,"\n\t\t=> bUpdateCargosOcacionales szRowid [%s]", LOG05,stCliente.pCargos[iCont].szRowid);
	           	if (!bUpdateCargosOcacionales (stCliente.pCargos[iCont].szRowid))
	            	return FALSE;
            }
            else	
	        {
	           	vDTrazasLog (szExeName,"\n\t\t=> bUpdateCargos szRowid [%s]", LOG05,stCliente.pCargos[iCont].szRowid);
	           	if (!bUpdateCargos (stCliente.pCargos[iCont].szRowid))
	            	return FALSE;
	        }

     	}/* fin if dImpConcepto >= 0.01 */

	}

	vDTrazasLog (szExeName,"\n\t\t=> Fin Cargo ", LOG05);
  	if (stProceso.iCodTipDocum == stDatosGener.iCodContado &&
      	stVentaDto.iNumReg >0)
  	{
    	if (!bfnInsertVentaDtos (&stVentaDto))
      	{
        	return FALSE;
      	}
  	}
	vDTrazasLog (szExeName,"\n\t\t=> Fin Cargo (Fin)", LOG05);
  	return TRUE;
}/****************************** Final bEMCargos *****************************/


/*****************************************************************************/
/*                           funcion : vfnFreeVentaDto                       */
/*****************************************************************************/
static void vfnFreeVentaDtos (VENTADTO *pVentaDto)
{

  	if (pVentaDto->pVtaDto != (VTADTO *)NULL)
  	{
    	free (pVentaDto->pVtaDto)          ;
      	pVentaDto->pVtaDto = (VTADTO *)NULL;
  	}
  	pVentaDto->iNumReg = 0;

  	if (pVentaDto != (VENTADTO *)NULL)
  	{
    	free (pVentaDto)            ;
      	pVentaDto = (VENTADTO *)NULL;
  	}
}/**************************** Final vfnFreeVentaDto *************************/

/*****************************************************************************/
/*                          funcion : bfnInsertVentaDtos                     */
/*****************************************************************************/
static BOOL bfnInsertVentaDtos (VENTADTO *pVentaDto)
{
  int  i      = 0    ;
  int  j      = 0    ;
  int  k      = 0    ;
  BOOL bError = FALSE;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long   lhNumVenta   [NREG];
  static long   lhNumItem    [NREG];
  static int    ihCodProducto[NREG];
  static double dhImpVenta   [NREG];
  static short  shIndDto     [NREG];
  static double dhValDto     [NREG];
  static long   lhNumUnidades[NREG]; /* Incorporado por PGonzaleg 4-03-2002 */
  static short  shIndAcepta  [NREG];
  static int    ihCodCtoDto  [NREG];
  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Insertando en VE_VENTADTO\n",LOG05);

  for (j=0;j<pVentaDto->iNumReg;j++)
  {
       vfnPrintVentaDtos (pVentaDto->pVtaDto[j],bError);
       if (k == NREG)
       {
           /* EXEC SQL FOR :k
                INSERT INTO VE_VENTADTOS
                       (NUM_VENTA   ,
                        NUM_ITEM    ,
                        COD_PRODUCTO,
                        IMP_VENTA   ,
                        IND_DTO     ,
                        VAL_DTO     ,
                        NUM_UNIDADES,
                        IND_ACEPTA  ,
                        COD_CTODTO  )
                 VALUES(:lhNumVenta     ,
                        :lhNumItem      ,
                        :ihCodProducto  ,
                        :dhImpVenta     ,
                        :shIndDto       ,
                        :dhValDto       ,
                        :lhNumUnidades  , /o Incorporado por PGonzaleg 4-03-2002 o/
                        :shIndAcepta    ,
                        :ihCodCtoDto); */ 

{
           struct sqlexd sqlstm;
           sqlstm.sqlvsn = 12;
           sqlstm.arrsiz = 29;
           sqlstm.sqladtp = &sqladt;
           sqlstm.sqltdsp = &sqltds;
           sqlstm.stmt = "insert into VE_VENTADTOS (NUM_VENTA,NUM_ITEM,COD_P\
RODUCTO,IMP_VENTA,IND_DTO,VAL_DTO,NUM_UNIDADES,IND_ACEPTA,COD_CTODTO) values (\
:b1,:b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9)";
           sqlstm.iters = (unsigned int  )k;
           sqlstm.offset = (unsigned int  )425;
           sqlstm.cud = sqlcud0;
           sqlstm.sqlest = (unsigned char  *)&sqlca;
           sqlstm.sqlety = (unsigned short)256;
           sqlstm.occurs = (unsigned int  )0;
           sqlstm.sqhstv[0] = (unsigned char  *)lhNumVenta;
           sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[0] = (         int  )sizeof(long);
           sqlstm.sqindv[0] = (         short *)0;
           sqlstm.sqinds[0] = (         int  )0;
           sqlstm.sqharm[0] = (unsigned long )0;
           sqlstm.sqharc[0] = (unsigned long  *)0;
           sqlstm.sqadto[0] = (unsigned short )0;
           sqlstm.sqtdso[0] = (unsigned short )0;
           sqlstm.sqhstv[1] = (unsigned char  *)lhNumItem;
           sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[1] = (         int  )sizeof(long);
           sqlstm.sqindv[1] = (         short *)0;
           sqlstm.sqinds[1] = (         int  )0;
           sqlstm.sqharm[1] = (unsigned long )0;
           sqlstm.sqharc[1] = (unsigned long  *)0;
           sqlstm.sqadto[1] = (unsigned short )0;
           sqlstm.sqtdso[1] = (unsigned short )0;
           sqlstm.sqhstv[2] = (unsigned char  *)ihCodProducto;
           sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[2] = (         int  )sizeof(int);
           sqlstm.sqindv[2] = (         short *)0;
           sqlstm.sqinds[2] = (         int  )0;
           sqlstm.sqharm[2] = (unsigned long )0;
           sqlstm.sqharc[2] = (unsigned long  *)0;
           sqlstm.sqadto[2] = (unsigned short )0;
           sqlstm.sqtdso[2] = (unsigned short )0;
           sqlstm.sqhstv[3] = (unsigned char  *)dhImpVenta;
           sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[3] = (         int  )sizeof(double);
           sqlstm.sqindv[3] = (         short *)0;
           sqlstm.sqinds[3] = (         int  )0;
           sqlstm.sqharm[3] = (unsigned long )0;
           sqlstm.sqharc[3] = (unsigned long  *)0;
           sqlstm.sqadto[3] = (unsigned short )0;
           sqlstm.sqtdso[3] = (unsigned short )0;
           sqlstm.sqhstv[4] = (unsigned char  *)shIndDto;
           sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
           sqlstm.sqhsts[4] = (         int  )sizeof(short);
           sqlstm.sqindv[4] = (         short *)0;
           sqlstm.sqinds[4] = (         int  )0;
           sqlstm.sqharm[4] = (unsigned long )0;
           sqlstm.sqharc[4] = (unsigned long  *)0;
           sqlstm.sqadto[4] = (unsigned short )0;
           sqlstm.sqtdso[4] = (unsigned short )0;
           sqlstm.sqhstv[5] = (unsigned char  *)dhValDto;
           sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
           sqlstm.sqhsts[5] = (         int  )sizeof(double);
           sqlstm.sqindv[5] = (         short *)0;
           sqlstm.sqinds[5] = (         int  )0;
           sqlstm.sqharm[5] = (unsigned long )0;
           sqlstm.sqharc[5] = (unsigned long  *)0;
           sqlstm.sqadto[5] = (unsigned short )0;
           sqlstm.sqtdso[5] = (unsigned short )0;
           sqlstm.sqhstv[6] = (unsigned char  *)lhNumUnidades;
           sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
           sqlstm.sqhsts[6] = (         int  )sizeof(long);
           sqlstm.sqindv[6] = (         short *)0;
           sqlstm.sqinds[6] = (         int  )0;
           sqlstm.sqharm[6] = (unsigned long )0;
           sqlstm.sqharc[6] = (unsigned long  *)0;
           sqlstm.sqadto[6] = (unsigned short )0;
           sqlstm.sqtdso[6] = (unsigned short )0;
           sqlstm.sqhstv[7] = (unsigned char  *)shIndAcepta;
           sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
           sqlstm.sqhsts[7] = (         int  )sizeof(short);
           sqlstm.sqindv[7] = (         short *)0;
           sqlstm.sqinds[7] = (         int  )0;
           sqlstm.sqharm[7] = (unsigned long )0;
           sqlstm.sqharc[7] = (unsigned long  *)0;
           sqlstm.sqadto[7] = (unsigned short )0;
           sqlstm.sqtdso[7] = (unsigned short )0;
           sqlstm.sqhstv[8] = (unsigned char  *)ihCodCtoDto;
           sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
           sqlstm.sqhsts[8] = (         int  )sizeof(int);
           sqlstm.sqindv[8] = (         short *)0;
           sqlstm.sqinds[8] = (         int  )0;
           sqlstm.sqharm[8] = (unsigned long )0;
           sqlstm.sqharc[8] = (unsigned long  *)0;
           sqlstm.sqadto[8] = (unsigned short )0;
           sqlstm.sqtdso[8] = (unsigned short )0;
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
               i       = (sqlca.sqlerrd[2] == SQLOK)?SQLOK:sqlca.sqlerrd[2]-1;

               bError = TRUE                                  ;
               iDError (szExeName,ERR000,vInsertarIncidencia,
                        "Insert->Ve_VentaDtos",szfnORAerror());
               vfnPrintVentaDtos(pVentaDto->pVtaDto[i],bError);
           }
           if (SQLCODE == SQLOK)
           {
               k = 0;
           }
        }
               lhNumVenta   [k] = pVentaDto->pVtaDto [j].lNumVenta   ;
               lhNumItem    [k] = pVentaDto->pVtaDto [j].lNumItem    ;
               ihCodProducto[k] = pVentaDto->pVtaDto [j].iCodProducto;
               dhImpVenta   [k] = pVentaDto->pVtaDto [j].dImpVenta   ;
               shIndDto     [k] = pVentaDto->pVtaDto [j].iIndDto     ;
               dhValDto     [k] = pVentaDto->pVtaDto [j].dValDto     ;
               lhNumUnidades[k] = pVentaDto->pVtaDto [j].lNumUnidades; /* Incorporado por PGonzaleg 4-03-2002 */
               shIndAcepta  [k] = pVentaDto->pVtaDto [j].iIndAcepta  ;
               ihCodCtoDto  [k] = pVentaDto->pVtaDto [j].iCodCtoDto  ;
               k++                                                   ;
  }
  if (k > 0)
  {
      /* EXEC SQL FOR :k
               INSERT INTO VE_VENTADTOS
                       (NUM_VENTA   ,
                        NUM_ITEM    ,
                        COD_PRODUCTO,
                        IMP_VENTA   ,
                        IND_DTO     ,
                        VAL_DTO     ,
                        NUM_UNIDADES,
                        IND_ACEPTA  ,
                        COD_CTODTO  )
                 VALUES(:lhNumVenta     ,
                        :lhNumItem      ,
                        :ihCodProducto  ,
                        :dhImpVenta     ,
                        :shIndDto       ,
                        :dhValDto       ,
                        :lhNumUnidades  , /o Incorporado por PGonzaleg 4-03-2002 o/
                        :shIndAcepta    ,
                        :ihCodCtoDto); */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 29;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "insert into VE_VENTADTOS (NUM_VENTA,NUM_ITEM,COD_PRODUC\
TO,IMP_VENTA,IND_DTO,VAL_DTO,NUM_UNIDADES,IND_ACEPTA,COD_CTODTO) values (:b1,:\
b2,:b3,:b4,:b5,:b6,:b7,:b8,:b9)";
      sqlstm.iters = (unsigned int  )k;
      sqlstm.offset = (unsigned int  )476;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)lhNumVenta;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )sizeof(long);
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqharc[0] = (unsigned long  *)0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)lhNumItem;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[1] = (         int  )sizeof(long);
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqharc[1] = (unsigned long  *)0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)ihCodProducto;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )sizeof(int);
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqharc[2] = (unsigned long  *)0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)dhImpVenta;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[3] = (         int  )sizeof(double);
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqharc[3] = (unsigned long  *)0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)shIndDto;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[4] = (         int  )sizeof(short);
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqharc[4] = (unsigned long  *)0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)dhValDto;
      sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
      sqlstm.sqhsts[5] = (         int  )sizeof(double);
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqharc[5] = (unsigned long  *)0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)lhNumUnidades;
      sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[6] = (         int  )sizeof(long);
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqharc[6] = (unsigned long  *)0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)shIndAcepta;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(short);
      sqlstm.sqhsts[7] = (         int  )sizeof(short);
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqharc[7] = (unsigned long  *)0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)ihCodCtoDto;
      sqlstm.sqhstl[8] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[8] = (         int  )sizeof(int);
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqharc[8] = (unsigned long  *)0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
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
         i       = (sqlca.sqlerrd[2] == SQLOK)?SQLOK:sqlca.sqlerrd[2]-1;

         bError = TRUE                                  ;
         iDError (szExeName,ERR000,vInsertarIncidencia,
                  "Insert->Ve_VentaDtos",szfnORAerror());
         vfnPrintVentaDtos(pVentaDto->pVtaDto[i],bError);
     }

  }
  vfnFreeVentaDtos (pVentaDto)        ;
  return (SQLCODE != SQLOK)?FALSE:TRUE;
}/****************************** Final bfnInsertVentaDtos ********************/

/*****************************************************************************/
/*                          funcion : vfnPrintVentaDtos                      */
/*****************************************************************************/
static void vfnPrintVentaDtos (VTADTO stVtaDto, BOOL bError)
{
  if (bError)
  {
      vDTrazasError(szExeName,"\n\t\t* Error al Insertar en Ve_VentaDto el Registro:"
      						  "\n\t\t Num.Venta   .....................[%ld]"
      						  "\n\t\t Num.Item    .....................[%ld]"
      						  "\n\t\t Cod.Producto.....................[%d] "
      						  "\n\t\t Imp.Venta   .....................[%f] "
      						  "\n\t\t Ind.Dto     .....................[%d] "
      						  "\n\t\t Val.Dto     .....................[%f] "
      						  "\n\t\t Ind.Acepta  .....................[%d] "
      						  "\n\t\t Cod.CtoDto  .....................[%d] "
      						  "\n\t\t lNumUnidades.....................[%d] "
                     		  ,LOG03,stVtaDto.lNumVenta
                      		  ,stVtaDto.lNumItem
                      		  ,stVtaDto.iCodProducto
                      		  ,stVtaDto.dImpVenta
                      		  ,stVtaDto.iIndDto
                      		  ,stVtaDto.dValDto
                      		  ,stVtaDto.iIndAcepta
                      		  ,stVtaDto.iCodCtoDto
                      		  ,stVtaDto.lNumUnidades);				/* Incorporado por PGonzaleg 4-03-2002 */
  }
  else
  {
      vDTrazasLog   (szExeName,"\n\t\t Num.Venta   .....................[%ld]"
							   "\n\t\t Num.Item    .....................[%ld]"
							   "\n\t\t Cod.Producto.....................[%d] "
							   "\n\t\t Imp.Venta   .....................[%f] "
							   "\n\t\t Ind.Dto     .....................[%d] "
							   "\n\t\t Val.Dto     .....................[%f] "
							   "\n\t\t Ind.Acepta  .....................[%d] "
							   "\n\t\t Cod.CtoDto  .....................[%d] "
							   "\n\t\t lNumUnidades.....................[%d] "
                     		   ,LOG05,stVtaDto.lNumVenta
                     		   ,stVtaDto.lNumItem
                     		   ,stVtaDto.iCodProducto
                     		   ,stVtaDto.dImpVenta
                     		   ,stVtaDto.iIndDto
                     		   ,stVtaDto.dValDto
                     		   ,stVtaDto.iIndAcepta
                     		   ,stVtaDto.iCodCtoDto
                     		   ,stVtaDto.lNumUnidades);				/* Incorporado por PGonzaleg 4-03-2002 */
  }
}/************************** Final vfnPrintVentaDtos *************************/
