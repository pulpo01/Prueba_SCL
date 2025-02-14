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
 * 03-07-2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.serviceDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.marketSalesDomain.dataTransferObject.VentaDTO;
import com.tmmas.scl.framework.serviceDomain.businessObject.bo.interfaces.PerfilProvisionamientoIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.PerfilProvisionamientoDAO;
import com.tmmas.scl.framework.serviceDomain.businessObject.dao.interfaces.PerfilProvisionamientoDAOIT;
import com.tmmas.scl.framework.serviceDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.serviceDomain.dataTransferObject.PerfilProvisionamientoListDTO;
import com.tmmas.scl.framework.serviceDomain.exception.ServiceException;

public class PerfilProvisionamiento implements PerfilProvisionamientoIT
{
	private PerfilProvisionamientoDAOIT perfilProvDAO = new PerfilProvisionamientoDAO(); 
	private final Logger logger = Logger.getLogger(ListaNumeros.class);
	private Global global = Global.getInstance();
	
	
	public RetornoDTO informar(PerfilProvisionamientoListDTO perfilProvListDTO) throws ServiceException {		
		RetornoDTO retorno = null;
		try {
			logger.debug("informar():start");			
			for(int i=0;i<perfilProvListDTO.getPerfilesProvisionamientos().length;i++)
			{
				retorno = perfilProvDAO.informar(perfilProvListDTO.getPerfilesProvisionamientos()[i]);
			}			
			logger.debug("informar():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO obtenerEstado(VentaDTO ventaDTO) throws ServiceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("obtenerEstado():start");
			retorno = perfilProvDAO.obtenerEstado(ventaDTO);
			logger.debug("obtenerEstado():end");
		} catch (ServiceException e) {
			logger.debug("ServiceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ServiceException(e);
		}		
		return retorno;	
	}

}
