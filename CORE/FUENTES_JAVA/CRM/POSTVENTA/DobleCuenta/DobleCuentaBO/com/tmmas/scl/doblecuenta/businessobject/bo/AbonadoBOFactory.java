package com.tmmas.scl.doblecuenta.businessobject.bo;

import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.AbonadoBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.AbonadoBOIT;

public class AbonadoBOFactory implements AbonadoBOFactoryIT{

	public AbonadoBOIT getBusinessObject1() {
		return new AbonadoBO();
	}
}
