
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
    "./pc/precuo.pc"
};


static unsigned int sqlctx = 865795;


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
   unsigned char  *sqhstv[4];
   unsigned long  sqhstl[4];
            int   sqhsts[4];
            short *sqindv[4];
            int   sqinds[4];
   unsigned long  sqharm[4];
   unsigned long  *sqharc[4];
   unsigned short  sqadto[4];
   unsigned short  sqtdso[4];
} sqlstm = {12,4};

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
5,0,0,1,97,0,5,668,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
28,0,0,2,103,0,5,696,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
51,0,0,3,118,0,5,745,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
74,0,0,4,151,0,5,780,0,0,4,4,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,
105,0,0,5,103,0,5,811,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
};


/*****************************************************************************/
/* Fichero    : precuota.pc                                                  */
/* Descripcion: funciones para el Interface de Facturacion de Cuotas         */
/* Autor      : Javier Garcia Paredes                                        */
/* Fecha      : 05-04-1997                                                   */
/*****************************************************************************/

#define _PRECUOTA_PC_

#include <precuo.h>

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
/*                            funcion : bIFPagare                            */
/* -Funcion que carga los Pagare de un Cliente o un Abonado a la estructura  */
/*  de clientes stCliente.                                                   */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bIFPagares (long lCodCliente, 
                 long lNumAbonado,
                 int  iIndFactur ,
                 int  iTipoFact)
{
 int  iCab          = 0    ;
 int  iNCuotas      = 0    ;
 int  iTotNumCuotas = 0    ;
 int  iInd1         = 0    ;
 int  iInd2         = 0    ;
 BOOL bAddReg       = FALSE;


 strncpy (stAnomProceso.szDesProceso,"Carga Pagare",
          strlen(stAnomProceso.szDesProceso)); 

 vDTrazasLog (szExeName,"\n\t\t* Carga Pagare"
                        "\n\t\t=> Cod.Cliente [%ld]"
                        "\n\t\t=> Num.Abonado [%ld]",
                        LOG03,lCodCliente,lNumAbonado);
 if(lNumAbonado == ORA_NULL)
 {
    /* Pagare de Cliente */
   for(iInd1=0;iInd1<NUM_CABCUOTAS;iInd1++)
   {
       if (pstCabCuotas[iInd1].lCodCliente == lCodCliente &&
           pstCabCuotas[iInd1].lNumPagare  >  0           &&
           pstCabCuotas[iInd1].iIndPagada  == 0           )
       {
           iCab = stCliente.iNumCabCuotas;

           if ((stCliente.pCabCuotas =
               (CABCUOTAS *)realloc((CABCUOTAS *)stCliente.pCabCuotas,
               sizeof(CABCUOTAS)*(iCab+1)))==(CABCUOTAS *)NULL)
           {
               iDError (szExeName,ERR005,vInsertarIncidencia,
                        "stCliente.pCabCuotas");
               return FALSE;
           }
           memset (&stCliente.pCabCuotas[iCab],0,sizeof(CABCUOTAS));
           memcpy (&stCliente.pCabCuotas[iCab],&pstCabCuotas[iInd1],
                   sizeof(CABCUOTAS));

           for(iInd2=0;iInd2<NUM_CUOTAS;iInd2++)
           {
               if (iTipoFact == FACT_CICLO)
               {
                   if (pstCuotas   [iInd2].lSeqCuotas == 
                       pstCabCuotas[iInd1].lSeqCuotas              &&
                       pstCuotas   [iInd2].iIndFacturado      == 0 &&
                       strcmp (stCiclo.szFecDesdeOCargos,
                               pstCuotas[iInd2].szFecEmision) <= 0 &&
                       strcmp (stCiclo.szFecHastaOCargos,
                               pstCuotas[iInd2].szFecEmision) >= 0)
                       bAddReg = TRUE ;
                   else
                       bAddReg = FALSE;
               }
               else if (iTipoFact == FACT_BAJA)
               {
                   if (pstCuotas    [iInd2].lSeqCuotas    ==
                       pstCabCuotas [iInd1].lSeqCuotas    &&
                       pstCuotas    [iInd2].iIndFacturado ==0)
                       bAddReg = TRUE ;
                   else
                       bAddReg = FALSE;
               }
               if(bAddReg)
               {
                 iNCuotas = stCliente.pCabCuotas[iCab].iNCuotas;

                 if ((stCliente.pCabCuotas[iCab].pCuotas = 
                 (CUOTAS *)realloc((CUOTAS *)stCliente.pCabCuotas[iCab].pCuotas,
                          sizeof(CUOTAS)*(iNCuotas+1)))==(CUOTAS *)NULL)
                 {
                       iDError(szExeName,ERR005,vInsertarIncidencia,
                               "stCliente.pCabCuotas[%d].pCuotas",
                               iNCuotas);
                          return FALSE;
                  }
                  memset (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],0,
                          sizeof(CUOTAS))                   ;
                  memcpy (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],
                          &pstCuotas [iInd2],sizeof(CUOTAS));

                  stCliente.pCabCuotas [iCab].pCuotas [iNCuotas].iIndFactur =
                                                                 iIndFactur ;

                  if (!bValidacionCuota (&stCliente.pCabCuotas[iCab],
                                &stCliente.pCabCuotas[iCab].pCuotas[iNCuotas]))
                       return FALSE;
                  if ( (pstCabCuotas[iInd1].lSeqCuotas    ==
                        pstCuotas   [iInd2].lSeqCuotas          &&
                        pstCabCuotas[iInd1].iNumCuotas    ==
                        pstCuotas   [iInd2].iOrdCuota           &&
                        pstCabCuotas[iInd1].iIndPagada    == 0  &&
                        pstCuotas   [iInd2].iIndFacturado == 0) ||
                        iTipoFact == FACT_BAJA )
                  {
                        pstCabCuotas [iInd1].iIndPagada = 1;

                        if (!bUpdateCabCuotas (pstCabCuotas[iInd1].szRowid))
                             return FALSE;
                        if (!bUpdateIndCuotasInfa(lCodCliente,lNumAbonado,
                                             pstCabCuotas[iInd1].iCodProducto))
                             return FALSE;
                   }
                   pstCuotas [iInd2].iIndFacturado = 1;
                   if (!bUpdateCuotas (pstCuotas[iInd2].szRowid))
                        return FALSE;

                   iTotNumCuotas++                      ;
                   stCliente.pCabCuotas[iCab].iNCuotas++;
       
                 }/* fin AddReg */ 

           }/* fin for iInd2 ... */

           stCliente.iNumCabCuotas++;

       }/* fin if CabCuotas ... */

    }/* fin for iInd1 ... */
    if (!bUpdateIndPagare (lCodCliente))
         return FALSE;

  }/* fin Pagare de Cliente */
  else
  {
    for(iInd1=0;iInd1<NUM_CABCUOTAS;iInd1++)
    {
        if (pstCabCuotas[iInd1].lCodCliente == lCodCliente &&
            pstCabCuotas[iInd1].lNumAbonado == lNumAbonado &&
            pstCabCuotas[iInd1].lNumPagare  >  0           &&
            pstCabCuotas[iInd1].iIndPagada  == 0           )
        {
            iCab = stCliente.iNumCabCuotas;

            if ((stCliente.pCabCuotas =
                (CABCUOTAS *)realloc((CABCUOTAS *)stCliente.pCabCuotas,
                 sizeof(CABCUOTAS)*(iCab+1)))==(CABCUOTAS *)NULL)
            {
                 iDError (szExeName,ERR005,vInsertarIncidencia,
                          "stCliente.pCabCuotas");
                 return FALSE;
            }
            memset (&stCliente.pCabCuotas[iCab],0,sizeof(CABCUOTAS));
            memcpy (&stCliente.pCabCuotas[iCab],&pstCabCuotas[iInd1],
                    sizeof (CABCUOTAS));

            for(iInd2=0;iInd2<NUM_CUOTAS;iInd2++)
            {
                if (iTipoFact == FACT_CICLO)
                {
                    if (pstCuotas   [iInd2].lSeqCuotas ==
                        pstCabCuotas[iInd1].lSeqCuotas              &&
                        pstCuotas   [iInd2].iIndFacturado      == 0 &&
                        strcmp (stCiclo.szFecDesdeOCargos,
                                pstCuotas[iInd2].szFecEmision) <= 0 &&
                        strcmp (stCiclo.szFecHastaOCargos,
                                pstCuotas[iInd2].szFecEmision) >= 0)
                        bAddReg = TRUE ;
                    else
                        bAddReg = FALSE;
                 }
                 else if (iTipoFact == FACT_BAJA)
                 {
                     if (pstCuotas   [iInd2].lSeqCuotas ==
                         pstCabCuotas[iInd1].lSeqCuotas              &&
                         pstCuotas   [iInd2].iIndFacturado == 0 )
                         bAddReg = TRUE ;
                     else
                         bAddReg = FALSE; 
                 }
                 if(bAddReg)
                 {
                    iNCuotas = stCliente.pCabCuotas[iCab].iNCuotas;
 
                    if ((stCliente.pCabCuotas[iCab].pCuotas = (CUOTAS *)
                        realloc ((CUOTAS *)stCliente.pCabCuotas[iCab].pCuotas,
                        sizeof(CUOTAS)*(iNCuotas+1)))==(CUOTAS *)NULL)
                    {
                        iDError(szExeName,ERR005,vInsertarIncidencia,
                                "stCliente.pCabCuotas[%d].pCuotas",
                                iNCuotas);
                        return  FALSE    ;
                    }
                    memset (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],0,
                            sizeof(CUOTAS))                   ;
                    memcpy (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],
                            &pstCuotas [iInd2],sizeof(CUOTAS)); 

                    if(!bValidacionCuota (&stCliente.pCabCuotas[iCab],
                              &stCliente.pCabCuotas[iCab].pCuotas[iNCuotas]))
                        return FALSE;
                    if ( (pstCabCuotas[iInd1].lSeqCuotas    ==
                          pstCuotas   [iInd2].lSeqCuotas          &&
                          pstCabCuotas[iInd1].iNumCuotas    ==
                          pstCuotas   [iInd2].iOrdCuota           &&
                          pstCabCuotas[iInd1].iIndPagada    == 0  &&
                          pstCuotas   [iInd2].iIndFacturado == 0) ||
                          iTipoFact == FACT_BAJA )
                     {
                        pstCabCuotas [iInd1].iIndPagada = 1;

                        if(!bUpdateCabCuotas (pstCabCuotas[iInd1].szRowid))
                            return FALSE;
                        if (!bUpdateIndCuotasInfa(lCodCliente,
                                lNumAbonado,pstCabCuotas[iInd1].iCodProducto))
                             return FALSE;
                        if(!bUpdateEquipaBoser(pstCabCuotas[iInd1].lNumAbonado))
                            return FALSE;
                      }
                      pstCuotas [iInd2].iIndFacturado = 1;

                      if (!bUpdateCuotas (pstCuotas[iInd2].szRowid))
                           return FALSE;

                      stCliente.pCabCuotas[iCab].iNCuotas++;
                      iTotNumCuotas++                      ;

                 }/* fin AddReg */

               }/* fin for iInd2 ... */

               stCliente.iNumCabCuotas++;

           }/* fin if CabCuotas ... */

      }/* fin for iInd1 ... */
  }
  vDTrazasLog (szExeName,"\n\t\t* Numero de Cabeceras de Cuotas Cargadas [%d]"
                         "\n\t\t* Numero de Cuotas Cargadas              [%d]",
                         LOG03,stCliente.iNumCabCuotas,iTotNumCuotas);
  return TRUE;
}/*************************** Final bIFPagare ********************************/

