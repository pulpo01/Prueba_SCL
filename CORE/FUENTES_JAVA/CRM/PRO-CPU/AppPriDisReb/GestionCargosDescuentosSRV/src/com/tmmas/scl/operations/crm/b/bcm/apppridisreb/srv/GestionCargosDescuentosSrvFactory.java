package com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv;

import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces.GestionCargosDescuentosSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.apppridisreb.srv.interfaces.GestionCargosDescuentosSrvIF;

public class GestionCargosDescuentosSrvFactory implements GestionCargosDescuentosSrvFactoryIF{
	
	public GestionCargosDescuentosSrvIF getApplicationService1(){
		return new GestionCargosDescuentosSRV();
	}

}
