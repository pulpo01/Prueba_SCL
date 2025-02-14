
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
    "./pc/imptoiva.pc"
};


static unsigned int sqlctx = 3458531;


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

 static const char *sq0005 = 
"select  /*+  index (GE_IMPUESTOS PK_GE_IMPUESTOS)  +*/ TO_CHAR(I.FEC_DESDE,'\
YYYYMMDDHH24MISS') ,I.COD_CONCGENE ,TO_CHAR(I.FEC_HASTA,'YYYYMMDDHH24MISS') ,I\
.PRC_IMPUESTO ,T.TIP_MONTO  from GE_IMPUESTOS I ,GE_TIPIMPUES T where (((((((I\
.COD_TIPIMPUES=T.COD_TIPIMPUE and I.COD_CATIMPOS=:b0) and I.COD_ZONAIMPO=DECOD\
E(I.COD_ZONAIMPO,0,0,:b1)) and I.COD_ZONAABON=DECODE(I.COD_ZONAABON,0,0,:b2)) \
and I.COD_GRPSERVI=:b3) and I.FEC_DESDE<=TO_DATE(:b4,'YYYYMMDDHH24MISS')) and \
I.FEC_HASTA>=TO_DATE(:b4,'YYYYMMDDHH24MISS')) and I.PRC_IMPUESTO<>0.0) order b\
y COD_CONCGENE,PRC_IMPUESTO            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,262,0,4,662,0,0,6,5,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
44,0,0,2,399,0,4,699,0,0,11,5,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
5,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
103,0,0,3,219,0,4,806,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
134,0,0,4,219,0,4,841,0,0,4,3,0,1,0,2,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
165,0,0,5,583,0,9,1157,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,
5,0,0,
204,0,0,5,0,0,13,1168,0,0,5,0,0,1,0,2,5,0,0,2,3,0,0,2,5,0,0,2,4,0,0,2,3,0,0,
239,0,0,5,0,0,15,1230,0,0,0,0,0,1,0,
254,0,0,6,106,0,6,1328,0,0,4,4,0,1,0,1,3,0,0,1,5,0,0,1,4,0,0,1,3,0,0,
285,0,0,7,421,0,4,2129,0,0,8,2,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,3,0,0,2,
3,0,0,1,3,0,0,1,5,0,0,
332,0,0,8,70,0,4,2178,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
355,0,0,9,699,0,4,3065,0,0,13,12,0,1,0,2,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,
1,5,0,0,1,5,0,0,1,3,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,
};


/****************************************************************************/
/*  Fichero    : imptoiva.pc                                                */
/*  Descripcion: funciones PROC para el calculo de impuestos                */
/*  Fecha      : 14-Nov-96                                                  */
/****************************************************************************/

#define _IMPTOIVA_PC_


#include <imptoiva.h>

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


void vFreeTotImpuestos (TOTIMPTOS*);

/****************************************************************************/
/*                          Variables globales                              */
/****************************************************************************/
static int    iNImptosT     ;

double roundd(double valor)
{
	if (valor > 0) 
	{
		return((double)(long)(valor+0.5));
	}
	else
	{
		return((double)(long)(valor-0.5));
	}
}

/******************************************************************************************/
/*  FUNCION     : bImtosIvaClienteGeneral                                                 */
/*  DESCRIPCION : Funcion que Aplica Impuestos a los Conceptos generados en un ciclo para */
/*                un Cliente.                                                             */
/******************************************************************************************/
BOOL bImptosIvaClienteGeneral (int iTipoFact)
{
    char  modulo[] = "bImptosIvaClienteGeneral";

    int      iNumRegIni        = 0 ;
    int      iInd              = 0 ;
    int      i                 = 0 ;
    int      iNImptos          = 0 ;
    int      iNumConceptos     = 0 ;
    int      iCodZonaImpos     = 0 ;
    int      iCodZonaAbon      = 0 ;
    int      iCodZonaAbon_Ant  = -1;
    int      iCodZonaImp       = 0;
    int      iCodGrpServi      = 0 ;
    int      iContadorAux      = -1;
    long     lCodUsuario       = 0 ;
    long     lCodUsuario_Ant   = -1;
    char     szCodRegion    [4]= "";
    char     szCodProvincia [6]= "";
    char     szCodCiudad    [6]= "";
    char     szCodComuna    [6]= "";
    char     szFecZonaImpo [15] = "";
    char     szFuncion     [20] = "";
    CONCEPTO stConcepto                     ;
    IMPTOS   stImpto = {0,(IMPUESTOS *)NULL};

    /* Acumula el total de los impuestos para el ajuste */
    TOTIMPTOS stTotImptos={0,(TOTIMPTO *)NULL};

    iNImptosT = 0;

    strcpy (stAnomProceso.szDesProceso, "Impuestos");

    switch (iTipoFact)
    {
        case FACT_CICLO      :
             strcpy (szFuncion,"CICLO")      ;
             break                           ;
        case FACT_CONTADO    :
             strcpy (szFuncion,"CONTADO")    ;
             break                           ;
        case FACT_BAJA       :
             strcpy (szFuncion,"BAJA")       ;
             break                           ;
        case FACT_LIQUIDACION:
             strcpy (szFuncion,"LIQUIDACION");
             break                           ;
        case FACT_RENTAPHONE  :
             strcpy (szFuncion,"RENT PHONE") ;
             break                           ;
        case FACT_COMPRA      :
             strcpy (szFuncion,"COMPRA")     ;
             break                           ;
        case FACT_MISCELAN    :
             strcpy (szFuncion,"MISCELAN")   ;
             break                           ;
        case FACT_ROAMINGVIS  :
             strcpy (szFuncion,"ROAMING VISITANTE");
             break                                 ;
        default               :
             break                           ;
    }
    vDTrazasLog (szExeName,"\n\t\t* IMPUESTOS %s\n\t\t=> Cliente [%ld]", LOG03,szFuncion,
                           stCliente.lCodCliente);

    /*********************************************************/
    strcpy (szFecZonaImpo, szGetFecZonaImp(stProceso.iCodTipDocum));
    if (strlen (szFecZonaImpo) == 0)
    {
        iDError (modulo,ERR040,vInsertarIncidencia);
        return FALSE;
    }

    if (!bfnEvalZonasImpos (szFecZonaImpo, iTipoFact, &iCodZonaImpos, pstParamGener.iIndZonaImpCic))
    {
        vDTrazasError(modulo,"\n\t** No se pueden evaluar Zonas Impositivas **",LOG01);
        vDTrazasLog  (modulo,"\n\t** No se pueden evaluar Zonas Impositivas **",LOG01);
        return FALSE;
    }
    /* Pasa a la prefactura el valor de la zona impositiva */
    stPreFactura.iCodZonaImpo=iCodZonaImpos;
    /* *************************************************** */

    iNumRegIni = stPreFactura.iNumRegistros;

    for (i=0;i<iNumRegIni;i++)
    {
        if (stPreFactura.A_PFactura[i].iCodTipConce  != IMPUESTO &&
            stPreFactura.A_PFactura[i].iCodTipConce  != CARRIER )
        {
            if (!bGetGrupoServicios (stPreFactura.A_PFactura[i].iCodConcepto,
                                     &iCodGrpServi, szFecZonaImpo,iTipoFact))
            {
                 return FALSE;
            }
            
            if (iCodGrpServi == ORA_NULL)
            {
                vDTrazasLog(modulo, "\n\t\t* Concepto [%d] NO tiene Grupo Servicios Asociado"
                                  , LOG04,stPreFactura.A_PFactura[i].iCodConcepto);
                continue;
            }
            
            if (iTipoFact == FACT_MISCELAN || stPreFactura.A_PFactura[i].lNumAbonado == 0 
                                           || stPreFactura.A_PFactura[i].lNumAbonado == -1)
            {
                iCodZonaAbon=iCodZonaImpos;
            }
            else
            {
            /***************************************************************/
                if (!bfnGetDirAbonado (stPreFactura.A_PFactura[i].lNumAbonado,
                                       szCodRegion, szCodProvincia, szCodCiudad, 
                                       szCodComuna, &lCodUsuario, &iCodZonaImp))
                {
                    return FALSE;
                }
                else
                {
                    /* if cod usuario es igual al anterior, asume zona anterior sino busca nuevamente */
                    /* Obtiene  la zona impositiva del abonado */
                    if (lCodUsuario_Ant==lCodUsuario)
                    {
                        iCodZonaAbon=iCodZonaAbon_Ant;
                    }
                    else
                    {
                        if (!bGetZonaImpositiva (szCodRegion   ,
                                 szCodProvincia,
                                 szCodCiudad   ,
                                 &iCodZonaAbon, szFecZonaImpo, iTipoFact))
                        {
                            vDTrazasError(modulo,"\n\t** No se puede obtener Zona Impositiva Abonado **",LOG01);
                            vDTrazasLog  (modulo,"\n\t** No se puede obtener Zona Impositiva Abonado **",LOG01);
                                return FALSE;
                        }
                        else
                        {
                            iCodZonaAbon_Ant=iCodZonaAbon;
                        }/*if encuentra zonaAbon*/
                    }/* if usuario es el mismo anterior*/
                    lCodUsuario_Ant=lCodUsuario;
                }/* if encuentra direccion de Abonado */
            } /*fact miscelanea*/

            /* *************************************************** */
            if (!bGetImpuestos (stCliente.iCodCatImpos, iCodZonaImpos,iCodZonaAbon, iCodGrpServi ,
                              szFecZonaImpo,&stImpto, iTipoFact))
            {
                vFreeImpuestos(&stImpto);
                return FALSE;
            }

            vDTrazasLog (modulo, "\n\t\t* Aplica Iva "
                                 "\n\t\t=> Cod.TipConce       [%d]"
                                 "\n\t\t=> Ind.Factur         [%d]"
                                 "\n\t\t=> Zona Impositiva    [%d]"
                                 "\n\t\t=> Grupo Servicios    [%d]"
                                 "\n\t\t=> Numero de Impuestos[%d]"
                                 "\n\t\t=> Concepto           [%d]"
                               , LOG05
                               , stPreFactura.A_PFactura[i].iCodTipConce 
                               , stPreFactura.A_PFactura[i].iIndFactur   
                               , iCodZonaImpos, iCodGrpServi, stImpto.iNumImpuestos
                               , stPreFactura.A_PFactura[i].iCodConcepto);
                               
            iContadorAux = -1;
            
            for (iInd=0;iInd<stImpto.iNumImpuestos;iInd++)
            {
                iNumConceptos = stPreFactura.iNumRegistros;

                if (!bCalculaImptos (i,stImpto.pImpuestos[iInd]))
                {
                    vFreeImpuestos(&stImpto);
                    return FALSE;
                }

                stPreFactura.A_PFactura[iNumConceptos].iCodConcepto = stImpto.pImpuestos [iInd].iCodConcGene ;

                memset (&stConcepto,0,sizeof(CONCEPTO));

                if (!bFindConcepto (stImpto.pImpuestos[iInd].iCodConcGene,
                               &stConcepto))
                {
                    vFreeImpuestos(&stImpto);
                    return FALSE;
                }

                strcpy (stPreFactura.A_PFactura[iNumConceptos].szDesConcepto ,
                    stConcepto.szDesConcepto);

                if (!bfnAplicaImpto(i, iNumConceptos, iTipoFact))
                {
                    vDTrazasError(modulo,"\n\t** ERROR, en creacion del concepto de Impto. **",LOG01);
                    vFreeImpuestos(&stImpto);
                    return (FALSE);
                }

                stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto = stImpto.pImpuestos[iInd].fPrcImpuesto;

                stPreFactura.A_PFactura[iNumConceptos].iCodZonaAbon=iCodZonaAbon;
                
                vDTrazasLog (modulo, "\n\t\t SUMATORIA IMP_FACT_CON_IVA \n"
                                       "\t\t ========================== \n"
                                       "\t\t (i)                           => [%d]\n"
                                       "\t\t dImpFactConIva (i)            => [%f]\n"
                                       "\t\t (iNumConceptos)               => [%d]\n"
                                       "\t\t dImpFacturable (i)            => [%f]\n"
                                       "\t\t dImpConcepto (i)              => [%f]\n"                                       
                                       "\t\t dImpFacturable (iNumConceptos)=> [%f]\n"
                                   , LOG06
                                   , i                                
                                   , stPreFactura.A_PFactura[i].dImpFactConIva
                                   , iNumConceptos
                                   , stPreFactura.A_PFactura[i].dImpFacturable
                                   , stPreFactura.A_PFactura[i].dImpConcepto  /* P-MIX-09003 77 */    
                                   , stPreFactura.A_PFactura[iNumConceptos].dImpFacturable ); /* P-MIX-09003 77 */                                  
                
                if (iContadorAux == -1)
                {
                    stPreFactura.A_PFactura[i].dImpFactConIva = stPreFactura.A_PFactura[i].dImpFacturable + 
                                                                stPreFactura.A_PFactura[iNumConceptos].dImpFacturable; /* P-MIX-09003 77 */
                    iContadorAux = i;                                                                
                }
                else
                {
                    if (iContadorAux == i)
                    {
                        stPreFactura.A_PFactura[i].dImpFactConIva = stPreFactura.A_PFactura[i].dImpFactConIva + 
                                                                    stPreFactura.A_PFactura[iNumConceptos].dImpFacturable; /* P-MIX-09003 77 */                    	
                    }                    
                }
                                                            
                vDTrazasLog (modulo, "\n\t\t SUMA IMP_FACT_CON_IVA \n"
                                       "\t\t ========================== \n"
                                       "\t\t dImpFactConIva (i) => [%f]\n"
                                   , LOG06
                                   , stPreFactura.A_PFactura[i].dImpFactConIva ); /* P-MIX-09003 77 */                                                            

                if (!bfnAcumTotImptos (&stTotImptos
                        ,stPreFactura.A_PFactura[i].iCodConcepto
                        ,stPreFactura.A_PFactura[iNumConceptos].iCodConcepto
                        ,stPreFactura.A_PFactura[i].dImpFacturable
                        ,stPreFactura.A_PFactura[iNumConceptos].dImpFacturable
                        ,stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto
                        ,stImpto.pImpuestos[iInd].iTipMonto))
                {
                    vDTrazasError(modulo,"\n\t**  Error en acumulacion de Impuestos **",LOG01);
                    vFreeTotImpuestos(&stTotImptos);
                    vFreeImpuestos(&stImpto);
                    return (FALSE);
                }
                iNImptos++;

                if (stPreFactura.A_PFactura[i].iIndCuota == IND_CUOTA &&
                        iTipoFact == FACT_CONTADO)
                {
                    if (stPreFactura.A_PFactura[i].iCodTipConce == ARTICULO)
                    {
                        if(!bGeneraCuotas(stPreFactura.A_PFactura[i].lNumCargo      ,
                                      stPreFactura.A_PFactura[i].szCodCuota     ,
                                      stImpto.pImpuestos[iInd].fPrcImpuesto     ,
                                      stPreFactura.A_PFactura[i].iCodConcepto   ))
                        {
                            vFreeTotImpuestos(&stTotImptos);
                            vFreeImpuestos(&stImpto);
                            return FALSE;
                        }
                    }
                }

            }/* fin for->iInd */

            vDTrazasLog (modulo, "\n\t\tImpuestos aplicados al concepto %d del cliente %ld\n"
                               , LOG04,stPreFactura.A_PFactura[i].iCodConcepto
                               , stPreFactura.A_PFactura[i].lCodCliente );
            vFreeImpuestos(&stImpto);

            iNImptosT += iNImptos;

        }/* fin if Imptos y Carrier */

    }/* fin for i<iNumRegIni */

/******************************************************/
/* Codigo para guardar Zona Impositiva del Abonado     */
/******************************************************/
    if(stPreFactura.iNumRegistros > 0)
    {
        if (!bfnRegZonaAbon(iNumRegIni))
        {
            vDTrazasError(modulo,"\n\t**  Error en proceso bfnRegZonaAbon **",LOG01);
            return (FALSE);
        }
    }
/******************************************************/

/******************************************************/
/* Codigo para realizacion de ajuste de IVA.          */
/******************************************************/
    vDTrazasLog (modulo,"\n\t\t# stPreFactura.iNumRegistros [%d] entrada a bfnAjusteImptos\n",LOG04,stPreFactura.iNumRegistros);
    if(stPreFactura.iNumRegistros > 0)
    {
        if (!bfnAjusteImptos(&stTotImptos))
        {
            vDTrazasError(modulo,"\n\t**  Error en proceso de Ajuste de Impuestos **",LOG01);
            vFreeTotImpuestos(&stTotImptos);
            return (FALSE);
        }
    }

    vDTrazasLog (modulo,"\n\t\t# Cliente [%ld] => Impuestos Aplicados [%d]\n",
                LOG03,stCliente.lCodCliente,iNImptos);

/******************************************************/
/* Codigo Aplicar descuento a impuesto IEPS           */
/******************************************************/

    if ( pstFadParam.iConcDctoIEPS != 0 && pstFadParam.iConcIEPS != 0)
    {
        if (!bfnProcDctoIEPS (iTipoFact))
        {
            vDTrazasError(modulo,"\n\t** Error Aplicacion de Dscto. a Impuesto IEPS  **",LOG01);
            vFreeTotImpuestos(&stTotImptos);
            return (FALSE);
        }
    }



/******************************************************
 * Impuesto al documento (Maicao)
 ******************************************************/
    if (!bfnProcImptoMaicao (iTipoFact, szFecZonaImpo))
    {
        vDTrazasError(modulo,"\n\t** Error Aplicacion de Impuesto Maicao. **",LOG01);
        vFreeTotImpuestos(&stTotImptos);
        return (FALSE);
    }

/******************************************************/

    vFreeTotImpuestos(&stTotImptos);

 return TRUE;
}/************************** Final bImptosIvaClienteGeneral ****************************/


