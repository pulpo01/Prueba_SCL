package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ParametrosGeneralesIT;

public class ParametrosGeneralesBOFactory implements ParametrosGeneralesBOFactoryIT{
	
	public ParametrosGeneralesIT getBusinessObject1(){
		return new ParametrosGenerales();
	}
}
