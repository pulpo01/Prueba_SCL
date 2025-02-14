
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
    "./pc/presac.pc"
};


static unsigned int sqlctx = 865891;


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
   unsigned char  *sqhstv[2];
   unsigned long  sqhstl[2];
            int   sqhsts[2];
            short *sqindv[2];
            int   sqinds[2];
   unsigned long  sqharm[2];
   unsigned long  *sqharc[2];
   unsigned short  sqadto[2];
   unsigned short  sqtdso[2];
} sqlstm = {12,2};

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
5,0,0,1,64,0,2,682,0,0,1,1,0,1,0,1,5,0,0,
24,0,0,2,98,0,5,720,0,0,2,2,0,1,0,1,3,0,0,1,5,0,0,
};


/*****************************************************************************/
/*  Fichero     : presac.pc                                                  */ 
/*  Descripcion : funciones para prebilling SAC                              */
/*                                                                           */
/*  Fecha       : 30-Oct-96                                                  */
/*  Autor       : Javier Garcia Paredes                                      */
/*****************************************************************************/
#define _PRESAC_PC_

#include <presac.h>

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
/*                        funcion : bIFSac                                   */
/*  -Utilizacion de stCliente (estructura global)                            */
/*  -return Error->FALSE, !Error->TRUE                                       */
/*  -Entrada lNumAbonado (identificador unico de producto-abonado)           */
/*****************************************************************************/
BOOL bIFSac (int iTipoFact, int iIndFactur,long lNumAbonado,int iCodProducto)
{
     vDTrazasLog(szExeName,"\n\t\t* Cargando SAC (Penalizaciones)"
                 "\n\t\t=>Cliente     [%ld]"
                 "\n\t\t=>Num.Abonado [%ld]"
                 "\n\t\t=>Ind.Factur  [%d] ",
                 LOG03,stCliente.lCodCliente,lNumAbonado,iIndFactur);

     if (bCargaPenalizaCli (lNumAbonado,iCodProducto,iTipoFact,iIndFactur))
         return TRUE;
     else
         return FALSE;
}/**************************** Final bIFSac **********************************/

