
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
    "./pc/AsigEJecCobSuc.pc"
};


static unsigned int sqlctx = 220751971;


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

 static const char *sq0002 = 
"select A.COD_AGENTE ,A.PRC_ASIGNACION  from CO_ENTCOB C ,CO_AGENCOB B ,CO_AG\
ENCOMU A where (((A.COD_COMUNA=:b0 and B.COD_AGENTE=A.COD_AGENTE) and C.COD_EN\
TIDAD=B.COD_ENTIDAD) and C.TIP_ENTIDAD='S')           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,155,0,4,91,0,0,2,1,0,1,0,2,97,0,0,1,3,0,0,
28,0,0,2,208,0,9,127,0,0,1,1,0,1,0,1,97,0,0,
47,0,0,2,0,0,13,135,0,0,2,0,0,1,0,2,97,0,0,2,3,0,0,
70,0,0,2,0,0,15,152,0,0,0,0,0,1,0,
85,0,0,3,59,0,5,166,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
108,0,0,4,247,0,4,190,0,0,3,2,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,
135,0,0,5,59,0,5,226,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  ACCION
    Nombre      :  AsigEJecCobSuc.pc ("AEJCS"->szfnAsigEJecCobSuc)
    Descripcion :  ASIGna un EJECutivo de COBranza por SUCursal
                   a todos los abonados del cliente dado
    Recibe      :  by Val -> Cod Cliente 
    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
                   "NOAGE"-> Fue imposible asignar un agente (entidad)
                   "NODIR"-> Fue imposible determinar la direccion (comuna) del cliente
                   "OK"   -> La accion se ejecuto correctamente
    Autor       :  Roy Barrera Richards
    Fecha       :  10 - Agosto - 2000 
Modificacion    :  12-11-2004
						 Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
    
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "AsigEJecCobSuc.h"
#define HOST_ARRAY_AGENTES  500     /* maximo de agentes por sucursal */

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


