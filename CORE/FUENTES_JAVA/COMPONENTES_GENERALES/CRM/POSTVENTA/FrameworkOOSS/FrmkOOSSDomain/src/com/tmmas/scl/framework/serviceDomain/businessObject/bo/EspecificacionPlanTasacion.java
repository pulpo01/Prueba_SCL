/**
 * Copyright © 2006 Telef&oacute;nica M&oacute;viles Soluciones y Aplicaciones, SA.
 * Av. Del Condor 720, Huechuraba, Santiago de Chile, Chile
 * Todos los derechos reservados.
 *
 * Este software es informaci&oacute;n propietaria y confidencial de TM-mAs SA.
 * Usted no debe develar tal información y s&oactute;lo debe usarla en concordancia
 * con los t&eacute;rminos de derechos de licencias que sean adquiridos con TM-mAs.
 *
 * Fecha ------------------- Autor  ------------------------- Cambios ----------
 * 11-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionPlanTasacionIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.EspecificacionPlanTasacionDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionPlanTasacionDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecPlanTasacionListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionPlanTasacion implements EspecificacionPlanTasacionIT
{
	private final Logger logger = Logger.getLogger(EspecificacionPlanTasacion.class);
	private Global global = Global.getInstance();
	
	private EspecificacionPlanTasacionDAOIT espPlanTasDAO=new EspecificacionPlanTasacionDAO();
	
	public EspecPlanTasacionListDTO obtenerEspecPlanTasacion(EspecServicioClienteListDTO espServCltList) throws ServiceSpecEntitiesException 
	{
		EspecPlanTasacionListDTO retorno = null;
		try {
			logger.debug("obtenerEspecPlanTasacion():start");
			retorno = espPlanTasDAO.obtenerEspecPlanTasacion(espServCltList);
			logger.debug("obtenerEspecPlanTasacion():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return retorno;	
	}

	public EspecPlanTasacionListDTO obtenerPlanesTasacion() throws ServiceSpecEntitiesException {
		EspecPlanTasacionListDTO retorno = null;
		try {
			logger.debug("obtenerEspecPlanTasacion():start");
			retorno = espPlanTasDAO.obtenerPlanesTasacion();
			logger.debug("obtenerEspecPlanTasacion():end");
		} catch (ServiceSpecEntitiesException e) {
			logger.debug("ServiceSpecEntitiesException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceSpecEntitiesException(e);
		}		
		return retorno;	
	}
	
}
