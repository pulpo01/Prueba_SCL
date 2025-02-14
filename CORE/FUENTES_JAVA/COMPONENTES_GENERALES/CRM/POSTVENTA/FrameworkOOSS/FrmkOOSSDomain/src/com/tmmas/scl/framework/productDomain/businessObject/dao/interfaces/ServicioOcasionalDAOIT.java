package com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.ArticuloDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.DescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametrosDescuentoDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.PrecioCargoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ParametrosCargoServOcacionalesPVDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductException;

public interface ServicioOcasionalDAOIT {
	
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesDTO entrada)throws ProductException;
	
	public PrecioCargoDTO[] getCargoServOcac(ParametrosCargoServOcacionalesPVDTO entrada)throws ProductException;
	
	public DescuentoDTO getCodigoDescuentoManual(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public DescuentoDTO[] getDescuentoCargoArticulo(ParametrosDescuentoDTO entrada) throws ProductException;

	public DescuentoDTO[] getDescuentoCargoConcepto(ParametrosDescuentoDTO entrada) throws ProductException;
	
	public boolean existeCodConcepArticulo(ArticuloDTO entrada) throws ProductException;
}
