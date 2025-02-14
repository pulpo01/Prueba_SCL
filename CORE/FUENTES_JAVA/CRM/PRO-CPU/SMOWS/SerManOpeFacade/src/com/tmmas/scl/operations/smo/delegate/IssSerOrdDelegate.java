package com.tmmas.scl.operations.smo.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.operations.smo.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.smo.delegate.helper.Global;
import com.tmmas.scl.operations.smo.fulfillment.scaa.issserord.common.exception.IssSerOrdException;

public class IssSerOrdDelegate 
{
	private final Logger logger = Logger.getLogger(IssSerOrdDelegate.class);	
	private Global global=Global.getInstance(); 
	
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public IssSerOrdDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	
	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws IssSerOrdException, RemoteException
	{
		return facadeMaker.getIssSerOrdFacade().obtenerPlanesTasacion();
	}
}
