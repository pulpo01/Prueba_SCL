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
 * 04-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.EspecificacionServicioAltamiraIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.EspecificacionServicioAltamiraDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.EspecificacionServicioAltamiraDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.EspecServicioClienteListDTO;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.FreqAltamiraListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceSpecEntitiesException;

public class EspecificacionServicioAltamira implements EspecificacionServicioAltamiraIT
{
	private EspecificacionServicioAltamiraDAOIT servAltamiraDAO = new EspecificacionServicioAltamiraDAO();
	
	private final Logger logger = Logger.getLogger(EspecificacionServicioAltamiraDAOIT.class);
	private Global global = Global.getInstance();

	public RetornoDTO crear(FreqAltamiraListDTO listFrecAlt) throws ServiceSpecEntitiesException {
		RetornoDTO retorno = null;
		try {

			logger.debug("crear():start");
			retorno = servAltamiraDAO.crear(listFrecAlt);
			logger.debug("crear():end");
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

	public RetornoDTO notificar(VentaDTO venta) throws ServiceSpecEntitiesException {
		RetornoDTO retorno = null;
		try {
			logger.debug("notificar():start");
			retorno = servAltamiraDAO.notificar(venta);
			logger.debug("notificar():end");
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

	public EspecServicioAltamiraListDTO obtenerEspecServicioAltamira(EspecServicioClienteListDTO espSerCliList) throws ServiceSpecEntitiesException {
		EspecServicioAltamiraListDTO retorno = null;
		try {
			logger.debug("obtenerEspecServicioAltamira():start");
			retorno = servAltamiraDAO.obtenerEspecServicioAltamira(espSerCliList);
			logger.debug("obtenerEspecServicioAltamira():end");
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
