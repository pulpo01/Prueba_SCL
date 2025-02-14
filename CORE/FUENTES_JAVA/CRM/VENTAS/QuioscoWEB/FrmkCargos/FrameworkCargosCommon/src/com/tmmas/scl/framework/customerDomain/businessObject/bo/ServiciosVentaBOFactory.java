package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.ServiciosVentaBOIT;


public class ServiciosVentaBOFactory implements ServiciosVentaBOFactoryIT{
	public ServiciosVentaBOIT getBusinessObject1() {
		return new ServiciosVentaBO();
	}
}
