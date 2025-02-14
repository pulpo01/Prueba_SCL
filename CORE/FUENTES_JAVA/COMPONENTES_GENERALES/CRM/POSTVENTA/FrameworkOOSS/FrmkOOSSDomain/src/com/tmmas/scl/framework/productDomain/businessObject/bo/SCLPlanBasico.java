package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.CicloFactDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ClienteDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanBasicoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SCLPlanBasicoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLPlanBasicoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
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

public class SCLPlanBasico implements SCLPlanBasicoIT {

	private SCLPlanBasicoDAOIT planDAO = new SCLPlanBasicoDAO();
	
	private final Logger logger = Logger.getLogger(SCLPlanBasico.class);
	private Global global = Global.getInstance();
	
	public PlanTarifarioListDTO obtenerPlanesTarifarios(
			BusquedaPlanTarifarioDTO param) throws ProductOfferingException {
		PlanTarifarioListDTO planes = null;
		try {
			logger.debug("obtenerPlanesTarifarios():start");
			planes = planDAO.obtenerPlanesTarifarios(param);
			logger.debug("obtenerPlanesTarifarios():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return planes;	
	}
	
	public RetornoDTO registroHistoricoPlan(CicloFactDTO ciclo) throws ProductOfferingException{
		RetornoDTO retorno = null;
		try {
			logger.debug("registroHistoricoPlan():start");
			retorno = planDAO.registroHistoricoPlan(ciclo);
			logger.debug("registroHistoricoPlan():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return retorno;			
	}

	public ServiciosDTO obtenerServiciosDefaultPlan(BusquedaServiciosDefaultDTO param) throws ProductOfferingException{
		ServiciosDTO servicios = null;
		try {
			logger.debug("obtenerServiciosDefaultPlan():start");
			servicios = planDAO.obtenerServiciosDefaultPlan(param);
			logger.debug("obtenerServiciosDefaultPlan():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return servicios;			
	}
	
	public RetornoDTO anularCargoBolsaDinamica(BolsaDinamicaDTO bolsa) throws ProductOfferingException{
		RetornoDTO retorno = null;
		try {
			logger.debug("anularCargoBolsaDinamica():start");
			retorno = planDAO.anularCargoBolsaDinamica(bolsa);
			logger.debug("anularCargoBolsaDinamica():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return retorno;			
	}
	
	public RetornoDTO validaFreedom(ClienteDTO cliente) throws ProductOfferingException{
		RetornoDTO retorno = null;
		try {
			logger.debug("validaFreedom():start");
			retorno = planDAO.validaFreedom(cliente);
			logger.debug("validaFreedom():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return retorno;				
	}
	
	public ProductoOfertadoListDTO obtenerProductosPorDefectoPlan(AbonadoDTO abonado) throws ProductOfferingException{
		ProductoOfertadoListDTO listaProductos = null;
		try {
			logger.debug("obtenerProductosPorDefectoPlan():start");
			listaProductos = planDAO.obtenerProductosPorDefectoPlan(abonado);
			logger.debug("obtenerProductosPorDefectoPlan():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return listaProductos;			
	}
	
	public PlanCicloDTO obtenerCicloFreedom(PlanCicloDTO plan) throws ProductOfferingException{
		PlanCicloDTO respuesta = null;
		try {
			logger.debug("obtenerCicloFreedom():start");
			respuesta = planDAO.obtenerCicloFreedom(plan);
			logger.debug("obtenerCicloFreedom():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return respuesta;			
	}
	
	public PlanTarifarioDTO obtenerCategPlan(PlanTarifarioDTO plan) throws ProductOfferingException{
		PlanTarifarioDTO respuesta = null;
		try {
			logger.debug("obtenerCategPlan():start");
			respuesta = planDAO.obtenerCategPlan(plan);
			logger.debug("obtenerCategPlan():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return respuesta;		
	}
	
	public ClienteDTO obtenerPlanComercial(ClienteDTO cliente) throws ProductOfferingException{
		ClienteDTO respuesta = null;
		try {
			logger.debug("obtenerPlanComercial():start");
			respuesta = planDAO.obtenerPlanComercial(cliente);
			logger.debug("obtenerPlanComercial():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return respuesta;		
	}

	public PlanTarifarioDTO obtenerDetallePlanTarif(PlanTarifarioDTO planTarif) throws ProductOfferingException 
	{		
		try {
			logger.debug("obtenerDetallePlanTarif():start");
			planTarif = planDAO.obtenerDetallePlanTarif(planTarif);
			logger.debug("obtenerDetallePlanTarif():end");
		} catch (ProductOfferingException e) {
			logger.debug("ProductOfferingException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingException(e);
		}		
		return planTarif;		
	}
}
