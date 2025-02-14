package com.tmmas.scl.operations.crm.f.oh.comord.srvord;

import com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces.GestionComplementoOrdenSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.comord.srvord.interfaces.GestionComplementoOrdenSrvIF;

public class GestionComplementoOrdenSrvFactory implements GestionComplementoOrdenSrvFactoryIF {

	public GestionComplementoOrdenSrvIF getApplicationService1() {
		return new GestionComplementoOrdenSrv();
	}

}
