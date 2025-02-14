
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
           char  filnam[23];
};
static struct sqlcxp sqlfpn =
{
    22,
    "./pc/Enl_Comisiones.pc"
};


static unsigned int sqlctx = 221113219;


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

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{12,4128,2,27,0,
5,0,0,1,202,0,3,79,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
28,0,0,2,71,0,5,104,0,0,1,1,0,1,0,1,97,0,0,
47,0,0,3,51,0,2,175,0,0,1,1,0,1,0,1,97,0,0,
66,0,0,4,66,0,5,192,0,0,1,1,0,1,0,1,97,0,0,
85,0,0,5,69,0,4,217,0,0,2,1,0,1,0,2,3,0,0,1,97,0,0,
108,0,0,6,48,0,1,352,0,0,0,0,0,1,0,
123,0,0,7,0,0,30,400,0,0,0,0,0,1,0,
};


/************************************************************************/
/* Programa encargado de generar registros de tabla de enlaces          */
/*----------------------------------------------------------------------*/
/* Version 2 - Revision 00.                                             */
/* Inicio: Miercoles 10 de Julio de 2002 .                                 */
/* Fin:                                                                 */
/* Autor : Nelson Contreras Helena                                      */
/************************************************************************/
/* Modificacion por PGonzaleg                                           */
/* Inicio: Lunes 2 de diciembre de 2002.                                */
/* Fin:    Lunes 2 de diciembre de 2002.                                */
/* Autor : Patricio Gonzalez Gomez                                      */
/* Modificacion de condiciones en los WHERE referentes a la tabla       */
/* CMD_PARAMETROS. Cambio en los campos COD_TIPCODIGO, COD_CODIGO y     */
/* COD_PARAMETRO.                                                       */
/************************************************************************/
/* 200309256 Marcelo Quiroz G. Versionado Cuzco.                        */
/* Se normalizan nombres de funciones y de variables                    */
/* Se incorporan campo Id_Periodo en la tabla CM_ENLACEHIST_TO          */
/*                                                                      */
/* 2004-05-12	Manuel Garcia G HD-200403020315                         */
/* ============================================                         */
/* Se agrega filtro para que considere solo los parámetros que tienen   */
/* relación con las tablas y los históricos, es decir, se agrega        */
/* COD_TIPCODIGO = 0 en la query que obtiene el nombre físico y lógico  */
/* de las tablas del proceso de comisiones al insertar y actualizar en  */
/* la tabla CM_ENLACEHIST_TO, de la función iGeneraEnlace del proceso   */
/* Enl_Comisiones. Se actualiza Version a CUZCO 4.0.1                   */
/************************************************************************/
/************************************************************************/

/*---------------------------------------------------------------------------*/
/* Inclusion de libreria para definiciones generales del programa.           */
/*---------------------------------------------------------------------------*/
#include "Enl_Comisiones.h"
#include "GEN_biblioteca.h"
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

/* EXEC SQL WHENEVER SQLERROR DO vSqlError(); */ 

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales para ser usadas con Oracle.              */
/*---------------------------------------------------------------------------*/
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	char    szhUser[30]="";
	char    szhPass[30]="";
	char    szhSysDate [17]="";
	char    szFechaYYYYMMDD[9]="";
	int     iAccion;
/* EXEC SQL END DECLARE SECTION; */ 

