/* ********************************************************************** */
/* *  Fichero : Proc_GenrepECU.h                                        * */
/* *  Cabecera del proceso generador de reportes legales de Ecuador 	* */
/* *  Autor : Patricio Gonzalez Gomez	                                * */
/* *  Modif : 								* */
/* ********************************************************************** */


/* inclusion de archivos */
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <string.h>
#include <strings.h>
#include <math.h>
#include <time.h>
#include <GenFA.h>
#include <predefs.h>
#include <New_Interfact.h>
#include <unistd.h>

#ifndef _PROC_GENREPECU_H_
#define _PROC_GENREPECU_H_

/* Definicion de contantes */
#define   iLOGNIVEL_DEF  3

/*
#define REG_IVA 		"%-13.-13s%4.4s%2.2s%-13.-13s%2.2s%8.8s%8.8s%6.6s%7.7s%10.10s%2.2s%010ld%02.f%1.1ld%010ld%02.f%010ld%02.f%010ld%02.f%010ld%02.f%1.ld%010ld%02.f%010ld%02.f%1.1ld%010ld%02.f%1.1s%12.12s%12.12s%12.12s\n"
*/

#define REG_IVA 		"%-13.-13s%4.4s%2.2s%-13.-13s%2.2s%8.8s%8.8s%6.6s%7.7s%10.10s%2.2s%010ld%02.f%1.1ld%010ld%02.f%010ld%02.f%010ld%02.f%10.10s%2.2s%1.1s%10.10s%2.2s%10.10s%2.2s%1.1s%10.10s%2.2s%1.1s%12.12ld%12.12ld%12.12s\n"
#define REG_ICE 		"%4.4s%2.2s%-13.-13s%1.1s%2.2s%-13.-13s%-90.-90s%-5.-5s%013ld%02.f%013ld%02.f%013ld%02.f%013ld%02.f\n"
					


/* Definicion de estructuras */
typedef struct LINEACOMANDO
{
    char    	szUser       [50]	;
    char    	szUsuario    [63]	;
    char    	szPass       [50]	;
    long	lMes			;
    long	lAno			;
    long    	lCodCliente		;
    long	lCodCiclo		;
    char	szFecInicio  	[9]	;
    char	szFecFin  	[9]	;
    int     	iNivLog			;
}LINEACOMANDOPRELIMINAR;


/*--------------------------------------------------------------------------*/
typedef struct ARCH_IVA
{
	char	szRuc					[13 + 1];
	char	szCod_Periodo				[4  + 1];
	char	szCod_Secuencial			[2  + 1];
	char	szNro_Docto				[13 + 1];
	char	szCod_Tip_Comprobante			[2  + 1];
	char	szFec_Emision				[8  + 1];
	char	szFec_Registro_Contable			[8  + 1];
	char	szNro_Serie_Comprobante			[6  + 1];
	char	szNro_Secuen_Comprobante		[7  + 1];
	char	szNro_Autoriz_Comprob			[10 + 1];
	char	szIdentif_Credito_Tributario		[2  + 1];
	double	dBase_Imponible_Gravada				;
	long	lCod_Porcent_Iva				;
	double	dBase_Imponible_Tarif_0				;
	double	dMonto_Iva					;
	double	dMonto_Ice					;
	double	dMonto_Iva1					;
	long	lCod_Porcent_Retencion_Iva1			;
	double	dMonto_Retencion_Iva1				;
	double	dMonto_Iva2					;
	long	lCod_Porcent_Retencion_Iva2			;
	double	dMonto_Retencion_Iva2				;
	char	szTransac_Con_Derecho_Devolucion	[1  + 1];
	char	szCant_Coprobantes_Vta_Emitidos_Mes	[12 + 1];
	char	szCant_Notascredito_Emitidas_Mes	[12 + 1];
	char	szCant_Notasdebito_Emitidas_Mes		[12 + 1];

}REG_ARCH_IVA;

typedef struct ARCH_IVA_HOST
{
	char	szRuc					[TAM_HOSTS_PEQ][13 + 1]	;
	char	szCod_Periodo				[TAM_HOSTS_PEQ][4  + 1]	;
	char	szCod_Secuencial			[TAM_HOSTS_PEQ][2  + 1]	;
	char	szNro_Docto				[TAM_HOSTS_PEQ][13 + 1]	;
	char	szCod_Tip_Comprobante			[TAM_HOSTS_PEQ][2  + 1]	;
	char	szFec_Emision				[TAM_HOSTS_PEQ][8  + 1]	;
	char	szFec_Registro_Contable			[TAM_HOSTS_PEQ][8  + 1]	;
	char	szNro_Serie_Comprobante			[TAM_HOSTS_PEQ][6  + 1]	;
	char	szNro_Secuen_Comprobante		[TAM_HOSTS_PEQ][7  + 1]	;
	char	szNro_Autoriz_Comprob			[TAM_HOSTS_PEQ][10 + 1]	;
	char	szIdentif_Credito_Tributario		[TAM_HOSTS_PEQ][2  + 1]	;
	double	dBase_Imponible_Gravada			[TAM_HOSTS_PEQ]		;
	long	lCod_Porcent_Iva			[TAM_HOSTS_PEQ]		;
	double	dBase_Imponible_Tarif_0			[TAM_HOSTS_PEQ]		;
	double	dMonto_Iva				[TAM_HOSTS_PEQ]		;
	double	dMonto_Ice				[TAM_HOSTS_PEQ]		;
	double	dMonto_Iva1				[TAM_HOSTS_PEQ]		;
	long	lCod_Porcent_Retencion_Iva1		[TAM_HOSTS_PEQ]		;
	double	dMonto_Retencion_Iva1			[TAM_HOSTS_PEQ]		;
	double	dMonto_Iva2				[TAM_HOSTS_PEQ]		;
	long	lCod_Porcent_Retencion_Iva2		[TAM_HOSTS_PEQ]		;
	double	dMonto_Retencion_Iva2			[TAM_HOSTS_PEQ]		;
	char	szTransac_Con_Derecho_Devolucion	[TAM_HOSTS_PEQ][1  + 1]	;
	char	szCant_Coprobantes_Vta_Emitidos_Mes	[TAM_HOSTS_PEQ][12 + 1]	;
	char	szCant_Notascredito_Emitidas_Mes	[TAM_HOSTS_PEQ][12 + 1]	;
	char	szCant_Notasdebito_Emitidas_Mes		[TAM_HOSTS_PEQ][12 + 1]	;
}REG_ARCH_IVA_HOST;

