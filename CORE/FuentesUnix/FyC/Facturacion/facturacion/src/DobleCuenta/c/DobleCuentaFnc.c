
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
    "./pc/DobleCuentaFnc.pc"
};


static unsigned int sqlctx = 220749715;


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
   unsigned char  *sqhstv[13];
   unsigned long  sqhstl[13];
            int   sqhsts[13];
            short *sqindv[13];
            int   sqinds[13];
   unsigned long  sqharm[13];
   unsigned long  *sqharc[13];
   unsigned short  sqadto[13];
   unsigned short  sqtdso[13];
} sqlstm = {12,13};

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
{12,4130,2,0,0,
5,0,0,1,88,0,4,89,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
28,0,0,2,99,0,5,106,0,0,2,2,0,1,0,1,3,0,0,1,3,0,0,
51,0,0,3,199,0,4,138,0,0,5,4,0,1,0,2,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,97,0,0,
86,0,0,4,90,0,4,171,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
109,0,0,5,0,0,17,255,0,0,1,1,0,1,0,1,97,0,0,
128,0,0,5,0,0,45,276,0,0,0,0,0,1,0,
143,0,0,5,0,0,13,330,0,0,13,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,
4,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,3,0,0,2,97,0,0,
210,0,0,5,0,0,15,397,0,0,0,0,0,1,0,
225,0,0,5,0,0,17,517,0,0,1,1,0,1,0,1,97,0,0,
244,0,0,5,0,0,45,533,0,0,0,0,0,1,0,
259,0,0,5,0,0,13,564,0,0,6,0,0,1,0,2,3,0,0,2,3,0,0,2,3,0,0,2,4,0,0,2,3,0,0,2,3,
0,0,
298,0,0,5,0,0,15,598,0,0,0,0,0,1,0,
313,0,0,5,0,0,17,673,0,0,1,1,0,1,0,1,97,0,0,
332,0,0,5,0,0,45,689,0,0,0,0,0,1,0,
347,0,0,5,0,0,13,704,0,0,3,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,
374,0,0,5,0,0,15,719,0,0,0,0,0,1,0,
389,0,0,5,0,0,17,781,0,0,1,1,0,1,0,1,97,0,0,
408,0,0,5,0,0,45,797,0,0,0,0,0,1,0,
423,0,0,5,0,0,13,812,0,0,3,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,
450,0,0,5,0,0,15,829,0,0,0,0,0,1,0,
465,0,0,5,0,0,17,1351,0,0,1,1,0,1,0,1,97,0,0,
484,0,0,5,0,0,45,1372,0,0,0,0,0,1,0,
499,0,0,5,0,0,13,1389,0,0,8,0,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,
3,0,0,2,3,0,0,2,3,0,0,
546,0,0,5,0,0,15,1401,0,0,0,0,0,1,0,
561,0,0,5,0,0,17,1488,0,0,1,1,0,1,0,1,97,0,0,
580,0,0,5,0,0,45,1504,0,0,0,0,0,1,0,
595,0,0,5,0,0,13,1519,0,0,3,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,
622,0,0,5,0,0,15,1533,0,0,0,0,0,1,0,
637,0,0,6,0,0,17,1791,0,0,1,1,0,1,0,1,97,0,0,
656,0,0,6,0,0,45,1806,0,0,0,0,0,1,0,
671,0,0,6,0,0,13,1813,0,0,1,0,0,1,0,2,4,0,0,
690,0,0,6,0,0,15,1817,0,0,0,0,0,1,0,
705,0,0,7,0,0,17,1911,0,0,1,1,0,1,0,1,97,0,0,
724,0,0,7,0,0,45,1926,0,0,0,0,0,1,0,
739,0,0,7,0,0,13,1933,0,0,4,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
770,0,0,7,0,0,15,1939,0,0,0,0,0,1,0,
785,0,0,8,0,0,17,1991,0,0,1,1,0,1,0,1,97,0,0,
804,0,0,8,0,0,45,2006,0,0,0,0,0,1,0,
819,0,0,8,0,0,13,2013,0,0,1,0,0,1,0,2,3,0,0,
838,0,0,8,0,0,15,2016,0,0,0,0,0,1,0,
853,0,0,9,0,0,17,2097,0,0,1,1,0,1,0,1,97,0,0,
872,0,0,9,0,0,45,2112,0,0,0,0,0,1,0,
887,0,0,9,0,0,13,2120,0,0,1,0,0,1,0,2,3,0,0,
906,0,0,9,0,0,15,2160,0,0,0,0,0,1,0,
921,0,0,10,0,0,17,2234,0,0,1,1,0,1,0,1,97,0,0,
940,0,0,10,0,0,45,2250,0,0,0,0,0,1,0,
955,0,0,10,0,0,13,2258,0,0,4,0,0,1,0,2,4,0,0,2,4,0,0,2,4,0,0,2,4,0,0,
986,0,0,10,0,0,15,2271,0,0,0,0,0,1,0,
1001,0,0,11,0,0,17,2299,0,0,1,1,0,1,0,1,97,0,0,
1020,0,0,11,0,0,45,2314,0,0,0,0,0,1,0,
1035,0,0,11,0,0,13,2322,0,0,6,0,0,1,0,2,3,0,0,2,4,0,0,2,3,0,0,2,5,0,0,2,5,0,0,
2,5,0,0,
1074,0,0,11,0,0,15,2338,0,0,0,0,0,1,0,
1089,0,0,12,88,0,4,2395,0,0,6,5,0,1,0,1,3,0,0,1,97,0,0,1,97,0,0,1,97,0,0,1,3,0,
0,2,5,0,0,
1128,0,0,13,58,0,4,2585,0,0,1,0,0,1,0,2,3,0,0,
1147,0,0,14,126,0,4,3214,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1170,0,0,15,331,0,4,3249,0,0,3,2,0,1,0,2,97,0,0,1,97,0,0,1,97,0,0,
1197,0,0,16,70,0,4,3304,0,0,2,1,0,1,0,2,5,0,0,1,3,0,0,
1220,0,0,17,363,0,4,3336,0,0,6,1,0,1,0,2,3,0,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,
1,3,0,0,
1259,0,0,18,170,0,4,3405,0,0,5,1,0,1,0,2,3,0,0,2,5,0,0,2,3,0,0,2,5,0,0,1,3,0,0,
1294,0,0,19,0,0,17,3463,0,0,1,1,0,1,0,1,97,0,0,
1313,0,0,19,0,0,45,3481,0,0,0,0,0,1,0,
1328,0,0,19,0,0,13,3492,0,0,1,0,0,1,0,2,3,0,0,
1347,0,0,19,0,0,15,3494,0,0,0,0,0,1,0,
1362,0,0,20,128,0,4,3526,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1385,0,0,21,125,0,4,3573,0,0,3,2,0,1,0,2,5,0,0,1,3,0,0,1,3,0,0,
1412,0,0,22,124,0,4,3616,0,0,2,1,0,1,0,2,3,0,0,1,3,0,0,
1435,0,0,23,301,0,4,3669,0,0,5,1,0,1,0,2,5,0,0,2,5,0,0,2,5,0,0,2,5,0,0,1,5,0,0,
1470,0,0,24,433,0,4,3733,0,0,11,1,0,1,0,2,3,0,0,2,97,0,0,2,97,0,0,2,97,0,0,2,
97,0,0,2,97,0,0,2,3,0,0,2,97,0,0,2,97,0,0,2,3,0,0,1,3,0,0,
1529,0,0,25,0,0,17,4256,0,0,1,1,0,1,0,1,97,0,0,
1548,0,0,25,0,0,21,4264,0,0,0,0,0,1,0,
1563,0,0,25,0,0,17,4283,0,0,1,1,0,1,0,1,97,0,0,
1582,0,0,25,0,0,45,4298,0,0,0,0,0,1,0,
1597,0,0,25,0,0,15,4314,0,0,0,0,0,1,0,
};


/****************************************************************************/
/* Fichero    : DobleCuentaFnc.pc											*/
/* Descripcion: fichero de funciones auxiliares al ejecutable Doble Cuenta  */
/* Fecha      : 02-09-2007                                                  */
/* Autor      : Carlos A. Ortiz Hijar										*/
/****************************************************************************/
#define _DOBLECUENTA_C_

#include "DobleCuenta.h"



/****************************************************************************/
/*  bfnCargaDatosGenerales()  : Obtiene Datos Generales una sola vez		    */
/****************************************************************************/
BOOL bfnCargaDatosGenerales(long lCodCicloFact)
{
	char modulo[]   = "bfnCargaDatosGenerales";

	memset(szFecSysDate,0,sizeof(szFecSysDate));
	memset(&stDatosGener,0,sizeof(DATOSGENER));
	memset(&stFecProceso,0,sizeof(FECHASPROCESO));
	memset(&pstParamGener,0,sizeof(GENPARAM));
	memset(&stProceso,0,sizeof(PROCESO));

	vDTrazasLog(modulo, "\n\t INICIO Carga de Datos Generales \n", LOG03);

	if(!bGetSysDate (szFecSysDate))
	{
		vDTrazasError(modulo," en  retorno Funcion bGetSysDate\n",LOG01);
		vDTrazasLog  (modulo," en  retorno Funcion bGetSysDate\n",LOG01);
		return (FALSE);
	}

	vDTrazasLog(modulo, "\n\t Carga de Valores y Parametros Generales\n", LOG03);

	if(!bGetDatosGener (&stDatosGener, szFecSysDate))
	{
		vDTrazasError(modulo," en  retorno Funcion bGetDatosGener\n",LOG01);
		vDTrazasLog  (modulo," en  retorno Funcion bGetDatosGener\n",LOG01);
		return (FALSE);
	}

	/*** Se imprimen Datos Generales, solo LOG05 ***/
	vPrintDatosGener();

	if(!bfnGetFechasProceso(lCodCicloFact))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnGetFechasProceso\n",LOG01);
		vDTrazasLog(modulo  ," en  retorno Funcion bfnGetFechasProceso\n",LOG01);
		return (FALSE);
	}

	stProceso.lNumProceso = stFecProceso.lNumProceso;
	if(!bfnGetProceso (&stProceso))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnGetProceso\n",LOG01);
		vDTrazasLog(modulo  ," en  retorno Funcion bfnGetProceso\n",LOG01);
		return (FALSE);
	}

	/*** Imprime los valores obtenidos para stProceso ***/
	vfnPrintProcesos(&stProceso);

	return (TRUE);

}

BOOL bfnVerficaEstadoClie(long lNumProceso, long lCodCliente, long lNumAbonado)
{
	char modulo[] = "bfnVerficaEstadoClie";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

			long lhCodCliente;
			long lhNumAbonado;
			long lhCantidad;
			long lhNumProceso;
	/* EXEC SQL END DECLARE SECTION; */ 


	lhCantidad = 0;
	lhNumProceso = lNumProceso;
	lhCodCliente = lCodCliente;
	
	
	vDTrazasLog (modulo,"\n\t\t* bfnVerficaEstadoClie --> Cliente %ld\n" ,LOG03, lhCodCliente);
	vDTrazasLog (modulo,"\n\t\t* bfnVerficaEstadoClie --> Abonado %ld\n" ,LOG03, lNumAbonado);


	/* EXEC SQL SELECT COUNT(1)
		INTO :lhCantidad
		FROM FA_CICLOCLI
		WHERE COD_CLIENTE = :lhCodCliente
		AND NUM_PROCESO = -99; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 2;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select count(1) into :b0  from FA_CICLOCLI where (COD_CLIENT\
E=:b1 and NUM_PROCESO=(-99))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )5;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCantidad;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if((SQLCODE != SQLNOTFOUND) && (SQLCODE != SQLOK))
	{
			vDTrazasLog (modulo,"\n\t\t* Error en Obtencion de datos de FA_CICLOCLI \n" ,LOG03);
			return (FALSE);
	}

	if (lhCantidad != 0)
	{
			vDTrazasLog (modulo, "\n\t\t* UPDATE Registro en FA_CICLOCLI CLIENTE[%ld] ABONADO[%ld]\n"
			                   , LOG03,lhCodCliente, lhNumAbonado);
			
			/* EXEC SQL UPDATE FA_CICLOCLI SET NUM_PROCESO = :lhNumProceso, IND_MASCARA  = 1
				WHERE COD_CLIENTE = :lhCodCliente
				AND NUM_PROCESO = -99; */ 

{
   struct sqlexd sqlstm;
   sqlstm.sqlvsn = 12;
   sqlstm.arrsiz = 2;
   sqlstm.sqladtp = &sqladt;
   sqlstm.sqltdsp = &sqltds;
   sqlstm.stmt = "update FA_CICLOCLI  set NUM_PROCESO=:b0,IND_MASCARA=1 wher\
e (COD_CLIENTE=:b1 and NUM_PROCESO=(-99))";
   sqlstm.iters = (unsigned int  )1;
   sqlstm.offset = (unsigned int  )28;
   sqlstm.cud = sqlcud0;
   sqlstm.sqlest = (unsigned char  *)&sqlca;
   sqlstm.sqlety = (unsigned short)256;
   sqlstm.occurs = (unsigned int  )0;
   sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
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
   sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



			if((SQLCODE != SQLNOTFOUND) && (SQLCODE != SQLOK))
			{
				vDTrazasLog (modulo,"\n\t\t* Error en UPDATE de NUM_PROCESO en FA_CICLOCLI \n" ,LOG03);
				return (FALSE);
			}
	}

	return (TRUE);
}

