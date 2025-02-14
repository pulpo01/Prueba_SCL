package com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv;

import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.interfaces.DetCusOrdFeaSrvFactoryIF;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.srv.interfaces.DetCusOrdFeaSrvIF;

public class DetCusOrdFeaSrvFactory implements DetCusOrdFeaSrvFactoryIF {

	public DetCusOrdFeaSrvIF getApplicationService1() {
		return new DetCusOrdFeaSrv();
	}

}
