package com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv;

import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces.GestionCargosRegistrarSrvFactoryIF;
import com.tmmas.scl.operations.crm.b.bcm.mancusbil.srv.interfaces.GestionCargosRegistrarSrvIF;

 

public class GestionCargosRegistrarSrvFactory implements GestionCargosRegistrarSrvFactoryIF{
	
	public GestionCargosRegistrarSrvIF getApplicationService1(){
		return new GestionCargosRegistrarSrv();
	}

}
