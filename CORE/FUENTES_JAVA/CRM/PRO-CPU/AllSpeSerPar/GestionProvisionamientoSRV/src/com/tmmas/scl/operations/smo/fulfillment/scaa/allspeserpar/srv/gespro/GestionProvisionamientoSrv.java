package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionServicioClienteBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioClienteBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioClienteIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.helper.Global;
import com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces.GestionProvisionamientoSrvIT;

public class GestionProvisionamientoSrv implements GestionProvisionamientoSrvIT 
{
	private final Logger logger = Logger.getLogger(GestionProvisionamientoSrv.class);	
	private Global global = Global.getInstance();
	
	private EspecificacionServicioClienteBOFactoryIT boFactory=new EspecificacionServicioClienteBOFactory();
	private EspecificacionServicioClienteIT serviceBO=boFactory.getBusinessObject();


	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws ProductException 
	{		
		EspecProvisionamientoListDTO retorno = null;
		try {
			String log = global.getValor("service.log");;
			PropertyConfigurator.configure(log);		
			logger.debug("obtenerEspecificacionesProvisionamiento():start");
			 retorno = serviceBO.obtenerEspecificacionesProvisionamiento(espSerCliList);		
			logger.debug("obtenerEspecificacionesProvisionamiento():end");
		} catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductException(e);
		}
		return retorno;	
	}

}
