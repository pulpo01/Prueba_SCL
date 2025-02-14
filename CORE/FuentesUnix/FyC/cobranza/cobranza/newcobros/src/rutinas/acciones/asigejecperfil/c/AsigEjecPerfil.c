
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
static const struct sqlcxp sqlfpn =
{
    22,
    "./pc/AsigEjecPerfil.pc"
};


static unsigned int sqlctx = 220754507;


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
{12,4138,1,0,0,
5,0,0,1,135,0,4,91,0,0,4,3,0,1,0,2,5,0,0,1,3,0,0,1,5,0,0,1,97,0,0,
36,0,0,2,101,0,4,107,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
59,0,0,3,289,0,4,132,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
86,0,0,4,59,0,5,164,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
};


/* ============================================================================= 
Tipo        :  ACCION
Nombre      :  AsigEjecPerfil.pc ("AEPER"->szfnAsigEjecPerfil)
Descripcion :  ASIGna un EJECutivo de acuerdo al PERFIL del cliente
               a todos los abonados del cliente dado
Recibe      :  by Val -> Cod Cliente 
Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
               "NOAGE"-> Fue imposible asignar un agente (entidad)
               "NODIR"-> Fue imposible determinar la direccion (comuna) del cliente
               "OK"   -> La accion se ejecuto correctamente
Autor       :  Roy Barrera Richards
Fecha       :  10 - Agosto - 2000 
================================================================================
MGG 07-01-2003	Se agrega funcionalidad para tratamiento de cobranza a nivel de cuenta o cliente	
17-08-2004  GAC.  Homologacion a Incidencia XC-200406200056
Modificacion    :  12-11-2004
						 Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
================================================================================ */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "AsigEjecPerfil.h"
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