/*****************************************************************************/
/*                            funcion : bCargaPenalizaCli                    */
/*  -Entrada estructura stCliente.pPenaliza (global), lNumAbonado            */
/*  -En Rent Phone el Producto es Celular                                    */
/*  -return Error->FALSE, !Error->TRUE                                       */
/*****************************************************************************/
static BOOL bCargaPenalizaCli (long lNumAbonado ,
                               int  iCodProducto,
                               int  iTipoFact   ,
                               int iIndFactur)
{
   CONCEPTO  stConcepto;
    
   BOOL bAddReg      = FALSE;
   BOOL bRes         = TRUE ; 
   int  iNumPenaliza = 0    ;
   int  iCont        = 0    ;
   char szFecBaja[15]=""    ;
   char szFecAlta[15]=""    ;
   char szTipFact[20]=""	;

   memset (&stConcepto,0,sizeof(CONCEPTO));

   if (iTipoFact == FACT_CICLO)
       strcpy (szTipFact, "Ciclo");
   else if (iTipoFact == FACT_BAJA)
       strcpy (szTipFact, "Baja");
   else if (iTipoFact == FACT_RENTAPHONE)
       strcpy (szTipFact, "Rent Phone");
   else if (iTipoFact == FACT_ROAMINGVIS)
       strcpy (szTipFact, "Roaming Visitante");
    
       
   vDTrazasLog (szExeName,"\n\t\t* Carga de Penalizaciones %s\n"
                    	  "\t\t=> Cliente        [%ld]\n"
                    	  "\t\t=> Num.Abonado    [%ld]\n"
                    	  "\t\t=> Cod.Producto   [%d] \n",LOG04,szTipFact,
                    	  stCliente.lCodCliente,lNumAbonado,iCodProducto);

   stAnomProceso.lCodCliente = stCliente.lCodCliente;
   stAnomProceso.lNumAbonado = lNumAbonado          ;
   stAnomProceso.lCodCiclFact= stCiclo.lCodCiclFact ;
   stAnomProceso.iCodProducto= iCodProducto         ;

   strncpy (stAnomProceso.szDesProceso,"Carga Penalizaciones)",
            sizeof (stAnomProceso.szDesProceso));

   while (iCont<NUM_PENALIZACIONES && bRes)
   {
       switch (iTipoFact)
       {
           case FACT_CICLO:
	           if (lNumAbonado != ORA_NULL)
	           {
	              /* Penalizaciones a Nivel de Abonado */
	              if (pstPenalizaciones[iCont].lCodCliente==stCliente.lCodCliente&&
	                  pstPenalizaciones[iCont].lCodCiclFact==stCiclo.lCodCiclFact&&
	                  pstPenalizaciones[iCont].lNumAbonado == lNumAbonado        &&
	                 (pstPenalizaciones[iCont].lNumProceso == 0 ||
	                  pstPenalizaciones[iCont].lNumProceso == ORA_NULL)) 
	                   bAddReg = TRUE;
	               else
	                   bAddReg = FALSE; 
	           }
	           else
	           {
	              /* Penalizaciones a Nivel de Cliente */
	              if(pstPenalizaciones[iCont].lCodCliente ==stCliente.lCodCliente&&
	                 strcmp (pstPenalizaciones[iCont].szFecEfectividad,
	                         stCiclo.szFecDesdeOCargos)   >= 0                   &&
	                 strcmp (pstPenalizaciones[iCont].szFecEfectividad,
	                         stCiclo.szFecHastaOCargos)   <= 0                   &&
	                (pstPenalizaciones[iCont].lNumProceso == 0 ||                 
	                 pstPenalizaciones[iCont].lNumProceso == ORA_NULL))           
	                 bAddReg = TRUE;
	              else
	                 bAddReg = FALSE; 
	           }
           		break;
           case FACT_BAJA:
	           /* Penalizaciones a Nivel de Abonado */ 
	           if (lNumAbonado != ORA_NULL)
	           {              
	             if(pstPenalizaciones[iCont].lCodCliente ==stCliente.lCodCliente && 
	                pstPenalizaciones[iCont].lCodCiclFact<=stCiclo.lCodCiclFact  &&
	                pstPenalizaciones[iCont].lNumAbonado ==lNumAbonado           &&
	                pstPenalizaciones[iCont].iCodProducto==iCodProducto          &&
	               (pstPenalizaciones[iCont].lNumProceso ==ORA_NULL ||
	                pstPenalizaciones[iCont].lNumProceso ==SQLOK)    ) 
	                bAddReg = TRUE;
	             else
	                bAddReg = FALSE;
	           }
	           /* Penalizaciones a Nivel de Cliente */
	           if (lNumAbonado == ORA_NULL && iCodProducto == ORA_NULL)
	           {
	             if(pstPenalizaciones[iCont].lCodCliente==stCliente.lCodCliente && 
	                strcmp (pstPenalizaciones[iCont].szFecEfectividad,
	                        stCiclo.szFecDesdeOCargos)  >= 0                    &&
	                strcmp (pstPenalizaciones[iCont].szFecEfectividad,
	                        stCiclo.szFecHastaOCargos)  <= 0                    &&
	               (pstPenalizaciones[iCont].lNumProceso==ORA_NULL ||
	                pstPenalizaciones[iCont].lNumProceso==SQLOK)    )
	                bAddReg = TRUE;
	             else
	                bAddReg = FALSE;
	           }
           	break;
           case FACT_RENTAPHONE :
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
             if (pstPenalizaciones[iCont].lCodCliente     ==
                 stCliente.lCodCliente                                   &&
                 strcmp (pstPenalizaciones[iCont].szFecEfectividad,
                         szFecBaja) <= 0                                 &&
                 strcmp (pstPenalizaciones[iCont].szFecEfectividad,
                         szFecAlta) >= 0                                 &&
                 pstPenalizaciones[iCont].lNumAbonado     == lNumAbonado &&
                 pstPenalizaciones[iCont].iCodProducto    == iCodProducto)
             {
                 bAddReg = TRUE ;
             }
             else
             {
                 bAddReg = FALSE;
             }
             break;
           default :
               iDError (szExeName,ERR023,vInsertarIncidencia,iTipoFact);
               return FALSE;
        }
        if (bAddReg)
        {
            iNumPenaliza = stCliente.iNumPenaliza;

            if ((stCliente.pPenaliza=
                (PENALIZA *)realloc ((PENALIZA *)stCliente.pPenaliza,
                (iNumPenaliza+1)*sizeof(PENALIZA))) == (PENALIZA *)NULL)
            {
                 iDError (szExeName,ERR005,vInsertarIncidencia,
                          "stCliente.pPenaliza");
                 bRes = FALSE;
            }
            memset (&stCliente.pPenaliza[iNumPenaliza],0,sizeof(PENALIZA));
            memcpy (&stCliente.pPenaliza[iNumPenaliza],
                    &pstPenalizaciones  [iCont]       ,sizeof(PENALIZA))  ;
          
            stCliente.pPenaliza [iCont].iIndFactur = iIndFactur;
 
            if (!bValidacionPenaliza (&stCliente.pPenaliza[iNumPenaliza]))
                 bRes = FALSE;
            else
               stCliente.iNumPenaliza++;
        }
        iCont++;

	} /* fin While */
    if (bRes)
    {
        vDTrazasLog (szExeName,
                     "\t\t# Numero de Penalizaciones Cargadas [%ld]\n",LOG03,
                     stCliente.iNumPenaliza) ; 
    }
    return (bRes);
}/*************************** Final bCargaPenalizaCli ************************/