/*****************************************************************************/
/*                           funcion : bIFCuotas                             */
/* -Funcion que Carga las Cuotas de un Cliente y Abonado en la estructura ge-*/
/*  neral de Cliente (stCliente).                                            */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bIFCuotas (long lCodCliente,
                long lNumAbonado,
                int  iIndFactur ,
                int  iTipoFact)
{
 int  iCab          = 0    ;
 int  iNCuotas      = 0    ;
 int  iTotNumCuotas = 0    ;
 int  iInd1         = 0    ;/* iIndice Registros Fa_CabCuotas */
 int  iInd2         = 0    ;/* iIndice Registros Fa_Cuotas    */
 BOOL bAddReg       = FALSE;

 strncpy (stAnomProceso.szDesProceso,"Carga Cuotas",
          strlen(stAnomProceso.szDesProceso))   ;

 vDTrazasLog (szExeName,"\n\t\t* Carga CUOTAS\n"
                        "\t\t=> Cliente   [%ld]\n"
                        "\t\t=> Abonado   [%ld]\n",LOG04,
                        lCodCliente,lNumAbonado);

 for(iInd1=0;iInd1<NUM_CABCUOTAS;iInd1++)
 {
   if (pstCabCuotas[iInd1].lCodCliente == lCodCliente &&
       pstCabCuotas[iInd1].lNumAbonado == lNumAbonado &&
       pstCabCuotas[iInd1].lNumPagare  <= 0           && 
       pstCabCuotas[iInd1].iIndPagada  == 0)
   {
       iCab = stCliente.iNumCabCuotas;

       if ((stCliente.pCabCuotas =
           (CABCUOTAS *)realloc((CABCUOTAS *)stCliente.pCabCuotas,
           sizeof(CABCUOTAS)*(iCab+1)))==(CABCUOTAS *)NULL)
       {
           iDError (szExeName,ERR005,vInsertarIncidencia,
                    "stCliente.pCabCuotas");
           return FALSE;
       }
       memset (&stCliente.pCabCuotas[iCab],0,sizeof(CABCUOTAS));
       memcpy (&stCliente.pCabCuotas[iCab],&pstCabCuotas[iInd1],
               sizeof(CABCUOTAS));

       for(iInd2=0;iInd2<NUM_CUOTAS;iInd2++)
       {
          if(iTipoFact == FACT_CICLO)
          {
             if(pstCuotas   [iInd2].lSeqCuotas == 
                pstCabCuotas[iInd1].lSeqCuotas             &&
                pstCuotas   [iInd2].iIndFacturado     == 0 &&
                strcmp (stCiclo.szFecDesdeOCargos,
                        pstCuotas[iInd2].szFecEmision)<= 0 &&
                strcmp (stCiclo.szFecHastaOCargos,
                        pstCuotas[iInd2].szFecEmision)>= 0)
                bAddReg = TRUE ;
             else
                bAddReg = FALSE;
         }
         else if(iTipoFact == FACT_BAJA)
         {
            if (pstCuotas   [iInd2].lSeqCuotas == 
                pstCabCuotas[iInd1].lSeqCuotas        &&
                pstCuotas   [iInd2].iIndFacturado == 0  )
                bAddReg = TRUE ;
            else
                bAddReg = FALSE; 
         }
         if(bAddReg)
         {
            iNCuotas = stCliente.pCabCuotas[iCab].iNCuotas;

            if ((stCliente.pCabCuotas[iCab].pCuotas =
                (CUOTAS *)realloc((CUOTAS *)stCliente.pCabCuotas[iCab].pCuotas,
                sizeof(CUOTAS)*(iNCuotas+1)))==(CUOTAS *)NULL)
            {
                iDError (szExeName,ERR005,vInsertarIncidencia,
                         "stCliente.pCabCuotas.pCuotas");
                return  FALSE                           ;
            }
            memset (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],0,
                    sizeof(CUOTAS))                     ;
            memcpy (&stCliente.pCabCuotas[iCab].pCuotas[iNCuotas],
                    &pstCuotas[iInd2],sizeof (CUOTAS))  ;

            stCliente.pCabCuotas[iCab].pCuotas[iNCuotas].iIndFactur=iIndFactur;

            if (!bValidacionCuota(&stCliente.pCabCuotas[iCab],
                             &stCliente.pCabCuotas[iCab].pCuotas[iNCuotas]))
                 return FALSE;
            if ((pstCabCuotas[iInd1].lSeqCuotas    ==
                 pstCuotas   [iInd2].lSeqCuotas          &&
                 pstCabCuotas[iInd1].iNumCuotas    ==
                 pstCuotas   [iInd2].iOrdCuota           &&
                 pstCabCuotas[iInd1].iIndPagada    == 0  &&
                 pstCuotas   [iInd2].iIndFacturado == 0 )||
                 iTipoFact == FACT_BAJA )
            {

                 if (!bUpdateCabCuotas (pstCabCuotas[iInd1].szRowid))
                      return FALSE;
                 if (!bUpdateIndCuotasInfa(lCodCliente,
                                           lNumAbonado,
                                           pstCabCuotas[iInd1].iCodProducto))
                      return FALSE;
                 pstCabCuotas [iInd1].iIndPagada = 1;

            }

            if (!bUpdateCuotas (pstCuotas[iInd2].szRowid))
                 return FALSE;

            pstCuotas [iInd2].iIndFacturado = 1    ;

            stCliente.pCabCuotas[iCab].iNCuotas++; 
            iTotNumCuotas++                      ;
       }/* fin AddReg */

     }/* fin for iInd2 ... */

     stCliente.iNumCabCuotas++;

   }/* fin if CabCuotas ... */

 }/* fin for iInd1 ... */

 vDTrazasLog (szExeName,"\n\t\t* Numero de Cabeceras de Cuotas Cargadas [%d]"
                        "\n\t\t* Numero de Cuotas                       [%d]",
                        LOG03,stCliente.iNumCabCuotas,iTotNumCuotas);
                       
 return TRUE;
}/*************************** Final bIFCuotas ********************************/


