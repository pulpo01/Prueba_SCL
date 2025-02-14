#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <unistd.h>
//#include <time.h>
#include <pthread.h>
#include <errno.h>

#include "tipos.h"
#include "shared.h"
#include "tablas.h"
#include "general.h"

/******************************************************************************
Funcion         :       bfnObtGeCargos
*******************************************************************************/

BOOL bfnObtGeCargos ( long *lGeCargos,CARGOS **pstlGeCargos,void* ctx, long ciclo, long ci, long cf)
{
	int iOra;
	long lNumFilas;
	static CARGOS_HOST stlGeCargosHost;
	static	CARGOS_HOST_NULL stlGeCargosHostNull;
	CARGOS *pstlGeCargosTemp;
	long lCont;

 	*lGeCargos = 0;
 	*pstlGeCargos = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CARGOS");
	iOra=ifnOraDeclararGeCargos (ctx,ciclo, ci, cf);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargos):\n\tError al declarar cursor sobre CARGOS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCargos(&stlGeCargosHost,&stlGeCargosHostNull,&lNumFilas,ctx,ci,cf);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargos):"
			"\n\tError al  realizar el FETCH sobre CARGOS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

 		*pstlGeCargos =(CARGOS*) realloc(*pstlGeCargos,(((*lGeCargos)+lNumFilas)*sizeof(CARGOS)));

		if (!*pstlGeCargos)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargos):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCargosTemp = &(*pstlGeCargos)[(*lGeCargos)];
		memset(pstlGeCargosTemp, 0, sizeof(CARGOS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{

			strcpy(pstlGeCargosTemp[lCont].szRowid,stlGeCargosHost.szRowid[lCont]);
			pstlGeCargosTemp[lCont].lNumCargo = stlGeCargosHost.lNumCargo[lCont];

			if(stlGeCargosHostNull.slNumVenta[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lNumVenta = stlGeCargosHost.lNumVenta[lCont];
			else
                                pstlGeCargosTemp[lCont].lNumVenta=-1;

			pstlGeCargosTemp[lCont].lCodCliente = stlGeCargosHost.lCodCliente[lCont];
			pstlGeCargosTemp[lCont].iCodProducto = stlGeCargosHost.iCodProducto[lCont];
			pstlGeCargosTemp[lCont].iCodConcepto = stlGeCargosHost.iCodConcepto[lCont];
			strcpy(pstlGeCargosTemp[lCont].szFecAlta,stlGeCargosHost.szFecAlta[lCont]);
			pstlGeCargosTemp[lCont].dImpCargo = stlGeCargosHost.dImpCargo[lCont];
			strcpy(pstlGeCargosTemp[lCont].szCodMoneda,stlGeCargosHost.szCodMoneda[lCont]);
			pstlGeCargosTemp[lCont].lCodPlanCom = stlGeCargosHost.lCodPlanCom[lCont];
			pstlGeCargosTemp[lCont].lNumUnidades = stlGeCargosHost.lNumUnidades[lCont];
			if(stlGeCargosHostNull.slNumAbonado[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lNumAbonado=stlGeCargosHost.lNumAbonado[lCont];
			else
				pstlGeCargosTemp[lCont].lNumAbonado=-1;
			if(stlGeCargosHostNull.sszNumTerminal[lCont] != ORA_NULL)
				strcpy(pstlGeCargosTemp[lCont].szNumTerminal,stlGeCargosHost.szNumTerminal[lCont]);
			else
                                pstlGeCargosTemp[lCont].szNumTerminal[0]=0;
			/*	strcpy(pstlGeCargosTemp[lCont].szNumTerminal,"0");	*/
			if(stlGeCargosHostNull.slCodCiclFact[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lCodCiclFact=stlGeCargosHost.lCodCiclFact[lCont];
			else
				pstlGeCargosTemp[lCont].lCodCiclFact=-1;
			if(stlGeCargosHostNull.sszNumSerie[lCont] != ORA_NULL)
				strcpy(pstlGeCargosTemp[lCont].szNumSerie,stlGeCargosHost.szNumSerie[lCont]);
			else
                                pstlGeCargosTemp[lCont].szNumSerie[0]=0;
			/*	strcpy(pstlGeCargosTemp[lCont].szNumSerie,"0");	*/
			if(stlGeCargosHostNull.sszNumSerieMec[lCont] != ORA_NULL)
				strcpy(pstlGeCargosTemp[lCont].szNumSerieMec,stlGeCargosHost.szNumSerieMec[lCont]);
			else
				pstlGeCargosTemp[lCont].szNumSerieMec[0]=0;
			/*	strcpy(pstlGeCargosTemp[lCont].szNumSerieMec,"0");	*/
			if(stlGeCargosHostNull.slCapCode[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lCapCode=stlGeCargosHost.lCapCode[lCont];
			else
				pstlGeCargosTemp[lCont].lCapCode=-1;
			if(stlGeCargosHostNull.siIndCuota[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iIndCuota=stlGeCargosHost.iIndCuota[lCont];
			else
				pstlGeCargosTemp[lCont].iIndCuota=-1;
			if(stlGeCargosHostNull.siMesGarantia[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iMesGarantia=stlGeCargosHost.iMesGarantia[lCont];
			else
				pstlGeCargosTemp[lCont].iMesGarantia=-1;
			if(stlGeCargosHostNull.sszNumPreGuia[lCont] != ORA_NULL)
				strcpy(pstlGeCargosTemp[lCont].szNumPreGuia,stlGeCargosHost.szNumPreGuia[lCont]);
			else
				pstlGeCargosTemp[lCont].szNumPreGuia[0]=0;
			/*	strcpy(pstlGeCargosTemp[lCont].szNumPreGuia,"0");	*/
			if(stlGeCargosHostNull.sszNumGuia[lCont] != ORA_NULL)
				strcpy(pstlGeCargosTemp[lCont].szNumGuia,stlGeCargosHost.szNumGuia[lCont]);
			else
				pstlGeCargosTemp[lCont].szNumGuia[0]=0;
			/*	strcpy(pstlGeCargosTemp[lCont].szNumGuia,"0");	*/

                        if(stlGeCargosHostNull.slNumTransaccion[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lNumTransaccion = stlGeCargosHost.lNumTransaccion[lCont];
			else
                                pstlGeCargosTemp[lCont].lNumTransaccion=-1;

			if(stlGeCargosHostNull.slNumFactura[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].lNumFactura = stlGeCargosHost.lNumFactura[lCont];
			else
                                pstlGeCargosTemp[lCont].lNumFactura=-1;

			if(stlGeCargosHostNull.siCodConceptoDto[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iCodConceptoDto=stlGeCargosHost.iCodConceptoDto[lCont];
			else
				pstlGeCargosTemp[lCont].iCodConceptoDto=-1;
			if(stlGeCargosHostNull.sdValDto[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].dValDto=stlGeCargosHost.dValDto[lCont];
			else
				pstlGeCargosTemp[lCont].dValDto=-1;
			if(stlGeCargosHostNull.siTipDto[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iTipDto=stlGeCargosHost.iTipDto[lCont];
			else
				pstlGeCargosTemp[lCont].iTipDto=-1;
			pstlGeCargosTemp[lCont].iIndFactur = stlGeCargosHost.iIndFactur[lCont];
			if(stlGeCargosHostNull.siNumPaquete[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iNumPaquete=stlGeCargosHost.iNumPaquete[lCont];
			else
				pstlGeCargosTemp[lCont].iNumPaquete=-1;
			if(stlGeCargosHostNull.siIndSuperTel[lCont] != ORA_NULL)
				pstlGeCargosTemp[lCont].iIndSuperTel=stlGeCargosHost.iIndSuperTel[lCont];
			else
				pstlGeCargosTemp[lCont].iIndSuperTel=-1;
				
			pstlGeCargosTemp[lCont].iFlagFaCargo=0;
		}

		(*lGeCargos) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCargos);

	iOra=ifnOraCerrarGeCargos(ctx,ci,cf);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargos):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCargos, *lGeCargos, sizeof(CARGOS),ifnCompareGeCargos);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCargosRecurrentes
*******************************************************************************/
BOOL bfnObtGeCargosRecurrentes ( long *lGeCargosRecurrentes,CARGOSRECURRENTES **pstlGeCargosRecurrentes,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CARGOSRECURRENTES_HOST stlGeCargosRecurrentesHost;
	static	CARGOSRECURRENTES_HOST_NULL stlGeCargosRecurrentesHostNull;
	CARGOSRECURRENTES *pstlGeCargosRecurrentesTemp;
	long lCont;

 	*lGeCargosRecurrentes = 0;
 	*pstlGeCargosRecurrentes = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CARGOSRECURRENTES");
	iOra=ifnOraDeclararGeCargosRecurrentes (ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosRecurrentes):\n\tError al declarar cursor sobre CARGOSRECURRENTES");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCargosRecurrentes(&stlGeCargosRecurrentesHost,&stlGeCargosRecurrentesHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosRecurrentes):"
			"\n\tError al  realizar el FETCH sobre CARGOSRECURRENTES");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

 		*pstlGeCargosRecurrentes =(CARGOSRECURRENTES*) realloc(*pstlGeCargosRecurrentes,(((*lGeCargosRecurrentes)+lNumFilas)*sizeof(CARGOSRECURRENTES)));

		if (!*pstlGeCargosRecurrentes)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosRecurrentes):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCargosRecurrentesTemp = &(*pstlGeCargosRecurrentes)[(*lGeCargosRecurrentes)];
		memset(pstlGeCargosRecurrentesTemp, 0, sizeof(CARGOSRECURRENTES)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
		    
		    pstlGeCargosRecurrentesTemp[lCont].lCodCargo = stlGeCargosRecurrentesHost.lCodCargo[lCont];
		    pstlGeCargosRecurrentesTemp[lCont].dMontoImporte = stlGeCargosRecurrentesHost.dMontoImporte[lCont];
		    strcpy(pstlGeCargosRecurrentesTemp[lCont].szCodMoneda,stlGeCargosRecurrentesHost.szCodMoneda[lCont]);
		}

		(*lGeCargosRecurrentes) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCargosRecurrentes);

	iOra=ifnOraCerrarGeCargosRecurrentes(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosRecurrentes):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCabCuotas
*******************************************************************************/

BOOL bfnObtGeCabCuotas ( long *lGeCabCuotas,CABCUOTAS **pstlGeCabCuotas,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CABCUOTAS_HOST stlGeCabCuotasHost;
	static	CABCUOTAS_HOST_NULL stlGeCabCuotasHostNull;
	CABCUOTAS *pstlGeCabCuotasTemp;
	long lCont;

 	*lGeCabCuotas = 0;
 	*pstlGeCabCuotas = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CABCUOTAS");
	iOra= ifnOraDeclararGeCabCuotas (ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCabCuotas):"
		"\n\tError al declarar cursor sobre CABCUOTAS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCabCuotas(&stlGeCabCuotasHost,&stlGeCabCuotasHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCabCuotas):"
		"\n\tError al  realizar el FETCH sobre CABCUOTAS");
		vfnImpErrorORACLE();
		return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCabCuotas =(CABCUOTAS*) realloc(*pstlGeCabCuotas,(((*lGeCabCuotas)+lNumFilas)*sizeof(CABCUOTAS)));

		if (!*pstlGeCabCuotas)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCabCuotas):"
		"\n\tError al alocar memoria"
		"\n\tError: [%d][%s]", errno, strerror(errno));
		return FALSE;
		}

		pstlGeCabCuotasTemp = &(*pstlGeCabCuotas)[(*lGeCabCuotas)];
		memset(pstlGeCabCuotasTemp, 0, sizeof(CABCUOTAS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeCabCuotasTemp[lCont].szRowid,stlGeCabCuotasHost.szRowid[lCont]);
			pstlGeCabCuotasTemp[lCont].lSeqCuotas = stlGeCabCuotasHost.lSeqCuotas[lCont];
			pstlGeCabCuotasTemp[lCont].lCodCliente = stlGeCabCuotasHost.lCodCliente[lCont];
			pstlGeCabCuotasTemp[lCont].iCodConcepto = stlGeCabCuotasHost.iCodConcepto[lCont];
			strcpy(pstlGeCabCuotasTemp[lCont].szCodMoneda,stlGeCabCuotasHost.szCodMoneda[lCont]);
			pstlGeCabCuotasTemp[lCont].iCodProducto = stlGeCabCuotasHost.iCodProducto[lCont];
			pstlGeCabCuotasTemp[lCont].iNumCuotas = stlGeCabCuotasHost.iNumCuotas[lCont];
			pstlGeCabCuotasTemp[lCont].dImpTotal = stlGeCabCuotasHost.dImpTotal[lCont];
			pstlGeCabCuotasTemp[lCont].iIndPagada = stlGeCabCuotasHost.iIndPagada[lCont];
			pstlGeCabCuotasTemp[lCont].lNumAbonado = stlGeCabCuotasHost.lNumAbonado[lCont];

			if(stlGeCabCuotasHostNull.sszCodCuota[lCont] != ORA_NULL)
				strcpy(pstlGeCabCuotasTemp[lCont].szCodCuota,stlGeCabCuotasHost.szCodCuota[lCont]);
			else
				strcpy(pstlGeCabCuotasTemp[lCont].szCodCuota, "");

			pstlGeCabCuotasTemp[lCont].lNumPagare = stlGeCabCuotasHost.lNumPagare[lCont];

		}

		(*lGeCabCuotas) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCabCuotas);

	iOra=ifnOraCerrarGeCabCuotas(ctx);
	if (iOra != SQL_OK)
	{
	vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCabCuotas):"
	"\n\tError al cerrar el cursor");
	vfnImpErrorORACLE();
	return FALSE;
	}

	qsort((void*)*pstlGeCabCuotas, *lGeCabCuotas, sizeof(CABCUOTAS),ifnCompareGeCabCuotas);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeTaConcepFact
*******************************************************************************/

BOOL bfnObtGeTaConcepFact ( long *lGeTaConcepFact,TACONCEPFACT **pstlGeTaConcepFact,void* ctx)
{
	int iOra;
	long lNumFilas;
	static TACONCEPFACT_HOST stlGeTaConcepFactHost;
	TACONCEPFACT *pstlGeTaConcepFactTemp;
	long lCont;


	 *lGeTaConcepFact = 0;
	 *pstlGeTaConcepFact = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: TACONCEPFACT");
	iOra=ifnOraDeclararGeTaConcepFact (ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTaConcepFact):"
		"\n\tError al declarar cursor sobre TACONCEPFACT");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeTaConcepFact(&stlGeTaConcepFactHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTaConcepFact):"
			"\n\tError al  realizar el FETCH sobre TACONCEPFACT");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

	 	*pstlGeTaConcepFact =(TACONCEPFACT*) realloc(*pstlGeTaConcepFact,(((*lGeTaConcepFact)+lNumFilas)*sizeof(TACONCEPFACT)));

		if (!*pstlGeTaConcepFact)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTaConcepFact):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeTaConcepFactTemp = &(*pstlGeTaConcepFact)[(*lGeTaConcepFact)];
		memset(pstlGeTaConcepFactTemp, 0, sizeof(TACONCEPFACT)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeTaConcepFactTemp[lCont].iCodProducto = stlGeTaConcepFactHost.iCodProducto[lCont];
			pstlGeTaConcepFactTemp[lCont].iCodFacturacion = stlGeTaConcepFactHost.iCodFacturacion[lCont];
			pstlGeTaConcepFactTemp[lCont].iIndTabla = stlGeTaConcepFactHost.iIndTabla[lCont];
			pstlGeTaConcepFactTemp[lCont].iIndEntSal = stlGeTaConcepFactHost.iIndEntSal[lCont];
			pstlGeTaConcepFactTemp[lCont].iIndDestino = stlGeTaConcepFactHost.iIndDestino[lCont];
			pstlGeTaConcepFactTemp[lCont].iCodTarificacion = stlGeTaConcepFactHost.iCodTarificacion[lCont];
			strcpy(pstlGeTaConcepFactTemp[lCont].szCodServicio,stlGeTaConcepFactHost.szCodServicio[lCont]);

		}

		(*lGeTaConcepFact) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeTaConcepFact);

	iOra=ifnOraCerrarGeTaConcepFact(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTaConcepFact):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeTaConcepFact, *lGeTaConcepFact, sizeof(TACONCEPFACT),ifnCompareGeTaConcepFact);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeConceptos
*******************************************************************************/

BOOL bfnObtGeConceptos ( long *lGeConceptos,CONCEPTO **pstlGeConc,void* ctx, long lCodCiclFact)
{
	int iOra;
	long lNumFilas;
	static CONCEPTO_HOST stlGeConcHost;
	static	CONCEPTO_HOST_NULL stlGeConcHostNull;
	CONCEPTO *stlGeConcTemp;
	long lCont;
	 long lIndConc = 0;

	 *lGeConceptos = 10000; /* se fija momentaneamente al tamaño de MAX_CONCEPTOS */
	 *pstlGeConc = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CONCEPTO");
	
	*pstlGeConc =(CONCEPTO*) realloc(*pstlGeConc,((*lGeConceptos)*sizeof(CONCEPTO))); /* se fija momentaneamente al tamaño de MAX_CONCEPTOS */
	
	if (!*pstlGeConc)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos):"
		"\n\tError al alocar memoria"
		"\n\tError: [%d][%s]", errno, strerror(errno));
		return FALSE;
	}
	
	iOra= ifnOraDeclararGeConceptos ( ctx, lCodCiclFact);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos):"
		"\n\tError al declarar cursor sobre CONCEPTO");
		vfnImpErrorORACLE();
		return FALSE;
	}

	stlGeConcTemp = &(*pstlGeConc)[0];
	memset(stlGeConcTemp, 0, sizeof(CONCEPTO)*10000);
	
	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeConceptos(&stlGeConcHost,&stlGeConcHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos):"
			"\n\tError al  realizar el FETCH sobre CONCEPTO");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			lIndConc = stlGeConcHost.iCodConcepto[lCont]; /* codigo de concepto */
			
			stlGeConcTemp[lIndConc].iFlagExiste  = 1; /* el concepto esta configurado */
			stlGeConcTemp[lIndConc].iCodProducto = stlGeConcHost.iCodProducto[lCont];
			strcpy(stlGeConcTemp[lIndConc].szDesConcepto,stlGeConcHost.szDesConcepto[lCont]);
			stlGeConcTemp[lIndConc].iCodTipConce = stlGeConcHost.iCodTipConce[lCont];
			strcpy(stlGeConcTemp[lIndConc].szCodModulo,stlGeConcHost.szCodModulo[lCont]);
			strcpy(stlGeConcTemp[lIndConc].szCodMoneda,stlGeConcHost.szCodMoneda[lCont]);
			stlGeConcTemp[lIndConc].iIndActivo = stlGeConcHost.iIndActivo[lCont];

			if(stlGeConcHostNull.siCodConcOrig[lIndConc] != ORA_NULL)
				stlGeConcTemp[lIndConc].iCodConcOrig=stlGeConcHost.iCodConcOrig[lCont];
			else
				stlGeConcTemp[lIndConc].iCodConcOrig=-1;

			if(stlGeConcHostNull.sszCodTipDescu[lCont] != ORA_NULL)
				strcpy(stlGeConcTemp[lIndConc].szCodTipDescu,stlGeConcHost.szCodTipDescu[lCont]);
			else
				strcpy(stlGeConcTemp[lIndConc].szCodTipDescu, "");

			stlGeConcTemp[lIndConc].iCodConCobr = stlGeConcHost.iCodConCobr[lCont];
			
			if(stlGeConcHostNull.slFactor[lCont] != ORA_NULL)
				stlGeConcTemp[lIndConc].lFactor = stlGeConcHost.lFactor[lCont];
			else
				stlGeConcTemp[lIndConc].lFactor = 1;
				
			stlGeConcTemp[lIndConc].iCodGrpServi = stlGeConcHost.iCodGrpServi[lCont];
		}
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeConceptos);

	iOra=ifnOraCerrarGeConceptos(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeConceptos_Mi
*******************************************************************************/

BOOL bfnObtGeConceptos_Mi ( long *lGeConceptos_Mi,CONCEPTO_MI **pstlGeConceptos_Mi,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CONCEPTO_MI_HOST stlGeConceptos_MiHost;
	CONCEPTO_MI *pstlGeConceptos_MiTemp;
	long lCont;

	 *lGeConceptos_Mi = 0;
	 *pstlGeConceptos_Mi = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CONCEPTO_MI");
	iOra= ifnOraDeclararGeConceptos_Mi (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos_Mi):"
		"\n\tError al declarar cursor sobre CONCEPTO_MI");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeConceptos_Mi(&stlGeConceptos_MiHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos_Mi):"
			"\n\tError al  realizar el FETCH sobre CONCEPTO_MI");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeConceptos_Mi =(CONCEPTO_MI*) realloc(*pstlGeConceptos_Mi,(((*lGeConceptos_Mi)+lNumFilas)*sizeof(CONCEPTO_MI)));

		if (!*pstlGeConceptos_Mi)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos_Mi):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeConceptos_MiTemp = &(*pstlGeConceptos_Mi)[(*lGeConceptos_Mi)];
		memset(pstlGeConceptos_MiTemp, 0, sizeof(CONCEPTO_MI)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeConceptos_MiTemp[lCont].iCodConcepto=stlGeConceptos_MiHost.iCodConcepto[lCont];
			strcpy(pstlGeConceptos_MiTemp[lCont].szCodIdioma,stlGeConceptos_MiHost.szCodIdioma[lCont]);
			strcpy(pstlGeConceptos_MiTemp[lCont].szDesConcepto,stlGeConceptos_MiHost.szDesConcepto[lCont]);

		}

		(*lGeConceptos_Mi) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeConceptos_Mi);

	iOra=ifnOraCerrarGeConceptos_Mi(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConceptos_Mi):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeConceptos_Mi, *lGeConceptos_Mi, sizeof(CONCEPTO_MI),ifnCompareGeConceptos_Mi);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeRangoTabla
*******************************************************************************/

BOOL bfnObtGeRangoTabla ( long *lGeRangoTabla,RANGOTABLA **pstlGeRangoTabla,void* ctx)
{
	int iOra;
	long lNumFilas;
	static RANGOTABLA_HOST stlGeRangoTablaHost;
	RANGOTABLA *pstlGeRangoTablaTemp;
	long lCont;


	 *lGeRangoTabla = 0;
	 *pstlGeRangoTabla = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: RANGOTABLA");
	iOra=ifnOraDeclararGeRangoTabla (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRangoTabla):"
		"\n\tError al declarar cursor sobre RANGOTABLA");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeRangoTabla(&stlGeRangoTablaHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRangoTabla):"
			"\n\tError al  realizar el FETCH sobre RANGOTABLA");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeRangoTabla =(RANGOTABLA*) realloc(*pstlGeRangoTabla,(((*lGeRangoTabla)+lNumFilas)*sizeof(RANGOTABLA)));

		if (!*pstlGeRangoTabla)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRangoTabla):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeRangoTablaTemp = &(*pstlGeRangoTabla)[(*lGeRangoTabla)];
		memset(pstlGeRangoTablaTemp, 0, sizeof(RANGOTABLA)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeRangoTablaTemp[lCont].lCodCiclFact = stlGeRangoTablaHost.lCodCiclFact[lCont];
			pstlGeRangoTablaTemp[lCont].lRangoIni = stlGeRangoTablaHost.lRangoIni[lCont];
			pstlGeRangoTablaTemp[lCont].lRangoFin = stlGeRangoTablaHost.lRangoFin[lCont];
			pstlGeRangoTablaTemp[lCont].iCodProducto = stlGeRangoTablaHost.iCodProducto[lCont];
			strcpy(pstlGeRangoTablaTemp[lCont].szNomTabla,stlGeRangoTablaHost.szNomTabla[lCont]);

		}

		(*lGeRangoTabla) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeRangoTabla);

	iOra=ifnOraCerrarGeRangoTabla(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRangoTabla):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeRangoTabla, *lGeRangoTabla, sizeof(RANGOTABLA),ifnCompareGeRangoTabla);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeLimCreditos
*******************************************************************************/

BOOL bfnObtGeLimCreditos ( long *lGeLimCreditos,LIMCREDITOS **pstlGeLimCreditos,void* ctx)
{
	int iOra;
	long lNumFilas;
	static LIMCREDITOS_HOST stlGeLimCreditosHost;
	LIMCREDITOS *pstlGeLimCreditosTemp;
	long lCont;


	 *lGeLimCreditos = 0;
	 *pstlGeLimCreditos = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: LIMCREDITOS");
	iOra=ifnOraDeclararGeLimCreditos (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLimCreditos):"
		"\n\tError al declarar cursor sobre LIMCREDITOS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeLimCreditos(&stlGeLimCreditosHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLimCreditos):"
			"\n\tError al  realizar el FETCH sobre LIMCREDITOS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeLimCreditos =(LIMCREDITOS*) realloc(*pstlGeLimCreditos,(((*lGeLimCreditos)+lNumFilas)*sizeof(LIMCREDITOS)));

		if (!*pstlGeLimCreditos)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLimCreditos):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeLimCreditosTemp = &(*pstlGeLimCreditos)[(*lGeLimCreditos)];
		memset(pstlGeLimCreditosTemp, 0, sizeof(LIMCREDITOS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeLimCreditosTemp[lCont].iCodCredMor = stlGeLimCreditosHost.iCodCredMor[lCont];
			pstlGeLimCreditosTemp[lCont].iCodProducto  = stlGeLimCreditosHost.iCodProducto [lCont];
			strcpy(pstlGeLimCreditosTemp[lCont].szCodCalClien,stlGeLimCreditosHost.szCodCalClien[lCont]);
			pstlGeLimCreditosTemp[lCont].dImpMorosidad = stlGeLimCreditosHost.dImpMorosidad[lCont];
		}

		(*lGeLimCreditos) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeLimCreditos);

	iOra=ifnOraCerrarGeLimCreditos(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLimCreditos):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeLimCreditos, *lGeLimCreditos, sizeof(LIMCREDITOS),ifnCompareGeLimCreditos);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeActividades
*******************************************************************************/

BOOL bfnObtGeActividades ( long *lGeActividades,ACTIVIDADES **pstlGeActividades,void* ctx)
{
	int iOra;
	long lNumFilas;
	static ACTIVIDADES_HOST stlGeActividadesHost;
	ACTIVIDADES *pstlGeActividadesTemp;
	long lCont;


	 *lGeActividades = 0;
	 *pstlGeActividades = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: ACTIVIDADES");
	iOra= ifnOraDeclararGeActividades (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActividades):"
		"\n\tError al declarar cursor sobre ACTIVIDADES");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeActividades(&stlGeActividadesHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActividades):"
			"\n\tError al  realizar el FETCH sobre ACTIVIDADES");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeActividades =(ACTIVIDADES*) realloc(*pstlGeActividades,(((*lGeActividades)+lNumFilas)*sizeof(ACTIVIDADES)));

		if (!*pstlGeActividades)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActividades):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeActividadesTemp = &(*pstlGeActividades)[(*lGeActividades)];
		memset(pstlGeActividadesTemp, 0, sizeof(ACTIVIDADES)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeActividadesTemp[lCont].iCodActividad = stlGeActividadesHost.iCodActividad[lCont];
			strcpy(pstlGeActividadesTemp[lCont].szDesActividad,stlGeActividadesHost.szDesActividad[lCont]);

		}

		(*lGeActividades) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeActividades);

	iOra=ifnOraCerrarGeActividades(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActividades):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeActividades, *lGeActividades, sizeof(ACTIVIDADES),ifnCompareGeActividades);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeProvincias
*******************************************************************************/

BOOL bfnObtGeProvincias ( long *lGeProvincias,PROVINCIAS **pstlGeProvincias,void* ctx)
{
	int iOra;
	long lNumFilas;
	static PROVINCIAS_HOST stlGeProvinciasHost;
	PROVINCIAS *pstlGeProvinciasTemp;
	long lCont;


	 *lGeProvincias = 0;
	 *pstlGeProvincias = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: PROVINCIAS");
	iOra= ifnOraDeclararGeProvincias ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeProvincias):"
		"\n\tError al declarar cursor sobre PROVINCIAS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeProvincias(&stlGeProvinciasHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeProvincias):"
			"\n\tError al  realizar el FETCH sobre PROVINCIAS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeProvincias =(PROVINCIAS*) realloc(*pstlGeProvincias,(((*lGeProvincias)+lNumFilas)*sizeof(PROVINCIAS)));

		if (!*pstlGeProvincias)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeProvincias):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeProvinciasTemp = &(*pstlGeProvincias)[(*lGeProvincias)];
		memset(pstlGeProvinciasTemp, 0, sizeof(PROVINCIAS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeProvinciasTemp[lCont].szCodRegion,stlGeProvinciasHost.szCodRegion[lCont]);
			strcpy(pstlGeProvinciasTemp[lCont].szCodProvincia,stlGeProvinciasHost.szCodProvincia[lCont]);
		}

		(*lGeProvincias) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeProvincias);

	iOra=ifnOraCerrarGeProvincias(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeProvincias):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeProvincias, *lGeProvincias, sizeof(PROVINCIAS),ifnCompareGeProvincias);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeRegiones
*******************************************************************************/

BOOL bfnObtGeRegiones ( long *lGeRegiones,REGIONES **pstlGeRegiones,void* ctx)
{
	int iOra;
	long lNumFilas;
	static REGIONES_HOST stlGeRegionesHost;
	REGIONES *pstlGeRegionesTemp;
	long lCont;


	 *lGeRegiones = 0;
	 *pstlGeRegiones = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: REGIONES");
	iOra= ifnOraDeclararGeRegiones ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRegiones):"
		"\n\tError al declarar cursor sobre REGIONES");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeRegiones(&stlGeRegionesHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRegiones):"
			"\n\tError al  realizar el FETCH sobre REGIONES");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeRegiones =(REGIONES*) realloc(*pstlGeRegiones,(((*lGeRegiones)+lNumFilas)*sizeof(REGIONES)));

		if (!*pstlGeRegiones)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRegiones):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeRegionesTemp = &(*pstlGeRegiones)[(*lGeRegiones)];
		memset(pstlGeRegionesTemp, 0, sizeof(REGIONES)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeRegionesTemp[lCont].szCodRegion,stlGeRegionesHost.szCodRegion[lCont]);
			strcpy(pstlGeRegionesTemp[lCont].szDesRegion,stlGeRegionesHost.szDesRegion[lCont]);
		}

		(*lGeRegiones) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeRegiones);

	iOra=ifnOraCerrarGeRegiones(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeRegiones):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeRegiones, *lGeRegiones, sizeof(REGIONES),ifnCompareGeRegiones);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCatImpositiva
*******************************************************************************/

BOOL bfnObtGeCatImpositiva ( long *lGeCatImpositiva,CATIMPOSITIVA **pstlGeCatImpositiva,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CATIMPOSITIVA_HOST stlGeCatImpositivaHost;
	CATIMPOSITIVA *pstlGeCatImpositivaTemp;
	long lCont;


	 *lGeCatImpositiva = 0;
	 *pstlGeCatImpositiva = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CATIMPOSITIVA");
	iOra= ifnOraDeclararGeCatImpositiva ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCatImpositiva):"
		"\n\tError al declarar cursor sobre CATIMPOSITIVA");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCatImpositiva(&stlGeCatImpositivaHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCatImpositiva):"
			"\n\tError al  realizar el FETCH sobre CATIMPOSITIVA");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCatImpositiva =(CATIMPOSITIVA*) realloc(*pstlGeCatImpositiva,(((*lGeCatImpositiva)+lNumFilas)*sizeof(CATIMPOSITIVA)));

		if (!*pstlGeCatImpositiva)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCatImpositiva):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCatImpositivaTemp = &(*pstlGeCatImpositiva)[(*lGeCatImpositiva)];
		memset(pstlGeCatImpositivaTemp, 0, sizeof(CATIMPOSITIVA)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeCatImpositivaTemp[lCont].iCodCatImpos = stlGeCatImpositivaHost.iCodCatImpos[lCont];
			strcpy(pstlGeCatImpositivaTemp[lCont].szDesCatImpos,stlGeCatImpositivaHost.szDesCatImpos[lCont]);
		}

		(*lGeCatImpositiva) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCatImpositiva);

	iOra=ifnOraCerrarGeCatImpositiva(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCatImpositiva):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCatImpositiva, *lGeCatImpositiva, sizeof(CATIMPOSITIVA),ifnCompareGeCatImpositiva);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeZonaCiudad
*******************************************************************************/

BOOL bfnObtGeZonaCiudad ( long *lGeZonaCiudad,ZONACIUDAD **pstlGeZonaCiudad,void* ctx)
{
	int iOra;
	long lNumFilas;
	static ZONACIUDAD_HOST stlGeZonaCiudadHost;
	ZONACIUDAD *pstlGeZonaCiudadTemp;
	long lCont;


	 *lGeZonaCiudad = 0;
	 *pstlGeZonaCiudad = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: ZONACIUDAD");
	iOra= ifnOraDeclararGeZonaCiudad ( ctx);
	if (iOra != SQL_OK)
	{
	vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaCiudad):"
	"\n\tError al declarar cursor sobre ZONACIUDAD");
	vfnImpErrorORACLE();
	return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeZonaCiudad(&stlGeZonaCiudadHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaCiudad):"
			"\n\tError al  realizar el FETCH sobre ZONACIUDAD");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeZonaCiudad =(ZONACIUDAD*) realloc(*pstlGeZonaCiudad,(((*lGeZonaCiudad)+lNumFilas)*sizeof(ZONACIUDAD)));

		if (!*pstlGeZonaCiudad)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaCiudad):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeZonaCiudadTemp = &(*pstlGeZonaCiudad)[(*lGeZonaCiudad)];
		memset(pstlGeZonaCiudadTemp, 0, sizeof(ZONACIUDAD)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeZonaCiudadTemp[lCont].szCodRegion,stlGeZonaCiudadHost.szCodRegion[lCont]);
			strcpy(pstlGeZonaCiudadTemp[lCont].szCodProvincia,stlGeZonaCiudadHost.szCodProvincia[lCont]);
			strcpy(pstlGeZonaCiudadTemp[lCont].szCodCiudad,stlGeZonaCiudadHost.szCodCiudad[lCont]);
			strcpy(pstlGeZonaCiudadTemp[lCont].szFecDesde,stlGeZonaCiudadHost.szFecDesde[lCont]);
			strcpy(pstlGeZonaCiudadTemp[lCont].szFecHasta,stlGeZonaCiudadHost.szFecHasta[lCont]);
			pstlGeZonaCiudadTemp[lCont].iCodZonaImpo = stlGeZonaCiudadHost.iCodZonaImpo[lCont];

		}

		(*lGeZonaCiudad) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeZonaCiudad);

	iOra=ifnOraCerrarGeZonaCiudad(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaCiudad):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeZonaCiudad, *lGeZonaCiudad, sizeof(ZONACIUDAD),
	ifnCompareGeZonaCiudad);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeZonaImpositiva
*******************************************************************************/