/*****************************************************************************/
/*                          funcion : bEMSac                                 */
/* -Funcion que pasa conceptos generados por el SAC (penalizaciones) a la ta-*/
/*  bla de Fa_PreFactura y las penalizaciones (Ca_Penalizaciones) a un histo-*/
/*  torico Fa_HistPenal.                                                     */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
BOOL bEMSac (void)
{
   int  iCont = 0       ;
   PENALIZA* pRegTmp = (PENALIZA *)NULL;
   BOOL bRes  = TRUE    ;
   int  iCodAnomalia = 0;

   vDTrazasLog (szExeName,"\n\t\t* Paso a Prefactura Modulo SAC "
   						  "\n\t\t=> Cliente             [%ld]"
                          "\n\t\t=> Num. Penalizaciones [%d] ",
                		  LOG03,stCliente.lCodCliente,stCliente.iNumPenaliza);

   strncpy (stAnomProceso.szDesProceso,"Paso a PreFactura del SAC",
            sizeof (stAnomProceso.szDesProceso));


   for (iCont=0;iCont<stCliente.iNumPenaliza;iCont++)
   {
        iCodAnomalia = ifnCheckPenaliza (&stCliente.pPenaliza[iCont]);
        switch (iCodAnomalia)
        {
          case  0:
                if (stCliente.pPenaliza[iCont].dImpPenaliz >= 0.01)
                {
                    if (!bEscribePreFactura  (&stCliente.pPenaliza[iCont],
                                              stProceso.iCodTipDocum))
                         bRes = FALSE;
                    if (!bUpdatePenalizaciones (&stCliente.pPenaliza[iCont]))
                         bRes = FALSE;
                 }
                 break;
          case -1: /* Errores Oracle */
                bRes = FALSE;
                break       ;
          default:
                if (!bfnEscribeAnomalia (&stCliente.pPenaliza[iCont],
                                         iCont, iCodAnomalia))
                     bRes = FALSE;
                bRes = FALSE;
                break;

         } /* fin switch */
         if (!bRes)
              return FALSE;

   }/* fin for */
   return TRUE;

}/*************************** Final bEMSac ***********************************/

/*****************************************************************************/
/*                           funcion : ifnCheckPenal                         */
/*****************************************************************************/
static int ifnCheckPenaliza (PENALIZA* pReg)
{
  int      iRes = 0  ;
  CONCEPTO stConcepto;

  memset (&stConcepto,0,sizeof(CONCEPTO));

  	if (!bFindConcepto (pReg->iCodConcepto,&stConcepto))
  	{
    	iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
    	iRes = ERR021;
  	}
  	else 
  	{
    	if ((stConcepto.iCodTipConce == IMPUESTO ||
    		 stConcepto.iCodTipConce == DESCUENTO  ) )
    	{
	    	sprintf (stAnomProceso.szObsAnomalia,"Tipo de Concepto erroneo %d",
	       	stConcepto.iCodTipConce);
	      	iRes = ERR001;
  		}
  		else
  		{
	  		if (stConcepto.iIndActivo == 0)
	  		{
		      	strcpy (stAnomProceso.szObsAnomalia,"Indice Activo = 0");
		      	iRes = ERR001;
	  		}
	  		else
	  		{
	  			if (pReg->dImpPenaliz <= 0)
  				{
			      	sprintf (stAnomProceso.szObsAnomalia,"Importe del concepto = %f",
			       	pReg->dImpPenaliz);
			      	iRes = ERR001;
  				}
  				else
  				{
  					strcpy (pReg->szDesConcepto,stConcepto.szDesConcepto);
  				}
  			}
  		}
  	}
  	if (iRes)
  	{
    	stAnomProceso.lNumProceso = stStatus.IdPro        ;
      	stAnomProceso.lCodCliente = stCliente.lCodCliente ;
      	stAnomProceso.iCodConcepto = pReg->iCodConcepto   ;
      	stAnomProceso.iCodProducto = pReg->iCodProducto   ;
      	stAnomProceso.lCodCiclFact = stCiclo.lCodCiclFact ;
      
  		switch (iRes)
      	{
  		case ERR021: 
       		break;
 		default    : 
 			iDError (szExeName,ERR001,vInsertarIncidencia,
                        stAnomProceso.iCodConcepto,
                        stConcepto.iIndActivo     ,
                        stConcepto.iCodTipConce   ,
                        pReg->dImpPenaliz); 
            break;         
    	}
  	}

  return (iRes);

}/*************************** Final ifnCheckPenal ****************************/

