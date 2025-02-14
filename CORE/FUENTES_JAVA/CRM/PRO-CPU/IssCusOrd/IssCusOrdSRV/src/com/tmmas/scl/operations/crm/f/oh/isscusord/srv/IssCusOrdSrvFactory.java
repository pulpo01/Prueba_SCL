package com.tmmas.scl.operations.crm.f.oh.isscusord.srv;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces.IssCusOrdSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.interfaces.IssCusOrdSrvIF;

public class IssCusOrdSrvFactory implements IssCusOrdSrvFactoryIF {

	public IssCusOrdSrvIF getApplicationService1() {
		return new IssCusOrdSrv();
	}

}