/* ============================================================================= */
/* funcion de asignacion de ejecutivo(a) por Perfil  */
/* ============================================================================= */
char  *szfnAsigEjecPerfil(FILE **ptArchLog,  long lCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente  = 0;
	long lhCodVendedor = 0;
	char szhFecTope    [9];	/* EXEC SQL VAR szhFecTope IS STRING (9); */ 

	char szhNomEjec   [31];	/* EXEC SQL VAR szhNomEjec IS STRING (31); */ 

	short shNomEjec       ; /* Homol. a XC-0056 GAC*/
	/* Vbles Bind */
	char szhDDMMYYYY [9];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "szfnAsigEjecPerfil";
char szValParametro[21];
int  iRet = 0;
FILE *pfLog = *ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

	memset( szValParametro, '\0', sizeof( szValParametro ) );
	memset( szhFecTope, '\0', sizeof( szhFecTope ) );
	memset( szhNomEjec, '\0', sizeof( szhNomEjec ) );

	strcpy(szhDDMMYYYY,"DDMMYYYY");
	lhCodCliente = lCliente;

  	/* obtenemos la entidad a la cual va dirigida la Cobranza Externa */
   if (ifnRecuperaGedParametro(&pfLog, "ENTIDAD_GESTION_COB", szMODULOCOBRANZA, szValParametro, CXX )!=0) 
    	return "ERENC";

	rtrim( szValParametro );

	if( !strcmp( szValParametro, szENTIDADCLIENTE ) )	/* la cobranza esta dirigida al cliente */
	{
	    /* Verificar si existen otros clientes de la cuenta, con agente asignado */    
	    iRet = ifnAsigEjecCliente(&pfLog, lCliente, "S", CXX );
	    if ( iRet < 0 )
	        return "EJEIN";		/* Fallo por error oracle */
	    else if( iRet == 1 )
	        return "OK";		/* Asigno mismo ejecutivo que los otros clientes del mismo rut y operadora */
	}
	else												/* la cobranza esta dirigida  ala cuenta */
	{
	    /*-- Verificar si el rut de este cliente ya tiene algun agente asignado --*/    
	    iRet = ifnAsigEjecRut(&pfLog, lCliente, CXX );
	    if( iRet < 0 )
	        return "EJEIN";		/* Fallo por error oracle */
	    else if( iRet == 1 )
	        return "OK";		/* Asigno mismo ejecutivo que los otros clientes del mismo rut */
	}

	/* se debe asignar ejecutivo segun corresponda */    
    strcpy( szhFecTope, "31123000" ); /* Fecha tope lejana, idem concepto de fecha nula */

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL
	SELECT NOM_EJECUTIVO
	INTO  :szhNomEjec
	FROM  CO_CATCUENTAS
	WHERE COD_CLIENTE = :lhCodCliente
	AND ( FEC_HASTA IS NULL OR ( TRUNC( FEC_HASTA ) = TO_DATE( :szhFecTope, :szhDDMMYYYY ) ) ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select NOM_EJECUTIVO into :b0  from CO_CATCUENTAS where (COD\
_CLIENTE=:b1 and (FEC_HASTA is null  or TRUNC(FEC_HASTA)=TO_DATE(:b2,:b3)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNomEjec;
 sqlstm.sqhstl[0] = (unsigned long )31;
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecTope;
 sqlstm.sqhstl[2] = (unsigned long )9;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhDDMMYYYY;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] CO_CATCUENTAS => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "ERSEL";     
    }
    else if( sqlca.sqlcode == SQLNOTFOUND )
    {
        /* no lo encontro en co_catcuenta, verificar si es gran cliente */
		sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
		/* EXEC SQL
		SELECT COD_VENDEDOR
		  INTO :lhCodVendedor
		  FROM VE_VENDCLIENTE
		 WHERE COD_CLIENTE = :lhCodCliente 
		   AND FEC_DESASIGNAC IS NULL ; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 4;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_VENDEDOR into :b0  from VE_VENDCLIENTE where (CO\
D_CLIENTE=:b1 and FEC_DESASIGNAC is null )";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )36;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodVendedor;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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
  sqlstm.sqphsv = sqlstm.sqhstv;
  sqlstm.sqphsl = sqlstm.sqhstl;
  sqlstm.sqphss = sqlstm.sqhsts;
  sqlstm.sqpind = sqlstm.sqindv;
  sqlstm.sqpins = sqlstm.sqinds;
  sqlstm.sqparm = sqlstm.sqharm;
  sqlstm.sqparc = sqlstm.sqharc;
  sqlstm.sqpadto = sqlstm.sqadto;
  sqlstm.sqptdso = sqlstm.sqtdso;
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


           
        if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
        {
            ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] VE_VENDCLIENTE => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
            return "ERSEL";     
        }
        else if ( sqlca.sqlcode == SQLNOTFOUND )
        {
           /* no lo encontro, no es gran cliente tampoco, por lo tanto es Natural, llama a AEJCS jlr_30.10.00 */
				return (char*) szfnAsigEJecCobSuc(&pfLog, lhCodCliente, CXX );
        }
        else
        {
            /* Lo encontro, por lo tanto es Gran Cliente*/
            ifnTrazaHilos( modulo,&pfLog, "lhCodVendedor => [%ld].", LOG05, lhCodVendedor );  
            
				/* Homol. a XC-0056 GAC*/
				
				sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
				/* EXEC SQL 
				SELECT MIN(U.NOM_USUARIO)
			   INTO  :szhNomEjec:shNomEjec
			   FROM  GE_SEG_USUARIO U, GE_VIG_USUARIO V
			   WHERE U.COD_VENDEDOR = :lhCodVendedor
			   AND   V.NOM_USUARORA = U.NOM_USUARIO
			   AND   V.FEC_CREACION = (SELECT MAX(Y.FEC_CREACION)
						   					FROM GE_SEG_USUARIO X, GE_VIG_USUARIO Y
						  						WHERE X.COD_VENDEDOR = :lhCodVendedor	
						    					AND Y.NOM_USUARORA = X.NOM_USUARIO); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 4;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select min(U.NOM_USUARIO) into :b0:b1  from GE_SEG_USUARI\
O U ,GE_VIG_USUARIO V where ((U.COD_VENDEDOR=:b2 and V.NOM_USUARORA=U.NOM_USUA\
RIO) and V.FEC_CREACION=(select max(Y.FEC_CREACION)  from GE_SEG_USUARIO X ,GE\
_VIG_USUARIO Y where (X.COD_VENDEDOR=:b2 and Y.NOM_USUARORA=X.NOM_USUARIO)))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )59;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhNomEjec;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)&shNomEjec;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodVendedor;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    
				/*if( sqlca.sqlcode == SQLNOTFOUND )
	            {   * no lo encontro, no es gran cliente tampoco, por lo tanto es Natural, llama a AEJCS jlr_30.11.00 */
	            /* Homol. a XC-0056 GAC*/
		    	if (shNomEjec == ORA_NULL)  {
                /* no lo encontro, no esta en la ge_seg_usuario, llama a AEJCS jlr_30.11.00 */
                ifnTrazaHilos( modulo,&pfLog, "No encontro en GE_SEG_USUARIO Vendedor => [%ld].", LOG05, lhCodVendedor );                
                return (char*) szfnAsigEJecCobSuc(&pfLog, lhCodCliente, CXX );
				
            }    
            
            else if( sqlca.sqlcode )    
            {   
                ifnTrazaHilos( modulo,&pfLog, "Cliente => [%d] GE_SEG_USUARIO => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
                return "ERSEL";      
            }
        }
    } /* if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) */

    ifnTrazaHilos( modulo,&pfLog, "szhNomEjec => [%s].", LOG05, szhNomEjec );  

	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL 
	UPDATE CO_MOROSOS
	   SET COD_AGENTE  = :szhNomEjec
	 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 4;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )86;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNomEjec;
 sqlstm.sqhstl[0] = (unsigned long )31;
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
 sqlstm.sqphsv = sqlstm.sqhstv;
 sqlstm.sqphsl = sqlstm.sqhstl;
 sqlstm.sqphss = sqlstm.sqhsts;
 sqlstm.sqpind = sqlstm.sqindv;
 sqlstm.sqpins = sqlstm.sqinds;
 sqlstm.sqparm = sqlstm.sqharm;
 sqlstm.sqparc = sqlstm.sqharc;
 sqlstm.sqpadto = sqlstm.sqadto;
 sqlstm.sqptdso = sqlstm.sqtdso;
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



    if( sqlca.sqlcode )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Ejecutivo => [%s] Actualizando Agente CO_MOROSOS => [%s].",
								LOG00, lhCodCliente, szhNomEjec, sqlca.sqlerrm.sqlerrmc );  
        return "ERUPD";   
    }

    ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Ejecutivo => [%s] OK.", LOG03, lhCodCliente, szhNomEjec );  
    return "OK";
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

