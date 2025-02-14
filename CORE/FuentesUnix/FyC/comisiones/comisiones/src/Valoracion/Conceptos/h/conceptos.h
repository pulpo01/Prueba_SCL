#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <strings.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>

#define PATHLEN         250
#define MAXARRAY       	2000
#define	CODUNIVERSO    	"HABCEL"
#define	LOGNAME		   	"Val_Conceptos"
#define GLOSA_PROG     	"PROGRAMA DE VALORACION ESTANDAR DE CONCEPTOS"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"06-AGOSTO-2003 (mwt00100)"
#define FORMACOMIS		"ALTACONTRA"

#define CON_INDIVIDUAL      1
#define CON_PYME            2
#define CON_ALLCATEGORIAS   3

#define PLAN                1
#define CATEGORIA           2
#define TODAS			    "TODAS"

#define NOTECNOLOGIA        "NOTECNO"
/*---------------------------------------------------------------------------*/
/* Definicion de variables para tipos de cálculo.                            */
/*---------------------------------------------------------------------------*/
#define TIPDIRECTO		1
#define TIPVOLNOES		2
#define TIPVOLUMES		3
#define TIPMETNOES		4
#define TIPMETAESC		5
/*---------------------------------------------------------------------------*/
/* Definicion de variables globales.                                         */
/*---------------------------------------------------------------------------*/
FILE    *pfLog;
char    *pszEnvLog  = "";
char	szLogName[PATHLEN] ;
/*---------------------------------------------------------------------------*/
/* Definicion de estructura para manejar estadisticas del proceso.           */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   int   iventas;
   int   ibasura;
   int	 ivalorizados;
   int	 ilogros;
   int   lSegProceso; 
}rg_estadistica;
rg_estadistica stStatusProc;
/*****************************************************************************/
/* ESTRUCTURA GENERAL DE VALORACION DE VENTAS.                               */
/*****************************************************************************/
typedef struct reg_universo
{ 
	int		iCodTipoRed;
	char	szCod_TipComis[3];
	long	lCod_Comisionista;
	char	szNomVendedor[41];	
	long	lCan_Ventas;
	struct reg_concepto	* sgte_concepto;
	struct reg_universo * sgte;
} stUniverso;
stUniverso * lstUniverso = NULL; 
/*****************************************************************************/
/* SUBESTRUCTURA DE CONCEPTOS, ASOCIADOS A LA ESTRUCTURA PRINCIPAL.          */
/*****************************************************************************/
typedef struct reg_concepto
{
	char	szCodPlanComis[7];
	int		iCodConcepto;
	char	szFecDesde[11];
	char	szFecHasta[11];
	char	cTipCalculo[2];
	char	szCodTecnologia[8];
	long	lCanVentas;
	int		iValLogro;
	double	dFecDesde;
	double	dFecHasta;
	double  dImpConcepto;
	struct reg_actuacion 	* sgte_actuacion;
    struct reg_concepto 	* sgte;
} stConcepto;
/*****************************************************************************/
/* ESTRUCTURA DE ACTUACION DE COMISIONES, ASOCIADA A CADA CONCEPTO.          */
/*****************************************************************************/
typedef struct reg_actuacion
{
	long	lNumActuacion;
	char	szTipPlan         [6];
	char	szCodCategCliente[11];
	char	szCodOficina[3];
	char	szIndEscalonado[2];
	double	dImpComision;
	long	lCanVentas;
	char	szFecInicio[11];
	char	szFecTermino[11];
	double	dFecInicio;
	double	dFecTermino;
	
	struct reg_venta 		* sgte_venta;
    struct reg_actuacion 	* sgte;
} stActuacion;
/*****************************************************************************/
/* ESTRUCTURA DE ACTUACION DE COMISIONES CON VALORACION DIFERENCIADA.        */
/*****************************************************************************/
typedef struct reg_actdiferenciada
{
	long	lNumActuacion;
	long	lCodVendedor;
	double	dImpComision;
    struct reg_actdiferenciada 	* sgte;
} stActDiferenciada;
stActDiferenciada * lstActDiferenciada = NULL;
/*****************************************************************************/
/* Almacenamiento del detalle de las metas anuales.                          */
/*****************************************************************************/
typedef struct ldetmetas
{
    double  dVal_MetaParcial;
    long    lCod_Periodo;
    struct ldetmetas * sgte;
} Ldetmetas;
/*****************************************************************************/
/* Almacenamiento de metas de comisiones.                                    */
/*****************************************************************************/
typedef struct lmetas
{ 
	long	lNum_Actuacion;
	long	lCod_Comisionista;
	char	szNomVendedor[41];
	double  dVal_Meta;
	char	szInd_TipMeta[2];	
	long	lCod_Periodo_Ini;
	long	lCod_Periodo_Fin;

	struct ldetmetas * sgte_detmeta;
    struct lmetas * sgte;
} Lmetas;
Lmetas * lstMetas = NULL; 
/*****************************************************************************/
/* Almacenamiento de las matrices de comision.                               */
/*****************************************************************************/
typedef struct ldetmatriz
{ 
    long    lNum_Desde;
    long    lNum_Hasta;
    double  dImp_Comision;

    struct ldetmatriz * sgte;
} Ldetmatriz;
Ldetmatriz * lstDetMatriz = NULL; 
/*****************************************************************************/
/* Estructura para baja de matrices de comisiones.                           */
/*****************************************************************************/
typedef struct lmatriz
{ 
    long    lNum_Actuacion;
    long    lCod_Periodo_Ini;
    long    lCod_Periodo_Fin;

    struct ldetmatriz * sgte_detmatriz;
    struct lmatriz * sgte;
} Lmatriz;

