package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.as.interfaces.GestionActivacionesSrvIF;

public class GestionActivacionesSrvFactory implements GestionActivacionesSrvFactoryIF {

	public GestionActivacionesSrvIF getApplicationService1() {
		return new GestionActivacionesSrv();
	}

}
