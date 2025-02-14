package com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord;

import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces.GestionOrdenServicioSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.clocusord.srv.ord.interfaces.GestionOrdenServicioSrvIF;

public class GestionOrdenServicioSrvFactory implements
		GestionOrdenServicioSrvFactoryIF {

	public GestionOrdenServicioSrvIF getApplicationService1() {
		return new GestionOrdenServicioSrv();
	}

}
