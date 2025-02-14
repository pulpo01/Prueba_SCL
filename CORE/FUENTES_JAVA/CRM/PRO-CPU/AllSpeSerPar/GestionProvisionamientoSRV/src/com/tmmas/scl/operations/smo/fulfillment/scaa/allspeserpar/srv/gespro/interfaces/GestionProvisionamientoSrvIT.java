package com.tmmas.scl.operations.smo.fulfillment.scaa.allspeserpar.srv.gespro.interfaces;

import com.tmmas.scl.framework.productDomain.productABE.exception.ProductException;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.EspecServicioClienteListDTO;

public interface GestionProvisionamientoSrvIT 
{
	public EspecProvisionamientoListDTO obtenerEspecificacionesProvisionamiento(EspecServicioClienteListDTO espSerCliList) throws ProductException;
}
