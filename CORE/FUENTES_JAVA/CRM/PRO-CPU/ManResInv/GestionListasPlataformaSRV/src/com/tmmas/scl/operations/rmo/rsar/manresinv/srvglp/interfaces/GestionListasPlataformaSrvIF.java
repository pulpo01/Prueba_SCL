package com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces;

import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.operations.rmo.rsar.manresinv.common.exception.ManResInvException;


public interface GestionListasPlataformaSrvIF 
{
	public RetornoDTO crearFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException;
	public RetornoDTO eliminarFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException;	
}
