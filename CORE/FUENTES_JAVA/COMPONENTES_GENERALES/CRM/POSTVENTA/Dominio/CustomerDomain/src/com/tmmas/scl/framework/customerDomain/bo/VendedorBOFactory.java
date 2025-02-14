package com.tmmas.scl.framework.customerDomain.bo;

import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.VendedorBOIT;

public class VendedorBOFactory implements VendedorBOFactoryIT{

	public VendedorBOIT getBusinessObject1() {
		return new VendedorBO();
	}
}
