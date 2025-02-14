#define _MEM_SHARED_C_

#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <sys/types.h>
#include <sys/time.h>
#include <sys/shm.h>
#include <sys/sem.h>

#include "tipos.h"
#include "tablas.h"
#include "shared.h"
#include "semap.h"
#include "general.h"
#include "mem_shared.h"

struct sembuf operaciones[1];

/******************************************************************************
Funcion         :       attach_shared_ciclo
*******************************************************************************/

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
	long *plNumFacCiclo)
{
	int iCont = 0;
  	int iError = 0;

	FACTCOBR *pstFactCobrTemp=NULL;
	OFICINA *pstOficinasTemp=NULL;
/*	DETPLANDESC *pstDetPlanDescTemp=NULL; */

	*piNumOficina=0;
	*piNumFactCobr=0;
/*	*piNumDetPlanDesc=0; */

	fprintf(stderr, "\n\n\t Antes funcion vfnInitStructGeneral.."); /* borrar */

	vfnInitStructGeneral();
	
	fprintf(stderr, "\n\n\t Saliendo funcion vfnInitStructGeneral.."); /* borrar */	
	
	fprintf(stderr, "\n\n\t Voy a crear semaforos con ifnLockSemForRead.."); /* borrar */		
	
	fprintf(stderr, "\n\n\t Llave para ifnLockSemForRead..[%d]",TaS.kSemKey); /* borrar */	

  	/*iError = ifnLockSemForRead(TaS.kSemKey,0); */
  	
  	/*iError = ifnLockSemForRead(TaS.kSemKey,(IPC_CREAT|0666));*/  	
  	
  	iError = ifnLockSemForRead(TaS.kSemKey,(IPC_CREAT|0666));
  	
  	if (iError != 0)
  	{
		if (iError == ENOENT)
	    	{
	      		fprintf(stderr, "\n\nMEM_SHARED: ERROR(bfnAttachMemory):"
	              		"\n\tNo existe semaforos para la memoria compartida");
	    	}
    	else
    		if (iError == EAGAIN)
    		{
      			fprintf(stderr, "\n\nERROR(bfnAttachMemory):"
              			"\n\tLos semaforos estan ocupados, memoria no disponible...\n");
    		}
		else
    		{
      			fprintf(stderr, "\n\nERROR(bfnAttachMemory):"
              			"\n\tError al obtener set de semaforos de la memoria compartida"
              			"\n\tError: [%d][%s]", errno, strerror(errno));
    		}
    		return FALSE;
  	}
	
  	
  	iError = ifnAttachDataTable(TaS.kTableKey,0,(NUM_SHARED_TABLES*sizeof(DATA_TABLE)),&TaS.pDataTable);
  	if (iError)
  	{
    		if (iError == ENOENT)
    		{
      			fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
              			"\n\tNo existe memoria compartida");
    		}
    		else
    		{
      			fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
              			"\n\tError al abrir memoria compartida"
              			"\n\tError: [%d][%s]", errno, strerror(errno));
    		}
    		return FALSE;
  	}