/*****************************************************************************/
/*                           funcion bEMCuotas                               */
/* -Funcion que introduce en Fa_PreFactura las Pagares (de un Cliente o un A-*/
/*  bonado) y las Cuotas de un Cliente.                                      */ 
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bEMCuotas (void)
{
 int  iInd1  = 0    ;
 int  iInd2  = 0    ;
 int  i      = 0    ;
 BOOL bError = FALSE;
 double dImpConceptoAux;

 CABCUOTAS *pTmpCab   = (CABCUOTAS *)NULL;
 CUOTAS    *pTmpCuotas= (CUOTAS    *)NULL;

 vDTrazasLog (szExeName,"\n\t\t* Paso a PreFactura de Cuotas y Pagares"
                        "\n\t\t=>Cliente        [%ld]"
                        "\n\t\t=>Num.Cabeceras  [%d] ",LOG04,
                        stCliente.lCodCliente,stCliente.iNumCabCuotas);

 
 if (pTmpCab != (CABCUOTAS *)NULL)
 {
     free (pTmpCab)             ;
     pTmpCab = (CABCUOTAS *)NULL;
 }
 pTmpCab = (CABCUOTAS *)stCliente.pCabCuotas;

 for (iInd1=0;iInd1<stCliente.iNumCabCuotas;iInd1++)
 {
      for (iInd2=0;iInd2<pTmpCab[iInd1].iNCuotas;iInd2++)
      {
           if (pTmpCab[iInd1].lNumAbonado != ORA_NULL)
               vDTrazasLog (szExeName,"\t\t=>Num.Abonado [%ld]\n",LOG04,
                            pTmpCab[iInd1].lNumAbonado);
           if (pTmpCuotas != (CUOTAS *)NULL)
           {
               free (pTmpCuotas)          ;
               pTmpCuotas = (CUOTAS *)NULL;
           }
           pTmpCuotas = (CUOTAS *)pTmpCab[iInd1].pCuotas;
           if (pTmpCuotas[iInd2].dImpCuota >= 0.01)
           {
               i = stPreFactura.iNumRegistros;
               
               /*if (stPreFactura.iNumRegistros >= MAX_CONCFACTUR)
               {
                   iDError (szExeName,ERR035,vInsertarIncidencia);
                   return FALSE;
               }*/

               stPreFactura.A_PFactura[i].bOptCuotas   = TRUE                 ;
               stPreFactura.A_PFactura[i].lNumProceso  = stStatus.IdPro       ;
               stPreFactura.A_PFactura[i].lCodCliente  = stCliente.lCodCliente;
               stPreFactura.A_PFactura[i].iCodConcepto = 
                                                   pTmpCab[iInd1].iCodConcepto;
               strcpy (stPreFactura.A_PFactura[i].szDesConcepto,
                       pTmpCab[iInd1].szDesConcepto)                          ;

               if (!bGetMaxColPreFa (stPreFactura.A_PFactura[i].iCodConcepto,
                                     &stPreFactura.A_PFactura[i].lColumna))
                    return FALSE;
               stPreFactura.A_PFactura[i].lSeqCuotas   =
                                                   pTmpCab[iInd1].lSeqCuotas  ;
               stPreFactura.A_PFactura[i].iCodProducto = 
                                                   pTmpCab[iInd1].iCodProducto;
               strcpy (stPreFactura.A_PFactura[i].szCodMoneda     ,
                       pTmpCab[iInd1].szCodMoneda)    ;
               strcpy (stPreFactura.A_PFactura[i].szFecValor      ,
                       pTmpCuotas[iInd2].szFecEmision);
               strcpy (stPreFactura.A_PFactura[i].szFecEfectividad,
                       szSysDate)                     ;

               stPreFactura.A_PFactura[i].dImpConcepto   =
                                       pTmpCuotas [iInd2].dImpCuota;
               stPreFactura.A_PFactura[i].dImpFacturable =
                                       pTmpCuotas [iInd2].dImpCuota;
                                       
               dImpConceptoAux = stPreFactura.A_PFactura[i].dImpFacturable;

               if (!bConversionMoneda (stCliente.lCodCliente                    ,
                                       stPreFactura.A_PFactura[i].szCodMoneda   ,
                                       stDatosGener.szCodMoneFact               ,
                                       stCiclo.szFecEmision                     ,
                                      &stPreFactura.A_PFactura[i].dImpFacturable))
                    return FALSE; /* P-MIX-09003 4 */

               stPreFactura.A_PFactura[i].dImpFacturable =
                         fnCnvDouble( stPreFactura.A_PFactura[i].dImpFacturable,
                                      0);

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
               

               strcpy (stPreFactura.A_PFactura[i].szCodRegion   ,
                       stCliente.szCodRegion   )  ;
               strcpy (stPreFactura.A_PFactura[i].szCodProvincia,
                       stCliente.szCodProvincia)  ;
               strcpy (stPreFactura.A_PFactura[i].szCodCiudad   ,
                       stCliente.szCodCiudad   )  ;
               strcpy (stPreFactura.A_PFactura[i].szCodModulo   ,
                       pTmpCab[iInd1].szCodModulo);

               stPreFactura.A_PFactura[i].lCodPlanCom = stCliente.lCodPlanCom ;
               stPreFactura.A_PFactura[i].lNumUnidades= 1                     ;
               stPreFactura.A_PFactura[i].iIndFactur  =
                       pTmpCab[iInd1].pCuotas [iInd2].iIndFactur              ;
               stPreFactura.A_PFactura[i].iCodCatImpos= stCliente.iCodCatImpos;
               stPreFactura.A_PFactura[i].iCodTipConce= ARTICULO              ; 
               stPreFactura.A_PFactura[i].iIndEstado  = EST_NORMAL            ; 
               stPreFactura.A_PFactura[i].lCodCiclFact= stCiclo.lCodCiclFact  ; 
               stPreFactura.A_PFactura[i].lColumnaRel = 0                     ; 
               stPreFactura.A_PFactura[i].iCodConceRel= 0                     ; 
               stPreFactura.A_PFactura[i].lNumAbonado = 
                                                    pTmpCab[iInd1].lNumAbonado;

               stPreFactura.A_PFactura[i].szNumTerminal[0] = 0;
               stPreFactura.A_PFactura[i].szNumSerieMec[0] = 0;
               stPreFactura.A_PFactura[i].szNumSerieLe [0] = 0;

               stPreFactura.A_PFactura[i].lCapCode        = ORA_NULL;
               stPreFactura.A_PFactura[i].iFlagImpues     = 0       ;
               stPreFactura.A_PFactura[i].iFlagDto        = 0       ;
               stPreFactura.A_PFactura[i].fPrcImpuesto    = 0.0     ;
               stPreFactura.A_PFactura[i].dValDto         = 0.0     ;
               stPreFactura.A_PFactura[i].iTipDto         = 0       ;
               stPreFactura.A_PFactura[i].lNumVenta       = 0       ;
               stPreFactura.A_PFactura[i].lNumTransaccion = 0       ;
               stPreFactura.A_PFactura[i].iMesGarantia    = 0       ;
               stPreFactura.A_PFactura[i].iIndAlta        = 0       ;
               stPreFactura.A_PFactura[i].iIndSuperTel    = 0       ;
               stPreFactura.A_PFactura[i].iNumPaquete     = 0       ;
               stPreFactura.A_PFactura[i].iIndCuota       = 0       ;
               stPreFactura.A_PFactura[i].iNumCuotas      = 0       ;
               stPreFactura.A_PFactura[i].iOrdCuota       = 0       ;

               vPrintRegInsert (i,"Cuotas",bError);
               i++                                ;
                if(bfnIncrementarIndicePreFactura()==FALSE) 
		{
		    vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
		    vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
		    return FALSE;
		}


           }/* fin dImpCuota >= 0.01 ... */

      }/* fin for iInd2 ... */

 }/* fin for iInd1 ... */

 
 return TRUE;
}/************************** Final bEMCuotas *********************************/

