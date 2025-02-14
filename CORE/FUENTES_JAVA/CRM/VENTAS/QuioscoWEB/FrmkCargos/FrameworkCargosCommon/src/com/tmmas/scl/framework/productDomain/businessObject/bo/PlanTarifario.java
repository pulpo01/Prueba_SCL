package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.PlanTarifarioDAO;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.PlanTarifarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;



public class PlanTarifario implements PlanTarifarioIT {
	
	
	private PlanTarifarioDAO planTarifarioDAO = new PlanTarifarioDAO();
	
	private final Logger logger = Logger.getLogger(PlanTarifarioDAO.class);
	private Global global = Global.getInstance();
	
	/**
	 * Obtiene todos los atributos del Plan Tarifario. No se define atributos 
	 * debido a que el BO solo procesa y los datos
	 * se retornan a traves de un DTO. 
	 * 
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PlanTarifarioDTO getPlanTarifario(PlanTarifarioDTO entrada) throws ProductOfferingException{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		logger.debug("Inicio:getPlanTarifario()");
		resultado = planTarifarioDAO.getPlanTarifario(entrada);
		logger.debug("Fin:getPlanTarifario()");
		return resultado;
	}
	
	/**
	 * Busca Valores asociados al Cargo Basico del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PrecioCargoDTO[] getCargoBasico(PlanTarifarioDTO entrada) throws ProductOfferingException{
		PrecioCargoDTO[] resultado = null;
		logger.debug("Inicio:getCargoBasico()");
		resultado = planTarifarioDAO.getCargoBasico(entrada);
		logger.debug("Fin:getCargoBasico()");
		return resultado;
	}//fin getCargoBasico
	
	/**
	 * Busca Descuentos asociados al Cargo Basico del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public DescuentoDTO[] getDescuentoCargoBasico(ParametrosDescuentoDTO entrada) throws ProductOfferingException{
		DescuentoDTO[] resultado = null;
		logger.debug("Inicio:getDescuentoCargoBasico()");
		if (entrada.getClaseDescuento().equals(entrada.getClaseDescuento()))
			resultado = planTarifarioDAO.getDescuentoCargoBasicoArticulo(entrada);
		else
			resultado = planTarifarioDAO.getDescuentoCargoBasicoConcepto(entrada);
		logger.debug("Fin:getDescuentoCargoBasico()");
		return resultado;
	}//fin getDescuentoCargoBasico
	
	/**
	 * Busca la categoria del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PlanTarifarioDTO getCategoriaPlanTarifario(PlanTarifarioDTO entrada) throws ProductOfferingException{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		logger.debug("Inicio:getCategoriaPlanTarifario()");
		resultado = planTarifarioDAO.getCategoriaPlanTarifario(entrada);
		logger.debug("Fin:getCategoriaPlanTarifario()");
		return resultado;
	}//fin getCategoriaPlanTarifario
	
	/**
	 * Busca el tipo del Plan Tarifario
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public PlanTarifarioDTO getTipoPlanTarifario(PlanTarifarioDTO entrada) throws ProductOfferingException{
		PlanTarifarioDTO resultado = new PlanTarifarioDTO();
		logger.debug("Inicio:getTipoPlanTarifario()");
		resultado = planTarifarioDAO.getCategoriaPlanTarifario(entrada);
		logger.debug("Fin:getTipoPlanTarifario()");
		return resultado;
	}//fin getTipoPlanTarifario
	
	/**
	 * Obtiene Codigo Concepto Facturable del descuento manual 
	 * @param entrada
	 * @return resultado
	 * @throws ProductOfferingException
	 */
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductOfferingException{
		logger.debug("Inicio:getCodigoDescuentoManual()");
		DescuentoDTO resultado = planTarifarioDAO.getCodigoDescuentoManual(entrada);
		logger.debug("Fin:getCodigoDescuentoManual()");
		return resultado;
	}//fin getCodigoDescuentoManual
	
}//fin PlanTarifario
	
