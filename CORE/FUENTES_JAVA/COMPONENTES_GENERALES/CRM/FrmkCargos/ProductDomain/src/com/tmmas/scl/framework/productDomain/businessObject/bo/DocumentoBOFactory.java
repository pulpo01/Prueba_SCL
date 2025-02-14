package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DocumentoBOIT;


public class DocumentoBOFactory implements DocumentoBOFactoryIT {
	
	public DocumentoBOIT getBusinessObject1(){
		return new Documento();
	}
}
