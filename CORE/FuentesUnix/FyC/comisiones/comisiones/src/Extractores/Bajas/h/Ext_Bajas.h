#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>
#include "GEN_biblioteca.h"

#define GLOSA_PROG     "EXTRACCION DE VENTAS PARA COMISIONES EXTERNAS"
#define PROG_VERSION   "1.6" 
/*#define LAST_REVIEW    "20-04-2005 (mwt00100)."*/
/*#define LAST_REVIEW    "24-08-2005 (mwn70351)."  XO-200508230442 Soporte RyC 24-08-2005 capc*/
/*#define LAST_REVIEW    "13-09-2005 (mwt00100)."  XO-200508270496 Amplicación Funcional Columnas en Blanco, y header de columnas*/
/*#define LAST_REVIEW    "03-10-2005 (mwt00100)."  XO-200509230721 Modificar obtención de Dirección*/
/*#define LAST_REVIEW    "07-10-2005 (mwt00100)."  XO-200510070817 Modificar construcción de archivos de datos*/
#define LAST_REVIEW    "21-12-2005 (mwn80006)."  /*RA-322 Se controla los tab y pipes en los archivos de datos*/

#define LOGNAME        "Ext_Bajas"

#define PATHLEN         250
#define UNIVERSO       "BAJAS"
/*---------------------------------------------------------------------------*/
/* Definicion de codigos de retorno del programa ejecutable (exit's code)    */
/*---------------------------------------------------------------------------*/
#define EXIT_01         1               /* Error en argumentos externos */
#define EXIT_03         3               /* Error en apertura de archivo de log */
#define EXIT_04         4               /* Error en apertura de archivo de datos de entrada */
#define EXIT_06         6               /* Usuario/Password Oracle son incorrectos */
/*---------------------------------------------------------------------------*/
/* Definicion de dia habil.                                                  */
/*---------------------------------------------------------------------------*/
#define HABIL           1

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;
FILE  * pfDat;
FILE  * pfLst;
char *pszEnvLog           = "";
char *pszEnvDat           = "";
char *pszEnvLst           = "";
char szLogName [250]      = "";
char szDatName [250]      = "";
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   long         lSegProceso ;
   long         lCantArchivos;
}rg_estadistica;
rg_estadistica stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE VENTAS SELECCIONADAS                                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
	long	lCodCliente       ;     
	char	szNumContrato     [22]; 
	char	szNomCliente	  [51]; 
	char	szApeCliente	  [41];
	char	cDireccion	  [801];
	char	szNumIdent	  [21]; 
	char	szFecAltaCli	  [21]; 
	char	szNumCelular	  [16];     
	long	lNumAbonado	  ;     
	char	szFecVenta	  [21]; 
	char	szFecBaja	  [21]; 
	char	szFecUltMod	  [21]; 
	char	szNomUsuario	  [31]; 
	char	szCodCausaBaja	  [3];  
	char	szDesCausaBaja    [31]; 
	char	szCodTecnologia   [8];  
	long	lNumVenta	  ;     
	long	lCodVenDealer     ;     
	long	lCodVendedor	  ;     
	char	szIndEstVenta	  [3];  
	char	szServicio	  [20]; 
	char    szMTX		  [4];
	char	szDesCiudad	  [31];
	char	szDesProvincia    [31];
	char	szCodCiudad	  [6];
	char	szFranquicia	  [31];
    	char    szNumSerie	  [26];
	char	szCompania	  [51];
	char	szNumRuc	  [21];
	long    lCodArticulo      ;
	char	szDesArticulo	  [41];
	char	iTipArticulo	  ;
	char	szDesTipArticulo  [16];
	char	szCodModelo	  [16];
	int 	iCodFabricante	  ;	
	char	szDesFabricante	  [21];
	char	szNumImei	  [26];
	char    szCodPlanTarif 	  [4];
	char    szDesPlanTarif	  [31];

	char    szNumTelefono1	  [16];
	int     iCodCiclo	  ;
	char    cSituacion[31];
	
	char    cIndConsidera;  
	struct  reg_universo * sgte;
}reg_universo;
typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;

/*------------------------------------------------------------------------------*/
void vSeleccionarUniverso();
int ifnCargaDatosEquipo(stUniverso * );
void vLiberaUniverso();
char szBuscaArchivo();
char *szBuscaDetalleCampoi(stUniverso *, stDetArchivo  *);