/*
  	iError = ifnAttachMemory(ID_TIPIMPUES,TaS.pDataTable,0,(void*)&TaS.pstlGeTipImpues,&TaS.lGeTipImpues);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_TIPIMPUES].szTableName,
        		strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_TIPIMPUES].lTotalRegistros;iCont++)
  		{
  			pstlGeTipImpues[iCont]=TaS.pstlGeTipImpues[iCont];
  		}
  		*piNumTipImpues=TaS.pDataTable[ID_TIPIMPUES].lTotalRegistros;
  	}
*/
	iError = ifnAttachMemory(ID_IMPUESTOS, TaS.pDataTable,0,(void*)&TaS.pstlGeImpuestos,&TaS.lGeImpuestos);
	if (iError != 0)
  	{
		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_IMPUESTOS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_IMPUESTOS].lTotalRegistros;iCont++)
  		{
  			pstlGeImpuestos[iCont]=TaS.pstlGeImpuestos[iCont];
  		}
  		*piNumImpuestos=TaS.pDataTable[ID_IMPUESTOS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CABCUOTAS, TaS.pDataTable,0,(void*)&TaS.pstlGeCabCuotas,&TaS.lGeCabCuotas);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      	       	       "\n\tError al mapear la memoria para la tabla %s"
      	       	       "\nError: [%s]", TaS.pDataTable[ID_CABCUOTAS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CABCUOTAS].lTotalRegistros;iCont++)
  		{
  			pstlGeCabCuotas[iCont]=TaS.pstlGeCabCuotas[iCont];
  		}
  		*piNumCabCuotas=TaS.pDataTable[ID_CABCUOTAS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_TACONCEPFACT, TaS.pDataTable,0,(void*)&TaS.pstlGeTaConcepFact,&TaS.lGeTaConcepFact);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_TACONCEPFACT].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_TACONCEPFACT].lTotalRegistros;iCont++)
  		{
  			pstlGeTaConcepFact[iCont]=TaS.pstlGeTaConcepFact[iCont];
  		}
  		*piNumTaConcepFact=TaS.pDataTable[ID_TACONCEPFACT].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CONCEPTO, TaS.pDataTable,0,(void*)&TaS.pstlGeConceptos,&TaS.lGeConceptos);
  	if (iError != 0)
  	{
		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CONCEPTO].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		
  		for(iCont=0;iCont<TaS.pDataTable[ID_CONCEPTO].lTotalRegistros;iCont++)
  		{
  			pstlGeConceptos[iCont]=TaS.pstlGeConceptos[iCont];
  		}
  		*piNumConceptos=TaS.pDataTable[ID_CONCEPTO].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CONCEPTO_MI, TaS.pDataTable,0,(void*)&TaS.pstlGeConceptos_Mi,&TaS.lGeConceptos_Mi);
  	if (iError != 0)
  	{
		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		"\n\tError al mapear la memoria para la tabla %s"
      		"\nError: [%s]", TaS.pDataTable[ID_CONCEPTO_MI].szTableName,
                 strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CONCEPTO_MI].lTotalRegistros;iCont++)
  		{
  			pstlGeConceptos_Mi[iCont]=TaS.pstlGeConceptos_Mi[iCont];
  		}
  		*piNumConceptos_Mi=TaS.pDataTable[ID_CONCEPTO_MI].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_RANGOTABLA, TaS.pDataTable,0,(void*)&TaS.pstlGeRangoTabla,&TaS.lGeRangoTabla);
  	if (iError != 0)
  	{
		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_RANGOTABLA].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_RANGOTABLA].lTotalRegistros;iCont++)
  		{
  			pstlGeRangoTabla[iCont]=TaS.pstlGeRangoTabla[iCont];
  		}
  		*piNumRangoTabla=TaS.pDataTable[ID_RANGOTABLA].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_LIMCREDITOS, TaS.pDataTable,0,(void*)&TaS.pstlGeLimCreditos,&TaS.lGeLimCreditos);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_LIMCREDITOS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_LIMCREDITOS].lTotalRegistros;iCont++)
  		{
  			pstlGeLimCreditos[iCont]=TaS.pstlGeLimCreditos[iCont];
  		}
  		*piNumLimCreditos=TaS.pDataTable[ID_LIMCREDITOS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_ACTIVIDADES, TaS.pDataTable,0,(void*)&TaS.pstlGeActividades,&TaS.lGeActividades);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_ACTIVIDADES].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_ACTIVIDADES].lTotalRegistros;iCont++)
  		{
  			pstlGeActividades[iCont]=TaS.pstlGeActividades[iCont];
  		}
  		*piNumActividades=TaS.pDataTable[ID_ACTIVIDADES].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_PROVINCIAS, TaS.pDataTable,0,(void*)&TaS.pstlGeProvincias,&TaS.lGeProvincias);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_PROVINCIAS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_PROVINCIAS].lTotalRegistros;iCont++)
  		{
  			pstlGeProvincias[iCont]=TaS.pstlGeProvincias[iCont];
  		}
  		*piNumProvincias=TaS.pDataTable[ID_PROVINCIAS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_REGIONES, TaS.pDataTable,0,(void*)&TaS.pstlGeRegiones,&TaS.lGeRegiones);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_REGIONES].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_REGIONES].lTotalRegistros;iCont++)
  		{
  			pstlGeRegiones[iCont]=TaS.pstlGeRegiones[iCont];
  		}
  		*piNumRegiones=TaS.pDataTable[ID_REGIONES].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CATIMPOSITIVA, TaS.pDataTable,0,(void*)&TaS.pstlGeCatImpositiva,&TaS.lGeCatImpositiva);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
                       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CATIMPOSITIVA].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CATIMPOSITIVA].lTotalRegistros;iCont++)
  		{
  			pstlGeCatImpositiva[iCont]=TaS.pstlGeCatImpositiva[iCont];
  		}
  		*piNumCatImpositiva=TaS.pDataTable[ID_CATIMPOSITIVA].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_ZONACIUDAD, TaS.pDataTable,0,(void*)&TaS.pstlGeZonaCiudad,&TaS.lGeZonaCiudad);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_ZONACIUDAD].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_ZONACIUDAD].lTotalRegistros;iCont++)
  		{
  			pstlGeZonaCiudad[iCont]=TaS.pstlGeZonaCiudad[iCont];
  		}
  		*piNumZonaCiudad=TaS.pDataTable[ID_ZONACIUDAD].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_ZONAIMPOSITIVA, TaS.pDataTable,0,(void*)&TaS.pstlGeZonaImpositiva,&TaS.lGeZonaImpositiva);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_ZONAIMPOSITIVA].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_ZONAIMPOSITIVA].lTotalRegistros;iCont++)
  		{
  			pstlGeZonaImpositiva[iCont]=TaS.pstlGeZonaImpositiva[iCont];
  		}
  		*piNumZonaImpositiva=TaS.pDataTable[ID_ZONAIMPOSITIVA].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_GRPSERCONC, TaS.pDataTable,0,(void*)&TaS.pstlGeGrpSerConc,&TaS.lGeGrpSerConc);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_GRPSERCONC].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_GRPSERCONC].lTotalRegistros;iCont++)
  		{
  			pstlGeGrpSerConc[iCont]=TaS.pstlGeGrpSerConc[iCont];
  		}
  		*piNumGrpSerConc=TaS.pDataTable[ID_GRPSERCONC].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CONVERSION, TaS.pDataTable,0,(void*)&TaS.pstlGeConversion,&TaS.lGeConversion);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CONVERSION].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CONVERSION].lTotalRegistros;iCont++)
  		{
  			pstlGeConversion[iCont]=TaS.pstlGeConversion[iCont];
  		}
  		*piNumConversion=TaS.pDataTable[ID_CONVERSION].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_DOCUMSUCURSAL, TaS.pDataTable,0,(void*)&TaS.pstlGeDocumSucursal,&TaS.lGeDocumSucursal);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_DOCUMSUCURSAL].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_DOCUMSUCURSAL].lTotalRegistros;iCont++)
  		{
  			pstlGeDocumSucursal[iCont]=TaS.pstlGeDocumSucursal[iCont];
  		}
  		*piNumDocumSucursal=TaS.pDataTable[ID_DOCUMSUCURSAL].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_LETRAS, TaS.pDataTable,0,(void*)&TaS.pstlGeLetras,&TaS.lGeLetras);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_LETRAS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_LETRAS].lTotalRegistros;iCont++)
  		{
  			pstlGeLetras[iCont]=TaS.pstlGeLetras[iCont];
  		}
  		*piNumLetras=TaS.pDataTable[ID_LETRAS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_GRUPOCOB, TaS.pDataTable,0,(void*)&TaS.pstlGeGrupoCob,&TaS.lGeGrupoCob);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_GRUPOCOB].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_GRUPOCOB].lTotalRegistros;iCont++)
  		{
  			pstlGeGrupoCob[iCont]=TaS.pstlGeGrupoCob[iCont];
  		}
  		*piNumGrupoCob=TaS.pDataTable[ID_GRUPOCOB].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_TARIFAS, TaS.pDataTable,0,(void*)&TaS.pstlGeTarifas,&TaS.lGeTarifas);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_TARIFAS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_TARIFAS].lTotalRegistros;iCont++)
  		{
  			pstlGeTarifas[iCont]=TaS.pstlGeTarifas[iCont];
  		}
  		*piNumTarifas=TaS.pDataTable[ID_TARIFAS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_ACTUASERV, TaS.pDataTable,0,(void*)&TaS.pstlGeActuaServ,&TaS.lGeActuaServ);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_ACTUASERV].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_ACTUASERV].lTotalRegistros;iCont++)
  		{
  			pstlGeActuaServ[iCont]=TaS.pstlGeActuaServ[iCont];
  		}
  		*piNumActuaServ=TaS.pDataTable[ID_ACTUASERV].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CUOTAS, TaS.pDataTable,0,(void*)&TaS.pstlGeCuotas,&TaS.lGeCuotas);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CUOTAS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CUOTAS].lTotalRegistros;iCont++)
  		{
  			pstlGeCuotas[iCont]=TaS.pstlGeCuotas[iCont];
  		}
  		*piNumCuotas=TaS.pDataTable[ID_CUOTAS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_FACTCARRIERS, TaS.pDataTable,0,(void*)&TaS.pstlGeFactCarriers,&TaS.lGeFactCarriers);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_FACTCARRIERS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_FACTCARRIERS].lTotalRegistros;iCont++)
  		{
  			pstlGeFactCarriers[iCont]=TaS.pstlGeFactCarriers[iCont];
  		}
  		*piNumFactCarriers=TaS.pDataTable[ID_FACTCARRIERS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CUADCTOPLAN, TaS.pDataTable,0,(void*)&TaS.pstlGeCuadCtoPlan,&TaS.lGeCuadCtoPlan);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CUADCTOPLAN].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CUADCTOPLAN].lTotalRegistros;iCont++)
  		{
  			pstlGeCuadCtoPlan[iCont]=TaS.pstlGeCuadCtoPlan[iCont];
  		}
  		*piNumCuadCtoPlan=TaS.pDataTable[ID_CUADCTOPLAN].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CTOPLAN, TaS.pDataTable,0,(void*)&TaS.pstlGeCtoPlan,&TaS.lGeCtoPlan);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CTOPLAN].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CTOPLAN].lTotalRegistros;iCont++)
  		{
  			pstlGeCtoPlan[iCont]=TaS.pstlGeCtoPlan[iCont];
  		}
  		*piNumCtoPlan=TaS.pDataTable[ID_CTOPLAN].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_PLANCTOPLAN, TaS.pDataTable,0,(void*)&TaS.pstlGePlanCtoPlan,&TaS.lGePlanCtoPlan);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_PLANCTOPLAN].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_PLANCTOPLAN].lTotalRegistros;iCont++)
  		{
  			pstlGePlanCtoPlan[iCont]=TaS.pstlGePlanCtoPlan[iCont];
  		}
  		*piNumPlanCtoPlan=TaS.pDataTable[ID_PLANCTOPLAN].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_ARRIENDO, TaS.pDataTable,0,(void*)&TaS.pstlGeArriendo,&TaS.lGeArriendo);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
    	  	       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_ARRIENDO].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_ARRIENDO].lTotalRegistros;iCont++)
  		{
  			pstlGeArriendo[iCont]=TaS.pstlGeArriendo[iCont];
  		}
  		*piNumArriendo=TaS.pDataTable[ID_ARRIENDO].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_CARGOSBASICO, TaS.pDataTable,0,(void*)&TaS.pstlGeCargosBasico,&TaS.lGeCargosBasico);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CARGOSBASICO].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CARGOSBASICO].lTotalRegistros;iCont++)
  		{
  			pstlGeCargosBasico[iCont]=TaS.pstlGeCargosBasico[iCont];
  		}
  		*piNumCargosBasico=TaS.pDataTable[ID_CARGOSBASICO].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_OPTIMO, TaS.pDataTable,0,(void*)&TaS.pstlGeOptimo,&TaS.lGeOptimo);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_OPTIMO].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_OPTIMO].lTotalRegistros;iCont++)
  		{
  			pstlGeOptimo[iCont]=TaS.pstlGeOptimo[iCont];
  		}
  		*piNumOptimo=TaS.pDataTable[ID_OPTIMO].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_FERIADOS, TaS.pDataTable,0,(void*)&TaS.pstlGeFeriados,&TaS.lGeFeriados);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_FERIADOS].szTableName,
               		strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_FERIADOS].lTotalRegistros;iCont++)
  		{
  			pstlGeFeriados[iCont]=TaS.pstlGeFeriados[iCont];
  		}
  		*piNumFeriados=TaS.pDataTable[ID_FERIADOS].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_PLANTARIF, TaS.pDataTable,0,(void*)&TaS.pstlGePlanTarif,&TaS.lGePlanTarif);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_PLANTARIF].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_PLANTARIF].lTotalRegistros;iCont++)
  		{
  			pstlGePlanTarif[iCont]=TaS.pstlGePlanTarif[iCont];
  		}
  		*piNumPlanTarif=TaS.pDataTable[ID_PLANTARIF].lTotalRegistros;
  	}

  	iError = ifnAttachMemory(ID_PENALIZA, TaS.pDataTable,0,(void*)&TaS.pstlGePenalizaciones,&TaS.lGePenalizaciones);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_PENALIZA].szTableName,
                      	strerror(iError));
    	return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_PENALIZA].lTotalRegistros;iCont++)
  		{
  			pstlGePenalizaciones[iCont]=TaS.pstlGePenalizaciones[iCont];
  		}
  		*piNumPenalizaciones=TaS.pDataTable[ID_PENALIZA].lTotalRegistros;
  	}

	iError = ifnAttachMemory(ID_FAC_CLIENTES, TaS.pDataTable,0,(void*)&TaS.pstlFacClientes,&TaS.lFacClientes);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_FAC_CLIENTES].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}

	iError = ifnAttachMemory(ID_CARGOS, TaS.pDataTable,0,(void*)&TaS.pstlGeCargos,&TaS.lGeCargos);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CARGOS].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}

  	iError = ifnAttachMemory(ID_CICLOCLI, TaS.pDataTable,0,(void*)&TaS.pstlFacCiclo,&TaS.lFacCiclo);
  	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CICLOCLI].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		*plNumFacCiclo=TaS.pDataTable[ID_CICLOCLI].lTotalRegistros;
  	}

	iError = ifnAttachMemory(ID_OFICINA, TaS.pDataTable,0,(void*)&TaS.pstlGeOficina,&TaS.lGeOficina);
        if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_OFICINA].szTableName,
                      	strerror(iError));
    	return FALSE;
  	}
  	else
  	{
		*pstlGeOficina =(OFICINA*) realloc(*pstlGeOficina,(((*piNumOficina)+TaS.lGeOficina)*sizeof(OFICINA)));
		if (!*pstlGeOficina)
		{
			fprintf(stderr,"\nError bfnCargaOficinas: No se pudo reservar memoria.\n");
			return FALSE;
		}
		pstOficinasTemp = &(*pstlGeOficina)[(*piNumOficina)];
		memset(pstOficinasTemp, 0, sizeof(OFICINA)*TaS.lGeOficina);
  		for(iCont=0;iCont<TaS.pDataTable[ID_OFICINA].lTotalRegistros;iCont++)
  		{
  			pstOficinasTemp[iCont]=TaS.pstlGeOficina[iCont];
  		}
  		*piNumOficina=TaS.pDataTable[ID_OFICINA].lTotalRegistros;
  	}

	iError = ifnAttachMemory(ID_FACTCOBR, TaS.pDataTable,0,(void*)&TaS.pstlGeFactCobr,&TaS.lGeFactCobr);
	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_FACTCOBR].szTableName,
                      	strerror(iError));
    	return FALSE;
  	}
  	else
  	{
                *pstlGeFactCobr =(FACTCOBR*) realloc(*pstlGeFactCobr,(((*piNumFactCobr)+TaS.lGeFactCobr)*sizeof(FACTCOBR)));
		if (!*pstlGeFactCobr)
		{
			fprintf(stderr,"\nError bfnCargaFactCobr: No se pudo reservar memoria.\n");
			return FALSE;
		}
		pstFactCobrTemp = &(*pstlGeFactCobr)[(*piNumFactCobr)];
		memset(pstFactCobrTemp, 0, sizeof(FACTCOBR)*TaS.lGeFactCobr);
		for(iCont=0;iCont<TaS.pDataTable[ID_FACTCOBR].lTotalRegistros;iCont++)
  		{
  			pstFactCobrTemp[iCont]=TaS.pstlGeFactCobr[iCont];
  		}
  		*piNumFactCobr=TaS.pDataTable[ID_FACTCOBR].lTotalRegistros;
  	}
  	
 	iError = ifnAttachMemory(ID_CARGOSRECURRENTES, TaS.pDataTable,0,(void*)&TaS.pstlGeCargosRecurrentes,&TaS.lGeCargosRecurrentes);
  	if (iError != 0)
  	{
	    	fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_CARGOSRECURRENTES].szTableName,
                      	strerror(iError));
    		return FALSE;
  	}
  	else
  	{
  		for(iCont=0;iCont<TaS.pDataTable[ID_CARGOSRECURRENTES].lTotalRegistros;iCont++)
  		{
  			pstlGeCargosRecurrentes[iCont]=TaS.pstlGeCargosRecurrentes[iCont];
  		}
  		*piNumCargosRecurrentes=TaS.pDataTable[ID_CARGOSRECURRENTES].lTotalRegistros;
  	}
  	
