package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.productDomain.dataTransferObject.DatosGeneralesDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface DatosGeneralesBOIT {

	public DatosGeneralesDTO getActuacionCentral(DatosGeneralesDTO datosGenerales)	throws ProductException;
	
	public DatosGeneralesDTO[] getListCodigos(DatosGeneralesDTO entrada) throws ProductException;
	
	public DatosGeneralesDTO getProducto(DatosGeneralesDTO entrada)	throws ProductException;
	
	public DatosGeneralesDTO getResultadoTransaccion(DatosGeneralesDTO datosGenerales)throws ProductException;
	
	public DatosGeneralesDTO getSecuencia(DatosGeneralesDTO datosGenerales)	throws ProductException;
	
	public DatosGeneralesDTO getValorParametro(DatosGeneralesDTO datosGenerales)throws ProductException;
	
}
