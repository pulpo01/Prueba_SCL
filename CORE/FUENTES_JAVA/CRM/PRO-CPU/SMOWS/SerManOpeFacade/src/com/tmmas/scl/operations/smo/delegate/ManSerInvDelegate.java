package com.tmmas.scl.operations.smo.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;
import com.tmmas.scl.operations.smo.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.smo.delegate.helper.Global;

public class ManSerInvDelegate 
{
	private final Logger logger = Logger.getLogger(IssSerOrdDelegate.class);	
	private Global global=Global.getInstance(); 
	
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public ManSerInvDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}
	
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws ManSerInvException
	{
		SaldoProductoTasacionListDTO retorno=null;
		try {
			retorno=this.facadeMaker.getManSerInvFacade().obtenerSaldosProducto(productoCliente);
		}
		catch (Exception e) 
		{
			logger.error(e);			
			throw new ManSerInvException();
		}			
		return retorno;
	}

}
