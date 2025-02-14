package com.tmmas.scl.operations.crm.delegate;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.util.StackTraceUtl;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.OrdenServicioDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ProductoContratadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.isscusord.common.exception.IssCusOrdException;


public class IssCusOrdDelegate 
{
	private final Logger logger = Logger.getLogger(IssCusOrdDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	
	public IssCusOrdDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}

	/**
	 * obtener Productos Contratados
	 * 
	 * @param OrdenServicio
	 * @return ProductoContratadoListDTO
	 * @throws IssCusOrdException
	 */ 
	public ProductoContratadoListDTO obtenerProductoContratado(OrdenServicioDTO ordenServicio) throws IssCusOrdException{
		ProductoContratadoListDTO retorno = null;
		logger.debug("obtenerProductoContratado():start");
		try {
			logger.debug("getIssCusOrdFacade().obtenerProductoContratado():antes");
			retorno=this.facadeMaker.getIssCusOrdFacade().obtenerProductoContratado(ordenServicio);
			logger.debug("getIssCusOrdFacade().obtenerProductoContratado():despues");
			//retorno = getIssCusOrdFacade().obtenerProductoContratado(ordenServicio);//obtenerProductosContratadosVenta(venta);
		}
		catch(IssCusOrdException e){
			throw e;
		}
		catch(Exception e){
			String loge = StackTraceUtl.getStackTrace(e);
			logger.debug("Exception en WS [" + loge + "]");
			logger.debug("Exception en WS obtenerProductoContratado : "+e);
			throw new IssCusOrdException(e);
		}
		logger.debug("obtenerProductoContratado():end");
		return retorno;		
	}
	
}
