package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.PlanTarifarioIT;

public class PlanTarifarioBOFactory implements PlanTarifarioBOFactoryIT{
	
	public PlanTarifarioIT getBusinessObject1(){
		return new PlanTarifario();
	}
	
}
