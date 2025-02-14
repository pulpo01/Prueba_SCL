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

#define GLOSA_PROG     "SELECCION DE VENTAS PREPAGO (NO MASIVAS)"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "15-SEP-2003 (mw70192)."
#define LOGNAME        "Sel_VtaPrepago"

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
/* ESTRUCTURA DE VENTAS SELECCIONADAS                                        */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
	int		iCodTipoRed;
	char	szCodTipComis[3];
	long	lCodVendComis;
	int	    iCodAgencia;
	long	lCodVendDealer;
	long  	lNumVenta;
	char  	szFecVenta[20];
	long  	lCodCliente;
	char  	szCodOficina[3];
    char    szNumIdent[21];
	char  	cIndConsidera;  
	char	szCodTipVendedor[3];
	
    long    lNumCelular;
    char    szNumSerie[26];
    long    lNumAbonado;
    char    szIndProcequi[2];
    short   sCodFabricante;
    long    lCodArticulo;
	long	lCodPeriodo;
	char	szIdPeriodo[11];
	struct 	reg_universo * sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*---------------------------------------------------------------------------*/
void vSeleccionarUniverso(int , char * , char * );
void vGetEquipos();
void vInsertaSeleccion();
void vLiberaUniverso();
