package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PromocionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PromocionIT;

public class PromocionBOFactory implements PromocionBOFactoryIT {

	public PromocionIT getBusinessObject1() {
		return new Promocion();
	}

}
