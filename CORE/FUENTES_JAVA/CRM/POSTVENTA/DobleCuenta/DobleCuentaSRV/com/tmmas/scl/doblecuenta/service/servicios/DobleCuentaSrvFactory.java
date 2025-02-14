package com.tmmas.scl.doblecuenta.service.servicios;

import com.tmmas.scl.doblecuenta.service.interfaz.DobleCuentaSrvFactoryIF;
import com.tmmas.scl.doblecuenta.service.interfaz.DobleCuentaSrvIF;

public class DobleCuentaSrvFactory implements DobleCuentaSrvFactoryIF{

	public DobleCuentaSrvIF getApplicationService1() {
		return new DobleCuentaSrv();
	}
}
