package com.tmmas.cl.scl.gestiondedirecciones.businessobject.bo;

import org.apache.log4j.Logger;

import com.tmmas.cl.framework.exception.GeneralException;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dao.ProspectoDAO;
import com.tmmas.cl.scl.gestiondedirecciones.businessobject.dto.ProspectoDTO;


public class ProspectoBO {
	private ProspectoDAO prospectoDAO  = new ProspectoDAO();
	private final Logger logger = Logger.getLogger(ProspectoBO.class);


	/**
	 * Obtiene prospecto del Cliente
	 * @param prospecto
	 * @return resultado
	 * @throws CustomerDomainException
	 */
	public ProspectoDTO getProspectoCliente(ProspectoDTO prospecto) 
	throws GeneralException {
		
		logger.debug("Inicio:getProspectoCliente");
		ProspectoDTO resultado = prospectoDAO.getProspectoCliente(prospecto);
		logger.debug("Fin:getProspectoCliente");
		return resultado;
	}//fin getProspectoCliente
	
	/**
	 * Obtiene prospecto de la direccion
	 * @param prospectoDTO
	 * @return prospectoDTO
	 * @throws GeneralException
	 */
	public ProspectoDTO getProspectoDireccion(ProspectoDTO prospectoDTO) 
	throws GeneralException {
		logger.debug("Inicio:getProspectoDireccion");
		prospectoDAO.getProspectoDireccion(prospectoDTO);
		logger.debug("Fin:getProspectoDireccion");
		return prospectoDTO;
	}//fin getProspectoDireccion

}//fin class Prospecto
