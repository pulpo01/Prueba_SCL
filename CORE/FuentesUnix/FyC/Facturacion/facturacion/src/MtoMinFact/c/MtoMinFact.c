
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
    "./pc/MtoMinFact.pc"
};


static unsigned int sqlctx = 13858827;


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
5,0,0,1,91,0,4,459,0,0,3,1,0,1,0,2,3,0,0,2,5,0,0,1,3,0,0,
};


/*****************************************************************************/
/*  Fichero    : MtoMinFact.pc                                               */
/*  Descripcion: Monto Minimo Facturable                                     */
/*****************************************************************************/
#define _MTOMINFACT_PC_

#include "MtoMinFact.h"

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
/*  Funcion : bfnMontoMin_Fact                                               */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
access BOOL bfnMontoMin_Fact (long lCliente)
{
int     iCntAboEmp, iCntAboInd, iCntPaso ;
int     iNroCptoCB, iNroCpto, iCont ;
double  dNumRegInit;
REGMMF  stAboInd[NUM_ABONADOS_CLIENTE];
REGMMF  stAboEmp[NUM_ABONADOS_CLIENTE];
int     iPosAboCero;
BOOL    bFlag_Exis ;
int     i = 0;

    iCntAboEmp  =0;
    iCntAboInd  =0;
    iPosAboCero =0;

    memset (&stAboInd[0],0,sizeof(REGMMF)*NUM_ABONADOS_CLIENTE);
    memset (&stAboEmp[0],0,sizeof(REGMMF)*NUM_ABONADOS_CLIENTE);

    vDTrazasLog (modulo,"\n\t\t** Function bfnMontoMin_Fact MMF **"
                        "\n\t\t=> lCliente................. [%ld]"
                        ,LOG03      ,lCliente );

    dNumRegInit=stPreFactura.iNumRegistros;

    for (iNroCpto=0;iNroCpto < dNumRegInit ;iNroCpto++)
    {
        if (stPreFactura.A_PFactura[iNroCpto].iCodConcepto==stDatosGener.iCodAbonoCel)
        {
            if (bfnValidaPlanTarifMFF(stPreFactura.A_PFactura[iNroCpto].szCodPlanTarif))
            {
                if (strcmp(stPreFactura.A_PFactura[iNroCpto].szTipPlanTarif, "I")==0)
                {
                    bFlag_Exis=FALSE;
                    for (iCont=0;iCont<iCntAboInd;iCont++)
                    {
                        if ((stAboInd[iCont].lNumAbonado==stPreFactura.A_PFactura[iNroCpto].lNumAbonado)
                            && (strcmp(stAboInd[iCont].szPlantarif,stPreFactura.A_PFactura[iNroCpto].szCodPlanTarif)==0))
                        {
                            iCntPaso=iCntAboInd ;
                            iCntAboInd=iCont    ;
                            bFlag_Exis=TRUE     ;
                            break;
                        }
                    }
                    stAboInd[iCntAboInd].lNumAbonado        =stPreFactura.A_PFactura[iNroCpto].lNumAbonado    ;
                    strcpy(stAboInd[iCntAboInd].szPlantarif ,stPreFactura.A_PFactura[iNroCpto].szCodPlanTarif );
                    stAboInd[iCntAboInd].dImpCargoBasico    +=stPreFactura.A_PFactura[iNroCpto].dImpFacturable;
                    stAboInd[iCntAboInd].iPosCargoBasico    =iNroCpto;
                    if ( bFlag_Exis )
                    {
                        iCntAboInd=iCntPaso;
                    }else {
                        iCntAboInd++;
                    }
                }
                else if (  (strcmp(stPreFactura.A_PFactura[iNroCpto].szTipPlanTarif, "E")==0)
                        || (strcmp(stPreFactura.A_PFactura[iNroCpto].szTipPlanTarif, "H")==0) )
                {
                    bFlag_Exis=FALSE;
                    for (iCont=0;iCont<iCntAboEmp;iCont++)
                    {
                        if ((stAboEmp[iCont].lNumAbonado==stPreFactura.A_PFactura[iNroCpto].lNumAbonado)
                            && (strcmp(stAboEmp[iCont].szPlantarif,stPreFactura.A_PFactura[iNroCpto].szCodPlanTarif)==0))
                        {
                            iCntPaso=iCntAboEmp ;
                            iCntAboEmp=iCont    ;
                            bFlag_Exis=TRUE     ;
                            break;
                        }
                    }
                    if (stPreFactura.A_PFactura[iNroCpto].lNumAbonado<=0)
                    {
                        iPosAboCero=iCntAboEmp;
                        stAboEmp[iPosAboCero].dImpCargoBasico +=stPreFactura.A_PFactura[iNroCpto].dImpFacturable;
                    }
                    stAboEmp[iCntAboEmp].lNumAbonado        = stPreFactura.A_PFactura[iNroCpto].lNumAbonado;
                    strcpy(stAboEmp[iCntAboEmp].szPlantarif , stPreFactura.A_PFactura[iNroCpto].szCodPlanTarif);
                    stAboEmp[iCntAboEmp].iPosCargoBasico    = iNroCpto;
                    if ( bFlag_Exis )
                    {
                        iCntAboEmp=iCntPaso;
                    }else {
                        iCntAboEmp++;
                    }
                }
            }
        }
    }

    vDTrazasLog (modulo,"\n\t\t\t=>Nro. de Abonados Individuales. [%d]"
                        "\n\t\t\t=>Nro. de Abonados Empresa...... [%d]\n"
                        ,LOG03,iCntAboInd,iCntAboEmp);

    for (iCont=0;iCont < iCntAboInd ;iCont++)
    {
        for (iNroCpto=0;iNroCpto < dNumRegInit ;iNroCpto++)
        {
            if (stAboInd[iCont].lNumAbonado==stPreFactura.A_PFactura[iNroCpto].lNumAbonado)
            {
                if (bBuscaCodTraficoLocal(stPreFactura.A_PFactura[iNroCpto].iCodConcepto))
                {
                    stAboInd[iCont].dImpTrafico+=stPreFactura.A_PFactura[iNroCpto].dImpFacturable;
                }
            }
        }
    }
    for (iCont=0;iCont < iCntAboEmp ;iCont++)
    {
        for (iNroCpto=0;iNroCpto < dNumRegInit ;iNroCpto++)
        {
            if (stAboEmp[iCont].lNumAbonado==stPreFactura.A_PFactura[iNroCpto].lNumAbonado)
            {
                if (bBuscaCodTraficoLocal(stPreFactura.A_PFactura[iNroCpto].iCodConcepto))
                {
                    stAboEmp[iPosAboCero].dImpTrafico+=stPreFactura.A_PFactura[iNroCpto].dImpFacturable;
                }
            }
        }
    }

    for (iCont=0;iCont < iCntAboInd ;iCont++)
    {
        vDTrazasLog (modulo,"\n\t\t\t=>Imp. Ind. Cargo Basico. [%.0f]"
                            "\n\t\t\t=>Imp. Ind. Trafico...... [%.0f]\n"
                            ,LOG05
                            ,stAboInd[iCont].dImpCargoBasico
                            ,stAboInd[iCont].dImpTrafico);
        if (stAboInd[iCont].dImpTrafico<stAboInd[iCont].dImpCargoBasico)
        {

            if (!bfnGeneraCptoMMF(stAboInd[iCont].iPosCargoBasico
                                , stAboInd[iCont].dImpCargoBasico
                                , stAboInd[iCont].dImpTrafico))
            {
                vDTrazasError(modulo,"\t\tGenerando Concepto MMF Individual",LOG01);
                return (FALSE);
            }
        }
        if (!bfnRebajaCargoBasico(stAboInd[iCont].iPosCargoBasico))
        {
            vDTrazasError(modulo,"\t\tRebajando Cargo Basico Individual",LOG01);
            return (FALSE);
        }
    }

    if (iCntAboEmp>0)
    {
        vDTrazasLog (modulo,"\n\t\t\t=>Imp. Emp. Cargo Basico. [%.0f]"
                            "\n\t\t\t=>Imp. Emp. Trafico...... [%.0f]\n"
                            ,LOG05
                            ,stAboEmp[iPosAboCero].dImpCargoBasico
                            ,stAboEmp[iPosAboCero].dImpTrafico);

        if (stAboEmp[iPosAboCero].dImpTrafico< stAboEmp[iPosAboCero].dImpCargoBasico)
        {
            if (!bfnGeneraCptoMMF(stAboEmp[iPosAboCero].iPosCargoBasico
                                , stAboEmp[iPosAboCero].dImpCargoBasico
                                , stAboEmp[iPosAboCero].dImpTrafico))
            {
                vDTrazasError(modulo,"\t\tGenerando Concepto MMF Empresa",LOG01);
                return (FALSE);
            }
        }
        if (!bfnRebajaCargoBasico(stAboEmp[iPosAboCero].iPosCargoBasico))
        {
            vDTrazasError(modulo,"\t\tRebajando Cargo Basico Empresa",LOG01);
            return (FALSE);
        }
    }

    /* [JQH] Validar si flag de Validacion de importe esta activado */
    if (stDatosGener.lIndValImporte == 1L )
    { 
        for(iNroCpto=0;iNroCpto< stPreFactura.iNumRegistros;iNroCpto++)
        {
            if( abs(stPreFactura.A_PFactura[iNroCpto].dImpConcepto) <= (double)(stDatosGener.lMontoImporte) )
            {
                vDTrazasLog(modulo,"\t [JQH] Procediendo a trasladar Registros... iNroCpto : [%d]",LOG05, iNroCpto);
                for(i=iNroCpto;i<stPreFactura.iNumRegistros-1;i++)
                {
                    memcpy(&stPreFactura.A_PFactura[i], &stPreFactura.A_PFactura[i+1], sizeof(FAPFACTURA));
               
                }
            
                /* Antes del siguiente bucle, disminuimos en 1 iNroCpto para que tome el trasladado hacia arriba */
                iNroCpto--;
                /* Limpiamos el ultimo registro */
                vfnLimpiarRegs(stPreFactura.iNumRegistros-1, stPreFactura.iNumRegistros);
                /* Decrementar la cantidad de registros validos */
                stPreFactura.iNumRegistros--;
                
            }
            
        }

    }

    return (TRUE);
}/************************ bfnMontoMin_Fact **********************************/