Lmatriz * lstMatrizCom = NULL; 
/*****************************************************************************/
/* ESTRUCTURA DE VENTAS A VALORAR.                                           */
/*****************************************************************************/
typedef struct reg_venta{ 
	long	lNumGeneral;
	char	szCodOficina[3];
	char	szCodTecnologia[8];
	char    szCodTipVendedor[3];
	long    lCodVendedor;
	char	szTipPlan[6];
	char	szCodCategCliente[11];
    double  dImpComision;
    struct reg_venta * sgte;
} stVenta;
/*****************************************************************************/
/* Lista de Ventas a ser valorizadas por el sistema.                         */
/*****************************************************************************/
typedef struct Ventas 
{
    long    lNumGeneral;
	int		iCodTipoRed;
	char    szCodTipComis[3];
    char    szTipPlan[6];
	char    szCodCategCliente[11];
	long    lCodComisionista;
	char    szCodTipVendedor[3];
	long    lCodVendedor;
	char    szCodOficina[3];
	char	szCodTecnologia[8];
    char    szFecAceptacion[20];
    double  dFechaAceptacion;
	char    szFecVenta[11];
    double  dFechaVenta;
    
	struct Ventas * sgte;        
}Ventas;
Ventas * lstVentas = NULL;
/*****************************************************************************/

typedef struct REG_INSERT_CMT_LOGRO_METAS_VALOR
{
    char    szIdPeriodo  [11];
    int     iCodPeriodo      ;
    char    szCodTipComis [3];
    long    lCodComisionista ;
    int     iCodConcepto     ;
    int     iValLogro        ;
    double  dImpConcepto     ;
    int     iNumRegistros    ;
    long    lNumGeneral      ;
    char    szCodUniverso [7];
	double  dImpComision;
	int		iCodTipoRed;	
}reg_logro_metas_valorizados;
reg_logro_metas_valorizados sthCmtLogroMetas;
/*----------------------------------------------------------------------------*/
/* PROTOTIPOS DE FUNCIONES DEL PROCESO.                                       */
/*----------------------------------------------------------------------------*/
int vCalculaEscalMeta(stActuacion * ,long , double *);
int vCalculaMeta(stActuacion * ,long , long , double *);
int iAsigna_Escalonado(long , stVenta * , long);
int bExisteTipComis(char * , stUniverso * );
int bExisteDiferenciada(stActDiferenciada * , long ,long );
int bCargaConceptos();
int iDetTipoCalculo(char * , char * );
double dObtiene_Importe(long , double );
double dObtiene_Importe_Mensual(Lmetas * , long ,long );
double dObtiene_Importe_Anual(Lmetas * , long ,long );
double dAsigna_Comision(stVenta * , double );
double dImporteDiferenciada(stActDiferenciada * , long ,long );
double dObtieneImporteMatriz(double ,Ldetmatriz * );
long lObtieneMeta(long ,long , long , Lmetas * );
void vValorizando();
void vInsertaCmtLogrosMetas();
void vInsertarCmtValorizados();
void vInserta_Salida();
void vAsigna_Ventas();
void vMuestraMetas(long , Lmetas * );
void vMuestraMatriz(int , Lmatriz * );
void vMuestraEstructura();
void vMuestraDiferenciada(long, char * );
void vAsignaConceptos();
void vCargaActuaciones();
void vLiberaDetMetas(Ldetmetas * );
void vLiberaMetas(Lmetas * );
void vLiberaDetMatrizCom(Ldetmatriz * );
void vLiberaMatrizcom(Lmatriz * );
void vLiberaVentas(Ventas * );
void vLiberastVenta(stVenta * );
void vLiberaActuacion(stActuacion * );
void vLiberaConceptos(stConcepto * );
void vLiberaUniverso(stUniverso * );
void vLiberaDiferenciada(stActDiferenciada * );
stActDiferenciada * stCargaActDiferenciada();
Lmatriz * stBuscaMatriz(long ,Lmatriz * ,long );
stUniverso * stBuscaTipComis(stUniverso * , Ventas * );
stActuacion * stBuscaActuacion(stActuacion *,Ventas * );
stActuacion * stCreaActuacionBasura();
stVenta * stCreaNodoVenta(Ventas * );
Ldetmatriz * stBajaDetMatrizCom(long );
Lmatriz *  stCargaMatrizCom();
Ldetmetas * stBajaDetMetas(long );
Lmetas * stCargaMetas();
stUniverso * stCargaUniverso();
Ventas *  vCargaVentas();