/*	iError = ifnAttachMemory(ID_DETPLANDESC, TaS.pDataTable,0,(void*)&TaS.pstlGeDetPlanDesc,&TaS.lGeDetPlanDesc);
	if (iError != 0)
  	{
    		fprintf(stderr,  "\n\nERROR(bfnAttachMemory):"
      		       "\n\tError al mapear la memoria para la tabla %s"
      		       "\nError: [%s]", TaS.pDataTable[ID_DETPLANDESC].szTableName,
                      	strerror(iError));
    	return FALSE;
  	}
  	else
  	{
        *pstlGeDetPlanDesc =(DETPLANDESC*) realloc(*pstlGeDetPlanDesc,(((*piNumDetPlanDesc)+TaS.lGeFactCobr)*sizeof(DETPLANDESC)));
		if (!*pstlGeDetPlanDesc)
		{
			fprintf(stderr,"\nError bfnCargaDetPlanDesc: No se pudo reservar memoria.\n");
			return FALSE;
		}
		pstDetPlanDescTemp = &(*pstlGeDetPlanDesc)[(*piNumDetPlanDesc)];
		memset(pstDetPlanDescTemp, 0, sizeof(DETPLANDESC)*TaS.lGeFactCobr);
		for(iCont=0;iCont<TaS.pDataTable[ID_DETPLANDESC].lTotalRegistros;iCont++)
  		{
  			pstDetPlanDescTemp[iCont]=TaS.pstlGeDetPlanDesc[iCont];
  		}
  		*piNumDetPlanDesc=TaS.pDataTable[ID_DETPLANDESC].lTotalRegistros;
  	}
*/
  	return TRUE;
}

