package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoVetadoBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoVetadoBOIT;


public class AbonadoVetadoBOFactory implements AbonadoVetadoBOFactoryIT{

	public AbonadoVetadoBOIT getBusinessObject1() {
		return new AbonadoVetadoBO();
	}


}
