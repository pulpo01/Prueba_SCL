package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondeclientescommon.commonapp.dto.EstadoDTO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.PuebloDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.PuebloDTO;

public class PuebloBO {
	
	private PuebloDAO pueblodao  = new PuebloDAO();
	private final Logger logger = Logger.getLogger(ProvinciaBO.class);
	
	/**
	 * Obtiene listado de Provincias. No se define código y descripción 
	 * como atributos debido a que el BO procesa y retorna un listado
	 * de Provincias 
	 * 
	 * @param 
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	
	public PuebloDTO[] getListadoPueblos(EstadoDTO estado) throws GeneralException {
		logger.debug("getListadoPueblos():start");
		PuebloDTO[] resultado = pueblodao.getListadoPueblos(estado);
		logger.debug("getListadoPueblos():end");
		return resultado;
	}
}
