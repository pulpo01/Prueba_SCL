package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionesValidacionesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionesValidacionesIT;

public class RestriccionesValidacionesBOFactory implements
		RestriccionesValidacionesBOFactoryIT {

	public RestriccionesValidacionesIT getBusinessObject1() {
		return new RestriccionesValidaciones();
	}

}
