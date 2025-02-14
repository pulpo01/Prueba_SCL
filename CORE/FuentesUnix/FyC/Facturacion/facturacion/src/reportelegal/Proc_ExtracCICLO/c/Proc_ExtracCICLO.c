
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
           char  filnam[25];
};
static struct sqlcxp sqlfpn =
{
    24,
    "./pc/Proc_ExtracCICLO.pc"
};


static unsigned int sqlctx = 887575027;


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
   unsigned char  *sqhstv[30];
   unsigned long  sqhstl[30];
            int   sqhsts[30];
            short *sqindv[30];
            int   sqinds[30];
   unsigned long  sqharm[30];
   unsigned long  *sqharc[30];
   unsigned short  sqadto[30];
   unsigned short  sqtdso[30];
} sqlstm = {12,30};

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

 static char *sq0013 = 
"select PROC.COD_ESTAPREC ,NVL(TRAZ.COD_ESTAPROC,0)  from FA_TRAZAPROC TRAZ ,\
(select A.COD_PROCESO COD_PROCESO ,B.DES_PROCESO DES_PROCESO ,A.COD_PROCPREC C\
OD_PROCPREC ,C.DES_PROCESO DES_PROCPREC ,A.COD_ESTAPREC COD_ESTAPREC  from FA_\
PROCFACTPREC A ,FA_PROCFACT B ,FA_PROCFACT C where ((A.COD_PROCESO=:b0 and A.C\
OD_PROCESO=B.COD_PROCESO) and A.COD_PROCPREC=C.COD_PROCESO)) PROC where (TRAZ.\
COD_CICLFACT(+)=:b1 and TRAZ.COD_PROCESO(+)=PROC.COD_PROCPREC) order by PROC.C\
OD_PROCESO            ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,0,0,17,211,0,0,1,1,0,1,0,1,97,0,0,
24,0,0,1,0,0,45,225,0,0,0,0,0,1,0,
39,0,0,1,0,0,13,238,0,0,30,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,
4,0,0,2,97,0,0,2,4,0,0,2,4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,2,3,0,0,2,3,0,
0,2,97,0,0,2,4,0,0,2,97,0,0,2,97,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,4,0,0,2,97,0,0,
2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,3,0,0,
174,0,0,1,0,0,15,284,0,0,0,0,0,1,0,
189,0,0,2,106,0,4,502,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
216,0,0,3,257,0,3,517,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
239,0,0,4,191,0,4,570,0,0,3,1,0,1,0,2,97,0,0,2,97,0,0,1,3,0,0,
266,0,0,5,339,0,3,620,0,0,13,13,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,
0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
333,0,0,6,430,0,5,669,0,0,15,15,0,1,0,1,3,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
408,0,0,7,191,0,4,738,0,0,3,1,0,1,0,2,97,0,0,2,97,0,0,1,3,0,0,
435,0,0,8,106,0,4,786,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
462,0,0,9,257,0,3,800,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
485,0,0,10,339,0,3,831,0,0,13,13,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,3,0,0,1,4,0,0,
552,0,0,11,430,0,5,879,0,0,15,15,0,1,0,1,3,0,0,1,4,0,0,1,4,0,0,1,4,0,0,1,4,0,0,
1,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,
627,0,0,12,115,0,4,935,0,0,1,0,0,1,0,2,97,0,0,
646,0,0,13,488,0,9,1005,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
669,0,0,13,0,0,13,1025,0,0,2,0,0,1,0,2,3,0,0,2,3,0,0,
692,0,0,13,0,0,15,1056,0,0,0,0,0,1,0,
};


/* *********************************************************************** */
/* *  Fichero : Proc_ExtracCICLO.pc                                        * */
/* *  Extractor de data para la Generacion de Reportes Legales		 * */
/* *  Autor : Patricio Gonzalez Gomez	                                 * */
/* *  Modif : 								 * */
/* *  Parametros : 							 * */
/* *         -u Usuario/Password                                         * */
/* *         -c Ciclo de Facturacion 	                                 * */
/* *         -l Nivel de Log						 * */
/* *********************************************************************** */

#define _PROC_EXTRACCICLO_PC_

#include <deftypes.h>
#include <stdlib.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "Proc_ExtracCICLO.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

char  modulo[30];

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





/* DESDE AQUI PGG FUNCIONES NUEVAS */
void trim (const char *c, char *result)
{
   char *l;
   char *r;
   for(l=(char *)c;  *l==' '; l++);
   for(r=(char *)c+strlen(c)-1;  *r==' '; r--);

   strncpy(result, l, (r>=l)?r-l+1:1);
   result[r-l+1]=0;
}

/* --------Estructura DatosAcum Desde Aqui */

void vfnPrintDatosAcum (REG_DATOSACUM *pstDatosAcum, int iNumAcum)
{
        int i = 0;

	strcpy(modulo,"vfnPrintDatosAcum");
        vDTrazasLog(modulo,"\n\t\t* Despliegue de la Carga de Datos Acum ... [%d]", LOG05, iNumAcum);

        for (i=0;i<iNumAcum;i++)
        {
                vDTrazasLog(modulo,	"----------------------------------------------------\n"
					"pstDatosAcum[%d].lNum_Secuenci      		[%ld]\n"
					"pstDatosAcum[%d].lCod_Tipdocum      		[%ld]\n"
					"pstDatosAcum[%d].lCod_Vendedor_Agente		[%ld]\n"
					"pstDatosAcum[%d].szLetra         		[%s] \n"
					"pstDatosAcum[%d].lCod_Centremi      		[%ld]\n"
					"pstDatosAcum[%d].dTot_Pagar         		[%f] \n"					
					"pstDatosAcum[%d].szFec_Emision	     		[%s] \n"
					"pstDatosAcum[%d].dAcum_Netograv    		[%f] \n"
					"pstDatosAcum[%d].dAcum_Netonograv   		[%f] \n"
					"pstDatosAcum[%d].lInd_Ordentotal		[%ld]\n"
					"pstDatosAcum[%d].lInd_Anulada          	[%ld]\n"
					"pstDatosAcum[%d].lNum_Folio	        	[%ld]\n"
					"pstDatosAcum[%d].szFec_Vencimie		[%s] \n"
					"pstDatosAcum[%d].lCod_Ciclfact	      		[%ld]\n"
					"pstDatosAcum[%d].lCod_Concepto	      		[%ld]\n"  
					"pstDatosAcum[%d].szFec_Efectividad	        [%s] \n"
					"pstDatosAcum[%d].dImp_Concepto	                [%f] \n"
					"pstDatosAcum[%d].szCod_Provincia	        [%s]\n"
					"pstDatosAcum[%d].szCod_Comuna	                [%s]\n"					
					"pstDatosAcum[%d].lCod_Ciudad	                [%ld]\n"
					"pstDatosAcum[%d].dImp_Montobase	        [%f] \n"
					"pstDatosAcum[%d].lInd_Factur		        [%ld]\n"
					"pstDatosAcum[%d].dImp_Facturable	        [%f] \n"
					"pstDatosAcum[%d].szCod_Tipidtrib               [%s] \n"
					"pstDatosAcum[%d].szNum_Identtrib               [%s] \n"
					"pstDatosAcum[%d].szNom_Cliente                 [%s] \n"
					"pstDatosAcum[%d].szNom_Apeclien1               [%s] \n"
					"pstDatosAcum[%d].szNom_Apeclien2               [%s] \n"
					"pstDatosAcum[%d].szDes_Tipident                [%s] \n"
					"pstDatosAcum[%d].lCod_Zonaimpo                [%ld] \n"					
					,LOG05
					,i , pstDatosAcum[i].lNum_Secuenci      			
					,i , pstDatosAcum[i].lCod_Tipdocum      			
					,i , pstDatosAcum[i].lCod_Vendedor_Agente			
					,i , pstDatosAcum[i].szLetra         		
					,i , pstDatosAcum[i].lCod_Centremi      			
					,i , pstDatosAcum[i].dTot_Pagar         			
					,i , pstDatosAcum[i].szFec_Emision	     			
					,i , pstDatosAcum[i].dAcum_Netograv    		
					,i , pstDatosAcum[i].dAcum_Netonograv   			
					,i , pstDatosAcum[i].lInd_Ordentotal		                
					,i , pstDatosAcum[i].lInd_Anulada          	                
					,i , pstDatosAcum[i].lNum_Folio	        	
					,i , pstDatosAcum[i].szFec_Vencimie		                
					,i , pstDatosAcum[i].lCod_Ciclfact	      			
					,i , pstDatosAcum[i].lCod_Concepto	      			
					,i , pstDatosAcum[i].szFec_Efectividad	        
					,i , pstDatosAcum[i].dImp_Concepto	                        					
					,i , pstDatosAcum[i].szCod_Provincia	                        
					,i , pstDatosAcum[i].szCod_Comuna	                        
					,i , pstDatosAcum[i].lCod_Ciudad	                        
					,i , pstDatosAcum[i].dImp_Montobase	                        
					,i , pstDatosAcum[i].lInd_Factur		                
					,i , pstDatosAcum[i].dImp_Facturable	                        
					,i , pstDatosAcum[i].szCod_Tipidtrib                      
					,i , pstDatosAcum[i].szNum_Identtrib                      
					,i , pstDatosAcum[i].szNom_Cliente                        
					,i , pstDatosAcum[i].szNom_Apeclien1                      
					,i , pstDatosAcum[i].szNom_Apeclien2                      
					,i , pstDatosAcum[i].szDes_Tipident  		
					,i , pstDatosAcum[i].lCod_Zonaimpo);
        }
}/*************************** vfnPrintDatosAcum *****************************/

