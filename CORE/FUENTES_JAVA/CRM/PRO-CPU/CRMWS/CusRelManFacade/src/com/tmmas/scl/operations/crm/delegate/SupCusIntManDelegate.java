package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.ContratanteBeneficiarioDTO;
import com.tmmas.scl.framework.serviceDomain.serviceABE.businessObject.dataTransferObject.NumeroDTO;

import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.o.csr.supcusintman.common.exception.SupCusIntManException;

public class SupCusIntManDelegate {
	private final Logger logger = Logger.getLogger(SupOrdHanDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	private ParametroSerializableDTO process;
	
	public SupCusIntManDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}	
	
	public RetornoDTO validarContratanteBeneficiario(ContratanteBeneficiarioDTO contratanteBeneficiarioDTO) throws SupCusIntManException, RemoteException
	{		
		try{
			//return this.facadeMaker.getIssSerOrdFacade().anulacionVenta(venta);
			logger.debug("validarContratanteBeneficiario():start");
			logger.debug("getSupCusIntManFacade().validarContratanteBeneficiario():antes");
			RetornoDTO retValue =this.facadeMaker.getSupCusIntManFacade().validarContratanteBeneficiario(contratanteBeneficiarioDTO);
			logger.debug("getSupCusIntManFacade().validarContratanteBeneficiario():despues");
			logger.debug("validarContratanteBeneficiario():end");
			return retValue;
		}catch(SupCusIntManException e){
			throw e;
		}
		
	}
	
	public NumeroDTO obtenerTipoNumero(NumeroDTO numeroDTO) throws SupCusIntManException, RemoteException
	{		
		try{
			//return this.facadeMaker.getIssSerOrdFacade().anulacionVenta(venta);
			logger.debug("obtenerTipoNumero():start");
			logger.debug("getSupCusIntManFacade().obtenerTipoNumero():antes");
			numeroDTO =this.facadeMaker.getSupCusIntManFacade().obtenerTipoNumero(numeroDTO);
			logger.debug("getSupCusIntManFacade().obtenerTipoNumero():despues");
			logger.debug("obtenerTipoNumero():end");
			
		}catch(SupCusIntManException e){
			throw e;
		}
		return numeroDTO;
	}
}
