package com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta;

import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces.GestionCuentaSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvcta.interfaces.GestionCuentaSrvIF;

public class GestionCuentaSrvFactory implements GestionCuentaSrvFactoryIF {

	public GestionCuentaSrvIF getApplicationService1() {
		return new GestionCuentaSrv();
	}

}
