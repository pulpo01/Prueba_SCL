package com.tmmas.cl.scl.socketps.bo;

import com.tmmas.cl.scl.socketps.bo.interfaces.ConsultaBOFactoryIT;
import com.tmmas.cl.scl.socketps.bo.interfaces.ConsultaIT;

public class ConsultaBOFactory implements ConsultaBOFactoryIT {

	public ConsultaIT getBOFactoryConsulta() {
		// TODO Auto-generated method stub
		return new Consulta();
	}

}
