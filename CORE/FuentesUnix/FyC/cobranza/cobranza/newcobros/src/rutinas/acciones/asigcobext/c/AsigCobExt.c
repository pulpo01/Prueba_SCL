
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
    "./pc/AsigCobExt.pc"
};


static unsigned int sqlctx = 13797211;


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
   unsigned char  *sqhstv[17];
   unsigned long  sqhstl[17];
            int   sqhsts[17];
            short *sqindv[17];
            int   sqinds[17];
   unsigned long  sqharm[17];
   unsigned long  *sqharc[17];
   unsigned short  sqadto[17];
   unsigned short  sqtdso[17];
} sqlstm = {12,17};

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

 static const char *sq0013 = 
"select A.COD_AGENTE ,A.PRC_ASIGNACION ,C.COD_ENTIDAD  from CO_ENTCOB C ,CO_A\
GENCOB B ,CO_AGENCOMU A where ((((A.COD_COMUNA=:b0 and B.COD_AGENTE=A.COD_AGEN\
TE) and C.COD_ENTIDAD=B.COD_ENTIDAD) and C.TIP_ENTIDAD=:b1) and C.TIP_COBRANZA\
<>:b2)           ";

 static const char *sq0017 = 
"select COD_CLIENTE ,COD_AGENTE ,COD_CUENTA  from CO_MOROSOS where (NUM_IDENT\
=:b0 and COD_TIPIDENT=:b1)           ";

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* cud (compilation unit data) array */
static const short sqlcud0[] =
{12,4138,1,0,0,
5,0,0,1,220,0,4,155,0,0,14,9,0,1,0,1,97,0,0,2,97,0,0,2,97,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
76,0,0,2,465,0,4,219,0,0,16,14,0,1,0,2,5,0,0,2,97,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,
0,0,1,97,0,0,1,3,0,0,
155,0,0,3,59,0,5,251,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
178,0,0,4,297,0,5,273,0,0,8,8,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,
225,0,0,5,297,0,4,300,0,0,17,11,0,1,0,1,97,0,0,1,97,0,0,2,97,0,0,2,97,0,0,2,97,
0,0,2,97,0,0,2,5,0,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,1,97,0,0,1,97,0,0,1,97,0,0,
308,0,0,6,130,0,4,335,0,0,5,4,0,1,0,2,3,0,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,
343,0,0,7,247,0,5,394,0,0,14,14,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,4,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,
0,0,
414,0,0,8,174,0,5,415,0,0,8,8,0,1,0,1,3,0,0,1,4,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
1,97,0,0,1,97,0,0,1,97,0,0,
461,0,0,9,297,0,5,435,0,0,8,8,0,1,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,97,0,0,
508,0,0,10,175,0,4,465,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
539,0,0,11,242,0,4,484,0,0,4,2,0,1,0,2,5,0,0,2,5,0,0,1,3,0,0,1,3,0,0,
570,0,0,12,63,0,4,505,0,0,1,0,0,1,0,2,5,0,0,
589,0,0,13,249,0,9,572,0,0,3,3,0,1,0,1,5,0,0,1,97,0,0,1,97,0,0,
616,0,0,13,0,0,13,580,0,0,3,0,0,1,0,2,97,0,0,2,3,0,0,2,97,0,0,
643,0,0,13,0,0,15,598,0,0,0,0,0,1,0,
658,0,0,14,59,0,5,625,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
681,0,0,15,238,0,4,650,0,0,8,7,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,1,97,0,0,1,5,0,0,
728,0,0,16,59,0,5,699,0,0,2,2,0,1,0,1,97,0,0,1,3,0,0,
751,0,0,17,113,0,9,749,0,0,2,2,0,1,0,1,97,0,0,1,97,0,0,
774,0,0,17,0,0,13,763,0,0,3,0,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,
801,0,0,18,59,0,5,785,0,0,2,2,0,1,0,1,5,0,0,1,3,0,0,
824,0,0,19,86,0,4,800,0,0,3,2,0,1,0,2,3,0,0,1,3,0,0,1,97,0,0,
851,0,0,20,164,0,3,826,0,0,6,6,0,1,0,1,3,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,
0,1,97,0,0,
890,0,0,21,86,0,5,861,0,0,2,2,0,1,0,1,3,0,0,1,97,0,0,
913,0,0,17,0,0,15,877,0,0,0,0,0,1,0,
928,0,0,22,65,0,4,957,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
951,0,0,23,331,0,3,994,0,0,14,14,0,1,0,1,97,0,0,1,97,0,0,1,3,0,0,1,3,0,0,1,97,
0,0,1,97,0,0,1,3,0,0,1,97,0,0,1,4,0,0,1,4,0,0,1,3,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,
};


/* ==================================================================================================
Tipo        :  ACCION
Nombre      :  AsigCobExt.pc ("ACEXT"->szfnAsigCobExt)
Descripcion :  ASIGna una entidad de COBranza EXTerna ( Pre-Judicial)
               a todos los abonados del rut del cliente dado
Recibe      :  by Val -> Cod Cliente 
Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
               "NORUT"-> Fue imposible determinar el rut del cliente dado
               "NOAGE"-> Fue imposible asignar un agente (entidad)
               "PND"  -> La accion queda pendiente                         / MGG_27032001 /
   				"NODIR"-> Fue imposible determinar la direccion del cliente / MGG_27032001 /
   				"OK"   -> La accion se ejecuto correctamente
Autor       :  Roy Barrera Richards
Fecha       :  10 - Agosto - 2000 

Modificaciones	:	
==================================================================================================
2004-03-09  :  Se comenta UPDATE CO_MOROSOS CH-200402171678 MAC.
2004-08-17  :  GAC. Homologacion a Incidencia PR-200406100505
Modificacion:  12-11-2004
					Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
               Puntero de archivo log tipo Hilo. 
               Variable de contexto para instancia de BD tipo hilo
================================================================================================== */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include	"AsigCobExt.h"
#define	HOST_ARRAY_AGENTES  500  

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


