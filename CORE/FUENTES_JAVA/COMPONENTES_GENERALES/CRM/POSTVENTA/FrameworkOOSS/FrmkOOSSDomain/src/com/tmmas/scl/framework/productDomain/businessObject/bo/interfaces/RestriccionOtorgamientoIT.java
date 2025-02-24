package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public interface RestriccionOtorgamientoIT {
	
	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restriccion) throws ProductSpecificationException;
	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(ProductoOfertadoDTO producto) throws ProductSpecificationException;
}
