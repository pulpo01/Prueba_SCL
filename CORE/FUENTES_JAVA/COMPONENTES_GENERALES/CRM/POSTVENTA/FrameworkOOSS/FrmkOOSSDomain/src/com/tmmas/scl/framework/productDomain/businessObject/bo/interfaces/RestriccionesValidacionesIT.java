package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public interface RestriccionesValidacionesIT {
	
	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param) throws ProductSpecificationException;
}
