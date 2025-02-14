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

#define GLOSA_PROG     "SELECCION DE BAJAS ANTICIPADAS"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "04-SEP-2003 (mwn70192)."
#define LOGNAME        "Sel_Bajas"

#define UNIVERSO       "BAJAS"

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
char    szLogName [250]  = "";

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   int         lSegProceso ;
   int         lCantRegistros;
}rg_estadistica;
rg_estadistica stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE BAJAS SELECCIONADAS                                         */
/*---------------------------------------------------------------------------*/
typedef struct reg_universo{
	int		iCodTipoRed     ;
	char	szCodTipComis[3];
	long	lCodVendComis   ;
	char	szCodTipVendedor[3];
	long	lCodVendedor    ;
	long	lCodVendDealer  ;

	char  	szNumContrato[20] ;      
	long  	lNumVenta;
    char  	szFecVenta[20]    ;
	char  	szFecRecepcion[20];
	char  	szFecAceptacion[20];

	long  	lCodCliente;
	char  	szNumIdent[21];
	int  	iCodCategoria;
    long  	lNumCelular;
    char    szNumSerie[26];
    long    lNumAbonado;
    char    szCodCausaBaja[3];
    char    szFecAlta[20];
    char    szFecContrato[20];
    long    lCodVendFinal;
	char	szIndEstVenta[3];
    char    cIndConsidera;
	char  	szTipIdent[3];
    char    szCodCaTribut;    
    short   sIndNumVenta;         
    short   sIndCodVendFinal;
    short   sIndFecRecepcion;             
    short   sIndFecAceptacion;             

	struct 	reg_universo * sgte;
	struct 	reg_abonado  * abonado_sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA DE ABONADOS DE BAJAS.                                          */
/*---------------------------------------------------------------------------*/
struct reg_abonado{
	long  	lNumCelular;
	char  	szCodPlanTarif[4];
	char  	szNumSerie[26];
	long  	lNumAbonado;
	int	 	iCodAfinidad;
	char  	szCodTecnologia[8]; 
	char  	cIndProcequi;
	long  	lCodArticulo;
	char  	cIndConsidera;  
    short   sCodFabricante;

	struct 	reg_abonado * sgte;
};
typedef struct reg_abonado stAbonado;
/*------------------------------------------------------------------------------*/
void vCargaTiposComis();
void vSeleccionarUniverso(int , char * , char * );
void vGetAbonados();
void vGetClientes();
void vGetEquipos();
void vInsertaSeleccion();
void vLiberaAbonados(stAbonado * );
void vLiberaUniverso();
