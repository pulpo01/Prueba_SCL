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
#include <libgen.h>
#include <utils.h>

#define MAXARRAY     		500
#define MAX_CONCEPTOS       50
#define GLOSA_PROG          "PROGRAMA DE LIQUIDACION DE COMISIONES"
#define LOG_NAME            "Liq_comisiones"
#define LAST_REVIEW			"13-SEP-2003 MWT00100"
#define PROG_VERSION    	"CUSCO 4.0"


#define BONOS_COMISIONES    1
#define AJUSTES             2
#define ANTICIPOS           3
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define LC_TIME_SPANISH "es_ES.iso88591"

/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/

FILE  	* pfLog;
char    *pszEnvLog  = "";
char    szLogName[MAXARRAY] ;
long    lSegIni, lSegFin, lSegProceso;

int     iTotAbonados;
int     ibiblio = 0;
int     iCanUmbrales = 0;
int     iConceptoComisiones;
long    lClienteGenerico;
int     iPl;
float   fFactorImpuesto;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef struct REG_ESTADIST             
{
        long    lSegProceso;
        long    lComisiones;
        long    lAjustes;
        long    lAnticipos;
        long	lLiquidaciones;
}rg_estadistica;
rg_estadistica  stStatusProc;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar monto de conceptos de liquidacion */
/*---------------------------------------------------------------------------*/
struct reg_criticos
{
    int		iCodTipoRed;
    char	szCodPlanComis[7];
    long    lCodConcepto;
    double	dNivCritico;
    char	cCodOperador[2];
    struct  reg_criticos * sgte;
};
typedef struct reg_criticos stCriticos;
stCriticos * lstCriticos = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para almacenar monto de conceptos de liquidacion */
/*---------------------------------------------------------------------------*/
struct reg_conceptos
{
    long    lCodConcepto;
    char    cTipComision[2];
    char    szUniverso[7];
    char	cTipCalculo[2];
    long	lNumLogro;
    long	lNumRegistros;
    double  dImpConcepto;
    int		iNivSeleccion;
    int		iNivAplicacion;	
    char	cIndConsidera;
    struct  reg_conceptos * sgte;
};
typedef struct reg_conceptos stConceptos;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura de comisionista                                  */
/*---------------------------------------------------------------------------*/
struct reg_comisionistas
{
	int		iCodTipoRed;
    char    szTipComis[3];
    long    lCodComisionista;
    long    lCodCliente;
    char    szCodOficina[3];
    char	szIndAplicSubordinada[2];
    char	cIndCumplimiento;
    char	cIndConsidera;

    double  dAcumComisiones;
    double  dAcumAjustes;
    double  dAcumAnticipos;
    double  dAcumPenaliza;
    double  dValorNeto;
    double  dValorImpuesto;
    double  dValorTotal;

    struct  reg_comisionistas	* sgte;
    struct  reg_conceptos       * sgte_concepto;  
    struct  reg_conceptos       * sgte_anticipo;  
    struct  reg_conceptos       * sgte_ajuste;  
};
typedef struct reg_comisionistas stUniverso;
stUniverso * lstComisionistas = NULL;
stUniverso * lstAuxiliar = NULL;

/*---------------------------------------------------------------------------*/
/* Definicion de estructura para formación de query dinámico.                */
/*---------------------------------------------------------------------------*/
typedef  struct reg_campos
{
        char    szNomTabla		[100];
        char	szNomComisAplic	[100];
        char	szNomComisSelec	[100];
}reg_campos;
reg_campos      stCampos;
/*---------------------------------------------------------------------------*/
/* Definición de los prototipos de funciones utilizadas en el codigo.        */
/*---------------------------------------------------------------------------*/
void vSqlError_2( void );
void vCreaConceptosCriticos();
stCriticos * stFndCriticos(int , long , stCriticos * );
int bEvaluaCumplimiento(long , char * ,double );
void vMarcaTipoRed(int , long );
void vEvaluaCriticos();
stUniverso * stfnFindComisionista(int , long , stUniverso * );
stConceptos * stfnFindConcepto(long , stConceptos * );
stUniverso * stCreaUniversoPeriodico();
stUniverso * stCreaUniversoEsporadico();
stConceptos * stCargaAjustes(int , long );
stConceptos * stCargaAnticipos(int , long );
stConceptos * stCargaConceptos(int , long );
void vCargaDatosLiquidacion();
void vTotalizaLiquidaciones();
void vCalculaImpuestos();
void vInsertaLiquidacion();
void vMarcaAjustesAnticipos();
long lObtenerCategoria(long );
double dObtenerFactor(long , char * );
void vCargaParametros();
void vMuestraListas(stUniverso *);
stUniverso * stCreaComisHijos(int , long );
int ifnGetNomTablaSeleccion(char * , reg_campos *  );
void vDeterminaMontos(int , long , long , stConceptos * );
void vReparteComision(stUniverso * , stUniverso * );
void vConcatenaListas(stUniverso * );
void vMergeListas(stUniverso * , stUniverso * );
void vComisionesSubordinadas();
void vLiberaConceptos(stConceptos * );
void vLiberaUniverso(stUniverso * );
void vLiberaCriticos(stCriticos * );
/*---------------------------------------------------------------------------*/


/******************************************************************************************/
/** Información de Versionado *************************************************************/
/******************************************************************************************/
/** Pieza                                               : */
/**  %ARCHIVE% */
/** Identificador en PVCS                               : */
/**  %PID% */
/** Producto                                            : */
/**  %PP% */
/** Revisión                                            : */
/**  %PR% */
/** Autor de la Revisión                                : */
/**  %AUTHOR% */
/** Estado de la Revisión ($TO_BE_DEFINED es Check-Out) : */
/**  %PS% */
/** Fecha de Creación de la Revisión                    : */
/**  %DATE% */
/** Worksets ******************************************************************************/
/** %PIRW% */
/** Historia ******************************************************************************/
/** %PL% */
/******************************************************************************************/

