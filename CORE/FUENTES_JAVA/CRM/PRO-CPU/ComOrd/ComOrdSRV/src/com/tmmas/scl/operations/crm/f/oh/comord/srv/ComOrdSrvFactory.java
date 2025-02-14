package com.tmmas.scl.operations.crm.f.oh.comord.srv;

import com.tmmas.scl.operations.crm.f.oh.comord.srv.interfaces.ComOrdSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.comord.srv.interfaces.ComOrdSrvIF;

public class ComOrdSrvFactory implements ComOrdSrvFactoryIF {

	/**
	 * Application Service Factory Class
	 */
	public ComOrdSrvIF getApplicationService1() {
		return new ComOrdSrv();
	}

}
