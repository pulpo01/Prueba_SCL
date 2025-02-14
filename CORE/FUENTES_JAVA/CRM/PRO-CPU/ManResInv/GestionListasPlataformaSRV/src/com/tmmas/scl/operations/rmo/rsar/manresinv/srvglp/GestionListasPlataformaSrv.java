package com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp;

import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.scl.framework.customerDomain.customerABE.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.EspecificacionServicioAltamiraBOFactory;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioAltamiraBOFactoryIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.bo.interfaces.EspecificacionServicioAltamiraIT;
import com.tmmas.scl.framework.serviceDomain.serviceSpecEntitiesABE.businessObject.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.operations.rmo.rsar.manresinv.common.exception.ManResInvException;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.helper.Global;
import com.tmmas.scl.operations.rmo.rsar.manresinv.srvglp.interfaces.GestionListasPlataformaSrvIF;

public class GestionListasPlataformaSrv implements GestionListasPlataformaSrvIF
{
	private final Logger logger = Logger.getLogger(GestionListasPlataformaSrv.class);	
	
	private EspecificacionServicioAltamiraBOFactoryIT factoryBO1 = new EspecificacionServicioAltamiraBOFactory();	
	private EspecificacionServicioAltamiraIT espSerAltamiraBO = factoryBO1.getBusinessObject1();
	private Global global = Global.getInstance();
	
	public GestionListasPlataformaSrv(){
		String log = global.getValor("service.log");
		log = global.getPathInstancia() + log;
		PropertyConfigurator.configure(log);
	}

	public RetornoDTO crearFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException {
		RetornoDTO retorno = null;
		try {
					
			logger.debug("crearFrecuentesAltamira():start");
			retorno = espSerAltamiraBO.crear(frecAltDTO);
			logger.debug("crearFrecuentesAltamira():end");
		} catch (GeneralException e) {
			logger.debug("GeneralException[", e);
			throw new ManResInvException(e);
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManResInvException(e);
		}
		return retorno;	
	}

	public RetornoDTO eliminarFrecuentesAltamira(FreqAltamiraListDTO frecAltDTO) throws ManResInvException {
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminarFrecuentesAltamira():start");
			//retorno = espSerAltamiraBO.  PENDIENTE HASTA QUE EXISTA EL METODO EN EL BO
			logger.debug("eliminarFrecuentesAltamira():end");
		}// catch (GeneralException e) {
			//logger.debug("GeneralException[", e);
			//throw e;
		//}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ManResInvException(e);
		}
		return retorno;	
	}

}
