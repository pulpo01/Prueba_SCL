/*
	MorDistri.h : Morosos por Distribuidores.  Basado en Gen_Masters.h
*/

#ifndef _MASTERS_H_
	#define _MASTERS_H_
	#include <stdarg.h>
	#include <GenFA.h>
	#include <math.h>
#endif

/************************************************************************/
/*   Definiendo Constantes Enteras y de Caracter                        */
/************************************************************************/
#define iLOGNIVEL_DEF 	3

static char szUsage[]=
"\n\t Uso: MorDistri opciones"
"\n"
"\n\t opciones:"
"\n"
"\n\t\t -h Muestra esta Ayuda sin ejecutar el programa \n"
"\n\t\t -u 'Usuario/Password' o '/' 				(Opcional)  Default : '-u /' "
"\n\t\t -l  Nivel Log               				(Opcional)  Default : LOG03	 "
"\n";

#define	iNum	10000 /* Numero de Registros que escribiremos a la vez*/
/***************************************************************************************************/
#define SIZE_HOSTARRAY 10000

typedef	struct REG_SUSPENDIDOS
{
	long    lCodEvento			[SIZE_HOSTARRAY]		;
	long	lNumAbonado			[SIZE_HOSTARRAY]		;
	long	lCodCliente			[SIZE_HOSTARRAY]		;
	 int    iCodProducto		[SIZE_HOSTARRAY]		;
	char    szFechaAlta			[SIZE_HOSTARRAY] [15]   ;
  double	dImporteDeuda		[SIZE_HOSTARRAY]		;
    char    szCodEstado			[SIZE_HOSTARRAY] [3]	;
    char    szFecHistorico      [SIZE_HOSTARRAY] [15]   ;
    char    szCodEstadoHist     [SIZE_HOSTARRAY] [3]	;
}rg_suspendidos;

typedef	struct DatosAbo
{
	long lCodCuenta			;
	long lNumCelular		;
	char szFecContrato	 [9];
	char szNumContrato	[20];
	long lCodVendedor		;
	char szVendedor		[41];
	char szCodOficina    [3];
	char szOficina		[41];
	char szCanalVenta	 [3];
} DATOSABONAD;


typedef	struct DatosCli
{
		char szDV [2]			;
		char szRut[12]			;
		char szNombre[36]		;
/*		char szFonoContacto[13]	;*/
		 int iCiclo				;
		char szCodBanco[4]      ; 
		 int iCodDireccion		;
		char szRegion[31]		;
		char szProvincia[31]	;
		char szCodCiudad[6]		;
		char szCiudad[16]		;
		char szCodComuna[6]		;
		char szComuna[16]		;
		char szCalle[17]		;
		char szNumCalle[7]		;
		char szCasilla[16]		;
} DATOSCLIENT;

typedef	struct DocsPendientes
{
     	 int iCodDocum			;
      	long lNumFolio			; 
      	char szNumCTC[12]		;
       float fImporte			;
      	char szFecVencimie[9]	;
      	char szFecEmision[9]	;
} DOCSPENDVENC;

/***************************************************************************************************/



/**********************************************
Estructura con los Path de los archivos 
**********************************************/
typedef struct PathArch
{
	char     szPathLog          [255];
	FILE*    ArchLog                 ;	 
	char     szPathCtlMorosos   [255];
	FILE*    ArchCtlMorosos          ;
	char     szPathMorosos      [255];
	FILE*    ArchMorosos             ;
}PATHARCH; 

/********************************************************************/
/*   Estructura para recoger los datos por la linea de comandos.    */  
/********************************************************************/
typedef struct LineaComando
{
    char    szUsuarioOra [64] ;
    char    szOraAccount [32] ;
    char    szOraPasswd  [32] ;
     int    iLogLevel         ;
}LINEACOMANDO;

