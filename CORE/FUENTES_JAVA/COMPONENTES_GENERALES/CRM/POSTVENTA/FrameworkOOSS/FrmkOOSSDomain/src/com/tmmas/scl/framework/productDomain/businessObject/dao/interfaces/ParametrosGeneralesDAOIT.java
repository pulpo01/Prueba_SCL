package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductOfferingException;

public interface ParametrosGeneralesDAOIT {
	
	public ParametrosGeneralesDTO getParametroGeneral(ParametrosGeneralesDTO parametrogeneral) 
	throws ProductOfferingException;
	
	public ParametrosGeneralesDTO getParametroFacturacion(ParametrosGeneralesDTO parametrogeneral) throws ProductOfferingException;
	
	public ParametrosGeneralesDTO getParametroGrupoTecnologico(ParametrosGeneralesDTO parametroGeneral) 
	throws ProductOfferingException;
}