/*****************************************************************************/
/*                             funcion : bImptosIvaNotas                     */
/* -Funcion que Aplica Impuestos (recogidos en la tabla Fa_HistConc que son  */
/*  en este caso los conceptos Impuestos que se aplicaron a los Conceptos de */
/*  la factura modificada por la Nota que Emitimos. Todos estos Conceptos Im-*/
/*  puestos estan recogidos en la estructura stNota.A_HistConc y los Concep- */
/*  tos sobre los que se aplican se recogen en stPreFactura.A_PFactura.      */
/* -Observacion :                                                            */
/*            * Dos formas de Aplicar Impuestos :                            */
/*              1.- Apartir del fPrcImpuesto de stNota.A_HistConc            */
/*              2.- Apartir de la Categoria Impositiva del Cliente           */
/*            * Hay que tener en cuenta que el Concepto no sea una Cuota a la*/
/*              cual no se le aplican Impuestos, y ademas que el Concepto so-*/
/*              bre el cual se aplica el Impuesto, en el momento de generar  */
/*              la factura que se modifica con la nota se le aplicaron im-   */
/*              puesto (esto viene indicado por el Campo FlagImpuesto = 1).  */
/*                                                                           */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
BOOL bImptosIvaNotas (int iTipoFact)
{
char  modulo[] = "bImptosIvaNotas";

  int  iNumRegIni    = 0;
  int  iInd          = 0;
  int  i             = 0;
  int  iNumConceptos = 0;
  int  iNImptos      = 0;
  int  iCodZonaImpos = 0;
  int  iCodZonaAbon  = 0;
  int  iCodGrpServi  = 0;

  IMPTOS   stImpto = {0,(IMPUESTOS *)NULL};
  char     szFecZonaImpo [15]=""          ;
  CONCEPTO stConcepto                     ;

    /* Acumula el total de los impuestos para el ajuste */
    TOTIMPTOS stTotImptos={0,(TOTIMPTO *)NULL};

    if (iTipoFact == FACT_NOTACRED)
        vDTrazasLog (szExeName,"\n\t\t* IMPUESTOS NOTA CREDITO\n"
                               "\t\t=> Cliente [%ld]\n",LOG03,
                               stCliente.lCodCliente);
    else if (iTipoFact == FACT_NOTADEBI)
        vDTrazasLog (szExeName,"\n\t\t* IMPUESTOS NOTA DEBITO \n"
                               "\t\t=> Cliente [%ld]\n",LOG03,
                               stCliente.lCodCliente);
    vDTrazasLog(szExeName,
              "\n\t\t* Categoria Impositiva del Cliente [%d]",
              LOG03,stCliente.iCodCatImpos);

    /* Obtiene parametro de minimo ajustable */

    strcpy (szFecZonaImpo,stNota.szFecEmision);
    iCodZonaImpos= stNota.iCodZonaImpo;
    stPreFactura.iCodZonaImpo=iCodZonaImpos;

    vDTrazasLog (modulo,"\t\t* Zona Impositiva [%d] "
                        "\n\t\t* Fecha Zona Impositiva [%s] "
                        ,LOG06, iCodZonaImpos, szFecZonaImpo);

    iNumRegIni = stPreFactura.iNumRegistros;

    for (i=0;i<iNumRegIni;i++)
    {
        if (stPreFactura.A_PFactura[i].iFlagImpues   == 1         &&
            stPreFactura.A_PFactura[i].iCodTipConce  != IMPUESTO &&
            stPreFactura.A_PFactura[i].iIndCuota     <= 0        )
        {

            if (!bGetGrupoServicios (stPreFactura.A_PFactura[i].iCodConcepto,
                                     &iCodGrpServi,szFecZonaImpo,iTipoFact))
                 return FALSE;

            if (iCodGrpServi == ORA_NULL)
            {
                vDTrazasLog (modulo,
                      "\n\t\t* Concepto [%d] NO tiene Grupo Servicios Asociado",
                      LOG03,stPreFactura.A_PFactura[i].iCodConcepto);
                continue;
            }

        if (stPreFactura.A_PFactura[i].iCodZonaAbon == -1)
            iCodZonaAbon = iCodZonaImpos;
        else
            /* Se considera para los conceptos con abonado 0 la zona impositiva del Cliente. */
            /* iCodZonaAbon = stPreFactura.A_PFactura.iCodZonaAbon[i]; */
           if (stPreFactura.A_PFactura[i].lNumAbonado  == 0 && stPreFactura.A_PFactura[i].iCodZonaAbon == 0)
               iCodZonaAbon = iCodZonaImpos;
           else
              iCodZonaAbon = stPreFactura.A_PFactura[i].iCodZonaAbon;

        vDTrazasLog (modulo,    "\n\t\t* PGG Beta - iCodZonaAbon    [%i]\n"
                    ,LOG03
                        ,iCodZonaAbon);

            if (!bGetImpuestos (stCliente.iCodCatImpos, iCodZonaImpos,iCodZonaAbon, iCodGrpServi,
                                szFecZonaImpo,&stImpto, iTipoFact))
                {
                    vFreeImpuestos(&stImpto);
                    return FALSE;
                }
            vDTrazasLog (modulo,"\n\t\t* Grupo Servicios [%d]"
                                "\n\t\t* Numero de Impuestos = [%d]",LOG06
                                ,iCodGrpServi,stImpto.iNumImpuestos);

            for (iInd=0;iInd<stImpto.iNumImpuestos;iInd++)
            {
                iNumConceptos = stPreFactura.iNumRegistros;

                if (!bCalculaImptos (i,stImpto.pImpuestos[iInd]))
                {
                     vFreeImpuestos(&stImpto);
                     return FALSE;
                }

                stPreFactura.A_PFactura[iNumConceptos].iCodConcepto =
                                   stImpto.pImpuestos[iInd].iCodConcGene  ;
                memset (&stConcepto,0,sizeof(CONCEPTO))                   ;

                if (!bFindConcepto (stImpto.pImpuestos[iInd].iCodConcGene, &stConcepto))
                {
                        vFreeImpuestos(&stImpto);
                        return FALSE;
                }
                strcpy(stPreFactura.A_PFactura[iNumConceptos].szDesConcepto,
                       stConcepto.szDesConcepto);

                if (!bGetMaxColPreFa
                     (stPreFactura.A_PFactura[iNumConceptos].iCodConcepto,
                      &stPreFactura.A_PFactura[iNumConceptos].lColumna ))
                {
                vFreeImpuestos(&stImpto);
                return FALSE;
                }
                if (!bfnAplicaImpto(i, iNumConceptos, iTipoFact))
                {
                    vFreeImpuestos(&stImpto);
                    vDTrazasError(modulo,"\n\t** ERROR, en cracion del concepto de Impto. **",LOG01);
                    return (FALSE);
                }

                strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecValor ,
                       stPreFactura.A_PFactura[i].szFecValor );

                strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecEfectividad,
                       stPreFactura.A_PFactura[i].szFecValor );

                stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto = stImpto.pImpuestos[iInd].fPrcImpuesto;              

                if (!bfnAcumTotImptos (&stTotImptos
                            ,stPreFactura.A_PFactura[i].iCodConcepto
                            ,stPreFactura.A_PFactura[iNumConceptos].iCodConcepto
                            ,stPreFactura.A_PFactura[i].dImpFacturable
                            ,stPreFactura.A_PFactura[iNumConceptos].dImpFacturable
                            ,stPreFactura.A_PFactura[iNumConceptos].fPrcImpuesto
                            ,stImpto.pImpuestos[iInd].iTipMonto))
                {
                    vDTrazasError(modulo,"\n\t**  Error en acumulacion de Impuestos **",LOG01);
            vFreeImpuestos(&stImpto);
            vFreeTotImpuestos(&stTotImptos);
            return (FALSE);
                }
                iNImptos++                  ;
            }/* fin for->iInd */
        } /* fin if Condiciones ... */

        vDTrazasLog (modulo,"\n\t\t[%d]Impuestos aplicados al concepto [%d] del cliente [%ld]\n",
                    LOG06,iNImptos,stPreFactura.A_PFactura[i].iCodConcepto, stPreFactura.A_PFactura[i].lCodCliente );
        vFreeImpuestos(&stImpto);
        iNImptosT += iNImptos;

    }/* fin for i<iNumRegIni */
/******************************************************/
/* Codigo para guardar Zona Impositiva del Abonado     */
/******************************************************/
    if(stPreFactura.iNumRegistros > 0)
    {
        if (!bfnRegZonaAbon(iNumRegIni))
        {
            vDTrazasError(modulo,"\n\t**  Error en proceso bfnRegZonaAbon **",LOG01);
            return (FALSE);
        }
    }
/******************************************************/
/******************************************************/
/* Codigo para realizacion de ajuste de IVA.          */
/******************************************************/
    if(stPreFactura.iNumRegistros > 0)
    {
        if (!bfnAjusteImptos(&stTotImptos))
        {
            vDTrazasError(modulo,"\n\t**  Error en proceso de Ajuste de Impuestos **",LOG01);
            vFreeTotImpuestos(&stTotImptos);
            return (FALSE);
        }
    }
/******************************************************/

/******************************************************/
/* Codigo Aplicar descuento a impuesto IEPS           */
/******************************************************/
    if ( pstFadParam.iConcDctoIEPS != 0 && pstFadParam.iConcIEPS != 0)
    {
        if (!bfnProcDctoIEPSNC (iTipoFact))
        {
            vDTrazasError(modulo,"\n\t** Error Aplicacion de Dcto. a Impuesto IEPS  **",LOG01);
                vFreeTotImpuestos(&stTotImptos);
                return (FALSE);
        }
    }


/******************************************************/
/* Aplicacion de impuesto al documento Maicao         */
/******************************************************/
    if (!bfnProcImptoMaicao (iTipoFact, szFecZonaImpo))
    {
        vDTrazasError(modulo,"\n\t** Error Aplicacion de Impuesto Maicao. **",LOG01);
        vFreeTotImpuestos(&stTotImptos);
        return (FALSE);
    }

    vDTrazasLog (szExeName,"\n\t\t* Cliente [%ld] => Impuestos Aplicados [%d]\n",
               LOG03,stCliente.lCodCliente,iNImptosT);
    vFreeTotImpuestos(&stTotImptos);
    return TRUE;
}/**************************** Final bImptosIvaNotas *************************/


/*****************************************************************************/
/*                          funcion : bGetZonaImpositiva                     */
/* -Busca la Zona Impositiva (iCodZonaimpo) en memoria (ZONACIUDAD *),que es */
/*  cargada en el modulo con los reg. de la tabla GE_ZONACIUDAD              */
/* -Entrada szCodMunicipio, piCodZonaimpo, szFecZonaimpo                     */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
BOOL bGetZonaImpositiva ( char *szCodRegion   ,
                          char *szCodProvincia,
                          char *szCodCiudad   ,
                          int  *piCodZonaImpo ,
                          char *szFecZonaImpo ,
                          int  iTipoFact)
{
    ZONACIUDAD stZonaCiudad;
    BOOL bRes = TRUE       ;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static char  szhCodRegion    [4]; /* EXEC SQL VAR szhCodRegion    IS STRING(4) ; */ 

         static char  szhCodProvincia [6]; /* EXEC SQL VAR szhCodProvincia IS STRING(6) ; */ 

         static char  szhCodCiudad    [6]; /* EXEC SQL VAR szhCodCiudad    IS STRING(6) ; */ 

         static char  szhFecDesde     [15]; /* EXEC SQL VAR szhFecDesde     IS STRING(15); */ 

         static char  szhFecHasta     [15]; /* EXEC SQL VAR szhFecHasta     IS STRING(15); */ 

         static int    ihCodZonaImpo  ;
   /* EXEC SQL END DECLARE SECTION  ; */ 


   memset (&stZonaCiudad,0,sizeof(ZONACIUDAD));

   vDTrazasLog (szExeName, "\n\t\t* Parametros Entrada bGetZonaImpositiva\n"
                           "\t\t=>Cod.Region   [%s]\n"
                           "\t\t=>Cod.Provincia[%s]\n"
                           "\t\t=>Cod.Ciudad   [%s]\n"
                           "\t\t=>Fecha        [%s]\n"
                         , LOG05,szCodRegion,szCodProvincia,szCodCiudad,szFecZonaImpo);

   if (iTipoFact == FACT_CICLO)
   {
       strcpy (stZonaCiudad.szCodRegion   ,szCodRegion)   ;
       strcpy (stZonaCiudad.szCodProvincia,szCodProvincia);
       strcpy (stZonaCiudad.szCodCiudad   ,szCodCiudad)   ;

       if (!bFindZonaCiudad (szCodRegion,szCodProvincia,
                             szCodCiudad,szFecZonaImpo,piCodZonaImpo))
       {
            /* Si no lo encontramos en memoria buscamos en tabla */
            /* EXEC SQL SELECT /o+ index (GE_ZONACIUDAD PK_GE_ZONACIUDAD) o/
                            COD_ZONAIMPO
                     INTO   :ihCodZonaImpo
                     FROM   GE_ZONACIUDAD
                     WHERE  COD_REGION    = :szCodRegion
                       AND  COD_PROVINCIA = :szCodProvincia
                       AND  COD_CIUDAD    = :szCodCiudad
                       AND  FEC_DESDE    <= TO_DATE(:szFecZonaImpo,'YYYYMMDDHH24MISS')
                       AND  FEC_HASTA    >= TO_DATE(:szFecZonaImpo,'YYYYMMDDHH24MISS'); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 6;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select  /*+  index (GE_ZONACIUDAD PK_GE_ZONACIUDA\
D)  +*/ COD_ZONAIMPO into :b0  from GE_ZONACIUDAD where ((((COD_REGION=:b1 and\
 COD_PROVINCIA=:b2) and COD_CIUDAD=:b3) and FEC_DESDE<=TO_DATE(:b4,'YYYYMMDDHH\
24MISS')) and FEC_HASTA>=TO_DATE(:b4,'YYYYMMDDHH24MISS'))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )5;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihCodZonaImpo;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szCodRegion;
            sqlstm.sqhstl[1] = (unsigned long )0;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szCodProvincia;
            sqlstm.sqhstl[2] = (unsigned long )0;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szCodCiudad;
            sqlstm.sqhstl[3] = (unsigned long )0;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szFecZonaImpo;
            sqlstm.sqhstl[4] = (unsigned long )0;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szFecZonaImpo;
            sqlstm.sqhstl[5] = (unsigned long )0;
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
                iDError (szExeName,ERR000,vInsertarIncidencia,"Ge_ZonaCiudad",
                         szfnORAerror())               ;
                strncpy (stAnomProceso.szObsAnomalia,
                         "No se encontraron Datos en"\
                         " Ge_ZonaCiudad ",sizeof(stAnomProceso.szObsAnomalia));
                bRes = FALSE;
            }
            else
            {
                strcpy (stZonaCiudad.szFecDesde     , szhFecDesde    );
                strcpy (stZonaCiudad.szFecHasta     , szhFecHasta    );
                strcpy (stZonaCiudad.szCodRegion    ,szhCodRegion    );
                strcpy (stZonaCiudad.szCodProvincia , szhCodProvincia);
                strcpy (stZonaCiudad.szCodCiudad    ,szhCodCiudad    );

                *piCodZonaImpo = ihCodZonaImpo           ;
                stZonaCiudad.iCodZonaImpo = ihCodZonaImpo;

                if (!bAddZonaCiudad (&stZonaCiudad))
                     bRes = FALSE;
            }
        }
    }
    else
    {
        /* EXEC SQL SELECT /o+ index (GE_ZONACIUDAD PK_GE_ZONACIUDAD) o/
                        COD_ZONAIMPO                           ,
                        TO_CHAR (FEC_DESDE, 'YYYYMMDDHH24MISS'),
                        TO_CHAR (FEC_HASTA, 'YYYYMMDDHH24MISS'),
                        COD_REGION                             ,
                        COD_PROVINCIA                          ,
                        COD_CIUDAD
                   INTO :ihCodZonaImpo  ,
                        :szhFecDesde    ,
                        :szhFecHasta    ,
                        :szhCodRegion   ,
                        :szhCodProvincia,
                        :szhCodCiudad
                   FROM GE_ZONACIUDAD
                  WHERE COD_REGION    = :szCodRegion
                    AND COD_PROVINCIA = :szCodProvincia
                    AND COD_CIUDAD    = :szCodCiudad
                    AND FEC_DESDE <=TO_DATE(:szFecZonaImpo,'YYYYMMDDHH24MISS')
                    AND FEC_HASTA >=TO_DATE(:szFecZonaImpo,'YYYYMMDDHH24MISS'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select  /*+  index (GE_ZONACIUDAD PK_GE_ZONACIUDAD)  \
+*/ COD_ZONAIMPO ,TO_CHAR(FEC_DESDE,'YYYYMMDDHH24MISS') ,TO_CHAR(FEC_HASTA,'YY\
YYMMDDHH24MISS') ,COD_REGION ,COD_PROVINCIA ,COD_CIUDAD into :b0,:b1,:b2,:b3,:\
b4,:b5  from GE_ZONACIUDAD where ((((COD_REGION=:b6 and COD_PROVINCIA=:b7) and\
 COD_CIUDAD=:b8) and FEC_DESDE<=TO_DATE(:b9,'YYYYMMDDHH24MISS')) and FEC_HASTA\
>=TO_DATE(:b9,'YYYYMMDDHH24MISS'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )44;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodZonaImpo;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[1] = (unsigned long )15;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhCodRegion;
        sqlstm.sqhstl[3] = (unsigned long )4;
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhCodProvincia;
        sqlstm.sqhstl[4] = (unsigned long )6;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodCiudad;
        sqlstm.sqhstl[5] = (unsigned long )6;
        sqlstm.sqhsts[5] = (         int  )0;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)szCodRegion;
        sqlstm.sqhstl[6] = (unsigned long )0;
        sqlstm.sqhsts[6] = (         int  )0;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)szCodProvincia;
        sqlstm.sqhstl[7] = (unsigned long )0;
        sqlstm.sqhsts[7] = (         int  )0;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)szCodCiudad;
        sqlstm.sqhstl[8] = (unsigned long )0;
        sqlstm.sqhsts[8] = (         int  )0;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)szFecZonaImpo;
        sqlstm.sqhstl[9] = (unsigned long )0;
        sqlstm.sqhsts[9] = (         int  )0;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)szFecZonaImpo;
        sqlstm.sqhstl[10] = (unsigned long )0;
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
            iDError (szExeName,ERR000,vInsertarIncidencia,"Ge_ZonaCiudad",
                     szfnORAerror())               ;
            strncpy (stAnomProceso.szObsAnomalia,
                         "No se encontraron Datos en"\
                         " Ge_ZonaCiudad ",sizeof(stAnomProceso.szObsAnomalia));
            bRes = FALSE;
        }
        else
        {
            *piCodZonaImpo = ihCodZonaImpo;
        }
   }
   return (bRes);
}/************************** Final bGetZonaImpositiva ************************/

/*****************************************************************************/
/*                           funcion : bAddZonaCiudad                        */
/* -Funcion que inserta en memoria (ZONACIUDAD* pstZonaCiudad)reg. y aumenta */
/*  en uno el numero de reg. cargados de GE_ZONACIUDAD en (NUM_ZONACIUDAD+1) */
/*  ambos datos son globales al modulo                                       */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
static BOOL bAddZonaCiudad (ZONACIUDAD* pZona)
{
  BOOL bRes = TRUE;

  if (NUM_ZONACIUDAD >= MAX_ZONACIUDAD)
  {
      vDTrazasLog (szExeName,"\n\t*** Imposible Anadir reg. en pstZonaCiudad"\
                   "=>Desbordamiento (Dimension Actual %d) ***",LOG01,
                   MAX_ZONACIUDAD);
      bRes = FALSE;
  }
  else
  {
      pstZonaCiudad[NUM_ZONACIUDAD].iCodZonaImpo = pZona->iCodZonaImpo      ;

      strcpy (pstZonaCiudad [NUM_ZONACIUDAD].szCodRegion,pZona->szCodRegion);
      strcpy (pstZonaCiudad [NUM_ZONACIUDAD].szCodProvincia,
                                                      pZona->szCodProvincia);
      strcpy (pstZonaCiudad [NUM_ZONACIUDAD].szCodCiudad,pZona->szCodCiudad);
      strcpy (pstZonaCiudad [NUM_ZONACIUDAD].szFecDesde, pZona->szFecDesde) ;
      strcpy (pstZonaCiudad [NUM_ZONACIUDAD].szFecHasta, pZona->szFecHasta) ;

      NUM_ZONACIUDAD += 1;
			
      qsort (pstZonaCiudad,sizeof(ZONACIUDAD),NUM_ZONACIUDAD,iCmpZonaCiudad); 

  }
  return (bRes);

}/************************* Final bAddZonaCiudad *****************************/