/*****************************************************************************/
/*                           funcion : bValidacionCuota                      */
/* -Funcion que valida los Conceptos de Pagare y de Cuota                    */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bValidacionCuota (CABCUOTAS *pCabCuota,CUOTAS *pCuota)
{
   int iRes = 0;
   CONCEPTO stConcepto;

   memset (&stConcepto,0,sizeof(CONCEPTO));

   vDTrazasLog (szExeName,"\n\t\t* Validacion de Cuotas\n",LOG05);

   if (!bFindConcepto (pCabCuota->iCodConcepto,&stConcepto))
   {
        iDError (szExeName,ERR021,vInsertarIncidencia,"pstConcepto");
        iRes = ERR021;
   }
   else 
   {
		strcpy (pCabCuota->szCodModulo  ,stConcepto.szCodModulo)  ;
       	strcpy (pCabCuota->szDesConcepto,stConcepto.szDesConcepto);
	   	if (stConcepto.iIndActivo == 0)
	   	{
	    	sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
	                stConcepto.iIndActivo);
	       	iRes = ERR001;
	   	}
		else 
		{
			if (pCuota->dImpCuota < 0)
	   		{
	       		sprintf (stAnomProceso.szObsAnomalia,
	            		"%s %lf","Importe menor que Cero",pCuota->dImpCuota);
	       		iRes = ERR001;
	   		}
	   		else 
	   		{
				if ((stConcepto.iCodTipConce == IMPUESTO ||
	        		 stConcepto.iCodTipConce == DESCUENTO) )
	   			{
			        sprintf (stAnomProceso.szObsAnomalia,"%s %d",
			                 "Tipo de Concepto (Descuento o Impuesto)",
			                 stConcepto.iCodTipConce);
			        iRes == ERR001;
	
	    		}
	    	}
		}
	}

    if (iRes != 0)
    {
        stAnomProceso.iCodConcepto = pCabCuota->iCodConcepto   ;
        stAnomProceso.iCodProducto = pCabCuota->iCodProducto   ;
        strcpy (stAnomProceso.szDesProceso,"Validacion Cuotas");
        stAnomProceso.lNumAbonado  = pCabCuota->lNumAbonado    ;

        stEstCuotas.iNumAnomalias++;
        if (iRes == ERR001)
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stConcepto.iIndActivo  ,
                     stConcepto.iCodTipConce,
                     pCuota->dImpCuota);
        }
    }
    else
        stEstCuotas.iNumCorrectos++;
    stEstCuotas.iNumProcesad++;

    return (iRes == 0)?TRUE:FALSE;
}/************************* Final bValidacionCuota ***************************/

