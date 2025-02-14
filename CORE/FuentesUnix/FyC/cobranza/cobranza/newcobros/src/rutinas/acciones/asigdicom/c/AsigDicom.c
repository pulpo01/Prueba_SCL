
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
           char  filnam[18];
};
static const struct sqlcxp sqlfpn =
{
    17,
    "./pc/AsigDicom.pc"
};


static unsigned int sqlctx = 6898323;


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
   unsigned char  *sqhstv[6];
   unsigned long  sqhstl[6];
            int   sqhsts[6];
            short *sqindv[6];
            int   sqinds[6];
   unsigned long  sqharm[6];
   unsigned long  *sqharc[6];
   unsigned short  sqadto[6];
   unsigned short  sqtdso[6];
} sqlstm = {12,6};

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
5,0,0,1,204,0,4,104,0,0,6,2,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,1,5,
0,0,
44,0,0,2,177,0,5,158,0,0,6,6,0,1,0,1,3,0,0,1,5,0,0,1,5,0,0,1,4,0,0,1,5,0,0,1,5,
0,0,
83,0,0,3,104,0,4,181,0,0,3,2,0,1,0,2,3,0,0,1,5,0,0,1,5,0,0,
110,0,0,4,65,0,4,196,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
133,0,0,5,227,0,3,214,0,0,4,4,0,1,0,1,5,0,0,1,5,0,0,1,3,0,0,1,4,0,0,
};


/* ============================================================================= */
/*
    Tipo        :  ACCION
    Nombre      :  AsigDicom.pc ("ASDIC"->szfnAsigDicom)
    Descripcion :  ASIGna la categoria de Dicom, al cliente en proceso
    Recibe      :  by Val -> Cod Cliente 
    Devuelve    :  "SQL"  -> Ocurrio un error de oracle ( queda registrado en el log )
                   "NORUT"-> Fue imposible determinar el rut del cliente dado
                   "PND"  -> La accion queda pendiente                         / MGG_27032001 /
				       "NODIR"-> Fue imposible determinar la direccion del cliente / MGG_27032001 /
				       "OK"   -> La accion se ejecuto correctamente
    Autor       :  Manuel Garcia G.
    Fecha       :  17 - Mayo - 2001
Modificacion    :  12-11-2004
						 Por proyecto P_MAS-04037 se agregan 2 parametros a la accion
                   Puntero de archivo log tipo Hilo. 
                   Variable de contexto para instancia de BD tipo hilo
*/ 
/* ============================================================================= */

