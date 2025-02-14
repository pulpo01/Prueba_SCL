package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;

public interface ArticuloFCBOIT {
	public ArticuloDTO getArticulo(ArticuloDTO entrada)	throws CustomerBillException;
}
