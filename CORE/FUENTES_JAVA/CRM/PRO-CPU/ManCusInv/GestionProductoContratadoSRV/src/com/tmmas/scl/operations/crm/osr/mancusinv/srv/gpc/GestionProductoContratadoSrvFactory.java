package com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc;

import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.interfaces.GestionProductoContratadoSrvFactoryIF;
import com.tmmas.scl.operations.crm.osr.mancusinv.srv.gpc.interfaces.GestionProductoContratadoSrvIF;

public class GestionProductoContratadoSrvFactory implements GestionProductoContratadoSrvFactoryIF{
	
	public GestionProductoContratadoSrvIF getApplicationService1() 
	{		
		return new GestionProductoContratadoSrv();
	}
	

}