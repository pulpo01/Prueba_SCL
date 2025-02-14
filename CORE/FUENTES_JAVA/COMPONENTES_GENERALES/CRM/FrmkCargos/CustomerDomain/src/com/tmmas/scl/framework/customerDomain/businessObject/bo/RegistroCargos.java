package com.tmmas.scl.framework.customerDomain.businessObject.bo;


import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroCargosIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.RegistroCargosDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;


public class RegistroCargos implements RegistroCargosIT {

	private RegistroCargosDAO registroCargosDAO  = new RegistroCargosDAO();
	private final Logger logger = Logger.getLogger(RegistroCargos.class);
	private Global global = Global.getInstance();
	
	/**
	 * Registra Cargo 
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	public void registraCargo(RegistroCargosDTO cargo) throws CustomerBillException {
		logger.debug("registraCargo():start");
		registroCargosDAO.registraCargo(cargo);
		logger.debug("registraCargo():end");
	}
	
	/**
	 * Obtiene Secuencia del Cargo
	 * @param cargo
	 * @return 
	 * @throws CustomerDomainException
	 */
	public RegistroCargosDTO getSecuenciaCargo(RegistroCargosDTO entrada)throws CustomerBillException{
		RegistroCargosDTO resultado = new RegistroCargosDTO();
		logger.debug("Inicio:getSecuenciaCargo()");
		resultado = registroCargosDAO.getSecuenciaCargo(entrada);
		logger.debug("Fin:getSecuenciaCargo()");
		return resultado;
	}

}
