package com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord;

import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces.GestionApoyoOrdenServicioSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.supordhan.srv.ord.interfaces.GestionApoyoOrdenServicioSrvIF;

public class GestionApoyoOrdenServicioSrvFactory implements
		GestionApoyoOrdenServicioSrvFactoryIF {

	public GestionApoyoOrdenServicioSrvIF getApplicationService1() {
		return new GestionApoyoOrdenServicioSrv();
	}

}
