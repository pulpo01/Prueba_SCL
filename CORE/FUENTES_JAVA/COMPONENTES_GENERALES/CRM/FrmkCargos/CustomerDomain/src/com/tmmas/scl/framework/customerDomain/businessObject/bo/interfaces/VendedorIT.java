package com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces;


import com.tmmas.scl.framework.customerDomain.exception.CustomerBillException;
import com.tmmas.scl.framework.productDomain.dataTransferObject.VendedorDTO;

public interface VendedorIT {
	public VendedorDTO verificaVendedorEsExterno (VendedorDTO vendedor) throws CustomerBillException;
	
	public VendedorDTO getVendedor(VendedorDTO vendedor) throws CustomerBillException ;
}
