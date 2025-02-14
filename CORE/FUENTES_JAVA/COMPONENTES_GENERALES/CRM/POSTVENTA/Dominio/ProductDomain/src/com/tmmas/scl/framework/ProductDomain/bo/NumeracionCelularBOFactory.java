package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.NumeracionCelularBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.NumeracionCelularBOIT;

public class NumeracionCelularBOFactory implements NumeracionCelularBOFactoryIT{

	public NumeracionCelularBOIT getBusinessObject1() {
		return new NumeracionCelularBO();
	}
}

