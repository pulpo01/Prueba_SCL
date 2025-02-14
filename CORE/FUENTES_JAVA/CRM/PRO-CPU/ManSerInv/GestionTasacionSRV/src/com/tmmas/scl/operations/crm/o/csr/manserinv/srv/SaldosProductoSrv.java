package com.tmmas.scl.operations.crm.o.csr.manserinv.srv;


import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.ProductoTasacionContratadoBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ProductoTasacionContratadoBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.bo.interfaces.ProductoTasacionContratadoIT;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoCliente;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.SaldoProductoTasacionListDTO;
import com.tmmas.scl.operations.crm.o.csr.manserinv.common.exception.ManSerInvException;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.manserinv.srv.interfaces.SaldosProductoSrvIF;


public class SaldosProductoSrv implements SaldosProductoSrvIF {

	private ProductoTasacionContratadoBOFactoryIT prodTasContFactory=new ProductoTasacionContratadoBOFactory();
	private ProductoTasacionContratadoIT prodTasConBO=prodTasContFactory.getBusinessObject1(); 
	private final Logger logger = Logger.getLogger(SaldosProductoSrv.class);	
	private Global global=Global.getInstance(); 
	
	
	public SaldosProductoSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);	
	}
	
	public SaldoProductoTasacionListDTO obtenerSaldosProducto(SaldoProductoCliente productoCliente) throws ManSerInvException 
	{
		SaldoProductoTasacionListDTO retorno=null;
		logger.debug("dentro de obtenerSaldosProducto");
				
		try {
			retorno= prodTasConBO.saldos(productoCliente);
			logger.debug("obtenerSaldosProducto retorno sin problemas ");
		}
		catch (Exception e) 
		{			
			logger.error(e);
			throw new ManSerInvException(e);
		}
		return retorno;
	}

}
