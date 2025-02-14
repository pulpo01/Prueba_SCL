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

#define	LOGNAME			"Val_Evaluaciones"
#define GLOSA_PROG     	"PROGRAMA DE VALORACION DE EXCEDENTES DE EVALUADOR DE RIESGO"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"06-NOVIEMBRE-2003 (mwn70192)"
#define FORMACOMIS		"DOCUMENTAC"
#define CODUNIVERSO     "EVALUA"
/*---------------------------------------------------------------------------*/
/* Definicion de configurador LC_TIME para mensajes relacionados con fechas, */
/* en lenguaje espanol y en ambiente HP-UX.                                  */
/*---------------------------------------------------------------------------*/
#define	LC_TIME_SPANISH	"es_ES.iso88591"
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE  * pfLog;                 
char    *pszEnvLog  = "";
/*---------------------------------------------------------------------------*/
/* Parametros generales de la aplicación.                                    */
/*---------------------------------------------------------------------------*/
int   iCodConcepFactImp, iPl;
long  lClienteGenerico;	    
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef	struct REG_ESTADIST		
{
	long	lSegProceso	;
	long	lCantEvaluaciones;
}rg_estadistica;
rg_estadistica	stStatusProc;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar resumen de ponderaciones.           */
/*---------------------------------------------------------------------------*/
struct reg_universo
{
	int		iCodTipoRed;		
	long	lCodComisionista;
	char	szCodTipComis [3];
	char	szCodOficina  [3];
	char	szCodPlanComis[7];	

    char	szFecDesde[11];
    char	szFecHasta[11];
	
    int     iCodConcepto;
	int		iNumTotal;
	int		iNumVentas;
	long	lCodCliente;
	double	dPonderacion;
	double	dImpComision;
    double  dValUmbral;
    double  dValExcedente;
    char    szCodMoneda[3];

	struct	reg_evaluaciones * sgte_eval;
	struct	reg_universo * sgte;
};
typedef struct reg_universo stUniverso;
stUniverso * lstUniverso = NULL;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejardetalle de evaluaciones.             */
/*---------------------------------------------------------------------------*/
struct reg_evaluaciones
{
	long	lNumGeneral;
	long	lNumVenta;
	char	szFechaSolicitud [11];
	struct	reg_evaluaciones * sgte;
};
typedef struct reg_evaluaciones stEvaluaciones;
/*---------------------------------------------------------------------------*/
void  vSqlError_2();
void  vCargaParametros();
char  *szGetCmdParametros(int , int );
int   bCargaConceptos();
void  vCreaUniverso();
void  vValoraExcedentes();
float fObtienePrecio (float , long , char * );
float fObtieneValorConversion();
float fOBtieneImpuestos(float , long , char * );
void  vInsertaValorizados();
void  vLiberaUniverso(stUniverso * );
void  vLiberaEventos(stEvaluaciones *);
