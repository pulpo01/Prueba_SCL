package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CiclosFacturacionBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.CiclosFacturacionIT;

public class CiclosFacturacionBOFactory implements CiclosFacturacionBOFactoryIT {

	public CiclosFacturacionIT getBusinessObject1() {
		return new CiclosFacturacion();
	}

}
