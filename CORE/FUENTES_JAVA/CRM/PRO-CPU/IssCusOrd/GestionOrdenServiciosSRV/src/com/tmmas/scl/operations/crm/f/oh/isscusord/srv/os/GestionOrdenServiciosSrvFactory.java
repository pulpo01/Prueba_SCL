package com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os;

import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.GestionOrdenServiciosSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.isscusord.srv.os.interfaces.GestionOrdenServiciosSrvIF;

public class GestionOrdenServiciosSrvFactory implements GestionOrdenServiciosSrvFactoryIF {

	public GestionOrdenServiciosSrvIF getApplicationService1() {
		return new GestionOrdenServiciosSrv();
	}

}
