package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SegmentacionBOIT;

public class SegmentacionBOFactory implements SegmentacionBOFactoryIT{

	public SegmentacionBOIT getBusinessObject1() {
		return new SegmentacionBO();
	}

}