/*****************************************************************************/
/*                          funcion : vInitEstCuotas                         */
/*****************************************************************************/
static void vInitEstCuotas (void)
{
  stEstCuotas.iNumProcesad = 0;
  stEstCuotas.iNumCorrectos= 0;
  stEstCuotas.iNumAnomalias= 0;
}/************************** Final vInitEstCuotas ****************************/


/*****************************************************************************/
/*                          funcion : bUpdateCuotas                          */
/*****************************************************************************/
static BOOL bUpdateCuotas (char *szRowid)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhRowid   ; /* EXEC SQL VAR szhRowid    IS STRING(19); */ 

  static int  iUno=1;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Update Cuotas\n"
                         "\t\t=> Rowid de Fa_Cuotas     [%s]\n",LOG05,
                         szRowid);
  szhRowid = szRowid;
 
  /* EXEC SQL UPDATE /o+ Rowid (FA_CUOTAS PK_FA_CUOTAS) o/
                  FA_CUOTAS
           SET   IND_FACTURADO = :iUno
           WHERE ROWID = :szRowid; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 2;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update  /*+  Rowid (FA_CUOTAS PK_FA_CUOTAS)  +*/ FA_CUOTAS \
 set IND_FACTURADO=:b0 where ROWID=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iUno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szRowid;
  sqlstm.sqhstl[1] = (unsigned long )0;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "Update->Fa_Cuotas\n\t",szfnORAerror());
      return FALSE;
  }
  return TRUE; 
}/************************* bUpdateCuotas ***********************************/

