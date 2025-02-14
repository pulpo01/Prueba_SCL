
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
    "./pc/camnum.pc"
};


static unsigned int sqlctx = 861139;


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
   unsigned char  *sqhstv[25];
   unsigned long  sqhstl[25];
            int   sqhsts[25];
            short *sqindv[25];
            int   sqinds[25];
   unsigned long  sqharm[25];
   unsigned long  *sqharc[25];
   unsigned short  sqadto[25];
   unsigned short  sqtdso[25];
} sqlstm = {12,25};

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

 static const char *sq0003 = 
"select  /*+  AK_GA_ABOCEL_CLIENTE  +*/ NUM_ABONADO ,COD_SITUACION ,NUM_CELUL\
AR ,NVL(IND_PLEXSYS,:b0) ,COD_CENTRAL ,NVL(NUM_SERIEHEX,:b1) ,TIP_TERMINAL ,NU\
M_MIN ,COD_TECNOLOGIA ,DECODE(COD_TECNOLOGIA,:b2,NUM_SERIE,:b3) ,NVL(NUM_IMEI,\
:b3) ,DECODE(COD_TECNOLOGIA,:b2,fRecuperSIMCARD_FN(NUM_SERIE,:b6),:b3) IMSI ,C\
O_fGetTipPlanCelular(COD_PLANTARIF)  from GA_ABOCEL where ((COD_CLIENTE=:b8 an\
d COD_USO<>:b9) and COD_SITUACION in (:b10,:b11,:b12)) for update ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,192,0,4,117,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
32,0,0,2,197,0,4,141,0,0,5,3,0,1,0,2,5,0,0,2,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
67,0,0,3,454,0,9,190,0,0,13,13,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
134,0,0,3,0,0,13,199,0,0,13,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
5,0,0,2,5,0,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
201,0,0,4,581,0,3,251,0,0,25,25,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,3,0,0,1,97,0,
0,1,3,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,5,0,0,1,5,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,
5,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,0,1,5,0,0,1,5,0,0,1,97,0,
0,1,5,0,0,
316,0,0,3,0,0,15,284,0,0,0,0,0,1,0,
};


