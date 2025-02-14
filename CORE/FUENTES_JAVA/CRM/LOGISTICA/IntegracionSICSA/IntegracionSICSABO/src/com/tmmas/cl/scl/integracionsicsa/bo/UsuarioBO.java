package com.tmmas.cl.scl.integracionsicsa.bo;

import com.tmmas.cl.scl.integracionsicsa.common.dto.UsuarioDTO;
import com.tmmas.cl.scl.integracionsicsa.common.exception.IntegracionSICSAException;
import com.tmmas.cl.scl.integracionsicsa.dao.UsuarioDAO;

public class UsuarioBO extends IntegracionSICSABO {

	private UsuarioDAO usuarioDAO = new UsuarioDAO();

	/*
	 * -------------------------------------------------------------------------
	 * INICIO BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */
	
	/**
	 * Metodo que consulta los datos de un usuario
	 * 
	 * @author Hugo Olivares
	 * @throws IntegracionSICSAException
	 */
	public UsuarioDTO getDatosUsuario(String codUsuario)
			throws IntegracionSICSAException {
		UsuarioDTO outDTO;
		loggerDebug("getDatosUsuario: inicio");
		outDTO = usuarioDAO.getDatosUsuario(codUsuario);
		loggerDebug("getDatosUsuario: fin");
		return outDTO;
	}

	/*
	 * -------------------------------------------------------------------------
	 * FIN BLOQUE METODOS HOM
	 * -------------------------------------------------------------------------
	 */

}
