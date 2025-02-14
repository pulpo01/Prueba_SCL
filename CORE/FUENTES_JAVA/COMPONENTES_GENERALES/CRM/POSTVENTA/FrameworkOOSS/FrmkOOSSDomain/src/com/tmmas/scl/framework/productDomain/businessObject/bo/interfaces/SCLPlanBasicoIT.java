package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.BusquedaPlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.BusquedaServiciosDefaultDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanCicloDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServiciosDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.BolsaDinamicaDTO;

public interface SCLPlanBasicoIT {
	
	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ProductOfferingException;
	
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws ProductOfferingException;
	
	public ServiciosDTO obtenerServiciosDefaultPlan(BusquedaServiciosDefaultDTO param) throws ProductOfferingException;
	
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws ProductOfferingException;
	
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws ProductOfferingException;
	
	public ProductoOfertadoListDTO obtenerProductosPorDefectoPlan(AbonadoDTO abonado) throws ProductOfferingException;
	
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws ProductOfferingException;
	
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws ProductOfferingException;
	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws ProductOfferingException;
	
	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ProductOfferingException;
}