/*****************************************************************************/
/*                          funcion : bUpdateCabCuotas                       */
/*****************************************************************************/
static BOOL bUpdateCabCuotas (char *szRowid)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhRowid   ; /* EXEC SQL VAR szhRowid    IS STRING(19); */ 

  static int  iUno=1;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Update Cab.Cuotas\n"
                         "\t\t=> Rowid de Fa_CabCuotas     [%s]\n",LOG05,
                         szRowid);
  szhRowid = szRowid;

  /* EXEC SQL UPDATE /o+ Rowid (FA_CABCUOTAS PK_FA_CABCUOTAS) o/
                  FA_CABCUOTAS
           SET   IND_PAGADA = :iUno
           WHERE ROWID = :szRowid; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 2;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update  /*+  Rowid (FA_CABCUOTAS PK_FA_CABCUOTAS)  +*/ FA_C\
ABCUOTAS  set IND_PAGADA=:b0 where ROWID=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )28;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&iUno;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szRowid;
  sqlstm.sqhstl[1] = (unsigned long )0;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "Update->Fa_Cuotas\n\t",szfnORAerror());
      return FALSE;
  }
  return TRUE; 
}/************************* bUpdateCabCuotas ********************************/


/*****************************************************************************/
/*                         funcion : vFreeCuotas                             */
/* -Funcion que libera stCliente.pCabCuotas                                  */
/*****************************************************************************/
void vfnFreeCuotas (void)
{
  int iInd = 0;

  if (stCliente.pCabCuotas != (CABCUOTAS *)NULL)
  {
      for (iInd=0;iInd<stCliente.iNumCabCuotas;iInd++)
      {
           free (stCliente.pCabCuotas[iInd].pCuotas)          ;
           stCliente.pCabCuotas[iInd].pCuotas = (CUOTAS *)NULL;
           stCliente.pCabCuotas[iInd].iNCuotas = 0            ;
      }
      free (stCliente.pCabCuotas)             ;
      stCliente.pCabCuotas = (CABCUOTAS *)NULL;
  }
  stCliente.iNumCabCuotas = 0;
}/*************************** Final vFreeCuotas ******************************/

