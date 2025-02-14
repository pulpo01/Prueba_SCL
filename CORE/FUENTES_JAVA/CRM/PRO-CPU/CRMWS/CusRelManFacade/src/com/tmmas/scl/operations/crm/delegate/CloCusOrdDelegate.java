package com.tmmas.scl.operations.crm.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistrarOossEnLineaDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RegistroNivelOOSSDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.clocusord.common.exception.CloCusOrdException;

public class CloCusOrdDelegate {
	private final Logger logger = Logger.getLogger(CloCusOrdDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();

//	---------------------------------------------------------------------------------------------------------------	
	public CloCusOrdDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
//	---------------------------------------------------------------------------------------------------------------	
	public RetornoDTO registraNivelOoss(RegistroNivelOOSSDTO param) throws CloCusOrdException{
		RetornoDTO retorno = null;
		logger.debug("registraNivelOoss():start");
		try {
			logger.debug("getCloCusOrdFacade().registraNivelOoss():antes");
			retorno=this.facadeMaker.getCloCusOrdFacade().registraNivelOoss(param);
			logger.debug("getCloCusOrdFacade().registraNivelOoss():despues");
		}catch(CloCusOrdException e){
			throw e;
		}
		catch(Exception e){
			throw new CloCusOrdException(e);
		}
		logger.debug("registraNivelOoss():end");
		return retorno;		
	}	

//	---------------------------------------------------------------------------------------------------------------	
	public RetornoDTO registrarOOSSEnLinea(RegistrarOossEnLineaDTO param) throws CloCusOrdException{
		RetornoDTO retorno = null;
		logger.debug("registrarOOSSEnLinea():start");
		try {
			logger.debug("getCloCusOrdFacade().registrarOOSSEnLinea():antes");
			retorno=this.facadeMaker.getCloCusOrdFacade().registrarOOSSEnLinea(param);
			logger.debug("getCloCusOrdFacade().registrarOOSSEnLinea():despues");
		}catch(CloCusOrdException e){
			throw e;
		}catch(Exception e){
			throw new CloCusOrdException(e);
		}
		logger.debug("registrarOOSSEnLinea():end");
		return retorno;		
	}
	
}
