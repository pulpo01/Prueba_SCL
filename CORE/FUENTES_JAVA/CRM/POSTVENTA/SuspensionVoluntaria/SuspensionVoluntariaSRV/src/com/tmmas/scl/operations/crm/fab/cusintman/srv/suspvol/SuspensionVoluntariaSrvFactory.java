package com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol;

import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces.SuspensionVoluntariaSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cusintman.srv.suspvol.interfaces.SuspensionVoluntariaSrvIF;

public class SuspensionVoluntariaSrvFactory implements SuspensionVoluntariaSrvFactoryIF {

	public SuspensionVoluntariaSrvIF getApplicationService1() {
		return new SuspensionVoluntariaSRV();
	}

}
