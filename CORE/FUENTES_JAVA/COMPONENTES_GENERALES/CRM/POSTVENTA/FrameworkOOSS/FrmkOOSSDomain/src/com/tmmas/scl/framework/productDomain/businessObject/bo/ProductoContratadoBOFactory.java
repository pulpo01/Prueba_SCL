package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoContratadoBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.ProductoContratadoIT;

public class ProductoContratadoBOFactory implements
		ProductoContratadoBOFactoryIT {

	public ProductoContratadoIT getBusinessObject1() {
		return new ProductoContratado();
	}

}
