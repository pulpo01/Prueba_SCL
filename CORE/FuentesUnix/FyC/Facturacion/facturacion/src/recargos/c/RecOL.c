
/* Result Sets Interface */
#ifndef SQL_CRSR
#  define SQL_CRSR
  struct sql_cursor
  {
    unsigned int curocn;
    void *ptr1;
    void *ptr2;
    unsigned long magic;
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
           char  filnam[14];
};
static struct sqlcxp sqlfpn =
{
    13,
    "./pc/RecOL.pc"
};


static unsigned long sqlctx = 432267;


static struct sqlexd {
   unsigned int   sqlvsn;
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
            void  **sqphsv;
   unsigned int   *sqphsl;
            int   *sqphss;
            void  **sqpind;
            int   *sqpins;
   unsigned int   *sqparm;
   unsigned int   **sqparc;
   unsigned short  *sqpadto;
   unsigned short  *sqptdso;
            void  *sqhstv[2];
   unsigned int   sqhstl[2];
            int   sqhsts[2];
            void  *sqindv[2];
            int   sqinds[2];
   unsigned int   sqharm[2];
   unsigned int   *sqharc[2];
   unsigned short  sqadto[2];
   unsigned short  sqtdso[2];
} sqlstm = {10,2};

/* SQLLIB Prototypes */
extern sqlcxt (/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlcx2t(/*_ void **, unsigned long *,
                   struct sqlexd *, struct sqlcxp * _*/);
extern sqlbuft(/*_ void **, char * _*/);
extern sqlgs2t(/*_ void **, char * _*/);
extern sqlorat(/*_ void **, unsigned long *, void * _*/);

/* Forms Interface */
static int IAPSUCC = 0;
static int IAPFAIL = 1403;
static int IAPFTL  = 535;
extern void sqliem(/*_ char *, int * _*/);

typedef struct { unsigned short len; unsigned char arr[1]; } VARCHAR;
typedef struct { unsigned short len; unsigned char arr[1]; } varchar;

/* CUD (Compilation Unit Data) Array */
static short sqlcud0[] =
{10,4130,0,0,0,
5,0,0,1,0,0,31,66,0,0,0,0,0,1,0,
20,0,0,2,0,0,29,75,0,0,0,0,0,1,0,
35,0,0,3,88,0,4,169,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
};


/****************************************************************************/
/*                                                                          */
/*    Programa    : Conceptos.                                              */
/*    Modulo      : COBROS.                                                 */
/*    Fichero     : RecOL.pc                                                */
/*    Descripcion : Programa para generar los concepto generados.           */
/*    Programador : Julia Serrano Pozo.                                     */
/*    Fecha       : 05-12-1996                                              */
/*                                                                          */
/****************************************************************************/

#include <stdio.h>
#include <stdarg.h>
#include <string.h>
#include <stdlib.h>

#include <GenORA.h>
#include <coerr.h>
#include "recargos.h"

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

/*****************************************************************************/
/* Estos defines son solo para pruebas. Este programa no debe usarse.*/
/*********************************************************************/
#define USERID         "COBROS"
#define PASSWORD       "COBROS"

/*****************************************************************************/
int ifnInitProceCon(int argc,char *argv[]);
/**
Descripcion: Funcion que comprueba si se le pasan bien los parametros al
             programa y se conecta bien con ORACLE.
Entrada:     argc, contador de parametros de la linea de comandos.
             argv, array de parametros de la linea de comandos.
Salida:      TRUE, si todo ha ido bien.
             ERR_xxx, si falla algo.
**/

/*****************************************************************************/
int main(int argc, char *argv[])
{
	int	iResul;
	int	iRes;
	char	szFec[9];
	long	lCodCliente;
	int	iCodCredito;


	/* Inicializacion del proceso. */
	fprintf(stdout,"inicializacion del proceso\n");
	iResul = ifnInitProceCon(argc,argv);
	if (iResul)
		return iResul;

	lCodCliente = atol(argv[1]);
	strcpy(szFec,argv[2]);
	iCodCredito = atoi(argv[3]);

	fprintf(stdout,"recargos\n"); 

	iResul = ifnDBCompCliente(lCodCliente,szFec,iCodCredito);
	if (iResul)
	{
		fprintf(stderr,"* Error al generar recargos\n");

		/* EXEC SQL ROLLBACK; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 10;
  sqlstm.arrsiz = 0;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )5;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


		if (sqlca.sqlcode != SQLOK)
		{
			fprintf(stderr,"* Error al hacer ROLLBACK FINAL %s\n",szfnORAerror());
			return ERR_ROLLBACK;
		}
	}
	else
	{
		/* EXEC SQL COMMIT; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 10;
  sqlstm.arrsiz = 0;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )20;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



		if (sqlca.sqlcode != SQLOK)
		{
			fprintf(stderr,"* Error al hacer COMMIT FINAL %s\n",szfnORAerror());
			return ERR_COMMIT;
		}
	}
	fprintf(stderr,"iResul: %d\n",iResul);

	/* GAC 17-05-2002 */
	/*iRes = ifnDisConnORA();
	if (iRes == -1)
	{
		fprintf(stderr,"* Error :Fallo en desconexion ORACLE\n");
		return ERR_DESCONEXION;
	}*/

	if( ifnDisConnORA()!=0 )  {
        fprintf(stdout,"iRet [%d]. Fallo Desconexion Oracle.\n",ERR_DESCONEXION);
        return ERR_DESCONEXION ;
	} else	{
		fprintf(stdout, "\n\t-------------------------------------------------------"
						"\n\tDesconectado de  ORACLE"
						"\n\t-------------------------------------------------------");
	}

	return iResul;

} /* Fin main() */
/****************************************************************************/

int ifnInitProceCon(int argc, char *argv[])
/**
Descripcion: Funcion que comprueba si se le pasan bien los parametros al
             programa y se conecta bien con ORACLE.
Entrada:     argc, contador de parametros de la linea de comandos.
             argv, array de parametros de la linea de comandos.
Salida:      TRUE, si todo va bien.
             ERR_xxx, si falla algo.
**/
{
	int iResul;

	/* Comprobacion de la linea de comandos. */
	if (argc != 6)
	{
		fprintf(stderr,"\n\tProcesar %s con Parametros :\n\t\tCodCliente  Fecha  CodCredito  Usuario  PassWord\n",
							argv[0]);
		return ERR_PARAMETROS;
	}

	/* Conexion a ORACLE */
	/*fprintf(stdout,"antes de conectarme\n");
	iResul = ifnConnectORA(argv[4],argv[5]);
	if (iResul == -1)
	{
		fprintf(stderr,"* Error :Fallo en conexion ORACLE: %s\n",szfnORAerror());
		return ERR_CONEXION;
	}*/

	if( !ifnConnectORA(argv[4],argv[5]) )	{
		fprintf(stderr, "\n\tUsuario/Passwd Invalido\n\t\t  <usuario> <passwd> \n ");
		return ERR_CONEXION;

	} else {
		printf(	"\n\t----------------------------------------------------  "
				"\n\tConectado a ORACLE: Usuario %s Passwd xxxxxxxx        "
				"\n\t----------------------------------------------------\n",argv[14]);
	}

	return OK;

}/* Fin bfnInitProceCon() */
/****************************************************************************/
int ifnDBCompCliente(long lCodCliente, char *szFecValor,int iCodCredito)
/**
Descripcion: Comprueba primero si el cliente tiene pago mediante PAC.
				 En caso negativo llama a la funcion que genera recargos.
Salida     : Si todo va bien devuelve OK y en caso contrario ERR_XXXX.
**/
{

   /* EXEC SQL BEGIN DECLARE SECTION; */ 
 

      long   lhCodCliente;

   /* EXEC SQL END DECLARE SECTION; */ 


	int        iResul = OK;
	double		dImporte = 0.0;

	lhCodCliente = lCodCliente;

   /* EXEC SQL
     SELECT COD_CLIENTE
       INTO :lhCodCliente
      FROM GE_CLIENTES
      WHERE COD_CLIENTE = :lhCodCliente
		AND	IND_DEBITO = 'A'; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 10;
   sqlstm.arrsiz = 2;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "select COD_CLIENTE into :b0  from GE_CLIENTES where (COD_C\
LIENTE=:b0 and IND_DEBITO='A')";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )35;
   sqlstm.selerr = (unsigned short)1;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (         void  *)&lhCodCliente;
   sqlstm.sqhstl[0] = (unsigned int  )sizeof(long);
   sqlstm.sqhsts[0] = (         int  )0;
   sqlstm.sqindv[0] = (         void  *)0;
   sqlstm.sqinds[0] = (         int  )0;
   sqlstm.sqharm[0] = (unsigned int  )0;
   sqlstm.sqadto[0] = (unsigned short )0;
   sqlstm.sqtdso[0] = (unsigned short )0;
   sqlstm.sqhstv[1] = (         void  *)&lhCodCliente;
   sqlstm.sqhstl[1] = (unsigned int  )sizeof(long);
   sqlstm.sqhsts[1] = (         int  )0;
   sqlstm.sqindv[1] = (         void  *)0;
   sqlstm.sqinds[1] = (         int  )0;
   sqlstm.sqharm[1] = (unsigned int  )0;
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



   if (sqlca.sqlcode < 0)
   {
      /* fprintf(stderr,"Error en Select de Cliente %s\n",szfnORAerror()); */
      return ERR_DEBCLI;
   }

   if (sqlca.sqlcode == NOT_FOUND)
	{
/*		iResul = ifnDBCompRecargos(lCodCliente,szFecValor,iCodCredito,"CO",
												&dImporte);*/
	}

	/* fprintf(stdout,"IMPORTE %f\n",dImporte); */
	return iResul;

}/* Fin ifnDBCompCliente() */


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

