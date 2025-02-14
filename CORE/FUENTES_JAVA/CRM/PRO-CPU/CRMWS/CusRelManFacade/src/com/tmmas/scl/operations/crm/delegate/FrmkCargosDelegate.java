package com.tmmas.scl.operations.crm.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.commonDoman.exception.FrmkCargosException;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ObtencionCargosDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosObtencionCargosDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegCargosDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ResultadoRegCargosDTO;

public class FrmkCargosDelegate {
	private final Logger logger = Logger.getLogger(FrmkCargosDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();

//	---------------------------------------------------------------------------------------------------------------	
	public FrmkCargosDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
//	---------------------------------------------------------------------------------------------------------------	
	public ObtencionCargosDTO obtenerCargos(ParametrosObtencionCargosDTO param) throws FrmkCargosException{
		ObtencionCargosDTO retorno = null;
		logger.debug("obtenerCargos():start");
		try {
			logger.debug(".getFrmkCargosFacade().obtenerCargos():antes");
			retorno=this.facadeMaker.getFrmkCargosFacade().obtenerCargos(param);
			logger.debug(".getFrmkCargosFacade().obtenerCargos():despues");
		}catch(Exception e){
			throw new FrmkCargosException(e);
		}
		logger.debug("obtenerCargos():end");
		return retorno;		
	}
	
//	---------------------------------------------------------------------------------------------------------------	
	public RegCargosDTO construirRegistroCargos(ObtencionCargosDTO param) throws FrmkCargosException{
		RegCargosDTO retorno = null;
		logger.debug("obtenerCargos():start");
		try {
			logger.debug(".getFrmkCargosFacade().construirRegistroCargos():antes");
			retorno=this.facadeMaker.getFrmkCargosFacade().construirRegistroCargos(param);
			logger.debug(".getFrmkCargosFacade().construirRegistroCargos():despues");
		}catch(Exception e){
			throw new FrmkCargosException(e);
		}
		logger.debug("obtenerCargos():end");
		return retorno;		
	}
	
//	---------------------------------------------------------------------------------------------------------------	
	public ResultadoRegCargosDTO parametrosRegistrarCargos(RegCargosDTO param) throws FrmkCargosException{
		ResultadoRegCargosDTO retorno = null;
		logger.debug("obtenerCargos():start");
		try {
			logger.debug(".getFrmkCargosFacade().parametrosRegistrarCargos():antes");
			retorno=this.facadeMaker.getFrmkCargosFacade().parametrosRegistrarCargos(param);
			logger.debug(".getFrmkCargosFacade().parametrosRegistrarCargos():despues");
		}catch(Exception e){
			throw new FrmkCargosException(e);
		}
		logger.debug("obtenerCargos():end");
		return retorno;		
	}
	
	
	
	
}
