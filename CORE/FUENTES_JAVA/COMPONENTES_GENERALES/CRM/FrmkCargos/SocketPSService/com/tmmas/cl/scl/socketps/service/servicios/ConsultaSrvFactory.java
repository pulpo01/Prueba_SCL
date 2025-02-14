package com.tmmas.cl.scl.socketps.service.servicios;

import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvFactoryIT;
import com.tmmas.cl.scl.socketps.service.servicios.interfaces.ConsultaSrvIT;

public class ConsultaSrvFactory implements ConsultaSrvFactoryIT {

	public ConsultaSrvIT getApplicationServiceConsulta() {
		// TODO Auto-generated method stub
		return new ConsultaSrv();
	}

}