/*---------------------------------------------------------------------------*/
/* Genera registros en tabla CM_ENLACEHIST_TO                                */
/*---------------------------------------------------------------------------*/
int iGeneraEnlace(int iAccion)
{
    int iExiste;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         char szhNomLogico[30];
         char szhNomFisico[30];
         char szhIdPeriodo[11];
		 long lhCodPeriodo;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhCodPeriodo       = stCiclo.lCodCiclComis;
    strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);
        
    /*----------------------------------------------*/
    /*  Accion INICIO                               */       
    /*----------------------------------------------*/
    if ( iAccion == INICIO )
    {
       fprintf(pfLog,  "iAccion....INICIO [%ld]\n\n", iAccion);  
       iExiste = iExisteRegistro();     
       
       if (iExiste )
       {                   
          /* EXEC SQL INSERT INTO CM_ENLACEHIST_TO 
                   (COD_PERIODO  , ID_PERIODO   , NOM_LOGICO)
             SELECT :lhCodPeriodo, :szhIdPeriodo, DES_PARAMETRO1
               FROM CMD_PARAMETROS
              /oWHERE COD_CODIGO    = 14 o/		/o MGG - HOMOLOGACION HD-200403020315 o/
              WHERE COD_TIPCODIGO = 0 
              AND	COD_CODIGO    = 14
              AND   TIP_PARAMETRO =  2 
              AND   COD_PARAMETRO >  0; */ 

{
          struct sqlexd sqlstm;
          sqlstm.sqlvsn = 12;
          sqlstm.arrsiz = 2;
          sqlstm.sqladtp = &sqladt;
          sqlstm.sqltdsp = &sqltds;
          sqlstm.stmt = "insert into CM_ENLACEHIST_TO (COD_PERIODO,ID_PERIOD\
O,NOM_LOGICO)select :b0 ,:b1 ,DES_PARAMETRO1  from CMD_PARAMETROS where (((COD\
_TIPCODIGO=0 and COD_CODIGO=14) and TIP_PARAMETRO=2) and COD_PARAMETRO>0)";
          sqlstm.iters = (unsigned int  )1;
          sqlstm.offset = (unsigned int  )5;
          sqlstm.cud = sqlcud0;
          sqlstm.sqlest = (unsigned char  *)&sqlca;
          sqlstm.sqlety = (unsigned short)256;
          sqlstm.occurs = (unsigned int  )0;
          sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPeriodo;
          sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
          sqlstm.sqhsts[0] = (         int  )0;
          sqlstm.sqindv[0] = (         short *)0;
          sqlstm.sqinds[0] = (         int  )0;
          sqlstm.sqharm[0] = (unsigned long )0;
          sqlstm.sqadto[0] = (unsigned short )0;
          sqlstm.sqtdso[0] = (unsigned short )0;
          sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodo;
          sqlstm.sqhstl[1] = (unsigned long )11;
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
          if (sqlca.sqlcode < 0) vSqlError();
}


                
          if ( sqlca.sqlcode != SQLOK )
          {
             fprintf(pfLog,  "Error en insercion CM_ENLACEHIST_TO : ORACLE-> %d ",sqlca.sqlcode);  
             exit(EXIT_202);
          }
       }
       return TRUE;
    } /* Fin INICIO */

    /*----------------------------------------------*/
    /*  Accion PROCESO                              */       
    /*----------------------------------------------*/
    if ( iAccion == PROCESO )
    {
       fprintf(pfLog,  "iAccion....PROCESO [%ld]\n\n", iAccion);
       /* EXEC SQL UPDATE CM_ENLACEHIST_TO 
             SET NOM_FISICO = NOM_LOGICO
       WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 2;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update CM_ENLACEHIST_TO  set NOM_FISICO=NOM_LOGICO whe\
re ID_PERIODO=:b0";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )28;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
       sqlstm.sqhstl[0] = (unsigned long )11;
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
       if (sqlca.sqlcode < 0) vSqlError();
}


                
       if ( sqlca.sqlcode != SQLOK )
       {
           fprintf(pfLog,  "Error en UPDATE CM_ENLACEHIST_TO en PROCESO : ORACLE-> %d ",sqlca.sqlcode);  
           exit(EXIT_203);                
       }
       return TRUE;
    } /* Fin PROCESO */

    /*----------------------------------------------*/
    /*  Accion CERRADO                              */       
    /*----------------------------------------------*/
/*    if ( iAccion == CERRADO )
    {
       fprintf(pfLog,  "iAccion....CERRADO [%ld]\n\n", iAccion);
       EXEC SQL DECLARE Cursor1 CURSOR FOR
            SELECT DES_PARAMETRO1,DES_PARAMETRO2
              FROM CMD_PARAMETROS
             WHERE COD_TIPCODIGO = 0 
			   AND COD_CODIGO    = 14 
			   AND TIP_PARAMETRO =  2  
			   AND COD_PARAMETRO >  0;
                     
       EXEC SQL OPEN Cursor1 ;
                        
       if ( sqlca.sqlcode != SQLOK )
       {
           fprintf(pfLog,  "Error en Open Cursor sobre CM_ENLACEHIST_TO en CIERRE : ORACLE-> %d ",sqlca.sqlcode);  
           exit(EXIT_203);
       }
       
       while (1)
       {
           EXEC SQL FETCH Cursor1 INTO
                    :szhNomLogico,
                    :szhNomFisico;
                
           if ( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
           {
               fprintf(pfLog,  "Error en FETCH en CM_ENLACEHIST_TO en CIERRE : ORACLE-> %d ",sqlca.sqlcode);  
               exit(EXIT_203);                 
           }
                
           if (sqlca.sqlcode == SQLNOTFOUND )  break;
                                        
           strcpy(szhNomFisico,szfnTrim(szhNomFisico));
           strcpy(szhNomLogico,szfnTrim(szhNomLogico));
                                           
           EXEC SQL UPDATE CM_ENLACEHIST_TO 
                SET NOM_FISICO = :szhNomFisico
              WHERE NOM_LOGICO = :szhNomLogico
              AND   ID_PERIODO = :szhIdPeriodo;
                
           if ( sqlca.sqlcode != SQLOK )
           {
               fprintf(pfLog,  "Error en UPDATE CM_ENLACEHIST_TO en CIERRE : ORACLE-> %d ",sqlca.sqlcode);  
               exit(EXIT_203);                 
           }
        }
        return TRUE;
    } *//* Fin CERRADO */

    /*----------------------------------------------*/
    /*  Accion REVERSA_SELECCION                    */       
    /*----------------------------------------------*/
    if ( iAccion == REVERSA_SELECCION )
    {
       fprintf(pfLog,  "iAccion....REVERSA_SELECCION [%ld]\n\n", iAccion);
       /* EXEC SQL DELETE FROM CM_ENLACEHIST_TO 
          WHERE ID_PERIODO = :szhIdPeriodo; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 2;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "delete  from CM_ENLACEHIST_TO  where ID_PERIODO=:b0";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )47;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
       sqlstm.sqhstl[0] = (unsigned long )11;
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
       if (sqlca.sqlcode < 0) vSqlError();
}


                
       if ( sqlca.sqlcode != SQLOK )
       {
           fprintf(pfLog,  "Error en UPDATE CM_ENLACEHIST_TO en REVERSA_SELECCION  : ORACLE-> %d ",sqlca.sqlcode);  
           exit(EXIT_203);
       }
       return TRUE;
     } /* Fin REVERSA_SELECCION  */

    /*----------------------------------------------*/
    /*  Accion REVERSA_LIQUIDACION                  */       
    /*----------------------------------------------*/
    if ( iAccion == REVERSA_LIQUIDACION )
    {
       fprintf(pfLog,  "iAccion....REVERSA_LIQUIDACION [%ld]\n\n", iAccion);             
       /* EXEC SQL UPDATE CM_ENLACEHIST_TO 
            SET NOM_FISICO = NULL
      WHERE ID_PERIODO     = :szhIdPeriodo; */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 2;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "update CM_ENLACEHIST_TO  set NOM_FISICO=null  where ID\
_PERIODO=:b0";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )66;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)szhIdPeriodo;
       sqlstm.sqhstl[0] = (unsigned long )11;
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
       if (sqlca.sqlcode < 0) vSqlError();
}


                
      if ( sqlca.sqlcode != SQLOK )
      {
         fprintf(pfLog,  "Error en UPDATE CM_ENLACEHIST_TO en REVERSA_LIQUIDACION : ORACLE-> %d ",sqlca.sqlcode);  
         exit(EXIT_203);
      }
      return TRUE;
    } /* Fin REVERSA_LIQUIDACION */
}