static int ifnOpenDatosAcum (void)
{
	int i = 0;
	long	lAnoBusqueda;
	long	lMesBusqueda;
	
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

  		char    szhCadenaPaso[4096];
  		long	lhDiaHoy;  			
  		long	lhMesHoy;
  		long	lhAnoHoy;
  		char	szhFechaIni[9];
  		char	szhFechaFin[9];
  		long	lhUltimoDiaMes;
	/* EXEC SQL END DECLARE SECTION ; */ 


	vDTrazasLog(modulo, "\n\t\t* Entro a ifnOpenDatosAcum... ciclo [%ld]\n",   LOG05, stLineaComando.lCodCiclFact);
	
	memset (szhCadenaPaso, '\0', sizeof(szhCadenaPaso));

	
/*	sprintf (szhCadenaPaso, "SELECT + ORDERED " */
/*			"A.NUM_SECUENCI         , A.COD_TIPDOCUM        		, A.COD_VENDEDOR_AGENTE 		, A.LETRA				, A.COD_CENTREMI        , "
			"A.TOT_PAGAR           			        		, TO_CHAR(A.FEC_EMISION, 'DDMMYYYY')	, A.ACUM_NETOGRAV       		, A.ACUM_NETONOGRAV    	, "
			"A.IND_ORDENTOTAL      	, A.IND_ANULADA         		, A.NUM_FOLIO				, TO_CHAR(A.FEC_VENCIMIE, 'DDMMYYYY')	, A.COD_CICLFACT       	, "
			"B.COD_CONCEPTO         , TO_CHAR(B.FEC_EFECTIVIDAD, 'DDMMYYYY'), SUM(B.IMP_CONCEPTO)                	, B.COD_PROVINCIA 			, F.COD_COMUNA          , "
			"B.COD_CIUDAD          	, SUM(B.IMP_MONTOBASE)   		, B.IND_FACTUR          		, SUM(B.IMP_FACTURABLE)              	, C.COD_TIPIDENT        , "
			"C.NUM_IDENT           	, C.NOM_CLIENTE				, NVL(C.NOM_APECLIEN1, ' ')		, NVL(C.NOM_APECLIEN2, ' ')		, D.DES_TIPIDENT        , "
			"A.COD_ZONAIMPO "
			"FROM FA_HISTDOCU A		, "
			"FA_HISTCONC_%ld B  		, "
			"GE_CLIENTES C           	, "
			"GE_TIPIDENT D           	, "
			"FA_CATEGORIACONCEPTO_TD E	, "
			"GE_DIRECCIONES F        	, "
			"GA_DIRECCLI G "
			"WHERE 	B.IND_ORDENTOTAL= A.IND_ORDENTOTAL "
			"AND A.COD_CICLFACT = %ld "
			"AND B.COD_CONCEPTO     = E.COD_CONCEPTO "
			"AND A.COD_CLIENTE      = C.COD_CLIENTE "
			"AND C.COD_TIPIDENT     = D.COD_TIPIDENT "
			"AND G.COD_CLIENTE      = C.COD_CLIENTE "
			"AND G.COD_TIPDIRECCION = 1 "
			"AND F.COD_DIRECCION    = G.COD_DIRECCION "
			"AND A.IND_ANULADA 	= 0 "				
			"GROUP BY A.NUM_SECUENCI , A.COD_TIPDOCUM        		, A.COD_VENDEDOR_AGENTE 		, A.LETRA				, A.COD_CENTREMI	, "
			"A.TOT_PAGAR        			         		, TO_CHAR(A.FEC_EMISION, 'DDMMYYYY')	, A.ACUM_NETOGRAV       		, A.ACUM_NETONOGRAV     , "
			"A.IND_ORDENTOTAL      	, A.IND_ANULADA         		, A.NUM_FOLIO				, TO_CHAR(A.FEC_VENCIMIE, 'DDMMYYYY')	, A.COD_CICLFACT        , "
			"B.COD_CONCEPTO 	, TO_CHAR(B.FEC_EFECTIVIDAD, 'DDMMYYYY'), B.COD_PROVINCIA               	, F.COD_COMUNA          		, B.COD_CIUDAD          , "
			"B.IND_FACTUR  		, C.COD_TIPIDENT        		, C.NUM_IDENT           		, C.NOM_CLIENTE				, C.NOM_APECLIEN1   	, "
			"C.NOM_APECLIEN2        , D.DES_TIPIDENT        		, A.COD_ZONAIMPO " , stLineaComando.lCodCiclFact, stLineaComando.lCodCiclFact);

*/

	sprintf (szhCadenaPaso, "SELECT /*+ ORDERED*/ "
			"A.NUM_SECUENCI				, A.COD_TIPDOCUM        		, A.COD_VENDEDOR_AGENTE 		, A.LETRA		, A.COD_CENTREMI        , "
			"A.TOT_PAGAR    			, TO_CHAR(A.FEC_EMISION, 'DDMMYYYY')	, A.ACUM_NETOGRAV       		, A.ACUM_NETONOGRAV    	, A.IND_ORDENTOTAL	, "
			"A.IND_ANULADA  			, A.NUM_FOLIO				, TO_CHAR(A.FEC_VENCIMIE, 'DDMMYYYY')	, A.COD_CICLFACT       	, B.COD_CONCEPTO        , "
			"TO_CHAR(B.FEC_EFECTIVIDAD, 'DDMMYYYY')	, SUM(B.IMP_CONCEPTO)                	, B.COD_PROVINCIA 			, F.COD_COMUNA          , B.COD_CIUDAD          , "
			"SUM(B.IMP_MONTOBASE)   		, B.IND_FACTUR          		, SUM(B.IMP_FACTURABLE)              	, C.COD_TIPIDENT        , C.NUM_IDENT           , "
			"C.NOM_CLIENTE				, NVL(C.NOM_APECLIEN1, ' ')		, NVL(C.NOM_APECLIEN2, ' ')		, D.DES_TIPIDENT        , A.COD_ZONAIMPO "
			"FROM "
			"FA_HISTCONC_%ld B  		, "
			"FA_HISTDOCU A			, "
			"GE_CLIENTES C  		, "
			"FA_CATEGORIACONCEPTO_TD E	, "
			"GA_DIRECCLI G			, "
			"GE_DIRECCIONES F        	, "
			"GE_TIPIDENT D "
			"WHERE 	B.IND_ORDENTOTAL	= A.IND_ORDENTOTAL "
			"AND B.COD_PRODUCTO		> 0 "
			"AND B.COD_CONCEPTO     	= E.COD_CONCEPTO "
			"AND A.IND_ANULADA 	   	= 0 "
			"AND A.COD_CLIENTE      	= C.COD_CLIENTE "
			"AND C.COD_CLIENTE		= G.COD_CLIENTE "
			"AND C.COD_TIPIDENT      	= D.COD_TIPIDENT "
			"AND A.COD_CICLFACT 	   	= '%ld' "
			"AND E.COD_CONCEPTO		> 0 "
			"AND E.COD_IMPUESTO 		> 0 "
			"AND G.COD_TIPDIRECCION 	= '1' "
			"AND G.COD_DIRECCION    	= F.COD_DIRECCION "
			"GROUP BY "
			"A.NUM_SECUENCI 			, A.COD_TIPDOCUM        		, A.COD_VENDEDOR_AGENTE 		, A.LETRA		, A.COD_CENTREMI	, "
			"A.TOT_PAGAR  				, TO_CHAR(A.FEC_EMISION, 'DDMMYYYY')	, A.ACUM_NETOGRAV       		, A.ACUM_NETONOGRAV     , A.IND_ORDENTOTAL      , "
			"A.IND_ANULADA         			, A.NUM_FOLIO				, TO_CHAR(A.FEC_VENCIMIE, 'DDMMYYYY')	, A.COD_CICLFACT        , B.COD_CONCEPTO 	, "
			"TO_CHAR(B.FEC_EFECTIVIDAD, 'DDMMYYYY')	, B.COD_PROVINCIA               	, F.COD_COMUNA          		, B.COD_CIUDAD          , B.IND_FACTUR  	, "
			"C.COD_TIPIDENT        			, C.NUM_IDENT           		, C.NOM_CLIENTE				, C.NOM_APECLIEN1   	, C.NOM_APECLIEN2       , "
			"D.DES_TIPIDENT        			, A.COD_ZONAIMPO " , stLineaComando.lCodCiclFact, stLineaComando.lCodCiclFact);


	vDTrazasLog(modulo, "\n\t\t* QUERY PRINCIPAL 	[%s]\n",   LOG05, szhCadenaPaso);
	
	/* EXEC SQL PREPARE sql_select_datosacum FROM :szhCadenaPaso; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 1;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCadenaPaso;
 sqlstm.sqhstl[0] = (unsigned long )4096;
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


	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* PREPARE=> Cursor_DatosAcum\n",   LOG05);
                return(SQLCODE);
    	}

	/* EXEC SQL DECLARE Cursor_DatosAcum CURSOR FOR sql_select_datosacum; */ 

	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* DECLARE=> Cursor_DatosAcum\n",   LOG05);
                return(SQLCODE);
    	}

        /* EXEC SQL OPEN Cursor_DatosAcum; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 1;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )24;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqcmod = (unsigned int )0;
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* OPEN=> Cursor_DatosAcum\n",   LOG05);
                return(SQLCODE);
    	}

    	return (SQLCODE);
}/***************************** Final ifnOpenDatosAcum  **********************/

