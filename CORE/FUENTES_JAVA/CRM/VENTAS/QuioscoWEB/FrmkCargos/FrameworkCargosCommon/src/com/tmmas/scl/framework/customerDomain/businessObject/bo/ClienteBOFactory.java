package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ClienteIT;

public class ClienteBOFactory implements ClienteBOFactoryIT {

	/**
	 * Business Object Factory Class
	 */	
	public ClienteIT getBusinessObject1() {
		return new Cliente();
	}
}
