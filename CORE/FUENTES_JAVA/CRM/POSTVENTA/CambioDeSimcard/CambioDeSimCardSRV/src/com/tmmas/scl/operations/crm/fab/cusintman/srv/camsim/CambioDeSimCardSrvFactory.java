package com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim.interfaces.CambioDeSimCardSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.camsim.interfaces.CambioDeSimCardSrvIF;

public class CambioDeSimCardSrvFactory implements CambioDeSimCardSrvFactoryIF {

	public CambioDeSimCardSrvIF getApplicationService1() {
		return new CambioDeSimCardSrv();
	}

}
