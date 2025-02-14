
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
static struct sqlcxp sqlfpn =
{
    18,
    "./pc/Ext_Ventas.pc"
};


static unsigned int sqlctx = 13851843;


static struct sqlexd {
   unsigned long  sqlvsn;
   unsigned int   arrsiz;
   unsigned int   iters;
   unsigned int   offset;
   unsigned short selerr;
   unsigned short sqlety;
   unsigned int   occurs;
            short *cud;
   unsigned char  *sqlest;
            char  *stmt;
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
   unsigned char  *sqhstv[19];
   unsigned long  sqhstl[19];
            int   sqhsts[19];
            short *sqindv[19];
            int   sqinds[19];
   unsigned long  sqharm[19];
   unsigned long  *sqharc[19];
   unsigned short  sqadto[19];
   unsigned short  sqtdso[19];
} sqlstm = {12,19};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned int *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned int *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned int *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

 static char *sq0001 = 
" OFI where ((((((((((OFI.COD_OFICINA=VTAS.COD_OFICINA and VTAS.COD_CLIENTE=C\
LI.COD_CLIENTE) and VTAS.NUM_VENTA in (select distinct NUM_VENTA  from GA_ABOA\
MIST where (((COD_PRODUCTO=1 and NUM_ABONADO>0) and FEC_ACTIVACION>=TO_DATE(:b\
0,'YYYYMMDD')) and FEC_ACTIVACION<=(TO_DATE(:b1,'YYYYMMDD')+1)))) and VTAS.IND\
_ESTVENTA=COD2.COD_VALOR) and COD2.COD_MODULO='GA') and COD2.NOM_TABLA='GA_VEN\
TAS') and COD2.NOM_COLUMNA='IND_ESTVENTA') and VTAS.IND_VENTA=COD.COD_VALOR) a\
nd COD.COD_MODULO='CM') and COD.NOM_TABLA='GA_VENTAS') and COD.NOM_COLUMNA='IN\
D_VENTA')           ";

 static char *sq0002 = 
"M_COLUMNA='COD_SITUACION') and CEL.COD_SITUACION=SIT.COD_SITUACION) and  not\
 exists (select 1  from GA_TRASPABO ABO where (ABO.NUM_ABONADO=CEL.NUM_ABONADO\
 and ABO.NUM_ABONADO<>ABO.NUM_ABONADOANT)))           ";

 static char *sq0003 = 
" CEL.COD_EMPRESA=EMP.COD_EMPRESA(+)) and CEL.COD_SITUACION=COD.COD_VALOR) an\
d COD.COD_MODULO='CM') and COD.NOM_TABLA='GA_ABOCEL') and COD.NOM_COLUMNA='COD\
_SITUACION') and CEL.COD_SITUACION=SIT.COD_SITUACION) and  not exists (select \
1  from GA_TRASPABO ABO where (ABO.NUM_ABONADO=CEL.NUM_ABONADO and ABO.NUM_ABO\
NADO<>ABO.NUM_ABONADOANT)))           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,2612,0,9,160,0,0,4,4,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
36,0,0,1,0,0,13,164,0,0,19,0,0,1,0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,
127,0,0,1,0,0,15,263,0,0,0,0,0,1,0,
142,0,0,2,1232,0,9,351,0,0,3,3,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,
169,0,0,2,0,0,13,356,0,0,14,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,
240,0,0,2,0,0,15,404,0,0,0,0,0,1,0,
255,0,0,3,1372,0,9,503,0,0,6,6,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
294,0,0,3,0,0,13,509,0,0,14,0,0,1,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,2,3,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,
0,
365,0,0,3,0,0,15,557,0,0,0,0,0,1,0,
380,0,0,4,466,0,4,599,0,0,8,4,0,1,0,2,3,0,0,2,97,0,0,2,3,0,0,2,97,0,0,1,3,0,0,
1,97,0,0,1,3,0,0,1,97,0,0,
427,0,0,5,48,0,1,993,0,0,0,0,0,1,0,
442,0,0,6,0,0,30,1074,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de extraer las ventas para comisiones, en archivos*/
/*     planos, orentado a procesos externos de comisiones (SADECOM)     */
/*----------------------------------------------------------------------*/
/* Version 1 - Revision 00.                                             */
/* Inicio: Martes 19 de Abril del 2005.                                 */
/* Fin   : Martes 19 de Abril del 2005.                                 */
/*                                                                      */
/************************************************************************/
#include "Ext_Ventas.h"
/*#include "GEN_biblioteca.h"*/
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
char zsBufferImpresionArchivo[5000];
/*---------------------------------------------------------------------------*/
/* Lista de Archivos                                                         */
/*---------------------------------------------------------------------------*/
	stArchivo *lstArchivo = NULL;
/*---------------------------------------------------------------------------*/
/* Inclusion de biblioteca para manejo de interaccion con Oracle.            */
/*---------------------------------------------------------------------------*/
/* EXEC SQL INCLUDE sqlca;
 */ 
/*
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
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
 * $Header: sqlca.h,v 1.3 1994/12/12 19:27:27 jbasu Exp $ sqlca.h 
 */