/******************************************************************************
Funcion         :       bfnProcesarClientes
*******************************************************************************/

BOOL bfnProcesarClientes(FAC_CLIENTES **pstCliente,CICLOCLI *pstlFacCiclo,long *piNumAbonados,long plNumFacCiclo, int iSemId)
{
	static long iInd = 0;
	long i=0;
	BOOL bFinAbonados=FALSE;
	long j=0;

	fprintf(stderr,"\n\t\t*****Intenta Tomar Cliente TaS.pstlFacClientes[%ld]****"      
	               "\n\t\t*****De un total de [%ld] Clientes \n"
	               "\n\t\t*****Abonados [%ld] Clientes \n"
	               , iInd, TaS.lFacClientes, plNumFacCiclo);
	while (iInd < TaS.lFacClientes)
	{
/*		fprintf(stderr,"\n\t\tEspera a lokear semáforo (poner en rojo), para consultar por recurso de CLIENTES.\n"); */
		lock(iSemId);	                                                                                            
/*		fprintf(stderr,"\n\t\tSemáforo en ROJO, el recurso CLIENTES está lockeado.\n");                              */
		
		if ( TaS.pstlFacClientes[iInd].iCodEstado == EST_INICIAL)
		{
			TaS.pstlFacClientes[iInd].iCodEstado=EST_RAO;                                                             

/*			fprintf(stderr,"\n\t\tCliente en la pos.[%d] ESTA DISPONIBLE... procede a marcarlo con EST_RAO.\n", iInd); */

			unlock(iSemId);                                                                                           

/*			fprintf(stderr,"\n\t\tSemáforo en VERDE, el recurso CLIENTES está disponible.\n");                        */

/*			fprintf(stderr,"\n\t\tCarga Clientes[i] en memoria.\n", iInd);                                            */
		    *pstCliente = &TaS.pstlFacClientes[iInd];
			
		    i=TaS.pstlFacClientes[iInd].lRowNum;
		    while(i<plNumFacCiclo && bFinAbonados==FALSE)
		    {
				if(TaS.pstlFacCiclo[i].lCodCliente==TaS.pstlFacClientes[iInd].lCodCliente)
				{
			    	pstlFacCiclo[j]=TaS.pstlFacCiclo[i];
		            j++;
		        }
				if(j!=0 && TaS.pstlFacCiclo[i].lCodCliente!=TaS.pstlFacClientes[iInd].lCodCliente)
			    	bFinAbonados=TRUE;
			    i++;
		    }

		    if(j==0)
		    {
				fprintf(stderr,"\n----No se encontro abonados para cliente [%ld]----\n",TaS.pstlFacClientes[iInd].lCodCliente);
	        }

		    *piNumAbonados=j;
	            return TRUE;

		}
		else
		{
			fprintf(stderr,"\n\t\tCliente[%ld] no está disponible !=EST_INICIAL ----\n",iInd);
			unlock(iSemId);
			fprintf(stderr,"\n\t\tSemáforo en VERDE, el recurso CLIENTES está disponible.\n");
			iInd++;
		}
	}

	return FALSE;
}

