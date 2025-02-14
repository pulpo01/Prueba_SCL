package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;


import com.tmmas.scl.framework.customerDomain.dataTransferObject.TipoComisionistaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;

public interface ServiciosVentaBOIT {
	public TipoComisionistaDTO ObtieneComisPorVendedor(VendedorDTO vendedorDTO) throws CustomerBillException;
}