/*****************************************************************************/
/*                           funcion : vFreeSac                            */
/* -Funcion que libera la memoria de las estructuras para las penalizaciones */
/*  de un cliente=>  stCliente.pPenaliza                                     */
/*****************************************************************************/
void vFreeSac (void)
{
   if (stCliente.pPenaliza != (PENALIZA *)NULL)
   {
       free (stCliente.pPenaliza);
       stCliente.pPenaliza = (PENALIZA *)NULL;
       stCliente.iNumPenaliza = 0;
   }
}/*************************** Final vFreeSac *******************************/ 


/*****************************************************************************/
/*                            funcion : bfnGenEstaPen                        */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/* -Utilizacion stCliente estructura global al modulo                        */
/*****************************************************************************/
static BOOL bfnGenEstaPen(ESTSAC *pESSac)
{
   PENALIZA* pRegTmp = (PENALIZA *)NULL        ;
   EST_PENALIZA* pEstTmp = (EST_PENALIZA *)NULL;

   int  i = 0;
   long j = 0;

   pRegTmp = stCliente.pPenaliza;
   pEstTmp = pESSac->pEst       ;

   /* Liberamos la estructura de estadisticas */
   if (pEstTmp != NULL)
   {
       free(pESSac->pEst)                 ;
       pESSac->pEst = (EST_PENALIZA *)NULL;
   }
   pESSac->iNumEst = 0                    ;

   for (j=0;j<stCliente.iNumPenaliza;)
   {
        if ((pESSac->pEst=(EST_PENALIZA *)realloc((EST_PENALIZA *)pESSac->pEst,
            (i+1)*sizeof(PENALIZA)))==(EST_PENALIZA *)NULL)
        {
             iDError (szExeName,ERR005,vInsertarIncidencia,"stESSac.pEst");
             return FALSE;
        }
        pEstTmp = pESSac->pEst+i;

        pEstTmp->lCodCliente = stCliente.lCodCliente;
        pEstTmp->iAbonados   = 0                    ;
        pEstTmp->dImporte    = 0.0                  ;
        pEstTmp->iAnomalia   = 0                    ;

        do
        {
            /* Los importes para un mismo NumAbonado van a unico reg. */
            /* Cuando el reg. es anomalo se lo anadimos a otro reg.   */
            pEstTmp->iAnomalia = 0;

            if (pRegTmp->iCodTipConce != ARTICULO)
            {
                pEstTmp->iAnomalia = ERR027;
                vDTrazasLog(szExeName,
                            "Registro Anomalo: Cliente [%ld] Abonado [%d] "
                            "Tipo Concepto [%d]",
                            LOG03,pEstTmp->lCodCliente,pRegTmp->lNumAbonado,
                            pRegTmp->iCodTipConce);
            }
            if (pRegTmp->dImpPenaliz == 0)
            {
                pEstTmp->iAnomalia = ERR017;
                vDTrazasLog(szExeName,
                            "Registro Anomalo: Cliente [%ld] Abonado [%d]"
                            "Importe Penalizacion == 0",LOG03,
                            pEstTmp->lCodCliente,pEstTmp->iAbonados);
             }
             if (pRegTmp->dImpPenaliz < 0)
             {
                 pEstTmp->iAnomalia = ERR024;
                 vDTrazasLog(szExeName,
                             "Registro Anomalo: Cliente [%ld] Abonado [%d]"
                             "Importe Penaliza < 0 (%lf)",LOG03,
                             pEstTmp->lCodCliente, pRegTmp->lNumAbonado,
                             pRegTmp->dImpPenaliz);
             }
             if (pRegTmp->iIndActivo == 0)
             {
                 pEstTmp->iAnomalia = ERR028;
                 vDTrazasLog(szExeName,
                             "Registro Anomalo: Cliente [%ld] Abonado [%d]"
                             "Indicador de Activo == 0",LOG03,
                             pEstTmp->lCodCliente, pRegTmp->lNumAbonado);
             }
             pEstTmp->iAbonados++                     ;
             pEstTmp->dImporte += pRegTmp->dImpPenaliz;
             pRegTmp++                                ;
             j++                                      ;
      }while ( (pRegTmp-1)->lNumAbonado == pRegTmp->lNumAbonado &&
                pRegTmp->iCodTipConce   == ARTICULO             &&
                pRegTmp->dImpPenaliz    >  0                    &&
                pRegTmp->iIndActivo     == 1                    &&
                pEstTmp->iAnomalia      == 0                    &&
                j < (long)stCliente.iNumPenaliza);
      i++;
      pESSac->iNumEst++;
   }/* fin for */
   return TRUE;
}/*************************** Final bfnGenEstaPen ****************************/


