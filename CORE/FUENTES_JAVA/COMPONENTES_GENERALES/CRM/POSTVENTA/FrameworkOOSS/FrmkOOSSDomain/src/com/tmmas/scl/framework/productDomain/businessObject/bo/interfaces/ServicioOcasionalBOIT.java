package com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesPVDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;


public interface ServicioOcasionalBOIT {
	
	
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada) throws ProductException;
	
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesPVDTO entrada) throws ProductException;
		
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargo(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public boolean existeCodigoConceptoArticulo(ArticuloDTO articuloDTO)throws ProductException;
	
	
}
