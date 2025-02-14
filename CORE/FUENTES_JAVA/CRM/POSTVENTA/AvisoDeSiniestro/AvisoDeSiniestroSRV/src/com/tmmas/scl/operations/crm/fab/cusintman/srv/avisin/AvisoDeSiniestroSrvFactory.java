package com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.interfaces.AvisoDeSiniestroFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.avisin.interfaces.AvisoDeSiniestroSrvIF;

public class AvisoDeSiniestroSrvFactory implements AvisoDeSiniestroFactoryIF {

	public AvisoDeSiniestroSrvIF getApplicationService1() {
		return new AvisoDeSiniestroSrv();
	}

}
