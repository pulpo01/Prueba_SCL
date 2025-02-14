
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
           char  filnam[20];
};
static const struct sqlcxp sqlfpn =
{
    19,
    "./pc/ValidaConce.pc"
};


static unsigned int sqlctx = 27698163;


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

 static const char *sq0001 = 
"select  /*+   index (TOL_ACUMOPER_TO AK_TOL_ACUMOPER_TO)  + +*/ COD_CLIENTE \
,NUM_ABONADO ,COD_CARG ,count(1)  from TOL_ACUMOPER_TO where COD_CARG not  in \
(select COD_CONCORIG  from FA_CONCEPTRAIMP_TD ) group by COD_CLIENTE,NUM_ABONA\
DO,COD_CARG           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4130,2,0,0,
5,0,0,1,254,0,9,132,0,0,0,0,0,1,0,
20,0,0,1,0,0,13,147,0,0,4,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,
51,0,0,1,0,0,15,166,0,0,0,0,0,1,0,
};


/* ********************************************************************** */
/* *  Fichero : ValidaConce.pc                                		* */
/* *  Proceso generador de reportes de validacion de conceptos		* */
/* *  Autor : Patricio Gonzalez Gomez	                                * */
/* *  Modif : 								* */
/* *  Parametros : 							* */
/* *         -u Usuario/Password                                        * */
/* *         -l Nivel de Log						* */
/* ********************************************************************** */

#define _VALIDACONCE_PC_

#include <deftypes.h>
#include <stdlib.h>
#include <New_Interfact.h>
#include <GenFA.h>
#include "ValidaConce.h"

/****************************************************************************/
/*           Variables de Retorno de Oracle-Pro-C                           */
/****************************************************************************/

char  	modulo[30];

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

/* PGG SOPORTE... CODIGO NUEVO DESDE AQUI */

int iCargaEstructura(REG_ARCH_STRUCT **pstRegStruct, int *iNumRegStruct)
{
        int     rc = 0;
        long    lNumFilas;
        static  REG_ARCH_STRUCT_HOST pstRegStructHost;
        REG_ARCH_STRUCT *pstRegStructTemp;
        long lCont;

        strcpy(modulo,"iCargaEstructura");

        vDTrazasLog(modulo, "\n\t\t* Carga Estructura",   LOG05);


        *iNumRegStruct = 0;
        *pstRegStruct = NULL;

        if (ifnOpenSTRUCT ())
        	return (FALSE);

	vDTrazasLog(modulo, "\n\t\t* Paso el OPEN Cur_STRUCT",   LOG05);

        while (rc != SQLNOTFOUND)
        {
        rc = ifnFetchSTRUCT (&pstRegStructHost,&lNumFilas);
        vDTrazasLog(modulo, "\n\t\t* Paso el FECTH Cur_STRUCT",   LOG05);

        if (rc != SQLOK  && rc != SQLNOTFOUND)
        {
        		vDTrazasLog(modulo, "\n\t\t* Primer return false",   LOG05);
                        return (FALSE);
	}
                if (!lNumFilas)
                {
                	vDTrazasLog(modulo, "\n\t\t* Segundo return false",   LOG05);
                	break;
		}

                *pstRegStruct =(REG_ARCH_STRUCT*) realloc(*pstRegStruct,(((*iNumRegStruct)+lNumFilas)*sizeof(REG_ARCH_STRUCT)));

                if (!*pstRegStruct)
                {
                	vDTrazasLog(modulo, "\n\t\t* Tercer return false",   LOG05);
                        return (FALSE);
		}

                pstRegStructTemp = &(*pstRegStruct)[(*iNumRegStruct)];
                memset(pstRegStructTemp, 0, sizeof(REG_ARCH_STRUCT)*lNumFilas);
                for (lCont = 0 ; lCont < lNumFilas ; lCont++)
                {
                        pstRegStructTemp[lCont].lCod_Cliente		 	= 	pstRegStructHost.lCod_Cliente	[lCont];
                        pstRegStructTemp[lCont].lNum_Abonado		 	= 	pstRegStructHost.lNum_Abonado	[lCont];
                        pstRegStructTemp[lCont].lCod_Carg		 	= 	pstRegStructHost.lCod_Carg	[lCont];
                        pstRegStructTemp[lCont].lCantidad		 	= 	pstRegStructHost.lCantidad	[lCont];
                }
                (*iNumRegStruct) += lNumFilas;

        }/* fin while */


        vDTrazasLog(modulo, "\n\t\t* Cantidad de Regs. de la Estructura cargados [%d]",   LOG05, *iNumRegStruct);

        rc = ifnCloseSTRUCT();
        if (rc != SQLOK)
                return (FALSE);

        vfnPrintSTRUCT (*pstRegStruct, *iNumRegStruct);

        return (TRUE);
}

