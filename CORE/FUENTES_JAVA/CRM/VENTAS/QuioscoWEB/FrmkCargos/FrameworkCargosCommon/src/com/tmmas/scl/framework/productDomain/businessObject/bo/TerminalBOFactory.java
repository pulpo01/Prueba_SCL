package com.tmmas.scl.framework.productDomain.businessObject.bo;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOFactoryIT;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.TerminalBOIT;



public class TerminalBOFactory implements TerminalBOFactoryIT {
	
	public TerminalBOIT getBusinessObject1(){
		return new TerminalBO();
	}
}
