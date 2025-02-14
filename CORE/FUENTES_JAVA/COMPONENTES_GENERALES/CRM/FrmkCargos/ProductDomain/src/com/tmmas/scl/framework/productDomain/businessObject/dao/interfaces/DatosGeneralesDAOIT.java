package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface DatosGeneralesDAOIT {
	
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales) throws ProductException;
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales) throws ProductException;

}
