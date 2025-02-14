package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.DatosGeneralesBOIT;



public class DatosGeneralesBOFactory implements DatosGeneralesBOFactoryIT{

	public DatosGeneralesBOIT getBusinessObject1() {
		return new DatosGeneralesBO();
	}
}