static int ifnOpenSTRUCT (void)
{
    	strcpy(modulo,"ifnOpenSTRUCT");


        /* EXEC SQL DECLARE Cursor_STRUCT CURSOR FOR
		SELECT /o+  index (TOL_ACUMOPER_TO AK_TOL_ACUMOPER_TO)  +o/
		COD_CLIENTE,NUM_ABONADO, COD_CARG, COUNT(1)
		FROM   TOL_ACUMOPER_TO
		WHERE  COD_CARG NOT IN ( SELECT COD_CONCORIG FROM FA_CONCEPTRAIMP_TD)
		GROUP BY COD_CLIENTE,NUM_ABONADO, COD_CARG; */ 



    	if(SQLCODE != SQLOK)
        {

        	vDTrazasLog(modulo, "\n\t\t* DECLARE=> Cursor_STRUCT",   LOG05);
                return(SQLCODE);
    	}

        /* EXEC SQL OPEN Cursor_STRUCT; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 0;
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
        sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    	if(SQLCODE != SQLOK)
        {
        	vDTrazasLog(modulo, "\n\t\t* OPEN=> Cursor_STRUCT",   LOG05);
                return(SQLCODE);
    	}

    	return (SQLCODE);
}/***************************** Final ifnOpenSTRUCT  **********************/



static BOOL ifnFetchSTRUCT (REG_ARCH_STRUCT_HOST *pstHost,long *plNumFilas)
{
         /* EXEC SQL FETCH Cursor_STRUCT
             INTO	 :pstHost->lCod_Cliente
			,:pstHost->lNum_Abonado
			,:pstHost->lCod_Carg
			,:pstHost->lCantidad	; */ 

{
         struct sqlexd sqlstm;
         sqlstm.sqlvsn = 12;
         sqlstm.arrsiz = 4;
         sqlstm.sqladtp = &sqladt;
         sqlstm.sqltdsp = &sqltds;
         sqlstm.iters = (unsigned int  )2000;
         sqlstm.offset = (unsigned int  )20;
         sqlstm.selerr = (unsigned short)1;
         sqlstm.cud = sqlcud0;
         sqlstm.sqlest = (unsigned char  *)&sqlca;
         sqlstm.sqlety = (unsigned short)256;
         sqlstm.occurs = (unsigned int  )0;
         sqlstm.sqfoff = (         int )0;
         sqlstm.sqfmod = (unsigned int )2;
         sqlstm.sqhstv[0] = (unsigned char  *)(pstHost->lCod_Cliente);
         sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[0] = (         int  )sizeof(long);
         sqlstm.sqindv[0] = (         short *)0;
         sqlstm.sqinds[0] = (         int  )0;
         sqlstm.sqharm[0] = (unsigned long )0;
         sqlstm.sqharc[0] = (unsigned long  *)0;
         sqlstm.sqadto[0] = (unsigned short )0;
         sqlstm.sqtdso[0] = (unsigned short )0;
         sqlstm.sqhstv[1] = (unsigned char  *)(pstHost->lNum_Abonado);
         sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[1] = (         int  )sizeof(long);
         sqlstm.sqindv[1] = (         short *)0;
         sqlstm.sqinds[1] = (         int  )0;
         sqlstm.sqharm[1] = (unsigned long )0;
         sqlstm.sqharc[1] = (unsigned long  *)0;
         sqlstm.sqadto[1] = (unsigned short )0;
         sqlstm.sqtdso[1] = (unsigned short )0;
         sqlstm.sqhstv[2] = (unsigned char  *)(pstHost->lCod_Carg);
         sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[2] = (         int  )sizeof(long);
         sqlstm.sqindv[2] = (         short *)0;
         sqlstm.sqinds[2] = (         int  )0;
         sqlstm.sqharm[2] = (unsigned long )0;
         sqlstm.sqharc[2] = (unsigned long  *)0;
         sqlstm.sqadto[2] = (unsigned short )0;
         sqlstm.sqtdso[2] = (unsigned short )0;
         sqlstm.sqhstv[3] = (unsigned char  *)(pstHost->lCantidad);
         sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
         sqlstm.sqhsts[3] = (         int  )sizeof(long);
         sqlstm.sqindv[3] = (         short *)0;
         sqlstm.sqinds[3] = (         int  )0;
         sqlstm.sqharm[3] = (unsigned long )0;
         sqlstm.sqharc[3] = (unsigned long  *)0;
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




	vDTrazasLog(modulo, "\n\t\t* SQLCODE EN FETCH	[%ld]\n",   LOG05, sqlca.sqlcode);
        if (SQLCODE==SQLOK)
                *plNumFilas = TAM_HOSTS_PEQ;
        else
                if (SQLCODE==SQLNOTFOUND)
                        *plNumFilas = sqlca.sqlerrd[2] % TAM_HOSTS_PEQ;

  return (SQLCODE);
}/***************************** Final ifnFetchSTRUCT ****************/

int ifnCloseSTRUCT (void)
{
	/* EXEC SQL CLOSE Cursor_STRUCT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )51;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	strcpy(modulo,"ifnCloseSTRUCT");
	vDTrazasLog(modulo, "\n\t\t* Close=> Cursor_STRUCT",   LOG05);

	return (SQLCODE);
}/**************************** Final ifnCloseSTRUCT ******************/


void vfnPrintSTRUCT (REG_ARCH_STRUCT *pstRegStruct, int iNumRegStruct)
{
        int i = 0;

        strcpy(modulo,"vfnPrintSTRUCT");

	vDTrazasLog(modulo,"\n\t\t* Despliegue de la Carga de la Estructura... [%d]", LOG05 ,iNumRegStruct);

        for (i=0;i<iNumRegStruct;i++)
        {
               vDTrazasLog(modulo,	"---------------------------------------\n"
               				"pstRegStruct[%d].lCod_Cliente			[%ld]	\n"
                                        "pstRegStruct[%d].lNum_Abonado			[%ld]	\n"
                                        "pstRegStruct[%d].lCod_Carg			[%ld]	\n"
                                        "pstRegStruct[%d].lCantidad			[%ld]	\n"
               				, LOG05
               				, i, pstRegStruct[i].lCod_Cliente
               				, i, pstRegStruct[i].lNum_Abonado
               				, i, pstRegStruct[i].lCod_Carg
               				, i, pstRegStruct[i].lCantidad	);
        }
}/*************************** vfnPrintSTRUCT *****************************/

/* PGG SOPORTE... CODIGO NUEVO HASTA AQUI */

BOOL bfnCargaEstructuras()
{
	char modulo[]="bfnCargaEstructuras";

	if(!iCargaEstructura(&pstRegStruct.stRegStruct, &pstRegStruct.iCantRegStruct)!= SQLOK)
	{
		strcpy(modulo, "bfnCargaEstructuras");
		vDTrazasLog(modulo, "Error al Cargar el Detalle de la Estructura para el reporte. Proceso se cancela.\n",   LOG05);
		return(FALSE);
	}

	return (TRUE);
}

BOOL bfnGeneraReporte()
{
	char modulo[]="bfnGeneraReporte";	
	int   i;
	FILE 	*Arch;
	char 	*pathDir;
	char 	szPath[128]="";
	char 	szNombreFile[200];
	char	szRegistro[4000];
	char 	szComando[128]="";

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_DAT");
	sprintf(szPath,"%s/ValidaConce/%s",pathDir,cfnGetTime(2));
	free(pathDir);

	vDTrazasLog(modulo,"szPath DAT	[%s]\n", LOG03, szPath);

	sprintf(szComando,"mkdir -p %s", szPath);
	system (szComando);

	memset (szNombreFile, '\0', sizeof(szNombreFile));


	sprintf (szNombreFile	, "%s/ValidaConce_%s.dat"	, szPath, cfnGetTime(5));



	if( (Arch=fopen(szNombreFile, "w" ) )==NULL )
	{
		vDTrazasLog(modulo,"Error creando archivo de Validacion [%s]\n", LOG03, szNombreFile);
	}


	sprintf (szRegistro,	"-----------------------------------------------------------------------\n"
        		    	"HORA INICIO  : %s\n"
        			"-----------------------------------------------------------------------\n"
        			,cfnGetTime(1));

        fprintf(Arch ,"%s", szRegistro);

	if (pstRegStruct.iCantRegStruct > 0)
	{

		printf("Archivo  [%s]\n", szNombreFile);

		for (i=0; i < pstRegStruct.iCantRegStruct; i++)
		{
			memset(szRegistro, '\0', sizeof(szRegistro));

			sprintf (szRegistro, 	"-----------------------------------------------------------------------\n"
						"CLIENTE = %ld\n"
						"ABONADO = %ld\n"
						"COD_CARG= %ld\n"
						"CANTIDAD= %ld\n"
						,pstRegStruct.stRegStruct[i].lCod_Cliente
						,pstRegStruct.stRegStruct[i].lNum_Abonado
						,pstRegStruct.stRegStruct[i].lCod_Carg	
						,pstRegStruct.stRegStruct[i].lCantidad);

			fprintf(Arch ,"%s", szRegistro);

		}
	}

	sprintf (szRegistro,	"-----------------------------------------------------------------------\n"
				"-----------------------------------------------------------------------\n"
				"HORA TÉRMINO  : %s\n"
				"-----------------------------------------------------------------------\n"
				,cfnGetTime(1));

	fprintf(Arch ,"%s", szRegistro);

	fclose (Arch);

	return (TRUE);
}

/****************************************************************************/
/*  Funcion :   main                                                        */
/****************************************************************************/

int main(int argc, char *argv[])
{
    char 	modulo[]="main"		;
    char 	*szUserid_Aux		;
    extern	char *optarg        	;
    char  	opt[]=":u:c:l:" 	;
    int   	iOpt =0             	;
    int   	sts			;
    char  	szHelpString[1024] = " ";    
    char        szaux[10]  	= "" 	;
    

    memset(&stLineaComando,0    ,sizeof(LINEACOMANDOPRELIMINAR));


    sprintf(szHelpString,"\n Argumentos de entrada de proceso : "
    				"\n\t -u Usuario/Password                               "
    				"\n\t -c Codigo de Ciclo de facturacion			"    				
    				"\n\t -l Nivel de Log				   	\n");

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
				fprintf (stdout," -u?/? ");
			}
			break;


		case 'c':
                	if (strlen (optarg))
                	{
	                    strcpy(szaux,optarg);
	                    stLineaComando.lCodCiclo = atol(szaux);
	                    fprintf (stdout,"-c %ld ", stLineaComando.lCodCiclo);
	                }
	                break;
                
		case 'l':
			if (strlen (optarg) )
			{
				stStatus.LogNivel =(atoi (optarg) > 0)? atoi (optarg):iLOGNIVEL_DEF ;
				fprintf (stdout,"-l%d ", stStatus.LogNivel)     ;
			}
			break;

        }/*End Switch */

    } /* End While */
    fprintf (stdout,"\n");

    /* Validacion de Parametros */
	if (stLineaComando.lCodCiclo == 0)
	{
		fprintf (stderr, "\n\t# Faltan Parametros de Entrada:\n%s\n", szHelpString);
		return 1;
	}


	if (stStatus.LogNivel <= 0) stStatus.LogNivel = iLOGNIVEL_DEF;

	stLineaComando.iNivLog = stStatus.LogNivel;

    	if(!bfnConnectORA(stLineaComando.szUser,stLineaComando.szPass))
    	{
        	fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t"
                		"' <usuario> <passwd> '\n");
        	return (2);
    	}
    	else
    	{
        	printf( "\n\t-------------------------------------------------------"
                	"\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx "
                	"\n\t-------------------------------------------------------\n",
	                stLineaComando.szUser);
    	}



	
	
	/* iCODPROCVALIDACONCE (2999) es cod_proceso del proceso ValidaConce */

	/*if (!bfnValidaTrazaProc(stLineaComando.lCodCiclo, iCODPROCVALIDACONCE, 1 )) */
	if (!bfnValidaTrazaProc(stLineaComando.lCodCiclo, iCODPROCVALIDACONCE, iIND_FACT_ENPROCESO))
    	{
    		printf ("FALLO VALIDATRAZAPROC \n");
       		return(FALSE);
	}
	else
	{
		stTrazaProc.lCodCiclFact = stLineaComando.lCodCiclo;
		sprintf (stTrazaProc.szFecInicio ,"%s000000",  cfnGetTime(2));
	}



    	/**************************************************************************************/
    	/* Crear archivos y directorios de log y errores */

    	sts = ifnAbreArchivosLog();


    	if ( sts != 0 ) return sts;

    	/*********************************************************************************************/

    	vDTrazasLog  ( modulo ,"\n\n\t**********************************************"
                           "\n\n\t****           Log ValidaConce          **"
                           "\n\n\t**********************************************"
                           ,LOG03);

    	vDTrazasLog  ( modulo ,"\n\t\t***  Parametro de Entrada ValidaConce  ***"
                           "\n\t\t=> Usuario               	[%s]"
                           "\n\t\t=> Mes			[%ld]"
                           "\n\t\t=> Año			[%ld]"
                           "\n\t\t=> Niv.Log              	[%d]"
                           ,LOG03
                           ,stLineaComando.szUser
                           ,stLineaComando.lMes
                           ,stLineaComando.lAno
                           ,stLineaComando.iNivLog);

    	/************************************************************************************/
    	/*			Proceso Principal						*/
    	/************************************************************************************/

    	strcpy(modulo,"ValidaConce");

    	vDTrazasLog(modulo,"\n\t\t***  Inicio Proceso principal  ***", LOG03);

	vDTrazasLog(modulo,"\n\t\t*** Verificacion de Impuestos en Cero***\n", LOG03);


    	vDTrazasLog(modulo,"\n\t\t*** Inicio del Cargado de Estructuras***\n", LOG03);


	if (!bfnCargaEstructuras())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la carga de las Estructuras***\n", LOG01);
	        return (FALSE);
	}
	vDTrazasLog(modulo,"\n\t\t*** Inicio Ejecucion Generacion de Reportes***\n", LOG03);


	if (!bfnGeneraReporte())
	{
		vDTrazasLog  (modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de la Generacion de reporte***\n", LOG01);
		vDTrazasError(modulo,"\n\t*** ATENCION ***\n\t\t\t Error en la ejecucion de la Generacion de reporte***\n", LOG01);
	        return (FALSE);
	}
	
	
	if (stTrazaProc.lCodCiclFact > 0)
	{
		
		printf ("\tEntro al traza final \n");
		if (!bfnSelectSysDate(szSysDate))
			vDTrazasLog(modulo,"\n\t*** Error en bfnSelectSysDate (Main) ***\n",LOG01); 
		else
		{
			stTrazaProc.iCodEstaProc       	= iPROC_EST_OK; /* 3 ; */
			strcpy(stTrazaProc.szFecTermino	,szSysDate);
			strcpy(stTrazaProc.szGlsProceso	,"Proceso Validacion de Conceptos Terminado OK");
			stTrazaProc.lCodCliente        	= 0  ;
			stTrazaProc.lNumAbonado        	= 0  ;
			stTrazaProc.lNumRegistros      	= 0  ;
			stTrazaProc.iCodProceso      	= iCODPROCVALIDACONCE;
			
			bPrintTrazaProc(stTrazaProc);
			if (!bfnUpdateTrazaProc(stTrazaProc))
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
	sprintf(szArchivo,"ValidaConce");

	pathDir=(char *)malloc(128);
	pathDir=szGetEnv("XPF_LOG");
	sprintf(szPath,"%s/ValidaConce/%s",pathDir,cfnGetTime(2));
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


	vDTrazasLog(modulo, "%s << Inicio de ValidaConce >>" , LOG03, cfnGetTime(1));

	return 0;


} /* Fin ifnAbreArchivosLog  */