BOOL bFindZonaImpo(char *szCodRegion, char *szCodProvincia, char *szCodCiudad, char *szFecZonaImpo, int  *piCodZonaImpo)
{
	char modulo[]   = "bFindZonaImpo";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char	szhCodRegion   [4];
        char	szhCodProvincia[6];
        char	szhCodCiudad   [6];
        char	szhFecDesde    [15];
        int		ihCodZonaImpo;
    /* EXEC SQL END DECLARE SECTION; */ 



	  strcpy (szhCodRegion   ,szCodRegion   );
	  strcpy (szhCodProvincia,szCodProvincia);
	  strcpy (szhCodCiudad   ,szCodCiudad   );
	  strcpy (szhFecDesde    ,szFecZonaImpo );

		/* EXEC SQL SELECT COD_ZONAIMPO
		INTO :ihCodZonaImpo
		FROM   GE_ZONACIUDAD
		WHERE COD_REGION = :szhCodRegion
		AND COD_PROVINCIA = :szCodProvincia
		AND COD_CIUDAD = :szCodCiudad
		AND TO_DATE(:szFecZonaImpo,'YYYYMMDDHH24MISS') BETWEEN FEC_DESDE AND FEC_HASTA
		AND ROWNUM < 2; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 5;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "select COD_ZONAIMPO into :b0  from GE_ZONACIUDAD where ((((\
COD_REGION=:b1 and COD_PROVINCIA=:b2) and COD_CIUDAD=:b3) and TO_DATE(:b4,'YYY\
YMMDDHH24MISS') between FEC_DESDE and FEC_HASTA) and ROWNUM<2)";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )51;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)&ihCodZonaImpo;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)szhCodRegion;
  sqlstm.sqhstl[1] = (unsigned long )4;
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)szCodProvincia;
  sqlstm.sqhstl[2] = (unsigned long )0;
  sqlstm.sqhsts[2] = (         int  )0;
  sqlstm.sqindv[2] = (         short *)0;
  sqlstm.sqinds[2] = (         int  )0;
  sqlstm.sqharm[2] = (unsigned long )0;
  sqlstm.sqadto[2] = (unsigned short )0;
  sqlstm.sqtdso[2] = (unsigned short )0;
  sqlstm.sqhstv[3] = (unsigned char  *)szCodCiudad;
  sqlstm.sqhstl[3] = (unsigned long )0;
  sqlstm.sqhsts[3] = (         int  )0;
  sqlstm.sqindv[3] = (         short *)0;
  sqlstm.sqinds[3] = (         int  )0;
  sqlstm.sqharm[3] = (unsigned long )0;
  sqlstm.sqadto[3] = (unsigned short )0;
  sqlstm.sqtdso[3] = (unsigned short )0;
  sqlstm.sqhstv[4] = (unsigned char  *)szFecZonaImpo;
  sqlstm.sqhstl[4] = (unsigned long )0;
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
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE)
        return (FALSE);

    *piCodZonaImpo = ihCodZonaImpo;

    return (TRUE);

}/************************** Final bFindZonaImpo **************************/

/****************************************************************************/
/*  bfnGetCicloFact()  : Obtiene Ciclo de Facturacion			    */
/****************************************************************************/
BOOL bfnGetCicloFact (PARAMETROSENTRADA *stParametrosIn)
{
    char modulo[]   = "bfnGetCicloFact";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhCodCiclFact  = stParametrosIn->lCodCicloFact;
		int	 ihCodCiclo;
    /* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog (modulo,"\n\t\t* Parametros Entrada a bfnGetCicloFact\n"
						"\t\t=> Cod.CiclFact [%ld]\n",LOG05, stParametrosIn->lCodCicloFact);

	/* EXEC SQL
		SELECT COD_CICLO
		INTO :ihCodCiclo
	    FROM  FA_CICLFACT
		WHERE COD_CICLFACT  = :lhCodCiclFact
			AND IND_FACTURACION < 2; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CICLO into :b0  from FA_CICLFACT where (COD_CICLF\
ACT=:b1 and IND_FACTURACION<2)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )86;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCiclFact;
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



	if (SQLCODE != SQLOK)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,"Select->Fa_CiclFact",
		szfnORAerror());
		return (FALSE);
	}

	stParametrosIn->iCodCiclo = ihCodCiclo;
	return (TRUE);
}/*************************** Fin bfnGetCicloFact ************************/

/****************************************************************************/
/*  ifnOpenClientesFactuDif()  : Abre Cursor de Clietes                       */
/****************************************************************************/
int ifnOpenClientesFactuDif(PARAMETROSENTRADA *stParamIn)
{
    char modulo[]   = "ifnOpenClientesFactuDif";

	static char szCadenaSQL[2048];

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        long lhCodCicloFact  = stParamIn->lCodCicloFact;
        int  ihCodCiclo     = stParamIn->iCodCiclo;
        long lhCodClienteIni  = stParamIn->lCodClienteIni;
        long lhCodClienteFin  = stParamIn->lCodClienteFin;
        long ihRngClientes  = stParamIn->iRngClientes;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t Parametros entrada a ifnOpenClientesFactuDif\n"
						 "\t\tCod_CiclFact [%ld]\n"
						 "\t\tCod Ciclo    [%d]\n",
						 LOG03,
						 stParamIn->lCodCicloFact,
						 stParamIn->iCodCiclo);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL," SELECT\n"
		"\t		 DET.NUM_SEC_DETALLE_FD,\n"
		"\t		 ENC.COD_CLIENTE_CONTRA,\n"
		"\t		 DET.COD_CLIENTE_ASOC,\n"
		"\t		 DET.NUM_ABONADO,\n"
		"\t		 DET.COD_CONCEPTO,\n"
		"\t		 DET.MNT_CONCEPTO_ASOC,\n"
		"\t		 CONC.COD_CONCEPTO_DESC,\n"
		"\t		 CONC.COD_CONCEPTO_DEST,\n"
		"\t		 FCLIE.IND_ORDENTOTAL,\n"
		"\t		 ENC.TIP_OPERACION,\n"
		"\t		 ENC.TIP_MODALIDAD,\n"
		"\t		 ENC.TIP_VALOR,\n"
		"\t		 CON.COD_MONEDA\n"
		"\t	FROM \n"
		"\t		 FA_DET_FACTURACION_DIF_TO DET,\n"
		"\t		 FA_ENC_FACTURACION_DIF_TO ENC,\n"
		"\t		 FA_FACTCLIE_%ld FCLIE,\n"
		"\t		 FA_CORIG_CDESC_CDEST_TD CONC,\n"
		"\t		 FA_CONCEPTOS CON\n"
		"\t	WHERE\n"
		"\t		 ENC.NUM_SEC_ENCABEZADO_FD = DET.NUM_SEC_ENCABEZADO_FD\n"
		"\t		 AND ENC.COD_CICLO = %d\n"
		"\t		 AND (ENC.FEC_INGRESO_REGISTRO <= SYSDATE AND ENC.FEC_CIERRE_REGISTRO >= SYSDATE)\n"
		"\t		 AND (DET.FEC_INGRESO_REGISTRO <= SYSDATE AND DET.FEC_CIERRE_REGISTRO >= SYSDATE)\n"
		"\t		 AND ((1 <> %d) OR (ENC.COD_CLIENTE_CONTRA >= %ld AND  ENC.COD_CLIENTE_CONTRA <= %ld))\n"
		"\t		 AND CONC.COD_CONCEPTO_ORIG = DET.COD_CONCEPTO \n"
		"\t		 AND CONC.IND_ACTIVO = 1\n"
		"\t		 AND FCLIE.COD_CLIENTE = ENC.COD_CLIENTE_CONTRA \n"
		"\t		 AND DET.IND_ORDENTOTAL <> FCLIE.IND_ORDENTOTAL\n"
		"\t		 AND DET.COD_CONCEPTO = CON.COD_CONCEPTO\n"
		"\t		 ORDER BY ENC.COD_CLIENTE_CONTRA, DET.NUM_ABONADO \n",
		lhCodCicloFact,ihCodCiclo,ihRngClientes,lhCodClienteIni,lhCodClienteFin);

	/*** FIN Declara Cursor ***/

	vDTrazasLog ( modulo,"\n\t** Query for cCursor_Clientes_FactuDif \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));


	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 5;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )109;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )2048;
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



	if (SQLCODE) {
		vDTrazasError  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
					   "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
					   "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE cCursor_Clientes_FactuDif CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_FactuDif >>"
							 "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Clientes_FactuDif >>"
							 "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}


    /* EXEC SQL OPEN cCursor_Clientes_FactuDif; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 5;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )128;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Clientes_FactuDif **",LOG01);
        vDTrazasError(modulo," ** No Existen Datos en cCursor_Clientes_FactuDif **",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en Open cCursor_Clientes_FactuDif **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en Open cCursor_Clientes_FactuDif **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    return (SQLOK);

}/*************************** Fin ifnOpenClientesFactuDif ************************/

/****************************************************************************/
/*  ifnFetchClientesFactuDif()  : Fetch de Cliente                         */
/****************************************************************************/
int ifnFetchClientesFactuDif ( int *iInd,
                               int *iCountClientes)
{
    char modulo[]   = "ifnFetchClientesFactuDif";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		int     ihNumSecDetalle;
		long    lhCodCliContra;
		long    lhCodCliAsoc;
		long    lhCodAbonAsoc;
		long    lhCodConcepto;
		double  lhMontoConcAsoc;
		long    lhCodConcDesc;
		long    lhCodConcDest;
		long    lhIndOrdenTotal;
		int	ihTipOperacion;
		int	ihTipModalidad;
		int	ihTipValor;
		char    szhCodMoneda[4];
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t Parametros entrada a ifnFetchClientesFactuDif\n"
						 "\t\t CountClientes [%d]\n"
						 "\t\t Ind registro  [%d]\n",
						 LOG03,
						 *iCountClientes,
						 *iInd);

	while (SQLCODE == SQLOK)
	{
    /* EXEC SQL FETCH cCursor_Clientes_FactuDif INTO
			:ihNumSecDetalle,
      :lhCodCliContra,
			:lhCodCliAsoc,
			:lhCodAbonAsoc,
			:lhCodConcepto,
			:lhMontoConcAsoc,
			:lhCodConcDesc,
			:lhCodConcDest,
			:lhIndOrdenTotal,
			:ihTipOperacion,
			:ihTipModalidad,
			:ihTipValor,
			:szhCodMoneda; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )143;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&ihNumSecDetalle;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&lhCodCliContra;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&lhCodCliAsoc;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)&lhCodAbonAsoc;
    sqlstm.sqhstl[3] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)&lhCodConcepto;
    sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&lhMontoConcAsoc;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&lhCodConcDesc;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&lhCodConcDest;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[7] = (         int  )0;
    sqlstm.sqindv[7] = (         short *)0;
    sqlstm.sqinds[7] = (         int  )0;
    sqlstm.sqharm[7] = (unsigned long )0;
    sqlstm.sqadto[7] = (unsigned short )0;
    sqlstm.sqtdso[7] = (unsigned short )0;
    sqlstm.sqhstv[8] = (unsigned char  *)&lhIndOrdenTotal;
    sqlstm.sqhstl[8] = (unsigned long )sizeof(long);
    sqlstm.sqhsts[8] = (         int  )0;
    sqlstm.sqindv[8] = (         short *)0;
    sqlstm.sqinds[8] = (         int  )0;
    sqlstm.sqharm[8] = (unsigned long )0;
    sqlstm.sqadto[8] = (unsigned short )0;
    sqlstm.sqtdso[8] = (unsigned short )0;
    sqlstm.sqhstv[9] = (unsigned char  *)&ihTipOperacion;
    sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[9] = (         int  )0;
    sqlstm.sqindv[9] = (         short *)0;
    sqlstm.sqinds[9] = (         int  )0;
    sqlstm.sqharm[9] = (unsigned long )0;
    sqlstm.sqadto[9] = (unsigned short )0;
    sqlstm.sqtdso[9] = (unsigned short )0;
    sqlstm.sqhstv[10] = (unsigned char  *)&ihTipModalidad;
    sqlstm.sqhstl[10] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[10] = (         int  )0;
    sqlstm.sqindv[10] = (         short *)0;
    sqlstm.sqinds[10] = (         int  )0;
    sqlstm.sqharm[10] = (unsigned long )0;
    sqlstm.sqadto[10] = (unsigned short )0;
    sqlstm.sqtdso[10] = (unsigned short )0;
    sqlstm.sqhstv[11] = (unsigned char  *)&ihTipValor;
    sqlstm.sqhstl[11] = (unsigned long )sizeof(int);
    sqlstm.sqhsts[11] = (         int  )0;
    sqlstm.sqindv[11] = (         short *)0;
    sqlstm.sqinds[11] = (         int  )0;
    sqlstm.sqharm[11] = (unsigned long )0;
    sqlstm.sqadto[11] = (unsigned short )0;
    sqlstm.sqtdso[11] = (unsigned short )0;
    sqlstm.sqhstv[12] = (unsigned char  *)szhCodMoneda;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Fecth Cursor cCursor_Clientes_FactuDif %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Fecth Cursor cCursor_Clientes_FactuDif %s ",LOG01,SQLERRM);
    }

    if( SQLCODE == SQLOK )
	{
		if(stClientesInd[*iCountClientes].lCodCliente != lhCodCliContra)
		{
			(*iCountClientes)++;
			memset(&stClientesInd[*iCountClientes],0,sizeof(CLIENTESIND));

			stClientesInd[*iCountClientes].lCodCliente = lhCodCliContra;
			stClientesInd[*iCountClientes].iIndIni = *iInd;
			stClientesInd[*iCountClientes].iIndFin = *iInd;
		}
		stClientesInd[*iCountClientes].iIndFin = *iInd;

		memset(&stDatosDobleCuenta[*iInd],0,sizeof(DATOSDOBLECUENTA));

		stDatosDobleCuenta[*iInd].iNumSecDetalle = ihNumSecDetalle;
		stDatosDobleCuenta[*iInd].lCodCliContra  = lhCodCliContra;
		stDatosDobleCuenta[*iInd].lCodCliAsoc    = lhCodCliAsoc;
		stDatosDobleCuenta[*iInd].lCodAbonAsoc   = lhCodAbonAsoc;
		stDatosDobleCuenta[*iInd].lCodConcepto   = lhCodConcepto;
		stDatosDobleCuenta[*iInd].lMontoConcAsoc = lhMontoConcAsoc;
		stDatosDobleCuenta[*iInd].lCodConcDesc   = lhCodConcDesc;
		stDatosDobleCuenta[*iInd].lCodConcDest   = lhCodConcDest;
		stDatosDobleCuenta[*iInd].lIndOrdenTotal = lhIndOrdenTotal;
		stDatosDobleCuenta[*iInd].iTipOperacion  = ihTipOperacion;
		stDatosDobleCuenta[*iInd].iTipModalidad  = ihTipModalidad;
		stDatosDobleCuenta[*iInd].iTipValor 	 = ihTipValor;
		stDatosDobleCuenta[*iInd].lColumna       = 0;
		strcpy(stDatosDobleCuenta[*iInd].szCodMoneda , szhCodMoneda);

		(*iInd)++;
	}

	} /*** Fin del While ***/

    return (SQLCODE);

}/************************* Fin ifnFetchClientesFactuDif *************************/

/****************************************************************************/
/*  bfnCloseClientesFactuDif()  : Cierra Cursor de Clientes                   */
/****************************************************************************/
BOOL bfnCloseClientesFactuDif()
{
    char modulo[]   = "bfnCloseClientesFactuDif";

    /* EXEC SQL CLOSE cCursor_Clientes_FactuDif; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )210;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }
    return (TRUE);
}/************************* Fin bfnCloseClientesFactuDif *************************/


BOOL bfnOpenConceptosAbon(long lCodCicloFact, int	iInd)
{
    char modulo[]   = "bfnOpenConceptosAbon";

	static char szCadenaSQL[2048];

	long	lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	long	lNumAbonado     = stDatosDobleCuenta[iInd].lCodAbonAsoc;
	double	dImpFactConcep;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        double dhTotaCargos   = 0.0;
        double dhTotalDescImp = 0.0;
        double dhTotalImpDesc = 0.0;
		long   lhCodConcepto  = 0;
		long   lhTipConcepto  = 0;
        double dhImpConcepto  = 0.0;


    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t Parametros Entrada a bfnOpenConceptosAbon\n"
						 "\t\t Cod_CiclFact [%ld]\n"
						 "\t\t Indice Reg.   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	/*** Declara Query  busca Total Importe Facturado por Concepto ***/

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

        sprintf(szCadenaSQL,"\t\t SELECT COD_CONCEPTO, COLUMNA,COD_TIPCONCE, NVL(IMP_CONCEPTO +(SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
				"\t\t FROM FA_FACTCONC_%d B \n"
				"\t\t WHERE B.COD_CONCEREL=A.COD_CONCEPTO \n"
				"\t\t AND B.IND_ORDENTOTAL= %ld \n"
				"\t\t AND B.NUM_ABONADO=%ld \n"
				"\t\t AND B.COD_TIPCONCE IN(2) \n"
				"\t\t AND B.COLUMNA_REL =A.COLUMNA) \n"
				"\t\t +(SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
				"\t\t FROM FA_FACTCONC_%d C \n"
				"\t\t WHERE C.COD_CONCEREL IN (SELECT COD_CONCEPTO \n"
				"\t\t               FROM FA_FACTCONC_%d \n"
				"\t\t              WHERE IND_ORDENTOTAL=%ld \n"
				"\t\t              AND NUM_ABONADO=%ld \n"
				"\t\t              AND COD_TIPCONCE IN (2)) \n"
				"\t\t AND C.IND_ORDENTOTAL=%ld \n"
				"\t\t AND C.NUM_ABONADO=%ld \n"
				"\t\t AND C.COD_TIPCONCE IN(2) \n"
				"\t\t AND C.COLUMNA_REL =A.COLUMNA \n"
				"\t\t AND C.COD_CONCEREL IN (SELECT COD_CONCEPTO \n"
				"\t\t          FROM FA_FACTCONC_%d D \n"
				"\t\t         WHERE D.COD_CONCEREL =A.COD_CONCEPTO \n"
				"\t\t         AND IND_ORDENTOTAL=%ld \n"
				"\t\t         AND NUM_ABONADO=%ld \n"
				"\t\t         AND COD_TIPCONCE IN (2))),0) IMP_CONCEPTO2, COD_CONCEREL, COLUMNA_REL \n"
				"\t\t FROM FA_FACTCONC_%d A \n"
				"\t\t WHERE IND_ORDENTOTAL = %ld \n"
				"\t\t AND NUM_ABONADO    = %ld \n"
				"\t\t AND COD_TIPCONCE IN (3,4) \n"
				"\t\t UNION ALL \n"
				"\t\t SELECT COD_CONCEREL,COLUMNA_REL, COD_TIPCONCE, NVL(IMP_CONCEPTO +(SELECT NVL(SUM(IMP_CONCEPTO),0)\n"
				"\t\t FROM FA_FACTCONC_%d B \n"
				"\t\t WHERE B.COD_CONCEREL=A.COD_CONCEPTO \n"
				"\t\t AND B.IND_ORDENTOTAL= %ld \n"
				"\t\t AND B.NUM_ABONADO=%ld \n"
				"\t\t AND B.COD_TIPCONCE IN(2) \n"
				"\t\t AND B.COLUMNA_REL =A.COLUMNA) \n"
				"\t\t +(SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
				"\t\t FROM FA_FACTCONC_%d C \n"
				"\t\t WHERE C.COD_CONCEREL IN (SELECT COD_CONCEPTO \n"
				"\t\t               FROM FA_FACTCONC_%d \n"
				"\t\t              WHERE IND_ORDENTOTAL=%ld \n"
				"\t\t              AND NUM_ABONADO=%ld \n"
				"\t\t              AND COD_TIPCONCE IN (2)) \n"
				"\t\t AND C.IND_ORDENTOTAL=%ld \n"
				"\t\t AND C.NUM_ABONADO=%ld \n"
				"\t\t AND C.COD_TIPCONCE IN(2) \n"
				"\t\t AND C.COLUMNA_REL =A.COLUMNA \n"
				"\t\t AND C.COD_CONCEREL IN (SELECT COD_CONCEPTO \n"
				"\t\t          FROM FA_FACTCONC_%d D \n"
				"\t\t         WHERE D.COD_CONCEREL =A.COD_CONCEPTO \n"
				"\t\t         AND IND_ORDENTOTAL=%ld \n"
				"\t\t         AND NUM_ABONADO=%ld \n"
				"\t\t         AND COD_TIPCONCE IN (2))),0) IMP_CONCEPTO2, COD_CONCEPTO, COLUMNA \n"
				"\t\t FROM FA_FACTCONC_%d A \n"
				"\t\t WHERE IND_ORDENTOTAL = %ld \n"
				"\t\t AND NUM_ABONADO    = %ld \n"
				"\t\t AND COD_TIPCONCE IN (1) \n"
				"\t\t ORDER BY 1,2 \n",
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
				lCodCicloFact,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
											 lIndOrdenTotal, lNumAbonado,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
				lCodCicloFact,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
											 lIndOrdenTotal, lNumAbonado,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado,
				lCodCicloFact, lIndOrdenTotal, lNumAbonado);



	vDTrazasLog ( modulo,"\n\t** Query for cCursor_CarFactConcepto \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )225;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )2048;
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



	if (SQLCODE) {
		vDTrazasError(modulo," en PREPARE de la Query cCursor_CarFactConcepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo," en PREPARE de la Query cCursor_CarFactConcepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE  cCursor_CarFactConcepto CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_CarFactConcepto [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_CarFactConcepto [%d]",LOG01,SQLCODE);
	    return (SQLCODE);
	}

    /* EXEC SQL OPEN cCursor_CarFactConcepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )244;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasError(modulo," en OPEN cCursor_CarFactConcepto  Existen Datos",LOG01);
        vDTrazasLog  (modulo," en OPEN cCursor_CarFactConcepto  Existen Datos",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en OPEN cCursor_CarFactConcepto [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_CarFactConcepto [%s]",LOG01,SQLERRM);
        return (SQLCODE);
    }
}/************************* Fin bfnOpenConceptosAbon **********************/


BOOL bfnFetchConceptosAbon(long *lCodConcepto, long *lTipConcepto, double *dImpConcepto, long *lColumna, long *lCodConceRel, long *lColumnaRel)
{
    char modulo[] = "bfnFetchConceptosAbon";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long   lhCodConcepto  = 0;
		long   lhColumna      = 0;
		long   lhTipConcepto  = 0;
    double dhImpConcepto  = 0.0;
		long   lhCodConceRel  = 0;
		long   lhColumnaRel   = 0;

    /* EXEC SQL END DECLARE SECTION; */ 


	/* EXEC SQL FETCH cCursor_CarFactConcepto INTO
						:lhCodConcepto
						,:lhColumna
						,:lhTipConcepto
						,:dhImpConcepto
						,:lhCodConceRel
						,:lhColumnaRel; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )259;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodConcepto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&lhColumna;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhTipConcepto;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&dhImpConcepto;
 sqlstm.sqhstl[3] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodConceRel;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhColumnaRel;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
}



	if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
	{
		vDTrazasError(modulo," en FECTH cCursor_CarFactConcepto [%s] ",LOG01,SQLERRM);
		vDTrazasLog  (modulo," en FECTH cCursor_CarFactConcepto [%s] ",LOG01,SQLERRM);
	}

	*lCodConcepto = lhCodConcepto;
	*lColumna     = lhColumna;
	*lTipConcepto = lhTipConcepto;
	*dImpConcepto = dhImpConcepto;
	*lCodConceRel = lhCodConceRel;  
	*lColumnaRel 	= lhColumnaRel ;



	return(SQLCODE);
}/************************* Fin bfnFetchConceptosAbon **********************/


BOOL bfnCloseConceptosAbon()
{
    char modulo[]   = "bfnCloseConceptosAbon";

	static char szCadenaSQL[2048];


	/* EXEC SQL CLOSE cCursor_CarFactConcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )298;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en CLOSE cCursor_CarFactConcepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en CLOSE cCursor_CarFactConcepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

    return (TRUE);

}/************************* Fin bfnCloseConceptosAbon **********************/


BOOL bfnGetTotImpFactConceptoAbon(long lCodCicloFact, int	iInd)
{
    char modulo[]   = "bfnGetTotImpFactConceptoAbon";

	static char szCadenaSQL[2048];

	long	lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	long	lNumAbonado     = stDatosDobleCuenta[iInd].lCodAbonAsoc;
	double	dImpFactConcep;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        double dhTotaCargos   = 0.0;
        double dhTotalDescImp = 0.0;
        double dhTotalImpDesc = 0.0;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t Parametros Entrada a bfnGetTotImpFactConceptoAbon\n"
						 "\t\t Cod_CiclFact [%ld]\n"
						 "\t\t Indice Reg.   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	/*** Declara Query  busca Total Importe Facturado por Concepto ***/

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t SELECT\n"
					"\t\t (SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
					"\t\t	FROM FA_FACTCONC_%ld \n"
					"\t\t	WHERE IND_ORDENTOTAL = %ld \n"
					"\t\t		AND NUM_ABONADO    = %ld \n"
					"\t\t   		AND COD_CONCEPTO IN (SELECT COD_CONCEPTO FROM FA_FACTCONC_%d WHERE IND_ORDENTOTAL=%ld AND NUM_ABONADO=%ld AND COD_TIPCONCE IN (3,4)) \n"
					"\t\t   		AND COD_TIPCONCE IN (3,4)) CARGOS, \n"
					"\t\t(SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
					"\t\t	FROM FA_FACTCONC_%ld \n"
					"\t\t	WHERE IND_ORDENTOTAL = %ld \n"
					"\t\t	   	AND NUM_ABONADO    = %ld \n"
					"\t\t		AND COD_CONCEREL IN (SELECT COD_CONCEREL FROM FA_FACTCONC_%d WHERE IND_ORDENTOTAL=%ld AND NUM_ABONADO=%ld AND COD_TIPCONCE IN(1,2)) \n"
					"\t\t		AND COD_TIPCONCE IN(1,2)) IMPTOS_Y_DCTOS, \n"
					"\t\t(SELECT NVL(SUM(B.IMP_CONCEPTO),0)\n"
					"\t\t	   FROM FA_FACTCONC_%ld A, FA_FACTCONC_%ld B \n"
					"\t\t	   WHERE A.IND_ORDENTOTAL = %ld \n"
					"\t\t	   		 AND A.NUM_ABONADO    = %ld \n"
					"\t\t			 AND A.COD_CONCEREL IN (SELECT COD_CONCEREL FROM FA_FACTCONC_%d WHERE IND_ORDENTOTAL=%ld AND NUM_ABONADO=%ld AND COD_TIPCONCE = 2 ) \n"
					"\t\t			 AND A.COD_TIPCONCE   = 2 \n"
					"\t\t			 AND B.COD_CONCEREL   = A.COD_CONCEPTO \n"
					"\t\t			 AND B.IND_ORDENTOTAL = A.IND_ORDENTOTAL \n"
					"\t\t			 AND B.NUM_ABONADO    = A.NUM_ABONADO \n"
					"\t\t			 AND B.COD_TIPCONCE   = 1)IMPUESTO_DE_DESCUENTOS \n"
					"\t\tFROM DUAL \n",
					lCodCicloFact, lIndOrdenTotal, lNumAbonado,
					lCodCicloFact, lIndOrdenTotal, lNumAbonado,
					lCodCicloFact, lIndOrdenTotal, lNumAbonado,
					lCodCicloFact, lIndOrdenTotal, lNumAbonado,
					lCodCicloFact, lCodCicloFact, lIndOrdenTotal, lNumAbonado, lCodCicloFact, lIndOrdenTotal, lNumAbonado);


	vDTrazasLog ( modulo,"\n\t** Query for cCursor_Tot_Importe_Concepto \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )313;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )2048;
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



	if (SQLCODE) {
		vDTrazasError(modulo," en PREPARE de la Query Cursor_Tot_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo," en PREPARE de la Query Cursor_Tot_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE cCursor_Tot_Importe_Concepto CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_Tot_Importe_Concepto [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Tot_Importe_Concepto [%d]",LOG01,SQLCODE);
	    return (SQLCODE);
	}

    /* EXEC SQL OPEN cCursor_Tot_Importe_Concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )332;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasError(modulo," en OPEN cCursor_Tot_Importe_Concepto  Existen Datos",LOG01);
        vDTrazasLog  (modulo," en OPEN cCursor_Tot_Importe_Concepto  Existen Datos",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en OPEN cCursor_Tot_Importe_Concepto [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_Tot_Importe_Concepto [%s]",LOG01,SQLERRM);
        return (SQLCODE);
    }

    /* EXEC SQL FETCH cCursor_Tot_Importe_Concepto INTO
			:dhTotaCargos,
			:dhTotalDescImp,
			:dhTotalImpDesc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )347;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotaCargos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&dhTotalDescImp;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&dhTotalImpDesc;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en FECTH cCursor_Tot_Importe_Concepto [%s] ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en FECTH cCursor_Tot_Importe_Concepto [%s] ",LOG01,SQLERRM);
    }

    if( SQLCODE == SQLOK )
		stDatosDobleCuenta[iInd].lImpFactConcep = dhTotaCargos + dhTotalDescImp + dhTotalImpDesc;
	vDTrazasLog(modulo," Abonado [%d]  stDatosDobleCuenta[%d].lImpFactConcep=[%.4f] = [%.4f]+[%.4f]+[%.4f]",LOG05,stDatosDobleCuenta[iInd].lCodAbonAsoc, iInd, stDatosDobleCuenta[iInd].lImpFactConcep, dhTotaCargos, dhTotalDescImp, dhTotalImpDesc);

    /* EXEC SQL CLOSE cCursor_Tot_Importe_Concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )374;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en CLOSE cCursor_Tot_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en CLOSE cCursor_Tot_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	vDTrazasLog  (modulo,"\n\t Valores obtenidos por Total Cargos, Impuestos : \n"
						"\t\t Tot Cargo       [%.4f] \n"
						"\t\t Tot Imp y Desc  [%.4f] \n"
						"\t\t Tot Imp de Desc [%.4f] \n",
						LOG05,
						dhTotaCargos, dhTotalDescImp, dhTotalImpDesc);

    return (TRUE);

}/************************* Fin bfnGetTotImpFactConceptoAbon **********************/

BOOL bfnAjusteporAbonado(long lCodCicloFact, int	iInd, double *dImpOriginalObtenido)
{
	char modulo[]   = "bfnAjusteporAbonado";
	double dMontoAjuste=0.0;
  long lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	long lNumAbonado     = stDatosDobleCuenta[iInd].lCodAbonAsoc;

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        double dhMaxImpFacturable = 0.0;
        long   lhCodConceRel=0;
        long   lhCodColumnaRel=0;
        char   szCadenaSQL [3000];
        char   szIndOrdenTotal[13];
				double dImpFacturableDobleCta=0.0;
				double dImpConceptoDobleCta=0.0;
				double dImpDctoDobleCta=0.0;
  /* EXEC SQL END DECLARE SECTION; */ 


	dhMaxImpFacturable = dMaxImpFacturable;
	lhCodConceRel		= lGCodConceRel;
	lhCodColumnaRel = lGCodColumnaRel;

	vDTrazasLog  (modulo,"PGG - Entro a bfnAjusteporAbonado -->  dImpOriginalObtenido 	[%f] \n", LOG05, *dImpOriginalObtenido);
	
  /* rescatar importes por abonado */
	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t SELECT SUM(A.IMP_CONCEPTO), SUM(A.IMP_FACTURABLE) , ABS(NVL(B.TOTAL_DESCUENTOS,0)) \n" 
				"\t\t FROM FA_FACTCONC_%ld A , (SELECT SUM(IMP_FACTURABLE)  TOTAL_DESCUENTOS \n"
				"\t\t FROM FA_FACTCONC_%ld  \n"
				"\t\t WHERE IND_ORDENTOTAL = %ld \n"
				"\t\t AND NUM_ABONADO = %ld \n"
				"\t\t AND COD_TIPCONCE = 2 \n"
				"\t\t AND COD_CONCEPTO = 3450) B \n"
				"\t\t WHERE A.IND_ORDENTOTAL = %ld  \n"
				"\t\t AND A.NUM_ABONADO = %ld \n"
				"\t\t GROUP BY B.TOTAL_DESCUENTOS \n"
				,lCodCicloFact, lCodCicloFact, lIndOrdenTotal, lNumAbonado, lIndOrdenTotal, lNumAbonado);

	vDTrazasLog ( modulo,"\n\t** Query for cCursor_Tot_por_abonado \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )389;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )3000;
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



	if (SQLCODE) {
		vDTrazasError(modulo," en PREPARE de la Query cCursor_Tot_por_abonado [%d] : [%s]\n",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo," en PREPARE de la Query cCursor_Tot_por_abonado [%d] : [%s]\n",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE cCursor_Tot_por_abonado CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_Tot_por_abonado [%d]\n",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Tot_por_abonado [%d]\n",LOG01,SQLCODE);
	    return (SQLCODE);
	}

  /* EXEC SQL OPEN cCursor_Tot_por_abonado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )408;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqcmod = (unsigned int )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



  if(SQLCODE == SQLNOTFOUND)
  {
      vDTrazasError(modulo," en OPEN cCursor_Tot_por_abonado no Existen Datos\n",LOG01);
      vDTrazasLog  (modulo," en OPEN cCursor_Tot_por_abonado no Existen Datos\n",LOG01);
      return (SQLCODE);
  }
  if(SQLCODE != SQLOK)
  {
      vDTrazasError(modulo, " en OPEN cCursor_Tot_por_abonado [%s]\n",LOG01,SQLERRM);
      vDTrazasLog  (modulo, " en OPEN cCursor_Tot_por_abonado [%s]\n",LOG01,SQLERRM);
      return (SQLCODE);
  }

  /* EXEC SQL FETCH cCursor_Tot_por_abonado INTO :dImpConceptoDobleCta, :dImpFacturableDobleCta, :dImpDctoDobleCta; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )423;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&dImpConceptoDobleCta;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[0] = (         int  )0;
  sqlstm.sqindv[0] = (         short *)0;
  sqlstm.sqinds[0] = (         int  )0;
  sqlstm.sqharm[0] = (unsigned long )0;
  sqlstm.sqadto[0] = (unsigned short )0;
  sqlstm.sqtdso[0] = (unsigned short )0;
  sqlstm.sqhstv[1] = (unsigned char  *)&dImpFacturableDobleCta;
  sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
  sqlstm.sqhsts[1] = (         int  )0;
  sqlstm.sqindv[1] = (         short *)0;
  sqlstm.sqinds[1] = (         int  )0;
  sqlstm.sqharm[1] = (unsigned long )0;
  sqlstm.sqadto[1] = (unsigned short )0;
  sqlstm.sqtdso[1] = (unsigned short )0;
  sqlstm.sqhstv[2] = (unsigned char  *)&dImpDctoDobleCta;
  sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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



	vDTrazasLog(modulo, "---> PPV <--- dImpConceptoDobleCta	[%lf]		 \n",LOG05, dImpConceptoDobleCta);

  /* Dejo la sumatoria redondeada de acuerdo al USOFACT */
  dImpConceptoDobleCta = fnCnvDouble(dImpConceptoDobleCta,1); /* --> Tiene q ser a 2 decimales :1 = USOFACT */

  if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
  {
      vDTrazasError(modulo," en FECTH cCursor_Tot_por_abonado [%s] \n",LOG01,SQLERRM);
      vDTrazasLog  (modulo," en FECTH cCursor_Tot_por_abonado [%s] \n",LOG01,SQLERRM);
  }

  if( SQLCODE == SQLOK ) dMontoAjuste = dImpConceptoDobleCta - dImpFacturableDobleCta;

	vDTrazasLog(modulo," Abonado [%ld]  dMontoAjuste[%lf] = dImpConceptoDobleCta[%lf] - dImpFacturableDobleCta[%lf]  - dImpDctoDobleCta [%lf] \n",LOG05,lNumAbonado, dMontoAjuste,dImpConceptoDobleCta,dImpFacturableDobleCta, dImpDctoDobleCta );

  /* EXEC SQL CLOSE cCursor_Tot_por_abonado; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )450;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


  if ( SQLCODE != SQLOK )
  {
      vDTrazasError(modulo," en CLOSE cCursor_Tot_por_abonado [%d] : [%s]\n",LOG01,SQLCODE,SQLERRM);
      vDTrazasLog  (modulo," en CLOSE cCursor_Tot_por_abonado [%d] : [%s]\n",LOG01,SQLCODE,SQLERRM);
      return (FALSE);
  }

  /********************************************/

  memset (szCadenaSQL, 0 , sizeof(szCadenaSQL));
	vDTrazasLog  (modulo,"dhMaxImpFacturable [%lf]  lhCodConceRel[%ld] hCodColumnaRel[%ld]\n",
	              LOG05,dhMaxImpFacturable,lhCodConceRel,lhCodColumnaRel);

	if ((dMontoAjuste > 0.000001)||(dMontoAjuste < -0.000001))
	{
		lhCodConceRel		= lGCodConceRel;
		lhCodColumnaRel = lGCodColumnaRel;

		vDTrazasLog  (modulo,"Despues de asignacion lhCodConceRel[%ld] lhCodColumnaRel[%ld]\n",
	  	            LOG05,lhCodConceRel,lhCodColumnaRel);

		dMontoAjuste_Glob = dMontoAjuste;

		vDTrazasLog  (modulo,"PGG - dMontoAjuste_Glob Antes del UPDATE del Descuento [%f] \n", LOG05,dMontoAjuste_Glob);
		vDTrazasLog  (modulo,"PGG - ABONADO ajustado [%ld] \n", LOG05, lNumAbonado);

		sprintf(szCadenaSQL,"UPDATE FA_FACTCONC_%ld\n"
    	                	"\t SET IMP_FACTURABLE = IMP_FACTURABLE + %lf\n"
		  	              	"\t WHERE IND_ORDENTOTAL = %ld\n"
		    	            	"\t AND NUM_ABONADO = %ld\n"
		      	          	"\t AND COD_TIPCONCE = 2\n"
		        	        	"\t AND COD_CONCEREL = %ld\n"
		          	      	"\t AND COLUMNA_REL = %ld\n"
												"\t AND ROWNUM < 2 \n"  ,lCodCicloFact, dMontoAjuste, lIndOrdenTotal, lNumAbonado, lhCodConceRel, lhCodColumnaRel);
		
		vDTrazasLog  (modulo,"PGG - dImpDctoDobleCta  ---> [%f] \n", LOG05, dImpDctoDobleCta);		 
		dImpDctoDobleCta -= dMontoAjuste;
		*dImpOriginalObtenido = dImpDctoDobleCta;				
		dMontoAjuste_Glob = 0.0;
		vDTrazasLog  (modulo,"PGG - dImpOriginalObtenido Ahora vale ---> [%f] \n", LOG05, *dImpOriginalObtenido);
		vDTrazasLog  (modulo,"PGG - dMontoAjuste_Glob ahora se hace cero ---> [%f] \n", LOG05, dMontoAjuste_Glob);
		
    return (bfnExecuteQuery(szCadenaSQL));
  }
  else
	{
		vDTrazasLog  (modulo,"EN ELSE \n", LOG05);
		vDTrazasLog  (modulo,"PGG - dImpOriginalObtenido 	[%f] \n", LOG05, *dImpOriginalObtenido);
		vDTrazasLog  (modulo,"PGG - dImpDctoDobleCta 			[%f] \n", LOG05, dImpDctoDobleCta);
		
		if (*dImpOriginalObtenido != dImpDctoDobleCta)
		{		
				*dImpOriginalObtenido = dImpDctoDobleCta;
				vDTrazasLog  (modulo,"PGG - dImpOriginalObtenido Ahora vale ---> [%f] \n", LOG05, *dImpOriginalObtenido);
		}
	}

  return (TRUE);

}/************************* Fin bfnAjusteporAbonado **********************/

/****************************************************************************/
/*  bfnProcesaClientesFactuDif()  : */
/****************************************************************************/
BOOL bfnProcesaClientesFactuDif(long lCodCicloFact,
						 int	iInd,
						 int	iCountClientes)
{
    char modulo[]   = "bfnProcesaClientesFactuDif";

	int 	iIndAux;
	int 	iCountAux;
	double	dDifImpFactConcep=0;
	double	dDifImpDescConcep=0;
	double	dLimiteMontoAbo=0;
	long    lCodConcepto  = 0;
	long    lTipConcepto  = 0;
	double  dImpConcepto  = 0.0;
	long    lColumna      = 0;

	long    lCodConceptoRel= 0;
	long    lColumnaRel    = 0;

    vDTrazasLog  (modulo,"\n\t Parametros entrada a bfnProcesaClientesFactuDif\n"
						 "\t\t Cod Ciclo Fact [%d]\n"
						 "\t\t CountClientes  [%d]\n"
						 "\t\t Ind registro   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iCountClientes,
						 iInd);

	/***
	Se recorren todos los clientes obtenidos del registro
	Doble Cuenta
	***/
	for(iCountAux = 0;
		iCountAux <= iCountClientes;
		iCountAux++)
	{
		vDTrazasLog (modulo,"\t Cliente a Procesar :\n"
                            "\t\t Cliente      [%ld]\n"
                            "\t\t Indice Ini   [%ld]\n"
                            "\t\t Indice Fin   [%ld]\n",
                            LOG03,
							stClientesInd[iCountAux].lCodCliente,
							stClientesInd[iCountAux].iIndIni,
							stClientesInd[iCountAux].iIndFin);

		/*** Se Totalizan los cargos por Abonado-Concepto asociado al Cliente contratante ***/
		for(iIndAux = stClientesInd[iCountAux].iIndIni;
			iIndAux <= stClientesInd[iCountAux].iIndFin;
			iIndAux++)
		{

			dDifImpFactConcep = 0;

			if (stDatosDobleCuenta[iIndAux].iTipOperacion == DOBLECUENTA_FD)
			{
				/***
				Operacion DOBLE CUENTA deshabilitada para Panama,
				se desarrollo como Traspaso, [CAOH, PANAMA 19102007]
				***/
				continue;

			}
			else if (stDatosDobleCuenta[iIndAux].iTipOperacion == TRASPASO_FD)
			{
				if ( stDatosDobleCuenta[iIndAux].iTipModalidad == TF)
				{
					dLimiteMontoAbo=stDatosDobleCuenta[iIndAux].lMontoConcAsoc;
					vDTrazasLog (modulo,"\n\tTF\t Limite por Total Facturado Abonado [%d]=[%.4f]\n", LOG03, stDatosDobleCuenta[iCountAux].lCodAbonAsoc, dLimiteMontoAbo);

					if(!bfnGetTotImpFactConceptoAbon(lCodCicloFact, iIndAux))
					{
						vDTrazasLog (modulo,"\t\t Error en bfnGetTotImpFactConceptoAbon\n", LOG03);
						return FALSE;
					}

					vDTrazasLog (modulo,"\tTF\t Importe Fact Conc  [%.4f]  Saldo Limite por Total Facturado [%.4f]\n", LOG03, stDatosDobleCuenta[iIndAux].lImpFactConcep, dLimiteMontoAbo);

					/*** se imprime el registro de Cliente-Abonado si LOG03 ***/
					vfnPrintDatosDobleCuenta(iIndAux);

					if ( stDatosDobleCuenta[iIndAux].iTipValor == MONTO )
					{
								strcpy(stDatosDobleCuenta[iIndAux].szCodMoneda, alltrim (stDatosDobleCuenta[iIndAux].szCodMoneda));

								if (strcmp(stDatosDobleCuenta[iIndAux].szCodMoneda , stDatosGener.szCodMoneFact) != 0 )
								{
									if (!bConverMoneda (stDatosDobleCuenta[iIndAux].szCodMoneda,stDatosGener.szCodMoneFact,stFecProceso.szFecEmision,&dLimiteMontoAbo,stDatosGener.iCodCiclo))
									{
											vDTrazasLog (modulo,"\tFallo la conversion de moneda\n", LOG03);
		       						return FALSE;
		       				}

								}

								if (dLimiteMontoAbo < stDatosDobleCuenta[iIndAux].lImpFactConcep)
								{
									dDifImpFactConcep =  stDatosDobleCuenta[iIndAux].lImpFactConcep - dLimiteMontoAbo;
								}
								if(dLimiteMontoAbo > 0)
								{
									dLimiteMontoAbo-=stDatosDobleCuenta[iIndAux].lImpFactConcep;
								}
								if(dLimiteMontoAbo < 0)
								{
									dLimiteMontoAbo=0;
								}



					}
					else if (stDatosDobleCuenta[iIndAux].iTipValor == PORCENTAJE )
					{
						vDTrazasLog (modulo,"\n\tTF\t Tipo de Valor Porcentual no permitido en por Total Facturado...[%d] [%.4f]\n", LOG03,stDatosDobleCuenta[iIndAux].iTipValor, stDatosDobleCuenta[iIndAux].lImpFactConcep);

					}
					else
					{
						vDTrazasLog (modulo,"\n\tTF\t Tipo de Valor no permitido ....[%d]\n", LOG03,stDatosDobleCuenta[iIndAux].iTipValor);
					}

					vDTrazasLog (modulo,"\n\tTF\t Diferencia Importe Facturado [%.4f]  Saldo Limite [%.4f]\n", LOG03,dDifImpFactConcep, dLimiteMontoAbo);
				}
				else if ( stDatosDobleCuenta[iIndAux].iTipModalidad == CF)
				{
					if(!bfnGetImpFactuConceptoAbon(lCodCicloFact, iIndAux))
					{
						vDTrazasLog (modulo,"\t\t Error en bfnGetImpFactuConceptoAbon\n", LOG03);
						return FALSE;
					}

					vDTrazasLog (modulo,"\t\t Importe Fact Conc  [%.4f]  Saldo Limite por Concepto [%d][%.4f]\n", LOG03, stDatosDobleCuenta[iIndAux].lImpFactConcep, stDatosDobleCuenta[iIndAux].lCodConcepto, stDatosDobleCuenta[iIndAux].lMontoConcAsoc);

					/*** se imprime el registro de Cliente-Abonado si LOG03 ***/
					vfnPrintDatosDobleCuenta(iIndAux);

					if ( stDatosDobleCuenta[iIndAux].iTipValor == MONTO )
					{
							dLimiteMontoAbo = stDatosDobleCuenta[iIndAux].lMontoConcAsoc;

							strcpy(stDatosDobleCuenta[iIndAux].szCodMoneda, alltrim (stDatosDobleCuenta[iIndAux].szCodMoneda));

							if (strcmp(stDatosDobleCuenta[iIndAux].szCodMoneda , stDatosGener.szCodMoneFact) != 0 )
							{
								if (!bConverMoneda (stDatosDobleCuenta[iIndAux].szCodMoneda,stDatosGener.szCodMoneFact,stFecProceso.szFecEmision,&dLimiteMontoAbo,stDatosGener.iCodCiclo))
								{
										vDTrazasLog (modulo,"\tFallo la conversion de moneda\n", LOG03);
	       						return FALSE;
	       				}

							}
							dDifImpFactConcep = stDatosDobleCuenta[iIndAux].lImpFactConcep - dLimiteMontoAbo;
							
					}
					else if (stDatosDobleCuenta[iIndAux].iTipValor == PORCENTAJE )
					{
						dDifImpFactConcep = stDatosDobleCuenta[iIndAux].lImpFactConcep - (stDatosDobleCuenta[iIndAux].lMontoConcAsoc * stDatosDobleCuenta[iIndAux].lImpFactConcep / 100);
					}
					else
					{
						vDTrazasLog (modulo,"\n\t\t Tipo de Valor no permitido ....[%d]\n",
										LOG03,stDatosDobleCuenta[iIndAux].iTipValor);
					}

					vDTrazasLog (modulo,"\n\t\t Diferencia Importe Facturado  [%.4f]\n",
		                                LOG03,dDifImpFactConcep);
				}
				else
				{
					vDTrazasLog (modulo,"\n\t\t Tipo de Modalidad no permitida ....[%d]\n",
										LOG03,stDatosDobleCuenta[iIndAux].iTipModalidad);
				}

			}
			else
			{
					vDTrazasLog (modulo,"\n\t\t Tipo de Operacion no permitida ....[%d]\n",
									LOG03,stDatosDobleCuenta[iIndAux].iTipOperacion);
			}

			stClientesInd[iCountAux].iTotAbonados++;

			/***
			Se evalua si procede a Aplicar Descuento-Cargo al
			Cliente Contratante, Cliente Asociado
			Si Imp. Facturado - Imp. Contratado > 0 ==> Aplica
			***/

			if (dDifImpFactConcep > 0)
			{
				vDTrazasLog (modulo,"\n\t *** SE APLICA CARGO ***\n",LOG03);

				/*** Se valida si el Cliente Asociado ha sido Facturado ***/
				if (!bfnBuscaFacturaCliAsoc(lCodCicloFact, iIndAux))
				{
					vDTrazasError(modulo," en retorno funcion bfnProcesaClientesFactuDif",LOG01);
					vDTrazasLog  (modulo," en retorno funcion bfnProcesaClientesFactuDif",LOG01);

					/*** en este caso se continua al siguiente registro ***/
					continue;

				}

				/*** Se obtine la informacion del Concepto a aplicar,desde el cliente  facturado ***/
				if(!bfnBuscaInfConceptoFacturado(lCodCicloFact, iIndAux))
				{
					vDTrazasError(modulo,"en retorno de funcion bfnBuscaInfConceptoFacturado",LOG01);
					vDTrazasLog  (modulo,"en retorno de funcion bfnBuscaInfConceptoFacturado",LOG01);
					return (FALSE);
				}

				/*** Se aplica el Descuento al Cliente Contratante COD_TIP_CONCEPTO = 2 ***/
				if ( stDatosDobleCuenta[iIndAux].iTipModalidad == TF)
				{
					if(!bfnOpenConceptosAbon(lCodCicloFact, iIndAux))
					{
						vDTrazasLog (modulo,"\t\t Error en bfnGetTotImpFactConceptoAbon\n", LOG03);
						return FALSE;
					}

					dMaxImpFacturable = 0.0;
					lGCodConceRel		= 0;
					lGCodColumnaRel = 0;		

					dDifImpDescConcep=dDifImpFactConcep;
					while(bfnFetchConceptosAbon(&lCodConcepto, &lTipConcepto, &dImpConcepto, &lColumna, &lCodConceptoRel, &lColumnaRel)== SQLOK)
					{
								if (dImpConcepto != 0.0)
								{
										if (lTipConcepto == 3)
										{
											stDatosDobleCuenta[iIndAux].lCodConcepto=lCodConcepto;
											stDatosDobleCuenta[iIndAux].lColumna=lColumna;
										}
										else
										{
											stDatosDobleCuenta[iIndAux].lCodConcepto=lCodConceptoRel;
				              stDatosDobleCuenta[iIndAux].lColumna=lColumnaRel;
				            }

				            vDTrazasLog  (modulo,"\n\t Conceptos por Abonado: \n"
										"\t\t Concepto [%ld] \n"
										"\t\t Tip Concepto [%ld] \n"
										"\t\t Imp Concepto [%.4f] \n"
										"\t\t dDifImpDescConcep [%.4f] \n"
										"\t\t ConceptoRel [%ld] \n"
										"\t\t lColumnaRel [%ld] \n",
										LOG05,lCodConcepto, lTipConcepto, dImpConcepto,dDifImpDescConcep, lCodConceptoRel, lColumnaRel);

										if (dImpConcepto <= dDifImpDescConcep )
										{
											dDifImpDescConcep -= dImpConcepto;
											vDTrazasLog (modulo,"\n\t *** SE APLICA DESCUENTO TOTAL CONCEPTO [%d] DE [%.4f] ***\n",LOG03, lCodConcepto, dImpConcepto);
											if(!bfnAplicaCargosFactDif(2,dImpConcepto, lCodCicloFact, iIndAux))
											{
												vDTrazasError(modulo," al aplicar Descuento Cliente Contratante",LOG01);
												vDTrazasLog  (modulo," al aplicar Descuento Cliente Contratante",LOG01);
											}
										}
										else if(dDifImpDescConcep > 0)
										{
											vDTrazasLog (modulo,"\n\t *** SE APLICA DESCUENTO POR DIFERENCIA=[%.4f] ***\n",LOG03, dDifImpDescConcep);
											if(!bfnAplicaCargosFactDif(2,dDifImpDescConcep, lCodCicloFact, iIndAux))
											{
												vDTrazasError(modulo," al aplicar Descuento Cliente Contratante",LOG01);
												vDTrazasLog  (modulo," al aplicar Descuento Cliente Contratante",LOG01);
											}
											dDifImpDescConcep=0;
										}
										else
										{
											vDTrazasLog (modulo,"\n\t *** NO HAY MAS DESCUENTOS : DIFERENCIA=[%.4f] FIN ***\n",LOG03, dDifImpDescConcep);
 											break;
										}
								}
					}
					if(!bfnCloseConceptosAbon())
					{
						vDTrazasLog (modulo,"\t\t Error en bfnCloseConceptosAbon\n", LOG03);
						return FALSE;
					}

				}
				else if(!bfnAplicaCargosFactDif(2,dDifImpFactConcep, lCodCicloFact, iIndAux))
				{
					vDTrazasError(modulo," al aplicar Descuento Cliente Contratante",LOG01);
					vDTrazasLog  (modulo," al aplicar Descuento Cliente Contratante",LOG01);
				}

				dMontoAjuste_Glob = 0.0; 

 				/* if (!bfnAjusteporAbonado(lCodCicloFact, iIndAux, &dDifImpFactConcep))
				{
					vDTrazasError(modulo," al Ajustar Abonado Cliente Contratante Doble Cuenta ",LOG01);
					vDTrazasLog  (modulo," al Ajustar Abonado Cliente Contratante Doble Cuenta ",LOG01);
				} */ /* P-MIX-09003 */

				/*** se recalcula FA_FACTABON_ciclo Abonado Cargo ***/
				if(!bfnUpdateFactAbon(1,fnCnvDouble(dDifImpFactConcep,1), lCodCicloFact, iIndAux)) /*  PPV 74293 19/01/2009 Se redondea importe a descontar en Fa_factAbon */
				{
					vDTrazasError (modulo," al recalcular FactAbon Abonado Cargo ",LOG01);
					vDTrazasLog (modulo," al recalcular FactAbon Abonado Cargo ",LOG01);
				}
				else
				{
					/*** Se Aplica el Cargo al Cliente Asociado COD_TIP_CONCEPTO = 3 ***/
					if(!bfnAplicaCargosFactDif(3,dDifImpFactConcep, lCodCicloFact, iIndAux))
					{
						/*** ACA PUEDE IR UN ROLLBACK  ABONADO  ***/
						vDTrazasError (modulo," al aplicar Cargos Cliente Asociado ",LOG01);
						vDTrazasLog (modulo," al aplicar Cargos Cliente Asociado",LOG01);
						stClientesInd[iCountAux].iTotAbonErr++;
					}
					else
					{
						/*** se recalcula FA_FACTABON_ciclo Abonado 0 ***/
						if(!bfnUpdateFactAbon(0,fnCnvDouble(dDifImpFactConcep,1), lCodCicloFact, iIndAux)) /*  PPV 74293 19/01/2009 Se redondea importe a descontar en Fa_factAbon */
						{
							vDTrazasError (modulo," al recalcular FactAbon Abonado 0 ",LOG01);
							vDTrazasLog (modulo," al recalcular FactAbon Abonado 0 ",LOG01);
						}
						else
						{
							/*** se recalcula FACT_DOCU_ciclo Cliente Asociado ***/
							if(!bfnRecalculaDocuCicloCli(1,lCodCicloFact,iIndAux))
							{
								vDTrazasError (modulo,"ERROR al recalcular FactDocu Cliente Contratante ",LOG01);
								vDTrazasLog (modulo,"ERROR al recalcular FactDocu Cliente Contratante ",LOG01);
							}
							else
							{
								vDTrazasLog (modulo,"\n\t Se Actualizo Docum. Fact. Cliente Asociado[%ld]",
													LOG03,stDatosDobleCuenta[stClientesInd[iCountAux].iIndFin].lCodCliAsoc);

								if (!bfnUpdateIndOrdenTotalFD(iIndAux))
								{
									vDTrazasError (modulo," al actualizar Ind Orden Total Abonado FD",LOG01);
									vDTrazasLog (modulo," al actualizar Ind Orden Total Abonado FD",LOG01);
								}
								else
									stClientesInd[iCountAux].iTotAbonFD++;

							}
						}
					}
				}
			}
		} /*** for iIndAux ***/

		/***
		Despues de procesar los Abonados del Cliente, se recalcula los
		registros de facturacion del Cliente Contratante
		[CAOH, PANAMA 24102007]
		***/
		if ( stClientesInd[iCountAux].iTotAbonFD > 0)
		{
			/*** se recalcula FACT_DOCU_ciclo Cliente Contratante ***/
			if(!bfnRecalculaDocuCicloCli(0,lCodCicloFact,stClientesInd[iCountAux].iIndFin))
			{
				vDTrazasError (modulo,"ERROR al recalcular FactDocu Cliente Contratante ",LOG01);
				vDTrazasLog (modulo,"ERROR al recalcular FactDocu Cliente Contratante ",LOG01);
			}
			else
			{
				vDTrazasLog (modulo,"\n\t Se Actualizo Docum. Fact. Cliente Contratante[%ld]",
									LOG03,stClientesInd[iCountAux].lCodCliente);

				if (!bfnOraCommit ())
			    {
			        vDTrazasError(modulo," en COMMIT bfnProcesaClientesFactuDif", LOG01);
			        vDTrazasLog  (modulo," en COMMIT bfnProcesaClientesFactuDif", LOG01);
			        return (FALSE);
			    }
				else
					vDTrazasLog  (modulo,"\n\t se Aplico COMMIT en bfnProcesaClientesFactuDif", LOG03);

			}
		} /*** FIN if  stClientesInd[iCountAux].iTotAbonFD > 0 ***/

		vDTrazasLog (modulo,"\t Estadisticas Cliente :\n"
                            "\t\tCliente Contratante  [%ld]\n"
                            "\t\tTotal Abonados       [%ld]\n"
                            "\t\tTotal Abonados OK    [%ld]\n"
                            "\t\tTotal Abonados ERROR [%ld]\n",
                            LOG03,
							stClientesInd[iCountAux].lCodCliente,
							stClientesInd[iCountAux].iTotAbonados,
							stClientesInd[iCountAux].iTotAbonFD,
							stClientesInd[iCountAux].iTotAbonErr);

	} /*** for iCountAux ***/

    return (TRUE);

}/************************* Fin bfnProcesaClientesFactuDif *************************/

BOOL bfnBuscaInfConceptoFacturado(long lCodCicloFact, int iInd)
{
    char modulo[]   = "bfnBuscaInfConceptoFacturado";

	static char szCadenaSQL[2048];

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char    szhFecValor[15];        /* EXEC SQL VAR szhFecValor IS STRING(15) ; */ 

		char    szhFecEfectividad[15];  /* EXEC SQL VAR szhFecEfectividad IS STRING(15) ; */ 

		char    szhCodRegion[4];        /* EXEC SQL VAR szhCodRegion IS STRING(4) ; */ 

		char    szhCodProvincia[6];     /* EXEC SQL VAR szhCodProvincia IS STRING(6) ; */ 

		char    szhCodCiudad[6];        /* EXEC SQL VAR szhCodCiudad IS STRING(6) ; */ 

		short   ihIndFactur;
		short   ihIndSuperTel;
		int     ihCodPortador;
    /* EXEC SQL END DECLARE SECTION; */ 


	long lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	long lNumAbonado     = stDatosDobleCuenta[iInd].lCodAbonAsoc;
	long lCodConcepto    = stDatosDobleCuenta[iInd].lCodConcepto;

    vDTrazasLog  (modulo,"\n\t Parametros Entrada a bfnBuscaInfConceptoFacturado \n"
						 "\t\t Cod CiclFact [%ld]\n"
						 "\t\t Indice Reg.   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	memset(&stFaConcepto,0,sizeof(FACONCEPTO));

	if ( stDatosDobleCuenta[iInd].iTipModalidad == TF)
	{
		sprintf(szCadenaSQL," SELECT \n"
							"\t\t TO_CHAR(FEC_VALOR,'YYYYMMDDHH24MISS'), TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS'), \n"
							"\t\t COD_REGION, COD_PROVINCIA, COD_CIUDAD, \n"
							"\t\t IND_FACTUR,  IND_SUPERTEL, \n"
							"\t\t COD_PORTADOR \n"
							"\t FROM FA_FACTCONC_%ld \n"
							"\t WHERE IND_ORDENTOTAL = %ld \n"
							"\t\t AND NUM_ABONADO = %ld	\n"
							"\t\t AND ROWNUM=1 \n",
							lCodCicloFact,
							lIndOrdenTotal, lNumAbonado, lCodConcepto);
	}
	else
	{
		sprintf(szCadenaSQL," SELECT \n"
							"\t\t TO_CHAR(FEC_VALOR,'YYYYMMDDHH24MISS'), TO_CHAR(FEC_EFECTIVIDAD,'YYYYMMDDHH24MISS'), \n"
							"\t\t COD_REGION, COD_PROVINCIA, COD_CIUDAD, \n"
							"\t\t IND_FACTUR,  IND_SUPERTEL, \n"
							"\t\t COD_PORTADOR \n"
							"\t FROM FA_FACTCONC_%ld \n"
							"\t WHERE IND_ORDENTOTAL = %ld \n"
							"\t\t AND NUM_ABONADO = %ld	\n"
							"\t\t AND COD_CONCEPTO = %ld \n",
							lCodCicloFact,
							lIndOrdenTotal, lNumAbonado, lCodConcepto);
	}

	vDTrazasLog ( modulo,"\n\t** Query for cCursor_Inf_Concepto_Fact \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )465;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )2048;
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



	if (SQLCODE) {
		vDTrazasError  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
					   "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo,"<< Fallo en 'PREPARE' de la Query Dinamica >>"
					   "\n\t[%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE cCursor_Inf_Concepto_Fact CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Inf_Concepto_Fact >>"
							 "\n\t[%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo,"<< Fallo en 'DECLARE' del Cursor  cCursor_Inf_Concepto_Fact >>"
							 "\n\t[%d]",LOG01,SQLCODE);
	    return (SQLCODE);
	}


    /* EXEC SQL OPEN cCursor_Inf_Concepto_Fact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )484;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (modulo," ** No Existen Datos en cCursor_Inf_Concepto_Fact **",LOG01);
        vDTrazasError(modulo," ** No Existen Datos en cCursor_Inf_Concepto_Fact **",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en Open cCursor_Inf_Concepto_Fact **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en Open cCursor_Inf_Concepto_Fact **"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (SQLCODE);
    }

    /* EXEC SQL FETCH cCursor_Inf_Concepto_Fact INTO
			:szhFecValor, :szhFecEfectividad,
			:szhCodRegion, :szhCodProvincia, :szhCodCiudad,
			:ihIndFactur, :ihIndSuperTel,
			:ihCodPortador; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )499;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)szhFecValor;
    sqlstm.sqhstl[0] = (unsigned long )15;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)szhFecEfectividad;
    sqlstm.sqhstl[1] = (unsigned long )15;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodRegion;
    sqlstm.sqhstl[2] = (unsigned long )4;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodProvincia;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodCiudad;
    sqlstm.sqhstl[4] = (unsigned long )6;
    sqlstm.sqhsts[4] = (         int  )0;
    sqlstm.sqindv[4] = (         short *)0;
    sqlstm.sqinds[4] = (         int  )0;
    sqlstm.sqharm[4] = (unsigned long )0;
    sqlstm.sqadto[4] = (unsigned short )0;
    sqlstm.sqtdso[4] = (unsigned short )0;
    sqlstm.sqhstv[5] = (unsigned char  *)&ihIndFactur;
    sqlstm.sqhstl[5] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[5] = (         int  )0;
    sqlstm.sqindv[5] = (         short *)0;
    sqlstm.sqinds[5] = (         int  )0;
    sqlstm.sqharm[5] = (unsigned long )0;
    sqlstm.sqadto[5] = (unsigned short )0;
    sqlstm.sqtdso[5] = (unsigned short )0;
    sqlstm.sqhstv[6] = (unsigned char  *)&ihIndSuperTel;
    sqlstm.sqhstl[6] = (unsigned long )sizeof(short);
    sqlstm.sqhsts[6] = (         int  )0;
    sqlstm.sqindv[6] = (         short *)0;
    sqlstm.sqinds[6] = (         int  )0;
    sqlstm.sqharm[6] = (unsigned long )0;
    sqlstm.sqadto[6] = (unsigned short )0;
    sqlstm.sqtdso[6] = (unsigned short )0;
    sqlstm.sqhstv[7] = (unsigned char  *)&ihCodPortador;
    sqlstm.sqhstl[7] = (unsigned long )sizeof(int);
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
}



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en Fecth Cursor cCursor_Inf_Concepto_Fact %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en Fecth Cursor cCursor_Inf_Concepto_Fact %s ",LOG01,SQLERRM);
    }

    /* EXEC SQL CLOSE cCursor_Inf_Concepto_Fact; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )546;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en Close de Cursor cCursor_Inf_Concepto_Fact : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en Close de Cursor cCursor_Inf_Concepto_Fact : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	/*** Se agregan los datos obtenidos a la estructura stFaConcepto  ***/

		strcpy(stFaConcepto.szFecValor,szhFecValor);
		strcpy(stFaConcepto.szFecEfectividad,szhFecEfectividad);
		strcpy(stFaConcepto.szCodRegion,szhCodRegion);
		strcpy(stFaConcepto.szCodProvincia,szhCodProvincia);
		strcpy(stFaConcepto.szCodCiudad,szhCodCiudad);
		stFaConcepto.iIndFactur = ihIndFactur;
		stFaConcepto.iIndSuperTel = ihIndSuperTel;
		stFaConcepto.iCodPortador = ihCodPortador;

	/*** ***/

    return (TRUE);

}/************************* Fin bfnBuscaInfConceptoFacturado *************************/


BOOL bfnGetImpFactuConceptoAbon(long lCodCicloFact, int	iInd)
{
    char modulo[]   = "bfnGetImpFactuConceptoAbon";

	static char szCadenaSQL[2048];

	long	lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	long	lNumAbonado     = stDatosDobleCuenta[iInd].lCodAbonAsoc;
	long 	lCodConcepto    = stDatosDobleCuenta[iInd].lCodConcepto;
	double	dImpFactConcep;

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        double dhTotaCargos   = 0.0;
        double dhTotalDescImp = 0.0;
        double dhTotalImpDesc = 0.0;
    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog  (modulo,"\n\t Parametros Entrada a bfnGetImpFactuConceptoAbon\n"
						 "\t\t Cod_CiclFact [%ld]\n"
						 "\t\t Indice Reg.   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	/*** Declara Query  busca Importe Facturado por Concepto ***/

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t SELECT\n"
					"\t\t (SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
					"\t\t	FROM FA_FACTCONC_%ld \n"
					"\t\t	WHERE IND_ORDENTOTAL = %ld \n"
					"\t\t		AND NUM_ABONADO    = %ld \n"
					"\t\t   		AND COD_CONCEPTO   = %ld \n"
					"\t\t   		AND COD_TIPCONCE IN (3,4)) CARGOS, \n"
					"\t\t(SELECT NVL(SUM(IMP_CONCEPTO),0) \n"
					"\t\t	FROM FA_FACTCONC_%ld \n"
					"\t\t	WHERE IND_ORDENTOTAL = %ld \n"
					"\t\t	   	AND NUM_ABONADO    = %ld \n"
					"\t\t		AND COD_CONCEREL   = %ld \n"
					"\t\t		AND COD_TIPCONCE IN(1,2)) IMPTOS_Y_DCTOS, \n"
					"\t\t(SELECT NVL(SUM(B.IMP_CONCEPTO),0)\n"
					"\t\t	   FROM FA_FACTCONC_%ld A, FA_FACTCONC_%ld B \n"
					"\t\t	   WHERE A.IND_ORDENTOTAL = %ld \n"
					"\t\t	   		 AND A.NUM_ABONADO    = %ld \n"
					"\t\t			 AND A.COD_CONCEREL   = %ld \n"
					"\t\t			 AND A.COD_TIPCONCE   = 2 \n"
					"\t\t			 AND B.COD_CONCEREL   = A.COD_CONCEPTO \n"
					"\t\t			 AND B.IND_ORDENTOTAL = A.IND_ORDENTOTAL \n"
					"\t\t			 AND B.NUM_ABONADO    = A.NUM_ABONADO \n"
					"\t\t			 AND B.COD_TIPCONCE   = 1)IMPUESTO_DE_DESCUENTOS \n"
					"\t\tFROM DUAL \n",
					lCodCicloFact, lIndOrdenTotal, lNumAbonado, lCodConcepto,
					lCodCicloFact, lIndOrdenTotal, lNumAbonado, lCodConcepto,
					lCodCicloFact, lCodCicloFact, lIndOrdenTotal, lNumAbonado, lCodConcepto);


	vDTrazasLog ( modulo,"\n\t** Query for cCursor_Importe_Concepto \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE stQueryDinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )561;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )2048;
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



	if (SQLCODE) {
		vDTrazasError(modulo," en PREPARE de la Query Dinamica [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasLog  (modulo," en PREPARE de la Query Dinamica [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
	    return (SQLCODE);
	}

	/* EXEC SQL DECLARE cCursor_Importe_Concepto CURSOR FOR stQueryDinamica; */ 


	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_Importe_Concepto [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Importe_Concepto [%d]",LOG01,SQLCODE);
	    return (SQLCODE);
	}

    /* EXEC SQL OPEN cCursor_Importe_Concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )580;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqcmod = (unsigned int )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasError(modulo," en OPEN cCursor_Importe_Concepto  Existen Datos",LOG01);
        vDTrazasLog  (modulo," en OPEN cCursor_Importe_Concepto  Existen Datos",LOG01);
        return (SQLCODE);
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en OPEN cCursor_Importe_Concepto [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_Importe_Concepto [%s]",LOG01,SQLERRM);
        return (SQLCODE);
    }

    /* EXEC SQL FETCH cCursor_Importe_Concepto INTO
			:dhTotaCargos,
			:dhTotalDescImp,
			:dhTotalImpDesc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )595;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqfoff = (         int )0;
    sqlstm.sqfmod = (unsigned int )2;
    sqlstm.sqhstv[0] = (unsigned char  *)&dhTotaCargos;
    sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
    sqlstm.sqinds[0] = (         int  )0;
    sqlstm.sqharm[0] = (unsigned long )0;
    sqlstm.sqadto[0] = (unsigned short )0;
    sqlstm.sqtdso[0] = (unsigned short )0;
    sqlstm.sqhstv[1] = (unsigned char  *)&dhTotalDescImp;
    sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)&dhTotalImpDesc;
    sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
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



    if( SQLCODE != SQLNOTFOUND && SQLCODE != SQLOK)
    {
        vDTrazasError(modulo," en FECTH cCursor_Importe_Concepto [%s] ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en FECTH cCursor_Importe_Concepto [%s] ",LOG01,SQLERRM);
    }

    if( SQLCODE == SQLOK )
		stDatosDobleCuenta[iInd].lImpFactConcep = dhTotaCargos + dhTotalDescImp + dhTotalImpDesc;

    /* EXEC SQL CLOSE cCursor_Importe_Concepto; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )622;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en CLOSE cCursor_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en CLOSE cCursor_Importe_Concepto [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	vDTrazasLog  (modulo,"\n\t Valores obtenidos por Cargos, Impuestos : \n"
						"\t\t Tot Cargo       [%.4f] \n"
						"\t\t Tot Imp y Desc  [%.4f] \n"
						"\t\t Tot Imp de Desc [%.4f] \n",
						LOG05,
						dhTotaCargos, dhTotalDescImp, dhTotalImpDesc);

    return (TRUE);

}/************************* Fin bfnGetImpFactuConceptoAbon **********************/


BOOL bfnAplicaCargosFactDif(int iTipConcepto, /*** 2 = DESCUENTO, 3 = CARGO ***/
						double dImpFacturable,
						long lCodCicloFact,
						int iInd)
{
    char modulo[]   = "bfnAplicaCargosFactDif";

	long lColumna = 0;

	vDTrazasLog  (modulo,"\n\t Parametros de Entrada a bfnAplicaCargosFactDif\n"
						 "\t\t Cod CiclFact     [%ld]\n"
						 "\t\t Dif Imp Concepto [%.2f]\n"
						 "\t\t Tipo concepto    [%d]\n"
						 "\t\t Indice Reg.      [%d]\n",
						 LOG03,
						 lCodCicloFact, dImpFacturable, iTipConcepto, iInd);

	stFaConcepto.iCodTipConce = iTipConcepto; /*** TEMPORAL ***/

	stFaConcepto.iCodConceRel=0;

	stFaConcepto.iFlagImpues =0;

	if (iTipConcepto == 2)
	{
		/*** Se agrega el Descuento al Cliente Contratante ***/
		sprintf(stFaConcepto.szIndOrdenTotal,"%ld",stDatosDobleCuenta[iInd].lIndOrdenTotal);
		stFaConcepto.lCodConcepto   = stDatosDobleCuenta[iInd].lCodConcDesc;
		stFaConcepto.lNumAbonado    = stDatosDobleCuenta[iInd].lCodAbonAsoc;
		stFaConcepto.dImpFacturable = dImpFacturable * -1;

		stFaConcepto.dImpConcepto = stFaConcepto.dImpFacturable;
		stFaConcepto.dImpFacturable = fnCnvDouble(stFaConcepto.dImpFacturable,1); /* --> Tiene q ser a 2 decimales :1 = USOFACT */
		stFaConcepto.iCodConceRel   = stDatosDobleCuenta[iInd].lCodConcepto;
		stFaConcepto.lColumnaRel    = stDatosDobleCuenta[iInd].lColumna;

		if ((dMaxImpFacturable *-1) < (stFaConcepto.dImpFacturable*-1))
		{
			dMaxImpFacturable = stFaConcepto.dImpFacturable;
			lGCodConceRel			= stFaConcepto.iCodConceRel;
			lGCodColumnaRel		= stFaConcepto.lColumnaRel;
		}
		vDTrazasLog ( modulo,"\n\t Se Aplica Descuento al Cliente Contratante", LOG03);
	}
	else
	{
		/*** Se agrega el Cargo al Cliente Asociado ***/
		sprintf(stFaConcepto.szIndOrdenTotal,"%ld",stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc);
		stFaConcepto.lCodConcepto   = stDatosDobleCuenta[iInd].lCodConcDest;
		stFaConcepto.lNumAbonado    = 0L;
		stFaConcepto.dImpFacturable = dImpFacturable;
		stFaConcepto.dImpConcepto = stFaConcepto.dImpFacturable;

		stFaConcepto.dImpFacturable = stFaConcepto.dImpFacturable + (dMontoAjuste_Glob * -1);

		stFaConcepto.dImpFacturable = fnCnvDouble(stFaConcepto.dImpFacturable,1); /* --> Tiene q ser a 2 decimales :1 = USOFACT */
		vDTrazasLog ( modulo,"\n\t Se Aplica Cargo al Cliente Asociado",LOG03);
	} /*** FIN IF-ELSE ***/


	/*** Se obtiene la informacion del concepto a Aplicar ***/
	if(!bfnGetDetalleConcepto (stFaConcepto.lCodConcepto))
	{
        vDTrazasError  (modulo," en retorno de funcion  bfnGetDetalleConcepto ",LOG01);
        vDTrazasLog  (modulo," en retorno de funcion  bfnGetDetalleConcepto ",LOG01);
        return (FALSE);
	}

	/*** Se imprime Detalle Concepto si LOG05 ***/
	vfnPrintFaConcepto();

	/*** Se obtiene la columna del Concepto a aplicar ***/
	if(!bfnMaxColumnConcepto (lCodCicloFact, &lColumna))
	{
        vDTrazasError  (modulo," en retorno de funcion  bfnMaxColumnConcepto ",LOG01);
        vDTrazasLog  (modulo," en retorno de funcion  bfnMaxColumnConcepto ",LOG01);
        return (FALSE);
	}
	lColumna++;

	stFaConcepto.lColumna = lColumna;

	vDTrazasLog  (modulo," Se procede a Insertar el Descuento o Cargo -> bfnInsertaRegFactConc ",LOG03);

	/*** Se procede a Insertar el Descuento o Cargo ***/
	if(!bfnInsertaRegFactConc(lCodCicloFact))
	{
        vDTrazasError  (modulo," en retorno de funcion  bfnInsertaRegFactConc ",LOG01);
        vDTrazasLog  (modulo," en retorno de funcion  bfnInsertaRegFactConc ",LOG01);
        return (FALSE);
	}
	vDTrazasLog  (modulo,"Termino el INSERT del Descuento o Cargo -> bfnInsertaRegFactConc ",LOG03);

    return (TRUE);

}/************************* Fin bfnAplicaCargosFactDif *************************/

BOOL bfnInsertaRegFactConc (long lCodCicloFact)
{
	char modulo[]   = "bfnInsertaRegFactConc";

	static char szCadenaSQL[2048];

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t INSERT INTO	FA_FACTCONC_%ld \n"
		"\t (IND_ORDENTOTAL, COD_CONCEPTO, COLUMNA, COD_MONEDA,  \n"
    	"\t COD_PRODUCTO, COD_TIPCONCE, FEC_VALOR, FEC_EFECTIVIDAD,  \n"
    	"\t IMP_CONCEPTO, COD_REGION, COD_PROVINCIA, COD_CIUDAD,  \n"
    	"\t IMP_MONTOBASE, IND_FACTUR, IMP_FACTURABLE, IND_SUPERTEL,  \n"
    	"\t NUM_ABONADO, COD_PORTADOR, DES_CONCEPTO, SEG_CONSUMIDO,  \n"
    	"\t NUM_CUOTAS, ORD_CUOTA, NUM_UNIDADES, NUM_SERIEMEC,  \n"
    	"\t NUM_SERIELE, PRC_IMPUESTO, VAL_DTO, TIP_DTO,  \n"
    	"\t MES_GARANTIA, NUM_GUIA, IND_ALTA, NUM_PAQUETE,  \n"
    	"\t FLAG_IMPUES, FLAG_DTO, COD_CONCEREL, COLUMNA_REL,  \n"
    	"\t SEQ_CUOTAS, COD_PLANTARIF, COD_CARGOBASICO, TIP_PLANTARIF,  \n"
    	"\t IMP_DCTO, IMP_REAL, DUR_DCTO, DUR_REAL,  \n"
    	"\t CNT_LLAM_REAL, CNT_LLAM_DCTO, CNT_LLAM_FACT,  \n"
    	"\t IMP_VALUNITARIO, GLS_DESCRIP) \n"
		"\t VALUES \n"
		"\t (TO_NUMBER('%s'), %ld, %ld, '%s',  \n"
		"\t %d, %d, TO_DATE('%s','YYYYMMDDHH24MISS'), TO_DATE('%s','YYYYMMDDHH24MISS'),  \n"
		"\t %f, '%s', '%s', '%s',  \n"
		"\t %f, %d, %f, %d,  \n"
		"\t %ld, %d, '%s', %ld,  \n"
		"\t %d, %d, %ld, '%s',  \n"
		"\t '%s', %f, %f, %d,  \n"
		"\t %d, '%s', %d, %d,  \n"
		"\t %d, %d, %d, %ld,  \n"
		"\t %d, '%s', '%s', '%s',  \n"
		"\t %f, %f, %ld, %ld, \n"
		"\t %ld, %ld, %ld, \n"
		"\t %f, '%s') \n",
		lCodCicloFact,
		stFaConcepto.szIndOrdenTotal, stFaConcepto.lCodConcepto, stFaConcepto.lColumna, stFaConcepto.szCodMoneda,
		stFaConcepto.iCodProducto, stFaConcepto.iCodTipConce, stFaConcepto.szFecValor, stFaConcepto.szFecEfectividad,
		stFaConcepto.dImpConcepto, stFaConcepto.szCodRegion, stFaConcepto.szCodProvincia, stFaConcepto.szCodCiudad,
		stFaConcepto.dImpMontoBase, stFaConcepto.iIndFactur, stFaConcepto.dImpFacturable, stFaConcepto.iIndSuperTel,
		stFaConcepto.lNumAbonado, stFaConcepto.iCodPortador, stFaConcepto.szDesConcepto, stFaConcepto.lSegConsumido,
		stFaConcepto.iNumCuotas, stFaConcepto.iOrdCuota, stFaConcepto.lNumUnidades, stFaConcepto.szNumSerieMec,
		stFaConcepto.szNumSerieLe, stFaConcepto.fPrcImpuesto, stFaConcepto.dValDto, stFaConcepto.iTipDto,
		stFaConcepto.iMesGarantia, stFaConcepto.szNumGuia, stFaConcepto.iIndAlta, stFaConcepto.iNumPaquete,
		stFaConcepto.iFlagImpues, stFaConcepto.iFlagDto, stFaConcepto.iCodConceRel, stFaConcepto.lColumnaRel,
		stFaConcepto.lSeqCuotas, stFaConcepto.szCodPlanTarif, stFaConcepto.szCodCargoBasico, stFaConcepto.szTipPlanTarif,
		stFaConcepto.dMtoDcto, stFaConcepto.dMtoReal, stFaConcepto.lDurDcto, stFaConcepto.lDurReal,
		stFaConcepto.lCntLlamReal, stFaConcepto.lCntLlamDcto, stFaConcepto.lCntLlamFact,
    	stFaConcepto.dImpValunitario, stFaConcepto.szGlsDescrip);

	if(!bfnExecuteQuery(szCadenaSQL))
	{
	    vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
	    vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
		return (FALSE);
	}

	return (TRUE);

}/************************* Fin bfnAplicaCargosFactDif *************************/

BOOL bfnUpdateFactAbon(int iTipAbonado, double dImpFacturado, long lCodCicloFact, int iInd)
{
	char modulo[]   = "bfnUpdateFactAbon";

	long 	lNumAbonado;
	long	lIndOrdenTotal;
	double	dMasImporte;
	int	 	iAbonado0 = 0;

	IMPABONADO	stImpAbonado;

	static char szCadenaSQL[1024];

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		double	dhTotDescuentos=0.0;
  /* EXEC SQL END DECLARE SECTION; */ 


	memset(&stImpAbonado,0,sizeof(IMPABONADO));

	vDTrazasLog  (modulo,"\t Parametros entrada de bfnUpdateFactAbon\n"
						 "\t\t Tip Abonado    [%d]\n"
						 "\t\t Imp Facturado  [%.4f]\n"
						 "\t\t Cod Ciclo Fact [%ld]\n"
						 "\t\t Ind Registro   [%d]\n",
						 LOG03,
						 iTipAbonado,
						 dImpFacturado,
						 lCodCicloFact,
						 iInd);

	if(iTipAbonado == 0)
	{
		lNumAbonado = 0;
		lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc;

		vDTrazasLog   (modulo,"PGG - Cliente Asociado, se ajusta segun dMontoAjuste_Glob --> [%f] \n",LOG05, dMontoAjuste_Glob);
		vDTrazasLog   (modulo,"PGG - Ind_ordentotal del cliente asociado --> [%ld] \n",LOG05, lIndOrdenTotal);

		dMasImporte = dImpFacturado + (dMontoAjuste_Glob * -1);	

		vDTrazasLog   (modulo,"PGG - importe + (ajusteGlob *-1) --> [%f] \n",LOG05, dMasImporte);

		if(!bfnExisteAbonado0(lCodCicloFact, iInd, &iAbonado0))
		{
			vDTrazasError (modulo,"ERROR al validar FactAbon Abonado 0 ",LOG01);
			vDTrazasLog   (modulo,"ERROR al validar FactAbon Abonado 0 ",LOG01);
			return (FALSE);
		}

		if(iAbonado0 == 0)
		{
			if(!bfnInsertaAbonado0(lCodCicloFact, iInd, dMasImporte))
			{
				vDTrazasError (modulo,"ERROR al Insertar FactAbon Abonado 0 ",LOG01);
				vDTrazasLog   (modulo,"ERROR al Insertar FactAbon Abonado 0 ",LOG01);
				return (FALSE);
			}

			return (TRUE);
		}
	}
	else
	{
		lNumAbonado = stDatosDobleCuenta[iInd].lCodAbonAsoc;
		lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotal;
		/* PPV 74293 20/01/2009 Los descuentos se extraen de la FA_FACTCONC_*/
		sprintf(szCadenaSQL," SELECT SUM(IMP_FACTURABLE) \n"
												"\t FROM FA_FACTCONC_%ld \n"
												"\t WHERE IND_ORDENTOTAL = %ld \n"
												"\t AND NUM_ABONADO = %ld \n"
												"\t AND COD_TIPCONCE = 2 \n",
												lCodCicloFact,
												lIndOrdenTotal,
												lNumAbonado);

	  vDTrazasLog ( modulo,"\n\t Query for SQL CURSOR \n\t [%s]\n"
                          ,LOG05, alltrim(szCadenaSQL));

		/* EXEC SQL PREPARE sql_query_UpdateFactAbon FROM :szCadenaSQL; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.stmt = "";
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )637;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
  sqlstm.sqhstl[0] = (unsigned long )1024;
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


		if (SQLCODE)
 		{
	    vDTrazasError(modulo, " en PREPARE sql_query_UpdateFactAbon  [%s ]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en PREPARE sql_query_UpdateFactAbon  [%s ]",LOG01, SQLERRM);
	    return FALSE;
		}

		/* EXEC SQL DECLARE sql_Cursor_UpdateFactAbon CURSOR FOR sql_query_UpdateFactAbon; */ 

		if (SQLCODE) {
			vDTrazasError(modulo," en DECLARE del Cursor  sql_Cursor_UpdateFactAbon \n\t[%d]",LOG01,SQLCODE);
			vDTrazasLog  (modulo," en DECLARE del Cursor  sql_Cursor_UpdateFactAbon \n\t[%d]",LOG01,SQLCODE);
	    return FALSE;
		}

    /* EXEC SQL OPEN sql_Cursor_UpdateFactAbon; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )656;
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
    	vDTrazasError(modulo, " en OPEN sql_Cursor_UpdateFactAbon [%s]",LOG01,SQLERRM);
      vDTrazasLog  (modulo, " en OPEN sql_Cursor_UpdateFactAbon [%s]",LOG01,SQLERRM);
      return (FALSE);
    }
		/* EXEC SQL FETCH  sql_Cursor_UpdateFactAbon INTO :dhTotDescuentos; */ 

{
  struct sqlexd sqlstm;
  sqlstm.sqlvsn = 12;
  sqlstm.arrsiz = 13;
  sqlstm.sqladtp = &sqladt;
  sqlstm.sqltdsp = &sqltds;
  sqlstm.iters = (unsigned int  )1;
  sqlstm.offset = (unsigned int  )671;
  sqlstm.selerr = (unsigned short)1;
  sqlstm.cud = sqlcud0;
  sqlstm.sqlest = (unsigned char  *)&sqlca;
  sqlstm.sqlety = (unsigned short)256;
  sqlstm.occurs = (unsigned int  )0;
  sqlstm.sqfoff = (         int )0;
  sqlstm.sqfmod = (unsigned int )2;
  sqlstm.sqhstv[0] = (unsigned char  *)&dhTotDescuentos;
  sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
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



		vDTrazasLog  (modulo,"\t dhTotDescuentos[%f] \n" , LOG05, dhTotDescuentos);

    /* EXEC SQL CLOSE sql_Cursor_UpdateFactAbon; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )690;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( SQLCODE != SQLOK )
    {
      vDTrazasLog  (modulo," en CLOSE sql_Cursor_UpdateFactAbon : %d  %s **",LOG01,SQLCODE,SQLERRM);
      vDTrazasError(modulo," en CLOSE sql_Cursor_UpdateFactAbon  : %d  %s **",LOG01,SQLCODE,SQLERRM);
      return (FALSE);
    }
	  dMasImporte = dhTotDescuentos;
	  vDTrazasLog  (modulo,"\t dMasImporte[%f] \n" , LOG05, dMasImporte);
	}

	if(!bfnGetImpAbonado(lCodCicloFact, lNumAbonado, lIndOrdenTotal, &stImpAbonado))
	{
        vDTrazasError(modulo," en retorno de funcion  bfnGetImpAbonado ",LOG01);
        vDTrazasLog  (modulo," en retorno de funcion  bfnGetImpAbonado ",LOG01);
		return (FALSE);
	}

	if(iTipAbonado == 0)
	{
		stImpAbonado.dAcumCargo = stImpAbonado.dAcumCargo + dMasImporte;
		stImpAbonado.dTotCargosMe = stImpAbonado.dTotCargosMe + dMasImporte;  /* PPV 20/01/2009 74293 Aqui se modifica Total */
	}
	else
	{
		stImpAbonado.dTotCargosMe = stImpAbonado.dTotCargosMe - stImpAbonado.dAcumDto; /* Se le quita el descuento que trae */
		stImpAbonado.dAcumDto = dMasImporte;
		stImpAbonado.dTotCargosMe = stImpAbonado.dTotCargosMe + stImpAbonado.dAcumDto; /* Se le aplica el descuento calculado */
	}

	/*** Se procede a actualizar el registro del Abonado en la FA_FACTABON_ciclo ***/

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t  UPDATE FA_FACTABON_%ld \n"
						"\t  SET TOT_CARGOSME = %f ,\n"
						"\t\t ACUM_CARGO  = %f ,\n"
						"\t\t ACUM_DTO    = %f ,\n"
						"\t\t ACUM_IVA    = %f \n"
						"\t WHERE IND_ORDENTOTAL = %ld \n"
						"\t AND  NUM_ABONADO = %ld \n",
						lCodCicloFact,
						stImpAbonado.dTotCargosMe,
						stImpAbonado.dAcumCargo,
						stImpAbonado.dAcumDto,
						stImpAbonado.dAcumIva,
						lIndOrdenTotal,
						lNumAbonado);

	if(!bfnExecuteQuery(szCadenaSQL))
	{
	    vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
	    vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
		return (FALSE);
	}

	return (TRUE);

} /*** FIN bfnUpdateFactAbon ***/

BOOL bfnGetImpAbonado(long lCodCicloFact, long lNumAbonado, long lIndOrdenTotal, IMPABONADO *pImpA)
{
	char modulo[]   = "bfnGetImpAbonado";
	static char szCadenaSQL[1024];

	vDTrazasLog  (modulo,"\t Parametros entrada de bfnGetImpAbonado\n"
						 "\t\t Cod Ciclo Fact [%ld]\n"
						 "\t\t Num Abonado    [%ld]\n"
						 "\t\t Ind OrdenTotal [%ld]\n",
						 LOG03,
						 lCodCicloFact,
						 lNumAbonado,
						 lIndOrdenTotal);

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		double	dhTotCargosMe;
		double	dhAcumCargo;
		double	dhAcumDto;
		double	dhAcumIva;
    /* EXEC SQL END DECLARE SECTION; */ 


	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL," SELECT TOT_CARGOSME, ACUM_CARGO, ACUM_DTO, ACUM_IVA \n"
			"\t FROM FA_FACTABON_%ld \n"
			"\t WHERE IND_ORDENTOTAL = %ld \n"
			"\t AND NUM_ABONADO = %ld \n",
			lCodCicloFact,
			lIndOrdenTotal,
			lNumAbonado);

	vDTrazasLog ( modulo,"\n\t Query for SQL CURSOR \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_query_GetImpAbonado FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )705;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasError(modulo, " en PREPARE sql_query_GetImpAbonado  [%s ]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en PREPARE sql_query_GetImpAbonado  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE sql_Cursor_GetImpAbonado CURSOR FOR sql_query_GetImpAbonado; */ 

	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE del Cursor  sql_Cursor_GetImpAbonado \n\t[%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE del Cursor  sql_Cursor_GetImpAbonado \n\t[%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN sql_Cursor_GetImpAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )724;
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
        vDTrazasError(modulo, " en OPEN sql_Cursor_GetImpAbonado [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN sql_Cursor_GetImpAbonado [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
	/* EXEC SQL FETCH  sql_Cursor_GetImpAbonado INTO
		:dhTotCargosMe,
		:dhAcumCargo,
		:dhAcumDto,
		:dhAcumIva; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )739;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhTotCargosMe;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhAcumCargo;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&dhAcumDto;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&dhAcumIva;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    /* EXEC SQL CLOSE sql_Cursor_GetImpAbonado; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )770;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en CLOSE sql_Cursor_GetImpAbonado : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en CLOSE sql_Cursor_GetImpAbonado  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	pImpA->dTotCargosMe = dhTotCargosMe;
	pImpA->dAcumCargo   = dhAcumCargo;
	pImpA->dAcumDto     = dhAcumDto;
	pImpA->dAcumIva     = dhAcumIva;

	/*** Se imprimen los valores obtenidos, si LOG05 ***/
	vfnPrintImpAbonado(pImpA);

	return (TRUE);

}/************************* Fin bfnGetImpAbonado *************************/

BOOL bfnExisteAbonado0(long lCodCicloFact, int iInd, int *iExistAbon0)
{
	char modulo[]   = "bfnExisteAbonado0";
	static char szCadenaSQL[1024];

	long	lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc;
	long	lNumAbonado    = 0;

	vDTrazasLog  (modulo,"\t Parametros entrada de bfnExisteAbonado0\n"
						 "\t\t Cod Ciclo Fact [%ld]\n"
						 "\t\t Ind Registro   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		int		ihCountAbon0;
    /* EXEC SQL END DECLARE SECTION; */ 


	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL," SELECT count(1) \n"
			"\t FROM FA_FACTABON_%ld \n"
			"\t WHERE IND_ORDENTOTAL = %ld \n"
			"\t AND NUM_ABONADO = %ld \n",
			lCodCicloFact,
			lIndOrdenTotal,
			lNumAbonado);

	vDTrazasLog ( modulo,"\n\t Query for SQL CURSOR \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_query_ExisteAbonado0 FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )785;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasError(modulo, " en PREPARE sql_query_ExisteAbonado0  [%s ]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en PREPARE sql_query_ExisteAbonado0  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE sql_Cursor_ExisteAbonado0 CURSOR FOR sql_query_ExisteAbonado0; */ 

	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE del Cursor  sql_Cursor_ExisteAbonado0 \n\t[%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE del Cursor  sql_Cursor_ExisteAbonado0 \n\t[%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN sql_Cursor_ExisteAbonado0; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )804;
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
        vDTrazasError(modulo, " en OPEN sql_Cursor_ExisteAbonado0 [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN sql_Cursor_ExisteAbonado0 [%s]",LOG01,SQLERRM);
        return (FALSE);
    }
	/* EXEC SQL FETCH  sql_Cursor_ExisteAbonado0 INTO
		:ihCountAbon0; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )819;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCountAbon0;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
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



    /* EXEC SQL CLOSE sql_Cursor_ExisteAbonado0; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )838;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en CLOSE sql_Cursor_ExisteAbonado0 : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en CLOSE sql_Cursor_ExisteAbonado0  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	*iExistAbon0 = ihCountAbon0;

	return (TRUE);

} /*** FIN bfnExisteAbonado0 ***/

BOOL bfnInsertaAbonado0(long lCodCicloFact, int iInd, double dImpFacturado)
{
	char modulo[]   = "bfnInsertaAbonado0";
	static char szCadenaSQL[1024];

	long	lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc;
	long	lNumAbonado    = 0;

	vDTrazasLog  (modulo,"\t Parametros entrada de bfnInsertaAbonado0\n"
						 "\t\t Cod Ciclo Fact [%ld]\n"
						 "\t\t Ind Registro   [%d]\n"
						 "\t\t Imp Facturado  [%.4f]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd,
						 dImpFacturado);

	memset(&stCliente,0,sizeof(CLIENTE));
	stCliente.lCodCliente = stDatosDobleCuenta[iInd].lCodCliAsoc;

	if (!bfnGetDatosCliente(stCliente.lCodCliente))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnGetDatosCliente",LOG01);
		vDTrazasLog  (modulo," en  retorno Funcion bfnGetDatosCliente",LOG01);
		return (FALSE);
	}

	if(!bfnInsertClieAsocFactAbon(lCodCicloFact, iInd, dImpFacturado))
	{
		vDTrazasError(modulo," en Funcion bfnInsertClieAsocFactAbon", LOG01);
   	    vDTrazasLog  (modulo," en Funcion bfnInsertClieAsocFactAbon", LOG01);
		return (FALSE);
	}

	return (TRUE);

}/************************* Fin bfnInsertaAbonado0 *************************/

BOOL bfnBuscaFacturaCliAsoc (long lCodCicloFact, int iInd)
{
	char modulo[]   = "bfnBuscaFacturaCliAsoc";

	static char szCadenaSQL[1024];

	vDTrazasLog  (modulo,"\t Parametros entrada de bfnBuscaFacturaCliAsoc\n"
						 "\t\t Cod Ciclo Fact [%ld]\n"
						 "\t\t Ind Registro   [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long		lhIndOrdenTotal;
		static short	i_hIndOrdenTotal;
    /* EXEC SQL END DECLARE SECTION; */ 


	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL," SELECT IND_ORDENTOTAL \n"
			"\t FROM FA_FACTCLIE_%ld \n"
			"\t WHERE COD_CLIENTE = %ld \n",
			lCodCicloFact,
			stDatosDobleCuenta[iInd].lCodCliAsoc);

	vDTrazasLog ( modulo,"\n\t** Query for sql_select_IndOrdenTotal \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_select_IndOrdenTotal FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )853;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasError(modulo, " en PREPARE sql_select_IndOrdenTotal  [%s ]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en PREPARE sql_select_IndOrdenTotal  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE cCursor_Get_IndOrdenTotalAsoc CURSOR FOR sql_select_IndOrdenTotal; */ 

	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_Get_IndOrdenTotalAsoc [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Get_IndOrdenTotalAsoc [%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN cCursor_Get_IndOrdenTotalAsoc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )872;
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
        vDTrazasError(modulo, " en OPEN cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }

	/* EXEC SQL FETCH cCursor_Get_IndOrdenTotalAsoc INTO :lhIndOrdenTotal; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )887;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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



    if( SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog  (modulo,"\t Cliente Asociado [%ld] No ha sido Facturado para este ciclo",
                            LOG03,stDatosDobleCuenta[iInd].lCodCliAsoc);

        /*** Aca se genera la factura del cliente asociado ***/

        if(!bfnFacturaCliAsoc(lCodCicloFact, iInd))
        {
            vDTrazasError(modulo, " en retorno funcion bfnFacturaCliAsoc [%s] **",LOG01,SQLERRM);
            vDTrazasLog  (modulo, " en retorno funcion bfnFacturaCliAsoc [%s] **",LOG01,SQLERRM);
            return (FALSE);
        }
    }
    else if(SQLCODE == SQLOK)
    {
        stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc = lhIndOrdenTotal;
        vDTrazasLog  (modulo,"\t Cliente Asociado [%ld] Ha sido Facturado para este ciclo \n"
                            "\t\t Ind OrdenTotal [%ld] \n",
                            LOG03,
                            stDatosDobleCuenta[iInd].lCodCliAsoc,
                            stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc);

				if (!bfnVerficaEstadoClie(stFecProceso.lNumProceso, stDatosDobleCuenta[iInd].lCodCliAsoc, 0))
				{
					vDTrazasError(modulo, "\n\t\t* Error en Obtencion de datos de FA_CICLOCLI \n", LOG01);
					vDTrazasLog  (modulo, "\n\t\t* Error en Obtencion de datos de FA_CICLOCLI \n", LOG01);
					return FALSE;
				}
                            
    }
    else
    {
        vDTrazasError(modulo, " en FETCH cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en FETCH cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }

    /* EXEC SQL CLOSE cCursor_Get_IndOrdenTotalAsoc; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )906;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if(SQLCODE != SQLOK)
    {
        vDTrazasError(modulo, " en CLOSE cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en CLOSE cCursor_Get_IndOrdenTotalAsoc [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }

    vDTrazasLog (modulo,"\t Ind. Orden Total del Cliente Asociado [%ld]",
                        LOG03,stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc);

	return TRUE;

}/************************* Fin bfnBuscaFacturaCliAsoc *************************/


BOOL bfnRecalculaDocuCicloCli (int iTipoCli, long lCodCicloFact, int iInd)
{
	char modulo[]   = "bfnRecalculaDocuCicloCli";

	long lIndOrdenTotal;
	char szCodOficina[2];   
	char szCodOperadora[5]; 
	char szPrefPlaza[10];   

	if (iTipoCli == 0)
		lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	else
		lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc;

	static char szCadenaSQL[1024];

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		double	dhAcumIva;
		double	dhAcumNetoGrav;
		double	dhAcumNetoNoGrav;
		double	dhTotCargosMe;
		double	dhTotDescuento;
		double	dhTotFactura;
		double	dhTotPagar;
		double	dhImpSaldoAnt;
		long    lhCodTipdocum;
		long    lhNumFolio;   
		char    szhCodOficina[2];   /* EXEC SQL VAR szhCodOficina IS STRING(2); */ 
  
		char    szhCodOperadora[5]; /* EXEC SQL VAR szhCodOperadora IS STRING(5); */ 

		char    szhPrefPlaza[10];   /* EXEC SQL VAR szhPrefPlaza IS STRING(10); */ 
  
		char    szhResultado [256] ; /* EXEC SQL VAR szhResultado IS STRING (256); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog  (modulo,"\n\t Parametros entrada bfnRecalculaDocuCicloCli \n"
						 "\t\t Cod Ciclo Fact   [%ld]\n"
						 "\t\t Ind Orden Total  [%ld]\n"
						 "\t\t Ind Registro     [%d]\n",
						 LOG03,
						 lCodCicloFact,
						 lIndOrdenTotal,
						 iInd);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

        sprintf(szCadenaSQL,"\t SELECT \n"
						"\t\t SUM ( DECODE ( COD_TIPCONCE, 1, IMP_FACTURABLE, 0)) ACUM_IVA,   \n"
						"\t\t SUM ( DECODE ( COD_TIPCONCE, 2, IMP_FACTURABLE, 0)) ACUM_DTO, \n"
						"\t\t SUM ( DECODE ( COD_TIPCONCE, 3, DECODE(FLAG_IMPUES, 1, IMP_FACTURABLE,0), 0)) + SUM ( DECODE ( COD_TIPCONCE, 4, DECODE(FLAG_IMPUES, 1, IMP_FACTURABLE, 0), 0)) ACUM_NETOGRAV, \n"	/* PGG SOPORTE - 1-09-2008 - 69933 + 70533 - 3-11-2008 */
						"\t\t SUM ( DECODE ( COD_TIPCONCE, 3, DECODE(FLAG_IMPUES, 0, IMP_FACTURABLE,0), 0)) + SUM ( DECODE ( COD_TIPCONCE, 4, DECODE(FLAG_IMPUES, 0, IMP_FACTURABLE, 0), 0)) ACUM_NETONOGRAV \n"/* PGG SOPORTE - 1-09-2008 - 69933 + 70533 - 3-11-2008 */
						"\t\t FROM FA_FACTCONC_%ld \n"
						"\t\t WHERE IND_ORDENTOTAL = %ld \n",
						lCodCicloFact, lIndOrdenTotal);



	vDTrazasLog ( modulo,"\n\t** Query for sql_Recalc_FactDocuCli [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_Recalc_FactDocuCli FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )921;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasError(modulo, " en  PREPARE sql_Recalc_FactDocuCli  [%s ]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en  PREPARE sql_Recalc_FactDocuCli  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE cCursor_Recalc_FactDocuCli CURSOR FOR sql_Recalc_FactDocuCli; */ 

	if (SQLCODE)
	{
		vDTrazasError(modulo," en DECLARE cCursor_Recalc_FactDocuCli [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Recalc_FactDocuCli [%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN cCursor_Recalc_FactDocuCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )940;
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
        vDTrazasError(modulo, " en OPEN cCursor_Recalc_FactDocuCli [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_Recalc_FactDocuCli [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }

	/* EXEC SQL FETCH cCursor_Recalc_FactDocuCli INTO
         :dhAcumIva,
         :dhTotDescuento,
         :dhAcumNetoGrav,
         :dhAcumNetoNoGrav; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )955;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&dhAcumIva;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhTotDescuento;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&dhAcumNetoGrav;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)&dhAcumNetoNoGrav;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en FECTH cCursor_Recalc_FactDocuCli [%s] ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en FECTH cCursor_Recalc_FactDocuCli [%s] ",LOG01,SQLERRM);
		return (FALSE);
    }

	/* EXEC SQL CLOSE cCursor_Recalc_FactDocuCli; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )986;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    vDTrazasLog  (modulo,"\n\t (DEBUG) Importes obtenidos FA_FACTDOCU_%ld : \n"
						"\t\t Acum Iva        [%.4f] \n"
						"\t\t Tot Descuento   [%.4f] \n"
						"\t\t Acum NetoGrav   [%.4f] \n"
						"\t\t Acum NetoNoGrav [%.4f] \n",
						LOG05,
						lCodCicloFact,
						dhAcumIva,
						dhTotDescuento,
						dhAcumNetoGrav,
						dhAcumNetoNoGrav);

	/***
	Se obtienen valores desde FA_FACTDOCU_ciclo, para posteriromente actualizarlos
	***/

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t SELECT NVL(COD_TIPDOCUM,0), NVL(IMP_SALDOANT,0), NVL(NUM_FOLIO,0), NVL(COD_OFICINA,' '), NVL(COD_OPERADORA, ' '), NVL(PREF_PLAZA,' ')  \n"
						"\t\t FROM FA_FACTDOCU_%ld \n"
						"\t\t WHERE IND_ORDENTOTAL = %ld \n",
						lCodCicloFact, lIndOrdenTotal);

	vDTrazasLog ( modulo,"\n\t** Query for sql_Consulta_FactDocuCli [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_Consulta_FactDocuCli FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1001;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasLog  (modulo, " en PREPARE sql_Consulta_FactDocuCli  [%s ]",LOG01, SQLERRM);
	    vDTrazasError(modulo, " en PREPARE sql_Consulta_FactDocuCli  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE cCursor_Consulta_FactDocuCli CURSOR FOR sql_Consulta_FactDocuCli; */ 

	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE cCursor_Consulta_FactDocuCli [%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE cCursor_Consulta_FactDocuCli [%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN cCursor_Consulta_FactDocuCli; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1020;
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
        vDTrazasError(modulo, " en OPEN cCursor_Consulta_FactDocuCli [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN cCursor_Consulta_FactDocuCli [%s]",LOG01,SQLERRM);
        return (FALSE);
    }

	/* EXEC SQL FETCH cCursor_Consulta_FactDocuCli INTO :lhCodTipdocum, :dhImpSaldoAnt, :lhNumFolio, :szhCodOficina, :szhCodOperadora, :szhPrefPlaza; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1035;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodTipdocum;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&dhImpSaldoAnt;
 sqlstm.sqhstl[1] = (unsigned long )sizeof(double);
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&lhNumFolio;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodOficina;
 sqlstm.sqhstl[3] = (unsigned long )2;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhCodOperadora;
 sqlstm.sqhstl[4] = (unsigned long )5;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhPrefPlaza;
 sqlstm.sqhstl[5] = (unsigned long )10;
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
}



    if( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en FECTH Cursor cCursor_Consulta_FactDocuCli %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en FECTH Cursor cCursor_Consulta_FactDocuCli %s ",LOG01,SQLERRM);

		return (FALSE);
    }

	vDTrazasLog  (modulo,"\n\t szhCodOficina[%s] szhCodOperadora[%s] szhPrefPlaza[%s]",LOG03,szhCodOficina,szhCodOperadora,szhPrefPlaza);

	strcpy(szCodOficina,szhCodOficina);     
	strcpy(szCodOperadora,szhCodOperadora); 
	strcpy(szPrefPlaza,szhPrefPlaza);       

	/* EXEC SQL CLOSE cCursor_Consulta_FactDocuCli; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1074;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if( SQLCODE != SQLOK )
    {
        vDTrazasError(modulo," en CLOSE Cursor cCursor_Consulta_FactDocuCli %s ",LOG01,SQLERRM);
        vDTrazasLog  (modulo," en CLOSE Cursor cCursor_Consulta_FactDocuCli %s ",LOG01,SQLERRM);

		return (FALSE);
    }

    vDTrazasLog  (modulo,"\n\t dhImpSaldoAnt [%.4f] lhCodTipdocum [%ld] lhNumFolio [%ld] shCodOficina[%s] shCodOperadora[%s] shPrefPlaza[%s]",LOG05,dhImpSaldoAnt,lhCodTipdocum,lhNumFolio,szCodOficina,szCodOperadora,szPrefPlaza);

	/***
	Se Actualizan valores de FA_FACTDOCU_ciclo, para el IND_ORDENTOTAL
	***/
	
	dhTotFactura = dhAcumIva + dhAcumNetoGrav + dhAcumNetoNoGrav + dhTotDescuento;
	dhTotCargosMe = dhTotFactura;
	dhTotPagar = dhTotFactura + dhImpSaldoAnt;

    vDTrazasLog  (modulo,"\n\t (DEBUG) Totales a insertar en la Fa_FACTDOCU_%ld \n"
    					"\t\t cod_tipdocumen [%d] \n"
    					"\t\t Tot Descuento	[%.4f] \n"
    					"\t\t Tot Factura	[%.4f] \n"
    					"\t\t Tot Pagar  	[%.4f] \n",
						LOG05,
						lCodCicloFact,
						stProceso.iCodTipDocum,
						dhTotDescuento,
						dhTotFactura,
						dhTotPagar);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));


	if (iTipoCli == 0)
		sprintf(szCadenaSQL,"\t  UPDATE FA_FACTDOCU_%ld \n"
				"\t  SET TOT_DESCUENTO = %f ,\n"
				"\t\t ACUM_NETOGRAV    = %f ,\n"
				"\t\t ACUM_NETONOGRAV  = %f ,\n"
				"\t\t TOT_FACTURA      = %f ,\n"
				"\t\t TOT_CARGOSME     = %f ,\n"
				"\t\t TOT_PAGAR        = %f \n"
				"\t WHERE IND_ORDENTOTAL = %ld \n",
				lCodCicloFact,
			  dhTotDescuento,
				dhAcumNetoGrav + dhTotDescuento, 
				dhAcumNetoNoGrav,
				dhTotFactura, 
				dhTotCargosMe, 
				dhTotPagar,
				lIndOrdenTotal);

	else
  {
  	/* Aqui si el tipo de documento origen es 72 se debe cambiara a 2 y  eliminar el folio y se anula en folio anterior */
  	if (lhCodTipdocum==72)
  	{
  	   /* EXEC SQL
                SELECT FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(:lhCodTipdocum,
                                                         NULL,
                                                         :szCodOficina,
                                                         :szCodOperadora,
                                                         :szPrefPlaza,
                                                         :lhNumFolio)
                INTO :szhResultado
                FROM DUAL; */ 

{
      struct sqlexd sqlstm;
      sqlstm.sqlvsn = 12;
      sqlstm.arrsiz = 13;
      sqlstm.sqladtp = &sqladt;
      sqlstm.sqltdsp = &sqltds;
      sqlstm.stmt = "select FA_FOLIACION_PG.FA_ANULA_FOLIO_FN(:b0,null ,:b1,\
:b2,:b3,:b4) into :b5  from DUAL ";
      sqlstm.iters = (unsigned int  )1;
      sqlstm.offset = (unsigned int  )1089;
      sqlstm.selerr = (unsigned short)1;
      sqlstm.cud = sqlcud0;
      sqlstm.sqlest = (unsigned char  *)&sqlca;
      sqlstm.sqlety = (unsigned short)256;
      sqlstm.occurs = (unsigned int  )0;
      sqlstm.sqhstv[0] = (unsigned char  *)&lhCodTipdocum;
      sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[0] = (         int  )0;
      sqlstm.sqindv[0] = (         short *)0;
      sqlstm.sqinds[0] = (         int  )0;
      sqlstm.sqharm[0] = (unsigned long )0;
      sqlstm.sqadto[0] = (unsigned short )0;
      sqlstm.sqtdso[0] = (unsigned short )0;
      sqlstm.sqhstv[1] = (unsigned char  *)szCodOficina;
      sqlstm.sqhstl[1] = (unsigned long )2;
      sqlstm.sqhsts[1] = (         int  )0;
      sqlstm.sqindv[1] = (         short *)0;
      sqlstm.sqinds[1] = (         int  )0;
      sqlstm.sqharm[1] = (unsigned long )0;
      sqlstm.sqadto[1] = (unsigned short )0;
      sqlstm.sqtdso[1] = (unsigned short )0;
      sqlstm.sqhstv[2] = (unsigned char  *)szCodOperadora;
      sqlstm.sqhstl[2] = (unsigned long )5;
      sqlstm.sqhsts[2] = (         int  )0;
      sqlstm.sqindv[2] = (         short *)0;
      sqlstm.sqinds[2] = (         int  )0;
      sqlstm.sqharm[2] = (unsigned long )0;
      sqlstm.sqadto[2] = (unsigned short )0;
      sqlstm.sqtdso[2] = (unsigned short )0;
      sqlstm.sqhstv[3] = (unsigned char  *)szPrefPlaza;
      sqlstm.sqhstl[3] = (unsigned long )10;
      sqlstm.sqhsts[3] = (         int  )0;
      sqlstm.sqindv[3] = (         short *)0;
      sqlstm.sqinds[3] = (         int  )0;
      sqlstm.sqharm[3] = (unsigned long )0;
      sqlstm.sqadto[3] = (unsigned short )0;
      sqlstm.sqtdso[3] = (unsigned short )0;
      sqlstm.sqhstv[4] = (unsigned char  *)&lhNumFolio;
      sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
      sqlstm.sqhsts[4] = (         int  )0;
      sqlstm.sqindv[4] = (         short *)0;
      sqlstm.sqinds[4] = (         int  )0;
      sqlstm.sqharm[4] = (unsigned long )0;
      sqlstm.sqadto[4] = (unsigned short )0;
      sqlstm.sqtdso[4] = (unsigned short )0;
      sqlstm.sqhstv[5] = (unsigned char  *)szhResultado;
      sqlstm.sqhstl[5] = (unsigned long )256;
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
}



       if (SQLCODE)
       {
        vDTrazasLog  (modulo,"\n\t**  WARNING: Error en ejecucion de FA_FOLIACION_PG.FA_ANULA_FOLIO_FN **"
                                "\n\t\t=> Error : [%d]  [%s] ",LOG05,SQLCODE,SQLERRM);
       }
  	}
  	/* Se agrega cod_tipdocum par el cliente asociado ya que puede ser que este en 72(no tenga cargos fatura) y debe dejarlo en 2 (porque ahora si tiene cargos)*/
  	sprintf(szCadenaSQL,"\t  UPDATE FA_FACTDOCU_%ld \n"
				"\t  SET TOT_DESCUENTO = %f ,\n"
				"\t\t COD_TIPDOCUM     = %d ,\n"
				"\t\t NUM_FOLIO        = 0 ,\n"
				"\t\t ACUM_NETOGRAV    = %f ,\n"
				"\t\t ACUM_NETONOGRAV  = %f ,\n"
				"\t\t TOT_FACTURA      = %f ,\n"
				"\t\t TOT_CARGOSME     = %f ,\n"
				"\t\t TOT_PAGAR        = %f \n"
				"\t WHERE IND_ORDENTOTAL = %ld \n",
				lCodCicloFact,
				dhTotDescuento, stProceso.iCodTipDocum, dhAcumNetoGrav, dhAcumNetoNoGrav,
				dhTotFactura, dhTotCargosMe, dhTotPagar,
				lIndOrdenTotal);
  }
	if(!bfnExecuteQuery(szCadenaSQL))
	{
	    vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
	    vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
		return (FALSE);
	}

	return (TRUE);

}/************************* Fin bfnRecalculaDocuCicloCli *************************/

BOOL bfnUpdateIndOrdenTotalFD( int iInd)
{
	char modulo[]   = "bfnUpdateIndOrdenTotalFD";

	long lIndOrdenTotal = stDatosDobleCuenta[iInd].lIndOrdenTotal;
	int  iNumSecDetalle = stDatosDobleCuenta[iInd].iNumSecDetalle;

	static char szCadenaSQL[1024];

	vDTrazasLog  (modulo,"\n\t**(bfnUpdateIndOrdenTotalFD)\n"
						 "\t\tInd Orden Total        [%ld]\n"
						 "\t\tNum Secuencia Detalle  [%d]\n",
						 LOG03,
						 lIndOrdenTotal,
						 iNumSecDetalle);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t  UPDATE FA_DET_FACTURACION_DIF_TO \n"
						"\t  SET IND_ORDENTOTAL = %ld \n"
						"\t WHERE NUM_SEC_DETALLE_FD = %d \n",
						lIndOrdenTotal,iNumSecDetalle);

	if(!bfnExecuteQuery(szCadenaSQL))
    {
        vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        return (FALSE);
    }

	return (TRUE);

}/************************* Fin bfnUpdateIndOrdenTotalFD *************************/


/*** Funciones para Manejo de Strings ***/

#ifndef isnull
    #define isnull(name) (name==(char )NULL )
#endif
#ifndef strnull
    #define strnull(name) (name==(char *)NULL || name[0]==(char)NULL)
#endif

char *ltrim(char *s)
{
    char *p=s;
    if( strnull(s) )
        return(s);
    while( *p<=32 && *p>1 )
        p++;
    strcpy(s,p);
    return(s);
} /*** FIN ltrim ***/

char *rtrim(char *s)
{
    char *p=NULL;
    if( strnull(s) )
        return(s);
    p=(s+strlen(s)-1);
    while( *p<=32 && *p>1 )
        p--;
    *(++p)=0;
    return(s);
} /*** FIN rtrim ***/

char *alltrim(char *s)
{
    return(ltrim(rtrim(s)));
} /*** FIN alltrim ***/

/*** FIN alltrim ***/

/**************************************************************/
/***  Grupo de Funciones para Facturar Un cliente Asociado  ***/
/**************************************************************/

BOOL bfnFacturaCliAsoc(long lCodCicloFact, int iInd)
{
	char modulo[]   = "bfnFacturaCliAsoc";
	long lCodCliente = stDatosDobleCuenta[iInd].lCodCliAsoc;

	/*** Se obtiene un nuevo Num. de Ind Orden Total ***/
	if(!bfnGetNewIndOrdenTotal(iInd))
	{
		vDTrazasError(modulo," en Funcion bfnGetNewIndOrdenTotal", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnGetNewIndOrdenTotal", LOG01);
		return (FALSE);
	}

	/*** Se obtiene la Data correspondiente al Cliente Asociado ***/
	if(!bfnGetDatosClieAsoc(lCodCicloFact, iInd))
	{
		vDTrazasError(modulo," en Funcion bfnGetDatosClieAsoc", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnGetDatosClieAsoc", LOG01);
		return (FALSE);
	}

	/*** Se crea el registro en la FA_FACTCLIE ***/
	if(!bfnInsertClieAsocFaCicloCli(lCodCicloFact, iInd))
	{
		vDTrazasError(modulo," en Funcion bfnInsertClieAsocFactDocu", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnInsertClieAsocFactDocu", LOG01);
		return (FALSE);
	}

	/*** Se crea el Registro en la FA_FACTDOCU_ciclo ***/
	if(!bfnInsertClieAsocFactDocu(lCodCicloFact, iInd))
	{
		vDTrazasError(modulo," en Funcion bfnInsertClieAsocFactDocu", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnInsertClieAsocFactDocu", LOG01);
		return (FALSE);
	}

	/*** Se crea el Registro en la FA_FACTDCLIE_ciclo ***/
	if(!bfnInsertClieAsocFactClie(lCodCicloFact, iInd))
	{
		vDTrazasError(modulo," en Funcion bfnInsertClieAsocFactClie", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnInsertClieAsocFactClie", LOG01);
		return (FALSE);
	}

	/*** Se crea el Registro en la FA_FACTABON_ciclo ***/
	if(!bfnInsertClieAsocFactAbon(lCodCicloFact, iInd, 0.0))
	{
		vDTrazasError(modulo," en Funcion bfnInsertClieAsocFactAbon", LOG01);
        vDTrazasLog  (modulo," en Funcion bfnInsertClieAsocFactAbon", LOG01);
		return (FALSE);
	}

	vDTrazasLog(modulo, "FIN Facturacion Cliente Asociado [%ld]", LOG03,lCodCliente);

	return (TRUE);

} /*** FIN bfnFacturaCliAsoc ***/

BOOL bfnGetNewIndOrdenTotal (int iInd)
{
	char modulo[]   = "bfnGetNewIndOrdenTotal";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

		long lhIndOrdenTotal;
    /* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog (modulo,"\n\t ENTER bfnGetNewIndOrdenTotal\n",LOG03);

	/* EXEC SQL
		SELECT FA_SEQ_IND_ORDENTOTAL.NEXTVAL
		INTO   :lhIndOrdenTotal
		FROM   DUAL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select FA_SEQ_IND_ORDENTOTAL.nextval  into :b0  from DUAL ";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1128;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhIndOrdenTotal;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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



	if (SQLCODE != SQLOK)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,"Fa_Seq_Ind_OrdenTotal",
		szfnORAerror ());
		return (FALSE);
	}

	vDTrazasLog  (modulo,"\n\t Valor  IndOrdenTotal      [%ld]",LOG05,lhIndOrdenTotal);
	stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc = lhIndOrdenTotal;

	return (TRUE);

} /*** FIN bfnGetNewIndOrdenTotal ***/

BOOL bfnGetDatosClieAsoc(long lCodCicloFact, int  iInd)
{
	char	modulo[]   = "bfnGetDatosClieAsoc";

	COMUNAS  stComuna  ; memset (&stComuna  ,0,sizeof(COMUNAS) );
	CIUDADES stCiudad  ; memset (&stCiudad  ,0,sizeof(CIUDADES));

	memset(&stCliente,0,sizeof(CLIENTE));

	stCliente.lCodCliente = stDatosDobleCuenta[iInd].lCodCliAsoc;

	vDTrazasLog (modulo,"\n\t ENTER bfnGetDatosClieAsoc\n",LOG03);

	if (!bfnGetDatosCliente(stCliente.lCodCliente))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnGetDatosCliente",LOG01);
		vDTrazasLog(modulo," en  retorno Funcion bfnGetDatosCliente",LOG01);
		return (FALSE);
	}

	if (!bfnGetDirecCli (stCliente.lCodCliente, iTIPDIRECCION))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnGetDirecCli",LOG01);
		vDTrazasLog(modulo," en  retorno Funcion bfnGetDirecCli",LOG01);
		return (FALSE);
	}

	strcpy (stComuna.szCodRegion   ,stCliente.szCodRegion)   ;
	strcpy (stComuna.szCodProvincia,stCliente.szCodProvincia);
	strcpy (stComuna.szCodComuna   ,stCliente.szCodComuna)   ;

	if (!bfnFindComuna (&stComuna,stProceso.iCodTipDocum))
		return FALSE;

	strcpy (stCliente.szDesComuna,stComuna.szDesComuna);

	strcpy (stCiudad.szCodRegion   ,stCliente.szCodRegion)   ;
	strcpy (stCiudad.szCodProvincia,stCliente.szCodProvincia);
	strcpy (stCiudad.szCodCiudad   ,stCliente.szCodCiudad)   ;

	if (!bfnFindCiudad (&stCiudad,stProceso.iCodTipDocum))
		return FALSE;

	strcpy (stCliente.szDesCiudad,stCiudad.szDesCiudad);

	if (!bfnGetCodPlanCom (&stCliente))
	{
		vDTrazasError(modulo," en  retorno Funcion bGetCodPlanCom",LOG01);
		vDTrazasLog  (modulo," en  retorno Funcion bGetCodPlanCom",LOG01);
		return (FALSE);
	}

	return (TRUE);

} /*** FIN bfnGetDatosClieAsoc ***/

BOOL bfnInsertClieAsocFaCicloCli(long lCodCicloFact, int  iInd)
{
	char modulo[]   = "bfnInsertClieAsocFaCicloCli";

	FACICLOCLI		stCliCicloCli; memset (&stCliCicloCli, 0, sizeof(FACICLOCLI));

	vDTrazasLog (modulo,"\n\t Parametro entrada  bfnInsertClieAsocFaCicloCli\n"
						 "\t\tCod Ciclo Fact  [%ld]\n"
						 "\t\tInd Registro    [%ld]\n",
						 LOG03,
						 lCodCicloFact,
						 iInd);

	if(!bfngetDataCliAsocGeClientes(stDatosDobleCuenta[iInd].lCodCliAsoc, &stCliCicloCli))
	{
		vDTrazasError(modulo," en  retorno Funcion bfngetDataCliAsocGeClientes",LOG01);
		vDTrazasLog  (modulo," en  retorno Funcion bfngetDataCliAsocGeClientes",LOG01);
		return (FALSE);
	}

	stCliCicloCli.iCodProducto  = 1;  /*** se asume Producto CELULAR ***/
	stCliCicloCli.lNumAbonado   = 0L;
	stCliCicloCli.lNumProceso   = stProceso.lNumProceso;
	stCliCicloCli.iIndCambio    = 0;
	stCliCicloCli.iCodCredMor   = 0;
	stCliCicloCli.lNumTerminal  = 0L;
	strcpy(stCliCicloCli.szFecUltFact ,"");
	stCliCicloCli.iIndMascara   = 1;

	/*** Se imprimen los registros del FA_CICLOCLI  si LOG05 ***/
	vfnPrintCliCicloCli(&stCliCicloCli);

	/*** Insertando Registro en FA_CICLOCLI ***/
	if(!bfnInsertaRegFaCicloCli(&stCliCicloCli))
	{
	    vDTrazasError(modulo, "en retorno de Funcion  bfnInsertaRegFaCicloCli",LOG01);
	    vDTrazasLog  (modulo, "en retorno de Funcion  bfnInsertaRegFaCicloCli",LOG01);
		return(FALSE);
	}

	return (TRUE);

} /*** FIN bfnInsertClieAsocFactAbon ***/


BOOL bfnInsertaRegFaCicloCli(FACICLOCLI *pstCiCli)
{
	char modulo[]   = "bfnInsertaRegFaCicloCli";

	static char szCadenaSQL[2048];

	vDTrazasLog (modulo,"\n\t\t* INSERTANDO Regsitro en FA_CICLOCLI \n",LOG03);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t INSERT INTO FA_CICLOCLI \n"
						"\t\t (COD_CLIENTE,  COD_CICLO,     COD_PRODUCTO, NUM_ABONADO, \n"
						"\t\t NUM_PROCESO,   COD_CALCLIEN,  IND_CAMBIO,   NOM_USUARIO, \n"
						"\t\t NOM_APELLIDO1, NOM_APELLIDO2, COD_CREDMOR,  IND_DEBITO, \n"
						"\t\t COD_CICLONUE,  FEC_ALTA,      NUM_TERMINAL, \n"
						"\t\t IND_MASCARA,   COD_DESPACHO,  COD_PRIORIDAD) \n"
						"\t VALUES (\n"
						"\t\t %ld, %d, %d, %ld, \n"
						"\t\t %ld, '%s', %d, '%s', \n"
						"\t\t '%s', '%s', %d, '%s', \n"
						"\t\t %d, TO_DATE('%s','YYYYMMDDHH24MISS'), %ld, \n"
						"\t\t %d, '%s', %d) \n",
						pstCiCli->lCodCliente,    pstCiCli->iCodCiclo,      pstCiCli->iCodProducto, pstCiCli->lNumAbonado,
						pstCiCli->lNumProceso,    pstCiCli->szCodCalClien,  pstCiCli->iIndCambio,   pstCiCli->szNomUsuario,
						pstCiCli->szNomApellido1, pstCiCli->szNomApellido2, pstCiCli->iCodCredMor,  pstCiCli->szIndDebito,
						pstCiCli->iCodCicloNue,   pstCiCli->szFecAlta,      pstCiCli->lNumTerminal,
						pstCiCli->iIndMascara,    pstCiCli->szCodDespacho,  pstCiCli->iCodPrioridad);

	if(!bfnExecuteQuery(szCadenaSQL))
    {
        vDTrazasError(modulo, " Cliente existente en FA_CICLOCLI ",LOG01);
        vDTrazasLog  (modulo, " Cliente existente en FA_CICLOCLI ",LOG01);
/*      return (FALSE);*/
    }

	return (TRUE);

} /*** FIN bfnInsertaRegFaCicloCli ***/

BOOL bfnInsertClieAsocFactClie(long lCodCicloFact, int  iInd)
{
	char	modulo[]   = "bfnInsertClieAsocFactClie";
	char	szDesActividad[]="";

	vDTrazasLog (modulo,"\n\t ENTER bfnInsertClieAsocFactClie\n",LOG03);

	if (stCliente.iCodActividad > 0)
	{
		if (!bfnFindActividad (stCliente.iCodActividad, szDesActividad))
			return (FALSE);
	}

	/*** Se imprime los datos del cliente (stCliente) si LOG05 ***/
	vPrintCliente(&stCliente);

	/*** Inserta registro del cliente en FA_FACTCLIE_<ciclo> ***/
	if(!bfnInsertaRegFactClie(lCodCicloFact, &stCliente, iInd, szDesActividad))
	{
		vDTrazasError(modulo," en  retorno Funcion bfnInsertaRegFactClie",LOG01);
		vDTrazasLog(modulo," en  retorno Funcion bfnInsertaRegFactClie",LOG01);
		return (FALSE);
	}

	return (TRUE);

} /*** FIN bfnInsertClieAsocFactClie ***/

BOOL bfnInsertaRegFactClie(long lCodCicloFact, CLIENTE *pstCLI, int iInd, char *szDesActividad)
{
	char modulo[]   = "bfnInsertaRegFactClie";
    static char szCadenaSQL[2048];

	vDTrazasLog (modulo,"\n\t\t* INSERTANDO Regsitro en FA_FACTCLIE_%ld \n",LOG03,lCodCicloFact);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t INSERT INTO	FA_FACTCLIE_%ld \n"
		"\t\t (IND_ORDENTOTAL, COD_CLIENTE    ,  NOM_CLIENTE    , COD_PLANCOM    ,  \n"
		"\t\t NOM_APECLIEN1  , NOM_APECLIEN2  , TEF_CLIENTE1   , TEF_CLIENTE2   ,  \n"
		"\t\t DES_ACTIVIDAD  , NOM_CALLE      , NUM_CALLE      , NUM_PISO       ,  \n"
		"\t\t DES_COMUNA     , DES_CIUDAD     , COD_PAIS       , IND_DEBITO     ,  \n"
		"\t\t IMP_STOPDEBIT  , COD_BANCO      , COD_SUCURSAL   , IND_TIPCUENTA  ,  \n"
		"\t\t COD_TIPTARJETA , NUM_CTACORR    , NUM_TARJETA    , FEC_VENCITARJ  ,  \n"
		"\t\t COD_BANCOTARJ  , COD_TIPIDTRIB  , NUM_IDENTTRIB  , NUM_FAX        ,  \n"
		"\t\t COD_IDIOMA     , GLS_DIRECCLIE ) \n"
        "\t VALUES ( %ld, %ld, '%s', %ld, \n"
		"\t\t '%s', '%s', '%s', '%s', \n"
		"\t\t '%s', '%s', '%s', '%s', \n"
		"\t\t '%s', '%s', '%s', '%s', \n"
		"\t\t %f, '%s', '%s', '%s', \n"
		"\t\t '%s', '%s', '%s', TO_DATE('%s','YYYYMMDDHH24MISS'), \n"
		"\t\t '%s', '%s', '%s', '%s', \n"
		"\t\t '%s', '%s') \n",
		lCodCicloFact,
		stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc, pstCLI->lCodCliente, pstCLI->szNomCliente, pstCLI->lCodPlanCom,
		pstCLI->szNomApeClien1, pstCLI->szNomApeClien2, pstCLI->szTefCliente1, pstCLI->szTefCliente2,
		szDesActividad, pstCLI->szNomCalle, pstCLI->szNumCalle, pstCLI->szNumPiso,
		pstCLI->szDesComuna, pstCLI->szDesCiudad, pstCLI->szCodPais, pstCLI->szIndDebito,
		pstCLI->dImpStopDebit, pstCLI->szCodBanco, pstCLI->szCodSucursal, pstCLI->szIndTipCuenta,
		pstCLI->szCodTipTarjeta, pstCLI->szNumCtaCorr, pstCLI->szNumTarjeta, pstCLI->szFecVenciTarj,
		pstCLI->szCodBancoTarj, pstCLI->szCodTipIdTrib, pstCLI->szNumIdentTrib, pstCLI->szNumFax,
		pstCLI->szCodIdioma, pstCLI->szGls_DirecClie);

	if(!bfnExecuteQuery(szCadenaSQL))
    {
        vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        return (FALSE);
    }

	return (TRUE);

} /*** FIN bfnInsertaRegFactClie ***/

BOOL bfnInsertClieAsocFactDocu(long lCodCicloFact, int  iInd)
{
	char modulo[]   = "bfnInsertClieAsocFactDocu";
	int	iZonaImpo=0;

	memset(&stHistDocu,0,sizeof(HISTDOCU));

	OFICINA pstOficina; memset(&pstOficina,0,sizeof(OFICINA));

	char  szCodOficEmisora[3]; memset(szCodOficEmisora,0,sizeof(szCodOficEmisora));
	char  pszCodOficina[3]; memset(pszCodOficina,0,sizeof(pszCodOficina));

	int		iTipImpositiva = iCODCATRIBUT_EXENTO;

	static char szhCodRegion    [4]; /* EXEC SQL VAR szhCodRegion IS STRING(4); */ 

    static char szhCodProvincia [6]; /* EXEC SQL VAR szhCodProvincia IS STRING(6); */ 

    static char szhCodCiudad    [6]; /* EXEC SQL VAR szhCodCiudad IS STRING(6); */ 

    static char szhCodOficina   [3]; /* EXEC SQL VAR szhCodOficina IS STRING(3); */ 


	/*** Se inicializan registros con valor 0, posteriromente se actualizaran ***/

	stHistDocu.dTotPagar = 0.0;
	stHistDocu.dTotCargosMe = 0.0;
	stHistDocu.dTotFactura = 0.0;
	stHistDocu.dTotCuotas = 0.0;
	stHistDocu.dTotDescuento = 0.0;
	stHistDocu.dImpSaldoAnt = 0.0;

	stHistDocu.dAcumNetoGrav = 0.0;
	stHistDocu.dAcumNetoNoGrav = 0.0;
	stHistDocu.dAcumIva = 0.0;

	stHistDocu.iIndFactur = 1;
	stHistDocu.iIndVisada = 0;
	stHistDocu.iIndLibroIva = 0;
	stHistDocu.iIndPasoCobro = 0;
	stHistDocu.iIndSuperTel = 0;
	stHistDocu.iIndAnulada = 0;

	long lIndOrdenTotal  = stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc;
	sprintf(stHistDocu.szIndOrdenTotal,"%ld",lIndOrdenTotal);
	stHistDocu.lCodCliente     = stDatosDobleCuenta[iInd].lCodCliAsoc;
	stHistDocu.lCodCiclFact    = lCodCicloFact;

	vDTrazasLog (modulo,"\n\t ENTER bfnInsertClieAsocFactDocu\n",LOG03);

	vfnComposicionNumCTC(lIndOrdenTotal, stHistDocu.szNumCTC);

	stHistDocu.lNumProceso = stFecProceso.lNumProceso;
	strcpy(stHistDocu.szFecVencimie,stFecProceso.szFecVencimie);
	strcpy(stHistDocu.szFecEmision,stFecProceso.szFecEmision);
	strcpy(stHistDocu.szFecCaducida,stFecProceso.szFecCaducida);
	strcpy(stHistDocu.szFecProxVenc,stFecProceso.szFecProxVenc);

	vDTrazasLog(modulo,"\t\t iCodCiclo : [%d]",LOG05,stDatosGener.iCodCiclo);

	strcpy (stHistDocu.szhCodMonedaImp, stDatosGener.szCodMoneFact);
	stHistDocu.dhImpConversion    = 1;
	stHistDocu.lCodCliente        = stCliente.lCodCliente;
	stHistDocu.lCodVendedorAgente = stProceso.lCodVendedorAgente;
	stHistDocu.lCodVendedor       = stProceso.lCodVendedorAgente;
	stHistDocu.iCodCentrEmi       = stProceso.iCodCentrEmi;
	stHistDocu.iIndFactur         = stCliente.iIndFactur;
	stHistDocu.lNumFolio          = 0;
	strcpy (stHistDocu.szPrefPlaza,"");
	strcpy (stHistDocu.szCodOperadora,alltrim(stCliente.szCodOperadora));

	strcpy (szhCodRegion,stCliente.szCodRegion);
	strcpy (szhCodProvincia,stCliente.szCodProvincia);
	strcpy (szhCodCiudad,stCliente.szCodCiudad);

	if (!bFindZonaImpo(szhCodRegion, szhCodProvincia, szhCodCiudad, stHistDocu.szFecEmision, &iZonaImpo))
	{
		vDTrazasError(modulo,"en el retorno de la funcion : bFindZonaImpo",LOG01);
		vDTrazasLog(modulo,"en el retorno de la funcion : bFindZonaImpo",LOG01);
		return FALSE;
	}

	stHistDocu.iCodZonaImpo = iZonaImpo;

	if (!bfnGetDirOfiVend (stProceso.lCodVendedorAgente, pszCodOficina))
	{
		vDTrazasError(modulo,"en el retorno de la funcion : bfnGetDirOfiVend",LOG01);
		vDTrazasLog(modulo,"en el retorno de la funcion : bfnGetDirOfiVend",LOG01);
		return FALSE;
	}

	strcpy(stProceso.szCodOficina,pszCodOficina);

	vDTrazasLog (modulo,"\t\t cod_oficina proceso    : [%s]",LOG05,stProceso.szCodOficina);
	vDTrazasLog (modulo,"\t\t cod_Vendedor           : [%ld]",LOG05,stProceso.lCodVendedorAgente);

	strcpy(szhCodOficina,stProceso.szCodOficina);

	vDTrazasLog (modulo,"\t\t szhCodOficina          : [%s]\n",LOG05,szhCodOficina);

	if (!bfnGetDataOficina (szhCodOficina, &pstOficina ))
    {
        vDTrazasError(modulo, "en retorno bfnFindOficina : [%s]",LOG01,szhCodOficina);
        vDTrazasLog  (modulo, "en retorno bfnFindOficina : [%s]",LOG01,szhCodOficina);
        return FALSE;
    }

	strcpy (stHistDocu.szCodOficina , szhCodOficina);

	strcpy (stHistDocu.szCodPlaza,alltrim(pstOficina.szCodPlaza));
	strcpy (stHistDocu.szNomUsuarOra,stProceso.szNomUsuarOra);
	strcpy (stHistDocu.szFecCambioMo,szFecSysDate);
	stHistDocu.iIndSuperTel = stCliente.iIndSuperTel;

	if (!bfnGetCatImpos (&stCliente))
    {
        vDTrazasError(modulo, "en retorno bfnGetCatImpos ",LOG01);
        vDTrazasLog  (modulo, "en retorno bfnGetCatImpos ",LOG01);
        return FALSE;
    }

	if (!bfnGetLetra (stProceso.iCodTipDocum,stCliente.iCodCatImpos, stHistDocu.szLetra))
    {
        vDTrazasError (modulo, "en retorno bGetLetra : [%s]",LOG01,stHistDocu.szLetra);
        vDTrazasLog (modulo, "en retorno bGetLetra : [%s]",LOG01,stHistDocu.szLetra);
        return FALSE;
    }

	if (!bGenNumSecuenciasEmi (stProceso.iCodTipDocum, stHistDocu.szLetra, stProceso.iCodCentrEmi,&stHistDocu.lNumSecuenci))
    {
        vDTrazasError(modulo, "en retorno bGenNumSecuenciasEmi",LOG01);
        vDTrazasLog  (modulo, "en retorno bGenNumSecuenciasEmi",LOG01);
        return FALSE;
    }

	vDTrazasLog (modulo,"\t\t iTipoFoliacion            : [%d]",LOG05,pstParamGener.iTipoFoliacion);

	stHistDocu.iCodCatImpos = stCliente.iCodCatImpos;
	stHistDocu.iCodModVenta = 1; 

	stHistDocu.iCodTipDocum = stProceso.iCodTipDocum;

	stHistDocu.lCodVendedor = stProceso.lCodVendedorAgente;

	/*** Muestra los registros de stHistDocu si LOG05 ***/
	vfnPrintHistDocu(&stHistDocu);

	/*** Se inserta el registro en la FA_FACTDOCU_<ciclo> ***/
	if(!bfnInsertaRegFactDocu(lCodCicloFact, &stHistDocu))
	{
		vDTrazasError(modulo," en retorno de bfnInsertaRegFactDocu",LOG01);
		vDTrazasLog(modulo," en retorno de bfnInsertaRegFactDocu",LOG01);
		return FALSE;
	}

	if (!bfnVerficaEstadoClie(stHistDocu.lNumProceso, stHistDocu.lCodCliente, stDatosDobleCuenta[iInd].lCodAbonAsoc))
	{
		vDTrazasError(modulo, "\n\t\t* Error en Obtencion de datos de FA_CICLOCLI \n", LOG01);
		vDTrazasLog  (modulo, "\n\t\t* Error en Obtencion de datos de FA_CICLOCLI \n", LOG01);
		return FALSE;
	}

	return (TRUE);

} /*** FIN bfnInsertClieAsocFactDocu ***/

BOOL bfnInsertaRegFactDocu(long lCodCicloFact, HISTDOCU *pstHD)
{
	char modulo[]   = "bfnInsertaRegFactDocu";

	static char szCadenaSQL[2048];

	vDTrazasLog (modulo,"\n\t\t* INSERTANDO Regsitro en FA_FACTDOCU_%ld \n",LOG03,lCodCicloFact);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t INSERT INTO	FA_FACTDOCU_%ld \n"
						"\t\t (NUM_SECUENCI, COD_TIPDOCUM, COD_VENDEDOR_AGENTE, LETRA, \n"
						"\t\t COD_CENTREMI, TOT_PAGAR, TOT_CARGOSME, TOT_FACTURA, \n"
						"\t\t TOT_CUOTAS, TOT_DESCUENTO, COD_VENDEDOR, COD_CLIENTE, \n"
						"\t\t FEC_EMISION, FEC_CAMBIOMO, NOM_USUARORA, ACUM_NETOGRAV, \n"
						"\t\t ACUM_NETONOGRAV, ACUM_IVA, IND_ORDENTOTAL, IND_FACTUR, \n"
						"\t\t IND_VISADA, IND_LIBROIVA, IND_PASOCOBRO, IND_SUPERTEL, \n"
						"\t\t IND_ANULADA, NUM_PROCESO, NUM_FOLIO, NUM_CTC, \n"
						"\t\t COD_PLANCOM, COD_CATIMPOS, FEC_VENCIMIE, FEC_CADUCIDA, \n"
						"\t\t FEC_PROXVENC, COD_CICLFACT, NUM_SECUREL, LETRAREL, \n"
						"\t\t COD_TIPDOCUMREL, COD_VENDEDOR_AGENTEREL, COD_CENTRREL,NUM_VENTA, \n"
						"\t\t NUM_TRANSACCION, COD_MODVENTA, NUM_CUOTAS, IMP_SALDOANT, \n"
						"\t\t COD_OPREDFIJA, COD_OFICINA, COD_ZONAIMPO, PREF_PLAZA, \n"
						"\t\t COD_OPERADORA, COD_PLAZA, COD_MONEDAIMP, IMP_CONVERSION) \n"
						"\t VALUES( %ld, %d, %ld, '%s', \n"
						"\t\t %d, %f, %f, %f, \n"
						"\t\t %f, %f, %ld, %ld, \n"
						"\t\t TO_DATE('%s','YYYYMMDDHH24MISS'), TO_DATE('%s','YYYYMMDDHH24MISS'), '%s', %f, \n"
						"\t\t %f, %f, TO_NUMBER('%s'), %d, \n"
						"\t\t %d, %d, %d, %d, \n"
						"\t\t %d, %ld, %ld, '%s', \n"
						"\t\t %ld, %d, TO_DATE('%s','YYYYMMDDHH24MISS'), TO_DATE('%s','YYYYMMDDHH24MISS'), \n"
						"\t\t TO_DATE('%s','YYYYMMDDHH24MISS'), %ld, %ld, '%s', \n"
						"\t\t %d, %ld, %d, %ld, \n"
						"\t\t %ld, %d, %d, %f, \n"
						"\t\t %d, '%s', %d, NVL('%s','000'), \n"
						"\t\t NVL('%s','00000'), NVL('%s','00000'), '%s', %f)\n",
						lCodCicloFact,
						pstHD->lNumSecuenci,pstHD->iCodTipDocum, pstHD->lCodVendedorAgente, pstHD->szLetra,
						pstHD->iCodCentrEmi, pstHD->dTotPagar, pstHD->dTotCargosMe, pstHD->dTotFactura,
						pstHD->dTotCuotas, pstHD->dTotDescuento, pstHD->lCodVendedor, pstHD->lCodCliente,
						pstHD->szFecEmision, pstHD->szFecCambioMo, pstHD->szNomUsuarOra, pstHD->dAcumNetoGrav,
						pstHD->dAcumNetoNoGrav, pstHD->dAcumIva, pstHD->szIndOrdenTotal, pstHD->iIndFactur,
						pstHD->iIndVisada, pstHD->iIndLibroIva, pstHD->iIndPasoCobro, pstHD->iIndSuperTel,
						pstHD->iIndAnulada, pstHD->lNumProceso, pstHD->lNumFolio, pstHD->szNumCTC,
						pstHD->lCodPlanCom, pstHD->iCodCatImpos, pstHD->szFecVencimie, pstHD->szFecCaducida,
						pstHD->szFecProxVenc, pstHD->lCodCiclFact, pstHD->lNumSecuRel, pstHD->szLetraRel,
						pstHD->iCodTipDocumRel, pstHD->lCodVendedorAgenteRel, pstHD->iCodCentrRel, pstHD->lNumVenta,
						pstHD->lNumTransaccion, pstHD->iCodModVenta, pstHD->iNumCuotas, pstHD->dImpSaldoAnt,
						pstHD->iCodOpRedFija, pstHD->szCodOficina, pstHD->iCodZonaImpo, pstHD->szPrefPlaza,
						pstHD->szCodOperadora, pstHD->szCodPlaza, pstHD->szhCodMonedaImp, pstHD->dhImpConversion);

	if(!bfnExecuteQuery(szCadenaSQL))
    {
        vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        return (FALSE);
    }

	return (TRUE);

} /*** FIN bfnInsertaRegFactDocu ***/

BOOL bfnInsertClieAsocFactAbon(long lCodCicloFact, int  iInd, double dImpFacturado)
{
	char modulo[]   = "bfnInsertClieAsocFactAbon";

	HISTABO		stAbonadoFD; memset (&stAbonadoFD  ,0,sizeof(HISTABO));

	vDTrazasLog (modulo,"\n\t ENTER bfnInsertClieAsocFactAbon\n",LOG03);

	stAbonadoFD.lNumAbonado  = 0;
	stAbonadoFD.lCodCliente  = stDatosDobleCuenta[iInd].lCodCliAsoc;
	stAbonadoFD.dTotCargosMe = dImpFacturado;
	stAbonadoFD.dAcumCargo   = dImpFacturado;
	stAbonadoFD.dAcumDto     = 0.0;
	stAbonadoFD.dAcumIva     = 0.0;

	sprintf (stAbonadoFD.szIndOrdenTotal, "%ld", stDatosDobleCuenta[iInd].lIndOrdenTotalAsoc);
	strcpy (stAbonadoFD.szCodPlanTarif, "");

	stAbonadoFD.iCodDetFact   = 0;
	strncpy (stAbonadoFD.szNomUsuario  , stCliente.szNomCliente,20);
	strncpy (stAbonadoFD.szNomApellido1, stCliente.szNomApeClien1,20);
	strncpy (stAbonadoFD.szNomApellido2, stCliente.szNomApeClien2,20);
	stAbonadoFD.iCodCredMor   = 0;
	strcpy (stAbonadoFD.szNumTerminal, "0");

	stAbonadoFD.iIndFactur   = stCliente.iIndFactur;
	stAbonadoFD.iIndSuperTel = 0;
	stAbonadoFD.lCodGrupo    = 0L;

	strcpy (stAbonadoFD.szNumTeleFija , "");
	strcpy (stAbonadoFD.szFecFinContra, "");

	/*** Se imprimen los registros del Abonado 0 si LOG05 ***/
	vfnPrintAbonado0(&stAbonadoFD);

	/*** Insertando Registro en FA_FACTABON_<ciclo> ***/
	if(!bfnInsertaRegFactAbon(lCodCicloFact, &stAbonadoFD))
	{
	    vDTrazasError(modulo, "en retorno de Funcion  bfnInsertaRegFactAbon",LOG01);
	    vDTrazasLog  (modulo, "en retorno de Funcion  bfnInsertaRegFactAbon",LOG01);
		return(FALSE);
	}

	return (TRUE);

} /*** FIN bfnInsertClieAsocFactAbon ***/

BOOL bfnInsertaRegFactAbon(long lCodCicloFact, HISTABO *pstHA)
{
	char modulo[]   = "bfnInsertaRegFactAbon";

	static char szCadenaSQL[2048];

	char 	szCodSituacion[5];
	char 	szNumBeeper[3];
	int		iCodZonaAbon = 0;

	vDTrazasLog (modulo,"\n\t\t* INSERTANDO Regsitro en FA_FACTABON_%ld \n",LOG03,lCodCicloFact);

	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	strcpy(szCodSituacion, "ZZZ");
    strcpy(szNumBeeper, "0")  ;

	sprintf(szCadenaSQL,"\t INSERT INTO FA_FACTABON_%ld \n"
						"\t\t (IND_ORDENTOTAL  , NUM_ABONADO     ,  COD_CLIENTE     ,\n"
						"\t\t COD_PRODUCTO    , COD_SITUACION   , TOT_CARGOSME    , ACUM_CARGO      ,\n"
						"\t\t ACUM_DTO        , ACUM_IVA        , COD_DETFACT     , FEC_FINCONTRA   ,\n"
						"\t\t IND_FACTUR      , COD_CREDMOR     , NOM_USUARIO     , NOM_APELLIDO1   ,\n"
						"\t\t NOM_APELLIDO2   , LIM_CREDITO     , NUM_CELULAR     , NUM_BEEPER      ,\n"
						"\t\t CAP_CODE        , IND_SUPERTEL    , NUM_TELEFIJA    , COD_ZONAABON )\n"
						"\t VALUES (\n"
						"\t\t TO_NUMBER('%s'), %ld, %ld,\n"
						"\t\t %d, '%s', %f, %f,\n"
						"\t\t %f, %f, %d, TO_DATE('%s','YYYYMMDDHH24MISS'),\n"
						"\t\t %d, %d, '%s', '%s',\n"
						"\t\t '%s', %f, TO_NUMBER('%s'), TO_NUMBER('%s'),\n"
						"\t\t %ld, %d, '%s', %d)\n",
					 	lCodCicloFact,
						pstHA->szIndOrdenTotal, pstHA->lNumAbonado, pstHA->lCodCliente,
						pstHA->iCodProducto, szCodSituacion, pstHA->dTotCargosMe, pstHA->dAcumCargo,
						pstHA->dAcumDto, pstHA->dAcumIva, pstHA->iCodDetFact, pstHA->szFecFinContra,
						pstHA->iIndFactur, pstHA->iCodCredMor, pstHA->szNomUsuario, pstHA->szNomApellido1,
						pstHA->szNomApellido2, pstHA->dLimCredito, pstHA->szNumTerminal, szNumBeeper,
						pstHA->lCapCode, pstHA->iIndSuperTel, pstHA->szNumTeleFija,
						0);

	if(!bfnExecuteQuery(szCadenaSQL))
    {
        vDTrazasError(modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        vDTrazasLog  (modulo, " en retorno funcion bfnExecuteQuery ",LOG01);
        return (FALSE);
    }

	return (TRUE);

} /*** FIN bfnInsertaRegFactAbon ***/

/*** ***/

/*****************************************************************************/
/*                            funcion : vfnComposicionNumCTC                 */
/* - Posicion 1 (long 1): 8                                                  */
/* - Posicion 2 (long 9): Ind_OrdenTotal                                     */
/* - Posicion 3 (long 1): Digito Verificador                                 */
/*****************************************************************************/
static void vfnComposicionNumCTC (long lInd_OrdenTotal, char *szNumCTC)
{

	char modulo[]   = "vfnComposicionNumCTC";

	vDTrazasLog (szExeName,"\n\t Parametros Entrada vfnComposicionNumCTC \n"
							"\t\t Ind OrdenTotal [%ld] \n"
							"\t\t Num. CTC       [%s] \n",
							LOG05,
							lInd_OrdenTotal,
							szNumCTC);

    int i       = 0;
    int j       = 2; /* j tomara los valores de 2 a 7 inclusives */
    int iDigito = 0;

    char szAux[2] = "";
    char szCTC[13]= "";

    div_t stRes       ;

    sprintf(szCTC, "%9.9ld", lInd_OrdenTotal);

    i = strlen(szCTC)-1;

    while (i >= 0)
    {
       if (j >= 8)
         j  = 2;
       strncpy (szAux, &szCTC [i], 1);
       iDigito += (atoi (szAux) * j);
       j++;
       i--;
    }

    stRes = div (iDigito, 11);

    if( (11-stRes.rem) == 10 )
       sprintf (szNumCTC,"%s%s",szCTC, szDIG10);
    else
       sprintf (szNumCTC,"%s%d",szCTC,((11-stRes.rem)==11)?0:11-stRes.rem);

    vDTrazasLog (modulo, "\n\t\t Num. CTC Generado : [%s]", LOG05, szNumCTC);

}/**************************** Final vfnComposicionNumCTC ********************/

/*****************************************************************************/
/*                          funcion : bfnFindActividad                       */
/*****************************************************************************/
static BOOL bfnFindActividad (int iCodActividad,
								char *szDesActividad)
{

	char modulo[]   = "bfnFindActividad";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static char *szhDesActividad;/* EXEC SQL VAR szhDesActividad IS STRING(41); */ 

	/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog (szExeName,"\n\t\t* Parametros Entrada Ge_Actividades"
							"\n\t\t=> Cod.Actividad  [%d]",LOG05,
							iCodActividad);

	szhDesActividad = szDesActividad;
	/* EXEC SQL
	SELECT /o+ index (GE_ACTIVIDADES PK_GE_ACTIVIDADES) o/
		DES_ACTIVIDAD
	INTO :szhDesActividad
	FROM GE_ACTIVIDADES
	WHERE COD_ACTIVIDAD = :iCodActividad; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (GE_ACTIVIDADES PK_GE_ACTIVIDADES)  +*/ D\
ES_ACTIVIDAD into :b0  from GE_ACTIVIDADES where COD_ACTIVIDAD=:b1";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1147;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szhDesActividad;
 sqlstm.sqhstl[0] = (unsigned long )41;
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)&iCodActividad;
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



	if (SQLCODE)
	{
		iDError (szExeName,ERR000,vInsertarIncidencia,
						"select->ge_actividades",szfnORAerror());
		return FALSE;
	}

	return TRUE;

}/*************************** Final bfnFindActividad *************************/

/*---------------------------------------------------------------------------*/
/* OBTENCION DE OFICINA EMISORA A PARTIR DE LA OFICINA DE LA PRIMER VENTA    */
/*---------------------------------------------------------------------------*/
char * bfnObtieneOficinaEmisora(char *Oficina, char *Operadora)
{
	char modulo[]   = "bfnObtieneOficinaEmisora";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        char    szhCod_Oficina[3];
        char    szhCod_OficinaEmis[3];
        char    szhCod_Operadora[5];
    /* EXEC SQL END DECLARE SECTION; */ 

    char OficinaRet[3];

    strcpy(szhCod_Oficina,Oficina);
    strcpy(szhCod_Operadora, Operadora);

     /* EXEC SQL SELECT COD_OFICINA
        INTO :szhCod_OficinaEmis
        FROM  GE_OPERPLAZA_TD
        WHERE COD_PLAZA = (
            SELECT  C.COD_PLAZA
            FROM    GE_OFICINAS A   ,
                GE_DIRECCIONES B,
                GE_CIUDADES C
            WHERE   A.COD_OFICINA   = :szhCod_Oficina
            AND     A.COD_DIRECCION = B.COD_DIRECCION
            AND     B.COD_REGION    = C.COD_REGION
            AND     B.COD_PROVINCIA = C.COD_PROVINCIA
            AND     B.COD_CIUDAD    = C.COD_CIUDAD)
        AND COD_OPERADORA_SCL = :szhCod_Operadora ; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 13;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select COD_OFICINA into :b0  from GE_OPERPLAZA_TD where \
(COD_PLAZA=(select C.COD_PLAZA  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUDA\
DES C where ((((A.COD_OFICINA=:b1 and A.COD_DIRECCION=B.COD_DIRECCION) and B.C\
OD_REGION=C.COD_REGION) and B.COD_PROVINCIA=C.COD_PROVINCIA) and B.COD_CIUDAD=\
C.COD_CIUDAD)) and COD_OPERADORA_SCL=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1170;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhCod_OficinaEmis;
     sqlstm.sqhstl[0] = (unsigned long )3;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)szhCod_Oficina;
     sqlstm.sqhstl[1] = (unsigned long )3;
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)szhCod_Operadora;
     sqlstm.sqhstl[2] = (unsigned long )5;
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



    if(SQLCODE == SQLNOTFOUND)
    {
        vDTrazasLog(szExeName,"\t=>No hay registros para la obtencion de la Oficina Emisora",LOG01);
        strcpy(OficinaRet,"--");
    }
    if(SQLCODE != SQLOK)
    {
        vDTrazasLog(szExeName,  "\n\t=>Error en la obtencion de la Oficina Emisora"
        						"\n\t=>szhCod_Operadora   [%s]"
        						"\n\t=>szhCod_Oficina [%s]"
        						"\n\t=>Retorno szhCod_OficinaEmis [%s]"
        						,LOG01, szhCod_Operadora, szhCod_Oficina, szhCod_OficinaEmis);

        strcpy(OficinaRet,"--");
    }
    else
    {
        strcpy(OficinaRet,szhCod_OficinaEmis);
    }

	return (OficinaRet);

}

/*****************************************************************************/
/*                           funcion : bfnGetDirOfiVend                      */
/*    Obtiene la region, provinci y ciudad de la oficina pasada              */
/*****************************************************************************/
BOOL bfnGetDirOfiVend (long lCodVendedor, char *szCodOficina )
{

	char modulo[]   = "bfnGetDirOfiVend";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long  lhCodVendedor;
        static char  szhCodOficina   [3]; /* EXEC SQL VAR szhCodOficina   IS STRING(3) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    lhCodVendedor=lCodVendedor;

    /* EXEC SQL
        SELECT  COD_OFICINA
          INTO  :szhCodOficina
          FROM  VE_VENDEDORES
         WHERE  COD_VENDEDOR = :lhCodVendedor; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select COD_OFICINA into :b0  from VE_VENDEDORES where COD\
_VENDEDOR=:b1";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1197;
    sqlstm.selerr = (unsigned short)1;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlstm.sqhstv[0] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[0] = (unsigned long )3;
    sqlstm.sqhsts[0] = (         int  )0;
    sqlstm.sqindv[0] = (         short *)0;
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



    if (SQLCODE)
        return FALSE;

    strcpy(szCodOficina,szhCodOficina);

    return (TRUE);

}/************************** Final bfnGetDirOfiVend **************************/

BOOL bfnGetFechasProceso(long lCodCicloFact)
{

	char modulo[]   = "bfnGetFechasProceso";

    /* EXEC SQL BEGIN DECLARE SECTION; */ 

        static long  lhCodCicloFact;
        static long  lhNumProceso;
        static char  szhFecVencimie [15]; /* EXEC SQL VAR szhFecVencimie IS STRING(15) ; */ 

        static char  szhFecEmision  [15]; /* EXEC SQL VAR szhFecEmision  IS STRING(15) ; */ 

        static char  szhFecCaducida [15]; /* EXEC SQL VAR szhFecCaducida IS STRING(15) ; */ 

        static char  szhFecProxVenc [15]; /* EXEC SQL VAR szhFecProxVenc IS STRING(15) ; */ 

    /* EXEC SQL END DECLARE SECTION; */ 


	lhCodCicloFact = lCodCicloFact;
	lhNumProceso = stHistDocu.lNumProceso;

	/* EXEC SQL
	SELECT
		PROCS.NUM_PROCESO,
		TO_CHAR(CIFACT.FEC_VENCIMIE,'YYYYMMDDHH24MISS'),
		TO_CHAR(CIFACT.FEC_EMISION,'YYYYMMDDHH24MISS'),
		TO_CHAR(CIFACT.FEC_CADUCIDA,'YYYYMMDDHH24MISS'),
		TO_CHAR(CIFACT.FEC_PROXVENC,'YYYYMMDDHH24MISS')
	INTO
		:lhNumProceso,
		:szhFecVencimie, :szhFecEmision, :szhFecCaducida, :szhFecProxVenc
	FROM
		FA_CICLFACT CIFACT , FA_PROCESOS PROCS
	WHERE
		CIFACT.COD_CICLFACT = :lhCodCicloFact
		AND CIFACT.COD_CICLFACT = PROCS.COD_CICLFACT; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select PROCS.NUM_PROCESO ,TO_CHAR(CIFACT.FEC_VENCIMIE,'YYYYM\
MDDHH24MISS') ,TO_CHAR(CIFACT.FEC_EMISION,'YYYYMMDDHH24MISS') ,TO_CHAR(CIFACT.\
FEC_CADUCIDA,'YYYYMMDDHH24MISS') ,TO_CHAR(CIFACT.FEC_PROXVENC,'YYYYMMDDHH24MIS\
S') into :b0,:b1,:b2,:b3,:b4  from FA_CICLFACT CIFACT ,FA_PROCESOS PROCS where\
 (CIFACT.COD_CICLFACT=:b5 and CIFACT.COD_CICLFACT=PROCS.COD_CICLFACT)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1220;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhNumProceso;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhFecVencimie;
 sqlstm.sqhstl[1] = (unsigned long )15;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhFecEmision;
 sqlstm.sqhstl[2] = (unsigned long )15;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhFecCaducida;
 sqlstm.sqhstl[3] = (unsigned long )15;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhFecProxVenc;
 sqlstm.sqhstl[4] = (unsigned long )15;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)0;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)&lhCodCicloFact;
 sqlstm.sqhstl[5] = (unsigned long )sizeof(long);
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
}



	if (SQLCODE != SQLOK)
	{
		vDTrazasLog  (modulo," en SELECT FROM FA_CICLFACT FA_PROCESOS [%d - %s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasError  (modulo," en SELECT FROM FA_CICLFACT FA_PROCESOS [%d - %s]",LOG01,SQLCODE,SQLERRM);
		return (FALSE);
	}

	stFecProceso.lNumProceso = lhNumProceso;
	strcpy(stFecProceso.szFecVencimie,szhFecVencimie);
	strcpy(stFecProceso.szFecEmision,szhFecEmision);
	strcpy(stFecProceso.szFecCaducida,szhFecCaducida);
	strcpy(stFecProceso.szFecProxVenc,szhFecProxVenc);

	vDTrazasLog  (modulo,"\n\t Retorno de bfnGetFechasProceso : \n"
						"\t\t lNumProceso       [%ld] \n"
						"\t\t szFecVencimie     [%s] \n"
						"\t\t szFecEmision      [%s] \n"
						"\t\t szFecCaducida     [%s] \n"
						"\t\t szFecProxVenc     [%s] \n",
						LOG05,
						stFecProceso.lNumProceso,
						stFecProceso.szFecVencimie,
						stFecProceso.szFecEmision,
						stFecProceso.szFecCaducida,
						stFecProceso.szFecProxVenc);

	return (TRUE);

}/************************** Final bfnGetFechasProceso **************************/

/*****************************************************************************/
/*                            funcion : bfnGetDetalleConcepto                */
/*****************************************************************************/
BOOL bfnGetDetalleConcepto(long lCodConcepto)
{
	char modulo[]   = "bfnGetDetalleConcepto";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long  lhCodConcepto   ;

		int   ihCodProducto   ;
		int   ihCodTipConce   ;
		char  szhCodMoneda[5] ;/* EXEC SQL VAR szhCodMoneda   IS STRING (5) ; */ 

		char  szhDesConcepto[65] ;/* EXEC SQL VAR szhDesConcepto IS STRING (65); */ 

		int   ihzCodGrpConcepto ;
	/* EXEC SQL END DECLARE SECTION  ; */ 


	vDTrazasLog (szExeName,"\n\t Parametro de Entrada bfnGetDetalleConcepto \n"
							"\t\t Cod Concepto   [%ld]",
							LOG03, lCodConcepto);

	lhCodConcepto    = lCodConcepto;

	/* EXEC SQL SELECT /o+ index (FA_CONCEPTOS PK_FA_CONCEPTOS) o/
				COD_PRODUCTO,
				DES_CONCEPTO,
				COD_TIPCONCE,
				COD_MONEDA
		INTO
				:ihCodProducto,
				:szhDesConcepto,
				:ihCodTipConce,
				:szhCodMoneda
		FROM FA_CONCEPTOS
		WHERE COD_CONCEPTO = :lhCodConcepto; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (FA_CONCEPTOS PK_FA_CONCEPTOS)  +*/ COD_P\
RODUCTO ,DES_CONCEPTO ,COD_TIPCONCE ,COD_MONEDA into :b0,:b1,:b2,:b3  from FA_\
CONCEPTOS where COD_CONCEPTO=:b4";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1259;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodProducto;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhDesConcepto;
 sqlstm.sqhstl[1] = (unsigned long )65;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)&ihCodTipConce;
 sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhCodMoneda;
 sqlstm.sqhstl[3] = (unsigned long )5;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)0;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)&lhCodConcepto;
 sqlstm.sqhstl[4] = (unsigned long )sizeof(long);
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (SQLCODE != SQLOK)
	{
		vDTrazasLog  (modulo," en SELECT FROM FA_CONCEPTOS [%d - %s]",LOG01,SQLCODE,SQLERRM);
		vDTrazasError  (modulo," en SELECT FROM FA_CONCEPTOS [%d - %s]",LOG01,SQLCODE,SQLERRM);
		return (FALSE);
	}

	/*** Se agregan los datos obtenidos a la estructura stFaConcepto ***/

	stFaConcepto.lCodConcepto = lhCodConcepto ;
	stFaConcepto.iCodProducto = ihCodProducto ;
	strcpy(stFaConcepto.szDesConcepto,szhDesConcepto);
	stFaConcepto.iCodTipConce = ihCodTipConce ;
	strcpy(stFaConcepto.szCodMoneda,szhCodMoneda);

	return (TRUE);

}/************************** Final bfnGetDetalleConcepto*********************/

/*****************************************************************************/
/*                            funcion : bfnMaxColumnConcepto                 */
/*****************************************************************************/
BOOL bfnMaxColumnConcepto (long lCodCicloFact, long *lColumna)
{
	char modulo[]   = "bfnMaxColumnConcepto";

	char szCadenaSQL[1024];

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long      lhColumna;
	/* EXEC SQL END DECLARE SECTION; */ 


	memset(szCadenaSQL,0,sizeof(szCadenaSQL));

	sprintf(szCadenaSQL,"\t SELECT NVL(MAX(COLUMNA),0) \n"
			"\t FROM FA_FACTCONC_%ld \n"
			"\t WHERE IND_ORDENTOTAL = TO_NUMBER('%s') \n"
			"\t 	AND COD_CONCEPTO = %ld \n",
			lCodCicloFact,
			stFaConcepto.szIndOrdenTotal,
			stFaConcepto.lCodConcepto);

	vDTrazasLog ( modulo,"\n\t Query for sql_select_Columna \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_select_Columna FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1294;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )1024;
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


	if (SQLCODE)
 	{
	    vDTrazasLog(modulo, "ERROR : PREPARE sql_select_Columna  [%s]",LOG01, SQLERRM);
	    vDTrazasError(modulo, "ERROR : PREPARE sql_select_Columna  [%s]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE cCursor_ConcepColumna CURSOR FOR sql_select_Columna; */ 


	if (SQLCODE) {
		vDTrazasError  (modulo,"ERROR : DECLARE del Cursor  cCursor_ConcepColumna "
							 "\n\t[%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo,"ERROR : DECLARE del Cursor  cCursor_ConcepColumna "
							 "\n\t[%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN cCursor_ConcepColumna; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1313;
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
        vDTrazasError(modulo, " ERROR : Open cCursor_ConcepColumna "
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " ERROR : Open cCursor_ConcepColumna"
                              "\n\t\t=> Error [%s] **",LOG01,SQLERRM);
        return (FALSE);
    }

	/* EXEC SQL FETCH cCursor_ConcepColumna INTO :lhColumna; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1328;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqfoff = (         int )0;
 sqlstm.sqfmod = (unsigned int )2;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhColumna;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(long);
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



    /* EXEC SQL CLOSE cCursor_ConcepColumna; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1347;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en CLOSE de cCursor_ConcepColumna : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en CLOSE de cCursor_ConcepColumna : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	*lColumna = lhColumna;
	vDTrazasLog ( modulo,"\n\t Columna Concepto [%ld]",LOG03,*lColumna);

	return (TRUE);

}/************************** Final bfnMaxColumnConcepto **********************/

/*****************************************************************************/
/*                             funcion : bGetCodPlanCom                      */
/*****************************************************************************/
BOOL bfnGetCodPlanCom (CLIENTE *pstCliente)
{
	char modulo[]   = "bfnGetCodPlanCom";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

  		static long lhCodPlanCom;
  		static long lhCodCliente;
	/* EXEC SQL END DECLARE SECTION; */ 


	vDTrazasLog (modulo,"\n\t ENTER a bfnGetCodPlanCom", LOG03);

	lhCodCliente = pstCliente->lCodCliente;

	/* EXEC SQL SELECT /o+ index (GA_INTARCEL PK_GA_INTARCEL) o/
		COD_PLANCOM
	INTO   :lhCodPlanCom
	FROM   GA_INTARCEL
	WHERE  COD_CLIENTE  = :lhCodCliente
		AND  ROWNUM     = 1; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select  /*+  index (GA_INTARCEL PK_GA_INTARCEL)  +*/ COD_PLA\
NCOM into :b0  from GA_INTARCEL where (COD_CLIENTE=:b1 and ROWNUM=1)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1362;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&lhCodPlanCom;
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
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



	if (SQLCODE == SQLNOTFOUND)
  	{
		vDTrazasLog (modulo,"\t\t Cod PlanCom no encontrado se asume valor [0]", LOG03);
		pstCliente->lCodPlanCom = 0L;
	}
	else if (SQLCODE == SQLOK)
	{
		pstCliente->lCodPlanCom = lhCodPlanCom;
	}
	else
	{
        vDTrazasError(modulo," en SELECT FROM GA_INTARCEL [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en SELECT FROM GA_INTARCEL [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
	}

	return (TRUE);

}/************************** Final bfnGetCodPlanCom **********************/

BOOL bfnGetLetra (int iCodTipDocum,int iCodCatImpos,char *szLetra)
{
	char modulo[]   = "bfnGetLetra";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static int   ihCodTipDocum;
		static int   ihCodCatImpos;
		static char* szhLetra     ; /* EXEC SQL VAR szhLetra IS STRING(2); */ 

	/* EXEC SQL END DECLARE SECTION  ; */ 


	vDTrazasLog (modulo,"\n\t Parametros de Entrada bfnGetLetra\n"
                        "\t\t Cod TipDocum [%d]\n"
                        "\t\t Cod CatImpos [%d]\n",
						LOG03,
                        iCodTipDocum,iCodCatImpos);

	ihCodTipDocum = iCodTipDocum;
	ihCodCatImpos = iCodCatImpos;
	szhLetra      = szLetra;

     /* EXEC SQL SELECT /o+ index (GE_LETRAS PK_GE_LETRAS) o/
                     LETRA
              INTO   :szhLetra
              FROM   GE_LETRAS
              WHERE  COD_TIPDOCUM = :ihCodTipDocum
                AND  COD_CATIMPOS = :ihCodCatImpos; */ 

{
     struct sqlexd sqlstm;
     sqlstm.sqlvsn = 12;
     sqlstm.arrsiz = 13;
     sqlstm.sqladtp = &sqladt;
     sqlstm.sqltdsp = &sqltds;
     sqlstm.stmt = "select  /*+  index (GE_LETRAS PK_GE_LETRAS)  +*/ LETRA i\
nto :b0  from GE_LETRAS where (COD_TIPDOCUM=:b1 and COD_CATIMPOS=:b2)";
     sqlstm.iters = (unsigned int  )1;
     sqlstm.offset = (unsigned int  )1385;
     sqlstm.selerr = (unsigned short)1;
     sqlstm.cud = sqlcud0;
     sqlstm.sqlest = (unsigned char  *)&sqlca;
     sqlstm.sqlety = (unsigned short)256;
     sqlstm.occurs = (unsigned int  )0;
     sqlstm.sqhstv[0] = (unsigned char  *)szhLetra;
     sqlstm.sqhstl[0] = (unsigned long )2;
     sqlstm.sqhsts[0] = (         int  )0;
     sqlstm.sqindv[0] = (         short *)0;
     sqlstm.sqinds[0] = (         int  )0;
     sqlstm.sqharm[0] = (unsigned long )0;
     sqlstm.sqadto[0] = (unsigned short )0;
     sqlstm.sqtdso[0] = (unsigned short )0;
     sqlstm.sqhstv[1] = (unsigned char  *)&ihCodTipDocum;
     sqlstm.sqhstl[1] = (unsigned long )sizeof(int);
     sqlstm.sqhsts[1] = (         int  )0;
     sqlstm.sqindv[1] = (         short *)0;
     sqlstm.sqinds[1] = (         int  )0;
     sqlstm.sqharm[1] = (unsigned long )0;
     sqlstm.sqadto[1] = (unsigned short )0;
     sqlstm.sqtdso[1] = (unsigned short )0;
     sqlstm.sqhstv[2] = (unsigned char  *)&ihCodCatImpos;
     sqlstm.sqhstl[2] = (unsigned long )sizeof(int);
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



	if (SQLCODE == SQLNOTFOUND)
  	{
		vDTrazasError(modulo,"\t\t Letra no encontrada", LOG03);
		vDTrazasLog  (modulo,"\t\t Letra no encontrada", LOG03);
		return (FALSE);
	}

	if (SQLCODE != SQLOK)
	{
        vDTrazasError(modulo," en SELECT FROM GE_LETRAS [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en SELECT FROM GE_LETRAS [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
	}

	vDTrazasLog (modulo,"\n\t\t Letra     [%s]",LOG05,szLetra);

	return (TRUE);

}/*********************** Final bfnGetLetra ************************************/

BOOL bfnGetCatImpos (CLIENTE *pstCli)
{
	char modulo[]   = "bfnGetCatImpos";

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		static long  lhCodCliente;
		static int   ihCodCatImpos;
	/* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente = pstCli->lCodCliente;

	vDTrazasLog (modulo,"\n\t Parametros de Entrada bfnGetCatImpos\n"
                        "\t\t Cod Cliente  [%ld]\n",
						LOG03,
                        lhCodCliente);

	/* EXEC SQL SELECT
				COD_CATIMPOS
			INTO
				:ihCodCatImpos
			FROM GE_CATIMPCLIENTES
			WHERE COD_CLIENTE = :lhCodCliente
			AND (FEC_DESDE <= SYSDATE AND FEC_HASTA >= SYSDATE); */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select COD_CATIMPOS into :b0  from GE_CATIMPCLIENTES where (\
COD_CLIENTE=:b1 and (FEC_DESDE<=SYSDATE and FEC_HASTA>=SYSDATE))";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1412;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCatImpos;
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



	if (SQLCODE == SQLNOTFOUND)
  	{
		vDTrazasError(modulo,"\t\t Categoria Impositiva no encontrada", LOG03);
		vDTrazasLog  (modulo,"\t\t Categoria Impositiva no encontrada", LOG03);
		return (FALSE);
	}

	if (SQLCODE != SQLOK)
	{
        vDTrazasError(modulo," en SELECT FROM GE_CATIMPCLIENTES [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en SELECT FROM GE_CATIMPCLIENTES [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
	}

	pstCli->iCodCatImpos = ihCodCatImpos;

	vDTrazasLog(modulo,"\n\t\t Cat Impostiva      [%d]", LOG05, pstCli->iCodCatImpos);

	return (TRUE);

}/**************************** Final bfnGetDataOficina *********************/

BOOL bfnGetDataOficina (char *szCodOficina, OFICINA *pstOficina )
{
	char modulo[]   = "bfnGetDataOficina";

 	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		char szhCodOficina 	[3];/* EXEC SQL VAR szhCodOficina	IS STRING(3); */ 

		char szhCodRegion 	[4];/* EXEC SQL VAR szhCodRegion		IS STRING(4); */ 

		char szhCodProvincia [6];/* EXEC SQL VAR szhCodProvincia	IS STRING(6); */ 

		char szhCodCiudad 	[6];/* EXEC SQL VAR szhCodCiudad 	IS STRING(6); */ 

		char szhCodPlaza 	[6];/* EXEC SQL VAR szhCodPlaza		IS STRING(6); */ 

    /* EXEC SQL END DECLARE SECTION; */ 


    vDTrazasLog (szExeName,"\n\t Paramtero de entrada a bfnGetDataOficina \n"
                  			"\t\t Cod Oficina       [%s] \n"
                  			"\t\t Num Oficina       [%d] \n"
                  			"\t\t Tip Documento     [%d] \n"
                  			"\t\t Cod Ciclo (Gener) [%d] \n",
                  			LOG03,
							szCodOficina, pstOficinas.iNumOficinas,
							stProceso.iCodTipDocum,stDatosGener.iCodCiclo);

   	strcpy (szhCodOficina, szCodOficina);

   	/* EXEC SQL
   		SELECT B.COD_REGION, B.COD_PROVINCIA, B.COD_CIUDAD, C.COD_PLAZA
   		INTO :szhCodRegion, :szhCodProvincia,:szhCodCiudad,:szhCodPlaza
        FROM GE_OFICINAS A, GE_DIRECCIONES B, GE_CIUDADES C
        WHERE A.COD_OFICINA	= :szhCodOficina
               AND A.COD_DIRECCION  = B.COD_DIRECCION
               AND B.COD_REGION     = C.COD_REGION
               AND B.COD_PROVINCIA  = C.COD_PROVINCIA
               AND B.COD_CIUDAD     = C.COD_CIUDAD; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "select B.COD_REGION ,B.COD_PROVINCIA ,B.COD_CIUDAD ,C.COD\
_PLAZA into :b0,:b1,:b2,:b3  from GE_OFICINAS A ,GE_DIRECCIONES B ,GE_CIUDADES\
 C where ((((A.COD_OFICINA=:b4 and A.COD_DIRECCION=B.COD_DIRECCION) and B.COD_\
REGION=C.COD_REGION) and B.COD_PROVINCIA=C.COD_PROVINCIA) and B.COD_CIUDAD=C.C\
OD_CIUDAD)";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1435;
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
    sqlstm.sqhstv[1] = (unsigned char  *)szhCodProvincia;
    sqlstm.sqhstl[1] = (unsigned long )6;
    sqlstm.sqhsts[1] = (         int  )0;
    sqlstm.sqindv[1] = (         short *)0;
    sqlstm.sqinds[1] = (         int  )0;
    sqlstm.sqharm[1] = (unsigned long )0;
    sqlstm.sqadto[1] = (unsigned short )0;
    sqlstm.sqtdso[1] = (unsigned short )0;
    sqlstm.sqhstv[2] = (unsigned char  *)szhCodCiudad;
    sqlstm.sqhstl[2] = (unsigned long )6;
    sqlstm.sqhsts[2] = (         int  )0;
    sqlstm.sqindv[2] = (         short *)0;
    sqlstm.sqinds[2] = (         int  )0;
    sqlstm.sqharm[2] = (unsigned long )0;
    sqlstm.sqadto[2] = (unsigned short )0;
    sqlstm.sqtdso[2] = (unsigned short )0;
    sqlstm.sqhstv[3] = (unsigned char  *)szhCodPlaza;
    sqlstm.sqhstl[3] = (unsigned long )6;
    sqlstm.sqhsts[3] = (         int  )0;
    sqlstm.sqindv[3] = (         short *)0;
    sqlstm.sqinds[3] = (         int  )0;
    sqlstm.sqharm[3] = (unsigned long )0;
    sqlstm.sqadto[3] = (unsigned short )0;
    sqlstm.sqtdso[3] = (unsigned short )0;
    sqlstm.sqhstv[4] = (unsigned char  *)szhCodOficina;
    sqlstm.sqhstl[4] = (unsigned long )3;
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
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}



    if (SQLCODE == SQLNOTFOUND)
    {
		vDTrazasError(modulo,"\t\t Oficina no encontrada", LOG03);
		vDTrazasLog  (modulo,"\t\t Oficina no encontrada", LOG03);
	    return FALSE;
    }
    else if (SQLCODE == SQLOK)
    {
    	strcpy (pstOficina->szCodOficina	, szhCodOficina	);
    	strcpy (pstOficina->szCodRegion		, szhCodRegion	);
    	strcpy (pstOficina->szCodProvincia	, szhCodProvincia);
    	strcpy (pstOficina->szCodCiudad		, szhCodCiudad	);
    	strcpy (pstOficina->szCodPlaza		, szhCodPlaza	);
    }
	else
	{
        vDTrazasError(modulo," en SELECT FROM GE_OFICINAS,.. [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        vDTrazasLog  (modulo," en SELECT FROM GE_OFICINAS,.. [%d] : [%s]",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
	}

    return (TRUE);

}/**************************** Final bfnGetDataOficina *********************/

BOOL bfngetDataCliAsocGeClientes(long lCodCliente, FACICLOCLI *pstCiCli)
{
	char modulo[]   = "bfngetDataCliAsocGeClientes";

	vDTrazasLog (modulo,"\n\t Parametro entrada  bfngetDataCliAsocGeClientes \n"
						"\t\t Cod Cliente Asoc  [%ld] \n",
						LOG03,
						lCodCliente);

	/* EXEC SQL BEGIN DECLARE SECTION; */ 

		long		lhCodCliente;
		int			ihCodCiclo;
		char		szhCodCalClien[4];
		char		szhNomCliente[20];
		char		szhNomApeClien1[20];
		char		szhNomApeClien2[20];
		char		szhIndDebito[3];
		int			ihCodCicloNue;
		char		szhFecAlta[15];
		char		szhCodDespacho[7];
		int			ihCodPrioridad;

		short		i_szhNomApeClien1;
		short		i_szhNomApeClien2;
		short		i_ihCodCicloNue;
    /* EXEC SQL END DECLARE SECTION; */ 


	lhCodCliente =lCodCliente;

	/* EXEC SQL
		SELECT
			CLI.COD_CICLO,     CLI.COD_CALCLIEN,  CLI.NOM_CLIENTE,
			CLI.NOM_APECLIEN1, CLI.NOM_APECLIEN2, CLI.IND_DEBITO,
			CLI.COD_CICLONUE,  TO_CHAR(CLI.FEC_ALTA,'YYYYMMDDHH24MISS'),
			CODE.COD_DESPACHO, CODE.COD_PRIORIDAD
		INTO
			:ihCodCiclo,     :szhCodCalClien, :szhNomCliente,
			:szhNomApeClien1:i_szhNomApeClien1,:szhNomApeClien2:i_szhNomApeClien2,:szhIndDebito,
			:ihCodCicloNue:i_ihCodCicloNue,  :szhFecAlta ,
			:szhCodDespacho, :ihCodPrioridad
		FROM GE_CLIENTES CLI, GA_SECDESPCLIE DES, FA_CODESPACHO CODE
		WHERE CLI.COD_CLIENTE = :lhCodCliente
		AND DES.COD_CLIENTE   = CLI.COD_CLIENTE
		AND CODE.COD_DESPACHO = DES.COD_DESPACHO; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "select CLI.COD_CICLO ,CLI.COD_CALCLIEN ,CLI.NOM_CLIENTE ,CLI\
.NOM_APECLIEN1 ,CLI.NOM_APECLIEN2 ,CLI.IND_DEBITO ,CLI.COD_CICLONUE ,TO_CHAR(C\
LI.FEC_ALTA,'YYYYMMDDHH24MISS') ,CODE.COD_DESPACHO ,CODE.COD_PRIORIDAD into :b\
0,:b1,:b2,:b3:b4,:b5:b6,:b7,:b8:b9,:b10,:b11,:b12  from GE_CLIENTES CLI ,GA_SE\
CDESPCLIE DES ,FA_CODESPACHO CODE where ((CLI.COD_CLIENTE=:b13 and DES.COD_CLI\
ENTE=CLI.COD_CLIENTE) and CODE.COD_DESPACHO=DES.COD_DESPACHO)";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1470;
 sqlstm.selerr = (unsigned short)1;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)&ihCodCiclo;
 sqlstm.sqhstl[0] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[0] = (         int  )0;
 sqlstm.sqindv[0] = (         short *)0;
 sqlstm.sqinds[0] = (         int  )0;
 sqlstm.sqharm[0] = (unsigned long )0;
 sqlstm.sqadto[0] = (unsigned short )0;
 sqlstm.sqtdso[0] = (unsigned short )0;
 sqlstm.sqhstv[1] = (unsigned char  *)szhCodCalClien;
 sqlstm.sqhstl[1] = (unsigned long )4;
 sqlstm.sqhsts[1] = (         int  )0;
 sqlstm.sqindv[1] = (         short *)0;
 sqlstm.sqinds[1] = (         int  )0;
 sqlstm.sqharm[1] = (unsigned long )0;
 sqlstm.sqadto[1] = (unsigned short )0;
 sqlstm.sqtdso[1] = (unsigned short )0;
 sqlstm.sqhstv[2] = (unsigned char  *)szhNomCliente;
 sqlstm.sqhstl[2] = (unsigned long )20;
 sqlstm.sqhsts[2] = (         int  )0;
 sqlstm.sqindv[2] = (         short *)0;
 sqlstm.sqinds[2] = (         int  )0;
 sqlstm.sqharm[2] = (unsigned long )0;
 sqlstm.sqadto[2] = (unsigned short )0;
 sqlstm.sqtdso[2] = (unsigned short )0;
 sqlstm.sqhstv[3] = (unsigned char  *)szhNomApeClien1;
 sqlstm.sqhstl[3] = (unsigned long )20;
 sqlstm.sqhsts[3] = (         int  )0;
 sqlstm.sqindv[3] = (         short *)&i_szhNomApeClien1;
 sqlstm.sqinds[3] = (         int  )0;
 sqlstm.sqharm[3] = (unsigned long )0;
 sqlstm.sqadto[3] = (unsigned short )0;
 sqlstm.sqtdso[3] = (unsigned short )0;
 sqlstm.sqhstv[4] = (unsigned char  *)szhNomApeClien2;
 sqlstm.sqhstl[4] = (unsigned long )20;
 sqlstm.sqhsts[4] = (         int  )0;
 sqlstm.sqindv[4] = (         short *)&i_szhNomApeClien2;
 sqlstm.sqinds[4] = (         int  )0;
 sqlstm.sqharm[4] = (unsigned long )0;
 sqlstm.sqadto[4] = (unsigned short )0;
 sqlstm.sqtdso[4] = (unsigned short )0;
 sqlstm.sqhstv[5] = (unsigned char  *)szhIndDebito;
 sqlstm.sqhstl[5] = (unsigned long )3;
 sqlstm.sqhsts[5] = (         int  )0;
 sqlstm.sqindv[5] = (         short *)0;
 sqlstm.sqinds[5] = (         int  )0;
 sqlstm.sqharm[5] = (unsigned long )0;
 sqlstm.sqadto[5] = (unsigned short )0;
 sqlstm.sqtdso[5] = (unsigned short )0;
 sqlstm.sqhstv[6] = (unsigned char  *)&ihCodCicloNue;
 sqlstm.sqhstl[6] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[6] = (         int  )0;
 sqlstm.sqindv[6] = (         short *)&i_ihCodCicloNue;
 sqlstm.sqinds[6] = (         int  )0;
 sqlstm.sqharm[6] = (unsigned long )0;
 sqlstm.sqadto[6] = (unsigned short )0;
 sqlstm.sqtdso[6] = (unsigned short )0;
 sqlstm.sqhstv[7] = (unsigned char  *)szhFecAlta;
 sqlstm.sqhstl[7] = (unsigned long )15;
 sqlstm.sqhsts[7] = (         int  )0;
 sqlstm.sqindv[7] = (         short *)0;
 sqlstm.sqinds[7] = (         int  )0;
 sqlstm.sqharm[7] = (unsigned long )0;
 sqlstm.sqadto[7] = (unsigned short )0;
 sqlstm.sqtdso[7] = (unsigned short )0;
 sqlstm.sqhstv[8] = (unsigned char  *)szhCodDespacho;
 sqlstm.sqhstl[8] = (unsigned long )7;
 sqlstm.sqhsts[8] = (         int  )0;
 sqlstm.sqindv[8] = (         short *)0;
 sqlstm.sqinds[8] = (         int  )0;
 sqlstm.sqharm[8] = (unsigned long )0;
 sqlstm.sqadto[8] = (unsigned short )0;
 sqlstm.sqtdso[8] = (unsigned short )0;
 sqlstm.sqhstv[9] = (unsigned char  *)&ihCodPrioridad;
 sqlstm.sqhstl[9] = (unsigned long )sizeof(int);
 sqlstm.sqhsts[9] = (         int  )0;
 sqlstm.sqindv[9] = (         short *)0;
 sqlstm.sqinds[9] = (         int  )0;
 sqlstm.sqharm[9] = (unsigned long )0;
 sqlstm.sqadto[9] = (unsigned short )0;
 sqlstm.sqtdso[9] = (unsigned short )0;
 sqlstm.sqhstv[10] = (unsigned char  *)&lhCodCliente;
 sqlstm.sqhstl[10] = (unsigned long )sizeof(long);
 sqlstm.sqhsts[10] = (         int  )0;
 sqlstm.sqindv[10] = (         short *)0;
 sqlstm.sqinds[10] = (         int  )0;
 sqlstm.sqharm[10] = (unsigned long )0;
 sqlstm.sqadto[10] = (unsigned short )0;
 sqlstm.sqtdso[10] = (unsigned short )0;
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



	if (SQLCODE != SQLOK)
	{
		vDTrazasError(modulo, " en SELECT GE_CLIENTES [%s]",LOG01, SQLERRM);
        vDTrazasLog  (modulo, " en SELECT GE_CLIENTES [%s]",LOG01, SQLERRM);
        return (FALSE);
	}

	pstCiCli->lCodCliente    = lhCodCliente;
	pstCiCli->iCodCiclo      = ihCodCiclo;
	pstCiCli->iCodCicloNue   = ihCodCicloNue;
	pstCiCli->iCodPrioridad  = ihCodPrioridad;
	strcpy(pstCiCli->szCodCalClien, alltrim(szhCodCalClien));
	strcpy(pstCiCli->szNomUsuario, alltrim(szhNomCliente));
	pstCiCli->szNomUsuario[sizeof(pstCiCli->szNomUsuario)-1]=0;
	if (i_szhNomApeClien1 == ORA_NULL)
		strcpy(pstCiCli->szNomApellido1, " ");
	else
		strcpy(pstCiCli->szNomApellido1, alltrim(szhNomApeClien1));

	if (i_szhNomApeClien2 == ORA_NULL)
		strcpy(pstCiCli->szNomApellido2, " ");
	else
		strcpy(pstCiCli->szNomApellido2, alltrim(szhNomApeClien2));

	strcpy(pstCiCli->szIndDebito, alltrim(szhIndDebito));
	strcpy(pstCiCli->szFecAlta, alltrim(szhFecAlta));
	strcpy(pstCiCli->szCodDespacho, alltrim(szhCodDespacho));

	return (TRUE);

} /*** FIN bfngetDataCliAsocGeClientes ***/

/*****************************************************************************/
/*                            funcion : vfnPrintHistDocu                     */
/*****************************************************************************/
static void vfnPrintHistDocu (HISTDOCU *pHis)
{
	char modulo[]   = "vfnPrintHistDocu";

	vDTrazasLog (modulo,"\n\t\t=> Valores a Insertar en FA_FACTDOCU_%ld\n"
                  "\t\t Num.Secuenci   [%ld]\n"
                  "\t\t Cod.TipDocum   [%d] \n"
                  "\t\t Cod.VendedorAg.[%ld]\n"
                  "\t\t Letra          [%s] \n"
                  "\t\t Cod.CentrEmi   [%d] \n"
                  "\t\t Tot.Pagar      [%f] \n"
                  "\t\t Tot.Cargos Mes [%f] \n"
                  "\t\t Tot.Factura    [%f] \n"
                  "\t\t Tot.Cuotas     [%f] \n"
                  "\t\t Cod.Vendedor   [%ld]\n"
                  "\t\t Cod.Cliente    [%ld]\n"
                  "\t\t Fec.Emision    [%s] \n"
                  "\t\t Nom.UsuarOra   [%s] \n"
                  "\t\t Acum.NetoGrav  [%f] \n"
                  "\t\t Acum.NetoNoGrav[%f] \n"
                  "\t\t Acum.Iva       [%f] \n"
                  "\t\t Ind.OrdenTotal [%s] \n"
                  "\t\t Ind.Factur     [%d] \n"
                  "\t\t Ind.SuperTel   [%d] \n"
                  "\t\t Num.Proceso    [%ld]\n"
                  "\t\t Num.CTC        [%s] \n"
                  "\t\t Fec.Vencimie   [%s] \n"
                  "\t\t Fec.Cadudidad  [%s] \n"
                  "\t\t Fec.ProxVenc   [%s] \n"
                  "\t\t Cod.CiclFact   [%ld]\n"
                  "\t\t Num.SecuRel    [%ld]\n"
                  "\t\t LetraRel       [%s] \n"
                  "\t\t Cod.TipoDocumRe[%d] \n"
                  "\t\t Cod.Vend.AgenRe[%ld]\n"
                  "\t\t Cod.CentrRel   [%d] \n"
                  "\t\t Num.Venta      [%ld]\n"
                  "\t\t Num.Transacc.  [%ld]\n"
                  "\t\t Imp.SaldoAnt   [%f] \n"
                  "\t\t Zona Impositiva[%d] \n"
                  "\t\t Prefijo Plaza  [%s] \n"
                  "\t\t Cod.Operadora  [%s] \n"
                  "\t\t Cod.Plaza      [%s] \n"
                  "\t\t CodMonedaImp.  [%s] \n"
                  "\t\t ImpConversion  [%f] \n",
                  LOG05,pHis->lCodCiclFact,
                  pHis->lNumSecuenci         ,
                  pHis->iCodTipDocum         ,
                  pHis->lCodVendedorAgente   ,
                  pHis->szLetra              ,
                  pHis->iCodCentrEmi         ,
                  pHis->dTotPagar            ,
                  pHis->dTotCargosMe         ,
                  pHis->dTotFactura          ,
                  pHis->dTotCuotas           ,
                  pHis->lCodVendedor         ,
                  pHis->lCodCliente          ,
                  pHis->szFecEmision         ,
                  pHis->szNomUsuarOra        ,
                  pHis->dAcumNetoGrav        ,
                  pHis->dAcumNetoNoGrav      ,
                  pHis->dAcumIva             ,
                  pHis->szIndOrdenTotal      ,
                  pHis->iIndFactur           ,
                  pHis->iIndSuperTel         ,
                  pHis->lNumProceso          ,
                  pHis->szNumCTC             ,
                  pHis->szFecVencimie        ,
                  pHis->szFecCaducida        ,
                  pHis->szFecProxVenc        ,
                  pHis->lCodCiclFact         ,
                  pHis->lNumSecuRel          ,
                  pHis->szLetraRel           ,
                  pHis->iCodTipDocumRel      ,
                  pHis->lCodVendedorAgenteRel,
                  pHis->iCodCentrRel         ,
                  pHis->lNumVenta            ,
                  pHis->lNumTransaccion      ,
                  pHis->dImpSaldoAnt         ,
                  pHis->iCodZonaImpo         ,
                  pHis->szPrefPlaza          ,
                  pHis->szCodOperadora       ,
                  pHis->szCodPlaza           ,
                  pHis->szhCodMonedaImp      ,
                  pHis->dhImpConversion
                  );

}/**************************** Final vfnPrintHistDocu ************************/

/*****************************************************************************/
/*                            funcion : vfnPrintProcesos                     */
/*****************************************************************************/
static void vfnPrintProcesos (PROCESO *pP)
{
	char modulo[]   = "vfnPrintProcesos";

	vDTrazasLog (modulo,"\n\t\t=> Valores en Registro Procesos \n"
						"\t\t iCodTipDocum 			 : [%d] \n"
						"\t\t lCodVendedorAgente     : [%ld] \n"
						"\t\t iCodCentrEmi           : [%d] \n"
						"\t\t lNumSecuAg             : [%ld] \n"
						"\t\t iCodTipDocNot          : [%d] \n"
						"\t\t lCodVendedorAgenteNot  : [%ld] \n"
						"\t\t iCodCentrNot           : [%d] \n"
						"\t\t lNumSecuNot            : [%ld] \n"
						"\t\t iIndEstado             : [%d] \n"
						"\t\t lCodCiclFact           : [%ld] \n"
						"\t\t iIndNotaCredC          : [%d] \n"
						"\t\t szFecEfectividad       : [%s] \n"
						"\t\t szNomUsuarOra          : [%s] \n"
						"\t\t szLetraAg              : [%s] \n"
						"\t\t szLetraNot             : [%s] \n",
						LOG05,
						pP->iCodTipDocum,
						pP->lCodVendedorAgente,
						pP->iCodCentrEmi,
						pP->lNumSecuAg,
						pP->iCodTipDocNot,
						pP->lCodVendedorAgenteNot,
						pP->iCodCentrNot,
						pP->lNumSecuNot,
						pP->iIndEstado,
						pP->lCodCiclFact,
						pP->iIndNotaCredC,
						pP->szFecEfectividad,
						pP->szNomUsuarOra,
						pP->szLetraAg,
						pP->szLetraNot);

} /*** FIN vfnPrintProcesos ***/

/*****************************************************************************/
/*                            funcion : vPrintCliente                     */
/*****************************************************************************/
static void vPrintCliente (CLIENTE *pClie)
{
	char modulo[]   = "vPrintCliente";

	vDTrazasLog (modulo,"\n\t Valores en Registro Cliente : \n"
						"\t\t lCodCliente     [%ld] \n"
						"\t\t szNomCliente    [%s] \n"
						"\t\t lCodPlanCom     [%ld] \n"
						"\t\t szNomApeClien1  [%s] \n"
						"\t\t szNomApeClien2  [%s] \n"
						"\t\t szTefCliente1   [%s] \n"
						"\t\t szTefCliente2   [%s] \n"
						"\t\t iCodActividad   [%d] \n"
						"\t\t szNomCalle      [%s] \n"
						"\t\t szNumCalle      [%s] \n"
						"\t\t szNumPiso       [%s] \n"
						"\t\t szDesComuna     [%s] \n"
						"\t\t szDesCiudad     [%s] \n"
						"\t\t szCodPais       [%s] \n"
						"\t\t szIndDebito     [%s] \n"
						"\t\t dImpStopDebit   [%.4f] \n"
						"\t\t szCodBanco      [%s] \n"
						"\t\t szCodSucursal   [%s] \n"
						"\t\t szIndTipCuenta  [%s] \n"
						"\t\t szCodTipTarjeta [%s] \n"
						"\t\t szNumCtaCorr    [%s] \n"
						"\t\t szNumTarjeta    [%s] \n"
						"\t\t szFecVenciTarj  [%s] \n"
						"\t\t szCodBancoTarj  [%s] \n"
						"\t\t szCodTipIdTrib  [%s] \n"
						"\t\t szNumIdentTrib  [%s] \n"
						"\t\t szNumFax        [%s] \n"
						"\t\t szCodIdioma     [%s] \n"
						"\t\t szGls_DirecClie [%s] \n"
						"\t\t iCodCatImpos    [%d] \n",
						LOG05,
						pClie->lCodCliente,
						pClie->szNomCliente,
						pClie->lCodPlanCom,
						pClie->szNomApeClien1,
						pClie->szNomApeClien2,
						pClie->szTefCliente1,
						pClie->szTefCliente2,
						pClie->iCodActividad,
						pClie->szNomCalle,
						pClie->szNumCalle,
						pClie->szNumPiso,
						pClie->szDesComuna,
						pClie->szDesCiudad,
						pClie->szCodPais,
						pClie->szIndDebito,
						pClie->dImpStopDebit,
						pClie->szCodBanco,
						pClie->szCodSucursal,
						pClie->szIndTipCuenta,
						pClie->szCodTipTarjeta,
						pClie->szNumCtaCorr,
						pClie->szNumTarjeta,
						pClie->szFecVenciTarj,
						pClie->szCodBancoTarj,
						pClie->szCodTipIdTrib,
						pClie->szNumIdentTrib,
						pClie->szNumFax,
						pClie->szCodIdioma,
						pClie->szGls_DirecClie,
						pClie->iCodCatImpos);

} /*** FIN vPrintCliente ***/

/*****************************************************************************/
/*                            funcion : vfnPrintAbonado0                     */
/*****************************************************************************/
static void vfnPrintAbonado0 (HISTABO *pHa)
{
	char modulo[]   = "vfnPrintAbonado0";

	vDTrazasLog (modulo,"\n\t Valores en Registro Abonado 0 : \n"
						"\t\t iCodProducto    [%d] \n"
						"\t\t szIndOrdenTotal [%s] \n"
						"\t\t lNumAbonado     [%ld] \n"
						"\t\t lCodCliente     [%ld] \n"
						"\t\t dTotCargosMe    [%.4f] \n"
						"\t\t dAcumCargo      [%.4f] \n"
						"\t\t dAcumIva        [%.4f] \n"
						"\t\t dAcumDto        [%.4f] \n"
						"\t\t szNumTerminal   [%s] \n"
						"\t\t lCapCode        [%ld] \n"
						"\t\t iCodDetFact     [%d] \n"
						"\t\t szFecFinContra  [%s] \n"
						"\t\t iIndFactur      [%d] \n"
						"\t\t iCodCredMor     [%d] \n"
						"\t\t lCodGrupo       [%ld] \n"
						"\t\t szNomUsuario    [%s] \n"
						"\t\t szNomApellido1  [%s] \n"
						"\t\t szNomApellido2  [%s] \n"
						"\t\t szCodPlanTarif  [%s] \n"
						"\t\t dLimCredito     [%.4f] \n"
						"\t\t iIndSuperTel    [%d] \n"
						"\t\t szNumTeleFija   [%s] \n",
						LOG05,
						pHa->iCodProducto,
						pHa->szIndOrdenTotal,
						pHa->lNumAbonado,
						pHa->lCodCliente,
						pHa->dTotCargosMe,
						pHa->dAcumCargo,
						pHa->dAcumIva,
						pHa->dAcumDto,
						pHa->szNumTerminal,
						pHa->lCapCode,
						pHa->iCodDetFact,
						pHa->szFecFinContra,
						pHa->iIndFactur,
						pHa->iCodCredMor,
						pHa->lCodGrupo,
						pHa->szNomUsuario,
						pHa->szNomApellido1,
						pHa->szNomApellido2,
						pHa->szCodPlanTarif,
						pHa->dLimCredito,
						pHa->iIndSuperTel,
						pHa->szNumTeleFija);

} /*** FIN vfnPrintAbonado0 ***/

static void vfnPrintDatosDobleCuenta(int iInd)
{
	char modulo[]   = "vfnPrintDatosDobleCuenta";

	vDTrazasLog (modulo,"\t Cliente - Abonado :\n"
						"\t\t Num Sec Detalle    [%d]\n"
						"\t\t Cliente Contrata   [%ld]\n"
						"\t\t Cliente Asociado   [%ld]\n"
						"\t\t Abonado Asociado   [%ld]\n"
						"\t\t Concepto Asociado  [%ld]\n"
						"\t\t Monto Asociado     [%.4f]\n"
						"\t\t Concepto Descuento [%ld]\n"
						"\t\t Concepto Destino   [%ld]\n"
						"\t\t Indice OrdenTotal  [%ld]\n"
						"\t\t Tipo Operacion     [%d]\n"
						"\t\t Tipo Modalidad     [%d]\n"
						"\t\t Tipo Valor         [%d]\n",
						LOG03,
						stDatosDobleCuenta[iInd].iNumSecDetalle,
						stDatosDobleCuenta[iInd].lCodCliContra,
						stDatosDobleCuenta[iInd].lCodCliAsoc,
						stDatosDobleCuenta[iInd].lCodAbonAsoc,
						stDatosDobleCuenta[iInd].lCodConcepto,
						stDatosDobleCuenta[iInd].lMontoConcAsoc,
						stDatosDobleCuenta[iInd].lCodConcDesc,
						stDatosDobleCuenta[iInd].lCodConcDest,
						stDatosDobleCuenta[iInd].lIndOrdenTotal,
						stDatosDobleCuenta[iInd].iTipOperacion,
						stDatosDobleCuenta[iInd].iTipModalidad,
						stDatosDobleCuenta[iInd].iTipValor);

} /*** FIN vfnPrintDatosDobleCuenta ***/

static void vfnPrintFaConcepto()
{
	char modulo[]   = "vfnPrintFaConcepto";

	vDTrazasLog  (modulo,"\n\t Detalle Fact Concepto : \n"
						"\t\t szIndOrdenTotal     : [%s] \n"
						"\t\t lCodConcepto        : [%ld] \n"
						"\t\t lColumna            : [%ld] \n"
						"\t\t szCodMoneda         : [%s] \n"
						"\t\t iCodProducto        : [%d] \n"
						"\t\t iCodTipConce        : [%d] \n"
						"\t\t szFecValor          : [%s] \n"
						"\t\t szFecEfectividad    : [%s] \n"
						"\t\t dImpConcepto        : [%.4f] \n"
						"\t\t szCodRegion         : [%s] \n"
						"\t\t szCodProvincia      : [%s] \n"
						"\t\t szCodCiudad         : [%s] \n"
						"\t\t dImpMontoBase       : [%.4f] \n"
						"\t\t iIndFactur          : [%d] \n"
						"\t\t dImpFacturable      : [%.4f] \n"
						"\t\t iIndSuperTel        : [%d] \n"
						"\t\t lNumAbonado         : [%ld] \n"
						"\t\t iCodPortador        : [%d] \n"
						"\t\t szDesConcepto       : [%s] \n"
						"\t\t lSegConsumido       : [%ld] \n"
						"\t\t lSeqCuotas          : [%ld] \n"
						"\t\t iNumCuotas          : [%d] \n"
						"\t\t iOrdCuota           : [%d] \n"
						"\t\t lNumUnidades        : [%ld] \n"
						"\t\t szNumSerieMec       : [%s] \n"
						"\t\t szNumSerieLe        : [%s] \n"
						"\t\t fPrcImpuesto        : [%.4f] \n"
						"\t\t dValDto             : [%.4f] \n"
						"\t\t iTipDto             : [%d] \n"
						"\t\t iMesGarantia        : [%d] \n"
						"\t\t szNumGuia           : [%s] \n"
						"\t\t iIndAlta            : [%d] \n"
						"\t\t iNumPaquete         : [%d] \n"
						"\t\t iFlagImpues         : [%d] \n"
						"\t\t iFlagDto            : [%d] \n"
						"\t\t iCodConceRel        : [%d] \n"
						"\t\t lColumnaRel         : [%ld] \n"
						"\t\t szCodPlanTarif      : [%s] \n"
						"\t\t szCodCargoBasico    : [%s] \n"
						"\t\t szTipPlanTarif      : [%s] \n"
						"\t\t dMtoReal            : [%.4f] \n"
						"\t\t dMtoDcto            : [%.4f] \n"
						"\t\t lDurReal            : [%ld] \n"
						"\t\t lDurDcto            : [%ld] \n"
						"\t\t lCntLlamReal        : [%ld] \n"
						"\t\t lCntLlamFact        : [%ld] \n"
						"\t\t lCntLlamDcto        : [%ld] \n"
						"\t\t dImpValunitario     : [%.4f] \n"
						"\t\t szGlsDescrip        : [%s] \n"
						"\t\t lNumVenta	          : [%ld] \n",
						LOG05,
						stFaConcepto.szIndOrdenTotal,
						stFaConcepto.lCodConcepto,
						stFaConcepto.lColumna,
						stFaConcepto.szCodMoneda,
						stFaConcepto.iCodProducto,
						stFaConcepto.iCodTipConce,
						stFaConcepto.szFecValor,
						stFaConcepto.szFecEfectividad,
						stFaConcepto.dImpConcepto,
						stFaConcepto.szCodRegion,
						stFaConcepto.szCodProvincia,
						stFaConcepto.szCodCiudad,
						stFaConcepto.dImpMontoBase,
						stFaConcepto.iIndFactur,
						stFaConcepto.dImpFacturable,
						stFaConcepto.iIndSuperTel,
						stFaConcepto.lNumAbonado,
						stFaConcepto.iCodPortador,
						stFaConcepto.szDesConcepto,
						stFaConcepto.lSegConsumido,
						stFaConcepto.lSeqCuotas,
						stFaConcepto.iNumCuotas,
						stFaConcepto.iOrdCuota,
						stFaConcepto.lNumUnidades,
						stFaConcepto.szNumSerieMec,
						stFaConcepto.szNumSerieLe,
						stFaConcepto.fPrcImpuesto,
						stFaConcepto.dValDto,
						stFaConcepto.iTipDto,
						stFaConcepto.iMesGarantia,
						stFaConcepto.szNumGuia,
						stFaConcepto.iIndAlta,
						stFaConcepto.iNumPaquete,
						stFaConcepto.iFlagImpues,
						stFaConcepto.iFlagDto,
						stFaConcepto.iCodConceRel,
						stFaConcepto.lColumnaRel,
						stFaConcepto.szCodPlanTarif,
						stFaConcepto.szCodCargoBasico,
						stFaConcepto.szTipPlanTarif,
						stFaConcepto.dMtoReal,
						stFaConcepto.dMtoDcto,
						stFaConcepto.lDurReal,
						stFaConcepto.lDurDcto,
						stFaConcepto.lCntLlamReal,
						stFaConcepto.lCntLlamFact,
						stFaConcepto.lCntLlamDcto,
						stFaConcepto.dImpValunitario,
						stFaConcepto.szGlsDescrip,
						stFaConcepto.lNumVenta);

} /*** FIN vfnPrintFaConcepto ***/

static void vfnPrintImpAbonado(IMPABONADO *pImpA)
{
	char modulo[]   = "vfnPrintImpAbonado";

	vDTrazasLog  (modulo,"\n\t Totales Abonado : \n"
						"\t\t tot Cargos Mes   : [%.4f] \n"
						"\t\t Acum Cargo       : [%.4f] \n"
						"\t\t Acum Descuento   : [%.4f] \n"
						"\t\t Acum Impuesto    : [%.4f] \n",
						LOG05,
						pImpA->dTotCargosMe,
						pImpA->dAcumCargo,
						pImpA->dAcumDto,
						pImpA->dAcumIva);

} /*** FIN vfnPrintImpAbonado ***/

static void vfnPrintCliCicloCli(FACICLOCLI *pstCCli)
{
 	char modulo[]   = "vfnPrintCliCicloCli";

	vDTrazasLog (modulo,"\t Cliente FA_CICLOCLI :\n"
						"\t\t Cod Cliente   : [%ld] \n"
						"\t\t Cod Ciclo     : [%d] \n"
						"\t\t Cod Producto  : [%d] \n"
						"\t\t Num Abonado   : [%ld] \n"
						"\t\t Num Proceso   : [%ld] \n"
						"\t\t Cod CalClien  : [%s] \n"
						"\t\t Ind Cambio    : [%d] \n"
						"\t\t Nom Usuario   : [%s] \n"
						"\t\t Nom Apell 1   : [%s] \n"
						"\t\t Nom Apell 2   : [%s] \n"
						"\t\t Cod CredMor   : [%d] \n"
						"\t\t Ind Debito    : [%s] \n"
						"\t\t Cod CicloNue  : [%d] \n"
						"\t\t Fec Alta      : [%s] \n"
						"\t\t Num Terminal  : [%ld] \n"
						"\t\t Fec UltFact   : [%s] \n"
						"\t\t Ind Mascara   : [%d] \n"
						"\t\t Cod Despacho  : [%s] \n"
						"\t\t Cod Prioridad : [%d] \n",
						LOG03,
						pstCCli->lCodCliente,
						pstCCli->iCodCiclo,
						pstCCli->iCodProducto,
						pstCCli->lNumAbonado,
						pstCCli->lNumProceso,
						pstCCli->szCodCalClien,
						pstCCli->iIndCambio,
						pstCCli->szNomUsuario,
						pstCCli->szNomApellido1,
						pstCCli->szNomApellido2,
						pstCCli->iCodCredMor,
						pstCCli->szIndDebito,
						pstCCli->iCodCicloNue,
						pstCCli->szFecAlta,
						pstCCli->lNumTerminal,
						pstCCli->szFecUltFact,
						pstCCli->iIndMascara,
						pstCCli->szCodDespacho,
						pstCCli->iCodPrioridad);

 }
/*******************************************************************************/

BOOL bfnExecuteQuery(char *szCadenaSQL)
{
	char modulo[]   = "bfnExecuteQuery";

	vDTrazasLog ( modulo,"\n\t Query for sql_select_Columna \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_query_dinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1529;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )0;
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


	if (SQLCODE)
 	{
	    vDTrazasError(modulo, " en PREPARE sql_query_dinamica  [%s]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en PREPARE sql_query_dinamica  [%s]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL EXECUTE sql_query_dinamica; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1548;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


	if (SQLCODE != SQLOK)
 	{
	    vDTrazasError(modulo, " en  EXECUTE sql_query_dinamica  [%s]",LOG01, SQLERRM);
	    vDTrazasLog  (modulo, " en  EXECUTE sql_query_dinamica  [%s]",LOG01, SQLERRM);
	    return FALSE;
	}

	return (TRUE);

} /**** FIN bfnExecuteQuery ***/

BOOL bfnOpenCursorQuery(char *szCadenaSQL)
{
	char modulo[]   = "bfnOpenCursorQuery";

	vDTrazasLog ( modulo,"\n\t Query for SQL CURSOR \n\t [%s]\n"
                         ,LOG05, alltrim(szCadenaSQL));

	/* EXEC SQL PREPARE sql_query_dinamica FROM :szCadenaSQL; */ 

{
 struct sqlexd sqlstm;
 sqlstm.sqlvsn = 12;
 sqlstm.arrsiz = 13;
 sqlstm.sqladtp = &sqladt;
 sqlstm.sqltdsp = &sqltds;
 sqlstm.stmt = "";
 sqlstm.iters = (unsigned int  )1;
 sqlstm.offset = (unsigned int  )1563;
 sqlstm.cud = sqlcud0;
 sqlstm.sqlest = (unsigned char  *)&sqlca;
 sqlstm.sqlety = (unsigned short)256;
 sqlstm.occurs = (unsigned int  )0;
 sqlstm.sqhstv[0] = (unsigned char  *)szCadenaSQL;
 sqlstm.sqhstl[0] = (unsigned long )0;
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


	if (SQLCODE)
 	{
	    vDTrazasLog(modulo, "ERROR : PREPARE sql_query_dinamica  [%s ]",LOG01, SQLERRM);
	    vDTrazasError(modulo, "ERROR : PREPARE sql_query_dinamica  [%s ]",LOG01, SQLERRM);
	    return FALSE;
	}

	/* EXEC SQL DECLARE sql_Cursor_dinamico CURSOR FOR sql_query_dinamica; */ 

	if (SQLCODE) {
		vDTrazasError(modulo," en DECLARE del Cursor  sql_Cursor_dinamico \n\t[%d]",LOG01,SQLCODE);
		vDTrazasLog  (modulo," en DECLARE del Cursor  sql_Cursor_dinamico \n\t[%d]",LOG01,SQLCODE);
	    return FALSE;
	}

    /* EXEC SQL OPEN sql_Cursor_dinamico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.stmt = "";
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1582;
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
        vDTrazasError(modulo, " en OPEN sql_Cursor_dinamico [%s]",LOG01,SQLERRM);
        vDTrazasLog  (modulo, " en OPEN sql_Cursor_dinamico [%s]",LOG01,SQLERRM);
        return (FALSE);
    }

	return (TRUE);

} /**** FIN bfnOpenCursorQuery ***/

BOOL bfnCloseCursorQuery()
{
	char modulo[]   = "bfnCloseCursorQuery";

    /* EXEC SQL CLOSE sql_Cursor_dinamico; */ 

{
    struct sqlexd sqlstm;
    sqlstm.sqlvsn = 12;
    sqlstm.arrsiz = 13;
    sqlstm.sqladtp = &sqladt;
    sqlstm.sqltdsp = &sqltds;
    sqlstm.iters = (unsigned int  )1;
    sqlstm.offset = (unsigned int  )1597;
    sqlstm.cud = sqlcud0;
    sqlstm.sqlest = (unsigned char  *)&sqlca;
    sqlstm.sqlety = (unsigned short)256;
    sqlstm.occurs = (unsigned int  )0;
    sqlcxt((void **)0, &sqlctx, &sqlstm, &sqlfpn);
}


    if ( SQLCODE != SQLOK )
    {
        vDTrazasLog  (modulo," en CLOSE sql_Cursor_dinamico : %d  %s **",LOG01,SQLCODE,SQLERRM);
        vDTrazasError(modulo," en CLOSE sql_Cursor_dinamico  : %d  %s **",LOG01,SQLCODE,SQLERRM);
        return (FALSE);
    }

	return (TRUE);

} /**** FIN bfnCloseCursorQuery ***/
