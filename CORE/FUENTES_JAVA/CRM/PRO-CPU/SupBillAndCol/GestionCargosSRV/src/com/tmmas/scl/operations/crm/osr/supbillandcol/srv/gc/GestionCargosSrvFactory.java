package com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc;

import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces.GestionCargosSrvFactoryIF;
import com.tmmas.scl.operations.crm.osr.supbillandcol.srv.gc.interfaces.GestionCargosSrvIF;

public class GestionCargosSrvFactory implements GestionCargosSrvFactoryIF
{

	public GestionCargosSrvIF getApplicationService1() 
	{		
		return new GestionCargosSrv();
	}
	
}
