package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanBasicoIT;

public class SCLPlanBasicoBOFactory implements SCLPlanBasicoBOFactoryIT {

	public SCLPlanBasicoIT getBusinessObject1() {
		return new SCLPlanBasico();
	}

}