static BOOL ifnFetchDatosAcum (REG_DATOSACUM_HOST *pstHost,long *plNumFilas)
{

         /* EXEC SQL FETCH Cursor_DatosAcum
             INTO     :pstHost->lNum_Secuenci      	
                     ,:pstHost->lCod_Tipdocum      	
                     ,:pstHost->lCod_Vendedor_Agente	
                     ,:pstHost->szLetra         	
                     ,:pstHost->lCod_Centremi      	
                     ,:pstHost->dTot_Pagar        	
                     ,:pstHost->szFec_Emision	     	
                     ,:pstHost->dAcum_Netograv    	
                     ,:pstHost->dAcum_Netonograv   	
                     ,:pstHost->lInd_Ordentotal	     	
                     ,:pstHost->lInd_Anulada          	
                     ,:pstHost->lNum_Folio	        
                     ,:pstHost->szFec_Vencimie	       	
                     ,:pstHost->lCod_Ciclfact	      	
                     ,:pstHost->lCod_Concepto	        
                     ,:pstHost->szFec_Efectividad	
                     ,:pstHost->dImp_Concepto	        
                     ,:pstHost->szCod_Provincia	        
                     ,:pstHost->szCod_Comuna	         
                     ,:pstHost->lCod_Ciudad	        
                     ,:pstHost->dImp_Montobase	        
                     ,:pstHost->lInd_Factur		
                     ,:pstHost->dImp_Facturable	        
                     ,:pstHost->szCod_Tipidtrib         
                     ,:pstHost->szNum_Identtrib         
                     ,:pstHost->szNom_Cliente           
                     ,:pstHost->szNom_Apeclien1         
                     ,:pstHost->szNom_Apeclien2         
                     ,:pstHost->szDes_Tipident  
                     ,:pstHost->lCod_Zonaimpo; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 30;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )2000;
         sqlstm.offset = (unsigned int  )39;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lNum_Secuenci);
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )sizeof(long);
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lCod_Tipdocum);
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )sizeof(long);
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCod_Vendedor_Agente);
         sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[2] = (         int  )sizeof(long);
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->szLetra);
         sqlstm.sqhstl[3] = (unsigned long )2;
         sqlstm.sqhsts[3] = (         int  )2;
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqharc[3] = (unsigned long  *)0;
         sqlstm.sqadto[3] = (unsigned short )0;
         sqlstm.sqtdso[3] = (unsigned short )0;
         sqlstm.sqhstv[4] = (unsigned char  *)(pstHost->lCod_Centremi);
         sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[4] = (         int  )sizeof(long);
         sqlstm.sqindv[4] = (         short *)0;
         sqlstm.sqinds[4] = (         int  )0;
         sqlstm.sqharm[4] = (unsigned long )0;
         sqlstm.sqharc[4] = (unsigned long  *)0;
         sqlstm.sqadto[4] = (unsigned short )0;
         sqlstm.sqtdso[4] = (unsigned short )0;
         sqlstm.sqhstv[5] = (unsigned char  *)(pstHost->dTot_Pagar);
         sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[5] = (         int  )sizeof(double);
         sqlstm.sqindv[5] = (         short *)0;
         sqlstm.sqinds[5] = (         int  )0;
         sqlstm.sqharm[5] = (unsigned long )0;
         sqlstm.sqharc[5] = (unsigned long  *)0;
         sqlstm.sqadto[5] = (unsigned short )0;
         sqlstm.sqtdso[5] = (unsigned short )0;
         sqlstm.sqhstv[6] = (unsigned char  *)(pstHost->szFec_Emision);
         sqlstm.sqhstl[6] = (unsigned long )9;
         sqlstm.sqhsts[6] = (         int  )9;
         sqlstm.sqindv[6] = (         short *)0;
         sqlstm.sqinds[6] = (         int  )0;
         sqlstm.sqharm[6] = (unsigned long )0;
         sqlstm.sqharc[6] = (unsigned long  *)0;
         sqlstm.sqadto[6] = (unsigned short )0;
         sqlstm.sqtdso[6] = (unsigned short )0;
         sqlstm.sqhstv[7] = (unsigned char  *)(pstHost->dAcum_Netograv);
         sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[7] = (         int  )sizeof(double);
         sqlstm.sqindv[7] = (         short *)0;
         sqlstm.sqinds[7] = (         int  )0;
         sqlstm.sqharm[7] = (unsigned long )0;
         sqlstm.sqharc[7] = (unsigned long  *)0;
         sqlstm.sqadto[7] = (unsigned short )0;
         sqlstm.sqtdso[7] = (unsigned short )0;
         sqlstm.sqhstv[8] = (unsigned char  *)(pstHost->dAcum_Netonograv);
         sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[8] = (         int  )sizeof(double);
         sqlstm.sqindv[8] = (         short *)0;
         sqlstm.sqinds[8] = (         int  )0;
         sqlstm.sqharm[8] = (unsigned long )0;
         sqlstm.sqharc[8] = (unsigned long  *)0;
         sqlstm.sqadto[8] = (unsigned short )0;
         sqlstm.sqtdso[8] = (unsigned short )0;
         sqlstm.sqhstv[9] = (unsigned char  *)(pstHost->lInd_Ordentotal);
         sqlstm.sqhstl[9] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[9] = (         int  )sizeof(long);
         sqlstm.sqindv[9] = (         short *)0;
         sqlstm.sqinds[9] = (         int  )0;
         sqlstm.sqharm[9] = (unsigned long )0;
         sqlstm.sqharc[9] = (unsigned long  *)0;
         sqlstm.sqadto[9] = (unsigned short )0;
         sqlstm.sqtdso[9] = (unsigned short )0;
         sqlstm.sqhstv[10] = (unsigned char  *)(pstHost->lInd_Anulada);
         sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[10] = (         int  )sizeof(long);
         sqlstm.sqindv[10] = (         short *)0;
         sqlstm.sqinds[10] = (         int  )0;
         sqlstm.sqharm[10] = (unsigned long )0;
         sqlstm.sqharc[10] = (unsigned long  *)0;
         sqlstm.sqadto[10] = (unsigned short )0;
         sqlstm.sqtdso[10] = (unsigned short )0;
         sqlstm.sqhstv[11] = (unsigned char  *)(pstHost->lNum_Folio);
         sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[11] = (         int  )sizeof(long);
         sqlstm.sqindv[11] = (         short *)0;
         sqlstm.sqinds[11] = (         int  )0;
         sqlstm.sqharm[11] = (unsigned long )0;
         sqlstm.sqharc[11] = (unsigned long  *)0;
         sqlstm.sqadto[11] = (unsigned short )0;
         sqlstm.sqtdso[11] = (unsigned short )0;
         sqlstm.sqhstv[12] = (unsigned char  *)(pstHost->szFec_Vencimie);
         sqlstm.sqhstl[12] = (unsigned long )9;
         sqlstm.sqhsts[12] = (         int  )9;
         sqlstm.sqindv[12] = (         short *)0;
         sqlstm.sqinds[12] = (         int  )0;
         sqlstm.sqharm[12] = (unsigned long )0;
         sqlstm.sqharc[12] = (unsigned long  *)0;
         sqlstm.sqadto[12] = (unsigned short )0;
         sqlstm.sqtdso[12] = (unsigned short )0;
         sqlstm.sqhstv[13] = (unsigned char  *)(pstHost->lCod_Ciclfact);
         sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[13] = (         int  )sizeof(long);
         sqlstm.sqindv[13] = (         short *)0;
         sqlstm.sqinds[13] = (         int  )0;
         sqlstm.sqharm[13] = (unsigned long )0;
         sqlstm.sqharc[13] = (unsigned long  *)0;
         sqlstm.sqadto[13] = (unsigned short )0;
         sqlstm.sqtdso[13] = (unsigned short )0;
         sqlstm.sqhstv[14] = (unsigned char  *)(pstHost->lCod_Concepto);
         sqlstm.sqhstl[14] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[14] = (         int  )sizeof(long);
         sqlstm.sqindv[14] = (         short *)0;
         sqlstm.sqinds[14] = (         int  )0;
         sqlstm.sqharm[14] = (unsigned long )0;
         sqlstm.sqharc[14] = (unsigned long  *)0;
         sqlstm.sqadto[14] = (unsigned short )0;
         sqlstm.sqtdso[14] = (unsigned short )0;
         sqlstm.sqhstv[15] = (unsigned char  *)(pstHost->szFec_Efectividad);
         sqlstm.sqhstl[15] = (unsigned long )9;
         sqlstm.sqhsts[15] = (         int  )9;
         sqlstm.sqindv[15] = (         short *)0;
         sqlstm.sqinds[15] = (         int  )0;
         sqlstm.sqharm[15] = (unsigned long )0;
         sqlstm.sqharc[15] = (unsigned long  *)0;
         sqlstm.sqadto[15] = (unsigned short )0;
         sqlstm.sqtdso[15] = (unsigned short )0;
         sqlstm.sqhstv[16] = (unsigned char  *)(pstHost->dImp_Concepto);
         sqlstm.sqhstl[16] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[16] = (         int  )sizeof(double);
         sqlstm.sqindv[16] = (         short *)0;
         sqlstm.sqinds[16] = (         int  )0;
         sqlstm.sqharm[16] = (unsigned long )0;
         sqlstm.sqharc[16] = (unsigned long  *)0;
         sqlstm.sqadto[16] = (unsigned short )0;
         sqlstm.sqtdso[16] = (unsigned short )0;
         sqlstm.sqhstv[17] = (unsigned char  *)(pstHost->szCod_Provincia);
         sqlstm.sqhstl[17] = (unsigned long )4;
         sqlstm.sqhsts[17] = (         int  )4;
         sqlstm.sqindv[17] = (         short *)0;
         sqlstm.sqinds[17] = (         int  )0;
         sqlstm.sqharm[17] = (unsigned long )0;
         sqlstm.sqharc[17] = (unsigned long  *)0;
         sqlstm.sqadto[17] = (unsigned short )0;
         sqlstm.sqtdso[17] = (unsigned short )0;
         sqlstm.sqhstv[18] = (unsigned char  *)(pstHost->szCod_Comuna);
         sqlstm.sqhstl[18] = (unsigned long )6;
         sqlstm.sqhsts[18] = (         int  )6;
         sqlstm.sqindv[18] = (         short *)0;
         sqlstm.sqinds[18] = (         int  )0;
         sqlstm.sqharm[18] = (unsigned long )0;
         sqlstm.sqharc[18] = (unsigned long  *)0;
         sqlstm.sqadto[18] = (unsigned short )0;
         sqlstm.sqtdso[18] = (unsigned short )0;
         sqlstm.sqhstv[19] = (unsigned char  *)(pstHost->lCod_Ciudad);
         sqlstm.sqhstl[19] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[19] = (         int  )sizeof(long);
         sqlstm.sqindv[19] = (         short *)0;
         sqlstm.sqinds[19] = (         int  )0;
         sqlstm.sqharm[19] = (unsigned long )0;
         sqlstm.sqharc[19] = (unsigned long  *)0;
         sqlstm.sqadto[19] = (unsigned short )0;
         sqlstm.sqtdso[19] = (unsigned short )0;
         sqlstm.sqhstv[20] = (unsigned char  *)(pstHost->dImp_Montobase);
         sqlstm.sqhstl[20] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[20] = (         int  )sizeof(double);
         sqlstm.sqindv[20] = (         short *)0;
         sqlstm.sqinds[20] = (         int  )0;
         sqlstm.sqharm[20] = (unsigned long )0;
         sqlstm.sqharc[20] = (unsigned long  *)0;
         sqlstm.sqadto[20] = (unsigned short )0;
         sqlstm.sqtdso[20] = (unsigned short )0;
         sqlstm.sqhstv[21] = (unsigned char  *)(pstHost->lInd_Factur);
         sqlstm.sqhstl[21] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[21] = (         int  )sizeof(long);
         sqlstm.sqindv[21] = (         short *)0;
         sqlstm.sqinds[21] = (         int  )0;
         sqlstm.sqharm[21] = (unsigned long )0;
         sqlstm.sqharc[21] = (unsigned long  *)0;
         sqlstm.sqadto[21] = (unsigned short )0;
         sqlstm.sqtdso[21] = (unsigned short )0;
         sqlstm.sqhstv[22] = (unsigned char  *)(pstHost->dImp_Facturable);
         sqlstm.sqhstl[22] = (unsigned long )sizeof(double);
         sqlstm.sqhsts[22] = (         int  )sizeof(double);
         sqlstm.sqindv[22] = (         short *)0;
         sqlstm.sqinds[22] = (         int  )0;
         sqlstm.sqharm[22] = (unsigned long )0;
         sqlstm.sqharc[22] = (unsigned long  *)0;
         sqlstm.sqadto[22] = (unsigned short )0;
         sqlstm.sqtdso[22] = (unsigned short )0;
         sqlstm.sqhstv[23] = (unsigned char  *)(pstHost->szCod_Tipidtrib);
         sqlstm.sqhstl[23] = (unsigned long )3;
         sqlstm.sqhsts[23] = (         int  )3;
         sqlstm.sqindv[23] = (         short *)0;
         sqlstm.sqinds[23] = (         int  )0;
         sqlstm.sqharm[23] = (unsigned long )0;
         sqlstm.sqharc[23] = (unsigned long  *)0;
         sqlstm.sqadto[23] = (unsigned short )0;
         sqlstm.sqtdso[23] = (unsigned short )0;
         sqlstm.sqhstv[24] = (unsigned char  *)(pstHost->szNum_Identtrib);
         sqlstm.sqhstl[24] = (unsigned long )21;
         sqlstm.sqhsts[24] = (         int  )21;
         sqlstm.sqindv[24] = (         short *)0;
         sqlstm.sqinds[24] = (         int  )0;
         sqlstm.sqharm[24] = (unsigned long )0;
         sqlstm.sqharc[24] = (unsigned long  *)0;
         sqlstm.sqadto[24] = (unsigned short )0;
         sqlstm.sqtdso[24] = (unsigned short )0;
         sqlstm.sqhstv[25] = (unsigned char  *)(pstHost->szNom_Cliente);
         sqlstm.sqhstl[25] = (unsigned long )51;
         sqlstm.sqhsts[25] = (         int  )51;
         sqlstm.sqindv[25] = (         short *)0;
         sqlstm.sqinds[25] = (         int  )0;
         sqlstm.sqharm[25] = (unsigned long )0;
         sqlstm.sqharc[25] = (unsigned long  *)0;
         sqlstm.sqadto[25] = (unsigned short )0;
         sqlstm.sqtdso[25] = (unsigned short )0;
         sqlstm.sqhstv[26] = (unsigned char  *)(pstHost->szNom_Apeclien1);
         sqlstm.sqhstl[26] = (unsigned long )21;
         sqlstm.sqhsts[26] = (         int  )21;
         sqlstm.sqindv[26] = (         short *)0;
         sqlstm.sqinds[26] = (         int  )0;
         sqlstm.sqharm[26] = (unsigned long )0;
         sqlstm.sqharc[26] = (unsigned long  *)0;
         sqlstm.sqadto[26] = (unsigned short )0;
         sqlstm.sqtdso[26] = (unsigned short )0;
         sqlstm.sqhstv[27] = (unsigned char  *)(pstHost->szNom_Apeclien2);
         sqlstm.sqhstl[27] = (unsigned long )21;
         sqlstm.sqhsts[27] = (         int  )21;
         sqlstm.sqindv[27] = (         short *)0;
         sqlstm.sqinds[27] = (         int  )0;
         sqlstm.sqharm[27] = (unsigned long )0;
         sqlstm.sqharc[27] = (unsigned long  *)0;
         sqlstm.sqadto[27] = (unsigned short )0;
         sqlstm.sqtdso[27] = (unsigned short )0;
         sqlstm.sqhstv[28] = (unsigned char  *)(pstHost->szDes_Tipident);
         sqlstm.sqhstl[28] = (unsigned long )21;
         sqlstm.sqhsts[28] = (         int  )21;
         sqlstm.sqindv[28] = (         short *)0;
         sqlstm.sqinds[28] = (         int  )0;
         sqlstm.sqharm[28] = (unsigned long )0;
         sqlstm.sqharc[28] = (unsigned long  *)0;
         sqlstm.sqadto[28] = (unsigned short )0;
         sqlstm.sqtdso[28] = (unsigned short )0;
         sqlstm.sqhstv[29] = (unsigned char  *)(pstHost->lCod_Zonaimpo);
         sqlstm.sqhstl[29] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[29] = (         int  )sizeof(long);
         sqlstm.sqindv[29] = (         short *)0;
         sqlstm.sqinds[29] = (         int  )0;
         sqlstm.sqharm[29] = (unsigned long )0;
         sqlstm.sqharc[29] = (unsigned long  *)0;
         sqlstm.sqadto[29] = (unsigned short )0;
         sqlstm.sqtdso[29] = (unsigned short )0;
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


	
	vDTrazasLog(modulo, "\n\t\t* FETCH=> Error [%ld]\n",   LOG05, SQLCODE);
                     
        if (SQLCODE==SQLOK)
                *plNumFilas = TAM_HOSTS_PEQ;
        else
                if (SQLCODE==SQLNOTFOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

  	return (SQLCODE);
}/***************************** Final ifnFetchDatosAcum ****************/

int ifnCloseDatosAcum (void)
{

	/* EXEC SQL CLOSE Cursor_DatosAcum; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 30;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )174;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	strcpy(modulo,"ifnCloseDatosAcum");
	vDTrazasLog(modulo, "\n\t\t* CLOSE=> Cursor_DatosAcum \n",   LOG05);

	return (SQLCODE);
}/**************************** Final ifnCloseDatosAcum ******************/


int ifnCmpDatosAcum (const void *cad1, const void *cad2)
{
   int rc = 0;
   
   return
	   ( (rc = strcmp ( ((REG_DATOSACUM *)cad1)->szNum_Identtrib,
	                    ((REG_DATOSACUM *)cad2)->szNum_Identtrib    ) )!= 0 )?rc:0;
}/*********************** Final ifnCmpDatosAcum **********************************/

int iCargaDatosAcum(REG_DATOSACUM **pstDatosAcum, int *iNumAcum)
{
        int     rc = 0;
        long    lNumFilas;
        static  REG_DATOSACUM_HOST pstDatosAcumHost;
        REG_DATOSACUM *pstDatosAcumTemp;
        long lCont;

        strcpy(modulo,"iCargaDatosAcum");
        vDTrazasLog(modulo, "\n\t\t* Carga Estructura de Acumuladores\n",   LOG05);

        *iNumAcum = 0;
        *pstDatosAcum = NULL;

        if (ifnOpenDatosAcum ())
        {
		vDTrazasLog(modulo, "\n\t\t* Fallo la ejecucion del ifnOpenDatosAcum\n",   LOG05);
        	return (FALSE);
        }
	
	vDTrazasLog(modulo, "\n\t\t* Antes del while (rc != SQLNOTFOUND) \n",   LOG05);
        
        while (rc != SQLNOTFOUND)
        {
        rc = ifnFetchDatosAcum (&pstDatosAcumHost,&lNumFilas);
        if (rc != SQLOK  && rc != SQLNOTFOUND)
        {
        	vDTrazasLog(modulo, "\n\t\t* Fallo la ejecucion del ifnFetchDatosAcum\n",   LOG05);
		return (FALSE);
	}

                if (!lNumFilas)
                	break;

                *pstDatosAcum =(REG_DATOSACUM*) realloc(*pstDatosAcum,(((*iNumAcum)+lNumFilas)*sizeof(REG_DATOSACUM)));

                if (!*pstDatosAcum)
                        return (FALSE);

                pstDatosAcumTemp = &(*pstDatosAcum)[(*iNumAcum)];
                memset(pstDatosAcumTemp, 0, sizeof(REG_DATOSACUM)*lNumFilas);
                for (lCont = 0 ; lCont < lNumFilas ; lCont++)
                {
                	pstDatosAcumTemp[lCont].lNum_Secuenci      	=	pstDatosAcumHost.lNum_Secuenci      	[lCont];
                	pstDatosAcumTemp[lCont].lCod_Tipdocum      	=	pstDatosAcumHost.lCod_Tipdocum      	[lCont];
                	pstDatosAcumTemp[lCont].lCod_Vendedor_Agente	=	pstDatosAcumHost.lCod_Vendedor_Agente	[lCont];                	
                	trim(pstDatosAcumHost.szLetra         	[lCont]	, 	pstDatosAcumTemp[lCont].szLetra         	);                	
                	pstDatosAcumTemp[lCont].lCod_Centremi      	=	pstDatosAcumHost.lCod_Centremi      	[lCont];
                	pstDatosAcumTemp[lCont].dTot_Pagar         	=	pstDatosAcumHost.dTot_Pagar         	[lCont];
                	                	
                	trim(pstDatosAcumHost.szFec_Emision    	[lCont]	, 	pstDatosAcumTemp[lCont].szFec_Emision	     	);                	
                	pstDatosAcumTemp[lCont].dAcum_Netograv    	=	pstDatosAcumHost.dAcum_Netograv    	[lCont];
                	pstDatosAcumTemp[lCont].dAcum_Netonograv   	=	pstDatosAcumHost.dAcum_Netonograv   	[lCont];
                	pstDatosAcumTemp[lCont].lInd_Ordentotal	     	=	pstDatosAcumHost.lInd_Ordentotal	[lCont];
                	pstDatosAcumTemp[lCont].lInd_Anulada          	=	pstDatosAcumHost.lInd_Anulada          	[lCont];
                	pstDatosAcumTemp[lCont].lNum_Folio	        =	pstDatosAcumHost.lNum_Folio	        [lCont];                  	
                	trim(pstDatosAcumHost.szFec_Vencimie	[lCont]	, 	pstDatosAcumTemp[lCont].szFec_Vencimie		);                	
                	pstDatosAcumTemp[lCont].lCod_Ciclfact	      	=       pstDatosAcumHost.lCod_Ciclfact	      	[lCont];
                	pstDatosAcumTemp[lCont].lCod_Concepto	        =       pstDatosAcumHost.lCod_Concepto	        [lCont];                	
                	trim(pstDatosAcumHost.szFec_Efectividad	[lCont]	, 	pstDatosAcumTemp[lCont].szFec_Efectividad	);                	
                	pstDatosAcumTemp[lCont].dImp_Concepto	        =       pstDatosAcumHost.dImp_Concepto	        [lCont];
                	trim(pstDatosAcumHost.szCod_Provincia	        [lCont], pstDatosAcumTemp[lCont].szCod_Provincia	        );
                	trim(pstDatosAcumHost.szCod_Comuna	        [lCont], pstDatosAcumTemp[lCont].szCod_Comuna	        	);
                	pstDatosAcumTemp[lCont].lCod_Ciudad	        =       pstDatosAcumHost.lCod_Ciudad	        [lCont];
                	pstDatosAcumTemp[lCont].dImp_Montobase	        =       pstDatosAcumHost.dImp_Montobase	        [lCont];
                	pstDatosAcumTemp[lCont].lInd_Factur		=       pstDatosAcumHost.lInd_Factur		[lCont];
                	pstDatosAcumTemp[lCont].dImp_Facturable	        =       pstDatosAcumHost.dImp_Facturable	[lCont];
                	trim(pstDatosAcumHost.szCod_Tipidtrib	[lCont]	, 	pstDatosAcumTemp[lCont].szCod_Tipidtrib  	); 
                	trim(pstDatosAcumHost.szNum_Identtrib	[lCont]	, 	pstDatosAcumTemp[lCont].szNum_Identtrib  	);
                	trim(pstDatosAcumHost.szNom_Cliente  	[lCont]	, 	pstDatosAcumTemp[lCont].szNom_Cliente    	);
                	trim(pstDatosAcumHost.szNom_Apeclien1	[lCont]	, 	pstDatosAcumTemp[lCont].szNom_Apeclien1  	);
                	trim(pstDatosAcumHost.szNom_Apeclien2	[lCont]	, 	pstDatosAcumTemp[lCont].szNom_Apeclien2  	);
                	trim(pstDatosAcumHost.szDes_Tipident 	[lCont]	, 	pstDatosAcumTemp[lCont].szDes_Tipident   	);
                	pstDatosAcumTemp[lCont].lCod_Zonaimpo	        =       pstDatosAcumHost.lCod_Zonaimpo	[lCont];
                	
                	
		}
                (*iNumAcum) += lNumFilas;

        }/* fin while */

        vDTrazasLog(modulo,  "\n\t\t* Cantidad de Acumladores cargados [%d]\n",   LOG05, *iNumAcum);

        rc = ifnCloseDatosAcum();
        if (rc != SQLOK)
                return (FALSE);

	if (*iNumAcum == 0)
	{
		vDTrazasLog(modulo,  "\n\t\t* No existe data que cargar. Proceso Finalizado.\n",   LOG05);
		exit(0);
	}	

	
        return (TRUE);
}

/* --------Estructura DatosAcum Hasta Aqui */


BOOL bfnCargaEstructuras()
{

char modulo[]="bfnCargaEstructuras";
BOOL bExiste = TRUE;
int   i;
int   iContLeidos = 0;
int   iContTotal  = 0;

	if(!iCargaDatosAcum(&pstDatosAcum.stDatosAcum, &pstDatosAcum.iCantDatosAcum)!= SQLOK)
	{
		strcpy(modulo, "bfnCargaEstructuras");
		vDTrazasLog(modulo, "Error al Cargar los datos de acumulacion. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}
	
	qsort((void *) pstDatosAcum.stDatosAcum, pstDatosAcum.iCantDatosAcum, sizeof(REG_DATOSACUM), ifnCmpDatosAcum);
	
	vDTrazasLog(modulo,  "\n\t\t* MISMA ESTRUCTURA PERO ORDENADA POR CLIENTE \n",   LOG05);
	vfnPrintDatosAcum (pstDatosAcum.stDatosAcum, pstDatosAcum.iCantDatosAcum);
	
	return (TRUE);
}

BOOL iCargaTablasFacturacion()
{
	int i;
	/*long	lCod_ClienteAux; */
	char	szNumIdentAux[21];
		
	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long	lhNum_Secuenci      		        ;		
		long	lhCod_Tipdocum      		        ;
		long	lhCod_Vendedor_Agente		        ;
		char	szhLetra         		[1  + 1];
		long	lhCod_Centremi      		        ;
		double	dhTot_Pagar         		        ;
		long	lhCod_Cliente			        ;
		char	szhFec_Emision	     		[8  + 1];
		double	dhAcum_Netograv    		        ;
		double	dhAcum_Netonograv   		        ;
		long	lhInd_Ordentotal	     		;
		long	lhInd_Anulada          		        ;
		long	lhNum_Folio	        	        ;
		char	szhFec_Vencimie	       		[8  + 1];
		long	lhCod_Ciclfact	      		        ;
		long	lhCod_Concepto	        	        ;
		char	szhFec_Efectividad		[8  + 1];
		double	dhImp_Concepto	        	        ;		
		char	szhCod_Provincia	        [3  + 1];		
		char	szhCod_Comuna			[5  + 1];
		long	lhCod_Ciudad	        	        ;
		double	dhImp_Montobase	        	        ;
		long	lhInd_Factur			        ;
		double	dhImp_Facturable			;
		char	szhCod_Tipidtrib         	[2  + 1];
		char	szhNum_Identtrib         	[20 + 1];
		char	szhNom_Cliente           	[50 + 1];
		char	szhNom_Apeclien1         	[20 + 1];
		char	szhNom_Apeclien2         	[20 + 1];
		char	szhDes_Tipident          	[20 + 1];    
		
		char	szhCod_Impuesto			[5  + 1];
		char	szhDes_Impuesto			[20 + 1];
		double	dhAcumIva 				; 
		double	dhAcumIce 				; 
		long	lhCod_Zonaimpo				;
		long	lhAcumNCredito				;
		long	lhAcumNDebito                           ;  
		long	lhAcumDocumentos			;
		
		double	dhTot_MtoGrav                           ;
		double	dhTot_MtoExe                            ;
		double	dhTot_MtoIva                            ;
		double	dhTot_MtoIce				;
		
		int 	ihCantidadRegs				;
		
	/* EXEC SQL END DECLARE SECTION; */ 

	
	lhAcumNCredito  = 0;
	lhAcumNDebito	= 0;
	lhAcumDocumentos= 0;
	
	dhTot_MtoGrav   = 0.0;
	dhTot_MtoExe    = 0.0;
	dhTot_MtoIva    = 0.0;
	dhTot_MtoIce	= 0.0;
        
        dhAcumIva 	= 0.0;
        dhAcumIce       = 0.0;
        
        /*lCod_ClienteAux = pstDatosAcum.stDatosAcum[0].lCod_Cliente;*/
        trim (pstDatosAcum.stDatosAcum[0].szNum_Identtrib, szNumIdentAux);
        
        
	strcpy(szhNum_Identtrib,  pstDatosAcum.stDatosAcum[0].szNum_Identtrib);
	strcpy(szhCod_Tipidtrib,  pstDatosAcum.stDatosAcum[0].szCod_Tipidtrib);
        
        
        /* EXEC SQL SELECT COUNT(1)
		INTO :ihCantidadRegs
		FROM 	FA_RESUMEN_MONTOSIMP_TO 
		WHERE 	NUM_IDENTIFICACION = :szhNum_Identtrib
		AND 	COD_TIPIDENT = :szhCod_Tipidtrib; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "select count(1) into :b0  from FA_RESUMEN_MONTOSIMP_T\
O where (NUM_IDENTIFICACION=:b1 and COD_TIPIDENT=:b2)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )189;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCantidadRegs;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Identtrib;
        sqlstm.sqhstl[1] = (unsigned long )21;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Tipidtrib;
        sqlstm.sqhstl[2] = (unsigned long )3;
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


        
        if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
	{
		vDTrazasLog(modulo, "Error En SELECT COUNT(1) en FA_RESUMEN_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
		return (FALSE);
	}
	
	if (ihCantidadRegs == 0)
        {
        
		/* EXEC SQL INSERT INTO FA_RESUMEN_MONTOSIMP_TO 
	        			(NUM_IDENTIFICACION, COD_TIPIDENT, ULT_FECHA_PERIODO,
					TOT_MONTOGRAV, TOT_MONTOEXE, TOT_MONTOIVA, TOT_MONTOICE, 
					CANT_DOCVTAEMI, CANT_NCEMI, CANT_NDEMI, TOT_MONTOICEIMP)
				VALUES	(:szhNum_Identtrib	, :szhCod_Tipidtrib , to_date('01012001','DDMMYYYY'),
					0,0,0,0,
					0,0,0,0); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 30;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into FA_RESUMEN_MONTOSIMP_TO (NUM_IDENTIFICACION,COD\
_TIPIDENT,ULT_FECHA_PERIODO,TOT_MONTOGRAV,TOT_MONTOEXE,TOT_MONTOIVA,TOT_MONTOI\
CE,CANT_DOCVTAEMI,CANT_NCEMI,CANT_NDEMI,TOT_MONTOICEIMP) values (:b0,:b1,to_da\
te('01012001','DDMMYYYY'),0,0,0,0,0,0,0,0)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )216;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Identtrib;
  sqlstm.sqhstl[0] = (unsigned long )21;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Tipidtrib;
  sqlstm.sqhstl[1] = (unsigned long )3;
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


	        
		if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
		{
			vDTrazasLog(modulo, "Error En INSERT a la FA_RESUMEN_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
			return (FALSE);
		}
	}

        
	for (i=0;i < pstDatosAcum.iCantDatosAcum; i++)
	{
		if(strcmp(szNumIdentAux, pstDatosAcum.stDatosAcum[i].szNum_Identtrib) == 0)
		/*if (lCod_ClienteAux == pstDatosAcum.stDatosAcum[i].lCod_Cliente) */
		{
			lhNum_Secuenci      		= pstDatosAcum.stDatosAcum[i].lNum_Secuenci      	; 	/*	-       */
			lhCod_Tipdocum      		= pstDatosAcum.stDatosAcum[i].lCod_Tipdocum      	;       /*	A - D   */
			lhCod_Vendedor_Agente		= pstDatosAcum.stDatosAcum[i].lCod_Vendedor_Agente	;       /*	-       */
			strcpy(szhLetra        		, pstDatosAcum.stDatosAcum[i].szLetra         		);      /*	-       */
			lhCod_Centremi      		= pstDatosAcum.stDatosAcum[i].lCod_Centremi      	;       /*	-       */
			dhTot_Pagar         		= pstDatosAcum.stDatosAcum[i].dTot_Pagar         	;       /*	D       */			
			strcpy(szhFec_Emision	     	, pstDatosAcum.stDatosAcum[i].szFec_Emision	     	);      /*	D       */
			dhAcum_Netograv    		= pstDatosAcum.stDatosAcum[i].dAcum_Netograv    	;       /*	D       */
			dhAcum_Netonograv   		= pstDatosAcum.stDatosAcum[i].dAcum_Netonograv   	;       /*	D       */
			lhInd_Ordentotal	     	= pstDatosAcum.stDatosAcum[i].lInd_Ordentotal	     	;       /*	D       */
			lhInd_Anulada          		= pstDatosAcum.stDatosAcum[i].lInd_Anulada          	;       /*	-       */
			lhNum_Folio	        	= pstDatosAcum.stDatosAcum[i].lNum_Folio	        ;       /*	-       */
			strcpy(szhFec_Vencimie	   	, pstDatosAcum.stDatosAcum[i].szFec_Vencimie	       	);      /*	-       */
			lhCod_Ciclfact	      		= pstDatosAcum.stDatosAcum[i].lCod_Ciclfact	      	;       /*	-       */
			lhCod_Concepto	        	= pstDatosAcum.stDatosAcum[i].lCod_Concepto	        ;       /*	D       */
			strcpy(szhFec_Efectividad	, pstDatosAcum.stDatosAcum[i].szFec_Efectividad		);      /*	-       */
			dhImp_Concepto	        	= pstDatosAcum.stDatosAcum[i].dImp_Concepto	        ;       /*	-       */
			strcpy(szhCod_Provincia	        , pstDatosAcum.stDatosAcum[i].szCod_Provincia	        );       /*	A       */
			strcpy(szhCod_Comuna	        , pstDatosAcum.stDatosAcum[i].szCod_Comuna	        );       /*	-       */		
			lhCod_Ciudad	        	= pstDatosAcum.stDatosAcum[i].lCod_Ciudad	        ;       /*	-       */
			dhImp_Montobase	        	= pstDatosAcum.stDatosAcum[i].dImp_Montobase	        ;       /*	-       */
			lhInd_Factur			= pstDatosAcum.stDatosAcum[i].lInd_Factur		;       /*	-       */
			dhImp_Facturable		= pstDatosAcum.stDatosAcum[i].dImp_Facturable	      	;       /*	-       */
			strcpy(szhCod_Tipidtrib         , pstDatosAcum.stDatosAcum[i].szCod_Tipidtrib         	);      /*	A - D   */
			strcpy(szhNum_Identtrib         , pstDatosAcum.stDatosAcum[i].szNum_Identtrib         	);      /*	A - D   */
			strcpy(szhNom_Cliente           , pstDatosAcum.stDatosAcum[i].szNom_Cliente           	);      /*	A       */
			strcpy(szhNom_Apeclien1         , pstDatosAcum.stDatosAcum[i].szNom_Apeclien1         	);      /*	A       */
			strcpy(szhNom_Apeclien2         , pstDatosAcum.stDatosAcum[i].szNom_Apeclien2         	);      /*	A       */
			strcpy(szhDes_Tipident          , pstDatosAcum.stDatosAcum[i].szDes_Tipident          	);      /*	-	*/
			lhCod_Zonaimpo			= pstDatosAcum.stDatosAcum[i].lCod_Zonaimpo	      	;       /*	-       */
			
	
			/* EXEC SQL SELECT A.DES_IMPUESTO, A.COD_IMPUESTO
				INTO :szhDes_Impuesto, szhCod_Impuesto
				FROM FA_CATEGORIA_IMPUESTO_TD A, FA_CATEGORIACONCEPTO_TD B
				WHERE B.COD_CONCEPTO = :lhCod_Concepto
				AND B.COD_IMPUESTO = A.COD_IMPUESTO 
				AND B.VIGENTE = 'S'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 30;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.DES_IMPUESTO ,A.COD_IMPUESTO into :b0,:b1  from F\
A_CATEGORIA_IMPUESTO_TD A ,FA_CATEGORIACONCEPTO_TD B where ((B.COD_CONCEPTO=:b\
2 and B.COD_IMPUESTO=A.COD_IMPUESTO) and B.VIGENTE='S')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )239;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhDes_Impuesto;
   sqlstm.sqhstl[0] = (unsigned long )21;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Impuesto;
   sqlstm.sqhstl[1] = (unsigned long )6;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Concepto;
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


			
			if(SQLCODE!=SQLOK)
			{
				vDTrazasLog(modulo, "Error En SELECT de Impuestos en FA_CATEGORIA_IMPUESTO_TD. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
				return (FALSE);
			}				
			
			trim (szhDes_Impuesto, szhDes_Impuesto);
			trim (szhCod_Impuesto, szhCod_Impuesto);
			
			if (strcmp(szhDes_Impuesto, "IVA")==0)
				dhAcumIva = dhImp_Concepto;
			else if (strcmp(szhDes_Impuesto, "ICE")==0)
				dhAcumIce = dhImp_Concepto;
				
			
			if (lhCod_Tipdocum == 25) 	/* COD_TIPDOCUM = 25 --> NOTA CREDITO  */
			{
				lhAcumNCredito++;
			}
			else if (lhCod_Tipdocum == 26) /* COD_TIPDOCUM = 26 --> NOTA DEBITO  */
			{
				lhAcumNDebito++;
			}
			else				 /* CUALQUIER OTRO COD_TIPDOCUM */
			{
				lhAcumDocumentos++;
			}
			
			
			dhTot_MtoGrav   += dhAcum_Netograv	;
			dhTot_MtoExe    += dhAcum_Netonograv	;
			dhTot_MtoIva    += dhAcumIva		;
			dhTot_MtoIce	+= dhAcumIce		;
			
			
			vDTrazasLog(modulo, "\t	Valores del Insert... \n",   LOG05);
			
			vDTrazasLog(modulo, "\t	szhNum_Identtrib[%s] \n",   LOG05, szhNum_Identtrib);
			vDTrazasLog(modulo, "\t	szhCod_Tipidtrib[%s] \n",   LOG05, szhCod_Tipidtrib);
			vDTrazasLog(modulo, "\t	lhInd_Ordentotal[%ld]\n",   LOG05, lhInd_Ordentotal);
			vDTrazasLog(modulo, "\t	lhCod_Cliente	[%ld]\n",   LOG05, lhCod_Cliente);
							
	                        
			/* EXEC SQL
	                INSERT INTO FA_DETALLE_MONTOSIMP_TO(
	                	NUM_IDENTIFICACION	, 
	                	COD_TIPIDENT		, 
	                	ULT_FECHA_PERIODO	, 
				IND_ORDENTOTAL		, 
				COD_CONCEPTO		, 
				COD_IMPUESTO		, 
				FEC_EMISION		,
				TOT_PAGAR		,
				ACUM_NETOGRAV		, 
				ACUM_NETONOGRAV		,
				ACUM_IVA		, 
				COD_ZONAIMPO		,
				COD_TIPDOCUM		,
				ACUM_ICE) 
	                VALUES                          (
	                        :szhNum_Identtrib 	, 
	                        :szhCod_Tipidtrib	, 
	                        to_date('01012001', 'DDMMYYYY')		,                  
				:lhInd_Ordentotal	, 
				:lhCod_Concepto       , 
				:szhCod_Impuesto	, 
				to_date(:szhFec_Emision, 'DDMMYYYY')	,
				:dhTot_Pagar		,
				:dhAcum_Netograv	,
				:dhAcum_Netonograv	, 
				:dhAcumIva		, 
				:lhCod_Zonaimpo		, 
				:lhCod_Tipdocum		,
				:dhAcumIce	       ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 30;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into FA_DETALLE_MONTOSIMP_TO (NUM_IDENTIFICACION,CO\
D_TIPIDENT,ULT_FECHA_PERIODO,IND_ORDENTOTAL,COD_CONCEPTO,COD_IMPUESTO,FEC_EMIS\
ION,TOT_PAGAR,ACUM_NETOGRAV,ACUM_NETONOGRAV,ACUM_IVA,COD_ZONAIMPO,COD_TIPDOCUM\
,ACUM_ICE) values (:b0,:b1,to_date('01012001','DDMMYYYY'),:b2,:b3,:b4,to_date(\
:b5,'DDMMYYYY'),:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )266;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Identtrib;
   sqlstm.sqhstl[0] = (unsigned long )21;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Tipidtrib;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhInd_Ordentotal;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_Concepto;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Impuesto;
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFec_Emision;
   sqlstm.sqhstl[5] = (unsigned long )9;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&dhTot_Pagar;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&dhAcum_Netograv;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&dhAcum_Netonograv;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&dhAcumIva;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&lhCod_Zonaimpo;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&lhCod_Tipdocum;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&dhAcumIce;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
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

  
	
	
	
	            	if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
			{
				vDTrazasLog(modulo, "Error En INSERT a la FA_DETALLE_MONTOSIMP_TO. CORREGIDO ... Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
	                	return (FALSE);
	            	}
	            	
	            	
	            	
		}
		else
		{
			
			
			
			
			/* EXEC SQL UPDATE FA_RESUMEN_MONTOSIMP_TO SET 					
					TIPO_DOCUMENTO		= :lhCod_Tipdocum, 
					TOT_MONTOGRAV		= TOT_MONTOGRAV		+ :dhTot_MtoGrav, 
					TOT_MONTOEXE		= TOT_MONTOEXE		+ :dhTot_MtoExe	, 
					TOT_MONTOIVA		= TOT_MONTOIVA		+ :dhTot_MtoIva, 
					TOT_MONTOICE		= TOT_MONTOICE		+ :dhTot_MtoIce, 
					CANT_DOCVTAEMI		= CANT_DOCVTAEMI	+ :lhAcumDocumentos, 
					CANT_NCEMI		= CANT_NCEMI		+ :lhAcumNCredito, 
					CANT_NDEMI		= CANT_NDEMI		+ :lhAcumNDebito, 
					COD_PROVINCIA		= :szhCod_Provincia, 
					COD_CANTON		= :szhCod_Comuna, 
					NOM_CLIENTE		= :szhNom_Cliente , 
					NOM_APECLIEN1		= :szhNom_Apeclien1, 
					NOM_APECLIEN2		= :szhNom_Apeclien2, 
					CERRADO 		= 'N'
				WHERE NUM_IDENTIFICACION = :szhNum_Identtrib
				AND COD_TIPIDENT = :szhCod_Tipidtrib; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 30;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_RESUMEN_MONTOSIMP_TO  set TIPO_DOCUMENTO=:b0,TOT\
_MONTOGRAV=(TOT_MONTOGRAV+:b1),TOT_MONTOEXE=(TOT_MONTOEXE+:b2),TOT_MONTOIVA=(T\
OT_MONTOIVA+:b3),TOT_MONTOICE=(TOT_MONTOICE+:b4),CANT_DOCVTAEMI=(CANT_DOCVTAEM\
I+:b5),CANT_NCEMI=(CANT_NCEMI+:b6),CANT_NDEMI=(CANT_NDEMI+:b7),COD_PROVINCIA=:\
b8,COD_CANTON=:b9,NOM_CLIENTE=:b10,NOM_APECLIEN1=:b11,NOM_APECLIEN2=:b12,CERRA\
DO='N' where (NUM_IDENTIFICACION=:b13 and COD_TIPIDENT=:b14)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )333;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_Tipdocum;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)&dhTot_MtoGrav;
   sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&dhTot_MtoExe;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&dhTot_MtoIva;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)&dhTot_MtoIce;
   sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)&lhAcumDocumentos;
   sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&lhAcumNCredito;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&lhAcumNDebito;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)szhCod_Provincia;
   sqlstm.sqhstl[8] = (unsigned long )4;
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)szhCod_Comuna;
   sqlstm.sqhstl[9] = (unsigned long )6;
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhNom_Cliente;
   sqlstm.sqhstl[10] = (unsigned long )51;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhNom_Apeclien1;
   sqlstm.sqhstl[11] = (unsigned long )21;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhNom_Apeclien2;
   sqlstm.sqhstl[12] = (unsigned long )21;
   sqlstm.sqhsts[12] = (         int  )0;
   sqlstm.sqindv[12] = (         short *)0;
   sqlstm.sqinds[12] = (         int  )0;
   sqlstm.sqharm[12] = (unsigned long )0;
   sqlstm.sqadto[12] = (unsigned short )0;
   sqlstm.sqtdso[12] = (unsigned short )0;
   sqlstm.sqhstv[13] = (unsigned char  *)szhNum_Identtrib;
   sqlstm.sqhstl[13] = (unsigned long )21;
   sqlstm.sqhsts[13] = (         int  )0;
   sqlstm.sqindv[13] = (         short *)0;
   sqlstm.sqinds[13] = (         int  )0;
   sqlstm.sqharm[13] = (unsigned long )0;
   sqlstm.sqadto[13] = (unsigned short )0;
   sqlstm.sqtdso[13] = (unsigned short )0;
   sqlstm.sqhstv[14] = (unsigned char  *)szhCod_Tipidtrib;
   sqlstm.sqhstl[14] = (unsigned long )3;
   sqlstm.sqhsts[14] = (         int  )0;
   sqlstm.sqindv[14] = (         short *)0;
   sqlstm.sqinds[14] = (         int  )0;
   sqlstm.sqharm[14] = (unsigned long )0;
   sqlstm.sqadto[14] = (unsigned short )0;
   sqlstm.sqtdso[14] = (unsigned short )0;
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


			
			
			
			if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
			{
				vDTrazasLog(modulo, "Error En UPDATE a la FA_RESUMEN_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
	                	return (FALSE);
	            	}

			lhAcumNCredito		= 0	;
			lhAcumNDebito		= 0	;
			lhAcumDocumentos	= 0	;
			dhTot_MtoGrav   	= 0.0	;
			dhTot_MtoExe    	= 0.0	;
			dhTot_MtoIva    	= 0.0	;
			dhTot_MtoIce		= 0.0	;
			dhAcumIva		= 0.0	;
                        dhAcumIce               = 0.0	;

			lhNum_Secuenci      		= pstDatosAcum.stDatosAcum[i].lNum_Secuenci      	; 	/*	-       */
			lhCod_Tipdocum      		= pstDatosAcum.stDatosAcum[i].lCod_Tipdocum      	;       /*	A - D   */
			lhCod_Vendedor_Agente		= pstDatosAcum.stDatosAcum[i].lCod_Vendedor_Agente	;       /*	-       */
			strcpy(szhLetra        		, pstDatosAcum.stDatosAcum[i].szLetra         		);      /*	-       */
			lhCod_Centremi      		= pstDatosAcum.stDatosAcum[i].lCod_Centremi      	;       /*	-       */
			dhTot_Pagar         		= pstDatosAcum.stDatosAcum[i].dTot_Pagar         	;       /*	D       */
			
			strcpy(szhFec_Emision	     	, pstDatosAcum.stDatosAcum[i].szFec_Emision	     	);      /*	D       */
			dhAcum_Netograv    		= pstDatosAcum.stDatosAcum[i].dAcum_Netograv    	;       /*	D       */
			dhAcum_Netonograv   		= pstDatosAcum.stDatosAcum[i].dAcum_Netonograv   	;       /*	D       */
			lhInd_Ordentotal	     	= pstDatosAcum.stDatosAcum[i].lInd_Ordentotal	     	;       /*	D       */
			lhInd_Anulada          		= pstDatosAcum.stDatosAcum[i].lInd_Anulada          	;       /*	-       */
			lhNum_Folio	        	= pstDatosAcum.stDatosAcum[i].lNum_Folio	        ;       /*	-       */
			strcpy(szhFec_Vencimie	   	, pstDatosAcum.stDatosAcum[i].szFec_Vencimie	       	);      /*	-       */
			lhCod_Ciclfact	      		= pstDatosAcum.stDatosAcum[i].lCod_Ciclfact	      	;      
			lhCod_Concepto	        	= pstDatosAcum.stDatosAcum[i].lCod_Concepto	        ;       /*	D       */
			strcpy(szhFec_Efectividad	, pstDatosAcum.stDatosAcum[i].szFec_Efectividad		);      /*	-       */
			dhImp_Concepto	        	= pstDatosAcum.stDatosAcum[i].dImp_Concepto	        ;       /*	-       */
			strcpy(szhCod_Provincia	        , pstDatosAcum.stDatosAcum[i].szCod_Provincia	        );       /*	A       */
			strcpy(szhCod_Comuna	        , pstDatosAcum.stDatosAcum[i].szCod_Comuna	        );       /*	-       */		
			lhCod_Ciudad	        	= pstDatosAcum.stDatosAcum[i].lCod_Ciudad	        ;       /*	-       */
			dhImp_Montobase	        	= pstDatosAcum.stDatosAcum[i].dImp_Montobase	        ;       /*	-       */
			lhInd_Factur			= pstDatosAcum.stDatosAcum[i].lInd_Factur		;       /*	-       */
			dhImp_Facturable		= pstDatosAcum.stDatosAcum[i].dImp_Facturable	      	;       /*	-       */
			strcpy(szhCod_Tipidtrib         , pstDatosAcum.stDatosAcum[i].szCod_Tipidtrib         	);      /*	A - D   */
			strcpy(szhNum_Identtrib         , pstDatosAcum.stDatosAcum[i].szNum_Identtrib         	);      /*	A - D   */
			strcpy(szhNom_Cliente           , pstDatosAcum.stDatosAcum[i].szNom_Cliente           	);      /*	A       */
			strcpy(szhNom_Apeclien1         , pstDatosAcum.stDatosAcum[i].szNom_Apeclien1         	);      /*	A       */
			strcpy(szhNom_Apeclien2         , pstDatosAcum.stDatosAcum[i].szNom_Apeclien2         	);      /*	A       */
			strcpy(szhDes_Tipident          , pstDatosAcum.stDatosAcum[i].szDes_Tipident          	);      /*	-	*/
			lhCod_Zonaimpo			= pstDatosAcum.stDatosAcum[i].lCod_Zonaimpo	      	;       /*	-       */
			
	
			/* EXEC SQL SELECT A.DES_IMPUESTO, A.COD_IMPUESTO
				INTO :szhDes_Impuesto, szhCod_Impuesto
				FROM FA_CATEGORIA_IMPUESTO_TD A, FA_CATEGORIACONCEPTO_TD B
				WHERE B.COD_CONCEPTO = :lhCod_Concepto
				AND B.COD_IMPUESTO = A.COD_IMPUESTO 
				AND B.VIGENTE = 'S'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 30;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select A.DES_IMPUESTO ,A.COD_IMPUESTO into :b0,:b1  from F\
A_CATEGORIA_IMPUESTO_TD A ,FA_CATEGORIACONCEPTO_TD B where ((B.COD_CONCEPTO=:b\
2 and B.COD_IMPUESTO=A.COD_IMPUESTO) and B.VIGENTE='S')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )408;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhDes_Impuesto;
   sqlstm.sqhstl[0] = (unsigned long )21;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Impuesto;
   sqlstm.sqhstl[1] = (unsigned long )6;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCod_Concepto;
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


			
			if(SQLCODE!=SQLOK)
			{
				vDTrazasLog(modulo, "Error En SELECT de Impuestos en FA_CATEGORIA_IMPUESTO_TD. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
				return (FALSE);
			}	
			
			trim (szhCod_Impuesto, szhCod_Impuesto);
			trim (szhDes_Impuesto, szhDes_Impuesto);
			
			if (strcmp(szhDes_Impuesto, "IVA")==0)
				dhAcumIva = dhImp_Concepto;
			else if (strcmp(szhDes_Impuesto, "ICE")==0)
				dhAcumIce = dhImp_Concepto;
				
			
			if (lhCod_Tipdocum == 25) 	/* COD_TIPDOCUM = 25 --> NOTA CREDITO  */
			{
				lhAcumNCredito++;
			}
			else if (lhCod_Tipdocum == 26) /* COD_TIPDOCUM = 26 --> NOTA DEBITO  */
			{
				lhAcumNDebito++;
			}
			else				 /* CUALQUIER OTRO COD_TIPDOCUM */
			{
				lhAcumDocumentos++;
			}
			
			
			dhTot_MtoGrav   += dhAcum_Netograv	;
			dhTot_MtoExe    += dhAcum_Netonograv	;
			dhTot_MtoIva    += dhAcumIva		;
			dhTot_MtoIce	+= dhAcumIce		;
			
			
			
			strcpy(szhNum_Identtrib,  pstDatosAcum.stDatosAcum[i].szNum_Identtrib);
       			strcpy(szhCod_Tipidtrib,  pstDatosAcum.stDatosAcum[i].szCod_Tipidtrib);
        
        
        
        		/* EXEC SQL SELECT COUNT(1)
        			INTO :ihCantidadRegs
        			FROM 	FA_RESUMEN_MONTOSIMP_TO 
        			WHERE 	NUM_IDENTIFICACION = :szhNum_Identtrib
        			AND 	COD_TIPIDENT = :szhCod_Tipidtrib; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 30;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "select count(1) into :b0  from FA_RESUMEN_MONTOSIMP\
_TO where (NUM_IDENTIFICACION=:b1 and COD_TIPIDENT=:b2)";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )435;
          sqlstm.selerr = (unsigned short)1;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&ihCantidadRegs;
          sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)szhNum_Identtrib;
          sqlstm.sqhstl[1] = (unsigned long )21;
          sqlstm.sqhsts[1] = (         int  )0;
          sqlstm.sqindv[1] = (         short *)0;
          sqlstm.sqinds[1] = (         int  )0;
          sqlstm.sqharm[1] = (unsigned long )0;
          sqlstm.sqadto[1] = (unsigned short )0;
          sqlstm.sqtdso[1] = (unsigned short )0;
          sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Tipidtrib;
          sqlstm.sqhstl[2] = (unsigned long )3;
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


        		
        		if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
			{
				vDTrazasLog(modulo, "Error En SELECT COUNT(1) a la FA_RESUMEN_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
	                	return (FALSE);
	            	}	
        		
        		if (ihCantidadRegs == 0)
        		{	
				/* EXEC SQL INSERT INTO FA_RESUMEN_MONTOSIMP_TO 
	        			(NUM_IDENTIFICACION, COD_TIPIDENT, ULT_FECHA_PERIODO,
					TOT_MONTOGRAV, TOT_MONTOEXE, TOT_MONTOIVA, TOT_MONTOICE, 
					CANT_DOCVTAEMI, CANT_NCEMI, CANT_NDEMI, TOT_MONTOICEIMP)
				VALUES	(:szhNum_Identtrib	, :szhCod_Tipidtrib , to_date('01012001','DDMMYYYY'),
					0,0,0,0,
					0,0,0,0); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into FA_RESUMEN_MONTOSIMP_TO (NUM_IDENTIFICACION,C\
OD_TIPIDENT,ULT_FECHA_PERIODO,TOT_MONTOGRAV,TOT_MONTOEXE,TOT_MONTOIVA,TOT_MONT\
OICE,CANT_DOCVTAEMI,CANT_NCEMI,CANT_NDEMI,TOT_MONTOICEIMP) values (:b0,:b1,to_\
date('01012001','DDMMYYYY'),0,0,0,0,0,0,0,0)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )462;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Identtrib;
    sqlstm.sqhstl[0] = (unsigned long )21;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Tipidtrib;
    sqlstm.sqhstl[1] = (unsigned long )3;
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


	       
				if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
				{
					vDTrazasLog(modulo, "Error En INSERT a la FA_RESUMEN_MONTOSIMP_TO. ihCantidadRegs = 0. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
		                	return (FALSE);
		            	}
			}

        		
	            	
	            	vDTrazasLog(modulo, "\t	------------------------------\n",   LOG05);
			vDTrazasLog(modulo, "\t	Valores del Insert... \n",   LOG05);
			
			vDTrazasLog(modulo, "\t	szhNum_Identtrib[%s] \n",   LOG05, szhNum_Identtrib);
			vDTrazasLog(modulo, "\t	szhCod_Tipidtrib[%s] \n",   LOG05, szhCod_Tipidtrib);
			vDTrazasLog(modulo, "\t	lhInd_Ordentotal[%ld]\n",   LOG05, lhInd_Ordentotal);
			vDTrazasLog(modulo, "\t	lhCod_Concepto	[%ld]\n",   LOG05, lhCod_Concepto);
			vDTrazasLog(modulo, "\t	szhCod_Impuesto	[%s] \n",   LOG05, szhCod_Impuesto);
			vDTrazasLog(modulo, "\t	dhTot_Pagar	[%f] \n",   LOG05, dhTot_Pagar);
			vDTrazasLog(modulo, "\t	dhAcum_Netograv	[%f] \n",   LOG05, dhAcum_Netograv);
			vDTrazasLog(modulo, "\t	lhCod_Cliente	[%ld] \n",   LOG05, lhCod_Cliente);
			
	            	
			
			/* EXEC SQL
	                INSERT INTO FA_DETALLE_MONTOSIMP_TO(
	                	NUM_IDENTIFICACION	, 
	                	COD_TIPIDENT		, 
	                	ULT_FECHA_PERIODO	, 
				IND_ORDENTOTAL		, 
				COD_CONCEPTO		, 
				COD_IMPUESTO		, 
				FEC_EMISION		, 
				TOT_PAGAR		, 
				ACUM_NETOGRAV		, 
				ACUM_NETONOGRAV		, 
				ACUM_IVA		, 
				COD_ZONAIMPO		, 
				COD_TIPDOCUM		, 
				ACUM_ICE)
	                VALUES                          (
	                        :szhNum_Identtrib 	, 
	                        :szhCod_Tipidtrib	, 
	                        to_date('01012001', 'DDMMYYYY'),                   
				:lhInd_Ordentotal	, 
				:lhCod_Concepto       , 
				:szhCod_Impuesto	, 
				to_date(:szhFec_Emision, 'DDMMYYYY'), 
				:dhTot_Pagar		, 
				:dhAcum_Netograv	, 
				:dhAcum_Netonograv	, 
				:dhAcumIva		, 
				:lhCod_Zonaimpo	, 
				:lhCod_Tipdocum	, 
				:dhAcumIce	       ); */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 30;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "insert into FA_DETALLE_MONTOSIMP_TO (NUM_IDENTIFICACION,CO\
D_TIPIDENT,ULT_FECHA_PERIODO,IND_ORDENTOTAL,COD_CONCEPTO,COD_IMPUESTO,FEC_EMIS\
ION,TOT_PAGAR,ACUM_NETOGRAV,ACUM_NETONOGRAV,ACUM_IVA,COD_ZONAIMPO,COD_TIPDOCUM\
,ACUM_ICE) values (:b0,:b1,to_date('01012001','DDMMYYYY'),:b2,:b3,:b4,to_date(\
:b5,'DDMMYYYY'),:b6,:b7,:b8,:b9,:b10,:b11,:b12)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )485;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhNum_Identtrib;
   sqlstm.sqhstl[0] = (unsigned long )21;
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Tipidtrib;
   sqlstm.sqhstl[1] = (unsigned long )3;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhInd_Ordentotal;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)&lhCod_Concepto;
   sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhCod_Impuesto;
   sqlstm.sqhstl[4] = (unsigned long )6;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhFec_Emision;
   sqlstm.sqhstl[5] = (unsigned long )9;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)&dhTot_Pagar;
   sqlstm.sqhstl[6] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)&dhAcum_Netograv;
   sqlstm.sqhstl[7] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&dhAcum_Netonograv;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&dhAcumIva;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)&lhCod_Zonaimpo;
   sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)&lhCod_Tipdocum;
   sqlstm.sqhstl[11] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)&dhAcumIce;
   sqlstm.sqhstl[12] = (unsigned long )sizeof(double);
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


	
	
	
	            	if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
			{
				vDTrazasLog(modulo, "Error En INSERT a la FA_DETALLE_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
	                	return (FALSE);
	            	}
	        
		}
		
		/*lCod_ClienteAux = pstDatosAcum.stDatosAcum[i].lCod_Cliente;*/
		trim (pstDatosAcum.stDatosAcum[i].szNum_Identtrib , szNumIdentAux );
	}
	
	if (pstDatosAcum.iCantDatosAcum > 0)
	{
		/* EXEC SQL UPDATE FA_RESUMEN_MONTOSIMP_TO SET 					
			TIPO_DOCUMENTO		= :lhCod_Tipdocum, 
			TOT_MONTOGRAV		= TOT_MONTOGRAV		+ :dhTot_MtoGrav, 
			TOT_MONTOEXE		= TOT_MONTOEXE		+ :dhTot_MtoExe	, 
			TOT_MONTOIVA		= TOT_MONTOIVA		+ :dhTot_MtoIva, 
			TOT_MONTOICE		= TOT_MONTOICE		+ :dhTot_MtoIce, 
			CANT_DOCVTAEMI		= CANT_DOCVTAEMI	+ :lhAcumDocumentos, 
			CANT_NCEMI		= CANT_NCEMI		+ :lhAcumNCredito, 
			CANT_NDEMI		= CANT_NDEMI		+ :lhAcumNDebito, 
			COD_PROVINCIA		= :szhCod_Provincia, 
			COD_CANTON		= :szhCod_Comuna, 
			NOM_CLIENTE		= :szhNom_Cliente , 
			NOM_APECLIEN1		= :szhNom_Apeclien1, 
			NOM_APECLIEN2		= :szhNom_Apeclien2, 
			CERRADO 		= 'N'
		WHERE NUM_IDENTIFICACION = :szhNum_Identtrib
		AND COD_TIPIDENT = :szhCod_Tipidtrib; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 30;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "update FA_RESUMEN_MONTOSIMP_TO  set TIPO_DOCUMENTO=:b0,TOT_\
MONTOGRAV=(TOT_MONTOGRAV+:b1),TOT_MONTOEXE=(TOT_MONTOEXE+:b2),TOT_MONTOIVA=(TO\
T_MONTOIVA+:b3),TOT_MONTOICE=(TOT_MONTOICE+:b4),CANT_DOCVTAEMI=(CANT_DOCVTAEMI\
+:b5),CANT_NCEMI=(CANT_NCEMI+:b6),CANT_NDEMI=(CANT_NDEMI+:b7),COD_PROVINCIA=:b\
8,COD_CANTON=:b9,NOM_CLIENTE=:b10,NOM_APECLIEN1=:b11,NOM_APECLIEN2=:b12,CERRAD\
O='N' where (NUM_IDENTIFICACION=:b13 and COD_TIPIDENT=:b14)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )552;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_Tipdocum;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dhTot_MtoGrav;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dhTot_MtoExe;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&dhTot_MtoIva;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&dhTot_MtoIce;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&lhAcumDocumentos;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhAcumNCredito;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&lhAcumNDebito;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhCod_Provincia;
  sqlstm.sqhstl[8] = (unsigned long )4;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhCod_Comuna;
  sqlstm.sqhstl[9] = (unsigned long )6;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhNom_Cliente;
  sqlstm.sqhstl[10] = (unsigned long )51;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhNom_Apeclien1;
  sqlstm.sqhstl[11] = (unsigned long )21;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhNom_Apeclien2;
  sqlstm.sqhstl[12] = (unsigned long )21;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhNum_Identtrib;
  sqlstm.sqhstl[13] = (unsigned long )21;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhCod_Tipidtrib;
  sqlstm.sqhstl[14] = (unsigned long )3;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
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


		
		if(SQLCODE!=SQLOK && SQLCODE!=SQLNOTFOUND)
		{
			vDTrazasLog(modulo, "Error En UPDATE a la FA_RESUMEN_MONTOSIMP_TO. Proceso se cancela. Error[%d] [%s]\n",   LOG05, SQLCODE, SQLERRM);
                	return (FALSE);
            	}
	}
	
	return(TRUE);
}


BOOL bfnCargaTablas()
{

char modulo[]="bfnCargaTablas";
BOOL bExiste = TRUE;
int   i;
int   iContLeidos = 0;
int   iContTotal  = 0;


	if(!iCargaTablasFacturacion())
	{
		strcpy(modulo, "bfnCargaTablas");
		vDTrazasLog(modulo, "Error al Cargar Tablas con datos de Facturacion. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}


	return (TRUE);
}

BOOL bfnVerificaGeneracionReporte()
{
	/* EXEC SQL BEGIN DECLARE SECTION  ; */ 

		char	szhValor[2];
	/* EXEC SQL END DECLARE SECTION    ; */ 
    

    	/* EXEC SQL SELECT VAL_PARAMETRO
    		INTO :szhValor 
		FROM GED_PARAMETROS
		WHERE COD_MODULO = 'FA'
		AND NOM_PARAMETRO = 'REPORTES_LEGALES_ECU'; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 30;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select VAL_PARAMETRO into :b0  from GED_PARAMETROS where\
 (COD_MODULO='FA' and NOM_PARAMETRO='REPORTES_LEGALES_ECU')";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )627;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhValor;
     sqlstm.sqhstl[0] = (unsigned long )2;
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



	if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
         	vDTrazasLog  (modulo, "Error en la obtencion de parametros. Error-Ora[%ld]: %s\n", LOG01, SQLCODE, SQLERRM);
            	return (FALSE);
        }
        
        if(SQLCODE == SQLNOTFOUND)
        {
            vDTrazasLog  (modulo, "Parametro no encontrado. Error-Ora[%ld]: %s\n", LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        
        if (strcmp(szhValor, "N") == 0)
        {
        	vDTrazasLog  (modulo, "Parametro indica que no se generan reportes legales.\n", LOG01);
            	exit(1);
        }
	
	return (TRUE);

}

BOOL bfnChequeaProcesosPrevios(long lCodCiclFact)
{
    /* EXEC SQL BEGIN DECLARE SECTION  ; */ 

        long    lhCodCiclo          ;
        int     ihCodEstaPrec       ;
        int     ihTrazCodEstaProc   ;
        int     lhCod_Proceso       ;
    /* EXEC SQL END DECLARE SECTION    ; */ 

    BOOL bFinCursor_cFaProcTraza=FALSE;

    strcpy (modulo, "bfnChequeaProcesosPrevios");

    lhCodCiclo = lCodCiclFact;
    lhCod_Proceso = iCOD_PROCESO;

    /* EXEC SQL DECLARE cFaProcTraza CURSOR FOR
        SELECT
                PROC.COD_ESTAPREC,
                NVL(TRAZ.COD_ESTAPROC,0)
        FROM    FA_TRAZAPROC  TRAZ,
                (SELECT A.COD_PROCESO   COD_PROCESO,
                        B.DES_PROCESO   DES_PROCESO,
                        A.COD_PROCPREC  COD_PROCPREC,
                        C.DES_PROCESO   DES_PROCPREC,
                        A.COD_ESTAPREC  COD_ESTAPREC
                FROM    FA_PROCFACTPREC A ,
                        FA_PROCFACT B ,
                        FA_PROCFACT C
                WHERE   A.COD_PROCESO  = :lhCod_Proceso
                AND     A.COD_PROCESO  = B.COD_PROCESO
                AND     A.COD_PROCPREC = C.COD_PROCESO) PROC
        WHERE   TRAZ.COD_CICLFACT (+)  = :lhCodCiclo
        AND     TRAZ.COD_PROCESO  (+)  = PROC.COD_PROCPREC
        ORDER BY PROC.COD_PROCESO; */ 


    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (modulo, "\n\t**  Error : Declaracion del cursor FA_TRAZAPROC**"                                   
                                    ,LOG01);        
        return (FALSE);
    }

    /* EXEC SQL OPEN cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0013;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )646;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCod_Proceso;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclo;
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



    if(SQLCODE != SQLOK)
    {
        vDTrazasLog  (modulo, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,lhCod_Proceso,lhCodCiclo,SQLERRM);
        vDTrazasError(modulo, "\n\t**  Error : Al Crear Cursor de Procesos FA_PROCFACT - FA_TRAZAPROC **"
                                    "\n\t\t=> Para el Codigo de Proceso [%d]"
                                    "\n\t\t=> Para el Codigo de Ciclo   [%ld]"
                                    "\n\t\t=> (No Existe Traza Para el Proceso)\n%s\n"
                                    ,LOG01,lhCod_Proceso,lhCodCiclo,SQLERRM);
        return (FALSE);
    }
    /****************************************************************************/
    bFinCursor_cFaProcTraza = FALSE ;
    do
    {
        /* EXEC SQL FETCH cFaProcTraza INTO
                    :ihCodEstaPrec          ,
                    :ihTrazCodEstaProc      ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 30;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )669;
        sqlstm.selerr = (unsigned short)1;
        sqlstm.cud = sqlcud0;
        sqlstm.sqlest = (unsigned char  *)&sqlca;
        sqlstm.sqlety = (unsigned short)256;
        sqlstm.occurs = (unsigned int  )0;
        sqlstm.sqfoff = (         int )0;
        sqlstm.sqfmod = (unsigned int )2;
        sqlstm.sqhstv[0] = (unsigned char  *)&ihCodEstaPrec;
        sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
        sqlstm.sqhsts[0] = (         int  )0;
        sqlstm.sqindv[0] = (         short *)0;
        sqlstm.sqinds[0] = (         int  )0;
        sqlstm.sqharm[0] = (unsigned long )0;
        sqlstm.sqadto[0] = (unsigned short )0;
        sqlstm.sqtdso[0] = (unsigned short )0;
        sqlstm.sqhstv[1] = (unsigned char  *)&ihTrazCodEstaProc;
        sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
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



        if(SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
        {
            vDTrazasLog  (modulo, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            vDTrazasError(modulo, "Error en Fetch de Cursor de cFaProcTraza Error-Ora[%ld]: %s"
                                        ,LOG01, SQLCODE, SQLERRM);
            return (FALSE);
        }
        if(SQLCODE == SQLNOTFOUND)
        {
            bFinCursor_cFaProcTraza = TRUE;
        }
        else
        {
            /****************************************************************************/
            /*  Valida que el Estado del Proceso Precedente este Actualizado en la      */
            /*  tabla de Traza  FA_TRAZAPROC.                                           */
            /****************************************************************************/
            if(ihCodEstaPrec != ihTrazCodEstaProc)
            {
                vDTrazasLog  (modulo, "\n\t* Error: No ha Terminado Proceso Previo **\n",LOG01);
                vDTrazasError(modulo, "\n\t* Error: No ha Terminado Proceso Previo **\n",LOG01);
                return(FALSE);
            }
        }
    } while(!bFinCursor_cFaProcTraza);

    /* EXEC SQL CLOSE cFaProcTraza; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 30;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )692;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}




    return (TRUE);

}


/* HASTA AQUI PGG FUNCIONES NUEVAS */