/*---------------------------------------------------------------------------*/
/* Consuta registro en tabla CM_ENLACEHIST_TO                                */
/*---------------------------------------------------------------------------*/
int  iExisteRegistro()
{
    /* EXEC SQL BEGIN DECLARE SECTION; */ 

         int  iCont        = 0;
         char szhIdPeriodo[11];
    /* EXEC SQL END DECLARE SECTION; */ 

    
	strcpy(szhIdPeriodo, stCiclo.szIdCiclComis);

    /* EXEC SQL SELECT COUNT(*) 
        INTO :iCont
        FROM CM_ENLACEHIST_TO
       WHERE ID_PERIODO  = :szhIdPeriodo; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(*)  into :b0  from CM_ENLACEHIST_TO where ID\
_PERIODO=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )85;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&iCont;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhIdPeriodo;
    sqlstm.sqhstl[1] = (unsigned long )11;
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
    if (sqlca.sqlcode < 0) vSqlError();
}


                
    if ( iCont )
    {            
         fprintf(pfLog, "Registros ya existen en CM_ENLACEHIST_TO para periodo [%s]",szhIdPeriodo);  
         return FALSE;
    }

    if ( sqlca.sqlcode == SQLOK || sqlca.sqlcode == SQLNOTFOUND )
       return TRUE;
    else
       return FALSE;
}

/*---------------------------------------------------------------------------*/
/* Rutina principal.                                                         */
/*---------------------------------------------------------------------------*/
int     main (int argc, char *argv[])
{
/*---------------------------------------------------------------------------*/
/* Variables Globales.                                                       */
/*---------------------------------------------------------------------------*/
    long    lSegIni, lSegFin ;
    short   ibiblio;   
/*---------------------------------------------------------------------------*/
/* Inicializacion de estructura de argumentos externos, de estadistica del   */
/* proceso y de alguna otra estructura.                                      */
/*---------------------------------------------------------------------------*/
     memset(&stCiclo     , 0, sizeof(reg_ciclo));  
     memset(&stStatusProc, 0, sizeof(rg_estadistica));
/*     memset(&proceso, 0, sizeof(proceso));*/
/*---------------------------------------------------------------------------*/
/* Manejo de argumentos ingresados como parametros externos.                 */
/*---------------------------------------------------------------------------*/
     memset(&stArgs, 0, sizeof(rg_argumentos));
     vManejaArgs(argc, argv);
        
     if ( !strcmp(stArgs.szBloque,SEL_MENSUAL) )     iAccion = INICIO;        
     if ( !strcmp(stArgs.szBloque,LIQ_MENSUAL) )     iAccion = PROCESO;        
     if ( !strcmp(stArgs.szBloque,CIE_MENSUAL) )     iAccion = CERRADO;        
     if ( !strcmp(stArgs.szBloque,REV_SELECCION) )   iAccion = REVERSA_SELECCION;        
     if ( !strcmp(stArgs.szBloque,REV_LIQUIDACION) ) iAccion = REVERSA_LIQUIDACION;        
/*---------------------------------------------------------------------------*/
/* Conexion a la base de datos Oracle.                                       */
/*---------------------------------------------------------------------------*/
	fprintf(stderr, "\nstArgs.szUser        [%s]\n", stArgs.szUser);
	fprintf(stderr, "\nstArgs.szPass        [%s]\n", stArgs.szPass);
	
	strcpy(szhUser, stArgs.szUser);                                                      
	strcpy(szhPass, stArgs.szPass);                                                    
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
/* Inicia estructura de proceso y bloques.                                   */
/*---------------------------------------------------------------------------*/
    vInicia_Estructura_Procesos(stArgs.szBloque, stArgs.szProceso,szhUser, stArgs.izSecuencia);
    ibiblio = iAccesa_Traza_Procesos(ABRIR_TRAZA,0,"",0,0);
    if (ibiblio)
    {
        fprintf(stderr, "Error al Abrir Traza");
        fprintf(stderr, "Error [%d] al escribir Traza de Proceso.\n", ibiblio);
        exit(ibiblio);
    }        
/*---------------------------------------------------------------------------*/
/* Configuracion de idioma espanol para tratamiento de fechas.               */
/*---------------------------------------------------------------------------*/
    if(strcmp(getenv("LC_TIME"), LC_TIME_SPANISH) == 0)
    {
        setlocale(LC_TIME, LC_TIME_SPANISH);
    }
/*---------------------------------------------------------------------------*/
/* Preparacion de ambiente para archivos de log y datos.                     */
/*---------------------------------------------------------------------------*/
    fprintf(stderr, "Preparando ambiente para archivos de log, de datos y de configuracion ...\n");
    if((pszEnvLog = (char *)pszEnviron("XPCM_LOG", "")) == (char *)NULL)
    {
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_LOG NO RECONOCIDA.",0,0));
    }
    if((pszEnvCfg = (char *)pszEnviron("XPCM_CFG", "")) == (char *)NULL)
    {
         exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_401,"VARIABLE DE AMBIENTE XPCM_CFG NO RECONOCIDA.",0,0));
    }
       
    fprintf(stderr, "Directorio de Logs         : [%s]\n", (char *)pszEnvLog);