/*****************************************************************************/
/*                           funcion : bUpdateEquipaBoser                    */
/*****************************************************************************/
static BOOL bUpdateEquipaBoser (long lNumAbonado)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

     static char szPropiedad[2]   ; /* EXEC SQL VAR szPropiedad    IS STRING(2); */ 

  /* EXEC SQL END DECLARE SECTION  ; */ 


  vDTrazasLog (szExeName,"\n\t\t* Parametros de Entrada Ga_EquipAboSer"
                         "\n\t\t=> Num.Abonado  [%ld]",LOG04,lNumAbonado);

  strcpy(szPropiedad,"C");
  /* EXEC SQL UPDATE /o+ index (GA_EQUIPABOSER PK_GA_EQUIPABOSER) o/
                  GA_EQUIPABOSER
           SET    IND_PROPIEDAD = :szPropiedad
           WHERE  NUM_ABONADO = :lNumAbonado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 2;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update  /*+  index (GA_EQUIPABOSER PK_GA_EQUIPABOSER)  +*/ \
GA_EQUIPABOSER  set IND_PROPIEDAD=:b0 where NUM_ABONADO=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )51;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szPropiedad;
  sqlstm.sqhstl[0] = (unsigned long )2;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lNumAbonado;
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



  if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
  {
      iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Ga_EquipaBoser\n",
               szfnORAerror());
      return FALSE;
  }
  return TRUE;
}/*************************** Final bUpdateEquipaBoser ***********************/


