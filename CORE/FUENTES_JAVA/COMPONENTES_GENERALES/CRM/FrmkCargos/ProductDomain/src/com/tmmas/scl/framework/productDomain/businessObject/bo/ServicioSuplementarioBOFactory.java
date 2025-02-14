package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioSuplementarioBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ServicioSuplementarioBOIT;

public class ServicioSuplementarioBOFactory implements ServicioSuplementarioBOFactoryIT{
	
	public ServicioSuplementarioBOIT getBusinessObject1(){
		return new ServicioSuplementarioBO();
	}
}