/*------------------------------------------------------------*/        
/* Ingresa parametros para estructura que crea archivo de Log */
/*------------------------------------------------------------*/      
	strncpy(szFechaYYYYMMDD,szfnObtieneFecYYYYMMDD(),8);
        strncpy(szhSysDate, pszGetDateLog(),16);                                                            
	strcpy(stArgsLog.szProceso,LOGNAME);                                                                     
	strncpy(stArgsLog.szSysDate,szhSysDate,16);                                                                 
	sprintf(stArgsLog.szPath,"%s%s/%s",pszEnvLog,stArgsLog.szProceso,szFechaYYYYMMDD);                       
	strcpy(szLogName, stArgsLog.szPath);                                                                  
	
	if((pfLog = fAbreArchivoLog()) == (FILE *)NULL)                                                          
	{                                                                                                        
	    fprintf(stderr, "\nArchivo [%s] no pudo ser abierto.\n", szLogName);                                 
	    fprintf(stderr, "Revise su existencia.\n");                                                          
	    fprintf(stderr, "Error Numero: %d     %s\n", errno, strerror(errno));                                
	    fprintf(stderr, "Proceso finalizado con error.\n");                                                  
        exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,EXIT_301,"ARCHIVO DE DATOS NO PUDO SER ABIERTO.",0,0));
	}                                                                                                                   