/*****************************************************************************/
/* bfnGeneraCptoMMF: Genera el nuevo concepto de la diferencia del cargo     */
/*                   basico (MMF) y el trafico local                         */
/*                                                                           */
/*****************************************************************************/
BOOL bfnGeneraCptoMMF (long lNroConcCB, double  dImpCargoBasico, double dImpTrafico)
{
    int     iCodConcep          =0 ;
    char    szDesConcep [1025]  ="";
    int     iNumConceptos       =0 ;
    double  dDifConcepto        =0 ;

    /*if (stPreFactura.iNumRegistros >= MAX_CONCFACTUR)
    {
        iDError (szExeName,ERR035,vInsertarIncidencia);
        return FALSE;
    }*/

    dDifConcepto= dImpCargoBasico - dImpTrafico;

    vDTrazasLog (modulo,"\n\t\t\tEntrada en bfnGeneraCptoMMF"
                        "\n\t\t\t=> Nro. Abonado......[%ld] "
                        "\n\t\t\t=> Imp. Cargo Basico.[%ld] "
                        "\n\t\t\t=> Imp. Trafico......[%ld] "
                        ,LOG05,stPreFactura.A_PFactura[lNroConcCB].lNumAbonado ,
                        dImpCargoBasico,dImpTrafico );

    iNumConceptos = stPreFactura.iNumRegistros;

    stPreFactura.A_PFactura[iNumConceptos].lNumAbonado     =stPreFactura.A_PFactura[lNroConcCB].lNumAbonado     ;
                                                                                               
    stPreFactura.A_PFactura[iNumConceptos].lNumProceso     =stPreFactura.A_PFactura[lNroConcCB].lNumProceso     ;
    stPreFactura.A_PFactura[iNumConceptos].lCodCliente     =stPreFactura.A_PFactura[lNroConcCB].lCodCliente     ;
                            
    if (!bfnGetConcParam ( 21, &iCodConcep, szDesConcep ))
    {                       
        vDTrazasError(modulo,"\n\t\tObteniendo el Codigo de Concepto desde FAD_PARAMETROS ",LOG01);
        return (FALSE);
    }

            stPreFactura.A_PFactura[iNumConceptos].iCodConcepto    =iCodConcep;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szDesConcepto   ,szDesConcep);

    if (!bGetMaxColPreFa
        (stPreFactura.A_PFactura[iNumConceptos].iCodConcepto       ,
        &stPreFactura.A_PFactura[iNumConceptos].lColumna           ))
        return FALSE;

            stPreFactura.A_PFactura[iNumConceptos].iCodProducto    =stPreFactura.A_PFactura[lNroConcCB].iCodProducto    ;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodMoneda     ,stPreFactura.A_PFactura[lNroConcCB].szCodMoneda     );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szFecValor      ,stPreFactura.A_PFactura[lNroConcCB].szFecValor      );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szFecEfectividad,stPreFactura.A_PFactura[lNroConcCB].szFecEfectividad);

            stPreFactura.A_PFactura[iNumConceptos].dImpConcepto    =dDifConcepto;
            stPreFactura.A_PFactura[iNumConceptos].dImpMontoBase   =0;
            stPreFactura.A_PFactura[iNumConceptos].dImpFacturable  =dDifConcepto;
                                                  
            stPreFactura.A_PFactura[iNumConceptos].lSegConsumido   =0;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodRegion     ,stPreFactura.A_PFactura[lNroConcCB].szCodRegion     );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodProvincia  ,stPreFactura.A_PFactura[lNroConcCB].szCodProvincia  );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodCiudad     ,stPreFactura.A_PFactura[lNroConcCB].szCodCiudad     );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodModulo     ,stPreFactura.A_PFactura[lNroConcCB].szCodModulo     );
            stPreFactura.A_PFactura[iNumConceptos].lCodPlanCom     =stPreFactura.A_PFactura[lNroConcCB].lCodPlanCom     ;
            stPreFactura.A_PFactura[iNumConceptos].iCodCatImpos    =stPreFactura.A_PFactura[lNroConcCB].iCodCatImpos    ;
            stPreFactura.A_PFactura[iNumConceptos].iCodPortador    =stPreFactura.A_PFactura[lNroConcCB].iCodPortador    ;
            stPreFactura.A_PFactura[iNumConceptos].iIndFactur      =stPreFactura.A_PFactura[lNroConcCB].iIndFactur      ;
            stPreFactura.A_PFactura[iNumConceptos].lNumUnidades    =stPreFactura.A_PFactura[lNroConcCB].lNumUnidades    ; /* Incorporado por PGonzaleg 1-03-2002 */
            stPreFactura.A_PFactura[iNumConceptos].iIndEstado      =stPreFactura.A_PFactura[lNroConcCB].iIndEstado      ;

            stPreFactura.A_PFactura[iNumConceptos].iCodTipConce    =stPreFactura.A_PFactura[lNroConcCB].iCodTipConce    ;
            stPreFactura.A_PFactura[iNumConceptos].lCodCiclFact    =stPreFactura.A_PFactura[lNroConcCB].lCodCiclFact    ;
            stPreFactura.A_PFactura[iNumConceptos].iCodConceRel    =0;
            stPreFactura.A_PFactura[iNumConceptos].lColumnaRel     =0;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szNumTerminal   ,stPreFactura.A_PFactura[lNroConcCB].szNumTerminal   );
            stPreFactura.A_PFactura[iNumConceptos].lCapCode        =stPreFactura.A_PFactura[lNroConcCB].lCapCode        ;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szNumSerieMec   ,stPreFactura.A_PFactura[lNroConcCB].szNumSerieMec   );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szNumSerieLe    ,stPreFactura.A_PFactura[lNroConcCB].szNumSerieLe    );
            stPreFactura.A_PFactura[iNumConceptos].iFlagImpues     =stPreFactura.A_PFactura[lNroConcCB].iFlagImpues     ;
            stPreFactura.A_PFactura[iNumConceptos].iFlagDto        =stPreFactura.A_PFactura[lNroConcCB].iFlagDto        ;
            stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto    =stPreFactura.A_PFactura[lNroConcCB].fPrcImpuesto    ;
            stPreFactura.A_PFactura[iNumConceptos].dValDto         =stPreFactura.A_PFactura[lNroConcCB].dValDto         ;
            stPreFactura.A_PFactura[iNumConceptos].iTipDto         =stPreFactura.A_PFactura[lNroConcCB].iTipDto         ;
            stPreFactura.A_PFactura[iNumConceptos].lNumVenta       =stPreFactura.A_PFactura[lNroConcCB].lNumVenta       ;

            stPreFactura.A_PFactura[iNumConceptos].lNumTransaccion =stPreFactura.A_PFactura[lNroConcCB].lNumTransaccion ;
            stPreFactura.A_PFactura[iNumConceptos].lNumCargo       =stPreFactura.A_PFactura[lNroConcCB].lNumCargo       ;
            stPreFactura.A_PFactura[iNumConceptos].iMesGarantia    =stPreFactura.A_PFactura[lNroConcCB].iMesGarantia    ;

    strcpy( stPreFactura.A_PFactura[iNumConceptos].szNumGuia       ,stPreFactura.A_PFactura[lNroConcCB].szNumGuia       );
                                                                                                       
            stPreFactura.A_PFactura[iNumConceptos].iIndAlta        =stPreFactura.A_PFactura[lNroConcCB].iIndAlta        ;
            stPreFactura.A_PFactura[iNumConceptos].iIndSuperTel    =stPreFactura.A_PFactura[lNroConcCB].iIndSuperTel    ;
            stPreFactura.A_PFactura[iNumConceptos].iNumPaquete     =stPreFactura.A_PFactura[lNroConcCB].iNumPaquete     ;
            stPreFactura.A_PFactura[iNumConceptos].iIndCuota       =stPreFactura.A_PFactura[lNroConcCB].iIndCuota       ;
            stPreFactura.A_PFactura[iNumConceptos].lSeqCuotas      =stPreFactura.A_PFactura[lNroConcCB].lSeqCuotas      ;
            stPreFactura.A_PFactura[iNumConceptos].iNumCuotas      =stPreFactura.A_PFactura[lNroConcCB].iNumCuotas      ;
            stPreFactura.A_PFactura[iNumConceptos].iOrdCuota       =stPreFactura.A_PFactura[lNroConcCB].iOrdCuota       ;
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodCuota      ,stPreFactura.A_PFactura[lNroConcCB].szCodCuota      );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szFecVenta      ,stPreFactura.A_PFactura[lNroConcCB].szFecVenta      );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodPlanTarif  ,stPreFactura.A_PFactura[lNroConcCB].szCodPlanTarif  );
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szCodCargoBasico,stPreFactura.A_PFactura[lNroConcCB].szCodCargoBasico);
    strcpy( stPreFactura.A_PFactura[iNumConceptos].szTipPlanTarif  ,stPreFactura.A_PFactura[lNroConcCB].szTipPlanTarif  );
            stPreFactura.A_PFactura[iNumConceptos].bOptPenaliza    =stPreFactura.A_PFactura[lNroConcCB].bOptPenaliza    ;
            stPreFactura.A_PFactura[iNumConceptos].bOptCargos      =stPreFactura.A_PFactura[lNroConcCB].bOptCargos      ;
            stPreFactura.A_PFactura[iNumConceptos].bOptServicios   =stPreFactura.A_PFactura[lNroConcCB].bOptServicios   ;
            stPreFactura.A_PFactura[iNumConceptos].bOptAbonos      =stPreFactura.A_PFactura[lNroConcCB].bOptAbonos      ;
            stPreFactura.A_PFactura[iNumConceptos].bOptTrafico     =stPreFactura.A_PFactura[lNroConcCB].bOptTrafico     ;
            stPreFactura.A_PFactura[iNumConceptos].bOptCuotas      =stPreFactura.A_PFactura[lNroConcCB].bOptCuotas      ;
            stPreFactura.A_PFactura[iNumConceptos].bOptDescuento   =stPreFactura.A_PFactura[lNroConcCB].bOptDescuento   ;
            stPreFactura.A_PFactura[iNumConceptos].bOptImpuesto    =stPreFactura.A_PFactura[lNroConcCB].bOptImpuesto    ;
            stPreFactura.A_PFactura[iNumConceptos].bOptArriendo    =stPreFactura.A_PFactura[lNroConcCB].bOptArriendo    ;

    /* stPreFactura.iNumRegistros++; */
    if(bfnIncrementarIndicePreFactura()==FALSE)
    {
	vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
	return FALSE;
    }

    return (TRUE);
}

