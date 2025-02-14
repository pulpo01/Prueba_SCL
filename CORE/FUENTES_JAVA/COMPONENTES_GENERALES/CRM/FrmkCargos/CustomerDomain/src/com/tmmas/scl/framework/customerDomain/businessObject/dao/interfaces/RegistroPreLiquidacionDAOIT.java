package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;


import com.tmmas.scl.framework.customerDomain.dataTransferObject.RegistroPreliquidacionDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public interface RegistroPreLiquidacionDAOIT {

	public void actualizaMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException;
	
	public void registraMaestroPreliquidacion(RegistroPreliquidacionDTO preliquidacion)throws CustomerBillException;
}
