package com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via;

import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces.GestionViabilidadSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.via.interfaces.GestionViabilidadSrvIF;

public class GestionViabilidadSrvFactory implements
		GestionViabilidadSrvFactoryIF {

	public GestionViabilidadSrvIF getApplicationService1() {
		return new GestionViabilidadSrv();
	}

}
