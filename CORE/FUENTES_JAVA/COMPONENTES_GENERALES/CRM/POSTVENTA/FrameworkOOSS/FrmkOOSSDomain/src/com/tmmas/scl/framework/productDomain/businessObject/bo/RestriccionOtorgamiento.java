package com.tmmas.scl.framework.productDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.productDomain.businessObject.bo.interfaces.RestriccionOtorgamientoIT;
import com.tmmas.scl.framework.productDomain.businessObject.dao.RestriccionOtorgamientoDAO;
import com.tmmas.scl.framework.productDomain.businessObject.dao.interfaces.RestriccionOtorgamientoDAOIT;
import com.tmmas.scl.framework.productDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.productDomain.dataTransferObject.ProductoOfertadoDTO;
import com.tmmas.scl.framework.productDomain.dataTransferObject.RestriccionesContratacionDTO;
import com.tmmas.scl.framework.productDomain.exception.ProductSpecificationException;

public class RestriccionOtorgamiento implements RestriccionOtorgamientoIT {
	
	private RestriccionOtorgamientoDAOIT restriccionDAO = new RestriccionOtorgamientoDAO();
	
	private final Logger logger = Logger.getLogger(RestriccionesValidaciones.class);
	private Global global = Global.getInstance();
	
	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(RestriccionesContratacionDTO restriccion)
			throws ProductSpecificationException {
		RestriccionesContratacionDTO restricciones = null;
		try {
			logger.debug("validaServicioActDesc():start");
			restricciones = restriccionDAO.obtenerRestriccionesContratacion(restriccion);
			logger.debug("validaServicioActDesc():end");
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return restricciones;
	}

	public RestriccionesContratacionDTO obtenerRestriccionesContratacion(ProductoOfertadoDTO producto) throws ProductSpecificationException {
		RestriccionesContratacionDTO restricciones = null;
		try {
			logger.debug("validaServicioActDesc():start");
			restricciones = restriccionDAO.obtenerRestriccionesContratacion(producto);
			logger.debug("validaServicioActDesc():end");
		} catch (ProductSpecificationException e) {
			logger.debug("ProductSpecificationException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new ProductSpecificationException(e);
		}		
		return restricciones;
	}

}
