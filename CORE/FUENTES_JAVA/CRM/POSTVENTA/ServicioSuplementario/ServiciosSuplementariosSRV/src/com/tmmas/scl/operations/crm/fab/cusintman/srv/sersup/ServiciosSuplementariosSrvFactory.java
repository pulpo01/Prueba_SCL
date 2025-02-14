package com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.interfaces.ServiciosSuplementariosSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.sersup.interfaces.ServiciosSuplementariosSrvIF;

public class ServiciosSuplementariosSrvFactory implements ServiciosSuplementariosSrvFactoryIF {

	public ServiciosSuplementariosSrvIF getApplicationService1() {
		return new ServiciosSuplementariosSrv();
	}

}
