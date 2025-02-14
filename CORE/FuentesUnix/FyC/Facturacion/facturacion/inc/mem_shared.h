#define EST_INICIAL		0
#define EST_FINAL		1
#define EST_RAO			2


BOOL attach_shared_ciclo(
//	TIPIMPUES *pstlGeTipImpues,int *piNumTipImpues,
	IMPUESTOS *pstlGeImpuestos,int *piNumImpuestos,
	CABCUOTAS *pstlGeCabCuotas,int *piNumCabCuotas,
	TACONCEPFACT *pstlGeTaConcepFact,int *piNumTaConcepFact,
	CONCEPTO *pstlGeConceptos,int *piNumConceptos,
	CONCEPTO_MI *pstlGeConceptos_Mi,int *piNumConceptos_Mi,
	ACTIVIDADES *pstlGeActividades,int *piNumActividades,
	RANGOTABLA *pstlGeRangoTabla,int *piNumRangoTabla,
	LIMCREDITOS *pstlGeLimCreditos,int *piNumLimCreditos,
	PROVINCIAS *pstlGeProvincias,int *piNumProvincias,
	REGIONES *pstlGeRegiones,int *piNumRegiones,
	CATIMPOSITIVA *pstlGeCatImpositiva,int *piNumCatImpositiva,
	ZONACIUDAD *pstlGeZonaCiudad,int *piNumZonaCiudad,
	ZONAIMPOSITIVA *pstlGeZonaImpositiva,int *piNumZonaImpositiva,
	GRPSERCONC *pstlGeGrpSerConc,int *piNumGrpSerConc,
	CONVERSION *pstlGeConversion,int *piNumConversion,
	DOCUMSUCURSAL *pstlGeDocumSucursal,int *piNumDocumSucursal,
	LETRAS *pstlGeLetras,int *piNumLetras,
	GRUPOCOB *pstlGeGrupoCob,int *piNumGrupoCob,
	TARIFAS *pstlGeTarifas,int *piNumTarifas,
	ACTUASERV *pstlGeActuaServ,int *piNumActuaServ,
	CUOTAS *pstlGeCuotas,int *piNumCuotas,
	FACTCARRIERS *pstlGeFactCarriers,int *piNumFactCarriers,
	CUADCTOPLAN *pstlGeCuadCtoPlan,int *piNumCuadCtoPlan,
	CTOPLAN *pstlGeCtoPlan,int *piNumCtoPlan,
	PLANCTOPLAN *pstlGePlanCtoPlan,int *piNumPlanCtoPlan,
	ARRIENDO *pstlGeArriendo,int *piNumArriendo,
	CARGOSBASICO *pstlGeCargosBasico,int *piNumCargosBasico,
	OPTIMO *pstlGeOptimo,int *piNumOptimo,
	FERIADOS *pstlGeFeriados,int *piNumFeriados,
	PLANTARIF *pstlGePlanTarif, int *piNumPlanTarif,
	PENALIZA *pstlGePenalizaciones, int *piNumPenalizaciones,
	OFICINA **pstlGeOficina, int *piNumOficina,
	FACTCOBR **pstlGeFactCobr, int *piNumFactCobr,
        CARGOSRECURRENTES *pstlGeCargosRecurrentes,int *piNumCargosRecurrentes,
	long *piNumFacCiclo);
	
	
BOOL bfnProcesarClientes(FAC_CLIENTES **pstCliente,CICLOCLI *pstlFacCiclo,long *piNumAbonados,long piNumFacCiclo, int iSemId);
BOOL bCargaCargos_MC (CARGOS *,long*,int,long,long,long,long);
int  iCmpCargos (const void*,const void*);
void vPrintCargos (CARGOS *,int )               ;
/* ************************************************ */
/* Funciones de Control de Semáforos de Facturación */
/* ************************************************ */
int   unlock(int sem_id);
int   lock(int sem_id);
int   valor_semaforo(int sem_id);
int   bfnCreaSemaforo(void);