BOOL bfnObtGeZonaImpositiva ( long *lGeZonaImpositiva,ZONAIMPOSITIVA **pstlGeZonaImpositiva,void* ctx)
{
	int iOra;
	long lNumFilas;
	static ZONAIMPOSITIVA_HOST stlGeZonaImpositivaHost;
	ZONAIMPOSITIVA *pstlGeZonaImpositivaTemp;
	long lCont;


	 *lGeZonaImpositiva = 0;
	 *pstlGeZonaImpositiva = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: ZONAIMPOSITIVA");
	iOra= ifnOraDeclararGeZonaImpositiva ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaImpositiva):"
		"\n\tError al declarar cursor sobre ZONAIMPOSITIVA");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeZonaImpositiva(&stlGeZonaImpositivaHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaImpositiva):"
			"\n\tError al  realizar el FETCH sobre ZONAIMPOSITIVA");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeZonaImpositiva =(ZONAIMPOSITIVA*) realloc(*pstlGeZonaImpositiva,(((*lGeZonaImpositiva)+lNumFilas)*sizeof(ZONAIMPOSITIVA)));

		if (!*pstlGeZonaImpositiva)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaImpositiva):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeZonaImpositivaTemp = &(*pstlGeZonaImpositiva)[(*lGeZonaImpositiva)];
		memset(pstlGeZonaImpositivaTemp, 0, sizeof(ZONAIMPOSITIVA)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeZonaImpositivaTemp[lCont].iCodZonaImpo = stlGeZonaImpositivaHost.iCodZonaImpo[lCont];
			strcpy(pstlGeZonaImpositivaTemp[lCont].szDesZonaImpo,stlGeZonaImpositivaHost.szDesZonaImpo[lCont]);
		}

		(*lGeZonaImpositiva) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeZonaImpositiva);

	iOra=ifnOraCerrarGeZonaImpositiva(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeZonaImpositiva):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeZonaImpositiva, *lGeZonaImpositiva, sizeof(ZONAIMPOSITIVA),ifnCompareGeZonaImpositiva);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeImpuestos
*******************************************************************************/

BOOL bfnObtGeImpuestos ( long *lGeImpuestos,IMPUESTOS **pstlGeImpuestos,void* ctx)
{
	int iOra;
	long lNumFilas;
	static IMPUESTOS_HOST stlGeImpuestosHost;
	IMPUESTOS *pstlGeImpuestosTemp;
	long lCont;


	 *lGeImpuestos = 0;
	 *pstlGeImpuestos = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: IMPUESTOS");
	iOra= ifnOraDeclararGeImpuestos ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeImpuestos):"
		"\n\tError al declarar cursor sobre IMPUESTOS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeImpuestos(&stlGeImpuestosHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeImpuestos):"
			"\n\tError al  realizar el FETCH sobre IMPUESTOS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeImpuestos =(IMPUESTOS*) realloc(*pstlGeImpuestos,(((*lGeImpuestos)+lNumFilas)*sizeof(IMPUESTOS)));

		if (!*pstlGeImpuestos)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeImpuestos):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeImpuestosTemp = &(*pstlGeImpuestos)[(*lGeImpuestos)];
		memset(pstlGeImpuestosTemp, 0, sizeof(IMPUESTOS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeImpuestosTemp[lCont].iCodCatImpos = stlGeImpuestosHost.iCodCatImpos[lCont];
			pstlGeImpuestosTemp[lCont].iCodZonaImpo = stlGeImpuestosHost.iCodZonaImpo[lCont];
			pstlGeImpuestosTemp[lCont].iCodZonaAbon = stlGeImpuestosHost.iCodZonaAbon[lCont];
			pstlGeImpuestosTemp[lCont].iCodTipImpues = stlGeImpuestosHost.iCodTipImpues[lCont];
			pstlGeImpuestosTemp[lCont].iCodGrpServi = stlGeImpuestosHost.iCodGrpServi[lCont];
			strcpy(pstlGeImpuestosTemp[lCont].szFecDesde,stlGeImpuestosHost.szFecDesde[lCont]);
			pstlGeImpuestosTemp[lCont].iCodConcGene = stlGeImpuestosHost.iCodConcGene[lCont];
			strcpy(pstlGeImpuestosTemp[lCont].szFecHasta,stlGeImpuestosHost.szFecHasta[lCont]);
			pstlGeImpuestosTemp[lCont].fPrcImpuesto = stlGeImpuestosHost.fPrcImpuesto[lCont];
			pstlGeImpuestosTemp[lCont].iTipMonto = stlGeImpuestosHost.iTipMonto[lCont];

			pstlGeImpuestosTemp[lCont].dImpUmbral = stlGeImpuestosHost.dImpUmbral[lCont];
			pstlGeImpuestosTemp[lCont].dImpMaximo = stlGeImpuestosHost.dImpMaximo[lCont];
		}

		(*lGeImpuestos) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeImpuestos);

	iOra=ifnOraCerrarGeImpuestos(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeImpuestos):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeImpuestos, *lGeImpuestos, sizeof(IMPUESTOS),ifnCompareGeImpuestos);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeGrpSerConc
*******************************************************************************/

BOOL bfnObtGeGrpSerConc ( long *lGeGrpSerConc,GRPSERCONC **pstlGeGrpSerConc,void* ctx)
{
	int iOra;
	long lNumFilas;
	static GRPSERCONC_HOST stlGeGrpSerConcHost;
	GRPSERCONC *pstlGeGrpSerConcTemp;
	long lCont;


	 *lGeGrpSerConc = 0;
	 *pstlGeGrpSerConc = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: GRPSERCONC");
	iOra= ifnOraDeclararGeGrpSerConc ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrpSerConc):"
		"\n\tError al declarar cursor sobre GRPSERCONC");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeGrpSerConc(&stlGeGrpSerConcHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrpSerConc):"
			"\n\tError al  realizar el FETCH sobre GRPSERCONC");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeGrpSerConc =(GRPSERCONC*) realloc(*pstlGeGrpSerConc,(((*lGeGrpSerConc)+lNumFilas)*sizeof(GRPSERCONC)));

		if (!*pstlGeGrpSerConc)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrpSerConc):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeGrpSerConcTemp = &(*pstlGeGrpSerConc)[(*lGeGrpSerConc)];
		memset(pstlGeGrpSerConcTemp, 0, sizeof(GRPSERCONC)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeGrpSerConcTemp[lCont].iCodConcepto = stlGeGrpSerConcHost.iCodConcepto[lCont];
			strcpy(pstlGeGrpSerConcTemp[lCont].szFecDesde,stlGeGrpSerConcHost.szFecDesde[lCont]);
			pstlGeGrpSerConcTemp[lCont].iCodGrpServi = stlGeGrpSerConcHost.iCodGrpServi[lCont];
			strcpy(pstlGeGrpSerConcTemp[lCont].szFecHasta,stlGeGrpSerConcHost.szFecHasta[lCont]);
		}

		(*lGeGrpSerConc) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeGrpSerConc);

	iOra=ifnOraCerrarGeGrpSerConc(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrpSerConc):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeGrpSerConc, *lGeGrpSerConc, sizeof(GRPSERCONC),ifnCompareGeGrpSerConc);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeConversion
*******************************************************************************/

BOOL bfnObtGeConversion ( long *lGeConversion,CONVERSION **pstlGeConversion,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CONVERSION_HOST stlGeConversionHost;
	CONVERSION *pstlGeConversionTemp;
	long lCont;


	 *lGeConversion = 0;
	 *pstlGeConversion = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CONVERSION");
	iOra= ifnOraDeclararGeConversion ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConversion):"
		"\n\tError al declarar cursor sobre CONVERSION");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeConversion(&stlGeConversionHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConversion):"
			"\n\tError al  realizar el FETCH sobre CONVERSION");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeConversion =(CONVERSION*) realloc(*pstlGeConversion,(((*lGeConversion)+lNumFilas)*sizeof(CONVERSION)));

		if (!*pstlGeConversion)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConversion):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeConversionTemp = &(*pstlGeConversion)[(*lGeConversion)];
		memset(pstlGeConversionTemp, 0, sizeof(CONVERSION)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeConversionTemp[lCont].szCodMoneda,stlGeConversionHost.szCodMoneda[lCont]);
			strcpy(pstlGeConversionTemp[lCont].szFecDesde,stlGeConversionHost.szFecDesde[lCont]);
			strcpy(pstlGeConversionTemp[lCont].szFecHasta,stlGeConversionHost.szFecHasta[lCont]);
			pstlGeConversionTemp[lCont].dCambio = stlGeConversionHost.dCambio[lCont];
		}

		(*lGeConversion) += lNumFilas;
	}
		vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeConversion);

		iOra=ifnOraCerrarGeConversion(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeConversion):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeConversion, *lGeConversion, sizeof(CONVERSION),ifnCompareGeConversion);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeDocumSucursal
*******************************************************************************/

BOOL bfnObtGeDocumSucursal ( long *lGeDocumSucursal,DOCUMSUCURSAL **pstlGeDocumSucursal,void* ctx)
{
	int iOra;
	long lNumFilas;
	static DOCUMSUCURSAL_HOST stlGeDocumSucursalHost;
	DOCUMSUCURSAL *pstlGeDocumSucursalTemp;
	long lCont;


	 *lGeDocumSucursal = 0;
	 *pstlGeDocumSucursal = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: DOCUMSUCURSAL");
	iOra= ifnOraDeclararGeDocumSucursal ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeDocumSucursal):"
		"\n\tError al declarar cursor sobre DOCUMSUCURSAL");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeDocumSucursal(&stlGeDocumSucursalHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeDocumSucursal):"
			"\n\tError al  realizar el FETCH sobre DOCUMSUCURSAL");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeDocumSucursal =(DOCUMSUCURSAL*) realloc(*pstlGeDocumSucursal,(((*lGeDocumSucursal)+lNumFilas)*sizeof(DOCUMSUCURSAL)));

		if (!*pstlGeDocumSucursal)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeDocumSucursal):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeDocumSucursalTemp = &(*pstlGeDocumSucursal)[(*lGeDocumSucursal)];
		memset(pstlGeDocumSucursalTemp, 0, sizeof(DOCUMSUCURSAL)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeDocumSucursalTemp[lCont].szCodOficina,stlGeDocumSucursalHost.szCodOficina[lCont]);
			pstlGeDocumSucursalTemp[lCont].iCodTipDocum = stlGeDocumSucursalHost.iCodTipDocum[lCont];
			pstlGeDocumSucursalTemp[lCont].iCodCentrEmi = stlGeDocumSucursalHost.iCodCentrEmi[lCont];

		}

		(*lGeDocumSucursal) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeDocumSucursal);

	iOra=ifnOraCerrarGeDocumSucursal(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeDocumSucursal):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeDocumSucursal, *lGeDocumSucursal, sizeof(DOCUMSUCURSAL),ifnCompareGeDocumSucursal);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeLetras
*******************************************************************************/

BOOL bfnObtGeLetras ( long *lGeLetras,LETRAS **pstlGeLetras,void* ctx)
{
	int iOra;
	long lNumFilas;
	static LETRAS_HOST stlGeLetrasHost;
	LETRAS *pstlGeLetrasTemp;
	long lCont;


	 *lGeLetras = 0;
	 *pstlGeLetras = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: LETRAS");
	iOra= ifnOraDeclararGeLetras ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLetras):"
		"\n\tError al declarar cursor sobre LETRAS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeLetras(&stlGeLetrasHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLetras):"
			"\n\tError al  realizar el FETCH sobre LETRAS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeLetras =(LETRAS*) realloc(*pstlGeLetras,(((*lGeLetras)+lNumFilas)*sizeof(LETRAS)));

		if (!*pstlGeLetras)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLetras):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeLetrasTemp = &(*pstlGeLetras)[(*lGeLetras)];
		memset(pstlGeLetrasTemp, 0, sizeof(LETRAS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeLetrasTemp[lCont].iCodTipDocum = stlGeLetrasHost.iCodTipDocum[lCont];
			pstlGeLetrasTemp[lCont].iCodCatImpos=stlGeLetrasHost.iCodCatImpos[lCont];
			strcpy(pstlGeLetrasTemp[lCont].szLetra , stlGeLetrasHost.szLetra[lCont]);
		}

		(*lGeLetras) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeLetras);

	iOra=ifnOraCerrarGeLetras(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeLetras):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeLetras, *lGeLetras, sizeof(LETRAS),ifnCompareGeLetras);
	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeGrupoCob
*******************************************************************************/

BOOL bfnObtGeGrupoCob ( long *lGeGrupoCob,GRUPOCOB **pstlGeGrupoCob,void* ctx, int ciclo)
{
	int iOra;
	long lNumFilas;
	static GRUPOCOB_HOST stlGeGrupoCobHost;
	GRUPOCOB *pstlGeGrupoCobTemp;
	long lCont;


	 *lGeGrupoCob = 0;
	 *pstlGeGrupoCob = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: GRUPOCOB");
	iOra= ifnOraDeclararGeGrupoCob ( ctx, ciclo);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrupoCob):"
		"\n\tError al declarar cursor sobre GRUPOCOB");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeGrupoCob(&stlGeGrupoCobHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrupoCob):"
			"\n\tError al  realizar el FETCH sobre GRUPOCOB");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeGrupoCob =(GRUPOCOB*) realloc(*pstlGeGrupoCob,(((*lGeGrupoCob)+lNumFilas)*sizeof(GRUPOCOB)));

		if (!*pstlGeGrupoCob)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrupoCob):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeGrupoCobTemp = &(*pstlGeGrupoCob)[(*lGeGrupoCob)];
		memset(pstlGeGrupoCobTemp, 0, sizeof(GRUPOCOB)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeGrupoCobTemp[lCont].szCodGrupo,stlGeGrupoCobHost.szCodGrupo[lCont]);
			pstlGeGrupoCobTemp[lCont].iCodProducto = stlGeGrupoCobHost.iCodProducto[lCont];
			pstlGeGrupoCobTemp[lCont].iCodConcepto = stlGeGrupoCobHost.iCodConcepto[lCont];
			pstlGeGrupoCobTemp[lCont].iCodCiclo = stlGeGrupoCobHost.iCodCiclo[lCont];
			pstlGeGrupoCobTemp[lCont].iTipCobro = stlGeGrupoCobHost.iTipCobro[lCont];
			strcpy(pstlGeGrupoCobTemp[lCont].szFecDesde,stlGeGrupoCobHost.szFecDesde[lCont]);
			strcpy(pstlGeGrupoCobTemp[lCont].szFecHasta,stlGeGrupoCobHost.szFecHasta[lCont]);
		}

		(*lGeGrupoCob) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeGrupoCob);

	iOra=ifnOraCerrarGeGrupoCob(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeGrupoCob):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeGrupoCob, *lGeGrupoCob, sizeof(GRUPOCOB),ifnCompareGeGrupoCob);
	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeTarifas
*******************************************************************************/

BOOL bfnObtGeTarifas ( long *lGeTarifas,TARIFAS **pstlGeTarifas,void* ctx)
{
	int iOra;
	long lNumFilas;
	static TARIFAS_HOST stlGeTarifasHost;
	static TARIFAS_HOST_NULL stlGeTarifasHostNull;
	TARIFAS *pstlGeTarifasTemp;
	long lCont;

	 *lGeTarifas = 0;
	 *pstlGeTarifas = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: TARIFAS");
	iOra= ifnOraDeclararGeTarifas (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTarifas):"
		"\n\tError al declarar cursor sobre TARIFAS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeTarifas(&stlGeTarifasHost,&stlGeTarifasHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTarifas):"
			"\n\tError al  realizar el FETCH sobre TARIFAS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeTarifas =(TARIFAS*) realloc(*pstlGeTarifas,(((*lGeTarifas)+lNumFilas)*sizeof(TARIFAS)));

		if (!*pstlGeTarifas)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTarifas):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeTarifasTemp = &(*pstlGeTarifas)[(*lGeTarifas)];
		memset(pstlGeTarifasTemp, 0, sizeof(TARIFAS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeTarifasTemp[lCont].szCodTipServ,stlGeTarifasHost.szCodTipServ[lCont]);
			strcpy(pstlGeTarifasTemp[lCont].szCodServicio,stlGeTarifasHost.szCodServicio[lCont]);
			strcpy(pstlGeTarifasTemp[lCont].szCodPlanServ,stlGeTarifasHost.szCodPlanServ[lCont]);
			strcpy(pstlGeTarifasTemp[lCont].szFecDesde,stlGeTarifasHost.szFecDesde[lCont]);
			pstlGeTarifasTemp[lCont].dImpTarifa = stlGeTarifasHost.dImpTarifa[lCont];
			strcpy(pstlGeTarifasTemp[lCont].szCodMoneda,stlGeTarifasHost.szCodMoneda[lCont]);
			strcpy(pstlGeTarifasTemp[lCont].szIndPeriodico,stlGeTarifasHost.szIndPeriodico[lCont]);

			if(stlGeTarifasHostNull.sszFecHasta[lCont] != ORA_NULL)
				strcpy(pstlGeTarifasTemp[lCont].szFecHasta,stlGeTarifasHost.szFecHasta[lCont]);

			else
				strcpy(pstlGeTarifasTemp[lCont].szFecHasta, "");
		}

		(*lGeTarifas) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeTarifas);

	iOra=ifnOraCerrarGeTarifas(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeTarifas):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeTarifas, *lGeTarifas, sizeof(TARIFAS),ifnCompareGeTarifas);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeActuaServ
*******************************************************************************/

BOOL bfnObtGeActuaServ ( long *lGeActuaServ,ACTUASERV **pstlGeActuaServ,void* ctx)
{
	int iOra;
	long lNumFilas;
	static ACTUASERV_HOST stlGeActuaServHost;
	static ACTUASERV_HOST_NULL stlGeActuaServHostNull;
	ACTUASERV *pstlGeActuaServTemp;
	long lCont;


	 *lGeActuaServ = 0;
	 *pstlGeActuaServ = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: ACTUASERV");
	iOra= ifnOraDeclararGeActuaServ (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActuaServ):"
		"\n\tError al declarar cursor sobre ACTUASERV");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeActuaServ(&stlGeActuaServHost,&stlGeActuaServHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActuaServ):"
			"\n\tError al  realizar el FETCH sobre ACTUASERV");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeActuaServ =(ACTUASERV*) realloc(*pstlGeActuaServ,(((*lGeActuaServ)+lNumFilas)*sizeof(ACTUASERV)));

		if (!*pstlGeActuaServ)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActuaServ):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeActuaServTemp = &(*pstlGeActuaServ)[(*lGeActuaServ)];
		memset(pstlGeActuaServTemp, 0, sizeof(ACTUASERV)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeActuaServTemp[lCont].szCodTipServ,stlGeActuaServHost.szCodTipServ[lCont]);
			strcpy(pstlGeActuaServTemp[lCont].szCodServicio,stlGeActuaServHost.szCodServicio[lCont]);
			if(stlGeActuaServHostNull.siCodConcepto[lCont] != ORA_NULL)
				pstlGeActuaServTemp[lCont].iCodConcepto=stlGeActuaServHost.iCodConcepto[lCont];
			else
				pstlGeActuaServTemp[lCont].iCodConcepto=-1;
		}

		(*lGeActuaServ) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeActuaServ);

	iOra=ifnOraCerrarGeActuaServ(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeActuaServ):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeActuaServ, *lGeActuaServ, sizeof(ACTUASERV),ifnCompareGeActuaServ);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCuotas
