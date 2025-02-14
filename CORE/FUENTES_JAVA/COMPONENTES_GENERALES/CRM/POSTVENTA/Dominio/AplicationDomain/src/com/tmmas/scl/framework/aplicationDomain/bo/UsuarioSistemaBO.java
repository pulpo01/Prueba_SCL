package com.tmmas.scl.framework.aplicationDomain.bo;

import org.apache.log4j.Logger;

import com.tmmas.scl.framework.aplicationDomain.bo.interfeces.UsuarioSistemaBOIT;
import com.tmmas.scl.framework.aplicationDomain.dao.UsuarioSistemaDAO;
import com.tmmas.scl.framework.aplicationDomain.dao.interfaces.UsuarioSistemaDAOIT;
import com.tmmas.scl.framework.aplicationDomain.dto.UsuarioSistemaDTO;
import com.tmmas.scl.framework.aplicationDomain.exception.AplicationException;

public class UsuarioSistemaBO implements UsuarioSistemaBOIT{



	private UsuarioSistemaDAOIT UsuarioSistemaDAO = new UsuarioSistemaDAO();
	private final Logger logger = Logger.getLogger(UsuarioSistemaBO.class);

	public UsuarioSistemaDTO obtenerInformacionUsuario(UsuarioSistemaDTO UsuarioSistema) throws AplicationException {

		UsuarioSistemaDTO respuesta = null;
		try {
			logger.debug("obtenerTiposDeContrato():start");
			respuesta = UsuarioSistemaDAO.obtenerInformacionUsuario(UsuarioSistema);
			logger.debug("obtenerTiposDeContrato():end");
		} catch (AplicationException e) {
			logger.debug("ProductException[", e);
			throw e;
		}
		catch (Exception e) {
			logger.debug("Exception[", e);
			throw new AplicationException(e);
		}		
		return respuesta;			

	}
}
