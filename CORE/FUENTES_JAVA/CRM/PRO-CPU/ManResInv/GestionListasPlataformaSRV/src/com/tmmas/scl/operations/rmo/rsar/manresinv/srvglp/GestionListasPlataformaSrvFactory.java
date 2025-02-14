package com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp;

import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces.GestionListasPlataformaSrvFactoryIF;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces.GestionListasPlataformaSrvIF;

public class GestionListasPlataformaSrvFactory implements GestionListasPlataformaSrvFactoryIF 
{

	public GestionListasPlataformaSrvIF getApplicationService1() {		
		return new GestionListasPlataformaSrv();
	}

}
