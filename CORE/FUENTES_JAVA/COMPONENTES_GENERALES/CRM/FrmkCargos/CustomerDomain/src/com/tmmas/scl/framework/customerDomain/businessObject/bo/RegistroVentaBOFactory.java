package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.RegistroVentaBOIT;

public class RegistroVentaBOFactory implements RegistroVentaBOFactoryIT{

	public RegistroVentaBOIT getBusinessObject1() {
		return new RegistroVenta();
	}

}
