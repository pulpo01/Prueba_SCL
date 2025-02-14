package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionesValidacionesIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.RestriccionesValidacionesDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RestriccionesValidacionesDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RegistroServiciosListDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ValidaServiciosDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public class RestriccionesValidaciones implements RestriccionesValidacionesIT {
	
	private RestriccionesValidacionesDAOIT validaDAO = new RestriccionesValidacionesDAO();
	
	private final Logger logger = Logger.getLogger(RestriccionesValidaciones.class);
	private Global global = Global.getInstance();
	
	public RegistroServiciosListDTO validaServicioActDesc(ValidaServiciosDTO param)
			throws ProductSpecificationException {
		RegistroServiciosListDTO servicios = null;
		try {
			logger.debug("validaServicioActDesc():start");
			servicios = validaDAO.validaServicioActDesc(param);
			logger.debug("validaServicioActDesc():end");
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return servicios;
	}

}
