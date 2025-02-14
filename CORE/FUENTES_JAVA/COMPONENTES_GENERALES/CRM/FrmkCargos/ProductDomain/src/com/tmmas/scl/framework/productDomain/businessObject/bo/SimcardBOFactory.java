package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SimcardBOIT;



public class SimcardBOFactory implements SimcardBOFactoryIT {
	
	public SimcardBOIT getBusinessObject1(){
		return new SimcardBO();
	}
}
