#include <stdio.h>
#include <strings.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>


#define GLOSA_PROG     "SELECCION DE RECHAZOS"
#define PROG_VERSION   "CUZCO 4.0"
#define LAST_REVIEW    "24-SEP-2003 (mwn70192)."
#define LOGNAME        "Sel_Rechazos"

#define UNIVERSO       "RECHAZ"
#define MAXARRAY       2000

#define PYME            "PYME"
#define INDIVIDUAL      "INDIVIDUAL"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  * pfLog;
char *pszEnvLog           = "";
char szLogName [250]  = "";

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   long         lSegProceso ;
   long         lCantRechazos;
}rg_estadistica;
rg_estadistica stStatusProc;
/*------------------------------------------------------------------------------*/
/* DEFINICION DE LA ESTRUCTURA A GRABAR PINCIPAL                                */
/*------------------------------------------------------------------------------*/
typedef struct reg_universo
{
  	    long    lNumVenta;
        long    lNumAbonado;
		char    szCodTipComis[3];
        long    lCodVendFinal;
        short   sIndCodVendFinal;
        long    lCodCliente;
        long    lNumCelular;
        char    szNumContrato[20];
        short   sIdNumContrato;
        char    cNumSerie[26];
        long    lCodComisionista;
        long    lCodAgencia;
   	    char    szFecVenta[20];
	    char    szFecRecepcion[20];
        short   sIndFecRecepcion;
	    char    szFecRechazo[20];
        char    szCodCausaRec[3];
        char    szNumIdent[21];
        long    lCodCategoria;
        char    szCodCatribut[2];
        char    szIndProcequi[2];
        char    szNomUsuario[31];                
   	    int		iCodTipoRed;
	    char	szCodTipVendedor[3];
    	char  	cIndConsidera;  
        char    szCodPlanTarif[4]; 

	    struct 	reg_universo * sgte;
	    struct 	reg_abonado  * abonado_sgte;
}reg_universo;

typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;

/*------------------------------------------------------------------------------*/
void vSeleccionarUniverso(int , char * , char * );
void vGetPlan();
void vInsertaSeleccion();
void vLiberaUniverso();