/* ================================================================================================== */
/* funcion de asignacion de entidad de cobranza externa                                               */
/* ================================================================================================== */
char *szfnAsigCobExt (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 


	TDATOSCOB stDatosCob;
	char	szhEntGestCob[21];
	long	lhCodCliente = 0;
	long	lhCodClienteNew = 0;
	char	szhCodRegion[4];			   /* EXEC SQL VAR szhCodRegion IS STRING (4); */ 

	char	szhCodComuna[6];			   /* EXEC SQL VAR szhCodComuna IS STRING (6); */ 

	int   ihDirCorrespondencia = 3;
	char  szhCodEntidadAsig[6];		/* EXEC SQL VAR szhCodEntidadAsig IS STRING (6); */ 

	char  szhCodAgenteAsig[31];		/* EXEC SQL VAR szhCodAgenteAsig IS STRING (31); */ 

	char  szhCodAgenteNew[31];		   /* EXEC SQL VAR szhCodAgenteNew IS STRING (31); */ 

	long  lhCodCuentaNew = 0;
	char  szhAuxHoy[15];				   /* EXEC SQL VAR szhAuxHoy IS STRING (15); */ 

	int   ihIncrementoClientes = 0;
	char  szhCodAgente[HOST_ARRAY_AGENTES][31];
	char  szhCodEntidad[HOST_ARRAY_AGENTES][6]; 
	int   ihPrcAsignado[HOST_ARRAY_AGENTES];
	int   ihMorososAgente[HOST_ARRAY_AGENTES];
	int   ihCnt = 0;
	char  szhUser[31];				   /* EXEC SQL VAR szhUser IS STRING (31); */ 

	char  szhNomUsuario[31];			/* EXEC SQL VAR szhNomUsuario IS STRING (31); */ 

	int   iCountGest=0;
	char  szCodGestion[3+1];
	char  szCodOperadora[21];        /* EXEC SQL VAR szCodOperadora IS STRING (21); */ 

	/*vbles bind*/
	char  szhEjecutivoCob [41];
	char  szhYYYYMMDDHH24MISS [17];
	char  szhRutinaACEXT [6];
	char  szhEstadoEJE   [4];
	char  szhMovimSM [3];
	char  szhLetra_R [2];  
	char  szhLetra_I [2];
	char  szhLetra_G [2];
	char  szhLetra_V [2];
	char  szhLetra_N [2];
	char  szhLetra_E [2];
	char  szhLetra_B [2];
	char  szhLetra_J [2];
	
	int   ihValor_cero= 0;
	int   ihValor_dos = 2;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 

char  modulo[] = "szfnAsigCobExt";
int   iResp = 0, iMetropolitana = 13, iAsignado = 0, i = 0, iMorososComuna = 0, iPorcentajeTotal = 0;
long  lTotalRows = 0;
float fPorcentajeDefinido = 0.0, fPorcentajeActual = 0.0;
char  szRutina[] = "A", szMovimiento[] = "A", szValParametro[21];
BOOL  bCalcularAgente = FALSE;
struct sqlca sqlca;
FILE  *pfLog=*ptArchLog;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

	strcpy(szhEjecutivoCob,"CAMBIA EJECUTIVO COBRANZA A PRE-JUDICIAL");
	strcpy(szhYYYYMMDDHH24MISS,"YYYYMMDDHH24MISS");
	strcpy(szhRutinaACEXT,"ACEXT");
	strcpy(szhEstadoEJE  ,"EJE");
	strcpy(szhMovimSM, "SM");
	strcpy(szhLetra_R,"R");
   strcpy(szhLetra_I,"I");
   strcpy(szhLetra_G,"G");
   strcpy(szhLetra_V,"V");
   strcpy(szhLetra_N,"N");
   strcpy(szhLetra_E,"E");
   strcpy(szhLetra_B,"B");
   strcpy(szhLetra_J,"J");
	

	memset( szhEntGestCob, '\0', sizeof( szhEntGestCob ) );
	memset( szhEntGestCob, '\0', sizeof( szhEntGestCob ) );
	memset( szhCodRegion, '\0', sizeof( szhCodRegion ) );
	memset( szhCodComuna, '\0', sizeof( szhCodComuna ) );
	memset( szhCodEntidadAsig, '\0', sizeof( szhCodEntidadAsig ) );
	memset( szhCodAgenteAsig, '\0', sizeof( szhCodAgenteAsig ) );
	memset( szhCodAgenteNew, '\0', sizeof( szhCodAgenteNew ) );
	memset( szhAuxHoy, '\0', sizeof( szhAuxHoy ) );
	memset( szCodOperadora, '\0', sizeof( szCodOperadora ) );
	memset( szValParametro, '\0', sizeof( szValParametro ) );
	memset( szhUser, '\0', sizeof( szhUser ) );
	memset( szhNomUsuario, '\0', sizeof( szhNomUsuario ) );

   lhCodCliente = lCliente;
	stDatosCob.lCodCliente = 0;
	strcpy( stDatosCob.szRutSantiago, "N" );

	/* obtenemos la entidad a la cual va dirigida la Cobranza Externa */
   if (ifnRecuperaGedParametro(&pfLog, "ENTIDAD_GESTION_COB", "CO", szhEntGestCob, CXX )!=0) 
      return "ERENC";
    
	stDatosCob.lCodCliente = lhCodCliente;
	stDatosCob.dMtoDeuda = 0;

	/* Obtiene el Rut del Cliente -*/
    iResp = ifnGetRutCliente(&pfLog, lCliente, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent, CXX );
    if( iResp == 0 ) 
        return "NORUT";		/* No encontro el rut */
    else if( iResp < 0 )
        return "PND";		/* error oracle */

	iResp = 0; /* todo ok */

	ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], NumIdent => [%s], TipIdent => [%s].", LOG06, lhCodCliente, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent );

	if( !strcmp( szhEntGestCob, "C" ) )
	{
		/* Obtener la deuda del cliente */
	    if( !ifnGetSaldoVencidoAcc(&pfLog, lhCodCliente, &stDatosCob.dMtoVencido, CXX ) )
			return "PND";

		/* vemos en que situacion se encuentra */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
		/* EXEC SQL
		SELECT COD_MOVIMIENTO,
			   COD_ENVIO,
			   TO_CHAR( SYSDATE, :szhYYYYMMDDHH24MISS ),
			   USER,
			   NOM_USUARIO
		  INTO :stDatosCob.szCodMovimiento,
		  	   :stDatosCob.szCodEnvio,
		  	   :szhAuxHoy,
			   :szhUser,
			   :szhNomUsuario
		  FROM CO_COBEXTERNA
		 WHERE COD_CLIENTE = :lhCodCliente
		   AND COD_MOVIMIENTO <> :szhLetra_R 
		   AND COD_ENVIO NOT IN ( :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_N, :szhLetra_E ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 14;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_MOVIMIENTO ,COD_ENVIO ,TO_CHAR(SYSDATE,:b0) ,USE\
R ,NOM_USUARIO into :b1,:b2,:b3,:b4,:b5  from CO_COBEXTERNA where ((COD_CLIENT\
E=:b6 and COD_MOVIMIENTO<>:b7) and COD_ENVIO not  in (:b7,:b9,:b10,:b11,:b12,:\
b13))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHH24MISS;
  sqlstm.sqhstl[0] = (unsigned long )17;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodMovimiento);
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szCodEnvio);
  sqlstm.sqhstl[2] = (unsigned long )2;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szhAuxHoy;
  sqlstm.sqhstl[3] = (unsigned long )15;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szhUser;
  sqlstm.sqhstl[4] = (unsigned long )31;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhNomUsuario;
  sqlstm.sqhstl[5] = (unsigned long )31;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[7] = (unsigned long )2;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_I;
  sqlstm.sqhstl[9] = (unsigned long )2;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_G;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_V;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[13] = (unsigned long )2;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
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
  sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* Reasignado:Ingresado:Generado:Visado */

		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], SELECT CO_COBEXTERNA CLIENTE => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return "SECOB";
		}
		else if( sqlca.sqlcode != SQLNOTFOUND )
		{
			/* el cliente esta en Cobranza Externa */
			rtrim( stDatosCob.szCodMovimiento );
			rtrim( stDatosCob.szCodEnvio );

			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Movimiento => [%s] Envio => [%s].", LOG03, lhCodCliente, stDatosCob.szCodMovimiento, stDatosCob.szCodEnvio );  
	
	    	if( !strcmp( stDatosCob.szCodMovimiento, "SM" ) )				/* si no tiene movimiento */
			{
				if( !strcmp( stDatosCob.szCodEnvio, "B" ) )               	/* si el envio es de baja */
				{ 
		        	bCalcularAgente = TRUE;
	            }                                    
				else
				{
					if( !strcmp( szhUser, szhNomUsuario ) ) /* el usuario varia entre automatica y puntual */
					{
						ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Ya se encuentra en Cobranza Externa.", LOG03, lhCodCliente );  
						return "CESCO";											/* inconsistencia en datos de cobranza */
					}
				}
			}
            else if( !strcmp( stDatosCob.szCodMovimiento, "B" ) )
	        { 
 				/* si se iba a dar de baja */
	        	bCalcularAgente = TRUE;
		    }
			else															 /* puede ser A o M */
			{
				if( !strcmp( szhUser, szhNomUsuario ) ) /* el usuario varia entre automatica y puntual */
				{
					ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Ya se encuentra en Cobranza Externa.", LOG03, lhCodCliente );  
					return "CESCO";											/* inconsistencia en datos de cobranza */
				}
			}

			return "OK";

		} /* if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) */

		/* debemos buscar si hay otro cliente asignado a cobranza externa y sea de la misma operadora y misma cuenta */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
		/* EXEC SQL
		SELECT E.DES_ENTIDAD,
			   C.COD_ENTIDAD
		  INTO :szhCodAgenteAsig,
		  	   :stDatosCob.szCodEntidad
		  FROM CO_ENTCOB E, GE_CLIENTES G, CO_COBEXTERNA C
		 WHERE C.NUM_IDENT = :stDatosCob.szNumIdent
		   AND C.COD_TIPIDENT = :stDatosCob.szCodTipIdent
		   AND C.COD_CLIENTE != :lhCodCliente
		   AND C.COD_MOVIMIENTO NOT IN ( :szhLetra_R )
		   AND C.COD_ENVIO NOT IN ( :szhLetra_B, :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_N, :szhLetra_E ) /o Reasignado:Ingresado:Generado:Visado o/
		   AND C.COD_CLIENTE = G.COD_CLIENTE
		   AND G.COD_OPERADORA IN ( SELECT COD_OPERADORA
		   							  FROM GE_CLIENTES
		   							 WHERE COD_CLIENTE = :lhCodCliente )
		   AND C.COD_ENTIDAD = E.COD_ENTIDAD
		   AND E.TIP_ENTIDAD = :szhLetra_E			   							 
		   AND ROWNUM < :ihValor_dos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 16;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select E.DES_ENTIDAD ,C.COD_ENTIDAD into :b0,:b1  from CO_E\
NTCOB E ,GE_CLIENTES G ,CO_COBEXTERNA C where (((((((((C.NUM_IDENT=:b2 and C.C\
OD_TIPIDENT=:b3) and C.COD_CLIENTE<>:b4) and C.COD_MOVIMIENTO not  in (:b5)) a\
nd C.COD_ENVIO not  in (:b6,:b5,:b8,:b9,:b10,:b11,:b12)) and C.COD_CLIENTE=G.C\
OD_CLIENTE) and G.COD_OPERADORA in (select COD_OPERADORA  from GE_CLIENTES whe\
re COD_CLIENTE=:b4)) and C.COD_ENTIDAD=E.COD_ENTIDAD) and E.TIP_ENTIDAD=:b12) \
and ROWNUM<:b15)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )76;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgenteAsig;
  sqlstm.sqhstl[0] = (unsigned long )31;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodEntidad);
  sqlstm.sqhstl[1] = (unsigned long )6;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szNumIdent);
  sqlstm.sqhstl[2] = (unsigned long )21;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(stDatosCob.szCodTipIdent);
  sqlstm.sqhstl[3] = (unsigned long )3;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[5] = (unsigned long )2;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_B;
  sqlstm.sqhstl[6] = (unsigned long )2;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[7] = (unsigned long )2;
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_I;
  sqlstm.sqhstl[8] = (unsigned long )2;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_G;
  sqlstm.sqhstl[9] = (unsigned long )2;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_V;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[13] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[14] = (unsigned long )2;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)&ihValor_dos;
  sqlstm.sqhstl[15] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
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
			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Error al buscar Entidad => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return "BUSEN";
		}
		else if( sqlca.sqlcode != SQLNOTFOUND ) /* hay otro, asignar el mismo agente */
		{		
			rtrim( szhCodAgenteAsig );
			rtrim( stDatosCob.szCodEntidad );

			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Entidad => [%s], Ya existe otro cliente en Cobranza.", LOG05, lhCodCliente, szhCodAgenteAsig );  

			sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
			/* EXEC SQL 
			UPDATE CO_MOROSOS
			   SET COD_AGENTE  = :szhCodAgenteAsig
			 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 16;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=:b\
1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )155;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgenteAsig;
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


			 
			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], UPDATE CO_MOROSOS => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return "UPMOR";
			}

		    strcpy( stDatosCob.szRutSantiago, "N" );

			if( !bfnInsertaCobExterna( &pfLog, &stDatosCob, szhEntGestCob, CXX ) )
				return "INCOB";

			/* debemos actualizar la co_gestion, con un alta transitoria */
			if( !bfnActualizaCoGestionClienteAcc(&pfLog, lhCodCliente, stDatosCob.lCodCuenta, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent, stDatosCob.szCodEntidad, szRutina, szMovimiento, CXX ) )
				return "UPGES";

            /****** GAC 08.09.03 **** Se actualiza COD_AGENTE para todos los clientes del rut *******/
            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL UPDATE CO_MOROSOS
                     SET COD_AGENTE = (SELECT UNIQUE DES_ENTIDAD  /oSe agrega UNIQUE para que rtorne solo una entidad 20.06.2004 PR-505 CAPC o/
	                                 FROM CO_ENTCOB A, CO_COBEXTERNA B
	                                WHERE A.COD_ENTIDAD = B.COD_ENTIDAD
	                                  AND B.NUM_IDENT   =  :stDatosCob.szNumIdent 
                                          AND B.COD_TIPIDENT = :stDatosCob.szCodTipIdent
                                          AND b.cod_movimiento not in ( :szhLetra_B, :szhLetra_R )  /o Homol.a PR-0505 17.08.2004 GAC o/
                                          AND b.cod_envio not in ( :szhLetra_B, :szhLetra_R ))      /o Homol.a PR-0505  17.08.2004 GAC o/
                     WHERE NUM_IDENT  = :stDatosCob.szNumIdent
                     AND COD_TIPIDENT = :stDatosCob.szCodTipIdent; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 16;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=(select unique \
DES_ENTIDAD  from CO_ENTCOB A ,CO_COBEXTERNA B where ((((A.COD_ENTIDAD=B.COD_E\
NTIDAD and B.NUM_IDENT=:b0) and B.COD_TIPIDENT=:b1) and b.cod_movimiento not  \
in (:b2,:b3)) and b.cod_envio not  in (:b2,:b3))) where (NUM_IDENT=:b0 and COD\
_TIPIDENT=:b1)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )178;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)(stDatosCob.szNumIdent);
            sqlstm.sqhstl[0] = (unsigned long )21;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodTipIdent);
            sqlstm.sqhstl[1] = (unsigned long )3;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_B;
            sqlstm.sqhstl[2] = (unsigned long )2;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_R;
            sqlstm.sqhstl[3] = (unsigned long )2;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_B;
            sqlstm.sqhstl[4] = (unsigned long )2;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_R;
            sqlstm.sqhstl[5] = (unsigned long )2;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)(stDatosCob.szNumIdent);
            sqlstm.sqhstl[6] = (unsigned long )21;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)(stDatosCob.szCodTipIdent);
            sqlstm.sqhstl[7] = (unsigned long )3;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


            
			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) {
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], UPDATE CO_MOROSOS COD_AGENTE de RUT => [%s]", LOG00,lhCodCliente, sqlca.sqlerrm.sqlerrmc );
				return "UPCON"; /* error oracle*/
			}                     
	
			return "OK"; /* No hace nada mas, ya hay agente de Cobranza Pre-Judicial */
		}
		/* si no existe otro cliente, debe buscar un agente */
	}
	else /* la gestion esta dirigida a la cuenta */
	{
		/* Obtener la deuda del rut del cliente */
		if( !bfnGetSaldoPorRutAcc(&pfLog, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent, &stDatosCob.dMtoVencido, CXX ) ) 
			return "PND";

		sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
		/* EXEC SQL
		SELECT A.COD_ENTIDAD, 
			   A.COD_MOVIMIENTO, 
			   A.COD_ENVIO,
			   TO_CHAR( A.FEC_MOVIMIENTO, :szhYYYYMMDDHH24MISS ),
			   TO_CHAR( SYSDATE, :szhYYYYMMDDHH24MISS ),
			   COD_CUENTA
		  INTO :stDatosCob.szCodEntidad,
			   :stDatosCob.szCodMovimiento,
			   :stDatosCob.szCodEnvio,
			   :stDatosCob.szFecMovimiento,
			   :szhAuxHoy,
			   :stDatosCob.lCodCuenta
		  FROM CO_COBEXTERNA A
		 WHERE A.NUM_IDENT 	= :stDatosCob.szNumIdent
		   AND A.COD_TIPIDENT = :stDatosCob.szCodTipIdent
		   AND COD_MOVIMIENTO <> :szhLetra_R
		   AND COD_ENVIO NOT IN ( :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_N, :szhLetra_E ); */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 17;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select A.COD_ENTIDAD ,A.COD_MOVIMIENTO ,A.COD_ENVIO ,TO_CHA\
R(A.FEC_MOVIMIENTO,:b0) ,TO_CHAR(SYSDATE,:b0) ,COD_CUENTA into :b2,:b3,:b4,:b5\
,:b6,:b7  from CO_COBEXTERNA A where (((A.NUM_IDENT=:b8 and A.COD_TIPIDENT=:b9\
) and COD_MOVIMIENTO<>:b10) and COD_ENVIO not  in (:b10,:b12,:b13,:b14,:b15,:b\
16))";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )225;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szhYYYYMMDDHH24MISS;
  sqlstm.sqhstl[0] = (unsigned long )17;
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhYYYYMMDDHH24MISS;
  sqlstm.sqhstl[1] = (unsigned long )17;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szCodEntidad);
  sqlstm.sqhstl[2] = (unsigned long )6;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)(stDatosCob.szCodMovimiento);
  sqlstm.sqhstl[3] = (unsigned long )6;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)(stDatosCob.szCodEnvio);
  sqlstm.sqhstl[4] = (unsigned long )2;
  sqlstm.sqhsts[4] = (         int  )0;
  sqlstm.sqindv[4] = (         short *)0;
  sqlstm.sqinds[4] = (         int  )0;
  sqlstm.sqharm[4] = (unsigned long )0;
  sqlstm.sqadto[4] = (unsigned short )0;
  sqlstm.sqtdso[4] = (unsigned short )0;
  sqlstm.sqhstv[5] = (unsigned char  *)(stDatosCob.szFecMovimiento);
  sqlstm.sqhstl[5] = (unsigned long )15;
  sqlstm.sqhsts[5] = (         int  )0;
  sqlstm.sqindv[5] = (         short *)0;
  sqlstm.sqinds[5] = (         int  )0;
  sqlstm.sqharm[5] = (unsigned long )0;
  sqlstm.sqadto[5] = (unsigned short )0;
  sqlstm.sqtdso[5] = (unsigned short )0;
  sqlstm.sqhstv[6] = (unsigned char  *)szhAuxHoy;
  sqlstm.sqhstl[6] = (unsigned long )15;
  sqlstm.sqhsts[6] = (         int  )0;
  sqlstm.sqindv[6] = (         short *)0;
  sqlstm.sqinds[6] = (         int  )0;
  sqlstm.sqharm[6] = (unsigned long )0;
  sqlstm.sqadto[6] = (unsigned short )0;
  sqlstm.sqtdso[6] = (unsigned short )0;
  sqlstm.sqhstv[7] = (unsigned char  *)&(stDatosCob.lCodCuenta);
  sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
  sqlstm.sqhsts[7] = (         int  )0;
  sqlstm.sqindv[7] = (         short *)0;
  sqlstm.sqinds[7] = (         int  )0;
  sqlstm.sqharm[7] = (unsigned long )0;
  sqlstm.sqadto[7] = (unsigned short )0;
  sqlstm.sqtdso[7] = (unsigned short )0;
  sqlstm.sqhstv[8] = (unsigned char  *)(stDatosCob.szNumIdent);
  sqlstm.sqhstl[8] = (unsigned long )21;
  sqlstm.sqhsts[8] = (         int  )0;
  sqlstm.sqindv[8] = (         short *)0;
  sqlstm.sqinds[8] = (         int  )0;
  sqlstm.sqharm[8] = (unsigned long )0;
  sqlstm.sqadto[8] = (unsigned short )0;
  sqlstm.sqtdso[8] = (unsigned short )0;
  sqlstm.sqhstv[9] = (unsigned char  *)(stDatosCob.szCodTipIdent);
  sqlstm.sqhstl[9] = (unsigned long )3;
  sqlstm.sqhsts[9] = (         int  )0;
  sqlstm.sqindv[9] = (         short *)0;
  sqlstm.sqinds[9] = (         int  )0;
  sqlstm.sqharm[9] = (unsigned long )0;
  sqlstm.sqadto[9] = (unsigned short )0;
  sqlstm.sqtdso[9] = (unsigned short )0;
  sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[10] = (unsigned long )2;
  sqlstm.sqhsts[10] = (         int  )0;
  sqlstm.sqindv[10] = (         short *)0;
  sqlstm.sqinds[10] = (         int  )0;
  sqlstm.sqharm[10] = (unsigned long )0;
  sqlstm.sqadto[10] = (unsigned short )0;
  sqlstm.sqtdso[10] = (unsigned short )0;
  sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_R;
  sqlstm.sqhstl[11] = (unsigned long )2;
  sqlstm.sqhsts[11] = (         int  )0;
  sqlstm.sqindv[11] = (         short *)0;
  sqlstm.sqinds[11] = (         int  )0;
  sqlstm.sqharm[11] = (unsigned long )0;
  sqlstm.sqadto[11] = (unsigned short )0;
  sqlstm.sqtdso[11] = (unsigned short )0;
  sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_I;
  sqlstm.sqhstl[12] = (unsigned long )2;
  sqlstm.sqhsts[12] = (         int  )0;
  sqlstm.sqindv[12] = (         short *)0;
  sqlstm.sqinds[12] = (         int  )0;
  sqlstm.sqharm[12] = (unsigned long )0;
  sqlstm.sqadto[12] = (unsigned short )0;
  sqlstm.sqtdso[12] = (unsigned short )0;
  sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_G;
  sqlstm.sqhstl[13] = (unsigned long )2;
  sqlstm.sqhsts[13] = (         int  )0;
  sqlstm.sqindv[13] = (         short *)0;
  sqlstm.sqinds[13] = (         int  )0;
  sqlstm.sqharm[13] = (unsigned long )0;
  sqlstm.sqadto[13] = (unsigned short )0;
  sqlstm.sqtdso[13] = (unsigned short )0;
  sqlstm.sqhstv[14] = (unsigned char  *)szhLetra_V;
  sqlstm.sqhstl[14] = (unsigned long )2;
  sqlstm.sqhsts[14] = (         int  )0;
  sqlstm.sqindv[14] = (         short *)0;
  sqlstm.sqinds[14] = (         int  )0;
  sqlstm.sqharm[14] = (unsigned long )0;
  sqlstm.sqadto[14] = (unsigned short )0;
  sqlstm.sqtdso[14] = (unsigned short )0;
  sqlstm.sqhstv[15] = (unsigned char  *)szhLetra_N;
  sqlstm.sqhstl[15] = (unsigned long )2;
  sqlstm.sqhsts[15] = (         int  )0;
  sqlstm.sqindv[15] = (         short *)0;
  sqlstm.sqinds[15] = (         int  )0;
  sqlstm.sqharm[15] = (unsigned long )0;
  sqlstm.sqadto[15] = (unsigned short )0;
  sqlstm.sqtdso[15] = (unsigned short )0;
  sqlstm.sqhstv[16] = (unsigned char  *)szhLetra_E;
  sqlstm.sqhstl[16] = (unsigned long )2;
  sqlstm.sqhsts[16] = (         int  )0;
  sqlstm.sqindv[16] = (         short *)0;
  sqlstm.sqinds[16] = (         int  )0;
  sqlstm.sqharm[16] = (unsigned long )0;
  sqlstm.sqadto[16] = (unsigned short )0;
  sqlstm.sqtdso[16] = (unsigned short )0;
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

 /* Reasignado:Ingresado:Generado:Visado */

		if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
		{
			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], SELECT CO_COBEXTERNA CUENTA => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
			return "SECOB";
		}

		if( sqlca.sqlcode != SQLNOTFOUND ) /* La cuenta ya esta en cobranza */
		{
			rtrim( stDatosCob.szCodEntidad );
			rtrim( stDatosCob.szCodMovimiento );
			rtrim( stDatosCob.szCodEnvio );
			rtrim( stDatosCob.szFecMovimiento );
			rtrim( szhAuxHoy );

			/* debemos validar si el cliente a ingresar, ya estaba en forma puntual */
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
			/* EXEC SQL
			SELECT COUNT(1)
			  INTO :ihCnt
			  FROM CO_ACCIONES
			 WHERE COD_CLIENTE = :lhCodCliente
			   AND NUM_SECUENCIA > :ihValor_cero
			   AND COD_RUTINA = :szhRutinaACEXT
			   AND COD_ESTADO = :szhEstadoEJE; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 17;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select count(1) into :b0  from CO_ACCIONES where (((COD_CL\
IENTE=:b1 and NUM_SECUENCIA>:b2) and COD_RUTINA=:b3) and COD_ESTADO=:b4)";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )308;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&ihCnt;
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
   sqlstm.sqhstv[2] = (unsigned char  *)&ihValor_cero;
   sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
   sqlstm.sqhsts[2] = (         int  )0;
   sqlstm.sqindv[2] = (         short *)0;
   sqlstm.sqinds[2] = (         int  )0;
   sqlstm.sqharm[2] = (unsigned long )0;
   sqlstm.sqadto[2] = (unsigned short )0;
   sqlstm.sqtdso[2] = (unsigned short )0;
   sqlstm.sqhstv[3] = (unsigned char  *)szhRutinaACEXT;
   sqlstm.sqhstl[3] = (unsigned long )6;
   sqlstm.sqhsts[3] = (         int  )0;
   sqlstm.sqindv[3] = (         short *)0;
   sqlstm.sqinds[3] = (         int  )0;
   sqlstm.sqharm[3] = (unsigned long )0;
   sqlstm.sqadto[3] = (unsigned short )0;
   sqlstm.sqtdso[3] = (unsigned short )0;
   sqlstm.sqhstv[4] = (unsigned char  *)szhEstadoEJE;
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

 

			if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
			{
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], SELECT COUNT(1) CO_ACCIONES => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
				return "SECOB";
			}
			
			if( ihCnt == 0 ) /* solo si el cliente no esta en Cobranza Externa */
			{
				/* debemos actualizar la co_gestion, con un alta transitoria */
				if( !bfnActualizaCoGestionClienteAcc(&pfLog, lhCodCliente, stDatosCob.lCodCuenta, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent, stDatosCob.szCodEntidad, szRutina, szMovimiento, CXX ) )
					return "UPGES";
	
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], Entidad => [%s] stDatosCob.szCodMovimiento => [%s].", LOG03, lhCodCliente, stDatosCob.szCodEntidad,stDatosCob.szCodMovimiento );  
	
		    	if( !strcmp( stDatosCob.szCodMovimiento, "SM" ) )				/* si no tiene movimiento */
				{
			       if( !strcmp( stDatosCob.szCodEnvio,"B" ) )               	/* si el envio es de baja */
		            { 
		                strcpy( stDatosCob.szCodMovimiento, "A" );            	/* cambiar cod_movimiento a 'A' */
		                strcpy( stDatosCob.szFecMovimiento, szhAuxHoy );      	/* cambiar fecha del movimiento */
		                ihIncrementoClientes = 0;                   			/* no incrementa la cantidad de clientes */
		            }                                    
		            else                                            			/* puede ser A o M */
		            { 
		                strcpy( stDatosCob.szCodMovimiento, "M" );            	/* cambiar cod_movimiento a 'M' */
		                strcpy( stDatosCob.szFecMovimiento, szhAuxHoy );      	/* cambiar fecha del movimiento */
		                ihIncrementoClientes = 1;                   			/* incrementa la cantidad de clientes */
		            }                                    
		        }
		        else
			   	{
			   		if( !strcmp( stDatosCob.szCodMovimiento, "B" ) )			/* si se iba a dar de baja */
		            {
		            	strcpy( stDatosCob.szCodMovimiento, "M" );            	/* cambiar cod_movimiento a 'A' */
		                strcpy( stDatosCob.szFecMovimiento, szhAuxHoy );      	/* cambiar fecha del movimiento */
		                ihIncrementoClientes = 0;                   			/* no incrementa la cantidad de clientes */
				    }
				    else                                            			/* puede ser A o M */
				    {
		                strcpy( stDatosCob.szFecMovimiento, szhAuxHoy );      	/* cambiar fecha del movimiento */
		                ihIncrementoClientes = 1;                   			/* incrementa la cantidad de clientes */
		            }
				} /* if( strcmp( stDatosCob.szCodMovimiento,"SM" ) == 0 ) */                                        
	
				/* transformamos decimales segun definicion para la operadora tratada */
				ifnTrazaHilos( modulo,&pfLog, "Valores antes de transformer stDatosCob.dMtoVencido = [%.4f].", LOG08, stDatosCob.dMtoVencido );  
				stDatosCob.dMtoVencido = fnCnvDouble( stDatosCob.dMtoVencido, 0 );
				ifnTrazaHilos( modulo,&pfLog, "Valores despues de transformer stDatosCob.dMtoVencido = [%.4f].", LOG08, stDatosCob.dMtoVencido );  
	
				sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
				/* EXEC SQL
				UPDATE CO_COBEXTERNA
				   SET CNT_CLIENTES = CNT_CLIENTES + :ihIncrementoClientes,
				       COD_MOVIMIENTO = :stDatosCob.szCodMovimiento, 
				       FEC_MOVIMIENTO = TO_DATE( :stDatosCob.szFecMovimiento, :szhYYYYMMDDHH24MISS ),
				       MTO_VENCIDO = :stDatosCob.dMtoVencido
				 WHERE NUM_IDENT = :stDatosCob.szNumIdent
				   AND COD_TIPIDENT = :stDatosCob.szCodTipIdent
				   AND COD_MOVIMIENTO <> :szhLetra_R 
				   AND COD_ENVIO NOT IN ( :szhLetra_R, :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_N, :szhLetra_E ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "update CO_COBEXTERNA  set CNT_CLIENTES=(CNT_CLIENTES+:b0)\
,COD_MOVIMIENTO=:b1,FEC_MOVIMIENTO=TO_DATE(:b2,:b3),MTO_VENCIDO=:b4 where (((N\
UM_IDENT=:b5 and COD_TIPIDENT=:b6) and COD_MOVIMIENTO<>:b7) and COD_ENVIO not \
 in (:b7,:b9,:b10,:b11,:b12,:b13))";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )343;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihIncrementoClientes;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodMovimiento);
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szFecMovimiento);
    sqlstm.sqhstl[2] = (unsigned long )15;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhYYYYMMDDHH24MISS;
    sqlstm.sqhstl[3] = (unsigned long )17;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&(stDatosCob.dMtoVencido);
    sqlstm.sqhstl[4] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)(stDatosCob.szNumIdent);
    sqlstm.sqhstl[5] = (unsigned long )21;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)(stDatosCob.szCodTipIdent);
    sqlstm.sqhstl[6] = (unsigned long )3;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_R;
    sqlstm.sqhstl[7] = (unsigned long )2;
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)szhLetra_R;
    sqlstm.sqhstl[8] = (unsigned long )2;
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)szhLetra_I;
    sqlstm.sqhstl[9] = (unsigned long )2;
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)szhLetra_G;
    sqlstm.sqhstl[10] = (unsigned long )2;
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_V;
    sqlstm.sqhstl[11] = (unsigned long )2;
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhLetra_N;
    sqlstm.sqhstl[12] = (unsigned long )2;
    sqlstm.sqhsts[12] = (         int  )0;
    sqlstm.sqindv[12] = (         short *)0;
    sqlstm.sqinds[12] = (         int  )0;
    sqlstm.sqharm[12] = (unsigned long )0;
    sqlstm.sqadto[12] = (unsigned short )0;
    sqlstm.sqtdso[12] = (unsigned short )0;
    sqlstm.sqhstv[13] = (unsigned char  *)szhLetra_E;
    sqlstm.sqhstl[13] = (unsigned long )2;
    sqlstm.sqhsts[13] = (         int  )0;
    sqlstm.sqindv[13] = (         short *)0;
    sqlstm.sqinds[13] = (         int  )0;
    sqlstm.sqharm[13] = (unsigned long )0;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* Reasignado:Ingresado:Generado:Visado */
	
				if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
				{
					ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] UPDATE CO_COBEXTERNA => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
					return "UPCOB"; /* error oracle*/
				}
	
				if( ihIncrementoClientes > 0 ) /* si se incrementan los clientes */
				{
					/*  debemos dejar consistente el registro de no clientes, si existiera */
					sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
					/* EXEC SQL
					UPDATE CO_COBEXTERNA
					   SET CNT_CLIENTES = CNT_CLIENTES + :ihIncrementoClientes,
					       MTO_VENCIDO = :stDatosCob.dMtoVencido
					 WHERE NUM_IDENT = :stDatosCob.szNumIdent
					   AND COD_TIPIDENT = :stDatosCob.szCodTipIdent
					   AND COD_MOVIMIENTO = :szhMovimSM
					   AND COD_ENVIO IN ( :szhLetra_I, :szhLetra_G, :szhLetra_V ); */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 17;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_COBEXTERNA  set CNT_CLIENTES=(CNT_CLIENTES+:b0\
),MTO_VENCIDO=:b1 where (((NUM_IDENT=:b2 and COD_TIPIDENT=:b3) and COD_MOVIMIE\
NTO=:b4) and COD_ENVIO in (:b5,:b6,:b7))";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )414;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)&ihIncrementoClientes;
     sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&(stDatosCob.dMtoVencido);
     sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szNumIdent);
     sqlstm.sqhstl[2] = (unsigned long )21;
     sqlstm.sqhsts[2] = (         int  )0;
     sqlstm.sqindv[2] = (         short *)0;
     sqlstm.sqinds[2] = (         int  )0;
     sqlstm.sqharm[2] = (unsigned long )0;
     sqlstm.sqadto[2] = (unsigned short )0;
     sqlstm.sqtdso[2] = (unsigned short )0;
     sqlstm.sqhstv[3] = (unsigned char  *)(stDatosCob.szCodTipIdent);
     sqlstm.sqhstl[3] = (unsigned long )3;
     sqlstm.sqhsts[3] = (         int  )0;
     sqlstm.sqindv[3] = (         short *)0;
     sqlstm.sqinds[3] = (         int  )0;
     sqlstm.sqharm[3] = (unsigned long )0;
     sqlstm.sqadto[3] = (unsigned short )0;
     sqlstm.sqtdso[3] = (unsigned short )0;
     sqlstm.sqhstv[4] = (unsigned char  *)szhMovimSM;
     sqlstm.sqhstl[4] = (unsigned long )3;
     sqlstm.sqhsts[4] = (         int  )0;
     sqlstm.sqindv[4] = (         short *)0;
     sqlstm.sqinds[4] = (         int  )0;
     sqlstm.sqharm[4] = (unsigned long )0;
     sqlstm.sqadto[4] = (unsigned short )0;
     sqlstm.sqtdso[4] = (unsigned short )0;
     sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_I;
     sqlstm.sqhstl[5] = (unsigned long )2;
     sqlstm.sqhsts[5] = (         int  )0;
     sqlstm.sqindv[5] = (         short *)0;
     sqlstm.sqinds[5] = (         int  )0;
     sqlstm.sqharm[5] = (unsigned long )0;
     sqlstm.sqadto[5] = (unsigned short )0;
     sqlstm.sqtdso[5] = (unsigned short )0;
     sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_G;
     sqlstm.sqhstl[6] = (unsigned long )2;
     sqlstm.sqhsts[6] = (         int  )0;
     sqlstm.sqindv[6] = (         short *)0;
     sqlstm.sqinds[6] = (         int  )0;
     sqlstm.sqharm[6] = (unsigned long )0;
     sqlstm.sqadto[6] = (unsigned short )0;
     sqlstm.sqtdso[6] = (unsigned short )0;
     sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_V;
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}

 /* Ingresado:Generado:Visado */
	
					if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
					{
						ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], UPDATE CO_COBEXTERNA NO CLIENTE => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
						return "UPCON"; /* error oracle*/
					}
					
				} /* if( ihIncrementoClientes > 0 ) */
				
			} /* if( ihCnt == 0 ) */

            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
            /* EXEC SQL UPDATE CO_MOROSOS
                     SET COD_AGENTE = (SELECT UNIQUE DES_ENTIDAD  
	                                 FROM CO_ENTCOB A, CO_COBEXTERNA B
	                                WHERE A.COD_ENTIDAD = B.COD_ENTIDAD
	                                  AND B.NUM_IDENT   =  :stDatosCob.szNumIdent 
                                          AND B.COD_TIPIDENT = :stDatosCob.szCodTipIdent
                                          AND b.cod_movimiento not in ( :szhLetra_B, :szhLetra_R ) 
                                          AND b.cod_envio not in ( :szhLetra_B, :szhLetra_R ))     
                     WHERE NUM_IDENT  = :stDatosCob.szNumIdent
                     AND COD_TIPIDENT = :stDatosCob.szCodTipIdent; */ 

