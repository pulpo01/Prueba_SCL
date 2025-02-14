package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroCargosDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public interface RegistroCargosDAOIT {

	public void registraCargo(RegistroCargosDTO cargo) throws CustomerBillException;
	
	public RegistroCargosDTO getSecuenciaCargo(RegistroCargosDTO entrada) throws CustomerBillException;

}