/* rao20030814 */
/*****************************************************************************/
/*                            funcion : bfnGrabaEstaPen                      */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
/*static BOOL bfnGrabarEstaPen(ESTSAC *pESSac)
{
   int iProcesados=0, iAnomalos=0, iCorrectos=0;
   double dImpProcesados=0                     ;
   double dImpAnomalos  =0                     ;
   double dImpCorrectos =0                     ;
   int iCont=0                                 ;
   char szTab1[2]="\t", szTab2[4]="\t\t"       ;
   char szAux [4]                              ;
   FILE* fp = (FILE *)NULL                     ;
   EST_PENALIZA* pEstTmp = (EST_PENALIZA *)NULL;
   char szNombreArchivo [256]                  ;

   sprintf(szNombreArchivo,"EstSac%ld.est",stStatus.IdPro);

   if ((fp = fopen (szNombreArchivo,"a"))==NULL)
   {
        iDError(szExeName,ERR005,vInsertarIncidencia,szNombreArchivo);
        return FALSE;
   }
*/
   /* Comprobamos si es la primera vez que se llama a Estadisticas */
/*   if (stEstTotSac.iNumClientes == 0)
   {
       fprintf (fp,"\n\n                Estadisticas de Penalizaciones\n%s",
       "___________________________________________________________________");
       fprintf (fp,"\n\nCiclo de Facturacion: %ld\t\tCod.Modulo: AC\n\n",
stCiclo.lCodCiclFact);
   }
   stEstTotSac.iNumClientes++;
   fprintf (fp,"CLIENTE: %ld\n",stCliente.lCodCliente);

   pEstTmp = pESSac->pEst;

   for (iCont=0; iCont<pESSac->iNumEst;iCont++)
   {
if (pEstTmp->iAnomalia != 0)
{
    iAnomalos    += pEstTmp->iAbonados;
    dImpAnomalos += pEstTmp->dImporte ;
}
else
{
    iCorrectos   += pEstTmp->iAbonados;
    dImpCorrectos+= pEstTmp->dImporte ;
}
iProcesados      += pEstTmp->iAbonados;
dImpProcesados   += pEstTmp->dImporte ;
pEstTmp++;

}
*/ /* fin for */
/*   if (iProcesados > 99999)
       strcpy (szAux, szTab1);
   else
       strcpy (szAux, szTab2);

   stEstTotSac.iRegCorrectos += iCorrectos   ;
   stEstTotSac.dImpCorrectos += dImpCorrectos;
   fprintf (fp,"%s%-5d%s%s%-12.4f\n",
       "Registros Correctos : ",iCorrectos,szAux,"Imp.Correctos : ",
       dImpCorrectos);

   if (iAnomalos > 99999)
       strcpy (szAux, szTab1);
   else
       strcpy (szAux, szTab2);

   stEstTotSac.iRegAnomalos += iAnomalos     ;
   stEstTotSac.dImpAnomalos += dImpAnomalos  ;
   fprintf (fp,"%s%-5d%s%s%-12.4f\n",
       "Registros Anomalos : ",iAnomalos,szAux,"Imp. Anomalos : ",
dImpAnomalos);

   fprintf (fp,"%s\n",
   "___________________________________________________________________");

   if (fclose (fp))
   {
       vDTrazasLog (szExeName,"Error al cerrar fichero : %s",LOG03,
    szNombreArchivo); 
       return FALSE       ;
   }
   return TRUE            ;
}
*/
/*************************** Final bfnGrabaEstaPen **************************/


