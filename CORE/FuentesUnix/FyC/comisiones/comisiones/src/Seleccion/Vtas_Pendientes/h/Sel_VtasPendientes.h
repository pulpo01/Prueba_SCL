#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <unistd.h>
#include <signal.h>
#include <string.h>
#include <strings.h>
#include <sys/timeb.h>
#include <sys/stat.h>
#include <time.h>
#include <locale.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>

#define GLOSA_PROG     "SELECCION DE VENTAS CELULAR PENDIENTES DE ACEPTAR"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "17-SEP-2003 (mwn70192)."
#define LOGNAME        "Sel_VtasPendientes"

#define UNIVERSO       "HABCEL"

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE    * pfLog;                     
char    *pszEnvLog  = "";
char    szLogName[250] ;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        int     lCantRegistros  ;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA PARA ALMACENAT LISTA DE ABONADOS CON VENTASPENDIENTES          */
/*---------------------------------------------------------------------------*/
struct reg_universo{
        char    szCodTipComis[3];
        char    szIndEstVenta[2];
        long    lNumVenta;
        char    szFecVenta[22];
        char    szFecAceptacion[22];
        char    szFecRecepcion[22];
        char    szNumContrato[22];
        long    lCodVendedor;
        long    lCodVendComis;
        long    lCodVendDealer;
        long    lCodCliente;
        long    lNumAbonado;
        long    lNumCelular;
        char    szCodPlanTarif[4];
        char    szNumSerie[26];
        long    lCodArticulo;
        char    szIndProcequi[2];
      	char	szCodTipVendedor[3];
        long    lCodPeriodo;
        char    szNomVendDealer[41];
        char    szNumIdent[21];  
        short   iIndCodVendDealer;
   	    int		iCodTipoRed;
    	char  	cIndConsidera;  
        short   iIndCodVendFinal;
        char    szhNomVendDealer[41];
      
        struct  reg_universo * sgte;
};
typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*------------------------------------------------------------------------------*/
void vCargaTiposComis();
void vSeleccionarUniverso(int , char * , char * );
void vGetClientes();
void vGetVendDealer();
void vGetEquipos();
void vInsertaSeleccion();
void vLiberaUniverso();
