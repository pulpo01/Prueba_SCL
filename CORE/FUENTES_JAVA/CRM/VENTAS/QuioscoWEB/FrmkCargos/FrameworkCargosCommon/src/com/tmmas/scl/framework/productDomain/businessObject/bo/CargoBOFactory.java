package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CargoIT;

public class CargoBOFactory implements CargoBOFactoryIT {

	public CargoIT getBusinessObject1() {
		return new Cargo();
	}

}