/*****************************************************************************/
/*                        funcion : bEscribePreFactura                     */
/* -Entrada PENALIZA* pPenaliza                                              */
/* -Salida  Error->FALSE, !Error->TRUE                                       */
/* -Utilizacion szSysDate (global) sysdate del proceso                       */
/*****************************************************************************/
static BOOL bEscribePreFactura (PENALIZA* pReg, int iTipoFact)
{
  int  iInd      = 0    ;
  BOOL bError    = FALSE;
  double dImpConceptoAux;

  char szFuncion [20] = "";

  iInd = stPreFactura.iNumRegistros;

  /*if (stPreFactura.iNumRegistros >= MAX_CONCFACTUR)
  {
      iDError (szExeName,ERR035,vInsertarIncidencia);
      return FALSE;
  }*/

  stPreFactura.A_PFactura[iInd].lNumProceso = stStatus.IdPro       ;
  stPreFactura.A_PFactura[iInd].lCodCliente = stCliente.lCodCliente;
  stPreFactura.A_PFactura[iInd].iCodConcepto= pReg->iCodConcepto   ;
  stPreFactura.A_PFactura[iInd].iCodProducto= pReg->iCodProducto   ;
  stPreFactura.A_PFactura[iInd].lCodCiclFact= pReg->lCodCiclFact   ;
  stPreFactura.A_PFactura[iInd].lNumAbonado = pReg->lNumAbonado    ;
  stPreFactura.A_PFactura[iInd].iIndFactur  = pReg->iIndFactur     ;

  strcpy (stPreFactura.A_PFactura[iInd].szDesConcepto, pReg->szDesConcepto   );
  strcpy (stPreFactura.A_PFactura[iInd].szFecValor   , pReg->szFecEfectividad);

  strcpy (stPreFactura.A_PFactura[iInd].szFecEfectividad,szSysDate)          ;
  strcpy (stPreFactura.A_PFactura[iInd].szCodMoneda     ,pReg->szCodMoneda)  ;
  strcpy (stPreFactura.A_PFactura[iInd].szCodModulo     ,pReg->szCodModulo)  ;

  strcpy(stPreFactura.A_PFactura[iInd].szCodRegion   ,stCliente.szCodRegion)   ;
  strcpy(stPreFactura.A_PFactura[iInd].szCodCiudad   ,stCliente.szCodCiudad)   ;
  strcpy(stPreFactura.A_PFactura[iInd].szCodProvincia,stCliente.szCodProvincia);

  stPreFactura.A_PFactura[iInd].dImpConcepto  = pReg->dImpPenaliz;
  stPreFactura.A_PFactura[iInd].dImpFacturable= pReg->dImpPenaliz;
  
  dImpConceptoAux = stPreFactura.A_PFactura[iInd].dImpFacturable;

  if (!bConversionMoneda (stCliente.lCodCliente                       ,
                          stPreFactura.A_PFactura[iInd].szCodMoneda   ,
                          stDatosGener.szCodMoneFact                  ,
                          stPreFactura.A_PFactura[iInd].szFecValor    ,
                         &stPreFactura.A_PFactura[iInd].dImpFacturable))
       return FALSE; /* P-MIX-09003 4*/
       
  stPreFactura.A_PFactura[iInd].dImpFacturable = fnCnvDouble( stPreFactura.A_PFactura[iInd].dImpFacturable, 0);

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
  
  stPreFactura.A_PFactura[iInd].lCodPlanCom  = stCliente.lCodPlanCom       ;
  stPreFactura.A_PFactura[iInd].iCodCatImpos = stCliente.iCodCatImpos      ;
  stPreFactura.A_PFactura[iInd].iIndEstado   = EST_NORMAL                  ;
  stPreFactura.A_PFactura[iInd].lNumUnidades = 1                           ;
  stPreFactura.A_PFactura[iInd].iCodTipConce = ARTICULO                    ; 
  stPreFactura.A_PFactura[iInd].iCodConceRel = 0                           ;
  stPreFactura.A_PFactura[iInd].lColumnaRel  = 0                           ;

  stPreFactura.A_PFactura[iInd].szNumTerminal[0] = 0;
  stPreFactura.A_PFactura[iInd].szNumSerieMec[0] = 0;
  stPreFactura.A_PFactura[iInd].szNumSerieLe [0] = 0;

  stPreFactura.A_PFactura[iInd].lCapCode        = ORA_NULL;
  stPreFactura.A_PFactura[iInd].iFlagImpues     = 0       ;
  stPreFactura.A_PFactura[iInd].iFlagDto        = 0       ;
  stPreFactura.A_PFactura[iInd].fPrcImpuesto    = 0       ;
  stPreFactura.A_PFactura[iInd].dValDto         = 0       ;
  stPreFactura.A_PFactura[iInd].iTipDto         = 0       ;
  stPreFactura.A_PFactura[iInd].lNumVenta       = 0       ;
  stPreFactura.A_PFactura[iInd].lNumTransaccion = 0       ;
  stPreFactura.A_PFactura[iInd].iMesGarantia    = 0       ;
  stPreFactura.A_PFactura[iInd].iIndAlta        = 0       ;
  stPreFactura.A_PFactura[iInd].iIndSuperTel    = 0       ;
  stPreFactura.A_PFactura[iInd].iNumPaquete     = 0       ;
  stPreFactura.A_PFactura[iInd].iIndCuota       = 0       ;
  stPreFactura.A_PFactura[iInd].iNumCuotas      = 0       ;
  stPreFactura.A_PFactura[iInd].iOrdCuota       = 0       ;


  stPreFactura.A_PFactura[iInd].bOptPenaliza = TRUE;

  if (!bGetMaxColPreFa (stPreFactura.A_PFactura[iInd].iCodConcepto,
                        &stPreFactura.A_PFactura[iInd].lColumna))
       return FALSE;

  strcpy (szFuncion,"Penalizaciones")    ;
  vPrintRegInsert (iInd,szFuncion,bError);

  /* stPreFactura.iNumRegistros++           ; */
  if(bfnIncrementarIndicePreFactura()==FALSE)
  {
      vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
      vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
      return FALSE;
  }


  return TRUE;

}/*********************** Final bEscribePreFactura *************************/