/*****************************************************************************/
/*                          funcion : bGetGrupoServicios                     */
/* -Funcion que devuelve el Grupo de Servicios (iCodGrpServi), a partir del  */
/*  concepto (long iCodConcepto) y la Fecha (szFecGrp)                       */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
static BOOL bGetGrupoServicios (int iCodConcepto,
                                int* piCodGrpServi,char *szFecGrp,
                                int  iTipoFact)
{
  GRPSERCONC stGrpSerConc;
  BOOL       bRes = TRUE ;

  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static int    ihCodConcepto;
  static char*  szhSysDate   ; /* EXEC SQL VAR szhSysDate    IS STRING(15); */ 

  static int    ihCodGrpServi;
  /* EXEC SQL END DECLARE SECTION  ; */ 


    szhSysDate    = szFecGrp    ;
    ihCodConcepto = iCodConcepto;

    vDTrazasLog (szExeName, "\n\t\t* Parametros Entrada Grupo Servicios\n"
                            "\t\t=> Cod.Concepto  [%d]\n"
                            "\t\t=> Tipo Factura  [%d]\n"
                            "\t\t=> Fecha         [%s]\n",LOG05,
                            iCodConcepto,iTipoFact,szFecGrp);
    if (iTipoFact == FACT_CICLO)
    {
        if (!bFindGrpSerConc (iCodConcepto,&stGrpSerConc))
        {
            /* No se encuentran en memoria se buscan en la tabla */
            /* EXEC SQL SELECT /o+ index (FA_GRPSERCONC PK_FA_GRPSERCONC) o/
                            COD_GRPSERVI                            
                     INTO   :ihCodGrpServi                            
                     FROM   FA_GRPSERCONC
                     WHERE  COD_CONCEPTO = :ihCodConcepto
                       AND  FEC_DESDE <=TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS')
                       AND  FEC_HASTA >=TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS'); */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 11;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "select  /*+  index (FA_GRPSERCONC PK_FA_GRPSERCON\
C)  +*/ COD_GRPSERVI into :b0  from FA_GRPSERCONC where ((COD_CONCEPTO=:b1 and\
 FEC_DESDE<=TO_DATE(:b2,'YYYYMMDDHH24MISS')) and FEC_HASTA>=TO_DATE(:b2,'YYYYM\
MDDHH24MISS'))";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )103;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)&ihCodGrpServi;
            sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
            sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhSysDate;
            sqlstm.sqhstl[2] = (unsigned long )15;
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
                                "Select->Fa_GrpSerConc",szfnORAerror());
                bRes = FALSE;
            }
            else
            {
                if (SQLCODE == SQLOK)
                {
                    stGrpSerConc.iCodConcepto = ihCodConcepto;
                    stGrpSerConc.iCodGrpServi = ihCodGrpServi;

                    if (!bAddGrpSerConc (&stGrpSerConc))
                        bRes = FALSE;
                }
                else
                {
                    stGrpSerConc.iCodGrpServi = ORA_NULL;
                    iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_GrpSerConc",szfnORAerror());
                    bRes = FALSE;
                }
            }
        }
    }
    else
    {
        /* EXEC SQL SELECT /o+ index (FA_GRPSERCONC PK_FA_GRPSERCONC) o/
                        COD_GRPSERVI
                   INTO :ihCodGrpServi
                   FROM FA_GRPSERCONC
                  WHERE COD_CONCEPTO = :ihCodConcepto
                    AND FEC_DESDE <=TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS')
                    AND FEC_HASTA >=TO_DATE (:szhSysDate,'YYYYMMDDHH24MISS'); */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 11;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select  /*+  index (FA_GRPSERCONC PK_FA_GRPSERCONC)  \
+*/ COD_GRPSERVI into :b0  from FA_GRPSERCONC where ((COD_CONCEPTO=:b1 and FEC\
_DESDE<=TO_DATE(:b2,'YYYYMMDDHH24MISS')) and FEC_HASTA>=TO_DATE(:b2,'YYYYMMDDH\
H24MISS'))";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )134;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodGrpServi;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcepto;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhSysDate;
        sqlstm.sqhstl[2] = (unsigned long )15;
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
            iDError (szExeName,ERR000,vInsertarIncidencia
                                     ,"Select->Fa_GrpSerConc",szfnORAerror());
            bRes = FALSE;
        }
        stGrpSerConc.iCodGrpServi = ihCodGrpServi;
    }
    if (bRes)
        *piCodGrpServi = stGrpSerConc.iCodGrpServi;
    else
        *piCodGrpServi = ORA_NULL                 ;

    return (bRes);

}/************************ Final bGetGrupoServicios **************************/

/*****************************************************************************/
/*                         funcion : bAddGrpSerConc                          */
/* -Entrada es un reg. de la tabla FA_GRPSERCONC que introducimos en memoria */
/*  en una estructura global (GRPSERCONC* pstGrpSerConc) y aumentamos el con-*/
/*  tador de reg. (NUM_GRPSERCONC) global al modulo.                         */
/* -Salida Error->FALSE, !Error->TRUE                                        */
/*****************************************************************************/
static BOOL bAddGrpSerConc (GRPSERCONC *pGrp)
{
  BOOL bRes = TRUE;

  if (NUM_GRPSERCONC >= MAX_GRPSERCONC)
  {
      vDTrazasLog (szExeName,"\n\t*** Imposible Anadir reg. en pstGrpSerConc"\
                   "=>Desbordamiento (Dimension Actual %d) ***",LOG01,
                   MAX_GRPSERCONC);
      bRes = FALSE;
  }
  else
  {
      pstGrpSerConc [NUM_GRPSERCONC].iCodConcepto = pGrp->iCodConcepto    ;
      pstGrpSerConc [NUM_GRPSERCONC].iCodGrpServi = pGrp->iCodGrpServi    ;

      strcpy (pstGrpSerConc [NUM_GRPSERCONC].szFecDesde, pGrp->szFecDesde);
      strcpy (pstGrpSerConc [NUM_GRPSERCONC].szFecHasta, pGrp->szFecHasta);

      NUM_GRPSERCONC += 1;
			
      qsort (pstGrpSerConc,NUM_GRPSERCONC,sizeof(GRPSERCONC),iCmpGrpSerConc);      
  }
  return (bRes);
}/************************ Final bAddGrpSerConc ******************************/

/*****************************************************************************/
/*                  funcion : bTipoConceptoValido                            */
/* - El concepto no sera valido si se da alguna de las sig. condiciones:     */
/*       Indice Activo    = 0 - Error Concepto pendite de revisar factura    */
/*       tipo de Concepto = Impuesto - Error grave                           */
/*       tipo de Concepto = Descuento y Importe > 0 - Error grave            */
/*       tipo de Concepto = Otro y Importe < 0 - Error grave                 */
/*****************************************************************************/
static BOOL bTipoConceptoValido (int iInd)
{
  CONCEPTO stConcepto;
  BOOL bRes = TRUE   ;


  if (!bFindConcepto (stPreFactura.A_PFactura[iInd].iCodConcepto, &stConcepto))
  {
       iDError (szExeName,ERR021,vInsertarIncidencia,
                "pstConceptos (Fa_Conceptos)");
       strncpy (stAnomProceso.szObsAnomalia,"No se encuentra Concepto",
                strlen (stAnomProceso.szObsAnomalia));
       stAnomProceso.iCodConcepto = stPreFactura.A_PFactura[iInd].iCodConcepto;
       bRes = FALSE;
  }
  else
  {
      if (stConcepto.iIndActivo == 0)
      {
          iDError (szExeName,ERR001,vInsertarIncidencia,
                   stPreFactura.A_PFactura[iInd].iCodConcepto,
                   stConcepto.iIndActivo,stConcepto.iCodTipConce,
                   stPreFactura.A_PFactura[iInd].dImpConcepto);
          strncpy (stAnomProceso.szObsAnomalia,
                   "Concepto No Valido: Indice activo == 0",
          strlen(stAnomProceso.szObsAnomalia));
          bRes = FALSE;
       }
       else
       {
          if (stConcepto.iCodTipConce == IMPUESTO)
          {
              iDError (szExeName,ERR001,vInsertarIncidencia,
                       stPreFactura.A_PFactura[iInd].iCodConcepto,
                       stConcepto.iIndActivo,stConcepto.iCodTipConce,
                       stPreFactura.A_PFactura[iInd].dImpConcepto);

              strncpy (stAnomProceso.szObsAnomalia,
                       "Concepto No Valido: Tipo concepto Impuesto",
                       strlen(stAnomProceso.szObsAnomalia))           ;
              stAnomProceso.iCodConcepto =
                       stPreFactura.A_PFactura[iInd].iCodConcepto     ;
              bRes = FALSE                                            ;
          }
       }
  }/* fin else Find... */
  if (!bRes)
  {
      strcpy (stAnomProceso.szDesProceso,"Impuestos")  ;
      stAnomProceso.lNumProceso = stStatus.IdPro       ;
      stAnomProceso.lNumAbonado = stPreFactura.A_PFactura[iInd].lNumAbonado ;
      stAnomProceso.iCodProducto= stPreFactura.A_PFactura[iInd].iCodProducto;
      stAnomProceso.lCodCliente = stCliente.lCodCliente;
  }
  return (bRes);
}/*********************** Final bTipoConceptoValidoGeneral *******************/


/*****************************************************************************/
/*                         funcion : bCalculaImptos                          */
/* -Funcion que Calcula el Impuesto Aplicado a un Conceptos cargado en la es-*/
/*  tructura stPreFactura.A_PFactura.%[iInd], donde iInd el orden del regis- */
/*  al cual se le aplica el Impuesto.                                        */
/* -Valores Retorno : Error->FALSE, !Error->TRUE                             */
/*****************************************************************************/
static BOOL bCalculaImptos (int       iInd,/* Reg sobre el que Aplico Impto*/
                            IMPUESTOS pImpuesto)
{
    int  iNumReg = 0   ;
    BOOL bRes    = TRUE;

    iNumReg = stPreFactura.iNumRegistros;

    if (!bTipoConceptoValido (iInd))
    {
       return FALSE;
    }

    if ( pImpuesto.iTipMonto == PORCENTUAL )
    {
         stPreFactura.A_PFactura[iNumReg].dImpConcepto  =
               (double)(pImpuesto.fPrcImpuesto * stPreFactura.A_PFactura[iInd].dImpConcepto)/100;
    }
    else
    {
         stPreFactura.A_PFactura[iNumReg].dImpConcepto  = (double)(pImpuesto.fPrcImpuesto) ;
    }

    stPreFactura.A_PFactura[iNumReg].dImpMontoBase = stPreFactura.A_PFactura[iInd].dImpConcepto;

    stPreFactura.A_PFactura[iNumReg].dImpFacturable  = fnCnvDouble(stPreFactura.A_PFactura[iNumReg].dImpConcepto,0);
  
    vDTrazasLog (szExeName, "\n\t\t* Calculo del IVA:\n"
                            "\t\t=> iNumReg        [%d]\n"
                            "\t\t=> iInd           [%d]\n"
                            "\t\t=> Impto. IVA     [%f]\n"
                            "\t\t=> Valor IVA      [%f]\n"
                            "\t\t=> Monto Neto     [%f]\n"
                            "\t\t=> Monto Neto impfact [%f]\n"
                          , LOG05
                          , iNumReg, iInd, pImpuesto.fPrcImpuesto/100
                          , stPreFactura.A_PFactura[iNumReg].dImpConcepto
                          , stPreFactura.A_PFactura[iInd].dImpConcepto
                          , stPreFactura.A_PFactura[iInd].dImpFacturable);

    if (!bConversionMoneda (stCliente.lCodCliente                          ,
                            stPreFactura.A_PFactura[iInd].szCodMoneda      ,
                            stDatosGener.szCodMoneFact                     ,
                            szSysDate                                      ,
                           &stPreFactura.A_PFactura[iNumReg].dImpFacturable))
    {
        return FALSE;
    } /* P-MIX-09003 4 */

    stPreFactura.A_PFactura[iNumReg].dImpFacturable = fnCnvDouble (stPreFactura.A_PFactura[iNumReg].dImpFacturable,0);
  
    vDTrazasLog (szExeName, "\n\t\t* Importes despues del redondeo:\n"
                            "\t\t=> Monto Base:    [%f]\n"
                            "\t\t=> Valor IVA :    [%f]\n"
                            "\t\t=> Valor IVA impfact: [%f]\n"
                          , LOG05
                          , stPreFactura.A_PFactura[iNumReg].dImpMontoBase 
                          , stPreFactura.A_PFactura[iNumReg].dImpConcepto  
                          , stPreFactura.A_PFactura[iNumReg].dImpFacturable);
  return (bRes);
}/**************************  Final bCalculaImptos ***************************/


