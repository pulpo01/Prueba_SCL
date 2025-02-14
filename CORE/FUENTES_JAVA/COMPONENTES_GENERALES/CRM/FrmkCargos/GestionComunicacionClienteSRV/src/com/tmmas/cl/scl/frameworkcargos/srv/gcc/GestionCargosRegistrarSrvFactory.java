package com.tmmas.cl.scl.frameworkcargos.srv.gcc;

import com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces.GestionCargosRegistrarSrvFactoryIF;
import com.tmmas.cl.scl.frameworkcargos.srv.gcc.interfaces.GestionCargosRegistrarSrvIF;

 

public class GestionCargosRegistrarSrvFactory implements GestionCargosRegistrarSrvFactoryIF{
	
	public GestionCargosRegistrarSrvIF getApplicationService1(){
		return new GestionCargosRegistrarSrv();
	}

}