/*****************************************************************************/
/*                      funcion : bfnDeletePenalizacion                      */
/*  -Entrada PENALIZA* pPenaliza                                             */
/*  -Salida Error->FALSE, !Error->TRUE                                       */
/*****************************************************************************/
static BOOL bfnDeletePenalizacion (PENALIZA* pPenaliza)
{
   /* EXEC SQL BEGIN DECLARE SECTION; */ 

   static char *szhRowid; /* EXEC SQL VAR szhRowid IS STRING(19); */ 

   /* EXEC SQL END DECLARE SECTION; */ 


   szhRowid = pPenaliza->szRowid;
   
   /* EXEC SQL DELETE /o+ Rowid o/ 
            FROM   CA_PENALIZACIONES
            WHERE  ROWID = :szhRowid; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 1;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "delete  /*+  Rowid  +*/  from CA_PENALIZACIONES  where ROW\
ID=:b0";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )5;
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



   if (SQLCODE != 0)
       iDError(szExeName,ERR000,vInsertarIncidencia,"Delete->CA_PENALIZACIONES"
       		   ,LOG03,szfnORAerror() );
   else
      vDTrazasLog(szExeName,"Delete->CA_PENALIZACIONES por Rowid[%s]\n",
                  LOG03,szhRowid);
   return (SQLCODE != 0)?FALSE:TRUE; 
  
}/********************* Final bfnDeletepenalizacion **************************/

/*****************************************************************************/
/*                      funcion : bfnEscribeAnomalia                         */
/*  -Entrada PENALIZA* pPenaliza, iNumReg, iCodAnomalia                      */
/*  -Salida  Error->FALSE, !Error->TRUE                                      */
/*****************************************************************************/
static BOOL bfnEscribeAnomalia (PENALIZA* pPenaliza, int iNumReg, 
                                int iCodAnomalia)
{
  return 0;
}/********************* Final bfnEscribeAnomalia *****************************/


