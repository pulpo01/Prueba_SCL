package com.tmmas.scl.operations.crm.fab.cusintman.srv.anusin;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.anusin.interfaces.AnulacionSiniestroSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.anusin.interfaces.AnulacionSiniestroSrvIF;

public class AnulacionSiniestroSrvFactory implements AnulacionSiniestroSrvFactoryIF {

	public AnulacionSiniestroSrvIF getApplicationService1() {
		return new AnulacionSiniestroSrv();
	}

}
