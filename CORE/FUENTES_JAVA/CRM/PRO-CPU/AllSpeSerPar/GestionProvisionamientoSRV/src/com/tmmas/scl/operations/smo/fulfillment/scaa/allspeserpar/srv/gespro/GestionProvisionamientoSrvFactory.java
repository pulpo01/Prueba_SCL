package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro;

import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces.GestionProvisionamientoSrvFactoryIT;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces.GestionProvisionamientoSrvIT;

public class GestionProvisionamientoSrvFactory implements GestionProvisionamientoSrvFactoryIT
{

	public GestionProvisionamientoSrvIT getAplicationService1() 
	{		
		return new GestionProvisionamientoSrv();
	}
	
}
