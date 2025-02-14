package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public interface RestriccionOtorgamientoDAOIT {

	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restricciones) throws ProductSpecificationException;

	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(ProductoOfertadoDTO producto) throws ProductSpecificationException;	
}
