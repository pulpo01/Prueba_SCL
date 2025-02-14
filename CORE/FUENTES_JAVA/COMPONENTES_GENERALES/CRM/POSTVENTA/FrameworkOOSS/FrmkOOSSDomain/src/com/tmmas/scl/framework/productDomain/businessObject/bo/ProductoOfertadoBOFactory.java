package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoOfertadoIT;

public class ProductoOfertadoBOFactory implements ProductoOfertadoBOFactoryIT {

	public ProductoOfertadoIT getBusinessObject1() {
		return new ProductoOfertado();
	}

}
