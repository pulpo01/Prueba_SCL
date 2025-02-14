package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.AbonadoIT;

public class AbonadoBOFactory implements AbonadoBOFactoryIT {

	public AbonadoIT getBusinessObject1() {
		return new Abonado();
	}

}
