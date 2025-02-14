package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CuentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CuentaIT;

public class CuentaBOFactory implements CuentaBOFactoryIT {

	/**
	 * Business Object Factory Class
	 */	
	public CuentaIT getBusinessObject1() {
		return new Cuenta();
	}
}