/*****************************************************************************/
/*                           funcion : bGetImpuestos                         */
/* -Busca en memoria pstImpuesto  (global al modulo) los impuestos para una  */
/*  un mismo iCodCatImpos, iCodZonaimpos, iCodGrpServi, Fecha                */
/*  y iCodZonaimposAbon     -- COL-50001 Indra-jpena   20/05/2005            */
/*  y los carga en IMPTOS                                                    */
/* -Valores de Retorno : Error->FALSE, !Error->TRUE                          */
/*****************************************************************************/
BOOL bGetImpuestos (int iCodCatImpos, int  iCodZonaImpo, int iCodZonaAbon,
                    int iCodGrpServi, char *szFecVenc ,
                    IMPTOS* pImpto  , int  iTipoFact)
{
    int  iCount    = 0   ;
    int  iNumImpto = 0   ;
    int  iInd      = 0   ;
    BOOL bRes      = TRUE;
    BOOL bExiste   = FALSE;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         static int   ihCodCatImpos  ;
         static int   ihCodZonaImpo  ;
         static int   ihCodZonaAbon  ;
         static int   ihCodTipImpues ;
         static int   ihCodGrpServi  ;
         static char  szhFecDesde[15]; /* EXEC SQL VAR szhFecDesde    IS STRING(15); */ 

         static char  szhFecHasta[15]; /* EXEC SQL VAR szhFecHasta    IS STRING(15); */ 

         static char* szhFecVencimie ; /* EXEC SQL VAR szhFecVencimie IS STRING(15); */ 

         static int   ihCodConcGene  ;
         static float fhPrcImpuesto  ;
         static int   ihTipMonto     ;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName, "\n\t\t* Parametros entrada Ge_Impuestos\n"
                            "\t\t=> Cod.CatImpos   [%d]\n"
                            "\t\t=> Cod.ZonaImpos  [%d]\n"
                            "\t\t=> Cod.ZonaAbon   [%d]\n"
                            "\t\t=> Cod.Grupo Sev. [%d]\n"
                            "\t\t=> Fec.Vencimie.  [%s]\n"
                          , LOG05
                          , iCodCatImpos,iCodZonaImpo,iCodZonaAbon,iCodGrpServi,szFecVenc);

    if (iTipoFact == FACT_CICLO)
    {
        while (bRes && iCount<NUM_IMPUESTOS)
        {

               if (pstImpuestos[iCount].iCodCatImpos == iCodCatImpos        &&
                   pstImpuestos[iCount].iCodGrpServi == iCodGrpServi        &&
                  (pstImpuestos[iCount].iCodZonaImpo == iCodZonaImpo        ||
                   pstImpuestos[iCount].iCodZonaImpo == 0                     ) &&
                  (pstImpuestos[iCount].iCodZonaAbon == iCodZonaAbon        ||
                   pstImpuestos[iCount].iCodZonaAbon == 0                     ) &&
                  (strcmp (pstImpuestos[iCount].szFecDesde,szFecVenc)<= 0) &&
                  (strcmp (pstImpuestos[iCount].szFecHasta,szFecVenc)>= 0) &&
                  /*pstImpuestos[iCount].fPrcImpuesto >= 0.01)*/ /* P-MIX-09003 */
                  pstImpuestos[iCount].fPrcImpuesto != 0.0)      /* P-MIX-09003 */          
               {
                  /* BUSCA SI YA APLICO ESTE IMPUESTO (escenario en que se aplica con una u (OR) otra condicion)*/
                  bExiste=FALSE;
                  for (iInd=0; iInd<iNumImpto; iInd++)
                  {
                       if ( (pImpto->pImpuestos[iInd].iCodConcGene  == pstImpuestos[iCount].iCodConcGene) &&
                            (pImpto->pImpuestos[iInd].fPrcImpuesto == pstImpuestos[iCount].fPrcImpuesto) )
                       {
                             bExiste=TRUE;
                             break;
                       }
                  }
                  
                  /* valida si ya aplico el mismo impuesto para no duplicarlo - ver como optimizar este codigo */
                  if (!bExiste )
                  {
                      if ((pImpto->pImpuestos =
                          (IMPUESTOS*)realloc((IMPUESTOS*)pImpto->pImpuestos,
                          (iNumImpto+1)*sizeof(IMPUESTOS)))==(IMPUESTOS*)NULL)
                      {
                          iDError (szExeName,ERR005,vInsertarIncidencia,"bGetImpuesto->pImpto");
                          strncpy (stAnomProceso.szObsAnomalia, "No se ha podido reservar Memoria"
                                                              , strlen(stAnomProceso.szObsAnomalia));
                          bRes = FALSE;
                      }
                      else
                      {
                          memcpy (&pImpto->pImpuestos[iNumImpto],&pstImpuestos[iCount],sizeof(IMPUESTOS));
                          iNumImpto++;
                      }
                  } /* fin if ya aplico este impuesto */
               }
               
               if ( bRes )
               {
                   iCount++;
               }
        }/* fin While NUM_IMPUESTOS */
    }
    else
    {
       ihCodCatImpos = iCodCatImpos ;
       ihCodZonaImpo = iCodZonaImpo ;
       ihCodZonaAbon = iCodZonaAbon ;
       ihCodGrpServi = iCodGrpServi ;
       szhFecVencimie= szFecVenc    ;

       /* EXEC SQL DECLARE Cur_Impuestos CURSOR FOR
            SELECT /o+ index (GE_IMPUESTOS PK_GE_IMPUESTOS) o/
                   TO_CHAR (I.FEC_DESDE,'YYYYMMDDHH24MISS'),
                   I.COD_CONCGENE                          ,
                   TO_CHAR (I.FEC_HASTA,'YYYYMMDDHH24MISS'),
                   I.PRC_IMPUESTO,
                   T.TIP_MONTO
            FROM   GE_IMPUESTOS I, GE_TIPIMPUES T
            WHERE  I.COD_TIPIMPUES= T.COD_TIPIMPUE
              AND  I.COD_CATIMPOS = :ihCodCatImpos
              AND  I.COD_ZONAIMPO = DECODE(I.COD_ZONAIMPO,0,0,:ihCodZonaImpo)
              AND  I.COD_ZONAABON = DECODE(I.COD_ZONAABON,0,0,:ihCodZonaAbon)
              AND  I.COD_GRPSERVI = :ihCodGrpServi
              AND  I.FEC_DESDE   <= TO_DATE (:szhFecVencimie,'YYYYMMDDHH24MISS')
              AND  I.FEC_HASTA   >= TO_DATE (:szhFecVencimie,'YYYYMMDDHH24MISS')
              /o AND  I.PRC_IMPUESTO > 0.01 o/ /o P-MIX-09003 o/
              AND  I.PRC_IMPUESTO != 0.0       /o P-MIX-09003 o/
            ORDER BY COD_CONCGENE,PRC_IMPUESTO; */ 


      /* EXEC SQL OPEN Cur_Impuestos; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 11;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = sq0005;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )165;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqcmod = (unsigned int )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCatImpos;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)&ihCodZonaImpo;
      sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&ihCodZonaAbon;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&ihCodGrpServi;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)szhFecVencimie;
      sqlstm.sqhstl[4] = (unsigned long )15;
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhFecVencimie;
      sqlstm.sqhstl[5] = (unsigned long )15;
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



      if (SQLCODE != SQLOK)
      {
          iDError (szExeName,ERR000,vInsertarIncidencia,"Open->Ge_Impuestos",
                   szfnORAerror());
          bRes = FALSE;
      }
      iNumImpto = 0;
      while (bRes && SQLCODE == SQLOK)
      {
             /* EXEC SQL FETCH Cur_Impuestos INTO :szhFecDesde  ,
                                               :ihCodConcGene,
                                               :szhFecHasta  ,
                                               :fhPrcImpuesto,
                                               :ihTipMonto; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 11;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )204;
             sqlstm.selerr = (unsigned short)1;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqfoff = (         int )0;
             sqlstm.sqfmod = (unsigned int )2;
             sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesde;
             sqlstm.sqhstl[0] = (unsigned long )15;
             sqlstm.sqhsts[0] = (         int  )0;
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)&ihCodConcGene;
             sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
             sqlstm.sqhsts[1] = (         int  )0;
             sqlstm.sqindv[1] = (         short *)0;
             sqlstm.sqinds[1] = (         int  )0;
             sqlstm.sqharm[1] = (unsigned long )0;
             sqlstm.sqadto[1] = (unsigned short )0;
             sqlstm.sqtdso[1] = (unsigned short )0;
             sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
             sqlstm.sqhstl[2] = (unsigned long )15;
             sqlstm.sqhsts[2] = (         int  )0;
             sqlstm.sqindv[2] = (         short *)0;
             sqlstm.sqinds[2] = (         int  )0;
             sqlstm.sqharm[2] = (unsigned long )0;
             sqlstm.sqadto[2] = (unsigned short )0;
             sqlstm.sqtdso[2] = (unsigned short )0;
             sqlstm.sqhstv[3] = (unsigned char  *)&fhPrcImpuesto;
             sqlstm.sqhstl[3] = (unsigned long )sizeof(float);
             sqlstm.sqhsts[3] = (         int  )0;
             sqlstm.sqindv[3] = (         short *)0;
             sqlstm.sqinds[3] = (         int  )0;
             sqlstm.sqharm[3] = (unsigned long )0;
             sqlstm.sqadto[3] = (unsigned short )0;
             sqlstm.sqtdso[3] = (unsigned short )0;
             sqlstm.sqhstv[4] = (unsigned char  *)&ihTipMonto;
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


                                               
             if (SQLCODE != SQLOK && SQLCODE != SQLNOTFOUND)
             {
                 iDError (szExeName,ERR000,vInsertarIncidencia, "Fetch->Ge_Impuestos",szfnORAerror());
             }
                
             if (SQLCODE == SQLOK)
             {
                 if ((pImpto->pImpuestos =
                    (IMPUESTOS *)realloc( (IMPUESTOS *)pImpto->pImpuestos,
                    (iNumImpto+1)*sizeof(IMPUESTOS) ) ) == (IMPUESTOS *)NULL)
                 {
                     iDError (szExeName,ERR005,vInsertarIncidencia,"bGetImpuesto->pImpto");
                     strncpy (stAnomProceso.szObsAnomalia, "No se ha podido reservar Memoria",
                                                           strlen(stAnomProceso.szObsAnomalia));
                     bRes = FALSE;
                 }
                 else
                 {
                    /* BUSCA SI YA APLICO ESTE IMPUESTO (escenario en que se aplica con una u (OR) otra condicion)*/
                     bExiste=FALSE;
                     for (iInd=0; iInd<iNumImpto; iInd++)
                     {
                          if ( (pImpto->pImpuestos[iInd].iCodConcGene  == ihCodConcGene) &&
                               (pImpto->pImpuestos[iInd].fPrcImpuesto == fhPrcImpuesto) )
                          {
                                bExiste=TRUE;
                                break;
                          }
                     }
                     /* valida si ya aplico el mismo impuesto para no duplicarlo *** ver como optimizar este codigo */
                     if ( !bExiste )
                     {
                          pImpto->pImpuestos[iNumImpto].iCodConcGene =ihCodConcGene;
                          pImpto->pImpuestos[iNumImpto].iCodCatImpos =ihCodCatImpos;
                          pImpto->pImpuestos[iNumImpto].iCodZonaImpo =ihCodZonaImpo;
                          pImpto->pImpuestos[iNumImpto].iCodZonaAbon =ihCodZonaAbon;
                          pImpto->pImpuestos[iNumImpto].iCodTipImpues=ihCodTipImpues;
                          pImpto->pImpuestos[iNumImpto].fPrcImpuesto =fhPrcImpuesto;
                          pImpto->pImpuestos[iNumImpto].iCodGrpServi =ihCodGrpServi;
                          pImpto->pImpuestos[iNumImpto].iTipMonto    =ihTipMonto;

                          strcpy (pImpto->pImpuestos[iNumImpto].szFecDesde, szhFecDesde);
                          strcpy (pImpto->pImpuestos[iNumImpto].szFecHasta, szhFecHasta);

                          iNumImpto++;
                     }
                 }
             }/* fin SQLCODE == SQLOK */
      }/* While sqlcode == sqlok */
      
      if (bRes && SQLCODE != SQLNOTFOUND)
      {
          bRes = FALSE;
      }
      else
      {
         /* EXEC SQL CLOSE Cur_Impuestos; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 11;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )1;
         sqlstm.offset = (unsigned int  )239;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


         if (SQLCODE)
         {
             iDError (szExeName,ERR000,vInsertarIncidencia, "Close->Ge_Impuestos",szfnORAerror());
             bRes = FALSE;
         }
      }
   }
   if (bRes)
   {
       pImpto->iNumImpuestos = iNumImpto;
       vPrintImpuestos (pImpto)         ;
   }
   
   return (bRes);
}/************************** Final bGetImpuestos *****************************/

/*****************************************************************************/
/*                          funcion : vPrintImpuestos                        */
/*****************************************************************************/
void vPrintImpuestos (IMPTOS* pImpto)
{
    int i = 0;

    vDTrazasLog (szExeName,"\n\t\t*** Impuestos ***\n",LOG05);

    for (i=0;i<pImpto->iNumImpuestos;i++)
    {
         vDTrazasLog (szExeName, "\n\t\tCodCatimpos [%d]"
                                 "\n\t\tFec.Desde   [%s]"
                                 "\n\t\tFec.Hasta   [%s]"
                                 "\n\t\tCodZonaimp. [%d]"
                                 "\n\t\tCodTipimpues[%d]"
                                 "\n\t\tCodGrpServi [%d]"
                                 "\n\t\tCodConcGene [%d]"
                                 "\n\t\tPrcImpuesto [%f]"
                               , LOG05
                               , pImpto->pImpuestos[i].iCodCatImpos
                               , pImpto->pImpuestos[i].szFecDesde   
                               , pImpto->pImpuestos[i].szFecHasta   
                               , pImpto->pImpuestos[i].iCodZonaImpo 
                               , pImpto->pImpuestos[i].iCodTipImpues
                               , pImpto->pImpuestos[i].iCodGrpServi 
                               , pImpto->pImpuestos[i].iCodConcGene 
                               , pImpto->pImpuestos[i].fPrcImpuesto);
    }/* fin for i */
}/************************** Final vPrintImpuestos ***************************/

/*****************************************************************************/
/*                           funcion : vFreeImpuestos                        */
/* -Libera memoria de la estructura stImptos                                 */
/*****************************************************************************/
void vFreeImpuestos (IMPTOS* pImpto)
{
    if (pImpto->pImpuestos != NULL)
    {
        pImpto->iNumImpuestos = 0             ;
        free (pImpto->pImpuestos)             ;
        pImpto->pImpuestos = (IMPUESTOS *)NULL;
    }
}/************************** Final vFreeImpuestos ****************************/

void vFreeTotImpuestos (TOTIMPTOS* pTotImpto)
{
    if (pTotImpto->stTotImptos != NULL)
    {
        pTotImpto->iNumTotImptos=0;
        free (pTotImpto->stTotImptos)             ;
    }
}/************************** Final vFreeTotImpuestos ****************************/


/*****************************************************************************/
/*                     funcion : bGeneraCuotas                               */
/* -Funcion que llama al package fa_pac_cuota.p_main_cuota                   */
/* -Valores Retorno : Error->FALSE,!Error->TRUE                              */
/*****************************************************************************/
static BOOL bGeneraCuotas (long  lNumCargo , char *szCodCuota,
                           float fPrcImpues, int   iCodConcepto)
{
  /* EXEC SQL BEGIN DECLARE SECTION; */ 

  static long  lhNumCargo      ;
  static char* szhCodCuota     ; /* EXEC SQL VAR szhCodCuota IS STRING (3); */ 

  static float fhPrcImpuesto   ;
  static int   ihCodConcepto   ;
  /* EXEC SQL END DECLARE SECTION; */ 


  lhNumCargo       = lNumCargo      ;
  szhCodCuota      = szCodCuota     ;
  fhPrcImpuesto    = fPrcImpues     ;
  ihCodConcepto    = iCodConcepto   ;

  vDTrazasLog (szExeName,"\n\t\t*** Generando Cuotas ***\n"
               "\t\tNum.Cargo     [%ld]\n"
               "\t\tCod.Cuota     [%s]\n"
               "\t\tPrc.Impuesto  [%f]\n"
               "\t\tCod.Concepto  [%d]\n",LOG04,
               lhNumCargo,szCodCuota,fPrcImpues,ihCodConcepto);
  /* EXEC SQL EXECUTE
  BEGIN
      fa_pac_cuota.p_main_cuota(:lhNumCargo   ,:szhCodCuota,
                                :fhPrcImpuesto,:ihCodConcepto);
  END;
  END-EXEC; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 11;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "begin fa_pac_cuota . p_main_cuota ( :lhNumCargo , :szhCodCu\
ota , :fhPrcImpuesto , :ihCodConcepto ) ; END ;";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )254;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumCargo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodCuota;
  sqlstm.sqhstl[1] = (unsigned long )3;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&fhPrcImpuesto;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(float);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihCodConcepto;
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
      iDError (szExeName,ERR000,vInsertarIncidencia,
               "\t\tCod.Cuota     [%s]\n"
               "\t\tPrc.Impuesto  [%f]\n"
               "\t\tCod.Concepto  [%d]\n",LOG04,
               szCodCuota,fPrcImpues,ihCodConcepto);

  return (SQLCODE != 0)?FALSE:TRUE;
}/********************** Final bGeneraCuotas *********************************/


static BOOL bfnAcumTotImptos (  TOTIMPTOS *pstTotImptos ,
                                int     iCodConcBase    ,
                                int     iCodConcepto    ,
                                double  dImpMontoBase   ,
                                double  dImpConcepto    ,
                                float   fPrcImpuesto,
                                int     iTipMonto)
{
    int i;
    BOOL bExist=FALSE;

    vDTrazasLog (szExeName, "\n\t\t*** Entrada en %s ***\n"
                            "\t\tiCodConcepto  [%d]\n"
                            "\t\tdImpMontoBase [%f]\n"
                            "\t\tdImpConcepto  [%f]\n"
                            "\t\tfPrcImpuesto  [%f]\n",LOG04, "bfnAcumTotImptos",
                            iCodConcepto,dImpMontoBase,dImpConcepto ,fPrcImpuesto);


    for (i=0;i<MAX_FACTCARRIERS;i++) /* Busqueda del concepto en los conceptos de carrier */
    {
        if (pstFactCarriers[i].iCodConcFact == iCodConcBase )
        {
            vDTrazasLog (szExeName, "\n\t\t* Concepto de Carrier %d no se acumula para el ajuste * "
                        ,LOG05, iCodConcepto);
            return (TRUE);
        }
    }

    for (i=0;i<pstTotImptos->iNumTotImptos;i++)
    {
        if (pstTotImptos->stTotImptos[i].iCodImpto == iCodConcepto &&
            pstTotImptos->stTotImptos[i].fPorcent == fPrcImpuesto )
        {
            bExist = TRUE;
            break;
        }
    }

    if (bExist)
    {
        vDTrazasLog (szExeName, "\n\t\t=>[%d] += dImpMontoBase [%f]"
                                "\n\t\t=>[%d] += dImpConcepto  [%f]", LOG05
                                ,i,dImpMontoBase, i, dImpConcepto);
        if ( pstTotImptos->stTotImptos[i].iTipMonto == PORCENTUAL )
        { pstTotImptos->stTotImptos[i].dTotMBase+=dImpMontoBase;
            }
            else {
          pstTotImptos->stTotImptos[i].dTotMBase+=1; /* cantiad de  imp. monto fijo */
        }
        pstTotImptos->stTotImptos[i].dTotImpto+=dImpConcepto;
    }
    else
    {
        vDTrazasLog (szExeName, "\n\t\t=>** Se crea nuevo registro de Tot.impuestos **"
                                "\n\t\t=>[%d] += iCodImpto [%d]"
                                "\n\t\t=>[%d] += fPorcent  [%f]"
                                "\n\t\t=>[%d] += dTotMBase [%f]"
                                "\n\t\t=>[%d] += dTotImpto [%f]"
                                , LOG05,i,iCodConcepto
                                ,i,fPrcImpuesto,i,dImpMontoBase, i, dImpConcepto);

        if ((pstTotImptos->stTotImptos =
            (TOTIMPTO*)realloc((TOTIMPTO*)pstTotImptos->stTotImptos,
                               (pstTotImptos->iNumTotImptos+1)*sizeof(TOTIMPTO)))
            ==(TOTIMPTO*)NULL)
        {
            iDError (szExeName,ERR005,vInsertarIncidencia,
                             "pstTotImptos->stTotImptos");
        }

        pstTotImptos->stTotImptos[pstTotImptos->iNumTotImptos].iCodImpto=   iCodConcepto;
        pstTotImptos->stTotImptos[pstTotImptos->iNumTotImptos].fPorcent =   fPrcImpuesto;
        pstTotImptos->stTotImptos[pstTotImptos->iNumTotImptos].dTotMBase=   dImpMontoBase;
        pstTotImptos->stTotImptos[pstTotImptos->iNumTotImptos].dTotImpto=   dImpConcepto;
        pstTotImptos->stTotImptos[pstTotImptos->iNumTotImptos].iTipMonto=   iTipMonto;
        pstTotImptos->iNumTotImptos++;

    }
    return (TRUE);
}/****************************** Fin bfnAcumTotImptos ****************************/

/**********************************************************/
/* FUNCION : bfnAjusteImptos                              */
/**********************************************************/
static BOOL bfnAjusteImptos (TOTIMPTOS *pstTotImptos)
{
    /* Estuctura para acumular los totales por abonado */
    TOTABON stTotalesAbon;
    int     i,x;
    double  dMontoAjuste  = 0.0;
    int     iCont=0;
    int     iFlagAjuste   =   0;
    double  dIvaAcumBase  = 0.0;
    BOOL    bExiste=FALSE      ;
    double  dAcuFacturable= 0.0;
    double  dAcuConceptos = 0.0;

    vDTrazasLog (szExeName,"\n\t\t*** Entrada en %s ***\niNumRegistros=%d  iNumTotImptos=%d"
                            ,LOG04, "bfnAjusteImptos",stPreFactura.iNumRegistros,pstTotImptos->iNumTotImptos);

    /*****************************************************************************/
    /*  Rutina para calcular los saldos X abonado para realizar el ajuste        */
    /*****************************************************************************/
    memset (&stTotalesAbon,0,sizeof (TOTABON));
    iCont = stPreFactura.iNumRegistros - 1;

    for (i =0; i<=iCont; i++)
    {
        dAcuFacturable  = dAcuFacturable + stPreFactura.A_PFactura[i].dImpFacturable;
        dAcuConceptos   = dAcuConceptos + stPreFactura.A_PFactura [i].dImpConcepto   ;
    }

    if (fnCnvDouble(dAcuConceptos, USOFACT) == dAcuFacturable)
    {
        return (TRUE);
    }

    vDTrazasLog (szExeName,"\n\t\t*** Entrada 2 en %s ***\niCont=%d NumAbonados=%d",LOG04, "bfnAjusteImptos",iCont,stTotalesAbon.iNumAbonados);
    for (i=0;i<=iCont;i++)
    {
        bExiste=FALSE;
        for (x=0;x<stTotalesAbon.iNumAbonados;x++)
        {
            if (stTotalesAbon.stAbon[x].lNumAbonado == stPreFactura.A_PFactura[i].lNumAbonado)
            {
                stTotalesAbon.stAbon[x].dTotFactur  += stPreFactura.A_PFactura[i].dImpFacturable;
                bExiste=TRUE;
                break;
            }
        }
        if (!bExiste)
        {
            x =stTotalesAbon.iNumAbonados;
            stTotalesAbon.stAbon[x].lNumAbonado  = stPreFactura.A_PFactura[i].lNumAbonado;
            stTotalesAbon.stAbon[x].dTotFactur  += stPreFactura.A_PFactura[i].dImpFacturable;
            stTotalesAbon.iNumAbonados++;


            if (stTotalesAbon.iNumAbonados > NUM_ABONADOS_CLIENTE)
            {
                vDTrazasError(szExeName,"\n\t**  Sobrepasado NUM_ABONADOS_CLIENTE **",LOG01);
                vDTrazasLog  (szExeName,"\n\t**  Sobrepasado NUM_ABONADOS_CLIENTE **",LOG01);
                return (FALSE);
            }
        }
    }
    /****************************************************************************/

    for (i=0;i<pstTotImptos->iNumTotImptos;i++) /* Recorre los impuestos */
    {
        if ( pstTotImptos->stTotImptos[i].iTipMonto == PORCENTUAL )
        {        dIvaAcumBase = pstTotImptos->stTotImptos[i].dTotMBase * (double)pstTotImptos->stTotImptos[i].fPorcent / 100 ;
        }
        else {  dIvaAcumBase =  pstTotImptos->stTotImptos[i].dTotMBase * (double)pstTotImptos->stTotImptos[i].fPorcent;
        }
        /* rao270802: Se redondea el total de impuesto calculado */
        dIvaAcumBase = fnCnvDouble(dIvaAcumBase,USOFACT);
        dMontoAjuste = dIvaAcumBase - pstTotImptos->stTotImptos[i].dTotImpto;

        vDTrazasLog (szExeName, "\n\t\t* MONTO DEL AJUSTE [%f]", LOG04, dMontoAjuste);

        if (dMontoAjuste != 0.0 && (abs(dMontoAjuste) >= pstParamGener.iMtoMinAjuste))
        {
                iFlagAjuste=0;
                vDTrazasLog (szExeName, "\n\t\t* AJUSTE DE IVA "
                            "\n\t\t=> iCont            : [%d]"
                            "\n\t\t=> Num. Registros   : [%d]"
                            "\n\t\t=> Num. Impuestos   : [%d]"
                            "\n\t\t=> Total Ajuste     : [%f]", LOG03, iCont,
                            stPreFactura.iNumRegistros, iNImptosT,dMontoAjuste);

                while((iCont >= 0) && (iFlagAjuste != 1))
                {
                    if ((stPreFactura.A_PFactura[iCont].iCodConcepto    == pstTotImptos->stTotImptos[i].iCodImpto)  &&
                        (stPreFactura.A_PFactura[iCont].fPrcImpuesto    == pstTotImptos->stTotImptos[i].fPorcent )  &&
                        (stPreFactura.A_PFactura[iCont].dImpConcepto    != 0.0                                  )  &&
                        ( ( stPreFactura.A_PFactura[iCont].dImpConcepto > 0 && dMontoAjuste < 0 && (stPreFactura.A_PFactura[iCont].dImpConcepto + dMontoAjuste) >= 0 ) ||
                          ( stPreFactura.A_PFactura[iCont].dImpConcepto < 0 && dMontoAjuste > 0 && (stPreFactura.A_PFactura[iCont].dImpConcepto + dMontoAjuste) <= 0 ) ||
                          ( stPreFactura.A_PFactura[iCont].dImpConcepto > 0 && dMontoAjuste > 0 ) ||
                          ( stPreFactura.A_PFactura[iCont].dImpConcepto < 0 && dMontoAjuste > 0 )))
                    {
                        if((stPreFactura.A_PFactura[iCont].iCodConceRel != stDatosGener.iCodAbonoCel)   &&
                           (stPreFactura.A_PFactura[iCont].iCodConceRel != stDatosGener.iCodAbonoBeep))
                        {

                            vDTrazasLog (szExeName, "\n\t\t* Haciendo ajuste del IVA "
                                                    "\n\t\t=> Registro            : [%d]"
                                                    "\n\t\t=> Concepto            : [%d]"
                                                    "\n\t\t=> Descrip. Concepto   : [%s]"
                                                    "\n\t\t=> Producto            : [%d]"
                                                    "\n\t\t=> Importe Concepto    : [%f]"
                                                    "\n\t\t=> Concepto Relacion.  : [%d]"
                                                    "\n\t\t=> Importe Facturable  : [%f]", LOG05,iCont,
                                                    stPreFactura.A_PFactura[iCont].iCodConcepto  ,
                                                    stPreFactura.A_PFactura[iCont].szDesConcepto ,
                                                    stPreFactura.A_PFactura[iCont].iCodProducto  ,
                                                    stPreFactura.A_PFactura[iCont].dImpConcepto  ,
                                                    stPreFactura.A_PFactura[iCont].iCodConceRel  ,
                                                    stPreFactura.A_PFactura[iCont].dImpFacturable);
                            /*** RAO: Valida que el total del abonado sea >0 */
                            for (x=0;x<stTotalesAbon.iNumAbonados;x++)
                            {
                                if (stTotalesAbon.stAbon[x].lNumAbonado == stPreFactura.A_PFactura[iCont].lNumAbonado)
                                    break;
                            }

                            if (stTotalesAbon.stAbon[x].dTotFactur + dMontoAjuste >= 0 )
                            {
                                vDTrazasLog (szExeName,"\n\t\t* Abonado [%ld] total [%f] ajuste [%f]"
                                            ,LOG05,stTotalesAbon.stAbon[x].lNumAbonado
                                            ,stTotalesAbon.stAbon[x].dTotFactur, dMontoAjuste);
                                stPreFactura.A_PFactura[iCont].dImpConcepto += dMontoAjuste;

                                stPreFactura.A_PFactura[iCont].dImpFacturable = fnCnvDouble(stPreFactura.A_PFactura[iCont].dImpConcepto,0);
                                                                
                                iFlagAjuste = 1;
                                vDTrazasLog (szExeName, "\n\t\t* Monto del ajuste        : [%f]"
                                                        "\n\t\t* Nuevo importe Concepto  : [%f]"
                                                        "\n\t\t* Nuevo importe Facturable: [%f]", LOG05,
                                                        dMontoAjuste, stPreFactura.A_PFactura[iCont].dImpConcepto,
                                                        stPreFactura.A_PFactura[iCont].dImpFacturable);
                            }
                            else
                            {       
                            	/* RAO : Se aplica como ajuste el remanente de saldo del abonado */
                                stPreFactura.A_PFactura[iCont].dImpConcepto += (stTotalesAbon.stAbon[x].dTotFactur>0)?stTotalesAbon.stAbon[x].dTotFactur:0;

                                stPreFactura.A_PFactura[iCont].dImpFacturable = fnCnvDouble(stPreFactura.A_PFactura[iCont].dImpConcepto,0);
                                
                                dMontoAjuste -= (stTotalesAbon.stAbon[x].dTotFactur>0)?stTotalesAbon.stAbon[x].dTotFactur:0;

                                vDTrazasLog (szExeName, "\n\t\t*** Ajuste Especial, Total Factura < Ajuste ****"
                                                        "\n\t\t* Total Abonado           : [%f]"
                                                        "\n\t\t* Nuevo importe Concepto  : [%f]"
                                                        "\n\t\t* Nuevo importe facturable: [%f]"
                                                        "\n\t\t* Remanente Ajuste        : [%f]", LOG03,
                                                        stTotalesAbon.stAbon[x].dTotFactur,
                                                        stPreFactura.A_PFactura[iCont].dImpFacturable,
                                                        stPreFactura.A_PFactura[iCont].dImpFacturable,
                                                        dMontoAjuste);
                            }

                        }
                        else    /* El concepto es de cargo basico */
                        {
                            iCont--;
                        }
                    } /* Fin if concepto = concepto Impto */
                    if(iFlagAjuste != 1)
                        iCont--;
                }   /* Fin while */

                if(iFlagAjuste !=1)
                {
                    vDTrazasLog (szExeName, "\n\t\t* No se hizo ajuste de IVA\n", LOG03);
                }
            }   /* Fin if(dMontoAjuste...) */

    } /* Fin For pstTotImptos->iNumTotImptos */

    return(TRUE);

}/************************* Final bfnAjusteImptos ****************************/
/*****************************************************************************/
/*                           funcion : bfnRegZonaAbon                    */
/*    Carga estructura con relacion de abonados con su zona impositiva       */
/*    Retur True -> Ok False, si no.                                         */
/*****************************************************************************/
static BOOL bfnRegZonaAbon  (int iNumRegIni)
{
    /* Estuctura para acumular los totales por abonado */
    int     i,x;
    int     iCont=0;
    BOOL    bExiste=FALSE       ;

    vDTrazasLog (szExeName,"\n\t\t*** Entrada en [%s] ***\niNumRegistros=[%d]  NumAbonados=[%d] "
                          ,LOG04, "bfnRegZonaAbon",stPreFactura.iNumRegistros,stZonaAbon.iNumAbonados);

    /*****************************************************************************/
    /*  Rutina para calcular los saldos X abonado para realizar el ajuste        */
    /*****************************************************************************/
    memset (&stZonaAbon,0,sizeof (TOTZABON));
    iCont = stPreFactura.iNumRegistros - 1;

    stZonaAbon.iNumAbonados = 0;

    for (i=iNumRegIni;i<=iCont;i++)
    {

        if (stPreFactura.A_PFactura[i].iCodZonaAbon != 0)
        {
            bExiste=FALSE;

            for (x=0;x<stZonaAbon.iNumAbonados;x++)
            {
                if ((stZonaAbon.stAbon[x].lNumAbonado == stPreFactura.A_PFactura[i].lNumAbonado))
                {
                    bExiste=TRUE;
                    break;
                }
            }

            if (!bExiste)
            {
                x =stZonaAbon.iNumAbonados;
                stZonaAbon.stAbon[x].lNumAbonado  = stPreFactura.A_PFactura[i].lNumAbonado ;
                stZonaAbon.stAbon[x].iCodZonaAbon = stPreFactura.A_PFactura[i].iCodZonaAbon;
                stZonaAbon.iNumAbonados++;
            }
        }
    }

    /****************************************************************************/

    return(TRUE);

}/************************* Final bfnRegZonaAbon ****************************/

/*****************************************************************************/
/*                           funcion : bfnAplicaImpto                    */
/*  Aplica los campos al nuevo concepto de impuesto             */
/*****************************************************************************/
BOOL bfnAplicaImpto (int iIdxOri, int iIdxFin,int iTipoFact)
{



    stPreFactura.A_PFactura[iIdxFin].bOptImpuesto = TRUE;
                                    
    stPreFactura.A_PFactura[iIdxFin].lNumProceso  = stPreFactura.A_PFactura[iIdxOri].lNumProceso ;
    stPreFactura.A_PFactura[iIdxFin].lCodCliente  = stPreFactura.A_PFactura[iIdxOri].lCodCliente ;

    if (!bGetMaxColPreFa(stPreFactura.A_PFactura[iIdxFin].iCodConcepto, &stPreFactura.A_PFactura[iIdxFin].lColumna ))
        return FALSE;

    stPreFactura.A_PFactura[iIdxFin].iCodProducto = stPreFactura.A_PFactura[iIdxOri].iCodProducto ;
    strcpy(stPreFactura.A_PFactura[iIdxFin].szCodMoneda , stPreFactura.A_PFactura[iIdxOri].szCodMoneda) ;

    switch (iTipoFact)
    {
        case FACT_CICLO      :
        case FACT_BAJA       :
            strcpy (stPreFactura.A_PFactura[iIdxFin].szFecValor , stCiclo.szFecEmision);
            break;
        case FACT_CONTADO    :
        case FACT_COMPRA     :
        case FACT_MISCELAN   :
        case FACT_LIQUIDACION:
        case FACT_RENTAPHONE :
        case FACT_ROAMINGVIS :
            strcpy (stPreFactura.A_PFactura[iIdxFin].szFecValor, szSysDate);
            break;
        default              :
            break;
    }

    strcpy(stPreFactura.A_PFactura[iIdxFin].szFecEfectividad, szSysDate);
    strcpy(stPreFactura.A_PFactura[iIdxFin].szCodRegion     ,   stPreFactura.A_PFactura[iIdxOri].szCodRegion   );
    strcpy(stPreFactura.A_PFactura[iIdxFin].szCodProvincia,    stPreFactura.A_PFactura[iIdxOri].szCodProvincia);
    strcpy(stPreFactura.A_PFactura[iIdxFin].szCodCiudad     ,   stPreFactura.A_PFactura[iIdxOri].szCodCiudad   );
    strcpy(stPreFactura.A_PFactura[iIdxFin].szCodModulo     ,   stPreFactura.A_PFactura[iIdxOri].szCodModulo   );
    stPreFactura.A_PFactura[iIdxFin].lCodPlanCom           =    stPreFactura.A_PFactura[iIdxOri].lCodPlanCom   ;
    stPreFactura.A_PFactura[iIdxFin].iIndFactur            =    stPreFactura.A_PFactura[iIdxOri].iIndFactur    ;   /* FACTURABLE;  */
    stPreFactura.A_PFactura[iIdxFin].iCodCatImpos          =    stPreFactura.A_PFactura[iIdxOri].iCodCatImpos;
    stPreFactura.A_PFactura[iIdxFin].iIndEstado   = EST_NORMAL;
    stPreFactura.A_PFactura[iIdxOri].iIndEstado   = EST_IMPTO ;
    stPreFactura.A_PFactura[iIdxFin].iCodTipConce = IMPUESTO  ;
    stPreFactura.A_PFactura[iIdxFin].lNumUnidades = stPreFactura.A_PFactura[iIdxOri].lNumUnidades;  /* Incorporado por PGonzaleg  4-03-2002 */
    stPreFactura.A_PFactura[iIdxFin].lCodCiclFact = stCiclo.lCodCiclFact;
    stPreFactura.A_Ind[iIdxFin].i_lCodCiclFact    = (stCiclo.lCodCiclFact == ORA_NULL)?ORA_NULL:SQLOK;
    stPreFactura.A_PFactura[iIdxFin].iCodConceRel = stPreFactura.A_PFactura[iIdxOri].iCodConcepto;
    stPreFactura.A_PFactura[iIdxFin].lColumnaRel  = stPreFactura.A_PFactura[iIdxOri].lColumna    ;
    stPreFactura.A_PFactura[iIdxFin].lNumAbonado  = stPreFactura.A_PFactura[iIdxOri].lNumAbonado ;
    stPreFactura.A_Ind[iIdxFin].i_lNumAbonado     = (stPreFactura.A_PFactura[iIdxOri].lNumAbonado == ORA_NULL)?-1:0   ;
    strcpy(stPreFactura.A_PFactura[iIdxFin].szNumTerminal , stPreFactura.A_PFactura[iIdxOri].szNumTerminal );
    stPreFactura.A_Ind[iIdxFin].i_szNumTerminal   =         (strcmp(stPreFactura.A_PFactura[iIdxOri].szNumTerminal,"")==0)?-1:0;
    stPreFactura.A_PFactura[iIdxFin].lCapCode     =         stPreFactura.A_PFactura[iIdxOri].lCapCode   ;
    stPreFactura.A_Ind[iIdxFin].i_lCapCode        =         (stPreFactura.A_PFactura[iIdxOri].lCapCode   == ORA_NULL)?-1:0    ;
    strcpy(stPreFactura.A_PFactura[iIdxFin].szNumSerieMec ,  stPreFactura.A_PFactura[iIdxOri].szNumSerieMec );
    stPreFactura.A_Ind[iIdxFin].i_szNumSerieMec            = (strcmp(stPreFactura.A_PFactura[iIdxOri].szNumSerieMec,"")==0)?-1:0;
    strcpy(stPreFactura.A_PFactura[iIdxFin].szNumSerieLe  ,   stPreFactura.A_PFactura[iIdxOri].szNumSerieLe  );
    stPreFactura.A_Ind[iIdxFin].i_szNumSerieLe             =  (strcmp(stPreFactura.A_PFactura[iIdxOri].szNumSerieLe ,"")==0)?-1:0;
    stPreFactura.A_PFactura[iIdxFin].iFlagImpues   = 0  ;
    stPreFactura.A_PFactura[iIdxOri].iFlagImpues   = 1  ;
    stPreFactura.A_PFactura[iIdxFin].iFlagDto      = 0  ;
    stPreFactura.A_PFactura[iIdxFin].iFlagDto      = 0  ;
    stPreFactura.A_PFactura[iIdxFin].dValDto       = -1 ;
    stPreFactura.A_Ind[iIdxFin].i_dValDto          = -1 ;
    stPreFactura.A_PFactura[iIdxFin].iTipDto       = -1 ;
    stPreFactura.A_Ind[iIdxFin].i_iTipDto          = -1 ;
    stPreFactura.A_PFactura[iIdxFin].lNumVenta     =  stPreFactura.A_PFactura[iIdxOri].lNumVenta ;
    stPreFactura.A_Ind[iIdxFin].i_lNumVenta        =  (stPreFactura.A_PFactura[iIdxOri].lNumVenta    == ORA_NULL)?-1:0;

    stPreFactura.A_PFactura[iIdxFin].lNumTransaccion = stPreFactura.A_PFactura[iIdxOri].lNumTransaccion ;
    stPreFactura.A_Ind[iIdxFin].i_lNumTransaccion    = (stPreFactura.A_PFactura[iIdxOri].lNumTransaccion==ORA_NULL)?-1:0;
    stPreFactura.A_PFactura[iIdxFin].iMesGarantia  = 0;
    stPreFactura.A_PFactura[iIdxFin].iIndAlta      = 1;
    stPreFactura.A_PFactura[iIdxFin].iIndSuperTel  = 0;
    stPreFactura.A_PFactura[iIdxFin].iNumPaquete   =-1;
    stPreFactura.A_Ind[iIdxFin].i_iNumPaquete      =-1;
    stPreFactura.A_PFactura[iIdxFin].iIndCuota     = 0;
    stPreFactura.A_PFactura[iIdxFin].iNumCuotas    = 0;
    stPreFactura.A_PFactura[iIdxFin].iOrdCuota     = 0;

    stPreFactura.A_PFactura[iIdxFin].dhImpConversion  =  stPreFactura.A_PFactura[0].dhImpConversion;

    strcpy(stPreFactura.A_PFactura[iIdxFin].szhCodMonedaImp  , stPreFactura.A_PFactura[0].szhCodMonedaImp);

    /* stPreFactura.iNumRegistros++; */
    if(bfnIncrementarIndicePreFactura()==FALSE)
    {
        vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
        vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
        return FALSE;
    }

    return(TRUE);
}


/*****************************************************************************/
/*                           funcion : bfnEvalZonasImpos                     */
/*    Evalua las zonas impositivas del cliente y la oficina si estas son     */
/*    diferentes se asume la parametrizada en la tabla GED_PARAMETROS con    */
/*    el codigo 5.                                                           */
/*    Obs: piIndZonaImpCic -> obtenido desde la tabla ged_parametros         */
/*****************************************************************************/
BOOL bfnEvalZonasImpos (char *pszFecZonaImpo, int piTipoFact, int *iCodZonaImpo,
                        int piIndZonaImpCic)
{
char  szCodRegion    [4]="";
char  szCodProvincia [6]="";
char  szCodCiudad    [6]="";
int   iCodZonaImpoCli;
int   iCodZonaImpoOfi;
char  modulo[] = "bfnEvalZonasImpos";
char  pszCodOficina  [3]="";

    vDTrazasLog(modulo,"\n* Parametros Entrada %s "
                       "\n\t** stProceso.szCodOficina [%s] "
                       "\n\t** stCliente.szCodOficina [%s] "
                       "\n\t** Tipo documento         [%d] "
                       "\n\t** Ind. Tip Zona Impto.   [%d] "
                       ,LOG03,modulo, stProceso.szCodOficina,stCliente.szCodOficina, piTipoFact, piIndZonaImpCic);


    if (piTipoFact == FACT_CICLO && piIndZonaImpCic == ZICXOFICLIE)
    {
        strcpy(pszCodOficina,stCliente.szCodOficina);
        strcpy(stProceso.szCodOficina,pszCodOficina);
        if (bfnGetDirOficina (pszCodOficina, szCodRegion, szCodProvincia, szCodCiudad))
        {
            if (bGetZonaImpositiva(szCodRegion   ,
                                   szCodProvincia,
                                   szCodCiudad   ,
                                   &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
            {
                *iCodZonaImpo = iCodZonaImpoCli;
            }
            else
            {
                vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                return FALSE;
            }
        }
        else
        {
            vDTrazasError(modulo,"\n\t** En direccion de la oficina **",LOG01);
            vDTrazasLog  (modulo,"\n\t** En direccion de la oficina **",LOG01);
            return FALSE;
        }
        vDTrazasLog  (modulo,"\n\t** => Codigo de oficina [%s] **"
                             "\n\t** => Zona Impositiva   [%d] **"
                             ,LOG05,pszCodOficina,*iCodZonaImpo);
    }
    else
    {
        if(piTipoFact == FACT_CICLO && piIndZonaImpCic != ZICXOFICLIE)
        {
            if (bGetZonaImpositiva(stCliente.szCodRegion   ,
                                   stCliente.szCodProvincia,
                                   stCliente.szCodCiudad   ,
                                   &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
            {
                vDTrazasLog  (modulo,"\n\t** => iCodZonaImpoCli [%d] **",LOG05,iCodZonaImpoCli);
                *iCodZonaImpo = iCodZonaImpoCli;
            }
            else
            {
                vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                return FALSE;
            }


        }
        else
        {

            if (piTipoFact == FACT_MISCELAN)
            {
                if (!bfnGetDirOfiVend (stProceso.lCodVendedorAgente, pszCodOficina))
                {
                    vDTrazasError(modulo,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
                    vDTrazasLog  (modulo,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
                    return FALSE;
                }

                strcpy(stProceso.szCodOficina,pszCodOficina);


                vDTrazasLog  (modulo,"\n\t** Se asume zona impositiva del cliente  [%s] **", LOG05, pszCodOficina);

                if (bGetZonaImpositiva(stCliente.szCodRegion   ,
                                       stCliente.szCodProvincia,
                                       stCliente.szCodCiudad   ,
                                       &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
                {
                    *iCodZonaImpo = iCodZonaImpoCli;
                }
                else
                {
                    vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                    vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                    return FALSE;
                }
                vDTrazasLog  (modulo,"\n\t** Zona Impositiva del cliente  [%d] **", LOG05, iCodZonaImpoCli);

            }
            else
            {
                strcpy(pszCodOficina,stProceso.szCodOficina);
                vDTrazasLog  (modulo,"\n\t** Codigo de oficina [%s] **", LOG05, pszCodOficina);

                if (bfnGetDirOficina (pszCodOficina, szCodRegion, szCodProvincia, szCodCiudad))
                {
                    vDTrazasLog  (modulo,"\n\t** => stProceso.szCodOficina [%s], szCodRegion [%s], szCodProvincia [%s], szCodCiudad [%s]**"
                                        ,LOG05,stProceso.szCodOficina, szCodRegion, szCodProvincia, szCodCiudad);
                    if (bGetZonaImpositiva(szCodRegion   , szCodProvincia, szCodCiudad ,
                                           &iCodZonaImpoOfi, pszFecZonaImpo, piTipoFact))
                    {
                            if (bGetZonaImpositiva(stCliente.szCodRegion   ,
                                                   stCliente.szCodProvincia,
                                                   stCliente.szCodCiudad   ,
                                                   &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
                            {
                                vDTrazasLog  (modulo,"\n\t** => iCodZonaImpoCli [%d] **",LOG05,iCodZonaImpoCli);
                                if (iCodZonaImpoCli != iCodZonaImpoOfi)
                                {
                                    vDTrazasLog  (modulo,"\n\t** diferentes Zonas impositivas se toma la por defento [%d]**"
                                                 ,LOG04,pstParamGener.iZonaImpoDefec);
                                    *iCodZonaImpo = pstParamGener.iZonaImpoDefec;
                                }
                                else
                                {
                                    *iCodZonaImpo = iCodZonaImpoCli;
                                }
                            }
                            else
                            {
                                vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                                vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                                return FALSE;
                            }
                    }
                    else
                    {
                        vDTrazasError(modulo,"\n\t** En Zona impositiva de la oficina **",LOG01);
                        vDTrazasLog  (modulo,"\n\t** En Zona impositiva de la oficina **",LOG01);
                        return FALSE;
                    }
                }
                else
                {
                    vDTrazasError(modulo,"\n\t** En direccion de la oficina **",LOG01);
                    vDTrazasLog  (modulo,"\n\t** En direccion de la oficina **",LOG01);
                    return FALSE;
                }

            }
        }

    }

    vDTrazasLog  (modulo,"\n\t** => ZonaImpoCli [%d] **",LOG05, *iCodZonaImpo);

    return TRUE;
}/*************************** Final bfnEvalZonasImpos ************************/


/*****************************************************************************/
/*                           funcion : bfnGetZonaAbon                        */
/*    Obtiene la zona impositiva del Abonado, evalueando el parametro        */
/*    que indica el tipo de Facturacion                                       */
/*                                                                   */
/*****************************************************************************/
BOOL bfnGetZonaAbon (char *pszFecZonaImpo, int piTipoFact, int *iCodZonaImpo,
                        int piIndZonaImpCic)
{
char  szCodRegion    [4]="";
char  szCodProvincia [6]="";
char  szCodCiudad    [6]="";
int   iCodZonaImpoCli;
int   iCodZonaImpoOfi;
char  modulo[] = "bfnGetZonaAbon";
char  pszCodOficina  [3]="";


    vDTrazasLog(modulo,"\n**bfnGetZonaAbon \t** stProceso.szCodOficina [%s] stCliente.szCodOficina[%s]**"
                       "\n\t** Tipo documento [%d]\n **"
                       ,LOG05,stProceso.szCodOficina,stCliente.szCodOficina, piTipoFact);

    if (piTipoFact == FACT_CICLO && piIndZonaImpCic == ZICXOFICLIE)
    {
        strcpy(pszCodOficina,stCliente.szCodOficina);
        strcpy(stProceso.szCodOficina,pszCodOficina);
        if (bfnGetDirOficina (pszCodOficina, szCodRegion, szCodProvincia, szCodCiudad))
        {
            if (bGetZonaImpositiva(szCodRegion   ,
                                   szCodProvincia,
                                   szCodCiudad   ,
                                   &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
            {
                *iCodZonaImpo = iCodZonaImpoCli;
            }
            else
            {
                vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                return FALSE;
            }
        }
        else
        {
            vDTrazasError(modulo,"\n\t** En direccion de la oficina **",LOG01);
            vDTrazasLog  (modulo,"\n\t** En direccion de la oficina **",LOG01);
            return FALSE;
        }
        vDTrazasLog  (modulo,"\n\t** => Codigo de oficina [%s] **"
                             "\n\t** => Zona Impositiva   [%d] **"
                             ,LOG05,pszCodOficina,*iCodZonaImpo);
    }
    else
    {
        if (piTipoFact == FACT_MISCELAN)
        {
            if (!bfnGetDirOfiVend (stProceso.lCodVendedorAgente, pszCodOficina))
            {
                vDTrazasError(modulo,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
                vDTrazasLog  (modulo,"\n\t** ERROR, al obtener la oficina del vendedor **",LOG01);
                return FALSE;
            }
        }
        else
        {
            strcpy(pszCodOficina,stProceso.szCodOficina);
        }

        strcpy(stProceso.szCodOficina,pszCodOficina);

        vDTrazasLog  (modulo,"\n\t** Codigo de oficina [%s] **", LOG05, pszCodOficina);

        if (bfnGetDirOficina (pszCodOficina, szCodRegion, szCodProvincia, szCodCiudad))
        {
            vDTrazasLog  (modulo,"\n\t** => stProceso.szCodOficina [%s], szCodRegion [%s], szCodProvincia [%s], szCodCiudad [%s]**"
                                ,LOG05,stProceso.szCodOficina, szCodRegion, szCodProvincia, szCodCiudad);
            if (bGetZonaImpositiva(szCodRegion   , szCodProvincia, szCodCiudad ,
                                   &iCodZonaImpoOfi, pszFecZonaImpo, piTipoFact))
            {
                if (piTipoFact == FACT_MISCELAN)
                /* TM-200403170575. Si es MISCELANEA entonces se considera la zona impositiva de la oficina del vendedor*/
                {
                  *iCodZonaImpo = iCodZonaImpoOfi;
                }
                else
                {
                    if (bGetZonaImpositiva(stCliente.szCodRegion   ,
                                           stCliente.szCodProvincia,
                                           stCliente.szCodCiudad   ,
                                           &iCodZonaImpoCli, pszFecZonaImpo, piTipoFact))
                    {
                        vDTrazasLog  (modulo,"\n\t** => iCodZonaImpoCli [%d] **",LOG05,iCodZonaImpoCli);
                        if (iCodZonaImpoCli != iCodZonaImpoOfi)
                        {
                            vDTrazasLog  (modulo,"\n\t** diferentes Zonas impositivas se toma la por defento [%d]**"
                                         ,LOG04,pstParamGener.iZonaImpoDefec);
                            *iCodZonaImpo = pstParamGener.iZonaImpoDefec;
                        }
                        else
                        {
                            *iCodZonaImpo = iCodZonaImpoCli;
                        }
                    }
                    else
                    {
                        vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                        vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
                        return FALSE;
                    }
                }
            }
            else
            {
                vDTrazasError(modulo,"\n\t** En Zona impositiva de la oficina **",LOG01);
                vDTrazasLog  (modulo,"\n\t** En Zona impositiva de la oficina **",LOG01);
                return FALSE;
            }
        }
        else
        {
            vDTrazasError(modulo,"\n\t** En direccion de la oficina **",LOG01);
            vDTrazasLog  (modulo,"\n\t** En direccion de la oficina **",LOG01);
            return FALSE;
        }
    }

    vDTrazasLog(modulo,"\n**bfnGetZonaAbon\t** stProceso.szCodOficina [%s] stCliente.szCodOficina[%s]**\n"
                                                    ,LOG05,stProceso.szCodOficina,stCliente.szCodOficina);
        return TRUE;
}/*************************** Final bfnGetZonaAbon ************************/




/*****************************************************************************/
/*                           funcion : bfnGetOficina                         */
/*    Obtiene la region, provinci y ciudad de la oficina pasada              */
/*****************************************************************************/
BOOL bfnGetDirOficina (char *pszCodOficina, char *szCodRegion, char *szCodProvincia, char *szCodCiudad    )
{
char   modulo[] = "bfnGetOficina";

    OFICINA pstOficina;

    vDTrazasLog (modulo, "\n\t\t Cod Oficina: [%s] \n",LOG05,pszCodOficina);


    if (!bfnFindOficina (pszCodOficina, &pstOficina ))
    {
        vDTrazasLog (modulo, "\n\t\t Error Obtener oficina : [%s] \n",LOG01,pszCodOficina);
        return FALSE;
    }

    strcpy(szCodRegion   , pstOficina.szCodRegion);
    strcpy(szCodProvincia, pstOficina.szCodProvincia);
    strcpy(szCodCiudad   , pstOficina.szCodCiudad);


    return (TRUE);


}/*************************** Final bfnGetOficina ****************************/

/*****************************************************************************/
/*                           funcion : bfnGetDirAbonado                      */
/*    Obtiene la region, provincia y ciudad del usuario asociado al Abonado  */
/*    Adicionalmente, se rescata la zona impositiva del abonado              */
/*****************************************************************************/
BOOL bfnGetDirAbonado (long lNumAbonado, char *szCodRegion, char *szCodProvincia, char *szCodCiudad , char *szCodComuna, long *lCodUsuario
                       , int *iCodZonaImpAbon )
{
char   modulo[] = "bfnGetDirAbonado";


    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long  lhNumAbonado = 0L;
        int  ihCodZonaImpAbon     = 0;
        char szhCodRegion    [4];/* EXEC SQL VAR szhCodRegion    IS STRING(4); */ 

        char szhCodProvincia [6];/* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

        char szhCodCiudad    [6];/* EXEC SQL VAR szhCodCiudad    IS STRING(6); */ 

        char szhCodComuna    [6];/* EXEC SQL VAR szhCodComuna    IS STRING(6); */ 

        static long lhCodUsuario;
        char szhCodTipDirec  [2];/* EXEC SQL VAR szhCodTipDirec  IS STRING(2); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (modulo, "\n\t\t Num Abonado: [%ld] \n",LOG05,lNumAbonado);


    lhNumAbonado= lNumAbonado;

    sprintf(szhCodTipDirec, "2\0");

    /* EXEC SQL
        SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, B.COD_COMUNA, C.COD_USUARIO, E.COD_ZONAIMPO
          INTO :szhCodRegion, :szhCodProvincia,:szhCodCiudad, :szhCodComuna, :lhCodUsuario, :ihCodZonaImpAbon
          FROM GE_DIRECCIONES B ,GA_DIRECUSUAR C, GA_ABOCEL D, GE_ZONACIUDAD E
         WHERE D.NUM_ABONADO      = :lhNumAbonado
           AND C.COD_USUARIO      = D.COD_USUARIO
           AND C.COD_TIPDIRECCION = :szhCodTipDirec
           AND C.COD_DIRECCION    = B.COD_DIRECCION
           AND E.COD_REGION       = B.COD_REGION
           AND E.COD_PROVINCIA    = B.COD_PROVINCIA
           AND E.COD_CIUDAD       = B.COD_CIUDAD; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select B.COD_REGION ,B.COD_PROVINCIA ,B.COD_CIUDAD ,B.COD\
_COMUNA ,C.COD_USUARIO ,E.COD_ZONAIMPO into :b0,:b1,:b2,:b3,:b4,:b5  from GE_D\
IRECCIONES B ,GA_DIRECUSUAR C ,GA_ABOCEL D ,GE_ZONACIUDAD E where ((((((D.NUM_\
ABONADO=:b6 and C.COD_USUARIO=D.COD_USUARIO) and C.COD_TIPDIRECCION=:b7) and C\
.COD_DIRECCION=B.COD_DIRECCION) and E.COD_REGION=B.COD_REGION) and E.COD_PROVI\
NCIA=B.COD_PROVINCIA) and E.COD_CIUDAD=B.COD_CIUDAD)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )285;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodRegion;
    sqlstm.sqhstl[0] = (unsigned long )4;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCiudad;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodComuna;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodUsuario;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihCodZonaImpAbon;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhNumAbonado;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodTipDirec;
    sqlstm.sqhstl[7] = (unsigned long )2;
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




    if (SQLCODE)
    {
       iDError (szExeName,ERR000,vInsertarIncidencia,"Open=> Dir Usuario Abonado",
                 szfnORAerror ());
       return FALSE;
    }
    else
    {
        strcpy (szCodRegion , szhCodRegion  );
        strcpy (szCodProvincia  , szhCodProvincia);
        strcpy (szCodCiudad , szhCodCiudad  );
        strcpy (szCodComuna , szhCodComuna  );
        *lCodUsuario=lhCodUsuario;
        *iCodZonaImpAbon= ihCodZonaImpAbon;
    }

    return (TRUE);

}/*************************** Final bfnGetDirAbonado ****************************/



/*****************************************************************************/
/*                           funcion : bfnGetDirOfiVend                      */
/*    Obtiene la region, provinci y ciudad de la oficina pasada              */
/*****************************************************************************/
BOOL bfnGetDirOfiVend (long lCodVendedor, char *szCodOficina )
{

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long  lhCodVendedor;
        static char  szhCodOficina   [3]; /* EXEC SQL VAR szhCodOficina   IS STRING(3) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodVendedor=lCodVendedor;

    /* EXEC SQL
        SELECT  COD_OFICINA
          INTO  :szhCodOficina
          FROM  VE_VENDEDORES
         WHERE  COD_VENDEDOR = :lhCodVendedor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 11;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA into :b0  from VE_VENDEDORES where COD\
_VENDEDOR=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )332;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodVendedor;
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



    if (SQLCODE)
        return FALSE;

    strcpy(szCodOficina,szhCodOficina);

    return (TRUE);

}/************************** Final bfnGetDirOfiVend **************************/


/*****************************************************************************/
/*                           funcion : bfnProcDctoIEPS                       */
/*    Procesa el descuento a los conceptos de impuesto IEPS                  */
/*****************************************************************************/
BOOL bfnProcDctoIEPS (int iTipoFact)
{
char   modulo[] = "bfnProcDctoIEPS";

    int     i               = 0;
    int     iNumConceptos   = 0;
    int     iNumRegIni      = 0;

    CONCEPTO stConcepto                     ;

    vDTrazasLog  (modulo,"\n\t** Entrada en %s  **",LOG04, modulo);

    iNumRegIni = stPreFactura.iNumRegistros;

    for (i=0;i<iNumRegIni;i++)
    {
        if (stPreFactura.A_PFactura[i].iCodConcepto == pstFadParam.iConcIEPS)
        {
            vDTrazasLog (modulo,  "\n\t\t* Aplica Descuento IEPS "
                                  "\n\t\t=> Cod.TipConce [%d]"
                                  "\n\t\t=> Ind.Factur   [%d]", LOG04,
                                  stPreFactura.A_PFactura[i].iCodTipConce ,
                                  stPreFactura.A_PFactura[i].iIndFactur   );

            iNumConceptos = stPreFactura.iNumRegistros;
            stPreFactura.A_PFactura[iNumConceptos].dImpConcepto  =
                    (double)(stPreFactura.A_PFactura[i].dImpConcepto * -1);
            stPreFactura.A_PFactura[iNumConceptos].dImpMontoBase =
                    stPreFactura.A_PFactura[i].dImpConcepto;           
            stPreFactura.A_PFactura[iNumConceptos].dImpFacturable  = 
                    fnCnvDouble(stPreFactura.A_PFactura[iNumConceptos].dImpConcepto,0);
            
            if (!bConversionMoneda (stCliente.lCodCliente                                ,
                                    stPreFactura.A_PFactura[i].szCodMoneda               ,
                                    stDatosGener.szCodMoneFact                           ,
                                    szSysDate                                            ,
                                   &stPreFactura.A_PFactura[iNumConceptos].dImpFacturable))
                return FALSE; /* P-MIX-09003 4 */                       
                   
            stPreFactura.A_PFactura[iNumConceptos].dImpFacturable =
                    fnCnvDouble (stPreFactura.A_PFactura[iNumConceptos].dImpFacturable,0);
             
            memset (&stConcepto,0,sizeof(CONCEPTO))                   ;
            if (!bFindConcepto (pstFadParam.iConcDctoIEPS, &stConcepto))
                return FALSE;

            stPreFactura.A_PFactura[iNumConceptos].iCodConcepto = pstFadParam.iConcDctoIEPS ;

            strcpy (stPreFactura.A_PFactura[iNumConceptos].szDesConcepto ,
                    stConcepto.szDesConcepto);

            if (!bfnAplicaImpto(i, iNumConceptos, iTipoFact))
            {
                vDTrazasError(modulo,"\n\t** ERROR, en creacion del concepto de Impto. **",LOG01);
                return (FALSE);
            }

            /* Se modifican los campos que corresponden a impuestos */

            strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecValor , stPreFactura.A_PFactura[i].szFecValor );
            stPreFactura.A_PFactura[iNumConceptos].bOptImpuesto = FALSE;
            strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecEfectividad , stPreFactura.A_PFactura[i].szFecEfectividad);
            stPreFactura.A_PFactura[i].iIndEstado               = EST_NORMAL;
            stPreFactura.A_PFactura[iNumConceptos].iCodTipConce = DESCUENTO ;
            stPreFactura.A_PFactura[i].iFlagImpues              = 0  ;


            /* **************************************************** */

            vDTrazasLog (modulo, "\n\t\t Descuento IEPS al concepto %d del cliente %ld\n",
                                 LOG04,stPreFactura.A_PFactura[i].iCodConcepto,
                                 stPreFactura.A_PFactura[i].lCodCliente );

        } /* iCodConcepto[i] == pstFadParam.iConcIEPS */
    }/* fin for i<iNumRegIni */
    return (TRUE);

}/*************************** Final bfnProcDctoIEPS **************************/


/*****************************************************************************/
/*                           funcion : bfnProcDctoIEPSNC                     */
/*    Procesa el descuento a los conceptos de impuesto IEPS                  */
/*****************************************************************************/
BOOL bfnProcDctoIEPSNC (int iTipoFact)
{
char   modulo[] = "bfnProcDctoIEPSNC";

    int     i               = 0;
    int     iNumConceptos   = 0;
    int     iNumRegIni      = 0;

    CONCEPTO stConcepto                     ;

    vDTrazasLog  (modulo,"\n\t** Entrada en %s  **",LOG04, modulo);

    iNumRegIni = stPreFactura.iNumRegistros;

    for (i=0;i<iNumRegIni;i++)
    {
        if (stPreFactura.A_PFactura[i].iCodConcepto == pstFadParam.iConcIEPS)
        {
            vDTrazasLog (modulo, "\n\t\t* Aplica Descuento IEPS "
                              "\n\t\t=> Cod.TipConce [%d]"
                              "\n\t\t=> Ind.Factur   [%d]", LOG04,
                              stPreFactura.A_PFactura[i].iCodTipConce ,
                              stPreFactura.A_PFactura[i].iIndFactur   );

            iNumConceptos = stPreFactura.iNumRegistros;
            stPreFactura.A_PFactura[iNumConceptos].dImpConcepto  =
                    (double)(stPreFactura.A_PFactura[i].dImpConcepto * -1);
            stPreFactura.A_PFactura[iNumConceptos].dImpMontoBase =
                    stPreFactura.A_PFactura[i].dImpConcepto;                  
            stPreFactura.A_PFactura[iNumConceptos].dImpFacturable  = 
                    fnCnvDouble(stPreFactura.A_PFactura[iNumConceptos].dImpConcepto, 0 );

            if (!bConversionMoneda (stCliente.lCodCliente                                ,
                                    stPreFactura.A_PFactura[i].szCodMoneda               ,
                                    stDatosGener.szCodMoneFact                           ,
                                    szSysDate                                            ,
                                   &stPreFactura.A_PFactura[iNumConceptos].dImpFacturable))
                return FALSE; /* P-MIX-09003 4 */                    
						
            stPreFactura.A_PFactura[iNumConceptos].dImpFacturable = fnCnvDouble(stPreFactura.A_PFactura[iNumConceptos].dImpFacturable, 0);

            memset (&stConcepto,0,sizeof(CONCEPTO))                   ;
            if (!bFindConcepto (pstFadParam.iConcDctoIEPS, &stConcepto))
                return FALSE;

            stPreFactura.A_PFactura[iNumConceptos].iCodConcepto = pstFadParam.iConcDctoIEPS ;

            strcpy (stPreFactura.A_PFactura[iNumConceptos].szDesConcepto ,
                    stConcepto.szDesConcepto);

            if (!bfnAplicaImpto(i, iNumConceptos, iTipoFact))
            {
                vDTrazasError(modulo,"\n\t** ERROR, en cracion del concepto de Impto. **",LOG01);
                return (FALSE);
            }


            /* Se modifican los campos que corresponden a impuestos */

            strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecValor , stPreFactura.A_PFactura[i].szFecValor );
            stPreFactura.A_PFactura[iNumConceptos].bOptImpuesto = FALSE;
            strcpy(stPreFactura.A_PFactura[iNumConceptos].szFecEfectividad, stPreFactura.A_PFactura[i].szFecEfectividad);
            stPreFactura.A_PFactura[i].iIndEstado   = EST_NORMAL;
            stPreFactura.A_PFactura[iNumConceptos].iCodTipConce = DESCUENTO ;
            stPreFactura.A_PFactura[i].iFlagImpues   = 0  ;

            /* **************************************************** */

            vDTrazasLog (modulo, "\n\t\t Descuento IEPS al concepto %d del cliente %ld\n",
                                 LOG04,stPreFactura.A_PFactura[i].iCodConcepto,
                                 stPreFactura.A_PFactura[i].lCodCliente );

        } /* iCodConcepto[i] == pstFadParam.iConcIEPS */
    }/* fin for i<iNumRegIni */

    return (TRUE);

}/*************************** Final bfnProcDctoIEPSNC **************************/

/** Desde aqui impuesto Maicao **/
/*
 * Funcion      : bfnProcImptoMaicao
 * Descripcion  : Funcion de procesamiento impuesto Maicao.
 */
BOOL bfnProcImptoMaicao(int iTipoFact, char *pszFecZonaImp)
{

    char    *modulo            = "bfnProcImptoMaicao";
    int     iCodGrpServi      = 0;
    register int i          = 0;
    register int j          = 0;
    int     iNumRegistros   = 0;
    int     iNumConcRev     = 0;
    double  dSumConcNetos   = 0.0;
    long    *lConcRevisados = NULL;
    BOOL    bExisteConc     = FALSE;
    BOOL    bRebajaConcepto = FALSE;
    BOOL    bConcVigente    = FALSE;

    GRPSERCONC     stGrpSerConc;
    COD_IMPTODCTOS stCodZonas;

    vDTrazasLog  (modulo,"\n\t** Dentro de la funcion bfnProcImptoMaicao() **"
                         "\n\t** iTipoFact     [%d] **"
                         "\n\t** pszFecZonaImp [%s] **"
                        ,LOG05
                        ,iTipoFact
                        ,pszFecZonaImp);


    memset (&stGrpSerConc,0,sizeof(GRPSERCONC));
    memset (&stCodZonas  ,0,sizeof(COD_IMPTODCTOS));


    /* Sumar Conceptos netos */
    dSumConcNetos = dfnSumarConceptosNetos();

    vDTrazasLog  (modulo,"\n\t** (bfnProcImptoMaicao) stPreFactura.iNumRegistros :[%d] **"
                        , LOG06
                        , stPreFactura.iNumRegistros);

    iNumRegistros = stPreFactura.iNumRegistros;

    /* Recorrer la estructura stPreFactura */
    for(i=0; i < iNumRegistros; i++)
    {
        if (stPreFactura.A_PFactura[i].dImpConcepto > 0.0)
        {
            vDTrazasLog  (modulo,"\n\t** (bfnProcImptoMaicao) En for(i)-stPreFactura, i:[%d], CodCliente:[%ld] **"
                                , LOG06
                                , i
                                , stCliente.lCodCliente);

            /* Obtener codigos de zona para su validacion posterior */
            if(!bfnCargarCodigosZona(&stCodZonas, pszFecZonaImp, stPreFactura.A_PFactura[i].lNumAbonado, iTipoFact))
            {
                vDTrazasLog  (modulo, "\n\t\t* En funcion bfnCargarCodigosZona().", LOG01);
                vDTrazasError(modulo, "\n\t\t* En funcion bfnCargarCodigosZona().", LOG01);
                return FALSE;
            }

            /* Obtencion del codigo de grupo de servicio del concepto */
            if (!bGetGrupoServicios (stPreFactura.A_PFactura[i].iCodConcepto, &iCodGrpServi,pszFecZonaImp,iTipoFact))
            {
                vDTrazasLog  (modulo, "\n\t\t* No se encuentra Codigo de grupo de servicio.", LOG01);
                vDTrazasError(modulo, "\n\t\t* No se encuentra Codigo de grupo de servicio.", LOG01);
                return FALSE;
            }
            /* Busqueda del grupo de servicio en la estructura de impuestos a los documentos */
            j=0;
            while(j < pstImptoDctos.iNumImptosDctos)
            {
                vDTrazasLog  (modulo, "\n\t\t* (bfnProcImptoMaicao) Dentro de while(j)..."
                                      "\n\t\t* j                                         :[%d] "
                                      "\n\t\t* pstImptoDctos.stImptoDcto[j].lCodGprservi :[%ld] "
                                      "\n\t\t* (long)iCodGrpServi                        :[%ld] "
                                    , LOG06
                                    , j
                                    , pstImptoDctos.stImptoDcto[j].lCodGprservi
                                    , (long)iCodGrpServi);

                bExisteConc  = bfnExisteConcRev(pstImptoDctos.stImptoDcto[j].lCodConcepto,lConcRevisados, iNumConcRev);
                bConcVigente = bfnVerificarVigConc(pstImptoDctos.stImptoDcto[j], pszFecZonaImp);

                vDTrazasLog  (modulo, "\n\t\t* bExisteConc  :[%d]"
                                      "\n\t\t* bConcVigente :[%d]"
                                    , LOG06
                                    , bExisteConc
                                    , bConcVigente);

                /* Es el codigo de grupo de servicio de impuesto igual al de concepto de prefactura ? */
                /* y ademas el concepto de impuesto no esta entre los ya generados?                   */
                /* y el concepto de impuestos esta vigente? */
                if( (pstImptoDctos.stImptoDcto[j].lCodGprservi == (long)iCodGrpServi)
                        && (bExisteConc  == FALSE)
                        && (bConcVigente == TRUE ) )
                {
                    /* De acuerdo al tipo de facturacion que se este realizando    */
                    /* Se comprueba validacion de rebaja total de concepto para NC */
                    if(iTipoFact == FACT_NOTACRED || iTipoFact == FACT_NOTADEBI)
                        bRebajaConcepto = bfnValidarRebImptosDctos(pstImptoDctos.stImptoDcto[j], pszFecZonaImp);
                    else
                        bRebajaConcepto = TRUE;

                    /* Validar internamente direcciones y, en el caso de NC rebaja total del concepto */
                    /* XO-200607241178 FAAR 20060725 Se agrega validación de iCodCatImpos */
                    if( bfnValidarZonaDeCargo(pstImptoDctos.stImptoDcto[j], stCodZonas) &&
                                              pstImptoDctos.stImptoDcto[j].iCodCatImpos == stCliente.iCodCatImpos &&
                                              bRebajaConcepto == TRUE)
                    {
                        /* generar Impuesto al documento */
                        bfnGenerarImptoAlDcto(iTipoFact, pstImptoDctos.stImptoDcto[j], stCodZonas, dSumConcNetos);
                        /* Marcar este concepto como revisado */
                        iNumConcRev++;
                        lConcRevisados = (long*) realloc (lConcRevisados, iNumConcRev * sizeof(long));
                        if (lConcRevisados == NULL)
                        {
                            vDTrazasLog  (modulo, "\n\t\t* Al asignar memoria para conceptos revisados.", LOG01);
                            vDTrazasError(modulo, "\n\t\t* Al asignar memoria para conceptos revisados.", LOG01);
                        }
                        lConcRevisados[iNumConcRev-1] = pstImptoDctos.stImptoDcto[j].lCodConcepto;

                        /* Ir al siguiente concepto de impuestos de la estructura*/
                        vDTrazasLog  (modulo,"\n\t** j antes de entrar a funcion ifnBuscarSgteConceptoImpto()  :[%d] **",LOG06,j);
                        j = ifnBuscarSgteConceptoImpto(j);
                        vDTrazasLog  (modulo,"\n\t** j despues de entrar a funcion ifnBuscarSgteConceptoImpto():[%d] **",LOG06,j);

                    }
                    else
                    {
                        /* Avanzar al siguiente registro */
                        j++;
                    }

                }
                else
                {
                    /* Avanzar al siguiente registro */
                    j++;
                }

            }/* fin while(j < pstImptoDctos.iNumImptosDctos) */

        }/* fin for(i=0;i<stPreFactura.iNumRegistros;i++) */
    }

    free(lConcRevisados);
    vDTrazasLog  (modulo,"\n\t** Saliendo de la funcion bfnProcImptoMaicao() **",LOG05);

    return TRUE;

}

/*
 * Funcion      : bfnValidarZonaDeCargo
 * Descripcion  : Realizar validacion de datos para verificar si se debe generar un impuesto al documento.
 */
BOOL bfnValidarZonaDeCargo(IMPTODCTO stImptoDcto, COD_IMPTODCTOS stCodZonas)
{

    char    *modulo = "bfnValidarZonaDeCargo";

    vDTrazasLog  (modulo,"\n\t** Dentro de la funcion [%s] **",LOG05, modulo);

    vDTrazasLog  (modulo,"\n\t** Parametros de comparacion :      **"
                         "\n\t** stImptoDcto.iTipZonacargo  : [%d]**"
                         "\n\t** stImptoDcto.iTipEvaluacion : [%d]**"
                         "\n\t** stImptoDcto.szCodZonacargo:  [%s]**"
                         "\n\t** stImptoDcto.szCodRegion    : [%s]**"
                         "\n\t** stImptoDcto.szCodProvincia : [%s]**"
                        ,LOG06
                        ,stImptoDcto.iTipZonacargo
                        ,stImptoDcto.iTipEvaluacion
                        ,stImptoDcto.szCodZonacargo
                        ,stImptoDcto.szCodRegion
                        ,stImptoDcto.szCodProvincia);


    /* Tipo de zona de cargo: zona impositiva de la direccion */
    if(stImptoDcto.iTipZonacargo == giCodZonaImpDir)
    {
        /* Ninguna validacion */
        if( stImptoDcto.iTipEvaluacion== giNoEvaluar )
            return TRUE;

        /* Validacion de cliente y abonado */
        if( stImptoDcto.iTipEvaluacion == giEvalClieAbon)
        {
            if( (stCodZonas.iCodZonaImpCliente == atoi(stImptoDcto.szCodZonacargo))
                    && (stCodZonas.iCodZonaImpAbon == atoi(stImptoDcto.szCodZonacargo)) )
                return TRUE;
        }
        /* Validacion de cliente */
        else if( stImptoDcto.iTipEvaluacion == giEvalCliente)
        {
            if( stCodZonas.iCodZonaImpCliente == atoi(stImptoDcto.szCodZonacargo) )
                return TRUE;

        }
        /* Validacion de abonado */
        else if( stImptoDcto.iTipEvaluacion == giEvalAbonado )
        {
            if( stCodZonas.iCodZonaImpAbon == atoi(stImptoDcto.szCodZonacargo))
                return TRUE;
        }
    }
    /* Tipo de zona de cargo: Codigo de provincia */
    else if( stImptoDcto.iTipZonacargo == giCodProvincia)
    {
        /* Ninguna validacion */
        if( stImptoDcto.iTipEvaluacion == giNoEvaluar)
            return TRUE;

        /* Validacion de cliente y abonado */
        if( stImptoDcto.iTipEvaluacion == giEvalClieAbon )
        {
            if( !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodProvAbon, stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodRegion))
                return TRUE;
        }
        /* Validacion de cliente */
        else if( stImptoDcto.iTipEvaluacion == giEvalCliente )
        {
            if( !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion) )
                return TRUE;
        }
        /* Validacion de abonado */
        else if( stImptoDcto.iTipEvaluacion == giEvalAbonado )
        {
            if( !strcmp(stCodZonas.szCodProvAbon, stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodRegion))
                return TRUE;
        }
    }
    /* Tipo de zona de cargo: Codigo de region */
    else if( stImptoDcto.iTipZonacargo == giCodRegion)
    {
        /* Ninguna validacion */
        if( stImptoDcto.iTipEvaluacion == giNoEvaluar)
            return TRUE;

        /* Validacion de cliente y abonado */
        if( stImptoDcto.iTipEvaluacion == giEvalClieAbon)
        {
            if( !strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodZonacargo) )
                return TRUE;
        }
        /* Validacion de cliente */
        else if( stImptoDcto.iTipEvaluacion == giEvalCliente)
        {
            if( !strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodZonacargo) )
                return TRUE;

        }
        /* Validacion de abonado */
        else if( stImptoDcto.iTipEvaluacion == giEvalAbonado)
        {
            if( !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodZonacargo))
                return TRUE;
        }
    }
    /* Tipo de zona de cargo: Codigo de Ciudad */
    else if( stImptoDcto.iTipZonacargo == giCodCiudad)
    {
        /* Ninguna validacion */
        if( stImptoDcto.iTipEvaluacion == giNoEvaluar)
            return TRUE;

        /* Validacion de cliente y abonado */
        if( stImptoDcto.iTipEvaluacion == giEvalClieAbon)
        {
            if( !strcmp(stCodZonas.szCodCiudadCliente,stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodCiudadAbon, stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodProvincia)
                    && !strcmp(stCodZonas.szCodProvAbon,  stImptoDcto.szCodProvincia) )
                return TRUE;
        }
        /* Validacion de cliente */
        else if( stImptoDcto.iTipEvaluacion == giEvalCliente )
        {
            if( !strcmp(stCodZonas.szCodCiudadCliente,stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodProvincia) )
                return TRUE;
        }
        /* Validacion de abonado */
        else if( stImptoDcto.iTipEvaluacion == giEvalAbonado)
        {
            if( !strcmp(stCodZonas.szCodCiudadAbon, stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionAbon,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvAbon,stImptoDcto.szCodProvincia) )
                return TRUE;
        }
    }
    /* Tipo de zona de cargo: Codigo de Comuna */
    else if( stImptoDcto.iTipZonacargo == giCodComuna)
    {
        /* Ninguna validacion */
        if( stImptoDcto.iTipEvaluacion == giNoEvaluar)
            return TRUE;

        /* Validacion de cliente y abonado */
        if( stImptoDcto.iTipEvaluacion == giEvalClieAbon)
        {
            if( !strcmp(stCodZonas.szCodComunaCliente,stImptoDcto.szCodZonacargo)
                    && !strcmp(stCodZonas.szCodComunaAbon, stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodRegionAbon, stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodProvincia)
                    && !strcmp(stCodZonas.szCodProvAbon,  stImptoDcto.szCodProvincia) )
                return TRUE;
        }
        /* Validacion de cliente */
        else if( stImptoDcto.iTipEvaluacion == giEvalCliente )
        {
            if( !strcmp(stCodZonas.szCodComunaCliente,stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionCliente,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvCliente,stImptoDcto.szCodProvincia) )
                return TRUE;

        }
        /* Validacion de abonado */
        else if( stImptoDcto.iTipEvaluacion == giEvalAbonado)
        {
            if( !strcmp(stCodZonas.szCodComunaAbon, stImptoDcto.szCodZonacargo)
                    &&!strcmp(stCodZonas.szCodRegionAbon,stImptoDcto.szCodRegion)
                    && !strcmp(stCodZonas.szCodProvAbon,stImptoDcto.szCodProvincia) )
                return TRUE;

        }
    }

    /* El valor por defecto es FALSE */
    return FALSE;
}

/*
 * Funcion      : bfnGenerarImptoAlDcto
 * Descripcion  : Generacion del impuesto al documento
 */
BOOL bfnGenerarImptoAlDcto(int iTipoFact, IMPTODCTO stImptoDcto, COD_IMPTODCTOS stCodZonas, double dSumConcNetos)
{
    int iIdxNew = 0;

    CONCEPTO stConcepto;

    char    *modulo = "bfnGenerarImptoAlDcto";

    vDTrazasLog  (modulo,"\n\t** Dentro de la funcion [%s] **",LOG05, modulo);

    iIdxNew = stPreFactura.iNumRegistros;

    stPreFactura.A_PFactura[iIdxNew].iCodConcepto = (int)stImptoDcto.lCodConcepto;

    memset (&stConcepto,0,sizeof(CONCEPTO))                   ;

    if (!bFindConcepto (stPreFactura.A_PFactura[iIdxNew].iCodConcepto, &stConcepto))
    {
        vDTrazasLog (szExeName, "\n\t\t* No se encuentra detalle de concepto de Impto Dcto ", LOG01);
        return FALSE;
    }
    strcpy(stPreFactura.A_PFactura[iIdxNew].szDesConcepto, stConcepto.szDesConcepto);


    if (!bGetMaxColPreFa
            (stPreFactura.A_PFactura[iIdxNew].iCodConcepto,
            &stPreFactura.A_PFactura[iIdxNew].lColumna ))
        return FALSE;


    stPreFactura.A_PFactura[iIdxNew].bOptImpuesto = FALSE;
    stPreFactura.A_PFactura[iIdxNew].lNumProceso  = stPreFactura.A_PFactura[0].lNumProceso;
    stPreFactura.A_PFactura[iIdxNew].lCodCliente  = stPreFactura.A_PFactura[0].lCodCliente;
    stPreFactura.A_PFactura[iIdxNew].iCodProducto = 1;

    strcpy(stPreFactura.A_PFactura[iIdxNew].szCodMoneda , stPreFactura.A_PFactura[0].szCodMoneda) ;

    vDTrazasLog  (modulo,"\n\t** stImptoDcto.szTipValor     [%s] **"
                         "\n\t** stImptoDcto.dImpfacturable [%f] **"
                         "\n\t** dSumConcNetos              [%f] **"
                        ,LOG06
                        ,stImptoDcto.szTipValor
                        ,stImptoDcto.dImpfacturable
                        ,dSumConcNetos);

    switch(stImptoDcto.szTipValor[0])
    {
        case 'M':
            stPreFactura.A_PFactura[iIdxNew].dImpConcepto    = stImptoDcto.dImpfacturable ;
            stPreFactura.A_PFactura[iIdxNew].dImpFacturable  = fnCnvDouble(stImptoDcto.dImpfacturable, 0) ;
            break;

        case 'P':
            stPreFactura.A_PFactura[iIdxNew].dImpConcepto    = (stImptoDcto.dImpfacturable/100) * dSumConcNetos;
            stPreFactura.A_PFactura[iIdxNew].dImpFacturable  = fnCnvDouble(((stImptoDcto.dImpfacturable/100) * dSumConcNetos), 0);
            break;

        default:
            /* Por defecto se asume monto (M)*/
            stPreFactura.A_PFactura[iIdxNew].dImpConcepto    = stImptoDcto.dImpfacturable ;
            stPreFactura.A_PFactura[iIdxNew].dImpFacturable  = fnCnvDouble(stImptoDcto.dImpfacturable,0) ;
            break;

    }

    switch (iTipoFact)
    {
        case FACT_CICLO      :
        case FACT_BAJA       :
            strcpy (stPreFactura.A_PFactura[iIdxNew].szFecValor ,
                    stCiclo.szFecEmision);
            break;
        case FACT_CONTADO    :
        case FACT_COMPRA     :
        case FACT_MISCELAN   :
        case FACT_LIQUIDACION:
        case FACT_RENTAPHONE :
        case FACT_ROAMINGVIS :
            strcpy (stPreFactura.A_PFactura[iIdxNew].szFecValor,
                    szSysDate);
            break;
        case FACT_NOTACRED   :
        case FACT_NOTADEBI   :
            strcpy (stPreFactura.A_PFactura[iIdxNew].szFecValor,
                    stNota.szFecEmision);
            break;
        default              :
            break;
    }

    strcpy(stPreFactura.A_PFactura[iIdxNew].szFecEfectividad, szSysDate);
    
    /* 38937 PPV 30/03/2007 Se pasa el codigo de ciudad del cliente */
    if (strlen(stCodZonas.szCodCiudadCliente)==0) strcpy (stCodZonas.szCodCiudadCliente,stCliente.szCodCiudad);


    strcpy (stPreFactura.A_PFactura[iIdxNew].szCodCiudad      , stCodZonas.szCodCiudadCliente);
    strcpy (stPreFactura.A_PFactura[iIdxNew].szCodRegion     , stCodZonas.szCodRegionCliente);
    strcpy (stPreFactura.A_PFactura[iIdxNew].szCodProvincia, stCodZonas.szCodProvCliente);
    strcpy (stPreFactura.A_PFactura[iIdxNew].szCodCuota        , "0") ;

    strcpy(stPreFactura.A_PFactura[iIdxNew].szCodModulo , "FA");
    stPreFactura.A_PFactura[iIdxNew].iIndFactur   = 1;   /* FACTURABLE;  */

    stPreFactura.A_PFactura[iIdxNew].iIndEstado   = EST_NORMAL;
    stPreFactura.A_PFactura[iIdxNew].iCodTipConce = IMPUESTO  ;
    stPreFactura.A_PFactura[iIdxNew].lNumUnidades = 1;
    stPreFactura.A_Ind[iIdxNew].i_lCodCiclFact    = (stCiclo.lCodCiclFact == ORA_NULL)?ORA_NULL:SQLOK;
    stPreFactura.A_PFactura[iIdxNew].iCodConceRel = 0;
    stPreFactura.A_PFactura[iIdxNew].lColumnaRel  = 0;
    stPreFactura.A_PFactura[iIdxNew].lNumAbonado  = 0;
    stPreFactura.A_Ind[iIdxNew].i_lNumAbonado     = 0;
    stPreFactura.A_Ind[iIdxNew].i_szNumTerminal   = -1;
    stPreFactura.A_Ind[iIdxNew].i_lCapCode        = -1;
    stPreFactura.A_Ind[iIdxNew].i_szNumSerieMec   = -1;
    stPreFactura.A_Ind[iIdxNew].i_szNumSerieLe    = -1;
    stPreFactura.A_PFactura[iIdxNew].iFlagImpues   = 0  ;
    stPreFactura.A_PFactura[iIdxNew].iFlagDto      = 0  ;
    stPreFactura.A_PFactura[iIdxNew].iFlagDto      = 0  ;
    stPreFactura.A_PFactura[iIdxNew].dValDto       = -1 ;
    stPreFactura.A_Ind[iIdxNew].i_dValDto          = -1 ;
    stPreFactura.A_PFactura[iIdxNew].iTipDto       = -1 ;
    stPreFactura.A_Ind[iIdxNew].i_iTipDto          = -1 ;
    stPreFactura.A_PFactura[iIdxNew].lNumVenta     = stVenta.lNumVenta;
    stPreFactura.A_Ind[iIdxNew].i_lNumVenta        = (stVenta.lNumVenta == ORA_NULL)?-1:0;

    stPreFactura.A_PFactura[iIdxNew].lNumTransaccion = -1;
    stPreFactura.A_Ind[iIdxNew].i_lNumTransaccion  = -1;
    stPreFactura.A_PFactura[iIdxNew].iMesGarantia  = 0;
    stPreFactura.A_PFactura[iIdxNew].iIndAlta      = 1;
    stPreFactura.A_PFactura[iIdxNew].iIndSuperTel  = 0;
    stPreFactura.A_PFactura[iIdxNew].iNumPaquete   =-1;
    stPreFactura.A_Ind[iIdxNew].i_iNumPaquete      =-1;
    stPreFactura.A_PFactura[iIdxNew].iIndCuota     = 0;
    stPreFactura.A_PFactura[iIdxNew].iNumCuotas    = 0;
    stPreFactura.A_PFactura[iIdxNew].iOrdCuota     = 0;

    stPreFactura.A_PFactura[iIdxNew].dhImpConversion =  stPreFactura.A_PFactura[0].dhImpConversion;

    strcpy(stPreFactura.A_PFactura[iIdxNew].szhCodMonedaImp , stPreFactura.A_PFactura[0].szhCodMonedaImp);

    /* stPreFactura.iNumRegistros++; */
    if(bfnIncrementarIndicePreFactura()==FALSE)
    {
        vDTrazasLog  (szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
        vDTrazasError(szExeName,">> ERROR: Al Intentar Aumentar memoria de stPreFactura  <<",LOG01);
        return FALSE;
    }


    vDTrazasLog  (modulo,"\n\t** Saliendo de la funcion [%s] **",LOG05, modulo);

    return(TRUE);

}


/*
 * Funcion      : bfnCargarCodigosZona
 * Descripcion  : Cargar los codigos necesarios para la posterior  utilizacion en validacion de zonas en Maicao.
 */
BOOL bfnCargarCodigosZona(COD_IMPTODCTOS *pstCodZonas, char *pszFecZonaImpo,long lNumAbonado, int iTipoFact)
{
    char    *modulo = "vfnCargarCodigosZona";
    char    szCodRegion   [4];
    char    szCodProvincia[6];
    char    szCodCiudad   [6];
    char    szCodComuna   [6];
    int     iCodZonaImp;
    long    lCodUsuario;


    vDTrazasLog  (modulo,"\n\t** Dentro de la funcion [%s] **",LOG05, modulo);

    /* Cargar Codigos de zona impositiva de cliente y abonado */
    if (bGetZonaImpositiva(stCliente.szCodRegion   ,
                           stCliente.szCodProvincia,
                           stCliente.szCodCiudad   ,
                           &iCodZonaImp, pszFecZonaImpo, iTipoFact))
    {
        vDTrazasLog  (modulo,"\n\t** => Cod Zona Imp. Cliente: [%d] **",LOG05,iCodZonaImp);
        pstCodZonas->iCodZonaImpCliente = iCodZonaImp;
    }
    else
    {
        vDTrazasError(modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
        vDTrazasLog  (modulo,"\n\t** En Zona impositiva del cliente  **",LOG01);
        return FALSE;
    }

    /* Obtencion de los codigos de region, provincia y ciudad */
    strcpy(pstCodZonas->szCodRegionCliente,stCliente.szCodRegion   );
    strcpy(pstCodZonas->szCodProvCliente  ,stCliente.szCodProvincia);
    strcpy(pstCodZonas->szCodCiudadCliente,stCliente.szCodCiudad   );
    strcpy(pstCodZonas->szCodComunaCliente,stCliente.szCodComuna   );

    if(lNumAbonado > 0L)
    {
        /*
        if (bfnGetZonaAbon (pszFecZonaImpo, iTipoFact,
                         &iCodZonaImp,
                         pstParamGener.iIndZonaImpCic))
        {
            vDTrazasLog  (modulo,"\n\t** => Cod Zona Imp. Abonado: [%d] **",LOG05,iCodZonaImp);
            pstCodZonas->iCodZonaImpAbon = iCodZonaImp;
        }
        else
        {
            vDTrazasError(modulo,"\n\t** En Zona impositiva del abonado  **",LOG01);
            vDTrazasLog  (modulo,"\n\t** En Zona impositiva del abonado  **",LOG01);
            return FALSE;
        }
        */

        /* 20060606: Se carga en esta funcion el codigo de zona impositiva del abonado */
        if(iTipoFact!=FACT_NOTACRED)/*CO-200608310357 FPH I, si es Nota de Credito no rescate la zonaimpositiva*/
        {
            if (!bfnGetDirAbonado (lNumAbonado,szCodRegion, szCodProvincia, szCodCiudad, szCodComuna, &lCodUsuario, &iCodZonaImp))
            {
            vDTrazasError(modulo,"\n\t** En obtencion codigos de direccion del abonado  **",LOG01);
            vDTrazasLog  (modulo,"\n\t** En obtencion codigos de direccion del abonado  **",LOG01);
            return FALSE;
            }
        }/*CO-200608310357 FPH F*/
        strcpy(pstCodZonas->szCodRegionAbon,szCodRegion   );
        strcpy(pstCodZonas->szCodProvAbon  ,szCodProvincia);
        strcpy(pstCodZonas->szCodCiudadAbon,szCodCiudad   );
        strcpy(pstCodZonas->szCodComunaAbon,szCodComuna   );
        pstCodZonas->iCodZonaImpAbon = iCodZonaImp;
    }
    else
    {
        /* Si es abonado cero, se utiliza codigo de zona impositiva del cliente */
        pstCodZonas->iCodZonaImpAbon = pstCodZonas->iCodZonaImpCliente;

        /* Si es abonado cero, se utiliza direccion del cliente */
        strcpy(pstCodZonas->szCodRegionAbon,stCliente.szCodRegion   );
        strcpy(pstCodZonas->szCodProvAbon  ,stCliente.szCodProvincia);
        strcpy(pstCodZonas->szCodCiudadAbon,stCliente.szCodCiudad   );
        strcpy(pstCodZonas->szCodComunaAbon,stCliente.szCodComuna   );
    }

    /* Imprimir codigos de zona cargados */
    vDTrazasLog  (modulo,"\n\t** Valores Cargados de zonas para abonado [%ld]: **"
                         "\n\t** pstCodZonas->iCodZonaImpCliente [%d]"
                         "\n\t** pstCodZonas->iCodZonaImpAbon    [%d]"
                         "\n\t** pstCodZonas->szCodProvCliente   [%s]"
                         "\n\t** pstCodZonas->szCodProvAbon      [%s]"
                         "\n\t** pstCodZonas->szCodRegionCliente [%s]"
                         "\n\t** pstCodZonas->szCodRegionAbon    [%s]"
                         "\n\t** pstCodZonas->szCodCiudadCliente [%s]"
                         "\n\t** pstCodZonas->szCodCiudadAbon    [%s]"
                         "\n\t** pstCodZonas->szCodComunaCliente [%s]"
                         "\n\t** pstCodZonas->szCodComunaAbon    [%s]"
                        , LOG06
                        , lNumAbonado
                        , pstCodZonas->iCodZonaImpCliente
                        , pstCodZonas->iCodZonaImpAbon
                        , pstCodZonas->szCodProvCliente
                        , pstCodZonas->szCodProvAbon
                        , pstCodZonas->szCodRegionCliente
                        , pstCodZonas->szCodRegionAbon
                        , pstCodZonas->szCodCiudadCliente
                        , pstCodZonas->szCodCiudadAbon
                        , pstCodZonas->szCodComunaCliente
                        , pstCodZonas->szCodComunaAbon);

    vDTrazasLog  (modulo,"\n\t** Saliendo de la funcion [%s] **",LOG05, modulo);

    return TRUE;
}

/*
 * Funcion      : dfnSumarConceptosNetos
 * Descripcion  : Sumar conceptos de cargo y conceptos de descuentos.
 */
double dfnSumarConceptosNetos(void)
{
    register int i    = 0;
    double dSumaNetos = 0.0;

    for(i=0;i<stPreFactura.iNumRegistros;i++)
    {
        if(stPreFactura.A_PFactura[i].iCodTipConce== ARTICULO || stPreFactura.A_PFactura[i].iCodTipConce== DESCUENTO)
            dSumaNetos += stPreFactura.A_PFactura[i].dImpFacturable;

    }

    return dSumaNetos;

}

/*
 * Funcion      : ifnBuscarSgteConceptoImpto
 * Descripcion  : Buscar el siguiente concepto de impuesto en la estructura de impuestos.
 */
int ifnBuscarSgteConceptoImpto(int iPosRegImptoDctos)
{
    register int i = 0;

    for(i=iPosRegImptoDctos;i<pstImptoDctos.iNumImptosDctos-1;i++)
    {
        if(pstImptoDctos.stImptoDcto[i+1].lCodConcepto != pstImptoDctos.stImptoDcto[i].lCodConcepto)
            return i+1;
    }

    /* Se ha llegado al final de la estructura sin encontrar un concepto distinto */
    return i+1;

}


/*
 * Funcion      : bfnValidarRebImptosDctos
 * Descripcion  : Validar si el impuesto al documento ingresado por parametro
 *                esta rebajado en su totalidad.
 */
BOOL bfnValidarRebImptosDctos(IMPTODCTO stImptoDcto, char *pszFecZonaImp)
{
    /* EXEC SQL BEGIN  DECLARE SECTION; */ 

    char     szhPrefPlaza      [26];    /* EXEC SQL VAR szhPrefPlaza     IS STRING(26); */ 

    char     szhCodTipDocum    [3] ;    /* EXEC SQL VAR szhCodTipDocum   IS STRING(3) ; */ 

    long     lhCodCliente      =0L ;
    long     lhNumFolio        =0L ;
    char     szhFecha          [15];    /* EXEC SQL VAR szhFecha         IS STRING(15); */ 


    long    lhCodConceptoImpto =0L ;
    char    szhCodZonaCargo    [11];    /* EXEC SQL VAR szhCodZonaCargo  IS STRING(11); */ 

    int     ihTipZonaCargo     =0  ;
    int     ihTipEvaluacion    =0  ;

    long     dhNumRegs         =0.0;
    /* EXEC SQL END    DECLARE SECTION; */ 


    char    *modulo = "bfnValidarRebImptosDctos";


    vDTrazasLog  (modulo,"\n\t** Dentro de la funcion [%s] **"
                         "\n\t** pszFecZonaImp       :[%s]"
                        , LOG05
                        , modulo
                        , pszFecZonaImp);

    strcpy(szhFecha, pszFecZonaImp);

    strcpy(szhPrefPlaza  , stNota.szPrefPlaza);
    sprintf(szhCodTipDocum,"%d", stNota.iCodTipDocum);

    lhNumFolio        = stNota.lNumFolio;
    lhCodCliente      = stNota.lCodCliente;

    lhCodConceptoImpto     = stImptoDcto.lCodConcepto    ;
    strcpy(szhCodZonaCargo  ,stImptoDcto.szCodZonacargo) ;
    ihTipZonaCargo         = stImptoDcto.iTipZonacargo   ;
    ihTipEvaluacion        = stImptoDcto.iTipEvaluacion  ;


    /* EXEC SQL
        SELECT nvl (sum(A.IMP_CONCEPTO) - sum(A.IMP_FACTURABLE), 0.0)
        INTO :dhNumRegs
        FROM FA_AJUSTECONC A
        WHERE A.PREF_PLAZA   = :szhPrefPlaza
          AND A.NUM_FOLIO    = :lhNumFolio
          AND A.COD_CLIENTE  = :lhCodCliente
          AND A.COD_TIPDOCUM = :szhCodTipDocum
          AND A.IMP_CONCEPTO <> A.IMP_FACTURABLE
          AND EXISTS (SELECT 1
                      FROM FA_GRPSERCONC B
                      WHERE B.COD_CONCEPTO = A.COD_CONCEPTO
                        AND B.FEC_DESDE <=TO_DATE (:szhFecha,'YYYYMMDDHH24MISS')
                        AND B.FEC_HASTA >=TO_DATE (:szhFecha,'YYYYMMDDHH24MISS')
                        AND EXISTS (SELECT 1
                                    FROM FA_IMPTODCTOS_TD C
                                    WHERE B.COD_GRPSERVI   = C.COD_GRPSERVI
                                      AND C.COD_CONCEPTO   = :lhCodConceptoImpto
                                      AND C.COD_ZONACARGO  = :szhCodZonaCargo
                                      AND C.TIP_ZONACARGO  = :ihTipZonaCargo
                                      AND C.TIP_EVALUACION = :ihTipEvaluacion
                                      AND C.FEC_DESDE      <= to_date (:szhFecha, 'YYYYMMDDHH24MISS')
                                      AND C.FEC_HASTA      >= to_date (:szhFecha, 'YYYYMMDDHH24MISS'))); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select nvl((sum(A.IMP_CONCEPTO)-sum(A.IMP_FACTURABLE)),0.\
0) into :b0  from FA_AJUSTECONC A where (((((A.PREF_PLAZA=:b1 and A.NUM_FOLIO=\
:b2) and A.COD_CLIENTE=:b3) and A.COD_TIPDOCUM=:b4) and A.IMP_CONCEPTO<>A.IMP_\
FACTURABLE) and exists (select 1  from FA_GRPSERCONC B where (((B.COD_CONCEPTO\
=A.COD_CONCEPTO and B.FEC_DESDE<=TO_DATE(:b5,'YYYYMMDDHH24MISS')) and B.FEC_HA\
STA>=TO_DATE(:b5,'YYYYMMDDHH24MISS')) and exists (select 1  from FA_IMPTODCTOS\
_TD C where ((((((B.COD_GRPSERVI=C.COD_GRPSERVI and C.COD_CONCEPTO=:b7) and C.\
COD_ZONACARGO=:b8) and C.TIP_ZONACARGO=:b9) and C.TIP_EVALUACION=:b10) and C.F\
EC_DESDE<=to_date(:b5,'YYYYMMDDHH24MISS')) and C.FEC_HASTA>=to_date(:b5,'YYYYM\
MDDHH24MISS'))))))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )355;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhNumRegs;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhPrefPlaza;
    sqlstm.sqhstl[1] = (unsigned long )26;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodTipDocum;
    sqlstm.sqhstl[4] = (unsigned long )3;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[5] = (unsigned long )15;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[6] = (unsigned long )15;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodConceptoImpto;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhCodZonaCargo;
    sqlstm.sqhstl[8] = (unsigned long )11;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihTipZonaCargo;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihTipEvaluacion;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[11] = (unsigned long )15;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhFecha;
    sqlstm.sqhstl[12] = (unsigned long )15;
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



    if(SQLCODE!=SQLOK)
    {
        vDTrazasLog  (modulo,"\n\t** Error en SELECT, sqlcode: [%d] **",LOG01, sqlca.sqlcode);
        vDTrazasError(modulo,"\n\t** Error en SELECT, sqlcode: [%d] **",LOG01, sqlca.sqlcode);
        return FALSE;

    }
    if(SQLCODE==SQLNOTFOUND)
    {
        vDTrazasLog  (modulo,"\n\t** Saliendo de la funcion [%s]\n\t** Diferencia No Encontrada **",LOG05, modulo);
        return TRUE;
    }

    vDTrazasLog  (modulo,"\n\t** Saliendo de la funcion [%s]\n\t** dhNumRegs :[%f] **",LOG05, modulo, dhNumRegs);

    if(dhNumRegs == 0.0)
        return TRUE;
    else
        return FALSE;

}
/*
 * Funcion      : bfnExisteConcRev
 * Descripcion  : Validar si existe el concepto ingresado por parametro <lCodConcepto> en <plConceptos>.
 */
BOOL bfnExisteConcRev(long lCodConcepto, long *plConceptos, int iNumConc)
{
    int i=0;

    for(i=0;i<iNumConc;i++)
    {
        if(lCodConcepto == plConceptos[i])
            return TRUE;
    }

    /* Si no lo encuentra, retorna FALSE */
    return FALSE;
}

/*
 * Funcion      : bfnVerificarVigConc
 * Descripcion  : Validar si el impuesto al documento esta vigente de acuerdo a la fecha de emision.
 */
BOOL bfnVerificarVigConc(IMPTODCTO stImptoDcto, char *pszFecZonaImp)
{
    char    szFecEmision[9] = "";

    strncpy(szFecEmision, pszFecZonaImp,8); /* Rescatar solo YYYYMMDD */
    szFecEmision[8] = '\0';

    if(strcmp(szFecEmision, stImptoDcto.szFecDesde)>=0 && strcmp(szFecEmision, stImptoDcto.szFecHasta)<=0 )
        return TRUE;
    else
        return FALSE;
}
/** Hasta aqui impuesto Maicao **/

/******************************************************************************************/
/** Informacion de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisiï¿½                                            : */
/**  %PR% */
/** Autor de la Revision                                 : */
/**  %AUTHOR% */
/** Estado de la Revision  ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creacion de la Revision                     : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/
