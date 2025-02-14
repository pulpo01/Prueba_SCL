package com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo;

import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces.GestionAbonadoSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srvabo.interfaces.GestionAbonadoSrvIF;

public class GestionAbonadoSrvFactory implements GestionAbonadoSrvFactoryIF {

	public GestionAbonadoSrvIF getApplicationService1() {
		return new GestionAbonadoSrv();
	}

}
