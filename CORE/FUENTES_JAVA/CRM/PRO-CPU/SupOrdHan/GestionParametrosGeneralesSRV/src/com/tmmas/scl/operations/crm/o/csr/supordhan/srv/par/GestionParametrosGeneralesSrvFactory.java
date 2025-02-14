package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par;

import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces.GestionParametrosGeneralesSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.par.interfaces.GestionParametrosGeneralesSrvIF;

public class GestionParametrosGeneralesSrvFactory implements
		GestionParametrosGeneralesSrvFactoryIF {

	public GestionParametrosGeneralesSrvIF getApplicationService1() {
		return new GestionParametrosGeneralesSrv();
	}

}
