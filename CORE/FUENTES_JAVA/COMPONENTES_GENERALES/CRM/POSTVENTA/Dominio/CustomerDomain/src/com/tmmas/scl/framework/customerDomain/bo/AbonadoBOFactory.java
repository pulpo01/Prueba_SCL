package com.tmmas.scl.framework.customerDomain.bo;

import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.AbonadoIT;

public class AbonadoBOFactory implements AbonadoBOFactoryIT {

	public AbonadoIT getBusinessObject1() {
		return new Abonado();
	}

}
