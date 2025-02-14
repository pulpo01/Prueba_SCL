
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
    "./pc/facturAux.pc"
};


static unsigned int sqlctx = 6893259;


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
   unsigned char  *sqhstv[1];
   unsigned long  sqhstl[1];
            int   sqhsts[1];
            short *sqindv[1];
            int   sqinds[1];
   unsigned long  sqharm[1];
   unsigned long  *sqharc[1];
   unsigned short  sqadto[1];
   unsigned short  sqtdso[1];
} sqlstm = {12,1};

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
};


/****************************************************************************/
/* Fichero    : facturAux.c                                                 */
/* Descripcion: fichero de funciones auxiliares al ejecutable de factura    */
/* Fecha      : 02-04-1997                                                  */
/* Autor      : Javier Garcia Paredes                                       */
/****************************************************************************/
#define _FACTURA_C_

#include <factura.h>

/* ------------------------------------------------------------------------- */
/*   bExitInstance (void)                                                    */
/*     Libera tabla anomalias, cierra fichero de log, desconcexion oracle    */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */
BOOL bExitInstance (void)
{
 /* Desconexion Oracle */
 if (!bfnDisconnectORA (0))
 {
    iDError (szExeName,ERR000,vInsertarIncidencia,"Desconexion",szfnORAerror());
    return FALSE;
 }
 stStatus.OraConnected = FALSE;
 vDatosFinTiempo ()           ;

 vDTrazasLog (szExeName,"\n\t*** Desconexion a Oracle ***\n"
                        "\t*** Informacion Tiempos Proceso (Segundos) ***"
                        ,LOG03);
 if (stStatus.lNumReg > 0)
 {
     vDTrazasLog (szExeName,"\t=> Tiempo CPU           : [%f] \n"
                            "\t=> Tiempo Real          : [%f] \n"
                            "\t=> Tiempo Real x Cliente: [%f] \n"
                            "\t=> Tiempo Cpu  x Cliente: [%f] \n"
                            "\t=> Clientes Procesados  : [%ld]\n",LOG03,
                            cpu,real,real/(float)stStatus.lNumReg,
                            cpu/(float)stStatus.lNumReg,stStatus.lNumReg);
 }
 else
 {
     vDTrazasLog (szExeName,"\t=> Tiempo CPU  : [%f]\n"
                            "\t=> Tiempo Real : [%f]\n",LOG03,
                            cpu,real);
 }
 /* Cerrar Fichero de Log */
 if (!bCloseLog ())
      return FALSE;
 if (!bCloseError ())
      return FALSE;

 return TRUE;
}/***************************** Final bExitInstance **************************/

/* ------------------------------------------------------------------------- */
/*   sigterm (int)                                                           */
/* ------------------------------------------------------------------------- */
void sigterm(int sig)
{
}

/*****************************************************************************/
/*                         funcion : vInitConfig                             */
/* -Funcion que Inicializa la estructura de entrada stConfig                 */
/*****************************************************************************/
void vInitConfig (void)
{
  memset (&stConfig,0,sizeof (CONFIG));

  strcpy (stConfig.szUsuario ,"");
  strcpy (stConfig.szPassWord,"");

  stConfig.lCodCliente     = -1;
  stConfig.lNumTransaccion = -1;
  stConfig.lNumVenta       = -1;
  stConfig.iTipoFactura    = -1;
  stConfig.lCodCiclFact    = -1;
  stConfig.lNumAbonado     = -1;
  stConfig.lNumAlquiler    = -1;
  stConfig.lNumEstaDia     = -1;
  stConfig.iCodProducto    = -1;

  stConfig.bOptPreBilling  = FALSE;
  stConfig.bOptComposicion = FALSE;
  stConfig.bOptCliente     = FALSE;
  stConfig.bOptUsuario     = FALSE;
  stConfig.bOptNumVenta    = FALSE;
  stConfig.bOptTransaccion = FALSE;
  stConfig.bOptNumProceso  = FALSE;
  stConfig.bOptSizeLog     = FALSE;
  stConfig.bOptCiclFact    = FALSE;
  stConfig.bOptMiscelanea  = FALSE;
  stConfig.bOptRentPhone   = FALSE;
  stConfig.bOptRoamingVis  = FALSE;
  stConfig.bOptCompra      = FALSE;
  stConfig.bOptBaja        = FALSE;
  stConfig.bOptAbonado     = FALSE;
  stConfig.bOptProducto    = FALSE;
  stConfig.bOptLiquidacion = FALSE;
  stConfig.bOptContado     = FALSE;
  stConfig.bOptCiclo       = FALSE;

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

  stConfig.bOptMemShared   = FALSE;

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

  stConfig.bOptNumAlquiler = FALSE;
  stConfig.bOptNumEstaDia  = FALSE;


}/************************** Final vInitConfig *******************************/

