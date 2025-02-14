package com.tmmas.scl.doblecuenta.businessobject.bo;

import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.FacturaBOFactoryIT;
import com.tmmas.scl.doblecuenta.businessobject.bo.interfaces.FacturaBOIT;

public class FacturaBOFactory implements FacturaBOFactoryIT{

	public FacturaBOIT getBusinessObject1() {
		return new FacturaBO();
	}
}
