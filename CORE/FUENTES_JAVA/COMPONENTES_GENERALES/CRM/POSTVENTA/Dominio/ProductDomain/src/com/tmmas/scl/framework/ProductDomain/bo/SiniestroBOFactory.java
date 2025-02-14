package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SiniestroBOIT;

public class SiniestroBOFactory implements SiniestroBOFactoryIT{

	public SiniestroBOIT getBusinessObject1() {
		return new SiniestroBO();
	}
}