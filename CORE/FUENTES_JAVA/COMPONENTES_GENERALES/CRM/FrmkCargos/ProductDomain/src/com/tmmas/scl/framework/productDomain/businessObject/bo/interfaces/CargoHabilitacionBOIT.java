package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosCargoHabilitacionDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;



public interface CargoHabilitacionBOIT {
	
	public PrecioCargoDTO[] getCargoHabilitacion(ParametrosCargoHabilitacionDTO entrada) throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	
}
