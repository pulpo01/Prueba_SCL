#include <stdio.h>
#include <malloc.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>
#include <strings.h>
#include <geora.h>
#include <utils.h>
#include <libgen.h>

#define	MAXARRAY		2500
#define GLOSA_PROG 		"VALORACION DE stVentas PREPAGO POR TRAFICO (MOD. TMC-CHILE)"
#define PROG_VERSION 	"CUZCO 4.0"
#define	LOGNAME			"Val_Prepago"
#define PROG_VERSION   	"CUZCO 4.0"
#define LAST_REVIEW		"15-OCTUBRE-2003 (MWT00100)"
#define FORMACOMIS		"HABTRAFPRE"

FILE *pfLog;

char *pszEnvLog;
char *szLogName;
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/*---------------------------------------------------------------------------*/
/* SUB LISTA DE REQUISITOS PARA LA EVALUACION DE CRITERIOS DE TRAFICO        */
/*---------------------------------------------------------------------------*/
struct reg_requisitos
{
      int   iNumCriterio_req;
      int   iNumPerfil_req;
      int   iNumPeriodo_req;
      char  cIndCumplimiento;
      struct reg_requisitos *sgte;
};
typedef struct reg_requisitos stRequisito;
/*---------------------------------------------------------------------------*/
/* SUB LISTA DE PERFILES DE EVALUACION DE TRAFICO ASOCIADAS A CADA CRITERIO  */
/*---------------------------------------------------------------------------*/
struct reg_perfil
{
    int     iNumPerfil;
    int     iNumPeriodo;
    char    cTipUnitas;
    long    lUniEntrada;
    long    lUniSalida;
    long    lUniTotal;
	double	dImpRecarga;
    double  dImpComision;
    double  dImpCastigo;
    char	cOpeEntrada;
    char	cOpeSalida;
    char	cOpeRecarga;
    char	szCodOrigen[6];
    struct 	reg_perfil 		*sgte;
    struct 	reg_requisitos 	*sgte_requisito;
    struct	reg_ventas 		*sgte_venta;
};
typedef struct reg_perfil stPerfil;
/*---------------------------------------------------------------------------*/
/* LISTA PRINCIPAL DE DEFINICION DE CRITERIOS DE EVALUACION DE HAB. Y TRAF.  */
/*---------------------------------------------------------------------------*/
struct reg_criterios
{
	int		iCodTipoRed;
	char	szCodPlanComis[7];
	int		iCodConcepto;
	char	szCodTipComis[3];
	char	szFecDesde[11];
	char	szFecHasta[11];
	char	szCodTecnologia[8];
	char	szCodUniverso[7];
    int     iNumCriterio;
    struct reg_criterios *sgte;
    struct reg_perfil  *sgte_perfil;
};
typedef struct reg_criterios stCriterios;
stCriterios * lstCriterios = NULL;

/*---------------------------------------------------------------------------*/
/* LISTA DE HABILITACIONES A SER EVALUADAS SEGUN CRITERIOS / PERFILES        */
/*---------------------------------------------------------------------------*/
struct reg_ventas
{
    long    lNumGeneral;
    long    lCodComisionista;
    long	lNumAbonado;
    long    lNumCelular;
    char    szFechaHabilitacion[11];
    char    szNumSerie[26];
    long	lCodPeriodoHab;
	long    lUniEntrada;
    long    lUniSalida;
    long    lUniTotal;
	double	dImpRecarga;
	double	dImpComision;
    struct 	reg_ventas *sgte;
};
typedef struct reg_ventas stVentas;
/*---------------------------------------------------------------------------*/
/* REGISTRO DE ESTADISTICAS DE PROCESO.                                      */
/*---------------------------------------------------------------------------*/
typedef  struct REG_ESTADIST
{
   int   lCantValorizados;
   int   lSegProceso; 
}rg_estadistica;
rg_estadistica stStatusProc;
/*---------------------------------------------------------------------------*/
/* DECLARACION DE PROTOTIPOS DE FUNCIONES UTILIZADAS POR EL PROCESO          */
/*---------------------------------------------------------------------------*/
stCriterios * vLlenaTasador();
stVentas *pSeleccionaVentas(stCriterios *pCrit, stPerfil *pPerf);
void vObtieneTabla(int iPeriodo,char *szhNomTabla);
void vValorarVentas(stVentas *pVentas,stCriterios *pCrit, stPerfil *pPerf);
BOOL bVerificaRequisitos(stRequisito *pReq,stPerfil *pPerf ,stVentas *pVta,int lNumCriterio);
void vInsertaCmTrafCriterio(stCriterios *pCrit,stVentas *pVta,stPerfil *pPerf,int iEntrada,int iSalida,int iTotal,float Importe);
void vInsertaCmtValorizados(stVentas *pVta,float fImporte);
/*---------------------------------------------------------------------------*/
stPerfil * stObtienePerfiles(int );
stRequisito * stObtieneRequisitos(int ,int ,int );
int bRecuperaTrafico(int , char , long *,long *);
int iEvaluaPerfil(stVentas *, stPerfil *);
/*---------------------------------------------------------------------------*/