*******************************************************************************/

BOOL bfnObtGeCuotas ( long *lGeCuotas,CUOTAS **pstlGeCuotas,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CUOTAS_HOST stlGeCuotasHost;
	CUOTAS *pstlGeCuotasTemp;
	long lCont;


	 *lGeCuotas = 0;
	 *pstlGeCuotas = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CUOTAS");
	iOra= ifnOraDeclararGeCuotas ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuotas):"
		"\n\tError al declarar cursor sobre CUOTAS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCuotas(&stlGeCuotasHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuotas):"
			"\n\tError al  realizar el FETCH sobre CUOTAS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCuotas =(CUOTAS*) realloc(*pstlGeCuotas,(((*lGeCuotas)+lNumFilas)*sizeof(CUOTAS)));

		if (!*pstlGeCuotas)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuotas):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCuotasTemp = &(*pstlGeCuotas)[(*lGeCuotas)];
		memset(pstlGeCuotasTemp, 0, sizeof(CUOTAS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeCuotasTemp[lCont].szRowid,stlGeCuotasHost.szRowid[lCont]);
			pstlGeCuotasTemp[lCont].lSeqCuotas = stlGeCuotasHost.lSeqCuotas[lCont];
			pstlGeCuotasTemp[lCont].iOrdCuota = stlGeCuotasHost.iOrdCuota[lCont];
			strcpy(pstlGeCuotasTemp[lCont].szFecEmision,stlGeCuotasHost.szFecEmision[lCont]);
			pstlGeCuotasTemp[lCont].dImpCuota = stlGeCuotasHost.dImpCuota[lCont];
			pstlGeCuotasTemp[lCont].iIndFacturado = stlGeCuotasHost.iIndFacturado[lCont];
			pstlGeCuotasTemp[lCont].iIndPagado = stlGeCuotasHost.iIndPagado[lCont];
		}

		(*lGeCuotas) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCuotas);

	iOra=ifnOraCerrarGeCuotas(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuotas):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCuotas, *lGeCuotas, sizeof(CUOTAS),ifnCompareGeCuotas);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeFactCarriers
*******************************************************************************/

BOOL bfnObtGeFactCarriers ( long *lGeFactCarriers,FACTCARRIERS **pstlGeFactCarriers,void* ctx)
{
	int iOra;
	long lNumFilas;
	static FACTCARRIERS_HOST stlGeFactCarriersHost;
	FACTCARRIERS *pstlGeFactCarriersTemp;
	long lCont;


	 *lGeFactCarriers = 0;
	 *pstlGeFactCarriers = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: FACTCARRIERS");
	iOra= ifnOraDeclararGeFactCarriers ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCarriers):"
		"\n\tError al declarar cursor sobre FACTCARRIERS");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeFactCarriers(&stlGeFactCarriersHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCarriers):"
			"\n\tError al  realizar el FETCH sobre FACTCARRIERS");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeFactCarriers =(FACTCARRIERS*) realloc(*pstlGeFactCarriers,(((*lGeFactCarriers)+lNumFilas)*sizeof(FACTCARRIERS)));

		if (!*pstlGeFactCarriers)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCarriers):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeFactCarriersTemp = &(*pstlGeFactCarriers)[(*lGeFactCarriers)];
		memset(pstlGeFactCarriersTemp, 0, sizeof(FACTCARRIERS)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeFactCarriersTemp[lCont].iCodConcFact    = stlGeFactCarriersHost.iCodConcFact[lCont];
			pstlGeFactCarriersTemp[lCont].iCodConcCarrier = stlGeFactCarriersHost.iCodConcCarrier[lCont];
			pstlGeFactCarriersTemp[lCont].iCodTipConce    = stlGeFactCarriersHost.iCodTipConce[lCont];
		}

		(*lGeFactCarriers) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeFactCarriers);

	iOra=ifnOraCerrarGeFactCarriers(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCarriers):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeFactCarriers, *lGeFactCarriers, sizeof(FACTCARRIERS),ifnCompareGeFactCarriers);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCuadCtoPlan
*******************************************************************************/

BOOL bfnObtGeCuadCtoPlan ( long *lGeCuadCtoPlan,CUADCTOPLAN **pstlGeCuadCtoPlan,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CUADCTOPLAN_HOST stlGeCuadCtoPlanHost;
	CUADCTOPLAN *pstlGeCuadCtoPlanTemp;
	long lCont;


	 *lGeCuadCtoPlan = 0;
	 *pstlGeCuadCtoPlan = NULL;
   
	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CUADCTOPLAN");
	iOra= ifnOraDeclararGeCuadCtoPlan (ctx );
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuadCtoPlan):"
		"\n\tError al declarar cursor sobre CUADCTOPLAN");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCuadCtoPlan(&stlGeCuadCtoPlanHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuadCtoPlan):"
			"\n\tError al  realizar el FETCH sobre CUADCTOPLAN");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCuadCtoPlan =(CUADCTOPLAN*) realloc(*pstlGeCuadCtoPlan,(((*lGeCuadCtoPlan)+lNumFilas)*sizeof(CUADCTOPLAN)));

		if (!*pstlGeCuadCtoPlan)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuadCtoPlan):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCuadCtoPlanTemp = &(*pstlGeCuadCtoPlan)[(*lGeCuadCtoPlan)];
		memset(pstlGeCuadCtoPlanTemp, 0, sizeof(CUADCTOPLAN)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeCuadCtoPlanTemp[lCont].lCodCtoPlan = stlGeCuadCtoPlanHost.lCodCtoPlan[lCont];
			pstlGeCuadCtoPlanTemp[lCont].dImpUmbDesde = stlGeCuadCtoPlanHost.dImpUmbDesde[lCont];
			pstlGeCuadCtoPlanTemp[lCont].dImpUmbHasta = stlGeCuadCtoPlanHost.dImpUmbHasta[lCont];
			pstlGeCuadCtoPlanTemp[lCont].dImpDescuento = stlGeCuadCtoPlanHost.dImpDescuento[lCont];
			pstlGeCuadCtoPlanTemp[lCont].iCodTipoDto = stlGeCuadCtoPlanHost.iCodTipoDto[lCont];
		}

		(*lGeCuadCtoPlan) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCuadCtoPlan);

	iOra=ifnOraCerrarGeCuadCtoPlan(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCuadCtoPlan):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCuadCtoPlan, *lGeCuadCtoPlan, sizeof(CUADCTOPLAN),ifnCompareGeCuadCtoPlan);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCtoPlan
*******************************************************************************/

BOOL bfnObtGeCtoPlan ( long *lGeCtoPlan,CTOPLAN **pstlGeCtoPlan,void* ctx)
{
	int iOra;
	long lNumFilas;
	static CTOPLAN_HOST stlGeCtoPlanHost;
	static CTOPLAN_HOST_NULL stlGeCtoPlanHostNull;
	CTOPLAN *pstlGeCtoPlanTemp;
	long lCont;


	 *lGeCtoPlan = 0;
	 *pstlGeCtoPlan = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CTOPLAN");
	iOra= ifnOraDeclararGeCtoPlan ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCtoPlan):"
		"\n\tError al declarar cursor sobre CTOPLAN");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCtoPlan(&stlGeCtoPlanHost,&stlGeCtoPlanHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCtoPlan):"
			"\n\tError al  realizar el FETCH sobre CTOPLAN");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCtoPlan =(CTOPLAN*) realloc(*pstlGeCtoPlan,(((*lGeCtoPlan)+lNumFilas)*sizeof(CTOPLAN)));

		if (!*pstlGeCtoPlan)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCtoPlan):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCtoPlanTemp = &(*pstlGeCtoPlan)[(*lGeCtoPlan)];
		memset(pstlGeCtoPlanTemp, 0, sizeof(CTOPLAN)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeCtoPlanTemp[lCont].lCodCtoPlan = stlGeCtoPlanHost.lCodCtoPlan[lCont];
			pstlGeCtoPlanTemp[lCont].iCodProducto = stlGeCtoPlanHost.iCodProducto[lCont];
			strcpy(pstlGeCtoPlanTemp[lCont].szCodTipCtoPlan,stlGeCtoPlanHost.szCodTipCtoPlan[lCont]);
			strcpy(pstlGeCtoPlanTemp[lCont].szCodMoneda,stlGeCtoPlanHost.szCodMoneda[lCont]);
			pstlGeCtoPlanTemp[lCont].iCodCtoFac = stlGeCtoPlanHost.iCodCtoFac[lCont];
			pstlGeCtoPlanTemp[lCont].dImpDescuento = stlGeCtoPlanHost.dImpDescuento[lCont];
			pstlGeCtoPlanTemp[lCont].iCodTipoDto = stlGeCtoPlanHost.iCodTipoDto[lCont];
			pstlGeCtoPlanTemp[lCont].iIndCuadrante = stlGeCtoPlanHost.iIndCuadrante[lCont];
			pstlGeCtoPlanTemp[lCont].iCodTipoCuad = stlGeCtoPlanHost.iCodTipoCuad[lCont];
			if(stlGeCtoPlanHostNull.sdImpUmbDesde[lCont] != ORA_NULL)
				pstlGeCtoPlanTemp[lCont].dImpUmbDesde=stlGeCtoPlanHost.dImpUmbDesde[lCont];
			else
				pstlGeCtoPlanTemp[lCont].dImpUmbDesde=-1;
			if(stlGeCtoPlanHostNull.sdImpUmbHasta[lCont] != ORA_NULL)
				pstlGeCtoPlanTemp[lCont].dImpUmbHasta=stlGeCtoPlanHost.dImpUmbHasta[lCont];
			else
				pstlGeCtoPlanTemp[lCont].dImpUmbHasta=-1;
			if(stlGeCtoPlanHostNull.siNumDias[lCont] != ORA_NULL)
				pstlGeCtoPlanTemp[lCont].iNumDias=stlGeCtoPlanHost.iNumDias[lCont];
			else
				pstlGeCtoPlanTemp[lCont].iNumDias=-1;
		}

		(*lGeCtoPlan) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCtoPlan);

	iOra=ifnOraCerrarGeCtoPlan(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCtoPlan):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCtoPlan, *lGeCtoPlan, sizeof(CTOPLAN),ifnCompareGeCtoPlan);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGePlanCtoPlan
*******************************************************************************/

BOOL bfnObtGePlanCtoPlan ( long *lGePlanCtoPlan,PLANCTOPLAN **pstlGePlanCtoPlan,void* ctx)
{
	int iOra;
	long lNumFilas;
	static PLANCTOPLAN_HOST stlGePlanCtoPlanHost;
	PLANCTOPLAN *pstlGePlanCtoPlanTemp;
	long lCont;


	 *lGePlanCtoPlan = 0;
	 *pstlGePlanCtoPlan = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: PLANCTOPLAN");
	iOra= ifnOraDeclararGePlanCtoPlan ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanCtoPlan):"
		"\n\tError al declarar cursor sobre PLANCTOPLAN");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGePlanCtoPlan(&stlGePlanCtoPlanHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanCtoPlan):"
			"\n\tError al  realizar el FETCH sobre PLANCTOPLAN");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGePlanCtoPlan =(PLANCTOPLAN*) realloc(*pstlGePlanCtoPlan,(((*lGePlanCtoPlan)+lNumFilas)*sizeof(PLANCTOPLAN)));

		if (!*pstlGePlanCtoPlan)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanCtoPlan):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGePlanCtoPlanTemp = &(*pstlGePlanCtoPlan)[(*lGePlanCtoPlan)];
		memset(pstlGePlanCtoPlanTemp, 0, sizeof(PLANCTOPLAN)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGePlanCtoPlanTemp[lCont].lCodPlanCom = stlGePlanCtoPlanHost.lCodPlanCom[lCont];
			pstlGePlanCtoPlanTemp[lCont].iCodProducto = stlGePlanCtoPlanHost.iCodProducto[lCont];
			pstlGePlanCtoPlanTemp[lCont].lCodCtoPlan = stlGePlanCtoPlanHost.lCodCtoPlan[lCont];
			strcpy(pstlGePlanCtoPlanTemp[lCont].szFecEfectividad,stlGePlanCtoPlanHost.szFecEfectividad[lCont]);
			strcpy(pstlGePlanCtoPlanTemp[lCont].szFecFinEfectividad,stlGePlanCtoPlanHost.szFecFinEfectividad[lCont]);
		}

		(*lGePlanCtoPlan) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGePlanCtoPlan);

	iOra=ifnOraCerrarGePlanCtoPlan(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanCtoPlan):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGePlanCtoPlan, *lGePlanCtoPlan, sizeof(PLANCTOPLAN),ifnCompareGePlanCtoPlan);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeArriendo
*******************************************************************************/

BOOL bfnObtGeArriendo ( long *lGeArriendo,ARRIENDO **pstlGeArriendo,void* ctx)
{
	int iOra;
	long lNumFilas;
	static ARRIENDO_HOST stlGeArriendoHost;
	ARRIENDO *pstlGeArriendoTemp;
	long lCont;


	 *lGeArriendo = 0;
	 *pstlGeArriendo = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: ARRIENDO");
	iOra= ifnOraDeclararGeArriendo ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeArriendo):"
		"\n\tError al declarar cursor sobre ARRIENDO");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeArriendo(&stlGeArriendoHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeArriendo):"
			"\n\tError al  realizar el FETCH sobre ARRIENDO");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeArriendo =(ARRIENDO*) realloc(*pstlGeArriendo,(((*lGeArriendo)+lNumFilas)*sizeof(ARRIENDO)));

		if (!*pstlGeArriendo)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeArriendo):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeArriendoTemp = &(*pstlGeArriendo)[(*lGeArriendo)];
		memset(pstlGeArriendoTemp, 0, sizeof(ARRIENDO)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeArriendoTemp[lCont].szRowid,stlGeArriendoHost.szRowid[lCont]);
			pstlGeArriendoTemp[lCont].lCodCliente = stlGeArriendoHost.lCodCliente[lCont];
			pstlGeArriendoTemp[lCont].lNumAbonado = stlGeArriendoHost.lNumAbonado[lCont];
			strcpy(pstlGeArriendoTemp[lCont].szFecDesde,stlGeArriendoHost.szFecDesde[lCont]);
			strcpy(pstlGeArriendoTemp[lCont].szFecHasta,stlGeArriendoHost.szFecHasta[lCont]);
			pstlGeArriendoTemp[lCont].iCodProducto = stlGeArriendoHost.iCodProducto[lCont];
			pstlGeArriendoTemp[lCont].iCodConcepto = stlGeArriendoHost.iCodConcepto[lCont];
			pstlGeArriendoTemp[lCont].lCodArticulo = stlGeArriendoHost.lCodArticulo[lCont];
			pstlGeArriendoTemp[lCont].dPrecioMes = stlGeArriendoHost.dPrecioMes[lCont];
			strcpy(pstlGeArriendoTemp[lCont].szCodMoneda,stlGeArriendoHost.szCodMoneda[lCont]);
		}

		(*lGeArriendo) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeArriendo);

	iOra=ifnOraCerrarGeArriendo(ctx);
	if (iOra != SQL_OK)
	{
	vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeArriendo):"
	"\n\tError al cerrar el cursor");
	vfnImpErrorORACLE();
	return FALSE;
	}

	qsort((void*)*pstlGeArriendo, *lGeArriendo, sizeof(ARRIENDO),ifnCompareGeArriendo);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeCargosBasico
*******************************************************************************/

BOOL bfnObtGeCargosBasico ( long *lGeCargosBasico,CARGOSBASICO **pstlGeCargosBasico,void* ctx, char *pszFecEmision)
{
	int iOra;
	long lNumFilas;
	static CARGOSBASICO_HOST stlGeCargosBasicoHost;
	CARGOSBASICO *pstlGeCargosBasicoTemp;
	long lCont;


	 *lGeCargosBasico = 0;
	 *pstlGeCargosBasico = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CARGOSBASICO");
	iOra= ifnOraDeclararGeCargosBasico ( ctx, pszFecEmision);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosBasico):"
		"\n\tError al declarar cursor sobre CARGOSBASICO");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeCargosBasico(&stlGeCargosBasicoHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosBasico):"
			"\n\tError al  realizar el FETCH sobre CARGOSBASICO");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeCargosBasico =(CARGOSBASICO*) realloc(*pstlGeCargosBasico,(((*lGeCargosBasico)+lNumFilas)*sizeof(CARGOSBASICO)));

		if (!*pstlGeCargosBasico)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosBasico):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeCargosBasicoTemp = &(*pstlGeCargosBasico)[(*lGeCargosBasico)];
		memset(pstlGeCargosBasicoTemp, 0, sizeof(CARGOSBASICO)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeCargosBasicoTemp[lCont].szCodCargoBasico,stlGeCargosBasicoHost.szCodCargoBasico[lCont]);
			pstlGeCargosBasicoTemp[lCont].dImpCargoBasico = stlGeCargosBasicoHost.dImpCargoBasico[lCont];
			strcpy(pstlGeCargosBasicoTemp[lCont].szCodMoneda,stlGeCargosBasicoHost.szCodMoneda[lCont]);
		}

		(*lGeCargosBasico) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCargosBasico);

	iOra=ifnOraCerrarGeCargosBasico(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeCargosBasico):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeCargosBasico, *lGeCargosBasico, sizeof(CARGOSBASICO),ifnCompareGeCargosBasico);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeOptimo
*******************************************************************************/

BOOL bfnObtGeOptimo ( long *lGeOptimo,OPTIMO **pstlGeOptimo,void* ctx)
{
	int iOra;
	long lNumFilas;
	static OPTIMO_HOST stlGeOptimoHost;
	static OPTIMO_HOST_NULL stlGeOptimoHostNull;
	OPTIMO *pstlGeOptimoTemp;
	long lCont;


	 *lGeOptimo = 0;
	 *pstlGeOptimo = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: OPTIMO");
	iOra= ifnOraDeclararGeOptimo ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOptimo):"
		"\n\tError al declarar cursor sobre OPTIMO");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeOptimo(&stlGeOptimoHost,&stlGeOptimoHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOptimo):"
			"\n\tError al  realizar el FETCH sobre OPTIMO");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGeOptimo =(OPTIMO*) realloc(*pstlGeOptimo,(((*lGeOptimo)+lNumFilas)*sizeof(OPTIMO)));

		if (!*pstlGeOptimo)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOptimo):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGeOptimoTemp = &(*pstlGeOptimo)[(*lGeOptimo)];
		memset(pstlGeOptimoTemp, 0, sizeof(OPTIMO)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeOptimoTemp[lCont].szCodPlanTarif,stlGeOptimoHost.szCodPlanTarif[lCont]);
			pstlGeOptimoTemp[lCont].lMinDesde = stlGeOptimoHost.lMinDesde[lCont];
			if(stlGeOptimoHostNull.slMinHasta[lCont] != ORA_NULL)
				pstlGeOptimoTemp[lCont].lMinHasta=stlGeOptimoHost.lMinHasta[lCont];
			else
				pstlGeOptimoTemp[lCont].lMinHasta=-1;
			pstlGeOptimoTemp[lCont].fPrcAbono = stlGeOptimoHost.fPrcAbono[lCont];
			pstlGeOptimoTemp[lCont].fPrcNormal = stlGeOptimoHost.fPrcNormal[lCont];
			pstlGeOptimoTemp[lCont].fPrcBajo = stlGeOptimoHost.fPrcBajo[lCont];
		}

		(*lGeOptimo) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeOptimo);

	iOra=ifnOraCerrarGeOptimo(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOptimo):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGeOptimo, *lGeOptimo, sizeof(OPTIMO),ifnCompareGeOptimo);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeFeriados
*******************************************************************************/

BOOL bfnObtGeFeriados ( long *lGeFeriados,FERIADOS **pstlGeFeriados,void* ctx)
{
	int iOra;
	long lNumFilas;
	static FERIADOS_HOST stlGeFeriadosHost;
	FERIADOS *pstlGeFeriadosTemp;
	long lCont;


	*lGeFeriados = 0;
	*pstlGeFeriados = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: FERIADOS");
	iOra= ifnOraDeclararGeFeriados ( ctx);
	if ( iOra != SQL_OK )
	{
            vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFeriados):"
		              "\n\tError al declarar cursor sobre FERIADOS");
	    vfnImpErrorORACLE();
	    return FALSE;
	}

	while ( iOra != NOT_FOUND )
	{
                iOra= ifnOraLeerGeFeriados(&stlGeFeriadosHost,&lNumFilas,ctx);
                if ( iOra != SQL_OK  && iOra != NOT_FOUND )
                {
                     vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFeriados):"
                                       "\n\tError al  realizar el FETCH sobre FERIADOS");
                     vfnImpErrorORACLE();
                     return FALSE;
                }

		if ( !lNumFilas )
		{
		     break;
		}

                *pstlGeFeriados =(FERIADOS*) realloc(*pstlGeFeriados,(((*lGeFeriados)+lNumFilas)*sizeof(FERIADOS)));

                if ( !*pstlGeFeriados )
                {
                     vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFeriados):"
                                       "\n\tError al alocar memoria"
                                       "\n\tError: [%d][%s]", errno, strerror(errno));
                     return FALSE;
                }

                pstlGeFeriadosTemp = &(*pstlGeFeriados)[(*lGeFeriados)];
                memset(pstlGeFeriadosTemp, 0, sizeof(FERIADOS)*lNumFilas);
		
                for ( lCont = 0 ; lCont < lNumFilas ; lCont++ )
                {
                      strcpy(pstlGeFeriadosTemp[lCont].szFecFeriado,stlGeFeriadosHost.szFecFeriado[lCont]);

                }

                (*lGeFeriados) += lNumFilas;
        }
        
        vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeFeriados);

        iOra=ifnOraCerrarGeFeriados(ctx);
	
        if (iOra != SQL_OK)
        {
	    vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFeriados):"
                              "\n\tError al cerrar el cursor");
            vfnImpErrorORACLE();
            return FALSE;
        }

        return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGePlanTarif
*******************************************************************************/

BOOL bfnObtGePlanTarif ( long *lGePlanTarif,PLANTARIF **pstlGePlanTarif,void* ctx, char *szFecEmision)
{
        int       iOra;
        long      lNumFilas;
        static    PLANTARIF_HOST stlGePlanTarifHost;
        static    PLANTARIF_HOST_NULL stlGePlanTarifHostNull;
        PLANTARIF *pstlGePlanTarifTemp;
        long      lCont;

        *lGePlanTarif = 0;
        *pstlGePlanTarif = NULL;

        vfnLog(FILE_LOG, "\n\t-Leyendo datos: PLANTARIF");
        iOra= ifnOraDeclararGePlanTarif ( ctx, szFecEmision);
	
        if ( iOra != SQL_OK )
        {
             vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanTarif):"
                               "\n\tError al declarar cursor sobre PLANTARIF");
             vfnImpErrorORACLE();
             return FALSE;
        }

        while ( iOra != NOT_FOUND )
        {
                iOra= ifnOraLeerGePlanTarif(&stlGePlanTarifHost,&stlGePlanTarifHostNull,&lNumFilas,ctx);
                
                if ( iOra != SQL_OK  && iOra != NOT_FOUND )
                {
                     vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanTarif):"
                                       "\n\tError al  realizar el FETCH sobre PLANTARIF");
                     vfnImpErrorORACLE();
                     return FALSE;
                }

                if ( !lNumFilas )
                {
		     break;
		}

                *pstlGePlanTarif =(PLANTARIF*) realloc(*pstlGePlanTarif,(((*lGePlanTarif)+lNumFilas)*sizeof(PLANTARIF)));

                if ( !*pstlGePlanTarif )
                {
		     vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanTarif):"
			               "\n\tError al alocar memoria"
			               "\n\tError: [%d][%s]", errno, strerror(errno));
                     return FALSE;
                }

                pstlGePlanTarifTemp = &(*pstlGePlanTarif)[(*lGePlanTarif)];                
                memset(pstlGePlanTarifTemp, 0, sizeof(PLANTARIF)*lNumFilas);
                
                for ( lCont = 0 ; lCont < lNumFilas ; lCont++ )
                {
                      strcpy(pstlGePlanTarifTemp[lCont].szCodPlanTarif,stlGePlanTarifHost.szCodPlanTarif[lCont]);
                      
                      if( stlGePlanTarifHostNull.sszTipTerminal[lCont] != ORA_NULL )
                      {
			  strcpy(pstlGePlanTarifTemp[lCont].szTipTerminal,stlGePlanTarifHost.szTipTerminal[lCont]);
                      }
		      else
		      {
			  strcpy(pstlGePlanTarifTemp[lCont].szTipTerminal, "");
                      }
                      
                      strcpy(pstlGePlanTarifTemp[lCont].szCodLimConsumo,stlGePlanTarifHost.szCodLimConsumo[lCont]);
                      strcpy(pstlGePlanTarifTemp[lCont].szCodCargoBasico,stlGePlanTarifHost.szCodCargoBasico[lCont]);
                      strcpy(pstlGePlanTarifTemp[lCont].szTipPlanTarif,stlGePlanTarifHost.szTipPlanTarif[lCont]);
                      strcpy(pstlGePlanTarifTemp[lCont].szTipUnidades,stlGePlanTarifHost.szTipUnidades[lCont]);
                      pstlGePlanTarifTemp[lCont].lNumUnidades = stlGePlanTarifHost.lNumUnidades[lCont];
                      pstlGePlanTarifTemp[lCont].iIndArrastre = stlGePlanTarifHost.iIndArrastre[lCont];
                      pstlGePlanTarifTemp[lCont].iNumDias = stlGePlanTarifHost.iNumDias[lCont];
                      pstlGePlanTarifTemp[lCont].iTipCobro = stlGePlanTarifHost.iTipCobro[lCont];
                      
                      if( stlGePlanTarifHostNull.slNumAbonados[lCont] != ORA_NULL )
                      {
                          pstlGePlanTarifTemp[lCont].lNumAbonados=stlGePlanTarifHost.lNumAbonados[lCont];
                      }
                      else
                      {
                          pstlGePlanTarifTemp[lCont].lNumAbonados=-1;
                      }
			
                      strcpy(pstlGePlanTarifTemp[lCont].szInd_Francons,stlGePlanTarifHost.szInd_Francons[lCont]);
			
                      pstlGePlanTarifTemp[lCont].iFlgRango = stlGePlanTarifHost.iFlgRango[lCont];
                      
                      strcpy(pstlGePlanTarifTemp[lCont].szIndCompartido,stlGePlanTarifHost.szIndCompartido[lCont]);                      
                }

                (*lGePlanTarif) += lNumFilas;
        }
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGePlanTarif);

	iOra=ifnOraCerrarGePlanTarif(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePlanTarif):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGePlanTarif, *lGePlanTarif, sizeof(PLANTARIF),ifnCompareGePlanTarif);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGePenalizaciones
*******************************************************************************/

BOOL bfnObtGePenalizaciones ( long *lGePenalizaciones,PENALIZA **pstlGePenalizaciones,void* ctx)
{
	int iOra;
	long lNumFilas;
	static PENALIZA_HOST stlGePenalizacionesHost;
	static PENALIZA_HOST_NULL stlGePenalizacionesHostNull;
	PENALIZA *pstlGePenalizacionesTemp;
	long lCont;


	 *lGePenalizaciones = 0;
	 *pstlGePenalizaciones = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: PENALIZA");
	iOra= ifnOraDeclararGePenalizaciones ( ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePenalizaciones):"
		"\n\tError al declarar cursor sobre PENALIZA");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGePenalizaciones(&stlGePenalizacionesHost,&stlGePenalizacionesHostNull,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePenalizaciones):"
			"\n\tError al  realizar el FETCH sobre PENALIZA");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		 *pstlGePenalizaciones =(PENALIZA*) realloc(*pstlGePenalizaciones,(((*lGePenalizaciones)+lNumFilas)*sizeof(PENALIZA)));

		if (!*pstlGePenalizaciones)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePenalizaciones):"
			"\n\tError al alocar memoria"
			"\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlGePenalizacionesTemp = &(*pstlGePenalizaciones)[(*lGePenalizaciones)];
		memset(pstlGePenalizacionesTemp, 0, sizeof(PENALIZA)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGePenalizacionesTemp[lCont].szRowid,stlGePenalizacionesHost.szRowid[lCont]);
			pstlGePenalizacionesTemp[lCont].lCodCliente = stlGePenalizacionesHost.lCodCliente[lCont];
			pstlGePenalizacionesTemp[lCont].iTipIncidencia = stlGePenalizacionesHost.iTipIncidencia[lCont];
			strcpy(pstlGePenalizacionesTemp[lCont].szFecEfectividad,stlGePenalizacionesHost.szFecEfectividad[lCont]);
			strcpy(pstlGePenalizacionesTemp[lCont].szCodMoneda,stlGePenalizacionesHost.szCodMoneda[lCont]);
			pstlGePenalizacionesTemp[lCont].dImpPenaliz = stlGePenalizacionesHost.dImpPenaliz[lCont];
			if(stlGePenalizacionesHostNull.slCodCiclFact[lCont] != ORA_NULL)
				pstlGePenalizacionesTemp[lCont].lCodCiclFact=stlGePenalizacionesHost.lCodCiclFact[lCont];
			else
				pstlGePenalizacionesTemp[lCont].lCodCiclFact=-1;
			pstlGePenalizacionesTemp[lCont].iCodConcepto = stlGePenalizacionesHost.iCodConcepto[lCont];
			pstlGePenalizacionesTemp[lCont].iCodProducto = stlGePenalizacionesHost.iCodProducto[lCont];
			if(stlGePenalizacionesHostNull.slNumAbonado[lCont] != ORA_NULL)
				pstlGePenalizacionesTemp[lCont].lNumAbonado=stlGePenalizacionesHost.lNumAbonado[lCont];
			else
				pstlGePenalizacionesTemp[lCont].lNumAbonado=-1;
			pstlGePenalizacionesTemp[lCont].lNumProceso = stlGePenalizacionesHost.lNumProceso[lCont];
		}

		(*lGePenalizaciones) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGePenalizaciones);

	iOra=ifnOraCerrarGePenalizaciones(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGePenalizaciones):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}

	qsort((void*)*pstlGePenalizaciones, *lGePenalizaciones, sizeof(PENALIZA),ifnCompareGePenalizaciones);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtFacClientes
*******************************************************************************/