/********************************************************
Estructura que guarda datos de Morosos
********************************************************/
typedef struct ArchMorosos
{
	   int	iCodDocum			; /* co_cartera  ihCodTipDocum (Boleta/Factura) de cada Documento */
	  long	lCodCuenta			; /* ga_abocel */
	  long  lCodCliente 		; /* co_abonadoevento */
	  long  lNumAbonado 		; /* co_abondoevento */
	  char  szNombre		[36]; /* ge_clientes */
	  char	szCodBanco       [4]; /* (si el cliente es PAC) */
	   int  iCodDireccion       ; /* ga_direccli (3:correspondencia) */
	  char  szRegion 		[31]; /* ge_regiones*/
	  char  szProvincia 	[31]; /* ge_provincias */
	  char  szCodCiudad		 [6]; /* ge_ciudades */
	  char  szCiudad		[16]; /* ge_ciudades */
	  char  szCodComuna      [6]; /* ge_comunas */
	  char  szComuna		[16]; /* ge_comunas */
 	  char  szCalle			[17]; /* ge_direcciones */
	  char  szNumCalle		 [7]; /* ge_direcciones */
	  char  szCasilla        [6]; /* ge_direcciones */
	  long	lNumCelular    		; /* ga_abocel */
	   int	iCiclo              ; /* ge_clientes */
	  char  szCodOficina	 [3]; /* ga_ventas*/
	  char  szOficina		[41]; /* ge_oficinas */
	  char	szFecEmision     [9]; /* co_cartera (por cada documento del cliente) */
	  char	szFecVencimie    [9]; /* co_cartera (por cada docuemnto del cliente) */ 
	  long	lNumFolio           ; /* co_cartera (por cada documento del cliente) */
     float  fImporte            ; /* co_cartera (por cada documento del cliente) ¿deuda? */	  
	  long  lCodEvento			; /* co_abonadoevento */
	  long  lCodVendedor		; /* ga_abocel */
	  char  szVendedor		[41]; /* ve_vendedores */
	  char  szNumContrato 	[20]; /* ga_abocel */
	  char  szFecContrato 	 [9]; /* ga_abocel (fec_alta) */
	  char  szFecEnganche    [9]; /* idem szFecContrato */
	  char  szNumCTC		[12]; /* co_cartera (NumFolioCtc) */
     /*	      CORTE 			; */ /* ? */
	 /*       PERIODO           ; */ /* ? */
       int	iNegocio		    ; /* co_abonadoevento (cod_producto) */
	  char  szRut			[12]; /* ge_clientes */
	  char  szDV			 [2]; /* ge_clientes */
	  char	szEstadoCob      [3]; /* co_abonadoevento (cod_estado) */
	/*		 FecVence			; */ /* ? */
	/*		 Vence				; */ /* ? */
	/*		 GranCli			; */ /* ? */
	/*		 Ejecutivo			; */ /* ? */
	  char  szCanalVenta	 [3]; /* ga_ventas (cod_tipcomis) */
	  BOOL  bfinal				; /* indice de impresion (mio) */
}ARCHMOROSOS;

#undef access 
#ifdef _MASTERS_PC_
	#define access
#else
	#define access extern
#endif
access BOOL bfnValidaParametros();
access BOOL bfnIniciarProceso();
access BOOL bfnObtieneFechas();
access BOOL bfnProcesaSuspendidos();
access BOOL bfnVerificaCondiciones();
access BOOL bfnGetDatosDireccionCliente();
access void vfnLimpiaStArchMorosos();
access BOOL bfnInsArchMorosos();
access BOOL bfnObtieneDocumentos();
access void vfnLog();
/*access  int ifnLlenarStMorosos();*/
access char *szGetTime(int fmto);

/* Marcelo Quiroz  */
/* Fecha Actualizacion : 30-12-2002 */
access BOOL bfnOraConnecta( char *szUser, char *szPasw );
/* Fin */
#undef access
#ifdef _MASTERSC_C_
	#define access
#else
	#define access extern
#endif

#undef _MASTERS_PC_
#undef _MASTERSC_C_


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

