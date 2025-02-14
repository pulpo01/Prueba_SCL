package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroEvaluacionRiesgoBOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroEvaluacionRiesgoDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.RegistroEvaluacionRiesgoDAOIT;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosValidacionVentasDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroEvaluacionRiesgoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ResultadoValidacionVentaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;



public class RegistroEvaluacionRiesgoBO implements RegistroEvaluacionRiesgoBOIT {
	
	private RegistroEvaluacionRiesgoDAOIT registroEvaluacionRiesgoDAO  = new RegistroEvaluacionRiesgoDAO();
	private final Logger logger = Logger.getLogger(RegistroEvaluacionRiesgoBO.class);

	
	public void actualizaTerminalesVendidos(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) throws CustomerBillException {
		
		logger.debug("Inicio:actualizaTerminalesVendidos()");
		registroEvaluacionRiesgoDAO.actualizaTerminalesVendidos(registroEvaluacionRiesgoDTO); 
		logger.debug("Fin:actualizaTerminalesVendidos()");
	}

	public ResultadoValidacionVentaDTO existeEvalRiesgoPlanTarif(ParametrosValidacionVentasDTO parametroEvaluacion) throws CustomerBillException {
		ResultadoValidacionVentaDTO retValue=null;
		logger.debug("Inicio:existeEvalRiesgoPlanTarif()");
		retValue=registroEvaluacionRiesgoDAO.existeEvalRiesgoPlanTarif(parametroEvaluacion); 
		logger.debug("Fin:existeEvalRiesgoPlanTarif()");
		return retValue;
	}

	public ResultadoValidacionVentaDTO existeEvaluacionRiesgo(ParametrosValidacionVentasDTO parametroEvaluacion) throws CustomerBillException {
		ResultadoValidacionVentaDTO retValue=null;
		logger.debug("Inicio:existeEvaluacionRiesgo()");
		retValue=registroEvaluacionRiesgoDAO.existeEvaluacionRiesgo(parametroEvaluacion); 
		logger.debug("Fin:existeEvaluacionRiesgo()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO getEvalRiesgoPlanTarif(RegistroEvaluacionRiesgoDTO parametroEvaluacion) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO retValue=null;
		logger.debug("Inicio:getEvalRiesgoPlanTarif()");
		retValue=registroEvaluacionRiesgoDAO.getEvalRiesgoPlanTarif(parametroEvaluacion); 
		logger.debug("Fin:getEvalRiesgoPlanTarif()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO parametroEvaluacion) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO retValue=null;
		logger.debug("Inicio:getEvaluacionRiesgo()");
		retValue=registroEvaluacionRiesgoDAO.getEvaluacionRiesgo(parametroEvaluacion); 
		logger.debug("Fin:getEvaluacionRiesgo()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO getEvaluacionRiesgoVigenteCliente(RegistroEvaluacionRiesgoDTO entrada) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO retValue=null;
		logger.debug("Inicio:getEvaluacionRiesgoVigenteCliente()");
		retValue=registroEvaluacionRiesgoDAO.getEvaluacionRiesgoVigenteCliente(entrada); 
		logger.debug("Fin:getEvaluacionRiesgoVigenteCliente()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO getExcepcion(RegistroEvaluacionRiesgoDTO entrada) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO retValue=null;
		logger.debug("Inicio:getExcepcion()");
		retValue=registroEvaluacionRiesgoDAO.getExcepcion(entrada); 
		logger.debug("Fin:getExcepcion()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO[] getListPlanTarifarioAutoriz(RegistroEvaluacionRiesgoDTO entrada) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO[] retValue=null;
		logger.debug("Inicio:getListPlanTarifarioAutoriz()");
		retValue=registroEvaluacionRiesgoDAO.getListPlanTarifarioAutoriz(entrada); 
		logger.debug("Fin:getListPlanTarifarioAutoriz()");
		return retValue;
	}

	public RegistroEvaluacionRiesgoDTO getRegEvaluacionRiesgo(RegistroEvaluacionRiesgoDTO entrada) throws CustomerBillException {
		RegistroEvaluacionRiesgoDTO retValue=null;
		logger.debug("Inicio:getRegEvaluacionRiesgo()");
		retValue=registroEvaluacionRiesgoDAO.getRegEvaluacionRiesgo(entrada); 
		logger.debug("Fin:getRegEvaluacionRiesgo()");
		return retValue;
	}

	public void insSolicitudVenta(RegistroEvaluacionRiesgoDTO registroEvaluacionRiesgoDTO) throws CustomerBillException {
		logger.debug("Inicio:insSolicitudVenta()");
		registroEvaluacionRiesgoDAO.insSolicitudVenta(registroEvaluacionRiesgoDTO); 
		logger.debug("Fin:insSolicitudVenta()");
		
		
	}
	
		
		
}
