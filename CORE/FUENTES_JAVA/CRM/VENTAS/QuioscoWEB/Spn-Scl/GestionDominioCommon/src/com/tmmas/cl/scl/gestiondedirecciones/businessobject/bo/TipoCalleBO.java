package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.TipoCalleDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.TipoCalleDireccionDTO;

public class TipoCalleBO {

	TipoCalleDAO tipoCalleDAO = new TipoCalleDAO();  
	private final Logger logger = Logger.getLogger(RegionBO.class);
	
	/**
	 * Obtiene listado de tipos de calles. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de tipos de calles
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public TipoCalleDireccionDTO getListadoTiposCalles() throws GeneralException {
		logger.debug("getListadoTiposCalles():start");
		TipoCalleDireccionDTO resultado = tipoCalleDAO.getListadoTiposCalles();
		logger.debug("getListadoTiposCalles():end");
		return resultado;
	}
}
