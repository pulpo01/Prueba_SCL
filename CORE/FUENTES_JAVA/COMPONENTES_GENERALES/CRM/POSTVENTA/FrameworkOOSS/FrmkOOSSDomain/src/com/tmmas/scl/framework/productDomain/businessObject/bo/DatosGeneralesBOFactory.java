package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.DatosGeneralesBOIT;


public class DatosGeneralesBOFactory implements DatosGeneralesBOFactoryIT{

	public DatosGeneralesBOIT getBusinessObject1() {
		return new DatosGenerales();
	}


}
