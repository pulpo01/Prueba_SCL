package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RegistroFacturacionIT;

public class RegistroFacturacionBOFactory implements RegistroFacturacionBOFactoryIT{
	
	public RegistroFacturacionIT getBusinessObject1(){
		return new RegistroFacturacion();
	}
}