/****************************************************************************************************/
/* funcion de asignacion de entidad de cobranza de sucursal											*/
/****************************************************************************************************/
char *szfnAsigEJecCobSuc(FILE **ArchLog, long lCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente = 0;
	char szhCodComuna[6];
	char szhCodAgente    [HOST_ARRAY_AGENTES][31];
	int ihPrcAsignado   [HOST_ARRAY_AGENTES];
	int ihMorososAgente [HOST_ARRAY_AGENTES];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "szfnAsigEJecCobSuc";
char szValParametro[21];
int i = 0, iMorososComuna = 0, iPorcentajeTotal = 0, iRet = 0;
long lTotalRows = 0;
float fPorcentajeDefinido = 0.0;
float fPorcentajeActual = 0.0;
FILE *pfLog = *ArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	
	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

	memset( szValParametro, '\0', sizeof( szValParametro ) );
	memset( szhCodComuna, '\0', sizeof( szhCodComuna ) );

   lhCodCliente = lCliente;

	/* obtenemos la entidad a la cual va dirigida la Cobranza Externa */
   if (ifnRecuperaGedParametro(&pfLog, "ENTIDAD_GESTION_COB", "CO", szValParametro, CXX )!=0) 
    	return "ERENC";

	rtrim( szValParametro );

	if( !strcmp( szValParametro, "C" ) )	/* la cobranza esta dirigida al cliente */
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
    /* Obtiene la Comuna del Cliente a partir del cod direccion de la dir de correspondencia */            
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL 
	SELECT A.COD_COMUNA 
	  INTO :szhCodComuna
	  FROM GE_DIRECCIONES A, GA_DIRECCLI B
	 WHERE B.COD_CLIENTE = :lhCodCliente
	   AND B.COD_TIPDIRECCION = 3  
	   AND A.COD_DIRECCION = B.COD_DIRECCION; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select A.COD_COMUNA into :b0  from GE_DIRECCIONES A ,GA_DIRE\
CCLI B where ((B.COD_CLIENTE=:b1 and B.COD_TIPDIRECCION=3) and A.COD_DIRECCION\
=B.COD_DIRECCION)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhCodComuna;
 sqlstm.sqhstl[0] = (unsigned long )6;
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
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] NODIR => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc ); 
        return "NODIR";    
    }

	rtrim( szhCodComuna );
	
	/* Obtiene los agentes de cobranzas de la comuna y sus porcentajes definidos */
	sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
	/* EXEC SQL 
	DECLARE curAgentes CURSOR FOR
	SELECT A.COD_AGENTE,
		   A.PRC_ASIGNACION
	  FROM CO_ENTCOB C,
		   CO_AGENCOB B,
		   CO_AGENCOMU A
	 WHERE A.COD_COMUNA  = :szhCodComuna 
	   AND B.COD_AGENTE  = A.COD_AGENTE
	   AND C.COD_ENTIDAD = B.COD_ENTIDAD
	   AND C.TIP_ENTIDAD = 'S' ; */ 
 /* SUCURSAL */

    if( sqlca.sqlcode )
    {   
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] DECLARE curAgentes => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
		return "ERSEL";   
    }

    /* EXEC SQL OPEN curAgentes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0002;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )28;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodComuna;
    sqlstm.sqhstl[0] = (unsigned long )6;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if (sqlca.sqlcode)
    {   
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] OPEN curAgentes => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
        return "EROPE";   
    }

    sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
    /* EXEC SQL 
    FETCH curAgentes 
     INTO :szhCodAgente, :ihPrcAsignado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )47;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente;
    sqlstm.sqhstl[0] = (unsigned long )31;
    sqlstm.sqhsts[0] = (         int  )31;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqharc[0] = (unsigned long  *)0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)ihPrcAsignado;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[1] = (         int  )sizeof(int);
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqharc[1] = (unsigned long  *)0;
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



    lTotalRows = SQLROWS;    

    if( sqlca.sqlcode < 0 )
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] [Comuna => [%s] FETCH curAgentes => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
        return "ERFET";   
	}
	else if( sqlca.sqlcode != SQLNOTFOUND )	/* verifica no haber llegado al final de los datos */
	{
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] Desbordamiento Array para FETCH curAgentes => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
        return "ERARY";   
	}

    /* EXEC SQL CLOSE curAgentes ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 2;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )70;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if( sqlca.sqlcode )
    {   
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] CLOSE curAgentes => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
        return "ERCLO";   
    }

	if( lTotalRows > 0 ) /* recupero agentes*/
	{
		rtrim( szhCodAgente[0] );

		if( ( ihPrcAsignado[0] == 100 ) ) /*si el primer cliente tiene el 100 % asignado */ 
		{    
			sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
			/* EXEC SQL 
			UPDATE CO_MOROSOS
			   SET COD_AGENTE = :szhCodAgente[0]		/o lo asigna de inmediato o/
			 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 2;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=:b\
1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )85;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente[0];
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
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] UPDATE CO_MOROSOS => [%s].", LOG00, lhCodCliente, szhCodComuna, sqlca.sqlerrm.sqlerrmc );  
				return "ERUPD";            
			}
			else
			{   
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] OK.", LOG03, lhCodCliente, szhCodAgente[0] );  
				return "OK";            
			}
		}            
		else /* el primero no tiene asignado el 100%, buscar entre todos cual asignar */
		{
			for( i = 0; i < lTotalRows; i++ ) /* procesar cada agente (contar sus morosos) */
			{
				rtrim( szhCodAgente[i] );
				rtrim( szhCodComuna );

				sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
				/* EXEC SQL 
				SELECT --+RULE
					   COUNT( A.COD_CLIENTE )   
				  INTO :ihMorososAgente[i]
				  FROM GE_DIRECCIONES C, GA_DIRECCLI B, CO_MOROSOS A
				 WHERE A.COD_AGENTE = :szhCodAgente[i]
				   AND B.COD_CLIENTE = A.COD_CLIENTE
				   AND B.COD_TIPDIRECCION = 3
				   AND C.COD_DIRECCION = B.COD_DIRECCION
				   AND C.COD_COMUNA= :szhCodComuna; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 3;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select  /*+ RULE +*/ count(A.COD_CLIENTE) into :b0  from \
GE_DIRECCIONES C ,GA_DIRECCLI B ,CO_MOROSOS A where ((((A.COD_AGENTE=:b1 and B\
.COD_CLIENTE=A.COD_CLIENTE) and B.COD_TIPDIRECCION=3) and C.COD_DIRECCION=B.CO\
D_DIRECCION) and C.COD_COMUNA=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )108;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihMorososAgente[i];
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodAgente[i];
    sqlstm.sqhstl[1] = (unsigned long )31;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodComuna;
    sqlstm.sqhstl[2] = (unsigned long )6;
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



				if( sqlca.sqlcode )
				{   
					ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] Agente => [%s] COUNT(*) CO_MOROSOS => [%s].", 
											LOG03, lhCodCliente, szhCodComuna, szhCodAgente[i], sqlca.sqlerrm.sqlerrmc );  
					return "ERSEL";
				}

				iMorososComuna += ihMorososAgente[i];      /* Acumula el total de morosos de la comuna */
				iPorcentajeTotal += ihPrcAsignado[i];      /* Suma los porcentajes de cada agente */
			} /* end for 1 */

			if( iPorcentajeTotal != 100 )
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] LA SUMA DE PORCENTAJES NO DA 100%% [%d].", LOG02, lhCodCliente, iPorcentajeTotal );  

			for( i = 0; i < lTotalRows; i++ ) /* procesar cada agente (elegir cual asignar) */
			{
				fPorcentajeDefinido = (float) ihPrcAsignado[i];
				fPorcentajeActual = ( iMorososComuna == 0 ) ? 0.0 : (float)( (100 * (float)ihMorososAgente[i]) / (float)iMorososComuna );

				ifnTrazaHilos( modulo,&pfLog, "i[%d] COD_AGENTE => [%s] fPorcentajeDefinido => [%f] fPorcentajeActual => [%f].",
										LOG05, i, szhCodAgente[i], fPorcentajeDefinido, fPorcentajeActual );  

				if( fPorcentajeDefinido >= fPorcentajeActual )
				{   
					sqlca.sqlcode=0; /* se resetea la vble sql para evitar rebalsamiento de memoria*/
					/* EXEC SQL 
					UPDATE CO_MOROSOS
					   SET COD_AGENTE = :szhCodAgente[i]
					 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 3;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=\
:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )135;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgente[i];
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
						ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] UPDATE CO_MOROSOS => [%s].",
												LOG00, lhCodCliente, szhCodAgente[i], sqlca.sqlerrm.sqlerrmc );  
						return "ERUPD";
					}  

					ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] OK.", LOG00, lhCodCliente, szhCodAgente[i] );  
					return "OK";
				}

				i = lTotalRows;
			} /* end for 2 */
		}
    }        
    
    /* 2 situaciones : ( lTotalRows <= 0 ) o nunca se cumplio que (fPorcentajeDefinido >= fPorcentajeActual )*/
    
    ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s] NOAGE => No se encontraron agentes.", LOG01, lhCodCliente, szhCodComuna );  
    return "NOAGE";
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