/*****************************************************************************/
/* bfnRebajaCargoBasico : Deja en 0 el concepto de Cargo basico              */
/*                                                                           */
/*****************************************************************************/
BOOL bfnRebajaCargoBasico(int iNroCpto)
{
    vDTrazasLog (modulo,"\n\t\t\tEntrada en bfnRebajaCargoBasico"
                        "\n\t\t\t=> Pos. Abonado [%ld] "
                        ,LOG05,iNroCpto);

    stPreFactura.A_PFactura[iNroCpto].dImpConcepto    =0;
    stPreFactura.A_PFactura[iNroCpto].dImpMontoBase   =0;
    stPreFactura.A_PFactura[iNroCpto].dImpFacturable  =0;
    return (TRUE);
}

/*****************************************************************************/
/* bBuscaCodTraficoLocal : Funcion que verifica que el ind_tabla sea = 1 para*/
/*                        un codigo de concepto,en pstTaConcepFact.          */
/*****************************************************************************/
BOOL bBuscaCodTraficoLocal (int iCodConcepto)
{
    long lCont;


/*    TACONCEPFACT  stkey                   ;
    TACONCEPFACT  *pConcepto= (TACONCEPFACT *)NULL;

    memset (&stkey, 0, sizeof (TACONCEPFACT));

    stkey.iCodFacturacion= iCodConcepto;

    if ((pConcepto = (TACONCEPFACT *)bsearch (&stkey, pstTaConcepFact, NUM_TACONCEPFACT,
                            sizeof (TACONCEPFACT), ifnCmpCodConcep))==(TACONCEPFACT *)NULL)
    {
        vDTrazasError(modulo,"\t\tBusqueda binaria en pstTaConcepFact ",LOG01);
        return (FALSE);
    }
    else
    {
        if (pConcepto->iIndTabla==1)
        {
            return (TRUE);
        }
    }
    return (FALSE);
*/

    vDTrazasLog (modulo,"\t\t\tEntrada en bBuscaCodTraficoLocal \n"
                        "\t\t\t=> Cod.Concepto [%d] "
                        ,LOG05,iCodConcepto);

    for (lCont=0;lCont < NUM_TACONCEPFACT ;lCont++)
    {
        if (iCodConcepto== pstTaConcepFact[lCont].iCodFacturacion)
        {
            if (pstTaConcepFact[lCont].iIndTabla==1)
            {
                return (TRUE);
            }
            return (FALSE);
        }
    }
    return (FALSE);

}/********************** Final bBuscaCodTraficoLocal *************************/