/*****************************************************************************/
/*                      funcion : bUpdatePenalizaciones                      */
/*****************************************************************************/
static BOOL bUpdatePenalizaciones (PENALIZA *pPen)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static char *szhRowid    ; /* EXEC SQL VAR szhRowid IS STRING(19); */ 

  static long  lhNumProceso;
  /* EXEC SQL END DECLARE SECTION; */ 


  lhNumProceso = stStatus.IdPro;
  szhRowid     = pPen->szRowid ;
  /* EXEC SQL UPDATE /o+ Rowid (CA_PENALIZACIONES) o/
                  CA_PENALIZACIONES
           SET   NUM_PROCESO = :lhNumProceso
           WHERE ROWID = :szhRowid; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 2;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update  /*+  Rowid (CA_PENALIZACIONES)  +*/ CA_PENALIZACION\
ES  set NUM_PROCESO=:b0 where ROWID=:b1";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )24;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "Update->Ca_Penalizaciones",szfnORAerror());
  return (SQLCODE != 0)?FALSE:TRUE;
}/******************** Final bUpdatePenalizaciones ***************************/ 

/*****************************************************************************/
/*                         funcion : bValidacionPenaliza                     */
/* -Funcion que valida un concepto de penalizaciones                         */ 
/* -Entrada : Indice de stCliente.pPenaliza                                  */ 
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
static BOOL bValidacionPenaliza (PENALIZA *pPenaliza)
{
   int iRes = 0;
   CONCEPTO stConcepto;

   memset (&stConcepto,0,sizeof(CONCEPTO));

   if (!bFindConcepto (pPenaliza->iCodConcepto,&stConcepto))
   {
       iDError (szExeName,ERR021,vInsertarIncidencia,"pstConceptos");
       iRes = ERR021;
   }
   else 
   {
       strcpy (pPenaliza->szCodModulo  ,stConcepto.szCodModulo)  ;
       strcpy (pPenaliza->szDesConcepto,stConcepto.szDesConcepto);
	   
	   if (stConcepto.iIndActivo == 0)
	   {
	       sprintf (stAnomProceso.szObsAnomalia,"%s %d","Ind.Activo Cero",
	                stConcepto.iIndActivo);
	       iRes = ERR001;
	   }
	   else 
	   {
		   if (pPenaliza->dImpPenaliz < 0)
		   {
		       sprintf (stAnomProceso.szObsAnomalia,
		                "%s %lf","Importe menor que Cero",
		                 pPenaliza->dImpPenaliz);
		       iRes = ERR001;
		   }
		   else
		   {
			   	if  (stConcepto.iCodTipConce == IMPUESTO ||
			   	     stConcepto.iCodTipConce == DESCUENTO )
			   	{
			    	sprintf (stAnomProceso.szObsAnomalia,"%s %d",
			                 "Tipo de Concepto (Descuento o Impuesto)",
			                 stConcepto.iCodTipConce);
			        iRes == ERR001;
			
				}
				else 
				{
			        if ( strcmp (pPenaliza->szCodMoneda,
			                     stConcepto.szCodMoneda) != 0 )
			        {
			             if (!bConversionMoneda (stCliente.lCodCliente ,
			                                     pPenaliza->szCodMoneda,
			                                     stConcepto.szCodMoneda,
			                                     szSysDate             ,
			                                    &pPenaliza->dImpPenaliz))
			                  return FALSE; /* P-MIX-09003 4 */

			             strcpy (pPenaliza->szCodMoneda,
			                     stConcepto.szCodMoneda);
			        }
			        else
			           strcpy (pPenaliza->szCodMoneda,stConcepto.szCodMoneda);
				}		   	
		   	}
	   	}
	}

    if (iRes != 0)
    {
        stAnomProceso.iCodConcepto = pPenaliza->iCodConcepto;
        stAnomProceso.iCodProducto = pPenaliza->iCodProducto;
        strcpy (stAnomProceso.szDesProceso,"PreBilling SAC");
        stAnomProceso.lNumAbonado  = pPenaliza->lNumAbonado ;
        if (iRes == ERR001)
        {
            iDError (szExeName,ERR001,vInsertarIncidencia,
                     stConcepto.iIndActivo  ,
                     stConcepto.iCodTipConce,
                     pPenaliza->dImpPenaliz);
        }
    }

    return (iRes == 0)?TRUE:FALSE;
}/*********************** Final bValidacionPenaliza ************************/