{
            struct sqlexd sqlstm;
            sqlstm.sqlvsn = 12;
            sqlstm.arrsiz = 17;
            sqlstm.sqladtp = &sqladt;
            sqlstm.sqltdsp = &sqltds;
            sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=(select unique \
DES_ENTIDAD  from CO_ENTCOB A ,CO_COBEXTERNA B where ((((A.COD_ENTIDAD=B.COD_E\
NTIDAD and B.NUM_IDENT=:b0) and B.COD_TIPIDENT=:b1) and b.cod_movimiento not  \
in (:b2,:b3)) and b.cod_envio not  in (:b2,:b3))) where (NUM_IDENT=:b0 and COD\
_TIPIDENT=:b1)";
            sqlstm.iters = (unsigned int  )1;
            sqlstm.offset = (unsigned int  )461;
            sqlstm.cud = sqlcud0;
            sqlstm.sqlest = (unsigned char  *)&sqlca;
            sqlstm.sqlety = (unsigned short)256;
            sqlstm.occurs = (unsigned int  )0;
            sqlstm.sqhstv[0] = (unsigned char  *)(stDatosCob.szNumIdent);
            sqlstm.sqhstl[0] = (unsigned long )21;
            sqlstm.sqhsts[0] = (         int  )0;
            sqlstm.sqindv[0] = (         short *)0;
            sqlstm.sqinds[0] = (         int  )0;
            sqlstm.sqharm[0] = (unsigned long )0;
            sqlstm.sqadto[0] = (unsigned short )0;
            sqlstm.sqtdso[0] = (unsigned short )0;
            sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodTipIdent);
            sqlstm.sqhstl[1] = (unsigned long )3;
            sqlstm.sqhsts[1] = (         int  )0;
            sqlstm.sqindv[1] = (         short *)0;
            sqlstm.sqinds[1] = (         int  )0;
            sqlstm.sqharm[1] = (unsigned long )0;
            sqlstm.sqadto[1] = (unsigned short )0;
            sqlstm.sqtdso[1] = (unsigned short )0;
            sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_B;
            sqlstm.sqhstl[2] = (unsigned long )2;
            sqlstm.sqhsts[2] = (         int  )0;
            sqlstm.sqindv[2] = (         short *)0;
            sqlstm.sqinds[2] = (         int  )0;
            sqlstm.sqharm[2] = (unsigned long )0;
            sqlstm.sqadto[2] = (unsigned short )0;
            sqlstm.sqtdso[2] = (unsigned short )0;
            sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_R;
            sqlstm.sqhstl[3] = (unsigned long )2;
            sqlstm.sqhsts[3] = (         int  )0;
            sqlstm.sqindv[3] = (         short *)0;
            sqlstm.sqinds[3] = (         int  )0;
            sqlstm.sqharm[3] = (unsigned long )0;
            sqlstm.sqadto[3] = (unsigned short )0;
            sqlstm.sqtdso[3] = (unsigned short )0;
            sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_B;
            sqlstm.sqhstl[4] = (unsigned long )2;
            sqlstm.sqhsts[4] = (         int  )0;
            sqlstm.sqindv[4] = (         short *)0;
            sqlstm.sqinds[4] = (         int  )0;
            sqlstm.sqharm[4] = (unsigned long )0;
            sqlstm.sqadto[4] = (unsigned short )0;
            sqlstm.sqtdso[4] = (unsigned short )0;
            sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_R;
            sqlstm.sqhstl[5] = (unsigned long )2;
            sqlstm.sqhsts[5] = (         int  )0;
            sqlstm.sqindv[5] = (         short *)0;
            sqlstm.sqinds[5] = (         int  )0;
            sqlstm.sqharm[5] = (unsigned long )0;
            sqlstm.sqadto[5] = (unsigned short )0;
            sqlstm.sqtdso[5] = (unsigned short )0;
            sqlstm.sqhstv[6] = (unsigned char  *)(stDatosCob.szNumIdent);
            sqlstm.sqhstl[6] = (unsigned long )21;
            sqlstm.sqhsts[6] = (         int  )0;
            sqlstm.sqindv[6] = (         short *)0;
            sqlstm.sqinds[6] = (         int  )0;
            sqlstm.sqharm[6] = (unsigned long )0;
            sqlstm.sqadto[6] = (unsigned short )0;
            sqlstm.sqtdso[6] = (unsigned short )0;
            sqlstm.sqhstv[7] = (unsigned char  *)(stDatosCob.szCodTipIdent);
            sqlstm.sqhstl[7] = (unsigned long )3;
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
            sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



            if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
            {
               ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld], UPDATE CO_MOROSOS COD_AGENTE de RUT => [%s]", LOG00,lhCodCliente, sqlca.sqlerrm.sqlerrmc );
               return "UPCON"; /* error oracle*/
            }

			return "OK"; /* No hace nada mas, porque ya esta como cobranza Pre-Judicial */
			
		} /* if( sqlca.sqlcode != SQLNOTFOUND ) */

	} /* if( !strcmp( szhEntGestCob, "C" ) ) */

    /* debemos actualizar la co_gestion, con un alta transitoria */
	sprintf( stDatosCob.szCodEntidad, "X\0" );
	if( !bfnActualizaCoGestionClienteAcc(&pfLog, lhCodCliente, 0, stDatosCob.szNumIdent, stDatosCob.szCodTipIdent, stDatosCob.szCodEntidad, szRutina, szMovimiento, CXX ) )
		return "UPGES";

	/* Determinar comuna asociada a la direccion de correspondencia del cliente */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	/* EXEC SQL
	SELECT C.COD_REGION, 
		   C.COD_COMUNA
	  INTO :szhCodRegion, 
		   :szhCodComuna
	  FROM GE_DIRECCIONES C, GA_DIRECCLI B
	 WHERE B.COD_CLIENTE = :lhCodCliente
	   AND B.COD_TIPDIRECCION = :ihDirCorrespondencia  	/o 3 o/
	   AND C.COD_DIRECCION = B.COD_DIRECCION; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select C.COD_REGION ,C.COD_COMUNA into :b0,:b1  from GE_DIRE\
CCIONES C ,GA_DIRECCLI B where ((B.COD_CLIENTE=:b2 and B.COD_TIPDIRECCION=:b3)\
 and C.COD_DIRECCION=B.COD_DIRECCION)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )508;
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
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodComuna;
 sqlstm.sqhstl[1] = (unsigned long )6;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&ihDirCorrespondencia;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



    if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] SELECT GE_DIRECCIONES => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND";
    } 
	else if( sqlca.sqlcode == SQLNOTFOUND )
	{
    	/* Si el cliente no tiene direccion de correspondencia, se busca el menor codigo de las que tiene mgg_27.03.01 */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
		/* EXEC SQL
		SELECT C.COD_REGION, C.COD_COMUNA
		  INTO :szhCodRegion, :szhCodComuna
		  FROM GE_DIRECCIONES C, GA_DIRECCLI B
		 WHERE B.COD_CLIENTE = :lhCodCliente
		   AND B.COD_TIPDIRECCION = ( SELECT MIN( COD_TIPDIRECCION ) FROM GA_DIRECCLI WHERE COD_CLIENTE = :lhCodCliente )
		   AND C.COD_DIRECCION = B.COD_DIRECCION; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 17;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select C.COD_REGION ,C.COD_COMUNA into :b0,:b1  from GE_DIR\
ECCIONES C ,GA_DIRECCLI B where ((B.COD_CLIENTE=:b2 and B.COD_TIPDIRECCION=(se\
lect min(COD_TIPDIRECCION)  from GA_DIRECCLI where COD_CLIENTE=:b2)) and C.COD\
_DIRECCION=B.COD_DIRECCION)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )539;
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
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodComuna;
  sqlstm.sqhstl[1] = (unsigned long )6;
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
  sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCliente;
  sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
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
        	ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] SELECT GE_DIRECCIONES => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        	return "PND";
		} 
		else if( sqlca.sqlcode == SQLNOTFOUND )
		{
        	ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] NO TIENE DIRECCION DE CORRESPONDENCIA.", LOG00, lhCodCliente );  
        	return "NODIR";     /* No encontro direccion para el cliente */
		}
	}

	sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	/* EXEC SQL
	SELECT COD_OPERADORA_SCL
	INTO   :szCodOperadora
	FROM   GE_OPERADORA_SCL_LOCAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_OPERADORA_SCL into :b0  from GE_OPERADORA_SCL_LOC\
AL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )570;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCodOperadora;
 sqlstm.sqhstl[0] = (unsigned long )21;
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


	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND ) 	{  
		ifnTrazaHilos( modulo,&pfLog,  "Error al recuperar Codigo Operadora Local ==> [%s].", LOG00, sqlca.sqlerrm.sqlerrmc );
		return "EPARG";
	}  

	ifnTrazaHilos( modulo,&pfLog,  "Valor de Operadora recuperado ==> [%s].", LOG05, szCodOperadora);

   if (ifnRecuperaGedParametro(&pfLog, "OPER_CALCULO_REGION", "CO", szValParametro, CXX )!=0) 
      return "EPARG";

	rtrim( szCodOperadora );
	rtrim( szValParametro );

	/* esto es valido solo para la operadora TMC */
	if( !strcmp( szCodOperadora, szValParametro ) )
    {
	    if( atoi( szhCodRegion ) != iMetropolitana ) /* la direccion no es de la region metropolitana */
	    {
	        /*-- Verificar si el Rut tiene asociados clientes con direccion en Santiago */
	        iResp = ifnRutMetropolitano(&pfLog, lhCodCliente, &i, CXX );
	        if( iResp < 0 )
	            return "PND";       /* error oracle */
	        else if( iResp == 0 )
	            return "NORUT";     /* no hallo el rut */
	    }
	    else
	    {
	        i = 1 ; /* marca como metropolitano */
	    }

	    strcpy( stDatosCob.szRutSantiago, "N" );
	    if( i == 1 )   
	    {
			 if (ifnRecuperaGedParametro(&pfLog, "COMUNA_STGO_CENTRO", "CO", szhCodComuna, CXX )!=0) 
			    return "EPARG";

          strcpy( stDatosCob.szRutSantiago, "S" );
	    }
	}
   ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Comuna => [%s].", LOG03, lhCodCliente, szhCodComuna );  
   /* Obtiene los agentes de cobranzas de la comuna y sus porcentajes definidos */
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL 
    DECLARE curEntExt CURSOR FOR
    SELECT A.COD_AGENTE,
           A.PRC_ASIGNACION,
           C.COD_ENTIDAD
      FROM CO_ENTCOB C,
           CO_AGENCOB B,
           CO_AGENCOMU A
     WHERE A.COD_COMUNA  = :szhCodComuna 
       AND B.COD_AGENTE  = A.COD_AGENTE
       AND C.COD_ENTIDAD = B.COD_ENTIDAD
       AND C.TIP_ENTIDAD = :szhLetra_E  /o EXTERNO o/
       AND C.TIP_COBRANZA != :szhLetra_J ; */ 
 /* JUDICIAL */

    if( sqlca.sqlcode )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] DECLARE curEntExt => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "BUSEN";   
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL OPEN curEntExt ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = sq0013;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )589;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhLetra_E;
    sqlstm.sqhstl[1] = (unsigned long )2;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_J;
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


    if( sqlca.sqlcode )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] OPEN curEntExt => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "BUSEN";   
    }

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL 
    FETCH curEntExt 
     INTO :szhCodAgente, :ihPrcAsignado, :szhCodEntidad; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )500;
    sqlstm.offset = (unsigned int  )616;
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
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodEntidad;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )6;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqharc[2] = (unsigned long  *)0;
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



    lTotalRows = SQLROWS;    

    if ( sqlca.sqlcode != SQLNOTFOUND && sqlca.sqlcode != SQLOK )
	{
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] FETCH curEntExt => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return "BUSEN";
	}
	else if ( sqlca.sqlcode != SQLNOTFOUND )
	{
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] FETCH curEntExt => Sobrepasado Maximo de elementos.", LOG01, lhCodCliente );  
        return "PND";
	}

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL CLOSE curEntExt ; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )643;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


    if( sqlca.sqlcode )
    {   
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] CLOSE curEntExt => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND";            
    }

	iAsignado = 0;

	if( lTotalRows > 0 ) 
	{
		if( ( ihPrcAsignado[0] == 100 ) ) 
		{    
			/* transformamos decimales segun definicion para la operadora tratada */
			ifnTrazaHilos( modulo,&pfLog, "Valores antes de transformer stDatosCob.dMtoVencido = [%.4f].", LOG05, stDatosCob.dMtoVencido );  
			stDatosCob.dMtoVencido = fnCnvDouble( stDatosCob.dMtoVencido, 0 );
			ifnTrazaHilos( modulo,&pfLog, "Valores despues de transformer stDatosCob.dMtoVencido = [%.4f].", LOG05, stDatosCob.dMtoVencido );  
			
			rtrim( szhCodAgente[0] );
			rtrim( szhCodEntidad[0] );
		    
		    sprintf( stDatosCob.szCodEntidad, "%s\0", szhCodEntidad[0] );

			if( !bfnInsertaCobExterna( &pfLog, &stDatosCob, szhEntGestCob, CXX ) )
				return "INCOB";

			sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
			/* EXEC SQL 
			UPDATE CO_MOROSOS
			   SET COD_AGENTE  = :szhCodAgente[0] 
			 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 17;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=:b\
1";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )658;
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
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] INSERT CO_COBEXTERNA => [%s].", LOG00, lhCodCliente, szhCodAgente[0], sqlca.sqlerrm.sqlerrmc );  
				return "UPMOR";            
			}
			else
			{   
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] Ok.", LOG03, lhCodCliente, szhCodAgente[0] );
				sprintf( szhCodEntidadAsig, "%s", szhCodEntidad[0] );
				sprintf( szhCodAgenteAsig, "%s", szhCodAgente[0] );
				iAsignado = 1;
			} /* ( ( ihPrcAsignado[0] == 100 ) ) */
		}            
		else /* el primero no tenia el 100% */
		{
			for( i = 0; i < lTotalRows; i++ ) /* procesar cada agente (contar sus morosos) */
			{
				rtrim( szhCodEntidad[i] );

				sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
				/* EXEC SQL      
				SELECT COUNT( UNIQUE E.NUM_IDENT )   
				  INTO :ihMorososAgente[i]
				  FROM CO_MOROSOS M, CO_COBEXTERNA E
				 WHERE E.COD_ENTIDAD = :szhCodEntidad[i]
				   AND E.COD_ENVIO NOT IN ( :szhLetra_I, :szhLetra_G, :szhLetra_V, :szhLetra_E, :szhLetra_N )
				   AND E.NUM_IDENT = M.NUM_IDENT
				   AND E.COD_TIPIDENT = M.COD_TIPIDENT
				   AND M.COD_COMUNA= :szhCodComuna; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 17;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(unique E.NUM_IDENT) into :b0  from CO_MOROSO\
S M ,CO_COBEXTERNA E where ((((E.COD_ENTIDAD=:b1 and E.COD_ENVIO not  in (:b2,\
:b3,:b4,:b5,:b6)) and E.NUM_IDENT=M.NUM_IDENT) and E.COD_TIPIDENT=M.COD_TIPIDE\
NT) and M.COD_COMUNA=:b7)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )681;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodEntidad[i];
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhLetra_I;
    sqlstm.sqhstl[2] = (unsigned long )2;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhLetra_G;
    sqlstm.sqhstl[3] = (unsigned long )2;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhLetra_V;
    sqlstm.sqhstl[4] = (unsigned long )2;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_E;
    sqlstm.sqhstl[5] = (unsigned long )2;
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)szhLetra_N;
    sqlstm.sqhstl[6] = (unsigned long )2;
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)szhCodComuna;
    sqlstm.sqhstl[7] = (unsigned long )6;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



				if( sqlca.sqlcode )
				{   
					ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] SELECT COUNT CO_COBEXTERNA => [%s].", LOG00, lhCodCliente, szhCodAgente[i], sqlca.sqlerrm.sqlerrmc );  
					return "SEMOR";
				}

				iMorososComuna += ihMorososAgente[i];      /* Acumula el total de morosos de la comuna */
				iPorcentajeTotal += ihPrcAsignado[i];      /* Suma los porcentajes de cada agente */
			}/* end for i  */

			rtrim( szhCodAgente[i] );

			if( iPorcentajeTotal != 100 )
				ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] LA SUMA DE PORCENTAJES NO DA 100%% [%d].", LOG02, lhCodCliente, iPorcentajeTotal );  

			for( i = 0; i < lTotalRows; i++ ) /* procesar cada agente (elegir cual asignar) */
			{
				rtrim( szhCodAgente[i] );
				rtrim( szhCodEntidad[i] );

				fPorcentajeDefinido = (float) ihPrcAsignado[i];
				fPorcentajeActual = ( iMorososComuna == 0 ) ? 0.0 : (float)( ( 100 * (float)ihMorososAgente[i] ) / (float)iMorososComuna );
				
				ifnTrazaHilos( modulo,&pfLog, "[%d] COD_AGENTE => [%s] fPorcentajeDefinido => [%f] fPorcentajeActual => [%f].",
									  LOG05, i, szhCodAgente[i], fPorcentajeDefinido, fPorcentajeActual );  

				if( fPorcentajeDefinido >= fPorcentajeActual )
				{   
					/* transformamos decimales segun definicion para la operadora tratada */
					ifnTrazaHilos( modulo,&pfLog, "Valores antes de transformer stDatosCob.dMtoVencido = [%.4f].", LOG05, stDatosCob.dMtoVencido );  
					stDatosCob.dMtoVencido = fnCnvDouble( stDatosCob.dMtoVencido, 0 );
					ifnTrazaHilos( modulo,&pfLog, "Valores despues de transformer stDatosCob.dMtoVencido = [%.4f].", LOG05, stDatosCob.dMtoVencido );  

				    sprintf( stDatosCob.szCodEntidad, "%s\0", szhCodEntidad[i] );
		
					if( !bfnInsertaCobExterna( &pfLog, &stDatosCob, szhEntGestCob, CXX ) )
						return "INCOB";

					sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
					/* EXEC SQL 
					UPDATE CO_MOROSOS
					   SET COD_AGENTE = :szhCodAgente[i] 
					 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 17;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_CLIENTE=\
:b1";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )728;
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



					if (sqlca.sqlcode)
					{   
						ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] UPDATE CO_MOROSOS => [%s].", LOG00, lhCodCliente, szhCodAgente[i], sqlca.sqlerrm.sqlerrmc );  
						return "UPMOR";
					}  
					else
					{   
						ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Agente => [%s] Ok.", LOG03, lhCodCliente, szhCodAgente[i] );  
						sprintf( szhCodEntidadAsig, "%s", szhCodEntidad[i] );
						sprintf( szhCodAgenteAsig, "%s", szhCodAgente[i] );
						iAsignado = 1;     
					}
					break;
				}
			} /* end for i */
		} 
	}

    if( iAsignado == 0)
    {
        /* 2 situaciones : ( lTotalRows <= 0 ) o nunca se cumplio que (fPorcentajeDefinido >= fPorcentajeActual ) */
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] NOAGE => No se encontro agente", LOG01, lhCodCliente );  
        return "NOAGE";
    }

	if( !strcmp( szhEntGestCob, szENTIDADCUENTA ) )	/* si la cobranza es a nivel de cuenta */
	{
		/* Se debe actualizar el agente de cobranza a los otros clientes de la cuenta */
		sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
		/* EXEC SQL 
		DECLARE curClientes CURSOR FOR
		SELECT COD_CLIENTE,
			   COD_AGENTE, 
			   COD_CUENTA
		  FROM CO_MOROSOS
		 WHERE NUM_IDENT = :stDatosCob.szNumIdent
		   AND COD_TIPIDENT = :stDatosCob.szCodTipIdent; */ 

	
	    if( sqlca.sqlcode )
	    {
	        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] DECLARE curClientes => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	        return "SEMOR";
	    }
	
	    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	    /* EXEC SQL 
	    OPEN curClientes ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 17;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = sq0017;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )751;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqcmod = (unsigned int )0;
     sqlstm.sqhstv[0] = (unsigned char  *)(stDatosCob.szNumIdent);
     sqlstm.sqhstl[0] = (unsigned long )21;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)(stDatosCob.szCodTipIdent);
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
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	    
	    if( sqlca.sqlcode )
	    {
	        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] OPEN curClientes => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	        return "SEMOR";
	    }

		iResp = 0;
	    
	    while( 1 )
	    {
			sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
			/* EXEC SQL
	        FETCH curClientes
	         INTO :lhCodClienteNew,
	        	  :szhCodAgenteNew,
	        	  :lhCodCuentaNew; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 17;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )774;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqfoff = (         int )0;
   sqlstm.sqfmod = (unsigned int )2;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
   sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         short *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned long )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (unsigned char  *)szhCodAgenteNew;
   sqlstm.sqhstl[1] = (unsigned long )31;
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         short *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned long )0;
   sqlstm.sqadto[1] = (unsigned short )0;
   sqlstm.sqtdso[1] = (unsigned short )0;
   sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCuentaNew;
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


	
	        if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	        {
		        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] FETCH curClientes => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
	            iResp = 1;
	            break;
	        }
	        else if( sqlca.sqlcode == SQLNOTFOUND )
	        {
	            ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] FIN CURSOR Clientes.", LOG03, lhCodCliente );
	            iResp = 0;
	            break; /* no mas datos */
	        }
	
	        if( strcmp( szhCodAgenteNew, szhCodAgenteAsig ) ) /* si son != */
	        {
	            sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	            /* EXEC SQL
	            UPDATE CO_MOROSOS
				   SET COD_AGENTE = :szhCodAgenteAsig
	             WHERE COD_CLIENTE = :lhCodClienteNew; */ 

{
             struct sqlexd sqlstm;
             sqlstm.sqlvsn = 12;
             sqlstm.arrsiz = 17;
             sqlstm.sqladtp = &sqladt;
             sqlstm.sqltdsp = &sqltds;
             sqlstm.stmt = "update CO_MOROSOS  set COD_AGENTE=:b0 where COD_\
CLIENTE=:b1";
             sqlstm.iters = (unsigned int  )1;
             sqlstm.offset = (unsigned int  )801;
             sqlstm.cud = sqlcud0;
             sqlstm.sqlest = (unsigned char  *)&sqlca;
             sqlstm.sqlety = (unsigned short)256;
             sqlstm.occurs = (unsigned int  )0;
             sqlstm.sqhstv[0] = (unsigned char  *)szhCodAgenteAsig;
             sqlstm.sqhstl[0] = (unsigned long )31;
             sqlstm.sqhsts[0] = (         int  )0;
             sqlstm.sqindv[0] = (         short *)0;
             sqlstm.sqinds[0] = (         int  )0;
             sqlstm.sqharm[0] = (unsigned long )0;
             sqlstm.sqadto[0] = (unsigned short )0;
             sqlstm.sqtdso[0] = (unsigned short )0;
             sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteNew;
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
	                ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] UPDATE CO_MOROSOS => [%s]", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
	                iResp = 1;
	                break; /* error sql */
	            }

                memset(szCodGestion, 0, sizeof(szCodGestion));
                strcpy(szCodGestion,"007");
                sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                /* EXEC SQL SELECT count(*)
                         INTO   :iCountGest
                         FROM CO_GESTION
                         WHERE COD_CLIENTE = :lhCodClienteNew
                         AND   COD_GESTION = :szCodGestion; */ 

