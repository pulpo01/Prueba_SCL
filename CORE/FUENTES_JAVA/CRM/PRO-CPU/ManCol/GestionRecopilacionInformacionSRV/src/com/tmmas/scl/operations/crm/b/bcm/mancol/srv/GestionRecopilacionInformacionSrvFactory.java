package com.tmmas.scl.operations.crm.b.bcm.mancol.srv;

import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces.GestionRecopilacionInformacionSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.mancol.srv.interfaces.GestionRecopilacionInformacionSrvIF;

public class GestionRecopilacionInformacionSrvFactory implements
		GestionRecopilacionInformacionSrvFactoryIF {

	public GestionRecopilacionInformacionSrvIF getApplicationService1(){
		return new GestionRecopilacionInformacionSrv();
	}

}