/*****************************************************************************/
/*                            funcion : bUpdateIndCuotasInfa                 */
/*****************************************************************************/
static BOOL bUpdateIndCuotasInfa   (long lCodCliente,long lNumAbonado,
                                    int  iCodProducto)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

       static int  iCero=0;
  /* EXEC SQL END DECLARE SECTION  ; */ 

  
  char szFuncion [20] ="";

  	vDTrazasLog (szExeName,
               "\n\t\t* Parametos de Entrada Update Ga_Infac% (IndCuotas = 0)"
               "\n\t\t=> Cod.Cliente  [%ld]"
               "\n\t\t=> Num.Abonado  [%ld]"
               "\n\t\t=> Cod.Producto [%d] ",LOG05,
               lCodCliente,lNumAbonado,iCodProducto);

	strcpy (szFuncion,"Ga_InfacCel");
    /* EXEC SQL UPDATE /o+ index (GA_INFACCEL PK_GA_INFACCEL) o/
                      GA_INFACCEL
               SET    IND_CUOTAS = :iCero
               WHERE  COD_CLIENTE = :lCodCliente
                 AND  NUM_ABONADO = :lNumAbonado
                 AND  COD_CICLFACT= :stCiclo.lCodCiclFact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update  /*+  index (GA_INFACCEL PK_GA_INFACCEL)  +*/ GA_I\
NFACCEL  set IND_CUOTAS=:b0 where ((COD_CLIENTE=:b1 and NUM_ABONADO=:b2) and C\
OD_CICLFACT=:b3)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )74;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCero;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
    sqlstm.sqhstv[3] = (unsigned char  *)&(stCiclo.lCodCiclFact);
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



  	if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
  	{
    	iDError (szExeName,ERR000,vInsertarIncidencia,szFuncion,
               szfnORAerror());
      	return FALSE;
  	}
  	return TRUE;
}/*************************** Final bUpdateIndCuotasInfa *********************/

/*****************************************************************************/
/*                            funcion : bUpdateIndPagare                     */
/*****************************************************************************/
static BOOL bUpdateIndPagare (long lCodCliente)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

       static int  iCero=0;
  /* EXEC SQL END DECLARE SECTION  ; */ 


  if(strcmp (stFactCli.szFecUltPagare,stCiclo.szFecHastaCFijos) <= 0)
  {
     vDTrazasLog(szExeName,
                 "\n\t\t* Parametros de Entrada Update Fa_FactCli(IndPagare=0)"
                 "\n\t\t=> Cod.Cliente [%ld]",LOG05,lCodCliente);

      /* EXEC SQL UPDATE /o+ index (FA_FACTCLI PK_FA_FACTCLI) o/
                      FA_FACTCLI
               SET    IND_PAGARE = :iCero
               WHERE  COD_CLIENTE = :lCodCliente; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 4;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "update  /*+  index (FA_FACTCLI PK_FA_FACTCLI)  +*/ FA_F\
ACTCLI  set IND_PAGARE=:b0 where COD_CLIENTE=:b1";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )105;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&iCero;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
          iDError (szExeName,ERR000,vInsertarIncidencia,"Update->Fa_FactCli",
                   szfnORAerror());
          return FALSE;
      }

  }
  return TRUE;
}/*************************** Final bUpdateIndPagare *************************/

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