/*****************************************************************************/
/* ifnCmpCodConcep : Funcion para la busqueda binaria de codigo de conceptos */
/*                  en pstTaConcepFact.                                      */
/*****************************************************************************/
int ifnCmpCodConcep(const void* cad1,const void* cad2)
{
    return (
           (((TACONCEPFACT *)cad1)->iCodFacturacion < ((TACONCEPFACT *)cad2)->iCodFacturacion) ?-1:
           (((TACONCEPFACT *)cad1)->iCodFacturacion == ((TACONCEPFACT *)cad2)->iCodFacturacion) ?0:1);

}/************************ Final ifnCmpCodConcep *****************************/



/*****************************************************************************/
/* bfnValidaPlanTarifMFF : Valida que el plan tarifario entregado posea el   */
/*                         indicador "P" en el campo "Ind_Francons"          */
/*****************************************************************************/
BOOL bfnValidaPlanTarifMFF (char *szPlanTarif)
{
    long x;
    vDTrazasLog (modulo,"\t\t\tEntrada en bfnValidaPlanTarifMFF [%s] "
                        ,LOG05,szPlanTarif);

    for (x=0;x<NUM_PLANTARIF;x++)
    {
        if (strcmp(szPlanTarif,pstPlanTarif[x].szCodPlanTarif) == 0 )
        {
            if (strcmp(pstPlanTarif[x].szInd_Francons,"P")== 0)
            {
                return (TRUE);
            }
            return (FALSE);
        }
    }
    return (FALSE);
}

