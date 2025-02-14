#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>
#include "GEN_biblioteca.h"

#define GLOSA_PROG     "EXTRACCION DE VENDEDORES PARA COMISIONES"
#define PROG_VERSION   "1.4" 
/*#define LAST_REVIEW  "20-04-2005 (mwt00100)."                                                  */
/*#define LAST_REVIEW  "24-08-2005 (mwn70351)."   XO-200508230442 Soporte RyC 24-08-2005 capc     */
/*#define LAST_REVIEW    "31-08-2005 (mwt00100)." XO-200508270496 Amplicación Funcional Columnas en Blanco, y header de columnas*/
/*#define LAST_REVIEW    "07-10-2005 (mwt00100)."  XO-200510070817 Modificar construcción de archivos de datos*/
#define LAST_REVIEW    "21-12-2005 (mwn80006)."  /*RA-322 Se controla los tab y pipes en los archivos de datos*/

#define LOGNAME        "Ext_RedVentas"

#define PATHLEN         250
#define UNIVERSO       "REDVEN"
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
  char    szDesTipcomis[31];
  long    szCodVendedor;
  char    szNomVendedor[41];
  char    szCodTipident[3];
  char    szDesTipident[21];
  char    szNumIdent[21];
  char    szFecContrato[21];
  char    szFecFinContrato[21];
  char    szDesOficina[41];                 
  char    szNumTelefono[16];
  char    szIndVentaExterna[14];
  
  int     iDiasHabiles;
  int     iDiasReales;

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

