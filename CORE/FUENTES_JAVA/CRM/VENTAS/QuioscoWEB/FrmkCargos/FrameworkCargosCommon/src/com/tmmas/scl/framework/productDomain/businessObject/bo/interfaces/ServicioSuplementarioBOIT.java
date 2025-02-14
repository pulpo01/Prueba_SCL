package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ServicioSuplementarioDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;



public interface ServicioSuplementarioBOIT {
	
	//public void creaSSAbonado(ServicioSuplementarioDTO entrada)throws ProductException;
	
	public PrecioCargoDTO[] getCargoServSupl(ServicioSuplementarioDTO entrada) throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public ServicioSuplementarioDTO[] getSSAbonado(ServicioSuplementarioDTO entrada)throws ProductException;
	
}
