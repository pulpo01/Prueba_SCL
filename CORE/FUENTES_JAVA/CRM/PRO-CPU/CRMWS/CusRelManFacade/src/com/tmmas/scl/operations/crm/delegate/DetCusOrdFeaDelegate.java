package com.tmmas.scl.operations.crm.delegate;

import java.rmi.RemoteException;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.customerDomain.customerOrderABE.dataTransferObject.RestriccionesDTO;
import com.tmmas.scl.framework.productDomain.productABE.dataTransferObject.ParametroSerializableDTO;
import com.tmmas.scl.operations.crm.delegate.helper.FacadeMaker;
import com.tmmas.scl.operations.crm.delegate.helper.Global;
import com.tmmas.scl.operations.crm.f.oh.detcusordfea.common.exception.DetCusOrdFeaException;

public class DetCusOrdFeaDelegate {
	private final Logger logger = Logger.getLogger(DetCusOrdFeaDelegate.class);	
	private Global global=Global.getInstance(); 
	private FacadeMaker facadeMaker=FacadeMaker.getInstance();
	private ParametroSerializableDTO process;
	
	public DetCusOrdFeaDelegate()
	{
		String log = global.getValor("delegate.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);		
	}	
	
	public RetornoDTO validaRestriccionComerOoss(RestriccionesDTO restricciones) throws DetCusOrdFeaException, RemoteException
	{
		try{
			//return this.facadeMaker.getIssSerOrdFacade().anulacionVenta(venta);
			logger.debug("validaRestriccionComerOoss():start");
			logger.debug("getDetCusOrdFeaFacade().validarContratanteBeneficiario():antes");
			RetornoDTO retValue =this.facadeMaker.getDetCusOrdFeaFacade().validaRestriccionComerOoss(restricciones);
			logger.debug("getDetCusOrdFeaFacade().validarContratanteBeneficiario():despues");
			logger.debug("validaRestriccionComerOoss():end");
			return retValue;
		}catch(DetCusOrdFeaException e){
			throw e;
		}
		catch(Exception e){
			throw new DetCusOrdFeaException(e);
		}
		
	}
}
