package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;

public interface OrdenServicioDAOIT {
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException;
	

}