/*---------------------------------------------------------------------------*/
/* Recuperacion del tiempo de inicio del proceso, en segundos.               */
/*---------------------------------------------------------------------------*/
    lSegIni=lGetTimer();
/*---------------------------------------------------------------------------*/
/* Header.                                                                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();                                                               
    fprintf(stderr, "Procesando ...\n");                                        
    fprintf(pfLog, "%s\n", szRaya);                    
    fprintf(pfLog, "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog, "%s\n", GLOSA_PROG);                
    fprintf(pfLog, "VERSION %s\n", PROG_VERSION);      
    fprintf(pfLog, "Ultima Revision: [%s]\n", LAST_REVIEW);                
    fprintf(pfLog, "%s\n\n", szRaya);                  

    fprintf(pfLog, "\n Argumentos de Ejecucion\n");
    fprintf(pfLog, "Identificador de Ciclo 			<%s>\n", stArgs.szIdPeriodo);
    
/*---------------------------------------------------------------------------*/
/* Modificacion de configuracion ambiental, para manejo de fechas en Oracle. */
/*---------------------------------------------------------------------------*/
    /* EXEC SQL ALTER SESSION SET NLS_DATE_FORMAT='dd-mm-yyyy'; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "alter SESSION SET NLS_DATE_FORMAT = 'dd-mm-yyyy'";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )108;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
}


/*---------------------------------------------------------------------------*/
/* CARGA ESTRUCTURA CICLOS DE PROCESO                                        */
/*---------------------------------------------------------------------------*/    
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Carga estructura de ciclo de proceso...\n\n");       
    fprintf(stderr, "Carga estructura de ciclo de proceso...\n\n");       
    if (!vCargaCiclo(stArgs.szIdPeriodo,&stCiclo))    
    {
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	fprintf(pfLog, "\n\n[Main] Ciclo que pretende Ejecutar no existe.\n");
    	fprintf(pfLog, "[Main] Se cancela la ejecucion.\n");
    	exit(EXIT_101);
    }
    fprintf(pfLog,  "Cod_Periodo           :%d\n",stCiclo.lCodCiclComis);
    fprintf(pfLog,  "Id_Periodo            :%s\n",stArgs.szIdPeriodo);
    fprintf(pfLog,  "Fecha Inicio          :%s\n",stCiclo.szFecDesdeAceptacion);
    fprintf(pfLog,  "Fecha de Termino      :%s\n",stCiclo.szFecHastaAceptacion);
    fprintf(pfLog,  "Fecha YYYYMMDD        :%s\n",szFechaYYYYMMDD);    
/*---------------------------------------------------------------------------*/
/*    - Genera registros tablas de enlace.                                   */
/*---------------------------------------------------------------------------*/
    vFechaHora();
    fprintf(pfLog,  "\n\n%s\n", (char *)pszFechaHora());
    fprintf(pfLog,  "Genera enlace segun accion...\n\n");       
    fprintf(stderr, "Genera enlace segun accion...\n\n");       
    iGeneraEnlace(iAccion);           
/*---------------------------------------------------------------------------*/
/* Recuperacion de los segundos reales ocupados por el proceso.              */
/*---------------------------------------------------------------------------*/ 
    lSegFin=lGetTimer();
    stStatusProc.lSegProceso = lSegFin - lSegIni;
/*---------------------------------------------------------------------------*/
/* Despliegue de la informacion estadistica del proceso.                     */
/*---------------------------------------------------------------------------*/    
	fprintf(pfLog, "Estadistica del proceso\n");
	fprintf(pfLog, "------------------------\n");
	fprintf(pfLog, "Segundos Reales Utilizados     : [%d]\n\n", stStatusProc.lSegProceso);

	fprintf(stderr, "Estadistica del proceso\n");
	fprintf(stderr, "------------------------\n");
	fprintf(stderr, "Segundos Reales Utilizados    : [%d]\n\n", stStatusProc.lSegProceso);
/*---------------------------------------------------------------------------*/
    ibiblio = iAccesa_Traza_Procesos(CERRAR_TRAZA_OK,EXIT_0,"",stStatusProc.lSegProceso,0);
    if (ibiblio)
       exit(iAccesa_Traza_Procesos(CERRAR_TRAZA_NOK,ibiblio,"ERROR CERRANDO TRAZA.",0,0));
    /* EXEC SQL COMMIT WORK RELEASE; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )123;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
    if (sqlca.sqlcode < 0) vSqlError();
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

