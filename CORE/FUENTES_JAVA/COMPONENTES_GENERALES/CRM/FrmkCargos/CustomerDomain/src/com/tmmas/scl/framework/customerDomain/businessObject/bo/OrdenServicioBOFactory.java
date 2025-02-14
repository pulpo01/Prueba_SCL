package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;

public class OrdenServicioBOFactory implements OrdenServicioBOFactoryIT {

	/**
	 * Business Object Factory Class
	 */	
	public OrdenServicioIT getBusinessObject1() {
		return new OrdenServicio();
	}

}
