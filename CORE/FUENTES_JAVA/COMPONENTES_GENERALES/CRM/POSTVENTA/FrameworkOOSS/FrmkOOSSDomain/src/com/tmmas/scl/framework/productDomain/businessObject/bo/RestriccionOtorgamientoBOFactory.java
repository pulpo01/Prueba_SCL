package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionOtorgamientoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionOtorgamientoIT;

public class RestriccionOtorgamientoBOFactory implements
	RestriccionOtorgamientoBOFactoryIT {

	public RestriccionOtorgamientoIT getBusinessObject1() {
		return new RestriccionOtorgamiento();
	}

}