typedef struct TagREG_IVA
{
	int			iCantRegIVA;
	REG_ARCH_IVA		*stRegIva;

}REG_ARCH_IVA_S;



/* --------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------- */

typedef struct ARCH_ICE
{
	char	szAno_Proceso		[4  + 1];
	char	szMes_Proceso		[2  + 1];
	char	szRuc_Empresa		[13 + 1];
	char	szTip_Servicio		[1  + 1];
	char	szTip_Ident_Usuario	[2  + 1];
	char	szIdentif_Usuario	[13 + 1];
	char	szNom_Usuario		[60 + 1];
	char	szCod_Provincia		[5  + 1];                            
	double	dBase_Imponible_Iva		;
	double	dBase_Imponible_Ice		;
	double	dValor_Iva			;
	double	dValor_Ice			;
	
	
	
	
}REG_ARCH_ICE;

typedef struct ARCH_ICE_HOST
{
	char	szAno_Proceso		[TAM_HOSTS_PEQ][4  + 1];
	char	szMes_Proceso		[TAM_HOSTS_PEQ][2  + 1];
	char	szRuc_Empresa		[TAM_HOSTS_PEQ][13 + 1];
	char	szTip_Servicio		[TAM_HOSTS_PEQ][1  + 1];
	char	szTip_Ident_Usuario	[TAM_HOSTS_PEQ][2  + 1];
	char	szIdentif_Usuario	[TAM_HOSTS_PEQ][13 + 1];
	char	szNom_Usuario		[TAM_HOSTS_PEQ][60 + 1];
	char	szCod_Provincia		[TAM_HOSTS_PEQ][5  + 1];
	double	dBase_Imponible_Iva	[TAM_HOSTS_PEQ]		;
	double	dBase_Imponible_Ice	[TAM_HOSTS_PEQ]		;
	double	dValor_Iva		[TAM_HOSTS_PEQ]		;
	double	dValor_Ice		[TAM_HOSTS_PEQ]		;	
}REG_ARCH_ICE_HOST;

typedef struct TagREG_ICE
{
	int			iCantRegICE;
	REG_ARCH_ICE		*stRegIce;

}REG_ARCH_ICE_S;

/* --------------------------------------------------------------------------- */
/* --------------------------------------------------------------------------- */


#undef access

#ifdef _PROC_GENREPECU_PC_
#define access
#else
#define access extern
#endif  /* _PROC_GENREPECU_PC_ */


/* Declaracion de variables y estructuras globales */
LINEACOMANDOPRELIMINAR  	stLineaComando;
access REG_ARCH_IVA_S  		pstRegIva	;
access REG_ARCH_ICE_S  		pstRegIce	;




/* Definicion de prototipos de funciones */
BOOL bfnCargaEstructuras();
BOOL bfnGeneraReportes()  ;

int iCargaICE(REG_ARCH_ICE **pstRegIce, int *iNumRegIce)			;
int iCargaIVA(REG_ARCH_IVA **pstRegIva, int *iNumRegIva)                        ;

int ifnCloseICE (void)		;
int ifnCloseIVA (void)          ;

void vfnPrintICE (REG_ARCH_ICE *pstRegIce, int iNumRegIce)			;
void vfnPrintIVA (REG_ARCH_IVA *pstRegIva, int iNumRegIva)                      ;


static BOOL ifnFetchICE (REG_ARCH_ICE_HOST *pstHost,long *plNumFilas)		;
static BOOL ifnFetchIVA (REG_ARCH_IVA_HOST *pstHost,long *plNumFilas)           ;

static int ifnOpenICE (void)		;
static int ifnOpenIVA (void)            ;

void trim (const char *c, char *result)	;
int ifnAbreArchivosLog	(void)		;

int ifnVerificaImpuestoIVACero (void)	;	/* PGG SOPORTE 27-10-2005 XO-952 */

#undef access
#endif  /* _PROC_GENREPECU_H_ */

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

