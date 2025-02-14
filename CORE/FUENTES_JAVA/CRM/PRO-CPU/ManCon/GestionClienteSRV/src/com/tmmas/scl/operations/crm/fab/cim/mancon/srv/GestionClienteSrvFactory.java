package com.tmmas.scl.operations.crm.fab.cim.mancon.srv;

import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces.GestionClienteSrvFactoryIF;
import com.tmmas.scl.operations.crm.fab.cim.mancon.srv.interfaces.GestionClienteSrvIF;

public class GestionClienteSrvFactory implements GestionClienteSrvFactoryIF{

	/**
	 * Application Service Factory Class
	 */
	public GestionClienteSrvIF getApplicationService1() {
		return new GestionClienteSrv();
	}
}
