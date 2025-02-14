/*******************************************************************************
	DEFINES:
*******************************************************************************/
#define FILE_LOG		0
#define FILE_ERR		1
#define FILE_BOTH		2
#define SALIR_OK		0
#define MTX			60000000
/*******************************************************************************
 Estructura general
*******************************************************************************/

typedef struct tag_TAS
{
 	FILE * pFileLOG;
	FILE * pFileERR;
	long lGeCargos;
	long lGeCabCuotas;
	long lGeTaConcepFact;
	long lGeConceptos;
	long lGeConceptos_Mi;
	long lGeRangoTabla;
	long lGeLimCreditos;
	long lGeActividades;
	long lGeProvincias;
	long lGeRegiones;
	long lGeCatImpositiva;
	long lGeZonaCiudad;
	long lGeZonaImpositiva;
	long lGeImpuestos;
	long lGeTipImpues;
	long lGeGrpSerConc;
	long lGeConversion;
	long lGeDocumSucursal;
	long lGeLetras;
	long lGeGrupoCob;
	long lGeTarifas;
	long lGeActuaServ;
	long lGeCuotas;
	long lGeFactCarriers;
	long lGeCuadCtoPlan;
	long lGeCtoPlan;
	long lGePlanCtoPlan;
	long lGeArriendo;
	long lGeCargosBasico;
	long lGeOptimo;
	long lGeFeriados;
	long lGePlanTarif;
	long lGePenalizaciones;
  	long lFacClientes;
  	long lFacCiclo;
  	long lGeCatImpClientes;
  	long lGeDirecciones;
  	long lGeDirecciones2;
  	long lGeUnipac;
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
	long lGeOficina;
	long lGeFactCobr;
	long lGeDetPlanDesc;
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
/***********   Inicio Cargos Recurrentes   *************/
	long lGeCargosRecurrentes;
/***********     Fin Cargos Recurrentes    *************/
	CARGOS *pstlGeCargos;
	CABCUOTAS *pstlGeCabCuotas;
	TACONCEPFACT *pstlGeTaConcepFact;
	CONCEPTO *pstlGeConceptos;
	CONCEPTO_MI *pstlGeConceptos_Mi;
	RANGOTABLA *pstlGeRangoTabla;
	LIMCREDITOS *pstlGeLimCreditos;
	ACTIVIDADES *pstlGeActividades;
	PROVINCIAS *pstlGeProvincias;
	REGIONES *pstlGeRegiones;
	CATIMPOSITIVA *pstlGeCatImpositiva;
	ZONACIUDAD *pstlGeZonaCiudad;
	ZONAIMPOSITIVA *pstlGeZonaImpositiva;
	IMPUESTOS *pstlGeImpuestos;
	TIPIMPUES *pstlGeTipImpues;
	GRPSERCONC *pstlGeGrpSerConc;
	CONVERSION *pstlGeConversion;
	DOCUMSUCURSAL *pstlGeDocumSucursal;
	LETRAS *pstlGeLetras;
	GRUPOCOB *pstlGeGrupoCob;
	TARIFAS *pstlGeTarifas;
	ACTUASERV *pstlGeActuaServ;
	CUOTAS *pstlGeCuotas;
	FACTCARRIERS *pstlGeFactCarriers;
	CUADCTOPLAN *pstlGeCuadCtoPlan;
	CTOPLAN *pstlGeCtoPlan;
  	PLANCTOPLAN *pstlGePlanCtoPlan;
  	ARRIENDO *pstlGeArriendo;
  	CARGOSBASICO *pstlGeCargosBasico;
  	OPTIMO *pstlGeOptimo;
  	FERIADOS *pstlGeFeriados;
  	PLANTARIF *pstlGePlanTarif;
  	PENALIZA *pstlGePenalizaciones;
  	FAC_CLIENTES *pstlFacClientes;
  	CICLOCLI *pstlFacCiclo;
  	CAT_IMPCLIENTES *pstlGeCatImpClientes;
  	DIRECCIONES *pstlGeDirecciones;
  	DIRECCIONES2 *pstlGeDirecciones2;
  	UNIPAC *pstlGeUnipac;	
/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
  	OFICINA *pstlGeOficina;
  	FACTCOBR *pstlGeFactCobr;
  	DETPLANDESC *pstlGeDetPlanDesc;
/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/
/***********   Inicio Cargos Recurrentes   *************/
	CARGOSRECURRENTES *pstlGeCargosRecurrentes;
/***********     Fin Cargos Recurrentes    *************/
  	key_t   kTableKey;
  	key_t   kSemKey;
  	int     SharedPerms;
  	int     SemPerms;
  	int     iTableDescriptor;
  	DATA_TABLE      *pDataTable;
  	long    lMemoriaTotal;
}TAS;

TAS TaS;

void vfnLog( int iCode,        /* Error o Log */ char *szformat,...);
void vfnImpErrorORACLE( void);
void vfnRecuperarFechaHora( char *szFormato, char *szTime);
void vfnInitStructGeneral(void);