{
                struct sqlexd sqlstm;
                sqlstm.sqlvsn = 12;
                sqlstm.arrsiz = 17;
                sqlstm.sqladtp = &sqladt;
                sqlstm.sqltdsp = &sqltds;
                sqlstm.stmt = "select count(*)  into :b0  from CO_GESTION wh\
ere (COD_CLIENTE=:b1 and COD_GESTION=:b2)";
                sqlstm.iters = (unsigned int  )1;
                sqlstm.offset = (unsigned int  )824;
                sqlstm.selerr = (unsigned short)1;
                sqlstm.cud = sqlcud0;
                sqlstm.sqlest = (unsigned char  *)&sqlca;
                sqlstm.sqlety = (unsigned short)256;
                sqlstm.occurs = (unsigned int  )0;
                sqlstm.sqhstv[0] = (unsigned char  *)&iCountGest;
                sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
                sqlstm.sqhsts[0] = (         int  )0;
                sqlstm.sqindv[0] = (         short *)0;
                sqlstm.sqinds[0] = (         int  )0;
                sqlstm.sqharm[0] = (unsigned long )0;
                sqlstm.sqadto[0] = (unsigned short )0;
                sqlstm.sqtdso[0] = (unsigned short )0;
                sqlstm.sqhstv[1] = (unsigned char  *)&lhCodClienteNew;
                sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
                sqlstm.sqhsts[1] = (         int  )0;
                sqlstm.sqindv[1] = (         short *)0;
                sqlstm.sqinds[1] = (         int  )0;
                sqlstm.sqharm[1] = (unsigned long )0;
                sqlstm.sqadto[1] = (unsigned short )0;
                sqlstm.sqtdso[1] = (unsigned short )0;
                sqlstm.sqhstv[2] = (unsigned char  *)szCodGestion;
                sqlstm.sqhstl[2] = (unsigned long )4;
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



                if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
                {
                   ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(COD_GESTION:%s) SELECT count(*) FROM CO_GESTION: %s", LOG00, lhCodClienteNew, szCodGestion, sqlca.sqlerrm.sqlerrmc );
                   return FALSE;
                }

                /* Si no existe el cliente + codigo de gestion se inserta*/
                if (iCountGest == 0)
                {
				   ifnTrazaHilos( modulo,&pfLog, "Datos Insert CO_GESTION.\n"
									"\t\t   lhCodClienteNew         => [%ld],\n"
									"\t\t   lhCodCuentaNew          => [%ld],\n"
									"\t\t   stDatosCob.szCodEntidad => [%s],\n"
									"\t\t   stDatosCob.szNumIdent   => [%s],\n",
									LOG06,
									lhCodClienteNew,
									lhCodCuentaNew,
									stDatosCob.szCodEntidad,
									stDatosCob.szNumIdent );
				   sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
				   /* EXEC SQL
				   INSERT INTO CO_GESTION
				   (
					   COD_CLIENTE,
					   COD_CUENTA,
					   COD_TIPIDENT,
					   NUM_IDENT,
					   COD_GESTION,
					   FEC_GESTION,
					   OBS_GESTION,
					   NOM_USUARIO 
				   )
				   VALUES
				   (
					   :lhCodClienteNew,
					   :lhCodCuentaNew,
					   :stDatosCob.szCodTipIdent,
					   :stDatosCob.szNumIdent,
					   :szCodGestion,
					   SYSDATE,
					   :szhEjecutivoCob,
					   USER
				   ); */ 

{
       struct sqlexd sqlstm;
       sqlstm.sqlvsn = 12;
       sqlstm.arrsiz = 17;
       sqlstm.sqladtp = &sqladt;
       sqlstm.sqltdsp = &sqltds;
       sqlstm.stmt = "insert into CO_GESTION (COD_CLIENTE,COD_CUENTA,COD_TIP\
IDENT,NUM_IDENT,COD_GESTION,FEC_GESTION,OBS_GESTION,NOM_USUARIO) values (:b0,:\
b1,:b2,:b3,:b4,SYSDATE,:b5,USER)";
       sqlstm.iters = (unsigned int  )1;
       sqlstm.offset = (unsigned int  )851;
       sqlstm.cud = sqlcud0;
       sqlstm.sqlest = (unsigned char  *)&sqlca;
       sqlstm.sqlety = (unsigned short)256;
       sqlstm.occurs = (unsigned int  )0;
       sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
       sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[0] = (         int  )0;
       sqlstm.sqindv[0] = (         short *)0;
       sqlstm.sqinds[0] = (         int  )0;
       sqlstm.sqharm[0] = (unsigned long )0;
       sqlstm.sqadto[0] = (unsigned short )0;
       sqlstm.sqtdso[0] = (unsigned short )0;
       sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCuentaNew;
       sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
       sqlstm.sqhsts[1] = (         int  )0;
       sqlstm.sqindv[1] = (         short *)0;
       sqlstm.sqinds[1] = (         int  )0;
       sqlstm.sqharm[1] = (unsigned long )0;
       sqlstm.sqadto[1] = (unsigned short )0;
       sqlstm.sqtdso[1] = (unsigned short )0;
       sqlstm.sqhstv[2] = (unsigned char  *)(stDatosCob.szCodTipIdent);
       sqlstm.sqhstl[2] = (unsigned long )3;
       sqlstm.sqhsts[2] = (         int  )0;
       sqlstm.sqindv[2] = (         short *)0;
       sqlstm.sqinds[2] = (         int  )0;
       sqlstm.sqharm[2] = (unsigned long )0;
       sqlstm.sqadto[2] = (unsigned short )0;
       sqlstm.sqtdso[2] = (unsigned short )0;
       sqlstm.sqhstv[3] = (unsigned char  *)(stDatosCob.szNumIdent);
       sqlstm.sqhstl[3] = (unsigned long )21;
       sqlstm.sqhsts[3] = (         int  )0;
       sqlstm.sqindv[3] = (         short *)0;
       sqlstm.sqinds[3] = (         int  )0;
       sqlstm.sqharm[3] = (unsigned long )0;
       sqlstm.sqadto[3] = (unsigned short )0;
       sqlstm.sqtdso[3] = (unsigned short )0;
       sqlstm.sqhstv[4] = (unsigned char  *)szCodGestion;
       sqlstm.sqhstl[4] = (unsigned long )4;
       sqlstm.sqhsts[4] = (         int  )0;
       sqlstm.sqindv[4] = (         short *)0;
       sqlstm.sqinds[4] = (         int  )0;
       sqlstm.sqharm[4] = (unsigned long )0;
       sqlstm.sqadto[4] = (unsigned short )0;
       sqlstm.sqtdso[4] = (unsigned short )0;
       sqlstm.sqhstv[5] = (unsigned char  *)szhEjecutivoCob;
       sqlstm.sqhstl[5] = (unsigned long )41;
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
       sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
	               if( sqlca.sqlcode )
	               {
	                   ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] INSERT CO_GESTION => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
	                   iResp = 1; 
	                   break; /* error sql */
	               }
               }
               else
               {
                  /* Si existe el cliente + codigo de gestion se actualiza fecha*/
                  sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
                  /* EXEC SQL UPDATE CO_GESTION
                           SET    FEC_GESTION = SYSDATE
                           WHERE  COD_CLIENTE = :lhCodClienteNew
                            AND   COD_GESTION = :szCodGestion; */ 

{
                  struct sqlexd sqlstm;
                  sqlstm.sqlvsn = 12;
                  sqlstm.arrsiz = 17;
                  sqlstm.sqladtp = &sqladt;
                  sqlstm.sqltdsp = &sqltds;
                  sqlstm.stmt = "update CO_GESTION  set FEC_GESTION=SYSDATE \
where (COD_CLIENTE=:b0 and COD_GESTION=:b1)";
                  sqlstm.iters = (unsigned int  )1;
                  sqlstm.offset = (unsigned int  )890;
                  sqlstm.cud = sqlcud0;
                  sqlstm.sqlest = (unsigned char  *)&sqlca;
                  sqlstm.sqlety = (unsigned short)256;
                  sqlstm.occurs = (unsigned int  )0;
                  sqlstm.sqhstv[0] = (unsigned char  *)&lhCodClienteNew;
                  sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
                  sqlstm.sqhsts[0] = (         int  )0;
                  sqlstm.sqindv[0] = (         short *)0;
                  sqlstm.sqinds[0] = (         int  )0;
                  sqlstm.sqharm[0] = (unsigned long )0;
                  sqlstm.sqadto[0] = (unsigned short )0;
                  sqlstm.sqtdso[0] = (unsigned short )0;
                  sqlstm.sqhstv[1] = (unsigned char  *)szCodGestion;
                  sqlstm.sqhstl[1] = (unsigned long )4;
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



                  if( sqlca.sqlcode != SQLOK )
                  {
                     ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Actualizando CO_GESTION %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );
                     return FALSE;
                  }
               } /* if (iCountGest == 0) */

	        }
	    } /* End While */
	
	    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	    /* EXEC SQL
	    CLOSE curClientes; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 17;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )913;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}


	
		if( sqlca.sqlcode )
		{
			ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] FIN CURSOR Clientes.", LOG03, lhCodCliente );  
			iResp = 1; 
		}
	
	    if( iResp == 1 )
	        return "INGES";
	} /* if( !strcmp( szhEntGestCob, szENTIDADCUENTA ) ) */

    ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] Entidad => [%s] OK.", LOG03, lhCodCliente, szhCodEntidadAsig );
    return "OK";
}