/* Copyright (c) 1985,1986, 1998 by Oracle Corporation. */
 
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError_EXT(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhUser[30]="";
        char    szhPass[30]="";
        char    szhSysDate [17]="";
        char  szFechaYYYYMMDD[9]="";
    /* EXEC SQL END DECLARE SECTION; */ 

/* -------------------------------------------------------------------------------------- */
/* Se extrae el universo DIRECTO inicial de registros a considerar para Comisiones.       */
/* -------------------------------------------------------------------------------------- */
void vSeleccionarUniverso(char * pszFecDesde, char * pszFecHasta)
{
    stUniverso  *paux;
    char        szObsIncumpFil[151];
    long        iCantVentasInv = 0;
    int			iVentaInvalida = 0;
    long        iCantidad = 0;
    int         i;
    long        iLastRows    = 0;
    int         iFetchedRows = MAXFETCH;
    int         iRetrievRows = MAXFETCH;

    /* EXEC SQL begin declare section; */ 

     long    lNumVenta[MAXFETCH];                      
     long    lCodCliente[MAXFETCH];                    
     char    cContrato[MAXFETCH][22];                  
     char    cNombre[MAXFETCH][51];                    
     char    cApellidos[MAXFETCH][51];                 
     char    num_cCedula[MAXFETCH][21];                
     char    num_cRut[MAXFETCH][21];                   
     char    cFec_Aceptacion_venta[MAXFETCH][31];      
     char    cFec_ultimo_cambio[MAXFETCH][31];         
     char    usuario[MAXFETCH][31];                    
     int     Codigo_servicio[MAXFETCH];                
     long    Vendedor[MAXFETCH];
     int     Ciclo[MAXFETCH];
     char    Indicador_venta[MAXFETCH][50];           
     char    szhCodTipVendedor[MAXFETCH][3];
     char    szhCodOficina[MAXFETCH][3];
     char    szhDesOficina[MAXFETCH][41]; 
     char	 szhIndEstVenta[MAXFETCH][3];
	 char	 szhIndTipoVenta[MAXFETCH][20];
     long    lMaxFetch;
     char    szhFecDesde[9];
     char    szhFecHasta[9];
    /* EXEC SQL end declare section; */ 

    
    strcpy(szhFecDesde, pszFecDesde);
    strcpy(szhFecHasta, pszFecHasta);

    paux = NULL;
    lMaxFetch = MAXFETCH;
   	/* EXEC SQL declare cur_universo cursor for  
         SELECT DISTINCT
              VTAS.NUM_VENTA                 num_venta,
              CLI.COD_CLIENTE                cliente, 
              NVL(VTAS.NUM_CONTRATO, 'S/N')  Contrato,
              CLI.NOM_CLIENTE                Nombre,
              NVL (CLI.NOM_APECLIEN1,NULL )|| ' ' ||NVL(CLI.NOM_APECLIEN2,NULL )  Apellidos,
              CLI.NUM_IDENT                  cedula,
              CLI.NUM_IDENT                  RUC,
              NVL(TO_CHAR(CLI.FEC_ACEPVENT, 'YYYYMMDD'), ' ')     Fecha_activacion_cuenta,
              TO_CHAR ( VTAS.FEC_VENTA, 'YYYYMMDD' )      		  Fecha_ultimo_cambio,
              VTAS.NOM_USUAR_VTA             Usuario,
              NVL ( VTAS.COD_MODVENTA, - 1 ) Codigo_servicio,
              VTAS.COD_VENDEDOR              Vendedor,
              CLI.COD_CICLO                  Ciclo,
              COD.DES_VALOR                  Indicador_venta,
              VTAS.COD_TIPCOMIS		         tip_vendedor,
              VTAS.COD_OFICINA				 cod_oficina,
              OFI.DES_OFICINA				 des_oficina,
              VTAS.IND_ESTVENTA				 ind_estventa,
              'CONTRATO'					 ind_tipoventa
         FROM GA_VENTAS    VTAS,
              GE_CLIENTES  CLI,     
              GED_CODIGOS  COD,
              GED_CODIGOS  COD2,
              GE_OFICINAS  OFI
         WHERE OFI.COD_OFICINA   	= VTAS.COD_OFICINA
          AND  VTAS.COD_CLIENTE  	= CLI.COD_CLIENTE
          AND  VTAS.FEC_VENTA  		>= to_date(:szhFecDesde,'YYYYMMDD') 
          AND  VTAS.FEC_VENTA  		<= to_date(:szhFecHasta,'YYYYMMDD') + 1
          AND  VTAS.IND_ESTVENTA 	= COD2.COD_VALOR
          AND  COD2.COD_MODULO    	= 'GA'
          AND  COD2.NOM_TABLA     	= 'GA_VENTAS'
          AND  COD2.NOM_COLUMNA   	= 'IND_ESTVENTA'
          AND  VTAS.IND_VENTA    	= COD.COD_VALOR
          AND  COD.COD_MODULO    	= 'CM'
          AND  COD.NOM_TABLA     	= 'GA_VENTAS'
          AND  COD.NOM_COLUMNA   	= 'IND_VENTA'
          AND EXISTS (SELECT 1 FROM GA_ABOCEL X
					  WHERE VTAS.NUM_VENTA = X.NUM_VENTA)	
		UNION SELECT DISTINCT
              VTAS.NUM_VENTA                 num_venta,
              CLI.COD_CLIENTE                cliente, 
              NVL(VTAS.NUM_CONTRATO, 'S/N')  Contrato,
              CLI.NOM_CLIENTE                Nombre,
              NVL (CLI.NOM_APECLIEN1,NULL )|| ' ' ||NVL(CLI.NOM_APECLIEN2,NULL )  Apellidos,
              CLI.NUM_IDENT                  cedula,
              CLI.NUM_IDENT                  RUC,
              NVL(TO_CHAR(CLI.FEC_ACEPVENT, 'YYYYMMDD'), ' ')     Fecha_activacion_cuenta,
              TO_CHAR ( VTAS.FEC_VENTA, 'YYYYMMDD' )      		  Fecha_ultimo_cambio,
              VTAS.NOM_USUAR_VTA             Usuario,
              NVL ( VTAS.COD_MODVENTA, - 1 ) Codigo_servicio,
              VTAS.COD_VENDEDOR              Vendedor,
              CLI.COD_CICLO                  Ciclo,
              COD.DES_VALOR                  Indicador_venta,
              VTAS.COD_TIPCOMIS		         tip_vendedor,
               VTAS.COD_OFICINA				 cod_oficina,
              OFI.DES_OFICINA				 des_oficina,
              VTAS.IND_ESTVENTA				 ind_estventa,
			  'PREPAGO'						 ind_tipventa
         FROM GA_VENTAS    VTAS,
              GE_CLIENTES  CLI,     
              GED_CODIGOS  COD,
              GED_CODIGOS  COD2,
              GE_OFICINAS  OFI
         WHERE OFI.COD_OFICINA   	= VTAS.COD_OFICINA
          AND  VTAS.COD_CLIENTE  	= CLI.COD_CLIENTE
		  AND  VTAS.NUM_VENTA       IN (SELECT DISTINCT NUM_VENTA
		  	   						    FROM 	GA_ABOAMIST
										WHERE 	COD_PRODUCTO = 1
										  AND 	NUM_ABONADO  > 0
										  AND 	FEC_ACTIVACION	>= TO_DATE(:szhFecDesde,'YYYYMMDD') 
          								  AND 	FEC_ACTIVACION	<= TO_DATE(:szhFecHasta,'YYYYMMDD') + 1)
          AND  VTAS.IND_ESTVENTA 	= COD2.COD_VALOR
          AND  COD2.COD_MODULO    	= 'GA'
          AND  COD2.NOM_TABLA     	= 'GA_VENTAS'
          AND  COD2.NOM_COLUMNA   	= 'IND_ESTVENTA'
          AND  VTAS.IND_VENTA    	= COD.COD_VALOR
          AND  COD.COD_MODULO    	= 'CM'
          AND  COD.NOM_TABLA     	= 'GA_VENTAS'
          AND  COD.NOM_COLUMNA   	= 'IND_VENTA'; */ 

        
        /* EXEC SQL open cur_universo; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 4;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlbuft((void **)0, 
          "select distinct VTAS.NUM_VENTA num_venta ,CLI.COD_CLIENTE cliente\
 ,NVL(VTAS.NUM_CONTRATO,'S/N') Contrato ,CLI.NOM_CLIENTE Nombre ,((NVL(CLI.N\
OM_APECLIEN1,null )||' ')||NVL(CLI.NOM_APECLIEN2,null )) Apellidos ,CLI.NUM_\
IDENT cedula ,CLI.NUM_IDENT RUC ,NVL(TO_CHAR(CLI.FEC_ACEPVENT,'YYYYMMDD'),' \
') Fecha_activacion_cuenta ,TO_CHAR(VTAS.FEC_VENTA,'YYYYMMDD') Fecha_ultimo_\
cambio ,VTAS.NOM_USUAR_VTA Usuario ,NVL(VTAS.COD_MODVENTA,(-1)) Codigo_servi\
cio ,VTAS.COD_VENDEDOR Vendedor ,CLI.COD_CICLO Ciclo ,COD.DES_VALOR Indicado\
r_venta ,VTAS.COD_TIPCOMIS tip_vendedor ,VTAS.COD_OFICINA cod_oficina ,OFI.D\
ES_OFICINA des_oficina ,VTAS.IND_ESTVENTA ind_estventa ,'CONTRATO' ind_tipov\
enta  from GA_VENTAS VTAS ,GE_CLIENTES CLI ,GED_CODIGOS COD ,GED_CODIGOS COD\
2 ,GE_OFICINAS OFI where ((((((((((((OFI.COD_OFICINA=VTAS.COD_OFICINA and VT\
AS.COD_CLIENTE=CLI.COD_CLIENTE) and VTAS.FEC_VENTA>=to_date(:b0,'YYYYMMDD'))\
 and VTAS.FEC_VENTA<=(to_date(:b1,'YYYYMMDD')+1)) and VTAS.IND_ESTVENTA=COD2\
.COD_VALOR) and COD2.COD_MODULO='GA') and COD2.");
        sqlbuft((void **)0, 
          "NOM_TABLA='GA_VENTAS') and COD2.NOM_COLUMNA='IND_ESTVENTA') and V\
TAS.IND_VENTA=COD.COD_VALOR) and COD.COD_MODULO='CM') and COD.NOM_TABLA='GA_\
VENTAS') and COD.NOM_COLUMNA='IND_VENTA') and exists (select 1  from GA_ABOC\
EL X where VTAS.NUM_VENTA=X.NUM_VENTA)) union select distinct VTAS.NUM_VENTA\
 num_venta ,CLI.COD_CLIENTE cliente ,NVL(VTAS.NUM_CONTRATO,'S/N') Contrato ,\
CLI.NOM_CLIENTE Nombre ,((NVL(CLI.NOM_APECLIEN1,null )||' ')||NVL(CLI.NOM_AP\
ECLIEN2,null )) Apellidos ,CLI.NUM_IDENT cedula ,CLI.NUM_IDENT RUC ,NVL(TO_C\
HAR(CLI.FEC_ACEPVENT,'YYYYMMDD'),' ') Fecha_activacion_cuenta ,TO_CHAR(VTAS.\
FEC_VENTA,'YYYYMMDD') Fecha_ultimo_cambio ,VTAS.NOM_USUAR_VTA Usuario ,NVL(V\
TAS.COD_MODVENTA,(-1)) Codigo_servicio ,VTAS.COD_VENDEDOR Vendedor ,CLI.COD_\
CICLO Ciclo ,COD.DES_VALOR Indicador_venta ,VTAS.COD_TIPCOMIS tip_vendedor ,\
VTAS.COD_OFICINA cod_oficina ,OFI.DES_OFICINA des_oficina ,VTAS.IND_ESTVENTA\
 ind_estventa ,'PREPAGO' ind_tipventa  from GA_VENTAS VTAS ,GE_CLIENTES CLI \
,GED_CODIGOS COD ,GED_CODIGOS COD2 ,GE_OFICINAS");
        sqlstm.stmt = sq0001;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )5;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlstm.sqhstv[0] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[0] = (unsigned long )9;
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[1] = (unsigned long )9;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecDesde;
        sqlstm.sqhstl[2] = (unsigned long )9;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)szhFecHasta;
        sqlstm.sqhstl[3] = (unsigned long )9;
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
        if (sqlca.sqlcode < 0) vSqlError_EXT();
}


        
    while(iFetchedRows == iRetrievRows)
    {
        /* EXEC SQL for :lMaxFetch
              FETCH cur_universo INTO
                :lNumVenta             , 
                :lCodCliente           , 
                :cContrato             , 
                :cNombre               , 
                :cApellidos            , 
                :num_cCedula           , 
                :num_cRut              , 
                :cFec_Aceptacion_venta , 
                :cFec_ultimo_cambio	, 
                :usuario               , 
                :Codigo_servicio       , 
                :Vendedor              , 
                :Ciclo                 , 
                :Indicador_venta       ,
                :szhCodTipVendedor	   ,
                :szhCodOficina		   ,
                :szhDesOficina		   ,
                :szhIndEstVenta		   ,
                :szhIndTipoVenta       ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 19;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )lMaxFetch;
        sqlstm.offset = (unsigned int  )36;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)lNumVenta;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[0] = (         int  )sizeof(long);
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqharc[0] = (unsigned long  *)0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)lCodCliente;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[1] = (         int  )sizeof(long);
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqharc[1] = (unsigned long  *)0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)cContrato;
        sqlstm.sqhstl[2] = (unsigned long )22;
        sqlstm.sqhsts[2] = (         int  )22;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqharc[2] = (unsigned long  *)0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)cNombre;
        sqlstm.sqhstl[3] = (unsigned long )51;
        sqlstm.sqhsts[3] = (         int  )51;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqharc[3] = (unsigned long  *)0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)cApellidos;
        sqlstm.sqhstl[4] = (unsigned long )51;
        sqlstm.sqhsts[4] = (         int  )51;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqharc[4] = (unsigned long  *)0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)num_cCedula;
        sqlstm.sqhstl[5] = (unsigned long )21;
        sqlstm.sqhsts[5] = (         int  )21;
        sqlstm.sqindv[5] = (         short *)0;
        sqlstm.sqinds[5] = (         int  )0;
        sqlstm.sqharm[5] = (unsigned long )0;
        sqlstm.sqharc[5] = (unsigned long  *)0;
        sqlstm.sqadto[5] = (unsigned short )0;
        sqlstm.sqtdso[5] = (unsigned short )0;
        sqlstm.sqhstv[6] = (unsigned char  *)num_cRut;
        sqlstm.sqhstl[6] = (unsigned long )21;
        sqlstm.sqhsts[6] = (         int  )21;
        sqlstm.sqindv[6] = (         short *)0;
        sqlstm.sqinds[6] = (         int  )0;
        sqlstm.sqharm[6] = (unsigned long )0;
        sqlstm.sqharc[6] = (unsigned long  *)0;
        sqlstm.sqadto[6] = (unsigned short )0;
        sqlstm.sqtdso[6] = (unsigned short )0;
        sqlstm.sqhstv[7] = (unsigned char  *)cFec_Aceptacion_venta;
        sqlstm.sqhstl[7] = (unsigned long )31;
        sqlstm.sqhsts[7] = (         int  )31;
        sqlstm.sqindv[7] = (         short *)0;
        sqlstm.sqinds[7] = (         int  )0;
        sqlstm.sqharm[7] = (unsigned long )0;
        sqlstm.sqharc[7] = (unsigned long  *)0;
        sqlstm.sqadto[7] = (unsigned short )0;
        sqlstm.sqtdso[7] = (unsigned short )0;
        sqlstm.sqhstv[8] = (unsigned char  *)cFec_ultimo_cambio;
        sqlstm.sqhstl[8] = (unsigned long )31;
        sqlstm.sqhsts[8] = (         int  )31;
        sqlstm.sqindv[8] = (         short *)0;
        sqlstm.sqinds[8] = (         int  )0;
        sqlstm.sqharm[8] = (unsigned long )0;
        sqlstm.sqharc[8] = (unsigned long  *)0;
        sqlstm.sqadto[8] = (unsigned short )0;
        sqlstm.sqtdso[8] = (unsigned short )0;
        sqlstm.sqhstv[9] = (unsigned char  *)usuario;
        sqlstm.sqhstl[9] = (unsigned long )31;
        sqlstm.sqhsts[9] = (         int  )31;
        sqlstm.sqindv[9] = (         short *)0;
        sqlstm.sqinds[9] = (         int  )0;
        sqlstm.sqharm[9] = (unsigned long )0;
        sqlstm.sqharc[9] = (unsigned long  *)0;
        sqlstm.sqadto[9] = (unsigned short )0;
        sqlstm.sqtdso[9] = (unsigned short )0;
        sqlstm.sqhstv[10] = (unsigned char  *)Codigo_servicio;
        sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[10] = (         int  )sizeof(int);
        sqlstm.sqindv[10] = (         short *)0;
        sqlstm.sqinds[10] = (         int  )0;
        sqlstm.sqharm[10] = (unsigned long )0;
        sqlstm.sqharc[10] = (unsigned long  *)0;
        sqlstm.sqadto[10] = (unsigned short )0;
        sqlstm.sqtdso[10] = (unsigned short )0;
        sqlstm.sqhstv[11] = (unsigned char  *)Vendedor;
        sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
        sqlstm.sqhsts[11] = (         int  )sizeof(long);
        sqlstm.sqindv[11] = (         short *)0;
        sqlstm.sqinds[11] = (         int  )0;
        sqlstm.sqharm[11] = (unsigned long )0;
        sqlstm.sqharc[11] = (unsigned long  *)0;
        sqlstm.sqadto[11] = (unsigned short )0;
        sqlstm.sqtdso[11] = (unsigned short )0;
        sqlstm.sqhstv[12] = (unsigned char  *)Ciclo;
        sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[12] = (         int  )sizeof(int);
        sqlstm.sqindv[12] = (         short *)0;
        sqlstm.sqinds[12] = (         int  )0;
        sqlstm.sqharm[12] = (unsigned long )0;
        sqlstm.sqharc[12] = (unsigned long  *)0;
        sqlstm.sqadto[12] = (unsigned short )0;
        sqlstm.sqtdso[12] = (unsigned short )0;
        sqlstm.sqhstv[13] = (unsigned char  *)Indicador_venta;
        sqlstm.sqhstl[13] = (unsigned long )50;
        sqlstm.sqhsts[13] = (         int  )50;
        sqlstm.sqindv[13] = (         short *)0;
        sqlstm.sqinds[13] = (         int  )0;
        sqlstm.sqharm[13] = (unsigned long )0;
        sqlstm.sqharc[13] = (unsigned long  *)0;
        sqlstm.sqadto[13] = (unsigned short )0;
        sqlstm.sqtdso[13] = (unsigned short )0;
        sqlstm.sqhstv[14] = (unsigned char  *)szhCodTipVendedor;
        sqlstm.sqhstl[14] = (unsigned long )3;
        sqlstm.sqhsts[14] = (         int  )3;
        sqlstm.sqindv[14] = (         short *)0;
        sqlstm.sqinds[14] = (         int  )0;
        sqlstm.sqharm[14] = (unsigned long )0;
        sqlstm.sqharc[14] = (unsigned long  *)0;
        sqlstm.sqadto[14] = (unsigned short )0;
        sqlstm.sqtdso[14] = (unsigned short )0;
        sqlstm.sqhstv[15] = (unsigned char  *)szhCodOficina;
        sqlstm.sqhstl[15] = (unsigned long )3;
        sqlstm.sqhsts[15] = (         int  )3;
        sqlstm.sqindv[15] = (         short *)0;
        sqlstm.sqinds[15] = (         int  )0;
        sqlstm.sqharm[15] = (unsigned long )0;
        sqlstm.sqharc[15] = (unsigned long  *)0;
        sqlstm.sqadto[15] = (unsigned short )0;
        sqlstm.sqtdso[15] = (unsigned short )0;
        sqlstm.sqhstv[16] = (unsigned char  *)szhDesOficina;
        sqlstm.sqhstl[16] = (unsigned long )41;
        sqlstm.sqhsts[16] = (         int  )41;
        sqlstm.sqindv[16] = (         short *)0;
        sqlstm.sqinds[16] = (         int  )0;
        sqlstm.sqharm[16] = (unsigned long )0;
        sqlstm.sqharc[16] = (unsigned long  *)0;
        sqlstm.sqadto[16] = (unsigned short )0;
        sqlstm.sqtdso[16] = (unsigned short )0;
        sqlstm.sqhstv[17] = (unsigned char  *)szhIndEstVenta;
        sqlstm.sqhstl[17] = (unsigned long )3;
        sqlstm.sqhsts[17] = (         int  )3;
        sqlstm.sqindv[17] = (         short *)0;
        sqlstm.sqinds[17] = (         int  )0;
        sqlstm.sqharm[17] = (unsigned long )0;
        sqlstm.sqharc[17] = (unsigned long  *)0;
        sqlstm.sqadto[17] = (unsigned short )0;
        sqlstm.sqtdso[17] = (unsigned short )0;
        sqlstm.sqhstv[18] = (unsigned char  *)szhIndTipoVenta;
        sqlstm.sqhstl[18] = (unsigned long )20;
        sqlstm.sqhsts[18] = (         int  )20;
        sqlstm.sqindv[18] = (         short *)0;
        sqlstm.sqinds[18] = (         int  )0;
        sqlstm.sqharm[18] = (unsigned long )0;
        sqlstm.sqharc[18] = (unsigned long  *)0;
        sqlstm.sqadto[18] = (unsigned short )0;
        sqlstm.sqtdso[18] = (unsigned short )0;
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
        if (sqlca.sqlcode < 0) vSqlError_EXT();
}



        iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
        iLastRows = sqlca.sqlerrd[2];
        for (i=0; i < iRetrievRows; i++)
		{
        	paux = (stUniverso *) malloc(sizeof(stUniverso));

			paux->lNumVenta              	   = lNumVenta              [i]   ; 
			paux->lCodCliente            	   = lCodCliente            [i]   ; 
			strcpy(paux->cContrato             , szfnTrim(cContrato              [i] )); 
			strcpy(paux->cNombre               , szfnTrim(cNombre                [i] )); 
			strcpy(paux->cApellidos            , szfnTrim(cApellidos             [i] )); 
			strcpy(paux->num_cCedula           , szfnTrim(num_cCedula            [i] )); 
			strcpy(paux->num_cRut              , szfnTrim(num_cRut               [i] )); 
			strcpy(paux->cFec_Aceptacion_venta , szfnTrim(cFec_Aceptacion_venta  [i] )); 
			strcpy(paux->cFec_ultimo_cambio    , szfnTrim(cFec_ultimo_cambio     [i] )); 
			paux->Codigo_servicio        	   = Codigo_servicio        [i] ;   
			strcpy(paux->usuario               , szfnTrim(usuario                [i] )); 
			paux->Vendedor               	   = Vendedor[i] ;   
			paux->Ciclo                  	   = Ciclo[i] ;   
			strcpy(paux->Indicador_venta       , szfnTrim(Indicador_venta        [i] )); 
			strcpy(paux->szCodTipVendedor      , szfnTrim(szhCodTipVendedor[i]));
			strcpy(paux->szCodOficina          , szfnTrim(szhCodOficina    [i]));
			strcpy(paux->szDesOficina          , szfnTrim(szhDesOficina    [i]));
			strcpy(paux->szIndEstVenta         , szfnTrim(szhIndEstVenta    [i]));
			strcpy(paux->szIndTipoVenta        , szfnTrim(szhIndTipoVenta   [i]));
			
			paux->cIndConsidera                = 'S';
			iVentaInvalida                     = 0;
			paux->abonado_sgte                 = NULL;
			fprintf(pfLog , "\n\tVenta Recuperada:[%ld] Cliente:[%ld] TIPO:[%s]", paux->lNumVenta, paux->lCodCliente, paux->szIndTipoVenta);	
			fprintf(stderr, "\n\tVenta Recuperada:[%ld] Cliente:[%ld] TIPO:[%s]", paux->lNumVenta, paux->lCodCliente, paux->szIndTipoVenta);	

			if (ifnCargaDireccion(paux->lCodCliente, 1, &stDireccion))
			{
				
				strcpy(paux->szDireccion		, stDireccion.szDireccion);
				strcpy(paux->szDesCiudad    	, stDireccion.szDesCiudad);
				strcpy(paux->szCodCiudad    	, stDireccion.szCodCiudad);
				strcpy(paux->szDesProvincia 	, stDireccion.szDesProvincia);
				strcpy(paux->szCodFranquicia	, stDireccion.szCodFranquicia);
				strcpy(paux->szDesFranquicia	, stDireccion.szDesFranquicia);
				strcpy(paux->szCodRegion		, stDireccion.szCodRegion);
/*				fprintf(pfLog , "\n\tDirección:[%s], Region:[%s] Ciudad:[%s]", paux->szDireccion, paux->szCodRegion, paux->szDesCiudad);    */
/*				fprintf(stderr, "\n\tDirección:[%s], Region:[%s] Ciudad:[%s]", paux->szDireccion, paux->szCodRegion, paux->szDesCiudad);	*/
			}
			else
			{
				paux->cIndConsidera			 = 'N';
				iVentaInvalida  			 = 1;
			}

			if (strcmp(paux->szIndTipoVenta, TIPOCONTRATO)==0)
			{
				if (ifnGetAbonados_pospago(paux)==0)
				{
					fprintf(stderr,"\n\t Venta Invalidada...");
					fprintf(pfLog ,"\n\t Venta Invalidada...");
					paux->cIndConsidera			 = 'N';
					iVentaInvalida  			 = 1;
				}
			}
			else
			{
				if (ifnGetAbonados_prepago(paux, szhFecDesde, szhFecHasta)==0)
				{
					fprintf(stderr,"\n\t Venta Invalidada...");
					fprintf(pfLog ,"\n\t Venta Invalidada...");
					paux->cIndConsidera			 = 'N';
					iVentaInvalida  			 = 1;
				}
			}
			paux->sgte                         = lstUniverso;
			lstUniverso                        = paux;
			iCantidad++;
			iCantVentasInv 					  += iVentaInvalida;
       } 
    }
    /* EXEC SQL close cur_universo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )127;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}



    fprintf(pfLog , "\n(vSeleccionarUniverso) Cantidad de Ventas Extraidas:[%ld] Invalidas:[%ld] Abonados Total:[%ld].\n", iCantidad, iCantVentasInv, lCantTotalAbonados);
    fprintf(stderr, "\n(vSeleccionarUniverso) Cantidad de Ventas Extraidas:[%ld] Invalidas:[%ld] Abonados Total:[%ld].\n", iCantidad, iCantVentasInv, lCantTotalAbonados);
}
/* ***************************************************************************** */
/* Para cada venta pospago, ahora se rescatan los abonados.                      */
/* ***************************************************************************** */
int ifnGetAbonados_pospago(stUniverso * paux)
{
    stAbonado  * aaux;
    int          i;      
    short        iLastRows    = 0;       
    int          iFetchedRows = MAXFETCH;
    int          iRetrievRows = MAXFETCH;
    int          iCantAbonados = 0;
    /* EXEC SQL begin declare section; */ 

		long    lMaxFetch;       
        long    lhNumVenta;
        char    szhNumCelular[MAXFETCH][16];
        char    szhCodPlanTarif[MAXFETCH][4];
		char    szhDesPlanTarif[MAXFETCH][31];             
        long    lhNumAbonado[MAXFETCH];
        int     ihCodAfinidad[MAXFETCH];
        char    szhCodTecnologia[MAXFETCH][8]; 
        char	szhTipoPlanTarifario[MAXFETCH][21];
		char    szhDesSituacionAbonado[MAXFETCH][31];      
		char    szhcDescripcionEmpresa[MAXFETCH][51];      
		char    szhcFecActivaTelefono[MAXFETCH][30];       
		char    szhcFecBajaTelefono[MAXFETCH][30];   
		char	szhTipTerminal[2];
		char	szhIndProcequiGet[MAXFETCH][2];
        char    szhNumSerie[MAXFETCH][26];
		char    szhNumImei[MAXFETCH][26];                      
    /* EXEC SQL end declare section; */ 


	fprintf(stderr, "\n[ifnGetAbonados_pospago] Recupera Datos de Abonados POSPAGO de Venta:[%ld].\n", paux->lNumVenta);
	fprintf(pfLog , "\n[ifnGetAbonados_pospago] Recupera Datos de Abonados POSPAGO de Venta:[%ld].\n", paux->lNumVenta);

    strcpy(szhTipTerminal , "G");
    iLastRows    = 0;       
    lMaxFetch    = MAXFETCH;
    paux->abonado_sgte = NULL;
    if (paux->cIndConsidera == 'S')
    {
/*		fprintf(pfLog , "\nRecuperando Abonados de la Venta:[%ld] Cliente:[%ld]", lhNumVenta, paux->lCodCliente);   */
/*		fprintf(stderr, "\nRecuperando Abonados de la Venta:[%ld] Cliente:[%ld]", lhNumVenta, paux->lCodCliente);	*/
        lhNumVenta = paux->lNumVenta;
        /* EXEC SQL DECLARE CUR_ABONADOS_POSPAGO CURSOR FOR SELECT 
				TO_CHAR(CEL.NUM_CELULAR),
                CEL.COD_PLANTARIF,
				TAP.DES_PLANTARIF, 
				NVL(CEL.NUM_IMEI, CEL.NUM_SERIE), 					/o SERIE DE LA TERMINAL o/
				DECODE(CEL.NUM_IMEI, NULL, 'S/N', CEL.NUM_SERIE), 	/o SERIE DE LA SIMCARD  o/
                CEL.NUM_ABONADO,
                NVL(CEL.COD_AFINIDAD,'0'),
                NVL(CEL.COD_TECNOLOGIA,'TDMA'),
				DECODE(TAP.COD_TIPLAN, '1','PREPAGO',2,'POSPAGO',3,'HIBRIDO'),
				SIT.DES_SITUACION              							Situacion_abonado,
				NVL(EMP.DES_EMPRESA, 'S/E')            					compania,
              	TO_CHAR ( CEL.FEC_ALTA, 'YYYYMMDD' )      				Fecha_activa_telefono,
              	nvl(TO_CHAR ( CEL.FEC_BAJA, 'YYYYMMDD' ),' ') 			Fecha_baja_telefono,
              	EQUI.IND_PROCEQUI
        FROM	GA_EQUIPABOSER      EQUI,
        		GA_ABOCEL 			CEL,
            	TA_PLANTARIF 		TAP,
            	GA_EMPRESA   		EMP,
            	GA_SITUABO   		SIT,
            	GED_CODIGOS			COD
        WHERE   CEL.NUM_VENTA 		=  :lhNumVenta
        AND   CEL.NUM_ABONADO 		=  EQUI.NUM_ABONADO
        AND   EQUI.TIP_TERMINAL     != :szhTipTerminal
        AND   EQUI.FEC_ALTA 		= (SELECT MAX(R.FEC_ALTA) 
        							    FROM 	GA_EQUIPABOSER R
        							    WHERE 	EQUI.NUM_ABONADO 	= R.NUM_ABONADO
        							    AND 	R.TIP_TERMINAL     != :szhTipTerminal)
		AND   CEL.COD_PLANTARIF 	=  TAP.COD_PLANTARIF
		AND   CEL.COD_EMPRESA   	=  EMP.COD_EMPRESA (+)
		AND   CEL.COD_SITUACION  	=  COD.COD_VALOR
      	AND   COD.COD_MODULO    	=  'CM'
      	AND   COD.NOM_TABLA     	=  'GA_ABOCEL'
      	AND   COD.NOM_COLUMNA   	=  'COD_SITUACION'
		AND   CEL.COD_SITUACION     =  SIT.COD_SITUACION
        AND   NOT EXISTS (SELECT 1
            FROM   GA_TRASPABO ABO
            WHERE  ABO.NUM_ABONADO  =  CEL.NUM_ABONADO
            AND    ABO.NUM_ABONADO  != ABO.NUM_ABONADOANT); */ 


    	/* EXEC SQL open cur_abonados_pospago; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 19;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlbuft((void **)0, 
       "select TO_CHAR(CEL.NUM_CELULAR) ,CEL.COD_PLANTARIF ,TAP.DES_PLANTARI\
F ,NVL(CEL.NUM_IMEI,CEL.NUM_SERIE) ,DECODE(CEL.NUM_IMEI,null ,'S/N',CEL.NUM_\
SERIE) ,CEL.NUM_ABONADO ,NVL(CEL.COD_AFINIDAD,'0') ,NVL(CEL.COD_TECNOLOGIA,'\
TDMA') ,DECODE(TAP.COD_TIPLAN,'1','PREPAGO',2,'POSPAGO',3,'HIBRIDO') ,SIT.DE\
S_SITUACION Situacion_abonado ,NVL(EMP.DES_EMPRESA,'S/E') compania ,TO_CHAR(\
CEL.FEC_ALTA,'YYYYMMDD') Fecha_activa_telefono ,nvl(TO_CHAR(CEL.FEC_BAJA,'YY\
YYMMDD'),' ') Fecha_baja_telefono ,EQUI.IND_PROCEQUI  from GA_EQUIPABOSER EQ\
UI ,GA_ABOCEL CEL ,TA_PLANTARIF TAP ,GA_EMPRESA EMP ,GA_SITUABO SIT ,GED_COD\
IGOS COD where (((((((((((CEL.NUM_VENTA=:b0 and CEL.NUM_ABONADO=EQUI.NUM_ABO\
NADO) and EQUI.TIP_TERMINAL<>:b1) and EQUI.FEC_ALTA=(select max(R.FEC_ALTA) \
 from GA_EQUIPABOSER R where (EQUI.NUM_ABONADO=R.NUM_ABONADO and R.TIP_TERMI\
NAL<>:b1))) and CEL.COD_PLANTARIF=TAP.COD_PLANTARIF) and CEL.COD_EMPRESA=EMP\
.COD_EMPRESA(+)) and CEL.COD_SITUACION=COD.COD_VALOR) and COD.COD_MODULO='CM\
') and COD.NOM_TABLA='GA_ABOCEL') and COD.NO");
     sqlstm.stmt = sq0002;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )142;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhTipTerminal;
     sqlstm.sqhstl[1] = (unsigned long )2;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhTipTerminal;
     sqlstm.sqhstl[2] = (unsigned long )2;
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
     if (sqlca.sqlcode < 0) vSqlError_EXT();
}




        while(iFetchedRows == iRetrievRows)
        {
            /* EXEC SQL for :lMaxFetch FETCH cur_abonados_pospago
                INTO     :szhNumCelular				,
                         :szhCodPlanTarif			,
                         :szhDesPlanTarif			,
                         :szhNumImei				, 
                         :szhNumSerie				,
                         :lhNumAbonado				,
                         :ihCodAfinidad				,
                         :szhCodTecnologia			, 
                         :szhTipoPlanTarifario		,
                         :szhDesSituacionAbonado	,
                         :szhcDescripcionEmpresa	,
                         :szhcFecActivaTelefono		,
                         :szhcFecBajaTelefono		,
                         :szhIndProcequiGet			; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 19;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )169;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumCelular;
            sqlstm.sqhstl[0] = (unsigned long )16;
            sqlstm.sqhsts[0] = (         int  )16;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
            sqlstm.sqhstl[1] = (unsigned long )4;
            sqlstm.sqhsts[1] = (         int  )4;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhDesPlanTarif;
            sqlstm.sqhstl[2] = (unsigned long )31;
            sqlstm.sqhsts[2] = (         int  )31;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNumImei;
            sqlstm.sqhstl[3] = (unsigned long )26;
            sqlstm.sqhsts[3] = (         int  )26;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhNumSerie;
            sqlstm.sqhstl[4] = (unsigned long )26;
            sqlstm.sqhsts[4] = (         int  )26;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)lhNumAbonado;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )sizeof(long);
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)ihCodAfinidad;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[6] = (         int  )sizeof(int);
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
            sqlstm.sqhstl[7] = (unsigned long )8;
            sqlstm.sqhsts[7] = (         int  )8;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)szhTipoPlanTarifario;
            sqlstm.sqhstl[8] = (unsigned long )21;
            sqlstm.sqhsts[8] = (         int  )21;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)szhDesSituacionAbonado;
            sqlstm.sqhstl[9] = (unsigned long )31;
            sqlstm.sqhsts[9] = (         int  )31;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqharc[9] = (unsigned long  *)0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)szhcDescripcionEmpresa;
            sqlstm.sqhstl[10] = (unsigned long )51;
            sqlstm.sqhsts[10] = (         int  )51;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqharc[10] = (unsigned long  *)0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhcFecActivaTelefono;
            sqlstm.sqhstl[11] = (unsigned long )30;
            sqlstm.sqhsts[11] = (         int  )30;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqharc[11] = (unsigned long  *)0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)szhcFecBajaTelefono;
            sqlstm.sqhstl[12] = (unsigned long )30;
            sqlstm.sqhsts[12] = (         int  )30;
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqharc[12] = (unsigned long  *)0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)szhIndProcequiGet;
            sqlstm.sqhstl[13] = (unsigned long )2;
            sqlstm.sqhsts[13] = (         int  )2;
            sqlstm.sqindv[13] = (         short *)0;
            sqlstm.sqinds[13] = (         int  )0;
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqharc[13] = (unsigned long  *)0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
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
            if (sqlca.sqlcode < 0) vSqlError_EXT();
}

 

            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];
               
            for (i=0; i < iRetrievRows; i++)
            {
                aaux = (stAbonado *) malloc (sizeof(stAbonado));

                strcpy(aaux->szNumCelular           , szfnTrim(szhNumCelular[i]));
                strcpy(aaux->szCodPlanTarif   		, szfnTrim(szhCodPlanTarif[i]));
                strcpy(aaux->szDesPlanTarif   		, szfnTrim(szhDesPlanTarif[i]));
                strcpy(aaux->szNumSerie       		, szfnTrim(szhNumSerie[i]));
                aaux->lNumAbonado             		= lhNumAbonado[i];
                aaux->iCodAfinidad            		= ihCodAfinidad[i];
                strcpy(aaux->szCodTecnologia  		, szfnTrim(szhCodTecnologia[i])); 
                strcpy(aaux->szTipPlanTarif   		, szfnTrim(szhTipoPlanTarifario[i]));
                strcpy(aaux->szNumImei   			, szfnTrim(szhNumImei[i]));
                strcpy(aaux->szDesSituacionAbonado	, szfnTrim(szhDesSituacionAbonado[i]));
                strcpy(aaux->szcDescripcionEmpresa	, szfnTrim(szhcDescripcionEmpresa[i]));
                strcpy(aaux->szcFecActivaTelefono	, szfnTrim(szhcFecActivaTelefono[i]));
                strcpy(aaux->szcFecBajaTelefono		, szfnTrim(szhcFecBajaTelefono[i]));
		
				fprintf(pfLog , "\n\tAbonado Recuperado:[%ld] ->Celular:[%ld]", aaux->lNumAbonado, aaux->szNumCelular);     
				fprintf(stderr, "\n\tAbonado Recuperado:[%ld] ->Celular:[%ld]", aaux->lNumAbonado, aaux->szNumCelular);		

                aaux->cIndConsidera           		= 'S';
                aaux->sgte                    		= paux->abonado_sgte;
                paux->abonado_sgte            		= aaux;
				
                iCantAbonados++;
            }
		}
	}
    /* EXEC SQL close cur_abonados_pospago; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )240;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    fprintf(stderr, "\n[ifnGetAbonados_pospago] Abonados Recuperados (retorno):[%d]\n",iCantAbonados);
    fprintf(pfLog , "\n[ifnGetAbonados_pospago] Abonados Recuperados (retorno):[%d]\n",iCantAbonados);
    lCantTotalAbonados += iCantAbonados;
	return iCantAbonados;
}
/* ***************************************************************************** */
/* Para cada venta prepago, ahora se rescatan los abonados.                      */
/* ***************************************************************************** */
int ifnGetAbonados_prepago(stUniverso * paux, char * pszFecDesde, char * pszFecHasta)
{
    stAbonado  * aaux;
    int          i;      
    short        iLastRows    = 0;       
    int          iFetchedRows = MAXFETCH;
    int          iRetrievRows = MAXFETCH;
    int          iCantAbonados = 0;
    /* EXEC SQL begin declare section; */ 

		long    lMaxFetch;       
        long    lhNumVenta;
        char    szhNumCelular[MAXFETCH][16];
        char    szhCodPlanTarif[MAXFETCH][4];
		char    szhDesPlanTarif[MAXFETCH][31];             
        long    lhNumAbonado[MAXFETCH];
        int     ihCodAfinidad[MAXFETCH];
        char    szhCodTecnologia[MAXFETCH][8]; 
        char	szhTipoPlanTarifario[MAXFETCH][21];
		char    szhDesSituacionAbonado[MAXFETCH][31];      
		char    szhcDescripcionEmpresa[MAXFETCH][51];      
		char    szhcFecActivaTelefono[MAXFETCH][30];       
		char    szhcFecBajaTelefono[MAXFETCH][30];   
		char    szhIndProcequi[3];      
		char	szhTipTerminal[2];
		char	szhIndProcequiGet[MAXFETCH][2];
        char    szhNumSerie[MAXFETCH][26];
		char    szhNumImei[MAXFETCH][26];                      
		char    szhFecDesde[9];
		char    szhFecHasta[9];

    /* EXEC SQL end declare section; */ 


    strcpy(szhFecDesde, pszFecDesde);
    strcpy(szhFecHasta, pszFecHasta);
	fprintf(stderr, "\n[ifnGetAbonados_prepago] Recupera Datos de Abonados PREPAGO de Venta:[%ld] Activados entre [%s] y [%s].\n", paux->lNumVenta, szhFecDesde, szhFecHasta);
	fprintf(pfLog , "\n[ifnGetAbonados_prepago] Recupera Datos de Abonados PREPAGO de Venta:[%ld] Activados entre [%s] y [%s].\n", paux->lNumVenta, szhFecDesde, szhFecHasta);

	strcpy(szhIndProcequi, "E");
    strcpy(szhTipTerminal , "G");
    iLastRows    = 0;       
    lMaxFetch    = MAXFETCH;
    paux->abonado_sgte = NULL;
    if (paux->cIndConsidera == 'S')
    {
/*		fprintf(pfLog , "\nRecuperando Abonados de la Venta:[%ld] Cliente:[%ld]", lhNumVenta, paux->lCodCliente);   */
/*		fprintf(stderr, "\nRecuperando Abonados de la Venta:[%ld] Cliente:[%ld]", lhNumVenta, paux->lCodCliente);	*/
        lhNumVenta = paux->lNumVenta;
    	/* EXEC SQL DECLARE CUR_ABONADOS_PREPAGO CURSOR FOR SELECT
				TO_CHAR(CEL.NUM_CELULAR),
                CEL.COD_PLANTARIF,
				TAP.DES_PLANTARIF, 
				NVL(CEL.NUM_IMEI, CEL.NUM_SERIE), 					/o SERIE DE LA TERMINAL o/
				DECODE(CEL.NUM_IMEI, NULL, 'S/N', CEL.NUM_SERIE), 	/o SERIE DE LA SIMCARD  o/
                CEL.NUM_ABONADO,
                NVL(CEL.COD_AFINIDAD,'0'),
                NVL(CEL.COD_TECNOLOGIA,'TDMA'),
				DECODE(TAP.COD_TIPLAN, '1','PREPAGO',2,'POSPAGO',3,'HIBRIDO'),
				SIT.DES_SITUACION              					Situacion_abonado,
				NVL(EMP.DES_EMPRESA, 'S/E')            			compania,
              	TO_CHAR ( CEL.FEC_ACTIVACION, 'YYYYMMDD' )      Fecha_activa_telefono,
              	nvl(TO_CHAR ( CEL.FEC_BAJA, 'YYYYMMDD' ),' ') 	Fecha_baja_telefono,
              	EQUI.IND_PROCEQUI
		FROM    GA_EQUIPABOSER EQUI,
            	GA_ABOAMIST			CEL,
		    	TA_PLANTARIF 		TAP,
		    	GA_EMPRESA   		EMP,
		    	GA_SITUABO   		SIT,
		    	GED_CODIGOS			COD
		WHERE   CEL.NUM_VENTA 		=  :lhNumVenta
		AND 	CEL.FEC_ACTIVACION	>= TO_DATE(:szhFecDesde,'YYYYMMDD') 
		AND 	CEL.FEC_ACTIVACION	<= TO_DATE(:szhFecHasta,'YYYYMMDD') + 1
       	AND   	CEL.NUM_ABONADO		=  EQUI.NUM_ABONADO
       	AND   	EQUI.TIP_TERMINAL  != :szhTipTerminal
       	AND   	EQUI.IND_PROCEQUI   =  :szhIndProcequi
       	AND   	EQUI.FEC_ALTA 		= (SELECT MAX(R.FEC_ALTA) 
            						   FROM 	GA_EQUIPABOSER R
            						   WHERE 	EQUI.NUM_ABONADO = R.NUM_ABONADO
            						   AND 		R.TIP_TERMINAL     != :szhTipTerminal)
	    AND   CEL.COD_PLANTARIF 	=  TAP.COD_PLANTARIF
	    AND	  CEL.COD_EMPRESA   	=  EMP.COD_EMPRESA (+)
		AND   CEL.COD_SITUACION  	=  COD.COD_VALOR
      	AND   COD.COD_MODULO    	=  'CM'
      	AND   COD.NOM_TABLA     	=  'GA_ABOCEL'
      	AND   COD.NOM_COLUMNA   	=  'COD_SITUACION'
	    AND   CEL.COD_SITUACION     =  SIT.COD_SITUACION
        AND   NOT EXISTS (SELECT 1
            FROM   GA_TRASPABO ABO
            WHERE  ABO.NUM_ABONADO   =  CEL.NUM_ABONADO
            AND    ABO.NUM_ABONADO   != ABO.NUM_ABONADOANT); */ 

    	
    	/* EXEC SQL open cur_abonados_prepago; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 19;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlbuft((void **)0, 
       "select TO_CHAR(CEL.NUM_CELULAR) ,CEL.COD_PLANTARIF ,TAP.DES_PLANTARI\
F ,NVL(CEL.NUM_IMEI,CEL.NUM_SERIE) ,DECODE(CEL.NUM_IMEI,null ,'S/N',CEL.NUM_\
SERIE) ,CEL.NUM_ABONADO ,NVL(CEL.COD_AFINIDAD,'0') ,NVL(CEL.COD_TECNOLOGIA,'\
TDMA') ,DECODE(TAP.COD_TIPLAN,'1','PREPAGO',2,'POSPAGO',3,'HIBRIDO') ,SIT.DE\
S_SITUACION Situacion_abonado ,NVL(EMP.DES_EMPRESA,'S/E') compania ,TO_CHAR(\
CEL.FEC_ACTIVACION,'YYYYMMDD') Fecha_activa_telefono ,nvl(TO_CHAR(CEL.FEC_BA\
JA,'YYYYMMDD'),' ') Fecha_baja_telefono ,EQUI.IND_PROCEQUI  from GA_EQUIPABO\
SER EQUI ,GA_ABOAMIST CEL ,TA_PLANTARIF TAP ,GA_EMPRESA EMP ,GA_SITUABO SIT \
,GED_CODIGOS COD where ((((((((((((((CEL.NUM_VENTA=:b0 and CEL.FEC_ACTIVACIO\
N>=TO_DATE(:b1,'YYYYMMDD')) and CEL.FEC_ACTIVACION<=(TO_DATE(:b2,'YYYYMMDD')\
+1)) and CEL.NUM_ABONADO=EQUI.NUM_ABONADO) and EQUI.TIP_TERMINAL<>:b3) and E\
QUI.IND_PROCEQUI=:b4) and EQUI.FEC_ALTA=(select max(R.FEC_ALTA)  from GA_EQU\
IPABOSER R where (EQUI.NUM_ABONADO=R.NUM_ABONADO and R.TIP_TERMINAL<>:b3))) \
and CEL.COD_PLANTARIF=TAP.COD_PLANTARIF) and");
     sqlstm.stmt = sq0003;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )255;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lhNumVenta;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhFecDesde;
     sqlstm.sqhstl[1] = (unsigned long )9;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhFecHasta;
     sqlstm.sqhstl[2] = (unsigned long )9;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhTipTerminal;
     sqlstm.sqhstl[3] = (unsigned long )2;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhIndProcequi;
     sqlstm.sqhstl[4] = (unsigned long )3;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhTipTerminal;
     sqlstm.sqhstl[5] = (unsigned long )2;
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
     if (sqlca.sqlcode < 0) vSqlError_EXT();
}





        while(iFetchedRows == iRetrievRows)
        {
            /* EXEC SQL for :lMaxFetch FETCH cur_abonados_prepago
                INTO     :szhNumCelular				,
                         :szhCodPlanTarif			,
                         :szhDesPlanTarif			,
                         :szhNumImei				, 
                         :szhNumSerie				,
                         :lhNumAbonado				,
                         :ihCodAfinidad				,
                         :szhCodTecnologia			, 
                         :szhTipoPlanTarifario		,
                         :szhDesSituacionAbonado	,
                         :szhcDescripcionEmpresa	,
                         :szhcFecActivaTelefono		,
                         :szhcFecBajaTelefono		,
                         :szhIndProcequiGet			; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 19;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.iters = (unsigned int  )lMaxFetch;
            sqlstm.offset = (unsigned int  )294;
            sqlstm.selerr = (unsigned short)1;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqfoff = (         int )0;
            sqlstm.sqfmod = (unsigned int )2;
            sqlstm.sqhstv[0] = (unsigned char  *)szhNumCelular;
            sqlstm.sqhstl[0] = (unsigned long )16;
            sqlstm.sqhsts[0] = (         int  )16;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqharc[0] = (unsigned long  *)0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)szhCodPlanTarif;
            sqlstm.sqhstl[1] = (unsigned long )4;
            sqlstm.sqhsts[1] = (         int  )4;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqharc[1] = (unsigned long  *)0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhDesPlanTarif;
            sqlstm.sqhstl[2] = (unsigned long )31;
            sqlstm.sqhsts[2] = (         int  )31;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqharc[2] = (unsigned long  *)0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhNumImei;
            sqlstm.sqhstl[3] = (unsigned long )26;
            sqlstm.sqhsts[3] = (         int  )26;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqharc[3] = (unsigned long  *)0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhNumSerie;
            sqlstm.sqhstl[4] = (unsigned long )26;
            sqlstm.sqhsts[4] = (         int  )26;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqharc[4] = (unsigned long  *)0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)lhNumAbonado;
            sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
            sqlstm.sqhsts[5] = (         int  )sizeof(long);
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqharc[5] = (unsigned long  *)0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)ihCodAfinidad;
            sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
            sqlstm.sqhsts[6] = (         int  )sizeof(int);
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqharc[6] = (unsigned long  *)0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)szhCodTecnologia;
            sqlstm.sqhstl[7] = (unsigned long )8;
            sqlstm.sqhsts[7] = (         int  )8;
            sqlstm.sqindv[7] = (         short *)0;
            sqlstm.sqinds[7] = (         int  )0;
            sqlstm.sqharm[7] = (unsigned long )0;
            sqlstm.sqharc[7] = (unsigned long  *)0;
            sqlstm.sqadto[7] = (unsigned short )0;
            sqlstm.sqtdso[7] = (unsigned short )0;
            sqlstm.sqhstv[8] = (unsigned char  *)szhTipoPlanTarifario;
            sqlstm.sqhstl[8] = (unsigned long )21;
            sqlstm.sqhsts[8] = (         int  )21;
            sqlstm.sqindv[8] = (         short *)0;
            sqlstm.sqinds[8] = (         int  )0;
            sqlstm.sqharm[8] = (unsigned long )0;
            sqlstm.sqharc[8] = (unsigned long  *)0;
            sqlstm.sqadto[8] = (unsigned short )0;
            sqlstm.sqtdso[8] = (unsigned short )0;
            sqlstm.sqhstv[9] = (unsigned char  *)szhDesSituacionAbonado;
            sqlstm.sqhstl[9] = (unsigned long )31;
            sqlstm.sqhsts[9] = (         int  )31;
            sqlstm.sqindv[9] = (         short *)0;
            sqlstm.sqinds[9] = (         int  )0;
            sqlstm.sqharm[9] = (unsigned long )0;
            sqlstm.sqharc[9] = (unsigned long  *)0;
            sqlstm.sqadto[9] = (unsigned short )0;
            sqlstm.sqtdso[9] = (unsigned short )0;
            sqlstm.sqhstv[10] = (unsigned char  *)szhcDescripcionEmpresa;
            sqlstm.sqhstl[10] = (unsigned long )51;
            sqlstm.sqhsts[10] = (         int  )51;
            sqlstm.sqindv[10] = (         short *)0;
            sqlstm.sqinds[10] = (         int  )0;
            sqlstm.sqharm[10] = (unsigned long )0;
            sqlstm.sqharc[10] = (unsigned long  *)0;
            sqlstm.sqadto[10] = (unsigned short )0;
            sqlstm.sqtdso[10] = (unsigned short )0;
            sqlstm.sqhstv[11] = (unsigned char  *)szhcFecActivaTelefono;
            sqlstm.sqhstl[11] = (unsigned long )30;
            sqlstm.sqhsts[11] = (         int  )30;
            sqlstm.sqindv[11] = (         short *)0;
            sqlstm.sqinds[11] = (         int  )0;
            sqlstm.sqharm[11] = (unsigned long )0;
            sqlstm.sqharc[11] = (unsigned long  *)0;
            sqlstm.sqadto[11] = (unsigned short )0;
            sqlstm.sqtdso[11] = (unsigned short )0;
            sqlstm.sqhstv[12] = (unsigned char  *)szhcFecBajaTelefono;
            sqlstm.sqhstl[12] = (unsigned long )30;
            sqlstm.sqhsts[12] = (         int  )30;
            sqlstm.sqindv[12] = (         short *)0;
            sqlstm.sqinds[12] = (         int  )0;
            sqlstm.sqharm[12] = (unsigned long )0;
            sqlstm.sqharc[12] = (unsigned long  *)0;
            sqlstm.sqadto[12] = (unsigned short )0;
            sqlstm.sqtdso[12] = (unsigned short )0;
            sqlstm.sqhstv[13] = (unsigned char  *)szhIndProcequiGet;
            sqlstm.sqhstl[13] = (unsigned long )2;
            sqlstm.sqhsts[13] = (         int  )2;
            sqlstm.sqindv[13] = (         short *)0;
            sqlstm.sqinds[13] = (         int  )0;
            sqlstm.sqharm[13] = (unsigned long )0;
            sqlstm.sqharc[13] = (unsigned long  *)0;
            sqlstm.sqadto[13] = (unsigned short )0;
            sqlstm.sqtdso[13] = (unsigned short )0;
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
            if (sqlca.sqlcode < 0) vSqlError_EXT();
}

 

            iRetrievRows = sqlca.sqlerrd[2] - iLastRows;
            iLastRows = sqlca.sqlerrd[2];
               
            for (i=0; i < iRetrievRows; i++)
            {
                aaux = (stAbonado *) malloc (sizeof(stAbonado));

                strcpy(aaux->szNumCelular           , szfnTrim(szhNumCelular[i]));
                strcpy(aaux->szCodPlanTarif   		, szfnTrim(szhCodPlanTarif[i]));
                strcpy(aaux->szDesPlanTarif   		, szfnTrim(szhDesPlanTarif[i]));
                strcpy(aaux->szNumSerie       		, szfnTrim(szhNumSerie[i]));
                aaux->lNumAbonado             		= lhNumAbonado[i];
                aaux->iCodAfinidad            		= ihCodAfinidad[i];
                strcpy(aaux->szCodTecnologia  		, szfnTrim(szhCodTecnologia[i])); 
                strcpy(aaux->szTipPlanTarif   		, szfnTrim(szhTipoPlanTarifario[i]));
                strcpy(aaux->szNumImei   			, szfnTrim(szhNumImei[i]));
                strcpy(aaux->szDesSituacionAbonado	, szfnTrim(szhDesSituacionAbonado[i]));
                strcpy(aaux->szcDescripcionEmpresa	, szfnTrim(szhcDescripcionEmpresa[i]));
                strcpy(aaux->szcFecActivaTelefono	, szfnTrim(szhcFecActivaTelefono[i]));
                strcpy(aaux->szcFecBajaTelefono		, szfnTrim(szhcFecBajaTelefono[i]));
		
				fprintf(pfLog , "\n\tAbonado Recuperado:[%ld] ->Celular:[%ld]", aaux->lNumAbonado, aaux->szNumCelular);     
				fprintf(stderr, "\n\tAbonado Recuperado:[%ld] ->Celular:[%ld]", aaux->lNumAbonado, aaux->szNumCelular);		

                aaux->cIndConsidera           		= 'S';
                aaux->sgte                    		= paux->abonado_sgte;
                paux->abonado_sgte            		= aaux;
				
                iCantAbonados++;
            }
		}
	}
    /* EXEC SQL close cur_abonados_prepago; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )365;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    fprintf(stderr, "\n[ifnGetAbonados_prepago] Abonados Recuperados (retorno):[%d]\n",iCantAbonados);
    fprintf(pfLog , "\n[ifnGetAbonados_prepago] Abonados Recuperados (retorno):[%d]\n",iCantAbonados);
    lCantTotalAbonados += iCantAbonados;
	return iCantAbonados;
}
/* ***************************************************************************** */
/* Del universo seleccionado, ahora se rescatan los equipos.                     */
/* ***************************************************************************** */
void vGetEquipos()
{
    stUniverso * paux;
    stAbonado  * aaux;
    int          iCantAboRead  = 0;
    int          iCantAboValid = 0;
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

 		long    lhNumAbonado;
		long	lzhTipTerminal;
		char	szhDesTerminal[41];
		int		ihCodFabricante;
		char	szhDesFabricante[21];
		char    szhIndProcequi[3];      
		char	szhTipTerminal[2];
    /* EXEC SQL END DECLARE SECTION; */ 

	strcpy(szhIndProcequi, "E");
    strcpy(szhTipTerminal , "G");

	fprintf(stderr, "\n[vGetEquipos] Recupera Datos de Terminal.\n");
	fprintf(pfLog , "\n[vGetEquipos] Recupera Datos de Terminal.\n");

    for(paux = lstUniverso; paux != NULL; paux = paux->sgte)
    {
        if (paux->cIndConsidera == 'S')
        {
			for (aaux = paux->abonado_sgte; aaux != NULL; aaux = aaux->sgte)
			{
		        if (aaux->cIndConsidera == 'S')
		        {
					lhNumAbonado 		= aaux->lNumAbonado;
					iCantAboRead++;
					fprintf(stderr, "\t[vGetEquipos] Procesa Abonado:[%ld].\n", lhNumAbonado);
					fprintf(pfLog , "\t[vGetEquipos] Procesa Abonado:[%ld].\n", lhNumAbonado);
					/* EXEC SQL SELECT 
								A.COD_ARTICULO,
								B.DES_ARTICULO,
								B.COD_FABRICANTE, 
								D.DES_FABRICANTE
						INTO	:lzhTipTerminal,
								:szhDesTerminal,
								:ihCodFabricante,
								:szhDesFabricante
						FROM 	GA_EQUIPABOSER A, 
								AL_ARTICULOS B, 
								AL_TIPOS_TERMINALES C, 
								AL_FABRICANTES D
						WHERE 	A.NUM_ABONADO 	 = :lhNumAbonado
						AND     A.TIP_TERMINAL  != :szhTipTerminal
						AND 	A.FEC_ALTA 		 = (SELECT MAX(X.FEC_ALTA) 
                									FROM GA_EQUIPABOSER X
													WHERE X.NUM_ABONADO   = :lhNumAbonado
													AND   X.TIP_TERMINAL != :szhTipTerminal)
						AND 	A.COD_ARTICULO = B.COD_ARTICULO
						AND 	B.TIP_TERMINAL = C.TIP_TERMINAL
						AND 	B.COD_FABRICANTE = D.COD_FABRICANTE
						AND     ROWNUM < 2; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 19;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select A.COD_ARTICULO ,B.DES_ARTICULO ,B.COD_FABRICANTE \
,D.DES_FABRICANTE into :b0,:b1,:b2,:b3  from GA_EQUIPABOSER A ,AL_ARTICULOS B \
,AL_TIPOS_TERMINALES C ,AL_FABRICANTES D where ((((((A.NUM_ABONADO=:b4 and A.T\
IP_TERMINAL<>:b5) and A.FEC_ALTA=(select max(X.FEC_ALTA)  from GA_EQUIPABOSER \
X where (X.NUM_ABONADO=:b4 and X.TIP_TERMINAL<>:b5))) and A.COD_ARTICULO=B.COD\
_ARTICULO) and B.TIP_TERMINAL=C.TIP_TERMINAL) and B.COD_FABRICANTE=D.COD_FABRI\
CANTE) and ROWNUM<2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )380;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&lzhTipTerminal;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhDesTerminal;
     sqlstm.sqhstl[1] = (unsigned long )41;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodFabricante;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)szhDesFabricante;
     sqlstm.sqhstl[3] = (unsigned long )21;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)&lhNumAbonado;
     sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhTipTerminal;
     sqlstm.sqhstl[5] = (unsigned long )2;
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
     sqlstm.sqhstv[7] = (unsigned char  *)szhTipTerminal;
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
     if (sqlca.sqlcode < 0) vSqlError_EXT();
}



					if (sqlca.sqlcode!=SQLOK)
					{
						aaux->cIndConsidera = 'N';
						fprintf(stderr, "\n[vGetEquipos] Error Recuperando datos terminal Abonado:[%ld]\n", lhNumAbonado);
						fprintf(pfLog , "\n[vGetEquipos] Error Recuperando datos terminal Abonado:[%ld]\n", lhNumAbonado);
					}
					else
					{
						iCantAboValid++;
						       aaux->lzTipTerminal		= lzhTipTerminal	     ;
						strcpy(aaux->szDesTerminal		, szfnTrim(szhDesTerminal  ));
						strcpy(aaux->szDesFabricante	, szfnTrim(szhDesFabricante));
						       aaux->iCodFabricante 	= ihCodFabricante	     ;
					}

				}
			}
		}
    }
	fprintf(stderr, "\n[vGetEquipos] Total Abonados Procesados:[%d] -> Validos:[%d].\n", iCantAboRead, iCantAboValid);
	fprintf(pfLog , "\n[vGetEquipos] Total Abonados Procesados:[%d] -> Validos:[%d].\n", iCantAboRead, iCantAboValid);
}
/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por las listas de abonados.      */
/*****************************************************************************/
void vLiberaAbonados(stAbonado * qaux)
{
    if (qaux!=NULL)
    {
        vLiberaAbonados(qaux->sgte);
        free(qaux);
    }
}

/*****************************************************************************/
/* Rutina que devuelve la memoria utilizada por la lista de ventas.          */
/* como pueden ser "n" ventas, se hará con while y no recursiva...           */
/*****************************************************************************/
void vLiberaUniverso()
{
    stUniverso * paux;
    stUniverso * qaux;
    if (lstUniverso != NULL)
    {
        qaux = lstUniverso;
        paux = lstUniverso->sgte;
        while (paux!=NULL)
        {
            vLiberaAbonados(qaux->abonado_sgte);
            qaux->abonado_sgte = NULL;
            free(qaux);
            qaux = paux;
            paux = qaux->sgte;
        }
        if (qaux!=NULL)
        {
            vLiberaAbonados(qaux->abonado_sgte);
            qaux->abonado_sgte = NULL;
            free(qaux);
        }
    }
}

/*****************************************************************************/
/* Rutina que busca un campo de detalle de archivo en una lista              */
/*****************************************************************************/
char szBuscaArchivo()
{
    stArchivo     *paux_archivos;
    stDetArchivo  *paux_det_archivo;
    stUniverso    *paux_venta;
    stAbonado     *paux_abonado;
    
    char          szLineaArchivo[2048];                           
    char          szCampoArchivo[1024];
    char          szNomArchivo_dat[250] ;
    char          szNomArchivo_lst[250] ;
    char          separador;                           
    int 	  i,j,k;
    int		  bRes;
    char          *aux;
    int		  iNumLineas = 0;
    int		  iNumArchivos = 0;

	for (paux_archivos = lstArchivo;paux_archivos != NULL; paux_archivos=paux_archivos->sgte)
    {
		sprintf(szDatName, "%s_%s", UNIVERSO, paux_archivos->szNomFisico);
        	bGeneraArchivoExtractores(&pfDat,szDatName,pszEnvDat,szhSysDate,DAT, szNomArchivo_dat);
		
		if (pfDat==NULL)
		{
			fprintf(stderr, "\nError en Generacion de Archivo de Datos:[%s]", szNomArchivo_dat );
			fprintf(stderr, "Revise su existencia.\n");
			fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
			fprintf(stderr, "Proceso finalizado con error.\n");
		}

		bGeneraArchivoExtractores(&pfLst, szDatName, pszEnvDat, szhSysDate, LST, szNomArchivo_lst);
		if(pfLst == NULL)
		{
			fprintf(stderr, "\nError en Generacion de Archivo de Datos:[%s]", szNomArchivo_lst );
			fprintf(stderr, "Revise su existencia.\n");
			fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));
			fprintf(stderr, "Proceso finalizado con error.\n");
		}
		iNumLineas = 0;
    	iNumArchivos++;
		
    	/* primero se lista el encabezado del archivo */
		memset(szLineaArchivo, 0, sizeof(szLineaArchivo)); 
		for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
		{
	        aux = szFormatEtiqueta(paux_det_archivo);
        	sprintf(szCampoArchivo, "%s", aux);
            separador = paux_archivos->szCarSeparador[0];
			if (paux_det_archivo->sgte != NULL)
			{ 
				if (separador != 'X')
					sprintf(szLineaArchivo,"%s%s%c", szLineaArchivo,szCampoArchivo,separador);
				else
					sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
			}
			else
				sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
			free(aux);
		}
		fprintf(pfDat ,"%s\n", szLineaArchivo);
		
		for (paux_venta =lstUniverso,i=0 ;paux_venta != NULL; paux_venta = paux_venta->sgte,i++)
        {
           	if (paux_venta->cIndConsidera == 'S')
           	{
	           	for (paux_abonado = paux_venta->abonado_sgte, j=0; paux_abonado != NULL; paux_abonado = paux_abonado->sgte,j++)
	           	{
	              	if (paux_abonado->cIndConsidera == 'S')
					{
		              	memset(szLineaArchivo, 0, sizeof(szLineaArchivo)); 
		              	for (paux_det_archivo = paux_archivos->sgte_detalle,i=0; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte,i++)
		              	{
				            aux = szBuscaDetalleCampoi(paux_venta, paux_abonado, paux_det_archivo);
		                   	sprintf(szCampoArchivo, "%s", aux);
		                    separador = paux_archivos->szCarSeparador[0]; 
		                    if (paux_det_archivo->sgte != NULL)
		                    { 
		                        if (separador != 'X')
		                        	sprintf(szLineaArchivo,"%s%s%c", szLineaArchivo,szCampoArchivo,separador);
		                        else
		                           	sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
		                    }
		                    else
		                       sprintf(szLineaArchivo,"%s%s", szLineaArchivo,szCampoArchivo);
		                    
		                    free(aux);
		              	}
						/*fprintf(stderr,"[%d][%s]\n", iNumLineas, szLineaArchivo); */
		                fprintf(pfDat,"%s\n",szLineaArchivo);
		                iNumLineas++;
	           		}
	           	}
			}
        }
		fprintf(stderr,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(stderr,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(stderr,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(stderr,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		fprintf(pfLog,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(pfLog,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(pfLog,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(pfLog,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		fprintf(pfLst,"\nArchivo Generado                : [%s]\n", szNomArchivo_dat); 
		fprintf(pfLst,"\nRegistros Generados             : [%d]\n", iNumLineas);
		fprintf(pfLst,"\nFechas de Inicio de Generacion  : [%s]\n", stArgsExt.szFecDesde);
		fprintf(pfLst,"\nFechas de Termino de Generacion : [%s]\n", stArgsExt.szFecHasta);

		/* Actualiza Traza de Archivos... */
		fprintf(pfLog ,"\nActualiza Trazas de Archivos: [%s]\n", szNomArchivo_dat);
		fprintf(stderr,"\nActualiza Trazas de Archivos: [%s]\n", szNomArchivo_dat);
		if (!ifnActualizaTrazasArchivos(paux_archivos->szNomFisico, UNIVERSO, stArgsExt.lNumSecuencia, szNomArchivo_dat, iNumLineas, getlogin()))
		{
			fprintf(pfLog ,"\nError Actualizando Trazas de Archivos.\n");
			fprintf(stderr,"\nError Actualizando Trazas de Archivos.\n");
		}

		fprintf(pfLst,"\nDetalle de Campos Listados:");
		fprintf(pfLst, "\n[COL][CAMPO                    ][LEN][JUS][FIL][TYP]");
		
		for (paux_det_archivo = paux_archivos->sgte_detalle; paux_det_archivo != NULL; paux_det_archivo = paux_det_archivo->sgte)
		{
			fprintf(pfLst, "\n[%-3d][%-25.25s][%-3d][%-3.3s][%-3.3s][%-3.3s]",
			paux_det_archivo->iNumOrden, paux_det_archivo->szNomCampo, paux_det_archivo->iLargoCampo,
			paux_det_archivo->szIndJustificado, paux_det_archivo->szCarRelleno, paux_det_archivo->szTipoDato);
		}

		fclose(pfLst);
		fclose(pfDat);
         
    }
	stStatusProc.lCantArchivos = iNumArchivos;    
    return(TRUE);
}


/*****************************************************************************/
/* Rutina que busca un campo de detalle de archivo en una lista             */
/*****************************************************************************/
char *szBuscaDetalleCampoi(stUniverso    *paux, stAbonado     *paux_abonado, stDetArchivo  *paux_det_archivo)
{    
    char   szCodCampo[31];
    char   *szResp;         
    long   lNunVenta;
    int    iLargoCampo = paux_det_archivo->iLargoCampo;
    char   szFormato[81];
    /*char   tipo='s';    */
    char   pszTipoDato[15];

    if (iLargoCampo == 0) iLargoCampo=8; /* para fechas, por si no vienen con largo */
    szResp = (char *) malloc(sizeof(iLargoCampo +1));
    if (!szResp) 
       fprintf(stderr, "[szBuscaDetalleCampoi] No se pudo asignar memoria a szResp        [%s]\n",paux_det_archivo->szNomCampo);
    memset(szResp,0,(iLargoCampo ));
    
    strcpy(szCodCampo      , paux_det_archivo->szNomCampo);
    strcpy(pszTipoDato     , paux_det_archivo->szTipoDato);
    strcpy(szFormato       , paux_det_archivo->szFormato);

/*    fprintf(stderr, "[szBuscaDetalleCampoi] Campo:[%s] 	szFormato:[%s]\n",szCodCampo, szFormato); */
/*    fprintf(pfLog , "[szBuscaDetalleCampoi] Campo:[%s] 	szFormato:[%s]\n",szCodCampo, szFormato); */

 	   	   if (strncmp( "COD_REGION"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szCodRegion  				    );
      else if (strncmp( "NUM_CONTRATO"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->cContrato        				); 
      else if (strncmp( "NOM_CLIENTE"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux->cNombre               			);
      else if (strncmp( "NOM_APECLIEN1"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->cApellidos            			);
      else if (strncmp( "DES_EMPRESA"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szcDescripcionEmpresa	);
      else if (strncmp( "DIRECCION"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->szDireccion           			);
      else if (strncmp( "NUM_IDENT"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->num_cCedula               		);
      else if (strncmp( "NUM_RUC"             ,szfnTrim(szCodCampo),7  ) == 0)  sprintf(szResp,szFormato, paux->num_cRut                  		);
      else if (strncmp( "FEC_ACEPVENT"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->cFec_Aceptacion_venta 			);
      else if (strncmp( "NUM_CELULAR"         ,szfnTrim(szCodCampo),11 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szNumCelular    		);
      else if (strncmp( "FEC_ALTA"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux_abonado->szcFecActivaTelefono  	);
      else if (strncmp( "FEC_BAJA"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux_abonado->szcFecBajaTelefono		);      
      else if (strncmp( "FEC_VENTA"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->cFec_ultimo_cambio    			);
      else if (strncmp( "NOM_USUAR_VTA"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->usuario               			);
      else if (strncmp( "COD_TIPLAN"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szTipPlanTarif			);
      else if (strncmp( "COD_TECNOLOGIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szCodTecnologia			);
      else if (strncmp( "TIP_TERMINAL"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux_abonado->lzTipTerminal   		);   
      else if (strncmp( "DES_TERMINAL"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szDesTerminal   		);   
      else if (strncmp( "COD_FABRICANTE"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux_abonado->iCodFabricante   		);   
      else if (strncmp( "DES_FABRICANTE"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szDesFabricante   		);   
      else if (strncmp( "COD_PLANTARIF"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szCodPlanTarif       	);
      else if (strncmp( "DES_PLANTARIF"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szDesPlanTarif        	);
      else if (strncmp( "COD_VENDEDOR"        ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->Vendedor              			); 
      else if (strncmp( "DES_CIUDAD"          ,szfnTrim(szCodCampo),10 ) == 0)  sprintf(szResp,szFormato, paux->szDesCiudad   					);   
      else if (strncmp( "DES_PROVINCIA"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux->szDesProvincia   				);        
      else if (strncmp( "COD_FRANQUICIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szCodCiudad   					);        
      else if (strncmp( "DES_FRANQUICIA"      ,szfnTrim(szCodCampo),14 ) == 0)  sprintf(szResp,szFormato, paux->szDesCiudad   					);   
      else if (strncmp( "COD_CICLO"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->Ciclo                 			); 
      else if (strncmp( "IND_VENTA"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux->Indicador_venta 	  			);
      else if (strncmp( "DES_SITUACION"       ,szfnTrim(szCodCampo),13 ) == 0)  sprintf(szResp,szFormato, paux_abonado->szDesSituacionAbonado	);     
      else if (strncmp( "IND_ESTVENTA"  	  ,szfnTrim(szCodCampo),12 ) == 0)  sprintf(szResp,szFormato, paux->szIndEstVenta           		);  
      else if (strncmp( "BLANCO"  			  ,szfnTrim(szCodCampo),6  ) == 0)  sprintf(szResp,szFormato, CARACBLANCO      		  				);  
      else if (strncmp( "NUM_SERIE"           ,szfnTrim(szCodCampo),9  ) == 0)  sprintf(szResp,szFormato, paux_abonado->szNumSerie 				);
      else if (strncmp( "NUM_IMEI"            ,szfnTrim(szCodCampo),8  ) == 0)  sprintf(szResp,szFormato, paux_abonado->szNumImei               );

/*	 fprintf(stderr, "[szBuscaDetalleCampoi] Parseo realizado.. respuesta[%s]\n",szResp); */
/*	 fprintf(pfLog , "[szBuscaDetalleCampoi] Parseo realizado.. respuesta[%s]\n",szResp); */

    if (szResp[0] == NULL){
        if (pszTipoDato[0] == 'N')
             sprintf(szResp,szFormato,0);
        else
             sprintf(szResp,szFormato," ");
    }
    return (szResp);
}
/*****************************************************************************/
/* Rutina principal.                                                         */
/*****************************************************************************/
int main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Definición de buffer local.                                               */
/*---------------------------------------------------------------------------*/
	char        buffer_local[1900];
	char        aux_nombre[300];
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
    long  lSegIni, lSegFin;         
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
    memset(&stArgsExt, 0, sizeof(rg_argextractores));
    vManejaArgsExt(argc, argv);
    memset(&stDireccion, 0, sizeof(rg_direccion));
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "\nstArgsExt.szUser        [%s]\n", stArgsExt.szUser);
    fprintf(stderr, "\nstArgsExt.szPass        [%s]\n", stArgsExt.szPass);
    
    strcpy(szhUser, stArgsExt.szUser);                                                      
    strcpy(szhPass, stArgsExt.szPass);                                                    
    if(fnOraConnect(szhUser, szhPass) == FALSE)                                          
    {                                                                                  
            fprintf(stderr, "\nUsuario/Password Oracle no son validos. Se cancela.\n");
            exit(EXIT_205);                                                            
    }                                                                                  
    else                                                                               
    {                                                                                  
            fprintf(stderr, "\nConexion con la base de datos ha sido exitosa.\n");     
            fprintf(stderr, "Username: %s\n\n", szhUser);                              
    }
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando ambiente para archivos de log ...\n");                    
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)                                               
    {                                                                                                                  
            exit(1);
    }                                                                                                                  

    fprintf(stderr, "Preparando ambiente para archivos de datos...\n");                    
    if((pszEnvDat = (char *)pszEnviron("XPCM_DAT", "")) == (char *)NULL)                                               
    {
            exit(1);
    }
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);                                         
    fprintf(stderr, "Directorio de Dats         : [%s]\n", (char *)pszEnvDat);                                         

/*---------------------------------------------------------------------------*/
/* GENERACION DEL NOMBRE Y CREACION DEL ARCHIVO DE LOG.                      */
/*---------------------------------------------------------------------------*/
     strncpy(szhSysDate, pszGetDateLog(),16);                                                            

    bGeneraArchivoExtractores(&pfLog, LOGNAME, pszEnvLog,szhSysDate,LOG,aux_nombre );                                                          
    if(pfLog == NULL)                                                          
    {                                                                                                        
        fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", LOGNAME);                                 
        fprintf(stderr, "Revise su existencia.\n");                                                          
        fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
        fprintf(stderr, "Proceso finalizado con error.\n");
        exit(EXIT_03);                                                  
    }                                                                                                               
/*---------------------------------------------------------------------------*/
/* HEADER.                                                                   */
/*---------------------------------------------------------------------------*/ 
    vFechaHora();                                                               
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog,  "%s\n", szRaya);                    
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "%s\n", GLOSA_PROG);                
    fprintf(pfLog,  "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog,  "Ultima Revision: [%s]\n", LAST_REVIEW);                
    fprintf(pfLog,  "%s\n\n", szRaya);                  

    fprintf(pfLog,  "\n Argumentos de Ejecucion\n");
    
    fprintf(pfLog,  "Fecha Desde        [%s]\n", stArgsExt.szFecDesde);
    fprintf(pfLog,  "Fecha Hasta        [%s]\n", stArgsExt.szFecHasta);
    fprintf(pfLog,  "Username unix   [%s](id = %d)\n", getlogin(), getuid());
    fprintf(pfLog,  "Base de datos   [%s]\n\n", (strcmp(getenv("ORACLE_SID"), "")!=0?getenv("ORACLE_SID"):getenv("TWO_TASK"))); 
/*---------------------------------------------------------------------------*/
/* MODIFICACION DE CONFIGURACION AMBIENTAL, PARA MANEJO DE FECHAS EN ORACLE. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )427;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


/*---------------------------------------------------------------------------*/
/* CARGA LISTA DE ARCHIVOS A GENERAR                                         */
/*---------------------------------------------------------------------------*/

    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga la definción de Archivos para universo:[%s].\n",UNIVERSO);
    fprintf(stderr,"\n(Principal) Carga la definción de Archivos para universo:[%s].\n",UNIVERSO);
    lstArchivo = stCargaDefArchivo(UNIVERSO);
    if (lstArchivo == NULL)
    {
	    fprintf(pfLog ,"\n(Principal) No Existen Archivos Configurados para este Universo:[%s].\n",UNIVERSO);
	    fprintf(stderr,"\n(Principal) No Existen Archivos Configurados para este Universo:[%s].\n",UNIVERSO);
    	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 10, "No hay Archivos Configurados.", iCIERRATRAZAOK);
		exit(EXIT_0);
    }
    vMuestraArchivo(lstArchivo);
    
/*---------------------------------------------------------------------------*/
/* CARGA REGISTROS DE VENTAS DEL PERIODO                                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga xlas Ventas Aceptadas entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
    fprintf(stderr,"\n(Principal) Carga xlas Ventas Aceptadas entre las Fechas:[%s] y [%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
    vSeleccionarUniverso(stArgsExt.szFecDesde, stArgsExt.szFecHasta);
    if (lstUniverso == NULL)
    {
	    fprintf(pfLog ,"\n(Principal) No Existen Eventos para Informar en el Periodo Desde:[%s] y Hasta:[%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
	    fprintf(stderr,"\n(Principal) No Existen Eventos para Informar en el Periodo Desde:[%s] y Hasta:[%s].\n",stArgsExt.szFecDesde,stArgsExt.szFecHasta);
    	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 10, "No Existen Eventos para Informar.", iCIERRATRAZAOK);
		exit(EXIT_0);
    }
/*---------------------------------------------------------------------------*/
/* CARGA DATOS DE LOS EQUIPOS Y TIPO TERMINAL                                */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Carga los datos de los equipos de los abonados.\n");
    fprintf(stderr,"\n(Principal) Carga los datos de los equipos de los abonados.\n");
	vGetEquipos();
/*---------------------------------------------------------------------------*/
/* PROCEDE A LA GENERACION DE LOS ARCHIVOS DE DATOS...                       */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Genera los Archivos de Datos.\n");
    fprintf(stderr,"\n(Principal) Genera los Archivos de Datos.\n");
    szBuscaArchivo();
/*---------------------------------------------------------------------------*/
/* LIBERA MEMORIA UTILIZADA POR LOS DATOS RECUPERADOS...                     */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog ,"\n(Principal) Libera memoria de Universos.\n");
    fprintf(stderr,"\n(Principal) Libera memoria de Universos.\n");
    vLiberaUniverso();
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();                         
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/
    fprintf(pfLog, "\n\n\nEstadistica del proceso\n");                                                   
    fprintf(pfLog, "-------------------------\n");
    fprintf(pfLog, "Archivos Generados             : [%d]\n\n", stStatusProc.lCantArchivos);   
    fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);  
	fprintf(stderr, "\n\n\nEstadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
    fprintf(stderr, "Archivos Generados             : [%d]\n\n", stStatusProc.lCantArchivos);  
	fprintf(stderr, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);
/*---------------------------------------------------------------------------*/
/* ACTUALIZA TRAZA DE EXTRACTORES                                            */
/*---------------------------------------------------------------------------*/
	fprintf(pfLog ,"\n(Principal) Actualiza Traza de Extractores(iCIERRATRAZAOK): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);
	fprintf(stderr,"\n(Principal) Actualiza Traza de Extractores(iCIERRATRAZAOK): Secuencia:[%d] Proceso:[%s].\n",stArgsExt.lNumSecuencia, UNIVERSO);
	ifnActualizaTrazasExtractores(stArgsExt.lNumSecuencia, UNIVERSO, 0, "", iCIERRATRAZAOK);
	
    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 19;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )442;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError_EXT();
}


    
    vFechaHora();
    fprintf(stderr, "Programa [%s] finalizado ok.\n", basename(argv[0]));
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "Proceso [%s] finalizado ok.\n", basename(argv[0]));
    fclose(pfLog);
    return(EXIT_0);
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

