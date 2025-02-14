package com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv;

import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces.GestionProductoSrvFactoryIF;
import com.tmmas.scl.operations.crm.o.csr.manprooffinv.srv.interfaces.GestionProductoSrvIF;

public class GestionProductoSrvFactory implements GestionProductoSrvFactoryIF {

	public GestionProductoSrvIF getApplicationService1() 
	{
		return new GestionProductoSrv();
	}

}
