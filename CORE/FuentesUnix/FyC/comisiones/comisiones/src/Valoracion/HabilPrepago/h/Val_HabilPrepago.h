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
#include <utils.h>
#include <libgen.h>
#include <geora.h>

#define MAXARRAY       	2000
#define	LOGNAME			"Val_HabilPrepago"
#define GLOSA_PROG     	"PROGRAMA DE COMISION POR HABILITACION DE VENTAS PREPAGO"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"08-OCTUBRE-2003 (mwn70192)"
#define FORMACOMIS		"ALTAPREPAG"

/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                    /* PUNTERO AL ARCHIVO DE LOG */
char    *pszEnvLog      = "";
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para estadísticas de proceso.                    */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso      ;
        long    lCantRegistros   ;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS HABILITACIONES DEL PERIODO                   */
/*---------------------------------------------------------------------------*/
typedef struct reg_habilitado{
	int     iCodTipoRed;
    char    szCodTipComis[3];
    long    lNumGeneral;   
    long    lCodComisionista;
    char    szFechaEvento[11];
    char    szIndProcequi[2];
    struct  reg_habilitado  * sgte; 
}reg_habilitado;
typedef struct reg_habilitado stHabilitado;
stHabilitado * lstHabilitado = NULL;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LA MATRIZ DE COMISIONES                           */
/*---------------------------------------------------------------------------*/
typedef struct reg_matriz{
    long    lNumDesde;                                                                                                                                                             
    long    lNumHasta;                                                                                                                                                             
    double  lImpComision;                                                                                                                                                          
    struct  reg_matriz      * sgte                                                                                                                                                  ;               
}reg_matriz;
typedef struct reg_matriz stMatriz;
/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE LAS HABILITACIONES (VENTAS)                       */
/*---------------------------------------------------------------------------*/
typedef struct reg_evento{
    long    lNumGeneral;
    char    szCodUniverso[10];
    double  lImpConcepto;
    struct  reg_evento      * sgte;         
}reg_evento;
typedef struct reg_evento stEvento;
stEvento * lstEvento = NULL;

/*---------------------------------------------------------------------------*/
/* ESTRUCTURA QUE CONTIENE EL TASADOR DE CONCEPTOS COMISIONALES              */
/*---------------------------------------------------------------------------*/
typedef struct reg_principal{    
	int     iCodTipoRed;
    char	szCodPlanComis[6];
    int     iCodConcepto;
    char    szFechaDesde[11];
    char    szFechaHasta[11];
    char    szCodTipComis[3];
    long    lCodComisionista;
    char    szTipCalculo[2];
    char    szIndProcequi[2];
    long    dImpConcepto;
    int     iValorMeta;
    double  fPorcentaje;
    double  dImpComision;
    int     iContadorVentas;
    char	szCodUniverso[7];
    struct  reg_principal   * sgte;
    struct  reg_evento      * sgte_evento;
    struct  reg_matriz      * sgte_matriz;
}reg_principal;
typedef struct reg_principal stPrincipal;
stPrincipal * lstPrincipal = NULL;
/*---------------------------------------------------------------------------*/
int    bCargaConceptos();
int    iCargaMeta(int , int, char *, long);
void   vLlenaTasador ();
void   vLlenaMatriz();
stMatriz * CargaMatriz(int , char * , int);
void   vLlenaHabilitaciones();
void   vValoraHabilitaciones();
double lGetImporte(stMatriz *, float );
void   vInsertaValorizados();
void   vLiberaPrincipal(stPrincipal * );
void   vLiberaDatosMatriz(stMatriz * );
void   vLiberaDatosEvento(stEvento * );
void   vLiberaDatosHabilitado(stHabilitado * );

