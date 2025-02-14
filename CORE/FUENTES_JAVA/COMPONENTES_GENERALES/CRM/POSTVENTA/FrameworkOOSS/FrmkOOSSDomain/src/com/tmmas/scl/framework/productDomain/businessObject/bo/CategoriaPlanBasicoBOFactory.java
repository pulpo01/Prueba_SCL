package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CategoriaPlanBasicoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.CategoriaPlanBasicoIT;

public class CategoriaPlanBasicoBOFactory implements CategoriaPlanBasicoBOFactoryIT {

	public CategoriaPlanBasicoIT getBusinessObject1() {
		return new CategoriaPlanBasico();
	}

}