/*****************************************************************************/
/* bfnGetConcParam : Devuelve el concepto y su descripcion de la tabla de    */
/*                   parametros                                              */
/*****************************************************************************/
BOOL bfnGetConcParam (long lCodParametro, int *iCodConcep, char *szDesConcep)
{
 /* EXEC SQL BEGIN DECLARE SECTION; */ 

    long lhCodParametro = 0;
    int  ihCodConcep    = 0;
    char szhDesConcep  [1025] ; /* EXEC SQL VAR szhDesConcep  IS STRING (1025); */ 

 /* EXEC SQL END DECLARE SECTION; */ 


    lhCodParametro =lCodParametro;

    /* EXEC SQL
        SELECT VAL_NUMERICO, VAL_CARACTER
          INTO :ihCodConcep, :szhDesConcep
          FROM FAD_PARAMETROS
         WHERE COD_PARAMETRO= :lhCodParametro; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select VAL_NUMERICO ,VAL_CARACTER into :b0,:b1  from FAD_\
PARAMETROS where COD_PARAMETRO=:b2";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihCodConcep;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhDesConcep;
    sqlstm.sqhstl[1] = (unsigned long )1025;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodParametro;
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



    if (sqlca.sqlcode != SQLOK)
    {
        return (FALSE);
    }
    *iCodConcep=ihCodConcep;
    strcpy (szDesConcep, szhDesConcep);
    return (TRUE);
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

