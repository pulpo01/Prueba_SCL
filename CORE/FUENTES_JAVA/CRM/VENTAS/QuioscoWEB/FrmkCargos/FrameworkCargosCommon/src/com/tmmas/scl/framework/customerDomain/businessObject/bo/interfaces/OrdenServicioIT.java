package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;

public interface OrdenServicioIT {
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException;
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException;
	
}