/****************************************************************************************************/
/* bfnInsertaCobExterna()   													   					*/
/****************************************************************************************************/
BOOL bfnInsertaCobExterna(FILE **ptArchLog,  TDATOSCOB *stDatosCobros, char *szpEntGestCob, sql_context ctxCont )
/*
	Definicion		:	Inserta un registro en la tabla co_cobexterna
	
	Parametros		:	stDatosCobros		Estructura con los datos a insertar
*/	
{
/* EXEC SQL BEGIN DECLARE SECTION; */ 

	long	 lhCodCliente   = 0;
	long   lhCodCuenta    = 0;
	char   szhRutStgo     [2];
	char   szhCodEntidad  [6];
	char   szhNumIdent   [21];
	char   szhCodTipIdent [3];
	double dhMtoVencido = 0.0;
	double dhMtoDeuda   = 0.0;
	/* Vbls Bind */
	char   szhLetra_P [2];
	char   szhLetra_A [2];
	char   szhLetra_X [2];
	
	int   ihValor_cero= 0;
	int   ihValor_uno = 1;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 


char modulo[] = "bfnInsertaCobExterna", szEntGestCob[2];
FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 


 	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo : [%s].", LOG05, modulo );

	memset( szhNumIdent, '\0', sizeof( szhNumIdent ) );
	memset( szhCodTipIdent, '\0', sizeof( szhCodTipIdent ) );
	memset( szhCodEntidad, '\0', sizeof( szhCodEntidad ) );
	memset( szhRutStgo, '\0', sizeof( szhRutStgo ) );
	memset( szEntGestCob, '\0', sizeof( szEntGestCob ) );
	strcpy(szhLetra_P,"P");
	strcpy(szhLetra_A,"A");
	strcpy(szhLetra_X,"X");

	strcpy( szEntGestCob, szpEntGestCob );
	strcpy( szhNumIdent, stDatosCobros->szNumIdent );
	strcpy( szhCodTipIdent, stDatosCobros->szCodTipIdent );
	strcpy( szhCodEntidad, stDatosCobros->szCodEntidad );
	strcpy( szhRutStgo, stDatosCobros->szRutSantiago );
	lhCodCliente = stDatosCobros->lCodCliente;
	dhMtoVencido = stDatosCobros->dMtoVencido;
	dhMtoDeuda = stDatosCobros->dMtoDeuda;

	rtrim( szhNumIdent );
	rtrim( szhCodTipIdent );
	rtrim( szhCodEntidad );
	rtrim( szhRutStgo );

    /* Obtiene el cod_cuenta del cliente en la CO_MOROSOS */
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	/* EXEC SQL
	SELECT COD_CUENTA
	  INTO :lhCodCuenta
	  FROM CO_MOROSOS
	 WHERE COD_CLIENTE = :lhCodCliente; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CUENTA into :b0  from CO_MOROSOS where COD_CLIENT\
E=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )928;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCuenta;
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



    if( sqlca.sqlcode )
    {
        ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] SELECT CUENTA CO_MOROSOS => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return FALSE;
    }

	stDatosCobros->lCodCuenta = lhCodCuenta;

	ifnTrazaHilos( modulo,&pfLog, "Valores Insert CO_COBEXTERNA\n"  
						  "\t\t   szhNumIdent    => [%s],\n"
						  "\t\t   szhCodTipIdent => [%s],\n"
						  "\t\t   szhCodEntidad  => [%s],\n"
						  "\t\t   szhRutStgo     => [%s],\n"
						  "\t\t   lhCodCliente   => [%ld],\n"
						  "\t\t   dhMtoVencido   => [%.2f],\n"
						  "\t\t   dhMtoDeuda     => [%.2f],\n"
						  "\t\t   lhCodCuenta    => [%ld],\n",
						  LOG07,
						  szhNumIdent,
						  szhCodTipIdent,
						  szhCodEntidad,
						  szhRutStgo,
						  lhCodCliente,
						  dhMtoVencido,
						  dhMtoDeuda,
						  lhCodCuenta );

	if( !strcmp( szEntGestCob, "R" ) )
		lhCodCliente = 0;
	
	sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
	/* EXEC SQL 
	INSERT INTO CO_COBEXTERNA
			  (NUM_IDENT     ,  COD_TIPIDENT  ,	 COD_CLIENTE       ,	 COD_CUENTA,      
				COD_ENTIDAD   ,  TIP_COBRANZA  ,  FEC_INGRESO       ,	 NUM_PROCESO,
				COD_MOVIMIENTO,  FEC_MOVIMIENTO,	 MTO_DEUDA         ,	 MTO_VENCIDO,
				CNT_CLIENTES  ,  COD_ENVIO     ,	 NUM_IDENT_SANTIAGO,	 NOM_USUARIO,
				DIA_PRORROCOM )
	VALUES  (:szhNumIdent  ,  :szhCodTipIdent, :lhCodCliente     ,	 :lhCodCuenta,
		      :szhCodEntidad,  :szhLetra_P    , SYSDATE           ,  :ihValor_cero ,
		      :szhLetra_A   ,  SYSDATE        , :dhMtoDeuda       ,  :dhMtoVencido,
		      :ihValor_uno  ,  :szhLetra_X    , :szhRutStgo       ,  USER,
		      :ihValor_cero ); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 17;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "insert into CO_COBEXTERNA (NUM_IDENT,COD_TIPIDENT,COD_CLIENT\
E,COD_CUENTA,COD_ENTIDAD,TIP_COBRANZA,FEC_INGRESO,NUM_PROCESO,COD_MOVIMIENTO,F\
EC_MOVIMIENTO,MTO_DEUDA,MTO_VENCIDO,CNT_CLIENTES,COD_ENVIO,NUM_IDENT_SANTIAGO,\
NOM_USUARIO,DIA_PRORROCOM) values (:b0,:b1,:b2,:b3,:b4,:b5,SYSDATE,:b6,:b7,SYS\
DATE,:b8,:b9,:b10,:b11,:b12,USER,:b6)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )951;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhNumIdent;
 sqlstm.sqhstl[0] = (unsigned long )21;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodTipIdent;
 sqlstm.sqhstl[1] = (unsigned long )3;
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
 sqlstm.sqhstv[3] = (unsigned char  *)&lhCodCuenta;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodEntidad;
 sqlstm.sqhstl[4] = (unsigned long )6;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhLetra_P;
 sqlstm.sqhstl[5] = (unsigned long )2;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)0;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhLetra_A;
 sqlstm.sqhstl[7] = (unsigned long )2;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)&dhMtoDeuda;
 sqlstm.sqhstl[8] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&dhMtoVencido;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&ihValor_uno;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
 sqlstm.sqhstv[11] = (unsigned char  *)szhLetra_X;
 sqlstm.sqhstl[11] = (unsigned long )2;
 sqlstm.sqhsts[11] = (         int  )0;
 sqlstm.sqindv[11] = (         short *)0;
 sqlstm.sqinds[11] = (         int  )0;
 sqlstm.sqharm[11] = (unsigned long )0;
 sqlstm.sqadto[11] = (unsigned short )0;
 sqlstm.sqtdso[11] = (unsigned short )0;
 sqlstm.sqhstv[12] = (unsigned char  *)szhRutStgo;
 sqlstm.sqhstl[12] = (unsigned long )2;
 sqlstm.sqhsts[12] = (         int  )0;
 sqlstm.sqindv[12] = (         short *)0;
 sqlstm.sqinds[12] = (         int  )0;
 sqlstm.sqharm[12] = (unsigned long )0;
 sqlstm.sqadto[12] = (unsigned short )0;
 sqlstm.sqtdso[12] = (unsigned short )0;
 sqlstm.sqhstv[13] = (unsigned char  *)&ihValor_cero;
 sqlstm.sqhstl[13] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[13] = (         int  )0;
 sqlstm.sqindv[13] = (         short *)0;
 sqlstm.sqinds[13] = (         int  )0;
 sqlstm.sqharm[13] = (unsigned long )0;
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
 sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if( sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND )
	{   
		ifnTrazaHilos( modulo,&pfLog, "Cliente => [%ld] INSERT CO_COBEXTERNA => [%s].", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
		return FALSE;
	}  

	return TRUE;
} /* bfnInsertaCobExterna */


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

