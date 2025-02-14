package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.IntegracionSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.IntegracionSrvIF;

public class IntegracionSrvFactory implements IntegracionSrvFactoryIF {

	public IntegracionSrvIF getApplicationService1() {
		return new IntegracionSrv();
	}

}