#define _COLIBGENERALES_PC_ /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#define _COLIBACCIONES_PC_  /* Agregado por PGonzalez 20-10-2004 MAS-04037 */
#include "AsigDicom.h"

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
/* funcion de asignacion de entidad de cobranza externa                          */
/* ============================================================================= */
char  *szfnAsigDicom (FILE **ptArchLog, long lCliente, sql_context ctxCont )
{
char 	modulo[] = "szfnAsigDicom";
int 	iResp = 0, iMetropolitana = 13, iAsignado = 0;
int 	i = 0, iMorososComuna = 0 , iPorcentajeTotal = 0;
long 	lTotalRows = 0;
float 	fPorcentajeDefinido = 0.0;
float 	fPorcentajeActual   = 0.0;
char		szhCodEntidadAsig[] = "DICOM";
char		szRutina[] = "A"; 
char		szMovimiento[] = "A";
/* EXEC SQL BEGIN DECLARE SECTION; */ 

   long lhCodCliente          = 0  ;
   char szhCodRegion[4]       = "" ; /* EXEC SQL VAR szhCodRegion IS STRING (4); */ 

   char szhCodComuna[6]       = "" ; /* EXEC SQL VAR szhCodComuna IS STRING (6); */ 

   int ihDirCorrespondencia  = 3  ;
   char szhNumIdent[iLENNUMIDENT]       = "" ; /* EXEC SQL VAR szhNumIdent IS STRING (iLENNUMIDENT); */ 

   char szhCodTipIdent[3]     = "" ; /* EXEC SQL VAR szhCodTipIdent IS STRING (3); */ 

   long lhCodCuentaNew        = 0  ;
   char szhCodMovimiento[6]   = "" ; /* EXEC SQL VAR szhCodMovimiento IS STRING (6); */ 

   char szhFecMovimiento[15]  = "" ; /* EXEC SQL VAR szhFecMovimiento IS STRING (15); */ 

   char szhAuxHoy[15]         = "" ; /* EXEC SQL VAR szhAuxHoy IS STRING (15); */ 

   char szhCodEnvio[6]        = "" ; /* EXEC SQL VAR szhCodEnvio IS STRING (6); */ 

   int  ihIncrementoClientes  = 0  ;
   char szhRutStgo[2]         = "" ; /* EXEC SQL VAR szhRutStgo IS STRING (2); */ 

   double dhDeudaRut = 0.0;
	int  cntcategorias         = 0;
	sql_context CXX;
/* EXEC SQL END DECLARE SECTION; */ 


FILE *pfLog=*ptArchLog;
struct sqlca sqlca;

	CXX = ctxCont;
	/* EXEC SQL CONTEXT USE :CXX; */ 

       
	ifnTrazaHilos( modulo,&pfLog, "Ingreso modulo => [%s].", LOG03, modulo );
	ifnTrazaHilos( modulo,&pfLog, "VERSION : [%s].", LOG03, szVersion);

   lhCodCliente = lCliente;
    
    /*-(0) Obtiene el Rut del Cliente -*/            
    iResp = ifnGetRutCliente(&pfLog, lCliente, szhNumIdent, szhCodTipIdent, CXX); /* el envia mensaje en caso de error */
    if (iResp == 0) /*No encontro el rut */
    {
        return "NORUT";
    }
    else if (iResp < 0 ) /* error oracle */
    {
        return "PND";
    }
    
    iResp = 0;

    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)(NumIdent:%s)(TipIdent:%s)",LOG05,lhCodCliente,szhNumIdent,szhCodTipIdent);  

    
    /*- (0.5) Verificar la deuda del rut del cliente */
    if ( !bfnGetSaldoPorRutAcc(&pfLog, szhNumIdent,szhCodTipIdent,&dhDeudaRut, CXX ) ) return "PND";
  
	/* transformamos decimales segun definicion para la operadora tratada */
	ifnTrazaHilos( modulo,&pfLog, "Valores antes de transformer dhDeudaRut = [%.4f].", LOG05, dhDeudaRut );  
	dhDeudaRut = fnCnvDouble( dhDeudaRut, 0 );
	ifnTrazaHilos( modulo,&pfLog, "Valores despues de transformer dhDeudaRut = [%.4f].", LOG05, dhDeudaRut );  

	/* debemos actualizar la co_gestion, con un alta transitoria para DICOM */
	if( !bfnActualizaCoGestionClienteAcc(&pfLog, lhCodCliente, lhCodCuentaNew, szhNumIdent, szhCodTipIdent, 
									   szhCodEntidadAsig, szRutina, szMovimiento, CXX ) )
	{
		return "PND";
	}
		
    /*--(1) Verificar si el rut de este cliente ya tiene alguna dicom asignado --*/    
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    SELECT 	A.COD_MOVIMIENTO, 
    		A.COD_ENVIO, 
    		TO_CHAR(A.FEC_MOVIMIENTO,'YYYYMMDDHH24MISS'), 
    		TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
    INTO 	:szhCodMovimiento, 
    		:szhCodEnvio, 
    		:szhFecMovimiento, 
    		:szhAuxHoy
    FROM 	CO_DICOM A
    WHERE 	A.NUM_IDENT 	= :szhNumIdent
    AND   	A.COD_TIPIDENT 	= :szhCodTipIdent; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select A.COD_MOVIMIENTO ,A.COD_ENVIO ,TO_CHAR(A.FEC_MOVIM\
IENTO,'YYYYMMDDHH24MISS') ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') into :b0,:b1,:b\
2,:b3  from CO_DICOM A where (A.NUM_IDENT=:b4 and A.COD_TIPIDENT=:b5)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )5;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodMovimiento;
    sqlstm.sqhstl[0] = (unsigned long )6;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodEnvio;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhFecMovimiento;
    sqlstm.sqhstl[2] = (unsigned long )15;
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
    sqlstm.sqhstv[4] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[4] = (unsigned long )21;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipIdent;
    sqlstm.sqhstl[5] = (unsigned long )3;
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



    if (sqlca.sqlcode != SQLOK && sqlca.sqlcode != SQLNOTFOUND)
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) CO_DICOM => %s ",LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND"; /* error oracle*/
    }
    else if ( sqlca.sqlcode != SQLNOTFOUND ) /* LO ENCONTRO. EL RUT YA EXISTE */
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)-->Ya esta en CO_DICOM -OK- ", LOG03, lhCodCliente );  
        
        /*ihIncrementoClientes = 1; * XC-51 20040706 capc*/
        ihIncrementoClientes = 0;
        
        if ( strcmp( szhCodMovimiento, "SM" ) == 0 )		/* si no tiene movimiento */
        {
            if ( strcmp( szhCodEnvio, "B" ) == 0 )  		/* si el envio es de baja */
            { 
                strcpy( szhCodMovimiento, "A" );        	/* cambiar cod_movimiento a 'A' */
                /* ihIncrementoClientes = 0;               	*  XC-51 20040706 capc  ** no incrementa la cantidad de clientes, asume que tiene uno */
				ihIncrementoClientes = 1;
            }
			else
			{
                strcpy( szhCodMovimiento, "M" );   			/* cambiar cod_movimiento a 'M' */
			}
            strcpy( szhFecMovimiento, szhAuxHoy );      	/* cambiar fecha del movimiento */
        }
        else 
        {
            if( strcmp( szhCodMovimiento, "A" ) != 0 )		/* si tiene movimiento distinto de 'A' : Alta */
            {    
                if( strcmp( szhCodMovimiento, "B" ) == 0 )
                	/*ihIncrementoClientes = 0; * XC-51 20040706 capc */
					ihIncrementoClientes = 1;                

                strcpy( szhCodMovimiento, "M" );            /* cambiar cod_movimiento a 'M'  */
            }

            strcpy( szhFecMovimiento, szhAuxHoy );			/* cambiar fecha del movimiento */
        }
        
        sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
        /* EXEC SQL
        UPDATE 	CO_DICOM
        SET    	CNT_CLIENTES 	= CNT_CLIENTES + :ihIncrementoClientes
              , COD_MOVIMIENTO 	= :szhCodMovimiento 
              , FEC_MOVIMIENTO 	= TO_DATE(:szhFecMovimiento,'YYYYMMDDHH24MISS')
              , MTO_VENCIDO 	= :dhDeudaRut
        WHERE 	NUM_IDENT 		= :szhNumIdent
        AND   	COD_TIPIDENT 	= :szhCodTipIdent ; */ 

