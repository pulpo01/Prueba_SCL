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
 * 13/07/2007     			 Cristian Toledo              		Versión Inicial
 */
package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.dataTransferObject.RetornoDTO;
import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.SCLPlanDescuentoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.SCLPlanDescuentoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.SCLPlanDescuentoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.productOfferingABE.dataTransferObject.RegistroSolicitudDTO;
import com.tmmas.scl.framework.productDomain.productOfferingABE.exception.ProductOfferingPriceException;

public class SCLPlanDescuento implements SCLPlanDescuentoIT {
	private SCLPlanDescuentoDAOIT descuentoDAO = new SCLPlanDescuentoDAO();
	
	private final Logger logger = Logger.getLogger(SCLPlanDescuento.class);
	private Global global = Global.getInstance();
	
	public RetornoDTO crearSolicitud(RegistroSolicitudDTO registro)
			throws ProductOfferingPriceException {
		RetornoDTO retorno = null;
		try {
			logger.debug("crearSolicitud():start");
			retorno = descuentoDAO.crearSolicitud(registro);
			logger.debug("crearSolicitud():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	
	}

	public RegistroSolicitudDTO consultarEstadoSolicitud(RegistroSolicitudDTO registro) throws ProductOfferingPriceException{
		RegistroSolicitudDTO retorno = null;
		try {
			logger.debug("consultarEstadoSolicitud():start");
			retorno = descuentoDAO.consultarEstadoSolicitud(registro);
			logger.debug("consultarEstadoSolicitud():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	
	}

	public RetornoDTO eliminarSolicitudDescuento(RegistroSolicitudDTO registro) throws ProductOfferingPriceException{
		RetornoDTO retorno = null;
		try {
			logger.debug("eliminarSolicitudDescuento():start");
			retorno = descuentoDAO.eliminarSolicitudDescuento(registro);
			logger.debug("eliminarSolicitudDescuento():end");
		} catch (ProductOfferingPriceException e) {
			logger.debug("ProductOfferingPriceException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductOfferingPriceException(e);
		}		
		return retorno;	
	}
}
