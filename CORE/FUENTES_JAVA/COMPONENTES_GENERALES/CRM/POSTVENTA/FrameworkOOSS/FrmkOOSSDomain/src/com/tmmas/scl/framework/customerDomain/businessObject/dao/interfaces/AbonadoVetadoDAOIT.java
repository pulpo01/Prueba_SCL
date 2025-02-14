package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.exception.CustomerException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.AbonadoVetadoListDTO;

public interface AbonadoVetadoDAOIT {
	
	public AbonadoVetadoListDTO obtieneAbonadosVetados(AbonadoDTO abonadoDTO) throws CustomerException;

}
