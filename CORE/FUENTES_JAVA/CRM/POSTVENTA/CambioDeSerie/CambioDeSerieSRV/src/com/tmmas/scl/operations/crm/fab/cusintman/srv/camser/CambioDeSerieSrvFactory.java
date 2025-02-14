package com.tmmas.scl.operations.crm.fab.cusintman.srv.camser;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces.CambioDeSerieSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camser.interfaces.CambioDeSerieSrvIF;

public class CambioDeSerieSrvFactory implements CambioDeSerieSrvFactoryIF {

	public CambioDeSerieSrvIF getApplicationService1() {
		return new CambioDeSerieSrv();
	}

}
