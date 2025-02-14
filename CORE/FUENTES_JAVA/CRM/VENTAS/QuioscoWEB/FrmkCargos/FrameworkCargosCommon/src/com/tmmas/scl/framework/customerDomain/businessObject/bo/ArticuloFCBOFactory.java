package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ArticuloFCBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ArticuloFCBOIT;

public class ArticuloFCBOFactory implements ArticuloFCBOFactoryIT{

	public ArticuloFCBOIT getBusinessObject1() {
		 return new ArticuloFCBO();
	}

}
