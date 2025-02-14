package com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser;

import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces.GestionActivacionServiciosSrvFactoryIF;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.srvser.interfaces.GestionActivacionServiciosSrvIF;

public class GestionActivacionServiciosSrvFactory implements GestionActivacionServiciosSrvFactoryIF 
{

	public GestionActivacionServiciosSrvIF getApplicationService1() {		
		return new GestionActivacionServiciosSrv();
	}
}
