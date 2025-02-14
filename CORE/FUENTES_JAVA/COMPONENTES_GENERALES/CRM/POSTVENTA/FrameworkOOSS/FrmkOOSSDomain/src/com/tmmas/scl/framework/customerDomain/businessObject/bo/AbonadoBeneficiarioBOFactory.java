package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoBeneficiarioBOFactoryIT;
import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.AbonadoBeneficiarioBOIT;

public class AbonadoBeneficiarioBOFactory implements AbonadoBeneficiarioBOFactoryIT{

	public AbonadoBeneficiarioBOIT getBusinessObject1() {
		return new AbonadoBeneficiarioBO();
	}


}