/* ------------------------------------------------------------------------- */
/*   bInitInstance (int)                                                     */
/*      Establece Conexion Oracle. Abre fichero de log. Toma un numero de    */
/*      proceso.                                                             */
/*      Valores Retorno: FALSE - Error                                       */
/*                       TRUE  - Ningun Error                                */
/* ------------------------------------------------------------------------- */

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

/*BOOL bInitInstance (int iTipoFact)
{
 int iRet = 0;
 int iPid = 0;

 vDatosInicialesTiempo();

 if (iTipoFact == FACT_CICLO)*/

BOOL bInitInstance (int iTipoFact, BOOL MemShared)
{
	int iPid = 0;
	char 	szHostID  [21]="";

	vDatosInicialesTiempo();

	/* ************FAR************/
	memset(stStatus.szBuffLog,0,sizeof(stStatus.szBuffLog));
	stStatus.szBuffLog[0]='\0';

	if (iTipoFact == FACT_CICLO && MemShared==FALSE)

/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/

	{
		iPid = fork ();
		fprintf(stdout, "\n\t\t***** iPid = fork ();==> [%d]\n", iPid);
		switch (iPid)
		{
		  case -1 :
		            fprintf (stdout, "\n=> Error Llamada fork");
		            return  (3)                                ;
		  case  0 :
		            fprintf (stdout, "\n\t\t=> Arranca Hijo\n");
		            break                                      ;
		  default :
		            fprintf(stdout, "\n\t\t=> Matando Proceso Padre : Pid [%d]\n",
		                    iPid);
		            exit (0)     ;
		}
	}
 /* Conexion Oracle */
	if (!bfnConnectORA (stConfig.szUsuario,stConfig.szPassWord))
	{
		vDTrazasError ( "bfnConnectORA","\n%s\n",LOG01,szfnORAerror());
		stStatus.ExitApp = TRUE;
		return FALSE;
	}

	stStatus.OraConnected=1;


	if (!bGetDatosGener (&stDatosGener,szSysDate))
    	return FALSE;
	if (stConfig.iTipoFactura == FACT_CICLO || stConfig.iTipoFactura == FACT_BAJA)
	{
		memset (&stCiclo,0,sizeof (CICLO));

		stCiclo.lCodCiclFact = stConfig.lCodCiclFact;
		if (!bFindCiclFact (&stCiclo))
			return FALSE;
		if (stConfig.iTipoFactura == FACT_CICLO)
		{
			if (ifnGetHostId (szHostID))
			{
				vDTrazasLog (szExeName,"\n\t\t=> Validando ejecucion por Host [%s]",LOG03, szHostID);
			}
			if (!bActualizaIndFacCiclo (stCiclo.lCodCiclFact,1, szHostID, 0, 0L, 0L))
			{
				iDError (szExeName,ERR000,vInsertarIncidencia, "Error Actualizando Ciclo (bActualizaIndFacCiclo en bInitInstance)","Procesos no se puede lanzar");
				return FALSE;
			}
		}
	}
	else
		stCiclo.lCodCiclFact = -1;

	/* Si no se Lanza PreBilling el Numero de Proceso debe ser Parametro de entrada del Proceso de Facturacion */

	if (stConfig.bOptPreBilling)
	{
    	if (stConfig.iTipoFactura == FACT_CICLO)
      	{
        	if (!bGetUltimoCliPro (  stCiclo.iCodCiclo,      stConfig.lCodCiclFact, stConfig.iTipoFactura,
                                  &stCliente.lCodCliente, &stConfig.lNumProceso))
            	return FALSE;

      	}
      	if (stConfig.lNumProceso <= 0)
      	{
        	if (!bGetNumProceso(&stStatus.IdPro))
            	return FALSE;
      	}
      	else
        	stStatus.IdPro = stConfig.lNumProceso;
	}
	else
    	stStatus.IdPro = stConfig.lNumProceso;

 /****************************************************************************/
 /*   Abre Fichero de Log con stStatus.LogName :                             */
 /*   Abre Fichero de Err con stStatus.ErrName :                             */
 /*  -Si iTipoFact in (FACT_CONTADO,FACT_LIQUIDACION)=>stDatosGener.szDirLogs*/
 /*  -En otro caso=>stCiclFact.szDirLogs                                     */
 /****************************************************************************/
 	vEligeDirLogs (stStatus.LogName,stStatus.ErrName,stConfig.iTipoFactura);

	unlink (stStatus.LogName);
	unlink (stStatus.ErrName);

 	if (!bOpenError (stStatus.ErrName))
 	{
    	vDTrazasError (szExeName, "No se puede Abrir el fichero %s",LOG03,stStatus.ErrName);
      	return FALSE;
 	}
 	if (!bOpenLog (stStatus.LogName))
 	{
    	vDTrazasError (szExeName, "No se puede Abrir el fichero %s",LOG03,stStatus.LogName);
      	return FALSE;
 	}

	vDTrazasLog (szExeName,
	"\n     *********************************************************************"
	"\n                 FacturaC version " __DATE__ " " __TIME__ " TMGE. MC", LOG03);
	vDTrazasError (szExeName,
	"\n     *********************************************************************"
	"\n                 FacturaC version " __DATE__ " " __TIME__ " TMGE. MC",LOG03);

 	if (stConfig.bOptPreBilling)
 	{
 		vDTrazasLog (szExeName,
 		"\n     *********************************************************************"\
 		"\n     *                          PREBILLING                               *"\
 		"\n     *********************************************************************",
 		LOG03);
 		vDTrazasError (szExeName,
 		"\n     *********************************************************************"
 		"\n     *                           PREBILLING                              *"
 		"\n     *********************************************************************",
 		LOG03);
 	}
	vDTrazasLog (szExeName,"\n\t*** Conexion a Oracle ***\n",LOG03);

	vPrintDatosGener ();
	vPrintCiclFact (pstCiclFact,NUM_CICLFACT);

	vInitProceso (&stProceso);

	/******************************************************************/
	/* Devuelve el control al terminal, se ejecuta en modo background */
	/******************************************************************/

/*************************************************************************
	INI MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
	if (iTipoFact == FACT_CICLO && MemShared==FALSE)
/*************************************************************************
	FIN MODIFICACION THALES-IS MC MAYO 2004
*************************************************************************/
	{
		close (0); close (1); close (2);
		dup   (0); dup   (1); dup   (2);
	}
 	return TRUE;

}/******************** Final bInitInstance ***********************************/

