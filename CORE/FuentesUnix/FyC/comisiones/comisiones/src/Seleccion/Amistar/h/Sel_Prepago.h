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

#define GLOSA_PROG     "SELECCION DE HABILITACIONES AMISTAR"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "23-SEP-2003 (mwn70192)."
#define LOGNAME        "Sel_Prepago"

#define UNIVERSO       "HABPRE"

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  * pfLog;                 
char  *pszEnvLog  = "";
char  szLogName[250] ;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        int     iCantAbonados   ;
        long    lCantRegistros  ;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
	int		iCodTipoRed;
	char	szCodTipVendedor[3];
	char    szCodTipComis[3];
    long    lCodComisionista;
    int     iCodAgencia;
    int     iCodVenDealer;
    char    szFecVenta[20];
    long    lCodCliente;
    char    szCodOficina[3];
    char    szNumIdent[21];
    long    lNumVenta;
    char    cIndConsidera;      

  	struct 	reg_universo * sgte;
	struct 	reg_abonado  * abonado_sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE ABONADOS DE LA VENTA.                                       */
/*---------------------------------------------------------------------------*/
struct reg_abonado{
	long  	lNumCelular;
	long  	lNumAbonado;	
	char  	szNumSerie[26];
	char  	cIndProcequi[2];
    long    lCodArticulo;
    short   sCodFabricante;
	char  	cIndConsidera;  
	
	struct 	reg_abonado * sgte;
};
typedef struct reg_abonado stAbonado;

/*------------------------------------------------------------------------------*/
void vSeleccionarUniverso(int , char * , char * );
void vGetAbonados();
void vGetClientes();
void vGetEquipos();
void vInsertaSeleccion();
void vLiberaUniverso();
