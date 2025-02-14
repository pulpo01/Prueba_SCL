#include <stdio.h>
#include <stdlib.h>
#include <strings.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>
#include "GEN_biblioteca.h"

#define GLOSA_PROG     "EXTRACCIÓN DE ACTIVACIONES LISTOPACK PARA SADECOM"
#define PROG_VERSION   "1.6" 
/*#define LAST_REVIEW    "25-ABR-2005 (mwt00100)."*/
/*#define LAST_REVIEW    "24-08-2005 (mwn70351)."  XO-200508230442 Soporte RyC 24-08-2005 capc*/
/*#define LAST_REVIEW    "13-09-2005 (mwt00100)."  XO-200508270496 Amplicación Funcional Columnas en Blanco, y header de columnas*/
/*#define LAST_REVIEW    "03-10-2005 (mwt00100)."  XO-200509230721 Modificar obtención de Dirección*/
/*#define LAST_REVIEW    "07-10-2005 (mwt00100)."  XO-200510070817 Modificar construcción de archivos de datos*/
#define LAST_REVIEW    "21-12-2005 (mwn80006)."  /*RA-322 Se controla los tab y pipes en los archivos de datos*/

#define LOGNAME        "Ext_ListoPack"

#define PATHLEN         250
#define UNIVERSO       "LISPAC" 

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de codigos de retorno del programa ejecutable (exit's code)    */
/*---------------------------------------------------------------------------*/
#define EXIT_01         1               /* Error en argumentos externos */
#define EXIT_03         3               /* Error en apertura de archivo de log */
#define EXIT_04         4               /* Error en apertura de archivo de datos de entrada */
#define EXIT_06         6               /* Usuario/Password Oracle son incorrectos */
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;
FILE  * pfDat;
FILE  * pfLst;

char    *pszEnvLog  = "";
char    *pszEnvDat  = "";
char    *pszEnvLst  = "";
char    szLogName[250]       = "";
char    szDatName[250]       = "";
/*---------------------------------------------------------------------------*/
/* Definicion de dia habil.                                                  */
/*---------------------------------------------------------------------------*/
#define HABIL           1
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso    ;
        long    lCantArchivos  ;
}rg_estadistica;
rg_estadistica  stStatusProc;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE VENTAS SELECCIONADAS                                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
  long    lNumVenta;
  long    lCodCliente;
  char    szMTX[4];
  char    cContrato[22];
  char    cNombre[51];
  char    cApellidos[50];
  char    cDesEmpresa[51];
  char	  cDireccion[801];
  char    cCedula[21];
  char    cRuc[21];
  char    cFec_act_cuenta[30];
  char    cCelular[16];
  char    cFec_act_tel[30];
  char    cFec_termino_tel[30];
  char    cFec_act_comp[30];
  char	  cFec_termino_comp[30];
  char    cFec_ult_cambio[30];
  char    cUsuario[31];
  char    cCod_servicio[8];
  char    cCod_tecnologia[8];
  long    lCodArticulo;
  char	  szDesArticulo[41];
  int 	  iCodFabricante;
  char	  szDesFabricante[21];
  char    cCod_plan[4];
  char    cPlan_activo[31];
  long    lVendedor;
  char	  szDesCiudad[31];
  char	  szDesProvincia[31];
  char	  szCodCiudad[6];
  char	  szFranquicia[31];
  long    iCiclo;

  char    szNumSerie[26];	/* Serie de la Simcard (GSM) */
  char	  szNumImei [26];	/* serie mecanica (terminal) */

  char    cSituacion[31];
  char    cIndConsidera;  
  
  char	  iTipArticulo;
  char	  szDesTipArticulo[16];
  char	  szCodModelo[16];
  

  long    lNumAbonado;
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