{
        struct sqlexd sqlstm;
        sqlstm.sqlvsn = 12;
        sqlstm.arrsiz = 6;
        sqlstm.sqladtp = &sqladt;
        sqlstm.sqltdsp = &sqltds;
        sqlstm.stmt = "update CO_DICOM  set CNT_CLIENTES=(CNT_CLIENTES+:b0),\
COD_MOVIMIENTO=:b1,FEC_MOVIMIENTO=TO_DATE(:b2,'YYYYMMDDHH24MISS'),MTO_VENCIDO=\
:b3 where (NUM_IDENT=:b4 and COD_TIPIDENT=:b5)";
        sqlstm.iters = (unsigned int  )1;
        sqlstm.offset = (unsigned int  )44;
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
        sqlstm.sqhstv[1] = (unsigned char  *)szhCodMovimiento;
        sqlstm.sqhstl[1] = (unsigned long )6;
        sqlstm.sqhsts[1] = (         int  )0;
        sqlstm.sqindv[1] = (         short *)0;
        sqlstm.sqinds[1] = (         int  )0;
        sqlstm.sqharm[1] = (unsigned long )0;
        sqlstm.sqadto[1] = (unsigned short )0;
        sqlstm.sqtdso[1] = (unsigned short )0;
        sqlstm.sqhstv[2] = (unsigned char  *)szhFecMovimiento;
        sqlstm.sqhstl[2] = (unsigned long )15;
        sqlstm.sqhsts[2] = (         int  )0;
        sqlstm.sqindv[2] = (         short *)0;
        sqlstm.sqinds[2] = (         int  )0;
        sqlstm.sqharm[2] = (unsigned long )0;
        sqlstm.sqadto[2] = (unsigned short )0;
        sqlstm.sqtdso[2] = (unsigned short )0;
        sqlstm.sqhstv[3] = (unsigned char  *)&dhDeudaRut;
        sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
        sqlstm.sqhsts[3] = (         int  )0;
        sqlstm.sqindv[3] = (         short *)0;
        sqlstm.sqinds[3] = (         int  )0;
        sqlstm.sqharm[3] = (unsigned long )0;
        sqlstm.sqadto[3] = (unsigned short )0;
        sqlstm.sqtdso[3] = (unsigned short )0;
        sqlstm.sqhstv[4] = (unsigned char  *)szhNumIdent;
        sqlstm.sqhstl[4] = (unsigned long )21;
        sqlstm.sqhsts[4] = (         int  )0;
        sqlstm.sqindv[4] = (         short *)0;
        sqlstm.sqinds[4] = (         int  )0;
        sqlstm.sqharm[4] = (unsigned long )0;
        sqlstm.sqadto[4] = (unsigned short )0;
        sqlstm.sqtdso[4] = (unsigned short )0;
        sqlstm.sqhstv[5] = (unsigned char  *)szhCodTipIdent;
        sqlstm.sqhstl[5] = (unsigned long )3;
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


        
        if (sqlca.sqlcode)
        {
            ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) UPDATE CO_DICOM => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
            return "PND"; /* error oracle*/
        }
            
        return "OK"; /* No hace nada mas, porque ya esta en DICOM */

    }
    /* SQLNOTFOUND : No esta en DICOM, continua el proceso*/

    /*--(0) Obtiene el cod_cuenta del cliente en la CO_MOROSOS --*/    
	/*INICIO***** XC-51 **************/  
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
	SELECT  COUNT(UNIQUE COD_CATEGORIA)
	INTO  :cntcategorias
	FROM  GE_CLIENTES
	WHERE NUM_IDENT    = :szhNumIdent
	AND   COD_TIPIDENT = :szhCodTipIdent; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select count(unique COD_CATEGORIA) into :b0  from GE_CLIE\