/* =================================================================================================
Tipo        :  ACCION
Nombre      :  camnum.pc ("CANUM")
Descripcion :  Enruta a un nuevo numero de telefono al cliente morosos
Creado en   : 	Proyecto MPR_04008 - Flexibilidad de Enrutamiento.
Autor       :  G.A.C.
Fecha       :  13-Agosto-2004 
Modificacion    :  12-11-2004
						 Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
====================================================================================================*/

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "camnum.h"

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
/* A todos los abonados de un cliente los enruta a un nuevo telefono             */
/* de servicio de cobranza                                                       */
/* ============================================================================= */
char  *szfnCambioNumero(FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long lhCodCliente       = 0;
	char szhCodCauSusp   [4];			   /* EXEC SQL VAR szhCodCauSusp IS STRING (4); */ 

	int  ihCodActuacion     = 0;
	long lhNumAbonado       = 0;
	char szhCodSituacion [4];		      /* EXEC SQL VAR szhCodSituacion IS STRING (4); */ 

	long lhNumCelular       = 0;
	int  ihIndPlexsys       = 0;
	int  ihCodCentral       = 0;
	char szhNumSerieHex  [9];			   /* EXEC SQL VAR szhNumSerieHex IS STRING (9); */ 
  
	char szhTipTerminal  [2];		   	/* EXEC SQL VAR szhTipTerminal IS STRING(2); */ 

	int  ihNumMin           = 0;
	long lhNumSecuencia		= 0;
	char szhCodTecnologia[iLENCODTECNO];/* EXEC SQL VAR szhCodTecnologia IS STRING (iLENCODTECNO); */ 

	char szhNumSerie[iLENNUMSERIE];		/* EXEC SQL VAR szhNumSerie IS STRING (iLENNUMSERIE); */ 

	char szhNumImei[iLENNUMIMEI];		   /* EXEC SQL VAR szhNumImei IS STRING (iLENNUMIMEI); */ 

	char szhNumImsi[iLENNUMIMSI];		   /* EXEC SQL VAR szhNumImsi IS STRING (iLENNUMIMSI); */ 

	char szhCodTiPlan[9];			      /* EXEC SQL VAR szhCodTiPlan IS STRING (9); */ 

	char szhCod_Param  [16];       /* EXEC SQL VAR szhCod_Param IS STRING (16); */ 

	char szhCodActAbo[3];
	char szhParamExcluidor[16];/* vble global usada por ejecutor*/
	/* Variables Bind */
	int  ihValor_Cero  = 0;
	int  ihValor_Uno   = 1;
	int  ihValor_Tres  = 3;
	char szhValor_0[2];
	char szhModulo [3];
	char szhERA    [4];
	char szhGSM    [4];
	char szhIMSI   [5];
	char szhAAA    [4];
	char szhSAA    [4];
	char szhFiller [2];
	char szhCANUM  [6];
	char szhEPR    [4];
	char szhLetra_S[2];
	char szhPENDIENTE [10];
	int	ihCntTemp;
	char  szhLetra_T [2];
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char modulo[] = "szfnCambioNumero";
int iError = 0, iResul = 0;
char szCodEstado[3];
char szValRetorno[4];
struct sqlca sqlca;
FILE *pfLog=*ptArchLog;

	strcpy(szhParamExcluidor,szParamExclu);
	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

	memset( szhCodCauSusp, '\0', sizeof( szhCodCauSusp ) );
	memset( szhCodSituacion, '\0', sizeof( szhCodSituacion ) );
	memset( szhNumSerieHex, '\0', sizeof( szhNumSerieHex ) );
	memset( szhTipTerminal, '\0', sizeof( szhTipTerminal ) );
	memset( szValRetorno, '\0', sizeof( szValRetorno ) );
	memset( szhCodTecnologia, '\0', sizeof( szhCodTecnologia ) );
	memset( szhNumSerie, '\0', sizeof( szhNumSerie ) );
	memset( szhNumImei, '\0', sizeof( szhNumImei ) );
	memset( szhNumImsi, '\0', sizeof( szhNumImsi ) );
	memset( szhCodTiPlan, '\0', sizeof( szhCodTiPlan ) );
	memset( szhCodActAbo, '\0', sizeof( szhCodActAbo ) );

	/*iAboCeluGlobal = 0;  Cantidad de abonados Celular suspendidos */
	/*iAboBeepGlobal = 0;  Cantidad de abonados Beeper suspendidos */
   strcpy(szhModulo,"CO");
   strcpy(szhERA ,"ERA"); 
   strcpy(szhGSM ,"GSM"); 
	strcpy(szhIMSI,"IMSI");
	strcpy(szhAAA ,"AAA");
	strcpy(szhSAA ,"SAA");	
	strcpy(szhValor_0,"0");
	strcpy(szhFiller," ");
	strcpy(szhCANUM,"CANUM");
	strcpy(szhEPR,"EPR");
	strcpy(szhLetra_S,"S");
	strcpy(szhPENDIENTE,"PENDIENTE");
   strcpy( szCodEstado, "EN" );
	strcpy(szhLetra_T,"T");

   lhCodCliente = lCliente;
   ifnTrazaHilos( modulo,&pfLog, "En funcion %s con Cliente => [%ld].", LOG05, modulo, lhCodCliente );

	/* verifica si algun abonado del cliente se encuentra en un estado temporal 
	if( ( iResul = ifnAbonadosSituacionTemporal(&pfLog, lhCodCliente, CXX ) ) < 0 )
		return "PND";
	if( iResul )	 el cliente presenta abonados en situacion temporal 
		return "PND";*/
	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL
	SELECT COUNT(*)
	INTO  :ihCntTemp
	FROM  GA_ABOCEL G
	WHERE G.COD_CLIENTE = :lhCodCliente
	AND   G.COD_SITUACION IN (SELECT COD_SITUACION
								     FROM  GA_SITUABO
								     WHERE G.COD_SITUACION = COD_SITUACION 
							        AND   TIP_SITUACION = :szhLetra_T ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 3;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(*)  into :b0  from GA_ABOCEL G where (G.COD_CLI\
ENTE=:b1 and G.COD_SITUACION in (select COD_SITUACION  from GA_SITUABO where (\
G.COD_SITUACION=COD_SITUACION and TIP_SITUACION=:b2)))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCntTemp;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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
 sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_T;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

	 /* marca estado temporal */
    
	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )	{   
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], Error comprobando situacion temporal =>[%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "PND";
	}
	if ( ihCntTemp > 0 )	  {
		ifnTrazaHilos( modulo,&pfLog,  "Cliente => [%ld], TIENE ABONADOS CON SITUACION TEMPORAL.", LOG02, lhCodCliente );  
		return "PND";
	}

	/* Selecciona cod_param solo si el proceso precedente es el ejecutor */ 
	if (strcmp(szhParamExcluidor,"0")==0) {
		ifnTrazaHilos( modulo,&pfLog, "Rescatando Cod_param para Ejecutor", LOG03);  
		/* Se agrega query para rescatar parametro de enrutamiento (Proy. MPR_04008) */
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
		SELECT B.COD_PARAM   , B.NUM_SECUENCIA
		INTO   :szhCod_Param , :lhNumSecuencia
		FROM   CO_ACCIONES A, CO_PARAM_ACCIONES B
		WHERE  A.NUM_SECUENCIA= B.NUM_SECUENCIA
		AND    A.COD_CLIENTE  = :lhCodCliente
		AND    A.COD_RUTINA   = :szhCANUM
		AND    A.COD_ESTADO   = :szhEPR; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select B.COD_PARAM ,B.NUM_SECUENCIA into :b0,:b1  from CO_A\
CCIONES A ,CO_PARAM_ACCIONES B where (((A.NUM_SECUENCIA=B.NUM_SECUENCIA and A.\
COD_CLIENTE=:b2) and A.COD_RUTINA=:b3) and A.COD_ESTADO=:b4)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )32;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCod_Param;
  sqlstm.sqhstl[0] = (unsigned long )16;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&lhNumSecuencia;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhCANUM;
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhEPR;
  sqlstm.sqhstl[4] = (unsigned long )4;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


		if (sqlca.sqlcode != SQLOK ) {
	        ifnTrazaHilos( modulo,&pfLog, "Parametro de Enrutamiento  (Cliente:%ld) - %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	        return "PND";    
		}
		strcpy(szhParamExcluidor,szhCod_Param);
		ifnTrazaHilos( modulo,&pfLog, "szhParamExcluidor => [%s].", LOG05, szhParamExcluidor);
		
	} else {
		ifnTrazaHilos( modulo,&pfLog, "Traspasando Cod_param para Excluidor", LOG03);  
		strcpy(szhCod_Param,szhParamExcluidor);
		ifnTrazaHilos( modulo,&pfLog, "szhParamExcluidor => [%s].", LOG05, szhParamExcluidor);
	}

	sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
	/* EXEC SQL DECLARE curAbonados CURSOR FOR 
	SELECT /o+ AK_GA_ABOCEL_CLIENTE o/
		   NUM_ABONADO, 
		   COD_SITUACION, 
		   NUM_CELULAR,
		   NVL( IND_PLEXSYS, :ihValor_Cero ), 
		   COD_CENTRAL,
		   NVL( NUM_SERIEHEX, :szhValor_0),
		   TIP_TERMINAL,
		   NUM_MIN,
		   COD_TECNOLOGIA,
		   DECODE( COD_TECNOLOGIA, :szhGSM,  NUM_SERIE, :szhFiller ),
		   NVL( NUM_IMEI, :szhFiller ), 
		   DECODE( COD_TECNOLOGIA, :szhGSM, fRecuperSIMCARD_FN( NUM_SERIE, :szhIMSI), :szhFiller ) IMSI,
		   CO_fGetTipPlanCelular( COD_PLANTARIF )
	FROM  GA_ABOCEL
	WHERE COD_CLIENTE    = :lhCodCliente
	AND   COD_USO       != :ihValor_Tres /o Amistar o/
	AND   COD_SITUACION IN (:szhAAA,:szhSAA, :szhERA )
	FOR UPDATE ; */ 


   if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )  {   
        ifnTrazaHilos( modulo,&pfLog, "Declare curAbonados (Cliente:%ld) %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND";    
   }
        
   sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
   /* EXEC SQL OPEN curAbonados; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 13;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = sq0003;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )67;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqcmod = (unsigned int )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihValor_Cero;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhValor_0;
   sqlstm.sqhstl[1] = (unsigned long )2;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)szhGSM;
   sqlstm.sqhstl[2] = (unsigned long )4;
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhFiller;
   sqlstm.sqhstl[3] = (unsigned long )2;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhFiller;
   sqlstm.sqhstl[4] = (unsigned long )2;
   sqlstm.sqhsts[4] = (         int  )0;
   sqlstm.sqindv[4] = (         short *)0;
   sqlstm.sqinds[4] = (         int  )0;
   sqlstm.sqharm[4] = (unsigned long )0;
   sqlstm.sqadto[4] = (unsigned short )0;
   sqlstm.sqtdso[4] = (unsigned short )0;
   sqlstm.sqhstv[5] = (unsigned char  *)szhGSM;
   sqlstm.sqhstl[5] = (unsigned long )4;
   sqlstm.sqhsts[5] = (         int  )0;
   sqlstm.sqindv[5] = (         short *)0;
   sqlstm.sqinds[5] = (         int  )0;
   sqlstm.sqharm[5] = (unsigned long )0;
   sqlstm.sqadto[5] = (unsigned short )0;
   sqlstm.sqtdso[5] = (unsigned short )0;
   sqlstm.sqhstv[6] = (unsigned char  *)szhIMSI;
   sqlstm.sqhstl[6] = (unsigned long )5;
   sqlstm.sqhsts[6] = (         int  )0;
   sqlstm.sqindv[6] = (         short *)0;
   sqlstm.sqinds[6] = (         int  )0;
   sqlstm.sqharm[6] = (unsigned long )0;
   sqlstm.sqadto[6] = (unsigned short )0;
   sqlstm.sqtdso[6] = (unsigned short )0;
   sqlstm.sqhstv[7] = (unsigned char  *)szhFiller;
   sqlstm.sqhstl[7] = (unsigned long )2;
   sqlstm.sqhsts[7] = (         int  )0;
   sqlstm.sqindv[7] = (         short *)0;
   sqlstm.sqinds[7] = (         int  )0;
   sqlstm.sqharm[7] = (unsigned long )0;
   sqlstm.sqadto[7] = (unsigned short )0;
   sqlstm.sqtdso[7] = (unsigned short )0;
   sqlstm.sqhstv[8] = (unsigned char  *)&lhCodCliente;
   sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[8] = (         int  )0;
   sqlstm.sqindv[8] = (         short *)0;
   sqlstm.sqinds[8] = (         int  )0;
   sqlstm.sqharm[8] = (unsigned long )0;
   sqlstm.sqadto[8] = (unsigned short )0;
   sqlstm.sqtdso[8] = (unsigned short )0;
   sqlstm.sqhstv[9] = (unsigned char  *)&ihValor_Tres;
   sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[9] = (         int  )0;
   sqlstm.sqindv[9] = (         short *)0;
   sqlstm.sqinds[9] = (         int  )0;
   sqlstm.sqharm[9] = (unsigned long )0;
   sqlstm.sqadto[9] = (unsigned short )0;
   sqlstm.sqtdso[9] = (unsigned short )0;
   sqlstm.sqhstv[10] = (unsigned char  *)szhAAA;
   sqlstm.sqhstl[10] = (unsigned long )4;
   sqlstm.sqhsts[10] = (         int  )0;
   sqlstm.sqindv[10] = (         short *)0;
   sqlstm.sqinds[10] = (         int  )0;
   sqlstm.sqharm[10] = (unsigned long )0;
   sqlstm.sqadto[10] = (unsigned short )0;
   sqlstm.sqtdso[10] = (unsigned short )0;
   sqlstm.sqhstv[11] = (unsigned char  *)szhSAA;
   sqlstm.sqhstl[11] = (unsigned long )4;
   sqlstm.sqhsts[11] = (         int  )0;
   sqlstm.sqindv[11] = (         short *)0;
   sqlstm.sqinds[11] = (         int  )0;
   sqlstm.sqharm[11] = (unsigned long )0;
   sqlstm.sqadto[11] = (unsigned short )0;
   sqlstm.sqtdso[11] = (unsigned short )0;
   sqlstm.sqhstv[12] = (unsigned char  *)szhERA;
   sqlstm.sqhstl[12] = (unsigned long )4;
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
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


   if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )   {   
        ifnTrazaHilos( modulo,&pfLog, "Open curAbonados (Cliente:%ld) %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND";    
   }

	for(;;)  /* Forever */
   {
      sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
      /* EXEC SQL 
		FETCH curAbonados 
		INTO :lhNumAbonado,
		 	  :szhCodSituacion,
		 	  :lhNumCelular,
		 	  :ihIndPlexsys,
		 	  :ihCodCentral,
		 	  :szhNumSerieHex,
		 	  :szhTipTerminal,
		 	  :ihNumMin,
		 	  :szhCodTecnologia,
		 	  :szhNumSerie,
		 	  :szhNumImei,
		 	  :szhNumImsi,
		 	  :szhCodTiPlan; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )134;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqfoff = (         int )0;
      sqlstm.sqfmod = (unsigned int )2;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szhCodSituacion;
      sqlstm.sqhstl[1] = (unsigned long )4;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)&lhNumCelular;
      sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)&ihIndPlexsys;
      sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&ihCodCentral;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhNumSerieHex;
      sqlstm.sqhstl[5] = (unsigned long )9;
      sqlstm.sqhsts[5] = (         int  )0;
      sqlstm.sqindv[5] = (         short *)0;
      sqlstm.sqinds[5] = (         int  )0;
      sqlstm.sqharm[5] = (unsigned long )0;
      sqlstm.sqadto[5] = (unsigned short )0;
      sqlstm.sqtdso[5] = (unsigned short )0;
      sqlstm.sqhstv[6] = (unsigned char  *)szhTipTerminal;
      sqlstm.sqhstl[6] = (unsigned long )2;
      sqlstm.sqhsts[6] = (         int  )0;
      sqlstm.sqindv[6] = (         short *)0;
      sqlstm.sqinds[6] = (         int  )0;
      sqlstm.sqharm[6] = (unsigned long )0;
      sqlstm.sqadto[6] = (unsigned short )0;
      sqlstm.sqtdso[6] = (unsigned short )0;
      sqlstm.sqhstv[7] = (unsigned char  *)&ihNumMin;
      sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
      sqlstm.sqhsts[7] = (         int  )0;
      sqlstm.sqindv[7] = (         short *)0;
      sqlstm.sqinds[7] = (         int  )0;
      sqlstm.sqharm[7] = (unsigned long )0;
      sqlstm.sqadto[7] = (unsigned short )0;
      sqlstm.sqtdso[7] = (unsigned short )0;
      sqlstm.sqhstv[8] = (unsigned char  *)szhCodTecnologia;
      sqlstm.sqhstl[8] = (unsigned long )9;
      sqlstm.sqhsts[8] = (         int  )0;
      sqlstm.sqindv[8] = (         short *)0;
      sqlstm.sqinds[8] = (         int  )0;
      sqlstm.sqharm[8] = (unsigned long )0;
      sqlstm.sqadto[8] = (unsigned short )0;
      sqlstm.sqtdso[8] = (unsigned short )0;
      sqlstm.sqhstv[9] = (unsigned char  *)szhNumSerie;
      sqlstm.sqhstl[9] = (unsigned long )26;
      sqlstm.sqhsts[9] = (         int  )0;
      sqlstm.sqindv[9] = (         short *)0;
      sqlstm.sqinds[9] = (         int  )0;
      sqlstm.sqharm[9] = (unsigned long )0;
      sqlstm.sqadto[9] = (unsigned short )0;
      sqlstm.sqtdso[9] = (unsigned short )0;
      sqlstm.sqhstv[10] = (unsigned char  *)szhNumImei;
      sqlstm.sqhstl[10] = (unsigned long )26;
      sqlstm.sqhsts[10] = (         int  )0;
      sqlstm.sqindv[10] = (         short *)0;
      sqlstm.sqinds[10] = (         int  )0;
      sqlstm.sqharm[10] = (unsigned long )0;
      sqlstm.sqadto[10] = (unsigned short )0;
      sqlstm.sqtdso[10] = (unsigned short )0;
      sqlstm.sqhstv[11] = (unsigned char  *)szhNumImsi;
      sqlstm.sqhstl[11] = (unsigned long )51;
      sqlstm.sqhsts[11] = (         int  )0;
      sqlstm.sqindv[11] = (         short *)0;
      sqlstm.sqinds[11] = (         int  )0;
      sqlstm.sqharm[11] = (unsigned long )0;
      sqlstm.sqadto[11] = (unsigned short )0;
      sqlstm.sqtdso[11] = (unsigned short )0;
      sqlstm.sqhstv[12] = (unsigned char  *)szhCodTiPlan;
      sqlstm.sqhstl[12] = (unsigned long )9;
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
      sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


			         
      if( sqlca.sqlcode == SQLNOTFOUND )  {   
             ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], no tiene mas abonados celulares", LOG03, lhCodCliente );  
             break;    
      }
      else if( sqlca.sqlcode )  {   
             ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Fetch curAbonados => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
             strcpy( szValRetorno, "PND" );   
             break;    
      }
   
      ifnTrazaHilos( modulo,&pfLog, "Generando icc_movimiento abonado => [%ld].", LOG05, lhNumAbonado );
      
     	/* recuperamos la actuacion de abonado celular */
		if( !bfnGetActAbodeAccion(&pfLog, szCODRUTINA, szhCodTiPlan, 1, szhCodActAbo, CXX ) ) {
	   	 strcpy( szValRetorno, "PND" );   
	       break;   
		}
   
		/* recuperamos el codigo de actuacion de la central, relacionado con la actuacion del abonado */
		if( ( ihCodActuacion = ifnGetActuacionCentralCelularAcc(&pfLog, szhCodActAbo, 1, szMODULOCOBRANZA, szhCodTecnologia, CXX ) ) < 0 )	{
          strcpy( szValRetorno, "PND" );   
          break;   
		}	
   
		ifnTrazaHilos( modulo,&pfLog, "ihCodActuacion   [%d] ", LOG05, ihCodActuacion);  
		ifnTrazaHilos( modulo,&pfLog, "szhCodActAbo     [%s] ", LOG05, szhCodActAbo);  
		ifnTrazaHilos( modulo,&pfLog, "ihCodCentral     [%d] ", LOG05, ihCodCentral);  
		ifnTrazaHilos( modulo,&pfLog, "lhNumCelular     [%ld] ", LOG05, lhNumCelular);  
		ifnTrazaHilos( modulo,&pfLog, "szhNumSerieHex   [%s] ", LOG05, szhNumSerieHex);  
		ifnTrazaHilos( modulo,&pfLog, "szhTipTerminal   [%s] ", LOG05, szhTipTerminal);  
		ifnTrazaHilos( modulo,&pfLog, "szhCod_Param     [%s] ", LOG05, szhCod_Param);  
		ifnTrazaHilos( modulo,&pfLog, "szhCodTecnologia [%s] ", LOG05, szhCodTecnologia);  
		ifnTrazaHilos( modulo,&pfLog, "szhNumImei       [%s] ", LOG05, szhNumImei);  
		ifnTrazaHilos( modulo,&pfLog, "szhNumImsi       [%s] ", LOG05, szhNumImsi);  
		ifnTrazaHilos( modulo,&pfLog, "szhNumSerie      [%s] ", LOG05, szhNumSerie);  
		sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
		/* EXEC SQL
      INSERT  INTO ICC_MOVIMIENTO
             (NUM_MOVIMIENTO  ,	NUM_ABONADO   ,  COD_ESTADO,
              COD_MODULO      ,	NUM_INTENTOS  ,  DES_RESPUESTA,
              COD_ACTUACION   , 	COD_ACTABO    ,  NOM_USUARORA,
              FEC_INGRESO     ,	COD_CENTRAL   ,  NUM_CELULAR,
              NUM_SERIE       ,	TIP_TERMINAL  ,  COD_SUSPREHA,
              IND_BLOQUEO     ,	NUM_MOVPOS    ,  NUM_MIN,
              STA             ,	COD_SERVICIOS ,  COD_ENRUTAMIENTO,
              TIP_ENRUTAMIENTO,	TIP_TECNOLOGIA,  IMEI,				
              IMSI            ,	ICC           )
      VALUES (ICC_SEQ_NUMMOV.NEXTVAL,
      		  :lhNumAbonado   ,  :ihValor_Uno  ,
              :szhModulo      ,	:ihValor_Cero ,  :szhPENDIENTE,
              :ihCodActuacion ,	:szhCodActAbo ,  USER,
              SYSDATE         ,	:ihCodCentral ,  :lhNumCelular,
              :szhNumSerieHex ,  :szhTipTerminal, NULL,
              :ihValor_Cero   ,  ICC_SEQ_NUMMOV.NEXTVAL,:ihNumMin,
              :szhLetra_S     ,	NULL,   
              TO_NUMBER(:szhCod_Param),	NULL,
			     :szhCodTecnologia,	
			     DECODE( :szhNumImei, :szhFiller, NULL, :szhNumImei ),
			     DECODE( :szhNumImsi, :szhFiller, NULL, :szhNumImsi ),
			     DECODE( :szhNumSerie,:szhFiller, NULL, :szhNumSerie ) ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 25;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "insert into ICC_MOVIMIENTO (NUM_MOVIMIENTO,NUM_ABONADO,COD_\
ESTADO,COD_MODULO,NUM_INTENTOS,DES_RESPUESTA,COD_ACTUACION,COD_ACTABO,NOM_USUA\
RORA,FEC_INGRESO,COD_CENTRAL,NUM_CELULAR,NUM_SERIE,TIP_TERMINAL,COD_SUSPREHA,I\
ND_BLOQUEO,NUM_MOVPOS,NUM_MIN,STA,COD_SERVICIOS,COD_ENRUTAMIENTO,TIP_ENRUTAMIE\
NTO,TIP_TECNOLOGIA,IMEI,IMSI,ICC) values (ICC_SEQ_NUMMOV.nextval ,:b0,:b1,:b2,\
:b3,:b4,:b5,:b6,USER,SYSDATE,:b7,:b8,:b9,:b10,null ,:b3,ICC_SEQ_NUMMOV.nextval\
 ,:b12,:b13,null ,TO_NUMBER(:b14),null ,:b15,DECODE(:b16,:b17,null ,:b16),DECO\
DE(:b19,:b17,null ,:b19),DECODE(:b22,:b17,null ,:b22))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )201;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&lhNumAbonado;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&ihValor_Uno;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szhModulo;
  sqlstm.sqhstl[2] = (unsigned long )3;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhPENDIENTE;
  sqlstm.sqhstl[4] = (unsigned long )10;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)&ihCodActuacion;
  sqlstm.sqhstl[5] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhCodActAbo;
  sqlstm.sqhstl[6] = (unsigned long )3;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&ihCodCentral;
  sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)&lhNumCelular;
  sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhNumSerieHex;
  sqlstm.sqhstl[9] = (unsigned long )9;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhTipTerminal;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)&ihValor_Cero;
  sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)&ihNumMin;
  sqlstm.sqhstl[12] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_S;
  sqlstm.sqhstl[13] = (unsigned long )2;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhCod_Param;
  sqlstm.sqhstl[14] = (unsigned long )16;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhCodTecnologia;
  sqlstm.sqhstl[15] = (unsigned long )9;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[16] = (unsigned long )26;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
  sqlstm.sqhstv[17] = (unsigned char  *)szhFiller;
  sqlstm.sqhstl[17] = (unsigned long )2;
  sqlstm.sqhsts[17] = (         int  )0;
  sqlstm.sqindv[17] = (         short *)0;
  sqlstm.sqinds[17] = (         int  )0;
  sqlstm.sqharm[17] = (unsigned long )0;
  sqlstm.sqadto[17] = (unsigned short )0;
  sqlstm.sqtdso[17] = (unsigned short )0;
  sqlstm.sqhstv[18] = (unsigned char  *)szhNumImei;
  sqlstm.sqhstl[18] = (unsigned long )26;
  sqlstm.sqhsts[18] = (         int  )0;
  sqlstm.sqindv[18] = (         short *)0;
  sqlstm.sqinds[18] = (         int  )0;
  sqlstm.sqharm[18] = (unsigned long )0;
  sqlstm.sqadto[18] = (unsigned short )0;
  sqlstm.sqtdso[18] = (unsigned short )0;
  sqlstm.sqhstv[19] = (unsigned char  *)szhNumImsi;
  sqlstm.sqhstl[19] = (unsigned long )51;
  sqlstm.sqhsts[19] = (         int  )0;
  sqlstm.sqindv[19] = (         short *)0;
  sqlstm.sqinds[19] = (         int  )0;
  sqlstm.sqharm[19] = (unsigned long )0;
  sqlstm.sqadto[19] = (unsigned short )0;
  sqlstm.sqtdso[19] = (unsigned short )0;
  sqlstm.sqhstv[20] = (unsigned char  *)szhFiller;
  sqlstm.sqhstl[20] = (unsigned long )2;
  sqlstm.sqhsts[20] = (         int  )0;
  sqlstm.sqindv[20] = (         short *)0;
  sqlstm.sqinds[20] = (         int  )0;
  sqlstm.sqharm[20] = (unsigned long )0;
  sqlstm.sqadto[20] = (unsigned short )0;
  sqlstm.sqtdso[20] = (unsigned short )0;
  sqlstm.sqhstv[21] = (unsigned char  *)szhNumImsi;
  sqlstm.sqhstl[21] = (unsigned long )51;
  sqlstm.sqhsts[21] = (         int  )0;
  sqlstm.sqindv[21] = (         short *)0;
  sqlstm.sqinds[21] = (         int  )0;
  sqlstm.sqharm[21] = (unsigned long )0;
  sqlstm.sqadto[21] = (unsigned short )0;
  sqlstm.sqtdso[21] = (unsigned short )0;
  sqlstm.sqhstv[22] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[22] = (unsigned long )26;
  sqlstm.sqhsts[22] = (         int  )0;
  sqlstm.sqindv[22] = (         short *)0;
  sqlstm.sqinds[22] = (         int  )0;
  sqlstm.sqharm[22] = (unsigned long )0;
  sqlstm.sqadto[22] = (unsigned short )0;
  sqlstm.sqtdso[22] = (unsigned short )0;
  sqlstm.sqhstv[23] = (unsigned char  *)szhFiller;
  sqlstm.sqhstl[23] = (unsigned long )2;
  sqlstm.sqhsts[23] = (         int  )0;
  sqlstm.sqindv[23] = (         short *)0;
  sqlstm.sqinds[23] = (         int  )0;
  sqlstm.sqharm[23] = (unsigned long )0;
  sqlstm.sqadto[23] = (unsigned short )0;
  sqlstm.sqtdso[23] = (unsigned short )0;
  sqlstm.sqhstv[24] = (unsigned char  *)szhNumSerie;
  sqlstm.sqhstl[24] = (unsigned long )26;
  sqlstm.sqhsts[24] = (         int  )0;
  sqlstm.sqindv[24] = (         short *)0;
  sqlstm.sqinds[24] = (         int  )0;
  sqlstm.sqharm[24] = (unsigned long )0;
  sqlstm.sqadto[24] = (unsigned short )0;
  sqlstm.sqtdso[24] = (unsigned short )0;
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


		if( sqlca.sqlcode )  {   
	       ifnTrazaHilos( modulo,&pfLog, "Al insertar en icc_movimiento. Cliente [%ld] - %s", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	       return "PND";   
	   }


   } /* endfor */
    
   sqlca.sqlcode=0; /* se resetea la vble sql por brain damage*/
   /* EXEC SQL CLOSE curAbonados ; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 25;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )316;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	if( sqlca.sqlcode )  {   
       ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Close curAbonados => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
       return "PND";   
   }
   
	if( strcmp( szValRetorno, "" ) ) /* szValRetorno != "" */	{  
	    ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Error al tratar de Enrutar.", LOG01, lhCodCliente ); 
		 return "PND";
	}  
   
	/* se debe borrar el registro de la CO_PARAM_ACCIONES */
	if (strcmp(szhParamExcluidor,"0")==0) { 
		if( !bfnBorrarCoParamAcc(&pfLog, lhNumSecuencia, CXX ) )	{
			ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Error en bfnBorrarCoParamAcc.", LOG02, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return "NOELI";   
		}	
	}
	/* traspasa valor a vble global */
	strcpy(szParamExclu,szhParamExcluidor);
   ifnTrazaHilos( modulo,&pfLog, "Ok abonados celulares del cliente %ld",LOG05,lhCodCliente); 
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
