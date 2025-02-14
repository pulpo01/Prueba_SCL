package com.tmmas.cl.scl.frameworkcargos.srv.gcd;

import com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces.GestionCargosDescuentosSrvFactoryIF;
import com.tmmas.cl.scl.frameworkcargos.srv.gcd.interfaces.GestionCargosDescuentosSrvIF;

public class GestionCargosDescuentosSrvFactory implements GestionCargosDescuentosSrvFactoryIF{
	
	public GestionCargosDescuentosSrvIF getApplicationService1(){
		return new GestionCargosDescuentosSRV();
	}

}