NTES where (NUM_IDENT=:b1 and COD_TIPIDENT=:b2)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )83;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&cntcategorias;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhNumIdent;
    sqlstm.sqhstl[1] = (unsigned long )21;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodTipIdent;
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
    sqlcxt(&CXX, &sqlctx, &sqlstm, &sqlfpn);
}



	if (cntcategorias > 1 ) 
	{
		return "RDCAT";
	}
	
	/*FIN***** XC-51 **************/    

    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL
    SELECT 	COD_CUENTA
    INTO 	:lhCodCuentaNew
    FROM 	CO_MOROSOS
    WHERE 	COD_CLIENTE = :lhCodCliente; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_CUENTA into :b0  from CO_MOROSOS where COD_CLI\
ENTE=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )110;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)&lhCodCuentaNew;
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



    if( sqlca.sqlcode == SQLOK && sqlca.sqlcode == SQLNOTFOUND )
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Select Cod_cuenta from CO_MOROSOS => %s " ,LOG00,lhCodCliente,sqlca.sqlerrm.sqlerrmc);  
        return "PND"; /* error oracle*/
    }                                              
    else if( sqlca.sqlcode == SQLNOTFOUND )
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) No se encuentra Cod_cuenta en la CO_MOROSOS => %s.", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND"; /* error oracle*/
    }
	
    sqlca.sqlcode=0; /* se resetea la vble sql en caso de memoria saturada*/
    /* EXEC SQL 
    INSERT INTO CO_DICOM
    ( 
        NUM_IDENT,		COD_TIPIDENT,		COD_CUENTA,			FEC_INGRESO,       
        NUM_PROCESO,	COD_MOVIMIENTO, 	FEC_MOVIMIENTO,     MTO_DEUDA,         
        MTO_VENCIDO,	CNT_CLIENTES,  		COD_ENVIO,          NOM_USUARIO
    )
    VALUES
    (   
        :szhNumIdent,	:szhCodTipIdent,	:lhCodCuentaNew,   	SYSDATE,            
        0,             	'A',       			SYSDATE,			0,
        :dhDeudaRut, 	1,    				'X',                USER
    ); */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 6;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "insert into CO_DICOM (NUM_IDENT,COD_TIPIDENT,COD_CUENTA,F\
EC_INGRESO,NUM_PROCESO,COD_MOVIMIENTO,FEC_MOVIMIENTO,MTO_DEUDA,MTO_VENCIDO,CNT\
_CLIENTES,COD_ENVIO,NOM_USUARIO) values (:b0,:b1,:b2,SYSDATE,0,'A',SYSDATE,0,:\
b3,1,'X',USER)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )133;
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
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCuentaNew;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&dhDeudaRut;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
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



    if ( sqlca.sqlcode )
    {
        ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld) Al insertar en CO_DICOM => %s ", LOG00, lhCodCliente, sqlca.sqlerrm.sqlerrmc );  
        return "PND"; /* error oracle*/
    }

    ifnTrazaHilos( modulo,&pfLog, "(Cliente:%ld)-->Insertado CO_DICOM -OK- ", LOG03, lhCodCliente );  

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

