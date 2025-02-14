package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public interface ParametrosGeneralesIT {
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 
	throws ProductOfferingException;
	
	public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) throws ProductOfferingException;

}
