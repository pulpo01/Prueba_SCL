package com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public interface ArticuloFCDAOIT {
	
	public ArticuloDTO getArticulo(ArticuloDTO entrada) throws CustomerBillException;
}
