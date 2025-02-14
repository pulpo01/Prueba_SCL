package com.tmmas.scl.framework.ProductDomain.bo;

import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOFactoryIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOIT;
import com.tmmas.scl.framework.ProductDomain.bo.interfaces.SuspensionVoluntariaBOIT;

public class SuspensionVoluntariaBOFactory implements SuspensionVoluntariaBOFactoryIT{

	public SuspensionVoluntariaBOIT getBusinessObject1() {
		return new SuspensionVoluntariaBO();
	}
}