/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char modulo[]="main"		;
    char *szUserid_Aux			;
    extern	char *optarg        	;
    char  	opt[]=":u:c:l:" 	;
    int   	iOpt =0             	;
    int   	sts			;
    char  	szHelpString[1024] = " ";
    char  	szLineaComando2[25]= ""	;
    int		iUserFlag 	= 0;
    int		iLogFlag 	= 0;
    int		iCicloFlag 	= 0;

    memset(&stLineaComando,0    ,sizeof(LINEACOMANDO));


    sprintf(szHelpString,"\n Argumentos de entrada de proceso : "
                         "\n\t -u Usuario/Password"
                         "\n\t -c Ciclo de Facturacion"
                         "\n\t -l Nivel de Log\n");


    if (argc == 1)
    {
	fprintf(stderr,"%s",szHelpString);
	return 1;
    }

    while ( (iOpt = getopt(argc,argv,opt)) != EOF)
    {
        switch(iOpt)
        {
		case 'u':
			strcpy(stLineaComando.szUsuario, optarg);
			if((szUserid_Aux=(char *)strstr(stLineaComando.szUsuario,"/")) == (char *)NULL)
			{
				fprintf(stderr, "\nUsuario Oracle no es valido.\n");
				return(1);
			}
			else
			{
				strncpy(stLineaComando.szUser,stLineaComando.szUsuario, szUserid_Aux-stLineaComando.szUsuario);
				strcpy(stLineaComando.szPass, szUserid_Aux+1);
				printf("stLineaComando.szUser	[%s]\n",stLineaComando.szUser);
				printf("stLineaComando.szPass	[%s]\n",stLineaComando.szPass);
				fprintf (stdout," -u?/? ");
				iUserFlag = 1;
			}
			break;
		case 'c':
                	if (strlen (optarg))
                 	{
                    		stLineaComando.lCodCiclFact = atol(optarg);
                    		fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclFact);
                    		iCicloFlag = 1;
                 	}
                 	break;


		case 'l':
			if (strlen (optarg) )
			{
				stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
				fprintf (stdout,"-l%d ", stStatus.LogNivel)     ;
				iLogFlag = 1;
			}
			break;
		case '?':
			fprintf(stderr,"\n<< ERROR (main): Se ha ingresado parametro desconocido: -%c >>\n%s\n",optopt,szHelpString);
			return -1;
			
		case ':':
			if ( optopt == 'u' ) 
			{
				fprintf(stderr,"\n<< ERROR (main): Falta especificar usuario/password >>\n%s",szHelpString);
				return -1;
			}
			if ( optopt == 'c' ) 
			{
				fprintf(stderr,"\n<< ERROR (main): Falta especificar Ciclo de Facturacion >>\n%s",szHelpString);
			    	return -1;
			}
			if ( optopt == 'l' ) 
			{
				fprintf(stderr,"\n<< ERROR (main): Falta especificar nivel de LOG >>\n%s",szHelpString);
			   	return -1;
			}
			
        }/*End Switch */


    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */

	if ((iCicloFlag == 0) || (iLogFlag == 0) || (iUserFlag == 0))
	{
		fprintf(stderr,"Faltan parametros \n\n%s",szHelpString);
		return 1;
	}

	if (stLineaComando.lCodCiclFact < 0)
	{
		fprintf(stderr, "\n\tCiclo de Facturacion Invalido o no ingresado\n");
		fprintf(stderr,"%s",szHelpString);
		return 1;
	}


	if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF;

	stLineaComando.iNivLog = stStatus.LogNivel;

    	if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    	{
        	fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                		"<usuario> <passwd> '\n");
		fprintf(stderr,"%s",szHelpString);
        	return (2);
    	}
    	else
    	{
        	printf( "\n\t-------------------------------------------------------"
                	"\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                	"\n\t-------------------------------------------------------\n",
	                stLineaComando.szUser);
    	}
    	
    	
    	
    	
	if (stLineaComando.lCodCiclFact != 0)
	{
	    	if (!bfnChequeaProcesosPrevios(stLineaComando.lCodCiclFact))
	        {
	            vDTrazasLog(modulo,"Error en ejecucion de bfnChequeaProcesosPrevios ",LOG02);
	            return(FALSE);
	        }
	}

	
	if (!bfnVerificaGeneracionReporte())
	{
		vDTrazasLog(modulo,"Error en ejecucion de bfnVerificaGeneracionReporte ",LOG02);
		return(FALSE);	
	}
	


    	/**************************************************************************************/
    	/* Crear archivos y directorios de log y errores */

    	sts = ifnAbreArchivosLog();


    	if ( sts != 0 ) return sts;

    	/*********************************************************************************************/

    	vDTrazasLog  ( modulo ,"\n\n\t**********************************************"
                           "\n\n\t****           Log Proc_ExtracCICLO           **"
                           "\n\n\t**********************************************"
                           ,LOG03);

    	vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada Proc_ExtracCICLO  ***"
                           "\n\t\t=> Usuario               	[%s]"
                           "\n\t\t=> Ciclo de Facturacion	[%ld]"
                             "\n\t\t=> Niv.Log              	[%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.lCodCiclFact
                           ,stLineaComando.iNivLog);

    	/************************************************************************************/
    	/*			Proceso Principal						*/
    	/************************************************************************************/

    	strcpy(modulo,"Proc_ExtracCICLO");

    	vDTrazasLog(modulo,"\n\t\t***  Inicio Proceso principal  ***", LOG03);
    	vDTrazasLog(modulo,"\n\t\t*** Inicio del Cargado de Estructuras***\n", LOG03);

	if (!bfnCargaEstructuras())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
	        return (FALSE);
	}
	vDTrazasLog(modulo,"\n\t\t*** Inicio Ejecucion Procesos de carga de tablas***\n", LOG03);

	if (pstDatosAcum.iCantDatosAcum != 0)
	{
		if (!bfnCargaTablas())
		{
			vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de procesos***\n", LOG01);
			vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de procesos***\n", LOG01);
		        return (FALSE);
		}
	}


    	if (!bfnOraCommit ())
    	{
        	vDTrazasError(modulo," en Commit", LOG01);
        	vDTrazasLog  (modulo," en Commit", LOG01);
        	return FALSE;
    	}

	if(!bfnDisconnectORA(0))
	{
		vDTrazasLog  ( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo ,	"\n\t--------------------------------------------"
					"\n\t ERROR en Desconeccion de  ORACLE  = finaliza"
					"\n\t--------------------------------------------\n"
					,LOG03);
	}
    	else
    	{
		vDTrazasLog  ( modulo,	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);
		vDTrazasError( modulo, 	"\n\t--------------------------------------------"
					"\n\tDesconectado de  ORACLE"
					"\n\t--------------------------------------------\n"
					,LOG03);

	}

    return (0);
}/* ********************* Fin Main * *************************************** */

