package com.tmmas.scl.framework.customerDomain.businessObject.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.customerDomain.businessObject.bo.interfaces.OrdenServicioIT;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.OrdenServicioDAO;
import com.tmmas.scl.framework.customerDomain.businessObject.dao.interfaces.OrdenServicioDAOIT;
import com.tmmas.scl.framework.customerDomain.businessObject.helper.Global;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.ParametroDTO;
import com.tmmas.scl.framework.customerDomain.dataTransferObject.SecuenciaDTO;
import com.tmmas.scl.framework.customerDomain.exception.CustomerOrderException;

public class OrdenServicio implements OrdenServicioIT {

	private OrdenServicioDAOIT osDAO = new OrdenServicioDAO();
	
	private final Logger logger = Logger.getLogger(OrdenServicio.class);
	private Global global = Global.getInstance();
	
	public ParametroDTO obtenerParametroGeneral(ParametroDTO param) throws CustomerOrderException{
		ParametroDTO respuesta = null;
		try {
			logger.debug("obtenerParametroGeneral():start");
			respuesta = osDAO.obtenerParametroGeneral(param);
			logger.debug("obtenerParametroGeneral():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;	
	}
	
	public SecuenciaDTO obtenerSecuencia(SecuenciaDTO secuencia) throws CustomerOrderException{
		SecuenciaDTO respuesta = null;
		try {
			logger.debug("obtenerSecuencia():start");
			respuesta = osDAO.obtenerSecuencia(secuencia);
			logger.debug("obtenerSecuencia():end");
		} catch (CustomerOrderException e) {
			logger.debug("CustomerOrderException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new CustomerOrderException(e);
		}		
		return respuesta;			
	}
}
