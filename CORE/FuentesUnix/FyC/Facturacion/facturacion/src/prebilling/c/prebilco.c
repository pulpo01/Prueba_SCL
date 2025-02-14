
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
    "./pc/prebilco.pc"
};


static unsigned int sqlctx = 3462659;


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


/*****************************************************************************/
/* Fichero    :  prebilcon.pc                                                */ 
/* Descripcion:  Proceso de Prebilling de PVENTA||CONTADO                    */
/*****************************************************************************/

#define _PREBILCON_PC_
#include <prebilco.h>
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
/*                    funcion : bPreBillingClienteContado                    */ 
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
BOOL bPreBillingClienteContado (long         lNumProceso,  VENTAS       stVenta  ,
                                TRANSCONTADO stTransC   ,  int          iTipoFact)
{
   long  lNumAbonado ;
   short iCodProducto;
   int   iRegInsert = 0;

   vInitAnomProceso(&stAnomProceso);
   vInitEstructuras();
   strcpy(stAnomProceso.szDesProceso,"PreBilling Contado");

   vDTrazasLog (szExeName,
   "\n\t\t*** FACTURA CONTADO ***"
   "\n\t\t=>  CLIENTE: [%ld]   \n",LOG03,stCliente.lCodCliente);
   
   vDTrazasError (szExeName,
   "\n\t\t*** FACTURA CONTADO ***"
   "\n\t\t=>  CLIENTE: [%ld]   \n",LOG03,stCliente.lCodCliente);

   vInitEstructurasCargos ();
   lNumAbonado = -1;
   iCodProducto= -1;
   if(!bIFCargos (stVenta,stTransC,lNumAbonado,iCodProducto,iTipoFact))
   {   vDTrazasLog (szExeName,"\tCliente %ld sin procesar",LOG01, stCliente.lCodCliente);
       vFreeCargos (); 
       return FALSE ;   }
       
   /**************************************************************************/
   /* Si hay dos modalidades en la Venta (Contado y Credito) introducimos un */
   /* proceso por modalidad, esto lo marca el campo stCliente.iModVenta = 2  */
   /* que se rellena en bIFCargos, donde se recupera un numero de proceso de */
   /* la secuencia (fa_seq_numpro) y se asocia a cada carga el numero de pro-*/
   /* ceso al que pertenece.                                                 */
   /**************************************************************************/
   if (!bGenProcesoII ()) 
   {   vDTrazasLog (szExeName,"\n\t*** Error GenProcesoII ***\n"
                    "\t=> Cliente [%ld] sin procesar",LOG01, stCliente.lCodCliente);
       vFreeCargos();
       return FALSE;   }
      
   if(!bEMCargos ()) 
   {   vDTrazasLog (szExeName,"\tCliente %ld sin procesar", LOG01,stCliente.lCodCliente);
       vFreeCargos ();
       return FALSE ;   }

   /* Calculo de Impuestos             */
   if (!bImptosIvaClienteGeneral (iTipoFact))
   {   vDTrazasLog(szExeName,"\nProceso Impuestos incompleto.\n",LOG01);
       vFreeCargos ();
       return FALSE  ;   }
       
   if (!bInsertPreFactura ()) return FALSE;

   vFreeCargos ();

   vDTrazasLog (szExeName,"\n\t*** Proceso CONTADO OK ***\n",LOG03);

   return TRUE;
}

/* -------------------------------------------------------------------------- */
/*   bGetCodMunicipio (char*)                                                 */
/*      Valores Retorno: FALSE - Error                                        */
/*                       TRUE  - Ningun Error                                 */
/* -------------------------------------------------------------------------- */
BOOL bGetCodMunicipio (long lCodCliente,char* szCodMunicipio)
{
   long lCodDireccion;

   if (!bFindDirecCli (lCodCliente, &lCodDireccion))
   {  vDTrazasLog (szExeName,"No encontro Cod.Direccion para el"\
                    " Cliente ['%ld']",LOG01,lCodCliente);
       return FALSE;
   }
   
   if (!bFindDirecciones (lCodDireccion, szCodMunicipio))
   {    vDTrazasLog (szExeName,"No encontro Cod.Municipio para el"\
                     " Cod.Direccion ['%ld'] (Ge_Direcciones)",LOG01, lCodDireccion);
        return FALSE;   }
   
   return TRUE; 
}


/*****************************************************************************/
/*                       funcion : bFindDirecCli                             */
/* -Funcion que busqueda en memoria (DIRECCLI* pstDirecCli) un reg. a partir */
/*  del CodCliente.                                                          */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bFindDirecCli (long lCodCliente,long* lCodDireccli)
{
  DIRECCLI stkey;
  DIRECCLI *pDir = (DIRECCLI *)NULL;
  stkey.lCodCliente = lCodCliente;

  if ((pDir = (DIRECCLI *)bsearch (&stkey,pstDirecCli,NUM_DIRECCLI,
               sizeof (DIRECCLI),iCmpDirecCli))==(DIRECCLI *)NULL)
  {    iDError (szExeName,ERR021,vInsertarIncidencia,"pstDirecCli (Ga_Direccli)");
       return FALSE;  }
  *lCodDireccli = pDir->lCodDireccion;
  return TRUE;
}


/*****************************************************************************/
/*                         funcion : bFindDirecciones                        */
/* -Funcion que recupera en memoria (DIRECCIONES* pstDirecciones) un reg. a  */
/*  partir del CodDireccion.                                                 */
/* -Valores de Retorno : Error->FALSE, !Error->TRUE                          */
/*****************************************************************************/
BOOL bFindDirecciones (long lCodDireccion, char* szCodMunicipio)
{
  DIRECCIONES stkey;
  DIRECCIONES *pDir = (DIRECCIONES *)NULL;
  if ((pDir = (DIRECCIONES *)bsearch(&stkey,pstDirecciones,NUM_DIRECCIONES,
               sizeof(DIRECCIONES),iCmpDirecciones))==(DIRECCIONES *)NULL)
  {    iDError (szExeName,ERR021,vInsertarIncidencia, "pstDirecciones(Ge_Direcciones");
       return FALSE;  }

  /* provisional deberia ir CodMunicipio envez de CodCiudad */
  strcpy (szCodMunicipio, pDir->szCodCiudad);
  return TRUE;
}


/* -------------------------------------------------------------------------- */
/*   vFreeCargos (void)                                                       */
/* -------------------------------------------------------------------------- */
void vFreeCargos (void)
{
  if (stCliente.pCargos != (CARGOS*)NULL) 
  {   free (stCliente.pCargos)         ;
      stCliente.pCargos = (CARGOS*)NULL;  }
  stCliente.iNumCargos = 0;
}

/* ------------------------------------------------------------------------- */
/*   vInitEstructurasCargos (void)                                           */
/* ------------------------------------------------------------------------- */
void vInitEstructurasCargos (void)
{  stCliente.pCargos      = (CARGOS*)NULL;
   stCliente.iNumCargos   = 0;
   stEstTotCar.iNumClientes   = 0;
   stEstTotCar.iRegProcesados = 0;
   stEstTotCar.iRegCorrectos  = 0;
   stEstTotCar.iRegAnomalos   = 0;
   stEstTotCar.dImpProcesados = 0;
   stEstTotCar.dImpCorrectos  = 0;
   stEstTotCar.dImpAnomalos   = 0;
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

