package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public interface SCLPlanDescuentoIT {

	public RetornoDTO crearSolicitud(RegistroSolicitudDTO registro) throws ProductOfferingPriceException;
	
	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws ProductOfferingPriceException;
	
	public RetornoDTO eliminarSolicitudDescuento(RegistroSolicitudDTO registro) throws ProductOfferingPriceException;
}