/******************************************************************************
Funcion         :       bCargaCargos_MC
*******************************************************************************/
/*bool bCargaCargos_MC(CARGOS *pCargos,int *piNumCargos,int iTipoFact,long lNumTransaccion,long lNumVenta, long lCodCliente, long lCargos) */
BOOL bCargaCargos_MC(CARGOS *pCargos,long *piNumCargos,int iTipoFact,long lNumTransaccion,long lNumVenta, long lCodCliente, long lCargos)  /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 
{
	long iInd=0;
  BOOL bFinCargos=FALSE;
	long iCont=0; /* PGG SOPORTE 43878 MAX_CARGOS > 65000 se cambia de int a long 11-10-2007 */ 

	fprintf(stderr,
			"\n\t\t************* bCargaCargos_MC *************"
			"\n\t\tlCodCliente     :[%ld]"
			"\n\t\tpiNumCargos     :[%ld]"
			"\n\t\tiTipoFact       :[%d]"
			"\n\t\tlNumTransaccion :[%ld]"
			"\n\t\tlNumVenta       :[%ld]"
			"\n\t\tlCargos         :[%ld]"
			, lCodCliente, *piNumCargos, iTipoFact, lNumTransaccion, lNumVenta, lCargos);

	if(lCargos!=-1)
	{
		iInd=lCargos;
		while(iInd<TaS.lGeCargos && bFinCargos==FALSE)
		{
			if(TaS.pstlGeCargos[iInd].lCodCliente==lCodCliente)
			{
				fprintf(stderr,"\n\t\tCarga Estructura pCargos[%ld]", iCont);
				pCargos[iCont].lNumVenta=lNumVenta;
				pCargos[iCont]=TaS.pstlGeCargos[iInd];
				iCont++;
			}
			if(iCont!=0 && TaS.pstlGeCargos[iInd].lCodCliente!=lCodCliente)
			{
				fprintf(stderr,"\n\t\tTotal de Cargos Recuperados:[%ld] >Cambia de Cliente Estructura TaS.pstlGeCargos[%ld]\n", iCont, iInd);
				bFinCargos=TRUE;
			}
			iInd++;
		}
	}

	*piNumCargos = iCont;

 	qsort(pCargos,*piNumCargos,sizeof(CARGOS),iCmpCargos);
	vPrintCargos(pCargos,iCont);
	

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnCreaSemaforo
*******************************************************************************/
int valor_semaforo(int sem_id)
{
   int ret=semctl(sem_id,0,GETVAL,0);
   return ret;
}
int bfnCreaSemaforo(void)
{
    int ret = 0;
    int iValSem = 0;
    operaciones[0].sem_num =  0;
    operaciones[0].sem_op  =  1;
    operaciones[0].sem_flg =  0;

	fprintf(stdout, "\n(bfnCreaSemaforo)Usa el valor de TaS.kSemKey:[%d]\n", TaS.kSemKey);
	ret = semget(TaS.kSemKey,1,IPC_CREAT|0666 ); 

    if (ret == -1)
    {
        fprintf(stdout, "\n(bfnCreaSemaforo)No consiguio Id para Semaforo\n");
        return 0;
    }
    fprintf(stdout, "\n(bfnCreaSemaforo)Semaforo creado con ID : [%d]\n", ret);
    iValSem = valor_semaforo(ret);
    switch(iValSem )
    {
    	case 0:
	    	fprintf(stdout, "\n\t****Semaforo creado en ROJO.\n"
	    	                "\n\t****Se cambia estado a VERDE.\n");
	    	unlock(ret);
    		break;
    	case 1:
    		fprintf(stdout, "\n\t****Semaforo creado en VERDE.\n");
    		break;
    	default:
    		fprintf(stdout, "\n\t****Semaforo En estado INDETERMINADO:[%d].\n", iValSem);
    		ret = 0;
    		break;
    }
    return ret;
}
int lock(int sem_id)
{
   int ret = 0;
   operaciones[0].sem_num =  0;
   operaciones[0].sem_op  = -1;
   operaciones[0].sem_flg =  0;

   while(ret==0)
   {
       ret=valor_semaforo(sem_id);
       if (ret==1)
       {
/*           fprintf(stdout, "\n(lock)Cambiando a Rojo\n"); */
           semop(sem_id,operaciones,1);
           return 0;
       }
/*       fprintf(stdout, "\n(lock)Semaforo en Rojo\n"); */
   }
}

int unlock(int sem_id)
{
    int ret = 1;
    operaciones[0].sem_num =  0;
    operaciones[0].sem_op  =  1;
    operaciones[0].sem_flg =  0;
    while(ret==1)
    {
        ret=valor_semaforo(sem_id);
        if (ret==0)
        {
/*             fprintf(stdout, "\n(unlock)Cambiando a Verde\n"); */
             semop(sem_id,operaciones,1);
             return 0;
        }
        else if (ret==1)
        {
/*          fprintf(stdout, "\n(unlock)Semaforo ya esta en Verde\n"); */
			return 1;
		}
    }
}

