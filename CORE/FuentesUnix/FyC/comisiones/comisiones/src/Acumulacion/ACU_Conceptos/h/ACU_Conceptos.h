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
#include <libgen.h>
#include <geora.h>
#include <utils.h>

#define	MAXARRAY		100
#define GLOSA_PROG     	"PROGRAMA DE ACUMULACION DE RESULTADO DE COMISIONES"
#define LAST_REVIEW		"10-SEP-2003 MWT00100"
#define PROG_VERSION    "CUSCO 4.0"
#define LOGNAME        	"ACU_Conceptos"
#define DATNAME        	"ACU_Conceptos"
#define SQLNOTFOUND    	100
#define SQLOK          	0

#define CONCEPTO_NORMAL     0
#define CONCEPTO_BONO       1
#define CONCEPTO_META       2
#define CONCEPTO_ARRIENDO   3
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* PARAMETROS GENERALES LEIDOS DESDE CMD_PARAMETROS                          */
/*---------------------------------------------------------------------------*/
int     iValCoap    = 0;
int     iMesesCoap  = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                     /* PUNTERO AL ARCHIVO DE LOG */
char  szFuncName[MAXARRAY];         /* NOMBRE DE LA FUNCION O ACCION A EJECUTAR */

char    *pszEnvLog      = "";
char    *pszEnvDat      = "";
char    szLogName[MAXARRAY] ;
char    szDatName[MAXARRAY] ;
long    lSegIni, lSegFin, lSegProceso;
int     iTotAbonados;
int     iCodErr         = 0;
int     ibiblio         = 0;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso     ;
        long	lCantAcumulados	;
        long	lCantConsumos   ;
        long	lCantFondos		;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* Estructura de listas para cargar datos de fondos coap disponibles para    */
/* cada distribuidor.                                                        */
/*---------------------------------------------------------------------------*/
struct reg_fondos
{
    long    lCodPeriodo;
    int     iNumPeriodo;
    long    lImpInicial;
    long    lImpUsado;
    long    lImpDisponible;
    struct  reg_fondos * sgte;
};
typedef struct reg_fondos stFondos;
/*---------------------------------------------------------------------------*/
struct reg_fondoscomis
{
	int		iCodTipoRed;
	
    char    szCodTipComis[3];
    char	szCodPlanComis[7];
    int		iCodConcepto;
    int     lCodComisionista;
    long    lImpDisponible;
    struct  reg_fondos * sgte_fondo;
    struct  reg_fondoscomis * sgte;
};
typedef struct reg_fondoscomis stFondosComis;
stFondosComis * lstFondosComis = NULL;
/*---------------------------------------------------------------------------*/
/* Estructura de listas para cargar datos de desde valoracion y ejecutar la  */
/* acumulación en memoria.                                                   */
/*---------------------------------------------------------------------------*/
struct reg_conceptos
{
	int		iCodTipoRed;
    char	szCodPlanComis[7];
	int     iCodConcepto;
	char	szNomConcepto[61];
	char    szCodUniverso[7];
	char	szCodTecnologia[8];
	char	szCodForma[11];
	char	szTipCalculo[2];
	char    szCodTipComis[3];
	long    lCodComisionista;
	char    szIdPeriodo[11];
	long    lCodPeriodo;
	double  dImpConcepto;
	long    lCantRegistros;
	double	dNumLogro;
	struct  reg_conceptos * sgte;
};
typedef struct reg_conceptos stConceptos;
stConceptos * lstConceptos = NULL; 
/*---------------------------------------------------------------------------*/
/* Estructura de listas para cargar datos facturas autorizadas para aplicar  */
/* Bono COAP.                                                                */
/*---------------------------------------------------------------------------*/
struct reg_facturas{
    char	szRowId[19];
    int		iCodTipoRed;
    char	szCodPlanComis[7];
    int		iCodConcepto;
    char    szCodTipComis[3];       /* Canal de ventas                                    */
    int     lCodComisionista;   	/* Codigo Comisionista                                */
    long    lCodPeriodo;            /* Codigo Periodo liquidacion                         */
    double  dImpNeto;               /* Acumulado Neto para el Periodo                     */
    double  dImpTotal;              /* Acumulado Total para el periodo(+IVA)              */
    double  dImpAutorizado;         /* Acumulado de montos autorizados para el periodo    */
    double  dImpPonderado;          /* Autorizado sesgado por el % participacion del fondo*/
	struct    reg_facturas * sgte;
};
typedef struct reg_facturas stFacturas;
stFacturas * lstFacturas = NULL; 
/*---------------------------------------------------------------------------*/
int iBuscaConcepto(int Concepto );
void vLiquidaFacturasCoap();
void vInsertaFondoCoap(int , char * , int , char * , int , long );