/* ******************************************************************************** */
/* ifnAbreArchivosLog : Crea para escritura o appendea archivos de Log y de Errores */
/* ******************************************************************************** */
int ifnAbreArchivosLog(void)
{
	char modulo[]="ifnAbreArchivosLog";

	char *pathDir;
	char szArchivo[32]="";
	char szPath[128]="";
	char szComando[128]="";
	char szRechazadosName[32];

	memset(szArchivo,'\0',sizeof(szArchivo));
	sprintf(szArchivo,"Proc_ExtracCICLO");

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/Proc_Extractor/Ciclo/%s",pathDir,cfnGetTime(2));
	free(pathDir);

	fprintf(stdout, "\nCrea Directorio Log  : %s\n", szPath);
	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	fprintf(stdout, "\nCrea Archivo Log/Err : %s\n\n", szArchivo);

	sprintf(stStatus.ErrName,"%s/%s_%s.err",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.ErrFile = fopen(stStatus.ErrName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de errores %s >> \n", stStatus.ErrName);
		return -7;
	}

	vDTrazasError(modulo, "%s  << Abre Archivo de Errores >>", LOG04, cfnGetTime(1));

	sprintf(stStatus.LogName,"%s/%s_%s.log",szPath,szArchivo,cfnGetTime(5));
	if((stStatus.LogFile = fopen(stStatus.LogName,"w")) == (FILE*)NULL )
	{	fprintf(stderr, "\n<< No pudo crearse el archivo de log %s >>\n", stStatus.LogName);
		vDTrazasError(modulo, "\n<< No pudo crearse el archivo de log %s >>\n", LOG01, stStatus.LogName);
		return -8;
	}

	vDTrazasLog(modulo, "%s << Abre Archivo de Log >>", LOG04, cfnGetTime(1));


	vDTrazasLog(modulo, "%s << Inicio de Proc_ExtracCICLO >>" , LOG03, cfnGetTime(1));

	return 0;


} /* Fin ifnAbreArchivosLog  */


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
