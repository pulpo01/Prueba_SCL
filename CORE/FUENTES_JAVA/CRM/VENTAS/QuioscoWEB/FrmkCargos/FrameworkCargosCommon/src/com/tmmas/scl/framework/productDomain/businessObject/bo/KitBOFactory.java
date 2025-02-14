package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.KitBOIT;

public class KitBOFactory implements KitBOFactoryIT{
	
	public KitBOIT getBusinessObject1(){
		return new KitBO();
	}
}
