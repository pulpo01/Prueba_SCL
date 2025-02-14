package com.tmmas.scl.operations.crm.o.csr.supcusintman.srv;

import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces.GestionValidacionesSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.srv.interfaces.GestionValidacionesSrvIF;

public class GestionValidacionesSrvFactory implements
		GestionValidacionesSrvFactoryIF {

	public GestionValidacionesSrvIF getApplicationService1() {
		return new GestionValidacionesSrv();
	}

}
