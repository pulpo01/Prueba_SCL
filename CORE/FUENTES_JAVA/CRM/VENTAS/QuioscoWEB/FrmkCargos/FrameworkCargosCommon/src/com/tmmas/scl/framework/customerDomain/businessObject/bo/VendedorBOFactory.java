package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.VendedorIT;

public class VendedorBOFactory implements VendedorBOFactoryIT{

	public VendedorIT getBusinessObject1() {
		return new Vendedor();
	}
	
	
}
