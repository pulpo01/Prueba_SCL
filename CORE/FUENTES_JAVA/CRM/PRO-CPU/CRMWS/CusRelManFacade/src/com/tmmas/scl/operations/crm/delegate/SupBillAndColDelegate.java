package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.CargoListDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ProductoOfertadoListDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.osr.supbillandcol.common.exception.SupBillAndColException;

public class SupBillAndColDelegate {
	private final Logger logger = Logger.getLogger(SupOrdHanDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	private ParametroSerializableDTO process;
	
	public SupBillAndColDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}	
	
	public CargoListDTO obtenerCargosProductos(ProductoOfertadoListDTO productoOfertadoListDTO) throws SupBillAndColException, RemoteException
	{		
		try{
			//return this.facadeMaker.getIssSerOrdFacade().anulacionVenta(venta);
			logger.debug("obtenerCargosProductos():start");
			logger.debug("getSupBillAndColFacade().obtenerCargosProductos():antes");
			CargoListDTO retValue =this.facadeMaker.getSupBillAndColFacade().obtenerCargosProductos(productoOfertadoListDTO);
			logger.debug("getSupBillAndColFacade().obtenerCargosProductos():despues");
			logger.debug("obtenerCargosProductos():end");
			return retValue;
		}catch(SupBillAndColException e){
			throw e;
		}
		
	}
}
