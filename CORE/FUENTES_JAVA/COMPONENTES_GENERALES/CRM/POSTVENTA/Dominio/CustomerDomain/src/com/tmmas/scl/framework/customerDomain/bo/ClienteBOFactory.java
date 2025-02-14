package com.tmmas.scl.framework.customerDomain.bo;

import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.bo.interfaces.ClienteIT;

public class ClienteBOFactory implements ClienteBOFactoryIT {

	/**
	 * Business Object Factory Class
	 */	
	public ClienteIT getBusinessObject1() {
		return new Cliente();
	}
}
