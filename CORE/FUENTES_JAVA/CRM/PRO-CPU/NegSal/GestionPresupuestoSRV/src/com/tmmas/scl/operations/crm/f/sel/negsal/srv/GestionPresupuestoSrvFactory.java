package com.tmmas.scl.operations.crm.f.sel.negsal.srv;

import com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.sel.negsal.interfaces.GestionPresupuestoSrvIF;

public class GestionPresupuestoSrvFactory implements
		GestionPresupuestoSrvFactoryIF {

	public GestionPresupuestoSrvIF getApplicationService1() {
		return new GestionPresupuestoSrv();
	}

}