BOOL bfnObtFacClientes( long *lFacClientes,FAC_CLIENTES **pstFacClientes,void* ctx,int ciclo,
			long clieini,long cliefin, char *szFecEmision)
{
	int	iOra;
	long	lNumFilas;
	static FAC_CLIENTES_HOST stFacClientesHost;
	static FAC_CLIENTES_HOST_NULL  stFacClientesHostNull;
	FAC_CLIENTES	*pstFacClientesTemp;
	long	lCont;

	*lFacClientes = 0;
	*pstFacClientes = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: FAC_CLIENTES");
	iOra=ifnOraDeclararFacClientes(ctx,ciclo,clieini,cliefin,szFecEmision);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacClientes):"
			"\n\tError al declarar cursor sobre FAC_CLIENTES[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerFacClientes(&stFacClientesHost,&lNumFilas,ctx,clieini,cliefin,&stFacClientesHostNull );
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacClientes):\n\tError al realizar el FETCH sobre FAC_CLIENTES[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilas)
			break;
		*pstFacClientes =(FAC_CLIENTES*) realloc(*pstFacClientes,(((*lFacClientes)+lNumFilas)*sizeof(FAC_CLIENTES)));
		if (!*pstFacClientes)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtFacClientes):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstFacClientesTemp = &(*pstFacClientes)[(*lFacClientes)];
		memset(pstFacClientesTemp, 0, sizeof(FAC_CLIENTES)*lNumFilas);
		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstFacClientesTemp[lCont].lRowNum =	stFacClientesHost.lRowNum[lCont];
			pstFacClientesTemp[lCont].lCargos=-1;
			pstFacClientesTemp[lCont].lCodCliente =	stFacClientesHost.lCodCliente[lCont];
			pstFacClientesTemp[lCont].iCodEstado = 0;
			pthread_mutex_init(&(pstFacClientesTemp[lCont].mMutexLock), NULL);
			strcpy(pstFacClientesTemp[lCont].szNomCliente, stFacClientesHost.szNomCliente[lCont]);

			if(stFacClientesHostNull.sszNomApeClien1[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNomApeClien1, stFacClientesHost.szNomApeClien1[lCont]);
			else
				pstFacClientesTemp[lCont].szNomApeClien1[0]=0;

			if(stFacClientesHostNull.sszNomApeClien2[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNomApeClien2, stFacClientesHost.szNomApeClien2[lCont]);
			else
				pstFacClientesTemp[lCont].szNomApeClien2[0]=0;

			if(stFacClientesHostNull.sszTefCliente1[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szTefCliente1, stFacClientesHost.szTefCliente1[lCont]);
			else
				pstFacClientesTemp[lCont].szTefCliente1[0]=0;

			if(stFacClientesHostNull.sszTefCliente2[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szTefCliente2, stFacClientesHost.szTefCliente2[lCont]);
			else
				pstFacClientesTemp[lCont].szTefCliente2[0]=0;

			if(stFacClientesHostNull.sszCodPais[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodPais, stFacClientesHost.szCodPais[lCont]);
			else
				pstFacClientesTemp[lCont].szCodPais[0]=0;

			if(stFacClientesHostNull.sszIndDebito[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szIndDebito, stFacClientesHost.szIndDebito[lCont]);
			else
				pstFacClientesTemp[lCont].szIndDebito[0]=0;

			if(stFacClientesHostNull.sdImpStopDebit[lCont] != ORA_NULL)
				pstFacClientesTemp[lCont].dImpStopDebit = stFacClientesHost.dImpStopDebit[lCont];
			else
				pstFacClientesTemp[lCont].dImpStopDebit=0.0;

			if(stFacClientesHostNull.sszCodBanco[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodBanco, stFacClientesHost.szCodBanco[lCont]);
			else
				pstFacClientesTemp[lCont].szCodBanco[0]=0;

			if(stFacClientesHostNull.sszCodSucursal[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodSucursal, stFacClientesHost.szCodSucursal[lCont]);
			else
				pstFacClientesTemp[lCont].szCodSucursal[0]=0;

			if(stFacClientesHostNull.sszIndTipCuenta[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szIndTipCuenta, stFacClientesHost.szIndTipCuenta[lCont]);
			else
				pstFacClientesTemp[lCont].szIndTipCuenta[0]=0;

			if(stFacClientesHostNull.sszCodTipTarjeta[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodTipTarjeta, stFacClientesHost.szCodTipTarjeta[lCont]);
			else
				pstFacClientesTemp[lCont].szCodTipTarjeta[0]=0;

			if(stFacClientesHostNull.sszNumCtaCorr[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNumCtaCorr, stFacClientesHost.szNumCtaCorr[lCont]);
			else
				pstFacClientesTemp[lCont].szNumCtaCorr[0]=0;

			if(stFacClientesHostNull.sszNumTarjeta[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNumTarjeta, stFacClientesHost.szNumTarjeta[lCont]);
			else
				pstFacClientesTemp[lCont].szNumTarjeta[0]=0;

			if(stFacClientesHostNull.sszFecVenciTarj[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szFecVenciTarj, stFacClientesHost.szFecVenciTarj[lCont]);
			else
				pstFacClientesTemp[lCont].szFecVenciTarj[0]=0;

			if(stFacClientesHostNull.sszCodBancoTarj[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodBancoTarj, stFacClientesHost.szCodBancoTarj[lCont]);
			else
				pstFacClientesTemp[lCont].szCodBancoTarj[0]=0;

			if(stFacClientesHostNull.sszCodTipIdTrib[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodTipIdTrib, stFacClientesHost.szCodTipIdTrib[lCont]);
			else
				pstFacClientesTemp[lCont].szCodTipIdTrib[0]=0;

			if(stFacClientesHostNull.sszNumIdentTrib[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNumIdentTrib, stFacClientesHost.szNumIdentTrib[lCont]);
			else
				pstFacClientesTemp[lCont].szNumIdentTrib[0]=0;

			if(stFacClientesHostNull.siCodActividad[lCont] != ORA_NULL)
				pstFacClientesTemp[lCont].iCodActividad = stFacClientesHost.iCodActividad[lCont];
			else
				pstFacClientesTemp[lCont].iCodActividad=-1;

			if(stFacClientesHostNull.sszCodOficina[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodOficina, stFacClientesHost.szCodOficina[lCont]);
			else
				pstFacClientesTemp[lCont].szCodOficina[0]=0;

			pstFacClientesTemp[lCont].iIndFactur = stFacClientesHost.iIndFactur[lCont];

			if(stFacClientesHostNull.sszNumFax[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNumFax, stFacClientesHost.szNumFax[lCont]);
			else
				pstFacClientesTemp[lCont].szNumFax[0]=0;

			strcpy(pstFacClientesTemp[lCont].szFecAlta, stFacClientesHost.szFecAlta[lCont]);
			pstFacClientesTemp[lCont].lCodCuenta = stFacClientesHost.lCodCuenta[lCont];
			strcpy(pstFacClientesTemp[lCont].szCodIdioma, stFacClientesHost.szCodIdioma[lCont]);

			if(stFacClientesHostNull.sszCodOperadora[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodOperadora, stFacClientesHost.szCodOperadora[lCont]);
			else
				pstFacClientesTemp[lCont].szCodOperadora[0]=0;

			strcpy(pstFacClientesTemp[lCont].szCodBancoUniPac,"");

			pstFacClientesTemp[lCont].iCodCatImpos=-1;
			
			if(stFacClientesHostNull.sszCodDespacho[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szCodDespacho, stFacClientesHost.szCodDespacho[lCont]);
			else
				strcpy(pstFacClientesTemp[lCont].szCodDespacho, "NOINF");
				
			if(stFacClientesHostNull.sszNomEmail[lCont] != ORA_NULL)
				strcpy(pstFacClientesTemp[lCont].szNomEmail, stFacClientesHost.szNomEmail[lCont]);
			else
				strcpy(pstFacClientesTemp[lCont].szNomEmail, "SIN INFORMACION");
			
			strcpy(pstFacClientesTemp[lCont].szCodIdTipDian, stFacClientesHost.szCodIdTipDian[lCont]);
			
			pstFacClientesTemp[lCont].iIndClieLoc = stFacClientesHost.iIndClieLoc[lCont];						
			
			strcpy(pstFacClientesTemp[lCont].szCodSegmentacion, stFacClientesHost.szCodSegmentacion[lCont]);			
			
		}

		(*lFacClientes) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lFacClientes);
	iOra=ifnOraCerrarFacClientes(ctx,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacClientes):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

       	qsort((void*)*pstFacClientes, *lFacClientes, sizeof(FAC_CLIENTES),ifnCompareGeClientes);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtFacCiclo
*******************************************************************************/

BOOL bfnObtFacCiclo( long *lFacCiclo,CICLOCLI **pstFacCiclo,void* ctx,int ciclo,
		     long clieini, long cliefin)
{
	int    iOra;
	long   lNumFilasCiclo;
	static CICLOCLI_HOST	stFacCicloHost;
	static CICLOCLI_HOST_NULL  stFacCicloHostNull;
	CICLOCLI *pstFacCicloTemp;
	long   lCont;

	*lFacCiclo = 0;
	*pstFacCiclo = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CICLOCLI");
	iOra=ifnOraDeclararFacCiclo(ctx,ciclo,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacCiclo):"
			"\n\tError al declarar cursor sobre CICLOCLI[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerFacCiclo(&stFacCicloHost,&stFacCicloHostNull,&lNumFilasCiclo,ctx,clieini,cliefin);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacCiclo):\n\tError al realizar el FETCH sobre CICLOCLI[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilasCiclo)
			break;
		*pstFacCiclo =(CICLOCLI*) realloc(*pstFacCiclo,(((*lFacCiclo)+lNumFilasCiclo)*sizeof(CICLOCLI)));
		if (!*pstFacCiclo)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtFacCiclo):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstFacCicloTemp = &(*pstFacCiclo)[(*lFacCiclo)];
		memset(pstFacCicloTemp, 0, sizeof(CICLOCLI)*lNumFilasCiclo);
		for (lCont = 0 ; lCont < lNumFilasCiclo ; lCont++)
		{
			strcpy(pstFacCicloTemp[lCont].szRowid, stFacCicloHost.szRowid[lCont]);
			pstFacCicloTemp[lCont].lCodCliente =	stFacCicloHost.lCodCliente[lCont];
			pstFacCicloTemp[lCont].iCodProducto =	stFacCicloHost.iCodProducto[lCont];
			pstFacCicloTemp[lCont].lNumAbonado =	stFacCicloHost.lNumAbonado[lCont];
			strcpy(pstFacCicloTemp[lCont].szCodCalClien, stFacCicloHost.szCodCalClien[lCont]);
			pstFacCicloTemp[lCont].iIndCambio =	stFacCicloHost.iIndCambio[lCont];
			strcpy(pstFacCicloTemp[lCont].szNomUsuario, stFacCicloHost.szNomUsuario[lCont]);
			strcpy(pstFacCicloTemp[lCont].szNomApellido1, stFacCicloHost.szNomApellido1[lCont]);
			if(stFacCicloHostNull.sszNomApellido2[lCont] != ORA_NULL)
				strcpy(pstFacCicloTemp[lCont].szNomApellido2, stFacCicloHost.szNomApellido2[lCont]);
			else
				strcpy(pstFacCicloTemp[lCont].szNomApellido2,"");
			if(stFacCicloHostNull.siCodCredMor[lCont] != ORA_NULL)
				pstFacCicloTemp[lCont].iCodCredMor=stFacCicloHost.iCodCredMor[lCont];
			else
				pstFacCicloTemp[lCont].iCodCredMor=ORA_NULL;
			if(stFacCicloHostNull.sszIndDebito[lCont] != ORA_NULL)
				strcpy(pstFacCicloTemp[lCont].szIndDebito, stFacCicloHost.szIndDebito[lCont]);
			else
				strcpy(pstFacCicloTemp[lCont].szIndDebito,"");
			if(stFacCicloHostNull.siCodCicloNue[lCont] != ORA_NULL)
				pstFacCicloTemp[lCont].iCodCicloNue=stFacCicloHost.iCodCicloNue[lCont];
			else
				pstFacCicloTemp[lCont].iCodCicloNue=ORA_NULL;
			strcpy(pstFacCicloTemp[lCont].szFecAlta, stFacCicloHost.szFecAlta[lCont]);
			strcpy(pstFacCicloTemp[lCont].szFecUltFact, stFacCicloHost.szFecUltFact[lCont]);
		}

		(*lFacCiclo) += lNumFilasCiclo;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lFacCiclo);
	iOra=ifnOraCerrarFacCiclo(ctx,clieini,cliefin);

	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtFacCiclo):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

       	qsort((void*)*pstFacCiclo, *lFacCiclo, sizeof(CICLOCLI),ifnCompareGeCiclo);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtCatImpClientes
*******************************************************************************/

BOOL bfnObtCatImpClientes( long *lGeCatImpClientes,CAT_IMPCLIENTES **pstlGeCatImpClientes,void* ctx,
			  long clieini, long cliefin, char *szFecha, long ciclo)
{
	int    iOra;
	long   lNumFilas;
	static CAT_IMPCLIENTES_HOST	stCatImpClientesHost;
	CAT_IMPCLIENTES *pstCatImpClientesTemp;
	long   lCont;

	*lGeCatImpClientes = 0;
	*pstlGeCatImpClientes = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: GE_CATIMPCLIENTES");
	iOra=ifnOraDeclararGeCatImpClientes(ctx,szFecha,ciclo,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCatImpClientes):"
			"\n\tError al declarar cursor sobre GE_CATIMPCLIENTES[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerGeCatImpClientes(&stCatImpClientesHost,&lNumFilas,ctx,clieini,cliefin);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCatImpClientes):\n\tError al realizar el FETCH sobre GE_CATIMPCLIENTES[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilas)
			break;
		*pstlGeCatImpClientes =(CAT_IMPCLIENTES*) realloc(*pstlGeCatImpClientes,(((*lGeCatImpClientes)+lNumFilas)*sizeof(CAT_IMPCLIENTES)));
		if (!*pstlGeCatImpClientes)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtCatImpClientes):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstCatImpClientesTemp = &(*pstlGeCatImpClientes)[(*lGeCatImpClientes)];
		memset(pstCatImpClientesTemp, 0, sizeof(CAT_IMPCLIENTES)*lNumFilas);


		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstCatImpClientesTemp[lCont].lCodCliente = stCatImpClientesHost.lCodCliente[lCont];
			pstCatImpClientesTemp[lCont].iCodCatImpos = stCatImpClientesHost.iCodCatImpos[lCont];
			strcpy(pstCatImpClientesTemp[lCont].szIndOrdenTotal, stCatImpClientesHost.szIndOrdenTotal[lCont]);
		}

		(*lGeCatImpClientes) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeCatImpClientes);
	iOra=ifnOraCerrarGeCatImpClientes(ctx,clieini,cliefin);

	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCatImpClientes):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

        qsort((void*)*pstlGeCatImpClientes, *lGeCatImpClientes, sizeof(CAT_IMPCLIENTES),ifnCompareGeCatImpClientes);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtDirecciones
*******************************************************************************/

BOOL bfnObtDirecciones( long *lGeDirecciones,DIRECCIONES **pstlGeDirecciones,void* ctx,
			  long clieini, long cliefin,long iTipDireccion,long ciclo)
{
	int    iOra;
	long   lNumFilas;
	static DIRECCIONES_HOST	stDireccionesHost;
	static DIRECCIONES_HOST_NULL  stDireccionesHostNull;
	DIRECCIONES *pstlGeDireccionesTemp;
	long   lCont;

	*lGeDirecciones = 0;
	*pstlGeDirecciones = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: GE_DIRECCIONES");
	iOra=ifnOraDeclararGeDirecciones(ctx,iTipDireccion,ciclo,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones):"
			"\n\tError al declarar cursor sobre GE_DIRECCIONES[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}
	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerGeDirecciones(&stDireccionesHost,&stDireccionesHostNull,&lNumFilas,ctx,clieini,cliefin);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones):\n\tError al realizar el FETCH sobre GE_DIRECCIONES[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilas)
			break;
		*pstlGeDirecciones =(DIRECCIONES*) realloc(*pstlGeDirecciones,(((*lGeDirecciones)+lNumFilas)*sizeof(DIRECCIONES)));
		if (!*pstlGeDirecciones)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtDirecciones):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstlGeDireccionesTemp = &(*pstlGeDirecciones)[(*lGeDirecciones)];
		memset(pstlGeDireccionesTemp, 0, sizeof(DIRECCIONES)*lNumFilas);

		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
				pstlGeDireccionesTemp[lCont].lCodCliente = stDireccionesHost.lCodCliente[lCont];
				
				if(stDireccionesHostNull.sszCodRegion[lCont] != ORA_NULL)
					strcpy(pstlGeDireccionesTemp[lCont].szCodRegion, stDireccionesHost.szCodRegion[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodRegion[0]=0;
					
				if(stDireccionesHostNull.sszCodProvincia[lCont] != ORA_NULL)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodProvincia, stDireccionesHost.szCodProvincia[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodProvincia[0]=0;
				
				if(stDireccionesHostNull.sszCodCiudad[lCont] != ORA_NULL)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodCiudad, stDireccionesHost.szCodCiudad[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodCiudad[0]=0;
					
				if(stDireccionesHostNull.sszCodComuna[lCont] != ORA_NULL)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodComuna, stDireccionesHost.szCodComuna[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodComuna[0]=0;

				if(stDireccionesHostNull.sszNomCalle[lCont] != ORA_NULL)
					strcpy(pstlGeDireccionesTemp[lCont].szNomCalle, stDireccionesHost.szNomCalle[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNomCalle[0]=0;

				if(stDireccionesHostNull.sszNumCalle[lCont] != ORA_NULL)
					strcpy(pstlGeDireccionesTemp[lCont].szNumCalle, stDireccionesHost.szNumCalle[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNumCalle[0]=0;

				if(stDireccionesHostNull.sszNumPiso[lCont] != ORA_NULL)
					strcpy(pstlGeDireccionesTemp[lCont].szNumPiso, stDireccionesHost.szNumPiso[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNumPiso[0]=0;

		}
		(*lGeDirecciones) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeDirecciones);
	iOra=ifnOraCerrarGeDirecciones(ctx,clieini,cliefin);

	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

        qsort((void*)*pstlGeDirecciones, *lGeDirecciones, sizeof(DIRECCIONES),ifnCompareGeDirecciones);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtDirecciones2
*******************************************************************************/

BOOL bfnObtDirecciones2( long *lGeDirecciones,DIRECCIONES2 **pstlGeDirecciones,void* ctx,
			  long clieini, long cliefin,long iTipDireccion,long ciclo)
{
	int    iOra;
	long   lNumFilas;
	static DIRECCIONES_HOST2	stDireccionesHost;
	static DIRECCIONES_HOST_NULL2  stDireccionesHostNull;
	DIRECCIONES2 *pstlGeDireccionesTemp;
	long   lCont;

	*lGeDirecciones = 0;
	*pstlGeDirecciones = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: GE_DIRECCIONES2");
	iOra=ifnOraDeclararGeDirecciones(ctx,iTipDireccion,ciclo,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones2):"
			"\n\tError al declarar cursor sobre GE_DIRECCIONES[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}
	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerGeDirecciones2(&stDireccionesHost,&stDireccionesHostNull,&lNumFilas,ctx,clieini,cliefin);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones2):\n\tError al realizar el FETCH sobre GE_DIRECCIONES[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilas)
			break;
		*pstlGeDirecciones =(DIRECCIONES2*) realloc(*pstlGeDirecciones,(((*lGeDirecciones)+lNumFilas)*sizeof(DIRECCIONES2)));
		if (!*pstlGeDirecciones)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtDirecciones2):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstlGeDireccionesTemp = &(*pstlGeDirecciones)[(*lGeDirecciones)];
		memset(pstlGeDireccionesTemp, 0, sizeof(DIRECCIONES2)*lNumFilas);

		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
				pstlGeDireccionesTemp[lCont].lCodCliente = stDireccionesHost.lCodCliente[lCont];
				
				if(stDireccionesHostNull.sszCodRegion[lCont] != -1)
					strcpy(pstlGeDireccionesTemp[lCont].szCodRegion, stDireccionesHost.szCodRegion[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodRegion[0]=0;
					
				if(stDireccionesHostNull.sszCodProvincia[lCont] != -1)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodProvincia, stDireccionesHost.szCodProvincia[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodProvincia[0]=0;
					
				if(stDireccionesHostNull.sszCodCiudad[lCont] != -1)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodCiudad, stDireccionesHost.szCodCiudad[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodCiudad[0]=0;
					
				if(stDireccionesHostNull.sszCodComuna[lCont] != -1)	
					strcpy(pstlGeDireccionesTemp[lCont].szCodComuna, stDireccionesHost.szCodComuna[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szCodComuna[0]=0;

				if(stDireccionesHostNull.sszNumPiso[lCont] != -1)
					strcpy(pstlGeDireccionesTemp[lCont].szNomCalle, stDireccionesHost.szNomCalle[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNomCalle[0]=0;

				if(stDireccionesHostNull.sszNumCalle[lCont] != -1)
					strcpy(pstlGeDireccionesTemp[lCont].szNumCalle, stDireccionesHost.szNumCalle[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNumCalle[0]=0;

				if(stDireccionesHostNull.sszNumPiso[lCont] != -1)
					strcpy(pstlGeDireccionesTemp[lCont].szNumPiso, stDireccionesHost.szNumPiso[lCont]);
				else
					pstlGeDireccionesTemp[lCont].szNumPiso[0]=0;

		}
		(*lGeDirecciones) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeDirecciones);
	iOra=ifnOraCerrarGeDirecciones(ctx,clieini,cliefin);

	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDirecciones2):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

        qsort((void*)*pstlGeDirecciones, *lGeDirecciones, sizeof(DIRECCIONES2),ifnCompareGeDirecciones2);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtCoUnipac
*******************************************************************************/

BOOL bfnObtCoUnipac(long *lGeUnipac,UNIPAC **pstlGeUnipac,void* ctx,
		    long clieini, long cliefin,long ciclo)
{
	int    iOra;
	long   lNumFilas;
	static UNIPAC_HOST stUnipacHost;
	UNIPAC *pstlGeUnipacTemp;
	long   lCont;

	*lGeUnipac = 0;
	*pstlGeUnipac = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: CO_UNIPAC");
	iOra=ifnOraDeclararGeCoUnipac(ctx,ciclo,clieini,cliefin);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCoUnipac):"
			"\n\tError al declarar cursor sobre CO_UNIPAC[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}
	while (iOra != NOT_FOUND)
	{
		iOra=ifnOraLeerGeCoUnipac(&stUnipacHost,&lNumFilas,ctx,clieini,cliefin);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCoUnipac):\n\tError al realizar el FETCH sobre CO_UNIPAC[%d]",iOra);
			vfnImpErrorORACLE();
			return FALSE;
		}
		if (!lNumFilas)
			break;
		*pstlGeUnipac =(UNIPAC*) realloc(*pstlGeUnipac,(((*lGeUnipac)+lNumFilas)*sizeof(UNIPAC)));
		if (!*pstlGeUnipac)
		{
			vfnLog(FILE_BOTH,"\n\nERROR(bfnObtCoUnipac):\n\tError al alocar memoria\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}
		pstlGeUnipacTemp = &(*pstlGeUnipac)[(*lGeUnipac)];
		memset(pstlGeUnipacTemp, 0, sizeof(UNIPAC)*lNumFilas);

		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeUnipacTemp[lCont].lCodCliente = stUnipacHost.lCodCliente[lCont];
			strcpy(pstlGeUnipacTemp[lCont].szCodBanco, stUnipacHost.szCodBanco[lCont]);
		}

		(*lGeUnipac) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeUnipac);
	iOra=ifnOraCerrarGeCoUnipac(ctx,clieini,cliefin);

	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtCoUnipac):\n\tError al cerrar el cursor[%d]",iOra);
		vfnImpErrorORACLE();
		return FALSE;
	}

        qsort((void*)*pstlGeUnipac, *lGeUnipac, sizeof(UNIPAC),ifnCompareGeCoUnipac);

	return TRUE;
}

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion         :       bfnObtGeOficina
*******************************************************************************/

BOOL bfnObtGeOficina ( long *lGeOficina,OFICINA **pstlGeOficina,void* ctx)
{
	int iOra;
	long lNumFilas;
	static OFICINA_HOST stlGeOficinaHost;
	OFICINA *pstlGeOficinaTemp;
	long lCont;

 	*lGeOficina = 0;
 	*pstlGeOficina = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: OFICINA");
	iOra= ifnOraDeclararGeOficina (ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOficina):"
		"\n\tError al declarar cursor sobre OFICINA");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeOficina(&stlGeOficinaHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOficina):"
		"\n\tError al  realizar el FETCH sobre OFICINA");
		vfnImpErrorORACLE();
		return FALSE;
		}

		if (!lNumFilas)
		break;

		*pstlGeOficina=(OFICINA*)realloc(*pstlGeOficina,(((*lGeOficina)+lNumFilas)*sizeof(OFICINA)));

		if (!*pstlGeOficina)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOficina):"
		"\n\tError al alocar memoria"
		"\n\tError: [%d][%s]", errno, strerror(errno));
		return FALSE;
		}

		pstlGeOficinaTemp = &(*pstlGeOficina)[(*lGeOficina)];
		memset(pstlGeOficinaTemp, 0, sizeof(OFICINA)*lNumFilas);


		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlGeOficinaTemp[lCont].szCodOficina,stlGeOficinaHost.szCodOficina[lCont]);
			strcpy(pstlGeOficinaTemp[lCont].szCodRegion,stlGeOficinaHost.szCodRegion[lCont]);
			strcpy(pstlGeOficinaTemp[lCont].szCodProvincia,stlGeOficinaHost.szCodProvincia[lCont]);
			strcpy(pstlGeOficinaTemp[lCont].szCodCiudad,stlGeOficinaHost.szCodCiudad[lCont]);
			strcpy(pstlGeOficinaTemp[lCont].szCodPlaza,stlGeOficinaHost.szCodPlaza[lCont]);
		}


		(*lGeOficina) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeOficina);

	iOra=ifnOraCerrarGeOficina(ctx);
	if (iOra != SQL_OK)
	{
	vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeOficina):"
	"\n\tError al cerrar el cursor");
	vfnImpErrorORACLE();
	return FALSE;
	}

	qsort((void*)*pstlGeOficina, *lGeOficina, sizeof(OFICINA),ifnCompareGeOficina);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtGeFactCobr
*******************************************************************************/

BOOL bfnObtGeFactCobr ( long *lGeFactCobr,FACTCOBR **pstlGeFactCobr,void* ctx)
{
	int iOra;
	long lNumFilas;
	static FACTCOBR_HOST stlGeFactCobrHost;
	FACTCOBR *pstlGeFactCobrTemp;
	long lCont;

 	*lGeFactCobr = 0;
 	*pstlGeFactCobr = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: FACTCOBR");
	iOra= ifnOraDeclararGeFactCobr (ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCobr):"
		"\n\tError al declarar cursor sobre FACTCOBR");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerGeFactCobr(&stlGeFactCobrHost,&lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCobr):"
		"\n\tError al  realizar el FETCH sobre FACTCOBR");
		vfnImpErrorORACLE();
		return FALSE;
		}

		if (!lNumFilas)
		break;

		*pstlGeFactCobr=(FACTCOBR*)realloc(*pstlGeFactCobr,(((*lGeFactCobr)+lNumFilas)*sizeof(FACTCOBR)));

		if (!*pstlGeFactCobr)
		{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCobr):"
		"\n\tError al alocar memoria"
		"\n\tError: [%d][%s]", errno, strerror(errno));
		return FALSE;
		}

		pstlGeFactCobrTemp = &(*pstlGeFactCobr)[(*lGeFactCobr)];
		memset(pstlGeFactCobrTemp, 0, sizeof(FACTCOBR)*lNumFilas);


		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			pstlGeFactCobrTemp[lCont].iCodConcFact = stlGeFactCobrHost.iCodConcFact[lCont];
			pstlGeFactCobrTemp[lCont].iCodConCobr = stlGeFactCobrHost.iCodConCobr[lCont];
		}


		(*lGeFactCobr) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lGeFactCobr);

	iOra=ifnOraCerrarGeFactCobr(ctx);
	if (iOra != SQL_OK)
	{
	vfnLog(FILE_BOTH, "\n\nERROR(bfnObtGeFactCobr):"
	"\n\tError al cerrar el cursor");
	vfnImpErrorORACLE();
	return FALSE;
	}

	qsort((void*)*pstlGeFactCobr, *lGeFactCobr, sizeof(FACTCOBR),ifnCompareGeFactCobr);

	return TRUE;
}

/******************************************************************************
Funcion         :       bfnObtDetPlanDesc
*******************************************************************************/

BOOL bfnObtDetPlanDesc ( long *lNumRegs,DETPLANDESC **pstlDetPlanDesc,void* ctx, long lCodCiclFact)
{
	int iOra;
	long lNumFilas;
	static DETPLANDESC_HOST stlDetPlanDescHost;
	static DETPLANDESC_HOST_NULL  stlDetPlanDescHostNull;
	DETPLANDESC *pstlDetPlanDescTemp;
	long lCont;

 	*lNumRegs = 0;
 	*pstlDetPlanDesc = NULL;

	vfnLog(FILE_LOG, "\n\t-Leyendo datos: DETPLANDESC");
	iOra= ifnOraDeclararDetPlanDesc (ctx, lCodCiclFact);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDetPlanDesc):"
		"\n\tError al declarar cursor sobre DETPLANDESC");
		vfnImpErrorORACLE();
		return FALSE;
	}

	while (iOra != NOT_FOUND)
	{
		iOra= ifnOraLeerDetPlanDesc(&stlDetPlanDescHost, &stlDetPlanDescHostNull, &lNumFilas,ctx);
		if (iOra != SQL_OK  && iOra != NOT_FOUND)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDetPlanDesc):"
							  "\n\tError al  realizar el FETCH sobre DETPLANDESC");
			vfnImpErrorORACLE();
			return FALSE;
		}

		if (!lNumFilas)
		break;

		*pstlDetPlanDesc=(DETPLANDESC*)realloc(*pstlDetPlanDesc,(((*lNumRegs)+lNumFilas)*sizeof(DETPLANDESC)));

		if (!*pstlDetPlanDesc)
		{
			vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDetPlanDesc):"
							  "\n\tError al alocar memoria"
							  "\n\tError: [%d][%s]", errno, strerror(errno));
			return FALSE;
		}

		pstlDetPlanDescTemp = &(*pstlDetPlanDesc)[(*lNumRegs)];
		memset(pstlDetPlanDescTemp, 0, sizeof(DETPLANDESC)*lNumFilas);


		for (lCont = 0 ; lCont < lNumFilas ; lCont++)
		{
			strcpy(pstlDetPlanDescTemp[lCont].szCodPlan 		,stlDetPlanDescHost.szCodPlan [lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szDesPlandesc 	,stlDetPlanDescHost.szDesPlandesc [lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szFecDesdePlandesc,stlDetPlanDescHost.szFecDesdePlandesc [lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szFecHastaPlandesc,stlDetPlanDescHost.szFecHastaPlandesc [lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szIndRestriccion 	,stlDetPlanDescHost.szIndRestriccion  [lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szFecDesdeDetplan ,stlDetPlanDescHost.szFecDesdeDetplan[lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szFecHastaDetplan ,stlDetPlanDescHost.szFecHastaDetplan[lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szCodTipeval 		,stlDetPlanDescHost.szCodTipeval[lCont]);
			strcpy(pstlDetPlanDescTemp[lCont].szCodTipapli 		,stlDetPlanDescHost.szCodTipapli[lCont]);

	        if (stlDetPlanDescHostNull.i_shCodGrupoeval [lCont]== ORA_NULL)
	            pstlDetPlanDescTemp[lCont].iCodGrupoeval = -1;
	        else
	            pstlDetPlanDescTemp[lCont].iCodGrupoeval = stlDetPlanDescHost.iCodGrupoeval[lCont];

	        if (stlDetPlanDescHostNull.i_shCodGrupoapli [lCont]== ORA_NULL)
	            pstlDetPlanDescTemp[lCont].iCodGrupoapli = -1;
	        else
	            pstlDetPlanDescTemp[lCont].iCodGrupoapli = stlDetPlanDescHost.iCodGrupoapli[lCont];

	        if (stlDetPlanDescHostNull.i_shNumCuadrante[lCont] == ORA_NULL)
	            pstlDetPlanDescTemp[lCont].iNumCuadrante = -1;
	        else
	            pstlDetPlanDescTemp[lCont].iNumCuadrante = stlDetPlanDescHost.iNumCuadrante[lCont];

			strcpy(pstlDetPlanDescTemp[lCont].szTipUnidad ,stlDetPlanDescHost.szTipUnidad[lCont]);

	        if (stlDetPlanDescHostNull.i_shCodConcdesc[lCont] == ORA_NULL)
	            pstlDetPlanDescTemp[lCont].iCodConcdesc = -1;
	        else
	            pstlDetPlanDescTemp[lCont].iCodConcdesc = stlDetPlanDescHost.iCodConcdesc[lCont];

	        if (stlDetPlanDescHostNull.i_shMtoMinfact [lCont] == ORA_NULL)
	            pstlDetPlanDescTemp[lCont].dMtoMinfact = -1;
	        else
	            pstlDetPlanDescTemp[lCont].dMtoMinfact = stlDetPlanDescHost.dMtoMinfact[lCont];

		}

		(*lNumRegs) += lNumFilas;
	}
	vfnLog(FILE_LOG, "\t\t\t[%d]", *lNumRegs);

	iOra=ifnOraCerrarDetPlanDesc(ctx);
	if (iOra != SQL_OK)
	{
		vfnLog(FILE_BOTH, "\n\nERROR(bfnObtDetPlanDesc):"
		"\n\tError al cerrar el cursor");
		vfnImpErrorORACLE();
		return FALSE;
	}
	qsort((void*)*pstlDetPlanDesc, *lNumRegs, sizeof(DETPLANDESC),ifnCmpDetPlanDesc);

	return TRUE;
}


/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion         :       ifnCompareGeCargos
*******************************************************************************/

static int ifnCompareGeCargos(const void *pvstKey,const void *pvstItem)
{
	int rc=0;
	CARGOS *pstKey		= (CARGOS *) pvstKey;
	CARGOS *pstItem 	= (CARGOS *) pvstItem;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
    		rc = 1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	if ( pstKey->lCodCliente == pstItem->lCodCliente )
       		rc =  0;
  	return rc;

}

/******************************************************************************
Funcion         :       ifnCompareGeCabCuotas
*******************************************************************************/

static int ifnCompareGeCabCuotas(const void *pvstKey,const void *pvstItem)
{
	CABCUOTAS *pstKey	= (CABCUOTAS *) pvstKey;
	CABCUOTAS *pstItem	= (CABCUOTAS *) pvstItem;
	int rc = 0;

  	if ( pstKey->lSeqCuotas > pstItem->lSeqCuotas )
       		rc =  1;
  	if ( pstKey->lSeqCuotas < pstItem->lSeqCuotas )
       		rc = -1;
  	return rc;

}

/******************************************************************************
Funcion         :       ifnCompareGeTaConcepFact
*******************************************************************************/

static int ifnCompareGeTaConcepFact(const void *pvstKey,const void *pvstItem)
{
	TACONCEPFACT *pstKey	= (TACONCEPFACT *) pvstKey;
	TACONCEPFACT *pstItem	= (TACONCEPFACT *) pvstItem;

	return ( pstKey->iCodFacturacion - pstItem->iCodFacturacion );

}

/******************************************************************************
Funcion         :       ifnCompareGeConceptos_Mi
*******************************************************************************/

static int ifnCompareGeConceptos_Mi(const void *pvstKey,const void *pvstItem)
{
	CONCEPTO_MI *pstKey	= (CONCEPTO_MI *) pvstKey;
	CONCEPTO_MI *pstItem	= (CONCEPTO_MI *) pvstItem;
	int rc = 0;

    return ( (rc = pstKey->iCodConcepto-pstItem->iCodConcepto) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeRangoTabla
*******************************************************************************/

static int ifnCompareGeRangoTabla(const void *pvstKey,const void *pvstItem)
{
	RANGOTABLA *pstKey	= (RANGOTABLA *) pvstKey;
	RANGOTABLA *pstItem	= (RANGOTABLA *) pvstItem;
	int rc = 0;

  	return
   		( (rc =  pstKey->lCodCiclFact-
            		pstItem->lCodCiclFact )!= 0)?rc:
   		( (rc =  pstKey->lRangoIni-
            		pstItem->lRangoIni    )!= 0)?rc:
   		( (rc =  strcmp ( pstKey->szNomTabla,
                      	pstItem->szNomTabla )) != 0)?rc:0 ;

}

/******************************************************************************
Funcion         :       ifnCompareGeLimCreditos
*******************************************************************************/

static int ifnCompareGeLimCreditos(const void *pvstKey,const void *pvstItem)
{
	LIMCREDITOS *pstKey	= (LIMCREDITOS *) pvstKey;
	LIMCREDITOS *pstItem	= (LIMCREDITOS *) pvstItem;
	int rc = 0;

   	return
    		( (rc = pstKey->iCodCredMor -
            		pstItem->iCodCredMor ) != 0)?rc:
    		( (rc = pstKey->iCodProducto-
            		pstItem->iCodProducto) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeActividades
*******************************************************************************/

static int ifnCompareGeActividades(const void *pvstKey,const void *pvstItem)
{
	ACTIVIDADES *pstKey	= (ACTIVIDADES *) pvstKey;
	ACTIVIDADES *pstItem	= (ACTIVIDADES *) pvstItem;

	return pstKey->iCodActividad-pstItem->iCodActividad;
}

/******************************************************************************
Funcion         :       ifnCompareGeProvincias
*******************************************************************************/

static int ifnCompareGeProvincias(const void *pvstKey,const void *pvstItem)
{
	PROVINCIAS *pstKey	= (PROVINCIAS *) pvstKey;
	PROVINCIAS *pstItem	= (PROVINCIAS *) pvstItem;
	int rc = 0;

  	return
   		( (rc = strcmp ( pstKey->szCodRegion,
                    	pstItem->szCodRegion    ) )!= 0 )?rc:
   		( (rc = strcmp ( pstKey->szCodProvincia,
                    	pstItem->szCodProvincia ) )!= 0 )?rc:0;
}

/******************************************************************************
Funcion         :       ifnCompareGeRegiones
*******************************************************************************/

static int ifnCompareGeRegiones(const void *pvstKey,const void *pvstItem)
{
	REGIONES *pstKey	= (REGIONES *) pvstKey;
	REGIONES *pstItem	= (REGIONES *) pvstItem;

	int rc = 0;

  	return ( (rc = strcmp ( pstKey->szCodRegion, pstItem->szCodRegion) )  != 0 )?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeCatImpositiva
*******************************************************************************/

static int ifnCompareGeCatImpositiva(const void *pvstKey,const void *pvstItem)
{
	CATIMPOSITIVA *pstKey	= (CATIMPOSITIVA *) pvstKey;
	CATIMPOSITIVA *pstItem	= (CATIMPOSITIVA *) pvstItem;
	int rc = 0;

  	return ( (rc = pstKey->iCodCatImpos-pstItem->iCodCatImpos) != 0)?rc:0;
}

/******************************************************************************
Funcion         :       ifnCompareGeZonaCiudad
*******************************************************************************/

static int ifnCompareGeZonaCiudad(const void *pvstKey,const void *pvstItem)
{
	ZONACIUDAD *pstKey	= (ZONACIUDAD *) pvstKey;
	ZONACIUDAD *pstItem	= (ZONACIUDAD *) pvstItem;
	int rc = 0;

  	return
   		( (rc = strcmp ( pstKey->szCodRegion,
                    	pstItem->szCodRegion ))    != 0)?rc:
   		( (rc = strcmp ( pstKey->szCodProvincia,
                    	pstItem->szCodProvincia )) != 0)?rc:
   		( (rc = strcmp ( pstKey->szCodCiudad,
                    	pstItem->szCodCiudad ))    != 0)?rc:
   		( (rc = strcmp ( pstKey->szFecDesde,
                    	pstItem->szFecDesde )) < 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeZonaImpositiva
*******************************************************************************/

static int ifnCompareGeZonaImpositiva(const void *pvstKey,const void *pvstItem)
{
	ZONAIMPOSITIVA *pstKey	= (ZONAIMPOSITIVA *) pvstKey;
	ZONAIMPOSITIVA *pstItem	= (ZONAIMPOSITIVA *) pvstItem;
	int rc = 0;

  	return  ( (rc = pstKey->iCodZonaImpo-pstItem->iCodZonaImpo) != 0)?rc:0;
}

/******************************************************************************
Funcion         :       ifnCompareGeImpuestos
*******************************************************************************/

static int ifnCompareGeImpuestos(const void *pvstKey,const void *pvstItem)
{
	IMPUESTOS *pstKey	= (IMPUESTOS *) pvstKey;
	IMPUESTOS *pstItem	= (IMPUESTOS *) pvstItem;

	int rc  = 0;
  	return
  		( (rc = pstKey->iCodCatImpos -
          		pstItem->iCodCatImpos ) != 0)?rc:
  		( (rc = pstKey->iCodZonaImpo -
          		pstItem->iCodZonaImpo ) != 0)?rc:
  		( (rc = pstKey->iCodZonaAbon -
          		pstItem->iCodZonaAbon ) != 0)?rc:
  		( (rc = pstKey->iCodTipImpues-
          		pstItem->iCodTipImpues) != 0)?rc:
  		( (rc = pstKey->iCodGrpServi -
          		pstItem->iCodGrpServi ) != 0)?rc:
  		( (rc = pstKey->iCodConcGene -
          		pstItem->iCodConcGene ) != 0)?rc:
  		( (rc = strcmp ( pstKey->szFecDesde,
                   	pstItem->szFecDesde) ) != 0)?rc:0;
}

/******************************************************************************
Funcion         :       ifnCompareGeTipImpues
*******************************************************************************/
/*
static int ifnCompareGeTipImpues(const void *pvstKey,const void *pvstItem)
{
	TIPIMPUES *pstKey	= (TIPIMPUES *) pvstKey;
	TIPIMPUES *pstItem	= (TIPIMPUES *) pvstItem;
	int rc = 0;

  	return ( (rc = pstKey->iCodTipImpue-pstItem->iCodTipImpue ) != 0)?rc:0;
}
*/
/******************************************************************************
Funcion         :       ifnCompareGeGrpSerConc
*******************************************************************************/

static int ifnCompareGeGrpSerConc(const void *pvstKey,const void *pvstItem)
{
	GRPSERCONC *pstKey	= (GRPSERCONC *) pvstKey;
	GRPSERCONC *pstItem	= (GRPSERCONC *) pvstItem;
	int rc = 0;

  	return
       		( (rc = pstKey->iCodConcepto-
               		pstItem->iCodConcepto) != 0)?rc:
       		( (rc = strcmp (pstKey->szFecDesde,
                       	pstItem->szFecDesde)) < 0)?rc:
       		( (rc = strcmp (pstKey->szFecHasta,
                       	pstItem->szFecHasta)) > 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeConversion
*******************************************************************************/

static int ifnCompareGeConversion(const void *pvstKey,const void *pvstItem)
{
	CONVERSION *pstKey	= (CONVERSION *) pvstKey;
	CONVERSION *pstItem	= (CONVERSION *) pvstItem;
	int rc = 0;

  	return
   		( (rc = strcmp ( pstKey->szCodMoneda,
                    	pstItem->szCodMoneda) )!= 0)?rc:
   		( (rc = strcmp ( pstKey->szFecDesde,
                    	pstItem->szFecDesde ) ) < 0)?rc:
   		( (rc = strcmp ( pstKey->szFecHasta ,
                    	pstItem->szFecHasta ) ) > 0)?rc:0;
}

/******************************************************************************
Funcion         :       ifnCompareGeDocumSucursal
*******************************************************************************/

static int ifnCompareGeDocumSucursal(const void *pvstKey,const void *pvstItem)
{
	DOCUMSUCURSAL *pstKey	= (DOCUMSUCURSAL *) pvstKey;
	DOCUMSUCURSAL *pstItem	= (DOCUMSUCURSAL *) pvstItem;
	int rc = 0;

   	return
    		( (rc = strcmp ( pstKey->szCodOficina,
              		pstItem->szCodOficina) ) != 0)?rc:
    		( (rc = pstKey->iCodTipDocum-
            		pstItem->iCodTipDocum) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeLetras
*******************************************************************************/

static int ifnCompareGeLetras(const void *pvstKey,const void *pvstItem)
{
	LETRAS *pstKey	= (LETRAS *) pvstKey;
	LETRAS *pstItem	= (LETRAS *) pvstItem;
	int rc = 0;

  	return
   		( (rc = pstKey->iCodTipDocum-
           		pstItem->iCodTipDocum ) != 0)?rc:
   		( (rc = pstKey->iCodCatImpos-
           		pstItem->iCodCatImpos ) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeGrupoCob
*******************************************************************************/

static int ifnCompareGeGrupoCob(const void *pvstKey,const void *pvstItem)
{
	GRUPOCOB *pstKey	= (GRUPOCOB *) pvstKey;
	GRUPOCOB *pstItem	= (GRUPOCOB *) pvstItem;
	int rc = 0;

  	return
   		( (rc = strcmp ( pstKey->szCodGrupo,
                    	pstItem->szCodGrupo ) ) != 0)?rc:
   		( (rc = pstKey->iCodProducto-
           		pstItem->iCodProducto) != 0)?rc:
   		( (rc = pstKey->iCodConcepto-
           		pstItem->iCodConcepto) != 0)?rc:
   		( (rc = pstKey->iCodCiclo-
           		pstItem->iCodCiclo) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeTarifas
*******************************************************************************/

static int ifnCompareGeTarifas(const void *pvstKey,const void *pvstItem)
{
	TARIFAS *pstKey	= (TARIFAS *) pvstKey;
	TARIFAS *pstItem = (TARIFAS *) pvstItem;
	int rc = 0;

   	return
    		( (rc = strcmp ( pstKey->szCodTipServ,
                     	pstItem->szCodTipServ) )!= 0)?rc:
    		( (rc = strcmp ( pstKey->szCodServicio,
                     	pstItem->szCodServicio))!= 0)?rc:
    		( (rc = strcmp ( pstKey->szCodPlanServ,
                     	pstItem->szCodPlanServ))!= 0)?rc:
    		( (rc = strcmp ( pstKey->szFecDesde,
                     	pstItem->szFecDesde)  ) < 0 )?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeActuaServ
*******************************************************************************/

static int ifnCompareGeActuaServ(const void *pvstKey,const void *pvstItem)
{
	ACTUASERV *pstKey	= (ACTUASERV *) pvstKey;
	ACTUASERV *pstItem 	= (ACTUASERV *) pvstItem;
	int rc = 0;

   	return
    		( (rc = strcmp ( pstKey->szCodTipServ,
                     	pstItem->szCodTipServ) ) != 0)?rc:
    		( (rc = strcmp ( pstKey->szCodServicio,
                     	pstItem->szCodServicio)) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeCuotas
*******************************************************************************/

static int ifnCompareGeCuotas(const void *pvstKey,const void *pvstItem)
{
	CUOTAS *pstKey	= (CUOTAS *) pvstKey;
	CUOTAS *pstItem = (CUOTAS *) pvstItem;
	int rc = 0;

    	if ( pstKey->lSeqCuotas > pstItem->lSeqCuotas )
         	rc =  1;
    	if ( pstKey->lSeqCuotas < pstItem->lSeqCuotas )
         	rc = -1;
    	if ( pstKey->lSeqCuotas == pstItem->lSeqCuotas)
    	{
         	rc = pstKey->iOrdCuota - pstItem->iOrdCuota;
    	}
    	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeFactCarriers
*******************************************************************************/

static int ifnCompareGeFactCarriers(const void *pvstKey,const void *pvstItem)
{
	FACTCARRIERS *pstKey	= (FACTCARRIERS *) pvstKey;
	FACTCARRIERS *pstItem 	= (FACTCARRIERS *) pvstItem;

	return ( pstKey->iCodConcFact - pstItem->iCodConcFact );

}

/******************************************************************************
Funcion         :       ifnCompareGeCuadCtoPlan
*******************************************************************************/

static int ifnCompareGeCuadCtoPlan(const void *pvstKey,const void *pvstItem)
{
	CUADCTOPLAN *pstKey	= (CUADCTOPLAN *) pvstKey;
	CUADCTOPLAN *pstItem 	= (CUADCTOPLAN *) pvstItem;

	return
   		( pstKey->lCodCtoPlan <
     			pstItem->lCodCtoPlan )?-1:
   		( pstKey->lCodCtoPlan >
     			pstItem->lCodCtoPlan )? 1:
   		( pstKey->dImpUmbDesde<
     			pstItem->dImpUmbDesde)?-1:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeCtoPlan
*******************************************************************************/

static int ifnCompareGeCtoPlan(const void *pvstKey,const void *pvstItem)
{
	CTOPLAN *pstKey	= (CTOPLAN *) pvstKey;
	CTOPLAN *pstItem = (CTOPLAN *) pvstItem;

	return
    		( pstKey->lCodCtoPlan < pstItem->lCodCtoPlan )?-1:
    		( pstKey->lCodCtoPlan > pstItem->lCodCtoPlan )? 1:0;

}

/******************************************************************************
Funcion         :       ifnCompareGePlanCtoPlan
*******************************************************************************/

static int ifnCompareGePlanCtoPlan(const void *pvstKey,const void *pvstItem)
{
	PLANCTOPLAN *pstKey	= (PLANCTOPLAN *) pvstKey;
	PLANCTOPLAN *pstItem 	= (PLANCTOPLAN *) pvstItem;
	int rc = 0;

  	return
   		( pstKey->lCodPlanCom <
     			pstItem->lCodPlanCom)?-1:
   		( pstKey->lCodPlanCom >
     			pstItem->lCodPlanCom)? 1:
   		( pstKey->lCodCtoPlan <
     			pstItem->lCodCtoPlan )?-1:
   		( pstKey->lCodCtoPlan >
     			pstItem->lCodCtoPlan )? 1:
   		( (rc = strcmp ( pstKey->szFecEfectividad, pstItem->szFecEfectividad ) != 0))?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeArriendo
*******************************************************************************/

static int ifnCompareGeArriendo(const void *pvstKey,const void *pvstItem)
{
	ARRIENDO *pstKey	= (ARRIENDO *) pvstKey;
	ARRIENDO *pstItem 	= (ARRIENDO *) pvstItem;

	if ( pstKey->lCodCliente > pstItem->lCodCliente )
    		return  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
    		return -1;
  	if ( pstKey->lCodCliente ==pstItem->lCodCliente )
  	{
    		if ( pstKey->lNumAbonado > pstItem->lNumAbonado )
        		return  1;
      		if ( pstKey->lNumAbonado < pstItem->lNumAbonado )
        		return -1;
      		if ( pstKey->lNumAbonado == pstItem->lNumAbonado )
      		{
        		if (strcmp ( pstKey->szFecDesde,pstItem->szFecDesde ) > 0 )
            			return  1;
          		if (strcmp ( pstKey->szFecDesde,pstItem->szFecDesde ) < 0 )
              			return -1;
          		if (strcmp ( pstKey->szFecDesde,pstItem->szFecDesde ) == 0)
              			return  0;
      		}
  	}
}

/******************************************************************************
Funcion         :       ifnCompareGeCargosBasico
*******************************************************************************/

static int ifnCompareGeCargosBasico(const void *pvstKey,const void *pvstItem)
{
	CARGOSBASICO *pstKey	= (CARGOSBASICO *) pvstKey;
	CARGOSBASICO *pstItem 	= (CARGOSBASICO *) pvstItem;
	int rc = 0;

  	return ( (rc = strcmp ( pstKey->szCodCargoBasico,
                    	   pstItem->szCodCargoBasico) ) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeOptimo
*******************************************************************************/

static int ifnCompareGeOptimo(const void *pvstKey,const void *pvstItem)
{
	OPTIMO *pstKey		= (OPTIMO *) pvstKey;
	OPTIMO *pstItem 	= (OPTIMO *) pvstItem;
	int rc = 0;

   	return
   		( (rc = strcmp ( pstKey->szCodPlanTarif,
                        pstItem->szCodPlanTarif)) != 0)?rc:
          	( pstKey->lMinDesde < pstItem->lMinDesde )?-1:
          	( pstKey->lMinDesde > pstItem->lMinDesde )? 1:0;

}

/******************************************************************************
Funcion         :       ifnCompareGeFeriados
*******************************************************************************/

static int ifnCompareGeFeriados(const void *pvstKey,const void *pvstItem)
{
	FERIADOS *pstKey	= (FERIADOS *) pvstKey;
	FERIADOS *pstItem 	= (FERIADOS *) pvstItem;


	if(strcmp(pstKey->szFecFeriado, pstItem->szFecFeriado) > 0)
		return 1;
	if(strcmp(pstKey->szFecFeriado, pstItem->szFecFeriado) < 0)
		return -1;

	return 0;
}

/******************************************************************************
Funcion         :       ifnCompareGePlanTarif
*******************************************************************************/

static int ifnCompareGePlanTarif(const void *pvstKey,const void *pvstItem)
{
	PLANTARIF *pstKey	= (PLANTARIF *) pvstKey;
	PLANTARIF *pstItem 	= (PLANTARIF *) pvstItem;
	int rc = 0;

   	return ( (rc = strcmp ( pstKey->szCodPlanTarif,
                     	   pstItem->szCodPlanTarif) ) != 0)?rc:0;

}

/******************************************************************************
Funcion         :       ifnCompareGePenalizaciones
*******************************************************************************/

static int ifnCompareGePenalizaciones(const void *pvstKey,const void *pvstItem)
{
	PENALIZA *pstKey	= (PENALIZA *) pvstKey;
	PENALIZA *pstItem 	= (PENALIZA *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
    		return  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
    		return -1;
  	if ( pstKey->lCodCliente ==pstItem->lCodCliente )
  	{
    		return
        		( (rc = pstKey->iTipIncidencia-
                  		pstItem->iTipIncidencia) != 0)?rc:
          		( (rc = strcmp ( pstKey->szFecEfectividad,
                           	pstItem->szFecEfectividad) ) != 0)?rc :0;
	}
}

/******************************************************************************
Funcion         :       ifnCompareFacClientes
*******************************************************************************/

static int ifnCompareFacClientes(const void *pvstKey,const void	*pvstItem)
{
	FAC_CLIENTES *pstKey	= (FAC_CLIENTES *) pvstKey;
	FAC_CLIENTES *pstItem	= (FAC_CLIENTES *) pvstItem;

	if(pstKey->lCodCliente > pstItem->lCodCliente)
		return 1;
	if(pstKey->lCodCliente < pstItem->lCodCliente)
		return -1;

	return 0;
}

/********************************************************
	INICIO NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion         :       ifnCompareGeOficina
*******************************************************************************/

static int ifnCompareGeOficina(const void *pvstKey,const void *pvstItem)
{
	OFICINA *pstKey		= (OFICINA *) pvstKey;
	OFICINA *pstItem	= (OFICINA *) pvstItem;

	return(strcmp(((OFICINA*)pstKey)->szCodOficina,((OFICINA*)pstItem)->szCodOficina));

}

/******************************************************************************
Funcion         :       ifnCompareGeFactCobr
*******************************************************************************/

static int ifnCompareGeFactCobr(const void *pvstKey,const void *pvstItem)
{

	return ((FACTCOBR *)pvstKey)->iCodConcFact - ((FACTCOBR *)pvstItem)->iCodConcFact;
}

/********************************************************
	FIN NUEVAS ESTRUCTURAS HOMOLOGADO
********************************************************/

/******************************************************************************
Funcion         :       ifnCompareGeDirecciones
*******************************************************************************/

static int ifnCompareGeDirecciones(const void *pvstKey,const void *pvstItem)
{
	DIRECCIONES *pstKey	= (DIRECCIONES *) pvstKey;
	DIRECCIONES *pstItem	= (DIRECCIONES *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeDirecciones2
*******************************************************************************/

static int ifnCompareGeDirecciones2(const void *pvstKey,const void *pvstItem)
{
	DIRECCIONES2 *pstKey	= (DIRECCIONES2 *) pvstKey;
	DIRECCIONES2 *pstItem	= (DIRECCIONES2 *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeCoUnipac
*******************************************************************************/

static int ifnCompareGeCoUnipac(const void *pvstKey,const void *pvstItem)
{
	UNIPAC *pstKey	= (UNIPAC *) pvstKey;
	UNIPAC *pstItem	= (UNIPAC *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeCatImpClientes
*******************************************************************************/

static int ifnCompareGeCatImpClientes(const void *pvstKey,const void *pvstItem)
{
	CAT_IMPCLIENTES *pstKey	 = (CAT_IMPCLIENTES *) pvstKey;
	CAT_IMPCLIENTES *pstItem = (CAT_IMPCLIENTES *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeClientes
*******************************************************************************/

static int ifnCompareGeClientes(const void *pvstKey,const void *pvstItem)
{
	FAC_CLIENTES *pstKey	 = (FAC_CLIENTES *) pvstKey;
	FAC_CLIENTES *pstItem    = (FAC_CLIENTES *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}

/******************************************************************************
Funcion         :       ifnCompareGeCiclo
*******************************************************************************/

static int ifnCompareGeCiclo(const void *pvstKey,const void *pvstItem)
{
	CICLOCLI *pstKey	 = (CICLOCLI *) pvstKey;
	CICLOCLI *pstItem       = (CICLOCLI *) pvstItem;
	int rc = 0;

  	if ( pstKey->lCodCliente > pstItem->lCodCliente )
       		rc =  1;
  	if ( pstKey->lCodCliente < pstItem->lCodCliente )
       		rc = -1;
  	return rc;
}
/******************************************************************************
Funcion         :       ifnCmpDetPlanDesc
*******************************************************************************/
int ifnCmpDetPlanDesc(const void *cad1,const void *cad2)
{
	return ( strcmp( ((DETPLANDESC  *)cad1)->szCodPlan, ((DETPLANDESC  *)cad2)->szCodPlan ));

}