/****************************************************************************/
/*                      funcion : vInitProceso                              */
/* -Funcion que inicializa la estructura stProceso con los parametros de en-*/
/*  trada.                                                                  */
/****************************************************************************/
void vInitProceso (PROCESO *pProceso)
{
	memset (pProceso,0,sizeof(PROCESO))          ;

	pProceso->lNumProceso = stStatus.IdPro       ;
	pProceso->lCodCiclFact= stConfig.lCodCiclFact;

	strcpy (pProceso->szNomUsuarOra,stConfig.szUsuario);
}/*********************** Final vInitProceso ********************************/

/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  CORE/FUENTES_UNIX/FyC/Facturacion/facturacion/src/factura/pc/facturAux.pc */
/** Identificador en PVCS                               : */
/**  SCL:A5766.A-UNIX;des#5 */
/** Producto                                            : */
/**  SCL */
/** Revisión                                            : */
/**  des#5 */
/** Autor de la Revisión                                : */
/**  MWN70059 */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  CERTIFICADO */
/** Fecha de Creación de la Revisión                    : */
/**  22-OCT-2004 12:59:08 */
/** Worksets ******************************************************************************/
/** 1:																	*/
/** 	Workset:     "$GENERIC:$GLOBAL"                                                                                                 */
/** 	Description: Global workset for database                                                                                        */
/**                                                                                                                                     */
/** 2:                                                                                                                                  */
/** 	Workset:     "SCL:WS/D"                                                                                                         */
/** 	Description: Workset de Desarrollo                                                                                              */
/**                                                                                                                                     */
/** 3:                                                                                                                                  */
/** 	Workset:     "SCL:WS/ADEC-TMM-OLD"                                                                                              */
/** 	Description: (10M)Proyecto  Mejoras al proceso de Interfaz con Centrales                                                        */
/**                                                                                                                                     */
/** 4:                                                                                                                                  */
/** 	Workset:     "SCL:WS/ADEC-TMM"                                                                                                  */
/** 	Description: Work Set WS/ADEC-TMM1.AAAA                                                                                         */
/**                                                                                                                                     */
/** 5:                                                                                                                                  */
/** 	Workset:     "SCL:WS/D-P-TMM-03075"                                                                                             */
/** 	Description: P-TMM-03075 Evolución de Factura miscelánea (Facturación en Dólares e incorporación de unidad en los conceptos)    */
/**                                                                                                                                     */
/** Historia ******************************************************************************/
/** Revision des_tmc#2 (CERTIFICADO)                                                                                                    */
/**   Created:  01-nov-2004 18:26:09      MWT00175                                                                                      */
/**     Se agrega fecha-version. XC-200410290315                                                                                        */
/**                                                                                                                                     */
/** Revision des#5 (CERTIFICADO)                                                                                                        */
/**   Created:  22-oct-2004 12:59:07      MWN70059                                                                                      */
/**     Proyecto Contabilizaci n CDMA por Tecnolog a -  FT_TMM-50127                                                                    */
/**                                                                                                                                     */
/** Revision libdes_tmm#1 (CERTIFICADO)                                                                                                 */
/**   Created:  21-oct-2004 20:38:44      MWN70187                                                                                      */
/**     Proyecto TMM-04026 Contabilizacion CDMA por Tecnolog a y                                                                        */
/**     facturaci n ciclo por abonado - certificado en TMM                                                                              */
/**                                                                                                                                     */
/** Revision des_tmc#1 (CERTIFICADO)                                                                                                    */
/**   Created:  08-oct-2004 17:56:57      MWN70059                                                                                      */
/**     Proyecto Post Bucerias TMC_04046.                                                                                               */
/**                                                                                                                                     */
/** Revision des#4 (CERTIFICADO)                                                                                                        */
/**   Created:  20-jul-2004 18:43:58      MWN70059                                                                                      */
/**     Proyecto Memoria Compartida                                                                                                     */
/**                                                                                                                                     */
/** Revision des#3 (CERTIFICADO)                                                                                                        */
/**   Created:  22-mar-2004 09:58:14      MWN70059                                                                                      */
/**     Pieza proyecto Homologacisn Linea Evolutiva.                                                                                    */
/**                                                                                                                                     */
/** Revision des#2 (CERTIFICADO)                                                                                                        */
/**   Created:  29-oct-2003 09:23:40      MWN70294                                                                                      */
/**     Sellado con Version Stamping                                                                                                    */
/**                                                                                                                                     */
/** Revision des#1 (CERTIFICADO)                                                                                                        */
/**   Created:  24-sep-2003 17:38:24      MWN70252                                                                                      */
/**     Initial Revision                                                                                                                */
/******************************************************************************************/

