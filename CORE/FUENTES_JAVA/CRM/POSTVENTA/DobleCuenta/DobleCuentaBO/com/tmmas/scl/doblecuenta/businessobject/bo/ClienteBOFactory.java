package com.tmmas.scl.doblecuenta.businessobject.bo;

import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.ClienteBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.ClienteBOIT;

public class ClienteBOFactory implements ClienteBOFactoryIT{

	public ClienteBOIT getBusinessObject1() {
		return new ClienteBO();
	}
}
