package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioOcasionalBOIT;

public class ServicioOcasionalBOFactory implements ServicioOcasionalBOFactoryIT{
	
	public ServicioOcasionalBOIT getBusinessObject1(){
		return new ServicioOcasionalBO();
	}
}
